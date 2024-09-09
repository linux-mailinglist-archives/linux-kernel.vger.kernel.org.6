Return-Path: <linux-kernel+bounces-320956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A2A971279
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85ABC1F2335E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6301B2507;
	Mon,  9 Sep 2024 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="zIrbgie8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22317557C;
	Mon,  9 Sep 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871634; cv=fail; b=DDIPiODBGmNH8qIfkeHDUykk6uxDF0wdLyDc/FMM+2aMI8l62cZkWmH2ftbyigoBGMItWZk4Dp0APBOZx9PhcfD2DgAxEKAh3m51CkbneR5zCX9o8mNuHMM/6nUwt4rNXFBLhLxbrGNSkH6b46eeKVgvbfr/DOO1cJf6fjFJYTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871634; c=relaxed/simple;
	bh=U94dWL8NJRZI8JZkHtHqTijOjZtOjKm6Z17C3GQ8znk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2lqx9A8Pai04uTogIvVRxOz8eHgh95/aK3C0eCJitMNRUjn60kxAruDD9pPx7I5mVVE1xdhf//7UoQD92pZyNN8Vz9/EyCqMB228BBcUSq+IZp736wxyVaEgAKT7k1z5FBBpHFEA3nsNMnplQ3/dNg3Aj6JQnHB/+DB/c7vefY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=zIrbgie8; arc=fail smtp.client-ip=40.107.117.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv/QRyWHGSMp2vfVVRjtUbUVd8n1s2wzjbegffCjouF9gx+4n4ek9afn9FEGcXjSBoK0NdwJcRbsQF1MBQMqT+E8TPy/k5iIOlg4YqaCiFL3ul8W93Obla7bVvEPTFlkjXlPWwf6rNbXzYksPNU48PayN3xapfRSYAcO+1RJL5l5Aypq24nHlKq++sBK0RJ/E9KN2jupv65VkIi+do7MfOO3bAxSn4zINfv9UPrxC+YCj8qDzVRMwW6XBzoid0OC7/OzCHZiq2+Af0+zN8cvN7m+r6u1UZ1EM/H2I1hxUFAhrhu3E4gEm/ycFj5ZGXWUZ/EqL8QKXFmvvdDHgPzUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVU85tWqUelWgvEuUouZ7Dhi2qiH8/B/6xzU7kYY5/k=;
 b=bvsXuF8eErFIJHTaioh10AfVr0zdHaQvKq55HRy5aYIYJB3eqI9Qku5ykIgQD6sIV+dcsb3aPnOR9A2tix2BMpkx6BN/d1WICQ6F2sOGNSq0rP5smAwBHOPIQDN2cjQTq069D/I07gpeaQSN5wT8nZcmsGwg7qXXMeWzr6a6kjRyKdCcvocwCulaRuHqvsmcrs8zgXuEQrsT9GBKmPsajyezj9qsW305b3tbfwT1TJNoGZbjP/e3DsqhUJP8UOC1XXOdBvEzfG847OgX5WujiQxUoSy0Rgruf9R8RGrJZRhPWL/cpx6X1eEy9yhzvWpvtYSQzU3nGYMtSFlGjtOmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVU85tWqUelWgvEuUouZ7Dhi2qiH8/B/6xzU7kYY5/k=;
 b=zIrbgie8RG6rgbm102rV/YOSI/kpoyzmT7xXXnnnvDmGdenEd8H6ICOxdfwuy82HfchypZ3dTIbkckI0/F8oxQzRX6JHtGkFVaDUg9FJxN+m0O2pVZk5EZ1QqyV2svf9WiZLENj4P4sSkUFhKRM5kPQt3A3NSaHESJIIx9EnhL5TKDA2B77GCxP7kfx28Ha0EuPT8Z+flOvm53euY313TgFckLWFbeTzD6jZ+etxZvJY8fVPI9J8uLQBb3wYt8J+8jPZI9L6N9hOlX1MUrr8/kUDacm+SU40fcN/mg7yb5GZuwHH3AYjgN8aXZFPgdepNihLJmSJzqJln2zkWtVrHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by PUZPR03MB7063.apcprd03.prod.outlook.com (2603:1096:301:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 08:47:09 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 08:47:09 +0000
Message-ID: <a84c8ffb-8eda-434a-834c-a023563ac8cd@amlogic.com>
Date: Mon, 9 Sep 2024 16:46:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: meson: Support PLL with fixed fractional
 denominators
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
 <20240906-fix_clk-v2-1-7a3941eb2cdf@amlogic.com>
 <1jjzfpqb5a.fsf@starbuckisacylon.baylibre.com>
 <46c55bd0-0076-4eaa-8b12-0e28f650e5bd@amlogic.com>
 <1jmskhtgv1.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jmskhtgv1.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0243.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::17) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|PUZPR03MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: c359e92d-ed37-442f-aa99-08dcd0abfd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmN4eEVRVTJ3ZHZOZkZldDcwQ1Vud3dQRmtQTXJXeElrS2Q1WTQ5U1luazk4?=
 =?utf-8?B?dmNneVRKQjh3UlNIYzhXWVRPUzRCTlBveDFCVUkzUFhCVmFvUlRGQnN0dHJX?=
 =?utf-8?B?SlZTMDdvR0oyR29wQzRFSFNvU2lFSzBYc1ZhTWxCUGpVbVV1VjhCRyt2eExV?=
 =?utf-8?B?ZTcvMmRnbjN0aFdjR2hVL3U5d2V3VWdwYkRnUHY2STV1dm9nbDhUb1FSb0VM?=
 =?utf-8?B?Qmc5YWVJK1NINE1BN1M5R21xS2QxU29QTDVHQnFKQnY3bGxnb2sxOHpjRExT?=
 =?utf-8?B?bk85N1JqRmhsRktrREppQTM4b2VhaTVoMW9TbDRCdlg3cWxSdjBURVZueHA5?=
 =?utf-8?B?SmJpTi8yY2tOUER6V25KQlNFaDlETE9lVnBJSjYzK29iam9VNSszbGZ2b2FZ?=
 =?utf-8?B?bkNJSmpqeWZuUzVnNkNFeFAxNElXc2tzTTJsRGRhNzA5Y08zc3JvMVRJU2pY?=
 =?utf-8?B?V1ZvYVhuczFGSGJCOXVWbjJqVm13MmdDZ0hDdEFiSlU3S3dCTzl5MjRETGVZ?=
 =?utf-8?B?REh4YnpiTERObmVEOCtDWW5FL1lOd09qbGFmZ0hJVUFhbkxCTzY1QzlBNjBv?=
 =?utf-8?B?NGpUTWVDQmhrTWJjQjQvaUZkazl3a3JUU0Y2ckMwSERmWm9FK0U5OStWVE5q?=
 =?utf-8?B?UGYwNDJzemlzTXkyNnBPdFJSZ3JHbmZRMkRkTVVpNWI4QnVJbmZxY2RoRGUz?=
 =?utf-8?B?ZER4aFUvbFBYYWphUmgrSUF4Y3oxNnpvMjY4Y0R5MitIZE5mdGx4eHNyVE5i?=
 =?utf-8?B?UzEwU1FZVUJhVSsxMEFkTFZKdzFVY2NuUCtpNGhuQlJFcUN3eHpWNEVUY2p6?=
 =?utf-8?B?UDA1dS9SWUQ2S2hvUHIrLytaQTJ5aVY0MlY5bm1zNkZhaTVhcXlyRXl0d0JS?=
 =?utf-8?B?QjZNSmZCVTBBa2hWeUlzSkhyY0F1RHdmNk8vYWlTUEF2ODVIWHAyVmpkRjZR?=
 =?utf-8?B?Wis1cUJONm04a1RDcURwYy96bmc4TlJzeHRKVEdaa2xjckZHdk13SmFEWk80?=
 =?utf-8?B?ei9VSkkzZjF0MEZKcUZGbFFTYnZYRTZXT0c5cXBTbGJoU0Z6djJwa1RsSXVu?=
 =?utf-8?B?aGdjM0djdGlmS1I2aHdMYmJVQ2dTZngwaEJCckNrWEdLYU85OUlrMWsxbjl6?=
 =?utf-8?B?UE8vR1pncmYwVmtQR0F0d05iNGNhWnVrWFpZUlYzODBRMitUSmdzbWtsclFX?=
 =?utf-8?B?K1NsWHhORVMvbnRYUllwL1VLZ1Q4SWNoY0QrWG1lNDNQdDRDZDNJTHBiOE0y?=
 =?utf-8?B?RXpKRjk5TDgwWllzUEo2R1NEclVCREEzMU53cU9PeFpZbFFJaU90QitLWWxQ?=
 =?utf-8?B?NU52S2pVUUJHbjVYdjRwZmdXRVJnVk1md3IwcUJScVk0YlpqakozbjhLSjl0?=
 =?utf-8?B?NFRvMldpU045cDVIN1ZhVS9VYlRTdEFtWG52WWQraU5hSWRmNzJNQUg2SU1L?=
 =?utf-8?B?T08wUVpXN2xVLzJlMEpqNytYUVhqUlhmRTRJeGRQODV3a2NNSzd0alp5em50?=
 =?utf-8?B?Yzg2ZWJvZlRYVkRMcUpUYmVWakhpUld1eUwrRFp2N3VBMUxLbzdwUk5NZEhR?=
 =?utf-8?B?RzZDQlRhOWF5c2JMTlYrQXNRdTNacVozaFZERXpUNDdUYzlzcVFuNkQvcUJM?=
 =?utf-8?B?emRvR3U5SE5COFNlRGQxYWZ3ejNheWJ6Sjg3N0Y1ZE1MdzRMMlpFbUJ2N2Qz?=
 =?utf-8?B?bHZYc1V5cGQ3clE3aXlYWHp2VlNyNTdrUnc0K2JSOEQrTitIMlNSbGlvMndB?=
 =?utf-8?B?QUZBbnFjNmFwV011ZGI4Si9PKzFLM25vU3hmeTlDN2JDNlFHNzhPK1oxUGp6?=
 =?utf-8?B?NXA3T2d1eTk1R0ZhdUFmdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFFwOUpQSkxRVGRUTGxmbGZJeVQxZTNhdnVVbys2RmlVanJYMThZeUlZVE1y?=
 =?utf-8?B?YzBxVW9OdHJrT1p4Y2tkRDRvbVRzRGV2MUR1amlBV2ZyTnc0cldVN0dLVXpq?=
 =?utf-8?B?L01QTVlRa2l3MDVjV3VZbzc0eU43L056L0VQb0tIUEVXclp3WlgreG9rTlRX?=
 =?utf-8?B?RzJQZEovS2pQYm94MnZNSHlKNjIrbTNHSy80Q3lJc3Y1dVQrOHdwaEdHeGU5?=
 =?utf-8?B?OUk1L0c5a05BeFh2cng2anNwL3JBZ3NyNWdtNVV0ei9MR3E2Wk84K21EcG5t?=
 =?utf-8?B?VkZxZk91VUNLa05qSUh6V3c4Wk42ZzNab3JpZnN4UUpvTnlPaHp5OTFHV3d4?=
 =?utf-8?B?RTdTMUdSVXo4bXFOMVhUeDNaZktkN2dXcGpaaitjR1Vadzhvby8wYUQrT1dp?=
 =?utf-8?B?emtJTFYyclM5N3VJMEovUWlrSU1vWnE2VkJ2eSs2S1o0UEF3QStxcjlreXlG?=
 =?utf-8?B?ck5TWFNOZmxVS0dlakJvTzEvcTMxMFF0ZzM4UVdlS09DRnpaeTA3R0xFZktJ?=
 =?utf-8?B?NEQvWElzRVp2SklFRjFiSzZUYlZRdkpmeGp5OEIvRFN1bG9KNTlySU8rT21X?=
 =?utf-8?B?VjB6d0NTd1JUUjdaQmNjUHRiK2tDWERqR2prNWtoTkM5WEFHc2lhenNaUEht?=
 =?utf-8?B?c08xQS9Bb2FCalpyZGtMak9LYk1UNmpJandQbWRNQVdQWHhhcjM3bmpVUGZF?=
 =?utf-8?B?cjlyYlhnQnk0bDhJQVlEVExRbytDUVBuWDFTYVFZRk1mUmI5R005OFA5UU1k?=
 =?utf-8?B?QUxHYjVXRmErbFVXWkt3SkJueHB3VytNUTVUWWlyYkVmSWFPU2h1NWRVZUtz?=
 =?utf-8?B?aXJ5dWhRRXY3UjlucTBKY01paHdxdHVsMzRpaUJvaU9xaFMvRk5RQ3c5bHdK?=
 =?utf-8?B?bEpIMHdvS2xWVUZseC8rN2tZakczTjhVUi9TcUttTHUwMHd3UFpmTk4va0Fx?=
 =?utf-8?B?bXl5RFpuM1hwcUVLUUhoWjFKN1JpV3B2ZjVGSEF2RGYvVXUwSEJBa0xpRHl4?=
 =?utf-8?B?Vy9vWFh2NXg0c0g1MDIzeWxnQTBnckNFVUF0N1Yybml0cjJPUFlLMFpYMnhB?=
 =?utf-8?B?R3lwdHoxMC9xMGxMU2JtRE5sWGdOUCtPQ0RWWkx4YllOV1huV0NSR3ZpUERB?=
 =?utf-8?B?c0hOajdCWDJBT1N1WHIwSVNMQ28xc1ZqQjFrUjNjWnE0SGpTcFpuRE9QbmFq?=
 =?utf-8?B?dWdSTFRhcVpxOFFza0dBeXF0VGZXWTF2cG1henBnM0k1SWxFUlhiVSs3UFVF?=
 =?utf-8?B?dlkvTFl1ejJuRUk2OWw1Q0ZwUHFORXcrRHluS0xWYjY1Rjd3OGNUZDNDMkRD?=
 =?utf-8?B?czBJVStONGtDU3R2Q1ZmWHYrUFZLRjJ2azNzMUdjM2xXeWJLejhKY21OMEEz?=
 =?utf-8?B?Q2RHSGV6U0ZUNitmK0lTWGZyZ2JlRjh1Q3JxWWpFY1k2UTFKdWpKSUhMOCtz?=
 =?utf-8?B?bEhXMHJnRzNXakIxQWZISXJPdHF1amhtenRvUGNkU3NyOWh5ZkZoS29PNzlM?=
 =?utf-8?B?M21CQWVrSGJVNGtIOVJZTE1rOVRhSnhaeGY0QjRjbi83bDRXM3ovWE55b3dW?=
 =?utf-8?B?MzJ2MFpLSk9HYnloeW9aN2NMRzVUQzUvTmF3RFBaY3Y5YjJTcmttWjZNa2VI?=
 =?utf-8?B?SjlIUTh6b3AvUkd1ZnBLSFhBeGRMSmtCMVhHUXdwZVZsczA1VHRoYnRYd1FR?=
 =?utf-8?B?UVNoVnJqMTlHb2V6RUYrZnJ0bUQ0QjJOUDRFNDJId2o4am9TVFhHS3BVd1dD?=
 =?utf-8?B?M0g1L0k0Y3BmZzdTU0ExYVVWNWp5Y0NWYzAzaVR5ekx4Y0hhSnlvTkRib205?=
 =?utf-8?B?bFc2YnY1MlFYY0NYUDFYUXlsVEU1OXRZdTFpY2F0a0RhMjBJL1dWb1hESHNm?=
 =?utf-8?B?MTJOcHF1VllqcGdIcGw2SENwcU9SYTgyQnhnSXg1dmpFeWlnV0RKRWFqVkR3?=
 =?utf-8?B?ZkZXMHIwMzlUTlN3dXl4TTFqK0hvOW1RdzBOVTdIYWsrTTVzWS9WY1U5TUVn?=
 =?utf-8?B?QmphYmg2Skt3bkF0NE5vQnNMdlZYYVBsRmYxSXBCYWdvUnExUmxEVndCQW05?=
 =?utf-8?B?VDYyVHFmK3pLTUxPNVRIOUxtN0tFcjBQZE8vdUs0amVwZ05tUlJrK0ZNK25r?=
 =?utf-8?Q?fFAj/IwBIWXk5EU9ToBty4XlA?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c359e92d-ed37-442f-aa99-08dcd0abfd49
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 08:47:08.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l11JSKrdnGXecapANfyR03vVcmrS/nWcxJhVmkCwuyXuT0cJMAIinTIzBTxaYazn12k60I8fQ0CvL03P19ccKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7063


Hi, Jerome:

         Thank you for your meticulous explanation.


On 2024/9/9 15:40, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Mon 09 Sep 2024 at 09:55, Chuan Liu <chuan.liu@amlogic.com> wrote:
>
>> Sorry, I don't quite understand this one. Is it because you suggest keeping
>>
>> "(1 << pll->frac_max)" here, followed by "if" to determine whether to assign
>>
>> "pll->frac_max"?
>>
>>
>> "unlikely" is used here. My idea is that it will be possible to determine
>> the value
>>
>> of "frac_max" at compile time, which will result in one less "if" judgment
>> and
>>
>> slightly improve drive performance.
> I'll rephrase.
>
> Please drop the 'unlikely()' call.
>
> You may add that :
>   * in a separate change
>   * if you really really wish to
>   * if you provide profiling numbers for the different supported
>     platforms and PLLs, not just the one targeted by this patchset.


Okay, Understood. So you suggest like this?

static unsigned long __pll_params_to_rate(unsigned long parent_rate,
                                           struct meson_clk_pll_data *pll)
  {
         u64 rate = (u64)parent_rate * m;
+       unsigned int frac_max = (1 << pll->frac.width);

         if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
                 u64 frac_rate = (u64)parent_rate * frac;

-               rate += DIV_ROUND_UP_ULL(frac_rate,
-                                        (1 << pll->frac.width));
+               if (pll->frac_max)
+                       frac_max = pll->frac_max;
+
+               rate += DIV_ROUND_UP_ULL(frac_rate, frac_max);


In my opinion, this change seems more logical, but the amount of

change is larger?😮



