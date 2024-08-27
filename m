Return-Path: <linux-kernel+bounces-302626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC996012C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662242811AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C17D1386C6;
	Tue, 27 Aug 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VRrrEHZm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE6C13D;
	Tue, 27 Aug 2024 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724737835; cv=none; b=VT3pIrOM3WV1BN/+pnK5+7slhg6+Dj9VzUij1vcYS/0nVEdYr6wPOKrsB5Eh08QbBbGH+Zvscfd3vvXfru3mzEDfI0ypr5046ax6zPLjnqAgNlvCvorowmpHGuN1O0gMUaN0Plg9ve+68QC4OeIDXoSVBfuG/HxD8bojqmKzDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724737835; c=relaxed/simple;
	bh=Id5ibrNXsxdWUWMoeaWn5ewrkhVAGe6v0pmUZe73mWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=npWGy73MWWLyu1XUxucl9f/eOGNS2BlhEtI63ZnXOe0r6J5RGdSadBEW+vGQ5HiQtf2bUDeax5CwnimEYenfygKwOU21MbExk5Q98Q7/kbxx9/os2RpAnmAfsciKZPPYtv0mpJ5nMJntIrw1uzoF7mkJEFKaPBazqeQK0JWSCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VRrrEHZm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGdRh001576;
	Tue, 27 Aug 2024 05:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=UQ3fXOtrIT786AaZns6SDYL5Hql1H9mlHZ+MPHuXOFY=; b=VR
	rrEHZm3e/++6c+VYW8asYcQFgN9HtjJzg2zWd4FkftQZDeP9FGxdoyxKY0n5F1Xz
	Jek/AlraKgeiV4LWUe9SpbCJgXREnLtIuUBnH4K0rg/6/+CGe9rjf5olkbweZcxD
	e6/9Q+0r2uv+DIVXxNknreXecKJus1px/Ujv1SOHq+edPVaFok6yhL/mLm91tJmh
	DWSieaGHt47d8H896Y3waXCGPshDzCRIY0p5oiEFyr/9/HGeLMdxgi3j7AfGIN4o
	I3Bo5Ui2bW1hpJX+l82+tAafSIViE7iNtrhuCFulOECMGstq4lTWu1mQzGO3OM2S
	8FIyj4qEvXz9mfEduu8w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179anwvks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:50:25 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R5oEu8020538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:50:14 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 22:50:06 -0700
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
Subject: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC endpoints
Date: Tue, 27 Aug 2024 11:19:56 +0530
Message-ID: <20240827054956.28241-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a2S5Bfn-clyQKzQbQR3jugW-HAeVuRlm
X-Proofpoint-ORIG-GUID: a2S5Bfn-clyQKzQbQR3jugW-HAeVuRlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=669 clxscore=1011 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270042

Use 2K TX FIFO size for low-resolution UVC cameras to support the
maximum possible UVC instances. Restrict 2K TX FIFO size based on
the minimum maxburst required to run low-resolution UVC cameras.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..f342ccda6705 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -788,6 +788,10 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
 		num_fifos = dwc->tx_fifo_resize_max_num;
 
+	if (dep->endpoint.maxburst <= 1 &&
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		num_fifos = 2;
+
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
 
-- 
2.17.1


