Return-Path: <linux-kernel+bounces-341800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19F988666
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36641F23E28
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553219C553;
	Fri, 27 Sep 2024 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zTzAusyy"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F01779BC;
	Fri, 27 Sep 2024 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444450; cv=fail; b=MjiMUpEgzYRZtDjjXNy1iu5zcz6Chkz5kV+Zs/uqUUxNgwHkwP6PsXsyVNNnTjm0/ZiAnJlj+nzT+QGOKDsYIYvSjqzeCGQlMA6+k9Sze9mvQpR3g5+VUHkZCXJItkF+N50+gCxL9I/GSYqS02OVjxFdKzWWbs3ZwmWeC/ufS0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444450; c=relaxed/simple;
	bh=+FYTs2R8J/RFX1MFG61h323w/wdr1cWQImqNM3DyvjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CnZkqJhs6/PeOQLJA7kTf5FUlVnIn0ulI9zd2j1mtRyPUMNohN0A6ik6zrIrVsufsqif0AzLHQqb9uDmwXEwS3RO1NbuKWHKykwDFrfkSJZWMIYTvTXamwl6UIQQn/ueGyahtKMNnPacRGO0fJlrnCvAzgCLlNyHmhkUsZD1qaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zTzAusyy; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQDqNoOtHaWUaLqNDupeBLPcIch7Kpd5Htcd/X5XpCQz4u69Gxg6FuDEojsJZd5WEh8rdPT/Q4kMTtvcDVjmofoDP6JrYdjDcuATLRAcAEHs6jQv+ML65q/FtAWjIuXrO16TTVkJJ8bKDDiPdIPs5oPwenTOgdi5LWGmg5qdtSigE9DJeFCZm2sBa2Ut7Du1OVtgVgDW3ccZgA5QKrC58RgVi14QTqylWZdupQUq2tmYBj3PpXNRavpSZ381v2yd5F8QV/UjbDyIMa6CBFhlAgMPWnKHMPZhhrOprPYxC/1x55HrP9Rrm/WY3Hi6YzFx5VcINy8Qremp/A/iYpshwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAKfBOOIQRW87OXLKeCDTMs/TiFZqYkdRYvmSS6QP2I=;
 b=uYP7KOk3QsWsiej4AePFWev0wvr+ohjmUjkiWJfsYwtvIbUW+v9MxX3NZTUc3s8qjCug3wmdzSulFkTkwaZuhuFq6I1XuXgMdErODJeyNvJxoi+Y+bM2nxCIuTQdoKjLNSIU1TGhgnZn7LMITIXPEAnH523NIM0wmi0+sAK9U9fQiqGTd+vErpEm//I98UhbmTnoRzLfd+ocwikoptzmDAJxcxX/IHOrOZoA+UO4broHnWYGUSASh+C/BMYb/mlAqaQJ6K8g1fMwqaezSDi8F6BVbM4e9Rs35E5OQm451ISdgLxavQA8+QzTv8poJrWZn8ZPkzMSw38YPPD/Ck9VXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAKfBOOIQRW87OXLKeCDTMs/TiFZqYkdRYvmSS6QP2I=;
 b=zTzAusyyp4dvOxgcxHYAQTwApG/V2e3y/Gl4gBwfHnquQ8xC6ys78I/U1dBRrNPEopGDY/8OHuoLISTLmDpF+FMtVKGK5mVnE7+MoFGMw+IcwNSHG7ooKQZ8/yuzjeW7Lvq+gPRq3Fs1mawySt17hpEx49iZoK8vTXU8/3oQZBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 13:40:45 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%5]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 13:40:45 +0000
Message-ID: <c99c6b36-2618-4ca8-c716-e553637ddc11@amd.com>
Date: Fri, 27 Sep 2024 08:40:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 19/24] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <1c5b054d8fbc3f7ad22c686d0d5e21e6573187bd.1725488488.git.babu.moger@amd.com>
 <f5f61804-3743-42ef-83ed-6c198c4eef74@intel.com>
 <3734ee4d-f0ab-41b1-8f5d-42642760da8c@amd.com>
 <eae45121-e0bf-4076-a189-948531b89374@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <eae45121-e0bf-4076-a189-948531b89374@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:806:127::10) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc38590-4b59-4eb5-14b5-08dcdef9fd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCtGWFRneEUyVkQydGJ5YXRIQjRGRWNLK1JpZmhtcGdrNXNtUmp0Nklramtk?=
 =?utf-8?B?OUxTZGpMVi9QaHk5Rzh3d0xKOVZaTUdyNVRNU3pMTU13bVVhU1k5bU9uZ0tm?=
 =?utf-8?B?aW11OUFMQlJpZ0JLemQ5T2hBMVd5Qm9XTTRlMXgyaFJ1MnpoaklHbStzRk55?=
 =?utf-8?B?Q3NaZVlBbG0yemtFMDN6bmUwRDFrNmNZTUJUc1ZHVWZYcldaK0h5YVJmS0lM?=
 =?utf-8?B?bU9YZ1cvRW5NUUM5QUdGQ1d4WWd3RGJyVlhzbjI0a01BVVIzUFNQemRtMkRX?=
 =?utf-8?B?RTNqR3pGYUl3aEo1L1k4c3pQamt1TmthcVVLY3RkQytRS1ZPQ0thekRKZGtp?=
 =?utf-8?B?M29TbnBNMUswMXE3Kyt6MGJCd2JyeWloMk50QzJhNDhxdHRTZ3hJZStldGdz?=
 =?utf-8?B?YlNKL2R5S0dPekFpek9MT0ZaVzM0OHFZN3NyTmg2MVQvNFh4MEY0RnlxYmxz?=
 =?utf-8?B?OHNTOVBOSjRlWnBsTVF2dUxGdWtZWmQyUjQwRkdJMXErK1RjcTMybCtNc3Qr?=
 =?utf-8?B?VEVNaHQ5WU01OEhvZlM4VVhaOUdFVUFZb3p6RzRnejB4cEV2aXFrL0ptdHY1?=
 =?utf-8?B?RXRCbGxFL1hDN2lZRVlOUU9zUkp0K0t6cU5XTjZERWdvYW1zelpxdjdueEQ2?=
 =?utf-8?B?ajNxamJBd292YS9CeVh4QTd3S2NkdTBSN3YzVnZEQ3YvOUJEdkJLdVk1Z0F5?=
 =?utf-8?B?M0hCWEQ0Z0xacEFiY1RUK0hRME1GZFJyM1hROHRKOGxreTdBK2tkMkNCS1k2?=
 =?utf-8?B?a1JCSmdtZ3Uzc3owTE9YYTVVZVFTMzN1RkE5dDNFR2Y5M1R4cXp0MmMzeis2?=
 =?utf-8?B?MjNCMUFMRzR3RDZGampaVW40QkQ1bHZpUDZ1WUd2TE9HRUpFTnAvaFdwMmgw?=
 =?utf-8?B?SzRCTnAxUW1QLzF3Z25XbWtWaXUySk5tNVIvYi8wQXY4Vy9CaUxLTkI4OVFN?=
 =?utf-8?B?MjAwL0tKZnppTUpEdlB0dXVoM1daSnVJam9CZWpvOFgvajdQN1RmTEE2dUlv?=
 =?utf-8?B?R2xxZzk0V245OG5IZ3FlUDNXWUpFdks5WWRSTjZHbVFnbHFWU2JET2pEbmla?=
 =?utf-8?B?ZGo0SVliNDFHT0gvMGFzQll1R3o4SjZlTG9HbU1DYlMyVkk0L2IwUUFiL05Q?=
 =?utf-8?B?TFdMTVExVUJQRTVTblpZOWttYzVzUWJ6OHVWMFN1cnV5ck5tUGhKU2hEVFRR?=
 =?utf-8?B?NFBLall3OTB0VUpTTThOK2l1blBtNGQvNmRBa0pHc1VlbUVraU1TS1hQV1p2?=
 =?utf-8?B?V3RqaUt6NndVbUlaVXVocjRlYlFuUDcvN1RFd3R4amYxQytRVkthd3FFemFX?=
 =?utf-8?B?U1lNcVJlUEorNFdMY3d4eGo0V1FndERWNFdOTlNOZHBvODRkZnZHWUVCUlJD?=
 =?utf-8?B?WCs5KzlFa014cVN3MGVGUVYreXRrVjV3NkhwTU9jMGxoODZ0SllxTlhuVTJZ?=
 =?utf-8?B?ZVc3dXRDZTJ2aGRudys4UzVwLzRxUUYzTTVzM2pzWWZvdWtqZmZuNVpLbW5O?=
 =?utf-8?B?YndqYnZWTnZQS3pJc29OMGJTZ01Na1FEZHZZMC9ORzZYL1pIcWZFZm82NHJQ?=
 =?utf-8?B?UHV4ODY1VWU1UkE2NGR1eWZWWExwdGJCZTk2TEFKZjd2cGdXQ3NlZGNnZ3lE?=
 =?utf-8?B?UWRxTFVza3dVb2srT2pNWnZUNFlWWVhXeFRMMzk1c3d6bkpFMDRiVFk5c2da?=
 =?utf-8?B?M2lJRkhESEJDSkNRdGZxMGFRbk1QUWlPdXdCaUFjUzdIUDNSelhrTDNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3ZDODVpMHdnczdUSEVla05EemNHUG5QdFFLRVVVU0pxclV5Y0tKWmkzTk1P?=
 =?utf-8?B?RUxPZDVWNmhwL1NvQkVNeU01UEpTb29nRDhnUW1DeEhZZUgwVnFEZW41aUpC?=
 =?utf-8?B?YmVkeVg1WUQ3MjZRbE5wbytiQ0E3aVRGRDV1ZDlzZzFTcmpZcHF1eEJtbnNv?=
 =?utf-8?B?TEhFSXFmeXRtZ3RkTCt6YnF5ZVRKeUVFWmtNUUdqNjQyek9iZG9pM2p6RG0r?=
 =?utf-8?B?MWNXWjZoZGJQSXpYck9aZWdGbUlvOWVBR1EvSldIWll2WHl0TmJ4MTc5eTlv?=
 =?utf-8?B?bCtnMEdWS1oycmQvemQ1ekZSMlNlNEMwYzB4TG42WUpnNXZMTGU5OG9VQkwv?=
 =?utf-8?B?NjNxbVhyYTVvNGVkTVpxdE1YVWh1dFRaR1B6bHp2L1FvSkpyR0wyN04yNGpm?=
 =?utf-8?B?WmFvZ210OUM5NDVKTHlxSk5pakttbzJoaEZoTW5wSlE5MXZSQktWUnBXRndE?=
 =?utf-8?B?THRMajJaazZjbG1uQUNXaVBiVFNnVGl5Z2liWEF2Mk1DQjh4TVE2dFhGdjZ0?=
 =?utf-8?B?OXR0MVZzN1NiZTJZSG02SDh4WGhGQ2dqUEZ0blNaaFk4dW9BSWtTZTZIczRE?=
 =?utf-8?B?YW1QejVuOUprb1VvS0FNaFNPVjVzOGJpdDhaT2I0STZ3Tk5udjNpcmJzbUtN?=
 =?utf-8?B?MzNjL2Vad3lPSFU1RTFQUU80VFN6M1pLcDhVSFFXaTZzZCtydEZhcWhoeWFs?=
 =?utf-8?B?OVhOM3FaeDNjVitPYWJrcmFlR2dSa0FkLzBBSXZZaXc0ei9LbllyRkd4ellR?=
 =?utf-8?B?Sm5IKzNZd1IvTHQ1MkMybmJXMzNiVGZIQnh3NEh0SWg0ZXNydS9Xd3FzaVY3?=
 =?utf-8?B?anhhNkxsU1UrNzQzQmtCSVlxVTJrWVl2ckQ4MjR4dFJMTVRJeXBid00wVk5D?=
 =?utf-8?B?bUQxZVo1dWQvcHNaRUk2bjV5OXpvRi9HOVZ5SSsvNWFrY2M3aGowcjJ6ejB6?=
 =?utf-8?B?MTgrTUNlOWtpdFpvSXdJQ2dtaERFMW1pYWZPV0ZLZVNJcURLL1N3U1NpYVpk?=
 =?utf-8?B?M0RHejR2cTFWU1E1OElua2ZENmozN01OY3JCRGtBQ0x4b1ZSR254WTdwWnIx?=
 =?utf-8?B?WGxaL2orb2pUNjhndk9ZK2JvN0JDM0NMSWtkN09IM01LNU5XQng3cnd1QVJ2?=
 =?utf-8?B?WVZhZ3A0YjZxcnN2anlMcnhxaUMrUFRuNTh6T0lPN0dKcXllLzBZdkk3dUVa?=
 =?utf-8?B?ZHpQQld4WExXNzRTWGErMlk3SVJGYXFta0prYUx5eUV2NGZNSkViaVBrWnBq?=
 =?utf-8?B?aGNtbGtEdnhnRmNwYUZ4M0VLZ3NuR2dQN3VpM1pHWms3aTBDbmxQWGx0d0U2?=
 =?utf-8?B?NmFMN2Q0OXhjYkdCd213dGZNZkZGMEh3QWpveTZYNzl3d1BEcjBxRzZCSTEy?=
 =?utf-8?B?TEd2QStEazY0SHdMQzhuQUFDaDN1TGpvc0VHRkFqWFJCWVpjUkx2MG9BOFNE?=
 =?utf-8?B?YVFXb1hNM0E2YkpheDNnb1BseDh3MlNYbDBCU1FHaWtwUlExRllMZzczSzJD?=
 =?utf-8?B?QjlSZ1NFbDJpZk1WRmp4RzliWmtRN1IvSHR0STZCWUlaOXVjcGVERWdhcGsz?=
 =?utf-8?B?MjVlbnJPS0lqZ2t4dFZ6aEFkcVFsS1dBam4wRUJJUHZYS1RVeXU2bTRBZDM4?=
 =?utf-8?B?dUhYYUEvNVkwYjJBNkpkeHdWNE9oTjV6TDlFY0FjY09DTTlTZlROTC93S2Qw?=
 =?utf-8?B?UytKRjlzSnhqbHpMb2FUY3dqODFoZFV5cCttTzNwc1BFTmViR3dVWkpub3kr?=
 =?utf-8?B?Uit1OVduTHlEWjVBMHE1dFQrbEh2NzJVblF5VHRuTnZ4bDdBT1JqNWdIYW5G?=
 =?utf-8?B?VkFES3dsaEJ6VWJUNUZUaXhLTlJLTXhMbFc4L1k3N1lUdzU2Nm5wbTUvRFg1?=
 =?utf-8?B?VTVpQXRuOVJEQTVJNk5vc0gxTC9zUVBRblR4ak1hNk1YNGMzelluT3NZVXh2?=
 =?utf-8?B?ODlrdTFQNmFuaTdvZGYwUTg5dm9DN3I4Q0JlL1QwQlhsaFhIRGN3dmVTbUtR?=
 =?utf-8?B?L3VLRXNxUUFNSWdQcHpxYlFuTkdlblhEV0Z6cHZUa0xKaGpsNFdUSmlhdisr?=
 =?utf-8?B?ZGRwQ2NRQ3ZSRlZLVThiaERoL3B5b0prc1FRVWpKZEphcldUc243N1JWTXRP?=
 =?utf-8?B?bU4rYnRNQ0t6eG42ckx6RFN1dWFDSVNBQ2xldHhIWnJSbFc4YlRHM3Y5MVhi?=
 =?utf-8?Q?ogC0rtdy3ZFn2K3Mv2kEUWyV4adNa+Wtpp7JCp4qWn5x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc38590-4b59-4eb5-14b5-08dcdef9fd2c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:40:45.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uULzLdBT/gGeEcBQAlq1MQfDSyA3kHeZc+9nVo7KhlkaKEMqVGYRaQIAm7N+Jvth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244

Hi Reinette,

On 9/26/2024 8:50 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/26/24 12:16 PM, Moger, Babu wrote:
>> On 9/19/24 12:31, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>> In mbm_cntr_assign mode, the hardware counter should be assigned to read
>>>> the MBM events.
>>>>
>>>> Report "Unassigned" in case the user attempts to read the events without
>>>> assigning the counter.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v7: Moved the documentation under "mon_data".
>>>>      Updated the text little bit.
>>>>
>>>> v6: Added more explaination in the resctrl.rst
>>>>      Added checks to detect "Unassigned" before reading RMID.
>>>>
>>>> v5: New patch.
>>>> ---
>>>>   Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>>>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++++++-
>>>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>> index 3e9302971faf..ff5397d19704 100644
>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>> @@ -417,6 +417,16 @@ When monitoring is enabled all MON groups will also contain:
>>>>   	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>>>   	where "YY" is the node number.
>>>>   
>>>> +	The mbm_cntr_assign mode allows users to assign a hardware counter
>>>> +	to an RMID-event pair, enabling bandwidth monitoring for as long
>>>> +	as the counter remains assigned. The hardware will continue tracking
>>>> +	the assigned RMID until the user manually unassigns it, ensuring
>>>> +	that counters are not reset during this period. With a limited number
>>>> +	of counters, the system may run out of assignable resources. In
>>>> +	mbm_cntr_assign mode, MBM event counters will return "Unassigned"
>>>> +	if the counter is not allocated to the event when read. Users must
>>>> +	manually assign a counter to read the events.
>>>> +
>>>
>>> Please consider how this text could also be relevant to soft-ABMC.
>>
>> It mostly applies to soft-ABMC also. Minor tweaking may be required.
> 
> hmmm ... seems that I still have mostly the "soft-RMID" model in my head.
> 
>> How about?
>>
>> "When supported the 'mbm_cntr_assign' mode allows users to assign a
>> hardware counter to RMID, event pair, enabling bandwidth monitoring for as
> 
> hmmm ... so soft-ABMC also assigns hardware counters?


It does not have hardware counter. I need to change this text.

> Also, we should aim for generic text that will cover how this may look on MPAM
> also. Considering this, it may just mean to replace "RMID, event pair" with
> "mon_hw_id, event pair"?

ok.

> 
>> long as the counter remains assigned. The hardware will continue tracking
>> the assigned RMID until the user manually unassigns it, ensuring
> 
> Please do double-check all usage of "RMID" in user facing interfaces/docs where
> mon_hw_id may be more appropriate.

Sure.

> 
>> that counters are not reset during this period. With a limited number
>> of counters, the system may run out of assignable counters at some point.
>> In that case, MBM event counters will return "Unassigned" when the event
>> when read. Users must manually assign a counter to read the events."
> 
> "when the event when read" -> "when the event is read"?

Sure.

-- 
- Babu Moger

