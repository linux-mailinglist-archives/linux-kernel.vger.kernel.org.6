Return-Path: <linux-kernel+bounces-346499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82398C551
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E709287224
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138271CCB44;
	Tue,  1 Oct 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mx0up8YI"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2106.outbound.protection.outlook.com [40.107.122.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94361CCB26;
	Tue,  1 Oct 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807320; cv=fail; b=RdqeFEzntT8C3CCn7FIjUJtTOhqHbzB+ZOE+PL1Fm9GtM2A6KZRxOt9fMMJ9j7gS1U/hxVvHBY8E4TPC2ClDaKW02bmdV3sk0TIuG34qTrsN2qiteytu9NvpdndUScF6+yN/TPPp/NA1QTZaMggrtUIse2Rg267CJucnoIArQqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807320; c=relaxed/simple;
	bh=UQSBQwG5Ft+EPbhWW3gF99sdrNFht9AsjfdoXJpNYa4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBnThBTvr3xIB3JbIyvonG7El6dbUWQvOGqoeHCMjexmUkPSJy/vwPHWexrXGVEKWYA125vGTlj/e7aT78GyMENaQGc6D8uFMMaa/7f+6qVnqhyL1nZIULAvskCI8em3rTd1JqiXKBCGiTOOjXIbI5e7+V5IxX33v/U3Fiuq+A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mx0up8YI; arc=fail smtp.client-ip=40.107.122.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmnbsVr85IoPJ8RFYS0OArvUFvMUiD6PuH1NJj8+bJq1vAPQce0TKsjGz2yGPSb3NYzOyUutGyRPa9PlFbkNmJp/ZsQCDVakSvUjypfBWezINxlWRvgsqjPrrgIlm9vaqb6KuAW+sSr3TIGQ8Am5n4nNy2D2qVdiX+5HaBHa+dswfBoB7EwsGJjdGdmwSkGMBT1XNIUqoYT8qBKLD9oTwNoeTPQzZJWyvannEHtN7rna5Uy9GBjcclb3WdgJNZeFX0/tpPYPMkBDMohLanc0wyKlSgfe1r1+FDHbchNsNoXkoKhrSU1vYBgke5raXStOQAbBKVO9RvSDW+c2Vjqf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+UI/KwvMIY5EX0mnNiirFj2jrd1NYIwWX985DkLeh4=;
 b=OqkbUBmgHkQcY2FdDlSP0nJpq1wZ5Enw2MFswCs6Nl8YXTeEQK4tbJCALcLEqjjLaqoanzHkDZHh7VHPjti+iZ6b2pn0SE6j12n9kaY33V9L9kMkhUTdyUtrVyT25N+Df+zJOmLxfEoIxRE3/emTtnIDA5JCmdO/A0Y2H3OT8akb7v+xd0OT6LxRZw9ArlsgSiL04MorbiwjLEg0wg95YtstjdH0BNI8G/b7h2tvynegn4zPV/UskCEnHrqDlWj355qMxkaI2h5wvDKMqcGW1P4NkO5k8l/KAORJLQVn0yc0F9LLp1FrwmWHn8Q6QMb34D9aglsMxJUHwE0dodAW4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+UI/KwvMIY5EX0mnNiirFj2jrd1NYIwWX985DkLeh4=;
 b=mx0up8YI0gKc5kSDCUyiLDKUF75At3Gi2Xxwisosv3Ov8JxXTjcmQ33kyIbt2nUcOt+Gi1HGKnJHkYMK5z6VXjWsZUxZRHm0D8/TvUKetp3vf5BtLJpvN/d+AkTTi6UrL7+liaYcJe+o3B+y0vb+bRkfioV00DyEwjwFFZRO9Vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7730.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:28:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:28:36 +0000
Date: Tue, 1 Oct 2024 19:28:34 +0100
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
Subject: Re: [PATCH v8 11/29] rust: alloc: implement kernel `Box`
Message-ID: <20241001192834.36ec0fd7.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-12-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-12-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cec498-4c23-4013-0bd2-08dce246dcfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ym4QaBXsaSSY45ube4/yg3LG4csAvCRJA1jLQhjoa2iVNJc0k8peo+j8n4XP?=
 =?us-ascii?Q?cnliWXztRJt+Xea/MJAl/6w41Y825mfI6/GhE6yNN4T9HO04+REYMTvNFV/R?=
 =?us-ascii?Q?hoOix1Zj8WiUuFJNsBchTI9o5xy9SztiWeVXOLJwC6LPwYUsM8hTLp3t+4zU?=
 =?us-ascii?Q?fihrbt68jXHSehwdruMoNkqdOIh8+0zJaaTtqbAMnpTNl4MWbNbTycZxigWr?=
 =?us-ascii?Q?dKD8yZqex+zRs6rtf1VVCT3yR9G+luD8Ioi6VVPB1GpkU5Nh8K8Y6Jbo4OG3?=
 =?us-ascii?Q?z5nk0BKgb7inrrJarbEaosgQaUWh4DJ42hwIRJ5bKKwUxed2zKghuMVkNuQI?=
 =?us-ascii?Q?9INtjeL7WbIJ6KZPc4yhmSejw6cwK5xPqsgt9PrqfyEa02DVR8v3C0kjAIuU?=
 =?us-ascii?Q?XFUmxQQPk2FTP3yxxW5Zr7FeN+Avj9v8lmOUiG9PW1DUMXEVzwLB6BF+aYDI?=
 =?us-ascii?Q?WRz+BbhRWg/Nxff3SE7gZgZkIjrZSXmnn3BZVT/gUwPvd4A+OGk47noeiAO+?=
 =?us-ascii?Q?Xckv6IBlZCqzdPZjlY+qQM3/vTFGy652FSVW20/xHK0+Mxl+CqZz3xHfAmYK?=
 =?us-ascii?Q?pt3n6cXnJL9ABJkdqFiD7rVHgdAH8GHaxj5XKX67Pu89O9U0oYmBQbdVjGTk?=
 =?us-ascii?Q?mk14aMJuFTQWAGBhTDiaLtcs99YS5wcmdv/7cl/rBa4MkpB0apgPzrXZSajz?=
 =?us-ascii?Q?Jg6SVAayJ777ebYVOL2IQgslNdp/OliBV6qd/ZshNdLEkd55cTLBHzMrJMB1?=
 =?us-ascii?Q?3zsD7S47b+cAvKX0kP7sq1nMHXFHO8BAcr5Jfu6ht+vclryA+IGpGgtmlESH?=
 =?us-ascii?Q?DWpaP5Tei+KBSZSKQhFY8vv0bvrCj6CbvcN02LIA6keR5R2RNmkwDPBaxH3S?=
 =?us-ascii?Q?fKj6UyUqxSSk/6+zE7uxlnwsGVDP0xmGAsiGBkIQWUdxv5YxUG449nBFMLFr?=
 =?us-ascii?Q?aIoPE7gKgZpG060zRSVYB31wxoQBCJ8CwU8327s7IhWu7Uejg8htMyBg8EbL?=
 =?us-ascii?Q?oK/quN8W556lPLAzBsNx9ie0Y4J9s/Y1/CStE3Rrw6aMn7LwRiPQFKy1MXZR?=
 =?us-ascii?Q?WBV9wrag+gUTRopf4QKx6z3ZJF4TB5eNxSd7Fxfyon/hVZ8L++ueoMsZa67/?=
 =?us-ascii?Q?fWNga1Gut3bOvd+EI8CosMExTG6O/QCk8/ihxCWThBU7tZCFDtDQGwLA0FDK?=
 =?us-ascii?Q?PQUodOk+MAZbz9dNAYPCFtFYXiquSb0NLRHODgyIYixk1AhYnDfmxrsBU/hA?=
 =?us-ascii?Q?WRs1U3a6yCdJxSO7B4A1dBwIL/cbDvcdhUvtany5vQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JSq/e2kDqYGO4i+yQXEFhvVRrZUTGOpsDW+b5ZmTVy5dNweL7heNQbnCaYGs?=
 =?us-ascii?Q?ulZ6AS64ZkrG5IPfRaagJbTC3l9FaxjPPaIayKZKWv0BZrt9+6x/xgUltrXn?=
 =?us-ascii?Q?R3nvsXqweAeQQSchMJFx5zULm4JP/gTdLqdMSKV33iGU9uhVeul8DsR2Sp+z?=
 =?us-ascii?Q?icDBXYwgY7mqDRi6ykntktvjrIOOQEhhNyGnswSqnylYmgASiz7T16oBLReZ?=
 =?us-ascii?Q?3Q+MGQ+lVUkOtw2kpU/jmVrxvMn36EQWnvX3ltO/h23mD9+jzkGLyFfHssr2?=
 =?us-ascii?Q?879LvaFHgXpBkP1Ch6HPtaZXCxOQvixxWNkmvz676Ucsj/BPiyxmA3IWgvU7?=
 =?us-ascii?Q?XEgSsmJrJS86GaoeX4tVZf8zXGjkCFsEQ8WvLt0IwFCm2Z0wR8xhBxU1565u?=
 =?us-ascii?Q?bj7KMxJak8T8GJmrsjO1nnvS896CL4keiuPvebkASjefdq0RvIUMH4ZJanWY?=
 =?us-ascii?Q?SWBj79xUVvdiRh7+eGvcWgTO7HHQ0YUlNkm2yKWsNTykWSV0JAy4j4a0kMBt?=
 =?us-ascii?Q?50RbDwpcaZchg21ssGzJSHRy+nUP3V7opcjCvdgaLDMLDA5JAIUYH37U7uB9?=
 =?us-ascii?Q?I58lTaLdA+BmIpVYDjVoWarG7TKIlaEnrs8Gq0uCKy89FCVadIoJ9bhv/01R?=
 =?us-ascii?Q?4e+PqZPegLP+IHfuzCugIicmusHjNmtISQgwiih0G2Tfv0V8Nyl1Ze53RaGM?=
 =?us-ascii?Q?VrAmpmrcN9p6NnOSwwGJ08jzhfuF4GvYtaGkvVaeBJEzdML0Vj+LsIzhXVXN?=
 =?us-ascii?Q?3CjfLohD1Wh629bmEqe94FXrN/2ssWG/w4qqqKc81uk0CjcRqhREQmVIDN2s?=
 =?us-ascii?Q?9sUljSRwSCbj0zja2xyLeFd1OrkmoAOorYFUx9KJrnfzhWzPruuAbNKpyw5e?=
 =?us-ascii?Q?ZjBppIGkhhiyZoh7mvXoBH/RdQZNVhqiW9IUdeRI35+EbooAr6PxQBiPt/Eo?=
 =?us-ascii?Q?7KMCY8+cmr+B8uzo89iPbVABOvwdUzhGejfTkqONbEeDUFVszftSWLUnYpea?=
 =?us-ascii?Q?O9pQvPA095+qOf1G7XJJS0rD1khsGY53ntE0ir/7GnPZnqxqpw1Bhkhqcx2F?=
 =?us-ascii?Q?ZY7K1dOWhQZDuVZHXAGPdJD/KkBT/emsZyeUccdT38rw9ZFcn5WUdzDgZtI8?=
 =?us-ascii?Q?qYZoOSP66CWXmubHfR8lUbZ5DG8RoaQw7+AlLY42cubtpIfSygquc2IFPONq?=
 =?us-ascii?Q?Y56Tl38rPxyw5O0aijmKAxs46x2unH8M/zvlOpbAOp1ghsD4m/6U6R8/cv8W?=
 =?us-ascii?Q?qrl9pK10p9xaP3SsJjwMM1MebC5waDnz38odmVnwv06z+gAAurTqiLPc4Y7N?=
 =?us-ascii?Q?QC09paLOu7FKDQdjeRbyAeDT8ematGRuQerRn/zwQnlp6Ebeq6FGfc8NbhUp?=
 =?us-ascii?Q?lNkhKOkqIFRMwsDsg0PSGBdI7AsRJVDrD/U5iuNkXLrQgdLnq95dmMoz9JNH?=
 =?us-ascii?Q?tVQmOcsJpedSp29qPzQNP0FnUt7OiHhg/jPiPufe8h/tvUO2YIJFIaO88OKY?=
 =?us-ascii?Q?FkT14189GFx/wuR2OQCZlAmeb8xes26Jp5Ff2g3k17s/kxbyVNjqAEedJNmd?=
 =?us-ascii?Q?yIeiP6Fv2XUJotjnMK+B67s5VyufzttGtR5IQfl6?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cec498-4c23-4013-0bd2-08dce246dcfa
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:28:36.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ros7uw7gOzymAVDj47X+SRRrcnvfMcTstwvBARHRJ1XM2Fz55GUFcTV9GioHOocTdN2Gt2y4wm11Rv9HzGcSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7730

On Tue,  1 Oct 2024 16:59:46 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> `Box` provides the simplest way to allocate memory for a generic type
> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> `KVmalloc`.
> 
> In contrast to Rust's `Box` type, the kernel `Box` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kbox.rs | 455 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 462 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kbox.rs

