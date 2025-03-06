Return-Path: <linux-kernel+bounces-550005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE1A559CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B970D177B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843E27C173;
	Thu,  6 Mar 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HN52qbYt"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291BC1FCFFE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300317; cv=fail; b=I7AL7dt1K0NplDYWKmdxYW8qj4wUGyBDo1jVSUz60EvMa3VZHpJBfKwFXICt7rQTybplyblaHFLQjpULlxbQenwpYhJGFacBUwR++VHNzIx652thV6K+mCUu2h99iFO6JDteIl95sfpJS/IAvT/xqIRyRazwmnxKm9xkBIy5v+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300317; c=relaxed/simple;
	bh=p1R/oC0sjoSoEcbc8OOlYzVCrm0pT6/f2srrLRgXTtA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S0seUaF1qOcWWuq0/HTJiLAETpUhUK4PyGumXswfH5l/IVzyDZATsSqQgJMFAOxDyCoUJ1YTfJ/LMb50Wp3GgxLVDF7vOt8Rm96ynm0dSIFWTFOtI8E5E7rax9ZMRTQAnHP/Tw8oXYeplpE1SnaeMnPiNGzSa6/sz1VCqlGFmIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HN52qbYt; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaOqrTX4BkC6aEiFkKtrNvzJYhs+3qeh+11x9D/b0Ug3QJvQYYXRdoInimA6mb4miAPQrcA9cTJJn5SpWQP9tshZBegWEP70uPd1zNAbFghx+cNQ1zjPSbQOgKrn/rYoy5UvLiRMWdZ8okrxMw7l3jFZjex4YDgEJ1u7mfnmrXG9/XRE01XyuC4hqCGa57VscSFg589U7OhzUg6Sc82Kwlqi9VKO8Tyol/wbMEGooAMTjY1xs6+PA3bW+d8L7vNAGU3Mi1QfilB4cxKcna9TWKfbq33mLby28hnNnMM0tz1bj4T90aIfAL5E1w9jssX7ozUSGJ/71halqKDAWfRFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1R/oC0sjoSoEcbc8OOlYzVCrm0pT6/f2srrLRgXTtA=;
 b=Vc/UVJaTi1S5s9/UueoBkcgwnfvCe+7Kg+GXx8+AaqlqQv12/ZBJ24UBL0wswZZNxOkhpx9Jakyajmk7qMfDFY5tYAOsqy8DRVY6HYj3OeEn4S4dpyR74C5Pcm84pqNnR0hiHFtleBTcShmtTDFt06wmNQDfp/8aTPHwl95JnrXdrggMaXEEcJRHjbSM8RRKGLnTwMm2b5doqHHUf7xj7fwi+RPb7na/42+PrvsJcWchHNTxu2NZLnuduVR8BgrZ7BmcJFQvgm893OvxgAnLW9Uis7asKLNA3APqQBS9/qnGt/XmKvG5mC8tEhrViJQOMxuKNu8Ktv661Fs775nvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1R/oC0sjoSoEcbc8OOlYzVCrm0pT6/f2srrLRgXTtA=;
 b=HN52qbYtxh4n3Ao0FGzv8XelbQ8v6M9fd6EWnVJ580qdFMmNe4oZETa8u3gjnYqzNNuq9vVq9CUvkfYfl9S9LPj3vCHrS+MkLE8aXTm76kmGZZ7xxxejSe/JIhiTelFsB/zoGZ14TSXpiG5gYUVNFP8xD+kShLv7QaZmNXMkeZJLHxm07RhWCgAjoYZb+b4H4IC98TjHwWMvOzKUJnDyK8HyazEV0JaRxLp/o9qtSP0P0tev7rYpKydlczzcgK82ba8dVPvqKPnyJJ9tlNGJCC1Of+fCPdTWW+WWBhr4A6uNC0rCnxMAhXTVxnj37MhA0ks47inLv4AIOzjs+fE37A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.16; Thu, 6 Mar 2025 22:31:53 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:31:53 +0000
Message-ID: <a9f3d684-e44e-40d3-977a-d9d12c8877d8@nvidia.com>
Date: Thu, 6 Mar 2025 14:31:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 36/49] x86/resctrl: Add end-marker to the
 resctrl_event_id enum
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-37-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-37-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b49f9fb-98df-4351-14d0-08dd5cfeb1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1V6ajFhVHN2M2ovUTdkZGh6T0ozenFsbEVKRmdoS1pveXljNm5KK1lPdi80?=
 =?utf-8?B?NlNtZEJtcjdSR1Y1K0tNbWR4UXhZRFZUWW1hSHpuUmRCV0VhMG5kTFBJc3RE?=
 =?utf-8?B?ZExhbVRaSDJ4ZVJCQlY3d3dpcFgzdFRrYUJESlpTcWM1SnYzaGRHamtNNTBq?=
 =?utf-8?B?enRKWGlnS3Axb0habThmSmg4YU0rOE5QaXZxUXdJR1oyQzlROG1scWJhZzU5?=
 =?utf-8?B?MTBKdUZiSFE3Z0NoVXcrY3FtWjJnVDJyZjNLR0o3M2kvSzMyWEVaelJkWFo5?=
 =?utf-8?B?VE1CQVUyYThHdGZ6TUhxaWR0V2RBWGVHbHhIV0JzdjNGRlN6cXQ1ZkwyZDho?=
 =?utf-8?B?YkRuR1R3Vmx1UHBVTVI0RTdUdWN5cnoxSzZaeGZyVTlsWWNyY3ozZ0cxdTVQ?=
 =?utf-8?B?SjVaZm13SjRKYTZWeW5lbmFpMVhUMjdtZzA1RUhaNG5SeEdLTVpSUXJFZTc2?=
 =?utf-8?B?TCtnWGpWcWplbXFCZUxwYnlqbEVGMjhLaHl6cmJJQ1ZBUml2T29UZWl4Tlo5?=
 =?utf-8?B?aUlJZWdpcEY2WlhtbG15eXdLcjRkdE5qelpFeEZTODRtcVdTZEdiS3dJSXZO?=
 =?utf-8?B?Qm5KUmVSSDRQNXJHUmMxTzZDbG1aK0VmOFNwVnQzeFVCQlAzaFVlZUxXRWVH?=
 =?utf-8?B?V0hIZDNiQlBxcTE3TDdWRXlIa0t1MEIxODlCeFhLd1Y5YkFOL2UwNnR6T0tF?=
 =?utf-8?B?c1BaMGcrUmQzS0d5c3lBSEJwNnVnQXhML1g0TDRCcWRVcjNPc29YSmFPaitn?=
 =?utf-8?B?UTc2bjJkSXpZUXE3ZnlTN0JQZm1FTmVIMittSVRHNEQyaDAxTS9mSUE3cmZV?=
 =?utf-8?B?MnBuR09PTy9NdDNXU01kVWNTZGJLL2xCRlpzaGZKZFZ2ajg3T00wdDl4Z1Uy?=
 =?utf-8?B?eU16aWZhWkw5anEza0E3SjZsekZOdU1RV0RLVEhLa1cvdkpsVEJUSU1CQ1do?=
 =?utf-8?B?SmVMNm83a0h4aDRuMnVPUkwxdEhDcFVxemNoRmlRQm90eE82QVVlQnFSV3M1?=
 =?utf-8?B?SXlqZk5EU1p6S2cvWCtnRFZkU0JHbDhyeE9QTEN6djEvejQ1UWdWTWl0S1lN?=
 =?utf-8?B?MEFQQ0djVENVMk1VV2lHSWJDQ1ZUb25JaWg0VHJIOXppUG80TkFUcjUvWFgz?=
 =?utf-8?B?eExVMHNjT09uVVpyUUNtak8wWkxIOURnbkpTK2JEbFNEbUFvcFpVcGxtMTBh?=
 =?utf-8?B?MjBhS3Z0Y252ZDJYYmRKQ1ZzanViaWNQd2swVXhJeXp1RG9SSWF6ZG1yMjhS?=
 =?utf-8?B?R3N6Z1ZvUm5RVGpHdS9hOTBmMEpIdk9rTFk5em5pK3pJR3JpNTNNUEtRdjRT?=
 =?utf-8?B?alB6cDliZW9tb0xrZXM2NmVVU3h3clFRdVloMDkybzI3YVZ1YjdISjF6cjdU?=
 =?utf-8?B?ZnJXU1pRSjhDMjRZeVdCaGFKS2RYWHMwTDU1V0JKdEVhcFJFTmpTcHJwc0hV?=
 =?utf-8?B?eGtWbHJKVUVmcTBxVHk0MDhUY3IwWDJmUkdjRFZSMWlPTzd5UXdMcGVBNHRC?=
 =?utf-8?B?SUEydjN0RkZYajZ0ZVNheGRRcFl5VVRMOUliRjlqVWMvQWN5MVU3bzdITE80?=
 =?utf-8?B?V0crTU03d3JZdXVHQ2NrcnY3aXA3NGtPSWVJampKOEpsNG1ZY21TQWw2cTho?=
 =?utf-8?B?V1RVTnlCR1dVdjYwVTZhbVB2YlZNZEpVeVdTWDc2MnBvOUo1d3B0Q1YvaFdE?=
 =?utf-8?B?VUpGNUF2Yk5lVHFCWVE5OWZhOUg2MW5wUEJCem1PYXRzQmVFeWR1RkdTMlVN?=
 =?utf-8?B?UTczR0FoM21iVUZkRjBnL1F5TUYzQTdBdWZ1cVlZK2FwMWtxQmFlSWN1MURK?=
 =?utf-8?B?ZUFpdk4yalh5S2NmOFZxTnJiTTlLcFNCOFFIbnFxN0tneXpTVGpVVnlSSFEx?=
 =?utf-8?Q?L1RnkvNHv8jdk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzY4NXR5dHJJWS9Rdnd2MVNXVUF0TG1STmhoREwzaHJXTkEwcEdqWTVYNzRi?=
 =?utf-8?B?a0s2RmRBZ0t1NDVBK0VjYTE4M2FHQ0FQT1lURlBlL25ieGhPMjZNRWs2c1Z0?=
 =?utf-8?B?ODZIZXByMzVVdUtVNktqWFpKL1BhK2ZHRVFzM2R5S3JuMlVydXdNUkUxWVUv?=
 =?utf-8?B?MFM4eDVSOFVZQ3F5VnNGVXduN3pXT214Z1RteTlPbmhDMUc2Q1Rkd1pLTTRX?=
 =?utf-8?B?MVZldWRBZWVCVVFvenFiMkNmNXhkczMxdnBWSlVaNWIrTmlvQVMvazR0OGpJ?=
 =?utf-8?B?Sk5SWmwzeFVINVlFR2RtWmF5NjhtS1UrVGx3NnRBMWRXVmtDL2prWHBtZDds?=
 =?utf-8?B?MXpXaldFbzJDOUlQY3ZvbkIwM0R1K1F3R0RMYWVyQTFHcnQzdkRuM2NJSy8r?=
 =?utf-8?B?MEZBOUh4bGVoUUZKeCtYZmVwcVhVblZEY2ZaNVl1QjZoeXZXVFhWRjRoMDRj?=
 =?utf-8?B?L21OLzZaam9oMGVIaFZaVDhSRUpybWljUzNYbTNQZ3h5YU4ra2hiVXNKRitI?=
 =?utf-8?B?WEJCVW5WSjhrajFlaFlKc01hTjRZQzZMcmRJNXE0bzZKZzRXbTJCcmw5TDBE?=
 =?utf-8?B?T21KYXI4VUh6QzVNVW9GQ2Ftb0tUSnExU21vckJUL0VKK2NFRW93QzFDeE4x?=
 =?utf-8?B?ai9aWHEreHBKYUZPbWlOMjRpa2Z5a2RaT1RmK1N2VUFtem5KQ2JZc0NnZUxs?=
 =?utf-8?B?Q0lIV05SdlM3a1MvbGUvRlRSWkVicFlRVWhWTjFJOElWakdrSkkzUlQ4OGhJ?=
 =?utf-8?B?V1E2c005K0pqNDhLUmlPZDdmZzM2MWt5ZkJXNTdRK0JOK3REbEhBTmx4TjFw?=
 =?utf-8?B?YXZTM3RLb3dmUElyamlSU3E0dEJRcW0rVXFCTVlSWTIvblZIT0NWZmR2clo5?=
 =?utf-8?B?U0NwQlhjSVJjMURWVFdJeWF4dS8rNmlTeU5VWGRWK215cGtiQUZaYTgxdWln?=
 =?utf-8?B?b2dZQ2pNckd4TUZadEF0ckpSZm9CWk5kSkQxYVBJdFg1SzlhMnh4VnhxUHRl?=
 =?utf-8?B?NFBxY3ZkSnhoZTZVY3JDd2l4aTZrSUtLSGIwVzRoM2VCN0ZRNks4QklDTldv?=
 =?utf-8?B?dWZSUEtrZ0dIWXozbkhMNFhYQXdXS3pybzBLcjZyYytyTi8yNWtoZ0p3dFFv?=
 =?utf-8?B?c2NJM2hHVDE1TXVCTXJaVEwwaDhSR2JnNXlsWmJNYTF1UlVIeU56WUsvMWlh?=
 =?utf-8?B?WkM0em1DYzhKK2JHZnBDWFU3TTBVOUpyVGhhSmRxb0Qyd0ZnZ0RNMWFZQVlE?=
 =?utf-8?B?NEYvTEFFUDZKMG5WKzllNGdNWWFHQjdqWFlUVk9leGJtaE1MOTlMRkx3dGZY?=
 =?utf-8?B?aXg0aUt3UE8yVWNFMXhKZnI3RHhucEFQYThXOFFYemhCRFZJOVpKWnE4MlUz?=
 =?utf-8?B?R09hcXhWcVI3My9WRWsrSzVsU0xVc0gwMVliTGpZMFNkSkxiWUViWUphc0Q3?=
 =?utf-8?B?Y1FxZmtHd2JaR3I5ek5yVFdqTzlIVnh6by9jMERSL3RqaWxGazhqQ0xuODIz?=
 =?utf-8?B?UUI3Tmswby9pM2wwUTJvdmMxNGFmUUpWMFVPMzdMWGdoT1R1eDhoNlhuOU5M?=
 =?utf-8?B?cUVqc1BDU0JMYmZrcExvbFlSdVRFZGVTT3hYbkpNWXZGY21zbVIxbFlVRkhD?=
 =?utf-8?B?RHU1WU9ITEw3K25DcXRUcm45STBqWUxFdmJPd0tzZTgyaFNaZDZIQjBOcm5F?=
 =?utf-8?B?b2JWd1RxeVJZNW1rMWNzYjluS2JWRmFFTldjZGxFVklWdmlwQUZtN2w4OC9j?=
 =?utf-8?B?aHZvTXNyWnE2aU94c3I0T0IyVmRzY3VzZ3FSZm5qRUtLcS9zTk0vekM5L0l5?=
 =?utf-8?B?QWR1SmJ5RkVabmw4dkpXa1BVblpzME9FNlBpY21jd0hCbjAzZ2YvNkdQMGFZ?=
 =?utf-8?B?bGtUZHEzR0tnUW9DbTRMOXdPS0RqYlM1c21Cb0ZXVmhnK080RnhhMXNZRUpF?=
 =?utf-8?B?NUlwUU5kOWZ2ZURRT21XTERTbWdIVGpDeFNqbkJJUHJyKzFYNEVEVlJFR01D?=
 =?utf-8?B?Ui8ybDhIWC81emRUM1RjcW9Xd2psQ0FOWS85MmxMVEltMlMxTTc1ZzhoQjR6?=
 =?utf-8?B?QWFCazRPeTNodXJFNkVRT2RheHJZRjdZQWwwbUExSTZIR0NQSW0zN0NZTGlK?=
 =?utf-8?Q?tyJXIXyYuHtw4cTia6Cc4A5kC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b49f9fb-98df-4351-14d0-08dd5cfeb1e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:31:53.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14xewU1e/zmIAZlVlltStfjt022SabByAgFfHPsZRClrnmdZ5FcGJj19SRZ8R9G4dcFk6CoaSxvGlOJNnChbEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838


On 2/28/25 11:59, James Morse wrote:
> The resctrl_event_id enum gives names to the counter event numbers on x86.
> These are used directly by resctrl.
>
> To allow the MPAM driver to keep an array of these the size of the enum
> needs to be known.
>
> Add a 'num_events' define which can be used to size an array. This isn't
> a member of the enum to avoid updating switch statements that would
> otherwise be missing a case.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua

