Return-Path: <linux-kernel+bounces-539666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABFA4A70A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D173B484B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50135971;
	Sat,  1 Mar 2025 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gnaVATYM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D97F9CB;
	Sat,  1 Mar 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789309; cv=none; b=Lg6fqVyV17GUUNV8/rIO4CnwxZ8DblCFzEL0gFFe/1sXTPRNCL8b1mAxH5G1mHnzEFeOxEUZ1Q3/Ctsh+bWRLhs/2gSfkMQWIo7eGxQN01m6XCFgHFPjlWgMRd+lwj3HVOKtu0Go9mBn2MabP2Ln62DABPVHKMSWtyiG2d4VqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789309; c=relaxed/simple;
	bh=WVNYcQWeL8UADbiEzE8q9R/lB0imDkhBxk37nrIgev4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxqmjnsi/5sp4VfDYW1Y5HsL+74HzJw0lcLICAK4Ir4BO62eqIHA5qBTydWKIxZyqHVVzkNp6jcKCxpKjj0H/+iogqwl77M3f2ydHFeZq/iggkj9ayFlGPPy8VBL1yaAOQY8SYzLz0azz8+mji3WLw4MbQiNqDKg+Jx05w0ZIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gnaVATYM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SJqoid010188;
	Sat, 1 Mar 2025 00:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WrPxIxnpKiMpqPD+FZfg/kiIDeehcKp5nFGG+DUfxg4=; b=gnaVATYMzjE3kD8d
	1s8Zun50RjoIjop2JV7Fir1XiWNrNExyUChJNM5U7nNKjLzV2IWmN3h53d+Xmzb6
	x6D7y4y23k8cY7puR2hPhQyJEXlA3OCQcRDm1wjxAptipU+mYtJ2hJT4L/NMdKIG
	99QClgTxtLKPbx8vBrfyJh6tkd5nNWdoQSG6FM48sD9+lct1cLn62JDm19d2mN9/
	QfCzizEAJOsRfM6Mx6QAuRrqzvON5g8sLWwWJ81mMvVh5ycKbEPw5+d3spB8jrjJ
	z5oUJmPIDvk09Lq1s+KB82znerC1vgXxqLZ2iWpVMv0Xa1a8STnnqMrzBo8pl2jJ
	zNAdjQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453kphrg67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Mar 2025 00:35:04 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5210Z3ca002754
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Mar 2025 00:35:03 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Feb 2025 16:35:02 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>
Subject: [PATCH 1/2] Revert "usb: dwc3: gadget: Fix incorrect UDC state after manual deconfiguration"
Date: Fri, 28 Feb 2025 16:34:51 -0800
Message-ID: <20250301003452.2675360-2-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zDaYXJGm_cpuUOyHUILh3Yfgh1GgFWD2
X-Proofpoint-GUID: zDaYXJGm_cpuUOyHUILh3Yfgh1GgFWD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_07,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010002

This reverts commit 1ff24d40b3c3c673d833c546f898133b80dffc39.

The following change creates a potential use after freed scenario within
the UDC core level.  When transitioning from peripheral to host mode, the
DWC3 DRD will remove the USB UDC using usb_del_gadget().  As part of the
UDC removal routine, the UDC core will issue a pullup disable call back to
the DWC3 gadget driver, which will now call usb_gadget_set_state(), and
queues gadget->work.  If gadget->work is unable to complete before the USB
gadget is freed, then we will run into the use after freed situation.

Below is the callstack in question:

dwc3_gadget_exit()
 --> usb_del_gadget()
 --> gadget_unbind_driver()
  --> device_del()
   --> gadget_unbind_driver()
    --> usb_gadget_disconnect_locked()
     --> pullup(0)
      --> dwc3_gadget_soft_disconnect()
       --> usb_gadget_set_state(UNATTACHED)
        --> queue_work(gadget->work) --> async
  --> device_unregister()

Unfortunately, the flush_work() call within usb_del_gadget() doesn't work
in this situation, as it happens before the device_del() and soft
disconnect sequence.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5156fafbda6c..921f72995dbf 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2781,8 +2781,6 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	__dwc3_gadget_stop(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
-
 	return ret;
 }
 

