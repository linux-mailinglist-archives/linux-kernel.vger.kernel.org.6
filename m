Return-Path: <linux-kernel+bounces-313014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D7969F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A81B2116F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C020A1C2437;
	Tue,  3 Sep 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P+cwsVOJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2851C242F;
	Tue,  3 Sep 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370190; cv=none; b=p9qZiIapNb+7/44RCjZBxbmW1pcD65BsoJUbUc2/Xw5CeF2wUaLyxFjoaLEshsLZDmfEM7XJszWAhv3LZym2IZgNZ2vdg135G9xU4emLdCpF/TX2FJj9VeOpJTMKtvCa85uWjSHTS4OoInHvb4aOWVT4/NWQ0Y92Ity/KD8p6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370190; c=relaxed/simple;
	bh=m6PdLgnTXOez5AhkrL0LnfNQVFKTYIvo5+OBwmv4Wkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kB81K4o3q1oOfR2fSIlqjUZFtjGMOhZQSGxM+jjW+vgscLzb37Ovv9ql2YUY1U8ZBwMjsMi+qk/B+fQtofHhCW9zqB5R7xeuWyB31vrf2mZRkeqw/hyveGbV1kFFvYxrYdmIzm4nG6liVy4mJ4wbsRyiI7m4yjSU3ueNyAhOzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P+cwsVOJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Agugb014913;
	Tue, 3 Sep 2024 13:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4NQycEyc125xNTS3TYtmmc
	NjWV6AcYdZJ+XMDcN/R+g=; b=P+cwsVOJ/VT3JyXMf8pFW/Dcb1G+iBItWXWUHs
	tO9a7IE2suIhELGQqEf6csTTqSdJNgakEzBVNsBuNBEavNhxhzS6nx8xi7sYFtfD
	sK4wDQf/CLnQTEYByKoQrpASEDOS31rBdBrVdhsrYolMH6znrBtwLTW4NwPwnbp5
	XtGB5TKiS5aiCO5CiZoPERWzmGFl3QzkuFCdSjtDAfKLIgiFBnmnZR4OKWMnWdkD
	qRvNSa+hD7HVLNZIa0at9E7HncmrhWZOhmdTJz23t5RfDO3BmN7DHrwpXSJtN618
	8CkFPcWqL1SKdXD2QZHuCQ5Tc+Cuk5zL0A4q6WirXPxsEhfQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt66yfkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 13:29:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 483DTdgB021168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 13:29:39 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 06:29:33 -0700
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
Subject: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Date: Tue, 3 Sep 2024 18:59:17 +0530
Message-ID: <20240903132917.603-1-quic_akakum@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KeKLWNqf6DWwYKR1d9WuTfoYBoOiqQpb
X-Proofpoint-GUID: KeKLWNqf6DWwYKR1d9WuTfoYBoOiqQpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030109

The current logic is rigid, setting num_fifos to fixed values:

3 for any maxburst greater than 1.
tx_fifo_resize_max_num for maxburst greater than 6.
Additionally, it did not differentiate much between bulk and
isochronous transfers, applying similar logic to both.

The new logic is more dynamic and tailored to the specific needs of
bulk and isochronous transfers:

Bulk Transfers: Ensures that num_fifos is optimized by considering
both the maxburst value and the maximum allowed number of FIFOs.

Isochronous Transfers: Ensures that num_fifos is sufficient by
considering the maxburst value and the maximum packet multiplier.

This change aims to optimize the allocation of Tx FIFOs for both bulk
and isochronous endpoints, potentially improving data transfer
efficiency and overall performance.
It also enhances support for all use cases, which can be tweaked
with DT parameters and the endpoint’s maxburst and maxpacket.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
Changes for v2:
Redefine logic for resizing tx fifos.

Changes for v1:
Added additional condition to allocate tx fifo for hs isoc eps,
keeping the other resize logic same.
---
 drivers/usb/dwc3/gadget.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..49809a931104 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -778,15 +778,12 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
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
+	if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+		num_fifos = min_t(unsigned int, dep->endpoint.maxburst + 1,
+				  dwc->tx_fifo_resize_max_num);
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		num_fifos = max_t(unsigned int, dep->endpoint.maxburst,
+				  usb_endpoint_maxp_mult(dep->endpoint.desc));
 
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
-- 
2.17.1


