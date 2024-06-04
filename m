Return-Path: <linux-kernel+bounces-201432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63B8FBE76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E781F25DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F6143870;
	Tue,  4 Jun 2024 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i4q3cb+Y"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47A320C;
	Tue,  4 Jun 2024 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538536; cv=none; b=e25m5KhwPV2fPkw0a6SQxUK9ktD6ivsxlEZ4TrTqlnhVRf6n0fm35dE2j+WZMOL2bz02Q5x4af3NE46voS44d+G7uQucYfnYU7ib8MakttXfVXbmppMqqJffMNuRHrgOoY6Ls/rPfixty3wkiR1yXPksdNSykGhvG8nhmvCREjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538536; c=relaxed/simple;
	bh=EMIzYIFkXVUprOInl/LuU0NK/y3BCX3/WnmoS6Oig2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u7HEsfEfL4IRDvdzMKsU5fp3pp+gypBAbEpsiTuoKzymQTTuaTOnepGrroK6hOd9UtJGvk29EvKnMmKMbeQMo1sGbMXnDzUALg7/1+X0gpDyNTGe7rDlTpahCwnLocB4IJMP9QUpHzQ6eHo5JvAFp5cGpJ/5jKKWcbI/44GZP58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i4q3cb+Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454LqCMp009352;
	Tue, 4 Jun 2024 21:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=pp1; bh=OHYuuKn8tJ7rSUbYgVXZpxWOnvGgk1aa1oTjRBRVGS4=;
 b=i4q3cb+YDGF8VqB19V6IAhQpX61Nn7ZfC6yTCdM8yp2tgfOA6SYWRyoOPuxR1+inR5/1
 wva8yBRXckEq7gm/WajmB8Vv4tji1gdXQp24O1Fx4wPzP6ebuT7O9TS3kyw+KuVKHttg
 vN+VTMAkOIaeVQku5CtTpPYM8qSXCD5eSV4x+j29DbzEs9gIQJbQUJLfP4oNTdAUi9Hv
 THTvcimKZH/sDzgwAVO52sSnEE36WdVeYrBKabFyBl1lyaxQT9EKK0SCZdbAyQJrk81w
 1xnnCJGoW0/D/A5OFa+VNiQhoDEz9u3QbXBDyQx7pwBY3VsgfcWMnzIJBS+43ror4sX9 Iw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yjax7g1ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 21:59:48 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 454LjC1x008501;
	Tue, 4 Jun 2024 21:59:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec0rq47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 21:59:47 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 454Lxife15270642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 21:59:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B2BF58064;
	Tue,  4 Jun 2024 21:59:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2F7858062;
	Tue,  4 Jun 2024 21:59:43 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 21:59:43 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au
Cc: Ninad Palsule <ninad@linux.ibm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, eajames@linux.ibm.com
Subject: [PATCH v1] ARM: dts: aspeed: System1: Updates to BMC board
Date: Tue,  4 Jun 2024 16:59:39 -0500
Message-Id: <20240604215939.1967329-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Vetq6Mejqa7zfwIUkmji2p2f6zF51Xz
X-Proofpoint-ORIG-GUID: -Vetq6Mejqa7zfwIUkmji2p2f6zF51Xz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=779 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040177

- Added new power monitor device max5970
- Changed temperature sensor monitor chip from tmp423 to tmp432

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index dcbc16308ab50..e09a6b383ba49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -753,6 +753,11 @@ &i2c4 {
 &i2c5 {
 	status = "okay";
 
+	power-monitor@3a {
+		compatible = "maxim,max5970";
+		reg = <0x3a>;
+	};
+
 	regulator@42 {
 		compatible = "infineon,ir38263";
 		reg = <0x42>;
@@ -1138,7 +1143,7 @@ i2c8mux0chn6: i2c@6 {
 			reg = <6>;
 
 			temperature-sensor@4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1599,7 +1604,7 @@ i2c15mux0chn6: i2c@6 {
 			reg = <6>;
 
 			temperature-sensor@4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1615,7 +1620,7 @@ regulator@40 {
 			};
 
 			temperature-sensor@4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
-- 
2.40.1


