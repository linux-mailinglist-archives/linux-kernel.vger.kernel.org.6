Return-Path: <linux-kernel+bounces-291278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B984956038
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF157281A54
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21D2156227;
	Sun, 18 Aug 2024 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rMnx5D+R"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021110.outbound.protection.outlook.com [52.101.100.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F231A291;
	Sun, 18 Aug 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724025406; cv=fail; b=usMEwNVyGq7p0bOJvdFueLseM1onq4cp9MTBPRTU1cFx3EZycCn30uk9uBFHViiDC9WcC5xJ9t8cfpDYCs5wxbKMwoNaDGftfW1JN3lggzTAV4o/+skoLkGRNGKSM+wICl/ZH09RR83LOgsW5ss2WAvzM8OTlvuwS+MYRVoUa9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724025406; c=relaxed/simple;
	bh=7pGoMrXEPMXt4GbDcWNU6M3hbfhjVA+RxSpLNjptr9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BuU/0wM9NlbwuWSftTZTejSBjFPCiUscffi+O7rA0sIZBaDniG3Y0cTMDnh5yn1GA1mNaqUT7d0PPEvAQN6W2K5uq2XrQMbhdWZI6wH99ah5AzsuNdQBXin3rYqac1c5vRNSdt/HemdmrRAIl0nELeDzS6GhQhwdav67s6mFz1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rMnx5D+R; arc=fail smtp.client-ip=52.101.100.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nri6K8ZaNtT1ovDd3fYbzr3caat4RZOxFWV8LdHslvexKl9srJnf1g6XJOGADpc/lxQzKvUrUmMbkCDTGvWkYqxFIaxWZQ4F3K1ZW9ZOPiZFT2z6kSLQZgXBCjWeTugn0i8h6Kn+1onuTqMkYMjPnGNDBiFTZ8uZ6cFcetNvvzB9YSGdiLYPwP9Ta9D3+I0JfQY5h7jXDWN4H+lJijIylA+CgBxRbibBpoGzbu3gowsT489NyspzjDtYxVW/RLwST7SQ9scbijAbmJAHI/gj2u1xFI16PrXjURHLExb8/VtCOKWA9g6JENyh6+okmA+oWhZ6gDX9XYqwc3TXF5zKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC8B2SjJLAsIYORyCqT1biaELYy15U6a9bSJujuoTVs=;
 b=Mpieki3CiKLS9jukYjtolltjnoxHlm3f5XxgPCaPCEjAnWWHY4bIYUt1gOVz21MXO97Z7Qz20ufw19xRrJhau7DBW5qf+ArsEJPrVUiSzWHrbybQu8/PfKmxhxciuvOdlh+66239TZHkxvRGnhNPvSkMOyswu/yibM5asgJnBURD3HRngSiV27lhFPbymPiLoB6uIecryNQWRxDRUC4LPIm9U5XClBVhiCitPjL2bnNtyeiwnI4V52YF6YASsYjFU+DswwQWHWW0Yaup3OtERJbp8mMhPskgYDHPuN/9fQfSxXuzCe3ljVEj4Lk4OXFQR3Kl57/e3MzJUPzb/pKd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC8B2SjJLAsIYORyCqT1biaELYy15U6a9bSJujuoTVs=;
 b=rMnx5D+R7ievlOkiQGgso23OvjRsxHuMk6guOgPAd556PIk4ZzHhYIIhkueTCVZAJGowzJvnBqXffSdeGiz6WsNQWa6JoQUPLFUcCLAAi1whpvnI+/p6UO6SvGn8Tsbi5AH6oc2UJJ2Hb4B8VnKi5A6MUGpK4fEAO2YmGC/IdO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2190.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 18 Aug
 2024 23:56:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 23:56:41 +0000
Date: Mon, 19 Aug 2024 00:56:37 +0100
From: Gary Guo <gary@garyguo.net>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, Dirk Behme <dirk.behme@de.bosch.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
Message-ID: <20240819005637.47e7045f.gary@garyguo.net>
In-Reply-To: <CANiq72k81VrS+3Skh7gfYzkcxTsGscUJOhroV4MXH-LZgroZFg@mail.gmail.com>
References: <20240817165302.3852499-1-gary@garyguo.net>
	<ZsFEpjvE9osKDb3b@boqun-archlinux>
	<CANiq72k81VrS+3Skh7gfYzkcxTsGscUJOhroV4MXH-LZgroZFg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::23) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2190:EE_
X-MS-Office365-Filtering-Correlation-Id: add68e7f-a565-48cb-5599-08dcbfe16833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekZqSkJCMVlFYkZZaTl0N2l3ZTdYTUFyTlZSU1JSeG5jZTJhWmRKc09FUld0?=
 =?utf-8?B?dnFZVjEreEhyZGFkTFo2RDJtUVNhdVlZZWhSV2R5Zjd3Wm14YVlRWkFKOWVN?=
 =?utf-8?B?Q0Y5RW1SVmthVGtUNjF1STJTVk14aHhZeHFFMVl6RVFzSW9HaTNLZThrUFln?=
 =?utf-8?B?bm54b3FpcTB0WE5Ja0g0RWZrTHNEVG5KQ2l5UFAyUHIwbE5kcDdhYVRIZjdQ?=
 =?utf-8?B?eTRyUG4vbHk2aFZwUk9FTzVmTTkyazlrUHpadDJ5aEdZUXVxK21HNytaYkhM?=
 =?utf-8?B?VGoyVVBpTmhMSlpWZTd3Q0hxRzd0NWtrZEJaSzdXaGVtT2V0QTdHM1JyeE0w?=
 =?utf-8?B?cnllWSt1dFljbUVTZWhpYlBnc05QcFoxbWRiZkN0eHAxVzV5L1FxdjJNTGpr?=
 =?utf-8?B?bHVmZ3JGYnhlV1M3TC94Z0M2Y0l3NUtMZnJodEZUVHFRSXNOaVBrd3dZaEtD?=
 =?utf-8?B?S2U4VlpTVWo0MXAwcHgyTWI3ZmRacCs4UGExa08zMS93ZTFrSDB0OGErWUI2?=
 =?utf-8?B?Vk0wRkNNaDJqVGxSZURCd1N2OFhNU0xFMzNQR3NZVUZTSDcrOE95TnJKZzd6?=
 =?utf-8?B?M0VzK3hvK3Q4cHpKS3liNkdnWTZnYVhITEtmVU9Nd291SFJnaTVYd1d1bEtD?=
 =?utf-8?B?TmtSdERJa3FzZC9qQnBmeWF2OHlSRXJyV2V0NThVNUdjcE5LWm5lT3hQdm9Z?=
 =?utf-8?B?eUd6MGxXZFdnUCtuZDNMN0lWSUl0T0VhTkhOQ0g5aUsxbHg4L3ZGS3FHMHlt?=
 =?utf-8?B?L3c5V3NoRUw3a3N3dG52bjlHQmNwOGFJZ0UyZENhWU9SMytCVUFxZzY1Mmpt?=
 =?utf-8?B?bzdSZSszNE92U3RNdmF6UlZwZnJ2UVd3WW9KY3IxQklTTzdhd1VKUkplT29n?=
 =?utf-8?B?SXloM2ZKSWhXM0hDTlE2aGpzdUcyZXJ6TzkxdHVBclFKNzR4cmFNTzFCTXJK?=
 =?utf-8?B?ZVJ1NktrcFErQzhta0FhU0xnRmNwa3BQZEZnSEgrQ1pjZnUvbTA5TDFCZFBn?=
 =?utf-8?B?bjVzVFZjcFlHZ0NLamN1dlJ5dXlnRjNxQmU1ZzFqTEMwTmpCd1B6Skw5Z2R5?=
 =?utf-8?B?cTYyRW9tQVRaWnZoWGRsa2xkU0toK05nRGtSMC8rMjhPZ1lsWnF6NUJCN0xi?=
 =?utf-8?B?UVRxNFNoYVpkcWZJSHV3dzYrRXNWRHNWYXdYR3d1SjRrS25xekhyeSs4MnRF?=
 =?utf-8?B?dGZhUDIxVXBLT3YrV3Voczl4Z3hqbFRDZ3VLU3hIbU5LZnpmbTMvRHgrQ0lF?=
 =?utf-8?B?SjUvcThKbmFqMmtMelFyRWhJQ0ZkN0FWTlh1N1VYVGthOGxESEV0aElJS2l1?=
 =?utf-8?B?NGhGa0JuS0g0U1hKNGRvM2UwdzJ3UExocGtNeE8rcjAzUWNDeXJHOUJ5UzVN?=
 =?utf-8?B?WFZ3N295dWF0c09lWXJQN2JnSzhBUmZGbWNzQVRzMWRjRWFvdUFDY0dvT1pT?=
 =?utf-8?B?TW1XNnhKVElYZzdLNityWDl4OEJISTBXRWtBWkVoMUtTQk4ydy9wVzJvL0Jh?=
 =?utf-8?B?Y0lXTDBzZUZxK0FYdkllMHp4ejB4YnpKK1diUzNDTVFEZ1hQSTlvd0NIRWRI?=
 =?utf-8?B?VENIdWRFRHlXRi9EMGlSMnVTWDI2RmRBYjZ0S2RPVlUxN0o4WjlLMmx2bEhr?=
 =?utf-8?B?cGIreE1wbVpQdmNYQTZaQVpjd0V1UW11ZTFXM0VHS3AzNnlLL3FSNVFMVCs5?=
 =?utf-8?B?UG5uWE11bzNRSXB5VWVZbmw2VVl1Q1E3ekJrVnpNOUpIL0lZM0E1ZE5HOWFo?=
 =?utf-8?Q?eWxG16l+bxHVDTzwxs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUJ3WE14ZW1BU1U4MjRQQUg5ZHpFTUFEV0Q1b0RRaHlOL1Nqc1hsL211emVZ?=
 =?utf-8?B?aTV3WXFBZmc3WmZnNUJUelhDL0lhWGxqYmNURzN2VlBSKzVaTmNUb0ZRRzRR?=
 =?utf-8?B?WWdncng1U0lkdmNLWkxhcWNqUUNON2FXclFuaFlTMWxlQ1AyZ3ZJN01JTXFC?=
 =?utf-8?B?U3pmaEVvUGRRaUNYRDdsRFE4enpXRUNmMVlPdDBweSs0RFdGWm9XV2RRYWl5?=
 =?utf-8?B?UzEvUmJnY0dzUXVGQ2NKZmpLUWFzbCsyVTRDNldITFYzd2FSckJabldmYjdT?=
 =?utf-8?B?eDNOU3Y3dWpOdkk5TzVZZUpJTmxRZnl0RCtTM2ZpU1hJTEN2QlpRRmJUM2x2?=
 =?utf-8?B?V3dGQlpYUDg5VE15RXpMTldkaVNxYzFubEIyZDJtVkZLYkZ5WXI3RlVuaE5F?=
 =?utf-8?B?eWh1VTBGejNWamh6WURHRjF6Wms1RDVRTy9WRndrMkdWWTdxTlRnYTA1L3Fr?=
 =?utf-8?B?dkpOOTRIaXhHNWhrQTJEOE5oSE01R1NHQWpnSGJjUDd5QWxXUUNrSk9Mbzk1?=
 =?utf-8?B?YXAyKzJwYm1kckZ0cFZIVitwRnpyTUNRYkJ6WGIxMGZEV2FPZDh1M0NvTzI1?=
 =?utf-8?B?NVR5UzN6R0FNdTBrVjlDWVlPTG1Gblh2SEM3Tm83WVhmbENDcEt2alk5NHBN?=
 =?utf-8?B?TjlCcm1hRFBGU3Vwd0xhY3p5djVxQ0tibjVjNzAvLzF6Mk1Xa2xWMHVNd3Vw?=
 =?utf-8?B?M096Q1F1NU9sTWFvR1REY0s1RmgvZ1pvVmdESGRuSktiOFgyRnF2WjZEdFZl?=
 =?utf-8?B?OWh0MnErdGVnckRubE1vVG4zZUtQellFWXNEWWx5aVYwTHcweVRVSmNYTGVR?=
 =?utf-8?B?dVAyYUxMQUt1Q0h5UCtLdW9ic3FyZVptckUvODNzZlYvQm1zUExNa3hlN1pB?=
 =?utf-8?B?RFkwYTFmRU9KVlVvZkdWYW8zQnZjZjA5em5YazVITUxvVlo0b014alptajJJ?=
 =?utf-8?B?N2U2K3IvazY2ZFZDQU9XcTRsUWpmOXJ2ZzR4aGF6dXhtUHZ1Rk4ramJFeWZH?=
 =?utf-8?B?S1hsdEhRT2w5TU5HUmpXRldvQWpRaS85ZVRzSWY0Z2Fjd1BYMUE0dWxBVFJ4?=
 =?utf-8?B?bXlXZGk1OVBqSlNHeDJOUi9PRjBNK1VMTnBhaFg5TWRmSHFaZnduV3lCeWRt?=
 =?utf-8?B?SHpzYXRUdXlSaDk5QUh2ZWhVU05IYnNTcTFmSmFBU0V6WlFheVZUajRDK1Nl?=
 =?utf-8?B?MDE2VzU5a0tNOHhlSnlyQkJiaE44dDdSQ2lqVXZlemZPN25vUjRQMGJ0RXdK?=
 =?utf-8?B?czdoczR0QkwycC9LVXZGdTY5b2VZcER1ZTVZZXBtUmxONzNUZ3NNYUxnTTA5?=
 =?utf-8?B?ZVFhTk52SGJpZkJWYWE5RDdSUWRNMkZ1ajYxOVI0dUlTWVV3QWpKYjlFQVlI?=
 =?utf-8?B?UnFmWkxFdTkrcWhQZ2hSTVdENmNxNVc2MlpTYjkzV3laNDRTbWZnajlNMVY4?=
 =?utf-8?B?M2tIT3hFZ3NMYzk4NFQrMWs1SVhwSy9vQUlLZVVNaUtzcWlRVUxHZHI3a0gz?=
 =?utf-8?B?U2JkZGZCbjJ0TTBlWDZrbWxUUENKOUx5MlVnZ1VTWDZxVEZXRWxoTGJPYytN?=
 =?utf-8?B?TG4xbFZNcWQ5VVdOYlY5MTUzSWR1Y3pQL1I1WEZtemY0OFJsSGtIeDZ0U3Nr?=
 =?utf-8?B?MVVCWW9WcXVNL2FIbFdKV0d2WUp0OWlPUE8yMzBmUU5Ib2FPNFFNTjRBUFJT?=
 =?utf-8?B?WnhKNXpTSVhEd2s0MEdEaDc2L2FnVENEVjI4QTF3dlY5bmtxWG9xMCt6Q0J6?=
 =?utf-8?B?T0NRKytTb05UN1IwVGlIS1pwbkg4Qkk5dElZMkFWZ0lKMUZQS0FOTGdJRmEz?=
 =?utf-8?B?aEJWNGhCL2ozdTdjQVpVd0NuN0g3MG9vSk9ZYm80M2NSVnVkYXVPRk5VS1NM?=
 =?utf-8?B?NFFKUDFoY3JENWk0aGdMZUVCai9XbEJUQzlla0ZLM1o2U0lnbkJTM3JpTmlh?=
 =?utf-8?B?VWNuYWVVc2kxVjFubUFOSjVHWFlMU0p3MEIvczc5RFdkaGQva2QwMk5GdVNB?=
 =?utf-8?B?NXgvQ1Z1T09XM3BGZ1Y3M0F5UkJibmE3T2swUm1rSDBLMGxtUmxLZnJyUDh6?=
 =?utf-8?B?eDBNVXFzYUkzZmNneU10OGJORlk1c05ENE1zZFpmZTN3QTI3VllCdXpYa2lQ?=
 =?utf-8?B?Z01IdkNHeHFPdERhSXEveVAwcSt4Mmk3cElLb3h2SWJQdy96MjNXSHV0OE44?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: add68e7f-a565-48cb-5599-08dcbfe16833
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2024 23:56:41.7917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6YLtgGV1EbeSm19u5XjoJl9LAvwSHEHOo9FtbukNdaKbODQ3XINAARsZLEfJuLGrw5irBhEKgyur/IQlMS98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2190

On Mon, 19 Aug 2024 01:40:44 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sun, Aug 18, 2024 at 2:49=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >
> > This also passed my test script (x86, arm64 and riscv build and kunit
> > tests). =20
>=20
> Hmm... I think you either tested another one, or you manually fixed
> the dependency (`$(obj)/helpers/helpers.o`).
>=20
> Or am I confused?
>=20
> > Miguel, I think it makes more sense if we take this one and the
> > helpers.c split one as early as possible, given they are treewide
> > changes ;-) =20
>=20
> Agreed, we should take it soon. I have rebased it on top of
> `rust-next` and fixed the dependency.
>=20
> Please take a look:
>=20
>     https://github.com/Rust-for-Linux/linux/commit/0d6e3e8d3677ee7b5cccf9=
bc002e18f140c02a4e
>=20
> I will put it in after we confirm we are not confused :) (and after we
> get a linux-next round or two for what is currently there).
>=20
> Extra `Tested-by`s would be nice!
>=20
> Cheers,
> Miguel

Hi Miguel,

It's the mistake on my patch. I noticed the exact issue while I was
trying to rebase my helper-lto patch :)

I believe that reason that it builds fine for me previously and for
Boqun was that we didn't delete the helpers.o generated prior to
applying the helper split patch, and we know that kbuild is not
hermetic.

Your rebase and the fix is identical to the one I got locally, and I
can confirm that it compiles fine for a clean build.

Best,
Gary

