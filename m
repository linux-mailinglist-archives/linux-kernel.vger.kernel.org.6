Return-Path: <linux-kernel+bounces-342630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9245989110
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086E41C20F02
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A14915ADAB;
	Sat, 28 Sep 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fIVAGEwl"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2125.outbound.protection.outlook.com [40.107.121.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832BB1EB25;
	Sat, 28 Sep 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727549959; cv=fail; b=Bk6HIM1fOJI+eGWMXKTcheKD3H0Ih1iR3Jkdbn9sTwhnBwmt9G771Gx8HmjViPwrqsKh+brrIf5qGz58xVev5RPIcvRG7sWfY3q0QiAcd0t0P1QxLa43sAJ1l1nZhtR8VeGgBSGtyXi4cBMeVCEmsiDnf+QuoNK7gFrRvWKLaU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727549959; c=relaxed/simple;
	bh=ITK5Xf9C/YBoN9RjHSrAysp4kbF0tEG57Jyj9qe3ElE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gT22ibP75yMmQUGO9v5xAi5BKnrf4a6p2qgOVf43hsrn8BzlWH5Jh+m2k14sjEgmPFDZxACOMlh6h2sb3yBA+EORfa/cerxSzQ9EeOrCflfzAK+JG6M8HaxJHJgl6duc7k3oA80KvkMffBKQz1QIuz7104TgsmzCjgmERWRh3u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fIVAGEwl; arc=fail smtp.client-ip=40.107.121.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNyHHm/OljJMb4tnSKSuHQ/vRVPJZQOFt8i/Rg13dJrhmGrdDY13oqAO3kat3IlUUA0DPlmx1Whg1v1fCBULeuR6mJosbAma1pnMTZkX+SVaem51bH/XlPSJhojQSW8YnO4shosidSnbfG5l7QACuG7jVBdeykZ5W/acDNB0m5ZdOcWtTAtiNvjhT+9LS6JUk+qL6PxVwr/dJGFbM99tE0VWC533jR/lWn0BKAzHIi3myMUWW4uva6Qux161UckRm6WYPI4T8GGCXJRAM6zPnSS5X+aDjNlkceabTMFpuQ/PlZoF6mC/eTeJKePGpg9zujl37f8PkKzqon5Ga1uA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZihwotzJnnQZs2GkUU8AFff+tr7Vxt56RoCAxpqEsGw=;
 b=ZG7Cf2q5LTz/q7rCSK5K4P3NZhqNTLjnKGMVatqOTfpPImNSilljx850DxklLgJsp8GTsbPC4ET46b03tS05hxP+KFhPrFNysDyPmIH/QTddkfPV8MJWAOVH3HFoF5mCfxkHJa7fcY1fkC9IGwiCLDiwFlp6NTR0MeloEr1HN5/mxDnF1v5MMfBLT1i2ilYU2p8zU2IaPrtmWFU8V2Zc09JMozYawiWLeQaoFq2cpbO7cEux7rKmIVkKHN7EhsUNoOimBZH2TYLpLfAOS9sU2J+ihTbIgUH93RVlaOsoPvfzvucmqdP5O6rJnLAUlndeJHVnXY2xNZN6AAMD8iK15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZihwotzJnnQZs2GkUU8AFff+tr7Vxt56RoCAxpqEsGw=;
 b=fIVAGEwlm/dJD8uuEofCH+wTDBf/SkI8QGYDgvxepkR5MR0t44Yt6xDSPgzXoieGk1047Qvb0qnFn5dWzd5BneZGgnCCBSuKlx0YpOte5pb5p1Imf4WPfGhCNYt0Xb/B//eM+mZDlqEaQdPiju5hoKbEvdn8iWU7iU3OezGqCIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 18:59:15 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 18:59:15 +0000
Date: Sat, 28 Sep 2024 19:59:13 +0100
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
Subject: Re: [PATCH v7 10/26] rust: treewide: switch to our kernel `Box`
 type
Message-ID: <20240928195913.5b2c04d8.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-11-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-11-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::26) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a22396-0f7c-433f-cfa7-08dcdfefa59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QsF3f8qR9/q7smnbwGTu5zsvUsqP/ocO36dCD8wq26c2LjeH+aavP7FDiQ9j?=
 =?us-ascii?Q?hKbb2SAlW/PhjP4w70K382e4lxru1Is+kP8SI1r+308GQpNDb+76TnGGwoe4?=
 =?us-ascii?Q?usQuyqONpGDwYnHHIQBKFjhTEN34u18N+6faxgAEd3IsmG83rPbC1AwfawW2?=
 =?us-ascii?Q?uAsUhh4TP3GoyeXKSpYuK5CXd3lNubROCdQJDyXpZGDCPWTqCc+s5NMbW7Sl?=
 =?us-ascii?Q?eZqBOn4qomrJOOYDVIjeu2bsYdC3Moi/3xTpNwaG8abdFq+ukeJ6yELMfJyo?=
 =?us-ascii?Q?YVjd6xYjGF9w9SbpANE3kS8gmf/xJdqkktiCmBTqwlCKfogBxalqo6hSvsii?=
 =?us-ascii?Q?MGdAV9+i3xo/1Ju7GXb6sxm4T4kx1cSv319ZcPm2+3Gw35p61M9KQwE1VYd9?=
 =?us-ascii?Q?hs0BkCwYtk85iZ2Z/67nj2V0uZ7hRuqTmUB4nSPD2oDwCXunGiSI/61+/ylS?=
 =?us-ascii?Q?2qJg5bxmM83fyAZcunkPtzG8ZTvPnuzG18VFx960TYEiZYk6Kw1iU5Rz3R2E?=
 =?us-ascii?Q?nkr7iQXoptRu0ezTGM4IZ1LHwO0XomjPLBg/o+FDlPWKMV6z/WuLElDh9F6U?=
 =?us-ascii?Q?clR5JYFt0FtNyjtr98C1fl79FopFii3GyoeuDzlpN9UDBkIKdTRCBaINr/1k?=
 =?us-ascii?Q?vTFLqpLVA9SbEmBpf0TEm1RmpLTzMzkV2DRfwHFyMn8EmTDe3eSlpLbEvoG5?=
 =?us-ascii?Q?ywloV1AepJpEy6JN3ECAE/Dkt8Gwienp9iUViuQs7Oz8HGnPAYpmkpvVOUhy?=
 =?us-ascii?Q?g9YhON/nEdWIuNwgghONBKLLeOT9Spsf5aw21VXxxPnXsM3SCRGrtEQdDttR?=
 =?us-ascii?Q?z5YI+FSswnDxYVEA1TJK8czjHioa/31TdXu7ZSKrTPkdAic0CEd0VZnFst3o?=
 =?us-ascii?Q?iRaiML22XikK/7iOSLMTXiezCBnOFvNzs8Hy+JjYpC9uZjlTLyiMyZe8UzoR?=
 =?us-ascii?Q?fBBrB3rc+8CNt0xEXuNQjWclmY+2eCkMCcgnJWk3+RIKgCglHA4knEGeVZo+?=
 =?us-ascii?Q?F81HzTU4x9nUbm6v3kNOReoBeD35wI8rTZRDoHHL7XTyMcc0AY1WCgbfTLO0?=
 =?us-ascii?Q?KL6EhdeK5IWqIUsQok/ixh1Strp56feaLvsYwu/P0xWRB5+owLKEvwkdNY2Y?=
 =?us-ascii?Q?0YJAyNAzjwTisuSohLVXUwPx8s0SGyvemZTLlMECeWajUzv0Ic44frj1a5R0?=
 =?us-ascii?Q?EG/fKKsbngIvl8e/LK/3/ROxLqAJhWdh24BpsPcYVtH+bL6XPLPfLxgRgSHi?=
 =?us-ascii?Q?r4k6VuwxC1td9TxEtMd8UbB3KObJeg4yWHASQAfqSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5dysEThRJ4/l/t0OvSUHAvnlRE/EaqdC6E8aKoCG4lha/XWrFcsQfzJYlbu?=
 =?us-ascii?Q?pMRBrgXj+Mk7KPhCmMMg/Xo+mdtt2ExVvRC1WFEsDWsYhv1k8rrTvmr4hiyN?=
 =?us-ascii?Q?XB9/yQAuQwP2PwQyBNwmRIUh2EsLjczQazNXCYXSJ9voln51eogeF8RAcv3T?=
 =?us-ascii?Q?008iIkRhdXa3Km4QmNjN76myxNLfmxU+o0GEg/1hBPDDq9/VjpoTXhxXo9p3?=
 =?us-ascii?Q?vFbZQyfn4gHlbHKqRf88EJjIU/QDXtQZ1BcA2BQ0R7/FDsk6mH4OxAJLNTxc?=
 =?us-ascii?Q?1tyw7hoFE1vvcH3NylpcRZrYv1vVkvZb7qGGbL8OcWigNE8UCP9wR+DwOEx2?=
 =?us-ascii?Q?jho666bycrE+bq4ba12+2HYyTwozxr32en3KuqwSDHA31wZV12mhgkui8TUR?=
 =?us-ascii?Q?UoCvy7V/lYPhW+tLDNClsR0gQGeq5fTnwwLZ2lWihKd6yLg82wii4lhrv2RR?=
 =?us-ascii?Q?PPYmdjmOoqpqxhpRD3JRUZIIukP+6b/Y1YP3+STq9etCDmIjZ2k1TBfaMj/T?=
 =?us-ascii?Q?ACIbN2oYcQ+uqEaSnBVhVyYdDm1alHcGjN6LbA81UkEPFuik+QqetXM8WvH+?=
 =?us-ascii?Q?IMafS+qJWnFeaerAdvXVb5MROsTJ1r6HyJ27I4G/eOa55dtIK6kh1T7Yytmp?=
 =?us-ascii?Q?xoV6NX5OJdvuQpZHn2NltcR779asxm8KecoyQ9n9aFUx4T7XtZtjgEqI4ZHy?=
 =?us-ascii?Q?V6B4QT6qigCHchVPdKn1v4sVJMYThjb0viLI9kgW8Zp+S+sAZl1vwUxlKoUo?=
 =?us-ascii?Q?ENmu3mFXFnAFkIdMI2wpEzS7Y92pCOWynPkKUP5L7FEZ+WJ3DMxeyP7RpNwh?=
 =?us-ascii?Q?ia6J0IGAt+zdik81Lm/fqlDAthx/fb8aNuMlJokUgQZpcystXf96Q57r9fEa?=
 =?us-ascii?Q?oB8t/BCE5m244SaQCXYbyvHXzSiDfQsC4ezwC6/LvNAVy1jGkqo45rnblvrK?=
 =?us-ascii?Q?UcTuu9chaxjUxHFpc8d0LJFC/T6ntcV1n509qRT5QmEzu2jhyREHXzunYsB6?=
 =?us-ascii?Q?9gITjQA8WljOrWzOZWz4ouJCeT9rqr/+7MeOub2xKuOScdA/FyhFz+Kcr4EY?=
 =?us-ascii?Q?QyX4nSAZ82L3F+d2Mx71RV+GXUTRg5Hpk3WqdheoADegNqF3LjKXHDSCvIm8?=
 =?us-ascii?Q?AcrCNDJ8QOs+YkeRvIINH+qhqtlOmRqAxfa4f4CciatDLIq4rFBhs1xmkqjc?=
 =?us-ascii?Q?23fQ1HIKt/fQeeNvCg+Zor1UnD7EG76uM8rzh7D4uJ0qlQ9u48gBMqN2t5KQ?=
 =?us-ascii?Q?gGbhMdfn+NIGTYMtHv7DuEvLz/AOcO4W8CDlDzJAyktmR61QZX73mc7a6Jqn?=
 =?us-ascii?Q?PdwNXozkVKJcwaSB3TuZGj/7ARZexrDxrRhABkwRm61hc+3sNUCL+ORbJhL4?=
 =?us-ascii?Q?Qp+JIThOFgY1meFo3UFES8DmPBLJr9bqRIlMsysBM8j9TH1aX1xEEZ6ScNHB?=
 =?us-ascii?Q?9guOVypNX3A7qEwqK9Ja0ThgDfElVSLOAASaZZUouUojwK0nXrBUBs7C33Mu?=
 =?us-ascii?Q?hbxzlTi/tWrpJ4xH/+bpfH2Z1OtlVcB1pykE9rSni8krYC4xvw12vvnymWjT?=
 =?us-ascii?Q?V24cqsvimwDu4MOoDeyDbfsLP9uZO5j3rqqJN057?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a22396-0f7c-433f-cfa7-08dcdfefa59b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 18:59:14.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1pXAarMEygy1q807BSqhfPSN+fwmEUtnxnA0fLREFd05su+6b3eJgrIhEJHI8+Wc60wrsrT2BO1RH2J2Ot4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6981

On Thu, 12 Sep 2024 00:52:46 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Now that we got the kernel `Box` type in place, convert all existing
> `Box` users to make use of it.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

Have you considered defaulting the `A` in `Box` to `Kmalloc`? This
would avoid doing a lot of tree-wide changes.

If you have a reason against it (I'm pretty sure you have), then
probably you should put it in the commit message.

Best,
Gary

> ---
>  drivers/block/rnull.rs            |  4 +--
>  rust/kernel/init.rs               | 51 ++++++++++++++++---------------
>  rust/kernel/init/__internal.rs    |  2 +-
>  rust/kernel/rbtree.rs             | 49 ++++++++++++++++-------------
>  rust/kernel/sync/arc.rs           | 17 +++++------
>  rust/kernel/sync/condvar.rs       |  4 +--
>  rust/kernel/sync/lock/mutex.rs    |  2 +-
>  rust/kernel/sync/lock/spinlock.rs |  2 +-
>  rust/kernel/workqueue.rs          | 20 ++++++------
>  rust/macros/lib.rs                |  6 ++--
>  10 files changed, 81 insertions(+), 76 deletions(-)

