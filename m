Return-Path: <linux-kernel+bounces-420790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735459D8314
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FDA287611
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403E199EA8;
	Mon, 25 Nov 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WmWSKIYy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419081922E1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529316; cv=none; b=iCT0QZJXvJU6z6rE+Mbp9uluC6tsQSHL5SILtMEIu6a0eIzDWRnNdc/Y1bdSI02cwHzJBvBOx/g2U40aDXZfUDejloUfmmelEqHskVGGLqn6lIP290fADaasG7Hv/rH8giaE5Zmof0prSY7hCKFUUSFYR8mpQCIkyGQydNihccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529316; c=relaxed/simple;
	bh=zRFTU0CSm45BCgyzjxndpiefx1AXH1El990vWzmV4Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHST6Ebr4Rh3kkfA1D376QePsdvYcMW6eFm0xP4EJqqIfSqWKRVygnaEhImbsCX+lwVg+3DYEDUIy5EPcMZGMN/k8viLsX87qsrE9WtITxvKKAMMuPH4eVe464EtAtRhwiE3WSf+edEre1Hj8dFyO3JMw3g4UTvLqoU1ZSgamng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WmWSKIYy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bXmqZfne9wIEAoo4ONpQDgj54jhO/Xmxv8yTtbrY0pg=; b=WmWSKIYyS0X84wqKwhW8CrvIJN
	r6ShI5FW0t3pCK/0k4oIDB9N2s1pYE9o0cKtV/qQmbbVqF9VKn9ZwtInKPVmU92oXkKnjcqy+ru5d
	BT2FttN+UjTiqWlCOsI2D3J2KdPAEUfDllzbkDmyJemWsUy0UTRUrEl9vJVDX6NjsndKkclz5071M
	kanfcAiT35y11lrVbRi8T8rZVkIqMlq6ZmOFQezsBbFo3JB0tSbcQ4gyy5NANbMgANjDaDL/IfHwc
	4SmjbuN8+uBduxp1OI2qq7kj7affI12F7YYxndSrGFl5C2h97WE3MXC+4NjAxAzMF2rLBGKlpYlML
	aWDGtJ2w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW11-000000014f3-04Du;
	Mon, 25 Nov 2024 10:08:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000kn-0s7a;
	Mon, 25 Nov 2024 10:08:21 +0000
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
Subject: [RFC PATCH v3 00/20] x86/kexec: Add exception handling for relocate_kernel and further yak-shaving
Date: Mon, 25 Nov 2024 09:54:30 +0000
Message-ID: <20241125100815.2512-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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
KEXEC_PRESERVE_CONTEXT invocation instead of trusting the called code to
do so. And explicitly map the control_code_page into the identmap used by
relocate_kernel() instead of depending on it being in the same superpage
as something else that gets mapped.

I should probably bring the i386 version into line with this, although
the lack of rip-based addressing makes all the PIC code a bit harder.

David Woodhouse (20):
      x86/kexec: Ensure control_code_page is mapped in kexec page tables
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
      [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing

 arch/x86/Kconfig.debug               |   8 +
 arch/x86/include/asm/kexec.h         |  34 +++-
 arch/x86/include/asm/sections.h      |   1 +
 arch/x86/kernel/callthunks.c         |   6 +
 arch/x86/kernel/early_printk.c       |   6 +
 arch/x86/kernel/machine_kexec_64.c   | 127 ++++++++----
 arch/x86/kernel/relocate_kernel_64.S | 385 +++++++++++++++++++++++++++--------
 arch/x86/kernel/vmlinux.lds.S        |  16 +-


