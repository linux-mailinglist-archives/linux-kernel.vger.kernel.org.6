Return-Path: <linux-kernel+bounces-179192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D36008C5CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42358B2169F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE1181CE4;
	Tue, 14 May 2024 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DKrLMLsg"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB3B180A6A;
	Tue, 14 May 2024 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722528; cv=none; b=DTOHu31zwKEZFhdcYQIwyqMIvohALboiLAOBFmZ5UioHBNQys8TrUMQPK0B+OuDnl8U3LMGbCW+7kzyw6dLvflFKw7KbCR4tPg3dOXvwKX6HXFrdX5N6pPVjVTPA8okMmLVqj8ydCIXqQ10bcHpSYxKPreOp6FHQDZkx/lC+gbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722528; c=relaxed/simple;
	bh=aF9WqJDnCdLja00O7itEYM9SGXGttlvGBdB6IhdeNP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VwUxI6hBe3ZQTN3UtK/QOQqEoncK9asRHCkxEuZSBfxFowbX9eB+4E21BRZVBM/qOVJ/aBavZ7eEVzZo4GsuKzv8XLXr9Mzb301HbpgGhSOnAE34jZdkwbnezBstet6spvrLI21UWPsl3aG0Y9Ac4vzkebw23AVkdqACN32drtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DKrLMLsg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKqLiZ026521;
	Tue, 14 May 2024 21:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=XlxC1D8a2ar7YUytuCba9+OD4bQgUK1iL9higa/s9HU=;
 b=DKrLMLsg6xxNtqqj17h/Jv79RawyBHUDdiS/eW26DvSEHkUu0JEKsn6pYDQddZIxpEKf
 0DAyUOpf0e4heGvuwNt+vwX0Scim7c9K3cvwgRXQwYZNvpds1PaNi4nVvESw+cNrbWuP
 w/zIz5TDGjcwIx4eiGlR/dY7adNoNWn5BV0TIN+mwFpzgmFkI12Aiig5rxTpx18izVTg
 4tN7GAQkjmB36wOe4rmzUg7J9+bp/uxEqjklKVPmFOG+c+6Gkpyf7UUTARBOso+eypDo
 i9Ezlur4YMqMkpsk/xqJHnABOwK69B87+jH63k+7kVFWlVQhp7EbWwTQlgZzsUqSEimA GA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4fcc043b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:35:15 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIlHrw006189;
	Tue, 14 May 2024 21:35:13 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmfpmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:35:13 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44ELZBpI47382950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:35:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40BAF58055;
	Tue, 14 May 2024 21:35:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0963E58060;
	Tue, 14 May 2024 21:35:11 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 21:35:10 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
        conor+dt@kernel.org, eajames@linux.ibm.com, krzk+dt@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] ARM: dts: aspeed: Add IBM P11 BMC systems
Date: Tue, 14 May 2024 16:35:06 -0500
Message-Id: <20240514213510.159144-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OgrG-qXJ8DAzju17FgNjonMk-yNb2pUZ
X-Proofpoint-ORIG-GUID: OgrG-qXJ8DAzju17FgNjonMk-yNb2pUZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_13,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=395 suspectscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140154

This series was previously included in
https://lore.kernel.org/all/20240429210131.373487-1-eajames@linux.ibm.com/
The series now depends on
https://lore.kernel.org/all/20240514212555.158788-1-eajames@linux.ibm.com/
https://lore.kernel.org/all/20240514205454.158157-1-eajames@linux.ibm.com/
https://lore.kernel.org/all/20240514195435.155372-1-eajames@linux.ibm.com/
https://lore.kernel.org/all/20240514192630.152747-1-eajames@linux.ibm.com/

Changes since v4:
 - Update SPI frequencies
 - Add Blueridge 4U system

Eddie James (4):
  ARM: dts: aspeed: Add IBM P11 FSI devices
  ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
  ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
  ARM: dts: aspeed: Add IBM P11 Fuji BMC system

 arch/arm/boot/dts/aspeed/Makefile             |    2 +
 .../aspeed/aspeed-bmc-ibm-blueridge-4u.dts    |   21 +
 .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1691 +++++++
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 3880 +++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1538 +++++++
 5 files changed, 7132 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi

-- 
2.39.3


