Return-Path: <linux-kernel+bounces-351865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DD991702
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D6A1C2145C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8041534EC;
	Sat,  5 Oct 2024 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Sqk2JXeF"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2132.outbound.protection.outlook.com [40.107.121.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9038FA6;
	Sat,  5 Oct 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135075; cv=fail; b=elrbZrloClGkKAxYsg7jcnQD/dGsMe6/EkhWvyAaiJMX5tBQLx1TwgwbJMeaegoK5RbuaVCiL9frfls19jjT9oeyxgCFOcWxJ+5XkJN1xpH9Dhz/OMUh1caOTBcy2l6+pGGx9w6As4/eds7VwW/y7kbOOq1gAWI4yrqBTzPwqnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135075; c=relaxed/simple;
	bh=YhC1/7cePzQYVXtjfPdB4gw3i/I7mhJ/EWssAE1HX+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7jMdnJqw7y7OKZlSOUqhNoJsh1HKhEREdzpMxqR2RZ6ygU/xPfZJ+vCbQMJVZZE4mbdT7pnMLyYIuRAwjSIbNDt7ux/NzgV/AqwAFufFyd6FzhcnbC8MriIS2yw8W9BaubWKz0ko5xJRV6h2jpAGOXCCC/48/BIU6YIt0/A33g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Sqk2JXeF; arc=fail smtp.client-ip=40.107.121.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/PSV23GeBLHDwmwgdXUid0Ff2RbRuOlN9zIBxB4ml2i4boYND73diAy47cFVAVaRr0ArpnPHw8mZtgAvrFaF/vJzZQOyelf39/GMaGCptosr3lTgpXi1WsCuXf4RGupCdRrZP8QGAkc8qqugCTuWsA9cJU0wHhgiUiyZhz5ueE3FXV6x82c1QpW80prNW95HOmeyk7lTYtYHvmea1hWTAhXY3KzMAXB7XVJtFfttN/9qqq01lc+R4zCkXieQo26uMOqzpDv/Dx1QIjZK3WTmghFzgdgR6ewbWywkCyoV6fQkDXow98NHKnJ1x6RlwXL9x4DZvNruWJZ2zv6ZjXYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wY4yUqHwq6Yg5CAsdUPJ3PeNe9/ffVzeSjaExYz6jQ=;
 b=XNl9NdZvik1+8cvY9/GHMIm8BsohZ1OadRoquSt1S22uRUCSGjdByDubY+hVXiCjaprQopKA9eYVzYw7CZDPWHxFLOXDJCF0OuYkyiKjuZa/pzXLRIhRCRu/L9XBFWlL/af636TQcPfdijoQJ194Ly2eCuzF0g1tefCyksJIvoPRKEJ0mwyflb2MFHKeBo6eY86Ao2LbUd6eFlne4ariV2JzCtK6kESke5KSFsCpyP+I8nkFaDF0raJ8OgxQgScWTTJRs4NXT9WuLqej5xMhSK0Ey0C7B+y6qo98ivvDpXcT/aNe5Eql9sgv62tw6ZDPlIgNQmeso8CjUbXKgZ+Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wY4yUqHwq6Yg5CAsdUPJ3PeNe9/ffVzeSjaExYz6jQ=;
 b=Sqk2JXeFvQHocr2Lvc017Gw7raIyLJJwCs2QpLVuf7qrOzkiR5RbMDc9VVodqSA1ExQhmu5h4qkrLT52q2cOJ1GgxC/MiNA3TAtBbmu+7UAwmXzq/pRGlf6SNcJ4E0GeXy/4KGQJe4g8h5bvyF/EhzoMvaMScZTjkWfTRyQ3sUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB1872.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 13:31:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 13:31:10 +0000
Date: Sat, 5 Oct 2024 14:31:06 +0100
From: Gary Guo <gary@garyguo.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark
 Rutland <mark.rutland@arm.com>, Dirk Behme <dirk.behme@de.bosch.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
Message-ID: <20241005143106.1196fd3a.gary@garyguo.net>
In-Reply-To: <2024100505-aftermath-glue-7e61@gregkh>
References: <20241004155247.2210469-1-gary@garyguo.net>
	<20241004155247.2210469-2-gary@garyguo.net>
	<2024100505-aftermath-glue-7e61@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0601.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB1872:EE_
X-MS-Office365-Filtering-Correlation-Id: 719c86a7-8508-483b-11d1-08dce541f96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?imC2Qq3fk1avB+OIpe2OuzC5EBFQpG7H5luNPhe7rkwQg/Ku7NYCXEgeB595?=
 =?us-ascii?Q?BmUqJjcdRZm6IcvE/UOFUsMySWttitV+ceEH4SS9PF/X6q7AMegmH/aQD0/m?=
 =?us-ascii?Q?R9EFbMlyaPw2s3QcxGPwtfiqUQpF3Ax+rI+6le00P9o1AiGh+IxSx0URLwku?=
 =?us-ascii?Q?6LGMiUlEHQoJTxLtPKsqJCoGE7uqTJ7lFXUXK/rH+CW8KIimnG/ogFCp68Gk?=
 =?us-ascii?Q?J59hfcohu6TSaBz89RolRoy3p6MD5sAzswq6rNRH+fwQzWAhwyF8rKgd77aY?=
 =?us-ascii?Q?ZVdrZVi0k18vNL3Z7oKbh5tGejAbQU3eEMDbjw2HpVJ7kYVLM1Iud1aVR09v?=
 =?us-ascii?Q?RkvLuh7/7litDcDCn51TobsohA82ZzOyJvJiujOQtzR/GELl1tWDjNWfNzT5?=
 =?us-ascii?Q?NB715rG59750rHIMyPH5zsyfw5gntBVhw1ef3T4eivMSCqNYkPmfxBeKc8+M?=
 =?us-ascii?Q?QNy4UlJts3+3QiTGzGgFSCEgphzIudyUC8xi3QyetHcToJCOodxmpBOjMw6u?=
 =?us-ascii?Q?IBQsiavZKsX5uMnpRTQzoZv03K0wCHe4+/I0wfrNlebbPh81uUrc54f/l836?=
 =?us-ascii?Q?SQ/R74pnYyy6aAjj5oVviX5mDgkfzgjIxE5uhLoWSFAP2NlqNUQgENQuBeb1?=
 =?us-ascii?Q?i+dj3fqAWhMrFjTUwy7zu0ysbxs4sKCGCmx+FTyRAt/jQmelSW6zQXq18s3m?=
 =?us-ascii?Q?0gyMQweAas8hbU6GHlsLvhiln/4aHXrrcD6SLNEP15//thFARYmSFG/FF+H4?=
 =?us-ascii?Q?sv7LtY15BoprlIV0UnO+9Z2LTLjZlem5H+3I8ZkVDzytGQosgut9t+MCAcSf?=
 =?us-ascii?Q?1CLkAzuUWosDiyGXgeaQoh/TXKDsOom7pPr5wp/uhlgI06CR0PVz559VsfRY?=
 =?us-ascii?Q?sP/eeW3lRQa1x97MwgBf2djA3G1JtOIbVXwUEvQ8PdGf+/bnE0FFpq4wfzyX?=
 =?us-ascii?Q?Tc4ceT9n9aOqmJP8beN060/NAKMfu/rHM7mLsBIuHuOGdG5XXryuYi30XwHH?=
 =?us-ascii?Q?roRGMn4RrDBx2DmYK7v9zK9z9AZtGVDs95GPPpEG7LBiEUopORnGGgF1Em+m?=
 =?us-ascii?Q?qYwf0xwSuFWCp+Md30iNcK98apLfWUex6Z8qWReUxM0LWxxg78Y4sPgsIhjo?=
 =?us-ascii?Q?3ppojDPte2kgKI6z/BWD4eokIhZ91zpFgX7MQ34hcn46jFVBhr7guiGBB5GV?=
 =?us-ascii?Q?YHgaVNAGNnU3Rl9mix0iAbD0mR5o0mRTLwCHCnSa1WZkbhYAXfHlMtTXRRB6?=
 =?us-ascii?Q?6S59d+kPk2+I4Eo4EkJwHxo1SM5EzhE+C+6+5AY7Mg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?outX0RdLPlW5sMImrQB3oFmPJqxF7P0SYmIgcju1ySO1smvPv91xCsK43aQi?=
 =?us-ascii?Q?I+KbS+2yOlhFPsUVNgFX5dpnQZagpF3jg1x+ybgWBvmbaEeh6rs8mtALa+0r?=
 =?us-ascii?Q?IOvEweZN+dBjIPXJ2hbvfnztMfq4M4SNzJGPmDBV5mCh53yjzJVEUCj6KD0S?=
 =?us-ascii?Q?+MsRmxHlFsMtK9gh+03NxPx00VB+SR5x5sWMa/omKHptDcKIh/KpmVgZTgs2?=
 =?us-ascii?Q?a84tN5VGMcO4M8+/IhcmK03H1o0iEPPvhPwMe2PsqC33PKZU3Y1bczgBDsFF?=
 =?us-ascii?Q?IQrqoqo2iALx5SWvKw4SDVrLiiz9o0STYdQtG00zFZFVSo2kPmksgCbCqPvJ?=
 =?us-ascii?Q?rd6frrZP79Xb5pncfDnNG0Wwe7aioSYW6UETMZ6l1rZcMUajjKucRMYQBsKS?=
 =?us-ascii?Q?eKkK6KN9n8t5PBn/Ccj1DkprfzpNkZz9k4nmQyNKK3WfrQ4K7X3CBVT0MyIf?=
 =?us-ascii?Q?7gkF4D2GEYdAyZJvHebBndfeq/43OWawmAFQzFb2wQGE5xjPUYyzFpUdLxMt?=
 =?us-ascii?Q?7gwN2dySP6Nk0dn24v1azjJD/wE5Tb3btLEatXxu5u2LCjRdVUmnMNH1ZDVq?=
 =?us-ascii?Q?a1veP/2Rsv+25ja2bnRhbZS7FLFVcj/povDvWoVcg3Qk0reYoKJd6j9GNacC?=
 =?us-ascii?Q?6EvpJtMdVZqb+01HvJh1iESwrLZdpN9l0X1RMyEcg6J+ECZqJOcFPrTgYyVT?=
 =?us-ascii?Q?b78+TgTX/7Vm9yOTW/XC4tTcdb0/ctg9fKfEQ3u2xHBXYUzNBI3ZMixdc7gK?=
 =?us-ascii?Q?wPd1Dq5OdLPUSJtzkXsmY40H7fNmGHSxoedRCvrVyQZWWUBWyKvR36kJhXWm?=
 =?us-ascii?Q?zqldlxXHfOpP1bvbYtKDTbkqz1gmJDI/ovp7IZVBR8lXMqVR9m6LhNbOuADg?=
 =?us-ascii?Q?s0+LA/5qubRzYupiXEv5vbTlJ2iA3pdnV6rsSFh7BXtRluasilLLgFDJm0Xx?=
 =?us-ascii?Q?CYveCPW1LfZd2zf0fLpeZoRUb/f/hE/p88JRvsCjA3Hu8WKwVdYg5Lcggla4?=
 =?us-ascii?Q?vUB5TAt+8M+FcXfrgByeLqjZ1qQZUWHashZWlu127Z1y9neq+fLpZhcjNW0k?=
 =?us-ascii?Q?CkF4v7PmbHC8X/LojYeahH7TlyBisP+e6n06txcqiNAuiee7ySUTBcVggjKw?=
 =?us-ascii?Q?Nv7aQcQ/iRoSRjZFg/DvIRNk6he7pseaTdZSze6ej1WQbShH70SzmCj10TuI?=
 =?us-ascii?Q?0HoYEJ6bnAjNTDmeLT3HLkgZ8ZKK4XylZsMenusSiweSU4yJOV0Kr/O4BDCs?=
 =?us-ascii?Q?CIlp42sh5nuEPRe0Hu60KSP19w/RLmX8vWAT3j29DzItPiPUeyKEBG1TUmVb?=
 =?us-ascii?Q?RKva1UsZ66doZCK7JrSb3+pEOPjJdjl1lOJzgvHruvx54VCTW7UKy98/+4Fy?=
 =?us-ascii?Q?6mwSL+G8FvVuXmSmQXPvKI4IWoKDDimDyIfaAZdK25rdLfZQUNTQgAgkq6tj?=
 =?us-ascii?Q?1e0aW7WvHYJ4j1TsD4florcMDRbYFkUWfmqqoRpY5r5rjzTiDJAGdRc1xqQq?=
 =?us-ascii?Q?itOgL3nU/RtTAmoWPDiYq6GPdIbFl7Hje+feA1Yo9Z1KEgtptOxhaH0NhfBw?=
 =?us-ascii?Q?IEYgjuc5nzFX0Z1cxAdhgfDajLmtns3yJ4nhuuF60YA4NtMsf46b6AdbUAQ3?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 719c86a7-8508-483b-11d1-08dce541f96e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 13:31:10.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BabODKhXAHVlEYLxUYD2KajD/9jFS1pJArYRFZm4QAtXbQGUgNM7W1y5dWshSngxUZ6xEJIYSs5W9x8SoonvuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1872

On Sat, 5 Oct 2024 09:40:53 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 04, 2024 at 04:52:22PM +0100, Gary Guo wrote:
> > This is a wrapping layer of `include/linux/refcount.h`. Currently only
> > the most basic operations (read/set/inc/dec/dec_and_test) are implemented,
> > additional methods can be implemented when they are needed.
> > 
> > Currently the kernel refcount has already been used in `Arc`, however it
> > calls into FFI directly.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >  rust/helpers/refcount.c      | 15 ++++++
> >  rust/kernel/sync.rs          |  2 +
> >  rust/kernel/sync/refcount.rs | 94 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 111 insertions(+)
> >  create mode 100644 rust/kernel/sync/refcount.rs
> > 
> > diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> > index f47afc148ec3..39649443426b 100644
> > --- a/rust/helpers/refcount.c
> > +++ b/rust/helpers/refcount.c
> > @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
> >  	return (refcount_t)REFCOUNT_INIT(n);
> >  }
> >  
> > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > +{
> > +	return refcount_read(r);
> > +}  
> 
> Reading a refcount is almost always a wrong thing to do (it can change
> right after you read it), and I don't see any of the later patches in
> this series use this call, so can you just drop this?
> 
> thanks,
> 
> greg k-h

I originally introduced this thinking I can replace Andreas's atomic
2->0 operation with a read + set, but ended up couldn't do it.

The refcount read is still useful to determine if the current value is
1 -- in fact, `Arc::into_unique_or_drop` could use this rather than
decrementing the refcount and then incrementing it again (just doing a
refcount read would be much better codegen-wise than the current
behaviour). I'll probably make this change in the next version of the
series.

It might also be useful for debugging, so we can have a `Debug` impl
for `Refcount` which prints out the current value. But I didn't
introduce it due to no user.

Best,
Gary

