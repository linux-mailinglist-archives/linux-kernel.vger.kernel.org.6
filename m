Return-Path: <linux-kernel+bounces-292394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9AB956EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DADD4286064
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2685130E4A;
	Mon, 19 Aug 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V4rTiDMo"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029BE77F01;
	Mon, 19 Aug 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081846; cv=fail; b=dukbMZHs9fulc1IgQbQApjgdCHs5CUeuJEDdbbgbM7yASgrixxeYWuCUO0u849huvHzOlMaJbdaBjrOsPcNuTpco04k4RWipVILYT52iB9c/1PNVtLInOq4KGDn+Y+B5AyMnvr6yC7G3qW9tkQY5OBDnMEtCzXhZCQvEfxjvhaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081846; c=relaxed/simple;
	bh=J/ozw7ETitZIYw5/7P8PkGo4j3LE2YqfApX44z479ZI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9Iva2uZ5DB7OZTPZeqhEO2fhWJQvQUdv7ewbjo5V6FTzJSXcPv5vZxsXyYja6PhGz78HSIpBcMMRGSqzr3OTy9+zTeZMp+Y0BgACuoeo50fcX0mUe6nLkX4A2PlJJZZnkfcKv4nO8WNq3Y7IM2XL6qQcIjKrbUGIfNDYdIrx88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V4rTiDMo; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhqYURYmeBH7rzU504kHXwO8B35W3pVnNwvRDR+7FPgKlIe7WLnjwK2Cp/ykr9NQq+KvZbppUt9CO58yycPNuaBWvzSQPUZU9Zl9rV64eZyfyHU1knzh+aK2brCta9DpaHCtK7UlU+MpQazq3hQ+GoFrJfZE6+tVYETo2aBoezDA9wNS2wd+Z1sgVUtbZjYMZx2NNmfQMlLjz1E+tyftj9I2iSSh0DYdYfC2Mc7lDS8RAZBv4iaticVVSvY4UQlGb+09ahGnen+C+AZz9fGlx+WSOR2AoP5n3Q7Q0VjSG3NfnmByxl8xA0Y/xe7ibPgUy1i6b9FoK3a4L7Rmqc3AFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idgcN83iNeACDmLN2D2j/EUAOxAJmUYRZOSpf26FpOE=;
 b=cJ/iv26WEyP4QQVHLCdPHsiKClwtgfJdBkqLzJQplSYCv87IvvMCO3Dlj92ySZ1QbslDqmk+V0jbY2BpYTZOvKeot6UEXQAzlN2KdX4h+gVCLImSp24zMJnIdC8OWPsRHHRK/m5yWZNNP/VqFZWIqab++NUryrO378pvLYNRUT8HcbwJXrMRlmzUaLWRx4SKrOXa4S5aujApIb/3aCQk6lPv5AuRaY4yrDF8JlTKxwLhqwSUuarHpsl3qibcOo9ZFBe2D1zV63ej8XSxQ/h1cd6sTN6klOnCnbtL96jmiaKInNw4VGgWmnL46fhWujdj7LwnEjRC8rE6iotDPRzVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idgcN83iNeACDmLN2D2j/EUAOxAJmUYRZOSpf26FpOE=;
 b=V4rTiDMoWVS4gK8eVtDyZAbKWVIzJU69x4UHg6TWsJynU9eyogJdmIioyb7pOSL9E0DjGcATCcPTSH71wL8WEMM/M4VRtUfQRPzlw41yKn+iN/Yzc5SMhCkRjiLT9M5LMyK1UoGGXpsXkBaQqzDk5S9OBULB1LUGaQGjPd58JnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:37:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:37:16 +0000
Message-ID: <8a3755a3-0c4b-41ba-a2bb-e269d5d53fbe@amd.com>
Date: Mon, 19 Aug 2024 10:37:11 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 04/22] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <851bfbee0fd53631acae8d209796d52ce8051e68.1722981659.git.babu.moger@amd.com>
 <daa0fdd5-bc86-45a5-a684-a88816f3cfe1@intel.com>
Content-Language: en-US
In-Reply-To: <daa0fdd5-bc86-45a5-a684-a88816f3cfe1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: e17c2359-0b86-4a5a-a3a5-08dcc064ce09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czdNbVZuZmUzeEVQaUlpbWVHT2F4NFJ6MkIwQUdJQUk2bXlhN1czdU5QL2g5?=
 =?utf-8?B?TGJqbDlSUjlLdVE1UndEdWszV1B2R0lsTXZEbWVPT1VZVTBIcmF1ME1ZREpz?=
 =?utf-8?B?MHZZRnloYlByNk5hNjU4b2hrMER5YWplSEd5ajBXdUVRR3BWY0hueENKUHo0?=
 =?utf-8?B?bEJPampqT2xtenRtUUVjcyt3enJZdjVLQW1lMzdSTFY3OE93QnQwcmpPYUpG?=
 =?utf-8?B?UzFaYmRFWDNlSlg3THU1TitXQTNYTUVvUG9zNVFGUUtlOVJna0FUUEtQVFl6?=
 =?utf-8?B?K2ROdyt1eCtBc09OSHlUNTYwcms2RGpxaFpaRHRIOUN5UlNncys2a0dTeU41?=
 =?utf-8?B?N29URURjMmhYYlgrSEtOclplb3dDdHFFTGJueFNGeWZ4bzFUNUxuVnVwMjhE?=
 =?utf-8?B?R3JPeWJMZWlpRHNtcWFzcldwcWFBcjFpSC9BcEhqcXJyYWlIUDRlYm5EL1Ir?=
 =?utf-8?B?Um5ydUxaeEdaYUVraUV0VE5nRWhNeTk0c01DSFFiYllrWU1udGtWakUrVU5x?=
 =?utf-8?B?S2lyZzhkeVBhb3Z6YWN2SmdXcmp2RnBNNjNLMDBGalNvZjdodWN0NU1kZXh5?=
 =?utf-8?B?R2VCSVNkeUJEb0gvNUdnWkJ4VEJ4RWJUc3lrY3c2VFNUZTdKRFpKOFUwcHd6?=
 =?utf-8?B?dWNramZTT3cyd1RoaHpkOTBRVjBwZ3I5T0d6bXpDR2RQVlZsTXZFNWVrSFZ2?=
 =?utf-8?B?QUZOZ2pXWmk3K3ljR1JIR01ZeWtSVWY3MnRVeWN3VXp2eGN2SWV6UDEyNk1X?=
 =?utf-8?B?c0dhSFYwZTRiRUxIbVZnaHhLcERNTUloRWwyaERxWVh5QUlQN3IvemJLMFJR?=
 =?utf-8?B?bmtoc1p2RXhTcTNTMGRna0E3NEVPRGhKUkorckJjMlY2Ynd2Mk94allmaXRN?=
 =?utf-8?B?QktGUkJwVGQyRm52V3ZSUkQ0R05RaGVpeE5WYThDclBiMEZQcUFPdWo1Rnl5?=
 =?utf-8?B?bW5kWFA1bHhwVzZnRDhReWJ4d0dHcENqbUdxazd1aDBWM3JiM1diTlk0dlEv?=
 =?utf-8?B?L3VqTzQxWDk1UGZGTTNZaXpNbFJjaVFVckh4RnBMUFk0T3VBYUd5VnV6WnAr?=
 =?utf-8?B?WExoVitRTjEwWTAxTDdTQXFwd0IwS1JFVGl0bTlSWjlmOEMyQ05IeDIzdzVP?=
 =?utf-8?B?SE4xY284ck95a0VGN1J4N1ljeHJ1WXVGZDZvamV2UFdLb3lwQ1JsT1JBbHh1?=
 =?utf-8?B?dVBmL2VkdlB2OHdFakpGVGREZHV6RzRvQk9ucEhHa1hVNjFKZlZkeFRkRFJE?=
 =?utf-8?B?aDQxOHd1Um12TjMvdDRBZjRRbGNLVStCLzFiY1ZhK0huZlNOOGlIcmdNd0Uw?=
 =?utf-8?B?TUxDK3grczhmWHdkMVdheTVqcXpvalNkSUM4a3BJYW5yL01CVHloaXRMdkkz?=
 =?utf-8?B?dHRHVENGeGF6bTl1ZkVOdXFBRHJkVk80WmJMemNSYmUvSXhRbUcvSTRtbHFo?=
 =?utf-8?B?Z05lV1dBQ1RrNzRSTnpKOFJSZ2cydHhKYzlDdk1XNmhLcjFsdEkwWDIrb1BS?=
 =?utf-8?B?cGs2U3F0YVFrMmNVMHhJMHJjK1ZUT2ltdzliTHBYd0thd3FqeTFCK3FKU1NW?=
 =?utf-8?B?Y2g4RldqZGFyMkZEQndiYzdFWGpkZi9jVkRFYXFBdjliTlRzSUJvbkdUVyti?=
 =?utf-8?B?dHRZWmZxd2N6cTZHaG5ZZ3NDWWk4MU53MGFXZER0aXcrVXZrTGtKMzR5L1BF?=
 =?utf-8?B?anBxdGVlQlVINEZnNGJsT0lKWGFIS1BTdXA4dm9qbGJvYmYydmQ3S3dxamhH?=
 =?utf-8?B?RFFEa3BBbXA1UkgwMUxiS3hXQjFqM3R4Z0M2Zk5aQjlWNmpiNnhna2t3L2tz?=
 =?utf-8?Q?1V0m/RMNEnw8w5rX3AxDVdYxSuUWs6y8kfsUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R09aZmYwbjUzSlI3RFBuRVdnR1lMQmdRNkJIVmJiZjI1YWpqN0w3cFRHZ2RF?=
 =?utf-8?B?aXp1aDNadGQvZ3FicjRFRUVyKzNFNjlJaFhSNEJIMk15OGNwcGxWakdtYThZ?=
 =?utf-8?B?V1hac1UyTEs3VE9TaTZ2NGp1V3ZpR1c2MFRTcXNQNW9XUTVMOTkrK2N5MFFJ?=
 =?utf-8?B?Tk1PVVh1MnhMTmh5UEk4ZThwYzJSeDNMb2l4REI4OFpBY1FmOW41TGVZaG1z?=
 =?utf-8?B?cURld01MaVQrWDR6dm9nZUtmWGExQU11dGYvMW8wT3BiZVRJTk90dlBITTZp?=
 =?utf-8?B?RmRibVJjZ3dJcHZJaFZaM1lXdytZSTFoRHBCQXBnL1RDVy80R2pweWRjT0F5?=
 =?utf-8?B?cnY2UHV3S0F3TldtcHF1OTdQN0hhRUg3U0RiSUJaNWxwbCtNWTFiM25ndnFM?=
 =?utf-8?B?Rkljc0I2d0I3d1B6dU5PUzlVTjIvamNUZHpDZkd6ZEF6dzNGanltMDNwR2pu?=
 =?utf-8?B?Q3B6czNzbGk5SWZHWkNFUG5sQWY3c3M4blJpVXlYVTJUMmRaTm9yVmdJbmVB?=
 =?utf-8?B?V1V5czBIUlZIUGtJeWZkTlBWUnhWdkFEaE1jOXBXMjc4T2U0S2gwQ0Y2ajQv?=
 =?utf-8?B?RzBxRDZFaGtpOGtFdFZpS3NVOW1jekh3OXRIN24xUTRMZ3R4SXgwd3dnZ3pz?=
 =?utf-8?B?U2R6bm03Q0YzNXV5VjZIYmd0TFdwWjlrQVdmQk1NK1pTVS9WSlBYQlZGNTVk?=
 =?utf-8?B?azFaYk1QTUdhWXpCN0VtTEtYdjZ1V2prKzc4R2hyMFRNalgvUUwrdisrUlpq?=
 =?utf-8?B?T05XRlFHRk5uRkVJK29PbVBVMXdSNWtxQnNGUnFueElnWnYxVkdKS01BYUFU?=
 =?utf-8?B?LzBnQk5LbTduUWthNVcvSGNzQUFCWWtuWkZ2NkRQbFc3YVVYVC9ONEo4ODZv?=
 =?utf-8?B?QUZSSTRCOThHT1dlajkwdDYzVjBQQUhlenRSVTZ3NGhwaExnVERWY0lQTjJ4?=
 =?utf-8?B?QnZmUFQrTy9mR0lQM055SlE5Nmc5WmFaQkJpYzg5Q1h1dWNLa1NXNmpGeHVw?=
 =?utf-8?B?YXY0ai85MCttR0lqVGdDRFZRWCtId3lxOHBUbytnL1IvUE11TFB6dVFjbjRW?=
 =?utf-8?B?R2xVLzM3RmdvT0wvUzZIRml5M2hrWW9iWm1sT1RWNEFXbmZMSHlZOURGZDNv?=
 =?utf-8?B?TTlMc3hQRzRYc2trVTdLeGp1b2c1WlhQSGtnTEY1cUl2eXIvcldZcXl5Z0VB?=
 =?utf-8?B?QzFqQ1JkZytsM09jQldoTE4yWGoxNVBRWFpWZkkzM3MzQXRqR0FrV20zaHYy?=
 =?utf-8?B?M1lVRktDNXhNMFJNODNBbHlKSWN3ejlWclJvMmJpMmhxOVk0TWFDNjlvQWpV?=
 =?utf-8?B?R1U2WlQ2dU0zd1lvaHNoR1dHblA5V3FUNXZyMnpqSXFNZUduUlh4K3AzRTBZ?=
 =?utf-8?B?WEI2OGxNeUpRb2hmOUlLNmt6enYzTVBSeU5QQmJLUGx2S21iTWxPakppczNN?=
 =?utf-8?B?Z094dGNHdzVXcmVNL2NCSm1OYUNzOTRvZ1luWmNTd0lGY280VDNSVmdxWEJn?=
 =?utf-8?B?dkRyYWo3MTNWYm5YaTFodCtDZFMrVFhXWG43a054MlZ1QWU5bTNUZlMyc0pp?=
 =?utf-8?B?OGJUT2QzeklwK21OWElaaFZZU2xVTWdTT2VYRUhtclphWVc1WmJ6dmZDczVW?=
 =?utf-8?B?Z1dmL3k1QUdtUjB3UGtYRzlaWFNoWXc5RlJyVFRNcmlvNVNFMGtjYTdTdld5?=
 =?utf-8?B?cjJsN015UjFvQUkvU2F1REFvays1ckJVNDRDdnNEZXQzZTN2SGRtTzVNMENV?=
 =?utf-8?B?R3RWcEp4T2puSmxiK3JWWnNHMUttcy9RWG82VUVISmVNcWt4dTE0cDVxbEtQ?=
 =?utf-8?B?SFF5T3dsVmpNMWVvZjlQNGoxeU5ESGdqVVBJNHRsL05WOFJyNnpxNmExUFlj?=
 =?utf-8?B?YTl4ajJRcnFZazVaYWlEYWFJT0JOVHI2b3V3RG1WRnFjTkdObitRQnZWWXEw?=
 =?utf-8?B?Ymhjc3BqWmtHd2RUekpSWStKdVFoejV6UHF3dXBHTkEwSG5sYkVSbVFxVUJB?=
 =?utf-8?B?NWYvOVF0ZUlWOUdxSXJ0TGF2UTVvbmhibXZ0WU53SmlERW5OeTdjOHF4VDQr?=
 =?utf-8?B?eHRSa21oZllpeGtlRlQvSUNLY2M1SHFvSXI2akZpOHRqZVYvQlgxR0JXVHIr?=
 =?utf-8?Q?ViGY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17c2359-0b86-4a5a-a3a5-08dcc064ce09
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:37:16.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcmxCxftbLWgGHlQY4xTX4xKiCqw1Rnu1uE/DvKQ4zzl3jAr/zFArF/w2cO6jaFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

Hi Reinette,

On 8/16/24 16:30, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
>> Bits Description
>> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>>       Monitoring Counter ID + 1
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Detect the feature and number of assignable counters supported.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Commit message update.
>>      Renamed abmc_capable to mbm_cntr_assignable.
>>
>> v5: Name change num_cntrs to num_mbm_cntrs.
>>      Moved abmc_capable to resctrl_mon.
>>
>> v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
>>      need to separate this as arch code.
>>
>> v3: Removed changes related to mon_features.
>>      Moved rdt_cpu_has to core.c and added new function
>> resctrl_arch_has_abmc.
>>      Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>>      rdt_resource. (James)
>>
>> v2: Changed the field name to mbm_assign_capable from abmc_capable.
>> ---
>>   arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++++++++++++
>>   include/linux/resctrl.h               |  4 ++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 795fe91a8feb..88312b5f0069 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1229,6 +1229,18 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>               mbm_local_event.configurable = true;
>>               mbm_config_rftype_init("mbm_local_bytes_config");
>>           }
>> +
>> +        if (rdt_cpu_has(X86_FEATURE_ABMC)) {
>> +            r->mon.mbm_cntr_assignable = true;
>> +            /*
>> +             * Query CPUID_Fn80000020_EBX_x05 for number of
>> +             * ABMC counters.
>> +             */
> 
> At this point this comment seems unnecessary. Not an issue, it can stay of
> you
> prefer.
> 
>> +            cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>> +            r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
>> +            if (WARN_ON(r->mon.num_mbm_cntrs > 64))
> 
> Please document where this "64" limit comes from. This is potentially a
> problem
> since the resctrl fs managed bitmap is hardcoded to be of size 64 but the
> arch code
> sets how many counters are supported. Will comment more later on bitmap
> portions, but
> to handle this I expect resctrl fs should at least sanity check the number
> of counters
> before attempting to initialize its bitmap ... or better, as James
> suggests, make the
> bitmap creation dynamic.

Yes. Agree. It is better we allocate it dynamically. Then we don't need
WARN_ON here.

> 
>> +                r->mon.num_mbm_cntrs = 64;
>> +        }
>>       }
>>         l3_mon_evt_init(r);
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 1097559f4987..72c498deeb5e 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -185,10 +185,14 @@ enum resctrl_scope {
>>   /**
>>    * struct resctrl_mon - Monitoring related data
>>    * @num_rmid:        Number of RMIDs available
>> + * @num_mbm_cntrs:    Number of monitoring counters
>> + * @mbm_cntr_assignable:Is system capable of supporting monitor
>> assignment?
>>    * @evt_list:        List of monitoring events
>>    */
>>   struct resctrl_mon {
>>       int            num_rmid;
>> +    int            num_mbm_cntrs;
>> +    bool            mbm_cntr_assignable;
>>       struct list_head    evt_list;
>>   };
>>   
> 
> Reinette
> 

-- 
Thanks
Babu Moger

