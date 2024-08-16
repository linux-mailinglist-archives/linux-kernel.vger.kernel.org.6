Return-Path: <linux-kernel+bounces-290293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A4E9551E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1768286533
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F61C3F1C;
	Fri, 16 Aug 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wAFd0tYc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835610E4;
	Fri, 16 Aug 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840742; cv=fail; b=oztC5b/LbGRIwhowdiRCm49gSEbc3qsd2iIkMnHG8GAcbTlb0JJsv7TldKG8OFE08E+uRI548xAJsVq01/aNxPWZQCg8xBYuUVjRk9nSxml5bEKN1zb6gFGVLjXvMqRX7dkuZTad/hn8wtBxrKNAFO1QpbfRJbfgAxsJiYw5jfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840742; c=relaxed/simple;
	bh=vGjv7AT1usjKAbG5uyYWC7vxRbPuhLO1ynU31s+QwVs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VzplXCmX8fthUCjp65aiOK+64AZHIZJriaeXhInahhC8K5S8Sgs6TIn/sNMKA7HPOmEcl43nqFPOoiqm7S0RC5EHjqEenEBnf9IxPulXPVEyD2xoEzDyo4yzjAsoy7bcX+iaBog8XeFdSAxOx5LskMDh6QI1C7P0XsCwHX9Vy8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wAFd0tYc; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmgvM3TqRlbf5zu/hHKmgBvUK8HV14xBQP9wwyackHB3CHTwNj5QZVrRKNNnnmG8Vm0gw05KyL/nWbrW5n6nJi1Q1kNvB1uXNAoahFO3qNX02qstGexnhD8cUzKLDWJFR79Hu0gVjUo/nGv096omGFUnWtypevetrqrFkV6xUD6KofHRhQbxJZipFA3lfxSE4mz9g8Ao7TWvRNjH1jjeoQkuT//7wKEaOEnarbT+DmMCuK0U2Z7a0UKZraU5r7ljfP6ZJHFzapFMk21hmaRVtPzyL1bi4jE1+ipD5tN9N3s7PqzQxlgK7VH5CzUZzWtXpptMUHJ25nreS5u4g8C4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO6BLaAaP7fMmNILhR4aj55jiQQUXgUl3RZJH0mkINI=;
 b=E9CGy79Z9cXj2mHgt7iPgZmjlyxY64qidd6T8YcIoNHp6JV7X2wxEsBN9Zu4bgRpu0SQkp2Ern9H9OaL9OHOas3U4776DfZknwXDudcJnt6Zz2y3Yk0nM4DvVTMXF9bl8wGJgkO8tcCpiVkvj8iK3FtyEd0yqhmkLce/iC899Jxi14JrCfPFU/O0xdcfd0s59XNk49dVXJ8oMOgoJEl8V33XnnFhS6AMIaNS3bgI3oXLADAJBGwoEhiMj0pNAeV2zeCJQAC8Ugp9yzJfPPoh6QbhgEH4ElU7cu5cb5BYQQxeMzFogBGFy7MQw4GBNZn99Nv42Yp1ShMMuicYpNEV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO6BLaAaP7fMmNILhR4aj55jiQQUXgUl3RZJH0mkINI=;
 b=wAFd0tYcdhcoYIuNeryahqkCaL/Kmx01Z6EEBt30btEQPBFUAAGHFjlNq/XclVruLA2iBjtI0mQlGYryE06AjpCcIE833GE8YQAS5nLmmKyla766l9VJKcJRFNjWUyX+o4ZnVb/7poQmrRvIAcpAohWPAv8BpqHLb3JZvn87JMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 20:38:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 20:38:57 +0000
Message-ID: <43051b97-38ac-4f4d-afdd-014387de4996@amd.com>
Date: Fri, 16 Aug 2024 15:38:51 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 07/22] x86/resctrl: Introduce the interface to display
 monitor mode
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
 mingo@redhat.com, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <c8503402c5dcb17012b2010f6accf00db245dec4.1722981659.git.babu.moger@amd.com>
 <b07218ed-057e-4eaa-b04c-15f7b80cee90@arm.com>
Content-Language: en-US
In-Reply-To: <b07218ed-057e-4eaa-b04c-15f7b80cee90@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9787be-3860-475b-4ce2-08dcbe3373c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWtMSzEvVnp6M1pqcnZKVTRMQkg5dUp2NFUySzJWVXJ1K2VaNXRHcStvMnk0?=
 =?utf-8?B?dUZ4WHNwK0krME9aR3ZNZ2ZycURaQ2xuMyt5SnpYRU5qR2FQdXV5aVZZNG8w?=
 =?utf-8?B?aG91YklqeUJzN3RQNjZ2WmhHcWtxYVQ0RVFtaHdPVEo1NWNYVE9kbzZYNjQz?=
 =?utf-8?B?TFpWZGhKdGlVWUc0MkFqa0dsSHQ2ZVZvQ0RtOGRkMy9nSG1sS29Gb1VEZXgv?=
 =?utf-8?B?SVpZemR4WG5NTzk0YzVjN3lmTkdOcEVlMUhBcHk4bFdYTk1EK2JmUUJJSllX?=
 =?utf-8?B?a2hISkp3eU9PSUFza3VUTms2L3lxczdGSzQ3bEw5SW54SGVzUEtHTHBtMjZH?=
 =?utf-8?B?dVRuWHU4d2FBZ3MxcVBjNk85VkdVU2hkd29OcUR3OGptRW1CTnZ5QUlqVzlk?=
 =?utf-8?B?K1J6LzN2WjRUME9ELzR3NUM3Qm10TUdTOWlma0QwWlZudERJUmtkMVdkVFFF?=
 =?utf-8?B?UEVDMWZBSnA1bW9rakRzRlcvelVOOGUvQ29HOTd3Z1VDTmVBUG40VlRub2RN?=
 =?utf-8?B?TjZ0eDZZS2VUTThsUWlSK21DWkJYZThQYlRyUkdwZXp1bmhjNDd2SkdtRGVS?=
 =?utf-8?B?c2k1dHNsODVQMjUyKzdlZjh2RDhMeXJjZTlPS0lEK1VvTUJRVU02dzVIck1E?=
 =?utf-8?B?UzJXMmFyTkJxb2VqYWFuS1JGWCtIVGdRZWU2SjBpV0RJUS9zSU9xRUJlaU1s?=
 =?utf-8?B?T3l0L2xPNm0vc1Bob0hBS2ZxeWZFdkZHV1RmYjA5bkQ0bEFRR1dVSDkxVlA3?=
 =?utf-8?B?UzV1eGtBZGpqV09ZaFFaUXZQTG1DVEs0Yjc0dmcwMm9pN0VNWTlKS2p3M05v?=
 =?utf-8?B?Q2NCQ0M1MGxPMFlxWTBkaG9TNVFDbGJrOTZ6M1ZJekM4ck5GNEFQRy8vcXFV?=
 =?utf-8?B?ckt4M1U0c09vWGFuZFN2cDRoSWdXNzVPK3NxVDR0TmVYdjVpby9qYlZtUHVC?=
 =?utf-8?B?NlFsbkJhc1c3d3Y3VERZUVBFMjd4M0JsODRlUmkwZGRIOFVTczR0NzNyRU4x?=
 =?utf-8?B?MUFhbzF3ZXAvRHJKc28vSzVxVkYxT0dDQm9Ec2ZHdnZraWorYnhrcndHV1Ex?=
 =?utf-8?B?S09HS3VvN2J5ZzF6d0s2b21OWXcralphQmFVMUVORkRLdGtRaCtVSnhNaHI1?=
 =?utf-8?B?S1pQdzZ1enlWM1l1bVdFMVJzYklNSFVEOTlTejVJU1E0NjlYNXgwZ3YvcXVD?=
 =?utf-8?B?aGdla1p6NmJwelpsVHErd2RZVDNkZHN3WmhVUHB6am9XdUdkQnJQR2RzdXBm?=
 =?utf-8?B?Vk9scUpYTnZPL1RGaXVNeS92dXBmMmI4bzkyWnhLNS8vQVpiSEpnUytSbERj?=
 =?utf-8?B?SndLd25uamh0a0t1ZlpaUGJscDQ1TTJWSzJYbnlnVjZCNmdVbkZXOHZZSzQ0?=
 =?utf-8?B?czBndFhNVjlPNTh2c21jVlJjb3kxcHA3VThYaUo4RDNOWmNhdkVCL0UrTEJi?=
 =?utf-8?B?eHYwM2txV0lSUXF3OWt3TDFLRG93M0xXQ0Y2bnI4ck1TWEF4WnJOVXQxQlVm?=
 =?utf-8?B?cDY5VlBPNHNKazRGNHRDSHZ3c0hJajM0aE9NVWtmRDBvcDBhY0ExcTRVZS9v?=
 =?utf-8?B?MG5oc3dlK1JpRlIyVkJneVBIZjRIbEJSNDd3TWRGNWdNbUhoeFdLUGtNS2tj?=
 =?utf-8?B?ZXYveSt0cTF6dkt5YUJLeWpUVm5WTEFGTkMyNGJRcXc1RzJuSkI5bW9OZm9J?=
 =?utf-8?B?a3NxVzRyaVlUdEtOd1dZTExKOVc5ejNrVjhkcGw2aDI5NDFLYmprbFF4TStp?=
 =?utf-8?B?S3hibFpXNG1sNHNtZmdhbE5pYXcyd1F2NngwdnZpbnNtNkdNclNGZGtOd0ps?=
 =?utf-8?B?M0JmanFSdmMvK2srMm5uUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHhackUxaTVCdjhjZHFqeW9ic1BVUGdDVk5JclFLVFVZNWpueFladUkramNM?=
 =?utf-8?B?aVQwUUlRUlVuUnpFdXhQOXptaE8vV2RORlBhNmZvaHExYzhlMEhHSnlNTGVu?=
 =?utf-8?B?bkdUSjcwUzFlOTQ0c1Q5MnFtK3N4a0tWY3JqbUlNeXcvNWRVL0FsT2JpaWNm?=
 =?utf-8?B?SG9MMTJnenFnT1p4TEtZYUIzM3AyK1pZaWxwNlJuMGZtV2lCMWlFaTFQVDNS?=
 =?utf-8?B?ZDd0QlNrRzJkRVBLTkMxQnVZaStwQmQ5NUYzWFhTREQxN0xqR3NYL3B2V0U3?=
 =?utf-8?B?czNoVlhyQm5pdVM0ZFA4ZUlEdmxpTXNId0VvWjRwSC9ZeTAvWkhCRzlBVndC?=
 =?utf-8?B?Z2cvT2dKTUdsYzFTa2prZ0wwQmhCUm5LdWFIQzZqcWxGc3A2UjlYYlQ0RGdz?=
 =?utf-8?B?UGhWcng5cTFBZEttdjVCNUY4cXNieVFIVzBvZ2w5enVZK3VnWjF5Tnh3TDJz?=
 =?utf-8?B?NUFWdkM4MWVOZEY4cFFUdGh2UmJTMEQ0SGRJUktFVk9mbGkwZjA5SmNjU2tM?=
 =?utf-8?B?WlFjaXNLK21XeGk4aXRMcldDNVFQbXBFWVZzdFEyK1NlcmxJT2ZEeVJhS3M4?=
 =?utf-8?B?Mml2OWZQTi9OaUIxMk1ZOHAyUTJyekc3c2dVTHUzRm5HdTZzM0FtbzRPa1pR?=
 =?utf-8?B?c3FuQTYrN3pKVUJ5c0dOTytjelkyVkVTSDhrU3ZHY1E1YnhZL1M3VElKYlNm?=
 =?utf-8?B?TFdSR1R1N2Fia0ZaYUJ1YkZqZkV4WkZibTM3eGNCVTRjQ2hsOWtvTnZCNDRt?=
 =?utf-8?B?N05tcXFQczBpalRldXVYK1R5OWxkVHYvZGNmZ24zUWZpL2ZFaldRb3dvemky?=
 =?utf-8?B?MUZvTUtKeWlaVW4rajU2ZUp5RVRwM3RSWStLSHpGOGgzc3JyTEVwbFEyNEtL?=
 =?utf-8?B?R3JDRTQ5WlFjRTJkL21NRm9RTjU3aFh1bE5xaG5KRmszbXM3ZkZyakFXUmJH?=
 =?utf-8?B?aE9DUHFkZjBMMU54dE1zbTRKWDd6RjhEcmQ1dS85OXNrVUpCVVJXWVYxNUVE?=
 =?utf-8?B?S1ZoNU0vbFhHU0xFVUE1YXZXT1hiZ0pIVEtocHhqT2NIV1phT3RoZFZOMUJs?=
 =?utf-8?B?MkhteGFwWHVjUjFBTjRiSlBNOVZ3YTVrV0FtYVhHUkZlL091VnFqOHE3TTdu?=
 =?utf-8?B?cUk1aGRyU3VZWEdhc3JjUWtQM3UrTWZZNGZ4WnJZUjh5Y0tTRFFnWTkzdWVI?=
 =?utf-8?B?ZDZsbE10ZHhQWVpJTktud1VUR040L21kK1U5OUpxeHFsTitBU0M1b3pkTGVC?=
 =?utf-8?B?Szl1M2FFOU4xRUkzbWdYdDltK2NBRkRPcWJtL3JGK2ljTjR0ZmRnMllxaGZy?=
 =?utf-8?B?Q1grR09NL1VUQ0tCUmh1UWU2QUFvMnRuNFBVbTFCdTFPWENtYlRzR2Z1T2Vj?=
 =?utf-8?B?ekdLVlRxM3F3WWMvZ2htbnpGaWdqdEdxZFgvYlFDK3ZPa2g4TnRJdytzbENo?=
 =?utf-8?B?L1gxallNL0pqVkRNeTFla1lYcWFhR2lSakkvSEZEYWZORXJmZ1hBSHgvMk1j?=
 =?utf-8?B?aml6RWIvYVVCUjkzTnpFYmFqM0VwaC9xNTBDdHRhbUNIaUJXb0VNNUtsUzFk?=
 =?utf-8?B?cnNuSTRIaS9PTzJGNWV3MGpROGhvNlE1QU1QaG9hcm5HeHFDNnVibXloTW5I?=
 =?utf-8?B?RmNPRmMrbEl2bXFiMVJEaXFKTFZGQkVtRDRtK0RXMFZFU1JXTHd5MVdzVlE3?=
 =?utf-8?B?WEVDVVgvSXVDWEd3R29hT2lFRzkzbmdsekcvQnpjNFcrTFEvTmczejZ3VmEy?=
 =?utf-8?B?RFlqTm9hd2N1U0hFV0tRUjdKaS9NeGhxcmZLQTl4SXdFT1JBMmI1WnE1V3BJ?=
 =?utf-8?B?ajU2K25iY2hLenBnWHdXU1pLUEpibzNFVGt3L0FOMWVjQWI2MW1HZk9WL2Qw?=
 =?utf-8?B?NUgybVdMa1Ercnl0SWZUc0VBNElmSng2SkNCc3ZRUk8ramJJWERRSXNaTUFL?=
 =?utf-8?B?VlpOWDlPNEVVYzRYV3RnajhwVEhkOEYvY2kzTU5KVmtuT3hadW5UT3EySDlp?=
 =?utf-8?B?Sk5YK1BtRWZ1eEdyZ3k1ZVd5ekhzN1lzcW5FUjk4Y1FOa2RDSmRqVnZvZEh0?=
 =?utf-8?B?OVRsd1RoS1FjWlhOanlQNzkxM1FXa1dyeHF5UWdZWk5xMEwwVHdFYUNlVXVt?=
 =?utf-8?Q?XMD0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9787be-3860-475b-4ce2-08dcbe3373c2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:38:57.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKKZaULrzVGUT7ZkL4kIBzj2fl0NJfbvrgTth8KaazrahQ1RapyDsdbpRWztiZ48
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

Hi James,

On 8/16/24 11:56, James Morse wrote:
> Hi Babu,
> 
> On 06/08/2024 23:00, Babu Moger wrote:
>> The mbm_mode displays list of monitor modes supported.
>>
>> The mbm_cntr_assign is one of the currently supported modes. It is also
>> called ABMC (Assignable Bandwidth Monitoring Counters) feature. ABMC
>> feature provides option to assign a hardware counter to an RMID and
>> monitor the bandwidth as long as it is assigned. ABMC mode is enabled
>> by default when supported.
>>
>> Legacy mode works without the assignment option.
>>
>> Provide an interface to display the monitor mode on the system.
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>> [mbm_cntr_assign]
>> legacy
>>
>> Switching the mbm_mode will reset all the mbm counters of all resctrl
>> groups.
> 
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 30586728a4cd..d4ec605b200a 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,40 @@ with the following files:
>>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>  	    0=0x30;1=0x30;3=0x15;4=0x15
>>  
>> +"mbm_mode":
>> +	Reports the list of assignable monitoring features supported. The
>> +	enclosed brackets indicate which feature is enabled.
>> +	::
>> +
>> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>> +	  [mbm_cntr_assign]
>> +	  legacy
>> +
>> +	"mbm_cntr_assign":
>> +		AMD's ABMC feature is one of the mbm_cntr_assign mode supported.
>> +		The bandwidth monitoring feature on AMD system only guarantees
>> +		that RMIDs currently assigned to a processor will be tracked by
>> +		hardware. The counters of any other RMIDs which are no longer
>> +		being tracked will be reset to zero. The MBM event counters
>> +		return "Unavailable" for the RMIDs that are not tracked by
>> +		hardware. So, there can be only limited number of groups that can
>> +		give guaranteed monitoring numbers. With ever changing configurations
>> +		there is no way to definitely know which of these groups are being
>> +		tracked for certain point of time. Users do not have the option to
>> +		monitor a group or set of groups for certain period of time without
>> +		worrying about RMID being reset in between.
>> +
>> +		The ABMC feature provides an option to the user to assign a hardware
>> +		counter to an RMID and monitor the bandwidth as long as it is assigned.
>> +		The assigned RMID will be tracked by the hardware until the user
>> +		unassigns it manually. There is no need to worry about counters being
>> +		reset during this period.
> 
> While debugging my rebase of MPAM on top of this series, I've come back to this wording a
> few times to try and work out what I should expect to see ...
> 
> Is it possible to disentangle the AMD hardware feature description from the description of
> the filesystem behaviour this enables? You are really describing what the hardware does if
> you don't enable this mode...
> 
> An incomplete suggestion of the shape would be something like:
> 
> | In mbm_cntr_assign mode user-space is able to specify which control
> | or monitor groups in resctrl should have a hardware counter assigned
> | using the 'mbm_control' file. The number of hardware counters available
> | is described in the 'num_mbm_cntrs' file.
> | Changing this mode will cause all counters on a resource to reset.
> |
> | The feature is needed on platforms which support more control and monitor
> | groups than hardware counters, meaning 'unassigned' control or monitor groups will
> | report 'Unavailable' or not count all the traffic in an unpredictable way.
> |
> | Platforms with AMDs ABMC feature enable this mode by default so that counters
> | remain assigned even when the corresponding RMID is not in use by any processor.
> 

Looks good to me.

> 
>> +	"Legacy":
> 
> Calling "enough hardware counters" 'legacy' is a bit curious.... 'default'?

"Default"  Sound good me to if no objections from others.


> (but I haven't worked out the benefit of disabling this mode, so maybe it doesn't need a
> name.)
> 
>> +		Legacy mode works without the assignment option. The monitoring works
>> +		as long as there are enough RMID counters available to support number
>> +		of monitoring groups.
> 
> How can user-space tell this is the case? Could we be specific as to what 'works' means?
> 
> Something like:
> | By default resctrl assumes each control and monitor group has a hardware counter.
> | Hardware without this property will still allow more control or monitor groups
> | than 'num_mbm_cntrs' to be created. Reading the mbm files may report
> | 'Unavailable' if there is no hardware resource assigned.

Looks good.

> 
> 
> N.B. I don't suggest referring to the num_rmid file in these as MPAM doesn't have an
> equivalent property.
> 
> 
> Thanks,
> 
> James
> 

-- 
Thanks
Babu Moger

