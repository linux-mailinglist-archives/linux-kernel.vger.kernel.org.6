Return-Path: <linux-kernel+bounces-443254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F69EE940
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF92C28402D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E912147E5;
	Thu, 12 Dec 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v6tRAMmM"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304120E716
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014790; cv=fail; b=sFuo0aL7p+dDj6UBC84GEgKw1jY1zxMn/sqaK0uN4bIdg8MC7+/Xya62d22UxRrCeWDDQohwGeoqw/B7FQK/veTUoXE4rDoaSZNhHMuygEsz3cn17VoSDIcUVG3jL8EqpjuMri1iTwgtkHszaG4ajvqztTvhjEJmKXGP2VvmYR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014790; c=relaxed/simple;
	bh=AT2AYeK3ilIPwme1j/fXMumpUQOnlmuL7LSiGBiaraQ=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=oVuFhJkgZo2E0MX8wd3m5qJWYiLFJxk7ugaX/VAFsJ5l15+g/K2CNVlppdMUn4NHpMIZlVUeduQMiiqF5oBlvw9wI9VbHx8VVERzzVc0pK539h1ei/M9D81xHEMVegq9QgMMHH6GOZuhJUJZl9TUFz085nCTuRKbQ0R4zuhieL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v6tRAMmM; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxbHGR99Wj96uMQ/aW11OrTKyQJw8LUA0m4oOnqTHVuZMrq8iJ4Nk0Q+nxgjqvBnGREIzjl2ZOcYMBLpQjW8Ni7E5Wu7khbfTbkbbvHROcLJQSO8J88och0PIzy1Oh1hsJs4wjJ5zu5emtrruk0ni9zNPYT2DKDuCp5L3QmTg9uo9QSjoHJC6HxNgLO4AqUccndqOEaUKHZ+UIB78ChuhR5+Y24IkSzahzUsRSwwJKRwv6uVoQdSXqzzPnm6RGfOf7Z7lHd7g86cSZX9v2vC1zf+2HdPzdzOFSYKrZEZtltrBrGUSxzrYAMYj6Xiz4dF4nUkk9uBnXtMfRQT/XmQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx0zHYo/VBoFDcfDNhbzkKZnGjbABEC2+tKsX2NCIDA=;
 b=TMFZZEhoRRNaT3w+DwVM7GjW0/lGT+JbWRpNNvga0Jot4/o7iM3W7D6MkmpE8f1N+j3e0r1vaGMxdaY5F5EbLOzx+cy7sRJ6hIP0BKz9oO4CogH8ZaNNsYdtmoUrriwpmq5oSwED6EiCEzK2lnIzdD4gvTOx4+CrZqfLrpYM259hsjgBiE5nez+9Q/Xl6gnfSvnpX9mUbPpuNXUOdN1ppM++Xx7yBdzwASGk+DRHxYIcqUzIU/EQ9V8LD/U0x6LTcJdUlMMRTqoOuse2+Z1yC8jVWk0iEm2m5cV2vfZqZstBynobjAmTq0vKdtPahMgoiEHb2PuEqEiixgKNQz+Tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx0zHYo/VBoFDcfDNhbzkKZnGjbABEC2+tKsX2NCIDA=;
 b=v6tRAMmMbkRpnjwO8gxmeE4DrnkVi9e6MLiNHc35mbgs/waWJisclrJWsbfo3PhAroueRZtDM4zkgoh6V3GQUfEW2DFW6b0crz7UdsX7ctB2eKW2CvGqzlz9mvzyuF2jVS/4xz4l3+86e3XU70L87jG+tlf2nX9QPuPJKmONsv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 14:46:23 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 14:46:23 +0000
Message-ID: <b1ba3ffe-4336-4901-fe35-03971ae1f82b@amd.com>
Date: Thu, 12 Dec 2024 08:46:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <c3c5acb445f9cdea6d5c0f16ff961aca65c05528.1733172653.git.thomas.lendacky@amd.com>
 <20241212091152.GEZ1qo2CJgP_V7Xvma@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v6 7/8] x86/sev: Add full support for a segmented RMP
 table
In-Reply-To: <20241212091152.GEZ1qo2CJgP_V7Xvma@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:6e::23) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 574d29e7-da88-4fdd-fac1-08dd1abbbfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGJlekV5eCs1WnZCYityZ2cvOE1RWmFhY1ZoKytSck9WSi9pa1NScEhZNmRZ?=
 =?utf-8?B?cU14ZFQxSFBKNmZRaVNweVd2SnpIRGk3b2VUVGVSYlZKcDNOVFJKV21lUXox?=
 =?utf-8?B?SXhsaEhOSTVxZlI1MU1FeDJ5b0N1cFpYRFUyZVNRMFBMU2V2U3VSbDdWUUZp?=
 =?utf-8?B?d1RTMW00VkFMTmdxNm9SS2VJRnZEakNmTlJ6ZkJIbFBCV3gzZWtXbCtZZTBk?=
 =?utf-8?B?bG9RZkVPRCtBVmZTS3ZvQTgvbVk3N2UxSGp3Z25zOUFSZE1JZldMOEFwamdq?=
 =?utf-8?B?QjJ4N01CRW5MZW0xMUp0aW9GdXIvcVhxNUZWT1NDdGkyaDdNaHRvcnBTS3lL?=
 =?utf-8?B?OGR3Sy9PRnJvOW5XUE44cjJNa3d5a3JZMkFYUVVpRG5rRmxiMEtBQ0dUSHBp?=
 =?utf-8?B?Zk83cGc0M0FaTHRkcTVFWmNxSmR4TVlTSTVVNVowMEg4TDloVjg1a0k0aUNY?=
 =?utf-8?B?K2UxZ20xVmhxV0xROUt4UXNmdko2L245ZEQxdGhGeSt1SVhvdmxmUTBmY2lk?=
 =?utf-8?B?ZDJ5TkpNWmR2VTBGVTVSaHVLTUhhbUMzamROWFdLbWNDMGsyRWNKYWtPWnRI?=
 =?utf-8?B?eTd1WjhSN3Mwd3BrcTZRVGVhbnNzbEtqeHA4dWdyYUFmV20rV0ZibHIxV05I?=
 =?utf-8?B?WGpQSVZNM2JQWHlBcTFGcndNWFd5cjB3SXJaK0xTZ3A2WHNFb2NjeE5NNWx2?=
 =?utf-8?B?MEVYRGdwYTNoM1Z1YTBNbndOdUxQOTZhYnM1QksxcE11VkdnUFQyWkFTQ2Qz?=
 =?utf-8?B?YXpDaVRjeHJJS2QwZ3NXVWkyLzVHUndoSXB6YTlGNU5QcWw2L0VDY2kyTzZH?=
 =?utf-8?B?SWMyOVJPeGVVbWs4VUsvbWhWbGZuL1puSmZEM0dHWHNQNWlEaWRhb2FXbm5m?=
 =?utf-8?B?eWIrN2RRdWtWdVFhU3RqSHlPWC9ya044UkRjMGJlU2RITTV2VE9hS0ErOE53?=
 =?utf-8?B?QXlxMUdpZENlOGwxYmxlenJLNVRQUDFiYWEwSXRTVFJIZGhHdVJSb2JFNWhD?=
 =?utf-8?B?dVdVZDE2MUNRVTU0cHRvRXZpNEJkTHdRQk5ESVJiVmNwcUpScnE5Wll3S2Rm?=
 =?utf-8?B?a1VsYmtFVEZLRE9WUFFqNmlEaEVMcXRrb2FDQnByQUhkaU9MZ1Q5MnFUZVlj?=
 =?utf-8?B?N2dVNFpjZ3FmcStoTkRQd3c0Rm9WbUZzdEhWWWtWVDJ3WC9jY1lGaEx1MVpK?=
 =?utf-8?B?TExaWGN4eFdmb3VVWWdBajZmK1I3ZnpIYitkMUxUOWRnc0F2QnNFUENmZmpL?=
 =?utf-8?B?WEV1SjgzMzN6WSs0ZlQ1YUgrK0Jqakp3b2dpSjQ2WE9tNTZXbGsxNmQ2Ly93?=
 =?utf-8?B?OUxWcVBEVEpiTGMydEV3c2xPeDh2QSs4TFEwTWdSOUVBdEE2RHNEell1aU9U?=
 =?utf-8?B?emNTOXhIWExMOWhiWVBidytDd0FoUUpXLzVjaDNVdkY5SUFhYjJWR0Y5SHFC?=
 =?utf-8?B?VG1QTkd5bEEzMmhDQUZXMEIvdmkvMytpMTJRNVdoajJwMEswRStSRWdmUnBM?=
 =?utf-8?B?M0U1NC9CL0xwdTArb3N3TDNBV01IWmtYUTAxNkFUUmMrWVJjeXdGVjBiUGRI?=
 =?utf-8?B?T0xuL1NEcmNHdkNaMk43V3ZTSG95MFI3M3FLREJJRVFsR0pneXpYU0pVcnpZ?=
 =?utf-8?B?VHpJd0t0VE9mZEoyQ21jRENiUFJjYmMyY2VTYUJUQytBSFNNdVorK1AxaWhT?=
 =?utf-8?B?b1Q3YStsNjQxLzJFRXM0Q0NWbEY2bDlJMTNtVEhJSW9VMDJSMmdDSXRvVjBv?=
 =?utf-8?B?MGRrRGRlWHQ5STJpMW5UakQrUmgxNzNiL0hEZ1lNdEw0QmNoREl5QUZmOStn?=
 =?utf-8?B?dmhuU1htODhFbERDTzZHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFB0Y29EVE0wOFkwdmNTNVBSRTZHNWRIY0JPUGtIV085VWJlbUVwNTZEOVpH?=
 =?utf-8?B?TFlnVTJqNmEwTmVIdFBFYWlGMm9UTUo4MHYrVVB5aE0yaVpMVHplUjZCb1Jl?=
 =?utf-8?B?S0NIb2ZqV2FGamY3dGNLWHVxUW1HeEJYaEVoa3B6UkFSaVllRmhBN21NdUhO?=
 =?utf-8?B?WG5MZlFEMXNhVHhBcjFUL1JLdWNSd3phQmgzRUsrTDlXUGpGOXR6bExFWnBt?=
 =?utf-8?B?b05CUXR3bzE1WnRNR3ljTnlzdEp3SVpQZFhEbm43V3dmSENtbXZSK0YyVTJp?=
 =?utf-8?B?SVk4OGExL2QrYWY5Wm9QeUhQbzVsSjc3emlJbFJVOEVqQk9IOEt1YzRJRTha?=
 =?utf-8?B?MFZGK1Z3dExkZSt2RVlRUWFoUHZadGJxcU14L0sxYlY2MXRmQmllUXE4bHhT?=
 =?utf-8?B?cnpJUTJHa1htMjJJcHJHcDBvK01MY1NmYktzS3g0RThpWnBzWjJjeUNHTllm?=
 =?utf-8?B?OEcrWUxtZzU0ZUFEUSsrckNjMnR2V0ZvRndZaWRoQTJjaEZQOVQ4RStrakll?=
 =?utf-8?B?aGNHQnk5UUJlYWQyTGg0bXV1ODU2b2dDSXRPWWJ0bjVkZWp5NEE3NG1oRnZk?=
 =?utf-8?B?cEh1QkQyZjNnUVJwRitGZXIySzBTbitwUS9hYU9BeXZBejlCL1JpZGg3c2sy?=
 =?utf-8?B?M3JOcFdQbEdiZ2E1alo4MVBtc3U0N1poRVdwcVpsQzAwM2tMRjFoejVIU08r?=
 =?utf-8?B?dmUzT0VMemJQbWxSaUxYODlXck9EM2VaZklqaDU3M0Nva2VyTVluTVpuUTVJ?=
 =?utf-8?B?Z1YxaGlHWnF6T1ZmaXZiK1A2SXVjYkgvYngwT0NoRTRyYnZXQ0gzQ1hoWVZ1?=
 =?utf-8?B?dUhZWkpQTHNUaUtCSmIrWFlaUWNzMkxsMlVqOURoUWJER3NSZitiNzV3a3F0?=
 =?utf-8?B?bk9QTDF1SU50Z1FDOXpkQkpwOVFObHNqZDE3QTYwajlaVGUvMkhnaVZWVkZT?=
 =?utf-8?B?a1o5TGJkV2xvY1BhYTB1QnRZUExZMVRhKzZzb3hvN2pUREpEakRRZDgxNlI2?=
 =?utf-8?B?c2gxdU1xUU5IQnZjOHB1cFhhcklwcUUyWEZzdHg2NHFuMGZSOG00RCsvYTZz?=
 =?utf-8?B?R2dqSlBnT1pDWGUzU2Fma2FSVTlrdHAzRU44RGtFNEdCejlaY25PVU04cTlx?=
 =?utf-8?B?UytidytLaEo3THp6OFkrRnZaTmltOTNXa1AwNytnRmpXWWZUaVY4YmdETzJt?=
 =?utf-8?B?RGhLMXA1dzZuVnhyVngwcGVjc0FXbTB3emRkVktEL3M5dmlOWXFoc2VmazZG?=
 =?utf-8?B?eW93b3pIYjRaenkxODMrMGlXMEJENnBNcmIwMFVVaGFSU0hnR0xSRXY5NEVM?=
 =?utf-8?B?NlJ3Z3N6WnZEOHFKWjBhRVNCamdGMUJXMUNHQzBtbW53dlBJWUNLYlRFQncx?=
 =?utf-8?B?S1NGZUhmczBodlVuUFJrR0FXMDhlUzBiSW9TTks3RnFPWGxFbHVSeWdISUts?=
 =?utf-8?B?MndTVlJxNzhVKytwREVUcnVPU0N6eEE3S0p4S3E0QU9qVjAzdlpLQytETDZx?=
 =?utf-8?B?bUVnWXVQdUlWbncyZXN6S3dyT1htYjZSNjEzb2xZZmZud0lvSjZqY3RJeTNo?=
 =?utf-8?B?cnlrYmpoY0FLRTRQTkRvQ2JNU2VNQTZ3blZMRDA4QmplYU02NC9KaXNxL0Jp?=
 =?utf-8?B?ekMza3JoVXlkellUeFBreWNRZUtndW5HTC9CQ1NiTEgvS0VuVFIrV0JVNWN1?=
 =?utf-8?B?b04xYUlmUUl2b3JncDh6Nkk3SnhiWmRJN0MwdnlFT1RGRy9Wc2F3MTQrdlNi?=
 =?utf-8?B?Q1B6djY1NWRvMnZFK0ZEdFNvY0wvenh0aVVhREZKMDdaa0QyVE5rcWZ6dDR1?=
 =?utf-8?B?Vnp4RW1WZWRBaVNVVmVGM0NnWUZSYUJNVUVmeTFuc2haRytZN3B3N2d0bGlq?=
 =?utf-8?B?aUdHSnZjUzgycmtPT0dHYkxOVkRxTVpZazJrVm91Slk2VHBuSm9CWEdZSk5F?=
 =?utf-8?B?ZjdmOWkwNFRPUHpDWUZ4b2x6UUNDcGNjK0IrckFQb2xoWVpyZTRqSXkzcnFV?=
 =?utf-8?B?K0dRYUk1TkdvTHVJVGJ5dHQzNlZBaU0wWTZJb1lQd0NYUjBFY0ViUnlaM2Uy?=
 =?utf-8?B?b3JwRjEvU1dDTldOYmFPYk1vZUdjTmhXZUZKaHVyMHFFSSswOVVTN2VZeGlU?=
 =?utf-8?Q?7RBsxjW97NIKe9jy9uB619XxK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574d29e7-da88-4fdd-fac1-08dd1abbbfa6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:46:23.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3LtfGN3mj2XqIKKDXV7yX/Wzm29fzSwu3LZq/hyYAsgD9T/mHGoj5H5deLRHl1cTkd4Lvn9Z1WtS/C0sLLG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

On 12/12/24 03:11, Borislav Petkov wrote:
> On Mon, Dec 02, 2024 at 02:50:52PM -0600, Tom Lendacky wrote:
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index 3272a73d3594..31d653db830a 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -100,6 +100,10 @@ struct rmp_segment_desc {
>>   *     a specific portion of memory. There can be up to 512 8-byte entries,
>>   *     one pages worth.
>>   */
>> +#define RST_ENTRY_MAPPED_SIZE(x)	((x) & GENMASK_ULL(19, 0))
>> +#define RST_ENTRY_SEGMENT_BASE(x)	((x) & GENMASK_ULL(51, 20))
>> +
>> +#define RMP_SEGMENT_TABLE_SIZE	SZ_4K
> 
> RST_SIZE as we abbreviate the segment table as RST so far...

Ok.

> 
>>  static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
>>  static unsigned int rst_max_index __ro_after_init = 512;
>>  
>> @@ -109,6 +113,9 @@ static u64 rmp_segment_mask;
>>  #define RST_ENTRY_INDEX(x)	((x) >> rmp_segment_shift)
>>  #define RMP_ENTRY_INDEX(x)	((u64)(PHYS_PFN((x) & rmp_segment_mask)))
>>  
>> +static u64 rmp_cfg;
>> +#define RMP_IS_SEGMENTED(x)	((x) & MSR_AMD64_SEG_RMP_ENABLED)
> 
> Please drop those macros.
> 
> 	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
> 
> is good enough.

Ok.

> 
>>  /* Mask to apply to a PFN to get the first PFN of a 2MB page */
>>  #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
>>  
>> @@ -200,7 +207,49 @@ static void __init __snp_fixup_e820_tables(u64 pa)
>>  void __init snp_fixup_e820_tables(void)
>>  {
>>  	__snp_fixup_e820_tables(probed_rmp_base);
>> -	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
>> +
>> +	if (RMP_IS_SEGMENTED(rmp_cfg)) {
> 
> That whole branch in a helper, pls, with a descriptive name what it does.

Ok.

> 
>> +		u64 pa, *rst, size, mapped_size;
>> +		unsigned int i;
>> +
>> +		pa = probed_rmp_base;
>> +		pa += RMPTABLE_CPU_BOOKKEEPING_SZ;
>> +		pa += RMP_SEGMENT_TABLE_SIZE;
> 
> 		pa = A + B + C
> 		
>> +		__snp_fixup_e820_tables(pa);
>> +
>> +		pa -= RMP_SEGMENT_TABLE_SIZE;
> 
> uff:
> 		pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
> 
> 		__snp_fixup_e820_tables(pa + RMP_SEGMENT_TABLE_SIZE);
> 
> 		rst = early_memremap(pa, RMP_SEGMENT_TABLE_SIZE);

Ok.

> 
>> +		rst = early_memremap(pa, RMP_SEGMENT_TABLE_SIZE);
>> +		if (!rst)
>> +			return;
>> +
>> +		for (i = 0; i < rst_max_index; i++) {
>> +			pa = RST_ENTRY_SEGMENT_BASE(rst[i]);
>> +			mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
>> +			if (!mapped_size)
>> +				continue;
>> +
>> +			__snp_fixup_e820_tables(pa);
>> +
>> +			/*
>> +			 * Mapped size in GB. Mapped size is allowed to exceed
>> +			 * the segment coverage size, but gets reduced to the
>> +			 * segment coverage size.
>> +			 */
>> +			mapped_size <<= 30;
>> +			if (mapped_size > rmp_segment_size)
>> +				mapped_size = rmp_segment_size;
>> +
>> +			/* Calculate the RMP segment size (16 bytes/page mapped) */
>> +			size = PHYS_PFN(mapped_size);
>> +			size <<= 4;
>> +
>> +			__snp_fixup_e820_tables(pa + size);
>> +		}
>> +
>> +		early_memunmap(rst, RMP_SEGMENT_TABLE_SIZE);
>> +	} else {
>> +		__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
>> +	}
>>  }
>>  
>>  static bool __init clear_rmptable_bookkeeping(void)
>> @@ -308,29 +357,17 @@ static bool __init alloc_rmp_segment_table(void)
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
> 
> setup_contiguous_rmptable() and setup_segmented_rmptable() - all natural. :)

Ok.

> 
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
> 
> Lift that check into rmptable_setup(). Or should it be called setup_rmptable()
> too? :)

Ok.

> 
>>  
>>  	rmp_end = probed_rmp_base + probed_rmp_size - 1;
>>  
>>  	/*
>> -	 * Calculate the amount the memory that must be reserved by the BIOS to
>> +	 * Calculate the amount of memory that must be reserved by the BIOS to
>>  	 * address the whole RAM, including the bookkeeping area. The RMP itself
>>  	 * must also be covered.
>>  	 */
>> @@ -342,11 +379,11 @@ static int __init snp_rmptable_init(void)
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
>> @@ -354,9 +391,127 @@ static int __init snp_rmptable_init(void)
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
> 
> Kinda obvious, right?
> 
> I mean, a variable called "rst_pa" should already explain what it is...

Sure.

> 
>> +	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
>> +	rst = memremap(rst_pa, RMP_SEGMENT_TABLE_SIZE, MEMREMAP_WB);
>> +	if (!rst) {
>> +		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
>> +		goto e_free;
>> +	}
>> +
>> +	/* Get the address for the end of system RAM */
>> +	ram_pa_max = max_pfn << PAGE_SHIFT;
> 
> Ditto.
> 
>> +
>> +	/* Process each RMP segment */
> 
> Ditto.
> 
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
>> +		/*
>> +		 * Mapped size in GB. Mapped size is allowed to exceed the
>> +		 * segment coverage size, but gets reduced to the segment
>> +		 * coverage size.
>> +		 */
>> +		mapped_size <<= 30;
>> +		if (mapped_size > rmp_segment_size) {
>> +			pr_info("RMP segment %u mapped size (0x%llx) reduced to 0x%llx\n",
>> +				i, mapped_size, rmp_segment_size);
>> +			mapped_size = rmp_segment_size;
>> +		}
>> +
>> +		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
>> +
>> +		/* Calculate the RMP segment size (16 bytes/page mapped) */
>> +		rmp_size = PHYS_PFN(mapped_size);
>> +		rmp_size <<= 4;
> 
> 		rmp_size = PHYS_PFN(mapped_size) << 4;

Ok.

> 
>> +
>> +		pa = (u64)i << rmp_segment_shift;
>> +
>> +		/*
>> +		 * Some segments may be for MMIO mapped above system RAM. These
>> +		 * segments are used for Trusted I/O.
>> +		 */
>> +		if (pa < ram_pa_max)
>> +			ram_pa_end = pa + mapped_size;
>> +
>> +		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa))
>> +			goto e_unmap;
>> +
>> +		pr_info("RMP segment %u physical address [%#llx - %#llx] covering [%#llx - %#llx]\n",
>> +			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa + mapped_size - 1);
>> +	}
>> +
>> +	if (ram_pa_max > ram_pa_end) {
>> +		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
>> +		       ram_pa_max, ram_pa_end);
>> +		goto e_unmap;
>> +	}
>> +
>> +	/* Adjust the maximum index based on the found segments */
>> +	rst_max_index = max_index + 1;
>> +
>> +	memunmap(rst);
>> +
>> +	return true;
>> +
>> +e_unmap:
>> +	memunmap(rst);
>> +
>> +e_free:
>> +	free_rmp_segment_table();
>> +
>> +	return false;
>> +}
>> +
>> +static bool __init rmptable_setup(void)
>> +{
>> +	return RMP_IS_SEGMENTED(rmp_cfg) ? segmented_rmptable_setup()
>> +					 : contiguous_rmptable_setup();
> 
> How is that more readable than the most simple:
> 
> 	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED)
> 		return setup_segmented_rmptable();
> 	else
> 		return setup_contiguous_rmptable();
> 
> ?

I find it more readable :)

But, ok, I'll switch to the if statement, especially since you want the
probed_size check moved here and that only applies to the contiguous RMP
table.

> 
>> +}
>> +
>> +/*
>> + * Do the necessary preparations which are verified by the firmware as
>> + * described in the SNP_INIT_EX firmware command description in the SNP
>> + * firmware ABI spec.
>> + */
>> +static int __init snp_rmptable_init(void)
>> +{
>> +	unsigned int i;
>> +	u64 val;
>> +
>> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>> +		return 0;
>> +
>> +	if (!amd_iommu_snp_en)
>> +		goto nosnp;
>> +
>> +	if (!rmptable_setup())
>> +		goto nosnp;
>> +
>>  	/*
>>  	 * Check if SEV-SNP is already enabled, this can happen in case of
>>  	 * kexec boot.
>> @@ -420,7 +575,7 @@ static void set_rmp_segment_info(unsigned int segment_shift)
>>  
>>  #define RMP_ADDR_MASK GENMASK_ULL(51, 13)
>>  
>> -bool snp_probe_rmptable_info(void)
>> +static bool probe_contiguous_rmptable_info(void)
>>  {
>>  	u64 rmp_sz, rmp_base, rmp_end;
>>  
>> @@ -453,6 +608,60 @@ bool snp_probe_rmptable_info(void)
>>  	return true;
>>  }
>>  
>> +static bool probe_segmented_rmptable_info(void)
>> +{
>> +	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
>> +	u64 rmp_base, rmp_end;
>> +
>> +	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
>> +	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
>> +
>> +	if (!(rmp_base & RMP_ADDR_MASK)) {
>> +		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
>> +		return false;
>> +	}
> 
> Do them in the right order:
> 
> 	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
> 	if (!(rmp_base & RMP_ADDR_MASK)) {
> 		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
> 		return false;
> 	}
> 
> 	rdmsrl(MSR_AMD64_RMP_END, rmp_end);

Just matching the way it's done in the contiguous table probe, but I can
redo.

> 
> 
>> +	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
>> +		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");
> 
> Meaning?
> 
> Fatal error? Doesn't look like it. Sanity-check for BIOS testers?

BIOS shouldn't be setting anything as this MSR is ignored when segmented
RMP is enabled, so, yeah, just bringing attention to it.

> 
>> +
>> +	/* Obtain the min and max supported RMP segment size */
>> +	eax = cpuid_eax(0x80000025);
>> +	segment_shift_min = eax & GENMASK(5, 0);
>> +	segment_shift_max = (eax & GENMASK(11, 6)) >> 6;
>> +
>> +	/* Verify the segment size is within the supported limits */
>> +	segment_shift = MSR_AMD64_RMP_SEGMENT_SHIFT(rmp_cfg);
>> +	if (segment_shift > segment_shift_max || segment_shift < segment_shift_min) {
>> +		pr_err("RMP segment size (%u) is not within advertised bounds (min=%u, max=%u)\n",
>> +		       segment_shift, segment_shift_min, segment_shift_max);
>> +		return false;
>> +	}
>> +
>> +	/* Override the max supported RST index if a hardware limit exists */
>> +	ebx = cpuid_ebx(0x80000025);
>> +	if (ebx & BIT(10))
>> +		rst_max_index = ebx & GENMASK(9, 0);
>> +
>> +	set_rmp_segment_info(segment_shift);
>> +
>> +	probed_rmp_base = rmp_base;
>> +	probed_rmp_size = 0;
>> +
>> +	pr_info("Segmented RMP base table physical range [0x%016llx - 0x%016llx]\n",
>> +		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);
>> +
>> +	return true;
>> +}
>> +
>> +bool snp_probe_rmptable_info(void)
>> +{
>> +	if (cpu_feature_enabled(X86_FEATURE_SEGMENTED_RMP))
>> +		rdmsrl(MSR_AMD64_RMP_CFG, rmp_cfg);
>> +
>> +	return RMP_IS_SEGMENTED(rmp_cfg) ? probe_segmented_rmptable_info()
>> +					 : probe_contiguous_rmptable_info();
> 
> As above.

Ok.

Thanks,
Tom

> 
> Thx.
> 

