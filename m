Return-Path: <linux-kernel+bounces-405159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE879C4DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A6285294
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AB4207A03;
	Tue, 12 Nov 2024 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Mx7vVr+Y"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011036.outbound.protection.outlook.com [52.101.129.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975BB16CD29
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384979; cv=fail; b=A5UPWpWSPrPl7I4A/zhLvJMss9iU0mTqAxS+I5aa6uZdZ/gcT4p0PcF8H4AZn4b1Ux0N82yeBJMtf3z2iR0OhwcxtD80AmuzserWxemSOhteqjQLAzuATxuyknI8srLY+5KCGXjcmf5asZhGaq/63qR+Wefzw3aXo7w3I4j4wqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384979; c=relaxed/simple;
	bh=ZZlTJ5XlrLI7Q9qThO2g1RxjBUXjqDHXDRW1iMG0sg8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AP6uyj2JRer73FmCO/r3i8ZrbjoPQxJddPrdhNKglaT5DgyIffxu88MbRFrBOmsVHH7QSmKp9/a/aBWRHleqaPZ2mR00tuXA7Em0q2d3XNexUI2eYcxYgUJrAd68pbTI5HAEjCL20uHaD2KMEF5GvI6yGGshKS8GbM3TdksFdwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Mx7vVr+Y; arc=fail smtp.client-ip=52.101.129.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHnwWlRE8cvtwX46jJcbov+RfTkn41PnhfazHiy2QiHPmG9kC1ErrpMSxNWoxNCtTHI+EtqA6FwhvpXbFNE84eXlAj7FCDO2K3AUX/6rhpZBA8J37U5FlTRhszQw5Db7joBqku2jKDjBJEdYTsG+XrxAN4bFa6ENQWct22wZ2LWgB3og+JGwpVdr/ad2S1Iyp2PYw3QhQ8FXoZFww5ysldib26hT5iWkrv/WR4Lsx7h/+JTtALww8NAjqlyO/EGjWY6xlUuc7UoJnI0eY8tyznQxUNBDr5J1+6M+aphpgE43aYh9WmvD0C9CQpIsvghXdg4tA7T+rZQzltT/NL7TZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnFa9iocdHJ4baaTatKyAF4tSa92k4Eib2WDXY4rHxQ=;
 b=EtbShJ+HdpLeWQscyIOmr3QXm1kwCQxCSLepuUAlCg4myEOtNdjyWc024pD+z9KWq9MHrtWS5k4OK566uA5lkmymxOEYu2SfDM1OjMjvNYN2oI6NHq6K6Yro4EXUjVAVdgQ1RB7LOmrFdzjG7q9Nevt0gBcdp8CuBMYRqJl1URiFhu+O3T1MhJXF3EnVMxh3fQVMOiLVJs59YY3FFWSEDD/3DX9W32aMgHtaBdJvtPRYNtEKa9OAwuWLQrS9Ktnuq5Vm/vFxqbLZPG93N9+cwwvBpST7ShCJbbCi188GK9fPy1FzA7Gfp4D97cKxB6TYwR+3DG3ninTHe4BC+Ps9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnFa9iocdHJ4baaTatKyAF4tSa92k4Eib2WDXY4rHxQ=;
 b=Mx7vVr+Y6reJ/7Sxh5AsNWgsQK1OSA65glILNHMhYhKs5gIrywc3c64SrGGCfW8pn9nZ2w1/vApA3XS8P9hRW0ADCbRXec+BYviXIJKSwnGoIUrtj29LzElyYRkasgJ6c/a/btRxUSJy3onkGyM3khrsLZBhX9Xw/IpXnj6c2SW3b9SdCZFwh9WbG8Uxtp001ulTBKXHJUmWHzoLaK4IJcbN7JbsL2FZEgtP271/GTrXMnxyOXQag7D7aQkyKNGgs1HORiMWulc8HQNJ9B8TeDleM0KiGYmUcb59cj+ulYMzlXVukUUYNad5cZGp53IJkNCxujScvx23GTa+2YhKUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TYZPR06MB6261.apcprd06.prod.outlook.com (2603:1096:400:335::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Tue, 12 Nov
 2024 04:16:09 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Tue, 12 Nov 2024
 04:16:09 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH v6] erofs: free pclusters if no cached folio is attached
Date: Mon, 11 Nov 2024 21:32:35 -0700
Message-Id: <20241112043235.546164-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|TYZPR06MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: dcad5ccd-e000-4c7d-0d89-08dd02d0bc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N245gvdT+YGGnj+3itqxgOdj3L/7CkX6/ssN+7DzvLA4YCZCRCvyBoRFSoOU?=
 =?us-ascii?Q?A7O2CY57qsOpB5map+Fcr6OVsyDrKsa9J/UYbCYWYYKgnAVPnVSyDhqPhzPk?=
 =?us-ascii?Q?shRDXOXWVfADiafpCPXfnVSUniCFa8p6KsCuOXB+4NPpv36L3fxhcURkuoJ8?=
 =?us-ascii?Q?9NrYJRaPgK5yuqzC3NLemzLSW7uBO6sVzeNdtD7Z55ulW9h3uMqwEqSkG1Xo?=
 =?us-ascii?Q?JSjZfDhTAfyuJ3ARetAhnkhayABdF2a3YvYzs1HWIliRUGFWgvufW9y6L281?=
 =?us-ascii?Q?G8cuSirkvlvQxgzTXuVnhdP4KI4kpx0+MZ6pYmlfgdydUga5cosc8uk41Kcn?=
 =?us-ascii?Q?uO4Kd/wV7KOW9t66NDcq2axss1NU2ZqrzHnlsz0yruKy6VCiOsN4DuZ1oKoW?=
 =?us-ascii?Q?lTKZCJHnQG1Z3fepvgvhcQRNgDkOd/zxpTyGk9Ms8xWWYX52DnYN2hNyRX5f?=
 =?us-ascii?Q?xdKxBQH3QE1icdY22k5N0UL/nZn2ON+JevEK8UEBJsAPcmPWkrNhoIwk9MPN?=
 =?us-ascii?Q?jiWA/UUScjp5lTSgllmEGLeWhDoUau1One+qVtF0BstLQjk+XVZUEaAKIVgC?=
 =?us-ascii?Q?yEPhUDKP/4/Bm9ckuyV/Ce7saEFDYOGkRf0qaX4Cdj8eTrrQ+/Nu/Jo8SaGo?=
 =?us-ascii?Q?WbiZMCDzfp8yczqlRQIgLzjKjxPzk/B7NhCzyCCQ0X697hucJZ7b7LrWrSVQ?=
 =?us-ascii?Q?E8FeSydPKopGDLvHST2fAPW3/b3Th29C88TfGUdVTrZJAJoPvhs4Dz5DxIuL?=
 =?us-ascii?Q?93CsFph8QTElhDYquprQe8/4tfgow1JDfqyXdfbmbM3YuxbXAZAzJApWzldv?=
 =?us-ascii?Q?T/CyuVpXtmP1FiC+yoJFZvOoxCFNKPZUxhI3U/dy4wOLgM4Qj0dJ6zBBkt+q?=
 =?us-ascii?Q?cbZYCoJwBnBqeazJH6FOLoXKcYdQo8kk1cdv7UwrM/hvQMtrO2rkiAIV09Yv?=
 =?us-ascii?Q?CA0rdniO3nfdzYilWwtDiY/W/FQC9CNXGUuelx3GT4V+nCJtEWo3QQ4y5bfy?=
 =?us-ascii?Q?ppZ7bsMDjVkGnSed4Rd0w8Jkq06HWVWxNynyCfxPxD4llWziHSsufCZZb18u?=
 =?us-ascii?Q?+lcEGS1OsZp4RcvMx8V5UZgxlhXx1gwSFB+jYy1yWfGayHhWNaf3Y3+R9axJ?=
 =?us-ascii?Q?AT9une9cXctagAvdMLS7MQVKgITpKC61a90BQ9wRvQaHAB/eYlRaTvkZTepD?=
 =?us-ascii?Q?N0ap29CQALpR2NK/bulSWgxQBWWjYXQD5HOsFEGK3DKEh7KsouyIRYr/buJ4?=
 =?us-ascii?Q?1ti4WvsulMsObGinCur+3VNqbkUt4lNT6x+7aS6UglpselHQtFHiTvUfIEBq?=
 =?us-ascii?Q?EdZNCV4vcR2wBEXUXuqbW4VG7AB6R3y4pAWUPIh6j9L1df8kxRd/uNWALEFS?=
 =?us-ascii?Q?6/sG3gPxq9suCB5Ctav/ZTZghgkZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DIQFdYYIRhgwMzJB4Vs4lps9YLmLgKClputLuTRnXklh9fQbiyecsHtTTzfa?=
 =?us-ascii?Q?VbG+LQIj0FCHbnu52fzSjVZxnRGKDSEoqM9cS+NpzP3CUFrsPXLfWzNqYN7P?=
 =?us-ascii?Q?x/yb2CPWzD1Xf6+okUboRwgNCiFECS2GdNlN3+Vk2KJl/i9aSs33L7tp9TMf?=
 =?us-ascii?Q?dufJF4trvaE0MZEYJWp2dPUVr7//gpAn0noZ/7OLNPkBPlepF8Sy6nYJ2ZNm?=
 =?us-ascii?Q?vTQhmUvHsYAHGZYVGFz4uNoV/WgLT2WCbaqlN+mSWgYpcFh8SzZFeBaisl1I?=
 =?us-ascii?Q?BII8G2lxX0CDnVFRI+0l6LugGBgDA6zSuA/MOAvsCJo+M1YB2iWzviMCH/Qi?=
 =?us-ascii?Q?U0nMD8Xq6Rv415jYkCFJLtEJLhnLdISYWK5CVbdPsX5RPaqAswrbfS3Rpu/D?=
 =?us-ascii?Q?loDQZTs+h6j6HZCojBFufsia4uB8zQG8QPUEG/tJ0lcgpm4x9DtGqODr67WG?=
 =?us-ascii?Q?uf27V5gKA3LOc+4Q9L8S9vfGC9rrnIrn46VYXpUoJNntun12RvbUmn9cB2+o?=
 =?us-ascii?Q?NkIfNW5FBXLEF+KAQlMehdFl79B+kCC4PtyDakvJaNOtwSUX2zERw6JuOri6?=
 =?us-ascii?Q?/yj9frDNv0ogpvci/hDgstLEn7kZ/FtYkNv18dxWg2vmSH2mdojr6xL1eFXT?=
 =?us-ascii?Q?U3yDFIOuOXOQqgH+hKrvuM4NLN3ZWTfMMe0L7G65ndTfbaUTSUdt8VCNhHI0?=
 =?us-ascii?Q?/ujkNWXs55WKNEe9S7InIrMfBlT2LKjrLJn+fIBFMAk5UM7xDzjxd/MvnIw2?=
 =?us-ascii?Q?B8VPk0Z/WE8sMue080Bs40vFODVhIfN7ZyFWJMU9u5voBrEHB8Ga6Q7ChyWl?=
 =?us-ascii?Q?yL/dYWm86hP/1rZB1UhMr+9eXQ96uoBrv5+YPAHmJOjPtYqrGc8FzqJlh1ua?=
 =?us-ascii?Q?lLCUYc3aakRycixohT2y08WCSDw6kykidzvOYHEeXZAYAgMX+HsbkoftUhkb?=
 =?us-ascii?Q?fPhSF0AlIxhJSv1InRnZQMCmpebtIRSXJU94GM2G2zzGT9VHnvg+fRZvKOy7?=
 =?us-ascii?Q?9wuoMbT/+8is5O8ac6ykVaMUGTEUnQfQbA2F5b9Yl4mfzgB2L/9zsc1SaLAL?=
 =?us-ascii?Q?5Kix1mOA9Hc3jsoX2VZabb+bmTIvHIMJ8H4dqsLNVvFDL1O1Ll6wF3Vh+gkf?=
 =?us-ascii?Q?jr7C6rY+xGhFKjYd1YSrTveo+cc0sHS0RCmwhkpR54+IJZIgaFidYu9GpJeT?=
 =?us-ascii?Q?ayvSyijHLac5aklplGlbnosw1CW+A1Mpr97beqFcbn+MxmJUTuINR8YN5lTv?=
 =?us-ascii?Q?/Aen+2h5A7e5y75/XZ/3kSyHgORTKxmyI29B9nZIhrVTVRo1f/9RrcTfnhB6?=
 =?us-ascii?Q?qbjdXSp+MfiuZ8LlpiCoEv3OYkaIQf8M8Sk7kiFulwbLA1sl8VFVlj8srSf7?=
 =?us-ascii?Q?D0sWiJNzwWbtUcuo67HlNtrupjNaODR4XF6PoOvZTv7wEigB2DCTczIeim3O?=
 =?us-ascii?Q?tlIMf7bEIGynahfizwo6/1DVbHsUVldlymbrzTYw1erg+myYx0oKrFbjz9yq?=
 =?us-ascii?Q?wjYXQsK2pZXXtYaF4y5gexbsFu475r4zuv6K11EHbxuu3ePmYhoTRpMsPpNr?=
 =?us-ascii?Q?RHJQtJGmem0iXLZn4Clrv01hM7qgBXA0DCNcaq+i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcad5ccd-e000-4c7d-0d89-08dd02d0bc64
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 04:16:09.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxaDI5SI/ID+6brTtnyEHXQQwwsjnNfAPuwG65uGwgpID7yXIgT9qhJJsEsh5nWvf78PJf64reI+9nACTkXj/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6261

Once a pcluster is fully decompressed and there are no attached cached
folios, its corresponding `struct z_erofs_pcluster` will be freed. This
will significantly reduce the frequency of calls to erofs_shrink_scan()
and the memory allocated for `struct z_erofs_pcluster`.

The tables below show approximately a 96% reduction in the calls to
erofs_shrink_scan() and in the memory allocated for `struct
z_erofs_pcluster` after applying this patch. The results were obtained
by performing a test to copy a 4.1GB partition on ARM64 Android devices
running the 6.6 kernel with an 8-core CPU and 12GB of memory.

1. The reduction in calls to erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (times) |   11390   |   390    | -96.57% |
+-----------------+-----------+----------+---------+

2. The reduction in memory released by erofs_shrink_scan():
+-----------------+-----------+----------+---------+
|                 | w/o patch | w/ patch |  diff   |
+-----------------+-----------+----------+---------+
| Average (Byte)  | 133612656 | 4434552  | -96.68% |
+-----------------+-----------+----------+---------+

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v5 -> v6:
 - Fix issue: free pclusters when no folio is attached.

v4 -> v5:
 - modify subject to be more formal
 - `--pcl->lockref.count == 0` --> `!--pcl->lockref.count`

v3 -> v4:
 - modify the patch as Gao Xiang suggested in v3.

v2 -> v3:
 - rename erofs_prepare_to_release_pcluster() to __erofs_try_to_release_pcluster()
 - use trylock in z_erofs_put_pcluster() instead of erofs_try_to_release_pcluster()

v1: https://lore.kernel.org/linux-erofs/588351c0-93f9-4a04-a923-15aae8b71d49@linux.alibaba.com/
change since v1:
 - rebase this patch on "sunset z_erofs_workgroup` series
 - remove check on pcl->partial and get rid of `be->try_free`
 - update test results base on 6.6 kernel 
---
 fs/erofs/zdata.c | 57 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6b73a2307460..877bce7709d5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -885,14 +885,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
 			struct z_erofs_pcluster, rcu));
 }
 
-static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 					  struct z_erofs_pcluster *pcl)
 {
-	int free = false;
-
-	spin_lock(&pcl->lockref.lock);
 	if (pcl->lockref.count)
-		goto out;
+		return false;
 
 	/*
 	 * Note that all cached folios should be detached before deleted from
@@ -900,7 +897,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	 * orphan old pcluster when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_folios(sbi, pcl))
-		goto out;
+		return false;
 
 	/*
 	 * It's impossible to fail after the pcluster is freezed, but in order
@@ -909,8 +906,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
 
 	lockref_mark_dead(&pcl->lockref);
-	free = true;
-out:
+	return true;
+}
+
+static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
+					  struct z_erofs_pcluster *pcl)
+{
+	bool free;
+
+	spin_lock(&pcl->lockref.lock);
+	free = __erofs_try_to_release_pcluster(sbi, pcl);
 	spin_unlock(&pcl->lockref.lock);
 	if (free) {
 		atomic_long_dec(&erofs_global_shrink_cnt);
@@ -942,16 +947,25 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
 	return freed;
 }
 
-static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
+static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
+		struct z_erofs_pcluster *pcl, bool try_free)
 {
+	bool free = false;
+
 	if (lockref_put_or_lock(&pcl->lockref))
 		return;
 
 	DBG_BUGON(__lockref_is_dead(&pcl->lockref));
-	if (pcl->lockref.count == 1)
-		atomic_long_inc(&erofs_global_shrink_cnt);
-	--pcl->lockref.count;
+	if (!--pcl->lockref.count) {
+		if (try_free && xa_trylock(&sbi->managed_pslots)) {
+			free = __erofs_try_to_release_pcluster(sbi, pcl);
+			xa_unlock(&sbi->managed_pslots);
+		}
+		atomic_long_add(!free, &erofs_global_shrink_cnt);
+	}
 	spin_unlock(&pcl->lockref.lock);
+	if (free)
+		call_rcu(&pcl->rcu, z_erofs_rcu_callback);
 }
 
 static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
@@ -972,7 +986,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
 	 * any longer if the pcluster isn't hosted by ourselves.
 	 */
 	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
-		z_erofs_put_pcluster(pcl);
+		z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
 
 	fe->pcl = NULL;
 }
@@ -1274,6 +1288,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	int i, j, jtop, err2;
 	struct page *page;
 	bool overlapped;
+	bool try_free = true;
 
 	mutex_lock(&pcl->lock);
 	be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
@@ -1331,9 +1346,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 		/* managed folios are still left in compressed_bvecs[] */
 		for (i = 0; i < pclusterpages; ++i) {
 			page = be->compressed_pages[i];
-			if (!page ||
-			    erofs_folio_is_managed(sbi, page_folio(page)))
+			if (!page)
 				continue;
+			if (erofs_folio_is_managed(sbi, page_folio(page))) {
+				try_free = false;
+				continue;
+			}
 			(void)z_erofs_put_shortlivedpage(be->pagepool, page);
 			WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
 		}
@@ -1379,6 +1397,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	/* pcluster lock MUST be taken before the following line */
 	WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
 	mutex_unlock(&pcl->lock);
+
+	if (z_erofs_is_inline_pcluster(pcl))
+		z_erofs_free_pcluster(pcl);
+	else
+		z_erofs_put_pcluster(sbi, pcl, try_free);
 	return err;
 }
 
@@ -1401,10 +1424,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(be.pcl->next);
 
 		err = z_erofs_decompress_pcluster(&be, err) ?: err;
-		if (z_erofs_is_inline_pcluster(be.pcl))
-			z_erofs_free_pcluster(be.pcl);
-		else
-			z_erofs_put_pcluster(be.pcl);
 	}
 	return err;
 }
-- 
2.34.1


