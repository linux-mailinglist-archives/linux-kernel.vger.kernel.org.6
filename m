Return-Path: <linux-kernel+bounces-562783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9F0A632E9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B421703F7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92941C861B;
	Sat, 15 Mar 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="llW6p7ho"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2127C1C6FFF
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742080204; cv=fail; b=u0894wDi6t4GgP7vrlALmRtg8tCvj2VEUSA/jxbEPz7LrrAp9imfBm3CSkPf1e6fBKkM9PBPwJEZz9Z0ti2Eofy9Psi6IgBPPIi5IzZKXAl5L+WCTWMFdpEXV6sFDUWPBwrup5JWBVPJgx+asfouLk9rNkUnVgRf3/OIKvgb2lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742080204; c=relaxed/simple;
	bh=+v31xkHXTtEtoCtbTBvAUCwKOd54OhHSenHJxS37Y6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p07Ea7OR5SKa2q88YV87gnqj/dnPOxtzuBGIB4u3XkvpCGO4sNmjS1qJ3HxpMPZKV2Y9AEaBLBe3CE7ZenOp9Z57LLLUo10Fo7m5IgnBf7d4g33ooiGnwfv8LSgi5kGvDR9lKstudQJ0aIUJntXoabnvEEgDWXCgApyOFL61x6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=llW6p7ho; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgYaHW+by+refcFfMwPJ+1+uz/mVOVW52ig8iZW+K16VA+Ne/QjcOg3FgZuPOAPpysFK+uu0y/LU6RtnrvF/fm9bJc94f6JqCgEJ69RFx2maPtbjauMcrZbkwGSxkcLLEj9yHZsoneteTZ8Zw4WLyGztvjtOobX9MBiMsfhqefEzRFukwqzV4WD+75K+yRC8bBwn35BznY7LUN72RR6zn7jnSmbI0fWyO0h8Y13pXM982Eg+gAHhllF/3oweOrKaclc72qdpWX93z06BjpJG+Q3gyRNsQNzMRdKSJ3AGdRTSThZywYMlMHLxRXtITMpHJjfIFKTHkGxqA6wGP9acbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v31xkHXTtEtoCtbTBvAUCwKOd54OhHSenHJxS37Y6w=;
 b=nWCBDzdv/S5xrDRQLlEYdvqNfUOvEF9O4r7FXfRGc6dPWnB7TFdWYNcIsXw3GVGJK4RsqI1NdNDrefYZATYqgMJoTutfLcAs1I+lPZme29F0XVWSDtBFrLSWJbhQSwt3IHgOLAu7J9INEOR0rYDAt+IVyZ04vo0pUGWBhFpmSn25GbyqX0G5dh+4X3vDSkAR3HmPCpNoLqcc07Mvn/tQN3aMWcBd0lJZh4r838i40P/UYSTaaUt+Mzza2hqGGDAsnp5b/6cFXmiRNEwdj74VJ8mAMUcaWATNEirVMKMwTZh/zK0gkxdaHrPr9xjn9KjPYTUqXaOXm3WCAnCkt718tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v31xkHXTtEtoCtbTBvAUCwKOd54OhHSenHJxS37Y6w=;
 b=llW6p7ho2yl1YN+pkMdFsctDeaT50AYKX5U/V6fZCKe8hIC6kqC6VjPRm8+jug/9YXaOFbkM8WYVE13qLsCZuu0kN9eKgw3w7lFfhHU/VAUMHXzUzu+2HxXvT9ZrLliPV+W0cXFCQqsGdSy+9/YhfFHDIfuzwfuJFoY0d//IWdmwok78UlGCLhsiMvtdoZxctSHIP2IiQK6c9dZhwIPfyoA4OeHETPBF99l2N1cmLW8cHJCHFsXgb1sH4OVIu3SlnwYc81rtqhUYGxIyLvfTOuZ5YJ7mFUWVbmQdSDxlmlix5k65Z5HWle74O6FYQetGhtmt+wfEWs852KdCjKJH9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Sat, 15 Mar 2025 23:10:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8534.031; Sat, 15 Mar 2025
 23:09:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Sooyong Suk <s.suk@samsung.com>, viro@zeniv.linux.org.uk,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 jaewon31.kim@gmail.com, spssyr@gmail.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Date: Sat, 15 Mar 2025 19:09:57 -0400
X-Mailer: MailMate (2.0r6238)
Message-ID: <D01E015B-BA24-41B8-B179-4D24EB3867B8@nvidia.com>
In-Reply-To: <e8996592-f7ba-4926-8556-1fe7534038dc@redhat.com>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <Z8tVrOezU2q_0ded@casper.infradead.org> <Z9GmYe-bdOZ8LQV5@infradead.org>
 <cd013218-7735-4bc1-b6b6-80d1129e2b76@redhat.com>
 <c45e1bf8-f91b-4383-8c1a-7e11be02743b@nvidia.com>
 <e8996592-f7ba-4926-8556-1fe7534038dc@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:208:19b::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 205ddfac-38ab-447e-6fc1-08dd64168268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vQyYaQQSc2Hbjw9kWyqVgm2tKriuJccalA/OYte33UAvLPH3t12ynRniEJYT?=
 =?us-ascii?Q?Emo25m0dEZyT5YFzFWd4Xhz6g1Qv2+SVHMO2x5eFCbMIfYCk2ykzM3ajHtSe?=
 =?us-ascii?Q?kZNDKHJaaaHjSWjRibaX3yn6GixSHhMdkHxrt7Q7yr8SvK+WTYYQm6TC2qoe?=
 =?us-ascii?Q?Fv7VVcuJzlUCfE60zcKIMil5EfLwJKdrNaNHNwUEEwBUGD5GeEGfSodAXJkw?=
 =?us-ascii?Q?jdF0e1mZtrI8+Ny90KsNarFjJZW/FmM3tBN5fbhaO8Cb9GapT7JYL4fGzBrb?=
 =?us-ascii?Q?nqldOLAKkHeTzk/HzdktQ6ZZ068k0IDSphYi6DtGkfDdX3AUw/oXF7lkqYLF?=
 =?us-ascii?Q?9mdt5o+ETdiuxTIvgLB6BuAYz2tBxkf+gwf6fW0WUgW7XELVRCW4qf+kLkYr?=
 =?us-ascii?Q?V9LowvzWXXfg5ChRfXkolUuj6WN7/Sig8J2mpTcuHEcNxnJDxLt4l/OkArqM?=
 =?us-ascii?Q?+8+Dyo8ptcGQlTx6+hGf/n4S2gM3XW3gbzzQcFyWUjAE0JJt9hLjy86cI31u?=
 =?us-ascii?Q?4vWEITyXfpASGR+cXaJ/wPs0+OSvREyMcE2SWb5AwxJI6fAHDVUC3bt2iytF?=
 =?us-ascii?Q?hVqDrDO3zljVAOjEspOTBo8c6VXKxvrX4nv6LaTBrFifPEryGMkPGw6PDBmk?=
 =?us-ascii?Q?LeJUMJ3M8+Cn8xZbDvwRfF8mO+c0Hmybt2FNcQ2gNKLJyfW43NE8uWIPpOcB?=
 =?us-ascii?Q?7YUlXKYtSz45R6J19Gf8otPgMXEMbxXLWQXaWb38xbvdFngj03SZEL/hf/ya?=
 =?us-ascii?Q?ngGloCPNlGL63D0EWe1r3TnMLLtq/mBGN/aXO3z2EKIz3NxJUQ9FeIvFOPgh?=
 =?us-ascii?Q?QvnHzH+pM0a7VRFFk8ikDO6l2goqHbu1m7lGFO2wAUuS3TS1DT0Wx8Wgx3hV?=
 =?us-ascii?Q?o/GQ430A3jUya5t+TwtObpzlbtzLvRiBDDfvS0GhjcQmlwGS2GWRba/mPnol?=
 =?us-ascii?Q?QTmZAP6YuvE47KspUyQECGMRnlE0Ud0yzsXQI8PML8VcMk+th/3eQYWdVGXA?=
 =?us-ascii?Q?5PPOXDgprTdrMNqtrUsLV1kG51KRJO/szCsyrCJ1HvBaLQ4tNi9cq0JX2y53?=
 =?us-ascii?Q?EINUkwKQ2wqGLWvwthPSF/EM+A/q7wy6lDEfZ6vE47TOBtgSbhY6WEVlUew6?=
 =?us-ascii?Q?rhVFB1jkgzszb0UrfOTFVfHwOEahlFik7sxr9yikHsO3KDRQbNowe5Y1tOkX?=
 =?us-ascii?Q?oVu8UoPlXCb2NHqUPH/So8PyjlCE0sGPm1oFwlAmDzkt+AoBReeVIitxXts4?=
 =?us-ascii?Q?6xGZ2fTxbJylJXGvJGZfaLUcsqf2vsQqY8LHVLWDckll8syBVJGJnHjr3rUj?=
 =?us-ascii?Q?uOIIK9Zg1tX75/Dl3CB7SS1M1CAKc+5wFigKOQANB9inLGGNNqj/dtM3uZvM?=
 =?us-ascii?Q?WUvMRbq/glfPUFNGB+MmLiBibs3Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNRsRIjJfysYzkwJpPusJdjb1lbHHwd5KLHCpMROoHmsWtwsYl+ldWG2tRqP?=
 =?us-ascii?Q?rtHNNyTrqWWVogM3vuVFAadnH9g6E3RT0+X9Vx6Zsz3B16vTix9+2GtLdHmr?=
 =?us-ascii?Q?3CvUTUI0OO0cPoC+fI4s2RW6QTw0Mh0MNSkGkcP8TIT92eKfxpnDZuk+9zA/?=
 =?us-ascii?Q?OlHdtiiLtNnUmM0wpgv/4+SyTqRnLTiI+3g5MBSqkpkXZAeTMtRHp14xmGSz?=
 =?us-ascii?Q?mCD5PEMK0FaNG98oH6Cxu+2xd+w/NeqhlmulPpUmEimCVOlZ/APQ4oD2IEZ0?=
 =?us-ascii?Q?a3d0RkH+Duv2/QRldvp0JqlSTeXLghYLhmyTG7k2MNBNzOBUkuh6KT3tg0gv?=
 =?us-ascii?Q?T0HUYQ90O/eALz4G0Vebj+Qi/h6cdQ4OwqGWzZdzoCvGIcazfsS7xhbN+0Cq?=
 =?us-ascii?Q?1caIV2C3rxeG5jmJteCza0JRSspKOSWmv0ODc9NVtxR4ST2aOhptWm+g2v/i?=
 =?us-ascii?Q?egqrg4kyTNbReFgEE7IB+qDwk4UfNSCdhUqGp/Fcef5YCcJGgGMSMueQbvvM?=
 =?us-ascii?Q?gAGFwLTyTy14XrvLwj47Ob1t9pav38kX7ulY5l+CY4/dWzuKmd7jrvy4fUDn?=
 =?us-ascii?Q?3az6xc0Gc+a1Q6nWb5guXesg96iTyJ9W6+pGwl0WdMrFK/yb58lLNuhvLg9k?=
 =?us-ascii?Q?48mbMn2kJ+qgmKqxJKa4UzTHFYm/uCset/eFCm+NwKysxuEj/V7EeaEyXak+?=
 =?us-ascii?Q?Se8p6BTughz9zJ+7Px3lrRF4WGa9VMG55Mc+hKkarpJAYB7EIq2+CF3lti/F?=
 =?us-ascii?Q?5IzZ96VHr23V+0NY2lZNqipDOnc9IocdXKuW++RnIWDbml6W01Bor0MyEv4j?=
 =?us-ascii?Q?dOccTZpnQN46AHYkHXOWhmEuqM5dsqWvX7U2mttsB8EzpBc+9MWjn0BUh8yG?=
 =?us-ascii?Q?QjIIAkVVXP3wCvUrYOWIDSvuttwNTgERIDGcuiAoSY0qmzh/kFbItK2D3Eu4?=
 =?us-ascii?Q?USMgG49rUxOqfM8xEt9wXbuVbMjy0cYPsNpDjOb/FGfneKZ++mtmcDAkCZHy?=
 =?us-ascii?Q?rJ/Lrm9KQ2pIS3iCxqjfCV8dyy7NpqJz33CPkGNflFB9s8WNYKMDdemv9NI0?=
 =?us-ascii?Q?utyhblvq442z+SMm5OUWSzfCafFiYgG1e1rwotYRd1E1ObqwJ1odw8fi7nwz?=
 =?us-ascii?Q?TUp+6OY1iWwhyG1NPs5PHVO40+1oDfz7lOAJYvbDBOS0fkm4h2G9Xn14Kq4Q?=
 =?us-ascii?Q?wXaMOsFto7dsmbDetX8jcog3ENe51afVwdVEXXniAfjErpZrs43VgqUKrcMR?=
 =?us-ascii?Q?/eaCjPwr5fx07ekaxaeps1yPz07LRiJo3QAr0RbVUzrsIrg1uzca0167EVQz?=
 =?us-ascii?Q?Z2uZMc7+hUuV3/R739pmlsKfreTISdUx6WXXyrtWzkKITc19PtO+oY3MZQMa?=
 =?us-ascii?Q?jPygtRth7fSiKCtzRG/KdJEjImXhbNt/qjjKeU+9/bzj10lHRhLoKieT06co?=
 =?us-ascii?Q?fuf9tqWmI0FJODZdU92Srvh6axXAvIoGhyUUGRdwCC5GsR7uQa+BxCrPDR08?=
 =?us-ascii?Q?Ntxntw/KPcxIrj/nJQ6hcRcN+LXz/AZtdHNrWGq6crWOhnp5tGQZhZWxTrAo?=
 =?us-ascii?Q?RM16S+ZICKnmt/WVIlw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205ddfac-38ab-447e-6fc1-08dd64168268
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 23:09:59.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuyTQF5aCgmMMjgK38HWJzauzuh9HtcvSmJU+LqNY45WNcBDZISC3ym8Hilhp7nc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653

On 15 Mar 2025, at 19:00, David Hildenbrand wrote:

> On 15.03.25 02:04, John Hubbard wrote:
>> On 3/13/25 3:49 PM, David Hildenbrand wrote:
>>> On 12.03.25 16:21, Christoph Hellwig wrote:
>>>> On Fri, Mar 07, 2025 at 08:23:08PM +0000, Matthew Wilcox wrote:
>>>>> Howver, the problem is real.
>>>>
>>>> What is the problem?
>>>
>>> I think the problem is the CMA allocation failure, not the latency.
>>>
>>> "if a large amount of direct IO is requested constantly, this can mak=
e
>>> pages in CMA pageblocks pinned and unable to migrate outside of the
>>> pageblock"
>>>
>>> We'd need a more reliable way to make CMA allocation -> page migratio=
n
>>> make progress. For example, after we isolated the pageblocks and
>>> migration starts doing its thing, we could disallow any further GUP
>>> pins. (e.g., make GUP spin or wait for migration to end)
>>>
>>> We could detect in GUP code that a folio is soon expected to be migra=
ted
>>> by checking the pageblock (isolated) and/or whether the folio is lock=
ed.
>>>
>>
>> Jason Gunthorpe and Matthew both had some ideas about how to fix this =
[1],
>> which were very close (maybe the same) to what you're saying here: sle=
ep
>> and spin in an killable loop.
>>
>> It turns out to be a little difficult to do this--I had trouble making=

>> the folio's "has waiters" bit work for this, for example. And then...s=
quirrel!
>>
>> However, I still believe, so far, this is the right approach. I'm just=
 not
>> sure which thing to wait on, exactly.
>
> Zi Yan has a series to convert the "isolate" state of pageblocks to a s=
eparate pageblock bit; it could be considered a lock-bit. Currently, it's=
 essentially the migratetype being MIGRATE_ISOLATE.
>
> As soon as a pageblock is isolated, one must be prepared for contained =
pages/folios to get migrated. The folio lock will only be grabbed once ac=
tually trying to migrate a folio IIRC, so it might not be the best choice=
: especially considering allocations that span many pageblocks.
>
> So maybe one would need a "has waiters" bit per pageblock, so relevant =
users (e.g., GUP) could wait on the isolate bit getting cleared.


The patchset is at: https://lore.kernel.org/linux-mm/20250214154215.71753=
7-1-ziy@nvidia.com/. I should be able to work on it soon, as I have been =
busy with
folio_split() patchset recently. My patchset extends migratetype bits fro=
m 4 to 8
and use bit 7 for MIGRATE_ISOLATE.


--
Best Regards,
Yan, Zi

