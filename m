Return-Path: <linux-kernel+bounces-179326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CBD8C5ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088A51F2203C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD020E6;
	Wed, 15 May 2024 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e4/5VL1H"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C624A2A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737432; cv=fail; b=aRvmIehXA2EAC3KrFe4mGd7SmP+0rguIZe6nC5jANAXT0Y2vETmTcby8lj6+QDNcjP2jYlXWxa8bKa2z4Y+Z438x1FFME+pO21yiGYB7IlEFxH38gN9wTM8i2IGVFk/bm6z6Yr5cMRTrLzwNdjXncKK8aP4JLZ1ROBzjdWbF4WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737432; c=relaxed/simple;
	bh=rL6m69wgct2h+l4mNEQ1YQ3wI5tAiw9jAp38xOk4ZgI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=unE/K9UT1fOjP34/ws5jfn0VjKRpgsHPllSDd4poo2khZci2xnkj753qDaxo3mtQ0KO1iDx+K3kdJ9rqPxz/+7ithuumRp+9eKz2pWhHwFRnARZrbApHfA8+y4nX5nxBuelCV9kGYs0A+4iu5ERlHxlfjMTQxHnkzaaaV3LLlY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e4/5VL1H; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFBoMyfxkhFIxIy3S7xIiehYUxmhedabpojIPA/MfYoZdY2UokTfguasUcy89r0F/WFIcLLYPN0WvEEyifpnBDCdpVJB+q94fh1qKznZGBKzjQdqPLdF78WKm2aACsrKGugBq64C5eCfbPaqFX/jWbym0Qgy44m2kjyvtAgXkxoq/gc1Kpc6s/AOcyPAX7KZCgooXbel7jkDDS8DqDUNzmMi6eAAeUxTppkdPnuS6M/uPk23QwmSsIiDJPkmCggAYc4C9HJAnGwdvN3K0WJeNDpde1IZAo91DUo3zM6cIIncAZAIHpPMRS/JeVg3arCdBRGVDO+0vOm40Fq9H1ACiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9Mo9dcjzNCPuVSTk1Qb4E60fo4KMmya7iYoi3zTTWY=;
 b=TGLCnzRCB29j5QcYGXVlvVmfhICyUUfz0oOLZmzDUIFaadVL//H0ZeKrOLMnd0AItsfZbi4eaXoG3PS75tW9KpZbCOOXktCwd2s1VcaRy+vkeQSbcRsPglp2JidQOXkfFxzYrTaUbGIB98jwR3TMnSBSzNidZ44cz5xfo15fr5hcU6JG0HIulkVE7owAH0ynsgNCgOKLUwc1yb4K7N1wfzJush36t9Ye4sOkrb1Z2TKQb2ZdwOWsg86SK7rOk7xY1vVb444Z6XIeiSdPuVn9nSbzAnM3QfMmoKuAHeKWIaHX6HLfS7Yzd0QGDqyB8hcqI+fXU66zlLp5AlKPfkaekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.xenproject.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9Mo9dcjzNCPuVSTk1Qb4E60fo4KMmya7iYoi3zTTWY=;
 b=e4/5VL1Hg/ZkmMZiWziQL/vAVLpD4gpMWEipjaIc7sTOvOrw49b1D8Z3BtAXAcB25s0g8sqGSJKvTqfofv4HivmkdWnh+4PMEztyKJkzIjigAekdhLC8DYRufURSJ73f3g0y4IoluXgVcs7Z+1AcbOqNal2LBQ3Bev5un394cjE=
Received: from SA9PR13CA0060.namprd13.prod.outlook.com (2603:10b6:806:22::35)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 01:43:45 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::a2) by SA9PR13CA0060.outlook.office365.com
 (2603:10b6:806:22::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Wed, 15 May 2024 01:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 01:43:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 20:43:44 -0500
Received: from henry-MS-7D54.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 20:43:42 -0500
From: Henry Wang <xin.wang2@amd.com>
To: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC: Henry Wang <xin.wang2@amd.com>, Juergen Gross <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Michal Orzel <michal.orzel@amd.com>
Subject: [PATCH] drivers/xen: Improve the late XenStore init protocol
Date: Wed, 15 May 2024 09:43:30 +0800
Message-ID: <20240515014330.1044617-1-xin.wang2@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xin.wang2@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a6b98b-32b5-4f2d-7f64-08dc7480750f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qaa5iZHwudBr6Y7Q5p2814qTq2Rmlqeenf++Xa2C+u6cCutSNQGZO0HNRaO/?=
 =?us-ascii?Q?kAVe5wbHqXen9F7FoG4Om4fCmqLoC/anR0Dfgw1mcBduElhp1J4mC/n7J2ts?=
 =?us-ascii?Q?q3ZXu9ipOcXDkTgYCpynQDBdbbaZUmGfCfRd0VXn7e8Je6West5rjyOazkP5?=
 =?us-ascii?Q?DFkJLTNVmXV7ls9bpFVYE/DXzYM2r1CK++wsMU287YZCTok393L4DTqdjbGm?=
 =?us-ascii?Q?kUVbpS1zCAKqvKdKv1E4JIdNlxSabIC3JXsymmJoJbQI831MgfYD+QlPPOdj?=
 =?us-ascii?Q?pSOhW18qvFjKNhBPCpyHYBBoxNcAukm/nJBCQyv24g1eKpFIuzCIH5m1929f?=
 =?us-ascii?Q?zh7pVoUiUX+Tx1UGWlocge1vPdeEs2s0kljHyzs7WZlfe5WBe3AEgwRspG0A?=
 =?us-ascii?Q?2lcQ+3yxmvr2C/t/kbuOHcF1zLmx5We24teXZ+0xtAHSO1GmjbdlYtsKEbLB?=
 =?us-ascii?Q?ZETnF9Jm44PhJk9o6UiOsIKr38HsBo5QB+HR4FIuK1cplJIL9SVtrR6vEh8D?=
 =?us-ascii?Q?oKqP0rVLvIah+2O7cnOOVwXpL4VtvacminojTUDHG0uJs+0zAe4QSzWaAPQX?=
 =?us-ascii?Q?KVfR6xD45x3C1CfqXwwfRcTuJiDYUCuSPqURwBhj/97B/SIyl/OzVdzybkIY?=
 =?us-ascii?Q?bN1s4+8iIFNQBxVVmPozaqFBhjDrW38a/2woF3qxoDmlno2YVU+yc4+OPoXC?=
 =?us-ascii?Q?eKVbNOzhY+a5ybeeo2008K3Pb3+x/ZpvZIC9/ShE4Bhycl55G97dJtIRcOB1?=
 =?us-ascii?Q?0Wk32EHdUpk1HUUHOme3fslqV4OgGimNGfY8fbdGwEBsPJDKGesB+qUdENGH?=
 =?us-ascii?Q?VGfzP8HpgO/tvayTuUPLruYp7/xOjMXm1RCWv5CKf5hG08f4YOy+7jRsIQCe?=
 =?us-ascii?Q?4b/rp2nLn0beUhx4xhKSr4my3NFxx2FAhZjBINgO5v+Ypj0I1vV1eQkKdUFV?=
 =?us-ascii?Q?okj+DebYMAO1jOW+s7yWyooabzobJGTe0ggLdUUbbJhUkfW3os3Rd72/WzX/?=
 =?us-ascii?Q?wlTyoVtiF0qnLv/Jeo+wqTbqyErnUjI/dpy2mpZfC9ccSffOlQLcgsS7aoSu?=
 =?us-ascii?Q?B5fMw8cUvgj0DsYlaKnrOVJlOkDo4u0u6YhLRIwkZCISQ2uEO0v2bxTDcVqB?=
 =?us-ascii?Q?4WoXWvc90MybBwWP7y9Y5hhEZtuC9kbkoVzjaFbvu4ea5d7CQkgHjDp20iP2?=
 =?us-ascii?Q?8Pl1acSG3PD1xL3OmMHe5Pl8Ld80abgtdydyZf6jJ4MTT8WD2uSZJPM/Tioi?=
 =?us-ascii?Q?KlbrVOLOAqoBdZHosTfsxc5/Rstk3dNJSykC9cQwvjb8b+IKHIaHf/1gwrRB?=
 =?us-ascii?Q?V3m8ugt1a76aW/ZkDGeTHSXzjxWk3P7LNz8A/0iljLpj2073jmh9aNgmbbmm?=
 =?us-ascii?Q?WHlMaA6QJ4KpgPP8lyOjGN6n76CW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 01:43:44.7728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a6b98b-32b5-4f2d-7f64-08dc7480750f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

Currently, the late XenStore init protocol is only triggered properly
for the case that HVM_PARAM_STORE_PFN is ~0ULL (invalid). For the
case that XenStore interface is allocated but not ready (the connection
status is not XENSTORE_CONNECTED), Linux should also wait until the
XenStore is set up properly.

Introduce a macro to describe the XenStore interface is ready, use
it in xenbus_probe_initcall() and xenbus_probe() to select the code
path of doing the late XenStore init protocol or not.

Take the opportunity to enhance the check of the allocated XenStore
interface can be properly mapped, and return error early if the
memremap() fails.

Signed-off-by: Henry Wang <xin.wang2@amd.com>
Signed-off-by: Michal Orzel <michal.orzel@amd.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 3205e5d724c8..8aec0ed1d047 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -72,6 +72,10 @@ EXPORT_SYMBOL_GPL(xen_store_evtchn);
 struct xenstore_domain_interface *xen_store_interface;
 EXPORT_SYMBOL_GPL(xen_store_interface);
 
+#define XS_INTERFACE_READY \
+	((xen_store_interface != NULL) && \
+	 (xen_store_interface->connection == XENSTORE_CONNECTED))
+
 enum xenstore_init xen_store_domain_type;
 EXPORT_SYMBOL_GPL(xen_store_domain_type);
 
@@ -751,9 +755,10 @@ static void xenbus_probe(void)
 {
 	xenstored_ready = 1;
 
-	if (!xen_store_interface) {
-		xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
-					       XEN_PAGE_SIZE, MEMREMAP_WB);
+	if (!xen_store_interface || XS_INTERFACE_READY) {
+		if (!xen_store_interface)
+			xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
+						       XEN_PAGE_SIZE, MEMREMAP_WB);
 		/*
 		 * Now it is safe to free the IRQ used for xenstore late
 		 * initialization. No need to unbind: it is about to be
@@ -822,7 +827,7 @@ static int __init xenbus_probe_initcall(void)
 	if (xen_store_domain_type == XS_PV ||
 	    (xen_store_domain_type == XS_HVM &&
 	     !xs_hvm_defer_init_for_callback() &&
-	     xen_store_interface != NULL))
+	     XS_INTERFACE_READY))
 		xenbus_probe();
 
 	/*
@@ -831,7 +836,7 @@ static int __init xenbus_probe_initcall(void)
 	 * started, then probe.  It will be triggered when communication
 	 * starts happening, by waiting on xb_waitq.
 	 */
-	if (xen_store_domain_type == XS_LOCAL || xen_store_interface == NULL) {
+	if (xen_store_domain_type == XS_LOCAL || !XS_INTERFACE_READY) {
 		struct task_struct *probe_task;
 
 		probe_task = kthread_run(xenbus_probe_thread, NULL,
@@ -1014,6 +1019,12 @@ static int __init xenbus_init(void)
 			xen_store_interface =
 				memremap(xen_store_gfn << XEN_PAGE_SHIFT,
 					 XEN_PAGE_SIZE, MEMREMAP_WB);
+			if (!xen_store_interface) {
+				pr_err("%s: cannot map HVM_PARAM_STORE_PFN=%llx\n",
+				       __func__, v);
+				err = -ENOMEM;
+				goto out_error;
+			}
 			if (xen_store_interface->connection != XENSTORE_CONNECTED)
 				wait = true;
 		}
-- 
2.34.1


