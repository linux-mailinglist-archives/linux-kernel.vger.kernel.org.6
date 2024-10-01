Return-Path: <linux-kernel+bounces-346560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0915C98C5ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A6D2838B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED2B1CDA14;
	Tue,  1 Oct 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6XpS73E"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C71CCEC2;
	Tue,  1 Oct 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810311; cv=none; b=HJBVZrObG/ccNC7K2yUVZX5Il2RyeAVRMBEhTuyb9nM1iu5Mwdi919Gi6/aFjwlXObJdVetkR7O+84Zg+s42Gghirmpuzj7gByWBl1/hUId3oKzoWMay0PZogsKOkvNfRu/iGMlJmQrgd3KOAvgsb9H8pO4E5uxK7ejZ9VdG5rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810311; c=relaxed/simple;
	bh=Sjxm123N1yCiAxylZoKkXY6FQSEsTBe+B87LsqzbZj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIUDDo4zV1uvsf+IPXiZ2CL94TAl+SD4INwamN1v5DO1yzl5lXJzj2ExVQlNUkJo4NvXUt3dG8hErpDKAFtsTwX3z7+ZLQJn2Oy0D3OtiXoBpPA1LxjvgP/IXV5nP+73V+q3ysm0gEdV7y/780ACenzTfxdxj8qSicsTAVwf1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6XpS73E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491JH63M011616;
	Tue, 1 Oct 2024 19:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=IDSkA+pHDjhKZYqv6kAJMgRE2r
	n2M7Iu0eSnkvjhH68=; b=P6XpS73EmgKW/7etdhE5Dxmc6rmFLx+pxT6rbZMVpn
	Ck8hRF8z4pKOqRO1sXZkWgZBMftXV2JR4oe8LlRu1my6EpwzST+H49rIFZ5SV8Zn
	Be7S4O0tNcbTNAG2cc5OC9qB+J1N/Jvg8Zm8DEx0qEu2N5xHjjcnEd2nJE9VPbg5
	KbpkCpqsy2rPBF8Ke17fO+rXfb8tKqFjIW7OqWZBM/JRTC6d9Z9dPYa3MoGyzXLK
	WhEoPMtiGFjRRIA0GOwfjqeR6xmbjix7kxzwGnVRP9U/nlG2fRils6kOumsjxasn
	wsc408m3qsxhrHvavqSWdUjPKD9i25LrlGFuT8jSv7wQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420q3p0046-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 19:18:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491I8dGO017866;
	Tue, 1 Oct 2024 19:18:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mx9xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 19:18:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491JI8RY40829550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 19:18:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859725804E;
	Tue,  1 Oct 2024 19:18:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEA2B5803F;
	Tue,  1 Oct 2024 19:18:07 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 19:18:07 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, eajames@linux.ibm.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Device tree changes for system1 BMC
Date: Tue,  1 Oct 2024 14:17:47 -0500
Message-ID: <20241001191756.234096-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: thyCX61fjYp6ldqtjQhvbnSdr5eFTeX-
X-Proofpoint-ORIG-GUID: thyCX61fjYp6ldqtjQhvbnSdr5eFTeX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=661 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010125

Hello,

Please review the device tree changes for BMC for system1 machine.

Ninad Palsule (3):
  ARM: dts: aspeed: system1: Bump up i2c busses freq
  ARM: dts: aspeed: system1: Enable serial gpio0
  ARM: dts: aspeed: system1: Add GPIO line names

 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0


