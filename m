Return-Path: <linux-kernel+bounces-175555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AAD8C2170
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBCEB21A99
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FC8165FD2;
	Fri, 10 May 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b="UgT0Yh4m"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2082.outbound.protection.outlook.com [40.107.113.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B53165FAF;
	Fri, 10 May 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335069; cv=fail; b=l3QeYujWcOdzpAzRqrF2pZaya7J26soNTO99eRsy8F0MNVJCKOWCyheX8Bq0+1ww616CiZCiNwCKUQO69DdCmXT1wxj9KfWijsQD/oqgjnmwzEvErsuKFkFt1h/Ac4ojw5NIHZ1athP930kj5qe3cT8MMnejZ2VEjQ7GWkeHT3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335069; c=relaxed/simple;
	bh=Ko9QP9iqx/pnT317GHmcgZuTAx8WrJScAWUgp7mfUIc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EIolZUk/tRuvnEqhiMaQ1wvXiDgWk4iXPSKxan7Njd145S+c4vq1NMjfoFh8nE9Mi2Wpv+hnOdm7mZqCsL1TMOLiLmnMjC6AK+3m3ZRzVEIdlS4Kx2JbAgRzjvIMw+UU6N1rv6mMZ6KH20U6jwgNH2FEyaPF5ebe4wp0plj9vo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com; spf=pass smtp.mailfrom=alpsalpine.com; dkim=pass (2048-bit key) header.d=alpsalpine.com header.i=@alpsalpine.com header.b=UgT0Yh4m; arc=fail smtp.client-ip=40.107.113.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alpsalpine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpsalpine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLRfsJebLinvkQehD+Z9RaRwfosEbFImqihE2DUx0XVjobkYVrjRm7rvHPKqAAQQba+DFtZxV9xISGYyI9WaXItqBzGkeMH7g26EklBA2+oazxFUM8dkYfz2DMlO94cje+zWI3Yy8Err8LwEzgXPITJoDh4HZV5E5HgPuVOWiM/xSGAEcBPnu1aqo+iF2Tmd/XKzmWx3MT+lNe4y/rqvNBxWz1ILe/C7HcIYndLSeMMqJ6rFtppfNM1upqVddbERuvtzMdk6CMWM4lJoT/CLUGANM3FUHY4ex14TG7LD42GEuqFyfGAaUsC/DOf380rjAwalYzx7ongogXFoSovJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA0lmFbpHL0BE7fBEe2T5vqjkMG3zvIjhCsCVlZGrgY=;
 b=jgsfM+ZpmqMHMLwwgDAEzhoSmmVkXwpEQFfWdQ7rDUsfC4jIS++y8RHzpSPZ1W0+i/zUkIoH6A9oMSJ9w1hjMvbfwFx6KyDNIqKHqLec4fPXxppMdy7ewviwhp/qtkzuhiWSdE+a7xJylCSTFF1Ept74cn/uug0lj+aZS31VFdww0+hvRDyebFwKd+7IB+39D6Vp42AJE4E9LRmqUwB1n0Um1qlqJDmC8uZMw1H2KmjroHtPdZBU+GQaR6MEVhfFCebXh/5BmdlXfsdGHDWlEaMDgj0EMPEXG5Np0DPvSrP+5+kJ5j+oJdYSA7RPElr/EprqMl1QWoFsI2kCmmXvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=alpsalpine.com; dmarc=pass action=none
 header.from=alpsalpine.com; dkim=pass header.d=alpsalpine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpsalpine.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA0lmFbpHL0BE7fBEe2T5vqjkMG3zvIjhCsCVlZGrgY=;
 b=UgT0Yh4mW2A9pT0uFC1BDYJFE82SRvz7gBne+g2qwEpoEavMGQx2V9R4Sudf5s/xd5OSOeQnOTIcyw6KL3mo4WfprqNwx008dPjLX7a/HU5o2HHy0yoRVd0FR0O6mnnA4kH67pNt3NRaAUNfGIsvj1xIfjRpxacqnvgqkVz7JpBoWAU85PvSTD83vq/l4BqV4p8mxDhTfxBEjm4bzd1zREpC86DLaEN1mXCCQzzVSNkA0BRZnbSCibV3n2UD7yk6Rr6QK+Dcb1XNQhXHSDg2/k8xB+vqSa0BsdLT1lSDDSsmF4A5IE4iXZfJ6Cy5wd/nHVs+qWYPBr7sC/8bCQNeZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=alpsalpine.com;
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14) by TYCPR01MB10102.jpnprd01.prod.outlook.com
 (2603:1096:400:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 09:57:42 +0000
Received: from TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::fe5b:1283:68a6:dacc]) by TYVPR01MB10781.jpnprd01.prod.outlook.com
 ([fe80::fe5b:1283:68a6:dacc%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 09:57:42 +0000
From: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
Subject: [PATCH v6] usb-storage: Optimize scan delay more precisely
Date: Fri, 10 May 2024 19:03:41 +0900
Message-Id: <20240510100341.51999-1-Norihiko.Hama@alpsalpine.com>
X-Mailer: git-send-email 2.17.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: OSAPR01CA0283.jpnprd01.prod.outlook.com
 (2603:1096:604:2b::31) To TYVPR01MB10781.jpnprd01.prod.outlook.com
 (2603:1096:400:2ae::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYVPR01MB10781:EE_|TYCPR01MB10102:EE_
X-MS-Office365-Filtering-Correlation-Id: 877ba6e9-fe65-4e5a-d836-08dc70d7a276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zT4idOO7cm4isfryzPIqcc4u3UsZr/Ql+rYL/FuIx4Ql6prnLxHBEl/TqINJ?=
 =?us-ascii?Q?ne42rwB7isOvqRqKC2KMjJ66WoNjjgEEu+vBOCSXYCr+QubsTnaUlrG6TCGl?=
 =?us-ascii?Q?nIcpoieZ1G/tHkzvSBICBUomKV6jCn35EmMzWXnD51jKCM2O2+dqtbCQqcv4?=
 =?us-ascii?Q?mHoiDYoicS+SN+GKfFzWSDkv0H9DlqICfuNPRqR6x/fVLrf8CF2aoBffsm1H?=
 =?us-ascii?Q?ByA5WfV+2AP0RfiooFUw223nesgCbU8YxUAruSa6rzRrWfdX3b2v5KAq2LaD?=
 =?us-ascii?Q?o1ImdFMrLu6JdSIdnKAleEm2OmfkJPJu0iJ4yIxjgykvcgWwKrzLrzbvLsbN?=
 =?us-ascii?Q?KZUu0Kt11NMbQd9Br3bbvOUDAzpwumZx2Na+GJ8bApNYQZVphG//4dYt13WT?=
 =?us-ascii?Q?HeJU+dTZmVRQ/ERIuXJIKz/JCVyXu4OA/XXxEHHo3qUD5TnwsHP0uv5BVf08?=
 =?us-ascii?Q?ydRaJhfNLDVNF309qPMZmMUb7oDMkGWp9Q6IpcYUjmk73reHKRiZXCQ3OgdT?=
 =?us-ascii?Q?mv9UXSJh46L6zvYxSzpl70x5W3H7p2SZ3El6BlYbGlEt6o2P3lJuV2G2c0Nw?=
 =?us-ascii?Q?JG3ICX7zRuXPQOurQUMzvodg6kSAfxPeypTZojq/fMvp9QDsYfZSWwZyRk7O?=
 =?us-ascii?Q?Noq0nTRYwzuFKN8vaR9eVI8c6pj7+gQESpBtxJNEL9XczDVqQbIQhuFV/iCi?=
 =?us-ascii?Q?aQlzqIrpdcCs8OBlUKruZUkaYImCRQ+rTRR27tVZSLE/ZUVC3XwrA1hHuCJc?=
 =?us-ascii?Q?eGuPfqlQxUMHAK6G7yUf5txKhF3ov1aOmg4udXvryNokJrJ65k8L+sUb8kmf?=
 =?us-ascii?Q?BAWim1UtUyrEgHLDgun3UxYSSGKa5e/Nx56PpO0wfI3ZbzR9oVSOXLAERsgJ?=
 =?us-ascii?Q?aWM7eKTuqml2TvqSWHMC5esfOsmKVgT6UjyaHBWMqGEPZkrCXzA7SHV3K8+b?=
 =?us-ascii?Q?VO+VZckY20E58fGVVaG/hWH9eV5o0CiqdftxUrY0rpxyUgQdXmu3bMr30ow4?=
 =?us-ascii?Q?6tQxetW8y1wX/4/UxqYBMuAYoPyc9WzMOLAk40TY8NR09V5rS5iNnr/jGXAM?=
 =?us-ascii?Q?b/xeDTD4tUg0BI8idGMD7MAR63ZfX6uv63PZYSuPs8ETD8zooqMTeXpHAd4x?=
 =?us-ascii?Q?81LBvlRi42QFGCukVc65lwvqAXg9UYlHDxa6iDEieuaaczsHoIkeFuxQxExL?=
 =?us-ascii?Q?WvQgOj4k6FhNES2Sri0UwtAXrgyQqdVWWP7ArGxYAlCuRQsVtt9LSONCOnvl?=
 =?us-ascii?Q?2TUypkgsgqG0zwr97GY5vA9SHPuUKk1965bkkm27A7UeWz1cZu7EfMZIZv+g?=
 =?us-ascii?Q?nNhBHjQR0zdpTYbrsmBEVEVwS5GWeKz+RmwgPdGPwK/9dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB10781.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f6BOXJWOOl5a6gvbR07Xfhq9OVstumznOT14rrK3isyWa5QcroJKAe20yI0x?=
 =?us-ascii?Q?mbMKF4+QFVzAbE6/vAQYLtENkfIwo/DEEpq2aIhBc2a0VY37XZHdpPQ+jwGN?=
 =?us-ascii?Q?hoogmjzdLHvuHwHXzlItp9MXvVekxa55dmt9IJFT9gq8xDCew54B/0yl150t?=
 =?us-ascii?Q?B8PI26r3Rc5MZx48TEHp+v3fXH12uk+h9ftr9jTrH1AI+TNi+Ge3oGlksqtU?=
 =?us-ascii?Q?Y8S5gT0W66HoY0gnFLwM4gS7PeBFHt8LzxD5Dme1hMO7FuWWS9HowjvEK+JJ?=
 =?us-ascii?Q?OhIlMbabUyt56qJiJT3SsH4ntSyAMS4Ipxe6PgOrJuHHSYbdvSDts2PHLQ6J?=
 =?us-ascii?Q?PmBSZCZy4ei2PoB5zLxYTzHu8qKfuPC/CxQJmqSea1hH3kteBLTElT8B2CEx?=
 =?us-ascii?Q?NJ2rqe3rR64nI87eiyMfqiLV44R5dVtd4YKLgp+5a8RIt6wuvu1+s7u7gVTo?=
 =?us-ascii?Q?TeQFhrthHNxG7WD3mfWEqUkkUDfL7b7VhgzWRD1DSs2+GdR1hRFxAvn2af7N?=
 =?us-ascii?Q?gnVBzYNBsHTYRwj2Mh9NrAsR3Z6yaC2QAwGFd9Qj4UpeHuwCTbYOTY0aE9nh?=
 =?us-ascii?Q?3MREo9Y5LFt9PYkeYi6OM7TCpR6PlW3TUH6apVs8oJXKbFaXhCG0eM96QhwQ?=
 =?us-ascii?Q?EXXGovEMFOwwUgZo9HCqhe5NbM34ij4dp1IQeNTktnS65k9Jn87LC2m2G+Ov?=
 =?us-ascii?Q?2RjZzYX+P01/sj3XGqF65/VMMJUDhssEwMsMBjBQSkf2j27g95bhA5tJ29F6?=
 =?us-ascii?Q?H//JjRXUsB0nKlizEa1teKEjborNBtu8rUkH12ZgI9945wxJ5QJfuiK3KIZu?=
 =?us-ascii?Q?mZBrOQY5sXGopbYNPYQJ/GCvCkKDxHHjQoLGwj9olur2qkjkmrDHVWh/Sn7A?=
 =?us-ascii?Q?wX6k7bit9mu05y+XZr/wW0CkMP72uQd5GNCZ+k+N2AsF89q5uJ3tcbDNTVaF?=
 =?us-ascii?Q?m/1juLxsjxMboIgeL56sQSl8jbAliK5mCqxn3lu/Q6kGgalCWldu4eDa5T9u?=
 =?us-ascii?Q?VT0eJkjTOmWouXLD/ti7E2l/U0hKlq2tOfSk5YELp5ftvMhHtnCMcx++LCdO?=
 =?us-ascii?Q?JmGUMQUSfEAHSbs3HyvDQ8n/R7wEt9Qpi08djuDwKH1eLHQgjKFWyoAQJZhc?=
 =?us-ascii?Q?SDxdnADUiqcNWfeLcXfJ3yhZh+7FqAknvWKl2Qhwv1iQTcQZesURfKLv1ufJ?=
 =?us-ascii?Q?5gXmLxUJNZAsznZcsXkvXE9ju73ZdzvNwFHYA+e9Q7sD7YYap00kUXg1dD4K?=
 =?us-ascii?Q?K6JK39kh9O1valFs4eXjwQ/Uomfqp+3KgbgnTnWbSzsQcgyOUDF5vKSiq7D4?=
 =?us-ascii?Q?oYV9skJpWlg/vol0dhm025vdGWTLThL126gXvDeL0zTmPtbNeolM96XoqwO7?=
 =?us-ascii?Q?TWD0UpUtd2/mhn3Yrv0VP9id3G8Xeuo4BVHCOsChWk0YXsJS0O9mUGHzN1VR?=
 =?us-ascii?Q?vdiiypwQhOBBwVgxw6hCDVYSp889QmiM0DrCb2AUOyawHGYUF1GdlcxCEZjS?=
 =?us-ascii?Q?Kzf1sMDOffMeNAf3XWTTNdlo0xxAioSExJXYDMR0MZCcASRmLq2FAmwHJtZ6?=
 =?us-ascii?Q?xuK8wc2Ncv7GRKVLYpYcSVLdrTbPeOvoPEJ8F5et?=
X-OriginatorOrg: alpsalpine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877ba6e9-fe65-4e5a-d836-08dc70d7a276
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB10781.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 09:57:42.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 57e76998-77bd-4b82-a424-198f46eb2254
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C3tavjztifnYlFZj9wtDF3Us/HiZjmhV8fKSb16t4ybNaQsby/sWiDASXgK96J5KpCQQLLGAjQb2VIWDSGCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10102

Current storage scan delay is reduced by the following old commit.

a4a47bc03fe5 ("Lower USB storage settling delay to something more reasonable")

It means that delay is at least 'one second', or zero with delay_use=0.
'one second' is still long delay especially for embedded system but
when delay_use is set to 0 (no delay), still error observed on some USB drives.

So delay_use should not be set to 0 but 'one second' is quite long.
Especially for embedded system, it's important for end user
how quickly access to USB drive when it's connected.
That's why we have a chance to minimize such a constant long delay.

This patch optimizes scan delay more precisely
to minimize delay time but not to have any problems on USB drives
by extending module parameter 'delay_use' in milliseconds internally.
The parameter 'delay_use' optionally supports in milliseconds
if it ends with 'ms'.
It makes the range of value to 1 / 1000 in internal 32-bit value
but it's still enough to set the delay time.
By default, delay time is 'one second' for backward compatibility.

For example, it seems to be good by changing delay_use=100ms,
that is 100 millisecond delay without issues for most USB pen drives.

Signed-off-by: Norihiko Hama <Norihiko.Hama@alpsalpine.com>
---
V5 -> V6: Change module parameter 'delay_use' to optionally support suffix 'ms'
V4 -> V5: Simplify parser/formatter code and fix documentaion
V3 -> V4: Separate parser functions from module parameter set/get
V2 -> V3: Change to use kstrtouint only for parsing decimal point
V1 -> V2: Extend existing module parameter 'delay_use' to support decimal points

 .../admin-guide/kernel-parameters.txt         |  3 +
 drivers/usb/storage/usb.c                     | 99 ++++++++++++++++++-
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 561d0dd776c7..a56f906b960e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6190,6 +6190,9 @@
 	usb-storage.delay_use=
 			[UMS] The delay in seconds before a new device is
 			scanned for Logical Units (default 1).
+			Optionally the delay in milliseconds if the value has
+			suffix with "ms".
+			Example: delay_use=2567ms
 
 	usb-storage.quirks=
 			[UMS] A list of quirks entries to supplement or
diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..bce146152151 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -67,9 +67,100 @@ MODULE_AUTHOR("Matthew Dharm <mdharm-usb@one-eyed-alien.net>");
 MODULE_DESCRIPTION("USB Mass Storage driver for Linux");
 MODULE_LICENSE("GPL");
 
-static unsigned int delay_use = 1;
-module_param(delay_use, uint, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(delay_use, "seconds to delay before using a new device");
+static unsigned int delay_use = 1 * MSEC_PER_SEC;
+
+/**
+ * parse_delay_str - parse an unsigned decimal integer delay
+ * @str: String to parse.
+ * @ndecimals: Number of decimal to scale up.
+ * @val: Where to store the parsed value.
+ *
+ * Parse an unsigned decimal value in @str, optionally end with @suffix.
+ * Stores the parsed value in @val just as it is if @str ends with @suffix.
+ * Otherwise store the value scale up by 10^(@ndecimal).
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int parse_delay_str(const char *str, int ndecimals, const char *suffix,
+			unsigned int *val)
+{
+	int n, n2, l;
+	char buf[16];
+
+	l = strlen(suffix);
+	n = strlen(str);
+	if (n > 0 && str[n - 1] == '\n')
+		--n;
+	if (n >= l && !strncmp(&str[n - l], suffix, l)) {
+		n -= l;
+		n2 = 0;
+	} else
+		n2 = ndecimals;
+
+	if (n + n2 > sizeof(buf) - 1)
+		return -EINVAL;
+
+	memcpy(buf, str, n);
+	while (n2-- > 0)
+		buf[n++] = '0';
+	buf[n] = 0;
+
+	return kstrtouint(buf, 10, val);
+}
+
+/**
+ * format_delay_ms - format an integer value into a delay string
+ * @val: The integer value to format, scaled by 10^(@ndecimals).
+ * @ndecimals: Number of decimal to scale down.
+ * @str: Where to store the formatted string.
+ * @size: The size of buffer for @str.
+ *
+ * Format an integer value in @val scale down by 10^(@ndecimals) without @suffix
+ * if @val is divisible by 10^(@ndecimals).
+ * Otherwise format a value in @val just as it is with @suffix
+ *
+ * Returns the number of characters written into @str.
+ */
+static int format_delay_ms(unsigned int val, int ndecimals, const char *suffix,
+			char *str, int size)
+{
+	u64 delay_ms = val;
+	unsigned int rem = do_div(delay_ms, int_pow(10, ndecimals));
+	int ret;
+
+	if (rem)
+		ret = scnprintf(str, size, "%u%s\n", val, suffix);
+	else
+		ret = scnprintf(str, size, "%u\n", (unsigned int)delay_ms);
+	return ret;
+}
+
+static int delay_use_set(const char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms;
+	int ret;
+
+	ret = parse_delay_str(skip_spaces(s), 3, "ms", &delay_ms);
+	if (ret < 0)
+		return ret;
+
+	*((unsigned int *)kp->arg) = delay_ms;
+	return 0;
+}
+
+static int delay_use_get(char *s, const struct kernel_param *kp)
+{
+	unsigned int delay_ms = *((unsigned int *)kp->arg);
+
+	return format_delay_ms(delay_ms, 3, "ms", s, PAGE_SIZE);
+}
+
+static const struct kernel_param_ops delay_use_ops = {
+	.set = delay_use_set,
+	.get = delay_use_get,
+};
+module_param_cb(delay_use, &delay_use_ops, &delay_use, 0644);
+MODULE_PARM_DESC(delay_use, "time to delay before using a new device");
 
 static char quirks[128];
 module_param_string(quirks, quirks, sizeof(quirks), S_IRUGO | S_IWUSR);
@@ -1066,7 +1157,7 @@ int usb_stor_probe2(struct us_data *us)
 	if (delay_use > 0)
 		dev_dbg(dev, "waiting for device to settle before scanning\n");
 	queue_delayed_work(system_freezable_wq, &us->scan_dwork,
-			delay_use * HZ);
+			msecs_to_jiffies(delay_use));
 	return 0;
 
 	/* We come here if there are any problems */
-- 
2.17.1


