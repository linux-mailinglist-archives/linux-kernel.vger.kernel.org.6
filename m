Return-Path: <linux-kernel+bounces-444987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AAC9F0F92
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8F3188339E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9233C1E22E6;
	Fri, 13 Dec 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lmnu+yRo"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC71DF759;
	Fri, 13 Dec 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101460; cv=none; b=OIMsswN79coWFPjUIT49XJWLoc+m8NYm77OZiLkhutT22La5OzEv91Y3bp9xktSstR+e4JAOiJ0ZhcrSoiCgPjTw/kKpPOOSruvTq9ZguPNdJz2iUV2ekOrjy1qQG+DM+X9JxDibUXeZXXnO0dj0LGnFIuOMy4MvWbhrtF1mN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101460; c=relaxed/simple;
	bh=zBaQeLiVC53oDeKPILC2AVTpps1Judn7JLM3ItjLFYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MTUy5u4D1SXmYNj3CczlHTcwa+tmbgP6c2AgScJvziX4H/DU+HH4Mm4qZxcMETN0wxc+NjsknQ82+wWCAShbi88vcXGbUY/pZNAE0omfZFjNQ1Q1bDZYHrh/Rf8DHnKBXT8EOsJw66bw/jMGyVmZivJjnd7W0ZwK4wZ1rBBJJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lmnu+yRo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIvXY022054;
	Fri, 13 Dec 2024 14:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ILQcBliS53PGmeAwS/K4h6GeyD7y4AIHXFgUd+DVO
	pk=; b=lmnu+yRoKp1ILXdG+ZED3QUW8z2UZ/CW6E2uItRcfSkkTylF2uTj5bDbY
	ylRPbJP3fjnq1KAOLhrH1dKV2UOCVVxY85sGmKPhtjFTCrGJ+lywlgay8cbnwkw8
	ET8I2vtTeig1sbl6QDdrKlPc5mxpYRQIyN0ZhRLCI+EhNk0yocnBY4H2PaKTKFrF
	l+MQme+BhkQNCrbRJGsy38UoIXRiuriDOwH46WebwS+8jCF3UxvNv1pS0TWDX+0j
	I9vvLdYNkDbSeQ2gXfJVFePWJzRhCa6zx3IGsyzL1Ah0Sx8heKOlRgGtG6lBdbuN
	F5ib0iPGgkODfkSc9sCqHJ1HRaVww==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhkm56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBx6KV007781;
	Fri, 13 Dec 2024 14:50:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11ysf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEoeQ051839256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 226F65805F;
	Fri, 13 Dec 2024 14:50:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CCD858062;
	Fri, 13 Dec 2024 14:50:39 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:39 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/8] DTS updates for system1 BMC
Date: Fri, 13 Dec 2024 08:50:26 -0600
Message-ID: <20241213145037.3784931-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XOW9082fpxCc7H1F3PAnWkbIU9wTLjzF
X-Proofpoint-ORIG-GUID: XOW9082fpxCc7H1F3PAnWkbIU9wTLjzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=387
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

Hello

Please review the patch set. It has various device tree changes for
system1 BMC after hardware testing.

NINAD PALSULE (7):
  ARM: dts: aspeed: system1: Add IPMB device
  ARM: dts: aspeed: system1: Add GPIO line name
  ARM: dts: aspeed: system1: Add RGMII support
  ARM: dts: aspeed: system1: Reduce sgpio speed
  ARM: dts: aspeed: system1: Update LED gpio name
  ARM: dts: aspeed: system1: Remove VRs max8952
  ARM: dts: aspeed: system1: Mark GPIO line high/low

Ninad Palsule (1):
  ARM: dts: aspeed: system1: Disable gpio pull down

 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 178 ++++++++++++------
 1 file changed, 119 insertions(+), 59 deletions(-)

-- 
2.43.0


