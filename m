Return-Path: <linux-kernel+bounces-531878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DECA44645
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086C93B1D70
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D66A18CC13;
	Tue, 25 Feb 2025 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="WsvOIoBi"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020103.outbound.protection.outlook.com [52.101.195.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137818A93C;
	Tue, 25 Feb 2025 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501180; cv=fail; b=X9uRUbKHrmcsJRIIqyLuZAwnqjgfoAL1SdVWPsIrVhF9lJKqGPuQJcGc4nGX2bEBEVoY9GQNrKz6xEVLt12NRTdEwH9OEkoaosVX0kBCFFgxwmMt9iq4r8B078MH4E0iCwV3PrPbEn0eZ74UIs2eZRyIcZquixQm+q9K4YvAaNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501180; c=relaxed/simple;
	bh=iyEkDTz01b1gPOeBy9ZR7OuD+gN8ilH9Xhf1HrasvR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHtUdO+dBkOPWi9rYfWprBvuHszbrHgpF1pOxLXQ86ZNXht8V1TxIxaKIxwACuczlCD6lbQfUXT7tNoPlobvEi9vjRyYHOe/FQwHlJfct22yFBQ4amWFAdrdWit+ExgRc4KVitTpM4DPFq9lk4vJicieevmnhEZwn3ekceYsVF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=WsvOIoBi; arc=fail smtp.client-ip=52.101.195.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAicd2+M5MwLTe9MN3fmKB1rqfOtLs2iE1sV9MlQ8K97cpZ9CDgRcaENp5ywgicO7a1cwxZfYV49IErdpFmzXH2miq1SA7BLpdnHR0L0D22fRnH5ychd4V/eKtQtdYpQJfhrTJA3eBkpOKl8c/z68FLEwu1EmNUnb7u5TxHITSivQkMRIuM6GZK/aN3FMug5b6hRLGSKqd299qSXKa/KXN02FGcbMB+RutnjVA/GTTI3cDUftjfyeyZal1IieuKNsc/5+4esln0ciSlbFBX6lZWvImIhrTYU9TXCjDq8OIT91fYo4v6ZoU4r84b1TfC0yX9V3RRyZ+05TpEt0usvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMkK7/0w70KDl7X9HEll3knYGVUC2P94nHEOTzap0fM=;
 b=vGyQbv9GXCJ6PbsEJ96y1O/IETPvyyZHvtt509EcvuMiCMPPzQFX/oAkvrZ1IAFfq3VL/ByQEZobw/EaThq7XGkYnjznF86UQ9ZiFovsD02DrzqK0CtshE8kZXR28BpkmeaqhXAFCiWdQRQtVyH5mTAw0WfYsof4EK1o/gKKV2tSfyrme2yhm3pjI2eg2aACIaZwDqrSJpar/0VXc5sIDMKC17f1p2WsDwN6Pk7V8qLCnn8sLprXRQQco5Yu438DdgjnDRueCk8VnGKpd6cl4nhiSbId2R/J7XP99RGaweHUXiJgxqriFtl55LnuD4UKUltMqlZZz0YDv9MYyRTohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMkK7/0w70KDl7X9HEll3knYGVUC2P94nHEOTzap0fM=;
 b=WsvOIoBi+CXRAKA97uEshCHphgE7cjE4YTV5LoTWZqv1DtttUA974ma1npnFA57VqfWbL/zlzOjKGBLlyt5/TqLcLMvbjxCV+6oD/ervvymUw9pco0TXTCadcSlvb8hYgWRCC/yV2o6IRwqB/uOLh2FSCyzIe0xCrXlLDVM2aZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6519.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.17; Tue, 25 Feb
 2025 16:32:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 16:32:55 +0000
Date: Tue, 25 Feb 2025 16:32:53 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v14 8/8] task: rust: rework how current is accessed
Message-ID: <20250225163253.22ddcaaf@eugeo>
In-Reply-To: <20250213-vma-v14-8-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-8-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: ec360193-df85-4476-7f72-08dd55ba0ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ClBcDuqNGah38O/UMXgnt0u4XvjyRe7FkNe0Bgoczwclj0e3/VCMpkZdBy0K?=
 =?us-ascii?Q?WIT9byXclr+oEwBXeRka41q2URjyHNMtxFiGlmIoHaIN94tqtjX0yk6+upfO?=
 =?us-ascii?Q?BIh9ND3r9keOvGLAot/ujypAxkGu9u9dNoC6IE5Lrmc7FbQuSOjB7v+scf1U?=
 =?us-ascii?Q?6xEG5vHpFJCPOzLhjken8DcMO9N8j43Vlh9HbH/BeinETQDYxgSqO8LLL/5s?=
 =?us-ascii?Q?LL9ZIs6RAzeTjjW+c33SHs6Iq1qPYFodDCeZIpFgvsEwur61ugS+QT/+ZYUy?=
 =?us-ascii?Q?UhdmyUAOgiea5OI94xBVLPXURwvNAFoIObcDNqy1Ihldr2M3/wkH5Q+pUGrx?=
 =?us-ascii?Q?joPCJ8dkl0166hKo7Vse3G7hxTXb83J2Dn+WrhunOH0SidjCHpnPrk6nDrXh?=
 =?us-ascii?Q?L1zeqTK8LJzJUFb9On6Au+WcI7fu2bhfyWuc+bT40OAcZVHd7XhTfCn9sZlP?=
 =?us-ascii?Q?4wNqLA3V8ey1AHT+M3s+HNHIjxfbCCG63puylykTjth1qRTRarqh12985/wW?=
 =?us-ascii?Q?Qa2ff1swT5Gm62SDchqKXNxepSsnpbjXAkHrchmluCpZ/aeU2TJqM5MNEQne?=
 =?us-ascii?Q?AllV3pDJCK7vhMJ2M6PrwL/WH7SkHvYJZgniihdPd3zNTxnknoIHe+8ZAs3V?=
 =?us-ascii?Q?1aLC6Zfi+RDSHzrIhHW+fARaGrWjg75nN2a4HjyEaVHm+K1c4n+7dnjgZwUb?=
 =?us-ascii?Q?eRes9ykpqEbVYxnDnfXogiBsGs30EfeykhfDO1hAHws12pRgmnBQu+naGd4f?=
 =?us-ascii?Q?W5bTpUq51nrHXTnSkpCs8C0WMHvXyj8WbzlbCELBkBf1mrIV7Bp3nNSnE+0U?=
 =?us-ascii?Q?fjb6Wu5z/WpgdmwAy0ImxykB/D3MeayaF+chKqEHGvf/qtEp5u48E9xa4eor?=
 =?us-ascii?Q?JdM1w90nqziTrn/J78kqj4mQlEcchf4Ecd9nPgEZ6whkEiZIQvB0DBTGqJFs?=
 =?us-ascii?Q?Uu7bDHfOXTkPQjC+Os7l9iRiFb0wqH345WACSED+/5kX4ufjSMqItUXf/Uo6?=
 =?us-ascii?Q?3Wwp3270NH+ArFo9cvF5vAOq17lASbKiUzGcaedCGvYw1xYuz6lxmL6rWa6x?=
 =?us-ascii?Q?SM9TA7qHhviiBU5/4jy8ykdTHZ3kgffHjTpmbal2lwsuHReW3GnvSq4rIJyr?=
 =?us-ascii?Q?7e6NCUO+i/b/IiEmajL0fGGfUvIvUx4/j8OrQwc42DyIbxqqjf2j1VrQMevW?=
 =?us-ascii?Q?MCX4stkYvEVWx6mznyQcV/+xjTh9OTKMTfoAkhK+rc3hHpoQ86sqMbSHhsFl?=
 =?us-ascii?Q?p9ossYb7AWcasUN3hgBCfPhIadkHHXgmjlEszFsl8xhm3OQuvjqoCL2dgHyY?=
 =?us-ascii?Q?PuGVfhjlhtHaIJgyt9liRwdwOVfy2rKV7Z8qi3pwTntXEaaohLomex+bDgtl?=
 =?us-ascii?Q?sRo6ERUT4TWhwmSDsVxq9MrCpTu/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZN5KXrz3wD9RgtxzA/HJ+YgLojj3BP14LfT9eT//mMvtdlThJEVoGdF2MMEs?=
 =?us-ascii?Q?iQ+RDlVE14zndU4hUN4MwwYrsv4FWcDZW2DsECwpnr9IOg2DfWKw0Vx8wKYR?=
 =?us-ascii?Q?JLZl9o5/faoqptbhhTYOzykWImigDO7aMB2sTzRUoJEC2MrjwWs4h+LHGAL5?=
 =?us-ascii?Q?CfEC3oE9ViDQdgVYy41B3xewgxPgeJc4j6n63lRfOKyYutcO8UDm4X+UGOZl?=
 =?us-ascii?Q?gehg93RNT3Rnvm1Zgi4L20ijDDrMhvwKsKzUHt99J6Bb474aD1J6dh8icceo?=
 =?us-ascii?Q?v7lRhen15WzbWOD8Nqhd/mlKA9tux4Wqo9Qo0+NXfiUpRvmvVZx4aae14Zne?=
 =?us-ascii?Q?yTA3DfICccRdqQ4tRk/owPJgFvV61Ws2iGUn8mmOFthjVO6yUQiM7okkd58Q?=
 =?us-ascii?Q?7BxlBAsEdlQF6AUIPFsIpvxEYVOjMAgvQLNYYLpONyjnWPEWL4YzYoeO0w9W?=
 =?us-ascii?Q?SV6B7YgDHC5Apoa5ziZ/glaYPikzTjE7oHn24MwRtqaN2g01SIgHd0xJWI5P?=
 =?us-ascii?Q?1fkfRw8zWhIkUu+OQjR/VLwBEHmC19JWrWb9gGlJwM1TFxOzFRXmqr9eXNRq?=
 =?us-ascii?Q?ESwzuyhQ4CToEwke/VF0rKrVbJuuoeQ+sgoC3ojhIncU1QafwpkmlQVHbEv5?=
 =?us-ascii?Q?7qcg0vyMosmU6cB/yZakQCOqUSWvU4YIrAs7XidOPCeUTbPBr/VZg3R5M2iH?=
 =?us-ascii?Q?gtlExc65wna29tqfxF7gSpEgKOqvTpI7jnGC1qCVlZhw7n07AcpHMyEkHXrR?=
 =?us-ascii?Q?V6bEOv0xr/wHTy7CqC3btCbS2Atho1HoFS2pY73jLOT6XPWnzsR2mfAmnNZd?=
 =?us-ascii?Q?Qv+bujy/juHkExgBoMU6FBzPz2XDvTwxbX9Vph7yy7mcjHf0z9W0VkU8zwVe?=
 =?us-ascii?Q?puIJbrW7B2fNthFEqeyCjSeqMeAuCBV0Gy2YcgY9e7lftSMrwYeq6hhWp1fP?=
 =?us-ascii?Q?pnCFpfe5p++4HrWR8KA5J2yEQNIl39CpgAWNgxt9Eu7lGkZ7ZLEi5hNUQlkm?=
 =?us-ascii?Q?dQUV3zyhx1q77RQCmTCODqCvm0ZNQUyk6CqTbbhSSPmLicAdAjpTeQ5Gr1s0?=
 =?us-ascii?Q?Cx5ERecpA4BvGRW0LPjlEMB3qCE53/BYJazUXszRLRPQcAvZl0umbTjxpKAR?=
 =?us-ascii?Q?8yPO+cpb1Lv5UBdXZptVUqzGXgHPfHelh5quysO1VrWjhRJoU04Y385bTvL8?=
 =?us-ascii?Q?pJW93rEUA1GThjMoVYq64S2TE2WGRbEyxzciFwHXpKCP8m3x907bslAwc/kC?=
 =?us-ascii?Q?17a12Z74wOG9Xl+o3ZbBLM0rforI2/7YBBMc0WJEunYHo7F1PVojjPuUC8nN?=
 =?us-ascii?Q?DrayiIYAC/xTQV6HJxmYxWDwUmhiKXrk3E0FEkw0PaUwO9aB9GXeXezgGZzb?=
 =?us-ascii?Q?JKZRkHw+/f2v6c4qimk3ZXULU3BgmIIIIO5owpzIPbplIplaZGW+K5ycUVN4?=
 =?us-ascii?Q?a4AOq2FJqrK+wvAU5uqzVS4Iijk+9IsV6mplJlkks7ZWxDpVlM8h8GiydAJh?=
 =?us-ascii?Q?R0AuRTOSC9xMWPBdB7WDjZEyFCqDSgvXzWQcGgCz7Qev4cglT7/SVxyCgODG?=
 =?us-ascii?Q?kmxNELLqzOD/PVbOdYhZ6zMSayhVpVCP7JqjblYh+aDnxx+7l1yFb3kebenb?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ec360193-df85-4476-7f72-08dd55ba0ea1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:32:55.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJUNbhn/Sb8f5SFigiiFdHSOjyWE5x+MC9COIXITRYxXipPhEMlCTsPR0I+UT21fyuThZsZeOWHKGilNL5s1rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6519

On Thu, 13 Feb 2025 11:04:07 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Introduce a new type called `CurrentTask` that lets you perform various
> operations that are only safe on the `current` task. Use the new type to
> provide a way to access the current mm without incrementing its
> refcount.
> 
> With this change, you can write stuff such as
> 
> 	let vma = current!().mm().lock_vma_under_rcu(addr);
> 
> without incrementing any refcounts.
> 
> This replaces the existing abstractions for accessing the current pid
> namespace. With the old approach, every field access to current involves
> both a macro and a unsafe helper function. The new approach simplifies
> that to a single safe function on the `CurrentTask` type. This makes it
> less heavy-weight to add additional current accessors in the future.
> 
> That said, creating a `CurrentTask` type like the one in this patch
> requires that we are careful to ensure that it cannot escape the current
> task or otherwise access things after they are freed. To do this, I
> declared that it cannot escape the current "task context" where I
> defined a "task context" as essentially the region in which `current`
> remains unchanged. So e.g., release_task() or begin_new_exec() would
> leave the task context.
> 
> If a userspace thread returns to userspace and later makes another
> syscall, then I consider the two syscalls to be different task contexts.
> This allows values stored in that task to be modified between syscalls,
> even if they're guaranteed to be immutable during a syscall.
> 
> Ensuring correctness of `CurrentTask` is slightly tricky if we also want
> the ability to have a safe `kthread_use_mm()` implementation in Rust. To
> support that safely, there are two patterns we need to ensure are safe:
> 
> 	// Case 1: current!() called inside the scope.
> 	let mm;
> 	kthread_use_mm(some_mm, || {
> 	    mm = current!().mm();
> 	});
> 	drop(some_mm);
> 	mm.do_something(); // UAF
> 
> and:
> 
> 	// Case 2: current!() called before the scope.
> 	let mm;
> 	let task = current!();
> 	kthread_use_mm(some_mm, || {
> 	    mm = task.mm();
> 	});
> 	drop(some_mm);
> 	mm.do_something(); // UAF
> 
> The existing `current!()` abstraction already natively prevents the
> first case: The `&CurrentTask` would be tied to the inner scope, so the
> borrow-checker ensures that no reference derived from it can escape the
> scope.
> 
> Fixing the second case is a bit more tricky. The solution is to
> essentially pretend that the contents of the scope execute on an
> different thread, which means that only thread-safe types can cross the
> boundary. Since `CurrentTask` is marked `NotThreadSafe`, attempts to
> move it to another thread will fail, and this includes our fake pretend
> thread boundary.
> 
> This has the disadvantage that other types that aren't thread-safe for
> reasons unrelated to `current` also cannot be moved across the
> `kthread_use_mm()` boundary. I consider this an acceptable tradeoff.

I like the approach used.

Reviewed-by: Gary Guo <gary@garyguo.net>

> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/task.rs | 247 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 129 insertions(+), 118 deletions(-)

