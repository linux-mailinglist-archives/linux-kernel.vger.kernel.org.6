Return-Path: <linux-kernel+bounces-179198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E068C5CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D323A1C21475
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151E181D00;
	Tue, 14 May 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EtxsXLNQ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF037181BA9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722775; cv=none; b=ntuPKnNZV8Rbam0vKy177pA5YykYycxkRfUye69+H7+GqVy/SSjYgleVIZr7E1xrH1h9C9p679KzG9rZk1hvuaoIvEYxfweDVPuRejgdbvNYI7wUtxRhqpO51M41JeURGzpQlgpvQsjj1TLr5lKVRP7Wi3IClH8aToIdRTEaYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722775; c=relaxed/simple;
	bh=rrshtRxJ0zBX8DKiO+PgrYPgqcxgCyYplSoLmAeycBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kb3xenXPA36z5YiXj+jNNLvLnZJ8Pc9DOcCT0GzjSBehtDsD2573fuqUuf6UAwecyiC8SSMJj3/ZqGtUVT5Mqy8YNMSCFeyFFVlhkC8qp3oOb5ovElmT+RBuRDrnNMaeRsxOB1nWd+LKJa8epjudCZIDtFiYQMS8NRH1LbLRU6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EtxsXLNQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EKvjLL011698;
	Tue, 14 May 2024 21:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qYzA3djA8qYcwsm/Lwf5UAjqaXak8juwjCb3AbTGi14=;
 b=EtxsXLNQEvUem8+lLpgPoMRF8YZAfY6wcrHbQ0P9v/WbUsZ/RA+7PEeH+HbulJDvBlIB
 C7eNcAh/5loPmgfQmEmB6JSnOSw13+316BS5seHx0V+IclHYM9sFjSu5LaVVwBotKHyU
 frVgitSZQMgu3NdCcREtRLp4my88+TiGInbERBQGrAGwIz5+XBRbLW3gPagGOQ9lwcWn
 E95WRB91YR/EYv6QswoOqPU2pLnlsiuAPBZK68jjqECS7a44rwXNB1VpguTURgqpG+YI
 0YSMr8bzURrERUhaLO0MgcL4UqiEgSls1GA9EF31jhc8Mlb05lHN3oPyoGjqhTsfzFE+ 8w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4fesr3u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EK8npW029592;
	Tue, 14 May 2024 21:39:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2n7kqfhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 21:39:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44ELdMn68520362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 21:39:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E722E58068;
	Tue, 14 May 2024 21:39:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E79C5804B;
	Tue, 14 May 2024 21:39:21 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 21:39:21 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: eajames@linux.ibm.com, linux-kernel@vger.kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
Subject: [PATCH v5 2/3] fsi: occ: Find next available child rather than node name match
Date: Tue, 14 May 2024 16:39:19 -0500
Message-Id: <20240514213920.159357-3-eajames@linux.ibm.com>
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
X-Proofpoint-GUID: fx2CIxHI1W_y4bljq1XNjmIZrUvDJ9Tg
X-Proofpoint-ORIG-GUID: fx2CIxHI1W_y4bljq1XNjmIZrUvDJ9Tg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_13,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=757 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140156

There's no reason to restrict the creation of the hwmon device to
a matching child node name. Just get the first available one. There
should only be one child node anyway.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 2023355b39805..9a3658d863792 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -669,7 +669,7 @@ static int occ_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	hwmon_node = of_get_child_by_name(dev->of_node, hwmon_dev_info.name);
+	hwmon_node = of_get_next_available_child(dev->of_node, NULL);
 	if (hwmon_node) {
 		snprintf(child_name, sizeof(child_name), "%s.%d", hwmon_dev_info.name, occ->idx);
 		hwmon_dev = of_platform_device_create(hwmon_node, child_name, dev);
-- 
2.39.3


