Return-Path: <linux-kernel+bounces-169309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327108BC6A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1381281585
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64347F5B;
	Mon,  6 May 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dgvNatgK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BB01EEE9;
	Mon,  6 May 2024 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714972568; cv=none; b=hJjDPv9Azu0BP69Y5RsgF9dp70W24/VrmAaK3KjP/2f6EKXffWvFWd6BVaBuPqRlcuvj6ROkcvjnD6xF2H15S9Rf0U8OwHssEOU0fbWlEN9VsWQANc6xuCMjm7P1yVtXabDmKkHW+2kyfmWTZewpSRS2jVyzE+pGJ0KC7IgYXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714972568; c=relaxed/simple;
	bh=BAKASVa/AofS5RB0Gp033UciJlTVWR1s4oyK01067g8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KAuQIrEsFR7UZbicn2zJ9w23QE81xWv2UV1Sx6K2RSMLyWUpljXnuKLSP0v8rK10CCCrHB0tn2DXod61LMA/pTjHd6XazbvYWg7au6Wqi3IzZJ/2t8zabCYG3kZEhHIanOj4NmyVIbl54BFrMOiKhDbJPmUr8gbY1z4bjO874uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dgvNatgK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462C9Pl027974;
	Mon, 6 May 2024 05:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=z0XwOvB
	72dJUZkcF3hng94pWYHRw7u8W7DxQNCBWw8A=; b=dgvNatgKTzVj8+Q9orQMLIV
	e+qiLefuOoX/VaS4tWeiUQorSsntKXojoR3i6G2Ka8Hko7gHRxHU3kCU0KxkB81+
	mzoyQSZuykrThtJR3GwVrE9EJ343xUR3R1B3W3UX2NgkCxWMtSGoIsAhW95Na98D
	h5+cCQ9eqJp+Dhs3sdAMwu2vYSyV/2xECLmDfPOLxESz8zJsx5npyLTMqRX7ehsg
	g5VvZ/ZV+xcyF+lxLblRr3LrBiBFZ1IQKe7vrNkHVKByCLpjpaXQzcLSO1rpke7G
	1vzx1pDyH8PL7KfRLlp1AD0sC9QHBt44Jnwtgux7NLaSDW5aMdpPqdG2tVaUycg=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwaqjjtdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 05:16:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4465G0bO029663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 05:16:00 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 5 May 2024 22:15:57 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH] usb: dwc3: core: Fix unused variable warning in core driver
Date: Mon, 6 May 2024 10:45:48 +0530
Message-ID: <20240506051548.1768794-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rHNOMOi9N8VfqUv8lIS_xZm9Pb6fKWI-
X-Proofpoint-ORIG-GUID: rHNOMOi9N8VfqUv8lIS_xZm9Pb6fKWI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_02,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=575 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060029

While fixing a merge conflict in linux-next, hw_mode variable
was left unused. Remove the unused variable in hs_phy_setup call.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8b6f7769fcd5..7f176ba25354 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -676,11 +676,8 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 
 static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
 {
-	unsigned int hw_mode;
 	u32 reg;
 
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
 
 	/* Select the HS PHY interface */
-- 
2.34.1


