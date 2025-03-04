Return-Path: <linux-kernel+bounces-545644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFFA4EF8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE316E420
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA02620E6;
	Tue,  4 Mar 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1pYBLf1O"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3381EE7B1;
	Tue,  4 Mar 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124965; cv=fail; b=hOXDWm1CPy3vUQodbbhJf3Tr1/O9CXaTZcBVoz4/AvhStQWLQwZd6oRX082cDEV5N6SbB5nkiclJqWSeqBDWpgfPo26On+nepZJ2xZH0PbjNkuYNFDii2rQ5UwOAabck+V1xpbC5Pz0mOZYgvIUSOalmF3c/1J05rcq5qNW4zws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124965; c=relaxed/simple;
	bh=u9SkZB5X/5WlN5HvRSMGfCSxiEbVg0zdtna7fP8Rlig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UjIeyCJFqdCY9Sw0WfRjU5c0r35EysWCJNDa6V+TByGRaqnUqIzVHDuAcs+1nwD2SKJTTCFadNteNe2dK1YbeS0PiEQkKUtBMW/JtNgAf6dP82FhQyk3+YyeG0JAGe4K9GFBxDtKWCebti3IAFZB4YpmWMZDFE4BDQD+fDHqvl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1pYBLf1O; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opwrLl+YZRkwZSX6nh42nSbTyoF1KwfiZD7NQA0zUZGZYOWb+EGlxYuRAYl6NOuKmIU23RjOb6M1ahD9sSHD1q5HjqStcheHSWunhVUf7IyszZXzxpJJvgkzccrYn/jyfcLlubXb7CIQ8YvFEZ16IRc80dnSyUHG5xaysCzHUc4eSKa8hYKBGFQnr4cJyFk89AS+xEGVV58Y8ffVrFG7muE6SHEUrhGzgPagd+6aVC1Hv/QP/vHc1t9kLf2+34WmHddjWfDidP5V8OEdvmyj+EdQpvXB0BIEtNnrdD34aodsTDX3m9pqcnJ+aFQChobx9+Y9c+T/QDbKzjga/Ek8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiILhYveMDsAxSXfA4dIaR/7DGgr0BLECMP/u7kmdmo=;
 b=iuvWtV/u8IyTr5QO+eKZlIxjQRxdeCxJFHovrmFkqMBUqSCywj1snCirWNmFjd1xyWwwx+Y10Rw97e6Vu4TyPMsMLU6on3uGL+JUHQXj2q5+7z/TaKdKcp9e3qkkcpNCUnE4QFcQ1zlWHNpJjVfM4TcUMLaEjcItedSkAdAkFNXGU7dIaOrRebdJBza9qKbbJoaSVFXIqcmPgklu1hrqqcZwuQ9v8Tu/797k3Km4RC3chXOl3T2kQFz1PBk/7o1Qz0GaQHIoXz8SxcrG6A/ZAsiQOLUIZYvDR/rfaIaPK4meQUfbXH+3CG/pePGn+u6G/019OfDcx5+gxGnKPyUxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiILhYveMDsAxSXfA4dIaR/7DGgr0BLECMP/u7kmdmo=;
 b=1pYBLf1O9x9dIdhW7mlL5HulwrA2ObISAwnCcOnZamb7iltdBMu3yWnXAOvqjfxrJ17lfBXaY2udKvZ1QDp+kI7cMNA5VjTgvNHw7m3/5dWujfvBWW/t/RHy+J2btsuf62OYUfYj991rVgyowOTJt2cohMck6YxYXeb7IUsXJRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 21:49:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 21:49:16 +0000
Message-ID: <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
Date: Tue, 4 Mar 2025 15:49:12 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
 <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <f1744c45-9edf-4012-89bc-47393b4c53fc@amd.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0137.namprd11.prod.outlook.com
 (2603:10b6:806:131::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: b50b321a-b040-4c41-d389-08dd5b666904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0NBM3RaUjdDaytwMEZQZ0pBYWNxOFhMc2ZPeE5tUitaTzBGOVRNemRLaDlM?=
 =?utf-8?B?aXNucnEvOGRKSmJkUW10QWJQbVFzMkR2cWE0TXcxdlZ3alJlUGhaekw5anNO?=
 =?utf-8?B?WlJ4MUVhc09iTGZlSm1jVFVxa3hVYXpNM3dIK2ZLS0RWckxXV3dqL1dKTzhU?=
 =?utf-8?B?MGZOTVBFdzRLN0w2SFVXUm9aL2NuTFRRbkZsL0d6b1VsZzFmRGwxMjFFWkIr?=
 =?utf-8?B?MEhkOTRDQnlGMGJ1RXVkQVFZOUh3NThUb2JTeUFrRGQ5UXFJd0Rac0ZhTFFH?=
 =?utf-8?B?T1NnYkkzb1Jmd2xLUStJOHhxaEcvSkI5bERiWVcvMXluNCtYeDRhQ25CTWdR?=
 =?utf-8?B?aUtCZHN0UUlFY1d3Y0xxN0xhM0JGWU9uS2I4aXJyejhpQVdodnpoOG14OFJ5?=
 =?utf-8?B?TGJNTFhPRVUzZE0xa3pnNUFtQXJvOVhUWkYxVFQ0YmVMWkdpa3IxWkcxWERQ?=
 =?utf-8?B?QXB4ZHFXS0E0RUdocndqZC82LzBrWGdPQW1EU0xQZHZTQXQ4ZTFYb0huQVk1?=
 =?utf-8?B?TmhjQkVCLzVuaWpiVzJuSldDRXBkVjBnTTVVOERHRjZTNm13dzN0TFczZTdD?=
 =?utf-8?B?UjlUNDdWaDIvYTJlNi9wcVVqTFRkTGpaRHZ1aHk1WHBwL0dEOUlXRUkrWHo3?=
 =?utf-8?B?c2pOcUhOSFlEcThSRFpBL0tKSVZJZXhXck8wd1BVVlVMM2FWejliMTZQS3hT?=
 =?utf-8?B?R0NNYmp6OTVIczV0UG9NMEV6cnVCZVVpWEVjQUVEV1h2TjhGT0Y0NmRXNVVW?=
 =?utf-8?B?dlRUUUhUSE9LQm1Yb2NkODhESkVXazVrT0hCbzhxZjdPWnlQb0xkRlI3Q1JS?=
 =?utf-8?B?aklyejV3K2FoUXVCSGwxQVUvdmpWUlB2WFk4ZER1WG1Ja3NHOXQ4eXUxZGc0?=
 =?utf-8?B?VmJ0ci9Db0h0emNDZEVtZVRWSDFkM2lCdTFrMWY5Z204YTc1MURBZFhaQnNx?=
 =?utf-8?B?UnAyalkzenR1bW1aSE9uUTNZTWpuR0ppRXh1ZkM3aUlJZ2lLWG1WVmpsWThY?=
 =?utf-8?B?WWxIa1lGSTZtYVo1cFRsOTJIaTdENmJILzZ6amVGS1lXT2RKa3VrMnd6dkNS?=
 =?utf-8?B?WEEwdFNVdVhsekp3RWljc3R6bWhYTE1UUjdVNnluSFF5d1Jyc2wrL0lia0lq?=
 =?utf-8?B?d3YwR0lHd2pUanlldTFzK0tpbFZmVWxVMzVBbzBQSWQyL0FTTVZkME1HUGJq?=
 =?utf-8?B?b0pxUDNVODRxR2dhMUFCMURJdlY2ZzhuQlc1TmlSOFJEK2xoSVRGdW9IRTFP?=
 =?utf-8?B?RTUrVFBrZytSY3NJQVlwTnB4QXJwOGZ2V3RFYlhvd0hmN3pNV01USHlZbkRQ?=
 =?utf-8?B?bm9tMlI4ZDVmTVhwSDl2Q2JOYWs2V0k0SEJvZ3psQkdRd2tnQ1B4ZzhhMk9L?=
 =?utf-8?B?K2pVQjFCWmV1NWpBN0hHV2g3cE1pQVUwZDE4cmZmcmdwUHY2WUZuSmd1TFVq?=
 =?utf-8?B?MkJhNzRSTmRBT1ltNWpNUGsybkovNUxZYkRoRmoyWGlxK3hrdnlkOFFxNVhl?=
 =?utf-8?B?NnE1a3ZhK09QVmxyQit1VjdZeHJCaVlTSXNZMVlDZENrVFBVbDA5RmFzalJi?=
 =?utf-8?B?aUhITlN5NkViTUpmVkUveTFzd1ZtWTBsMXRTcG1aN2QxRHpjSFpQMloxenZq?=
 =?utf-8?B?V0xzL0ZuQUZkR1pQV2N1bG1CbzMraE1JK3NUN2xMZCt5aWVhdDdYaWxTRks2?=
 =?utf-8?B?Z2ZBcWlSaTJsaTU2N0hQZjhTQ0FNTml1MzhtN3VNbU1BZkdtZlBUcmIycFlO?=
 =?utf-8?B?UGdlYTFoN1pLY29tVG5WeXdhZGVPMnVxRmQ5d0pOcmdrOVlkVHpCa1dldFFT?=
 =?utf-8?B?WDJUcWR0VFd3eGllQTUrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWhnSXVjaS9OV3YxYjlSWElRS0QyYWZQVThOWHlOa0dyV3NYdlVoZEtUbTNy?=
 =?utf-8?B?a2tGUUd4SjhaRXB3YXA3UzlxcVpGQzJ1VlRWcWJnMytFZXJMWFVhYnNyOGtW?=
 =?utf-8?B?bTFLaGh6RHhlbXZlZHVGL1JBZ3FySDE1N2lERGM4WHNSSlZHK1hpYzRHM0R3?=
 =?utf-8?B?ZVMyNm9GYUZrTk5uYnFjczlrelBlcTJOa1VjallTOWRoTU9QWGtmK2I0TUQ5?=
 =?utf-8?B?eFh6OUNvM0VsZThTbENoa084NEFsVFFlOEwzWVRjS0Y3R1hqeXM2cHhES1FV?=
 =?utf-8?B?ZjFOMWh5U2xaeW9heVVKcjNNcXJjem1YcTlvdWo0UEU2ZTgzcWV6TU5CVlFx?=
 =?utf-8?B?N2kvMzFuL1lmSUhWci94R01mOUY2L2FFNnFhQjZzN1E3aFp2bkc2RUpCQ3hB?=
 =?utf-8?B?N0hvVG1Gd2lSbzArWmpHSDczVnJMNWhDOGlZUWptUU1BWUpUaWtIaHlmb0c3?=
 =?utf-8?B?UGNVQ1Iwb0owOTJSZmtrd0c4d3JqZTRtaStQS3BTcVJMdGc5bXJWQWlZekRM?=
 =?utf-8?B?S3pTV014OCsxbWlxekNHYWlLQlV1eTdQb2duRTlIVU1iaXF3eTFCaHVGc2pU?=
 =?utf-8?B?UWlBUlBTaXJlSW9OMitpZFpaaUNrZXgyQnZ6bVZYMERYZFNQWTN4eUdzRk9M?=
 =?utf-8?B?WVVVUjF3QlVlbTU1RUNBSnF3d1lEUU9MWkxqelMzaHJSMGpMcEx6TUhiKzZj?=
 =?utf-8?B?cDExenZJKzRvLzZGeGdWckxjSVdLZFJuWTlEdzZ1S1ZTODVXRTBNdjZ0b20r?=
 =?utf-8?B?WmxvdEwrU3FidWRFaDlQc0g1VnJRYjUrL0FSRnBRb2VEZFljT1RPeXg3MmVW?=
 =?utf-8?B?Vk9Gd0s4NS9YVlFJV2IvbDJROVpMb3hYV3BIYUdHTjgwekM4VXlGQTVZdlcw?=
 =?utf-8?B?Wm43bmRMYm1EY3pHaFVvVVQ1dC9FYU1UU1ZqbC9yZTZkWEVPL2RVcWR1YXlE?=
 =?utf-8?B?RVdVTWIwYWtvejdyczJUa2U0YVo3cHBOK1JiV2JOYjJPdXBoR2xSMkxWUXBr?=
 =?utf-8?B?WE02YUlxdS9TbU5xeWVqQTkxWHFndk1SaHU1aUZzemJ1NG9wWHF1MkFuTzEv?=
 =?utf-8?B?VVFuRnEvMzNRZlpZNmQxNTdHQUhBNFBRTU9Qd2xxNHpFY1NZeGdLQU5vaW5V?=
 =?utf-8?B?c1M0QWVoQ05zR1JpaG94RXlIZXV1MnlhVWd6TDFJMUlocDJudml4Q1c1QVIw?=
 =?utf-8?B?eFRLeE81VVBTSlFRZzdyZXpxZmdNQzFtMWRrQ1lsT1U1eE5wcjljWTBiZFZL?=
 =?utf-8?B?MXRCK1lBbjBNSE8xdWJYanc1RVg4ejdXb2NUOGFWTk90NlduaU9Yd1MxZEcy?=
 =?utf-8?B?cEZRdTlPa0cyNjRsYlNtVDBUVFB2bG1YR28xR1VQT0QwQjN3c3R0ZkZaRG8z?=
 =?utf-8?B?YS91YjlHNGFyN0ppVEc0VHZzMHBJTnU1VzF2SHQrSzk1VU5qUm1QWDR2dXFp?=
 =?utf-8?B?RTB3R2d6SXRiaC9mM0VRSVNTMkNqZS9HckhkYk9lSzRWT3dLRER2c3BPR3Ft?=
 =?utf-8?B?MDc3WnJWc0lZYUl6N28zWHJFR0EzVi9SZnlDc2xXcGc3K0N0NFkyT2o2Y05K?=
 =?utf-8?B?ZytzeFZoZkhEVlk0aXFtNUlPN29VV2c3aUV3eVJsY3FWa2JieWtXNGxNMmVT?=
 =?utf-8?B?UEFnZVJMNVEwVXloTUpDNGh3OS9GdXdXVG9HeUIwN3Q0cEJ5UDFqZjF5ZFFI?=
 =?utf-8?B?VWdpVzd6MG5RdXhVaEVjTVd5anhHL0pxbXZKdEtvZEdHaTRPL1FhWjRaRDhX?=
 =?utf-8?B?Nkt4ZDdiUzF2VnJCN1laSC9aTUZXZVdyR0hrRHlEQUh5TDc0c1FacXNSZ1U0?=
 =?utf-8?B?dXRnZjhGcHk4VDlwOUZGRmxISFZRRjZlbEpla0RCWmd6RWZCaUZiNWZWdGVh?=
 =?utf-8?B?bHNRZEhkQnIrb2JqbzRsNHBWK1F6dnlRM3IraGFnS0JOYisrQnVrUUp5QUJv?=
 =?utf-8?B?NjNRYkFGL04xWHZyRFZQbWFhbTBnTVg3QmRKam9Ub21RTzdPajZBZlJHdXJj?=
 =?utf-8?B?WGZFS1F0dVJTK2tyQ09KYVl3K0FXYnNCUmFVNzMwVWY5K3JmL253SUVGQTAy?=
 =?utf-8?B?c1Z5c1ZJUHdHZDltcmNRVi9yejhPdTlqQ0VERlRNTEU3SjRRN05ZRytFaTZh?=
 =?utf-8?Q?CWZE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50b321a-b040-4c41-d389-08dd5b666904
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 21:49:16.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tx/0j/31ZJY7zlgOd1e16QQGwdjVOfZHR5DfgiSeAU+ZWZdYjUL/34qIKEkm2yeD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854

Hi Peter,

On 3/4/25 10:44, Peter Newman wrote:
> On Mon, Mar 3, 2025 at 8:16 PM Moger, Babu <babu.moger@amd.com> wrote:
>>
>> Hi Peter/Reinette,
>>
>> On 2/26/25 07:27, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>>
>>>> Hi Peter,
>>>>
>>>> On 2/25/25 11:11, Peter Newman wrote:
>>>>> Hi Reinette,
>>>>>
>>>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>
>>>>>> Hi Peter,
>>>>>>
>>>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>>>> for.
>>>>>>>>>>>>
>>>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>>>
>>>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>>>> customers.
>>>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>>>
>>>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>>>> event names.
>>>>>>>>>>
>>>>>>>>>> Thank you for clarifying.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>>>
>>>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>>>
>>>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>>>
>>>>>>>>>>> (per domain)
>>>>>>>>>>> group 0:
>>>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>> group 1:
>>>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>> ...
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>>>> configuration is a requirement?
>>>>>>>>>
>>>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>>>> there's less pressure on the counters.
>>>>>>>>>
>>>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>>>> many counters the group needs in each domain.
>>>>>>>>
>>>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>>>> globally then it would not make it possible to support the full configurability
>>>>>>>> of the hardware.
>>>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>>>> earlier example copied below:
>>>>>>>>
>>>>>>>>>>> (per domain)
>>>>>>>>>>> group 0:
>>>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>> group 1:
>>>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>>> ...
>>>>>>>>
>>>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>>>> I understand it:
>>>>>>>>
>>>>>>>> group 0:
>>>>>>>>  domain 0:
>>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>  domain 1:
>>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>> group 1:
>>>>>>>>  domain 0:
>>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>  domain 1:
>>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>
>>>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>>>> in domain 1, resulting in:
>>>>>>>>
>>>>>>>> group 0:
>>>>>>>>  domain 0:
>>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>> group 1:
>>>>>>>>  domain 0:
>>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>  domain 1:
>>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>
>>>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>>>
>>>>>>>> group 0:
>>>>>>>>  domain 0:
>>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>> group 1:
>>>>>>>>  domain 0:
>>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>  domain 1:
>>>>>>>>   counter 0: LclFill,RmtFill
>>>>>>>>   counter 1: LclNTWr,RmtNTWr
>>>>>>>>   counter 2: LclSlowFill,RmtSlowFill
>>>>>>>>   counter 3: VictimBW
>>>>>>>>
>>>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>>>> understand the above does contradict global counter configuration though.
>>>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>>>> that it is reconfigured as part of every assignment?
>>>>>>>
>>>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>>>> system configuration, the user will settle on a handful of useful
>>>>>>> groupings to count.
>>>>>>>
>>>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>>>
>>>>>>>  # define global configurations (in ABMC terms), not necessarily in this
>>>>>>>  # syntax and probably not in the mbm_assign_control file.
>>>>>>>
>>>>>>>  r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>  w=VictimBW,LclNTWr,RmtNTWr
>>>>>>>
>>>>>>>  # legacy "total" configuration, effectively r+w
>>>>>>>  t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>>
>>>>>>>  /group0/0=t;1=t
>>>>>>>  /group1/0=t;1=t
>>>>>>>  /group2/0=_;1=t
>>>>>>>  /group3/0=rw;1=_
>>>>>>>
>>>>>>> - group2 is restricted to domain 0
>>>>>>> - group3 is restricted to domain 1
>>>>>>> - the rest are unrestricted
>>>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>>>
>>>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>>>
>>>>>>
>>>>>> I see. Thank you for the example.
>>>>>>
>>>>>> resctrl supports per-domain configurations with the following possible when
>>>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>>>
>>>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>
>>>>>>    /group0/0=t;1=t
>>>>>>    /group1/0=t;1=t
>>>>>>
>>>>>> Even though the flags are identical in all domains, the assigned counters will
>>>>>> be configured differently in each domain.
>>>>>>
>>>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>>>> reasonable to carry this forward to what will be supported next.
>>>>>
>>>>> The hardware supports both a per-domain mode, where all groups in a
>>>>> domain use the same configurations and are limited to two events per
>>>>> group and a per-group mode where every group can be configured and
>>>>> assigned freely. This series is using the legacy counter access mode
>>>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>>>> in the domain can be read. If we chose to read the assigned counter
>>>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>>>> rather than asking the hardware to find the counter by RMID, we would
>>>>> not be limited to 2 counters per group/domain and the hardware would
>>>>> have the same flexibility as on MPAM.
>>>>
>>>> In extended mode, the contents of a specific counter can be read by
>>>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>>>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>>>> QM_CTR will then return the contents of the specified counter.
>>>>
>>>> It is documented below.
>>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>>>  Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>>>
>>>> We previously discussed this with you (off the public list) and I
>>>> initially proposed the extended assignment mode.
>>>>
>>>> Yes, the extended mode allows greater flexibility by enabling multiple
>>>> counters to be assigned to the same group, rather than being limited to
>>>> just two.
>>>>
>>>> However, the challenge is that we currently lack the necessary interfaces
>>>> to configure multiple events per group. Without these interfaces, the
>>>> extended mode is not practical at this time.
>>>>
>>>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>>>> require modifications to the existing interface, allowing us to continue
>>>> using it as is.
>>>>
>>>>>
>>>>> (I might have said something confusing in my last messages because I
>>>>> had forgotten that I switched to the extended assignment mode when
>>>>> prototyping with soft-ABMC and MPAM.)
>>>>>
>>>>> Forcing all groups on a domain to share the same 2 counter
>>>>> configurations would not be acceptable for us, as the example I gave
>>>>> earlier is one I've already been asked about.
>>>>
>>>> I don’t see this as a blocker. It should be considered an extension to the
>>>> current ABMC series. We can easily build on top of this series once we
>>>> finalize how to configure the multiple event interface for each group.
>>>
>>> I don't think it is, either. Only being able to use ABMC to assign
>>> counters is fine for our use as an incremental step. My longer-term
>>> concern is the domain-scoped mbm_total_bytes_config and
>>> mbm_local_bytes_config files, but they were introduced with BMEC, so
>>> there's already an expectation that the files are present when BMEC is
>>> supported.
>>>
>>> On ABMC hardware that also supports BMEC, I'm concerned about enabling
>>> ABMC when only the BMEC-style event configuration interface exists.
>>> The scope of my issue is just whether enabling "full" ABMC support
>>> will require an additional opt-in, since that could remove the BMEC
>>> interface. If it does, it's something we can live with.
>>
>> As you know, this series is currently blocked without further feedback.
>>
>> I’d like to begin reworking these patches to incorporate Peter’s feedback.
>> Any input or suggestions would be appreciated.
>>
>> Here’s what we’ve learned so far:
>>
>> 1. Assignments should be independent of BMEC.
>> 2. We should be able to specify multiple event types to a counter (e.g.,
>> read, write, victimBM, etc.). This is also called shared counter
>> 3. There should be an option to assign events per domain.
>> 4. Currently, only two counters can be assigned per group, but the design
>> should allow flexibility to assign more in the future as the interface
>> evolves.
>> 5. Utilize the extended RMID read mode.
>>
>>
>> Here is my proposal using Peter's earlier example:
>>
>> # define event configurations
>>
>> ========================================================
>> Bits    Mnemonics       Description
>> ====   ========================================================
>> 6       VictimBW        Dirty Victims from all types of memory
>> 5       RmtSlowFill     Reads to slow memory in the non-local NUMA domain
>> 4       LclSlowFill     Reads to slow memory in the local NUMA domain
>> 3       RmtNTWr         Non-temporal writes to non-local NUMA domain
>> 2       LclNTWr         Non-temporal writes to local NUMA domain
>> 1       mtFill          Reads to memory in the non-local NUMA domain
>> 0       LclFill         Reads to memory in the local NUMA domain
>> ====    ========================================================
>>
>> #Define flags based on combination of above event types.
>>
>> t = LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>> l = LclFill, LclNTWr, LclSlowFill
>> r = LclFill,RmtFill,LclSlowFill,RmtSlowFill
>> w = VictimBW,LclNTWr,RmtNTWr
>> v = VictimBW
>>
>> Peter suggested the following format earlier :
>>
>> /group0/0=t;1=t
>> /group1/0=t;1=t
>> /group2/0=_;1=t
>> /group3/0=rw;1=_
> 
> After some inquiries within Google, it sounds like nobody has invested
> much into the current mbm_assign_control format yet, so it would be
> best to drop it and distribute the configuration around the filesystem
> hierarchy[1], which should allow us to produce something more flexible
> and cleaner to implement.
> 
> Roughly what I had in mind:
> 
> Use mkdir in a info/<resource>_MON subdirectory to create free-form
> names for the assignable configurations rather than being restricted
> to single letters.  In the resulting directory, populate a file where
> we can specify the set of events the config should represent. I think
> we should use symbolic names for the events rather than raw BMEC field
> values. Moving forward we could come up with portable names for common
> events and only support the BMEC names on AMD machines for users who
> want specific events and don't care about portability.


I’m still processing this. Let me start with some initial questions.

So, we are creating event configurations here, which seems reasonable.

Yes, we should use portable names and are not limited to BMEC names.

How many configurations should we allow? Do we know?

> 
> Next, put assignment-control file nodes in per-domain directories
> (i.e., mon_data/mon_L3_00/assign_{exclusive,shared}). Writing a
> counter-configuration name into the file would then allocate a counter
> in the domain, apply the named configuration, and monitor the parent
> group-directory. We can also put a group/resource-scoped assign_* file
> higher in the hierarchy to make it easier for users who want to
> configure all domains the same for a group.

What is the difference between shared and exclusive?

Having three files—assign_shared, assign_exclusive, and unassign—for each
domain seems excessive. In a system with 32 groups and 12 domains, this
results in 32 × 12 × 3 files, which is quite large.

There should be a more efficient way to handle this.

Initially, we started with a group-level file for this interface, but it
was rejected due to the high number of sysfs calls, making it inefficient.

Additionally, how can we list all assignments with a single sysfs call?

That was another problem we need to address.


> 
> The configuration names listed in assign_* would result in files of
> the same name in the appropriate mon_data domain directories from
> which the count values can be read.
> 
>  # mkdir info/L3_MON/counter_configs/mbm_local_bytes
>  # echo LclFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>  # echo LclNTWr > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>  # echo LclSlowFill > info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>  # cat info/L3_MON/counter_configs/mbm_local_bytes/event_filter
> LclFill
> LclNTWr
> LclSlowFill

I feel we can just have the configs. event_filter file is not required.

#cat info/L3_MON/counter_configs/mbm_local_bytes
LclFill <-rename these to generic names.
LclNTWr
LclSlowFill


> 
> Note that we could also pre-populate info/L3_MON/counter_configs with
> the expected configuration for mbm_local_bytes and mbm_total_bytes for
> backwards compatibility.
> 
> To manually allocate counters for "mbm_local_bytes":
> 
>  # mkdir test
>  # echo mbm_local_bytes > test/mon_data/mon_L3_00/assign_exclusive
>  # echo mbm_local_bytes > test/mon_data/mon_L3_01/assign_exclusive
>  # echo mbm_local_bytes > test/mon_data/mon_L3_02/assign_exclusive
> [..]
> 
> Which would result in the creation of test/mon_data/mon_L3_*/mbm_local_bytes
> 
> For unassignment, we can just make an "unassign" node alongside
> "assign_exclusive" and "assign_shared". These should provide enough
> context to form resctrl_arch_config_cntr() calls.
> 
> -Peter
> 
> [1] https://lore.kernel.org/lkml/CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com/
> 

Lets keep discussing.
-- 
Thanks
Babu Moger

