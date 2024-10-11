Return-Path: <linux-kernel+bounces-361259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EEB99A5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ADE1F249FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549DDD517;
	Fri, 11 Oct 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="U2IBMBb3"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021118.outbound.protection.outlook.com [52.101.95.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF716216A0D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655726; cv=fail; b=JZei8mDIumnXFJxL3yfREGHJkXE+SbD+sNdPwCjt02sJWOGolkv6Tn8UZcZkBRoYD6sYCAplPSKC95bNiqzaSVEam64JOxLNuKy9BGjiXyfdOfgphyZOOUgSfZ8zlGbp3LHC8txxil5YwUR39xLi3CjddNbuqBg0JJd/bpicIVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655726; c=relaxed/simple;
	bh=J2iTVB3F9UoBMYHBHh178wIRcR/yz5NEzQfL4mGj+lY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H62pJ04ZtcnqWUG78otK+648kgirLlcoHPPCkM9kjf5MH6x81+iVIPqOwZac/DQZcxuwasGc9XYUJOcvMBI786cR9eJCA7t7bePi1yTX35wPCcWgBxL0OBR2ottxh0Gq5WLXc1mDVrGsoadRdKb1+XgTUoYKKuNEIlvQuopLCTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=U2IBMBb3; arc=fail smtp.client-ip=52.101.95.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZZYc6xBkm0BthsMhAEhZAGN0J9gCcGZ7bYITBUOS8j4JTaIaDmuS6P88LNLJC+lmeR3tt3SbvmwaoToNSfz+GnaNqJUJJ4xOeItK2X59uDRG7zATwL76PwFg7jS17vPkm6KheFBvIyv3m8IFGc/j4yoB9atUpYytEgTHQy8sBijEOdWAgrpWoUoy3mrqGUKfzpA4rYvMOd0ULHyyNcY3xmyFjUfkBgpRfoLoB7Uh3+iDFPym/pVb3Vjq1YlgLo6aaEvMuFMwL/he7QKDbuzOZJxFZ0wc/XSHk393V/9s5PR6olmVC/PROWISlS0LxzPv9rpRelKeyk9YcUTBJiQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZDEr9krCWww3ER29bawVhca1hvF7jicFyyfq1Xk5Qc=;
 b=wihKubBdsRtS8ab8xvclwtL1l9aq/dtoEDl+s1pyPYKL4BkRSJAW+wikvJH3U9Y3I1NbjA1Ue8xatnRXC8b0bu/6wx1Bzw3MeZ3EXMoipIPNeCPloNO/sI7YyAdT6YW/JEu4ry+hqdbyA+IMl4dwrHsbkgOGwn0X4X9BHT89lVpAUpWjUi4hgTRdYbhWbOogFzyWdALL1RjZr1hacHi9wDPJ8H3JplN9rQHpgE+Ihm8mQehdqY70hCVnoj4oxLmTp84eZq7r3RZ2ll2wLZpuk5mKNIeDUEFV0yAtD2nI1eqC8rfXSC7nzZCcTXwH7jfIRP6p29CwQakCoJKDVANqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZDEr9krCWww3ER29bawVhca1hvF7jicFyyfq1Xk5Qc=;
 b=U2IBMBb3nunUUF5dtEFgGu0jFn1FYhVJKCtUChUHW46JEtrDGa9FtDOke/DZ3V72ym1Ry2d40BBZK8WAKLtNqSDvQbXtRxpTrpNF4ugpaqfAcxm7uepRRTmeUNmEsQc0P4N15ciPg7t5HNgy/wMQWdOq7fxTp8vExCMsrxT83jI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2447.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Fri, 11 Oct
 2024 14:08:40 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 14:08:40 +0000
Date: Fri, 11 Oct 2024 15:08:35 +0100
From: Gary Guo <gary@garyguo.net>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: arnd@arndb.de, kees@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org,
 ndesaulniers@google.com, ardb@kernel.org, jannh@google.com,
 song@kernel.org, willy@infradead.org, boqun.feng@gmail.com,
 gregkh@linuxfoundation.org, wedsonaf@google.com,
 linux-kernel@vger.kernel.org, yeweihua4@huawei.com
Subject: Re: [PATCH v2] kallsyms: Fix wrong "big" kernel symbol type read
 from procfs
Message-ID: <20241011150835.465dde00@eugeo>
In-Reply-To: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
References: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0258.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2447:EE_
X-MS-Office365-Filtering-Correlation-Id: 798dac44-f567-4fbc-4e5e-08dce9fe354b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yTt5cbzwuYwq2KL9Vc7JS4TgQDK9Y/KG1j0CURHt6ux9G7jx6qdbX8xjTONx?=
 =?us-ascii?Q?iOn3QnyxisEtOJDeNTlEdc3nIx3EeT8o9rcGGE6GxOH4RQgmMw43qOp8Tktk?=
 =?us-ascii?Q?yWF3B/TuDBr1uhb3x4GdWRsXc9vykKbQPjbkgCaINpIr68ROVhcVyTOVykTU?=
 =?us-ascii?Q?Yyxbrt+ldgx0btXzgnL3cRffZhm8yea+t7QE5NOIrNlD4AOtbZiazRpPhCbb?=
 =?us-ascii?Q?OkaNL4KrO9MxEpgGIpYsygca4k7sFhCxLU/mRUPRy4coJe7AU+A2klR5Sfue?=
 =?us-ascii?Q?ig6UTEaIeS/HUXcrPuzhQl2j8nnXJDKwMwxTgxvmMgSkxKW7GrldpTBahfZP?=
 =?us-ascii?Q?F6519pL4+fcs4ZPzBHfoergX6S3EGGm1ITXAw8uOQO7ZX2zXbb9IoOMSWE//?=
 =?us-ascii?Q?62ZOj4w2MiDNef/Nuhtu1AXe9eS9zGkCiGkh+oln613z+SnSXuUviVaxJH8z?=
 =?us-ascii?Q?YjrtpI4RuDLRK4pM3AyBhkgcJWfFFt2wROFRtw6UW9iCAqFtEB9gu90LhJq0?=
 =?us-ascii?Q?vOMVgSnDb1FCUZNKIKjQpngZyWpbk1OIf4sZbmXRtzIjUjflYCL3etNdtw7h?=
 =?us-ascii?Q?pJb5noS3YWx++/WCbGAjp3FMQ2Fa8kirS3ePi4XDLBqoqqpKbG8iLOar6bTB?=
 =?us-ascii?Q?dsgCW30GUAh+80SwnPEfqL93iehh2Qrx++M7Gg9QaWn2sN+/12gXNxQ9wLpX?=
 =?us-ascii?Q?HuJ/UPMYnvSRTUDWEPpU2M5z4Q6eU2hQLAW8pU1l0KD7X9gG6zhf8cHz6Efu?=
 =?us-ascii?Q?hoA1xT43+mRtDAMr611f/jZm7pOMBAi1iW/pTEddpI5QQFHLSTpCzVmqfpRu?=
 =?us-ascii?Q?NE8GdivYBpZTrACpy42cE3LDr9uOvj48e+6Xa4ZgRLrba1JnSZ2ol3an9Yjo?=
 =?us-ascii?Q?ZGK23dTWdw4m34LJP38THCZ/6XGXAmHoYOBY82LXXnqvZT9FK3MddyUeVvMl?=
 =?us-ascii?Q?xTHQOnexXj32HMTlKMHFmnjCcQJNHb1NcnsdyBBKrpFikKtXfFkmAMKdHPMl?=
 =?us-ascii?Q?qqLbEmXvZTcJoefygkAI8NWX1IhEsqvxq53jEqw9gmXOTMSg5MgT+CYiJvXN?=
 =?us-ascii?Q?0meLEVnYFfb+/LOePcrDoBrxn1RgURgtIBPn9nBGYZLs7PMQqSsbMCxhSQIG?=
 =?us-ascii?Q?0ALywgWWWoZ0K/337tNfeQ+LrkfUZe6R/QjpHs1yH5rx4nb5D9ko0LKzcMxd?=
 =?us-ascii?Q?G+NjbYQ3bkWeimkUc/oPGVUXbJAOFXkNME/CaW/ZIR6E97eRaeFSOM+wXfaN?=
 =?us-ascii?Q?WEJxswKtgBWPOAk1YkaeZhsQSFDc1N6tQK7dRh6JsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5+vbjGuC1Wc4KvaHqDfUwh1tOR98/43RFkvW6Bm4Tl6Eh2nxj6YHcRQouioC?=
 =?us-ascii?Q?+qVwWt5c07QB2ryjF59bO7Fxsb4Ts7tTECIAE73wW65PUXe1gRrxXq10e/Y4?=
 =?us-ascii?Q?LYSPF9FHE3l3x/RELEM+Vnq2EE35lFSNrVFIb9xfTJGUS/UQiedQwDMQay1w?=
 =?us-ascii?Q?D9GPrTUv6y6cmTi+TVONtZhFg0p3W1U6JalEtayQjYGJT2xwlOBzIfJaRfWL?=
 =?us-ascii?Q?M9bMIf5Iuwf5BbvlY9bia5YHdArm1zIc2vMhzdNUnoH19XwF/sO3CzH7d88U?=
 =?us-ascii?Q?hncK+Q/YPY5zakxsPoxu0mdrX7OoiF1H4Xus8HeDf7tuncfkEk5fdTensq6z?=
 =?us-ascii?Q?wpRA13OPQ4iSWdcxFRDx/Z48rWaKEF3dQsXH+CelJZKU2ZLGe2bfE0OAjEtk?=
 =?us-ascii?Q?VwiK+tftdPIqSjQlNUc3DnCtWSgdvDhP0NUqUHyhqx+VywSIT67o4DvOAt02?=
 =?us-ascii?Q?pAqfqbiZpXQM3I9N0fGKLBNHWfm+RiKx0Y5QoV/P2uE2uiBP3ZTztgFnqoNE?=
 =?us-ascii?Q?vOzUCRBjIRem9HEjyEMv+Tnx4Da+sUAOZ9o1xLFdcMugBAAI9sEDr0pVwDrU?=
 =?us-ascii?Q?2n8pTYzSM7xOiZ4VnINok2DL2vO1r3QDYNxAWb47dHkeF95ICqZQ6ZiZGNnP?=
 =?us-ascii?Q?PnhUpTYQRjLRA0UQqfiZCOHL7OpiFrnPI/WIf5YQgFq8JdpGeTz3iU3iwrEw?=
 =?us-ascii?Q?YFcBNq3BuRT8HdGl0s8BsQOylsHt4hfBHqkF+UMHpORuX7SZCqiQCOeXIq20?=
 =?us-ascii?Q?gJFpqGvUVTz5OsQlHC2Gm6sORukvZK7em2gpz9nrmzk12G/pJfxGjnNyF160?=
 =?us-ascii?Q?PC+mckHX4nwQMXnu3UU3IXBU1sAHH8gTmdCN5Z+8PY5ieuBaVq30KKlOQZr7?=
 =?us-ascii?Q?UkucmA/jpblE4+WUyCqylyavjbr2gjrYLgnfX0wrPcssVeNgei+QmucHxZ/b?=
 =?us-ascii?Q?A75Io4rdo6MhESy+Ou7l5S3FEUr0DtMJnwGWMbuETeAMD1t6EmDDuBp11Qjq?=
 =?us-ascii?Q?R8Y6Ee4b2j59IxGVCeHoWdgyE/0gwIQU3FCI4vXf+tx0ESkFWKwDrKstkGEu?=
 =?us-ascii?Q?dyzoOSJxXQOmRcqK9Z0JeWKsNB8s/Vv/ZNHqoJtdDSy467U43VPArvGNPrL5?=
 =?us-ascii?Q?sDXzVz96pxMYvDb1zjik59QXYij4dbeTHCgBZwLQS2UkNZrea7LFCm8qQj+c?=
 =?us-ascii?Q?dPFS0lQFdmhIYte+6cBLf4/TdiCQcatlveoizjpLt66zDOkQLixyC6wZ59B4?=
 =?us-ascii?Q?P/lSwKfc7DR46JtWVniN/j+HBW5nHUFIgC9hadwBkUw0gZx5N5TMzStNouo1?=
 =?us-ascii?Q?dt+x8iGeYP4GC3zjbia/0lmnZ/d2qs/y3YUeNHpRjtVekgAo2MLf1jOqIhHO?=
 =?us-ascii?Q?wxd4FpHWlRmY3JqGZFUXd6HDucH3IEhXZdorIgHfDPeFoEC6GeKh7+s0qpfE?=
 =?us-ascii?Q?MkzoC9ZZAYFfISDbFYggQXmY6W2pT5Iz1HjhBy05/5Zh1VOGn65FAf3q4Y8X?=
 =?us-ascii?Q?CiQDwzRLHprcW3U7H4YzTIg7v9PGt+S4vKu68jf6/rFSYm3btEMieHLrBxkO?=
 =?us-ascii?Q?9sL3KVCeBXJnTD087I845sG6an9VBrJ/QIwggGhnD//7Z+Xs5iggJA7qUFiO?=
 =?us-ascii?Q?QXvPCNys9qORk1TPf3sNM3F78cHlHFu1Qn5sQ3kR0eFf?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 798dac44-f567-4fbc-4e5e-08dce9fe354b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:08:40.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdaE/gqGtukDfIZcY4dEEzF5BsFWmez+SBteNf8dSNh1WTdVUI7x7Nt996LUVnQIwpH1Tb2pmZQsyVeYnsYG9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2447

On Fri, 11 Oct 2024 22:38:53 +0800
Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

> Currently when the length of a symbol is longer than 0x7f characters,
> its type shown in /proc/kallsyms can be incorrect.
> 
> I found this issue when reading the code, but it can be reproduced by
> following steps:
> 
>   1. Define a function which symbol length is 130 characters:
> 
>     #define X13(x) x##x##x##x##x##x##x##x##x##x##x##x##x
>     static noinline void X13(x123456789)(void)
>     {
>         printk("hello world\n");
>     }
> 
>   2. The type in vmlinux is 't':
> 
>     $ nm vmlinux | grep x123456
>     ffffffff816290f0 t x123456789x123456789x123456789x12[...]
> 
>   3. Then boot the kernel, the type shown in /proc/kallsyms becomes 'g'
>      instead of the expected 't':
> 
>     # cat /proc/kallsyms | grep x123456
>     ffffffff816290f0 g x123456789x123456789x123456789x12[...]
> 
> The root cause is that, after commit 73bbb94466fd ("kallsyms: support
> "big" kernel symbols"), ULEB128 was used to encode symbol name length.
> That is, for "big" kernel symbols of which name length is longer than
> 0x7f characters, the length info is encoded into 2 bytes.
> 
> kallsyms_get_symbol_type() expects to read the first char of the
> symbol name which indicates the symbol type. However, due to the
> "big" symbol case not being handled, the symbol type read from
> /proc/kallsyms may be wrong, so handle it properly.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73bbb94466fd ("kallsyms: support "big" kernel symbols")
> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
> 
> v1 -> v2:
> - Add reproduction info into commit message to make it clearer;
> - Add cc: stable line;
> 
> v1: https://lore.kernel.org/all/20240830062935.1187613-1-zhengyejian@huaweicloud.com/
> 
>  kernel/kallsyms.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index a9a0ca605d4a..9e4bf061bb83 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -103,8 +103,11 @@ static char kallsyms_get_symbol_type(unsigned int off)
>  {
>  	/*
>  	 * Get just the first code, look it up in the token table,
> -	 * and return the first char from this token.
> +	 * and return the first char from this token. If MSB of length
> +	 * is 1, it is a "big" symbol, so needs an additional byte.
>  	 */
> +	if (kallsyms_names[off] & 0x80)
> +		off++;
>  	return kallsyms_token_table[kallsyms_token_index[kallsyms_names[off + 1]]];
>  }
>  


