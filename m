Return-Path: <linux-kernel+bounces-431803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FDB9E419F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73A016237C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B730422A542;
	Wed,  4 Dec 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/71zMS3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5B229B00;
	Wed,  4 Dec 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331811; cv=fail; b=eGIgualBI+5zEF1VwBGXmxQ3yFAT7TVCE+teQJNsKXkym8orDhvw5cZFn7P3ybpLfyf2OlUM1wwQfBoO/O7HGaHSW//eTqOmpeXKOT7zSCo5sg+hRAocrn82bBlqCXLrhgSVTbViHvnJsVQi6TSoatGbqLhkN5AgG1k9sa+gRXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331811; c=relaxed/simple;
	bh=yen6HRlGW9NNke6vBGQdK8M2VZ5Qu7ajERmMOP/2t3g=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRwAtbLulP0jjkgFz2Jg1Lt9L2T2RbXerup5pm/l29v1MURbKTCKT76f7qOnO/1SGH/+OzAF0mrJ2KtOl9UR12nceIM0wEX2roqbJudALWgZE4bbRcAlBKHPyHh+xmKg8g08R0iIW8yHM3ZpvAMLaoV72wGikYgzgLuuBNhhjOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/71zMS3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733331809; x=1764867809;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yen6HRlGW9NNke6vBGQdK8M2VZ5Qu7ajERmMOP/2t3g=;
  b=K/71zMS3V8/50/G4Dt+Frx1fpfem5b9c/TAuPMBnXWu4Ip2Z7jXYlp3Z
   UwnclulyGu6GrXNtLk+k8tNrjvF9gzqyStYbdEccjyhBhzNJOpvI+kIzW
   Tyk4MfuBsV4qTK0qnAarGb84L/M894w2rFRPady1FZ5RE+cVOH8biZwvc
   hDPVdMkt1xG6V6J89ZAA6vq2aEevlMF+OU9gKQBQ5theqNGH8sYPiIdaB
   gLFJUUKyR4y4tWp+paAFnb5KI3bVSptrw3vZXsk6nbFpLlplCG7xq8dmN
   HQqH1KwKTXzhW0/zU3EJz9b/UX0t/A1cZYo5kq0a46nSmyIVyfV1ejw4O
   Q==;
X-CSE-ConnectionGUID: 1SBWX9NRQJiem2SGb83T6g==
X-CSE-MsgGUID: tE5s/9oeSsGFwBG7k5JGAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44220276"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44220276"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 09:03:23 -0800
X-CSE-ConnectionGUID: ieIyeGi/RnypTYJ3cY570w==
X-CSE-MsgGUID: pjSZVUI3QNW1cAft34KGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93669287"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 09:03:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 09:03:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 09:03:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 09:03:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSrYXYr9IZFBwbM+jA1GHRaq9j/j4ugFAsn+CoFBDoNCJx0P72izWyy/Xvp8dQJNZfBKkBoSOGv2L0n0UXFius4hMPdDuw/LgzM5KMn6YTKxHrDLAK0pV7Y8k4hIfpyu+lj+4PpAvu2FKFMfarIJ8NTOxjeu115csj6jOVLZQ2sHokuEXyEgx2WoKSZeXMFj7iZcQ6zRFza7OBs+RZNXpKqFBzXOc6IwAFRsks9j4aZFquINpbP2onxZteTgdFW+G2RFVQuGVGbY4+JcgrdQILIhBDxy/dR5K80X6VfqPth8Tq6PWurubQTWskVr3QDi1Sl8V01+K4XfirU5iHYQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haSLTqyRoWvpVxUKZtBw0uzX39XGoIa5KK0I6Kd6BYk=;
 b=P3Dg/Y7VxaUvv9rWir30JsK3O6BQN27cskRxSULpFg5bMOd+ros5HbHG/XQDaHRMPnXvPrWhPlXeuU6yltHVmcvsph0ZISlIC2Xh4FF3b+z8yGwcfZ+cx1r8mm2+BHq/+11GE+rQw1em0vD7l12DehEKKNVvZPZmksDc5/xt8faPvOk4sdn//knvhz/1PCBy+IJ8EUjdmvIga8fp7nuIL78zgJDW1CXqZXhwJsNmBu5op5WEJUGhLJDBLcLvonfhQNONJFrAA9W3B1Mh1AlgZCsxOEATSsZmYhbEPj+XaUJL8GqLyjmQKoCS4Tk3ABEh/ngKiQOg5EpMFNt3Qlmr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 4 Dec
 2024 17:03:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 17:03:14 +0000
Message-ID: <4032a5a5-dd0a-49ae-94b6-dc4fac4c190d@intel.com>
Date: Wed, 4 Dec 2024 09:03:10 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 20/26] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <thuth@redhat.com>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <akpm@linux-foundation.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <perry.yuan@amd.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <jithu.joseph@intel.com>, <brijesh.singh@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <4ec00fe60cd42c1f22c98c9f5c2f5d3ceb9f8d58.1730244116.git.babu.moger@amd.com>
 <3061ec99-c418-b1a3-7975-8a6b9d0bdd14@intel.com>
Content-Language: en-US
In-Reply-To: <3061ec99-c418-b1a3-7975-8a6b9d0bdd14@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: f73ec407-4439-4e71-d4d4-08dd14858a89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzdNNFNKRVFYNk85eldKKzlMMzFxRzA5WGJZZ3ZDUGpKRVhzWTIwNmtVdkhr?=
 =?utf-8?B?cjZSbkhJNW1kY2JFS2tRWFBINWZnWTlYZlFZNVNoaXY2SUZtK1BoV0dqbjhj?=
 =?utf-8?B?ZzVkMGhzUnRhYzgwUCsrZnVhQWxOSysxQllMR2JkZTBIc0lDR0dxc1VscXQ1?=
 =?utf-8?B?Z3ZHWmlZaTJCa1ZDUVRlVDFaTmZVRjY5cjQvR0I5d0pVem9DUm1PZDJRSGQw?=
 =?utf-8?B?c3NYWkh3bEFGSFIwMlRXMW1xcmZiRkZOekIyRWFkc0g4UGdBam5mUlhNNXlO?=
 =?utf-8?B?ekxIMUNWbXR4Y01pZCtyajZmR2RkN01sK0IwM2RmaWpTbndwQUVFbTdQVkFs?=
 =?utf-8?B?K2xCVks3S3E2cVJ5UTJ0UHRaTE9RSUYvSEcrc3dxQVJEUkhjM3NLNUw2Mmo0?=
 =?utf-8?B?SkpSTEtuMWV6ck9BVmZFVEV5RGhXY3NCbFNraWhndkplSnQwSVlCOUwrZkZw?=
 =?utf-8?B?ZWpnT1kxaXh0T01VU1pjakVRN3lrOW5ERGRlQXBqWDlDa2lRS3BucXFScEhV?=
 =?utf-8?B?MmxPaG5ScENDdkxNVVRsU2dkMG8rdnNvOEwxS0o0ZFIwQ0xkVlR5ckI1RWN5?=
 =?utf-8?B?UEdDV2d3d1pGYzNrV0FuZkt5MlpEVVhQVUZqTjJ2UWFpU3A2VjJuRWNzVDJB?=
 =?utf-8?B?NWk0YXZRNUVva2xwT3lZS3VrbWVZNUw1a0xUL3ZkVkQzd3ordWdwUDZvT1lz?=
 =?utf-8?B?TzVpZWtQRzhwRnZXT09rU1NmYnBoSExveS9sWDVya2VDRUJCalRxdlFDQkIy?=
 =?utf-8?B?NXUxTllvaXNPZ1NSZ1NEQlhhTzFYRm9BUEs1TlcwWnBMWjdmOWI2a0xEWnJk?=
 =?utf-8?B?NE02YytWN2Jya1E1N0Q1ODRnN3ovUjlVQS93K0FLNEZ0YkNIK29TMjFFdFFt?=
 =?utf-8?B?ajJyN3BYQm12S1lBNmlCNTdmdW1ZY3pwbFlJNlNIN2IxTmJxZVV6WWpPeW5Z?=
 =?utf-8?B?YUNIbHBDSE15Tk5UM215SnV0SlNxMHphNW9qdkp6T3h1Rk5xYU1RM0Y2a29q?=
 =?utf-8?B?T01jS3RXM3ovNVpvMEdXd0JLZlgvUnRycVppZTM3eStjZ0lPMHNrbmFxSmJS?=
 =?utf-8?B?U2YxTW1QNlZQUUdMd255RTloNzJZazJXWlpFVTJvTzhVOWh6RzFnSTBtNU9Z?=
 =?utf-8?B?bjFxVExDWEx6dXFDTTZNRGRuN09JMGFDVFRtQjhpd2wrUTVHM0JGcUJMRGI2?=
 =?utf-8?B?Szg1Z1FzV3RmdEdibHUwSnNQajVIUTRjMWdpMFpBeUMyUTBlcGlFZklzQUNG?=
 =?utf-8?B?WGdtL09taHlXbDkyU1cwcCs5K1BEeEhLaDFueUtzK3FyVXF3OCtxQkdoU1pU?=
 =?utf-8?B?NktIeWt0UEhIOFV1K2l5dUttczFncEVlQi9PNzY0dzVVa1gvaHhraFBOMXJW?=
 =?utf-8?B?VjdLVkMwWCs2OXVYVXR4OWZHcXVBck95dGxUS21hTytxRXJDVnBCa3YrQXJn?=
 =?utf-8?B?TnY4ZWFqYjlDYjVFMVdxbkl0dU5OeWdjVElicFVaL0hBR1dOcDV2aDB4a1VC?=
 =?utf-8?B?QVhzczgzM3NVUjFXWUYvSzhpenl4ODltZUFzQUczaXJYY01COEN3UURBTVJX?=
 =?utf-8?B?cjZ5dEt2V2puZDZqVWdsOGJtQXNoODdJV1c2SWdseU96MEd6b3NKd2JqcVRX?=
 =?utf-8?B?NU9HeWZweGpRRGJkL0wzblNlby9PaWV2ZjJOMUxQN204a2ZJM1J1RUkwak1U?=
 =?utf-8?B?d3NqMURyZzEya2J1bGxwOVZFY2wxU3MzUTFhQXlCeHBDZGdKME0rMmsvZnF5?=
 =?utf-8?B?a0RCSjNDMUxOT3lQY1BObmZtZTJZbFhLZHZtUStNUUJzM25FY1B6VVZmbmZu?=
 =?utf-8?B?N0VQVjRCOS9TWGZvRjZvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpUS1NkN2w5UWk2RzlORlhweXJ0cUlsc0o4MnRneXhJclp6ZTg2YjIwL1RH?=
 =?utf-8?B?eGVDVk9YL24rTFhuY3EySkVvU0NLZGV4YVpOa1RZMXp5RnhlbFBLcTBKVW9X?=
 =?utf-8?B?RlFIWUxaMHgweFBISzlQUjJlZTRBb3lLRG5yTVl5MHJla2sxMjNxcXNkbWpq?=
 =?utf-8?B?QW5sS1lzcTdKOW1Yd09xaUtEVmdLREViMHZYWG50eVFQZDMydWVlZ21Cbk0v?=
 =?utf-8?B?c05ZMWZFU3BidUZKd2RWREVEYkJ1Y210TkZEcjZHZ3lkOFl5SmwwdGN4ZlR6?=
 =?utf-8?B?QlRacStQZ25qWlVYMncvbGhqSzc2T0ZHTTU5TDVYZ0ZiY21IbXpndnpkSmtt?=
 =?utf-8?B?QjdRemF1YmFlU3F1Z1h3dmQxQmtEV25sODhMNzJlUm5peWY1bUtXWHJvMTJ6?=
 =?utf-8?B?ZllJWHBXanp6cStERkFuSXZ1Q2pQeGJaM1JpVDV5b0dORXh6UC9XQXYyanRa?=
 =?utf-8?B?bk5ZSm5iVTVKc0pQYzcxUjJRRkkwek5XWVVDR1Yvd09zb3ZBcjcyc3ZHSXNt?=
 =?utf-8?B?SmtQTCtyQXArU25CNXRxUHRpb25YOUcwYmpTNDl3RTFnWEtaNjRKbXdBUmxm?=
 =?utf-8?B?d09iRTd0SGs3b0I1WmJKU3ZwTVlzZXZuZEI0b2tvbFhmYnVNVmxNSlpaVEhz?=
 =?utf-8?B?ekRGa0M3M0lNVitXVFBGQWEzQkR4NTRnTk5CWkxoVnlGSW9wSGFJbGxUQisx?=
 =?utf-8?B?VE1UMllxTzhxUDZQRUtGMk5PUDNHeWEzY0xZRWdhK0ViaHRMMy9EbEZLaFF0?=
 =?utf-8?B?Qi9UY21UQmNacTFKcWhxSWx1Ui9hU3V6V2VxbnhtWnlxTFZyRDJIdlYvMkJZ?=
 =?utf-8?B?TkRTU0YxUDgyTHhBc2NJRG5QSi9MdjMwQmJ6OTQxR25yS1I5MDNLRFQyMFpF?=
 =?utf-8?B?eC9ueEJtNVhNcTRaa3M5d205Wi9vUkY3OVEwdWtWa1V3VWxrcURmd3BvcnhG?=
 =?utf-8?B?QkI0WC9xK1FqQWRuNGlSNnVNZnZwWWpxWVBDWVJPcU91Nzh2NktMeGttNWFZ?=
 =?utf-8?B?ZSt2aFQ2Q2dIVlA2bDN6dDBmdlpyS1d2aTYxL05mVzdZU0hMQk5aNkVTTVlF?=
 =?utf-8?B?OXlPT0oxRU94UlVFVGpqd0lHbDRleER6VFdrYmRRblBkY0RmeHlSdzRSUXNN?=
 =?utf-8?B?TFgrMERMWUZ0ejhFeklPU05hMFZKMm1YNklraEwwc0NOK2hYb2JFUmZIZ29z?=
 =?utf-8?B?RG5GVTlpOWw0dWpBYzZMOGh5eXdFUjh6TFdYUmhQc2c1RVlFcXZjV1VSaGQ5?=
 =?utf-8?B?dm56T0xnenJ3blE2Qko3cVB0UEgvMi9kdS8xbE8wSmdyblo0ZDNVR0VsWkF5?=
 =?utf-8?B?YkhjczJCQlBqMmxOYlEveXFGZUlJdm5yanhWNXF5Y0lNT0VNT0grTmxtMVQ1?=
 =?utf-8?B?bnMvRGpkbjVheXJnSmtrZjBVYytjMWFvaVFieXNzd09XUysxNVNNOEZZVVpv?=
 =?utf-8?B?S0VrbTEwRlVJTW1vUmM0ZlpnOGxpVGdSc3pteFh3UENJaHZPb0tSM0xiT1hH?=
 =?utf-8?B?Umx4c2p0SkpCZ014T3B5UmhxMW81QlVmU0pYTXRIeEtxdkI4RHpHeVRiRlRO?=
 =?utf-8?B?NUwvWnkwdFFSd2wzR3hRN3lZek43cmhGZ0RtSEZQaEdpVUZrbXJkaDhWN0VS?=
 =?utf-8?B?bUE3aWIvOTRrczlFSUNUMnZ4UzZMSnFlQkdpWCtRaHdYVHJoMGFYOEI0RW9i?=
 =?utf-8?B?UjJyUjYyQTQzOW8zdnlBSkhuN2RVTnFzeHRBb09KYXNpejFVY0JHTy9nZ3dy?=
 =?utf-8?B?R3lzTEJNdmVodlBmZjVYN2ZQQUFNakZZYkV1cEcwY2U4U2k2Y05OSzdOVEFy?=
 =?utf-8?B?aGFrWnQwVXNzR3Yva0phYlRrejU3TmprbW1GVWFLR2YrN0lHL2JkcXN1dlh1?=
 =?utf-8?B?QytIaGx0TG0rSmNJaElKNC8zWkVoZVg0ZFJtNVVPZGNrZGk3ZURCOEYvR0I3?=
 =?utf-8?B?ZTZ3UklXN0xVNmFHMnd3V3k2UXBvT1pZK1JuWG1vSHJrcGRIRTRWYUxQbkts?=
 =?utf-8?B?S0FRb2V6Z1JteDYzb0kwWE1RSTV6T0FjQ0hSK3hPWWRLTWRaVnJscUdKa25X?=
 =?utf-8?B?RUJNREwzZSttQ2JnWVQwODFBYTRKU2RvZlpaT3RNUS9BeXg2Qm10a1M3cXYy?=
 =?utf-8?B?dm9BSmR4M25jd2lMY0JyRzNyYXhITDRyL2lVTkRqY1pqQkk1d01lK0d5b2Jx?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f73ec407-4439-4e71-d4d4-08dd14858a89
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:03:14.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt50e6GUTwyKTxDZ9+I4i8jTqG4HeLN9yUlAUYTbRobr3rfWaVyHQ6YXKPu8yrJCrMz7EDaGVPHHLC0dj/ayUYZRc1JO6Q+brK2fSvuvU6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-OriginatorOrg: intel.com

Hi Fenghua,

On 12/3/24 8:16 PM, Fenghua Yu wrote:
> Hi, Babu,
> 
> On 10/29/24 16:21, Babu Moger wrote:
>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>> are required per group, one for MBM total event and one for MBM local
>> event.
>>
>> There are a limited number of counters available for assignment. If these
>> counters are exhausted, the kernel will display the error message: "Out of
>> MBM assignable counters". However, it is not necessary to fail the
>> creation of a group due to assignment failures. Users have the flexibility
>> to modify the assignments at a later time.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
>>      Updated couple of rdtgroup_unassign_cntrs() calls properly.
>>      Updated function comments.
>>
>> v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
>>      Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
>>      Fixed the problem with unassigning the child MON groups of CTRL_MON group.
>>
>> v7: Reworded the commit message.
>>      Removed the reference of ABMC with mbm_cntr_assign.
>>      Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.
>>
>> v6: Removed the redundant comments on all the calls of
>>      rdtgroup_assign_cntrs. Updated the commit message.
>>      Dropped printing error message on every call of rdtgroup_assign_cntrs.
>>
>> v5: Removed the code to enable/disable ABMC during the mount.
>>      That will be another patch.
>>      Added arch callers to get the arch specific data.
>>      Renamed fuctions to match the other abmc function.
>>      Added code comments for assignment failures.
>>
>> v4: Few name changes based on the upstream discussion.
>>      Commit message update.
>>
>> v3: This is a new patch. Patch addresses the upstream comment to enable
>>      ABMC feature by default if the feature is available.
>> ---
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++++++-
>>   1 file changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index b0cce3dfd062..a8d21b0b2054 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2932,6 +2932,46 @@ static void schemata_list_destroy(void)
>>       }
>>   }
>>   +/*
>> + * Called when a new group is created. If "mbm_cntr_assign" mode is enabled,
>> + * counters are automatically assigned. Each group can accommodate two counters:
>> + * one for the total event and one for the local event. Assignments may fail
>> + * due to the limited number of counters. However, it is not necessary to fail
>> + * the group creation and thus no failure is returned. Users have the option
>> + * to modify the counter assignments after the group has been created.
>> + */
>> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>> +{
>> +    struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +    if (!resctrl_arch_mbm_cntr_assign_enabled(r))
>> +        return;
>> +
>> +    if (is_mbm_total_enabled())
>> +        rdtgroup_assign_cntr_event(r, rdtgrp, NULL, QOS_L3_MBM_TOTAL_EVENT_ID);
> 
> In this code path,
> resctrl_mkdir()->resctrl_mkdir_ctrl_mon()->rdtgroup_assign_cntrs()->rdtgroup_assign_cntr_event()
> 
> CPUs are not protected by read lock while rdtgroup_assign_cntr_event() walks r->mon_domains and run assing counters code on CPUs in the domains. Without CPU protection, r->mon_domains may race with CPU hotplug.

From what I can tell rdtgroup_assign_cntrs() is called with CPU hotplug lock held:

rdtgroup_mkdir_ctrl_mon()
{

	ret = mkdir_rdt_prepare(...);
	/* mkdir_rdt_prepare()->rdtgroup_kn_lock_live()->cpus_read_lock() */
	...
	rdtgroup_assign_cntrs(rdtgrp);
	...
	rdtgroup_kn_unlock(parent_kn);
	/* rdtgroup_kn_unlock()->cpus_read_unlock() */
	return ret;
}

Reinette

