Return-Path: <linux-kernel+bounces-280548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B884C94CC08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345FF1F22D25
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814E18DF60;
	Fri,  9 Aug 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YqlHhUEb"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B542A80;
	Fri,  9 Aug 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191595; cv=fail; b=D4cawS46PoO9xxJuU+l6wU9nDv7/10m84/orGamLxsfWoDFuDRt1MiLKyNNpB/yrcq+w1xcPGl4abtOdgiOvBpRAedNWnzdAKe7UuuDkCpXJkbfPE7xEYkCdX4p7xsGKTfA4xLocOlTl1S0SFGC6FbK/EMGbHADhXrq9f/OMu/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191595; c=relaxed/simple;
	bh=KReTU9ZVNmXINJ7DYPwZr2Jk7r5h5UfasvQtmf+Ftt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KHHY/32lf3VwyHBIQ5qSEV3B5RMCFCrf4ZasIR39kObtXbC17DQvA9qMc/j1fcj/8Y8nHQIm5i4COUyyFkDYJWi7/movW0UDYFVu4xUWLNiTblETQB0RvtJD8INLHVO6culWH90+5VhXafgOMUeKkJOH9BSonzJiUyYpgUDQRx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YqlHhUEb; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp4e95/2HNJDLP+dt/7bKlF7uXscTvuA5mLVpaWZDZz7XRYwt5LP4oqz9/XSnllDv25tSd/kINhhB3ZF4hXaLpvEemqXgJpqSrIhlG2+B3tWomt4P2gQ0T8h1kGg0SNpDeidRHfYIcJg9bFut83IPr0otHvukSoMYdMPCcSRnvBZM/LkI7i/AUlaWJF9sqSviYLeX+Dlce9nre0zM7hdXGz+wh0tiT84sfcncTM4w90olZPGpBSMeBF4z5oTOs23VNWUKnWxBR9O7pLAOOc3MxinLqpGPwu2P9cFceSfl7aP891WskU9Id9NV5g+HyyjKqDT6JRjqfCXUmOymoJpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY+jbxACSYN1cPziumWETJw8b6T4Dcv1UvHKt2L3aaE=;
 b=YgZynrHbxV3OaLv1gWAJdDQ29aobE9NvSyc8v9WmIvRx7EeVP5XTh24MdMVcZk2fw3TPt7iLk/fySkqQxlxsdXrn0/vyMM2jkbiL+BXZAEm1/BsRL1nri0PClcPtn9c6bE7K5O7HAnnCjI9mtTrtyGbaRxCWe9SuEM10hsdN9hFS26AA4vAOlDTGwrncdgAfZOtByV4otgTznGjajB5xiK76VSKZrFfdzQ/TzGfTDF6Dp4bWauztIAJDgfLk84PMDHMcc5dywprPeJbJD91wEydKd1pCE/gW+8WdIDXbuPp3HZnOPPx4tg0geELMvXx+QDdYyAQ5N2av3Afh7qnslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY+jbxACSYN1cPziumWETJw8b6T4Dcv1UvHKt2L3aaE=;
 b=YqlHhUEbyZeYwHjjYdMoBJaWheJtMXzG37OHhDYyWDuat++NBQc8RaI/SX8UZeP0O/yxcnJLAv7WMhDidsP1glpiqyI00MwTu1PZg1HuK2i5mvE/s1fvrfX4muC23gZb4OMISjq9zWbZ5LNHM8VEwtZIJ+XnkZ6n+6lED7tgyp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 08:19:49 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 08:19:49 +0000
Message-ID: <adeb6cf8-1fb6-4bf7-8d36-504b22c366be@amd.com>
Date: Fri, 9 Aug 2024 13:49:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ASoC: SOF: amd: fix for acp error reason registers
 wrong offset
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
 <20240807051341.1616925-2-Vijendar.Mukunda@amd.com>
 <ZrUdOyGiFRH0sRlt@finisterre.sirena.org.uk>
 <a6a0c975-728b-4379-b074-b88ac928c58b@amd.com>
 <ZrXGzmhgyIJ9ID6I@finisterre.sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <ZrXGzmhgyIJ9ID6I@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067EC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::28) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d1de76-621f-4306-5ba4-08dcb84c08df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEh5eEdlcTZKbXNsMVN6dEVlV0NacWhoSkJ2REhEUTk0TkZFNHc1UXZ4dTUz?=
 =?utf-8?B?U29VaTVDRFBVYUNRaHBoV0Q4dTk2NGlSSTZSUFkzVGpjWS9uZFpOMjkyRG9p?=
 =?utf-8?B?UEc3TDdCWUtIZm50TktGOFgwVURBTVU1Tmw4QndobHpFRklkd0ZCTW1wNWJX?=
 =?utf-8?B?c2JBV3h4WE93M09GUG82ZlE1Y3dRMjZvL0ExVkNzNlFLeFFMdENkMys5ZlJU?=
 =?utf-8?B?L1IxREVzczlhT0l3aXgzRVRZY2ZLY1VlakFVL0xWZmVZV0pNcU5JNjNMQllq?=
 =?utf-8?B?VDZ3K1pQaXhxUmdYbzlDTnpZRFRCdlZFeXdYaXl0NE81VVRHVkdSNENZREhV?=
 =?utf-8?B?Y1JEUjRaV0kyUGliaXl2STFIc09HNURvNUt5UW8rTEU2bU5iQVVoRzlTSGMv?=
 =?utf-8?B?ZnZYT2IwQWkvaGx3RFhabm1EV2RpcGpwaURPZ3hpYWdWKzFHQjJLcEk1OVl4?=
 =?utf-8?B?MnVpa1piSVMyT1ZCYUdxT3dISncrbDVRUW0wRmJiSmtXSE5vVE5RamxiRTQ1?=
 =?utf-8?B?TElqM3VNalpEVE13QWdZaU5rM3RvYk1TUDRKV1c0byt0cmlmVlgrVGVJbllI?=
 =?utf-8?B?aWd6aFREcEJDMk94dlF3RFZlRkdqSnU2RXltY0E2SHRRS3ZySG10UXR4R05m?=
 =?utf-8?B?Vnc5Y1pzNG5zaXZiRGZ0UWFHWnVBKzJaYktYektrSVBDenVRTXVNL1VObzBC?=
 =?utf-8?B?eTFFY1NaVEFsSzBVMTBkVzJrdElwaGxnbHRsUEhRTkJQbGd1NGZtK29Sc1Z0?=
 =?utf-8?B?ZG9EWDNBdlhqb0N6Lzhtd1pMekZ0Q1UzSHQrbkp4bmprU05Fa0V3MW5sSEpo?=
 =?utf-8?B?M3gzNUYvVjgycXBndUVMb2FuUWRWck0vSldsWmdVY20wUm9YNVVBV3ZhT05o?=
 =?utf-8?B?bkpxZStMQXhnMVUxNnpZeVAra1Y4dUpGbGZLcm1ha1dzWFN0T2JJNEFrUVhG?=
 =?utf-8?B?VVl3NG1SWTVHdjZ0YnNQZzVtR3ZOZ25hbmVDTXkwcVdIQjBrTGJobVFPdjhK?=
 =?utf-8?B?VGZNUmRWOGlYYWhqR1Y3RUQxYndCT3NnbUo4QjRTQWxZOU9WTTY4RlR5VHp4?=
 =?utf-8?B?UmRmWkJKcHdlT3l0dFJHK3Y1UE4rTkIxUVl6R2VOejBXbGVNcENST0EzUyty?=
 =?utf-8?B?T3V1UHR0RWlLMGh1N1ROeERRMVpiOGhvT3RxRytDdCtneW1rRytaaXgxaHJz?=
 =?utf-8?B?T3pLcll3ZVZrWk9wRUY5MWU0dDlsa0R4YWwwUkZNc0F5ZGdNdURyVlR5dzBZ?=
 =?utf-8?B?T085SXM0Y0taQzk4NW9hQkJNbjV2ckoxZFNPRlZ5Wk13cksxeTlxTTFyMnhV?=
 =?utf-8?B?RGo5RUdRTXFiN3haMUI0cmFmSlpzTmh4UjNKb2N3dGwzcHUrcnB6SFRLL1pL?=
 =?utf-8?B?R0R5dGxIczAvN3NjMkJ4L0p5QjM5QlR5TnJFRitlcll0QitkQnZKemRqblp5?=
 =?utf-8?B?T0l4QTJzMEoxUmFtVTRhZ0RHcTNnRndZTWNiamE2YWRvNnJJRVlPMXoyV0JK?=
 =?utf-8?B?WXNXWGxoZUhRSzFNeDdublNJWVNBeXp0dHZzNzNpSzl1eGlNTzZhd2FSeXFa?=
 =?utf-8?B?aERINDBZaWZzOG9BbkV3ays3dGtBeWo0QlFQbGxyWmdwbC9TYUFud2hITW9V?=
 =?utf-8?B?SGp4Y1RtVnYzdXpvaEVPUFJTNWM3MnkxcFEveUNWWTFIRTJhelRSSjQzN2V2?=
 =?utf-8?B?K2xMeVBvYWd6R0lsVm9PZjNPUUpwaENYTTRJQllSR0prQzZGeUQ4TG9EYU5y?=
 =?utf-8?Q?LMSfVk9BMPntu1s3hs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVZjWXBJNFJBUktJaHJTSjVaLy9YRzZRdkhpV3VNeStsaFR1RlVhZ0pKQk91?=
 =?utf-8?B?VXh4SDJjS21wOGtaVUk4Z3R5dkdsVGtPTnh1dTBKRFlEcHcxRFpxcEVKMzhX?=
 =?utf-8?B?TlZsRVRSajVtbUN3Uk1iMExZOU5FR2ZVdXVKRWZMZlV6M2JpYWtkZE9zVEpv?=
 =?utf-8?B?S2o5UTZsdGxWOCtoSUo3NFlKeEZkUEp3MzErRnhqcmlnTGVCUFlqeHcxTWZz?=
 =?utf-8?B?U09sa1ByWDdjMmk1ZVhMMi90cU0xYkFpcHcxUjJkejBsVHNxcUhVcFo5WVpj?=
 =?utf-8?B?cUlFVkk3U0k5YWgvbEUrK3NtOWY3NUFvajBsRFJlSGwyZktaTFJhREtJY0NL?=
 =?utf-8?B?bkNRRWhlT095UkxXdG1vZGU1TUJ5eEpyajZoYTRucTNmVnhlSFFyeHl0bmRP?=
 =?utf-8?B?WExyTWM1QVFSbWJRajBRMmxKRkpzdC9FejBBZk5RQkhXTlhDWncyV2dOOVJ2?=
 =?utf-8?B?TE43S3ZXM0dVYyt5WGppL2lwUWQrcjhIZ0xlTmc1bmc4ZEF5TlFHTjQxNWlz?=
 =?utf-8?B?bHFzUUNEdWRlKzNCT2N0UDNrY3Z2L1puYkloUVVsR0RvYjljZzAzb3hBRjVV?=
 =?utf-8?B?RVlhYzFIVk9SN3NZSTUxbjZxcHhDbStLNXRmbVJMYVBncWRmV3JiRDdZOE16?=
 =?utf-8?B?RDN0WXRWSzJyd3EzRGdXN3R0VGM4VzJuTGoyQnNSZ1c4endTOEZnNEtIczRX?=
 =?utf-8?B?WWZaTVU2TXNJZ3ZWV3N1ZUozMkJNME9lUzkvWXlWanRQekgrbXgySGhRSzVB?=
 =?utf-8?B?c3BWMXFnaE53VTlFNmluZXpxclN1djZ2U0VaWGpMdWFlNnkvaXBYZzN3eXlJ?=
 =?utf-8?B?cXo4ZkxjZktqdXkzZlVKSFVCdU5EMUxtM0RQOUZiajZBZ0wycWM1WlV2Q0lm?=
 =?utf-8?B?eUF3Q1FaNHR1VGJ6Vk5PUTYxUWJyN1BKOG96Qmdvc1Q0YncxTE5rYmxlTTlx?=
 =?utf-8?B?VXk1QkdMaml2YTVOSHpIVmZWTmFHbE03ZXlEa0tWejR4ajFLL09hZURMSWs1?=
 =?utf-8?B?dFpqbG1FQkN0eXJpMnJPYzlCMkcrYnY1RTFjK011eWh2Z3prUWxhWHBtbjZU?=
 =?utf-8?B?ZWwrdXl2OG9lZnZJbHI2YUZjblBsRHloeWh4ejhOMWRZVU1VVmdYbzVIT3dk?=
 =?utf-8?B?M0s5MWZ0YUk0NHBNaFIzOGZJeW52a3hRa3pzb25VTkluWjVJYlRuZkZnQllt?=
 =?utf-8?B?RnA0N3BLQm9JdUVZcnMza3hBODlmUFlna3c4OXROTDJjT3BGYXNmRFFaUFAr?=
 =?utf-8?B?YkdMQUdZejRTVFppUGZrajR3dU5abmRDT1VsWlFhS3BBVDB1TnVaRHl2dWt3?=
 =?utf-8?B?eG5pNHc1R2FYelBkNEphQUhOdW1MVEtuZjg3SHdrOEFncisvWmZwY05WVjFL?=
 =?utf-8?B?LzA3V29MT2xJOWhka2ROVEFYTXQvQzlKSUs1Q0hkVnFLczNuUFI4Z2ZoVVZt?=
 =?utf-8?B?TkNNMGQ4Um1wd1ZxS3BDdWp3ZTFZTnE4TFpIdU1DUWR3a0xPU3BlVlFXVW1l?=
 =?utf-8?B?WTNkSGw1dm8yTUlDaGhldENrVkRNazlZL3RBa0JqZEx2WWNrck9zSC9qUWdJ?=
 =?utf-8?B?VFNBeVoxTWEvS3dmbTE4S3ZId2hQWjRlM3RVMnAvK2NWbnpNWTdRYzc2R3Zh?=
 =?utf-8?B?WW9HUXNaR2hpS2puTkdPRkgzU2ErRDNJQ3hJemVtZjc5bEwzR3RuZmJUUWpP?=
 =?utf-8?B?UFhZQmZ0RkhtUEpWWEZsUUhQYlRXSzR3V0IvODZQNkJrN3RQeXhDNlBRcldz?=
 =?utf-8?B?aDdyUnFWUTRmTGY0NElCQ2lpdWdVcWtMbnMwY2c1K2swY1Z0bFgxVTlyYjAv?=
 =?utf-8?B?STFGVHpzc3hONGZadUswRmpaNTZCVk13WGVTZnMwMjU5ZzZHaFJ0cU5UeGdt?=
 =?utf-8?B?c1NkazBwTml4MjNQK29odlpYY00yV013V1krUUFEZVZqWEh0bGVHakc4dVo5?=
 =?utf-8?B?UGNpR3BpRC9abTlYbWFlZVA3NGZuWXZja0psRjY4VVBjZy9Ha3ZwTFBLaVU2?=
 =?utf-8?B?Ly9SYlQzVW0ybHZXeUNHT1VkWERDeldWUzZua0ZYdExwd3NrRlNjZGpxVm8w?=
 =?utf-8?B?SXpYTmFDL2pnSUpTWEFCbnkvNHZTd2xCNG5sYTRiNzgrQ1d6YXA3TEtKNmw2?=
 =?utf-8?Q?7WDHJptOMxjaHJAdXJ2wLd/FZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d1de76-621f-4306-5ba4-08dcb84c08df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 08:19:48.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTU9dOY56XVXFrbdg58GyzjxPfC9dzzamv79a0stWVcTv6iVs1JN1IZToRH6KOPBMQegFuXGVOfEeKVuZvCD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

On 09/08/24 13:05, Mark Brown wrote:
> On Fri, Aug 09, 2024 at 07:30:54AM +0530, Mukunda,Vijendar wrote:
>> On 09/08/24 01:02, Mark Brown wrote:
>>> /build/stage/linux/sound/soc/sof/amd/acp.c: In function ‘acp_irq_handler’:
>>> /build/stage/linux/sound/soc/sof/amd/acp.c:407:26: error: ‘struct acp_dev_data’ h
>>> as no member named ‘pci_rev’
>>>   407 |                 if (adata->pci_rev >= ACP_RMB_PCI_ID)
>>>       |                          ^~
>> This patch is part of https://github.com/thesofproject/linux/pull/5103
>> which got successfully merged into sof github without any build errors.
>> This patch is dependent on
>> Link: https://patch.msgid.link/20240801111821.18076-10-Vijendar.Mukunda@amd.com
>> which got already merged in to ASoC tree for-next base.
>> It shouldn't cause build error if the dependent patch already merged.
> Are the patches it depends on actually before it in the patch series?
> We want the resulting git tree to be bisectable, that means testing each
> commit not just the final result.

This patch series is prepared on top of
20240801111821.18076-1-Vijendar.Mukunda@amd.com
which are incremental changes and also has dependency.

As 20240801111821.18076-1-Vijendar.Mukunda@amd.com got merged into
for-next branch, compiling this patch series,which is prepared on
top of it(20240801111821.18076-1-Vijendar.Mukunda@amd.com),
shouldn't trigger any build failures.

Within this patch series (20240807051341.1616925-1-Vijendar.Mukunda@amd.com),
few patches are dependent patches, as changes are incremental.
That's why I have resent whole patch series with cover letter again
(20240808165753.3414464-1-Vijendar.Mukunda@amd.com) so that whole
patch series can be merged at one go.
Each commit can be buildable sequentially.



