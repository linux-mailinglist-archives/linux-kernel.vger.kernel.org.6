Return-Path: <linux-kernel+bounces-331584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4DE97AE88
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBD71C21D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7B165F0C;
	Tue, 17 Sep 2024 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DZzD+XD5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8120323;
	Tue, 17 Sep 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568062; cv=none; b=llKvWBVQVqK5Houj43iKyQC+5oPjXX+M4JJ+tz3X0MoQMKviro+qGaU3syklnR0M3rD1kHipVZf8DLwVPH09V2wTyHgn60iZQ591m4UYFXfA8AW+QB1XiQN5rRBlvNaVJ+rsCAYdaPYnRzU2r/9jmrd2WGq2mTEJWRJFv8AE+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568062; c=relaxed/simple;
	bh=6D4S999Nnxi0r3tu7/o4AjVIMG0y9Zam5kzWfkgR+PA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZWJWDqAQXgZW++u1m+kHzqhleVRRbSPnCGVZvLc0jrr6eqEv1/j9eILwlDShkDChBOPcKNGddcPQd1X1a+Vyj34pq0lpTBhZC34DLdiLDqY7oc/hJrskFoup//0nlX6XusEnsBE1rrkMdUUGxdqHOGBhTxOBQKIg9xEnFASgGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DZzD+XD5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H6N5wx010049;
	Tue, 17 Sep 2024 10:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Q2hyy08txf3PgeLa/vwjP0
	4RLvzJlwXDq1iftDTDDHQ=; b=DZzD+XD5XWiLv8DdLnVs3s3hD7Psl5aCcnh47T
	9g/kWiqDd3CY3HppQfBZ2h/2ZrBPYMjO1k4HoUHaOpo7wBuz59veOwHPoeZT891C
	AUPirAKzR0Z/5eiJiz+aTwN+zJJySipuvf+L+jDxLCGIQ1+zO4sTBOBRJFpQneiC
	6/nhkfkU9DA5Zo7WmGUt0Ht0Yl3NF0cjADvUR3qRDiO2ItpFm1RPqsdZzT3HpSbg
	BCfpnADwwQTDSjZV2S0xDX84BCNLi5kIYQ6l9qHLl79yKpFf2MwaDqNbZzmPwqOB
	WIAD3Fq0/mLIGlHZssRoz7f+Q3752AgAW2zARtmnnlu5Gaug==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdpfym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 10:14:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HAECOe001275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 10:14:12 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Sep 2024 03:14:05 -0700
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
Subject: [PATCH v3] usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
Date: Tue, 17 Sep 2024 15:43:55 +0530
Message-ID: <20240917101355.15580-1-quic_akakum@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zEv5BUY6L3AdlikcuWGM6GiR7p2004C4
X-Proofpoint-GUID: zEv5BUY6L3AdlikcuWGM6GiR7p2004C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170074

The current logic is rigid, setting num_fifos to fixed values:

3 for any maxburst greater than 1.
tx_fifo_resize_max_num for maxburst greater than 6.
Additionally, it did not differentiate much between bulk and
isochronous transfers, applying similar logic to both.

The new logic is more dynamic and tailored to the specific needs of
bulk and isochronous transfers:

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
endpoint’s maxburst and maxpacket

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
 Changes for v3:
 Redefine logic for resizing tx fifos,added check based on
 operating speed and used maxp for HS and maxburst for SS
 and defined max allocation based on dt property.

 Changes for v2:
 Redefine logic for resizing tx fifos, handled fifo based on
 minimum of maxp and maxburts.

 Changes for v1:
 Added additional condition to allocate tx fifo for hs isoc
 eps, keeping the other resize logic same.
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


