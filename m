Return-Path: <linux-kernel+bounces-255488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0093415D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16711F211DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684D17FAC1;
	Wed, 17 Jul 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K4/FJkJS"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53392224FA;
	Wed, 17 Jul 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236769; cv=fail; b=qasXQV0eYLnVquU4HDkPQUkmlRIpNUIMOnLl8sSjWkVh2NEQxYAiM80fm3oo0A2Hgsv6eVmF8M+W6CiAYEFl/6IITBzR1tC/kDlcFwOSt10QYJLAgv0czhyiO/L96myXOb9HTNlKvkBjCf8ha3OyOeDplSPfLDlE3qvh+XCABlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236769; c=relaxed/simple;
	bh=FCdOh/NFJtKwD/i80adJbQSwMI8M81GBdDYxezsk/20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EmLvT2lIMMlm5S7cCTC1Wrt3fa71divHUCa5YiSJZ59bRcSyrXY7ZlyemMK3rNYcqgLA0s5/AW9RnGqiteUwS2nNdaagdekGpI3Jw2/KYB/Dswh/RIU2ga0uYv5AbS900iQCUOJX2nBxNCFy87l+QgspHxOrtdTAeLVAiVIUMl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K4/FJkJS; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9uAkX5UQQjeeRaS4nWUyNpPxFbiBf+doUZ8AXDTvQzqupMttlDx8u+I0pIE0RUnhHpQhInbduNmyulvhf2+w6WfKAEMcm05hlE293ohVZG5W1ZKfqhMsHCORq2hixQKBYJwJIGpRBNPYeikzneMFqvaCB/X12HhgICqKynucae40S1ltwzBfnuUVDlJOHrIBDXNAHO7K6rufjj9R14HLoKURD1wbA/4lLHR7CjD6kiPCbkQoR1PcvvmdU9w7DWooYJUYVPQd0sbg9PGCwACPZNYM2diiop5nMwvHL1oTecfrBurJIXwlDRMxyfTu5iuMb0xGgT1sihY5kHqYw7a7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTE4oQA0GOKV2pk4+rcDzSM2iXxIQEPSJV0BnQkP9cY=;
 b=QOMMr6hc9Glw8YVwfgQHgBR9NTxbjTbCV9kxSCXEeexSfGBI0bpXNfVL58Up5uYt7ps2gbTcbMFbeioiT+Aca4wqf2vQhdobbdUEqsM7ua+tpvFUgVJJ4qnhkfroUIheB6eAuC+ptXxQQ/pVURSQ15kY+bv2+nH5ZcDSm9mYEsAlHyc8QrWjspu5zBhMiW9+0J1zQV+E+XMkS8xS5gf5lwkNJXAMKmgukmEiG4iw+8O6fF0Dl12QUMjwWh+oKEvnKGnZ9Qumavhf0BsCii7eBHk1EEZ0lF+cRygXDqTSsEIErAjrDfbjeGGjlHaDwDOVQOX1/EOJnqmYPLIMNp2S+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTE4oQA0GOKV2pk4+rcDzSM2iXxIQEPSJV0BnQkP9cY=;
 b=K4/FJkJSIWpyK9PYc3edPHVBn04mbt18+ERlq5K7Yu62nyhsXjf0ci+i1R1zsG4+RnhsT57CMFypieuQdhKMizScR6RACEPIBN/xyqcPtIHQEteXG2CPbsYXfeleMMl7ZPHTN4FwM/4o99aLT4DGGsm+FQLX3c5e5P7/Wf2eeMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 17:19:21 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 17:19:21 +0000
Message-ID: <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com>
Date: Wed, 17 Jul 2024 12:19:17 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e59eef-a922-4140-b45f-08dca6849948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU11WTRNNDVFS2gzSVJER3dFazI3RXU0ekhtaEZMaTNLUExlTS95OVRRSmRa?=
 =?utf-8?B?VGlSb3FuVGhQMVlvbzdzNHlaMTZ5K0h4dmZiemVVcGdvdnNEa0FEOVUycDE2?=
 =?utf-8?B?QnI1dm1nT0xlRGFCT2VhQSs0OWFQbnBpNFRlZnNuMmg0MXNKUDQ3SWp0djVv?=
 =?utf-8?B?UzhGYkpNNlVyMXJSWEszUmZ3V0MxSU5uaGF6RGF3TmU3VC9IV3poM2d1UE5X?=
 =?utf-8?B?V0hHWEZJVUJxZnpISkhkMXZ1c1JrY3VzT2c4T01lQ05FRzN6RVVTMVYxTUNz?=
 =?utf-8?B?Z1dTek1pUmlBeTdRYis5UUYyZGk1WHdnVWRiek80VERrL04zTjY5bWVKVFNK?=
 =?utf-8?B?R2xkd2RZTlVKNU5KWXpqcUhwV0hiRThZcFV2RUpHcFVtMlJaSmdyODg0Qk15?=
 =?utf-8?B?U3VGTmxxQStKM1k1UjNiS1gzSnhUZERRQzJxb1VUbk1tOUlPbVhuSmhuc0I1?=
 =?utf-8?B?dTNZbFhkNXVER2hTRHQvVlB2eGNFQzFCaytxMEpIanhweVBtN29OYndtbnBy?=
 =?utf-8?B?SUd2anRZb2tnclNqNm85cTNwTERYWG9qd2p0eU1FcXBuU0drMDkvekVqbkNM?=
 =?utf-8?B?dmZPbHJFWkZvc0FmN1N1UmhwaklHclExUXZ0Z2NPazFOSndyb3E5UnhWOWtV?=
 =?utf-8?B?OGQwK29rQjhLR1ZiQjU5R2xqTHdEamVXS0VIVlRBeTUzVzh4ekN0YkdYQ2tQ?=
 =?utf-8?B?T2tGTUJWZlR5VldrQjlPdUVuNWd3R0hCZzBWSUhnWVNTdjVvTDB6bk9MdHlT?=
 =?utf-8?B?OU8rOFEyL2Z5T1JaV0NLaDNST1RvRFBTYWtYZTR1cWtkV2hKYVpmWHQ0Ym44?=
 =?utf-8?B?dW1BUzZwTTJyREJMT2tBbTR6VjdUSGJyWmZxd0FlRkdJY3BBeGhTQnBwbnBT?=
 =?utf-8?B?cFlQUmR4OHFBbUttYTJyNDVGV3lMS3ZoT0VQd01VSWFqOFdtdWFBVzRab0lN?=
 =?utf-8?B?TTFVTjlSV05xaG1RR3FnUEcyVjRSczkzQ1JNMnN6Q0JkeTJUYmtCSzNmOWg3?=
 =?utf-8?B?bWt1alhKbDdQMHF3aGF0cG9KWkNBUXlUVFNidU9zalN2Qk1ENEtTWXo4K0tI?=
 =?utf-8?B?UjlFR3MyT1JWbHZ5Q3JsbWpPYjl1WVlVQWc4dFBnNFIvMzNnSlppTWVtbFMz?=
 =?utf-8?B?ZFp4SjJHeGlVVE1FTm1vNVZ2YXZJbzVPa0g4aE95enJhaGYxM2ROUlY3UTJk?=
 =?utf-8?B?ZlhqQk1ZUXVHcHdlTjlTbmNRVWJvNnZ5QXdxRUpLcG1rUTM5ZExmelV2eTFj?=
 =?utf-8?B?Q3pkUDFsMGJUdFh5UUJZSXpGMFJWVjB1cDYwYXJhbm8rWUFhc3VEcDdCV3RT?=
 =?utf-8?B?QTg5amVmdURNbmNaMFJKdUQ1dHlEeWUyNXUydEN3TjBhUWhJenZCWnhheUlW?=
 =?utf-8?B?TnlmNTd2aXZpeGdQZnJBZTcyZU9wQmJPQkJLbnVEQjkwdjBYMjJIL0s4dFZu?=
 =?utf-8?B?ajFJbnBkdVF5SVZUY2ZURlh1cUdBejhNanArK3RMWkYvT1hXNHVQcjZHdmdR?=
 =?utf-8?B?NjJUOXhIekxOdnZEY1A0azVpZGRSc2VUbGxOQWNHbWF3cXYzVzFyZG5EOEd6?=
 =?utf-8?B?Y01LVkpEMWE3STJBa3BJczRWWXlwa2NGYlVuMXpMUU05aVJ4NFlUa2FHM3hV?=
 =?utf-8?B?K1Z3dVQ4NS9OVll6dHExd2M4dnpNc2pjT0FFN1FyZ2U3ekRtcjhYZm9vYi9r?=
 =?utf-8?B?YW41a09DRmdwN0pDZ0ZQMXdSSkU0S0gzL2JpYVVnc1Y4dEVGMlB2bTl2T09W?=
 =?utf-8?Q?1ikNDSfBYlE+OizUo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnJ3aFNaQmJWdDVybDZGN0lneEtmOU05dWZRTVRoOEtYT0dYU0VmbS8wRS9n?=
 =?utf-8?B?SlhMdHJGT3ZuMk51enFqUnk4VDNPZUN2VHRVYmpVWUpCWXJLNUVDZ0xSUDNB?=
 =?utf-8?B?OUk1OXYxcm5rSWhnazBoZnNHTTdRekJSY3Jua0RudVFTM1R6VjhjWGdVV0k2?=
 =?utf-8?B?VkhUM2lTL29tQ3ZJSVhRVTJad2p2dWpsSXN6eUc4Q1d6RlBFZEllOVNOWHh3?=
 =?utf-8?B?OVpDdUhoV0kvTVovVFhza2VNNEp1bVI1U1puV2duMFR4MEtZVzhMMWc0TnJZ?=
 =?utf-8?B?OU1xUEdvV3dBY0pYVnVPUlMzT0pDY1hCdnpQVmNNbEVXRXJPVmRMbFNmeC9P?=
 =?utf-8?B?QWVvU3U5OCswWW9INjM5WDB4R1dhNmZTL1ZKTW5HSUhZSHZ1VldjRjZZeGVF?=
 =?utf-8?B?ZWtvbnFTRHFLV21DYUxLVTZGdlQ4Q2RLTVM4SDEraDcyQzZ5Y0pRTEpHK0k5?=
 =?utf-8?B?UU5YMTFWclE5RzA5UjNHNU9aNDA0ZWUyWGc3dXVGSFdQOHZzL04zQzErOUNZ?=
 =?utf-8?B?K0RRRTd6cnRSa3hTaGdwbGxvcUw5cTI5NEpqV0NUYjVaUFljbzBqWVpiRmNq?=
 =?utf-8?B?dklmcGJEbGZnL2FCbDVQdVhoWDFrU0hpWXhqVHFsbFRXQlh6NDV6dGFnQThZ?=
 =?utf-8?B?NVpJQ1VSdW8xYmRaZ2gxT1ozMG43b2E5QUo4UnlJY0hOMWxuK05yN0k0eXF4?=
 =?utf-8?B?VnhTUW9QYm93TGIveFFPYktKQU5lQks3UzlySDlPb0RvZUF4NHQ5MU9DVytV?=
 =?utf-8?B?M2Y5ZmZ1cldGUUlWUzRacG5sQ1FnQ2FkYWZDTUlzWUdPc2NKdkRsMnAwK0cr?=
 =?utf-8?B?ZmRDajFBODNwYnhKV3gwL3lubDllTk0wblowZ2ZoWTBLaUhvdjE2MXE0TUp2?=
 =?utf-8?B?cnhyblRpckszSWhQSW9DbW9yNExBaE1ZZGkySWZsRVQ5YlhJbGVaa2RGdW9I?=
 =?utf-8?B?T0RibFRMNlFVbU1NcTRWT1Y2UGliM3JKSXpkV3F5QlBQVG1uWnEwNGdtKytq?=
 =?utf-8?B?V2ZGMWFONHhJSU1aNU0vK1BuRGVSZ2F4ZGN2V2RPZUlKWFp5WHhucG1TWHZi?=
 =?utf-8?B?UFNhYm0xcEpYOVlDbXpwbWZlRkRJZE5DWURHYlJSQk16aXEvUkdGaWl2d2g4?=
 =?utf-8?B?K2xlRnAxSnpha2Z1VmFxRHNoQXVQeXVoOUJMSzJCZUU0M2tCSDY3a29tbXBU?=
 =?utf-8?B?Vk1WQWJISmVBLzBnNGxPeGQ4T2RYRmVDZzRDTzFZYTVndVkwZzUxLzZJcWJi?=
 =?utf-8?B?Y1RxaFd0cGxnT2tpWTBqNlBRWEtOVDAvOVJIb2FOMk00QW4vbXVLaHdDUUd5?=
 =?utf-8?B?N0dlMm5YUUlGaDdyRnhLSHFVT2dxS0ZDRDYwZzdIR2dYZ1FYdE5Ud0VxdWRM?=
 =?utf-8?B?TXRSZzY2bDlZQkRIL0sybk1oTlZBMU1LSmFKVFQ5UkgxcVVYVFRTUUI1d1lx?=
 =?utf-8?B?bVRTU1dsTmRDOGVjNzJEMjRYaytIVU9FdXczZWRmM2J3dTVobmZ3SWs2QnVo?=
 =?utf-8?B?M3drQUxON1ZJcXY5NVZkSXk0YVdJbk42UFpmVDhTNmNsUHA0bS9VaWJmd2dw?=
 =?utf-8?B?VGNXb2wvV2tYek1UMkZ6M0ZvMFpMWkRFaVlzOXYxbXZMOUpLVStLTkpHMUU5?=
 =?utf-8?B?TnNIQmZjYng2NDdaLzUrNFJiMjZvakZGZ0t2MFRqdzdxWWdqS2VFYmNXYzlt?=
 =?utf-8?B?SmF4ZWlDL1BYcDFaMmVjSUNPSERKT3l4VSswM2dVMjNQdzBrRmtiaGpGdFRZ?=
 =?utf-8?B?azBaV1h5SDMvV2ozaFlCUVRQODhObExDdjZGbmNXMWdhUUxOWlk2TE1MOXg3?=
 =?utf-8?B?RmNlNTRObEUxakJiY2E1MGVweUpoZmxFNEpFNWIvdFoxNzZ5TUhyN2dVdjI5?=
 =?utf-8?B?blZiTjBLZlBxSEkwcld6TXlYbi9YNmdBQVFGbjdjY28zbDNBaTFKcU5SeWwz?=
 =?utf-8?B?RDFlRU1lNkxZL3hmcWpoNVdYT3RKR2VobTF3SlNuSXg0RFN0cld6c3JGOU4w?=
 =?utf-8?B?WHpxNDJKbGpqRnlZM2wrUVlDWnVBd2tCT1AzcTRHOFlBR2pUalFMS1VXZDlO?=
 =?utf-8?B?c012VmtEQmtRbDcwMXJTVXFYVU9IMUVBc0lmWC82dEtXd0N2bHFZZWxSdHU3?=
 =?utf-8?Q?TKfA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e59eef-a922-4140-b45f-08dca6849948
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 17:19:21.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeFO6Zy571+0WXQ/66g2h8w9zgE4vkbVt3HuzNFf2fOsz/XO804e8J4Qt4dR3F8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

Hi Reinette,

On 7/12/24 17:03, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> # Linux Implementation
>>
>> Linux resctrl subsystem provides the interface to count maximum of two
>> memory bandwidth events per group, from a combination of available total
>> and local events. Keeping the current interface, users can enable a maximum
>> of 2 ABMC counters per group. User will also have the option to enable only
>> one counter to the group. If the system runs out of assignable ABMC
>> counters, kernel will display an error. Users need to disable an already
>> enabled counter to make space for new assignments.
> 
> The implementation appears to be converging on an interface that can
> be generic enough to be used by other features discussed along the way.
> "Linux implementation" summary can thus add:
> 
>     Create a generic interface aimed to support user space assignment
>     of scarce counters used for monitoring. First usage of interface
>     is by ABMC with option to expand usage to "soft-RMID" and MPAM
>     counters in future.

Sure.

> 
> 
>> # Examples
>>
>> a. Check if ABMC support is available
>>     #mount -t resctrl resctrl /sys/fs/resctrl/
>>
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>     [abmc]
>>     legacy
>>
>>     Linux kernel detected ABMC feature and it is enabled.
> 
> How about renaming "abmc" to "mbm_cntrs"? This will match the num_mbm_cntrs
> info file and be the final step to make this generic so that another
> architecture
> can more easily support assignining hardware counters without needing to call
> the feature AMD's "abmc".

I think we aleady settled this with "mbm_cntr_assignable".

For soft-RMID" it will be mbm_sw_assignable.


> 
> Expanding on this it may be possible to add a new "sw_mbm_cntrs" feature that
> will be the "soft-RMID" feature while also reflecting the "mbm_cntrs" name
> so that when user space enables that feature its properties can be found in
> "num_mbm_cntrs".
> 
> The "abmc" kernel parameter remains but that does seem separate from this
> resctrl fs feature since it is explicitly tied to X86_FEATURE_ABMC surely
> making it architecture specific.
> 
>>
>> b. Check how many ABMC counters are available.
>>
>>     #cat /sys/fs/resctrl/info/L3_MON/num_cntrs
>>     32
> 
> This is now num_mbm_cntrs

Sure.

> 
>>
>> c. Create few resctrl groups.
>>
>>     # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>>     # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>>     # mkdir
>> /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>>
>>
>> d. This series adds a new interface file
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>     to list and modify the group's monitoring states. File provides
>> single place
>>     to list monitoring states of all the resctrl groups. It makes it
>> easier for
>>     user space to learn about the counters are used without needing to
>> traverse
>>     all the groups thus reducing the number of filesystem calls.
>>
>>     The list follows the following format:
>>
>>     "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>>     Format for specific type of groups:
>>
>>     * Default CTRL_MON group:
>>      "//<domain_id>=<flags>"
>>
>>         * Non-default CTRL_MON group:
>>                 "<CTRL_MON group>//<domain_id>=<flags>"
>>
>>         * Child MON group of default CTRL_MON group:
>>                 "/<MON group>/<domain_id>=<flags>"
>>
>>         * Child MON group of non-default CTRL_MON group:
>>                 "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>>         Flags can be one of the following:
>>
>>          t  MBM total event is enabled.
>>          l  MBM local event is enabled.
>>          tl Both total and local MBM events are enabled.
>>          _  None of the MBM events are enabled
> 
> The language needs to be changed here (and in the many copied places) to
> be specific about what setting the flag accomplishes. For example, in
> "legacy" mode user space can be expected to find all events enabled, no?
> Needing a new feature to set a flag to accomplish something that is
> possible in legacy mode can thus cause confusion.

Yes. It is possible to do it. But I feel unnessassary.

> 
> If I understand the implementation reading "mbm_control" will fail
> if system is ABMC capable but it is disabled. Why can "mbm_control" not
> always be displayed to user space? For example, what if "mbm_control" is
> always available to user space and it can provide specific information to
> user space. For example:
>     t  MBM total event is enabled but may not always be counted.
>     T  MBM total event is enabled and being counted.
> 
> On AMD systems resource groups will have "t" associated with monitor
> groups when ABMC disabled, "T" when ABMC enabled and a counter assigned.
> On Intel systems monitor groups will always have "T".

I think more flags will add more confusion.

> 
> For "soft-RMID" the flag could possible continue to be "T"?
> 
> I am trying to find ways to communicate to user space consistently
> and clearly and any insights will be appreciated. We really do not want
> to add this interface and then find that it just causes confusion.
> 
> It is not quite obvious to me when the new files should be visible and
> what they should present to the user. "mbm_mode" is now always visible.
> Should "num_mbm_cntrs" not also always be visible? Right now "num_mbm_cntrs"
> appears to be only associated to ABMC, should it not also, for example,
> be the file that "soft-RMID" may use to share how many counters are
> available? Its contents will thus be dynamic based on which "MBM mode" is
> active, begging the question, what should it contain when "legacy" mode is
> enabled, should "num_mbm_cntrs" perhaps show "0" to user space when
> "legacy" mode is active?

Its good we have this discussion.

How about we go with simple way for now. The mbm_mode will only available
when ABMC or Soft_RMID(MPAM feature) is supported. Same way for the
num_mbm_cntrs.


> 
>>
>>     Examples:
>>
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>     
>>     There are four groups and all the groups have local and total
>>     event enabled on domain 0 and 1.
> 
> "local and total event" is vague, can it be made specific with, for example,
> "local and total MBM events"

Sure.

> 
>>
>>     =tl means both total and local events are enabled.
> 
> Same here (and all copied places in this series)

Sure.

> 
>>
>>     "//" - This is a default CTRL_MON group
>>
>>     "non_default_ctrl_mon_grp//" - This is non-default CTRL_MON group
>>
>>     "/child_default_mon_grp/"  - This is Child MON group of the defult
>> group
> 
> Same typos as in previous version of cover letter.

Oh. no. Will fix it.

> 
>>
>>     "non_default_ctrl_mon_grp/child_non_default_mon_grp/" - This is child
>>     MON group of the non-default group
>>
>> e. Update the group assignment states using the interface file
>> /sys/fs/resctrl/info/L3_MON/mbm_control.
>>
>>     The write format is similar to the above list format with addition of
>>     op-code for the assignment operation.
>>     
>>     * Default CTRL_MON group:
>>             "//<domain_id><op-code><flags>"
>>     
>>     * Non-default CTRL_MON group:
>>             "<CTRL_MON group>//<domain_id><op-code><flags>"
>>     
>>     * Child MON group of default CTRL_MON group:
>>             "/<MON group>/<domain_id><op-code><flags>"
>>     
>>     * Child MON group of non-default CTRL_MON group:
>>             "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
>>     
>>     Op-code can be one of the following:
>>     
>>     = Update the assignment to match the flag.
>>     + Assign a new state.
>>     - Unassign a new state.
> 
> Please be consistent with terminology. Above switches between "flag"
> and "state" while it then continues below using "event". Also,
> "Unassign a _new_ state" is unexpected, it should probably be an
> _existing_ (not "new") state/flag/event?

I will use event consistantly.

> 
>>
>>     Flags can be one of the following:
>>
>>          t  MBM total event.
>>          l  MBM local event.
>>          tl Both total and local MBM events.
>>          _  None of the MBM events. Only works with '=' op-code.
>>     
>>     Initial group status:
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>
>>     To update the default group to enable only total event on domain 0:
>>     # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=t;1=tl;
>>     /child_default_mon_grp/0=tl;1=tl;
>>
>>     To update the MON group child_default_mon_grp to remove total event
>> on domain 1:
>>     # echo "/child_default_mon_grp/1-t" >
>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     $ cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>     //0=t;1=tl;
>>     /child_default_mon_grp/0=tl;1=l;
>>
>>     To update the MON group
>> non_default_ctrl_mon_grp/child_non_default_mon_grp to
>>     remove both local and total events on domain 1:
>>     # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>>            /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>>     //0=t;1=tl;
>>     /child_default_mon_grp/0=tl;1=l;
>>
>>     To update the default group to add a local event domain 0.
>>     # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>>     Assignment status after the update:
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>     non_default_ctrl_mon_grp//0=tl;1=tl;
>>     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>>     //0=tl;1=tl;
>>     /child_default_mon_grp/0=tl;1=l;
>>
>>
>> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>>     There is no change in reading the events with ABMC. If the event is
>> unassigned
>>     when reading, then the read will come back as "Unassigned".
>>     
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     779247936
>>     # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>     765207488
>>     
>> g. Users will have the option to go back to legacy mbm_mode if required.
>>     This can be done using the following command. Note that switching the
>>     mbm_mode will reset all the mbm counters of all resctrl groups.
> 
> mbm -> MBM (throughout)

Sure.

> 
>>
>>     # echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>     abmc
>>     [legacy]
>>
>> h. Check the bandwidth configuration for the group. Note that bandwidth
>>     configuration has a domain scope. Total event defaults to 0x7F (to
>>     count all the events) and local event defaults to 0x15 (to count all
>>     the local numa events). The event bitmap decoding is available at
>>     https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>>     in section "mbm_total_bytes_config", "mbm_local_bytes_config":
>>     
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x7f;1=0x7f
>>     
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>>     0=0x15;1=0x15
>>     
>> j. Change the bandwidth source for domain 0 for the total event to count
>> only reads.
>>     Note that this change effects total events on the domain 0.
>>     
>>     #echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     #cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>     0=0x33;1=0x7F
>>     
>> k. Now read the total event again. The first read will come back with
>> "Unavailable"
>>     status. The subsequent read of mbm_total_bytes will display only the
>> read events.
>>     
>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     Unavailable
>>     #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>     314101
>>     
>> l. Unmount the resctrl
>>     
>>     #umount /sys/fs/resctrl/
>>
> 
> Reinette
> 

-- 
Thanks
Babu Moger

