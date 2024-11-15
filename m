Return-Path: <linux-kernel+bounces-411452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2059CF9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226861F24B66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248519004B;
	Fri, 15 Nov 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bkwDMOyC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50E186E56;
	Fri, 15 Nov 2024 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709669; cv=none; b=pjz39AEWtFJGGDXIcifGybfaHof0zZra/zgoQGwfwWDy9BGTtYbpflYScCCM8LCiMPx9NNLpL601biBIeAfEWTqwe2AmS9GfQaOKPym1SEyf+g8C0ubg9OWEHLpPIEJEyLikf1CBMuyqHa5Cns9cx+8/Z//jOTY9fjNX1ljyBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709669; c=relaxed/simple;
	bh=sKTA+y2N6NtmY9ipmfTfJK99DKc9W0SoDGDw2WjdHaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dGJVl3H4Riwp2Mg3/IB3j6ODwKnIIJeTa5xCfCk0AS6lcoC054Fz/supYYyP1/LG7JP2SahCMCagrNFQCy9QKaiVa2uEu/oufhgbVKCd3RlTLHp9ihe3QDmlcpSJNYMz99OvoIrzktgxDO1YHc3xGltOtl16eJeNZimqW/71glA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bkwDMOyC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFLQIiq003900;
	Fri, 15 Nov 2024 22:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qF+mrQmSnUbowuzaVvbuJVUuttwpmgemw8P54JHvW
	pM=; b=bkwDMOyC2ZStTUq3RCfq6jBWOqf3MIwUkQi2feVIVV+jMnzpQRSQOyyyL
	5TOwYrvO6YuOsOI/8KTq3iXhGEy/r903MTUCqDlp1TL7Kb6qTQ9f+kBOduvOuTgl
	i7SjUFWlqeKmANnUF84Wb3t6vTxq3C8uxl1V/qCxdVPft/BwgY8FsOsvvH4BlUIO
	g5ipC/9LZsFLu3AEuVEuxZymQywmFF46c1qiIsxnPxDYhmg1Cw3ysht5twKQpIfP
	ByYMCJnktw0TrbvxATE8p0ZBCzUmbQMcSWqrXBAVWhUj3++SEFbg6QJSvKqZafcN
	zAaVTN3lDvUluwAPTRQNAfIzhEp2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuy1nth8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 22:27:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFLRhAg029721;
	Fri, 15 Nov 2024 22:27:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmxccu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 22:27:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AFMRN2j48300424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 22:27:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200F85805E;
	Fri, 15 Nov 2024 22:27:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E347858051;
	Fri, 15 Nov 2024 22:27:22 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.159.220])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 22:27:22 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2] arm: dts: aspeed: Blueridge and Rainer: Add VRM presence GPIOs
Date: Fri, 15 Nov 2024 16:27:21 -0600
Message-ID: <20241115222721.1564735-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MSJwhyRl3RV_-5CFans8ZY7eUkqKx3kg
X-Proofpoint-GUID: MSJwhyRl3RV_-5CFans8ZY7eUkqKx3kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxlogscore=435 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150186

Add GPIO line names to the GPIO expander to describe DCM and
VRM presence detection lines.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Fix lines that were too long

 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts | 5 +++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts   | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
index 5f9a46c2abb8..bc4c46235421 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
@@ -1232,8 +1232,9 @@ led-controller@60 {
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-			"", "", "", "", "", "", "", "",
-			"", "", "", "", "", "", "power-config-full-load", "";
+			"", "", "", "", "", "", "P10_DCM0_PRES", "P10_DCM1_PRES",
+			"", "", "", "", "PRESENT_VRM_DCM0_N", "PRESENT_VRM_DCM1_N",
+			"power-config-full-load", "";
 	};
 
 	led-controller@61 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
index a4aec3010456..638a2c1c7892 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
@@ -1280,8 +1280,9 @@ pca_pres3: pca9552@60 {
 		#gpio-cells = <2>;
 
 		gpio-line-names =
-			"", "", "", "", "", "", "", "",
-			"", "", "", "", "", "", "power-config-full-load", "";
+			"", "", "", "", "", "", "P10_DCM0_PRES", "P10_DCM1_PRES",
+			"", "", "", "", "PRESENT_VRM_DCM0_N", "PRESENT_VRM_DCM1_N",
+			"power-config-full-load", "";
 	};
 
 	pca_pres2: pca9552@61 {
-- 
2.43.5


