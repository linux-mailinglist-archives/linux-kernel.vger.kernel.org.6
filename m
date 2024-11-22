Return-Path: <linux-kernel+bounces-418823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A59D65ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC371617D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353831DE8B0;
	Fri, 22 Nov 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZEHxI3q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B518B47C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315666; cv=none; b=C8/v2w65gFGF56ZApLHclVRgqTPFomGgaEpqIJWbSWE/sSubudRpm7xgOtTu4Ut5L7P4IbCiD4ivYkNkge2m7c3iE44WN1YZ8IzVsDvepG74q+ZjZmVsj4iSp41KzT7+De2hl+zEB1tRb9t/6GL1T9aP+eBgNGzwLzevy/A/ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315666; c=relaxed/simple;
	bh=RGUKNDHGWOazvs/c7hrffgjfh6HEUXX7zQWnEARD2gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7SCOo78D5+YGGU7agpyr5cxPq4BaIF37UdMQuyvhhjg2l6Z5FJon3ecYlHoKrRB46+TJmsgFvHSCRMAQkN0DrZWA1f0QzRHVby8fbofnWbVZb8oyBesLALR2cislRi5NfjJP9AlO2x8sn4bTk4BiSKQjfDDF1gvKEIGiOj6K88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CZEHxI3q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sLmOWyrmuAgxGhbmd1Cx2AL9gzQ7rBcfLnxnrcUkLFI=; b=CZEHxI3qag6H7vBnQzDyG84huZ
	6QJ6owj1EX3+VI1h+UzfeQysyMxoa9CHS3YZfLFiQ+2fhmwV/ginQhEBpqB1b0AxDedvvD/kYpV2H
	jaFB0bXlJdSP0NFTO7UKSMgVIQetKhNWHawYDEZHKdOV7sNbKMZF5F/SKMKWlEd6zhkIEgQKxEILZ
	R6oUOzyCoN64mkI2D+nK9V/3FxC6ISvMvIduIBex7Y0bNMLVSU7r5rQAxfNNnEVzhnA8H2afkCtRM
	z53rRZIn6ppFhBO3Q4EMsyHwCLZsEn++faPY2fv5hxkk6pDRbZGOjel6/1MYbQpitZH1Odh3xf0Ey
	hu3/jr8w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQt-00000008PI6-1TwR;
	Fri, 22 Nov 2024 22:47:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iia-1Wwr;
	Fri, 22 Nov 2024 22:47:19 +0000
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
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 12/16] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
Date: Fri, 22 Nov 2024 22:38:21 +0000
Message-ID: <20241122224715.171751-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

All writes to the page now happen before it gets marked as executable
(or after it's already switched to the identmap page tables where it's
OK to be RWX).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c653c2c22d63..2a294daeeb1a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -319,7 +319,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
-	set_memory_x((unsigned long)control_page, 1);
+	set_memory_rox((unsigned long)control_page, 1);
 
 	return 0;
 }
@@ -329,6 +329,7 @@ void machine_kexec_cleanup(struct kimage *image)
 	void *control_page = page_address(image->control_code_page) + PAGE_SIZE;
 
 	set_memory_nx((unsigned long)control_page, 1);
+	set_memory_rw((unsigned long)control_page, 1);
 
 	free_transition_pgtable(image);
 }
-- 
2.47.0


