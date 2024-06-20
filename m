Return-Path: <linux-kernel+bounces-222731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138B910650
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4B61C222D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C661AD9C8;
	Thu, 20 Jun 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Xw5UJQKF"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2095.outbound.protection.outlook.com [40.107.121.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F34F211;
	Thu, 20 Jun 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890579; cv=fail; b=fFD3IPNRi+zfPLLf4SoqNb3M152qHHegjtndaveI9fZysVdj3JtvLKseOHdB+JT+d8lI4kFqpclfIKVZ0AMtSU0dCKEw6DVwUyq7hXCz8v/8xyhaB4mJ740psaiumS3aBvsSARH0GMx9mtWYl9935lRUlHVStyIKGBigrtwlMRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890579; c=relaxed/simple;
	bh=i+e7gx+qu0MKp/bKrPtnCPiqsdktQLqQG0HvrB/OcM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l2+hB9Wk4rCkiSDFMlcBflbY4Hey6FoWrjG0bo67cOYpUPpAK4inBbxZFR1p9O8Ti8t3BSwBfvImUSYbJTj+u0aTFXy/156825gYAG3FL6tC7I6kLp9bW/hkzOEst8juyDIo5q2pC8txNf7HG0hLg6fl+J4xnQXnGJEJXHv7pv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Xw5UJQKF; arc=fail smtp.client-ip=40.107.121.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT5gM6GMSo+T3/55tTJxssJKshzYQz5qG8wUkZZwnfapypJwD2oUvFXVsiLL4sO3zvgessSY/pmL1AsQfpqLmZomQMyadIgh+FuMq1fMrXR/sKlVLQ0kSuR0YPJHxHITte4B4d9MmXfHzvL6IrNz9UI0duLZ1hPpow9qw4XKTjZqI1W3G1amYdOzudaTyaSmMmbrIWjvngJQohfDPnZeWnJTbh9a+vY8UNBsVTlkGWtWOyLZ4xrNOshPcSdwfO1upb7EqGFQ4aTbmFHo+KheOvW3D16dxJXTEiHWdVDF/w3lHpQQV00lS5j0GA2HkJyUZuAFsWJoeyW6Jn9W4IrskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfCfK92a5jjayAP63zdNd5kcntsQOpxx3G2o8UKbYzw=;
 b=YN4Y5g+xi7dToL1QvRTe2DaiescBFSg4z1KfpskozjTunn2qj19cIF3y2naFtKuIkAYTv/OsPBZIA1aj46eIbSCj+/l9l2KCGxGGY64oLuhaGL2PTEzPLQfx/7Y2mQCYZRI32OUxnAk1RSmf5Y6ZKUXOoeXkwvKV+dPGxN88pWJDe5OXC2/xb46f8wtOYMbH27AyQndYasjjWFLQXhOimSl3D7F0GWfKPQYD2sYYO9cFS5jguHojFxYQNWA1QOe0V+l3IudjrMjcsaZtQJGC4qBoqkalH949cV0tHlVKOXBNENSE/ZXRkb5egIk+xgau61rSaHjWomEibF9C/ttN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfCfK92a5jjayAP63zdNd5kcntsQOpxx3G2o8UKbYzw=;
 b=Xw5UJQKF2FtXWae7GJu4808lwulMN2Wdmauamod0EWs9NEnkPPP0/6S8m+d6o3EpQhAsXlz7RTJD66cJrPE/rPE7wVOyktrP7rLVsHVCS072tUkRmpGTbeV9k9mrlBs7qj1Bj6owlr0pC9g2edPfzbacKxfQQVNec+5IPFYbtqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:36:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 13:36:14 +0000
Date: Thu, 20 Jun 2024 14:36:11 +0100
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
Message-ID: <20240620143611.7995e0bb@eugeo>
In-Reply-To: <20240618154841.6716-3-dakr@redhat.com>
References: <20240618154841.6716-1-dakr@redhat.com>
	<20240618154841.6716-3-dakr@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3314:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca6b501-2d4c-4b39-a093-08dc912df458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S1aPOq7U+w8uxBz4IUmvB41pWisVBSsOKTfp6DJ0jGaJniiGSs0ZcL7LkYX4?=
 =?us-ascii?Q?T0yh85F5Y0anry/1vPXHIXt1T6ngCM28Db+vC3qBbp3oXMPEUepSJg/f3rDf?=
 =?us-ascii?Q?2KkzuXpO6DOHg7OGyj0IBQkH1xHvW2wp9Aw6O2QIUeXAP+iwrk3XmMgZYVnv?=
 =?us-ascii?Q?xja5ipFMQbvRgjEdQUIvQmMRcH2Qth1knYCQsDzHnVz5NCYgAKlOTMKo3s18?=
 =?us-ascii?Q?KO0yE4p8v/GoaMkq+1mq4OfBtizAq6jPnovShMCXyJRfygipjhTQdNokvH7H?=
 =?us-ascii?Q?qVQg4Pgy02+uBvB+no2mE32CUAGy2dvbSm5r1WfR+4NvIOayq35stJbcui2d?=
 =?us-ascii?Q?n3QKNybwt/V8fkWpDX9Djm/8ZdxdRz+QKqjiVNvzHm6Jk032R+t+FqAJcg3K?=
 =?us-ascii?Q?oI/v31uMVjzyKiUCoXJawFoIXgJ77hvhS2ABOlaRuYZMC4hRelzRTLE5ATHi?=
 =?us-ascii?Q?CzK8AllxA0EBPk9S439W1veru3xBOKWvH8fxmnfuYZpvQKACC236RefPZ+iU?=
 =?us-ascii?Q?WUdPCa0aFx/zfpo1sR2AFx3xaDShxZksZhiOeY15t1lVZynAzimw69DnZyz6?=
 =?us-ascii?Q?5toxyqm6ZCtH0B8JkaLqHp027odsgnj1CaTxKi/LA/WsWKVclT5DERClX6wl?=
 =?us-ascii?Q?NxDV7Q52sZFIY7Uv4GXWSs3n0BDHY7IBGGUdxD59SOQCXNl7i7CEjcyCc+WB?=
 =?us-ascii?Q?iHkDQPDYizMNSiQce2FtuoiOotMhWLGWJnshmhsuc40qls3XRRt4AGOzWheM?=
 =?us-ascii?Q?R8+fmbfuR6Ab4lhIKnmkokJf9T8Aiskzo/xe5gIwKACBGTUzeqOZ1/EwfrDx?=
 =?us-ascii?Q?6eF+ofFJuEitqmYZy2bmcNS/ivkuArbfFFByjFnK02p2D2RttU7yVEGD7PwH?=
 =?us-ascii?Q?7jItUbcMSoTRohYVCvRKm48u+9l2DJ9d9dQpgr5nszFFeYeAb8iFgzNzE2vl?=
 =?us-ascii?Q?Sf5x352b09IHS9DwN+D6hgKZQD0Cj9YsCOoQ+PuoEc1XtCMHKW7mRR7c/d5q?=
 =?us-ascii?Q?2Hd4oQkt+eOQcSX8TWoKoMCyLVLKseIAlZE+HbDwyBvckGg68SyW/OlGwAi2?=
 =?us-ascii?Q?XVN99PI7aKdb1941psNLAEJbseUwLANFJlxieSEPR9hSghL6xF5/5+9b8qCc?=
 =?us-ascii?Q?X3N9bD8dE8x/R/8JkryNXY+zBZr10G9nKhvaa3MbklWxBoysuy2URMKeZVfD?=
 =?us-ascii?Q?2hrustCCd+L3y2TmYru0mAfTs0DJ4w2tZ2B4follh/RArDNJIF8I3MvBFLIv?=
 =?us-ascii?Q?UhbnOaBTpl9hnyzdiukwEHD2rxwvqvRU24Vl4jIcEvyiI/qEflv3NUewrEni?=
 =?us-ascii?Q?jN59f3qZ9ovYdoT+o9I5Nzjr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uv9pZVEHyh2EBz3ctyaCaArcq1ZKdPu2I8tqb1fou4vG+/JvhW0tyWapT3TW?=
 =?us-ascii?Q?dPPsTAOFarQcraY0URxC3YsyiSHchdmh2iC2MI21PwKsoU62njWRM2BUfXE0?=
 =?us-ascii?Q?iL97YSHanAv8G8cGHmuTlMNPVUWyRAXqub8sEFN05nJK98UTegXajJp7k1wI?=
 =?us-ascii?Q?j/0XDJzgaFXgEG0WPeu/I8Bf1Ncblm1tiIL8NwO0OXlB2NZB0KtTU9DtUxg5?=
 =?us-ascii?Q?rxdvd/vgkzUZN13rJvVD6I2/ha8wP75t4FM59awBl0EJO7QjWmn1Thg5K3sw?=
 =?us-ascii?Q?AFJMoVoXF//nkQ2mECp0eyscAk/sqjIMO+Tzsi/w95w0+fl2SF8YZLtwwTGu?=
 =?us-ascii?Q?oqIJDxdrRRfJjE1XxxsbCHE7WLfL1GKzTUb1g0w9J7RGS6WI7T3LhJ3tFBzS?=
 =?us-ascii?Q?gsVw1encab6U62uAiUJe7VAbNYElvBh2gp9hJ9v6OX0ouVQXNPNyVi3A9dnP?=
 =?us-ascii?Q?hZPb5NIwp7F9FY3SR4eRji3h06QAFzyLp/BbKb0jLJuGMgFwZMqSu9nG9nIo?=
 =?us-ascii?Q?7JgRm4WiYmuPEb4xaefBOnys6iDzsalJVvmE2tSnythVjLJFLEgbW5yjsBsF?=
 =?us-ascii?Q?ZHjzdFjs/204aZsdVsy4/IHpnkUNliTyeXqrrgQq+MAdjQQUWtDDsysBJgK9?=
 =?us-ascii?Q?oCf6jehb/7CK6DyIiBN8kp0A9mPh889HWO7J3wmdvaRbPkD3u+e0H3L7+lb9?=
 =?us-ascii?Q?jVPZX2H9dj/rMABoBfQnw6QFuPlJi3bJLyh4rkQHCiOQaXln5A4a8kbnm21s?=
 =?us-ascii?Q?ctAfkzWuH2oglHXNzmzvcaTJkj4n9U7fq9LfHRze5SxULDqTxG0dPjp55nyS?=
 =?us-ascii?Q?9c4VM6SU/58+C0LDdMI1jA2ciyEA4k6FoPtu7WfvRdsWmmt1XkjRTIxWa9vn?=
 =?us-ascii?Q?5oYQN2zxvMdUVbTCY2e0lKHdqpOZiWXxrKUfJ037qnLiTjQAxs4nTZW1AmpY?=
 =?us-ascii?Q?Vcc50bO6ppOlgZlZGEcndi8YKrxE/4W9ZNAfTqZ/LN46LwwVy0qasOdt/I1a?=
 =?us-ascii?Q?HdKKl8/bRH8wi5TtGnahphZfxms62BUb5RDLwGx1VQOd14ESEeyB2+mjCbPw?=
 =?us-ascii?Q?6ZaeRL7GIosnbHyrD2dxsecGRY3vkcp3bYcB2TvFDGwx8e2vhCrSgRd0a23c?=
 =?us-ascii?Q?/fvG9YhmbPHljtgolRkUoLI+IOq+xhNVR5sk26rpg7bl8UvR9h+phFK1AblG?=
 =?us-ascii?Q?CItR7jkUFJgw5Wwx3O36E+WCkkF7QVAiNNJH8CWwwSLmNBsYG8tVnwUPSLXk?=
 =?us-ascii?Q?6iRQX76I9yJ5kmnmH13AA1yokAenr44DjwQ1cTqZ5Um1S/lzsTBdDm5D4vOD?=
 =?us-ascii?Q?SZiZOaappeyCv37I40yZ6r8CyAO/jKQ32uJmfWxCaSeyDoRwC/vuBsraijmY?=
 =?us-ascii?Q?sMGQRmte9n5/kplQzMmmRGFBSBvJO+npgDG1Wst7QzOOGB3uwEAi+SDL99mh?=
 =?us-ascii?Q?QBlqghjUc4z0Awqz2eTgk0yUgYWEFkcNLLRcwVZ/Yo8k56sSpkb7XPpY7x4d?=
 =?us-ascii?Q?buwLD0Qw58YgWJPvOjIOXrIPNwUFSPbZIWDHr/f1gmZoWOiHrDblOTmUJymo?=
 =?us-ascii?Q?5HYMjrSwGU3v5rDwPUgFMOFWs8qINuDGeGuq+Fu6?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6b501-2d4c-4b39-a093-08dc912df458
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:36:14.2963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKlwGUa7Zm9HO0q4TydggrWIoK3beSIWgFrKL8RFLxQwUNyyVLtYUjjpfiL8Tt5x6IpFWl6GcxifjUpQV9tKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3314

On Tue, 18 Jun 2024 17:48:35 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> Add an abstraction around the kernels firmware API to request firmware
> images. The abstraction provides functions to access the firmware's size
> and backing buffer.
> 
> The firmware is released once the abstraction instance is dropped.
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  drivers/base/firmware_loader/Kconfig |   7 ++
>  rust/bindings/bindings_helper.h      |   1 +
>  rust/kernel/firmware.rs              | 101 +++++++++++++++++++++++++++
>  rust/kernel/lib.rs                   |   2 +
>  4 files changed, 111 insertions(+)
>  create mode 100644 rust/kernel/firmware.rs
> 
> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
> index 5ca00e02fe82..a03701674265 100644
> --- a/drivers/base/firmware_loader/Kconfig
> +++ b/drivers/base/firmware_loader/Kconfig
> @@ -37,6 +37,13 @@ config FW_LOADER_DEBUG
>  	  SHA256 checksums to the kernel log for each firmware file that is
>  	  loaded.
>  
> +config RUST_FW_LOADER_ABSTRACTIONS
> +	bool "Rust Firmware Loader abstractions"
> +	depends on RUST
> +	depends on FW_LOADER=y
> +	help
> +	  This enables the Rust abstractions for the firmware loader API.
> +
>  if FW_LOADER
>  
>  config FW_LOADER_PAGED_BUF
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ddb5644d4fd9..18a3f05115cb 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>  #include <kunit/test.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
> +#include <linux/firmware.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> new file mode 100644
> index 000000000000..b55ea1b45368
> --- /dev/null
> +++ b/rust/kernel/firmware.rs
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Firmware abstraction
> +//!
> +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> +
> +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> +use core::ptr::NonNull;
> +
> +// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> +// `firmware_request_platform`, `bindings::request_firmware_direct`
> +type FwFunc =
> +    unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> +
> +/// Abstraction around a C `struct firmware`.
> +///
> +/// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> +/// be requested. Once requested the abstraction provides direct access to the firmware buffer as
> +/// `&[u8]`. The firmware is released once [`Firmware`] is dropped.
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid, and has ownership over the instance of `struct firmware`.
> +///
> +/// Once requested, the `Firmware` backing buffer is not modified until it is freed when `Firmware`
> +/// is dropped.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{c_str, device::Device, firmware::Firmware};
> +///
> +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> +///
> +/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
> +/// let blob = fw.data();
> +/// ```
> +pub struct Firmware(NonNull<bindings::firmware>);
> +
> +impl Firmware {
> +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> +        let pfw: *mut *mut bindings::firmware = &mut fw;
> +
> +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> +        // `name` and `dev` are valid as by their type invariants.
> +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };

This is line is unsound if this function is called with an arbitrary
FwFunc, therefore the safety comment should also mention that `func`
cannot be an arbitrary function and it must be one of
`request_firmware`, `firmware_request_nowarn`,
`firmware_request_platform`, `request_firmware_direct`, and this is
true because the function is not public and all users in the file
satisfy this safety precondition.


> +        if ret != 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> +        // valid pointer to `bindings::firmware`.
> +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> +    }
> +
> +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::request_firmware)
> +    }
> +
> +    /// Send a request for an optional firmware module. See also
> +    /// `bindings::firmware_request_nowarn`.
> +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> +    }
> +
> +    fn as_raw(&self) -> *mut bindings::firmware {
> +        self.0.as_ptr()
> +    }
> +
> +    /// Returns the size of the requested firmware in bytes.
> +    pub fn size(&self) -> usize {
> +        // SAFETY: Safe by the type invariant.
> +        unsafe { (*self.as_raw()).size }
> +    }
> +
> +    /// Returns the requested firmware as `&[u8]`.
> +    pub fn data(&self) -> &[u8] {
> +        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if
> +        // successfully requested, that `bindings::firmware::data` has a size of
> +        // `bindings::firmware::size` bytes.
> +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
> +    }
> +}
> +
> +impl Drop for Firmware {
> +    fn drop(&mut self) {
> +        // SAFETY: Safe by the type invariant.
> +        unsafe { bindings::release_firmware(self.as_raw()) };
> +    }
> +}
> +
> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
> +// any thread.
> +unsafe impl Send for Firmware {}
> +
> +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
> +// be used from any thread.
> +unsafe impl Sync for Firmware {}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index dd1207f1a873..7707cb013ce9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -30,6 +30,8 @@
>  mod build_assert;
>  pub mod device;
>  pub mod error;
> +#[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> +pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]


