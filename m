Return-Path: <linux-kernel+bounces-275814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4BE948A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2621F21BCA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224916A92D;
	Tue,  6 Aug 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Iy55KWM+"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2058.outbound.protection.outlook.com [40.107.117.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDA166F0C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930062; cv=fail; b=slONPbQ3/+1mmwpCvw4H5wkxsfGV/1m7Zhjjc1OiiyxGVEdUq+hGUpLhhHyBnZAQ8u9q2JJUstS3rs4YHqaOXGKF/WwQOJ7xRw3mUlHnhz4ZSwpKsbLIu7ZDvzefl1UqP7atmQO8O9CfVOXdOtRAwQE4CMJXjbFnFYyddve6frk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930062; c=relaxed/simple;
	bh=Ln0P5uzisqbBNERZdDARkN/o8a/W3iG341XTr3j99hc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyJKKjJYyvmyMhEHlSZzhF5h9rVT8cj8JJNjREvBNNms8sN0OEJMg21teQMEoaKdHe35VJiCgRGWvEkLb0o/IPH0PcwpsQjhOz/GJSmlho7mYwlWMV/PZslttbvIT1EeqADCuu92+Zqz3iJt9XhCFVESiaAA5J/L3DppQTMQRIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Iy55KWM+; arc=fail smtp.client-ip=40.107.117.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZI8UxMGIc9zh7MWz5Oa/gTIdaDd+xZB6LZXJwhzvu8rZiAm2Xa96dC3OQpGql/eldexZjgSSKk8DNRHBxu+5YM1aMEMLHN7Tw6wS4dFq6gju4IpK9c/ym2MgHFYUP7v4CTxIHI3giweJ6PwgxPt84/p1CGj/3VdCni7WBIw8ZwDrzdGXl9fJqYLCg665YtKRgfj81bbMx894SwAGiq4wUN1DZ1Mm736cOjzrX6io0BBf1Bb9D+7Y7jPzP3296qAmK5/GkVG2M2QfqKM/R46merMQb9fTFlPU7Fxca8XeeXjQ5jwXneBCHm4m0s8bTZmN/qwDD0Zfj2PGN2vgh2q9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz86QmxXDTgxc9rQqJ98jKrldrLjnzp4vukHKJdnpLM=;
 b=r5XlE/aI6/qu1bHR1Yqba/05u1YJXPQ2EP6sQTzyXN5sp6UErf6rp6bO2qgvJAcyvdR9QoYT42pEVxyQot3vEL47DKNZ1JJJNCUZpiXr94t2jji7wiNa3n6qTPjWfmglR/la1h+wc5iDkICIxsMJmPNU0NAuT05+ot+mlcpnpIJLGUQucEZmtLbSLrT4wYH7ZPCDUyOIsb4DAc+Ds7m2cHe3WS21t5ETJbBYBo35qdYEYTgXKoYvV+rI9E2jTNDt7Tr+V08wgkBHJ+GAFwtkK9N5W8SUKxyAaJyeFvHivq3pD5YsLRfvfTvHZG60ZOtGXSpuplbNvywBMuEsJ/fYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz86QmxXDTgxc9rQqJ98jKrldrLjnzp4vukHKJdnpLM=;
 b=Iy55KWM+mrKIB5BEuqzE6ldsQ9qD++uUsmyksxGUZ4TGIr2JaCQzvaVJdP9OJ+h5q4huyCqovP4lvJ0JYYiqKoP6eZoqA79fgM14K2NYbIdmeuypuu/GD3epgZK2aQwL3OI8V2rkGC3SqsC/nGf98j1V8Vou14uqA5u4M76dpVuw3UuT07+13nS99pFAgQ/TKNw2y5Aw+eadYpuVLEmDbbex0MWmJdPi+fYtG/u12keQyAmKH1stxP2Dbc+6mw06oyJO0fm36MqwYAmEPrpscLZngQkz6w0WVv2cfVEI4cYg5pGf0bDr4X8ViwUyCRYL6BKr+nuNnPnb8ZgyocMf6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB7143.apcprd06.prod.outlook.com (2603:1096:405:ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 07:40:55 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:40:55 +0000
Message-ID: <dee6bf7c-ae73-435b-a6d5-ae966dfec048@vivo.com>
Date: Tue, 6 Aug 2024 15:40:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: swap: mTHP frees entries as a whole
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>,
 opensource.kernel@vivo.com
References: <20240805160754.1081-1-justinjiang@vivo.com>
 <CAGsJ_4wqENiGf4FoEKA2yO5pmu3SfJD9qsjHD0E7eHPZG1+PuA@mail.gmail.com>
 <3699860f-3887-4a99-b9ef-10e3f86ec3bb@vivo.com>
 <CAGsJ_4zNd5oCG1vpWRJxOQgPRvyO3AbjGM5nt9SxGjm=YTcrdg@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4zNd5oCG1vpWRJxOQgPRvyO3AbjGM5nt9SxGjm=YTcrdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ead9b1-60e2-47e1-00eb-08dcb5eb1b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDdxeURDTFZoY3RmT2U4Yjhvc1lpd1B5ZkpFZGRIUm5tUFlhT3NsemcwZ1lo?=
 =?utf-8?B?STZXVzNmQXJnSUNNT3djUXdJRnhEUkxGRTZTb2xGRnV6ZmRNYXZKeldxOHpy?=
 =?utf-8?B?QzZ4MEU1cVNVbDI3QWNtZCt4OXJvY1JDbkZDTmlSdnlYa1FoSi9BQ2JOdS9z?=
 =?utf-8?B?TXRlMGZmRkRBMGxTUXQ1NVRBWWNBTURQR2Z0TjE0VFhCbEJjT1UzdTNlR3Ru?=
 =?utf-8?B?M1RLMld6cHVzS0wyOE82OWlWTDBlaHpHYTYwRlR4aHRrcnlxNDBhd0E0Lzl4?=
 =?utf-8?B?MzYyK1Z5dTd0ZFN2RUdieWJHSzN2UHZ6ZzQreU5FMDU2Qmo3QlBOSkoxeUwz?=
 =?utf-8?B?ckZjQXFtOS9SMHJGY1JsTlVUdzlOYTZqbWcxeFNIUk1NbGplNDhad2pYaXkx?=
 =?utf-8?B?dHFYTGpibW4yUlcwRmVXSmUwOWp6S2VYZThaN2h0bm5CUmhJdERPN1NkV2NP?=
 =?utf-8?B?UVNNaFZ2d1E5ZHBwUjVsaDdhV0ZlSjExS2RxT1FZYkh6WEhiSWQrNU9jVkZq?=
 =?utf-8?B?Y3R1MkFCMWplTWJDY3B6ZWdpaENoQ3Vwcm1yZkZuenN1bG4vN2gzOWtFVEtW?=
 =?utf-8?B?ZVVYQjdrQUVSdjFLeFdSTVkxYndwNThmMURCK3R4UWtYOW9YS2hIcG9HdnpE?=
 =?utf-8?B?QktvLy9tdkxMdW5Ha05xdlRXeFJlcWZtL3BwaDVhVVpaY1gyTzF4NFZlNnVF?=
 =?utf-8?B?TkE0clFkS3FmSk4ySzducE1CbDZzbjZOYmlCY3dZU2Mxd2w1MHMxTUgyajlJ?=
 =?utf-8?B?Nm8xL1FPVlRYdUJieEI5SitnNm5vR0FLZVFIcWtiYmFMbGlFcEphTUh0a0VL?=
 =?utf-8?B?ZEJDSUQ0YmtYSlUxem8vbTIwQU92T0poTDlubDQxVXdKN0l6K2haNEdZeEpp?=
 =?utf-8?B?VkErc2tXZ25MSkVjNmxLalFaWmJ0bGVKb01kQzhwU0wzTnZ1QUxYOWNtOXVE?=
 =?utf-8?B?azFSaVVxdTEyYTRHbEd4aG04UFhPRFJPUXA0KytQaC9mdHhtSGU2OXNXaUJT?=
 =?utf-8?B?SExrcUErblYvd1FxQWNlWE1OTjFwWmFEZFdleVkxS3huUWhjTTV3SmZIZG1o?=
 =?utf-8?B?WEN1SUYvNldZTUZ5Yk50UDRPV3RmdENoRWJQTEJsaWFEQWQrbUZ2N1JmcTZD?=
 =?utf-8?B?L3BDZFRWQzQ1MVJpTk5qelRtNXQ4NkFMSUgrTmlXYmNwWHV2T29SOFU3MWZy?=
 =?utf-8?B?c3VBbU5aQWJxQU5SUEFrcCtSUERyWXhPRDR3dUNoWUVGenNJMFB1VkdYdW1h?=
 =?utf-8?B?Q3BHSEgvdjk1SytJajJOVm5FejlvSnlqUjNqRmpJRFk4WUtTbnpjTWNZbHVP?=
 =?utf-8?B?akc5SkFLVU1qUUJHSnVtSVNuRktjTEkrMkZ2SkRLTHhOQjljZGVMZDZuZGQy?=
 =?utf-8?B?OGtaZHNpaGphbkRnV2poRWpVSzJBaUx5cTBUZDNTN0Z4VGRSSjRtV0FVN0Ft?=
 =?utf-8?B?U2NXbCsxM1MvRHRVQ1huL1JYbVA2a3ZtUlQ0RU1GeXYvckJZdk5PM1UyNHBt?=
 =?utf-8?B?WllHV01ZZFpWbmFLa2VkbzNWYWU0ckJCY2RxRHdjR2g1Yk9HTmE0K0kycU9t?=
 =?utf-8?B?K1ZCOUtGQzN6c0FiT1d5K0dwc1NLbTZQbE5BbGVzK2t1STVKb1NvSkNvckdu?=
 =?utf-8?B?cFh2UE9SM1pXeUpxUWJqSnEwSXpiL0ZlU2ZHdWowbExjSFMzeG1Yc1Bsdlh4?=
 =?utf-8?B?Nlk3UUJldm5STjUyZnYwTTRFS2N1UFpkTlJYR3pVUGhyaXpMWVN0UmFOV3Y5?=
 =?utf-8?B?U0dSakp3U0c2ZTB1SEZmWlpTNmJXTDlWbE9LWnAyMGw1SWFJUndrYU42VVor?=
 =?utf-8?B?SXJQSGNScFoyVmRmTjhmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWxWRlBoTUkwVVZiQ0M2YlZEY3ovT2Njd1JvYTUyVnZzYjhUUVphUEJsN3dL?=
 =?utf-8?B?QXYwUzl3dXN3ejR5SFM5T3dSQU40azlxb1pDZDlmMmw4ZFVsWTBzcVUzWEQ4?=
 =?utf-8?B?eXRielY5blF5alo3bVZ6S0h3T1hGTlR0eTVGVGgyR1ZRaFV1ZGdENjV2dE5U?=
 =?utf-8?B?S3Fqa0ZIM3dpNS9zSG5SWjErcCswKytkTDVPWEs1VVdNcXlySFBDZ3k2ejJw?=
 =?utf-8?B?V0tRTDJ1cmlxUzBQbzB6NkZkSWRKRE5ISDZwL21ZcjZKQWc3N3daNFJhVDFM?=
 =?utf-8?B?LzliR2pZSEE4VUN2dE1zQ29XaGFFZzl3NnVPSzdHWGJZcTlCbHorOSs1U1lK?=
 =?utf-8?B?cGdvemUzU3pDQ2lqOFQzZ1F6MzlSdnBXampLaUNoWERzRllhbkhXaGxUYk1F?=
 =?utf-8?B?ZGFnWGp1aW0wc1BRRGJMRTZHYzBnNG9kTlZjUXJ1cHl0N01JNDBSb3N2b1RB?=
 =?utf-8?B?aFVZeXM2OFJIaVdGMHdvd3FHWnF5VjRqRlYrZXJYQ3luNDBPVFFJZjZ2YUs5?=
 =?utf-8?B?UE1sZzVsMkhjSmY1clo4VEh2MzkxS1ZqcnQ0UEpXbzdvdE13SzU2MlorUlB6?=
 =?utf-8?B?cEJlcUtEeDh5UUlxaXJjSldlblEwYm1SRVdhc3VZT2lBV0lGdnArZCt0cWtH?=
 =?utf-8?B?dkxkWHphM01JZ0d1bTRTanIvRldMZ04zalV5aXY2NnFoSDFkY1YxSVZnZS9Q?=
 =?utf-8?B?VDBhbVdNZVVwelgrbXVyYldxZVZ6bks4R1R5QXRyYVovYTV0VzgwRW40dytv?=
 =?utf-8?B?bTBKWFB1M25aRy9tdFkreDZObmNoWndPclJEb3JZNUsxMlBBZE1ScVo2RlJu?=
 =?utf-8?B?R1JQN25zaitMQjdodHVMeEZ0alBTK2hHRnBwQm82bDVGbDhnK1FacEx5Qk9a?=
 =?utf-8?B?YlM3YTl3RVhNUldxMjlBVldnU2xaV3VPV0pZNThRaHZTQVpNTUpyVTdESUJB?=
 =?utf-8?B?V1pOaHJ4Tm5qTUxhMXlLNEFWU1hyK3VkNjdqK25mc3hFSEVaclZRamZmVGFi?=
 =?utf-8?B?RW9ubEtEblpIUjFQcGloTHA5NnRldkpHM0pDaVZjcVZmbDFTaUs4YnliVlpN?=
 =?utf-8?B?YkxmTEtPSGFmbUdSOFFsVGV5U0RzU2lUc0ZGV2VCV2I3RU4zajE2K0RKdkIy?=
 =?utf-8?B?a0MwVXhkcWtPNlFPbk8rUW8wRzNMVUl5WlRFbnZUM3k4Sy9sKzJ3SGdjUE41?=
 =?utf-8?B?WXhxSUY3enh5RnVQOEJHbFMwZ1JCVSt1MzdjM3o1YXlHRzBSSHZ6blJDejgr?=
 =?utf-8?B?SW0zZnF2TFJpbFJ3RmxpSUcvb0lGVDMrYkpFYmpURkRNMlpVZFBrYVdzT1dw?=
 =?utf-8?B?bUtUVFFDb3pkemw5S3kyeWpIaGlZc2xZZ0RvT21Oa2d3bHVENkxTZFE0dWlj?=
 =?utf-8?B?cCs1dmptYkJZaWd2TVUyVmpWMlBNV2RIWG9NZ1MvWEJVRzRLMSsyT3ArRUpC?=
 =?utf-8?B?UlJIdWtTL29ORFV1dmY2c0owMXk3aklocXo1QjVLYWVtZ2lNODBHOXAzaHdP?=
 =?utf-8?B?VS9INlZQN1BObWM4ZHJYN1plQTREbXh1cElOQUdzTDl6M2JVbG40NkEzOXNm?=
 =?utf-8?B?dHVBaFZHQnJaRTV0bWlFYzV2ZmhDcUlaZ1JSWFllRkxqaVRNTXppNDFTVEt2?=
 =?utf-8?B?WnIzc1dSRDhmenJDak92Q1l0cW1tY2ZvSXI0ZGlnMHUzcU0wcWRxZzQ5RmdU?=
 =?utf-8?B?dVJkM3JsamRhSDY0clA3VnV4Q2pTUzlEWFU3M3BZRHZUVGFrTzJiUmt6U1Aw?=
 =?utf-8?B?STY2eS9sRk5GdXR6VmdOTHZ2YnlWU0lQbjlWS1FzenI5aFV3eGt2aHQyTHgx?=
 =?utf-8?B?blNhUUc4T2NBMEV2aXdCV0tUZkx0bXc4N2xHR0FiTC9HMXdHcU4rUnJVR2J6?=
 =?utf-8?B?MVgzN1FNVHhxZHpZOTF1TFNza0c1MlhTT0hsNk1pTlNSdk8vVjAraFlwNXR1?=
 =?utf-8?B?cEFBMGlkdnRNVWozM2dmcy9jL1I3V3l1SE0wWUkyMTVRYk50MDVCdUJ3aFg3?=
 =?utf-8?B?bFBkUWdUWTJOOWxlM2ovc1NwOTNPL0tUZEcwQ21maDJpMTZUTTVmYngvc1Vr?=
 =?utf-8?B?NFNtR0cya0xSS1dzSE84VUVxNGhuNjlMODVWNTI5b2dobzFUSkNRTlJ1VkVu?=
 =?utf-8?Q?pUjtXvZbtOBkLXEJJFnVvFkmc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ead9b1-60e2-47e1-00eb-08dcb5eb1b1c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 07:40:55.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcy+GDL/d74BlSnYj3Wm9ymEesjx3Fjaw2yx2oW181gqYzJn2eSdF0CRNpBCnh46oLY56/cW5r/wgLQZOWwZ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7143



在 2024/8/6 10:07, Barry Song 写道:
> On Tue, Aug 6, 2024 at 2:01 PM zhiguojiang <justinjiang@vivo.com> wrote:
>>
>>
>> 在 2024/8/6 6:09, Barry Song 写道:
>>> On Tue, Aug 6, 2024 at 4:08 AM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>>>> Support mTHP's attempt to free swap entries as a whole, which can avoid
>>>> frequent swap_info locking for every individual entry in
>>>> swapcache_free_entries(). When the swap_map count values corresponding
>>>> to all contiguous entries are all zero excluding SWAP_HAS_CACHE, the
>>>> entries will be freed directly by skippping percpu swp_slots caches.
>>>>
>>> No, this isn't quite good. Please review the work done by Chris and Kairui[1];
>>> they have handled it better. On a different note, I have a patch that can
>>> handle zap_pte_range() for swap entries in batches[2][3].
>> I'm glad to see your optimized submission about batch freeing swap
>> entries for
>> zap_pte_range(), sorry, I didn't see it before. My this patch can be
>> ignored.
> no worries, please help test and review the formal patch I sent:
> https://lore.kernel.org/linux-mm/20240806012409.61962-1-21cnbao@gmail.com/
I believe it's ok and valuable.  Looking forward to being merged soon.
>
> Please note that I didn't use a bitmap to avoid a large stack, and
> there is a real possibility of the below can occur, your patch can
> crash if the below is true:
> nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER
>
> Additionally, I quickly skip the case where
> swap_count(data_race(si->swap_map[start_offset]) != 1) to avoid regressions
> in cases that can't be batched.
>
>> Thanks
>> Zhiguo
>>
>>> [1] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-5-cb9c148b9297@kernel.org/
>>> [2] https://lore.kernel.org/linux-mm/20240803091118.84274-1-21cnbao@gmail.com/
>>> [3] https://lore.kernel.org/linux-mm/CAGsJ_4wPnQqKOHx6iQcwO8bQzoBXKr2qY2AgSxMwTQCj3-8YWw@mail.gmail.com/
>>>
>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>> ---
>>>>    mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 61 insertions(+)
>>>>
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index ea023fc25d08..829fb4cfb6ec
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -1493,6 +1493,58 @@ static void swap_entry_range_free(struct swap_info_struct *p, swp_entry_t entry,
>>>>           swap_range_free(p, offset, nr_pages);
>>>>    }
>>>>
>>>> +/*
>>>> + * Free the contiguous swap entries as a whole, caller have to
>>>> + * ensure all entries belong to the same folio.
>>>> + */
>>>> +static void swap_entry_range_check_and_free(struct swap_info_struct *p,
>>>> +                                 swp_entry_t entry, int nr, bool *any_only_cache)
>>>> +{
>>>> +       const unsigned long start_offset = swp_offset(entry);
>>>> +       const unsigned long end_offset = start_offset + nr;
>>>> +       unsigned long offset;
>>>> +       DECLARE_BITMAP(to_free, SWAPFILE_CLUSTER) = { 0 };
>>>> +       struct swap_cluster_info *ci;
>>>> +       int i = 0, nr_setbits = 0;
>>>> +       unsigned char count;
>>>> +
>>>> +       /*
>>>> +        * Free and check swap_map count values corresponding to all contiguous
>>>> +        * entries in the whole folio range.
>>>> +        */
>>>> +       WARN_ON_ONCE(nr > SWAPFILE_CLUSTER);
>>>> +       ci = lock_cluster_or_swap_info(p, start_offset);
>>>> +       for (offset = start_offset; offset < end_offset; offset++, i++) {
>>>> +               if (data_race(p->swap_map[offset])) {
>>>> +                       count = __swap_entry_free_locked(p, offset, 1);
>>>> +                       if (!count) {
>>>> +                               bitmap_set(to_free, i, 1);
>>>> +                               nr_setbits++;
>>>> +                       } else if (count == SWAP_HAS_CACHE) {
>>>> +                               *any_only_cache = true;
>>>> +                       }
>>>> +               } else {
>>>> +                       WARN_ON_ONCE(1);
>>>> +               }
>>>> +       }
>>>> +       unlock_cluster_or_swap_info(p, ci);
>>>> +
>>>> +       /*
>>>> +        * If the swap_map count values corresponding to all contiguous entries are
>>>> +        * all zero excluding SWAP_HAS_CACHE, the entries will be freed directly by
>>>> +        * skippping percpu swp_slots caches, which can avoid frequent swap_info
>>>> +        * locking for every individual entry.
>>>> +        */
>>>> +       if (nr > 1 && nr_setbits == nr) {
>>>> +               spin_lock(&p->lock);
>>>> +               swap_entry_range_free(p, entry, nr);
>>>> +               spin_unlock(&p->lock);
>>>> +       } else {
>>>> +               for_each_set_bit(i, to_free, SWAPFILE_CLUSTER)
>>>> +                       free_swap_slot(swp_entry(p->type, start_offset + i));
>>>> +       }
>>>> +}
>>>> +
>>>>    static void cluster_swap_free_nr(struct swap_info_struct *sis,
>>>>                   unsigned long offset, int nr_pages,
>>>>                   unsigned char usage)
>>>> @@ -1808,6 +1860,14 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>>>           if (WARN_ON(end_offset > si->max))
>>>>                   goto out;
>>>>
>>>> +       /*
>>>> +        * Try to free all contiguous entries about mTHP as a whole.
>>>> +        */
>>>> +       if (IS_ENABLED(CONFIG_THP_SWAP) && nr > 1) {
>>>> +               swap_entry_range_check_and_free(si, entry, nr, &any_only_cache);
>>>> +               goto free_cache;
>>>> +       }
>>>> +
>>>>           /*
>>>>            * First free all entries in the range.
>>>>            */
>>>> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>>>>                   }
>>>>           }
>>>>
>>>> +free_cache:
>>>>           /*
>>>>            * Short-circuit the below loop if none of the entries had their
>>>>            * reference drop to zero.
>>>> --
>>>> 2.39.0
>>>>
> Thanks
> Barry
Thanks
Zhiguo

