Return-Path: <linux-kernel+bounces-416287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F22C9D42CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345F22825D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8396B170A2C;
	Wed, 20 Nov 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JbyGYqcL"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28015855C;
	Wed, 20 Nov 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132952; cv=fail; b=qO6qgV11AsnxcBBOQ6I3/sOIoWVX6N9rpfE/qBMfJ0S6+EEa3tldcUFyZe11VzqsLWbYxmHceqXtg7+g5u2y/WBvJlM3SrqNREda0UUGWVDzjk/UagciD2OkY/wx9Nkw9/xylraKUqU5FTL3vaUFzm6xDa73lq+IM2Pj1kGCvhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132952; c=relaxed/simple;
	bh=UfKUgrjeDNjvxVY0+Wbn/C8KaRyi81FZpW98q5KmlQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aQAsSHfvRUNIPz/llz4rCRh9vRhmdLAzYAdwwsRPaFJ6rLzwJcTRN/Hd2MeXHOJLTCViD5u3BPHa8AHQaegj5ns+P6oz56CWoxb6zF3jy6OME/YbBDQEakm4ppKmeaIvM20/IGcQkTPBRQgans7O3PGbivq6vwo+0pLD/AMRuiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JbyGYqcL; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFv5sOptiqKUsMTJbQ0QkJ207eeA+Y7CAqgFP1GDQqoDgPIkPJ/JAwIzG6JV2hNxy5foQufkQWazCXLTJCWo+iLnJ2ztlHUCRcQ2eNyRvLzBJZ+C3KtoyMErO4EmOTnRnEgvHloU4GsRHgr8BIPCtZCooY/Ymwqgg571A26r5/XVgFMDFvVZOE3e8MOzhTcsv5PufFS3iz1skg7/MdM9m7OMfIH6/P9Xn+T295kSDrtM6+6BBTTGRZP7Dsb3zipTM8oe1B0Fu8/HOnQo3tKkxRSbYqF2XEWcQazQLR+yxJPf5UPwZZaCVtMQS2IuZaq+hDpBgi/DCrCDLSKQqT43Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibik+D3fhMSR0joZeTPJ5cBKvi/P97SW3+0TXt4Ei+I=;
 b=uVDfoGOW5Qb3XQDiktOzSsN+VO3gw4F+W+AhMtBLN5NKmV1qNNYXLfGJzczXaW3USWFrfvNJwlCjApwCeUyKKWhxq/3HTU33BblzFW2anPVVLftiN9nigpewAU9BdTRgEW0ewHaZ45xNxZ81GpvMZYFzIzRsmYsEfwtpwu9B4APfdeJgtEwXgacNUxH55hBAfQfp4mSjdEqI+vI49YriW2ROCXbyCPeVFn4aM3WRrknMkvHYO3nuUHHESGkhLexy++/3FUONyp6Lww8hsUpADFDyy1BqB2pk0K3BpqJq9vUNG8fyMcxqxRMlD8lfV9cAJedHyY5v2vE+c7fAkwoGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibik+D3fhMSR0joZeTPJ5cBKvi/P97SW3+0TXt4Ei+I=;
 b=JbyGYqcLHd9le5uLDcEOMTXfkZLHxAGY26HqyjskGkW+ulDyqYcW0rZpTA6Bl83t/JE9oENTvGfQdR5RGMTsOypt57Qu7p0biCAyWIDl2ULmGrkkHKQ66kUkPMwrnZmeh5ImuD4rkIBjhq15KmKLEco9wYcuVBITXDOnJOtPog4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 20:02:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 20:02:27 +0000
Message-ID: <55237d27-16dd-4b0d-868a-bc7ca6155270@amd.com>
Date: Wed, 20 Nov 2024 14:02:23 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 01/26] x86/resctrl: Add __init attribute for the
 functions called in resctrl_late_init
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <2372314c135882d233eb8dba69af7c245efdcc8d.1730244116.git.babu.moger@amd.com>
 <55bd64e3-50ff-423c-ac75-e25f2e1c9ffe@intel.com>
 <02e304e5-597d-48f6-b61e-24f366f60fda@amd.com>
 <b29b8732-8b6f-47d3-9432-88884e744f56@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b29b8732-8b6f-47d3-9432-88884e744f56@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:806:27::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 429197b5-1a04-4446-b11d-08dd099e4235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bktSUmtBSmprZFU5VzFDbVZyVTFQS3haSUd4S2dTYUpDb2FoditNTEg4VHZX?=
 =?utf-8?B?KzdGNVBkOHI3R3JraG84RitxejFxOTRSeXlFV0JSSi9zTXF4RUN5OWQ4NU1w?=
 =?utf-8?B?Vk5TVXBzSE9pN09QN05qZEtOWUh2ZlhpSEtDcW1OSE9JR1h6eWpTNE9lUUZM?=
 =?utf-8?B?WE9oSjJ2L0dRUjNvQzk4b1l6Qk1EOCtWaUdjbTZXRlk3cUZVamQ4UFFDMkFN?=
 =?utf-8?B?WlZUUVZ1eG9FRjhDS0xtaGhaeFB6eFhjZFNMKzBud2EvaGwzWTJkODU1aHpN?=
 =?utf-8?B?M3UyZ2VmT3B2KzY4dUJnNnR2OVdHcjVEOXdQNjY5MDRFZS9HYlZ1SHRkZ0I3?=
 =?utf-8?B?YnB1bld1S3Bpa1BLT2thQ2ZQUS93QWtjRHkzcTRVczZ6UnlkM2VLRmhjZFRK?=
 =?utf-8?B?VzRsRjVrT3RCZ01GbzUzajdTeGNDUzdSUUhPdWdQdnNlS09tVUhLTWhMamFp?=
 =?utf-8?B?WHVibms5dmxMd2dSWHNjT0ZrUU8xWWhPMVRVcTdBTzdBWUd1M2pQY3p6SVlp?=
 =?utf-8?B?MTYwVU0rOUVhVjhHd256Wkx4ZEhxdm1hVHI1V3k4Q0ZKQVhlTk9NWXNRclEw?=
 =?utf-8?B?NmN6NGMxRXVXUXdKMWM5cC9ublljL0IzNEV3aHFvcmZNTWgwbHlPMWJVT0M5?=
 =?utf-8?B?STQ5eWlDTm85V0ZFWnJHYVpJRzVFbXdobnpVbDVyMVRORVZ5RGhEREpSNlZp?=
 =?utf-8?B?NUlYNlZjcjN3ZDZ1SGN5NzhFZFNYVW9PQi9KNGJLckFvanRpcjZjdW1XdjdN?=
 =?utf-8?B?NDdTNVBaQk1ZcURvS0RWVVZCbDVKMzF6SGRZYkM4Vi91SE9rMHBWU0RXYXFF?=
 =?utf-8?B?Zi84cE5PK015RFFjWGFEWlhMT1R2Ty9sdnVMcjVPOVJ4R21KNEdGOHVCVjBG?=
 =?utf-8?B?S2VDUVlqVk0xQThEVHJKZ2o2WFhFTWJTRUp5OUFaTDFWZklxZXd5SCtPUmFa?=
 =?utf-8?B?WjBFQU9lSmw5bitWbkVkSUZHY1d3Yk9JVmFRa2YzZ0lYZXFKbnpJckxidjI3?=
 =?utf-8?B?MWtKcWNoSEVUY1lML1hMK0p0Y1MvaVhIQlI5SUNEYzI0eTdEZ1FRcitQYkxS?=
 =?utf-8?B?TjNINjVXUWxGWDFIMG9rMkJNeXdNSUZXcWx2ejBjWmdpQ1lWU0gzcTNKaTRD?=
 =?utf-8?B?RTNhZFlzcDgxemRTMEsyMTN1RGNTWS93T0Y5cmJTRXhQMDhWWGEzN1BGSjZS?=
 =?utf-8?B?NGU5RENwVDFsTEY1ODNlVlhxSVRHUUVSSkhjYk1KV1VkamVrV0RJc3ZPRFAz?=
 =?utf-8?B?bHdtTUtYckJnM0xFbHpIbzZ6THM4b0VvVmU2bjBYTWl5UXFrNHpSdWgzNStU?=
 =?utf-8?B?WllHQTVkK212QlN0QTF3NjZsRVhCV20zTjhvSlVBQ2Ftcm1Yd293TVJvZnlW?=
 =?utf-8?B?ei9mcEorVWczV3BhM1JZNUw1am55R3NCdVU0VThmbUZ2cWo0aGt6TTY5WnMv?=
 =?utf-8?B?SEg1TjlCYjAwN1JOb0ZIUnU2dkZINjBFam5HMzBGc0gwSEp3TWdpQjhKYXp1?=
 =?utf-8?B?eTVsVUpPRkNXdVcrbHlzYmZUQkZxa1FaQS9qcTNBZHRHWGJlWkhMYjdQMEY3?=
 =?utf-8?B?by9YSE1aRmFlSUFwK0VkSGMyMDhGVklWSUpRZFZwTXQ2WDhLczNXSWFuTlJk?=
 =?utf-8?B?VVJuVit2UVZkRTFOSkoxTCt6a2tOSDZkWExTUTFYTnFoa0t1aFNaRkNyZzcr?=
 =?utf-8?B?eURaVGxTNmFldm54djNkR1pyWHlQQ1NOcWdBR2JUNU4xL2J5RTNsbllkZnpP?=
 =?utf-8?Q?MmxljA8S6HCRR6Uxlcq6EvHYfJJ9bL+HLfQ8OB2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWFldEN3bHZnNlJVMWRlSmMrSTVsV3Y1dXRtcUpaWXY3VWU0SUtSZ2xxMCs4?=
 =?utf-8?B?VnlKaEtMTkhJOElnQmJNajdjSFpxNTM4RWx5M3FTTWk5ZUpVb2M1N3lMYkFX?=
 =?utf-8?B?UGVhQ2xVOGJEY3hNKysyRjdEeEVObDJVai9IZTloM1NoeDZyODhJN1RuYzhu?=
 =?utf-8?B?dXhGTTNXNk1acDIvOHZvVG1pR0JBNlpoTTdKbzFNSktSRldUMS8rays4clpW?=
 =?utf-8?B?UlJtdDVNWHFPYkVjOERBZXk3MnBxMDdtMFhlbmlqa21nR2xheVlJbmtDcVZS?=
 =?utf-8?B?b0VQK3ZIaWhJSHJrR050UmsvZUZOVWZFSWV5SzRVV3dHUXl6T2xVbU80aEdR?=
 =?utf-8?B?OHN2dmFEZGEvaDBtM1hBNnQxTzZLanIxNVRIaThwbi90NHJORUtCYjRlUjNh?=
 =?utf-8?B?QUhTWHo2Z1BoOStvSHM4Ukt1cW9zRXUvR0UwM0tVMlJ2b1BnbFM2S1FXaWJK?=
 =?utf-8?B?WGFoUS9PT0ttUDBKMGx6cGI5WVJ5eXlScGpORXJyNFI5dUtjUXpNcEYvUDZj?=
 =?utf-8?B?YnlUeUhEVjBsZzBObEJMYnhBcU9DWmQ0MjZJZDBja21DUjlWY2RldGdRZjBv?=
 =?utf-8?B?bUVJVkxDcWhRbXBMdUZVdkxkb2MwSWFFbkc2QTJXVDZmU3NaWitZZDE3aFYv?=
 =?utf-8?B?bjdUZ2djem45RWx1QjJ3TlZONkNBSGRsNGNjYW1uWEJrWC9vdURqTXVjWWFq?=
 =?utf-8?B?b2hpUDAvaURCNENEd0tmVnZqQnYxbFFPM1JGcitYTmVla2M4WTQ5WWN2eXhi?=
 =?utf-8?B?ZXZVT3RwTU8vdmtlREljVzMvQ2FFRHNYWHljY1Q3ejhwY1pSdC9uTENUN3Qv?=
 =?utf-8?B?a3dzSFFPM2NpanIxbG1FR2toZXk1MW1za0pPN0MyVHVEcE02V0t2ZjdOdnY0?=
 =?utf-8?B?Q2V4UGRzZDZpK0ViT1h6WG03Ly8relIwVzQybHFwTDJtOFArMXZTSlFqcjdm?=
 =?utf-8?B?aXJxdnpFRFVpY1h2eVAxNWhrK1U1RllxYzZYcjJuS1dzQjllSEY1dlBIS3J2?=
 =?utf-8?B?RlpQWE5hMDg5Y0t2NS9lbm4xYi85d2pFblVncXB0c3dwQWhJeEpRVjl6SThV?=
 =?utf-8?B?ay9ja1Z3RmNyNDFBK3JPY0NYak9MUEJtM2JueFJCSnNibzBnaEcrbWRXRXVS?=
 =?utf-8?B?UHNJYk4wSStxN3E5dVQ4OFJPYWFjZ1V6b0g0RWRiWk4vdm4vSDZlZXJmNlc1?=
 =?utf-8?B?VlBQL1MxUVNkb1RLSmppSW0wRWp0TXVtcFdYb3pXNEZsYS92bXlQTXROOXJ1?=
 =?utf-8?B?dTFESzZuZFJaZnFHVXlib1VCeXhPV3pEMWsxOFZrNEZna2VpQys0VEM1ejdR?=
 =?utf-8?B?UkYwRTM5QW1JM3dVZXp6Z3JlSXBVVUYzVXJ5ZnlJUlZGV3k3VWhVTC9OQlp4?=
 =?utf-8?B?YWYyKzBsUzFnNllZVk1TTVdaa0pCMENuekdhaE04d3RDUVpRSCtYbmlyT3dK?=
 =?utf-8?B?a0JsVDc3RmY0OEROUXJXVSs4L21sU3dCUUo4TXcwUXBsWVZ2elVibCtuZFcz?=
 =?utf-8?B?SFMyWGxITUJYV0xKdCtTZjA4R1BvZVZDWnVrcG9kaGVJb3l5enNibzVuK1RD?=
 =?utf-8?B?L3UrOW8rSkQxR0t1WEJxMHpzbnNXN1lUZSswK3JLZ3RUOUNmV3VsSFpBR1ky?=
 =?utf-8?B?SnRYK1VpbTBQNU41aGkwd0tDcnR6N1ZMWTNGNmUvQXU4ZEpLa3U5OWI4RDNa?=
 =?utf-8?B?c1REeEpNdTFKa3BadWZaWVNGWTkrQXFKMjVpU1dlVk91ejZxS2I5ZE4xVFY5?=
 =?utf-8?B?VnZQOXZrNXdEQk4xS05NRUQwaXBnK3B1dmZhREFhRkNFaWRYMEdwS3pLcWRQ?=
 =?utf-8?B?VFZPbUNtMkxYN3NzclN2cC90NnJOZWo4dTMrek5tR0tlUmhGbGtOWHJNTSth?=
 =?utf-8?B?dTN0OC95c2ZJWUJBOHk0bmpRM1dreTRURG01WkpIdzM5czRlcFRYVDgwMTMy?=
 =?utf-8?B?YkpLU2RaRlJrVVhnMlFJVm9DQjdHa0N0ZFJ4ejBMTHlTL09FYUVoQVhxRmZL?=
 =?utf-8?B?K1hRZExOWThXRDZDQ3FOUGZyeGNRajB6MFpTenNBdzZwUk9vdklCZmt3WVky?=
 =?utf-8?B?ZXdyMU94dTNFWmlWZVFWZm5CVHlWdnVZeDdYZWZVem56SS9wdzNMYzI5Y1pi?=
 =?utf-8?Q?Njts=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429197b5-1a04-4446-b11d-08dd099e4235
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:02:27.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: am7VAmrej/JSdv9eVkMBrO4H69abkCq4suw3ZcRsKykaTgTZmI+rZtKrJdzRW2jd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

Hi Reinette,

On 11/18/24 16:07, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/18/24 9:44 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/15/24 17:21, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> In subject please use () to indicate a function, writing resctrl_late_init()
>>
>> Will change it to
>>
>> x86/resctrl: Add __init attribute for all the call sequences in
>> resctrl_late_init()
> 
> I am not sure how to interpret "call sequences". The original is ok now that
> cache_alloc_hsw_probe() is also included. Specifically, this can be:
> 
> 	x86/resctrl: Add __init attribute to functions called from resctrl_late_init()

Sure.
> 
>>
>>>
>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>> The function resctrl_late_init() has the __init attribute, but some
>>>
>>> No need to say "The function" when using ().
>>>
>>>> functions it calls do not. Add the __init attribute to all the functions
>>>
>>> None of the functions changed are actually called by resctrl_late_init(). If this
>>> is indeed the goal then I think cache_alloc_hsw_probe() was missed.
>>
>> Will change the function to.
>>
>> static inline __init void cache_alloc_hsw_probe(void)
>>
>> How about this description?
>>
>> "resctrl_late_init() has the __init attribute, but some of the call
>> sequences of it do not have the __init attribute.
> 
> "some of the call sequences of it" sounds strange. It can be simplified with
> "some of the functions called from it"?

Sure,

> 
>>
>> Add the __init attribute to all the functions in the call sequences to
>> maintain consistency throughout."
> 
> Sounds good, thank you.

-- 
Thanks
Babu Moger

