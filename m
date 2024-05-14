Return-Path: <linux-kernel+bounces-179197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D738C5CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A139FB21949
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475C6181CEA;
	Tue, 14 May 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OPkmNenn"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55698181BA6
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722774; cv=none; b=ukG+GtqfcewCjsODMpwKagePx6k5WvR61MmaXnX8wPijnqKt5twwGSPWO7GAJxJ6OLSOW3YmDJ0Fm3UD9k61kU531VVfZFSZUMtETkap4VgEEBWg/A8ygh7KnLcDTU/CD5nRIadAPBeixi5c0tsbol09qu14kI9RNlKZSG5SFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722774; c=relaxed/simple;
	bh=dKKGEyMUk0UwgESO6nJ+5EuDLzkHGZXIp4njWAeuzdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dn5yAuvmI+Jwt+GhmpoUY96AZgscx8ODl1O6g3MS8SHT3UeECW+bV5lIz7Z5CrYMj/0zNCoKh5mnXiV2AsKOqJnCiSH1QEM193PlBlpzBvzuqh3oapOrgrvGb75QzcXJ/cu9zwArKEuYpjPqXDcyQc/ogPqUWLsdPN2BqZX1/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OPkmNenn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKv2fF029010;
	Tue, 14 May 2024 21:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=b4yNQBAtpva9pbdQ3MKrwTcabBpfveNT3SZdpdEVr0c=;
 b=OPkmNennSEhbDWmWXApSu0tZXSefrWUTTouuOx6Uetm7xNTlkJ75CYqYfbtTC84AHa/t
 9CSiX2XcZ0zm97Og9yDwhSSAc+d1FXKrYmlzopPfzR+pcg1ZZg3vCJgS2cPGUTUmem0y
 juBMIeh/1XP9JLfMLqAzsiI4wznbjfZmZdIdHXbvH19AeIKBVDli+kt+t35qs2Pp5cwk
 phI4OycdUbINEuTfMo6/S/3hRQgk6JqmGNjyLTjC966tRa48BtwU1nuGiUVAi+cV/QfD
 F7qixLO99Ogz/CTanqf838a7hORxV3/rwdd47UG5Oxk4Z+z8nj6fE4uq2+ajptR7BoUx Qw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4fehr479-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKLQ5u005821;
	Tue, 14 May 2024 21:39:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq2qc1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44ELdMij26608208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:39:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70F165806B;
	Tue, 14 May 2024 21:39:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 088125804B;
	Tue, 14 May 2024 21:39:22 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 21:39:21 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: eajames@linux.ibm.com, linux-kernel@vger.kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
Subject: [PATCH v5 3/3] fsi: scom: Update compatible string to match documentation
Date: Tue, 14 May 2024 16:39:20 -0500
Message-Id: <20240514213920.159357-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514213920.159357-1-eajames@linux.ibm.com>
References: <20240514213920.159357-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0-KCbhKzGkWf7ltpa9pfXCOgoQqjCNKo
X-Proofpoint-GUID: 0-KCbhKzGkWf7ltpa9pfXCOgoQqjCNKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_13,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=960 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140156

Use p9-scom instead of fsi2pib.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-scom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 61dbda9dbe2b0..4558b96474e09 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -590,6 +590,7 @@ static int scom_remove(struct device *dev)
 
 static const struct of_device_id scom_of_ids[] = {
 	{ .compatible = "ibm,fsi2pib" },
+	{ .compatible = "ibm,p9-scom" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, scom_of_ids);
-- 
2.39.3


