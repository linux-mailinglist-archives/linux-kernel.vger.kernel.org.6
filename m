Return-Path: <linux-kernel+bounces-371844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC89A4135
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6E1F24443
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB141DB352;
	Fri, 18 Oct 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cMDmm3v9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9A20E31E;
	Fri, 18 Oct 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261910; cv=fail; b=tw65UyTitGnlX1wJY0YkV0SNn/ZKLXFGM3PbifxkNY90mGV5jcZdQGnqAOvdhwBYYqcC5TZ7nl3LiF146IJrp8dRYi6ikdGoZRtq2PDqmtMjKvzrrDXQifTnoJTPu7yA2u7UzlzoOyiM1Vua/0YCGVA5dE1wgKL7vB5IoOHHcyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261910; c=relaxed/simple;
	bh=GAvOYmH6EfU2f2GTXyTOXvynqnbrOQlj1Hxw1/HyIWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iheFsySzSMp6za8rL87V/hZM1yiQrmsK9zqKCgg+R6t2OQ0pjt0ItWP4cM235BgQrhmjqHSBWMJ8gjDuN00ok08vOS3sqnDGhE6BLauzvkPmMrXul/pX5FXmtWNGLrzkLDFKc7SC0J4L3As5IinMFKGqFR5YAIe7mcPmExyQQog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cMDmm3v9; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9+/TfJOLz3wEuUvRTSctlrnrbjwQTAIRU6s1HWok0/Jl9iKmNbQiN3kt2yzFLHHvhaHe750SY1qX4thusscQjyi+kA+lVXURAhb+SdB+LEEYePbNNEwdRxKdQ3Nd7lReP0/TS9ULwyA0F60nwUsd7obp1suwnN6Pbmp3JcS1ipAAmnNf+lLLurI6Ip5qn8DsS/E5OfN0dnXg5DL7bE0PR2SwYrQg0qIroCV9F64fm+b5jCA/WENxMBFk6/AApVy22NGeIvhKozSrwWAtua8O5C+41GI9D9BFUGf633poxo6YT6DuCm0Gek2f1Sh6wC/y7R1poBSEE4yoEneI9sh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkbG3XMFdvBG8dSz8fd3fQUoc4hsvesXfZLR0YHyZBQ=;
 b=KbXUC6aByrZge6CxWYiulKVB0agsxnEAJW6JXzUT0G08pWl+cM6jlpaLAIvTgd2PZOuECtqL8v0n2gNqHmgZw3/6IaxajRhAdzCF6h2DytFTzFApUDZQ77iaTMeofmP+FblTTNi01SYsfTnfgGIcCP1QUNFfnrOUCpEzY1czIzp9hcdMj5DzUEWm/AwQU3Kol33Gxm/0A0vMuyujFeYCyrfzv1gRC8Vl727/gUvT7Y6sBWfhEo/zRD2TPTEP3v1PcGM6GWrnGPcizPwvf+tCXQi69EwxWlzfZZWsq3HuAMpEY3NLrageYfvK6ckX1Q0vRFXw2f4T5ixEyexurA2uAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkbG3XMFdvBG8dSz8fd3fQUoc4hsvesXfZLR0YHyZBQ=;
 b=cMDmm3v9uLjBNZBgRI5CIqDvi4uhx0Rd29gBmRxWGHEFwiHj1eBnAHJtvNV3mjGQyf9c7RlXOGnmyVfb6lLNqFC7Z5ivmi/BMDIoaMh+fioJk08K8CeSaUilXkhdHh1Zw4rcrbJaYalcuI5IsUJ/ySxPUy2LlRCN/5pe9yLM+Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 14:31:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 14:31:44 +0000
Message-ID: <c074fd31-f037-7da9-85f9-9cfde3b30716@amd.com>
Date: Fri, 18 Oct 2024 09:31:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 20/25] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <50a4e993098422eece96d08edc337856a52cadd1.1728495588.git.babu.moger@amd.com>
 <115efb93-9d5e-4e03-9aab-a08afa003359@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <115efb93-9d5e-4e03-9aab-a08afa003359@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:806:a7::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: e15e9ee6-228d-40b4-3a8a-08dcef8196be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGJ1VmVNUWozc1lIT0FibFZUVzUxR3NMbjYybTJkeFZHZ0U3K0dwYThhNXNT?=
 =?utf-8?B?MUw3S0w4YjkrNFhKbFJrUE1PVmlteHJtMllwYlcvdEg5ZFhsRDduRTd0SVZ4?=
 =?utf-8?B?QVVSeHM4cm9FNkVTVi92UzA4bVUwbG9LTDlKM3liZUcxYXFpNGgwaXZkOU11?=
 =?utf-8?B?azRaVDgwUXI2bm5OUlJiaVl6anlLRU8zUlN2ZTdxL2lFVHUrSmp2ck5ZTE5p?=
 =?utf-8?B?TkJQM0dVY0pSYWdKTmx4aUIzMDJoRWUvNERES3RtWTl5Ymhia1h1UklzTlpi?=
 =?utf-8?B?aUlSWjY5dzJNMnJIbmF3RjF4Nk94REVGMm0wa2JjbmRoZ3g2Z295WmdEdWFI?=
 =?utf-8?B?S2lGRGdYM0NoNElwYmd1cFVBRWlnQWk5eUZYVHVCT3gyUFVKdjR4bnBQMFZ5?=
 =?utf-8?B?STNVR3pScjJmcGo3TVdrWENKM3VleUJJcisybEhlNkI2dHI2YTExS0V0RGpN?=
 =?utf-8?B?cVFGclk5d2dGeFVWWG1kUnJWbXV5RDZGakE3QThMM1AwTkIvcXZ0ZE9OWlBT?=
 =?utf-8?B?Y3RINUZLYXZIZDUzMkhVWjVYaGJsY1lONjRHa2kzU2FWMHFzMmNhL2x5aWhi?=
 =?utf-8?B?NHM5cW9yT2c1ZUJaaFdWZm1lc210WUQrMmJtMWxkdW41NHV2L2ZYMTlwa2Jx?=
 =?utf-8?B?cTFzZlcyY2w3OHBKdTBadURBYlFXOUo3bnBLNzBpWGFzQzB5d0FienVZZ25k?=
 =?utf-8?B?cFBsLy9TVEdaLy8zdGdMbU9XUHp1MEU1ZEhueG9Xd0FDVnNoTFpIcjhXWmtE?=
 =?utf-8?B?RFdUclRZZzZCdUNKVjJQU2lzSFRxRzBRckZUMlhmbzN2bVZYZm05RGx3NmdJ?=
 =?utf-8?B?RVlaWWVMVGJTNURxZUI4WS9DSm01MmhaM3ZlUENmUEp4U3RFU2hmWGlPU1ls?=
 =?utf-8?B?cTl3Mkp1Q20yUUwvYnJtcHFWSm1SV3JtWGZHc0gzTURzb0xSRXJqNUFuS3BY?=
 =?utf-8?B?WXM4cnZoTUZRUWxmbWwxN3ZRdE9nN01lNzlhbGE2eXRBaER2ZWNCV2oxV3pa?=
 =?utf-8?B?TXRTak9WUS8wd01Sc21LQkhTaW5DckxYUDNXRWoySW1sNGR6aTVnNGpweEZ6?=
 =?utf-8?B?bExMWDcyNVRPOVE1MmtzK0RBN2xRMlg3K3VLNTB0VTI0THFZOXM1KzlSZE4w?=
 =?utf-8?B?N2JJQkNaeEJ3UWNpZVNqRFYvUHBLK1l2by9GeXhTenhwemZLQ0VKaDJSM3cz?=
 =?utf-8?B?SndIMjdXLzFNSW1HY0tyVzBaSE9uNllRc0RRWHR5eWNCSUZTSEVtZFFrY3NU?=
 =?utf-8?B?bnVSY040Y1d1em03d25aUEhZNVF5Tm45VnYvYVNaUXJzbkFTVnB6UHBBenhq?=
 =?utf-8?B?QzErRGpNaGE1bERJeGxUQ0hwdWxUTWJ5Q3BsYlJiVXVVOU1ka3ZIL2VUamM3?=
 =?utf-8?B?NHRlTFRlVWtJenlNZGNoLzlSa0Y5Z1lKZFlsc0VZL0FqZnNEYmY0NVRTMTJP?=
 =?utf-8?B?OWszdDZuY0hiUDdPeEtvUUVGcWpMM0RIdmZHdWw1RW1USTExT2p2V2RKeldX?=
 =?utf-8?B?UG9tRXpUUlpLRFNhVEhPMmQxYUZPRFFaVmlQSHRLKys3U2NOdmVzNERWV3FN?=
 =?utf-8?B?MFRGcTFBZWFmQ0NCRXNIRU94RlFGM0xFNkpIVktxR3BYTGpVOXM1SEYwbWJW?=
 =?utf-8?B?NFViZnRwc0VORjl2U1pWeER6SmxGbzVZSTBMQVFtZE4rcnpHWUF5V21UdjJz?=
 =?utf-8?B?T0t6QzNyVU1teUJHZS9xeFRSN0t6TUtwaFZYTzJ4WGlncTFtUjVsaSs2RUZp?=
 =?utf-8?Q?LGAAnXGXtTvUZhixpZDhcvkUis84PEDkmHoZ3gQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djNXRFNham96dkc3QUVHZUlRc1p4ZFBZRERsOGZGdjVPeGRBaEdjTktMdmJt?=
 =?utf-8?B?S2JhdGJueDd2NmFhYmJDM1dGUHhBeFJ3NUlzLzdoYmFyeHF4OEN2RzJRYkhJ?=
 =?utf-8?B?NExUNWVBMVJBd01oelJkUkE4RFVVNUxWODM3N243UGVCNlh6ZWFBNTFsSEFC?=
 =?utf-8?B?SG1Xdmp5NTZyeFAyRVl5RzNXS3pYS2IxbjUzbSt3UVNLWUJoRGh6NVRPdVFS?=
 =?utf-8?B?QzdFQUhZZzkxR0lPenJtRmYxNno3cHI4SFFaYXgvdzhPb3RqWjRIbEVic3J0?=
 =?utf-8?B?TGVvTzJ3bjN1OCtDeS9taHpRNG9lTE5iSmdFanpWalpCZ3A5T2NUYitRa0pO?=
 =?utf-8?B?a09tYWxkY2JKeTdBM2pENUcrd2lWYUVrYW9kR0ZhdmdUc3VyamlSUzlCdXFt?=
 =?utf-8?B?aHFLN0Jrc3NlRkhIZWpzeWw2TFZrQUdWZ2c5VnE2eU1PanRCeUdiYXVxWkUy?=
 =?utf-8?B?NzdSMkM2NkF0WE1KTWdnbmlmMksyTDhZN1FJOFNSMTVZNnBuWlpKakswSFcv?=
 =?utf-8?B?RnBKUTJTcitFTVlCZk1VeEt3dUhqanVYaWFMcHRONittOWFMZGhhOEJrMVZp?=
 =?utf-8?B?TDBEZ0w5cExsMjlTaWpFV3BFQWtXQXgwRmRibFpHbFFHYzluS21RSnhXNldP?=
 =?utf-8?B?cnhtV1BqQVRzWVFkTnpjbUJWVHBucFg3eitiVUlIYlVRNEYzWFFDUktraHpr?=
 =?utf-8?B?cWdGSTRabDhlSm5IZldTMHprMzFqNEtta0ZRTE44MklGZzZsRVdOL0t1elF0?=
 =?utf-8?B?ekhDK1h4ZmlpUDlyQ0c2bWZJdEN1ZkxZcFdUbERoSWxGWU00WWhnODZ1Y2d1?=
 =?utf-8?B?Y0xDc2k1OU5IWnAvcG15OXBibGp0SGVYSVhXUWV5RmJJZFRPN1MwbGg2K0FK?=
 =?utf-8?B?SUNvS2JoalU4THBJWS9NY3BOaE1LUTFva1N6M2MxNDRIQWtLNEVubW1nMEY1?=
 =?utf-8?B?Z2FhOWtrMk9vS3hsMFYwaWhLeUkrdGVCZ0ZUSzNMZE1HRzhDQlNEaFRCY1cx?=
 =?utf-8?B?cDE5RnRQcnhJR2hjRWFBS09HeUw4bkhReXI3YWhTMVkvOHZpbi80Q3F4ZHhI?=
 =?utf-8?B?SEdEODNNU0Zqd2crS0h5V2lNU28rUi9ldy8zaXp0VG5jc1ZEdTlXMDBsY2xE?=
 =?utf-8?B?REJDTnZHakdkQ1hzdW85Z1NZdXBiYlNGUWxQVWNQNThLVUFETmdOV2F0REhl?=
 =?utf-8?B?OTFsc21VSTFUT3gxdlFVclJ6K21yOE8xS1lOZkI4QU5JSlFobjNaTjZGYzJI?=
 =?utf-8?B?Zy9wcEk0cUhaeHNEZktqVDlVRHc0NjQ2ODNYRmVMRUp3TUNnOU5zT3BTakxD?=
 =?utf-8?B?disrc0tONGRVdGlWVGRnQUJsOGtEUmVzK0N0OFgyNHJnVzNRWGZtSTBIelNH?=
 =?utf-8?B?MTlhYjE3SXZ1dzZ1Q2VPWVp0TXV5eTl2SWRUNjg3YlpBRmJTQ3IxUUk3OXda?=
 =?utf-8?B?Yi93eFQxZEZjdWt1T1piSTFZM3hSaktTSWxLdm5VYVgyMFp4WnJibWhuaDht?=
 =?utf-8?B?a0ZMaFFyVjFYblpSYjQrT1hGUFNhYnUvQTBHWlRXaXprd1I3UVFnZmw2ZnVK?=
 =?utf-8?B?WENrQlZpUWxFcXJmVDRBR1d2WGVFRzhXUTFWM2NoSXMxWnJpVUd0TklBWGdB?=
 =?utf-8?B?LzdUSUlUeXA2VjQzakdFYUQ1bVZRK3NRRG44QU9RSDF2NHIrMk9pZVZpOGJS?=
 =?utf-8?B?ZG9id0psNml1QUVVbzl3UGsrUGZDQ0Y1NW94SHEwcTVXejIzcjg3SEc2Tjlk?=
 =?utf-8?B?dUQwbDNZRS96QXdxTUxIQmJwR0VQZW8vbFN5SXd1aGRDQ1ZlM05kWWVrVUlY?=
 =?utf-8?B?Q0p2Nk8xYUNDRmsrRnQ0cDlQWW1KRXU3aHU3YVczQlltaEsxemxJT1JXTndJ?=
 =?utf-8?B?VW1QNnB2Ny9NZ1JOU1AvK1ZmdWxOa3JETjFCbEJab0Nna21JOGxZZlpCb2ov?=
 =?utf-8?B?RDNJb0NkZHlvMTZPUktxVnFodWNvWnNydHErYTB6REhTOGFYTTRNeWlZQWMy?=
 =?utf-8?B?RmpVdmVvQjdKaDFpUjMrclMvNDZnTFAwWGxWTFRWYjNNUGQvaWgwQXBxUEhz?=
 =?utf-8?B?Q3NveDExeHEwalh6cExBaGZJVjlSWEM3YlMxQ2k3NC9ZblQvWFhqa3VIMmNs?=
 =?utf-8?Q?M+qA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15e9ee6-228d-40b4-3a8a-08dcef8196be
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:31:44.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyUH7u3UQoV6WFiyFahip8yByia5Zba8lvxSGoIoBu5I9dDpoaLJ5zXWSGoRAoZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

Hi Reinette,

On 10/15/2024 10:31 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> In mbm_cntr_assign mode, the hardware counter should be assigned to read
>> the MBM events.
>>
>> Report "Unassigned" in case the user attempts to read the events without
>> assigning the counter.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v8: Used MBM_EVENT_ARRAY_INDEX to get the index for the MBM event.
>>      Documentation update to make the text generic.
>>
>> v7: Moved the documentation under "mon_data".
>>      Updated the text little bit.
>>
>> v6: Added more explaination in the resctrl.rst
>>      Added checks to detect "Unassigned" before reading RMID.
>>
>> v5: New patch.
>> ---
>>   Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 1b5c05a35793..99ee9c87952b 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -419,6 +419,16 @@ When monitoring is enabled all MON groups will also contain:
>>   	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>   	where "YY" is the node number.
>>   
>> +	When supported the 'mbm_cntr_assign' mode allows users to assign a
>> +	counter to mon_hw_id, event pair enabling bandwidth monitoring for
>> +	as long as the counter remains assigned. The hardware will continue
>> +	tracking the assigned mon_hw_id until the user manually unassigns
>> +	it, ensuring that counters are not reset during this period. With
>> +	a limited number of counters, the system may run out of assignable
>> +	counters at some point. In that case, MBM event counters will return
> 
> nit: "at some point" can be dropped for clarity.

Sure.

> 
>> +	"Unassigned" when the event is read. Users must manually assign a
>> +	counter to read the events.
>> +
>>   "mon_hw_id":
>>   	Available only with debug option. The identifier used by hardware
>>   	for the monitor group. On x86 this is the RMID.
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 50fa1fe9a073..5a9d15b2c319 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>   	struct rdtgroup *rdtgrp;
>>   	struct rdt_resource *r;
>>   	union mon_data_bits md;
>> -	int ret = 0;
>> +	int ret = 0, index;
>>   
>>   	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>   	if (!rdtgrp) {
>> @@ -576,6 +576,15 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>   	evtid = md.u.evtid;
>>   	r = &rdt_resources_all[resid].r_resctrl;
>>   
>> +	if (resctrl_arch_mbm_cntr_assign_enabled(r) && evtid != QOS_L3_OCCUP_EVENT_ID) {
>> +		index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +		if (index != INVALID_CONFIG_INDEX &&
>> +		    rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET) {
>> +			rr.err = -ENOENT;
>> +			goto checkresult;
>> +		}
>> +	}
>> +
>>   	if (md.u.sum) {
>>   		/*
>>   		 * This file requires summing across all domains that share
>> @@ -613,6 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>   		seq_puts(m, "Error\n");
>>   	else if (rr.err == -EINVAL)
>>   		seq_puts(m, "Unavailable\n");
>> +	else if (rr.err == -ENOENT)
>> +		seq_puts(m, "Unassigned\n");
>>   	else
>>   		seq_printf(m, "%llu\n", rr.val);
>>   
> 
> Reinette
> 

Thanks
- Babu Moger

