Return-Path: <linux-kernel+bounces-331966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2223B97B37A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B14A1F23E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E71925A2;
	Tue, 17 Sep 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VVzMlCbo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125B2188A23
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593425; cv=none; b=Jj3Z70tumR3W+5LFL8yytc3yuzF4RCWJu1ATCmyhz8ZwIkDRECYbQPsi+dDtMx9DW2j2YPBVagtRboLwRYNGPKDcYvn6wdU0kCNcdne6ixLg95NqxMLs92av6Ignpb5UlWg957VE2r+vBcT2YoL9JvkvAUc9baUu7x5dKjy/4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593425; c=relaxed/simple;
	bh=EKWfqaeq7NpDWzfi0whJPvRuRD+M+3iTC2yU70sQPdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCJdXwWTXV4wilh0OnHBQX1N4lOZPJm13uaZaQDZjDPlXxei82dJT/zMEBhP5RoXmUZcZEqPv+tBgbwF6DLdsj3GvpPu8MmNyEsQPgfWUnpUr2SwMK2AXY10usBKxQe6x68+Di24KhWYhLz1DAD3At89QAnAqstOFY2lVW3X++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VVzMlCbo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H7tlwM030209;
	Tue, 17 Sep 2024 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=sV761vlSy4p44
	1y09pi1WCNRwViJB3aPpG45NTlUP54=; b=VVzMlCboQIcu3ZS35pbR30/Nw+ovK
	ui8g6ho/jXvHbXGACanhXMMJmPZ2U1QaEby89ck9VScx/SukNngWkfVheK1YQpzh
	/PUzGQ3J/KVEZYm+E4hXtL2yTcleQJG2tOQmR0hibsbjBTSPCnwd1TICJ05a0BAa
	aIVS4nNyF8qdMHpaQLqNF/8KCt5cVNxI3IFNf+VPxFthk33CI8uTYhkcBwCXbp7f
	6PGmOzKpHSkwQDuSY3bIQxCEZGphqNhmp8FUh4rQfcFVyYp6i5dGGLOckejnsnJG
	7SWAnJOQSnqcMThmFXZuXZBF7fJ12Ks2/pGAXsfUeLXb6Fh27PkqyZHjQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8gf1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HGjMLx025044;
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mx7ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGnQj36045262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3FA158058;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7857058065;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 08/15] fsi: core: Reset errors instead of clearing interrupts
Date: Tue, 17 Sep 2024 12:16:40 -0500
Message-ID: <20240917171647.1403910-9-eajames@linux.ibm.com>
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
X-Proofpoint-GUID: kMpBuDM1E9wFY5eOZKpsEKVg6gdDFhsE
X-Proofpoint-ORIG-GUID: kMpBuDM1E9wFY5eOZKpsEKVg6gdDFhsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=857 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

The proper way to clear error conditions is to use the SRES
register rather than simple clearing SISC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c  | 9 +++++----
 drivers/fsi/fsi-slave.h | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 8ce187bbaf22..53d61ea46a4f 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -166,7 +166,7 @@ static int fsi_slave_calc_addr(struct fsi_slave *slave, uint32_t *addrp,
 static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 {
 	struct fsi_master *master = slave->master;
-	__be32 irq, stat;
+	__be32 irq, reset, stat;
 	int rc, link;
 	uint8_t id;
 
@@ -187,9 +187,10 @@ static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 			be32_to_cpu(stat), be32_to_cpu(irq));
 	trace_fsi_slave_error(slave, be32_to_cpu(irq), be32_to_cpu(stat));
 
-	/* clear interrupts */
-	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SISC,
-			&irq, sizeof(irq));
+	/* reset errors */
+	reset = cpu_to_be32(FSI_SRES_ERRS);
+	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SRES, &reset,
+				sizeof(reset));
 }
 
 /* Encode slave local bus echo delay */
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index fabc0b66d5bf..e9fd4be6f376 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -24,6 +24,7 @@
 #define FSI_SSI1M		0x1c	/* S  : Set slave interrupt 1 mask */
 #define FSI_SCI1M		0x20	/* C  : Clear slave interrupt 1 mask */
 #define FSI_SLBUS		0x30	/* W  : LBUS Ownership */
+#define FSI_SRES		0x34	/* W  : Reset */
 #define FSI_SRSIC0		0x68	/* C  : Clear remote interrupt condition */
 #define FSI_SRSIC4		0x6c	/* C  : Clear remote interrupt condition */
 #define FSI_SRSIM0		0x70	/* R/W: Remote interrupt mask */
@@ -90,6 +91,11 @@
  */
 #define FSI_SLBUS_FORCE		0x80000000	/* Force LBUS ownership */
 
+/*
+ * SRES fields
+ */
+#define FSI_SRES_ERRS		0x40000000	/* Reset FSI slave errors */
+
 /*
  * LLMODE fields
  */
-- 
2.43.0


