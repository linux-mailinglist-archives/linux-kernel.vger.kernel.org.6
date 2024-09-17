Return-Path: <linux-kernel+bounces-331961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1E97B374
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E131F23EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D6C18FC83;
	Tue, 17 Sep 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RvUQ9H/9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C8176FB6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593424; cv=none; b=HvF6mvViBl4aBcm0/fWbNsH8i6TuU5227Ru4rlBjzMDKkSG0QQkurFT1gRfy5EVeIDaIOYpT0ej5hf4X8pJkJFM8i0cQzniNpOL4B08N8EXLNqYn1LxIOluEcvzwh87Y40BXxJO96fXd0KbcthOAOk8VfRup9iK6THuNW5mIHZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593424; c=relaxed/simple;
	bh=xVmxFtkpWlJU238eAzvHKx/JYWmLAnS81rCYjR7YsxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtZh1noNUCH8Eb+bOn++btwW9LoWp5C0EQaaQ5e6SpN0c+4haOmuVXpQjzzHEvxySjr0Mxw+3TJ1s6HIort7zhJ1MNiafjY+P4Cav3YENOqCUFvEx6vhR0mYiM2MhKqfkK3i9MI9T3yuxeYg7oQoOzyuUN+eu7rHa9OQer2uBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RvUQ9H/9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H8muXd007650;
	Tue, 17 Sep 2024 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=NdgjyTP5bHuWM
	KxG+Dyf8Kp5l871ZAgSYlDsb5N07Vw=; b=RvUQ9H/9OBBQa78JwTJkbiXlnK36B
	ehvLTJsTIBhEdKAAtnHUjJ1bzDJ1d4+qeRWn/sB2D2MgggJCd+po607M3WoaH80V
	JNVHQ4YE8zBXjGsXIb7S3RIg9N0r7tZ5n9HTW0im8JacJSczgvqWNGiZEc8bEte6
	iW2Zi8WTnl14iOhBBh7boRnaF43TrcUmTfVkMy1lHyyoBhu8mQYE1GGRFrawrmp0
	qqqQK31QBks3ivuKRbVM7Z8fXR5NEyb0cfoxwSPyc0MDGe3gUzu5iCjZgKrE+CAL
	46tOo+3K5eGOlgkw5h7+mh5KjKH12biTxW98Y5jg1oAxSz/Oa+FbSRpyQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdhjrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HFhBrY001184;
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntq6erk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGmmb27263694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6401A58059;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37CFD5805D;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 02/15] fsi: Move slave definitions to fsi-slave.h
Date: Tue, 17 Sep 2024 12:16:34 -0500
Message-ID: <20240917171647.1403910-3-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: YnQZDxjEU6GbGhZa8OIZ1tu2krDZSPEv
X-Proofpoint-GUID: YnQZDxjEU6GbGhZa8OIZ1tu2krDZSPEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=980 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

Master drivers may need access to the slave definitions.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c  | 35 -----------------
 drivers/fsi/fsi-slave.h | 84 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 35 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e2e1e9df6115..b50ed849f924 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -45,41 +45,6 @@
 
 static const int engine_page_size = 0x400;
 
-#define FSI_SLAVE_BASE			0x800
-
-/*
- * FSI slave engine control register offsets
- */
-#define FSI_SMODE		0x0	/* R/W: Mode register */
-#define FSI_SISC		0x8	/* R/W: Interrupt condition */
-#define FSI_SSTAT		0x14	/* R  : Slave status */
-#define FSI_SLBUS		0x30	/* W  : LBUS Ownership */
-#define FSI_LLMODE		0x100	/* R/W: Link layer mode register */
-
-/*
- * SMODE fields
- */
-#define FSI_SMODE_WSC		0x80000000	/* Warm start done */
-#define FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
-#define FSI_SMODE_SID_SHIFT	24		/* ID shift */
-#define FSI_SMODE_SID_MASK	3		/* ID Mask */
-#define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
-#define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
-#define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
-#define FSI_SMODE_SD_MASK	0xf		/* Send delay mask */
-#define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
-#define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
-
-/*
- * SLBUS fields
- */
-#define FSI_SLBUS_FORCE		0x80000000	/* Force LBUS ownership */
-
-/*
- * LLMODE fields
- */
-#define FSI_LLMODE_ASYNC	0x1
-
 #define FSI_SLAVE_SIZE_23b		0x800000
 
 static DEFINE_IDA(master_ida);
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index 1d63a585829d..dba65bd4e083 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -7,6 +7,90 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 
+#define FSI_SLAVE_BASE			0x800
+
+/*
+ * FSI slave engine control register offsets
+ */
+#define FSI_SMODE		0x0	/* R/W: Mode register */
+#define FSI_SISC		0x8	/* R  : Interrupt condition */
+#define FSI_SCISC		0x8	/* C  : Clear interrupt condition */
+#define FSI_SISM		0xc	/* R/W: Interrupt mask */
+#define FSI_SISS		0x10	/* R  : Interrupt status */
+#define FSI_SSISM		0x10	/* S  : Set interrupt mask */
+#define FSI_SCISM		0x14	/* C  : Clear interrupt mask */
+#define FSI_SSTAT		0x14	/* R  : Slave status */
+#define FSI_SI1S		0x1c	/* R  : Slave interrupt 1 status */
+#define FSI_SSI1M		0x1c	/* S  : Set slave interrupt 1 mask */
+#define FSI_SCI1M		0x20	/* C  : Clear slave interrupt 1 mask */
+#define FSI_SLBUS		0x30	/* W  : LBUS Ownership */
+#define FSI_SRSIC0		0x68	/* C  : Clear remote interrupt condition */
+#define FSI_SRSIC4		0x6c	/* C  : Clear remote interrupt condition */
+#define FSI_SRSIM0		0x70	/* R/W: Remote interrupt mask */
+#define FSI_SRSIM4		0x74	/* R/W: Remote interrupt mask */
+#define FSI_SRSIS0		0x78	/* R  : Remote interrupt status */
+#define FSI_SRSIS4		0x7c	/* R  : Remote interrupt status */
+#define FSI_LLMODE		0x100	/* R/W: Link layer mode register */
+
+/*
+ * SMODE fields
+ */
+#define FSI_SMODE_WSC		0x80000000	/* Warm start done */
+#define FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
+#define FSI_SMODE_SID_SHIFT	24		/* ID shift */
+#define FSI_SMODE_SID_MASK	3		/* ID Mask */
+#define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
+#define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
+#define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
+#define FSI_SMODE_SD_MASK	0xf		/* Send delay mask */
+#define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
+#define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
+
+/*
+ * SISS fields
+ */
+#define FSI_SISS_CRC_ERROR		BIT(31)
+#define FSI_SISS_PROTO_ERROR		BIT(30)
+#define FSI_SISS_LBUS_PARITY_ERROR	BIT(29)
+#define FSI_SISS_LBUS_PROTO_ERROR	BIT(28)
+#define FSI_SISS_ACCESS_ERROR		BIT(27)
+#define FSI_SISS_LBUS_OWNERSHIP_ERROR	BIT(26)
+#define FSI_SISS_LBUS_OWNERSHIP_CHANGE	BIT(25)
+#define FSI_SISS_ASYNC_MODE_ERROR	BIT(14)
+#define FSI_SISS_OPB_ACCESS_ERROR	BIT(13)
+#define FSI_SISS_OPB_FENCED		BIT(12)
+#define FSI_SISS_OPB_PARITY_ERROR	BIT(11)
+#define FSI_SISS_OPB_PROTO_ERROR	BIT(10)
+#define FSI_SISS_OPB_TIMEOUT		BIT(9)
+#define FSI_SISS_OPB_ERROR_ACK		BIT(8)
+#define FSI_SISS_MFSI_MASTER_ERROR	BIT(3)
+#define FSI_SISS_MFSI_PORT_ERROR	BIT(2)
+#define FSI_SISS_MFSI_HP		BIT(1)
+#define FSI_SISS_MFSI_CR_PARITY_ERROR	BIT(0)
+#define FSI_SISS_ALL			0xfe007f00
+
+/*
+ * SI1S fields
+ */
+#define FSI_SI1S_SLAVE_BIT	31
+#define FSI_SI1S_SHIFT_BIT	30
+#define FSI_SI1S_SCOM_BIT	29
+#define FSI_SI1S_SCRATCH_BIT	28
+#define FSI_SI1S_I2C_BIT	27
+#define FSI_SI1S_SPI_BIT	26
+#define FSI_SI1S_SBEFIFO_BIT	25
+#define FSI_SI1S_MBOX_BIT	24
+
+/*
+ * SLBUS fields
+ */
+#define FSI_SLBUS_FORCE		0x80000000	/* Force LBUS ownership */
+
+/*
+ * LLMODE fields
+ */
+#define FSI_LLMODE_ASYNC	0x1
+
 struct fsi_master;
 
 struct fsi_slave {
-- 
2.43.0


