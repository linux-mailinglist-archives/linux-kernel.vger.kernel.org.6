Return-Path: <linux-kernel+bounces-370699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAC99A30EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B50285DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C561D86CD;
	Thu, 17 Oct 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cdlo0bsf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FA1D5AC6;
	Thu, 17 Oct 2024 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205101; cv=fail; b=hkzLw0ZlelmLedkiqGE3PknxzhPnIRcxaGTvnLkKsKPDqT7d3Fqb5O2bmVWCsmRHG/oLVZRrP1b/XPOdA6DPUa+8htXqbhtSkDrX+jta0Ejj6rwTjDXTHZIn0QL8R4GGvJB5DcGWwXzxZEfuxUQuDSU6uVQEqZH6TJbJPQhgXRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205101; c=relaxed/simple;
	bh=BhXth5V0+PlwB73Tv9pHWpEpvt5PjrWTsLevOaxkhSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oK7Rfq4CKtlw4PpBCKva3QwD5gbt7JZooyl36cjJx1Qdkv/6GYCUNnoS4arf+PGjkCjJGK93AlyxQI2EyoIwiKGhvv4C8FHvQ7/D4S+jq+IOtG3zu3sq66X0ob8It4eWALKWcqvDUNrIrbbrurRADFa7p5f1XiKPYww5//c8ILU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cdlo0bsf; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBcrEqDf6/K6y4tlwVbEqRk8JaPM7/FkJ35wMdzQ7MZt3GW3+aq37fXyNoFLz0g8PNLyPFh6T0HOgU8RUwtE4n/2lUtTL7CEGSOAG9L94JiKLzBoyKWMV4nEuZirX1vvPfThXoixS9bQ5ImIGwhTscDVvoa+KYfCmuzS2zAM+07fd8vTu3Mxc6IuYCwTEbTqoymRsoMCmJxu7KvCUEx+NryKCX8kcgJwKoTed//VDrt0PcWUB/KsdwDQSXIxVXufaYeWnrtmTqjizV+hyUJtereIRXxEbVd7J4jqXcmBtCaAeuyuyBeMkWWx/4UDRW3unLF5riIWVS0eKLLz0bd+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKUK9hrctIObgrshgXQVxQgNm4fYSN6fwoPeoa+zR08=;
 b=EG+2cv6OPVEsIFhr7JBJIU9uoQIyolW5cuFvqjlJS0CdFtt2/Zk06bK+ll+AdWmmEU4z+mmlaEa/iHyt9JDrWZWSDf63+oc5VjqhTd4S+BvcfYcal6yNml3a1p+HyhWLc0s/rAZ6Ai2CHXrSM2lsECN40GZ5XZBGcaT4mjsHt3kiypd2Xx1HnMs/RHfEZ+glSeftK0iyRS9Pw9Pfb/ccSRGgHXHEFGSxWApY2/e5zZjHFLu6UebPssYLzoDrSrYdkE8DK8CYg4LvgFckfXR+uBdlHtrBpSvmpCC4dz6oM59s4Ae6Ri/Imv8rqJi6W7BoHcTcwIDzV42DOF2KuoDZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKUK9hrctIObgrshgXQVxQgNm4fYSN6fwoPeoa+zR08=;
 b=cdlo0bsf0jchCetLl22S82jE+UQqv3407/E4zCvtOA3y4sJtwUadukNUmdlXNwZA0wV/es9KsPaVDcXlkxJfENq7/uoKdc/fQorL9rKi7jFchLThAa7rY2dgXnCkgAblsaX/YDp+A4xWtda6WFe1U5hAIbsTEnxDNYw674xtzsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5711.namprd12.prod.outlook.com (2603:10b6:510:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 22:44:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 22:44:52 +0000
Message-ID: <73308f34-cdfb-cf6b-a53a-2f22847757a6@amd.com>
Date: Thu, 17 Oct 2024 17:44:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 16/25] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <16d88cc4091cef1999b7ec329364e12dd0dc748d.1728495588.git.babu.moger@amd.com>
 <d0251b1b-a188-459d-a758-fe34d91ae91b@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <d0251b1b-a188-459d-a758-fe34d91ae91b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0595.namprd03.prod.outlook.com
 (2603:10b6:408:10d::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 14102fdf-81e4-4aab-6b12-08dceefd4fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNQdGRLRzhnQldLdE92aGhnNU9LTE9Pa1E0dGl0YmlReUxXcE5rU1pJWWRE?=
 =?utf-8?B?YWlqMlA1RngwemtxZ3NoNnI0Nk1IeEY3YlhTN3lCakxndzB6REtzOCtyMU5y?=
 =?utf-8?B?WFlOSlVuL3pET2ZldFNsT3laKzZkTmUvWGxOQU9QTVBwOWJ3bzJuMHA5cXRz?=
 =?utf-8?B?SlY1M0FUaFliK285V0ZwNUI0SC9UOENtZEN5aE9WejJqNFN1eVYzaGNXd2FJ?=
 =?utf-8?B?VmFiam9pMkpZTi9RdGNyVURXdC9GM2sxRmNJT3VQcUI2ZFZIN3hQcnZ6aFlW?=
 =?utf-8?B?UmNDK29yV3RCdExjbUtTM0Q3c0x4RnZsWXJBTEZzVGtuWGlMUHVDTEVwZm45?=
 =?utf-8?B?alJQc0NabnlOY3JUMDVNNSsxL2NOVU9IeE11OEF6aXZVSlBDdC82aU1abEZZ?=
 =?utf-8?B?cWc4aVVZMnVheFBRSVBjaWNMalhaUTJXSVVIUk9DUWFpdVlTVytIbVk2OEIy?=
 =?utf-8?B?RVlYU0hjZUtaNmpuNVZIeGgyYmt6NWxYd2UzSFlZWnBVbUQvNVBPbmpNOEFv?=
 =?utf-8?B?TThOeHZXcGl4YWNHTTNHWVFPZ3dIeWxqbVF2NGdGcjdJZGZnRmZMS0Jickkr?=
 =?utf-8?B?WUduOFVlU1dNVmNPdHgvRVlsRzFnVDVPOTNZa1Y2SmN6WGFyTFN1VXF1eTIy?=
 =?utf-8?B?WUhwZUpWVFc5RUpta0YvYjc0L0YxNXV6dkFVZ1FXM2NUSkxDVG1EQkszbTFV?=
 =?utf-8?B?Qk1DSHlZS1kxMTRlQS9TTksxeVFMSkoxZkh6VDBWMFdNNFM5Yk9wZm41S0Fj?=
 =?utf-8?B?NlBIS2dhdmtFZ2w5Ukh6OEZVRDVNVTljWGxuZEZ2TkZMZkxHVDNFZFlVcGRK?=
 =?utf-8?B?ZGxhTnUxNzN4QWFrOGM1UVQyb0ZXa0VsTXJ1em9nY2pEN2Q0eWlGN0pDaXBK?=
 =?utf-8?B?RTE4ZkFkcnQ0N2ozL1RsdlVqN1VNRVJKK2FVdGh4d1dQa0tDMkdBYmF5VEw3?=
 =?utf-8?B?dWtwVU5LSjBzMTVCMFUwbTR0Tmh1emV3ZFFtVTVDMHFtbFd0dC9sc05tb2xI?=
 =?utf-8?B?WCtxNVZlRFREeG9VbEJTUGkyNkZwN29FdmpEMVJKb2xiSTlyM0RHajRiUUdI?=
 =?utf-8?B?T09qb3M2SEtaaEFOVjB4Z1U5YlFKMUFtaTlPR0c1allXTkVzRVBOS0x6LzBq?=
 =?utf-8?B?cmt0VFpNSFN6cno3MmN1NlJpYkxsNjhWOGJzS1c5eHgzTUJiY2YySFBkVEtw?=
 =?utf-8?B?cE9TNFAzT0gwS0tZTTJJUVdpb3lHeS9WZ1V1RUxKa1VLclIvSTg2UjNEU1Rq?=
 =?utf-8?B?UFNwL0pha1hCUU5CSFBDeFhhY2FicFZWNXczMWJpZllMWEFkRnhyekszenhL?=
 =?utf-8?B?a21QancxblJTb21IT0NpSFVhS2loQXIxbkJ1OUZ0eHM0OEptcGtWYkN6OGp4?=
 =?utf-8?B?bjhpdUNtSjA2bm01bFNPRjd3NkJyS2hqdUZvRmRiLzVEY09ubEpkZTArMHZ3?=
 =?utf-8?B?a2pLOTVLWGtFT0pWN0xwZnNTT1BxbkIvYXJ2ZW5iZzNyK3NJTk5ndmZQaitK?=
 =?utf-8?B?dE45N1AySlljN2ozQzFYYndhZ0xubWY1WlZsc2RIbTNYdU5xM29oYVpxU0Rv?=
 =?utf-8?B?MHNXaG52L1ozSWYybEcyOUgvMDQ5bU1taXZ3Z1ZVUVk5ZnpsSzFPa1BtTWtv?=
 =?utf-8?B?enFIaWVadmZlbUFFYXI2NUN0NE5mNjVGQms0SldhejNtWFdMUlByL1dnbDRL?=
 =?utf-8?B?OStoRlFaQ3pBekdsY3BpejUzb0lmM3VuT1IwaFlaS213N2gyZUZZYjB6NHpW?=
 =?utf-8?Q?6rU1B3eUe/aq8W4LspsdWzegY5YRftkOiVstfqK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlJGN2haZEI0QWJOZXVWc01qSU1XTmVBekNaTWhsK1VFQlFjTHJVU1ZLZzcw?=
 =?utf-8?B?blJMb3VwQUlTU25NMzRMbUlqeTdMZm5aMWFXTmE5TlNYVGhmV3U0SlJVajMr?=
 =?utf-8?B?a0NtSlpCMzBBMi9UTEFVRGhsSC9JV0ZIeDVmK2JnN0lMSnpsenQ3bHdJVWpN?=
 =?utf-8?B?QlVEVDFJVG1sUlNnQWpSZFVxS0JwVkp2SElRUnJqREFMNXljZXhUNm9Mcyth?=
 =?utf-8?B?bFdVNEhPakNBakt6dWhEVVlEUSthelZzWVQybk1SYU0vWE5JNmxRSHprSnVl?=
 =?utf-8?B?YmpqUWVSTXFZTkhONXpwYTVOSTVqMGhIbXpZUzZmZTFFYnZXUFJKSDdkb0Z6?=
 =?utf-8?B?eGdtTk5KL0VzRjBhai9VVEg4VzhXQ00zRU00NGJieVR2VElPNE4xVkFXY1pB?=
 =?utf-8?B?WnRNM09GNVhaVUlZQkVzOWVlSk01bEkxS01BSUwzdnVBRTNhdTFWSUtHKzZU?=
 =?utf-8?B?RVY1M0xrek5mVUFZdWJKZXB6UTNIV09FM1IwS25ML2FmcGtYUktsUU5VK2VJ?=
 =?utf-8?B?RGlUTXZaUCtDUGdwWENHeU1ZQTd3SU9xWE1vWGtrclV5c1VpWTBpZEtROHFB?=
 =?utf-8?B?OG5mR0lxSklaenkxQUZRVzVaZFVJUlJhdkFxSWtPb2ttMUVVelloUXVXL0tk?=
 =?utf-8?B?RHJzc1RuM2loTlIrc1E1U2dtR0NPZ3BXS3c2Z0RPek9SbXFvTXRIWnJoRUE2?=
 =?utf-8?B?dVJod21WYVVxS3Yydnl6TmdvMGdJdWl5MTIyVDlsQVJIa2o3OUNTOEFHOU93?=
 =?utf-8?B?dHdrbGtBaHZHR1o3UWNkYW9CTjR4OUVxbnlqQXpMbjEyeGF6L0dNa0gxeDVz?=
 =?utf-8?B?ZGQ5ZzJ5Z0UwcnNjSXF1MDc2SE9QLzA0bUJkaXdyN1RtKzNneDJNN2JYcDcw?=
 =?utf-8?B?Vnc3ajZza3hwckkzSWxTcHg3YzlneFNGQ0UvdmNvekZkZHRDU05ZQzQ5OXB5?=
 =?utf-8?B?WFRYUDNqWUZ6c0hoMkJNQW5SdEI1bHc2bWw3WldTcCtHamtVb2U2S1cwNlI3?=
 =?utf-8?B?NVNBdjBPRG5JRFVLMk1CQWlhbmRjVmw1bGdUTzhFRmo1VXdGVVhzYVAwbzQ5?=
 =?utf-8?B?TFZyS3ZVbnp0ZXNSbHNnVjhkM0hxQVMySHliakVuQ0NrRGVoUzg2czJmRW96?=
 =?utf-8?B?cklkN3lCcVA2SXNSMTFEdS9Qb0lLays1Sk9zaTYwN0hIb1VZejdwdDh3OXlU?=
 =?utf-8?B?K2s4QUxiNmZqNlhaRU9oWDgwRlg1bkJlM1lNRkFxMUJrRWp1UitnOWNYR1B6?=
 =?utf-8?B?TCthY1ZYS2FmNUl3OXRiOXJpYTh2S0MxTGJxZDd3YkQ5L1NmUVVnOHJlQ0FO?=
 =?utf-8?B?Tnl4bXRYdEdpK3pkUFp6U2VxRXVqQU4rL3BlMW40czkzV0w2dGlGUVRtTHU3?=
 =?utf-8?B?NmJvMjlMZ1hUWHJnbVl5M0tBY3lmbCt1QytvVjRIZ1lDblZhUlhKQ0k1bFhB?=
 =?utf-8?B?bWowaEpZRUhrTGtZT2NlcVVLSDlybC9nc2RxUnB0OGpQckZCQmZOUGFzZmNq?=
 =?utf-8?B?QUh6ZUxwNjdOcjUwQlQzZ0d2dGl4SGgwcndrSEhGckp6d2h2TVBYbGpiVllB?=
 =?utf-8?B?emRNMWtqZlBjbkZ4MHNCdGNBS0oyWmYweVRQeC9XR2w4K2Y0bHBNMTBmNnVH?=
 =?utf-8?B?K0YrYTE3WmE0NlZ4NkZpQndQbjcwditRbWZwb21veDRWdVE4OWxzUjBuTkNQ?=
 =?utf-8?B?TlVxa29XdDdoOExJRUk5YXR5ckx4bzE3MTBYSDZZMDVxempiU0hYVUoycGND?=
 =?utf-8?B?d2I5VkNLdndWWWxLSldpQ25BaW5ybkZzN0VOU3V1NnlEVEdBREZscmdUeHBB?=
 =?utf-8?B?WnNyenFNNTJ2M0I3dnRYRHVyVC93ZzNFVUMzWUx1MXdya1o0VlBsMDhEdXF0?=
 =?utf-8?B?RWFvUkpxQUJqckdteW5yVnMzZGIvVjJ2aWd1bUhRc0xJRndxOXNVUmpXeTBN?=
 =?utf-8?B?WC8xLzArUXRSNk5iOTBwVG42VXN1L3BxYkZsYVp4byt0SVdPa01ZWDRHSU5r?=
 =?utf-8?B?dmZLNUZrTmMvUkhST2d4QVlybHJWcDdBVDRZS0dMNW9STkw5Y3Y1T1ZIUVQr?=
 =?utf-8?B?TllkaUFSNGdOV1B3TTkzV2ZlalRnZ1cwRThZSHF0ZE1DdmFxQjdBTXppZWJX?=
 =?utf-8?Q?bIzY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14102fdf-81e4-4aab-6b12-08dceefd4fe9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:44:52.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HvVIJjM1eomFzeu5ibczOJsMPk3vQIcjzgRewEjL+GvImkTBFKD4PSHsr30yZTa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5711

Hi Reinette,

On 10/15/2024 10:23 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/9/24 10:39 AM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>> assigned. The assigned RMID will be tracked by the hardware until the user
>> unassigns it manually.
>>
>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>> specifying the counter id, bandwidth source, and bandwidth types.
>>
>> Provide the interface to assign the counter ids to RMID.
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>      Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h |  3 ++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 ++++++++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 58298db9034f..6d4df0490186 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -705,6 +705,9 @@ int mbm_cntr_alloc(struct rdt_resource *r);
>>   void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
>>   void arch_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
>>   unsigned int mon_event_config_index_get(u32 evtid);
>> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +			     u32 cntr_id, bool assign);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 03b670b95c49..4ab1a18010c9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1853,6 +1853,51 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>   	return ret ?: nbytes;
>>   }
>>   
>> +static void resctrl_abmc_config_one_amd(void *info)
>> +{
>> +	u64 *msrval = info;
>> +
>> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
>> +}
>> +
>> +/*
>> + * Send an IPI to the domain to assign the counter to RMID, event pair.
>> + */
>> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +			     u32 cntr_id, bool assign)
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +	struct arch_mbm_state *arch_mbm;
>> +
>> +	abmc_cfg.split.cfg_en = 1;
>> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
>> +	abmc_cfg.split.cntr_id = cntr_id;
>> +	abmc_cfg.split.bw_src = rmid;
>> +
>> +	/* Update the event configuration from the domain */
>> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +		arch_mbm = &hw_dom->arch_mbm_total[rmid];
>> +	} else {
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +		arch_mbm = &hw_dom->arch_mbm_local[rmid];
>> +	}
>> +
>> +	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd,
>> +			      &abmc_cfg, 1);
>> +
>> +	/*
>> +	 * Reset the architectural state so that reading of hardware
>> +	 * counter is not considered as an overflow in next update.
>> +	 */
>> +	if (arch_mbm)
>> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>> +
> 
> More on this later, but I do believe later code can be simplified if
> reset of architectural state is done by caller. This function should
> focus on just configuring the counter.

Yes. It can be done by the caller. Need to introduce arch handler to do 
this as it accesses the arch state.

> 
>> +	return 0;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>   	{
> 
> Reinette
> 

-- 
- Babu Moger

