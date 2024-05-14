Return-Path: <linux-kernel+bounces-179195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E298C5CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41DE1C21D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC90182C94;
	Tue, 14 May 2024 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fJNfwtds"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBF181D08;
	Tue, 14 May 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722531; cv=none; b=UzsfYcSv76Y3P57Pu8iT+7lwJ7Oq3mMnegwMPVGNlzjuVIJiAIrUV4IEDKc3K8lNUCPlIIeZci3I2DE2EOaTRLHB2Wg5Nf00CWBwSD5hE2saaRX6/aD7gsBfH43QI/xcEBYRbOKfB1VYrvJimRhHJ0+uXpGIr+4xVMKWAl7VVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722531; c=relaxed/simple;
	bh=so/mAaimo4YUFOIxeSddD0OiNIPa+CWrnkywJc8Erhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZVVOWDJpV0vWkKjXpHiNr46VFoClYF7Cj5iNgNHvOBiMN2zCfQFh5yH3Sq7bzSfZ8SX6aHDI2PLCCiqrnrrHjdax76foKJOVvZvxVvRER1t1h6JkI+CTW3L1072liopHNyZOoJPraK/8+NJ2olZxVGGIpeJxCnkUEXE6aycxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fJNfwtds; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKvXp8011480;
	Tue, 14 May 2024 21:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4pORVVcsA6Howf6k5wKer88rPHPM+CRiI07jqlHbYv8=;
 b=fJNfwtdsOzqrEQ9pwtBTxHjHI294BikFpaQV9mKismWJySqTsoi7/JqZJh19bs6zOw1K
 KHA1yy27yy2wlGakEQIoFQ/1/EO8m0qhI8qB9tFoWBgucPj0DYRmZBSc4o+NJLdM1fBo
 iHVS22QjnXupORq0g1Up0O2c1pHMPvT0fRybnXkvyjliKaBaJt1ewKPxEHUKVN59OnGP
 rKgG9+MMJvUrTI5kdI5bG8F9NN69YojkATx+FkO1OfVbMOQ47V7FX3Ge/yHpbMwOaNec
 q5oItQo0NP3ma87PWiOxQ2dCAJiQeq1HpfR1rcc9tAZAH1uveLeBGMy+y/X79w5kxNyU UA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4fesr3m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:35:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EL25Z4018828;
	Tue, 14 May 2024 21:35:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tg0np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:35:15 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44ELZCiN29295190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:35:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2740C58063;
	Tue, 14 May 2024 21:35:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E76BE58069;
	Tue, 14 May 2024 21:35:11 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 21:35:11 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        conor+dt@kernel.org, eajames@linux.ibm.com, krzk+dt@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
Date: Tue, 14 May 2024 16:35:09 -0500
Message-Id: <20240514213510.159144-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514213510.159144-1-eajames@linux.ibm.com>
References: <20240514213510.159144-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r5DHtlMcJ8Mw6Rh-K7QKs66E_MeBIn17
X-Proofpoint-ORIG-GUID: r5DHtlMcJ8Mw6Rh-K7QKs66E_MeBIn17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_13,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=565 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140154

The 4U Blueridge is identical to the Blueridge system but has two extra
power supplies.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../aspeed/aspeed-bmc-ibm-blueridge-4u.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
new file mode 100644
index 0000000000000..839aad4ddd917
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-bmc-ibm-blueridge.dts"
+
+/ {
+	model = "Blueridge 4U";
+};
+
+&i2c3 {
+	power-supply@6a {
+		compatible = "ibm,cffps";
+		reg = <0x6a>;
+	};
+
+	power-supply@6b {
+		compatible = "ibm,cffps";
+		reg = <0x6b>;
+	};
+};
-- 
2.39.3


