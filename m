Return-Path: <linux-kernel+bounces-433559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7119B9E59D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A053169C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7A227B92;
	Thu,  5 Dec 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZNPfCHLe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0A22146E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412846; cv=none; b=lULmBFpRUxW3eU+2yCddJxYAAWdpTT1Zniz9pY9cE6Dr6lVcV+jJF3C1B6kG21Z+XxpYH464DvSnfA9vbkolkSqdEl1E7Rawyk8Y1OBNTleAPO/O2glVZyHmDm8qavKjmxPGinn0Q0KF8szn+tvDeR6pQul9WlWpqmh0UhqV51w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412846; c=relaxed/simple;
	bh=AsiiQ3AH1Hg7rwxuzn5lSkbSiTugjqpdIcmQv0ke14I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUnZD9WFSVZ9nWtE+r+r/MVpkGtyRmGxOoEdyUaaPl1o3M15SdpmYLBglWjjqxXecxI0r+RG66EfUJKLzlrHoJAiddkOldACKWN2J+QQrj0/VJo540Jj/2Kiv0xMzfoQQv5tAioEHJQH+OBgncvP9mUAFnduqb6Apk+eM9OfakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZNPfCHLe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OdEG0WeYpieRfolhaDUCqcLcNIgzvpIdz1LyzO6qrFg=; b=ZNPfCHLeGFjD0PhnFi1lOm5/BY
	OhpN7dy2FKhqjHlZAb+KLKwUjEqa6T5m4j2z+Q95H1jhIoMm0hDia1+2svbQSoeXxYEshFJLBD9Ia
	NtcSXpmfUIGtGB8D5282qN9AdBWQIOHtimHxO608fbjmZkRqotzR5htTAyQWERRiGUkStquaWcPux
	9Y29elLQaLbcjUaEfb4PlvFG3eAvd2CHdIzKT6Yl0rF10BWjjWuLWpUlLagrRZDbJxAH6/mcik2T/
	KpXF8hG7V976moMATWVrN/n4oXjrRClWojwOZs0XjyU2C0rFXKAWjjPyauM2aw02rv4ri0Hc70VOx
	dJfZIn2w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DDpG-001i;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrO-0000000DyMe-00DK;
	Thu, 05 Dec 2024 15:33:46 +0000
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
Subject: [PATCH v5 20/20] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Thu,  5 Dec 2024 15:05:26 +0000
Message-ID: <20241205153343.3275139-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 12001f389d0b..4fd89ae5a565 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -153,7 +153,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	lidt	(%rsp)
 	addq	$10, %rsp
 
-	//int3
+	int3
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	/*
-- 
2.47.0


