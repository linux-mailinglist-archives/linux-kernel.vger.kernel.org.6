Return-Path: <linux-kernel+bounces-395951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAED9BC540
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34A31C20C53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31751BC077;
	Tue,  5 Nov 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rSmg9MEP"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E31B6539
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786809; cv=fail; b=gCCserio7IiM09ZU0DCgfylTapDTwAVM4LNHf+Zcj8uVtLjzPDIaEB+AEwIIgS02IIzLmMimxNECvbm/BwEAYYnZIXnAiTLs9FQ1ShHq21ytlSaioMuGqZ33xvMafD1zsqW4HNXm62skwYElzSeeim//ewg2BxkRaUsff0ybLio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786809; c=relaxed/simple;
	bh=T2K9JkA6/glB1LgxGKc/U1qXaBx+//ZzNB+ZlMEJ5Tg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iboGi23f+GMtxw8efOfhAfVp4slt3F36AnvN7cn0xMCsuUHSpxXYPUfTXJhM12VlgKWkWVS3uVC3SDM7pAxsg8Q5JMtAveRp8keV8eYNHZnISeS6WZcD/Wc7LL0PnauyYuSCIZ022vVEh68ES7kHo3R62nemOg5Jmx+YFALhJI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rSmg9MEP; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MybHvIYzjj29QQCzwD0eJwb0U3AYxGn90TBrZUuHLlnU64Dfmqa5y+mIcmBjXeLh2c20YeI2xADoPtm8QFNDl9nXhd2TuxTk2FwktAehbUjLAtIBkQyzlWBA4XYZKNmQNTzr6zDFxD6Lqh4SpRV+m8VDCbnAMXLz7r1xMTJGFx5NvzrGdhaPhPwU5JqXy0A+6dq/yxJGjZUNBPOfkG7tplyXxdj86DnD5Pv1dke/1qGCJe1Tl5ZZ026yQkfB5BvldnjF7ztc4lvVy6XwUA4R2SNIwu89XVccBnQ3Dmmz9VQMLVECDinAdfi/Js/Z71+TYdoPl2FCTBOn8vIizxI02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huYP415T/IJOdk1XFa7YtXiUfoXMQiYnlehFJ4704Vs=;
 b=YqhceGhkgxj1/UGq8RVysPLUW7eF3wctUCeDOgnoTdhKvE5LSEhX+NyQq7wm8mWAwtkjRPzRFiw9JivI6SHDjH0qJWXm50Dd9YGah89q8qTwAmRXCbfvJhGv8gVK6j0l8XPGFfjtUp43f93XBUCMjj6As3So18JhSZ06lFkQrEPNcTJNQXl9v7MmvVzGX1NZk3IpIAbGDbbK9QPJo3FSQwLp22CL5VMMSJZzfIvpzufgmcBZ149dN3BpIMF5E1Y5C6G+jlEj8cWXLx163jQj3LFmeMvJgfgGhPenFpVXn1Ti1k/LT9ULIlxf2VH4zXp7y7NUzCFYTsL5lIJ32nC+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huYP415T/IJOdk1XFa7YtXiUfoXMQiYnlehFJ4704Vs=;
 b=rSmg9MEPZ0Hecqc8E9tSVlGRuAa8srssKOuLrdWXOfYwqUX4oe5eGcPAjKFa47VW7mZvu+7dHyfW55iK6Hn0hvktK9j1/tto6S7pD7V8y1OyrxiDVIXWhjHqVhIQ7IZiUQwoy6v2jmXcxGw9nytPxQeauoEfr5BrbW0i35ALl48=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:06:43 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::97) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 06:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 06:06:42 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 00:06:39 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Xinhui Pan
	<Xinhui.Pan@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Jiqian Chen
	<Jiqian.Chen@amd.com>
Subject: [PATCH 0/2] Fix some issues when using amdgpu on XEN PVH dom0
Date: Tue, 5 Nov 2024 14:05:29 +0800
Message-ID: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a12902a-8b76-4cb5-7275-08dcfd60054e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7q9PjVebDWvnOwoR0SK7PAYzGBFExrmEGbN1FediWBSpp+QtO1+xqQRW39c?=
 =?us-ascii?Q?/qo94LwYElPj3OZbBCByf3P5OjgHw8cdwEvhgPq1MZY4iI87y+/fzlfIHw6G?=
 =?us-ascii?Q?/xov5fsURNw8z71NjxqTEHbhMAtXvvkamo/CD8cIw+2XEauVR92WFVkXURQp?=
 =?us-ascii?Q?MHc8QAfn6a40robbfCllTWec/xj8RN9FyKBn+Xbb0Oie52v3FsEyw6o4yU2D?=
 =?us-ascii?Q?DjA8LUxir/KK5JLPXfLWINNlAlstYSDQ7Pm1tOifGINZx456tRC4EkihL6Xt?=
 =?us-ascii?Q?xrzFO5fDg4TNRm632WcpnvAKZ2tbJ5fqEeNNrS9pLLgGPiUaIPMT7mkHiKFm?=
 =?us-ascii?Q?DKuGcHk5u0zk8UVlxfEGypISj/UMN6ZoUOqttTdeaqviQ/9fZGSUbVW8dGWN?=
 =?us-ascii?Q?60f14g5Py2lZ3wh8agPNnJnE4bvovBwSjR+9kB+yQeW6Hs8TC+okxwUW5kD9?=
 =?us-ascii?Q?QrAL16YSVofv8k0H7dCcd3KplUb/m5TDbqQ9TsUiXOEcN/8QLqTy9qmMnk4U?=
 =?us-ascii?Q?4Q7/bq1P8dtPvCcHEShkWQ5C2khceH8X/LaHzeOG3YVxBuSDFeTWviaRZmbl?=
 =?us-ascii?Q?npgBjAuZQl+HUnN3AezCFtRJ97Y5Idx0wc5uPpkZxG5e2fNN0owGTsBqUhgo?=
 =?us-ascii?Q?bABKi2VUtGbSh7/OJpUPz3ep0e1wOvStoH5RSMjlHp/7+Je14UwpcqM6o7jd?=
 =?us-ascii?Q?vejs97/sCXRvqAb7pf6l6P/tj1juI1UipNYiiEibzWK3pSUNsJm2bbSJ55Hy?=
 =?us-ascii?Q?ZmWARerDn/h0PxrWmDoBPAywQGhmTIYktEr7QSSYZBjppUlSkaJmtPhiCAxi?=
 =?us-ascii?Q?6cfAdq8xsJaVsrQfQ2IQTu5ULQp5MAlrS63SiPY2CKPULEkXOa9iTGdffiWV?=
 =?us-ascii?Q?ysqM3wYPIoWY8h4/qkzgS6aPMngmfZC5K2+scVaCf3li51CLH+3Y/pZc7uxE?=
 =?us-ascii?Q?BBOa7ipfqm7+FXW946zoAw4jWbUM8LV4KjfMqz1PCx7k4ohEUAu9UF1PEsGE?=
 =?us-ascii?Q?NCIuFECX5ikOdup6ja3E9EKg0GvNS+H1jo6d1x8IQGFkKrduAL4Vc8RkODxu?=
 =?us-ascii?Q?t4m1EcbTbzd1PVcKtYjg45YNtg7Y/cFq2AsAhhavzTt9CpKGABtMnM4bZnRo?=
 =?us-ascii?Q?Mf2I91stGzz0HcM37mLWKasyxt8Zz49xFOd6fSPnOnAfIC5WpKuwWff575OO?=
 =?us-ascii?Q?LN0n27PRKgRkdl/p8Fe3QaYM0hgNO7ggz9/FFvmigydsUTOzCjLCsPBQrtmz?=
 =?us-ascii?Q?lK2hrGj9VsM3ich5BvVarNvr5qiXkd1CGQASzoVvpt5IrGWZPsZCL6Yi2I2s?=
 =?us-ascii?Q?Kn6uD/a7UfzxZx3zRyk2FS1dL3g5ev4yJiH59zAs7XETt5bxEG/kYZxkTDhx?=
 =?us-ascii?Q?A+bvmnYoMRvWuHSX+v3v2Trd+v+Kt4eOTiwDkWaVmpBAkt0ndQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:06:42.6701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a12902a-8b76-4cb5-7275-08dcfd60054e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

Hi all,
These two patches are to fix issues we encountered when using amdgpu on PVH dom0 with Xen hypervisor.
Patch 1 is to fix a address problem that PVH type domain does a second address translation for pcidev, then causes the address to be not physical address, so we need to set amdgpu to be passthrough mode.
Patch 2 is because PVH type domain uses VPCI of Xen, but VPCI doesn't support Resizable Bar capability, so just return success when discrete GPU tries to
resize bars.

Best regards,
Jiqian Chen.

Huang Rui (1):
  drm/amdgpu: set passthrough mode for xen pvh/hvm

Jiqian Chen (1):
  drm/amdgpu: Bypass resizing bars for PVH dom0

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.34.1


