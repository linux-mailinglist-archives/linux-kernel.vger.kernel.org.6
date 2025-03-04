Return-Path: <linux-kernel+bounces-545167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B516A4EC3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FE588637F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC882853F1;
	Tue,  4 Mar 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XEsu+ODt"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563562080C0;
	Tue,  4 Mar 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108890; cv=fail; b=Zx6LLllFiDqO4JeGsK1ScAQRhD2nFt/4EztRy6nA1Dk1RiNKmNUH+hPlcZvy3IP59HtrfqlMkuxWSNI6OJ0jpC6r3sPnox8zv/nkgMlHaMOWqKVpShHzKWcdUvnOcRiO5P0zS43Of5ThFcK9e9XGnw1U6jXY8qEzN0p93kVvjck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108890; c=relaxed/simple;
	bh=RZS21/EwVz3RWaKw2AYwO/Q9ce9YYVBE/raThNkoUdY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XIDcf0dX/NKcTpd/IlfyUHAb+o2qukx/nNkmXKy2k6Uf1Aa4I0uK8aTptMX8jrRa2/of84Nwhf/e5ajblKah18c+YQPPPasJXtOq8Zseys2DviA3Q8b2niBNAxMgbwoaYWkPoLfTweZOt8if5xqT8Zzl1r81zlbDOEb4/+xBSV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XEsu+ODt; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzbm54/zXwUr8MT5ifuBSAbHDN4AfpN5Is9noWU2vukjnQ4FCDvpo16U0ecqi57yBd2onuwKZs/7sa/TcvGF1tqafJJ7rRufQ1zFyHHElcONgqyW8oPPcIo28dBeOMdyrjLO21t6eubcaZdKwlmV7aEgSMpuQLf2Pps46AoRCdvmxeCQutFOG7PXwg+qodx5ZKTC1uIU2Gf2WG/SawPPNShF8zrrYr3eP7tCn6HykbxKGjiUq/D68Dig8L2dVSbP16R4U0pDkLagcsLbgNEX52hVmRL8pbaRPHLusZhXrvCNUxoWJ4qZIo2UfPILGDhYt5FVrjTPBeOTKEd2YNeNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nuqwSSXy7rWgNWx1utwah2EJnM/1tXRKTstbhXmZkY=;
 b=lm4Rg0Z7qoepZXQfhA2Ka6fftCVMhANKINS125Dri5CtrQQKkyMpL7E/+157tU+iSNN23A75n2PhCZ/S52K5Yd3xIq3n2qNJ3gQunvhmgDsnaTUeDM3ZndRI9QCpLMsN7f0fKSX0LBnVXJVunYV1LcvPWZmWPvbkodRYtpPT6tM09oD283JsW5gZmlUl5muIbrX5EHFabdzrsHopgCxS/GtIe3OTtAS/XZ0fmiHblYj4RuFlG09Ioq5l1SarWh3Q1fDTGQzlB+fPQSBYI7pWS3hjHwneoRlK2X3n/esY52kezpAH3s3zekFfbsGrZvwb63joDJBgtxhIaBzve4Feqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nuqwSSXy7rWgNWx1utwah2EJnM/1tXRKTstbhXmZkY=;
 b=XEsu+ODtZfwn5LaDzINP5Nq8LQ/8qg6dTjKYAiBDkVoSU0YUrFrCRsC4AP7nihhb6zkhNVhNTvmgpNhHoGvkGPwVO4l00fB9NyOC0hZFETxOrWBazPNi95xadKgBA9kQ7s8+eN/LirKfl8k90GhSNS6duM03bBzsNhqlZVpyeLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 17:21:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:21:26 +0000
Message-ID: <6fbc6b5f-67b1-4b6d-b590-a3858d00ff96@amd.com>
Date: Tue, 4 Mar 2025 11:21:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger:
 Make symbol static
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:806:27::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: ae579a8d-b7d6-4da7-96fd-08dd5b40fe65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWdrYkRMbmw5MTY3T3pQRkRseVh6TThzdXZWSUQwbVdpYmNuUkhhYkpvcU8v?=
 =?utf-8?B?QlUzbG5MeGt0Z3dwaFZFMFFJOFdNS3JQZjJoN2hvQlk0V20xSTA5cGljRkFY?=
 =?utf-8?B?eHYrS1loQ2x5bS9valY5dzZXTk92a3hkOGtZV1UzU0lRejYwbDllSXNBVVpw?=
 =?utf-8?B?UnYzTFZQc05zVjhobHR5UHZQdkVkb0p4WUx1aVNRbkpXQ091dkJRT2QrNVJs?=
 =?utf-8?B?NnQvbmdqaURFcHZzSGwwSlZEbExZaWNubnU4ZGQ3akNSNS9MY21EK3pKNUtU?=
 =?utf-8?B?d1NXNlpHWVZNRmNwQmhhbnB2b2xQTDFKREZJUHJFa3R6WmY2amFrWk1YdWRL?=
 =?utf-8?B?cm1VdnZWa2pGY2svNWZTQ2MxNHdVelZoVTU3SU82RjZnRTFuOENybW5ISmEv?=
 =?utf-8?B?UCtQMWkrTDJ5dTlscVpKaGo3V05tMWpDMVVQdVNBVkh5dERIMzRnbnJNTlRT?=
 =?utf-8?B?MmMwZzdoeTBzeU9iRm8yVVJiNURDbVZjSU1Ia1MydjQyYk1TOTdZbzVGS0Nw?=
 =?utf-8?B?Q3Z1aUcwMm9MMXNWYlpCTjNSM1Z0NHRmWTBzQnpRVmdNWUVjZ1VyL1B5RWNF?=
 =?utf-8?B?RUt3dWtsdnBaN2cvbEV2Z290Ky8vaTBjVUFGOGxyYzNzL01PQjBBakxWcVdB?=
 =?utf-8?B?YUlGZlUyeWZuUmJUcmxXVjlVZU03NW51b1htdVhQdDFucFRVMnlrLzBpam9D?=
 =?utf-8?B?TW5aV0VmSTRUbEwxUFdBZndOZjF4MFZKNG9TZ3o2N29jeGpZY0x0cklyL1FE?=
 =?utf-8?B?d2N5VHBoQmVwUEZiRS85MWViSmJOTFRTWGdIQnZlbmxDM1d2cmdCWmYzVFdj?=
 =?utf-8?B?RDlIUlFEK1h1aEtJbWJ6aVN1dUdWYy9kUEVkMll3OHoyM2J3NmRyWStoOHAw?=
 =?utf-8?B?ZW1IWUtNUWhiTXJFMjRtKzBiVGNjRWQyaGtsWnd3U3dPRVUyeUtiL1IrTmhj?=
 =?utf-8?B?djdxMkJNU2x5amlKNnpsTnBUbXIwRkRydC9QcmdtdE9qUFU2L0k0eTR0N0N0?=
 =?utf-8?B?b2FCNlZLa0owUThVeWtQZVJkRFNoNUpsdGFzNzIrNWxyQ2d4TEFpbjI1MmFu?=
 =?utf-8?B?S3I2dTVva3JUaFdxMXcrTHdmSmREUUQvREphUkNYQkFxMkxGZFBucFF1MElw?=
 =?utf-8?B?MExyUGtGZGpnNlNxUFk1di9PY0JOZUhpUDcrV3pOWWpZei9HVWNrWFpZV1o5?=
 =?utf-8?B?cFN3RUg2QkJ5V3FQRkNXaDZ2aGZyMUdLSm1LdUMvSFBsRUhjbUZYaG1LVzJS?=
 =?utf-8?B?cjE4Q1VvbGlTNi9iVHNBSDNPUytSV2RNam1JZjhQVy9TUnllWGswTFpJaERM?=
 =?utf-8?B?UlM3eGN6MmxrcnJDemJFc3FsK3I1SE91cFpHSkUwakx5MTdxbHNXNDcrR0RZ?=
 =?utf-8?B?NHV1dTJrZWh2V0tFM1U1cjlKV3BtaWFVS2kxNSttRWNsK24vQ2hiR3k4SUsr?=
 =?utf-8?B?eDZ1Q2xWR3JCdnJxZ0Q0RWEzdmNtditPeWZGS3B6UllHYWgvbEl0U0ZaNzlN?=
 =?utf-8?B?cklBcUZObmJUcEhraFJ6cUJNVFhVQk53NnFyak9jR1hXTy94NGIxMVN1Mk10?=
 =?utf-8?B?S0NQNERwQ2lEcmpsdUE1UVZMNXRRQU9LZ051bVdBekxoT2hXakg3TUNxTVhq?=
 =?utf-8?B?UmcxeVdiRitFc3JMdDE5R1FkaE1qRjJqdUpSTENva3I5TTM4SVJKZmdVc2Nl?=
 =?utf-8?B?OFZ6Q2g0dFpGaFpJOFhvZU9HUVFkbWUzYndKMzNRY1YxOWo2UzQ1SThIT3lQ?=
 =?utf-8?B?c2F6MVYxNC8xVWVBVG9PVGRtdDhoaGhIODQ3WTRvU1FVb0Q1TnJqb1RFZCtJ?=
 =?utf-8?B?S1RaQUJtVkxUZ0NSalBocmtuaVBIUzhKUFN1aGdBbEtBQzN6Nk1ENjlhOHdw?=
 =?utf-8?Q?tBn0O4RQcJY9p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3pyZ1U5L21oZXhtNGtUTXJqczlBMWtnWHB2S2p6K0lXRWhYNngxc3Y3R0t5?=
 =?utf-8?B?alNsYlRlL3BIcnJGdFVyemlpVzlzYnJOQktwZ1I5TkhHSjdxTjdkY04wYkhx?=
 =?utf-8?B?b1d6NkFBWXFBTDJRVVBvSFVXSkhZem5zb1U3b3poYjlZWGl2TUNsNnJPZnpQ?=
 =?utf-8?B?SjU5RDRxV3VQZWVoV29GazVmUGxManlOY1VibHpkUkR4SlF1RW1ZRWdBbHFp?=
 =?utf-8?B?ZFliTy95NmF5WEg3TG5waVc3UnpKRitZRDdnOHBJQjNub1pPSUh3RmNyTXZM?=
 =?utf-8?B?VkM0dXhJVzlPcVFNc0RwZUIyaFprZlgyMFFhTHB3NktRNG5UUU1YbnY5ZnNz?=
 =?utf-8?B?NlN1L0xoNUFrUndnUWk1QlpJZEowNVY5NmI5Si9BOWdzd0dSM3ZKNUNoUnlQ?=
 =?utf-8?B?d3UvUUNMcFZ6UzNyVHZEbk8zYTFPQ3IrU25xaks2alFIeUVXbURVLzFpK09P?=
 =?utf-8?B?K0RGUkJoTHMvQ3BFWGRhMFFoWDhxWlNqNEdwa2JyTTlQWHJEYWtuRGlkMkVs?=
 =?utf-8?B?TmF4SEkzWit1ZkNMY2JLc3B5a3ZVREhZejhOaTYzaGtMbUFPa20yOXNZanF5?=
 =?utf-8?B?RkZPYW1ETS9MbDRhVUllVVVqT3Vhc2hIL204aTZrK1YwMFNxNzJGdWVMVUNB?=
 =?utf-8?B?VjBJa095ZndrRVZaVjMwZHVta1Q1NjZ6KzNkMkdhRWdBVkFSNkxkb0ViU2E2?=
 =?utf-8?B?NzVnamVPdERPd09YdFNscXJiMEpKVTBQY1NRQkNZV2RYTmlZRmJZT1M0TWcz?=
 =?utf-8?B?SVY2dkhvaW9OSjBzbkhqTzdFQmRrTjVNenBwMUtOWEtza3lBV1d2OUthY09q?=
 =?utf-8?B?SktsYysraW1iZEVycVBGY2dhOFpjeHJocmhRdnI1R3ZVQzJPOHU2Q0NYUDRw?=
 =?utf-8?B?WjBRR0REbXdmRWRNZm9yZ0xvMFJOMURnS2FVOFFZdlBEMzRuRUJMQ1JrcWRQ?=
 =?utf-8?B?RVlLWGM0NE5SRW9sSjZ2QnVJOUZVRG5TWWxyTTFWV1lram04aEdUS01RSVZ4?=
 =?utf-8?B?VUdyTkMzd1FPaFloekpDcjBHUitRTTJZNVpYT25PSFFTTms1RFFYRHBlREJ6?=
 =?utf-8?B?QVJYQmxLaDl1aEtmblFYSW8yNWQwV3ZHYWNOVHljZWNKb2xHZUpwOEEraTBT?=
 =?utf-8?B?elRRU3FFejl6RWYzNDRMdVVzYXlpbVpwMXlnbHBaT2pPdnplWkhvUlRNT1Rq?=
 =?utf-8?B?OFc1TG5tcThYZTBFZnI4QVlncWRPcDVFeElaUjhMK1lSL2l2MFdoVzJxMklu?=
 =?utf-8?B?YXQ5RVIyanB0bnk1eWpsY21vdHhLZkZCdXZSY0RZb2NDYnFGNXhNOXlMOXRY?=
 =?utf-8?B?MWVtZzVuZE9SVXU2KzliU21HOW52MGxTYmRBamxKaGI0cTFob3lpNVJiVnJU?=
 =?utf-8?B?YjJNRXBwa1ZYU3Zxb0ViQWRUVEZhbHM5Yld5ZVN0VGxPUy9uTlVUVEEvWk5E?=
 =?utf-8?B?VzNMRmxVZU1Xc0RqMWJvU1FSbWNkUmdnUDVhKzdEdXpMOExQbnpNdkE2ZEZW?=
 =?utf-8?B?b3JVZkNiaW52V0MvMFppN01aM0MvS25DQ1FIYk1QLzNoamZEM2RHcy9yTUF0?=
 =?utf-8?B?SGFqMVg2a3FqZ3F2NXNDYmZCdUpLVlZnRXhhVjNMd3lIYzB1Qy9uTkZXanZL?=
 =?utf-8?B?a3ZoSExpWkhSU0t2ek1NOUN0UXptTURnOFRTV3hLbG9sb0h5SmtjOWNKYzRT?=
 =?utf-8?B?eWYrWkh1Z053VXlHckxtV2QrSnMxVlBodjRsTllOTEUwajJ5RmJVWEd4OS80?=
 =?utf-8?B?NGtNUkFjVmhvaGoxU3ZEeDZLZjM1aVVLSlJhaWxvMEd0MkY4aTR5KzdZWXdN?=
 =?utf-8?B?SXI1UjBQNHRTRC9tME41bVJYTVJSUTNweEhLdmVaMkYzTjBMQW1nZDBFNHdI?=
 =?utf-8?B?UUR0N29pdk1ndmpJcjdmdDZVdjhlOFpTUDY3bGNHbXQzQ0l3Ukp5TDA5c1Fy?=
 =?utf-8?B?cG05Tk1BaUM0eHJLdjEwNGlCSjJXYXBNMmRIbFBUOW45OEJkbjhrcVdMM1dL?=
 =?utf-8?B?NU81MXM5dXpFeEU3MWhHUU5Ceko4dFVNTlJNRkVUZmgxNGtJczcybzNENmU3?=
 =?utf-8?B?dG16Nzk1K2Z6OEYvZTJwd1M3eWlWeDFXM3c3cHlDWnJFK2JNOXZJVzZIUk9L?=
 =?utf-8?Q?MKz0rAl/ex2WXVNtblGWB4BWr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae579a8d-b7d6-4da7-96fd-08dd5b40fe65
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:21:26.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1rVuoY8jy7WujwZ02j+KG9qZg2YZI/+jsfkIUvA/RLdyuKFJAO/mxs2vrLfk6aZ6VFYvrOLb90WTI/3T3eZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472

On 3/4/2025 10:06, Ilpo Järvinen wrote:
> Sparse reports:
> 
> lenovo-yoga-tab2-pro-1380-fastcharger.c:222:29: warning: symbol
> 'yt2_1380_fc_serdev_driver' was not declared. Should it be static?
> 
> Fix that by making the symbol static.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Fixes: b2ed33e8d486a ("platform/x86: Add 
lenovo-yoga-tab2-pro-1380-fastcharger driver")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
> index a96b215cd2c5..25933cd018d1 100644
> --- a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
> +++ b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
> @@ -219,7 +219,7 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
>   	return 0;
>   }
>   
> -struct serdev_device_driver yt2_1380_fc_serdev_driver = {
> +static struct serdev_device_driver yt2_1380_fc_serdev_driver = {
>   	.probe = yt2_1380_fc_serdev_probe,
>   	.driver = {
>   		.name = KBUILD_MODNAME,
> 
> base-commit: 432c2adb9e2f84f81c4b218acb07a2cd3dce64a9


