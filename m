Return-Path: <linux-kernel+bounces-550912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF5A565A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8003189914F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C640F20E713;
	Fri,  7 Mar 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kjTie8t7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AE634EC;
	Fri,  7 Mar 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344234; cv=fail; b=NHhpohq6Ph/X8l5nT0Dv/aAhbIhx6i/UZL6db3nCnFywY1hXLHq9vtjnTX5RukCh2QOZBhpNlfyVU/rNk0gMCnbYLJh7o2eVP8qY9QwakcHEbUjQvsAl9k+zTkv+R7s5GV8jlvWftFeSenozwkohfoQAUQg3dCuFYqxz8OMc0/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344234; c=relaxed/simple;
	bh=k4Lrs+NwXJe+Ajr3M69r/fwp7ToAcDhJcUll9wXSOT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQOemoebADTL6YRbNPu0ySmJ1eviX6VgqqBrd0Z5R+nd6cn9KZ2HBHhU8bpaA9KKUfapRVFScgDM9lKMaVVAkDofX6ikMCsNlFu52CUrS+DEAtHd7DAEHD2EGkWD4zVjh4Syq6SERnt0VB5Yu/ozDSIw20vr0PyEEQGkUV8JsIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kjTie8t7; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdlcbND/4jw8U9NorIQpE7ZLcyhx7Z1E7AwvgsD3H1c1tQf+0weYd5eJxWWGx3wDCfHsFJkW/AFkpiXyZ2e8iz8RoEzv0VMta/3OJY8tWLODhPtlgcO6iKbjzZaVvZE+7Af+8yPHX1v4STlxJH+XrJ6qavU5hFkuUYvj9tt64yy3o/I6s7uXucjigoAnkB5bVd//M/IB3xWx9NSLdznNrIdMFHOeoGXT2PObYcbsa8EUh2GQyah00BQzopklrBHPwxOQIonBn92oENkZme0RJtUoPpTmZbWgI7ug1QDifhCtxTg3F/qP5VDkOC4Yf+lBxSmpuAvRnVguqHNegOoYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cjQTCTyPIRCO/+rsO7gfK3vq6cqQgcxsga/iHZoQJY=;
 b=KBeakTLqFQvVHcvbZemXLuxjotFrb7Zul6aqIbkYR/gAPHe9R2XgRVTTSjm4McWdMepEkt0Rcbq9Kh/YCWp1AS/698WaTCqL1OWhb8YUDBzMUFnAIwzZtoQ5EbLPnC5bI9JZPzQ3SMrETpezONK3m7SsQ6LgjhstARdQP3S6z34FInGDLg7zfO87x2IKke1dBh4+tj//EgTDAB+HECsW9MSnwHyFFVOUbYopDonOnBhWVy/PFo+AeCGrwrBz6o9+KYF8Jm86YYy+jRP97DTvWohOT7nnMsPquB8jhWBRggROFFQ/q13dFU+KqeH9rni3vJGG4THHNxxzNmWkqnhTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cjQTCTyPIRCO/+rsO7gfK3vq6cqQgcxsga/iHZoQJY=;
 b=kjTie8t7zL5EHhbTJ/8eQ7EmKI5b20wlqper9MSHUHTYMs0qBYw3IDeoddqcwnuh+HLY/U4ozhJv5mb9mYkrD/yGIiZ6+lRJw2uKery9Jy1NhgP24np99741IQgNZVv/P39KwrFBpQFAHvEntYPb7z4uSVA40gLY3L89+BW4dzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 10:43:51 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 10:43:51 +0000
Message-ID: <435b554b-d77f-4b98-9e4f-f635bbc4b7a1@amd.com>
Date: Fri, 7 Mar 2025 16:13:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
To: Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com
References: <20250303105902.215009-1-akshay.gupta@amd.com>
 <20250303105902.215009-7-akshay.gupta@amd.com>
 <c3c1fee9-d119-456e-827b-04ba6cdd8d7d@app.fastmail.com>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <c3c1fee9-d119-456e-827b-04ba6cdd8d7d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ffeff2-7165-4d20-9a82-08dd5d64f2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkZxbFRWUWtiTzljWXkvZ0R6cHI0azRBL3c3Umc1dVU1N3ovb3docHRYM1ZC?=
 =?utf-8?B?aGFCWEM5OXlJU0R2bzBoNGVVM1YxQ3hENHkyU1o5Y0JLZHl1b0Z2Y2xwLzZ5?=
 =?utf-8?B?V2Q2L3FCZExJM0FIVW9vaTdBSlNIN2NLcDJzd2YwNkIrN21kTWk5WUhINDBp?=
 =?utf-8?B?ek90QmFucjFlbURlbVBCQ0FNdUdRK3d5d1ExeWMzT2laWmgwalFyTXlpKzlF?=
 =?utf-8?B?ZS9jS0h4Vm1BZ05PQXV5WWJNOHo4R0Rtd1VqNGRGeHhHU2FHcXNURHRGRy9K?=
 =?utf-8?B?U05pZHgwRHNIOWM5RUhUVWo0cHBub0tuYkFVUk4zeDJORS8vaWdYYWxNSTNZ?=
 =?utf-8?B?OENqYlRKN25GUE5WYU8xRkh3Vkk1Rmpvb3dMWGxLeDBRV2U2TzRrWXViY2dQ?=
 =?utf-8?B?TWRVV3JIMW4rY0d5bUxZZXZlVmtGN0RxWlQyZ0lybTQ3TVNvd2JaSDc4S1pV?=
 =?utf-8?B?Q01vblk5aUUrMDc1L3ZBNnM4d0pKdWd2RVJkaGRGMFpwOUZtTXVEcXpmZ0Np?=
 =?utf-8?B?MU9pTmNUekFDTkU3ak9FQytDeFdyS1ZlVTVIalV4SnJaWm1Yd0U0eU9oeTRu?=
 =?utf-8?B?M05MVStFT2Z6M29lNkJCWU9HMSthUHFaM3hJZW9FWjhORzRBSWNJbjNpZ3Q5?=
 =?utf-8?B?NVA2Rlo2R2FoVzZPNk9va0VhMDdXVnBCNUNyUTkwR0FZQUI5RG13dTF2bUdp?=
 =?utf-8?B?VS9zc2FVek1EUVE2NThzTVJiQlZZdU5nWjlIenRWWlhJZ3VBaG5BWUJhY2F3?=
 =?utf-8?B?Mis0Zkpid0EwT1pqT0ZIQnhaRTRNR3pYQUFoZ21wNHB4UnVFc01RcjRWSG9S?=
 =?utf-8?B?M1BTcGRwK1cvbndQeG5idGVMb091eDZZR0REUDFSdTIxNDV4Wjc4QXNnSDI5?=
 =?utf-8?B?cGt2UXZjeTJwUVR5RXhkZmhrai9IcTF6TDFsWHlYU2hxL3lOT0owNDZZeFFZ?=
 =?utf-8?B?OHI3aUMxNkRIQ0hoU0hNKzltQll4QVlFdEpRMlUxY2RRSGQ2WnBUZndNOG1L?=
 =?utf-8?B?bjdrcFB2Z3l4S01vTVJZWjg5NXVPZGNNbGtiUFd1ZlViUDBlV2ZveDJ1T25k?=
 =?utf-8?B?dThQSW5yY1duQzd1Z0R3dGFKclY3dGI5RXdzTm85Z0E4T2JqckFsTkNFRUc1?=
 =?utf-8?B?aCtuUmpraEQwSzlJZkF5ZnFzNCtsTUFIWTQ4RGVxNktDSTR4RWF1NDNyM3gz?=
 =?utf-8?B?MDkrWFdESmRXRU5BSjZYWkkyU05SckpGZGtHUjJZbmxSNzJOSisrN1pxWFdG?=
 =?utf-8?B?OVpqMEpkcG5sZlBjWmxOVTVzcTNMU1BxZitwUVpyTXROYlVhUUFObUNWdHpz?=
 =?utf-8?B?SWdibnI4bmVWT1lWZ09iQS9LdGpGQlhvd3dxdFU4UkFrajFrcmRoL2Y0MkYr?=
 =?utf-8?B?d3VnME9obEUwVjF6L0kzcGI0b3JzVmlLeWluMlpBbVh4M3dPM3ZOemUyTklR?=
 =?utf-8?B?UU1TM2h5SkRCUnJ2dXVwQ2VpWjV6Vkg4cnFOQW9qMlJaOUgzbTZzRlM1RDky?=
 =?utf-8?B?OVdkMFhwck52SDFPR0N6TFhBa1kxc0E1Tks5V3R4dFhwcysvUmtSeXlFQS9K?=
 =?utf-8?B?LytKU2d6VUF6TnNWcjRFUmdJSVV5L1NjVndxMjcyeGgvVFoyMjlqcmpGMy9G?=
 =?utf-8?B?SnNxQnhWZXg0RWRYakZZTjByR2Z3aSs4MlJwLzBBUWcxTkV0U0ZzWFF6MDdv?=
 =?utf-8?B?NEJWSEd6bzRIZWRNYnNCNytNZkdDdFpReWo0YlJuYUtPNUR6QWVPbDZra0FL?=
 =?utf-8?B?TlJEc1J4Q3l2bmhjaEtSVEw1U0VkMmUzOXNJcnduR0wzUHhOT0s5QzNEcjhT?=
 =?utf-8?B?V09VcGh6TEUxTTZmcWVUUWFnL3llYnVCa2dpZExEMUtSQUNsTk9CNnhmaW1Y?=
 =?utf-8?Q?Bwe+NZD18ZJBi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEJXb1FJdnVMTmZqSkk1alZhcFQ4dkZneUhzOGM4bmdYTENEQjVDS0tYZTc3?=
 =?utf-8?B?OU1IQ0lmUXowbThKMGMxSndjMTlQOEJyTmtWSG96Q3RPTVdjUEx5S3VYdEJB?=
 =?utf-8?B?TFUzTU9VTzM1RFFHVGc1MU1Jdk9DL1gxSEt6SmRWQXYvUU5IcmFBbDJlRmpY?=
 =?utf-8?B?M09nc1N6TkY5RmlvaGVmSTJmdExBcmE0WlE0ZXorYWlFZ1BNT0FUdkhxaUZF?=
 =?utf-8?B?ZWFRMHlUMVE5OHFHSlRqZ08rK3JPK1hYNm5XaEV3cW55SXlNMHpxZy9HUnpQ?=
 =?utf-8?B?dm5ZWWgxeENEam9XRlVCYmRHeWhzNDhJSkFpNzBiVG5rMmJRRVpCdWhPM1Uw?=
 =?utf-8?B?aWQ1WkdkaHNHMFRMTG5hclNYQi84Y0lhQ0VxUHBaUXFaOE5idGpNeCsrdEVt?=
 =?utf-8?B?Y05oRlAzbHlmTXo5czE4UVExMlZWVXRsdm1uYjIyRFBHZzFlQXM5YXZTamZV?=
 =?utf-8?B?RVZuQVZaMlRwSmd3Uk1Pc0M4V2hseVRjSEUwdHg4T0hENEtsNkN5UXhoeVZG?=
 =?utf-8?B?QUlSVS9IWjNzOU54NHEyclVGcFBoYWdJbm0wdEJpTm56UUF4dS9WcEh3dUpE?=
 =?utf-8?B?cUxBb2FCeE0vVVA5eXlBa0hMYjhCY01QUEFObVp5aE93anRReXJxUnJKVjh5?=
 =?utf-8?B?d0taQVRkNVF6T254blZDTWUrUkdVUzhhWTBOOHBmZVdlMXpBOFRnemQyVktj?=
 =?utf-8?B?a3NMc3RYdjZFODhMcVgrdVR2anE1bkE4ZUF1ZUU1Mi9CdVZXbk5WTWk1M2VB?=
 =?utf-8?B?eDR4SEZ2bmlNdzdoMkpJQ1RxUWowMkdzdXprWll6bEJDNXNXc2Fqd25FM2xu?=
 =?utf-8?B?UDlSS3E0RU5Wdk9JSS9jZjMyR0dRczNFanlOTzU3YXJ5TEROSlBzNUVGTzBq?=
 =?utf-8?B?WG1FVk4xUlh0L2liV25kak9zcmFWcU9jWHUyUE9mVHRiWFRVbUtWcmV0UEtD?=
 =?utf-8?B?SURjOGFHZDZsdmZkakhOVUpuZEJoQ0VxZnV4ZWxIazFIZjQxYmc3L0hyTFNJ?=
 =?utf-8?B?Y21laVV1Q1p6dzgzTzVqY1Y3aDFDNkdCVDc0UnhsaUp1UEljYm0rWitGemsv?=
 =?utf-8?B?R0FzTWRjampocVRrSzBDeFFOTkFNNFBSVnU3K01BdFAvSk9iZjlXZjFpbHRs?=
 =?utf-8?B?enRpRXhVRWhCdnVqKzFRME0xbCt1MlJNNEFWUkxSTG5uTEEwQUpVRUZtTnJm?=
 =?utf-8?B?d2gwdHA3Y2NyQ1ZlWTJINnVOdlQyMkU2U05hU0trSGdrMDB2SVhGaEx4Rkoy?=
 =?utf-8?B?YTMrSktkK2FLc3A3RStEKy80VFlLcG9JUXJpdGJuaVpNaDAzRHZ1cEFpRDZp?=
 =?utf-8?B?Wi9JVkN6NitMUkNBZ1ZSN0djZk9Xd3hpWGJkNkFsRTExdUNnZnM1RHpBL29L?=
 =?utf-8?B?dnV6VXdRVytpbW5YQ3krVmFEdmlBQldLTy9Pcm1qaTd2MjJWWVZ5M1FwVTNh?=
 =?utf-8?B?alozenNhYzAxRjlVQjFxRFdWR2Nqd1Q3OTIxUUlWWGdBL213N29OaGdmSHB6?=
 =?utf-8?B?RExkZHRKeEJaQ0puK0YySkNOVVdnWUhtSFhKblJZK0tIS3lHaHU0cUVtemJE?=
 =?utf-8?B?OUVrMWVzeS9uV1hseUhJMGd0bXNHOEhrY1dvcVY5Z3VzL2kwclZvN3p3QkVQ?=
 =?utf-8?B?RTB1TzVmc1FmOVozUWozZFFPZm9tQW5IZWlWdkpYZ0kycWZiM2c3VlNHVFpj?=
 =?utf-8?B?dCtGM3FqTHhQNmZEenI0TjlvMmwxZDZ4cHQvaEdsM0M0UlFlMG1WNDRxTWN2?=
 =?utf-8?B?cllXbm9CYzR4RkdhekhEbEhFeERFOGU1aVdqbzhGVHBuQlBsSjJhVmdUck5j?=
 =?utf-8?B?WlM0SjZ1K1doenVXQVg5NkowVytnc3lsTDlOUEtia3ZGQnRRLytKanVDUUdJ?=
 =?utf-8?B?eVVWTlNpSkJ5K0dTWDM0ZDZTanNjVGd5TkpBNUV3dXN6QW5MRWZ6dFUyT2Z0?=
 =?utf-8?B?M2pwNnpWeTh4VEF3OUFDS0pmTjkrYXVUUlBFTjRHb01VdVFxd1BWRFc2Tzhk?=
 =?utf-8?B?OHVKSmQ5UkJiQU1tdG85TStGYUxrRzIyQllLQ3RiM1VBRHNGWE44Vk1GNXF1?=
 =?utf-8?B?THcwRG5KaE5YT01NUXhNUEVhUXYzOUc2SW1YOURXL0NBWnZzamR3YjFJOW5p?=
 =?utf-8?Q?X0yot4mPnJD0kDa9H2Wt+TbOD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ffeff2-7165-4d20-9a82-08dd5d64f2b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 10:43:50.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33JMnQDvg9w8NTS1upXN3mp4He54j+aNNkqCCiN5o8ED6vaVHFcBC53KFGNuT1hVlDnsCBYWc5z+mMbXc0TQWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646


On 3/3/2025 9:48 PM, Arnd Bergmann wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Mon, Mar 3, 2025, at 11:58, Akshay Gupta wrote:
>
>> +static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned
>> long arg)
>> +{
>> +     int __user *arguser = (int  __user *)arg;
>> +     struct apml_message msg = { 0 };
>> +     bool read = false;
>> +     int ret;
>> +
>> +     struct sbrmi_data *data = container_of(fp->private_data, struct
>> sbrmi_data,
>> +                                            sbrmi_misc_dev);
>> +     if (!data)
>> +             return -ENODEV;
>> +
>> +     /* Copy the structure from user */
>> +     if (copy_struct_from_user(&msg, sizeof(msg), arguser,
>> +                               sizeof(struct apml_message)))
>> +             return -EFAULT;
> This is not how ioctl commands work: you need to check the
> 'cmd' argument, which includes the length of the data.
will add check in ioctl for 'cmd'. Thank you.
>
> copy_struct_from_user() makes no sense here since the length
> is fixed (for a given command).
will modify it to use copy_from_user and size using the _IOC_SIZE(cmd)
>
>> +     switch (msg.cmd) {
>> +     case 0 ... 0x999:
>> +             /* Mailbox protocol */
>> +             ret = rmi_mailbox_xfer(data, &msg);
>> +             break;
> This looks like you are blindly passing through any command
> from userspace, which is generally not the preferred way.
>
> Usually this should be a known set of high-level commands
> accepted by the driver.
This will be addressed
>
>> +static const struct file_operations sbrmi_fops = {
>> +     .owner          = THIS_MODULE,
>> +     .unlocked_ioctl = sbrmi_ioctl,
>> +     .compat_ioctl   = sbrmi_ioctl,
> Change this to
>
> .compat_ioctl = compat_ptr_ioctl,
sure.
>
>
>> +     data->sbrmi_misc_dev.name       = devm_kasprintf(dev,
>> +                                                      GFP_KERNEL,
>> +                                                      "sbrmi-%x",
>> +                                                      data->dev_static_addr);
>> +     data->sbrmi_misc_dev.minor      = MISC_DYNAMIC_MINOR;
>> +     data->sbrmi_misc_dev.fops       = &sbrmi_fops;
>> +     data->sbrmi_misc_dev.parent     = dev;
>> +     data->sbrmi_misc_dev.nodename   = devm_kasprintf(dev,
>> +                                                      GFP_KERNEL,
>> +                                                      "sbrmi-%x",
>> +                                                      data->dev_static_addr);
>> +     data->sbrmi_misc_dev.mode       = 0600;
>> +
>> +     return misc_register(&data->sbrmi_misc_dev);
> What is 'dev_static_addr'? Usually you want a miscdevice to
> have a constant name and a static structure definition, not
> dynamic allocation.
>
> Are there multiple devices of this type in a given system?

Yes, there can be multiple devices on the basis of number of nodes.

>
>> +struct apml_message {
>> +     /* message ids:
>> +      * Mailbox Messages:    0x0 ... 0x999
>> +      */
>> +     __u32 cmd;
>> +
>> +     /*
>> +      * 8 bit data for reg read,
>> +      * 32 bit data in case of mailbox,
>> +      */
>> +     union {
>> +             __u32 mb_out[2];
>> +             __u8 reg_out[8];
>> +     } data_out;
>> +
>> +     /*
>> +      * [0]...[3] mailbox 32bit input
>> +      * [7] read/write functionality
>> +      */
>> +     union {
>> +             __u32 mb_in[2];
>> +             __u8 reg_in[8];
>> +     } data_in;
>> +} __attribute__((packed));
> You normally want to have the in-kernel data aligned. Even
> if userspace has it at a misaligned offset, it will still
> work without the __packed.
>
>       Arnd
Thank you, will update.

