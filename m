Return-Path: <linux-kernel+bounces-217363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D927B90AEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C773B279EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020EA197A60;
	Mon, 17 Jun 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ihndfD+U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051D194AC7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629779; cv=none; b=onQ1B9YnRCGdvYndiD8N4e/JCDiRRFHrcstSez/tbJzKvr7RnpBfsAd4GwitnQZ4FpCvlgibzlsWrgKgO/e/t2EvF7eKlkmwsq2E33DGdBtN7pldAzzI8qGt74CmTQ53qIftBd7ypb5wZj/bl0v61eMEvP70zlcU7OIutlT6tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629779; c=relaxed/simple;
	bh=MYPsn6ritNqE9TZVt+8Zslm3u4yWjO/7RIp0LIHgrAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AmHZ5/NjTu59XiUgnAJ/gctqc9rHB6uTcm9T6RP7y2LmGZ3WzbYKD7HcUo607pKOWJE+6j/jEbQoWQ9yL6CjaCqdpCl3+IcpNFMRiO3JJSlpv4uZ3Jvm6QbLRtmGWJGO9KhCTQttEQK0iauxUUeDj1BZA4UNCOCvEM3jPsoVm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ihndfD+U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAevkw010949;
	Mon, 17 Jun 2024 13:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=+UTqsXnqYsf71lwEIfR/epO5ggHZN8teXnYbfbnsODA=; b=ih
	ndfD+UwTPnQ6TkCy0nEUExDxxqrBros/dtSfC+nHKEkWHtcwbPitgaeViMm0MamW
	Penm3S/DUQQuFZSim+7qlPqe+ysSOe1wojK/Fwh7xessQoek01vPl29fpmw/iEdx
	thhan88rj8Xlmp1HQOAmxOAEKN3jNt6KMTkbrqH/Vf9/qbDn9js0SPI72LvJJLk0
	PV01uGGB54ms9G/5qV7PHeHcGfsyVLCVzHkQRs5F6tghcgXQqy3wEonazj7ATtsx
	K76vTvStGQrxX5QX8oT4ppDx1t46+Gf4wvlnkgaxpItuEvrfr8n58gfhUA6oJo8o
	+/x5sSOFad2Xr5S0yVVw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1wr3ryy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:09:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HD9VNF015647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 13:09:32 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 17 Jun 2024 06:09:30 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
Subject: [PATCH v1] devres: Initialize a uninitialized struct member
Date: Mon, 17 Jun 2024 21:09:25 +0800
Message-ID: <1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-GUID: bywCj_mlsdAhvwCmfVzi0UwR-Yu-lm_y
X-Proofpoint-ORIG-GUID: bywCj_mlsdAhvwCmfVzi0UwR-Yu-lm_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_11,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=572 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170102

Use memset() after kmalloc() a struct devres_group to initialize
potential uninitialized members such as @color within kernel API
devres_open_group() as alloc_dr() does.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/devres.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..ba3e4603cd77 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -558,6 +558,10 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	if (unlikely(!grp))
 		return NULL;
 
+	/* No need to clear memory twice */
+	if (!(gfp & __GFP_ZERO))
+		memset(grp, 0, sizeof(*grp));
+
 	grp->node[0].release = &group_open_release;
 	grp->node[1].release = &group_close_release;
 	INIT_LIST_HEAD(&grp->node[0].entry);
-- 
2.7.4


