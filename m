Return-Path: <linux-kernel+bounces-418672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58B9D642A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE39D16102A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC21DF97C;
	Fri, 22 Nov 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q2LbkQGn"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9CA15CD60;
	Fri, 22 Nov 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299921; cv=fail; b=c8usweN/iGxLF0HEntVVXlmGim/GYKR0CRKEqDmCmp5VmwmjBldd1fOY1JD9z9qYqoF6aGnwMVXo8BkDAynj/UfKBh2M9dXsUygsXVY2ikyJqFZYqoiNIfqpPVRb8N5h3en4spflrhiNPuUomuwTNzhDfayWb5ezHtUK1nkPifg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299921; c=relaxed/simple;
	bh=gm3r9JDHF3UuNcUycPKCeqa8V+2VswmKheDUEvNTGeA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hN/BEph9rscgtmrXGTYbV2oog2PAGSgxH7KNCJBSRbQl8/ORlSSPcqCki8PlhyQ6qHfzDG0kWT7SjQZArPsAZGnLqvTSCiip4XADTiCA3PBKZuPPhxy9h5lIiv9GET2UIWlHUGeJu12b/STvwM3X+HPEM7nNPxGigcDnefs9Of8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q2LbkQGn; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l16FlU9onMay0dfrP4WWLkfStNWdu+w3dmmETxCe3p3IeLCdt1VoWCBkxXfuToZ1BXsEwawfUAueBIbIZ4hTJCkvphBKDwPa4iA2vUlY3fTkek+lVs+kbdk483OwDL2NuZeZkdlaMTWSsoCH8O7m//rjS5Jov5sKBMpgazG9mLy67YDIDhUI//1qCDavwHnk6SjC0nJH+Od1gUTDvSAhOdKBkNl97pGNuEhbNqnt2n7HOz+/ZasqdBQuVxaub3olIoc88Q4FnazDomcs3/gBTyaOZYNXtS6+TfkpMObQGivMizu9iltKxPEgOAjfK4p8NCarQa9M1NMlfA8uz2aCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejazaYMTLqQ7hEsN2xZUjcpaS5291nG0oVaXH3CEADE=;
 b=fOGbvjcfnNIPgrQh0YDHS15MVRLXBNts6K7Ldxi8dCJETgWYD2T4VtXa2iW5Ce+tEwmS/UGyHioZ00HZLlYN6e21Idely5ZqAXpGQKbem02gI8+wYlnbP/9ySdIFpNhqFaJyUorMLfNG51R2QDIFzwzF8H7KPL5UlUKxXh3GLbH5xQxS8y22amNbsWYVXZQlFmprCx3c5163RRuizx9IEMcmLsG8Xh1PzZYaOC7ydcS4gxh46TpFYaC6QEST5flEmHlN+ecAGkdvjtDiVpzbvfUzfU/lePIH95JcPN2Jz/Yge2KW6sH5nhiBg3OZ5Whsy5YmlogPToR5vFPnqckaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejazaYMTLqQ7hEsN2xZUjcpaS5291nG0oVaXH3CEADE=;
 b=q2LbkQGnskytuu2duGaUGYAMMkgw+Y6JjjqtnAFXL0ziaPRwET+WjeYLTv26lrNaHzYnvw8jtcMPF1XP1nOBb5vixGdKCgIkjcLO4IsqwADWYoQQBxFeJCP+LyHh4/Rpkrt86Dc0IFh02MRZT+toWoluqcRBsVNEPBeG1YFtzcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 18:25:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 18:25:13 +0000
Message-ID: <0eff9462-e7e2-49a9-9538-c8907024322f@amd.com>
Date: Fri, 22 Nov 2024 12:25:08 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
 <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
 <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:806:d0::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: a8456aa9-fbea-4ccd-bd85-08dd0b230162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0IweVZJeUxWMjI4VElMaFEzekM2eUdNM09ORWZrVGpIckxUQ2dKNVIzMTlt?=
 =?utf-8?B?V1U5WmJaR1EvejlsV3E4Z1NONzBFL0taNENPMTlzM2hZZWNyQy9YVDJjQU9a?=
 =?utf-8?B?SERDTEpiNHYyTFJ6S0lIaFFyb1VPYlRua1Z1SEtIb3dXODZjOVNtOVlRZ2xo?=
 =?utf-8?B?ekhpbTYzQ0ZLTzJaQU1jcVJNMVVPSW5OMnFKQUxpNVozY0cxZTRDMHFseDBI?=
 =?utf-8?B?MXdleXVjNzRIajlTb3FLQ2EzUjk5TmxHWWVSUi8xRG8yUTVsM0FzYzkzVFdp?=
 =?utf-8?B?cU9aZURZTmtndzgwRWhWYVRSekE5S09QV3VPK0xDbjZQa1YwQWl6amlVYXhZ?=
 =?utf-8?B?aEVQY0ZWYzI2R3hqdU5DZ0VaeDhsdWxMTmFyWGlGMUU3bE93SHcrUVlTdTNt?=
 =?utf-8?B?NnlQMFlHQ0tGRzhETGhnb3VIY0lnNWdXVUw1MEoxaHpidEZRaTJiUmxtQlpE?=
 =?utf-8?B?N0N1WTBnTndnL1lWcTBrR0cxWWFnWXovQi8yRVEyYnRyWmQzVXY1REIvM0Z5?=
 =?utf-8?B?S0l2NzFoNVEvZ1BqV1JpZ3RWbi9XeGQ1eVpRd3NZVjRpWEMwVm9rc1hhaHor?=
 =?utf-8?B?Z0F5OVJmYTFGMXY1dVNuQVlHTDN0NzRKV1cvZlNBU2VwUzZydWRKOGw4WkxY?=
 =?utf-8?B?UWROYXVsODJudlZad0FaKzlPWnBvalNCanljQ1VmWkRHb3dBdjRmTy80VE5a?=
 =?utf-8?B?ektIWlcyRUhyMkdvTXE0RFE1d3V3WTBrNGJaZWpRQVo1YW84Tjc2UlJVdlRT?=
 =?utf-8?B?am93anNGY2kva3pCTnJ6ajR4bFozUWRsN2gzUWErb3RDRE9qMHoyWmExVm8r?=
 =?utf-8?B?dVBaeXFTZGIzWkJUbWtTNXBEMHFOYUlDWXo0RW1QNlhKN3ZmSTg2MUFnUGpS?=
 =?utf-8?B?OEdNdGdIUndKOGR6dStROSt3WFBBU2pFcHVBSThiK1pXWXFsNkZWQUVWakox?=
 =?utf-8?B?L3RvWlppdk55QXREd2tlb0NZVkpyWWNSQVl4S0NwdmtvQ2JWa0dRNVowVlph?=
 =?utf-8?B?VWhpMW9DNVBCVElZWHFsOU9uSWNkMmtpWVFzL08rRXhDbGtyWndlMVdsQXV2?=
 =?utf-8?B?dGtjeDJFeEoxblNrRlBaTldIVHl4QkpwTno5OVBWZlBnb2R0Wi9ZekYxMXNR?=
 =?utf-8?B?cVZxb0Z3RkdyZGFYVGYxc0lJTUQxaXFvZkJqbnlkajBMdklqK2o2YXdNQ0h2?=
 =?utf-8?B?bkp6SEZINHpHeE5rMGI3Y3o3YkJFWFV5cGNaUWExanZhSUpGb1czR2pWQU50?=
 =?utf-8?B?ei9nY2dBT3BTL09aSzV2ZldJWjE3eW1uZ1VjbW1IOHJMN1E0WG4xQzRKWUJ0?=
 =?utf-8?B?bENDQTJuOW5IZGM4TExHUERtSk5ITS9DRGpDYmZCeVF6WlNia3R0ZFNoVWhs?=
 =?utf-8?B?RFUyNjVxNG8yZGdWTEd2dlJ4NGEzbCtxVjJwWXpMSFV5MEM1S0VYeWJQQndi?=
 =?utf-8?B?OUZHVnBmRm1UaWVBV0Vnb1d4bC9HNW1TajdTL0hYNUhMYnpVZmhGaXNIeWV6?=
 =?utf-8?B?RnMrN3lWMmZpTWllVldhdHJydUhLNk1xbXhjaUZsaEhheitPVlRTbEt0QURD?=
 =?utf-8?B?eGM0WUlGV2FlenBxcGhNeVEwby9OdHI1dGpyajRjRmVwb2ErS1N2QWxsTkFX?=
 =?utf-8?B?bm8vL2E2anpkRE1HcUNidnA5ZUpvUGxkOS93U2V5UG9LY2VtVnloR0EwWktx?=
 =?utf-8?B?cnBCUlBacXdrU0JvOFVwajYxbVRFZkdLUno4WDlaZy9KZ2laUjBIWG1ybXUv?=
 =?utf-8?Q?aQ9u9Iksiyau999hjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2lYSHhXUGhEbFNnT09wVVlybER5UHpyVEZMTUg4T1JzK2EvVi9xakh4SkJS?=
 =?utf-8?B?L3BVU1FkY2ZRSXNnMkgxbldKNWRmSnlWcEoyZEk5VUZPTlNqazNyUnBpVjdH?=
 =?utf-8?B?SVpseWdXckN0NzJ5UEJmT3VhU042NDk4QUxWMHVuKzdjYVF1QkxQam01K1dX?=
 =?utf-8?B?ZEwxTGhvZ3NFc0dQY2FiWTVmUGtoTVlYb3lwSklRT0VoRzh2cHpKQThHWTJY?=
 =?utf-8?B?MW5xdVlXVnNuK1g4ZzBkNWJTK0h4Uis5eVA0VG5NZXZmVllNUHlKSDdKRnpG?=
 =?utf-8?B?K1BVRkp0bnp1eWREeDJyL3RKSCtEc0xuWFU3a2hIWGxQTFRFTmNMMW1IR2Y1?=
 =?utf-8?B?ZWNtOEVhWnhwWXNwV2ttdTN6OWNjM1ZtWFpsL2ZNUDBXL1pqbTl0OERHUGRw?=
 =?utf-8?B?enFvU2pGTC9LRFB0RjVyazYwenlwK0NXb3dqMVNBUGxFZzJrT2I4STYrZ1FF?=
 =?utf-8?B?a2lOMG1YeXhyenFqaDVINUw1Q1Brb3ArR1hkTDV2UXNjdTBWOFI5bEJGWlN0?=
 =?utf-8?B?NnFndjRDMGVrenYrQ21ZZW1DWjVyUGdXUjhxMzNDSzIyNDhGLzdqSU11cXRk?=
 =?utf-8?B?N3RIVkJBODJRbEx5SUt1L2FyWURBcUtvM3I0eFZVejJXRWc1aklROUxlTmF2?=
 =?utf-8?B?V1ExV2Nwdi9iZTk2SGgveURVVzNUd1BMV0pMRG1SdXNEa0EyT0k1OHJWdFhn?=
 =?utf-8?B?aE05ekxLYkN3REpSM1dVWU9rdzdsaFcvcFJJeVNsYVFHQ0l4ODNoMWtyZjBp?=
 =?utf-8?B?QVlEcHRBb2JSN2NkNzFsTk9nd21tMlZxU0ZVa1Y2U3pDTHRuUlhaYnVUaXRW?=
 =?utf-8?B?UG94b2ZBZCs0NktlcDRSR1BkeHc4K2krQm9BN2NvUmhMbmZXT0J2K3hNZ29p?=
 =?utf-8?B?S0krKzNkUDVFVS9PSTFJemd0WjF6Vy9rd21qakNQSExrSGYrQ0QxV0xJcFIv?=
 =?utf-8?B?RHd3WVJxSEJCQUhNL1V3MmFrdkdNNHVsS2I0RTVuWlBZOXlQSDFGQWlxYnJW?=
 =?utf-8?B?YnNxN3ljSTYrTmVrNkpZUXV2dEdxQW5WZVlOd1c5K1Y3eGMxbkordTVzYXB2?=
 =?utf-8?B?cm5nWmJBS3pEbFJBZEtTQTVaYmFqTGZuSElaNk1XeWVlbWRNTThvWFBUUExT?=
 =?utf-8?B?WHVwQk5ldUU2OTRiVm90aS83QzJ3NHRmN1JKd1pBRktqUzhkQXoxcUpHUnBW?=
 =?utf-8?B?TU44YnIwNmtFWWpGa2EwdnV0R3dMWCt6dndEZCtiRmY0Wks4WjRMMnZCbStt?=
 =?utf-8?B?cGJBaG9hUzZ0TzFsUlNqL3ZGZjk3MnVOTER3cnRORlBLL2VweklBR0FkcGR3?=
 =?utf-8?B?YUdrdGNKeGQyZVNHQTdnZjl4YzJIZWllR1dMSCtUMmhlTFAvb2ptQ0hHUXpK?=
 =?utf-8?B?VXNzWDNlVmEyRUErTkdhNDhzTFVXbXVKWDZMV3pDbkxQK3JHdmRHMnVISUFT?=
 =?utf-8?B?aktBaG56OUVjQlRCdHFSc0djZmpHWThwTlVocyt4RGZNbzVsc2dObHZqK3Nh?=
 =?utf-8?B?QjlncG1acHpWSm1kdkQ1dVl0WjFzQ2oxblM4bHdpOGtQN3E4T2toSjE5QlMr?=
 =?utf-8?B?NEpQUk03NnQ1aXV3WTJ6N2VzaG5lOHg1NmdtUGZVN2VPVElvZlJqQTdsbUxR?=
 =?utf-8?B?c2gxc3lFZklpYnNHYndjTUNqaWdKai9pR215cW9TUFcrU2RFOGhXQnZMcEJI?=
 =?utf-8?B?V2ZEd0RiZTh5cmNFUEM1OS94RmxWQXdIakJ2M2pNOUJLV3Z1ekJrMjc4NnJF?=
 =?utf-8?B?QjRTU3h0NEpuVng4R1RuZ1hTZVBDZFJFSHArb0hqU3FmcDEyVFBsSmtma3Bv?=
 =?utf-8?B?VWptaTFkUDRySGNobFR4Mk0vdDY0R0kyditBamxIQmRDZEhCV01HQ3FvRjhB?=
 =?utf-8?B?MXlOSWF4dGFheERqWHd4Zng5ZWtNZGVHQmZOeXNiMDBqcEp5NWdDZlJHMnda?=
 =?utf-8?B?OFZkd0VMVzJUM0JXb1p1dmxiM0k4OURHakVLOHlvbXJMcWZIRXZDTTdEbWI5?=
 =?utf-8?B?eWR5Mmd4TGg5V0VzM09sRHFkMEtYZERZZ3pqR2xvZFgrc3NQc01FMXlaeGda?=
 =?utf-8?B?Smp5ZGtldUVoWlJPWXc5ZXh2aTBaQkRONXZsQmllUTZsaFhRQlErU2Z1bWFO?=
 =?utf-8?Q?g2Gg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8456aa9-fbea-4ccd-bd85-08dd0b230162
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 18:25:13.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuACW14k+FYwx9iR6WL4aPRNYvCwQ57gkNWCkiejYjJwQZ3xSBrohgdwOeHqRNzi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

Hi Reinette,

On 11/18/2024 4:07 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/18/24 11:04 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/15/24 18:00, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>>>> supported.
>>>>
>>>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>>>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>>>
>>>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>>>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>>>
>>>> The "default" mode is the existing monitoring mode that works without the
>>>> explicit counter assignment, instead relying on dynamic counter assignment
>>>> by hardware that may result in hardware not dedicating a counter resulting
>>>> in monitoring data reads returning "Unavailable".
>>>>
>>>> Provide an interface to display the monitor mode on the system.
>>>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>>> [mbm_cntr_assign]
>>>> default
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
> 
> ...
> 
>>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>>> to make the event data "more predictable" and then be concerned when the mode does
>>> not exist.
>>>
>>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing
>>> num_mbm_cntrs to num_rmids).
>>
>> There is some round about(or hacky) way to find that out number of RMIDs
>> that can be active.
> 
> Does this give consistent and accurate data? Is this something that can be added to resctrl?
> (Reading your other message [1] it does not sound as though it can produce an accurate
> number on boot.)
> If not then it will be up to the documentation to be accurate.
> 
> 
>>>> +
>>>> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>>> +	enable this mode by default so that counters remain assigned even when the
>>>> +	corresponding RMID is not in use by any processor.
>>>> +
>>>> +	"default":
>>>> +
>>>> +	In default mode resctrl assumes there is a hardware counter for each
>>>> +	event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>>> +	mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>>> +	with that event.
>>>
>>> If I understand correctly, on AMD platforms without ABMC the events only report
>>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>>> is unassigned and then reassigned then the event count will reset and the user
>>> will get some data back but it may thus be unpredictable (to match earlier language).
>>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
>>
>> Yes. All the AMD systems without ABMC are affected by this problem.
>>
>>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>>> available, while not be made concerned to use "default" mode on Intel where
>>> mbm_assign_mode is not available.
>>
>> Can we add text to clarify this?
> 
> Please do.

I think we need to add text about AMD systems. How about this?

"default":
In default mode resctrl assumes there is a hardware counter for each
event within every CTRL_MON and MON group. On AMD systems with 16 more 
monitoring groups, reading mbm_total_bytes or mbm_local_bytes may report 
'Unavailable' if there is no counter associated with that event. It is 
therefore recommended to use the 'mbm_cntr_assign' mode, if supported."

> 
> Reinette
> 
> [1] https://lore.kernel.org/all/35fc70fd-0281-4ac8-b32b-efa2f4516901@amd.com/
> 

-- 
- Babu Moger


