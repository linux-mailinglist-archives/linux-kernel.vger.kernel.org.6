Return-Path: <linux-kernel+bounces-381780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580D99B0462
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17F61F22E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D218E76C;
	Fri, 25 Oct 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AKhtBZLq"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E766212178
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863833; cv=fail; b=bgI3RJjzojxVZBsoQ7CDpHaVFE1WS92NtRzONxAQBvPIWiyL1tv8bgMIK0PRp0dNd32ezP5lKpKAlEFJLIpsroBZvFEyRk84A0niO/GwIyPUvdx+qJpkV9j11bdPIouR1eQi0HWVqHa4pA94jKDGfAeKRNlUCgumaT8icZIxJOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863833; c=relaxed/simple;
	bh=yaceOK7vkyy4z65+IvNelL3/zPCrNYA2PLsSnVZP8lQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mi2rmEpIcRklXxSbdsmqLtWWUysK0WNg+OsKBgHHMQaB5J9+D82ariKYym58rR/2L/Te1reQJBgDZ7+WTTMVWILYozksHKTYSApb1PCgx9I/b5f11QEw598xJE1aYqoP1Xzx3joPERqQB63og5hKcvKKb5Hf1Ldl/qfAIRhETXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AKhtBZLq; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3PAohBR1znOEKvNl5pdPp1TvcdwoqSKdgNOpzWM8OGcT6VV6lPAxmjRNxiXpXv+LFtHB48sPjdyKEgcs/MIToKg6URQhfF6gVo0Q1UX0XGT2sveuZifP9hi+rQS5PoEMP4JtOBPYbzcMGNFlayANlO4RvwH9zxsaYTYUQ0xKnEvZPya8pSbvL7q00li3odgVBtQasJl9gOYhmIZ1xSj8l7jB5G0H0Bgt3wEpvFdF6H/b1YZ4/jFVgOYHVnFSkb460+123LVI6a3oma8z/cn22c+mbX9kY6rnGuNYvIAIit2KiU1m0dv2e9jOW3JC0n0bzVsY07f04Dj6zQapDncgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceU2NEaDKSdW1UBnSzZXd8c4sQiYUuezm8rnMO7pec8=;
 b=XxBdWliMTFefrUKmK6JreimcWCKxbJpmpLOn5D7QX5bVI2BQ5MgQCEiFQuBp/5eH7Ku69XXh2Xuwcse76YhR7wlpZDZxhMbEWTRpqXeXwIQc7ZYIzzdM69G9lJ4yP2PNC1IGGZnwx3NgC1BxmC5B+UQeOtKI9bbk/ms0k050tGKmrAWJoZEDcOf5dQHO+1je0y6Vqm+p/CQCWBQIT0ueKXlhtefXqx7fB8yFfG6VH4f3j0Ld2RffPXdMew3f7iNns9Nz4L6EG+Qfksj2oNPbpb5tmPuPjv6gY/82ONSVeczM5AuyBwv+/D49AkqQENNl7Sd9UNot7NYHUn9WoILDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceU2NEaDKSdW1UBnSzZXd8c4sQiYUuezm8rnMO7pec8=;
 b=AKhtBZLqtC34AOlcKdwv0nZIFC87PqXwInUzIj2xpZ+meVJlOqlM62te9f3OsUbZ0FnO45fLDoSReIcaOU64R0Zs4UjnS4Y8NYk5JxjkZonVs5YN2OcuST1XwN9QCu4xwYV8d3yzJ9RdClKylHHKvWP2c4tdmagLsz8OmFldsu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 13:43:48 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:43:48 +0000
Message-ID: <9d1792de-ef5e-b1c2-cbbe-55b1ef616341@amd.com>
Date: Fri, 25 Oct 2024 08:43:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Content-Language: en-US
To: "Kalra, Ashish" <ashish.kalra@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
 <e4ad82d80e8a484f1d0a46ec94b7c9fccf91d13e.1729708922.git.thomas.lendacky@amd.com>
 <de69eefa-0da3-4142-bcd0-257248c403f1@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <de69eefa-0da3-4142-bcd0-257248c403f1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c25b42e-803d-4e11-1810-08dcf4fb0da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTcvb1pzclE3WXhVamVEdDVCUlBzbmZwRm1GYXVzaW1QRE02alUwbWxkMytp?=
 =?utf-8?B?SlFLVnNjMHMyMmtpeENCUjlENTVrUFdBQmpvRnkxWUhjYS9wS2dDQXdIWWF3?=
 =?utf-8?B?dVBCemVscy8rUFJndm1mMmNlUUplbk1ZVlp6K3RNMEpKeTJjckFLMHJlNHVs?=
 =?utf-8?B?dU1XeHo5RTcyaXYzbFVRUVlFV1pWbStOZlBWcDdrSk1BVG9FRFNuV2o1VHR4?=
 =?utf-8?B?b2VpUFQzbFFVMkNONWxWdGdqQ2FITVYrNVhTaFY1QUFCZXV6K3E3NHdGcFpw?=
 =?utf-8?B?Nzg4YTUrZ04wNHdXeVNvN3dua1gwRS85TWhWMlJrQnV4blA2bWpvS080T1A5?=
 =?utf-8?B?Q0FjQkQ4ZHlFeTRudXZ2SFo2TVJtRXM5MjRkRUJjT2tIUWVnWkUwNHhnY01h?=
 =?utf-8?B?NDI2d3JTNTAzRFFBbzk2bFdvQzFOZUd3aU03aVVYbTNkZy8xREtQU3FFZ0hz?=
 =?utf-8?B?Q241RTdnNEVsY1VJQ1JWdm96N2xzbERuZVZBRUNWSUZZZXJqSldrUlZHNlAz?=
 =?utf-8?B?anFjVGs4RWxZRVVtQWgxaGM5emwxTGpUVVZ6akJmOUxDUzhNVzFCM3FUMUFS?=
 =?utf-8?B?U2F6a3U3L1FJOC9ZamhYMXFhVU5XeE5TeXByOS91K2l0L0tJSThHZEN0WjhW?=
 =?utf-8?B?VkFkU2VNWkhqbmtsWEVkMUFDUnVCd0ovNk5GMHVDUVhrZXc3QUxlZ0I3bnZl?=
 =?utf-8?B?TlJmbVMrWkdsSnFMUW16bk1aaTdyVmsvMkU1RUNGbC8xTkNlT1h0WmYzUGlk?=
 =?utf-8?B?ZHBYK0RwdHRMQ1VtYnhMWmc2WlMxb004bmdTUnNKd3RrY2hwRzBVMk1WQnBO?=
 =?utf-8?B?aGVMS2VtSVY0ekxXeW9GLzZmOWZsYm9kUnpSVUFsK0Z6YitOKzdvamNXVlFj?=
 =?utf-8?B?T01kWkFXbTQ1OWhTVlQ4Q0JHaXlVQlp4eUJETzMweVIrNWt2NnVOdDgza21t?=
 =?utf-8?B?c3JKVlZsdWw5czlVR1pURVBOSDRROEV1Um1wN0w5blQvTm5PY2piUTI4NlFW?=
 =?utf-8?B?cnhDeVJYd2d0ci9uUVNxSHA5UFdhMXdMMHlrRjZOSGlDa205TkxyanBkZzYw?=
 =?utf-8?B?d1FXRUJEei90YUYvY0pTZ3V3QjB2dDJhQkphd1RpQkhORU5CQU91cVVFd2ZS?=
 =?utf-8?B?WEl1czFydTNwemplQ2p5RDRnQlJObFEvbkxkUksyUmdQNnovbDBxdis0VlEw?=
 =?utf-8?B?eHB2QlBQV0JtencrSUhhd0lZUldObWtpNE5DWlRZTW40cWJtbVJLN0NTaDNR?=
 =?utf-8?B?SHlnaHU2ZGVCR3ZaMkNTR0FXd0NHTGFxUlVtYkZwY2I3V2FDOTNLeWx6eWJx?=
 =?utf-8?B?QWZEWFF5em9DWEF0MHowczZtRmwvcnRNa0N4MGIxeldqMzlvWFhTWmlHOGxt?=
 =?utf-8?B?WnpGTUdwdjdsNEJTL21VSzJ6RG5FcEc1YVVTUzFLWmNkRlhITWZFa085QW5y?=
 =?utf-8?B?dlFXMGVWbGpGQzBVbi9qakgreEszNG04eVdxOVNHVjJhdUtqZHF2WGdCQjRx?=
 =?utf-8?B?SEJTMU1YV28rQ1d0L3hIUWtuQXM4Q0d4K3pIdG9kQlh5MVJ5VStyeTNKMzhq?=
 =?utf-8?B?T1lCTmp4QTVxSDZMb1QxZm10dmIyblFBSVkrL2FBZVp2eXplM1B4UnBtb3Vp?=
 =?utf-8?B?ZVBoZ3lIK09XTUhHanlqZVVEc1c1eGpQbzdISDFhb01LSm9CNHpTNXloYnE2?=
 =?utf-8?B?cnVETXd1aG1jemIyNGw1b0IrRE1OelFYY04xTTM4QWtyMzZXaHNjLzlRVE5J?=
 =?utf-8?Q?bh6amffKVqQ6xHbItc8RH11mU4TfYRCfMLKyuG+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzBlVkR6UnV5TitTUzhjMExIdy9WYzFBeSs3UisrYWhrdXdmbVUzbVBUblU2?=
 =?utf-8?B?aGlJV0t6cFBkN254UmFLVlFJTCtWVDlDNFovY0I5TUVscFFQUW9ScnJzRHhs?=
 =?utf-8?B?YnhHc3RDdGhiZWF6bWVIZHMrV2dCRm5rYms3L3RoWHZHTGpxSWF1bk13bjZm?=
 =?utf-8?B?c0JjWHMwMmNKZFVtdVNzTzRua3lPL3k4QzRicEtEUHpseU54MW9xdUU3SWln?=
 =?utf-8?B?bytZZi9JeFZiamdyZjZhQ1ZWMjhXRnluRG5pclRJeEoxbjVNY1FTMVlvdVo1?=
 =?utf-8?B?RE1MdVFoTUFLSmZyUWw1Y3pkWnptd0pTMUNpVHg0eWhLTVZlL0l3cmw0bHdr?=
 =?utf-8?B?bnpUVStiWXhXd3JwZSttYTlTTmNSc2VTR2J4Y3NKeHNHTGVqQ3pNSG00Vkta?=
 =?utf-8?B?ZTRnTi9YOUlKWC9EQURkbEFUMXpkVVNPamdYeXlibExuZHF2czNjekJteklh?=
 =?utf-8?B?eHhORXRydXZrN2dmRVVSOGNIWVRFZEc3VStYa2dndnJyK0NONGpBdXQwakkr?=
 =?utf-8?B?MEQybHRYMWxXMTlLZUZ0NUtCb3hZMXZiTFRmcnRHQ2ZlR0UxZHliem45UmI3?=
 =?utf-8?B?RktFVVJvNmVodkU1dUNONG1RanFnY3NxeWgzckRQYVpTM0JaT01yaG5temta?=
 =?utf-8?B?eDFGOHZPTFc2YnJhU0ZSNG1MQWFiQzdicXJiZndqd0QwOFc2MFRxS2tXTU5l?=
 =?utf-8?B?c0VLZ3IxcnlLTFhJdmhuUU1iZmpRU3VOWHZ5RE9vMkxtZ1pJYW9ndHdmRy8x?=
 =?utf-8?B?U1pXYzZOOVJTWG5yVlY0bzEyRXZhYzlVeWxJZnNoYjJZWkhpMTJlVGdvTktE?=
 =?utf-8?B?QlVCWm54eU9ISDBTd0pXQjdIQlFJRkc2ZVRhT3VBcVl0bFFqTHA3YzVpUVVO?=
 =?utf-8?B?cEM4azVYR3FnK1Y3a1JRRTNiZHFVNktncGFzTXhjUkJXckNIMGlianRYa01p?=
 =?utf-8?B?MGxuWkxmWERHdGhpb3IzbDk1NnNpdkpEVU1KWnptd0hGL1NmRWc2N1Npd2ls?=
 =?utf-8?B?K2R6WXd2WnA1WFVvVzBwNXVtTGovMjVBb1gxOFcxZVFoL3l1WGNrKzQ1YzdT?=
 =?utf-8?B?aWUwWTJzTTAxbnNPN0ljdHhwNUNxVmR2anl1S2lNN3J6Uys4Q2cveU1URWpt?=
 =?utf-8?B?ZVFZTkFjRXI3WmFzV2VtVThxOFFHZzFCTEtoRlBPS0t4aFVSR0VvZGxnR1hR?=
 =?utf-8?B?Y0NuMHhzUGpadm1ibjJxWjBQWTlPaks0MmdWekh5aGtUMkxrendnM3REUjVz?=
 =?utf-8?B?MGpQcks0c1o0dTY3OXNIaHZ0VGlyUFUzQUhwRFNBT2N1cytITlJZdjFrcERa?=
 =?utf-8?B?aXBoSlgrVkp2a05mR3NMTTV6VWtPWDlPZ1YyeDF2NlZkcmM2TUtpc0Z6ZFRE?=
 =?utf-8?B?bForM1hzenVGbU94MjRlZGlYTnRvMDZUWDdRNm5wOFZEeU9ocS9haEdseFhH?=
 =?utf-8?B?VGNKWG1HeGIvZlR2YmtHNjd4T0NMMTFtZ0tDUmpvQmVTWmNoK3BiUC9aQ21a?=
 =?utf-8?B?U2hieDVUUkpxVTdaOEgyTjhkTWJnODNhNCtHbmtqZ1ZNMGFuRllkaFFGdmM5?=
 =?utf-8?B?YXpyZ0ZFOTRSL0pWUHkzTCthNFZGTFQ1WU00ZmJ2eUlzbmlrcVlTR2hOdWxH?=
 =?utf-8?B?eGxUVkJjOFZXeFhMUEdNWVJ5cy9PR1p1WWMweHBuWFpxWWZLQlkvYkhyWlVv?=
 =?utf-8?B?Ukcra3JIeWpYSy93Tk9sNzhmM3I1cWV5dGFrOWFoV3VLMHowL0VGTi8vUzZo?=
 =?utf-8?B?NmR0d1lTUHlGNURBOUh2d3o5bHpvK0RnK0pMNnFzYnN3S3pWa0FOUGZZNkt0?=
 =?utf-8?B?TlY2TjdzdmwzSUVXL1h5d3dHQ3V3SFhSZjhmTHZ0eDcxZzRWcWxhTUh4enRV?=
 =?utf-8?B?VjN3bXFwK2xGbldEcXp1ZlQvTnlKVXdsY2ZQbk5WTFBwQ28zMmpEWTBZTjgy?=
 =?utf-8?B?N0dEeTFrV2hhZXVqR21PM3hGdWVYa05hQ0Y2aTRXNUh6Y0lqV0xpays1UGpx?=
 =?utf-8?B?aFc0NS9vQm9hNmE3SWZYY3NOS3M2YjNkbXJOazNab2FSWllOdncrQTBJUjc5?=
 =?utf-8?B?bzdTTGE3dU04bzlQa3ErdkRRRjhPMFhPVGxjVDVwdlVtbjhjYTVTby81ejRp?=
 =?utf-8?Q?WSM+RYQcnw7quPku6fWRgTVR/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c25b42e-803d-4e11-1810-08dcf4fb0da6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:43:48.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKI8h5pguf7gZKakmq0YmyCrcaaF2Qh0ReCgm+GQ4gh7dITto5zDzz7ReQRe2gG8Qlgtf230F/aOZTStU8qXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995

On 10/25/24 06:51, Kalra, Ashish wrote:
> On 10/23/2024 1:42 PM, Tom Lendacky wrote:
>> In preparation for support of a segmented RMP table, treat the contiguous
>> RMP table as a segmented RMP table with a single segment covering all
>> of memory. By treating a contiguous RMP table as a single segment, much
>> of the code that initializes and accesses the RMP can be re-used.
>>
>> Segmented RMP tables can have up to 512 segment entries. Each segment
>> will have metadata associated with it to identify the segment location,
>> the segment size, etc. The segment data and the physical address are used
>> to determine the index of the segment within the table and then the RMP
>> entry within the segment. For an actual segmented RMP table environment,
>> much of the segment information will come from a configuration MSR. For
>> the contiguous RMP, though, much of the information will be statically
>> defined.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/virt/svm/sev.c | 193 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 174 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index dd256e76e443..043b2582e10e 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c

>> -	return rmptable + pfn;
>> +	segment_index = RMP_ENTRY_INDEX(paddr);
>> +	if (unlikely(segment_index >= desc->max_index))
>> +		return ERR_PTR(-EFAULT);
>> +	segment_index = array_index_nospec(segment_index, desc->max_index);
>> +
>> +	return desc->rmp_entry + segment_index;
>>  }
>>  
> 
> Ah ok, __get_rmpentry() is finalized here in this patch and rmptable & rmptable_max_pfn 
> are removed as part of this patch, so probably my comments on patch #1 are not relevant. 
> 
> This is somewhat confusing, maybe some comments can be added in patch #1 to explain that
> __get_rmpentry() will be finalized in this patch ?
> 
> My confusion results from the following : 
> 
> Patch #1: 
> __get_rmpentry() 
> --- refers to rmptable.
> 
> Patch #5:
> rmptable initialized here.
> 
> Patch #6:
> rmptable not required and removed in this patch.
> do final cleanup for __get_rmpentry(). 

Patch #1 was just a restructuring, rmptable_max_pfn and rmptable are both
initialized in snp_rmptable_init() as they previously were. So no real
explanation needed.

Thanks,
Tom

> 
> Thanks,
> Ashish
> 
>>  static int get_rmpentry(u64 pfn, struct rmpread *entry)

