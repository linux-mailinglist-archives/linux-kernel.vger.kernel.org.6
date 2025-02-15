Return-Path: <linux-kernel+bounces-515872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F62A36A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BAA7A3F45
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9192B9A5;
	Sat, 15 Feb 2025 00:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xw2lfvVz"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64D1CD2B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580503; cv=fail; b=K566VaPYg3NHHVu1DqVchyzetZvSjG4XXDa6lrzHkzauxpyb5hZhsqTqor0Cy8r3AmpsceNqBqa963Y1YW53sVaU78pJlwVuaf8nYIN3AoTua+GMwUIkTkDKWX7AxrhSWfDVbCyTJ11YmqP0ia1cuTHhJP8AFiOKGjeRxNObwz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580503; c=relaxed/simple;
	bh=UWxJ7gVsqTGXLKucIfqBWhLVbre8PeIavgxix92VCZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7U+iTJsmi/y2QCF6yuD4PyJ+enlNWlFNISQp224+LXXamN48909BZnkXuqwBBBbjGDUMrb3vAtY0c0+zSr0lDNbKUWNfN7nk9c/1oyFomEfIkBOL1MKaGZjpjgoEfS1rzgtdrUdT1JoxmOvBc8CtfLMEcGOm76jAljrxKA2wfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xw2lfvVz; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4o2bpicek/pOQXsmke/3HEFLZdljxOzQZM0u3gw6SrSxSkg3frse1ql4iGHoYhQDuxeuGHGbS672BOaG5NFyIHK+bkfi7oatGmV93sylHlFWfQA4yq/Lsbx77+tYcEosXdkr8xg9oTF7+N5H3SXBnpOABVBVowM7gtVOn2xpVVdxs8AqYPb2uSsOG8okjXNbpj5xSINy5w7cG2eggpXIQIxiemIBAtd0Yt+paYZaCHs3TyD+99EJNl2kYRjT0RCZhQZ8fYPhN7GQlHZscmOf3Q+yp3GqwmmM/nwoDzVOABbauwJYNAyxPU9wJq195ztCiWgwu9qeB9mkR7omuC1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nheMRDHM9qwbXkinVmqs4wc5tyYuDJNXd7KpyilVOw=;
 b=La+iPt9+wxIMi+6z9q0nh5znQ4yS62xOnkqbYee/oQNOjMnaoa/gPpK6xvsNjP5hDtDTtoRMy1BfnVoAPdBIjNvNlFyNrc1WspvTeA2kGDVPgZjMRlhfc9yXYYD1cIZmstJVfoYgoaJhFqyLlEe38yWf+fmWgyrFThGyrUkMzR10M39FZdjSFQ58Ls1BiEkd9vzXY4u/akGAh7rXIDmspMKW7Z08gSPZp3oEkw0sj/IY/Pmm8LefxoUKNG6TDJTGDF1uqLfu3xWxS+Aft7vsqpfKlrDp3XIXGI7BKnmYMwDwefjdGgHA4/cyVlmYs0U7dWYdhQwOERJMbgqqxWNmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nheMRDHM9qwbXkinVmqs4wc5tyYuDJNXd7KpyilVOw=;
 b=Xw2lfvVzS+M7Mth190Y6UIAjuKqg7XdCGrH966wyjKt1I/aWvXPt+Z2Cmoccy2lnYhVdfIRYDl43DHyzVgC2h7ABtj8UQ3A4n0zuNZsMrzOmStcqBwPicKAftH5NwmHNNzjl8oNYNRaWIkvkWEDKxXHim+xCgEaI1uZIKXbbPCeObFhkEMJC4P/qxZK5szeW2a5fMkmg+6kOkR4Y8nfYXmj5IwjxyklqbznmWk9RrXedfB1V4nlB23oA2kGzYx/8f5mFwDg3yMc3yMEiZKjraSMgWRaaB5+JetVfGQ4b34JxQOp8H0dOSxRl7lFjMYYiSTnoiD4cfZOtkym8BZgLrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.17; Sat, 15 Feb 2025 00:48:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Sat, 15 Feb 2025
 00:48:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in shmem_mapping
Date: Fri, 14 Feb 2025 19:48:13 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <72BB1BE7-6EBD-45DC-ACD5-B931F5C20E0C@nvidia.com>
In-Reply-To: <67af65cb.050a0220.21dd3.004a.GAE@google.com>
References: <67af65cb.050a0220.21dd3.004a.GAE@google.com>
Content-Type: multipart/mixed;
 boundary="=_MailMate_31522DB3-C8E7-4FAD-A0F3-FE8FCE819C13_="
X-ClientProxiedBy: SJ0PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:a03:331::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: ea919fdc-d308-49c1-ac5b-08dd4d5a6faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|4053099003|4013099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bAKx5iplPMP5cnn7be5mj4LVtiWtEVQsZfsvJByINVQYE+JARaNmaOxd4ugu?=
 =?us-ascii?Q?kkliv3nzNkL/6uNjQTczt3a81luLy/G60bEu+gsTJLPDCxCJkeB/6vEiP8/a?=
 =?us-ascii?Q?1sF1GqqspeJLFX3T1gJ9fdGaEYQP7u3TPjGPlwCpoG04UVqQjQq3+zsqlK5H?=
 =?us-ascii?Q?iWwputyBRXELAqeNNiGlRQy3dS/8jG9SlMYk06tn3RALhqZs17txntjwDxHA?=
 =?us-ascii?Q?GiZov2x3c+MfHLR4GuhhuneQ+Vjc4JYjydaEwUSyms07d3bv59sqp22/O0Mk?=
 =?us-ascii?Q?9LSRW28LixeVZWMKXhpVdrsmV7OZWHnPgMfjc+fnJI349VvCkSYfCn8B0JJN?=
 =?us-ascii?Q?3xazhQLcXT9MLysu880VUcJmCjeer+B+5EMokIMjHQYCo/vW0JSmSD0nMVyc?=
 =?us-ascii?Q?aWhteUwLIKBUo+RKAuzxGk/zXPrPtMC3yXSStxvJziwZypAMVDTnPY4FuRCd?=
 =?us-ascii?Q?OfxNyAUqMnS7Vz699vEo+CtmeVe5M4x6cipn+nsQ/KjrsqzzkbNbJLZ5UY+p?=
 =?us-ascii?Q?jdjHOlxwCyRfRmzG9upgHPHb0LHK8DmNUIX0h8ufKTgCBJqj7d+iNRdgr4bE?=
 =?us-ascii?Q?eyr1/o+tOPUqDsJeT97aKjAUp3XV39qeS0cn5yqNadVkXdfLOb3KtxRaD3Kn?=
 =?us-ascii?Q?YcPHN/ATKyBbnq4w0Y9FANNgvwPui1rM/BLyHP2xLU5RJlk9uRntcD6zSu2F?=
 =?us-ascii?Q?InvxbWRuKDwooe++ypPnkAnSg+GpK63MLEH/Sjvo8jj+qeP3sGSshMgKIrjw?=
 =?us-ascii?Q?RepZMGMa3DVje8guIMwnAsPD1SmePmWLYcdn+zL3UXYRZm/oyd3r2lB6Vxmb?=
 =?us-ascii?Q?tggothQpdbrgl/mAo9zQ+ef4fR3vAO/uZAHTykcThiWZiX+t21CcvZaOJIgj?=
 =?us-ascii?Q?uv4iU1yMeyHNIoV86juXmetm49gS7FUT39yolk8sSewyAqId0zr/7gBO+LEF?=
 =?us-ascii?Q?oVv6kIyw9+l+tNqUxolmU0G9SUGuB5DcWsbJ35ROmA31rVNB9QaSLA4S0Xr0?=
 =?us-ascii?Q?Sae6ifIY9LIfo53oG0lDrpHm+XK7AuShLdmQ1890TKkFMKHI65XndXEDSwX5?=
 =?us-ascii?Q?jQytv0XAozEEOBKXjXjUKyVRBVTOOl+SWFZselmCOmqIpO7FK7g8awAkL0rF?=
 =?us-ascii?Q?aggJDe6NvEZ81ULaPNGM/4I9/EhxrXUjocmVanOLBfGE+zv28SSt8UiKpZSW?=
 =?us-ascii?Q?bVmKV4rUaDh+jpTVLaGCmSEtfjqOeMiLVNjjzBNs8Q53qnd+pq9MF0nPoxFC?=
 =?us-ascii?Q?jhcV/MM18MJTGZiqD6AD5zxIFYG9ZKbRPIvUFEsFRkD6P6+RgbvBFABBA6av?=
 =?us-ascii?Q?0vJYzAdB7Axmr2EsibCvshpn/1C+PvxvzzDJZOXBwIRdju9tAweSRzjkFkmY?=
 =?us-ascii?Q?o479gFihKD4rEIzEJUf7drrdAfTn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(4013099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DzKrofacksWTFB6JI1miLaslaDKLwp+3aS0lHP8D8QqfVnFw0ljvj+mLc/h?=
 =?us-ascii?Q?x1cIngDPB5xF3Zq3qXO+WEgIZqoo9SC5qPqn5Gl3KOfzX/AWYxe8/5ry/8zo?=
 =?us-ascii?Q?5g9bmYpF6Qy37kjwjkgmW/m2KAa3c9kH0zFJnmlZbpzcwbVcn2tDxO5HbARA?=
 =?us-ascii?Q?DvI+6PdTN+1BtnwjCHqnj19LvfdKvWKxyn/O4QwedDicG6qr+5Kgz9p1nX0x?=
 =?us-ascii?Q?c+eqHf5A/zBq7tNOdnO4u4sGldatPyV4Mi0DVjdiew9y32hP7/Vv600uDQVG?=
 =?us-ascii?Q?EgAi7Ho9cV4eptqNkRCRKrRvezAl2mMNx+M1krGR0NEoAkdzewiPdzLtOybm?=
 =?us-ascii?Q?56dlrrMpyOKGnq45CDBKELzhR68MO0p2XvkXcc9PmttvBH4dZSXuOJm5ErSM?=
 =?us-ascii?Q?Ze01gfEYifKcOdGveYICj/jRqL3dk3y+8OCdE5JhgJSrrBiyy39TY1j/ZIrQ?=
 =?us-ascii?Q?njSvgKaB/gdM1JDPZissGA4gr7hDOmNVaEF4OZ5ThyFVsqk2vmFZvOcMjaGv?=
 =?us-ascii?Q?x6KWYiJ2ovJlNK0c+qcYI2dK4x6/4qK8kg8nxyt12D4jJyVTPN9PRRjvRqpO?=
 =?us-ascii?Q?mKAzo5PstozRbzkTcNajauEqrR5r3fVmkBReBSoI+bzI+kBD+FmnkbRnWxUD?=
 =?us-ascii?Q?Ic+53gD9FtU1hXJ+qziKlngsYdE1UD+6+NnOIh9FniCMwODqKwYfi5SkuBio?=
 =?us-ascii?Q?sZttmvVpUzsmNiAEmOC+1rqFUtBvHG0JHElg9zm1sFs+HCxDg5VDbnOcMYug?=
 =?us-ascii?Q?TMIXyYQXg6iGwuKrLCNi8brHQlI8567fyd1Yvd9wl1rpFBRwxAHt2D6RUHtX?=
 =?us-ascii?Q?CGyW8WZiFAZ6IgtJvoro6z8ngmHCL8WPmNs92q1cVp0mZDqMUILCkOLQBRLj?=
 =?us-ascii?Q?vh/fqgE5LqsP71yry1JotypYUxJrns3xl4yZZ5PA7I7LHgw0vDMYTfiCC7EU?=
 =?us-ascii?Q?Tgs9ojcbOMs0/9mFpi4URjmCJz08MpkwwtS6FGCi7z+WdCiRXsJPfxi2RNGl?=
 =?us-ascii?Q?sSp8+uRoeGTKqImjXqwnB35h38+nCyiTCaJDV9kfVkNyKn38nGLFVrrdh55Y?=
 =?us-ascii?Q?cQC+AuJQ8LcbgdYHjFD0YZJtEmpLQrvRHUIfSHxWp9BSQ1+lfyVu2GKLfnL+?=
 =?us-ascii?Q?xqGtV1pPYzEatGKwmmAGE1qxbMZYWN0PDJ1te7wwt35Q9sQAxazLuvHFgcUO?=
 =?us-ascii?Q?+M0YD0BQuJeyca6pK+2Tm35kE+TaJ8kUrCvGPoHwy5La1lsIs23CH3PMn2qh?=
 =?us-ascii?Q?G7fXojOuYt+zFmPbMuJz+HETG3rG0PDwAI4fL1b7VofKnsaYuSg9dvhRtR3m?=
 =?us-ascii?Q?BYrxLW/E1bK+eUwepUaP3f8UOk4cpvitV3/pEIdg8J2sA5Ty85av5CfE/npS?=
 =?us-ascii?Q?LlXfBKPNr3PggH75x6xrCAi6SGN8WXg21iMX+KKfTCki+PFj9NcxZhjQRWsr?=
 =?us-ascii?Q?LHC5A0pr/vjj8rERptMCu0/eRIKmUJM4r8N3jRGFGKA7t7Fx0jke+LdmUZYN?=
 =?us-ascii?Q?cCYVbBNCLFr0IDqTzdzxsSnXFzgOLkclgylCaN72Jm4PswCjDSLkt5z3m9U4?=
 =?us-ascii?Q?BFSOfLtSAlvlsHkBni8B1AheUeMVKSUCCXr4qiQ/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea919fdc-d308-49c1-ac5b-08dd4d5a6faa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 00:48:17.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDxOhLG9pecfd0eGAlB6h5DpVNH8P0Uxt/Ypd4cYJ/5XpvP5wJO3pyHq9cEjkvC1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339

--=_MailMate_31522DB3-C8E7-4FAD-A0F3-FE8FCE819C13_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Feb 2025, at 10:48, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    df5d6180169a Add linux-next specific files for 20250210=

> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16d343f8580=
000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2cd616b6e73=
6ca7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D012c6245eaea0=
e23f7f9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D138972a45=
80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11737b18580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/92495cf20271/d=
isk-df5d6180.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4b3656161842/vmli=
nux-df5d6180.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7fbc4e7a0f5d=
/bzImage-df5d6180.xz
>
> The issue was bisected to:
>
> commit 19c067c8a0f18b62d4a4235b0b327624c86f2e40
> Author: Zi Yan <ziy@nvidia.com>
> Date:   Wed Feb 5 03:14:13 2025 +0000
>
>     mm/huge_memory: add buddy allocator like folio_split()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D102f9bdf=
980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D122f9bdf=
980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D142f9bdf980=
000
>
> IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> Reported-by: syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com
> Fixes: 19c067c8a0f1 ("mm/huge_memory: add buddy allocator like folio_sp=
lit()")
>
> Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000024: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
> CPU: 1 UID: 0 PID: 5949 Comm: syz-executor163 Not tainted 6.14.0-rc2-ne=
xt-20250210-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 12/27/2024
> RIP: 0010:shmem_mapping+0x25/0x50 mm/shmem.c:281
> Code: 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 c3 3a bd ff 48 81 c3 20=
 01 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 0=
0 74 08 48 89 df e8 dd 35 24 00 48 c7 c0 80 6c 14 8c 48
> RSP: 0018:ffffc90004036dd8 EFLAGS: 00010006
> RAX: 0000000000000024 RBX: 0000000000000120 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000600 RDI: 0000000000000000
> RBP: 0000000000000600 R08: ffffffff822bcf18 R09: 1ffffd4000331008
> R10: dffffc0000000000 R11: fffff94000331009 R12: ffffea0001988018
> R13: ffffea0001988080 R14: ffffea0001988018 R15: ffffea0001988000
> FS:  00007f5e045316c0(0000) GS:ffff8880b8700000(0000) knlGS:00000000000=
00000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5e0458dae0 CR3: 0000000023c78000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __split_unmapped_folio+0x238a/0x3e50 mm/huge_memory.c:3587
>  __folio_split+0x1267/0x16d0 mm/huge_memory.c:3871
>  try_folio_split include/linux/huge_mm.h:374 [inline]
>  truncate_inode_partial_folio+0x55d/0xdc0 mm/truncate.c:230
>  shmem_undo_range+0xab7/0x1820 mm/shmem.c:1144
>  shmem_truncate_range mm/shmem.c:1224 [inline]
>  shmem_fallocate+0x431/0xf20 mm/shmem.c:3674
>  vfs_fallocate+0x623/0x7a0 fs/open.c:338
>  madvise_remove mm/madvise.c:1034 [inline]
>  madvise_vma_behavior mm/madvise.c:1269 [inline]
>  madvise_walk_vmas mm/madvise.c:1511 [inline]
>  madvise_do_behavior+0x1f29/0x3c00 mm/madvise.c:1646
>  do_madvise mm/madvise.c:1744 [inline]
>  __do_sys_madvise mm/madvise.c:1752 [inline]
>  __se_sys_madvise mm/madvise.c:1750 [inline]
>  __x64_sys_madvise+0x11b/0x140 mm/madvise.c:1750
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5e04576519
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5e04531218 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 00007f5e04600308 RCX: 00007f5e04576519
> RDX: 0000000000000009 RSI: 0000000000600003 RDI: 0000400000000000
> RBP: 00007f5e04600300 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5e045cd074
> R13: 0000400000000000 R14: 0000400000000140 R15: 0000400000000040
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:shmem_mapping+0x25/0x50 mm/shmem.c:281
> Code: 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 c3 3a bd ff 48 81 c3 20=
 01 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 0=
0 74 08 48 89 df e8 dd 35 24 00 48 c7 c0 80 6c 14 8c 48
> RSP: 0018:ffffc90004036dd8 EFLAGS: 00010006
> RAX: 0000000000000024 RBX: 0000000000000120 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000600 RDI: 0000000000000000
> RBP: 0000000000000600 R08: ffffffff822bcf18 R09: 1ffffd4000331008
> R10: dffffc0000000000 R11: fffff94000331009 R12: ffffea0001988018
> R13: ffffea0001988080 R14: ffffea0001988018 R15: ffffea0001988000
> FS:  00007f5e045316c0(0000) GS:ffff8880b8700000(0000) knlGS:00000000000=
00000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5e0458dae0 CR3: 0000000023c78000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	90                   	nop
>    1:	90                   	nop
>    2:	90                   	nop
>    3:	90                   	nop
>    4:	90                   	nop
>    5:	f3 0f 1e fa          	endbr64
>    9:	53                   	push   %rbx
>    a:	48 89 fb             	mov    %rdi,%rbx
>    d:	e8 c3 3a bd ff       	call   0xffbd3ad5
>   12:	48 81 c3 20 01 00 00 	add    $0x120,%rbx
>   19:	48 89 d8             	mov    %rbx,%rax
>   1c:	48 c1 e8 03          	shr    $0x3,%rax
>   20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
>   27:	fc ff df
> * 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping inst=
ruction
>   2e:	74 08                	je     0x38
>   30:	48 89 df             	mov    %rbx,%rdi
>   33:	e8 dd 35 24 00       	call   0x243615
>   38:	48 c7 c0 80 6c 14 8c 	mov    $0xffffffff8c146c80,%rax
>   3f:	48                   	rex.W

OK, I figured out how to trigger syzkaller to do the test. The attached
patch includes both the fix and the __split_folio_to_order() change
discussed at https://lore.kernel.org/linux-mm/d989ef66-4a4b-4679-b2e9-f05=
916ca3672@redhat.com/. I will paste the patch to my original patch
email once syzkaller confirms it fixes the issue.


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git df5d6180169a


Best Regards,
Yan, Zi

--=_MailMate_31522DB3-C8E7-4FAD-A0F3-FE8FCE819C13_=
Content-Disposition: attachment;
 filename=0001-mm-huge_memory-do-not-drop-the-original-folio-during.patch
Content-ID: <320C8478-4090-4D12-8DB3-FB762B049C73@nvidia.com>
Content-Type: text/plain;
 name=0001-mm-huge_memory-do-not-drop-the-original-folio-during.patch
Content-Transfer-Encoding: quoted-printable

From a6bd83dfbb1143f1614ede4817cccb1e8cc6290d Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 14 Feb 2025 16:18:24 -0500
Subject: [PATCH] mm/huge_memory: do not drop the original folio during
 truncate.

The caller expects to handle the original folio itself.

also make __split_unmapped_folio() never fail, per discussion with David
Hildenbrand.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2eda2a9ec8fc..87cb62c81bf3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3292,16 +3292,12 @@ bool can_split_folio(struct folio *folio, int calle=
r_pins, int *pextra_pins)
  * It splits @folio into @new_order folios and copies the @folio metadata =
to
  * all the resulting folios.
  */
-static int __split_folio_to_order(struct folio *folio, int new_order)
+static void __split_folio_to_order(struct folio *folio, int new_order)
 {
-	int curr_order =3D folio_order(folio);
 	long nr_pages =3D folio_nr_pages(folio);
 	long new_nr_pages =3D 1 << new_order;
 	long index;
=20
-	if (curr_order <=3D new_order)
-		return -EINVAL;
-
 	/*
 	 * Skip the first new_nr_pages, since the new folio from them have all
 	 * the flags from the original folio.
@@ -3396,8 +3392,6 @@ static int __split_folio_to_order(struct folio *folio=
, int new_order)
=20
 	if (!new_order)
 		ClearPageCompound(&folio->page);
-
-	return 0;
 }
=20
 /*
@@ -3491,7 +3485,6 @@ static int __split_unmapped_folio(struct folio *folio=
, int new_order,
 		int old_order =3D folio_order(folio);
 		struct folio *release;
 		struct folio *end_folio =3D folio_next(folio);
-		int status;
=20
 		/* order-1 anonymous folio is not supported */
 		if (folio_test_anon(folio) && split_order =3D=3D 1)
@@ -3524,12 +3517,7 @@ static int __split_unmapped_folio(struct folio *foli=
o, int new_order,
 		split_page_owner(&folio->page, old_order, split_order);
 		pgalloc_tag_split(folio, old_order, split_order);
=20
-		status =3D __split_folio_to_order(folio, split_order);
-
-		if (status < 0) {
-			stop_split =3D true;
-			ret =3D -EINVAL;
-		}
+		__split_folio_to_order(folio, split_order);
=20
 after_split:
 		/*
@@ -3567,8 +3555,10 @@ static int __split_unmapped_folio(struct folio *foli=
o, int new_order,
 				     folio_test_swapcache(origin_folio)) ?
 					     folio_nr_pages(release) : 0));
=20
-			if (release !=3D origin_folio)
-				lru_add_page_tail(origin_folio, &release->page,
+			if (release =3D=3D origin_folio)
+				continue;
+		=09
+			lru_add_page_tail(origin_folio, &release->page,
 						lruvec, list);
=20
 			/* Some pages can be beyond EOF: drop them from page cache */
--=20
2.47.2


--=_MailMate_31522DB3-C8E7-4FAD-A0F3-FE8FCE819C13_=--

