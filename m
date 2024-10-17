Return-Path: <linux-kernel+bounces-369700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695A9A2155
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DF82892D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CBD1DDC10;
	Thu, 17 Oct 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C7QGnwM3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928281DDA20;
	Thu, 17 Oct 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165293; cv=none; b=ezIFKIn1gHvd4iMHM7yUbBSJa6QJdFFvtrACZur8MwiYzRpDcbgMMgN4sCjUiGej5BjIUuNFbIOUhfYpOrJLRkj5knA2KbSarULwDQ+jTFtHXWE/QkVQfcbFA88Q/7bgZkbSur4LeETSwAm5ui5c8Jrbp6/PBhRGEL2BBUSVAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165293; c=relaxed/simple;
	bh=YsKHWDsdtdJrPiLIWWsmq7J79lvjBsnTcX0IPMSDzPM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqS0gA7wucZLGvPsKxahu7u1I2sDbZJBPSfxnh6aIJyNTS+rvy8PfzvyPe+2NjGVJ0BRGIwTUBuSvjS/Km834kuYahyOpYqdzCkEkTmjF0G/NS8M9XTqH6j1IulvfLvT59eONaPEKNAe/lWXUEu5jYVv1KztLqXIxUxeEd6ZBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C7QGnwM3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8cbA5027144;
	Thu, 17 Oct 2024 11:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZL+2g8XG4c27RmEa1CMpke6x
	7p9QgJBfJS5qL6dbLso=; b=C7QGnwM3aU4vhl+KdaoG6YBggKhP3wpziRzNoLov
	wc5Rf6Iu5ujnXPj7o+3iPUBjYTNc/YSs/mS9qjdyP1amKLtMlpoMeoyJhfVeD6BX
	UCZGUngRrks/06Vzfn5NOl4PIpNyq2EkRzKd0ev/dOyb1QNEqwSutOYGOq0a3y4Z
	KenA2CQV52husfOQjyH4MlOWuHmdXPkstrbedxWfHQpmloRGGRPKy0azBxFCZqyk
	hFoVWxpnDi1g6xenuzRzCyAwSjsLFFNeGb6fywPB9QeE4fC+5Ut0GuR6W+F/ID3N
	8OaHySVF63LcP0Xk4AMF1QDqgh3s0SIjt7I/6xQ3muhIKw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ay8j8fux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 11:41:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HBfMGs007278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 11:41:22 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 04:41:19 -0700
From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>,
        Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
Subject: [PATCH v2 2/2] usb: dwc3: core: Add support to ignore single SE0 glitches
Date: Thu, 17 Oct 2024 17:10:55 +0530
Message-ID: <20241017114055.13971-3-quic_uaggarwa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
References: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
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
X-Proofpoint-GUID: 25b_0Cl65OBiCRbmF0CouGyXAeWJuac-
X-Proofpoint-ORIG-GUID: 25b_0Cl65OBiCRbmF0CouGyXAeWJuac-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=984 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170079

Currently in few of Qualcomm chips USB (Low speed) mouse not
detected showing following errors:

  usb 1-1: Device not responding to setup address.
  usb 1-1: device not accepting address 2, error -71
  usb 1-1: new low-speed USB device number 3 using xhci-hcd
  usb 1-1: Device not responding to setup address.
  usb 1-1: Device not responding to setup address.
  usb 1-1: device not accepting address 3, error -71
  usb usb1-port1: attempt power cycle

Based on the Logic analyzer waveforms, It has been identified that there
is skew of about 8nS b/w DP & DM linestate signals (o/p of PHY & i/p to
controller) at the UTMI interface, Due to this controller is seeing SE0
glitch condition, this is causing controller to pre-maturely assume that
PHY has sent all the data & is initiating next packet much early, though
in reality PHY is still busy sending previous packets.

Enabling the GUCTL1.FILTER_SE0_FSLS_EOP bit29 allows the controller to
ignore single SE0 glitches on the linestate during transmission. Only two
or more SE0 signals are recognized as a valid EOP.

When this feature is activated, SE0 signals on the linestate are validated
over two consecutive UTMI/ULPI clock edges for EOP detection.

Device mode (FS): If GUCTL1.FILTER_SE0_FSLS_EOP is set, then for device LPM
handshake, the controller ignores single SE0 glitch on the linestate during
transmit. Only two or more SE0 is considered as a valid EOP on FS port.

Host mode (FS/LS): If GUCTL1.FILTER_SE0_FSLS_EOP is set, then the controller
ignores single SE0 glitch on the linestate during transmit.

Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---
 drivers/usb/dwc3/core.c | 13 +++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 86b37881aab4..4edd32c44e73 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -222,6 +222,17 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	switch (desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
+	       /*
+		* Setting GUCTL1 bit 29 so that controller
+		* will ignore single SE0 glitch on the linestate
+		* during transmit.
+		*/
+		if (dwc->filter_se0_fsls_eop_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+			reg |= DWC3_GUCTL1_FILTER_SE0_FSLS_EOP;
+			dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+		}
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
@@ -1788,6 +1799,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
+	dwc->filter_se0_fsls_eop_quirk = device_property_read_bool(dev,
+				"snps,filter-se0-fsls-eop-quirk");
 	device_property_read_u8(dev, "snps,tx_de_emphasis",
 				&tx_de_emphasis);
 	device_property_read_string(dev, "snps,hsphy_interface",
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index cc3f32acfaf5..33d53a436fd7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -276,6 +276,7 @@
 
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
+#define DWC3_GUCTL1_FILTER_SE0_FSLS_EOP		BIT(29)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
@@ -1140,6 +1141,8 @@ struct dwc3_scratchpad_array {
  * @gfladj_refclk_lpm_sel: set if we need to enable SOF/ITP counter
  *                          running based on ref_clk
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
+ * @filter_se0_fsls_eop_quirk: set to ignores single
+ *				SE0 glitch on the linestate during transmit.
  * @tx_de_emphasis: Tx de-emphasis value
  *	0	- -6dB de-emphasis
  *	1	- -3.5dB de-emphasis
@@ -1373,6 +1376,7 @@ struct dwc3 {
 	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
+	unsigned		filter_se0_fsls_eop_quirk:1;
 	unsigned		tx_de_emphasis:2;
 
 	unsigned		dis_metastability_quirk:1;
-- 
2.17.1


