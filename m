Return-Path: <linux-kernel+bounces-273075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F57946450
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A541F21107
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3524EB37;
	Fri,  2 Aug 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hNz8zngi"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D81ABEAB;
	Fri,  2 Aug 2024 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630208; cv=fail; b=Jaz9ChIWQZxIFp4/fs9GGxQC/M05vYNF62pfvUnw6FRqU1asNqj/wxgbBjTK3NbCDA/VWb+flPuTljmldR6t1kwkyb7ctjCU7ELl8nlzYj+l6a6sW1Q8bV6mtUz+C2tsoMnFZ5xh1ls2o85XlZyl1rYRNEtgM8EDVgOuJ/oNXwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630208; c=relaxed/simple;
	bh=cbw6FwOf+b+L2UZyApCs21wqepy+l+8kPt38jxycEno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQLmBbd/erWpL4R7rZ2CoUx4re7LzQz7au/Bwc+QYcIQkZWEvqRyjF8SK+9ar6884EfljexK5NMOcvWzvwCi3GM6Dd5pQq9zYagQ+8I6S0u5tH9JYPJ1EFDUgQOE2vgWnuyvtZkGDQN3m1oU/YeNEnBEA4i9TfMW29b9rbkkfWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hNz8zngi; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9ZwRmEXESGogS7/FJbxgOOzsCBmoG00g9rf0HV3ncBqRGfhk2CVOa/OtmIap3r1aI1SDTd94MQHmJGB1o1UCANlz8kSEtdCxuD7T8/h7eEh5IVpmMJC68GoOgAIYi8Z9joVO3DNI/c11qefQ5C5YltaKONa3pyl7sdwCmq84178rK1UVC/pTIw/hL0ScWLY1NMkP+syIHCVHLc3fy+uIwaVHTYDJL3eeRcT8xlPTlroGNYkq5hbQnLVSeKZGtPRlD4i/O19L3w1WMXRiqxMhVb44nNsGIpVbKl/YNIRVjjmIDvp/hAmpqUVBM9ZjhVf9pASOWaeu80skffza/3mWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIqqxoGPAMihe1bHVY4j4vt00PVWXaIafH9OMLtHIH0=;
 b=YdT1uIAdbwPeEDgcvjI52PkPE5wYLEWt4lXg7uU1gyx6/svdMxHb8byScest+eTHGePkgrCjOc1+arCkIwb3A1nTWXufDBkcg4xJPu83M0adMpJvBm3TnzTiqJGuuSR6dPo9bYTX7DSqpr12hFDlKq4TDCMnLRhepqlxSy7l/YYvkUHLPFHe1lsJNSa8sHyG5Or6eZSg4XY9fEpkDT7Cp7y5SqCgpwf4Ac66X5aYospF2g7myxn5GMzWwdfiTW1gYGq+F+qa1VVKttTGghZf+xfzFqSXzHO5cMkDcAKgNDZ/TcRM6YZUohWGZcJu0r/F2Tgzv5sMfMEVsxHkf1BgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIqqxoGPAMihe1bHVY4j4vt00PVWXaIafH9OMLtHIH0=;
 b=hNz8zngijXVDLfqAwSQrJnSGlqu7fTig9CPq61FF4vHJf9zmIZkTeRpaSl5z1UvLbUhpvARit5CaGY7M7TGW1aY9mGQgzllG5Bn17mi1x2YEXb097BdetKepVmYGimSbWnTpbjSZ/ZuHw8U+vthVULG8oGjtymkXQGb1LKtYNNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 20:23:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:23:22 +0000
Message-ID: <60543477-842a-60eb-143c-d740c648fde4@amd.com>
Date: Fri, 2 Aug 2024 15:23:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
 <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com>
 <05786b1c-cc4e-26ea-581d-3aad3b594f91@amd.com>
 <CALPaoChDv+irGEmccaQ6SpsuVS8PZ_cfzPgceq3hD3N2cqNjZA@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoChDv+irGEmccaQ6SpsuVS8PZ_cfzPgceq3hD3N2cqNjZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0076.namprd12.prod.outlook.com
 (2603:10b6:802:20::47) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: c091da32-78d8-4339-0a6b-08dcb330f492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek5BeGZtbllBNkRManhncEFneUliUkc4QnN5QlpmeWllcTJoZFNEcG9BT0xU?=
 =?utf-8?B?Uis4Ylk3WitvS29qdVdTOUp4RnEraHZ5NHhIUTQ2UVRpalYwNFFBc0hoNHU5?=
 =?utf-8?B?c1Z5aUFoa3Y2TXluRFZTOEc0LzFZM2x3TmhKZXZWeW1jVnJwdHVVd0hRZUJT?=
 =?utf-8?B?cGo2eHhDaGt6RWYwdTQrSldDN28xWTY0TE40My9KUDdnSXYvOFljY01qVncv?=
 =?utf-8?B?LzNHdGZBQTdUL2xMbUUwSFNKemJqRHptNlpmeWdaWnlLLy8xSHRnaVBzWWVB?=
 =?utf-8?B?Nm1mMUhVQkdQTlFqVmxJSm8xSUFyb3AyWksxYllGT1hkTE1sL0hTN054ZUcv?=
 =?utf-8?B?UlIzclljaFVxd3VnbnJ3UEszc0FoeldxNFFsd2pEWC9HVXM2ZkFPU0lsNlB5?=
 =?utf-8?B?cGc4VjQvL0daYXAzbVdTVjk1djVZeDk3RUlXQzBaT2FYTzg3dXJSL2J1WE1F?=
 =?utf-8?B?YW5IT1lOZkcwNXVGRnRVeWI1cGZpUkpwVE5TVC82RkFYcldmL1dvZ0NnYUwr?=
 =?utf-8?B?WE16bkJUcVYwdU9ZcGFwUTNDai9wQndROWJlS1dCUWw2V25qQ0tjMlVZUHE2?=
 =?utf-8?B?Y0czZUJoQ2xQaE9SeUs1TkJkSk9BeitHTkE2RkFwN1BFT0lBaWxxcEtEdm9m?=
 =?utf-8?B?dkxjUXhWdWtUbVozbHpUZXFjMks4Z0ZROG83S3ZTN3JrbG5CKzNKYm5Hejgr?=
 =?utf-8?B?SjRLbHpPbUdNd3ZORHl5VTY5eDdFRlJGT3ZaSk9tVnNsYmhMVEF1RUx1b0xJ?=
 =?utf-8?B?TVJabUVYeTBMVFZ3V1ZOZjB0TU5WNWlDc012bGRiTkF6U3d0WkV5aUNpMXVh?=
 =?utf-8?B?S3NMZmcvUytHR3YvRnhZOGhuMWdoaFdFZ2lzbE51R3gvOGdJWmowODdxWlpE?=
 =?utf-8?B?RjdQOFhxWWJRYXB6bHZNQ1htN0VnSDBsblVkUDA0bkt5ZTNwMUZrbDNCb0pu?=
 =?utf-8?B?Vm05M2ZQZ0dOZWVaRGgrb2hobE1BMlNUUFRneUZCU0c4MXM0YWZvUHRvZTJq?=
 =?utf-8?B?bnJlNTd6QXpXNW5wbDUyU1gyTS9PNHZ1T0JqY3VYSUY4VC85SElkem9DOVly?=
 =?utf-8?B?SWp2VUVaSVBqNTZMY2wrOVlQZ01KZVo4b3I1cmVydEowYVhMb2lzc01ReGJa?=
 =?utf-8?B?Rm9weHlTUWRWdXRFcWJZWld4SC9qWFBDbjBuanFEMWl1QWErcTdBTENmM1Ra?=
 =?utf-8?B?SG5FZXpvcVFZZWladnN3VW41aThjczRWdXBlMEdtK2w4ZU9IZmJxSU5ZU1FN?=
 =?utf-8?B?SEpyTE11Y2dpLzFCUUNmdGdYR3psRkN5UWV4UEs3M05ESWVPS0dLUk1ObS9z?=
 =?utf-8?B?SDY3bVNiU1c4Nkh3czQ3aE1WMGV5bmtRWWFVYnRZc3dyY0MyVS91ZFBaZXRM?=
 =?utf-8?B?V3cvbSt2b3gwTXVwRU13WkV4QzFBeTkrM0ZGRm9lVEd2WVNRZ2tBV1pkcXc4?=
 =?utf-8?B?VXIwUGQ4dmFyQ08yUFlGUFRCVDhNUkpMZWV6bHAxR2ZNU1VIL0FqMyt0TStH?=
 =?utf-8?B?cER4bTNvMXJhSE9COVNZQTBCSitseTV3UmxTb3B5eUF4Z0R0VDg3SjJXOEZ1?=
 =?utf-8?B?eUxoYVZOQkJOeDgwL0FhKzc1UDVnblhjdDBMTmFiM0tHRkRCRTZkdGZBR2tt?=
 =?utf-8?B?djhnVk5OdnoxK1AvbVpCY0dmWHpuNHJVeEIyTjl5cUs4ZVpsaG1ZOW1EWUJo?=
 =?utf-8?B?blgwWU5VRlJZb2VwQVB3OC9rNDk3dnFKd3RtbXgraUNTRjlUK0RsRjFPcTBF?=
 =?utf-8?B?U2J1Znl5ODNHenA2OUJJWGQwTGxGWmVMU1prL3pGa1UvaC90Q0dVTVJlTmRp?=
 =?utf-8?B?WSs1UHRrUTc3R0Vjd2VTZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3o2T2dEWGg0RVpyK0NHNlBNcGl2M1AxV3Z2aGgvVFpSU0pLbndFcHRxOUpZ?=
 =?utf-8?B?MTd4QUc4Wng3MHdnblBvNDZ4d1hXaTBlbnArQlZCUHNJYVRUbjgzUHdhRUY4?=
 =?utf-8?B?aC8vMHRnRTlhNzF1bk9vaEppMTVpTWlIWXFLSy9HSmtOT1phYklaT3VGQlJq?=
 =?utf-8?B?UXNvekJzRE9hai9SdkdrUVFWOHE3RVY0eUhKQStOTk1VOStJNUxYQmM3Wm4x?=
 =?utf-8?B?T2ttVzVqY2h0SEVnS3AvR0NNNkpNSERISUZPZGtEQWQwdDdDRWRwVnBGTkVu?=
 =?utf-8?B?c0xIR2wvemVvcE8yUmRtN211RitJUjc5bUhYTlNXYnRud0gwR0h3dC8reUJO?=
 =?utf-8?B?KzdEUkwwUTVrMVE2bjUyMlBIRnpiek93VjNxanlPSFhtMm54RmMyOXpxUFJm?=
 =?utf-8?B?YWQvd091WHl4aFBPTDM3VHVVS0lZWWRCdWx6enJXSWdzM3dWS2dhQ1pBVkRC?=
 =?utf-8?B?MnZqQ3NJMkRCRVVCQU9HYVhUNTJaWDFrK1dwV29KR05BT09GUWJQRHJXU0N2?=
 =?utf-8?B?dXpWVTVtckgrMkdwYUpQZ2UycmRMZWkrN1BLWlAwemVrMGN3Q2IzMjNnN2R5?=
 =?utf-8?B?T2Y5N3NHZ05MWE5iaHNMT1dpb241MklyL3ZJRFR0NERvRnBRVExMRThTYm1O?=
 =?utf-8?B?Ymh6SlRhMlp6clBMV1EvT0hESTFGdytWMHdmYzZWdkJHOEtjalVGUHJXSXVP?=
 =?utf-8?B?dDlmakJPVnNSREN2QmNydUNaQTJQMzFLWWE1Y0s5cGR0QytKRGZCRjVtRk0x?=
 =?utf-8?B?OUQyYzNiQ0ozRVZWcEFyVTI3dCt2NWMxUDd4UDdKejZXbGZrT3NOMTV0ZG5Y?=
 =?utf-8?B?WjlxdkRnS01ETlY2S2FnTVFDVmNSVjA1a1AzV0FoNVpCMHBCb0REdkJxbUIw?=
 =?utf-8?B?R0NKRFNrU1EwTS9BZXNyZXI2ekxBMmVYQkwrcEswM1A2My9wZlczZTVPeDJ1?=
 =?utf-8?B?NEMvNmI1WDVqUVAwNlJCUTBrZTJNWDRNenZKT2ZnRDRGN0JXazM4OXQ1eDA1?=
 =?utf-8?B?TWV2VElRMWxXVUpaMlhteHk2cFRnZGJLdFRpaFdXSVFlUVNwZ3JWaDFPY2tn?=
 =?utf-8?B?bHZxOFJpMHZFcUNPSDlkQlRRMC9qRk1NQU5zd3N6UG1vUFRoaW1QekxHcVk5?=
 =?utf-8?B?MFhSZS9qVys5M01YMDF0OHVHeVg1amo4L3RhcjJWQVE3NE9wM2JWemxxQldK?=
 =?utf-8?B?U1BveHI2Y1lna1FsRmhhZXE2QmM5RGRLWmhkQ3BXekJSKzdLSVUxNytwMFdN?=
 =?utf-8?B?VGk0UGNrc3QwNk5adERyYjJZQXZuQmRlVDBNSkpOWEZySU5kUStYUERHZk5K?=
 =?utf-8?B?d29xTGNTeUxacWZzSFhxNHZhakU1SWJxQmp3NHh5dzBoY2QzaXFicHI2enNS?=
 =?utf-8?B?M3U0aTVpRzI2Mk9OU0cxRDNvS0pwbC9MbHZ0bkNJUkZ6aUFRSis0aTNWU25n?=
 =?utf-8?B?WGtya3lJTElYYTBFb3B2S1FuTVBkemNObTFWOHoyNEc2L2tUWHpxU1Nqdm95?=
 =?utf-8?B?Z01CN0ttcVYzcXFPRnJWaUc0ZWlmUERWSklmS3k3VDVxWTFxbkpJN3BHTmFR?=
 =?utf-8?B?TGFnbGRUeUZsT0FlNWkyaVNDTmVOU2RaNTJOZDhXUzZqU0dQSUVtSHo5QTNx?=
 =?utf-8?B?enA4U045Z1ZvNTdhMEJha3ZTdWg2U3JTSnNlVXA1K1JEQUVWTDlDd1RGZy9w?=
 =?utf-8?B?Nm81UWlUVzVsa3AxS3NWaDFiWjVkUmo0ZmFNNTAxd293SUw5L0dlWTBYUFVG?=
 =?utf-8?B?SDBlRU5qMkdpUDNZOGw0VmkvcTg3c1RJeWtsN3dFa2h4bkJhOGhTdDRzeFZY?=
 =?utf-8?B?NjArU3ZHc1NqblhKeUxIRzFkU29xNm1zRTJnKzhNVFc2am1SemF2Ym9zdFJH?=
 =?utf-8?B?RUNKUUFSblFqL3VEQjBmaW0wMHhkZkNOQy9YcVNyL1NrK0pzL2s1NVUvdXNW?=
 =?utf-8?B?R0twRVBQYmpTQXRhWWRpR2RHZXFyYWVoMDQvWHlNWTdhK1FmOFNrdDc0ZUZD?=
 =?utf-8?B?ZlBSK2tsQXJxY2tFeTE5eHkrc0hZakRTUDUybEJXZmYrOGVnRkRRZ0Vacnhm?=
 =?utf-8?B?R1I5VmIvOVlvTUtFT0oxbUJqMWxUTW4xalRMTHRBMmlKRWY5QTAwRk41bVJt?=
 =?utf-8?Q?WEbo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c091da32-78d8-4339-0a6b-08dcb330f492
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:23:22.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nzdGHGAvkdhrJzvbe0oNK5vkPYuiGDfvKrMWDH5J264199T+aTM235CbD+VQTLL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

Hi  Peter,

On 8/2/2024 2:13 PM, Peter Newman wrote:
> Hi Babu,
> 
> On Fri, Aug 2, 2024 at 11:49 AM Moger, Babu <bmoger@amd.com> wrote:
>>
>> Hi Peter/Reinette,
>>
>> On 8/2/2024 11:13 AM, Reinette Chatre wrote:
>>> Hi Peter,
>>>
>>> On 8/1/24 3:45 PM, Peter Newman wrote:
>>>> However, If we don't expect to see these semantics in any other
>>>> implementation, these semantics could be implicit in the definition of
>>>> a SW assignable counter.
>>>
>>> It is not clear to me how implementation differences between hardware
>>> and software assignment can be hidden from user space. It is possible
>>> to let user space enable individual events and then silently upgrade it
>>> to all events. I see two options here, either "mbm_control" needs to
>>> explicitly show this "silent upgrade" so that user space knows which
>>> events are actually enabled, or "mbm_control" only shows flags/events
>>> enabled
>>> from user space perspective. In the former scenario, this needs more
>>> user space support since a generic user space cannot be confident which
>>> flags are set after writing to "mbm_control". In the latter scenario,
>>> meaning of "num_mbm_cntrs" becomes unclear since user space is expected
>>> to rely on it to know which events can be enabled and if some are
>>> actually "silently enabled" when user space still thinks it needs to be
>>> enabled the number of available counters becomes vague.
>>>
>>> It is not clear to me how to present hardware and software assignable
>>> counters with a single consistent interface. Actually, what if the
>>> "mbm_mode" is what distinguishes how counters are assigned instead of how
>>> it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
>>> "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable"
>>> and "mbm_cntr_group_assignable" is used? Could that replace a
>>> potential "mbm_assign_events" while also supporting user space in
>>> interactions with "mbm_control"?
>>
>> If I understand correctly, current interface might work for both the sw
>> and hw assignments.
>>
>> In case of SW assignment, you need to manage two counters at context
>> switch time. One for total event and one for local event. Basically, you
>> need to calculate delta for both events. You need to do rmid read for
>> both events and then calculate the delta.
>>
>> If the user assigns only one event you do the calculations only for the
>> event user is interested in. That will save cycles as well. In this case
>> "mbm_control" will report as one one event is assigned.
>>
>> In many cases user will not interested in both the events. Also events
>> are configurable so users can get what they want with just one event.
>>
>> Does that make sense?
> 
> I think you've confused soft-RMID for soft-ABMC. Or more likely I've
> confused you by not using consistent terminology.
> 
> soft-RMIDs are simulated by reading the counters of HW RMIDs
> permanently assigned to each CPU at context switch. We found the
> context switch cost of this approach unacceptable.
> 
> soft-ABMC is permanently associating an RMID with the local and total
> counter-pair that will be automatically associated with it when it is
> first loaded into a PQR_ASSOC MSR in a domain, then using the
> mbm_control interface to choose which group to associate with these
> RMIDs. This does not require any context switching work. This
> technique is specific to the behavior of AMD hardware.

Got it.

I assume you have not posted the patches for this yet right?

thanks

Babu Moger

