Return-Path: <linux-kernel+bounces-547203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF18A5041E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB6B1736C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F924DFE7;
	Wed,  5 Mar 2025 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="MVcIznGL"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012005.outbound.protection.outlook.com [52.101.71.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D5C1C8619
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190741; cv=fail; b=QmSnU0H4emmjCU/d/3C+2uqaCMeCiALq9nIBxb90qy4t0y90vP52AG7s2O5nZEquEW+be/HRjHLUPvNpKBx0V0LEKRlu1Hc9IYOSJGe8XmI9HxmDIGHwnVAnkLoSOJPrlKtWDxdtMNoecEIYJV9V/t8IFaM3+fdCWa0NWpOZBR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190741; c=relaxed/simple;
	bh=Knvdh1mFmv/gAHlXcpPW2M6sTizOKz1w2TL8rBkOroU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cM63iZf/C3OJodZ7xOoE1Wc2cjJhIFKwhcKHuEvYkJkiGDUHlKxf7XODkQgSw4egN3nBBvtTaPX1lAK9wb258QIL2oVxvMicXjnJUUcAtoIxl71hvZx7GAfstoviqxsGeDanYY2ID2BoCWN1gHh89xRXISwG6RFUFQUpPw5LCDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=MVcIznGL; arc=fail smtp.client-ip=52.101.71.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYVX1B4D8YVFcHt5PPmmDCErfpDzN5qB1srp5FuCK5L2yHpaiUriAf9z1MlOAQ3tqW4RKEF8OVBmPJWOczhHw6VgSCETb16cb7K8JLWEbDL7dvhPN1UoK6L98bGfKjTUx6oMkhsFujtLBdWvdDCOmvqL6Z8OBK6SoeIzvs8EB5Eb5hmMuBpOyGL2pt/zFWw43d7lZLjjJUkwDuyRcNLdV4IiB7nRWZnJR5p59yvXF4ItFgXPxP6UGgGQWMUiw/FTexkQ6BT9SJazFCeqOR23EIgfoSl0T7yuUg764aN2KE4TX5Cwg+89boO99PH/kxv/yRW0T05u3TOyiQdS8yvxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V96WjpA3e41/Y7hLhyq/xg8N7azC9O7hT1gWD9B4xu8=;
 b=DmXo5VeCSCAB4h3KMzcHfG4DPrVKv9UqKQZUfcX91Xb6NFUW4E9C9KzZxD7nM0GcsnrTgJs1VyGnl5wHim5vLqmPoefYggPhzXSjqN9E1hGKHn3EvgtVtqfi80z7MgsnC9gMjbckLV82LBAfNajWmA7hhy8b3g9IeHOQgoKmk4ZPm7c8mE6rAwF6ykU9DSsWU2ew2AoNAUV4Zdueo8fQEt3g68HiLY6F8keGt1q0ak0L7KSpYt37j0I46i/RuUF5+74aO/RCvs3G3kF7PSMXdXJBz1vGnGKCHF5dEy1jDoWhh4JmRAqoCrRfBB5eSs7wgPY4fVhoKB36p1yzX3vdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=chromium.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V96WjpA3e41/Y7hLhyq/xg8N7azC9O7hT1gWD9B4xu8=;
 b=MVcIznGLzFDqRuaddzIYJM6g0QGg3zuh0/udzhPVnEsXOZcdyqHk1dYzGGsNd63/kH5d2S4jBPRKDDZ5khp3Dt1rHjpd1Z3XWn7mrAGWXIJM5YXEgh0KbMODQhqKxlpeYVKEBBOv0W1eO77xjrMG0uafC4TdIiH5yr2bs1lLo3w=
Received: from CWLP123CA0004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::16)
 by VI0PR02MB10569.eurprd02.prod.outlook.com (2603:10a6:800:1b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 16:05:32 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:401:56:cafe::87) by CWLP123CA0004.outlook.office365.com
 (2603:10a6:401:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 16:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 16:05:32 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 17:05:31 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 17:05:31 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 5 Mar 2025 17:05:31 +0100
Received: from pc44637-2125.se.axis.com (pc44637-2125.se.axis.com [10.92.125.2])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 16263265;
	Wed,  5 Mar 2025 17:05:31 +0100 (CET)
Received: by pc44637-2125.se.axis.com (Postfix, from userid 15765)
	id 123EF40160C1; Wed,  5 Mar 2025 17:05:31 +0100 (CET)
From: =?utf-8?q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
Date: Wed, 5 Mar 2025 17:05:04 +0100
Subject: [PATCH] regulator: core: Fix deadlock in create_regulator()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250305-regulator_lockdep_fix-v1-1-ab938b12e790@axis.com>
X-B4-Tracking: v=1; b=H4sIAC92yGcC/x2MWwqAMAzAriL9djA3xMdVRGTMVovipFMRxLs7/
 EwgeSCiMEZoswcEL44ctgRFnoGf3Tah4jExGG1KbbVVgtO5uiPIsAa/jLgPxLdCMkS1s01FHlK
 7Cyb9f7v+fT9b1mXkZwAAAA==
X-Change-ID: 20250303-regulator_lockdep_fix-ef2ff8a397fc
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>, David Collins
	<quic_collinsd@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
	=?utf-8?q?Ludvig_P=C3=A4rsson?= <ludvig.parsson@axis.com>
X-Mailer: b4 0.14.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|VI0PR02MB10569:EE_
X-MS-Office365-Filtering-Correlation-Id: 9844febc-1699-402d-abc5-08dd5bff8e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlRWSFBkckZMZVk4Tnc4bHFkR2t4WlJoN1BXN3ZqazlBenBoYWdTcTZiQVhI?=
 =?utf-8?B?R21HU2hndThCNGFHdDdyQVFQaDB0Nzh5TzhDQmNhdU82Q3FPVjdsSnZTaFRp?=
 =?utf-8?B?UW9NZjVzVVBjdWlxZkVxemNkeG9WQWNtZ1luQmJSNFhYTC92dkhDVkc1TCtl?=
 =?utf-8?B?QzhiS2taeG1ZY3RaeXFTb1RCdUVKWHJqZWM2L0tFUVByN2VJWm9IZUwveDlM?=
 =?utf-8?B?dWZaNlE0WmRQRW5xb2tuLzB2UDcvY243MnNwVUdqejdWQm92ZW92QnFheEVw?=
 =?utf-8?B?QXgyczhXLzB1U0dLeTN1V0FzTXdmaXpTM0luZW1ERytDbFdYeDM4dHBDc0ti?=
 =?utf-8?B?Ynl3dS9jZFFVWER4RndVYkdSSTUySDQ2azVBN050N0lpTU9WZGw0MmkreUFG?=
 =?utf-8?B?UmlwaU1UeHBYYmVvWm5iSkErVzFUYU10eGlkZ1JKVk95K3htZjZoaUJyR3Vs?=
 =?utf-8?B?djdNcmNhVDJMVEh6WXdkc1ZsVEVrOG5TblFQNVloTGNIRWRjeHh2d2N1ZitQ?=
 =?utf-8?B?MmVCeVJMNG1jSzRJOWRFeStYYVpobVhmWDE5dkN5c3RyNi9NNUpxaG9RV25x?=
 =?utf-8?B?SHhxWkpOeTJOQzlVVDF2NEd6L09RWmsybnZVRmh3bElUUCtCTmlhWEpHMXFG?=
 =?utf-8?B?MmVETHl3UFg0L25JcGU3dStIZ1d0S0FIQ1k2M3NqbmpJN2laNldwL0p3ZTVE?=
 =?utf-8?B?a3dYK2xMbndhaGRoNklUNjQ5SG0vMW0vcUFMK2ZaMUdGOWExMkoxSHdoUXFl?=
 =?utf-8?B?STd3aTNrTTFUeHJnWjNsWmk2NXlnbEw4andOSDJJamlhcC9xWC96U0MrRlJv?=
 =?utf-8?B?RWdGRGk5bUljaVhNdWFPOUZxNnIzd3lIVGdrQlF4d2xuWHJMZjlLK2loOVZ5?=
 =?utf-8?B?MEdMK0VxYndyM3ZwNTdWVW9tRTlwOU05dmdTUHFoWFdOZXV4N0szUmwwSGxR?=
 =?utf-8?B?V1dwU3IzV0JZajVUdFFYUzRBWU9jN1YxYlFTMWtuT1hhSHl2c0xYdEhoQnFm?=
 =?utf-8?B?WXhHa1M0TXBGZlJqTnp6eHV5bGNPNmJpS29BdnhLLzJNb3dsT0NkR3greEVp?=
 =?utf-8?B?UUM0OW0zSkg0aG0zZHdjVEw5bzJiOG9CYjQ4eXQrckkvdXc3d2lkQkJ0L1RW?=
 =?utf-8?B?TUNNUjMyd0Z4NE5McGxqYkc5TjRmMnkwZ1NwaXZQQldqdGZLSVgvZThPdTBN?=
 =?utf-8?B?cktmWkRJWWRYcDBLbjl3ekgzaXVGREhoazdMWkt3NDBQMUgveXYxSmxrTnRE?=
 =?utf-8?B?KzR3bnhPcUNKSCtUclRLZ2dadnUremdpVmF0TUZVOUdWZFRUZUtJaXBrQWVK?=
 =?utf-8?B?TVVnMk9ldXpmMjBBRFVKWjlXb0paQml1R2R5V0d0Rm5JUkpqeTVHb0I1aVFr?=
 =?utf-8?B?NGR3N0ltMko1blIzSkZJMXZkRkNRMnFJbGdPcGtwdk9jdnJaZGxqM1VMYVVP?=
 =?utf-8?B?MmdoRkxSR0NOdlMwY2FwQzZJUUEydWdXTjRERkZkOWJHdUpFdkM2bmFheUUv?=
 =?utf-8?B?clAwVmVmM096UW50eElsWUpiOUExSXE2UExjYnlHTmJ0WXZWaXcxRjg2ajdM?=
 =?utf-8?B?WHJRbFZpZjNLTGFWTWs3cnA5MUlHZjhVSktnNmxVREVyYUdIQUt0YVpWTnlm?=
 =?utf-8?B?UmJ2OHZVUmZsd1hQQ1lBNHpGanVHaGpJbERpV1RxamhMWDJ2K2ttKzVZTlM5?=
 =?utf-8?B?eExQMGh4ZmU3bURkelJzYlY3dE9acmNPeGFqeDYyWElqOFpUSGgydkR0bmNn?=
 =?utf-8?B?V2VtWk13ZGZGTy95Nm5RR0RkUk9VSzh3MXBUVDhEdmt6WjBxVXlKZWZScWxN?=
 =?utf-8?B?NGdHaUI2aVdVZzJWT0U1aGlISEZSUkdjVmtqMVZ4blJ4d29IWVNvL01xalVU?=
 =?utf-8?B?TW5aT3dFYStiVFQyUXFqU1cwb1VmN2pDL2E2WXlWR09SajF4T3NqNTM0VW9m?=
 =?utf-8?B?WW1LeXdBb0IzZVhaa2VHcnN0c0NVM3ZEUS9MVlBXaElJNlF6TFhURDBIMDJx?=
 =?utf-8?B?am9wSThXY0ZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:05:32.3258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9844febc-1699-402d-abc5-08dd5bff8e97
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10569

Currently, we are unnecessarily holding a regulator_ww_class_mutex lock
when creating debugfs entries for a newly created regulator. This was
brought up as a concern in the discussion in commit cba6cfdc7c3f
("regulator: core: Avoid lockdep reports when resolving supplies").

This causes the following lockdep splat after executing
`ls /sys/kernel/debug` on my platform:

  ======================================================
  WARNING: possible circular locking dependency detected
  5.15.167-axis9-devel #1 Tainted: G           O
  ------------------------------------------------------
  ls/2146 is trying to acquire lock:
  ffffff803a562918 (&mm->mmap_lock){++++}-{3:3}, at: __might_fault+0x40/0x88

  but task is already holding lock:
  ffffff80014497f8 (&sb->s_type->i_mutex_key#3){++++}-{3:3}, at: iterate_dir+0x50/0x1f4

  which lock already depends on the new lock.

  [...]

  Chain exists of:
    &mm->mmap_lock --> regulator_ww_class_mutex --> &sb->s_type->i_mutex_key#3

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&sb->s_type->i_mutex_key#3);
                                 lock(regulator_ww_class_mutex);
                                 lock(&sb->s_type->i_mutex_key#3);
    lock(&mm->mmap_lock);

   *** DEADLOCK ***

This lock dependency still exists on the latest kernel and using a newer
non-tainted kernel would still cause this problem.

Fix by moving sysfs symlinking and creation of debugfs entries to after
the release of the regulator lock.

Fixes: cba6cfdc7c3f ("regulator: core: Avoid lockdep reports when resolving supplies")
Fixes: eaa7995c529b ("regulator: core: avoid regulator_resolve_supply() race condition")
Signed-off-by: Ludvig Pärsson <ludvig.parsson@axis.com>
---
 drivers/regulator/core.c | 76 +++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4ddf0efead682fd006657cdad1dc335f08f1da3e..c993ab48f4153965706567b3f497d461c46f535b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1830,12 +1830,49 @@ static const struct file_operations constraint_flags_fops = {
 
 #define REG_STR_SIZE	64
 
+static void link_and_create_debugfs(struct regulator *regulator, struct regulator_dev *rdev,
+				    struct device *dev)
+{
+	int err = 0;
+
+	if (dev) {
+		regulator->dev = dev;
+
+		/* Add a link to the device sysfs entry */
+		err = sysfs_create_link_nowarn(&rdev->dev.kobj, &dev->kobj,
+					       regulator->supply_name);
+		if (err) {
+			rdev_dbg(rdev, "could not add device link %s: %pe\n",
+				 dev->kobj.name, ERR_PTR(err));
+			/* non-fatal */
+		}
+	}
+
+	if (err != -EEXIST) {
+		regulator->debugfs = debugfs_create_dir(regulator->supply_name, rdev->debugfs);
+		if (IS_ERR(regulator->debugfs)) {
+			rdev_dbg(rdev, "Failed to create debugfs directory\n");
+			regulator->debugfs = NULL;
+		}
+	}
+
+	if (regulator->debugfs) {
+		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
+				   &regulator->uA_load);
+		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
+				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
+		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
+				   &regulator->voltage[PM_SUSPEND_ON].max_uV);
+		debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
+				    regulator, &constraint_flags_fops);
+	}
+}
+
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name)
 {
 	struct regulator *regulator;
-	int err = 0;
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
@@ -1868,38 +1905,6 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
 	list_add(&regulator->list, &rdev->consumer_list);
 
-	if (dev) {
-		regulator->dev = dev;
-
-		/* Add a link to the device sysfs entry */
-		err = sysfs_create_link_nowarn(&rdev->dev.kobj, &dev->kobj,
-					       supply_name);
-		if (err) {
-			rdev_dbg(rdev, "could not add device link %s: %pe\n",
-				  dev->kobj.name, ERR_PTR(err));
-			/* non-fatal */
-		}
-	}
-
-	if (err != -EEXIST) {
-		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);
-		if (IS_ERR(regulator->debugfs)) {
-			rdev_dbg(rdev, "Failed to create debugfs directory\n");
-			regulator->debugfs = NULL;
-		}
-	}
-
-	if (regulator->debugfs) {
-		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
-				   &regulator->uA_load);
-		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
-				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
-		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
-				   &regulator->voltage[PM_SUSPEND_ON].max_uV);
-		debugfs_create_file("constraint_flags", 0444, regulator->debugfs,
-				    regulator, &constraint_flags_fops);
-	}
-
 	/*
 	 * Check now if the regulator is an always on regulator - if
 	 * it is then we don't need to do nearly so much work for
@@ -2133,6 +2138,9 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 	regulator_unlock_two(rdev, r, &ww_ctx);
 
+	/* rdev->supply was created in set_supply() */
+	link_and_create_debugfs(rdev->supply, r, &rdev->dev);
+
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
 	 * but we couldn't propagate to the supply if it hadn't been resolved
@@ -2271,6 +2279,8 @@ struct regulator *_regulator_get_common(struct regulator_dev *rdev, struct devic
 		return regulator;
 	}
 
+	link_and_create_debugfs(regulator, rdev, dev);
+
 	rdev->open_count++;
 	if (get_type == EXCLUSIVE_GET) {
 		rdev->exclusive = 1;

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-regulator_lockdep_fix-ef2ff8a397fc

Best regards,
-- 
Ludvig Pärsson <ludvig.parsson@axis.com>


