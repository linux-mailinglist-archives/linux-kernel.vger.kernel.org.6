Return-Path: <linux-kernel+bounces-236787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D309D91E719
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012181C21ACD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E116EB77;
	Mon,  1 Jul 2024 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="UtAO0ZIM"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2099.outbound.protection.outlook.com [40.107.22.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9A47A4C;
	Mon,  1 Jul 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857149; cv=fail; b=m6hh1cVFKw2GvE5SKpMAfDcr1HvKDgLkhyFqBL4mbidIyNlIRV109Lx5ZB0bfnfncDovaatcirrZ2SVQsRyBW+MRuyAyFS0FD5WGnLsCZQ9mWJVe5WEf2HWpsGoU/oM3u0OEHFHbdc9S8HegLFyH8grTCtu1OtD1c0zzVcEklmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857149; c=relaxed/simple;
	bh=sV4C2TXnLat1axAHGs18mCrkF9H1PSH/JJkgu0G6Ep4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LZ8BtrIouwe7zOHi26RwjV/tCqyF+y+4qMmTUG9ZrF3YZRbZ9wJ/vkHhYjL73p06ynO0KWEuD7BVrNgxNs4GkEtrdDPs4wPcfVbjBDmpH2zkt/mr1Hqs3fRYR7aK4scO2vB/9MpzXVGHTmUXvPYw+7hooVlNbjnQY8xl9IviB/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=UtAO0ZIM; arc=fail smtp.client-ip=40.107.22.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih9ieRCR38GpH5eCbLd/aNm3XDHii/DavyjgX9lRcrBZp2Cm41D2GIkFKvcq0HbCLJMex6XFVUFL+mz9k3fPynrkM/7yPUmhIaGhg8c0jLqDi2RdM08COVgEJQt0qdqa3dhsc0RoRZ8QhGUiVemLBGcq+zeXUuJrbp+StMGCcpqUbE0r63NNUn/k57H6xtWK6HUkm/wc50vK6gS7rdxdVmNWbhqeCeNO09766vVmxgqAtHwsR2EGzbLK5Re8Ewjdub1tYL9nuxEpso6DpC6Ng0PvZMKZFSkDjJYAkIGxRVegAJW/tdtz2NhpiN62E7NEp/f1NRg2LkhWkaz4ynUBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgYl7ufi/s6cOsMme8xCCtfT799SNwrpPfOAURZ5bwI=;
 b=THyTQPu4bkD869vB+cYBpWP5bGdOD1iPRLZ+e/erCPhUzL0Ui1AJEI5PoBSUE/P2/fL7CWBEiiufDF0t6O0kuyxAS+qu82X6y2o/oT4S/DfbJ5PYOUIiHmuuhnvFWkAwRYHlywjR8SF4GR2JB2K0+wW3wjSe4qwdqjQrb2oR2nMPm/abCeBjgknYrMFOQJGolzt97de/Ym3eJgKCs8xrls3SgXV3Zhop5DP31mSVpe0r3g8UYx5maK48kzMFq12Yianx6M9Nhi3Yg9eZOm5EZ8oRz+diQ2d4+mUxfxskZ4kVMwoAdQRdF0jRvw75S8VVgsEn3fMPco60W/5n9iaJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgYl7ufi/s6cOsMme8xCCtfT799SNwrpPfOAURZ5bwI=;
 b=UtAO0ZIMT/k4S2Kc+D0bvSfrgLc75JynpxhxLRFilx13fvJM989yACCmECd0xTXlRc4Qm6G66JsAudXRutI8NhT8gfnMuFX53Bxl1y+j+/E/PlbMnx/jBRLeCGjCbkW/3v7dGfwCsOMepDIzP2AP91SdzgkQ5SAzO7cz1/NOK/c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:05:41 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:05:41 +0000
Message-ID: <1543dfdc-0cde-401c-8ab7-a4f2ee0eb81f@cherry.de>
Date: Mon, 1 Jul 2024 20:05:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hwmon: (amc6821) Make reading and writing fan speed
 limits consistent
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-3-linux@roeck-us.net>
 <615377cf-99bb-4159-b072-7992ccddf09d@cherry.de>
 <9fce6789-edc8-4c44-89c0-ae4ca3ec3315@roeck-us.net>
 <80a7f733-655e-4b00-a802-825d3acaafcb@roeck-us.net>
 <535f3381-2fa9-41a3-896a-8d5879546ac9@cherry.de>
 <8a86272c-933d-45c2-b229-ed10e65d9053@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <8a86272c-933d-45c2-b229-ed10e65d9053@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GV1PR04MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: dace35f8-5d8b-4422-9122-08dc99f86b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2tqbXJCaWI4L1BWTXcwaUFQUUg0amlWK245djJhTG5RbDU2Ukh0WDhXeTdq?=
 =?utf-8?B?Mllkd1ZPVk12NFlJV0QrbTNZc1RzZzloV3RnSGorTlBnT29GWDV1b1JkbGpy?=
 =?utf-8?B?RnkxSHRaL0JmRkM3RWdjcXVKZFhkM0FKeVQzSXJ0VXNhKzN2c2kraWoxNjY3?=
 =?utf-8?B?MmQxMlFTcGlWQmRtQStrSGFTeDBnOXdNZUtxckZKaUF0NFBOMFkraFl0Smdr?=
 =?utf-8?B?M05WRFFRV2NQbXRVTEgzM0E0M2N1a2Rhc05oc0xGQjRmV3F5TVpxVVpVemZ4?=
 =?utf-8?B?R3UwcnM5cjV0TnhuNDllQmI1L2tBOUkwTWwrb3FneWFKTERhd1FFckk5OFIx?=
 =?utf-8?B?WTY2NEMyczdhSlhnalFFTUlQNEdSV3RKRDZpRFdsa0dITkhHSlVxTEtQcTMx?=
 =?utf-8?B?elRacUltL2pjWTBuVzZRVllLbU90TmFsY2x4Ty9qYzBEdkFwTU52cHFiaVFi?=
 =?utf-8?B?NHNuVlJMVERrZHFUbllWYjh3UDBkY3kwT21mK0FJRXZqZzFmMS9EZEdMajRR?=
 =?utf-8?B?WjJrSVFZN1EwNlpzU3gxS1pRRnU1NUhZdkpxdmRlbVpZRmx1Z0xjNU93bGE3?=
 =?utf-8?B?Ui8wUDRNcEpkdnY5QlhqNCsyeW1GQTgwRTZMSHorTGFrdXlCT3ZVZVZmSUx6?=
 =?utf-8?B?SkRTWHJXV2lESDhXUURXbnFSMFdaQURmcXlaMmhZMlpBS3hRRzBsRHh5Z0lZ?=
 =?utf-8?B?VDJESWNoUnNPTG45cFhRQnpiVUVNQXZvT3BFbThsdmlPdHMvQ1N5U2YvUGw5?=
 =?utf-8?B?eGZQdDRYMXE3eTYzSXAyQWhxVGo3RHU5VWpTTjdGYUJRYUtwR0VDa3NVb2tR?=
 =?utf-8?B?eFplYmt4ajdIeGpSTXNpejhCWEFPcWNXaE5qL2E0NGNObHg2WUxlT3hzKzRT?=
 =?utf-8?B?TmlhQVdMT2REeWgzR1RQM3lBVVRwdFkxd0dDRFY1S1NCNmx6VTBmaXNLVU92?=
 =?utf-8?B?UnYyYTlpZURkOHpYeVBhdndBL1ozR2R2YWhsZWgrK0phelZJZlNHNGhxckkx?=
 =?utf-8?B?dlZuMmlHeEVtT0RtNWFMaC9nNG5YMFVDTlUzY0hxNUVRZEM1bkdSY3N1TlBX?=
 =?utf-8?B?RGJsTWtKVzdzZGNSUWhlT1JwcTZBR0RoOXZUMzA4ZGNlc05KMHlyZmRrNUJP?=
 =?utf-8?B?TWNNWC9VQzFGalFsaXY5aHBnMFpndkdzSmJIdWpDK0g0a0NNV2JIZC9hdk8x?=
 =?utf-8?B?RUhYOVZQellyMXhERENGLzZXYllPN1dBRlBIZjJCTDR0SFJhUkpMTWh2QXU3?=
 =?utf-8?B?ZE9wMUF1MGw3QlVxOEFWYXE0dy9xc3kwaWpvY3J2R2FVM0lLU0MvWDBRU1hx?=
 =?utf-8?B?TS91QWI4eTI5NWx2QVgxOThNQmNScXZQcmdNeEJVMFozclNISWFhdkdFZ1c5?=
 =?utf-8?B?YnErVEZQOEYyazFXVG1SYU5EWG5odVQyZFVwcnhCd3oxY1dNb0ZnRHhyU1lx?=
 =?utf-8?B?YndMUDJ0OE11dFVvTldmS1NmL0QxS3pCUUlWMlZCRmhxNSs0MGNhdW5BRTd4?=
 =?utf-8?B?VXBQZG50U3ZGaVpTNE5NMlZDeFJkT05oU0Z0RFJVcDQ3WGk3WXNSdWU3cDYy?=
 =?utf-8?B?TDRYb09FTitxV0FqOTcwS2J4dGozSVc2OWJQbDZBZ2Y2MkwyMTEzL2lQMzRj?=
 =?utf-8?B?RDIxMGRidkpLWmt6dC82dEp6NUZqK3BZNjA4enI3TEFybGl5bDZRVlVJazlr?=
 =?utf-8?B?SHhMdmVEZC9BVUJwOE00MllNcGltbWFsNFl6bWVJK21TVlk3NGgvL2pqdlZt?=
 =?utf-8?B?eG4zOHgxMGFvNUlkSDgvdFBvN2FXaFJwemlwVGRUUmxva2o2NnU5d1UvUW9J?=
 =?utf-8?B?YlY0bjJtZFZxZXNLSENMZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk9FbEpudjBDTWhMVC9acGIrTGNXWm5qTXRuRXhocFh3NHlaVjEzRUtFZlRV?=
 =?utf-8?B?K3BTbW9hNE5ISHJTNVRXd2k4L1NYclhDL0Jta0NORVNZMVF2allyVXYyVWJJ?=
 =?utf-8?B?enRuOVBudFhsTFk0MzFvdytlZlg4U04rU0JONkp2WEpYYWVVSkltckNJS0h2?=
 =?utf-8?B?aTdoWDdoOFNZMng5YnBxSU95OS9uYVhPbnpYczBNdEliK1pDUHdLT09FTVZz?=
 =?utf-8?B?SWtGcTVmb2RtbCtReHpSTUpKQlBmK1ZlaWxJMGhYT0xHSlJsaHVKSzZLWmZS?=
 =?utf-8?B?WUNPczJrVnFBZ3pZbEN1Q21Gb1J3UlBEUmpLb2ZWeTBDWXNTbUFJUW9mOTMx?=
 =?utf-8?B?RnlwanhiakpHc0VJM1NUb0N3Q2dpQWQxT2lrc0xpOE91WnJ3Ync2TWtZMGRx?=
 =?utf-8?B?V2lUVVhIMzdZbnp6elJDMkRxSVg3U2hyak1BQUxmcndkZ1F2eHMwWkFyRTMv?=
 =?utf-8?B?UnkvSHBXYnRkUmhScG53WVBKM0ZjNGNRejV5ZWxDQ2hGSHdaZ0k1eHRiaXBL?=
 =?utf-8?B?b2lyZ2owaEQ5WEpUbW9Za3hqVUErUXBocUJZZ3dYai9RRjRnYmpsMk4xSTRW?=
 =?utf-8?B?bStjRURldUNKeWhoaHdQZnE2Rk9lWHVEd0hSdlY3MlVOc1hLYjgrV0MyUXJL?=
 =?utf-8?B?c2hjaDBlUlpWTDhDcDVDcG1mbDhaNUlCM05MRGRFcyt0SzZmZktHeWdNaXdI?=
 =?utf-8?B?ZmdIQzczS2hZdUhxT2djNmhUWjFGcVp6WTdVelQwRXZES0Yrd3VMRktrMXE5?=
 =?utf-8?B?d3lqemlYSXVCYVBiU3pFVmNVQ0NUbml6eU82c1dCL0xSUE5MYVFxSlpyNnpB?=
 =?utf-8?B?OFpnQjM5YVo4RU9sdXpoa2MyaVd6aGFaTEEwNG1kZHVBaG1wdFg0U1JZTHJR?=
 =?utf-8?B?RUJQWHpWQlhKYkcrNTMwYlVnTjJLb2VseWtXSGlsRDkzejU1M1c5Qlk5enRT?=
 =?utf-8?B?dlo1b0VIaVNHU1hidGg5YWxFNHZDU2huWThUQ0M3aXlJU1A0UUxiWmRFWFRV?=
 =?utf-8?B?Q3BobTgvbVhLUnN1ZTV4R0F3MXZUNGZLcys5b1FsbGRQM29hQTYzd0lRQmo2?=
 =?utf-8?B?dFBJb0NsdC8wdUlrMTN3TWFFUzNZRHdKZVRHUFlKcXk2WlB6NUhwbEFUQ1pF?=
 =?utf-8?B?c1Nid0t5dUxxa3pNS2ZRcmVvb1BNd3FaRUZycktxYWxZeGNLNCthaWlab1NW?=
 =?utf-8?B?Uk5CUWFhQXFmWVV4MDM0MG9tUzNpQ0xQMTBhZWV0QUFLSGozTGw0bUxtb3Nr?=
 =?utf-8?B?QkIvNjVGRGFqL3EvbkRsc3ZlVHNCY2psTFZkbkNkL0VJaWtveGhiVlBsVCs4?=
 =?utf-8?B?eVFKWENSaUpWUzY5U255OXEvTE45cjVaSXdzeEZtSkxWa0RDM3ZRY1ZHMTNw?=
 =?utf-8?B?bFBzSExlQUlFNU5oaEVIb3hudi9tcjQ4aHNCU0VoNjdvbHJ3RzRjVTliR0F5?=
 =?utf-8?B?allBZjZIUXhZZ3QvVmRDNVJhMktjY012V0w1cm0wc1dKUG5Ib3FJQ2N0eDBY?=
 =?utf-8?B?WU9RU2hTY3BlSmhvcG5rbm9qMi9ubEJoM1NPQ0NVaEZIdUx1RnNNb2szSkFF?=
 =?utf-8?B?dzlOazBScEM1eUhxL3NEVEFpVVNmM0Vua3VKUFNnMDZLd3RCNVpPb25sZFh6?=
 =?utf-8?B?dlZCOEdCS3dQY2hPcVZ1SUZJUjlvaHlsUGM5OGpIazJCUWJBcEdLTWtYVFdQ?=
 =?utf-8?B?WGppaVlJc2EzNzFETUFWTXB0RFJya25oMkFYckVQZkJZcVZsRm1kOHF2cEM4?=
 =?utf-8?B?bkVzdmVtekIyZmkyblpEVkVNSEhmenlaWmY1UjduM21ZU3lmS0srS29WMWpN?=
 =?utf-8?B?VlZwSk5vc0VpK0M2M3VaZ0E2Vk5pZzV3djVwcWJsVElHaE9IdkNQVmd6Wkk0?=
 =?utf-8?B?djgvdTFNdUlNSW5jUmtSaGh4aHZraG1MUW9LMzZxNjRXdU9YQit3MVd1VkZI?=
 =?utf-8?B?bU16b05JaUwwaml5Zld5RlhidFdLdzRtbVd4dXFKMEM2MG1Yd0FFU1JkODlj?=
 =?utf-8?B?Rng5Rm5lLzdXd1ZuWDZWTjRlM1dJZHl3eFYwdS96OFlXWTdYQTlhdnBoc2dx?=
 =?utf-8?B?VUZSNXZnYzE2ejlTMDZCSlNWSmZnS2VHNWl5MEZNdzA3aG5DNURsaEl4RjFj?=
 =?utf-8?B?Wnc0Q2VIZUpqSFVtcE1XUjVtYlZBakJ1c2VUM3VGUm14NUduNWNSdjVJa1dJ?=
 =?utf-8?Q?UKFlvEgrMvYUQ3+C6QUbQEM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dace35f8-5d8b-4422-9122-08dc99f86b85
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 18:05:41.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSaUb2+uLN/I3G+LG8cvXZb17a8eJYj5UALuat3sIV6O80SysUTXxVt+Md/2ciGCOQ/qAIlNWfKNGc37f7sR67m8+qO/rvXgXvh2NKj5q4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244

On 7/1/24 7:21 PM, Guenter Roeck wrote:
> On 7/1/24 09:13, Quentin Schulz wrote:
>> Hi Guenter,
>>
>> On 7/1/24 4:37 PM, Guenter Roeck wrote:
>>> On 7/1/24 07:11, Guenter Roeck wrote:
>>>> On 7/1/24 04:05, Quentin Schulz wrote:
>>>>> Hi Guenter,
>>>>>
>>>>> On 6/28/24 5:13 PM, Guenter Roeck wrote:
>>>>>> The default value of the maximum fan speed limit register is 0,
>>>>>> essentially translating to an unlimited fan speed. When reading
>>>>>> the limit, a value of 0 is reported in this case. However, writing
>>>>>> a value of 0 results in writing a value of 0xffff into the register,
>>>>>> which is inconsistent.
>>>>>>  > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>>>> ---
>>>>>>   drivers/hwmon/amc6821.c | 6 +++---
>>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
>>>>>> index 3c614a0bd192..e37257ae1a6b 100644
>>>>>> --- a/drivers/hwmon/amc6821.c
>>>>>> +++ b/drivers/hwmon/amc6821.c
>>>>>> @@ -601,7 +601,7 @@ static ssize_t fan_show(struct device *dev, 
>>>>>> struct device_attribute *devattr,
>>>>>>       struct amc6821_data *data = amc6821_update_device(dev);
>>>>>>       int ix = to_sensor_dev_attr(devattr)->index;
>>>>>>       if (0 == data->fan[ix])
>>>>>> -        return sprintf(buf, "0");
>>>>>> +        return sprintf(buf, "6000000");
>>>>>>       return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
>>>>>>   }
>>>>>> @@ -625,10 +625,10 @@ static ssize_t fan_store(struct device *dev, 
>>>>>> struct device_attribute *attr,
>>>>>>       int ret = kstrtol(buf, 10, &val);
>>>>>>       if (ret)
>>>>>>           return ret;
>>>>>> -    val = 1 > val ? 0xFFFF : 6000000/val;
>>>>>> +    val = val < 1 ? 0xFFFF : 6000000 / val;
>>>>>>       mutex_lock(&data->update_lock);
>>>>>> -    data->fan[ix] = (u16) clamp_val(val, 1, 0xFFFF);
>>>>>> +    data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);
>>>>>
>>>>> This is an unrelated change I believe and I would therefore have 
>>>>> this in its own commit with proper documentation in the commit log. 
>>>>> Indeed:
>>>>>
>>>>> 1- Change in fan_show handles the default 0x0 register value (which 
>>>>> can only currently be achieved via the default value of the registers)
>>>>> 2- Allow (re-)setting unlimited fan speed by allowing the user to 
>>>>> pass 6000001+ instead of clamping it to 6000000 RPM.
>>>>>
>>>>
>>>> Both changes are related.
>>>>
>>>> The whole point of this commit is to report and permit consistent 
>>>> values when
>>>> the register value is 0. But you do have a point - reading it after 
>>>> my changes
>>>> returns 6000000, but writing the same value sets the register to 1. 
>>>> So I think
>>>> the proper change would be to display 6000001 as speed if the 
>>>> register value is
>>>> 0, and provide a more detailed explanation. Would that address your 
>>>> concerns ?
>>>>
>>>
>>> Ah, never  mind, I'll do it differently:
>>>
>>> - If the register value is 0, keep reporting 0.
>>
>> Or...... maybe UINT_MAX?
>>
> 
> Problem with that is that disconnected fans would report that value as 
> fan speed.
> Traditionally drivers report a fan speed of 0 in that case.
> 

OK so the issue is that the current fan speed in RPM could be 0 because 
it's disconnected, or because it exceeds 6M tach pulses.

> On the other side I agree that reporting "0" as "maximum fan speed" doesn't
> make much sense either because the real limit _is_ unlimited. But reporting
> 4294967295 in that case isn't really any better.
> 

Agreed, but I'm also wondering if there really exist fans at 6M+ RPMs? 
Maybe we're discussing a scenario that just doesn't exist (yet) and that 
we don't need to handle?

[...]
>>> This minimizes user visibility of the changes, and also ensures that
>>> the reported fan speed is 0 if the register value is 0 when reading 
>>> the fan
>>> speed.
>>>
>>
>> But didn't you say this means the fan is running at unknown 60 000 
>> 000+ RPMs? Do we really want to return 0 even if the fan is actually 
>> running? In which case max < current (possibly) but with no event 
>> happening (which I would expect, reading the datasheet).
>>
> 
> Did I say that ? If so, I must have meant something different. The 
> register counts the
> pulse period, so, yes, it would be 0 if rpm is above 6,000,000. But that 
> is really not
> realistic. In practice I don't know what the controller reports in the 
> register if no
> fan is connected - that would require real hardware which obviously I 
> don't have.
> 

I'll forage in our shelves tomorrow if I don't forget, trying to find 
one... if we have one.

> Overall I think I'll stick with the minimum, at least for now: Permit 
> writing 0
> into the high limit register only, and otherwise keep the currently 
> permitted ranges.
> 

Works for me, we can always revisit later on if needed/desired.

Quentin

