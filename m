Return-Path: <linux-kernel+bounces-537795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCCA490EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF4188FBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979A1C07ED;
	Fri, 28 Feb 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="foVV7CDc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17B1BCA1C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721046; cv=fail; b=OZJXZK5+ICa3AkU+uSN9tTGBTbTSFK+VVoxP0x39+5O6PkXZqNBh0QA9wENirJkWI3m/7uhHssfiA1UAVmd9gd17MSGx9kJNaJUO+EnhzMEJ2V0XBNgAbg7xXJwnGHLqvs9CJOIfUdjoiBZO4eXO5UEatE6igfeYq2NxEb0FeOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721046; c=relaxed/simple;
	bh=v7nErJYDji/g57/K60L7Q6CSftNQ3/HGCy0bmDglkCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duox8fl8vDErljLPiizhkWsTS4b8fe55+BcBc9644guCWF0JDv5VvLt7zHZD+RW7s2/1I+/BtR8O5wmLcvnuXtxrjFO5hUtvv6IJ1foRP4IZLvtZEeWpxaIM6m2Up8PyfgFYr8J3r4rkSfOn9IlGqdeZif78ov+CcXLCHbLLSQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=foVV7CDc; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naX07gDTYFyy/woS7MPpNm5VA5DXNDOTH4THKTS8GTgfH1elSeUgncTIyZAw5hKxgO9XMcvUxnW0VR47JHUMeERe3C5ZkVrXvymqov+pUjJNC3/rCKXY7dAPoUHq6pNpQ7m9AgdLDuj1WCodp/Y/kqQDjusDBxx5LamuEfdCiUZGygCtbDGdKRVYBFCiXWrXnhO9VR0IYp6uI/NyJYIfO1+qZLzi6U0d+tz4gi7NknknrFErLITM/vNLn6pzDYvOTOEhp1nNjNoqs3/MDjDSqnaYvLyc2fxIUCTpCOnkPVZgM2hL6GqnssdSbTajtfAu3xuR5ReQ+SUDgwGSSixP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlUDLO9Mv0KbxxxVePrVKYrp3a2hwUSkyptytu0GRuA=;
 b=wDS22Iczl0KBPEc+oCJhHZ+VTrgRMt/7bnnwZiyMOv3HGcGDLdiB94DfeEaLFL2OUHrbNze/OfQNk6Bv2GGqek+3z7oiNhHU45S+Ug6G49HdDA7zM1aLsbL9n3YZuIeOpaq+kCFNRtrg3h7hVGW6Gm+CI4LAsZP76RfXeBgHfDfjCcpf6a93zsWljM00BrHyBBIAKOlyer86aA0n0hB8fq6PO7MEzMFDMVrwj0S/FtOPEA0ZCLjRLaT4rlTpB7BPUjVTWhaPv4ngaPxRxKoWMvvQdN5xP0fWthB21a6BpN6ITqpyoi6kS4U9UN0oH5qy30mMcW7E0K6c5gEtAsUYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlUDLO9Mv0KbxxxVePrVKYrp3a2hwUSkyptytu0GRuA=;
 b=foVV7CDchBFR6Haw0Y/5p7nNW0CLuQkqUg7J2eB9Qely6CbZDSeEL4c5STeuouPG56FBGgp0kMgcEyFbLCvpbaE+GcUCYjHjvTGI1fFQC/pU/QgndRo3xp4KMTX96Bz4hHIMQ1m0ZGAts+uRRDz8EvstmhamgRITvXpD7YESjM4=
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.21; Fri, 28 Feb 2025 05:37:22 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::bd) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 05:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 05:37:21 +0000
Received: from jenkins-honglei.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 23:37:17 -0600
From: Honglei Huang <honglei1.huang@amd.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
	<simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, Huang Rui
	<ray.huang@amd.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Honglei Huang
	<Honglei1.Huang@amd.com>
Subject: [PATCH v1 1/7] virtio-gpu api: add blob userptr resource
Date: Fri, 28 Feb 2025 13:36:44 +0800
Message-ID: <20250228053650.393646-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228053650.393646-1-honglei1.huang@amd.com>
References: <20250228053650.393646-1-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d67615-22b4-4fde-a209-08dd57b9f931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ar7ETty8yJ1I6ZTFBCFbhak4U9FykKpfRJ9M/Vgt+ztJgvocLNxhenTy78cN?=
 =?us-ascii?Q?4tkEjit3QTS1Px/Gfc5QzcUjhBZ2Tw47fNjmJk6zTiaMbV8HK7FlGzxQMuDn?=
 =?us-ascii?Q?tg3jaqJfhq41Tk5OlsSp/t6xuilwz5Q+LVShtWH+wnwWSYXDsbJm+xUFbdKM?=
 =?us-ascii?Q?43c7qjMBBY2dIOmFsMG3d6XHRFniTbKhhNJUcVcEsB7Dq3IJcADY8aCBZ3e/?=
 =?us-ascii?Q?/0uOz4GdoLEEeYuCUCpX+FwXbdK2m6xWFAIL7uqJQnLKYTrpb2k+bKdf28dV?=
 =?us-ascii?Q?VLtbEFbdPnAr2nvpsAZ8lMQck47jtELQJv5LtuYxiiykc8vg79zjPBv69rHz?=
 =?us-ascii?Q?x/hlilPWpU0U027YNFFbzhayFHhmeETMSNXIG3XhFrS/2lEDvTtB79ZyV0la?=
 =?us-ascii?Q?JDMhC7c7/4f+ox9QUeQKVT/Mh+/uPMUKRv/e3oRM8tTvjVGMKQ9ia2DR5g7u?=
 =?us-ascii?Q?BV6q0jp+R3NPVKbwBYxqMnuXPszvNzWD2Q2ne3zkMWD+3SJxpotRAUWDNs5y?=
 =?us-ascii?Q?LJnbKTnGpkx72ParPjW9d4a2Nmhnp2ueJSgT1JW27LJskXPrkRTfs4r4zD/u?=
 =?us-ascii?Q?ZB3G5LZbYzyx727o0vrUBld9okzbzHG2n2G5dWj/yy4Zu0raXekGQJir8Ihc?=
 =?us-ascii?Q?lQH5vZswFSwxqI8BanpabyLifR4dQpi4MJRsL1cM4kz8KFKHeki0pWyR+uPL?=
 =?us-ascii?Q?RCmDOoGTgma2mKzK74tJ8GlpiLU1X+Fxsa1R1xDTKBiABlmUb/bcONkr1AdN?=
 =?us-ascii?Q?4Eu0LALgniGYSbemTroayROGl56u2Mf7vWIvxFX+ZUb58M+B1xWVcRhJLeVk?=
 =?us-ascii?Q?JfWCr76WHe9PZvykbwVJSmNV1jandwlM5gNKnNlTe1jeOSxsVMgTQEb6GlH+?=
 =?us-ascii?Q?xx9r/yG5gb0y7LMn76aA5pjmzUPTjRq1iAw8RCVfwvagxLE7VoMi55Aik6OG?=
 =?us-ascii?Q?ineMfOdv+1UYoPeUmADtCClBHZseiWu8a+9JAHi76GiAMquF5konoCKxhWEh?=
 =?us-ascii?Q?WIT4py2UcutsHElq+BWhyexFHcRwyzkoaHsic9RVanDsA3Edxr5lX6p1Zuop?=
 =?us-ascii?Q?OxYnibDCzT8wCBuct2ksEIbDDGVrnDlpvBmGgs8jYuDU1exn0kD7U93LjhZA?=
 =?us-ascii?Q?H/WkYhAaWXMzby7uTWJZ0cIqiG5OLbN4PtMjmLmJ0vjZO2ov1qLu7RT3TmW0?=
 =?us-ascii?Q?AvNRtv+kzrsvHuaELZoBE7+HzDg5UrNtTlajfINutUHDKPdZh+GzZP9I4Pps?=
 =?us-ascii?Q?RoTh27p+vhdUO6OX6ws6W0QyWK5y+5mX3kyVo1udHaEukmSotz1nXJGdSaZe?=
 =?us-ascii?Q?EmRJiIlcldAAwaKbe9VGj2itNa8X60z+fuubLvar9KPub7Q5RWPqMO13HSVm?=
 =?us-ascii?Q?I+KZFD0NrAmcOnKislZXpvnI7z5pNRgb4WcZrLDQS0hG006EO8Y6r//q0tHb?=
 =?us-ascii?Q?6jqKK0ZXGzAlIEJgC/yeky3ZttwSiA9+jCKdFK109H0iqv/VfzGn98/gr0Ft?=
 =?us-ascii?Q?+xkXLohxhg7+g+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:37:21.7355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d67615-22b4-4fde-a209-08dd57b9f931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

From: Honglei Huang <Honglei1.Huang@amd.com>

Add a new resource for blob resource, called userptr, used for let
host access guest user space memory, to acquire buffer based userptr
feature in virtio GPU.

- The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
in this series patches only HSAKMT context can use the userptr
feature. HSAKMT is a GPU compute library in HSA stack, like
the role libdrm in mesa stack.
- New flag VIRTIO_GPU_BLOB_FLAG_USE_USERPTR used in blob create
to indicate the blob create ioctl is used for create a userptr
blob resource.

Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
---
 include/uapi/linux/virtio_gpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index bf2c9cabd207..4da36a1e62c4 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -65,6 +65,11 @@
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
 
+/*
+ * VIRTGPU_BLOB_FLAG_USE_USERPTR
+ */
+#define VIRTIO_GPU_F_RESOURCE_USERPTR    5
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
@@ -312,6 +317,7 @@ struct virtio_gpu_cmd_submit {
 /* 3 is reserved for gfxstream */
 #define VIRTIO_GPU_CAPSET_VENUS 4
 #define VIRTIO_GPU_CAPSET_DRM 6
+#define VIRTIO_GPU_CAPSET_HSAKMT 8
 
 /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
 struct virtio_gpu_get_capset_info {
@@ -404,6 +410,7 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
 	/* zero is invalid blob mem */
 	__le32 blob_mem;
 	__le32 blob_flags;
-- 
2.34.1


