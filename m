Return-Path: <linux-kernel+bounces-337217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7D98471E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6351F23C17
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631B1A76A7;
	Tue, 24 Sep 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGzF+63d"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3A1DDEA;
	Tue, 24 Sep 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186331; cv=fail; b=tFIbdlvduRZG+ky34r139xYtrqIm0amLOs2sPHdUOfwiR6rfVCIKapc4lukC6737kgmLTlTNzVhY9F/+EQ3hpp+n+TNwJDbhGFnOyZgpRftaE4g0jFNZvpAJU2tQOKTAB6m0qFZvTY19RAhYYYHxT7psZV3+tiCxRgBeb3108Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186331; c=relaxed/simple;
	bh=LJ7KvWlXIGv3t2+yVjHMh+PcPVegmIpEwxJVDnroNaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mG0TgixtBQBRfrRd+7VKswyVHYPIJ8VH9g2ZXsmeSsGY/tspLECqL10ZEerc+FOEXl1BpKyWuu0GRz8xZwuGiKuvx8nxxSc67nS7JfeL3Zr8538HYqdVvOkqL07HTI8phkhFTH4zj1eXBRjQdc/M5DvwLEH3Ik3F1t9zg/qBlLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGzF+63d; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq9aqbqkGrHJz+DqUsrXqiraS4vVVff7IBYbepI0MTEoNJpbzTmq7/lhZv9/5c0KZ9r3k9syAqUjEHu+UZvaz35WHgPp3YaM9amJRJQSUEE89O28ZZO185Q83OLFXJTim9dcwbLcMBnP8fio5azxq/85VT4E2lfomOi0zmJmLGcif08R4o7V4wtWkIf0Z3fWNQcPF65TjRAui5HiSLooW2HIetQU0zyJSey/RyT2v6yLOhA4TDuYSYx2USt+nQ96pwQLkrZDIdtyRTCcrml3XA6bh8kbeJoSz66x2w7XJFSYu476LxZZPVjcTnTowsQkCe8v/lN5XqQkZPcl51229Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45V11frH4pTCx7Nx7mHSSEoD9oydpHruqGkjC/3rBEA=;
 b=b/Y3E6ksggEh8v58peMbn+UkvUMV0NDb8+Mnq6nd/97M9RaL4GSssN64LlwFw8Q7vNeDVtae9LohoaWG0HXKIc08pUrRgqO9i0lY7K+I2YN/RH6X8qj7H8B0JRKh5czsEnmlcjJ8scjQ8dgOK4gY0xgeDspb187vzZPZHn+Dn5eNd+YfUpb0LhIsXyG890aE4s7vO6A55HPfWQZJZ8TrR1xlXaMpQwcWO4L2wFxqSYbNjugvaXRxgeaRJiffvEwlMdwF+CqqLRAyrI1WsI4QZwKFYzubqLvcvSldg2ju/9rSfnrDe0sUgE961xBEu+xPpFzt8MXshsPSSG+5V92Zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45V11frH4pTCx7Nx7mHSSEoD9oydpHruqGkjC/3rBEA=;
 b=wGzF+63dWNgTKjt/jf/JpxeomiqfLX9k4txeTdLOjjv/UkZouaSAN7cEBd4LBf2FbSLdD7i28e+3q8j7PkoLuRM1eIvAcbCVsMMyBAmL9tFwfYMt+MunY5behJCj89A/2VZ2NyTWXnQbXDbIMp1gEx0A6nYfv/X6FqRk9N7CVC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Tue, 24 Sep
 2024 13:58:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 13:58:46 +0000
Message-ID: <5f4f1316-f049-4c96-a881-fee128d26e27@amd.com>
Date: Tue, 24 Sep 2024 08:58:42 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 09/24] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <a94c14653c29e89bc76727addfcdf1f9c164b95d.1725488488.git.babu.moger@amd.com>
 <50084b31-49e4-41c7-be1e-24773d03d5d3@intel.com>
 <c333ce4d-3e4a-45b1-87b4-42a4d35d0ad0@amd.com>
 <175ac51f-62bc-481c-a31f-b1e372ac343a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <175ac51f-62bc-481c-a31f-b1e372ac343a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 872b66ba-6e34-477a-0097-08dcdca10243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ri9MYjhqaGNta3RteDJqMUdBWEZCZkhjTHBBU3pTZmx3U0RXR2xxdHFFRXht?=
 =?utf-8?B?ZkZiM3JvOWJNZ0RUVWhGZE0xaFBoa1ZzMitOaGcxNUMrZ1UxWCt6Z3drL2ZB?=
 =?utf-8?B?SXcxNi9kSWJENSsxRGxPeWh2aklxTGhiQTV0dUdoaE92eUhSYkJOeXpreUEr?=
 =?utf-8?B?WDlKeVh2REpEejNCT2VUK1lXTGdQQjJOUmxUYnN1ZytQbytvd3RlYnQ2ZGNQ?=
 =?utf-8?B?WnRWcm1VWFc1S0dvMDBzU2JGb2NUbithWnFQK2JSUEhkWGNYYTBDM0hHL1V5?=
 =?utf-8?B?L2tVTnJ1WTl2cTYyVnJFWXVYNTFFRHBiSk1OMU5OUHhSTE1VQWFxTU1zOVlv?=
 =?utf-8?B?d0s2YUNTU0RzbHRxSnhiMFp6OUpwakVpNURhMUkyRDhWdmVwWlhKL2hJK3Y2?=
 =?utf-8?B?RDlvazEzdEtVVksxQWR3RTJ5aWNvdGxGZGx4dFFIcVFSYnZncjgvdEMvcHZS?=
 =?utf-8?B?NVlBT2t3Ti90Q2Y4amlJYktQMTErWXJ2VTFiU0JYUTVhL2FwdmNJQksyNGVV?=
 =?utf-8?B?VnFZdlJPb29VVDdVcFUyRzlQb3czWmtocjN6YnZXTWtPQ3FQWG9IMG5ETDNX?=
 =?utf-8?B?NnhRZ3RoTEpZV1RkMFZuSGVKbm4wUnVyU3psRGZudTBhZW16RWZGMTBPOG83?=
 =?utf-8?B?cnRYdzVQc2RiMGxTbmc4SUtrUm5xajhqSy8reVl2U1MwcWpFRDdaL004WUkz?=
 =?utf-8?B?bzR2VkozbEMycjExanUrdUM0OW96WGY4THlkZk1WVTVia1VSWDVTMElxbDhZ?=
 =?utf-8?B?VWRqcDJWbVFYeHhiQjJjRVk3VG92Z2NJMnFmRmIzSitjc3lLbnFFSEdXMllh?=
 =?utf-8?B?Znh3Ynh3ZkgzcU1QUzIyUFJRdmZsU280U3Y5dmpPdGJjWndKM2FZMkpqRVNZ?=
 =?utf-8?B?M3J5SlNzaDFPWXhCcGJkT1c5YndNKzRaZFpoVTZWNU0vVUZMK0J0WmNKdk40?=
 =?utf-8?B?QUxDNTAyN0w4K3pnTThZVXRzZ1dqSElFQ0ZHczIyU0JQL2dPVlgrQldwcWZL?=
 =?utf-8?B?Y01Pa292RFQ3Z3JKQ1IycXZwNVo0WmpjUVE3Qi9UeUh6SGh1QXpTZTA2Mkhi?=
 =?utf-8?B?endTL21Ib3VlZ2c2ZWliR0NOSFB2OWJCeTVsSjE4U1hjVlhGb3hVcWM5VTVP?=
 =?utf-8?B?U01EZnlkeHNhelQxa0k2dmExMEZ6bldLRFZqcTdLWUZtRmNUVHc3aWwxeGZB?=
 =?utf-8?B?emFQSVRaOEV3Z1l2SGtiWnVmbFd2T2JVRFVFM3IybXdHSUt3c1ZUdWYvSXNS?=
 =?utf-8?B?Q3kvYXNMUEpCVVJRQ0hRUVVCNENZdnFWdHRueHd2Y2N2eDdSTG4rcUliNUty?=
 =?utf-8?B?NzZ1WTRQTEd6QnpRVml4SHRtMjNLU1o0T0JuS0I0SHZ6WGRMWXlRbDI3MHpz?=
 =?utf-8?B?aThHVXB6YkdkY3pUNVFuS0JBRGZjeWFIV0REUEtZQXR5UUV2OUF3WkFOaEU2?=
 =?utf-8?B?SVhuN3dQTEhFVU1hSzc4amhkVDg4Vk5GRzJNOWdaQTVOd3ZZaGplbkZOVFNX?=
 =?utf-8?B?eEQ1cHVjWm9MS1lBejBYOEtBMmdScUtUR0FuT3ZqblFqV0RjcS9rQW5CYzlz?=
 =?utf-8?B?c29yMUVpaWMvSjJmcTN6cUU5VGNrWGJVUENCSkpuN3c5ODU2NFNsdkFrQzc1?=
 =?utf-8?B?b0YvakZjWjVhd3BkdXlaakVqL1ZrVVpaTVRzbExSY0lCNVdSWU0rSG9lMzF0?=
 =?utf-8?B?YXVEWnZ0MWR1cTd1cWpDcmFwZWJZcms3MURJcXJIdlA2Vm52NHdRWWhxbG1L?=
 =?utf-8?B?M3BON0YxNWQ4eUtjQkhXZDd2YWFBZytqNVhyK3hDcVltb3JBZDlTSVRiYVlo?=
 =?utf-8?B?NE5xb2tmenJDQ3NWaEU5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDdPaXE2dDFWZ2x3aEZaaERXVkpVVlVweTY2S3NTeWdBcVRheStYazRZVG43?=
 =?utf-8?B?TXZSaHcvQmNybEZlOVNOUDRWaTdseDZoVVdqbUdoSVB5KzFZc1VvZDFiNlRw?=
 =?utf-8?B?S2g3dGdjRVpQSllzb0wrRmt5VDcxUlZid3k1YURDcnN1blY0WFZOalNvdTBL?=
 =?utf-8?B?cXNjNzhCNENLUms2bEFrSDFzcTU4czNTSDZrMVRtb2JwWm4vWVZaKzEvWllh?=
 =?utf-8?B?WVFGQVdrWi9wYStibURuRTFHL3JMZE1LbElDOGtydGlLdEN6bjZTcmtMY0ZJ?=
 =?utf-8?B?clZWelhNY0F1ZHQzWHNManhLOFgxWkFMV2dEZWpITDFXWXBvd3VsQ0dMQ3RX?=
 =?utf-8?B?dTVPek5NRXdFbFUzWTdma1dQWWZ0Q2FhUVRnZHBzVldxcEJBU3ZtaHFQZURj?=
 =?utf-8?B?blFPZFpjVDlKeXRvd3lpdC8wWlpncXhrT2hzYUJkNWNPalUrTHlJNDQvM01i?=
 =?utf-8?B?bWJUcEVVSWYyeWNsbEk0NGh0aFU1R3V5WkVnc0d3UU9vcVdIQ2M3U3BLbGxP?=
 =?utf-8?B?T0tVQ2RlR3NQM1JPUzViRG1tSTlDc0dncitsV3p0dXdlSG1iWlllNzZsdXVL?=
 =?utf-8?B?WStHSitpcm15WUNpOElYamdKTnh4b0h5VmFuYzgzcEJ5VFZrNWhTZGRpQXhU?=
 =?utf-8?B?c0sxbnNWL21FdzVTUVpLUDZZbG50WVg4dTBzSzV1WWxtTTJYbHF5eGhQYWJB?=
 =?utf-8?B?NGVocTczSkJiZ2dwY3JsbUxmazFIUE45NGhlcndpUG1sODk0NlV4d0cyUkxU?=
 =?utf-8?B?TmZOZTRCMGhHTklWTW1yWUJkaFkzb09KWDVTekJzTnFpOWxqSEZmcWp6TW1s?=
 =?utf-8?B?c2RVS1pwU2JORzNpb1RqZngzVUhaY0VlOWlEWmxwU2d4aWFETHJyeWoxN0Zz?=
 =?utf-8?B?ZFVxTFFuYnJnVUtsUFQ2d1hvQTMyRGtyNnpPNkMvd2F1S2duRkp3VzU1Wlo5?=
 =?utf-8?B?c3I5cGVVRm44ZGdVeklOcTdWcmhsSSs5eXNFNDBDUGZqZXd3STBFTUd0RERG?=
 =?utf-8?B?ZktWN082ZVNmRGZDMnJYblZUK0xhdmlldld0QXE4NjY0VVp6Y0t5UEgrUUhJ?=
 =?utf-8?B?RktPb2JLa0pUbEQ3MzJ0MTVjVEJnSXR1Tkp2SkdwMHAwZlk1bzFQa1BSdXR6?=
 =?utf-8?B?V0NtRUNlcWRXeUpqazg1QkJwVWUwK3J3blR1V2h0SXFkOW5hL3JHU2VySDV2?=
 =?utf-8?B?SDJObnZXUFhlVzNZaDFHc0JRckJtTFBxdWs4Y2F0ejVOdytjOU9VQkcvWnp3?=
 =?utf-8?B?VkpNYndCRGJYZHQ2Z0lWOXlQdk1ESWJuUWRQWXRkZnFrWmN4SHVUUnpUQlJB?=
 =?utf-8?B?T0t2SEUrL2VKc1VLNUxhYkM4TDRDWTVMQXJKQk1qZEswK1lJL2VDMmdWNm8y?=
 =?utf-8?B?aUJxRm5lS0N3dTBpOGdTa2JmbXk2dVBjQmlkOS84YWlEL0srKzg3bnhNb3ND?=
 =?utf-8?B?T2V0cGI4UW9PUUVvbkxzdHAzUlgzUUpYZnNwZkxOMFdGZUpwRlE2U25Fd0w3?=
 =?utf-8?B?OHN0UCtBSzFtZzl4bnhNT1kxeEF3UjA1ck8xY3JzUjNlRVRnMzFvdXZnTEZ2?=
 =?utf-8?B?bUltaDdvUnhUZ3VNYzhxMzZkQTI2SW1HYXpEVVRDdks1UWtOYVhNL0lsMm5M?=
 =?utf-8?B?RkRpY05KaDh3Mm9OeVVndlJJRVdNMncxc3BXRjMyQ2FDK1ZXWERyS0FpODdY?=
 =?utf-8?B?M0R1N01XWW9CSFpCWFMwbHVsUFdMeW8za0ZsNDJsQlY3R3ZCbWxEOEhBU3JV?=
 =?utf-8?B?T0ZNZUZtTDdvZXBxcFdoa2lYbmQzUFNXODhRMFBOdEV2c0F2czlldnNEcERp?=
 =?utf-8?B?N2M4RFcrN1kwVVVIWjkrQWdkbjA3OWtoajZhR0c5WmlZQUd4UTFIdnBpMnF2?=
 =?utf-8?B?UkJ6d3YwUzErRUVhajk4Wjc0UGhkVys3QUUrNC81aGRhSk9kLzJxUWhVaUJP?=
 =?utf-8?B?dmw3VjBHTHA4TWVMb2hDL0dOempHZTVIVis5RXcvZDUydEZBVGxKdGN4MlVX?=
 =?utf-8?B?aUFZUitLOGxFMHNha1pTNDhnYXk2NHZPSzJud0JXODcvNlMrUUNxZmNTK3J4?=
 =?utf-8?B?VEFsTGF4dG9seWlnc3g5bmhURERQV2d3TU44ZXRqK2FqYXF2M2N3bWtSTlM4?=
 =?utf-8?Q?2UYI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872b66ba-6e34-477a-0097-08dcdca10243
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 13:58:46.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AP4k9yr5gJe9WCKaQpPziDHMqiSLHtGNjqfcOCsln0QQiXpbCQkBUAEYbncBHMhf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042

Hi Reinette,

On 9/23/24 17:28, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/23/24 11:33 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/19/24 11:42, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>> Hardware provides a set of counters when mbm_cntr_assignable feature is
>>>> supported. These counters are used for assigning the events in resctrl
>>>> a group when the feature is enabled. The kernel must manage and track the
>>>
>>> The second sentence ("These counters ...") is difficult to parse.
>>
>> How about?
>>
>> Counters are used for assigning the events in resctrl group.
> 
> Apologies but I am just not able to parse this. How about: "These counters
> are assigned to the MBM monitoring events of a MON group that needs to
> be tracked."

Sure.

> ...
> 
>>>> + */
>>>> +static int mbm_cntrs_init(struct rdt_resource *r)
>>>
>>> Needs __init?
>>
>> Did you mean to merge this with dom_data_init and don't have to have a
>> separate function. Please clarify.
> 
> Here I was referring to the actual __init storage class attribute. Since
> mbm_cntrs_init() is only called by __init code, it too should have the
> __init storage class attribute.
> I do expect that mbm_cntrs_init() will be called by dom_data_init() and
> care should be taken when making this change since it seems that dom_data_init()
> itself needs the __init storage class attribute. Looks like this was missed
> by commit bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")

Sure. I can take care of this.

-- 
Thanks
Babu Moger

