Return-Path: <linux-kernel+bounces-374824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141809A70B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA63B236A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FE61EABBA;
	Mon, 21 Oct 2024 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EAnol9rb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122F1E9072
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530661; cv=fail; b=JkLrKdd0KCVqhdK4ZoInAyLkdyaUhtPV+h4MsPX3zW7QroFBHw8Yty7z+Dp3jP94o5pBn80I2fS6C8YaVkmgqhyLzgk+EhA/Q55jTuSF5LBhoPlxMsl0UuKAPvAdsNs31Nrb/T7QPqmf8xxQvbVu0EAvq8LqTUU8ryfRjkQoeoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530661; c=relaxed/simple;
	bh=clB5hTzmEf7dD1I0hJkX3f8942mZ/t8UP8p5acMfFMM=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=BaQsCINF3NpODd+L9a7uIFdBZn85w3C4dAW1bTO09X+egmkblZ+Qe3vuz7Ebl6Rs6dT1AcD1zlbbqt0GiGI0LMA2noWAINNt49HJoMpfCGdR/FYkXREZDR5qOgHUEngO/J2bsiuIAXH+eoVRqhYXDjd8kP4VtiT+sgDDSP/KhBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EAnol9rb; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSEmuMhxiF6OzoZwGzO4Xe2CbR8snQ79aYF5P5R+01DPnFbdB0nBDRP+Huu7LVYojExM2i4fveKckZz+fX9e5bilxpxktF/ZNDO81P9TJnbw1Kk7wSzc1ijbna2JtZSJmj/GGZI/J4WHgxtRfxBiO2IZkJy78ewxkGDgI9IBUS9HMhqsdxkAP/eBclhhE6pemfmjRBJ0vrNYTbmRvGybzyPO2va185jNr/bNIoTpSJ8XXH++GhIICRMVpG1PmqM5sK3ydXLMsI2VfKipp0Txv1X/rFc/1vvCfxMtFnWXLE7kdwWqWB7QdQn92+YAOhFWtdjSjMGUJzD4SdB1ex+LqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/hRR8lZ700jKEr38dHgw38bL2ICPEdcTI5nIM6alL8=;
 b=LCizWhrHF5BszHaWngafwf095X8v1/vdudgeLsYnmy/zjfNHsA9zUyq7qv8Y7DeHljycEP8xPMMW5sKiOeh8Uv7UCtXWI/iLyiEuoi4oZZbIinF+oX73vCP0y7RLBktJAKVM5YzaHOysu11Gt0FvGykzaWI3WfpjDI924qfA2agDYaPCXiztyop3GgrUbUEy4ZgyGhBVqyJiLbdKacyUHfRkwnWmBfQhi9641j6nXITNIJ77UvH18E6V6+sIgpMwm9OqxFt50xZ1c3rhWTO9VHNpUOMI3O62GivjUOwCzWl3adfy5Gr7QbhImI0/D8tzl+sDDf5UFu8HcvIBmqRdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/hRR8lZ700jKEr38dHgw38bL2ICPEdcTI5nIM6alL8=;
 b=EAnol9rbENWyoxRiyJVSIf0ehYmI/NORdb3IOSUKTQxYnlxHoOXc0StnwYnM59Rwp6j4SRqe+jksMZ+NdhL3eGrm2v/nnpO59DMlgkcrmCuLYzI920WYyhfAlbwKCfE/kLaZ3i93mL/63U+m4KienFrS7RFoIjcn0CtawFdCyl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:10:56 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:10:56 +0000
Message-ID: <b707bf9c-14b6-e210-2da8-c5d01d36d804@amd.com>
Date: Mon, 21 Oct 2024 12:10:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
 <20241018124118.GCZxJXbvAIcEak1gue@fat_crate.local>
 <7820cd89-f25a-4934-9597-d53e861d6e92@amd.com>
 <20241021154117.GFZxZ2HbUPG9ux8bYr@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
In-Reply-To: <20241021154117.GFZxZ2HbUPG9ux8bYr@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::8) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 8958dd88-907a-4686-02ed-08dcf1f353c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWJWbGlNTmNHWXBLYW1CalBtb25pQUhXQ1ZaMkVST2FablRDSkZkc25QVzdp?=
 =?utf-8?B?elIyMTlqUXM0cE5oWjUzZDdrQytUNm9ib09uN0FzMkpsb09LOWRZZnQ1NTNu?=
 =?utf-8?B?VzVTTTI0UmZDV3hiYjFTRkpZRW5pUlA1Sm5kSjJjU2ljVlY2UDlWZm5NNTlH?=
 =?utf-8?B?bVlYMTdZOEtITDJ3RUVGYWIzWlc1eFhYdG1UV1V3azdGUlNESTJjQWFQMi9J?=
 =?utf-8?B?Q240QTl0RnJnOU9YbVJ0aTdFNUs3cHVXUVNDaG9nRVRiWWlENmZoc3dDbHZZ?=
 =?utf-8?B?VEM0cnFiWDQvVDJUL1hNaGsyb0hLek5tR1MvM2t2ck5SQUJmY0VqRnp3MWEr?=
 =?utf-8?B?VERhS3FBTFY4SG1PWFBsYTJ0TVZRalFyRWtzOVZ5QTNMdEdMUXQ3WXg3N2hC?=
 =?utf-8?B?STQ5Z3h4dVRvekNGN1daWVpvVXpQNlhoS25idGc5b09XUjRZSTJHdlV3MXdE?=
 =?utf-8?B?aWZ5K2UraFhxZjlNdHlscWlKdDFaUTBWVEE4UXQyc3B1OGs2ZnNlME1VY3Vo?=
 =?utf-8?B?cVh4bVpYdEhMOU9kZ3FmRUN5MHYrVGFpdjZyYWtxNGNrSjNML1MxU0E1djNG?=
 =?utf-8?B?K2RIRXVVc1EwNkhhODVlOVZScjhrMHYwRWlJT0F0RTV3b1loQVkrQmdJVDht?=
 =?utf-8?B?UDEyV0djYWJiRlVuVHJvbys5VEhWQnN0M2gzeHByTG1yV1hWVHBDTnNzUG5Q?=
 =?utf-8?B?STI2Y1F3Vm54K3lnaUd2U3hRNW93dXp0SzMwYXhEck5QblFnNEFXMnY5WU9u?=
 =?utf-8?B?SlExc1VoSXF5RHphM01JNEp4MzNFV2NUb1JHTUNnWU1KZ2t2d0NKS1pvck4v?=
 =?utf-8?B?MU1wMWFWY3V6NEdRKzFvVFRFMUNwRlJSbExtbkNwRW0raW9jb0tPVUNRa3VG?=
 =?utf-8?B?dzlGaXJvbVF4UVYxV1NDaTR0L01VTFpCVEJIS0hXM2xoalY4aVl4MThWd2xn?=
 =?utf-8?B?VTBBdzhMNnNoelFJYmgvU1pnZkh4djdnSXVJUVYwemdWUEVxdUZmUjI0bjlo?=
 =?utf-8?B?SGNHRGwrWmRVUCs0UU9USFFma09Dd1o0U3hMUi9FMFdqS2lJRWhvMFp0ajFo?=
 =?utf-8?B?dkVZOHpjdXo3U0FxWHJjT3pNN1A5aEZXVVJnazJEN0tLNjFMS1ZmR3BRenpi?=
 =?utf-8?B?Zjc5MngzOXNWdldKOE1hcGRhY0JzWVlRZG00TFpueGlrYWprVmJUd2dFOGZJ?=
 =?utf-8?B?Qnp4Sk1MY0NMaWpxT0dMUkJ6N3hVVmkwLzdjV3JWQkxoMCsvRGtraUdiVXhV?=
 =?utf-8?B?QWI3ZmhWTldxajNSWFBTYWVMczZTWWd2QWVPUVhTYkxoaFdFWEFkb1ZNRGhF?=
 =?utf-8?B?RE9HQ1NydStwSk90QkxsYXpVcXptQzc5STNKQ28yYlJzMHdLcWJua0pwRUFQ?=
 =?utf-8?B?aEprU0x6c21LZndTSS95Q3JDTXczVlo1bm01NzZ4dVM4allLZDJ3cHpxTWp0?=
 =?utf-8?B?NExjTzh2dXZQQzhCMlZBeGpEakkzL2hHT0hjNUpobzJpY1NGRzdiTStPc3VT?=
 =?utf-8?B?bGJzdVc3WFRWc1hYVXV6dnNLcUZlRVdCMWt1TFcrQ0didlFMRnM0eStvOXVp?=
 =?utf-8?B?OFpjWC96VW1KUGtNalBZUGR2MkorZTBVMnpraU1LRW9JS2JFYkc4dVdIYnQ0?=
 =?utf-8?B?YXNwR251WXRjbjlidW9TM2E2anF0NlVrM2ZFQ2hmUTZldDQvalpJTjlTaGlE?=
 =?utf-8?B?dERQWUcvYkVUVXhERDVqdHEvWTFZRkNzZS95TzRiSzRtZmgzQVpZUy9mZFlq?=
 =?utf-8?Q?I16SXYl8t8wF83zeVc06yKMp6lHApIAh0fHbyMy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWtIS3kwbVlhRk0wL241UTVaaDBDL1NYcUcrdkc1dENmNUFYRVM3SjJLYkdt?=
 =?utf-8?B?U2g1UFpic3hKMHUyMndnVHJrVktuRnNIK0tLWHA4WEs3QzU4a3NSY3ArRzFQ?=
 =?utf-8?B?QWQ3ZEtsa0dQRnhwdnVzUVl3SkNVaWUxbkxzbnMzYkYzRWhRMHZIaWczWGRp?=
 =?utf-8?B?YW04ZjlCQU1QL0IzdlViOWxNZ0VwS2ZVQUU3V3JpYlNlemVOMGtIeCsza0tn?=
 =?utf-8?B?UjlCQVVYaGJsbXVrNUtFdER4T3lDOWZUMlpadzU1bFlmVjFFVmlVKzNJK0FU?=
 =?utf-8?B?MENvbUhjb1VCbDI0OFRpNGg4d1FOREJVZHpkeXpoQzlkblQwZHhtcC9vMldD?=
 =?utf-8?B?VTMxNWE1OW84MXYxL1I5bG5TMW9DOVNSb2xheDVRNmVlM0dTNDIxVnF0MVNa?=
 =?utf-8?B?ZytPdDhjbEpKMzVYekh5NVE3eVFnMWRDeHNDMEtzeGdEZGpEV1JQeCtkcXZN?=
 =?utf-8?B?ODk3TGo2ckxCOWZLUTlkcUVtRzNNRmN3MlhLMFJSYytPVkNlcUdKRUhUR21Y?=
 =?utf-8?B?R0tYakhZWjk0eW5BMlBNUGpyMGNxS2RUUkdlMzA2YktOaEliNkRwMHByODJE?=
 =?utf-8?B?QW5NNTIzSHJHclBNcTlWcGcydTFsV1VHTnlCdmFiL3FkS3NLSUNxZTdyQUhG?=
 =?utf-8?B?eWh0WUN4TFZodTk5emVDbXcvUjUvS2NZM1pKRzBRVkNkN0FaenhRNCtUYUNx?=
 =?utf-8?B?cWFRTEJpZ0p3K2NlNTdrSU9aWEgwdW94eWdjbUU1b3VjODNGQ1QySVJnZFUy?=
 =?utf-8?B?V3VHSDVDMkVack9PakdxRWZXdlN6ak0wbGxwdzVFRFJ4SnlpSk5rcm5HNW16?=
 =?utf-8?B?MFlyU1ZCRExIZzlpdGg3V3pZVG43WlhCZSs0ZHR6c2JLMHorUXJudmNyTUZV?=
 =?utf-8?B?bFBsUFljK25mRzFtUXdHdmp6NEl4Rm54ajZTdFRLQm5VUEQrcWdkeXUwZklD?=
 =?utf-8?B?aHRLZHFPRkVjK0F0bHRKQ1VlYnlMT3BTMkl3WXR4c051Sk16TGdvYTRxOGdo?=
 =?utf-8?B?T3k4SjY5RG42bW1XbnoyQlltQUdFaHFLZ1Z3SVFxVS9LZFplOTVIU1FiR0Fz?=
 =?utf-8?B?VVV1L2FKTXhVaEsrRTlMcTFIQVQxbnZiVFROSXN6Tm9OSG1PZGI1OHhRSVpi?=
 =?utf-8?B?dE0zTWNLMStVR0dDRXhheEdZZFdGcSt2SVFWTFNkMjd2RmFhS25UUGtXaHMz?=
 =?utf-8?B?dUp5bGd2bkdHbFpUY082ZG5ISjI5RlNPcUFJY05YSTZiSWFwSlIxWTNBa0Zh?=
 =?utf-8?B?S3RCblVCSnMrSUJDeVRoWnVlTUl1ajdLK0xOSVd0WFFWU0FuMFV3eHdnd2Vj?=
 =?utf-8?B?bjFVWnkyRnViOW5iRnVyZFVjYVB0UHZmanAvWmN2VGprc0dlY24yT01vTXlL?=
 =?utf-8?B?Zi9uRE8rbFB2a0k0QW5LV25RYjZFTlFCNWxMS3VBNThTdE1rcmx5Y3FSMTZY?=
 =?utf-8?B?K0thdlA1QjJDQ0tyM1BtRXVqNTBaa3ZianVjRVJNRzlmNFNldjRNZnBkb2E2?=
 =?utf-8?B?bEJUcDU4VUNHVnpQNzNRWFR0Zzg4U1YwRmdwWDJDYTZjVG95eDFxVzlSMllD?=
 =?utf-8?B?T0h1WUkxTDVZTkZWQzhNMFd2TUZWWksyUXdHM2tYeXNsRi9rYUtpR3dvTER4?=
 =?utf-8?B?UUpUMm54TjllV0taeVlVZ1oxMGFmMld6Vmg4RWl5d0trc2NsVVN3OE9XZ0tk?=
 =?utf-8?B?Y0hhRXdpazU3ZTV4ckdaU3FoVlVKWWVyM1JBS0ZtMXIxcjJFUHNQR2RJb0c4?=
 =?utf-8?B?MDFiR1lNSlBjWjRyV05EeEZRangvc0dCUkR2Y0hucTRCUlR2MUFSdk1UekVS?=
 =?utf-8?B?OTJJTG5UVmZ0QVE1TXcyM3MxaTF5OW5zT1VyZFVsWkJ0dFVLSk53NDZacm5j?=
 =?utf-8?B?eklyclh2Q0lTcnVla0U2VHhNU0pMZENuVnMvYWJSeXZuczFjQXZCOFZFZHR1?=
 =?utf-8?B?OElKeTJ6bFBoN3NPTFMzTWp6U2cvTDNTRHVzN2JVb1poanZQYUsxVU9nNEVl?=
 =?utf-8?B?R3FRSjNSTFRsRnFFQ3VDWFRLR2wxeTRiekdEc2FDVXZHTDhnVlRBNTUyWHdH?=
 =?utf-8?B?THFZUXpJZkcrTkJidks1bjczR203OEh0cHJ6M1BUem9SeGl3NEdEOGh0NDFr?=
 =?utf-8?Q?3MPGG2SaxYEEnTQh4Izk9KnRt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8958dd88-907a-4686-02ed-08dcf1f353c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:10:56.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SxiPrvCoLT3Oq8Nu2LGT3EGSH/Y3XGa4POJvxRySnKDj/PKEggWlkbYjxXv8J/WTIBwuluD/qNCXsrMpXkNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

On 10/21/24 10:41, Borislav Petkov wrote:
> On Fri, Oct 18, 2024 at 10:14:04AM -0500, Tom Lendacky wrote:
>> I don't think so. RCX does not change on output, the contents that RCX
>> points to changes, but the register value does not so the "+" is not
>> correct. The instruction doesn't take a memory location as part of
>> operands (like a MOV instruction could), which is why the "memory" clobber
>> is specified.
> 
> Just confirmed it with my compiler guy: yes, you're right. The rule is this:
> *if* RCX itself doesn't change but memory it points to, does change, then you
> need the "memory" clobber. Otherwise the compiler can reorder accesses.
> 
>> For RAX, yes, if I set "ret" to the input value then I can use "+"
>> specification. But the way it's coded now is also correct.
> 
> If you set ret, it means a smaller and simpler inline asm which is always
> better.

The input value is a 64-bit value and on output the return code is in
EAX, a 32-bit value. So the use of the "=a" (ret) for output and "a"
(pfn << PAGE_SHIFT) for input is more accurate.

It's not a complicated statement and is much clearer to me.

I can change it if you really want the "+a" thing (including changing
the ret variable to a u64), but would prefer not to do that.

Thanks,
Tom

> 
> :-)
> 
> Thx.
> 

