Return-Path: <linux-kernel+bounces-384227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBCB9B288E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B0FB21B68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1201B1922DC;
	Mon, 28 Oct 2024 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pg+ioHrk"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9D18FDDB;
	Mon, 28 Oct 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099564; cv=fail; b=RRl15uj28sdk2JT7LRNwUL4uJwzagc2F37BveZfsrBXTlO5LBYcqJHDJsymM8BHCLZKTGqAvT7oWZNY5id2yOhjA68U+BtvJjBXcepm3tt9NgIpXKrmidfK42QGGQTG+66UbfGNxLfahTZzN2QhCvusPSCodb+eTjwnVMvJ7SLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099564; c=relaxed/simple;
	bh=GlEPx7HcqMUHvhjUIVKbEQexTkZTgm0/6z6EWH/eFT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bYc+a/IfsJfXxQKkdklCwV3ZUqawypPzO1G8QDSGHvnlx02o+yEn4V8GJxhRHXUMXe56AC7VJ8lj4xCk7bYxySaGmm5AL0z9AKiHvtC1nrJwkXW2d3fnqEoMkZeGCvgek7TqBAZbn92cGBBNmtUq8i0IgKmtNrAf2KCtqq2bQX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=pg+ioHrk; arc=fail smtp.client-ip=40.107.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNebUc+ick9QNh9x+tJdWuSs0bL9DYQX82l7vSccu6sTZOB/RkiZOjePKdSZihIg/awitgGhnPOrW3WHkslj9Q66T6QiZJ5BGuam2AP/cs06VHEPT5PWwOvAXRQS2HXpS60jckYeQ6GJnTah+g9bJlguvYAgb552h96dBf0JT7IgvEF0YbCOerrIj4zc/P5St6ItB2wdT9pA9mPZjzeYcK6ZFtgIz73PqeswJfoUmug8jLy+akjSryniLRpUYI29yucw+OzgFkyGyqRCU235yMxgUHKBHmXbH+hLWNkt/sbhj8PEZVvnZqpfRA1Na9iOqyHUYw6QuJ4DD+PMoXzvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AefoFcU2USlpsgg2CkNjk1Mxxx/cXNmfOE06W0YiWX4=;
 b=uPDnmW5VqCreM4pAV50vyO2auV839RZbXocp+df1EFpqGA09DgcQRETuBJdL6JSU8UUUlxyOypfeoT5b18u0SwqdBzDvYGCf7CiZIgMu5lOq3DS1i/fvYutzibpPo+aoMOWSWHGoBb6a11i9YnpwV0y5jBBhGeCATua7vzTlh2qDfdnBpxSWT/KbGrVZ9aIo9LXDv4OUm34BpDmAsxXtl1kcIXcr4vmf51uU5k6FP5uNGuB1Be+aS2Z6BoTDCt6jET+bJn9mRc6RYgO9ahxoXQqZEkFERfdqz+Gakv4zSYtwz9UvK3lY7iATJLeiq6lyBna38czZ330VYzwuK/gaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AefoFcU2USlpsgg2CkNjk1Mxxx/cXNmfOE06W0YiWX4=;
 b=pg+ioHrkaY7szqnhYzng/3czzXvrAOgBUfVs1Ht3Ljw8m6sOdUaRf8EJmQvMGJ1wlqhfdsXseKmJMwRGTgPOhXc2Lp0Oyy5teVaSJUOS+jlgdxLW2c/xKfu4edRRP3nGODKGdBH/+HpnPcMdj7FSOg0lyGbVivwu4nOjSguJrzdudEf3dhBuPMvdGgJXwOTdtYK0e96bS6ddn4wtc12ruLLyownukT7lSdjJYcPHozfRc1VooaMwqHZF9Ztw1o8HSHe2b4QFqbIfR27PokiSCNXKgOLHbM9EjZfwEkB8IIFgkHtHfy7dEw3GWVg3Dv+HthjHJrPYre79EYySM07aIA==
Received: from AS8PR07CA0043.eurprd07.prod.outlook.com (2603:10a6:20b:459::12)
 by GV2PR10MB6670.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Mon, 28 Oct
 2024 07:12:35 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:459:cafe::69) by AS8PR07CA0043.outlook.office365.com
 (2603:10a6:20b:459::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Mon, 28 Oct 2024 07:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 07:12:35 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 08:12:32 +0100
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 08:12:31 +0100
Message-ID: <7974c521-975c-4df6-bf3c-f5f3e123019e@de.bosch.com>
Date: Mon, 28 Oct 2024 08:12:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: "Rob Herring (Arm)" <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme
	<dirk.behme@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|GV2PR10MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: f33d3626-b548-4e53-395f-08dcf71fe5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2hTNnVtOU5WeUlidVp4SzBtL0V4M2ozOXk2Ny9IQTBJM3VNcmhJMWNlcm9W?=
 =?utf-8?B?NzJtN1hYRUFRTmxrZ2szU2hvVGJHdzFIcG5iRUZVMXNxbDJCdFNnTHJJa0VJ?=
 =?utf-8?B?cm03cTZHVUE1OTd1QjRra3k5bk1tUDhXQmVad1NMMS9KblVlcFIzN2ZIbjB4?=
 =?utf-8?B?SiticFU3a09XeForZThCbzkvRDdzRGdlZEcveGhqR0VNOHZDMGVDOG9WU2dM?=
 =?utf-8?B?WWt1QWptQlpOcUpOYk9mOU5NOHl0eEVtSDBuazlxV1NCaUNjTnVmd295M2hZ?=
 =?utf-8?B?b0cvNGM3NFlsVXR6NEdEcTFqdHBHTFBILzJUODZCSTc5Z0lncmJLYTRrTmV2?=
 =?utf-8?B?ZU9PNytwUllRV2wrV3VnV252Mmloa084MnFhbFNheTZVVzFJVDlGMHQ2bkVN?=
 =?utf-8?B?TlJkd2hxUlRxK3JwUHJZMVI5UjNMN2RGc2hQNy9Zc3JMdGNsV0pGUGlDeC9F?=
 =?utf-8?B?UXJadkE1bE1mVEVocTFObW1ob0xEMHA0Z2FnbW1za0hycFY3UlpvRVRMdzIr?=
 =?utf-8?B?T1RzeWYxL2hUZzZzMXRzMVZ2RnFycjU0QkFtQy9rSUl1U2N6djhGak5PMHd1?=
 =?utf-8?B?cnlyaW5vY1FBZUJzOWhzT3p1ZGVYUHhnYVFEbWpBNnZvcWJha2xEU3FGNitZ?=
 =?utf-8?B?Tnp0ZGRGUXAyTm5Mcm8zM3R2ZzFjUzJiN1I0eEpVYWlnMktFWHl2Q2VlSlhG?=
 =?utf-8?B?bG9PblZrS2RicXA2SzAyZktiMGI0V3BlTWpMVFQ1Yy9qY3NyM29qVFBESVRD?=
 =?utf-8?B?MWhpSjZiTkgxd3lpSnhnNUtyZ05jR0FsbU1sNDRsWE9veU1nMmlacEJWcDNF?=
 =?utf-8?B?Nlc4TDkxclZnd1JSUzdZVjJFczhYQVM5emRlczl5dERVbWNyb2tlOVlKN0tO?=
 =?utf-8?B?ZlBON0ZscEFBR2d3RG1xcGdUSm1wV0Q3eVBueGh6Vi9jME1QQm53QWtLZEli?=
 =?utf-8?B?bmhzZkkxVjJCZVcwZFdXbTUvYnRmZDRkR2NaSkpnZjJLMTN4cStDWm85dU9a?=
 =?utf-8?B?NE05THdDSFlLa0xVZ0FsNnpYaE5aWnRPNUVQbm9tU0ZVdmhLRUJiZ3Rqa1Fh?=
 =?utf-8?B?di9EYVFySEtnNHVxTUd6b1paL3lDalg3cUU0N1dacWtSRHl1WnlaZUZwczZo?=
 =?utf-8?B?RVVRd2ZvMklpYk91bTA2YzlQSHAzcGxjaDhrcy8wbnorOTBrSXJrVXowVWRW?=
 =?utf-8?B?MUxBd2FEb3JIQVlXdDlTQUJvOVRNYjZOZU8wN2ljWjB2RysrclkzanA4SVBC?=
 =?utf-8?B?eTZsclRjNm1nWlJ0enFSeVNJUUlxbGZjMkVueHBkYU9nWjV0aVhLNWNpNEJo?=
 =?utf-8?B?N0ZYSmJyUjl4SS95QlQxM2xOUmhUYW4yZzJ6cUNKb2JoWU5CclFNczkxK1Ry?=
 =?utf-8?B?Rkd5aVBZT1JrTHNFbVRxZGNHODlxVm5VZXFoQnRkalptcUN3UFZLRWR6K2RS?=
 =?utf-8?B?MkpEd2F5a1NLUGRvRUVMaEp5d1VERlNsL2psOFNaZTlvTEh6S2RkcmpHRVBS?=
 =?utf-8?B?NEFLc01aVmdlZU1NeHJaSUJjNGZzTkpBQ3BqOC9FdGdhQ1A1ZnpBRDc4cGF6?=
 =?utf-8?B?Rm0vRE1IYk1oTXBpUUZHc2sxMFJySFRqN05XV1BtNG5FNm1oSk51SGxtZVVi?=
 =?utf-8?B?TFVodjFGcUNFSUpHUEdPVVNXZzU2K0d2WUJ0QmUvMFRKWkR6dmpZL2VWSTBo?=
 =?utf-8?B?VkxwSzBxZkFkcHZzeVJzVjNsS1ZUaC80N1NqOG9DbHEyVnFzcDJIVDVxR1V4?=
 =?utf-8?B?dWE0S2JuZTJic0FoWkY3d2NMY0ljUWM4RzJOZGlyLzN5TmZVRjU0M2pXeUl3?=
 =?utf-8?B?YkpXQmR1ZnpyNm1SeXBPY3R6blRtTWFmWGtjQnZONm5iWUxzTDJ3VkNuU0h3?=
 =?utf-8?B?V3AvWFVqRTJBaFZRME1mcGIrWk5FVldPTnhaeHNseFBxRUJ6TVRLT2dtZ2lq?=
 =?utf-8?Q?++O7LuBT7jU=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:12:35.3439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33d3626-b548-4e53-395f-08dcf71fe5f8
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6670

On 25.10.2024 23:05, Rob Herring (Arm) wrote:
> The device property API is a firmware agnostic API for reading
> properties from firmware (DT/ACPI) devices nodes and swnodes.
> 
> While the C API takes a pointer to a caller allocated variable/buffer,
> the rust API is designed to return a value and can be used in struct
> initialization. Rust generics are also utilized to support different
> sizes of properties (e.g. u8, u16, u32).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>


Building this on rust-next with CLIPPY=1 there are some improvement 
requests:

* Function documentation for property_read_array_vec
* SAFETY comments for all unsafe{} blocks
* Different ret usage for match size_of::<T>()
* Use self instead of &self

See [1] below (without the SAFETY comments).

Best regards

Dirk

> ---
> Not sure if we need the KVec variant, but I kept it as that was my first
> pass attempt. Most callers are filling in some value in a driver data
> struct. Sometimes the number of elements is not known, so the caller
> calls to get the array size, allocs the correct size buffer, and then
> reads the property again to fill in the buffer.
> 
> I have not implemented a wrapper for device_property_read_string(_array)
> because that API is problematic for dynamic DT nodes. The API just
> returns pointer(s) into the raw DT data. We probably need to return a
> copy of the string(s) instead for rust.
> 
> After property accessors, next up is child node accessors/iterators.
> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/kernel/device.rs           | 145 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 217c776615b9..65717cc20a23 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -19,6 +19,7 @@
>   #include <linux/pci.h>
>   #include <linux/phy.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   #include <linux/refcount.h>
>   #include <linux/sched.h>
>   #include <linux/slab.h>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 0c28b1e6b004..bb66a28df890 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -5,10 +5,14 @@
>   //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
>   
>   use crate::{
> +    alloc::KVec,
>       bindings,
> +    error::{to_result, Result},
> +    prelude::*,
> +    str::CStr,
>       types::{ARef, Opaque},
>   };
> -use core::{fmt, ptr};
> +use core::{fmt, mem::size_of, ptr};
>   
>   #[cfg(CONFIG_PRINTK)]
>   use crate::c_str;
> @@ -189,6 +193,145 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
>               )
>           };
>       }
> +
> +    /// Returns if a firmware property `name` is true or false
> +    pub fn property_read_bool(&self, name: &CStr) -> bool {
> +        unsafe { bindings::device_property_present(self.as_raw(), name.as_ptr() as *const i8) }
> +    }
> +
> +    /// Returns if a firmware string property `name` has match for `match_str`
> +    pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
> +        let ret = unsafe {
> +            bindings::device_property_match_string(
> +                self.as_raw(),
> +                name.as_ptr() as *const i8,
> +                match_str.as_ptr() as *const i8,
> +            )
> +        };
> +        to_result(ret)?;
> +        Ok(ret as usize)
> +    }
> +
> +    /// Returns firmware property `name` scalar value
> +    ///
> +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> +    pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
> +        let mut val: [T; 1] = unsafe { core::mem::zeroed() };
> +
> +        Self::_property_read_array(&self, name, &mut val)?;
> +        Ok(val[0])
> +    }
> +
> +    /// Returns firmware property `name` array values
> +    ///
> +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> +    pub fn property_read_array<T, const N: usize>(&self, name: &CStr) -> Result<[T; N]> {
> +        let mut val: [T; N] = unsafe { core::mem::zeroed() };
> +
> +        Self::_property_read_array(self, name, &mut val)?;
> +        Ok(val)
> +    }
> +
> +    fn _property_read_array<T>(&self, name: &CStr, val: &mut [T]) -> Result > +        match size_of::<T>() {
> +            1 => to_result(unsafe {
> +                bindings::device_property_read_u8_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u8,
> +                    val.len(),
> +                )
> +            })?,
> +            2 => to_result(unsafe {
> +                bindings::device_property_read_u16_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u16,
> +                    val.len(),
> +                )
> +            })?,
> +            4 => to_result(unsafe {
> +                bindings::device_property_read_u32_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u32,
> +                    val.len(),
> +                )
> +            })?,
> +            8 => to_result(unsafe {
> +                bindings::device_property_read_u64_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u64,
> +                    val.len(),
> +                )
> +            })?,
> +            _ => return Err(EINVAL),
> +        }
> +        Ok(())
> +    }
> +
> +    pub fn property_read_array_vec<T>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
> +        let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;
> +
> +        // SAFETY: len always matches capacity
> +        unsafe { val.set_len(len) }
> +        Self::_property_read_array::<T>(&self, name, val.as_mut_slice())?;
> +        Ok(val)
> +    }
> +
> +    /// Returns array length for firmware property `name`
> +    ///
> +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> +    pub fn property_count_elem<T>(&self, name: &CStr) -> Result<usize> {
> +        let ret;
> +
> +        match size_of::<T>() {
> +            1 => {
> +                ret = unsafe {
> +                    bindings::device_property_read_u8_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            2 => {
> +                ret = unsafe {
> +                    bindings::device_property_read_u16_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            4 => {
> +                ret = unsafe {
> +                    bindings::device_property_read_u32_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            8 => {
> +                ret = unsafe {
> +                    bindings::device_property_read_u64_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            _ => return Err(EINVAL),
> +        }
> +        to_result(ret)?;
> +        Ok(ret.try_into().unwrap())
> +    }
>   }
>   
>   // SAFETY: Instances of `Device` are always reference-counted.


[1]

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index bb66a28df890..3c461b1602d5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -218,7 +218,7 @@ pub fn property_match_string(&self, name: &CStr, 
match_str: &CStr) -> Result<usi
      pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
          let mut val: [T; 1] = unsafe { core::mem::zeroed() };

-        Self::_property_read_array(&self, name, &mut val)?;
+        Self::_property_read_array(self, name, &mut val)?;
          Ok(val[0])
      }

@@ -271,12 +271,13 @@ fn _property_read_array<T>(&self, name: &CStr, 
val: &mut [T]) -> Result {
          Ok(())
      }

+    /// ToDo
      pub fn property_read_array_vec<T>(&self, name: &CStr, len: usize) 
-> Result<KVec<T>> {
          let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;

          // SAFETY: len always matches capacity
          unsafe { val.set_len(len) }
-        Self::_property_read_array::<T>(&self, name, val.as_mut_slice())?;
+        Self::_property_read_array::<T>(self, name, val.as_mut_slice())?;
          Ok(val)
      }

@@ -284,11 +285,10 @@ pub fn property_read_array_vec<T>(&self, name: 
&CStr, len: usize) -> Result<KVec
      ///
      /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
      pub fn property_count_elem<T>(&self, name: &CStr) -> Result<usize> {
-        let ret;

-        match size_of::<T>() {
+        let ret = match size_of::<T>() {
              1 => {
-                ret = unsafe {
+                unsafe {
                      bindings::device_property_read_u8_array(
                          self.as_raw(),
                          name.as_ptr() as *const i8,
@@ -298,7 +298,7 @@ pub fn property_count_elem<T>(&self, name: &CStr) -> 
Result<usize> {
                  }
              }
              2 => {
-                ret = unsafe {
+                unsafe {
                      bindings::device_property_read_u16_array(
                          self.as_raw(),
                          name.as_ptr() as *const i8,
@@ -308,7 +308,7 @@ pub fn property_count_elem<T>(&self, name: &CStr) -> 
Result<usize> {
                  }
              }
              4 => {
-                ret = unsafe {
+                unsafe {
                      bindings::device_property_read_u32_array(
                          self.as_raw(),
                          name.as_ptr() as *const i8,
@@ -318,7 +318,7 @@ pub fn property_count_elem<T>(&self, name: &CStr) -> 
Result<usize> {
                  }
              }
              8 => {
-                ret = unsafe {
+                unsafe {
                      bindings::device_property_read_u64_array(
                          self.as_raw(),
                          name.as_ptr() as *const i8,
@@ -328,7 +328,7 @@ pub fn property_count_elem<T>(&self, name: &CStr) -> 
Result<usize> {
                  }
              }
              _ => return Err(EINVAL),
-        }
+        };
          to_result(ret)?;
          Ok(ret.try_into().unwrap())
      }


