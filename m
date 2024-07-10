Return-Path: <linux-kernel+bounces-246919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CB592C8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCDE281561
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D492C182;
	Wed, 10 Jul 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AesXsTSt"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2052.outbound.protection.outlook.com [40.107.117.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDF17BDA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720580790; cv=fail; b=OfdGzUtPV9vqHekQ0g1P/5oCGik0d2GuZG8aIuv/AlPieAz5BnVMnlkD8ADhC7ZeM0c9uBbzAImEH6PY7hiCetOGLiBmesqPrANsGtlDapeUYxXElAjCMKAiGqwX3Pf8wr+L+hV6Z2rRSJpaqWLxTGQENFglmBMjMTntMC3+ii8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720580790; c=relaxed/simple;
	bh=7LcXkY4OG8+tAoInfcUTbYu+MCCjyiHl4dBDPnuBOcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXtI0LbUkEaAosV5Sgl0WjzO+56cwnhtTuMBUDygNiwSH6MNma0BHNw/pSwLDjVKjaRjwLbqCEkEU2JG3FG+dYEKR7rzeCQAsfec/pQuawjZOlUmpHd9W1UPlH8pm2TsX6lWSnIYLvyTrCmvNPzsPocq/HSuZ7NpH8Qm3WQFpZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AesXsTSt; arc=fail smtp.client-ip=40.107.117.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcV9z10KvKfGwQZviVTO6zP6bm/g8p+dsWvTBpQEM43fyfuoFJbj4EWvh7jVlm0Y2XtVUzHifqxYP4ckJQmh7GalFC47Kx966YozhpEMXProDsuCpARhmxBOXbg9KZvKXAH5OKS0r/BS2Wpqc6SPehTsGgGacWZ/VOqIPKB4scRaIgH0lYeCwD5i5mxQLxpbGw7AAmdrDHYqFPoxcnoeAY7qrVg4xFLHff7htTGEQOphNT4V2la/v7A9fwGMdabJ97shlUEffiht6lQZZHCNWm4Hcm+ABS344dAL7iw5WPLqE+0rrtJY5IIv6bs2KbYniGX8JgoxYffF0PszSqPm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev6p1RULBr8hJZaw8HlYO4WmszUtHZ131cla4tKfV3w=;
 b=XQuJ+FEXyivOcSqtPabFjv71VQ+wNGQoVJCevc56Oe+4GJCArhMfPFugbk9EmcOR9T9sNNJbbSENnEQEc/FCS9Bm2BFJGv2RgMRXUy64QqC47r00Qp1f1XH12HH/xf8pjj4jldO8ZflFoltdqvRJi9a9aHWGqRBMgf2alUP2KnLYQMT+pbJB7oR4AJX/JYYcOgj4p0FAM5LxnlFZmtEuojYiOyc9N+wmyD1neRvM49nr17ZaWMD9pWa4MHWNKxAmMWLeBWWgq8GUsx5LuFB7NZf+s8GQa7HBJdtAXo/1RTQE4w5akyTCIMS2uut8AXXeI4qxeuc8qJ1G5CvqGMI2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev6p1RULBr8hJZaw8HlYO4WmszUtHZ131cla4tKfV3w=;
 b=AesXsTStTfaTI06McPQ9M5VQ7xUMvsKQpR67uwEyXRY2PlH9ZnEAZvOu8GLheA4s1kC/dAKNuF0kbLWLgxZHOAMtFn1x9Hsm10Rz/cktnIfmYGpspvc1khSg+kY51FdzOexv4EyIDa4aOkP1H4vBSNQmnt7N5wbzZtkAylEt5lVNQl3ASia6F5izOt6oW9iG/b7UIe7dwsBp7lpn6TnXVlXNFAUDXWfbR5yK9yKUJKGE/qOLCHPuEdS7ZbDlF6VLn2SQKVhwBj3F8ujRAcgVMqbaDeAjcI6R32l8YMPq6I62NVAY8ZxHSlXjWGny+BNAOIvURXmxkNNd1OUtbqf5Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYZPR06MB5640.apcprd06.prod.outlook.com (2603:1096:400:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 03:06:24 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 03:06:24 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: bo.wu@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v4] f2fs:Add write priority option based on zone UFS
Date: Wed, 10 Jul 2024 11:06:08 +0800
Message-Id: <20240710030608.28496-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702062952.28859-1-liaoyuanhong@vivo.com>
References: <20240702062952.28859-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::28) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYZPR06MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3a8588-1a67-4d82-84dc-08dca08d4844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?siKAoQsiaXwOguRQHkdbt76de3hFtT/kG5etOCwl9G5lLB0vbNnFuDxjAqEq?=
 =?us-ascii?Q?WyQiT7a6q2mxBijyGcK0DAqZwGYKti+QpxWPDwPLExVvQT820yxP1/PSwlEm?=
 =?us-ascii?Q?fGG/m5SFmKrclry+1ZyjZLjbI4uUACCHqarH3snqKXO8Wilpssv7XeGHuOKD?=
 =?us-ascii?Q?mn5AgqXM53N7bNZU9RVDdqE57J+EEx2DIhZr/lPwkP9jVVfzWnypgOcjzx9P?=
 =?us-ascii?Q?3v8/pT6Nf5a+UreTixdsBHagdZhPwwBkXde70dlxCdYO2X1V9n7Vqs5WxVkw?=
 =?us-ascii?Q?ghsk0UikB4pO3fU7Ug3Rf3Q9Sj0BA6AuCGVAw17bQkFUOtK97j8COD8NBOcx?=
 =?us-ascii?Q?o88XUGNzfH7jRPviQpQgoPOuiQeZs3YRNYEGHV3X4r4gWnxBgTv7qX4EJuM1?=
 =?us-ascii?Q?t3qMn3H+J0nCLQ6kDKDcnwVakZIh3ypwQHYDN31jokBJm8v9Cy5vtuLJeT66?=
 =?us-ascii?Q?8tOAwcrEIxYCfMbZJhQJhkiLy4s+/kcttzYcJfA/siDRlW9jgA9QuHryZBYa?=
 =?us-ascii?Q?EpFs41HnGvPKa9I7JYYQQE+lO81hYDa4zFB5Z4D2+NK+zliTLxA2gIXc5WqT?=
 =?us-ascii?Q?wUfyH0+atOzq6otNeTetbSO+h6h2lUcLBhAj36elqN96K90Yq5kElAKcN/p9?=
 =?us-ascii?Q?1BTy5nkrANwktmY41r2imuPT9aGRNaozTj5hbwgeD/eZqW8NhiakGZRwoniw?=
 =?us-ascii?Q?UgdVk9MJz2FBqxf2br2elRZ417XiwuNM7j8wnM/wVLFIESLBGJGTer+EI0im?=
 =?us-ascii?Q?d6lJstanDvMhFE3OK1OORgLLU2CwReSP4aa19xIdv0kZ5/rE5YdVP4PW7CFl?=
 =?us-ascii?Q?WvAz/AthweGFZ2VmKBoWEG/L2L+dvy+7QH0YMyACAC8xTRDf/aEZA0+iH3qm?=
 =?us-ascii?Q?RbMAqmXLVe1lVNenJxdQcbmMFTL++TX6zAfNoSSAftbAnrR9N8Kpq2AHsuxP?=
 =?us-ascii?Q?AEhR0zqmv4wcW4CgqMLQ3F19iIzC3xhInNuv/UA7F8GN4R1UDVObbWADAwab?=
 =?us-ascii?Q?NWz9fAj4X0WoaLI4rLQShJeDMGewjNVqooZRShbIDWobSa6S65lktLlBFkE8?=
 =?us-ascii?Q?14sf6b4KtvrMB/Qb8GZc7VrYouWskcNOpFYP3dmT2TA/AOVcm0d7i2HCbjAv?=
 =?us-ascii?Q?wpH0/Ele1svAX+rM8BRAEEwuOHbn+oxnJ+TIVUpG4gSqBisGaXC/JqPuXD+M?=
 =?us-ascii?Q?iqPoBOUOPIwyFZsLtdqF+1UjoXqHIlEvKdeu87jOP9HMMDPIXBDkMu15Muzn?=
 =?us-ascii?Q?vHml6LDRMYPcWlIIRxxZRAEhXO2WnEhxngYxSJ/RovlYXBR+o1UVE3GkO6tv?=
 =?us-ascii?Q?b3h7BCOi61xKiTOOCSZ8KmCjNPfiJ1A5P3TfG+oljPo3yTbDn6WKTo2DZRYh?=
 =?us-ascii?Q?5/zfZkkBmhx7aqQQL/cpdUeZej8rT7gXf9WSBMEiAA5pVNoixw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Dfa91qK8fiume3v1zTvqmmzEEEScTbwFYE8Z6DIQetoF+VC7EHytN9VMJek?=
 =?us-ascii?Q?Gyy4aByg8B7gq220FbgZ5ru7QK/WciNf/3Pu4WS3SKDyjUs+JYDWcqJHOwM8?=
 =?us-ascii?Q?rpZaZG/hXzzMTgckyyWTGRYfd9b9Kjbkkf0Fd+VDnK3QE3Q+wRNRg2rbA30T?=
 =?us-ascii?Q?mLLZ/A1F8Vkhg0j5sWC3+crgALvRtkiYgg8MBDeWiIT4gVwQHuaowMqer8ei?=
 =?us-ascii?Q?G5Yiq9P4ka/v3MShE9c9NKvdInfLn4U9YeO4RAXb5J7eXoe1txALr0zpNqZu?=
 =?us-ascii?Q?NHCGXtxMOPmo6eZKN37tFCB5uaf3M03lNxLvIXyB6Q5ZgKS4OgVgTmsUaL2z?=
 =?us-ascii?Q?gdpo1ifmTvQLPmCTQr4KLAJaaAxdTu/f17iRPF4mB+GR+jycyEQTDLL6WyOT?=
 =?us-ascii?Q?cPPWWk6yeS4wYuYr84JDAk73FDNUdWq9cNILbgyECUixEmwo7OxUiHzKewZx?=
 =?us-ascii?Q?ZU5PLZN+myw9dpWvmzIV8KrN7K4kxwY3+AWntmbtR1HUgaakjeQCRZaXFHKX?=
 =?us-ascii?Q?huWB9CRtaZaZSKcDPF4T9VvzI4RR7F3RZrg5CjR9UWbgB4RvKTNlzCjFsZay?=
 =?us-ascii?Q?VbS7UVeUCILB5LrNI8FMca62d6cLvVGAfctlLx62LLYEChRBjJUpWc+g6HwR?=
 =?us-ascii?Q?lUOQ1pfbt6uRwd2WTAHNExCLCmp5Pu8cbirFFIUh9I1xSb+PQbQriqDudKQP?=
 =?us-ascii?Q?zPjJufmWQacho8yLerr11LgC+497B58LPjMsabaOIlS26HwUe7SaUgZ03FNb?=
 =?us-ascii?Q?mFIHtKwN+RmH85h/boew9x5GjI8/z4IcOxXXsWUOZK823gcWv9PrdPcop2cg?=
 =?us-ascii?Q?H3N0+P+A10Jb+mSkxvQEmxq8+fR+xhA/O0iLJ5l1bG4rB8Fe8DdiS6mHRZap?=
 =?us-ascii?Q?CSHiPxLxSfoHWjXuS3taMXAAZ1UBBEeJkZWer/JB4QBW4fHvlyvERyTHLYjJ?=
 =?us-ascii?Q?4+N1+p5TfAcrAl2u1V5mLf4tNbN8GA6wOw+cBN0F/9DaofxzuQtkI5mBSQN2?=
 =?us-ascii?Q?0VHS+dIQH6cjLID7lnrCMGqP/Bj/V47jVOx1BfFV9Lq+xjgX9ts4kZ55uPxa?=
 =?us-ascii?Q?yCjAVtN/EG0D3QgdO22BXDuoqQbDxxYlzJNf1buEpucaejAkhLR6WD6nfEQy?=
 =?us-ascii?Q?1cRmfnPXWFwYF7wpqWJd0jntwchxIvcIxqkfdC7741LJ7VrKH87og3zy3wby?=
 =?us-ascii?Q?iSRmmZTKtpFbW22N3XZZQ/VfskOTSQI1NCldtwhQc3wUHRPMP5yKa006Q5i0?=
 =?us-ascii?Q?HFbxxAGD4oxZxMl8nkQlTgRGeyTCl9tTO6U1KkLvsqrY8GMHfgrs9YgbRvoj?=
 =?us-ascii?Q?dEhHMzNd5JaHfTDM2TMxTX6yd8VjDc22P1taQC00TB2McZ/BYqRhzqi7urcQ?=
 =?us-ascii?Q?gE1SofHCYI35Go6XEVa8vjNmr1e9VxJrFRHDU/XQujCQ+sGXMNzwoI5gs2TK?=
 =?us-ascii?Q?4a7H+pFZt4Pix8V7sib7xkyb1mJFJXh8r/h21lqExosusT+MJN1uVaABTdqv?=
 =?us-ascii?Q?rmU8F/GVK/DOh1D2Uv3cdKNk6rK7y4XfcCnXKDkRpjsNmpg3HaPEd6aRv4+a?=
 =?us-ascii?Q?lkN50JmEqyn9ujiYjFcbJg85x2oIyd6bqZlLrnXX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3a8588-1a67-4d82-84dc-08dca08d4844
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 03:06:24.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZJTCuF+CCBwALuEdfemJqoLO04JHEtjVDvIQNrZcb0jl6wbbwDAGzQ6i6k//ivZaDy4OMdLRzvsdchnAklgyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5640

Currently, we are using a mix of traditional UFS and zone UFS to support 
some functionalities that cannot be achieved on zone UFS alone. However, 
there are some issues with this approach. There exists a significant 
performance difference between traditional UFS and zone UFS. Under normal 
usage, we prioritize writes to zone UFS. However, in critical conditions 
(such as when the entire UFS is almost full), we cannot determine whether 
data will be written to traditional UFS or zone UFS. This can lead to 
significant performance fluctuations, which is not conducive to 
development and testing. To address this, we have added an option 
zlu_io_enable under sys with the following three modes:
1) zlu_io_enable == 0:Normal mode, prioritize writing to zone UFS;
2) zlu_io_enable == 1:Zone UFS only mode, only allow writing to zone UFS;
3) zlu_io_enable == 2:Traditional UFS priority mode, prioritize writing to 
traditional UFS.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
v4:
	-Change some constant's name.
---
v3:
	-Delete excess comments,
	-Use enum instead of define,
	-Modify some judgment criteria to make them more reasonable.
---
v2:
	-Change name to blkzone_alloc_policy,
	-Update manual of f2fs sysfs entry,
	-Use macro instead of magic number,
	-Initialize it w/ default policy in f2fs_scan_devices,
	-Add validation check,
	-Merged the ifdef PROFIG-BLK-DEV_ZONED area.
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++++++++++++++
 fs/f2fs/f2fs.h                          |  8 ++++++++
 fs/f2fs/segment.c                       | 25 ++++++++++++++++++++++++-
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 11 +++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index cad6c3dc1f9c..3500920ab7ce 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -763,3 +763,17 @@ Date:		November 2023
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It controls to enable/disable IO aware feature for background discard.
 		By default, the value is 1 which indicates IO aware is on.
+
+What:		/sys/fs/f2fs/<disk>/blkzone_alloc_policy
+Date:		July 2024
+Contact:	"Yuanhong Liao" <liaoyuanhong@vivo.com>
+Description:	The zone UFS we are currently using consists of two parts:
+		conventional zones and sequential zones. It can be used to control which part
+		to prioritize for writes, with a default value of 0.
+
+		========================  =========================================
+		value					  description
+		blkzone_alloc_policy = 0  Prioritize writing to sequential zones
+		blkzone_alloc_policy = 1  Only allow writing to sequential zones
+		blkzone_alloc_policy = 2  Prioritize writing to conventional zones
+		========================  =========================================
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7ee6c5e371e..adefd19810ff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -134,6 +134,12 @@ typedef u32 nid_t;
 
 #define COMPRESS_EXT_NUM		16
 
+enum blkzone_allocation_policy {
+	BLKZONE_ALLOC_PRIOR_SEQ;	/* Prioritize writing to sequential zones */
+	BLKZONE_ALLOC_ONLY_SEQ;		/* Only allow writing to sequential zones */
+	BLKZONE_ALLOC_PRIOR_CONV;	/* Prioritize writing to conventional zones */
+};
+
 /*
  * An implementation of an rwsem that is explicitly unfair to readers. This
  * prevents priority inversion when a low-priority reader acquires the read lock
@@ -1555,6 +1561,8 @@ struct f2fs_sb_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
 	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
+	/* For adjust the priority writing position of data in zone UFS */
+	unsigned int blkzone_alloc_policy;
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4db1add43e36..026b61602113 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2686,17 +2686,40 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 			goto got_it;
 	}
 
+#ifdef CONFIG_BLK_DEV_ZONED
 	/*
 	 * If we format f2fs on zoned storage, let's try to get pinned sections
 	 * from beginning of the storage, which should be a conventional one.
 	 */
 	if (f2fs_sb_has_blkzoned(sbi)) {
-		segno = pinning ? 0 : max(first_zoned_segno(sbi), *newseg);
+		/* Prioritize writing to conventional zones */
+		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
+			segno = 0;
+		else
+			segno = max(first_zoned_segno(sbi), *newseg);
 		hint = GET_SEC_FROM_SEG(sbi, segno);
 	}
+#endif
 
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
+		/* Write only to sequential zones */
+		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
+			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
+			secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
+		} else
+			secno = find_first_zero_bit(free_i->free_secmap,
+								MAIN_SECS(sbi));
+		if (secno >= MAIN_SECS(sbi)) {
+			ret = -ENOSPC;
+			goto out_unlock;
+		}
+	}
+#endif
+
 	if (secno >= MAIN_SECS(sbi)) {
 		secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4a1bc8f40f9a..95ae6de77939 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4229,6 +4229,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	sbi->aligned_blksize = true;
 #ifdef CONFIG_BLK_DEV_ZONED
 	sbi->max_open_zones = UINT_MAX;
+	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
 #endif
 
 	for (i = 0; i < max_devices; i++) {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fee7ee45ceaa..63ff2d1647eb 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -627,6 +627,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	}
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (!strcmp(a->attr.name, "blkzone_alloc_policy")) {
+		if (t < BLKZONE_ALLOC_PRIOR_SEQ || t > BLKZONE_ALLOC_PRIOR_CONV)
+			return -EINVAL;
+		sbi->blkzone_alloc_policy = t;
+		return count;
+	}
+#endif
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (!strcmp(a->attr.name, "compr_written_block") ||
 		!strcmp(a->attr.name, "compr_saved_block")) {
@@ -1033,6 +1042,7 @@ F2FS_SBI_GENERAL_RW_ATTR(warm_data_age_threshold);
 F2FS_SBI_GENERAL_RW_ATTR(last_age_weight);
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
+F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
 #endif
 
 /* STAT_INFO ATTR */
@@ -1187,6 +1197,7 @@ static struct attribute *f2fs_attrs[] = {
 #endif
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(unusable_blocks_per_sec),
+	ATTR_LIST(blkzone_alloc_policy),
 #endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compr_written_block),
-- 
2.25.1


