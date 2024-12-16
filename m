Return-Path: <linux-kernel+bounces-448300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5CA9F3E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8D11619CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26D1DB37A;
	Mon, 16 Dec 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m94t7MaE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC77139CEF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392258; cv=none; b=id9qc8UaFzVryJ0DSSOzVLAHmJpR4uKcIJiHyboge68J+OEV2wxg0fKG1EzG+4IbMf/gNIzzZHR9UtIgGNDC0c+p/jSScZ1YyGZbVShLRf7lFcIaRoqAjxug6kvG+cUpbdJ8lVC19WOj8AlXlGFBEcETMm5wzEcnK/KX+onuEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392258; c=relaxed/simple;
	bh=pD/iM6D1Uc9Ku+aH6t9jBfBnAst+5WgG7HrJPvYhw58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfDRTgF+9Uu1SbFaiO7FgQIP7u8TGKJK9SQFXmMfSEdE+ZfLb0CTiacCFNMyfG7sJyyvldyHDivDm+aOIMX3qNq/97odQXkMl4/I4eXp6qtplgQvOjONmBV25we81/8CRuuhGvcXMNGxcfCEz1WFT/MgZT5688h16l5RH68vjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m94t7MaE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=KF9I8gMwuVGDi5vu6drdRG3X3dHP+mrVfyO8mKUOGvk=; b=m94t7MaEEu9OBNPTDHoiuf70Fq
	Tp+6Tautcgn9+y4v+iOpPpRA7dlOW5BExNEZlyaWF6c5MembvO9E+FFAn0uqXpg5K1RzSXcq4jav2
	0bPZNV6y+IFYVMhUtDQZqYbSCItpaxpTV1ihMtfL8DxE6H6VkEvxzqAqu4H8t5WnoBViQ3X5Z1Jra
	KCkt6QMGdR3bdWpiBS2RER03GULc8H1xzIA+fy/pEXdzwv5vxGdcmVMSrO6KJSnfRCNFZl5s+xqv7
	W9sQtfqIFJO3Yz2pT5PTiGNtw22ueBKpuEkj9w2CSSaof8josM9C5BZT6ffocA8+uiijHgK8XXaqU
	YCQ/yO3w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nY-2fG0;
	Mon, 16 Dec 2024 23:37:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWN-17Kz;
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
Subject: [PATCH 6/9] x86/kexec: Mark machine_kexec() with __nocfi
Date: Mon, 16 Dec 2024 23:24:13 +0000
Message-ID: <20241216233704.3208607-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

A recent commit caused the relocate_kernel() function to be invoked
through a function pointer, but it does not have CFI information. The
resulting trap occurs after the IDT and GDT have been invalidated,
leading to a triple-fault if CONFIG_CFI_CLANG is enabled.

Using SYM_TYPED_FUNC_START() to provide the CFI information looks like
it will require a prolonged battle with objtool. And is fairly pointless
anyway, as the actual signature comes from a __kcfi_typeid_… symbol
emitted from the C code based on the function prototype it thinks that
relocate_kernel has, rendering the check somewhat tautological.

The simple fix is just to mark machine_kexec() with __nocfi.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Fixes: eeebbde57113 ("x86/kexec: Invoke copy of relocate_kernel() instead of
the original")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9232ad1562c8..1440f792a86d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -342,7 +342,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void machine_kexec(struct kimage *image)
+void __nocfi machine_kexec(struct kimage *image)
 {
 	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
 					     unsigned long pa_control_page,
-- 
2.47.0


