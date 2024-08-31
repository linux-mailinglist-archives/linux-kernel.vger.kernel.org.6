Return-Path: <linux-kernel+bounces-309902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E39671A8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FDB283CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B576181B80;
	Sat, 31 Aug 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QUlOtLFp"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2096.outbound.protection.outlook.com [40.107.122.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AF2AF05;
	Sat, 31 Aug 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725109040; cv=fail; b=nGEMyI5D8du+PFSqMr5xc0OdYSN/8TKTFTaUbaYEZ8E1rVB5WQxnce0nkmXuIV0zGG7H2H/mU4Vj0aReZNoSRBtH0vbDou6TnnncJVp/byVOKf3ZUbsWr3rFped+6CTGiE4OO/RYxCchN9vO0h/JseofhGlFn/jiZ29WmsK6OLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725109040; c=relaxed/simple;
	bh=UYnVxwgYwk92e9iCzsHyZuCoukQPLG56Q9g27qzahpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TKxQdGdREJGOiymTjpoGoqgRfCTe4of6hiRo3ie7dA7C9g2C+3vcMq4acNULJtNyd+WijkqDj4tMC8wzPwLGEmZASsy9MrsBk9TmdGqRqZzIOqutPsizyKLwfjS3z0Bt4jNJM65fnoGFiW1KrxKv7ma0IpcTn6CynYiJ6Ocbdjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QUlOtLFp; arc=fail smtp.client-ip=40.107.122.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLHyHYmkIHce4Y3JfFCPbprcFdEcKkBJLu6paIP8wkUx6vG3rQLHav8mOik+MZKlMc0+gk9C4KJtelWo2vOoDBhpk5K8s85sNVl+JUweBBZPch5hcoEQsjLgwQ5EatdzGoPT6ZcqRtwd6KKz6Wqat4BaDK4OewYkJOqrHaL7qM39kGCKs0EVyms8O51T+sNUVn4pSABJFc2jzI65jfua2UsTdELJUTC+/m09zFnf4L2TJQgi4sjJKqlnceKkuP0GKbVGfx39qKrGq1SrTdmf8zX5B83+tw2Acy0ZzABxXb7JvEZ7g7LD1cLfemqZmQq4UJGDbs3XKl/S2+/O9dhCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFFGYRyREp0d3/ovI3rOCjOBwcdFrdmnj6Koxigv0oA=;
 b=yb6V+7C7RQFC8I1QnVJwLlW90y6egndsR/yVmW40LSSU/xa2wH5F/WPvFBU2iRamzjDP6cTkgmeD349hoAkqStftDDPR88DcWZ/2RqKKLdgyLM1p1N3maUIvLZw3pAmCxi0ogiSfkS5EgzwsGbUxE2NO9VkZulDzBTR6wZiImbDJIWYSfsPIHAJUWdVzP6yapmsWQkMzIfV9mY1/z8psbne8O2A/3RWFQSt4NPfKU2R52sD6VcAvnxZyl2hGmstZ7a68i3Z89/vGBGRuUnmFmDJ2yyQ2k3h+lo92JAwT9VCdyXFw5TxOTH734q9SDrzbloUsWEzppc7uE+ma9nQmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFFGYRyREp0d3/ovI3rOCjOBwcdFrdmnj6Koxigv0oA=;
 b=QUlOtLFp8Zh4E+AJ4ziA6R0gvC1/+HhuOD/Cu/NlJoO6zFrh1WLaduir1IzQWJhpJSdAzAEfw2gmrcz4yqMYo33aOkBuPhxIUeCQqDrEVd+EgXyAUMs35xW9ZGq5tlO9mgdGHS0yHxmhBIxzdbSUAmcHnpdVibBC9n0ru4nNsd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO8P265MB7702.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sat, 31 Aug
 2024 12:57:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 12:57:15 +0000
Date: Sat, 31 Aug 2024 13:57:12 +0100
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
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc`
 module
Message-ID: <20240831135712.0d7366b6.gary@garyguo.net>
In-Reply-To: <20240816001216.26575-27-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
	<20240816001216.26575-27-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO8P265MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: d88924c2-115a-44ce-bed4-08dcc9bc7030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvAA6dFLEfwAGaNI2F2TNsn0DpNOeAbt0BhmWm2Czp5feEcUBqL2Q7I+xu0p?=
 =?us-ascii?Q?cuu5CgYfI7aujldo5LW/1omx4SfW5yR3I28F6VTZbYAAw/JEqRLyFdHTU3do?=
 =?us-ascii?Q?gpLyFAGepvKMfoHdwerxNOdlkr/M4eTAn/pW3wtWdZmkSn5fz7VqQMJ2yuPH?=
 =?us-ascii?Q?L+4jcZQTTaBalTW8K9zU+dCK6B/j/3RKtmfP/sDtjRURkMH1Hw6VQq07e/Ai?=
 =?us-ascii?Q?raP130AT1aOgTGxEMRU0jJHDN7xoXTSCceD8wwlh6g75Dc7U4GuCQBLtNU5+?=
 =?us-ascii?Q?hhDDbM2901AbB895JX146ClWJs9HmTp827GOdGhFjuVQQaw4q/CNjereiaUh?=
 =?us-ascii?Q?TnVEtDoeAYCuacA7XOQPmmQsJgk4/NaoSTKKlg15Gm97NBy0JHSvnQiaoHmN?=
 =?us-ascii?Q?M219Dj7cHz/3NAAXtVUch+Wi174d61bO92SU6J497qsaW/r76ItDfav2FoMu?=
 =?us-ascii?Q?qZgPfAi7QzTrQGN8lTobWwJ3yeNhysmxFMaipUzjlLhj73SiIhcfJ7m4Mr6K?=
 =?us-ascii?Q?EEtW+xVLJivIyhwlbPx83t8ig8t1BwhIN79PEammq6+C7NgbPs4rRNvzeiK7?=
 =?us-ascii?Q?3nWWGyi6tZ7oPTArxlxew5w5KsN0XiUJaTS9OazyUwT+ECVuD3Hui1e+QuKw?=
 =?us-ascii?Q?Fz62mH7Jrf+GlpbLAgaD5EvLdMWcVOLh/jWuT9gr2qia+bD2sriF09l0S47g?=
 =?us-ascii?Q?fL+BD6XDO21FEg/US8ZEpcapMax26issUY1I8D58yC6oPo6nCjIWd7pYtLKR?=
 =?us-ascii?Q?unYo/5DIzOQwGMGQFG5qQlbxWROleahipBpsAXcR8P9Lld/sL/zA05W5LEoU?=
 =?us-ascii?Q?nEE9ZAIeFngqibLa2jD5rnAVC887zOp9piVfXKAzO1DjUG08oo88ewEdGYEy?=
 =?us-ascii?Q?dWV5QainPXs9ng3V83vyIpr5yNRLVmgoaV9rqiR3SJodQP+YpTJtfsellGTu?=
 =?us-ascii?Q?nuYC39XOieFineGXq2U0Jk7Ts+MjXFBXMjYYmG+lG7z5xcEutlcsDuTqv1yZ?=
 =?us-ascii?Q?Y3cUC8M4FjKlm4+fd0S7Q3+aGirAsZLbydUnF85SQ7/l+JavNI8ynGzy2Dgu?=
 =?us-ascii?Q?dr3+N+YAZZDW6IArklKnqxz5UMuFIy7+fmAnwenKWVrMkdcvRZv/CTmuSE20?=
 =?us-ascii?Q?cn2ZNnq2exO/6y/fMMsYit3iMUK6RUXv+aPt4iAYJD9mafkL/QhON2gWauxr?=
 =?us-ascii?Q?3gGBPySN04BhR00jRVh5xyBI1XNquOzOWgYZYH1brH0yWKjd33nVjxRwFwCT?=
 =?us-ascii?Q?H4X0BhQI5lpaDFnX3UnkN1cbv0Ig2MuhN871YslaVi6wJ15xVz2t78kqBz9y?=
 =?us-ascii?Q?lsxIhFMA7sgKVYkJ7D1W8fpsAGphyfap5nnhwYs7/NeUnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/tKulTGwx0C8JXVMlRILpwtVDqy48mW5cZO6DbGlBjJpLANNIHH8eR1dH5q?=
 =?us-ascii?Q?XU2WMM8bdYvsj0zPVKpFmrADwZAf5BPcOVb9LGxK+t2Bg+KXwdycDZoJ+JIT?=
 =?us-ascii?Q?6BHBk+6nUrdFgG+TPOz0IllRr/7jh78ml5ht75p/We/izw3XJ7UNKwkuKhNH?=
 =?us-ascii?Q?Rn+4Gvxy246ljn0BdAe76PwmJbq5EsHa2I+bo1wDIc9hRM3RcwMDQxMRfNyp?=
 =?us-ascii?Q?aLqJE+HrPIV2moQro1SzWHV20PEJevAiTHi9m8wfeP52L5pe+nqrS/XXUMo0?=
 =?us-ascii?Q?FL9LLFWVL6L14x/paVWMkdycOj7TLEMUKvUeoytgBfGjwXlifn6Ol/w2kwhl?=
 =?us-ascii?Q?I2QPQC8kogbFL1mjQBYsdF6SuD0V0xnKcledxkzHVIzi1zd/h9k9S4N40tdg?=
 =?us-ascii?Q?HocbDkM3Bx3jcjN6UxzxpyciZkBTN1QsbplMmnjiLO1+TVh8wkWabDx0fnDF?=
 =?us-ascii?Q?OtfWqKRIoNPYo1Eg0XfLA+rdjddaxCo0DTc4j8lB8Ngbr90DTEUS/IZtNP95?=
 =?us-ascii?Q?dV1qCiaVckzbqdGH67SATcQB5q/OfLrZsZLbYHD4F8c6za6+iYFDwXwQ5BJB?=
 =?us-ascii?Q?NmlwW2J6YninTMPUAR7Dls8HZLWvWRyW4jFWBjGVwDKzyO1OMkYAGXYw55zH?=
 =?us-ascii?Q?WDqfdFLPMgXDm+LwVRYEDV4jL5ZZKNvq5UCp60LHPgT4q4oj9+/4N7KqaDHV?=
 =?us-ascii?Q?sNFKML6J5Aw8+y9W6a0WLXrHOMpek8ahcHeREDfj4i07te5AyU3Lg9nwzkEI?=
 =?us-ascii?Q?YgcH++X9rBsuerfKZF2Fw2XZVyRFRzZieQzkxlE2BET8qt9NWgoCJuMY1iYl?=
 =?us-ascii?Q?Dq9jf1U4qC4E0VAlvMnCB/CIehfqWb+i61dIQQE0D5zek68b6p4+biB0Rp5l?=
 =?us-ascii?Q?p02IUz1NajYgPsdFLNJedou4lt6EhH49Up+1ccqPiBi8bgTgSg9VDOA855/p?=
 =?us-ascii?Q?xytrmo5j21uq/AQbXaR1ls3bFvbg91MfauPuDTsUb5FLQR9VUaLvI/lU7Dx4?=
 =?us-ascii?Q?t2bY0ECB57EEIqX4wMHjM6LPdPXGpBp3Bx5Vyix+eYia5GJjrjyctyfbFhMq?=
 =?us-ascii?Q?23mL/3GVCBYBCE0HksdQvUSV70I3oLUYvH2mj2G31JnrlEE0G6K4e3e0eHti?=
 =?us-ascii?Q?8ItF9rXLw+oSMsQptKxauIhjlxbiuIFKQbWJqIfXRIpz9Xk01+ujoKwEM3Zy?=
 =?us-ascii?Q?nZ0w2xRb/Sls2GA16pPPT+620D1L/xEPBUDZ4jGRV3d99IBl+yxJjHeJoVJn?=
 =?us-ascii?Q?XcMINRmgJLyW2jiZkf61qnHgOvBtu+Oc07qoFhxQtsZUuGuRq0YSnKcmgDT2?=
 =?us-ascii?Q?pgRaBuXwBo1FmVAoRIonrQD0/fm7qSGcnxSr7t900Rd90wYTmd9NwbBupeiz?=
 =?us-ascii?Q?UDXEvdCdF8j+RFw7aB9g0h6F+RmZ+2BVvfk/HrN+iVhbzIk7A/6b7Lq1LTF3?=
 =?us-ascii?Q?eLZiVvWeAibDqyq4kIJbuh54IaJs4Athqn40+KsHuLC/KQi6XP9/AJ2K12Fh?=
 =?us-ascii?Q?WGwVYZWdMUm6CHsMuI2bBEUKpZ2ysiZ8Q4+weRRk+C6Wq0FzEro5hszyU41K?=
 =?us-ascii?Q?xyAHgSGoOZGw3g2IGEYWDEY4I1umPpP/Ff2A5GJMnfqFvnc7zX5TQ+/HxQu2?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d88924c2-115a-44ce-bed4-08dcc9bc7030
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 12:57:15.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eq7wOWgKMViSHvxAfqJgvmwXLyDCTPfvcDFlwM3v6dAVXJqNuNt6emVTswWev2QC7svavhG4ikG8eIfQyLLAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7702

On Fri, 16 Aug 2024 02:11:08 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Add maintainers entry for the Rust `alloc` module.
> 
> Currently, this includes the `Allocator` API itself, `Allocator`
> implementations, such as `Kmalloc` or `Vmalloc`, as well as the kernel's
> implementation of the primary memory allocation data structures, `Box`
> and `Vec`.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..560516b3aaf4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19925,6 +19925,13 @@ F:	scripts/*rust*
>  F:	tools/testing/selftests/rust/
>  K:	\b(?i:rust)\b
>  
> +RUST [ALLOC]
> +M:	Danilo Krummrich <dakr@kernel.org>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +F:	rust/kernel/alloc.rs
> +F:	rust/kernel/alloc/

It feels like we should use `mod.rs`.

> +
>  RXRPC SOCKETS (AF_RXRPC)
>  M:	David Howells <dhowells@redhat.com>
>  M:	Marc Dionne <marc.dionne@auristor.com>


