Return-Path: <linux-kernel+bounces-428351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACDB9E0D41
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7FD165239
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1952D1DEFDC;
	Mon,  2 Dec 2024 20:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pHW40WXH"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037051DEFC6;
	Mon,  2 Dec 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172177; cv=fail; b=Etc+ccHlm+xwAOC5cQjj3I71DBNuVTmqPofcxJ8d3DikhofI2JQzhf1wXtTSTHQ+IstTbvNKcVud55ywggSC6LW02S24Wm1Eww7TPYLVA7a+P+wQQoV+Wl7U8Wv/BX3+6/JLIltieCM8Z8ixrAYmm1HRo4EOEEyfzx6mS61R/Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172177; c=relaxed/simple;
	bh=ZbQ1K923xs0DqdD6heudieRP1Is5KLmQqLJjgxGfcto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b76+rpa0OrRgJHXq8Mv9RkpSSroHJuZ2iZCpfbIiQl3T3T4wCi6owOdYwEaE47tmpUZTFp+H3qniHLxSim03CoUgtJUNM7d+e+yS5NIHF1jefHrWzR42WEBiof6rPNaKsc9a9rVLLmf1sG1ErBRUC96Ro0JP+AVR7m/R7E2HJQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pHW40WXH; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3/sDsW1a9BfaPgfLuJYuQ2QKRWjoqcZNEnPXO6wevuRAa+ox5s0ZFx/jieXBZjbc28Mxm2kJn97RqTlEuSuL8+nvQSU+5dYky0Bg5irQTn1ThpM9O9BZXqHkuSPwJTdbqotFvxoeViWEWHnL/XLX6M8iQ3MxNoPI2WFL5xGuRqW71kC7WqvpPzJNIktgz1HjpCyFm7UhaTtnA7G8yPRvaybVS4iAIH3aVx8r9lq8rAlJ2AcAf7WWweZbVuhrtKzgyvrpiapnlvgfFV/Dy44mlv/VeopOD6+1V3I7IzS4MRJ/6u37BH4fB/H3JHgDI+2VrEFknUKVH2l8ZNkR8oM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUzmL7Mht/KYJrFp1zjeh6Fj/Uh0Xr0LgJV11ELdmeI=;
 b=Rio7sXJyzGBtINoY4Op0OjAiAXCXhkEPvQhdCLU+jKeadPtnJZcROkR5XuXGZwGm9ZF50KJL8r5mKRU4gjH9APMVCxM503tut3Km/ZPHp4nv2ELGZ00iTA9ZERoaawVOYznrBzar+ydymR/CqMV+TXjYgQ4olMnSAUl/nuOSnk0eyFezWbTRSafcoBgY8qtpdWJzcHfgvWjxhyCkgP/D492R+lG7bIirhkdGyj7OMdfOCBu+sXLIVqhbGnQHu1aRtmegoOhgM+D6g067lnpZqZpNJeCHXLJqkiDJ+ju8t6dPi3zLe5hcIzkZ6jtOKPEROJz7WbBUuZ7DHWkgT4hlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUzmL7Mht/KYJrFp1zjeh6Fj/Uh0Xr0LgJV11ELdmeI=;
 b=pHW40WXHMvwK8Scx3qfTuzzEO+432A3/6/45nCfAjPvevpKGt8wRRHDxPSFBc3sY2QHXMi9iUXKKcAFYt3vsRc6RnNSO8FYpLrn7nXNr/Velu6tDN/xGIp737ycEV1e7BTaMQol4Y7QLKR0xsgikqk2UiEKPBlpSU2GgBNN+SgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 20:42:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 20:42:52 +0000
Message-ID: <03b5f7f2-d347-44de-85bc-0a346651d487@amd.com>
Date: Mon, 2 Dec 2024 14:42:45 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, fenghua.yu@intel.com, x86@kernel.org,
 hpa@zytor.com, thuth@redhat.com, paulmck@kernel.org, rostedt@goodmis.org,
 akpm@linux-foundation.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 perry.yuan@amd.com, sandipan.das@amd.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, seanjc@google.com, jithu.joseph@intel.com,
 brijesh.singh@amd.com, xin3.li@intel.com, ebiggers@google.com,
 andrew.cooper3@citrix.com, mario.limonciello@amd.com, james.morse@arm.com,
 tan.shaopeng@fujitsu.com, tony.luck@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maciej.wieczor-retman@intel.com,
 eranian@google.com, jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
 <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
 <5a8eaf67-baaa-4278-abe5-cf68f795d4bf@amd.com>
 <c9b0115e-d994-4239-b2b2-12359878ec7a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c9b0115e-d994-4239-b2b2-12359878ec7a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0053.namprd16.prod.outlook.com
 (2603:10b6:805:ca::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cfa654-2e44-4725-d038-08dd1311e498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGFBZEVwTHNiamMzV0NhZVZreUtEVHdNSnhWT3h4NU9kQTZOSUJZSHFsWkZ0?=
 =?utf-8?B?eFBIa2ZoUExTc3oyeE56cUNReWxCYUorY0R0QXN0Z2FuRUVta1p6NzVWK3Y5?=
 =?utf-8?B?cU9HaFNlR1hwcXdsRm9pWUhiUlhDVWN6TEVnOHNCbkkxSy9NY3JGL2tvWTRU?=
 =?utf-8?B?d2k5ZWVHSXNIRUh6ZUl4Y01LbjR2S2pDa21GVmlrU2wxcjRvUWJPbnFtM0N3?=
 =?utf-8?B?b0NqaU56YkxZeDcwU3pKZUkvQjRyZkFydFZQNWwzV1ZTTTJ6RU5zNjMyZWNu?=
 =?utf-8?B?TnhuWGJkY0VjbmJWWXpUdnVtQmFnQksrOWxWTmszQnR2c2wyeXNITFQ0dkE0?=
 =?utf-8?B?a1Vab1ZkWnlyZHpid2FNS0VIVTE1S2VnUE5xQlg1NEdNMXFEM0kvS0w0aEFY?=
 =?utf-8?B?TXE1Z3B0eVcrdEo3ZythREozUVlJdTJpS0ZibUVwcG5majZWQTYrQ00vb3Nz?=
 =?utf-8?B?OStRQXl3ZWlVV0owclpvRmdnNlB2L1l2ZlBCTGJtcENKc05IR2tQc1dlYWIv?=
 =?utf-8?B?MzRpeTBkNmFPMldtR21NclpmVjltRDBmMklJZ2FlQ054aDFhUDFHbG56cXMw?=
 =?utf-8?B?UTdWWFdKQlk2Zy9ZWk12ZUFXRHdBZEtiTUh3aHpyVlQyWEVTTHJCN1pRMmtx?=
 =?utf-8?B?SUNNMktiRDU4Z3lvZ0dybkdvNUFkbDcvRFFjK3U2NmdvQXBER0wwWmhiYXVZ?=
 =?utf-8?B?Tkd5dEcwcGpoYmdSVkZxRnNmRVRPckxWaVpzbkNGK2RwSjFXVThpUktPajM2?=
 =?utf-8?B?VFJ6M1hTN3o1a1BHTHhhdTgwYmVwSDltVHpQamZQNllsamJOeXkzMTFDMGxS?=
 =?utf-8?B?aU4xSGNwZlJFSVA3REI3ekN3RStVQnFtK3NYR00xM1QzQ1VZZUhnS1Jqbnph?=
 =?utf-8?B?dU5vcDZZOVo1ODYyQWd4RE5YQXFqK0NVcDFVc1dldTdybzh3eWV1bFVuSEJR?=
 =?utf-8?B?b200U1U0enFBNUUvTUJNM1lwOTMvYUtCb0ZYR3ZSQThKSkV0bzBuZm5tWGtY?=
 =?utf-8?B?amwrV2gzc05nbjdhUWp3a1daVEg3ZWp6dFlPTFBwZjluSzRub3JMbm1KZlFm?=
 =?utf-8?B?VU5US3AveGYva2RFOElNQWVaczN2YXNBNGxNTXVUb0NlTE9tbU1vb09ibk5B?=
 =?utf-8?B?d3NnU09HdVZoVjkxeHd0cXIxVUFpVjlUb05vWFQ0OUZJeDNHcng2OXFOblVH?=
 =?utf-8?B?QUJvOFlILzlhdmF1ZE14Vmp3U0tpS3NOUGdPNklRcmRiNkc2N3d0bEJlQmRS?=
 =?utf-8?B?c0xwT0JTaEcvVVlJWEpGM3hBRmhPdHJqWVA1RHJCM2lXTXBvOXdrV2xDTVFr?=
 =?utf-8?B?QlkydXFpWGdEenRtZ2F5U25DYmVLanVaNFlkeHJreDA1WWlGcmhSVnJrZmlM?=
 =?utf-8?B?OWx5S1ZnaWhFMGlzZldLa2czUXZyUk1PQU9ONkVJT0x4Mm1uazZWWGc2TDJO?=
 =?utf-8?B?NW5CUWZ6MGR5MUVUMjlpd1NlWjhDaG90NWFKbUVrWGRPTFpjZE1FUW9XYnNo?=
 =?utf-8?B?REdKbkdVT3BMNnZ0bjF5ejdZaXE0dzFqWG5vWGwvSzV3VVVqWDRPM29VemhU?=
 =?utf-8?B?Tjl0WENjRy9YTWhZRzZCWXB0RVcwUU9ndi9vaFJ1SzRod1dBUTdjUTE0WjBC?=
 =?utf-8?B?NnpPamxoSERzdXNLdjVNYmJkd3IrWG1rdUQ5L1RJMy9hb05sb1JCL0dqai91?=
 =?utf-8?B?QzV4RHZ2TldEZXg4MVJ1bnpQOGdFU0RLa0Z4N0J6STliZVhON1YyWGpmOWlR?=
 =?utf-8?B?ZkNJSjhOcERSU2tibW5EMDZvSWE5eVp6TVdTOTF4Mkt2RW9kMm5qRlJZK2l4?=
 =?utf-8?B?eTQ3TkRMTlV5NnBqc3BPZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXpDeUxwRVFUemloQytvVUJ6OEttWVFCL2Q0ODAwdHYvNjB0WXVLSStBczdk?=
 =?utf-8?B?T2Q0VFF1cTNmdUJJd1dMTEVmNG5MVGRpdjlRaC9XWTlhMVJoT2EzdDI5d2lm?=
 =?utf-8?B?OWxlS3lrMDVjN0VlblBNR1dQdUtXS3VzQXp1SnVvM0UzQzBYU1hOK1lVTjB0?=
 =?utf-8?B?RGl6NjkzV3JuL01oUFlFV1FFZFlLZy9RM2tjcmwzd3ljQmR4ZE5jOVo4STBO?=
 =?utf-8?B?QVIyTER5MG5Lc1JhWVI0ckZ3ZzE1emI5WXc3SGx3YzhPOUFDaFJ6SkY0RUQ1?=
 =?utf-8?B?RGw2TlMyWVJzaEsrWGNXaG1XZURzQmFiTjY2ZWprZmVHNVFiYkV5VDlPZENQ?=
 =?utf-8?B?L1RxZG1WSzMxb3lJNmhLakdaVnk4MUx3cVVhd0JLYkhsNUdKc29LaWJVNEtF?=
 =?utf-8?B?S0RMVXhTZ0ZUNXV6V0c5SFFRN2laYXVqZWdEc3BMSHRBNjlRTXh1UC9Nekxw?=
 =?utf-8?B?eVJHWFZxdG81c2RLK0szeFF1VTVKMG9OOFUwRDFzTjlKRlVuSUJ3a2NNMUIy?=
 =?utf-8?B?RFV1YVRwblpjcGt6TEpXZ2pLRkZhUHFoSmxSMVRJSGNab2wzN3hTdU82RFJK?=
 =?utf-8?B?UkwyWXB0b2VKZktmUWxWbXRRMVc4MEdROHAwS0ZhWGxoK3hVTGtXYTJxNjV0?=
 =?utf-8?B?cmFjUUE3Q2gxZFVMUEpoMnNKQTRHS3V4djlxOEpxdXBQY2RTNWY1UXpCRlV6?=
 =?utf-8?B?QkdmYnNBS3lDUnVZQlBoREtNem43a1NPWDc1akFQVXNsajlXOW9FTkJZK25G?=
 =?utf-8?B?VVJESW56SHJpeHBldW9hK2xKM0ZKeVBJUGNCK3V1TWRweXlPekQyOHJxMDBO?=
 =?utf-8?B?dFpOUUU0UTdOenhIa2lub0x1NkFLYkFUZFgzVjJmUitMWmRNNk5GWVB0eVdP?=
 =?utf-8?B?RG1lZ3pHWjRuL3dXZjFmSmRVZTdCSExYRzVNNW5WRjZxTU9SWEc1WU1ZL2cv?=
 =?utf-8?B?elhYOHM3VzNEK1llYVhjYkg2blNiN2JEWC8xNVFxTlVKV1dGT1g4Tit1bEc3?=
 =?utf-8?B?cjZwczZUQ2ZFcUNZY0hEcjYvT2ozd1l2TmhBanFkQWF1eUNOZTBvNUxWRUVm?=
 =?utf-8?B?WDlRZmo0dkFCMDdwYXdiNlRsTktvRHp5cEQ0TUJTVFVJdVdnN2dJZHpqamhR?=
 =?utf-8?B?WndIQWhMUmdmbXQzdjNVQ2RIQkE0V0xWZk1TMXJQNkdUaDlDbzUzM3cwV3FN?=
 =?utf-8?B?UnlkNGxaVHdIalRmSHplMkZoZ3gvMGJFMHAxQTFSM2g4dmlFTUlXVXFWQlZ4?=
 =?utf-8?B?Y1dtcS9PWkhROUsra3ZaWksxVk42YUxUMTJWMEhsWTd1TlRRYndJSm4xdk1J?=
 =?utf-8?B?K2ZoaHJWSm1iY3M0WjJta1NCZnpNRHRQdjBKTU84czhqTnNtV1lkaXFrbDV6?=
 =?utf-8?B?NFdNWmZrRCtJVWR0V1h1RUdKVXRlWTVrUHBHRlNNdmJzWUgyWWFaaSt2emtL?=
 =?utf-8?B?a1VhSitMSnlWTWRnSGFERGhES0graHdacnlEQ2RjbFZZS2V2WEFjaGR3WGxu?=
 =?utf-8?B?ZS8wSXNXeS9uZ3JHWXJVRGU4REtQRWZERFJuVGhnZ3V5aFpGNHdjTXZQN1V2?=
 =?utf-8?B?UzNtV0w5L21GUmNIcXNrc2JpSStqWE50dW9OUEVaR0tBK3BVUXM1OUwzcmFX?=
 =?utf-8?B?dVNrU1l2YnRnTzNLbm9FK2lha21MWENBRjgrcjU3eTk4Q1FDMm9ZSFVLK0t6?=
 =?utf-8?B?Q0lBK3lQcG1Tc1pyZEQvZCt5cWpqcVY3WCtZMm5BVzVULzNpT2FNTVJROWNy?=
 =?utf-8?B?VXlQZTA2S28xY0syK252OTBjT2piYk96cURQVDVYK3pYU1VhN045dC9WWFhw?=
 =?utf-8?B?L2hSY2I5akhKS3JWK1g0a004bWpYRjN4OUZWVVMyckpZajdBcFg5WnVYa1hu?=
 =?utf-8?B?VTJQYUZwTWxXVWJPRXhGdmlDbkxkbHNmbkN3bFhrVHlicHcvS0ROai9zVDVS?=
 =?utf-8?B?MVZXVVdwaEgwWXQyT0c5Z25BZ0M4Y0hzN0pYc2JFQjNmZzREdEFHMEZhTHZU?=
 =?utf-8?B?UHQxalVYbVpyTHNqMVlRVHRUVW9pUzFaME40UDFxRGtIR3BSTEt6Qng5WitD?=
 =?utf-8?B?dGVBNlYzWkVpb0toWmgwVC84MS94b1VDcVluZ1Z6TTNldUFzR2hpRmlCNGpM?=
 =?utf-8?Q?Nqco=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cfa654-2e44-4725-d038-08dd1311e498
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:42:52.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eunOVj+g7jrBsvz4hv/Y7gWasV2WT1wrF5ls9RxnBWfMbnCROJ8y+orpjHbHZNQC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121

Hi Reinette,

On 12/2/24 14:15, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/2/24 11:48 AM, Moger, Babu wrote:
>> On 12/2/24 12:33, Reinette Chatre wrote:
>>> On 11/29/24 9:06 AM, Moger, Babu wrote:
>>>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>
>>>>>>>> Hi Babu,
>>>>>>>>
>>>>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>>>>
>>>>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>>>>      For example:
>>>>>>>>>      Resctrl group mon1
>>>>>>>>>       Total event
>>>>>>>>>       dom 0 cntr_id 1,
>>>>>>>>>       dom 1 cntr_id 10
>>>>>>>>>       dom 2 cntr_id 11
>>>>>>>>>
>>>>>>>>>      Local event
>>>>>>>>>       dom 0 cntr_id 2,
>>>>>>>>>       dom 1 cntr_id 15
>>>>>>>>>       dom 2 cntr_id 10
>>>>>>>>
>>>>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>>>>> group:
>>>>>>>>           struct cntr_id {
>>>>>>>>                   u32     mbm_total;
>>>>>>>>                   u32     mbm_local;
>>>>>>>>           }
>>>>>>>>
>>>>>>>>
>>>>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>>>>> current implementation deals with domains that come and go. I do not think
>>>>>>>> this is currently handled. For example, if a new domain comes online and
>>>>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>>>>> not configured to the newly online domain.
>>>>>>
>>>>>> I am trying to understand the details of your approach here.
>>>>>>>
>>>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>>>> monitoring domain structure for tracking the counter allocations,
>>>>>>> because the hardware counters are all domain-scoped. That way the
>>>>>>> tracking data goes away when the hardware does.
>>>>>>>
>>>>>>> I was focused on allowing all pending counter updates to a domain
>>>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>>>> processed in a single IPI, so I structured the counter tracker
>>>>>>> something like this:
>>>>>>
>>>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>>>
>>>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>
>>>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>>>> domain.
>>>>>>
>>>>>> Are you doing something different?
>>>>>
>>>>> I said "all pending counter updates to a domain", whereby I meant
>>>>> targeting a single domain.
>>>>>
>>>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>>>
>>>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>>>
>>>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>>>> for readability)
>>>>>
>>>>> echo $'//0=t;1=t\n
>>>>> /g1/0=t;1=t\n
>>>>> /g2/0=t;1=t\n
>>>>> /g3/0=t;1=t\n
>>>>> /g4/0=t;1=t\n
>>>>> /g5/0=t;1=t\n
>>>>> /g6/0=t;1=t\n
>>>>> /g7/0=t;1=t\n
>>>>> /g8/0=t;1=t\n
>>>>> /g9/0=t;1=t\n
>>>>> /g10/0=t;1=t\n
>>>>> /g11/0=t;1=t\n
>>>>> /g12/0=t;1=t\n
>>>>> /g13/0=t;1=t\n
>>>>> /g14/0=t;1=t\n
>>>>> /g15/0=t;1=t\n
>>>>> /g16/0=t;1=t\n
>>>>> /g17/0=t;1=t\n
>>>>> /g18/0=t;1=t\n
>>>>> /g19/0=t;1=t\n
>>>>> /g20/0=t;1=t\n
>>>>> /g21/0=t;1=t\n
>>>>> /g22/0=t;1=t\n
>>>>> /g23/0=t;1=t\n
>>>>> /g24/0=t;1=t\n
>>>>> /g25/0=t;1=t\n
>>>>> /g26/0=t;1=t\n
>>>>> /g27/0=t;1=t\n
>>>>> /g28/0=t;1=t\n
>>>>> /g29/0=t;1=t\n
>>>>> /g30/0=t;1=t\n
>>>>> /g31/0=t;1=t\n'
>>>>>
>>>>> My ultimate goal is for a thread bound to a particular domain to be
>>>>> able to unassign and reassign the local domain's 32 counters in a
>>>>> single write() with no IPIs at all. And when IPIs are required, then
>>>>> no more than one per domain, regardless of the number of groups
>>>>> updated.
>>>>>
>>>>
>>>> Yes. I think I got the idea. Thanks.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> struct resctrl_monitor_cfg {
>>>>>>>       int closid;
>>>>>>>       int rmid;
>>>>>>>       int evtid;
>>>>>>>       bool dirty;
>>>>>>> };
>>>>>>>
>>>>>>> This mirrors the info needed in whatever register configures the
>>>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>>>> updated.
>>>>>>
>>>>>> This is what my understanding of your implementation.
>>>>>>
>>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>>> index d94abba1c716..9cebf065cc97 100644
>>>>>> --- a/include/linux/resctrl.h
>>>>>> +++ b/include/linux/resctrl.h
>>>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>>>           u32                             *mbps_val;
>>>>>>    };
>>>>>>
>>>>>> +struct resctrl_monitor_cfg {
>>>>>> +    int closid;
>>>>>> +    int rmid;
>>>>>> +    int evtid;
>>>>>> +    bool dirty;
>>>>>> +};
>>>>>> +
>>>>>>    /**
>>>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>>>> resource
>>>>>>     * @hdr:               common header for different domain types
>>>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>>>           struct delayed_work             cqm_limbo;
>>>>>>           int                             mbm_work_cpu;
>>>>>>           int                             cqm_work_cpu;
>>>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>>>    };
>>>>>>
>>>>>>
>>>>>> When a user requests an assignment for total event to the default group
>>>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>>>> entry.
>>>>>>
>>>>>> If there is an empty entry, then use that entry for assignment and
>>>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>>>> information from default group here.
>>>>>>
>>>>>> Does this make sense?
>>>>>
>>>>> Yes, sounds correct.
>>>>
>>>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>>>> initialize during the allocation. And rename the field 'dirty' to
>>>> 'active'(or something similar) to hold the assign state for that
>>>> entry. That way we have all the information required for assignment
>>>> at one place. We don't need to update the rdtgroup structure.
>>>>
>>>> Reinette, What do you think about this approach?
>>>
>>> I think this approach is in the right direction. Thanks to Peter for
>>> the guidance here.
>>> I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
>>> though, I think the cntr_id would be the index to the array instead?
>>
>> Yes. I think We can use the index as cntn_id. Will let you know otherwise.
>>
>>
>>>
>>> It may also be worthwhile to consider using a pointer to the resource
>>> group instead of storing closid and rmid directly. If used to indicate
>>> initialization then an initialized pointer is easier to distinguish than
>>> the closid/rmid that may have zero as valid values.
>>
>> Sure. Sounds good.
>>
>>>
>>> I expect evtid will be enum resctrl_event_id and that raises the question
>>> of whether "0" can indeed be used as an "uninitialized" value since doing
>>> so would change the meaning of the enum. It may indeed keep things
>>> separated by maintaining evtid as an enum resctrl_event_id and note the
>>> initialization differently ... either via a pointer to a resource group
>>> or entirely separately as Babu indicates later.
>>
>> Sure. Will add evtid as enum resctrl_event_id and use the "state" to
>> indicate assign/unassign/dirty status.
> 
> Is "assign/unassign" state needed? If resctrl_monitor_cfg contains a pointer
> to the resource group to which the counter has been assigned then I expect NULL
> means unassigned and a value means assigned?

Yes. We use the rdtgroup pointer to check the assign/unassign state.

I will drop the 'state' field. Peter can add state when he wants use it
for optimization later.

I think we need to have the 'cntr_id" field here in resctrl_monitor_cfg.
When we access the pointer from mbm_state, we wont know what is cntr_id
index it came from.

-- 
Thanks
Babu Moger

