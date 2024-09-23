Return-Path: <linux-kernel+bounces-336302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E497F1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2481F21689
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EE823A9;
	Mon, 23 Sep 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XbTf040/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0ED745CB;
	Mon, 23 Sep 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125571; cv=none; b=ZHiqqsfI0j2v+51UKBY3pxS2JI2yluz2lvYp6wOhZxEgWMZDVg+5JeflbwZhG7s37+T8osz+ZjSJ9iFQmURSZAy1Ct30pK4giHlOLIOEarJ1gyg+nS7nAbHVI6Gq3YV0/Ei1G2QACB6lXZH96KjBNtjyKymwi/ppCL+jg2fGqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125571; c=relaxed/simple;
	bh=eabuGpc9lJSR0DmVtyg4ARIl188TuwVM/U5Ghf2HoHk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=myyr/6UFUMHYcO6VtYU+z7B2SXtAfxYFr9z4tQD4aSlNe7XOHJXKvnIkmP9wVuVasQDig8r1ce0iCDvaAvgnTWmy4SISgSYAl3tae7Mlgm7wvojURdJESyMAL/ebXM4uL3ku7JgZr1NpZHWut4CbhSJ0AwfB43u/UUkZnq8OiHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XbTf040/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NBAa5u021675;
	Mon, 23 Sep 2024 21:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d1hdjZMy6xqWYWjqV9RKcK
	PSdh5HRKCt0MPkZEhtFeU=; b=XbTf040/XGuYmpbr6TLh1PgugSq26ulPLcgbeo
	xAX17rV+F8FWks1Zg8vaQYhX/kVOjUAnTdNZFv9I8R0uXqPNUZ9ab9sGW4V+abKg
	6hqFJ+ls4NmXS5HISt97wSjrHKfdFsFl2I8kzOrD2KflIK/D0bbgfYW3UtFzpf+O
	zCWIgQ5MgiWB0hB+XC5Yt7a1QCrJkvaLHM3BTZljf3q4yWdU7HewtebAIUR587J2
	oZy2ue4qTf2eMpwzdTeaXGy7BIb45ciEb4J1cD7pKREzRBNI6/gn4Ru8CnkBl8MP
	L+kRJoe7fFWNw3ilNd9KTH8bD6nWfKMt7qt9i+QKmq8tYDmw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sp7ueb5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 21:05:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48NL5nre005793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 21:05:49 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Sep 2024 14:05:41 -0700
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
Subject: [PATCH v4] usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Date: Tue, 24 Sep 2024 02:35:30 +0530
Message-ID: <20240923210530.30264-1-quic_akakum@quicinc.com>
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
X-Proofpoint-GUID: CH_SN0LjgM59uIGeD6-wJYLbleKVOkQa
X-Proofpoint-ORIG-GUID: CH_SN0LjgM59uIGeD6-wJYLbleKVOkQa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409230151

The current logic is rigid, setting num_fifos to fixed values:

3 for any maxburst greater than 1.
tx_fifo_resize_max_num for maxburst greater than 6.
Additionally, it did not differentiate much between bulk and
isochronous transfers, applying similar logic to both.

The updated logic is more flexible and specifically designed to meet
the unique requirements of both bulk and isochronous transfers. We
have made every effort to satisfy all needs and requirements, but
please note that this has only been verified on our specific platform
and application.

Bulk Transfers: Ensures that num_fifos is optimized by considering
both the maxburst value and the maximum allowed number of FIFOs
based on the DT property tx_fifo_resize_max_num and the maximum
packet multiplier for HS.

Isochronous Transfers: Ensures that num_fifos is sufficient by
considering the maximum packet multiplier for HS and maxburst for SS,
along with a constraint with the DT property tx_fifo_resize_max_num.

This change aims to optimize the allocation of Tx FIFOs for both bulk
and isochronous endpoints, potentially improving data transfer
efficiency and overall performance. It also enhances support for all
use cases, which can be tweaked with DT parameters and the
endpoint’s maxburst and maxpacket.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
Changes for v4:
Updated commit message as per review comments to clarify that it
has been tested on specific platforms only and tried best to
match all expectations.

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
 drivers/usb/dwc3/gadget.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..7557bd0053a7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -778,15 +778,19 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
 
-	if ((dep->endpoint.maxburst > 1 &&
-	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		num_fifos = 3;
+	if (dwc->gadget->speed <= USB_SPEED_HIGH &&
+	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+	     usb_endpoint_xfer_isoc(dep->endpoint.desc)))
+		num_fifos = min_t(unsigned int,
+				  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+				  dwc->tx_fifo_resize_max_num);
 
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


