Return-Path: <linux-kernel+bounces-346491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE998C546
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B371F2431A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B171CCB44;
	Tue,  1 Oct 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="GqWWe4kP"
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022072.outbound.protection.outlook.com [52.101.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19339191F81;
	Tue,  1 Oct 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807100; cv=fail; b=DwLd3ljl1B4bA2SVTa2ZlmBBmyXfAvFQHgzvK8de6OMePkSOiTOueoiPGev/+NlyOrueEHA5S8Ib+9J/nGAFrrTxVCFkRPB9+ldGvp2c8z8LqBZvFnAXyrvCfxE325srfX18WVs7OnLJ63j53Sj7mQxjHEkp0FTOa3Erz8c0/xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807100; c=relaxed/simple;
	bh=e5Dc5v0uKEhKK9z7HDn25QcwvVMgSWau6+uDCkYRtLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHnF0PtvS0RcVA6jUCSD5piq1WwI4YfCjL8c9wdNzt+qgLalV0947dYLeLtYux14PNc7Vzr51x0YuB2T2nrd7G5V2ghy/Iv5De3YkLzK/InFhnk/QRfpluiR2ChFsEgH1p8PXpjFafHRrRWHvyhOiei3EdfB3Fl86FOIo8q/vCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=GqWWe4kP; arc=fail smtp.client-ip=52.101.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mR4M08BJDxEraUL00R/ntsRmc52fveuh8MXwMDGHNezKu9G0NiTVyALP2sp02XpMdSaT2YlFZR9fvzpgFdsPyvjnTF2+dn3mrSqLjn2WW6JMMiI8JzPp8hvNIw79cCtBh7B6TY0/zB8puJSjMktOn57LHFQWAVPtsv/ENFGWLcqjuNs5AYYDWW/nez/r3a6wkPXBGZ48q7ojAn1z5vdf2aodLMx9ANCycly/fs7UsQm/kE1Vl3lb32EY6rVJqmweSSA2rZ6lqpgsEofM8vptZo613472zR8gpuMAWEiuDI13JLAA3uXl/7F9pluNhsMhissw50nUFCz21bgryRmCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC6fzwil92k44hX67p9RE9slsRSmIjM0lDrbjhsYXbg=;
 b=o2qbKVCh6mUp0p7q30FAJZjZyJl0KDarnMPZydY05WID/NsOFNYscMOfMdvMzZ1cOKW3lFFO7+sI1xobTEG9TVqQFRbqFjerf4ZXFxYUwVolhfJv6QQi0MHuRqCZDdsG/nhPXTnx1jemB9rBCKGabgkcbQZS7ge4qNzqNX+JjwJyv7fe+sLTorRpu+aGUjZ/iqfI7Bn3vHX3CcZD+ZFZ8+EjEPOjO14qy/byWzRGQGydMUnFpiXwTyoC5nnNVgjACVmv2Pt3A+68jMXEr4Ten7moXhgqVcYv+TbXMcdu5Mxxi3HXKuDEik6ossbUQCCwlRwnG/seOuT56Y3m5UHbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC6fzwil92k44hX67p9RE9slsRSmIjM0lDrbjhsYXbg=;
 b=GqWWe4kPPzkHFdXSXz/ptgm4+dvVkac+MW+45YDH0B8ZbwzFWA1bxkrHKkBuIPmu4UQor35aypdxVWE6tEYtylpvxl0BRKIs+4Q8VfLZctRuALo6q2B/7nxtXnB++m1U2DeZay6pNcavP7ouI9NmLgYlrOmJaPQ/3t8LP4l0Rnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6618.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:24:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:24:55 +0000
Date: Tue, 1 Oct 2024 19:24:50 +0100
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
Subject: Re: [PATCH v8 01/29] rust: alloc: add `Allocator` trait
Message-ID: <20241001192450.4407ab84.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-2-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-2-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: b24a896f-1a41-440e-48b9-08dce246593e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6jXxnb7S+G9XC20W7y9hC26P9scbl0heVCLjKwHCKb4368jgES7OzyE70RA+?=
 =?us-ascii?Q?WKmPdqs5lRXdloIDU96OjXn5GmWNuiGyn7qjdGMgTaqTGDtDQMme/Hencs5J?=
 =?us-ascii?Q?rRRTadpGzhL0tvFXx+ru2fBp1jFk9bpi+47KycOVjlmToWYzgd8wRS3lJNXB?=
 =?us-ascii?Q?5oPULCgTYVuK21yxn3MXwWRXF5cI+3MEDbPfkAHxT/Dux+Lez8fXhw5UG1MQ?=
 =?us-ascii?Q?HAVHIrylxKSJL0AEs33Q260cYf/KTjOUK6ZmfaM3S0ouY2EqIFtO0Msznqrt?=
 =?us-ascii?Q?T6XmUuyGxmVly0MVXidQXA45QGjATO3AbefS0ik/woPqQqOgCQpQCoDwv5GW?=
 =?us-ascii?Q?0FEzz5V6IEz5xw9ZdXLvBWcYCxE7Zpgn9V19qUKR2KcOuo9B0y4b7NAQzm/W?=
 =?us-ascii?Q?SDmdniAXL/3bAnQC/OzHu7kPHi+6mxEA491EiY3N5KBnk6ahlfjZoUNNJCes?=
 =?us-ascii?Q?krKHMHesltF2UOu8S/2yMOa6uHtdsEZ3KAgWTgx0aFkIhhttShllMsuYTL7z?=
 =?us-ascii?Q?I92CLaSDjH/X5PoyEWzNH0WT7TbpEmGb1nM6UECANhpDiLsSfsFpu7lpT/cG?=
 =?us-ascii?Q?1CRWLGIUuV0NA3K9bL9LpRSqg8lpNf0FQZkH4TYj5RDfj9ujdGzXy0pAsR+n?=
 =?us-ascii?Q?eyiMhXB9IRTL9V0cPldXFv9/qRGywsk92JfiSxdSactNBwANWsCgg72yQUlO?=
 =?us-ascii?Q?A12u+siWc4qX/4x8ePxBObdFChMMRd5n0geHMgPsN7XR7D7ZgvAwQY+15ehs?=
 =?us-ascii?Q?5GruP/orFfxneMJRzCb0VzG6zlhP/Lf7LIkVCN7XmI4OcI/VmxjmGJk9nk5K?=
 =?us-ascii?Q?wuctWsvhlGMaWw7/W3goz0hcZmCuKWr4hqKq6l/crkFjwUuqJTQUuzTRET+q?=
 =?us-ascii?Q?5pM7UQb1GiJKZUd7FbGAk2Xivlp7ZArzLIabu0kSwZZ8L6liXhi81H5ZXPbZ?=
 =?us-ascii?Q?k9gYbfw3ZykJxn2wWaF9Iybb8HtML5+StXAzi26zfdZI2UOA7b+EO3aSfN1C?=
 =?us-ascii?Q?7teLFzHFf4JTX4fZa5E/0ycKn+gj++08Gnlwplw8w47UWSGUiWTuYCpjrn77?=
 =?us-ascii?Q?QaLhr66JTGAo5kELcc6C6qLzL+4Em1Bcs7F4Ezm7bisspm8gWVm6NeXpkHPx?=
 =?us-ascii?Q?BtmfrKGo9KVSs9LpMhzlPGLhXrPEKhUyrzLhYqhUbz97a++xnbexcZ8OBKvq?=
 =?us-ascii?Q?7kA0R0uiH+qwJudc4/SXjY/1kKAMRrG35fLSoLKbvuplTnqOst/NvYFeyKMp?=
 =?us-ascii?Q?E6S8uFTXcdFxxwehpZSnQXqueSMPJ/BVILKN5y4i3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kQhVg2svWV22b9bT/TE1KqTcQ2YkNGs9zrihNVXhcqDIUFWuLtQ9NB3k7AtJ?=
 =?us-ascii?Q?Uy/EqDcM38waJkbmG396A4vMLG/Mhs4JyHXB9i4UlEOTVytHZ4cIT+AiNn4s?=
 =?us-ascii?Q?CORbcDeao6ImBGEGPBV0FvTimw62rjp8WBDQ41VO3GWh2p1HWXJmVA1kSPdD?=
 =?us-ascii?Q?r13n3xWKjQMeS/BGDA+e/njO2gHneT1CdOPk4Hpn4fLDNxVdzNY9SdZYkrYn?=
 =?us-ascii?Q?4mhEhNjkfxQdprVHsrr/wxen60SYiEJ6EqZBxBeLzvKjtDt2pv0xQXhBEbwW?=
 =?us-ascii?Q?lRmwyaRd8KkTH7xsYkyLEfkJSf/UJwTy0ZGTubFpP/su487LiNPhywndMKMa?=
 =?us-ascii?Q?yE482hau0MO1Na1aMcUycY87JFibx2F3ongsoS+yKiivQEeLJ4UMCUH+bzGQ?=
 =?us-ascii?Q?cUk5Sr3oOrgW6V/cwx6tfkPcFlMZfAN/dbVCre1i21Z1yFE7CK/u84H0mrYJ?=
 =?us-ascii?Q?JBIOZ9/TdW6qT7QHBY5JXRUY890EbLVX1L0HQdL1TWKwp5a9ws4+DlOpWA2N?=
 =?us-ascii?Q?oUC+A3O2mJhrC3AzyQyinwLxDwQtNE273e708qLSS3XvTThoQAqWa5NOfqoN?=
 =?us-ascii?Q?86rWXd6yLWyRTyot+TUzifDqGOZNtdhm2MlGo2d0aSzvWUFQk04+cnLjhW+G?=
 =?us-ascii?Q?IHml/vKoOZ1AP1mRAC/SMw/eLenRgnESCLPEpJezBBHaQFA9ouuvTF1JQ/zT?=
 =?us-ascii?Q?vmvR9HNNHChSf3uBzoL9u4A4K3vpnpjQWm5az3VO4Lt78Jo62f37eAgt35Zx?=
 =?us-ascii?Q?GoaUYg2ZqWv8jFKXG3qxC3svF5hSm9rH14XRca7OFb7feSk2ZXKggdz4FNU0?=
 =?us-ascii?Q?H84jabQ6nGbWG++jNKpH0JxNcdmO9N1HdSAAYjXyhdhgiQzttMoA39bHg7sG?=
 =?us-ascii?Q?6Xhtf6xUcln8cZhn/Eg2wXnOSXvXaZgUyao1MfYterqeexpfo9GeO/Gfl1AW?=
 =?us-ascii?Q?DPgZNEVoDL5gTN/4WE4pJHhaxBVcn4uw5VhP0s43qDIJhCzMucFLuafxeSKk?=
 =?us-ascii?Q?lN/S5T98M76j7QSwRF9ioa6faP95cj0XA1UmwhQhvvLvxNzTcSi8MVXtL0rb?=
 =?us-ascii?Q?Hi3ZO7AsnKlCEKs/O7ka1xrYfoELfWw4qm3lbwEDePYTxr0qYWh0LnsqD0Co?=
 =?us-ascii?Q?QHPESF1Yw6hrO1nFOXTRnFyJYysePVA5hSh2hOPaPN9/if/3rKlMyEIpMN95?=
 =?us-ascii?Q?a+fmqAq6boF7UCe9Jlo9IdhjEMhgY7O5JeGvDyGdeNDuQW3w9rspy4/vIPkd?=
 =?us-ascii?Q?vMDJUrPTaA4VpteT6zrb+lVX1qiaYH1C11yZxl+UjLn8Y4JpT03m89nm+NfP?=
 =?us-ascii?Q?2zGuTBQCHRxqN6hf+uVuByt0fr2Vr6AgmQ1kAMOFyUVUNdK5fItWQE/WQiXE?=
 =?us-ascii?Q?Kc6g84qefVT6z8AmtLjKsJt+AGq54ZKuShXM0UOPlkbTCfFoe4/c+/zjYJKu?=
 =?us-ascii?Q?XnArHOFTw+4all08TvlLCuYz4R5upJ6z7FuFm0s1x+MWKIfEYUtu7nTxa9HG?=
 =?us-ascii?Q?GAWv6CxMZdjdtjPM1JjXVW/qrHQ7Ze4bHfnZ9leNoUDrlN8+Xj72MdG0zz+9?=
 =?us-ascii?Q?N6dNjxofyub4no8VKdFCxGSKXarND2qelVT1myUr?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b24a896f-1a41-440e-48b9-08dce246593e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:24:55.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peEIxVfm/tH8Eg7VSn7b9jfpwZ17hIzwNH03gOoXvoRfj8beftgWYmiOOvrRhIZPuDSrZ36YR0hS1XrKLu2YxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6618

On Tue,  1 Oct 2024 16:59:36 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
> 
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc.rs | 101 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)

