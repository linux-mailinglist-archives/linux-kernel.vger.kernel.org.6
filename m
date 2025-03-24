Return-Path: <linux-kernel+bounces-574487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BCA6E5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E560E173257
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628B1EDA33;
	Mon, 24 Mar 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPdg1VWH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620B1EB5FE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853382; cv=none; b=Xo2KSn4B+XG/ol6kDTaS47DYvKiscOMNzEYtrCO8H/WQL4eazK0if4thgGO4jIR4j5GPr5CP7o9xfaTnhcjx0uMPn0tfX/QNIH/s5MZkTCKOMiCFGUWwqNobmMKXmz8ZObG+/Xi/Z3+ztnNwpuAaeTYiHeutJzDQKHfD3vs2cCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853382; c=relaxed/simple;
	bh=6oqZEdmgrvjphSWtepV7HXKe9va29XW99ADSgNxBjfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtu6s0vdEWY3kokA9+FlX6suysLIYdVvlEm+D3ihlYzaVvVd1ftV1tctRXC1S0INk5HVbar4uOtlE8Un/hOGyvUasAib2pImENk+e/n87MH5qrM4E+de65Yb5AKJTkFbBgkseX6RuP2plw7iJftEqkdwN5X50o8v2gHZfkq2hQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPdg1VWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E84C4CEEE;
	Mon, 24 Mar 2025 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853382;
	bh=6oqZEdmgrvjphSWtepV7HXKe9va29XW99ADSgNxBjfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPdg1VWHpjXTbmbO70/1v9pEQAICdMjen9L+qY3Uy6wpRlS99AqXrfmjBhacOnPkw
	 1JmHoL37QEAgJGEl204jmNLVPgY5fl451IOy6rFilQVIHX//hcirYouChdQBRzNroJ
	 G1NPkJ+VwPnXbHhX04MCRNEJzESxBDAJm/1zqvamhB8hDcrz9GCcGG7R3bPmld9t0H
	 8xpUZ7kdy/zuNxFxKcQ8f2NlEwegDG74DYFMpz3G52XCjXTi4xqrSziKSn1sO60a72
	 aY0Z2LVZKdDOPLIDPKIZb02IJxKnoa0KMbOOBsvMV+/OCO7Hu3jZ5uv8um1HGC17FO
	 KmfBHALhUByXg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 02/22] objtool: Warn when disabling unreachable warnings
Date: Mon, 24 Mar 2025 14:55:52 -0700
Message-ID: <df243063787596e6031367e6659e7e43409d6c6d.1742852846.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print a warning when disabling the unreachable warnings (due to a GCC
bug).  This will help determine if recent GCCs still have the issue and
alert us if any other issues might be silently lurking behind the
unreachable disablement.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/special.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 9c1c9df09aaa..5f46d4e7f7f8 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -3,6 +3,7 @@
 
 #include <objtool/special.h>
 #include <objtool/builtin.h>
+#include <objtool/warn.h>
 
 #define X86_FEATURE_POPCNT (4 * 32 + 23)
 #define X86_FEATURE_SMAP   (9 * 32 + 20)
@@ -156,8 +157,10 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	 * indicates a rare GCC quirk/bug which can leave dead
 	 * code behind.
 	 */
-	if (reloc_type(text_reloc) == R_X86_64_PC32)
+	if (reloc_type(text_reloc) == R_X86_64_PC32) {
+		WARN_INSN(insn, "ignoring unreachables due to jump table quirk");
 		file->ignore_unreachables = true;
+	}
 
 	*table_size = 0;
 	return rodata_reloc;
-- 
2.48.1


