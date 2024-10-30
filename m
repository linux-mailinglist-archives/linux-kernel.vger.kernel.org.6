Return-Path: <linux-kernel+bounces-388865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD09B6567
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253901F2200C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6855A1F12E8;
	Wed, 30 Oct 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5nT9qubb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0871991D3;
	Wed, 30 Oct 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297662; cv=fail; b=paCMG5f1tfhlrR8NXbYQuRDh8fqfnNXgJPZuz89LUMMoMrwPlJ7lwJcemPBfp5zhtnR3ccFmCAvTIgU+8EcS4bkZflDg2+AguzkQfxtEnvzq1fkjvkCQbQQ75j0FILesxtMK2xk2xFtrQI2i5DnTTCUCJM9xa920r1pOw8P9qmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297662; c=relaxed/simple;
	bh=66hevjNxwGTbVWhX24+0rVSkG6PXIuff3x268pwj0XU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCYXUcnq23c3SzpeynFfExG2U2ZFfAlZXrtYGS1FuPE9RgbwKAHCUo5klkGduLVp2kXIe0emunRib69A3pxHvG1I7oJyWDaU8zQPMW95uFQMJeyCVpzmqFwTNR4z+tvovvbHwGYburBYqDbAEDag9SiZgZ9NtD0yPjMylxb/1TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5nT9qubb; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPBOSZL6aEZ/gpn0A6Huef+A36SmmDONjWi11D262VhR+gSV5BKFeRsDIBD5YZUZGz8ptAFxvh20zrBuZK7S62qAIYu8Vk9gJ5EQ1egNNpmWH2uLDLzgmbTNtRPZFdOr4vRCi5lClksPbyFh3uE4ueEJfMo3use5k5xTtJgcGkzRwBfG4W+D4cPL/qP/nkQMIr8/ruTE+LQknRWOK2nezk+QO9wr5q6lOR9XDDq/AUOmwWT9GWFhLmtckri+GTjwrMEo8o2gYN7ML9iJsKJxl+WD8ZPe+hEqY3sVMnDx6Gqidha1tZaOJzYAdo6F3wwqO5J1j50kDCkcSBaS4baq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0V5zjvWnShhDT/PCSdqYkhwkWe33zMWLoX3MOt3K/c=;
 b=C8gfF6Ap/Q/1OpDAYhsSwTT8KdNNVnK5dWYnt6CWKqLTGwIFO9NmHAyaTe6SAgCZ3OpAUVWxsl/vGF1dx9BU1Tjm5jj3TyFAeA4+igezJj1V1HTNPZAda9+/Xzzxp3JeDZSBcZ9NlOIS19wlIBQbVxct7JUZuFAbhW78K6OfoMwIglo90WRp8K/RjGsA4njN3OQ6JBOJKyFHn+Zta8lG6nOSSolE/Cm7sHjLTQWFR7KBnjtKEy2f6rDeEaqmdbbEigC1qKJto/V5AyXkgfYlURKUqwu+HE61GGNTzIMJCvjbjH8QLa7KrdFsc1P+Y9yFBh6V/WYxU3AFYBXamZ1F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0V5zjvWnShhDT/PCSdqYkhwkWe33zMWLoX3MOt3K/c=;
 b=5nT9qubbGs+zhuoupUVpCs6z099gwTvnGW5NwSgtYFhJAdtgn67ep3MUZPJVcZfESiEyRabAE4LSOE2DHt/kvPUw+Vnwcn2y9SoAEzRYi+F/lg/i3Yiz11h1OFUWSGWJbRqvKS1bcShdQb2k7KePJodIMSaypQnGN9FuNBYbOPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 14:14:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:14:17 +0000
Message-ID: <7ed40bcb-d51c-4b6e-84da-81e4ce816606@amd.com>
Date: Wed, 30 Oct 2024 09:14:12 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: RE: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
To: "Luck, Tony" <tony.luck@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>, "Li, Xin3"
 <xin3.li@intel.com>, "ebiggers@google.com" <ebiggers@google.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "Eranian, Stephane" <eranian@google.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
 <SJ1PR11MB6083BDFA959067B4BF62B478FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB6083BDFA959067B4BF62B478FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: b6691668-9276-41c3-c7b7-08dcf8ed23f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3JZSEU2MjE3dWRvNG5aYTEwOU5USm1hMW5kMHpwajlmTHlMaVpkcmx3QjJq?=
 =?utf-8?B?c1ZWL3RYNVhLRUpSeXpVM3lVMHk2VUR2bFNVK3cyZjhTQkRnbzNzV1RLeTVU?=
 =?utf-8?B?dU51M1dqcDNWM2tic1J6VXhNemxIV3BsRm5CRVJURHFIMis1eFdjVW9WK3dP?=
 =?utf-8?B?VUx1aWZmTzQ4d3RCN2Z3WkZRYzhuV3E5V1FyMVlaaW8wbkRsVXp4cXlPc2Zk?=
 =?utf-8?B?ZTQremJUeFNLS0hlNHByb1ZudmZ0bHdKbDJNN0cwTUJveXhkak5zUVNrV3Rk?=
 =?utf-8?B?QkJFNElZUEx2NnFSWTUwcEllY1RyVW8rSjJHL0pOdXdXTzJIYXRxcU9MVk40?=
 =?utf-8?B?T1ZyZ0lBaWNOVks0TzM1U0duUG5wbTQzR0ZRdHVqelNZbC9aeFdIWDcwc1l6?=
 =?utf-8?B?eGVwTjVGTVRoQ29GWC9GOTRTakN4R3pEOTVFN0RZUTJHU0taVTYyQXE0ZlB1?=
 =?utf-8?B?aEthZGJYVGtEeEdHZVdoYXU5UjhxS0JyQkN6SVAwaEJwYkU1R254UVgyTjYx?=
 =?utf-8?B?a3dGT05nVXdOYWExVWdGbGhYNTRUa1M1NWdZK29KaUhlNEhMRmJTVmFpb0Z5?=
 =?utf-8?B?aStOTHorV3BYeFA0N3p4eFpIK2t4VHVhaXFUb1dGN3p6dXJVTVNmelFQbW5G?=
 =?utf-8?B?R2UvOUxBRkhlb0ZIMDVZcGRIN2N0ZC82ZGtIVTA1RFpnbUZYNjM3T1NwUnZn?=
 =?utf-8?B?T0FXcmFMaGxBVkx2WjBUa2I1a1l6NUpaRmpabVZteXpQckFEVVp5RGsvZnVQ?=
 =?utf-8?B?TzIyaEsza0J6dDBnYXMvN1Z6MUluNnhMYlptdUZiTjdqRllLZmp0ZytjbzlR?=
 =?utf-8?B?VWcvTGMxQjBXMTNqY1NXUlEwdmdMNFdaTVkreGV6Z1M2MHo3WitMUStITE45?=
 =?utf-8?B?UEpzMkp4L0xZM25Jb3NkakxVbUV6c1F6UnFnRzdOR0tZQW9tYTAraHRERWlO?=
 =?utf-8?B?dUVBakZOVlVQcFo3UkVqckFDeTdHTVR3SGVzMWJiVWV2ZndmSGlYbktoOTho?=
 =?utf-8?B?YldGNE42c0ZrUm5aVi9WNUduSDc0cm9UT1JmdDBHVi80ODF2Znpha0JmZENh?=
 =?utf-8?B?YndjbUxsNzYxcCtabnJkWGpCZVBwM3Q4enVwWTF6QVVaSml4WEt0cVNFR3d5?=
 =?utf-8?B?OEIvT2dubzZyR3gyOWEyS210NHFjcUpSQUhUUXUvQjZqaEZNWHF4N3lkQVVF?=
 =?utf-8?B?YjhBZnRiRWlneTRuN3BGTlV1K1I3VzYxOUpIZjh6R1J5a0dSQ0QvRkR4bGY0?=
 =?utf-8?B?RTBuRnRVWDVDRW50eUE2Z3l1dTRPNEtoSUxDckNpbWZxdENWNVljb1BSRmcw?=
 =?utf-8?B?a3RmWFZHMktMTVFsQW1mMDFvK0xEYmsvN2xScHFOR3ZnZFYwK0QydmZTMmgx?=
 =?utf-8?B?eTFFTll4c3RLYTdCSnNzdmJsT2h2RkNlVUsvRTNrSVQzS2tQejEzaG1qaVJS?=
 =?utf-8?B?Zm9OQUNwdnN0TWM4aTNXYi9vNFo3S1NUdyt6RTV3ZXgzRm9WRXFQaDBRV2JV?=
 =?utf-8?B?QmllbWMwNW9yQ08waHN2dThleThVQUsyK0MxWHRsb3ZoS05KY1lBdTVJTlg4?=
 =?utf-8?B?SldGenJ2RVVMR2VyQnFjQmRTSC9ZZkxxNUNGZXNvVEgvclFjWGNyMUxnWnkr?=
 =?utf-8?B?QjdiblpUeXZHR0Zua3E2NjhXdVZXVytwOC9JNzhJbkY2NFp1ZTF3aWxDTEJa?=
 =?utf-8?B?aWwrT3NxVmQyV09wT0Y0dzVPR2lWYlNkZnUwTGVLUEN5bWZFK2thck5JcThW?=
 =?utf-8?Q?3Qm11bMVaUjbwixsUVycvc7S3LwbUztJQa+yMeX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3k5NFBIME0rVHF3NmRvSDE1TWhxaVljSEFXNHFCRWdoZmZlOHRFWHlrbUlB?=
 =?utf-8?B?QWpCa1k1RENuTHhzZDFVd3luZ2E5Y1V0cGwxU2U1SFU2OTJkR05jV293Rmdu?=
 =?utf-8?B?UEgweTFEVW5Yc2srRFd1N0JHY2ZMOGM4WWZPcVUrbm5qM0NNV0tYaEJhOEdT?=
 =?utf-8?B?alJuTWMxOERwc0VPTHg1VThyVEZablhtNk5WSmtwa0UyUjJSbDJrNk5sTlBR?=
 =?utf-8?B?WS9SU2x6aHVHb0xCbVNwRkVjKzdOK0l5QnRuWEhsOFVrTEFVUVNDNm1HMkVx?=
 =?utf-8?B?YjVTaHh0Yms3TnJyeDdETW5nUzVNM2JlOTJZdE5jeVkxVlRwMDVoTStuZ3dk?=
 =?utf-8?B?Mm9uUlVHWHZ4SFBFOENVS0FwdTFST1NHS2NITGJ5elhsclRhQkFQOWdNdkJY?=
 =?utf-8?B?N05qZzhXUUw2dU5icTVzLy9jczVoemVpQzdPbHorQnVjR1NQOE5zUDA5NE84?=
 =?utf-8?B?VFpBTXRiSVJmZWhzR0hESTJPQVBRelZaZmtSVFdlK2JmQ1pwOHhiMENYVU05?=
 =?utf-8?B?bmE2MWwyYzJQbnhjYncvZzlEa3huTnBTNnlYUklkS1AxcFE5MGpMSFY0VVpr?=
 =?utf-8?B?eHRzYkRxRzJQOUErUFBnTUdLM1htbFFyeWsvNzhJYm1rTktWNitrL3FxWkts?=
 =?utf-8?B?Y1pYRUwzU1hpVmVsQ3lSNW9MeEhuTUVBNVhoTm5YK0psTjN1VElqdTJybEtq?=
 =?utf-8?B?TG4zNUIzMXlsR3lWeG1wdlFxeERKN2wxeTZHMHk2b1dEWnA1NzR0cEpsd1Vp?=
 =?utf-8?B?M1BZMXkwakY2M3pLMnlFTmxUQTVPTWRidnZmejh4RS8zb000a0hQVG0yaGJ3?=
 =?utf-8?B?bVVYQkovdlAxbmJ2T1NtUHNSL3RoQXBEOFU4RVNaUjBPNTZ5c3hXRTFJUjVK?=
 =?utf-8?B?WG5BL295L2VLS21Cck5KK1Ryc0RPc1l2NUZvWEVxVjBjbGZ3d3VROS9zQkJ3?=
 =?utf-8?B?bzlkRFhFU3QxUkpwNzdPZWZLYkNISlRzZ29zRWNWQldjT0VQUjBjdWtzbDNM?=
 =?utf-8?B?cHE0OUxvMlJBUTRvRElTUkZKTDdPNGo2SzF1eVNBVi9iVVo5WDBpa3gwMVJ0?=
 =?utf-8?B?eWlEbHB1MVM5UUJsR3lvTk5KMkhOMzRmZVAwUkgvTmRxZEdWem9GVXZxVzdr?=
 =?utf-8?B?Y2h5SzZGTWRacWNkbC9BTFhPZU8ySU0rRlBHYk9GeVJWd3pCL2tzSTRVOTNk?=
 =?utf-8?B?dWhrdFR6bGh2WmtKVkpiYWg1SDV6dGdtZFpoRG5vUTdGblV5MXBlSEJnSkZy?=
 =?utf-8?B?MWtQc1VHa3VIWlNzK3drOGJrWURrSzg0OVQvbnBVV0h4cnZzOVBNb3ZHaDNn?=
 =?utf-8?B?UFNtM1crTWJvSVV0SHBQNVdyN2lrRHVkazhUKzlvS0M5elpWYXVvbDdTOFE0?=
 =?utf-8?B?Z05EQkV3dXA5ZmMzUHhnUmlBdzZHcmZwOG5aT0NyUFhVa2tiYVdXSGxTK0Z3?=
 =?utf-8?B?b0p1NS9STWRFYTJiRVd4ZGNkWk5ycmJKeVRQWDNaV2RMb1Uzdk5tMmYza0s0?=
 =?utf-8?B?OFhJT0lDV0FwdW1YakdONGM4MUJING1adHM4bTMzT2JKZEExSE14QlBaQ0dh?=
 =?utf-8?B?SHh3bG5CcXcxYnVCdnl1VlZyUHovd01BUTNyN2hkTGdabVMvcmQ5ZkpIdHNa?=
 =?utf-8?B?V29QYWVWVUVzWllNMG5ESW9pM1Eyc1lzM0tuQlBkN2xJT2tsOFFYT2RrZTJw?=
 =?utf-8?B?L3ZWZ2ZESmRQLzlCb3ZCTWxEMWR4QmtYWmtsK0hnWWhlekt4NnFvZDRsT1Zx?=
 =?utf-8?B?MHFCZzZkN1lxTkRKZXBMT0Z0QXNsbUlpcW9iNGJEcEZwLzdQazE0NllMQlJO?=
 =?utf-8?B?Ulk3ZDlSUjRycTRQMlU2NTBwdjltWW02S04rWUY5NlhnbkFMcHhiNzM0cVpq?=
 =?utf-8?B?S3Q1bkV2Y3QzRStFNUdoUFVnMFVxYTBxWisybkZqUlgwRjkvMGtaejBwcXJQ?=
 =?utf-8?B?M1NGSnVhditmNDB4MVJValBrekFBRzdqUjZQZVEyRThTRUNQNXRIOUVBTW5C?=
 =?utf-8?B?TGd6SVFlMWw5ZlZNeWlYOVlndjlwUXlQSDU4MXZpbG9OekxGa09jeVV4dmw0?=
 =?utf-8?B?UHNBZnNLRFE2dE9UbFVOOUhNQVNFNHFFSDZQaTRUTWpOK1pveENXWUNDS2lB?=
 =?utf-8?Q?FzNY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6691668-9276-41c3-c7b7-08dcf8ed23f3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:14:17.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTyTo28z85Iwq+F2aO/iM/bGLP+SfpT72/Yu/KmTQegAhEkr+yn+mFuaXTwomipr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268

Hi Tony,


On 10/29/24 18:54, Luck, Tony wrote:
>> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +                          enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +                          u32 cntr_id, bool assign)
>> +{
>> +     struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +     union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +     struct arch_mbm_state *arch_mbm;
>> +
>> +     abmc_cfg.split.cfg_en = 1;
>> +     abmc_cfg.split.cntr_en = assign ? 1 : 0;
>> +     abmc_cfg.split.cntr_id = cntr_id;
>> +     abmc_cfg.split.bw_src = rmid;
>> +
>> +     /* Update the event configuration from the domain */
>> +     if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +             abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +             arch_mbm = &hw_dom->arch_mbm_total[rmid];
>> +     } else {
>> +             abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +             arch_mbm = &hw_dom->arch_mbm_local[rmid];
>> +     }
>> +
>> +     smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
>> +                           &abmc_cfg, 1);
>> +
>> +     return 0;
>> +}
> 
> Compiling with W=1:
> 
> warning: variable 'arch_mbm' set but not used [-Wunused-but-set-variable]
> 
> [still not used by patch 26]

I knew I am going to miss something like this.   Thanks. Will fix it.

-- 
Thanks
Babu Moger

