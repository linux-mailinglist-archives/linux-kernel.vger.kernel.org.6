Return-Path: <linux-kernel+bounces-414918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB659D2F37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9853B23CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4931CEAB9;
	Tue, 19 Nov 2024 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SXYf2CZ7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74781482F3;
	Tue, 19 Nov 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046553; cv=fail; b=Ld33DD0nF9Yn/aPu1EfJepeu4vm3w5ElZkOy3awgeqQ/++mPOoKmly9lyZqsV8GOBdS92KSA9k5DYTWQXqDwHc5myV+vtH6sTFqm6vuHH/xVsN9gRDIVg2XqU5LWGKZwdV5J5Aq7N64D6rKI1UsbwrRxZ4B7RkFYfNaqYpBo6ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046553; c=relaxed/simple;
	bh=uaNtpdhiI2KFog88MKfsWC38zwZy0OWeDyGXoJkB8Hg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mpiU8NDxRFCunG8rI/Y+Ndi+yhutan527zSNHhfnDMcyxeM7XasLm727LQXJOC4S4kF54CH/7284VepWJkSw+XK711h0pKqRb2jYpnbdHtY5AoTvkLuMrIa9iUNIfMuIWu8tvE1v1Ej9dyeyJxlitXfi7qwxgoH9Pow+sbsnRfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SXYf2CZ7; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJ9H5TCo4NO7M8B0IaGpm98QCku5mvTHJsOhP57/0iFSeyE+kxLJo3nH9/X4wq7A1iV6NJ68lzCZPL4W3Y2DknfDCwqbh2TrNrwRbPVnlHNczMH/jmpjQdzAtwCiF9ki58ECxT0H5r5a+lP65n/M5Gxpdpb6aDUUCsrftis22guz3TJiQhU/Qj+n3ejFweUW0OEDpaIvz9EcTXt23VQlb8B0ftzq7v620z95oWoeCZHdkqP95P7IxqrhlO4RqRo41pxHYZliAnUFSOj/Gsl/UDBWvjzS1psdEKF27wpA+8ItzerzmggDn8uXhEo4coDLSTo3+/V6EakGZF3tnG6Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXzpPuPYSnE+fen267PwFIN+veUajEA90RLoXNCPpJo=;
 b=P/1yTcn9zEZgXecS32Q7hCW7JWjThtp+9Da0C99+21Vng9INphh1tfh+mEXR/bJQEwf4afwjr4xSbKb+PP+u2hIOY3MYUTbUU46nOCYZZ4nckH+Vsza8auk1zIAMug8eQA8ZyiHa6Bzl30BAJxbLgeQuLVTemnnP+yF2UjLPRlU38VM6hvV4a1pW9Y+nLLYLSF6F2LXK9ecMlIbUYj2JeZkhUccUtu14qSs8Oe/h4TSa6Qqabx8QwdVGmOOcn7nJpOidf+MCgLpc6z7W/ETaxQJ0+WGpd6uhSLEDCF2dDFx5iKON5usBZzSFJDgnxoQYYWhlDorEq5GjAw0lnlx74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXzpPuPYSnE+fen267PwFIN+veUajEA90RLoXNCPpJo=;
 b=SXYf2CZ7L1uRHv+dx1ty4ASykOduWXZBgFPojQRswqQ88VlXqp+7i313oehv65bxdoXZmMA2XqZm2BwPo2DheG9m0Zns6oXYWgQPYxRRW93vHKLFZFH83fQM8/jFlpGzCa+FtjsPI8daJO5wmmAS9JYBUQrq/r+WB2kOvLEf/Ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Tue, 19 Nov
 2024 20:02:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 20:02:28 +0000
Message-ID: <c5ca33be-762e-49e9-9bce-664befa5a8ff@amd.com>
Date: Tue, 19 Nov 2024 14:02:22 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 16/26] x86/resctrl: Introduce cntr_id in mongroup for
 assignments
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
 <be93dbe464747ef0b6e3158aacbd32499028cfb4.1730244116.git.babu.moger@amd.com>
 <49350779-c7a6-4fdd-a6cd-0fc5cf4d154a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <49350779-c7a6-4fdd-a6cd-0fc5cf4d154a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:806:d1::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: cde38ae1-2a1f-492a-2f34-08dd08d517e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVU4SlV4NmNRQjBZdGRKekxnREVzQ1RTekVzRTY5MkhvQVA4OG5lZjZDN1pP?=
 =?utf-8?B?ZzIwMno5WVlSQXh1b21PcVpIZFViakVyQWt2WVpHYWRzdUx3VnYrNzNPaHd5?=
 =?utf-8?B?cFFBblpsZjVMMTNCOVZLbisxcVBpY1p3OHFhVXRQZXl0MzV3R1Jqelk2Q0Uw?=
 =?utf-8?B?bHp4djZ6anY4Y29QM0ptdTdBaE80dUs1NE5ZZ3pZTzVrSWUvTmU1ZW1yT011?=
 =?utf-8?B?YTg3dCt4YWs5amFLWEdDV2ZBa1d6YjhBOEtSTHpzUWwvZWQ5T2lxQmJqQlBC?=
 =?utf-8?B?OFBXQWxLaWtoT2Y1SEYwQkxCSHlBOFhnUDJNeFhSaUt1Wk1QeFdhSzNKa0RS?=
 =?utf-8?B?RjZ0a2tEclhaK1VrOEZOWEpFSjBUWS9nb0tDeUxyY0pYKzlENkgvS1lxQ0dQ?=
 =?utf-8?B?TWNxY053UjF2ZEMwSWVSaFVwWHRyVWh2enhUMVBpOThIb09YaGRVWFV3RkdZ?=
 =?utf-8?B?cC9YWjl6djg5NkY5WVZSTzhyNE81ck93VWduN1Axc0Z1cXVkcDN1MWpMUlcx?=
 =?utf-8?B?STlYaVJHWmdlYjBNbmVZQzNZUUhDNWc3TE55ZnJtN1BoenJGSWZ3UUFyWFlO?=
 =?utf-8?B?a00wM0VONG5VTkpxTlNSNGhJKzgwOG53VUdCVVpRRk9mQ1JsYkpCcXNnR3V0?=
 =?utf-8?B?aFB0MUt6V3gvQkF3UkhDRmFyS29Tc0ZkbTVOSFBmdHpwa0laeXpqcVpyU1lD?=
 =?utf-8?B?Y2FzeDlxSzlYMmttT3dLUWpmaHEvVktQOWFzNnhwbXdHSFpqSXZKOGF2YlFJ?=
 =?utf-8?B?dWVUSUdhNHdXaE5UQ3NLTUQ4SzdYTkoyaUZEVmE1RS8xSjFuVzlRN3crTlIr?=
 =?utf-8?B?RTVTclAvVXRPRDFwSnppSUZIeTNuUS9XUndEbU1TcmcwRHR3OGtnVUpjMzZv?=
 =?utf-8?B?NGlYYkVYdHZVMjR6TWpyZU92a1NhL1M3Vnh1aDBVV3dkdFY5RjRUYVlFTU1Q?=
 =?utf-8?B?bUZabmNMWC9vMUlIVEhYQUF2Rm5FZjBmMmVCWkJDMHlVbVJBRHRaOGw5MTRt?=
 =?utf-8?B?N2R3ckhITWFzY2dacm1lSTZFV0hscUsxc2M5VmlUcmc2SHQ5cUFjQ0hwd0hX?=
 =?utf-8?B?K1d3dUlTcHJBbnRCMzczTEYzSkxDd0dWNXFuRVRkNi9NS21UY2pqVHBORDlH?=
 =?utf-8?B?ZC95dmdJUTFrUk9jWUs1UHhYV2lFSUhRd0cxRzhtWkVjOWwwNDZXUU1iR2I0?=
 =?utf-8?B?OHloMjAwNk1yVE5QcUxiUFltZWQ2LzNKdGJQNEdHSXRIVTlSeFphNDRkQXBX?=
 =?utf-8?B?emN1N2YzSXdTL2FBQ2NQSXJHNktsbTlPOCs0UUVCV1RxV3pmRm1ISFhVQ01C?=
 =?utf-8?B?S1Nud285ZnBnNHV3V09Bc2JMUVpaRjUvMWFSQVZtVVp0M2gxdnphQTZnbks4?=
 =?utf-8?B?MGt6YUJWb3VjY09aSWtaUDdCYVg5WWtKSTZFcytuVVRjczdRUWE1M2I0am5I?=
 =?utf-8?B?RTZDSURUaG5ESWZlMzFuV2QvenlXdHRJdXpjdDBVQjJRR1p6ZDVobkMzWHlX?=
 =?utf-8?B?L1pGVitsSTE1WFl1cksrZzE2Nk0vYkovMHV5QW1tS2xhQlovdW5UdDZGNjJB?=
 =?utf-8?B?SFA2eG1LdHJHV1dmeTFlWTQ0NUFZYklKcEhKL256SS9FbUowWVVqdFpaZW9r?=
 =?utf-8?B?dlQveVBBM0cwMnlpNlNGWjl0T3gxMnlETE5XVkloUmU5V3p2TldyVXEwM0hx?=
 =?utf-8?B?YVZ6TTQvQ2VXd2NmOURhOC95RzRnOWNPU1h4UUQwUGdGTjJESTkvSmtDN1Vm?=
 =?utf-8?Q?7mZtOltz0wgn0RIgaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym94OVFhR01JNUlMN3UyUUM2cGpQV2ZwOEFQTzdzRXJNRGtqQTh5OU1yckp1?=
 =?utf-8?B?MXFnVDZ0NWtoL1IzRlNaM2RWc2U3ZndaRDFxNVllYkQ3VFJrVUpkQnprYTl6?=
 =?utf-8?B?UjJKZlNxTWJCS1FYUExqYmhpNGtEanlzK25tdW8rRDFPamVuT2M5WTAxMWJl?=
 =?utf-8?B?WkZkZHRkZzYxTFU3SXJqaDJta0NXeWg0S0pRbUl1cUFmd0g5MHFRMmZXVGJx?=
 =?utf-8?B?T2VvT24xdHV0eXZUcmtGeU9zeVpPRDlzR2FYeDNPRnc1NVhJcDlnUVg4b3Mw?=
 =?utf-8?B?dU5lNE1MY2YyUUVzZm1UTkNKMnREQXhCZGxoa0wwOHFtN1JjK3pNU3NrekU2?=
 =?utf-8?B?L1ZMUUlXcG40VjQvbXFkYWZFTkkyeGcyZEhINytlbGxSRlB0ZHBVVzMxT2ZW?=
 =?utf-8?B?U3QxSG1kdEpDQ3NiTXVyQmlQYjhDMFErc0R6VFlFeVk2bVgyTWpJS3dzbXpQ?=
 =?utf-8?B?UDE1YjJBRVVmYjlWVUZucm00S1V0TG5OVGZCRzU4dDhYaGFHWGxpSGM5b1Ew?=
 =?utf-8?B?cTZBN01ubmZJemZwNC9UM202YlllTHBPUTdEeVF0NE1jUFZkTVNHUEpQOVgx?=
 =?utf-8?B?VXJ0RG4raUNNVHB2RllmcXVjRzR5bnh0QzUvREpWbjR3WmdZOThZZFFCVkpE?=
 =?utf-8?B?OXI3Mk9aOVlueVZBYitjOXI1WmhXUWxDcW5qTkNDcEtJL2xYbkxTdGhiTUZF?=
 =?utf-8?B?V25HdHZLVmhTcFBRWmRKemc0blRRMUJCSDBvK1lrNmtvK2hJYm5BZ3E2UHlD?=
 =?utf-8?B?a2pQOUh3OHU3Yytyb1ZoWlRyZVgrNjFmeHhPT2ZqMzNpSDc4cXhGaUxmWWVP?=
 =?utf-8?B?eE9GY29jekRoY2k5N2RESnVXOHRWNVRwZks1c3BuWW0vOWNZY2Q4VHA0YzRM?=
 =?utf-8?B?bGhNOFpLaFJuTFhYTytreVZMajNmMlhDdlppcXhQdVBIVUVhK2hhMHBGVTg3?=
 =?utf-8?B?Qit3czZ4SytBUTYzdWFQVXF3SFBqRlVUNmRLSEx4aFgzUnVCbnFqYXh0ajQ4?=
 =?utf-8?B?MHRRcFo2TG5VK1lmczl2dkpWNFJ3K2lvQjdUQVN5cW53ZTdUdCs1VVdPVHcw?=
 =?utf-8?B?N0FabHlWeUg5cW9DT3pJcUdEVGpuZWpRZVNoTk9RaEl6OVU4c3VZNEtmaGtq?=
 =?utf-8?B?Z2ZrMmFZVGJEdWtTQ1VneE9GcHh1Q3dwK1VpczErTko0UjN1cGJhbVRvVE1W?=
 =?utf-8?B?YUFHYXl5cnNBYmVscStRNjhXdk5aU0h1bkNwUGwxaURTSUVBTkJjUnczNFZK?=
 =?utf-8?B?L0xqNi9mZSttWm9UNTFtUnVDUDVIakZHUVl0V0k1Nk9pS2g3eGdmVmh1cUJv?=
 =?utf-8?B?VEdUbmFVcllxOFNOR1FGWDUwZXB3M3ZHL0NjdnZPb2hObkRVZ3ZZQlQ2NHFp?=
 =?utf-8?B?OTJtZ0pUM2FXcGJLK2o0N0FoTmRsUFlkcmdKUEFxZExpNHh4T2RvNlhHMzds?=
 =?utf-8?B?S0RCYmxlRUZTZmdPNVZqWjZYbDNJbnNISmxIMDAxSkJNR2Jra2UzL0FtUlNn?=
 =?utf-8?B?RE5hRkhGUTdXYXhrQ3ZBOVI4RjkxSitsdjBERGRXYXAyY1VzMmhDMUQzWEdm?=
 =?utf-8?B?ZDRJSyt2N3lJeGFsR3o3UkMwZFdFYXUrcXdsdko2M1RUdU9GYjliNHZ2MGpx?=
 =?utf-8?B?U0d5VzVhamdudDhGZkpkNW13SXhLRHNkUDFFcTdCYmpmMW1zRFA0cHVrMlRG?=
 =?utf-8?B?WTcxWldoL0M2UmV5VndmbTJTSzV0aS9tdys5cXc1bWRiTU9TNWRVdVdtZmtq?=
 =?utf-8?B?SUNpU0FDM0Q1a0JaL3pJRUM1NXJINHd0em14TWFiWlJsUlpMOEIwVGZtQlNY?=
 =?utf-8?B?OTNNYU95eFkrZXhqbHlsUEFpOTlUb3FZMzYrQVpiYlRvT3J2YWJxdWJBYVFU?=
 =?utf-8?B?OUpudVk4M3pqUVVXd0owTkRONzFVOXVJbEVzUml5V2wwUjVKNlBZREdpZGxu?=
 =?utf-8?B?Rk4ySHNPYWxhTmpIRlBuRjZCRG1LSkZLc2V6aTJ4ek55NU1JbE13L1NiTnJ6?=
 =?utf-8?B?d2JkeG9KcEZXYko2L1YzaDhhTWxJeklsZW05dkZUQWFKM3dyMWJvSUVtdlBV?=
 =?utf-8?B?Q2JoMWg2ZnpzL0ZhS0Q2SlA4UzlReEZWK0lzRUxGYWdFOVNKWXc3S2Z0UEhq?=
 =?utf-8?Q?BhhA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde38ae1-2a1f-492a-2f34-08dd08d517e7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:02:28.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpNOiMSNPY3s50+4OIf6QBJdIt2l9N2AEgObZCn+T5eJQ3yk0IIfwxEf3WgyydNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

Hi Reinette,

On 11/15/24 18:38, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> mbm_cntr_assign feature provides an option to the user to assign a counter
> 
> nit for consistency: "mbm_cntr_assign feature" -> "mbm_cntr_assign mode"

Sure.
> 
>> to an RMID, event pair and monitor the bandwidth as long as the counter is
>> assigned. There can be two counters per monitor group, one for MBM total
>> event and another for MBM local event.
>>
>> Introduce cntr_id to manage the assignments.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

-- 
Thanks
Babu Moger

