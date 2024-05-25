Return-Path: <linux-kernel+bounces-189211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E828CED31
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 02:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75E91F2195D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EE0137E;
	Sat, 25 May 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X4ghCieO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F13382;
	Sat, 25 May 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716596257; cv=none; b=PeL93JnEru5wU5RGUEJVcgkN6mUwcesOdKG3Y+6SYwubW61LFYSUDRbGUMtsqffDJHmorfWyizjOMw3T2r0zDWF+uQtyGIx5c8G+27OBDXYA+GsScUW9IrjtPiKJVhI3uZll6t9nvNR12aEGZeP1jbgm1l54MtFeUo+yYCBvF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716596257; c=relaxed/simple;
	bh=BbauQxWMN0JI117TXfZpAyS5rwsGBt25bcZE1MQ3zeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aOMuLYCG6dHCTuhyAKoV1wAzeZxCNiFuNaXxUFlROhLwkPPoLjCpS5Dgre8GYHeS2Pa+Olv1tS5TzWx0UN4qKjhiKC4AoIR8obSi0jxeqCC5N2ZZ4/R8+VcgzkjNbTnFwHlXNtZRCM2HluzcULu+cPkjMzFhlDVLBebrrmer/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X4ghCieO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ONbljG012387;
	Sat, 25 May 2024 00:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5Spshvdqh7GjrxRh8KyZoF
	u4oCIhNpxOAWpDuCCn8uc=; b=X4ghCieO6eMYLPMpjn756Ts32CE6IEkmeYk27K
	8ZxQ2clt+69gLp67eN5tob+TIn14oNli2QhpX3850flZd/lRtEWqgcOmtG8TIHAK
	J2Dz2w4wsmXNYGPOplVbnucRqpZjDXKzkE2zMoIEU5phjmtZ0OXKfeyJyOuw7KIZ
	eDlmia8TyRQAxUVLPdiccWC49pgl547I4dZk+3hwVZ19uSnXTjJLcN0Vf07mIqet
	6SZUIrwPHmrqlnxQ0XM0cDpyOXZNoE05B/BYdG9o1v51p+jxhzuLzlzKOO0aVjDj
	tbtcqF7apD2hWXrd0vsyz/0f4Al3kYX8UW/844wP+1tysoEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8hunyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 00:17:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44P0HSOM023522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 May 2024 00:17:28 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 May
 2024 17:17:28 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 24 May 2024 17:17:24 -0700
Subject: [PATCH] locktorture: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240524-md-locktorture-v1-1-f84c5d07b1ab@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABMuUWYC/x3MQQqDMBCF4avIrDugaSqlVyldjMlYBzWRSRSLe
 PemXX7w3n9AYhVO8KgOUN4kSQwFzaUCN1B4M4ovBlMbW9+MxdnjFN2Yo+ZVGVtvr01/N0TGQjk
 tyr3s/+DzVdxRYuyUght+mUnCuuNMKbPi8ilTOM8v/5m5G4UAAAA=
To: Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gnk-32QW9bSnTJWYgdZb95TNuO1WZv-x
X-Proofpoint-GUID: gnk-32QW9bSnTJWYgdZb95TNuO1WZv-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxlogscore=957 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405250000

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/locktorture.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/locking/locktorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 415d81e6ce70..de95ec07e477 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -30,6 +30,7 @@
 #include <linux/torture.h>
 #include <linux/reboot.h>
 
+MODULE_DESCRIPTION("torture test facility for locking");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-locktorture-6d431f82aa24


