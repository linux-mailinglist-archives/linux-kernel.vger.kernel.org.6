Return-Path: <linux-kernel+bounces-292967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686FE957725
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5AB285545
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606BE1DB453;
	Mon, 19 Aug 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sq4L6t5A"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225715A849;
	Mon, 19 Aug 2024 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105327; cv=fail; b=aU2p2dYCz5DoKEXC9CKoKR9iE8wOqAexNfQM3s2WwlHZiO1kebiyONHh+LMKXUkHEZZ6KFTCFltiPm3+TdE32rMVxSxpGnuz/mWrasVkXjQ/n8gfLiSz9Mt/MGkMXGGpXHVFvaavyk0VgdTPhxPL6rH5vt0uYpwJK8cttSb1QBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105327; c=relaxed/simple;
	bh=HhOUvbSojV1AQ5++hxbLunGn8hXOW8bzAd55ZKGmUNE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSfNezfok/Kcp8SuNmiAAjtYCXFDmxmhWyQ6CK/nP21GzjY01snIetIcQda/7PDnYBGh0djsfGlryA8jnNXasoQ98Xi0Pk1v3WnpNCiN4v07cHYraYgjIsiu14Be1e85T3OYqJOVOXabdvWkjLDwRknCv8Pw8NtMTKiqCYaeYsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sq4L6t5A; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnJo7ZBKpDsmsB07moa3299DsZ0ikBQ4SJze7aJ31+pLRzScWcSzt1chwbweXKiRIRY4OxBCb24QCXKYESB9XntNwgd0XivWyTxvSmik53aOvjQQPxsmF0ND2jSeVkm08A6pI73LP2Q3D9Z05SunWR3qpQhWLbrprDyJzdypml5DykGSJqCgWhQ0NBlj7BlwdzyChOM7+0TOknZcDNqhXKtyEpSVcq8bOxEDPcvSDe5kB+0WpivZ3N7ncs6fnrIch+aIAj2TCvYZD6aS4e65m1nCP+kd4eDke/yQMRgY82K6wTXFzCYxqSYtoQSKVDyXj3kx3boLN8VShfqKH/2hQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofsILX6ZZfrLZYUwOO6jfJiLkNJdD8780PmYx2gj7mk=;
 b=H/pdzcX2CIEu7MsH3L3oo1cUxz1Zs7pcV0Tg5WHUCd1336r42uS0sqMdgMxiKqxWGropfKNXE+elmMil9NiMiix55eUL19oN4JhkjnZIPCeEp0Yy0xltwmWIs+ruAhe6yLN6NEIiFJRVcyDODQvprzcfCji0Lyq8P62W2/HPfMVEpZ+PMvR+YF8Y+LCMuJlUzNcbMVbj5V0AwXMJb/9W9CEC4tKWUkdhwm6AAxQhXWakurYq1VMnuFV2qnPjIYWTbQUVDmZIys/O+pvn1G6etXgRKoLBlFJ/NfYnMYbMM6wt9K4KotiKc6Owp+afw/Xw2PhnYC0Rckgo03QWp/V1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofsILX6ZZfrLZYUwOO6jfJiLkNJdD8780PmYx2gj7mk=;
 b=sq4L6t5Ay/cFmyD/sStC/OPfrmZLz0k9Y3BYnBv883dJH032qhGujOX+rJ5MuMK6ydEJT42pRrVTJbH3XjWL/N4wY5HXsU5d1EpXDDYE10z4jIbUT523jrUNQAbHhsIyp+e4y5b0WMIGrb/cKRC0BHzDiVNsMK51G7sS6vtKB7/qLvJbr9YXawnGOk5rHv/JawANtXHhV+wsaIcnifjoL/EvK3ChDiiFn8MkOrK0tsfGc6bqd2CSG+mdpGvejHhnw8c2xVE9BGCtIwS9CSglecPE9l3keKcp/88twiqPBcTAx0U+xis8R8lHuZMVmKuDCPVQlFiQrgxhqE15G63++Q==
Received: from SJ0PR13CA0221.namprd13.prod.outlook.com (2603:10b6:a03:2c1::16)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 22:08:41 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::af) by SJ0PR13CA0221.outlook.office365.com
 (2603:10b6:a03:2c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Mon, 19 Aug 2024 22:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 22:08:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 15:08:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 19 Aug
 2024 15:08:20 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 15:08:20 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: James Morse <james.morse@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Rohit Mathew <rohit.mathew@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>
Subject: [PATCH] arm_mpam: Fix T241-MPAM-4 workaround
Date: Mon, 19 Aug 2024 17:08:18 -0500
Message-ID: <20240819220818.201870-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: 56681b00-96d0-4cb0-e065-08dcc09b7b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvLsXZl5aUMg44FLvb2f+zfvc5T+yxAHaDFKV49QkCPwmnORA9pet04U3Ev+?=
 =?us-ascii?Q?tQFR81VnPnY8pRKgQh9RTDVSxJRdOAcYuwQ8Qx8s3Q+xMxOxJii/+IMjpCNM?=
 =?us-ascii?Q?Ybbv4qPVGag8d1jhwLbinPpM/XBNgaDjFdbC/or61sI77yhaYZSpy4+/u+1u?=
 =?us-ascii?Q?B2kM+MijEEET+sEejoTsaDF9+DZzVOxo6QbVUtJ2gHnQoHl+OWPy5JShLHo6?=
 =?us-ascii?Q?wxOZXd0MrFWU5iEk1EJOzZgmyYKT04zv4zFxeUoa7cnacis/RLmzb5mVcOl/?=
 =?us-ascii?Q?Y2sUuk8gRxnaRWBOJIMlUApBVcV/rvn0V7F2J6XeSmhZRSpNkFCLA7E3V1KE?=
 =?us-ascii?Q?VVRdPMDctPJZn6fMmgh0mrNdxF4wjAVDzH+wZq0m+idWYvbK6Sm0Qzs/B+ek?=
 =?us-ascii?Q?ge9sHDyKGCYPLPoSTFg1vABc1MA3Qso4eLYEBwbLUJEPEi+nwZC8V7jQRfQG?=
 =?us-ascii?Q?fNw6MMHNF9+YA1ATPR7aQgV2QP+joQAyeBuksYgxQYETRugkXBxmwtmD364F?=
 =?us-ascii?Q?tAfTt6tkdwAOMlyIN4KD2AIwjJr3axsRmFxUeDV80W/xtcMaDSHDaMm5ATrB?=
 =?us-ascii?Q?O4bmg6wvuvb/V922BdGT/r18LSPyJWl5WxHqA/qeAS8BPPVHT6ILDQsrWLu0?=
 =?us-ascii?Q?PYR2iPIyFyW5vGKdUnHwkDuBhvDGT+csFW+L18SVUoJca5V2tY4sBiDZzQLk?=
 =?us-ascii?Q?FsNHCrrLLxGDRg2nb026iLSasXgCDd6v+y+fFOWkDIXoVvhDqt7PdL8UOFVR?=
 =?us-ascii?Q?StWlPxRHmU8K/q6B1icJScTV6xPQZR6v63wEl5jfZ/59Kgzmls+myyqA1SWs?=
 =?us-ascii?Q?8jW8VX+d+9rdi5gqJ7MASTNugeYA0igGrFVN3vmokDxIjaJEOAeknJTrYBlQ?=
 =?us-ascii?Q?n3youU9Mmnol1t+CfQmc78sGV8RB8ZqWAvk4HtTCbC0TDDwbLF9Dog+kG8yc?=
 =?us-ascii?Q?+B1Ukoe/1tY8xpo4cHUMtUTKLQ/NTARUYWphac/qrIloQy/KaEjGGfwoemqp?=
 =?us-ascii?Q?DWzrUqxTAG03v7bJSwaFExdV44BrRJFeSo42id7k0clOkv6VFNxw7O7l628c?=
 =?us-ascii?Q?Qn52fislpw5qotZXjGRjwKwqvk4yxEOsIxQdN/UyDTn2Q9rvKO8On/Ucvqvk?=
 =?us-ascii?Q?pC9/2vMKFPRC+fuvZnkAFoRRuGVzWbtL4/YyI129YSrufm5HOZ3g45AZE1JP?=
 =?us-ascii?Q?IjBQWkKDa0Bsus5LhcXsieD+SwyMS9xYe1JzyiIKtwDEOm8ox/LnPChsGJ2u?=
 =?us-ascii?Q?1hr6JgyZJR3jO6Udo9sn7yB00R9igSkiIfnLhtAu4UvQZi3uHgZyHKb03A92?=
 =?us-ascii?Q?crAbSfxtV4lcCgmJSvcaIDdkvip54mywXxnwaLO/vfnp0fc+szyuvVwbT8Ub?=
 =?us-ascii?Q?4PFkQxK8A0EameY/f55wsPWVI32B7Oph4Sd2NItyw104DaiUikx+g8XUfQ2I?=
 =?us-ascii?Q?0Y7qVR/6EaJFPZaGAGq8yGZOo4zwlm9x?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 22:08:40.4214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56681b00-96d0-4cb0-e065-08dcc09b7b8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

The workaround for T241-MPAM-4 was applied incorrectly, leading to
MBW_MIN being programmed with a zero value when the user specifies
MBW_MAX is less than 5%.

This patch ensures that MBW_MIN is programmed with a non-zero value,
set to 1 to fix the T241-MPAM-4 as expected.

Fixes: 13ff1b527e40 ("arm_mpam: Add workaround for T241-MPAM-4")
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/platform/arm64/mpam/mpam_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
index a802ca1c9f05..e49a27c02c66 100644
--- a/drivers/platform/arm64/mpam/mpam_devices.c
+++ b/drivers/platform/arm64/mpam/mpam_devices.c
@@ -2990,7 +2990,7 @@ static void mpam_extend_config(struct mpam_class *class, struct mpam_config *cfg
 	}
 
 	if (mpam_has_quirk(T241_FORCE_MBW_MIN_TO_ONE, class) &&
-	    cfg->mbw_min == 0) {
+	    cfg->mbw_min <= min_hw_granule) {
 		cfg->mbw_min = min_hw_granule + 1;
 		mpam_set_feature(mpam_feat_mbw_min, cfg);
 	}
-- 
2.25.1


