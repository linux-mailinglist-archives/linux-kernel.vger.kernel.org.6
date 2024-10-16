Return-Path: <linux-kernel+bounces-367914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707D99A0845
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19100286228
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ECB2076B0;
	Wed, 16 Oct 2024 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cNmpnaqL"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57452206066
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077930; cv=fail; b=KLOHJX9W4F5G7qF6ctbmGUq8Bblgz+S+fHkdbF5bHAPErouDQs7VNUQvfxrNT1QvwutX/HPI2wxJSaCfA3SqtPVE488+532NhYwRJGasZW35r687SrngHtj2hi3J+6GOG0izCE8yaOz1B8sC5uP6FeLmcXdfxJDCJXCHtQRtyw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077930; c=relaxed/simple;
	bh=vbeHRlEKSjxSHjjaXS/DmbfU4uNS6JWD9Vdoqo+VEzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YL3fmnv+L0cWqGOi37egLr6NWBJ7l4a0L44QHbZxDFl1LPVDATAHjzXkBUbiuhNVr8sJ2cWVlSNQ185SR6uIFzE86nd0PWCWsjpp0VJJALQDNVM3YmbeavDLCacZZIDoydl/mzINr+VQeoCJfVgYTD4r65s53VDX8BpatkMPFqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cNmpnaqL; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGaXInz4pYRfuBYeLcxMSONs2PZLcFiH9g1fm4G+e0D5byQiV1hNgsJxONSJI6Ja+b2sGjsXGOeHMILGqvdW97XU7ySsQWHtFHvLqa+Jwp4gfsYwe1INBvOe0Gu0NkggJUqPAli3oyE4sAh/X6taB8+1D6FjlGsifkghxTE2FiUyramwn3mhP39C47Fmsi7k9dRtLOPVLGNPZOeh60rKMWr8XSJKSR21jSD6erxY11S4ctnLIxEui/13gc33sBPO7xspAC6NkfUj/Nd2Fmre6qK04CbyxblCF5WKrAGJrRzAdpRMctwxlgmxldQMAsHEEMcQivjJO8qPTS290oadxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn7G7oriToBc4+RbmyUKIP/dzMeHoTcFWV9ewT9GFcs=;
 b=m67v7uoZ7hjBcbKnstIPjTPzcBRiizSEjXRv5r92i+aNu9zsQX+Y3A2m43V2fKFFtXGMt8zaL8G9VGLhuy6uKEMPBNa5xiNyZtA6N0DTOQOnIBHeeL5FWLOFIk7bjBn3G5jGXYMdSecHVvKpclYszvhGdPUubgz1xRY2BXDfopOWQv5+K2ATjqlDLj/Vkin5OG9gSW4YLlgc3dRaLNnK/+EFGP4GIHEyasaYfthiLjWfmZydd2+Wqcw9UzgSZBoJ93rI/Ta/wpt6b4la2LFKUCZQr8x9BuIMCJflU0HNB588v0wcgwBtXpITlSq/kOFNSGZ3HsQI9FZh0+YLxjgPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn7G7oriToBc4+RbmyUKIP/dzMeHoTcFWV9ewT9GFcs=;
 b=cNmpnaqLYUkr3nHdhuGY4ff29ahgKGrBhsBqZfEVSpBNtpNuhhbfq236bNNG8nIopmsAY4SD/wgH4+SdOgAB+YDG6hAZBY2gKwRGS/MJ9H6piCLY8xM6bya9PCmIjWH+V/PqJC2SU5pVG6MlPgu1lyc67NqLsn8reTLETmCfKVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 11:25:26 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 11:25:26 +0000
Message-ID: <57a6e04d-b95d-83b1-aa0b-fb2f7174e47d@amd.com>
Date: Wed, 16 Oct 2024 16:55:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [sos-linux-ext-patches] [PATCH v3 5/8] x86/sev: Map only the RMP
 table entries instead of the full RMP range
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <89d50ef2f0a9b3eaf4e9c4cf4e0a418f963d92e7.1727709735.git.thomas.lendacky@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <89d50ef2f0a9b3eaf4e9c4cf4e0a418f963d92e7.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: e11bffb1-8ebd-46b1-80e2-08dcedd53b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXcySkpRcnBqaFZGNG5RVVp0QW5XeEpBblZLR1g1cmQyQnFaWGRIM1ZlTmti?=
 =?utf-8?B?REhqeHh4ZjgvSVBOTHBSYVQxR0J3OFBhaDIrOUdKU28xVUhZdDhHMFc4SStE?=
 =?utf-8?B?Q1NnNTVrN1VEZGp5SXUxV1RRMFRuQjlTSjJDNXpsRDU5UTNHOFlmYmNHTGJW?=
 =?utf-8?B?eXRTaThrcEdTRVFFRkwxSStBV1JiSTI2UDZLY0ZnbmZRLy96OTY3Q2FuU0VM?=
 =?utf-8?B?QXJTZ21EbklXVGxmUEhyUFoycGtidFJrSFRuOXZzbVhqcUpXTCtSajFZQXpX?=
 =?utf-8?B?L2M2VjFnNitTb083c1F1U0FWM0VqbW5qell5a091RjB2dEFPTkMwZzVDN0hR?=
 =?utf-8?B?SUdZOC9nN0hjbklrV0ppVFR5V25CNmtuajMyQ054U0ZvRXJJOGdMNmJXSkVY?=
 =?utf-8?B?MmxlaGlVZVhKdU9NM3VVdU9UYkIxZjIwaXdqTSsyajRsakQ5UlJPRUNPeHM2?=
 =?utf-8?B?OU5McElUVWdKRzdYbklGRnRLZ1NPL2lUZi9MR3gvcWJoWHBtU3VKQW1SRm1a?=
 =?utf-8?B?cEs5UXh4c1hFRVlpN3c0a2R3b014QVFxeWc3V08yL1BENFl0Wkp2T2hzSzBL?=
 =?utf-8?B?RjNMa2lWVTkrRlJTUXJPV3RNTndUWFdJUUdFelhEMEtHVmZNSlN4ZjM2VHVk?=
 =?utf-8?B?THFjTmdHOHdEbkdNL3BZOFdCWEJxRTFBc215TzhJL0VQbGNtOUIvZDZMK1Yy?=
 =?utf-8?B?WnZFV3ZBbDFSeEM3eE1wUXk5VFdRRHZmbFY2ODFDZ2Jhd2MweE1TNHBRMkcv?=
 =?utf-8?B?VGdCRVpBdmdFejB3amdnYmVGNHVTYlNXV1JlcVJkTFZxYXRXZjNFN2x6bHpi?=
 =?utf-8?B?M3N6QVIrQ0dsaHVmT09pdkw2ZGF3MXJvZE4vOFRwa1lRTGwvVEllL3k4bUZx?=
 =?utf-8?B?R082MjlyNEF2U0piNDlQU2kyN1lhRlZscTNybnBhbVZzTmJMbDVFalFOcFIx?=
 =?utf-8?B?T3F0cWh2bHFEMVpnODh4cHFYaUF4VDM1b1ZRUi9HTFdhTnpsbmFOTnljdUFa?=
 =?utf-8?B?MGlOcTRRa2lTN1dLbExEMU5lY0RBbSt4dWU5M2RVUFlZaEQ2ZUVkZ3N4cjFX?=
 =?utf-8?B?WndjVkJoVm5rUEZoeFpQUGtmYVhvVldoSy9aWCtNeWxVSTZ1WUYzem4rNS84?=
 =?utf-8?B?bmVVekJSYkpLN08rSzFUQ1Jkb1hTS21rakdnMm1qY3Azamx6Y1hnRWxNaWFN?=
 =?utf-8?B?MURvZ0ROY2kzM0o5QTI1bUhjcEdqN1JPT3FaS0l2WWdtYnBDYkV1eDVvT1I4?=
 =?utf-8?B?MlNVU21SU2xOYWZoZndaTVF5enBQbnkyMS9NUDdkYmgzdmtXM2d6VGoxUTRw?=
 =?utf-8?B?VGFkV3kxcUd0WGpqRGl0V3F3ajVMbVo2Ui8ySVFwQmk0bzM5T0FlbUNUbmhZ?=
 =?utf-8?B?UVZjVG45UkZvRVpTNWs1VDZyNjVKUktkc25BWXVMNFlZdko0T2tPenFXMnFL?=
 =?utf-8?B?UnpoZkJpendHQ2ZSOFFxcVd3bXROc1dadmxPNEUyQmN0dUU2cEdKZldIaFU1?=
 =?utf-8?B?N0V5d1NObmkwSEFwdU9zVlpaZjE0cnBOd24relhGZGllRWc1MElIc2ZJcjQv?=
 =?utf-8?B?VEFWQkxzRFNBbTJPUWl2d3pzOVh4ZHhRMXBYbDBIK2ZJUW9EekNqcEsrYVdJ?=
 =?utf-8?B?QWJPaS9hWDZhUTFYSkhQbDRPU3pMYnBTSGo4aW1KMy9DdzkyejBuMWkrSDIz?=
 =?utf-8?B?ZHY2K295bjJOd1NyYTVXcFgzMHdhb0RZa0VTUDBiaGcwK3BmWjhaSG1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm5BWGRwRmJPUUxlSHF1Y1NSRkp0cWpnUWhNR0wwOXVmdDMzZjd6ajZXTTNR?=
 =?utf-8?B?Q1ZLRGZPdjZEcVlyVTJ3WGpUZzRLNlBuVHpRbkF3RmtFak5qUnJkbHNmN1RE?=
 =?utf-8?B?SlBUVnhFbjQvR0Fwd0ExMWlHbGI1aGxQUkxzbG5ZdjNpUkJKV1N0WTR0UTM3?=
 =?utf-8?B?bFlab1BFUzNRWTlaUjVkRlpaZTlXTFdMOEFockx0NVEzd1JQbXFiY1VCcDk3?=
 =?utf-8?B?bzVveU1lNU5CN0JZVjBEYUh5YXFpa1Nma2ZFVDNMQURDbWtDTzdGaERnOWJS?=
 =?utf-8?B?dXJlTjl4RmF0NDhqMFFUcUdEanRVanZjUS9VR0l6Sm9WOGlmR3htQlhLYmZL?=
 =?utf-8?B?U0ZRUkwyNERWckVGbHNmVHVWTXIrZlJudFk5VGc2MWxad0FQSlMxWUNsMitj?=
 =?utf-8?B?VnJoLy9IOUdEVGlwTGRha1ZrQ21OQzJyQWk0aDdoa0d0MCtQMmlBU28rOWll?=
 =?utf-8?B?VC82MDhOODJrMmhpL1Foc0FsMDdYNForQ2Frd3ZiL0RwUEpCU2RIelg3cWc5?=
 =?utf-8?B?aTlPNG1hL1pNSHdSazBDcXlYTHhCRXhhM3JaQ0VFL0xienBEVXVxcGhaaW5E?=
 =?utf-8?B?ajhCR1RnWjQxS2sxVHdxaFpZQ3dzRm02djU5cENrQk84WkJ6MXQreTUzSHZB?=
 =?utf-8?B?YzVUN05BT2ZBR1ZRSG1JVXpITmE5ZVNwZVEycGt2ZFVjMzIwSXA2NVNIVnNr?=
 =?utf-8?B?RllhS2htaHhxYTBuQVcrcUpVL2lpMmF0c1I4UENQVDJweUhTaVYvTWRhY3Ni?=
 =?utf-8?B?WmhGZVdEUWRsWlNXL3k4SFR6clhnbVlub2tWdmZxbDFOZ00wRlVBQ3Y2d0th?=
 =?utf-8?B?VFVzWFZ4cGN3RXFSSFFCcFBxSEpBclZSV1cwcWVDRXArYzFQbWhqdUJMYVpE?=
 =?utf-8?B?SFR6c2JTYTNRM2drSmdnQzExRk56RGZTU0NyL3JOekoyeWs1QlQ2eFgrazAv?=
 =?utf-8?B?VFpORE9IaGdmbEMrYnhIcEFFOXVCdHVHWnZwVzRmM0tuL3RnWjFnRmQ5Yzlk?=
 =?utf-8?B?NmluaUh6eXE5d1Q2bGlkUHhTZjc4czU0V0NCcUZXRFVsNDl0U1I5UW8yRmNT?=
 =?utf-8?B?dytZeWQ2aUxtSEdQTnlyL1p0d0tieC9BalIyQTlXS0dobCtuc1dURjZqZWZB?=
 =?utf-8?B?bXhtWnM0cFdRa2hlU01WdzRqYjF0bEt6WW5nN3llMnllK05ESjRQM2RsMExv?=
 =?utf-8?B?dXYra0VIT2VJUzJGZmZGL3IzVHo2d0VZT1hRUDJ5VXZmV1V1OElrZFpQbmI2?=
 =?utf-8?B?RlEwSE96M1U3czFqeUpWRVptSExIQjRROHJ0N2FsaGs5UkNzLytqLzRvZUhU?=
 =?utf-8?B?UDRMUlczbWVqb2lQOFBMQ0UxQXRtTFd0TVdBREFqTlhzcUM1MHZIckhoLysv?=
 =?utf-8?B?QlZFNjBmYyswcGduY3pRamQwbU9wVloyVWM2eCtESXpxR1lTUEdEZnFBKzlN?=
 =?utf-8?B?NzRpNWVlNm5JaDhuRDM5TW5WUTJpRXp0Z0ROSFBpMlJ1Ky9FSGlSMytNNXBv?=
 =?utf-8?B?WmhNKzk5eUF3RzlPZjFOZ1E3WTNQemtwdnRkRWlwd3JCY0w4cWowZkRBOEZq?=
 =?utf-8?B?dlpHWWlNZ1pXSUpZcmdFb0N2OHVKL2krd0ZLTFpQZ0pCWEZZcS92eUprZVd1?=
 =?utf-8?B?WUhOY2U5bmNLM3B3WXAzQnh1aFN6eGtRclpXSXhkeWlsRFJZU0l2NnJaWVBm?=
 =?utf-8?B?b3ZXY1Bmb0FLQWgweDdnOCtZa0ozcisyY0Mvc0ZHTytQWFFIT1dONWtYcGRi?=
 =?utf-8?B?WDNJUDJjQUJTZGtGZ1o4aG5RR0NpNHRKdjVxMHRlSGxUa0FwWDlZVE1EUmtW?=
 =?utf-8?B?eDhXbk81V0xJUzAzMk1ENFdHZWZCcjNzZXQ4dlVoVDhxdDlIekF1RTFPR2Iy?=
 =?utf-8?B?TVNRdkw5WXBqRXN2aXI2dzcxZFMzWDVFaFJEVi96L3VqMUd1VnJ4SFgydUJV?=
 =?utf-8?B?b3l5Tlc2Q20wZGsvdDNnQWc3K1QySHJjYmtKaWhNZld4Tml4SkgwQVJnc2tJ?=
 =?utf-8?B?WHF4eWFWYldGQWZIQlEzTVljWXFwK0pSdXI2TzJpdVpOU0w3ZURWSkI2SFJs?=
 =?utf-8?B?d1NwTmtpTDhJZ1VRbkd6VkpPWGRNaWlhTjlFT0FwM2plTWJraWtudHk5QW1w?=
 =?utf-8?Q?lZ43Y2yinerXbVEpRC5fNazML?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11bffb1-8ebd-46b1-80e2-08dcedd53b55
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 11:25:26.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyY1pIQYvTGR7F6zUPJzjeMDBnZGqDP/sz9up+ZSWnQKR8b/GzkVUBL3A4Jp0570iMoc2bWnvz2bXgEAk7L1qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917



On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> In preparation for support of a segmented RMP table, map only the RMP

s/support of/supporting/

> table entries. The RMP bookkeeping area is only ever accessed when
> first enabling SNP and does not need to remain mapped. To accomplish
> this, split the initialization of the RMP bookkeeping area and the
> initialization of the RMP entry area. The RMP bookkeeping area will be
> mapped only while it is being initialized.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/virt/svm/sev.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 31d1510ae119..81e21d833cf0 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -168,6 +168,23 @@ void __init snp_fixup_e820_tables(void)
>  	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
>  }
>  
> +static bool __init init_rmptable_bookkeeping(void)
> +{
> +	void *bk;
> +
> +	bk = memremap(probed_rmp_base, RMPTABLE_CPU_BOOKKEEPING_SZ, MEMREMAP_WB);
> +	if (!bk) {
> +		pr_err("Failed to map RMP bookkeeping area\n");
> +		return false;
> +	}
> +
> +	memset(bk, 0, RMPTABLE_CPU_BOOKKEEPING_SZ);
> +
> +	memunmap(bk);
> +
> +	return true;
> +}
> +
>  /*
>   * Do the necessary preparations which are verified by the firmware as
>   * described in the SNP_INIT_EX firmware command description in the SNP
> @@ -205,12 +222,17 @@ static int __init snp_rmptable_init(void)
>  		goto nosnp;
>  	}
>  
> -	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
> +	/* Map only the RMP entries */
> +	rmptable_start = memremap(probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ,
> +				  probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ,
> +				  MEMREMAP_WB);
>  	if (!rmptable_start) {
>  		pr_err("Failed to map RMP table\n");
>  		goto nosnp;
>  	}
>  
> +	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> +
>  	/*
>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>  	 * kexec boot.
> @@ -219,7 +241,14 @@ static int __init snp_rmptable_init(void)
>  	if (val & MSR_AMD64_SYSCFG_SNP_EN)
>  		goto skip_enable;
>  
> -	memset(rmptable_start, 0, probed_rmp_size);
> +	/* Zero out the RMP bookkeeping area */
> +	if (!init_rmptable_bookkeeping()) {
> +		memunmap(rmptable_start);
> +		goto nosnp;
> +	}
> +
> +	/* Zero out the RMP entries */
> +	memset(rmptable_start, 0, rmptable_size);
>  
>  	/* Flush the caches to ensure that data is written before SNP is enabled. */
>  	wbinvd_on_all_cpus();
> @@ -230,9 +259,6 @@ static int __init snp_rmptable_init(void)
>  	on_each_cpu(snp_enable, NULL, 1);
>  
>  skip_enable:
> -	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
> -	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
> -
>  	rmptable = (struct rmpentry_raw *)rmptable_start;
>  	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
>  

