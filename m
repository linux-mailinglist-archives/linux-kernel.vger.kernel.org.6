Return-Path: <linux-kernel+bounces-371859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37189A4166
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A30D1F254AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354E1DA2FE;
	Fri, 18 Oct 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NGxQ3Rs1"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F320E312
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262531; cv=fail; b=lCjP8hFM+Kyg49FQbzH1K6BYXejPehFed07qoxJPS+xhzbGQvKd3KvwpBZMflaNehx+4ZQ8hAR+5GXoD9jtJX3Iru2vCkvdkw99ZAiDd14jorFGpK35iijEXaB0c3oiEK1VYcuvigWexL5r6xipW6eBJ/oMKGHmlBN+I6hBzHaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262531; c=relaxed/simple;
	bh=AQMcmvPZg4Dt7egcKAbOjI4ZxMf59Dq0QxKze7OjyhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mUm0pTdkPDa3py517v1lTfrTCXCm4xY8EN9dYNxGu2T6VJuu/ZIk8VzJtcTSlefV/Th1+OyFk4OA5RsegDjtU/UrNliIMUhj8jpCoC+1O9VTTy38m2ntHttgybDq7zJAISwfPNXsLN3t1kWQsv8xyvX665EXe4JvqFPqv1q1eV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NGxQ3Rs1; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgY/YFZNFhsT1zXmYCwVD5DOIRZc0ZKCImmZ5tkfn0oKN7DThISaIf+Uo4enuYpSHkwXQVbiZuywb/2oyvfxjxM0wz+rZT4ulAO31DkXJ5sPqIGYOhesLsLqmaMXSqWBamOUqTOwNlaLKg2LQD31UcHnmZTrOFllm+Y7nZyHcVKhEnXhhP/OjyQtvdRGlQEpn6hQrimmCTSc6X0F0EK5yvAoutvHASbn4LjB9PFYwnClLRk4YlkNpFsYFyKpRaUxDfxTSABtLLk2X1FnYwxew0a9E4wYrplIxWEan8cya5qUk+xHAivqBBQPsZ1CldpXK0/FkM1x1JPvKDuPLUMWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1IgB3osJlX+f1siqlI+9nOcRQviZx1awCnZklGqraA=;
 b=Pc1sJ3OpeLFubGTeS8jVcgsXn777pE0WJJYTUtKU4dEh8ZB7l5O3eqQ9yS0QuBLdwh13/b1c+4OGe0vbVUZjeBKhew6wq4XlycFGwJrzjkuo1Q+rZmgVWqs8CwNiXvtOu/4JVgeG5OTf1AJotW5rR2QGjHkO9RV4DIoGsqWzTNjDyZpoy0D2af4V8Ab0CzEQy3IHrwsTY1CahJpypivIoFl9P32pVv9IIvUz6UdvRUPMnLQ3wvCBWrlyFDS6zohk3Wt9dMZAHhtag4F9yX0we5Ryb2a9O5cxjG+CEm55QC9RTlQ2Q2u8DH2zy0f6RHYlYMnigxEp53CjiSeJFuNGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1IgB3osJlX+f1siqlI+9nOcRQviZx1awCnZklGqraA=;
 b=NGxQ3Rs1/tmgl0s/8AENf+bFBctTvChFDZqYcBtzAPGn82Rq1AyZ8uPNXc36EjHPW96ThmNhzcmuLEbdTG88GvnN5nNEadenVRcqTLhDtlvHZw2JlSsmTgKMXJfE43XwDD0ApfvBKBDqmt9RxNEhn91z3zkai4wsSR7erjBxAtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 14:42:03 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 14:42:02 +0000
Message-ID: <c2a51588-4b5d-dff4-2bc9-719afa818490@amd.com>
Date: Fri, 18 Oct 2024 09:41:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 7/8] x86/sev: Add full support for a segmented RMP
 table
Content-Language: en-US
To: "Nikunj A. Dadhania" <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <333a437e6412a27ee666e10c2aca568985868ed9.1727709735.git.thomas.lendacky@amd.com>
 <d20e0333-4710-9153-a687-05b708769616@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <d20e0333-4710-9153-a687-05b708769616@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb8c1b2-183d-4885-d7d3-08dcef830783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHF3VGFOYzNXdUNrRVU0NWQrTUJ0RkEwQTVMQXVuUWMyem9nZzBkWGE3dU1W?=
 =?utf-8?B?aGxGQnFZSHB2a3FDQXBDbzVzNGN2Z1lKWEJYZGZwcURnVVFxUWtBT3l1Q1NF?=
 =?utf-8?B?R2lzVXhEVjYwSXNJc1hxUmVYR0lDeE40M1pGSW0ybFpYWG9Sb1dmNFJtcHVr?=
 =?utf-8?B?OU93K0RoNncvU1c4cHNwOXg2OElCaVBjZlFmZU1LbFNyMUdPM29vaHo2Ynh4?=
 =?utf-8?B?Z3lQZndlZ1pqQzQwMWdpTk05eDBFWVJWSHhNVjAyYW1VTmF2cGhLbmZudWJO?=
 =?utf-8?B?LzV4WEFhemNGbDFmcFRpOGIydDNRNk9lZ3BaNVBNbUptS2hHdEFxVGNZT1F3?=
 =?utf-8?B?dHJWTnVrRU5NVzRaclQ0VzAvWWp5enhxeFBCbjVjbk4vdkcyeW5kcFNreWVS?=
 =?utf-8?B?ZWpsbkIxMlFZei9nRU9EMmtLeTlHMyt4SHlRTEpFZUhIS0t3NjUxMW1PeWhW?=
 =?utf-8?B?ZXgwMlRwQnNiN3VlVFgwVmU5bU02M0NYcVhQMkVCZWtPWU1SLzRNOThWWExv?=
 =?utf-8?B?SGZDNHE4QitmWDdpdWV5Q2RkdGlheDBnTUVFZCtmM0FYaEx2Tm9RL3d6K2c1?=
 =?utf-8?B?YXJvN2ZNWmRTN2hvQ3Q3REJZU2J6cUEveTdtcDZTSHowUWRrdkVJU2ZGam5h?=
 =?utf-8?B?Vm9zNVdib0ZYTW1QL0hMQlhnbU1SMnE3SnVYR0V3cDJsc01MaUFOdDYzRngr?=
 =?utf-8?B?MEVPR0lLNnExbXREbExNR0dWSGNYMHZueXJZdWR1cmd1Rm15Z1pFRTRkczQ4?=
 =?utf-8?B?YUU3UEt3dUVpSHBNWXJEWGo5b0pxS2RuaGdPc2NaeG9FdEUvQ3hVQkdWdkZq?=
 =?utf-8?B?KzFFcXY5ek5JT3ZYcmNETjJKcmhuNUc4MWI3dTgvajBHakpLR2dGcllMUFJH?=
 =?utf-8?B?ZStacXhPSVVBdU1ORzJtbUZyamI2UFhRZFU2Ujk2T0NhcmNMUmdFRHUxV3dJ?=
 =?utf-8?B?cjdzaTVuNlhCaCt3STBma1ZkdG5wbVJSWW9sQ1ZnMC9ndGxmRktGMlhQQmNr?=
 =?utf-8?B?WTNZK1B2bVgwOERpMWpQMVE1dDg4dUhmMzRsTHFZbEVST0Nnd2NaYzRkNmVN?=
 =?utf-8?B?NmtaTUJCemRwb1ZjUHVmVDhvWHlqc1crMkY2VHBUMnhaR00yK21CK0dzNGJY?=
 =?utf-8?B?UDgwMThYYlFIeEhrWndSMDZldm1hZytsWGttUHpQZFJmYmYrbEg1a0N3MWtM?=
 =?utf-8?B?UlhpYkJmdW9GaXBza3pIb09CeGVmN2hSbE4rVjBYQmwxejd4UmVXYzhPaHdU?=
 =?utf-8?B?UW1lSXZCcFVxdG5Hc0dYZVR4TElxUC9hVHA5aWxUT1doTWFrbmVCSmhTbXhL?=
 =?utf-8?B?cGdKMUsxZUNIcGV6eXdOQnZNbUV1aFdVZEs1Um9uQXV5dUt1aUtvenh2UzN5?=
 =?utf-8?B?b0pjNjAyakZzMEtFcHlLQnhvMjBOQmZJMUJRSjVVZ3d6SFBST2xvMTNKUTdI?=
 =?utf-8?B?RUROZUc0ZEwrVERCTHE1VGI5ck5oMHNXcW84TlJCdkpsbzZ6TjhWZWxVVmtF?=
 =?utf-8?B?cS9zdk81Q1N6cEU4dUVvRjdhZ2FtSWRhWlZGcVBoaE8xRVhDbGtuUXlYU2g4?=
 =?utf-8?B?a1lQa0pDSGt2UFIxRnFtaVRPN3hoaXBBQjlTMkF6VGZsZmxvWTZvV0xIWnpQ?=
 =?utf-8?B?a3FGYWV5ZUxjaUVmTStMeGFYbVl4dy9lVkR3K3laSHViNTZwMkQ4NkRkbEdJ?=
 =?utf-8?B?WXYreldWWUdsQ3I5bDRPRzVSSFlHckVlUUhhclNLdnllMU4rK1VzVldZTlpn?=
 =?utf-8?Q?QGCNeMP05fnPB5UHVqZS19ZL99ds1osbkndExOw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTJYRWJrYXlPYnl3YVZXWFoxTEY3SGk5RXNZWlJQYlZSZ2JOY3RnbDFJbU9J?=
 =?utf-8?B?TWFrZTgxM0t0NmFSSjBJWHY4WXFzR3FWN1pKT3pXQjJGUUNOUDFrMlNVZ21E?=
 =?utf-8?B?MXlZQmxjSHZLUUdKVkozdEhRcDFxNWpSNlR3Y2JPVTJESlFZdjZJdFEvOHZa?=
 =?utf-8?B?VFQzNVRZSkZXRjJrb2xIdVRVc0FETGE3VXg5SDJ4UE1lSzdydXJBUjdFYlFH?=
 =?utf-8?B?dHJrbkVZVHppR0ZET2dhblRJOFI4S2ZCQS9VSDZtQUNEYlBQUHZ2TVF4cHZi?=
 =?utf-8?B?dUZuSDZDcW9HVUNXazQ0Y0hlOTg1R0phWnhFRlAzRUgxcTczWm5Rd25NU3Z0?=
 =?utf-8?B?S2NtVytCWWZVTGY1VUpib284ZWQyc3V2ZmRTQytmQWFuV3p3bUhFT2srMlRU?=
 =?utf-8?B?KzJVdmpBQkdiOTVpVXNOOXdMQkMwM0RDMU9TK1VoTzVrSHoyazhyTHk5VlJy?=
 =?utf-8?B?eGtRYmpHWEQycjdsYklTdnZhUk9WT0tNempRRTVPbG1LdEM2MUk3U285cGxQ?=
 =?utf-8?B?aGNnOTJNQlF1VURveGtaRFpiSWx4SlRoakxQcThZekZVaVlPNEgxc1hQU2RB?=
 =?utf-8?B?SFluaGtZRUNBNUR3Zk5kWTFWaGRIL3ZNMkZmVDU5R01aS3cwVFk4RUhNQzZV?=
 =?utf-8?B?NCt3WEsya21KWGt4MWFFRm9PN3hkVExFbVd2MXA5SUg2RE9YcFp3SjdPbkdE?=
 =?utf-8?B?citwalRycWlNVnY0REdqRE5sbmxkazRIVklGN0pMaThsSzlWMWYyRThqSzZq?=
 =?utf-8?B?N2RlVkw4VVR6anhZSVA2SERjbXVMME92QzI0YkVmUjQ0UXZadCsybHFOTS9z?=
 =?utf-8?B?bTQrVm1CWmJPOUJHR001cEVqbEM4QlZIaFc0MHNtVWNzT1h0ai8xUU1vSzJE?=
 =?utf-8?B?YjM2aEx1Wmg4cEVUa1pnT3JSWmdwQzQvK2YvVjVKaGNjSkVqZkhheVdSSkpD?=
 =?utf-8?B?MUZ5NkY2N3NabEdjL2MvRWZiSkhPTktlM25Udzl2cnQ3dUJWTUdsdTduVlFm?=
 =?utf-8?B?NWVJR1M2ZEpyaGJuMkxVUE8rOGg5VUV2MFRpUys4dXg5aGlpZGx5cTBzWXVy?=
 =?utf-8?B?MFd1czZLTzNDZGxTWWtvcVUxbjAxRkVVNzhqczNzTGpqdVF2anJLd2Z5VkJR?=
 =?utf-8?B?dGtiVWV1NkUzQXl3QTM1TDR1MGpiSTBjT21POW85MlZkTlpyMDRkU0ZzcHg1?=
 =?utf-8?B?c1VGdEVrU0VoT050dUM0a3JBa2ljSlczSElhenZMS2dIaWpDck5OeEZYSTVD?=
 =?utf-8?B?QzdyTE5XMUIrMnB6RzBtYklYb0RDVkxSRm1zcy9kdTd0VnhhQTlCQnBybHE2?=
 =?utf-8?B?UG9neWtIcWx2dUI5dUFsbzZ0ODZwVjdRazZab2JOblRVbFA2R1dnck8yNEgx?=
 =?utf-8?B?YitrYXRSblpuRnpNN1NoUjNTaUd0ZTNSYmFhaUxkdkt5Ly9GeVBEbjFTcDFR?=
 =?utf-8?B?TDMrMmhpNjdrWWl2emMvajZaUmhnNUU1QXRxbHJWNmNGYjBzcTRHdFVhQVpw?=
 =?utf-8?B?VW05MTBiN3dTZ2hpbkhQWE5hdEJyMnJ0ai9GeWgvZEM1R3REU0dBSU9QUVNi?=
 =?utf-8?B?RGtjaU1BbnpqSXFxbThJN1ovSXBqUW1GcnNadkloMHRocmdPNVVGalkrakdr?=
 =?utf-8?B?UE1GTzlHZ0xQQlMzS2taSnFNd1pFVDhxbktlN29iOXRLMEttZU5kZWpxZ01n?=
 =?utf-8?B?QnE0ZmxBZDFyaTRzRWdmZlpwd1BsTGE2dG82dUt5VExnczQ4VzREayswcWpt?=
 =?utf-8?B?aHNWT3Rubzg4M2tvTHc1Wm9ZUTlMbklRTGJWM3BmcHFEeG83emlwQ3djNnJT?=
 =?utf-8?B?MjJLWndub3JvMmZabXlLeWdaZ3FVc2NhczFtekx4K1BXR2czNG1MTm84amsv?=
 =?utf-8?B?K2h2bTErT3J6aTJEVWExQjBRcnovYm5IMDQxcklIeXRuTXpQYkNjOGhZbm1w?=
 =?utf-8?B?TFkySlJLcmhhMlljc1hJQjFXR3RYVWFoZXlUSTNJZTRGSlBrZk1XZFpVZDJt?=
 =?utf-8?B?amdDOStQZHcvZEtSWlBQZzhlNWh1NTMwY0pDbkRWNSt2dlhFbS95UkVBL1FR?=
 =?utf-8?B?WlZkYnZWS3hkbFU1K0hQbGNFeDdxamtvc3ZVMnMyeCtYdWlMS0p2WHZSeWpO?=
 =?utf-8?Q?OXDMthm43N9moNqUvsJheDL/e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb8c1b2-183d-4885-d7d3-08dcef830783
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:42:02.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cj2h1fME78XhJDmv4gQT8HAZnyL/hYpe31f3Cgy0SOX8zGY7WqUYNqQyhB2SNqsU+Yqnyfw0Za4d5sbscuTzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

On 10/18/24 01:32, Nikunj A. Dadhania wrote:
> On 9/30/2024 8:52 PM, Tom Lendacky wrote:
>> A segmented RMP table allows for improved locality of reference between
>> the memory protected by the RMP and the RMP entries themselves.
>>
>> Add support to detect and initialize a segmented RMP table with multiple
>> segments as configured by the system BIOS. While the RMPREAD instruction
>> will be used to read an RMP entry in a segmented RMP, initialization and
>> debugging capabilities will require the mapping of the segments.
>>
>> The RMP_CFG MSR indicates if segmented RMP support is enabled and, if
>> enabled, the amount of memory that an RMP segment covers. When segmented
>> RMP support is enabled, the RMP_BASE MSR points to the start of the RMP
>> bookkeeping area, which is 16K in size. The RMP Segment Table (RST) is
>> located immediately after the bookkeeping area and is 4K in size. The RST
>> contains up to 512 8-byte entries that identify the location of the RMP
>> segment and amount of memory mapped by the segment (which must be less
>> than or equal to the configured segment size). The physical address that
>> is covered by a segment is based on the segment size and the index of the
>> segment in the RST. The RMP entry for a physical address is based on the
>> offset within the segment.
>>
>>   For example, if the segment size is 64GB (0x1000000000 or 1 << 36), then
>>   physical address 0x9000800000 is RST entry 9 (0x9000800000 >> 36) and
>>   RST entry 9 covers physical memory 0x9000000000 to 0x9FFFFFFFFF.
>>
>>   The RMP entry index within the RMP segment is the physical address
>>   AND-ed with the segment mask, 64GB - 1 (0xFFFFFFFFF), and then
>>   right-shifted 12 bits or PHYS_PFN(0x9000800000 & 0xFFFFFFFFF), which
>>   is 0x800.
>>
>> CPUID 0x80000025_EBX[9:0] describes the number of RMP segments that can
>> be cached by the hardware. Additionally, if CPUID 0x80000025_EBX[10] is
>> set, then the number of actual RMP segments defined cannot exceed the
>> number of RMP segments that can be cached and can be used as a maximum
>> RST index.
> 
> In case EBX[10] is not set, we will need to iterate over all the 512 segment
> entries?

Correct.

> 
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/include/asm/cpufeatures.h |   1 +
>>  arch/x86/include/asm/msr-index.h   |   9 +-
>>  arch/x86/virt/svm/sev.c            | 231 ++++++++++++++++++++++++++---
>>  3 files changed, 218 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 93620a4c5b15..417cdc636a12 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -448,6 +448,7 @@
>>  #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
>>  #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
>>  #define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
>> +#define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
>>  #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
>>  
>>  /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 3ae84c3b8e6d..8b57c4d1098f 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -682,11 +682,14 @@
>>  #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
>>  #define MSR_AMD64_SNP_RESV_BIT		18
>>  #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
> 
>> -
>> -#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>> -
> 
> Moved accidentally?

No, just didn't want that value in the middle of all the SNP related MSRs.
Really, I should have moved it above to keep everything in numerical order.

> 
>>  #define MSR_AMD64_RMP_BASE		0xc0010132
>>  #define MSR_AMD64_RMP_END		0xc0010133
>> +#define MSR_AMD64_RMP_CFG		0xc0010136
>> +#define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
>> +#define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
>> +#define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
>> +
>> +#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
>>  
>>  #define MSR_SVSM_CAA			0xc001f000
>>  
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index ebfb924652f8..2f83772d3daa 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -97,6 +97,10 @@ struct rmp_segment_desc {
>>   *     a specific portion of memory. There can be up to 512 8-byte entries,
>>   *     one pages worth.
>>   */
>> +#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
>> +#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
>> +
>> +#define RMP_SEGMENT_TABLE_SIZE	SZ_4K
>>  static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
>>  static unsigned int rst_max_index __ro_after_init = 512;
>>  
>> @@ -107,6 +111,9 @@ static unsigned long rmp_segment_coverage_mask;
>>  #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_coverage_shift)
>>  #define RMP_ENTRY_INDEX(x)	PHYS_PFN((x) & rmp_segment_coverage_mask)
>>  
>> +static u64 rmp_cfg;
>> +#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)
>> +
>>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>>  
> 
>> @@ -196,7 +203,42 @@ static void __init __snp_fixup_e820_tables(u64 pa)
> 
> <skipped the e820 bits>
> 
>> @@ -302,24 +344,12 @@ static bool __init alloc_rmp_segment_table(void)
>>  	return true;
>>  }
>>  
>> -/*
>> - * Do the necessary preparations which are verified by the firmware as
>> - * described in the SNP_INIT_EX firmware command description in the SNP
>> - * firmware ABI spec.
>> - */
>> -static int __init snp_rmptable_init(void)
>> +static bool __init contiguous_rmptable_setup(void)
>>  {
>> -	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end, val;
>> -	unsigned int i;
>> -
>> -	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>> -		return 0;
>> -
>> -	if (!amd_iommu_snp_en)
>> -		goto nosnp;
>> +	u64 max_rmp_pfn, calc_rmp_sz, rmptable_segment, rmptable_size, rmp_end;
>>  
>>  	if (!probed_rmp_size)
>> -		goto nosnp;
>> +		return false;
>>  
>>  	rmp_end = probed_rmp_base + probed_rmp_size - 1;
>>  
> 
> If you dont mind, please fold the below comment update in contiguous_rmptable_setup()
> found during review. If required, I can send a separate patch.

Looks like there will be a v4, so I'll update it.

> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 2f83772d3daa..d5a9f8164672 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -354,7 +354,7 @@ static bool __init contiguous_rmptable_setup(void)
>  	rmp_end = probed_rmp_base + probed_rmp_size - 1;
>  
>  	/*
> -	 * Calculate the amount the memory that must be reserved by the BIOS to
> +	 * Calculate the amount of memory that must be reserved by the BIOS to
>  	 * address the whole RAM, including the bookkeeping area. The RMP itself
>  	 * must also be covered.
>  	 */
> 
> 
>> @@ -336,11 +366,11 @@ static int __init snp_rmptable_init(void)
>>  	if (calc_rmp_sz > probed_rmp_size) {
>>  		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
>>  		       calc_rmp_sz, probed_rmp_size);
>> -		goto nosnp;
>> +		return false;
>>  	}
>>  
>>  	if (!alloc_rmp_segment_table())
>> -		goto nosnp;
>> +		return false;
>>  
>>  	/* Map only the RMP entries */
>>  	rmptable_segment = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
>> @@ -348,9 +378,116 @@ static int __init snp_rmptable_init(void)
>>  
>>  	if (!alloc_rmp_segment_desc(rmptable_segment, rmptable_size, 0)) {
>>  		free_rmp_segment_table();
>> -		goto nosnp;
>> +		return false;
>>  	}
>>  
>> +	return true;
>> +}
>> +
>> +static bool __init segmented_rmptable_setup(void)
>> +{
>> +	u64 rst_pa, *rst, pa, ram_pa_end, ram_pa_max;
>> +	unsigned int i, max_index;
>> +
>> +	if (!probed_rmp_base)
>> +		return false;
>> +
>> +	if (!alloc_rmp_segment_table())
>> +		return false;
>> +
>> +	/* Map the RMP Segment Table */
>> +	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
>> +	rst = memremap(rst_pa, RMP_SEGMENT_TABLE_SIZE, MEMREMAP_WB);
>> +	if (!rst) {
>> +		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
>> +		goto e_free;
>> +	}
>> +
>> +	/* Get the address for the end of system RAM */
>> +	ram_pa_max = max_pfn << PAGE_SHIFT;
>> +
>> +	/* Process each RMP segment */
>> +	max_index = 0;
>> +	ram_pa_end = 0;
>> +	for (i = 0; i < rst_max_index; i++) {
>> +		u64 rmp_segment, rmp_size, mapped_size;
>> +
>> +		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
>> +		if (!mapped_size)
>> +			continue;
>> +
>> +		max_index = i;
>> +
>> +		/* Mapped size in GB */
>> +		mapped_size *= (1ULL << 30);
>> +		if (mapped_size > rmp_segment_coverage_size)
>> +			mapped_size = rmp_segment_coverage_size;
> 
> This seems to be an error in BIOS RST programming, probably a print/warning
> would help during debug. 

The segmented RMP support allows for this, but, yeah, should probably
print a message when it occurs.

> 
>> +
>> +		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
>> +
>> +		rmp_size = PHYS_PFN(mapped_size);
>> +		rmp_size <<= 4;
> 
> A comment above this will help, as you are calculating 16 bytes/page.

Sure.

> 
>> +		pa = (u64)i << rmp_segment_coverage_shift;
>> +
>> +		/* Some segments may be for MMIO mapped above system RAM */
> 
> Why will RST have MMIO mapped entries ? 

Trusted I/O. I'll add that to the comment.

Thanks,
Tom

> 

