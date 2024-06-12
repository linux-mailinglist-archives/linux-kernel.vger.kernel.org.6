Return-Path: <linux-kernel+bounces-210749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E2904841
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261761F23F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4D78C1E;
	Wed, 12 Jun 2024 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MhKWQPkS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88BAD56;
	Wed, 12 Jun 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155156; cv=none; b=AT2Fo++pwkep2cIFXrqWvh5KmtEEnuECS42qE0UbpYLwGmVt1sOVmhotmrbML5hnElGmyxjXQKQ51Jfa05JykHbuLo5GBpy8nwDzpeOdxva6EBmQVVUVJ6yI8y+t4Id9cA/BnJuwdtSPYqpm8UWWb5wYjDycDrGNay7503z80ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155156; c=relaxed/simple;
	bh=kSYXv9nIPkIFXOkJTequSQ7Wqj4nVqUZe+e6mX6ay74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=r/bgN1Dc/sWKqKXQvyy4+482U1Qwl6hzRvp5NXsr9AV7zLXPefcB1MkCxADw7gW0p3B1pIFMpA/HmsVsv2AMqB2dzR9c/rMTbbvBeKuiaPkLGkVj8G2QvPS9CBdHAE7WkM9rjwFaD5qxfOg+rQul/IxGXFKhs+1BN4t77UV+gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MhKWQPkS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BHHrFi001180;
	Wed, 12 Jun 2024 01:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=yw0xmqzsIr/6r5+9NKqm3b
	RLhcjjifZCyGq40TyF3tI=; b=MhKWQPkSpWuFqtV+qjM+Hfbb2rIgsO+IXEG7DM
	/9FtdsfJnM9LwQy2LG4u1nryfpf6VNZkMjpklq46ZLNkmZuUgwtqawWnXtXBB8kD
	pAsAGtu/Mcx0ezs/4KzdxxLNW0qz4SvsGZcYaw+9fI/bQuaRJwCVLG9YL/jjmwou
	K7VtbXoK/10sAIEiDWgmmr2zZkrblrP+1hIutyN0Wz+c2BeOCR5ijvi/7CF4AloY
	LEZKGxb4OxW2Rdm7QamL+3jCpswV5OucWkN1lfabD2X+w9TYxpAJq9OlLpnMGxm4
	3JDKDcvgbPuHFzT6tscp9Zyw5MQ8q+87riWuVjCEQq/hrYiA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yptuy0ux8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 01:19:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C1JCOk026642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 01:19:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 18:19:11 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 18:19:10 -0700
Subject: [PATCH] usb: phy: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-usb-phy-v1-1-1cacb41280c3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAI33aGYC/x3MTQ6CMBBA4auQWTsJrWLUqxgX/ZnaSaSSGSAYw
 t0pLr/FeysoCZPCo1lBaGblb6kwpwZCduVNyLEabGsv7dUY7CNG4ZlEcVKPQ/6hvdlzl7q7Syl
 ADQehxMt/+nxVe6eEXlwJ+Vh9uEwL9k5HEti2Hcikx+2DAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oAh1paW8K3R4STJ9BfoJwCvCotDadggY
X-Proofpoint-ORIG-GUID: oAh1paW8K3R4STJ9BfoJwCvCotDadggY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_13,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=643 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120006

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x-control.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/phy/phy-am335x.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/usb/phy/phy-am335x-control.c | 1 +
 drivers/usb/phy/phy-am335x.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/phy/phy-am335x-control.c b/drivers/usb/phy/phy-am335x-control.c
index 97e6603c7149..ada508be090a 100644
--- a/drivers/usb/phy/phy-am335x-control.c
+++ b/drivers/usb/phy/phy-am335x-control.c
@@ -189,4 +189,5 @@ static struct platform_driver am335x_control_driver = {
 };
 
 module_platform_driver(am335x_control_driver);
+MODULE_DESCRIPTION("AM335x USB PHY Control Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
index e39665cf4b4a..6db88e00f127 100644
--- a/drivers/usb/phy/phy-am335x.c
+++ b/drivers/usb/phy/phy-am335x.c
@@ -142,4 +142,5 @@ static struct platform_driver am335x_phy_driver = {
 };
 
 module_platform_driver(am335x_phy_driver);
+MODULE_DESCRIPTION("AM335x USB PHY Driver");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-usb-phy-28235f59affc


