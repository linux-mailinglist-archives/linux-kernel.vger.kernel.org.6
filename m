Return-Path: <linux-kernel+bounces-369699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD139A2151
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC51F25198
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97431D9A63;
	Thu, 17 Oct 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SI6hFtvn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5B1DD523;
	Thu, 17 Oct 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165288; cv=none; b=HraZ/h8A7z9SLjMTeYqryt0/gFZdER6c6JvPu45Wvil6eJT8Nn01EaH8knrvfYY4jpHK54SkvO9Vh8a61fZtweMg6I5JAPAVV+UlDUMynMm22q2/HBsTX9ycUduKuQl9VtbLqngtcjfr0EAq13XAqt4uTP/TfrNF5/zjZu7JiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165288; c=relaxed/simple;
	bh=gTB/I1yIrmxfrwS4Lmr9UCzhBZN1hbqmQdeYRMvAFOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWupIVjFwyBuV8jpM6PlUWx/KMapjgjpGsIkmvIgdeBLdbLyL40OgXTYEXqkOBnanDu9c0wz3fmcxjQ++eNDHw5wPVNUqGWv/u9l3DYRNXK2k+l2tXP2d8MtU977k9TRdLFjuatXB0AvLgJzCj634IJmGwnhiXZx93uDlS6kvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SI6hFtvn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8vt7s011199;
	Thu, 17 Oct 2024 11:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KKTgqoSqQSfHGYkfrHbSB/+T
	55XsMPAz2RMALrOtQy8=; b=SI6hFtvnTHJmZrW+bKoEu6v/a9yw+ovYAT/ycDo0
	EAj3dQSyjpfEq+W7WmxQ6LVzn4vUwA0PNooPX0u0GoaDk7o9tl68PCM8PCSosqZO
	NyXQu3XaoK2bdcv9yeF2AoaQWWz6yOza4eKge1qLQXMWKDQiOn8guIyqZmRjLw5k
	iY02onpxrS95ZaZ4rtqek1fp5NQLsyq8X/iPWhKR0hIVtyazt2+ezaxDxkeFcZ/0
	1MI5sxUt1gvPvU9pqEWEvAFgVIUhAPk/YDn0xS4ezS/fwQEcBDF4YrTO9gi69LaN
	lVlLHtqM0J2JZeYWVyo2uG4SYkG+/dgs+T0iAqfIOxVm2Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abm5kvcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 11:41:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HBfGiV027898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 11:41:16 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 04:41:13 -0700
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
Subject: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Add snps,filter-se0-fsls-eop quirk
Date: Thu, 17 Oct 2024 17:10:54 +0530
Message-ID: <20241017114055.13971-2-quic_uaggarwa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xKCJljY5cY7qM0L65KI_Ii2buniblwQw
X-Proofpoint-GUID: xKCJljY5cY7qM0L65KI_Ii2buniblwQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=732 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170079

Adding a new 'snps,filter-se0-fsls-eop quirk' DT quirk to dwc3 core to set
GUCTL1 BIT 29. When set, controller will ignore single SE0 glitch on the
linestate during transmission. Only two or more SE0 is considered as
valid EOP on FS/LS port. This bit is applicable only in FS in device mode
and FS/LS mode of operation in host mode.

Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d..d9e813bbcd80 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -180,6 +180,12 @@ properties:
     description: When set core will set Tx de-emphasis value
     type: boolean
 
+  snps,filter-se0-fsls-eop-quirk:
+    description:
+      When set controller will ignore single SE0 glitch on the linestate during transmit
+      Only two or more SE0 is considered as a valid EOP on FS/LS port.
+    type: boolean
+
   snps,tx_de_emphasis:
     description:
       The value driven to the PHY is controlled by the LTSSM during USB3
-- 
2.17.1


