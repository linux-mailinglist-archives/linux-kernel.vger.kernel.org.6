Return-Path: <linux-kernel+bounces-418881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEDA9D66A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6031601B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F28566A;
	Sat, 23 Nov 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41GOfozj"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB48F6B;
	Sat, 23 Nov 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732320932; cv=fail; b=AxsduVtb2n8tMQEB/qncd1yWexgExfoch76cON7oJeidKy6BI2QtD0YoAWHAmdD8gaDw33kK/T91BwqqQUPs+jEEXhzuPqmSF/87x2LLazML4MT5oYKMk9/KaffjryLPLaIBoiYVrKe1H5khQ4vR03CgmkyVFfGYtPp5SdfyvQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732320932; c=relaxed/simple;
	bh=vEmKCTKEKJRHyuV0/GYcg60UWSc8e4Iy/WHa63D65A8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=icNaRGaHzLyCo+6pjos4jpaNcWXtwCpktCPHxG/YM7XDshRNO/LNf7o39RMf+W+H72ZvQKurab/Cx1THQK+Bb1c3C8igjrG0tR++vcsRnKl/SwXptIepeRP8kkeTtTGl64hOGWKd7FaeHff9wdr6enhIyf4yBH5dvbTTkyT5iSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41GOfozj; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nwn0PTNFt31cTKQ6IJa15H4ClSuMXoQMjxq3cwISCLZ8OxWRH8cNw4UKC4TapIoPm2rC2XliGooZNKYCubZ8W1uQYrbFAuvAVkJoNW2Op0M5JtaeRRlEl8WY4i+c3lVUZky3RYSVuLDynLLRbPDHu4sK5HRCfSUBHFHo5HHeZHkTmiDFtG4DmoKfGTG06iyj9sdPXjBS0KbMiFxRfZPzthzZsiKBkCjp9ATv3mB0Lr4BDBz0dvck7y7OkKcE9XsX3H/5nkkZ7CI40yViXN2wf/yLYAytbUhMzSDV/H+1lz7ykeTETs+e5Q8hU7rZCfczuqhooZlUP4eiPxCRsmt7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCL6+mfvZmuOXFrco9q+CCO94NfWkmlCTVilnzeKv4A=;
 b=wgqxYcr28SetF+eK4k1Wx/cQhIRJr/wCKJ8H8fwQcdOqgXz4e9IO9oKz4Z9oZWfGXLFGjaDGy+2R8/LpB0wv9y3vrMl94wQYtgYY8jSeHLC1pAGf9Tp5DTajjdgk+iBw5f6RJOjxtujiJjtJwpHY15J6FiNMuiuaMacek5gCyrDYEtKjVPUMtstlAeMYVbDFXZzsrXTPkuEIL7SAaOziFhEWxEKsudfyC5dbcvnbl3Jh7N1oNJfeekktaVaQqq/P67hq2PDxxpKcoJcqp3ZFh88zbIJCJGFmg7yWlOEawS5sOk7fY+ODfEKtoNZ7yLvyXUcbRmhj/LYiZF3H5fRbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCL6+mfvZmuOXFrco9q+CCO94NfWkmlCTVilnzeKv4A=;
 b=41GOfozjULm8QDY0Xmn8i/9NufSVAC7hpJOXuMoy/vk4r61dDTqbCJfsGtQ6Qj9oddYEuVG7I+SeOrN4WYkvmlwhLlvvSE+4gfPmojKN6p8jM8U03zXeMav/+LvN2iek1QUSMuXJ7ou/fnkYIwIevFEyiKs/WatpPPUla3xrPC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Sat, 23 Nov
 2024 00:15:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.024; Sat, 23 Nov 2024
 00:15:28 +0000
Message-ID: <8ad51d26-fe26-4fa7-9d20-7e83a9009941@amd.com>
Date: Fri, 22 Nov 2024 18:15:22 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
 <5a7d8ff1-91c7-4e75-9730-3aa0703274a6@intel.com>
 <e108846f-930b-4afd-90c6-2266af96816f@amd.com>
 <a1417f89-7d07-4e9c-ace4-1248fb2f668b@intel.com>
 <d7bbc624-75f0-4110-b459-e69dafd9577a@amd.com>
 <9b510a12-b0de-4143-806b-493c29f4ff00@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <9b510a12-b0de-4143-806b-493c29f4ff00@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3551c073-aec8-4952-7fc0-08dd0b53ef2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUNFT0RYaFlFWlQ0STk4NG80VUxZN1lURUlHdWhCOHN0RWJ6RlBVMklTOHVC?=
 =?utf-8?B?TUV3US9vVENYR1lGc3hHeHNrZ3dubHEwNXluNm84NlRzcEtCTUtTVGxkNi9q?=
 =?utf-8?B?cjNYa1d1OEdKL3R4dVcyM3MvRTVYQVVqOHNnRFZIU0VZL1l2TVRFUldQeFJG?=
 =?utf-8?B?SnVOLytSaHJqMjYvQmRoRkgzVy9Pdm9lSGoxYWdBVHpJVnl1K0REVVNOcVBV?=
 =?utf-8?B?Y1NvQTlFUHl2RnlHTk14UytaQ1c1RXRjeU9NWk1nTys2WXBVTWhzemxaZmxN?=
 =?utf-8?B?ZzlBdkVwbGtNcG4wQjdOOUVoWCtteFVkUVNRY2xJRGNYMitndmp4S3NaaFEy?=
 =?utf-8?B?cXA4Sm9BZFlCNTN5ajZscnNvZElPQXV4Y0o5VTk3emxmNkpVbE9JSkNjcDY5?=
 =?utf-8?B?TkM4ODFKTk1ZTHAveVlmMjFZRFZNREdIdTZDR3pxNkpHUi9Cd2k2a25XZWlU?=
 =?utf-8?B?R3drRC93M2VlVXlneGNiRFhhVU01cGFEa3dWOG5wVXRIRUl1NVZwUXRwbDlD?=
 =?utf-8?B?V3diMzVIdTQ4Z0xsc3BVNjRVeHora0lrZzZUSk1MZi9aVnA1bVY3aFRwcXAw?=
 =?utf-8?B?bzRkSEd4NUhSbE9heUdmL2hFaUhhYzlWRkdUalJyaTNvdEh3dVNwQnYrOEJh?=
 =?utf-8?B?TGZ4YnVsemVGTXRRRFFzNHJtRThKaGlFRFMxaDNEOWYxUEt3TXV3TXcrcnhs?=
 =?utf-8?B?MGhTaTZuV2JJZExtaWI4WHR4L3QwWkUrSXllWWYwRmNSQUcyNWJPM01iYitV?=
 =?utf-8?B?UlI0RG1Xckc0VWt6M24xWE5mbUJTbjQ2cFgxTHZhWThrVVo4VlJjWjZKVEEv?=
 =?utf-8?B?RHVSNTRSQ0podWFUUk01RldYeDcwcDJYMXNZZVNJRGRtVmNLMkVvVnE2R1lv?=
 =?utf-8?B?ZVRjN2RsL2tGdGpueFB1ZFJkSm1CMWZkcGtmS043WllNb2NSZzZsc1YrVklE?=
 =?utf-8?B?V2NHdTUreEtqMk1PeG5DV0lmOHl5WXB0VWdOb0RlbVhoUDJxMmNydlFhTjNW?=
 =?utf-8?B?UGZpRTFUZE9razVkQzNSb3lFRk5QdkZOOHNDU3JmN0FiaXdaM1MzUmNIcWJW?=
 =?utf-8?B?RTIzUGtwWmFrMjRHS3QwVmh2RkN5WVFUakpRekE4ZFV0UUQ2NzZXWW5Bd1J4?=
 =?utf-8?B?d2ZUazkyb0c2VzNyaFpjZ29kaFpka3R0Vld6bGFMN3ZTdlBZSVlxRVBzNExD?=
 =?utf-8?B?L0JuVENZL2RDNGkvcHR5QWxGcE5PbWdWOEJua3dyR3JwM3BoZ2JwNnZtUnhv?=
 =?utf-8?B?OWJVa3p4SHRKWXpSTVRDZFY4cEdBNFNSYTB5OS9kNU5aVWZEM0ZoOHZYN2o4?=
 =?utf-8?B?RzJ4Ui9JNnJOS08xMGRhLzVOQmhxUEU4SjRwTnl2SHNhSmZWQW5iMDlINWoy?=
 =?utf-8?B?ZCttVWwvY3hEdDFEMUJ1VWxRcjRXb1o5VnQzTHZ4MWZTWEFmRFRlOUVXMCth?=
 =?utf-8?B?bHBTSi9mQmxMODRBTk5jTEtoeUU1Z09tTkxXUVhUT2FGaUlDN0thSTJxYW9l?=
 =?utf-8?B?R1FGbXgwOGluZ21zVlIraW5iMTdFeFRjL0lpdXZTTFZ5N3orM1pRQ3VWUnBX?=
 =?utf-8?B?M1l6T1ZJRE9GRmRYclAvT3NTRXhVc3hEbkhzVktnWjZ1M3lUajRNbmU4Z0tZ?=
 =?utf-8?B?OUpTcmZGaW1vVjh1Q1pMSi9YTDdBRkhXalBOeklKTXkrVm8ySlFsL2t4V003?=
 =?utf-8?B?SmlpOXNQZVZuSUFrMVlOM2RyWXBrS3RSVFBDT0c4SktYZXdYUGdGbzYwVXBD?=
 =?utf-8?Q?ZkWVC/Y1C19ph7FRHbdo6uyZvCfGCLpL50JGsjs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEkyakhCVURhWXgvYWdoYVk5VUF3aEIrTHRzWnpTRFdXUHpSY1hCSER0c3Rn?=
 =?utf-8?B?ckxOZUZBVmlXWGhSemd0ejZjVjA5TmFDQ3BINHk4SFFNMlJKV3ZheG9BM3N6?=
 =?utf-8?B?UC9WQ0toNHZ4M0xQU21Lb2diWlliY0dvTE53L2tXS1g2ZEpVcExDRmk0UG8r?=
 =?utf-8?B?ZDBGZzdxK01mNDg4d3BHemR5RTMrWDdaTWJEWngvQTAvVHA5UW5WaStVN1lh?=
 =?utf-8?B?WkxtTDRHak5CS055Z0RqUzFNSWdTQ3EzejI1bytCRGZKa2RJQjNqL3JNRU41?=
 =?utf-8?B?cTFSZFR3T1d3aU1oeTJndU4zaU4ydnd4T0R6Rm5hdGFmdFR6eUNmL0IxVXZP?=
 =?utf-8?B?SXltRFR1Tm1hTTlqRk8wbW5vVE9Id3JJdnVQaGdpbEtrMDRnODRZU1grQjJz?=
 =?utf-8?B?d0YrS3dIV1I3QUNBQ2VlaVdSOTR1NExEa1dFQzJGYWxSS1FsdmtISjUvN3hp?=
 =?utf-8?B?R0RlZlArSWcvRE1DclJBZjdhaDFUU0haYjBwUjVwck9RemZvblVZL25MMDYv?=
 =?utf-8?B?SmM2MlRtcDVsT3dUQ3U0cXhOeEI1VlR4T2JqSmpPRXZvR1F0UGoyOTZUdUh2?=
 =?utf-8?B?dXFOSkgyNlRCUis3SDQxaGpWY1BJWkkxai9sWWNuek10TG9JWlpMVXErQWov?=
 =?utf-8?B?Q2ZHaGxwbjIrRFYyNis1SloyVEd6dWlvV2J0K2FJTmJyK3V2TUNXeW8zb0hz?=
 =?utf-8?B?UEJNcmV6OVR5d2drM0toMXBhQVdqTDNpa3FwbG9JbTZqeDd4bExvaE1mQThU?=
 =?utf-8?B?Q0JEbEtnN2hMU2dVcUp4cnFmOXJSbkdyMzZVOWVBdG41T1RUR1V6MmZhd0Fj?=
 =?utf-8?B?UUV0RmFuRGlIT1ZNR2RNOTdQVWN0RHR6eE1FeXQwRmtIY3dXclE4SkVUTWh4?=
 =?utf-8?B?d0RTR1U5dDFHcm5iY3ZoQXkwRzJ1bmJlUzdRcU8rYndrMkxmTldxZGJINEV6?=
 =?utf-8?B?Yk9jMUR4VUd1Y09ZQ0hHcm9Fb0p3dnEzckprd0dlZVBTU1AyQzhocU1YRUh4?=
 =?utf-8?B?aUZjSGFCNmxoNUZxeW82RVIyM0xVY3JNWmI4OUt6QnpwRlU5ZnV0UkRjTTNE?=
 =?utf-8?B?UXNtT1JaRHVEY1J2NDJ2OE9xUFVRZVlJUGdjSjdibE1QZTBqRVdBRTJ4NWRj?=
 =?utf-8?B?M1ZCTjFOcUpWK3I5K2k3dW8zRmtsSXcrdHNWWE5RT3R6ZzBsMDZmTXF5RytU?=
 =?utf-8?B?U3VwYnJRem5mYUZMeTY5b09Xb1N6eUxPMndXZTlieCt6RUlhVE1BSktVQVVu?=
 =?utf-8?B?WDBrekltc2piYnBYb0VRNDRUeWtoeXdoQ3J5UE9obWJFTkZhdzlheHVybmFW?=
 =?utf-8?B?Ynl3NmFDb0V2MTQ3UnArOFFQQTJuanF3R0FLMzgxS2NiL0xOcDNvbjdKYnlY?=
 =?utf-8?B?ZDJYbTA5ZjZFK25SUFYwR0RzTXBhdENRUjdKaHJseDhkTXFIeEVBMkVCNFll?=
 =?utf-8?B?SG1FMGF4cW5SS3FzRzdqdjcyQjlvMjlMK0l1bExWMGNqMHJPOS9STVVyWDBF?=
 =?utf-8?B?N0pQellYUjYxVG9KdnFRbGYvSzdUcDFlWTR3RHB4K294eWRlT1RvT25KNkxq?=
 =?utf-8?B?Zm9wZFhDRCtBTGk0akRITWVBWWxsdXorSzdkM2VUT2JMUXhGMHlNYmZFMXJC?=
 =?utf-8?B?NEJQVXE1ZGVLNlQzRlljSzk1cjJBMkJOVUZwT240U2d6S2cwUERZVk10cHNp?=
 =?utf-8?B?ZmVTODFJOVl3OTM5UXNsYjZtbmNYRHZweGhkSE1haVNpYmttcVRnSVBzYTRS?=
 =?utf-8?B?ZUZicmI2a1V3RzJBZHBOdWRFUmlWQTRoSkEvMnBUSTdEVjVieXdiNmY4RDdh?=
 =?utf-8?B?Vk45VFpvVlI5RUdhTDlmbEJxK1JXbjI5UHg2M2RlaXV3UFhiblZPdHJhZGs3?=
 =?utf-8?B?c0hibWVOeUtFaFVaa0FrdkNkN3FwNVlDaXMvaDAzS1RUWHpEVjVsVUI2Tjl6?=
 =?utf-8?B?WkgvQTJMUDJPMEdPc2hNNTF0ekhidmQwTDFhc25KekhpTW11OW5CbmhqZXcr?=
 =?utf-8?B?SXBjbTVMTnpXM2lHK2Q3UE15RTNZZHowWW0wU1V0d3M4Y1hLZmVzdmpkSFc2?=
 =?utf-8?B?Y1g5a2RyMmxUR2czTE0xcWRGMGZTWlpwUmVhd2hqbnRXKy80SmpFbFZMenIz?=
 =?utf-8?Q?Jsic=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3551c073-aec8-4952-7fc0-08dd0b53ef2b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 00:15:28.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+KhJbaOODmVeewxg0Qg/IXD2euHz01sLa+HPWsq2vXZQE2GTxnlOswXtYS6pQ/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

Hi Reinette,

On 11/22/2024 3:52 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 11/22/24 10:54 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 11/21/2024 2:18 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 11/19/24 12:12 PM, Moger, Babu wrote:
>>>> Hi Reinette,
>>>>
>>>> On 11/15/24 18:44, Reinette Chatre wrote:
>>>>> Hi Babu,
>>>>>
>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>> The ABMC feature provides an option to the user to assign a hardware
>>>>>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>>>>>> assigned. The assigned RMID will be tracked by the hardware until the user
>>>>>> unassigns it manually.
>>>>>>
>>>>>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>>>>>> specifying the counter id, bandwidth source, and bandwidth types.
>>>>>
>>>>> needs imperative tone
>>>>
>>>> How about this?
>>>>
>>>> Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and
>>>> specifying the counter ID, bandwidth source, and bandwidth types.
>>>>
>>>
>>> ok with me. Exactly what ChatGPT suggests.
>>
>> Hmm. ):
>>
>>>
>>> Please do note that that first paragraph informs reader that
>>> a counter is assigned by user to "an RMID, event pair" while the hardware is configured with
>>> "the counter ID, bandwidth source, and bandwidth types". There thus does not seem
>>> to be a clear connection between what user assigns and what is programmed to hardware.
>>>
>>
>> Adding RMID in the text might help.
>>
>> Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and specifying the counter ID, RMID, bandwidth source, and bandwidth types.
>>
> 
> Isn't the bandwidth source and the RMID the same thing? How about something like:
> "Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and specifying
>   the counter ID, bandwidth source (RMID), and bandwidth event configuration."
> 
> Please feel free to improve.

Looks good. Thanks
-- 
- Babu Moger


