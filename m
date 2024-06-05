Return-Path: <linux-kernel+bounces-202821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF538FD184
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD961F243F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF417BCD;
	Wed,  5 Jun 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IEUv6THF"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5EC13C823
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600841; cv=fail; b=CRfeKD1LGXaV6cKFNoK7Atk0+wlQlrnkvz5PhJSdb/HHJZ2e7ANVdXFgjdkN2y1sYZhgJ4DHRedDn4a44SVZkmZ2F/RcCx1RCHQI7PxtR/qYGh85KI6HFZQn4UEVH1QTaHG6F4TT78Ef/zeYUantXryJaNic3GMorLPzEyZVy3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600841; c=relaxed/simple;
	bh=zGxZDwZAFNslghR2sG6lPCA2hDGeuJpzUoPiYCCwt9M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+vZKSxAkqS15T+PZVS93y6TeJca88FB49PbolNMCSKPQrsYKtEao/lQ55kpmq43/yE0Y5oINkIVxvKVCpHx60JlxtCiK5X/fhrd2PLTIiXVSQkFUX7LNTn6dmYipfpTVhyzOhGqZeYn2rHvGs3FLiON4t6n6dh2Uz8JW0QNWzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IEUv6THF; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYn9peXEJV8/4IKW7VQWlixb1WnTWXYOCis6xL7T7okPKaQjNre1XzcMTMouGpZBLKOiia+rnNXTnYhyjcjeA2+QHUoXQvPjqWt0H+Gr9VFRR2bnDrAQ6O2kB8lM0buDTfQIyDfyELdXbn1OggyLtkeu6QbRWeGkTh0kGLm/ghnGENMawpTasDg1uf1VeAgj90SSpV9q/f+2bmdTg9EytoE/qF053HFgsizCFfz+lLOKNxyE7L7kjuqWmiiyMsYgEvL/33D1ZFhnNsK7puC+OgAsptrIc+lcC0UCyJ07a0CjbwX5eYREld+U5Iy83UuFjeW6MCwAmVCx2DQZpeo+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6S87TAS1om1dd99gH95g7g/MwCTFNZYgcn+CNT0oSo=;
 b=B4r4abXDoDMxSMjkUtvAW9AVGd8yY/ppDfvlHHcVi82waX/w8ODw18p5n0zRWZGZ6vGds92f8bRYaOwy3Qc6m2JcYml0Z1H9W7VuNH+ciT33PXpwahrpmxfo3kzDRSsgB2KKLgDP3s//uZUOPcdtFjC6murD0WdFHUrO/8FpXIMYzf3TxK7FjMly4AYQCRr8jdXkaNe7kO0AXHCfEsVHgaV7/9B9+TIPrSZMvy0ICBNbxMSQwuOKUrCnjF8w2IdAGHYDSzjJ3L7tRYcdk52tUy4hFnX7K+cByel6nJXmeVJS2opWHbzd242tNsCujqumc+oNUPUATyb8rKQx0dntFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6S87TAS1om1dd99gH95g7g/MwCTFNZYgcn+CNT0oSo=;
 b=IEUv6THF2PoFC3pJdX08YAJf8wFdZiX7OZDnFcXzZsHcnFA5YyvHfSbgLtdT1UbwLhS8cJraQSz+OOye1wDfaVesCy0Zijr36/2AL8k8JhwP1ZA+eLbMxfQuejbAWHGLNOEYAFSzkVbDE9nWMkshCysPys4aYD7sBcapBAUGSNc=
Received: from BLAPR03CA0051.namprd03.prod.outlook.com (2603:10b6:208:32d::26)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 5 Jun
 2024 15:20:36 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::a5) by BLAPR03CA0051.outlook.office365.com
 (2603:10b6:208:32d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 15:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:20:36 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:20:34 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v5 11/13] x86/sev: Take advantage of configfs visibility support in TSM
Date: Wed, 5 Jun 2024 10:18:54 -0500
Message-ID: <8873c45d0c8abc35aaf01d7833a55788a6905727.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: e153fc4a-a86e-41be-d5d3-08dc85730cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FwbFUZurYcPph0v8cCQPX80riTwG+9Q4GXb2kCeYyrm54qgRH/6D4bLVkSmK?=
 =?us-ascii?Q?XStpBXvEBFrKeQ5ArTo0Y44k93b9noaw3jXbcfqcqCl67Cf0UbeJDrMqI1l1?=
 =?us-ascii?Q?kwwfeWglNqT+aPb2UPXb4yMVWfrNBryyzcozAzw9dj8DRUKYKDk9oQ3pQ+Jy?=
 =?us-ascii?Q?K2mzATAjqn/pEPgnFoTDKo/C8HOib+cMD2HbO8oT4ZNoy16I1CUYKKkSc5iU?=
 =?us-ascii?Q?wEg8Sfua2Iq527tDade7EbyG/Ndw9TYBLgN8Ip+3fYX1YFCieJktMspLYJMM?=
 =?us-ascii?Q?lVM8UYrdh0SDGC/1+AS0Rt5ulZMc+jNFSNvFS9AlooY0oz4JbG96X7lFJoqs?=
 =?us-ascii?Q?I6uwpEo7TEslDyK+SyVBRDmXjeqXzEQP58KEvOqp620cGkscGD5cApo/rVL7?=
 =?us-ascii?Q?vPJOHZyJACF/742dN1jgf2Bf/9K2IaW1lfiDV5MyXLe4xnJTJe9NrgdzvBSg?=
 =?us-ascii?Q?0kAGmfttvj7k6zOGpXJuRhmv1ccgeoTPqkpNsm/iQvLEj+Twp7Ig1QXOc1KI?=
 =?us-ascii?Q?YtveOiSbbEN9Vb1gdacCcO+XinQxRQzxS2SPIbXNOmMVI3NH1sENnigaiESR?=
 =?us-ascii?Q?Zy0WYHhA9I7r6a6XRtBnTqMVsygivU+xs3V6zg2IzMFin3hgLMOlxrxLXZGX?=
 =?us-ascii?Q?daxNDs+geiMMtiMEcBSmnAYXOtwMMJ3LNSvnzRWwAK/kA9j4OjJbYLDKD447?=
 =?us-ascii?Q?f84CgCADbSLeL3sgDnBDsOZdmjzDvpdoK9CISzEDg/wtlehHSwkyMrYkMeAU?=
 =?us-ascii?Q?qwW757rC1xoCHfbfIMmo3e43k2ckb98OGBl+GSIlvESO2HZ6xIbRnlycX2hS?=
 =?us-ascii?Q?OAmQ9QRqpaXvXofi+LfnGQV+5uJxdd0VmJhPWy0CK+datDjZ2dm/fstpugIO?=
 =?us-ascii?Q?qIdSxZpraU9Fuxz+C+RBkH7FUNo7Y05HkJXKl0neGiw/KiucfMLi7Rf4BXsI?=
 =?us-ascii?Q?ZpIesbYAwrUJLNTkr3c7eZTfw4q4+auxKAuBC99UdgDai3uLWAKa4/0o7pIp?=
 =?us-ascii?Q?CbGwSO8bPa77reA6U3fN53syWrpRQQ8jcnlDpoFZB7sA/qZwXaCJCSckmRx9?=
 =?us-ascii?Q?YSTENItvhsSgvj4Pwog0rxoDEHPocuRL/jyT1GA11Up23mpzKdHP5pjmwF66?=
 =?us-ascii?Q?SQ+oqO/w9BvlMvrqkEVrYr3cyENbvAW6nzF0dsHeoSmhcrIJdi5TOmCMVtH+?=
 =?us-ascii?Q?l6rBx3XNnA4GQMG13PcjTVZGD4hTeAEy/gdEli1Y3+Chs3XEeDFITPNXQ6lZ?=
 =?us-ascii?Q?7MxA+HoGDReVfdYyXqnn13Qvb+QMqq0nfrpGXZ+ecf0YFVSEFTA1y29c3CpM?=
 =?us-ascii?Q?LoWRprC8cO/vYvdXdYGKPabljPhIDZk62yGuj/l+wRG/YrcNOR1HGTi5+Mkz?=
 =?us-ascii?Q?zsE5DK3jiqahBvunPlz+3PF1pUG+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:20:36.0159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e153fc4a-a86e-41be-d5d3-08dc85730cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214

The TSM attestation report support provides multiple configfs attribute
types (both for standard and binary attributes) to allow for additional
attributes to be displayed for SNP as compared to TDX. With the ability
to hide attributes via configfs, consolidate the multiple attribute groups
into a single standard attribute group and a single binary attribute
group. Modify the TDX support to hide the attributes that were previously
"hidden" as a result of registering the selective attribute groups.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
 drivers/virt/coco/tdx-guest/tdx-guest.c | 26 +++++++-
 drivers/virt/coco/tsm.c                 | 86 ++++++++++++-------------
 include/linux/tsm.h                     | 38 +++++++++--
 4 files changed, 100 insertions(+), 53 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 3560b3a8bb4d..0c70a38c8cc0 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,6 +23,7 @@
 #include <linux/sockptr.h>
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
+#include <linux/configfs.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
@@ -982,7 +983,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	/* Set the privlevel_floor attribute based on the vmpck_id */
 	sev_tsm_ops.privlevel_floor = vmpck_id;
 
-	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
+	ret = tsm_register(&sev_tsm_ops, snp_dev);
 	if (ret)
 		goto e_free_cert_data;
 
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..2acba56ad42e 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -249,6 +249,28 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 	return ret;
 }
 
+static bool tdx_report_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_GENERATION:
+	case TSM_REPORT_PROVIDER:
+		return true;
+	}
+
+	return false;
+}
+
+static bool tdx_report_bin_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_INBLOB:
+	case TSM_REPORT_OUTBLOB:
+		return true;
+	}
+
+	return false;
+}
+
 static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -281,6 +303,8 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 static const struct tsm_ops tdx_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = tdx_report_new,
+	.report_attr_visible = tdx_report_attr_visible,
+	.report_bin_attr_visible = tdx_report_bin_attr_visible,
 };
 
 static int __init tdx_guest_init(void)
@@ -301,7 +325,7 @@ static int __init tdx_guest_init(void)
 		goto free_misc;
 	}
 
-	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
+	ret = tsm_register(&tdx_tsm_ops, NULL);
 	if (ret)
 		goto free_quote;
 
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..7db534b63c9f 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -14,7 +14,6 @@
 
 static struct tsm_provider {
 	const struct tsm_ops *ops;
-	const struct config_item_type *type;
 	void *data;
 } provider;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -252,34 +251,18 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 }
 CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
 
-#define TSM_DEFAULT_ATTRS() \
-	&tsm_report_attr_generation, \
-	&tsm_report_attr_provider
-
 static struct configfs_attribute *tsm_report_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
+	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
+	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
+	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
+	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
 	NULL,
 };
 
-static struct configfs_attribute *tsm_report_extra_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
-	&tsm_report_attr_privlevel,
-	&tsm_report_attr_privlevel_floor,
-	NULL,
-};
-
-#define TSM_DEFAULT_BIN_ATTRS() \
-	&tsm_report_attr_inblob, \
-	&tsm_report_attr_outblob
-
 static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	NULL,
-};
-
-static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	&tsm_report_attr_auxblob,
+	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
+	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
+	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
 	NULL,
 };
 
@@ -297,21 +280,44 @@ static struct configfs_item_operations tsm_report_item_ops = {
 	.release = tsm_report_item_release,
 };
 
-const struct config_item_type tsm_report_default_type = {
+static bool tsm_report_is_visible(struct config_item *item,
+				  struct configfs_attribute *attr, int n)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->report_attr_visible)
+		return true;
+
+	return provider.ops->report_attr_visible(n);
+}
+
+static bool tsm_report_is_bin_visible(struct config_item *item,
+				      struct configfs_bin_attribute *attr, int n)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->report_bin_attr_visible)
+		return true;
+
+	return provider.ops->report_bin_attr_visible(n);
+}
+
+static struct configfs_group_operations tsm_report_attr_group_ops = {
+	.is_visible = tsm_report_is_visible,
+	.is_bin_visible = tsm_report_is_bin_visible,
+};
+
+static const struct config_item_type tsm_report_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_bin_attrs = tsm_report_bin_attrs,
 	.ct_attrs = tsm_report_attrs,
 	.ct_item_ops = &tsm_report_item_ops,
+	.ct_group_ops = &tsm_report_attr_group_ops,
 };
-EXPORT_SYMBOL_GPL(tsm_report_default_type);
-
-const struct config_item_type tsm_report_extra_type = {
-	.ct_owner = THIS_MODULE,
-	.ct_bin_attrs = tsm_report_bin_extra_attrs,
-	.ct_attrs = tsm_report_extra_attrs,
-	.ct_item_ops = &tsm_report_item_ops,
-};
-EXPORT_SYMBOL_GPL(tsm_report_extra_type);
 
 static struct config_item *tsm_report_make_item(struct config_group *group,
 						const char *name)
@@ -326,7 +332,7 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
-	config_item_init_type_name(&state->cfg, name, provider.type);
+	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
 	return &state->cfg;
 }
 
@@ -353,16 +359,10 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type)
+int tsm_register(const struct tsm_ops *ops, void *priv)
 {
 	const struct tsm_ops *conflict;
 
-	if (!type)
-		type = &tsm_report_default_type;
-	if (!(type == &tsm_report_default_type || type == &tsm_report_extra_type))
-		return -EINVAL;
-
 	guard(rwsem_write)(&tsm_rwsem);
 	conflict = provider.ops;
 	if (conflict) {
@@ -372,7 +372,6 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 
 	provider.ops = ops;
 	provider.data = priv;
-	provider.type = type;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_register);
@@ -384,7 +383,6 @@ int tsm_unregister(const struct tsm_ops *ops)
 		return -EBUSY;
 	provider.ops = NULL;
 	provider.data = NULL;
-	provider.type = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 50c5769657d8..30d9d270b446 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -42,12 +42,40 @@ struct tsm_report {
 	u8 *auxblob;
 };
 
+/**
+ * enum tsm_attr_index - index used to reference report attributes
+ * @TSM_REPORT_GENERATION: index of the report generation number attribute
+ * @TSM_REPORT_PROVIDER: index of the provider name attribute
+ * @TSM_REPORT_PRIVLEVEL: index of the desired privilege level attribute
+ * @TSM_REPORT_PRIVLEVEL_FLOOR: index of the minimum allowed privileg level attribute
+ */
+enum tsm_attr_index {
+	TSM_REPORT_GENERATION,
+	TSM_REPORT_PROVIDER,
+	TSM_REPORT_PRIVLEVEL,
+	TSM_REPORT_PRIVLEVEL_FLOOR,
+};
+
+/**
+ * enum tsm_bin_attr_index - index used to reference binary report attributes
+ * @TSM_REPORT_INBLOB: index of the binary report input attribute
+ * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
+ * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
+ */
+enum tsm_bin_attr_index {
+	TSM_REPORT_INBLOB,
+	TSM_REPORT_OUTBLOB,
+	TSM_REPORT_AUXBLOB,
+};
+
 /**
  * struct tsm_ops - attributes and operations for tsm instances
  * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
  * @privlevel_floor: convey base privlevel for nested scenarios
  * @report_new: Populate @report with the report blob and auxblob
  * (optional), return 0 on successful population, or -errno otherwise
+ * @report_attr_visible: show or hide a report attribute entry
+ * @report_bin_attr_visible: show or hide a report binary attribute entry
  *
  * Implementation specific ops, only one is expected to be registered at
  * a time i.e. only one of "sev-guest", "tdx-guest", etc.
@@ -56,14 +84,10 @@ struct tsm_ops {
 	const char *name;
 	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
+	bool (*report_attr_visible)(int n);
+	bool (*report_bin_attr_visible)(int n);
 };
 
-extern const struct config_item_type tsm_report_default_type;
-
-/* publish @privlevel, @privlevel_floor, and @auxblob attributes */
-extern const struct config_item_type tsm_report_extra_type;
-
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type);
+int tsm_register(const struct tsm_ops *ops, void *priv);
 int tsm_unregister(const struct tsm_ops *ops);
 #endif /* __TSM_H */
-- 
2.43.2


