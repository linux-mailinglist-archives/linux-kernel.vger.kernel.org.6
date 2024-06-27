Return-Path: <linux-kernel+bounces-232140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99F91A3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9141F244B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3581420B6;
	Thu, 27 Jun 2024 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="eTc1Nk7G"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2114.outbound.protection.outlook.com [40.107.121.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0713DB99;
	Thu, 27 Jun 2024 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484611; cv=fail; b=Re4zrK/rQ3KRgrQxtDjAH1qUF5aHf2xfGP78M5s/Dbos+e7OSrp92ayVIOKssmk2vEaVWgiUQpJNogM0XaPEL3+W7HUb56cIBmaM8ST6+VM+ijCCnijZwKcfyq0efkBiUOAqrFD8vuyXG3Uc6tBfJJtXWFubBx8KjOE3fL2+K3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484611; c=relaxed/simple;
	bh=++yFD+/Zp9ODX+g0Hd1k0oBfVcVgd9nYGg2FYqTshyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUKAzUTQdF39djd+Vz/WT3qEWQh2WyBlYM9VpiByFtcUzLy0glSyWYPsUkAZHFHPat9HvGa8PCI6Hf8+/qXr20LuFAQSV/tJYWdaLUbZSJdvH3Miei7dwenKGJQksbyOg4TpuE1VMPQhb2xsDwPSmODdAQFAvTTQi9DWbwA2N7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=eTc1Nk7G; arc=fail smtp.client-ip=40.107.121.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM4iXJX+p0dHCWZ7qXB29upUYoDLwYrV00qtvDeE2hCM4Amwdtz8aOC5OTH1CApxMqA5a2YXN5pv+GhbuhCTJS3fbrqB0ioqUZQqWywEvfLIL/tiqfJYlgIE6mYsV7Mt1HeXVii3y8vpDwNMQ13vSMQBqWF/wU4rOAo5K1Pe/3NeXPM+ixvDduQCEyMQPKbF9B9FszaNkWwA+Xo1PdXSmxZgJSJDiEJQfETpXwaEj9OCW6rtUIxEu/ZhP9NAICYNmYpHxVzuQJkeuOoFp7iNwYGxZw98FtbL3i7bvboppFNJXMCpS25ZwpUcjk7PGbMo3XUt8Bil/QlvlHFWGEjnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxwKAgV0FalUBA5WTw0i9AweEQV2tuMCojQhr10B5v0=;
 b=jW2XfwsvYj+u/yf7Z376A0iQjnFUCx0siWqGlp0Qt1Kb4p25Xzm+cpZipqULgBONkpfUzkU70Jv7l+utUe8h83vurz/hFLuAE445ioN+kmTJBbl3fO7jKo7V/ilW1FFh+8O7YXeGP3jX+K4m+HBzTR68hRNlD1R61O7oo7Qj9Ii4f+7z5QMOndH/SL80Y6v46cauHtH+Cg1dkoPgDBhH5lAsXw/j5pL0/ZGEiEP0LwMAQf7XRjBuCD3VNi14B+K8bp9Cck+Ho4g6l77wdS0YY9T2g3Ve/2Da+st2c1KYcYoV37EfJf/vIyIlkcOtqDpSGazxLUdLZ9tsjEHAM+g7fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxwKAgV0FalUBA5WTw0i9AweEQV2tuMCojQhr10B5v0=;
 b=eTc1Nk7GhGvQfL8zCFGsdSRaFWtKE3z74kJuDeMLGETvTIJCIasPR6gWR79poTLXPUkYKXLJ8m32enFK/zuckADP2LXC8pLwnQjd9pystmzOh9kywv9r5ml1h7uzMbLEp30r3LL+99ZIMU1fuH9mKVfn0vG9Pfona71KOmS04vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2614.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 10:36:44 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 10:36:44 +0000
Date: Thu, 27 Jun 2024 11:36:41 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
 russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
 wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] rust: add firmware abstractions
Message-ID: <20240627113641.18d77571@eugeo>
In-Reply-To: <df627771-72c7-4532-87da-3a132ad17f83@redhat.com>
References: <20240618154841.6716-1-dakr@redhat.com>
	<20240618154841.6716-3-dakr@redhat.com>
	<20240620143611.7995e0bb@eugeo>
	<df627771-72c7-4532-87da-3a132ad17f83@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2614:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b0bed0-3596-4c53-46c8-08dc96950a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vcTE1PdnFYmvVMGSTH67x7iHhT4byQLMXPCRCCe/9dlulLrVMtWKNipchqUX?=
 =?us-ascii?Q?3bwNxdF6RlNj7HRBtLospZDaI69eCGCoePfm81cKX1uyEgOx+DpykDXIoRc1?=
 =?us-ascii?Q?FSHOqGIYfCS+SDUORFlh2CzukdF8Wg3CM1FOIHHsfQVZIPNWuOZmJ5W+x1Fc?=
 =?us-ascii?Q?31FKcNrL9N7kv21/htmEMHyTYtFpPyvweNzzPEi5auwJA3hJKe9S/nO3mjFx?=
 =?us-ascii?Q?4JfZW3jE24fPJDtGO8oP1qBA7MU8/74zGuXdw4G10MY9dIygvzR16ffp39zB?=
 =?us-ascii?Q?o9xPzx4e6Zp/4QWtAjs/mqG2sEbsG15E3GazpX48LBzSU8XTVq/gkHpaRZ+f?=
 =?us-ascii?Q?t4o+ol6kUWwOi2IA6uSJcelBD1ChVb4kBpW6TVnkJ58TQrI2iyy5g14FDvj4?=
 =?us-ascii?Q?25JaUP8znA/hXMAyTfytRd9x7YJseT74THJHyE3V1dfwvPPpIPsULSG6GmDu?=
 =?us-ascii?Q?PtKXleeLxfzbzR8EUjSc6PB5rOYS6zGA55A1vqDe8AjRb2HpNsXH9cLGkuwr?=
 =?us-ascii?Q?md4D8SHO+51V5rJPLdhh8sputx/1dBiDax5CTLQTiMXocB2yIJwTJ+zOD/Yd?=
 =?us-ascii?Q?6tTwcUCymub7akilAuvcAQ+XZnaMJW4aiHvwrfSjB7t4DT+GxLe2yp4XE/FJ?=
 =?us-ascii?Q?Ld06dZE/FJOS5l/nFO9AjC+m17B8zCpd+ackz9h5dhuOU4ms7tm8dA6YJ/Bb?=
 =?us-ascii?Q?DVZfSUR+GV9I1GSvx09Gujjctq347efQsyb1nPmWTUrz1WfxcAomqluayQGS?=
 =?us-ascii?Q?HabkjcmwZx38Hc3LNyPYITa3/sWgw+NxpUBQj6uyBipEqWvK/hb6bo+JrP4K?=
 =?us-ascii?Q?9Gb6aiEzr8Vy1hUP8dl1DTZaftHe1sjeaPmAFvTW/2OZ8XZgoJFhl6GKe6Az?=
 =?us-ascii?Q?pRn6Pv2KMvVS65uLJUzDO45ilnAkUNsIGeu6ftzTD0ykxuNYCDHFnMg94Z47?=
 =?us-ascii?Q?AF1UqIspzODPm+AnjjtzHMbyYop7d7P9HCnxowMR9dwwvybmmtHFIIWoTqFz?=
 =?us-ascii?Q?RyWC6tiYFZeC4+RDj+Wd9QPd3kadvTQ5mRX8j99tI3WOkTbhLTuWg25r55hN?=
 =?us-ascii?Q?NdqkAd6E8Aen7zPZj4BbUGi1kRABpEtqnpCdllehbDFUThzejpEXNSSbmXxA?=
 =?us-ascii?Q?VS2+Q5qhHZABmKhv3ynaqU6jZP7WPWPMbHyLYnZ/3+PugHj/SLH+hr/zktVQ?=
 =?us-ascii?Q?7HdinHLbestxu8T7x0ShjJX4aQkPRT5nXwSETJsw5r/0C6B7wdDacjUB1Db+?=
 =?us-ascii?Q?uUqjsrCckg6BKitSpspyAlmc0CcJOH73VnXB42yMUcnBs5znWCfldX6mcq9n?=
 =?us-ascii?Q?ORPIqU/KKi/H7EQ5vf8wppCLmnvtC/XLzAVxLxIVmWGaVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q6OGVGaROa5ImonsULRxbZfXW4yYxc+0WZLxPCeWJAcRvlKPbdmjut84LRYF?=
 =?us-ascii?Q?UsSuCRxLSAJu1X6FECeBgVWLxm/32mJ/8jmPad4bOiUUdZpmyK0bwMIw9Uph?=
 =?us-ascii?Q?fBWlmmiVuElm0jJFPwQBnKZ8ettdq3Jc7x2iWgKIqq4XY3S/sXaRa4pF/l2/?=
 =?us-ascii?Q?PWd9AcqI2pK+Hvd2xlvsC+I5uf351A9K3453h+Yyi8GMb5Su5Rl+gy/8fdEK?=
 =?us-ascii?Q?hN95WoTjrnsvActuSeo6tOoFnipWiH4mbrFewKXy3CHqNIr5WfmliieEntRw?=
 =?us-ascii?Q?Km4u0hinD4zth8n13Y5iS8RDZT0moJctvp7DlxFjONiLthqZs84gY/ITwlTA?=
 =?us-ascii?Q?vKAsH8adakgh8uZUYq0irYctSMxvsbiqFaLL06GC2rRExlI4MNR0T9opiEQt?=
 =?us-ascii?Q?E491DRr3bv1P6+KxECUVsDxln93krTgy9D3+Co2DXNqqb40hOcIr8GGcTdel?=
 =?us-ascii?Q?doKJtLMmk756Q4ogDvX50+rjXofzS4/HAjKXTBMfPg3H8igI+4QNHYTp47y1?=
 =?us-ascii?Q?cdFj39JpF/1+sP/fmudKHAoTFaiw2lBSWP39Qg080f7TE5f8HMC9ex6gOfER?=
 =?us-ascii?Q?Tv24M/TjIKwRc5L9AFGKwvTQ/Q4bxtRso6Ac/3d1O9OSgZwbgk0nakaW0lEq?=
 =?us-ascii?Q?9FlBkqXJEkq0MfnjgbdOisHzi3i0oh2Iae9g3+KDNyUoSrA1xXOfB+t2Ul5Q?=
 =?us-ascii?Q?zqVsz1WVICo1+EKgfsTvVMFRIqQB54n4sndMvMeuprDTfpB+AQdQCV8rgvIO?=
 =?us-ascii?Q?pvdkdvOF1bUzu0DoMzAj7o1RZA+C6GcuCfLL/xJVaWQKLCiFW8s6M1PtWTs/?=
 =?us-ascii?Q?Fx7neDMxH2JtSF0NCZtCQ++ypvE6tSSsiXg1PhKm2unUplh95vQw6G26wEUH?=
 =?us-ascii?Q?HFho5ovwd1IyLYDcEsfoED7ShIwimlx5s/6wKVoVqy4Vv3EEQhhnhKWr+JbM?=
 =?us-ascii?Q?IPGDQSf++j5Pv8rvDrPKbYq4Gv4NfGLNb2YNDPCEuXf301dTrWqttyAcp0Va?=
 =?us-ascii?Q?pA9Vh32RptEE67YH4AT4sv1tIdVOVyDmV/KZoisrMHMnB7OeO399AeS/UKc6?=
 =?us-ascii?Q?i2KXMiZpR8IDe3aOq02+37E29acDm7TDoyOl4quKxBOL8OEZwUYewlCMgCvD?=
 =?us-ascii?Q?bK4QBwB0DReqbUWM9hGR6uea4kwQPWri4wsPTGj9M4BEFHmh7Yf/5Rv8iOT4?=
 =?us-ascii?Q?nH+aea6F33sKZDcBMMoOOHcRvVCv7LxPijldgE5qiUz5j2MDt4s8qfKLkgk2?=
 =?us-ascii?Q?lncEn2ETT6sgQMw4XcX+1WEnMSyyggRrsPxSfOZjb3Pz3StuHZmCphM12CD5?=
 =?us-ascii?Q?ObCZ0/yemLEya8TbBnh0ndFn4m1xrr8YT2g7IQ8/5jtt3dVbi8P5L8RNwcNi?=
 =?us-ascii?Q?F5pzC1IGpMprWgHZoYLguOWyZV+kHgTheYuEwnz1K9gl3gfIqU1DYScJSOu3?=
 =?us-ascii?Q?lNFZ+/yw3xa0LdAfFVKgfMDEhYlSJg36kftKK8xeRrreYItRhVp96gzZRltf?=
 =?us-ascii?Q?8vg3grn97CrRPkjqe5QjlM1NEU3rp98Yoo2nvRVbHDAnksiIZenBU0Pps41/?=
 =?us-ascii?Q?Xq41i2UxHwjLCYuMFw7So3X3FwwJwQVjrBvP929H?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b0bed0-3596-4c53-46c8-08dc96950a1e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 10:36:44.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXDknAyYGprUMz2HvnImkwhxnsetQklE6qhkNqsml16vrhetrJqyjepIB4gY2i4LFHiwOfO3SEkmW3eDRMKoeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2614

On Thu, 20 Jun 2024 15:43:52 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> On 6/20/24 15:36, Gary Guo wrote:
> > On Tue, 18 Jun 2024 17:48:35 +0200
> > Danilo Krummrich <dakr@redhat.com> wrote:
> >   
> >> Add an abstraction around the kernels firmware API to request firmware
> >> images. The abstraction provides functions to access the firmware's size
> >> and backing buffer.
> >>
> >> The firmware is released once the abstraction instance is dropped.
> >>
> >> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> >> ---
> >>   drivers/base/firmware_loader/Kconfig |   7 ++
> >>   rust/bindings/bindings_helper.h      |   1 +
> >>   rust/kernel/firmware.rs              | 101 +++++++++++++++++++++++++++
> >>   rust/kernel/lib.rs                   |   2 +
> >>   4 files changed, 111 insertions(+)
> >>   create mode 100644 rust/kernel/firmware.rs
> >>
> >> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> >> new file mode 100644
> >> index 000000000000..b55ea1b45368
> >> --- /dev/null
> >> +++ b/rust/kernel/firmware.rs
> >> @@ -0,0 +1,101 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +//! Firmware abstraction
> >> +//!
> >> +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> >> +
> >> +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> >> +use core::ptr::NonNull;
> >> +
> >> +// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> >> +// `firmware_request_platform`, `bindings::request_firmware_direct`
> >> +type FwFunc =
> >> +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> >> +
> >> +/// Abstraction around a C `struct firmware`.
> >> +///
> >> +/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> >> +/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
> >> +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
> >> +///
> >> +/// # Invariants
> >> +///
> >> +/// The pointer is valid, and has ownership over the instance of `struct firmware`.
> >> +///
> >> +/// Once requested, the `Firmware` backing buffer is not modified until it is freed when `Firmware`
> >> +/// is dropped.
> >> +///
> >> +/// # Examples
> >> +///
> >> +/// ```
> >> +/// # use kernel::{c_str, device::Device, firmware::Firmware};
> >> +///
> >> +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> >> +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> >> +///
> >> +/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
> >> +/// let blob = fw.data();
> >> +/// ```
> >> +pub struct Firmware(NonNull<bindings::firmware>);
> >> +
> >> +impl Firmware {
> >> +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> >> +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> >> +        let pfw: *mut *mut bindings::firmware = &mut fw;
> >> +
> >> +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> >> +        // `name` and `dev` are valid as by their type invariants.
> >> +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };  
> > 
> > This is line is unsound if this function is called with an arbitrary
> > FwFunc, therefore the safety comment should also mention that `func`
> > cannot be an arbitrary function and it must be one of
> > `request_firmware`, `firmware_request_nowarn`,
> > `firmware_request_platform`, `request_firmware_direct`, and this is  
> 
> This is documented in the type definition of `FwFunc`. We can link to this invariant though
> and explicitly mark it as such. Does that make sense?

You can't really attach an invariant to `FwFunc` because it's just a
type alias, although linking to the comment in `FwFunc` and mentioning
that all users are within the module is good to me.

Some other options are:
* New type over FwFunc and attach invariant
* Make this function unsafe and have this as a safety precondition

Both would make the safety comment making local reasoning rather than
file-level reasoning. Although I don't think either is necessary since
this is a small file. But we need to be explicit file-level reasoning
is used here.

Best,
Gary

> - Danilo
> 
> > true because the function is not public and all users in the file
> > satisfy this safety precondition.
> > 
> >   
> >> +        if ret != 0 {
> >> +            return Err(Error::from_errno(ret));
> >> +        }
> >> +
> >> +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> >> +        // valid pointer to `bindings::firmware`.
> >> +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> >> +    }
> >> +
> >> +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> >> +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> >> +        Self::request_internal(name, dev, bindings::request_firmware)
> >> +    }
> >> +
> >> +    /// Send a request for an optional firmware module. See also
> >> +    /// `bindings::firmware_request_nowarn`.
> >> +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> >> +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> >> +    }
> >> +
> >> +    fn as_raw(&self) -> *mut bindings::firmware {
> >> +        self.0.as_ptr()
> >> +    }
> >> +
> >> +    /// Returns the size of the requested firmware in bytes.
> >> +    pub fn size(&self) -> usize {
> >> +        // SAFETY: Safe by the type invariant.
> >> +        unsafe { (*self.as_raw()).size }
> >> +    }
> >> +
> >> +    /// Returns the requested firmware as `&[u8]`.
> >> +    pub fn data(&self) -> &[u8] {
> >> +        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if
> >> +        // successfully requested, that `bindings::firmware::data` has a size of
> >> +        // `bindings::firmware::size` bytes.
> >> +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
> >> +    }
> >> +}
> >> +
> >> +impl Drop for Firmware {
> >> +    fn drop(&mut self) {
> >> +        // SAFETY: Safe by the type invariant.
> >> +        unsafe { bindings::release_firmware(self.as_raw()) };
> >> +    }
> >> +}
> >> +
> >> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
> >> +// any thread.
> >> +unsafe impl Send for Firmware {}
> >> +
> >> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
> >> +// be used from any thread.
> >> +unsafe impl Sync for Firmware {}


