Return-Path: <linux-kernel+bounces-331964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112897B377
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260CF2865B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EE4191F8F;
	Tue, 17 Sep 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LsWCpker"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E3188A26
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593425; cv=none; b=r9yatNQdo9VuwNfEDDqfJCORISFTtjz0HoefiDJOrSG+SkWbVUZK7m8mJ1SiPpBYR8ac+povS8UFMxF8qMAYQY4WrYtpeeiYRMn+pTolNSU3yDHT3pzvpbapdeAA+oDpOm4BezYgZx+a/qc8DVuYpsnnA2CqEpet+oeCcZ2N4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593425; c=relaxed/simple;
	bh=6TdFma9aRy1vcP8LH45ag4P1Opkky2758LJqc9/2hLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrtRPyez8axvibas3mNV+cUROgdKmZVn/e+uyeYUE0v8LnVmbw58o09Wd60c6WSTmk28BxUXOSJ+aWbrEg+c9x2/64Iac7H5wusH2olbE5Ehjlj2ZEoH0diUpZxRonAReUsacJO4U7QKK9tH3iC3hbYgEfcJtCGXORfs1y6hq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LsWCpker; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H8eXLc006164;
	Tue, 17 Sep 2024 17:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=ugH+Qd7xUHLQ4
	eYpCxT7RB/vaTjhXjlfHzuz5ZAN7KM=; b=LsWCpkerLjYWLmLPgjLX4C6Wu7KY3
	tHgCLMF+DD9J+IjQZi4PHdXWiusziFkiQZ6f5g7Bhlc9JZo/O9/vFAhE5OgfXEOy
	0PFy1vCrwwdRVwZYsa3togdYeVo0xP9Osa3M+b8Dr42lzG6NhMSewcwb9KKhq+Sr
	Wa5bypiO+/8a3t9n6YMuzvEW0eDVluFJ29gIIRx+bWIlPQY2te0kgDLoqmd/M+66
	FuWebWCzH/A/aJQXK3kH0zOc4YWdBxu1ZZMOnZZzQsF3vYmbjNqB5tp+tieCDpPN
	zVELhPLZEp8/JYh+yccCtKGQ5a1zZhGqnA1/FiwFJX93AzGjAdWb711BQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41agwbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HGVuB2025033;
	Tue, 17 Sep 2024 17:16:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mx7ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGoqr61210936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52B3158057;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D52B58059;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:50 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 11/15] fsi: scom: Update compatible string to match documentation
Date: Tue, 17 Sep 2024 12:16:43 -0500
Message-ID: <20240917171647.1403910-12-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917171647.1403910-1-eajames@linux.ibm.com>
References: <20240917171647.1403910-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jUQHSJwwGJUFDCWuhjLVw1fatHYw2O5x
X-Proofpoint-ORIG-GUID: jUQHSJwwGJUFDCWuhjLVw1fatHYw2O5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=879 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

Use p9-scom instead of fsi2pib.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/fsi/fsi-scom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 411ddc018cd8..8f27bccb8746 100644
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
2.43.0


