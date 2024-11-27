Return-Path: <linux-kernel+bounces-423856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B75E9DAD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4387B23A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A1205E17;
	Wed, 27 Nov 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hIXc1feL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0A2036FD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734251; cv=none; b=DWb7BbHKyoZTQo5LK9XTXiU5TlZhv6BP/tszvu5caM4Lf2sGh2cWtFyB62bxdEB2hnhwZQKPK/OSiixQS658SLypXJGyWdUO01IHMXllGe/pZRnfwdb2XcMQxUX/J6oSX3ANIriDRrB5KX81zRpx/LBafqs/jMwm9umqqcJa/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734251; c=relaxed/simple;
	bh=ATrLF8bEGGQ7d1ke8koQcA5JABpDyqfpZQhiBk9oNjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Va/jugSJXeWzTZUwlz0c8pGU7ojHvFvPEpO2OddhhIeoGOPHTsCNCgC8ukY2qEbb8LYoP5Re3Lt3cMqQx87Kl+DInVg/NkTqY5qwKxbQfQ4ZEIJPP4WJNpzV1BEgRHF2YlTUjntkxH1cF8PruZTZvGkhwVSQaoX7Pv9g5FzzSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hIXc1feL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OTgmGqkzjiMCAdM9XAGVnWmAd0bZ2mIoBGOGiUYyUyI=; b=hIXc1feLdzn5u5UgzQVtmgzb0L
	tIIR/OVSGOFdLZ/bDLsU+8k0HWQJAfnJBBbU1hDGxJI8NkcxP3Feu3mbhtlip4PnBWeUboSVaR0TG
	td797DNJ62Agu3iRmioCN+/QhRwcXOG1zI6YAvqrCLw70X6pKJgvDRmjPcJCZ6i43M1PuQOPKUy5B
	Cf7IGkWg9C5RQgTzljoY9ngd6fyz3gjlBxteE6L/iGhm6+4dhUE/u76oagvPdUB9CkUj8uUUcxnDx
	f6XNW5n/pJM4+neVN8kAVbj6619Wf2egv2kmqBdmEZ9z9kS+nRO6OtI6wIdq9gUvtstIyxfI+8px9
	JDZaUXGQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKC-00000001cW2-3BcR;
	Wed, 27 Nov 2024 19:03:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKD-00000000Bi7-39d2;
	Wed, 27 Nov 2024 19:03:45 +0000
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
Subject: [RFC PATCH v4 00/20] x86/kexec: Add exception handling for relocate_kernel and further yak-shaving
Date: Wed, 27 Nov 2024 19:00:14 +0000
Message-ID: <20241127190343.44916-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

Debugging kexec failures is painful, as anything going wrong in execution
of the critical relocate_kernel() function tends to just lead to a triple
fault. Thus leading to *weeks* of my life that I won't get back. Having
hacked something up for my own use, I figured I should share it...

Add a CONFIG_KEXEC_DEBUG option which sets up a trivial exception handler
in that environment, and outputs to the early_printk serial console if
configured. Currently only I/O-based 8250 serial ports are supported, but
that could be extended.

While we're here, clean the code up a little and fix some other problems. 
Most notably, load a suitable GDT on the way back into the kernel after a 
KEXEC_PRESERVE_CONTEXT invocation instead of trusting the called code to do 
so. And (new in v4) fix the interaction of PTI and the identmap code so that 
it doesn't scribble over the end of the 4KiB region allocated for the PGD 
expecting there to be a userspace PGD there.

I should probably bring the i386 version into line with this, although
the lack of rip-based addressing makes all the PIC code a bit harder.

David Woodhouse (20):
      x86/kexec: Restore GDT on return from preserve_context kexec
      x86/kexec: Clean up and document register use in relocate_kernel_64.S
      x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
      x86/kexec: Only swap pages for preserve_context mode
      x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables
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
      [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing

 arch/x86/Kconfig.debug               |   8 +
 arch/x86/include/asm/kexec.h         |  34 +++-
 arch/x86/include/asm/pgtable_types.h |   8 +-
 arch/x86/include/asm/sections.h      |   1 +
 arch/x86/kernel/callthunks.c         |   6 +
 arch/x86/kernel/early_printk.c       |   6 +
 arch/x86/kernel/machine_kexec_64.c   | 121 +++++++----
 arch/x86/kernel/relocate_kernel_64.S | 385 +++++++++++++++++++++++++++--------
 arch/x86/kernel/vmlinux.lds.S        |  16 +-
 arch/x86/mm/ident_map.c              |   6 +-
 arch/x86/mm/pti.c                    |   2 +-
 11 files changed, 457 insertions(+), 136 deletions(-)



