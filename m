Return-Path: <linux-kernel+bounces-515789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC0A36915
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D712E16AF9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670EA1FCFD4;
	Fri, 14 Feb 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sQLtWhsS"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B81FCD16
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575596; cv=fail; b=fjMFprE29XQhxbj0SECQBwLErDmEBLIjfLfWMbZcphAgR2fHA8pkq17GrmEcuKt05wIU6N0bmHcaix+h1Nkb/fTOSvuFOQ8QCi2syZ32hRIkAem8eNiNxAL+FxkJMjkxXmIh9MShfClEgyhilsCOY0H+QOLPFhp2XioU8hYe2PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575596; c=relaxed/simple;
	bh=EIY6/ZrNfs9jNmOh3tYtJFVUENuIA02GNK+4avGLcFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ij+LjyKKNqn4/1i35oOow4RBwFelDfvggkeTCXLYbz0j9IBF3Dq4LaSx2gGiQ8C51p5Gqbo2FuQg18b4n2H71iFhgdkkPBjj5VOjm9YrrTK2X/FBBBtwe5qPezRuaQ+r8HzC7s/z/oa8L9cPFZc5N1X0dYocN2vkOm8AMi9TfLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sQLtWhsS; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amIpB+blAEY4OjlgwJ9+7LlN7WCvoMKjlTW8HBZCK2n6Fs8yl+vMs68AT2u6hc7kt23cG7OUr6PM7ixrhGHLo8aJZ0qYj/nYYC0Ll+M+UrXeXiBYKmRx8sSDpqTufdL27RSdXQqameDlWC5Po3ua/SGAaVNOvqux4D/V8EBlTVoGPdV1PQjGlx+Rkw5fX2ZCe3WQgeiVAlVtLev2zBhWdpxlN/IueUi91Nmh/lbL0Z93jcqNnNBO79tuD6uLBk/4Cbj488eLt1o8j5fvLMsX0bB09FbXekOwjCggzkG/u5LSlZrKSarl4hAWcQHzoWYsaSW9JUMpIkIYwrPG3Wwg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jqS9iLmm/KLK00rrZhbUwjv3VC9DkYf8jKK5HMrkxA=;
 b=Fz+0ysocKadDu2JaBr86WnMn6dgphsM45EETpPYtcf1wab4sZGi58B89cUk56qYGo0m7qlPRODEjFTdLGcFpernheqHQEqHAOqtGGAJhQYlJSAXR9dKlkARdOGUva+PKpKdojxregUhjfunyl+rOWmUQraP+xmsIlg2Ey6qEVJf67o82xPLzW0wQS9CtuPualyZF3lLsYNOzL80shQx8Y2s4R+3nao5pCADM3w26okfjcoTnP5dIcd4tE3LNaktRwb1icqSOqhKhsMIrTv8XTACLpMIFsRIaDXly7MF7DSTJNN1+CLxalmM/NrHiATNAEg68aaa/Wqbz11sB8aDIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jqS9iLmm/KLK00rrZhbUwjv3VC9DkYf8jKK5HMrkxA=;
 b=sQLtWhsSY5CNFLWoX+SX+4UAJ1ox22S5Qcxr/aAHfmPRwhcZQNrr9uy3jpYAv5dDRp8CraN/F+KsnFB0oFisbbyyHuubMPe2dAuDVn/bQ8mB96EN1civQ04f0f0NUKJ2Lbgk0L5kHCRWMlopMdg3g9rX2bQ7Ep83aASdoWDcHK1cKk5ImSshvtL10aCnr8BAqNX5O8bQYF9mz3S61kV+Wl0HWcGbO8wmZTCZPyrct0zfBHK08uJcgwp0zPPtGFosz+X20qqUVW4VErfuIANcibDXZCENYWiVDvDtK4LzL2C5QvjM7P13FZw/G6yF1Pb9/h+EZXzH14s6IV67LBrBRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 23:26:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 23:26:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in shmem_mapping
Date: Fri, 14 Feb 2025 18:26:25 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <742701F5-3B2E-45AA-BBEC-69C76E49E3AC@nvidia.com>
In-Reply-To: <67af65cb.050a0220.21dd3.004a.GAE@google.com>
References: <67af65cb.050a0220.21dd3.004a.GAE@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f3248b-d459-4933-975c-08dd4d4f0256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E0QbDdlcAnLtnwZ+6/ReiooggT0l6pvvN2SdnbbLaavjbEvVgoxQSiNmZNfE?=
 =?us-ascii?Q?9WWFDx4TcjkWpa542HkCrQF4dq7V+UnruR9AodYM96gcxaT1/hx3+Uhm1Pww?=
 =?us-ascii?Q?gE6vR8ap4EygskkMXEGa2kmnambkmUm6EtvcnBk5ABIC2tCUR/0lzi7oQvqf?=
 =?us-ascii?Q?zBZWBcbECqCV5CR2M6ocZnmUQ0SDpeOj46rJIU07g4CvuOAjeOd8qHowvYsC?=
 =?us-ascii?Q?UlfmRp6fI/3R0gGhfAJdnzyZx991rL3LLiQczPI45Of8vDeOVOXiYQH3xqk9?=
 =?us-ascii?Q?McaJcYRtgERBaDdqUtgQQ5ae+aSMfhNfmfJbDr2NBcxDfW1hBef4kEjLZMzQ?=
 =?us-ascii?Q?4tNDdN1xFx3tID16iXiUKZk7gzjwxhBSA5rgril+5oc+R9X73YT6rRzzJdKL?=
 =?us-ascii?Q?Ue5FUFICkgKKQmCX4Nw275EA7BTwe3HbHcUKNEaGMxXR06ehe5muDOob4Tfz?=
 =?us-ascii?Q?d1pw9h+aT8RnzeYHLXAmovq7CYfFsITMrZbkHF+4bNIGdvSfm9uR+PxrIV7l?=
 =?us-ascii?Q?4p8/isuY4SQrCTGaI/heWWgVXtX8j5GhQ3MA5YLjcTJ5XEAwzhOPjMvM7ONY?=
 =?us-ascii?Q?6QdzjwpASlV8ZzvJ3xh+KCKTnUyLSSa4V16wEjQH7pxQ3YZmP49Mw1YSY1a2?=
 =?us-ascii?Q?bvRHuuJKdOEj96W8dQfPTkInD+DmlK3CVUU7jwBYnNj6QRGF/OpK1+wdqpnr?=
 =?us-ascii?Q?m/oNhrjF+k9YsbDVIdhuYsCtQk7QjbfCYtxygMPtzXR8TkvQrGbw71j6cJ/Y?=
 =?us-ascii?Q?qBeqQVF+AN2XtnsySJ1sbBJwpgANOKNxK0ZL/TKf1TjQ5zo7OZqaW7kjXQF9?=
 =?us-ascii?Q?xKTzd4dLIiGx1oPYk1y9FC0n8jZV7OBdEG5uq+Y5AUK6q5Nke+Sxbvx0/OND?=
 =?us-ascii?Q?/J28Cx1UDrnopxxg5Qmy2fpjv7d6MmyQmDEFcSPBjS7AY1B/SyRqsz+xKgav?=
 =?us-ascii?Q?XAnlzPKjcE8zJEVCxuqwo5ZN70D0f93yU1oJk5a+sf2F0H7MjQ+cS6T+E3o3?=
 =?us-ascii?Q?5BjF4Abc5jJIAtPhVFuByC0/V0KMXsZJWeC8qZ2ZqMSY+sfOfQLU3W9YG2xZ?=
 =?us-ascii?Q?KnSrz2N8+AdUPKAyS/jOcdxy/J67sQpnJLCEUYbfSj+5+cdl60FvIvCBdRjv?=
 =?us-ascii?Q?SDIUI8x1unr8v4jeD0CmrxbQRYcBncuLcwxJ9cS7ueQTfi6qWEKvrktoPDxb?=
 =?us-ascii?Q?ijiqTGyhab8kJNqTRTjgRx4MmD8X6mhK0pgcGJyN7+ES2RfyhMXRJP6T6mpf?=
 =?us-ascii?Q?HdG/jG79eacs1+DlXAuRN/lThIihabx2VSmYLRqrKlrsnte9ht9CZNWfLkUJ?=
 =?us-ascii?Q?3q76llbWVH+38wyIF9uUaN4nm6ylAd/kXqQY3m1QxaLTiJgWbCZCRolS9Jqf?=
 =?us-ascii?Q?JgLmLZNkOdrGfJLIZr9S3yR5CXZm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KI/Ilo4owBvrL0l2Ps7gxax6lvUtTgPNd3Vnl5UNnRoLlFH0+bT9D997TsH7?=
 =?us-ascii?Q?RE5+tbMchI4exJzEXpTRc7VCe/VJqeeQwzvLMSeUbeWEXq0Ub53jTtXmSpZr?=
 =?us-ascii?Q?h2yFbKkTg0Uhro4ui5VMFw6HXyDwZonKapEE3UNjBJgLBe/YJVUuCyDBxQxT?=
 =?us-ascii?Q?FQcA3SRyHgw9/Og/VmYpAhSu+NNWs3whZxO2ikBZSJZ6iYFFz1zfYcsK65BH?=
 =?us-ascii?Q?0weF1I+gvHYseYzPKAwtiOkLjhxz98dT4Q5pfQYw5x4WR+DwKqB6ESVLLSXJ?=
 =?us-ascii?Q?wcMlOKF8JWSk4+5RdpzeVVADq0nhPGHbNkQtSZF07bMq+LccH2IDyJy0NjJp?=
 =?us-ascii?Q?XsSXtmcB2J14MaZvU0z6VdP0vesDV7EdDLRSlizdeQWHZ8zfOMaFrpn9vphJ?=
 =?us-ascii?Q?V4GOEGWcK/iaE48TnQ6hI1UpfrfoSRykhOGIq8of5XmGYqMjLD05rCbmmaYm?=
 =?us-ascii?Q?TWdkI3NJwIBp45olQtW7KPBsqhvGbiatpZXkpJh3aXhbtUYwZ+GgJgbRvGvR?=
 =?us-ascii?Q?ega5x0Ob+zsVgStOyHHmfnIMGE9qDbfOhMi23aaVWMHZZLKhIK9rfSP3+fGC?=
 =?us-ascii?Q?CW+8eDilupa9LbccK1FRSXoJmkgPt9LpkhnjLYVQ6zmNh6J+n+AERw3QzpP/?=
 =?us-ascii?Q?k5HoijOfgLU/YsRH57R20tNS+HTOBXc1ZcaKP3xSTTF2GddklhSv+vI3u8BG?=
 =?us-ascii?Q?TCyIuMEIdZpSMfAmDSJPhbss9/7Rd2qI96/Ii3gynlGA0zlFO0HuzwC4hS2i?=
 =?us-ascii?Q?4AdmDwO4jDD5Jyxw70DkqaRQrnuR3IijRXgV3dh1mKyo/hwcPVjBc5Afy1DJ?=
 =?us-ascii?Q?PFm3WiM8Xni/LGeGno+cUKOg1TULTMLP+W+EUYvNU4+ySBxFJwRCiHl+/JUG?=
 =?us-ascii?Q?lj8aZ5ZdpPN2iprLkzYiAiYcUBs3em8+2vuA0p6pNjy4vdfhAHFCxya1s3Ui?=
 =?us-ascii?Q?0defoZoYDCIG+S3WrxFLdsz4XIG91CMUVawXEfCpf8p9Merln/nTWquKyWg5?=
 =?us-ascii?Q?fMkJw20b60X4W16gLYAkUj3H0crJalCLpGjnEJGyQFHd+eIRt/JCEh2TTk4y?=
 =?us-ascii?Q?G0lEyQ1EGFE/gCnvEPBxZVlP2L2+Qbk5A4M+eQknx8mUbFqLKtmtoiPmETBY?=
 =?us-ascii?Q?SZMeoCAY6F+j4Z4YJKgJQg9qhTclUFYP8KQxFUWWhXUaLT6Nltf6gGir3H48?=
 =?us-ascii?Q?ONSAaDZF2+h4w0TrgWI4WvktzPDla2dSEgun6IdXYhOvW6FGCPDCMUAXz7hy?=
 =?us-ascii?Q?yESsY2f7usayg+6umajrCYntrmV4ZlAlQR33kOZ6LVqFLFOcIbBPKtdIr4or?=
 =?us-ascii?Q?ugxBUfq5K9fGHSNb7XTUFMiwsERGz1M0j9ZQ+3cbeOr93DwxG0amebsseSp7?=
 =?us-ascii?Q?u7g9sxpjxsvZt1fWLqcRuN/wOVcexIoa+RSky395HWAOIo6NsUgD+04Y7hOm?=
 =?us-ascii?Q?UVmUQR/q5wlQd+Ux7iVnysvkxYnu3BN9KeQcx58lPH8svjBA5vh3QKhsEH09?=
 =?us-ascii?Q?jI3Gins42bzSBNfk2OnuHYI1We6FH6l1RbnGKuKm5kpdh0BWDCBCCUN7Pat5?=
 =?us-ascii?Q?6EX0EJL3UgJlPOI9jGxXMhPRfZQRDqa/fzE245RW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f3248b-d459-4933-975c-08dd4d4f0256
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 23:26:29.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NzieQwdtvOxpjHP9H7w4acicwz2c/++v1LqdzsKfpWRhbyUWJhHyp3hhx48r/Oq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

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
>


#syz test: github.com:x-y-z/linux-1gb-thp.git syzkaller_fix_20250114

origin_folio->mapping becomes NULL, since it was dropped, and the remaini=
ng
after-split folios are still trying to use origin_folio->mapping. It lead=
s
to the error. And the original __split_huge_page() did not check
origin_folio->index nor dropped it. __split_unmapped_folio() should keep
the original behavior.

Fixed it by not dropping origin_folio.

My local test do not fail and I am triggering syzbot to test the change
to confirm it.

Best Regards,
Yan, Zi

