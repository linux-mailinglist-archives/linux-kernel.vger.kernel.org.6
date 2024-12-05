Return-Path: <linux-kernel+bounces-433118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD0D9E540A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4381681BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4E1F7090;
	Thu,  5 Dec 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="husZCXaJ"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CC1F03DB;
	Thu,  5 Dec 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398419; cv=none; b=kngoyPqUYnHGPJs0R1Sw+aeBz7mKvsQWo0F88xsgL8N9MqP2cGHi/ZPRqqd0kjhMcq9GW3JFNxnExcKFsl1iZISRcUviK+NGH70LZODIKX0Cudck/ineMaYm0vb3Rx5hi87micK0uT376z7ZjugT0w7tihdbAnoe4FMZxXbhV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398419; c=relaxed/simple;
	bh=8aJSrBt7vDI0XvJjYTGTbtLzlNcvc9SAt6bZolu9r0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7A6Aga8Wia5Y1S+uVukxhqvZGFtAWU3DA6QmtM2EUuvvWn04Covem80BfS4jDOPSQq9NtePp+Jy6Nfap+ebmdVnXJORlkZTYV/GcmPYTibPTVv212GeQwSPsa+nIIsERfg5ceOZXMnQJrstcxJNyMhGNQSnUEdCLz8hnOjt8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=husZCXaJ; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B570G11015991;
	Thu, 5 Dec 2024 05:33:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=J4U/QsW7Oo9dQ9b3
	PjN9SLU2ugoMLq2bshZkcGDthcQ=; b=husZCXaJWbGOY6bpjBkl1Pk3ihZw4aO7
	T8tYXbbY9mN0R6JBT1p6illtdHVdasspNHrJzumfRjoEY5G3ZDAgalJPokJ5Jj0r
	e/y3xD+DnXqrYmIWxWRb/zXOHrtcl/wPCrSLt677QL8XazVFGE+4R3SG/4d4ClX4
	0RdTMPXaL9NHmcx0x/mRyb3z51nJfrwkk0DXq0Ah1zatOY+KKGbb9W5vRmY8uv80
	kHCizAw0CjULE2vU34w0UuVi2VtoNekfLvL5xDqQcXdwJ21FOtwllHumvFjbvTTg
	p9WB/qOj0ACWJ4WVwgzU3Ofld2pAMaqnEyxN8Yddw/UbWW4xALJK4g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4381022bhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 05:33:17 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 5 Dec
 2024 11:33:15 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 5 Dec 2024 11:33:15 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 24734820248;
	Thu,  5 Dec 2024 11:33:15 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <vkoul@kernel.org>
CC: <pierre-louis.bossart@linux.dev>, <sanyog.r.kale@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] soundwire: bus: Move irq mapping cleanup into devres
Date: Thu, 5 Dec 2024 11:33:15 +0000
Message-ID: <20241205113315.2266313-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: jcpw5c08OMdoDmA9If1NnknDHGt9INxO
X-Proofpoint-ORIG-GUID: jcpw5c08OMdoDmA9If1NnknDHGt9INxO
X-Proofpoint-Spam-Reason: safe

Currently the IRQ mapping is disposed off in sdw_drv_remove(), however
if the SoundWire device uses devres this can run before the actual device
clean up, potentially clearing the mapping whilst it is still in use.
Make this devres safe by also moving the sdw_irq_dispose_mapping into
devres.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/bus_type.c |  3 ---
 drivers/soundwire/irq.c      | 12 ++++++++----
 drivers/soundwire/irq.h      |  5 -----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 77dc094075e1..e98d5db81b1c 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -167,9 +167,6 @@ static int sdw_drv_remove(struct device *dev)
 
 	slave->probed = false;
 
-	if (slave->prop.use_domain_irq)
-		sdw_irq_dispose_mapping(slave);
-
 	mutex_unlock(&slave->sdw_dev_lock);
 
 	if (drv->remove)
diff --git a/drivers/soundwire/irq.c b/drivers/soundwire/irq.c
index 0c08cebb1235..c237e6d0766b 100644
--- a/drivers/soundwire/irq.c
+++ b/drivers/soundwire/irq.c
@@ -46,14 +46,18 @@ void sdw_irq_delete(struct sdw_bus *bus)
 	irq_domain_remove(bus->domain);
 }
 
+static void sdw_irq_dispose_mapping(void *data)
+{
+	struct sdw_slave *slave = data;
+
+	irq_dispose_mapping(irq_find_mapping(slave->bus->domain, slave->dev_num));
+}
+
 void sdw_irq_create_mapping(struct sdw_slave *slave)
 {
 	slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
 	if (!slave->irq)
 		dev_warn(&slave->dev, "Failed to map IRQ\n");
-}
 
-void sdw_irq_dispose_mapping(struct sdw_slave *slave)
-{
-	irq_dispose_mapping(irq_find_mapping(slave->bus->domain, slave->dev_num));
+	devm_add_action_or_reset(&slave->dev, sdw_irq_dispose_mapping, slave);
 }
diff --git a/drivers/soundwire/irq.h b/drivers/soundwire/irq.h
index 58a58046d92b..86e2318409da 100644
--- a/drivers/soundwire/irq.h
+++ b/drivers/soundwire/irq.h
@@ -16,7 +16,6 @@ int sdw_irq_create(struct sdw_bus *bus,
 		   struct fwnode_handle *fwnode);
 void sdw_irq_delete(struct sdw_bus *bus);
 void sdw_irq_create_mapping(struct sdw_slave *slave);
-void sdw_irq_dispose_mapping(struct sdw_slave *slave);
 
 #else /* CONFIG_IRQ_DOMAIN */
 
@@ -34,10 +33,6 @@ static inline void sdw_irq_create_mapping(struct sdw_slave *slave)
 {
 }
 
-static inline void sdw_irq_dispose_mapping(struct sdw_slave *slave)
-{
-}
-
 #endif /* CONFIG_IRQ_DOMAIN */
 
 #endif /* __SDW_IRQ_H */
-- 
2.39.5


