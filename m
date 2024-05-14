Return-Path: <linux-kernel+bounces-179200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E5D8C5CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987CD1F22A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C0181D14;
	Tue, 14 May 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bieQw72Z"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31489180A77
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722775; cv=none; b=nDaVwrAW1Pc4dIu3SB8Zt3i8Pp6/LFLcDGGOSHnGIb87hDC5yNve8pkDCfgrI6juqxG6hSUJUVh2rSzOHBMOerGgUs4FfWQXpWabi8AKlZPd2o4bhRJGC82+foiAXLTB7A/JB9TMyWUpyhXkzR7IHOvCVvYZQMMAsEyWGsd9838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722775; c=relaxed/simple;
	bh=wtVIF8Wge5YdecSIDp9ap1mpirYKwrUhFLT4RyPR9Oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpCFmmE5ODV9FTruCUtoez1ZoEG1Jx2g+beGS6gsB0P1PpNeYHuiBeoHGKu4X/OM0hQ2+0VWrpflZ8vxs+j03uGyuqRUGfGBlZwkktbIQEyYe4zZ7BZ3/NXuR//Y3hBntdkGrKhWyMfxPDFThFUr4yRMKUwGB1OFWZFh0jVeOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bieQw72Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKrB0A031386;
	Tue, 14 May 2024 21:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=DnWgp2QmvAuQ8Do/IwlTa4K4noZyV9DzLZUq1Y7CHso=;
 b=bieQw72Zs3CfZ8AmraqSJW5A0VLJHSCfsYpmQflH+1DwWD12jIQGRERxzBv3wTQIHLJn
 ZiiSkpPqP/rs2o+JGh9He0I5zUenUIl+GbqRhA03meCl8X+WhcGL8Ngj9k84WFAbE+9v
 A7uwYH4X0Yh80MhcNd+d577vcreVpa3Ec94siemHGBkjphresPKfUMjgqUfxyLAVmreG
 DoFfkOhxMwh/DVAXptCM/QhTYtuiO+eLrYuxrrd7VikdCx1lTPQ5/QOpGILwMwz9MRuZ
 T21jTQDGMpE3Szhs/jDVrH+jHJDDmKqa9jfCYWwJ3BZua11Hr/DsUtu4nttrZ8BusywJ Ww== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4fch048m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EJuMaj029568;
	Tue, 14 May 2024 21:39:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2n7kqfhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:23 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44ELdLbC24904242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:39:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9EE658055;
	Tue, 14 May 2024 21:39:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81CDE5804B;
	Tue, 14 May 2024 21:39:20 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 21:39:20 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: eajames@linux.ibm.com, linux-kernel@vger.kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
Subject: [PATCH v5 0/3] fsi: Update drivers with latest documentation
Date: Tue, 14 May 2024 16:39:17 -0500
Message-Id: <20240514213920.159357-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8VyQKj-ZfQOpoWcRfck3GddwmUbZMjbl
X-Proofpoint-ORIG-GUID: 8VyQKj-ZfQOpoWcRfck3GddwmUbZMjbl
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=484
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405140156

This series was previously included in
https://lore.kernel.org/all/20240429210131.373487-1-eajames@linux.ibm.com/

This series updates the SCOM and OCC drivers to be compatible with the
latest documentation.

Eddie James (3):
  fsi: occ: Get device number from FSI minor number API
  fsi: occ: Find next available child rather than node name match
  fsi: scom: Update compatible string to match documentation

 drivers/fsi/fsi-occ.c  | 49 +++++++++---------------------------------
 drivers/fsi/fsi-scom.c |  1 +
 2 files changed, 11 insertions(+), 39 deletions(-)

-- 
2.39.3


