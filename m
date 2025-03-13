Return-Path: <linux-kernel+bounces-559767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB6A5F94A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC641682AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E3268C44;
	Thu, 13 Mar 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MxRvlNJN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51003264F81;
	Thu, 13 Mar 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878697; cv=fail; b=Z2x6vYRukApyrDPMNU5aPImoTQJQpMGz7sXfFT8/EZe5Fvq7rUzU4hFztnsQqUeyGNDY3TDFItNsNFyn6W4DgPwiXLdoESgjwzPBZyBioSWZxp7vzRwLNNxPAZCw+I0Gw/VO1lJZ+hr9OTl3Jpwz5wdI51SiIAWTC8VWJaAnpr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878697; c=relaxed/simple;
	bh=bjG52JCK2W2YpBFzdZJ6EgqbHsZIyo7jQ70EXJ1mhlc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IK+9SsVcbJjJonMScMzjPkN4ldh0K+RhwSe33E4ef1h9qdnHsHCf/HYJYUXkkMG3aCS+730TfOTlgs+PXR0u0Mjh69lTQXWqh7npUHmpMRTZB0n6ocyNoLnNXghC9irOqGzzvUUc6WZdIGfAfGRPE48sK95TlcMfLJF7tfWlQbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MxRvlNJN; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs6mJXAn6LLkgSdjwSp8OnyvMYBT1zYudD3xmDl0ZIdnbb5DZNueTeXS1B7RkATerxWxv1NDyqHCBeaPF8pKzqF2qNSYdBmbrin3zkko0Iey09YY+i04RTEDyQaZBXPxI3DhBuOGTXXTF+XYGmbUOd6AYLs4848MxYzu36ezzBV4wI31WwJbdyhIC1ncsWqkwS6CtoAEXUK0I/11VYAh18fdsl6KHEWiZuMU/RDNLm2+aoZ/DEtDqeHjvEILRQrhlWXrkA/8mE1W5ThP6QNgTvb3ZMDKS7siizmnV/a3wtnAJea9yikyhwRyBHF7To4GVLhaWSQaq6tP+qQUUx/oGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9cItI4DtxlDz8/PDxJPZFk/CoNm2RSvndJRqA2wcnQ=;
 b=bZtsImC03aTi2zroSh1xFh1WSVyZqbxPpu+kiKFieW7qcgOYac51cuAzePuiFkUY8u/7f/v9nEacpvmQESFZjOG0nl2MXcGMm+O2ppI1RqILBpgW9p89O5Y7qRUcknRfH08sM5zdtBK2Spto8Cmll77fZesu8Kyy1VBrUE1d3w33u4v8RhxDA/UUOOG7ffbWbl1JvSqDWY1vUFByIpg7pmXqoHe2KVkZyNDP9nfvz582BLsXm992HHgcE20qmLTl5rjZJF3Iz01ozFQMqnInjzeiKQG9GKLMRBkxeQia4yKC6ICBZFNvzoQVKaP5uATFP/ljZ77sr9VegK6/MSyv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9cItI4DtxlDz8/PDxJPZFk/CoNm2RSvndJRqA2wcnQ=;
 b=MxRvlNJNtkcxhntvzw8zEIKavXvWmCTxhr0MG7+2A4YqP+QArV6WHcfgxo0OQzDd759niJLLDr4Ipz7f3nUqkltXNeEkY4z15h9gp1O9JCqBakezY/YnJILEOQLSkOzHwY5VlI2tdnwlyZHa+2HHPIXnJOyI27hNBEhkIpZ42gYi6HeMlfwqFWZHMQTlFSUFPcDUAgi0iJMOhQzCC3pLfBGjWLPVh5FWk3SeX47yONefkrs1Greq/cYMhoO6UtTPH3QnhW+T//lbOFzP9V5g2ENKB00i2ARcnVsekT9PVPlQQwlIsbhq/T06aiqhRmY/7ZR3htTFQUp7LFwckx+KXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9590.namprd12.prod.outlook.com (2603:10b6:8:279::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 15:11:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:11:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 00:11:31 +0900
Message-Id: <D8F8GNNJ52JQ.1ZXW618MPFIYD@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
 <Z9Lto6tbWS0kR6gK@pollux>
In-Reply-To: <Z9Lto6tbWS0kR6gK@pollux>
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d59e10c-6a89-4a7e-b60b-08dd62415774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUM4Q1VZZXRHdlAvY2doZTkxbzRCTkRaNGZ3elhEVm5sZWJSaTVYbzNFR2Q2?=
 =?utf-8?B?OXpieUtUSTBRa2oveVlDTGxlZDNpMXZNYWkzTE1MK0RCWlc5QmN4WCtRTElq?=
 =?utf-8?B?TTZwR2JmV09mWHdBMnVvSUJhSDdvOVpOc2hHMDlxNFg3ZU0rOG9pdGlFd3RC?=
 =?utf-8?B?c0FOenFJOExNSXE1Y0owUlRiakFJbmVYZVBTRmsrOUdEY2RwMVQ5T0JHNlRs?=
 =?utf-8?B?R3dEK3ZqM25FS1M5WUtRTzhkVGNjT0cyQ0JaZlJiVWNxeU8zTDJOM2U3ZVRP?=
 =?utf-8?B?QWQwd2dmMnZORXV0ZlFHWCtiaHYzUEVEMU1VNGhJU0Z6NXQ1Y2l0OGc4YjFl?=
 =?utf-8?B?WkNMUFpUZFp1WjZ1azN1TXlzOEJkQ0JEMTd6NVo0SHQzWmNrZ1RRU1ZFc2xh?=
 =?utf-8?B?YlAvN0VOR3lFNnVibFhna1preXJ4UG5HS3R6WEZhek13aitSYXpXT3B0MWto?=
 =?utf-8?B?N2FWK0pzUE1yNHllYXJJdVJhS0pEM3lkVDZ2STRZc05sdmRWWm1HTXdDZjBQ?=
 =?utf-8?B?SUNPa2hFQnVxWG0wWmxDK2xxN283aUlPZVU3RzRLRGV4aHhkU1FrOWtkZmxl?=
 =?utf-8?B?U0hZV0FnNURMeFVlVWNpUHNWTVBsUzFxZ2xlajQ0TjFaWkdKOGVFUjBpREx4?=
 =?utf-8?B?cm45cDNEY3piZ2VXSXVtdytTcFNMeGY0Uzdxbm54dUZPNnMwcHVxSzVScXlQ?=
 =?utf-8?B?M1V3NEpSOENmazVIM2FBbVRWdkFXTXNVWVVlT0hCTy9iQ0crTWVGcks5ak9U?=
 =?utf-8?B?MFI2Qklla0ExMUtMZmxHOTVYNGhZRVBSR1Y3cnF2RUxmY0pFNy9vblJuSjd5?=
 =?utf-8?B?dWNMMFgyTUMySFlOdHFLY0FocTk5dmxNSmc3UUE5Rnk1dFhrVmpGLzgvS21T?=
 =?utf-8?B?Nmc4cGR6NUJhRGRIR2ZxQ0R3MlZIZTlQdnc4ZllGdWpTSUFjOVVXbWFrSVVj?=
 =?utf-8?B?NXlJUEFPdlZPY0JXS2c3cVl1OTVvalhrMzRHLzIvOVBpMjQ1RUNwbm1uZmVt?=
 =?utf-8?B?S2hlK1RpMnVJS3JtbFRPNzd5UTIwR0NQM3YzMnlOaDB4T3lqcFowZHdQbWlr?=
 =?utf-8?B?WjJyOTcwYWhIQUFYZjhhYlZhM2loaDZhT2JPYmM3TERHb1hCaG4vcFVubTZs?=
 =?utf-8?B?aGtSTVNCaktHd2Q3M244MXRTU0JBUXdxb3Y3K0RIaGkvZVJlNk5URE5Tb1lm?=
 =?utf-8?B?WGFHU2t5b01sMjdhOG1UNEg5Z2FuUVJZY0lERG9Pc0QrYmJhZE9kaXVLMVNB?=
 =?utf-8?B?T25aR1pvU1VOQk4vWEh1S0c1TXNOdncyWU5FOUljanNodkZwQnEyZEJhdXV3?=
 =?utf-8?B?aXNSejl6SFdVZU5DNWhrNzdiWmNqbzJxVGdERm52SXVWZFUvNkJERjAvWDhB?=
 =?utf-8?B?TGFyS3BYQjZBb2M1Y0FEdXpwSnFIVFhvSFVBUUdhTlZaa1ZFOGJQbVJNTlk5?=
 =?utf-8?B?VVBWT25Tb25JWmYxMUQySy9YaklWZzdIRzFKUi9QbjFCVGlsMzdkUWF4Mmhv?=
 =?utf-8?B?VXVYcDVhcm8vTEpybnR4NVlHVk1Lc1lUeEovbEhJemNCZU1SY2N6ZjA2VkIr?=
 =?utf-8?B?ZlFUQ1lzdmlla0lxR2ordGhqZEI3MGxzRFppNnpqZytxbHp4OERHMURnTndq?=
 =?utf-8?B?czBsNW5QSWowaDJvbGxOam54TXA4S0RWSG5XRGZ6VHNxWERIMDQ3Wlg1K0FL?=
 =?utf-8?B?bHZ0OHA3eDlxbjcrZVJYcVIwMWJURitnOTdjRXpDL0pEem44NHFwZXJ0UG0x?=
 =?utf-8?B?bXBmdmMrb2pPcXlZeEUwdnlHWGJKQVJmYUNkbk5PNTJqbVJZVk85dHBUTjEy?=
 =?utf-8?B?YklJMnNPcjhaQ05VakhvTis1TG9PRU1NSkZtYUdUWlc4NkJUblJWL0VvNGhv?=
 =?utf-8?Q?qeR81bItTzMZf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STZqQUJIeHRnS2ZDTUFyTGg3ZUdNdmhHeHNVSjVlMXBrTDdYTmV5eWJLY3dQ?=
 =?utf-8?B?TTdkZWV6N2JjYXU0UFAyN3pYdmtCbXdESTErSEZnRkR2ekYzOGlHRklIK3d6?=
 =?utf-8?B?NExLSkdlRkJ3NjAvbGVBVE42ZkozSXRsYVNaK0ZDU01nNlBaeUlNblRxVUE2?=
 =?utf-8?B?MUhWbTJmRnpZNE1zamM5bWxMME9hemY2ZkZLblRGY0xZQXZwVzJySUZraXow?=
 =?utf-8?B?eHJaRGxZNCtCT2RXb3BmdXlVTUtCM0Ntb1dPSUc5ekNNSGdoaG5GSkF4NDZN?=
 =?utf-8?B?dWduQktWMTI2U0RCcFY0blk0N1hXcm5MbEhWbVRQY083dTNlOHU2MDg2bFlu?=
 =?utf-8?B?VHhXdWJ3eHg2MGNRQmJ1ZmJDQXhlblNOQTBTSFA5N3p5WVJ5UTN3aFJkQy9O?=
 =?utf-8?B?NFFKTS9lN2szZ3VWTDNBTGRUOTJkSytKNlNDT2RtdXJMTVVkL2ZEdWFUWTdj?=
 =?utf-8?B?ekRlUE10aTB0emxZS3BPWGdhdTEzOGlYTVh3TmRjZVFxRGZDdW5ubDVVUHAy?=
 =?utf-8?B?OWJ3djZtQUlOY1FWc2t0SWE4YnlRTWxjd3IwYTdZVUZ2Z1V5OEs3Vlk4U05J?=
 =?utf-8?B?ZzV2cW02ZWxQc3I5dDhrbDhsN01iMS84QmYzeWxXQVY0OVlQb1Y0cERHaTQz?=
 =?utf-8?B?NXpodE1VakU4YTA5cGlCWGNTWUdKbmwwYnFqK1J0SjhZcW9SbXZBekJzWmtl?=
 =?utf-8?B?NE9zSGNMYUZSeVI1MCtDQndPQm95SDg5MWZZOVRtZU9QUEkrVlB2cDJ5eTVL?=
 =?utf-8?B?NUUvQXhIeE85ZmNzcjNwY3YwMy9MY21nSzZEbnFwLzNmOE5CaFVlOGxET1BM?=
 =?utf-8?B?cW8zUEdsZXpCN1Y0cGlsSlFTZzRGdzJqRE5MOUhTVzAvTHZnNGl2V0R0WEZq?=
 =?utf-8?B?ajhMcDArbnAxZytRNVE0d2hFNDF2clRkQmtNSllVZlc3TmF3aFZmYnpTOGl4?=
 =?utf-8?B?TEExRFpkTTloczd0NytObFpGV2Q4MWhFR2dyUGoySSt6UkZPRUIzTytTbjRI?=
 =?utf-8?B?MVUwSXVIdmtjVjJVRm1Rd3lMVDkrZ0hpMkZQSCtHS2lYcjJYN0Rkb2Fmd294?=
 =?utf-8?B?NitxWnVYRVBiMktJZnNBbmJGQkJKbjVhemJqUE5DS2lHeVpzOTVPYnJEU0N1?=
 =?utf-8?B?OHlLUzRrMndWQ2hyd1M3djBVSkVHY3FBUnM0bHRzOFJtaUtJQkloU2hWNEt6?=
 =?utf-8?B?YjA1cmM5ZmZVQUdnWjlSTjdhOHZyclJtZVVEOVV6NEVnQlMzc3ludnpGZUx2?=
 =?utf-8?B?VzJvTGE4Ylk1UmhxdHdJWEljOThabFhhbWlZak1YTWhLVHNVYUtRbjA2eGc2?=
 =?utf-8?B?SWx6bzV3d1d4NDQ5ZVpoSDVIdmFnVFl4SytvV0dkMHM2MElCRXYvOFJzdnFj?=
 =?utf-8?B?ZnRQcms4Rllaak9UZkZrRFVrSkE4NzRmUTJMOG9sdjVoWERyNXkvaDBUNTBp?=
 =?utf-8?B?blp2YVQyT1VKa0JIUEFZMldpbWFuZG02TWdsQkVtb3NnV1J1OFN4NitzTmhQ?=
 =?utf-8?B?U3lmMDRmamhYZUZYNUpxUkxMeXlleVAzSlZxdlB3WGFNYS9jTGd3bVloWURF?=
 =?utf-8?B?SEhXS3N3Nmlhc3VaaFh5clVONFEwVVUrMVF6bGk3ajFSSTRESFZzOG45dkFW?=
 =?utf-8?B?c25ZNzBYbS9JbllCU2V0cTcwWU1SWnRhOWZiUmJvblBEN3JPZ2VyUVRUNloy?=
 =?utf-8?B?ajN3UUVwa1NLdWZTeTRWUjhCR2xFSnl6MlBFMVVrVXp6RzMxU0NERkRpSGFm?=
 =?utf-8?B?Z0FhRS9wM0F3MDlyOUhpRFdJelR2K0RPcy9ucFFOYXlTdHJVSXFMVUtMQUFl?=
 =?utf-8?B?UTFadWQ1ZVIwYkZUanNhWWFuSnhScUpqKzhrTW9vdExnc1hPekFJL2NTVTJH?=
 =?utf-8?B?bzNta3JjV09HZGdDSHp3Smp3MWRySGJESytaZXhuT0w3b2JxODZvZHpxVUZX?=
 =?utf-8?B?bitmeDNlZDR1WU43dWpXQjBpdkRVS3NqaUZPaFYwajM2VU9BV1RWaWVLTVAy?=
 =?utf-8?B?ZlhPVnUvV0Y0UFFiYTBMWWs1WVBZMmc5bDBJd0tXUDYzWmVEME9aYnN5MlZh?=
 =?utf-8?B?UVgyUDVROExQdHo0Ykl1ZW1VVzVaWXhXbnR0L1JIMGUyMHVsdktQSmdqWkJy?=
 =?utf-8?B?LzZXbWhTN3pSdTBNRUttWWl4MkRwWEUxcU8ya2NaV25wNzJFRjc3RGdrV2ZW?=
 =?utf-8?Q?s26ErCdJJdp4COHhfZpz+qCFsTaMtSJQzAvS6T/ly2hL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d59e10c-6a89-4a7e-b60b-08dd62415774
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:11:33.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvYrD19J2Y6B9kcKnlJKq8FIZW3PBge0aSLGqB2nBnSPfF0JKcsIQNImFJMYOOOWXtqGspiFoslKnQCqYSYmhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9590

On Thu Mar 13, 2025 at 11:37 PM JST, Danilo Krummrich wrote:
> Hi Alex,
>
> Thanks for looking into this!
>
> On Thu, Mar 13, 2025 at 09:40:59PM +0900, Alexandre Courbot wrote:
>> Revocable::try_access() returns a guard through which the wrapped object
>> can be accessed. Code that can sleep is not allowed while the guard is
>> held ; thus, it is common that the caller will explicitly need to drop
>> it before running sleepable code, e.g:
>>=20
>>     let b =3D bar.try_access()?;
>>     let reg =3D b.readl(...);
>>=20
>>     // Don't forget this or things could go wrong!
>>     drop(b);
>>=20
>>     something_that_might_sleep();
>>=20
>>     let b =3D bar.try_access()?;
>>     let reg2 =3D b.readl(...);
>
> Ideally, we get klint to protect us against those kind of mistakes too.

Yes, but even with klint I find it easier to delimitate the critical
sections explicitly and not having to remember about dropping the guard
when needed.

>
>> This is arguably error-prone. try_with() and try_with_ok() provides an
>> arguably safer alternative, by taking a closure that is run while the
>> guard is held, and by dropping the guard automatically after the closure
>> completes. This way, code can be organized more clearly around the
>> critical sections and the risk is forgetting to release the guard when
>> needed is considerably reduced:
>>=20
>>     let reg =3D bar.try_with_ok(|b| b.readl(...))?;
>>=20
>>     something_that_might_sleep();
>>=20
>>     let reg2 =3D bar.try_with_ok(|b| b.readl(...))?;
>
> However, that's much more convenient and a great improvement.
>
> Feel free to add
>
> 	Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks!

>
>>=20
>> Unlike try_access() which returns an Option, try_with() and
>> try_with_ok() return Err(ENXIO) if the object cannot be acquired. The
>> Option returned by try_access() is typically converted to an error in
>> practice, so this saves one step for the caller.
>>=20
>> try_with() requires the callback itself to return a Result that is
>> passed to the caller. try_with_ok() accepts a callback that never fails.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Since I proposed something like that in one of the nova threads (and in Z=
ulip),
> feel free to also add
>
> 	Suggested-by: Danilo Krummrich <dakr@kernel.org>

Will do. I wasn't aware of this discussion, please let me know if I have
omitted something from your suggestion (like better method names, for
instance :)).


