Return-Path: <linux-kernel+bounces-348219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324E98E446
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989C01C2369C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF768217322;
	Wed,  2 Oct 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="jLuFNLzx"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2138.outbound.protection.outlook.com [40.107.122.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8781720;
	Wed,  2 Oct 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901480; cv=fail; b=aD5Ie345yRzUfkuWGzcfrMw7iXuS3s/mVzAkI0jgdRpcftoRHQ1SOSo1JfV/ryC09MFaDbxzr0F2Dksqamk233RYpwbO9blPqWGUOhhmZYXuBRowpmw5VUiPqB/M/4r+KT+bDFVRUugMESxTculEUVcGF556ndRQ0hCrv47Lg4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901480; c=relaxed/simple;
	bh=SD7o+KkqIX+B7GWXooGr5w5obIWbDbpGYKyCBuv16BU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHo2fHRfPlZfSmVoqNSAwYCpN20r34i0vaaY082IZChTXeR9b/MYvnCtWEqWYsIOt8GW4t7fhmvzfJcbj+hXSQWvHtf8rlYn64X5TsjW8VMGh8zMJOcesLBuGQnnpEAvoJkgz+C//cpRCCjsQfzWJeXiuwPfhEoTj5BfuDZwRCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jLuFNLzx; arc=fail smtp.client-ip=40.107.122.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTrZZ4FTe5DQlSOuOMDyItWSvUlup22xgtHssg97WIxwtineH80Tdw13hPKLu42PNHoJej2Le77D8xzLLIpBN71kohjtrQsyD0wK9bN/kSMwC6pftt6UwrPOjRcorTo6GB9oXyAEBRA4KO7X543njg0csMni/d2EmzY7u3//Y5IB/kCYDVOWh4MoA8M5o794+Um3HBIhj7NgIKQnfCO1C0/+r9R87lYqWRwhvXW//gfqLqRUXRWe99RKtjpTPxch04MiSJhQz7ZXxWJB9W9rztrGcNe7p0PUnwE6/3v0sFY/J4YAyApSSbL7mC9PjmJ4XFjtKiWQ86S+aUpXq5A/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbTZ3IWE2NAR1s3negpmjBIkUZbCerIryHiuLCwDEuo=;
 b=KMUIayJvBJeef8EEygD+S6J6NmbYAEXsAMhXDT1ZO355UsUz3Ar5hxZUarIaXhaFONh3Eug+LTORcX1E+0WzD6lIcG9NS6QYTvSS1JTw5JpT53qjXY8mCVs9oRIoojy/LDYNgScIziQ3UatSY7oIcvAYT6C+SB62qO9PDmyGcILBbl//Jg8t1050Mwg/S6vbuIdfioRRMOnHmiyIr8GGELX7XeBu8MKRec00ucIpKVcR7k841vcHMCGX/5kTaUTJXdGI8dkpGu2x5iMSVLCkD+9IHEAfFmBfaJnUWHYUVhOlh9N7pEh1kzoGXD9tb4QuF90IPwgDf8HtThapORmSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbTZ3IWE2NAR1s3negpmjBIkUZbCerIryHiuLCwDEuo=;
 b=jLuFNLzxcvN7+ilfy9Eq1+KDb1S3SaMIlbdM3BREIBMVDSmsURJM+tWx888XRg5nFUAIToS61/NEDgrqvWglNKSxGZW6MOwjQetGu0JXKK9OwcJMn5Y5GOrlIvbCFRj8L9HjZ8J3EJ09dUCfSySrSesbHJmqaIwWrsbf56e/h6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2942.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:17c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:37:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:37:55 +0000
Date: Wed, 2 Oct 2024 21:37:53 +0100
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
Subject: Re: [PATCH v8 25/29] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <20241002213753.1d420c39.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-26-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-26-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2942:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bc94ad-2cbc-4fd9-1a97-08dce32217fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHuPMfulzI8J5Nd1pkPGkf7E2tZBwliMGwuJLfgodIAVyRjDvHeIvXImad78?=
 =?us-ascii?Q?cYPIgiuGIeET05nYYBxn298smBihxZcYcRid6oPe/4UlF5CcSyW2oMBjSDrb?=
 =?us-ascii?Q?OTpAJ66KkH5r0cyJgAUU5DEBHS4S3oYDaHN6YUV1YQaS1kK5a+e7jEK/Wxut?=
 =?us-ascii?Q?i+KNqiWI2TNxDu8jDJSbD0l+ExStkDYd7x074lvCoczk6ydH8qWOPyYeySj0?=
 =?us-ascii?Q?cracCNjUZiD2INmNvwiVwmBvGGVhqIVOzZeBHnq0PMPdwan38HpHhht2oZmp?=
 =?us-ascii?Q?jpSIoJQap1oBA9xGHYzQTvvZmhz5XjJ8zqYDULGb5aai1LYdgXr0w4CuCMdI?=
 =?us-ascii?Q?a3XQ1IpBmamMrgrTiPlw4BVtgg4USjeDjR0dCZDzgbOro0NSpM92vmR+ni4y?=
 =?us-ascii?Q?2bHmIEi3tUMZsfd06wa7+6kjlIPWqvITrKkwJnlwgHNxS7UGZAd2Yl4AUxIP?=
 =?us-ascii?Q?MaNR/56OIgtOH3cUZtSdCORrzAd+UOECn2EBbFpz8Mjj1eyrw0k8uAvTThHl?=
 =?us-ascii?Q?yuUVNZUvsxSdRExNy786oFZikBSEeJLEaZb/NsLXtXbB/Bckk/wu2fLIf5Gz?=
 =?us-ascii?Q?BoNugTU9LbxP+In1kB01p3Qt0EAxP1B3J8c1SmHYevcNzqArYcR0zmKnVQPz?=
 =?us-ascii?Q?mnOVMDSG30/IWr8EZp5q+YwneqxLxh6PHR+UPhXMHSHARaCDA0P+jZMVH698?=
 =?us-ascii?Q?bmJLqZf6t4u+9fucalENIL6StZqVYBBr/xPbrdSx/O4BPrYzIxV7Qxo6Hnlt?=
 =?us-ascii?Q?7uZEUYDqgp4iHYpZstbW4becNs+m85hmMYMoGw9UG/3YmsfPWi7HwtkEJkDw?=
 =?us-ascii?Q?I59EIGEmRfkyqb704jBxf+hqr9APgVs4IwvBu3meX5FIw2cYodMDvRGcjX2p?=
 =?us-ascii?Q?NGGtAKnRmkoGoHvGYkC14cQxVAJDhO3ONJxAKgTxa1dfB4G25QeBf7x93blR?=
 =?us-ascii?Q?Q8oaQRUn35EhmqD4LVMLfkmJQfQURvfVcOlmLMQPcPAmr/P7acXUh6OdZFjf?=
 =?us-ascii?Q?lxIezgyq+hOmmk0b+msLFNigifw1/ZMwWhdOwqsGpdTpDvoysLXZ2LMbqzUy?=
 =?us-ascii?Q?EZOmUjy/PgsJ8a/0KXAblCwZy9OmYuEypl1MP/Vy7n9oVHBtKTLYpDntYRZn?=
 =?us-ascii?Q?7wo/XMQdWkTKY5daA6WvGlW/nKGXoAfiiMGiir0CL096Fi9i3ILPXWp9jlEI?=
 =?us-ascii?Q?wiRG2Abq60aWZw4lYipVlUNJkFz6h9BvTvWQcVOL6BFYk7zxhFPm0Gk3RSuW?=
 =?us-ascii?Q?m6TWHtX/JxkzvyG0XnfodoBOqrgDUsDbORDo6E6yVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mr7I+q/1V44JI+Q/ooxtWzP0EblHcdQ0Fipaa/zZ9Jhq4V8ZxXnDZ5EC2i4j?=
 =?us-ascii?Q?rK/fRu5U0PHpgzI1IbNYRVn6yezfHo/LyXSZL9oB4wySLRkj4sRsRH0D5Pbh?=
 =?us-ascii?Q?O0xI3CQ+cpdGu3cmHo0i0bSp76UOK7BMCHXwJNaMoBpUk7UoT8yy8N2gZWjF?=
 =?us-ascii?Q?glENLtx1DmkOMsidbc+KlzBWcqXn6JjT874oCB+ZMz6hwH3nGqJ5zPyIqnoS?=
 =?us-ascii?Q?24mlax0yvH+8P2lrUsdNhqN7ZPKs/ZBw/lnefRAIsj6ezDa1JZaoW3nWfZA6?=
 =?us-ascii?Q?G3Kr1Tqvz6ow/zyML44rkisYLLKEzxMwLiIOIEglHvcOQdujLA1lyj1OP81f?=
 =?us-ascii?Q?q7FOsy0TtCXoD7Sk1uVI3iTufX39oWPx4q9Bx/9PniFPctlV+ruqyNJvXOi3?=
 =?us-ascii?Q?4vpTdMrXMOqxuxOiY0YSmTazhHCm54150KTrUf8nUVaFdAW0U8PV67R04w/b?=
 =?us-ascii?Q?0fWrrntnuz+fT/u1e9aWLa/eZm362Xdgp2zF3fNV9RAkJ2MRYx2QmHZagNlm?=
 =?us-ascii?Q?BCJb47TkBet2Q0ZkDRQzkOvs3PaSvX+sjX/qOm7T7PqQp5VYatKH/7x/B9Dp?=
 =?us-ascii?Q?iEz2ZGmc3xMby0J42Wo1shL4W/ogmluzNGT6YSQ7k8bVDywKrBn6Z+QxaGTC?=
 =?us-ascii?Q?xf7gShO3b2exRbGQkDIJlIIvDbQbqjhxAJgac4xxJw+2o/pKgxFFZ2e3Fioo?=
 =?us-ascii?Q?rExdQOLGUOTzpfZLpWg9AenXnsRwY0wgvznWYvKB3xGhKpM17h6jz03QJH3Z?=
 =?us-ascii?Q?43AntjLO3aKnuFW+x0dRmYLjQmKLF0Vai8BlfKWePRtGbBFyfsk5rERhe/y8?=
 =?us-ascii?Q?CK4Q92axkqFxtW734a84oRm3H4H2t8G/HMk2G2YVa3QeyJ66WI5MaTfaOAFl?=
 =?us-ascii?Q?s6cUHmJVlKqTJjhzX6YFc0F82d0xfWKEcowD36VtWm/lBbEoTuz7EklbbusL?=
 =?us-ascii?Q?Z7+872t7LTOglf/7VKvUIjgziRLNvdhGosJfF8YpwfmJw3NryDJcMeg5lZg2?=
 =?us-ascii?Q?jHJtMn+v3OulBM1TMSY8291l10Un15CeLpdNep8UnOZAYHzCcyBAQ/IwmBbj?=
 =?us-ascii?Q?qPrVh3q9TMy+rpV9WTId7WNfBeBDfWClUKcbzwbcCueJDTucNkDHVnQLR48c?=
 =?us-ascii?Q?GuP/iwHXVi9OyBvqi8x1CbojKMvqucRKxj/kbc5s7A1I8wcZHM4NcTn7UjLd?=
 =?us-ascii?Q?xtvcWkNCEIXaujGWtAymgjK2w4neRCLc4PT00GUYz/w3XEBfjeoCABxI4tIN?=
 =?us-ascii?Q?EXG3O55UavynCELjM85GVC7PDeR8/q3iDj0qkvEO374/+M+arPEMC8dgrzBy?=
 =?us-ascii?Q?FEwnKhrKkMi1GPuEPlDakFUCxkkEOBeE4IZJGflfyndUnzwp0u2UlE92IsTe?=
 =?us-ascii?Q?UBEy7JuQ+WQ5gK2/PEEWAXo28CrlTYjgjk61d9abBXTvdjBPchBVc4ZElac6?=
 =?us-ascii?Q?zcfldrRDR6iMiQSkgRRvZ6h35IfXQq7knL39N2aTmNxkjr0a/yi6ytL9lOBZ?=
 =?us-ascii?Q?k9dV5kRBQSKWhjvNCDZXPtYAsy7RQVdiIoqWWO4MJS1OXfgSMPVbfeRj90Ik?=
 =?us-ascii?Q?RYeEjAqCB9Kwe6shLaihcyME+yJsw+RptOrABzqRckOe8AzmmS7vOhZx1UUJ?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc94ad-2cbc-4fd9-1a97-08dce32217fe
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:37:55.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 006FZ10h1SPVAEK4betEBtwecCzzg1ofOF5Dwwq5oZE+tIx+mYJxtLsJaZ4grfSPR5kGLqvWx7oGJO6jEQXWIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2942

On Tue,  1 Oct 2024 17:00:00 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> So far the kernel's `Box` and `Vec` types can't be used by userspace
> test cases, since all users of those types (e.g. `CString`) use kernel
> allocators for instantiation.
> 
> In order to allow userspace test cases to make use of such types as
> well, implement the `Cmalloc` allocator within the allocator_test module
> and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> allocator uses libc's realloc() function as allocator backend.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc/allocator_test.rs | 88 ++++++++++++++++++++++++++---
>  1 file changed, 81 insertions(+), 7 deletions(-)

