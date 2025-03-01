Return-Path: <linux-kernel+bounces-539665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274CDA4A708
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DA67A81FD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7421BC58;
	Sat,  1 Mar 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FY2PJpq3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC689101DE;
	Sat,  1 Mar 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789309; cv=none; b=ivteBFSz97Sh26qEz1QjB3Wnx72wijCq5TrJRPdx7vNaPfHTRZn64HXmc1BI2s2f7E1R/KbnzNxhCl7nmVyjuh1vH5eA7L97Du3Qqfp9k5GD4UX4+UMpDfHQrADQgpSD3X58aJI+CYR8+VccxiaCkBRgzMka8kGwPERufDwtYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789309; c=relaxed/simple;
	bh=oO08XvxDvh9yXZMbXQYj3VQi37rW9n2zZIw9YiEE7Uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH6hgBQi9Hox2hDQInPboKGVZALKQf0fj++ZROFkpapAzOqWTYlxRxIUj9Tr+CGIvzzKStWVzLbMmQ5kNw1JLWxvQ+rk5vF6uwd3DuWrKa+l/6UvL3QCxJl6zXEf8MYiFJaRi18UTJMR8RpHqk4XT2yQWsq+nWXJtUrfv8Xq11I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FY2PJpq3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SNkXwb003483;
	Sat, 1 Mar 2025 00:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3u5iOjHH37gAJGo3OjTOw3DnWB0/L8G20x0zyhLilkc=; b=FY2PJpq3Ojcp2nef
	sqNjTjqaWCfaSR1HIm+EF3X370TDHpBbAp7XCjzLXjIQJyQc0bOUx5RaMqHi/ExZ
	4emqoxCY22nub/dN07skdJvrEJlmOZG8NYlxFSjiBgYQDf/Ekiby2FOHXJ4cG2qF
	3+jVssulAzlyaTuitOXWQgVUsujgrUjdm/KBr5HMj0NFxiQVGCJARsBtVEgkDxTZ
	uelb1pFFPeYA1XgMnuQ3Ek1HDi3pH2xcP9lW/OQh/M8YTyTcaYuFSkFpEhyeBctN
	KdhW+EHXeGhoNuMaLpPnXNfihKWOMbzSzhA49JSUQKX50EYCw8UJ8Yrp08u22xZr
	O1Si5Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453cg3su5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Mar 2025 00:35:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5210Z3kI008398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Mar 2025 00:35:03 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Feb 2025 16:35:03 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>
Subject: [PATCH 2/2] usb: gadget: udc: Update USB gadget state during soft disconnect
Date: Fri, 28 Feb 2025 16:34:52 -0800
Message-ID: <20250301003452.2675360-3-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301003452.2675360-1-quic_wcheng@quicinc.com>
References: <20250301003452.2675360-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SlKe0RimQaAk4_6b7_mQieH1ZutVW6kU
X-Proofpoint-ORIG-GUID: SlKe0RimQaAk4_6b7_mQieH1ZutVW6kU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010002

In the soft disconnect scenarios, the USB connection will be lost
momentarily, so the proper gadget state should be reflected during the time
the connection is unavailable.  Add a flush_work() call, to ensure that
gadget->work is completed before continuing with the UDC unbind sequence.
Since usb_gadget_set_state() queues work to a workqueue, depending on when
the queue is scheduled, this avoids a possible use after freed scenario as
the USB gadget will most likely be freed shortly after the UDC driver is
unbounded.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/gadget/udc/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 4b3d5075621a..7e401cb5a265 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -775,8 +775,10 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 	}
 
 	ret = gadget->ops->pullup(gadget, 0);
-	if (!ret)
+	if (!ret) {
 		gadget->connected = 0;
+		usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
+	}
 
 	mutex_lock(&udc_lock);
 	if (gadget->udc->driver)
@@ -1669,6 +1671,7 @@ static void gadget_unbind_driver(struct device *dev)
 		synchronize_irq(gadget->irq);
 	mutex_unlock(&udc->connect_lock);
 
+	flush_work(&gadget->work);
 	udc->driver->unbind(gadget);
 
 	mutex_lock(&udc->connect_lock);

