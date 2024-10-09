Return-Path: <linux-kernel+bounces-357207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A58996D91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AD61C219BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB41A19CC34;
	Wed,  9 Oct 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="C5mocmDW"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E52199EB4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483846; cv=none; b=b685xIDRdAIKUKrl+oFbsJz2dkWjrL4sItrIeupdF38b+pz4pq66UAxSZLXMcmt8l3pLhv6mdAktCEW94BgnM/iev27K9sblABEMoJgoLDScPFMJEgL/MF9JRmmJo5uWWr/+kZWjNM2+0csiGF420xXNzAV0xg53qzdjEksrIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483846; c=relaxed/simple;
	bh=f9JNAxo07Q5dbhlbZTO/hOtteaSp0+62aExhm9YLEPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSAFfniF7biHDLJfMBUHDjh42sENwI8AD88HmjmiZs2HD5+q+wwd//Q3QeLo1LFsa+kprSzvYUGDB7kzGHYfnE0HwhRH9bqke3gJfodE+LPsJ9NbWl0j/fRWT8SUBNOSvEkfgf/VIHVruZa58P+spIKMayWAqIGzXfn7lIHJgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=C5mocmDW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499C8JMn006254;
	Wed, 9 Oct 2024 16:23:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	p2zU0J8Ozzt2FEFRpgTVYICyFeINndEpbE2yibsv9bg=; b=C5mocmDWIyl4eS+2
	rWzd7ksodcyUxo7yZWUTAkBqHEnRHnNid8sOZRDYAIUu5ecSzaTooQ7ByYH7SEfZ
	Xb/F9+Aa2DZU+6cqhgKEYNs3E2b15gH969zHfciHKLOcqy2mlReXMi26OeQ8NAX3
	S4tP4l347WNrmMnjnR9Y/S5piRp9hDOtBBKy+rSedPCXDP6ViBUKxaxvtGbujOd8
	9VH3wvzW00rwhcx3kVqfa+h/VbxYwS3oHJJaA2kGqdfUVL3U/NnI04ilbgu8GgZr
	fbdQUMTuDFwgqQECb77+DDyM/uITDeS06/doJIK3k50JyX9A2Cgt9vdEukG833fH
	GT0MVQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4257n8d5xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 16:23:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AF0B14004D;
	Wed,  9 Oct 2024 16:23:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 574E52612A5;
	Wed,  9 Oct 2024 16:22:41 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 9 Oct
 2024 16:22:41 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christian.bruel@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 1/1] ARM: decompressor: Use Domain Manager Access permissions
Date: Wed, 9 Oct 2024 16:22:22 +0200
Message-ID: <20241009142222.1489500-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009142222.1489500-1-christian.bruel@foss.st.com>
References: <20241009142222.1489500-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

EL1 exec access with read/write permissions result in a Permission Fault if
SCTLR.WXN or SCTLR.UWXN is set by the trusted firmware.
Since XN attribute is not checked for domains marked a Manager, change
the domain used for kernel relocation.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm/boot/compressed/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9f406e9c0ea6..d4ee205f3b9c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -888,7 +888,7 @@ __armv7_mmu_cache_on:
  ARM_BE8(	orr	r0, r0, #1 << 25 )	@ big-endian page tables
 		mrcne   p15, 0, r6, c2, c0, 2   @ read ttb control reg
 		orrne	r0, r0, #1		@ MMU enabled
-		movne	r1, #0xfffffffd		@ domain 0 = client
+		movne	r1, #0xffffffff		@ domains = Manager
 		bic     r6, r6, #1 << 31        @ 32-bit translation system
 		bic     r6, r6, #(7 << 0) | (1 << 4)	@ use only ttbr0
 		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
-- 
2.34.1


