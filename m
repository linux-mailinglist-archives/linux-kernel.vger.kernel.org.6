Return-Path: <linux-kernel+bounces-184592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A58CA948
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF71C2084A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0752F81;
	Tue, 21 May 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pQrAn3M7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55017740;
	Tue, 21 May 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277628; cv=none; b=TH7dhlD9Aha60iEb2BADGLda+K0ghbNP4j6qBCO6yWjIXKfqeAbXGU65HswCsfoKTyiGr8j+m1zxR2cui8IbfTTImOVIUYQX4I0NAXn6wuCvab8Md9YzOIloFJim9KxY8gDPC88YIifcl7j7NkT/MWHHMpmbBt6JSYoDPIFYmbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277628; c=relaxed/simple;
	bh=jj3ml5NryMM9k6Dd7LW1/PbFcKW1PEXt0SN6m0z7Ovk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U60h3lX2BgKX3iSNRCWFlkvPLPxuBL1d0f6mTFGkaMnYjpT8WK8Y025s42WuTYba0w9k90kQEdnC7bILukd2vfCyisoPLIZrTa3GRpt+7Tb87urKd3zvyqG7yb1109Ai/s14rVvZh8HpyrSfZK9vE8W7WY+6neeL69LWocTpKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pQrAn3M7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L3aVDH030616;
	Tue, 21 May 2024 07:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Prfa9G4HnCS9d8aKGY/KCOiEB9xV9WvqnSIJw3f9/gw=; b=pQ
	rAn3M7BR7cBKc2vxWTqUklXt9Tbi+/SA2F+0Y9uiTKUjMsaiMmDkl9PDp63AEib8
	lW24OxsQCnwN86Z40UvW/es0Ficj7EWyzYPeI71qFw4WErv3ttfyJH8K/y2rh3uQ
	GTIubKlkIStXPnFQLTiDIBTZ1o1sqIt2KDakim9K4jzw1l6fiWMlhlRvV2kgAMoJ
	y5tVf1Mac+zMuGdR4NJ+C2LjsFo3yN8Etnr0cRx9OSOR2F9dTUDdqWIQp1UuNedr
	CebcKk04qnR+krUIxZ2lfD1YBP3G6TxKBBNYhi2XQ4wctH/8XrT3KCgxtbu3Vbjk
	gEC7j05KDVG5ogbHPcag==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pr2n5e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 07:47:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44L7l1jd004985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 07:47:01 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 May 2024 00:46:53 -0700
From: Akash Kumar <quic_akakum@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng
	<jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Pratham=20Pratap=C2=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham
	<quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akash Kumar
	<quic_akakum@quicinc.com>
Subject: [PATCH] USB: pci-quirks: Skip usb_early_handoff for Renesas PCI USB
Date: Tue, 21 May 2024 13:16:35 +0530
Message-ID: <20240521074635.17938-1-quic_akakum@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CrJNrORKKLpUYSxBsDPQS7MuMakBwliP
X-Proofpoint-GUID: CrJNrORKKLpUYSxBsDPQS7MuMakBwliP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_04,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=964 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210058

Skip usb_early_handoff for the Renesas PCI USB controller due to
the firmware not being loaded beforehand, which impacts the bootup
time.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
 drivers/usb/host/pci-quirks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 0b949acfa258..a0770ecc0861 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1264,6 +1264,11 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
 		}
 	}
 
+	/* Skip handoff for Renesas PCI USB controller on QCOM SOC */
+	if ((pdev->vendor == PCI_VENDOR_ID_RENESAS) &&
+			(pcie_find_root_port(pdev)->vendor == PCI_VENDOR_ID_QCOM))
+		return;
+
 	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
 			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
-- 
2.17.1


