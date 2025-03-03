Return-Path: <linux-kernel+bounces-542384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49037A4C90D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D91884EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CCB22FACE;
	Mon,  3 Mar 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Va2UHwiI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F95D2620EC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020853; cv=fail; b=TCg+FLUH0yTpFT+b8ShyTu6bgPuXJC0o8cPgZsaTawYBU4YjihYRxj5s6iArgUCrdN5V6IEvg3y5AH3PwJ50WfEg2iYAaV8dq3BewnJliAlV/NsB+jWsjhNy9v/TTOEFTStpc1LHR2ypRlBf4pCyWosFzpvs5jhQIz2saGysSM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020853; c=relaxed/simple;
	bh=NE0ULnwk8TcIo6xfiAtckBSfsY0v8jMoGBLzMokbtHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iSkTs2XOV5ZHUxlTar5wrXYJ+9Xc1rBAzwCpTpVXMdS9mQAIC4sWHTVdFmcXRxnk8/Ym2Dm26A+LEQyVtJpY1DjLcMtnHG1wnAkpYgCi/PZBmuEncPCQ28FKzjP0aAPbjbHoH2cY9acxSZlBMI4bCgPvwe7/5P850LI/VDol1ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Va2UHwiI; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9cQerbDKby/hJfpX0xSkDl4XAQLWdzouTNBWoOEwh4cEvqO9jZ+stjOf41U1F8QjdreeEtAbhxDh2R+DvW9zXpTGiOd6IZrlXDq+vZTCLKFBB70Rer7RJJPHZuTWMcuBTVULCp8Z49NK8d0KCGW6RChu8tIDWeX2k4eCDrG2LA53U8dPLhJDpY3x+WxUsFllRXZAcrkHmmPvrq2xBtSgBcFxZgP+M/soWrJG8+fjAETdBH593HJnSlQo4vj4EZcITpJS35zosCys+hkfqG5Oo2zGh6rYPeqS15WI79VOGZ45LPP/t7DC0qHscT1bG+J/7KhQEcFN/kG5gdCs2Q+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsKN6vK5C8w1CdBpdTanTxjPZY5PY2hbPP47DeuSMmY=;
 b=QjwWowQasTRYQ6/NW+3I6RSIYSlGf9GrT+/Hmsf/M1pW3EtWd5fx3691St8AagYr1AOl5Uyh3QvRhI9x9HxNjhUz6U20QPRrXMJJo7bE2yhX3fobU6ZV+Tp5bumVuNIU2fkN0/bXFopU8yigxypqw43HfUS28RhWesOEbqJkJ7Su65ym7BDftXCQ0dNAHqqOgtty6n0HNgHZwG5TtBOoleJNnCX013ofGgkabdVIt95Eh/mCuOwlhoFg4uPvNONcKeeKAVor+DK3Tkfuh5oxyncYzAs9sHFsWhIWWYC0qZSh98P780CY4MVfPiArgS4JxbOFSKGE8SVDGDIoKJorEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsKN6vK5C8w1CdBpdTanTxjPZY5PY2hbPP47DeuSMmY=;
 b=Va2UHwiIdq5g+7Ib6ywptVkDEL8bD832UL5YVNHclhI9eNdLHfCSxf2iNFQl1aGPdUPSPkV5DcMk6pt/DBvIgTarT+ih443m734aBA2wv5xzJf8UKm8H+lUdf4586S3D1yfLqb03eeGjgBh8fZGwhO1ADil1GBaLVN1pjiZisNyTkSUJ15uLdrhyN1SjoZvyxGMIlcm/A/sxPNhOGdipZL1Q3gx0y882iKGtLg60fDtuP3W4SrcIS025cY4LwKXC/M+iGsnbyAGijcaQuc5Qbz5XRSlAoZFquFYAggNYCAOVAa3avyc6ShQcZuyYZYUfIzlbDkENusLRiPzRnes2Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:54:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:54:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Hillf Danton <hdanton@sina.com>,
 syzbot <syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in try_to_unmap_one
Date: Mon, 03 Mar 2025 11:54:04 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <DFC7712B-B996-493B-B462-94BB6123EABA@nvidia.com>
In-Reply-To: <efc2a483-34a2-4445-8dcb-7168869834af@redhat.com>
References: <20250301234002.2893-1-hdanton@sina.com>
 <efc2a483-34a2-4445-8dcb-7168869834af@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:408:ee::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4c679c-bb7f-47ea-fbe6-08dd5a7402c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cm6CpQrYIE++y+RFq0XQHYUTPaUV66+eVLTwAMsIL97Vsid4AY8n65YsCobJ?=
 =?us-ascii?Q?pqJzGI4YHtVku+5KuR+RuFkeKoeIyXmvhnytR35XD/Kv27siCnhTsJ8ORKV7?=
 =?us-ascii?Q?nFKw18uvkV+qDP4ZLy2kbzHfH/asBw612k0mVG3hLbEemgpSQqcmAmBwGXHE?=
 =?us-ascii?Q?VODxIMbfwVs8mjJDi9kRHGMZ/+wVy3DVMpcvcIVBCgIkQaMQY7rl5tSio9eY?=
 =?us-ascii?Q?aRm+ej/UzNpt4VR1tI+y864RjCAdY+itW6bT+OQB8UDEpL2iYMOIlCAPCxUB?=
 =?us-ascii?Q?6o+ez/IkWpiXDTKihBJ+I/+d80nQT5EBG8RktrQDsLqlJ87RjCGpXMlRu9QM?=
 =?us-ascii?Q?cHhzNmgJnwsfRSg/sLDoHmi0gnYq/YeAHUbRx1ZKg92C/F9cCAos0mSUb9uj?=
 =?us-ascii?Q?vNlX9gdK/79PucOU/uw6MDnyMUcr71dzmFvyO1UwRcE/TrIyT3HjxQF6IBK1?=
 =?us-ascii?Q?a+DfUbWd3eUicSxlzAGXpZMUQgeuyf7513moICQKGUgP8ki1TXwuVRsp8b73?=
 =?us-ascii?Q?Qo2CK9RDgnPUv6R/+1bez3jcdw3wQ/7tFYeEj465ix0+q/uDL/7VUYLAVt44?=
 =?us-ascii?Q?gsJciTDp2UEzkjoaJN0pu/3zmftyniUjL2ECHDFEmzhNnlg56osF10dckk/0?=
 =?us-ascii?Q?Mc9TY2Kj1/kaWU5n2hKUBsxtGUAnA0IXTQ0H/JR6JYhBXzdmJE8or80Bai04?=
 =?us-ascii?Q?tMxrwUPTk+owAx9dEI7AZ+kBl9UdgjLLjj6Gkb2nvBVOZ37Iyp3eaDHCN7Hj?=
 =?us-ascii?Q?OULtMOaba2w5uJzSqeR5Bq3ltTHkwsd0djEQ4jFvAcgUoQTx3o7iPH/q7a6B?=
 =?us-ascii?Q?vjFARLuoekrOZcv99WfkWAUP4y0UgExB9eaENUgHT7chqsiUVnQsXOpkDzr5?=
 =?us-ascii?Q?HqiljeaMwzUhm61TnLAg6EVskYPpL+PoEnL91+pAzqSSbNnSNjggqTrH2Zcd?=
 =?us-ascii?Q?4FHuHjFn/pStKgRMaZ6aZln/KKPmAOFC5YJtQ+NsFa4qYADsP8d1gN/BX+6e?=
 =?us-ascii?Q?x7I+evRv+uKMd1nuAtm/UrqtdZeizPdluiNep+SuWtJLPmUhYQ555godfl5b?=
 =?us-ascii?Q?aztExszM5kUfjNM+wR8wu1XsD7TaZfYdSqZsWNJ26ge0INZH8FOaAxjHt+hX?=
 =?us-ascii?Q?Y7qs39Ks8UcWgRjM6SO56q8SUeMwDv8TTI1aiCV3YsgAAjJ9WIc1lM21ONBG?=
 =?us-ascii?Q?riydUXdbhIb1cMSDrdqPVZOLNSSwpamn9xi3u9RxotpKUpcPJIKi4dFGRquK?=
 =?us-ascii?Q?TFlUwdv14TKJxrQh+U57yicgQfCaZXYRd3zVyun8IvyLtGArWLynz/VRAFTN?=
 =?us-ascii?Q?En00Sz416BqFy4IXUaxKZgXM74PJUihhNheLRuN1ByA530Q1M0FpbjtW7Ge3?=
 =?us-ascii?Q?V+i2n0Ov1WpsyKFhml0ZCbg1Nxhh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Zat4Ml5VRNpbvbR8/TV7Q0Z2Dz1ssRTd28aktToed0F8jN+iwKxKSQ+SQl0?=
 =?us-ascii?Q?qdH/VdBBG/SAAsOZKJxbBHuf04r4XrxbEkD68Tg+9eN3zPH+7wo1smlA7jpU?=
 =?us-ascii?Q?xvXb38fIX89NzTkRpj9MVc9bNdegTFZuhchLn31STVtTZB+vnqiQSeWvyJgv?=
 =?us-ascii?Q?YOwxCnIgBhqWnwDmVC7sisIEQW0oFg5Nu6ORN3Vq1fT2ihbFx9G5G5Ublco5?=
 =?us-ascii?Q?Lkr6ZKqSXEbUwjlkQKCbeXeKu9tjOjGwfJh0ZmS6buqIXPz75mdAb3YD6Dtf?=
 =?us-ascii?Q?DTST9opKU6a2fr4VzGTbjAGCMHTtfwsr2BXHNhb6QGWqQnv6pbnLalqVDozf?=
 =?us-ascii?Q?gdZ3z+1HO1CcOtwk6IwEvR+Vv/hBVw3Y+Dc1FHrvyg717DJMv+SgkzMidilt?=
 =?us-ascii?Q?C97vQwFaT1r41zd1ts9J6gRIqtWLUcKVPEEFVb5x4QjA2M9PwTgvH2AA7MAx?=
 =?us-ascii?Q?jsV1eeShSW+vuRWg5KRS5Qaj4whT6Apo2jSQ+qN3rRO0AmHNAtjTm0ecwktp?=
 =?us-ascii?Q?MnjmjJjExNizLKVw68twIft1LeTGlKyJ+YyEbxI3DOwavS/1ix00+v4JiYRV?=
 =?us-ascii?Q?vRGcgUvTNSp0X8LtLQf414hzmPhJwH5VgVQMqgmq/i3QCABJVqMFvDmz3/ki?=
 =?us-ascii?Q?238k2mNnWrRRTKpJQ18iG+sdShJpnTaF2fBcXvrF5thJWUYJ9MX+Pm2Ac4kW?=
 =?us-ascii?Q?2yVOJWIvqtlicL63fL4mgdJuUwwalHdbwS3c+XTViifGdpRWxAH3MTUVFuWx?=
 =?us-ascii?Q?2HX9qcjMCjTWwGrn6orFCM/QopmTi1iDWkg0rvt1kFXmc12vTTFIQlzxyDv9?=
 =?us-ascii?Q?JxL6DykotB7I0Sc+SIWPToKm0Vw975WORIrsGqfrHE0dTQCt+0BsDvaj3Tq3?=
 =?us-ascii?Q?CzObIUZWsPQELyDfbmWV4Ym1xZwV9BtmrQCl3DyIlk5MfC0c4PSeARzgR3Gy?=
 =?us-ascii?Q?jJ6XYrm8TCSJAFSdIfAUHoi7DucHFu91WEaRO6mL0ItywStUiGY2lRaSJJO9?=
 =?us-ascii?Q?ikjKYK7AAFE+gpQi1Du3cHOvdtSeZ2cJT0blS0jIauodzGVH86C5wba6R3vz?=
 =?us-ascii?Q?1NwjgKR6H9DMclz78GmyS5EhaPLzAWaoxZSkKcTeOC99KflcuUiQIf3tQHFs?=
 =?us-ascii?Q?nu5Zh60P9kzSUj6yldEsXFXT+hXWdN40OpBlR7XgfORXRIpSidTOtf0f2nI0?=
 =?us-ascii?Q?p0k6V2YcJVQba//O38HRL5mnkLr0Ct/JZFQK4VtyLpFrhJx0L38HbOvyedUQ?=
 =?us-ascii?Q?l4l3WCRfZlQsDdLPuiN06hnhL0kv1taV6ltb0DqQ1TfIk0QOoC9fHlEeGtZY?=
 =?us-ascii?Q?xIJIbUniPdffqzCLs/uGccDI9JEY93oc60NRKwZcrQRMO9qv4InZmmhJu11E?=
 =?us-ascii?Q?+hWHXpYSVnWfI+2Gjnz0AizMpGdMseeqOfk0Y84civcOzbo04CsZA4Iy97mX?=
 =?us-ascii?Q?DvGAFaSeLODad/sXi5DqhXE7/zD70intZKcM03iuwWi97Vmsbqlf4sxQrlG6?=
 =?us-ascii?Q?ByvcD8UV1Xp09FMumE7C8QHl2YJK/PCupukKFjOvn+j+/tVKW9shbCbD9lHQ?=
 =?us-ascii?Q?W19+taUxMT9ikuDCAGaJen6phCNWFcXj3PzH+QvE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4c679c-bb7f-47ea-fbe6-08dd5a7402c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:54:06.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4nUz8hUPwQDzPk/Wr2dja72bv+jihzB6i2HdSbsV3qTwfxzIijw3NvVfiOwtJ5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945

On 3 Mar 2025, at 11:46, David Hildenbrand wrote:

> On 02.03.25 00:40, Hillf Danton wrote:
>> On Sat, 01 Mar 2025 14:41:20 -0800
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    e5d3fd687aac Add linux-next specific files for 202502=
18
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12faf7f85=
80000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e945b2fe=
8e5992f
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfb86166504f=
57eff29d7
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/ef079ccd2725=
/disk-e5d3fd68.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/99f2123d6831/vm=
linux-e5d3fd68.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/eadfc95203=
58/bzImage-e5d3fd68.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
>>> Reported-by: syzbot+fb86166504f57eff29d7@syzkaller.appspotmail.com
>>>
>>>   evict+0x4e8/0x9a0 fs/inode.c:806
>>>   __dentry_kill+0x20d/0x630 fs/dcache.c:660
>>>   dput+0x19f/0x2b0 fs/dcache.c:902
>>>   __fput+0x60b/0x9f0 fs/file_table.c:472
>>>   task_work_run+0x24f/0x310 kernel/task_work.c:227
>>>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>>>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]=

>>>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]=

>>>   syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>>>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> ------------[ cut here ]------------
>>> kernel BUG at mm/rmap.c:1858!
>>> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>>> CPU: 1 UID: 0 PID: 6053 Comm: syz.4.27 Not tainted 6.14.0-rc3-next-20=
250218-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 02/12/2025
>>> RIP: 0010:try_to_unmap_one+0x3d0d/0x3fa0 mm/rmap.c:1858
>>> Code: c7 c7 80 93 c3 8e 48 89 da e8 ef f3 19 03 e9 68 ca ff ff e8 b5 =
12 ab ff 48 8b 7c 24 20 48 c7 c6 80 17 36 8c e8 94 d2 f5 ff 90 <0f> 0b e8=
 9c 12 ab ff 48 8b 7c 24 18 48 c7 c6 40 1c 36 8c e8 7b d2
>>> RSP: 0018:ffffc9000b1be9c0 EFLAGS: 00010246
>>> RAX: 367eb4645686ad00 RBX: 00000000f4000000 RCX: ffffc9000b1be503
>>> RDX: 0000000000000004 RSI: ffffffff8c2aaf60 RDI: ffffffff8c8156e0
>>> RBP: ffffc9000b1bedf0 R08: ffffffff903da477 R09: 1ffffffff207b48e
>>> R10: dffffc0000000000 R11: fffffbfff207b48f R12: 8000000053c008e7
>>> R13: dffffc0000000000 R14: ffffea00014f0000 R15: ffffea00014f0030
>>> FS:  00007f4d2783e6c0(0000) GS:ffff8880b8700000(0000) knlGS:000000000=
0000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 000000110c465fa1 CR3: 000000002a1f6000 CR4: 00000000003526f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>   <TASK>
>>>   __rmap_walk_file+0x420/0x5f0 mm/rmap.c:2774
>>>   try_to_unmap+0x219/0x2e0
>>>   unmap_folio+0x183/0x1f0 mm/huge_memory.c:3053
>>>   __folio_split+0x849/0x16d0 mm/huge_memory.c:3696
>>>   truncate_inode_partial_folio+0x9b1/0xdc0 mm/truncate.c:234
>>>   shmem_undo_range+0x82f/0x1820 mm/shmem.c:1143
>>
>> Given folio_test_hugetlb(folio) [1], what is weird is hugetlb page in =
a
>> shmem mapping.
>>
>
> Right, the problem begins when we call __folio_split() on a hugetlb fol=
io, and the issue is that we seem to find that in the pagecache.
>
> I wonder if there is some weird interaction with out recent folio split=
 changes in next. Maybe, for some reason, we end up adding a wrong folio =
to the pagecache during a split (truncation), and a follow-up split (trun=
cation) finds the wrong folio.
>
> Just a guess, though. CCing Zi Yan.

You are right. I have a fix:
https://lore.kernel.org/linux-mm/56EBE3B6-99EA-470E-B2B3-92C9C13032DF@nvi=
dia.com/

I should have verified folio2 after it is locked and before the second sp=
lit.

Best Regards,
Yan, Zi

