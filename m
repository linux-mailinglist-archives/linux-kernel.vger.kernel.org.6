Return-Path: <linux-kernel+bounces-173776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C58C0541
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E57B21937
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4812CDBC;
	Wed,  8 May 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kFIzC120"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D538DF2
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197427; cv=fail; b=e5+m7eBWdOcOv6k6Js3DViiRLhVOzxoINWFdzBrYS9GAwRk90Rj7qUkn/vtFvHUJl02TlkxbV4kqy9jOBJZAGGg7OZzFNYhFVkLRKaJOH6RQtnPUq/4zFT6nZr5/y0nptgjToUJgX7yyv2iddhyA959KeU67XeyyxfxIzuiDuME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197427; c=relaxed/simple;
	bh=WiQ4RVmhm52p+vV78bTycwX3K0Lpmw6oDeU5vekyN+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hl8ETGUHrW6Axbhk/I+KdEvAdA/GnwDPH9pgVoM2Hpk6e02VgFVAjowQ6AL4v80Em8G4q+ixevnRmB7zAqSdEcfgEnZlxk8Wx0YSf8Lf3ZnXUAxqjyo0FxdAA7WjGHQIHv/8TyI5cSBsPwftasJk3TZ9ozx6ekq9CI+8Z0UaCzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kFIzC120; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJh5H1MH89F+IKr6ohsExjDN6f6RGiALa0eAhchrktIf1mRRQscmpj/XmevzMltrf1Hp5SKekTkwfzI3tfFY3Ncibhkyy+LbHQYmhztICgGXFffkHnJ8K8I6uD0/MmxxOjqZ4vwmNOBmY8Iud1Unq9SqYUqxcIqTo8mH031T0tfaFcsE/VCpIacKrrzsz5PX1PSv590utDvNoeK2XD0HiV+4blCkfzLTVoVcE+SUPsoeJwmwEU76R0kWCFMS62QDqjMrLsDBSvTPI/MDFVn2qk2UTNm5Q+pmoDxXAvZi6b7UgxtR8gA9PVlqFIn38r0j3NsyyBPLVamMCQ8aJabDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04qr4LyuXbPa2cdzASG8pa9GNlgSbAUkzKIqYEAm5qA=;
 b=biNcLs+P7WWCw+MH9nT6QopzM5kEko2p1RjSJeARS7ChgpVxP0pU0+9w90zZ1UJ2VvHfKI5L0AVuznF5a7b45YFWq0hYR3h6mC988FKTfbAklWfil1NQ18czQ6qcbYYvHY/7sDdFG8H35sz5lpfctbYRafqFKEoPd4kEVk8d1nnJTbFEYm4VZ/ABGvRFsucbd8tmQd4TMo9w0uIQcDtXvweWfyhnvnLnm2jfbTbdu1KsdXB0Acooi4XKnRPp7x3poviPJHsSTRaDfKm2Orl2myEoiMEClv2eMSY8UNt0Y2boZZyY6/R9Dsxq04JDNLQUONNFyN/BLrgohuOLa679Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04qr4LyuXbPa2cdzASG8pa9GNlgSbAUkzKIqYEAm5qA=;
 b=kFIzC1209A483Yq97otrNXry9VT2wUDgqTg6jNL86K2uiVFRZdoX1vvch8TNSnhsTGBMdFEpwJocym/2FE/Uh7d4aIlD2tMCHKL69Rs15Il9ajRGiywuPyGXNhhq/uPn8xPi3M2czBUPnBHPApzHL8u70Zxb68b3T15qk9RXH+o=
Received: from BL0PR02CA0056.namprd02.prod.outlook.com (2603:10b6:207:3d::33)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 19:43:43 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:207:3d:cafe::90) by BL0PR02CA0056.outlook.office365.com
 (2603:10b6:207:3d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 19:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 19:43:43 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 14:43:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
	"Aurabindo Pillai" <aurabindo.pillai@amd.com>, Daniel Wheeler
	<daniel.wheeler@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Tyler Schneider <tyler.schneider@amd.com>
Subject: [PATCH 1/2] drm: Allow mode object properties to be added after a device is registered
Date: Wed, 8 May 2024 14:43:07 -0500
Message-ID: <20240508194308.48366-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e27d9a1-8796-4fde-1fd8-08dc6f972af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QATiqBGmPtbOOZWbMBcxjztCy+2w0E/KHXg52IWiS5GT0ixXCVKLTNxvwM1Z?=
 =?us-ascii?Q?yhYvKeubbp2bEtNT3aquqF37CgSfLPPECqbTDQMA6jje4j78Pen62OO1oiGm?=
 =?us-ascii?Q?z+KF0SjL/UovoVOpMp5lhT9syOLxHrjBBaL5HC/MkjegKWhxyIqON1eS/aEt?=
 =?us-ascii?Q?j00QGmkx6Y1Lt1/9YHKEoXP69ERoonHl/3HC73orJfneOV6knGZZ/CUxQ5/h?=
 =?us-ascii?Q?4HnJnzl+9nB10WXjrbQtYvEi/A57o1RmrwlRCGfd1GYASntfm5VfE6rufT5h?=
 =?us-ascii?Q?ekoRul7+7+tl/JdpZSrJu16ousgnBhpNZp7lMWsmuxSL/NkINij2DJImygzJ?=
 =?us-ascii?Q?cCuENseDL0JZ0lKfH/yRibeqM2BrO6xthRIOZ4dtuzf01Ar8IR6cxJYStVXS?=
 =?us-ascii?Q?KCk8MlXxkvvDOqZblxCRI3DVWRrOcdBuX67fNocKTM0653zXqB/gqs1Du6zT?=
 =?us-ascii?Q?rQed0OoKixzgRTSRx61IGReaxiGmZfbsASbrdI75KCLXFI38NIjSMUQKWITf?=
 =?us-ascii?Q?Vy85CbeG5BgqrDqMGjWOf0st7jqebU4V/eqKr7YUO8UlkoegN52kJQJW0ydR?=
 =?us-ascii?Q?ImYu851ffGiLDZV/PCTd9BskbJahxsjgohtQYDO1Mg52e1NbA8lW1b31AmDU?=
 =?us-ascii?Q?PHFGVcEsx1WB7IZGqj98AnO3eoIMfKzH/CStrGtiWEK3PFrjdDnxRnLZpyJV?=
 =?us-ascii?Q?oBns/R/a2zStEZs80uA0pIiKHFJtpTZ1txU+uLmik7zF+pRGUTaTh5bkcKxh?=
 =?us-ascii?Q?/qoVQs0Oxv8ElkrXJYQlJ6THNy/U7flj5pz17QkMwJu+v41dCmL+6ZrKH8ud?=
 =?us-ascii?Q?JVYTUkhgRSkC5zV4DS+xUi+IZEPAvI76aDiuEmTUtVvnhSP6BOqt7krbGi6A?=
 =?us-ascii?Q?1iilfgpu2wzshV7RoOm9sKlBvBakD/WOSulyEuUPky2YNJqmZRgqYfqkhYOP?=
 =?us-ascii?Q?EygzOGVW8YVCA8qmv+OirJinRQTRRv/ktLNAF4uAFyFxRBFOTGL0Mtc82qIU?=
 =?us-ascii?Q?j8Bw8OhUGcxSUBPN+PKyzSLfth30DUxE6DfYOsv+loMc2izt9CfK1KWGMNdP?=
 =?us-ascii?Q?QLiKdTnAYpMFSDm1ruzI2TGBX+EYvaSPmCsag4ApXxQRqRMzlgkkLv7+bB9P?=
 =?us-ascii?Q?UVqwl2JiO1b/FQtkG4E/jDiZ/R0acAJeTrrDmUNwi83rvJ0WBolBcms4K4VX?=
 =?us-ascii?Q?ig6FNyVCrGrwzmw7eKAjOjhSqgY+rRp8Fw/SQYptR6vnjkxoAuYE6+8OwzsE?=
 =?us-ascii?Q?oPEKjhDHswCMuiGSwXRTFTcReV4XnOZsdTFxcznfqIzzYZAwvahC+4lWKF5l?=
 =?us-ascii?Q?JqHrxgwnwFi7xTtd6SLlc/C1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 19:43:43.0816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e27d9a1-8796-4fde-1fd8-08dc6f972af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692

When the colorspace property is registered on MST devices there is
no `obj_free_cb` callback for it in drm_mode_object_add().

Don't show a warning trace for __drm_mode_object_add() calls for
DRM_MODE_OBJECT_PROPERTY.

Reported-and-tested-by: Tyler Schneider <tyler.schneider@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3353
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/drm_mode_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 0e8355063eee..b077547a2db4 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -42,7 +42,7 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
 {
 	int ret;
 
-	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);
+	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb && obj_type != DRM_MODE_OBJECT_PROPERTY);
 
 	mutex_lock(&dev->mode_config.idr_mutex);
 	ret = idr_alloc(&dev->mode_config.object_idr, register_obj ? obj : NULL,
-- 
2.43.0


