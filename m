Return-Path: <linux-kernel+bounces-332744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12AF97BE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106E01C20FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782D1BF7E4;
	Wed, 18 Sep 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="k3DtKxsi"
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142D1C1736
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670918; cv=none; b=XUHrGp4S5RK+E86VRflCwNm1WrpDfrthGOkk82kX+TDjuOLh/Ib8fmDbMMwEbL8WMfbdFsKijJLEA2Ig9FlrVLl/J583BdNxdXcaEKP9DFTVMLPXJyZNRCa/qlHrs2O+DBxb9Ap9YPlxfTPyON4eK8+0QL0WZ8eDRifLclDPm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670918; c=relaxed/simple;
	bh=oWvoqzkwTAc38n+BkwjGqCuP09d2IzfV0BqEwl/OdmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FW2aBllTJij7snWJgPtbuehYYSgCrmDmwGxwVhnN4C2AwZirFcyFXY/7H20alN7DpsvnH01eo0PZCCQpIh6WtvrdU5DUMpc+xx4UqQ1nokfbb3UGnCGZApyTDOHS/4Twbxf9TMQ44A9vVFek+SCBip8vXNPDxC136rdOkiW/PCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=k3DtKxsi; arc=none smtp.client-ip=17.58.23.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726670916;
	bh=k3QBKO1gMnIwD3eJwfnqLxeWPGTlb1G+6bWXT1SuXf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=k3DtKxsi2vtsTOKGQUcY3yEBBvLZuULUYXWTd1JuuP6azNL5ZMb+fqLoM3RoDImco
	 Bpqb8XnCJIfqTN06xQrRFmMpvlfn/v7TEXyr9w5gon9Yz3Woe6hwJiI77LfXTxm/c/
	 HobGFTdCd97p+NN86gTIPPbnBBH0INSFG4BrzZTWRionRXQVJGyxlak3LopBfLxqSB
	 +p+ZPR3IQSR++G1TfkX5TLsJTWvPGN/Tm2MRx2FYzknQv1jJVuRk/YJLH7mAdjL5XB
	 tgGBxwRH8dg8InIy2o4y6fhRxTVb2mqH2EREukF+gxyWfuZZVbW+fSxjJb7FA0SmP4
	 fAtCrtFO72SOA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 8E1CD800322;
	Wed, 18 Sep 2024 14:48:34 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Sep 2024 22:48:14 +0800
Subject: [PATCH 2/2] lib: devres: Simplify API devm_ioport_unmap()
 implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-fix_lib_devres-v1-2-e696ab5486e6@quicinc.com>
References: <20240918-fix_lib_devres-v1-0-e696ab5486e6@quicinc.com>
In-Reply-To: <20240918-fix_lib_devres-v1-0-e696ab5486e6@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: qMzcp3crPxakdMNBIoRQFbbaAEiyHP0a
X-Proofpoint-GUID: qMzcp3crPxakdMNBIoRQFbbaAEiyHP0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=933 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409180096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify devm_ioport_unmap() implementation by dedicated API
devres_release(), compared with current solution, namely
ioport_unmap() + devres_destroy(), devres_release() has below advantages:

- it is simpler if devm_ioport_unmap()'s parameter @addr was ever
  returned by devm_ioport_map().

- it can avoid unnecessary ioport_unmap(@addr) if @addr was not
  ever returned by devm_ioport_map().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 lib/devres.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index 68ffcd5d9358..73901160197e 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -307,8 +307,7 @@ EXPORT_SYMBOL(devm_ioport_map);
  */
 void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 {
-	ioport_unmap(addr);
-	WARN_ON(devres_destroy(dev, devm_ioport_map_release,
+	WARN_ON(devres_release(dev, devm_ioport_map_release,
 			       devm_ioport_map_match, (__force void *)addr));
 }
 EXPORT_SYMBOL(devm_ioport_unmap);

-- 
2.34.1


