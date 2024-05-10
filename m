Return-Path: <linux-kernel+bounces-175185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D458C1BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5B0B20E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE782572;
	Fri, 10 May 2024 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NLa5ABvf"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC8CA4E;
	Fri, 10 May 2024 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715302644; cv=fail; b=eHcsKbOwU34axmXjOdzSJWsbsYlNCBP6X8PIo8GMOne2YAPDUmLkWA7Qz5GVWSzOmNusZns5MTC+qCa0gXMC+2OkVbLXdBz9odSd7iczbTPxISLT+bSAiQSeP+Jqol6gtp0GwMrND+OCYYywdpjaaSMugmS3OR88vwm59rBwh64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715302644; c=relaxed/simple;
	bh=YMQctb6mCqNiwVSpxKpCvsOzvCNltWnLDce5PEVjDW4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fU2+wbZ9qZILNM8c98ZF/OmJUZ8Ym2gDAYRZvkYyt6TPlm3zWCapelAjBgBZOXdqIbeYOeMd3QS7ftUDY3dyIAamCGXr1Hb0wcYPVxd++HSzdTiFjRurVETxmOu6uhEHTZA202iPbLyMdl4DCEtvvwd7h9V4MVF+ZwDOr7LYxoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NLa5ABvf; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpUTNBIy7YVNyieDPBC5aFAikjnFDmi5FyqdYL9mknTvRI81Jq4QkskMbcseKIIue1O/sBrHTJfAa8gj/cttmqzoI+VeDX0Oil1IW1g8FYE8A9bFP19OuN8GacxoR2YmdOF4DFnQXake5GUe8NXe6IqkRYAvJiTjN58h68eRRna1CNhHswogKq7SyO9Psi+9K9kVy28MCGhwdXbIv2QJg7YJZmXKIQeZqDI7Ro+pqgG4nVD6KM4x2v6SWsbEmyNv5Nk9MLIWKM/K1f6HEUqKhmyBp7H1R2YB7pCxY7ukU3v6x0S8rSe2aR9AZUa3R6HjALIle8BX0BzdMl/lYDA+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxxHAcjKsfiM4aH8VPjR2k5AW3ROt6gqeSlr2Eiy+q8=;
 b=TUSaHkZuJkU4BHvTboGg88Uvh9fjOuMQgBX2GicNJJuU6KzI8L5jjHbjHZ0C3Sj1yl3JeYYb7t+x4LxJ8cYE2hQzZnwvf61h4zxHuh6gHQEv+UwiPIzqJ8GdUE2hkDrjphmLO4PYkRUZGiAm0ccaTDut6gXXzmaNImozdlqEDMak2xIMKPY/VzuA/q1awAk4YWXuxyVz/1F/oY73TgJM4cio7c329Mkkrni2Vus8HPL1EGkvm52dH2nYgXM3X9hkUrFFC1QbeWL85/+8DDIpwCABCN3hMbaDgMAanmV4Z6vT+9uNMwfFd/3skPmXVsYYbFneGqfMWN+5YxrbGgvPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxxHAcjKsfiM4aH8VPjR2k5AW3ROt6gqeSlr2Eiy+q8=;
 b=NLa5ABvf3VmLi6HqoZfMPTgQTGDby5FVI6Ro1nF3DesAY8l2HC4HeKIca3JMykehId0zWDKCyXnK0IXgJQsYaKXqC/17+KoHjrpAbcVR1qXcjPK0MYTGuNK08TG5RkCcxYU7VoAvJEnvPX8Y7vqgnJWYu46qBpxXxiabo1PBuNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 00:57:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 00:57:18 +0000
Message-ID: <380a91e1-248a-7d35-4da2-2bad2ddc6005@amd.com>
Date: Thu, 9 May 2024 19:57:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: babu.moger@amd.com, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
 <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
 <6edffe1b-e9a9-4995-8172-353efc189666@amd.com>
 <ab2a6a4b-3740-47c6-9443-e6bb7a0c1adb@intel.com>
 <CALPaoCiYFKeASPMDwzzaHLw4JiMtBB6DTyVPgt0Voe3c3Tav_A@mail.gmail.com>
 <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
In-Reply-To: <b725e4ca-8602-eb26-9d47-914526621f52@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 398c74a7-1b79-43f5-2233-08dc708c23da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWdCSUpBZ1lJUEdwU3NqaEVYN2huRTZFZ0lXS01sVDZqTllkRlc3TDJHbC91?=
 =?utf-8?B?Z1ppYzlUUGJxNTdaMkhBVmhRQ1F4c1k3SFVsaTlBUm9GSTJyR1FLcGFUWmFG?=
 =?utf-8?B?eWhmVzh3N1JFTkFLNHc5RXZOYlc2RFVBclgzT1k4TlcxOWJ3YmlreTZqaHF2?=
 =?utf-8?B?bHBRNXBjZnZyUmRjc0UvM0VrU28zUVJGclc4ZGorQmxsQklCb1hxQjhRY1ZB?=
 =?utf-8?B?NUxDZmVEekoyTzZCWGNOWWxtRXJsUkl5MTRpVFQ4RUlSTE91VEI3cnhodkZo?=
 =?utf-8?B?K28vanlqTXJMRUpuUXQwaG1mOURBWkJEU21vdUZOb1QzYkdPZFFnOS9QY3Fj?=
 =?utf-8?B?UnV1ek1lWHN5QXpiM1BMemxlVVY4ODA1Qm9WSGx6S0FlN001WkpnVzlhemRV?=
 =?utf-8?B?RUpkajNjM3ZaMFQxVVRtT2RmZU5OamhWdVJBMXJEcmtvd1ZJQXg1Wmw2STZM?=
 =?utf-8?B?OSs4eGJxcFhEcSswTW1WMGJ5c1hPV24vak5PL0gwV20xeEttVDBjaGZqbEhj?=
 =?utf-8?B?OTh5QTBlNjhVR29semN2ZERBS3kxVzR2OC93UlBneDVSNkNuN2VpVTNJTCtX?=
 =?utf-8?B?cExPYktVRVJCV1hUKzJBamVUMGNXRmUxQlVUSHY0UTAzckRmSzFJNG5kYmhs?=
 =?utf-8?B?TC9XdTdpeTIxVjVZRDZkQmFIbG9PdXJJaVFoek54NUU3QzZKLzFmSWRSME54?=
 =?utf-8?B?NlZKOEw3SFdmaVRUbHpGWlhpWVE4WG8zM1JHS2VPakYvNktTMm8wUnFxOWhz?=
 =?utf-8?B?bVlJMnhucnFGa2ZXdmtnQmZVd1U2b1VxbVNnRWpCL3d3ZHFyTk5nUGpLaDhI?=
 =?utf-8?B?RXN1OHQ5ZFZ3MUJwbHZtelBYRXBCL1Q3WUVBRTNkcThhak5NNEsxWVZkRU0x?=
 =?utf-8?B?c3Q4dFptNUg2aWhGdEVwbGM0d1o5VTBZVHZ4VU1zZzNqbUFMckJNVFc2akpP?=
 =?utf-8?B?U0V1L3N6eHhNVnhLeGxrRUVOOWwvRjZjTnZsSStBdlJ5Zzc3cng5S3FmS1hW?=
 =?utf-8?B?d0FtUUFPVjY1QU5DZm1xdXEwZk9hL050ZlRYK3FDbVYva0J6enIvaUJkR3h4?=
 =?utf-8?B?SjVPWGlUaExDT2ZGcFNpQmk4aksveE1ndDAwWGNoT3c5ZGRsVDhxeWI3dktp?=
 =?utf-8?B?UC9ZN0I1STRKYzEzT3VUQ1crekVWU0VKWU5oREs1ODV4ditiOW93eXF0TWlQ?=
 =?utf-8?B?MlY1V05mcWJZTURlSmNnNG1PakU2MzIra0tyRkVJVmNzNmRQR2JFaEVuRVVt?=
 =?utf-8?B?WG1uNFNCN0hjQlk4cVF6RG1nYmp2TkIwTHZsSkI0Vk5IK1FFYUtPYldMVmN0?=
 =?utf-8?B?ZXB1TGtQMHNJa2pEUXBCV20vc2pXNEk2a0Nrb0RRLzFDSXZRaHo1Wm1jaUFR?=
 =?utf-8?B?Q0lGaFpERFYzbkpxdkQvR24xRFZWclpraUV6cG4xcC9reW1iT3NZb2NEUjdD?=
 =?utf-8?B?UFFHVjdGYVNLaTJ1TUtzZ1g3OTFEY0RlRUw4UTdxeVRYdktFeC9qN3ZLUjg3?=
 =?utf-8?B?K2U4MmwxbDNLQ1VJNlNwMVpUaCtSRjE5aWdvNXBwcmZZWWMxeG9oK25EZ2Vm?=
 =?utf-8?B?VStEYXpPV0xHY21wVnNKd21XYUFtQjVkU1h1TUlYczFWWDhyMGxReXF2d1dC?=
 =?utf-8?Q?45qnEigR84h5D0G9uHfKyO4qBQMu7r9yMi6I9jS6Kp1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJBZTlmOVZHdDNEUldLT242bG1ybXNMQm9PVW96TzdNVFR5aEowZldYdEV6?=
 =?utf-8?B?dHB5VzZnc3FPUzRSN05IVE5wSnFkQm0yY1d1dHhCdmxHazJDWUREV2FXUDRq?=
 =?utf-8?B?Z3NLRUdWelJFZHQ3aFNhb3ZDTHgvUTFiNE8rLzdQVjlzVWdCb0pQbVRaeGow?=
 =?utf-8?B?dFREUnpuM1pwQlFGcU5wNFhyakh1RFV4VFAyeXdmSWtYdTJKUllaOFdHZlJG?=
 =?utf-8?B?cG5ONHQvZUpLQURmcHdya1VDVm1iWXZOVnQ2Z2hQRTZiTDNhQTk4czBXOEpK?=
 =?utf-8?B?YjYzbW9zcTliMnozbmxEaytabFpEZFZOQUN5a1A1TXZXK3ViZHg2SCtpSUlS?=
 =?utf-8?B?RWV0eFRhcW9YenhTejZieHF6TVFURWl0SjJpOERUVzdVcWcycUpIQTErREJN?=
 =?utf-8?B?ZUtlL29mS0dyeHRvYmpNZ0cyMlFTRFg2WisxMmVPa1FmR1JDVStTTUZWWHRL?=
 =?utf-8?B?NC9aaW03VTg5Z0Q2ZFU2ZjdSRjBJWkRMcFl6c3ZIS3NzbDRxY1ZsdFJNNHJh?=
 =?utf-8?B?MTFUdm9qREFQcEx3Vk9RTGtLMWJ1c0h4TnJoUHczWkNGRmhlWEE0THowSjVO?=
 =?utf-8?B?NU5hNC9JNElGNDc0ZndBZ1kvT0lpSWxXSGE5TFRBWVNQdjdyNjdQUmhETW5L?=
 =?utf-8?B?SVZYejJiNXVRWHo1bHl4dWdtZUZYVEpuSXNpejdXTDgrME5RN2pZSUhSd2M5?=
 =?utf-8?B?cnA1WVhrbU1LdzJPbUVURC9EVng2RlJ1QzBhV3dqczlBdEpSNG9PbWVwUUJr?=
 =?utf-8?B?OVY1RldUYXVROGtZTnNnbjdMTm9iYVFTbjc2eDRMV2xoc1ZpazZrL3ZhSW5a?=
 =?utf-8?B?OE1ad1lQckFkN0FnNUJVK3VIVHBFRU5BV2VubFk3OFRtSE5UVm5sZmR2cDJB?=
 =?utf-8?B?VmdEVGc2TVRPbk0yTldNUXRheW5iNjhKdlM5bjRNY2cxRm5jTjBKa0s3K1hE?=
 =?utf-8?B?ZS9ad3VFb25tdXVrMTZNNmlzUFFUb2JaaUR4WCtGV2NMTy9ic2dIdWVhZGJC?=
 =?utf-8?B?TEd5dTVXTnZiSEhpaEdiNWlxRFJNaXVyR3lHUWRSWEc0eHFQbEhwNVlTdjln?=
 =?utf-8?B?Wm9Za2R1ZGVBeVpIb0lpR1h0K25FNG9vZExEcmxQRjNsTnp2MlJJZlRoWmNy?=
 =?utf-8?B?REp5ZmdMNEJBb2RXc2JLbXB6L2dZbVVnT1R3eGNkN0ptdWdSUzdIeE81TXRr?=
 =?utf-8?B?UlYrZFZUMlBETkJIZGMvOFJIQjFJOGtuSEZQbE1ybGJHd1dmTkZ3MFdDQU5Q?=
 =?utf-8?B?N0Y0cjB0MldnQnlUR2h3WFYzWnc5NTgwL1pBcUxWVUcxN1d3WTA4ak8ySnFO?=
 =?utf-8?B?VHR4eGFIVkpSQnM3anQ2L0hORWI3ZTk2N2tMM29VaXR5SnVhMVcxK1FnTGl0?=
 =?utf-8?B?UDR6L1Z0c0JMeW9wcFhPbXdMRTBYTWxMQkRzZFRkNUpBQ3AzcDE3WFJweVc1?=
 =?utf-8?B?ZkU5eVpnV2hOM3gyaUlhZkF2Z29GRmY4eDZYdXFzWW1wK25ob0x5SWo1d0hW?=
 =?utf-8?B?R1I0R0h0QWtIOE9vMG54UE5vZmY2M0h2THVIQ2tTNDdtZ1FmbE84V3U5ZG55?=
 =?utf-8?B?RnBCZ256RU1XYlBRS2FoUDQ5RDUwMlJJUTJwQzFjWTl6UnMzV21GdVpvS1Vj?=
 =?utf-8?B?RWE5TE1rSHJYU094SllJKy9MMWlVckNPTzJXb1BXZEZmaU9tYmtSV3lDdmti?=
 =?utf-8?B?MFZrU0szMUNJbW5Od3U5Qnp5RjBrdUtqM0VJaTZJWXExclduMjY0OVZHOFJK?=
 =?utf-8?B?TFE1RTVXZW9IekZ6UTlGSXYyYitFSjYrOFVZTUlOSHQ3Z2xrbVZvamI1NnJo?=
 =?utf-8?B?NitDblA0a3ZxVnRCL0tFOFp2cWQxQXgycHZRTklZTVU3Y2VSc2Z0VmZ0bGJ3?=
 =?utf-8?B?QWVwWU16NUI5UkR3eG1RSlRvNVRPM2VVWExJL3k5dXJiYkZ3N0s4NUJwd1RO?=
 =?utf-8?B?Ymx4Mk1QUVBKZ2tHY2svb3EvaHBQdFBKVXhkaWRYZm5WMVB4M0JYdmEzZ3U1?=
 =?utf-8?B?cHlMMlVMQTF1TE0rSGd2RDRweC9WcmVMWncrdGtsWW10MmpHS0Q5L3JqNXM1?=
 =?utf-8?B?YW1XTzlXYTVGaFVyNkEzdXlwcHZPb0JUUVQvdE4yRWMrTUpQcUtsZXMwQ2Z2?=
 =?utf-8?Q?uexY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c74a7-1b79-43f5-2233-08dc708c23da
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 00:57:18.0406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53zOHuPy0TY4CpQ9SORHfdBicy0er2rfuM1EaCXlJJroB+woys5/LjBTFviGPEZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828

Hi Peter/Reinette,

On 5/3/2024 3:44 PM, Moger, Babu wrote:
> Hi Peter,
> 
> On 5/2/2024 7:57 PM, Peter Newman wrote:
>> Hi Reinette,
>>
>> On Thu, May 2, 2024 at 4:21 PM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>>
>>> Hi Peter and Babu,
>>>
>>> On 5/2/2024 1:14 PM, Moger, Babu wrote:
>>>> Are you suggesting to enable ABMC by default when available?
>>>
>>> I do think ABMC should be enabled by default when available and it looks
>>> to be what this series aims to do [1]. The way I reason about this is
>>> that legacy user space gets more reliable monitoring behavior without
>>> needing to change behavior.
>>
>> I don't like that for a monitor assignment-aware user, following the
>> creation of new monitoring groups, there will be less monitors
>> available for assignment. If the user wants precise control over where
>> monitors are allocated, they would need to manually unassign the
>> automatically-assigned monitor after creating new groups.
>>
>> It's an annoyance, but I'm not sure if it would break any realistic
>> usage model. Maybe if the monitoring agent operates independently of
> 
> Yes. Its annoyance.
> 
> But if you think about it, normal users don't create too many groups.
> They wont have to worry about assign/unassign headache if we enable 
> monitor assignment automatically. Also there is pqos tool which uses 
> this interface. It does not have to know about assign/unassign stuff.
> 
> 
>> whoever creates monitoring groups it could result in brief periods
>> where less monitors than expected are available because whoever just
>> created a new monitoring group hasn't given the automatically-assigned
>> monitors back yet.
>>
>>>
>>> I thought there was discussion about communicating to user space
>>> when an attempt is made to read data from an event that does not
>>> have a counter assigned. Something like below but I did not notice this
>>> in this series.
>>>
>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>> Unassigned
>>>
>>>>
>>>> Then provide the mount option switch back to legacy mode?
>>>> I am fine with that if we all agree on that.
>>>
>>> Why is a mount option needed? I think we should avoid requiring a 
>>> remount
>>> unless required and I would like to understand why it is required here.
>>>
>>> Peter: could you please elaborate what you mean with it makes it more
>>> difficult for the FS code to generically manage monitor assignment?
>>>
>>> Why would user space be required to recreate all control and monitor
>>> groups if wanting to change how memory bandwidth monitoring is done?
>>
>> I was looking at this more from the perspective of whether it's
>> necessary to support the live transition of the groups' configuration
>> back and forth between programming models.  I find it very unlikely
>> for the userspace controller software to change its mind about the
>> programming model for monitoring in a running system, so I thought
>> this would be in the same category as choosing at mount time whether
>> or not to use CDP or the MBA software controller.
> 
> Good point about the mount option is, we don't create extra files for 
> monitor assignment in /sys/fs/resctrl when we mount with legacy option.

I think we still have not decided about the "mount" option for switching 
to legacy monitoring. Mount option seems safe at this point. We don't 
have to deal with extra files in resctrl filesystem with dynamic switching.
> 
>>
>> Also, in the software implementation of monitor assignment for older
>> AMD processors, which is based on allocating a subset of RMIDs, I'm
>> concerned that the context switch handler would want to read the
>> monitors associated with the incoming thread's current group to
>> determine whether it should use one of the tracked RMIDs. I believe it
>> would be cleaner if the lifetime of the generic monitor-tracking
>> structures would last until the static branches gating
>> __resctrl_sched_in() could be disabled.
>>
>>>
>>>  From this implementation it has been difficult to understand the impact
>>> of switching between ABMC and legacy.
>>
>> I'll see if there's a good way to share my software monitor assignment
>> prototype so it's clearer how the user interface would interact with
>> diverse implementations. Unfortunately, it's difficult to see the
>> required abstraction boundaries without the fs/resctrl refactoring
>> changes[1] applied. It would also require my changes[2] for reading a
>> thread's RMID from the FS structures to prevent monitor assignments
>> from forcing an update of all task_structs in the system.
>>
>> -Peter
>>
>> [1] 
>> https://lore.kernel.org/lkml/20240426150537.8094-1-Dave.Martin@arm.com/
>> [2] 
>> https://lore.kernel.org/lkml/20240325172707.73966-1-peternewman@google.com/ 
>>
>>
> 

-- 
- Babu Moger

