Return-Path: <linux-kernel+bounces-340009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0B986D43
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9012817A6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF318B49A;
	Thu, 26 Sep 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Ly1xJT3s"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DD0176227;
	Thu, 26 Sep 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334521; cv=fail; b=tAOsXtyP4oAp9XTxtagDY0wSRriJPD0wFrerb6bPe0JNFZCji72LuOkHzCUOragEp+IVrHU4HctQ40F2EBWQCsNaZwyhrq+zY0sXfR87+ZPtOEVKlXIEl9MaDmId46tz3oaU++hhb78FVKUEOaFf4TGQae79k+7fkgLg1H80owk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334521; c=relaxed/simple;
	bh=LxTA/L3cIwNGlsIXlV5Q0eL+pIoZC/OioqgoqKG51AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LX0I0GTMsLk9Dlqy0gmq/5q4rC0mgX4D7nLlLC7s8NMDIxvYnFwk8BC7WeDErVLsDm+o3xxDBiGFKQ3/1n+cRCvwk3qeGU0YmaY3SYkWjnn2dnLhzzvwxJAy6+9f7vLoSnpT/aEYvK2YZkJskCK6kLQnfaefAOMfw1IHwHk+h0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Ly1xJT3s; arc=fail smtp.client-ip=40.107.104.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmTWdJBkdvuKqiNm4n3nCVRnfYpSxHAONKsZ61SYJa155AQ8FXQ7hYUn8dghs5vMcN//OaJaxi+Kqg6AlYQVpuTWr8NUhbmJiMDvOKnPGrXB8Zn9HJnwKffm5/lxBxZTFt/yif+sQ4C0GFsmjNPF0QxhLmncvocKkfXPqUEjYMmnz3fYQee41208UlBJSjmRonIfUKTm9uIkMxa/t3+1ZTFgcv0XiDqOxJVp8HlNDD3FjphWSv2ix24zZySxiOXAEBak6Wid4taJT2p928uqpCH7qGaOmiDs9qp1fpJJwqwfgXvjX4qSoOMPh9XmZcDHfhlBihgcWXxiSM9Z76N6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5vNBn7NSAs56OR+JNSCN6vg7SUCzOCGmfr2PC7yV1I=;
 b=YFoQ6Jto94bCxCgcGtL5DyZhCWUZog+bYm/ylDAFLnmKYR807LgHj1G/mfT6fsOFU98r3jFLxY8xYYe+uk7GpEPG6kvZ+BRASprtqeI5f3LSP1IRSwx9DC6BMbMK1bTc3H8/SK1WeqHvNSXLcA160jg42UhT4TBmjToFgCZ0f0/XkCaVdyds1U6hxDyk/gnXVRb9cdQ8dAOsy6gVaA9i7zKY4EoXvposKe8QXkl/JnXRLpeB2Qi5LqJddu6YkJV48oPWAU0LRhCE9HGepR+pYexoq0QJ4jbgpMe4p7YQD/zMLIO5Ir/D3xcU2YYneXnspBqbAEA4quljk/lDFqy9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=proton.me smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5vNBn7NSAs56OR+JNSCN6vg7SUCzOCGmfr2PC7yV1I=;
 b=Ly1xJT3s/B5UNQNSHMposFetsIuo5S6xBHsTwWyatXpxhdQK19olNCyRvo/HYKQi17uT4fCjzpURcUeUwlbq233jOz+Dm7jCC4MDUTGFM/CxlFMIO2nLeSTWwbQUG8havkdVFBTqoRrGqwltMQuI6+hGwJtnnMLlrljiwcGssRVB+v85R6HnBU7pYXb7RIY9xkT0c8p/b1c+BVmscnBo96svVPO1xZQEhUQsNZKhkpD1mw0/MBeW2VJk8D9oSxfjMcongVdlmetg5NxY2LKgB3vyC4I3OLyKZtZSzWn5tL6vLrpJ8vh7/spn3ylkVTXNLMbixt1jQVBkW71wZlTUew==
Received: from AS9PR04CA0165.eurprd04.prod.outlook.com (2603:10a6:20b:530::25)
 by AS4PR10MB5270.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 07:08:29 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:530:cafe::9d) by AS9PR04CA0165.outlook.office365.com
 (2603:10a6:20b:530::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Thu, 26 Sep 2024 07:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 26 Sep 2024 07:08:29 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 09:08:17 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 09:08:17 +0200
Message-ID: <d4520031-2f3e-43a1-9e95-e7845ef8cb94@de.bosch.com>
Date: Thu, 26 Sep 2024 09:08:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
CC: Greg KH <gregkh@linuxfoundation.org>, Simona Vetter
	<simona.vetter@ffwll.ch>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20240925205244.873020-1-benno.lossin@proton.me>
 <20240925205244.873020-2-benno.lossin@proton.me>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240925205244.873020-2-benno.lossin@proton.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|AS4PR10MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: d34ecb59-9c78-4a27-e656-08dcddfa0607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MllWNE05cUU1MC93NCsvR01hMG0vVEJHZFp6SHUrcUtib0IvL0tyZGd4amk5?=
 =?utf-8?B?Z3BOMkVWZVkyLzdPUHNkZVZNc3dNb2p2aW5lWXBtWTF5UU9QbnV5Y3djZmtq?=
 =?utf-8?B?MHJsVnVzWW0vd0g4ZFh5SFJqeUd0U0x0ZGxaaE1nczI2NEprRW1oSEZWT2pG?=
 =?utf-8?B?UVp0UTVDREprSXozSTB4NG9BR0R5Mko1UUZWVmFaQXpRSkRzYVdQQjJzbm1I?=
 =?utf-8?B?ZXdqeElHTHc3eVVTZkF2OG1wWDh4ZzJyVkt0Ujg1WXlQc1JyUEZ2Um80WjZh?=
 =?utf-8?B?bnBaUHJoR2xYSUtVWmlvZDRYanFxR1pXZ3FXK0I1aGlvUjdQbmE0N1psc2NH?=
 =?utf-8?B?MjZ6ODc3ajUzM09IZnM2aHZnQzNKYXAzTnNoRGpUYWh3cEhGRHV6NzdKWko3?=
 =?utf-8?B?WGpsVSswZHhBdkFIZTcvUEtnS0tUeVFBSll0L3c4VCswNjVXTXVKVFpnc1hR?=
 =?utf-8?B?TWMrN2xKYk5YdVJJTGpxVnFKNEpBc1lWcTQwL3JQVnVBK2JVUzQrWlZvSGFK?=
 =?utf-8?B?dFh3RTQxRGoxZXQwRTJkWG5kS294Q1VJeEg2UVY1dE9XOFcyMEdLRkU0KzlL?=
 =?utf-8?B?V3BnUmxsckJVTDg2Z2RWa1hXeVFEQ3hBeE1VcjVacXJCSXU2ZGdDazVtM2ww?=
 =?utf-8?B?aVVQOC8rRVZhbjNxaVk1bHJLdlhLejNnT2xDRFN5RjE3MTZXMU5RbzZodnhl?=
 =?utf-8?B?ano0YUhVcHJDM2Y2akJkS2JFZmpVUWg1eFQ2OXZVVWw5MjN1ZVpWUVQxS3VB?=
 =?utf-8?B?ZCtMV3JnNEpXVGNoa2hpYnNpUzFJQTZNRG4wampUdEl5cjM5cTlWRC9qNWZM?=
 =?utf-8?B?OFMveTNiVDRucUg2YU83YThXTExwOFkyc3FwRCtsMk5oUG1NS3htNHVWZlIx?=
 =?utf-8?B?cE1kOTkxZ0VhNk1kNjhNMHVHQjQ2WkF0TWEvMTFwcElrR3N5ajJEM21tMHZs?=
 =?utf-8?B?MFo0aWl6eWNoZE5wOXpsZlNibTNWOE9TcTByNmRnN1JyQWxRUzFWM3c4dkNk?=
 =?utf-8?B?eENwa1A0YUVlT1ZxR1FDYXZjK21ad3RyWlcyV1BkMXhYQ3JtSi85UzczT2ll?=
 =?utf-8?B?cmhxZGROb0IzWC9Kd0RBdHUvLzFJYjlFVC9JVnRsc3dyNkxuNUFib2dZc25Q?=
 =?utf-8?B?UnVVZHlELy9WdkxKRllTUE5qYnBqOE5IZFNrVHFNdmxSNC9QbVZjUHhJTWNS?=
 =?utf-8?B?Qm5BTDFnVlRjTmU0dHhPN2dNWkFyQ0dVVVBSWUpweW9BZ25zUzhraVpBbGYy?=
 =?utf-8?B?dXExcTcyZlhpN1Njd2ZVOHNoS2l1b0NNNkkrQkUxSzJNVUxXT1pFS0lSY0tk?=
 =?utf-8?B?bEx6STFOK1c0MXRzbHZ1clEwVnE0UEx3eE15RHI5cEFkcjVMbXVTNm4xQklL?=
 =?utf-8?B?NVU5N2RaTS8vWVp5K2JCeHFoK3ROS0J4Rkhwd2FiUjQzNExTTmYxelhwbHds?=
 =?utf-8?B?RFdXbUNoYW1JZTQwY2E4OWgrT2dtNFVkbTlEbzY2dmxmZkU4ODZ6ODEyYTBT?=
 =?utf-8?B?R05DM0VpdUdOZmFlRythTkJqWnVXZDQyclN6WHNmRXVOc3NVU1d2SjVJQTZu?=
 =?utf-8?B?cGVvLzJzQWJvV2ZRaHdid2NqaFlSZ0UvVGVlMEdFTEVWUzFDQzdzRmp2Zjls?=
 =?utf-8?B?d1dyWnNrTmhvUFZCc1JnOElhMjhaNCticXRwcU9ZbzZQWGlpZmxxQnFMSWhs?=
 =?utf-8?B?RVZVSEpBN0ZhRW5pS0YwbW8yQUMrK1crVFdOZ0JZS2V6eWNiOThIMUlsWjl3?=
 =?utf-8?B?em1qUEZiSmJnVEpQTkd3OElSSHViVEFGSi9JaUVCREE3cXlabWI3ajJLQmI2?=
 =?utf-8?Q?aRCTu8m1Yy6ISrAECheB73yOLT+s53nYrDQQU=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 07:08:29.1886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34ecb59-9c78-4a27-e656-08dcddfa0607
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5270

Hi Benno,

just some quick findings:


On 25.09.2024 22:53, Benno Lossin wrote:
....
> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 000000000000..b325349e7dc3
> --- /dev/null
> +++ b/rust/kernel/validate.rs
> @@ -0,0 +1,604 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for handling and validating untrusted data.
> +//!
> +//! # Overview
> +//!
> +//! Untrusted data is marked using the [`Untrusted<T>`] type. See [Rationale](#rationale) for the
> +//! reasons to mark untrusted data throught the kernel.


Typo? throught -> through (i.e. drop the trailing 't')?


...
 > //! [`Untrusted<T>`]. This type only allows validating the data or 
passing it along, since copying
 > //! data from one userspace buffer into another is allowed for 
untrusted data.

I wonder if we should drop the "userspace"? I mean untrusted data must 
not be in a user space buffer, only? It could come e.g. from hardware as 
well. Like in the read_bytes_from_network() example.

...
> +    /// Marks the value behind the reference as untrusted.
> +    ///
> +    /// # Examples
> +    ///
> +    /// In this imaginary example there exists the `foo_hardware` struct on the C side, as well as
> +    /// a `foo_hardware_read` function that reads some data directly from the hardware.
> +    /// ```
> +    /// use kernel::{error, types::Opaque, validate::Untrusted};
> +    /// use core::ptr;
> +    ///
> +    /// # #[allow(non_camel_case_types)]
> +    /// # mod bindings {
> +    /// #     pub(crate) struct foo_hardware;
> +    /// #     pub(crate) unsafe fn foo_hardware_read(_foo: *mut foo_hardware, _len: &mut usize) -> *mut u8 {
> +    /// #         todo!()
> +    /// #     }
> +    /// # }
> +    /// struct Foo(Opaque<bindings::foo_hardware>);
> +    ///
> +    /// impl Foo {
> +    ///     fn read(&mut self, mut len: usize) -> Result<&Untrusted<[u8]>> {
> +    ///         // SAFETY: just an FFI call without preconditions.
> +    ///         let data: *mut u8 = unsafe { bindings::foo_hardware_read(self.0.get(), &mut len) };
> +    ///         let data = error::from_err_ptr(data)?;


With my heavily patched 6.11-rc1 base for this I get:

error[E0603]: function `from_err_ptr` is private
     --> rust/doctests_kernel_generated.rs:6749:27
      |
6749 |         let data = error::from_err_ptr(data)?;
      |                           ^^^^^^^^^^^^ private function
      |
note: the function `from_err_ptr` is defined here
     --> rust/kernel/error.rs:271:1
      |
271  | pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
      | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


And the same for the &mut Untrusted example.


> +    /// Sets the underlying untrusted value.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::validate::Untrusted;
> +    ///
> +    /// let mut untrusted = Untrusted::new(42);
> +    /// untrusted.write(24);
> +    /// ```
> +    pub fn write(&mut self, value: impl Init<T>) {
> +        let ptr: *mut T = &mut self.0 .0;
> +        // SAFETY: `ptr` came from a mutable reference and the value is overwritten before it is
> +        // read.
> +        unsafe { ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` came from a mutable reference and the initializer cannot error.
> +        match unsafe { value.__init(ptr) } {
> +            Ok(()) => {}

For this I get

    --> rust/kernel/validate.rs:188:15
     |
188 |         match unsafe { value.__init(ptr) } {
     |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ pattern `Err(_)` not 
covered
     |
note: `core::result::Result<(), Infallible>` defined here
    --> 
.rustup/toolchains/1.80.0-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/result.rs:527:1
     |
527 | pub enum Result<T, E> {
     | ^^^^^^^^^^^^^^^^^^^^^
...
536 |     Err(#[stable(feature = "rust1", since = "1.0.0")] E),
     |     --- not covered


Just fyi in case its not due to my local patching ;)


Best regards

Dirk

