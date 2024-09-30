Return-Path: <linux-kernel+bounces-344660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDCC98AC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0AB3B225BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D4199253;
	Mon, 30 Sep 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="imkn5zNB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4E198831
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722801; cv=fail; b=ap9l0wHkpL1RljVXUDgeRFehAgiPkbR6zc00ZcUWMf0/bxva/i4RS5JDYt6ye7T4M2iHOUM/XLA3z4AKn2NXW4D8kLMP1oXzXPR/WmTx/vVx+zhW6M8fQR/dAo41BawcZqhAZK24ttIk1VxyJWEHI2A3Fi9iIOufngapiY2kDSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722801; c=relaxed/simple;
	bh=ypcwEL46+0ZZTfXjC0doFS8n6y2YMswGMcVPpGI5qew=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=JRTn3rOBYPQEjD/LQfzjasjfB1YIay6J/B9SvLamUop3oc5z9xQarJFmo7I0lToZcoTaJH8Q0EeS6RP6RP9gXlH17W5v6jXs2iTI1sSjosf3JqdKepRSsCqulHZc0rSxCNNsHMDVg9qLrqOsr0yqzHFVs7TPFB5Nyi3ri7pGtlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=imkn5zNB; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5MLpPDJL/outo1aFNZRWqye8HAaeFij185dSUFXuQTjDP/pxUareCQbWtCks1HziqTCQtG66YyG8LTCc8wIC+3KCdi+u50sXN2ucUrwDx/cPtq6d2e0M3XzxUSjfcrpopPqMAW1RZm34EA1N4//gZ13ckq4D3i5XLRyleleEmt5PB6IhITlibKJ2z72U0/zyP/658gbNWrPyuAoJcySH9YB/xmDC4QhMdFEAfAgV+62BY4VJXhtCG91kJxwWpz2RTPkC9H9AIkpksTt07dCn/m9kXRn52EVwLCsYJKfH4UmAdLZEcypPvXdZFe0qFXb8QkeBd08KEEgtyWxjBT8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHnC8tZHGGKxhq7QqefWWSoqrlzrRb2jPOfKGa2LAVw=;
 b=wr7MBA5UOmJ0eIls3p0KxpJizRldYceJOYXz49yZ04EhScqEGZixfOfaz7mGI1MTsrsrbXCiVPbg5iMnc98xhz6AFZWMShuNbDJSGatCXzeYHFx8gyKl97cvIQd/sHw5WjEATjh+oc3Cl9s/75gQ/wVyWl82SebzNRHTB2LT9iH84Jbe4PFcH720XWCdgiEie6TffInRiV9J2DCZodriP7OaNCjD+uGKaiwiqXpvPmeBeJfNUuefkzHsLUcGJb9mdsBfCA6rFDwnuU5reK7mRgBLr+v2OWCSsxJKhC8bGcWh3xTAr9mIPyOghMTKNiZBlXpLR9onC214pfYwUCdLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHnC8tZHGGKxhq7QqefWWSoqrlzrRb2jPOfKGa2LAVw=;
 b=imkn5zNBd9H5HN/tan40kEhGMFrzPcj5yeSA5SgLUDb3L++sUNqbkJjWXiuBJi18YLougdB2RwJ2eode1O5Gpr31H3iAc7Cl/WC4OXNC9zGUZTq+bho9rYrV88D70Z+7JvcYj23u9oBiNMNWRpP8He+E4KOx8QK14PAkyg2vxeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Mon, 30 Sep 2024 18:59:57 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 18:59:57 +0000
Message-ID: <45d69348-44bf-94c8-528d-9f5ac1aea163@amd.com>
Date: Mon, 30 Sep 2024 13:59:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <a8aa2542fb1b65371ca08ce2be40a5179aec6dca.1727709735.git.thomas.lendacky@amd.com>
 <ce1f252a-9ef1-4cf1-9d4e-bedab43fd7e1@intel.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/8] x86/sev: Require the RMPREAD instruction after
 Fam19h
In-Reply-To: <ce1f252a-9ef1-4cf1-9d4e-bedab43fd7e1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: c7526820-a091-4601-a304-08dce182134d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVU0ZFZRZkxERFpQbml5RmJZZERoTGwvV3JvRFIrQUVMQTgyWFVvWHlKUTdH?=
 =?utf-8?B?ai8zU01zaVBuVXFGU0pYdWdEUklUOGJDMHU5K3ArZ2hKVXdCUFhJTWNpOGQ0?=
 =?utf-8?B?aVNCMjNkdUN5VWdDRTVOdExuWVZxTW1FT2c1enFxUnhUd1UycjNVUUllY1Z2?=
 =?utf-8?B?NndKR25ydmx5bUJMM2NGdmRxZDVhOTB4bVgvbCtzdU94VXBKZkpOSzZBajN0?=
 =?utf-8?B?SWpUWGxoem9RN1p0bks3SHRIb1pEUVRPN2pHaFdZSkJXNzlUT0N6cXR5UXYy?=
 =?utf-8?B?Z2RHSUplZHZnK3JveEtIaVpzYjVaRE14dG9QMFdKNTBqVUVNbG94eGNLY2p6?=
 =?utf-8?B?aE9xMlBvUzRwSllGL2ZCRjZVNXd0ZjNtUUsya2hnVEhhczdNTUVJa0x6Wjcy?=
 =?utf-8?B?ZWtaZlI5YkRnTVlzN1BzcnN4bVBQQ3EwTUNKNXNLcmV2RW9EK1pxVzBxZkJ4?=
 =?utf-8?B?UFA4cGwvbXNNYXB4NzJUUkd1UmVVWENJZDlpd1Brb1hmZVQ1QzFvdmp1N0E0?=
 =?utf-8?B?a3pTbE1QdW9sdjhXdnYwVFRUc082clgxUTA5MjlWOElwUlpYb0ZibVJMc2dR?=
 =?utf-8?B?OWsxRUwyd3VjRHlTODAvNVVmWW9BeHQ5VnpWUGMvL0drNGR1aU8rODdTMlNW?=
 =?utf-8?B?NVIzd0RHNXNBd0NWVHpqanVNWVA3dHFaTjFWN1dRd0dBV3RyTHhNT25qbEFa?=
 =?utf-8?B?U3VBWTFSbnB1S0VYMUZORlVaZzMxbnVvaHhleis3Y1drd25iZ0FWZ25vTkVw?=
 =?utf-8?B?RGE3cTBWVGlaR3FnWk0wcFJaRDMvZ3JJbTNKY2t2UnY4bzNmV3VVRlJOUStY?=
 =?utf-8?B?RlNqRFJxekpEM1hKNStETU93RFp2T3FUT0N3YVFMdG93NHp4QnkzSzNnbHVL?=
 =?utf-8?B?MnlTR25FN0VOaGZuZy9PV0hoU2NnYnF2NFZkMmtsanRMQytjeXpvRDAvK3Jx?=
 =?utf-8?B?UzIrM1Fza3dlazlzOEZWYi9iRjBUWlo3TWdCN0FHdXd0MnhVMG1GbGNXLzVa?=
 =?utf-8?B?NXRxM2FGMkdOVk9yMmxXVy9CT21YTEs4YXp3OEx4S2xDbFhmcTVSSnF3NXp6?=
 =?utf-8?B?UDRxU1ZIMld4aU5tYXJHdHlGcDJnT21Oc0RoMGp2bGRuTzU1Q2ZzbEtFNEdO?=
 =?utf-8?B?Rlp5bXpiVmk3OFlUeHRxR0hTL3haTjhFMEpKNWhxdjNPc3dseXgvNW84OWxV?=
 =?utf-8?B?VTJiRS85SlZMUUt0RHRtUHJFREoxL210N0ZCQUN2dFBubnB5Ky9Xd3VzSUJI?=
 =?utf-8?B?a3crNzN6b3B4NlliMVdZR0VCKzJjeVZaYWdxL1Q2cVluSzZObnFwOEFBVi9y?=
 =?utf-8?B?ZmplVno1aEU1NEVoWURtdndveW9aQ0w2QytpVWI4S3FDeExxOUx4Nkk5QldS?=
 =?utf-8?B?UGhPaFlYV0VDMy96SWhWNzc4d2cxY01TUSthQ2JGWmNWdDRyUzA5MWFCNTVM?=
 =?utf-8?B?bjdidlQ4ckorTXRBNjg5bFB5V1hRVVFBN05EMW5rTkdHQTU5ekFsTDR2TW1B?=
 =?utf-8?B?eENsdC9uMk5pcjMxekhpY2xzU3lvYTQ0MjhuMm5UaW01VHlmSWQxVmQ2czM0?=
 =?utf-8?B?YW9sTUhRWDdUOEthZmFaQzVCbDlDUmlSVnFSMGFDQXpwbWVoRVBzVWFHUVZ3?=
 =?utf-8?B?dENMVk9HN1V5Q0lrcmlwWlNrRGNBTk4xSEtsU2pGRW9yZjdKNi9XZXc3TWJN?=
 =?utf-8?B?eXhxazY1cXBacGxBcjFYK2tZODA4Y0xkSk5LbjhiYmJIRGp6UnBIeVZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGlaMTB5bTh2cUxnUVFRMW5FeklGTm42bWwrWEREK3E3TENpMWM2cXphOTZJ?=
 =?utf-8?B?dkN5WUpaN1dNUWZzbklyRlZWWTd6Vi9TWmdhNWtyMVZNanNhRGFURXNIU2Nq?=
 =?utf-8?B?dFlaTTZneVZpQXd2VHUxNTVnWUhFdVlONnhZQ1RjV2hCcUtnaHNKMVJIekRn?=
 =?utf-8?B?YUdialF5ZnpNRmhaY3lQcUNTWnJsZXBRYnlVcWJHWW15ZHBoSjZ6YTVkMWll?=
 =?utf-8?B?NWs0d0RPVFgvN3Y0TnIzbTBCSTJBZDgyM3o2RXU2ckl6WVB0OUZHcVg5UGZ2?=
 =?utf-8?B?QUpFSVAwTEFEQ3E4dEhhVUhvWkU5Q1ZOMVFwYXo5S1FjUUJtL2I0QnNMd2Zk?=
 =?utf-8?B?RUIrSXJzNXVQaGlGZDhZdkp3YWR1bUw4bTVaY3BiOGZjMzN3UCtvOUJURUFh?=
 =?utf-8?B?VlVoUFd0NnpOb3BFaHpzSWRqTXhOZHVFM09lUE1KRHE1TmhVTXlBY2tGeFZH?=
 =?utf-8?B?ZkpwbTFXKzVtRjZWRTdNZnY0bno0cDFGYXNyNHkvK2pBUko4MElyZ3NCcVVR?=
 =?utf-8?B?QVhMYTYwNS9lOEgrSm1zaXR6Z2VvOEUvMnYrM0ROWFQyR3JzdHZma2FpZ1hz?=
 =?utf-8?B?ekU5a0V0RDdPVTZNNGpvL01pV3hTMmRtS2JBTjZkSTFDL2kvdjJ1aGIrQmZu?=
 =?utf-8?B?TCtVMjU5RnRHOExIQmp0VE1BWDVZSFp0VDlwajRURkE4Vmw1M3BnQmZZUDQz?=
 =?utf-8?B?UWFrbkVOOEIwd1B3cERVN2NtUU9wOVIyQS95N0xGL1IyTlU3VEpBcXhrMHNz?=
 =?utf-8?B?WTJFSEI0NGViRVprbVhsckpaNUNiMzFtZnIrN25DRmZEOU9EQ0drNWxST3BM?=
 =?utf-8?B?RENZd1VmMHBGR2ZkWmNvNG9ETmkwQzNJVFdod2RaUkE2aVZxa0Z2ZDdEYUVh?=
 =?utf-8?B?SVJGMDlmOHFPUlRYKzRHVmRqZG9aQldpY0MyamcrSUY3NnIxRmpEZU5KOG80?=
 =?utf-8?B?L1o4Nm8rSjNaSlBFS0dHU0k5a0JPUFltelk5MjMzU1Q3ODd4OWNhekJGd0JO?=
 =?utf-8?B?elRuOHJ2WEZuWXJqOTE5QmhpS2VjTlBZZ3JubHJpUUMxTU95amovWW1GQVor?=
 =?utf-8?B?ZXdaQVl2aWg0YjJ2U284THQ3VTlQeWY2bUNaczdzZXcrTEE2ckl5N3QweGV1?=
 =?utf-8?B?bjJqblo0UEVvbW9ZTnhVR1pyQXovRWlxbVdsdy9tRXhZcnh4OEFQREIrZHNE?=
 =?utf-8?B?aGg3Q01XSy9ldXVTWTJQc2VUVU5qZlRtZHV2cVM3YXROaDM0dWw0c2QzTHhY?=
 =?utf-8?B?Tk10YSt1dDJuS3RKRVRKaDREMTRQSHI3bWN0TkpVOUc2elplYXpMWGF3Vlpv?=
 =?utf-8?B?eTRtVnZrSlB5Zk9MUEpFSUVscGV3bFdtWE9yMTRBcngydVgxZXRuaEZXOHNs?=
 =?utf-8?B?SFN4bEp2YU5ZSVZQK2ZsQWZ1VmtvN2NCTmlWQlA3YmpWUEJBUVQxZThrK2ZB?=
 =?utf-8?B?bWVsOEJYNnRJQ2tDMGY5T2U4TXFjTGZkZDR5WXY2cjVnWmlSdHluYitHMHpw?=
 =?utf-8?B?dm9LaEtwdnBoVlVSVmlWOVhOaGNxLzVhVVg0YnNabjg0MURhYnFyT0tKbUZ3?=
 =?utf-8?B?U3kva3lROGlhTExhenVFaEtXZFhJQ1JkcjNWdTBna3Y2Nkw5MitTNDlhMVYx?=
 =?utf-8?B?Yk52bDIwZ0d1SlY3T3VzbjBYcFpHYnYxemZlYXkwRXFaNVZRZ0UzOGtkWENl?=
 =?utf-8?B?YTdwN3V0WGE2Ni9OQVNnQ3E0Mzh3aGdqS3FoaE1XZnVnNC8xVjRCdWVnR0VG?=
 =?utf-8?B?b0VjVWk0aE5LUU5ma0NwTUVpZG5mSVJTaXhzZlcxbEF2TmtmQzc4YVI1eTBK?=
 =?utf-8?B?SFNNNmswS1A1amxqL3VFdHVLSDlUdGhiNGdMc0ZLK2NIaVduMzNnb2pwd1Ur?=
 =?utf-8?B?RUMzQmhDanhYSkhiOUJ1dmVSSnlVN0Q0aHprK05rM1BwSllMY2VDSnNmZmNQ?=
 =?utf-8?B?dkpjckV4ZEdYWjBrazV6TGhtN2lSOElGUmhDTEZNZUpPMWZsM3haQkZqZkRP?=
 =?utf-8?B?ZEFhaFIxQXJSaU0vTnF2QVJGSnQ2c2JVeHR1MURTU2VCUXRQUVg3VzRsNG9m?=
 =?utf-8?B?RDEySFBiQ2pjS1UrUzd3eHB0R01RS1B0MG5haEpDUzFtOUJrbTVjQ0NBNU9B?=
 =?utf-8?Q?lUoG4d1eAVlSl13qnYzGbZmDP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7526820-a091-4601-a304-08dce182134d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 18:59:56.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B/PlEkkcM3nMUpvfW3YRPkm1VvlOnI0GG02IeCVSNKIZvvz4F9nQVT+IWS9lloWqRbOJWI86W+AQnviVSTgEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

On 9/30/24 12:03, Dave Hansen wrote:
> On 9/30/24 08:22, Tom Lendacky wrote:
>>  		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
>> -		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
>> +		    (c->x86 == 0x19 || cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
>> +		    snp_probe_rmptable_info()) {
> 
> One humble suggestion (and not a NAK of the series): Could we please
> start using #define'd names for these family numbers?  We started doing
> it for Intel models and I think it's been really successful.  We used to
> do greps like:
> 
> 	grep -r 'x86_model == 0x0f' arch/x86/
> 
> But that misses things like '>=' or macros that build the x86_model
> comparison.  But now we can do things like:
> 
> 	grep -r INTEL_CORE2_MEROM arch/x86
> 
> which does a much better job of finding references.

The one issue we run into is that family 0x19 contains both Milan (zen3)
and Genoa (zen4), so I'm not sure what to use as a good #define name. We
have the same problem with family 0x17 which contains zen1 and zen2.

I might be able to change the if statement to something like:

	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
	    (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
	     cpu_feature_enabled(X86_FEATURE_ZEN4) ||
	     cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
	    snp_probe_rmptable_info()) {

which might make the intent clearer.

But, yes, I get your point about making grepping much easier, along with
code readability. Maybe Boris and I can put our heads together to figure
something out.

Thanks,
Tom


