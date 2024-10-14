Return-Path: <linux-kernel+bounces-364447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4C99D4C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305DE1F23AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205C1ABEC9;
	Mon, 14 Oct 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k1n5ENgq"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888F231C92;
	Mon, 14 Oct 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923747; cv=fail; b=oHUVRcei7uomUomEU0m6nyyixbkgcDR0hNpjLy+gi88hyjID/aQTaei5KQ7JF+ILfV6TpOeiciqwxtqCxRuOBPvoAtckIel/1S3/+Flri2gSMXvJN8Ev9Pwr1Rymsr/oumICHbPEK/7LrIwm3ELKGJUVuaZ4Es+Tn8r+RpEuQQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923747; c=relaxed/simple;
	bh=eprI9eA1FNVMm2JRZveLEQIy/8a5ioY/K9dE3mpSXUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBoskEGQNJRYHKmoluW3LO5k1544qHcIkTDT1By6CU6qW/a9tVEdkjbX4BRwQ8Y8bv9+EKdNwZz8t5sSqiXY11nv19hxpVXLZRuZdJLIRt+wMmasWv8YI5vP7yraOFSzDcBt5oh8Nzn1eQaRG6tet3pr3yqVFoChfeh1BbAqPaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k1n5ENgq; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9XWdDfEHUJEgRjDTcIKV41P6mjBVNQvKglkZN7wge4L3sRdruUJG/oBioyS+XV4qISn8ieTjQsQXFQUrnuQNLjWT8PLBRD63iO4Nay/pdeBcfBhsg51IBTciCrLh9z5C53LscaN4pTCZWKIIVFdhCL+8O238eB7X0qS4r3xPyjvqWs/m5OOOt2jWE91ym7GtcrZ9/lARLb/v+0w1ay+bsxH7DcPrEj5YSH0Ate+qa0vyGpgr+czB4X5pk7Zty86zw+s8SX531ZMMJclDUb3Ohp1WIsId7wCdtzT4ZiMD6e8VGmBw0GiXLvwXuRy5nZ8sE1U2P7F+4mvhap1Hw5B6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gs7XJ7Bg0MQyCxhB3ad+PBSvz5FP4+ZefMfj4cDF1o=;
 b=YJC0czvH7QspWgfNi/1eCB9ADLyf3lzdZPl8xBupVY8FM63lt2QSOgx/YR3yfFuxPfHc4DTc0gQtPksbVxEP5H7WTpW5cjB6euQrYKIY8TMbODyMTJtj+eMYyIyHOgvF1o1yy/KJC7VhZJVOs4TnBHyALWlZ6MmUNjfVhYJist6U0YsPNzF/lczuHDIA27zLVX0JwmfKSVWTUSJ/QpwBBXIZX7v6CTyyaVEKxD8avC3c1QZL6M/GRUmsp4Lp5Rv7fy8BxXflsudCYWVm13YCvpovoA9XChFBiUAoDbhngjPkq1ER9018qO15bgrY8219NW5kVsUfprlOB0dswLKmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Gs7XJ7Bg0MQyCxhB3ad+PBSvz5FP4+ZefMfj4cDF1o=;
 b=k1n5ENgqfsqkLN+kbSsGLoyjbD/FML1yFqMwLuzpb+FAhrXtmf8diBug1hQe+ges976VuTkz7fdw9xCD1f1+7nOX6nzVa+EOvvi97BQaGWcEEEk6x71GGSoAhpNWK2MaEp3D47MgLIBWeH0kmxhw/HlxdaAtrDnP5lMehedNxsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 16:35:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:35:31 +0000
Message-ID: <a972dfe9-341b-416c-a245-0834583c6620@amd.com>
Date: Mon, 14 Oct 2024 11:35:27 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: RE: RE: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign
 counters when mbm_cntr_assign is enabled
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <43654ae1-c894-409b-bcb8-065940644906@amd.com>
 <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 0447b113-366c-4748-74f7-08dcec6e37ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkVNOGkxSEJwaXp4MHRPSmVXZHJkcTE1MVB6RU9VY05VeTA5WE0wM0I2TFpC?=
 =?utf-8?B?S2FPcGhtMUtLbXBNcDJJa2ZmN2lBZ0ZPM2pqaW9OSkRzZTNWVHdUZXBrb0U2?=
 =?utf-8?B?QnFsYWNIdFp6cm1XaGl4YXl1bHlKUFhvT3NiWG9KT0FPMkZGK2wvSFZpaXlD?=
 =?utf-8?B?TWg1MW9kcmF5NEpyWnlDVEU4TUpROGhZWDNRUWp6WElPaE9vL2pIcUlubmNS?=
 =?utf-8?B?UGIyUHRwWGM0NHgwNG9kUE1KekJJSUJ0cTI2Smt6aStaT1E1NGNTTlRoS0tY?=
 =?utf-8?B?MVNmN01rTGh6NmlpdkxNMlR6Q0NyVDlqNkQzWVVIRlhsaHZDT1hMRm5GMFlN?=
 =?utf-8?B?K1VITldoMXlHZGthalE2MWFtR3lXM3JRc2hLcHdMZDdnWEIwSEJta3dCZTI3?=
 =?utf-8?B?UkdlUTY0cmZaRG5pZTVWSE9WSUxBOEhGcElWZEt4OHpVMnkvZ1ZCWjk4ZEdD?=
 =?utf-8?B?Z08waVpVZmY4djQ5TDE1ZVhXTkxlVzkyQ0I3MzdTYlRWcDdlWUd0QXpqNGRR?=
 =?utf-8?B?d1A0TERBMVFvQnoxR0g2eU9tMGNKV1A1N1VPYXZsM0J2TGdmck1YelB0eWxW?=
 =?utf-8?B?RktqTjJxSFA3ZXpvdVJwK1dldGt0T05uZ244TWZ5ZUd1aGVYcjhwdTFhRklu?=
 =?utf-8?B?Y28rUytFcDBMazhUNmt4K1pRWDl0dGhBTmpxcXJrWC9ydWtRWmozcks1dzRF?=
 =?utf-8?B?UkJvc3hPa1d4N3BtSkxNVElIQlQ1U0t2UHRjcE5hYm56eHpOWXg2Y09tTmhz?=
 =?utf-8?B?UGE0UHk2TnNaekh1dWJwTmZjbU5EeXp6R0NTQnRQUXh4M0s0Y0ZMMXRMa1pT?=
 =?utf-8?B?c2pNZWtXM0RCZ2JTa1hzRWFXMzR6K21XQlBZRU5Gcm1ya01BMFJsbDdKMWdT?=
 =?utf-8?B?S2o3SlVJRDRCSVVObHFTOFhlcHFFbzdJcFRpak5lamVVVi96R2o2ekIrTHg0?=
 =?utf-8?B?UEtQV3VtanVHWEpvc0RwT3pnVlFMc3RRSkVYell6U3ZtQWYrKzNaMmsvVmtD?=
 =?utf-8?B?bGVyaFkvd05XalFia3NiOGhyenpHQXF4NExyOTNkamVIRWV0OUp5c251aWRz?=
 =?utf-8?B?YkdPU3FYVGdSeUNGb2tXbVpZczd5aUpPdHNSelFmb2hVRXRsYU1FekNQRU1p?=
 =?utf-8?B?SmhnRmc3ZVBEdXJqenRrbW1nQklISjZidzNFbmx0blJGbnVLaDM2bmV6bW8y?=
 =?utf-8?B?YmxKWWlYY1krS2ducXdib043NU91RlAxdU14OWNrWXM1S1BxalIvWDNDVVFF?=
 =?utf-8?B?bXJHa0J4YXBJM29HaWRXSnUrdDJ4TGI2Yy93eFkrTlJzbUpVNDJ2MHlvVnZM?=
 =?utf-8?B?MC9iNndhMGprNFRMWFExdzlkQWxaZmUvKy80c3pBNnMwZG50UUdJMSt2dGlT?=
 =?utf-8?B?VXVEV0gzZktaT2huaXVYYTJESnQ4N29BMWlBaUorMEdQRCtLTy81ZTNxSmF6?=
 =?utf-8?B?SnpqRDlCRzdiNU5XcW1RZHV5cHp5UmUzYkE0NDdoRzlhdlA1Zk8relp4anhp?=
 =?utf-8?B?STlpS3ZnWXRXSENTNndFMUQ4Q0JhWStLdGdDa0tQc1hmWEpHUnlqOEI0WUE5?=
 =?utf-8?B?R0pxeTRHV1MvSmNrM3QzV3RqQlB1c0dQU3lGeTZKbGphS1dudHlBWjBMS2ty?=
 =?utf-8?B?TE9sOVBOOWF4bUp4S3U5OXo4aVk5N1l0UUllazBoM05TazVvVEJjM0oveUsz?=
 =?utf-8?B?WkRGVVhEdk1WZnU4c1VRazU2N0dHbHFqYkJ1TVVhMVR2eDc4LzVqbEdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmwzRmFMTWk5NWJsek0vUVBnMDdLOGd0V3k3cmRIeEJmeWRZNUFnQXN2TnZr?=
 =?utf-8?B?eW0zRG4yeVJpVXlOdEtmY3lMUm1lbUk4LzdqbnZYK3hybEtVcUdDa003SjU1?=
 =?utf-8?B?R3FhNUY3MXRKakRPalZTdjZKWjZ3R0JocXY2MDd0SWVCMkpQeEV3cFFGUmNS?=
 =?utf-8?B?eGZQSFE1VFJtSk9TaUpBQjlmaENabW1MQjhtNlpIRm95Wnhvc1pRd1Zwa284?=
 =?utf-8?B?QjhRNTZzVURNemEzMnE5WXVNQkhwOUxIMzVIZmFLMm5sN3o4V1U4SkpyNDJR?=
 =?utf-8?B?ZlZJVzF0anVGdUczam5DeVBXNFFGTnkwUCtIZkN4Z0Y0NFdrWlJXVnRyQ0Zk?=
 =?utf-8?B?UGo2OW9sVlZZQ0VTS0tHd1pSRHk5MlM1a0thYWFDMUxpZ2Znd0hIQ3lmSEdJ?=
 =?utf-8?B?ZHVNbkRVQVIvd0lMbTdXaVZQSG03a0JrUzJ1VzlmZlJtSkZNNWJzb1BvdUxY?=
 =?utf-8?B?cW5YckJqM01RblptRDREWDR3VG5SZUhqbVhaQzVMOUpxS1A1emRnT3BMVWln?=
 =?utf-8?B?TE9ib0RMakVESlRRaXl6MDY3ZjhZZGZDeGRiUlk0YXY5MUV3VVBaR3RBTEQ4?=
 =?utf-8?B?a283YzNKNVFrMkxBWWIzYVRTTFBuUVJ6QkNSbThwSWhDUVJvK0F5SXk0eFZC?=
 =?utf-8?B?cWdRRjFSQzVySkZTblZWQUM4Q2FBVDhXWk1rMDFvQWs5T3lERURKSFJ1M3gr?=
 =?utf-8?B?cllhaTI3WEdyR3ljRE9VaUo2cHplNGNrVFRCbzErRDR6bThWbmoyeGdqRk9Y?=
 =?utf-8?B?ZkNNUEJxd1R3cnlSUHpEUkVsSDgzL2VSSTM4SStuSTdXTzNNU2F4TXR1STdh?=
 =?utf-8?B?WTdUUjBPSXg5WCtadkxwYXZuU0hxWWltb0lkTGQ1VkVvRzhteGNkWVhzV05N?=
 =?utf-8?B?c3lmb0NNWVQzWG9BQW9rb2ZmRUNndG1TbVI1aHpBaUI0M2tSSUM1YzJQdGFY?=
 =?utf-8?B?RGl6L2N1SnBudWo2Y3gydUU3THRneU9DdTdrcHpKODFqb2lOUkdOK3BXZHgv?=
 =?utf-8?B?SW1VMTEvNXpGeVRiNDJsMUttM29DY0JZT0lGR1hFVHV6UjlWcWNMSW9DbS9I?=
 =?utf-8?B?NEd4eE95d3RjT3FCaENlWUtPVUdrOUt5VE1FSFl4L29zQUM3Sk12R08zZ2lR?=
 =?utf-8?B?QXhQTG9VRWY0bGsweTZPQUtFcWZJM1FLcFlUc21RQWxrVFhQRG1uVnhrRW5L?=
 =?utf-8?B?eUQ4VWkyZDh5Z21UWU9RRXZNQXVSdy94MnFtSFhSaENRMmg3bHJWMDJFbXhv?=
 =?utf-8?B?VGxRL2tpVDNsS3N6cVBLaTZpOStZRVV4b3pza3h3LzhIZUtyVnp1OVZPWFV2?=
 =?utf-8?B?YVpvVVJ3RU9WUGJhb3plMTJlVnB5WlpvR0ZPVEk4SnRBZnA5VStwUUlOZisv?=
 =?utf-8?B?cWcrLy9RRVlSU2hNbmVBRGlOckI3MlY0S2kvTjYyS0ZqTjVZcWlaV0pSd1oz?=
 =?utf-8?B?Vm1BcmlOUk5pNjFrc3c1MUdFSEVKaWZKVk5nM2liVnBGRklRL3VEUS9sa0Iw?=
 =?utf-8?B?UGtBMm9sNVJKODJzUkdWQnE4T3JXcFMxa2FjQ0VzYkIreHlvd0RwajQ3d200?=
 =?utf-8?B?UGNkZVNJMFlybHRwaXNteENEZVR3bmNvZWtGODJpNjdocFV5N3VhUE4vNVp5?=
 =?utf-8?B?OGRtSWsxNlo3R3hHUmIwUXRycDlrZVJFLzBISkk4cGgwd003dEc2ZGRVaThu?=
 =?utf-8?B?bHlDRk5PdHVjK1YvTElpSHlhVTVGQlVUcHllMFlxdFNUcWFUaEZnSDZTL1Bv?=
 =?utf-8?B?K1MxZU9jZkNIdjd0ZEVKUkxDYUZXdWZhVmNCaXhheTdZbHBMTUZFYjdla1lT?=
 =?utf-8?B?cXVGT0lDZXhpMGRoWXZlcmlUQWQ1bFlaK2lnZGhMM2lvaDVkMTJZYXlNQms2?=
 =?utf-8?B?WFROR3FqbDhnbmpuWEFQMEgzeU9BVjhuL3lvbUo2NW1sVDFSQUF5ZG84UmVt?=
 =?utf-8?B?aVFnUUdjNTJ2WEZldG1KWGt3dVVFWkMyZHIrVmtyelQvRFYzUUppTjhrcGtQ?=
 =?utf-8?B?cURmWE9BWE0wVG5DNUlYNjIvZEx3c0NhZ3IyblBodFRKQ2YxNXZrUW5uZ2Nw?=
 =?utf-8?B?TmtaVVVLUkgvWnZkMUdEL0FGdjRPb0VtYU1QU25ncGNqd2JXbXdsRysrSy9o?=
 =?utf-8?Q?zJjU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0447b113-366c-4748-74f7-08dcec6e37ea
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:35:31.0099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBNLHNcujQY9zsltgzpJji38Vt6t2mUBmhlcLQlzcaWRb0wsbd+ErhJXuGcRFiVB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709



On 12/31/69 18:00, Luck, Tony wrote:
>>>>>> +  if (!ret && is_mbm_local_enabled())
>>>>>> +          ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_LOCAL_EVENT_ID);
>>>
>>> Now this call succeeds. The failure of the previous call is forgotten as "ret" is
>>> overwritten with the success code.
>>
>> It will not make this call if the first call fails because of this check.
>>
>>         if (!ret && is_mbm_local_enabled())
>>                 ret = rdtgroup_assign_cntr_event(r, rdtgrp, NULL,
>> QOS_L3_MBM_LOCAL_EVENT_ID);
>>
>>         return ret;
>>
>> Here if (!1) evaluates to false.
>>
>> Did I miss something?
> 
> You didn't.
> 
> I missed the check for ret in the local case.

That is fine,

> 
> It is still the case that callers don't care about the return value.

That is correct.

-- 
Thanks
Babu Moger

