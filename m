Return-Path: <linux-kernel+bounces-314418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFF96B2EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F91F298D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074FE146581;
	Wed,  4 Sep 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="K1UVoFoq"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283E3C17;
	Wed,  4 Sep 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435125; cv=fail; b=cANz6Ea/WhyMI4sfUig2axLXMmsLstC46988Uo6deMpc0WmZd689mLu04bgfP9IcMJ3nQrcSKkV81ufOjKcxnBVf5KpeMAunegFCuCprgLgPwV5NXVCo4KKNk+5ohzD70pgyv/+xFtKXZWU0o5SghtzEjmROmMTwmUrR01wS+HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435125; c=relaxed/simple;
	bh=6nz4bTUiFIUQXdwUDKwyUNeFazY+pCPUV2b8mLApQ7Y=;
	h=Message-ID:Date:Subject:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuwUCYB+oexiutX2Fwt6HeTKI/+S5rVw+YP+1w3dy8EQaSvjVV25e5c/vwYQwB4RMouLOFWKQZRZHE/5GQCFLadoStF1oK1xrfU+lzTxqVqEbriVCy+FCavV/uKV3ICyRRFOsL2wWAaSyaq5nP92DqAcnvOAnxENDs5eJVub3ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=K1UVoFoq; arc=fail smtp.client-ip=40.107.117.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGCbAYsz7fdlCpF8j2a1g0r4+VEs2r8KVPEDWIu08Y23kGWEaWhzNUi5Ovuz5AtCUwcea63Q91ghdSxzLMPuICEAo3YE6KkFdozijg3PczLwJaxjsjv6Ash84FVKfzbUM3quCENVxnfITl+c2kJ6dRGTypxLTciB8heFv64ITwWRs20vKkwaFv1XnIIkSZ8Zl3dUn8/P7CEmRHrYST+RGE6l23fgOk3WwugkVABO0kCjSqUV6cBSgy5WmDHmE/h7VGWqSZpVP/NHB36eckl3Rduv7FyNn05oEPhgypxXbGrGvSvb7ULcI/jxuhmwi3sF7XRCJCMSNhUP7RC4CwDpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bdM8vABrdqYhXQ7iZJJ8kRQijsxPo8FJKEON/8wduU=;
 b=cVODv3f0dI/BovRlZdxb06E2yFJJMVlC94Zuhjp3gesDRoxlBH6emrUyYCEz9QspNUh6ZfYx5I7sa7Og2ojFKJfZXBttLufRJGY96scgA8jfkuZSBMH1DE9UZetcZj4XE/+YOxyTJTyfX1ErlanabSA4RQ5You+larwuxeGKPjKJZMuqmlKwLZ1ajBCK8jT3s5eY1EsTwKMobfi9UzN8xEECdVI4Sd2cnFB1O5qyuW8WQuKwGEBcssUVPnlwzpmlfqCJD0MuPjYLPCaj2cNBeG+JokeGnsBiiZVU7fKiRT3RtUZ+Y5Mb9El43g3S0CHElZ4b2R8m1/URvW0uaB678w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bdM8vABrdqYhXQ7iZJJ8kRQijsxPo8FJKEON/8wduU=;
 b=K1UVoFoq4OY4fGnD4PS5sQitSUgdrDue3G1OzXKP2Y9E296XZLt1QUFRB50/JUxdhWKJVobOIsJlLgJ5Ug9LsLJPi5yY9Mc/yWmB1nP8Lj1OZuK/wokekB5kvg70Vpdal3dhkebq5njZCGRRzlfrFRCKjkOPD4pVIXr9l9YLLOxfLx5FoTPJoiu2n0QL98+npkX4Sn+xkODL2tyzOci8B/v/W6lPiWxpcvYvbSF2awhY8aKsYHW2KOaj0oku/JByqhTt3QLI9Brx5AekFJaQ28/3dWqa816eUsHW0dDAz2ycDZtatORVSS+Wmn8BUXD4nGKJZrbjPpgSKEXdWQr5Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by SEZPR03MB7809.apcprd03.prod.outlook.com (2603:1096:101:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 07:32:00 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 07:32:00 +0000
Message-ID: <15cd5d2a-61e3-40e1-a494-579b7e185dae@amlogic.com>
Date: Wed, 4 Sep 2024 15:31:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] clk: meson: Fix an issue with inaccurate hifi_pll
 frequency
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240904071817.489245-1-chuan.liu@amlogic.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20240904071817.489245-1-chuan.liu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|SEZPR03MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de3bcc4-0aa3-47d0-d938-08dcccb3a9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T05UN2IxTENNVkkzRFJiM0ZqYXRacC8vNmcwaUhTT1hLcnQrZ0VWaHJHVDRN?=
 =?utf-8?B?U2RrcDY2Q3hzN1NlSFY2WTROWi9LU1FsQ3hDanU2MjA1THBWNkMxYXRsb3pD?=
 =?utf-8?B?bWJQaGtpNm9iZEdSdVhwR0RqclpJNkNuOHJ6Ukwxd1RoSEQybUt5bmM1SnFI?=
 =?utf-8?B?dFZiYXhsc2FHZzBYSGdpNitqbk0ramViOC9iTllrem9FVUhHOHBNQ0tZSkRK?=
 =?utf-8?B?WVFqQ3NydnBFMFZGWXhyUXhlem4xSlR0b3pCcVgrelJsVWNzQ0VzWlpZMDJa?=
 =?utf-8?B?ZTQvcnJoSXY0VXhVL3VadUpMaUUwajVwU3haS0dZYnQ1REZIRlY2N0V0czZX?=
 =?utf-8?B?US9TS1krN2FRd2xGTy9RTi8xQnVmQnBNRGhuZkxrZHJPRWQxK0pXSEFqcVpM?=
 =?utf-8?B?VDMzdkUxL3VKUTdycSt0TTFxT05sYndod0JNeENXU1VneW9JZVNsVm1BZEVu?=
 =?utf-8?B?NTAveU1YVi9NK1JiK3ppUEc3aGFlOVd0YkN5K0czR1VMRGRTMmZGUmxtZFlO?=
 =?utf-8?B?bFU1MHZBQTc4N1BlcS9SL0prdm9QcC8wcGpjbElLT2NlVGFKQ3oyaWNoZjdV?=
 =?utf-8?B?aFdXWG9yUW1TcVNNbVdUOFdGb2JlYzR2ZXFvZTNPOXFwWkk5SkhRMHIrd1FG?=
 =?utf-8?B?bWQvTTM4ak1YNUk4MUxhRitGTFEvM2UxbVNzMmF1eGVkL29vSFJVaUw2dVRy?=
 =?utf-8?B?Y3dLeGdLeXpoOFFFaXUzV1NHTVdGVnJwTm5GYTVNd3ZKMytEa1dRaDN2VUtU?=
 =?utf-8?B?M0VmdWNyNFBBNkVqOHh3eUpScXJVZ3BYSUxJZWl0ZXN3VklIaUY3S1lvNmR5?=
 =?utf-8?B?T2sxNGRvT0hvdWlIOFFIT1VDUFJKYUpaWkEzeGNDbFpOM2VMTEVmWDd1Wng1?=
 =?utf-8?B?aXlPL3NHSnhOcC9lb0NIL0wvTHNNZDUrVUJva2pMUVhldmhoSUlIU2JzQkts?=
 =?utf-8?B?WjRtbjB5b05oUDdpZHN2UXJ5NmNDQlQ3TFJ6TlRTUDFWMXpncGZ6MTdvK0hy?=
 =?utf-8?B?c0RXeXpWZ09pM3hKWFd6QVhxRzF2YlJLQWY0TE1Gc0pnTUpIekIyQWNjdU5s?=
 =?utf-8?B?NEhDTXJoMmlWQU9Hc04xZENMVjduZy9WWU42NWhxNkhQWllpZk9JbjhWYmwr?=
 =?utf-8?B?MnBLTjdMUi80VXM3cHdaRjJpVWVUcm00ckF6OEJUcEhLb3FaMjVLQ2g1MnhC?=
 =?utf-8?B?czRGWFNncTN5cnc2VVpsWHRKdExJZVJ1ZXFtWkFSSlNtSWZmcEh6WUUxc1B0?=
 =?utf-8?B?T0cwYmt2M2hCSXNJcGhGWE9nRUJUQ0J5TDc1MGlkOVpHMXV6OFNQdkhPUEpt?=
 =?utf-8?B?dHhYRXJybkFHeFNnbzRyZkE5eXpuY21kajlVRnBHLzJxYUREckpOakxiZ0NU?=
 =?utf-8?B?RS9uak5xZDZwQm5UMnR3M1BObHMxcXpOVTQwYUV5NVA5Y3JnMEY5NkNLSVZ0?=
 =?utf-8?B?SmQ2WGN0cmJXMjd4U1VkYS82SE1qRTJXSTgrVkh2UmRhTWV6K2YxY0RUcWJL?=
 =?utf-8?B?VWVUbGwzMElhN2JSekROaGIzWHFzbklPWURyTytlaVNvR20yRFFNZms0ZlhE?=
 =?utf-8?B?eFdxNi9CL1ZraXluUWMvbHlDcWhBQ2RVM3A4bXpoZzNJbWpBdmQyNmhvbzdx?=
 =?utf-8?B?ZGlSZmw3MWVIOGNzdHZjSVZrMC9qbnV5MUtNd2NtYm5jTkdVaU9rT1pCR2hJ?=
 =?utf-8?B?STBQaWRvM1JNcmdMbWZveWNEeHdkdDVGRi9YbkhRRjFvZUhzb1VnRUgyT0FY?=
 =?utf-8?B?alFPR1hqL1F1K2JwUEdEVmJuUG1GMFhKK2tSOXJNcU1MUHZIM1pwMjI1OEJy?=
 =?utf-8?B?RTMvUTBtbHBWV3d2OU1ndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVVWMk1jOHJDK1Y1Y2Z6L3lFM2JIK2N6RHpzL01vQmJwVDRab1dFWk04WTVw?=
 =?utf-8?B?NWJpQjBHUUVKYkVpRnordjZaOTJJeWMwU2MxNjFFZ244d0Y2RSs0OXoyWnUy?=
 =?utf-8?B?RUlPN2duSHJXLzYyL01JUVV0NllvTWt1djFTeWViMHJERGtqcDU1akR5N2t2?=
 =?utf-8?B?ZEJRMEk0Z2pDVHdUVTR5RVFabEFMZ3oxWE51aVF5bVYxR3pEVDAyOGFCTGN4?=
 =?utf-8?B?M1VzRzN1b0pRbWRnc0JBRUJkcW5qWHNhQTd0dWhoWDUrMUlmRG9NMTRvZHpU?=
 =?utf-8?B?NUhVd1h0UmkyODAxRUtYY3gvSHhGTk1ia2taR3d4WkpwcCs5eFpBaWtLWWhX?=
 =?utf-8?B?ck1aQ1lrYzJnTzV5Sk10T0ovczk2dHBYdkx2cjYwZGlYdEQyQ2p3QWdDOVBi?=
 =?utf-8?B?d0Jwb01OeXFCL0pTdS9jT3p6YnRUaGZpcnNaSk9sZSs2MUV4OUZCQnoxYVQz?=
 =?utf-8?B?SU9KZzgrSDZlaDdLcDdGL0M2bDdNdWpLaXJsUmZtQU02RDhXYTJnaU9pc20y?=
 =?utf-8?B?SXIyZXBQSm1idk84ZGRLYWl5NGtmRnpjRk1aQ3UySmZYbUNUZzVLSFc5L0wy?=
 =?utf-8?B?YXNzVmJTM3dRR1FlK0xwSXZnUWxmSXMrQVc2VW5Nc0FzOGlhQ2crWVhXcEZH?=
 =?utf-8?B?c2V3Y056aThyb0FsVDhKSWIzQnptd3FrSFdEYVZTbTVSa0dPMGR6UXlBeW9Z?=
 =?utf-8?B?amVZUG95SzJ0MlVQV28vaDluVDRGbnhodit1QUxtTFYrRU1VbWNtYjNIaU9U?=
 =?utf-8?B?R2F5L3luUWhJZmlPR1NIUFRONDFnclRxODIrUnhIL2ZrSTg4cFNJZ3BiYWlp?=
 =?utf-8?B?SUZPRXNNVXN0M2xCMFZqVWI5NnlEM0NKZXptOWtVRlBRbUczZmsySVhyeVIw?=
 =?utf-8?B?bHpXZ1JjT090SlZNUVhnNkNQbmtOcEdSaXN2OUl6S1VJK0RzenpRcy9vZGk2?=
 =?utf-8?B?YTBwRTJXd3QvME83VmJpZEs5M0E5ZW9tRjJLUUJrU0JKaC9xRnN5NVROeDQv?=
 =?utf-8?B?S1I4K2wydHFSVkZldTBqWUw4QkMvbVhrTElQcnpmdG1ERGJpQ1p6RFZ3V2dp?=
 =?utf-8?B?S29jczQyRUIyT2ppZjliclB6NnNLUmlGR0dKSWhPNGNQbC8yTzlvemdZUGZ4?=
 =?utf-8?B?YjZGL3pPV0orbjl3VFVXbWcwdDNFcFU1RU5CbER6NlpUVU5KRW0veFFENkE1?=
 =?utf-8?B?NHl1Wml5eWwrSVZSL1g4c28yaVZIN3UyUzRKOUNyUVRZa0Z0OUFhRzVCM05i?=
 =?utf-8?B?WGVUZ3ptTzB3aERnbVliOThVcXd5dS9WUzlVR2dKbzZMSk9LenUzSjVIc0pk?=
 =?utf-8?B?MEQ4c2lGUVpqQ2dsa2NMWHRMcTBYQWU3S2Q4NDdwSEJpa0lyYXZzT2orNFBF?=
 =?utf-8?B?ZlJLS2t4YXZSSGxnV2FiNHlzZ05ubUUvNFpWNUhYWlZZVmIwUnlVWDlwdC9O?=
 =?utf-8?B?VTVpWk9PNGdOek5OQktsa3gxWU1qUGY1bzh2NDdNc2FpelcvWU0ySmp0U3ZW?=
 =?utf-8?B?dmhFS0FJS3FTWFhHMkl6cm9Fc2RWdEVjMWd4S3QxT2dEOUtLQm4vckluOXRD?=
 =?utf-8?B?RWduVDRyNTM3a3lkcElZMS90d01FTUNhTXhnTjRRMjBmMEM4WndqeU5LZ3JV?=
 =?utf-8?B?TThuU2tmZlEvRjZ6R29uQVBnaFg4WmlkRk5RbW5EZCtkeTR4akZsejBnTVBi?=
 =?utf-8?B?czZsL2s2bitkcTdtenNjbjFXVmw5YjQ5Ri9qUHFkT1A0WmR4NjhzL0NxUzdp?=
 =?utf-8?B?RWJqQ1pXM3h3YlN5NjBmYzduejRpS3A5aTlQOGNVOFl0dkQveVJYRzFjQ3h5?=
 =?utf-8?B?ZnM2Rm4wZHZBVUdMSms4UkgwazhCMC9Ic3JGUHJXaFRETEFoc0h2VlV5azlG?=
 =?utf-8?B?RkdWQkdyRlEzMmhMUXdPTEpjbWdWNjVoWEVCTC9FTDN4RklFb0puWFpweW9x?=
 =?utf-8?B?c2pSdXpCS1kyKzFFRVQyYzlaMm9DRTI1WkRpTm9DZkE4dE5qcUl2VHVQeGxT?=
 =?utf-8?B?SS80WEl0RFhUNWZSQW9PbkFDRWxyZlpUdUdHVTVhUVB0ZGIwdjduMnlRODNV?=
 =?utf-8?B?cHVwd0ZFWmJLdjBNT0dqTm44S2hrbThlTWYrQkgrWmRhVFZpL2ZRL01KTGgr?=
 =?utf-8?Q?GySnueAqKY255zTwzuQL4Wq1u?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de3bcc4-0aa3-47d0-d938-08dcccb3a9bb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 07:32:00.0087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5w3hY25IdHo+QwzIquDws1gKOFX/QPHX9LWhsnpWjYhqEyblpySBwi8jkjSI0I6RTGLm3OJ7xb7kA9SYvHpoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7809


Sorry, The email was sent by mistake, please ignore it.


On 2024/9/4 15:18, chuan.liu@amlogic.com wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Some PLLs with fractional multipliers have fractional denominators that
> are fixed to "100000" instead of the previous "(1 << pll->frac.width)".
>
> The hifi_pll for both C3 and S4 supports a fractional multiplier and has
> a fixed fractional denominator of "100000".
>
> Here are the results of the C3-based command tests (already defined
> CLOCK_ALLOW_WRITE_DEBUGFS):
> # echo 491520000 > /sys/kernel/debug/clk/hifi_pll/clk_rate
> # cat /sys/kernel/debug/clk/hifi_pll/clk_rate
> 491520000
> # echo 1 > /sys/kernel/debug/clk/hifi_pll/clk_prepare_enable
> # cat /sys/kernel/debug/meson-clk-msr/clks/hifi_pll_clk
> 491515625       +/-15625Hz
> # devmem 0xfe008100 32
> 0xD00304A3
> # devmem 0xfe008104 32
> 0x00014820
>
> Based on the register information read above, it can be obtained:
> m = 0xA3 = 0d163;
> n = 0x1 = 0d1
> frac = 0x14820 = 0d84000
> od = 0x3 = 0d3
>
> hifi_pll calculates the output frequency:
> calc_rate = xtal_rate / n * (m + (frac / frac_max)) >> od;
> calc_rate = 24000000 / 1 * (163 + (84000 / 100000)) >> 3;
> calc_rate = 491520000
>
> clk_rate, msr_rate, and calc_rate all match.
>
> The test and calculation results of S4 are consistent with those of C3,
> which will not be repeated here.
>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Jerome Brunet <jbrunet@baylibre.com>
> To: Michael Turquette <mturquette@baylibre.com>
> To: Stephen Boyd <sboyd@kernel.org>
> To: Kevin Hilman <khilman@baylibre.com>
> To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc:  <linux-amlogic@lists.infradead.org>
> Cc:  <linux-clk@vger.kernel.org>
> Cc:  <linux-arm-kernel@lists.infradead.org>
> Cc:  <linux-kernel@vger.kernel.org>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>
>
> --- b4-submit-tracking ---
> # This section is used internally by b4 prep for tracking purposes.
> {
>    "series": {
>      "revision": 1,
>      "change-id": "20240904-fix_clk-668f7a1a2b16",
>      "prefixes": []
>    }
> }

