Return-Path: <linux-kernel+bounces-398827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50849BF692
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6781C227D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBCE20969B;
	Wed,  6 Nov 2024 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ENr9eiVZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AA17B4FF;
	Wed,  6 Nov 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921612; cv=none; b=B3M+xYm1DyLx4dfxO6RC0ldxF4AATpv9ylA16xADSP98ujZkj4LWwNdT4aLdb+oCCdGovk7v22lCsliA79thmxgNqey4gooYeT+p8tVYixst/+yopwHnbGm8k59EXZnacDlH1edZY2uG3O543s45EIxBXLA9voyxmtFLKFrzfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921612; c=relaxed/simple;
	bh=Bh1/gSz4W7o4J39pG+iqfl78BR69v4xlANMsxCQ/nKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uz52JbZnyuNVLCL+zrVEv5CQmhPi9zo/dXYZvTFyDmI/uzskli8Odj1/jMW73QOEc9dqvlQ14unFW7wqovtuGTeJvS7OYKHvtNwS7A0FeSgI78TEHr9LKehaow+7IsAbQmjn8E3+X3mhCOK1kIgahOZxrUH/ng7A42ipERGiUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ENr9eiVZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Ie2xn019000;
	Wed, 6 Nov 2024 19:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DWKirZ0Dp0Cmi7IM3wOgw90y9rfSjrE2uL6xs36Ca
	BI=; b=ENr9eiVZ04SS+raMo7YOwe/5lqseQep5DBV0mxtj4ejs6+D6s9ty+mVdL
	yo+w7ofJrydqMWdkYqNFTgqsJvSHqWSYDNIKk3RQinPE7o/7DwsjOSRwjW+22/fo
	NOQXk728926OMGZ/1lRM7eeVSwrloJhOXNFhdXdvxOKBDq7urArFKRw8yDyOy8Am
	Ppwq3cfxtHD1QpIF+Id4CF/WaTHp+E4LM6RM6CqeIs+xKQWaW3oL8lL/73tzAjRz
	F9z4tRgba7b7B4MNZZyh9Jk3EolaIePA/UuWabvLYAbPxYYD2Rct49Z3XD7LUETW
	Sh4vKmDjS/c3MGUnjRPf74t/icEog==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rdxc87t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 19:33:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6Fpd2Q019096;
	Wed, 6 Nov 2024 19:33:06 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj6rhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 19:33:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A6JX6Di47841676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 19:33:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AAF5805C;
	Wed,  6 Nov 2024 19:33:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850925805A;
	Wed,  6 Nov 2024 19:33:05 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.24.137])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 19:33:05 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] arm: dts: aspeed: Everest and Fuji: Add VRM presence gpio expander
Date: Wed,  6 Nov 2024 13:33:03 -0600
Message-ID: <20241106193303.748824-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PJz5APyk2-yIADYsMYqQhSW6YClopaTn
X-Proofpoint-ORIG-GUID: PJz5APyk2-yIADYsMYqQhSW6YClopaTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 adultscore=0 mlxlogscore=602
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060147

Add the gpio expander that provides the VRM presence detection
pins.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 27 +++++++++++++++++++
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 27 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 513077a1f4be..9961508ee872 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -353,6 +353,33 @@ pca1: pca9552@62 {
 			"presence-base-op",
 			"";
 	};
+
+	led-controller@63 {
+		compatible = "nxp,pca9552";
+		reg = <0x63>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"presence-vrm-c12",
+			"presence-vrm-c13",
+			"presence-vrm-c15",
+			"presence-vrm-c16",
+			"presence-vrm-c17",
+			"presence-vrm-c18",
+			"presence-vrm-c20",
+			"presence-vrm-c21",
+			"presence-vrm-c54",
+			"presence-vrm-c55",
+			"presence-vrm-c57",
+			"presence-vrm-c58",
+			"presence-vrm-c59",
+			"presence-vrm-c60",
+			"presence-vrm-c62",
+			"presence-vrm-c63";
+	};
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
index c24e464e5faa..27ded3bba66d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
@@ -355,6 +355,33 @@ led-controller@62 {
 			"presence-base-op",
 			"";
 	};
+
+	led-controller@63 {
+		compatible = "nxp,pca9552";
+		reg = <0x63>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"presence-vrm-c12",
+			"presence-vrm-c13",
+			"presence-vrm-c15",
+			"presence-vrm-c16",
+			"presence-vrm-c17",
+			"presence-vrm-c18",
+			"presence-vrm-c20",
+			"presence-vrm-c21",
+			"presence-vrm-c54",
+			"presence-vrm-c55",
+			"presence-vrm-c57",
+			"presence-vrm-c58",
+			"presence-vrm-c59",
+			"presence-vrm-c60",
+			"presence-vrm-c62",
+			"presence-vrm-c63";
+	};
 };
 
 &i2c1 {
-- 
2.43.5


