Return-Path: <linux-kernel+bounces-423847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAC9DAD84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71494166C29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930FD204089;
	Wed, 27 Nov 2024 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QTHP0tu7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E08200BB5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734246; cv=none; b=otFPHTMGpLd/L8NTTJR46ji1u9jZJ11I9b9+x+J60Yqao07ak+iUVWgWYWbVeGhwQkhivhkHIVySKdl1iaYSvR29Z7y4mm61iwzpO/klmzDhfQHytV1yU6udPzYb0AtuKYtEtb3stGMzgB64Y2QQq5/s7AHjCE1RC0wTlucBPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734246; c=relaxed/simple;
	bh=FW6hMMPLyhwrarG5r0mql4WfDEvwbKU+qaIi/tENEuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1jDuL5iI9n7012YONPigYKUciuo+Mffx6fmukqN8CMaVwOqlUB/2NWTf8GeJ/I1Pc+sue9cRZ1ItqK58LDRxWkP7LyUPepKeLgClYE/1sWW6lSY+euv9Bt6MELbkFsjN0/8sjMdjf2OkpSRIgFuxtqW0GgHbwX+2KKi8jjBbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QTHP0tu7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0nLJBUlnC0lJdbTn9E+DJez294BNmSeUZNgs1SMEfHk=; b=QTHP0tu7JkZrCncyFGKJwfhkRm
	4kgZwolFREmY9Q0yPxR6t8QU8dlxFpifkLwvbrKa4iTOsF4HkoWjTrmVvtZ+pXQmw4VhN4gw/Fm/D
	aCXp3rGDgv23xrXpXbvd1Z2JwBx/Z82vYYlPcE4/nr6SHk6kjpbj1kGEt7jzXJ40RfjodPFxBchB/
	GqTnBWJuNaFVP5YrtpchS8naUcb6zc+n+flv0d0+pDoEX5CT731wbXbefvmVGWmWXb6FG4BdLYlez
	T59Kc8iH/t8IcaDSe1SRUCYYIhnfqw86AEL+bitFLVqVvI9s7TdBLODjyqM/rt/+LsZ7dxOVcPU4Z
	48M+TI7A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Suf-188l;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000BiY-0fVq;
	Wed, 27 Nov 2024 19:03:46 +0000
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
Subject: [RFC PATCH v4 07/20] x86/kexec: Copy control page into place in machine_kexec_prepare()
Date: Wed, 27 Nov 2024 19:00:21 +0000
Message-ID: <20241127190343.44916-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

There's no need for this to wait until the actual machine_kexec() invocation;
future changes will need to make the control page read-only and executable,
so all writes should be completed before machine_kexec_prepare() returns.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7223c38a8708..3a4cbac1a0c6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -301,17 +301,16 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long control_page;
+	void *control_page = page_address(image->control_code_page);
 	int result;
 
-	/* Calculate the offsets */
-	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, control_page);
+	result = init_pgtable(image, __pa(control_page));
 	if (result)
 		return result;
 
+	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+
 	return 0;
 }
 
@@ -363,7 +362,6 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page);
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-- 
2.47.0


