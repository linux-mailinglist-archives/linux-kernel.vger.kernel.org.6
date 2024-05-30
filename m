Return-Path: <linux-kernel+bounces-195794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640108D51DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193D71F24556
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE84F898;
	Thu, 30 May 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ZPfXmtEg"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7E4CE05
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094196; cv=none; b=B1mjZ76w3kGy70iKySsT3ReLV91BXLB0mYrO+h16lUNZOD4HGfPxIx5S81NDEQw8hyBAkMv13z3sU9ojszF9yd2gIeFP6DrwS3ralfOV2zaBT1n9DHu8VB6Tpgf2VutKnZqUF/jsItSg+BosDzP0Sn6NfSY/HGn4OtN7WcEv7ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094196; c=relaxed/simple;
	bh=RNwHdQcUYiTeG5hUBrDS1pUm7v2IHd2A3lb5RBu12MI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YglTbaIFhgcH2+xRS6FRTnFgVM1LtR7YGs5RS0CKe60VFUqc3LvpYItKApilySx2aha6KyhcolgiNkebA/wmd6S8vIxZOnyUJliUa1syNcHLDZQ3Pd3focLOPtjDn6Udojgwn4gzYV3JWOyP5XCw9BfkaI+U7NvvgdGr0H6kyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ZPfXmtEg; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFZPBn032085;
	Thu, 30 May 2024 18:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com;
 h=cc:content-type:date:from:message-id:mime-version:subject:to; s=pps0720;
 bh=0U6HffCCQbVDpU0ZFcMNAlCec0e3gES0NCQepInaYBA=;
 b=ZPfXmtEgj5htOfBURnO9ItNEjA+88dJ9+Ncc3l9T/Y/KmKxQWALTiLdRgyfAKGnl3NyI
 ZbyA8hcPR448WITmIkvVF8Y6fUsXMWwDgtXBE93KntoEsnl06wrDJubFmiKVYWfGUSlI
 fEiGsbAZFF191nEopjWAVnT+/ZHAa8K53KvEIBXB/FCNCRpiCG0JIaCx6Bbee1CvlFTk
 HnfGr6kS27fdhD7xZbBMRFk034ksDMoSywezA7vvyXilYL0niqzzLc7OY0rUd4Nwns92
 zAvE0pp2+PYchU97SBM+BM+Cnrnxo2jTpDy8Z8Een3ZIY6nAwkiZFSB/a8Jjkgtiiak5 8g== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3yechy0h2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 18:36:09 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 16F6B130D4;
	Thu, 30 May 2024 18:36:08 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 5ED8A810082;
	Thu, 30 May 2024 18:36:05 +0000 (UTC)
Date: Thu, 30 May 2024 13:36:03 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Yi Zhang <yi.zhang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Wang <00107082@163.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dimitri Sivanich <sivanich@hpe.com>, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [PATCH] iommu/amd: Fix panic accessing amd_iommu_enable_faulting
Message-ID: <ZljHE/R4KLzGU6vx@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: Zr1ZavLdYkTSvbOlZ5FyqI86n65-N2MK
X-Proofpoint-ORIG-GUID: Zr1ZavLdYkTSvbOlZ5FyqI86n65-N2MK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405300137

This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
DMAR fault interrupts locally").  The panic happens when
amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.

Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a18e74878f68..b02b959d12af 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
 	return 0;
 }
 
-int __init amd_iommu_enable_faulting(unsigned int cpu)
+int amd_iommu_enable_faulting(unsigned int cpu)
 {
 	/* We enable MSI later when PCI is initialized */
 	return 0;
-- 
2.35.3

