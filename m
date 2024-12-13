Return-Path: <linux-kernel+bounces-444990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90AB9F0F99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6EA2835F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34A31E32DA;
	Fri, 13 Dec 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RN7ny8VN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDE1E2309;
	Fri, 13 Dec 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101463; cv=none; b=PnL1RjCRJZlEKPt7/Nwz+TKxVZNiUx2vmSDl7+1rsAMVJFVH06ARiQUKf0luYX2WUyiOpmkucGe5ynNVNbgiGPcnHCXQhwROL9Xxrvj6ja00Y/GghWQC7ZBeoTeJcncRElrfm5iXSLKTqQjFSxIyXiG22b4VCJwgRsi4vtxgXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101463; c=relaxed/simple;
	bh=s3oz4BwFzz9SKcEFq1Bd9RmkYVZufapWBkh0909mOIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+yA6UF0FElQ6ce1wwLF82cS7DmAhI7RI2FbNG6gSmZyPhvJPU3f1QutLKq29DXzPGWqe72Q0tvr3j+jxSaPw9+NXOugvmMrD3EzptR2hbGMX/ZpAIMBaN3iFRqhi7GRgNX2rcdXYK0Bj0ieo6+mW+XDxYhS+FPdo2AJs1PRPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RN7ny8VN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIu8Q017056;
	Fri, 13 Dec 2024 14:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JAD71IwOAA32z1JJ/
	0HMb/xqrSSgnABthIuidtyzRmg=; b=RN7ny8VNWs4Bulybi304DEF/W6Avm8zMo
	06oPR+A2AaWUpGkhAqXsc6AeH5gFh52gki/xcvBBk9vDmDvyJiYSzfu8+Q5orFZ3
	ygEWzyA8WcQrerog4hYSVwqhLkBS9ItZi/OsjfB7JWDxyUSeglaixLrfYWkiZvtT
	ELByXakHpQXcMxAPhPyeeXiKrVXgaYFHOAzCshopTinT7YSZe2Xv8EMNElioDwq6
	WbmjEU1KF2NC8wWA8it7AXEsdFcDu2DXFVlYravyS05KjOQOaY5pdQczaB9Vwtkt
	767a7P8s0f1YJSurTd3tEVJ6z8JbneQE5EunbGErob1Ep6RuWGNVQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbtv9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDD63g6018618;
	Fri, 13 Dec 2024 14:50:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kx6kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEojVj18612950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E78B58052;
	Fri, 13 Dec 2024 14:50:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C58BF58054;
	Fri, 13 Dec 2024 14:50:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: [PATCH v1 6/8] ARM: dts: aspeed: system1: Remove VRs max8952
Date: Fri, 13 Dec 2024 08:50:32 -0600
Message-ID: <20241213145037.3784931-7-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5bAFWIizQVQFb68IYlBMzgxTpdTeSbAT
X-Proofpoint-GUID: 5bAFWIizQVQFb68IYlBMzgxTpdTeSbAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

From: NINAD PALSULE <ninadpalsule@us.ibm.com>

Removing voltage regulators max8952 from device tree. Those are fully
controlled by hardware and firmware should not thouch them.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 34 -------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 149b9ad23dbb..ca2d4a292687 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -514,23 +514,6 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
-
-	regulator@60 {
-		compatible = "maxim,max8952";
-		reg = <0x60>;
-
-		max8952,default-mode = <0>;
-		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
-						<1050000>, <950000>;
-		max8952,sync-freq = <0>;
-		max8952,ramp-speed = <0>;
-
-		regulator-name = "VR_v77_1v4";
-		regulator-min-microvolt = <770000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
 };
 
 &i2c1 {
@@ -1227,23 +1210,6 @@ eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
-
-	regulator@60 {
-		compatible = "maxim,max8952";
-		reg = <0x60>;
-
-		max8952,default-mode = <0>;
-		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
-						<1050000>, <950000>;
-		max8952,sync-freq = <0>;
-		max8952,ramp-speed = <0>;
-
-		regulator-name = "VR_v77_1v4";
-		regulator-min-microvolt = <770000>;
-		regulator-max-microvolt = <1400000>;
-		regulator-always-on;
-		regulator-boot-on;
-	};
 };
 
 &i2c11 {
-- 
2.43.0


