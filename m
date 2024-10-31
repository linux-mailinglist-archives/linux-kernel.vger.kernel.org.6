Return-Path: <linux-kernel+bounces-390134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C39B75FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CF21F210A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8811482F3;
	Thu, 31 Oct 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Roc0pHmW"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A61145A19
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361665; cv=fail; b=DSCSe/q7LT7anQKQvQrhPqPyvCZSiTThgm4+WOppwKliQBOEnqhRn3Tei+SFOSreQldjtb/sDTVNcnytO9jYgohV/vkNwxiJCxmwH9aJSbFM+ZST85wFZR9cOA5GWMk7tAboEsElCT+hLo24b6Q1DTyaFxGGxzhCJpG+xxsFynI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361665; c=relaxed/simple;
	bh=FdptBpGRZ7OdKlpUo3kVUmBSzmIW6K1uvCWLTd1CcCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9nH4IqjLGjZWAja6yK3tkcYlGZaLqTGdjybuacs5xlmL5QHMPhYGQ7geTzmrQ8MxMjBqJlAg+dDDjy0tEaerPYLzL/KazhbitkQuPN+mnryiRCK9HG/44z6+T1MG3cHOPmFBzJlXa8tkfW9XQgwjGeq36sxDz0da2W1uMkWUxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Roc0pHmW; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/jHLRQYz4FVgrY1It8nOD50XDqzAnGZBt2zhYPg9URXtYXX7ux+dNP7vtOo1WKalynyh5DFBPdwJt80O9qM+GS9qn3BDhb/0IXC7nRynOtO+Eobjsy0DfGLxMPu2HTGIcshFFkbsvBraHzmyayfwxQyAQhs/5LHSO7N3NcI+rLznKFKg8nDf/+EjM/nZJbts1sND3TyaHN8+s7xh35Mpa/776admQj6V1bWDKBDZVxd5maauuBl6kGdRgpj2hNFVmv2YDKfXr6Qe5+gsZpPT09/t7iOlxCn9+RpInRlGy4i8ENtgFlqew8yr4HRdbAQ98eqy5TrTVNY7sP2P16llw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IsKIPrXLBnivwlYfQ0Evkmjfiot5DFOA11QU820GsE=;
 b=qepyHu/J0/fUR2NLOQBKli+vZBa64Xbj80WQKi3dLfoIk4mW+SrrKJ611juP2HlDgBx1RTKM+Db0f7ylGDdPsFEui0zs3Wg6BiP9tPqpzCKuKIVAoPTYvFYbTAYg0tnB+aWEzMVVrIWEJtvraWzJs7XOR03P/SZwyvMZrXg/CLCbb4TqNX2IcSO0eiE08AwbDVYeNF0UNRIBBMeZwVJHy3DUVQlULQVsUnNOchoXOqdtMLMuOoPcnI7MUErrcLeeQqf1iABFACFTpNzj2j9gNnqraHfW/6oA+z0ygjzUISKlJrCqzj0XZmPtIpQBHSDYKVU/srnWnoIcWSfqvT2RpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IsKIPrXLBnivwlYfQ0Evkmjfiot5DFOA11QU820GsE=;
 b=Roc0pHmWqyAt5h1Y/n0DfzQILey/2t0QH9z0Zwrdo1zsmzAfipaAbu7wWSrCUP7qiXKoF09i6W95H2lVOhBYN4S38WW7ZyKZj+tFKOGzOYlM4u+GlWe2q1D7Mv8XzvCOXqWobexj7Jc+ViuZYyddv5s9FOTqYqir3X3sqVAHTFQ=
Received: from BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::30)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Thu, 31 Oct
 2024 08:00:59 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::bc) by BN9P222CA0025.outlook.office365.com
 (2603:10b6:408:10c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 08:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 08:00:59 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 03:00:57 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <dionnaglaze@google.com>
CC: <dakr@redhat.com>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, <mcgrof@kernel.org>, <rafael@kernel.org>,
	<russ.weight@linux.dev>, <russell.h.weight@intel.com>,
	<tianfei.zhang@intel.com>, <x86@kernel.org>
Subject: [PATCH 2/4] firmware_loader: Move module refcounts to allow unloading
Date: Thu, 31 Oct 2024 08:00:45 +0000
Message-ID: <20241029183907.3536683-3-dionnaglaze@google.com> (raw)
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029183907.3536683-1-dionnaglaze@google.com>
References: <20241029183907.3536683-3-dionnaglaze@google.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaf1fd6-4eba-4209-fcba-08dcf98227f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ql0GG4SC5MOycfeOArJAyx+r6T750P/Dbgg/o0QIOc0Vf9Xq1BRNOpj/BhJf?=
 =?us-ascii?Q?/mY/Fmh65iDXX2ZKreyQqc8mi/FyJII0q4OZgY/GHPRGJU0HuBYEc2/xIoGk?=
 =?us-ascii?Q?SYS33MjWVRXiQg9TNF2HJTWqPUWz0SvU2lXpiMyrai4VRQ4T6kT5eQrc2oGJ?=
 =?us-ascii?Q?Xtz2E8TTztxRi58fGpTY0j+BPWRb20JX3ZX6T93OKOBqdmXU0M5OeMotA064?=
 =?us-ascii?Q?aj1j11Iwk3sfvtwBhovzl/LCDzXj8LfH+bOjSCJ0Xprb3/l7WrR5KCy0NG7A?=
 =?us-ascii?Q?dGWjTtC9fkJTAEMg6OBqmf+T3MLz1gripqrkTsUY5FO4qAi1opI/sMPVh3qm?=
 =?us-ascii?Q?leK4qYklDKut+nDVWIq956jAuvUvbedzhLoXOVDpMDjI6UWLyMrGi35f1Fjx?=
 =?us-ascii?Q?Hw4pD7jtEiotsQuxhW55U09J6Le9nLikcnvd3On3qtP3eD41nZwNHdFiJGwg?=
 =?us-ascii?Q?i/dgfDugNheCzyk+8zttRe7bZ0PaiOF9y3PN07W+hI+vY87bncXtgAjO77Ec?=
 =?us-ascii?Q?tXSYu9ithMswGBWDXmdpzk7noLs5T9YKNKSI+nfP5S6vBI8J62q1ob+lhUh2?=
 =?us-ascii?Q?H/FQr6AgRFNFBLOKY+QvAV+aWubAbbd2Yf/rgi2JdiG8wH1O04tCWiAypnqO?=
 =?us-ascii?Q?EKZfbuqaFSFv2p8AWm8bqnHuy2eIQc3O1UoeKXgBDvakRWvYhN3AgY9MOy7Z?=
 =?us-ascii?Q?Z2brr+p/5R1CsgkepzVzmizYIv3eaHG70x5O618yRAdC34V1PuSvZTBgK5PT?=
 =?us-ascii?Q?6Gn+jVTiWhM4ejBBjIFD0yIuv6xt+GeZOXxqV+31bYA4KpOZvYS9HkmI5KK+?=
 =?us-ascii?Q?e5+3nxd13CoLKZe5em9KlHvk7izZb8EKev9MZkJYl0RAojUYWQyaxajs4F3H?=
 =?us-ascii?Q?U6ePppLThymYM9lJH7whl1yqVBMWR0/7MA2TEMVcsnZ4cJWe8JgsJnGoC/uR?=
 =?us-ascii?Q?G7rsxS1E0zeHcvMoMmDiSIo57uC9YXimezNOsVSYOLuYU90jdofCg1V0Sr/j?=
 =?us-ascii?Q?Me7TK2SJjOJrLyJLpfuoI9dNZyvvT3JcWxxVEKT8cBPMo3dz5Urpl11JkGwv?=
 =?us-ascii?Q?i4wRIVtk4Q1XyGf9aEyJweYjOMAeufkGsGeTMQEuV4++PPHKIPQXVznxF6m+?=
 =?us-ascii?Q?0maFvQ8eRVi2lqiT6/f/wOsc/LLOq3Eb/F5A4Ne1d/3yIhR4YH0WJFYzFW35?=
 =?us-ascii?Q?iQtUwSQFEXU9o6K6k7yg4Ypda6bdI7qGQWkMK+ZBOZmt+2eUD2pYq0tgXtAg?=
 =?us-ascii?Q?SdVA4A+t5b6mX4Iej0Nid+NoG/Y8IqxxJMhCoqYZC5kp9bSkzHtshj4PCXJq?=
 =?us-ascii?Q?sgHJic84EspRVSiO+vqzzOwd4PhGdKJh9uB2/cztg4TO55SkoBIhohKMkV6H?=
 =?us-ascii?Q?eUJcbuToyBAyMNBaZVxO5Mh9HMOy+1YeSr1pmMk7j6annfN8pg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 08:00:59.0508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaf1fd6-4eba-4209-fcba-08dcf98227f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

If a kernel module registers a firmware upload API ops set, then it's
unable to be moved due to effectively a cyclic reference that the module
depends on the upload which depends on the module.

Instead, only require the try_module_get when an upload is requested to
disallow unloading a module only while the upload is in progress.

Fixes: 97730bbb242cd ("firmware_loader: Add firmware-upload support")

CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Change-Id: Ifac9513de2f58a5120d4c0a681e969cd71cd3c68
---
 drivers/base/firmware_loader/sysfs_upload.c | 28 ++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 829270067d163..97b0ae855b5f0 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -103,6 +103,10 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 	if (fwlp->progress == FW_UPLOAD_PROG_IDLE)
 		ret = -ENODEV;
 
+	/*
+	 * Not idle, so fw_upload_start already called try_module_get.
+	 * No need to get/put around cancel.
+	 */
 	fwlp->ops->cancel(fwlp->fw_upload);
 	mutex_unlock(&fwlp->lock);
 
@@ -164,11 +168,13 @@ static void fw_upload_main(struct work_struct *work)
 	enum fw_upload_err ret;
 	struct device *fw_dev;
 	struct fw_upload *fwl;
+	struct module *module;
 
 	fwlp = container_of(work, struct fw_upload_priv, work);
 	fwl = fwlp->fw_upload;
 	fw_sysfs = (struct fw_sysfs *)fwl->priv;
 	fw_dev = &fw_sysfs->dev;
+	module = fwlp->module;
 
 	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_PREPARING);
 	ret = fwlp->ops->prepare(fwl, fwlp->data, fwlp->remaining_size);
@@ -204,6 +210,7 @@ static void fw_upload_main(struct work_struct *work)
 		fwlp->ops->cleanup(fwl);
 
 putdev_exit:
+	module_put(module);
 	put_device(fw_dev->parent);
 
 	/*
@@ -238,7 +245,11 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
 		return 0;
 	}
 
+
 	fwlp = fw_sysfs->fw_upload_priv;
+	if (!try_module_get(fwlp->module)) /* released in fw_upload_main */
+		return -EFAULT;
+
 	mutex_lock(&fwlp->lock);
 
 	/* Do not interfere with an on-going fw_upload */
@@ -310,13 +321,10 @@ firmware_upload_register(struct module *module, struct device *parent,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!try_module_get(module))
-		return ERR_PTR(-EFAULT);
-
 	fw_upload = kzalloc(sizeof(*fw_upload), GFP_KERNEL);
 	if (!fw_upload) {
 		ret = -ENOMEM;
-		goto exit_module_put;
+		goto exit_err;
 	}
 
 	fw_upload_priv = kzalloc(sizeof(*fw_upload_priv), GFP_KERNEL);
@@ -358,7 +366,7 @@ firmware_upload_register(struct module *module, struct device *parent,
 	if (ret) {
 		dev_err(fw_dev, "%s: device_register failed\n", __func__);
 		put_device(fw_dev);
-		goto exit_module_put;
+		goto exit_err;
 	}
 
 	return fw_upload;
@@ -372,8 +380,7 @@ firmware_upload_register(struct module *module, struct device *parent,
 free_fw_upload:
 	kfree(fw_upload);
 
-exit_module_put:
-	module_put(module);
+exit_err:
 
 	return ERR_PTR(ret);
 }
@@ -387,7 +394,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 {
 	struct fw_sysfs *fw_sysfs = fw_upload->priv;
 	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
-	struct module *module = fw_upload_priv->module;
 
 	mutex_lock(&fw_upload_priv->lock);
 	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
@@ -395,6 +401,11 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 		goto unregister;
 	}
 
+	/*
+	 * No need to try_module_get/module_put around the op since only the
+	 * module itself will call unregister, usually when the refcount has
+	 * dropped to zero and it's cleaning up dependencies to destroy itself.
+	 */
 	fw_upload_priv->ops->cancel(fw_upload);
 	mutex_unlock(&fw_upload_priv->lock);
 
@@ -403,6 +414,5 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 unregister:
 	device_unregister(&fw_sysfs->dev);
-	module_put(module);
 }
 EXPORT_SYMBOL_GPL(firmware_upload_unregister);
-- 
2.47.0.163.g1226f6d8fa-goog

Tested-by: Ashish Kalra <ashish.kalra@amd.com>

Thanks,
Ashish

