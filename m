Return-Path: <linux-kernel+bounces-342631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A29989111
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229CE1F21160
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEBA15B57F;
	Sat, 28 Sep 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="OvTFEM/p"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2102.outbound.protection.outlook.com [40.107.122.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771D17C95;
	Sat, 28 Sep 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727550014; cv=fail; b=XP4Nec/pCabfMLcYmOiCHbMHU7ZfDFdPs8My08xyONO52htb7GgdsecmAQWRMDD+Ss8z2QB2lZhlrMSH/u0i5rkKDkOgCXvUjM5cTj20452SfNGJo8NJ97MG9k6vBSwA9vn1JI2zw6gLf/xMUDzSyc5TNHdcySFG3U9TabCYY0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727550014; c=relaxed/simple;
	bh=JCKU0UBtUtjVq5mnfkAvb1dFINATezh9/6NLzptNSDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DgFr+9T6DqCWlttzZkm62DiVNjQLbx43STnJZvQPFvKDbdNHo6vgURQy4j97jIiGNQ5f9aDSBN4D8YfvOJ2qOFT4ozEGB7J3O4r0bzJ0SEd43Rubcl5KO4tlrrswl1dWUFnUCfkHJz6JERYNrkU3+jML2ekk2BCAE/83eoZbkEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OvTFEM/p; arc=fail smtp.client-ip=40.107.122.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S61fn3h1qhH98g6XrW4wiKUTQjxnr4H+pfIDODYfcvfbgT3mNCiAkWihqFmo1wBRdp+6p+SGDxt4IQcTL3SzlfaFLCe6shFcGcb0IZ+UIUYjkUKlW1S6DRBHSsVu9/8FSy5b1QZdibnPH8Y5bjLRw7ysm3eU46PDyl7iEyCmZEyeuwp3MlwjP+gttgbDm5UpKFGWN2eIVsYB2dkjVXeeVVv49xXSpB94etrvsfx0d0T7p4uhRjB+3rR8XuvltPPUdY9Kra6B6dvkBzp7dQtxmICpUr5JTp/G9I1F6pwLxAShovQNtpUgUYgqLsu8rmmzE+ZUCnk0dfdpD2in1WXK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCHKC6501ZoGRnQrJWwCiVJHLT8WwWaU9sBiqVDhWpo=;
 b=mnxHOw53FLoF4n5xsb5U9z8DAp9B7MLixcFT9OYLstRO7U6d5gIe0n/qdOckWZNe1k+5azazkME4pMFjkrfI15bgxkFgMqYM2PfdoT/Qo0r0z3FbPeQ5MkZ/nkTcbmtQIJHmOEmrJ860IBi+p2eVw5crbxIr0h8TZFENsEQNCpsjXjE3xvLS6QX1F5FcUTwi2u8VznSo818Dudh/VmKd1iak0jfiq2VER1RLnuXaVAEmOo+Set6JmJs+0YGi+aLiChD2rvUu/NdQFjJoaUzElbYvRi1ugdyKccjRK+GFswGukEDTP9MgRmom5Cx3o8+ChTTeCPoQjGQUvebnZ/fORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCHKC6501ZoGRnQrJWwCiVJHLT8WwWaU9sBiqVDhWpo=;
 b=OvTFEM/pxpqYP/A33V5rkfw314tMweihDTpyPQZzIZflRPIa2hsPzCc/mf+IXjN1JIaXp35gefhUJuL4CNXOC5wQe2tXF9b5FgIxe4JMygusprqeYwh+lt4isTLsCWDRUZyQE+1d7oPh0d/vj03Aw2dnmp6RG2jQt8FbfhYcnqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6981.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 19:00:09 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:00:09 +0000
Date: Sat, 28 Sep 2024 20:00:07 +0100
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
Subject: Re: [PATCH v7 12/26] rust: alloc: add `Box` to prelude
Message-ID: <20240928200007.7be0fa35.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-13-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-13-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: c744dd99-41ec-40f9-59b5-08dcdfefc5e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I/MoRIZMJp6wuUpmdT6hV+ECYSYwUCh9e8eE6zEFgzr1oMDCYLHbKiJZ9ox/?=
 =?us-ascii?Q?CgYlmp/GcqycUIsaFgWZ1ITixDiSh5TfCXq9hZR+KYv3uq1jjhe16f/BHeto?=
 =?us-ascii?Q?MGUNoVH61cIKmlpO1+LL0ZKkTrtQQFyaiQURLfsP7m28W8gLviXG2ZwczQ42?=
 =?us-ascii?Q?LH251CNwGntMNKgbquDWPAPck++cYkDUur0AQrxJ0vjMtesbqWtzQRlklBaY?=
 =?us-ascii?Q?76Ws7+U9U4VuVMUto3sRJrITqhr6RfNkcqY+CkmdOJ3zjvRGVuzz4YIb/7fa?=
 =?us-ascii?Q?886Bc/1Lc3Nm0QnT25nacWfsxCAflFIFr7yOsuwpGzQ8vZTPx8y2mvEgEeEH?=
 =?us-ascii?Q?gi2w3IqSrNvcmbKLsqi7DANqeCnB04jDEN89s6OJR62XgRk2xCfPRJLeGSOt?=
 =?us-ascii?Q?5QGkD24HFRfnWUfEfKPctMEwM4vYy+2w+9Ob/XDiMBS42ovpmGXT+fEvcERE?=
 =?us-ascii?Q?ZlcyMLmmNYpaRa23erSZtFnUcADGXQsjKKPbLFSs/RUyaDXmjfN93X316fBS?=
 =?us-ascii?Q?SYT8DAVWfeBzdvIw8gtJg65AIU0JjFqCVTKG/heT7rYYu/yBq0HRL1SUaWJ9?=
 =?us-ascii?Q?l9CQTJXSFnu+SmORIEj9nfM56kyBv0ejoO5FDsKmJ5N4kivGUrBMsMB8zh+O?=
 =?us-ascii?Q?BRH2iYYXsRl9mGK9CSld4FnkoS75KsZd+qo4kJReCmX7Cpobwcx1WJnnpNtN?=
 =?us-ascii?Q?3VrogWCacES2xsgiYGoWoG23ZkH0QuoPDkwxypYSJYvLg2p/y9pezkV8XyOR?=
 =?us-ascii?Q?d8AcwioFbIKrftt7XUY2x+OxZj/fWngfQJ65L8wFRe+su1wOt74Ozx7+S+G1?=
 =?us-ascii?Q?IHP8o+LKVesbZrHeOWRzJPQ3FrU5mL++wJzKAIJTL5vu+Ici12hGqG6Wo5AW?=
 =?us-ascii?Q?UdzMwJd2IIYzwqNK60JaWqnfXfaZFVbquFXq3u87JojirpLQMXr0a3nC77T9?=
 =?us-ascii?Q?Lmah/tI132HpLB+5+f+SyTw9ogQ6YSUF1X2fYmm7leY7qKuNtgBGLrZFFiHE?=
 =?us-ascii?Q?3AYu0kVUk8ONq0VFTHhBw6/qqPfynKfnP0qXRnsgrjYevB2mRWTbnzCwU2lH?=
 =?us-ascii?Q?NXv6lI6KXBKcnkHudNjkS+4joiMLFaG4+knpz0SdgWxCVNisMugfdfQ+98S4?=
 =?us-ascii?Q?wcij77mUf8aVVMfXKAcFFUThm0unRcKUHvP//DhhBb0fRCTgIQSTNSyMrIli?=
 =?us-ascii?Q?6ITquK2/AgUYtWrPcLKAPf0g2s2X3Duz6/eLj6egTei0848vnYsEFau4wncg?=
 =?us-ascii?Q?myjvWYQqyBbiS6Tii80MdfxWlcf6KnImM3k0pNDc/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHMZCD3cSqTVmF9SnPgUvH0RAWsyFET6azufa7Wz9U/EYs+wfS2WtdrpPCLM?=
 =?us-ascii?Q?55D46N7VambWGqxbQ8qkte5KcjlM0feNQVCy9nCB0dpfHMGEG/GSIFGuIfgB?=
 =?us-ascii?Q?cLXEM3jp8uvruSFHRtY8urcTzeYV5rLsbYvuucR4qTKg4Txmg7J3Rril3Csh?=
 =?us-ascii?Q?Pzg4sEwAkIPf5+ZdozdUvqIjn7phgxc560O+YUMB2MYrTOaLMz7ZigkaUd9b?=
 =?us-ascii?Q?iTF33UuSKqsMPPPvrYrgz3h7m6jBRScp4qkpxtBDpye9L+mTUtn7eE6AvCt+?=
 =?us-ascii?Q?/KBsqMqs67ASJWkTXjMLTvdFCPDJKWdFpEu2dBJ2gVQdwPDMzYrLF0dsRgsC?=
 =?us-ascii?Q?1ZX8b7uWTdlgl7DlAiZ/G4TjtMH5zJfJ7MLzmi6aPIVgD5WpnS0co1RwN8g6?=
 =?us-ascii?Q?xBakJWiSvpFeRr2iJmpuyUWWDe7yDVv/ho0kqR+4oB/Zb9nqC1vdpM0yE6Tj?=
 =?us-ascii?Q?+lCeKf/2gRageSmC+YfXdk9eNMmcaSm9DEoXQeRekeqzg/Y8+YmxHAhDMqtK?=
 =?us-ascii?Q?yz9ORe3IJhg70nBzCzhcGSGPNvwTqGGQKc19kVAWNZaerH0dciwQicIj95Mb?=
 =?us-ascii?Q?2Htuc0RKWN/UAgdfZlFYIVG2tjnCd9TnAwdAGjjkkSd1q/kyS1Jn1dkmX017?=
 =?us-ascii?Q?erHxrt4kWjiLRqGeMxMAeI/RDISHEXiGjET7CgOJ2RrFBx1/Pyb09rMO/qDG?=
 =?us-ascii?Q?1EnA3EOEbK2uxb/eeqr7UujA7lq9hD50R4atF3koRs49tuvlo1qAoEqYIKUV?=
 =?us-ascii?Q?RW+ry4WUbDvuq27Ps7xBBEIKRvLBLX6tM3xoS1xFwrmiamh2KsIgRbivo+bQ?=
 =?us-ascii?Q?I40PaPtgYRdhYfgDLW5XEc9RdiEe8KwFQqxYLC9veDRprySOcrnGQsqdtLk3?=
 =?us-ascii?Q?cJyNXOHV4Pj5LE7V7lb8DIjzy7E0ZeMxAvQxbzW2/Nxc+14RtcX5H6GF+BN4?=
 =?us-ascii?Q?6CMt6SffkOnq1+j5OBgLzJhNmOMEpfiGcbG7lgVLraMbaJ7PL1mWU8PraJFk?=
 =?us-ascii?Q?JbRkD7XOZCmD5FpVoOLxiyN4Hc2E05W0n96rNT4sfWpXjyebGmFQtGOaLy1C?=
 =?us-ascii?Q?vSqCgFBcB8D6ZhoG+9rfWK8838aFwr8QGOiq/4rchnrmxnGVAMc7s/njDzEz?=
 =?us-ascii?Q?WCWFzAY9uqP7sKXhmpsLxRa9Pu1KhGKu+rgrTsMfCYdOlJ45kedmDZjYLbYY?=
 =?us-ascii?Q?AL0gHU87MwnY0Uncf+UIChwFVoLLnK+KeKKHWsIwLDu6se6dSdmabqHjektd?=
 =?us-ascii?Q?awttVs5486JNMUVFMuXwXkhCBMpQs9VcIo2to1iW6Iut6vu/N/DNRDawSkyn?=
 =?us-ascii?Q?vk0epH4k7LHfJAadRrlPPknTnzdLK6z80D7ONKDYkR1p1x2t2zwshUaz4dBT?=
 =?us-ascii?Q?B5QTRWJ6hLakpuZ0QV1gZ1wyEfTnfA9TuQ+BLkRYSrYh4VbtINkTPJvKu6U1?=
 =?us-ascii?Q?tqIiJcnMFopefQtyQPMYst8vUY7de2D4Ag00b033tu3+/t0cFAgHZ45drVY/?=
 =?us-ascii?Q?lQIAcA4s3Uadhgbmp61vJHLN4sibiPDDInLn+XMvAhWBQMNivJB0fDr2L+MT?=
 =?us-ascii?Q?dfuqzVvyOmcgGe6MabKHfgE38SVUmi2nhBjIRmZm?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c744dd99-41ec-40f9-59b5-08dcdfefc5e4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:00:09.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wb+2wUrcrbB4sy52awTWHypvG7QNMLFb0WgSTeAvfhdxY7DbA9aSXX86NRil5f2Mz1S87K3g0r+IYyhKTCECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6981

On Thu, 12 Sep 2024 00:52:48 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Now that we removed `BoxExt` and the corresponding includes in
> prelude.rs, add the new kernel `Box` type instead.
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
> index c1f8e5c832e2..d5f2fe42d093 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>  
> -pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
> +pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox};
>  
>  #[doc(no_inline)]
>  pub use alloc::vec::Vec;


