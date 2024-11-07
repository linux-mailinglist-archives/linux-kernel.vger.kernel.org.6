Return-Path: <linux-kernel+bounces-400758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B44E9C11ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8C0285536
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407B9218D86;
	Thu,  7 Nov 2024 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eNFflRqe"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB8217447
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019116; cv=fail; b=aQPl7CucsT6Ri7431pzcwmQJ6ttVzRqBRnDL+trURvtLiaR/Rc/uZBOUNWDjhGJ97PaKsfcUPQn7zFJu2QguUI76q9yMJAwvxunFyvHqkTKp26PyJZAnRYyGFqnJA+r3eh3ZurtOkenOj0zdAniVK8TDWv0wgPSoS3Oo3aAy7BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019116; c=relaxed/simple;
	bh=hSbBnwT+SYeQokR3vAwARERiY01WwefckgaqJdJT3aI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVudRkAdXmT1nSZNVD0axXMnWHwckssxfBFXxBx+wtq7FUvafJsAgDUF0PjF4sOIl/I8bECuPfEfnp4f888LwpESPYd1uMa3gJ+phbqZ2Ff8AYze3OiOSz0iy0xl7Lf8GVd4RVwd783wEL/rj8oXpbLWH0trkVtrqSUUW8Q9G7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eNFflRqe; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSIE6KX8OpEExud3aoKBhC7hBuX/cQ9jZuqtxpNjTvD6A9Uu99FS/ePF9ze9M0axn6skJMAyFHVtY5XtziqF74HZBkcZk47DJxYBDMxNlCTgDfc0UxEgK9WYUexQJPOKS+4GW/LbSpaQhHMiv5nOMm7n55gEdG2l1jR6gdcaYteQVel/6GfFqhtzMlg/c5j2uukAU7BtL2YMWFX6Jevj/hMFsZfgxwChWH3NaRaiw9XBQXzoKLwgKnzq7lBZyIOx4ye7QO5oKvMcqDKpdo4j8w/IDLXxVHWxi0f7gJwoO8+Weg3EYlR4Q6f2480P3Hdj0WjrPdmjOnBCMESZ9EM9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhlZX/Gcu96IYqYv/B82Y7GNK8x8PONk0wqE7/iRxhc=;
 b=nJnZBFvV4CC1FKcTkfmt1KUiHtIMhLPetBwU2l5/Wsrc9OkBWqP50Ph5v65/vS6XPQwzkgrsCJWHIPU3QtjkAQZSi4MdSkL5BPzqsaoAb9gv9PA+QwYYFPRJzkIwOu65NpsxQLBWMSovzeJrbkhKWOoS1mr1a4QE2KOfbaXIwg1aVWFdEdoAmSsdXpIMcsirgAsTfrVK1L9rSpLp31D7UZM8p5s4mCiIGLxKlEaV5H2UZcnJlDeBnJ/P0A8xsEhysGTIzGKEZFmZOvo/YGimpPRJSUs/nnmc9JRKIw5XT/A+EvPzBurzt+QILOSu40/9zQS2BlVS5VP8jPi8k26YmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=hotmail.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhlZX/Gcu96IYqYv/B82Y7GNK8x8PONk0wqE7/iRxhc=;
 b=eNFflRqeYIsFM3vNGTDVQSVfy8gROLTT4kEHXfh/8PGaL3DX1XZBClAlin2OAoQcjJQzEps5KEkELkFQg2qGzOkJ5vM5I3xMjLDae8p3q85HdZXGHcnAmFey7mI0HVJX2ldURxu930KK9qJNUm7FYr5XBwomJ9GL/OIKRDHQdR8=
Received: from DUZP191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::18)
 by DBBPR02MB10823.eurprd02.prod.outlook.com (2603:10a6:10:537::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 22:38:28 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::ab) by DUZP191CA0040.outlook.office365.com
 (2603:10a6:10:4f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Thu, 7 Nov 2024 22:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 22:38:28 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 23:38:27 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryder Wang <rydercoding@hotmail.com>
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
In-Reply-To: <0f040e0a-c27f-2f29-6d9e-9c7152a18513@huawei.com> (Zhihao Cheng's
	message of "Thu, 7 Nov 2024 16:39:41 +0800")
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
	<0f040e0a-c27f-2f29-6d9e-9c7152a18513@huawei.com>
Date: Thu, 7 Nov 2024 23:38:26 +0100
Message-ID: <pndttci1xgd.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|DBBPR02MB10823:EE_
X-MS-Office365-Filtering-Correlation-Id: e688b9c4-e18f-46e8-dd90-08dcff7ce665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEhUYkt5aDZhdDVjSHFmY3J0dlYwa3JXQ0xOTlZxODQ1azkyN1BTUVNlY1ow?=
 =?utf-8?B?VG1OaFRVbWhvc0luc0NMck11dWVPeHYySmlwQXlZWU9LY1N5RnB3SHFqT3lk?=
 =?utf-8?B?TTNCZ3lseTF5MkVWS0szMjFpL1IwMWxRUkJiU0dLS2g2ZXl1VlprR3VOTlRy?=
 =?utf-8?B?bGlyRzk0d1Q3d1plUE5DOWdMSnVIcHBPYURic3Z1TS9rYWxqUE5iZFNydHJm?=
 =?utf-8?B?L0ZiVHQyOWkxUW44MnRmVmRtQjljVVc1djlwWGY5K2FMdUYrdFZQVnhYcVlr?=
 =?utf-8?B?UzVTS1VoS3JVUHRsdmJTUEdMc1E0MTNDeHNjMVFXTjNwY0NxdVBVTkdBNmN2?=
 =?utf-8?B?bUx0Q3ZVTng0UnNSK2dPRitONURQUytWcmNtU0xMOVZCM1ZMTjBXZkxyQndO?=
 =?utf-8?B?MkFpS2I3OWFEVnh6bUZwL2dvSm5CUFQ2ZzcxZEpTZWVERk85QTFML3o0Qnha?=
 =?utf-8?B?azE2a0ViMWxhOUljVU9FeU5wTVdVL052a2t2WTBobCtSVTlDTlptNmROMG83?=
 =?utf-8?B?d3FIT2RqYTg0YzgvRG5XMktYbGZCWi9DMno5ZnVtNHo5a0h4dUo0cHc2cWhh?=
 =?utf-8?B?UXF4V2t1MjgveHN0RlJHME90aHdaMmpHK3A5VmNkSkYyaXl4Q1gyMFNDRmg2?=
 =?utf-8?B?MGJ4cThwazBKZkZpQVN5aWpmQTB0Q01Ud2M0cEJBOWhOMWRmaWdDeVJjVmt6?=
 =?utf-8?B?V3gxSVRIRUthV20yTzc4aHk1SVdPVWMxaE9DQjllenp3c29kdXFtNkozK05U?=
 =?utf-8?B?ZjUzamV2cWhOSXVKVHI0UGdvN21BdHR6ZDVCNGd4Lzhwb1F6OEhxYWNkeEp3?=
 =?utf-8?B?ZGc0U0o0UXI0cGdsZUlNNGZVOHl5TFdLN3N1Y3BiSUtLbzc1eWRqM3lzNVBp?=
 =?utf-8?B?bEhBQ1ZjVzFnQUdkZHlZWUJmZTdUeUV5S2c5UXhUSlIza3pnbTZLS2pvL1lx?=
 =?utf-8?B?S2IyVHFEa3VqZEw4VzNjQW5ETTBSYjlJaGp2Q0tpL1V5WHR3TTduSXloNElE?=
 =?utf-8?B?dnNwVkl2cDV1aHRaZGV2bXZ3THgxMUlUTEc0SmFYVGhIZzlrTUNiTzJYWEZq?=
 =?utf-8?B?b1p1QmhTSlQ4TUFnbHE2RjFWcFZCMDhzOGZVbGRJWnFUZ0d1N0NBTlBZNXZQ?=
 =?utf-8?B?VDRVMkNwdHJOeHVHRXFEWlNzWjc2N3gxS21yV2UydFNXRzM0Q1ExTW5reTdG?=
 =?utf-8?B?Yk5qb3R0S1lPc3lFSXJLU25JbXB0dHhla3ByYW9VRE1EM2lKQUM0RUY2YmNp?=
 =?utf-8?B?ZU5Pb0hxTEJwSFMwSG5ueXZSWHp6V1FxTXVrSUhNNHBGcG94OWVVOXNHZloy?=
 =?utf-8?B?N1ppZEkxM0p0MjJGMGk4Z3RHc0ROcG5ITG9US3UxMkl0cmxVcjY0NzQ1R3VT?=
 =?utf-8?B?cTlGZFJVM2hSRnk3cVQxbVdNV0xtbDAxZlEwMGExK3QvVDBtVTQ3ZE44bXBV?=
 =?utf-8?B?MCtqazdxb0lsblgycVBCS05LelM3RzZBNW9yc3I1RytqZEZVNkJwandXK045?=
 =?utf-8?B?WDBkWDh3cWZib0ZrdkRoVDJTeWFvUXVDWlBqTUdoN1ZGQWpjekhDS05yVENw?=
 =?utf-8?B?K0FRWHBiSjBUcm5IQVNlaS81RG5PQXViYnlIR2phRnc3emdBaVBLNmUxaTFw?=
 =?utf-8?B?bkRRbm1aSWZNSXdnS3NUNGFQT0FhR1M0SW5GU09ORTZhc0dTZmQxUlpTYll1?=
 =?utf-8?B?dTc0RlBwOTZHc0htOVloNEw5WVNzK0VxamgzVEI5OXUvelhVelhMWndMeGtC?=
 =?utf-8?B?M3k3SXZIYWxMemZJMWllSlBuWjdqNmVYZjZWK09YSi9MTXRzeHFsNUZyVjVR?=
 =?utf-8?B?TlFzWFVDTjM2eDlNbVF6WTc4UnJHMEZ3Z29rN0hxRENETmVRQ0RvOHpodHdn?=
 =?utf-8?B?MjBJMEZYQ3ZrajBVdndhRzlaMDlCT1BRTjdjUjUyd0d0SGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(32650700017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:38:28.5605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e688b9c4-e18f-46e8-dd90-08dcff7ce665
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10823

On Thu, Nov 07, 2024 at 16:39 +0800 Zhihao Cheng <chengzhihao1@huawei.com> =
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
>
> Hi Waqar, is that line 2639 ?
> 2540 sstatic int tnc_delete()
> 2541 {
> 2608         if (!znode->parent) {
> 2609                 while (znode->child_cnt =3D=3D 1 && znode->level !=
=3D 0) {
> 2634                         if (zp->cnext) {
> ...
> 2638                         } else
> 2639                                 kfree(zp);
> 2644 }
>

`faddr2line` doesn't work for that func+offset. It just complains with

  bad symbol size: sym_addr: 0xc0830f81 cur_sym_addr: 0xc0831464
=20=20
The offset and size hints that it should be somewhere at the end of
`tnc_delete()`. I tried with `addr2line` and the addresses around that
offsets points to the `kfree()` on line 2639. So yes, it would say
that's the offending one.

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
>>=20
>
> Looks like there is one possibility:
> 1. tnc_insert() triggers a TNC tree split:
>    zroot
>    /
>   z_p1
>   /
> zn
>   z_p1 is full, after inserting zn_new(key order is smaller that zn) unde=
r z_p1,
>  zn->parent is switched to z_p2, but zn->cparent is still z_p1:
>    zroot
>    /    \
>   z_p1  z_p2
>   /      \
> zn_new   zn
> 2. tnc_delete() removes all znodes except the 'zn':
>    zroot
>       \
>       z_p2
>         \
>         zn
>     TNC tree is collapsed, zroot and z_p2 are freed:
>     zroot'(zn)
> 3. get_znodes_to_commit() finds only one znode(zn, which is also zroot),
> zn->cparent is not updated and still points to z_p1(which was freed).
> 4. write_index() accesses the zn->cparent->zbranch, which triggers an UAF!
>
> Try following modification to verify whether the problem is fixed:
> diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
> index a55e04822d16..7c43e0ccf6d4 100644
> --- a/fs/ubifs/tnc_commit.c
> +++ b/fs/ubifs/tnc_commit.c
> @@ -657,6 +657,8 @@ static int get_znodes_to_commit(struct ubifs_info *c)
>                 znode->alt =3D 0;
>                 cnext =3D find_next_dirty(znode);
>                 if (!cnext) {
> +                       ubifs_assert(c, !znode->parent);
> +                       znode->cparent =3D NULL;
>                         znode->cnext =3D c->cnext;
>                         break;
>                 }

Yup, I think this is it! Nice work!

I've started a test run with the following patch:

diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a55e04822d16..4c8150d5ed65 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -657,6 +657,11 @@ static int get_znodes_to_commit(struct ubifs_info *c)
 		znode->alt =3D 0;
 		cnext =3D find_next_dirty(znode);
 		if (!cnext) {
+			ubifs_assert(c, !znode->parent);
+			if (znode->cparent) {
+				printk("%s:%d\n", __func__, __LINE__);
+			}
+			znode->cparent =3D NULL;
 			znode->cnext =3D c->cnext;
 			break;
 		}

and can already see that the print hit a couple of times in a few hours
(250 iterations). I'll let it spin for a little longer (recall that the
other patch "masked" the problem for almost 800 iterations).

This was quite intricate and I really enjoyed your little breakdown.
Thank you very much for the discussions/collaboration! I'll let you now
as soon as I have an updated test result (and thus send a new version).

P.S
I wonder how many systems that might have experienced this
use-after-free and got random memory corruptions (or other security
issues). This bug has been there since v4.20.
D.S

