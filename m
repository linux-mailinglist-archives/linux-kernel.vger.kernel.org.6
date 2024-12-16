Return-Path: <linux-kernel+bounces-448308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E359F3E58
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00781698C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B651DF24F;
	Mon, 16 Dec 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o6LkWnyX"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6561DE88A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392265; cv=none; b=XatNe7N4OdrrdktyBKQMrsphFxkZHQ34ONaf1hETE02DhSj4mCpzy7ertUE1BtR9XcTu6R2SnihPwgA4N+eVNemIFZzuau/WD0Hqdp3IYykIfjBXUijNdOQ1fV7wmUApTQmUYS+HRIggwQQt6jJ/8XKD5quxqdbyh1u2t9OdL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392265; c=relaxed/simple;
	bh=VLUVdTyeV0P1JOB4I+p27vLpOo5Zr5seDRRWbSetvcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqXMgx1z4CLZ26/buTnea47ccHf1ZSuGA3YYv6sEPUG1GnHKJwPcdUyZ4E/kzD+xODjhIS30EpWvmVi/5j1toDj1UeAOaTJNI96XUU0AGyNREWk5CnjxMHPK7Rt7r9DkWb26w5+o7dxS6x1LKl1djNGbbEfq5aIZ53/RC7q5i6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o6LkWnyX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=tC7qQ0TyIBftkKD3qsN4aGjl/EaVH0eOIxBQvILwXpc=; b=o6LkWnyX2Y1FY1IHBX8dWfzjEC
	Oargtl0xKp3FA9E7/BFmUs5BT4/GpkY4on/TIsvS/USNH3AoUt3RkeogGdJYl6O/l7rtdSKyDJDFd
	S0cSBYTp6INO+7XPmjwY4wJ5U7YAz11PGTWhYBITeopPfKbNvIw3u9bmsgAGH0stZ6cQ9vBYrem6q
	MsDSgyJ33S6VURHETBwQmcoNm6NGgX49KAnWOgVLYVXKfQ5djQw5eJuZcOkgAllFo2y1SzZVEV1hw
	g7Ph+DghE3+WIovQJ4XfLU/KbSAYj8SCD824VOVmna6FREWru7cy3RJU8d/z9vz5GmyXvoVWZthXC
	AuVzCnag==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeB-00000004xiP-29zs;
	Mon, 16 Dec 2024 23:37:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWI-0qm5;
	Mon, 16 Dec 2024 23:37:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH 5/9] x86/kexec: Fix location of relocate_kernel with -ffunction-sections
Date: Mon, 16 Dec 2024 23:24:12 +0000
Message-ID: <20241216233704.3208607-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Nathan Chancellor <nathan@kernel.org>

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 6 +++---
 arch/x86/kernel/vmlinux.lds.S        | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b680f24896b8..1996cea909ff 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -23,11 +23,11 @@
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
@@ -39,7 +39,7 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
-	.section .text.relocate_kernel,"ax";
+	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0c893997f023..63ff60a11be5 100644
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
-- 
2.47.0


