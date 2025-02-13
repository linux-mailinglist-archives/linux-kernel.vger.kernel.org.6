Return-Path: <linux-kernel+bounces-513452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B2A34A71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1131E1893395
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB479270EC2;
	Thu, 13 Feb 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TdEPVpLQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBC270EAA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464214; cv=fail; b=nErvEreTpPrmuynjBrLYg8mgETfMU77CKi5aTVBpntVJMv0+gEneiZZgtZFzTiUMVAbsa9kdXnRo5AWyF9ZUmdclZZBfauZfiKhH5udlij20pu/t3G3MddyTyCDpRQ9BCZBFWNPzOryeZk6hr73i1WmlSRkkyR2Sw8ktql0Rc9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464214; c=relaxed/simple;
	bh=uTMWVvHMs0NwYZOTvhg2lOK4yy9JPbTPxAZn4+ZrCw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lf8YpEG/PBtwYwD7yKGbysuf7tpSPEf59C0k7TiP18cFjF+90iRhq25deCAhdIZ8JU6WkpkPijXl1L9GWdsfy3PcajmN+0ivubRyQYGZYGs17cim+bfXuboKW9kJl2MLK3M5X1Muyb3EWUlbNa2oas7TcuaW3VIOV5UyzH58tdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TdEPVpLQ; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM23P3JVFq0y1nUgnMW8GQRF7SD8pqX5rNhUKH8MXfYNZZOEn1oYOhAv1wFittIgjPgBPW7OF1vb43i1pxR8hkTYP2Kcip1HbhSmaun4hMTP/WPBkBWHMttsvLsHkq3LmkMq7Tl4Mc1mdiPItT1PiTR2TjmySTP7gW5dkLdg8ZdVzqUrzHVU30T5wN2llziFg4t96xnBMmtLczqI7C4xh63f3ksyXfnS7bqvb89Q5UjatRImRbByh1y39taiohCtNYH1rmzrZbXqYg7GVg2pcU+/DV22Ln/9gTLFKBRA3ScIM0tO6TsnHzJ9fxnIVUq1lbGh+/cu6OoGM5DrfLLYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CeBLinIWWNw3yenjeXff61vshkGLEeOiS34qKX3c5o=;
 b=EFJkNNhTElR0XcPdcb8AvLaJADnTW9WKtqteXzLx+YmyacH2mFF0r91/C5UrQP3gJGyaDM1b5IMqMqaEzH/vuxc54LYuTEi032g9qa5T1uCEZGyET/9kDHzk1JBfQ6mfcD2J71bVRevcdp4drsV5RmzRb5tu6H/kblxLq/f6L3L0eJLMxUvGwb/9rj8sqphpJt5vUbzB1TYKgkFVH2LtzRbkYbo1MC46v1i2GNHBDh39h807fBmwY49XovysnRwjHcaMMrE8AlMXdjMSgGKtAu6H2NX2kYIxwy4fBIYn2D4zrbJtVVYvuuzNjfxyo/tzDVqhFBznXUPFb56Bffp7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CeBLinIWWNw3yenjeXff61vshkGLEeOiS34qKX3c5o=;
 b=TdEPVpLQOJNbplbcShaluqTvHgfJinlurlJyh0CKX7OktRFLqHOvCjcU7yMMw2S7hRo/dljgcJGtZjZFKdId6VMJrhfgZSEHggmKBbsFCX+FItb2ggsBYQULtrW2qtM66y7BUAX6CrtHMVMf+OSpktO5IYU2HttrgsMMPBrTWvsKeKWOYu+kZPkPPQzcHjGohYSMCC2DAvAEH+j1WTeG3+mBbqoB1rBZxsJ53z5FIwqm2xboPfwvqF8clOnc7pxwRzpB6Q8wWGKNeRs2N6RZm3LCcrpWSjCo3spvMfVhMqjyIuUx/Dc+NpX5Prr0QlCBNIgPZtJjInAoAGt0/ZqwRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Thu, 13 Feb
 2025 16:30:09 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 16:30:09 +0000
Date: Thu, 13 Feb 2025 17:30:05 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Neel Natu <neelnatu@google.com>,
	Barret Rhoden <brho@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: Implement
 SCX_OPS_ALLOW_QUEUED_WAKEUP
Message-ID: <Z64eDRRW2gQv53nW@gpd3>
References: <Z60p755gE1aDiimC@slm.duckdns.org>
 <Z62q4Zuh7ry9tH3L@gpd3>
 <Z64di-4TaQ10GAbl@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64di-4TaQ10GAbl@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fc07f1-18f3-4b0e-4212-08dd4c4bae88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?awD/8UsLhkb6qaZ/wE2Dft7PKz9NfmTn8pXjXOIz2OznQw/TktK3qkPz6uJl?=
 =?us-ascii?Q?dq3uJ2UK6wV3pDxHqEA5fvjh5huDTWyJCBt6qhV4XXKSQLEjJ3qubqtpeVEJ?=
 =?us-ascii?Q?P8Zi7fzguAg0fSVMf05rH3vgNku9DuGahjbSQjPl3WM1AH8C7uWUSRQnkb1i?=
 =?us-ascii?Q?fZgh4ASWgCb3uPfd03kusiO4GlCMDsOHBB5BzPDwWynHRLXD8zMpo0SSQu9I?=
 =?us-ascii?Q?TaZtHgMu7EbOrR9tAXt/FLeCqEJr7j72xESg8Hi0PCKrOuuBQ8W/XN1GyLVY?=
 =?us-ascii?Q?Ce1Ht5Ir54xTSC5tG6z55cludi3hfiF4TnsEcDLklh/rTQk9dzQcdUHjtQdT?=
 =?us-ascii?Q?1ZbfsMKdmy+bV/qKpYAROSMfCwikViSMLsrocMGFx6fRr0LFhnQUwzEYV7+I?=
 =?us-ascii?Q?pnDBgSKLDH16U0+6QAQNDu6/XrpWEZTStyW2TVtTeaD0J2/ilb7Un21JBgUg?=
 =?us-ascii?Q?0lYjBZuH+qh25iA+nKe98i2VXR6W/hhXc8eaBGgizQWLwxWRu6UIYQWuncxm?=
 =?us-ascii?Q?XKRVUA1y4OQ4qHS9ep9VKifO9CEaoLTgEHwc8TTUG/SrcJ5bWzfSqr362ZZx?=
 =?us-ascii?Q?fALDI3n81NaDeSIvVqF7fOA9xErdjhiO2rq3L8/+BgXvSMnMYuuenDR0EGzE?=
 =?us-ascii?Q?606jcANv2vkI8EEziVTRmeq5Xe3AhBCeE0/77lT9adk17WsKXJkBnM1ZwqC+?=
 =?us-ascii?Q?lzLwhL3BX8nzBhDUJ4nSKEsCY1Glnea1A9AMFGvaxIk33URkE/Wsfjv9bOs0?=
 =?us-ascii?Q?HmJYy7spDVjYGZwJqtnBO1h4shgZ+5z/bhByM6OP+lSf8wRJ3mxT2incn6lf?=
 =?us-ascii?Q?iIyNgc+MuAFolwPMwdF3haaIvo+sBhFctzNzjsasAAQYNRwL0OUtn9YgEfXo?=
 =?us-ascii?Q?t8K04H7KvbTh2IgbGqbcTmjKwZBsz0fWTMkaUTGaTAQ/dHnyVYRXn42pUPS1?=
 =?us-ascii?Q?7ZxNyPwMRL5Vqr7IufAac8mxAIna85gqZgAOzR5ULVOhs5lJkuWy9zN/85SM?=
 =?us-ascii?Q?EKGWoN7g4xFZZ7LDcw3Ckk+nyH05wQoNIgK8JRvoZdLNzFmhpjOuhONZy/2b?=
 =?us-ascii?Q?s0ZRfB00owSMNhLQskGGuZbxi72ju0B7IlM6oXhO/d1xmk46VELx6fONJqxk?=
 =?us-ascii?Q?fd+6mbDP0Os3rQTpVnfShz1n862gx8VAZolB9DRtqTI6ChxAe8zIMU0juCd0?=
 =?us-ascii?Q?PUPE4z6tSVnpUIwGSxwWJ2OB3wW+T1S84IXwj12JOqkJLKYvB/jI6/lAMZif?=
 =?us-ascii?Q?Vge0Iycc/tlm9hgWpgLGSJtM2wM4s0O6jSKoGdVk5TbHH/gX8iquAm9HXn4g?=
 =?us-ascii?Q?x26vHTEJQ/suWtq0vlnqDNW94/uGHD4QfkD+SE8ioxRAyURqhwGaiAIRcnXK?=
 =?us-ascii?Q?4x0AdYN1wd73HcwWBYndpaaJ1eCP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ifm+3bjDYpj7DFh6cTjQOpA/uvlogzxMwrwFX+GTdIfn+nLRiT55v7jVdY4?=
 =?us-ascii?Q?Rguvof9DqvjadOfJt5t0QFQrvgelPXaMAzTFBljNQkmBjO1DN6mYPo3CUT0L?=
 =?us-ascii?Q?aH1mI5K0nwm/KlcpQhXcwGITbGsKCIFisXzdHNlJBhZ7p5mA4HIoBunQUKc0?=
 =?us-ascii?Q?QH2gCrICtrdLjWUZUy13qZQnP/cDBIAN0UWeT/NJwMiJJKva8Kd7d+svXGdS?=
 =?us-ascii?Q?/FqJqRt8o2j1E9M9ByzzVReNydCfAb+C4sJbSOVI7Df5EzEtOHeVac9FzgBB?=
 =?us-ascii?Q?xFC2ePWYPaKk1XsUDsavfrFb45lsyat9cqxYgMiwdTX+ePgj8roC4pwODT/C?=
 =?us-ascii?Q?zJGJvfxMrinwvKwqNxn3GW8FNdPanHzsaKXlf/pKVyOHw54H29SHr5f6uCOQ?=
 =?us-ascii?Q?PUkyiEk9N/2WULS4uAwxyp55OY+nlF5mbiqzKf/S/rO1UhgKabrCtv5NFJ1e?=
 =?us-ascii?Q?18j3soxXSE8aB0Y1OVXpxHAcnKduecBTvufNAAy2cI1O+kuMs+TM8AXsncgT?=
 =?us-ascii?Q?TjS2J9wbqc6wTlp3F0GRRX8r8i9KXTsp15/2UayJgIZ5ZoWsZ95LAYGjEizP?=
 =?us-ascii?Q?cdTz4zXGawV5cXpTI15au9Vtff5G2o/DVQohPrSflZ79JG+gm1sSytkEX10u?=
 =?us-ascii?Q?ToX6fx9S4fnpu1pwGtN7JqLsVfvOqUYgDUYvvIXOtu4vAjNdXC03SMxPfLpn?=
 =?us-ascii?Q?+5v7Wx6CqyLIXXu7tQ9YI3u8YGvnqaDkUtqDUrWg9JY6gQyc8GIwvIy7aMMg?=
 =?us-ascii?Q?9aPcMnCDAp+CuvoMpFlOIScw6fFfxZ3RFGvuVzYQMUkGjL14NoUHPb6d6Lcy?=
 =?us-ascii?Q?YBgDz4D1IoE1+AomaDHt9kULruo8YdDItHnvJQLpL7vJAEjunRUmURytR7Fm?=
 =?us-ascii?Q?OE507iRAPMpW1+KXXcfLuf5HJSJxdQvym1c00G38p+PIg7hFuXN0wF54CSd9?=
 =?us-ascii?Q?w4ONmSExd9GM4GhK2l0Ua36kHeZ5rWc4VQbfcUrTMjl/WmQiUADKoviEbeNQ?=
 =?us-ascii?Q?OhUntydQEwNIIfowWPSjjmQqZtzwwio3G2IMsBZhgKF3C/ZyxvG9cIqW3q6Q?=
 =?us-ascii?Q?ENbBlBW4zTC0xPLgmGQOz4K0JK6qfJDLxWDxRh4t9uCQTiZ+Wsm8Qw9YFeTM?=
 =?us-ascii?Q?O7lC01N2jBuGFIPVGomenGieCRJFOV4M9kX6fjIlPHP7c79IWvotH0z7ss+l?=
 =?us-ascii?Q?cEM+9+22U9ooO9tP9/L80qi+xEtRmNQZwb/eLIY1cWvYBWXVv2z4XNffdQ4g?=
 =?us-ascii?Q?utm1DiAXw6z74NGdCKEbj62Abp/qYtcrada2r3vPQL63DjjkRYqJHVhAiHeY?=
 =?us-ascii?Q?QpKXfNiMNm8/8H7jvj7sCTJXK2ZWZIcmSPESC9XtrahwVf1N4ehZyE3HjeSh?=
 =?us-ascii?Q?2GPrK/D1buqVRGCsLHabAolZRcSRlXBtvDzws59j/ecz0X8IuDDFc0/wZUmB?=
 =?us-ascii?Q?k5lNPdVjpfAF/r3WqdcHms2MyVuOvDKDkIGMh0czj/q2aH0qXnNaaUo5z0k5?=
 =?us-ascii?Q?a374JzJZSo5xBGzNv6opZkYmNmtjcw3nOHI8LILBem6qh4Lcl21Ks5juw1eO?=
 =?us-ascii?Q?qaH2KAmATOiquNzrFb9JYjpPVFJNlU9qwiBGJbgL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fc07f1-18f3-4b0e-4212-08dd4c4bae88
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:30:09.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaprsguZsJRsuRqNKWUNAv0XV9oRgzvyMJWaqdGF4ZhUqI4cQDYMqn8AoKzI/aBOaGv1WA9je3cvn93biCRb5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841

On Thu, Feb 13, 2025 at 06:27:55AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Feb 13, 2025 at 09:18:41AM +0100, Andrea Righi wrote:
> > > Implement SCX_OPS_ALLOW_QUEUED_WAKEUP which allows BPF schedulers to choose
> > > to enable ttwu_queue optimization.
> > 
> > I'm wondering whether it makes sense to introduce a new SCX_OPS flag for
> > this, considering that we already have the TTWU_QUEUE sched feature, that
> > determines this behavior.
> > 
> > Is this in perspective of a future scenario, when we may potentially have
> > multiple scx schedulers running at the same time and they may want to set a
> > different queued wakeup behavior?
> 
> It's more that it can be a breaking change for schedulers that expect
> ops.select_cpu() to be called on wakeups. e.g. If we make this behavior the
> default, scx_layered as of the last relesae would break in an unobvious but
> serious way - it'd fail to occupy CPUs fully as it'd be skipping picking
> idle CPU and pushing tasks there for a noticeable portion of wakeups on
> multi-LLC machines. The same holds for most of the C schedulers.
> 
> Down the line, once everyone is onboard, we can maybe make it the default
> and drop the flag but, for now, this needs to be opt-in.
> 
> Thanks.

Makes sense, thanks for the clarification. With that:

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea

