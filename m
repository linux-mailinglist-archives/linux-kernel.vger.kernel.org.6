Return-Path: <linux-kernel+bounces-342646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C24A989126
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FEB1F238D2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A5158A36;
	Sat, 28 Sep 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="aCGJ6Pnh"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6917736;
	Sat, 28 Sep 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552292; cv=fail; b=sUEhEEDyvnmxtHYnQ7BMgx0+jQGMdiNcu+sAj1zRAgbsWCpaPezB/lZ44puhZAgRzNqcAufC3j844mNJsqreXMk/41x1c11QvapumfQ77VO4gqv6TrKq8iypacOWQMZW2Kbp5+sli29HYJ/gNA51v9TqL6Qaj7zhBPN4pg8urv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552292; c=relaxed/simple;
	bh=5I9nx4PiPIdUC85xWp849W7GgX7reiVele8pbhosySE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzACs0ewBKTJMa0wU37nlT+QhPT6DvuEf3/+zjqz3y3y4cUBnsGR8jDWdtOq5OSuUVAYDyS0sblDHKbodUxbSm/DhspX8VxkGSLUNyqHR5PIL8x3N0Uh+40YBgv4weOUNG4upifaE42g9zcXnrLCg8xDcoIyLXR9tiYR1VuC8jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=aCGJ6Pnh; arc=fail smtp.client-ip=52.101.100.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2iZ4NZjolksvk0kTqA/LtX+/63u5KiAG51kCtlRF+VCwfxcxGhl9+sUDz7CBG4zLd2rFDjAa7EVeyVWltt0d2jMxeEbQiCnWW51p7YmPWwSX2Y+Y8/QiZzE9QAirCsq2WczhVUXUIhqIHNi3g5SwSKOyH5h6CTBVrY8qTSf54rTkI/LZ+ZjQNcXaVuununmc9twf9tlVhqv2p+rE6aT7qtpf+9D75vL+QrxoNORDHaj1CAK0/e+h69iH8tNmp/MsJQoi2KpD9i7erx4At44uEDdk6+qJxBlDuRfCjsU1j+VqojE13l5rlWwLjwKpj06DJnMIZjmMu7Ic74oOtpSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L9VGNcr8nzo60n5pfr0RMG5CObQ1BhWcjgZtMe3Ek4=;
 b=p9zVzAP0I68+VbP3K7LkAfxsC7jrAMAIPM5ytNOXcwJZ2gkq6MhQaqabu5SsERo99rOaUm8QG7oNl7P5a0N5zRbt8YvYwZ2DzPg1igZfoB3Y845ihuHpI9O/5gs076NLaWhwYqvhazVfj7sx7pyGxfVPUhDmru5FaQPqvIJfcdkmGHYLEqWR/c7shjeH77t/rnCzy1SFN8ad1alvYmCdhaItDDcdtvOdX7HEOBy6aZpsE60RJMNMpq7bthwklVxfC+Wq5qzHAbkSUzRh9VBYM7IN9YDutsx3hs6JHq1PljF3xcjbIr4WZvwxqiC9yJoGP0d34Ps8MMM5xnR6h21NBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L9VGNcr8nzo60n5pfr0RMG5CObQ1BhWcjgZtMe3Ek4=;
 b=aCGJ6PnhJNCUsaX9mc/gjMQ6V0SVw+wwvYkGZABEpc4/OdjtQX258SHYJTwdcSXlqDqwvpRo8hBf0YcpCxwloaJRxbIIStn67Aw8KicBZBeVYEcrf/iM/JRf/TIIIfctjOSmfmQUkrXlmolcf9Ol7+lV+LzALEhBI2CE7M8qaRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3240.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:38:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:38:08 +0000
Date: Sat, 28 Sep 2024 20:38:00 +0100
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
Subject: Re: [PATCH v7 24/26] rust: alloc: update module comment of alloc.rs
Message-ID: <20240928203800.6dc19e5c.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-25-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-25-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0552.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3240:EE_
X-MS-Office365-Filtering-Correlation-Id: d27e9975-8c2f-4b9a-5613-08dcdff51453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9LBpwjb8uPdaoPLBraAOB2QXRHZHbK+jmnHrDkwTzJSxU8jkHedaff7qAjG8?=
 =?us-ascii?Q?CIGACM+GVWSVbEwg0npsGwX+FDj0vLV0Hg25inGm3fAMC/vahDMk6A9UF4+a?=
 =?us-ascii?Q?ELtjIgVpt8M62Y7F61GR+pnnQ0k7GxjJPh9bFe+ewa1LZ+9tCQ5fRE1JNBKT?=
 =?us-ascii?Q?Wm8rNI9t347TVR27ytUR8H8yGnATE47wL1/UiKRARsNAwGdMsZFdmOS6v0OH?=
 =?us-ascii?Q?xGVy4uh5Oc4SuwqaSA70WNIqsQyyWIps2Su+aTrcUgAaExu8y6gSfciuwNWg?=
 =?us-ascii?Q?9DMjPE15KOni2x9UrZRgK5miIvmJqqP6SoLCxI3Zb8nUyd5e5vPa0ny1NgAs?=
 =?us-ascii?Q?qfpPy88byRgrvUCE/KjV2zw4GztjSSZchf/PK/Ebnws8OSI7WXvNI4pD6zvB?=
 =?us-ascii?Q?ClOOL9bE6vGUFxJp8UVILRE/U/tpasDqIQoYpQLaRlX7kk+ALOH+uZdo8chA?=
 =?us-ascii?Q?2fJUDFRg4h9qcSPLpnqcqbUFYM4kHJyXtj/UwE8+P6o41bLx1u5SzAxqCaP0?=
 =?us-ascii?Q?+Ye3OsEJYNDNflHF9pucgjxYm4KY7XPItcb6G1JwYeWIFDgJ1EBxzAb/3uAg?=
 =?us-ascii?Q?OjIg8RifuniLTXfWkr90BiJBZ8dN+7UmloIhyZZpz8S1Q8L/fJ+auJQ8dGCM?=
 =?us-ascii?Q?x9dUEFPxodkGfVqpb20VTourPDpj2PorsMyFu78Z1I2VFhW+QssDYfTtnZkK?=
 =?us-ascii?Q?C/S+tX6ZTm4YyEEQM+MAnKOh1VdfY3w98xNAopA5bg9PF0Z8LjI67IAF/lvv?=
 =?us-ascii?Q?eniU5fp+Rl+zmxLJKe/+EvKla08tRWuQCXPX8riBh31sAVpL1Ktc6chYSEEJ?=
 =?us-ascii?Q?/mYtrL9ItSIg9b91PEzDLVDxoRNSx5eInErVNY6DCer++aYViy2dXdo18Fnp?=
 =?us-ascii?Q?q+HgqyTol8JY9Ub+NUzvRPRkwjH4BE17RPmeKAwRaGdvF5hvDez9udNLuOt3?=
 =?us-ascii?Q?WeiDBfTc51lEdR2/+qQRlTHKamATLZoj1IeS5mQxwnqvbDtk0XIlKMbqo0pd?=
 =?us-ascii?Q?oZ7u57L2/BSLlJx6cQsVx1rb9eh7AU/XXlVVEGKQX3HOyv93JX4hRpY7sXox?=
 =?us-ascii?Q?1xtgL7j9p4RE1nN6YN8AaJqxtKT5+zGt5V2HNq3SjKNpVF6uf9MgDY3Mc9rj?=
 =?us-ascii?Q?PGYb6GYVhmi6buCCXuOz2ivue86e1mub8XzXHtx35C/ZJfb4pU7Gt6hjFQao?=
 =?us-ascii?Q?mO/zHICpq5ZPf7+0gqQUrC2InJc0Twzo2XhuH6mmxGZ59TRLlH+dj6nL48Gh?=
 =?us-ascii?Q?jk4rhkSifIFgp6uB/YtHM4oL6U2G+2H7sjhNj6nrM0wokkDZt1GjVdLSmcrW?=
 =?us-ascii?Q?/JkkQIZYtmX7VCd1rS6D4mqtPmAvCzcLvs1/VqF6dsXgBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrlLg/J/Ftq+ojrsL+DjlBUZKuRto+uBSh9yVYnJhFLEZ/hBeXqMckkjPaxP?=
 =?us-ascii?Q?o2W5LnrrRkv3KVXLCgzlOwXWE5Yc6lm7Zqsc4B4LMYNYPbH6TbIBlaXVdACh?=
 =?us-ascii?Q?9E71V6Q1jdzqd2fQ3YCR8g6CJqaF8++vip/0sD5MCvXFCaTwiyctzHLztMlY?=
 =?us-ascii?Q?Zr2nI8vWldlEEimP+MSr2vOH6IKZYBd5WeBSllu0eZcvzjf8OR8O73zZvXjo?=
 =?us-ascii?Q?ja9S5TBveQFbnyBOLMg2Pnlk8RFoLA75a4X4MC3FzB5qEcnpppy170wcpPzt?=
 =?us-ascii?Q?u/bnakVkfYdGzCLeaetvE812iojXd1OLLGJLp3PdBGwz+eSFOmjsXjfz7HKh?=
 =?us-ascii?Q?D/Z6YDegcgwh5mnmUEoJuhioWSN/JPo5nwDRaP1KI0iGILaPEDcA17zUvoPq?=
 =?us-ascii?Q?ORfamd6bu6TleJaXtuuTZuQBHFJM7z6ed0pd5QGIYMAgORKkbbf7OFwPHYAg?=
 =?us-ascii?Q?31C5ZjhxAX8pdv938ERND3hicvlUJUnBdRTakoPb44090KIN/cF5K4ch+x7E?=
 =?us-ascii?Q?mFytpIzGgPDXs5yaVLiUETBvRoQ14hrq1Kee4sesrgfJEdiBZo+zqcUY4Xvt?=
 =?us-ascii?Q?/3lAQfcw5yZmQo5z8e2kGvvHvYdeCxxKOL66/lp+7clqYQqz1G3CxK1kcPjR?=
 =?us-ascii?Q?sXdwxHBJGuGXaMNBaL9mRhPyEebBy7og3ABOMRfb/DJBzRBO69vHWK3mODib?=
 =?us-ascii?Q?99jNyb1v9an9dEQ3mewZsumzD7bpjteLfz6WKCX325xGVe6YocOuvNCU91qi?=
 =?us-ascii?Q?JeGVqqyrtdKt9NOLcityPOpzA0q2vWRDWDacM3xRxKeClktaQ9iE7gaMttK6?=
 =?us-ascii?Q?uvPaCUD/GWeH7P9ZW26aB8Z8REjyC9PvN/QtdhwulT2fJGZ94BQ7fN5VOzg6?=
 =?us-ascii?Q?QKdm9WG5KLw4zRx6+s7kNWn2MMbZdtcxGzrOXB7gJXE8XUDVpfpffdYEhLSp?=
 =?us-ascii?Q?yYSrRqjm4mFPcbdM4czQ2qTU2K9tIIg78wHAg9SZShE+4mKOxr7jF+Gefe8O?=
 =?us-ascii?Q?NvQgD+MJ3ua2b5Aj2n1deVhSj+lGoOrRn2ejThwIL8Hyf61Y4I32QMJhs+N3?=
 =?us-ascii?Q?5JiFZlphaWxk/0y9YgWBH2B9TeOoVNvgMIM3CP8NSjRROZ6r2FRaRZ/1Teu7?=
 =?us-ascii?Q?QBKovRteUaxRPtGix+FzNfgxASQIs328gLkR/U/xte+2AvfzVeGjZDPsNLyX?=
 =?us-ascii?Q?2OeBNye1rZYJ+tiYZ1T/NLpTyVQqXON2liFS82Xvw2+xwY3wvJS7u0tx32bq?=
 =?us-ascii?Q?R/4IwHYv7CnSpUr3qTt6qy3ohtYK4jJLu9tD5lfiyKQqGqKtIsyPnWMrRYyF?=
 =?us-ascii?Q?BbWOBpJL0bNJF7PhOjIaYgAuhBtViVbNTDMJhHX4gfN1LDM8sMi9WXEQW+L4?=
 =?us-ascii?Q?UZfkmfYyRVYlRcvDibPz6bGpdLG4IYs0caip4/8/44d8buvHmSbQF2iydK4U?=
 =?us-ascii?Q?ix6CCVryPNf6lT73+qLRxCNStJE0N0nXjlJoEfIOoD9fI+TlYqZrXAiKvTN2?=
 =?us-ascii?Q?O3MGAQahf2raoF0g2A8CiRoja/b5a3UwLww0SSipkXDeTImfuXBY+10CRiI2?=
 =?us-ascii?Q?OBkwzfZQfdNpLFW+hwl+OqKTMIDk/MP4iT0d8VLh?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d27e9975-8c2f-4b9a-5613-08dcdff51453
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:38:08.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSRydiyafghsRMXrSWssUdD5JTwJpgzCsQSKTfHlLYuY/D198dk4i+0DVj4e2v/oL/0SBLwRkNbmZTxnvMEbsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3240

On Thu, 12 Sep 2024 00:53:00 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Before we remove Rust's alloc crate, rewrite the module comment in
> alloc.rs to avoid a rustdoc warning.
> 
> Besides that, the module comment in alloc.rs isn't correct anymore,
> we're no longer extending Rust's alloc crate.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index caa0b9dfac87..2170b53acd0c 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -//! Extensions to the [`alloc`] crate.
> +//! Implementation of the kernel's memory allocation infrastructure.
>  
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;


