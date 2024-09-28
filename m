Return-Path: <linux-kernel+bounces-342629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFCC98910F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5039B215D5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664E15AAC8;
	Sat, 28 Sep 2024 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CDI+A9o5"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2105.outbound.protection.outlook.com [40.107.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153771EB25;
	Sat, 28 Sep 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727549741; cv=fail; b=Uk3zHrPDVhxnXd/rDONSK8nz7jzYo6d6Me4nNuymc2Pgm4AkgsIbUKCzEzxhgMi8Br7eIv+k8mDkwDA1aCXJD3WycHK4u+J+wnSxVeaefu4zqSJkRrQ3jtTMC216OWgCXCu/A4zfxWO+Gxzp2yNqQdyjaxr8ppKE/ESjeQhBGEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727549741; c=relaxed/simple;
	bh=V1SkJXR5phqiFDcB8w2jeOZX7vUhvHRazxa2RlurreE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pe9m4fFd4qj22zzExJCo/9GQygnGmVjMbMMEJ27C+OF7Eqle3spj18uRYpcqIotklJhjNfcZ0rGj45JKiYEVoJhq6/3elUG3W/zgw14Yzf3edIHWsutZzX8cftAFj51KlJHU8+qCe7c67vgE8bu+StuVodMjxeU9tPAfXEt0/dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CDI+A9o5; arc=fail smtp.client-ip=40.107.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV+2Dk6ZWQuLu/nggxu6Mvrlx5GsmGK75zOXHTcgVxfHt8P0uzgo0qaB1l4vsnfIs7FUQjQTXmcojg0fyz1Tdj4IZnmEjgFIzC1LWNdnZ0Apoofcn+mH8EmO++8ETWwZZMH/eHpH7/zeLQ6tV0CjYtzd2QT+VJEDFZel9pSKPJDPSH+/UFNAVVglH9sQY6LLtQVFYqle7RZi+urrs0cht1xWmNt6oX5+wVc3xQWPQ+D0pVfXsC2Cmtj8BVE6t0IuNZ5BuLSjLmiqRLUy04e6VGmqHPAiUwG78QohSttochXWb18u247EPdngX9wNSpR3pSbDU53oehOOufrALIo3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3AOOZPWmWVTx5j681pSN44z85UXc2vO2/rlKkLziRc=;
 b=mtalMcFcxe535AKlES7rXGEf0l5Pl/xYW6jCEutBMTlekqOwzL3AKXH7tWYiNVTRb/oEai+pNVtbp1avRdCCbHZ1f7yiyeRVOc33f+Gtegr4ftjumAXSaYTMFEwslmrgRj6sDtVjfZT3N+m2L26IuFE5NPRA9MO2HvZFYthgFkM/3eYU1nONijA8jnZLHYHJK5J9Sb3nED9hv/1CqoIMUmEOxGKGT8bohZ61/qM8bhJDIZMnHIKkLghDlQvhWT0sNnjSA2+lHc34SJrSq1XU/2dxf+7knaLHl7cLs7co9fAPTNCLQIz2TtgZaSuJCJrvaLME+mmJSctdkS1xpY/Umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3AOOZPWmWVTx5j681pSN44z85UXc2vO2/rlKkLziRc=;
 b=CDI+A9o5oz5RnGlQ/e9QhmiU6q5cFtiyapGiUVcjGmQ59xBkRDwxzVLTZFSLfn07tElxLJdOUXh7Da40D1jWpVtgQTIgjMi5xnvoUnoupZo2S3uVS72wYjjADLlGZ/YP1Obr3BerwPlSRDF5eeESC8yOOOOHQjsjeK0dLCLcnFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 18:55:37 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 18:55:37 +0000
Date: Sat, 28 Sep 2024 19:55:35 +0100
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
Subject: Re: [PATCH v7 08/26] rust: alloc: add __GFP_NOWARN to `Flags`
Message-ID: <20240928195535.302097c2.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-9-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-9-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9479131b-39a1-47c4-a8af-08dcdfef2406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5rO5phD+yOhGoW0LDmHezawyrZAjJLH+oOOTbgLTYUJ6cfhUsLiSjwqIFkEe?=
 =?us-ascii?Q?vplFSKltsZFD3PySOoBUFS7LqeG4dFjiRbStQ9lTSeYUMcRGSgPL6fJUBqfO?=
 =?us-ascii?Q?2PsmoX5jvA4rh2NYxL686AITbKq1JRHizDcZAAybv5mRrDFKrcJcf1rN53L0?=
 =?us-ascii?Q?gShEIZi4myDAran0rWJ5jkU08vZpPVHge97ur1WB+SpV7eN8V22GhibZ/bi+?=
 =?us-ascii?Q?4TbUqZ3Z5GuCQ395ZfPZf42iwAItIFKeOp8ZXrO3PQ9eigvDhbpA+T1pJWYb?=
 =?us-ascii?Q?2rsJ4RUbfhVgneK3vxJ4FNLdJg+lFLlEPV39PV/VPjs5faiA7VahF58TghnL?=
 =?us-ascii?Q?4ZHi6+K1euzsDp6T32YDzzsi8IA1fj15YR6ggij+bZVlakE2nwQaoxBPCefU?=
 =?us-ascii?Q?KvKomO7X0n6Sds4WGe0YbPs5ofnYaxavWt+DOtFuK+Ru6G31r+D3m5ub691T?=
 =?us-ascii?Q?kQooA4644OjQfQ3HWjw3VZmvJVyPwuC585Rz7hRkzOIcZORzOI7jY6agWhxa?=
 =?us-ascii?Q?Pm8qSTfj/K/IEFnAd+RO1z7/H1ZcT897StenmiMxBszGEWLiyCG9/44QX/ub?=
 =?us-ascii?Q?t8q+VV9ajL37ovUG46rNoL3Ey7CPXkzlKloY41XA5bDGTLRHnPo2gKy6sZFj?=
 =?us-ascii?Q?UbYPOIpvh9N4HnhHjSiPHdDx487PkBWhq5wYKdw04YTe1PXd7cUahWXWn3UV?=
 =?us-ascii?Q?OiR0g+9B/JPGILXPM04G5kBkuAUbQaJmqQDnL887yh6gUEvXBTqNiU039Hw8?=
 =?us-ascii?Q?86kqpr53EL9TStlU+hry9L/vnsVuL3yZ5q9S9Fb9ypOMCATixxxqHCLL4itk?=
 =?us-ascii?Q?mtWrwuJksqzjN9B+2BYtTS5tmT06uE02SCY5KWfiXZPaCB/1wLtEDm7+SHRu?=
 =?us-ascii?Q?BbdrbTN7YQMbcCLU4/r+WLpK2RnzJxHXre5DkCC7293r22EmwaHErVBMT6jP?=
 =?us-ascii?Q?HIYdO8updF7SYDZCYJNVtxHpLiNSCKTG31y2leIeV7FzlQNkuUZux8S8HleK?=
 =?us-ascii?Q?/SMPV9EMirW4wmkiyavViDRtvhfiKYiNVcvNaO2u3UrKfZk/bfcnl7S8hM5+?=
 =?us-ascii?Q?rWXl4KNnDvV6CXmTyYnVTWiO2B5lx6mVQ9emmxaeS/EPK5UpaJX/5EcW9JF+?=
 =?us-ascii?Q?lLlzTnXExOwzpW917DVPGwGXpG9QgsnNb5L9gLl4zD0g1bV8OBzr3vYc2P+P?=
 =?us-ascii?Q?LMBioLtQk8SONlMsAFDtPKPFjOqFjTy6q8s07SClGxOXemFJODp/ULtg5oO1?=
 =?us-ascii?Q?G2qyiEKsilFDx06yaaVtbkyIi5tfeVnYJAMAz6ZEIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dOvZpq6YOPm028W2CAhR7A/9fZCfDIMhA7wobo5LPifFzRLP6k5GwW0JGIVC?=
 =?us-ascii?Q?HnXL6JlunrZAjJnmnpzeUbko+FTEKZcX52Iz9o4aUuYDGGjcunNe/J4dI6EW?=
 =?us-ascii?Q?PPp5QGBcM3cHEqUMpZkpMh6qS1ab0Kb5F3SS4NdvRv9mfrXuDlpQyJaa5WUq?=
 =?us-ascii?Q?42mLXBeniXFRhVeedj82es1JfFild6nP/fqD1Cclg6NY9DNlS8lyXd5DdsJd?=
 =?us-ascii?Q?/TpAJII/jSKYu6XZxKiOdi13M1nRZKsmE8z3qpZirhDV2ratcvCcs+cl4J3c?=
 =?us-ascii?Q?F/R1hzAemEQBMKnIJUXEBb1q239LEuR9T06TTK8TcIUoryorD2mxYHrVJDle?=
 =?us-ascii?Q?r4ph1dytPevrUkYkEc6wVgjbI6dt6g0L1G4mE6Qvt2vop+0WmUJGZYnaXvWS?=
 =?us-ascii?Q?i+1HJwwuW0cYub4oRYy/vo7lrUtqqZwJDox5dNdadVh61kqpiZtURIMD8hFZ?=
 =?us-ascii?Q?jz99Xq+54TjjMZvPce/bIXk/ToPMEkcLPRK+QbFOnrpGc0KjWT4vuWIz40W3?=
 =?us-ascii?Q?05WLAH+rIyZiLMNDtNJQOMDJ+GuLaJVQnS2TgzcPNfUzhVC0365cDlXIJEcj?=
 =?us-ascii?Q?MSdMFTgodkO5yYXJzlez3bPhaUQ0Uez3TwouO2gn4MJKWpzQx7s/46AqDuXk?=
 =?us-ascii?Q?fMrGW3uaoMylTPKfr/U6aNB+2C3UyQ4NcszqIL79F8idW0VOPQZ7Bnkn0F9R?=
 =?us-ascii?Q?raw+WH2HZxdmFhk4amufHw+CT3bZudyO8wGSXSU4RK7ZNKlAdYQk7vvy0tZj?=
 =?us-ascii?Q?iVF3ioCRpSfhpJvrv2PlrJ13lHfMoEeIZ3Xe9Oq6JZD6pTbjFmFMSUR1aI6l?=
 =?us-ascii?Q?YzDGJKKVspz5CFVhPIs+qk4COyLOq6mA1nxhRG2If+EWiehAnIUh5wTZ2oYc?=
 =?us-ascii?Q?gnHPg39BYqV2KAF/8ltd7sxXu1sWrrZvh8snoCLqgmuC2QeDYj45YdNyP66n?=
 =?us-ascii?Q?2+f8tESK5mEwA2BX+ov2+MvZ2848JVdZkTDixIPREFAvK5bpv4h+BYan/yTa?=
 =?us-ascii?Q?J6jZyYlZM/dpwstHl273uns6limud096afhvudy06Fqtl+RvWmmdB3BnWikK?=
 =?us-ascii?Q?GPSmEwIZRPTlIcCf4qqhhKvah0CAlqYYzvjH1uauT9RpgQEdQsTwAjnKZwNI?=
 =?us-ascii?Q?G7BTTkdIGR1oLWL71gMBRmGNj/HXaoOQJtZv2OLhJEJU4iE/i7tUOyIySbo6?=
 =?us-ascii?Q?g99guFWmqvjWtdH0rcU36C95bG5kJ9OaxFwvxPrC9b7iNIjqQsXl1cMt5wWf?=
 =?us-ascii?Q?BHWtOLs4ZFtYeO0M45W5c+9YS7e7fElt5eeV4+XZcRsIHXsRtrt7PsRYy790?=
 =?us-ascii?Q?3N3vFHmxg3SnMetDeq33sFodKEPaqJOvGoFTTZzpMAXgmdjs5A0VEzJkIejW?=
 =?us-ascii?Q?eWkdyLgASh0lmoahQb7cbOwRPpWDTbxzXCgJHSFhdVqWzpF80KLFuTQjV+kz?=
 =?us-ascii?Q?96Altz/T2rMesZZuXVu+pEl/lEqoDEvvJDqPUfBi7A+rpejQnjyTwadIoZU9?=
 =?us-ascii?Q?2OfFNo2uGfFI0qTFORCWHBFXryqk3LAQb/qAiEoCwYqP+17PEI7I0wN8T5Qf?=
 =?us-ascii?Q?yTZMDzMnXmvy2Oh053zl/baKN5cgKmJRnfxo5YBV?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9479131b-39a1-47c4-a8af-08dcdfef2406
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 18:55:37.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFF2IsfXI5Oe6QIMGq2Sa1zmCeBBMWR7TgawIkB/3VGC0/uaRTK8maFc9CRwaJ8qab1TcDUQIBmafE/7Pq2Llg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6981

On Thu, 12 Sep 2024 00:52:44 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Some test cases in subsequent patches provoke allocation failures. Add
> `__GFP_NOWARN` to enable test cases to silence unpleasant warnings.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/bindings/bindings_helper.h | 1 +
>  rust/kernel/alloc.rs            | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ae82e9c941af..a80783fcbe04 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -31,4 +31,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
>  const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
>  const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
>  const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
> +const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
>  const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index da025faf07f8..7a405d6f3034 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -91,6 +91,11 @@ pub mod flags {
>      /// use any filesystem callback.  It is very likely to fail to allocate memory, even for very
>      /// small allocations.
>      pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
> +
> +    /// Suppresses allocation failure reports.
> +    ///
> +    /// This is normally or'd with other flags.
> +    pub const __GFP_NOWARN: Flags = Flags(bindings::__GFP_NOWARN);
>  }
>  
>  /// The kernel's [`Allocator`] trait.


