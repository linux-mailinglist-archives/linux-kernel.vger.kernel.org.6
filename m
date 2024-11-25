Return-Path: <linux-kernel+bounces-420795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED79D83E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0C4B2E1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8091A76B5;
	Mon, 25 Nov 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7yN+ESw"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79F192B63
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529317; cv=none; b=av61Y3x1iazDBLyJsPsiKov6tN6u9zF2p941NuklqtSqU3FNJRW2W3/WZKJk3kVY1hq9KIMxtuGjR6jXEVsVZzgrnlL67iXC6oQK6vv58PosCcTyXF7JVEzyqGoWy7csQLufdhw9WOLXavGA/u0FGdufqMr1kB/aKrdMZjTaNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529317; c=relaxed/simple;
	bh=901v+Xi8CX7WZ/2UaAhZTmdgUyMUUMTrOOkbZQQtRzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwIqABh8HIrW+cAtKgYQxvrVQtJlfpraQZs1OGSVnfezUTKNYc/oOktz3eTvlwSQbqmOW/5q5T9Vuz8cV2R0IL5g+D8TcOcr2vvtY0gdJhWpsXEd1NGL7o6vew3r6oAh+T2H/px8/oV0gZvlmjMMKTyyC++rPbNBenFbyRVkgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S7yN+ESw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qB9NedC9exMWgFE5PUxB2AwDSYyucxpVjpydFINlR5E=; b=S7yN+ESwTJFQEDhklLD2S8R1Zp
	XuMov2A6NwS+i7VLeDdjdP+1UjCf4kZLQQel9/uiBsSCU4Mspqe6bs0OM4da4bfYcK+P/tVw/d6jK
	K1ucopUyN9JfwR2qgkeEQJW7eMdcAA6IbsefY5+FIqTIimJvD268xFOxtghube1xQE0PQSQ4TMvg4
	o1fhP97RpvcoqETW4jJRgIaaYCNgwS7hpZlYLbi/q/uPuveUjhOYde7+LA+XqVMMlbw6/ZaQqen57
	iZizRnQ+iYdZL2EOJc37x++lsBkCyWprXSeVZRyOxKBssx7jSHDZ8nS9EFJuCBjHTjHO5/q9uPqmE
	8Er+fhyA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0y-0000000Biqv-42M4;
	Mon, 25 Nov 2024 10:08:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000l8-28Ma;
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
Subject: [RFC PATCH v3 07/20] x86/kexec: Copy control page into place in machine_kexec_prepare()
Date: Mon, 25 Nov 2024 09:54:37 +0000
Message-ID: <20241125100815.2512-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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

There's no need for this to wait until the actual machine_kexec() invocation;
future changes will need to make the control page read-only and executable,
so all writes should be completed before machine_kexec_prepare() returns.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c9ae65c9a27c..431a117f3fb3 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -307,17 +307,16 @@ static void load_segments(void)
 
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
 
@@ -369,7 +368,6 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page);
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-- 
2.47.0


