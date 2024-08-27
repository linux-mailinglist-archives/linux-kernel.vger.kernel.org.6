Return-Path: <linux-kernel+bounces-303192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979059608D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA0E1C20A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A731A00E2;
	Tue, 27 Aug 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sf/CuY+S"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2024.outbound.protection.outlook.com [40.92.47.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04B14D29C;
	Tue, 27 Aug 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758554; cv=fail; b=a8bUI8vWZf+nwHl1xO6NsdBq+Dbop7A/hg/5lOdmh4sHCt1Ardu1vrrJjW4uFrS6N5iiLdq7+8jKpuPDrhurmZAiliLvsIvyG0DGy/tC+QWjH/vkPkNJIkLc8pYD37PIzrE0yM9hjjFrJrji79Q8LHrQD/Kci6J0bSVVgAwOBeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758554; c=relaxed/simple;
	bh=vzFB3ZLv2n4geExks1YqoZU3HHnM6FBcplA8ekwN2nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJPvrWJTzU6lji5NLc3/bn9lbR/6KNxpc0mcEN5xOSRer+FLWYzDlxrXdnqMLd8JYrSwojsL97ngmdc+fMsWEk6mPcEwRmkKEfnJSdyAFJKyg3yIoXnEqh8BD2DVSaGKx0BPftdPbLkWdG9cbxWnGE7HNCEl8B0N53UdiPv05Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sf/CuY+S; arc=fail smtp.client-ip=40.92.47.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpyoVkY2/Qcgry2QLHoadZrDBzQ9uFg94i7mxY4pmB8oqsTBvwZSdsINYp0wcCeLMvRRE+uEtOjBd+e2btQKfFByb43PALEJnPCrtzjnopXnioiveOCf8XXo3fXUNtEhi8BaTwgNu0Fm+QQRoaOphQEJi/qiBWup/FKHjqSCqz+7BA/vOcOi2zgTDGCQaU2OJwJflFJeNlg5WRo+LGcfEUM0TLIc+JgdwkIzsJwH36BWiPrUjon0z2twuc6k1aSc+92oFOsmUHUv5bBmz0oogHZVRfkQVOGnl9G03ZJsa9A9d1xZuZZz5ahMcEEWWmyHakANyToH+rvx4u887c2f2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL9ALtdsHqGaO1a09Y1TAsJGYWHUl7rROAIise8KV/I=;
 b=Ye6d/gzk8j2z+HG+Wh63zsyBpV3slO/QXmHriiW1BM0G6isTq6Vk3MATppmA8PfXdenc82UyJbO+CWUauDuQJy9+TvOm7ZRAMnJzHgIOPAfNe3fhFi4p/jmiGqYIFqhPkbehZh5fiQpMF3YFuA167ay0cywcRa5e/nes1A+j/OTT+SHJEd7+YZGXFx1LMKFtUgxdrx05GgIAuwZOd0AzWnwExuTBSt2+IBxoz5a+qDzmJChEsasO1exhPV3ug4RttqjIsXz2X8noBQMPnkC0skr5U3MP2TwoQKcZPZRum9y1pr+vEk/M1e5u3xmkQZNVPnMLbhrrkA7+aRKOQbqNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL9ALtdsHqGaO1a09Y1TAsJGYWHUl7rROAIise8KV/I=;
 b=sf/CuY+SbNd2kAiba3spPmTj19Sezo56OamQP0mz+f6ZaA8UKRqdWByihjEY4wL9B1JMKic4jYCGylZs6m8x0U/VoB2vOYTpR1leh2BGaqC9iOqoVJQfRNlRJ/30Ldf8iVV04cFL917gFxRCVgy9xGRP0hx/k/VOtE+h+bxD9Yeetn+P3lUcix6PxxnAQKuC+HXhS1u1WNjXxYj/Rjwhs/PoMCSI2IV6lowu7tJH06gsuQLvzdgyqZ8/rtOTV59AVHsacqxtW/lgeRgAZDC6gtSwOIX1p3eJDqz4b6dXDAhFoYTQMwfvChfeN0sMdITZ84o0c4KrQ6kN1vtJ7PytYw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7037.namprd20.prod.outlook.com (2603:10b6:610:1b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 11:35:50 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 11:35:44 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v11 0/4] riscv: sophgo: Add SG2042 external hardware monitor support
Date: Tue, 27 Aug 2024 19:34:45 +0800
Message-ID:
 <IA1PR20MB4953A509BE6FB7E05590E3FBBB942@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [U7DgGyrQalc7TTsTG8pMr5l5QTyi56JY88DcGqbfdh8=]
X-ClientProxiedBy: TYCP286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <172475845236.1309337.9432886632005176363.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: b4aa3f51-e042-4799-2b06-08dcc68c62e0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|15080799006|8060799006|5072599009|19110799003|1602099012|440099028|3412199025|4302099013|1710799026;
X-Microsoft-Antispam-Message-Info:
	THuzMoXZXz6t+Np69sKKuHvHXO4mpIOhwizpEfygBVJKOD2QMlAF3ZX6f/nyp7PGNHuALyktKrHmy/w+tQp+OLyDMdu0o1eWkYtFFf2ErQJ+2m2suhhIKQa5Q8cSMjiTzqL8ZwvTxcedmuiCKkVvFxEOvQefw5p4yvortS2xK9233PDuiotjxPG5jf32lsvDHtTsihK1qQsrAgDUNfcpD9xW1ONdwnSxwSbKv5rwAhiqwLLWz1vMHhlceHi0dKVpZ3jkvosINOzr4qLoMdGzSY2thoxLK17x+glfevWUXQerV3oh5U1J+5uL8HbpIXELGiiKgI1wLqT3Ece265gGEX48ZJ0BRoy/iFvq5F+kgcArxm5VHsDEepSjIFU8yhWPjGCHPjvVaghzTJ4hoIJ0sIquVGX/HKnczOaKlkJoUqLplNFkHV06sI8gMv0AAYQrbklBqHdV1OODSNSX+3XMQSEYNAfuj8Xl2nIRESoyZtKtXvh8IWQms38VEbIMQ0/ihm4NSS4FiK6Q5FYof1S8Dp31pZ9vHX4HE/XdBf0U+LC2bRIra9RlbcTwuAINOaKpZFCUOgLI7c3I0nvEmH4otyYO8kCce3x+JpvvgCpSInWi1flaUUIZZvMPmxa+j+elQBaubyJPh2O3JtjmuQUVWyPE0NoDJhfsmYb3QPMEEbaMZQxQvS6ZDSIGhB13No8tYMf13YiGbr2UN1Y66nxCrY5tKnvortTqZoGIRwfnpt5JQBJ6iUeGciIwjMfFhNP3HtlOp0/64P2yzNkdP5PLuqQbyqxQGnAN7hvl8Wm5c24yxe0WwzrBwLRmihHseHDY+20EgUDcLyQexcSdxzfL9O6y6fhpKWz3zI6LyLnGVWhMQHIIvLeyMOxwIbiuwLtu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0FPU2ZzWklFKzE3Uk9HQzhiZFd6eXZORTV4d3o2WFFIUlZHM3lqbmZzM1c3?=
 =?utf-8?B?RTFOQW9pcVZIVzhYL1RwTXhVaHlIVDJ1YzllV1RaMDVsWEMySCtRNGpXTlVi?=
 =?utf-8?B?cXY0TjR4RDJJZ01rdkRjVTV2LzBYbDUzNVYrSlFtSmRnUE03YktIaGt5U3Zk?=
 =?utf-8?B?bUhUdG95NzluZzY2WUZLZ0c0TjdoTCtYOEdmNUthWmVPVEdJYUIrR2kvelBF?=
 =?utf-8?B?NSt0U0hSS2pDT0Z5bDNuczd3TFA1MzZjY29rUkRwTldGT2g5OHc5MkpiWTJS?=
 =?utf-8?B?UVJKSFhoMDRzM2F6VzhrTGxMOC9wMWtocThIUVdUNVRNMFJFTlZ6aHFoWXVN?=
 =?utf-8?B?ekw2WDl3WVJjK04zaWdtZEJtenVQa1JCZ1h6aFVxSTRBSllqcUFTU1RHMERw?=
 =?utf-8?B?QkpRaTBPeHplK0paYy95aWFEYk9Kck1lQWpmUTFPSXZFTm9ha0p3TGdLVGY5?=
 =?utf-8?B?dXR0WkhGVDJGSXo1cnc0RWJPcytmTlUwQXhmY1MrU3BaQjJvZjFwT1REL29r?=
 =?utf-8?B?elp3Wm1IZXN1RnZ6N3VuSmtTWmx5ODFMRlFaOHFoUE5iZUdSeDVYT0pTRTFZ?=
 =?utf-8?B?QWUvcGpHU0VGUXFqd1dXN01MeTdBaCtvdmVYWlVvWGhTNERmWEw1dzhHK1BC?=
 =?utf-8?B?eGViOVFpbTEvWGZFY1NDMjhuU0NXbStrZ1dNQXN6UTQ1N0Q3cjJiOS9MYUdr?=
 =?utf-8?B?Mk5GbkY5ZWlmaFRwVUF6ZGFaRGtsTUpUZ0JKZHRkY3I4RmdtaHljb0x3amlX?=
 =?utf-8?B?c0YyU0M2YXlGMHBidzhTeG1HN2UrKyttd2Q5ZzkxMG5yb3FCQVdHWGJ6c2d4?=
 =?utf-8?B?VWNSQTdHek1jTTc4WXI3a0RlQ1grb01HRVpJc3JvMHpqcVY5Y1RKcUNPQ2ZZ?=
 =?utf-8?B?Zk54akVRY1lRTEpEWVYzZDd4Q0MxNUpXend4Q0FxNy9IVnFOUmhXN2FFVjMw?=
 =?utf-8?B?QjVTbzY2Z2NFT1Bzd2hDYlNFK29OandscnRzVitUYVhWd1B1Tm9TempOcDZF?=
 =?utf-8?B?cU96d2FHSy9kQ043Zm42RThsUTVpZUx4Q2RHRFZ5amE1MnlvMnI4WlI0blV4?=
 =?utf-8?B?aitGWmNjcnV3TG5tQThKV1Jld09pd01TbUt2anpueWFHNFV4SnRyblJHMito?=
 =?utf-8?B?dyt0dFhpTEd2RllCSmkvSEkrVkJYRXlKbkUrZlV4bXAxblBIN1BVeFVRa3Bn?=
 =?utf-8?B?OTNBVnZONEpHTjIwcEUxNXkwL2ZETXc3ZWQxUTlyQnZLdWN4dlp6N1ZPY0Z6?=
 =?utf-8?B?ckFCMjRZYzdJQ21LVEhqalhleWlTZm1zeURJSUMrN2NjaXIzYmdTMGJDY1FG?=
 =?utf-8?B?K3RxYXBTZ3J0YmpITVYraE54a0hIdWdQU2pKcXZaSUtFVk04cSt0d2tscm9w?=
 =?utf-8?B?YnVMRGlYKzhRcGF6TkQ2TXJMZ0wwNDBwUEoxYWE0TERUeEVucCsrQ1paV255?=
 =?utf-8?B?ODBIRXY1RVVNTWN3U0lJbkp5MUdSZWNYMDJNRkhXNk8zck1pL284MWQrY1FI?=
 =?utf-8?B?Rm05UGtUMWt4a0RDOUJGQW5hNVMwNkhtMFc1eVNsYTRSYndIbDFaSXJ4ZnJP?=
 =?utf-8?B?QXhjVG9sWU1VK0M0MnJweW1KQ0VkT2NKK2d2NzByVFhzd0JDRm5zdk1lbmlo?=
 =?utf-8?B?Zm5tejBaQ3NHTlIxMkFvdUdvbnlqV0E1dHZzUTd5OEJYSnpTd1F4Tm1UczhH?=
 =?utf-8?Q?rm2sCZT6fXqNek4MwlNH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aa3f51-e042-4799-2b06-08dcc68c62e0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 11:35:43.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7037

On Sat, 17 Aug 2024 10:21:59 +0800, Inochi Amaoto wrote:
> Add support for the onboard hardware monitor for SG2042.
> Can be tested with OpenSBI v1.5.
> 
> This patch is based on sophgo/for-next:
> https://github.com/sophgo/linux/tree/sg2000/for-next
> 
> Changed from v10:
> 1. fix the hwmon entry permission.
> 2. remention the extra entry postion in the document.
> 
> [...]

Applied to sg2042/for-next, thanks!

[3/4] riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
      https://github.com/sophgo/linux/commit/cec3f1940b60b057142bd11f7bd421e13d198f75

Thanks,
Inochi


