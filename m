Return-Path: <linux-kernel+bounces-515533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7CA365F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F144E16F012
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E9194C96;
	Fri, 14 Feb 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h4TBdTbW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E73134AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559441; cv=fail; b=L8OleYxS9P5Bm2NlVB3FHWTyiL+Kg3qmBPiNVt1vEpAXpIebVHHOrO71pBJtUkXtjaqrRS9F9KSJE2Ot6osd1ac8WA1Lb5VDz/ol8uJ1OjdDSCAFhTeFizfxSMkRH5NkjroebUQxJ5neQs9mXo196niSRk4Acjn3xtLknbDnYUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559441; c=relaxed/simple;
	bh=5B2X5GP+kl+jKbDv6iBt9zlvwz7R7lje/zY9Oor6mgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzRs9jf5O1AHPRNOddM/kV0Hb7zUc5StgF2z1WBTFvZhYtuO9gzuy3TrKcGZqA9PjKwRPZJJ10qq8zCIpT7nX8mgD+K0nT4syrBoyj4BFQA3bADA+Ufejf5/3pBBslZyW+ZlLxRVOCB/XKTrLem9DJCtskl+kNo7Xe3jEfNdA6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h4TBdTbW; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JyicQuoDU5lxpHeSQ4BwXmAEBLprK6hVgBOGD8L49erdkKmM0QbsHsUmlkKdnOhiUrKyOgXyYV8UipazC593cw0g8nzUkNwB1haeN1bL/D8rReqCSragmofADvePU/zYxQPYx7o2M8BIO729HRgzQU5aTRmI49GGwc7WE/R7nqNpQM4GM8QwtoQ71aroQN1wiDgBxcFDiC91utOCA25el51myA9v9vyt65IXcNBRBwfflhZ/Nb/lDCWokG+NIin1KwwPbBTyWGofBDH2BwL3yjsSybpzJEkToJvT9u+3KUkDEeSwh2QuVbBKzrRtTvPiXZOiv7zIX9JtQDBIG7uq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e7phprRZ1LCBtQG5v/ZVvVvqhF9EWPsDhoYrJp7fb0=;
 b=nQEJ5Wfcz2U6lGKkDzuWQYriFMTiOt1hUZZCHA2TUW6Ntq8bcYtWhJqhD+BCJuPz/4/9GBcPRz36yahfWQKYen5mgFkoo+utU+Z9EDsj3JOU2pjnM/f9ytGzFNw6MmHlzDMEBsUZ0uTmz/ZlU/WC1u1ye9z/AXUaw4gFwt2CLJVTj2oNyqfQOllhM5LngY4309sIXOLM5TZLTBDgGA9XUAvvViLtjdx0/X0FYaQPugT6bYNTD+9ZLw4/yMCXnUj6IT0BRCP1+jvx+dRncWVu7sBAZn3M+70ExUM9Te/ryBp1GuBCy4VAl6X+S5RJ6gFgkm91n3CwVbaNOiXVhon13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e7phprRZ1LCBtQG5v/ZVvVvqhF9EWPsDhoYrJp7fb0=;
 b=h4TBdTbWgvFXR4LHXPSpe4PJo3/w+TcVYQiVlzxQSIYxUU7t5M2CY5ZHeY//b23s2639gTUsX5J2wC68AlFVwDGi3e9GxkW6yCa96F1VPXXRiOyo3UQivaw+ESn3dpUDh4pO+ENzzn1+fJPIMOMAYWy6/2Q9vB0vCjwfmbMP6ovTifrC+qamQ7nNlZ0qTZ7GfVG+J5IXnUckXazKUypskCmVIkW7t/HxiRRGMt8NkHiJ26PFmoX+Dj1021VHoPEeS3nbrfOEabcd9nLE3YPqJulSWLkC32VXWqNyDKNcwu+W2K6Qbja4RCNzv9moLFV6Zsla4Er2B+Pnr1IUMT7avw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 18:57:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 18:57:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in shmem_mapping
Date: Fri, 14 Feb 2025 13:57:12 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <D434825D-8201-4A2C-A65B-8EB8A3069B89@nvidia.com>
In-Reply-To: <67af65cb.050a0220.21dd3.004a.GAE@google.com>
References: <67af65cb.050a0220.21dd3.004a.GAE@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: e2241c03-da2d-4039-8360-08dd4d2965e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZKbzyajkcA3RcmIYLfJgrFBkAMJgVc77tBMymiIxaUeq5c8tWEmsiiVqeAo2?=
 =?us-ascii?Q?M7HV4GlWbOLxFwDw+Q95ic4xFVboLMZgI6wLpqLdpgPEYjnTF0NzsU43NshX?=
 =?us-ascii?Q?6VRIC0PqpTc5NmQusPAUcF4wu/XRuwf3AFEnqZP8HnuihAyHtWFVXOtzg9WU?=
 =?us-ascii?Q?oyqCQZszPTwSqGYeDNNWXiuNFJgRLaNPVWeLuYSDSSlDyQu53H52R6X99B1R?=
 =?us-ascii?Q?keB+KuaX70OV3Ru/si9rfJJ08SCl1xOOvCOlTlKs40txBgxxVawf3vedf3Mc?=
 =?us-ascii?Q?RlbCGQAwb90wXa2xPqdadQowVlVeUmTuuIbds1ai15WGs24OxD9QpFHc4PY0?=
 =?us-ascii?Q?Qz1ge+N6o1BnqI33Cyb7TCtokwbV+lMAXRQ6SCtiaoPsMFDRlG1esoRJBYZ2?=
 =?us-ascii?Q?ouM8a5jdEp0C00qfzvifx9iw59NPjaG6Sr01ja0vTrxJBBt6Xs5CANgUKGFL?=
 =?us-ascii?Q?rvYQzz30gRddR5/UZV1IuCllvJOW4iO+nk4iT3i/0RjQRpgkkG+3Qr25PHci?=
 =?us-ascii?Q?Vr9xz9HahNTi/q+gwrKiY7sFaqYWhylq45SZWkRbeRC3jESAqKpTb1afXEX4?=
 =?us-ascii?Q?asspF6Ca/QPD3v68tCZMZIAD2Nsc75OeiF5LLtCjF+ZTCpvSn3MyT4ZegsvT?=
 =?us-ascii?Q?xFwz3/PvYrd7EfiCnBLqEk48dEw0I4RCJiIpRx9EXFFz6FloRMn8tZGTzw5Z?=
 =?us-ascii?Q?wBBGOjsFJ7rxOUTTMjVb8jHlLGSFy6ZIiHQtvzv+uCUNCGO81uB6VClZWEsM?=
 =?us-ascii?Q?Cwz8BIftmPgZszzvCA6iDcBwnAguZ/4nrTOhwSKEID7S5LHMmiRezjKSZFr0?=
 =?us-ascii?Q?iggb8zkvcMuVFHUv9fiBg1uF1UtqPnXeOmF/icktTkwi8fm432mM9Aq6bF+n?=
 =?us-ascii?Q?ruSUNeMu3eT9TaFOnNJlCWhVAUK4e5pBIXRifnwrYOQtvV+/yD/pt9Z+qOOA?=
 =?us-ascii?Q?T12GWye6C8XDiWnRAi1m1xmKVqTB9xmANY0wBGezBFyMeO800c6bOHihjhaN?=
 =?us-ascii?Q?Vs3rscBNtk+y62NlIZ/t6qAd8Bl1k175n3USIvQSvHXatbwafUaysjPG3FUp?=
 =?us-ascii?Q?NFH7/OgipT44fO4qe7YOMYhy3ekxNFNfA+S9/ndyC+bV7k062tWNQhD4rXsp?=
 =?us-ascii?Q?ShBnhLQ0oSVvb0830+fIYzNUrwxgSjaVWcMDK0p3r1CTWuKp8J2tH3Z2g03h?=
 =?us-ascii?Q?25wxH23o1bWb1WBif0RdJX7fK8hNNCnbECUbcGFhwkjilUmT/P13gqDfvFiM?=
 =?us-ascii?Q?dlHDlMLBomCkeBJQK5XaZ5uMSmLIuCihIoMBuNtSzW+At4zlhd+5jGWbagiy?=
 =?us-ascii?Q?vmUgAogcqPS/ESHkT544khBjoLg04692VvBQQj7C1PNtFCeRE6LYM06P5LLA?=
 =?us-ascii?Q?eMZ4E2miHKQNERlGm3vBtmpVh8pb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4o9GjjSbxYNQDl12BsolBAYh4ivfVmvR+yaOXHoLHWcO+Hq3UPqpdph+IRAN?=
 =?us-ascii?Q?aN9p6b0fcd15LThRnUcyR4aKjXFbO/uAqDFCJ0kqpSM3qvp+MR5SouH+yV5w?=
 =?us-ascii?Q?l2vPdigjayKm7q/+bPz5JYUyQPQxgB+C5qc3ucagan9jS1sJJpBsX/RuNzdZ?=
 =?us-ascii?Q?VYV7J0baC2/5sy9CEsmXc5JXUkGNqLDc9/sssdqUfheD3nE73vFo7iPY+wb5?=
 =?us-ascii?Q?39rwFY7foBMCPxbWEPTNtSH3u6jaBV81LWkTfRfs9Dc2Z85Ka8gmJx9vfvwW?=
 =?us-ascii?Q?VuVSRJK0Z00bdJEGpTbO5fvU1sp46HWay8rxmGGWmCORIderaP7UN94vMC0A?=
 =?us-ascii?Q?mV9/rdUTFpSFdaw3I4Dlr1zEmbWH2k8ZkS1nh5dTpikD+59jKRHpClo+GChD?=
 =?us-ascii?Q?SY0m2SUGtWDxTzuUKzf7m54xkRf7wX/ZmRCIJeI+BGIRvMW0KiD3LMsKnq3W?=
 =?us-ascii?Q?Fb+fyib29PuPIqSrFsli6bFg/Ys4Ater6UJ7PGsEsxHPKXE5TJ8VjYIzQcRS?=
 =?us-ascii?Q?gciE6eDG+x3b086p3Eje0/HHIifo1NgdMbRwfNZSHccYYomTc3sJLQlCqT9F?=
 =?us-ascii?Q?pK80SYj6j5UUNo9MBGY0EnOd6BIUwNTNNc5nfl29jPWI/uQOPbn3UoBSnPI3?=
 =?us-ascii?Q?gvjlVHqSXaRgralJoSCayGU8UFk07FEETxAaC5PKOFBS6tDUcANEdJ9yfk/z?=
 =?us-ascii?Q?4/Ue6hVU+q3XZ8D+zCQSLINye5h57atFRM9CPgM2guFnaTkLZlBxRn8x+Uq/?=
 =?us-ascii?Q?stpFhNN7ufaVGWpl9pE+wvUaMmJn7S3JoCXdbsO5Vsf1araAGVXFALCCgnmy?=
 =?us-ascii?Q?KRWpEGGeRouQ7aPmmP+cL+neHpbOr/eIA1mAw/2ucRl3dhSFhCXltpC2cplh?=
 =?us-ascii?Q?7fmDRWC1vv57q7FpOXhoybxmGuVr/8UG2wycZNH/ZrP0OPI9RC8lL0d88NAW?=
 =?us-ascii?Q?DaJYTWiIRYaCvVRv0FDLgO5QFCZVI6sCN//n0nc+e9tK4sEQAU/ggnvKu5ax?=
 =?us-ascii?Q?Io2dWDMvYXMm3Ae/nm5MRgs7N9NjvVbGe+AIsbM1Sx6EprNG4AMEgC0q2PQr?=
 =?us-ascii?Q?e91ofZqCvI05sGtAq/Ai8OzznlbxTVGrxiVbAu5XYcFTgN/9WPYYpJ01JSWK?=
 =?us-ascii?Q?w2mYVcUlqo8z4nvERhvvaRFQxcIjMlyFPlV90NZTlv/YERGwOkYP604ZR+WA?=
 =?us-ascii?Q?ab7H1PN6U9QZAEFDUSGFkepihs9GGfN6KNHEAIrs8UZscQCTMXY6pvmowdQk?=
 =?us-ascii?Q?R6njxfSvFQZYYroDP5jgkJFp4AjxQ+lryF4ctU9Y689XFd0leKMude1MRFJ2?=
 =?us-ascii?Q?9gDj1sIIZPMfUCo/J4NUQiWlUP3fzEjXp6Uzq8G8oceyyNrCcqZwKP3sGal8?=
 =?us-ascii?Q?WYoeaONzTrXOrBBT0Q0rLMHMeEDqHe0ZZa6tHzXf209qhWEfshLAEiMv+hLK?=
 =?us-ascii?Q?103puivckWgFlbHpxBcrPBI0EalPv/vC8FTZW8yM74ox3CKC9pCqaYvhoLw7?=
 =?us-ascii?Q?g2ZdXhFw9qWpxY6Hk/lvegHxsHRyYD4dyMVsnc3JMjZGVd+/P+jAlSivGxVZ?=
 =?us-ascii?Q?zlGj/Vt6EkK+t/k2YfYcpgYM5/oGjZCsXm7RmVuj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2241c03-da2d-4039-8360-08dd4d2965e5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 18:57:15.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5L89bFvUpc4R5NQ4txwaHWGoDLydux+2rrnTvbzyUREdxPVz0eWq7jPjSPmuRIOA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

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

I have reproduced it locally and am working on a fix. Thanks for the repo=
rting.


Best Regards,
Yan, Zi

