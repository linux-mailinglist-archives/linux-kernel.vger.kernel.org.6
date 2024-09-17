Return-Path: <linux-kernel+bounces-331962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A197B375
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8ED2B24C93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4118FC92;
	Tue, 17 Sep 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f1PduCTI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231DC17C233
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593424; cv=none; b=dbyIGriIEMgPaCX9+a8nNIOThXjhyD5H4Xl/kPenvLKTvaG+OpIQywnGumsvxPn/TQHTsG/QxCMYIkxejgworipfWLh2G9HXja0QOADCdQu2mbirSQkqh/ukbx7OFAbTS1fe/TPmDywl75/S24pVk2vOW+twP5a5xcTTK4RlbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593424; c=relaxed/simple;
	bh=jIaC/3kfv4DQbKkjmLaklwnY++rNXUjoS+mUY01jZpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBMkOHbbHdanTM3C3xS1P6tHOwLVnereHjFAo7V2Etj7b6O6+psd5rFRlUpqueTHANHXz9MvvQEjTMc9SG3E2WBhRLasnmpvXBXOpj6/m0FtjVau9PfNZwDvPnD9ivlhYrBWAUI7T+HvLOyPE8rMpx/biC5hXkzVmOkJ3U5o1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f1PduCTI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HAf9rO031857;
	Tue, 17 Sep 2024 17:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=PY6/6DQFhjh9L
	oZY7SORITDwla3GRt+CRdzMs4nef5I=; b=f1PduCTIecfofUBMWwiQMBr/2s10L
	ZVnWdFIuvRvOFI4YTTb4qRdSJXUkSsdH6Oj8Faww6KWYEchTFyFcY95rN8UxC5rT
	yvvUc2A1SoCZEbelFKaUyD4tSXcXUf2sSRSHFb6v4fjzdnq8EazDgw/ttEieg+Wg
	LUjyJYZFzXMjpGrqblelw/dHJ+sL2Rhhz1QoIbNyxIgYU56jeV3yemZKNbCfjTs7
	cPDzysK7ne5M7ONeNKdyd/AyFtO9x+w6/clvR8ziXs4ueicRJVjZ9B/uR/fD2dWB
	X6TmE9H13bOzH1D82Y9uCF0aQb9NPXCB3cZQ2nFSR89PUk5C3pIRr9MWw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj9h8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HE7QHZ001871;
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nqh3p4mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGmYt55640432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9782A58058;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B68158065;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 03/15] fsi: Fix slave addressing after break command
Date: Tue, 17 Sep 2024 12:16:35 -0500
Message-ID: <20240917171647.1403910-4-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CmG5ph2IzbWfp2HQLwWEWeuDybu_0usl
X-Proofpoint-GUID: CmG5ph2IzbWfp2HQLwWEWeuDybu_0usl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

After a break command, the slave ID is set to 0x3, which means the
FSI driver should use that ID when communicating with the slave, until
SMODE is programmed with the new ID (forced to 0 for 23 bit addressing in
the current implementation). This worked previously due to a feature of
newer FSI slaves that don't enforce this requirement. Since hub masters
and I2C responders cannot address non-zero slave IDs, disable this
behavior for slaves off those masters.

Fixes: 2b545cd8e1b2 ("drivers/fsi: Implement slave initialisation")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c        | 20 ++++++++++----------
 drivers/fsi/fsi-master-hub.c  |  1 +
 drivers/fsi/fsi-master-i2cr.c |  1 +
 drivers/fsi/fsi-master.h      |  1 +
 drivers/fsi/fsi-slave.h       |  1 +
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index b50ed849f924..788b721a7d60 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -217,7 +217,7 @@ static uint32_t fsi_slave_smode(int id, u8 t_senddly, u8 t_echodly)
 		| fsi_smode_lbcrr(0x8);
 }
 
-static int fsi_slave_set_smode(struct fsi_slave *slave)
+static int fsi_slave_set_smode(struct fsi_slave *slave, uint8_t id)
 {
 	uint32_t smode;
 	__be32 data;
@@ -228,8 +228,7 @@ static int fsi_slave_set_smode(struct fsi_slave *slave)
 	smode = fsi_slave_smode(slave->id, slave->t_send_delay, slave->t_echo_delay);
 	data = cpu_to_be32(smode);
 
-	return fsi_master_write(slave->master, slave->link, slave->id,
-				FSI_SLAVE_BASE + FSI_SMODE,
+	return fsi_master_write(slave->master, slave->link, id, FSI_SLAVE_BASE + FSI_SMODE,
 				&data, sizeof(data));
 }
 
@@ -281,7 +280,7 @@ static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
 	slave->t_send_delay = send_delay;
 	slave->t_echo_delay = echo_delay;
 
-	rc = fsi_slave_set_smode(slave);
+	rc = fsi_slave_set_smode(slave, FSI_SMODE_SID_BREAK);
 	if (rc)
 		return rc;
 
@@ -773,7 +772,7 @@ static ssize_t slave_send_echo_store(struct device *dev,
 	slave->t_send_delay = val;
 	slave->t_echo_delay = val;
 
-	rc = fsi_slave_set_smode(slave);
+	rc = fsi_slave_set_smode(slave, slave->id);
 	if (rc < 0)
 		return rc;
 	if (master->link_config)
@@ -945,6 +944,8 @@ EXPORT_SYMBOL_GPL(fsi_free_minor);
 
 static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 {
+	const uint8_t break_id = (master->flags & FSI_MASTER_FLAG_NO_BREAK_SID) ? 0 :
+		FSI_SMODE_SID_BREAK;
 	uint32_t cfam_id;
 	struct fsi_slave *slave;
 	uint8_t crc;
@@ -957,7 +958,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	if (id != 0)
 		return -EINVAL;
 
-	rc = fsi_master_read(master, link, id, 0, &data, sizeof(data));
+	rc = fsi_master_read(master, link, break_id, 0, &data, sizeof(data));
 	if (rc) {
 		dev_dbg(&master->dev, "can't read slave %02x:%02x %d\n",
 				link, id, rc);
@@ -981,9 +982,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	 */
 	if (master->flags & FSI_MASTER_FLAG_SWCLOCK) {
 		llmode = cpu_to_be32(FSI_LLMODE_ASYNC);
-		rc = fsi_master_write(master, link, id,
-				FSI_SLAVE_BASE + FSI_LLMODE,
-				&llmode, sizeof(llmode));
+		rc = fsi_master_write(master, link, break_id, FSI_SLAVE_BASE + FSI_LLMODE, &llmode,
+				      sizeof(llmode));
 		if (rc)
 			dev_warn(&master->dev,
 				"can't set llmode on slave:%02x:%02x %d\n",
@@ -1028,7 +1028,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 			 "can't set slbus on slave:%02x:%02x %d\n", link, id,
 			 rc);
 
-	rc = fsi_slave_set_smode(slave);
+	rc = fsi_slave_set_smode(slave, break_id);
 	if (rc) {
 		dev_warn(&master->dev,
 				"can't set smode on slave:%02x:%02x %d\n",
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 3bfd0cea6f77..40a288b7342b 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -232,6 +232,7 @@ static int hub_master_probe(struct device *dev)
 
 	hub->master.idx = fsi_dev->slave->link + 1;
 	hub->master.n_links = links;
+	hub->master.flags = FSI_MASTER_FLAG_NO_BREAK_SID;
 	hub->master.read = hub_master_read;
 	hub->master.write = hub_master_write;
 	hub->master.send_break = hub_master_break;
diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index 40f1f4d231e5..61e55740946b 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -273,6 +273,7 @@ static int i2cr_probe(struct i2c_client *client)
 	i2cr->master.dev.release = i2cr_release;
 
 	i2cr->master.n_links = 1;
+	i2cr->master.flags = FSI_MASTER_FLAG_NO_BREAK_SID;
 	i2cr->master.read = i2cr_read;
 	i2cr->master.write = i2cr_write;
 
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 967622c1cabf..a0d7ad0f0f7c 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -111,6 +111,7 @@
 
 /* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
+#define FSI_MASTER_FLAG_NO_BREAK_SID	0x2
 
 /*
  * Structures and function prototypes
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index dba65bd4e083..f6cca04131a9 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -39,6 +39,7 @@
 #define FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
 #define FSI_SMODE_SID_SHIFT	24		/* ID shift */
 #define FSI_SMODE_SID_MASK	3		/* ID Mask */
+#define FSI_SMODE_SID_BREAK	3		/* ID after break command */
 #define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
 #define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
 #define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
-- 
2.43.0


