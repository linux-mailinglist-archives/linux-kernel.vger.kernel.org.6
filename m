Return-Path: <linux-kernel+bounces-294569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF40958F60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5A2B21BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D11C4630;
	Tue, 20 Aug 2024 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tgzF6rah"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B0125D5;
	Tue, 20 Aug 2024 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724187372; cv=fail; b=btyMeG6w1BvbnHJ1pq55g3r1IGWx+nXD2wxyiXf2drr4axSUeScVNT2zxYEgGtG1F7N1t1muO9v+vZ6h939rl3mPOWjw3KXg9Fu0J/GCjCFfQpxDBIgYpvAmh4fv34HvQLACRiJ4JhO9Oe3HZ+yay2A09UkSHNtM9MtzOw175NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724187372; c=relaxed/simple;
	bh=pDeaDulih2E0XdKQUDOfv2y5JIPQnhnxyQ9ifQg+OIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2SbFNHhF85xlHQhEqKHRYIpSyAz5QuMhkqaDyIZpDtLah12eIfwMi32UOcuGyszSb4gpqGS9B8n9U+LCKdp047wVKuPyaPoOYitOrmC0qXVA/2l+6gmc7RRQKnRhSwfZ9OG+8V+Tct7+o61DEwXomoiAAfXwt60TAsr6xDm9uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tgzF6rah; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJf8DSk+NnH8nKKaeRAkKlqv3wnFw/Vvp6gl3hFBhRgXgHoKRL4qyGrnzLspgT3umEIrvMY4NEprUspWxvzJ/Vy4MBCpL/DsFsIwsL/7J8l4W/BKgeBcDb3ZX4x9q4hnLXn4qCgLmxEaSTepjsm5BVJqEIr/R9NaEgaMQd9O1THRLRLksZDRX4dejvM47dCghZJQo9PJjHk69BKEUWBIwZHk3w0r701OO53FaDwvggyXi4e3soCEqlZ7q7xHj41jI1TykaoX1de5zY+bH5itsjzqyk8GSv0RxR94VBlV6+m/eucaCb9pj5PcAJLoLdgHJb8vywF34tHbaPc3MYObiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHFFaibwti7rYCHKwcdkOw31b8FaIgfghfC9vCOT9XM=;
 b=h2qy317fJy+Z1UAEJDM7nACehLNb/E7IC1qT428ALMvRrPKQOxt41/SlohsbAgmPTQjMJu3ME9UYptW03nhS3LUr2zNKqh/ogslyjab700TAf+k+VCwGvvoL/BZQmgUqusMa2Sr9RIgkr8Sl0lorKgRIgVU3ajruMzGow5Q/z8vznXpg8jhJIXk9fqyVsNFppQXPwVC0s4+ByrMhZmycznqPOo7C78ylaCz/cm4AFaywZKQGJhkIXFEAwXBagchMOGlzLeNqSJ9CYaRPQSGwxVsJbctgtDupw08+8yGQj1UbtwzjhJNb3wpegp5COwzQEuQNjuidUHtiFRWxOQ4sKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHFFaibwti7rYCHKwcdkOw31b8FaIgfghfC9vCOT9XM=;
 b=tgzF6rahC8bPo6K93WKYRNx3veoAn/gGwUWxspwklBxztLH5pjXHaO5TTOIC4SK7OVQJApb//qBn72fTbdlRdqvw6LY3LPfhe2d7eiPf6yAsa+RieEd+uCguld9io9SYvcqldwlZ8SZhaGQY8raDPz5yOQEihOjt5kQHQd0U25w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 20:56:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 20:56:06 +0000
Message-ID: <49ee6ebe-96a3-4e3b-bb60-090be2e9e17b@amd.com>
Date: Tue, 20 Aug 2024 15:56:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 13/22] x86/resctrl: Add data structures and definitions
 for ABMC assignment
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <337d3ed1eebc662dbc7e536aba49987c2396972e.1722981659.git.babu.moger@amd.com>
 <498fead6-8b03-4a68-8fb5-15c239e9b63e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <498fead6-8b03-4a68-8fb5-15c239e9b63e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: ffea56a0-b1db-4403-2b6f-08dcc15a82c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2xKZWRWNGxkUGNTbXJEWmc4QkxqYldtTFhrZDBWM2VKTjVRQ2c2VGhpNWVY?=
 =?utf-8?B?VXJRR3p3ZzNyaU81dzhLa1ZsSW5zQ0FLczFRMzR2TXNBL1pRQkZhc2syTE5N?=
 =?utf-8?B?K3MxNzJHTHlWYWt4NTUxWisxY3VwR2U0MmZ6NGxRT3ViQVVWdVhQRTVGTkh2?=
 =?utf-8?B?emg4a1BHMDBQcWFTWkxqdHN5QVJEdlBXNHN3YjhHZmlERjRDTk1sdS80dk1x?=
 =?utf-8?B?WlFPUlNnQ1pxWEQwanMxaDdvVDFVMG16WVRNY2l4QlJ1MFN4T2dpODRYL2Zz?=
 =?utf-8?B?YmkrTEVzZGlTRU4vN1YvNVVIZjhZcXpMSEZJY0liMjNvNWZPZklVVlNUdEJ0?=
 =?utf-8?B?ZmJ3NUsrTFlMVDlDYUVtMmlicEVGN3FCUVJsT1E0RlVIQ2s3SUt5QVNmVTQr?=
 =?utf-8?B?TXNBZ3VDb2JXeElwSno5WmZsSDY1MGdORnhlb3EwNlZraTVRRWcvNHMzWlNP?=
 =?utf-8?B?Wko1ZCtaUUdaVFZ2Z1h4Q0tvSHR5MklIWml6SVY1ZnZFNzMreTNFQmhsTU15?=
 =?utf-8?B?dWhJTk5NNnhXaEpFMXhIU0grbnZJajlZdGk0SE1nQ3BaWFJaOVNPdUFvTitN?=
 =?utf-8?B?bndOaU5Ca3lRT3VENkJibkVCOW5hVEJ4ZU9aOFM1V0JDL3ZLWTlSWkFEbHJD?=
 =?utf-8?B?aE1SakZYZXJIZzFZUTJJWCtkNGxsYzBENVJuakZJT2lxbHBPb0dyOE5Gczkw?=
 =?utf-8?B?SkFqcXFkc2hxMndzSlpWaytmZ2xKUEIrZkRPRU0wRWg4WjJzTmhvQ0tvNHVK?=
 =?utf-8?B?Q0toSExja3M4bHZ3aU9nRHZFRUkwdUV0eVp4Wkh4QUlZQTdmYzJ6MDFZd1hs?=
 =?utf-8?B?T2poTmRQTlFJWS9QcWJVdkFuWEhTdWIvOHIxbTlUcm0vc0tiVFRXVGFsdzJH?=
 =?utf-8?B?VTg4WFVSM3E4ay9KM21sN2prWDhtRGhsR3Y5OHE1K1A0eUV6UTQ3NHo0bVVo?=
 =?utf-8?B?ZE9IZ2Rsa0l6b0dVZnpMekFCQjVqcTZ2RVFmTWhxOVVJOU9jOTVTUGxJK09I?=
 =?utf-8?B?YllFNitEajJHV3kxaU1JZ3Y4U0tOZlJySnJSb0ZDb3MvSmhxR2NuNWdHSVB3?=
 =?utf-8?B?OFFYVUxubHg1d2s3QVczYWU1RThERUpaTzN6N0xsS3Nnc1NMUkV3ZlJVU2R3?=
 =?utf-8?B?cCsrVWg1MHBwUDRVK0hLMnU4WFpzQ2l1OHdCeVNtYWltdHRLOXlQQ0Z6dS9U?=
 =?utf-8?B?bDh3WmMzd1NiOHdhSC8xdkVyVU52cXUvdEoyNmgyclgyM3pNWEE4WEx1UXJM?=
 =?utf-8?B?d1ZVRG5tek9OWG0rT0pRZkFMelZvRzI0bGxiRi8rMDhxMzBWY3RFWUdsQ1F0?=
 =?utf-8?B?MXJGSW5UREh3eUtzeEQ4eHJUWGpnY00xMmp6WE9ibEh6UGRXYVBaNC92K3VH?=
 =?utf-8?B?NWdRT2xEcXhGNVhodXcxcWRwRFJhc05FaytIVGpyV2xzRnFIWHFXdG1pRlNv?=
 =?utf-8?B?YktBS0FIUllZSGxsakgrYUtWM2xnZlIrTU40THo1TnpnNmxZSURqNHBQNmgy?=
 =?utf-8?B?bnJZV1lYeFYwOVJKREM2bGlUNTZqbnQyeTlKUG5zNys1eXNoZWFMYWE3SktC?=
 =?utf-8?B?TnQzeEk3WE5VWjVDWW5zazJGbWpvK0FwRHJQeGpSVFY1amFtVDdoVTBpdkZ4?=
 =?utf-8?B?cWEvN2p0NG55SVFQT0tBMVh3L3hYTnZZUlFJNTRnOTQ2S2xzL0hPLzhTYld3?=
 =?utf-8?B?czUxZ2N1OHpEK2FyOWZ4S2lFMVEzdzZGdlJ4eGNxc3IyV2grNjAzMmV3QTha?=
 =?utf-8?B?R0p5MFFsalpiUFZadzhGUW9FUUoyMTdBVmtmWFZ1UmFUM3ZNNlE5aTRMZmNP?=
 =?utf-8?Q?UFJ2M7AaJx+cWTIAmRVV2W2oVxN4jYh+4DLuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dytRU0pMakNJNmRSVDVNM0dObmR1UXJrdTdqZzEvakQ0QmdRMU9rdGhOTU1Z?=
 =?utf-8?B?L0JVR0JxWkQ3TVRBNkE1anVNVy9UTFc1Y0xiR3djM0grUlF4U3lteVBmV0ho?=
 =?utf-8?B?eXRDbHZQR21JUjFoMWVaaDR5cUxrcGI5Z3BwNGJYZmdWMVpza3RRMEprdThz?=
 =?utf-8?B?K3dXM3ZSZDcxY0xzWmtqZW9DSG1GVjcyMG5TUGZXZVBlQWpWZjFXdi9QTWw3?=
 =?utf-8?B?bEwvdHczNzBQQ1NidWV2emhkeitRZWVFY1Mrbm1RL1RkTHl0QkxSbmxzYUZS?=
 =?utf-8?B?MXI2TTd3VHo0MmNNcW9sVmk2NVRGWWlmVnRVK3IrQzB2VjZqSlpGZk1ZMkV1?=
 =?utf-8?B?THZPdVRFV2MvdzJwQjVZUWgrSzZUV1FnZ2lQc2gxMFdrdGNNZHpFWmwrSFhx?=
 =?utf-8?B?OXdrb05qU25nbk9JSEVYeG0veHF0MzJpRHBqbmxZZGR6NVRwbTFNemdyY0pp?=
 =?utf-8?B?T3BJTlZiN0pJQXp0ZytYZkVwc3VjdTJLK3BGVWNKV2IrS0JOaEZya3B6SU1L?=
 =?utf-8?B?SVhlMFFQOUtJM3Z1Z1pSYytFbkVUMFRWMldma3M5TlAyYWp4VTZ1eHZOQ1lG?=
 =?utf-8?B?aTZKeEgreFN0amdOTFV5Z2x1L3RMNEhWNG40em9DZ3NLRm9QTUhQNkhUOThH?=
 =?utf-8?B?NlRsMXRyMG52cGx5R2xFbWZFUVVIYnJxMUp3bmlsaFVyMTg2cUVDNjY0bGZw?=
 =?utf-8?B?MFpHbHhsdlFGbExlTk9nazRPeWNZaWsxMWFTV0tsS05PbnFWTXpZVVJFaFUr?=
 =?utf-8?B?ZVNNUjVUWllDaVBBUys3MGFQenUvWlQ3VXFtUi9QUlA2OEZYMlgrbG9UOVVh?=
 =?utf-8?B?Q01zNkk4VHgxb1FsbFA3ajJIdkgrQkkzYjhEN1ZiUFBYYmJkeGVPR1h0UTNl?=
 =?utf-8?B?RmIwT0NCa2V6SEtxZStUV2p6TEhzM1h3c1QvbkJvREVTVWhYU1pGUURMeVJX?=
 =?utf-8?B?MWNsdDYvRS9zZS9lRkIvSzZzWGxLb3EvZTVTMGpWWldPMkJXZm5SbldSaE82?=
 =?utf-8?B?bTZGZEMwWERHd1h3bVJ2cUNhMDZkc2JOcTdsdmJCRmN3WEJBTVVkS1A4SWxa?=
 =?utf-8?B?YVdueUdtMGtZclNka0lZQ3JIeE53QUNQMmJWNitBRFNGTTJzeGVRdEtwalcx?=
 =?utf-8?B?cktwczlEZW1OajhoL1pTcHdaU0tOZUhFL1FwR3lVbUNNZi9lWld4NmNCZ3V2?=
 =?utf-8?B?cnNNeHUyU1RlMzZ3a2VYZXpORUJPUC9pT2FRYTE4bzViTmpkMVBWeDVKSVpo?=
 =?utf-8?B?RVZXWnFWNkgxZmVlYktFRW1TOU9iUmJiaHB5RGROdE9iMWg4ZzhnZW9NT1l0?=
 =?utf-8?B?aVZKWUl0WDlqdXNtdFpkMHZyY3U4TWtyWnN6TituUWh6TVVOK3pVYmhaa1lz?=
 =?utf-8?B?QlhWKzdaNm5jazRwTXdyanNkQzM0anVoOE56UmNYY1NLa3pYOGgyU2IyYTc1?=
 =?utf-8?B?REhlYW00a2pCN3lQU1BWQUxDZ2dOeVRYOU5XY0pqTzYxSENLa2JGckx4RlZ1?=
 =?utf-8?B?NG9ndG8zR2gyMjMzQnIwd2MvUVo1TlBaSlJtMGhOLysvL2FXV1I1b2tBdEI1?=
 =?utf-8?B?dklnM24vMG5NWjNyY3p4NlE0bFNmdmFhd3FsWGtwcVdBVVpmTE02dTlBNHdu?=
 =?utf-8?B?UFNyNDI2QURJbklERlBsdmxSU1Y5UzVES2MxMjFxQm1KQUduQzZQbTBTdTgv?=
 =?utf-8?B?dkRRb0Q1NEdCSDd0dnVxb3ByMjcwdFl5UHhsbnkwRXE3RnBEVW9vQU51Qkty?=
 =?utf-8?B?VTZublpSTUh0eGFjOTlxYmphQnVWVzhLb0ZOa1NoT1RQdkhDbDE5c3gwYzJh?=
 =?utf-8?B?dC9uc09FRlpNYnJJMkE3MXQ1eDNXTHR6VzlmalZ1dzVmY3NjekdlSFZNc2hC?=
 =?utf-8?B?Uk04WTM2V2xydmJwQW5WOEpkZ1dCd05UcE54NlhEdnJiR1VYb3RKVllKbmV5?=
 =?utf-8?B?QUk4OHJqMzZoRlgvcFlZdUROczBQVkFwb0hvd29lZDlCbG1FdFU3MDRGaUlB?=
 =?utf-8?B?S1RVS2hRM01ySEh2MTBhNkZubGRYeEprbDhrYUgyYjFqSnRiRFB1VE42b3ZB?=
 =?utf-8?B?SEhoWmRUOWcyY3FpUDQ4M0w1Umo4L082eUg5OVc3V3IxbmcwUlRVZnB0bWxw?=
 =?utf-8?Q?VSYs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffea56a0-b1db-4403-2b6f-08dcc15a82c5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:56:06.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4ImM1gMsPyV1I8QNZ/7oaW0uaLc3ioe38n0wXzihrnrINI/mukY8XkUSvHWRzt3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956

Hi Reinette,


On 8/16/24 16:38, Reinette Chatre wrote:
> Hi Babu,
> 
> This patch now only introduces one data structure so the subject could
> be made more specific.

How about?

x86/resctrl: Add data structures for L3_QOS_ABMC_CFG MSR

> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as the counter
>> is assigned. The bandwidth events will be tracked by the hardware until
>> the user changes the configuration. Each resctrl group can configure
>> maximum two counters, one for total event and one for local event.
>>
>>
> 
> (extra empty line)

Sure.
> 
>> The ABMC feature implements a pair of MSRs, L3_QOS_ABMC_CFG (C000_03FDh)
>> and L3_QOS_ABMC_DSC (C000_3FEh). The counters are configured by writing
>> to MSR L3_QOS_ABMC_CFG. Configuration is done by setting the counter id,
>> bandwidth source (RMID) and bandwidth configuration supported by BMEC
>> (Bandwidth Monitoring Event Configuration).
>>
>> L3_QOS_ABMC_DSC is a read-only MSR. Reading L3_QOS_ABMC_DSC returns the
>> configuration of the counter id specified in L3_QOS_ABMC_CFG.cntr_id
>> with rmid(bw_src) and event configuration(bw_type).
>>
>> Attempts to read or write these MSRs when ABMC is not enabled will result
>> in a #GP(0) exception.
>>
>> Introduce data structures and definitions for ABMC MSRs.
>>
>> MSR L3_QOS_ABMC_CFG (0xC000_03FDh) and L3_QOS_ABMC_DSC (0xC000_03FEh)
>> details.
> 
> The changelog and patch introduce L3_QOS_ABMC_DSC but I cannot see that it is
> used in this series.

Yes. I was using it in v5 to read the configuration back. It is not
required anymore. I will remove it.

> 
>> =========================================================================
>> Bits     Mnemonic    Description            Access Reset
>>                             Type   Value
>> =========================================================================
>> 63     CfgEn         Configuration Enable         R/W     0
>>
>> 62     CtrEn         Enable/disable Tracking        R/W     0
>>
>> 61:53     –         Reserved             MBZ     0
>>
>> 52:48     CtrID         Counter Identifier        R/W    0
>>
>> 47     IsCOS        BwSrc field is a CLOSID        R/W    0
>>             (not an RMID)
>>
>> 46:44     –        Reserved            MBZ    0
>>
>> 43:32    BwSrc        Bandwidth Source        R/W    0
>>             (RMID or CLOSID)
>>
>> 31:0    BwType        Bandwidth configuration        R/W    0
>>             to track for this counter
>> ==========================================================================
>>
>> Configuration and tracking:
>> CfgEn=1,CtrEn=0 : Configure CtrID and but no tracking the events yet.
>> CfgEn=1,CtrEn=1 : Configure CtrID and start tracking events.
> 
> Could you please add the above snippet noting field combinations to the
> kernel-doc of the union?

Sure.
> 
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6: Removed all the fs related changes.
>>      Added note on CfgEn,CtrEn.
>>      Removed the definitions which are not used.
>>      Removed cntr_id initialization.
>>
>> v5: Moved assignment flags here (path 10/19 of v4).
>>      Added MON_CNTR_UNSET definition to initialize cntr_id's.
>>      More details in commit log.
>>      Renamed few fields in l3_qos_abmc_cfg for readability.
>>
>> v4: Added more descriptions.
>>      Changed the name abmc_ctr_id to ctr_id.
>>      Added L3_QOS_ABMC_DSC. Used for reading the configuration.
>>
>> v3: No changes.
>>
>> v2: No changes.
>> ---
>>   arch/x86/include/asm/msr-index.h       |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h | 26 ++++++++++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h
>> b/arch/x86/include/asm/msr-index.h
>> index d86469bf5d41..5b3931a59d5a 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1183,6 +1183,8 @@
>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>   #define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>> +#define MSR_IA32_L3_QOS_ABMC_CFG    0xc00003fd
>> +#define MSR_IA32_L3_QOS_ABMC_DSC    0xc00003fe
>>     /* MSR_IA32_VMX_MISC bits */
>>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 1021227d8c7e..af3efa35a62e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -589,6 +589,32 @@ union cpuid_0x10_x_edx {
>>       unsigned int full;
>>   };
>>   +/*
>> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
>> + * @bw_type        : Bandwidth configuration(supported by BMEC)
>> + *              tracked by the @cntr_id.
>> + * @bw_src        : Bandwidth source (RMID or CLOSID).
>> + * @reserved1        : Reserved.
>> + * @is_clos        : @bw_src field is a CLOSID (not an RMID).
>> + * @cntr_id        : Counter identifier.
>> + * @reserved        : Reserved.
>> + * @cntr_en        : Tracking enable bit.
>> + * @cfg_en        : Configuration enable bit.
>> + */
>> +union l3_qos_abmc_cfg {
>> +    struct {
>> +        unsigned long    bw_type    :32,
>> +                bw_src    :12,
>> +                reserved1: 3,
>> +                is_clos    : 1,
>> +                cntr_id    : 5,
>> +                reserved : 9,
>> +                cntr_en    : 1,
>> +                cfg_en    : 1;
>> +    } split;
>> +    unsigned long full;
>> +};
>> +
> 
> This data structure still uses tabs that seem to have goal of aligning
> members
> but the tabs are used inconsistently and members are not lining up either.

Sorry. I always have issues with these tabs. Will address it next revision.

> 
>>   void rdt_last_cmd_clear(void);
>>   void rdt_last_cmd_puts(const char *s);
>>   __printf(1, 2)
> 
> Reinette
> 

-- 
Thanks
Babu Moger

