Return-Path: <linux-kernel+bounces-366507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08299F693
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C71F22F89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8661F80C8;
	Tue, 15 Oct 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XEDj9uO5"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331E1F80A2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018366; cv=fail; b=FvdprJ/7Qxko8hKZUmP57j/3tKwBizZJ2lishvbfMeHNZ4Iku/n/0FVqv9bOAITsfSoMyixtdTRa0jkPiqOG4RJtyZMPpP5EA4pAXfKA9PJQy5dRgdGa/ub5zc7xZLwsyQR5fWC1uUH/zZpbd1XRotYMid3ekWcsrV6RDKTXqXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018366; c=relaxed/simple;
	bh=lMougKV/184WKxzKLBBhMYxmNoDznExdCLPjwD8ryrE=;
	h=From:To:CC:Subject:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=PuP4kWo2G4K/mnHw1XbvPeZ6fLaGFpitxKFmPh7YnT7OtymfkZp8WJ8x3Cb7t2Eg8g6MPFN0kowNw8pmsdCdgg4rMFGD37eteR3+epcyzk9CD7Rp+Pkv6ujHgkc/stvkCFvp8rajEAHHUvndXm7k2xG4b8bu/hQTavAEGQWtWv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XEDj9uO5; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVQ7tlp9HOVKocps6QQroqh8ffLgjM3K9UVEJn0P5Pv/0u0ayLxmKZhm/MKc2JiGm4GONqXLS6UXDbdpAxM/hJgtM/RZctpXqdsYEHFtOJltmGYRoNRaWlLmWbxOnaCafvVipWGwe3yxWTSVYgLXrF77iRZqJwcFQRYgAYC6iFWotJ0DGI2ufrqlDZBgeTJeWeJR7ObdqJn8w+lNC/4l9d+UCSXXXvUwYZDPVW6VSddUkxjUKUM8mv8mz4PtlR3Mv05CXO9O+GY7YihqgV1VwkDu5LuZmrjCob/vaiER1Gite8fjCiqiNmJIEnc2faZx96DA0hyu5KgptYCkRkoJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTL2LBDbL0qc5ThRNA3ur1lSmI82842LeIXvRQ5M0fA=;
 b=kX9eQySELmIHF9tMqvw8xWc4h+UrjPkegcAOxktXnkRp9p/qb6Om/khycOCUw0uot24iivrnyJ3weknm4bCQWvzSUZz4Qvvc/qLVRPQXJHc5pI/RUNKDEuEn//pNmTDnVeeaM5DEmBUoZz0rScZN0n0QkvsWfMsWsQenVCrOMtKvwJjtYU1HO/1BmhjsOvHtgqEVNXODLwvFpZAob6NhDjXA2MEY6772nbPJVQ+fx7ssJeL2f0lN8g3v9HNAYVf0C1r3yA79w7shAGMyGkvb1Ktgr/WoFBk7N8t0HxAxzW0MNT+w70pGTazhvPQs6GOkJ9mAJJwFkQn5KXrr5TInfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTL2LBDbL0qc5ThRNA3ur1lSmI82842LeIXvRQ5M0fA=;
 b=XEDj9uO5oiPked4zSHfi2tN+HVj8HYTba+161XDjpcv0slAhLvpDpWIoowGVgmFGmBEyCsa9hN4SbRVOOJBIKUXyAVZxqsliUSoJdkTQ+pviIVVxjr4kx/Y/NdSyNJAfjoYwUQDfojrckZZcvSBJdaHXzL8lu3ySw4s4VMRfsok=
Received: from AS9PR07CA0044.eurprd07.prod.outlook.com (2603:10a6:20b:46b::30)
 by AS2PR02MB8885.eurprd02.prod.outlook.com (2603:10a6:20b:554::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 18:52:38 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:20b:46b:cafe::29) by AS9PR07CA0044.outlook.office365.com
 (2603:10a6:20b:46b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 18:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Tue, 15 Oct 2024 18:52:38 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 20:52:37 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
In-Reply-To: <5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com> (Zhihao Cheng's
	message of "Sat, 12 Oct 2024 20:30:17 +0800")
Message-ID: <pnd7ca9r0pt.fsf@axis.com>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
	<5173d3d2-4a6b-8b0b-c8f7-8034c9763532@huawei.com>
Date: Tue, 15 Oct 2024 20:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9A:EE_|AS2PR02MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a32d8c-5376-4eab-fef1-08dced4a8a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkRKYWJnYzlMdFVML2FaSTNLbzlrMUZ0U0pJNmo2R3dnaUQ4M0N4K1lod1R5?=
 =?utf-8?B?Q2s0YW9lWjk4OFc4WjJDNFRCR1ZtQTVQWVlML2IxOWNwMUhMbDFhSDdyZHhQ?=
 =?utf-8?B?VzdhWkVHZ3d2dWpERjUxeit5c3JOZXM4L1ZWeXVCanY3VVAxUzlHeUxHRm9a?=
 =?utf-8?B?TXoxZm01bTRGdmRFZlIxM2FQZ0dFblZWL0lSOW9rTnpIL1lUWUxLeE4vcUdq?=
 =?utf-8?B?dFJsNUttODk5azB2QjZoZ1RxMGlWdzlyWWhmYzhnejU1Q1FZRUhvS2VHMkhu?=
 =?utf-8?B?LzRHSWt5S1l2MDZXeVdLN2J1ak9wU3d3TDRTWmlnZnVaUUlHMG43Umsvdkxn?=
 =?utf-8?B?Qll0WlNXY3JsMmVUNlRrNDNrd3o1KzIxcG5QOXd4dGE0Tmc2dFFIQzB0TFc4?=
 =?utf-8?B?VlA4UkZKUFN0a2NFWWRrbDlrL3RtbjJUOTBLeVRpQkYxbzAwU0VNYkg1djd6?=
 =?utf-8?B?UStGQTU0U1VYZVIya3hRR2pTNmtQSGZHR0lid1pWL0JjekY4bERkejh6Sk5O?=
 =?utf-8?B?Y2cvTWJodThwZzc1ZUZjdTNsVWs2OGRlc1o5L0FPMlZKejFneUpWZ1VYVm5v?=
 =?utf-8?B?Mm5LQmt3UFp1WktsVXZocXVHVjg1dnlEOTlBT3RNeUpDMkRGZGJNQy84NkVW?=
 =?utf-8?B?T0VqZ1hFYkNWcUN4OFl2Q2lrMzNZM3Q1YUNrUnZBWHZFNlRBSk9mRjdOSVVZ?=
 =?utf-8?B?bURsRXVHOVVxa1I1aXBxRTE5bDVXNzB5MEJMaDByendrbXFHNC9uR3RyUUho?=
 =?utf-8?B?dWtoVTdCemN2bzBrbUtMMG92OFNLNEFmOVdNSGFnNlkyQkNwblp2d0RZeTRK?=
 =?utf-8?B?TEx1aDVxekhjdlo1K0E0OUgydlhBM09EQ0JnK1ZQOU1ud1BQNUNYTHI1Q0Iv?=
 =?utf-8?B?WVh3bWwwQkQrbDFxc3dCSTBjY3Q3cFZoNjNIaDVCV2V4NVU1MExwVlRHdFNX?=
 =?utf-8?B?R2dEcUVjQXdOWHhsNEVBVHdHZ3dTMEJmSTV2anlnRHd3VEErNjVjZjRVTmMr?=
 =?utf-8?B?NmZSQ1Z5eERPb3pyYnNmay84UW5OdFZlMDZiREpGcW1CaVNYa29KY202Vkoz?=
 =?utf-8?B?NGcwWE0xWGNUTnYwdngzdmhEY0UzNzh4SmRvSDQxSDZ0elR4UjdkRXVMRkRR?=
 =?utf-8?B?Q3ZJUkxqWERhVk9jaUx5bUdnbjg1UkRyeTBZcEpUQ3Vhd24vM2czd2JtRnVT?=
 =?utf-8?B?UGp0WWl6L2E1YUtiTGd5dUUwcHZJd2pqQVdCa1Z0Y1kvRytza0dUVmo2dHU5?=
 =?utf-8?B?alZlb3BGL3pzS3NiY2p5VVpTOEcxNDNNWS9HcmowQzVHRzNMdFpqcUxGM0k3?=
 =?utf-8?B?Qm1oUnBrb0V3YkZic1huai9DWjlZNExFMlRrTUgxMGZiNjBqbGVjcW5PbFV4?=
 =?utf-8?B?cDVFMEthV1ZaNVRCMEd0dGFsbmxidW80VHhEMldMMTMyQnByMGxHVXZESlZP?=
 =?utf-8?B?L2kySlhscWpIclB5MU9NbWE3Y1dObmRMR0tsQUNEeVVHVjhubUJseG9tMVJJ?=
 =?utf-8?B?SGJtdTdKZHVKRDRWMDhZWlpzK1hPWkpCK05pYVZEMm5zQkV0Y2xJQUpBMkQv?=
 =?utf-8?B?czFaUWpxazlhMDhsTTUyL1k0dzlTMlhHNE81OHpidXY1a1JoRDBEV1ZLOC9K?=
 =?utf-8?B?Zm0rR1B4b0lSK3phdVBjT0Y0V2xJcjdVUlR4QUM5VHFUMEF3UzFkM3MyUHQ1?=
 =?utf-8?B?c0txZGFiR2F6TE5HNS9KMVcxSjQzalN5SjBLbzZ0RXNnMzVhOXpTbE53NnhN?=
 =?utf-8?B?b1NLWFJiVHlnQWN0QS9TWWRpdjJDSlhzdUwrWjV2UmVsQ3RkUEFtNWh4VzJI?=
 =?utf-8?B?WjROalJZUjIrSjBQUy96VzQxbm4wMUxPWWVxM2R6bEZJdWhKRGpKWkhzSWFv?=
 =?utf-8?Q?shof5qyipvZFb?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:52:38.2504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a32d8c-5376-4eab-fef1-08dced4a8a45
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB8885

On Sat, Oct 12, 2024 at 20:30 +0800 Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:

> =E5=9C=A8 2024/10/9 22:46, Waqar Hameed =E5=86=99=E9=81=93:
>> Running
>>    rm -f /etc/test-file.bin
>>    dd if=3D/dev/urandom of=3D/etc/test-file.bin bs=3D1M count=3D60 conv=
=3Dfsync
>> in a loop, with `CONFIG_UBIFS_FS_AUTHENTICATION`, KASAN reports:
>>    BUG: KASAN: use-after-free in ubifs_tnc_end_commit+0xa5c/0x1950
>>    Write of size 32 at addr ffffff800a3af86c by task ubifs_bgt0_20/153
>>    Call trace:
>>     dump_backtrace+0x0/0x340
>>     show_stack+0x18/0x24
>>     dump_stack_lvl+0x9c/0xbc
>>     print_address_description.constprop.0+0x74/0x2b0
>>     kasan_report+0x1d8/0x1f0
>>     kasan_check_range+0xf8/0x1a0
>>     memcpy+0x84/0xf4
>>     ubifs_tnc_end_commit+0xa5c/0x1950
>>     do_commit+0x4e0/0x1340
>>     ubifs_bg_thread+0x234/0x2e0
>>     kthread+0x36c/0x410
>>     ret_from_fork+0x10/0x20
>>    Allocated by task 401:
>>     kasan_save_stack+0x38/0x70
>>     __kasan_kmalloc+0x8c/0xd0
>>     __kmalloc+0x34c/0x5bc
>>     tnc_insert+0x140/0x16a4
>>     ubifs_tnc_add+0x370/0x52c
>>     ubifs_jnl_write_data+0x5d8/0x870
>>     do_writepage+0x36c/0x510
>>     ubifs_writepage+0x190/0x4dc
>>     __writepage+0x58/0x154
>>     write_cache_pages+0x394/0x830
>>     do_writepages+0x1f0/0x5b0
>>     filemap_fdatawrite_wbc+0x170/0x25c
>>     file_write_and_wait_range+0x140/0x190
>>     ubifs_fsync+0xe8/0x290
>>     vfs_fsync_range+0xc0/0x1e4
>>     do_fsync+0x40/0x90
>>     __arm64_sys_fsync+0x34/0x50
>>     invoke_syscall.constprop.0+0xa8/0x260
>>     do_el0_svc+0xc8/0x1f0
>>     el0_svc+0x34/0x70
>>     el0t_64_sync_handler+0x108/0x114
>>     el0t_64_sync+0x1a4/0x1a8
>>    Freed by task 403:
>>     kasan_save_stack+0x38/0x70
>>     kasan_set_track+0x28/0x40
>>     kasan_set_free_info+0x28/0x4c
>>     __kasan_slab_free+0xd4/0x13c
>>     kfree+0xc4/0x3a0
>>     tnc_delete+0x3f4/0xe40
>>     ubifs_tnc_remove_range+0x368/0x73c
>>     ubifs_tnc_remove_ino+0x29c/0x2e0
>>     ubifs_jnl_delete_inode+0x150/0x260
>>     ubifs_evict_inode+0x1d4/0x2e4
>>     evict+0x1c8/0x450
>>     iput+0x2a0/0x3c4
>>     do_unlinkat+0x2cc/0x490
>>     __arm64_sys_unlinkat+0x90/0x100
>>     invoke_syscall.constprop.0+0xa8/0x260
>>     do_el0_svc+0xc8/0x1f0
>>     el0_svc+0x34/0x70
>>     el0t_64_sync_handler+0x108/0x114
>>     el0t_64_sync+0x1a4/0x1a8
>> The offending `memcpy` is in `ubifs_copy_hash()`. Fix this by checking
>> if the `znode` is obsolete before accessing the hash (just like we do
>> for `znode->parent`).
>
> Do you mean that the UAF occurs in following path:
> do_commit -> ubifs_tnc_end_commit -> write_index:
> while (1) {
>    ...
>    znode =3D cnext;
>    ...
>    if (znode->cparent)
>      ubifs_copy_hash(c, hash, znode->cparent->zbranch[znode->ciip].hash);=
  //
>      znode->cparent has been freed!
> }

Yes, that's what KASAN reports. It's the `memcpy()` in
`ubifs_copy_hash()` that triggers the slab-use-after-free.

>
> If so, according to the current implementation(lastest linux kernel is v6=
.12), I
> cannot understand that how the znode->cparent is freed before write_index=
()
> finished, it looks impossible.
> All dirty znodes are gathered by function get_znodes_to_commit() which is
> protected by c->tnc_mutex, and the 'cparent' member in all dirty znodes is
> assigned with non-NULL. Then I think the znode memory freeing path
> 'tnc_delete->kfree(znode)' cannot happen, because:
> 1) If a znode is dirtied, all its' ancestor znodes(a path from znode to r=
oot
> znode) must be dirtied, which is guaranteed by UBIFS. See
> dirty_cow_bottom_up/lookup_level0_dirty.
> 2) A dirty znode waiting for commit cannot be freed before write_index()
> finished, which is guaranteed by tnc_delete:
>   if (znode->cnext) {
>     __set_bit(OBSOLETE_ZNODE, &znode->flags);
>     ...
>   } else {
>     kfree(znode);
>   }

I'm with you here. Initially I thought there was some lock missing
(since it is showing signs of a race, e.g. not deterministic). But as
you point out, it is protected with `tnc_mutex`, hence my "RFC" tag on
this patch.

>> Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>> I'm not entirely sure if this is the _correct_ way to fix this. However,
>> testing shows that the problem indeed disappears.
>> My understanding is that the `znode` could concurrently be deleted (with
>> a reference in an unprotected code section without `tnc_mutex`). The
>> assumption is that in this case it would be sufficient to check
>> `ubifs_zn_obsolete(znode)`, like as in the if-statement for
>> `znode->parent` just below.
>
> I'm analyzing tnc-related code these days, however I can't find places th=
at may
> concurrently operate the same znode. And I cannot reproduce the problem w=
ith
> your reproducer:
> while true; do
>   rm -f /UBIFS_MNT/test-file.bin
>   dd if=3D/dev/urandom of=3D/UBIFS_MNT/test-file.bin bs=3D1M count=3D60 c=
onv=3Dfsync
> done

For completeness, here are the _exact_ steps that I have used to
reproduce this on my system with v6.12-rc2 (commit 75b607fab38d "Merge
tag 'sched_ext-for-6.12-rc2-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext"):

```
ubiattach -m 2

keyctl add logon dummy_key: dummy_load @us

ubimkvol /dev/ubi0 -s 80MiB -n 0 -N test-vol
ubiupdatevol /dev/ubi0_0 -t

mount -t ubifs /dev/ubi0_0 /mnt/flash -o auth_hash_name=3Dsha256,auth_key=
=3Ddummy_key:

count=3D0
while true; do
    date
    count=3D$(($count + 1))
    echo count=3D$count

    rm -f /mnt/flash/test-file.bin
    dd if=3D/dev/urandom of=3D/mnt/flash/test-file.bin bs=3D1M count=3D60 c=
onv=3Dfsync

    echo ""
done
```

Note that you need to have `CONFIG_UBIFS_FS_AUTHENTICATION=3Dy` (and
`CONFIG_KASAN=3Dy` obviously) in your `.config` in order to trigger the
offending `memcpy()` in `ubifs_copy_hash()`. Also, it takes a while. For
example, last time it took me 88 iterations of the above loop before it
triggered. So you might need to let it spin for a while.

>
> Can you dig more deeper by adding more debug message, so that we can figu=
re out
> what is really happening.

Certainly! I could try to enable the debug prints from UBIFS, however
they are *a lot*. Moreover, printing that much changes the timing
behavior and might make it harder to trigger the use-after-free. Do you
have any tips on where we should try to focus the debug prints (a
dynamic debug filter).

[...]


