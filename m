Return-Path: <linux-kernel+bounces-332917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2497C0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC51C210D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C99175D20;
	Wed, 18 Sep 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VUE5qkwb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748B224F0;
	Wed, 18 Sep 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726690782; cv=fail; b=umpfBw1EIb2NFX+9zj76wkfQCC5SeZhHjAs2pPSsW0F6dM4YnFoEQ5NzTyEPVgCgJNzVFKKDDxbONpBwoUaos3htWq+GBvTyJdWjRrMX9Uv3ogr50HjT4ACpvBw/cML6Q4Vh7cfraZ4upFy3OmujtRwq2Ra5VulrOHz5Kby0Gcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726690782; c=relaxed/simple;
	bh=fqPJR1uQRkCRi52A8+a3QRMQH5Mpwc3tKTVeMWL8Yp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rAKWxw/z1TVeDJM1xMMfwoyrzB7xvibPsuwg/9N0MQLpS2bBoirdeyfKSM/wEVpgyQ7Hcf4djPd/cF8qoSXfSLuhY/6N01QN505sE5SOm3XjpUpCbkyq1pwtm4BlCc/rQMcET5Ukw+gsAOg4tJH3/brrGH+dpjlXhRgqUZw/rC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VUE5qkwb; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldN8kILBIzwjlgNx1di5fNFTI6pZwTXTc17l/XIYyitftZYbe9LvVrXdGL2GIaSYq+PYCaz1uzYxApHZUqXfqwbqZ80bKGI23jdy8jqIqHTEk7QRxux9pfgll0uRT321pnoz2tA6EK870xeTJa3+x+U+Z/vDwJXZO9wWl0MmoYU+Rj463r3VYBiU3VzhZKfh97QHwVTL6ezH7Pm4tbUw81tuiY/b5Sm8y8dMCqxnIuhqqNpFq0djUWmCIMrA6DuTUUymuB19PMdCtNVFwIYfbKGJ1Qot8dgTQL4eDD8UOHJav1x4++Zt9RWx5bn4D35InMWlXtGFyNw1wowSj3JcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm2RlHVPWD9bUWBdp4Bp1lrVHq4W64A6GUS19SuDL/A=;
 b=tWCz2qYI3NcflPzweEXzLWVrp7BdpR2lwd6RsBR92PQH2byhwadlzH8h7SRtRbNUTNYmu8iIs0UflvPFl71pBRy8OgxZhXOa1WyBGrQOG1k7ZorYFhD7HasSR7AKfX5CJQpElWg7sUeLy0ru6pKI0pgYGrpgFeekysH0sP2oG2hgzTD0CTr/bAwlSomVOmfF7hlX3INHhDlY6dYjOXUqRIhNhc44+4K4JnURFeSha6sA1EkgkpICp89LcOk/dqdadnmQycgl8x9QJ9Ps6nUdljBqG+s0TVmDuGtEh+rZpp7u2mkJlqqE4wvX2YeBkS88jb2kFKrYxQq2cdss831s7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm2RlHVPWD9bUWBdp4Bp1lrVHq4W64A6GUS19SuDL/A=;
 b=VUE5qkwbQWdc82ScK9IF9jmELpoBlI27sQ9bJAknYwu9ihlGcQ6depw3BOKczMKmh2X2DMnq1/Cx3jQ3YYeAkqbr/DVt4tC14vCXkUzRttcgOpAdBZBVIuiSrmsn8zBNwDrNabY42nR0xI1QykNTV7fuqxSa5cZJ0ezlm9hSulU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 20:19:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 20:19:37 +0000
Message-ID: <15824c9d-b39a-43f8-b33c-787053061d70@amd.com>
Date: Wed, 18 Sep 2024 15:19:33 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 6/7] x86/resctrl: Introduce interface to display SDCIAE
 Capacity Bit Masks
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <52902dbb00069b4f6685835deab83748a7472b8b.1723824984.git.babu.moger@amd.com>
 <f1b98b0f-d2ab-40a3-87a0-193e67f345e0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f1b98b0f-d2ab-40a3-87a0-193e67f345e0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:806:127::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e3848a-a5ed-4273-abc2-08dcd81f37ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2UxRFBTWEt0eDVUZjY0RzFGYU9YZlpJcUxHWnhUSHVrV0hpRTEwUm1CQW9a?=
 =?utf-8?B?L3ZRYlFpSmhjS21XWWlBQmNtV0NTVzFQdmdnMjBaY3BhTHVMbHIvS0R4ZUVS?=
 =?utf-8?B?SkZIelBWd1psWXhJcUNKbVE0Qkc1SHNZZEY2SVJpMXpVVTYxaG51QmpNYVI3?=
 =?utf-8?B?aGJWTzgzV015MWxmaVdKZk1vV21SWVgzdmczNHoySUh5RHVtcHYrNTVjWFRa?=
 =?utf-8?B?MzRlMnBuQlFqZ2lCcjVRd3pZSUNRZ0U0T0MwUHlpT3I2cVJIellwMndxNENP?=
 =?utf-8?B?dTliZWVZK2paUVp2RWl0alcvSXViU2tHZXNFSzF0VEJmQ2lTNmZXUjlYdkZD?=
 =?utf-8?B?aFBtWDFldWYvQzRZQU9rR1JBYnFSQnpnT1lIZGpEUUMvNCswbWFWNHZHTXY5?=
 =?utf-8?B?K2dVOTN6bVdpa0hZUStnU3VCR1NITTZLWEl1L0VSOGtBb3UwaDNCdzhKWFBn?=
 =?utf-8?B?NTB0ZXlIc2tuRDhoQXlRTjFnTVVkZFVDQ3UzRXpUYUhqYk5XeFFUN1dkN3Q2?=
 =?utf-8?B?aFpncnJmbnFQTGtZQlhzWnRaTTZtSEwrclhUaXRBSVlleFl4OVppcTZzQ1Qz?=
 =?utf-8?B?ZGN3RVN5dkx4MEYyY0tOR1lEV0tJSU54bEdKbmZjL3BKeUdseXNYZnlPMkZz?=
 =?utf-8?B?T0VSb0FMQ1RRdU9tR1F0QXhSU1lYSSsyT09FRURyOEIxSDZudFF0aDA5c25N?=
 =?utf-8?B?bEhDTGlja2M0bVVJN0hCd3RUcmNCMGErZEFRZm5PSk1SdHpXTTlwYVJkSFJj?=
 =?utf-8?B?WjQ5MGR6KzFhTlM0NnJMbnUyb2UwbmpVK2Rnc1Vsd29IUlZFcGxtYjVPT1kx?=
 =?utf-8?B?OEp5RE1FcDA3bUhNUDVMTDM4bDNnNWg0ekFnK003WlJ2enhMcFBxUUNpZ2Yx?=
 =?utf-8?B?Z0M1ZS9mV09aME9EWSs4UGJzaXgxNlRuR0RjWld3eUxWWXA2NjJ5Mi9OUDZt?=
 =?utf-8?B?alJZMGt0cjBrck5RYlJxWURlNUVEZXhyaFMwN0VVdUp3dHZWL2tONWVqRjBD?=
 =?utf-8?B?MjZlMjJuRWJPL2hvVUVWdm9aZ0s0N2lWNE85K1hRRG84OGpTZEo3ckt0ejh2?=
 =?utf-8?B?ak9LWjE1Qjd4cDJPYzV1ZkpFSHZWWk9lS24ybnZ6ZzN6cXZoa0NwaTgvQXE2?=
 =?utf-8?B?ZkJrNnRoY2NuYk1FdmpsWGxlaTdPcmhXcVBoT1Q2VkRsa0UwU0pJUXZOVjZV?=
 =?utf-8?B?MGNBS0NmbGdsOFNpRzB3dHZrTUNUVmt5QzZ4cHVKR2V5NEZxeC9xekpYRkVn?=
 =?utf-8?B?YnQ4QU9BR1Q5cUlXUHFUaGhsMWhiNGpZeTY0R2JQTkZxUVNHNTVaV2E1M05x?=
 =?utf-8?B?R3JQT2h0VzNpVUdsbW5sNDhBRWxVVks5ZGF2eXMxTEUvV3BYNUtjQmRIb3Bm?=
 =?utf-8?B?ZlMvY2FPNWdCOTJWYm9jWHdXdGdObFNyT1lzbkxZZkxsYUJxWWJyaWNxZUtP?=
 =?utf-8?B?R3NGZGtaTjUxM2hGeDAxTlhJNVc5N05LU01xV2NhbW0vVVFXY3NCUmxaWVBY?=
 =?utf-8?B?Z1R6N1hWYjBHYkpRMGJSWmJSTkZ1OSt6cUVaWFYzcjAyQ1VGVWVEZmNMMGtU?=
 =?utf-8?B?ZUoxd2NWNHNTMFN5Uld3aHJ6ak92dXdlSEMwWU5jK1RUdzZ0Q2NXYllzVXJQ?=
 =?utf-8?B?L3FCN293bmJocDJpazFvd0QzditzeXR4MlYwRldIbGM4QlVNMzhHUWg4KzJu?=
 =?utf-8?B?MWcvTFVaYVA5NkZneWs2aVVJQXNjSVo3aDhKRkZwVEs2UnlUcWlmUll4L3FR?=
 =?utf-8?B?SERRNGF2Y0pOckpGZWhzWEU1WkdMWU00eGxuekpNSldGVStUNEw1azhmT3lC?=
 =?utf-8?B?clBGcGhJazFiak5OdWhhZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THJyVGJQVUZlMVNURnZmR0E0cUQ3aTB5QkovQTQ0YS9ZOElYdzBTM3RTNXhi?=
 =?utf-8?B?RC9za3RsbHRqTEdUYmx6eEViVFpvM2FTeU9ibmF2N0JMQjZGdUcrOUFwZEdN?=
 =?utf-8?B?ZW9JQ2p3Y2FNRXo1Q1RuZ1poOHZteS9nRDNSQVRsOWpyWU1kNkQrSFkwaGE2?=
 =?utf-8?B?MXdDV3NKV2V1LzRxNitHb1lVZ25TT1JVMVNHZ3l0N3k0cmJlWFRrS3dldnp4?=
 =?utf-8?B?YzkwYVltbU1TZlp4MFlRRUJrREFlbFVCRGlHeW56SXh3Tllib1lGL1BUemY5?=
 =?utf-8?B?OHpyRGZCcW1oRXpNdXlPM2d3WjFsRlhaYThqMWxoeWxNdGdhQWVEV1A3bHVC?=
 =?utf-8?B?aXhRR3dnMzZPTUk3aVF2V2x5dTIrUTVRc0JPUWxIY2w1ZllBcE9EZHRRRXRS?=
 =?utf-8?B?S3FlOFkxbEhtYzhiR2tPSGhOY1BrUm1oN1dpNHpZRGtKUFRlOTlHclNUUll0?=
 =?utf-8?B?dHQ5OGxyWVBrbXlFNEY3VjFJQ0s4dTRIUGdONFZoVFNuMzlzcWVKbDJGa0ZH?=
 =?utf-8?B?Tko1MlhRSmZCMk51SUpWU3B1MnQ5ay8yQlg1ME5pQlhxa0JieGE0THNDWUgr?=
 =?utf-8?B?aEcxNGJmOENBb2tVME1WQXdubEs1MkM1cDladVRZZEtWd3RpM1pCZUpGRzlz?=
 =?utf-8?B?emZYMXMzRXJqRGtCalB6cDBxWnh6YmhwZ1EwUWMyNTcxbkkxb2xBQ0FhYXNx?=
 =?utf-8?B?RTRTRmJpZWRlanhjTzJFOTBwWDg4WmVjRFBCalFvaXk5ZXVHbU8ybHBSVnN4?=
 =?utf-8?B?dkVNVnhsTXJrWlp0ZnQ2cWFJOUFzWFIwMWkrS0kwVklpTU84Znh2dGdJc2d1?=
 =?utf-8?B?dnpHYlVaY09VdVRUdVRiOTRJUms3eFkvWnRPNXZvWFpvUVhsZHN5a1JGUlZw?=
 =?utf-8?B?U0tvRFdIVGVObmV0a0NyYlZkaGhQc2NmN2kxUWM4QStYMkpZYlVrTE12a0Jm?=
 =?utf-8?B?Z3lobFVwbmo4VFRlc2dhTm9EZFlBUkszZTcxZGhZTzc2V3FqUWdsTTlEQWFq?=
 =?utf-8?B?di9KS0RoYnU0YlAzYzdpMUVVR1RQKytFbCtJLy9lNnNOY3VUYTI0bXptZFVG?=
 =?utf-8?B?ZGhTQVltWDNpY0phMHhydkpvbHo0NkFxcmg4UGN1ZVBLdVhPU3BvVTREaW1C?=
 =?utf-8?B?Mm1BVVFvZ0w0VFNIZU5GUnIrSUNuSU1mK1dCY3dPdWRLSy84YTVoL0dxbDhj?=
 =?utf-8?B?emZ1b0JXbU1QbThEaHFub1F5WFJtY21LZ2xCNnZsclBCVUxObWNFRitoek14?=
 =?utf-8?B?ekgzVGVlMVE2ZTFiTWgrajdjQ3J3VThCSkFOVkZGSmQ2emh4T3dqSTYvVUNT?=
 =?utf-8?B?bW5Wb2EwK3ZCVlc3ZEp2dk9FMFVGM1BIKy9LVVdjbFFoeGh1eXljNUNrTGdU?=
 =?utf-8?B?WFU5T3daeUxseWhUYk8rb2huRmZSUUdYSng1c0FoV3hoMmU5TjFNWkJwLy9n?=
 =?utf-8?B?VDRMSC9XODlab0ZUL3RramFiNWx6cGdwallRTFhUcGlsVEpBZE9qVjY3SkNL?=
 =?utf-8?B?VUluUGxPNWJlbDRFaDVLS1c5eURJb0hUYzJhY0ZsUllRSHJTNVo4ZDBTQllK?=
 =?utf-8?B?UEhoRCsyNHVHNE1VcG9EZ3lURDQxU0ZMa3VCbEF6UEdGdzFOZXk4c1FFT2lV?=
 =?utf-8?B?R0VrYm52T20yakI3SzNJYWJMMEszUzJoeUN6eE1lWjROaXRza2ZDNTFTUXQ4?=
 =?utf-8?B?cGR2eWF3M1Zkd0JLbDRPbjdqalFFWTRpUldSanFLQytVaGp5dEloUWpNUzBa?=
 =?utf-8?B?ZU5TZkNRVjZmT3p3ZGlpY0p3bTROODdpTVQweGpkWHBORndPRXI5OXVXK1lD?=
 =?utf-8?B?UjBSNk1kQ2pGUjMwOHBxS2ZYZnhaM3NDSEMzdm9YMDA1cUVBVkZRZ3g4SGlM?=
 =?utf-8?B?dldnS0lYYXprdU9IdnFVc2RranhpVFQrbitNV3RES0dLenlYSCsyb3VyNS9X?=
 =?utf-8?B?a1JhVkNkTk9ScDY2MUg5MUdUdWJ4YVhiZW5ISjQ1eDY5cXZrcWtPb3VXMGlX?=
 =?utf-8?B?S0pvNzdObkRmWlZobElrQmFDOWs2KzhTS081aWlyVWpYVERXRG5reW1TYjNp?=
 =?utf-8?B?Q290eW1hczV2MUJsdWNXcC93d0Z6bnBtYTN2cWN6eGxrNzJicG5vRmZPSlNm?=
 =?utf-8?Q?GJJc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e3848a-a5ed-4273-abc2-08dcd81f37ca
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 20:19:37.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhvlkGt4UgBsGuCbIIRadc78OMA++BZ9HjIZBIIvcT54SH/M761PB0qdYpYdPbkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846

Hi Reinette,

On 9/13/24 15:52, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/24 9:16 AM, Babu Moger wrote:
>> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
>> partitions identified by the highest-supported L3_MASK_n register where
>> n is the maximum CLOSID supported.
>>
>> Add the interface to display CBMs (Capacity Bit Mask) of the SDCIAE.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>>   arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++++++++++++++++++
>>   3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 50fa1fe9a073..fc99f4d17e6c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -439,7 +439,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r,
>> struct rdt_ctrl_domain *d,
>>       return hw_dom->ctrl_val[idx];
>>   }
>>   -static void show_doms(struct seq_file *s, struct resctrl_schema
>> *schema, int closid)
>> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, int
>> closid)
>>   {
>>       struct rdt_resource *r = schema->res;
>>       struct rdt_ctrl_domain *dom;
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 9a3da6d49144..f2c87ca37b13 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -663,6 +663,7 @@ void __init thread_throttle_mode_init(void);
>>   void __init mbm_config_rftype_init(const char *config);
>>   void rdt_staged_configs_clear(void);
>>   void __init resctrl_sdciae_rftype_init(void);
>> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, int
>> closid);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>>   diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 58e4df195207..51bc715bb6ae 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1922,6 +1922,25 @@ static ssize_t resctrl_sdciae_write(struct
>> kernfs_open_file *of, char *buf,
>>       return ret ?: nbytes;
>>   }
>>   +static int resctrl_sdciae_cbm_show(struct kernfs_open_file *of,
>> +                   struct seq_file *seq, void *v)
>> +{
>> +    struct resctrl_schema *s = of->kn->parent->priv;
>> +    struct rdt_resource *r = s->res;
>> +    u32 sdciae_closid;
>> +
>> +    if (!resctrl_arch_get_sdciae_enabled(RDT_RESOURCE_L3)) {
> 
> (same issue with this file appearing in all cache resources, eg. L2)

Sure. Will address it.

> 
>> +        rdt_last_cmd_puts("SDCIAE is not enabled\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    sdciae_closid = get_sdciae_closid(r);
>> +
>> +    show_doms(seq, s, sdciae_closid);
>> +
>> +    return 0;
>> +}
> 
> This really needs protection. (You should have encountered warnings
> via lockdep_assert_held(&rdtgroup_mutex) and lockdep_assert_cpus_held()
> found in the functions called.)


Sure. Will fix it.

>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>       {
>> @@ -2081,6 +2100,12 @@ static struct rftype res_common_files[] = {
>>           .seq_show    = resctrl_sdciae_show,
>>           .write        = resctrl_sdciae_write,
>>       },
>> +    {
>> +        .name        = "sdciae_cbm",
>> +        .mode        = 0444,
>> +        .kf_ops        = &rdtgroup_kf_single_ops,
>> +        .seq_show    = resctrl_sdciae_cbm_show,
>> +    },
>>       {
>>           .name        = "mode",
>>           .mode        = 0644,
>> @@ -2187,6 +2212,10 @@ void __init resctrl_sdciae_rftype_init(void)
>>       rft = rdtgroup_get_rftype_by_name("sdciae");
>>       if (rft)
>>           rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
>> +
>> +    rft = rdtgroup_get_rftype_by_name("sdciae_cbm");
>> +    if (rft)
>> +        rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE;
>>   }
>>     /**
> 
> Reinette
> 

-- 
Thanks
Babu Moger

