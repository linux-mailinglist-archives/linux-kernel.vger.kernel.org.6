Return-Path: <linux-kernel+bounces-290298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0229551EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0712B1C21A19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA551C57AC;
	Fri, 16 Aug 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cyHamYu4"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E21C579F;
	Fri, 16 Aug 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840837; cv=fail; b=ell5FSYUY5p4hmSWumnck5Iyv2jgaBT+I1Ytw/qdo2lp1/RimkPLmYmCtXaias9Vdj+ibN9aVDHNjfsy79gH3/yCunYVZvDO5t1D9okQbPDTzZL/6md0oTbnoph7N37UuV2gjXiccwbnIBN8k9wVNVRyi5U/DrF1KB3VYMcou74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840837; c=relaxed/simple;
	bh=Gs0d9x0O4E0CwVaW0tlKzW72doP5XaBkfVVMDetyL6s=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilxZSuaq/1nYqlQMwxpzoRaOzFcCzeNa3dVF72NfGXG2ME1qVxLudOe7Yu789Lcgz7h/6rapfCmBMuquLxsP2vgyBE7UQ03zCXTWdsenEgptKS6sqNFTBtqRGHuzX84CgACWIFX20VbQSd+bRqc7Xj50kAXc+4y5OBo/6YPUTIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cyHamYu4; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLmCqac0/Ag2mH+dGE0zoXhveVjrQAiBt6w2pnbZnwLQ1U6T2nzp/GzqkBHPZVCD/3SjDM9xr08RMY3e6Zgst9/hXyScyBG8lTCbkP+2nqB1LylPp7KYUY/SEQu0r5efbupD0WYl3J/YIgtYd0jw+kA3NJ0nhfRLS4NZHvWUHhCxMP0LFNa5kE2kZr2uCP71WKvJIq0S7PEpquAIst4GKR8Idnb4zR4o6/7O5pePddDAgAVHsJqaWwjJlmVKckTk5jFxNVkRAklgl2C87Fa0DgigYeBYwwU88CZMdiOYQJZRKfujgFe09/KFjkzMie0Jf1DsOmF/U6q4X00Xs4HHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rozb/JdKHzB2hcVQd+wWkKkCrjLPFTmC94gNuVQZDtU=;
 b=cNwwALn6nZtviVzcVssyuo+XIr3kHLugcMpCXNjmAoaNtW4q+3WK1K8MWgudaNCOWZKnQXFXZc6B4zEVyerpjWR2+2RX+FCnnWhoIiP2uhIehE2HgwafE7xq1mezsFsLKz+HGoaCLFRSp8HrMflL8kVaG3KqYXv6/aE5lnKCpaND6Qlu5hu5cGUx8o+Odg06fPmj3Qa2+Y/lGvjQvPRlFn3dUu1qSn4H9bj0f7PVBgyduJdBX0MB/cZ4heAX9oF+vNnrI38hodxiM1oLwsb1bIPn/YcSQcd7TvtglfVpc5ha23WwXlhJia2/EFl3UphaIBzFz/M3d2vJ88CFd6GHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rozb/JdKHzB2hcVQd+wWkKkCrjLPFTmC94gNuVQZDtU=;
 b=cyHamYu41hyAMvvGa4Ud/+Me05Med4Y+/M1ESPPpUR7ojKTecWNEbouvaqQXDQdIUsvUwyTtMnzv3QrQlx6ZM0OBUe+cvXo5FuPPWibEed2kIebOf+aQISHF0Op6M1yA6wC2IvEzRvEuwPIGQAqAlzxizNKK/8juyaMtYAvzapM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 20:40:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 20:40:33 +0000
Message-ID: <3d3acd15-3cf0-48eb-8b3b-53fdca1df7d2@amd.com>
Date: Fri, 16 Aug 2024 15:40:29 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 21/22] x86/resctrl: Introduce interface to list monitor
 states of all the groups
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, tglx@linutronix.de, corbet@lwn.net,
 fenghua.yu@intel.com, reinette.chatre@intel.com, mingo@redhat.com,
 bp@alien8.de
References: <cover.1722981659.git.babu.moger@amd.com>
 <821b725e9f00b4d423cc28d777d66d5681e1ba29.1722981659.git.babu.moger@amd.com>
 <2a65c646-ccd4-4e5e-bd1a-f56e69b1532c@arm.com>
Content-Language: en-US
In-Reply-To: <2a65c646-ccd4-4e5e-bd1a-f56e69b1532c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 087906d6-2fe1-4dd0-332e-08dcbe33ad0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S09LSU1jazUwL0UvSlNtN2JaazJCM1pOMW1MSW9KanprcGlqUkt5bHVyb3Jj?=
 =?utf-8?B?L29JTDBCbGZ4Qi9TUWpJM3lVTXBEV0Y5d3lEWkRSSXc3dWJUWkVPcEZ6QjQ2?=
 =?utf-8?B?QkpEcU1hV2Y3MFlDSGdZc1I1SlZyNTVrUzhoVW0rbXVYMTdEeEw4TVlwRGVL?=
 =?utf-8?B?bGxhUUhQRGg4cWJ0K3RuY05DaFJraGNWeUtRU3RHbklScmxyVDBZM0FSWFgv?=
 =?utf-8?B?TzdGb2pCMHNCTnNuQlVLaUQxTlNhbWlueHdJRzhtVXNMRWhwelhwVmt5NXgx?=
 =?utf-8?B?dUhoQmJCalFPU1JpdEEzbkIzeFJsT0R3bUc5VzlHRHlTRU0ydGNhVlR1SjV6?=
 =?utf-8?B?QU43eHJxSFVJVEw2dC9pdGVBQ2QvYlpDT1Z4a0l6T2JSeFFGTzdBMityenBZ?=
 =?utf-8?B?MVlKNVJBSVBkNUk3c05kaGFlS3c5cklRNkovU0xveEJYY3MvSFJoNlQwblNL?=
 =?utf-8?B?ODdBZHhFSHlGTjVxV0IwQ0ZHck5rY0xKV1lYRmlIT2lkNkdLQmNaT3VldlR1?=
 =?utf-8?B?NlJ1Yk1ZeTlHcTlOQi9JcThVQVdKWFFWU3d4S0pRNDVBeDRKR3Qvb3JsZ3F0?=
 =?utf-8?B?eEdWb0lTK0FVOUUvem1EMU45RG5pSDRvSy9ma2FZclVSdFdZY2FncUorSjhn?=
 =?utf-8?B?Z3l2eGNFWjhzcDd6Znhjb2g3K3lZU2dnait4Mzg5UUVPS1JSZDNxYUE3U2Zi?=
 =?utf-8?B?UzFOU1FXM0E0SXcrNjdXZnhnSkpDdW9saXhmc2doR3ZqVnh2bHBOcmtFR1di?=
 =?utf-8?B?Qkc0eDJpWjJhTk1GS3dFeFEvMVNLZnVLRFpDbndNc3g4Qi9IWEV6UFdCbVVs?=
 =?utf-8?B?ck9IaHNvdlhUZU1takxtZHBzelI2UmhTVFNOQTZndXVMRklqaWpKZDJFNG0w?=
 =?utf-8?B?NW53UnVIRnF6dlRvRklsZlpwbU4rUTdlOUtncDhlN2Zvd292bWZvTkJ6MzRq?=
 =?utf-8?B?Y2l4a2lQNVNYNitteTUwVm9TaURnbERlR0VKU0NOUU4zMXQxdW94bUhrM09B?=
 =?utf-8?B?bXM1bmNld1Q4TW5HN0RjaUZEZ3NYVDRiaUhQVklIVFpKLzdGd2Y3b3VucUlz?=
 =?utf-8?B?eXFrU3FvY1FPM1QyNHluSHRHWFlRbjlkd1RPcjBzUjB5SDI3SCtDTTNzRWtP?=
 =?utf-8?B?SERUd0NXemJzR2h5WVFSb1lvdWNPSjdkNmZrdE5JRXFxUm45bmRyVUlFQjZq?=
 =?utf-8?B?VGVXZEhXZTRlYmVvUUVpbHRYRGpwU0tiSzNvS20zWmM5aWxYTWpSVUxsaDZ5?=
 =?utf-8?B?a3dTSTdvakY5R0Jhb1BnSEVZbW9PbTBLMUZNT0lLREhzeDdzTlNKZ0RMZU03?=
 =?utf-8?B?MEV1SWhvSXM2bjZhdGZobTJUSEVSN2VRK2c4U2JIWmNHMmRPcEgwM2FUeG5L?=
 =?utf-8?B?TjFTMFdaMWJDWWh1d1hpbmVFZ2NGSUFCa0hLVHhlVFlFcXh5YVl1MHBzc2Ro?=
 =?utf-8?B?SEE1L1Zwa1pxQ3ZjbkFRY3BhYzloVmdPYlZKaTZGUGlpUkd1VHJwMW5jTEhN?=
 =?utf-8?B?Y3orcXJRVk9TMUxzNS8wbnphbm1EYmFSdHlrM1o2RHlzMDR6dE1tMHlJQVRq?=
 =?utf-8?B?UWpRSUlKOHFHOTFTRndJeFlWWjFESmR2azJxT1RvSERLblhIcXFla3oxS1Ez?=
 =?utf-8?B?SEhGSU82UFhWaFZFSjhNSm93UkRBcWdONDFOM1F1cjNPNkVIRGxWWm1VcWxs?=
 =?utf-8?B?dlhpOS9PMVdmSlN6QlFiNW1LQkc5TWhxUmlJQXB6QmlKM1dmbTBoY1Y2OThw?=
 =?utf-8?B?ZmZuWnpKd2NrZzBieGdCWDRiMWg4WEY3Rmx3akRJZVFvTk05bGFscThBWGY3?=
 =?utf-8?B?aW1BUzRYQUpKNUhqMUgzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N04xRitrUVFqWnV3SVlTTEtXKzNNZkRsaFZmaUVQS2IyMzJKUUw0Q2hnS3lK?=
 =?utf-8?B?MGNZT0hSVThLcHVkdnBZYk53NDgrSngweTIzMU1vdTVMVXU3TjY3aGo3Mmpq?=
 =?utf-8?B?alRNNWlpQ3ptdmViUDlhWmdMMkxhd2R1S2JkdlNORFduVUZyR0M5OGpVMW52?=
 =?utf-8?B?TWE2TDI2UDI0dEZnWGNsbXRYUDhiMmhjZE8zc1lOVHBtU3UrSkpaWC9ybnov?=
 =?utf-8?B?SUluR3NIbitHSng1QXFXUnduY2FmcGhuSi9pdWdzUTQ0bW5lK0hueXpMTndT?=
 =?utf-8?B?QTR4d2pUSEJXYktLTFFaQVBzcDBWNm8wcjZyaWVEK2FheTRNTi94STFPcWgy?=
 =?utf-8?B?WFdUYkNmeURxSzIzamROSTRna3BtMVNHVWx4SWxvMnc3ZlhFWG45UmFiWm5Y?=
 =?utf-8?B?VVlXOW0xejlOL0Z0RUxMYW51SnFPM29DbktLcDZGMEhHejFSeHYvYW9pWko4?=
 =?utf-8?B?a1lERnlGSkI5TUZRcTU4Rko3cGRIbFVNZW9CUHNZS2xzc2NoSEtMNWk5RzMz?=
 =?utf-8?B?NE1LODBVaXRUbllXN1dXWGkwelFWYlpyMFdrYXRMcndDMVhnTHlMd0VGV0ZX?=
 =?utf-8?B?c0pxZDNTWUJGUTNqNy9ObkF0M2V5ZTFFc2FNZ0N5U241clNTZmxWQnRKMEhO?=
 =?utf-8?B?dGVLYXFXZWgrWk11T1JwZWdrbStPNTF3Y0hUdVZlOFFIZUxzRlFRSGw0Tyt4?=
 =?utf-8?B?em1KQm9VTTJXKzF0RzZDWHBoL3Y0TXNOS2tCdkU4aWtFdUthT3hGRithUnFY?=
 =?utf-8?B?ckJHWDNvN293UURtSTdHYTgvY3ZPOWZCN3RONGltc2FYVkt2bW9sbmtyU0JX?=
 =?utf-8?B?SDJyRm5sK2Z1b3BBbFVtbVluOTZPVjZrSDBjMTRNRGxzUGNqVFN1TTBXMUty?=
 =?utf-8?B?Ym8xUjRWTFZOd3NJaXRnclVKVUFDQllpd1JJRDlkWTlPdjRmaXc3QnJjc3FG?=
 =?utf-8?B?SHE1cllydmF0ZE9ER3U5Z3J1YlVBMW42Q2dyaHdIdGMzOHlGbEgwelZBaUZy?=
 =?utf-8?B?b2VRMVVSTFNzWGp6b1RBR3ZoUXpGMG51YWlLS2dOVkhiVXBQaWZjWXVvRUM1?=
 =?utf-8?B?Y0JSNUJYcEV4YkszMjc2VVVRbk9jTU1wK2s1V0prbnhZanNaMW5OWTFtNThD?=
 =?utf-8?B?ekEvSDNreWk3UUFOOGkwV0E4Q2NCWkt1QmtFNjI4bU93REQ5VXFDalNGT1JU?=
 =?utf-8?B?L2kwRDF0UytwNndERFdPR0pPaWJDaWIxNjZvbGZXZnVNVjQ3K2lvTWl5WTRk?=
 =?utf-8?B?ZGE2eFhCejAvanRmM3VrQ0FQZDFsamc1ZjRmQjJJSHF3bmpGcUE3amxsdUIw?=
 =?utf-8?B?aXErVWcyMytlZk9FRndTSzI0ODBYbFprK3pkWjM0OXJXYzF0N2Z6dXNEdmdn?=
 =?utf-8?B?TzU4Q25HL2YvbmllZkhoclRPaHVHcnlVUlQ0dVUwNllEaEZQV2dJbWd3Sm1V?=
 =?utf-8?B?ZmJnWDY1Z2F4Q3NiUXBReHE0c0JPWW5XM1ozWmEzZDFSUEl5TTFPWVpmWU5k?=
 =?utf-8?B?MStiL3ZpV2pXY05saVNrVTRHVVZxUVRkN2VBeXFMNi9HclBjZHRFMnlMTC9B?=
 =?utf-8?B?ekwyQmQ1QmtMMWg0anpQbTJTbTZBdlVNZHl4eDE4MnIyNFpMUkVqUXdicFBI?=
 =?utf-8?B?Skhqekxham1odFBwcm82VFFXWDZvWXpPc1pBeEh3NW1uZ0t2S3B0T0RrMDJu?=
 =?utf-8?B?UWtHT21wOVlQTUpJdCtXczN1Sm9yTG0rdUNYMzcwRmFLaVdyRlVERWxoNDdl?=
 =?utf-8?B?aXNxVTg3ek1kZUljdWp1WVkvUXVmQ0lHZVkwSXhJKzFxWGJ1b054bG1nVXNS?=
 =?utf-8?B?Y0pycGdXQzBYOFE0aERhYXQraG5vUUpDMEtBWWhqdjFCVWtVZEFnTnJZWUpz?=
 =?utf-8?B?WEVGbStaZnhvU0xuSWF2SVBlVW1DemhMOGNvWHNkVGhHSjBia1RuTHlJRHJG?=
 =?utf-8?B?bVBobWJwdnkxNGZMdllCbDBQUW9scFJJNEN0b3kwcHBCMUUxeHJMSjQwbjZk?=
 =?utf-8?B?cVN5aWg1eDlpeUpJR0RRS2RwTnZKc1lQOVl2T0E5eS91bzcxdFJ2VDlaV3Mx?=
 =?utf-8?B?T2lSQ2ZlQkVOUzEvMDlHMkpSQ0tYVEhSb1BBYUl5eTNweS9PR0xEWmxpRHo2?=
 =?utf-8?Q?Ch2M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087906d6-2fe1-4dd0-332e-08dcbe33ad0d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:40:33.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnkaz6KQYLpJCOBkTEd14pELODwm6MLBBqJyAXI2INElKRWvjdTn1im+7nI84igZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

Hi James,

On 8/16/24 11:28, James Morse wrote:
> Hi Babu,
> 
> On 06/08/2024 23:00, Babu Moger wrote:
>> Provide the interface to list the monitor states of all the resctrl
>> groups in ABMC mode.
>>
>> Example:
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>> List follows the following format:
>>
>> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> Format for specific type of groups:
>>
>> - Default CTRL_MON group:
>>   "//<domain_id>=<flags>"
>>
>> - Non-default CTRL_MON group:
>>   "<CTRL_MON group>//<domain_id>=<flags>"
>>
>> - Child MON group of default CTRL_MON group:
>>   "/<MON group>/<domain_id>=<flags>"
>>
>> - Child MON group of non-default CTRL_MON group:
>>   "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> Flags can be one of the following:
>> t  MBM total event is enabled
>> l  MBM local event is enabled
>> tl Both total and local MBM events are enabled
>> _  None of the MBM events are enabled
> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index d15fd1bde5f4..d7aadca5e4ab 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -965,6 +965,75 @@ static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
>> +				       struct rdt_mon_domain *d, char *str)
>> +{
>> +	char *tmp = str;
>> +	int index;
>> +
>> +	/*
>> +	 * Query the monitor state for the domain.
>> +	 * Index 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>> +	 * Index 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>> +	 */
>> +	index = mon_event_config_index_get(QOS_L3_MBM_TOTAL_EVENT_ID);
>> +	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET &&
>> +	    test_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map))
>> +		*tmp++ = 't';
>> +
>> +	index = mon_event_config_index_get(QOS_L3_MBM_LOCAL_EVENT_ID);
>> +	if (rdtgrp->mon.cntr_id[index] != MON_CNTR_UNSET &&
>> +	    test_bit(rdtgrp->mon.cntr_id[index], d->mbm_cntr_map))
>> +		*tmp++ = 'l';
>> +
>> +	if (tmp == str)
>> +		*tmp++ = '_';
>> +
>> +	*tmp = '\0';
>> +	return str;
>> +}
>> +
>> +static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
>> +				     struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
> 
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> 
> This is filesystem code, once it moves to /fs/ you can't grab an architecture specific
> struct like this. (suggestion below).

Yes. Correct.  I don't need this. I will remove this.

> 
> 
>> +	struct rdt_mon_domain *dom;
>> +	struct rdtgroup *rdtg;
>> +	char str[10];
> 
> Shouldn't new commands that might fail start with rdt_last_cmd_clear()?

Yes. Correct.

> 
> 
>> +	if (!hw_res->mbm_cntr_assign_enabled) {
> 
> I think this should be wrapped up as:
> | resctrl_arch_mbm_cntr_assign_test(r)
> 
> as this flag is private to the architecture.

I can use resctrl_arch_get_abmc_enabled()

> 
> 
>> +		rdt_last_cmd_puts("ABMC feature is not enabled\n");
> 
> lockdep barks that you need to hold rdtgroup_mutex when calling rdt_last_cmd_puts() -
> otherwise this can run in parallel with another syscall.

Ok. Sure. Will fix it.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +		struct rdtgroup *crg;
>> +
>> +		seq_printf(s, "%s//", rdtg->kn->name);
>> +
>> +		list_for_each_entry(dom, &r->mon_domains, hdr.list)
>> +			seq_printf(s, "%d=%s;", dom->hdr.id,
>> +				   rdtgroup_mon_state_to_str(rdtg, dom, str));
>> +		seq_putc(s, '\n');
>> +
>> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +				    mon.crdtgrp_list) {
>> +			seq_printf(s, "%s/%s/", rdtg->kn->name, crg->kn->name);
>> +
>> +			list_for_each_entry(dom, &r->mon_domains, hdr.list)
>> +				seq_printf(s, "%d=%s;", dom->hdr.id,
>> +					   rdtgroup_mon_state_to_str(crg, dom, str));
>> +			seq_putc(s, '\n');
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	return 0;
>> +}
> 
> 
> Thanks,
> 
> James
> 
> 

-- 
Thanks
Babu Moger

