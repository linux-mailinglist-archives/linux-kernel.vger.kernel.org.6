Return-Path: <linux-kernel+bounces-171818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457808BE919
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF54E282792
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6E16D301;
	Tue,  7 May 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PX3/bUqx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E89816C453;
	Tue,  7 May 2024 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099310; cv=fail; b=WEz8sFidsSjacZ5MmcTlVGKQExuuvC87EXLZQelQshbA6v+63IHFzaSUPN42HjA7QNpkQfBBMKC+NvvFs8i2QvNd19Jvr4q8dWvG3EX2Z/R2pX3WPil60mhnmFE0DrjzShmKS3QwoJ5SbZVLdftinIWzQVMlWUlb4SfoNqL+LoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099310; c=relaxed/simple;
	bh=xB0AS24RAJmnKV2LhSkEVd+F5bhjvoo8S9ifWpwQNeI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CVS6jgH9MYzwtSyAf2XaCJJVAR7LDiYoHNplHRiPc8kZrrgjvOVNFBgHdVkPvpUdmD4d5zqB6mCetYfal3x2A08+wcYyYoN7pHV49fMxomIPim728gEdvXu5P9DsVeOMXvnHeOizSAWRhY6y356T5u9XiJUcFBA9lHIr6A2KMdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PX3/bUqx; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODnCX3sFRPO5ImqdM5Mm4I3ESFdaAp72rRaf5PXOvzzaGiaxdFN1LZ7mAGAdMO8ti8rQ+kmGZOHYgWhesmePK0Xh/fegKwpU0erS0rPCtb/WW7Y5+ogr3JkNnCWr6A2Rv7LIuRnX2hp/pswN2dJHdBCyAlPTsoU+yBih+81OkG+scf7A1y2XHjsiy56vHw4yThLDR04aGfn/uBSAgdYgItRtmzgNj3A0BlvJPD1bBjUskdNCGhyqlmXsLvhtRqWYGfO52SA5YSUl/lTu9OQHZjt4N6ustUh0NaLy1ablx1nc97rVAhmScl1dSqcEa55nSnVQz+WbHQlU7k6NL5nhLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbo3X8GyWl7M1x/kj1phUGkDFRlbo3wfVanUB6S8No4=;
 b=Ni5ruVO1ybO6TonjCJnWZTopv/FSWB2XCZc+elFN9MfWAJ4U63/nXSh4wZo6v/WbXGbk5mgUDTTlDJC58JXE++RqTIOdpJ2KB+hh67AqnoOtYJBF467oC0nXgOiTRxNkmzXRSqTnkvkLQuSrzJ2kyWra4fg3MO66txN4tOlPM3K/cXeeKQqRcYAFh/y3wUuA2Hgc8soaSRIofjosEoiaz+TXMjHc3WkPR+dyv9k7LGEL9fwsWVFH4JOZoLe0XXdgCJHFwFXN6o/GITqA0Eecztj7huJeos7wlNTC5pW/RzYVYWefoG6IFRQiTmW8pASjoeeoSC2QgiKaGjl4vTFOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbo3X8GyWl7M1x/kj1phUGkDFRlbo3wfVanUB6S8No4=;
 b=PX3/bUqxcjwrfH2oOpV10XZKoWFOQ+M1B4ZAj2i3hCiRae6Lhn8lnqyadJCLl1EaRcC4jKIvwSeb1p38yKCMj/JFfWcr+IepleUewO7VMh6HSziT0DdV7X0uzSjmCoWivQmeHV+McRz3UoZoUX7F4Fh1vKoYKg+IAxzHpvc/f5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 16:28:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:28:24 +0000
Message-ID: <086a6c59-f617-4714-b91a-2b1deae8e33e@amd.com>
Date: Tue, 7 May 2024 11:28:20 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [RFC PATCH v3 05/17] x86/resctrl: Introduce the interface to
 display the assignment state
Reply-To: babu.moger@amd.com
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <e50e1e55c2ef4f5e1609960e573b30a125a59e5c.1711674410.git.babu.moger@amd.com>
 <9fd1c700-fa24-4290-aa77-a6eda9758ace@intel.com>
Content-Language: en-US
In-Reply-To: <9fd1c700-fa24-4290-aa77-a6eda9758ace@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0015.prod.exchangelabs.com (2603:10b6:805:b6::28)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8b2fdb-12b0-48d5-20bc-08dc6eb2b7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXpBbXFmdVZJOHRxK0IyTThCczV6c0RxKy96MDAwSmFQQnBObHYwUkp3bGYy?=
 =?utf-8?B?Q3hxUWxFL2QyNVpZNENWMk11aU03ZUw5TDN3RXRDUWhkSHN5RWx0eHFzck0r?=
 =?utf-8?B?eGh0ZWZ3RzZnckdrYnZ3UWwxYm9GWWJHWUd5Ti90VHd0VVlQRkxodno4UVp0?=
 =?utf-8?B?YmQ1N3VzNVc5NFQ3d3QvVXdXRGVtQzU3dFUwM2hXN0Q4M3I2RVVHVEpacTlC?=
 =?utf-8?B?bVo2aXlhSHl2ZFhkMUlUanR3MUZSVEpSaitzbGZ1VWQrNTFKWHBRTnJ2b0lD?=
 =?utf-8?B?dTFEdElnMU53Y3JaR2ZrMkNqVHppK0UrSGVjRG9JNTJaNnVtYUgzZjZqRmJ2?=
 =?utf-8?B?ZThsN1lHcEpIZytvNXRrUklDZjRobU1PTWx2Ykt3Vk5UeTdMTCszTjY5Zzk1?=
 =?utf-8?B?S1FxWW5lTmFGajh2b0pPUzJrZFl5VGFXc1dkWk4vaURLVmJPeGg4L2Y1cGFK?=
 =?utf-8?B?NDZLL0UyMDBlRVJWekRyMk4vbEx3OStPa2s0eTN2OUFJclBwL2VVTkk4ekZF?=
 =?utf-8?B?ampUUjRoenpscXZwWVBPTWJ4SHZrdURtS1VvTEIwdkFrK2FsbUp1YzZpUjFF?=
 =?utf-8?B?RmRldmxJUTZMSmZVVnZRSUlldUoyOW9lQklrV29rV2kyZVh0QmlKYXVqOW5j?=
 =?utf-8?B?QlJUaE1JMTJPcnEyMFNKR2VoWm11U2FoejdDOTArVzdublJ2SURCaXVhM1Yw?=
 =?utf-8?B?TFErdlhuMitxRzRybk45blFENElEaHNYRzhYNHNkK0sweEQrZ0prT0NTWkly?=
 =?utf-8?B?UDhzckpJTnFsanFzb1NURnY1LzlTaGhOMHdveG9JMTBYUXBZamlQTlFhcW5W?=
 =?utf-8?B?WWpYV1NiK1FwNG8vZzB5K1dFWnJpdUpFNU4vcnVGQ0VxbXMrMkltWkFabTJZ?=
 =?utf-8?B?THhCYkZxVW9nYmx6ZFFzMUYrSEtpYUhVRUU5ZlNHZ2MvTVY0SXdNSWhRNTAv?=
 =?utf-8?B?SWNUcnNkdlVEU0s0UnNWeWhIK1VwUUlNVHdscEZSR3NuTlJDbE4vWkE4RUoy?=
 =?utf-8?B?STUyTUoveEVucVRSVWRMUjJZY2pCNm9kNjJPWnVFQ0JYS1M5MjBBVXc2RlU5?=
 =?utf-8?B?R0F2M2JObFZJaUI3cnAzaG1QdVdLWGwvS2YzdXB6VXpZTGVESy8vWGNZc0V6?=
 =?utf-8?B?bkNJUXBiQkR0Mlp2MmI3TEJtRkxwam05ZHdTYVBHTXJCeitlWXhHS056SnRv?=
 =?utf-8?B?aEhLRCt5YnZqY3ozSTRPTFV6VjM1eHJsMmwrc2JCUVEyRXpUWnJsNGlzQW5N?=
 =?utf-8?B?OEJKRU42VTRDZ3FBdlcrKzZFV3NVM1lJZGdkc29VQnJJSGhyaVRLV0diY1hB?=
 =?utf-8?B?Wlo5UFpnRjJLb1VTMTJSWjZzUEFYVE9WODZpMkF4VFZkaERFUkVBZlptUlZs?=
 =?utf-8?B?QXg3VE5sV1I2ejJSbUtERzFGRXJBblptZjZrM0RlcU1pSjlNcDJhcTRxT0Vw?=
 =?utf-8?B?QzBaYXJCSkNjdUprVjVObGUxV0ZIOUNHZXEwaTJDU3RkckRjaEdtVVVuYldD?=
 =?utf-8?B?UGlwamdCdnlMUmwyemFNbUtKSFlhNUxPZ0JaT29ORlplVXkzOE8yR3F2YUxO?=
 =?utf-8?B?YTFHa1JTbEZVdzVuRjdYdUJZR1RjaVB0R25jT1U3UjdXVjg5a3FRL2Q1Z1JJ?=
 =?utf-8?Q?hAq36FKVfanBlAwJNwlD8S4hkFd+Yr8E6Lgp6kEGbpPE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJLUmdFWGw3OEt1MUpXUzNvSEFHcWo5dlp1b0VYSmhvNkVGK1EyRks2aVFD?=
 =?utf-8?B?ZTdwSlk2TW1TWEpTckw3dm9TNDRuVmR3U1kweHRxckJHUFR0TzgvNzlReFB1?=
 =?utf-8?B?dGdpY0dLMjFxeGMxeXQ1Z0NDVWM5UHEzMG9RQnF5VFVKb0RYWkVDa2xSYmt6?=
 =?utf-8?B?bVhQZnJKSElzQVcwWFVQeVh0eHBPL0M1V2NoREZGM0hFdHJlQTR3V1hpbUJI?=
 =?utf-8?B?Mmg2SXpOL0FXSm9LOVJwTGdQc2h5TGx2UzNBcXRjUDYxSjA1bGo5VjFOdExr?=
 =?utf-8?B?bmlGTjE1d0pnY0ZBUHpLdG4ySy8wV0Myc0dSYlBnMXFLMHVZK1hpQm04Vm1R?=
 =?utf-8?B?M3A3MVJKZ0FaUGQwOE5rR05pVWRZOXc5d2owL2dhc1VyeC9DUXNaZFlXbEw2?=
 =?utf-8?B?WFBISmFJWFBzQkowYnN2M3p0S1VFYys2MVdLMDVxN2RPbWxydkhLNE1OWC8r?=
 =?utf-8?B?VkZrZ1ZscWZSUWg3NjRKb1V4M0ZuTTRaZVR3a00xOVpnVUwyd2VtaTdJcEhh?=
 =?utf-8?B?UjgwVFNEQUxOOGlGaWM5RHBNYzE5WWhEM0JodkNGVlNqeGU5WWt0U3BUYTNR?=
 =?utf-8?B?cmF4YkVjRndiUGNrWEYwdGRrbEZCZjVUVEQrUXdnMkc1b1hIb1UzKzlvWWts?=
 =?utf-8?B?d3N0N3ZLWERLSUw5VmtPcmZvTzgvRTFJTVlBNWtDcmtWNjdlVndZT2doSkhn?=
 =?utf-8?B?T2NyZ1pVK05BU1BXdUxoREwzQmJzQ0JsSWEycExtaDZoN1ppNms4K0FSYzA2?=
 =?utf-8?B?eEhuMjJ1cTJDYUlSYkdZZTVrdGt2L05NZGdqNSsybGJidE1lMmhjbGRtaTJh?=
 =?utf-8?B?Z09BL2E3SXArMCtpS3B1RGYxQXFwQmppU2V1SjZ2dE9kdVo2OGQ2d0FkMjFB?=
 =?utf-8?B?TjE1ZkNTaE52cXRkRVIyNmkzb1ZmMTFhRzRsbTFJdzU3elZjZjJxVjdnQTg1?=
 =?utf-8?B?Y3lHSXNreHlRbGc1U0huTkJudUNqeWRXVHA0aCtzODlxOStUd283NzBWYUJJ?=
 =?utf-8?B?U0JXVThKcStlK3J6T2o3dVlQdlNtN3gycnJOYzhzYTZlZXhFYXE1RzU4MmNP?=
 =?utf-8?B?V3BxeVVoOHgvQVBLczhiWWQ1NGpnVUw5WFJBZ2tnM2JiT1o4NFluSUJMTzh0?=
 =?utf-8?B?ZlFkaCtVVGwrOWtaTklsYkRvWEs0aThRNlVTM25mem9rOU9RNFNlWWNqa25F?=
 =?utf-8?B?aWtnVmp3QUU3cGkxZG1tamZoVTFRdHUrK2hvNDJha2pKRTdFdzBTWEFMUitP?=
 =?utf-8?B?WW5KYXo1Q3N5OFNzZExDUGtPbVBvZ1I5eXFLdUNuUGl0VzBEYitTdXh1RnJD?=
 =?utf-8?B?OS82bW9uVUQ5dU9sUmY0VDNTUEtjVlJSOWxTcmlqSUxSd2tIY3U5b0UrU2lR?=
 =?utf-8?B?b3IzdU9pa1Q5czcxZFhFSHBTM0JPUzgyb0t3bjd2bTBHdEJ4R0dVamhtYzUw?=
 =?utf-8?B?QVdJRm1hcFNGeHpjRUNIbzdiVHVlbUEreXdLVEo3Ly91UjVZYU85YlZ4bEFp?=
 =?utf-8?B?RlRvU1hkY3p5eTRyU3N3S0laRjJhSEdnTHdSQ1dTY0hybGtNSnFydC80clds?=
 =?utf-8?B?dWVBUEg1SE5GUllRcHRsTU1vcmRQa2JtNEE4aWYzVHFDbVpPOVprcUhySndP?=
 =?utf-8?B?NlowSUtkSHhJM3hJK3RKWHB1QVBEc0hSaFhNdHI1aGR6c1V4aVdJQVNMcjU2?=
 =?utf-8?B?eTFpNmxLSU9CNXFwS25zNUxIR0dZNWluZ3o5VEYxWVVpNlBtVzVaL2xoRERK?=
 =?utf-8?B?NnhkcGlFa3ZaeEV0dzVYOGI1bFdDK0tqbThCYlpZOEZ2WEJ1bUF3QmRNMkRK?=
 =?utf-8?B?U2hKWmJJbGtPR1VTb3BJUGxyUmUycEVDalpLaUZsT0ZVWFAzell6bUVSQURO?=
 =?utf-8?B?L2FhSkx4dGNMWmQxRUFXQlp6SmdUZFo5dGhUa09Tek9vMDErRE1OYTRISWl0?=
 =?utf-8?B?aUhyTlJ1eDh1QWdZaUZXMlMrK0d1WGF2K2lZMVB3TlVnQ0pYTGxHSWdNUTRD?=
 =?utf-8?B?cmtHcjBoVmlUaytlM2g0ZXh5S01XTVJVWHArR0RubWNKZTEwR1pzODBJU2xW?=
 =?utf-8?B?YmFmbG1rN1BhRThMTVF3UTBpRGRRQWZWNGZzRDN1ZG9NVlcxaTFid2RoeTRx?=
 =?utf-8?Q?uKSM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8b2fdb-12b0-48d5-20bc-08dc6eb2b7b6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:28:24.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+wUdHyKesTyDiBoJ48q8HngkJ8al9pbwNVcTF0Dc0XMOhDypo6Ps56hgeLnuuLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

Hi Reinette,

On 5/3/24 18:28, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign an RMID
>> to the hardware counter and monitor the bandwidth for a longer duration.
>> System can be in only one mode at a time (Legacy Monitor mode or ABMC
>> mode). By default, ABMC mode is disabled.
> 
> "By default, ABMC mode is disabled." seems to contradict later work.

Yes. Will correct it.

> 
>>
>> Provide an interface to display the monitor mode on the system.
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>     abmc
> 
> This example seems to contradict earlier statements in two ways:
> (a) it only shows one mode vs. there are two modes (legacy or ABMC)
> (b) there is no active mode vs. one mode is always active.

I need to correct the commit messages. At this point this interface is
read-only. I will move some of this commit message to patch 15/17.

> 
>>
>> When the feature is enabled
>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>     [abmc]
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v3: New patch to display ABMC capability.
>> ---
>>  Documentation/arch/x86/resctrl.rst     |  5 +++++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +++-
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>>  3 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 68df7751d1f5..cd973a013525 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -257,6 +257,11 @@ with the following files:
>>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>  	    0=0x30;1=0x30;3=0x15;4=0x15
>>  
>> +"mbm_assign":
>> +	Available when assignable monitoring features are supported.
>> +	Reports the list of assignable features supported and the enclosed brackets
>> +	indicate the feature is enabled.
> 
> "indicate the feature is enabled" -> "indicate which feature is enabled" or
> "indicates the currently enabled feature" or ...?

This looks good.

> 
>> +
>>  "max_threshold_occupancy":
>>  		Read/write file provides the largest value (in
>>  		bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 735b449039c1..48d1957ea5a3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1058,8 +1058,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>  						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>  		}
>>  
>> -		if (resctrl_arch_has_abmc(r))
>> +		if (resctrl_arch_has_abmc(r)) {
>>  			r->mbm_assign_capable = ABMC_ASSIGN;
>> +			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
> 
> I think this will need some more thought when considering the fs/arch split.
> The architecture can be expected to set r->mbm_assign_capable as above but
> having the architecture meddle with the fs flags does not seem like the right
> thing to do. I think that RFTYPE_MON_INFO may not be accessible to arch code
> anyway.

It is accessible to both arch and fs code per latest code.
https://lore.kernel.org/lkml/20240426150904.8854-33-Dave.Martin@arm.com/

> 
>> +		}
>>  	}
>>  
>>  	l3_mon_evt_init(r);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index dda71fb6c10e..5ec807e8dd38 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -846,6 +846,17 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
>> +				    struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +
>> +	if (r->mbm_assign_capable)
>> +		seq_puts(s, "abmc\n");
>> +
>> +	return 0;
>> +}
> 
> Should it print "legacy" if not mbm_assign_capable? Or actually, I think
> the expectation is that this file will only be accessible if 
> r->mbm_assign_capable is true ... so having that if (r->mbm_assign_capable)

Correct. I need to move code from patch 7/17 here to correct this.


> check is not clear to me ... if that is false then it would be a kernel
> bug, no?

Yes. This is not correct. I need to fix this.

> 
>> +
>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>  
>>  /*
>> @@ -1903,6 +1914,12 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= mbm_local_bytes_config_show,
>>  		.write		= mbm_local_bytes_config_write,
>>  	},
>> +	{
>> +		.name		= "mbm_assign",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= rdtgroup_mbm_assign_show,
>> +	},
>>  	{
>>  		.name		= "cpus",
>>  		.mode		= 0644,
> 
> Reinette
> 

-- 
Thanks
Babu Moger

