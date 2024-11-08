Return-Path: <linux-kernel+bounces-401131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1529C1645
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A12841A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69A1CBEA7;
	Fri,  8 Nov 2024 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="mJR1h/5v"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E921DDE9;
	Fri,  8 Nov 2024 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731045668; cv=fail; b=gLcwzU5jByergiUdfWqis7MHRjpCL7Z2zN8o8si92UCEBPNbPO3ivdvZO1t7ZkjeE1swvyX/fDOp+ov9u2+Dfar/ZzqPGgLnBC6v6K+F8gr6ogr0dFOH0RQSw2myFLrhsA6YCw3p6TerIXHNytj6p/lkAmfrB+gVw5+C5gpftDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731045668; c=relaxed/simple;
	bh=GYVpfhu2QvbXI+ukQvwGONeg958q2KzaAWZyPHwNT8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IvhqCly+lBuzij3Bg7Rfg6l7To43JLkOJfYvZvKYfTc/R0wT/+vZfQv4jGanj4lXC2EvHXLCroWtg9wtXvEhDX9QGH09FF3av4l425hckDnzP2fTHvuYmvXss1XWLmbYj/Qb98sN1zmeZAuzK9AmPBnadMS0MtyI7qBUmXHmdh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=mJR1h/5v; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR/ySZ1v+yKyT+lyBVmJVRbwF8/+u8wDRawVzTJWjwIgc9yty/j5mtr9GpIvHqMAJx88iooY1D/RqG12I3FnqOlThAQM1Zbf5OqPeO0um+rS5H2jZsbK9HNzUZ2fpS2RVLumizVJbzlRuPrf9xTCjv1LIZIfpuqQlW/h0KPt5SyBcLW/qfqtklWXHcDB4CCNDmR7jWIRdVcOtbaJQCPxtazAz2H8dmG/Fz0PP3kC2lmlZd9ljTwVeDVhP4afQOyZngBA0yX8+Cjdt2RPsFahkpOGP4Jex3qksBuI8FgIhXmynrqYJ9D5bU6GwxrJhbYu94Cx3Mcm3yd0XshWEmokLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QxZBktfbcHT3pMSsb6S4TgNM02mleAFXUBw7bY3hXw=;
 b=yNcJffasqAbo6Ip8W06sTNSVZ2+tDAVe49fRGioML5EFB5c/8iu1wBzy/GJnHpU3ANM3zLgNomb4Gpz+02vRCEBugQq9G6ps8AopN+ffzArssd1R0/LPyfduOmA70VBTJfWHhZVRIrZ9uGjKTA8d7vlXSJWvpmJxTM//i0vhUl0plFA8DiLK+q3Z8v4KaViVJo7sqF3piiJKvulKYS5NxXur6zSwZtDUmLvyIE66Gm6gbsXUStRg4gJN3siRtRKV4H1uuydjXeCMo3IybjBVZTCPJZ8FTBDMvUPhbZqwrKURwgzp5ISzyQA8x6wbK1yDJxx5aYSg6ktwgZn+wAqzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QxZBktfbcHT3pMSsb6S4TgNM02mleAFXUBw7bY3hXw=;
 b=mJR1h/5v3R5VJF4u8pGUvsqVfvgPPvyCRhO7aww3b5VhWesZCpw2JanjqVau2tyiMlVe/3mPjVDfxf4cGJzPbcosz4464Fm3VhWOZtNMHD5n4ZyCmRMPafgi5COvCTEODPSOMlC2V3UafotrkaXagh1gP3Kv5UC3DqyOaUcb92WXK9Qcg/B2939QwTEbtgSF8X5PH6nL4/2cdvkPU6HZ8Nc4KqdWEAMpF1mpEgcV+AaZy4Q5wAulp9ORAXXs36MG074y6DEi/hJOgBt8cEFNBcZUTD4aTyeKTv1k5a5oangn7zuHFTRq7jk76/oxJcWfGRYrNqMwwYHiUQr1L/tdyg==
Received: from DU7P195CA0022.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::16)
 by AS8PR10MB5856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:508::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 06:00:58 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::6b) by DU7P195CA0022.outlook.office365.com
 (2603:10a6:10:54d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 06:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 06:00:58 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 Nov
 2024 07:00:45 +0100
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 07:00:45 +0100
Message-ID: <900683ff-568e-4f63-a8c7-31271bd83988@de.bosch.com>
Date: Fri, 8 Nov 2024 07:00:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] rust: helpers: Remove kunit helper
To: Alistair Francis <alistair23@gmail.com>, <a.hindborg@kernel.org>,
	<boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>,
	<alistair.francis@wdc.com>, <rust-for-linux@vger.kernel.org>,
	<me@kloenk.dev>, <benno.lossin@proton.me>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<ojeda@kernel.org>, <gary@garyguo.net>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
 <20241108031012.335203-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20241108031012.335203-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|AS8PR10MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fb5bef-5a55-4992-5b2c-08dcffbab789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZFZ3hud0dLLy9IbFV5bGw2M2VxMU5Sa283OE5lOHVUcCt4dGZMM2tpNE9p?=
 =?utf-8?B?Rk5WZi94S0pRSlU1QndiMUdLaE1pVzJaaVdsK0ZJRldURzFJSDFlVlpqQUFh?=
 =?utf-8?B?UGFiME9mRG5XNDhXV2hySnRxUzE3TnRhdVVPWDNGb1M4WWlJcG50bVlBTTZx?=
 =?utf-8?B?bGMvTkJ2aXJOZ0ZDZFlpOFE2ZnI3WENQYWNhZi94alN6aWw2TEZaR1BEOWJY?=
 =?utf-8?B?c2F5WE9pMzJ6S1NOZ3U0UURBLytiT0dIaUo2QUVxQVNtK29tbnliUHYyUEto?=
 =?utf-8?B?NFNmMktuNXAxSEE4TmFIVzMweTA4UDA4MkdiUjZZN3Jxc29jQys5Q04zLzBV?=
 =?utf-8?B?cGlYQ3Vlb0FPdXE1OXorZDdzZStwNU5zQU1ZMi9WYjlTWTI5ejZQbjFkaFVN?=
 =?utf-8?B?SHpvRkVzSm15dVhVTGx5TzVydDM2dEdCbVgwRnpJME5iNzZVN0gvQlJ6V2pB?=
 =?utf-8?B?M010ajhiYzMzWUV1Wk9ZTSsrblNPV01ZM0VDdXZCZ2JPZzlLNmt0aWdWS3pk?=
 =?utf-8?B?TDdZQkV3WmVoSGNwbXJtbUdxOVdtZVN0NThGMkphZUNuQXdYTnFUZGVpVG1i?=
 =?utf-8?B?Y29xRTdyckJFak14dFNhdWt4Mm83aHNSMm9HWE1vV3N6dUEvL3VCNHd6Umd5?=
 =?utf-8?B?bjRGZEZMZzNUa21JYlRvSGlVN05xUmxIYUZ6bkI2dmROcFZxbFM2c0tWUzlC?=
 =?utf-8?B?aHE5NjVHZzBpOXhvcittdkp5aWtFUHUraWpUanEwdituNGxSUGU3M0MrUlpR?=
 =?utf-8?B?MVBkM2tTV1dGbWg1cnlCWkRaS0ZFTU92WWVKQkwveXJmeko4UnhBQ1hJV3Rl?=
 =?utf-8?B?UWpqbi8wbWwzeG53NXZ0Q3NVTUVlVEJCSnQxcFBENUxQb0JLWEpvT01GcWRq?=
 =?utf-8?B?eGlmODNjUzJYNndBZU85cUhFM2E5bFcwYjB1KzZOQUp0d3AwZEhYb2pXL1BE?=
 =?utf-8?B?UTFrWVdhTFhsTThXS1lSWmN5OUFhMjlzeVRUc2dQVlRpOXNLNzk2K2lHTEZF?=
 =?utf-8?B?di9nYm4xdHdKc1VwbW9ySUtDY3g1M3RjY2FtVnE3OWtld3VzOVhzM1lPSHk0?=
 =?utf-8?B?ZjdTMEFYZFFhRFhaQS9Fakt2cTZ4V29OSnZ3TlBaZEh3Q2xpWUZrODUyWkth?=
 =?utf-8?B?R3d4cGVLWUpsZC85eFhpOW5WOEdRTEQ1RFZ0eXY2YUdqL016VVZrTXhwK0s5?=
 =?utf-8?B?bFVkcXRzZ3Jia2NQTk4zN1JENnl1UzZGMWxObDlCT1hwY01XYzZRZmhxQjIy?=
 =?utf-8?B?UkFSZDkvYlpTczhYcEpNV1JkVHhWSjJTaGtyNWpNczBxbkpaVm1LQ1BHNTJJ?=
 =?utf-8?B?eEtOc1NmcjZ0VGVqMGIxYXhHTVl6bml0cHlkVmZIamtlaTJLOEVob2FmTEpp?=
 =?utf-8?B?T3NTYm5ORE5YalR3VGpHajBLZkt1WWFrN0NCdTAwZjZmbERZRGE2ZFJQUk42?=
 =?utf-8?B?MitFOFQzWWttYUNIL2x4VE9JSjdweTJtTDQzYnppRit1YkllOGxQdkVmOUQv?=
 =?utf-8?B?MU1iblZVYk8rOVhJZXZNNUlvT3A0cGFkRHovakpYck0xWGxsSW9ZWVRiZlE5?=
 =?utf-8?B?V0owYVoyZ2pFdXdvYVRQK01JOWdmSytZcmlLQWgvbktGeFFGcFlrenZIbWJz?=
 =?utf-8?B?ZGJBbTZVM0V0c2MrNzBQZzNvOUEvUzBhVUszUzVtNTYyWVV2VU5ad1h6cmVj?=
 =?utf-8?B?UGl5ckJtM0ZGdlBiSUJ3cFY1bEVBaE9Qb2JaVVRjYklCVkFjQjE2bUNVTnRw?=
 =?utf-8?B?Qnl3b3ZQeW5JSk1Hb3RFTExVZ1E5WG5reWNiMVlNTDBjd1hrSTFVZjlFeTh0?=
 =?utf-8?B?enk3T3lpYXp1ZTA1b3dBVlBtVHhVTi81U2tDY3d5SHRERGx2WkNQYThiS0dT?=
 =?utf-8?B?SFdoSnFtYUluTFZNdnM5SFBMc1lVVFhSOTVZVml1clRNSlgyMElXdWNya0RH?=
 =?utf-8?Q?emyn45reHnM=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 06:00:58.6906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fb5bef-5a55-4992-5b2c-08dcffbab789
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5856

Hi Alistair,

On 08.11.2024 04:10, Alistair Francis wrote:
> Now that we support wrap-static-fns we no longer need the custom helper.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   rust/bindgen_static_functions | 2 ++
>   rust/helpers/helpers.c        | 1 -
>   rust/helpers/kunit.c          | 8 --------
>   3 files changed, 2 insertions(+), 9 deletions(-)
>   delete mode 100644 rust/helpers/kunit.c
> 
> diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
> index 0269efa83c61..b4032d277e72 100644
> --- a/rust/bindgen_static_functions
> +++ b/rust/bindgen_static_functions
> @@ -9,3 +9,5 @@
>   --allowlist-function ERR_PTR
>   --allowlist-function IS_ERR
>   --allowlist-function PTR_ERR
> +
> +--allowlist-function kunit_get_current_test
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index e089ecdf091f..60b3fdc5c2de 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -10,7 +10,6 @@
>   #include "bug.c"
>   #include "build_assert.c"
>   #include "build_bug.c"
> -#include "kunit.c"
>   #include "mutex.c"
>   #include "page.c"
>   #include "rbtree.c"
> diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
> deleted file mode 100644
> index b85a4d394c11..000000000000
> --- a/rust/helpers/kunit.c
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -#include <kunit/test-bug.h>
> -
> -struct kunit *rust_helper_kunit_get_current_test(void)
> -{
> -	return kunit_get_current_test();
> -}

Could you check this? I don't get kunit_get_current_test() in the 
resulting bindings/bindings_generated_static.rs and 
exports_bindings_static_generated.h. So with CONFIG_KUNIT and 
CONFIG_RUST_KERNEL_DOCTESTS being enabled (not sure if both are required 
;) ) I get dozens of errors due to that missing:

error[E0425]: cannot find function `kunit_get_current_test` in crate 
`$crate::bindings`

Reverting only this 4/11 and keeping all other patches of this series 
makes my kernel build fine, though :)


Btw, do we want/need an update of the documentation?

https://docs.kernel.org/rust/general-information.html#bindings

Thanks

Dirk

P.S.: Many thanks for rebasing against rust-next!


