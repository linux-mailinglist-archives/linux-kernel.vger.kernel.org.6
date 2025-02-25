Return-Path: <linux-kernel+bounces-531865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE44A4460E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29BC3B7015
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903318DB3B;
	Tue, 25 Feb 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OjvPi0PD"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021074.outbound.protection.outlook.com [52.101.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCA4315F;
	Tue, 25 Feb 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500647; cv=fail; b=eH3VJ/fZqZE/svJG+yqIqjUccSYZrkv0ki6LJGX2n6XPnOn9JYUNZQauPxAW1xvqO9VDKRRjLdZwx/D4aAskGO1pIZ/HaItNrk8LbOlvraR/vIjbD2r81fBh7aG4thqzSRscEdYPsG2B9unw41PkQTo9jmfmdvQ5Si7wIQYzVMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500647; c=relaxed/simple;
	bh=bJUqXDDXQiQ9ePndLORDU93OlPuX4Opxl2uwhKJpGRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ptkIaCF9/NdChGpXP5DbKwxaRW4wk0JALKFnq6e6JholVP5RjJz562/alQgtVsstycw9RhdGEyFSMDlkUAiOLMg+dggSTJdj9kYCdcSF0SjVXzNpV25n+GLB79tO0LesG2s1LKjI7f3Kt2heSui6d2zSH8LKTHewL4hh/8gID8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OjvPi0PD; arc=fail smtp.client-ip=52.101.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urcEfoi9nJFhABvSkUqUG8fC+xE8p2a/Zq5EdTT2tzrhjzA0aQ9RXKQPuZzLb/9PXYZleS9kQOS5Rt1HVtYIJnJP/VwKyWXcwzazkbtBxwP0nv2vVScM3alk+lKbiF7ISSstlpfZnAXp3E8KAnUDfWrlMiSGMDBfeR6q1oTecyyygDxNRvk8MVlerhnJJzdYlm5XqFS3H/a74iWb1+jK2BnheFrzZV726yO7oI4JlukX+kRM2X/Arou/W9Wq/S8dK66ZyxsXfW3fTCXhZXO3j//6synD3IYvEbUm14+h7FRQY9rNdX5lESaVhWYmDriIL8i0ABcdDP6PgkqxRiEQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MavDc1RQuPDqfrR1gbDKVjRpCVMW8rd1kMI8Xqj60B0=;
 b=L1bMfWTGqz1f8NIsG2jQbIKsazLTw6/EmBM7WUcKkBrOMBnjvPRG3CSkAGU1kGVaWlT8muOE2hfoFo6CCCTxo0xFW7ks9Up1tQ92VaJMenBhVGvJd0H6b6nIk0jXvy7xV0eIsQJyoHHq7l6EMAbnyDNZ5X/gmO4iONpx+wJEpy4aa9ylxxbOGK1wkUsgZZs9ZvyJQYgwNCiGW+aCeQWS7b29CqVMTaWFJWSskT6EWKbq41biZpYGq3/Kpp/Qq9iGUgqmloPmoqu2b2BvcxX0VmET0Nn45A0i3S87BuZ4kf17zTH6Vp0uOaP/3tElQFbJ5Km7kolt4K3u4zQK7H93Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MavDc1RQuPDqfrR1gbDKVjRpCVMW8rd1kMI8Xqj60B0=;
 b=OjvPi0PD5lJRSOsKVILdk/vpRt1Ke4FWMz4bRrT5B3DBgGHy4/EUZ/vXjvodhLYc0JNuS6KFUdehZ0IarVbvmCjRV3QiQCCUULeQeu6zG8c9W0kSs+nQO8ygz1b4+GnnpcyMtHbWytjsH/UZRsktJcTnpxH9WnyjAVX6YXldNrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB7226.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.16; Tue, 25 Feb
 2025 16:24:03 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 16:24:03 +0000
Date: Tue, 25 Feb 2025 16:24:00 +0000
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
Subject: Re: [PATCH v14 6/8] mm: rust: add VmaNew for f_ops->mmap()
Message-ID: <20250225162400.37187f22@eugeo>
In-Reply-To: <20250213-vma-v14-6-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-6-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0515.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d57d160-ab88-4a19-1cce-08dd55b8d117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0Mc/QAKJ1gn13w3vKDJ496Od38f5rH3sQpD6L8LfCHijfYvhWUvDdHGPXCl?=
 =?us-ascii?Q?SyjpKEBT+HYdsaos/5Dlys4zTAJELJc05TTAHAfqZyU80Mec4nNiLWBa66Jx?=
 =?us-ascii?Q?E3cFV2tSTFLV0E2bEVmrdIfRRdCJY8+DxB0fLntS1ORVTIjVF9oSszHQgGnT?=
 =?us-ascii?Q?YCdir6uKPXUqEWykHO/mn3qA9BvODtQvCjyp5+K8MIsXj3yrrEuk1uOAF1tw?=
 =?us-ascii?Q?FkCBi51pg7X8TdpUVvEWLtd7UB6mDI3pqZ66ijuJeBg9NXIquVPIps2EzBm9?=
 =?us-ascii?Q?WwanKXwXIFYZvoySZZXJHiNWMKv+JiQH+P0a6Hq17KDptCFJUOG/yJKgDwQc?=
 =?us-ascii?Q?JWDfmE5FLIDmk4WnSf6nr3ds+7mwWilN1sFba7oXSjsUQbMyHiEMD6J77nwU?=
 =?us-ascii?Q?95U8y9KDv40H60ny9afTWJqRBlUP2L9O4EH57DZ4JvxQP3WO90dnwsXgJSMM?=
 =?us-ascii?Q?1e5t+c/RyY4O0sEUcVWwm42AmhvdhemF7ufHM4pK/9PxQ7diaZZolqdKrp2p?=
 =?us-ascii?Q?ZXsw9Znmylk4YTzMRn4T4Ze3d0CWdyLLafdvH5TRRI4pEkV6hF7BtQu+V4LF?=
 =?us-ascii?Q?nqftlqGJSK+lqfhjhLDBH+7vaIz1YHNufSjfMlK3Hedb05JYwfkFFYki30On?=
 =?us-ascii?Q?+tCTSEccklUKSwwVUqAby8ISFTOKQZ+S5yb7RrmjrB4QFNNDYCKDlKiqteH0?=
 =?us-ascii?Q?nB/a2F342ZZbEwuoSK5iI+Lq42zTHHfhKphOx1J122K+sMx+xC1mxgNxTBd2?=
 =?us-ascii?Q?Gu9tW3vj62ImOLps39K1i7CIp8ocWtawrPWu9GIiHTFqqrWZzUwsl/Zpgv2C?=
 =?us-ascii?Q?4x7WjYl8t1Kql5B66cy/4+0hMKkqf/KZr/1kiFIZJOfw5nBgilZyGLwvEg1m?=
 =?us-ascii?Q?XiAjkYGO1D68WAyQ3irmik6sE3Gq4bTrdRWYg7DX86eHJ+mxovvFq11rZxd5?=
 =?us-ascii?Q?YavfKIyfpM9IA7mySqwlewJNd2Lp39raWZx2mLGDb8zeRO/WT4tBq3Vruwzi?=
 =?us-ascii?Q?ZQseg4txd1jWy2AFGOYB1Iup9ob3u2mQhmVa8E3U4yKRIFL5cCxRQ6om7QI+?=
 =?us-ascii?Q?FMDi3bRFGLoC9tyBYQd/hgqmIIdQ6u4ah4T8oA3v7/+H9nAgeS5p64vsyfiW?=
 =?us-ascii?Q?BpmETQZ3noNnfwdkAl1iVvij72gt2RLFwfMbOBeifmBywTeWk6fttKpR3vHU?=
 =?us-ascii?Q?mV4qSFg3AI74j/qClxTW21ZIglXZcVu3LJMC7myjtGzmBhdnxGtbD1gE+SUw?=
 =?us-ascii?Q?t+QVGzs/f6ENiwg/PmL67Geht43A80tIvr6NbKzviKww6DiMFQpQSihWOA4e?=
 =?us-ascii?Q?RPvCDS9rnP2MKVGWzsb950IsNvhPnRF0e9OFtfVDNwYZkJIspD8upM9bmTdZ?=
 =?us-ascii?Q?1m2qHTWzpL24nV9ihm4FWR9a4Wik?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?otEop6rrt3vi37r+Dv06GmCUYaLZQV8jrtsvQLKEu24PKfOw01K+BVrkCk3x?=
 =?us-ascii?Q?wtv3LEylw+hpWWuRZgIeoDDIynJnuAZ/3469JBW7LGA6smCpKl7bI8lMkB6A?=
 =?us-ascii?Q?TSyR6ayx/zBmtJtYXTR5aIR4Xxc41ldg0+We8oPY+mMBsT0oBiNJiDwSlOOl?=
 =?us-ascii?Q?HWn8awapfnNFpRvUPtKH+tKz5rNNyfJzhZ9TAufZWzrOnkaZANNli0vsH9gH?=
 =?us-ascii?Q?A6GIHFlL6Z/kdU0Wo31zZJrMZUKA2llDHazzGWLjOXDAXB1ZNVkML7K051iw?=
 =?us-ascii?Q?0PnyvBPwvROTjuCZ6C0tIoEVoSHi+uECP40kfqrh+pZL7bvCmgXqb/hyvq/5?=
 =?us-ascii?Q?9gwttKaI80gC/KcPP+AgfbBdtZDHJIV+39pjB4IN6KBjcLtvS08bwOCex4Ic?=
 =?us-ascii?Q?RLx7Uhw4XoPje0OW0yU15/akLdnZUccOvWnntzfrkj1IpEgKvAW+3g+GTSvi?=
 =?us-ascii?Q?m+0LOreFUK7JT5NUc0EyapaHhmG0gAExj1UmuFvN8LXZOHqUNAghv5JXxXkN?=
 =?us-ascii?Q?d699PQSra3v2chpTb2Ho5f74l3cBfevj4OPg1Ck8BQbZNYajYxIRJ6gDG7Vw?=
 =?us-ascii?Q?Yn/6fwGjk1rXrCO6L/C/sa+DbnxS/SIaSAfkpWxDV0139utre9MCPtBg9N5b?=
 =?us-ascii?Q?vsN0YzOAQ4916fZHiQMyJe95tX9aqL+9RJtVeoZXCmyouehj8ojJji/P09YS?=
 =?us-ascii?Q?NMNmep28HPz8MubZb/EzZAnpW0I7QUEQn7IXFEBNKHE4YOZB9oZ+DXes4iwt?=
 =?us-ascii?Q?gMyxJp6QEpuAC6KHptVisYLxuOkQXQr+IA+dw2+oDO6pKpxWMWw/NMr60uQk?=
 =?us-ascii?Q?V8UvqmTyRtu6/0OMzYDGxjKdHMAQ66tCHE0x7P5VVo75QJHfszY6/DZzzIlV?=
 =?us-ascii?Q?Hb73Ua2rtGiLW6UFRB4MojWXIuMyAXb+1n5kpBEsp8RcNEpt04EUrGP5axXT?=
 =?us-ascii?Q?e99JKdDOhujetmwnZaMAaH7UNCLo2QcTOeNci33w76BW8EsfnnoegdAIRe7k?=
 =?us-ascii?Q?vAakPFnlEN+R1nudob9NroNNGUeBgWzMdlXf3EpeRUQJgWu1E2nzgBhd2r5U?=
 =?us-ascii?Q?xR2r6cTCdsU1fnjT51U4/oluK9FD5iagUVakZbOaXoIIzvJO0W/1T0LO6xXq?=
 =?us-ascii?Q?UzQ73aCdyhtP9Vr0rWzahIkC4K6KybYNDZ2T1u7QL/WCxh6fk9HCDUuzmhn4?=
 =?us-ascii?Q?rd1zQT85ZqE7Jsc2DBk+41ZmzX+sm1BLMOCR7GFfZ8eJME7liK9Crzjbl7Hw?=
 =?us-ascii?Q?q4L6McpRh1viYTIilYq6czwFu4OIDIG9M0QV6B75Kq6rWvlAf8UfLceu6UeE?=
 =?us-ascii?Q?DNLsVTXoLTkYFSQHRadH5aTVq32RerBk6/Vt9OTkpCUfGQPJ+8ZOVRefxXpD?=
 =?us-ascii?Q?/0dHzHRf8cu5ikAtEs+2IvGX5TxqWOCJLStMz6Z8+bOWv6jFvWVZYA3T9Y9N?=
 =?us-ascii?Q?/Cw8kwqww0JQnl4P0Mz6Wr3ZOJCe7kvaR73clMJ58no7m1ffKOxo+dZZGSWE?=
 =?us-ascii?Q?ZSsvuOgADOw9LbeF6tdLWXjs6wkAMpWb+85Mccn7dcp9njzM2GepJnYkHAbm?=
 =?us-ascii?Q?2MvnKH6Lwz031buzp2s5+3CElCR9K32nYhd62+5gyzEi8prZSLmP7jJx5WN8?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d57d160-ab88-4a19-1cce-08dd55b8d117
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:24:02.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAa8uPhjGfyHKQpbhddIkdEHB73P2ZpSdxeOvipCURQPyDy4wodW7z6FQOJWll/TygQX6Mzl4s9Kut0trhW3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7226

On Thu, 13 Feb 2025 11:04:05 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> This type will be used when setting up a new vma in an f_ops->mmap()
> hook. Using a separate type from VmaRef allows us to have a separate set
> of operations that you are only able to use during the mmap() hook. For
> example, the VM_MIXEDMAP flag must not be changed after the initial
> setup that happens during the f_ops->mmap() hook.
> 
> To avoid setting invalid flag values, the methods for clearing
> VM_MAYWRITE and similar involve a check of VM_WRITE, and return an error
> if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
> the return value results in a compilation error because the `Result`
> type is marked #[must_use].
> 
> For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
> we add a VM_PFNMAP method, we will need some way to prevent you from
> setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/mm/virt.rs | 186 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 185 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index 3e2eabcc2145..31803674aecc 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -16,7 +16,7 @@
>  
>  use crate::{
>      bindings,
> -    error::{to_result, Result},
> +    error::{code::EINVAL, to_result, Result},
>      mm::MmWithUser,
>      page::Page,
>      types::Opaque,
> @@ -198,6 +198,190 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
>      }
>  }
>  
> +/// A configuration object for setting up a VMA in an `f_ops->mmap()` hook.
> +///
> +/// The `f_ops->mmap()` hook is called when a new VMA is being created, and the hook is able to
> +/// configure the VMA in various ways to fit the driver that owns it. Using `VmaNew` indicates that
> +/// you are allowed to perform operations on the VMA that can only be performed before the VMA is
> +/// fully initialized.
> +///
> +/// # Invariants
> +///
> +/// For the duration of 'a, the referenced vma must be undergoing initialization in an
> +/// `f_ops->mmap()` hook.
> +pub struct VmaNew {
> +    vma: VmaRef,
> +}
> +
> +// Make all `VmaRef` methods available on `VmaNew`.

Are there operations that can't be performed when VMA is still being
setup? If so, using typestate might be more preferrable to Deref.

> +impl Deref for VmaNew {
> +    type Target = VmaRef;
> +
> +    #[inline]
> +    fn deref(&self) -> &VmaRef {
> +        &self.vma
> +    }
> +}
> +
> +impl VmaNew {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is undergoing initial vma setup for the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *mut bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Internal method for updating the vma flags.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This must not be used to set the flags to an invalid value.
> +    #[inline]
> +    unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
> +        let mut flags = self.flags();
> +        flags |= set;
> +        flags &= !unset;
> +
> +        // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet

It is possible to make this API `&mut self` then?

> +        // shared. Additionally, `VmaNew` is `!Sync`, so it cannot be used to write in parallel.
> +        // The caller promises that this does not set the flags to an invalid value.

Does `VmaRef` has to be `!Sync`? I wonder if we should explicitly mark
`VmaNew` as `!Sync` so this is more explicitly correct.

> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.__vm_flags = flags };
> +    }
> +
> +    /// Set the `VM_MIXEDMAP` flag on this vma.
> +    ///
> +    /// This enables the vma to contain both `struct page` and pure PFN pages. Returns a reference
> +    /// that can be used to call `vm_insert_page` on the vma.
> +    #[inline]
> +    pub fn set_mixedmap(&self) -> &VmaMixedMap {
> +        // SAFETY: We don't yet provide a way to set VM_PFNMAP, so this cannot put the flags in an
> +        // invalid state.
> +        unsafe { self.update_flags(flags::MIXEDMAP, 0) };
> +
> +        // SAFETY: We just set `VM_MIXEDMAP` on the vma.
> +        unsafe { VmaMixedMap::from_raw(self.vma.as_ptr()) }
> +    }

