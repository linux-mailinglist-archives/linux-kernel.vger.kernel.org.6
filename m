Return-Path: <linux-kernel+bounces-568674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B658FA6992B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683324846D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A172144B0;
	Wed, 19 Mar 2025 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hca4S8Vb"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56853214A66
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412255; cv=fail; b=l2xXHJ9kDjrm6SKj0zZV5/o/glmxfxCi1hQoIG0qp/KmmfyuK4FRYIEjgdvZV5H/2i9QFBUoioVJgj1nHmitRNRrIGXLWDMeHhrYKzEVwHZlHQhwbIIfW4PdFJ/766d1YvZ9pC0AXP3cy8Syuw1hDh+teVnJMQMUluUpers4kyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412255; c=relaxed/simple;
	bh=zoBJMZnCsHBreLGRFqINdcwUQR6uqGw11E67yjy6m10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkZesOZ5GpgVBh3n+bqANgbE12nKMkbEY/PBpG0CF/8CEGOmoBKFNhVDP7Qjb19b4SBvDzUDDZ17NabhCtSkM8tGYF/xx17pdXWsrPxYvV7+bkMH5+MjHb4b2uyb3j6Pic5KceQAka3MwaORf/HrrYfQhc/kgxFO6DFKChWbw8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hca4S8Vb; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvfQ621e1doNOrcBS1py9X0CzzNjVIY/YO1wRKFxunsk0WuwNc/foKf5vWEM++fHD7cqofmaxJmDdj0BbC8OsBPmWaPhbrKZpoFfCfPeZCCDv33AgCdUGBd2SOKlY/BJPqV4zJEyT/ZfG1SfgsrIDn8eT/yQh3fFdXG70iQL69E5Z6qjXBqzfRQsGmq3xNWwNy1/cQt61LRYqAWoBIRhSRJoPKfHvl0qnn5Y4JmXfmiPzLNk2ipT3BQ7NZMWOsakVW73Hta8hJP/lXty6DdxbDtqcLVmp57f0Qk4Qv5Fbh4bXXdv0nBbxQEe3E7fbq1+XXVx90A5jR01mBvbAdvodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpXcxvR43WjPNZga97MpcBVDDzX5U8hqC4yBCUzSERo=;
 b=zG0dbuRmRnykwBuMMrJrwMX2j+IwEeCKmmmJryqh6zFpVSeqh+LdZpJsZ92+cMaByba5M+LKWIJkqIkEY7fYdPDztcJR22iLvpzajm08cdy04YNbWewNC4fAYvSLNgFuLADZTPIt6hK+9rF9NSWR0ZerpJO8i16JX6H617TuEi8SMi5ePGPcOva/HJGulAFf8ew3rE03oWGOkD6ST915ohumsuWtPyc4zE6gd3wKQOe9VS42ylbo0ykMLPpoMnPCoGjTGPfpqPwuiqQatvs5vuFoY7MIO/qQCC3tSIigDhGbpmPZn3ZiDXVmSS/tbB6/Q8oi2hLGAuEH9605hMShrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpXcxvR43WjPNZga97MpcBVDDzX5U8hqC4yBCUzSERo=;
 b=hca4S8VbCULl5rMm26fdTMYeH9s1LyBi50x0JiCk0gcNHn1UKAbHOViGmVAqcWhNOEJIxCmjHuueJ0z4XKRV3G6coc5eKz8r2/BJ8HgpWc1rgYJLcc1x8bSc5eFNav3AQE8XuNLAjRbY/RXkbcFHpnoOsqw/6SOK2qUpZjpkQDg=
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:24:06 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::b3) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:24:06 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:23:58 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <baolin.wang@linux.alibaba.com>,
	<bharata@amd.com>, <david@redhat.com>, <gregory.price@memverge.com>,
	<honggyu.kim@sk.com>, <jane.chu@oracle.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mel.gorman@gmail.com>,
	<Michael.Day@amd.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>,
	<wangkefeng.wang@huawei.com>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <anannara@amd.com>, <wei.huang2@amd.com>,
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>
Subject: [PATCH RFC V2 7/9] dcbm: add dma core batch migrator for batch page offloading
Date: Wed, 19 Mar 2025 19:22:10 +0000
Message-ID: <20250319192211.10092-8-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192211.10092-1-shivankg@amd.com>
References: <20250319192211.10092-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d478642-28ce-4af5-b404-08dd671b9dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xQDoEqiktFI/GctzlhTV4b01Jap78eIsK+aQeK8LsVChK7eoGmEprWSrQa2?=
 =?us-ascii?Q?hCVr9wAYyNSu3UkSsoqfbYby0C96ZHqFDKyCvUgb86UJoeLowlLdbaU+sDtu?=
 =?us-ascii?Q?X4c6nET7I7bYzzYi/qPnip1xpT9xAigd0j+tvg2SLxW9wTKlt2u1RsPpd+ES?=
 =?us-ascii?Q?m+5RVI2yCITfHhxkU9PmSmn1n+LGyE3KwvThHLC8acf9TX5VJmzo0c5ojmKZ?=
 =?us-ascii?Q?GNlzg6gX3hlPlAMg3fhlry8SiWWf8NrywCNehRuXn3fcovRpMN+xFbZHWQa5?=
 =?us-ascii?Q?+u/AAlSYfukQAF43tiKQakrfcL9r3fE+VLZTIVct1U0MCWZpt+DW7y+lpdnB?=
 =?us-ascii?Q?KqC6nXk3DBLw13h6NY3FcA2JqevLOIeoX8WnHoZRkz6pzKjAUrfG31QbZ631?=
 =?us-ascii?Q?LrGR8ysRgDZxj6ckTp6/KJVbpytD+n33+b9iSCPA5JpSnmO1YtDErZtj0IKl?=
 =?us-ascii?Q?7j/yJLs0bzBlqf8v+S1jwGKv9y22ZqhqhAetz/lBHXCl1wEmgyLrh28BieVV?=
 =?us-ascii?Q?O9N6bx2UBbTfiK7I+0ma+ERrj3nhS6x6w3si94oUZ25/GVncv1+fwnLU5bgd?=
 =?us-ascii?Q?TvPLL1kuLoQPmeFkPlGglF3QyFxoqIRZq1oKZEVRuslndLBK5ZrToe4k6fqp?=
 =?us-ascii?Q?kQalbgfa8sniTYZlFBOKfcQhf7IJ1pWJPIcdE1JNh4k6xz/AKPfX7iRt70e0?=
 =?us-ascii?Q?XRnMzlB/TjKs1iAK/Qv9KS4QQVpaB/Y0E5eiPQRvkDjk8rQauhnAbSoWHc07?=
 =?us-ascii?Q?UtL1w5XqX8mxSXV1KpbC1UwsYHTVZnXwjuqu154lZpe9boAl+gjYI+OC9T2r?=
 =?us-ascii?Q?kv2X/DNSZHosLNeczQQHnWl5+FuKmlMqChFyHv8VmPO0B1BLB/NYsHbLBgw/?=
 =?us-ascii?Q?s/ayXNMZDNRdp7zVzBVFHDFvQxskAfhD0cbY5AUuNEz+Vt0Fnf74bjGPjL8G?=
 =?us-ascii?Q?TtzU5GvDuewQkI14WJXlaQUCypQ5MghooIGppzXfkTXufhGJdaHrT5SrM1Iw?=
 =?us-ascii?Q?hcuP0+HN6bF9zJXGzPDFcjGKLfYJTmNkpDlGSUXU/66dyqTg2pH5+gOs9eic?=
 =?us-ascii?Q?KM3k6y/NslIdvRA/e+R4MG6YrjigV1FlKZloSzvLrO5HBqMKaVWB0CKrOGjB?=
 =?us-ascii?Q?sARg9lRWsdRF38fFdIDO/KbqUJ6rYl+kHJ2ijBz8cwLasCq2FMdtDTXCXazl?=
 =?us-ascii?Q?1nS3lCjtJeKNSjgCCC7TVPxUSRIhmlFpkPBHX6xDRzwCH99mqF0Dyd01gXiS?=
 =?us-ascii?Q?LoEoR52wgNmHHhz2lkIkZb9kb95D/ukF7bDcv21wqQMkfsDzPqz/UnxDiu1v?=
 =?us-ascii?Q?5ELs8DmWjj15V14AsAIAsbyH1Wdj5GUD+qQiFd24+0Ucd3qZuHX5OO2UGN72?=
 =?us-ascii?Q?WZkn0rVUPu8jUCCK6cJwThy6Ks+cz3kwt7HgcvzJKTuP+J2rDys9VYoKxjxI?=
 =?us-ascii?Q?344mgNw/4IOSQ3FDsgRZXoPj4/OulCrJIFAiQIadoIVbc5vw2znKtoHarMQA?=
 =?us-ascii?Q?4aMzQh4FdBflFdU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:06.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d478642-28ce-4af5-b404-08dd671b9dcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846

The dcbm (DMA core batch migrator) provides a generic interface using
DMAEngine for end-to-end testing of the batch page migration offload
feature.

Enable DCBM offload:
echo 1 > /sys/kernel/dcbm/offloading
echo NR_DMA_CHAN_TO_USE > /sys/kernel/dcbm/nr_dma_chan

Disable DCBM offload:
echo 0 > /sys/kernel/dcbm/offloading

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/migoffcopy/Kconfig       |   8 +
 drivers/migoffcopy/Makefile      |   1 +
 drivers/migoffcopy/dcbm/Makefile |   1 +
 drivers/migoffcopy/dcbm/dcbm.c   | 393 +++++++++++++++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 drivers/migoffcopy/dcbm/Makefile
 create mode 100644 drivers/migoffcopy/dcbm/dcbm.c

diff --git a/drivers/migoffcopy/Kconfig b/drivers/migoffcopy/Kconfig
index e73698af3e72..c1b2eff7650d 100644
--- a/drivers/migoffcopy/Kconfig
+++ b/drivers/migoffcopy/Kconfig
@@ -6,4 +6,12 @@ config MTCOPY_CPU
          Interface MT COPY CPU driver for batch page migration
          offloading. Say Y if you want to try offloading with
          MultiThreaded CPU copy APIs.
+config DCBM_DMA
+       bool "DMA Core Batch Migrator"
+       depends on OFFC_MIGRATION && DMA_ENGINE
+       default n
+       help
+         Interface DMA driver for batch page migration offloading.
+         Say Y if you want to try offloading with DMAEngine APIs
+         based driver.
 
diff --git a/drivers/migoffcopy/Makefile b/drivers/migoffcopy/Makefile
index 0a3c356d67e6..dedc86ff54c1 100644
--- a/drivers/migoffcopy/Makefile
+++ b/drivers/migoffcopy/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MTCOPY_CPU) += mtcopy/
+obj-$(CONFIG_DCBM_DMA)		+= dcbm/
diff --git a/drivers/migoffcopy/dcbm/Makefile b/drivers/migoffcopy/dcbm/Makefile
new file mode 100644
index 000000000000..56ba47cce0f1
--- /dev/null
+++ b/drivers/migoffcopy/dcbm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DCBM_DMA) += dcbm.o
diff --git a/drivers/migoffcopy/dcbm/dcbm.c b/drivers/migoffcopy/dcbm/dcbm.c
new file mode 100644
index 000000000000..185d8d2502fd
--- /dev/null
+++ b/drivers/migoffcopy/dcbm/dcbm.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *
+ * DMA batch-offlading interface driver
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+/*
+ * This code exemplifies how to leverage mm layer's migration offload support
+ * for batch page offloading using DMA Engine APIs.
+ * Developers can use this template to write interface for custom hardware
+ * accelerators with specialized capabilities for batch page migration.
+ * This interface driver is end-to-end working and can be used for testing the
+ * patch series without special hardware given DMAEngine support is available.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/migrate.h>
+#include <linux/migrate_offc.h>
+#include <linux/printk.h>
+#include <linux/sysfs.h>
+
+#define MAX_DMA_CHANNELS 16
+
+static int is_dispatching;
+static int nr_dma_chan;
+
+static int folios_copy_dma(struct list_head *dst_list, struct list_head *src_list, int folios_cnt);
+static int folios_copy_dma_parallel(struct list_head *dst_list, struct list_head *src_list, int folios_cnt, int thread_count);
+static bool can_migrate_dma(struct folio *dst, struct folio *src);
+
+static DEFINE_MUTEX(migratecfg_mutex);
+
+/* DMA Core Batch Migrator */
+struct migrator dmigrator = {
+	.name = "DCBM\0",
+	.migrate_offc = folios_copy_dma,
+	.can_migrate_offc = can_migrate_dma,
+	.owner = THIS_MODULE,
+};
+
+static ssize_t offloading_set(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ccode;
+	int action;
+
+	ccode = kstrtoint(buf, 0, &action);
+	if (ccode) {
+		pr_debug("(%s:) error parsing input %s\n", __func__, buf);
+		return ccode;
+	}
+
+	/*
+	 * action is 0: User wants to disable DMA offloading.
+	 * action is 1: User wants to enable DMA offloading.
+	 */
+	switch (action) {
+	case 0:
+		mutex_lock(&migratecfg_mutex);
+		if (is_dispatching == 1) {
+			stop_offloading();
+			is_dispatching = 0;
+		} else
+			pr_debug("migration offloading is already OFF\n");
+		mutex_unlock(&migratecfg_mutex);
+		break;
+	case 1:
+		mutex_lock(&migratecfg_mutex);
+		if (is_dispatching == 0) {
+			start_offloading(&dmigrator);
+			is_dispatching = 1;
+		} else
+			pr_debug("migration offloading is already ON\n");
+		mutex_unlock(&migratecfg_mutex);
+		break;
+	default:
+		pr_debug("input should be zero or one, parsed as %d\n", action);
+	}
+	return sizeof(action);
+}
+
+static ssize_t offloading_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", is_dispatching);
+}
+
+static ssize_t nr_dma_chan_set(struct kobject *kobj, struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ccode;
+	int action;
+
+	ccode = kstrtoint(buf, 0, &action);
+	if (ccode) {
+		pr_err("(%s:) error parsing input %s\n", __func__, buf);
+		return ccode;
+	}
+
+	if (action < 1) {
+		pr_err("%s: invalid value, at least 1 channel\n",__func__);
+		return -EINVAL;
+	}
+	if (action >= MAX_DMA_CHANNELS)
+		action = MAX_DMA_CHANNELS;
+
+	mutex_lock(&migratecfg_mutex);
+	nr_dma_chan = action;
+	mutex_unlock(&migratecfg_mutex);
+
+	return sizeof(action);
+}
+
+static ssize_t nr_dma_chan_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", nr_dma_chan);
+}
+
+static bool can_migrate_dma(struct folio *dst, struct folio *src)
+{
+
+//	printk("folio_size %d\n",folio_size(src));
+	if (folio_test_hugetlb(src) || folio_test_hugetlb(dst) ||
+			folio_has_private(src) || folio_has_private(dst) ||
+			(folio_nr_pages(src) != folio_nr_pages(dst))) {
+		pr_err("can NOT DMA migrate this folio %p\n",src);
+		return false;
+	}
+	return true;
+}
+
+/**
+ * DMA channel and track its transfers
+ */
+struct dma_channel_work {
+	struct dma_chan *chan;
+	struct completion done;
+	int active_transfers;
+	spinlock_t lock;
+};
+
+/**
+ * Callback for DMA completion
+ */
+static void folios_dma_completion_callback(void *param)
+{
+	struct dma_channel_work *chan_work = param;
+
+	spin_lock(&chan_work->lock);
+	chan_work->active_transfers--;
+	if (chan_work->active_transfers == 0)
+		complete(&chan_work->done);
+	spin_unlock(&chan_work->lock);
+}
+
+/**
+ * process dma transfer: preparation part: map, prep_memcpy
+ */
+static int process_folio_dma_transfer(struct dma_channel_work *chan_work,
+				      struct folio *src, struct folio *dst)
+{
+	struct dma_chan *chan = chan_work->chan;
+	struct dma_device *dev = chan->device;
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
+	dma_cookie_t cookie;
+	struct dma_async_tx_descriptor *tx;
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	dma_addr_t srcdma_handle, dstdma_handle;
+	size_t data_size = folio_size(src);
+
+	/* Map source and destination pages */
+	srcdma_handle = dma_map_page(dma_dev, &src->page, 0, data_size, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, srcdma_handle)) {
+		pr_err("src mapping error\n");
+		return -ENOMEM;
+	}
+
+	dstdma_handle = dma_map_page(dma_dev, &dst->page, 0, data_size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dev, dstdma_handle)) {
+		pr_err("dst mapping error\n");
+		dma_unmap_page(dma_dev, srcdma_handle, data_size, DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
+
+	/* Prepare DMA descriptor */
+	tx = dev->device_prep_dma_memcpy(chan, dstdma_handle, srcdma_handle,
+					 data_size, flags);
+	if (unlikely(!tx)) {
+		pr_err("prep_dma_memcpy error\n");
+		dma_unmap_page(dma_dev, dstdma_handle, data_size, DMA_FROM_DEVICE);
+		dma_unmap_page(dma_dev, srcdma_handle, data_size, DMA_TO_DEVICE);
+		return -EBUSY;
+	}
+
+	/* Set up completion callback */
+	tx->callback = folios_dma_completion_callback;
+	tx->callback_param = chan_work;
+
+	/* Submit DMA transaction */
+	spin_lock(&chan_work->lock);
+	chan_work->active_transfers++;
+	spin_unlock(&chan_work->lock);
+
+	cookie = tx->tx_submit(tx);
+	if (dma_submit_error(cookie)) {
+		pr_err("dma_submit_error\n");
+		spin_lock(&chan_work->lock);
+		chan_work->active_transfers--;
+		spin_unlock(&chan_work->lock);
+		dma_unmap_page(dma_dev, dstdma_handle, data_size, DMA_FROM_DEVICE);
+		dma_unmap_page(dma_dev, srcdma_handle, data_size, DMA_TO_DEVICE);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * Copy folios using DMA in parallel.
+ * Divide into chunks, submit to DMA channels.
+ * if error, falls back to CPU
+ * Note: return 0 for all cases as error is taken care.
+ * TODO: Add poison recovery support.
+ */
+int folios_copy_dma_parallel(struct list_head *dst_list,
+			      struct list_head *src_list,
+			      int folios_cnt_total, int thread_count)
+{
+	struct dma_channel_work *chan_works;
+	struct dma_chan **channels;
+	int i, actual_channels = 0;
+	struct folio *src, *dst;
+	dma_cap_mask_t mask;
+	int channel_idx = 0;
+	int failed = 0;
+	int ret;
+
+	/* TODO: optimise actual number of channels needed
+	at what point DMA set-up overheads < mig cost for N folio*/
+	thread_count = min(thread_count, folios_cnt_total);
+
+	/* Allocate memory for channels */
+	channels = kmalloc_array(thread_count, sizeof(struct dma_chan *), GFP_KERNEL);
+	if (unlikely(!channels)) {
+		pr_err("failed to allocate memory for channels\n");
+		folios_copy(dst_list, src_list, folios_cnt_total);
+		return 0;
+	}
+
+	/* Request DMA channels */
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+	for (i = 0; i < thread_count; i++) {
+		channels[i] = dma_request_channel(mask, NULL, NULL);
+		if (!channels[i]) {
+			pr_err("could only allocate %d DMA channels\n", i);
+			break;
+		}
+		actual_channels++;
+	}
+
+	if (unlikely(actual_channels == 0)) {
+		pr_err("couldn't allocate any DMA channels, falling back to CPU copy\n");
+		kfree(channels);
+		folios_copy(dst_list, src_list, folios_cnt_total);
+		return 0;
+	}
+
+	/* Allocate work structures */
+	chan_works = kmalloc_array(actual_channels, sizeof(*chan_works), GFP_KERNEL);
+	if (unlikely(!chan_works)) {
+		pr_err("failed to allocate memory for work structures\n");
+		for (i = 0; i < actual_channels; i++)
+			dma_release_channel(channels[i]);
+		kfree(channels);
+		folios_copy(dst_list, src_list, folios_cnt_total);
+		return 0;
+	}
+
+	/* Initialize work structures */
+	for (i = 0; i < actual_channels; i++) {
+		chan_works[i].chan = channels[i];
+		init_completion(&chan_works[i].done);
+		chan_works[i].active_transfers = 0;
+		spin_lock_init(&chan_works[i].lock);
+	}
+
+	/* STEP 1: Submit all DMA transfers across all channels */
+	dst = list_first_entry(dst_list, struct folio, lru);
+	list_for_each_entry(src, src_list, lru) {
+		ret = process_folio_dma_transfer(&chan_works[channel_idx], src, dst);
+		if (unlikely(ret)) {
+			/* Fallback to CPU */
+			folio_copy(dst, src);
+			failed++;
+		}
+
+		channel_idx = (channel_idx + 1) % actual_channels;
+
+		dst = list_next_entry(dst, lru);
+	}
+
+	/* STEP 2: Issue all pending DMA requests */
+	for (i = 0; i < actual_channels; i++) {
+		dma_async_issue_pending(chan_works[i].chan);
+	}
+
+	/* STEP 3: Wait for all DMA operations to complete */
+	for (i = 0; i < actual_channels; i++) {
+		wait_for_completion(&chan_works[i].done);
+	}
+
+	if (failed)
+		pr_err("processed %d fallback with CPU\n", failed);
+
+	/* Release all resources */
+	for (i = 0; i < actual_channels; i++) {
+		dma_release_channel(channels[i]);
+	}
+
+	kfree(chan_works);
+	kfree(channels);
+
+	return 0;
+}
+
+/**
+ * Similar to folios_copy but use dma.
+ */
+static int folios_copy_dma(struct list_head *dst_list,
+			    struct list_head *src_list,
+			    int folios_cnt)
+{
+	return folios_copy_dma_parallel(dst_list, src_list, folios_cnt, nr_dma_chan);
+}
+
+static struct kobject *kobj_ref;
+static struct kobj_attribute offloading_attribute = __ATTR(offloading, 0664,
+		offloading_show, offloading_set);
+static struct kobj_attribute nr_dma_chan_attribute = __ATTR(nr_dma_chan, 0664,
+		nr_dma_chan_show, nr_dma_chan_set);
+
+static int __init dma_module_init(void)
+{
+	int ret = 0;
+
+	kobj_ref = kobject_create_and_add("dcbm", kernel_kobj);
+	if (!kobj_ref)
+		return -ENOMEM;
+
+	ret = sysfs_create_file(kobj_ref, &offloading_attribute.attr);
+	if (ret)
+		goto out;
+
+	ret = sysfs_create_file(kobj_ref, &nr_dma_chan_attribute.attr);
+	if (ret)
+		goto out;
+
+	is_dispatching = 0;
+	nr_dma_chan = 1;
+
+	return 0;
+out:
+	kobject_put(kobj_ref);
+	return ret;
+}
+
+static void __exit dma_module_exit(void)
+{
+	/* Stop the DMA offloading to unload the module */
+	sysfs_remove_file(kobj_ref, &offloading_attribute.attr);
+	sysfs_remove_file(kobj_ref, &nr_dma_chan_attribute.attr);
+	kobject_put(kobj_ref);
+}
+
+module_init(dma_module_init);
+module_exit(dma_module_exit);
+
+/* DMA Core Batch Migrator */
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Shivank Garg");
+MODULE_DESCRIPTION("DCBM");
-- 
2.34.1


