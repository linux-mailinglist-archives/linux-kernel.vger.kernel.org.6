Return-Path: <linux-kernel+bounces-331956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF6B97B36F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF62285F90
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D3188A02;
	Tue, 17 Sep 2024 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZhHQGwb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FD17BEBA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593423; cv=none; b=mZ+jR4yvOLRTQ8F5shr1gYCkB7ejy4T+YTLTq+CnlFHWc1LzR1rDkwZIYaXyXg7yUUQJPDDcxznRbLJqYv/iHUFnuexOh/iR3srYt/N6fS+/Vnr8RqHmKOOnk5SxwfDSXHoPXC3KZ4T5soL2BYR4wGwg7b7vDib3iTDTjJc/wRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593423; c=relaxed/simple;
	bh=R6vNDlxzpMjd4cvNhR1VF2VKpShfW1QT8piehDHAltc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYxxYAGyhd9IxXjvLt/vSYuUE21b3CfSSNeIAGMkteo/JpknreOd8vo3o72cjX12PvRowIyzEqsLIUaTHu9evY75smdRkFu5izjImNcpTuoSTHXyEssMcgrS/671V9RkyXW+A+cyMZo0aMXNWumwHZL0wIUQXk8YVegC5Ey32fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZhHQGwb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HAYVlU031830;
	Tue, 17 Sep 2024 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=MYiVufXi3qpzg
	AtUiMomcTpK4a9Yv9RJse/0tR7G80Q=; b=iZhHQGwbeC7GN32LXxlrms5ZIN1XH
	5G0K0aZ8nEPojaP4oNSlIDAfsJ5zzUnshALC+cIejnRxgJYq4nKccMzXnah2yHHk
	kYxhM5IBSC3rhuJnWqzEcALKX15/6M6KAf9jL8tRfedX/OVfsKfc+dMgX5r7JH5O
	puRoUpO8L13nRfueTKHFIcx026CWz+Ptt0aGMCz/B5Qw2l8xIU9bGDgPd1mKz5G7
	iaLuRiV9IEl325ormVGMmjPtKuvaHWxNiYKdzAhrUrsCEImt/0dqRKNr/Vn/qHyS
	HufwMfoknWChjgsNYUEhcSMEmxg61B3zbpogtb1X1DC1UvQoPrY+7RyCA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj9h8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HF6KR7000641;
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn716mxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGnQF47317286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A6365805D;
	Tue, 17 Sep 2024 17:16:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D29A058068;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 05/15] fsi: core: Calculate local bus clock frequency
Date: Tue, 17 Sep 2024 12:16:37 -0500
Message-ID: <20240917171647.1403910-6-eajames@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cc3oy5Bgyjd3qEgzuQM9pP0lb9BcP-RK
X-Proofpoint-GUID: cc3oy5Bgyjd3qEgzuQM9pP0lb9BcP-RK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170122

Instead of a hardcoded local bus clock divider, calculate the responder
local bus frequency from the FSI bus frequency.  This will allow FSI
engine drivers to set and calculate their bus (I2C, SPI, etc) frequencies.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c   | 22 +++++++++++++++++++---
 drivers/fsi/fsi-master.h |  1 +
 drivers/fsi/fsi-slave.h  |  2 ++
 include/linux/fsi.h      |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 3ddf518c6a19..1abbde4a9783 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -109,6 +109,12 @@ int fsi_device_peek(struct fsi_device *dev, void *val)
 	return fsi_slave_read(dev->slave, addr, val, sizeof(uint32_t));
 }
 
+unsigned long fsi_device_local_bus_frequency(struct fsi_device *dev)
+{
+	return dev->slave->master->clock_frequency / dev->slave->clock_div;
+}
+EXPORT_SYMBOL_GPL(fsi_device_local_bus_frequency);
+
 static void fsi_device_release(struct device *_device)
 {
 	struct fsi_device *device = to_fsi_dev(_device);
@@ -209,12 +215,12 @@ static inline uint32_t fsi_smode_sid(int x)
 	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
 }
 
-static uint32_t fsi_slave_smode(int id, u8 t_senddly, u8 t_echodly)
+static uint32_t fsi_slave_smode(int id, int div, u8 t_senddly, u8 t_echodly)
 {
 	return FSI_SMODE_WSC | FSI_SMODE_ECRC
 		| fsi_smode_sid(id)
 		| fsi_smode_echodly(t_echodly - 1) | fsi_smode_senddly(t_senddly - 1)
-		| fsi_smode_lbcrr(0x8);
+		| fsi_smode_lbcrr(div - 1);
 }
 
 static int fsi_slave_set_smode(struct fsi_slave *slave, uint8_t id)
@@ -225,7 +231,8 @@ static int fsi_slave_set_smode(struct fsi_slave *slave, uint8_t id)
 	/* set our smode register with the slave ID field to 0; this enables
 	 * extended slave addressing
 	 */
-	smode = fsi_slave_smode(slave->id, slave->t_send_delay, slave->t_echo_delay);
+	smode = fsi_slave_smode(slave->id, slave->clock_div, slave->t_send_delay,
+				slave->t_echo_delay);
 	data = cpu_to_be32(smode);
 
 	return fsi_master_write(slave->master, slave->link, id, FSI_SLAVE_BASE + FSI_SMODE,
@@ -950,6 +957,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	struct fsi_slave *slave;
 	uint8_t crc;
 	__be32 data, llmode, slbus;
+	u32 clock;
 	int rc;
 
 	/* Currently, we only support single slaves on a link, and use the
@@ -1003,6 +1011,7 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	slave->dev.of_node = fsi_slave_find_of_node(master, link, id);
 	slave->dev.release = fsi_slave_release;
 	device_initialize(&slave->dev);
+	slave->clock_div = FSI_SMODE_LBCRR_DEFAULT;
 	slave->cfam_id = cfam_id;
 	slave->master = master;
 	slave->link = link;
@@ -1020,6 +1029,10 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 
 	}
 
+	if (master->clock_frequency && !device_property_read_u32(&slave->dev, "clock-frequency",
+								 &clock) && clock)
+		slave->clock_div = DIV_ROUND_UP(master->clock_frequency, clock);
+
 	slbus = cpu_to_be32(FSI_SLBUS_FORCE);
 	rc = fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SLBUS,
 			      &slbus, sizeof(slbus));
@@ -1289,6 +1302,9 @@ int fsi_master_register(struct fsi_master *master)
 	if (!dev_name(&master->dev))
 		dev_set_name(&master->dev, "fsi%d", master->idx);
 
+	if (master->flags & FSI_MASTER_FLAG_SWCLOCK)
+		master->clock_frequency = 100000000; // POWER reference clock
+
 	master->dev.class = &fsi_master_class;
 
 	mutex_lock(&master->scan_lock);
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index a0d7ad0f0f7c..ff23983ea84c 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -121,6 +121,7 @@
 
 struct fsi_master {
 	struct device	dev;
+	unsigned long	clock_frequency;
 	int		idx;
 	int		n_links;
 	int		flags;
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index 45190b06fa02..fabc0b66d5bf 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -48,6 +48,7 @@
 #define FSI_SMODE_SD_DEFAULT	 16		/* Default send delay */
 #define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
 #define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
+#define FSI_SMODE_LBCRR_DEFAULT	 2		/* Default clk ratio */
 
 /*
  * SISS fields
@@ -104,6 +105,7 @@ struct fsi_slave {
 	int			id;	/* FSI address */
 	int			link;	/* FSI link# */
 	u32			cfam_id;
+	u32			clock_div;
 	int			chip_id;
 	uint32_t		size;	/* size of slave address space */
 	u8			t_send_delay;
diff --git a/include/linux/fsi.h b/include/linux/fsi.h
index 8c5eef808788..bf27b50652a5 100644
--- a/include/linux/fsi.h
+++ b/include/linux/fsi.h
@@ -24,6 +24,7 @@ extern int fsi_device_read(struct fsi_device *dev, uint32_t addr,
 extern int fsi_device_write(struct fsi_device *dev, uint32_t addr,
 		const void *val, size_t size);
 extern int fsi_device_peek(struct fsi_device *dev, void *val);
+extern unsigned long fsi_device_local_bus_frequency(struct fsi_device *dev);
 
 struct fsi_device_id {
 	u8	engine_type;
-- 
2.43.0


