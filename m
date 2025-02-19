Return-Path: <linux-kernel+bounces-522399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2287BA3C9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DA91885FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22D234966;
	Wed, 19 Feb 2025 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/yJCnYN"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3382723027D;
	Wed, 19 Feb 2025 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996877; cv=fail; b=t40PzwB/eGsz5N9d17jTVU5gdp2lULi0GjPn3W9gKYZnyRr6KS9yTC6DRjEzPBziE7kHbdS/7mO2WqT3NTy2Hv2vJG7rBiBn5iHvk90nDIULWyB62/6Qohy+JcpVXHraKFyYRevYHAA2KKPLgRTW+oOQlN+a0gc6iF1k39c853g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996877; c=relaxed/simple;
	bh=M/QI8bEZvPBsw8Vge70kgDy057s2stt3LPOgeqSOLD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aNXmyR+/H70kWyGDgxyFrTKEvQDWWAlq5PjPotrmvcUGGhHM+jCw1RYbTUOqwG18yYiHtDj4XDrqxnAbtIPWs5tFAgFi6rhQevxJ5N9ABceQspBRSRp5CBCqjMul2YNtIXhIfHuJgaPBA4PEuEzxR4ODDKEHNZper4chWV/AYmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/yJCnYN; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0Utmh/1HAc11pCqNvWA75nXSZQxn61twOvhoJbt1dCFVjInR6ZdS/l6VvECL8P2tUa6sg1sPN9wFx5NTsalIzI2cq7TCFcM1dufiNUz/nvHZFA6lRKABaMhyMNFop8x4BLiWP3tL6TttvleDEhpkuXxWeeUj2oPm/X0l5u0rq7pZ8fSVz8//g0X8DNVXPktJJX+J+4lKSmZh+4Nl86cua2mP3ylMGbOkaaZeFLTbtGbwSae25QmadXRSJLm/CpOJEjWQ/RCdZuQazCmTGaIa5a4HHrdtcK+Mm+dY/FRe2G1/R8qxtHOxPem7SLoRNxQnH5JnEmkySXQVA+JOL/TbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huHBAsoCys0m6qFxkPEWf8Z9c2pq62dT/tj9AWOxjes=;
 b=d3I0/qddrDDHv44rvWN217uJt9I2GpkdCOJteaO4kx4cqJ7eVgsokgLQmWHwWoOL3YlcVFh9CniS75/GvEXBT7GnA8hUrv+OlkmhozaDCGssAC6ZNfJB/NYD6yDWu/V47qm7MLxdrFanO/ahrkg9GODkHXAqUNP+JjLDaVYh+rbdj7HRevK1ZaiIRhQ11RUYyE4y09VjhuXDebiQ45QVFh1B+Y0jDhIBERuTd9zoPRDfCnPmjwcM9MVx4uFwKG7zqlLyZx/TcSsqCCqm1mrti1h93JRf3jUyVvMnRmKukYkTJn120U1d27pXT5bt+3b3v4ZyaCFqhbs8ZTTz4pHHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huHBAsoCys0m6qFxkPEWf8Z9c2pq62dT/tj9AWOxjes=;
 b=K/yJCnYNeRIbpp5sacjxQuzh+Y4d3eCDjwy1GCrLlvSuycstV1HNfat+q+/lt4fHm73Np4dpayDLtYZ4a3pkEOIQ4im9nFOUj6IYJBmCjOcUP8LQo7y48Dgo0/e2XAha7+u+HEXybuEW5mCcpwwNjs5bIsG0DqWJLE0deAw0qMmIQxtbv638Bpad/vhfRh/cN7QjvoydM0tCCdH72aWSWqPlsRmW/XG/VMDZbW8J2XUt3YMrFuuw5R8zLL+5f5fdVMlEOT8T/sJZJJbvMrFuQ8vHduunTOGt7vDT7+nIAIzn32KTxsHU1mCDGa+wWUQrp3gXAQclH/VbR5MUTa9jPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 20:27:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Wed, 19 Feb 2025
 20:27:52 +0000
Date: Wed, 19 Feb 2025 16:27:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219202751.GA42073@nvidia.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502191117.8E1BCD4615@keescook>
X-ClientProxiedBy: BL1PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 884d747f-78a4-4194-b02e-08dd5123e260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+6eJB3mDvzHFardTGV9i1ZmP/ouEYEfj2GMI6pLXDWgSBzNop2Xmd+PjiZF?=
 =?us-ascii?Q?vd6UQZ2c+msMRxYBfeu5c1/tZi8xrDrcki4jEyt2gfR713fps7nh4XWdazzF?=
 =?us-ascii?Q?uJ/S7JcfcIkJVGwmj93wnkPfBmpJPQtkKmBDQIE+voj8Pm4541XOPWMS/fHN?=
 =?us-ascii?Q?YZ5V4F6E8altWTyqQVeGdesvNw1k+hq8zk3iu/uMZi0lSpKfveQXxi/R+Wuk?=
 =?us-ascii?Q?k5fi66BNIZf+FfkwLzh/xWDLr3iOoAWiw0V2lq4oJ7VDjaeSSAH8cIRlczq7?=
 =?us-ascii?Q?rTsltR8o13eGKIooeHJlq8gzd2vx4zWcynoS/M+aBWXeNZEUH17fGNHlhewT?=
 =?us-ascii?Q?2lh1bdyxnX/I2MTsiDPjsF8P9RrYIh7xS9CFqRRrksu51xYFFLrLBLdztBbD?=
 =?us-ascii?Q?dwQqidMA1O4of7NpniLCIw0zJJSanKuZsaYvveGPuMB9KEDqp5sc6vfT/kaA?=
 =?us-ascii?Q?SXSmlPeV1Q43iKSRy+vktjeSzN72XHVPFtIRXMtBtSxFGMtENg6nXHH3FGQn?=
 =?us-ascii?Q?hZ8+SJDE4Ox6BdBtpRf+qKWF7/blEn2oywhNcj6wdQV/bqLeIDiIWOpDGBhE?=
 =?us-ascii?Q?UK61+Y6IUaIAoMJ+Rsh5R6DosHIsYNj1BgD069AZ2bDogY8OwAWOsqz5VNDg?=
 =?us-ascii?Q?QNMSnDOaCRsD2CCtz504c9q0cEZSZfjceKFjnHc32K4Ea0nm9KdTBzGDj1eq?=
 =?us-ascii?Q?2+H3faKEAPtA6u14lHCeMWjGxdBC+uYhcG5Zc6vI9oeVPqNAlck1YBsBAopa?=
 =?us-ascii?Q?l3wvacO8JTYAfvIaFFI3hpdzrk2c6BguCDaLke9yTDv3el0XBQ1tXSba9cpy?=
 =?us-ascii?Q?XqYQUk4XGnLnILjcaj6fLZjGmwEt2+FmqIzpaabCTl3DtlVaML23gq5fxGeG?=
 =?us-ascii?Q?XliaMZcdHmsIL4Qecl0fQwOclPgrUh1jom8w5azBEq8FoHw5eqyOnq86euc7?=
 =?us-ascii?Q?ExqDklOLmPWinnSs+2bZ/UUsE5WgRop/1MsU9A1r1yjDzrxdzPb3sEKedJk4?=
 =?us-ascii?Q?pGeWNN0YVlZGOcbPM0jAa+mZvihL5rl1QMaET4F0ME8xwS4N1VdTpr3HoCRP?=
 =?us-ascii?Q?YBC1RGRvZJQu6E0uvrLrjG6fp6muR3PaI2sB6/8+zgjFhAl0xoR7CbMVKzxj?=
 =?us-ascii?Q?dA0vZ54yCaSKVYziUZNG958i2x9JhaMD7e+Zr2z9EuLGdci7YkhA5T32uNWs?=
 =?us-ascii?Q?PNN0JnVcqX7Ao8uQCKQEsKy402eI2YKG/L9jVWXqN7zfkdi32VnBkFzBVUTT?=
 =?us-ascii?Q?emGcI9sEsz4qq1JII0qVJn0jR2ICHND8l7ofhMKjd2OFKvGbtWdNtwYHt2Yo?=
 =?us-ascii?Q?irl4d/mkCT7OSL7T2KZLZizeLvTxTcubeYXNlBp8YLUwwSxIMm9s2+J583ZS?=
 =?us-ascii?Q?LCK+B3rIv/LZHXEvoo8oCczcXh1W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QUSB9dnsY7zFQpzE+GCEhCvsaFGmr5NPfNN/alO19gOpVJxQu65nc18EgdUK?=
 =?us-ascii?Q?KCymJqX3ccXtp9HAlYC84LKxsfFUSp143xSjLm8rYIEa1PxoNAV3Tf3HS6hj?=
 =?us-ascii?Q?LYtsb5DB22bHiSZJzZPpSyhNuCcX+CatDeim3FKz8epQXHi5fmcbZLRkDw3m?=
 =?us-ascii?Q?e4hIrGwIMLwz6uRLr54OpWCDqd7ymAW3udk/375jCZXMDx5KjsA0LzZhZZG2?=
 =?us-ascii?Q?CkgaGexcp3XkHO9RyLKppiROpT87O1wwg1pm3ewR5Ui7+hw9LHQ9KsVWwJb2?=
 =?us-ascii?Q?kgcLAmOg9MxbdfNOmcwuX/BT9anxixITRv8vB6i+wl7xnDhz4i9OdV5ix3li?=
 =?us-ascii?Q?TZ2z4iODC45pILTQUQp5rbZaEKiMabqoHzQ/jQdGJellblDQ4PiE1LXzNTIy?=
 =?us-ascii?Q?htrLI6hjkfL9pShn1exZ7enfuKVvi1mmwO6DQQSXJaNsXqbg1+pKHGXUNTe+?=
 =?us-ascii?Q?9Z+JsqXx5/sIgyN+xGGZVD/WfULFfDJ3j0krC66Hsa+Yp8dRCh4HmSWKdt0F?=
 =?us-ascii?Q?a5XyuIH1U1PimNFYLAtkOJ3tR4PWc+4Q0B1TH5YRfSUXzq6vrQo/1IGlNUUL?=
 =?us-ascii?Q?UDl409ObV0P64Ivw/ibuRNtQdMYwGTLXjoAvshpno0V7tK7KEqy+6KGMormk?=
 =?us-ascii?Q?L1wmOWoek5gWxBws/dtON/AN0Sb1YJdj6EUru4GQ9atXpD0GGV9nWYQJrrkF?=
 =?us-ascii?Q?NO+L7SLHY+TmC9H8cLZKV7Xb8g9P0bZSg7jEYA6MByuGToVMowrf+Ij+4Tp2?=
 =?us-ascii?Q?H05L2G1kf3krGo9nz7RNIzf9WStby0lYvG+9U+Iv9TQqZHDMkb3w4J5s6Pjt?=
 =?us-ascii?Q?tAx/TCvSowuJpdTmiEncoyCRmHnXEHqMS3R8AHABf0FRhbGRHSxz3XHFqb4T?=
 =?us-ascii?Q?Krnd5vqCBP9cfGdK44pHqBntuGY9Pm8wfdmgAQlvJrxFHTygkl/0awySSuXi?=
 =?us-ascii?Q?5e6uD33flQ+MeiAhQZfTddIk0qU/eSTC/wiL+84p/NdmKujetPNXRbYOK2F3?=
 =?us-ascii?Q?qEie3x21ERMcRjWtTjEHPxB0G07GFB9EjeRmjNZr7BUMA1OSJbh2tQ2CaGi6?=
 =?us-ascii?Q?Lnt5qTAwAmbkzQ1sX/UY+5Q+/VhyibJPI3+xTfuBWwTwZgqwjEsdRR9tVYPn?=
 =?us-ascii?Q?M44lesjOjmTvoznkBvWyLEE22ORWxgG586OnY1MqWT9cXdcrMAMVtDd0FGOq?=
 =?us-ascii?Q?rmRE+2OiYG0etxz9Hz0XXcnNH1MEeqgRBV41KFqqGNAp6OsfcpqISJdYBhet?=
 =?us-ascii?Q?yDdYMSTQmbTcbQEmbXYqBkQf9ejrl/0NmvqRwdh1erY/2YhkhmG0d1RbAPZ8?=
 =?us-ascii?Q?2VcyLWTuyL/t722K3ReOHbnEHl6XvAvtI0nzUC4tMlZJ3VTUtSCarJsS2vzG?=
 =?us-ascii?Q?XpjnbwEaPMWOQC6kUI5/JoeshWzQyfuV6Hh2ZWkbfiaLB+sxEUEwX5v5I51s?=
 =?us-ascii?Q?7/2z8aUS6rstLm7KyQdWLy9enCRmkeqs3FucQd2/+f+ONMRNS+FsEXQTIgDT?=
 =?us-ascii?Q?u46t1LkHqqR+9UhZhTJmlMveKhVLS83fhJc+ppRObY5hYMwRoyWie5eOgSLo?=
 =?us-ascii?Q?G0GKhr3yGTtuN8WWsyn7vMWks5lhXG8Bt9+kRctM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884d747f-78a4-4194-b02e-08dd5123e260
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:27:52.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxMBxJZSfrNsjJuuiJ48joxfJXI5t0EumQdTQNI5lTqJVmpunnUJa1bH5oN+Xoev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

On Wed, Feb 19, 2025 at 11:17:59AM -0800, Kees Cook wrote:
> On Wed, Feb 19, 2025 at 02:08:21PM -0500, Steven Rostedt wrote:
> > On Wed, 19 Feb 2025 10:52:37 -0800
> > Kees Cook <kees@kernel.org> wrote:
> > 
> > > In other words, I don't see any reason to focus on replacing existing
> > > code -- doing so would actually carry a lot of risk. But writing *new*
> > > stuff in Rust is very effective. Old code is more stable and has fewer
> > > bugs already, and yet, we're still going to continue the work of hardening
> > > C, because we still need to shake those bugs out. But *new* code can be
> > > written in Rust, and not have any of these classes of bugs at all from
> > > day one.
> > 
> > I would say *new drivers* than say *new code*. A lot of new code is written
> > in existing infrastructure that doesn't mean it needs to be converted over
> > to rust.
> 
> Sorry, yes, I was more accurate in the first paragraph. :)

Can someone do some data mining and share how many "rust
opportunities" are there per cycle? Ie entirely new drivers introduced
(maybe bucketed per subsystem) and lines-of-code of C code in those
drivers.

My gut feeling is that the security argument is not so strong, just
based on numbers. We will still have so much code flowing in that will
not be Rust introducing more and more bugs. Even if every new driver
is Rust the reduction in bugs will be percentage small.

Further, my guess is the majority of new drivers are embedded
things. I strongly suspect entire use cases, like a hypervisor kernel,
server, etc, will see no/minimal Rust adoption or security improvement
at all as there is very little green field / driver work there that
could be in Rust.

Meaning, if you want to make the security argument strong you must
also argue for strategically rewriting existing parts of the kernel,
and significantly expanding the Rust footprint beyond just drivers. ie
more like binder is doing.

I think this is also part of the social stress here as the benefits of
Rust are not being evenly distributed across the community.

Jason

