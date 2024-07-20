Return-Path: <linux-kernel+bounces-257764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568BA937E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 03:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBE61F21FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960B748E;
	Sat, 20 Jul 2024 01:30:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9363A5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721439043; cv=none; b=gD9ixDF16PhgdiEMnzJWexOoMoImCrZBTtPCi0VuRqrlLEFiQm1n32PTrdp1OTvWFk8Oa2Ebh3KiUIifiCGwp/oHUQnFrEL6wfsDIS598atu/xmLiVJ5ZmTUM6fDvUA8zvbe2JNMtqLnmplWo8InUxXAxqT5KU6iiXVAJpN1Mxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721439043; c=relaxed/simple;
	bh=1g/GlgRpjraoXlcLgK5iOZRCDTd5JSB0ijyrsa0b9bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UP508a+GfXNotx6WEIIECo4Q7cKvuqlioe0FEfh9BFMPcn9lAE+itzm1wchjBvvEKio8+THoAv202qyOGEUKBN9Ee/t5zFX6DFKCvQvE1BTpeis1m9CgpcFdZxQ0v3Y/4Va75AE0UV0lDAobs8Z45k6RUFiDRnx8yWttHJwHDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WQplN6MTQzyN3X;
	Sat, 20 Jul 2024 09:25:52 +0800 (CST)
Received: from kwepemg200002.china.huawei.com (unknown [7.202.181.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D5E2140154;
	Sat, 20 Jul 2024 09:30:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200002.china.huawei.com
 (7.202.181.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 20 Jul
 2024 09:30:38 +0800
From: Yipeng Zou <zouyipeng@huawei.com>
To: <tglx@linutronix.de>, <maz@kernel.org>, <majun258@huawei.com>,
	<guohanjun@huawei.com>, <wangwudi@hisilicon.com>, <liaochang1@huawei.com>,
	<linux-kernel@vger.kernel.org>
CC: <zouyipeng@huawei.com>
Subject: [PATCH] irqchip/mbigen: Fix mbigen node address layout
Date: Sat, 20 Jul 2024 09:35:38 +0800
Message-ID: <20240720013538.3251995-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200002.china.huawei.com (7.202.181.29)

Mbigen chip contains several mbigen nodes, and mapped address space per
nodes one by one.

                    mbigen chip
       |-----------------|------------|--------------|
   mgn_node_0         mgn_node_1     ...         mgn_node_i
|--------------|   |--------------|       |----------------------|
[0x0000, 0x1000)   [0x1000, 0x2000)       [i*0x1000, (i+1)*0x1000)

Mbigen also defined a clear register with all other mbigen nodes in
uniform address space.

                         mbigen chip
    |-----------|--------|--------|---------------|--------|
mgn_node_0  mgn_node_1  ...  mgn_clear_register  ...   mgn_node_i
                            |-----------------|
                             [0xA000, 0xB000)

Everything is OK for now, when the mbigen nodes number less than 10,
there is no conflict with clear register.

Once we defined mbigen node more than 10, it's going to touch clear
register in unexpected way.

There should have a gap of 0x1000 between mgn_node9 and mgn_node10.

The simplest solution is directly skip clear register when access to
more than 10 mbigen nodes.

Fixes: a6c2f87b8820 ("irqchip/mbigen: Implement the mbigen irq chip operation functions")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 58881d313979..b600637f5cd7 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -64,6 +64,20 @@ struct mbigen_device {
 	void __iomem		*base;
 };
 
+static inline unsigned int get_mbigen_node_offset(unsigned int nid)
+{
+	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
+
+	/**
+	 * To avoid touched clear register in unexpected way, we need to directly
+	 * skip clear register when access to more than 10 mbigen nodes.
+	 */
+	if (nid >= (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
+		offset += MBIGEN_NODE_OFFSET;
+
+	return offset;
+}
+
 static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
@@ -72,7 +86,7 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
 
-	return pin * 4 + nid * MBIGEN_NODE_OFFSET
+	return pin * 4 + get_mbigen_node_offset(nid)
 			+ REG_MBIGEN_VEC_OFFSET;
 }
 
@@ -88,7 +102,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 	*mask = 1 << (irq_ofst % 32);
 	ofst = irq_ofst / 32 * 4;
 
-	*addr = ofst + nid * MBIGEN_NODE_OFFSET
+	*addr = ofst + get_mbigen_node_offset(nid)
 		+ REG_MBIGEN_TYPE_OFFSET;
 }
 
-- 
2.34.1


