Return-Path: <linux-kernel+bounces-233907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B1591BF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E287D1C2324D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6815885A;
	Fri, 28 Jun 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I+tQLd1D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49592B645
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579712; cv=none; b=KurKiMdf+07mZeZv2S+saXx0nzxrJVdPDjE6m/yvw06pcFJIycEKNspMOh6Zbrujf04McSJOhyR5kOBCheIGzqC8kxhe7J+z7qm5ejDtthg8JSd0Ns4McSiFpn05jd5d2h7z75LvpDxQKnGrcVM1cX+UVj5k0MYEAXsETzS4FTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579712; c=relaxed/simple;
	bh=zBlN8c5mvqoPuWacVrJG+y/9vrBhjQKLgd8J2ZIwId4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/A5PH58/WzBk9o9SxjupZ9c/6CoHcOswFxMVbLl2h6RvLtTHyGulkZBeZp0HLNt20T4lLhwEftz4gomcEa/QoTdUWiWLhfu5NZ8iPA/mgv4fifZBTlrsQeytmZxIBBbSRi1hUSv4Zc5G6XfPQTo1w5dT3N6rohelT7TRfo8Znc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I+tQLd1D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S94VM3010623;
	Fri, 28 Jun 2024 13:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=gOFHdX3bXcNuM7WqRip/5X/7Es4iTaTA3aFTXaY2NAU=; b=I+
	tQLd1DSLy1Kg62Oq+c/berLXbxePdmplbPOufkHkapadVVsPPm0fgLcTL6gcsCmb
	dGNkhqfLBFtDrnqoMgFpqbf6vx9BSrjqNlY+H8WOBifBHrKbRF49S5METwL/a/81
	FZLLiqd0TJSCvijW3xD6czAbIqQL0O1K+XAaEAdbIzrZdUPKLRbxRc+8dOXhvIER
	suommsZL+tbY+XlJUGPWC7COoXBlev3WtJuWk744+siUWO3stvf5/aUDbN0JSGe2
	oMRsgbRbeQ5jmFcKafs9qssKgGReuKonOmn1GlNT5CKP7DERMSgX+h/qOo5fy0w4
	L/XMesxchWzQvH+mTX7Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdqfkgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:01:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SD1elf000757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:01:40 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 06:01:39 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] devres: Initialize a uninitialized struct member
Date: Fri, 28 Jun 2024 21:01:32 +0800
Message-ID: <1719579692-9700-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lHDxbU6LTdBii6y4GV1hox0f4iNgoN5X
X-Proofpoint-GUID: lHDxbU6LTdBii6y4GV1hox0f4iNgoN5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=779
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280097

From: Zijun Hu <zijuhu@qti.qualcomm.com>

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
---
V2: Simplify fix by use = instead of memset() and commit message

Previous discussion link:
https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/

 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..3beedeaa0ffc 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.7.4


