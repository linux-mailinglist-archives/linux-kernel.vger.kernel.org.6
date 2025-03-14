Return-Path: <linux-kernel+bounces-562023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C34A61A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BA319C4FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6A420D4E1;
	Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J91zde2B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1F207A02
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980571; cv=none; b=EIJeap3f/F4s6lr0pN2cM6wXHifJIxvxKuQjrpriv5lSWnpRmc/hhxMX2AH5qpjrrFNhrIAAsilWchdrM8OgRGazR3mQbg6to1QtVXPizf99xeqm0wm6P4OqndKDOgMa+UY3Y9HSG9OKkHULBdrSKquzdtvSkTGH1jw5TnFKaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980571; c=relaxed/simple;
	bh=+NCq00Wy+1YJBoI8XRnsTBTKxGLAtQEKm5X7Ld5eVHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJUEf0QcHsdcvobt/yoXzVUxY/H4S2MStCMcwYkOTUHGnNUeJf1LVHLUx3c+txDgvYxocNHpfyl75CIINBV+4Kjw3Age8ZdcqEODdcy7yo8D04EBJwWPyJAXFlZhXn5pRKJc9FRZ4L0oiI3XMtcKaSs0BGBTXocHkBbcJc58ZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J91zde2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02AAC4CEEE;
	Fri, 14 Mar 2025 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980571;
	bh=+NCq00Wy+1YJBoI8XRnsTBTKxGLAtQEKm5X7Ld5eVHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J91zde2BBPnL+pJPtNfs0OzE+ts38HR2LixL2bFq9vML0VFsF3juMh9cuMLlCyXN2
	 +xz0RNNuq28au5/RWJb06Id3J1jubDWS6WroGOWIDZn2mYdrDjEhZoop0w/h+dd/1w
	 37D+612v3SFvZURb2g7soQL4r+3BVGiRK2Prvht2wh4p3Rp+svWHXtds/AqMsxSGD3
	 7DyNiRla5FiowRj3xn9RL8zUv1Bq+zeR+/RAY9ZI+BM7dEUvM3++tRo0G0tKE0oq39
	 77FP/nXkQdLTHc5pkUblXn61JkjVRgnOY6saMLkEq9bj9VFzAgVHD3As+zilF8xEzT
	 KBftWbQF0QbTA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 06/13] objtool: Remove --unret dependency on --rethunk
Date: Fri, 14 Mar 2025 12:29:04 -0700
Message-ID: <c6f5635784a28ed4b10ac4307b1858e015e6eff0.1741975349.git.jpoimboe@kernel.org>
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

With unret validation enabled and IBT/LTO disabled, objtool runs on TUs
with --rethunk and on vmlinux.o with --unret.  So this dependency isn't
valid as they don't always run on the same object.

This error never triggered before because --unret is always coupled with
--noinstr, so the first conditional in opts_valid() returns early due to
opts.noinstr being true.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 387d56a7f5fb..c7275cf7641b 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -151,11 +151,6 @@ static bool opts_valid(void)
 		return true;
 	}
 
-	if (opts.unret && !opts.rethunk) {
-		ERROR("--unret requires --rethunk");
-		return false;
-	}
-
 	if (opts.dump_orc)
 		return true;
 
-- 
2.48.1


