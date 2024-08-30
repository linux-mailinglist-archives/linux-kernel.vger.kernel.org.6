Return-Path: <linux-kernel+bounces-308997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D87A9664F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1487D2839A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6351B532C;
	Fri, 30 Aug 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="k8UHBAh4"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2100.outbound.protection.outlook.com [40.107.122.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5161FCE;
	Fri, 30 Aug 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030339; cv=fail; b=Mz/4N3p+rTje1OZOG6+JrFKjfTU4ZSmaxb286082viTtJ9efFTQ/KhBSqjZsAFJMZvtkPT4olLnc7eskYIEEAfe7zO48+gQwRhrCTfsCf27uYzSEC2/vIuHnSFDnW034et/uaRMO1rpj+1q2Y2swANis5TULX/sCsErPxBH5PbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030339; c=relaxed/simple;
	bh=qCW1c1ukqtxcXn2BhSTl7kPytSUxGZpYbIVrxX4UNX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmxogWAe7d6wKPuugbh/q0AS6P7P7SxhpW5V/pSOVxEsATp+SYeNfMfONkLww8Q93CanKIkFWyT81lOjvSjGfdZdKFOzTr6lLgfzVfuI2Mm2zvFsp14AHdrGYX3dlScZwZgaKEd4tbNWu6InvJ7/Jz/JnTiOCY4AXe+Pz2FI+sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=k8UHBAh4; arc=fail smtp.client-ip=40.107.122.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMrIY2FKpLeMe0mvafe3UZZ9cbx5I8AaP8Mic/GI5y5hzNLc0gJmBh8ptGqJmb/SYGN/9WcFPtg19H/wqrWxZpP+knaVBDf6j20swvIuiG/LUl+bYheV8SzURelt47n0P68wWTJ5/1a5xkfG/gvqz0XZs23U70c8b/EMksJvTcNk/zAKv49kSoPKJG5MgK0RolhWz2z8C/HL6O/H+dCvCAkeFgEyQGHHd2gZMsDbPsJ7FFJjS9CfR+QDcy1RuLbnW5ntLpSzhgfCMoCN2OQ+PAclwNEBhqJNMZ4yN3ELNaimwktZ4CQosNK6Za48J7sjdwJPaZfPX4IRxjNetfrBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFiRl49PPKcnA0MMIxdGr4HHylckDkc7y7+9IZaNSkU=;
 b=Jc/vdT7yx+QvlXqj1mnbGNTJ+4KizkB+7++C3tdlVnBujHw9KnDlPfVmUvZobnPXipsww+oaAdQI62DSC8XpNCs2zKR8BZE6EgcSWwPJLZ/3LwY9/4nr0ftnx+00nj8CDJ6yzIEQfWE2E8o6gd4Fxk7nbeHsDlOEaRtQUYJhB5qUq/LPGHf3Jnth8eP6T354Z0QVM9lq9YfUvrcyn9FGLu39n8yLOyuFdmEdKYlDHJTUpkyu/Kh9aoMO9tKa0QQcGejUuTkWC0FiBzSZf1ZZhnEecHQSg/5mM7C0nnUwTkkds9pZVeJOZ0cv5QKJsmqfkLwb6ilwBQNTf+V8UHFHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFiRl49PPKcnA0MMIxdGr4HHylckDkc7y7+9IZaNSkU=;
 b=k8UHBAh41BNcqE2NzBuo146tV/+jrdQbWm6mGY16kAlXCBt2F0LgWFPN+0xC0F9J1R/Pq7iC3IbsfrjxhF3bGLQm3KBW3ZuIcHx96Na8kLJEHFNWBrc2cOGupWb8b6oJtAWRrusIlR6fJt6YFDfQygeGGFoBSgkX7daIfxjcrFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:05:34 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 15:05:34 +0000
Date: Fri, 30 Aug 2024 16:05:32 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Subject: Re: [RFC PATCH] rust: Provide correct provenance when constructing
 THIS_MODULE
Message-ID: <20240830160532.4a526a62@eugeo>
In-Reply-To: <20240828180129.4046355-1-boqun.feng@gmail.com>
References: <20240828180129.4046355-1-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: ef436304-07b6-4913-f2ae-08dcc90532dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wa+C+0hGSUIMC+0uLtehJVbODirjxKd6zZp4PPEv+EgxnotTGTCt5itNwtDA?=
 =?us-ascii?Q?qZsrl4bIw5cJL0LcSViXZTu+P33GO4Lach/A2LAXFeQ488fwtnL2JXd72pvT?=
 =?us-ascii?Q?YU0RR7doCI4alY+5QQ9RbHljTQKvdJQm8hX8LM+tUTAg0aI3sLjylDG6jUEu?=
 =?us-ascii?Q?wKhy7xVJyMD2FoXe/3R3HO/dpq5JRRtanooH9iuGu+HrBwZGTv97iHFGwEe1?=
 =?us-ascii?Q?R1sBKjP/Eg0fFqEazvhWsLEyjPtCK39ls7FhuBr4/+pPw2SmL4lVFPDbAItd?=
 =?us-ascii?Q?PPw2Pf4J28eAjhvI/jAJX6dstycqKfPfHjMGTd8s6RnacNIi+HXpaavqqBq7?=
 =?us-ascii?Q?FCQPTqf1OQWb72v7gpWKbtLtEL8qkkxL+NCH9mntgZEzGpTKmoIjybxW+QYL?=
 =?us-ascii?Q?kMj6VgKoOUastllFU/t4r9RxbVq3Wvaxn4YaGHPW94a0ns7IfyOKkTwWU3a7?=
 =?us-ascii?Q?u/WJdNjySjh+AP2rQU7wGTlaK+DbgC7P/iBNfByCt5eYEWBfOxrUdYXnDXQG?=
 =?us-ascii?Q?vqSr/gkb7O7zKRI8OgPUiwdoWGrhBq/fbJLStZ18NmqbLMk1NkikxLtW2etW?=
 =?us-ascii?Q?D/wTrpkEXHFv4eFo+JUDdcy68tdtZEz1T/KDI4DFskCvq61euvQL+Pf+/c+t?=
 =?us-ascii?Q?Hv52R+Kd9MfkObeWgMfQ8RV6lOMI5+75Q4nejPMPFacryiP+eiKOWqjS189a?=
 =?us-ascii?Q?uJf42SsTBAUn384dEVRO/sc0madr042iHq8Cfk6OJIW8Sl1BVH3NLd3Zks/g?=
 =?us-ascii?Q?dvnJXk47wEpqg2ZKrCGKR0zeQrhD4m1ewYE4d+/0Ebr/76G6euDR6lf9vLah?=
 =?us-ascii?Q?ZzFYLqjMTm+pRj5wc9Y7HSTRAzyGkchy27uqGTvuWCTXBIJsrqufui7Om5zk?=
 =?us-ascii?Q?NNnRFLWhGZbjiKfnKcS2ZLRKnm/HKdKIeZfgOZvuK00HLiJVNuBA1VFbx9NC?=
 =?us-ascii?Q?lQTr+Ip7LAZrHaMYcHKOsIKrGoGuY0RCRTFeD/xnGQJhZfxTHNB2l1X+4hYP?=
 =?us-ascii?Q?k9ejMTEnjL9Qtkr1/MmKGj0VSvZvHrbtgHFBlXWYEsHTIyDis/P6WryfK2kr?=
 =?us-ascii?Q?VizEtYfs9bhJR4Vr3pEu0TimqZlcsMdxJABSGnFH2eFd6QGjlW75eawP8uyi?=
 =?us-ascii?Q?sNpGzon+VB9KkGCPFHzBeRmbo+u/k6WBqS+6oZWgVP7d07JFA20vJxdpPWpY?=
 =?us-ascii?Q?a/qXeFbZ1Z9FeWv+tq20t9ce4AORvYfen4a3bp01mgYsspqlPXbF8u65Nz9w?=
 =?us-ascii?Q?pwsWBYxLamYSktiOFbrR0/5SD5sLQdcRFg6cOnNALbFnC196yEx/FOAM25u0?=
 =?us-ascii?Q?t5YqOAROM1kJoNNlbmhw2eUnkpPc/6GBKTWiFXJHT3fHug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syImnnnQIYjXwyetbGDlwutY4LE+3UIbaSYenKRflw6Itm8wafhqQ+8PQiCs?=
 =?us-ascii?Q?sbnNzG/8fef99J76M1iE7W5tbpib3355zLtigWyRqZaqAsHxI2NsBoEnCN6B?=
 =?us-ascii?Q?mTqhA8kEIDgfb228k2nEXqy+9LyIBLk4ugAtSq6UQklxp9d2Fs1lZfCGUrpt?=
 =?us-ascii?Q?/mN0t9RkzB5pSRaTPe9aQxc4OVpmwoqi7GSNdAzFIvEvtUkiqrC7dvnVkY68?=
 =?us-ascii?Q?seevuU4u+TGUlWaWkjjgOZ7Pia8Z8ubxvpMaRnsomruw749iAP8Dd9vYsAOA?=
 =?us-ascii?Q?bad142UE0kErPpmRmIpIfYCe0go9H/T5rpiJUsmWkDZIkQHLrMzpgHz2nfkD?=
 =?us-ascii?Q?DXj6O4LBeR3mMbbU4Yo8Tlux05CyGmNpC2+ZFCJpbV2nUJdyzWnpP1aIGNzh?=
 =?us-ascii?Q?GCLTT3C5GN7SlmrDOEFNJehLgprTJYjaRl9mz2aLk+UBhFPc582uK4yGfe8v?=
 =?us-ascii?Q?Vu4hgB+uCDFQD5xBg17ezKZHoYNPrkbSmUmLWC3Y9TFMkHgqiGdo8c1zFECr?=
 =?us-ascii?Q?XfzddcivkP5oT1qLGA9Jqdwfr3+Cdtej1LvPUwEIZU3olJM9TDBqNBe1259D?=
 =?us-ascii?Q?QdLms0LK8hV8mEah07slumsedpxncsBUxzPTPisTZk4USGJsKjTsVpHXh37w?=
 =?us-ascii?Q?dkO9VDl/yfifXjYV/2cBOZGI9ZygmrVnSVHl8awu92CeOYUY27m2XL2OJ9kk?=
 =?us-ascii?Q?gSWzgAx8X/XUsF+g/74yzmY19ds9DhHoiMqEG5MQWjrsFDquBEWHxQ5V6eVn?=
 =?us-ascii?Q?4TXgetJz8v22Fg8IPeC+hSqXLoneVrib5E+yQYv/V9GvlCHgg7NO+pIsUhTO?=
 =?us-ascii?Q?070jhwL1U7yDoqL+jczWFHJcwYjJI8kVFzoj207KsQC3eZ+BA1hXyrTGkrlG?=
 =?us-ascii?Q?t9JQNq0E4hJXkM1pn5leeC/Wudr1Po6yzuhXB9JtMe4cyjmBtUz5Z74pJwZC?=
 =?us-ascii?Q?kYyflW7jLPmVUVhzgep6GyxdpowbBHmMSsOECfM5i7i6EFnCBJJcsGPxWfzT?=
 =?us-ascii?Q?3jR+iuCZQahZ2wXGHO90+07AVET3uSvuKYieH5hgEh6L/TKWw256Py0NyIQt?=
 =?us-ascii?Q?fg6gsQTF1euEjSyAqfh3bSidYNv+O2H19QZNkYpdJOOrupfHbPNLV3OYhb5A?=
 =?us-ascii?Q?FrFfLKKDSEMCFOdkh07EiUA8V5ksrQKhmyPkWpZ3XMMOdvoXEObViQSOyrkQ?=
 =?us-ascii?Q?g7m2gKRzXIO9Y5Z7ayJUykLlj6BhR9LE73hBHD/XdLAAGEWfeXSvVQdRbMGI?=
 =?us-ascii?Q?3HG67FbbYKRUSMfQP42jqJLpq45bsdgYZ6I1FY2BvJYRQRbtp9HFc540z8Rf?=
 =?us-ascii?Q?Y8Csm1IEuKHPC8uxYYk0t4NZe049Ebkcu0N1UEZe7gpGHSVnuk8TQjGHZRU8?=
 =?us-ascii?Q?OW5Q+im9KaQ3I34k8ulp4bwZYxGiWFVZuMTVljoVimWg4mnkGEjdx9zbvo1b?=
 =?us-ascii?Q?DU4VhjTy7QkqY/78Jpncfbarln1XUzAU+A4VBiMmolWYVNyRU0qie2eeZlge?=
 =?us-ascii?Q?6faqKHTULFAzAZsQKjcFz6IR3YH6ddRPEhguCIiV/IlL+AmxWT32tQNQdl1D?=
 =?us-ascii?Q?XlkWF4LXklt0jMv8UzDvsw8ImqpbEOWkOeS7zbUy?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ef436304-07b6-4913-f2ae-08dcc90532dc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:05:34.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A/YyUOYB1q6zRPos7vnrs25PahKG65X26m2zELJ5/fH07UA9FSlcce7bFuAZ+Gn66/UX35XkvhKsYTXH/qsng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2051

On Wed, 28 Aug 2024 11:01:29 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> Currently while defining `THIS_MODULE` symbol in `module!()`, the
> pointer used to contruct `ThisModule` is derived from an immutable
> reference of `__this_module`, which means the pointer doesn't have
> the provenance for writting, and that means any write to that pointer
> is UB regardless of data races or not. However, the usage of
> `THIS_MODULE` includes passing this pointer to functions that may write
> to it (probably in unsafe code), and this will create soundness issues.
> 
> One way to fix this is using `addr_of_mut!()` but that requires the
> unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
> an extern static `Opaque` is used here: since `Opaque<T>` is transparent
> to `T`, an extern static `Opaque` will just wrap the C symbol (defined
> in a C compile unit) in an `Opaque`, which provides a pointer with
> writable provenance via `Opaque::get()`. This fix the potential UBs
> because of pointer provenance unmatched.

`const_mut_refs` is getting stablised so we should be able to use it
soon. I am slightly inclined to use `addr_of_mut!()` over `Opaque` in
this case so we can use it directly from bindgen.

That said, the current approach also LGTM.

Reviewed-by: Gary Guo <gary@garyguo.net>

> 
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/macros/module.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 571ffa2e189c..aef3b132f32b 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -217,7 +217,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>              // freed until the module is unloaded.
>              #[cfg(MODULE)]
>              static THIS_MODULE: kernel::ThisModule = unsafe {{
> -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
> +                extern \"C\" {{
> +                    static __this_module: kernel::types::Opaque<kernel::bindings::module>;
> +                }}
> +
> +                kernel::ThisModule::from_ptr(__this_module.get())
>              }};
>              #[cfg(not(MODULE))]
>              static THIS_MODULE: kernel::ThisModule = unsafe {{


