Return-Path: <linux-kernel+bounces-369256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8EE9A1AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30DD1C21661
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93FC192B98;
	Thu, 17 Oct 2024 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NvTm1vnq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB57C147;
	Thu, 17 Oct 2024 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147499; cv=none; b=ISOO7Tr9hSbfKnBLkKxFH4b1l464b2LxJX2/ycCb0S5l8YrbmfIsxIjwYVEqH9qltiGfHjiv1WjB4sCX7MoQK9+I+gALDU3TAwqmFiVpPzc85UY+pc7tSTJv16qEpaUuT2wpTc+wHp8ftrrAzTntQ99paH7r4M6iWXEIkO5JjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147499; c=relaxed/simple;
	bh=ihg30lfa0a+XaBMfBkHOOO4M/+4J4jHtLdxkaK1oxQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hibqsDgAwp3LgU0FyUThhm+tpforpHTPxFcqBuf8dvZmhLuN5LT3ir3CFYdc1BjS/S7wEBOpkOZi9Z2lxAiG5VTP3166UKK4NcBDF6Ku6K2Gqa0W7Uh0Hk+9WfuApuTnzBF7jFhdtsu10ZcF6Rb/VYXqhiL818YcJ3BS7UzGm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NvTm1vnq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GIFrYZ001662;
	Thu, 17 Oct 2024 06:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YRpoatqSwReQMcbteYMFPT
	Pa0lxHiED/3hWe40ugtsQ=; b=NvTm1vnqrUuKQ3nAZgkOyICgHx8+mWvOc5U3e5
	8J8Je1Dw8NUuP/eHrsLAnrYVj+iHe8vRyciB7/dBlhVHlDBrsTGwAoEUHk3oC3Q0
	WfEV4eegfhjf5bwzV1uwwGJKL3E/ApwjcH86WpQzZDk+ORST9m0tnC7PBQ+zuabx
	GX/XPA+BbtX+H9kfBy6m+11fv0ahFbTivZS+dJrHxO9Z/5vBAFLSrrqcwAjNPtAS
	c4e7KfeyZqxZa7MhiKlf1+9DqpunZ3A3jICVemWpY0lGbSajNXkq4zTBaM/B2CId
	70CosuTui3yMi1LP6WH1YS7B9hz5swYKvA/wsOM5CM4oinuA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ajm59j5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:44:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49H6ijvC017365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:44:45 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 23:44:39 -0700
From: Akash Kumar <quic_akakum@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi
	<balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>
CC: Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akash Kumar <quic_akakum@quicinc.com>
Subject: [PATCH v7] usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Date: Thu, 17 Oct 2024 12:14:23 +0530
Message-ID: <20241017064423.7056-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2eoUch39tPKt3HUvOw8fRh5U7Zn2Zjaj
X-Proofpoint-ORIG-GUID: 2eoUch39tPKt3HUvOw8fRh5U7Zn2Zjaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170044

The current logic is rigid, setting num_fifos to fixed values.
3 for any maxburst greater than 1.
tx_fifo_resize_max_num for maxburst greater than 6.
Additionally, it did not differentiate much between bulk and
isochronous transfers, applying similar logic to both.

The updated logic is more flexible and specifically designed to meet
the unique requirements of both bulk and isochronous transfers. We
have made every effort to satisfy all needs and requirements, verified
on our specific platform and application.

Bulk Transfers: Ensures that num_fifos is optimized by considering both
the maxburst and DT property "tx-fifo-max-num" for super speed and
above. For high-speed and below bulk endpoints, a 2K TxFIFO allocation
is used to meet efficient data transfer needs, considering
FIFO-constrained platforms.

Isochronous Transfers: Ensures that num_fifos is sufficient by
considering the maximum packet multiplier for HS and below and maxburst
for Super-speed and above eps, along with a constraint with the DT
property "tx-fifo-max-num".

This change aims to optimize the allocation of Tx FIFOs for both bulk
and isochronous endpoints, potentially improving data transfer efficiency
and overall performance. It also enhances support for all use cases,
which can be tweaked with DT parameters and the endpoint’s maxburst and
maxpacket. This structured approach ensures that the appropriate number
of FIFOs is allocated based on the endpoint type and USB speed.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
Changes for v7:
fixed indentations for if checks.

Changes for v6:
The code has been refactored to replace multiple if checks with a
switch-case structure based on the USB speed. This change improves
readability and maintainability by clearly defining behavior for
different USB speeds. This structured approach ensures that the
appropriate number of FIFOs is allocated based on the endpoint
type and USB speed.

Changes for v5:
Update Calculation for HS and below bulk and isoc eps based on
suggestion and fixed at 2k for bulk eps considering fifo constrained
platforms.

Changes for v4:
Updated commit message as per review comments to clarify that it has
been tested on specific platforms only and tried best to match all
expectations.

Changes for v3:
Redefine logic for resizing tx fifos,added check based on  operating
speed and used maxp for HS and maxburst for SS  and defined max allocation
based on dt property.

Changes for v2:
Redefine logic for resizing tx fifos, handled fifo based on  minimum of
maxp and maxburts.

Changes for v1:
Added additional condition to allocate tx fifo for hs isoc  eps, keeping
the other resize logic same
---
 drivers/usb/dwc3/gadget.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 10178e5eda5a..af3d5b2f7b67 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -771,15 +771,30 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
 
-	if ((dep->endpoint.maxburst > 1 &&
-	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		num_fifos = 3;
-
-	if (dep->endpoint.maxburst > 6 &&
-	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
-	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
-		num_fifos = dwc->tx_fifo_resize_max_num;
+	switch (dwc->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			num_fifos = min_t(unsigned int,
+					  dep->endpoint.maxburst,
+					  dwc->tx_fifo_resize_max_num);
+		break;
+	case USB_SPEED_HIGH:
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			num_fifos = min_t(unsigned int,
+					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+					  dwc->tx_fifo_resize_max_num);
+			break;
+		}
+		fallthrough;
+	case USB_SPEED_FULL:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+			num_fifos = 2;
+		break;
+	default:
+		break;
+	}
 
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
-- 
2.17.1


