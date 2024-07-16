Return-Path: <linux-kernel+bounces-254353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8C93321A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4AB1F27605
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB551A2C0E;
	Tue, 16 Jul 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kortUOuN"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F71A0721;
	Tue, 16 Jul 2024 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158488; cv=fail; b=JmMYauL+5PhCYle5Z2Ezj5/aUlXpYqzu21zAcnCZF979NHTYz35rXK113OxHSSdNbwj8CdA9yq/sXj1AL/5Ioe6isVVQXz2GGcZMQpKa/2WcZwcD0y9xMmEQlQRlHUVI/3D/z79kCNKKzbAKz4VGeRtVuHB+pVeAyDs9yS2tv+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158488; c=relaxed/simple;
	bh=xWI7h9/dAObsgIqdGZKxfLGMR1DnmLw9WeJ2PvJ5PPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFNizPfPZnJ6ao0RRIkaVW+ZcBsXiOSDbO99g2uy1YP72DeMpnTjK+GMyEY/Y1qVF5lJPLr43HO9nTJi2wNu8s5kFlIg9e05kyKO7AvIPySAj2OgNxOy5ftiLf+BPhh2Iq17Nf14SP4rfKcIBOT6WtNNk0hBFXk50etvtvt7zro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kortUOuN; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsy3Q+ZtjjzA/eUmZbRs2dY39SJWM4rF3oO1lL2gh+kSU/kmOlsnWSVewzkBpMZxuwaK/Gi3qJsKwFyT8ftMJdYHQLrAj62YlIntczX44MqiWZ+1TP0KX2bY/cmxOpVtQpTyPiYYN3r+ScEuFnD3BQv6YS4yUkiNe5/BxZj7JRo3RRWJk7kfl+4Rk40v3WABoEel0Ikiv10kDov5tcfLu+iI0RC4V6LzAzq72kjKVrf7IxcAHJXr6GXuc8nFDt0yfWaGAayoDl9BHtUt5W8LYmf69GWvPQjeyEEtOIoDBHoxoz3kefjW3x74+kmfkgRLyzGMFRPY0g3FVQCZwf9Y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBpYVLfY+mV90IClpY0LWjyFsgaWGTkGct0681DpC6I=;
 b=AaF12ey3FP6JZzpyHvIQ3M11ZnmmDy+79/YBOANAKolMtvMbUqY+aCaVQ9wohWTbTa2mxAXNmyhjYxW4E2DFGUC9AL+eR/6ORoMpk+CzaTKCPRm7MDdn+/PDeULQVkLK8xQdzQP1IgSzwlCeXlrfYu7m9uUDml8c/eTa32TUCN98CkHnauI6DEsc8kNWJEp8ueGDVKXOZTF/0vnB3ax/7Htv6haze49rrbXZqTGBsKsHLPJuNLC80VccolOVTdITPtu8y0EMkc75HUIlunzy3S8Vhn05YSMJ3YtX8viJMXt6T81uMVxyjN7iHAE9MG6QRpaTfBeuEfITri61mTmizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBpYVLfY+mV90IClpY0LWjyFsgaWGTkGct0681DpC6I=;
 b=kortUOuNdShEp8ir6mtUK3tRsYi+sIFPDfsntBj+W4vm2SWwglr9QOae4Gd0ypxvaSjtoqDl5ijiOGDFXG8pcQBCC952oL+HocUAlGZtf0MRKDWejFpp2KfrgwNi3nv+EZ3qdUG8ZuSnFWYUj3tff+PqwXoJviNP0JsRDj8q0Vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Tue, 16 Jul
 2024 19:34:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:34:44 +0000
Message-ID: <779eaea8-ab16-47b0-b1bd-4dda439ae3d7@amd.com>
Date: Tue, 16 Jul 2024 14:34:39 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 11/20] x86/resctrl: Remove MSR reading of event
 configuration value
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <82e8c5c888220b7659d7cd57fb291412ba62b120.1720043311.git.babu.moger@amd.com>
 <0ffec8d1-a27f-48b4-997a-8cc057de701e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0ffec8d1-a27f-48b4-997a-8cc057de701e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 40031af4-3f9f-4bb2-0655-08dca5ce584c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUJFUXV0cWhrUTNBdG5JdWpmRXN1N1k5K3hXbC9ZVmR4Q1h1YklqYmJsWVU5?=
 =?utf-8?B?eUxlUUtCTXZiYWY4MnpTRVRzT1ljYlVUY01GdDZVeTh3NTFBUXczMFhndlU1?=
 =?utf-8?B?RlFJWjRvZXF6TExTZ0ErN0dNWjVLV2ZwSzBEUnA1a215UlVPM0lmWEJqZ2lV?=
 =?utf-8?B?cWlzckdERGZKRW1TMXgrRFpHNGZVWmp1WDEvRHlmZmlhTHlYbHhIYU02Q3Bx?=
 =?utf-8?B?ajRnWG5nODdQV1JqYmlyT2RoeVBIQWdBRytKMC94Wnc0Y2NQT3A2TmlaVVVz?=
 =?utf-8?B?dnUzOW9tdXordHJDQlpsZXY3S2x6K2RWN0JJK3B6RjhUQlJ6cHJzMTBnUEVJ?=
 =?utf-8?B?VjZSMzNkbjdkYWlJMi9WRXRFT1ZvaUtWZUJkTWtxcE8vbDZvekdrRVVicDFQ?=
 =?utf-8?B?eTM0QUFuamVBaFhBd0h0M3RYNFZLdUREMkdiMjJVZmdDeDkvYnlPQjR4OHpu?=
 =?utf-8?B?RSthdUJ3a1VUVmhzZUV1bEhabVhLaXZ3RW52bENJMU1WMHhPUkxyR3ZYZk5y?=
 =?utf-8?B?bEhuazNMZy9oRzVEdFprTkxUUnVQZStaQU56MHNVaEZJcDF2c05xMmt2SEo3?=
 =?utf-8?B?R1o3RUt3aGNRTHdYU1o3Y21zSTZjK0FJQ2w5WVAyQS9LdUFqa3FpcFJSajdD?=
 =?utf-8?B?aUVnQXVBakw3YmZtRTJJV0t3S1l1MmN4UVVDakNtbVFlVkJGaFFUYkhrZGoz?=
 =?utf-8?B?UWg5b0h3dzR4T1I0MXg1b0ZEUHZhcDFWYUtTcmlIV2dZRWtJQVFFM2xJZmE3?=
 =?utf-8?B?MGl5YU9qbHcxRUo4QUg3Q0lXNUs2S0xWZkliOVFSRjhsdnFhdHdTSlk5b0Vv?=
 =?utf-8?B?QXlpcyt2cTg5K0JIcVIxZ3h5U2QybjRtVVZKSHk5eDVUTTJmNUFPejdHZ28z?=
 =?utf-8?B?WlNQcys4Q2tMWEJtTVk5WnBUN3AvVThkUUZJd3RRZzhPRVU5b1o4Y1ZROXNJ?=
 =?utf-8?B?WDBlOVN1WGtZVi9nUGJLSDV5Y0VRdkI0R3RtbGpIVGNORHdXYTBRTDhZK0Jq?=
 =?utf-8?B?K1J4YnJ2bG9OcHc3djNRTm54eWI3SEN2UkZrZlJDRXVWUjhsWlVhTUxldTdW?=
 =?utf-8?B?Z1hMZ3pnUXAvS0o5TjdLaEVPSTl6bXJvVmptSHBqZS9rQWF5d0dUaVNxd21M?=
 =?utf-8?B?UmhoU1g4RlBOK2VXTHE3aTljZHkxL0hjaTlrbFo4UEZmUEZ2THI0dmZRVHhW?=
 =?utf-8?B?ZlBmU0VwWnJDNzhGdTFMM3NaOUtRbkNMSWdZM2drZTcvTVRwd0E0a25nTWsv?=
 =?utf-8?B?VU53T2dWWmdJemJ3elp0RHFHU09ZeldKdzNzVVp4djBXdkJlWnVqc1Npb2oy?=
 =?utf-8?B?b2xSQjNTanpaN0FiQXJCcWUrTEt3WGJsRmJwL3ZJd1lMdmxBWWlVOXlHQUpZ?=
 =?utf-8?B?cWxqRWJFU2duNE5NMmhuYjkyREFrVlpsMnRhd2twSEVZTFY5TmdxbEc3OUVu?=
 =?utf-8?B?ZWp6M1hlYXlJdTZ5TGdZN1ZzUFJYWGE5Tnd2UHYrV1RHdXFVeGVOU3Y0N0Y4?=
 =?utf-8?B?cGM5MkVFZEQvRm50MVRaUkR3Y29Ba1g2TllJbmkwZzJnNFFPLzg5VC85MWpT?=
 =?utf-8?B?dlJmblV5dWFHQmlTWUJjOHVrcWM4ZlZhOU5nSjMzYUJiUThSSzMvd3AzcUJu?=
 =?utf-8?B?YUZXQXdKUG00eTVUL1NUTGxYNWk4eDIzNjNZaWRoaWx6dzROcWk3ZVJaM3dC?=
 =?utf-8?B?ZkN3SkhoNDFIRk9salQzeXYvbjgvcFdycWMyWnZxWGgwaEwvakVzenJkQllt?=
 =?utf-8?Q?n2eoA2GRJcV42ngJGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU9WL05JeGhuNHdnY0JHWGk5Wkk3QVozdUNnRGJBR0EzN1AwZTJqSnc2UDJV?=
 =?utf-8?B?Q2FsUUlEbGg5aHBONmdZNlliZDlHY202ZzFjUkxZckxjb1JYcURwenRTZmFv?=
 =?utf-8?B?QjNsR3NNVEo3cm5iNkJ1bzQ4bWdxRHlIUWhvenZndnp0YmFQWERwRlRPd0RV?=
 =?utf-8?B?c1FCQjJ2VWRLay8vK2tXcHRiWGFFZFFOanp4Qm5reStqbmhCUi82blpPUFEv?=
 =?utf-8?B?RVpBSk1YMTN3R3pTUDcvRWttMkRlT01lNm1zSWJpWVJQd3NXaWFrNXd3L0Fm?=
 =?utf-8?B?cUxWZ1JYVVdBMUxFbTMvWkora1U5NnRiMDIzWHcxUGtoTTNHdkhweWZuQXJs?=
 =?utf-8?B?UmZCbGc3Zlk5VTJ2eExQZWhlZjAwRFU1NVJkNFlSZ3NMS3MyYUIrWWZEV2hK?=
 =?utf-8?B?M2szZHZCNmtTaWhOQnNPN2lOUjdkQUVhUWhhTkNxMmo4YU1CUC9GQWNSYVYw?=
 =?utf-8?B?Q0hSbmNUQzNEU2tUWEgrS0ZZTkh5bm9SUDRsQ3NtTkhsMFB6L0dXb1hPWUZD?=
 =?utf-8?B?YzRpM3hxOHFpdnlRcCtsaSs4TmJEMlk2QlN1VjZBYVkvVUpTSlN2aDJreVpJ?=
 =?utf-8?B?UXBvWEY1WTRydi9IcGZGblBOOWZhQmc0MFZOTndFMWNOUjRMRWl5MjFJbkxq?=
 =?utf-8?B?YUxzRkhGaFNkTG83LzV2MXJzNGVMZVQrR21MZ2VJaXkwTHZaZzlUcWUzUVh6?=
 =?utf-8?B?cnlvaGpZR1BieDdkQ1ZUN084bGM3WXBrNE56a25ETjg2QUdkMXVMeDFtK0Ni?=
 =?utf-8?B?b1dodCtrdTA3SkNOS0NpRFpEQUdDLy96M2dOQWE5QjlxbjVXVkdrYXZwaGE1?=
 =?utf-8?B?dXV6UkJ6UEFFdUdlZ0VXejNHOGp4Z3BBeGtBTThXZXV3d0dkS2xqeTZYTVlE?=
 =?utf-8?B?ckVWUTdkQ3Zvc0xiVzEwUDQxYmRvalpPVlpCYm1vUG9sdUdHL08xc0daNHhH?=
 =?utf-8?B?akl5aGNiVHdUYjJ2cXBoNXB3bFprUEIxakw5R25lRFdtQUxBcDFtUUUxdUpW?=
 =?utf-8?B?NHljWUxBWlNVRndTMWtHd2JRdkNET2FRMzFlOWRNZTdFaU1IK2dnTmNzQWZx?=
 =?utf-8?B?blQ1Zi80RlR0MUJhZFBSdWpCMFp6Zlo1VnY0bDhBYW1aQ25sRnl1RnhsN2lX?=
 =?utf-8?B?bFZZY2k2UEhXcDI4ZU5tVEVzaE4xRDJWQVdmRStqYVdqSCtKWGF1OXBmdERK?=
 =?utf-8?B?MWRvSXdLOWp1U3JCWUZnRXZiZXFyRHlLUk1YUzZaWm51cStERnlZeGo3MGNP?=
 =?utf-8?B?TWEvWTJiSStsMVE3NzF3NEdjVlNVeW9YYUU1N1BzNVVnOEdpeEV4S2NLYm5V?=
 =?utf-8?B?S1RTWVF4T3JsOHBTYjhEaVNMbVZkZTdIbm9uWWJQMnk0MUkyUXY3bjBQOUZO?=
 =?utf-8?B?d3duQjlZN0Z2aGU5T05BNk1vWU93eEx0bkp3UVJ2QWl1UXFuWW1LS2xlTkJo?=
 =?utf-8?B?TnVOa3R6ajJSU1luS0ltMjBUZ3hBVlhmcTkwZWZRelFvdlNHM1Y5cDRyYm93?=
 =?utf-8?B?UlFnM2VGSzFZYWFCU0NRaVk2ZEx3eGVTVUtYWjBNU2xsNGRXaWNDaVdFSHlN?=
 =?utf-8?B?UjBkR1VSUHlyVVdnWi9tTFdWTHdXODBVWlh5TDRYaGljQ3BDSEowa2JQTlVr?=
 =?utf-8?B?d0M5TnRpQWhmLzBoam5hYTNrMDBKUzB2SzhhQk1WeDByTGd1bUF0WERKaHla?=
 =?utf-8?B?Y1hZWXJ0bGRkSHNrVFBXRlJIUjYycE9nMlRwZDhZYVNYSk8yL3RpS01FczR4?=
 =?utf-8?B?eU9kYzNzVGlveHhZdHVJMERWWVJhYzBKNFJxTHEzNjBrUy9UTXB4TktudHBN?=
 =?utf-8?B?OHBjQlYrbmJlbU5lUUZCUEJhT0ExTHJ2TFJpNTl1UitrdW5EcU9samFmNU5o?=
 =?utf-8?B?MG81VC9oUURkdWMvVWFjclFmc2xHNFJrNDhLcHA0YnFkaldDa3hsRE1hZDBT?=
 =?utf-8?B?MXJXTDcxNWEvVm94UXZSd044VUpycDVTV1JDTDBQeGJ3TWNhcXFSaytCRTNp?=
 =?utf-8?B?akFpRWtUNHpPS3NlZzBBNDV5ZVMrdjFEeHBJL1c3ZzZTS0NQcVdPZFpwT2po?=
 =?utf-8?B?SjZjUUQ2djNJS1JDdUVyaFQwWnZoYmdDTHk5YVI3cndOOFhBcTJOOEpuM21E?=
 =?utf-8?Q?oeko=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40031af4-3f9f-4bb2-0655-08dca5ce584c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:34:44.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2LJWGuV8IIvK5IWPM14NfzgtQuRM02pcixq7sKuZ19dPISY5/EHvNBg2R/YPjEq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234

Hi Reinette,

On 7/12/24 17:10, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> The event configuration is domain specific and initialized during domain
>> initialization. It is not required to read the configuration register
>> every time user asks for it. Use the value stored in rdt_mon_hw_domain
> 
> rdt_mon_hw_domain -> rdt_hw_mon_domain
> 
>> instead. Also update the configuration value when user writes it.
> 
> Please separate the context/problem/solution clearly.

Sure.

> 
>>
>> Introduce resctrl_arch_event_config_get() and
>> resctrl_arch_event_config_set() to get/set architecture domain specific
>> mbm_total_cfg/mbm_local_cfg values.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: Introduced resctrl_arch_event_config_get and
>>      resctrl_arch_event_config_get() based on our discussion.
>>     
>> https://lore.kernel.org/lkml/68e861f9-245d-4496-a72e-46fc57d19c62@amd.com/
>>
>> v4: New patch.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 112 +++++++++++++++----------
>>   include/linux/resctrl.h                |   4 +
>>   2 files changed, 72 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index b2b751741dd8..91c5d45ac367 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1591,10 +1591,59 @@ static int rdtgroup_size_show(struct
>> kernfs_open_file *of,
>>   }
>>     struct mon_config_info {
>> +    struct rdt_mon_domain *d;
>>       u32 evtid;
>>       u32 mon_config;
>>   };
> 
> as seen above, mon_config is a u32
> 
>>   +#define INVALID_CONFIG_VALUE   UINT_MAX
> 
> So an invalid config value can be U32_MAX?

Sure.

> 
>> +
>> +unsigned int resctrl_arch_event_config_get(struct rdt_mon_domain *d,
>> +                       enum resctrl_event_id eventid)
>> +{
>> +    struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +
>> +    switch (eventid) {
>> +    case QOS_L3_OCCUP_EVENT_ID:
>> +        break;
>> +    case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +        return hw_dom->mbm_total_cfg;
>> +    case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +        return hw_dom->mbm_local_cfg;
>> +    }
>> +
>> +    /* Never expect to get here */
>> +    WARN_ON_ONCE(1);
>> +
>> +    return INVALID_CONFIG_VALUE;
>> +}
>> +
>> +void resctrl_arch_event_config_set(void *info)
>> +{
>> +    struct mon_config_info *mon_info = info;
>> +    struct rdt_hw_mon_domain *hw_dom;
>> +    unsigned int index;
>> +
>> +    index = mon_event_config_index_get(mon_info->evtid);
>> +    if (index == INVALID_CONFIG_VALUE) {
> 
> INVALID_CONFIG_INDEX?

Yes.

> 
>> +        pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>> +        return;
>> +    }
>> +    wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>> +
>> +    hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
>> +
>> +    switch (mon_info->evtid) {
>> +    case QOS_L3_OCCUP_EVENT_ID:
>> +        break;
>> +    case QOS_L3_MBM_TOTAL_EVENT_ID:
>> +        hw_dom->mbm_total_cfg = mon_info->mon_config;
>> +        break;
>> +    case QOS_L3_MBM_LOCAL_EVENT_ID:
>> +        hw_dom->mbm_local_cfg =  mon_info->mon_config;
> 
> Please add a break here.

Sure.
> 
>> +    }
>> +}
>> +
>>   #define INVALID_CONFIG_INDEX   UINT_MAX
>>     /**
>> @@ -1619,33 +1668,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
>>       }
>>   }
>>   -static void mon_event_config_read(void *info)
>> -{
>> -    struct mon_config_info *mon_info = info;
>> -    unsigned int index;
>> -    u64 msrval;
>> -
>> -    index = mon_event_config_index_get(mon_info->evtid);
>> -    if (index == INVALID_CONFIG_INDEX) {
>> -        pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>> -        return;
>> -    }
>> -    rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>> -
>> -    /* Report only the valid event configuration bits */
>> -    mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>> -}
>> -
>> -static void mondata_config_read(struct rdt_mon_domain *d, struct
>> mon_config_info *mon_info)
>> -{
>> -    smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read,
>> mon_info, 1);
>> -}
>> -
>>   static int mbm_config_show(struct seq_file *s, struct rdt_resource *r,
>> u32 evtid)
>>   {
>> -    struct mon_config_info mon_info = {0};
>>       struct rdt_mon_domain *dom;
>>       bool sep = false;
>> +    int val;
>>         cpus_read_lock();
>>       mutex_lock(&rdtgroup_mutex);
>> @@ -1654,11 +1681,13 @@ static int mbm_config_show(struct seq_file *s,
>> struct rdt_resource *r, u32 evtid
>>           if (sep)
>>               seq_puts(s, ";");
>>   -        memset(&mon_info, 0, sizeof(struct mon_config_info));
>> -        mon_info.evtid = evtid;
>> -        mondata_config_read(dom, &mon_info);
>> +        val = resctrl_arch_event_config_get(dom, evtid);
> 
> There are too many types used interchangeably. The mon_config is a "u32",
> but the new function
> returns "unsigned int", which is then assigned to an "int". Please just
> use one type
> consistently, it is a u32 so resctrl_arch_event_config_get() can return
> u32 and "val" should
> be u32.
> 

Sure. Will do.

>> +        if (val == INVALID_CONFIG_VALUE) {
>> +            rdt_last_cmd_puts("Invalid event configuration\n");
> 
> I do not see a reason to print message to user space here. If this error
> is encountered
> then it is a kernel bug and resctrl_arch_event_config_get() would already
> have triggered
> a WARN.
> 
> Since this is a "never should happen" scenario I wonder if we can not just
> print
> the INVALID_CONFIG_VALUE to user space?

Ok. Will remove the check and the message.

> 
> 
>> +            break;
>> +        }
>>   -        seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
>> +        seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
>>           sep = true;
>>       }
>>       seq_puts(s, "\n");
>> @@ -1689,33 +1718,27 @@ static int mbm_local_bytes_config_show(struct
>> kernfs_open_file *of,
>>       return 0;
>>   }
>>   -static void mon_event_config_write(void *info)
>> -{
>> -    struct mon_config_info *mon_info = info;
>> -    unsigned int index;
>> -
>> -    index = mon_event_config_index_get(mon_info->evtid);
>> -    if (index == INVALID_CONFIG_INDEX) {
>> -        pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>> -        return;
>> -    }
>> -    wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>> -}
>>     static void mbm_config_write_domain(struct rdt_resource *r,
>>                       struct rdt_mon_domain *d, u32 evtid, u32 val)
>>   {
>>       struct mon_config_info mon_info = {0};
>> +    int config_val;
>>         /*
>> -     * Read the current config value first. If both are the same then
>> +     * Check the current config value first. If both are the same then
>>        * no need to write it again.
>>        */
>> -    mon_info.evtid = evtid;
>> -    mondata_config_read(d, &mon_info);
>> -    if (mon_info.mon_config == val)
>> +    config_val = resctrl_arch_event_config_get(d, evtid);
>> +    if (config_val == INVALID_CONFIG_VALUE) {
>> +        rdt_last_cmd_puts("Invalid event configuration\n");
> 
> same here about unneeded print to user space. When this is encountered it is
> a kernel bug.

Ok. Will remove the check and the message.

> 
>> +        return;
>> +    }
>> +    if (config_val == val)
>>           return;
>>   +    mon_info.d = d;
>> +    mon_info.evtid = evtid;
>>       mon_info.mon_config = val;
>>         /*
>> @@ -1724,7 +1747,8 @@ static void mbm_config_write_domain(struct
>> rdt_resource *r,
>>        * are scoped at the domain level. Writing any of these MSRs
>>        * on one CPU is observed by all the CPUs in the domain.
>>        */
>> -    smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_write,
>> +    smp_call_function_any(&d->hdr.cpu_mask,
>> +                  resctrl_arch_event_config_set,
>>                     &mon_info, 1);
>>         /*
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 62f0f002ef41..f017258ebf85 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -352,6 +352,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource
>> *r, struct rdt_mon_domain *d,
>>    */
>>   void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct
>> rdt_mon_domain *d);
>>   +void resctrl_arch_event_config_set(void *info);
>> +unsigned int resctrl_arch_event_config_get(struct rdt_mon_domain *d,
>> +                       enum resctrl_event_id eventid);
>> +
>>   extern unsigned int resctrl_rmid_realloc_threshold;
>>   extern unsigned int resctrl_rmid_realloc_limit;
>>   
> 
> Reinette
> 

-- 
Thanks
Babu Moger

