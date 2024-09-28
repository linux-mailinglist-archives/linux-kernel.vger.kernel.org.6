Return-Path: <linux-kernel+bounces-342645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA5989125
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FF41C21E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551EF157488;
	Sat, 28 Sep 2024 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SAa8i3He"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020074.outbound.protection.outlook.com [52.101.195.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AF1487C8;
	Sat, 28 Sep 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552264; cv=fail; b=VENNc/bszR/zWWvrr/BCGkGs/dit4sWqw7ftJhRYwti9VxccrFhxV8bjSm9AOc15Z43sxQxiUrfpG5brUHF/vLYjRxti4RXDplY55QsTqgSav/sjhry3eOuFpqZnuEvq6ESAoKE6huATzRlBU83Y4Lxocj7YexMrgyZO/+/SKK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552264; c=relaxed/simple;
	bh=pnVrCMbukVpWQIS+IYFQ4sJLWfE0wki64Y10tpcwaao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swUhbqx1uoeFy4EsJqKNGnU6FB5kVRrDZBir3+p79f+NotD8Gmo7oLOKJ9fUreMT297hUX3IK4URHNC5nru0KQJDrzIdV6tM80bJp/zhxxQNOy68zavReNVKxqDh0QFKhEURCBwj69M5Lrh1MmrQY/WXSzGz7rk+w385QM32zwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SAa8i3He; arc=fail smtp.client-ip=52.101.195.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHCMHfk3GNHA9SW7Ob09c2xYZgKmSpczwwL9Z2xU2iAvka1XuZsOpyyvKK1VnjsA+g9g0CbYF3VXIUlqzwM3coEXS4VhKwE83b0/Xw/2/9fO294M0NIVshkuJOkqesmBMqG2zEyZVEjfz7y0hLCcBTm1sY+Lt2ZcsWEjk196Zj4i9RgilfYbj5uh0Gp5HKlGm1+NSdHzH2z1YGQW/99bVbOur3ATkpp8ctGic7kABaQEa3ZqB4l6NvSEXSTlaCIg6dspMcF+LmTfCmLcsyPKcGJ2+B0M773WTqP0j4D3Dau1k3LHmWW6R4W8+dvtuUsV1XZIfNDX4Mi44mwBlTo8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6+TgeRZDuPUKcI/vphnn+pojw9h+KHtVck4kWnJbFk=;
 b=EnAkMV+48zf988nspp4fuB37TdDjAmH+K0yt2PhUuJOEN76L8l1tRiyEFGKOD0pKMwt8Rc5C9B9TAo1+VdsdVuNpVehCHUQdSxN8iZV8VqAREYnLCf/d39KFnfH74yC73l6zbBHFLI0DPnkQjYmgW0Z9eFEAjk7IxBvu3XQj/RmPQ7tNeHqtHYILbmG5AcIMx0vg9sot/jm7nXwscgnQT7Np09sdk++RCteX6xfrot0pZa6hMQh480mJ3/Z8g+dC8Rg3cCMPfqoKCTaHWxOfycHNkE+kLMe2sjr+/jEmqtElgEUWvTD9bS2x4ipLT6jeta1F03R/9AWJqqCpjdh7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6+TgeRZDuPUKcI/vphnn+pojw9h+KHtVck4kWnJbFk=;
 b=SAa8i3Hetvqzjzka6bU0gYRpZcqrcP3lLvZWA/VbQLVtAeApu/b2pFpu5w4H3t2Cuq/UH8FChJDIG/xEvTrDvPGihJHMYoyGUVm6qNTGLwZLUS7mqd57dTNCOOtWEgMUOW0Dp75REnDinK6+JZMhyeEXpZkK/E7cdM+80z8UTMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3240.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:37:40 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:37:40 +0000
Date: Sat, 28 Sep 2024 20:37:10 +0100
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
Subject: Re: [PATCH v7 23/26] rust: str: test: replace `alloc::format`
Message-ID: <20240928203710.40bbb24d.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-24-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-24-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3240:EE_
X-MS-Office365-Filtering-Correlation-Id: 362ba1e7-f2fd-4c46-eafd-08dcdff503d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RrcZ1WMcyHzkKxqVGfbFsMdRlbn1zX6KccgCXrzCyEGvJ7BEHZtoyES9N1n3?=
 =?us-ascii?Q?x+0HGFuuuiufu2lQI5sDbvTileX8elezkakgwYmX50LBwyGf4eEd7eXjeubK?=
 =?us-ascii?Q?dCOEP+T2chvZO64P2oVZpVENxP7N/2iTCtJeK4mLlRv9mre4E7Cv+6hKz91B?=
 =?us-ascii?Q?uR8uVYLkfcq7xIfHsXjlPxuh53zvWXKQ76y1c1KPTNkmpc3l1VNhz+ry3//k?=
 =?us-ascii?Q?MHs5ZcVQZ/gUqHT4nfNo18i4L0bbr33zdXk2RfGJEX62AU5RFE+UjM5khCE0?=
 =?us-ascii?Q?KgIBmB4J4CFaqaC+HmQ+kbblIPtBZ0QRiO/B0akg2YmVCHGdWUdJVWuBK1Ft?=
 =?us-ascii?Q?kwGKvGu52tItXc4dgSpZol7adPnnGS23OdLWLDvUdkVHvnxinmo5ICZikrAH?=
 =?us-ascii?Q?gOciDqDZ2pJ2McNhtnbYIKiZoVpfMPH7l0AYGk54/3DTVaMmKpVDwb9SeXCz?=
 =?us-ascii?Q?BBEc6Zwrim8yF02Y2mZS9olLgHD6+eMJtpn2AzhQ+mRQN5Zif8mmhr8eHhrc?=
 =?us-ascii?Q?nIC3t6VlswfyTnab10wYYK0O0C7FwwoJ279b46HDWiYXVvFiDm3Ni9Vm6ezR?=
 =?us-ascii?Q?VVJo4JM4d25P0y+c7Asdu2Grm2RrzSi5u26cEb1IGGYapVU7FGiDUeUPQNIG?=
 =?us-ascii?Q?IdgiyyItqGRoTderiPpfpPfv+pC/4ssxqNqIvA+3APzuldJyz6xcNeL0MJbL?=
 =?us-ascii?Q?QinDCsRv2rvY1Ag2vbKgFnQpcffW5IOyQTRALCQgFiSymb4B5MTx3EHYrfpp?=
 =?us-ascii?Q?7KO+tpmN6TKELEwcfpVovnxMbFfXwqHiN8ekQDYeYZUIDc37YwddSkrbS9Ra?=
 =?us-ascii?Q?b4+IyA8DF4zxlGbL/M5B2K5Oa2LnZfL1hlMMUqrjAJ+v71dJ1D450VgYiQNo?=
 =?us-ascii?Q?9yA1EXZupQNDL0jsuCkGlmdjSdF3EVnNqqu4aF0DNtjOd5D4kGNLyUtmLw6T?=
 =?us-ascii?Q?qK3r4X5+/cVIWR5+6PnbLaKFVxwmHQxQzyd82iP60sBt0Xo3vTyn+vfMPUl0?=
 =?us-ascii?Q?eD3WSBDaEZdcMOTAZOc01BnKdBfY38SP51lhIkAMYsAEezD9p6FL2gmvRYOQ?=
 =?us-ascii?Q?SChrZ/sFmhIAdJWJ0e/Bk7y2rQa5nGmw+Ea+hjIrjhQvnlPlIDZ4ca5SmaJZ?=
 =?us-ascii?Q?7hDCkdjTOkjLiOB/Zz745ukXSyhYjPEInabEHQHzczuvXcM6T9ZD5nGDHt0P?=
 =?us-ascii?Q?3AUWX4XXBkL7CcsbTYbvVurz/H6tuHyLAWQaZvteG/kNCQ+6g3FtDcnPPCfo?=
 =?us-ascii?Q?+rxmC6j4BgnFAgTIf4puw5OY/sI7FT3QSpP+R8bhd63orB1yzm9oeeM+t/1a?=
 =?us-ascii?Q?4nSsRO+FNrfxze5J0eZNZhATJNu5jpgGB9czwlNbJQtf1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OE3Hju3XVOv1ajgambvRoS2fCwNXKFT79cdeKwfPc+4iDmmLpJ7tCeJ2QSNN?=
 =?us-ascii?Q?iQ3iHgQxSHCtKHJfOFDJFkgCUYEi9UApI//qYaOsFcJ/ETmdd7BcXlaiYKkF?=
 =?us-ascii?Q?52mBoqddzMqKRDqF8cR5G0ogAewoUscmJFmkUg/smzs0oQ+wmXvFaVqQY9Ao?=
 =?us-ascii?Q?VmSO0gPZRPZE9vdHpP7DWU8oVBhFIsTIhbxw694KvrRgJfkIONtlAaRzBlSV?=
 =?us-ascii?Q?XkhCeYgrTroatBhpu3Hozqqgxh461oP0Ofsiwwm4O5Og4ngFx4SMpDWNNYil?=
 =?us-ascii?Q?1GkW7snV5PUb1vjk5akXd3+EtA6i8UhRWP5AhGj5QxTCe6bDhTkwLjAU9b9r?=
 =?us-ascii?Q?S0xFipan+i+4+jBeYi7k+2kv+gPwHJ9HF6JtlexQYivDPFRGN1WVmsSQUPxe?=
 =?us-ascii?Q?9S1CtHViWhFp9Y5md8iQAonb45AcYFT00zCJZwNzWL0jzZFTi7Lq5bw2332e?=
 =?us-ascii?Q?pXewJxfi3K/eco+gfaOqpLSMGlol+BuQCl/OoRgAYm3I87yCQgCbQCxmihuz?=
 =?us-ascii?Q?uZ2/gMj9sc+3oWtZf/UB864Z27rBw5AgsgXydvkxXtvdy8d+L+9hD5nAqoDF?=
 =?us-ascii?Q?ix7pmn5PusOy2oUc09TzxR3KVq1PRL6qlzJFVfcAE4T5+nqi1KTmVHXQGOlz?=
 =?us-ascii?Q?YpNDkUrVxKGlugcPJYsNWweovWjeQpqrusXkTYqrB1Z4v4Hyhs5xpKLEoUqR?=
 =?us-ascii?Q?DVHqnpXg8g8AquiN9dMc1X30XpOGbLrAHdtIA/qKIxvDsltguLqI9RJL1/G3?=
 =?us-ascii?Q?Gcjnt+pLNCNI13IPJphuA6GISxfkPmK9Rro/AIgxOelOdqrXREOnjZOGa2KU?=
 =?us-ascii?Q?3iynTQWJDgQOglQk0MX872BAIkMUNcMBne6K/3XFUKF/Lfv/VtMvo91pMJ1t?=
 =?us-ascii?Q?tjIzA7YIb8tB1a9SBPqn3upSBK2nFwmkdg4YeoMwYOkdEVN5OIPCwS7VZ+o8?=
 =?us-ascii?Q?anEOEOfJONUMvFWtAJWHKbYNohT38F8yQsI1T+gg44seGkOIf/GkVzLzQGJM?=
 =?us-ascii?Q?aHlf8sJpVY62JakDwAmYKrZN0bkDtEiyldZPCl1AE6E9QBp9zVN03MDAkN/a?=
 =?us-ascii?Q?nme+Y1tFlC6b8TpIa7hg9G7AU9P2i6Qa7Sf94fZBfZHTO3CopeCQab1bQjU0?=
 =?us-ascii?Q?5rsHIolvqgfyB/SSmET4v98nFEJk7yKL/BoFZQZ4WsSHQsY/dfrtVWzrCBOk?=
 =?us-ascii?Q?Liykq2fkDKxgXEp/xpLi7z8hEcpW1rpNz4pHumQqO/FstvhCske7ZibXhQY/?=
 =?us-ascii?Q?ca1G2uq4LwnUyRzKbq6Z7TtvO0hquTwKTqxb105/b7cHmfjb8Y7Fgkpz8m6u?=
 =?us-ascii?Q?i8O0JnqH7Hb50DsNpjxWDbmRPwvOkGEDMs3Jw7/2GiP/Ex70Ys54FNcNLOaF?=
 =?us-ascii?Q?Ttw8/gpS0sy6QYcslbo2G5oWtmp6njUCf8L/DrI9n00lmW3Exj3bX9JHwI2E?=
 =?us-ascii?Q?eaAtDZvnPlz1MXWYLw7hDF+oHJW+SKTRR6kg/FjpqzkEYGXtSOZwIhriUvhy?=
 =?us-ascii?Q?OOYdNPUxfJzjcAAkfJz8t5THraRefRrrxhlNvmuWGANm2WuZtWXkYXMo/xAe?=
 =?us-ascii?Q?yvP+rv8pqh8uCCdz9eJkxL+sH75zAkA+Kv7lVXKF?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 362ba1e7-f2fd-4c46-eafd-08dcdff503d9
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:37:40.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX9qTV7D3OoHuu8ZPADQ66vq5wQRwK9UrRqE+f7NUoJXQTspTJ+znHA3zmplS32WDZalxjoywg5QIVWF+65qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3240

On Thu, 12 Sep 2024 00:52:59 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> The current implementation of tests in str.rs use `format!` to format
> strings for comparison, which, internally, creates a new `String`.
> 
> In order to prepare for getting rid of Rust's alloc crate, we have to
> cut this dependency. Instead, implement `format!` for `CString`.
> 
> Note that for userspace tests, `Kmalloc`, which is backing `CString`'s
> memory, is just a type alias to `Cmalloc`.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/str.rs | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 209ad1bb1a49..726329530338 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -523,7 +523,28 @@ macro_rules! c_str {
>  #[cfg(test)]
>  mod tests {
>      use super::*;
> -    use alloc::format;
> +
> +    struct String(CString);
> +
> +    impl String {
> +        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
> +            String(CString::try_from_fmt(args).unwrap())
> +        }
> +    }
> +
> +    impl Deref for String {
> +        type Target = str;
> +
> +        fn deref(&self) -> &str {
> +            self.0.to_str().unwrap()
> +        }
> +    }
> +
> +    macro_rules! format {
> +        ($($f:tt)*) => ({
> +            &*String::from_fmt(kernel::fmt!($($f)*))
> +        })
> +    }
>  
>      const ALL_ASCII_CHARS: &'static str =
>          "\\x01\\x02\\x03\\x04\\x05\\x06\\x07\\x08\\x09\\x0a\\x0b\\x0c\\x0d\\x0e\\x0f\


