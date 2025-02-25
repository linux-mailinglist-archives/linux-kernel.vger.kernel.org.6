Return-Path: <linux-kernel+bounces-531825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C817FA4457A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F743AB951
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D412166F3D;
	Tue, 25 Feb 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QBc+e/be"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020130.outbound.protection.outlook.com [52.101.196.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3A166F29;
	Tue, 25 Feb 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499570; cv=fail; b=tKhHbVVs5oZjGS4I3FWNuk1l9+qlzYXULpaJW/JOEzzp9nMTUIc8a/HQiLxeLT6kKxV4IDO8P/D4CxCi4wClS7SqCMTHjQ/FhCjwxLFS/6vHD/IfgP42f2QulpsP+C9Qn+VE/ShOpivBq2Cx7wl/7fzqo7nMpQgzkvzOTB2W/x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499570; c=relaxed/simple;
	bh=ZheD1QkQKnvLLlV3nEDh0UyYO0sM3dX/Ds1bvYq9IhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZJSrcWELlzoU/RJItBBH09LbrId+M+NH8cGmY9v5c5SZ/cTCCSRh4EmHyswvzBvlHGrFQhGQKO4fMMbYby2uCu2zVO1hH8DjQH0xw+IS80Ab5hIMg+a75TNuyaaNWTjCG5CWr8/+mmOWEdefFOxZ02+T0yp0d87qQb7JnlyfN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QBc+e/be; arc=fail smtp.client-ip=52.101.196.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dvl7atxqdigQhrqEOC3NRmJdWefRmqAqt4bkTI73DwP7WpXAISImyNYMeNLXxUeL56gx5zds3zejemiPmq+5TzJKUo2ZICpbsuLO90XW2CstQ5c3hp+LRamxBQaNiRUSQuAYExJ0bfstViospoePX6ab+l20lNM0QaMnL+9CVCkP4WFcZ9zmCBpATCJ11PnNXMI2QGMX5ycMX9TkhW6X+oLkMVnNAZD1iL3zJOIMjT0jJ6wRcu9UezalCWe8mw+sKSA97+R32Po964Cv7WVq9yGUd8PY/eL2l0k4Ig7DyTpmzVMRyqRqiwekVga/dqqENMh0CnMP+E5IMlZj9OgqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ15bdkn9OT9BtsiRR/dvA00dtoT+7R+2tKYdZXKUi0=;
 b=qtDtYPpmRjP3VL9ayf2Kr0UNlpXhHT2RqKni++8NN2SONa8QXJAUhbiJQaX9XGjZFiLatVcjlsVyEaGURYiLeBmD7tRNryxabFLy52AYpreMwDR/br8X6VN1MQcYZSIEXcZZ4F+/BkjinxHYozNi1eZeeLzNPjI0G/LuUeyzaeVv4rK8e/fu+akrr9HTr2Owb8D3oY02p+qH1FMmjr750TBOMZl07e2m+BxfsWvKU5IgpKyh+TML8ZVmBN5V3rGgzbBV92oagrrD11xWHgjEvVwDHcAgfqmAIBlcszmQdJQCz31y6djW8NeXKDJNvl8LIvgMPUTsMEZvKlCJ4RiHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ15bdkn9OT9BtsiRR/dvA00dtoT+7R+2tKYdZXKUi0=;
 b=QBc+e/beJj+GiS3KDDs5i4JuW/u3ch2xGtVE//mOkgvbfhRMAsuskcIDwj8vPE0wBUp9/DkQp/6MENbDM+J7mvdtfbB8YB9yHewuCYUvSrZ+Yn/0NHjHSNwUkrt4b14RXgW9DgcDZ8k1bNHbyRoWl+kOLgOky0FrQPQcyHYFprU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3203.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:8d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.17; Tue, 25 Feb
 2025 16:06:06 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 16:06:06 +0000
Date: Tue, 25 Feb 2025 16:06:03 +0000
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
Subject: Re: [PATCH v14 3/8] mm: rust: add vm_insert_page
Message-ID: <20250225160603.4d4a2893@eugeo>
In-Reply-To: <20250213-vma-v14-3-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-3-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0299.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4d256f-ae82-47ee-d494-08dd55b64f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Uqn4N7HH6SvJ4TnymYbHeTcHR912BUUQQxdzys3zlRQiAM3/cb0jYp6p0UT?=
 =?us-ascii?Q?bxzeTxydxu6BCi/7LYkLtzeDoXsubX+iQesnGFmH7z01fWt/bREYxph5PW5u?=
 =?us-ascii?Q?W5f2s9ZeFUOWZ3gS3J9Wl3qJZdqh4xDezDSFQBZgPMf9NjT3spdDfkVNYFjd?=
 =?us-ascii?Q?R9HMmg249b3++hTkDs6D6HUnqWHJc6pEESl5VDCuZMR67siBIBnhCXy0/30J?=
 =?us-ascii?Q?Dwk/Im8R46rAmJgIEaxzwBAtCPFurK/IFwT1Z78OluZKMEVOQDqPklHvft6Z?=
 =?us-ascii?Q?0d/mPf5n0/aU59RL/CLphOTSUkW53KlImDY+PLm2yHe0r29fQnACfuLimCAa?=
 =?us-ascii?Q?nMUuULclH6oH/2pjhm0C0X/QK7rIJoMd1ddxXOTm9uIU6YXLOE5/H9xHgrTy?=
 =?us-ascii?Q?6k25XHsBZr02CbIQ0T0dKyL3qvLp/j+oNjQCVd1g8SpLdwCpnsAi7Qk7ACdP?=
 =?us-ascii?Q?AAuWHqn+f1XISQ1AV+r2MfKEoi2F/2yRZF7sl9iigBZ7ho4N1n7PuDjwsy7x?=
 =?us-ascii?Q?JiF7ERbso0rjP6Dx3sjv80YDa/T5tQF6Jsolg2+BFOprphgv/cYiFdLpCCB1?=
 =?us-ascii?Q?W3MfAdx3y3eUoUCmfh4fvE68VjANeV3m/wU2AYF20QFAAcYv5jS9OWijLZkt?=
 =?us-ascii?Q?4sXrN1us6oN8wwivV/pw0OQvwnTAH4dn/RCi24YJM6blkRxE1aOvXNyu7KHO?=
 =?us-ascii?Q?tLsRwH5cwcniaKyh8KF5aB5ELD6+npak2D2i3+bkipKs2OxT2uQKrB4lm9Wv?=
 =?us-ascii?Q?CQte88srv4eEZ3WFxeruhLKJVIfHmByhYg4ceaTh29skAe7Dz8Zfd996lgKZ?=
 =?us-ascii?Q?Pc5tbAGLhW0Yks+JfeAk/Z1VGs+ekYCqbYP2uXU1DpLOupSSOBj1moZUqF1y?=
 =?us-ascii?Q?8JJy3HkqEuA9Lqm5SVWVr0mOua3z6xOoTazTC4f1zFi3LMFg4dQvP231TxVF?=
 =?us-ascii?Q?7MHcgJKrz7nDoTWTiPnctSiOXLEEvDzzw9Jq7SBmE2e1pbQtM1PtZc4poFXq?=
 =?us-ascii?Q?tWx8FAj3R1lN2yeZglcwaI4faORB7eZuTDzS/tl1HB795CdZV2r3D57g2G9x?=
 =?us-ascii?Q?l9MQao0TaHg7HJFuNh6ZB9X5TCQy3XDzIjHdcFGrfaPxnRezSe90UfWCXDzH?=
 =?us-ascii?Q?glETU5xirHZ2Fd0+Po+Z/8ldJdtfpeWM9vhk7sKcywiKe8u87tUsVNoKvydb?=
 =?us-ascii?Q?o2Qhbdds0RIU+yuxlaJYS9U5sS1jNyZnEUoNHGPOFwJ0Jkyl5473mGsvrD/s?=
 =?us-ascii?Q?zOOf9EkQBaaTSphWyOlZoPX/8L/8sZFH/kZ4x2GNn3tKeA8/d0lfuBDfKJBy?=
 =?us-ascii?Q?mHrHoyrwvSxcQdrud1TnokeAOu80OA9zcDWGV60kPz4dhDfT7qli1x4BQie/?=
 =?us-ascii?Q?eR9vGxGLxuPKuMMjp4Zc3ccSz4OE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6HSe6rrlF2FawEnIU0Go/c9PeO8mQW/Tt2Q5LvqoZYwvmaUJzu3ecbNp0qbS?=
 =?us-ascii?Q?K3OGNWaxpb/BfHSLB54oIENYPNcMYcWa04nLrzul3SASBIMKdNY+iYUdDOgS?=
 =?us-ascii?Q?2yB1VetkBMBpYlZpj1hzxd2YXFCxdOTzNvif0UedpGmhNSBmSuDmINS8f+/S?=
 =?us-ascii?Q?2DjKGhzZ0O49l+dk7tAV1E/q8Xp4RBGsWOHSJsg2QYEnwCkEAGGWV6KpcCHQ?=
 =?us-ascii?Q?rNPqeR7e3UxRHJzwnjyuT9vHcthX/oUyrCC3QFYPBzJpf39PkIY6yCU/MlA3?=
 =?us-ascii?Q?Og/cYDr0/PEFoIyiTfc2R5tcSL8HsQkoyEkQ41Y8M+zXz1iwJXkfXm5mXrcA?=
 =?us-ascii?Q?hRSIgFY4z9DoPI8UUvI06rp2xnKE1K2hzvJYRAo0mW7Sdg7NxWi2aJ11EPLc?=
 =?us-ascii?Q?8rmVJ4UfyaSIFhTdaeTc/BPBmMmTYXZtN8cMQJbZVsjmBA1Oe1N3hpJ8XJvZ?=
 =?us-ascii?Q?F7wV5qCHi/dk1Pz6rkuBsSg50GtdjqNF8WV2Z7+1NYTKifc6js21YhmYR3HN?=
 =?us-ascii?Q?K7UGlquiMAXqp0CBuRc3i+JzVRW1BLgD20Zz84tWHX23AU1qS6h6ENHmlqA+?=
 =?us-ascii?Q?8WBWPmr0CnSnnIYuW86goJlieT9hvNmvVp2mQrtr0Cc0Ak+ly3CHKJ3jKNR4?=
 =?us-ascii?Q?iuRFIovndR0Ki5v4F8Pmbn0fNAnckGu742rnaModjBsqoyizAsDhk5SgpNOK?=
 =?us-ascii?Q?50z/xkjjp2E8ImjWipiX8QgOLV6xc44EpGkbytpz+KQpH1vWkjIe53igazJw?=
 =?us-ascii?Q?7fK5Mc11fyeN09vz5eV2e/3CSNne5mOK6lEky1tmdXWpd8MHAikZW+pLPguB?=
 =?us-ascii?Q?Ut578oFcAEZKq5aXLFULG3P8kvB/IFEjaRf2/BIWA/lW2sgWbgFChbPR5Cu2?=
 =?us-ascii?Q?Fky1zmGhIC8IqCsR/mqi059J2/YJx+KuvVoccSh07BRCPZV2vQaY8FChdtNZ?=
 =?us-ascii?Q?Nl0SjLMzCCeBaxre5+JLaEhH4H1MsAX6Xxm8/5sNWGsPBLH/P1qc1cHjz2O8?=
 =?us-ascii?Q?j7awtfPvmGlo1TDU7WNWBK41vg7WuV3ekFEoIK18/EfAkWIz0boMPLXvCpb0?=
 =?us-ascii?Q?BjNeR4nz6oYsVDR41pxSx88fetjjzqKK6goD15oyYX5dkUYrKPU0A83jnuDC?=
 =?us-ascii?Q?+TLrZU7Jy8zmcdwTXg8kQmDo2VzKb/MYt3vLZ27YAI5EGi6hm6Kxx7qEA87z?=
 =?us-ascii?Q?bpIkGiv8kObLKekuJaWMSsDRhxfwNNZjKaApnPEjM0VHCezbKPJzVeAw2AHy?=
 =?us-ascii?Q?5kUq1xn6d8viRqZZi7qLPK8QPEKp3Vl0leZGJa8is/Cs8nuujW5wkixNnPTD?=
 =?us-ascii?Q?pDOqsg3Y8Rj3mm4noevzL6KJC+g3hQX+fh81MH7Vr5tUvhY+ObOgvt4vbhEa?=
 =?us-ascii?Q?LaR3PZS0uL/mUdA0VNTEKx2NcKWoMdaNOzjurF9EvA0bBGMno9M3lPxl4Ax5?=
 =?us-ascii?Q?+v7OCuGWxna2RrCjIIPMy+8TyYRXyGN+ejixOgUby4QIDEZLcO6HF12SZYEg?=
 =?us-ascii?Q?QMl0jKAo45fzNAIpn91X/FjATNqSkqvYnfYoGmHwzEgLKkH0aW7fiALFeqIS?=
 =?us-ascii?Q?MORzU+66SbYib+zLOBrpBYdwojzjUb95fud5NDEXE1gi0x8OSuKYDW4bFS5j?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4d256f-ae82-47ee-d494-08dd55b64f54
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:06:06.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV2+3ZsqI+Me/609aHmT73CVi+yaG7g+yHDY0eqiKMGsodH+7jQRZ8YPbApfOq5aZt1gMkcWVnEuixdN6gFs1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3203

On Thu, 13 Feb 2025 11:04:02 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
> flag, so we introduce a new type to keep track of such vmas.
> 
> The approach used in this patch assumes that we will not need to encode
> many flag combinations in the type. I don't think we need to encode more
> than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
> becomes necessary, using generic parameters in a single type would scale
> better as the number of flags increases.
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

LGTM, so:

Reviewed-by: Gary Guo <gary@garyguo.net>

BTW, any reason that this specialised type is called
`VmaMixedMap` but the base type is called `VmaRef` rather than just
`Vma`?

Best,
Gary

> ---
>  rust/kernel/mm/virt.rs | 79 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index a66be649f0b8..3e2eabcc2145 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -14,7 +14,15 @@
>  //! ensures that you can't, for example, accidentally call a function that requires holding the
>  //! write lock when you only hold the read lock.
>  
> -use crate::{bindings, mm::MmWithUser, types::Opaque};
> +use crate::{
> +    bindings,
> +    error::{to_result, Result},
> +    mm::MmWithUser,
> +    page::Page,
> +    types::Opaque,
> +};
> +
> +use core::ops::Deref;
>  
>  /// A wrapper for the kernel's `struct vm_area_struct` with read access.
>  ///
> @@ -119,6 +127,75 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>              bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
>          };
>      }
> +
> +    /// If the [`VM_MIXEDMAP`] flag is set, returns a [`VmaMixedMap`] to this VMA, otherwise
> +    /// returns `None`.
> +    ///
> +    /// This can be used to access methods that require [`VM_MIXEDMAP`] to be set.
> +    ///
> +    /// [`VM_MIXEDMAP`]: flags::MIXEDMAP
> +    #[inline]
> +    pub fn as_mixedmap_vma(&self) -> Option<&VmaMixedMap> {
> +        if self.flags() & flags::MIXEDMAP != 0 {
> +            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
> +            // satisfied by the type invariants of `VmaRef`.
> +            Some(unsafe { VmaMixedMap::from_raw(self.as_ptr()) })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` with read access and [`VM_MIXEDMAP`] set.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// This struct is identical to [`VmaRef`] except that it must only be used when the
> +/// [`VM_MIXEDMAP`] flag is set on the vma.
> +///
> +/// # Invariants
> +///
> +/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
> +/// set.
> +///
> +/// [`VM_MIXEDMAP`]: flags::MIXEDMAP
> +#[repr(transparent)]
> +pub struct VmaMixedMap {
> +    vma: VmaRef,
> +}
> +
> +// Make all `VmaRef` methods available on `VmaMixedMap`.
> +impl Deref for VmaMixedMap {
> +    type Target = VmaRef;
> +
> +    #[inline]
> +    fn deref(&self) -> &VmaRef {
> +        &self.vma
> +    }
> +}
> +
> +impl VmaMixedMap {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> +    /// (or stronger) is held for at least the duration of 'a. The `VM_MIXEDMAP` flag must be set.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Maps a single page at the given address within the virtual memory area.
> +    ///
> +    /// This operation does not take ownership of the page.
> +    #[inline]
> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
> +        // SAFETY: By the type invariant of `Self` caller has read access and has verified that
> +        // `VM_MIXEDMAP` is set. By invariant on `Page` the page has order 0.
> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address, page.as_ptr()) })
> +    }
>  }
>  
>  /// The integer type used for vma flags.
> 


