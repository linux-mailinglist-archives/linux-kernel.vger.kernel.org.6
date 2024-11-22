Return-Path: <linux-kernel+bounces-418826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AA9D65EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F281AB2375D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D881DFE22;
	Fri, 22 Nov 2024 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VtJlafzs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4581DFD9D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315672; cv=none; b=ukVMwrkQae3CvdrsdNO/SUGd5NqWRaUx9yVlaJ8Dzq46wN7qtHcYOVfcxVbbLy43uSTpDPB7pXHoasop8b9hj6AJnMFXLCEpdvrk5fxIjK1eu1FI3PVA28NbLYRawxmVDmxN4EJUA0AVyIdt5ldA2tAAIk6IrrIh2nFG4DuFX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315672; c=relaxed/simple;
	bh=oHixD4Rd4yh/kdDo4sDeeS4XxEV56OlFc1W88/QTwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSTxbCPXWJPYgVluiwAn4+g4RTf//Cx5B5z+OzZjWQWJ7Df7GwptL0Drc4kSclNRTu9d6igipagxpJK4M23R58htc6LI89eFine0ZYYh9wSFItKv9BTd4KZUObkV7QeSxL2h6lJNqjIeHcXth5KmJggOHEUmBRwpRpgxvxS+IXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VtJlafzs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qYFRgzDbimC0blaDJOJhby5s1NuEeujIYbn61y3E6GM=; b=VtJlafzsjOxL1ciibmV+zNF2mD
	jJmOJnM3bMCLXyECAn33h6KmC7anHGDQhnxf54de4TgaQdixwGqRfU5m08YsRuxiONe/8qUh7NQG3
	UUf+PVyb72aQW/l0c2+SfQreYi3jdmOrvLfINByqdzBzoqDXCrb9ezQQ6XlXPOlUivXD+13GDPDno
	DAUDeMuOYkyLG9GbdoQMlSMT5ejfxUOnmqIMMFTd+qcfGhZPgqIXu4hGWsFShlV3KVLkc9IWs2F3j
	GCEY9Rk7VTcQu1Uvv5Nnw8Eia1VP1DQipm1DJrKCkn+W7Djc6qw15WQgeMtielY3kqspM4AAwu+IW
	kq/Dek2g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQs-00000000ma4-00Xq;
	Fri, 22 Nov 2024 22:47:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiO-0jy2;
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
Subject: [RFC PATCH v2 08/16] x86/kexec: Copy control page into place in machine_kexec_prepare()
Date: Fri, 22 Nov 2024 22:38:17 +0000
Message-ID: <20241122224715.171751-9-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

There's no need for this to wait until the actual machine_kexec() invocation;
a subsequent change will mark the control page ROX so all writes should be
completed earlier.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 123e9544506b..60632a5a2a13 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -297,6 +297,8 @@ static void load_segments(void)
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page) + PAGE_SIZE;
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	unsigned long start_pgtable;
 	int result;
 
@@ -308,6 +310,8 @@ int machine_kexec_prepare(struct kimage *image)
 	if (result)
 		return result;
 
+	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
+
 	set_memory_x((unsigned long)control_page, 1);
 
 	return 0;
@@ -334,7 +338,6 @@ void machine_kexec(struct kimage *image)
 					     unsigned int preserve_context,
 					     unsigned int host_mem_enc_active);
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
-	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -372,7 +375,6 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
-	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-- 
2.47.0


