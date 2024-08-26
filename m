Return-Path: <linux-kernel+bounces-301366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87395EF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD551F22537
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20549153BED;
	Mon, 26 Aug 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="qj5eAGlF"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF30B66C;
	Mon, 26 Aug 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671311; cv=fail; b=Cyq1esTfNZEjtB9aMfYNN5hPT7BMU3daKi9zLd06vhaMEvFVPIgcoOiMU3IE3Wg9jLCfUwAIe/5ohW13sztNiPdBzJTXZffF/SQ8ec0/sEmiMLHBN2d6+hi2LcTss3Mk/duQf9RbP+ngSMNRQPgmQ9DwINsHCLkKp1pmhzAPc3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671311; c=relaxed/simple;
	bh=51TzkSMAdPh2NjdSlLuULIINb258sgrB8hfoHD6Olec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uqWgb/HMyjS8Aj4pPydDozEXS0kh2sRQOckyCIoY7dnWXBBY9bfWij+4gICfwoWWZdxYsskCazIGmW2RmWlM+FIWpABp76khGpDOs4xG3t9KetTzwaAcOMnEvxfkP0bX9HOemXck5KnVndDrRMvhv7Od9GlfsMzRP+sO8HWGQrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=qj5eAGlF; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0SiHT4WZGk5RhsXAzEPYzUC1tml0TlbKS9f37UlknMAcUqOx+b0QNo+j8NdyBchQbzeACaYbuIF8/2UHAxIjf99gnR22tkxV1T9jFn1ADGhYIyM4zly+o0jFphlceflLj+WydlZ4U2MoogaL4IXzscCwYppp44Y21LCh/9pRU9jokG6NNq+LpWeW14W4pnRWVMK2bddSBKD62ngenXUeWkmYR8Tufj/BGAt9penNFhwmFgLuCF1iCRWf2LO+or4TqNYsV0SgQER97ZJlpLhVEW5ZtdDpKG+3Xk+N0wqpI5DXVCrlnUdEuS4/oGJ7Nr4EoXsRRnSJ1xD8y1YgxJ9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUKbfVaIDVjaTqZVyGdPR+XTHRvDx66Vi1YMmmP48S8=;
 b=qxkr1QTfvlvnRqsnzTF7RQ8Gvgmfa65h/NCDL3CbDt9nOjcykGKVbqmNHew0jp5P255GyQeJBB38XYcxzEeJqh27K9aTXmYjWQjhzk3VUXt1Sicb9go1ptpfKXkW7ZCVO38Iqx+FLM2GNmhFNdx/QJb3NtDmJHgve/qff1SijBB4wzIY6+Icd2y/v0K5PPlIU5XJLxqtjSDOqgjb2dISnwRGDL50aiIUlod9k4yTvQ+HhBb0B0xva234RxWV9v6tZUbAjWDMTGoqlPo7W9RypL7N1+7NeaLdetuCjk5o/nGooYEXQzv2ZNQgj9bNdwMIZ2PnZhGjpU4koMiPXK8N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUKbfVaIDVjaTqZVyGdPR+XTHRvDx66Vi1YMmmP48S8=;
 b=qj5eAGlFrV0Wrm7cd7ih2Cl6qfy2pXfKNXiEvwHLjzVX/XBE/5et752BDbSFijJarTAW4PfWQIFtfy6d7mcMT++WuxtsDFg4w+VKM5Afme5VbrxG7oTvHefcLDiZbfBQugaei87llqp1UaMOcpl3mmHeLS+fazRCXZoZWil3qiHMFTBJAJqBr0nlFFdGvqxerysFYr4+pqHuf/kjEhjiTzT8y9zEyq31pDeRLaWNTtf+xlFGyqB+gsU5m8iQzsFwND1qgBMcYHM+eCcRmv5syeKp8R8lnY/MIy4ydp4Xzd2L5+OBxvLdogYh/TEA7h+2+uljpvdT+WzmAOBgUltzrQ==
Received: from AS9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::7) by PAWPR10MB7248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2e8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.31; Mon, 26 Aug
 2024 11:21:42 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::35) by AS9PR01CA0028.outlook.office365.com
 (2603:10a6:20b:542::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 11:21:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 11:21:42 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 13:21:23 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 13:21:22 +0200
Message-ID: <3f6a5c86-8dc4-4a62-8308-5ca25f9e4aec@de.bosch.com>
Date: Mon, 26 Aug 2024 13:21:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
To: Lyude Paul <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Danilo Krummrich <dakr@redhat.com>, <airlied@redhat.com>, Ingo Molnar
	<mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho
	<wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
	"FUJITA Tomonori" <fujita.tomonori@gmail.com>, Aakash Sen Sharma
	<aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240802001452.464985-2-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|PAWPR10MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: b2de3d18-fba4-49f4-7de1-08dcc5c14336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnduN3ozVFZncjZwd1ZSYkE2dHBjeDg1d3BBU0wrbjRWbUhWblcvcktqd1Fq?=
 =?utf-8?B?MUhhclF3amZPMk8zYmk0RHVnVVNzK2toS1JNc0VDQ2R1Z1RYTGFWbEdaUWhk?=
 =?utf-8?B?R1pEb2Z4SFEwTTUwKzBYdFNoK2hjLzZvMEF1bERiSEVzaGw4QnU3ZGNPcEV4?=
 =?utf-8?B?OUpRS0IzZ0NjOW4yZENIUEd0bHVzT1dWMTZ0MkVCZEJFZ0ZUU1Izd2g4NUhG?=
 =?utf-8?B?S3JFeUJmVGtkYXZnTEEvRjlqem1HWXhjV2tPbUxxVXNPdmdRaXdpSytsb3VZ?=
 =?utf-8?B?aTJUYitkNzRTYnh4K0w3ODZrcG5VK3pLV2hmNXlpUm9Xam9LM1BKSVE3QU91?=
 =?utf-8?B?SGwyNEQ4UHgxaGZwRHd6NDN3dnJNMXIvcm9NbjBEMTNZWGpaK3lCWXRmcjhQ?=
 =?utf-8?B?Q2drR2hyajJ0QzJiUmYzUTRQVnJYUVF2RXpPVjhTM1VJMlBxU25uTzl0WFBj?=
 =?utf-8?B?a1Nub2R6QUZrQm1DUGJ2VVdCZVdkbjRqY2p6NCs1NytGbGRpeDlsV1A0aFRv?=
 =?utf-8?B?VC9pNUgxMkd6OU1UNSttQUpuRHRFbnhRVjVyMmphaTZzREJKVk1HM3hlOGdW?=
 =?utf-8?B?S3A5b0VGWjlOaFg1TmQrVlQ2WHRGazhEN2x6cTRNRWUzcmNiQkpjMVdINmJw?=
 =?utf-8?B?c2FBVzB0eHE3TWREVzFrQXV0TlFRZ1VnRnNYK2U3dHF5U3duS3M2TmdDVklH?=
 =?utf-8?B?T09TclhiamZTSDZOQU9QZjN1dnV2VE5PQnFmK2cveGF6WVhXS1RlYUpCWkU2?=
 =?utf-8?B?VGcvZi8rSExPbGRlOXlNam52RGlNYksxemZmZkoza3VFWHlzK0R6bHE5MmNN?=
 =?utf-8?B?TGNXcGVvSnlpYWRsSktuTktmQng2ZCthVWRGU1EwNVo2SVVmdGs4dmVkVXpC?=
 =?utf-8?B?SytQd2E2eXBEM0huUTgvRGlZa3VOZTduWC9UWEVFM1Vma2htdzhSRWVsbG1z?=
 =?utf-8?B?M2dYV2NCZEZLZTdRNzRKaDhCVzk5ZHFSamFCQVIzajVkZ2xhdFZrTWR0ZTdk?=
 =?utf-8?B?Ly8yckJRQWdPUFFhUVVUcHpSMWFkOTJYWkRWVEJtVWRSdWthSEd0ZEVramNE?=
 =?utf-8?B?SUFSZWZMQ0tqT1lnb203WnZzUlNrWDVOUHd6dXpYWXdhVE5wWitKY0Rkb3Fl?=
 =?utf-8?B?QU5naEovenZRMzQrNE0xS3c5K1grK2ZCdXN4UTU4OXAvYTBTbGw1eVVObDJK?=
 =?utf-8?B?WHFReWE0SXRRVTZidUwzdjZxWjhGeE1FNVZBSXpvZzRBREZhU3Z5OVRUZ1cr?=
 =?utf-8?B?MitKbml1NUZDVFpHazZtdFhma0VpdXlDYnpyait6YzFUUWZUOWFwbWZhSEFO?=
 =?utf-8?B?K3ZOVmFxUUhPWDRJZ01yV21ZOUpEbnNXbDMwOEFlMUZtSWdoN1NZSmhDOTg0?=
 =?utf-8?B?U2hqMDMvYis1UC9pZXRCZDVzbVd0ZkNvMXVpb0dSYmdZNmFrVm9OYVd1UG8r?=
 =?utf-8?B?UE9sWm02QXBVd3BpSkc4TVhyMFJxMHVQQitzN0hTL3VOVkxaVUNYNmZMa2NO?=
 =?utf-8?B?ZmVFMjRqRXduN3V0L3N2V2xjQmhJMlRlU2tnaW1vcUd0L1cvRmU4am05b1Uy?=
 =?utf-8?B?M1VJdGxIQkpQYkFENjRPdW5Zd0haSTRLRUloZzQ0bnpkaUR2Um5TZjZpYjdy?=
 =?utf-8?B?anU1QTNORFJVYUlpVkp4TUNxSUxhYTNKYnZwUVExbmtvWGlsOXZ3WXI2K3ow?=
 =?utf-8?B?WEtId1I2T2RxZFZXQXlZRmFDN0dyWTdKTUpEL2VQNmxzODNMd093QklCbnVT?=
 =?utf-8?B?YlpqQThFTEYyODhQaGY3ejdYQ2ZoNjJUay9CRFNrclZiNElPLzhlRlpwN3Vs?=
 =?utf-8?B?MHQramM2K2tMbm5VWGpPZ2pRejRzeUJTM2VEelpYc3NXcTc3ZUdVdU13ODZm?=
 =?utf-8?B?ckJrQm1SVGRrY29TWVJQeW9XMFk2RXFYWmsxalRTdkZLMXRzczdSWHB0MWc2?=
 =?utf-8?Q?N7H7d61RpY3muYef7WQNRXWEW8cDBK0p?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:21:42.5991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2de3d18-fba4-49f4-7de1-08dcc5c14336
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7248

Hi Lyude,

On 02.08.2024 02:10, Lyude Paul wrote:
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
...
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..b52f8073e5cd0
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
> +//! that requires interrupts to be disabled.
> +
> +use bindings;
> +use core::marker::*;
> +
> +/// A token that is only available in contexts where IRQs are disabled.
> +///
> +/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
> +/// an [`IrqDisabled`] in order to indicate that they may only be run in IRQ-free contexts.
> +///
> +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
> +/// interrupts are disabled where required.
> +///
> +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
> +/// further information.
> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
> +
> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] without disabling interrupts.
> +    ///
> +    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +    /// without interrupts. If debug assertions are enabled, this function will assert that
> +    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
> +    /// upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is already known that interrupts have
> +    /// been disabled for the current CPU, as the user is making a promise that they will remain
> +    /// disabled at least until this [`IrqDisabled`] is dropped.
> +    pub unsafe fn new() -> Self {
> +        // SAFETY: FFI call with no special requirements
> +        debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +        Self(PhantomData)
> +    }
> +}

I have some (understanding) questions for this IrqDisabled::new():

1. It looks to me that both examples, below in this file irq.rs nor the 
with_irqs_disabled() example in spinlock.rs in the 3rd patch seem to use 
IrqDisabled::new()? At least some debug pr_info() added here doesn't 
print anything.

What's the intended use case of IrqDisabled::new()? Do we have any example?

I 'simulated' an interrupt handler where we know the interrupts are 
disabled:

let flags = unsafe { bindings::local_irq_save() }; // Simulate IRQ 
disable of an interrupt handler
let mut g = foo.lock_with(unsafe {IrqDisabled::new() });
g.val = 42;
unsafe { bindings::local_irq_restore(flags) }; // Simulate IRQ re-enable 
of an interrupt handler

Is this the intended use case?


2. If the example above is what is intended here, is it intended that 
this has to be called unsafe{}?

foo.lock_with(unsafe {IrqDisabled::new() });


3. I somehow feel slightly uncomfortable with the debug_assert!().

I understood that this is intended to be not in production code and only 
enabled with RUST_DEBUG_ASSERTIONS for performance reasons? But I have 
some doubts how many people have RUST_DEBUG_ASSERTIONS enabled? And 
disable it for the production build?

Wouldn't it be better to be on the safe side and have this check, 
always? Wouldn't a permanent if statement checking this be safer for all 
cases? Compare e.g. BUG_ON() or WARN_ONCE() or similar in the kernel's C 
code?

Or could we invent anything more clever?


> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +/// without interrupts.
> +///
> +/// # Examples
> +///
> +/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
> +/// disabled:
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> +///     /* When this token is available, IRQs are known to be disabled. Actions that rely on this
> +///      * can be safely performed
> +///      */
> +/// }
> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure completes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```

Best regards

Dirk

