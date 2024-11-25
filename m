Return-Path: <linux-kernel+bounces-420792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579BB9D8317
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD6D28132D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170219D07C;
	Mon, 25 Nov 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFH3G9TH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045C192580
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529316; cv=none; b=YMxgkauLX5B5xP79UxMt4qoqAmwXJdGhUlvM79iXp75rQLj50O4tohwsYhFlKJ7GdZ7cDDmXX3rRJJIbfnPf/3KKVgwrqQTf7T5zVltFSPxK2KoUPKE+j8BawrbOl96fcT42c3YGI0zq3dMtZHL0GB3XK7A5gz9sL26EbQ3aA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529316; c=relaxed/simple;
	bh=XntE1jaWDB+xU4Kuj4uoGVTcTddYkJE+v3cnM9fHE8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQnOTifLfAQQXjh0nrNe7IawpGZa39qNLE9wGyi5txi4O3CCKjTyQ2vxwPd2omGO38CpqqzPLY5TEWNtg8NJHjk8Mzms18bI1gpbn4hoQNQuc35nnV26oEDvBCYXJxxz/wyrQdKiTkzO2hgU9QqWYesc6P7Wdkjfa3A+zU+GA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KFH3G9TH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=905CV9ftpKJ0HPQLcIxyrOfAp/IXY8cX6AqTnVswgHw=; b=KFH3G9TH0TK2PRl18yYH2hameh
	nWg1EV1JfBaNIRnD42sGSmJGgQnz+JVkBjVkqoPRuhHvEMHTl3BeL1SDow+JE7I99qv2WbSQqks5b
	ozEwm5AfcCqGPVpLR26nLkltBgdd8334QZwxdt8BXcPLMtjBt71BnplqSllAl/q7O/xqxrSjIrOkT
	TgfR8N7AAKTvP+lrMS3SwUdYgXA1Bnka7RpoNQv3QbmG4dMqUq/APWXaZVtJUBzF/zRwXLU3MHd6H
	tPnUzfifEc7QTnOBNUtkYRxt2nuI0tAm+CKumkJk6FDVqeHxETwBCqW0TFhYBOAAa02EoXL88cm30
	ReEQUTgQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW11-000000014f4-04Ku;
	Mon, 25 Nov 2024 10:08:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000kq-17au;
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
Subject: [RFC PATCH v3 01/20] x86/kexec: Ensure control_code_page is mapped in kexec page tables
Date: Mon, 25 Nov 2024 09:54:31 +0000
Message-ID: <20241125100815.2512-2-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The control_code_page should be explicitly mapped into the identity
mapped page tables for the relocate_kernel environment. This only seems
to have worked by luck before, because it tended to be within the same
2MiB or 1GiB large page already mapped for another reason.

A subsequent commit will reduce the control_code_page to a single 4KiB
page instead of a higher-order allocation, and seems to make it much
*less* likely that we get lucky with its placement. This leads to a
fault when relocate_kernel() first tries to access the page through its
identity-mapped virtual address.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/machine_kexec_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e..b9b6243ee223 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -240,6 +240,12 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	if (direct_gbpages)
 		info.direct_gbpages = true;
 
+	/* Ensure the control code page itself is in the direct map */
+	result = kernel_ident_mapping_init(&info, level4p, start_pgtable + PAGE_SIZE,
+					   start_pgtable + KEXEC_CONTROL_CODE_MAX_SIZE);
+	if (result)
+		return result;
+
 	for (i = 0; i < nr_pfn_mapped; i++) {
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
-- 
2.47.0


