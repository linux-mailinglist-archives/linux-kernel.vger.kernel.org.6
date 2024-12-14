Return-Path: <linux-kernel+bounces-445832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97069F1C02
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0DF188E99C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367BF179BC;
	Sat, 14 Dec 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlMuDkyt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9316419;
	Sat, 14 Dec 2024 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734141303; cv=none; b=gTxKiCcgxFZizVN0WS0vestq3vQl5Bg7icbMfGb01mLpfw1mNaKpye42dFXTizHHweJ7QB1TtVxBdWw7Y+bqQnJyzC5tjZoImfnFmhNx+5OMQk1RA+vKcADUQ+HAX50eTb4sAUsp0t62nNQujTHu5AaFgAUR98dh8Io4D6nAdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734141303; c=relaxed/simple;
	bh=WsuA/3SXhnUfAIbjS7t3Vzhd4swMzfCSnp/biatW1ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tw9BT0nLm/le9wGpq6Uba9adRnXI6SKw9ZYGyQb0kxYICPInXcYBNwwXXLasXZWBG81qk0ojbhdazyO9RwimA75QLjXnRQ6DB3GZskQS8je8/YXV4bCSYpWnkfnYLlZGTGm+AqKbYKvFdsU6ZuJLA4F9vX0nWHaSl4BP3K75c2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlMuDkyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC42C4CED0;
	Sat, 14 Dec 2024 01:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734141303;
	bh=WsuA/3SXhnUfAIbjS7t3Vzhd4swMzfCSnp/biatW1ow=;
	h=From:Date:Subject:To:Cc:From;
	b=ZlMuDkytgSwnAN2EGUERMIPMSeRHXRocBhhzF3a1ZReeifq/TTgCV1UpR25TLO4c6
	 qT30AjmdzmFrnF1PWupwGfkT8aZmiK3U4jXXjM2cltmJMp6Dgj+5YKmrNtIAWHz1ND
	 zaIIu3+23HZc14a9knXcz/V6T7VN/4HSyds1ezKZ9gFvQprgx9NMo6+EiD0MI897Gh
	 pfMpF8hU6VzpwMvorNafetw4qiNVQqzpbm+FpgecMIuwbnzYpAUKtFWNJ/0uoXHxy0
	 WN5Sz/CE3+O9oroZhlLErUGawTUVBq2uKBAtjCdnmB1nGroQqIN5ZiQeTaVo4tWQRc
	 UQVr+b7Tc+z4A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 13 Dec 2024 18:54:53 -0700
Subject: [PATCH] x86/kexec: Fix location of relocate_kernel with
 -ffunction-sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-kexec-fix-section-name-for-ffunction-sections-v1-1-1ae6050f6a15@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGzlXGcC/y2NTQrCQAyFr1KyNtBJq4hXERftzBsN4lQmVQqld
 zeoy+/9rmSoCqNTs1LFW02n4hB2DcXbUK5gTc4krfRBQsd3LIicdWFDnD3NZXiA81Q551f5SX/
 LWNp+7OSYDmnck28+K7z6/Ttftu0DZ04KRX8AAAA=
X-Change-ID: 20241213-kexec-fix-section-name-for-ffunction-sections-204b328d6db5
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3896; i=nathan@kernel.org;
 h=from:subject:message-id; bh=WsuA/3SXhnUfAIbjS7t3Vzhd4swMzfCSnp/biatW1ow=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkxT0vC97QeWij/RqAxe4/Lap4Gj5sX5qyfUDIxnrWLh
 WHqm0nfO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEplkyMsyIf9BuyLJY9saa
 JImTpZkPn5QW7Ql3EY77XpI1e+1GuQmMDKdLHMoS0rfmHJjRoxSTE5fiXaelvCJSjW2f5EpTwVs
 sXAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit cb33ff9e063c ("x86/kexec: Move relocate_kernel to kernel
.data section"), kernels configured with an option that uses
-ffunction-sections, such as CONFIG_LTO_CLANG, crash when kexecing
because the value of relocate_kernel does not match the value of
__relocate_kernel_start so incorrect code gets copied via
machine_kexec_prepare().

  $ llvm-nm good-vmlinux &| rg relocate_kernel
  ffffffff83280d41 T __relocate_kernel_end
  ffffffff83280b00 T __relocate_kernel_start
  ffffffff83280b00 T relocate_kernel

  $ llvm-nm bad-vmlinux &| rg relocate_kernel
  ffffffff83266100 D __relocate_kernel_end
  ffffffff83266100 D __relocate_kernel_start
  ffffffff8120b0d8 T relocate_kernel

When -ffunction-sections is enabled, TEXT_MAIN matches on
'.text.[0-9a-zA-Z_]*' to coalesce the function specific functions back
into .text during link time after they have been optimized. Due to the
placement of TEXT_TEXT before KEXEC_RELOCATE_KERNEL in the x86 linker
script, the .text.relocate_kernel section ends up in .text instead of
.data.

Use a second dot in the relocate_kernel section name to avoid matching
on TEXT_MAIN, which matches a similar situation that happened in
commit 79cd2a11224e ("x86/retpoline,kprobes: Fix position of thunk
sections with CONFIG_LTO_CLANG"), which allows kexec to function
properly.

While .data.relocate_kernel still ends up in the .data section via
DATA_MAIN -> DATA_DATA, ensure it is located with the
.text.relocate_kernel section as intended by performing the same
transformation.

Fixes: cb33ff9e063c ("x86/kexec: Move relocate_kernel to kernel .data section")
Fixes: 8dbec5c77bc3 ("x86/kexec: Add data section to relocate_kernel")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/kernel/relocate_kernel_64.S | 6 +++---
 arch/x86/kernel/vmlinux.lds.S        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 484e8a13bf98399107f00dfb057b908e330c1a2d..38c90a14fc1b4c7d423a4decd227c7584bdfcee2 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -24,11 +24,11 @@
 #define PAGE_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 
 /*
- * The .text.relocate_kernel and .data.relocate_kernel sections are copied
+ * The .text..relocate_kernel and .data..relocate_kernel sections are copied
  * into the control page, and the remainder of the page is used as the stack.
  */
 
-	.section .data.relocate_kernel,"a";
+	.section .data..relocate_kernel,"a";
 /* Minimal CPU state */
 SYM_DATA_LOCAL(saved_rsp, .quad 0)
 SYM_DATA_LOCAL(saved_cr0, .quad 0)
@@ -40,7 +40,7 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
-	.section .text.relocate_kernel,"ax";
+	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0c893997f023627dd1f3187200d3609b234f98d1..63ff60a11be58132435e2ca8424ce31747d86c8c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -100,8 +100,8 @@ const_pcpu_hot = pcpu_hot;
 #define KEXEC_RELOCATE_KERNEL					\
 	. = ALIGN(0x100);					\
 	__relocate_kernel_start = .;				\
-	*(.text.relocate_kernel);				\
-	*(.data.relocate_kernel);				\
+	*(.text..relocate_kernel);				\
+	*(.data..relocate_kernel);				\
 	__relocate_kernel_end = .;
 
 ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,

---
base-commit: 7e39d667b06c0849ab9cec1c96e2dc253a57310b
change-id: 20241213-kexec-fix-section-name-for-ffunction-sections-204b328d6db5

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


