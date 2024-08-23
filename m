Return-Path: <linux-kernel+bounces-298280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114995C51A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06CB281E54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860BA6CDC8;
	Fri, 23 Aug 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C0yZSCzD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA16F305;
	Fri, 23 Aug 2024 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392669; cv=none; b=hwKJo9Zo0lw78n+5o7HEpJ1vBQzSGZ5/tHYQFXe2851JtsO1T9lvtvcSyJPpowDHu7r1oLlZhTOmzFOTzO6Ed5MVUlivIcJuRbv6gWpkP9ZDFCdVKSIwf7Dhpij4f6drj6m7Kg1OaE4g+h8OV9vqL0De8ELCEx5LTxqcD2Wqm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392669; c=relaxed/simple;
	bh=qKOTiMwnAcsaXcsYIeN5NCeYSDdkBUGq4qsXHEk3XmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G/VZsVdwSjRQih9NBB6ngC/mh5j49uYyBCKH0tli+Gpbek1D0aHJyNcijKInoPZ8taS2nl+NUtS27HpJURMCSPwYYzCuCvog5IQCd7U0sdwv7ObAULjSMkP1+AvkxF9AEvQrcQDEK5O6YUViZLd9OZaNvrluW6NDGVqN8VTgCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C0yZSCzD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N2msbo007676;
	Fri, 23 Aug 2024 05:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=V//feCbavFR0yiNBSQY8IK+/h95Nfvq1hfMd0arRUKw=; b=C0
	yZSCzDMRED6m0TkyjZk8W19cruJP5LqIAF5K5iI9a9f6zrtKBPUyYMBNKfKneyZ5
	vfhe3/NzB5n1dEc2nDOaeQx2BK9So0+4mEgnUNcLjRCGoGugbEcQiIeiFRy+8FUF
	tcttUeYiNQWlNRgFqaI+NrXj6bxv1tccdblaGbpEveSRnsg+k84hwgIrzGiipWgO
	8C6yd2D49+JsIMJnlH6Rg7Pni3At49uGngBi7/alBo21wDZ3aumVuXMem9GjPKjJ
	1fhJHZJ76ryHlaAuI9F44G/Jb+HUEb22+9ejpAJLJ3Wpeo2bGbo+FB5vXbXmC737
	+7O8M8/5E/lHrnnqx83Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4159yjf355-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 05:57:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47N5v3ZM023796
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 05:57:03 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 22 Aug 2024 22:57:01 -0700
From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        "Uttkarsh
 Aggarwal" <quic_uaggarwa@quicinc.com>
Subject: [PATCH] usb: dwc3: core: Set GUCTL1[29] to ignore single SE0 glitch for FS/LS operation
Date: Fri, 23 Aug 2024 11:26:42 +0530
Message-ID: <20240823055642.27638-1-quic_uaggarwa@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-ORIG-GUID: c4n8LsMcm8ejfNBv0jfF7xUBnhFrEQAB
X-Proofpoint-GUID: c4n8LsMcm8ejfNBv0jfF7xUBnhFrEQAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_03,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230041

Currently in few of Qualcomm chips USB LS mouse not detected
showing following errors:

[ 81.585361] usb 1-1: Device not responding to setup address.
[ 81.798676] usb 1-1: device not accepting address 2, error -71
[ 81.928378] usb 1-1: new low-speed USB device number 3 using xhci-hcd
[ 82.076248] usb 1-1: Device not responding to setup address.
[ 82.290630] usb 1-1: Device not responding to setup address.
[ 82.503877] usb 1-1: device not accepting address 3, error -71
[ 82.512548] usb usb1-port1: attempt power cycle

Based on the Logic analyzer waveforms, It has been identified that
there is skew of about 8nS b/w DP & DM linestate signals
(o/p of PHY & i/p to controller) at the UTMI interface,
Due to this controller is seeing SE0 glitch condition,
this is causing controller to pre-maturely assume that PHY
has sent all the data & is initiating next packet much early,
though in reality PHY is still busy sending previous packets.

Enabling the GUCTL1.FILTER_SE0_FSLS_EOP bit29 allows the controller
to ignore single SE0 glitches on the linestate during transmission.
Only two or more SE0 signals are recognized as a valid EOP.

When this feature is activated, SE0 signals on the linestate
are validated over two consecutive UTMI/ULPI clock edges for EOP detection.

Device mode (FS): If GUCTL1.FILTER_SE0_FSLS_EOP is set,
then for device LPM handshake, the controller ignores single
SE0 glitch on the linestate during transmit. Only two or more
SE0 is considered as a valid EOP on FS port.

Host mode (FS/LS): If GUCTL1.FILTER_SE0_FSLS_EOP is set, then
the controller ignores single SE0 glitch on the linestate during transmit.
Only two or more SE0 is considered as a valid EOP on FS/LS port.

Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---
 drivers/usb/dwc3/core.c | 10 ++++++++++
 drivers/usb/dwc3/core.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3e55838c0001..1edb16d2940c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -194,6 +194,16 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	switch (desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
+
+		/*
+		 * Setting GUCTL1 bit 29 so that controller
+		 * will ignore single SE0 glitch on the linestate
+		 * during transmit.
+		 */
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+		reg |= DWC3_GUCTL1_FILTER_SE0_FSLS_EOP;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e3eea965e57b..73e90daafecf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -271,6 +271,7 @@
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_HS		BIT(16)
 #define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
+#define DWC3_GUCTL1_FILTER_SE0_FSLS_EOP		BIT(29)
 
 /* Global Status Register */
 #define DWC3_GSTS_OTG_IP	BIT(10)
-- 
2.17.1


