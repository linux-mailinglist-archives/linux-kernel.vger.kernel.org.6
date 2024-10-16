Return-Path: <linux-kernel+bounces-367910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A61A9A0839
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3F81C219F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF92207209;
	Wed, 16 Oct 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fEZ0jHwO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150A15C147;
	Wed, 16 Oct 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077577; cv=none; b=DnDUID4xAQgf0OOD6zPuA8KmOtjKSr6FEfAintZXd4p9ghsiyXyGjqRNZNlW5qBWB44MExqk1KeMssPqveI2qrAFRsALtA72qgEJbOR+Z6fUIGmvAVutPd/O1ZW2V0yoM14P6QhMrK8ZEMkfLRRomOv5oujqBdyEybcPrayco+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077577; c=relaxed/simple;
	bh=FVtPvUPf+eIervD2QjqfFImVj/2vV5aXuTQ4YdK4MKY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udbpgkoPYqKLpp1bvU+fYqTMxebIteLmUU3Jd9ge7VmlMe9UQFtdI+OQZr8eoUZdaS2htUP4dwbH/HDwfaRFUyRN/bvcmb/NUj7iMIo9+0IFnMdeyNAXPEip92BUvjJbt+eSegULsVE4m5V6Qs1ba2MdUWtXMgk/Z/RAmbtBK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fEZ0jHwO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GAIHZw011617;
	Wed, 16 Oct 2024 11:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qMP0Mu8JZbyT1a4ltNfBCk
	sjG5mXh/8pQFvUu3S9POs=; b=fEZ0jHwOPCfFzHkhHqe4D8l+cdJ+qXtUbv5HDh
	53hVnWZJcT/cJaCSmEMD7iv80jleYJXOO4kx7TQaDnGk8Ju4RjRtv/a5TnaYjHhG
	x8yyMA5wYKYWbL/W+GxtqBeJg9wb2Q0WhqySYXy2aVjuWYMNz6vDcA6SiAO6/lQf
	8aijaAMyAXXSuMDEYuMk5/L8vISLElDIGAZriYiQPF49XwO/equEA7zxEs+B16C4
	JVqyRAk1o2F6dNi/dvaAOtjBHLcaw2Fgin/iDYqky3CebboM/aySE58dGmWlUHEV
	IDfuokQDeM61tM6zOtkqXA/Vx+XJpVFI72pJl8Cn2xE6CXqw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abm5g5c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:19:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GBJQw5003553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:19:26 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Oct 2024 04:19:18 -0700
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
Subject: [PATCH v6] usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Date: Wed, 16 Oct 2024 16:49:04 +0530
Message-ID: <20241016111904.11375-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qIIjMZ7WK2Q7GbA-_AmQiRXRQUIEj6KM
X-Proofpoint-GUID: qIIjMZ7WK2Q7GbA-_AmQiRXRQUIEj6KM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160070

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
Changes for v6:
The code has been refactored to replace multiple if checks with a
switch-case structure based on the USB speed. This change improves
readability and maintainability by clearly defining behavior for
different USB speeds. This structured approach ensures that the
appropriate number of FIFOs is allocated based on the endpoint type
and USB speed.

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
speed and used maxp for HS and maxburst for SS  and defined max
allocation based on dt property.

Changes for v2:
Redefine logic for resizing tx fifos, handled fifo based on  minimum
of maxp and maxburts.

Changes for v1:
Added additional condition to allocate tx fifo for hs isoc  eps,
keeping the other resize logic same
---
 drivers/usb/dwc3/gadget.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 10178e5eda5a..dc62d0626e53 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -771,15 +771,30 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
 
-	if ((dep->endpoint.maxburst > 1 &&
-	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
+	switch (dwc->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
 	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		num_fifos = 3;
-
-	if (dep->endpoint.maxburst > 6 &&
-	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
-	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
-		num_fifos = dwc->tx_fifo_resize_max_num;
+		num_fifos = min_t(unsigned int,
+				  dep->endpoint.maxburst,
+				  dwc->tx_fifo_resize_max_num);
+		break;
+	case USB_SPEED_HIGH:
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		num_fifos = min_t(unsigned int,
+				  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+				  dwc->tx_fifo_resize_max_num);
+		break;
+	}
+		fallthrough;
+	case USB_SPEED_FULL:
+	if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+		num_fifos = 2;
+		break;
+	default:
+		break;
+	}
 
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
-- 
2.17.1


