Return-Path: <linux-kernel+bounces-386167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F479B3FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384A11F23289
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E817E473;
	Tue, 29 Oct 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEx13d/g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E4145B2C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166999; cv=none; b=PRiWW/bzEdnMeJFapxVkPREz4IlECdMtUbH2ZBM9DALDSSjz/uq9kEqamsq9zIo7hucNVyZXWWN13oq4tjAayBMNx0FrOSy4wnJ8YzSZM3AnehMAr/DtPgh3XHnFwUpgmsdOvpXziUoWYUV5CHXxi6puYFRP8WHd5xi5ZQHER8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166999; c=relaxed/simple;
	bh=1HFVF/sthwuY/nVC5nB3Tk5D/RnkHEBPEeATrZPxBVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8xYN/xhd2EjMyUKu9N02dWv5oKu+DFF55aOLvcQvWxIsO64mePe5Tn3vzzg0y24fUOx9/N/MVxXxxBfSJ/Gttub8m4/sxvKej9Z/PRTK/iA9VKnqDqybQ4FXDWSdX3qcd/ZU6Zj0ZHP0Mod6qEbPMjo187zmhSPieetUSuroAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEx13d/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4299C4CEE8;
	Tue, 29 Oct 2024 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730166998;
	bh=1HFVF/sthwuY/nVC5nB3Tk5D/RnkHEBPEeATrZPxBVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEx13d/g9zNFzT2Tm1otgP9Q6bo86MvJMnE3VeZuPF+db0/rNspoRci34fi4xQ8/A
	 8KShpsxrYY3uamRJLnpeK7Gg7TqHo+S9jO19TL/Gijhmz785HmXFSRwcRRUTaAgBX9
	 FqqenAr2bOVk2zxF4rG6uBvzY0sZHl+CCZ2G3jWG1jX2fDyu8OW+5MuONEF9y53Yvk
	 t1MbquE+UDbl+kIl1RfltOEpe1tN8z/W5D6rBM1WB6qkl+HibSi9wE01rCh/hkhSyJ
	 xMbSHmFDSZT48TFuStkxHtqWqyQzTxwVo3kMViedmLL9/dLBqPQotuyLcNhOrXiP7r
	 GsiugLVijporg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
Date: Mon, 28 Oct 2024 18:56:15 -0700
Message-ID: <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730166635.git.jpoimboe@kernel.org>
References: <cover.1730166635.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The barrier_nospec() in 64-bit __get_user() is slow.  Instead use
pointer masking to force the user pointer to all 1's if a previous
access_ok() mispredicted true for an invalid address.

Note that for safety on some AMD CPUs, this relies on recent commit
86e6b1547b3d ("x86: fix user address masking non-canonical speculation
issue").

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/lib/getuser.S | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 4357ec2a0bfc..998d5be6b794 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -112,8 +112,12 @@ EXPORT_SYMBOL(__get_user_8)
 
 /* .. and the same for __get_user, just without the range checks */
 SYM_FUNC_START(__get_user_nocheck_1)
-	ASM_STAC
+#ifdef CONFIG_X86_64
+	check_range size=1
+#else
 	ASM_BARRIER_NOSPEC
+#endif
+	ASM_STAC
 	UACCESS movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
@@ -122,8 +126,12 @@ SYM_FUNC_END(__get_user_nocheck_1)
 EXPORT_SYMBOL(__get_user_nocheck_1)
 
 SYM_FUNC_START(__get_user_nocheck_2)
-	ASM_STAC
+#ifdef CONFIG_X86_64
+	check_range size=2
+#else
 	ASM_BARRIER_NOSPEC
+#endif
+	ASM_STAC
 	UACCESS movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
@@ -132,8 +140,12 @@ SYM_FUNC_END(__get_user_nocheck_2)
 EXPORT_SYMBOL(__get_user_nocheck_2)
 
 SYM_FUNC_START(__get_user_nocheck_4)
-	ASM_STAC
+#ifdef CONFIG_X86_64
+	check_range size=4
+#else
 	ASM_BARRIER_NOSPEC
+#endif
+	ASM_STAC
 	UACCESS movl (%_ASM_AX),%edx
 	xor %eax,%eax
 	ASM_CLAC
@@ -142,8 +154,12 @@ SYM_FUNC_END(__get_user_nocheck_4)
 EXPORT_SYMBOL(__get_user_nocheck_4)
 
 SYM_FUNC_START(__get_user_nocheck_8)
-	ASM_STAC
+#ifdef CONFIG_X86_64
+	check_range size=8
+#else
 	ASM_BARRIER_NOSPEC
+#endif
+	ASM_STAC
 #ifdef CONFIG_X86_64
 	UACCESS movq (%_ASM_AX),%rdx
 #else
-- 
2.47.0


