Return-Path: <linux-kernel+bounces-406514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E199C6044
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22E41F219D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EDF215C77;
	Tue, 12 Nov 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JRR969yy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F12144DD;
	Tue, 12 Nov 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435641; cv=none; b=q3zPfrXEKAeDDsysYL9BJduqDyX8ANE3YEucc3IIXj48U9kF9sg0+Q1dKoXwv2NLINc1+BcrS2W2j6Olxyln4gpqzIG/IAgKNxmTMRrXJzI3uW25n7tfu1zolSkuw3Z7yZte7XBSx0AxaX2fUAuYdx98YrZH8Hc22Pd4F3VNMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435641; c=relaxed/simple;
	bh=b2U5OCtPn243qzcSw8tXDTqbUUCT3bK/gESUj9nSDJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F85l8EMtTd35oqQU/AHWvdI7XfVnttcz0A7hdZIERDd+7OFxW/2MdrEHwaxvLostqXOSZYRlrp+RQQhJPojnXDlX72TQ8MxyYqnUTQg2e5o9q8E3jvPPjAgMMtulw6rtHbVipAJ2/DUPu5OxI8pHxE4tlMpoB0m5dylLUuK/gZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JRR969yy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACIKUtL025930;
	Tue, 12 Nov 2024 18:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KTk+4n3XFtqzo27e40D42y
	x3XCpHUbe/GUT3YGxz1aU=; b=JRR969yyNeetp5qHcy5s2WHBIH32BocDaOSOgc
	ft/y99m4F8XoOKRJeu/Z+haZc34uzDAh1QFoh6oDB5tHDGNR3Cyh0Zg7ysADTkrm
	tE64KoriaZK0auOu418GOdN0pHzRrIFQ0d5x7EgtL+QEVf/AyLBCQloYqIYx9Myu
	W8k5ktySo92n4FKAkzMa7fMJZyFmQ9PA91Smzr8/ri7n0snNB8+lK18TfEDGK8Ck
	jqIfdJOt3exwOZCMPO2M8zWUCRUor9fenOcGyqLvDV3Yg443+QxAAz227GA3ryGK
	3FsFQngz1Pv9sJ19DQYBTrVFxblWMbRmAmXCHZKcxt4XHxTA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v4kqsgjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 18:20:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACIKa19013701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 18:20:36 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 10:20:33 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH] usb: dwc3: core: Set force_gen1 bit for all applicable SuperSpeed ports
Date: Tue, 12 Nov 2024 23:50:18 +0530
Message-ID: <20241112182018.199392-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: tJ3mDsj8LH6jJGDcBM4RDNfYQ74BAmCz
X-Proofpoint-GUID: tJ3mDsj8LH6jJGDcBM4RDNfYQ74BAmCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=873
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120146

Currently if the maximum-speed is set to Super Speed for a 3.1 Gen2
capable controller, the FORCE_GEN1 bit of LLUCTL register is set only
for one SuperSpeed port (or the first port) present. Modify the logic
to set the FORCE_GEN1 bit for all ports if speed is being limited to
Gen-1.

Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Suggestion provided for the same at:
https://lore.kernel.org/all/20230517003037.i7hsg6k5fn4eyvgf@synopsys.com/

This patch has only been compile tested due to unavailability of
hardware at the moment.

 drivers/usb/dwc3/core.c | 10 +++++++---
 drivers/usb/dwc3/core.h |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9b888d33e64d..67aefdbe1d5f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1470,9 +1470,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
 	    (DWC3_IP_IS(DWC31)) &&
 	    dwc->maximum_speed == USB_SPEED_SUPER) {
-		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
-		reg |= DWC3_LLUCTL_FORCE_GEN1;
-		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+		int i;
+
+		for (i = 0; i < dwc->num_usb3_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_LLUCTL(i));
+			reg |= DWC3_LLUCTL_FORCE_GEN1;
+			dwc3_writel(dwc->regs, DWC3_LLUCTL(i), reg);
+		}
 	}
 
 	return 0;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eaa55c0cf62f..296cbe85a494 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -179,7 +179,7 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
-#define DWC3_LLUCTL		0xd024
+#define DWC3_LLUCTL(n)		(0xd024 + ((n) * 0x80))
 
 /* Bit fields */
 
-- 
2.34.1


