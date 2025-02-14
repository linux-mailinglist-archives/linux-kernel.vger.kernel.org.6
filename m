Return-Path: <linux-kernel+bounces-515791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F9A36919
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52E37A4CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871EB1FCFD4;
	Fri, 14 Feb 2025 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G5qZo1bC"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8571FCD16
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575710; cv=fail; b=hkiiIQd/sJH+0q41W2H45JVd7yxF3EgiL2o74XvhPVa0RxSMNxjC47IiA5yO3qFStfMIbo+kHPFB8ctjC5pFkEv1tDybgeUziLLbon1ivD+WO6gDkT9Gj2uDqCxT7KjTd+vjy5HYbCHw5hDxV8x2F/HMQevdK9FIpdlq+rMM+zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575710; c=relaxed/simple;
	bh=sJ+BjeX2+NYHlTfz4mFmsmRLzEO1CI6+wewnmIA2zdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUhYie1fOqifQnNEUBNCKfVBo/XVOgC9PGvbcqdgcIbazRfuZi/iC+w2NocaYSGWQLlH3OXumKaK1B76i+6F0mFyTI3JLYNkqBtF+iVFry3v56j/LnZ/MdDD5tpZQn55+GAt/Utv/JXYipGAinmLYGKWnt+RBOsLSh1nU91H26U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G5qZo1bC; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8nRTZr+Kqi6GONcNk9GxDiK6XoVL9/odNc7EUxJ24lFhI+9vmgOw+l00dxdSE/AdooxcPVRkLmgUOkDoLqJ4E4+ChPGlPzq/U31i4BLyeDyX4hYjN9BkkaJY1zwbZWTy3KBXwET4KyRVA6XO7lxsLDh+CaxZP1ff0wYaXqMdxFj16yGI6yF4Amz1SD738XW9H6/SgwFQ35reB8zLw5iPbUWFpoItk6+L3ikHBeZcRFV+soPCKfpNbLg+AqlHqqslXjKWRY4VW2NHUPPUSR94rTduTClLCIV9CpZqeYZOM9ZCOAIdNQ0W62o648kjifsozjndHAGArkLS7XeSENtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR2tsXy7Bl/jhZ3pnfP2iQVH8ypfsuowk0tzPTK6cMI=;
 b=I+BEJvr7MOHijXHNJp44I6lXdUdlnBja60P+ofYFYPvnHbzDXfSUt2wA8sSbMvYByYT210d2w9iCgrcN2DclVikjbHeyma4fG+vIW70cHqtzMbQr5zyEcmEPj7yCZTJP25+FmyoY95QA5ESPS2Ty+lwBXrcKli6S55wA9OuoYuzIPsXWOKsuFE8V8tu+i0XZs8ZBPs/oqZJbxBNEB8t4Qu9h+PP07Pf5dNamTehSUoBboQvEUnss602iqQ8mIwPERTjzP3IPMn/LMyGd/Za1uQ9If8as1OD3mVxVOy0NaxeeCkUwP9u1pU33Mm9sdqIWl/l5nCRt+G776dbkU1XgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR2tsXy7Bl/jhZ3pnfP2iQVH8ypfsuowk0tzPTK6cMI=;
 b=G5qZo1bCIaAAk3d2EpKx+Cs9s7w2vpqPeFlxP8SO61qJomLTevjxGHljjMifTEu7fg2B2oNjYLJcJ3gTT5Rbs2CbMXn3JS7E/PT3eoHWT9RWu3oO5m1qq1flyJJq7aWI0ooXi+n81vsx9+ZDy6iSReBLwvUI/C4pQB32MumdQ4YBJhr+B/hBO/uUooOM7v2qf/rf0ku3hXkLkHek4rJwbDddsnJf/M1EsK9qnUH9eoF34ZObWalT9ve3Q1F/HixLM2hw0vROI+EOQosttpBVDrkkDMu+9FB6v4drqIM0qXI7nr1OpyzbEugGsU/IxnvMShM39Pu0cCHgKI8h9aOYeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 23:28:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 23:28:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in shmem_mapping
Date: Fri, 14 Feb 2025 18:28:18 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <25D9A5BF-7108-455C-8A2E-B04A3A4DF5F2@nvidia.com>
In-Reply-To: <67afd12b.050a0220.21dd3.0059.GAE@google.com>
References: <67afd12b.050a0220.21dd3.0059.GAE@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 009b273b-a2ab-4305-e271-08dd4d4f46c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i0VDdwns8xvRmO04u2ZKvnzms/8q1vFiAB59i0hrUWiFmKe0HTkuDiRj3v3p?=
 =?us-ascii?Q?uCMJb2D15mAJfsDtY+60dqAkbFJgMEcAFkqDkwuMzgLwGThet1qfx6Tl+t9I?=
 =?us-ascii?Q?9tfdOFQ/go3OzUNCktUMNdG8rnascbDav8HXR119BYx3w5S+I8B8+S0lYIKH?=
 =?us-ascii?Q?M8yy57c0ObFbj21bify2Z2Oi8NWjS08r7HaN4kfoHb2qBQeCXnkrkQvxYSfU?=
 =?us-ascii?Q?pavVumXMl5ssNYn9M64bQOnnK1uTLxtunnjQd7n6P/TB6f9D6oW2yv5IyLCb?=
 =?us-ascii?Q?wrR+gipA3P2JRwm4unyCZSqhsiLKaOEL8/Zyv2V5W0AfDyCKB59Hp8CgmQlw?=
 =?us-ascii?Q?A27CHyOjp9p+q4dt2MaN/kixnJAqfMNVmtBYsnl3gD7xyBSn6Q+vb3pdYMZx?=
 =?us-ascii?Q?AgiNSFe2PPXXShqz5WHjaI6GG+w/UKktVbpKkLsTGDeTQagO3Zrl58pI5G9N?=
 =?us-ascii?Q?9mCKIOUeS9Vg/In3zQDQVWBafX5VBJNfgU4wmjIQGF/z9ql0qN1VGoUG68S6?=
 =?us-ascii?Q?tUAhH6w+EXSrfTvzgdCM/xQlXWF2PMzNdwLbiBzALIGWtVQIaTJrQ/r47LLO?=
 =?us-ascii?Q?FAJP1YD407JIAYZMqo2bqEGN0bDDH/ccW9CMLfTfJYaFo4ag7MvTBm/VMsmV?=
 =?us-ascii?Q?KTYWNyZ5dYWrbpI9OmI2YnwCxmo0QMqZI1Y7et5vJoUgZ4im7oficScoSMN0?=
 =?us-ascii?Q?mwOzP6aS9ZwwWVbs/5hhj9UXQGx3GBwiKRHqC+Q/LAxP/kDdFaCKw65dPJ5B?=
 =?us-ascii?Q?SQF9tejStrcd8OObwJp9TSBHZ8RfnMMTDeiXLLFCQ9oTNANMfH16AGab6thn?=
 =?us-ascii?Q?Fp5xXZY/Y4xACOd0hVN+5avD5mmlpP6NEsxriZnyA8Owj8GaUV17VQkLFuDk?=
 =?us-ascii?Q?1BlbTEgX9cbQKgWrBtYqYcnIF1fAfhNjd7W8PguzW7YXPmmqU4adJsY8JNqw?=
 =?us-ascii?Q?130XGIA/ZHsHqBSi7I9JQk/G14jpw+UtL5f8jaoaXzjzmElae8UHSwTQIzUg?=
 =?us-ascii?Q?KUyBupZuLGhFGlrNt4KmRYVKMyq3LLYGbukcVt+qOh3bW2XRlsuXxnCOhlOx?=
 =?us-ascii?Q?L0XloDhfYMRk7J7gGT0uJ48p1bkupBcfaBoYUZXfw7dPxKMBPgwFIuijbIMa?=
 =?us-ascii?Q?SJP11xG0r7zCvJCi20r3vBUPilS9pe8ajK2IfYfGDeons0G4AB8P8gIO79fI?=
 =?us-ascii?Q?lgK+lUexJEKxxRzGpIQsDL+UgHcdY9PxqQAq6xOmzLJlUTxJ86rzS0LNW2Wb?=
 =?us-ascii?Q?E2HeCrc4taMofN9GaIDLaAkoCFtWWXvIdzOW1MuSyOgxR1k4iSRwQbe8ic4n?=
 =?us-ascii?Q?YUnctSeiyLG3lKH2y7D6lqlj6SpUnGCIujQv4JId1pDL70pWMQTrZbCpX0JN?=
 =?us-ascii?Q?i1301UMLNdXbv9opJc4GvhLvk/26?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idM7Yo2NY/vKEMx4Z1ybcVQJifziQQLMN01JFJAPDkYWWo6HkYzQjUnuDtOL?=
 =?us-ascii?Q?D0JPU9dCyRxtx0WPsl/TJrhECZBkwIIgz5cBU5QYZbrXwdO8AvpOeugDAyCd?=
 =?us-ascii?Q?y4a/8VgNyTklJWYvvwja6SoeXLOr3ssOd8F7RXUMsgujcpbxBnk6a5424hsO?=
 =?us-ascii?Q?5vL6T3Rkw3RA4trECwtP6b3W/eRSOIhjR+3VWfY7FbuIsuYXVm7z0SY0KX7u?=
 =?us-ascii?Q?U0t6vKvWaUbIx4SIsTI1/4QVUPQAvuhelRuIIuBiEwpvFH7Ao/TdNl7WRAtr?=
 =?us-ascii?Q?AGIYCD/PngUZM9yR2mAE1GpVERX+QRwcLyP2CBx8BarkzERVMTXcceDA9eRM?=
 =?us-ascii?Q?rlwni2AAU+Rkx4kVt2RDNCEswGLFRQbI4txRFMeSdYlzSwn8Uy+JvnGE+wtw?=
 =?us-ascii?Q?FPqTnp/OaNoaYa60mdAwJiAPC/sZKRAVUt6y8a3EImaRtx6Sk/QxL8CeNlrf?=
 =?us-ascii?Q?nYH3b0p53pZq2Rmez19xLFfUpvXnH9EumcmxSHM7f0RyKVpWmnIBIPMNmLqa?=
 =?us-ascii?Q?st3rWT+BvQ3Am01YGl6bn839+RhrQdsfp8oY0MMT43re60W0GbepgYfgPLFw?=
 =?us-ascii?Q?Xcu9UPfKQIya33/WIrCixzVklZPcgN/YED5HwszEAPK4S6IHQenGp6Cmg3o4?=
 =?us-ascii?Q?HO3PLPv7m7uNzuJyClA9NwSqixECf7PxYRtW644YuiGNBclaxU1uCk/mFN6v?=
 =?us-ascii?Q?odGh3p9L+y7pGGYfAl3DwCJVjRj7Lutm7CGlvjcMjex5D6pM9QP2Tc/8Emss?=
 =?us-ascii?Q?F3o8zz1A/S76UCKC2LpvPls4ThstynYWcY4fnGoFLFZ9t7tPF9pLyOKi/M2e?=
 =?us-ascii?Q?h2CYMC6oBzgnTrVOK07/HGVA9J6/cg2FqZzBoUst3VqtT6TwCj9kCVQ7om9Q?=
 =?us-ascii?Q?8a9WQ2tEamzRFmrKuLcbp0tci8asYtYwphl6m5aCNeMR5p+YQYo4Y4TvIMVD?=
 =?us-ascii?Q?3PuHNmps+RSgqLVcrlLuHIOuVbQcHFxOlUAYpKUY3GhPV/rt/Q1+6wWuASke?=
 =?us-ascii?Q?W0akr5ipCrq75EQakcU2tNb0ns65upGujtO6XZXzVrHWan0Zfks+mO7SbaGT?=
 =?us-ascii?Q?MNQ2Ve3DR01c9TLE2knWlWF/RCD4KGz2aW0lj3ixsGuRS5r+HAS2UylvTI7I?=
 =?us-ascii?Q?6edFiXe1xFOVkyT7eIjAJf0+AzFA9AxXyks3i2LTKErDsRBUsUcfhmIei2T6?=
 =?us-ascii?Q?CFEDHB58aUO5hUVWWmHCgZYqfvq/vUmsK7SM3FpAZ23eMqXIsldBMYhMMMEW?=
 =?us-ascii?Q?Z3+apX90raXESA4nks6e36NVDMiWdplkYehq/Ewv7SI2cP21f8qKATn6Ff7M?=
 =?us-ascii?Q?7l1s5bkTY+jL5YtX9l2sN47M3YyYyIWN9QnPYZtNc/RYLPB5PbxoUKTeaTTG?=
 =?us-ascii?Q?FxM2br9ybLJZmy+81gzyLh8lRRGdCTdKCwXm7D65QS3TpOnyfZ4EKZGw/yUA?=
 =?us-ascii?Q?ItQ1O3XwtDD7MKVEZLBUBnn+ee5wu+kN5nw+w37YJkB24ZpBq7yiMfaWZN7o?=
 =?us-ascii?Q?mvtqHH9VeouPSIukC/rVE7YqXNWALemMhXL42ZSXoZbkCHjjul4Z2/s5K4EZ?=
 =?us-ascii?Q?v29V7HGHQnxEm272aU1ZCIfTlC+l/Ks8SJwwogfr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009b273b-a2ab-4305-e271-08dd4d4f46c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 23:28:24.2167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQbmHB3auZtDeecGTSSvwoY3KlXyO80B2MdVNuSnn4T7gzWnRvxcWx6O4GCumprB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

On 14 Feb 2025, at 18:26, syzbot wrote:

>> On 14 Feb 2025, at 10:48, syzbot wrote:
>>
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    df5d6180169a Add linux-next specific files for 202502=
10
>>> git tree:       linux-next
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16d343f85=
80000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2cd616b6e=
736ca7
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D012c6245eae=
a0e23f7f9
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D138972a=
4580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11737b185=
80000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/92495cf20271=
/disk-df5d6180.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/4b3656161842/vm=
linux-df5d6180.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/7fbc4e7a0f=
5d/bzImage-df5d6180.xz
>>>
>>> The issue was bisected to:
>>>
>>> commit 19c067c8a0f18b62d4a4235b0b327624c86f2e40
>>> Author: Zi Yan <ziy@nvidia.com>
>>> Date:   Wed Feb 5 03:14:13 2025 +0000
>>>
>>>     mm/huge_memory: add buddy allocator like folio_split()
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D102f9b=
df980000
>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D122f9b=
df980000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D142f9bdf9=
80000
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
>>> Reported-by: syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com
>>> Fixes: 19c067c8a0f1 ("mm/huge_memory: add buddy allocator like folio_=
split()")
>>>
>>> Oops: general protection fault, probably for non-canonical address 0x=
dffffc0000000024: 0000 [#1] PREEMPT SMP KASAN PTI
>>> KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127=
]
>>> CPU: 1 UID: 0 PID: 5949 Comm: syz-executor163 Not tainted 6.14.0-rc2-=
next-20250210-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 12/27/2024
>>> RIP: 0010:shmem_mapping+0x25/0x50 mm/shmem.c:281
>>> Code: 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 c3 3a bd ff 48 81 c3 =
20 01 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08=
 00 74 08 48 89 df e8 dd 35 24 00 48 c7 c0 80 6c 14 8c 48
>>> RSP: 0018:ffffc90004036dd8 EFLAGS: 00010006
>>> RAX: 0000000000000024 RBX: 0000000000000120 RCX: dffffc0000000000
>>> RDX: 0000000000000000 RSI: 0000000000000600 RDI: 0000000000000000
>>> RBP: 0000000000000600 R08: ffffffff822bcf18 R09: 1ffffd4000331008
>>> R10: dffffc0000000000 R11: fffff94000331009 R12: ffffea0001988018
>>> R13: ffffea0001988080 R14: ffffea0001988018 R15: ffffea0001988000
>>> FS:  00007f5e045316c0(0000) GS:ffff8880b8700000(0000) knlGS:000000000=
0000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f5e0458dae0 CR3: 0000000023c78000 CR4: 00000000003526f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>  <TASK>
>>>  __split_unmapped_folio+0x238a/0x3e50 mm/huge_memory.c:3587
>>>  __folio_split+0x1267/0x16d0 mm/huge_memory.c:3871
>>>  try_folio_split include/linux/huge_mm.h:374 [inline]
>>>  truncate_inode_partial_folio+0x55d/0xdc0 mm/truncate.c:230
>>>  shmem_undo_range+0xab7/0x1820 mm/shmem.c:1144
>>>  shmem_truncate_range mm/shmem.c:1224 [inline]
>>>  shmem_fallocate+0x431/0xf20 mm/shmem.c:3674
>>>  vfs_fallocate+0x623/0x7a0 fs/open.c:338
>>>  madvise_remove mm/madvise.c:1034 [inline]
>>>  madvise_vma_behavior mm/madvise.c:1269 [inline]
>>>  madvise_walk_vmas mm/madvise.c:1511 [inline]
>>>  madvise_do_behavior+0x1f29/0x3c00 mm/madvise.c:1646
>>>  do_madvise mm/madvise.c:1744 [inline]
>>>  __do_sys_madvise mm/madvise.c:1752 [inline]
>>>  __se_sys_madvise mm/madvise.c:1750 [inline]
>>>  __x64_sys_madvise+0x11b/0x140 mm/madvise.c:1750
>>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f5e04576519
>>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
>>> RSP: 002b:00007f5e04531218 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
c
>>> RAX: ffffffffffffffda RBX: 00007f5e04600308 RCX: 00007f5e04576519
>>> RDX: 0000000000000009 RSI: 0000000000600003 RDI: 0000400000000000
>>> RBP: 00007f5e04600300 R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5e045cd074
>>> R13: 0000400000000000 R14: 0000400000000140 R15: 0000400000000040
>>>  </TASK>
>>> Modules linked in:
>>> ---[ end trace 0000000000000000 ]---
>>> RIP: 0010:shmem_mapping+0x25/0x50 mm/shmem.c:281
>>> Code: 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 c3 3a bd ff 48 81 c3 =
20 01 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08=
 00 74 08 48 89 df e8 dd 35 24 00 48 c7 c0 80 6c 14 8c 48
>>> RSP: 0018:ffffc90004036dd8 EFLAGS: 00010006
>>> RAX: 0000000000000024 RBX: 0000000000000120 RCX: dffffc0000000000
>>> RDX: 0000000000000000 RSI: 0000000000000600 RDI: 0000000000000000
>>> RBP: 0000000000000600 R08: ffffffff822bcf18 R09: 1ffffd4000331008
>>> R10: dffffc0000000000 R11: fffff94000331009 R12: ffffea0001988018
>>> R13: ffffea0001988080 R14: ffffea0001988018 R15: ffffea0001988000
>>> FS:  00007f5e045316c0(0000) GS:ffff8880b8700000(0000) knlGS:000000000=
0000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f5e0458dae0 CR3: 0000000023c78000 CR4: 00000000003526f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> ----------------
>>> Code disassembly (best guess):
>>>    0:	90                   	nop
>>>    1:	90                   	nop
>>>    2:	90                   	nop
>>>    3:	90                   	nop
>>>    4:	90                   	nop
>>>    5:	f3 0f 1e fa          	endbr64
>>>    9:	53                   	push   %rbx
>>>    a:	48 89 fb             	mov    %rdi,%rbx
>>>    d:	e8 c3 3a bd ff       	call   0xffbd3ad5
>>>   12:	48 81 c3 20 01 00 00 	add    $0x120,%rbx
>>>   19:	48 89 d8             	mov    %rbx,%rax
>>>   1c:	48 c1 e8 03          	shr    $0x3,%rax
>>>   20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
>>>   27:	fc ff df
>>> * 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping in=
struction
>>>   2e:	74 08                	je     0x38
>>>   30:	48 89 df             	mov    %rbx,%rdi
>>>   33:	e8 dd 35 24 00       	call   0x243615
>>>   38:	48 c7 c0 80 6c 14 8c 	mov    $0xffffffff8c146c80,%rax
>>>   3f:	48                   	rex.W
>>>
>>
>>
>> #syz test: github.com:x-y-z/linux-1gb-thp.git syzkaller_fix_20250114
>
> "github.com:x-y-z/linux-1gb-thp.git" does not look like a valid git rep=
o address.

#syz test: git@github.com:x-y-z/linux-1gb-thp.git syzkaller_fix_20250114

Best Regards,
Yan, Zi

