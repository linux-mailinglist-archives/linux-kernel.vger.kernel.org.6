Return-Path: <linux-kernel+bounces-534389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7CBA46680
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DC2188436A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0628F3;
	Wed, 26 Feb 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQ0KtTWX"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2B21C9E3;
	Wed, 26 Feb 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585964; cv=fail; b=IknOWakVKL16pBxKJvDH+3IAVcNn+ywpWMxp7YcpMXlrozwuDMHivjnZqImto25yTHXMfjux3uu/4XhvoLijtaUXU4jznb9+7al3BDSn7m9LzwP6hOWPmAF/x4M01uKKs1q86neBfVZoEw9oxZz2t9ddczSQerUMROxQk5uxLw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585964; c=relaxed/simple;
	bh=HUoxzAEwZxS7ahUOxgfJzY7g6pRYFnW3/qQcV5OsghQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TJVTr5Vso1gOw5bYdxl2OWuDg8mtuIprswKynnmkGKFgQM0Q3D6oNeFvrUUet/Y2QGYRw7lwnYdlcWkkke8ojPLngtAQkLdzzZ6WtQ0ADKlLkaiS2OU44Rdjl0I73HF10a6o93U/0vpGhjqd8kgqnFWGL5gvn/Sq7Ge5FT3p538=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQ0KtTWX; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2bC+na+Ay5eyH1C8iQmpyOZmQEgepwUioq7TQUJAg1b6YBZB1ihsNypczqVPbYrf/9y17e6mkEb1pHU3wlmYyD1MmeLFR4PrDaEDEtmVs9mp12aRrmMAO/FsvgxGHV/mvBaKeB6QQUUU4Qo6b8KMAmZpS8Fg8u9N77usrpq70F+hDJakzwajAmh62o53WkPeNP/+TkpyoxfVAw8fn47afZewBA1Ral8CTNaKCbCgm6NVyrkGAmSrPpw0JAZShxTLpA3UbMgGxGyLAxb+6HdT19pmTHTKSrJxBU2P8gY1NLgqrgUZvc4+oK3QaIZzWEHUfR3MIbrr43ZWjBTuJWxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZUp5KGDYsGU21l44pumQJZa0oUnEtN0MDKUt/RJTRc=;
 b=cSZ2WMxyMEv/ol9NOyGhp4ViQfTNkFeEIGZdxqpb/wL6rDQ6uHyaoPj09ReWNmXiA4DhL+4KIUyndCe8Ap30fPH49THecXQpis0MuVZ2EaZwWkLe/O9yz2rVI4we3U0PTNMV4pxX3Jeob5MbUEml/YTHE6GNAXZoaUXJD4u3jCvYaCw6SI8LRU8W0TJYD4RkRQqo8LtL+IomK0KgACVP+roxQKYZGLTi0iA9T2LNkNpb2r3SSjFZl4qfvTAgHK5OcN50BQu+5ZuCADSpmvRbpa1T2qDCYQl1R7dinAXpOC6oGyU/u/oWa8F3vqLvzwxzxaIHt1ymwO2zAO3nSsNO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZUp5KGDYsGU21l44pumQJZa0oUnEtN0MDKUt/RJTRc=;
 b=GQ0KtTWXU83Z8ZavlG16446ZkKcRhjCvTew4ZHcqjajitLWjHHVkBn1tjBHFwJFsa7fj3GLCnk0Ob8KifIPnOxsQxmAFx6skg2ecjolRxNmrq/F8P0xPW1Bzzfs8JxANCW1MKPeZUL2HQvw8f5mER0tF0Y4RVNPhtau/52VqSczjWNWx2RCXit0GeZBWmu5R/7uk7WqyhXqoybStO5ng3nCPOJItCzMMi/mm24himPFamI/AfCqoBkPpZjhrJhXeKv8dzT43TKkf9ZZx5tV0I9gzIBjJ/jOjkRXVVkJ9+kIYJWdONq8PGHuNpGOIZ30PEtpEwKCp5hCvrDb9ISUE+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 16:05:57 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 16:05:55 +0000
Date: Wed, 26 Feb 2025 12:05:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250226160554.GA33931@nvidia.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <Z7bO1jT2onZFZwgH@infradead.org>
 <CAHk-=wgLbz1Bm8QhmJ4dJGSmTuV5w_R0Gwvg5kHrYr4Ko9dUHQ@mail.gmail.com>
 <Z7hulnJ4fwslRILy@pollux>
 <20250223180330.GC15078@pendragon.ideasonboard.com>
 <CAHk-=wie_Winz7CtRCM62S2b1pWKN2Jt2wdGHgFBv=aBU8qwqg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wie_Winz7CtRCM62S2b1pWKN2Jt2wdGHgFBv=aBU8qwqg@mail.gmail.com>
X-ClientProxiedBy: MN2PR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:208:23e::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dfa090-5b5e-471b-df5a-08dd567f735a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSaHfr5rQnd9sbefyV2rItb4fuIZRrA5puKED1sJyDKcplWPzhgrRdZGbiOQ?=
 =?us-ascii?Q?Er1lndcJNKjCECtXVXaq0Ox5GvD9kX2PBfGmjSwx53+JYFLhgNVtSAB7kNfd?=
 =?us-ascii?Q?u9TZjgtXyVXuXoh1MS0u9GwuNEEvwNheIi+4hmB1r2Y4BGAc+j4+w5RMGOqq?=
 =?us-ascii?Q?MP0ScTMtpGoGalL24UIh1hYJYmBurtwmZRHXaUtFoxiGMpaIgHLsA9gdfBIv?=
 =?us-ascii?Q?bKIIXLieKwNqEfcqjMNBne6sTFpRMFU+kmL9EoNF+QyzUDGUO7rJ3SJjhbFr?=
 =?us-ascii?Q?Xa+yj5YXxjmDAzZTk18+mm/fKpbCwWqQYSFm4Q1eJmdFAIzw4wgveUGvx6ih?=
 =?us-ascii?Q?SmU2DyclngTt9eFgraAZ2vY7hMyujj3MzAGvrJLlAe2W+QnAYMwMpgftpPET?=
 =?us-ascii?Q?+Qao26JnLiCyQkYGqnEi8utt4nOmqkAj0y9NvcCA87GEsgDPzKw58k2fUpTv?=
 =?us-ascii?Q?KXR4O5V5myXNC2EYbIMhMlfNiPtZvaby4UbDnO4VesNaFhRVHUhvkboa1wIt?=
 =?us-ascii?Q?dQUfaKRIE4xqyGC6wTPOFcbDybiPf3R0jTIaZwE9q0zD3bG/a7Xq4cCqgeT0?=
 =?us-ascii?Q?GCPmd4eAAVQHAe3aNeawX8IvPjU7ZLWhQdWLlYAIRfQnlO/cj99dnLIbJF3o?=
 =?us-ascii?Q?w6MUV+F+CJqiCe8orHhvRwKX4E2lT7ae6ERCMZTmEwSPQhQYko+UXu+r2bbk?=
 =?us-ascii?Q?ehQAsAp7p620xlpqcNbVKRA8J1XyX+97dAOgDFA7a+pQHDS4Q/pLIsMvfkui?=
 =?us-ascii?Q?JLLBgfxuJRoqBPF0t48uq22BZ8nbLvwin6Gs+65co0jZbO5ytaOwP//LT8rb?=
 =?us-ascii?Q?B2FsPBGvWzUKfg92meFPhzZzLTgFt3wONDmsb5/vaPqBBzQ6G26QayUeF/qe?=
 =?us-ascii?Q?6ujHbuzxmRCp4CNbs3GIC0RoKTWFCAnZKPYK+o6BeZKip4HzwDjHChHQIACs?=
 =?us-ascii?Q?cfWCvfVyByowiEO8RrCk10vQqblUKMsfwLwARp0TNyHB4DDEAtvN0ZuMXWd5?=
 =?us-ascii?Q?CoT4i2RhmIL89sV1DZBvojwvSFKAw7p2xja7sgV3396zoLb+s/16N6a790hw?=
 =?us-ascii?Q?CT0IslMq5Gs+pDuhvs2Q/XRWMmdgfpWQgGNcaqxpnhaFZ3pAzuyEKXs+NbUD?=
 =?us-ascii?Q?cbXKVhvbNb82I8bYf7j5VGENUw7pkAdyu3ezJNp+7RpWMWu5qToy4gsLYU/x?=
 =?us-ascii?Q?AXPYxzwYPLvNz2OsFkWySiHDAE88JsFi5E9TJuStDTjl5BemKuu7QYY/pwdz?=
 =?us-ascii?Q?7jqBeVOXMTLOLs1Q0YnKNl/Aw2jtNC85J7m+iLoO/+LNtPd/HZhIfWmN3fKE?=
 =?us-ascii?Q?q5c7xeP8YBvQnk5s4gcYXwl2NB+D4pnriF9ym0blKPSmfXJ5JtpsEupVGezS?=
 =?us-ascii?Q?Pwus5wJHlxRPVY9ZAl1/dpZ9WeTg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IJEwcTNPBQdN1+iRJXzil7qKmzihWiTI0qFn1NiVLuUFvHBkoV4LSnbheXzQ?=
 =?us-ascii?Q?jz3r9AdD0cbX8Oc4HmiiYKQ/63y6oAvvUaW9rKKdpoGcV7PhjfNsB44zzzFl?=
 =?us-ascii?Q?YaV0lwx2k/UEyJoXnGfbHXIHIaQZ0//ydCUq4qRbihWKSMmxk7a4/smHAQAZ?=
 =?us-ascii?Q?x4mIAZDk5sW6ywximXPL6KOYH72T30yVeWS9Yl+35ecmWYYlCGRmER/7+aaz?=
 =?us-ascii?Q?Gd1HDrJYxOlWBCNOUoFz6YqiSkW2TbPJAHYBO7xWKvfWZic6IBDm4QCeyb3R?=
 =?us-ascii?Q?/5l5S3IdrZTSddVVqOAxl9VXTiOkLKKNu/OGkMbcRxIB83CeXW5nQGudkl38?=
 =?us-ascii?Q?DbZVcCPC5qNsZenI+AMbCd81RwYW1Vtd4zStM0ZF53o+qAyYPayLNmt/BayI?=
 =?us-ascii?Q?VHMDkIqbau2QD/SSQHWZA8zta6MHVH69D59dAUEmP8COPR0dzMravAFV9DFT?=
 =?us-ascii?Q?OuCs5EOBHJIqF4yhhIiVhQxJlwthCpdBIL0Wf13IEgDNDENUUDt59gxwsLc3?=
 =?us-ascii?Q?CVySgUsqAXIVA0Ko1wjPNnDqXd3yfKxxaIfDrXjCdxepHm+oIqVz2SevRaZL?=
 =?us-ascii?Q?UvC6KcJab9PR9OQe9HYSZLJLX3NnptxlwHjiuGEp8Kmc+RSI5brb5LEl1StW?=
 =?us-ascii?Q?2CcUS53VOJ3veD/EsLTgDi4l+K+xKVKdZeTb+FWBsx6rpOjn95ZEIMiO/nPK?=
 =?us-ascii?Q?8syXOSTIh0QzPWgbA5Z2XyVsla4PkdrKtUsYwdRqBT6xWVpCAJrCilEaSEQQ?=
 =?us-ascii?Q?FPfC5QEQEGpPsolXvJ0Bz2NoA9j8Cuo24I1plqTqXF2cjZPgNzdWEBOi/ZjD?=
 =?us-ascii?Q?EEcvI+OpGUnMOaDPScnO/Hr+zmDOMewSDyWAz4cMyzqfHKD3fqgfmmtozOYb?=
 =?us-ascii?Q?o58xOJwMsEsOctz12LxV/DTquVhX2HWYFacEFWUiDQZwiWZN/nus/8NnSP3J?=
 =?us-ascii?Q?syto0b+Ab9iAymhDjurk5AKWTz18vK0xphxsK85aYYiXqW5HWx842Sq4EsXi?=
 =?us-ascii?Q?3VKJV+79XG/nuzChpblTVdnZdGQbsj7tf4kfpRGF4DtDY/DZaMLnlU5A8RLd?=
 =?us-ascii?Q?Rv5Q9QbhXQwDV8RCeYdAQvsxtdY+/e7pDvQUpVDES+7GBUxbZIGx1yTBoSYJ?=
 =?us-ascii?Q?zFXmfEQCTPuPjVuTkE/F5WrgEHQ4eoe0j8GWTtnFCPr5crB3HgTTQF965fRP?=
 =?us-ascii?Q?QjZrXEakWiu9/PiS1KFKwV+bFd7s0JCYjGffe4A5hEilS6xFWcn2rMbHtIsO?=
 =?us-ascii?Q?vcdg+0zgn42QxbSXfjEkoymPsCqHCLdz0+VsmLvG2m0P/yHYJZyEWF/gb/Zv?=
 =?us-ascii?Q?mAr5kCpLTILoEdZx54V0NymAchS7GrTI/UfYdnjge7LqBopXctDTkN60jG7x?=
 =?us-ascii?Q?IcARl8n2UvvPXV4tO0mH2CQpd7R4+rWKzEWGRZMX4lcotvRH1Atu1auAyVMj?=
 =?us-ascii?Q?lyrogXCOk8WRuqWsxidzZAo2wr8W0e/xFKeG8aUZ5OmjMDPFKq27FAwZGWmN?=
 =?us-ascii?Q?ksEbodOgzaZQ1niM+Q96GYHJ8hv2D6jMvnH0RMp9E+xqG5mkhwZvhqR62GSk?=
 =?us-ascii?Q?r78lHb3NzqgX4qw/PhQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dfa090-5b5e-471b-df5a-08dd567f735a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:05:55.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/bCQkoZ4L0Bq3wfBbA4wFlStrZA4nff5bGbinLEGUYOpy/rKv0lsCWf6/rUD5Ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

On Sun, Feb 23, 2025 at 10:31:49AM -0800, Linus Torvalds wrote:
> On Sun, 23 Feb 2025 at 10:03, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> >   > I can't answer for Linus, sorry.  But a generic "hey, this broke our
> >   > working toolchain builds" is something that is much much much
> >   > different than "an api changed so I now have to turn off this driver
> >   > in my build" issue.
> >
> >   I haven't found a clear statement from Linus on this topic.
> >
> > Those three statements can't all be true together, we can at best have
> > two. I would like to understand which one we will drop first, and I
> > believe many other developers and maintainers are wondering the same.

> Yes, linux-next is supposed to catch interactions between different
> development trees. And yes, various build bots test different
> configurations. But nothing is ever perfect, and you really shouldn't
> expect it to be.

There are two "break" issues:
 1) Does rc1 work on a given system? We discussed this at the
    maintainer summit, and I think the consensus was it is sad it is
    broken so much but no changes were proposed. i386 being broken
    is this type of problem.

 2) Does Linus accept a PR from the maintainer? This is what I think
    Laurent is driving at. AFAIK Linus accepting a PR at least
    requires it passes your build test and boots your test machine(s).

IMHO, when a PR is rejected it is a big emergency for maintainers.
They carry the responsibility for all their submitters to get things
merged each cycle. Just dropping a whole PR is not an option.

So, this last cycle, Andrew rebased & dropped 6 patches from Uros and
resent his PR so all the other work got merged. Uros respun them based
on the discussion with you but Andrew didn't pick them up till after
the merge window (now commit eaac384d7eb3/etc in -next).

This is almost fine, except IMHO Andrew, should be build testing Rust
as well to catch this before you did to avoid this emergency last
minute rebase/revert.

I think Laurent's message is still evidence that the messaging to
maintainers needs to be crystal clear:

 It is the top level maintainer's responsibility to send Linus PRs
 that pass a CONFIG_RUST=y x86-64 allmodconfig (?) build.

To Laurent's point, my test here:

 https://lore.kernel.org/all/20250131135421.GO5556@nvidia.com/

Demonstrates maintainers cannot fully ignore the Rust bindings when
merging changes to the bound C API. The build CONFIG_RUST=y
immediately fails, and my understanding is that is enough for you to
probably refuse the PR.

Thus, at a minimum, the maintainer must track this and ensure things
are resolved *somehow* before sending the PR. [1]

The fact you have been seeing so few Rust breaks says that the
affected maintainers are already doing this. For instance Andreas
explains how he has been working to keep block's PR to you building:

 https://lore.kernel.org/all/87frkfv8eu.fsf@kernel.org/

Some examples of his work:
 31d813a3b8cb ("rust: block: fix use of BLK_MQ_F_SHOULD_MERGE")
 5b026e341207 ("rust: block: fix generated bindings after refactoring of features")
 5ddb88f22eb9 ("rust: block: do not use removed queue flag API")

IMHO, maintainers are smart people, tell them clearly this is what
they need to do and they will figure it out. None of this is
especially new or particularly different from what people are already
doing.

I keep going back to this topic because there really is alot of
confusing messaging out there. For instance I wrote this same
essential guideline earlier and I belive I was told it is not the
policy. I'm glad to see Miguel's latest policy document is clearer,
but I think it could be even more specific.

Regards,
Jason

1 - Laurent, I think the seeming conflict between "things are allowed
to break" and "Linus must get PRs that build CONFIG_RUST=y" should be
understood as meaning bisection safety is not required for Rust. Ie
per the block methodology there are commits in the PRs that fail
CONFIG_RUST=y builds. However, Jens must ensure it is fixed all up
somehow before sending the PR.

