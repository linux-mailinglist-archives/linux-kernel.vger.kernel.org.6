Return-Path: <linux-kernel+bounces-332503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AFE97BA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FD01C2040E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087617DFF7;
	Wed, 18 Sep 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="diGFlGUb"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E9178378
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653996; cv=fail; b=CcrBzvbcSoTe61aWWyx5EY9wyTKJ+7T7UwawUPwFTqEMr6yeUDyohdbynzDGKzRzMU6iWw5IKUMBjbi964Xuuv0Io8DiFgufwRncAgbrSMbYcYBcTtxrHHSRYHV7YvMznf/OZ7VahNQhMX5tWMvqMgrUHxQAsctDUVR1WX4gV2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653996; c=relaxed/simple;
	bh=H6U+xrmapM07CJoMHmOCte/N8oi+LG9lPb0TyjzrE8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cDTNXVnMHYT+VoGxc2w87Og0EaPCdEMC/6d8Pn5rhbfniS2nTfdotD1D9I6doB7etOKLKfPzWQWjb5lNSgggALMUhTWHF4+V/w+cNi5AqUalkonEr20I3WCSq7RvhckcPt2owZw7OTNtHhHhNmm0iGuHmVevmoNa4e4y10QUZmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=diGFlGUb; arc=fail smtp.client-ip=40.107.117.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBNItt8CW58ODg5Dp8TAC5DWBq2EOBHTK1JBmki9Qqtd2pPKYbll+celRCd+YqLvz0EKX+ta1QoEZyLeB/QiqoPZER4CoQOBTQA9jcqOX6v2dA3tnDTR/DvAtbLnlXdiIUAZbd6GjXrB227wxVBGMxKFNOz927e79wWbynFfBBWacvKFvXsozvUvRQ28KV9fHfw9NZ+MVX04uC4yxZWSaTLH8sutsIzgV0X41iGVF/jaEIv/3QqSgV3PxCnDOmDxfDqJUZ3Re/GnaTvAeYz9X8rAPNVoP3UaIGx3eBdLusWAbq34frFq8e4bfG9SMpkPUNo13VTKcxnPxty0rShXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wovymd8akxg53irptRUgFwGJ9wUNA4VzdT4Dg8DoaE=;
 b=e0JRV7PopZxnY8sqY8eEZHbOrqnGoON0vj94c1ywCwoAOLA2oqeY0Vk5hsvrI+XNpJXrJlq254pIPvoKGQbcjZqo+dgUbHgOu1U/mfc0+GNkfYV3P8F4F6KNYKNyxyeLbrai3OfoXOuW5BbZljPVE3btApYuTNLK5qXl8T1zUcZHTZHlJhVTwDLDGpynYVlmnFLVANtO3KtPgjZkqieM2ZPIIFLtTu5lXd4idQ/dMxTXOZcnygwld4at7yJqLjoXb46Lb2IRDidkArRpWhlrFuxAVU3rTy1YH8bb7AhG0ir8zEetOctFEmjvQTyJDoL5C7v3ewNhAhDQdpeN3Qocrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wovymd8akxg53irptRUgFwGJ9wUNA4VzdT4Dg8DoaE=;
 b=diGFlGUb6JqjFdhRoO+sPkery5D4VlagNE89yNO+gTJmpB0rRebLVuRPtDzCIfTdc+2gzz8JG5+d7FzTxwkxxKiSIfiwRxv2etpgsVY0TJyu4JDSi/IwBCV+5B5oE+zghxcnZ1IGYFUV0Pz54h8rAH5W29BUA+KqtpJSs4flf6M=
Received: from PUZP153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::11)
 by JH0PR02MB7375.apcprd02.prod.outlook.com (2603:1096:990:62::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 10:06:31 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::7) by PUZP153CA0007.outlook.office365.com
 (2603:1096:301:c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.6 via Frontend
 Transport; Wed, 18 Sep 2024 10:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:06:30 +0000
Received: from cndgdcavdu0c-218-29.172.16.40.114 (172.16.40.118) by
 mailappw30.adc.com (172.16.56.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 18:06:29 +0800
From: <liuderong@oppo.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	liuderong <liuderong@oppo.com>
Subject: [PATCH v3 0/2] f2fs: modify the calculation method of mtime
Date: Wed, 18 Sep 2024 18:06:18 +0800
Message-ID: <1726653980-590956-1-git-send-email-liuderong@oppo.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|JH0PR02MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8e5736-11ce-4f3c-0eb4-08dcd7c99151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EumWgvz2Uu+KTv92Heo4aHCfRNTgirWHg+VFNwDHDM0rh4X1x1ufp+7ybb8w?=
 =?us-ascii?Q?qr/gS1Ao2I4DGdW7OChG1bOcF/NAp++eqaGhxyzj5iOWoHduVOEGMmy27lPA?=
 =?us-ascii?Q?ziIfU/Qx/pwKrKZ2OM4jtXLcAoWtV4ICMg1+vd+sUCjDv//OtEEKMWz03ux+?=
 =?us-ascii?Q?xUUr7XLlr1UENywBcfUZZfah4mqtUnWPwcjktALFgnN6q/r/FiNjcnQqD+tx?=
 =?us-ascii?Q?BNPhFjopJXySN2oklIU12BHXZh69hnisIbICppXyhID4ys4unp4kD6gABmhP?=
 =?us-ascii?Q?TM1YfzMEuxSbUKUVwpzWuAzfqpQc+bMoKDWsRuJ/NmItscv90m1x/jHzYUk8?=
 =?us-ascii?Q?lfybk5gJN9AsBmfO0LOttUOhzGfbgn0F1lbyRXgxhfFffvzyivrEgc84Y2Oh?=
 =?us-ascii?Q?HVgC8wYaa5FpTmEG0iDCnHxvKfDCAh5v6FnNwCEbzuRjlcx/dTGDomG1RPVZ?=
 =?us-ascii?Q?Xf/TXtpa7QoIfPwD9hjHinwSUUG2QMHXvHCxEm4vJoRmUWdMWcXZcGwtzmqN?=
 =?us-ascii?Q?+dEt5nNltETG4bg+eMBzmSJzUfzZYdCAKj7Qboi2YmI5/fUDc0Z+rW3Ka36R?=
 =?us-ascii?Q?zAVtgZeRY55nyQCHUeG9USrnJIts/Doaq0fGBhADPVPJLSJMhyoFbKEWIpAZ?=
 =?us-ascii?Q?HgC4FiMeFvCGgdvAObddpsYoJhe716uvA+fbahjWSI/PpKW60jSkYaZxYFeS?=
 =?us-ascii?Q?Mjq+6iMNvJ9GDpoqFIOo7t+tXsMF34myQhYR+XFFZyAF0r5svnub+0mDvUoS?=
 =?us-ascii?Q?w5qu25MiA+l3IubY/jNcW9mzX+DiLId/+EHSL6QImS7McJ1QyS+2llkD6jzB?=
 =?us-ascii?Q?EAyDWOMOv9+Xqu25iO9U3FOytF0zjR7j7awFGCwrSHJS+BXFw7VCaejbMB89?=
 =?us-ascii?Q?tJ5/kim4hG8e0x3Y9YbpecxmonGvo5HEdRxN+kxeu16GIrwmqtjy7gdPITV3?=
 =?us-ascii?Q?v9VplccmA8D4fDZqbnpixk5qAw4hBrdU0+oUDk6zEDO4xKKHAgPq92dpQUvo?=
 =?us-ascii?Q?Lo46bxbX4Yr7wcacrSHgSSMQf2xWQVpSw3zySk7w8GvUVKWnjx7oKvB4j/tk?=
 =?us-ascii?Q?jjyFsE6SapqNjaekpC2SE/JSWTGaPgaLrJF/6Ekfr5vVuOV7skQujuMztn/e?=
 =?us-ascii?Q?y/7Wdgu9PVqFC4Z1zTBBHANBgLX6+3gF6Rk5XGTZBNIdMcQl58qD83dC8tpS?=
 =?us-ascii?Q?iYDrnpyGUfBEzAmXN4fWJR0TTu8KqUKjJ7WvoGEfULLHk1iFrTe+Yf/bBTUF?=
 =?us-ascii?Q?QYMgsyZWvxrT0vuQX4HzAn4LO+rTUp7eMwrxxq1lqP8olYTaF5esZ6qKwrKp?=
 =?us-ascii?Q?pvxYCsKwBLkVoAy9Mm7C+b/cepiePgbjEVxPzScsvVmD62Fp5+uqp69W/tOH?=
 =?us-ascii?Q?vbgc7y1VWOMUBTUjS8hANiSOaGTjpV9ONpjDUrEZhUl5vGtyAfyisMHwpIqx?=
 =?us-ascii?Q?iHkM6OCnXieA3cwAOOcQmKJHunaKY9Rn?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:06:30.4455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8e5736-11ce-4f3c-0eb4-08dcd7c99151
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7375

From: liuderong <liuderong@oppo.com>

In cost-benefit GC algorithm, mtime will affect
the selection of victim segment.For a large section,
mtime should be the mean value of valid blocks,
in order to select correct victim segment,
it needs to modify the calculation method of mtime.

v3:
- add new define INVALID_MTIME and rename new API:f2fs_get_section_mtime

v2:
- modify new API:get_section_mtime

liuderong (2):
  f2fs: remove unused parameters
  f2fs: introduce f2fs_get_section_mtime

 fs/f2fs/f2fs.h    |  5 +++--
 fs/f2fs/gc.c      | 23 +++++++----------------
 fs/f2fs/segment.c | 38 +++++++++++++++++++++++++++++++-------
 fs/f2fs/segment.h |  6 ++++--
 4 files changed, 45 insertions(+), 27 deletions(-)

-- 
2.7.4


