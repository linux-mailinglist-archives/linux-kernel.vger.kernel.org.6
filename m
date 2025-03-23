Return-Path: <linux-kernel+bounces-572946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867ADA6D0A4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE857A5575
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2031194C61;
	Sun, 23 Mar 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UngI4r6C"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C68D78C9C;
	Sun, 23 Mar 2025 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742756159; cv=fail; b=nRWMZ+kmvQNh7yw+KIrhTEGGXDaOFXRlNdl4PrknYQabfEZ5Cn0DdIok0+vajcn9ZyEhVBgSKnPZ+OTrjYZdn6n/NonhHXYlzyltDCjwaOqhsP31Yfnskn5vrx+K/moyTZm2RIC6HgUNJ1kPZzWjDBBmNRY1YXgnq6gzR5gBYeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742756159; c=relaxed/simple;
	bh=jkVbcCvoASYTjlJk9KTg5sEhjo7RuXoT78LgnyB0Tak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YifVCyqua83Oop6kEeLKCMrkKBYudPAuhlmv9LthbI3V64hkbMR6b0z9g1IhL+eRU3OuzYkkw/ve5WPzTZMSM4eUrJt+TYLcfvtX8WREFdROZwSBXEKlADEvDiDqKG8KKw7Z7ruKvIx+pELwEBzpzD/VkmLkPrMXn0EImOAwHTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UngI4r6C; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSyMWh8nS8h/04iE80vfCLbsXZLU+/8sq+ceFexk3bKKOGwUYjsDEX2Z3ABdh93JSzKQfZt+3iB8A268Y8E1Ko/1SFMK622q9iht1yzIsciaQlqzLGwuRI2qFxsOEvlpFc16ueksyDGSqIp8PwT9lfbOn2pe9dPFN2Ep20j21XFw2vkOKhrP8AQer9Id/68nKDpHpZN5fv4BxBPpK2dTwJrv13L8jTmkcgmw+7NADlO8Y2Qsna9JnupG+vhwxr9dp+0J0+epkNZFwcnTzIK6ooSUN9mXGzBHhoEVWz0ZrZFDoe+on/k1RGzEU/t+WqGIUDdFtlkUi/hU0xHUb7UbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nAG/qQRQpu//rLtAVyPzvPWzctU8u3buhONBO6yYrU=;
 b=I7XBgcviTpqY1vuFFn0u1EU/8YTHz6X1rHf27bDvG5MiypDPfPMrKSngU/i2OYwaCSxb388V+7J3bIdY8BYThWYSD3J0kORj0+G5/DIPLAq4iE0q3h6AomYkj6U7rUEtNk6gwE9hUlf/rUAPg3L/7DGUW7Eqy7opqQ18mIqpQ+UJKVzsdBUqOqEEx9y6/diwozLqX1MyWHvOrvr1HnxeLgd8pSnRZDXB9jnhGt4knTiGTxgkudrzKOvfdewDxOMvQ1Ltcim/uweiI/P3a9Twrt/yuFlxQdCtIjtDLQuI4OQSeBbbw+w1Bik5h+sKyZdNLm0h6R6z8CA52xsWjOrdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nAG/qQRQpu//rLtAVyPzvPWzctU8u3buhONBO6yYrU=;
 b=UngI4r6C7vQ2n9H+gtGZhws6/qrBhSx43bAEGwBYrUdAW+CawijtqyIRTMjHgQxA/4DD13N8Mxsg8nkCW5c/2+BuePkX8ibVxDuWzzM5B6rTPDFRCUPq23E3JgNi0N8irotbUaYX95EQNaQC28LGn8hdkfIWmhYsHj7Wn+OA+bFRoPtJN/pUGcB8da5Nd04Dp0YUWyXIOhuSoGOZvVPLjoWUlLef2hzb37ApEotjdNLIqm4DDJsbbrDrpYEYAwopSGgQ/TZ3DhnE+4cvkJ+/ef0fgENegAC0Fo8/ZRplLW1M13V/yZdVc2gVLyf/IT1Fkfxs6H3XxRrvffb9NSJI9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 18:55:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 18:55:53 +0000
Date: Sun, 23 Mar 2025 15:55:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, mark.rutland@arm.com,
	pbonzini@redhat.com, pasha.tatashin@soleen.com, hpa@zytor.com,
	peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
	robh@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
	tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory
 preservation
Message-ID: <Z+BZOKSpyPA1Pyu+@nvidia.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-10-changyuanl@google.com>
 <20250321134629.GA252045@nvidia.com>
 <Z98Lmo50h5RboFXq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z98Lmo50h5RboFXq@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: d70fbe72-ad15-4802-0ca6-08dd6a3c565f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odjoHHyQ0FxiSX0H5pcOJzT32iQwjwxvJhX9xmj/+oE+tpwAR+mWZ8LHhYEg?=
 =?us-ascii?Q?+7DcN8MtdkL6le8IEG0XRcrjXKYpofURtY0yGp+tauwWsQdzXhRvMI8gkcfY?=
 =?us-ascii?Q?37w+iEFZvSHuv0UJMjCeMrGlSjF5BS0n4awzKKTUlD3G6bDTHhK1cPohDAmT?=
 =?us-ascii?Q?XgoGxnEhnRG9lTUojkx9ANSelB1AjdlU5LvHN31RSr4wo9E3c6jAWPbZ9X62?=
 =?us-ascii?Q?U1iJ6j4aGmotWWw61VtOglLyjRbPRvkuivyH3mK42qWvhNfmwZjwrJYrdmSc?=
 =?us-ascii?Q?xA6Kza6R0r/r3cLjEYGjoHq5fe48KKDfnreKrcLF0+CNt4O2HYWkaNfOuz/F?=
 =?us-ascii?Q?EBtSCtATMnS/oIDymQyyTieYYUvtbZobhdMic8AaQerQkD2WR+VO/haS1xOm?=
 =?us-ascii?Q?kLl4G/nUYFlCNGad7LxcJjUo9BMEL5pD1CrbHmOLdmUec+p6wgsgw+dxQDBb?=
 =?us-ascii?Q?mC/7TjoFZ9e1qSXjd1Rw7pHVGASLVbwMCz1roSk4XlavOf7UezLVGp0LXL5C?=
 =?us-ascii?Q?IY6Vp2ndeTF5vMHOgMuH1fruWzUO2JfdQJPiLXPYWyYvxT6MEkx2yF/lumtc?=
 =?us-ascii?Q?RAFAjEoneNCl7HmRK60gnRDaAU++froNzch6BF6Jgc8mP1US3OXnG51dsPZM?=
 =?us-ascii?Q?Z8spHWydjLhpY+G3/1OTKH2ouzkKeyPzVeatiqaWIAo4rY5wO7UaKCDy7yxq?=
 =?us-ascii?Q?vkxULmW9ds2DQUH8ZFLeYbyidZxxkPTmFtrrt1HL4N1Et0uK37vsJtVZVu41?=
 =?us-ascii?Q?5zhTaBzjsVGgJHRuxaQXBPdzzim8rQ8nn1kjA8dYRLhjROgSdCmy4OcS3YYm?=
 =?us-ascii?Q?hqTxdJg6IUtBvkjHJjRdajYXOSevDKr5V8SXquEo/j0StmcjUHzU+8amLSp2?=
 =?us-ascii?Q?EfTplKj7n2OxCRC98r/+3BypkBaVGM7ywcVUl+c3HbziQnX36MR6Lq5Njv7r?=
 =?us-ascii?Q?2/8unVO4jk12AaansdWjZMKxJUmShVjV+Mx4KjNAf2vBlcFDcbWYsCa4qCDs?=
 =?us-ascii?Q?DiEG6XVwsC62iCKOfaWPeah/KYC8DT9+hJ/myiFeiW3t6krkFwn2/6DoHXbi?=
 =?us-ascii?Q?mn9ksksE9+51KAhvYCK3VZdj4V9SA/gxKH3WyBA3/ZyeVFP4AOag0OC6HMIq?=
 =?us-ascii?Q?rKoX3aYHo5lwkk0K3HqVnmhDVbwCJYaFrdoTN26p1iRoA2NIjiIVZlZbELNA?=
 =?us-ascii?Q?O9xdTM2+D4J6FPT/5Hx9yT/eKYRzsdA5Kn18ZpvgT+BtBLGTh2YpHqr2ZmBs?=
 =?us-ascii?Q?HzwlAHEIOMuGEAQdXTuOHHfejrKfDdwrMgqcYy1CfxOky89HgXYu+XFFdf9p?=
 =?us-ascii?Q?CK66xiQ20ZV8g+0ZBCQIbenKBDhqTaRnHmzq86gUjWayCFY0Iib0qA+RkEgp?=
 =?us-ascii?Q?ASUv8mQXpG8Lyo2DY8hlbTi7q2HF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsNp4Y3v/uIAENqRxBR9lJqflaoGqma77DUjBEB1XRbcnEWi3ps82ty8dojg?=
 =?us-ascii?Q?sSM6k6BLABRBYfdd0iJZwJryXBx2Ym3nJmM6Ua8j7TE217JzD2avEeTyj4TF?=
 =?us-ascii?Q?7GTaTBYAM5H6u0dwcxGIce6oO4gimx1217XrtFQ3wcne7Al8ZUxQGXUBh7fI?=
 =?us-ascii?Q?ZGeI0QypduTQQJyWRkZZY0Hsk8jXzCXdHrgUSRcqjnshuT8pn7+KWwvEJdQe?=
 =?us-ascii?Q?4ZRh4T0PFFYqo5xJulIS26m7kRcs2lbVFsz6pB2HUWXK4xqH70FEUl5ZHr6I?=
 =?us-ascii?Q?TaKdL4+po0RT/nVCMM0u49KaOiEgXJdtePSfi5nddN3wZCF5qy5VoUbFkzSI?=
 =?us-ascii?Q?X4l9n6RRxi0JjgONz6qehVgL4PSoiMiPYwOxO8EkYkcNIp1Ypalk0vsNmwYy?=
 =?us-ascii?Q?q0Q7P0XPSalQ1qzEmtBiieL5R68QJZARXB13epL+TtSvFwtsFcb6NrY10STt?=
 =?us-ascii?Q?ONggKYvGliFTY9ilKUDguqLYQAYJ15DZIRuMPyHihEKyDqt0+dNjbZmWV6XP?=
 =?us-ascii?Q?6B/73j/1URh+8B3AMAdftrSTv74urDwfg+YmmSprnMKcOQh49if/x5sxMVRa?=
 =?us-ascii?Q?05znogQeQx0eeczC6mrByRAZn1zXOEVWRw/bEVus+oyb2Nq68eRUdv27sN9o?=
 =?us-ascii?Q?04iPjG435EOieO27gksKayrNIGzLGB9YH/RQzyfuTMgx9FckJXuM5i4kFjGO?=
 =?us-ascii?Q?DcGzjo31V0swi5v+38Ecle9Qhccj7F+0clVr14RQCcAMYDDP91bU7GN0yLCa?=
 =?us-ascii?Q?lhXsRdq3FkhFf939BI7jgJ5hyCw3NRI3nM0LOyAu6L2FMRq68Qe0K03vsJ03?=
 =?us-ascii?Q?z/Ftq/IFRp0yQ8Cn9iycMlY4f3ZkDDpfw2cBf4T9zH5jJ0bita+81UVH/7Ra?=
 =?us-ascii?Q?Hvprka82QinXKEYEpbBjqYLu2lypBD5Ncsyp1l/6e76dC6Cbb1g4HQGE6I4w?=
 =?us-ascii?Q?GZRNuY6a01bLRfg2jflByk5CBZ+LjFDwscpYyvaOlwoB5EA5ylbDIpe6FrUF?=
 =?us-ascii?Q?MxtZTWI5FIkNZ24qVEQj+b8xgjnO+Hckku4Rpkpwidt9GYIW8+UF4ZPl4Wnd?=
 =?us-ascii?Q?xqzs9TmNcznaPVBHAtXNhBDbnZXq17BUk/2ZWrJGqUH7xh0O4vrmEA4QCXhC?=
 =?us-ascii?Q?TMGxLVbcNKyY1cdsNeKmSazyU9OiDi9j4aRmcRhus0wpkmiwcvKn/HNE418A?=
 =?us-ascii?Q?OzIVNL+LDjignGZ73JbJW8Zn/4z41MATHjOX+p/8vwTQUFqDcSc4v3fTgBCS?=
 =?us-ascii?Q?KLBQjHMf2t5n9TYEIml4nWGKIgRrhZC1UqzCkocAjMNgu24L6x1rSgLdsT7E?=
 =?us-ascii?Q?pcZPd1N62J6vkbbKLneYvFO6HhnxAh1cPWxlgmiDb8Q7/9E0nzHM2rLbFJmW?=
 =?us-ascii?Q?kRXtrFtwIM4r2BCSEgtIH60NFtd5O6J3yYQ5ZaY6MPR1XzoLVXqUlqu9SsTC?=
 =?us-ascii?Q?OFNPJPwGKKsZ9tbgX7z+hm8XkPPokAp4dJeGye0lv2hYu1F18LNCVAPRIf7R?=
 =?us-ascii?Q?x08N6XCJ+FWLaMndud8xJxdnEIS5V4I/XxEGjxbFAiFE+Glrvoi48QTdf1SO?=
 =?us-ascii?Q?dj9FqUTc1rbXIL77/QJxopAbw/kmmGeEghkh0Bp0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70fbe72-ad15-4802-0ca6-08dd6a3c565f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 18:55:53.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93inFYzSfLw8BQQU10/cBXQfp93jyBY5w1ozhrFZ2r+OucIUX3coYeOtcaKamXth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297

On Sat, Mar 22, 2025 at 03:12:26PM -0400, Mike Rapoport wrote:
> This hunk actually came from me. I decided to keep it simple for now and
> check what are the alternatives, like moving away from memblock_reserve(),
> adding a maple_tree or even something else.

Okat, makes sense to me
 
> > > +		page->private = order;
> > 
> > Can't just set the page order directly? Why use private?
> 
> Setting the order means recreating the folio the way prep_compound_page()
> does. I think it's better to postpone it until the folio is requested. This
> way it might run after SMP is enabled. 

I see, that makes sense, but also it could stil use page->order..

> Besides, when we start allocating
> folios separately from struct page, initializing it here would be a real
> issue.

Yes, but also we wouldn't have page->private to make it work.. Somehow
anything we want to carry over would have to become encoded in the
memdesc directly.

I think this supports my remark someplace else that any user of this
that wants to preserve per-page data should do it on its own somehow
as an add-on-top?

Jason

