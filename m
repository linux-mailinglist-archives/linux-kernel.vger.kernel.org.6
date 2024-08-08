Return-Path: <linux-kernel+bounces-279544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA894BEC2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FF21F23AF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B1D18E033;
	Thu,  8 Aug 2024 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PiivER5s"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E341156654
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124916; cv=fail; b=kjNWhAygVEgxSb0j15CROXNQzRLZ+dx8VJpRodBUUZCN/jDmQVuE5vHoIP6TdElG2r77zXWMWxmOHqa9I1SnPAN5Z+WQ/pM8C26txpLpzCsT2Fm570vCTivBfFkYmB8+HkE2rWx16Z/7fWojR2j4yxJCvPIWazidz9c9FJfVp8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124916; c=relaxed/simple;
	bh=r9/UGGyLBs/Jz+tMXXRUng0l0j3XAoAKKGkQjew0M/Q=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=FfGUI/lLRiVUL7YXrN6CW+dzyd1eKuHOIvy4afDN0E5L5Gk6dbPJvIANMZ+UoEPNJnj56upvNxG1XgpGjwCEyTkuXZVFG70bVbGDtgwyMjbPdzAsoxpoeXv7JGlYeyPydBWyzkjVIqy02WJZKiTqAR6K8P4N11xChvXe7y1s5AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PiivER5s; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tetiaiLdyby8W5q5IsxUtw2d3zCNoqW5hSlF061i0nCIpMxiukzf2sbzmsNK4LtsltD+ceu9ag9e019TCjB+J7LMMhz7vdKDTB1VlA8G+d6P5WDou7fqbVNNAe8meoUOUEWhuVtQOe556rndEKBaV13tosqjvMQFQucXc2+09l28kpZUH0h75rQdQmw7RuoTxXh+8opYVFQ+R2wYp0tHDMrd3rTD9z1HHwTYae67MOAXXc6rDuxuPKTHC3UY7tRT+vJLeZ5aBRovY/I/HyUTKjJgYyakUz5qqJw5FfL66lBkpsEAtlVeTI4mON2bgwPAFZvU52BPGaYRyoYCwEBo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9Hk9D5HEp57LYhgreoEMq2AXPaHG3qNtj1DLQYdHXA=;
 b=tnJ+AOwBAz1Tb9U0FOU29yyDOEmGzujXEWOy2CIKj/5K2r1/7RSWQaC4t45W30Q3HqJCndrhsPdINLPDzZHAGxA/g8Isdxk4b1QoUOLI/2E2NdzWTjFr5ir7TmMn9AgjR7MCHIwdSMleBLbLRvTUyb1f4FbTCvyl8VS5mZJxFaJ8/Vqs2e2XH3PP2eRF2FbIWWTplKSENj7QuxIJianM80OUEp8lbesMiIq0j3LpYM/yevZUVB6DIcRXUi2nE5khO9lHESodVDyc8SV61sLYMWTBfGHKIv7BBNTsj+yCHOCP+3OPZFdycbwbsXDLVionCf2uBQ9ElrdEA350G931iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9Hk9D5HEp57LYhgreoEMq2AXPaHG3qNtj1DLQYdHXA=;
 b=PiivER5s1v/WSh9u8I92GAtYECuhalgaoCjAoyiHfEvdwo9ddSqDxhsAl8UztYJju+mTFnd/bTbIVy9nlze8owPwZg+1SFv2/E4CeNUTQdC71tjJ2PSvN7rSG686IGoW413L5+wOJaSoRiiA2lolSqdzf7Vgk6qLB/W0lZ1V8uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 13:48:30 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 13:48:30 +0000
Message-ID: <bb34abeb-c26e-7f72-2e3f-1c189c1ed871@amd.com>
Date: Thu, 8 Aug 2024 08:48:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Alexey Gladkov (Intel)" <legion@kernel.org>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>,
 Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, decui@microsoft.com,
 John.Starks@microsoft.com
References: <cover.1722356794.git.legion@kernel.org>
 <cover.1722862355.git.legion@kernel.org>
 <83aa03c8f95ef00a6cf2fd6fa768c4b13e533d1c.1722862355.git.legion@kernel.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 5/5] x86/tdx: Implement movs for MMIO
In-Reply-To: <83aa03c8f95ef00a6cf2fd6fa768c4b13e533d1c.1722862355.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: da20e41b-bb63-446a-d932-08dcb7b0c9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFJidnc1N1l5YitNaGFkNlN5TWlGdjMyWk5pZCtVZkVFa3MyZnJVL2o0VTFF?=
 =?utf-8?B?cWpJRlJiRThYempKU3FTMDdLOTJaUVF6MlVYYWdZa25TeXhuVFMzSzlZOUhT?=
 =?utf-8?B?c1VCKzA4TXlTL2Juam9pR1ZYalMzd2ZxWXhLMmJORXRYaGZZUEloQjROY3Er?=
 =?utf-8?B?K0UrRm1SUHRDWFFCYTc4NlFXbVZvd2FVYWlVQ0llMHdyYVJkazRqZDNCT0NB?=
 =?utf-8?B?V01nSUVwM2svWExMYitZZGFrVXV1SmVxTXR3SzBpeWJ3Wnd5WkJQVTlMSmFm?=
 =?utf-8?B?SHIzNG5sbkMxUGdKTUVkZENiU3VDN3BhdGYvRVZvZUVadnRhNGdhSmQwcVpG?=
 =?utf-8?B?bXY5U3BqTktNM1luaCtFVXNiYlhuRVBNRTZ2ZDROeHdZbnhvWXRra1NWdEox?=
 =?utf-8?B?eHY4bFAwOW1keWtHNm1rOXNnWnpYZVBOSmRBOE15Z0FNTCtSY2JFQ2JVajZE?=
 =?utf-8?B?RGwzdU5tRi9iekVnRFE2VzlubHVVNnVlNFliT1U5UTdtTzVXQUlxTEFTVmRO?=
 =?utf-8?B?R2RRdjgrVVV0eVNObk5kWEp0NWxhRzlUVjl5RVRWbThnR0pSazVZdlVidXJv?=
 =?utf-8?B?allUTE5SOXRnRmdjamFzOWQ2YXJwQnB6OHFSekg2RlZCUTJRc3cxUFUycVEz?=
 =?utf-8?B?dDJOQTFRMXdIN1pJblV3TGl4by9hMUNFMzV1M3BqbHlVL1kxU2tHTUcvQ0tY?=
 =?utf-8?B?KzdMYlR0QWhVZGg2MTZWaEpjWDVreDVJYjZZUWhSK2ZrZWo3Z0tQMGhVcTZG?=
 =?utf-8?B?aU0yNkE5Qk14WHQyK3FIWFBZT0tsWkVjQlhlMWhmY240VmUra3owS3hNZGZr?=
 =?utf-8?B?V0RkVlBoS1NvUGpMdVBlM2M0OHdpM0hCZDRtVkZmendmSW9zNEtseEVCMmc1?=
 =?utf-8?B?MUJVMk0xSVBjekJZYnp6ZmVZUjZ1ODAvS3crcHN1b3c2bTVycUVOZk5WS0pS?=
 =?utf-8?B?WW4yUldZSWltMFpZd1lYQWtBU1R0R3FaekY0T2NGTnFlQW9EcGpjQTFtV3Nx?=
 =?utf-8?B?V01DMkFSd0FFbDV6NE1vRTVWSFZtbGlnQzJYREs1MTVSWFVvWXdkU2NvZ0xl?=
 =?utf-8?B?NzFYQ1Z3c05lVVNDU2dkNUpRMEJ2RWh1V3d1eGROOXdxZXY4QmJ4U2xyVjVn?=
 =?utf-8?B?S0NvOUVzM1Z4c01LSXh3SWJzTFZqSFRsQ1lldFNOZ0pWNCsrQzR1NlJpUFYv?=
 =?utf-8?B?Ym55d1dta0g5QytLRVM1RzZwMlQwdWdSa3BmNUthWFJsL3NEODJ3UmNIbVhV?=
 =?utf-8?B?Y1M3N2JxSDhhNmxPeWFDWklXOFF2V0lHbDY3eXVCZEh6a3FOVnN2dmI4eXhV?=
 =?utf-8?B?VHUxc3htTnVoYjFSU0VnK1I1UWVjb0ZNaXR1TWVTNWRwODdUeDhTUnRuUUVo?=
 =?utf-8?B?SVl4QS8zK3F4ekJ4MGU4VS9sN2xKM0N0M29tbENHeXIyOFU0Ym5EZ3JBL2wz?=
 =?utf-8?B?VGZScGVQV2RZZS9KVWJ5cVhaYTVmNVVzMlUrTmVtZUFab1B5OFNLOHNxd0Y0?=
 =?utf-8?B?K2xHS1JoL2hNR1FrdWZVNFpsQStoM2ZBMmVibEFodjR2Z25kU1o3Y0ZtNDVT?=
 =?utf-8?B?dGQ1YU9UNWZKY2VxbFFNVTlKTUJSVVk4a1VMRjFwa2k5NDgwZEdjdFpDbnJO?=
 =?utf-8?B?d2lsYk5iVlV3Vm1KQWF6UFROOUpLNVgwY1hBT1NkNTM1eXBLWTA1RlMvaGtJ?=
 =?utf-8?B?TlhLOG5Ma2QrZEk4bks0b0VtR3o0TE5qTWh2YnFoV1BuN1hMc0lSOGdwbHg4?=
 =?utf-8?B?a2t4MGkxNWIxTjA3eGRpNDIxVTdVME9WQXN6eC9vTE5aNC82aTNMTE16Mi90?=
 =?utf-8?B?MGpkdFNmWmhvYjNIeHluZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG92azV1VWhEN3VCdGQ0VkFXV2h5REdEZUxHZmUyTFZvR2ZDdUh1ZGZQWUU2?=
 =?utf-8?B?OVpLaVZPY3FiUURMZjhlVUN6eWRJQmxUM210Z0xsRGxadXIrT2xjUkR1UUpV?=
 =?utf-8?B?dlVrL0EwTEpkZkZVSkdtc09kT21lQTdjaHZneWRxUnBiM2JJNDNYN3VrYzVD?=
 =?utf-8?B?bkxpVXNFSUU4L0doUnV6cXFsYVgrdEZyNDZGQnVhWUxsalB5QkVjYkw4L3FG?=
 =?utf-8?B?TUM5ckJSRzFKZkQwQllXbkdXOW9UVEZMRkxoUlczcTkxUldhSTl5bVZrd3JT?=
 =?utf-8?B?bk1tSno1cWp4NGVTWEhoc1pjWnJ3YjVJa1V4dGtDUzhSMEtMMlBWK3JYYjRB?=
 =?utf-8?B?b0ZBaGFBMEc0VVpQUGR3TjgvT1RPODl2emdvdFY5T05qVTgvS2RxclFOcDYx?=
 =?utf-8?B?YU9qVmI0eThKN2NzVmE0Ymk1bFFyaThTQjJrSFRrRWVqRS84Z1hDc01Pb1Jl?=
 =?utf-8?B?a25DNGU1dmx0Vjgycnp2bG5BSkx3TFV0eHprR1lwTVBWcm14Nmx0RXV0Y2VO?=
 =?utf-8?B?aU4zcEhPd1hIcG9CNDZzQ1JGcStjSVhzb1YwdG5ZMXB5dzJlaEFjQmxwTXBG?=
 =?utf-8?B?dU42VmhsVHU2UjJ4VUhuVG4rdlNuYWNYY3hUeGlhQ0RMT0ZzNURnSSs2bVZK?=
 =?utf-8?B?RkRJRUZ2OHp2ZTFyQ0tzTUhqWGxyOG5vZXQrQVR3VnF2VDRyOWZuK2l3VFZr?=
 =?utf-8?B?SXI5aXlnSi82TzZkYmhtdE8vU1FnWDJDYzNKOEVDcmNXUGxxR005WmtzdFFl?=
 =?utf-8?B?SXFyQzhBUkdCeml3bHBkZWxlbDlUbHVjQ1ZUVjlQVy9RbE5YS1hWamlVOGxa?=
 =?utf-8?B?WVBwK293QjY3d3UwQlVReDUyUGovMFFzWWEwTWlZTzdNdm1SUldjUW84RWkz?=
 =?utf-8?B?d3kzVHYyZWFVdkFDWnJwekVqRHIvMnZCWUpaYWxFR1hCcU1xbUQzcnp0d0E5?=
 =?utf-8?B?SXgrdnBhOS9nZm9iOFFvTzMvLzJDbVQ3eEZHaEdOZE03V05kVDU1ZXBwSlNJ?=
 =?utf-8?B?dHQ5NFhKT2t1cDY0Y1NhOVhyNmNyTjVrZlVzUy8xUUZJWFVlMzcvTitndjVI?=
 =?utf-8?B?WTdPbms3RXhURElQR3greERhQWdFSWhOK0w5YklNbWRTZmg1SDZNVUhYQ3lT?=
 =?utf-8?B?QUh5Q281NFJHYXhuTHUzOUhiQ1dWOUJMb2ZlREJwYS9VL3dZVUd5d2FtWmhi?=
 =?utf-8?B?SnZqdGNVYmhwL3hsaEZHYnJGTUdINVZPVzN5aUNiWDQ1dElJSW5OSHBGSVlX?=
 =?utf-8?B?WWVhV0hIMTRyUGdFbzRIREtPUTA5MjhMZDZwV2czTEtCQkI5RGErWElKdXUw?=
 =?utf-8?B?cGpKdHVrVGJQZkM1UUFyaE9oRDdwa1EveUdRd3pSNjVBTk1ETXpJZEZGSUVV?=
 =?utf-8?B?c0lnaTVreGhzUWRkYWlJM0prZE5nNmxCczNaZWpHMXB6cDIrWlRMQzFRWEpM?=
 =?utf-8?B?MndWNXYralQ2S3FUa1Y5ZlY3SHQ0WVRpdlhFVnpZZ2VwbXF5VGd6aXBBaFZU?=
 =?utf-8?B?cmY0M2V1VlBWU1Z5QVhrZ3duSHNyMzRjZXpTanFvZVZJd3NpbmRuR3l2dENu?=
 =?utf-8?B?WDdBeE9PL09Db0ZweW9RbjdySmpZZmtkMG5ocS8yRFk4VnJ1elF2aDd1d0Qr?=
 =?utf-8?B?ang5eUFVZVh5Rkp5QURUUldPdDVpYXdtOVg1T3o5SUFaZGUxbTl0VWU2R3ZC?=
 =?utf-8?B?Z3NKam42VVlzSGZaalE1b0lBajcrdVl3N1RidjdRajhSSDFyd1k2dytjTEZS?=
 =?utf-8?B?Nyt3SHBFaU1lT1diRXFZNnZzM0JpWUY2eU9NNmJJVGQ3WmdPVnIzanBNNENn?=
 =?utf-8?B?WEtMK29VSEZOaVlFTzJDNUxvOFFzMktFRUpBTVViWjJDN1M0MEtRUEpUdWpT?=
 =?utf-8?B?RlZWREh1NXlYdk96dVpGTnFpZm5ubmVmVWpReG1YTzR5OGVTVE8wdEtGTFls?=
 =?utf-8?B?NCtFKzNzR3ZTc1NZcnU0ajJDNk0xQnJRa3I0RzFOQjg5aktxYXdGbnU2WVc5?=
 =?utf-8?B?MjBSTWlnWDNhNHFPQzZqb1dzWG5pWFVlMTF6VXNVc3ptdE1OMjBQV3lXNTVx?=
 =?utf-8?B?THJNT3JXZGtTcXRtWGx2VUdyVHdveUlidVVTaGk1eWlOOVVIWjRwOTlZSjNY?=
 =?utf-8?Q?RcJnjNI2zoxJNd9BYZh8sTSJN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da20e41b-bb63-446a-d932-08dcb7b0c9a9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:48:30.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAUJlMqbb+NDv8ClzF1Q+UggbYuFErwKkYeU2pgnrnP2zv4NEXLFWnep8nZEgg/fyS5xmHAH3Y75PfKQcxZ7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055

On 8/5/24 08:29, Alexey Gladkov (Intel) wrote:
> Add emulation of the MOVS instruction on MMIO regions. MOVS emulation
> consists of dividing it into a series of read and write operations,
> which in turn will be validated separately.
> 
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> ---
>  arch/x86/coco/tdx/tdx.c | 57 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 4e2fb9bf83a1..8573cb23837e 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -509,6 +509,54 @@ static int decode_insn_struct(struct insn *insn, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +static int handle_mmio_movs(struct insn *insn, struct pt_regs *regs, int size, struct ve_info *ve)
> +{
> +	unsigned long ds_base, es_base;
> +	unsigned char *src, *dst;
> +	unsigned char buffer[8];
> +	int off, ret;
> +	bool rep;
> +
> +	/*
> +	 * The in-kernel code must use a special API that does not use MOVS.
> +	 * If the MOVS instruction is received from in-kernel, then something
> +	 * is broken.
> +	 */
> +	if (WARN_ON_ONCE(!user_mode(regs)))
> +		return -EFAULT;
> +
> +	ds_base = insn_get_seg_base(regs, INAT_SEG_REG_DS);
> +	es_base = insn_get_seg_base(regs, INAT_SEG_REG_ES);
> +
> +	if (ds_base == -1L || es_base == -1L)
> +		return -EINVAL;
> +
> +	rep = insn_has_rep_prefix(insn);
> +
> +	do {
> +		src = ds_base + (unsigned char *) regs->si;
> +		dst = es_base + (unsigned char *) regs->di;
> +
> +		ret = __get_iomem(src, buffer, size);
> +		if (ret)
> +			return ret;
> +
> +		ret = __put_iomem(dst, buffer, size);
> +		if (ret)
> +			return ret;
> +
> +		off = (regs->flags & X86_EFLAGS_DF) ? -size : size;
> +
> +		regs->si += off;
> +		regs->di += off;
> +
> +		if (rep)
> +			regs->cx -= 1;
> +	} while (rep || regs->cx > 0);
> +
> +	return insn->length;
> +}
> +
>  static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
>  			     struct pt_regs *regs, struct ve_info *ve)
>  {
> @@ -530,9 +578,8 @@ static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int si
>  		return insn->length;
>  	case INSN_MMIO_MOVS:
>  		/*
> -		 * MMIO was accessed with an instruction that could not be
> -		 * decoded or handled properly. It was likely not using io.h
> -		 * helpers or accessed MMIO accidentally.
> +		 * MOVS is processed through higher level emulation which breaks
> +		 * this instruction into a sequence of reads and writes.
>  		 */
>  		return -EINVAL;
>  	default:
> @@ -602,6 +649,9 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
>  		return -EINVAL;
>  
> +	if (mmio == INSN_MMIO_MOVS)
> +		return handle_mmio_movs(&insn, regs, size, ve);

You check the address in the non-MOVS case using valid_vaddr(), but you
don't seem to be doing that in the MOVS case, was that intentional?

Thanks,
Tom

> +
>  	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
>  
>  	if (user_mode(regs)) {
> @@ -630,7 +680,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	switch (mmio) {
>  	case INSN_MMIO_WRITE:
>  	case INSN_MMIO_WRITE_IMM:
> -	case INSN_MMIO_MOVS:
>  		ret = handle_mmio_write(&insn, mmio, size, regs, ve);
>  		break;
>  	case INSN_MMIO_READ:

