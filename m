Return-Path: <linux-kernel+bounces-400169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A79C09D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26580285C19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810CE2139C1;
	Thu,  7 Nov 2024 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="szPDi0ME"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FF212D21;
	Thu,  7 Nov 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992494; cv=none; b=l/OhXfZuh5awMDp40d+dXlU2wp5viMbe5h+VwnkmjwoAiRhJpQt1S5g92cE0VGfDXrjsvCoFLcFZ5fbXT1tTLmBKrlxPR1qhZMx+3FtPrt2x/RiFdHMuMK6w+NUAoSwuf9s/HckRyDOlqfRlh9mB3veiUxZm26ufrKw5lL2fiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992494; c=relaxed/simple;
	bh=tvkmO9lvPzpuaYW25HwS43eSHEK8FRazisRcpb8B09o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px/HYeUEPeqdtI5vLTfn53nOR+DTr8udJjWv+PVs9hdpxHtvnyy8746f0phBZCDaUAa5ai6pnXLh0j5Zyx4MguYUZXg415bPjvL6rihJvhOfc+wJT1/i+nZ+xY2YI/PSP0wFp2hyG3RfoX/Hj2SUKI/WebqN67jcmuppjTB/3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=szPDi0ME; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7FARX8018738;
	Thu, 7 Nov 2024 15:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WHnju/VNjDuD2pNeV/zF/23AlxGsr/9gnSmrgnw5y
	RQ=; b=szPDi0ME3UYdzSsuxj9HzLgueVJ8x8IP1hfhE8HmKPh3qZoe9YJrSC6Y5
	cN9of+57feVuL7LMF7jq1jB/3M0UeWbr+g2WnNif18KhfhMuWOc7Yfji297OKkBa
	WKmVNIpZG5nV6Tq/kN4K18YbfNXW7WBiYflP8EhqCQKnllFp7uKKxeAv4yBofVNY
	wf/5U2jI/foGdows1Sr0hIFkjseqBoguN7HUQx5Zcx+oQn4265nHmeV9tVmZINcB
	V2nJUvlwXrEEuzaHziINWXaq9zqIfElv0/43Af5Amkaj1qTe9izgdpbk4DILDbJN
	cH5bIH0EmzSjszcWZEPDMyR2jZWng==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ryxx00uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 15:14:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7CgCDM024200;
	Thu, 7 Nov 2024 15:14:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds8fbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 15:14:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7FEX0h53150092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 15:14:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D58258063;
	Thu,  7 Nov 2024 15:14:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DABA35805B;
	Thu,  7 Nov 2024 15:14:32 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.24.137])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 15:14:32 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] arm: dts: aspeed: Blueridge and Fuji: Fix LED node names
Date: Thu,  7 Nov 2024 09:14:31 -0600
Message-ID: <20241107151431.1045102-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q_K9IXljOvvaoq1SMAQ_tK1-7envGrUc
X-Proofpoint-GUID: q_K9IXljOvvaoq1SMAQ_tK1-7envGrUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=771 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070117

The addressing on PCA LED nodes should be in hexadecimal, not
decimal.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 36 ++++----
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 84 +++++++++----------
 2 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
index 9e6bfaef3840..5f9a46c2abb8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
@@ -740,7 +740,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "ddimm10";
@@ -748,7 +748,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "ddimm11";
@@ -756,7 +756,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "ddimm12";
@@ -764,7 +764,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "ddimm13";
@@ -772,7 +772,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "ddimm14";
@@ -780,7 +780,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "ddimm15";
@@ -877,7 +877,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "ddimm26";
@@ -885,7 +885,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "ddimm27";
@@ -893,7 +893,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "ddimm28";
@@ -901,7 +901,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "ddimm29";
@@ -909,7 +909,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "ddimm30";
@@ -917,7 +917,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "ddimm31";
@@ -1006,7 +1006,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "pcieslot7";
@@ -1014,7 +1014,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "pcieslot8";
@@ -1022,7 +1022,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "pcieslot9";
@@ -1030,7 +1030,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "pcieslot10";
@@ -1038,7 +1038,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "pcieslot11";
@@ -1046,7 +1046,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "tpm-wilson";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
index 27ded3bba66d..9a43fc7bcebe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
@@ -976,7 +976,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "pcieslot-c10";
@@ -984,7 +984,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "pcieslot-c11";
@@ -1085,7 +1085,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "ddimm10";
@@ -1093,7 +1093,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "ddimm11";
@@ -1101,7 +1101,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "ddimm12";
@@ -1109,7 +1109,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "ddimm13";
@@ -1117,7 +1117,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "ddimm14";
@@ -1125,7 +1125,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "ddimm15";
@@ -1222,7 +1222,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "ddimm26";
@@ -1230,7 +1230,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "ddimm27";
@@ -1238,7 +1238,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "ddimm28";
@@ -1246,7 +1246,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "ddimm29";
@@ -1254,7 +1254,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "ddimm30";
@@ -1262,7 +1262,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "ddimm31";
@@ -1359,7 +1359,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "ddimm42";
@@ -1367,7 +1367,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "ddimm43";
@@ -1375,7 +1375,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "ddimm44";
@@ -1383,7 +1383,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "ddimm45";
@@ -1391,7 +1391,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "ddimm46";
@@ -1399,7 +1399,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "ddimm47";
@@ -1496,7 +1496,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "ddimm58";
@@ -1504,7 +1504,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "ddimm59";
@@ -1512,7 +1512,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "ddimm60";
@@ -1520,7 +1520,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "ddimm61";
@@ -1528,7 +1528,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "ddimm62";
@@ -1536,7 +1536,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "ddimm63";
@@ -1625,7 +1625,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "vrm6";
@@ -1633,7 +1633,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "vrm7";
@@ -1641,7 +1641,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "vrm12";
@@ -1649,7 +1649,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "vrm13";
@@ -1657,7 +1657,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "vrm14";
@@ -1665,7 +1665,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "vrm15";
@@ -1754,7 +1754,7 @@ led@9 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@10 {
+		led@a {
 			reg = <10>;
 			default-state = "keep";
 			label = "vrm2";
@@ -1762,7 +1762,7 @@ led@10 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@11 {
+		led@b {
 			reg = <11>;
 			default-state = "keep";
 			label = "vrm3";
@@ -1770,7 +1770,7 @@ led@11 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@12 {
+		led@c {
 			reg = <12>;
 			default-state = "keep";
 			label = "vrm8";
@@ -1778,7 +1778,7 @@ led@12 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@13 {
+		led@d {
 			reg = <13>;
 			default-state = "keep";
 			label = "vrm9";
@@ -1786,7 +1786,7 @@ led@13 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@14 {
+		led@e {
 			reg = <14>;
 			default-state = "keep";
 			label = "vrm10";
@@ -1794,7 +1794,7 @@ led@14 {
 			type = <PCA955X_TYPE_LED>;
 		};
 
-		led@15 {
+		led@f {
 			reg = <15>;
 			default-state = "keep";
 			label = "vrm11";
@@ -2145,7 +2145,7 @@ led@9 {
 					type = <PCA955X_TYPE_LED>;
 				};
 
-				led@10 {
+				led@a {
 					reg = <10>;
 					default-state = "keep";
 					label = "fan0";
@@ -2153,7 +2153,7 @@ led@10 {
 					type = <PCA955X_TYPE_LED>;
 				};
 
-				led@11 {
+				led@b {
 					reg = <11>;
 					default-state = "keep";
 					label = "fan1";
@@ -2161,7 +2161,7 @@ led@11 {
 					type = <PCA955X_TYPE_LED>;
 				};
 
-				led@12 {
+				led@c {
 					reg = <12>;
 					default-state = "keep";
 					label = "fan2";
@@ -2169,7 +2169,7 @@ led@12 {
 					type = <PCA955X_TYPE_LED>;
 				};
 
-				led@13 {
+				led@d {
 					reg = <13>;
 					default-state = "keep";
 					label = "fan3";
-- 
2.43.5


