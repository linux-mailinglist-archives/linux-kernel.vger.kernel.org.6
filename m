Return-Path: <linux-kernel+bounces-346493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E52198C549
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479191F24F85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345641CCB45;
	Tue,  1 Oct 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="lux51vG8"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020102.outbound.protection.outlook.com [52.101.196.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDED1CCB37;
	Tue,  1 Oct 2024 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807152; cv=fail; b=n9T9SuJNnCC76dkM+dYmSLtIgavu2FpRF93uhcXHBbjRsLIu17QXcn7rCmXBv2jM18A9wN2LHUsYo4dLr5h/eCB7xr7Dv2QxHxg051eiqQQ0RQtyHXMHQE9ZhpQdcj7lemaZEJGYqwvJ+5j7wWtB25ZnktepEpK7s8DfvRPdiQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807152; c=relaxed/simple;
	bh=GV+tn/f5DviVkKtRgIC6SqjWhuLIhp36OwfCGItU2Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaPdPi3j2c1OcjV5hji6gK+G4UOsZc5XcSbqh7+0dksNqd+Aw3y9w5lvl0R9La6dHkNT/dkNn/qpCsTKH46UCLyy5qhgc0GEogx0S2MFxhDq+PU9C9q2J80dhMLK/sGrvaQFJUbNOQ7clfpkijbtUzutvO7YfK8Qtr9YOcrF/bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=lux51vG8; arc=fail smtp.client-ip=52.101.196.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thT/UCEE0hh0MXvqsLUTkpl/iJfbabLGh75ccCWDgtdSQq5ZlVUVyTHcWOaYYYI/1ylS0j9tDbK8ET13HCFEK8Yzj6E0/egy3DNNnz3uOr2OmvRycl078+zTw9kbTZKlVkU6gDT+O63ecF+EEi6b34kzxXMAHlxIWRQVlPMbgn8xRCZw0CEBtKJoF3la9U0UnjGczi0usNJ5pZKojV11GpHcZKnZ3Fm8pOoDVdWE2RZVCQqJnBknHimik3MP29ztfxs7aQ3bqxqBEde0iO6W3HpOk9Bmhx0t32kLzIRKd3KbpmRwzG8O93xuh2mNN4dXas74yCaITSCVnp0CCINhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTRIV53owyapCZKuXVE9/8xNAtA+BFQsqbjX2rxUUog=;
 b=Q7UJTkHQMYwEPIOVP4Yf78gW1woYK//v3+fNGkbBNzyLesGLXZHfJC5lbTkVISHXilULEEV47HreZ1E+RJMrYM7BMxm9X+JflgbDm5H/qLVl2LFF0uwGniGhVFMCd5zWNmBU3obfyEb41TwKKlE0quFDHVd5rceXlILM+FjUXwA6IbWgMHKgVTYHDSNmsrVKhibTEdQDduvj//z4b6qLDiPWSNQlluCzH1NhEJd5tHy5Yy4S9dNNe4l+F3P8cCHmPrhczyuopwaRGVn4LJfmYq5sg4jWPUADIEiEolm2b4pzzstkMCzvxU6gcmFfFl2/J/qhAH3wnNbQPBA7OTBDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTRIV53owyapCZKuXVE9/8xNAtA+BFQsqbjX2rxUUog=;
 b=lux51vG8Kgt++Lz1haYSijQiOzkvRlt37qovaKJamGCOZ3V24YksF1KtYdZ9MMXc2JziNq8qz+pva3vhHjibjotuvKiPgnjxEsGvGi24ghFIZhGsnWUNgXq7q4QvX2rz90g4C11I8VyTnaG4na/if0Gbn+FQvW+6Mz4pspaGdJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6618.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:25:48 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:25:48 +0000
Date: Tue, 1 Oct 2024 19:25:46 +0100
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
Subject: Re: [PATCH v8 05/29] rust: alloc: make `allocator` module public
Message-ID: <20241001192546.6d06c324.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-6-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-6-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 0117bf86-8b49-44f8-3a30-08dce24678fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4LIa2MBNFvQnss8SLn3mxd2fQKqxYluVHA2Ed87avwqD3FO2OXFeknQyiqhd?=
 =?us-ascii?Q?c3gV0+eHv1JFUQakBPGTM8LlAeybRwZWWD3HeQZemcr8DvQJm43HXg2yjxZR?=
 =?us-ascii?Q?j645/6swnKzrCybAx6NJIUtH+duCBKkgXM+5q8bJyEpatYh38JtyCY9T8w2+?=
 =?us-ascii?Q?SpgAGehyzruTBbzgo7hW0d6HJ0QVgHQIzkXJ6W6JOt3pYCvo9VZcozMsum38?=
 =?us-ascii?Q?PKBqB7oqBzdP0+n1Sry4vWVj2aObFPiwG6YJmF6FB/vCzkMIxeeq1Rc2jtaT?=
 =?us-ascii?Q?bDjTylCxifCdhYuGhmP9NdgrMNSUk0EU549CTRKOmHpKcEfYRXxy4ewyc24S?=
 =?us-ascii?Q?iPb3R0NlLjn4TGUFa9iv52a8D8o1SwmH//oAu04uvWs8qV47DTFOQXKmAopv?=
 =?us-ascii?Q?kistOA1kWv5FLpa5hJZIBuYSGOpsXbyGnTOoW7MqVqMo7lNc4Bcf+u+ssI1/?=
 =?us-ascii?Q?J/l39szTPlYHQLgk1BVsQBdfo+FtUbjQQVesve08KWE8NDEaz+wh108yri/L?=
 =?us-ascii?Q?XUJmDGoF1V7+8sLZ2hmanWtr0P+7WpeMXxbko/MIX2ErCI3NcKOmXz7BoZdL?=
 =?us-ascii?Q?yMukUGEC/6xc/ge6mBs3V4JmcGyQc1zt4eeYCt5H+YjwyZH42xPRRqyAe4Lw?=
 =?us-ascii?Q?1YvGCg5pFOWS4A4hu83lMw2NZnmiXbqTX90qyB3e0HkU5vzewmxZGvJJQ01M?=
 =?us-ascii?Q?inXDvGSE/Bo15q50MdqpWrUNkywGTaywv2hUXOAwESG1aajxlrK/FZeklPFI?=
 =?us-ascii?Q?187KYM6qgS1Aoo17kDi1/SnkasdS6MzKFxmw55NA1kgS2e4aQEG7le1r1cjR?=
 =?us-ascii?Q?1Ewa//xS8ddA4aR9BTKTeNA/vtS38w7VH1sv4wcyqCxYawX9NDFuUJAtk4rx?=
 =?us-ascii?Q?BOqIjG7Zw5R4noVRKO2flRMLnnxXDAxQ0LIjhTVFb49rMXWAuhQI+dyeGUIp?=
 =?us-ascii?Q?34kIDj4rAt/4xyngkz8+zxgxFlfbOEHskR7WLKt5qeIvOeCjS3U96KUd1yOk?=
 =?us-ascii?Q?86kyXOu2bjfaN4e1X3o36SOzp45sSJ4TP7oNEQZLkAEmy+7+CsQQq8hOrZfD?=
 =?us-ascii?Q?RwsZiZ0U/8J+S9Bg1+ZOgVIVHfc3my0jNIz3mCi8nAFjU7Fk4rPg/t2+PAh9?=
 =?us-ascii?Q?UyZTLFqJcUlA29YbATGVF/0OoVNLfdK/ipWVECuIz/6jUMsdnY+zYa6HYFUh?=
 =?us-ascii?Q?GEUvGOHnJgMQLgSrX9Aeu3fDiaKovx+FBfoUJYjzPPdhtj0T8y22PADNPQZg?=
 =?us-ascii?Q?7nslBRQ8RnXGiXILc8vt9y38wg7cK6aC0/5/egD9vA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIASpnTYvnn82BKHWeC0l34/wyLsPWjAJWI0ZMpipkWOdBMyULke7zxwgZGt?=
 =?us-ascii?Q?e4wFpzZHcdUAJ0vmHLA7hGUkBrWeS4zKf4/8cpwUoVIJIpKUIgT1wAAE542Z?=
 =?us-ascii?Q?Z06FfVLH59e0FT9I9kkq06ErtWQCZKoXv14vSNYN65HXH/ICpiY1ZIh1o3we?=
 =?us-ascii?Q?rpA2xrwapzA156UMxZ1zw46b6NcadJlZV+0t8x+IEuqnh3o3Etxorzlcbhy1?=
 =?us-ascii?Q?44vEL5ySTpqetRSNZlxAiEWwIAgsUMUEMKLCMwvk/AModkT60dRDvIQwwQjp?=
 =?us-ascii?Q?C6Oglh4iU2kPGJ5F/U4LBNT8orF2H0dCn1YaISSgSekJS0/rslP0a49DkkIC?=
 =?us-ascii?Q?M9a1B3/SA5yDBTqXpFQkMlW4ccYqTPzGCgCSsO34+vLUsJ4lCD/5iJddv8pA?=
 =?us-ascii?Q?TYnamwm5YmO+J2Yn+cdRAZpOd8TWB+a4JQ+XIn8iVgsy80NIIcxAlZz3Pjak?=
 =?us-ascii?Q?0Zck53tD8032PYplbWgvs1d3rrOvX8fAL7c4vVaVU9LIXDDI4C/+cyOXdeOq?=
 =?us-ascii?Q?azpWHk9XOW6Z5LaRwaNtUGYIHC6u/qBgp7BwaOk0LUzsp8MwlzZRCrzw/WxW?=
 =?us-ascii?Q?xCDVVv4amRfqxQ+Z5Q7gXnz1JouN/sb9mB7MqKvf4OfpxaJlllx35KJHMF6O?=
 =?us-ascii?Q?wzuE5J9ZU+emeuHOq852c2HPsEW0YglzDcs1HiFOV/nLieW/pkgKHtAU5wIz?=
 =?us-ascii?Q?QN7TKAteq6FnJwTyrmSLM16xNzT7VMtNdm1Nkfov7JOqOTjStMIGv1bQW2D8?=
 =?us-ascii?Q?NQJVk+Jt2zukOKdyO/dq99eHvBNZ0XKzBQSOXWTgIN9Us/r4+4yKETb4gtsP?=
 =?us-ascii?Q?ib1N75n4F95id4mZah+06ps/lsiUyOJROQ+u/XVdThyNCuIBluWDFUBH3WFw?=
 =?us-ascii?Q?LFDIVE+dHmSW6acjAqBCzdEvzWj24hpiqMA/A0iYfcYzX/3bu1G90LmqeKws?=
 =?us-ascii?Q?8IYGNRVW123cMPFEu7ymi0nU7PZQwshHqaNH2XyMXyd4Wm72UGC1oho+hime?=
 =?us-ascii?Q?WKROhdqp4OakX3nw9w/OG5IyLH3E46uT40hjFB0qULyFvYZ6Ng/BLg5tQmMf?=
 =?us-ascii?Q?I98Qb2/MQeKcdUj1tUqxO1NdWIDdZ4VWVKntcnoXXDyF8Te6ftqBHK65LEpz?=
 =?us-ascii?Q?1tjAvTGHRfKVYMlmZJUHbAjV01cee92Isrs9+s2JRty2/ZRdBCb9CiBQp8ar?=
 =?us-ascii?Q?o4/tpG8HilukC+7x3ZjNWB/+cm5ErFzPH0Yvs+slWNR2PWPL7aPpIg+QCDco?=
 =?us-ascii?Q?goY5YhEmJZygUcpY8FMV8my/gvMkOdmP1yf914vuabPZK5wL3UAIcv2lsHvU?=
 =?us-ascii?Q?GVpcLTWwjfEyODWJSd5ty67IJXRFBVeu/55hZ+BN+BXm518q7ob340n2KnUE?=
 =?us-ascii?Q?93p5OeYWQcMjRo96YQqEDawHf0EpOpwj5DhAj5x/rAKompZVvMas/OGTEnP9?=
 =?us-ascii?Q?5T07Y7I1ahb3nUXIcQ/hUJj6V3N5Lb8XjJIPt1ZR7oe7/m50RSkX7yrgsCGL?=
 =?us-ascii?Q?U+F4ieOYNA/4gnY+ozSbXKJER+29Ba4uGUE6+TuE90qLnL0JA1BLgtdl7foO?=
 =?us-ascii?Q?rzQ8OTPPpBijhA92i8N8tFWVSdmxKpOtMOI9Eg6M?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0117bf86-8b49-44f8-3a30-08dce24678fc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:25:48.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a4Gn62HjPLDxe232HoEv96wrrt+iCKeiM/UxVN0aMNZxeWO79GNjxrXYsoPUSnUzkFy/C4ITied6TXwqq668w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6618

On Tue,  1 Oct 2024 16:59:40 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Subsequent patches implement allocators such as `Kmalloc`, `Vmalloc`,
> `KVmalloc`; we need them to be available outside of the kernel crate as
> well.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index da49c5306431..91b2a26faf3d 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -4,7 +4,7 @@
>  
>  #[cfg(not(test))]
>  #[cfg(not(testlib))]
> -mod allocator;
> +pub mod allocator;
>  pub mod box_ext;
>  pub mod vec_ext;
>  


