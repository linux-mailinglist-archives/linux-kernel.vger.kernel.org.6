Return-Path: <linux-kernel+bounces-330012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7539297986B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7400B2140D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E21CA69A;
	Sun, 15 Sep 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cwnsz5m1"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021132.outbound.protection.outlook.com [52.101.100.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52701F943;
	Sun, 15 Sep 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726428170; cv=fail; b=QWu1aQcH5ajFmuitcRXScUWi5CWegVozKCWbix9wEWyk7qTtq9NlhkCzd4V/67AZZqQwO4L7AYyj1TBENwRsCYOIeG2OG0OEJWrC2oYQxlBWGzqPcOEl9AkkpbXUubjZAIRmlZweWDh6Gr6JT3HZcSGb30/4AoXXY9GfDanFxjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726428170; c=relaxed/simple;
	bh=GBa6iZCAWITHA6UcabMs8/BIJQ4+CVXQ44XpSxbCPAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xm7Qq7TJM809R+6eMWdKVojQqX5LiGcVxgliSwnY9xar8J1TQ7mjFJ3CdJFTgZlCzE2QpNZvKFuOcTIXvxqC/7D47Sknch0WwszRsUsPBy0P35Qzi/z8fs9k/ddXoGS5D/5tf47DnJIR5rIFwM/BkzblJPUSz0ExdZp7OlMsd8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cwnsz5m1; arc=fail smtp.client-ip=52.101.100.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQMhZcRw3jjlzg1Bf00dDpXjx9amkNC4reahahnb84wxLUbMJFHV1nkAhO6nkjr3wV4HhUnJNxBjuaGm5FG85/faTE2KLdA063ie5tzculxF09Dj5ErahCUUbQ+i/9yUwpeKQuu69+i3uo53fZ2NRLGRSmJXuPyNMzFrFBj+hnISlPO+nnEc0liMOdld89kOM5RTC19W7/swREXBatwDm9PD4w3xfBAb2PtzkloWe9q+9ShFZv2VQpnvEzpXOPtqwS2gYKxzTUfBn4QohRx0DCy9ofczjyj3rifysJNh8deXYS6SfMLpvH0DJrw3z+BkItl+xZkXJaeM8XCXn4i8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WIJ9rdifOWFEAIrQzAJpazZsR/mdljkDlJFhvc6Aek=;
 b=uzOwcszSsaWSUHnggoj5YkqR+kio7cY0htZwrx+S5q9gsNRkJJH8AMBSJR7Ft4NJ/ht3Y2CQ+i7UVMIAftbv1UlJEvuR+pcH0d5tOMYRoS4mxb2uVRejJ3MfkXTTvYr8NS3mxXL2get8sKiUmfEXSsqkRfkT8yO1DBlhTXOTlNNSE6YllvXTtZyvjK5WwYExTut07uc8AjRNV+0vfWt3otcWUYKnnbQMFMTbekyj5IcLQQ76cOdO/CD02xmktFOxXSARmjXzvjU3YJcLyeDldKQ1cl2rUCa1pzBi9/8ntHZMvKAOnnLBSXhS1nRpZTMpRS6y1W9fFyr02DzA/v+4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WIJ9rdifOWFEAIrQzAJpazZsR/mdljkDlJFhvc6Aek=;
 b=cwnsz5m1q2tgDetFhZHqLXqlYr504VtZDToi2UNJkU18xM0oJei98zOS6iIXAKzhXfpQEz78MoAGwms3kFVZMZSInlVELyaHy6inRndMhQbJzFCeGihKHIoEtkekf8W08tIs/cYyuRSjVWzoW413aA4XfbjrtlrTcDegmunlp1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2431.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 19:22:45 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 19:22:45 +0000
Date: Sun, 15 Sep 2024 20:22:42 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 01/26] rust: alloc: add `Allocator` trait
Message-ID: <20240915202242.7a16b3d3.gary@garyguo.net>
In-Reply-To: <ZucTMDCcoVH4oGs1@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-2-dakr@kernel.org>
	<20240915162813.149e21f2.gary@garyguo.net>
	<ZucTMDCcoVH4oGs1@pollux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0253.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::25) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2431:EE_
X-MS-Office365-Filtering-Correlation-Id: 8807c9e3-0d82-415f-3d6e-08dcd5bbc68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cMB236XqfSiUkl1+XFrMxYMZHEtNb6AH2qDLwCA7ss6o8bzm0v+BYDjAPxHO?=
 =?us-ascii?Q?jZ2X967N4jqSQ/DWE4EtRvPr+GBLrjktKRORCU74hRCblhs0ftzteuT7EZ0+?=
 =?us-ascii?Q?vluOFdWLBMCzwSCuYTCwx0Q8KjN1pKUPO3ViYb4rxDQfI8cNgeDPs2EmbaGd?=
 =?us-ascii?Q?sz0whl+xrIhwlcnuX9m+G28OoMvu8/84ZLn3PMveHfBxDiOx4hbTKC/4qeUM?=
 =?us-ascii?Q?whMSGvTa94lli3zRd/tXv0BC5aAVYoWBNutAA1/5ziXNJV13Ol9CQIiSv+Rq?=
 =?us-ascii?Q?sZ797qaWNSxcs0TIiL+cwDf2xGAB64P44ac3/qUNZfI/VrCaSadPP+f1dLuh?=
 =?us-ascii?Q?kWWkp8uRPBo0yl/Wlb5RP1A+nnhyu6IeacQcBGnjQhtmbO2A+PCkhlz0PUhS?=
 =?us-ascii?Q?3wcs74bBgtIiIAxKQJuwOTgKC8EEU3OpFtgFZdc2F9Z630AA1VeVt0l2l8F/?=
 =?us-ascii?Q?9FWSICP/pFVB7FVE0oLe0JCumZXn9MJY55QJNGCurBGxrzD6CiNKaY5ocA8S?=
 =?us-ascii?Q?D/tjecfVERtKlrugi5Xe9fDz6xlFWiasHFry+rWxCqz5k3S1pH9eG9RUtS6o?=
 =?us-ascii?Q?RTgdK1mdUx06oBZJNQtSuwYV73iBdnJwiIFgKtE5tus+8I2fCrjLtdmUDYXL?=
 =?us-ascii?Q?40H3RzF4rYKrWd/Pqas55lNhG/7uZdMy8SrJEZ7ZmDePvkIzxkjGIb54BEWr?=
 =?us-ascii?Q?8EpAv6pqdIW2FtVZTY4ncZwbXPP2RLQgEtvlbthQoQWw5TJB+AhRzqSa4p5P?=
 =?us-ascii?Q?hzUhzxT2asyQSepNczfxaKXSiUBi0PMdOU1t4KCCUAM8v98WiRfAsj4dMvra?=
 =?us-ascii?Q?rStcW5JVE5loMUKTIO2stgz+WTG6npP/5KG7CjJtqNF5h1osI5bHlbo4geTF?=
 =?us-ascii?Q?+k9MgQu3hqcos5ImKSqAmbJQMPsExuW1t2TI0D+FIo3hw4cLV1776QMD1t5T?=
 =?us-ascii?Q?IRph4bnpG4O6XTx7VsMSN5sYgGEw9is8GE3oadstEaHgxJriEOPIq9xOgua4?=
 =?us-ascii?Q?iHz2viuiTqhf5hYqyRTaOHWYHfs7afUGTYvsznFivxrclBgS/XnQmfxIOoJs?=
 =?us-ascii?Q?7RPGHgPTNHth98orynlfqR8clQeiqwXCIpiNLpA4o2F+ZpjZ+TeIHsRkXpWR?=
 =?us-ascii?Q?miixwQGfuh14cclhX0pZ8/ilErFEI1mIG0ycGW+uVErIKPSGMCFMLPoB3G2Q?=
 =?us-ascii?Q?suglmr17OGi0phchGd7PZ1EYv8QL4mpKsBqPaP2Q+UgS9zWAY/GlxRGLXp83?=
 =?us-ascii?Q?EiifTOQ+F+ikxHK2GfxT/XhCXmIm1ldZVzdEbs8vbsYI4fIsw9rEZDRt5CbD?=
 =?us-ascii?Q?WqNDVG+VUqinNl1b47Hhsl4ByIfdoXEsd9RdGprHGHsu7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uW7u9NUhkLF+ykOqvwa2llbUAYTuXGnjff7HD5HM4q1E8z1m72Jmy7fhCQaB?=
 =?us-ascii?Q?2uLWGrKXckOxi75GBlrfcCYk1ew3ZR2wTf9OPiHpt3hrYT29H8aFuRn0nasw?=
 =?us-ascii?Q?KrKR3FzL+lVYf+/m+DiMiLOV1pOWjMzHn1KcT0Tc3x51vQkW/BY4mk1Hy4X6?=
 =?us-ascii?Q?17dZ2Dih961uRwfRQ4gT1G7ENmqnnzNtSVxFJwUlecCioY5idXaIOMZgXktJ?=
 =?us-ascii?Q?BZOCFvB52yQWfUdsQqm42gZCGXrVrEjkhlr5YynwhC72n9h+rIfnhn0VaZZP?=
 =?us-ascii?Q?8aUGQpcElWffY5MUP43YbLynTAC0JbFvxHLCjLpNBPzHpCeTV83F46CFLEtE?=
 =?us-ascii?Q?1QBRRZ7tayJ/2hsiDAFklCiP+PczxE3x46WvnjzYtVZoRmrQT/16r9hq9isD?=
 =?us-ascii?Q?E2hbodCI0ucbmzE6LyYGwnaBgN06e109wPV5r3XndSHFREFPXlcqNY9hh7Ln?=
 =?us-ascii?Q?KZS+IR+rQObtMKXI3lwarotxSZ486cqmQr1ArvxzY93qg8QwFsjxj5B+wJ9b?=
 =?us-ascii?Q?56xWacsQQNlgbTaO8ngqge+s7NBeYA675udmHC3QwQhDQr9qPIqPJ57HOIM/?=
 =?us-ascii?Q?HvKkV/g2M0PmIq/JyqxOap6lrSMbNnC7I/6qjiWYmhVJWbmWAARlbLocZ9iv?=
 =?us-ascii?Q?VB1q50zynUnRQLW8IBU2W942NPTy0JoCvHamsj+d6RQcHjddLGgepRLkXn63?=
 =?us-ascii?Q?DoyYxQSXvx8K/Orkp0DySf9Bl4XM7iC7JIAE7/eL33KFeaBqpArD7IYF9j3L?=
 =?us-ascii?Q?m5WWbRSVkVADpJwBIN9N+AZZbsTFkGKxWRrGAKQlqWg/1y+KuAUe11rx8luK?=
 =?us-ascii?Q?K6ul1JcDyOO5KpTsBSeYOIsmzF/4XE/ULOeONXhujBjjZizZoYOjh4Bl6oTO?=
 =?us-ascii?Q?fP6kDNAEbhY+PUhQ32btofHD/PRElQuD1wPTgsWAL4yw+KrNUhl+HTYR6+YD?=
 =?us-ascii?Q?M2/067tPN3HX2fYCHpEcYuy2wgWde2eHk3WctAIRxyBTcnFC+T8zsptQkZvK?=
 =?us-ascii?Q?O0R5OVILFrzM+DnzPIkYEvH02VsdjnnYB6pxRA0Ry0ZbL/pGSdPiXvYe1nH+?=
 =?us-ascii?Q?tIpDpzH7F1z3GKLy6Rz/k4KkndMUZxYQE1lneQXWN7LjAtJ+3wS42q6Zp9jJ?=
 =?us-ascii?Q?EgyJFUDEBLq3DUsETvp0uqw+iMSasmnO8xRrqbI9jsAXv1CyO85tZdn2aehL?=
 =?us-ascii?Q?uyIEx98Xu0iIRH5TWtQNvSzNX5gshzcUOtVxj7qcg2mOKEqDiFtRSiEhiWQI?=
 =?us-ascii?Q?/O9nBuMJY2isqxA5Ng/hVWN209XvUyt8rz+g2Fk6hAL89pTYsClUI/ITMkzA?=
 =?us-ascii?Q?uM4cB5TzYAU+dYB6xAJliz77MBaZtqnBg98rxBK33spPUqxr5MvbyBxWhEcq?=
 =?us-ascii?Q?kg+5AU/OPBtbdjAao7eFiYbCGeVp+1BjwRLsAnJ25EbRt1gVx8XcRGOg53x6?=
 =?us-ascii?Q?4Sk05Aj/moH68GjaEke32VvyMiXL9rQ6hSkdvRseUJu0shabtIeDiZ9maSzM?=
 =?us-ascii?Q?UVK8uOrREMeDij7siWxthUAYmiaAGNHrw6zjza3QYUc14HJxoSNHIClikoEW?=
 =?us-ascii?Q?1sb68yxbphfXigG6vuqtj6gdticOHUK6OEwQXzIlBFHWVtXGnXtnc3dqmzL6?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8807c9e3-0d82-415f-3d6e-08dcd5bbc68e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 19:22:44.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZGHG4yq+pDF/cbmuNsrRn4BDTTRMpPi1Re+yEv6Fx0QPLRlWjff8S//Z3VNd/Lc9i0iY47Lj3AwlokEvTsfiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2431

On Sun, 15 Sep 2024 19:02:40 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Hi Gary,
> 
> thanks for taking a look.
> 
> On Sun, Sep 15, 2024 at 04:28:13PM +0100, Gary Guo wrote:
> > On Thu, 12 Sep 2024 00:52:37 +0200
> > Danilo Krummrich <dakr@kernel.org> wrote:
> >   
> > > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > > Rust's core library doesn't require unstable features and supports GFP
> > > flags.
> > > 
> > > Subsequent patches add the following trait implementors: `Kmalloc`,
> > > `Vmalloc` and `KVmalloc`.  
> > 
> > Hi Danilo,
> > 
> > I think the current design is unsound regarding ZST.
> > 
> > Let's say that `Allocator::alloc` gets called with a ZST type with
> > alignment of 4096. Your implementation will call into `krelloc` with
> > new_size of 0, which gets turned into of `kfree` of null pointer, which
> > is no-op. Everything is fine so far. Krealloc returns `ZERO_SIZE_PTR`,
> > and then implementation of `<Kmalloc as Allocator>::realloc` throws it
> > away and returns `NonNull::dangling`.
> > 
> > Since `NonNull::dangling` is called with T=u8, this means the pointer
> > returns is 1, and it's invalid for ZSTs with larger alignments.  
> 
> Right, this interface is not meant to handle "allocations" for ZSTs.
> 
> But you're right, since `alloc` is a safe function, we should return a properly
> aligned pointer.
> 
> > 
> > And this is unfixable even if the realloc implementation is changed.
> > Let's say the realloc now returns a dangling pointer that is suitable
> > aligned. Now let's see what happens when the `Allocator::free` is
> > called. `kfree` would be trying to free a Rust-side ZST pointer, but it
> > has no way to know that it's ZST!  
> 
> Right, that's why it's not valid to call `free` with dangling pointers.
> 
> From the safety comment of `free`:
> 
> "`ptr` must point to an existing and valid memory allocation created by this
> `Allocator` and must not be a dangling pointer."
> 
> We still need the same in `realloc` though.

I don't agree with this reading. If you allocate something with `alloc`
and it doesn't return an error then you should be able to feed it to
`free`. Whether the allocator does actual allocation when size is zero
or return a dangling pointer shouldn't matter to the caller.

The fact you `Kmalloc` returns a dangling pointer for ZST is an
implementation detail and the caller shouldn't care (and it also
couldn't check whether it's a dangling pointer). Nothing in your
`alloc` doc mention about dangling pointer return for zero-sized alloc
at all.

> 
> > 
> > I can see 3 ways of fixing this:
> > 1. Reject ZSTs that have larger alignment than 16 and fix the realloc
> > implementation to return suitable aligned ZST pointer. I don't
> > particularly like the idea of allocating ZST can fail though.
> > 2. Say ZST must be handled by the caller, and make alloc function
> > unsafe. This means that we essentially revert to the `GlobalAlloc`
> > design of Rust, and all callers have to check for ZST.
> > 3. Accept the `old_layout` and use it to check whether the allocation
> > is ZST allocation.
> > 
> > My personal preference is 3.  
> 
> There is also 4.
> 
> Let `alloc` and `realloc` return a properly aligned dangling pointer for
> `size == 0` and don't accept dangling pointers in `realloc` and `free`.

I'll consider the API design to be bad if I can't pass allocated pointer to
free. If caller needs to handle ZST specially then we might as well
just ban it completely.

> And 5.
> 
> Reject the combination of `None` and `size == 0` entirely, as earlier proposed
> by Benno.
> 
> I'm fine with both, 4. and 5. with a slight preference for 4.
> 
> I'd also go along with 1., as a mix of 4. and 5.
> 
> I really don't like making `alloc` unsafe, and I really don't want to have
> `old_layout` in `free`. Please let's not discuss this again. :-)

I don't buy it.

Your argument for having `old_layout` is so that the caller doesn't
need to care about the size. But as demonstrated the caller *does* need
to care about whether the size is zero.

Our previous discussion doesn't cover the particular case of ZST and
you said that it reason arise that we need this extra parameter, then
it could be added. It feels to me that sane behaviour when it comes
to ZST allocation is a very good reason.

> 
> > 
> > Best,
> > Gary
> >   
> > > 
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/kernel/alloc.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 112 insertions(+)

