Return-Path: <linux-kernel+bounces-334874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3EE97DDBF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC52F1F21A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A7175D4C;
	Sat, 21 Sep 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="qx7Zo7ql"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2103.outbound.protection.outlook.com [40.107.121.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BD1EA91;
	Sat, 21 Sep 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726934291; cv=fail; b=mhoqQCgjT1pH7M7wWNm0e8YU9iwzAcTka198tqArPXkexm1zfHFzthGt4sZ+8CijVtZ55iJMUn4NzMlt0uvRIAiQi/SyDBd8dZvx3+O9rQmwBt4aEVgNz3uOKyP3602QZbXm/qZvVWBlTudm+ns3H2HhBy+LM9kDVcP6a8lroMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726934291; c=relaxed/simple;
	bh=sAV00VzC0GEX+lmUeYjRAt3cK2sw8hpj+i8tphdx0xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jAowtdYIJtEjSGpq61RslwSepUXXmZJZCgRuM4Vpwhu7b739M/njKvJvsEo5IPODLhp+5UDltUtPUlWgmGtzRQt47JT1Qau4OT83dLFmfKTqTQoLcXcOfN7sbUWLyNsPkPxm2XopQO59CqIzi7J33kdkWH3fnvTCFKu7cGaiClw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=qx7Zo7ql; arc=fail smtp.client-ip=40.107.121.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xur4Obt0hkRYMs1cMiWObDvFbI67AHpHjdM91FHY93j8Z+X75xn27C3jAPqGoKZ2BScxNjtKk0dsoDBzuTKPfhCN8jaf3FXZCcUNMenA/M+x8O1YjZqfEtWmM6LJZoZ7BZ+wKsBzoFB/sjMUjh/XmT2eA0B8ZzsApghkZR1mRLjKT9QiXB4Sy5PwWrQG7b78M5epguxBxtBn/mAuPT9ki3Vhnhj6ke4cPOT8VAwmVmUJHruhZZ3UReUkDIfo+X8A7gSc0Fa07vrNYwvu/lGFrs2Aua7Xb01ZY/gOKmsBeK/6cYeRQbzr3CKf07lifer2abrqGR9RFrODGa1IWP7mUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixv3jL/Tg+XYqgFiY7MWFgSrLreIynnocxXHHLsAFjk=;
 b=tn+H9w3FQ8XVlkWC4ujWPaEM07qnV+bloNcZboEo7rwtsJAMO0umo9Xfi9DCJzZ2lqkhZAidCLtelagVAg6sRexWgSclArn1FaMHrh087D7BWJ25EijnQwEC4diF/34beoscqpJTjF/3jhvbr8GvvbXqITkFx3mEFtgmuzGdRl5Q8+/HaBgwdu6s1Whh9vMXYng4dRsaedaolBvICI+fty2j3hvzc6EE9ikU1JhbBibJZSOSFFSmOchQOq+uheSuOkSRWJM4DdLJA6fQ16q6IHk3QqG6mpU3MN5oGdyBems/uCBZOdnNRVq2pyzI35lAaBB855Sqe+xDEinBiCo+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixv3jL/Tg+XYqgFiY7MWFgSrLreIynnocxXHHLsAFjk=;
 b=qx7Zo7qliHNdJgNrQqprX1UQvvo8FUOAJ5VOUuDdeEeGHj/IPw7IznIWQepb3ZzXjOT8RwxXDt5UKIjdYJSSIJl9R/7eokeZ8b2NFty5nElpKaMBV1kCSGnVjm27zvq0ciodVs9EzAVnvuRBkHJQwcb5yVCvILO3GZ6kiPbWDko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2435.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Sat, 21 Sep
 2024 15:58:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 15:58:04 +0000
Date: Sat, 21 Sep 2024 16:58:01 +0100
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] rust: sync: add `Arc::as_ptr`
Message-ID: <20240921165801.1d1df6ab.gary@garyguo.net>
In-Reply-To: <e7e42ff2-1543-48b3-9bd3-bdef5ce66348@proton.me>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-4-a.hindborg@kernel.org>
	<e7e42ff2-1543-48b3-9bd3-bdef5ce66348@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0575.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2435:EE_
X-MS-Office365-Filtering-Correlation-Id: 086c5375-5a26-4936-b836-08dcda562d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5g4U8xB/BT69CCusuXwIzScDjwjmwhb+kMAGRxIcajX9f8f5OcJfOXOkPHIo?=
 =?us-ascii?Q?sNrZH3tuXnBxphxICkCql2tTIYh0IvfSjN5147E1s3utaJfe4K5OSF2Sh8Tt?=
 =?us-ascii?Q?/YXk4Xa0a/2d3nZOs/vWEmpKnwqpSNowFeAKdts2NM0NCZKEDXGrbP69au/a?=
 =?us-ascii?Q?YK2y/r+nO7fsg1s+KZEvp9roqx/kxNCDpPqv+KlbF/bvz21dd/SmFUF1viqa?=
 =?us-ascii?Q?qVFcL/N4zFG/5wzwKXm1Ru8zJoq1F9PwZTwa7SUAInldT2jm8vTiQ/0hydmJ?=
 =?us-ascii?Q?Vc0WpCskGxVO2li3LaBw6+ghBLKkmk9QCQDxeHji1MLeQdrFIb0NmedX5Gmp?=
 =?us-ascii?Q?U4RFfRq7qjC3jj1RTFKB3tZCtUSjVYoNjLCGb0arYhjyqJANtFwf1JeMhr5c?=
 =?us-ascii?Q?O1IfqJWDMVQcNKhueFnym6zTWSeFQ5LcBFC6dE4KPjt84u6FHY3mzkSX8OiY?=
 =?us-ascii?Q?nTSW64q6jNRNvSmeyckwt+b8hD3ql8X6+ZhzYB7xQvIYC8DFzqR1omu5U3Tk?=
 =?us-ascii?Q?g2/IeDFqp8yNr6YNCtCzzFEULolkdTiHhd4we79cT7efFVqg6nwUP+f7l2uk?=
 =?us-ascii?Q?PsqlzVX6WkyBLCpwdm9EF4b2IJXf4hmW+ABwe69cJoapPVKXyV63ace3w5aB?=
 =?us-ascii?Q?RWgrVCmcwiTFP2NR3GZtTkgkSX4fS0ojlH+Y0+zSmf03dRynemTpVwHCAR77?=
 =?us-ascii?Q?1jPdBZpL9gx+NKVgbmoDovU86NIf4UKlzU1U1cvxT4gLasgmgxK2wL5Fc7/S?=
 =?us-ascii?Q?gUw0iSTQPyKgSeF2b1m7s46YFE1tSj6gRIihyns0jCIj5OUFT7xUDNdSro3r?=
 =?us-ascii?Q?5brE0+3IzF5cHHjsd9iwj0b0e6zsKpNSZ+/6xCdTSP884nSinOhMLjK1phTz?=
 =?us-ascii?Q?aP0jq5n9IlXuRnI3X5aKW4YhsjoIWcIEqr+7CffCGLbw5np0pPhMJwk4KHmS?=
 =?us-ascii?Q?vmq29iy84w8r4d4sKiF5qNFFUsgmul9aICo0ABLO23k+wlKpm6Kvpr2ROrAT?=
 =?us-ascii?Q?6jQfZwue7MuBW6q8OYGJmGKV4IfBfyHRU8WiG9e7QqX0SHSBfNxPRO3IsrLN?=
 =?us-ascii?Q?J71ssWTNPiEbs2QVYYDLop7b/fimPdNqs1h7llEPxXPDa62ueKrTL/paAJZ6?=
 =?us-ascii?Q?4vB0AsZOxILfj/FcJapRoaHsyO3HaWirb73GyGMLYekeBgY4JxQSxWrfKaCM?=
 =?us-ascii?Q?8S2Vh0MBru8XN7tr+blR7/at5QalkH8lMK4lAMo4KSJouiLJIvLT41fkmEju?=
 =?us-ascii?Q?mIZOgU9fHKRCk2kuOiegQVrnNA+qLlvMDOTkIf5StQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YhhV62AhHnTNb1Y2dMj3Ipypm7ClmlDLu1bQbJjQkmYGcqTZ7AfEk4dAwh+?=
 =?us-ascii?Q?QCG5y0vTQRV7yUkd6i9oOlNeDuFsLk9YACU8zdmN/0Y7+K7n+xBC3kmSNwSu?=
 =?us-ascii?Q?P5yRXegtrJB+GTg1yk0jU2I78wmk3YW7asLgEO44syD7Nmvzi4sXfPSX9aic?=
 =?us-ascii?Q?w99VGl4txIdAHcM0aM60uZPuJU76MQrLMwJhiZUnlfRwoiMoSrpbmkXP/r95?=
 =?us-ascii?Q?9aC0Q39/4U8XmKODtwS9Or0uM5iwWTyY0hWkY5F9R4wAboXBePs208e2OuLZ?=
 =?us-ascii?Q?RwMi/8hYAQxdiPVGvBBBp4RwYFY2lAsmsnO09y44boqP9s1RzpYnrso7+xeV?=
 =?us-ascii?Q?h5N9sYFRQm1olaw3BLdyFvzeIAqTLxqagr5FjnIqpAM3OjF57x9OlFh4V01V?=
 =?us-ascii?Q?tM3hYRj2fBm49RaeHVM1q1ju86B4kXvkSMxUfIIm2r/tBIK5xEBlejJTWa7r?=
 =?us-ascii?Q?+wKCK2uirTSrZVH9PaCNf5QbFukF5qMU1iQRVMZUjL/rPv5nmdcoNOh4PxfM?=
 =?us-ascii?Q?WXbn9dec+oxDgG74uRPTh7oMR5q6EAe84sWjM4hdjf6ATmuYt5auZAklqfkd?=
 =?us-ascii?Q?vOUiu/8r5eNEzwvnLGslxfg+4Lhb5JfwIAygSf1q8xHHOHiVZbwHuvgLLJ3N?=
 =?us-ascii?Q?ZuozEFmSibJnHLRzGYCpTBhqmVvZBsUwje8RBmqnPy3NwOQIJMB6cb7270C8?=
 =?us-ascii?Q?XsBZ45EnwnsGDPitPsI/nbN5iLF0+xlWJY5IIgGjDhO58zme6ZXgbgWYzGB8?=
 =?us-ascii?Q?ktVrqBtXdulIQaB3TM44xFj1GKmm541Ysrh8K9puNkiVr7Oze3LJiaS4zr4N?=
 =?us-ascii?Q?r89ZtQUdfyuMzGRqu01pNOKlaw2eIWJx+9K5qBZ8M6g0GOUGUNErNWvwKCMv?=
 =?us-ascii?Q?USRgFBEOCKmVM1Xf1eYM2nnxXYK0OoCediQtQwmbVc4q+b4Z/Uu8NgNERh+W?=
 =?us-ascii?Q?e/WFr9YoBuAKtYYGsRhO15489gSpUKolO8QnzM0wHHBskxMCshkl/nyMxT/5?=
 =?us-ascii?Q?263JLgIkvw+a6kp8LM3+QvxAwSuN95kgth8RKOS7YyR/KYjXYzcCrDDF63WR?=
 =?us-ascii?Q?1TAqaaBSQK60TKYeLiAnS7e+hLnysuqiTqFjMWUSGXKKIUJgcxFTGshD1gqp?=
 =?us-ascii?Q?VUjNCqD1l5DjX6SFdOrLWJzz9Ufi9uMLSTWWS0aoJXvMsVWIGJByY0gYDAkm?=
 =?us-ascii?Q?yeeoptb5zODNLz52Y7xzjQCMkePE7lf2C+8LQFtkGJ7n5teM+hehCrRy/eYk?=
 =?us-ascii?Q?37r4AJFLwT9YQP2zks1fFV9gPj8XC07CQOC7dEuGL8k/PZeKVfsMymjCY7EY?=
 =?us-ascii?Q?9iYILkJhs5I2UxYETdUWcFYHKwWI+Litt5Xubz12em3OMFm0i1k9/GC+vWUF?=
 =?us-ascii?Q?cMAteeZoYWKbp4Vxia7NtlSjeEm1YeqB/75TrsAz5ADhyQ8/Negy8QI366M8?=
 =?us-ascii?Q?sfQ3hRLaakv4NEWh+iMvVRjXw3bCZNYtGBHsoFMkqRW4YQ1dQ23rZAnv5s02?=
 =?us-ascii?Q?aW4XMFuf4ft+CI5U+x2Q/eMYfup/fLKBEDGqkulZhiF67UQ9H0IF24SWhzHa?=
 =?us-ascii?Q?7O90XK8rT3wVhxXbW1626qfc4yWxnCGE2AWoou/pEK/xnioURSFl/zQzAu08?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 086c5375-5a26-4936-b836-08dcda562d6b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 15:58:04.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ0WNBtlU27TphnC9lKE4cVNPQVUK9VWrhjNXVqi9HaeBrR4/9KvpMCw5fW65UO9/QZOskn9M9MqFQZn5areug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2435

On Thu, 19 Sep 2024 14:03:50 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 18.09.24 00:27, Andreas Hindborg wrote:
> > Add a method to get a pointer to the data contained in an `Arc`.
> > 
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> > ---
> >  rust/kernel/sync/arc.rs | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index 3673496c2363..a57ea3e2b44c 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -258,6 +258,14 @@ pub fn into_raw(self) -> *const T {
> >          unsafe { core::ptr::addr_of!((*ptr).data) }
> >      }
> > 
> > +    /// Return a raw pointer to the data in this arc.
> > +    pub fn as_ptr(&self) -> *const T {  
> 
> I don't know if we have a convention for this, but shouldn't this be an
> associated function? Because if `T` also has an `as_ptr` function, it
> will be shadowed by this one. 

The usual Rust convention is usually that if `Deref` is implemented,
then unless there's a good reason to do otherwise, associated function
should be used.

Best,
Gary

> 
> ---
> Cheers,
> Benno
> 
> > +        let ptr = self.ptr.as_ptr();
> > +        // SAFETY: As we derive the pointer from a reference above, the pointer
> > +        // must be valid.
> > +        unsafe { core::ptr::addr_of!((*ptr).data) }
> > +    }
> > +
> >      /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
> >      ///
> >      /// # Safety
> > --
> > 2.46.0
> > 
> >   
> 


