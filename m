Return-Path: <linux-kernel+bounces-342640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D948989120
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26BF283C96
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091BC16132E;
	Sat, 28 Sep 2024 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mFFGD6wc"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2127.outbound.protection.outlook.com [40.107.122.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02A17736;
	Sat, 28 Sep 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727551803; cv=fail; b=sjthC61tYNm3I0FXS2vqwkwPad5z8zWDn3LeDDYfZupONRGq+zw3tnVo33E4DvjBo0qDxh1/H4Wi2oWjnhLPFjOdMLCVOix502mNtJa55o377PstrwZYn8luk9HPxCL+gYgf8tnF8WmV45MigkAwaZNsYLfXqlWzqpx0p1s1C8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727551803; c=relaxed/simple;
	bh=98/IRqRXk8QtGDkq5aTXe9iAYjMP2MHdq//qmjE26v8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Scz6aID0PJvBMnsHb4UcdiloJ54OfnIasGEK2i7dks4ml+VsTBrjUg4u4/ksHP83Txb3lE9mkJKWxRq2N/zw1U7gGoSuHrnMNATFqewJ5FqNUKs/VS8IB1tL8frtaKf+Eadbf2BhoH6kWBal9HdMY52UDpOKddTVxH6Vj7xvEHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mFFGD6wc; arc=fail smtp.client-ip=40.107.122.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHkdZt1vExD7YdgdJLRFZ/bhymuCjpcJwFQ5ULIjhnuiblzMK7uYGEdJHUZmdIRdM/yuxT29a3KS9sjXbmmdmbN6CFkVp2e7igrD7AsakXCfgxjBlD5r15LQx2xl60WKQxDn2XRTfqkeJiWMurYEB4o0dM2Ucah9XFnswos4DwC5INB2u2LIRXvrKLTQDkvldXrCEMFe3I3CokWE2RulttIVGjfnH/Qy9YQJ4N0kq/GmnYsYgI7gUb+drzA0X4TuHe1F40dPF0J9xzbfUpyByaqTAL9Ka1Q6TqmrfUoigXqNG/I7QaYddKTmAVly/toD6gWKI4b6o9gz9ZUnZ6aA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT9R32f2nCpYBKk2Q1w2zYdECplyQrVtU7toGG6KL04=;
 b=Kj+3nOISFHhrOvcmpYnYLG12ga/JbAG75WzYw8UOMEjo3zNuBwcfhCG7sfkcth6hFA1w27lthTr2lGVo252VPzbFxlikzzTgdR9NK1U+H3pU4iifhfOPGQy9sPhsSm0dVaW04RHApn1ip5EZ98VfoL/27YWeVM3WTFtLy1pt00fejz9oJDB+7/kXpW48xe4gwNYilZnAKvGqrtjx+cW2R+CYXSVI8sUUQ5eaXOa+qdpkSBq9pCLB4fXCjyxUL8oNiAXNdczwXPfl/03QCtDJ7QZB9peBCBQ6CF7y0tMMsOip3SDzfuYAQN6XQX+jji37au5Mzy0geKro8+BUJh7U8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT9R32f2nCpYBKk2Q1w2zYdECplyQrVtU7toGG6KL04=;
 b=mFFGD6wc2v0UYEKDIi+HjiJwmCkMkLUrXKQiLA5cYdQh8uuE7zUyiPwhtHexrjsjxAQ/WKdTH/uPoKXD8oiMIBUCbOSJ3EdDzPGh64Vgj0opQurcMhPK3r36zOve5116h6b6wlsHEZS44e/M0EJ3kc5BBjl0b82fOzsnj/FnmQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6484.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:29:59 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:29:59 +0000
Date: Sat, 28 Sep 2024 20:29:57 +0100
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
Subject: Re: [PATCH v7 18/26] rust: alloc: add `Vec` to prelude
Message-ID: <20240928202957.24a77b66.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-19-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-19-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0247.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8e4d1d-d7cd-45eb-c101-08dcdff3f110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RG7XTY/R2yptQSaZ7nq6wqKkchxx7hAesxhpyZacIyrImQgNBcwiYtKbYkeP?=
 =?us-ascii?Q?F+SwttsZkTkw+DwaHk0bQLN3AEcSQixkfNpj3PLvgkgR5jzf2/3btyfKg/mq?=
 =?us-ascii?Q?VYzEIIEW9s2g0LcjH4lgyDpY/F1gtSts5M88FPZ4denQdXGXRRKl7lPYkDey?=
 =?us-ascii?Q?Ji6qWBSIVuKrwwONmDWX+TmKUgz3VgvPCkz4jjXLXnIElimH573Tv3Qf0YyV?=
 =?us-ascii?Q?REFlABDQFE2gXnvpjoaCkZvHpDOhWGl9Sg6R3nRG7CNBucQ8OcFep242Vd1x?=
 =?us-ascii?Q?VQw6O8ggZJF+beze6B/9txsr7V5xFlxGUrpuB6Kq8leMEqJk1rg8ySJdZtMS?=
 =?us-ascii?Q?+DsmV8dyvvCp3g4KdOsgT7JiRPHMHUQbQvvYxdEW2T+OeApp6ZuJT06pa0cX?=
 =?us-ascii?Q?200qMbIrcgM9HS6jKzYzSIM/Te9+AZzAvVW7yXm+M1n8NtUq44Zoe+80/M9L?=
 =?us-ascii?Q?J52+R4qdYTwGN0GD30Q26VxyqPGGnOung/dQIck49iRlVmGdwCeeANO6+pku?=
 =?us-ascii?Q?fzXAw2rBft9o8rv5AoWGG8OrRvkJmB7Y81dCNPr/1SIYlRWxajNSLcGc84d2?=
 =?us-ascii?Q?G83ysezt7Ut2a/oC2JaDt8+fP+TkiQ+5rFrcfon4gCONsMeS9MzyomeQQfrX?=
 =?us-ascii?Q?RiReQbw8DAjbJhwGVXEX/ryUjaRSjI0Sdd1jFg1CG81P2gxLzhj8J0twwvim?=
 =?us-ascii?Q?uP32GdFOxszBmauocUgBubjZj8k27/84mb0+EEp0mptqxW/Hdba5efelyteX?=
 =?us-ascii?Q?GV9VUdQPW749snuAX3AeJC5MfYk8UP5ynM2Ff2pQcVwD/KmWA0pbwINq/V+9?=
 =?us-ascii?Q?wcsB89TN6NDz3pUsm3YNOURJcwIR88HexuZVXdPCo/rTe0VrbqdO9c8sUvLH?=
 =?us-ascii?Q?69i+DEtETC6VnC73mViqUa3xDEHT/Tn3d8vSblD4RSIJZ4f/K2o5xY/3hFWx?=
 =?us-ascii?Q?87QiXMjBDMvgZ4gV8daCzYArPHdvHIApU0IgUCDHpcKe2I7rjs01QJ0QIqni?=
 =?us-ascii?Q?JZFHWlrCRdpVuVced7Ik3pUz6EfLyKAkJqYi9NBHjcaeP9mXvI/7yy+7G3l2?=
 =?us-ascii?Q?Ow7qtw0V2xBOisHLGoVXXIzOWrk1GhG9nLMumIFzyR60S6FAYwU1r7z6gLgg?=
 =?us-ascii?Q?SMPCufC6NjdDYO9+N25VeEfWpyIThBU8x5lg0xCKm0HEsiIBTH85A2+rpTsW?=
 =?us-ascii?Q?asfhjVVlFUy4T6EtIAh4n7agYjMBSQTLOYMXwGFebSKIsA1u+KtIM/zPRHzJ?=
 =?us-ascii?Q?gokSOdEBVzb27wIb/JdaKytWWCF2vy+bwE4v+fAwJyhts8Z3TgB2r0gBkscb?=
 =?us-ascii?Q?n4U42lNJw8J6rGZMEdiXgAx+QO0R4kp58voy8LpvsJ+tuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MmvxlwnjDjgajzQy2WoFzSIpgZFffmpYrlirRRR0MB8Sp/TcODeVDQBnTF0d?=
 =?us-ascii?Q?FULWBj1iY02gCuc7uSD3xJA38LIT+XG4TNA6mrRtgtyyQdg6jvyRsRNFl9/T?=
 =?us-ascii?Q?jdTrBDqObhQHKo4FC/vNbxWJ+xgujn/v/HQsesQuyckR0dgeWYZ/nrPzCdkA?=
 =?us-ascii?Q?HmsropnUT6fA37lPZIcLQSoSsNr06VfVOUKx7mAFPQAt+tQd9jBMKIayBIPR?=
 =?us-ascii?Q?tNQGCwkba5i4GUUtwquM/veEDtgYWcWhLtVHt7Gm/Rm5IS9TuXtw86Ix59Wc?=
 =?us-ascii?Q?/Nbm5xkzdAkBJ7YdbLgEmkEbW1Oi3Osvo4UnyQBFpUd5lli5PImPzQvvF14n?=
 =?us-ascii?Q?+W0Ebztll/5Efk+pyUl6BERbe3DU4JeEJkhc8VuY9rUk6KlDML1S0gKTnNPA?=
 =?us-ascii?Q?64vQfkbXmEeMn1YlohEmHqFy2sEPWF0irjXm6R7vhsGby7VA89Mf1eFJrjqs?=
 =?us-ascii?Q?d9PwO1r+Nx15gWbJk0hNGJzlDIa52g2S9A54ZFZQY0iPVXpUGU4PHpJFklqL?=
 =?us-ascii?Q?PGDSrIroS75CcLULfa5nDlJBhn0HZWuaHs/VKjd1FySd8f+dwpIjM16P+Uz6?=
 =?us-ascii?Q?BSVwoAfta1bTpXE/GVTAFlKqW/BVVK4y1TKKLCeYqQBne5DaZSJQoas9f8ca?=
 =?us-ascii?Q?ml+ruTrk0NL0H+XyVufD1DDD0ofvD8erDSbihESt7Nova4/M2wkWCl/p19hO?=
 =?us-ascii?Q?9svi3aTOQF31cIpqkreWxZFaNigra3BTDdfZyvbXZNu2rTdczfqeJXtp3kyo?=
 =?us-ascii?Q?mWIbQsuSY8C3KsHRn2mC7ddHNEC7G0SMLOZeYGokSUe+vZrr+Z7O9xsWtvVk?=
 =?us-ascii?Q?4aqse1kzjYmza0oNFNP7ixz82hw3xdFoFLfaUJK4Z6mBVdO71MvzFXYneuJo?=
 =?us-ascii?Q?RhMADBg6gYhk66TViCcluib+eX3i++rlL/ePE5vOCtky70bLl+KKcTSAOiF5?=
 =?us-ascii?Q?IMn75i2c6bL/q9CmZNG/WB03nIOGNvWoNLJp6Et5vfQgbY44Ki4m/3xBYcJy?=
 =?us-ascii?Q?4uO3ik0CrA5KPdbgSNDvQYGAr0SG33PU47RahjXNRr/FohYjj3Of1YCPI7GO?=
 =?us-ascii?Q?+yCTPPXIFVsfDfghmdDtsxIOyCxPxZdS6YcArQMmUXlDk4nNkt72yxTbtg13?=
 =?us-ascii?Q?G3qWjOxXOd9jWaiHranrxPi56X+uerbKL/EB8JqinhrEExYoUkeXZOnoCgtp?=
 =?us-ascii?Q?sclu0WXwEkpU2gJZW57h1wHrIOcTSkl4CGIHqcwO4PUocU3KSVhbg1b/qoPs?=
 =?us-ascii?Q?2ru/kGIEqN+bXc5pxUdzd+3dI3WERdMUEBBZB8uXuI0U2/p4rMfjATseVVOt?=
 =?us-ascii?Q?Bo/cwoW7hwNPePMvbTU/t/pVS5h4I3ELbPZ772zPaRqJM+6g5t2CYGNz+F2+?=
 =?us-ascii?Q?jpYqJ3St/seFy9ZgqyTwknQPouMs4EgRRFulxqEXzApRIO0h9VhU8h5o9o88?=
 =?us-ascii?Q?wKW8U5R8bybcbzF3XhjuFv8nCCYtHwpFveUMc+8HD43JGNs5vn/V6qJASrKj?=
 =?us-ascii?Q?TLw/my2Lf/amTrkT1m1NaHfrgaoD8hJEAgFBNQiLbyKBUMJyRgS63Xxmb8B9?=
 =?us-ascii?Q?Tp13CFqNeYL32dj/fFOYLyQif/8SVmhI0lGAO7nu?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8e4d1d-d7cd-45eb-c101-08dcdff3f110
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:29:59.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO0EgLhUk6Elzk+GycTXALpnqaVzrz2fNBeOZ8y2aJg3LxLSw6s/5kkvXktVH9jnstBRbx7hxFI1ZfOo/VnvAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6484

On Thu, 12 Sep 2024 00:52:54 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Now that we removed `VecExt` and the corresponding includes in
> prelude.rs, add the new kernel `Vec` type instead.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/prelude.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 07daccf6ca8e..8bdab9aa0d16 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>  
> -pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
> +pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
>  
>  #[doc(no_inline)]
>  pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};


