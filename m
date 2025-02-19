Return-Path: <linux-kernel+bounces-522177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E2A3C707
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4DC175765
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440662147EF;
	Wed, 19 Feb 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4zPtW9tm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85121F3BA6;
	Wed, 19 Feb 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988460; cv=fail; b=pFWIZXiVmCMXkc6NT/yNHtofI8O4rAweo/Tk9kIIN0mNPsmxON8Lir1m77YpRFi5gKUZp9ZQg3WkS8BSmcZpeQaEg6TMsTnJyRn+fvdUrT3RHfao+a/gZ6p8tQDNyFYNRwHei9qKx0SXaL1t5OcR/2BW/oAHI/C6kzLA3dP0LqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988460; c=relaxed/simple;
	bh=4HpEo9hH80bHLT4AfcdeSr0GyrPjxwB1Xq2tbkHcsEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYK9GEnsCQAv7UOMzG/hBv8dEjunEfr5j4vWBfVjVRJ3Xrgo4V5OUn+RkoqoO8mlqshr7532kPQqHhDdoi/OrNdHKXQREcA4QtK4VFfrc9yLBRx9k4eqFyds0QsPFNq/0Hg/+ldbbjHkKmiNxtwKXxVUS19FKDGWuT7R1Do4xh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4zPtW9tm; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXRh4mf4OgjVdfmyhtS5DwDRCeMPT6dn4lRFzyC0fZxIf+iP68aGDZJa0z8xgC0KlMAIUjXfQu2wRKnUmMauEbBQzwhAIQqvv2bmISOi3IQb2U1hcM56f69Oexv0NwLVcvmoaZZd9PYzImFPJIQVLmXv0zdRnUx8Sc5X5ICPjcN6EN3p12+04JYCbeYY9sIFY6jrK1Ao4VqyLGjj/z0XN0E0cLF5GevspAefyRRGkFpdkuF5/rQ1XI1m5a22DOOcUDHGR7s2GaG8kFjOQ0LolvAuBTPL0SpRE4876Ycmahpf+NYsUlrzod4pCPmgG/sTyoZSv6/aJJcDVy1mj+vsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZZO2vafYvxE6HdCfzDmLkueWdkvMhgKScjbqBA/p5g=;
 b=TapW8dyDDtcXlb8oJnepYiXyE/8wCHcB/FAw2PKyGbHRBXumCYE/4F7sLe0pLxw3mKeq9Ay8BIF/RTnwalUQTOQDFmOUhgZoSudXIRTU2aUyv7NXzLa3aHZzZSkbL2LvtplRK+T/wZt2UVu5/iOubWKpfYuP2g55VuSAKD5nfFajYu+XtoVSG4EDg6lSWtZ45Z1vPloUZki7z8vv0h6bry8BhTZMityGBRKnXw6zbcdhY+Fcmw9vj77H6Dif3DY/JWy/dE71EQ6R3DnqQ7sPdK7bSiY8Pstz9REg1N69a9bf3zKpoxZoRmDz6QyhEhkO49JAGVKq7W53witC76wuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZZO2vafYvxE6HdCfzDmLkueWdkvMhgKScjbqBA/p5g=;
 b=4zPtW9tmwG4XyH6b+c0WaLdNSug1zP0py8yrcdksEzFeO3pymKP9qCcIoZx6z492b/cKVcemb/j7RhYkfZVgKmucJU0rG/+3y/Y+P6yUecCd9iP0IiTSMwp7vmmkz/DK8xszKQ3sbiWGrI1beV+VUtyk5Fz8SdRd4eim8MW9fFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 19 Feb
 2025 18:07:32 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%2]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 18:07:31 +0000
Message-ID: <21c911af-d396-411a-abdf-f72dd96d92c0@amd.com>
Date: Wed, 19 Feb 2025 12:07:30 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 11/23] x86/resctrl: Introduce mbm_cntr_cfg to track
 assignable counters at domain
To: Dave Martin <Dave.Martin@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <bmoger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <30652061d4a21eb5952a1323b76ca70927412a30.1737577229.git.babu.moger@amd.com>
 <b88868e1-52b2-4a66-bec2-e0846394b74b@intel.com>
 <7375cacc-5800-487c-bd8a-7ea11e694598@amd.com>
 <2f1d5857-7f32-4bde-9b12-77fb2b4464da@intel.com>
 <Z7Xc7Oxm9ByWhIEy@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z7Xc7Oxm9ByWhIEy@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::34) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: a94ca559-8907-4568-b80e-08dd51104768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmF6ZjJHTXZqMHJkWDMzeWR5emQxeEJ4anQvY0hDT01TME84R1JBZWRrcnJE?=
 =?utf-8?B?b0R0U0IxVGF3SjR4NlFWTTFtZHkzYUZ3SzNrWlE1STNRSkh5Zi9kQWVVbGgx?=
 =?utf-8?B?d255czlGNjk0WTJieVZDekZ3b04zaTBDY3g5ZFR5NmgxQjIxRktCOVlaVmFu?=
 =?utf-8?B?QVpBYWFIYUtxNWNvbVpFVVJjbE0xalYzallYb2hZUjhFYnNXWjdxdGV2Tkxo?=
 =?utf-8?B?Q1AwVnAyUy9QV0djQm5ZbTAzbUp0Y2FQdzlyNnVub1BJdVI5TEJZZG1OWXFV?=
 =?utf-8?B?VjcwaFNETGltT0hrOGNKc003QW9wR3dEMGkrS2Y1VWRycU5weWt6QkJmKzMv?=
 =?utf-8?B?T0RwWFIzZjBKdGpzRW1RSmNGQU5NUlFQSDlPcyt1bEE5ZUNEdkIwUEhOZEpP?=
 =?utf-8?B?Q05tWVc5cTAvTkFFd0RudUVVT3FuWXRBMWdIKytSbE8ram5KeXhCcWtKQjEw?=
 =?utf-8?B?SzRvWnErR3ZwS2lKeER4dHRENVJjSmwrdi9LVVdBQTN0R1lRd3hCb3BOR1Yz?=
 =?utf-8?B?NkZDUzJkakxZaXcrVGc5TVVYSWNWRVpTWXJ3TGVUWmJSdjhUVEN6UHZIM2hx?=
 =?utf-8?B?YTg1KytDdkhmVnpXN0lIQ3Y0dkxSU2VvM3pCTWIzNVJoZGNxeS9KdERSb2JQ?=
 =?utf-8?B?eDVlczhtR1ROcWZpN3YrNytXOGoyZWRRckFxU0tSbkp1RXJ6azR5cGhSVHRy?=
 =?utf-8?B?NmlNT0QxZFliVm4rN1B0NzFrMkNSWURrVjFER3BVK3g4QzdxRlFkL1YvRGJr?=
 =?utf-8?B?c3d4bnFwbUVCTlMyLzBGZ1ZQMmtocmxmQ2pQRGF0UGptQnIrdVZteHBFekdr?=
 =?utf-8?B?ZjlEeEFQRUtFMktJK0dQSzFodG13dWJxbGFJTk9hZy9KaVFhYTdTVTVja2JB?=
 =?utf-8?B?b1FvQlRJSWhBNU5MVktsUjZCOGlDcjRDMmJZRElsUDQrU280dmY1dSt2RGxt?=
 =?utf-8?B?MURMY0NoQjZLeG5mWXJvMURxMCt0UWRmWFdXTk5FUWZvcFF6L1JQT09na1Y5?=
 =?utf-8?B?U1BCWlVaNW0xSElNMTBQMmZZSVNVRDM4cytsTzU5bkVwM2FCYTk5emdZUzUv?=
 =?utf-8?B?clJJUUUvNm5JUWsyZStNMVUyeWxrT0FoTHFmbGpnMzk5STh5Tm9YWHd6b29S?=
 =?utf-8?B?Rk5RdWlOazEzaDZjMmMxRGcxR2szSmEyMmgxMVQ1VVVGSUxMY0xJMlU0bTZ0?=
 =?utf-8?B?SHUrMDNoeW5tdzZuUFpVSEtSbk9KVUJ6dEtBbUl6am1sYjdQZVdQNGdIcnlU?=
 =?utf-8?B?aEFDZWlaZ29kYUp3VlI2UFFnbzYyS0ZSVG5jTlNIQXo3cE9vSGxGQU1rR016?=
 =?utf-8?B?RXkwc0NzTUdMT1U1NiszZ2VvUHlSSWFLaldjakVvRnpLaVZMTDIxaGpCL0Nt?=
 =?utf-8?B?cGlrSjBCYXZOK01MUzNBdm9aSzMyYlZhVmRMaFBTZFEvMGVUaDdDNm82V0JS?=
 =?utf-8?B?cDA0UTRmOTNoeDJMZ2dNUWhIUTRxd2t3VHgxZy8yT1hXbWg2OEErb3lkYmFL?=
 =?utf-8?B?M0lTOFEyTjl5MUY4M3ZOTVpINTByY2RmQUdtRmQ4cit2Wk5RQWYvcXJVamc4?=
 =?utf-8?B?R1pvdy9mOW5FdTV5UjYvZjZFSHZLVWpaVVhVVWJCUGx6dURLb2p5TndmQW9r?=
 =?utf-8?B?eVNSU0F2QzA2Q0ZnZ28xdWxNckNXZlptcGkrY3l1Ukl4aG5QNUtONzdWclBp?=
 =?utf-8?B?OWpKdFNRZStFdkErdEFQUmRVK1ljc1pVbENKYk41eVRlRTlTZmd0ZEtSNmJr?=
 =?utf-8?B?SHVCUXVXdEFjRkZOdFVlanFWUVpyenZ1MXcrQ3Zkem51M3RKa3FqV3VndC9R?=
 =?utf-8?B?TTNnTkNRSHFyT0xSbzkyQzc2SWpuQXljWW9UOHpxSi9OWlNwTmNwd0ZhMzRZ?=
 =?utf-8?Q?hi/8L1OLYm68t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm4rUTJsMm5mcEpzcjB1UTF5RkovbFliSDBaeXRiOC9XMGJ1SkkzQlIraC9H?=
 =?utf-8?B?RWYwMElmcjlyeHlzUjJ3TEVjL1RaUXlHQXNEakp2Nzl6dStTUlJoUzdsZDRh?=
 =?utf-8?B?anlNZ3RPS0lpaHpnak51dEVqL1hsVUJoNitSLy9iT1laeGNnSVowa3RJbWdI?=
 =?utf-8?B?SlVwT3VySnB0bzJvaTVaZkF5QnBpMTE0ZGI4dFJhK3hxS1o3d2E2SVpOblho?=
 =?utf-8?B?dGRmYmhudjF0a2V5K1NhakpmRVYwdU51OGxiRVZ5T3p3cmprM1dacjhFUkhW?=
 =?utf-8?B?SnZyaFhLNnZTYmdwc1E1SjdBOW4zWG1JN3BmYnIreWR0emRQbkpvSUhIV085?=
 =?utf-8?B?YjRuR04yV09VR2l6Wi93ZnN3dzltbDlPam5xV0tUZjJEbm9TNkRRWm15Z0lY?=
 =?utf-8?B?eTdqbWMvL1ZoaUYrMExkWWc0cXNMWWJoWFJIVGdmM0M1alJ2cTRkby9ka0dj?=
 =?utf-8?B?aEtuZ0NJTXIrZnRSZ1BhT1J3VG1BYlJGM0dVckQ1WFdZZ0hqVDQyVkswUUJk?=
 =?utf-8?B?OG9scWZ3N1lscXlHcWJqTXJZcDlJOXdxSEQvRHhNS1NzV2g1d0xVbGV6dDZL?=
 =?utf-8?B?WFd3K0JQRHppbVZLdGJ3Qkl5WWNHY1FDQ2ZlRFlqdU1VdkRLSndvVmo5ZVlP?=
 =?utf-8?B?RUIxb2JnaGNRME1aNDBwQkI1SEtDY3pBMW94YnVVZTZJN3c5dVdscTZnMVJH?=
 =?utf-8?B?eUtJTTRDSUU3MUR6UkJFeG01VGE1NWdzZXlnajFZazFueXdrQ0lWaHNadW5F?=
 =?utf-8?B?bE9RY1J0UVpEdjhMczRBZ3BtN2s0aUhqY09vODJaVUZGTVFJdDNrVlJUYU5T?=
 =?utf-8?B?alozZk53a2JLamkvWXFFdEJNVklIbHorMzhSWVM2ejBib1ljK3RhTzl6R1Qw?=
 =?utf-8?B?SkJOS3BObW1ESEpkRVdGa2FnRC9JYTJaTVViL3RLMDNac3NYU0NNM1A0enhU?=
 =?utf-8?B?Q0tDOWliRjNGS1NURzlrTUhpYkxEeitjL1JaemdrOXdUWDdjNkRvajdNcHJt?=
 =?utf-8?B?ZG1WbHgwNWlCL0U1MEp0bDVhYVFsTGtlRzhyZ09rM2VVUjBTOEszY0FPdzZi?=
 =?utf-8?B?cVZlTkVmNmRMTzE3czdlWG5qVlR0dGhMQnlWMjlkQUJFTlpxWitsTmZpOXBR?=
 =?utf-8?B?Q1FieWZOVmRvSkhucW14MjdsOUVZcDlvUWtXRDM5UnByaGllcHpzUkxXSExm?=
 =?utf-8?B?THVnUWxGYnp3bTkyOUdxVUh5QlNnM0NFTURWQlRlYk5tZUtXNytHMjk3Z2dt?=
 =?utf-8?B?bitiR0ljSXp4YnJpY3FZQkY2bnFyTmVtd2VIeGpxOGlOMlJiNUJIL0Zndkd4?=
 =?utf-8?B?NHdZNitPUDEvZ0t0Nkt2NmV0ekRzVkFNK29oVFRQWFg3NVdsZ3k0akZrSHF5?=
 =?utf-8?B?TU9YQVY2VTNCNE1ROEhEYjY2eVpVK2duUi9jNk0yRmJyb1BibFlTQWdtVmNK?=
 =?utf-8?B?RnpYaTRhNUFIWUpjZGZBeEJqTHZnVTNTRVRrUnhNcjUwaEhoYjg3YkljZStI?=
 =?utf-8?B?VXVjYWZxVTkrQXhFeXQ4NzkzMUpMVGIwNjg3YlVuTEZhc3RmSDVaNGlEbFhs?=
 =?utf-8?B?cEZ6MDNSa0hPR01TRXBwV3o1VmxvYjdXRlhMaWRsay9aU2pOM1l1UlVESTRq?=
 =?utf-8?B?TnNoTHA3cmxSVzNhVmZ4NlRsVjlKRCtjdk5mK212TG1ZcjJSQnh1NDB0dWtQ?=
 =?utf-8?B?d1UwdmV5b0JJRkVwQmxkQ1phb3huSW1WQnYxc09PN1hEaklGVWRwN0NJRS9K?=
 =?utf-8?B?NDdnWG03YXdONnQ2alZxWmVjNFMxN3U1Ylg1SmZKNWF3cHdRRG13RGhJNU52?=
 =?utf-8?B?MmRwMzdia0UvT3k0L2ZkbzNUTE95VHIwZ05KUDhWVjJvQ0FyR0JRdU95eFdl?=
 =?utf-8?B?a1k5N2xiRzR0aythN1FFOTZLMHpSZWxMMUdrL3VYNEljWDh2Mko3ZENDR0xQ?=
 =?utf-8?B?RkZrTnRqaWdMY2RtbWEwU25GaU44bjdpRnkrZy9aM3BUS2M4a3VuQ3d6NERT?=
 =?utf-8?B?UVNIZE1WZnlJT0ZuZkhiVUhuUTVNNDcwU0t4ZmppbXhtMjNEaXdza21ERUlW?=
 =?utf-8?B?eWlZenRLamZiUEFrczU3NitvM0UxcHhDMTBPMEdkemUwRHRCbXpLd0k2N3I1?=
 =?utf-8?Q?vXbw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94ca559-8907-4568-b80e-08dd51104768
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 18:07:31.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8awKzDXcNk1qGYPkRF8oWFL5PMGEU7OZm5zOIBTTbwBwjkCqTnfmf/fCJsh715jO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

Hi Dave,

On 2/19/25 07:30, Dave Martin wrote:
> Hi,
> 
> On Mon, Feb 10, 2025 at 10:10:26AM -0800, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 2/7/25 10:23 AM, Moger, Babu wrote:
>>> On 2/5/2025 5:57 PM, Reinette Chatre wrote:
>>>> On 1/22/25 12:20 PM, Babu Moger wrote:
> 
> [...]
> 
>>>>> MBM events of a monitoring group is tracked by hardware. Such queries
>>>>> are acceptable because of a very small number of assignable counters.
>>>>
>>>> It is not obvious what "very small number" means. Is it possible to give
>>>> a range to help reader understand the motivation?
>>>
>>> How about?
>>>
>>> MBM events of a monitoring group is tracked by hardware. Such queries
>>> are acceptable because of a very small number of assignable counters(32 to 64).
>>
>> Yes, thank you. This helps to understand the claim.
>>
>> Reinette
> 
> Do these queries only happen when userspace reads an mbm_assign_control
> file?

Yes. All these queries are initiated by userspace in the form of
individual assignments or creating a group(mkdir).

> 
> It might be worth documenting somewhere that writing and (especially)
> reading an mbm_assign_control file is not intended to be super-fast.


We can drop the last sentence if it is creating confusion.

> 
> It feels like userspace should not generally rely on reading
> mbm_assign_control files except for diagnostic purposes, or occasional
> read-modify-write transformations.  Or do expect some other usage model
> that makes this a hotter path?
> 
> Cheers
> ---Dave

Our earlier interface was intended to query each group separately. After
the input from Peter, we changed it to batched query. One query from
userspace can list all the assignments. I am not aware of any other usage
model.
-- 
Thanks
Babu Moger

