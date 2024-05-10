Return-Path: <linux-kernel+bounces-175170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AA8C1BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33771F21D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C32E17BB4;
	Fri, 10 May 2024 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D2B9fD8p"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FFE552;
	Fri, 10 May 2024 00:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300648; cv=fail; b=mhqRho402QwWWvS9WRGDV+UqdPX140k2joZwyYkCMIpJd6wwBaqGDJnaNPTOqiqs6ct1y3eXnKsZxNQvOb++X8CBlNG7NiCjrj4TdWAIMJOQKfsyOa75sphUgGn+JBaIDadf2bt1hzN857ZQebj8qy/jM1atPstd81m3D7F8dSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300648; c=relaxed/simple;
	bh=tvaVge473bLdY8EV15obSw8Y4DuXrDVoJaQsc28AjU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n6kW9jJ7/kFRRVIJMdX4bLfZVdlTvoi7hnoix9gUIb6we+rqtiC+jECQivJMe2HqH84NLil38ZXOxDqQHIjgGupwEVeMm4zK8V7cogB4y5Ud88VYcP/WzH6JfgmJ/zBIXt8qkOIM4p7vBHZFMXnst9kU/v1JYXHYr4oEWCVGsQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D2B9fD8p; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc02DaML6gjIePhcHsBHaV1z7JDAjFX1DnJTl3u2scrvd3qGo+Zlt6l35R1tB+CGZhfOPSlnU6u6aQ94ScwOSduy1jugziYJKwRqMqarnNFZO1czTZBeQt1PTFHvDB2GFgfWPUjZZB/SGaAZz9JBD82xiQ81aXcF0EeOMtKiBuzgwTSBpZxBJJ59edO85iQF3FvAbFHFdtrCZN4W6CntDOjg1T3VQ/zdlDMMjT2xkqGFClBgPGwB97OxVRdmuhabdsPo3GbqPQpfdJk51vbCUNF4A36Ve+aoDQME4lGojhTiFevjrJYcmihCg6MkwSzY2I3SSpsNUCfAyugXVje6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3HzHLyo/2noTv3XfXbxJxWJGaERB9O8gF0WtQrkt/k=;
 b=XkbupHsdcLghdgrm8S20FSsU05AO10TXtwhO5gopm4mxkzx9wzosk4u8CCsiDYwbH4zr9wzls/4tFDUAZ+YcIqr5DBnyYlJ/5ZUUsvwUpTGYLi4tncCPSpIsJaXEFS05/gTu94gzX1kkOU58q7TyoK60vH6nZouMWlFgLv0ZTa9w5k9Y+ocHKYym1IkPg6o4lm3M7XydJrnBdW4JO0gRF+jHogPRqw6sJQ/I+4XwYAArHwDZO4o1l9avuKvliGckPLvCNzMfwgAt5jW7bJsdrvlM8JYA4DNrvINdqkjldnSWYqucQ6lj14YikKlqZ0asewpSdg+aGyLfly6gOqFl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3HzHLyo/2noTv3XfXbxJxWJGaERB9O8gF0WtQrkt/k=;
 b=D2B9fD8pELGQaizkXqKCE+eNqT1ft+xVUUMc4ZgEvENQFe+fwHQIdXpcsdl5uqPabfk7lZygVd9C15W6Gv/VhPPLsw3TOn2HqZgUMBggKj4KgU55NO4Sp5gr/M3hk7d/pdeAQzSNAYhh1gqG4zO9N629RXoWz7f2xLBDBiodcY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Fri, 10 May
 2024 00:24:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 00:24:04 +0000
Message-ID: <ed56e9bd-383e-eba8-874c-e4f0a0a5b9d8@amd.com>
Date: Thu, 9 May 2024 19:23:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 04/17] x86/resctrl: Introduce
 resctrl_file_fflags_init
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <363c14eeeac99eb0453ac3429f9e7bd446b2acdb.1711674410.git.babu.moger@amd.com>
 <55fa3189-b5da-494f-8ec2-7f0ab4b8d33e@intel.com>
 <119fbe0f-9688-4382-9263-220f69caa718@amd.com>
 <3f4d2c09-3158-477a-ba9b-f8f809d1999b@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <3f4d2c09-3158-477a-ba9b-f8f809d1999b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0185.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 1321658a-781e-4d15-4d86-08dc70877f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkR3WUJkZDhmeGJyNW45NkVUSGxNcVZWNzNnWUVmKzNuL2YweWx3NGRqN0tL?=
 =?utf-8?B?UDVJcEtNc3FwWnhLUklhaVh0b1JYLzNZQjJiWXJreHF2TVZDVHpHOWlWdy9Q?=
 =?utf-8?B?bXV5RGdOVGFEUGJWYU1YRExVdG9wS2NDTzJaVDdqczVLR09CWiszWTlHRi9M?=
 =?utf-8?B?dzFnUGUxNG5kd3JzVVIzaERzQXlVeTRTWjRDR3NCVkZYVm12dTE5OGhJbFYy?=
 =?utf-8?B?SC9rVm1zdGhCS1B2blRPc3NPQTBLRmN3WXB0bVREK3FGWnhVeDB1b0VMOG1H?=
 =?utf-8?B?K2dkZnZFZFY1SWdWN2NqcERIQnVob2VieEtiM0kxR0FJYVo4UnQwOEJQQlcw?=
 =?utf-8?B?UlBkb3o3Z3Z2Tkl0RjgybU5PdzV5L1BvbkdQeHNHeEtodTdMdERJeWhtSGt1?=
 =?utf-8?B?ZWdrR25BK1MwczZ3V2NxbE9iQ0ZKS04ya3ZaSXcyZzZobmEwS3lyaTlrQlBo?=
 =?utf-8?B?WUdFSDJCMG1FUmJiVmlaS3dScmNpRnVLdGJsdTRSUnIvMnJxS0o4bHZQdWRS?=
 =?utf-8?B?eHkvSkxrS1BoSFgway8rYnZuQks2V1AzcmdNRkJTQk9mTEluZmlsUm5Uc0NM?=
 =?utf-8?B?b09XTU5KdDh2YkRJL2lDemx4UG1NSkhtV1lheTlZSDhRYlZXY0h2S242ella?=
 =?utf-8?B?U0dKcUEyMWVzVGRmTEt6MGJYa09pcWxHMUxCbUpwQmNxNXRWQS9aVzZDbW1F?=
 =?utf-8?B?eUkzWm9tSFQ1VnhKTy9kOHFhOUdzQUdWOEhNSkdkMHU2VEEyQnRjTkZrd1VS?=
 =?utf-8?B?RHdjalhKU05QcnRoN3VtNXlielB2a1lnUVhTaFhXdzhLV3Ura1pwaTVrMlJF?=
 =?utf-8?B?NDdHZ0YyZ21sRnA5bTRkKzJqWWx5VUxIcmFtVzdldkNuSTdEbVpvWjFVNi9I?=
 =?utf-8?B?ZVJLY1dUM0RVbjdLQmcxSWNHdmZOTkdRSDZLbEl0OE1DWk1BRFRiaXU2WHRO?=
 =?utf-8?B?dVFFeTVKTmhmNWxMaGViK1Y0UHB4UC9JM1hTR1FwYzRJa0pVZEY2L2xQLzJ4?=
 =?utf-8?B?L2toNzBJRWFIa2NLa0Q1QytGUDNoeU1KLzJqZ0JuWXJaazFNTnAzdEUreUo4?=
 =?utf-8?B?elIwOHVYZlNBRjl0dlFYZzhqWExqZG9HM0R4RDM4OGNOOXR0U3lYK0liWmo5?=
 =?utf-8?B?NlNweGNCcW9BaE1HNUdsbmhFWUsvTE5pMVZZdnhIaUduTnpQM2xSUUZmbVNP?=
 =?utf-8?B?bkVEVjVIZTNnaml5bTNYTFJlM0RtaE9jVHlZWVdScWJRS28rWkwxOE5lQldF?=
 =?utf-8?B?Q0tic2ZZUnpYeFVxQnpkbXNaVUVlZEZqczZUbWNWc2hyaWd0a3RlUWJObDJ6?=
 =?utf-8?B?VnNLUkFtN2FBaFBEQkZJem4vMG8yQVhha3hjcmVVaEc5NlFlZXdkS3dCUjhp?=
 =?utf-8?B?OElicWNPL3V2ZFB6NVQ3YW9LSUt6c3c3RmgweGhpVGRkRXVHV0FTN2VHbGdV?=
 =?utf-8?B?MFo4aHZsc2JWQXJaS3Y0OFdZZHRPUVk3V2Nwb0U2eWJwMVBzc0tkTzdFYmFP?=
 =?utf-8?B?aDNBN3JHcHVYcEx0OGZJb2Jxay92bFdMcDV4RHRWK2lZa29vMmVxbDAwbXlk?=
 =?utf-8?B?UTZRTTRQMm5BQW5odndYUTdYMmFWVDZoT3dGMy9UOW4xZTFQa0U1bFNPMjVa?=
 =?utf-8?B?YkhGT1RlREdCbUhmNysramw1ZERGMzE4cE5MU2pFaThCOHRJbjJuWWpMSjcw?=
 =?utf-8?B?NERxTXpvZTFXMkc2QXlwSHZoeWZ1ZndVNFlKaDRwVklkQ3VubXBzMjZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEZ2VFFKRXBWcDMybVFrMUVFYzVWRUl1WW14d2RleThZUktYQ29YOEJ5bWwx?=
 =?utf-8?B?U2w1Q3E0cjE3R2g4Yk1aTk1MOE9VbHFvL2xwM0dhbVpNZTNtTDQvM25hZXVR?=
 =?utf-8?B?UWNGaUl3NXA2d282MkxPN0VYSlR6WVFHYlRXYkowZFNKc0p4L3V3Zmh6NERs?=
 =?utf-8?B?a0xOWk11aFN1aVdLU1d1K3ZyUmRINnFyU0RSVnlXWmRzSmh2ZHJCODZFZ3pu?=
 =?utf-8?B?NTlwTDZoQWZxK2F4Tm1kMDRzRHBYSEE5bnU0MDR3VG9TM0dOVjMxbjcvMUh2?=
 =?utf-8?B?eWVBZGdwUFZBSjNwYStJTmtFR25QR1dFNHNRcGxJdGhvWHJnK1NaQU1RN0FE?=
 =?utf-8?B?RndTUk40Y29qQmEzdVp0dVNIT3VCR3Q3di9IY2RQYW9jY1R3bW5MWVJkeFdE?=
 =?utf-8?B?MEl3RUUzTjRMVnJyb2FRaDd3RXlBbGFMRDlzMmc3V2FRQlFvYjlURGI5clM0?=
 =?utf-8?B?Tnhkamx6NDJuYzdTTExWaS9VTGlXWERsczdiZGlaRjAveFhPMDJHS0syS0Nv?=
 =?utf-8?B?NzFxMVdGcTA3eG5kcDl3Qlh2YWJMQjVySW5hM0E3TXZ6NjdIdEtYWnA4TEJY?=
 =?utf-8?B?Wnl1WVByZWNBTVA4UkM0R1Rwc1NBRlRZMDV1cTVJVzZXV2R6WnNmdG12eXYv?=
 =?utf-8?B?RjlVTFRqdG9jTDNIVFJ0RjE0RTM1QVFZNjJ4a0dycmZSc2NQWWRnS1RlRlZr?=
 =?utf-8?B?cG5lYUozRGJ6dVExaGhVV2YwNG55VUt5NXBCOEoxMklyaE4xakVMYml3U3da?=
 =?utf-8?B?d0VoYUR1aC9ZSm1GbTdsdktQTEtjSEdrbWNzd21pc3hzOXc3UHhUZG1RMnQz?=
 =?utf-8?B?MldEbERnRDUzZlJJN2dGMTYwdjJaZkQ0TnBMWDZZcnJNSmkvNEhTdXpKMHRB?=
 =?utf-8?B?ZEltRUs4akJSdERHUmtDZjh3YVN4SEJ2ZEVabWtrNHRQVGdkYzl0dEZxLzF0?=
 =?utf-8?B?a3BidW1HT3ZVN2h5MDJxWHlLNHFoWFMzbW9hbEdhdE0rQVVGM3c0UVA5QTBJ?=
 =?utf-8?B?UDNhKzdtT0RJb2N2WTJySmFBQ0ZoQXpHczcxWW1IZjQ4amY2R1FoZzQxajhD?=
 =?utf-8?B?ZW1hTmtKNzBDeFRrbWR0bVdEVU10WWtHODFIYWdPaDdUUHBpUTJ3WUhjZEhO?=
 =?utf-8?B?UHZlVWtpdEIzNlRCejZsK0lyczc2U3RzLzVJaDVUREJGbUJta0R5a1lQR2lG?=
 =?utf-8?B?b00wWXU1bFpzb2dYRm9jR0Z1bVBlL3RocFVFK1JyNXovaWFjYWtBa0U2WXQ0?=
 =?utf-8?B?OFVFdVF1SDhBbGp6bGl4SUs0TU8wajhvUDIzRVhwUTlaa2JlRnZ2VWFIZUV5?=
 =?utf-8?B?YnZKWHVxTlBuL2dEVjc3OU95Q3BCeXpHVG04SGdrVVF6T3dpcUtaLzFlVHhG?=
 =?utf-8?B?Z3FVMkF0UE1vMDBXVWNWY0djN0JXaVFlSTdCdmtibnFsWGhWZlBTRGl6MFJy?=
 =?utf-8?B?ejlQRTV6OStidENYakNycmZjMHI4RHg1UjZySXBwNWhYejBqK2dqM2JwajAx?=
 =?utf-8?B?aFU5bFFDcU1SZjBaMm9RVlNSOS9YWC8wdmMrd3dHdEkyTFJQSWd4b1hUWFQ4?=
 =?utf-8?B?K05HNnRiYlpDdWkzQ2F3USt1cnlXMHVLK3dpUCszd1poc0NTVEdiUXpnN3ls?=
 =?utf-8?B?SUtYa1pBNHlLd1NGa0d3dzZVb2FScDBRbTRzOU9lbks0dzBsdmtkMVA5YnRL?=
 =?utf-8?B?YlpvOVdCYjY3OUNTdktoU2VyVnZhRTl4T0JHV25KQUhpUVpZeTNlZVN2Smpt?=
 =?utf-8?B?R2lCUm91Y3oxOVZuVW5LMjh3S08yVkV6eklXSFozbTlKckJlUk1xdHNjWTZV?=
 =?utf-8?B?U29ZM1drNEo5RlV3QTVWU1B0Wmg2UHVxVXFVaXJ3MjdPZlE3RTdBYUZoVGdi?=
 =?utf-8?B?VFVGbCs2aTZ3VkZ3NHljOHlLcmtha0VSRTd3Tm9EVFY3Z0VsaVBsUEo5cldS?=
 =?utf-8?B?cXFhcUpBYkMybHhjRll1MUxUODI0b3AveDZ4YWdCcTdKaEpoNmNYcUY0eFJD?=
 =?utf-8?B?ejQ3V09DdHR6TE1jVXV2T2tBeklONHc1T0hiSFV6b2FRS3gzMW5LeThVS3M4?=
 =?utf-8?B?R0VzamE4OTdWR0l5Tm10UWxVWW14NHlvUG1nQ1BwN0xHS2FqVnZCblA3REJp?=
 =?utf-8?Q?pBog6rzesxpkH3/JVHRSycvGb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1321658a-781e-4d15-4d86-08dc70877f7d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 00:24:04.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMuhhrRMNJbSdTTjQFq7lUgd8O7ppu5lBAeAwMymMQ4dkGHMEiGeptyN3VacBbcl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134

Hi Reinette,

On 5/7/2024 3:27 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/6/2024 1:23 PM, Moger, Babu wrote:
>> On 5/3/24 18:26, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> In shortlog, please use () to indicate function:
>>> resctrl_file_fflags_init().
>>>
>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>> Consolidate multiple fflags initialization into one function.
>>>>
>>>> Remove thread_throttle_mode_init, mbm_config_rftype_init and
>>>> consolidate them into resctrl_file_fflags_init.
>>>
>>> This changelog has no context and only describes what the code does,
>>> which can be learned from reading the patch. Could you please
>>> update changelog with context and motivation for this change?
>> How about this?
>>
>> Consolidate multiple fflags initialization into one function.
>>
>> The functions thread_throttle_mode_init() and mbm_config_rftype_init()
>> both initialize fflags for resctrl files. This can be simplified into one
>> function passing the file name and flags to be initialized. It also helps
>> code simplification of new flags initialized for ABMC feature.
> 
> I am not sure what you intend here. Is this the entire intended changelog?
> I expected it to reflect x86 requirements as per
> Documentation/process/maintainer-tip.rst. Under "Changelog":
> 
> "It's also useful to structure the changelog into several paragraphs and not
> lump everything together into a single one. A good structure is to explain
> the context, the problem and the solution in separate paragraphs and this
> order."

I will try to elaborate this in next version.
Thanks
- Babu Moger

