Return-Path: <linux-kernel+bounces-562019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFBA61A97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0FF3BF2E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B75207A08;
	Fri, 14 Mar 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNK83rmU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D72066DB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980569; cv=none; b=R8yqYAeJ7eZRj/+AhcjgrdMkAYFF1QoCCscAKmsnNicqTB2x2RD/NLVP/Af86xjHg/3OTTmK4V7XW3vdi1Dh9VajBMzzmPs++xPxE+ffCd3D/YD3D1CqPrfNfM/sMh4VtNTqeK8WeyCsZvxr4BU1mM4xRmWvNXjrfTUUPT2vhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980569; c=relaxed/simple;
	bh=uxC5tVlc++V3xZ1VAv4k+jPVeflY2NBvsBYtkKGQnUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az80cyvwxGw+ChSi9bepYtbW1z2L/HwX1uUqVpCRkjt+tPX7KKm7vidSrHPmOa1XCEZZs0wu3o0uhrvWhquJwjpeyTQtHG8KH3Yx5pu/3kgO3Cxb+Jnzxh2/KkNr+EncLpgJNCjBSXibjl0bSJYuy/wGgX2NuNfJ8vP+58cIZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNK83rmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E204C116D0;
	Fri, 14 Mar 2025 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980569;
	bh=uxC5tVlc++V3xZ1VAv4k+jPVeflY2NBvsBYtkKGQnUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNK83rmUYgPUeFhMhhEwt0w1T+chZNlvMNTjtR7LiJ5r3DV20JgAvj+ZjhcwSrbF0
	 G/5xm4kcJGzjbr97XUwwpGuWS2VSyh+7j898et2maYmCaKlEPNw5usaA6RYN1gsvPy
	 n/XC6qAVs6VdxaxaQlgQ8KnC6ikYSLwv4uN3Cb+4nL3qSQ6dLdrU0pZz7LjPZUlkNh
	 pY9B9FRU1ziz1wA39gDGP0zF2C+iXYK+DR6th1hhD0NBnfyv8Q1GOeVVe3GbfAPZxo
	 zA7INOHDxF6Dsk9PPUlF3CVfasM8RY5jHC+x2Mh0qi7h+q5yd1lTPmycQaTUByzgUi
	 4ZNYyDH9WjU8A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 02/13] objtool: Fix error handling inconsistencies in check()
Date: Fri, 14 Mar 2025 12:29:00 -0700
Message-ID: <0f49d6a27a080b4012e84e6df1e23097f44cc082.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure all fatal errors are funneled through the 'out' label with a
negative ret.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3a3a1a905199..2b5249af7b0f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4586,8 +4586,10 @@ int check(struct objtool_file *file)
 	init_cfi_state(&force_undefined_cfi);
 	force_undefined_cfi.force_undefined = true;
 
-	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3)))
+	if (!cfi_hash_alloc(1UL << (file->elf->symbol_bits - 3))) {
+		ret = -1;
 		goto out;
+	}
 
 	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
@@ -4604,7 +4606,7 @@ int check(struct objtool_file *file)
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4640,7 +4642,7 @@ int check(struct objtool_file *file)
 		 */
 		ret = validate_unrets(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
@@ -4703,7 +4705,7 @@ int check(struct objtool_file *file)
 	if (opts.prefix) {
 		ret = add_prefix_symbols(file);
 		if (ret < 0)
-			return ret;
+			goto out;
 		warnings += ret;
 	}
 
-- 
2.48.1


