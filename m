Return-Path: <linux-kernel+bounces-336931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AB89842BF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187F21F21ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D79A158DD4;
	Tue, 24 Sep 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ll9qjpSH"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2081.outbound.protection.outlook.com [40.107.117.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15811487DC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171810; cv=fail; b=kWujAlTJpUohjPLL5ANCUGcDndsXV12I+5keqap1LlrfPWxKJZRxpcRLgr4g4+Tj0KixAR82b/sLvjtELN8PrP9pqRYWuiu+uP4u0p6dD7m2/Pxn8umNwsH4ywgC4v0IIdQLMDI0/TjEIESdm67xBKJzIvorEgxwiuTto4GFtco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171810; c=relaxed/simple;
	bh=ksVwK1VH/Y2dU/M92UC0rcRvwJscR3c35Axwgs4OzoU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VYqOuJEDGc2sHFhHpWptzPhN7h9fqcyv2gzf5S2U3NWo3pRTipciUyMJKWeti1KZJjYEPIVFX1CLoerc9DLXVEzYKpf26ZKEHoTYp2SFP8kFKYEUMGNa9R2dV19nxUbNchEuO+aYWDeChWEy6JM0e6HDP+0piCZeQogq5vkUfdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ll9qjpSH; arc=fail smtp.client-ip=40.107.117.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuiIg44iJb/YzonZLYFnZFqr70jmsRQZ+eBchwRVYRjUoJr22XSpC+BC4IxYmMva1IetnI9xnCqpXafloEj6rzja7o0NLZ5vZor8Cm4K8SLIRQrZCx6LPmdPPcUDtk5frg949nVRqQRtlqBDOnkn6l8a3cQxgG1B00kH4MfFIrOc9fKPUEo7/ZhStygRRkXBgQCPB/ClCLmGpKRx34QiLmmb3AqjJTwSQvcE+sttDV2h2RM1GYGNTbEdVXJ57o2iBA2Asqnj3gnjc9kI8pssrOHAj5NTBpWNhqEI3CEb/Ne0X7dxFd1oavxmTFkKdrtNTzwkXMZxSBbkH6RnN7szmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxVstS/tsmft28TiJt82p9fPxgOqFdFZeDzVMSpD8pQ=;
 b=osyx0F5YNInox2bMwmNA7Q+nG6xuQowd4HFxfh/iNvXloxrbSbxBC3nfEjK/usQe8OcfjQhjHGU9aW6tR0fYlbZYNd3bNnTHi2YbCsA1SY9LUNoGyvwqunYo+PmJT3tZ8sDOS2V3I22t13K/yprCwcQd1nJvqUQRSmFpWedwJyddGEXQMKIfNy0upxbLFg9/PrctZnxdKzA6aBLGvU5LFJAJDm19Ykf74NsLPDkDmXmuIVAUCPf5y0nTVo6C+HRgg25BnpfYoqlsl+Q98EZEfYwV506rYKmIC715GG2jcaKRykTIsWQSkVKcZ4vTR04/IKhz0a3sFRImZFxQQwDkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxVstS/tsmft28TiJt82p9fPxgOqFdFZeDzVMSpD8pQ=;
 b=Ll9qjpSHD1G/eFSGZb3ScYDzNNfzrpm8ftJ3OOXUewjXQIA//a8Rg0MvsVKp8RqJx8u6PMO2oz0KSGacSyvWKnHq+aNv5c4FrHfiQdx0Cci3DXUZ5PnKhqb/Pb4MAP44NemLjwO+V9FxSWiBj1P8qHuLixXWkG5f38BUYeKXj2r3y7YsEWX5yTBQAz54Ag6b0gmRXko/6eHuRc5D0g75qfsc9JD8tjcCcU+vT48f2I/p7W1+iiGlWlEQxeNAvOGstYJW864wWNRgg9z7zlq5Ve52u5UFjomtEoQaXh0kSBUpvEMmmN/bZ632FRhuMbQobCC80wQS6FXwMVJp8sA07Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5482.apcprd06.prod.outlook.com (2603:1096:400:287::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 09:56:45 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 09:56:45 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] f2fs-tools:provide a more reasonable ovp rate for manually setting rsvd
Date: Tue, 24 Sep 2024 17:56:36 +0800
Message-Id: <20240924095636.19457-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:404:15::19) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fdcd25-b9dc-4bc3-216a-08dcdc7f32d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jfMAblKeb3R4k+D7AwxTdwCajL6k7ak9L8cP2szBJiW3gLv8IRRsOukS9C3K?=
 =?us-ascii?Q?oH0vpkQldtxPK4wUVAMHnnimPvtv6BM24C9x5yFXOWQAa0YCnmwkgDM+UAgy?=
 =?us-ascii?Q?G4vSf5Pzw3Rr+INKNNhcS5UnA3h8ylkoJoadQ+akh+vfecnChipUTKNb2sP8?=
 =?us-ascii?Q?SMcgkPD7zEdpEmyme5gHMDw4X3zkSbwwm55RhxCBwdmgFtu368igBGOiJBhW?=
 =?us-ascii?Q?GJq6gUcd9pz4jYcC8XFx5g/IAUTJ3tZ0PeFKX3GG6OFnFvWWma6I9rTjJI/x?=
 =?us-ascii?Q?cnGofrirT4gp5jWIzxDhy4dnoZqnSpEGJK3knsmsq5GGNKdCU6Ryc7gJH4ME?=
 =?us-ascii?Q?kCGPbHdd0+RMfKbFLp4ay6s83AT0fCcBZ1aqXqaRPYg/sl6lYDVa/h1M3UiL?=
 =?us-ascii?Q?Tds4MBrugRU5/1OwVSHrnuTRwFsXWWeB4GBo1Sp/lBnaMpOnWX/gKuTrl1BZ?=
 =?us-ascii?Q?A9VulLAKEc4vkGoQRNqVvBg87PXwXOHTqTQ6I+qFu9t6XL1VTB9gH8qvlZtx?=
 =?us-ascii?Q?YqafJ0e3GJfkE/lGo0HO5sd0e177vdHKWzU24d/lxasBzEQXnCieg6mh9g7A?=
 =?us-ascii?Q?aESVfdZWBeKow/+hCT0J1sPyXDECDo/pTA9pP9IxZe20dbWYCdxLmiy7MKG4?=
 =?us-ascii?Q?RNg67aAVtBvH1DR+2iMW5WMO4rLPeuviB74Y7yr7UxWM4SwJgUs1ogxL96oX?=
 =?us-ascii?Q?NM53LO2uw9naB3kCBQ3LTzBMhDSTzuNKPmxfUlVdJNby7JDI0LKKnbxDdrn+?=
 =?us-ascii?Q?GKXD2wEB1M6u75OQgO7wsB0nBm9OO0Wfir5UtuuAcILnrpnz+vW/zAKI9847?=
 =?us-ascii?Q?o+6J6mzM33V384uRZQGYNRM9ktLb0hy161NM4Qq9SNjNbShdh6RYxeBfj3Qk?=
 =?us-ascii?Q?Mpsxq7cjBb78bYMZaRGOY0YqnB+g93ZP7IQGBcvzJmKpMYjxWNaSqMIKMKG/?=
 =?us-ascii?Q?3Et5Wo18zn9x+4e0odxxqRMelA/4OFS5cBJJfniGLTNwn+SAabIqenIS5bb5?=
 =?us-ascii?Q?trM/XsHHgBOqXPYa/zViH9wRfSG006nDavd/cUlfhCl6eLGk3jUNpjaAcuTf?=
 =?us-ascii?Q?cIYHsmTWcvolbqWPO/VKoqfMOo1UfVJ/wOdBVSzSwjXzK+WutYM3siT/vg+s?=
 =?us-ascii?Q?R1GWG+9ZmOpq7g4Zns+vmKeZKbFBy5P96AM8hCiigVDqPC1xViLqyhM4xdeF?=
 =?us-ascii?Q?9FvShQh5qQlvikPJOkbqs4+pWDF00D0HkVyYA5We3xwoB9Pb6drEz0rjrplI?=
 =?us-ascii?Q?4gfLl7UsXShgshu5Gnd4qmIJYkKPQbdEkzYOmEZ7ujdckgBM3Qkj+hnR20DO?=
 =?us-ascii?Q?LqpgXycb7L7YSTXDKmndf54vclr+LFz9NQ+ObUKYDzWaiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWcFZ0Gg1RRk5oNDU4Qwc6iqw++84qqqaTkcDrYDjrjWJb4Mz1vKS5VYLtUD?=
 =?us-ascii?Q?NeB7Oo2uB+mlDZzOoUs1Gy77VIqhCk7faZEaIdkB89Mrx3vl0zQSHN8MqrOc?=
 =?us-ascii?Q?PPdtz2kY835KQhqVU5oRcURTILkxQ6IcWfaf13HmFmzNAbLkvFkRA+8sHooV?=
 =?us-ascii?Q?kwx/4H/N/TYY61jal+QhInpRlCz7SZEZ/oxSgXehhJQn+cOH9/9o1ch5BM4x?=
 =?us-ascii?Q?+zxUHb6I5CEvJYzIKKYdCCpLSjxkQXBqIAARudmZGyXXpqv4Ng7t6uuPAOuT?=
 =?us-ascii?Q?Jnd7oMzGLsDPUSCHZWyx+oIRRsZ1ucazHpP17uw9cUGX6dH+PUXjHqe5Fqmb?=
 =?us-ascii?Q?2ysXGM92s3FoNsnN8N9fO1e2UEXdfci9jdPVnXVCxhTJPo/ugEGnByGmewLZ?=
 =?us-ascii?Q?hRKwmb6EYdyw/GjfdRRR2c08Uccb/ucYO0Xi9IEJPB66nxu9CmPH9+IjLCX6?=
 =?us-ascii?Q?/Qx4/4lJyQf1+PI5cWRN2Ej3YaYgO/m6E42E2EhKEXxR92BbKDw9iUF2DR4I?=
 =?us-ascii?Q?1tNMbcodhp5JpSiOC0Wk6Y0D+OYwDmUEpXBT55hxmhKBkUGicE7bN5vdOaGj?=
 =?us-ascii?Q?eoAX7AdAjgZionA3qJGjCVjtqSZwUCbjKR1jRcSpmwBMCTZwF/GkyPYGrKmE?=
 =?us-ascii?Q?2Y6Auqn+bywGbG9kXz/XxujHFNf6j8grrz8L3tYYiWyB6oG22Tpfvkk6odYY?=
 =?us-ascii?Q?3YjS5jNpbbvJla9VxP7NQD9bicsyGm79K5bZ8v+VMAmeIBV/X2HGqbwjfiVd?=
 =?us-ascii?Q?tdJ4UEcfdMWXXxbkHjYQ7DcK6Cve1A9nJ4XTbkd5PSuBXrOH2MIPVbIsCwSm?=
 =?us-ascii?Q?XTDiWTn1z1NXgCIjgdSROQJalXaPBBkyEvq7kOXOb2h1+F/HTxV7D4WvpqlB?=
 =?us-ascii?Q?/z9D2PhTvtiFP/oXouCxrsrcgomzyHjKPE1Xthf1pDVQNZAPHlzkjrD1FLTi?=
 =?us-ascii?Q?OhDPQJjsorkzZtp/EDDd/a7KAX5n5GL7xjhulx9MSA6e2X4YM73vimUMPRuI?=
 =?us-ascii?Q?+i6bR3JAQjiV5HahUhAZL6bOm6nTCFC+h0WDUlEyvoBkdlenC9/WunP5d/Bi?=
 =?us-ascii?Q?N5kMZ+T4yXQedTF5wTrcLT5J4E2pz3wSpAECkKuHtVj89yXNfBIfRhd7z27l?=
 =?us-ascii?Q?kwk7rSS4WohtuINo8mHVXDm/dAENKiD3jHrrXJBrfC7akP7pY/+UIQjzfQCh?=
 =?us-ascii?Q?bdo7rOBtdU2LpMLW8wB/N/qIfHgSH4PMav/QqtNiecU4VvHTZVuEXEaMySt2?=
 =?us-ascii?Q?aaYZArzmLYL3ZH7Zj8Of3D53HDpMMAwv93Ie1l8Hk2HwibmbAej1MMXhKGRi?=
 =?us-ascii?Q?BtrZhEqIkUhCBEf113dL33FUQRgV0HQscyvK7eIUIeWbsbmseR0V5o1QvZvg?=
 =?us-ascii?Q?xeWlWrQB4JiG1lzwbTGFCmDr6b9iMJwiaXq07K3YOUpBtyRat+FNHvP67BfA?=
 =?us-ascii?Q?5+fVR1eyrDP9MCHsCeK+qcAVdIOJbcdjE6t9ZTFf2RYBqjmtjiZU0Jyzm/Yk?=
 =?us-ascii?Q?YBl8MoDwDGl2/hBG5GtiBIXsHx+PC6EBAFojttgegrDInQCMKs/tiU/JHYmE?=
 =?us-ascii?Q?ijRZdAvWnE9fjN72UFUfi/8ScBbAJmST/tQCdZMa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fdcd25-b9dc-4bc3-216a-08dcdc7f32d1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:56:45.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WR4CU+V+W8CKaJbx3U56b0qEgwlaspIhKXIH+jy9EiyHsFgaQsFxZFVYbaqcx6XZxQ+YlkbqeJnQJIf0nvHjOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5482

The f2fs-tools support manual configuration of rsvd and ovp rate. In cases
where only a small rsvd is set, the automatically calculated ovp rate can
be very large, resulting in the reserved space of the entire file system
being almost the same as before, failing to achieve the goal of reducing
space usage. Therefore, for cases where only rsvd is set and ovp rate is
not, we will provide the same ovp rate as in normal situations, which
exceeds overprovision_segment_buffer, and does not occupy additional space.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 fsck/resize.c      |  2 +-
 include/f2fs_fs.h  |  8 ++++----
 mkfs/f2fs_format.c | 15 ++++++++++++---
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 049ddd3..eca6555 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -147,7 +147,7 @@ safe_resize:
 
 	/* Let's determine the best reserved and overprovisioned space */
 	if (c.new_overprovision == 0)
-		c.new_overprovision = get_best_overprovision(sb);
+		c.new_overprovision = get_best_overprovision(sb, true);
 
 	c.new_reserved_segments =
 		(100 / c.new_overprovision + 1 + NR_CURSEG_TYPE) *
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 870a6e4..038002a 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1760,13 +1760,13 @@ extern uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb);
 #define ZONE_ALIGN(blks)	SIZE_ALIGN(blks, c.blks_per_seg * \
 					c.segs_per_zone)
 
-static inline uint32_t get_reserved(struct f2fs_super_block *sb, double ovp)
+static inline uint32_t get_reserved(struct f2fs_super_block *sb, double ovp, bool conf_reserved)
 {
 	uint32_t usable_main_segs = f2fs_get_usable_segments(sb);
 	uint32_t segs_per_sec = round_up(usable_main_segs, get_sb(section_count));
 	uint32_t reserved;
 
-	if (c.conf_reserved_sections)
+	if (c.conf_reserved_sections && conf_reserved)
 		reserved = c.conf_reserved_sections * segs_per_sec;
 	else
 		reserved = (100 / ovp + 1 + NR_CURSEG_TYPE) * segs_per_sec;
@@ -1781,7 +1781,7 @@ static inline uint32_t overprovision_segment_buffer(struct f2fs_super_block *sb)
 	return 6 * get_sb(segs_per_sec);
 }
 
-static inline double get_best_overprovision(struct f2fs_super_block *sb)
+static inline double get_best_overprovision(struct f2fs_super_block *sb, bool conf_reserved)
 {
 	double ovp, candidate, end, diff, space;
 	double max_ovp = 0, max_space = 0;
@@ -1799,7 +1799,7 @@ static inline double get_best_overprovision(struct f2fs_super_block *sb)
 	}
 
 	for (; candidate <= end; candidate += diff) {
-		reserved = get_reserved(sb, candidate);
+		reserved = get_reserved(sb, candidate, conf_reserved);
 		ovp = (usable_main_segs - reserved) * candidate / 100;
 		if (ovp < 0)
 			continue;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index e26a513..9c917c9 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -480,10 +480,19 @@ static int f2fs_prepare_super_block(void)
 	 * overprovision ratio and reserved seg count based on avg usable
 	 * segs_per_sec.
 	 */
-	if (c.overprovision == 0)
-		c.overprovision = get_best_overprovision(sb);
+	if (c.overprovision == 0) {
 
-	c.reserved_segments = get_reserved(sb, c.overprovision);
+		/*
+		 * If rsvd is manually set but ovp rate is not,
+		 * provide the same ovp rate as in normal allocation.
+		 */
+		if (c.conf_reserved_sections)
+			c.overprovision = get_best_overprovision(sb, false);
+		else
+			c.overprovision = get_best_overprovision(sb, true);
+	}
+
+	c.reserved_segments = get_reserved(sb, c.overprovision, true);
 
 	if (c.feature & F2FS_FEATURE_RO) {
 		c.overprovision = 0;
-- 
2.25.1


