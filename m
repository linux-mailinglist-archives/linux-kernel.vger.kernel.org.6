Return-Path: <linux-kernel+bounces-561873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036BCA617DC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269161890F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AB204C3F;
	Fri, 14 Mar 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hYkUWdCG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7A204598
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973566; cv=none; b=K6Eh4u9StSgDKmrXS92ObDbnf/t9itgNgAtstdKbPdcttdXlTT1Yx0QE8BAu3wunLluhq6f6CnwofYDIfP0wDPXc1itxUYfTVY5vQ2Y5RpFlu0PImfpW+tmXdeNyRmf9djSgZ5TglwisEDgObWNJ/s7VhiKA0+u8+VGWyoDu/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973566; c=relaxed/simple;
	bh=xF/2QnZTSylt/cwjFnFTL7qBGTzMhfvtQ67JNqoT4r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hf+KTRPR4WuAJo6IEjQS17+WgDCzq8ARbwTPvFCNx0c1e4Z/D42gHcGZwbOIUAKu+TG57PkXJRTO/oG36+dThCEvfJUWEAP118EWQy7lojqHWiB/4qNoIo0lr23+y0MqpBKReZgclCiRSsOYJ8sV8Bm1bWDIN9JqxBb2wBRzsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hYkUWdCG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=96s6A0/wGdg9uEowt/d0MtM4B3230XuWS7buJGJQgVo=; b=hYkUWdCGeorzJA6Fbu6tUQSfsD
	rKkuiTnOfD+erkZFGETT3p78wEpDohBR3bKdRF/WXXzAyx9ZH7TuxytV0oSL4oP6JA4q0sQ2arUb/
	jnCHj/0t3dDQEyMWDdmTdQ9IPd2kaGqA/IUWp8hP00aByTzAz981k5S0/1akHmrJrDuiB1srX1v20
	FciWJCOUiaaGPrtUqrSWzFxWPbopR9myKzHtb7iVHtTC+b7pQAaeQkr3sKkLRcjxi8gR0NJBGGpph
	8pPqJjPrWZLly99egtwGI4maLLSTpNmPtwvJVcCmVaaxrJpCtaTozMQnA94mXhxJt53zEC+GWWwRp
	Nr1NUj4Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tb-00000002vU9-3fUO;
	Fri, 14 Mar 2025 17:32:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tY-0000000CsVc-32QC;
	Fri, 14 Mar 2025 17:32:28 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v8 0/7] x86/kexec: Add exception handling for relocate_kernel
Date: Fri, 14 Mar 2025 17:27:32 +0000
Message-ID: <20250314173226.3062535-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html


Debugging kexec failures is painful, as anything going wrong in execution
of the critical relocate_kernel() function tends to just lead to a triple
fault. Thus leading to *weeks* of my life that I won't get back. Having
hacked something up for my own use, I figured I should share it...

Add a trivial exception handler in the relocate_kernel environment which 
outputs to the early_printk serial console if configured. Currently only 
8250-compatible serial ports are supported, but that could be extended.

I had to hack up QEMU support for a PCI serial port which matches what
the existing early_printk code can drive, and the *real* 8250_pci driver
doesn't seem to cope with that setup at all, but whatever... the kexec
code now drives the same 32-bit stride which is all that earlyprintk
supports. We can always add more later, if anyone cares.

Someone who cares might want to bring the i386 version into line with
this, although the lack of rip-based addressing makes all the PIC code a
bit harder.

v8:
 • Fix UNRET objtool warning in exc_handler.
 • Clean up magic numbers in stack frame for exc_handler.
 • Fix i386 build error due to making the debug support unconditional.
 • The int3 is still a [DO NOT APPLY] hack for later, and I plan to deal
   with that with a userspace test case based on
   http://david.woodhou.se/loadret.c which will exercise kexec-jump at the
   same time.

v7: https://lore.kernel.org/kexec/20250312144257.2348250-1-dwmw2@infradead.org/
 • Drop CONFIG_KEXEC_DEBUG and make it all unconditional in order to
   "throw regressions back into the face of whoever manages to introduce
   them" (Ingo, https://lore.kernel.org/kexec/Z7rwA-qVauX7lY8G@gmail.com/)
 • Move IDT invalidation into relocate_kernel() itself.

v6: https://lore.kernel.org/kexec/20250115191423.587774-1-dwmw2@infradead.org/
 • Rebase onto already-merged fixes in tip/x86/boot.
 • Move CONFIG_KEXEC_DEBUG to generic kernel/Kconfig.kexec as Bartosz is
   working on an Arm64 version.

v5: https://lore.kernel.org/kexec/20241205153343.3275139-1-dwmw2@infradead.org/T/
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

David Woodhouse (7):
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception
      x86/kexec: Add 8250 serial port output
      x86/kexec: Add 8250 MMIO serial port output
      x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
      [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
      [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()

 arch/x86/include/asm/kexec.h         |   7 +
 arch/x86/kernel/early_printk.c       |   9 ++
 arch/x86/kernel/machine_kexec_64.c   |  50 +++++--
 arch/x86/kernel/relocate_kernel_64.S | 248 ++++++++++++++++++++++++++++++++++-
 4 files changed, 302 insertions(+), 12 deletions(-)


