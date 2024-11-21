Return-Path: <linux-kernel+bounces-417433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF659D5402
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F825B21B44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515631D363D;
	Thu, 21 Nov 2024 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dJAfZyj/"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883ED1CB331;
	Thu, 21 Nov 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220952; cv=fail; b=TEGHOxJRlCfn+PCh++UDViZoTtilt2ZKTjqMQCk1d6UpJ71vYF3QN6s7JwFw39JMG6C7/a+jzT/O7MzAferYwQfrrZF7eZMZXfM+pdCVVpz+TUy7Y5kNC0HgP8tU2MHyUK23kW3e87utI22mDAFh5ykSIyuOUjkABbnI6P+LEIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220952; c=relaxed/simple;
	bh=HMEudHUWtx/rJm8bCQOA5EKEQ4D4HIqJqwZeXwsPvfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SMby3rzESIDnifL9SS5A5SdZzu6CL9EMq09gw9sYafznmoOJt3LeEl22e/0kY7J+0XTdGYbCTD6GPUoKNR+vTs5YMFP5Pz68CQleFfm/0LlBD0Hft63pNoJz+XXPo7XCYwfRAt9riafZsNgcYxdf5Iw1lNWn4jh/XB8y30f7ifU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dJAfZyj/; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYwLlTQoxzEh2ToBPSoWEO/u+UL0H0qObm726zYIzQYS8YNhN2+zkByEoTDqBpem4dbb9vdLfGDavtg28yh/XysO+KsTF4GUBZQ6ifYnhxPWNElvgLQs+M4YT2B9riAWp9304b+H6Ohz2M9Y+evqPGR2eSewxh0fZKt9v1aJ7Dz/jUQTVGSkG0lmp93MFLi/vtyuUDA+uNu+khUN9DPfii6foDB4mL5xaC0NnjFBM1x2wZI6orXgWsJDqg/JNcXHJKykwZ12hqVaLyfVYE2UtAz7H7WveOvW/IOmU7WhfVM4QA96a6qjDaqrpJPqvrMi2v9/y8hQGFPtMcTtvP4BVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTxWPxa5wRK6WvyxD3/Hd42IVWbMO7e9jhQFYchcLbA=;
 b=iuKUbb3Yqs9NBlsQMtYWvqhN/+YAuuLT/8MzeYDo3kE9XQvkwmJFDZenFAGK262p1CYp4sONA3c8U+2kQd8G5+MJpSkoZP1USgxVu0ViaShYYA6rnEpAz2GHlLNxooeJ3Um4qqzB0revwyJlypot7HDV6/W20A+PYdBaf3OoU3Tma/7HSFl4i5qttOyQWPR+T4gnxkoesi7jcQY6gAu8eMW8q7nyhrpmrK2x9wVtLEY/aim3OQlaVBrduhI+EhrRU7vuc662K/GxFkem6Hd47jRL/dMCd6eVw3w5SXiKjXQtUkr4QsxXxfqfzGWPnP2RMzdrwdl1wYCuwYfjZI9BdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTxWPxa5wRK6WvyxD3/Hd42IVWbMO7e9jhQFYchcLbA=;
 b=dJAfZyj/nihnAW1jl/5iZWvEZPhpXmZQ29F+7ATAOgtjO7zT8cmV1Sjc+Wa0wp4YT0R/HvQte/hUqcTxh/Q9CroNnlZRobNz44M3iL8w1dpzFPSUtAJTS1Ny2vjlziLU5dilciXku7Mt4GuEBg0xFtK3mpxmgvc8NOvv0VPyOCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 20:29:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Thu, 21 Nov 2024
 20:29:06 +0000
Message-ID: <e344399f-2123-4f73-ad76-a2daa63259a7@amd.com>
Date: Thu, 21 Nov 2024 14:29:02 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 26/26] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
 <1dfa8b184a00d94013470b2818c23fd8eab66baa.1730244116.git.babu.moger@amd.com>
 <45384d5f-a6e7-4a82-974d-84e189381b36@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <45384d5f-a6e7-4a82-974d-84e189381b36@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:806:122::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f46d4fd-1bd1-4492-99a0-08dd0a6b2574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0NYbUlscWFJNkxKQTlxcEE1eTFyVWorUlordm14bmJyZzhCaThuQWxnUktn?=
 =?utf-8?B?c3JuZVpGUFprVkp2N2pSUVVWcW51SXI4WlRsb0MyWExjY2ZRNXBjR2dtME1S?=
 =?utf-8?B?OXU2alNXQjhVQnA5OFdDNlRrdE9TZzlqazNrcWpoY3lwVEZvMFJ0QW0vYUFQ?=
 =?utf-8?B?Mmp3M2RHNmlLMjhxVVBQL0s4c2pXaHFpbjU4YUJqOHkxVHJwclpML0dDL1hY?=
 =?utf-8?B?WVAzK0o2czJFVUlMWlFWeDRkQU9YbEEySFgyZXpqcXlVRXN0cmtYd1dvbEpO?=
 =?utf-8?B?eUZQYkwxa3N3NmtPU05jekVoaXJtbWhINDVmd3VQYUdRaEEyb0J6bkNpMDRR?=
 =?utf-8?B?cmhQTHJJVU9wZWRzQmtMd0hLQytVSnJZVi9kN3ZLaHJhTTBzNlhWVWNkYS92?=
 =?utf-8?B?eXJzTXJNQWQyajZJN0dqckZnNVQwaVJzL3VZQ3QzbkVSUG9sYTN3UHN3TWx3?=
 =?utf-8?B?ZlVST2x5Nk04MTVFS1ZaVWJZY3BscThlWlZEZFErUGpsM2d2OVVKNFIwcWNq?=
 =?utf-8?B?amdRUFhXdytlOGZYUXJwU2Y5SmcwekJOTnY1ZEJJclBBYjVxclJBeDRPYnl1?=
 =?utf-8?B?clBGY3RtbWpLM2FEOGM4VlZGVnN1RUtaUDdZNUpyWDFZWXV5Tlc1L2R1ejhw?=
 =?utf-8?B?R3JNbitkUEFjOVVERys4UG00WmxLa3ptR3dzVTJQR245b1ZlK29CQU02cGI0?=
 =?utf-8?B?Zjc5N0V4Y0hNVXZ6MXFIS3huQkFVelV3WkRkd255ZGJJYXlqenRLb29QQjVR?=
 =?utf-8?B?NzdEbHhmd0pPTFlDSjZ5dUtvVTJIcTJCT01rcGRESTdvNlZ4NVNtbmgzTG44?=
 =?utf-8?B?S3dGQXNDQm1MN01lakdyWDBwcEJwYklqZ1dsSGhqU1ZXNFdBSDFwN0dTWVNz?=
 =?utf-8?B?dGd4SzkxZndkand2TkZCNC9UYjcrR3NvMzVPbDBOSHNIdmJ3cGZ1MVF1VXht?=
 =?utf-8?B?U3RRS1ZlNHpqc3lCS25VUzJFNVAzeVNlZ1BSMUVUem1nc29KNWpwN09scnV1?=
 =?utf-8?B?bkhhck1qMGtzQUtTYXlvZkg4Tytrbk9jYTh4WnBDazFwMTd3amlENXFDOHBh?=
 =?utf-8?B?OUc4NHhrU1UralNseGpoU1kyYi9mdFFMLzQyUjNrMDFuR1FyQkszNGhDeEgy?=
 =?utf-8?B?U0hlSHIrS0d3SFhuek1HYXlVOXhOcTFCMTVwUUtSU21WRTkxU3B4ak1lcnJ5?=
 =?utf-8?B?SDI2RzExVjNiYllZWldlQStDSnRqYW5GSXdDRU8wemVOaENyK0VJVjRkcnBs?=
 =?utf-8?B?QlJ6aWIxZHFGYWgveFJXczFBZldGVHRzaUxiWGdHR1k0bkw4c1VvY3BPRGE2?=
 =?utf-8?B?c0NlTkV2eWFhU05NM3pTenlMTFJTNi81cDhEVjQ1aFMxaXdaTk9UYThVY2hW?=
 =?utf-8?B?NzRVZHYyalE4bGowQnA1L3pXRjZzNUFDZWJJVEIxMTZKVGcvMXl5Ujh6aFNX?=
 =?utf-8?B?dXlkZVlqQmRsY0YzemYzTkQrT0VmdHJ6cXJDTTgxN1ErT3RRbDUvWlV4OFFl?=
 =?utf-8?B?ckxWQ0lhcmlGblN1QTFhWDB5eVNTb0wySEYvNVl1eGhQb1hhR1BPU3lvUkxS?=
 =?utf-8?B?R3E1WVNCazJLVFBuajZuVUZtTDNrQWt2cDlHMXBlem10RXp3enNPUTd5S1k0?=
 =?utf-8?B?VWVJNElZV2padGdST2lCYjlEZW0xdnhzaTZwS2tYSFlicXhRZTRReWE4bjBy?=
 =?utf-8?Q?1845cvJ3Oo65BOVL0R36?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhPZi9hMlFiMnMyU3ZVZkE1Z3lxeEZiTWRTQ0hmUE01NmNTUWZnRUMwWHRs?=
 =?utf-8?B?a25NRjVPM0RtV0tYa1ROZ1Nvei9GeDB1bnVMVXJjY3FpNW93VThiRDdsOU5I?=
 =?utf-8?B?aTFPbkREM1M4OVpPY0VRZVB6aEQwWVNaYUx1WmpzVWVSdTlXNkdsVURuOUgx?=
 =?utf-8?B?dFhFVlhkM3c0ekhSZGhUR21meEdGMFQxMlVVRzV2c1hLQ2pYZlp4bmlVT3c4?=
 =?utf-8?B?MlF2a2dYY1ljYkRiek5SMk9ibHVBZnFYSG9saXJKb01MK2VnSk42b09qd0o0?=
 =?utf-8?B?QU1rQjN0bnFjcTBIVWNPTTZzeHBneFdkV3hEU2k3bWJIaXAzcHNJbE1Idnhi?=
 =?utf-8?B?bUJBRHZtU2F6eFdRZGpIcmNnQlBrUHd6VTMzOWJmZVA4YkMvdjZqdlBST1Vp?=
 =?utf-8?B?SUM3by9yVlk3Q1BwaHVuNzFrdWFJMzVPQTVjdmVCS1VnbHdrMjNTSTUvU1RB?=
 =?utf-8?B?RzhJNXhYUGdRTjVlN0hMTG1Cd3plbldmaGMzeVFSaVpQRVRuZlBPVm1pK2M3?=
 =?utf-8?B?aFBSeHd4bDhSV0xSK0pJV3BOSnpmZllqTWRsQ2RObmNFV3VSS0RuZnAvbVk1?=
 =?utf-8?B?U213aFNhcGhHM2k1RWsrS29YM0xXRDQ2eE9mQ3B1bTlsTldHdHMzbEhaaG5C?=
 =?utf-8?B?dHpDNzdEdXI3SkxTVUEyYmxJb2wyL1dyZXBBSW9obFNBa3hxQ0NSYnBOcXRo?=
 =?utf-8?B?SXR3TWxlUlZzT0plZnBGQTBLSlRzN3dmMzVPcis3NXhXdkpoNzJ5dnJOQjBQ?=
 =?utf-8?B?dlZYSE1INTBiZ1ZiMldpVFJHeTE2eU4wY3lNaGNnY09kWEFLRjQrdnNadFdL?=
 =?utf-8?B?T0hhY0VDSFV4TDc5ak9jUTRXSWIrdFBkTzdNTUd6ZlpIYTUzRjQzZWJsUEZV?=
 =?utf-8?B?NWlVVDI5cHNHRkhzbFdHVW5tc1ZqcXEyemRLWG9mRUE0dnZ0VHJ1Q0Voekxk?=
 =?utf-8?B?aGdycUpUR1RlYXd6Ny9wS21zQ3Bob3pYd2oxUkVZWW9YNUd5RHp2dEpwLzMr?=
 =?utf-8?B?OFkrckxjL25iaTkvU2xwWGlBeklBQVRDUEY2WkhDdFMyMXBNM2NZUmNGN1Rs?=
 =?utf-8?B?K05tckRYYk92M24vb0N6eDNZU3Z5UHlqejNzREpqbGxVUXFBRENObG9WL21B?=
 =?utf-8?B?KzRsY3BNVmNGVHhCK3krOWNtOVE4ajh4dnBFT2VoVjlIOXZkNXFEZndMWlE2?=
 =?utf-8?B?dng1ZnF0SkwzMGRyd1lldHQrU01Kc3YxaUpoWXhSeHNLbFFPMXJuVkExd25D?=
 =?utf-8?B?MDF3L2tmc3AxdkE3cEpqV2p6eGEyK01qclhJaG8yZlFzWUxzbEVVYnNWb25Q?=
 =?utf-8?B?Ym5EbER6WGpGU0l4SDh2dnBkVlNUQzY5ZVpOdVhmR2ZMTUkvaHlvV0xXS21h?=
 =?utf-8?B?ZGZsWnEzZzF2cEpaTEF4OFRkYktJNHM1VDE0S3Y3cENOeWZpZ3NsN2plWXdS?=
 =?utf-8?B?ZThQMmQxck1GRzg0NjA0bkpwSEJxUlIwV3ZXR3FGUmtaY3Y5K1ZaRERPaXF6?=
 =?utf-8?B?RythUjBjZ3ErZHlQT2hrbmtmR3hKMm51N1ppMFlWWTdCY1FYN2hMcTJML0Fy?=
 =?utf-8?B?Z0wvSytaWjdXd2lMak1rekppQzFhbHpuOXZ4ejdybVkvclZ4NjltZVJZUE9q?=
 =?utf-8?B?ZTdwems0dEVDRFJ6d2QzNXhOM2tjQUNIWnNMc0UwWFM2d1JycmZMSnZjK2cv?=
 =?utf-8?B?b1lUNmR1TXZVNkpjWDdscWNXQ05PYWdTa3orYktpSzYzRVJaTm9kemF3K2dB?=
 =?utf-8?B?UDJXYkJ5Rkx6TFdYdkt3Nml2V1ErZG1yNUQvTGpTSFhXRGk5Q3hEbHNvYzBO?=
 =?utf-8?B?OWhyaE5obnZGNVFEd1RKMytYaG1uUHNHVXNad3Y5RjJidEJJMXNvWFphaDRy?=
 =?utf-8?B?QzJMVXUvOXFYMUt1WDNXb2ZiaGZtSDE1ZWd2cFowWERtbW5RdnNmVXBQMVkv?=
 =?utf-8?B?MlpJOU55bDkzRTVmTDFlanZMb3IwcVdaQTRKSGZQSU5KWG5RNURuaFp4MmVz?=
 =?utf-8?B?SkJXOTJnbDh2ZDZ5QkhxcmJMOGFaUldDdHQyMXA5TG1odXFoeGc5bCtCcmk3?=
 =?utf-8?B?dzhxUHRBL2tJRlBBcFIzYjdpWGJMdWU3L29QeFo1UGxxMTJGd2U5UlRVVkt4?=
 =?utf-8?Q?Kb9k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f46d4fd-1bd1-4492-99a0-08dd0a6b2574
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:29:06.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga5Z/Kb0AprjO3V0MyzXKGx8KNWlVpiBgiCz5etkFjxG5rWQbnKD6KLXtVbIhEq0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820

Hi Reinette,

On 11/18/24 15:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> Introduce the interface to assign MBM events in mbm_cntr_assign mode.
>>
>> Events can be enabled or disabled by writing to file
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> Format is similar to the list format with addition of opcode for the
>> assignment operation.
>>  "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Format for specific type of groups:
>>
>>  * Default CTRL_MON group:
>>          "//<domain_id><opcode><flags>"
>>
>>  * Non-default CTRL_MON group:
>>          "<CTRL_MON group>//<domain_id><opcode><flags>"
>>
>>  * Child MON group of default CTRL_MON group:
>>          "/<MON group>/<domain_id><opcode><flags>"
>>
>>  * Child MON group of non-default CTRL_MON group:
>>          "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Domain_id '*' will apply the flags on all the domains.
>>
>> Opcode can be one of the following:
>>
>>  = Update the assignment to match the flags
>>  + Assign a new MBM event without impacting existing assignments.
>>  - Unassign a MBM event from currently assigned events.
>>
>> Assignment flags can be one of the following:
>>  t  MBM total event
>>  l  MBM local event
>>  tl Both total and local MBM events
>>  _  None of the MBM events. Valid only with '=' opcode. This flag cannot
>>     be combined with other flags.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Fixed handling special case '//0=' and '//".
>>     Removed extra strstr() call.
>>     Added generic failure text when assignment operation fails.
>>     Corrected user documentation format texts.
>>
>> v8: Moved unassign as the first action during the assign modification.
>>     Assign none "_" takes priority. Cannot be mixed with other flags.
>>     Updated the documentation and .rst file format. htmldoc looks ok.
>>
>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>     Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>     Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>     Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>     Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>     Removed ABMC reference in FS code.
>>     Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>     Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>     Users have the liberty to pass the flags. Restricting it might be a problem later.
>>
>> v6: Added support assign all if domain id is '*'
>>     Fixed the allocation of counter id if it not assigned already.
>>
>> v5: Interface name changed from mbm_assign_control to mbm_control.
>>     Fixed opcode and flags combination.
>>     '=_" is valid.
>>     "-_" amd "+_" is not valid.
>>     Minor message update.
>>     Renamed the function with prefix - rdtgroup_.
>>     Corrected few documentation mistakes.
>>     Rebase related changes after SNC support.
>>
>> v4: Added domain specific assignments. Fixed the opcode parsing.
>>
>> v3: New patch.
>>     Addresses the feedback to provide the global assignment interface.
>>     https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
>> ---
>>  Documentation/arch/x86/resctrl.rst     | 116 +++++++++++-
>>  arch/x86/kernel/cpu/resctrl/internal.h |  10 ++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 236 ++++++++++++++++++++++++-
>>  3 files changed, 360 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 590727bec44b..d0a107d251ec 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -347,7 +347,8 @@ with the following files:
>>  	 t  MBM total event is assigned.
>>  	 l  MBM local event is assigned.
>>  	 tl Both MBM total and local events are assigned.
>> -	 _  None of the MBM events are assigned.
>> +	 _  None of the MBM events are assigned. Only works with opcode '=' for write
>> +	    and cannot be combined with other flags.
>>  
>>  	Examples:
>>  	::
>> @@ -365,6 +366,119 @@ with the following files:
>>  	There are four resctrl groups. All the groups have total and local MBM events
>>  	assigned on domain 0 and 1.
>>  
>> +	Assignment state can be updated by writing to the interface.
> 
> This is already a bit far from original definition so it may help to be specific what is
> meant with "the interface". For example,
> 
> 	Assignment state can be updated by writing to "mbm_assign_control".

Sure.

> 
>> +
>> +	Format is similar to the list format with addition of opcode for the
>> +	assignment operation.
>> +
>> +		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +	Format for each type of groups:
> 
> "Format for each type of group"  or "Format of each type of group"?

Sure.

> 
>> +
>> +        * Default CTRL_MON group:
>> +                "//<domain_id><opcode><flags>"
>> +
>> +        * Non-default CTRL_MON group:
>> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of default CTRL_MON group:
>> +                "/<MON group>/<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of non-default CTRL_MON group:
>> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +	Domain_id '*' will apply the flags on all the domains.
> 
> "apply the flags on all the domains" -> "apply the flags to all the domains"?

Sure.

> 
>> +
>> +	Opcode can be one of the following:
>> +	::
>> +
>> +	 = Update the assignment to match the MBM event.
>> +	 + Assign a new MBM event without impacting existing assignments.
>> +	 - Unassign a MBM event from currently assigned events.
>> +
>> +	Examples:
>> +	Initial group status:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=tl;
>> +
>> +	To update the default group to assign only total MBM event on domain 0:
>> +	::
>> +
>> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=tl;
>> +
>> +	To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
>> +	::
>> +
>> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to unassign
>> +	both local and total MBM events on domain 1:
>> +	::
>> +
>> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>> +			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	To update the default group to add a local MBM event domain 0.
> 
> "." -> ":"

Sure.

> 
>> +	::
>> +
>> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all the
>> +	MBM events on all the domains.
> 
> "." -> ":"

Sure.

> 
>> +	::
>> +
>> +	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	Assignment status after the update:
>> +	::
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=_;1=_;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>>  		bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index b90d8c90b4b6..3ccaea6a2803 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -74,6 +74,16 @@
>>   */
>>  #define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>>  
>> +/*
>> + * Assignment flags for mbm_cntr_assign feature
>> + */
> 
> "mbm_cntr_assign feature" -> "mbm_cntr_assign mode"?

Sure.

> 
>> +enum {
>> +	ASSIGN_NONE	= 0,
>> +	ASSIGN_TOTAL	= BIT(QOS_L3_MBM_TOTAL_EVENT_ID),
>> +	ASSIGN_LOCAL	= BIT(QOS_L3_MBM_LOCAL_EVENT_ID),
>> +	ASSIGN_INVALID,
>> +};
>> +
>>  /**
>>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>>   *			        aren't marked nohz_full
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5cc40eacbe85..9fe419d0c536 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1082,6 +1082,239 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static int rdtgroup_str_to_mon_state(char *flag)
> 
> It seems strange to me that a variable used to contain flag bits
> is of type int. Why is it not unsigned?

Will change it to "unsigned int"

> 
>> +{
>> +	int i, mon_state = ASSIGN_NONE;
>> +
>> +	if (!strlen(flag))
>> +		return ASSIGN_INVALID;
>> +
>> +	for (i = 0; i < strlen(flag); i++) {
>> +		switch (*(flag + i)) {
>> +		case 't':
>> +			mon_state |= ASSIGN_TOTAL;
>> +			break;
>> +		case 'l':
>> +			mon_state |= ASSIGN_LOCAL;
>> +			break;
>> +		case '_':
>> +			return ASSIGN_NONE;
>> +		default:
>> +			return ASSIGN_INVALID;
>> +		}
>> +	}
>> +
>> +	return mon_state;
>> +}
>> +
>> +static struct rdtgroup *rdtgroup_find_grp_by_name(enum rdt_group_type rtype,
>> +						  char *p_grp, char *c_grp)
>> +{
>> +	struct rdtgroup *rdtg, *crg;
>> +
>> +	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
>> +		return &rdtgroup_default;
>> +	} else if (rtype == RDTCTRL_GROUP) {
>> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
>> +			if (!strcmp(p_grp, rdtg->kn->name))
>> +				return rdtg;
>> +	} else if (rtype == RDTMON_GROUP) {
>> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +			if (!strcmp(p_grp, rdtg->kn->name)) {
>> +				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +						    mon.crdtgrp_list) {
>> +					if (!strcmp(c_grp, crg->kn->name))
>> +						return crg;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>> +				  enum rdt_group_type rtype,
>> +				  char *p_grp, char *c_grp, char *tok)
>> +{
>> +	int op, mon_state, assign_state, unassign_state;
> 
> Same comment about type ... these *_state variables are used to contain
> bits representing the flags of the various states. An unsigned variable
> seems more appropriate.

Will change into unsigned int.

> 
>> +	char *dom_str, *id_str, *op_str;
>> +	struct rdt_mon_domain *d;
>> +	struct rdtgroup *rdtgrp;
>> +	unsigned long dom_id;
>> +	int ret, found = 0;
> 
> Could found be boolean?

Sure.

> 
>> +
>> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
>> +
>> +	if (!rdtgrp) {
>> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +next:
>> +	if (!tok || tok[0] == '\0')
>> +		return 0;
>> +
>> +	/* Start processing the strings for each domain */
>> +	dom_str = strim(strsep(&tok, ";"));
>> +
>> +	op_str = strpbrk(dom_str, "=+-");
>> +
>> +	if (op_str) {
>> +		op = *op_str;
>> +	} else {
>> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	id_str = strsep(&dom_str, "=+-");
>> +
>> +	/* Check for domain id '*' which means all domains */
>> +	if (id_str && *id_str == '*') {
>> +		d = NULL;
>> +		goto check_state;
>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing domain id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Verify if the dom_id is valid */
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found) {
>> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +		return -EINVAL;
>> +	}
> 
> I am missing how "found" is handled on second iteration. If an invalid domain
> follows a valid domain it seems like "found" remains set from previous iteration?

Yes. It should be reset. Good catch !

> 
>> +
>> +check_state:
>> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
>> +
>> +	if (mon_state == ASSIGN_INVALID) {
>> +		rdt_last_cmd_puts("Invalid assign flag\n");
>> +		goto out_fail;
>> +	}
>> +
>> +	assign_state = 0;
>> +	unassign_state = 0;
>> +
>> +	switch (op) {
>> +	case '+':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		assign_state = mon_state;
>> +		break;
>> +	case '-':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		unassign_state = mon_state;
>> +		break;
>> +	case '=':
>> +		assign_state = mon_state;
>> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (unassign_state & ASSIGN_TOTAL) {
>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (unassign_state & ASSIGN_LOCAL) {
>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_TOTAL) {
>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_LOCAL) {
>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	goto next;
>> +
>> +out_fail:
>> +	rdt_last_cmd_printf("Assign operation '%c%s' failed on the group %s/%s/\n",
>> +			    op, dom_str, p_grp, c_grp);
>> +
> 
> Can the domain id be printed also? This seems only piece missing to understand what failed.

Sure. Need to add a check if it is '*' or actual domain id.

Will do.

> 
>> +	return -EINVAL;
>> +}
>> +
>> +static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
>> +						 char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	char *token, *cmon_grp, *mon_grp;
>> +	enum rdt_group_type rtype;
>> +	int ret;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
>> +		mutex_unlock(&rdtgroup_mutex);
>> +		cpus_read_unlock();
>> +		return -EINVAL;
>> +	}
>> +
>> +	while ((token = strsep(&buf, "\n")) != NULL) {
>> +		/*
>> +		 * The write command follows the following format:
>> +		 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
>> +		 * Extract the CTRL_MON group.
>> +		 */
>> +		cmon_grp = strsep(&token, "/");
>> +
>> +		/*
>> +		 * Extract the MON_GROUP.
>> +		 * strsep returns empty string for contiguous delimiters.
>> +		 * Empty mon_grp here means it is a RDTCTRL_GROUP.
>> +		 */
>> +		mon_grp = strsep(&token, "/");
>> +
>> +		if (*mon_grp == '\0')
>> +			rtype = RDTCTRL_GROUP;
>> +		else
>> +			rtype = RDTMON_GROUP;
>> +
>> +		ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>  
>>  /*
>> @@ -2383,9 +2616,10 @@ static struct rftype res_common_files[] = {
>>  	},
>>  	{
>>  		.name		= "mbm_assign_control",
>> -		.mode		= 0444,
>> +		.mode		= 0644,
>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>  		.seq_show	= rdtgroup_mbm_assign_control_show,
>> +		.write		= rdtgroup_mbm_assign_control_write,
>>  	},
>>  	{
>>  		.name		= "mbm_assign_mode",
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

