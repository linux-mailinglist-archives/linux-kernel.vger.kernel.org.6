Return-Path: <linux-kernel+bounces-342643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1956D989123
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3855A1C227F2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82294157488;
	Sat, 28 Sep 2024 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DSAnExMS"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2138.outbound.protection.outlook.com [40.107.122.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A41487C8;
	Sat, 28 Sep 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551892; cv=fail; b=FLDXBczGU6ifM2MDHc7hHj0LuM8hXEFfieCHQB/TwmLzQzAc9514iqdN0tLoLL3+ld6iftJhQTWTCqSUQNqvHP9Ezq5eHRpPn64SZieYdZrfeJIEtgAwTkClXGwHDCXI4x2TI0oDne0KR4uRY/fz4HJLJvBdx9g8fZcuzdE5304=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551892; c=relaxed/simple;
	bh=jma5FlxPKSLRc3+3b1Cqy+EguJIZJWgPdL0dR6qAJpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rx0mmOjtZzgK9V0y0nqZS5j0+1FuWB6NvH2pojWqw1Wlw2am0V+M1Q/jKbi6PA6FlRk0Agv/8yA6prmZwUyaJwYpDRw1NEL8oXoS9/rRKwtP8dlNOlweQACuxc6y08Lc9ivm84nqXHtIz5laMJLQqEmIpKEZW3Qy2pUly8XGMVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DSAnExMS; arc=fail smtp.client-ip=40.107.122.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rmfa1Zi+FOug6So0nBvC7xotxhmHFD6fUFotjcJey/M2fcxvsfIYMrOk/VeN9/a8HLfFk9rOaUK8/xjz9fyoz5W24QQQe1Xk6gffN1nRG13c5FtT+jiRJ3Zs5UMMdOlFEu784jtHE/bbg7wT1SV20sfPY6JY5fdyWGAiitJcibEstxqE8oUN7QbR6TPX+b7Jo6TxoK7JGmRdcojwtTarMBh8Pi3HoLkAF8ZbMhTIixmrLhttgx6svl2tYqOlDproM9CFqqeS336QVfXc6k/x6rVzRONctRAcdV6Ni6YdAEEQYpQbsH1cUe3hofGMLIWvgihAffHEQSJFCWOYlF/AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTn2YOxV+QnrZ5wDrwpqOy7+Z9XrHLqgk7/doOcuw+Y=;
 b=nnLIGkyYMyjhBwjQr4mcqa0ROnJdSzaI0tGEUecrPRA44M51N9NCAJyOdlwJ3O05DWd0RYUiLY5A/VJ98ZUZkHLXmpcIxaclKq4dmZpN82iautSJaM0rXWzRgvlN7o9PHS5u0HuZk168Q5n6ILHMJtBWz7yFhaWZP0vWk5y0c9x8eNAx21d8MCqbZtzRbtu+HMq/gvZgXprwynT4Ll0rW4H5BkZTQgIxMd8bGZpd2jzw3wYEPXuQdOMPePtxZAp9dK0RYKusj8DnQTvZB5kyynBvRU4NLmOLpWzb2TZLD/BaSs3NBcsGj2HKOHmtYpRMNNgeb++auZQjILw9k8jahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTn2YOxV+QnrZ5wDrwpqOy7+Z9XrHLqgk7/doOcuw+Y=;
 b=DSAnExMSuNMFxyqOPJvGFS+VP68dnZUN1U0tw1rKRMC0Pis/HIKavnerF6IRGpigD1Aqf/z0LltKNpW9A4Pn+8y33x4cflxproDewGiQEOS+alAPPbwQyELcO8tseL84oDLCBg5EJDVdE35lYXgI1EMKcUDae5BdPU4tzLMlcts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:31:27 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:31:27 +0000
Date: Sat, 28 Sep 2024 20:31:26 +0100
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
Subject: Re: [PATCH v7 21/26] rust: alloc: implement `contains` for `Flags`
Message-ID: <20240928203126.0477cc08.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-22-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-22-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: d8922ee7-c4df-4798-c4f3-08dcdff42599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?248KLn+byA2fWqAlUl4gL3Fk1uyMxg9jNmiS4hMaKoTt5kRyLCT63rC8SfLo?=
 =?us-ascii?Q?Rh0tWU9eGfr+9J29Sfl49k+bV3plk3ZhR91AJbEX3TeAZkO156ZYCwcd+RPe?=
 =?us-ascii?Q?/aBGoo98e2YDvxD0DK/aPMsCJVNmrujPxC5uIsRh3JdcTLIPqSnTlTrZw4zU?=
 =?us-ascii?Q?B68sXTcHDc04WJtpyvtl32k0me6Fs7VNjqA3BKFf3yqFJgFAgDUnAAraco2h?=
 =?us-ascii?Q?2OG9hls0beum44RtnoDLbKXdVktqBdU9mKuYry9hdBTV6jZnDkfvwwZuyvgU?=
 =?us-ascii?Q?veIHahVdtMCHCvP26qKCClqYIYs8T+qggFj8vYs13ghO7C+3i3KzLF+E5OcD?=
 =?us-ascii?Q?WJPElAd/jwz8WcX65EXPdFh5PHrlo/yS0riLYWWoI2snlANa0n+gcHZwTBUU?=
 =?us-ascii?Q?ln8hPseIjFm/kpd8QUZ1EON+6HIEN5Vm56ed+HcAy5d1Ni6hKTUbz718xuUB?=
 =?us-ascii?Q?dLEwT+2vlJBC7AWmr0mO6wW5SULOn6oH5InpmNAkYomEQfQcW083gp0nqUBx?=
 =?us-ascii?Q?K1TEWRmIoJUfS6vvz+dyHe4TMZr+kPYb/335nNiHIdtWFNznlnwJuYRbEdoT?=
 =?us-ascii?Q?mvSUvd5KyP+mrR4GKk8wL2zdgoWOY3rOdWC0alrVZWwicSXhOiKi9soOMohy?=
 =?us-ascii?Q?t8Uvd+uC7mC1uPlS3b01Bghv41+qeI6uVHtKlkN//7DWRz+whi7kDEAz/aa6?=
 =?us-ascii?Q?8zJIMDhxw+zWuveZOS28JIT0tUEbSO57mbDBh1vxAF+RhomyVsgOA0e6lj6u?=
 =?us-ascii?Q?2KJmpKT+CA5r1feA61jch/z60gX8EFUhjO3JgPJ8zdxVcrnsela2MWhfHh4Y?=
 =?us-ascii?Q?nscgjnAFTcT0fWpq8qpezDDFgI8TMV9dM9j1HxSAPGG4K5tBvRYBPGtmt7L6?=
 =?us-ascii?Q?+Kt96ERXne3yDdgosuCcVEWIH2Iozxnx9jOpr3wsSp4Cgxua+wz2+iE+t/D/?=
 =?us-ascii?Q?x9FNRIiPbtqPs+CfRdVqD3W91/oLqdeFHOdToOZUudTJQb3D1Xlx28kZwb6I?=
 =?us-ascii?Q?SBStMMG0awkOBGDHQBGvzi1sE/8IyjhAzS8elK+lWRWKbM/bhsSg3eZeNQwr?=
 =?us-ascii?Q?pgZ3bg1R/OrtsDzsaXxcaINC2Yh1ksPK/v7ERB54LTw0JQBtdWwWY4lIRr+4?=
 =?us-ascii?Q?oLbiYGFdiMxfCIzu2Wx2g7c09hunABoGWYV5iG26flCl9JwSayLUFxGV5vUj?=
 =?us-ascii?Q?697pOIRjeE6DqcsJOrSJmKb8C3oYHJonkDWy+aeNdQdR+BiqTEw0kKrFyMGg?=
 =?us-ascii?Q?TjgMuEkQ9wgVfhqHxQ9qghiClRS3zgR43brAmJqImZH5cH3cCiQzgF2Ub4W9?=
 =?us-ascii?Q?SEiDnGaofVtEYxXoxIfjQgtcCdZJhmT5L4unASo6LJQ9nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Fv4fiaHpJa6u117Se0ghJKS06ERLz/KSeLlt3V8ZXpbvFvZJkjxIWCGhm/s?=
 =?us-ascii?Q?MDHbVSXa4mTyoKYl3y06cxqwgGqA8UUJsckBV8+kwGQoX8y7elzKXi7HsFGC?=
 =?us-ascii?Q?2D7TPzRZTnVWEUcbIFM0FQaQ68DN06vtv5EgL3nQBMuOu5rhJ2onlacJiU/V?=
 =?us-ascii?Q?iPqHkH3vpirLG/y/0HNE0zCwTl2kOO408fbGLSGkLUGdX04Pjv8SyEQy9/J4?=
 =?us-ascii?Q?uHqEBW8Pmx2gJmemlQPIPV82fKtRAZa73ZbePRlGyBXvKn2BZgm28w6xnFD3?=
 =?us-ascii?Q?ubh1KqgNcghn5CayxOSbhC/6znMgAHNpK8g6YeYA5W/FCT+AmkfdIB3fIyno?=
 =?us-ascii?Q?L37iVIOdgkeUAdlFuoXOyPU4dNUVslEtXbSCcDhODlbFnvXIuDrfyoM+Qn8q?=
 =?us-ascii?Q?0YYzFcXF+6wKYvJHbE72zl0xgn7wfCsROQLilpj2ceLVYMw12sVJS1X9X0E6?=
 =?us-ascii?Q?FGuR+uRlqFXFxsgEOmedaMY3z7AQJAZUrrzGWQU/Xj4b/wEVyZ7V6fRpsuIa?=
 =?us-ascii?Q?/XlsR59/7m+CyM7jADskUaXBU93eiX2MJ3zMQ5OCvlsCd5/pcu0u/XCQOymD?=
 =?us-ascii?Q?rhQ/DNatMM0KkQGfxWztATHWItf9LGFBlEe7GKfvqo4hkdafKSwJ46w4uQB9?=
 =?us-ascii?Q?gksOZxFhdOxkA8bXaZSk7zbjDWAbWMDHN3qRTDH03To435h6bRBAdXxegjHR?=
 =?us-ascii?Q?buTWPVYhE5omOiQFn3y3krQkijmYvQSEbC1Y/Oox5zLGj9HO3p9MOn75Ghu/?=
 =?us-ascii?Q?8j5ZkxhVEl1lmQPMNbHPhpCbjAhuQ/IjsiV/NDn9iWTDn3yEVdSvGtHGOF6l?=
 =?us-ascii?Q?Lid9ZkPea7ne3RFfHQsGAbK0I+4VdEJFnTDCKqmdhMcnO6NK6O2ckS9sPZAR?=
 =?us-ascii?Q?EP+fzCdYvHdsiiWpwIKzfRZn4p+zrDIaU1+KH1TCBsKPv4TqZFXplZJhOn/6?=
 =?us-ascii?Q?ggW4pcsvgpTM72Yt3KNom+fjOtlfwfHL0Xcw5gCx0xUz3KqGJ1NNMRk9MSlt?=
 =?us-ascii?Q?qrpqIUCBfdZ8qom6xsMGhT/DzG2LCDoeMbRKCyTcqe6T5W7LdVfc0fEIg7MB?=
 =?us-ascii?Q?JKzfmTe6Wwnt4aVn6PVQaiFQB1QGBoXg3FneAgHxNniQzxJg9fMsFq13n0tI?=
 =?us-ascii?Q?WWzEdr0qyyZMMNlOp/iy4SD0wJps2Sf1I0KEBa6zt9RQVkg4DXl4BOHywqjX?=
 =?us-ascii?Q?M9APFYCo67VZTi7TfnNT+yJlvikZiHP8DRfM45I+FB5r05kvX85zePswoRVI?=
 =?us-ascii?Q?xaVBJAkUPzyd/EIx8liscD0mLb8FifkWG2Pu3VSA7Et0Ptsw3/0Vxnm+85Qf?=
 =?us-ascii?Q?bu9iSMZIXiGL1ZK+n5SklnUZikDsFuxmCK409NhQVT8gjSZ8QdKlm6TO/vfo?=
 =?us-ascii?Q?r2kT+3xiJ6KyMKU79Zr6Ou5e6xAZcz9osPyIs9XCfHBDuBNQu7Ur5FCqz+EG?=
 =?us-ascii?Q?tlnN2HEJJnmCVAVb6vVRJ4PIhbeSJDC7+mEEHSgUk4YC6Aq8NoC86UXDv+kT?=
 =?us-ascii?Q?aC36DtTuxjn+pbA+TGOLE3urGANb5N/nEL37aTGMu23Zf/Pc8CjZlKCRCmX7?=
 =?us-ascii?Q?BnXvYRGgUfiLARiGo44v/ZxEq02lTyKmLm9iIu35?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d8922ee7-c4df-4798-c4f3-08dcdff42599
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:31:27.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8WI/N+3A8IBFdIA0wYt6ELwJ2xpBSnKs0peDB7nas0jw5yGN1Bio+eDHo1Gk0Fh0yUA+U2wHKOoRseYX6aS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6484

On Thu, 12 Sep 2024 00:52:57 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Provide a simple helper function to check whether given flags do
> contain one or multiple other flags.
> 
> This is used by a subsequent patch implementing the Cmalloc `Allocator`
> to check for __GFP_ZERO.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index aabdf80e4f7b..caa0b9dfac87 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -34,7 +34,7 @@
>  /// They can be combined with the operators `|`, `&`, and `!`.
>  ///
>  /// Values can be used from the [`flags`] module.
> -#[derive(Clone, Copy)]
> +#[derive(Clone, Copy, PartialEq)]
>  pub struct Flags(u32);
>  
>  impl Flags {
> @@ -42,6 +42,11 @@ impl Flags {
>      pub(crate) fn as_raw(self) -> u32 {
>          self.0
>      }
> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(self, flags: Flags) -> bool {
> +        (self & flags) == flags
> +    }
>  }
>  
>  impl core::ops::BitOr for Flags {


