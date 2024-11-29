Return-Path: <linux-kernel+bounces-416586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26BB9D473B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4471F21C87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2851CB31D;
	Thu, 21 Nov 2024 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BAVgIY8A"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE691CACDB;
	Thu, 21 Nov 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732166433; cv=none; b=eOM4/2EugwabpxMdcR5to4sCIIFFebj9G+OPx8V/mLhyQ87TceUhz95lIKZe7G80Dz7PB4WuHferOZrlEWlXs23DsjIDovcdQO5nSlrj5iWFQg1bXvteSD4Uy+2JAxbpu4cUF7OFB6CgsBXeTyWrPTNGHQHqCQlC8q2MW0OBgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732166433; c=relaxed/simple;
	bh=blOVQ/4lvrdmGaz/UKVIclSD/OH/Dx9lL4/cPlCabvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrpdE2vl08eUqv9ieN1C7Ad2wwjgj61MTwmywbWCJR+T08OB4ZRKkhVOdGVTkXgbm3mJdiDnpdFfrimp7dsDvFNqES60NNJ7Jjjw6eLsE7SyhrdOlGs6+aBOb0YO77WnupaalNDw6nFA+jvCve4jsJ13kGlDoeSiacgcyXk6hYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BAVgIY8A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL0qwtO027170;
	Thu, 21 Nov 2024 05:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	njvBd7fQBGBPY7/hdKL7MLDZVOz8Tcto5vfEol1CagA=; b=BAVgIY8AqMYK6wyC
	J4F4TAfRv/VnIwVKAV5h8bFPNGmIK3o2NNbcIrwomUTORSVYWTY8YYD0hm80nU/e
	fgaQcolY83JVmdT9Ir5OXC5kakNJYR7DVwLSzf8N40CKRt/ZewrbIBKcbZONgaDH
	bmZxHHiJp2ArGABGpLcIglBcMvKolKeqbmkRUSSxpRXH9GXkIyXUU3TlJm2JbQc7
	JN2UKKu9n2DbvBBVd0IO0YyR6amYdlXKRmn8vtMvquD6u7O5Zb9MsWj82BEUhdXB
	3dSz/VBtbNlfyMc3nniZw2rSa20NKwosbivCYYLN0OKBm6bShBzDMI+b/HvbprgC
	Cni3EA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ebyaf14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:20:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AL5KGO5025462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 05:20:16 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 21:20:11 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <quic_rjendra@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Document Qualcomm IPQ5424
Date: Thu, 21 Nov 2024 10:49:50 +0530
Message-ID: <20241121051951.1776250-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241121051951.1776250-1-quic_mmanikan@quicinc.com>
References: <20241121051951.1776250-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aTa35BLR3r4Wh4oAkMvzNvPot-_wRWkT
X-Proofpoint-ORIG-GUID: aTa35BLR3r4Wh4oAkMvzNvPot-_wRWkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210039

Add devicetree binding for watchdog present on Qualcomm IPQ5424 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V2:
	- Pick up A-b tag

 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 34896a39fa91..49e2b807db0b 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -20,6 +20,7 @@ properties:
               - qcom,kpss-wdt-ipq4019
               - qcom,apss-wdt-ipq5018
               - qcom,apss-wdt-ipq5332
+              - qcom,apss-wdt-ipq5424
               - qcom,apss-wdt-ipq9574
               - qcom,apss-wdt-msm8226
               - qcom,apss-wdt-msm8974
-- 
2.34.1


