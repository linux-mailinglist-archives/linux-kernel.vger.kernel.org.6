Return-Path: <linux-kernel+bounces-369697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7549A2148
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC2E1C215E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A31DD0EA;
	Thu, 17 Oct 2024 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Mbnd9BNE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9B1DA619;
	Thu, 17 Oct 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165277; cv=none; b=ieB9/AjeF+RdydKHL3W55QmVHjqsXFhSRd5X03oeprGkvMiYBObUGv+5bQb8pB210+WDo0nMac4AX6At7JbgTiecbNNwODvDeYKcPvnHJNYL3kfWq7+kAUf4MWXA1vyfAXC86VeDgf4MjHhpbwNxb2f8XiaKv0ftze3rMCxxHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165277; c=relaxed/simple;
	bh=JUTOHC7oZchUoyGlIeIQfiHyFCXZ7MguzflTQzHOcGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XgjFiAGR0KDbNLM3OehUBTEJtI9Jd3RIOrc5TsMsCAPyfdpuSEB47CGe5lqAly1+4PH8nlsTx4nvbPvWGrNhIRPOcTpcn8lCUt3dKhGjT6lD2UAcEKmu/QDRZBnB/p2KqrAJZKQ8MCp/GaIhph0MzkCXM/JYuvagGbIt3nceCAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Mbnd9BNE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H3GKjZ007525;
	Thu, 17 Oct 2024 11:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=h8IstpSGptQbHBaHeZzGDDYS4d6etOnMr9ZjcDunz88=; b=Mb
	nd9BNEEp/d/sbMXgZ9PCIl6s7WMmrMHFKJibHoNEZ925oYVevUVMzrdtzRigh42q
	DRjn3q40ZTjIHJWys5CkKwx3MFrOGiHPfwgLn/YdjhUzoquv9ffCbS/enNh1LjJJ
	UqTkI85WXtIa9jZhzw7iCLLEV2xVwwW45vnV2yQ0zBQ/NXzhDDEseJMAOzSQvhCK
	DbJ6eFSR3VS2JeM9VVlhb024GfG8ZpYCclZeqjX7BytAkZ+vUXrQ4XJfkMTcLRcs
	LZqgdFHSQMLjHWWOS3Bnrbxj0Zhcw5z2/9V0S5gbWkSKKpOoRoYggM99huYK9Vaz
	KVZplpi2sONxKq6+V3HA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42athc18vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 11:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HBf8ki006189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 11:41:08 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 04:41:04 -0700
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
Subject: [PATCH v2 0/2] Add support to ignore single SE0 glitches
Date: Thu, 17 Oct 2024 17:10:53 +0530
Message-ID: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
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
X-Proofpoint-GUID: 69v6MbNwFKRVf2rwcvJLPc5iR7TV7cma
X-Proofpoint-ORIG-GUID: 69v6MbNwFKRVf2rwcvJLPc5iR7TV7cma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 mlxlogscore=893 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

DT patch will be sent separately.

Changes in v2:
Included bindings update for the quirk.
Updated commit text for core patch.

Link to v1:
https://lore.kernel.org/all/20240823055642.27638-1-quic_uaggarwa@quicinc.com/

Uttkarsh Aggarwal (2):
  dt-bindings: usb: snps,dwc3: Add snps,filter-se0-fsls-eop quirk
  usb: dwc3: core: Add support to ignore single SE0 glitches

 .../devicetree/bindings/usb/snps,dwc3.yaml          |  6 ++++++
 drivers/usb/dwc3/core.c                             | 13 +++++++++++++
 drivers/usb/dwc3/core.h                             |  4 ++++
 3 files changed, 23 insertions(+)

-- 
2.17.1


