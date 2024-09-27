Return-Path: <linux-kernel+bounces-342153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFA5988B08
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4245A1C231E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C181C245F;
	Fri, 27 Sep 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OZhhuBD+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF51474B5;
	Fri, 27 Sep 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467309; cv=none; b=PevSOg1sQIJn81HRxVvpGG5HkrybMCteFTfe+kOpgzDj6iIYPkdpBrWVKLbOKHlqg9A9/yo5u93md051KAbleoghjFqVelEYFbCA+ksPCNThzwVPvc29jytqLb11lxJ5JGahBgjiCTzaMlDyY/iRWq7PkFwAATg2L18J7CeEwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467309; c=relaxed/simple;
	bh=11FvQvVXpaqDbgp/b53D1t2JXve7XhlDytqm6uJ6IoA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TKvCCrGMkT1wTNwVn+Fyv2EeEJUahcLPHr+mi2dDs9V0LtEzQ3SCOojhA23eR572tiRV9HnCCOV8eKaNSrSZ+g7wGCaTYfYt9Jg8vkWwtGYsph149/vxBcDx1se6sGDNxyRcjMysjmwOSYzm03UcvIEy54Nct2LJhyyolisWZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OZhhuBD+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RGaE1S026541;
	Fri, 27 Sep 2024 20:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nhINB1xMacCu66SjMnFSJo
	NBhLUvyaCk83CZgr3I6+g=; b=OZhhuBD+mh0ZfLjON8dBCtBkFy3VhMQZePgu+C
	EG5HR0RtIlHt9XZON3nYkWQDDlt7s4q6kYStynF8Q2/ckLzhD+WfseDN+IEfWsMC
	gZ04fdwpZdawBvPG1+F8m0DoiXHuEhyRVwI3sL0BKP/VFWfFkX0Ye988gAZao5Ow
	8bj3PgtrMTUXRxFLEPlUvX8vWFJKxxMZQkKQvSQmP0yeX59ppHJLEctTnfkNgz0L
	E/sHjS82wjas12QN0IzeslD1ZaEn0WJxFE7V71FGrGhChXE32Qj5vXDGanDzJyqE
	00eeXdS20T9fSGLl8vjmvmEWdWbIExVCF1BmFKfvKYzC2IjA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn5c44js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 20:00:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RK0T09010834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 20:00:29 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 13:00:21 -0700
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
Subject: [PATCH v5] usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Date: Sat, 28 Sep 2024 01:29:31 +0530
Message-ID: <20240927195931.10404-1-quic_akakum@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QQToKkZCANCB7g-XiZKU0QXItQbvwbVG
X-Proofpoint-GUID: QQToKkZCANCB7g-XiZKU0QXItQbvwbVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270146

The current logic is rigid, setting num_fifos to fixed values.
3 for any maxburst greater than 1.
tx_fifo_resize_max_num for maxburst greater than 6.
Additionally, it did not differentiate much between bulk and
isochronous transfers, applying similar logic to both.

The updated logic is more flexible and specifically designed to meet
the unique requirements of both bulk and isochronous transfers. We
have made every effort to satisfy all needs and requirements,
verified on our specific platform and application.

The updated logic is more flexible and specifically designed to meet
the unique requirements of both bulk and isochronous transfers. We
have made every effort to satisfy all needs and requirements, verified
on our specific platform and application.

Bulk Transfers: Ensures that num_fifos is optimized by considering both
the maxburst and DT property tx_fifo_resize_max_num for super speed and
above. For high-speed and below bulk endpoints, a 2K TxFIFO allocation
is used to meet efficient data transfer needs, considering
FIFO-constrained platforms.

Isochronous Transfers: Ensures that num_fifos is sufficient by considering
the maximum packet multiplier for HS and maxburst for SS, along with a
constraint with the DT property tx_fifo_resize_max_num.

This change aims to optimize the allocation of Tx FIFOs for both bulk
and isochronous endpoints, potentially improving data transfer efficiency
and overall performance. It also enhances support for all use cases,
which can be tweaked with DT parameters and the endpoint’s maxburst and
maxpacket.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
Changes for v5:
Update Calculation for HS and below bulk and isoc eps based on
suggestion and fixed at 2k for bulk eps considering fifo
constrained platforms.

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
keeping the other resize logic same.
---
 drivers/usb/dwc3/gadget.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 291bc549935b..035d49155d57 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -771,15 +771,21 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
 
-	if ((dep->endpoint.maxburst > 1 &&
-	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		num_fifos = 3;
+	if (dwc->gadget->speed <= USB_SPEED_HIGH) {
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+			num_fifos = 2;
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			num_fifos = min_t(unsigned int,
+					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+					  dwc->tx_fifo_resize_max_num);
+	}
 
-	if (dep->endpoint.maxburst > 6 &&
+	if (dwc->gadget->speed > USB_SPEED_HIGH &&
 	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
-	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
-		num_fifos = dwc->tx_fifo_resize_max_num;
+	     usb_endpoint_xfer_isoc(dep->endpoint.desc)))
+		num_fifos = min_t(unsigned int,
+				  dep->endpoint.maxburst,
+				  dwc->tx_fifo_resize_max_num);
 
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
-- 
2.17.1


