Return-Path: <linux-kernel+bounces-433563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465B9E59D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33B0285919
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC8227BBE;
	Thu,  5 Dec 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Isem4Tl2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AA221472
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412847; cv=none; b=Fh0Is9cakWTVawTa1qrSIaku/jEnl1pAX79ORPkrhEvVIWF6lgjeo4K2ZCDPF8aY+gD9oll+Xv2oMkHY2dJHsdLztyIquuaFlqQ+3s/jYapNo3QYnv79MON0WBIOCCQddgz90NbQ2o3D6aII8a9w0Aq7l3PJHan1sx+ihSPk7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412847; c=relaxed/simple;
	bh=DLvJR6vRB42IQ6bXdNqGfJmv989sW0yL3k8pTWSH91U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+3SXHSmgx6QqgYgFYZ8XJ0wrNTD18Plw/Ub3/aTeg/Dw61lMknL2Gjl15loA3hz2KhVZTG01nzXeIKKT4GGFeRphz0YITWBe33Ky9ndSO2vaQVYKHTJS3NVTcMCsNgYOxK0CKqbjC+lmZ8I+kzxGLWCC7aHA0VfweKhoaL4E9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Isem4Tl2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VY0R8j5jypP0cwBOS8yfGc5RtvDuIZdzSnSfEXeOn2k=; b=Isem4Tl2es6H75PCSt4DPzTDWO
	x2YgiBHzdejp9Km63w+tWG55EpEJ5PR9kDwI+xOOXK2YbyWkIaXpBn+aU4w5F4qVpPE0tWCaXZmLZ
	RN439YeYpAeZKVZwLrV7TnX0mObNcouQnLarnjbG5W+WYgeux1hCmQExS60alFqpLCx2cRoxlCb8/
	2EqNNrfr6XexjenMmL5ULoe7TbzmJi6XzVVU0/tIAOtN5raOedL3BDlceVNYLtqmOnn80uFAi6ttx
	UEhy2C1SIierPMB0abpVH7JXOY31szMxmYVtSRPeFXq1DNcYv+8b6k2BzIgkW53KqdzAsn3/svTyJ
	Vt48Yfag==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrM-0000000DDox-0grD;
	Thu, 05 Dec 2024 15:33:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyL5-0hMp;
	Thu, 05 Dec 2024 15:33:45 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v5 00/20] x86/kexec: Add exception handling for relocate_kernel and further yak-shaving
Date: Thu,  5 Dec 2024 15:05:06 +0000
Message-ID: <20241205153343.3275139-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

Debugging kexec failures is painful, as anything going wrong in execution
of the critical relocate_kernel() function tends to just lead to a triple
fault. Thus leading to *weeks* of my life that I won't get back. Having
hacked something up for my own use, I figured I should share it...

Add a CONFIG_KEXEC_DEBUG option which sets up a trivial exception 
handler in that environment, and outputs to the early_printk serial 
console if configured. Currently only 8250-compatible serial ports are 
supported, but that could be extended.

While we're here, clean the code up a little and fix some other problems. 
Most notably, load a suitable GDT on the way back into the kernel after a 
KEXEC_PRESERVE_CONTEXT invocation instead of trusting the called code to do 
so.

I had to hack up QEMU support for a PCI serial port which matches what
the existing early_printk code can drive, and the *real* 8250_pci driver
doesn't seem to cope with that setup at all, but whatever... the kexec
code now drives the same 32-bit stride which is all that earlyprintk
supports. We can always add more later, if anyone cares.

Someone who cares might want to bring the i386 version into line with 
this, although the lack of rip-based addressing makes all the PIC code a 
bit harder.

v5:
 • Drop [RFC].
 • Drop _PAGE_NOPTISHADOW fix, which Ingo already took into tip/x86/urgent.
 • Add memory-mapped serial port support (32-bit MMIO spacing only).

v4 (RFC): https://lore.kernel.org/kexec/20241127190343.44916-1-dwmw2@infradead.org/T/
 • Add _PAGE_NOPTISHADOW fix for the identmap code.
 • Drop explicit map of control page, which was masking the identmap bug.

v3 (RFC): https://lore.kernel.org/kexec/20241125100815.2512-1-dwmw2@infradead.org/T/
 • Add CONFIG_KEXEC_DEBUG option and use earlyprintk config.
 • Allocate PGD separately from control page.
 • Explicitly map control page into identmap.

V2 (RFC): https://lore.kernel.org/kexec/20241122224715.171751-1-dwmw2@infradead.org/T/
 • Introduce linker script, start to clean up data access.

V1 (RFC): https://lore.kernel.org/kexec/20241103054019.3795299-1-dwmw2@infradead.org/T/
 • Initial proof-of-concept hacks.

David Woodhouse (20):
      x86/kexec: Restore GDT on return from preserve_context kexec
      x86/kexec: Clean up and document register use in relocate_kernel_64.S
      x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
      x86/kexec: Only swap pages for preserve_context mode
      x86/kexec: Allocate PGD for x86_64 transition page tables separately
      x86/kexec: Copy control page into place in machine_kexec_prepare()
      x86/kexec: Invoke copy of relocate_kernel() instead of the original
      x86/kexec: Move relocate_kernel to kernel .data section
      x86/kexec: Add data section to relocate_kernel
      x86/kexec: Drop page_list argument from relocate_kernel()
      x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
      x86/kexec: Clean up register usage in relocate_kernel()
      x86/kexec: Mark relocate_kernel page as ROX instead of RWX
      x86/kexec: Add CONFIG_KEXEC_DEBUG option
      x86/kexec: Debugging support: load a GDT
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception
      x86/kexec: Add 8250 serial port output
      x86/kexec: Add 8250 MMIO serial port output
      [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing

 arch/x86/Kconfig.debug               |   8 +
 arch/x86/include/asm/kexec.h         |  35 ++-
 arch/x86/include/asm/sections.h      |   1 +
 arch/x86/kernel/callthunks.c         |   6 +
 arch/x86/kernel/early_printk.c       |   9 +
 arch/x86/kernel/machine_kexec_64.c   | 143 ++++++++----
 arch/x86/kernel/relocate_kernel_64.S | 406 ++++++++++++++++++++++++++++-------
 arch/x86/kernel/vmlinux.lds.S        |  16 +-
 8 files changed, 494 insertions(+), 130 deletions(-)



