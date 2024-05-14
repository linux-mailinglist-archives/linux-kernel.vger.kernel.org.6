Return-Path: <linux-kernel+bounces-179114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE58C5BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D881C21A46
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF9B181B80;
	Tue, 14 May 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cbrCSiRO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA32AF09;
	Tue, 14 May 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716491; cv=none; b=tgHDJ0Ffo717CFGNLz6EdUO5uZdarT3U/mAMlpGmtTFqCGFDfatNRwg+SwdOaZECtp9ILNe/Cd69e2tIfgm75t2ksqEkeSyUY2YgYF/vLrsvFWXcy/x/5fs8Rjf72dykdpE051R5hol+7352shrQ/Jwa5kCOhPYmkYh4ulqSals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716491; c=relaxed/simple;
	bh=/5PqzAFlrMJaKZ27IhU+KH4H2iwXQiRSH34L7rgCz1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r8s0SJe2jBhVo3lxEPnONK0CShF4fyx3mOaFGGWqklNZ/usAoLcGoMXfnIsuL4LEIwzz7p6Yj7NdijKjdijkRxX3scE0qE/m57tplHnBr4kdGUhHY2vrbFBxnsKAolIpLdTthbtLop3hI3D0NW1U+C4wWp4cShzcl3784sQ5BKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cbrCSiRO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIiZ2C025423;
	Tue, 14 May 2024 19:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=2QvCZbuUY0bHh/GhpEelkXTIT2gmf/R7LhhRsf0xJ30=;
 b=cbrCSiRO5q+Y6dztYEHCUbnR+ymn+t/Npf0teg5fyufzM2XWk/rGZx+XW+AmV97msimG
 hXEvUa6MKhFhi+kugFiIgiEhDKPWcL4iwwLbtHnrldmUxxFVKdKuai4Fijb9fgS+kcSa
 Z0JOfQPb0v8erjcpqBOWEc1DO3x1HuGTjxUO01a+O6BeTlbI6AzwYHvX7/WoYWWNzgz7
 q9ZargUSEhZlHCFGZSN+vDpKrwmuMQjxgMBhs0UE+jkt+gQ7xqZdmgxR9ARLrivfBVKd
 Wp2wzw2L2s428tNg7tddPqsk8oCBe2iaCgshOMGEbVnwyXZ25z1oECdpntD/Doz2s6mi gg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4dg0r5n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHbd2V018828;
	Tue, 14 May 2024 19:54:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tfhpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:38 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJsajD25952966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:54:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E6558056;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3D9E5803F;
	Tue, 14 May 2024 19:54:35 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:54:35 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        robh@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Subject: [PATCH v5 0/9] dt-bindings: fsi: Convert to json-schema and add missing engines
Date: Tue, 14 May 2024 14:54:26 -0500
Message-Id: <20240514195435.155372-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MN6fqohEi_6rnSalhhpK0yghkFUN1DuQ
X-Proofpoint-GUID: MN6fqohEi_6rnSalhhpK0yghkFUN1DuQ
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
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=544 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140142

This series was previously included in
https://lore.kernel.org/all/20240429210131.373487-1-eajames@linux.ibm.com/

Changes since v4:
 - Move the addition of AST2700 FSI into a separate patch
 - Add interrupt controller properties for the common FSI controller properties
 - Add clock-frequency property to FSI controller and CFAM
 - Add detail to chip-id property description
 - Drop pattern properties for occ and hwmon nodes

Eddie James (9):
  dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
  dt-bindings: fsi: Document the IBM SCOM engine
  dt-bindings: fsi: p9-occ: Convert to json-schema
  dt-bindings: fsi: Document the IBM SBEFIFO engine
  dt-bindings: fsi: Document the FSI controller common properties
  dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
  dt-bindings: fsi: ast2600-fsi-master: Convert to json-schema
  dt-bindings: fsi: Document the AST2700 FSI master
  dt-bindings: fsi: Document the FSI Hub Controller

 .../fsi/aspeed,ast2600-fsi-master.yaml        | 81 +++++++++++++++++++
 .../bindings/fsi/fsi-controller.yaml          | 66 +++++++++++++++
 .../bindings/fsi/fsi-master-aspeed.txt        | 36 ---------
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  | 36 ++++++++-
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  5 +-
 .../bindings/fsi/ibm,p9-fsi-controller.yaml   | 45 +++++++++++
 .../devicetree/bindings/fsi/ibm,p9-occ.txt    | 16 ----
 .../devicetree/bindings/fsi/ibm,p9-occ.yaml   | 40 +++++++++
 .../bindings/fsi/ibm,p9-sbefifo.yaml          | 46 +++++++++++
 .../devicetree/bindings/fsi/ibm,p9-scom.yaml  | 37 +++++++++
 10 files changed, 351 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml

-- 
2.39.3


