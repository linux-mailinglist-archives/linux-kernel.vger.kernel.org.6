Return-Path: <linux-kernel+bounces-374822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351AB9A70A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4DF1F22C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162831EBFF7;
	Mon, 21 Oct 2024 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YuCBo1IK"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27C198E71;
	Mon, 21 Oct 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530579; cv=fail; b=gVxdJG+Fasa64M4QcYwOqdVX4LIZ2/Y5sEnPYeR9Xm2U50vfoH1g+Vt5+4NF/cKvM/M87KCo8mFrmJ2tOa6lNkOIG6Db4FW+ponO5g6l632r9b21yROOu+pArmVH+Pp+DJCWdgs4LBI8RR+GamBs9i/QJmYkMwyBE98H7OJvCxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530579; c=relaxed/simple;
	bh=S65JkOfccOM/cCa8ilrSdGulQITynpYxzPoij8bqHHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QPROv0zk1saxwe7KBoOlkx+wVVxo4CRrJzUYI5NQE4tmC7ggcbv1fDGYEellgQs15olc0aMn14mKubiCYqvDNuKQGk3ercEKU5On9oCLxbKa6EywdJQKVixgvlMAhUl/6Cw3CprEl+23lY1G1d+9J+C37WQK3l5K8kyEiwYCRu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YuCBo1IK; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgWs3lzK8AUpUqsYY+3+CaiiDKxiTXVZR+0LYFi2YyJFbw0w38O/dPdljWh6cA2sF4eEmMu9DNuPb1nbXMIkv0/DlAg9uICMfKgqG6YJiXaUlbeszIk0NtCP9QXylZV7nPT9Z5qFf/v4zrWN5dZHX/kDqeGm6f0jydJWqUjnRycEvQ2NpxBlTmRxFUEgIKy2RgzCbXHib9FJb97puBy77QLXRNx4ubvAmUSsYy4NU3M7YAkaVAZ2Y+fE3uu63QWjYs06hTyLAeaNSI6NJY36jlLYdSt5TtavkbcVkEYz015yuokArA0Q0LX1ZKVaDtY1biZit0ZLZked5yjLnig0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvJiMC+iAWAm15gEsytyzmUp5LNIUMzAwwZPz9pEX8c=;
 b=cer51GdUJl+zHjgzHC7lH3GHWu/8WfsE4hXL7lEGu0s6pAApLxFtP5F22gTQeG7EKSzmnPmMapzg6O94DkHMy0thf5BFSxuwle8d6faMG4R3Vu49MPE+uI21F1CPvisNA1ORFDrq0Mrab84YMXTXA2kFvXMkbipUXoTMaRPktiUlpyswEiq1wqPEXDw9CHJsW8RLdm9cIEUi7NU+WnkD3j3Fp/6LP/zL+z38k2n3ucWrFiyP//cPRzcQH1dTBq/DyuYTycPB29B0+8ZzrhIobfJXhtJx+HXf/Q5azP9eEwAHDuEPw8U0KnhbSIEqJUzmxzi5uqwQfgMt796zJ2iv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvJiMC+iAWAm15gEsytyzmUp5LNIUMzAwwZPz9pEX8c=;
 b=YuCBo1IKqXbOsctjvEqusES0jqJ4ieCPYN4IeQ7dW8BaW8rqF/OJ0OJJrywiIDLiBsnoYb2zTyWjgN3OIHK4Ek8+acmOTYmq5Um0t69goOK1HJIdQ0pThoUtYCjL9Ic6MbK9g/s4MAP8e2kzQXfIieq7XvYrqCKyOzqSjPV7D90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 17:09:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:09:34 +0000
Message-ID: <56f3abef-439d-41e3-9ad6-44adca01eeb0@amd.com>
Date: Mon, 21 Oct 2024 12:09:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 00/25] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <9bc745ed-2520-4f33-85e3-881d3bf6aaab@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9bc745ed-2520-4f33-85e3-881d3bf6aaab@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3cc667-7e3e-4c6d-3fd0-08dcf1f322dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTVZTy9RUHJXWUtCcVdhSnBzTWNoSnpLc2NnaXlxOW1NUXVFRFE1aEdUbTRp?=
 =?utf-8?B?d0lqWjBrbWY4T2NuZHBaZ21PUmFEYTRFOXR5TTVXeU1FcTdTSDlNSEVYcGxC?=
 =?utf-8?B?RTlIMzlqR1hHVlNiNDE1eHUwT0pCSk1sL3RndU9ENk5XdEhnWGR2OThvSWpX?=
 =?utf-8?B?TnZXRjBZb3V6UndML3VoSEx4dmJvdmp5YjZwUldTd2VNRlZTWWdDalVoLzQ4?=
 =?utf-8?B?aU1XSVdZNEplY0Z5RmFYTnNnLzF3dXlUcGJ4VGNra3V5VHBoZGRJVmc0RWJs?=
 =?utf-8?B?K0draXd3Qy9lbUxXbERNdEthSlk1NHk1OE52WmdicTcxaGVodCtDSFJ1ZFZz?=
 =?utf-8?B?emhDUEhNcHVFd1hFUWtMa2dxWHhCR0hrQzVGRmcxdmczUUtkcDgzSmd0cVRQ?=
 =?utf-8?B?ZkhBckFZTXgveWJwR0Q5K21Fc3kzZ3dOdFZOSk5FSGE0T0x5dEcvSm1MK3FU?=
 =?utf-8?B?SEV3SDc1QVJHZmtsQWVJU3A3YVR2MDhiN3c5YzlBdFkrUUEyN2R5UUFMdGdP?=
 =?utf-8?B?UW90TlBtOXlpM0d0czNFM250NkYzVU9CU2gxMS9VcHJVVG44UENwY3QvTkZa?=
 =?utf-8?B?WEhyTEdVVmNQZHJsZFdTWkhZMjhpeGZXS3B1QlFLUEFPOFNvVmdHR3pCcTY1?=
 =?utf-8?B?SldFVWFmZlJQdEZvdjFyeVBKSUNlcTdZdkRPcmJ1YW1QdHB4SnNxQmxkdUVs?=
 =?utf-8?B?U1BDb0laQVBENjFvejYyaFgyYnRNQmhJcGxYMnVKK3M4M2NQSThvQXpqbmlS?=
 =?utf-8?B?ZVBFNExETlRTWHZLT1hFeFNkOXJDZW9WNUxlRk5rV1lNbkFGaHNVRUxFdDFr?=
 =?utf-8?B?aGZyNUhpSit1T2h1cEsxL0MrNXFYWjhmRFRsdW1nbFk5cXVNVXlyeXRDTUJW?=
 =?utf-8?B?cXBjbHRWQUM5QVkranZDQWxnOExJZ0VtU0lrcUFGVDkzcEZVL0ZvajVQU1dh?=
 =?utf-8?B?OHlwdEJtYXJOWXJRNEZTQjcyc29KckpqUjZxN0NBUVF6SjViMGltQ3FXYWtL?=
 =?utf-8?B?enJ5WWxBSks3S1JZZFl3cDFhRjQ1VW5pbUtuK1I5UGdQVkRHVTczdTZQaVpS?=
 =?utf-8?B?Zkt3K1RlRnpYQzZ6aTNBcXJCQ0x5MXg1ZGI4dkxXamRrQ1JsWUxwSEZCRURP?=
 =?utf-8?B?engvdVBxUlo4eEtLKzdKbHZLMC9MaVkxWnR4U0cxSDlZaWZqeHhrQkkrNUJR?=
 =?utf-8?B?ZGNqOVdMT0gybW5zbWtjUTlURHh2S3V6OVdVUEZHU09oT2NHUnBNMTQ2OGVi?=
 =?utf-8?B?QkNYaDhzcEhSWTJyWkFEWFhXY045dHVDWHRGNHQzRTRKMldpMVJHT1phUGhF?=
 =?utf-8?B?RW1qTUphZ29sbk1tTHZrR0p0N0ZTdW10M0ZUbUl1ejZJNDZ1cGpJeVB0cmRn?=
 =?utf-8?B?UURFeUdsVDlmR1M5WmxmTG1vQkxpYnNoNzNVUWF4cmYyMzl3TXFZcW5rQWov?=
 =?utf-8?B?dXhwMVNkWEwrKzdTODFrV2ZYeC8wVStPcFZuWGhnbmJ0emRDK0UwNTZHRkdy?=
 =?utf-8?B?TWE3Y0R5b1c5UzQvTmhvVEFDQ0FJQmpFbk5scjRaTWRWcTZUOHVXNElYM092?=
 =?utf-8?B?Q2hSZkdsVklQa1FBYnZObnRaYWVRcGFWeTVlNncwOEhyTXBUbWZPK21zUGVP?=
 =?utf-8?B?VEJqQm1OV05Qc1dqbE42Y1J3UklGMm83MStZVFBMMmcwVkJPVTNHWkVZbkc4?=
 =?utf-8?B?NW9wMUpYenZHZjVXaVJUWGhrcnJ1YVJ5Ymt0RTRGTFI1VE82MWhGKzRPVll1?=
 =?utf-8?Q?/mcns90IkG3GFtjBjaeuFAbOCvL5PAH0o11T9+n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnYreTN0QkJxMnlveUY0MGlOZmNZTnlPa2Rka1IrWnIwbXgvYmxSYmRPYWow?=
 =?utf-8?B?Mk5ZbWpBa1FveEI5cUJQYmFUL3JHQmZLVGpCMWFEcDZVQ2Z3K0lYUGxoZjJk?=
 =?utf-8?B?TlIxazVMSkh1bE9za2lpZXM1YUQ5b2Vnd2xsWnNqMVkvYnB3eW5rYnpyQk15?=
 =?utf-8?B?YXVvaXhqM0wxaXlNZGU2ZC9KbzVWaHh2VWpmSXBldjA2RTZ6VTRqYnlRZVhU?=
 =?utf-8?B?VDRXTTI5b3NLNmJHUi94dWw3OXJiUE02emgraXFEdU4yWXMyVmxMNVVCZHRt?=
 =?utf-8?B?bnhmeDVVYlpUaHNOekp1cXBKNWxZSjRLRTNLbmlIVGRnZGluelo5OWloMXVJ?=
 =?utf-8?B?cUIrckZaYWF0YzNFSnJUZHBTVGhuaHJNVXdDajZJVW5oQTdRaDl5QjFaOTRq?=
 =?utf-8?B?ZERmMUhTdjJtWVJpN3c0TUd5T2hha1htdkRWYk4xcVJ1bEFqN0NWV2QyYXpS?=
 =?utf-8?B?RXp2aHAySUhjWEJlR1J2UCt4TVloTHhyZVljaFdTM3dFdzlDejJ0cWtKbXFW?=
 =?utf-8?B?dWdqOWhkMnZOZnhOK0VCR0RVdHgxZmRPNkZNWTczN1JOb01VeGVsN3pYeHpa?=
 =?utf-8?B?VXlMZTVXVCtGelQ5T1pjbThoSE42OGQyZ05DbmtRaytBaFB5QUhBNHpZVHU3?=
 =?utf-8?B?eU1PaWZQNE9vOWFYTW5hMWRwcVV5Qjh2ODlDV0VZbTRZZE5Xelk5dzF6TDZC?=
 =?utf-8?B?NWJoSVRRWm1iN3VCVVZJZjBCOTlaZTFYWFFoSThuMWx6Z0NlVnBPUXVSZWox?=
 =?utf-8?B?bmVjTG9kSUVFVHV0Tjlxd1d3cjVKdDEwUkJlRFlmaFBJNFp2K2hSaUx3azUx?=
 =?utf-8?B?UFZIaWM4MGtSSEU5bkZQd1dBM2YxcVJlRmZvVlVhckdseTRaSW5MNUFiNUkz?=
 =?utf-8?B?S0ZpN2tGM2Vyb3l2OWh2bVhwWWlaS0FIcHhLYmF1VzQ5alVxUlg1WHJyNmd2?=
 =?utf-8?B?YXI3WjlXQWRyNmUxbGtYRG5TMDM4QnVyUjZjM3Y2endUM0NvWThwbFBLYkVL?=
 =?utf-8?B?eGN5OFhEa1NkT0lOUmovdmxSRUZUQmp5dXZaaGQ4V1JSTUdCQXpMODhDZDZL?=
 =?utf-8?B?WW8xVHYvMDEwamtKeGlnZURzMzNnK3ZYc3dsYW5xUXZranZoSWFBTmtoWk8w?=
 =?utf-8?B?RTFUZHdKQkZINi96ZlIzOHUxVlUxdWxOS1ErTml4cTdXaTNSSnIxWUFZanpl?=
 =?utf-8?B?bmRqZnloalZyL3dZVUxVcFFSc0lSZWNOTG15Zml2MjhWVmhtYkdWSHNZN1JB?=
 =?utf-8?B?K29seS95QTloQ28xdTZOOENBSVNJaUczVkNtR0FFclFNd0hMK1ZrWHBrZW5U?=
 =?utf-8?B?SjlSOFJueHVzblcyT0xSbk0vakNNU0Zwa3dwdzBCWS9FVjQwRmtTSGJwYWta?=
 =?utf-8?B?MzkreW81WTFzV3FGZ2JyanpBYlo5TFkyYlc1VTVrVXpwc0ZVekljL2srK2RE?=
 =?utf-8?B?Ry9qMktHaTU1MzkxWkUySzVkV2RXLzM2MWZsZStVNStPMXNVeTlVWTdJN0RV?=
 =?utf-8?B?Z2s5SHFWVjl4MzRCWWhyb1R3VkJxUzB1dWN4ZDJXcThnR1VCTjMxYjRrZDRF?=
 =?utf-8?B?aDh1dWZEMnVPYllLM3hOMnEvbGczQ3RsQ0VpbnljREcxQitwRzFKQXFIRFVC?=
 =?utf-8?B?TzVrOG54YWlqQ3lHVDJmT0ozdHJsSnlzZTlpMHM2dDB3QWcreEJ5dGZ5N1Bz?=
 =?utf-8?B?ZUc4V0V5QlNHUTBiRVhRZ2Zab3luRGIrZmM2YU9raHVGNmpZZktQS1lQN0Vt?=
 =?utf-8?B?b0hid0R4dmhkdG1OQTRIbEY4SUJ3WGRSTjdBLzN2eTR2dHU4dGFDOURrWng3?=
 =?utf-8?B?dkdSKzlyTHp5TEc5cWpoVjJGVjgwRzkwdDlHc3VjMzNGL0tlNEQ2NzE0Y1Zu?=
 =?utf-8?B?ZUdsZm1ZOS9WekVxcFFNODFmZHJMejhpR1EwT1dFdm9XdkhPNDJiRzU1NFJR?=
 =?utf-8?B?Q1ZrMjdOMUgvVU9HMmpIbW0zR2t4ald4bktSbFdxZ21mTDVxYmNlTEZ1Sy83?=
 =?utf-8?B?Rk5BWmlaYnRhNTBFK25Dd0xUN2d1bkNRMkRPZEZKSk40b3VOSEIxdm92ZWZx?=
 =?utf-8?B?WWV0NjRXcFlXczgrcktTMnQ1d2hyTXcreWIxYUFZc2xNKy9FdzRSVFE1VzFR?=
 =?utf-8?Q?p88g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3cc667-7e3e-4c6d-3fd0-08dcf1f322dd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:09:34.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBGfW/CfRm+3HjYd6xYVCSBFHEdHeFSVLRMjNs7uiIVJ3GdkCFsaaqWFArXebKCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

Hi Reinette,

Thanks again for quick turn around for this series. Will start working on
v9.

On 10/15/24 22:05, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>>
>> This series adds the support for Assignable Bandwidth Monitoring Counters
>> (ABMC). It is also called QoS RMID Pinning feature
>>
>> Series is written such that it is easier to support other assignable
>> features supported from different vendors.
>>
>> The feature details are documented in the  APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC). The documentation is available at
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The patches are based on top of commit
>> 5b0c5f05fb2fe (tip/master) Merge branch into tip/master: 'x86/splitlock'
>>
>> # Introduction
>>
>> Users can create as many monitor groups as RMIDs supported by the hardware.
>> However, bandwidth monitoring feature on AMD system only guarantees that
>> RMIDs currently assigned to a processor will be tracked by hardware.
>> The counters of any other RMIDs which are no longer being tracked will be
>> reset to zero. The MBM event counters return "Unavailable" for the RMIDs
>> that are not tracked by hardware. So, there can be only limited number of
>> groups that can give guaranteed monitoring numbers. With ever changing
>> configurations there is no way to definitely know which of these groups
>> are being tracked for certain point of time. Users do not have the option
>> to monitor a group or set of groups for certain period of time without
>> worrying about RMID being reset in between.
> 
> "worrying about RMID being reset in between" -> "worrying about counter being
> reset in between"? 

Sure,

> 
>>     
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>> assigned.  The assigned RMID will be tracked by the hardware until the user
>> unassigns it manually. There is no need to worry about counters being reset
>> during this period. Additionally, the user can specify a bitmask identifying
>> the specific bandwidth types from the given source to track with the counter.
>>
>> Without ABMC enabled, monitoring will work in current 'default' mode without
>> assignment option.
>>
> 
> Reinette
> 

-- 
Thanks
Babu Moger

