Return-Path: <linux-kernel+bounces-362582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEA99B6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913E0B21FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6D14D2BD;
	Sat, 12 Oct 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HH+gf1/Q"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021080.outbound.protection.outlook.com [52.101.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD5768FD;
	Sat, 12 Oct 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758623; cv=fail; b=dEtbjW/rYPXqHVpSj7wO3lEx44TggIRHWa0d2unORcoefct01lHZEfz+v+HTeY4PbuGyoaBEsGfd3C8fpfQrWzOKsYz5PsB1qmiUHNZ01NHZSa/gxAOUy32++7XNLB3uw1vSeTWp2K5MmxCghG0x+5DijFMjsRfo/IIDEf9oifA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758623; c=relaxed/simple;
	bh=vQTH27tTAlCwexiROIqFxvnPLXtGAyivExTEZ7gREtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gy605pODRhDZ1I4aFTT7RGrtDhP2h66ELnMNg1cd9M6gTf2nAQ4VHd6RdmPWyslb2kVCiSk/MPl40uC+02v2OzPos16xtxZklKTEPJsORJ17IFKImqAgvBcuO3rnP7AI5LxjnvV5AcFDCgIYrkdx32vJ8s8lMVtU+sJNbrQptqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HH+gf1/Q; arc=fail smtp.client-ip=52.101.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERgdhog7IFKWpvMJOkCgJIMp616X/oFsaJwJwlTZTv37UUDTRH+rKkVQPiN/XbHoibpghvWs8LTYOEd8S55axnLM1BycF4ovNtPeogIV4Yg5lS3Kp7qMksLbrAtbWLdptF4zGF+dc1sqSdHDDumIqDamsRXAENjOXA855EJlfEoIvNfyYxiS1Wi4nIuzzu15iM5vx1L37dWIZMH36vF2/HC8uH3KUny6OGUuIre4nOGG7vQYOble1srxXjiea1HCf9VzygrbNb4ci7wSKOdhV91XWrsTRjyZGR65Z+vRs7jQA0TR8bXUxm2WbqJDC/pwz6vNOuzi/mjT2V1TBul+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y6qdDJZlG+BBj4YVKC73vdeUuqaPaNVAfSGcAFcQt4=;
 b=WiSjJIZBzFgMX2eC08kXROgAthGerHRdDII994EYpYgBgKVeXQuIQJr1UUidK/GNk5aV9n85Rk0d/4GJYcsVATpzX3OMKtiLof49e/IdNsourveXpnnaQQvalIGJMtc4YKoGJukKCtUOgdo/qTHWqqCt9D7H91xfmcmz0unfALvQwwftBQtKabV/4BHTISfjsSq5t9cU4liuwG80e39llre9/0ZzilElQIwLNuzKMPlz+xdo55XAn47zWaCJiN6c6mmiHnnq463y5p29peAkUfg5ubI7hkiZWxbcE7+egznEj76vPCbtuhZMI1yqabSr3sbaoMhfF69q/2PXa5L+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y6qdDJZlG+BBj4YVKC73vdeUuqaPaNVAfSGcAFcQt4=;
 b=HH+gf1/QLg6tCm37Qzobmf/dQ08rBE2+9hf5aaRsN5iPScuemctpFEuc9vvgRJDsxTyqg2Y2TIr/da922BDlS9fxTSZABQUgNPgEfyqXUdCiTCLjxLj9ebQxCPEPyfwcAhk2jhtmt4pMONFZExGIvxs8TJ++I8in+V7LEookmMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3668.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 18:43:39 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 18:43:39 +0000
Date: Sat, 12 Oct 2024 19:43:36 +0100
From: Gary Guo <gary@garyguo.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Dirk Behme
 <dirk.behme@de.bosch.com>, Fiona Behrens <me@kloenk.dev>, Filipe Xavier
 <felipe_life@live.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: remove unnecessary header includes
Message-ID: <20241012194336.0c9f434d@eugeo>
In-Reply-To: <20241009162553.27845-2-tamird@gmail.com>
References: <CANiq72=M+rgJGLOBeSYygQzJZa9XnVvaWgi3DKUyT1Z_Rq=1Kw@mail.gmail.com>
	<20241009162553.27845-2-tamird@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0565.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3668:EE_
X-MS-Office365-Filtering-Correlation-Id: 519867ac-4239-4807-af72-08dceaedc975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?znDfkP3Sgeak1m05WhBRFjcWsYpztpD6/1Rqg4oBBOPXxrnhPMqVFBLynF96?=
 =?us-ascii?Q?7GP7HH05Nx3QhJBDJvKbEoeE9gsLuzHB4LUX0a5jBrd7Mw6Or589Xugsob40?=
 =?us-ascii?Q?HABHFIkUvcd05BpknYK/JXas6cQrxl4j03xO9rRkiRhCdzDZRYp/IaqnL5S2?=
 =?us-ascii?Q?FgCNMrgPsxl0WnxB0NBPeQjS2vLOODpSyo1BHSVgpIG4FXm3W63v+nvbGDMq?=
 =?us-ascii?Q?R0RQQzBQYc3Jrbbgym/VTKB7raKFYZaC/MDy23yMwGe1BWOMQVKPSqtKSXy0?=
 =?us-ascii?Q?R3+byKYptaV3FmOdNWgZFRC6vYXMWhzIYDx7s0l86ZqffJpQabVGXQcTH6nY?=
 =?us-ascii?Q?THz4zpw/HGC1nSnht4HW4fpCTx25cKAIIDIyeGK8ehp9/7VyeDLqCjtUOOyz?=
 =?us-ascii?Q?0aKR3cl+n3ZlzAN8yVq7Tr7VSnJTq/rA5aq834/R01NaSEC5qgwUfOBRRSRy?=
 =?us-ascii?Q?d0CFUNPZ69tI587PIq7jutSHel9WDUdHXLeSm4VLgEPfCjUSa5TGN08yHMEi?=
 =?us-ascii?Q?8sT6f4RLiin36ZRTQ2mZ+EfmoebK342TJf1NA12q8NpXUlDRCUTWTr+aulfB?=
 =?us-ascii?Q?QsQVPvw+65PchT2eO9KuZeY2GVQw73ikvU083etIH7LbBefYULu1yj4NZlXp?=
 =?us-ascii?Q?Y3CXAX+lJHXYXTqtCRKVaiZLA8Yr/MjH8I+4TztsImap0jnCeyYNQ8XGEKpc?=
 =?us-ascii?Q?gSn3Rfhj4X6OVGIXeQMZ93skR/Oqjvd6O7lSAbgSOSImCeSNmto4jWqqXX0R?=
 =?us-ascii?Q?rI0ViT9nIv9Ijbf2MIrkfJodv0BuxWMaCR7Nl8WMRke2vDAMswBJJzSvmoCC?=
 =?us-ascii?Q?o5sESHnM1egWJGNND4xBJ1o7qeLCcYJF+t4sslW4nMXYg0ZorzgaLmdIvdNd?=
 =?us-ascii?Q?n0/hMKF2ResMGCDVVG90gWT+lcLttDkQJeu4dx3/fXM4f7jY8hYT0ArEPz5S?=
 =?us-ascii?Q?LqprO3Rw2A9VXfSsdlLLtJ4BEDP1EJRE7WBaKIlj4xPnQK6D4QbZIyX7Avzo?=
 =?us-ascii?Q?8pHtF0WAZsMnQ1916Ba7teKzaFZLvIxtDQt8zCSMhq7PXNPTvf0sSALgOKjB?=
 =?us-ascii?Q?J1wgK0UjZwaNzTBJZf4rej6N8OFLNcZrUhLUeUWVRz22XmXuX0xGuoAvQdnt?=
 =?us-ascii?Q?ROyAeoeV+S7DYKVSENPHGn4zNVfzytPWStGyOf1LKuNrQheGLZktHqO3QxVy?=
 =?us-ascii?Q?Qu1NCzD0XoSmGEs0eX3p7fPTmvU1vLdfUZj3qptdkLtu98q2nIngdu5S1CpN?=
 =?us-ascii?Q?MmHPnaB0ftDraCk7BeUG95MzYxx+NiiP6w2T4AhWSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xDR4H211JRsEm7TD1KpUimi0gIUh26W9GsHYluTxiEvpK+n0upKMhekHMcOZ?=
 =?us-ascii?Q?s/gZ/4sv15EVNrUAtpQ4fyZW3hQGEACBbjKVvFnG2jg2UhTrMuGRKEN203Rk?=
 =?us-ascii?Q?XQpkS+rkQkfejSZVVnkxdoLyoWU3wNzhcRwS5G+vifoMsA/xNzF0JFfFBZII?=
 =?us-ascii?Q?H8T8ku0TXtVDsd8/CrPFiEo8DjXh61ZkN9Dy5+a76cusDrfjM1QEz5oEJzVN?=
 =?us-ascii?Q?OLgWwngoZwtfsxpEotfmEn26fQpIdLEgWB5iLp1QfguHG8ej5UdU/7BQ7qPP?=
 =?us-ascii?Q?CQHwA6CpIvu3yukr3anmp7t1rCNn58Lfd9fdAy1toAA/sY9/0c7w4IqFb1jP?=
 =?us-ascii?Q?ntQYEQntZKfE036Sb9tBOT2hC9wJgs+UNkmZpDVS/nGcrzCMh/OFSSD+Umru?=
 =?us-ascii?Q?boZawTVGFg9j1p6POhB5d1LdLrZ+/Or/3kjO0Tb3r5xwRCUcM94TszminBAo?=
 =?us-ascii?Q?UW65G1owCqnHHyxbochzxvzdfqCnDewuIIbBxqMOomSjmRy5QlNkASzGrQQZ?=
 =?us-ascii?Q?uqdwtel74pRlMK93UL0Wr75sYyi6GeIEj+wrf84ArRY/vmgzoGzyQmfRmuZ+?=
 =?us-ascii?Q?X4EOqe3IHQ5igoJroRJ6+aOQXJpgWwyc4uh0i8rpSIAnNl/NBtuBerRDFkuC?=
 =?us-ascii?Q?p+A3sRnlDN1ww1MBaZyyv6nIdNnmziiw9sZdUQY6gSslC6f7ux1PlDYKMthb?=
 =?us-ascii?Q?CUpn8//mY8vFhyzmeHAuQQFEViL8TtZmdCjdMcQn53sNVNjPFXF1O01B/0/S?=
 =?us-ascii?Q?GnihCcZA5TP25jyzrZmJ9Ao3s1XAJwEWM+f795n7r3vG1G9d6zFH/DPwlvKg?=
 =?us-ascii?Q?lU2hSplwlsfuhKbHZQ4WrFDjJSx3ausXcMq2NsjvYQk5ZRjt6KPl4hfl4QXU?=
 =?us-ascii?Q?HO+oeW+N9Vg2Zez3z21IYrJaWrettNdgslzvAAUJ/57Y9y+199khKBGf6FWZ?=
 =?us-ascii?Q?7rICf4uBJu4Bub+S0ULWCeY0T/2AN+VjNrKxULqi6bq8ab7i+03hnMO+XF/B?=
 =?us-ascii?Q?mDV22sn/PPNMc6VsYT93Mm/T0F13Cx9RYsx8jkRaDP0ljG41XSBM/i4YKB0S?=
 =?us-ascii?Q?ZF3mXWRR03tl4ZoDZvptzTjl8yQEeYezYEdY9VHduipR/S/b5Nhq5CFlXqBC?=
 =?us-ascii?Q?zfPDO6SNmUagRAlsdBKMpgW+Ug0vOWh62O7qdSwX/l1UIzgknww5+70tAZJj?=
 =?us-ascii?Q?zVGk/TcEjYfdG/3UosFWZ5X1bIlzO9qxxtrq10nEtqi6etaPgp2bg5B0Q8I2?=
 =?us-ascii?Q?1ZfZJQE2FFjahIfUBFWtRXmCBb8mmtBCrkOnBIraIZAFPLPmjKtJt2SPMHHd?=
 =?us-ascii?Q?YC5DWvHri4auFxTO64+XGfv551dI0HewjkFXnxUFmGOTO1FOSTpYwhd5zTqj?=
 =?us-ascii?Q?4OBM9l55P0J08x8t4yULGc17E7iLZyWVZ9b/T1Phk1DmQs7JxrfzPHPVnoD7?=
 =?us-ascii?Q?geu8vRJuz8cM8R9aBrrKfMfgDSqutAvt9G/TORhzHVFLcGMQjeOutX5eKgfy?=
 =?us-ascii?Q?Kz684d47XDwEE9RRWJIoBsVVclroPX4pyypkPtWRhusCSKI4UkYIMRWyXK5s?=
 =?us-ascii?Q?V1M3UUSUUOCfr3L9Y8YJyu261oDWZPVjLw19lyDt3g59U3Bd5RG9LdP/Cum0?=
 =?us-ascii?Q?CQjwU453oH5UComUE51AGhoEuLjSrKzaCcqfYcd7juJ5?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 519867ac-4239-4807-af72-08dceaedc975
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 18:43:38.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9kxN4o9aNSZdMr8u2ctxVvCpaKlwrsO+9pzJzcYV71Ra6mRWoH4kq5AEYue2LO2bGlbVvfdDWPQNzcLQG3Kig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3668

On Wed,  9 Oct 2024 12:25:30 -0400
Tamir Duberstein <tamird@gmail.com> wrote:

> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> removed the need for these by automatically generating the exports; it
> removed the explicit uses of `EXPORT_SYMBOL_GPL` but didn't remove the
> `#include <linux/export.h>`s.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> V1 -> V2: Split grammar improvement into separate patch.
> 
>  rust/helpers/build_bug.c | 1 -
>  rust/helpers/err.c       | 1 -
>  rust/helpers/kunit.c     | 1 -
>  rust/helpers/mutex.c     | 1 -
>  rust/helpers/refcount.c  | 1 -
>  rust/helpers/signal.c    | 1 -
>  rust/helpers/spinlock.c  | 1 -
>  rust/helpers/task.c      | 1 -
>  rust/helpers/wait.c      | 1 -
>  rust/helpers/workqueue.c | 1 -
>  10 files changed, 10 deletions(-)
> 
> diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
> index e994f7b5928c..44e579488037 100644
> --- a/rust/helpers/build_bug.c
> +++ b/rust/helpers/build_bug.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/errname.h>
>  
>  const char *rust_helper_errname(int err)
> diff --git a/rust/helpers/err.c b/rust/helpers/err.c
> index be3d45ef78a2..544c7cb86632 100644
> --- a/rust/helpers/err.c
> +++ b/rust/helpers/err.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/err.h>
> -#include <linux/export.h>
>  
>  __force void *rust_helper_ERR_PTR(long err)
>  {
> diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
> index 9d725067eb3b..b85a4d394c11 100644
> --- a/rust/helpers/kunit.c
> +++ b/rust/helpers/kunit.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <kunit/test-bug.h>
> -#include <linux/export.h>
>  
>  struct kunit *rust_helper_kunit_get_current_test(void)
>  {
> diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
> index a17ca8cdb50c..7e00680958ef 100644
> --- a/rust/helpers/mutex.c
> +++ b/rust/helpers/mutex.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/mutex.h>
>  
>  void rust_helper_mutex_lock(struct mutex *lock)
> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> index f47afc148ec3..d6adbd2e45a1 100644
> --- a/rust/helpers/refcount.c
> +++ b/rust/helpers/refcount.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/refcount.h>
>  
>  refcount_t rust_helper_REFCOUNT_INIT(int n)
> diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
> index 63c407f80c26..1a6bbe9438e2 100644
> --- a/rust/helpers/signal.c
> +++ b/rust/helpers/signal.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/sched/signal.h>
>  
>  int rust_helper_signal_pending(struct task_struct *t)
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> index 775ed4d549ae..b7b0945e8b3c 100644
> --- a/rust/helpers/spinlock.c
> +++ b/rust/helpers/spinlock.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/spinlock.h>
>  
>  void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> diff --git a/rust/helpers/task.c b/rust/helpers/task.c
> index 7ac789232d11..190fdb2c8e2f 100644
> --- a/rust/helpers/task.c
> +++ b/rust/helpers/task.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/sched/task.h>
>  
>  struct task_struct *rust_helper_get_current(void)
> diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
> index c7336bbf2750..ae48e33d9da3 100644
> --- a/rust/helpers/wait.c
> +++ b/rust/helpers/wait.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/wait.h>
>  
>  void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
> diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
> index f59427acc323..b2b82753509b 100644
> --- a/rust/helpers/workqueue.c
> +++ b/rust/helpers/workqueue.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/export.h>
>  #include <linux/workqueue.h>
>  
>  void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,


