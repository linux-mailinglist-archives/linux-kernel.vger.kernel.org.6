Return-Path: <linux-kernel+bounces-445702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696B9F19EB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126B516B119
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BB01EE00D;
	Fri, 13 Dec 2024 23:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zg+BeNMs"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7151E5708
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132601; cv=fail; b=t0QvQstte2lvBwcc95xN26pF4QqfIdUpIasLIyt8dINpNAC3N/VLp6BZkWCG2qf9PzpmFmQDD6mp0at3xJXuyY81ZopKLkIsVhM1q73/A6jpv1yDahcadPpGVPO9TpckMpxzw4HoT5/zYQD8CilJ1xRh93F0x0vA5B5V7YKNDwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132601; c=relaxed/simple;
	bh=OVVRmDhzCPPeOuEgYxe+sUzM0RudsknsyGmExQz3zKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9tLTVnZO3nTc2mreTaBGallKsQgHvZsjld7aJNhyBPWTxsRBX6bqSG/SgqRA6WSW7x++yD7plmNCpglmArjtzuwRpDXpbKmqAZjvkRGNxHImGjbsxrNCvFtzTjdRUZkDWK+dsofAlAkz14FmZjzBobqYKMBN3haZHe2fIaLUdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zg+BeNMs; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQTVh8DaJrbjGqY4BqUKf1ly56E7VH39SgGVa6glOlgemNZF3KqtDEPukz7wc6XbU/v8FHOeB5WFPUviZUxJBn1paoG9flqskTfzo1yDyIXRp9qQeJiem+SBnPSKxhHGbK/07564LA06CiImVtck3GhFtNs7zak5Az+D/s9iwFm8olLrtbbV/IU4HSarLIzOCDK9xepb3kd5gs6LniUL7uetRgVTmVkOPyo5nn+nxL6MVtyGyKsf9FOMvXFoMMy7xpI5rch51NcIAMBH1ekF7/4e1yEx/51UD5AzyUFREN6ld77G6Jtt0aKzrFH5g5+IN7xNAlhszhbOJRNnMdDGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=360jJaHwsWgqe2r/Uop4xy3ZLo9wjDJgBf8TrwQW5g8=;
 b=WMpWIOboz1yez4qSxLUjqEEuggKMndAaWXaaGHfET56i1xRIMfAtzw9TrA3UT1fzVnS7j18OXSZZ1gWXC0Mv3f4XuGKNDvLC5TGYuzvB9VgcGM1FwYQhrP/2xwt+fHTFSMLdrTw0ZpAaV5gCITqB1PD+qWis3JWc8ixe+KYd6VP9QWng0LQU5jTwJf9T/Cxu1VtZmeX1Bmrgp6pfnAsadPWvZB5Q/YCYtooopTP0HkOerB+VYVfzHSuGzGMbEEVxhwznYWqpo6PnJYE1mVAhyVzZIeUL+QDnBHq74axqee3sxiiyKlhmyOZAKhEKY8TPFkt6BDZypE+DRar793f/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=360jJaHwsWgqe2r/Uop4xy3ZLo9wjDJgBf8TrwQW5g8=;
 b=zg+BeNMscOTgwr8plQiqYAjY9O1f2V+wzoVY0mUyALYa6CJ7gAB5sMVlEIy8JuQ1Sm87eRZ1Tb3l2LyF24m6ULr+mzqpWm4fQGN5UeJeNume5e9GVlsNSxoGo2BfPkRrwdVTL/UfQ9KZJs88Xib1lL0E3mt4i7TgIUhxpIaZriw=
Received: from CH5PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:1ed::20)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 23:29:52 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::57) by CH5PR02CA0018.outlook.office365.com
 (2603:10b6:610:1ed::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 23:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 23:29:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 17:29:51 -0600
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 17:29:51 -0600
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V3 2/5] accel/amdxdna: Replace idr api with xarray
Date: Fri, 13 Dec 2024 15:29:30 -0800
Message-ID: <20241213232933.1545388-3-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213232933.1545388-1-lizhi.hou@amd.com>
References: <20241213232933.1545388-1-lizhi.hou@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6fde12-28bd-4f12-83ed-08dd1bce0b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BK5rBwQBHPsQqrsTcoUxyr1vdwBy6CR5wEHDK2RxkaF65/O2Rf9Bgtx5rEaN?=
 =?us-ascii?Q?VV/s8wZHCOlX7PvdUKBERqPH3BHKhYhsJyerZVzsvM4G5pbxsiPFSBC5nTJx?=
 =?us-ascii?Q?L3QVL6kALKbrGSyU5aJ3nuMup3GIksqeaKMLiSyR9nL07fmsN0UPN1PhSbw6?=
 =?us-ascii?Q?TGEgtxTu072N5/85ISeMWdnW6NNP2bDZEAH+9FNPg0b2tip8RCLfprt7Dei3?=
 =?us-ascii?Q?5//aaYWdU/WRnPgBLKh3+TI4ZK/UcFEuYjIKyBEKKYz09asvw4xbmEuLIsyI?=
 =?us-ascii?Q?X9NETTdZWpFgOg40agM53Z8gxklJaJDYj8E4QKGipvDOfDHcYJV33YOb4czs?=
 =?us-ascii?Q?bvWCq1HMYnUMXzMljtfX/74pAD2gwQ9TTnHj83D8xVqMFSSZY+DKfd+PVAIg?=
 =?us-ascii?Q?Ghy1b+Jt/C48u0W5vh5GCFyfU0AvdB+/LGPoKYqewc6ns2Gmd8tjRfolkTnS?=
 =?us-ascii?Q?KnGugSdwd9cM8JXwmvpPGCwPdsmDCDrJ1AT6qXestMz6iqqK07L/iCTtxHMK?=
 =?us-ascii?Q?88gEUjbaR6wehAs4CkExm4CeeFA7iqZyA/F97WkJ/wCOrGMoTsXoCPK8wYpX?=
 =?us-ascii?Q?hfNjqmTnhAm8wZHVs+y8OQz+uLGG4AVPfU2zdbUiakhDkBJMBsWu7qB5vp+h?=
 =?us-ascii?Q?nKn8l/Ja+2agYxsqQcalsfrpI1sHJjcUGXXExcXZNeBdsIwW15f8nmo/JYLw?=
 =?us-ascii?Q?dE9SlS0AqA/7F0kNeN8drXvuBpz0OWzIrypoRiMvSdOqmJwfmpNX6L5TRHT3?=
 =?us-ascii?Q?kKLa1A+lfVFHovN9mvL8NmquGNEuxfmmOjXabRW/bEq4vV9w8KgkzXhkHfOc?=
 =?us-ascii?Q?KgF/8r4sq+qMK6BbBDZJ5sxhaaSzh2qN1zbiuDrRwIdtQd7lNJCc9IHgD+6D?=
 =?us-ascii?Q?CELw+KbHxb/mCweC6xOfNp2tuevIHMisvvHmrAWCGfQWrJXxBUX9J6AZpxzy?=
 =?us-ascii?Q?6YcJLTdn9wqmXCFB+SIxQm4G7+V37ktKnkoW6KInTO01J4C3lMHSHwL2btKO?=
 =?us-ascii?Q?w/kXU7xG+FE0kxbypyoD21gLvJqzhteSNwWPFDd0miSsEBCEeFGh421Hf2iD?=
 =?us-ascii?Q?TUmUxXQmEJPOhJBYPZ11Xg9J/8+i4Xg0ee13RdV0LkGG4XjdhkS42takSp0J?=
 =?us-ascii?Q?pjglTRoKwBQksmfqZ3QVm4OuvF5yHLq/s8VwfIkI9b3AhpG8WmKdfhmZCvpJ?=
 =?us-ascii?Q?EMlqccNdXmdZkhTGEHJT350uf50Gkv74ijs/YIzHblvIJlhaReQtw5462/e4?=
 =?us-ascii?Q?QrIMbnfmU3FA4QSSENctT31wIqR1KR6EsFzjmOzwYGLIeiymFc/q+1pSxREq?=
 =?us-ascii?Q?/h1v2I1HkQTaepOJ13/Zze3c3ieAjgWDBvKn/HQApPOECEHnq8HMINDFeJGP?=
 =?us-ascii?Q?ca3dNdARcRG8MdpFcOd6+HoBRHwtSHGLeOa+2dZ9bnV5s6z7g13Gb1EzR0mC?=
 =?us-ascii?Q?U/xuZx+x91mGnPY4e7Vi8XuDPV4PsOJf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 23:29:52.4586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6fde12-28bd-4f12-83ed-08dd1bce0b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574

Switch mailbox message id and hardware context id management over from
the idr api to the xarray api.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/TODO              |  1 -
 drivers/accel/amdxdna/aie2_ctx.c        |  5 ++-
 drivers/accel/amdxdna/aie2_message.c    |  5 ++-
 drivers/accel/amdxdna/aie2_pci.c        |  6 +--
 drivers/accel/amdxdna/amdxdna_ctx.c     | 47 +++++++++------------
 drivers/accel/amdxdna/amdxdna_mailbox.c | 56 ++++++++++---------------
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  4 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |  8 +++-
 8 files changed, 60 insertions(+), 72 deletions(-)

diff --git a/drivers/accel/amdxdna/TODO b/drivers/accel/amdxdna/TODO
index a130259f5f70..de4e1dbc8868 100644
--- a/drivers/accel/amdxdna/TODO
+++ b/drivers/accel/amdxdna/TODO
@@ -1,4 +1,3 @@
-- Replace idr with xa
 - Add import and export BO support
 - Add debugfs support
 - Add debug BO support
diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index b5282555bbf2..7218f751144c 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -11,6 +11,7 @@
 #include <drm/drm_syncobj.h>
 #include <linux/hmm.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 #include <trace/events/amdxdna.h>
 
 #include "aie2_msg_priv.h"
@@ -90,11 +91,11 @@ void aie2_restart_ctx(struct amdxdna_client *client)
 {
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_hwctx *hwctx;
-	int next = 0;
+	unsigned long hwctx_id;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 	mutex_lock(&client->hwctx_lock);
-	idr_for_each_entry_continue(&client->hwctx_idr, hwctx, next) {
+	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
 		if (hwctx->status != HWCTX_STAT_STOP)
 			continue;
 
diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index c01a1d957b56..c90f5e2fc115 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "aie2_msg_priv.h"
 #include "aie2_pci.h"
@@ -315,10 +316,10 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 	struct amdxdna_dev *xdna = ndev->xdna;
 	struct amdxdna_client *client;
 	struct amdxdna_hwctx *hwctx;
+	unsigned long hwctx_id;
 	dma_addr_t dma_addr;
 	u32 aie_bitmap = 0;
 	u8 *buff_addr;
-	int next = 0;
 	int ret, idx;
 
 	buff_addr = dma_alloc_noncoherent(xdna->ddev.dev, size, &dma_addr,
@@ -329,7 +330,7 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
 	/* Go through each hardware context and mark the AIE columns that are active */
 	list_for_each_entry(client, &xdna->client_list, node) {
 		idx = srcu_read_lock(&client->hwctx_srcu);
-		idr_for_each_entry_continue(&client->hwctx_idr, hwctx, next)
+		amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
 			aie_bitmap |= amdxdna_hwctx_col_map(hwctx);
 		srcu_read_unlock(&client->hwctx_srcu, idx);
 	}
diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
index ebf68e3f8341..25c4215cc456 100644
--- a/drivers/accel/amdxdna/aie2_pci.c
+++ b/drivers/accel/amdxdna/aie2_pci.c
@@ -15,6 +15,7 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/pci.h>
+#include <linux/xarray.h>
 
 #include "aie2_msg_priv.h"
 #include "aie2_pci.h"
@@ -691,11 +692,11 @@ static int aie2_get_hwctx_status(struct amdxdna_client *client,
 	struct amdxdna_drm_query_hwctx *tmp;
 	struct amdxdna_client *tmp_client;
 	struct amdxdna_hwctx *hwctx;
+	unsigned long hwctx_id;
 	bool overflow = false;
 	u32 req_bytes = 0;
 	u32 hw_i = 0;
 	int ret = 0;
-	int next;
 	int idx;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
@@ -707,8 +708,7 @@ static int aie2_get_hwctx_status(struct amdxdna_client *client,
 	buf = u64_to_user_ptr(args->buffer);
 	list_for_each_entry(tmp_client, &xdna->client_list, node) {
 		idx = srcu_read_lock(&tmp_client->hwctx_srcu);
-		next = 0;
-		idr_for_each_entry_continue(&tmp_client->hwctx_idr, hwctx, next) {
+		amdxdna_for_each_hwctx(tmp_client, hwctx_id, hwctx) {
 			req_bytes += sizeof(*tmp);
 			if (args->buffer_size < req_bytes) {
 				/* Continue iterating to get the required size */
diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 5478b631b73f..324f35c43f6c 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -11,6 +11,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/xarray.h>
 #include <trace/events/amdxdna.h>
 
 #include "amdxdna_ctx.h"
@@ -63,11 +64,11 @@ void amdxdna_hwctx_suspend(struct amdxdna_client *client)
 {
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_hwctx *hwctx;
-	int next = 0;
+	unsigned long hwctx_id;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 	mutex_lock(&client->hwctx_lock);
-	idr_for_each_entry_continue(&client->hwctx_idr, hwctx, next)
+	amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
 		xdna->dev_info->ops->hwctx_suspend(hwctx);
 	mutex_unlock(&client->hwctx_lock);
 }
@@ -76,11 +77,11 @@ void amdxdna_hwctx_resume(struct amdxdna_client *client)
 {
 	struct amdxdna_dev *xdna = client->xdna;
 	struct amdxdna_hwctx *hwctx;
-	int next = 0;
+	unsigned long hwctx_id;
 
 	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
 	mutex_lock(&client->hwctx_lock);
-	idr_for_each_entry_continue(&client->hwctx_idr, hwctx, next)
+	amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
 		xdna->dev_info->ops->hwctx_resume(hwctx);
 	mutex_unlock(&client->hwctx_lock);
 }
@@ -149,13 +150,13 @@ int amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
 void amdxdna_hwctx_remove_all(struct amdxdna_client *client)
 {
 	struct amdxdna_hwctx *hwctx;
-	int next = 0;
+	unsigned long hwctx_id;
 
 	mutex_lock(&client->hwctx_lock);
-	idr_for_each_entry_continue(&client->hwctx_idr, hwctx, next) {
+	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
 		XDNA_DBG(client->xdna, "PID %d close HW context %d",
 			 client->pid, hwctx->id);
-		idr_remove(&client->hwctx_idr, hwctx->id);
+		xa_erase(&client->hwctx_xa, hwctx->id);
 		mutex_unlock(&client->hwctx_lock);
 		amdxdna_hwctx_destroy_rcu(hwctx, &client->hwctx_srcu);
 		mutex_lock(&client->hwctx_lock);
@@ -194,15 +195,13 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 	hwctx->num_tiles = args->num_tiles;
 	hwctx->mem_size = args->mem_size;
 	hwctx->max_opc = args->max_opc;
-	mutex_lock(&client->hwctx_lock);
-	ret = idr_alloc_cyclic(&client->hwctx_idr, hwctx, 0, MAX_HWCTX_ID, GFP_KERNEL);
+	ret = xa_alloc_cyclic(&client->hwctx_xa, &hwctx->id, hwctx,
+			      XA_LIMIT(AMDXDNA_INVALID_CTX_HANDLE + 1, MAX_HWCTX_ID),
+			      &client->next_hwctxid, GFP_KERNEL);
 	if (ret < 0) {
-		mutex_unlock(&client->hwctx_lock);
 		XDNA_ERR(xdna, "Allocate hwctx ID failed, ret %d", ret);
 		goto free_hwctx;
 	}
-	hwctx->id = ret;
-	mutex_unlock(&client->hwctx_lock);
 
 	hwctx->name = kasprintf(GFP_KERNEL, "hwctx.%d.%d", client->pid, hwctx->id);
 	if (!hwctx->name) {
@@ -228,9 +227,7 @@ int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 free_name:
 	kfree(hwctx->name);
 rm_id:
-	mutex_lock(&client->hwctx_lock);
-	idr_remove(&client->hwctx_idr, hwctx->id);
-	mutex_unlock(&client->hwctx_lock);
+	xa_erase(&client->hwctx_xa, hwctx->id);
 free_hwctx:
 	kfree(hwctx);
 exit:
@@ -249,24 +246,18 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
 	if (!drm_dev_enter(dev, &idx))
 		return -ENODEV;
 
-	/*
-	 * Use hwctx_lock to achieve exclusion with other hwctx writers,
-	 * SRCU to synchronize with exec/wait command ioctls.
-	 *
-	 * The pushed jobs are handled by DRM scheduler during destroy.
-	 */
-	mutex_lock(&client->hwctx_lock);
-	hwctx = idr_find(&client->hwctx_idr, args->handle);
+	hwctx = xa_erase(&client->hwctx_xa, args->handle);
 	if (!hwctx) {
-		mutex_unlock(&client->hwctx_lock);
 		ret = -EINVAL;
 		XDNA_DBG(xdna, "PID %d HW context %d not exist",
 			 client->pid, args->handle);
 		goto out;
 	}
-	idr_remove(&client->hwctx_idr, hwctx->id);
-	mutex_unlock(&client->hwctx_lock);
 
+	/*
+	 * The pushed jobs are handled by DRM scheduler during destroy.
+	 * SRCU to synchronize with exec command ioctls.
+	 */
 	amdxdna_hwctx_destroy_rcu(hwctx, &client->hwctx_srcu);
 
 	XDNA_DBG(xdna, "PID %d destroyed HW context %d", client->pid, args->handle);
@@ -324,7 +315,7 @@ int amdxdna_drm_config_hwctx_ioctl(struct drm_device *dev, void *data, struct dr
 
 	mutex_lock(&xdna->dev_lock);
 	idx = srcu_read_lock(&client->hwctx_srcu);
-	hwctx = idr_find(&client->hwctx_idr, args->handle);
+	hwctx = xa_load(&client->hwctx_xa, args->handle);
 	if (!hwctx) {
 		XDNA_DBG(xdna, "PID %d failed to get hwctx %d", client->pid, args->handle);
 		ret = -EINVAL;
@@ -436,7 +427,7 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
 	}
 
 	idx = srcu_read_lock(&client->hwctx_srcu);
-	hwctx = idr_find(&client->hwctx_idr, hwctx_hdl);
+	hwctx = xa_load(&client->hwctx_xa, hwctx_hdl);
 	if (!hwctx) {
 		XDNA_DBG(xdna, "PID %d failed to get hwctx %d",
 			 client->pid, hwctx_hdl);
diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 378d985222cd..1afc8079e3d1 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/xarray.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/amdxdna.h>
@@ -55,8 +56,8 @@ struct mailbox_channel {
 	struct xdna_mailbox_chann_res	res[CHAN_RES_NUM];
 	int				msix_irq;
 	u32				iohub_int_addr;
-	struct idr			chan_idr;
-	spinlock_t			chan_idr_lock; /* protect chan_idr */
+	struct xarray			chan_xa;
+	u32				next_msgid;
 	u32				x2i_tail;
 
 	/* Received msg related fields */
@@ -165,19 +166,17 @@ static inline int mailbox_validate_msgid(int msg_id)
 
 static int mailbox_acquire_msgid(struct mailbox_channel *mb_chann, struct mailbox_msg *mb_msg)
 {
-	unsigned long flags;
-	int msg_id;
+	u32 msg_id;
+	int ret;
 
-	spin_lock_irqsave(&mb_chann->chan_idr_lock, flags);
-	msg_id = idr_alloc_cyclic(&mb_chann->chan_idr, mb_msg, 0,
-				  MAX_MSG_ID_ENTRIES, GFP_NOWAIT);
-	spin_unlock_irqrestore(&mb_chann->chan_idr_lock, flags);
-	if (msg_id < 0)
-		return msg_id;
+	ret = xa_alloc_cyclic_irq(&mb_chann->chan_xa, &msg_id, mb_msg,
+				  XA_LIMIT(0, MAX_MSG_ID_ENTRIES - 1),
+				  &mb_chann->next_msgid, GFP_NOWAIT);
+	if (ret < 0)
+		return ret;
 
 	/*
-	 * The IDR becomes less efficient when dealing with larger IDs.
-	 * Thus, add MAGIC_VAL to the higher bits.
+	 * Add MAGIC_VAL to the higher bits.
 	 */
 	msg_id |= MAGIC_VAL;
 	return msg_id;
@@ -185,25 +184,17 @@ static int mailbox_acquire_msgid(struct mailbox_channel *mb_chann, struct mailbo
 
 static void mailbox_release_msgid(struct mailbox_channel *mb_chann, int msg_id)
 {
-	unsigned long flags;
-
 	msg_id &= ~MAGIC_VAL_MASK;
-	spin_lock_irqsave(&mb_chann->chan_idr_lock, flags);
-	idr_remove(&mb_chann->chan_idr, msg_id);
-	spin_unlock_irqrestore(&mb_chann->chan_idr_lock, flags);
+	xa_erase_irq(&mb_chann->chan_xa, msg_id);
 }
 
-static int mailbox_release_msg(int id, void *p, void *data)
+static void mailbox_release_msg(struct mailbox_channel *mb_chann,
+				struct mailbox_msg *mb_msg)
 {
-	struct mailbox_channel *mb_chann = data;
-	struct mailbox_msg *mb_msg = p;
-
 	MB_DBG(mb_chann, "msg_id 0x%x msg opcode 0x%x",
 	       mb_msg->pkg.header.id, mb_msg->pkg.header.opcode);
 	mb_msg->notify_cb(mb_msg->handle, NULL, 0);
 	kfree(mb_msg);
-
-	return 0;
 }
 
 static int
@@ -255,7 +246,6 @@ mailbox_get_resp(struct mailbox_channel *mb_chann, struct xdna_msg_header *heade
 		 void *data)
 {
 	struct mailbox_msg *mb_msg;
-	unsigned long flags;
 	int msg_id;
 	int ret;
 
@@ -266,15 +256,11 @@ mailbox_get_resp(struct mailbox_channel *mb_chann, struct xdna_msg_header *heade
 	}
 
 	msg_id &= ~MAGIC_VAL_MASK;
-	spin_lock_irqsave(&mb_chann->chan_idr_lock, flags);
-	mb_msg = idr_find(&mb_chann->chan_idr, msg_id);
+	mb_msg = xa_erase_irq(&mb_chann->chan_xa, msg_id);
 	if (!mb_msg) {
 		MB_ERR(mb_chann, "Cannot find msg 0x%x", msg_id);
-		spin_unlock_irqrestore(&mb_chann->chan_idr_lock, flags);
 		return -EINVAL;
 	}
-	idr_remove(&mb_chann->chan_idr, msg_id);
-	spin_unlock_irqrestore(&mb_chann->chan_idr_lock, flags);
 
 	MB_DBG(mb_chann, "opcode 0x%x size %d id 0x%x",
 	       header->opcode, header->total_size, header->id);
@@ -498,8 +484,7 @@ xdna_mailbox_create_channel(struct mailbox *mb,
 	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
 	memcpy(&mb_chann->res[CHAN_RES_I2X], i2x, sizeof(*i2x));
 
-	spin_lock_init(&mb_chann->chan_idr_lock);
-	idr_init(&mb_chann->chan_idr);
+	xa_init_flags(&mb_chann->chan_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	mb_chann->x2i_tail = mailbox_get_tailptr(mb_chann, CHAN_RES_X2I);
 	mb_chann->i2x_head = mailbox_get_headptr(mb_chann, CHAN_RES_I2X);
 
@@ -531,13 +516,18 @@ xdna_mailbox_create_channel(struct mailbox *mb,
 
 int xdna_mailbox_destroy_channel(struct mailbox_channel *mb_chann)
 {
+	struct mailbox_msg *mb_msg;
+	unsigned long msg_id;
+
 	MB_DBG(mb_chann, "IRQ disabled and RX work cancelled");
 	free_irq(mb_chann->msix_irq, mb_chann);
 	destroy_workqueue(mb_chann->work_q);
 	/* We can clean up and release resources */
 
-	idr_for_each(&mb_chann->chan_idr, mailbox_release_msg, mb_chann);
-	idr_destroy(&mb_chann->chan_idr);
+	xa_for_each(&mb_chann->chan_xa, msg_id, mb_msg)
+		mailbox_release_msg(mb_chann, mb_msg);
+
+	xa_destroy(&mb_chann->chan_xa);
 
 	MB_DBG(mb_chann, "Mailbox channel destroyed, irq: %d", mb_chann->msix_irq);
 	kfree(mb_chann);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index 0ba2af987837..c00ca314d033 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -78,7 +78,7 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
 	}
 	mutex_init(&client->hwctx_lock);
 	init_srcu_struct(&client->hwctx_srcu);
-	idr_init_base(&client->hwctx_idr, AMDXDNA_INVALID_CTX_HANDLE + 1);
+	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
 	mutex_init(&client->mm_lock);
 
 	mutex_lock(&xdna->dev_lock);
@@ -109,7 +109,7 @@ static void amdxdna_drm_close(struct drm_device *ddev, struct drm_file *filp)
 
 	XDNA_DBG(xdna, "closing pid %d", client->pid);
 
-	idr_destroy(&client->hwctx_idr);
+	xa_destroy(&client->hwctx_xa);
 	cleanup_srcu_struct(&client->hwctx_srcu);
 	mutex_destroy(&client->hwctx_lock);
 	mutex_destroy(&client->mm_lock);
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
index 0c2e31c05d3e..b62b63a66098 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
@@ -6,6 +6,8 @@
 #ifndef _AMDXDNA_PCI_DRV_H_
 #define _AMDXDNA_PCI_DRV_H_
 
+#include <linux/xarray.h>
+
 #define XDNA_INFO(xdna, fmt, args...)	drm_info(&(xdna)->ddev, fmt, ##args)
 #define XDNA_WARN(xdna, fmt, args...)	drm_warn(&(xdna)->ddev, "%s: "fmt, __func__, ##args)
 #define XDNA_ERR(xdna, fmt, args...)	drm_err(&(xdna)->ddev, "%s: "fmt, __func__, ##args)
@@ -100,7 +102,8 @@ struct amdxdna_client {
 	struct mutex			hwctx_lock; /* protect hwctx */
 	/* do NOT wait this srcu when hwctx_lock is held */
 	struct srcu_struct		hwctx_srcu;
-	struct idr			hwctx_idr;
+	struct xarray			hwctx_xa;
+	u32				next_hwctxid;
 	struct amdxdna_dev		*xdna;
 	struct drm_file			*filp;
 
@@ -111,6 +114,9 @@ struct amdxdna_client {
 	int				pasid;
 };
 
+#define amdxdna_for_each_hwctx(client, hwctx_id, entry)		\
+	xa_for_each(&(client)->hwctx_xa, hwctx_id, entry)
+
 /* Add device info below */
 extern const struct amdxdna_dev_info dev_npu1_info;
 extern const struct amdxdna_dev_info dev_npu2_info;
-- 
2.34.1


