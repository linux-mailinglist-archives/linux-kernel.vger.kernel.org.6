Return-Path: <linux-kernel+bounces-413323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349869D175D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0C1283204
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813BA1BE87C;
	Mon, 18 Nov 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QvIe6v2s"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB69A1ADFF9;
	Mon, 18 Nov 2024 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951896; cv=fail; b=psEYwRnGnDuLFwsFCdceepDj3imos74vnbrGjixVG7nZYFz2xsO6Li7BqYEiIBp5ENzLPfscFs2jEApoMK+RiPTOz/jakh7/rGoFUzZUMf/g/J76BJXrMGfyrH6/bwy6eWjf7L8ZLyJVQLHYjBg+8xhooEL9o4akYB04RWiIIqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951896; c=relaxed/simple;
	bh=rHQ8HYKek8i0BSZ5yEXxIpZmad5iXg+B59bRcI3Mw0I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OBx8An3nr0fHQJimYCWGy+rmM0TmhSULrv8m9PJqMVtOBGqJSgyPasm/y3r1acryha/qTfgVyyxOW8O931mAfhkGuBnBMGpq9HfOxFaFI68CrWPJVjyDq5xf6LE/kD/IsmO/iobJ4AlSvvdIyUDXq2eUnVo65XjC85dl9VVxjQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QvIe6v2s; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfocEd8Jq+OBPoJUjietFua1QohqMJl6SSGEtF2BzBsSalODY5km+Mpl8cddIfxXuZp7USKgoCbEK0r6XgBqPY9/WfRRj9nwY5koh8wsPg7Jlm4ssnyHRXPBYuq9XkPSoJvfrABJW3iuVsxPgZ17A5CM8Hy+P1Et0wgr8zDsKxBNBJzXpghVj0qG3ESqE6BwqS9hoeHvSWRzl4D0xHLgD6HmAjZGrzI8hF1NnX12rWe0gfNSLrDNq0Gy5mnBD8PHvacnYR1EM7ihGfEJ0sxDuUAp/aI/0gMKAsrklVXmvPLq6e3wRKRU+KOkB83Ait7Cx2AfWoRp6aExIQGUHUuG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YHjraGttgm723XtLiG4xQqjXFODWIGCddQ+9n7dGHI=;
 b=jVnFwdeeRjZhE3leyOF+i9332BJ/aAstiCdoDn9cOn7W8tiNCwkt2nQ/UEeL+EltLChPzFEanXPWLeJ3t4uj28h7A/BcUBTn+sgdKaK2/6JqnrWU/elfYVG9jAIOGX4cy1RXkkziTcmfyF3lCzo1YyTgNQvbxdQUFx34uExBIW+omYbvcm3Eewm8OmgpMVuU4mNZoJTMb/QrjC22aiIfjVDRWaN/pC3e06IXBR2C2cfn2TqGjjW01aoOGqR0UctRyQQiK5LEfi58zYnUUHP1J5BJxPWSgAozaa9yAPr/7iUNchYJbSNnvVDIBOcvAR0IURX8HiCqjwKnLkWSGn2lcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YHjraGttgm723XtLiG4xQqjXFODWIGCddQ+9n7dGHI=;
 b=QvIe6v2s6r2Xq7YlPFLUNGIPQK7JOjC7SfnRYwX2Ig63CBTBVjvPmpYR8UGFUUuPqeKw2+LFSSj/yLXfwUf+u/jghynXLEGTBAc7YtPIgCk8+nMpxDKdWi2BwZsNIL6N1T1p4YfD28IwRmD7fpXgiVVXa2U+Jq5ZHoLzo/uWHLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 17:44:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 17:44:52 +0000
Message-ID: <02e304e5-597d-48f6-b61e-24f366f60fda@amd.com>
Date: Mon, 18 Nov 2024 11:44:44 -0600
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
 vikas.shivappa@linux.intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com,
 maciej.wieczor-retman@intel.com, eranian@google.com, jpoimboe@kernel.org,
 thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <2372314c135882d233eb8dba69af7c245efdcc8d.1730244116.git.babu.moger@amd.com>
 <55bd64e3-50ff-423c-ac75-e25f2e1c9ffe@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <55bd64e3-50ff-423c-ac75-e25f2e1c9ffe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:805:de::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: c13a9832-bf85-4c7a-d28e-08dd07f8b496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0F5Z1QwTzEvK2tZSWNHVGhiZ0dHYmZiTlk5Z1Z2ZHVZWXQwS0loY0pTWDQ4?=
 =?utf-8?B?WHdEZkd2V2RHTkk5YUZFenU0RWR6T0Y0M3BHR2l1N25DeWZ4Uk14d3h2RU9y?=
 =?utf-8?B?dEpvQXhSVmNPWnNQWVhpUVExUHc0WTNBNXczU1B5RVExRXpQWU5ySzYwN0pT?=
 =?utf-8?B?UDcwUVg5TlZPRDJLNU44ekNIT1RKSWxtZmdKSjAyRGRObkZIVC9TTThKNGpH?=
 =?utf-8?B?OERVWmlpQmo5Z3VvSVlzaWE4U1dmaGRXYTVJenNQcGZDWDNSWno5MEdidExs?=
 =?utf-8?B?bktyZGJTd3RaN2ZnY0M0cnNYWEdiVUI0b2RpdXY4cVJpMlRINFBaSjNtYkFS?=
 =?utf-8?B?RlBtK1VqV1N2TGRNZkQzeGJjakxlbHlpN3lZekVOcERiSGw3YllqUjFDUlBu?=
 =?utf-8?B?NUI2L01ucXVndi9iTzBXbkJBenhuL0NLcGdUdGxpeXB6MHRTbXk2T1RONTkr?=
 =?utf-8?B?TTNpNnQxdlRkYVFuT1hhOHpzSFE4QUxRQXBkQlY2eTdTU3VqMjJFMytjU1pk?=
 =?utf-8?B?NkNGZVdRaDBSNjlnZGJIZjc3T2d6dkUzcFEyRkFRamw0V2t5cHFoS0QrOUpu?=
 =?utf-8?B?QzlnMFZQUi9CdHZ3REU3WUI1UDNEWmdNZTBNcHlLRzQ2aW80Ynp0UERJNHZn?=
 =?utf-8?B?UThLeWRONlJGRFN3WVMrK1NoUDFrMU03bFpTWmp6d0E1NDE1OGtmcXBvYVlY?=
 =?utf-8?B?Wm9yT3NMY21TbitNSHNYR2pyeWd2Q043S3hYckRUczhjRGZIbUJKTkdUZGZp?=
 =?utf-8?B?RFpRT1A4K0RaczlsL21oUk1kNWpqTFRFdU9lMEM2dWxwYnhRa0d4M0lkZUNB?=
 =?utf-8?B?ZjdkMVRnckRteUl4ZEtiWVpKSngrMWZsSGkzakl3a1lZMTFSWU1qME5Jczdz?=
 =?utf-8?B?UGRjbmJFeHdyVEtQWjlDUEdOZklGWTE3UHdiU1QrNGszZjllMXpqSlBpazRS?=
 =?utf-8?B?TTBuQ2d1UHY0Q2hzR3VFVnA0bksvOGIxV1RDaGphWlB3S1k5dE1oNjIyOXR1?=
 =?utf-8?B?U3hsM0FDaEhOR0NiOFNGQzdtcEIrc3NrNXk3MTF6ZERvZ2FxNEZnVm00bklW?=
 =?utf-8?B?NDJHOUNDdk4vd1QvUHVPemlQbVFFaE4rVk14RzRRT3M5algyT2VrNUtpWWxM?=
 =?utf-8?B?am1rYWtEN2c1SFFzVXp2bmFMV09CUU52S0RvV0FFREpyWVk0dnN6K1A0V3hn?=
 =?utf-8?B?dElBNGZQUXhFVm0wK3dYNWhQbGsvREZJRms3UURSTkdTd2J6TnVPY2FKWUIx?=
 =?utf-8?B?Znp2ZWh4VXJUNHNhOEZhY2JKVUxTVWxVMmhFRnlZOWNNamRaQ2dmVVdMSElY?=
 =?utf-8?B?OTJ6ZEFXOVpZY1NlWTNJZUNsdWxWcENXWDZCcUNDRUxFRksrM2J6OEJMaTQx?=
 =?utf-8?B?dk9oSDlqbE13Mks3RzlXTHhaNXYxbmpVTWJsTnU1bHNSOTFiLzA4ZUswYkZD?=
 =?utf-8?B?VndoU2YzRXdja0QxTG91OXFUaVFzNjhLVlNubEUydk0ydHU2V1VDSkxlUmVr?=
 =?utf-8?B?S3JRcmE5MWwxQmpqa0FwakRQZTFZRnVyeTNjNHAxWW9zcm1iUzdOL01KQ0s0?=
 =?utf-8?B?VnpvUHBuNVdqTTBtVUpMUzZ5VE9mSFRWTWJ4K1FRL1c5dnJXRTlZMGFyUGY5?=
 =?utf-8?B?RUFoZzhpNjd5S3E4c3QvbWZiWk5RMFg0dTlqZFhYVUZrR0IrNzRGQlJDSmcz?=
 =?utf-8?B?THFEeDc0TThDOHdrVHFJTkdVUzlBZktEc2luU3J6RGtVbDNmRnFnbE5laFVy?=
 =?utf-8?Q?Mzeu5zzVgeR1VoN7sNZ1tseaX4Xz5mxb5k+fmyt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1Vid0xWU3ZzVVRscVpIcXFXN09tS0J5T2ZvZ1dLRjdRQzBqcklkYzF3Z0t2?=
 =?utf-8?B?b0ZuUVJqRkFsaHZ1cnV2OTlPSllwTkE0YkUyazRFbExCbEVvVHVFdC80MDBT?=
 =?utf-8?B?Ky9iRGh2cHgyUHhkblVOWGdwMWh5aEE4OTk2MFp5WmE0N1I4dTFWTlpLd1B1?=
 =?utf-8?B?c3ZQcXZuRHNta3Y5T0FtZE5qSEFvTy90cmFsY0hNMnNYVGZ0ZmowanhSNmZC?=
 =?utf-8?B?aklZWDY2VEwwTHpaeUY4NjExR0JMV2VUZDFyQ2pWdzI1RWNEc0lnVlZEa2pB?=
 =?utf-8?B?Y0l3a0pFOS9MTjR3L0ZJaHdUV2QxZTRodEpoWlQ2cnBZNkZQSWZMQVM3T2Zm?=
 =?utf-8?B?b25XWlNuRVQyUmFTMnQ2MllNZGxvVnNLRjBkdTB2VDVmZVdRdVVxVnJJRWF4?=
 =?utf-8?B?aW1rS0ZvNUQxM1ptTVZoU1locG91bnppSklZY0ZMb05wc0llYzE2SmtLSmRV?=
 =?utf-8?B?bEZIbU12U011VVgxUGxHSjJSQlMyM0I4NkdEZWJ2bWp0TnAvenpuUEV3dlll?=
 =?utf-8?B?MFBNUHk5cWVsbVROeHdxQU1hdGNheE96MjkrSjhmMFlld25VRVppbjhTbmlG?=
 =?utf-8?B?Z3VycUFVNmhMM3QyYkJiYjdLK3BDZEt3Q3VMK1V1em0xaExvY1ZNRlAzQkF5?=
 =?utf-8?B?WU9uZENRcXhNbVpZTThQbmtTZXpKM3pkV3hzM3RyY3E5N2w2d3JMVkFrMGlm?=
 =?utf-8?B?VWVDSkFuZ2E2c0pxQmFYVjVDWHBEOHkvenN1ckYySWVaUk9wZlBoUGcvajdv?=
 =?utf-8?B?VmtpVDlzVEhYSHhncHdiQUMxRytaaUg2L24rVk9PL3BsQm1Va3hLZWdTaUx1?=
 =?utf-8?B?TkV4SHRwS1BLT1QyL0l6cGhsMGNYZ3RLUzlpcHRqL21NbWRBZ1ZHaXhWUFor?=
 =?utf-8?B?NnYzOXVqLzRXTkkzZGgvbTMzcEx2cm1icGp6MUZoNE9jL0Jxdm9PS1piTUd0?=
 =?utf-8?B?bGVOMlRvNXFoY0RGYVY2T1cyRHlsWW12MUJVVTZXVUpNNHZYZFJlWUR1M0xK?=
 =?utf-8?B?VzluQXpIMC91bFI0elBncjRhTnlLaC9JRXZJRlV4SiswdXFUZE5ZRHNUTHRk?=
 =?utf-8?B?SlBTTXVQcDNBQ09EczhQbEU0VEg4WDUrbytQeHh5VUpHQXBPcEc0WHcyb1hX?=
 =?utf-8?B?Qk1USXZLaDFYVE5PdXZONGUxQVRmbzJ4K05hc2VpY1NBWm8yMXp2VWpBUlFw?=
 =?utf-8?B?SVBiT1JiRjJuOHRWS2tyVlRKOXpudkhJcnlMaTA2cnRNNEI1QkxPY3ZoaWlj?=
 =?utf-8?B?YTRXc09wdkZGbVJLaWY4Q0lqN2pKT29RN1pabWFUWUo4eGl5YURKSmlvaE9L?=
 =?utf-8?B?L25JbUM0QnRjYXVvR2IvQjFnUkJjams5RnJzYXRzd1V6Z21Pc0pKMUJnSm5w?=
 =?utf-8?B?eVlIb0oyYlVlaUwwWmhMSHRxcnBNS3d0RWk3RTFkRHNhN3N3QjF1TUJ5WjhL?=
 =?utf-8?B?eCtRWE1sbVprK0xnNmlqMkE5am0wcUlxWEVMeFltSmxydlRLWGlsL3dpMmFM?=
 =?utf-8?B?eHJnVXVNZ0t5aElqczUzLzlERkc0SytBL0Q1THQ4Sk5qR09sUXkxbVZocGZW?=
 =?utf-8?B?OW41QnBzdnM3b2d4c2RzeWlETmhla3BtelZCcUpCUzg1VGFGVTJ0UWFheHlo?=
 =?utf-8?B?bk9URWtHYzNFUjJDWXRZbDluUDdkSlB0SmVGVFFZcHhhdE9IN1pUaS9aVzNY?=
 =?utf-8?B?SG1NT3dVSk1ud0tKR0ZQb1RkUVhoeW5nWTQ2UVQ5OFJiOFdOLzZBd1FRR3dS?=
 =?utf-8?B?U2hkbVd4L1dpMmw4TFBzNlNjQnh1VTBjcFZITXR0YnRBUFV5WWIwOGxxNUlS?=
 =?utf-8?B?ZzNQSmRhTWV6WjZrUnBtT0FTa3BPV3NJSk9SdEVoV0JQU1dTYmlQNzAxVS9t?=
 =?utf-8?B?QlI4R2ZwbnVIeGVRckVNb1BaZ01mZTE2a3dvamFZN1BaOGNpWEd3cTB3a01o?=
 =?utf-8?B?bTFSeUpBelpmVkVtZXZTTk9EQU5XZ3BqTHVBcUVibi9lUnU1aE5OU1Y4M0lF?=
 =?utf-8?B?SXk0RjV4eG9JV0NUT2NabXdLcjZpWXlCd1BveGtFTjlRK3ZBaGh2eitxbnBJ?=
 =?utf-8?B?VjlBL0tqelZjY1hpT1dIT0d5SlVleHQyTDdtUjdLb2s1M3A4T21ZVmUzNU5B?=
 =?utf-8?Q?A9v4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13a9832-bf85-4c7a-d28e-08dd07f8b496
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:44:52.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdlH+jAppxnx9A7BCvOgUwMaPz82bDh2cWQ4Lr9C+dtKLL10apG1No7Kr75CZmMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

Hi Reinette,

On 11/15/24 17:21, Reinette Chatre wrote:
> Hi Babu,
> 
> In subject please use () to indicate a function, writing resctrl_late_init()

Will change it to

x86/resctrl: Add __init attribute for all the call sequences in
resctrl_late_init()

> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> The function resctrl_late_init() has the __init attribute, but some
> 
> No need to say "The function" when using ().
> 
>> functions it calls do not. Add the __init attribute to all the functions
> 
> None of the functions changed are actually called by resctrl_late_init(). If this
> is indeed the goal then I think cache_alloc_hsw_probe() was missed.

Will change the function to.

static inline __init void cache_alloc_hsw_probe(void)

How about this description?

"resctrl_late_init() has the __init attribute, but some of the call
sequences of it do not have the __init attribute.

Add the __init attribute to all the functions in the call sequences to
maintain consistency throughout."

> 
>> to maintain consistency throughout the call sequence.
>>
>> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
>> Fixes: def10853930a ("x86/intel_rdt: Add two new resources for L2 Code and Data Prioritization (CDP)")
>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Moved the patch to the begining of the series.
>>     Fixed all the call sequences. Added additional Fixed tags.
>>
>> v8: New patch.
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     | 8 ++++----
>>  arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 4 ++--
>>  3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index b681c2e07dbf..f845d0590429 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -275,7 +275,7 @@ static __init bool __rdt_get_mem_config_amd(struct rdt_resource *r)
>>  	return true;
>>  }
>>  
>> -static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>> +static __init void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>>  {
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	union cpuid_0x10_1_eax eax;
>> @@ -294,7 +294,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>>  	r->alloc_capable = true;
>>  }
>>  
>> -static void rdt_get_cdp_config(int level)
>> +static __init void rdt_get_cdp_config(int level)
>>  {
>>  	/*
>>  	 * By default, CDP is disabled. CDP can be enabled by mount parameter
>> @@ -304,12 +304,12 @@ static void rdt_get_cdp_config(int level)
>>  	rdt_resources_all[level].r_resctrl.cdp_capable = true;
>>  }
>>  
>> -static void rdt_get_cdp_l3_config(void)
>> +static __init void rdt_get_cdp_l3_config(void)
>>  {
>>  	rdt_get_cdp_config(RDT_RESOURCE_L3);
>>  }
>>  
>> -static void rdt_get_cdp_l2_config(void)
>> +static __init void rdt_get_cdp_l2_config(void)
>>  {
>>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>>  }
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 955999aecfca..16181b90159a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -627,7 +627,7 @@ int closids_supported(void);
>>  void closid_free(int closid);
>>  int alloc_rmid(u32 closid);
>>  void free_rmid(u32 closid, u32 rmid);
>> -int rdt_get_mon_l3_config(struct rdt_resource *r);
>> +int __init rdt_get_mon_l3_config(struct rdt_resource *r);
>>  void __exit rdt_put_mon_l3_config(void);
>>  bool __init rdt_cpu_has(int flag);
>>  void mon_event_count(void *info);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 851b561850e0..17790f92ef51 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -983,7 +983,7 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
>>  		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>>  }
>>  
>> -static int dom_data_init(struct rdt_resource *r)
>> +static __init int dom_data_init(struct rdt_resource *r)
>>  {
>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>  	u32 num_closid = resctrl_arch_get_num_closid(r);
>> @@ -1081,7 +1081,7 @@ static struct mon_evt mbm_local_event = {
>>   * because as per the SDM the total and local memory bandwidth
>>   * are enumerated as part of L3 monitoring.
>>   */
>> -static void l3_mon_evt_init(struct rdt_resource *r)
>> +static void __init l3_mon_evt_init(struct rdt_resource *r)
> 
> This change follows a different order from the other changes in this patch. "Function prototypes"
> in Documentation/process/coding-style.rst indicates the preferred order is storage class
> before return type. I acknowledge that resctrl is not consistent in this regard but we can
> work towards the preferred order while keeping this patch consistent?

Sure. Will change it to.

static __init void l3_mon_evt_init(struct rdt_resource *r)


-- 
Thanks
Babu Moger

