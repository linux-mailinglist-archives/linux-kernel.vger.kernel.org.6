Return-Path: <linux-kernel+bounces-380411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075189AEE14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3A21C20C01
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120411FBF5E;
	Thu, 24 Oct 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WBC7kGlJ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A973446;
	Thu, 24 Oct 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790962; cv=fail; b=cFmAHwfjxa3bcX5A5L8BsGHPt8QpVAwJ9FYxlExbTmVpJrfGSe6v50MMUqGbv51orNsIyLobPbcSwoXxWi6EzCrvRP1l21eMhs8XGCnu7L7ok1B43kLB7IMoR9eSAsknYg2SHvmosNC/d0d86V8m6RMFIb0WsCsEwuEHwPCOvmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790962; c=relaxed/simple;
	bh=al04M4cA2uDUGVDL5YO4FEeUYkeWDYiyrlUn8HYJNz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dQCckK7CH6u9Hp3DWnJ9DbzzSkK0OExUnE5m1j+zIUWxVLnhR1nJZKnUQccFDZG5p+jf4TzSnFhOdBdJ+pUzqa+d94FjP/LUxeuLstYT73/T4i/cvoLX3P2a1pzGyma8DfxCYzFUv88wrh87eiXWqBstIm0hEHs6wcCrWJoOkEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WBC7kGlJ; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoOORBUESFl6/380qGJvmJYjwbd3b1VuAgrEcgvse+D4wtVqGJspqN7pEMv/7pnHEwzPeIiZ+yp9RWVMNGK/a5wuR9CnqnMu3d68e1bA76X/X8RYd1IAZa1MoGe0bv8GsLfafM7n1BTfbmBJBH1D0UWym2onGosMuZr7r2uA1bBAM5A4OOlRrhnELGG244YAogwRZoTXTMEmOIRtaDeUccG84lzZMJ1KDPicu/i6u3t9mKmYREV/pri5aYeG4tdVVo5zIEBTl0+6qbwBLsyM5wFEbXzGtJRqJmcm8pE2PebQ9+ktQyXSwUkJ1HsnB39HQJzAeyXgFsVrMSa02jwMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKjkvcxXCjLdx2THbVtwBjz2AhDuG1S8NIPteC2v7K0=;
 b=nsvXVYDUiYawYMsRqYFoGpmQrZUqtRYqwBZIB18soRGaR3Q/0MroyYijhmav/41bPlXfiTu0XXCrvBK0r6TOCm3KzWhypNmbs/3G6uzFB0tjNkNffq4vco5h9Ccmk/Q2/JxM/KFcB2lfaTSiMjEFtoAlG/k4AqXNqA6ipSKfnTvuceqr7YrTRnOOI0i3Zr/X7boL7J2fWXW0QIDEHUi7KIHCfyh9NKWWdT4wlyixzHXAEm6mRq8922S3QKKQ6LZ/UQ6nRk65EI4quCvBHPPBr9/IJPDemfvPKdNJku8KgWB6nmcZsrQc7hPcFfS7WyPyJfXaFJ/V372WUd8NGjFGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKjkvcxXCjLdx2THbVtwBjz2AhDuG1S8NIPteC2v7K0=;
 b=WBC7kGlJyDwW2ZrRXi2W7iTuTChYeupXKsHm2pf0yw+zj6JEtcGsb+bDYHUvkWeMLKKRJFzjLw826vmap9Is0xGKeSWpd69h8rbpBQjj7yZC/uuM5Sx9mell2ipfR+YTEJboTpyGmKRddFNCOL3B3FZQHk/JI3Ep/CWd0gV3aac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 17:29:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:29:17 +0000
Message-ID: <3b7ca34a-764d-458e-b28c-113dc5419a4e@amd.com>
Date: Thu, 24 Oct 2024 12:29:13 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
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
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
 <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
 <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <23b5a3d2-91ac-4467-9db0-3de483cfacf9@amd.com>
 <SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <799f514f-b06e-46d9-bfe7-dfd986aef166@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <799f514f-b06e-46d9-bfe7-dfd986aef166@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0169.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 575334d2-5204-49a9-1488-08dcf4516320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDIxaGI3VmpHUDdYL3ozNjZkOTRBL1FpYyszUEpvOUZRdkRROWNTcDJCZlBY?=
 =?utf-8?B?QTd2RExjNHc1RUZaVlI2OFF4YjQ0QzZUODNyWnpWdDBpaGQ2NmliZ2VlTFY2?=
 =?utf-8?B?b2U5WXMwSjF5L3BtUGw2V3BuYXJRMkhETFBUS2VJN1ZLVGJjQUpCQ0VQa1M2?=
 =?utf-8?B?elBmaEp2cEE0RWV4T1NOSU16cWwrTUJTa3RDSU5UaEFWcGN2Tjd1cVFkMkVZ?=
 =?utf-8?B?WXRhSFkzOWp2YmxwbDMvZXZ5Sm9QSU5ldFgxcUpzVnJXc2tucW1SMHdVbjQ4?=
 =?utf-8?B?NytyWHlVbWxVWG1rOUJhMkFVcWpaSHNUQkZtaVlMcDVwMWFuWkR0R1p0Z0Y3?=
 =?utf-8?B?Uzdmb05LUW9qSWF2T2E1eGlyN0ZzM0pVN2E2YWEwOVdzNUVzRXMyVGk1dVdU?=
 =?utf-8?B?aENLM0dCakNIcW1RSCt5UXU0WXM2SGphSHd6cGlEZ2pIeGRBRFdkNVRCeG9X?=
 =?utf-8?B?dVcxU1JCYjlDZ0lsbFBPT2Y5SmFUaDJiQmlYdFNCeDh4ZURuWjJ5bmlDdGZ3?=
 =?utf-8?B?aGNmSUpkWk9vN3ZaVDg4VkJmbFBLWXFraDZJd0dJRFgwTk1RNmhIZkRuV3V6?=
 =?utf-8?B?eEV0dndxeURaa1cvY3hYVThUL2FRZi9mSXlJTlR3UE10citQbGQxNDQ3Yktm?=
 =?utf-8?B?Qm9YMW1XTXQ2djFYQzdCc3Z4WUFyRUlqUCtDbUN0empJdEdNODY5amYrVVA3?=
 =?utf-8?B?SkpDTS9RcVBSeURIby9oemVYRGYyU1FVV3ltNGZWSVpreHBSMXpMRTU4WGM1?=
 =?utf-8?B?QkY3WVZVUDVGR0VLT1NQcHoyZ0s4MmU3ZW8vWGw0T1l0Uy9VMGFHTkwxSXkv?=
 =?utf-8?B?YnFkQXQzVFQxWXdlWjQ4K3JuSzYyRmdWQXhseHU3a2UwVnFvcWQvL0xqOUVQ?=
 =?utf-8?B?cklxUlR6aG92ZStJQkgrbko1T1VRUFhEeFBXV3VvOFlFQlNIbnJXbzBCWXEw?=
 =?utf-8?B?THZKTzNEMUlLVzQyb1Zya1VXSytvYXJZNFY0cElRdTlPSGdUVjNDd05seFAz?=
 =?utf-8?B?QjMwV1NBSytRdzRWakZDTGJUYTFkNjJlV0hvcDNDZFVuSUhOTnJISUhBUTZ2?=
 =?utf-8?B?dUNTR3ZFSU9vU3ZjV3hXdFk2TUl0KytKaGF0ZTQ5Ym9ROS9ybmlmMFhkL3Zt?=
 =?utf-8?B?TmR6d3o5d3NSVWgvWlBhZSthdExBTk5Dd09xaDBmdVJYTlZSZW53MlZOdTNL?=
 =?utf-8?B?R1VYdDdwTFRkTEozM3NmNTVTUGMrZG5PRndJQVZscTIyckExREdwZDlnK3Rr?=
 =?utf-8?B?MjFtTkpSa2E5MmtveGZ5dVdCT3dnOE94KzB4K01tOEFZS3h2T2tGVnNwMXFB?=
 =?utf-8?B?K3pTMGphWTZaQ3hkRDVsODJDRnU1cnJXM1hZUVNlRDd5R3lRN3NWb1NXTFFJ?=
 =?utf-8?B?Rm9jeXVadVpEMHJaLzM4VElnVjJXZTFhekZpdklKR3A3bmVjcy94Y0E4VXZZ?=
 =?utf-8?B?R2RMaHdhMW5iOHpXNW9LdlpLb0M2ZzVDd3cyRklIUThmMnU5RmM0RDVrQ1Nx?=
 =?utf-8?B?QlRpdkoyWGNxWlRYTTJYbjJhWVIrK1FHTVllVE55c0RoUFQ0TUpkQllidVBW?=
 =?utf-8?B?cG9ySVlINWpmajVzdXpLdnB5cGtibkNVR21SSzByb08xNVEzeXphN3Fhb3Ry?=
 =?utf-8?B?dWFKdkxlVjM5d3JQMCtBOXdOTWNZL2VxeHY1eHZabXUzWDl1RUpyeFcxMjhs?=
 =?utf-8?B?VXpiNG5ya08xTG5pNDZZUlQ2ZHU3VWVEeVNKT1d5bXlyaDBqUEpSY1IvdFNC?=
 =?utf-8?Q?hTJcfyJYjc/9Onuhrx3i9g68jMGbKn34m+X9IhH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjNqd0krSytFdUxRT3QvaWgwNjVhT3B0NjkxN0xYc0g1ZkF1eVFKRTMxdG5y?=
 =?utf-8?B?SjBVaUQ2Wng3OWZXUzd5OTNjcW5nZUJyeWtzUDdLRzYwYmRqWGRPZGtMZm5T?=
 =?utf-8?B?WVkwekJyV0Z4SFd4cnhmRldDa2JSd1Bjak55QXFzZE03MVNqYjc0d0JtOGFM?=
 =?utf-8?B?OVVZS2Zvcm0rY2p0eGtyMStvK3R2eHlzdnp3eDlTWWlPTFpZQUtpN0I4b0l5?=
 =?utf-8?B?T1BLb1dBUmRJUjEyL04wbEEwUTNFbjYzR1NqbTZ3MjZRMGhNcnBKNjhUVVhB?=
 =?utf-8?B?eExtT05icHcxVUVVOE9xZ1IyeUd0YS9vdU5rSWlTRUtydW9pVXZTUzVXMmFl?=
 =?utf-8?B?OVRjdTZYZFY0MHZJOXJjNjhaYU1BdTF5cStYbGdlUm5hVkhvWlFTcHA1dkw0?=
 =?utf-8?B?eXdQMi90QmtqSDYwclhQRndtdTFCSHU4UWNmYkRyR2pSbDdiWkJuOGdFV0lu?=
 =?utf-8?B?bjU2eGlvSURlTklZSzJoRGt2dDZMWGFwditKSHpFdkJWTXRsWEUraWlpaExT?=
 =?utf-8?B?RGo2QWlINzZBY2F1emxJbC8yYnZXYStIUVpZay8wWDVQLytsaktLS3REelIy?=
 =?utf-8?B?WnZvaTRyMis3SHhzNDZEU3hvaDVqeG1aYXd6Z1VXY3Izak5qTm1hcTFqWFNO?=
 =?utf-8?B?WmsxbGIyS1drWm5sdG9zcDlDaEQreGJ4R2ZpYjZudEVBbUU3YjRydzRUZkJO?=
 =?utf-8?B?TjRUVExBSEJ1TzVkUC9id2pIZ1l6OGtiZ0RuSEJkL1U3RjUxR0JrOEZEQXFv?=
 =?utf-8?B?YmF6aXp0UlNoa2Jiam91R3pacGZ5cVNuTGRhTWg4Z284a2gwem9Nbk9TajF5?=
 =?utf-8?B?RnU1Vks5clJWb3JHZlNKcHRQR3pobHdMQmpZa04vMnBJeHNtWFF1QkVSZ2Zt?=
 =?utf-8?B?OTBlT0c1cWJYQ0tYLzY5RENEREJXcmRqL1VMVkxjT1BpaFhHOU9xQUZaQnNp?=
 =?utf-8?B?VHJ2RW9uZmZMUitISWQ2TjBOYkZBYW1PdzBIdVY2dUQ0M1d4V1I4aVBUMGxD?=
 =?utf-8?B?bXJvNWw3Z2huaUppK0k5R05HV1B1R2FsVDIzM1l4KytPUU8vK0lWRGtmUmND?=
 =?utf-8?B?SVVrQXVEVG0rM21YVFJXc0E5R2ZOYVZocEZsRXVrbkc5OG9IWU4za0tMWWoz?=
 =?utf-8?B?MUJhdDhnNHZPY0NEanhObkRzYjR6MWp6RExkZmFpYUV0L2NLM0pBenUydlor?=
 =?utf-8?B?THJxRllla1N3aWw5NE4vUW1EQVVaY2VpWUp6T3VtUEF0bEhaVEM2Tk5rNlFi?=
 =?utf-8?B?Y2IvSStadlBsOTVxMm02U0x5eGp4QkFreDQyREtMZC9VeGswSCtZcHNCOHhT?=
 =?utf-8?B?T2NKR2M4WHdsc29jVy9POSt2TUVKaVoxUVhVTGFVb0FKd3RjOTRsSk55ekRs?=
 =?utf-8?B?N2l2RjVQMlNzQlhrWUlVV0E0MGE1UC90d3ppU1UxWmRFVFo1d2VHUUpTU3Nv?=
 =?utf-8?B?anUwWEk2WjNyVFZkTWRWMndqMHUrdGN2R2U1bTlsR0R0d2krYTYrR0xDVVpO?=
 =?utf-8?B?RTF2dkN4ZEtCbXU4eDdrNXJJclJRdFE1SDlvdHh6VWhMMUhLclk1QjJvSjVN?=
 =?utf-8?B?MnE1V1hFbHIwakhaUFhNaDJ4blg0QTVnajVUMkFXWDcyZ1RnT1VOQzI1SG05?=
 =?utf-8?B?d1NHUCtmREpjWHdsME1JMStxcXIySFlIdTRVV1VmQys0K3hHNzh0N1dSZGEw?=
 =?utf-8?B?aXBDMFdHYTBNVFNxMzNpa252aXRBbGg2UWowVHZJYVFKRXVOenJud1NtS0NV?=
 =?utf-8?B?bkZHNDB4SlFGZG5NRnRoWElZWDROdndzN1hDT2VqaGRJR2l3RkNvWGlIYWE1?=
 =?utf-8?B?eVBXTXFIQ09wUEh0N0dvdU50dHlKSkZrQ2F2MXM4TkdudTFzSGF4anRreGYr?=
 =?utf-8?B?cUhvYVVIajZOeG95V3NxZWQya25WZzh2TnIzNkpJNldlek8wWTJPMGZPL0hi?=
 =?utf-8?B?ZzNFUHowMlZuWHp5dERlL29nQW5MREtRZGtzeWhzRG1GNU9panVwT0o2b1l0?=
 =?utf-8?B?MllxRUxScjFyZXJIWXQ5QzJkbVRtVjBVMkJiWVFOcTBlZysvNE1QVHFoME1j?=
 =?utf-8?B?S2lnbzNLeWdJT2c0UU5xd3NJZnJIcmdyYnpwN1A1VlpOTCtSM01ZYnUyQXZJ?=
 =?utf-8?Q?uaU0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575334d2-5204-49a9-1488-08dcf4516320
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:29:17.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+M9uqdhw1tI1dwvKS6Cw8BJagcsf6aVAqqt3fdC7P2IH9PhVcLWxvd94Co6Ax6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816

Hi Reinette/Tony,

On 10/14/24 15:05,  wrote:
> Hi Tony,
> 
> On 10/14/24 12:51 PM, Luck, Tony wrote:
>>>> What advantage does it have over skipping the per-domain list and
>>>> just providing a single value for all domains? You clearly expect this
>>>> will be a common user request since you implemented the "*" means
>>>> apply to all domains.
>>>>
>>>
>>> We started with a global assignment by applying assignment across all the
>>> domains initially.
>>>
>>> But we wanted give a generic approach which allows both the options(domain
>>> specific assignment and global assignment with '*"). It is also matches
>>> with other managements (RMID/CLOSID management) we are doing in resctrl
>>> right now. Also, there is an extra IPI for each domain if user is only
>>> interested in on domain.
>>>
>>> Some of the discussions are here.
>>> https://lore.kernel.org/lkml/f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com/#r
>>
>> My summary of that:
>>
>> Peter: Complex, don't need per-domain.
>> Reinette: Maybe some architecture might want per-domain.
> 
> To be specific ... we already have an architecture that supports per-domain:
> AMD's ABMC. When I considered the lifetime of user interfaces (forever?) while knowing
> that ABMC does indeed support per-domain counter assignment it seems a good
> precaution for the user interface to support that, even if the first
> implementation does not.
> 
> There are two parts to this work: (a) the new user interface
> and (b) support for ABMC. I believe that the user interface has to be
> flexible to support all ABMC features that users may want to take advantage of,
> even if the first implementation does not enable those features. In addition,
> the user interface should support future usages that we know if, "soft-ABMC"
> and MPAM.
> 
> I do not think that we should require all implementations to support everything
> made possible by user interface though. As I mentioned in that thread [1] I do
> think that the user _interface_ needs to be flexible by supporting domain level
> counter assignment, but that it may be possible that the _implementation_ only
> supports assignment to '*' domain values. 
> 
> I thus do not think we should simplify the syntax of mbm_assign_control,
> but I also do not think we should require that all implementations support all that
> the syntax makes possible. 
>  
>> Since you seem to want to keep the flexibility for a possible future
>> where per-domain is needed. The "available_mbm_cntrs" file
>> suggested in another thread would need to list available counters
>> on each domain to avoid ABI problems should that future arrive.
>>
>> $ cat num_mbm_counters
>> 32
>>
>> $ cat available_mbm_cntrs
>> 0=12;1=9
> 
> Good point.
> 

Working on this now. Wanted to confirm if we really need domain specific
information?

To me, it does not seem necessary for the user. User cannot make any
decisions based on this information.

All user wants to know is if there are global counters available.

$ cat num_mbm_counters
32

$ cat available_mbm_cntrs
15

-- 
Thanks
Babu Moger

