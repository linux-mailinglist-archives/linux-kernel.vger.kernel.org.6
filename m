Return-Path: <linux-kernel+bounces-364314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45C299D1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448C01F24AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5821ABEC9;
	Mon, 14 Oct 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n/+qHvQn"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EEF1C8FB3;
	Mon, 14 Oct 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918982; cv=fail; b=hWsZT57kzI+T0kJRzVkLtvkXlGEoXgv3dAPj87Fupofb2YrMhTM9bjLSqsWAA4jcRKFFDGkGdxx2lMU819KIVFxByiYDK0vQUuUlCYn2lle8y1KRxj3oKZjhc2EztKFd9I7/Hm6pi62qa9jjYuo7I9Ky5xlP9FG2uGs5HBQDZHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918982; c=relaxed/simple;
	bh=rJLiD+Hbu2zY6IlLUapuGqTdwzBAOBi/VTKqu5Nbenw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sh6NrJmLzrWHndUJ6J3j9xSg1fVE1nhnaSXFJu6KNRGTS0n4wXE5c8okFaZoQFvFH4du8EUDAdUNhprWQ3bvRZWqyB06qvNx8gwwfPeFuMKrkCbVSn8vmbQRpn5vkzba0L3auqT8g9eGE4pSMcA3fTyZ1m61R3OS1JiLNq41iRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n/+qHvQn; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHNtWKrw2b3brzUlfEtzaszHhHzEgqvx/D7ddDZj+bpb8piV9ZLAWE1itsi1wAxzyj/Gw/aPUatK7aQcmK2F3vjWuuepaVAhlVYtpehGrGaz8u3zzG13jOPsZKRmeCVM62/TcBLaANmY6Mpf/YWg0nmDIbkvoX5vwsR9VgB5KRrvHFueDCKzsnredlmHONSkB5gD8ARE7PKGBwhYMNR2Iu/o2KiwqASlSn/vaHnR5j3e7DTwiZ7zwTE/rsK/lDdwioLZCeEAOeQ5/4TynuRb3gZlDjIJkDu4teqsIJomAxnm+7sAJUDcVBIG3TRl1Byb5wJZVpkgE+qlzuJVzm0OEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emNxCZB0tkw7yZeoh0zLABh50At/0nxbT08U2BZ0+/w=;
 b=fJ1dt2GXsvogtslrZXlDhV1/l8CBJ5CuriR6Iw/Ty+CyGfLSQkMpuMN14MhctOqI6vDL1SmlIpDvlQMx8dMtMQPy30jFAGsexYr/Ww/f3xPCiuebLuZwEg5pzk+FoqpQShMPu2wDZtFwHa/u2l4veO8TcBDPwIn0W6wITvn2T5g1C68SGQneAw3V8cVZ3tBjBR0cxRSU1G4xSEkaaqNY998QC4ZQLTPT+xpiOZ8J4zmhJP7kZ73EK0kubMQT8dY/ofJAuN+Qip/0pUZJuzCLGHZTM+Zeb7r1lG1yf/wBN7hsZak5Il/EyaUSa/xrEyl0DvcxuIvjvIR3qna4NCirjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emNxCZB0tkw7yZeoh0zLABh50At/0nxbT08U2BZ0+/w=;
 b=n/+qHvQn/YyFQTTSv2O2t3khFrTGoBROOc57CaJItVfVZ4ovsVK+tpSPE8RATvc7Z24sAPlcFrYYBf9aNVm2LsrlOsnj7uas+GH2JXmkXp4cTjloxDyWKsw0wpMjXZELVGwQguX9P1m76noBIvWkJp/2ERkY430uoYuYo+LGBXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 15:16:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:16:14 +0000
Message-ID: <a60a8998-419a-4263-a5d8-2defe70de549@amd.com>
Date: Mon, 14 Oct 2024 10:16:09 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
To: Reinette Chatre <reinette.chatre@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
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
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
 <4da658fa-3cea-4388-86f4-d4b0fb5f0903@amd.com>
 <SJ1PR11MB6083410D8FF053823F0BF884FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <71c79023-d39c-43e7-abc7-057864508edc@amd.com>
 <87d9bf3c-4916-46fa-b07f-c44d5295ba35@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <87d9bf3c-4916-46fa-b07f-c44d5295ba35@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8fbf64-6dac-420f-8ebb-08dcec6324b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG5weWpkd0paTkI1bUpERGk4Q1ZUME90M2JZUk5wR0l6UFd6TDYvVzgvOHlm?=
 =?utf-8?B?WXV0L0Y3a0lDN21wY0VZQjRvb3hZWEY3cCtVeGFXc1A3OEtWb0k5VzlGaHNC?=
 =?utf-8?B?a2dwUGZuclFNakowZUM4M0Z1aXYyMUEyZjdvbXRTYzlISFJyaDNrTWppSnZU?=
 =?utf-8?B?NU55WEFaZkRsbWlUblVuaFVSVWhIc0d6S1VKeUxwSFpHajhHRTAza2hpZ05t?=
 =?utf-8?B?cVdRN0FYbDJiandNTllBdXpQVXhKWnduMlRkUXFPMVI0RURSWlBpV2ZJTG10?=
 =?utf-8?B?bkVHaCszUUMyeXRJbDAvYWlVbkE0WVZ6WnNKOWVPdk5OOUFSaTZ0N2pDRGhO?=
 =?utf-8?B?NjRONzVoMS85N0dZdGo1bjg0UlNTblZpWGtoWHBKTXJiZTdCNzJjL1A1Zzd5?=
 =?utf-8?B?SCt6a2l3UU0rUTZnejBSTWZ1TmpjQUhYTllBdHNzZFlSUk5Mak1nMUE1eDVX?=
 =?utf-8?B?L3F2bHNQOVIwUEhyVmtJYVNGaDJiVXZFVEFpd0VWS0Z6LzNTaVAvcVNKaXZG?=
 =?utf-8?B?NXlZaGIvMkxlS25uMmd3bkhxSW9kNlJ4T2hIK1hRSlFDUDRHWStGbENHNDV2?=
 =?utf-8?B?QXJPMzR2Z0E2WE1nMFRyaGZpYnYxMXdXc1ZzeExQV0dIVkt6T004RW5lMjZM?=
 =?utf-8?B?OGhEWGM1MjdJN2RNQkVkZVFRdEhpZm9tZ1F2NUI3aHNVTDZQc2JzeUNOUC9X?=
 =?utf-8?B?bDBGZHNMY2hZT2RUWTZXRUJTL1BsdTJ5bURQZ2hKSklHaXlPN0tqbWtsZUZS?=
 =?utf-8?B?YnlHTGJrc3QwdVIvL3I4cnRiZkp0VlRuUGxoNThpMWFnUmUvNy9uMWNsWjR3?=
 =?utf-8?B?b1Q5ZkUvUUUyaFA4bDVKUnlJSi9tY3NEd3BHQ3J4TzRTV0ErQjN6TUxXMkVm?=
 =?utf-8?B?emoveGZ0bnkwcENMRWJFdjJweG52SnZCdHZtWE9jcGFNRGx5bXJhMm1UMlQz?=
 =?utf-8?B?Nk9Qd2VkbkJSUURDM01OSnBlNXZPbEV4UEh1YXMvQ3pTTDdFbEhMUDg4M1R2?=
 =?utf-8?B?eWQ4UkFWYlRGQkJCRlZCT1NERUEwT09Ba01iNXJ3dG5hRVFBeE9sYkhNc1pC?=
 =?utf-8?B?Y09NWHQ3dWdpNS9GWThQa0R0RWhkbzlnZmRJb0U1U2VYcjFDT2M2TUpXSEFH?=
 =?utf-8?B?bWpKcmUrOWx3bFdDYjFsZ01SVTZFU2o0TlNnZzFsSGJIYVNRUGNXN1c4Y0Rs?=
 =?utf-8?B?cmRXTk1scUxTODRBWUxxUTFPUm5FbTlnTkczSFhkQnQxTVVGQ2xDRkpWU2J6?=
 =?utf-8?B?TmNlNE5pYkVKamozQm1uejFBL1lpUk9VS0czWERRdTFwSjVZckp6aFAzazBo?=
 =?utf-8?B?Sm5UTXZ3Wlh2d29KNzdEK2VmUVkrTnJhUGsxVWhLenI1Tnd5WS90dS94ZFVo?=
 =?utf-8?B?RjNscUVUWjRsOTNxVGNGSDRKT05RM1NIa0dnY2FjNXViQUFVVzhTWTZwZU9n?=
 =?utf-8?B?ZTh4WmFReG1DSTUrZnVuUU9kamU0OHBrZDhON2V1RThOMDhra3lNejJnOUdi?=
 =?utf-8?B?NmpXVmhLR25lYkUrY09JejFHWDVkc2hFS2QvNzZJR2VxQiszNGNKaFRMK29n?=
 =?utf-8?B?YTVRd09Odkl5NUZUa0pPQmxJZzBtTWdBVmVneGdGZjZHN25qZnN3NnA0dFoy?=
 =?utf-8?B?bll0R2pWT2J3a3NWMDIrNVBEcnJUVFhiN0ZKWFNuOGNZdHRCSkx0bzYyajVi?=
 =?utf-8?B?VU1QRmlQT3p0WHV5cGhKWitvYm9XOGE2bnowTTZaVmhCOVRHU1dQbHJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckFjVUExQm9RRUNtVS9FN2dpSTBidXdybHRKOG1yaG0xakNDZUtYaHF1RnlP?=
 =?utf-8?B?N293SUwzQjJuMWZEZ2dKWlpqUVJNenJ2UXIwYXBjYWFla3MvelZQeVlQdkZv?=
 =?utf-8?B?UkRZeDRsb3JvcjNmUXZwK2pGTWRxdDRENTN0blorYldPc0drZXVzWFBIZEJE?=
 =?utf-8?B?ZkRURktOYWJHcTZtazhiWGVUdXUyYWhOQzU3MzE1UGNja0NZU0FOZTFpK1Nm?=
 =?utf-8?B?Q1lHTll2d3JHQTVjNVRQejlDbnYwM1MxSXVza3JwQk0xaFdNTit4MFlXVzhQ?=
 =?utf-8?B?VHg1RUtRRlZZTmlncjNjU1dhNlBvMHpPOFdFY2doQ21Fck1jelFEMk5yV3lr?=
 =?utf-8?B?bUZWVXFRV1pacURtcGd4Rk96cGtrK2VxVHJvTXovVWI2V081WVA1MmcvL1V4?=
 =?utf-8?B?WkVZZE1MWVJFc1VVYWFYdnVob3pNTE5vcGFuRzhmbWJUS29vNHdkc2VWeU94?=
 =?utf-8?B?eStKZTEyQit1VnNOaXhZRGhKbUlZWEczT1dxcUY0R0xBRWRMRTFYdHZxaEdi?=
 =?utf-8?B?Q1RmT3B1Mis0S2dGNHhNR2syK1ZaQ1V2VStPR3FRS21abmkyS296c1oyTzlp?=
 =?utf-8?B?aFRUczUwSTJCYkplNE1yN0VNZlQ0LzQvZUFTd2pBa1VjSEZHWS9KRTlKNVZ4?=
 =?utf-8?B?aDlOa1dYZTV5NDlHbHRLRml3alJRVTRiUGQyOUVQVTN1Vm1pTjNXMDhrQlF4?=
 =?utf-8?B?OENyckdmTTVXSCs4OEhpRmFFa3I0MWdKdUdxSXc2NHQ4Z1F4aEJ5WE1xMGxu?=
 =?utf-8?B?b1E0U1ZsM0RQK1VRbnA4RWNodXVCbFJLU1Q4cmRWRzliYUsyQlk2c2tmOUxu?=
 =?utf-8?B?WnY1VUR1RkhQUXVBRE51NEVsT2RLMDhkYzBIRTNOdGZtTW15a0YxUnh1VmRD?=
 =?utf-8?B?OXFTNlFPMG5lRVdDRmJMZFdkNUtZaE0xOVJNbGY1cnJiMWFrMjVpMXNibjVP?=
 =?utf-8?B?ZElrcHZ2aWw0alNaOVgrT2E1YlIrZStLVjhwWkNrcDJ1WnhNbVlUa1NudStm?=
 =?utf-8?B?TmtMOXpkaVpycWxoREp5bUhGWjc3dUJjTWhhSHF5a0lLY1BXam5sU0l1cTBK?=
 =?utf-8?B?NlFHK1pWZnRBK2kvYkxNdnBoN0ZxTEpyT1lQRlBFcC85b2JwckhnRlBzQ2NC?=
 =?utf-8?B?Wll0bWNIQVRzTGRnK1ByYWRiZnBKelVhZUk0NHdsOW81K3ZraXpiSGprazlv?=
 =?utf-8?B?c2ZxSzBSdDkyYk5rM3lxYXJ6ZkR1M2dHWFZzcm5zdnpWL0FEZnFZSlNoc3Vs?=
 =?utf-8?B?UFpZcmJoRk9UaTJwZE9Qb05vSFRWZDZBcVlUOVFUd0Z1dnd0dHdvd2pRNzVa?=
 =?utf-8?B?ak8zRzVHRm04dVc3cW5uaU5DcUZrTThHaVhRM2d6N1h3ZVkzbFowTVd3K25R?=
 =?utf-8?B?clZZNWkxcFE0b2tSQ1NUWEVrV1hLQm1XeGpESDcrejZDa1dWeFlKWkhnWUlo?=
 =?utf-8?B?cjczdkI2c1V6UERVaTJwSXVzeUMyQWdvWjl3c3VUckc5NzVPa2ZFRmRwc3VP?=
 =?utf-8?B?VFpkWUVOVGxYV1dZUXdoZlV1OHM3QmczZmdhVzVucDZvNW5qY09kT1JlTVc5?=
 =?utf-8?B?WEI5T3dibVhBWExMZWdWRFhEM3ZVRWFXZ1NVa3ZNRU5iaDZMZUI3TDE1K0xY?=
 =?utf-8?B?bEt5VlF1MktFd3hoV0VGbkcvUGZpdHp4SDFRdituSklnZ21HS2RtNk5lOHdu?=
 =?utf-8?B?N3JuN2tTN3VSKy9qTTF1RFhCY1psYWRYVDBTWHN2dFcxMFEwc2pQL0pTUlgv?=
 =?utf-8?B?Uzc0MEhnZE82K2xVTHY0bm44Ui9rRldSakcvdVViRmRHNG9rTUw2bkJCalZV?=
 =?utf-8?B?b21DYWJKaHVLMExSUDhNN0ljbVdXMFJwN01sL3hlT1JaVExKeUVSeU1mNTRt?=
 =?utf-8?B?ZEwycHI4cUtLZkE2RDNpK3VCNytIV1RRclk5ZCs0UlZHT2NUdHpSbHRXMlJn?=
 =?utf-8?B?VVl2cUdDYVZqS2xSdWVjVkFYcDJvWXhlek90Q2laWEs0NU03Z2UrWDBJcDd1?=
 =?utf-8?B?RVEwamt1RHZKeEtsbFNocHE3UUw1RWc0Si9ydWdjK3M0QUwwQ25xclk2bXBi?=
 =?utf-8?B?OHVOZEFqOE4zK1lNRENwYURyWU01bkdZejJ4Rlo1MWFBLzErcEk3cytjd1pi?=
 =?utf-8?Q?sfCM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8fbf64-6dac-420f-8ebb-08dcec6324b8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:16:14.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0q2ovGvZYSqEY/YfMUwUUTWOdTo4K7f6fVJPv5a5Gou5J//IiZXl/jmmJnPJJmqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

Hi Reinette,

On 10/11/24 17:24,  wrote:
> 
> 
> On 10/10/24 8:30 AM, Moger, Babu wrote:
>> On 10/10/24 10:07, Luck, Tony wrote:
>>>>>> +  By default resctrl assumes each control and monitor group has a hardware
>>>>>> +  counter. Hardware that does not support 'mbm_cntr_assign' mode will still
>>>>>> +  allow more control or monitor groups than 'num_rmids' to be created. In
>>>>>
>>>>> Should that be s/num_rmids/num_mbm_cntrs/ ?
>>>>
>>>> It is actually num_rmids here as in default mode, num_rmid_cntrs are not
>>>> available.
>>>
>>> Babu,
>>>
>>> The code isn't working that way for me. I built & booted. Since I'm on
>>> an Intel machine without ABMC I'm in "default" mode. But I can't make
>>> more monitor groups that num_rmids.
>>>
>>
>> That is correct. We will have to change the text. How about?
>>
>> "default":
>> By default resctrl assumes each control and monitor group has a hardware
>> counter. Hardware that does not support 'mbm_cntr_assign' mode will still
> 
> I think this is independent from whether hardware supports 'mbm_cntr_assign'
> mode since a user could enable 'default' mode on hardware that supports 
> 'mbm_cntr_assign'. This snippet is thus more about what is meant by 'default'
> mode than what is supported by hardware.
> 
> The docs already contain:
> 	"num_rmids":
> 		...
> 		This is the upper bound for how many "CTRL_MON" + "MON"
> 		groups can be created.
> 
> 
> Neither of the 'mbm_assign_mode' options change this meaning of 'num_rmids' (i.e.
> no change in how many monitor groups can be created) so mentioning it in the
> 'default' portion but not in the 'mbm_cntr_assign' portion may create confusion.
> 
> 
> Perhaps it can be simplified to:
> 	In default mode resctrl assumes each CTRL_MON and MON group has a
> 	hardware counter. Reading mbm_total_bytes or mbm_local_bytes may
> 	report 'Unavailable' if there is no counter associated with that
> 	group.

Sure.

-- 
Thanks
Babu Moger

