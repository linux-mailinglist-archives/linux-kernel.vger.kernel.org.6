Return-Path: <linux-kernel+bounces-577109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882EDA71867
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB35168BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380A1F3D3E;
	Wed, 26 Mar 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kN3gyvyo"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF161EBFE6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999064; cv=none; b=Xb9DbEkKch7QP4nLhv6jvxGeCea7eqwOtDxXrKyFQcBCJ8lcSoO1G5hiEBJTvG0/HzKbjWdo+SntCWZsCNgmyHs3DOsSKf04nrXetyW8ev0Sm+kffgGLQAfkkTRpARkxFtqNqgYtH0tDmjmzyTEHkdL0vHvwnIJ6Y+d1Cm8PjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999064; c=relaxed/simple;
	bh=yTMBScY022DhgNz3R0gMTDj7SUj2JpFKEV30QvNTSxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WrdZA7uYhoQlwY0xYG389tmfkohuJUXrryDwFcF/BXxV2AYPyM43IX3+dGH1WE5/V+VOnMx2aDj2aQ+TsciQBrGUVEDmXBEzAwZJxHO588GbGeAA6E+SiTKicTu4qZcWtKzSO/KQXxCGFUAr1xP7is2uKSR2dOgWrHMG6f2iRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kN3gyvyo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+YQTbf9wJEHM5R9aZVe7muVaiiyPNtqgtwKl9iBTy1A=; b=kN3gyvyodsSjFcGbPWrFFaIL+0
	mCW0up+AEH1HRKlGwnV0oqQpmKn2lKe3QkAp5jUJoxMVcf4yVFFdcO/RVmX07mofCvCHFs6PQY/Ph
	E/RSJV6P22v9hcMQZ25FhGWtGbl03X9eA6j6gsuQ1YUPY0K7t4hQXRLEvoHtlJvNWQEmaySbXRvB4
	vpw99Dl2Y744UX6D8BsIBHPkvCMm3dy3/TApYhNBxPuxEjxse6tNsU7qry0XERB/ckeh2mAlbheKA
	KEz3T+BlK1flWcjzJiaUQwnbz3PS+d66hBGGKw/VICpgSe+A4kl5XtVN6c0QgBmIhVFpKNfEfyVZF
	YFrqZaGg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfr-00000005oes-0VOC;
	Wed, 26 Mar 2025 14:24:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1txRfq-00000001A9B-1fVF;
	Wed, 26 Mar 2025 14:24:06 +0000
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
Subject: [PATCH v9 0/4] x86/kexec: Add exception handling for relocate_kernel
Date: Wed, 26 Mar 2025 14:16:00 +0000
Message-ID: <20250326142404.256980-1-dwmw2@infradead.org>
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

Continuing the drip-feed of the exception handling support, on top of the
current tip/x86/asm branch. This adds output to the serial port configured
by earlyprintk, reduces the window during which exceptions can't be handled
during the transition from kernel to relocate_kernel environment, and adds
a kselftest for the kexec-jump and exception handling.

v9:
 • Rebase on top of partial merge into tip/x86/asm (commit 0717b1392dc7).
 • Add kselftest.
 • Update to cope with static_call() usage in earlyprintk.
 • Drop the attempt at adding CFI support for relocate_kernel().

v8: https://lore.kernel.org/all/20250314173226.3062535-1-dwmw2@infradead.org/
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


David Woodhouse (4):
      x86/kexec: Add 8250 serial port output
      x86/kexec: Add 8250 MMIO serial port output
      x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
      selftests/kexec: Add x86_64 selftest for kexec-jump and exception handling

 arch/x86/include/asm/kexec.h                     |  2 +
 arch/x86/kernel/early_printk.c                   |  9 +++
 arch/x86/kernel/machine_kexec_64.c               | 27 ++++++---
 arch/x86/kernel/relocate_kernel_64.S             | 70 ++++++++++++++++++++---
 tools/testing/selftests/kexec/Makefile           |  7 +++
 tools/testing/selftests/kexec/test_kexec_jump.c  | 72 ++++++++++++++++++++++++
 tools/testing/selftests/kexec/test_kexec_jump.sh | 42 ++++++++++++++
 7 files changed, 213 insertions(+), 16 deletions(-)


