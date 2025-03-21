Return-Path: <linux-kernel+bounces-572066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3786A6C617
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518EF189E9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFAF22B8AA;
	Fri, 21 Mar 2025 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alIjcNTV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A128E7;
	Fri, 21 Mar 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597495; cv=fail; b=S+f9eE/fG+grPiEu4BrYq17Rq616ZEPoJelVQZDS+6yl6+u3X+V4zuFnnPNogu4DZdT72My+2vPL66JYNdPnFdq/RLX4llN77URBOlGW49w/PiIt2H8AM8JmLqkov42CLpO8PVfMYGOmTuVOJCeAWXS84OOnaODDBQ/4H1ohO0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597495; c=relaxed/simple;
	bh=V/tC2nQMqm6TisP+G7eTdyHhuddPR9agusI/hfSflsc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MyaXn2Pfqh3k/b/p1gqYF8gM5dnsc50hd85wHlqL+Z3xxpRJ410BnBSK8017XyZYKBrSqqn83VWrqzORVhaVDo30ZhJUQHWEckco/FO1E4VC2bPgPtGXvr4fFL6cJ2RIean5n7CWl7ifQ88gTK7bY1HxuzTyPZPsqwQtXfGfiEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alIjcNTV; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742597494; x=1774133494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V/tC2nQMqm6TisP+G7eTdyHhuddPR9agusI/hfSflsc=;
  b=alIjcNTVrW10FNtud6bJ9LoiS0B56Ov3LzGj5cEdUexXyh5GANagMO0a
   cJJowshXmSqUInLQ1D8qiQA7oszNSuNREJcRhumTLKRzrPTNFC5GQ/5zd
   nbELq2h+IqGr/4wo7MSAjcKPRVwde5YlzI2VP4tskSuUkVJDu6Rm6SPzB
   AaHHqcBK4Bo/bv1M4nwdEiQFupMCjE/MiObDKv/rGkPXv1OfOMaAGgfWJ
   U9bMmwLHUOW9ZpcT69NtUWvugR2F9Mi/3lkBeoSNDXICRMmg5UHX57zxN
   dUs3Bm3h2jBOnf5EhCDEhj6Ef7od88NWjTzpvPghLrMBna3SgR0P1Qtvc
   A==;
X-CSE-ConnectionGUID: KvSnWFMVS1mZAb94s/Qmsw==
X-CSE-MsgGUID: +HpaqXC3QLCRBamrnbKq+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44037852"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="44037852"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:51:33 -0700
X-CSE-ConnectionGUID: lrZ8+OmyQKyoLeRP3nnJjw==
X-CSE-MsgGUID: TuZVLvFVQYGBINpl70f2XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="154420469"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:51:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 15:51:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 15:51:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 15:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEeFiqOj1EUIKr3C0qH6g+wMwqllHo98Hv54h9qwHqIBtGRstNXH/pXrqPby1EsBpzZ536hdNnfYEVa7dtgWQVUYC2LkJvsNiYNSw3+lkngousPDNZjmdF2eqsgOlGZWqQy7Db50VFUS9kdOuVaY4QrLyMRoh/VNaWAA+5fGZrVCsC6fH9U9gH+WXVRpvpqcdwqttah8QSJAVx5uNjm7n9z1aUfC8n9DMjxCN5k9yFU94nLwpv7ZmnVxgdecy7mw92Mmfl/8AHZr2fSGMoFtoHO/Ds585QUxDfqANJY7SxtNg+78sRXjWrK8CSFi5dtMHmT2EEh3TkT4XClqRpp+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmsW24u8O8YZVuYGdTY+paR5dnAGoNBioBrD8P/IEU8=;
 b=saQJqrHcqSojiOfOBmR8msaChgRC8OW+wW8Q/4YABZps6t6S6O+41vX++m6ij/+QcDgngjDEX4rHYeyzH+beUPkZGOZflyKFrQx/vjZVbQB68l3R5kWOh14NLk4VdHXaUFkyWpusGk6+M+sfHnDL/9cwx1vG/uFRNs0+RUy/svFcg1GlHPX6JOPAdcXwuFTyHPsjMkPJHWzzRMMi855mLKdAaESdINsov/CGTFyt/NHoSI96ir784OXYIE8EVTbzsij09B6VCNIs3N9dO/LiDC7U6nEsOrKgui0K7CI8LS1LF5wSo8tCI/W922JDBXBX36VdJz4wiwi0vX9+EK8sNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 22:51:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:51:29 +0000
Message-ID: <fff9df3e-34ae-4aa0-8847-130a4ffd8fcf@intel.com>
Date: Fri, 21 Mar 2025 15:51:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] x86/resctrl: Detect io_alloc feature
To: Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<jpoimboe@kernel.org>, <daniel.sneddon@linux.intel.com>,
	<thomas.lendacky@amd.com>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <peternewman@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <corbet@lwn.net>
References: <cover.1738272037.git.babu.moger@amd.com>
 <3c07cd3fb7963320819e555086f701f125b55f4d.1738272037.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <3c07cd3fb7963320819e555086f701f125b55f4d.1738272037.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: ed276239-5fdb-4e51-ab6c-08dd68caeb09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnFTcWM0MzFrR3M5NjdSWnBFUGp2QWp6YnZoMXA3VnhIcnNwaEFnNnNsMXBr?=
 =?utf-8?B?QldXa0tZb1pDUUdqQ3UrZWFrLytyRndXL2lFN3dLemxHL3MwSmpOZ1dRTkZz?=
 =?utf-8?B?NlVoWnFUSW13ODRGUXdWNXNoZTRzR3pjeEdzeHpLQmlyOUNtTzErejhqTnpt?=
 =?utf-8?B?bTAxbnEwcjUxcm5rUDlYN3FnbnVPZy84WmJSeGtTQXdxSVhFSnd5TFV1a01T?=
 =?utf-8?B?emo4UFNFMkZpZm5lcGxRdGhaQnpvMGN2Uy9ybXkra0Fua3YwbTZSRW52VnU0?=
 =?utf-8?B?N3RGTThzV1hCU0tBc1M1MG1rcmFCUFlHekQyWDBhVkxuaHRVNU04dGNrWUF1?=
 =?utf-8?B?OGFOMVplSXpRRU13eVBxUkY1ODNMd3VrL3J4Rm5RNVRCMXZrb3VxQS94cFQ1?=
 =?utf-8?B?RXJpMFhXRmN2ajVVYzcvb0o5VnFKMDhPUTB6REhoWmlVM0lVVXJtRFFHTWgy?=
 =?utf-8?B?MnE3MjJFSmRWM0pBY1ZabjFpaDZObWFrTjBjMVNqcThuSXdXOEVlWHI0Q0Rt?=
 =?utf-8?B?bW90c3hnWW4yeW9uV0ZLNGU3OUovaHVmUU9HTmVLSHdsV0JlRE5HVGRZR2FO?=
 =?utf-8?B?cDZkVTJjMW9Ga1BqbVhBUXNLY1RiZVhRc0lkUkE1cVdsM04yQkJmOG5RcEZ1?=
 =?utf-8?B?L1VQNUlseVkyN09kcDg4eTgrUXJ4dkt4L09zc2pFRkZYWExPbCtiZWhnQWRT?=
 =?utf-8?B?cXdHMUFqcUx6a2IwVmE0REJDMG03S1IvdUlWUjkxNmdJKzNOekJnbzBBNVgy?=
 =?utf-8?B?bGJveUhXbktSV1RKSUZQL00vZ2QzUEJKVWhINld2bEpadjA1WjRsUUlUd2lr?=
 =?utf-8?B?UEdNNCt1Q1NBcHcvaTFBLzFZaERRZVVXWTY1WklqbzJkdzdqMmVEMFZSSENz?=
 =?utf-8?B?V05ReTA1TFlMdVdJWmFGWXg2amViUWZaK2hoYko0eFQwWXBDUjhCNXlkcE0y?=
 =?utf-8?B?QWVRY0REeUFzc2ZCekdPNEtIbkltaEZLWWdXbFpuVE5tTUgxbTVTUmRVeVF2?=
 =?utf-8?B?TEdLKzhQZUZiZHU4enpyUkR2UnM0YndReHhiTjRYV0RhdHd4NlVBVzk3ZnN1?=
 =?utf-8?B?WUZvU04ya2E2b2RLOVgwaGZkY2F3K05lTzl4L3VjMXdJbFVTdE1rZnhWZ3Zz?=
 =?utf-8?B?S0c5SnBGcEhpMkpSWXZmRkFnL2NEakwvUGtsNEFYWkJjUk0wbk5TQ3kyZzY5?=
 =?utf-8?B?MzdQa0JGa2NmcWM4YmZnVjhBZXFoa3BYTWVidzA5SXBWQ0lCR0NaV1hQMmF3?=
 =?utf-8?B?QnpYNXhZaHB4OVNHdHBKY1Rkcng4ZXl6UXVQYTA4V2tNeEZiOE9PYkowWlNy?=
 =?utf-8?B?bFAwZFZMdXRvcjZpWURuMW0yR3VWb1ZyakdhTVhFYnBwWmg3c2s5TDRFeFlk?=
 =?utf-8?B?LzlXTEhCeldhQ0M3RW5aME1aa2R6bUQ3WjJVQWxMNmh4YnVpaWdUbVUrVTVm?=
 =?utf-8?B?c1hpTXJDNUtCem53RFd1VTFya0ZBMFNobXpOSmVRODY2L2Ftc04rTGlFRzA1?=
 =?utf-8?B?aDB2WDJYWi9LK2JtYm9SU2lJeHVCYWppV00zMEhGWGZmZE41ZnJIWGdKREpy?=
 =?utf-8?B?Mk1CMUtOUWkxNVJrS1ZTd0ZIbjJybVQrdU5nSEJNTFNSL3p4cGZ3eHU5NHF1?=
 =?utf-8?B?SllPQUxyNytjWG8rZUYxekZvTnlyRWVVT1ZZb1R3S1owRm14eElmL3lhRkJC?=
 =?utf-8?B?ZzR3NytVbWFPMWVNZGVZRk1NNW1mRHh1eDFuT1FNTFpqRUlPSnJXV3JDaWs5?=
 =?utf-8?B?NkFURk13RXl5VllVMzVpRlF0cmJ6cmR2Skp2b2RaV0FYaFA0cEpOc2hWcDJJ?=
 =?utf-8?B?T2VIejU4NVNuVEhSK0Y4MzZlVXFsK1VKS25nMExBSStEdWZCZzJtM3QxS0lF?=
 =?utf-8?Q?xfwCL5H8Ht8JE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHp0MlE3aXNFeFp6L2FTK0FIVEgyaUV3RittRGVmL3hWN0t3TDZFaGRIeFBm?=
 =?utf-8?B?UUdQcGJOQnRTL3g4TUxBNm9FTm5RclkrQldUekI0a05Wdkt0eGxWL00wQ1dF?=
 =?utf-8?B?QjM4UlRQRUkxNHo2QWRkV1dZdGRFK0t4MzBJQ3RpVUpBSUZZQ1FTeFR2SGpG?=
 =?utf-8?B?clA0VU5yL1IrcXJCZU5VRWc0aGN2Z0pZVC9YcmpGZDhKQzBVSkQ2VG1SdHAw?=
 =?utf-8?B?Yk5FLzhUSFUwWVBEdEJpUzJhWDhBRjZvTWdGdEM3TXVIWTZpNnRDa0lsKyt6?=
 =?utf-8?B?TWdTb3NBVFBzcUdGZ25FMzlVWktmZXkvYVVCUWNSbUgyb3dtNlU4SXZWd0hF?=
 =?utf-8?B?bVl4UGc5aURDdnAxODFob1IvZVRwS29aanYrQThuVjhTNE10UllmR3BkK05S?=
 =?utf-8?B?dmhpNTUrMTRUMk9aM3V2NU5Cb2tXQS9xOXpRa3p5NE9vMXhZOXFQS3dkdi9h?=
 =?utf-8?B?NXhHd1F1Y2ZKY2kvd3hyblVjRkZYcWVzNTN0b2JjdXZ5cEFxN2RJbWhyZ2xU?=
 =?utf-8?B?cWFNeEc3UTRpUGYrUHYyZlpEQ3pQNlRhZEFIbEppL1IyZVg1QzVrczhXeVUw?=
 =?utf-8?B?VW5nUkxGeWUzbVZaRWlLWHdhbHl4ZEVSSjJXampuVW1JdG1UL0VtRVNFOGo2?=
 =?utf-8?B?SGE1QWk4aSsrUitJYjkwNHQ3SHp4bmxscGIxWGJPS0xIS2RlZjlMQkVUamFU?=
 =?utf-8?B?MzAyK1h6OFM2amw4NDJpNmZQNlhZQ0p3MDhUamQ4SU5CSDBnekdaT2RYRGlO?=
 =?utf-8?B?d0RTVEU3UnhFQjdQYkNod2xIWjdGQit2VWlHWXd6Q3Jna2R2ekg5V2hjZEVv?=
 =?utf-8?B?WkQ2a0JEM2Z0cFRaZjdVZ2V4Ti9CLzgxR3ZOVWlkaUNnek9BYkYyL1RLbEx1?=
 =?utf-8?B?bStBTERtMzkvS1ROelFRQnR4R3I5dTE5c2hLWVhUQnJyTUd2REg1eVppeWM1?=
 =?utf-8?B?NnZ6UFFaU1ZDSjV3V3lmeEl1WCtnZEN6dVZnUjE3dVIrNTFUbTR6N1lrYlB4?=
 =?utf-8?B?VzRXT0k3NklLelVQdWlCWXphcnBIVFg5MERhd0pCeUVFMWxZaEh6Ym8xeTBz?=
 =?utf-8?B?dHY5b1U1WTRUbUdhZFpiSGRHN3kzSHU2TkZhTnZlSzM1ejBzR1hHa3llN243?=
 =?utf-8?B?MTBBaDBOV2xGbitITndTcHhxODFFVWJKMERLVWhvU2ZTdHpaUEJGQUd2eEF6?=
 =?utf-8?B?K0twK01mS2pwZkpVak54VDlpZXc4ZE5KbmhydG5UeDZLOVdCZ1pFYU1VTkwx?=
 =?utf-8?B?WUdjVUlvR1g1NldUQTZoQllIUFBMZ3A2d25GMTlzb3Z2WTl0K3lramVOYTVu?=
 =?utf-8?B?aFVoUmdYM2sxYkpMOWdWb2w5WUo4RzBzclMvQ2FhcU5JNkFZV012WkdsY3Fi?=
 =?utf-8?B?ajF6bGhQMVp4L2FndE1uM1l3K2pXZjFYWmdUZnRKRmd6cWpVc2NLZkE4RGcr?=
 =?utf-8?B?djlkdjJ2UThydjJ2elA4dGxsc3JVVnViTEtPLzZZbzRhRnNQTE1mWHFjMFJV?=
 =?utf-8?B?eTdsVy9uU2VDQ3JQdWRIdFArMjFURzFhOXFaY0UxdUhBajVLc1NOaEkyNm1E?=
 =?utf-8?B?MXRPV095cjZITzhrYTd6WDJ4V0hsZU5nZXBidDRrQ1ZpQVJWNFI2Zkw1bW5u?=
 =?utf-8?B?ZExJdWlRaDRML01nYVpmb2ZPL0Q0eWplOEdjNk1oVjVhb1lxQTZheFk3V1N4?=
 =?utf-8?B?dktvdzVyc2k4UTJkcDZ0ZENQcjZoTlhtbVJKVE5reFQvQytpR2hna0QvVUda?=
 =?utf-8?B?VmdwcVFRL0pYdWlWdENjS29LZ3Q4VDJhZUhSbCtWam9JRzkvZmNnNC9qZFhR?=
 =?utf-8?B?WXh4eGdlMWR2MzNzdDRUL3hQZlBYZ21DS0IwSVVYYks0UnJBZldBdWdESmxa?=
 =?utf-8?B?bTZ0aklidEEzVDF1YXBFU0c2cmpMZi9DUzlDV25adTY1VkFxVHUrWUJDeXpD?=
 =?utf-8?B?ZHZjS3pSYkNLbTgxSkhEZ29qMzlmUUJ5czU1a3diWmZGYWpBVWtHRDh1WW5F?=
 =?utf-8?B?NkJGelRQMHgyZFZqNXhRY0tROEhoSXRLQS9oZE9EdnQwaVJvQXA2dzZkbHU5?=
 =?utf-8?B?Z1F2VlhjUVIza2MyMEV6WUVqUTkxQVRlWmxPbEk5TUc0RHV6K0xCVlVkR1BY?=
 =?utf-8?B?aGxHU0p2TkxBMUpmdnZKeGhSZHZ0UEcwSW4zVkF4MmZpeWVNMk9udERKaEhU?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed276239-5fdb-4e51-ab6c-08dd68caeb09
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:51:29.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGiD+98wDrJuMvLg8VtLKWlydcATt+GxlyWrGDX7E/8aeRL+O5vYGSdzJxX5dH7I+/g5R1Y3Gwm8uno3vc8jo3SBEIEwBV7LUY9m98Ovmls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

Hi Babu,

On 1/30/25 1:20 PM, Babu Moger wrote:
> "io_alloc" feature is a mechanism that enables direct insertion of data
> from I/O devices into the L3 cache. By directly caching data from I/O
> devices rather than first storing the I/O data in DRAM, feature reduces
> the demands on DRAM bandwidth and reduces latency to the processor
> consuming the I/O data.

This provides good context but the changelog does not mention what this patch
does.

An idea to get started (please improve):
	Data from I/O devices can be inserted directly into L3 cache. This
	reduces demands on DRAM bandwidth and reduces latency to the processor                  
	consuming the I/O data.                                                         
                                                                                
	Introduce cache resource property "io_alloc_capable" that an                    
	architecture can set if a portion of the L3 cache can be allocated              
	for I/O traffic. Set this property on x86 systems that support SDCIAE.  

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: Rewrote commit log. Changed the text to bit generic than the AMD specific.
>     Renamed the rdt_get_sdciae_alloc_cfg() to rdt_set_io_alloc_capable().
>     Removed leftover comment from v2.
> 
> v2: Changed sdciae_capable to io_alloc_capable to make it generic feature.
>     Also moved the io_alloc_capable in struct resctrl_cache.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 7 +++++++
>  include/linux/resctrl.h            | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index c2450cd52511..1ebdb2dcc009 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -306,6 +306,11 @@ static void rdt_get_cdp_config(int level)
>  	rdt_resources_all[level].r_resctrl.cdp_capable = true;
>  }
>  
> +static void rdt_set_io_alloc_capable(struct rdt_resource *r)
> +{
> +	r->cache.io_alloc_capable = true;
> +}
> +
>  static void rdt_get_cdp_l3_config(void)
>  {
>  	rdt_get_cdp_config(RDT_RESOURCE_L3);
> @@ -931,6 +936,8 @@ static __init bool get_rdt_alloc_resources(void)
>  		rdt_get_cache_alloc_cfg(1, r);
>  		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
>  			rdt_get_cdp_l3_config();
> +		if (rdt_cpu_has(X86_FEATURE_SDCIAE))
> +			rdt_set_io_alloc_capable(r);
>  		ret = true;
>  	}
>  	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index d94abba1c716..dbe6461f3fbc 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -129,6 +129,8 @@ struct rdt_mon_domain {
>   * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
>   * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
>   *				level has CPU scope.
> + * @io_alloc_capable:	True if portion of the L3 cache can be allocated
> + *			for I/O traffic.

Enforcing that this should be for L3 cache is confusing. On a system with
L3 and L2 cache resources each resource will be described by the properties in
struct resctrl_cache for particular resource. We do not want to set "io_alloc_capable"
to true in the L2's struct if the L3 cache supports this feature.

This can just be: "True if portion of the cache can be allocated for I/O traffic"


>   */
>  struct resctrl_cache {
>  	unsigned int	cbm_len;
> @@ -136,6 +138,7 @@ struct resctrl_cache {
>  	unsigned int	shareable_bits;
>  	bool		arch_has_sparse_bitmasks;
>  	bool		arch_has_per_cpu_cfg;
> +	bool		io_alloc_capable;
>  };
>  
>  /**

Reinette

