Return-Path: <linux-kernel+bounces-425844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910489DEBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFCC162C61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E219DF60;
	Fri, 29 Nov 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mwRbVJr7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326884087C;
	Fri, 29 Nov 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732901680; cv=none; b=ItMru7DHJPG1w2gpdVvgX/uqe391JifctJJfSFtyTQEmCRPLU54p81/dmtOIKP2oxP3crrFvMjOB5hwArxq6hb00Iz8UrN4LLrz4MqVUryAMloRv0XexwPkIq8GpxkV+QouM445pIlGfgOy4Mi8UgFYLdeXlpFL5PVaUkjeOev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732901680; c=relaxed/simple;
	bh=9ucjFOki5t2dl3XP4182L7N5dbkGMTm+yBRb4xbUR0g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSafNPRU+PmY9wtY3VdffmX+MFCsy2xLe6hBY4HMloNAr6lcpW0FX17RgZ1FjJNDUCyzT6ZN+4mCLOUsP1i3CtwdT+GlX/evxg1C22zhrgeamdgHIGpXvpJStYuu8b+SOczNL8D6DoZBxMSAdmpiaasdVj8+e0JDKZXo4w5r7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mwRbVJr7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATD6cUY016964;
	Fri, 29 Nov 2024 17:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=licW8m9ilwQfOCKroTCpcgSBkS1e2umVlZlG9DGK25c=; b=mw
	RbVJr7GRwKEbWsnu0V4g9AuzsyPs6Y4SgtdewQKIsuhI/Bqj4uvHjwodYPzGeyYs
	ZtHITQAD13R8/1PdbzDabS2RjVBxdlXh3iAIDmODp0PnoY49prfDGswqG0J9fIi7
	TZNn2ievgIqpt5+zdEh1tHR2K1dSqL7FQRYPkZ8mD79+P1Cz8ZeZMQc15JwE/xjl
	ZAwFLxeuNeLt+YZTeUT5li5GGhK+QqeU3HUsUF32clVRtqXYz4OTvStnfGY/exE1
	ixFiOJU8a3D1MDZ9WbCL4FX1GPiL2fdUBYcX3HTwYODVlIqffAr3vPJSSbpLSc0H
	I+tztjHemYj0ulQZ6mrg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43671ee46s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 17:34:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ATHYYuv030802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 17:34:34 GMT
Received: from hu-faisalh-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 29 Nov 2024 09:34:32 -0800
From: Faisal Hassan <quic_faisalh@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Faisal Hassan
	<quic_faisalh@quicinc.com>
Subject: [PATCH] usb: dwc3: core: Disable USB2 retry for DWC_usb31 1.80a and prior
Date: Fri, 29 Nov 2024 23:04:22 +0530
Message-ID: <20241129173422.20063-1-quic_faisalh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: aUoYrDxq0GxLUNERlXstiYSgFWafhNzW
X-Proofpoint-GUID: aUoYrDxq0GxLUNERlXstiYSgFWafhNzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=953
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411290141

STAR 9001346572 addresses a USB 2.0 endpoint blocking issue in host mode
for controller versions DWC_usb31 1.70a and 1.80a. This issue affects
devices on both high-speed and full-speed bus instances. When all
endpoint caches are filled and a single active endpoint receives
continuous NAK responses, data transfers to other endpoints may get
blocked.

To resolve this, for controller versions DWC_usb31 1.70a and 1.80a, the
GUCTL3 bit[16] (USB2.0 Internal Retry Disable) is set to 1. This bit
disables the USB2.0 internal retry feature and ensures proper eviction
handling in the host controller endpoind cache. The GUCTL3[16] register
function is available only from DWC_usb31 version 1.70a.

Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>
---
 drivers/usb/dwc3/core.c | 20 ++++++++++++++++++++
 drivers/usb/dwc3/core.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 98114c2827c0..c5c36134ddd9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1475,6 +1475,26 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
 	}
 
+	/*
+	 * STAR 9001346572: This issue affects DWC_usb31 versions 1.80a and
+	 * prior. When an active endpoint not currently cached in the host
+	 * controller is chosen to be cached to the same index as an endpoint
+	 * receiving NAKs, the endpoint receiving NAKs enters continuous
+	 * retry mode. This prevents it from being evicted from the host
+	 * controller cache, blocking the new endpoint from being cached and
+	 * serviced.
+	 *
+	 * To resolve this, for controller versions 1.70a and 1.80a, set the
+	 * GUCTL3 bit[16] (USB2.0 Internal Retry Disable) to 1. This bit
+	 * disables the USB2.0 internal retry feature. The GUCTL3[16] register
+	 * function is available only from version 1.70a.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC31, 170A, 180A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
+		reg |= DWC3_GUCTL3_USB20_RETRY_DISABLE;
+		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
+	}
+
 	return 0;
 
 err_power_off_phy:
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eab81dfdcc35..5417058c5943 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -425,6 +425,7 @@
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
+#define DWC3_GUCTL3_USB20_RETRY_DISABLE		BIT(16)
 
 /* Device Configuration Register */
 #define DWC3_DCFG_NUMLANES(n)	(((n) & 0x3) << 30) /* DWC_usb32 only */
-- 
2.17.1


