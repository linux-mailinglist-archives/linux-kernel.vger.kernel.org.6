Return-Path: <linux-kernel+bounces-329496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C530C97920F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB01F22635
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680891D094F;
	Sat, 14 Sep 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oYAa0zgW"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2117.outbound.protection.outlook.com [40.107.122.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4F155A30;
	Sat, 14 Sep 2024 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330724; cv=fail; b=stvm/RBzB9rRDM38kBqcNRZO9T+uY+1AnVNjn2Etil1VJYUDWV8hjmI03EnTmh0v+/LTQBCYwlLeVD3S7mPXOtQxdIPygzZPfLeEmMjbxA1NHvWjefpxyUxOInA6ecBRZ29G+wMR6ez2X8pPK6u+nWgVEE9IV65QtxXN3Mt+7rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330724; c=relaxed/simple;
	bh=fXWNmqkhTwrMBBg0fyLIFg0i4wKlA5C2xyFkkNEyEAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SCVVSPzRnSiKtYtUDumR8rNFpobgZztzN17INZwv9l4v9N9ZphOw+g8IMsuc7nL8bIUiEDK7PRs7m7yAfzJ3H/zGK8uciGqbbo+lvL0f7QmT819WCXKZgyOMMWIEE9ZfnReaZhQjvnXzm//Gw+OIvWEiWh58tKlY/IaM3ENAgcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oYAa0zgW; arc=fail smtp.client-ip=40.107.122.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzPnFuWgLow+JRVEYmqJXPqSOZ/gdP2WsbYwMUyrvfbg45kxnZWFEB0CTxYglPiKnSaOl2T15sM4wXydPZo/SPjS4hj80gS/feJ7sYEC18T6s7LL3N1UXY+oG0qVDpR6SPWZd6neH8wUNzEsSmbmEfsIuXM9Qg95+L06DeNlC7Zh3lYhTMalMpQBV+H/szH5Btoc3zMY0/GhUmGieOF47wvBb20JxcKyT2QaGxLEAGITYpbeXwHPLfiaAEVVnL9lk0rgRTys4/RCDplq+OuWHqegUWHDCBp3KoBSn+UxxzGXZnmXRJBwawpV7EhJsm5mmDbGqWQ5lhA6/3uiOyP+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVOGl/CHUO/pFrLW5B2/9TTi3EZ0ECfAzWAEtPrItw0=;
 b=Ula2wU0MZkfcP08jhzfa/FepJ2Rg4676UEfNyB2odLTiQu1Lm7Yj8QXTjgHqXaPMge/FmbFqOWhgWVbFPYzVYSY48HjXY4mlOkLmF1cQ/XPslp/LVcjiz2SHl/XN8/73XwwlvCJ+UdLm4SlycBO1UxtQtdtAAVGDNTq7AQnPFNakGJgPwB2btuAzX5rgRBTN35t23oC2WuF07W4KoKuj+dMf9d597XtgyMV4A2U7KRerm73nnYqcDmq9UbKoqasCKkRrcDrRLVWVDoQCg40Psu4oEmFUBFznkC26jKr/Wu7Tc5zug2Z005EvzilGSgdx/cshaPYqZ0QS7AqZ3PycIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVOGl/CHUO/pFrLW5B2/9TTi3EZ0ECfAzWAEtPrItw0=;
 b=oYAa0zgWygujx7o4+w069k3ncWV5ZiGXPZApd7pW0ZgOsqU3GfIvH/Ngx1ey/WSoclrrBwc0r7OWZwkgmzdhrK9GjGlSiybVkeFXYpPil0BXpABPK2ZRB6deCd+NZUddgOWbkCROaEsId3d+v0SEcOVzjOwEY3qghSoGSdz9wRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6671.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:306::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Sat, 14 Sep
 2024 16:18:38 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 16:18:38 +0000
Date: Sat, 14 Sep 2024 17:18:36 +0100
From: Gary Guo <gary@garyguo.net>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH v5 0/3] rust: Add irq abstraction, SpinLockIrq
Message-ID: <20240914171836.6afbbe78.gary@garyguo.net>
In-Reply-To: <20240912190540.53221-1-lyude@redhat.com>
References: <20240912190540.53221-1-lyude@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: a571b2f8-1a8b-47b8-c71b-08dcd4d8e434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7aZif9Or8VCSIoAlbeEg+fjzAxCFqYbdeaDj31laZwa1WyqTYnlLSm9CqGO?=
 =?us-ascii?Q?iwVf+ecbg2S9kNV9e68Xi5GngkkwHWTY1FEPO5UZ8NCh+A+gOVM2Mp1qRyCI?=
 =?us-ascii?Q?n5uHQyFLwNckCliGM6R22BHO3ZO38qtWUs5Y8Cnc3pqwbsG8RkQcBL2Q8yDA?=
 =?us-ascii?Q?4XITnZgTtFkAZWp4BF6WMR0jeAtnclMTXeKE+BNb+2rJNmeicc05vTiUExGl?=
 =?us-ascii?Q?JrLDjLkhYGvlkAKd6x98mXMBLRPfGu3ypCafmuJQRF67ajxFEjQpHwg7VFo/?=
 =?us-ascii?Q?DVpIFM6Mnrj1GvVtUdku6KGTA416VF05SKlR47H6r5C0eBiI1a0uvYUqz7yR?=
 =?us-ascii?Q?9mYPyP4EAYDjClhGfILz9PqmJRw8U6BAyjSGG4B994DrJuHQkGHhMj1PgeNc?=
 =?us-ascii?Q?nHNlZio+RKq1snRDK0RNvwxzkvAZJRaN5jhF1GSgU2QxeP+sAcOUuvRDIOTA?=
 =?us-ascii?Q?6iLQAg375BPVCsEShchPAe2islce0fFsUtfuuYMYG1ZBnXBHa0FPRuVzrOTL?=
 =?us-ascii?Q?3H1vQ0uzYLGibwef4ZbF9QGRyF4H13fC8fvtksBMhx7X+sDQhXF8dusVuvEg?=
 =?us-ascii?Q?zE67Bb1IEnO7x9VNQQCKcEeakeXte/EguP8ho6zhB6p9TLkgpv8m36mt3dOW?=
 =?us-ascii?Q?zP1xyViBe9gkut0qKUxIEyJgRn7lmhxMxGM3YfKQGXwuQgCEixxE0cSU1IBl?=
 =?us-ascii?Q?zy10EU9mE458n8A+N7lfklEZPSynr3ve4/YZxtEWRJldUHLlyMIAFa6wx7oQ?=
 =?us-ascii?Q?dfmzqbfeh5t8a/oDul50RYvH04aGoqPTYp+6fOJjs86mBecCH2FhdcX7yImj?=
 =?us-ascii?Q?QGOq/tHB20WpjMzR3Uleoo4UqjPZnXlKJ47woFcyMIafCj6absT2kwURx7Pk?=
 =?us-ascii?Q?OacGFMpRcY7AEIdn+kPfVwTdwAof9Qs5xk8dakkuZtmJgEu8UaSnbBGYVXMW?=
 =?us-ascii?Q?R/cJWRiUMC1bx4PaO7BJYL2xlItdMk4wICxouvwIS7q/rkIUsp4yEXuA/x5D?=
 =?us-ascii?Q?dvHgGC3nALOyrpPqCTIoFfaUk0ypoeuyXssy8FxtPTydcpwACdlENmXKEAC0?=
 =?us-ascii?Q?RGO2D7toAiXj24dSjJgQyMHgOCX2fM8Y7DJ3ZTcvYF0wN1G89Pc9q5XcA9jG?=
 =?us-ascii?Q?GViNJdWP5jpRBixRaZ1ZD3KaPkj82GaLOBgyDra8F2kmNYYXUaJohBKkGpq4?=
 =?us-ascii?Q?wKCSetZr/n0VQxfPu+kRBOsIKEpPcZ2EGO3qURnFCzjkKa8ijeKIobxlj+On?=
 =?us-ascii?Q?TETCSIePF73ukaTF3donrMrngpwl+GfohCLLZwim4HfhVJNBi2VNQsfrtk06?=
 =?us-ascii?Q?d6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/9omQtIVUoN6NaK+qY5PIYoKoBMe2Rugb78cfDSu/EFnfqDpREKzrmJIoos?=
 =?us-ascii?Q?qs6afdSQI4YYQ2wgC6dgj64SSevjTAJTDwATxbG9BGLpaEDrfX/9QdqYn20t?=
 =?us-ascii?Q?STMjtn7XH6AXzJE2V1/vuHlF66xdub21TbFjZqNveYBw4Zo2h8MXI9HCsq5N?=
 =?us-ascii?Q?NWbTE2WihMGtvmvEGyZvGw4fxQ5lpPLxqx/FeFuWi4iyPbVjO1B4BrI6i4KE?=
 =?us-ascii?Q?jGgOsZH0Orde32Xd3eTuT1tRDVSIIlIZCfDcoo+3foyuJgkh3ErG6ekVdN+w?=
 =?us-ascii?Q?+qZ5FBuR7EhhbHe5UFU1GsCdGBHy30JqSCSkcms0m81cJnJHolPxknU+D/au?=
 =?us-ascii?Q?B8K0doCBPbHgpINMU5wQDnZ5tzb4npYzj1VxNPCUiAa33fsA4pY5P1YebGFz?=
 =?us-ascii?Q?j3qSGug14nqVidU3GyH0AfJBauPK8FJWbtr8kax84d/iluqEadwTPbyIGvOi?=
 =?us-ascii?Q?YuWf/EimnIPE+6KGb/ylgcUTNRX1y6wCFi8KgrlrM0wHfu8cx9TYqMR/qx73?=
 =?us-ascii?Q?K8QAvzwaxHv7ZhgyUnYLOZTT5JQ4Nqlvw1amPRTJj8qgcCNzaVQo4s+K5SFD?=
 =?us-ascii?Q?+IFU5mVeeiS6C/bLoKSLF4EE71JRDutRvc7fGZG5CjbOkshlkMHAhzr6MrtV?=
 =?us-ascii?Q?Nm49VqgWS5MV067tqQ9guzzXAXAraNix1H3z3yWjPAgkb2QLE+b7Am7ZITfK?=
 =?us-ascii?Q?DvLNtHXKxkHmGd+TvGRKfB1XGKFTUDQr02Zo9M1YW23fUkyQg1s9OH6yB4Q6?=
 =?us-ascii?Q?C/aCV+qRIUofq+CS2KMtHXw6yHL8X6tdGlHyieOnDvJIfe8hiXnpb7wV1eNY?=
 =?us-ascii?Q?dxMMjCkkgJHx97YJKjO85CPBYoOTefHZcPdSTKmNipBUN6zLyF8dFQHX6FjJ?=
 =?us-ascii?Q?d2QrX6m/+YlsojdIb/rNqRa3YxZc8JFakhRqxDOadSm+2lR7kcWtibCUStTF?=
 =?us-ascii?Q?nhwxQp4+xNnQs3fjfTv/WGJp+NkajtWpWCNbnJC0D/uSwk4Tn6uytIfLuqFI?=
 =?us-ascii?Q?gb2kc1p4I0f/LGcSobjWyhe+K48AGk2iFKjCSTD/yBDPUMufjZMzdo5MWl1b?=
 =?us-ascii?Q?TkY8Z6PynnFnhtaeFmx4amUtx8DMcUsMC6CtHKXuCA7pIVsQPsXit5T31Toi?=
 =?us-ascii?Q?4D08XRPMNiwDs8rFs6Fc7OkMTSFJ4WfC4mktPzkkvFkySdWSYWAbU9NyCKM8?=
 =?us-ascii?Q?tqcl+mMbIZKh106ij8XHJSkHvYaw7FXaddYLmxlBcdZJCzEMnuynSFCGbMjt?=
 =?us-ascii?Q?W+lKXLken+beZz2Pnr8rs2kKI/UfHkwwdV18mGGAksjl8rNF1kiNPydln8bL?=
 =?us-ascii?Q?kXiew/waPwGXgUVWmOWThO0f37XFkk17dsOLUtkK9Io08iKLBL5PREfO9nEb?=
 =?us-ascii?Q?6sRXVabEmRkRHcPR6VslO2ZcnIlzS92MIhCr4E33seCS1zV7l7MCnxBicauG?=
 =?us-ascii?Q?uCJ1E0Fliq7+FKkSoE87Ti+b/8W/GFz5VM4J9f7MfcY4Q9In7/V+DNow2hiG?=
 =?us-ascii?Q?JSpUe0B4+1naH6eJ1fyVnXsXF1yo+JmCfQIpj88DjlraLXFGp9cMjFtz/olB?=
 =?us-ascii?Q?uYYjbZdwcuV+e2CXWRFDNVCtjIjKIZSMCLq5+2ZiDHszX3ysYEJGBNcSmM2X?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a571b2f8-1a8b-47b8-c71b-08dcd4d8e434
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 16:18:38.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGlFIhdzBq6aAiHGHcV/BKyqi3FScYfLhEbERH4SXFwWCmdl6GuB/6aArsi9P5nKgwt9CVk9kkjeVupva/rC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6671

On Thu, 12 Sep 2024 15:04:15 -0400
Lyude Paul <lyude@redhat.com> wrote:

> This adds a simple interface for disabling and enabling CPUs, along with
> the ability to mark a function as expecting interrupts be disabled -
> along with adding bindings for spin_lock_irqsave/spin_lock_irqrestore().
> 
> Current example usecase (very much WIP driver) in rvkms:
> 
> https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-example-08012024
> 
> specifically drivers/gpu/drm/rvkms/crtc.rs
> 
> Lyude Paul (3):
>   rust: Introduce irq module
>   rust: sync: Introduce lock::Backend::Context
>   rust: sync: Add SpinLockIrq
> 
>  rust/helpers/helpers.c            |   1 +
>  rust/helpers/irq.c                |  22 +++++++
>  rust/kernel/irq.rs                |  90 +++++++++++++++++++++++++
>  rust/kernel/lib.rs                |   1 +
>  rust/kernel/sync.rs               |   2 +-
>  rust/kernel/sync/lock.rs          |  17 ++++-
>  rust/kernel/sync/lock/mutex.rs    |   1 +
>  rust/kernel/sync/lock/spinlock.rs | 105 ++++++++++++++++++++++++++++++
>  8 files changed, 236 insertions(+), 3 deletions(-)
>  create mode 100644 rust/helpers/irq.c
>  create mode 100644 rust/kernel/irq.rs
> 
> 
> base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2

With the invariant documentation of `IrqDisabled` fixed:

Reviewed-by: Gary Guo <gary@garyguo.net>

