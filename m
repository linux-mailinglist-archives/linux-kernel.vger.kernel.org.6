Return-Path: <linux-kernel+bounces-448306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673DB9F3E55
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B3816E54B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D31DE4EB;
	Mon, 16 Dec 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIW8v66q"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB141DDC3C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392263; cv=none; b=bQumM+xWkHPrJmGTyJ+IsWgQ+yi8zmF4/rL1zBKIH+uqyFjn0ohAr1pFxHlO6hAAPrOGGTIu1h7nHtMj7Ua6y6tEM4Bqt4KpGVf0Mxn4DWOxEsrE/FOzlFGm6hMKrGN10UwFEpI8S+eGA71ZeXXyrj82RzjllgWCwaUomJhS7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392263; c=relaxed/simple;
	bh=ujJqyhY4eWgDpx9l5yGgvRcwHT3PcsUqudVIHR06Uuw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qEgbO/ax7OYxJWsSyeA+Uf2ru+odCphEWLXoA94U5BqpfXgwVbYcWESmZVmtD0CEzsbzTVA5Q2etM67PA6p8MPXtDfwaECyqdZCiyPeQlxHeCAtBWUUW81aA3ZdDn2U2vPCNEPZXe7ISL89leRfqVQYgSQ+UygKX3t+w9Lefgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aIW8v66q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ApUmt5w5j50ZzE4CN8B8im/cB0YzhpqvQRJfxOmpDKc=; b=aIW8v66qJZpnRx4m3gzUvZqAl9
	45t1gnTqyeP3Azx2aZfITl6GbsRtFlM2MyIKtCOZpuQQ84GB9JrWXxsvtH+He4besVhXQr6QLduir
	/eNlzMwd8DDqg0pmKOkSjeskGPIpiYltdMJVayJA1dQvPqs+ndHzc3ccRYjogdE/zP1gZYw+UDcMt
	pvFCNZ1bRMoA5+rhhxsXw/vbkjGLB91eQE5WkFKb8ECaggDgCt8F8Rmc679Tyhwjk/mctU5xXWNef
	siWqn4HujzYmScywJ39NEOlc/iaCGEGnnLnnF3vFg3iAumiGzvde4hmgHVcpCreJg9RKwsfg83Slb
	lbeUcrHA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeB-00000004xiN-2ANX;
	Mon, 16 Dec 2024 23:37:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKe9-0000000DeW0-3qcI;
	Mon, 16 Dec 2024 23:37:05 +0000
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
Subject: [PATCH 0/9] x86/kexec: Fixes for tip/x86/boot
Date: Mon, 16 Dec 2024 23:24:07 +0000
Message-ID: <20241216233704.3208607-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

Fix a few bugs introduced by the recent rework of the relocate_kernel()
code, and one which has been there in the kjump code from the beginning.

 • Global read-only TLB entries made relocate_kernel() crash when writing
   to its own page after the %cr3 switch should have made it writeable.
 • The preserve_context flag was lost when invoking swap_pages on the way
   back, causing pages not to be swapped.
 • The wrong page was being used as the swap page.
 • The ABI for the kjump call asks the callee to put its entry address for
   next time at %rsp+8 before returning, but we set %rsp to the top of the
   available page, such that the entry address is at the start of some
   other page.
 • The relocate_kernel() function lacked Clang CFI information, but is now
   called via a function pointer, leading to a crash¹.
 • The relocate_kernel() code and data could end up being linked into the
   wrong place for a LTO / -ffunction-sections build.

Thanks to Nathan for reporting many of the above.

Also a few minor cleanups, including a comments-only patch from Rafael 
on the suspend-like part of kjump as a prelude to actually cleaning that 
up.

¹ Fixed by just adding __nocfi. Actually providing the CFI information 
for relocate_kernel() will need a bit more work, so let's just do the 
simple fix for now.

David Woodhouse (7):
      x86/kexec: Disable global pages before writing to control page
      x86/kexec: Ensure preserve_context flag is set on return to kernel
      x86/kexec: Use correct swap page in swap_pages function
      x86/kexec: Fix stack and handling of re-entry point for ::preserve_context
      x86/kexec: Mark machine_kexec() with __nocfi
      x86/kexec: Cope with relocate_kernel() not being at the start of the page
      x86/kexec: Use typedef for relocate_kernel_fn function prototype

Nathan Chancellor (1):
      x86/kexec: Fix location of relocate_kernel with -ffunction-sections

Rafael J. Wysocki (1):
      kexec_core: Add and update comments regarding the KEXEC_JUMP flow

 arch/x86/include/asm/kexec.h         | 26 ++++++++--------
 arch/x86/kernel/machine_kexec_32.c   |  7 +----
 arch/x86/kernel/machine_kexec_64.c   |  8 ++---
 arch/x86/kernel/relocate_kernel_64.S | 57 ++++++++++++++++++++++++------------
 arch/x86/kernel/vmlinux.lds.S        |  4 +--
 kernel/kexec_core.c                  | 23 +++++++++++----
 6 files changed, 74 insertions(+), 51 deletions(-)


