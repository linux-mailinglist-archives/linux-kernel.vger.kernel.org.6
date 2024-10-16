Return-Path: <linux-kernel+bounces-367154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289D99FF30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413312832B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA1E17B425;
	Wed, 16 Oct 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW0JInfU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D613D53D;
	Wed, 16 Oct 2024 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048507; cv=fail; b=NFUyjxQw24eLMeX0JCzRmrMMJiFIcHQyLiNumOh3KbYC2EZCNzebwP05J2ifeeQqt7qrfNWV+Kkd0yIR86AC8KuiRW3HPqn5d1IX7rkZrz2HnNSn/A4HDqwoEgKRX/6Qu6MuLF1Yr4qSvpya6MOKWFSjZmI52N+tHhNYh3stDqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048507; c=relaxed/simple;
	bh=TuIjOFQOu5USvNXfIwGh/aTuUXSbCG5vTa1rZnY4yZU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kngBuLghpoV5U3Cj4RXuV0KlUt5qUtB+FN48CfvMbKqjE6rq9ZqqO7BO5dXrEawW1iV9w+OhZzY8Y0wcMAdLysOkHY3LgFXMJFHKXIf0ST6N69tlH6yWzIZQ0DD0nph3OevYMOeqHB70vTSPz1htJ3Y4Qhdxr5sn3euhbbgW+nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KW0JInfU; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048506; x=1760584506;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TuIjOFQOu5USvNXfIwGh/aTuUXSbCG5vTa1rZnY4yZU=;
  b=KW0JInfUrLwSoZw3uYP9WvQQS6phESY0/FGxiEFU0av4Ole6/usm9Mdd
   QmkHOEnzg2Ww0d3NeT+FrjjETuKS3WDrHHe0zv6+REsvEf2qZuK4HqImZ
   uq/IBmZ82ThO7oRAjdl4vjfjja+pzZFQoZvYYphcQLhoBu6ustPssP0Ge
   RdFlvwudgvBut1VK57eBN4GFPkjEaA4qx7HgvqMQ6WwoGlY/y7ZoCN6a2
   TSaAfAXiwa+6HWs3yjStpN8yljCgHkLpFgE/Wz3+Hoae+b/pZjYqmwa0k
   MFF08cJk39oz3JUZ3u+pP+oGBVkKAposPKG4yIYtF5S7NKJW5BVFYsE2D
   w==;
X-CSE-ConnectionGUID: 6JqVqF40QHm/Yk2Sr3LbBA==
X-CSE-MsgGUID: 4fSXiPfZQh6MS/ZgsmLp4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28354888"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28354888"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:15:05 -0700
X-CSE-ConnectionGUID: F2gWAKz6R6SJV3UWzxxf2Q==
X-CSE-MsgGUID: m/Fjf5bARkeQQ5FILQ4gxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="77716308"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:15:04 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:15:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:15:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkMKv3r0BXDa01+JMRAecvnshW7h5sQYkPwGsSzUtXvyIdB7ElcTg+0lfkKM8MFHcYt5zEL7WnxfAUNNqENMycBiHZS46SN0+uedQotQvz4S9z9mUoSulAPk4ByTAO7fr6i7zoucra7U1jKFwv0rM73mn5jmU4GNB4+HN97rALW4Y9pg4JPj/Ku0FtwpxDBV684tHyyGgP8GtJzS9JvVisn72X1moqH/nS6Z4P/p3jT4ZhweR7HV+wW9+fSQSgXodA72Z/ZfyqqV9G+rfXAYXsktcDOjM1pNnl1qMILiRqzeLl5y8mnYxKibrrdj6UU6GSBfdI0EubceVe04CM/ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/pPE4oS2jzzG0LmOT2quKoEZttin9BEBgfPwBKy7yc=;
 b=XKZciXLI7mVH2pSQ3K5lrf+gIsAokeY6Po6LYz2TBKtlbU/wq3U3CfUKgwe/mJ7JKlkBsbja1TIO3/TqDnS2OO95SnnBwwsddYYG/HKYIWgiQY3nErs3XEBeJeQFqCHyA7kmxpLSZsyraRLmFHjZPvYQ3OMYTtzrvIfnI6iqFbNLk7JCj1762eMgntcwZScAm+vqm999YnDp4/vPXwLmsBOiC/hpAzArpBTCMjUd6kK01By3C859IMCrn3cL+lL9lvkZYiYTyCW0Qr3sDPXGhzJafozzb3K7NH2I4H2HzJzsaGZvyoI2YE282U1AsqzKuCbxVCquCyDMns7icD4TOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL4PR11MB8823.namprd11.prod.outlook.com (2603:10b6:208:5a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 03:14:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:14:59 +0000
Message-ID: <acb1a461-1e2d-40fb-80f5-fbb6a81145e1@intel.com>
Date: Tue, 15 Oct 2024 20:14:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/25] x86/resctrl: Introduce bitmap mbm_cntr_free_map
 to track assignable counters
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <669613777b83bcd4150f2f204311e96198417495.1728495588.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <669613777b83bcd4150f2f204311e96198417495.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL4PR11MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: de34f4c9-8b4b-4765-3639-08dced90b763
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDBTdXRSVDNVaXJWUjhqbWlnWU5nWndnVWlzalZnNTAwZVVUU2VVZFhucG1J?=
 =?utf-8?B?WDFGb1dCYUdhVmlLS1ZDLzJ4d2JHUHJWdkZTUWpZdWFrNlFqMWZzU3RFL1hW?=
 =?utf-8?B?RTljN3R4K2tLeGFLS1FTNHpBcFdjT2FQRCtoQUhmM0NZUisrWElYa3RpNHFM?=
 =?utf-8?B?U0I0VzVFYk5hUG1WZlBSZzN3RVA5bW5SRTVRNnNFSmVNb2l1TjRsa0p1cVda?=
 =?utf-8?B?WW9xeGNxaHd1QlJjUWxWZ1Q5aHhzSTFwN3A3Q3VVNDRuSjczUDJRMFVOdThN?=
 =?utf-8?B?Y3NpU0c1bUlCUjBndXpXelRvUDB0UG5tZC9GbFZhZU1hbjRBaE9HT2FWaXVC?=
 =?utf-8?B?OUY5V2JXN2N0eXN6cnJ4b2w1UHczMGtDVXZHYUc3c090ajJlY3pvdzlpMHB0?=
 =?utf-8?B?Z2V3VXVHVy9wSGtML1JPOEM1elZwbWtRa1MySHZEdk9BVHRJLzFoSW1zQnAv?=
 =?utf-8?B?aktoU0pxWW5mcWZwcmUrRzVVODNrQjl5d1UyeFBkM0VkQlluMWUxNDRMQVhp?=
 =?utf-8?B?c0FXUkxDbVBtQlNDUGt3OUxFUFkzeklqZzRkVEtwN01JL2Z0TDJXY2lDZ0Ja?=
 =?utf-8?B?c0J4djdqK3YwWGNYaUQyMnA5aTBMU1NIVjNuM080anovcGF3ZUR4a2NkVjBi?=
 =?utf-8?B?eENFbk9Pd21UU0o3aVNjWkNhRm55d0wwQ2ptY1NZYkNMM1hSOHVxUUhTTEJ2?=
 =?utf-8?B?V3BiSEJWaytWS0xjT3BHRUdpSEdQcmNRUGd0RDVxTjhndXV2N25OeWJEUzBF?=
 =?utf-8?B?aEZhYWxUU1lUK2VLaCsyYjVybXJUQUI0SjBUMUI0eXJVR0hQRExNbGJEd1lT?=
 =?utf-8?B?Zno2V1h4OEFKNmJFUEFXaklrbE5IdG0yNGZORysxcHlzVUZjV2t4aEhGVGJT?=
 =?utf-8?B?LzNoR0dPcDFMdEhDUE1vS1M1RlZsZERtblRnSWxycElKRDYyL3QzQ2d5L0Ju?=
 =?utf-8?B?ZjQvaURPRzFXbFdqeGp1dHlYTG5HWXpvQ2RQVEVtOFRxRmV5Qm9JYTlsQjZ0?=
 =?utf-8?B?VUszQzZ4QW12V1BoK3RYSWJHMDJrc1d5ZnEyT2U5U0NkM0l3ME8vbFJKWjlM?=
 =?utf-8?B?OGpvK0RXdVRzQ1haOGxvbWNpZ2VmekNyRHZrcnlYNjJLbFl3S0ZmWUtDTDRO?=
 =?utf-8?B?My8yVk9VRjZMQ2RRY0lSV0VQV1NrekRqM3R5K0VBUlFoN1dtaWw2VVZlQW50?=
 =?utf-8?B?aTdFeW9kT2xvcEJWT1E0SFhpSUZwNzRXaWljM3l4OFdTU0F1eWdEUGtLM0NZ?=
 =?utf-8?B?cEVyQmp2RkpDTDJacjIrSUoxUHBpQXpRL1dSMnZvZDI0c3A1K3lzTE80ZjVw?=
 =?utf-8?B?MC9LQTZ0NkdhWWVROVlaM3ZJWDVqVVlET2E3RS8xZU9UcFA4cTMraGR1TXN0?=
 =?utf-8?B?ZWRWY0VNSGRXcTR2amQ2S1Z6aWU4VXFOcWNvSFBINnBwZW9xY3lwOEJvZkVQ?=
 =?utf-8?B?Zy9tZktMSHRNVE16bDh6Zm1DN3dwY3pIakJhVXEwclZxNjlIcFpqZUZWREFw?=
 =?utf-8?B?UzdTMDgzbk9hVndjRnBqTFBRZE9idFFUWTc5UnBOeUJqWUxaUTBhS2hnRjh4?=
 =?utf-8?B?M3ZwZExTdW5GSURjMDFiNWVmdTBQU243dVlCdkp3amxYNzZTUFVpdklBRUVt?=
 =?utf-8?B?MXdzRnVES1pLL0hPZHNZTk1KRlJjZi9zZGNzSlRjWGN4aFJIMU0vWkUycW9i?=
 =?utf-8?B?a2EyWERiTzF0bisvTmkvbUtOMEppN1VKL2ZuUlNjdE9OYldKeFVwdWhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxZbEdpSGdnL3Z4OUwzWlIrVWpKSnU3UmtXYlpxSjRJYjRMTm40eWRsVE1v?=
 =?utf-8?B?U1g3bUc0THo4dWNNbXVUc0ZaVUhLaTFIcFZTNmc4QU9xV3JrOGc0T2dhSHZF?=
 =?utf-8?B?MytiYUZHK1BxYU5rd0hodVVSVDlpYzNnSzJWblV1NUFTdE5EQXJvcHlYMDNB?=
 =?utf-8?B?M3RnbEhJRWlJeWxKTjB1T1A3dmJoaDl4R0F5clQyVmduaUJoUmpIWnluaktq?=
 =?utf-8?B?WHV1RW5NY0RyZDJkYXRRNmVLRXJRcU9oV0ZLR01FNkwwWWtQcG15ckZzMlZ1?=
 =?utf-8?B?bW1IbmVHWmx4OWdtaU9KQzdoZUNYZW15enBIUzlvcjBGZDN0WGFZUkYxSmVj?=
 =?utf-8?B?VHk4eit3M3F4SzZTVUxKeWhvbVNiejVYOXg1WlB0aU1oRGFvUWNIOTh2Unpv?=
 =?utf-8?B?UDRkVWVMTXdwTmhQNmNycXJoZzRvNXVNZ1NXc1lxMnB2ZWVHZEI1dVREbGVR?=
 =?utf-8?B?cUtCaDBpcDQyZjhCbjEvdjBrVnUweXhReXUxSnlxdWhGRDBWZ2VaWEEvOEYr?=
 =?utf-8?B?R3J1WkltVUpqU3JXeFVra3QzdjE5YkMwS2NNa0o0VHRnNTBUQzloSU1wbjdq?=
 =?utf-8?B?UXZ5ZytmMTVxdDdXWWtPVXVQTmpRaDgxeUVTc01uY2FmTVp2Z2srTnQ2dTE3?=
 =?utf-8?B?OHRvWE16eU9YMVVhb1o1VUdrM2pJaEcvdjIxWktnZmVFUW5tZjdlTXBhakhv?=
 =?utf-8?B?TDZ5andwZ0ptNklqeVpWcVV2M2loOGF3dkJBNmNTYWgxa3NuVllPTEJqbXpx?=
 =?utf-8?B?Y2o3SzZFNDU3a1JGUnlvK1FnaW9wMERUS2tWejlZa0FoOWZ2aGpaaHhlUGZk?=
 =?utf-8?B?NjdjNjRvUzNRZ2Vqd3luMjdLNUg4K3d4QlRMTUMvdE1ldExudUZRRGdzc2ZV?=
 =?utf-8?B?WVZ4SWI1azZJVTJablpyQ3N4K2k1ZU4rTXUrblBLVm1xbW5mWk1obkdUQnU5?=
 =?utf-8?B?bnNacmxjR0Y1TE4ybTN0eXZpSXQ4MVgrUzlVUVFFM0ZtWnJPUjh0dDlxODQ4?=
 =?utf-8?B?Z0x2NW8vWlBuU0hHWjRRbHRsZjZTWVBEQjNtT0Q3a1hFRDV3a1J1NUwvUDJ3?=
 =?utf-8?B?SGNZUHYyTHhqVkJmTzZUT3V0NnpsczZNT0lSQjYyNkRUYXlnNHJGNHNualhH?=
 =?utf-8?B?aGU1RDlCY2IrVTFsTlVMS0g4QzNOVGk5aUVjMjBmQ2dqK09iZy9xMnZENTRa?=
 =?utf-8?B?VElVSlhvTHE0Q3ZpZE9wYjN0MUo5bjd6ODlOQWRGNk5NSlpUVzFENG15bFFt?=
 =?utf-8?B?b29Ra2J3ZEhCMU4zUEhXbWV5TURETTdPTDlpWmZiNVNTK2hVVHN3M0FmdUw0?=
 =?utf-8?B?blFDbjR1N3YvWURiQjVwV3pUalcrb1A5NDBnclRVbm1GN3FkZWxkOWFRTDBu?=
 =?utf-8?B?NUFkbC9IcVNBa1c2NDZFSXVWZlUyendBdFVMZU9Fb2ZBZys0L2s1ejBJVndz?=
 =?utf-8?B?QVBYVVBLcTh6bUtYUURXRnFONVF4c0hWYjFtdW1MQUlPVHdGTWlVTHdWMU94?=
 =?utf-8?B?ZUxiL3FTRFJzdnRPa1ZwcXl2KzdPaVBycnFEekxHVXhZaXczM0hrQUZtWXNK?=
 =?utf-8?B?eWNzam5UQlJiRFZya0xhaEJrR0owV3VqaXBueXNuUFJCSWxqcDdKYnJta2JJ?=
 =?utf-8?B?bTdjYnhCOTlPYVZOUlFRb1FkWS83bEpwcFpSc3puODRiaXFSdWlLMkR5dzE5?=
 =?utf-8?B?eHVUK0Zlb3FRaUlBeVJlYm5uYVlmMTN4cGMvUGNDT1UvYVBWNjBqaUt6MmUv?=
 =?utf-8?B?am1NbGhUeXh4d0JuR1NBK3IyUG5KTHV4TFA0UGRScWxXOGhhZS8vc2Q3cjd1?=
 =?utf-8?B?UUF4NExIQlpjUHdvQmsvKzF4TWRvYUJPRmVDbm9JeFdHTDFOcmFsRW9MdG9Z?=
 =?utf-8?B?RWNwbDhCUURoRXRoeWFPQ0d0cGxUOHRaa2RjNEE0ZmluRkxNTzJ1MHU0YVJr?=
 =?utf-8?B?N281OEFyNzQ4NldqM2ZMcjVuMWF6cUhISzFjcHdSTFBTRU04L0JrQ1BZVVZt?=
 =?utf-8?B?Uk5JUXU1ZDlkNHNOS0YwcjI1b2Y1N21YZTJ5aVFDM3F5aGZwOUdTM2hTOVUz?=
 =?utf-8?B?SUdudVJ1dk5sUCtMR1EwaGhSVnZFRndDc0ZXUlJDNHo0Q3ZvaFZLNENQME5t?=
 =?utf-8?B?S2lkWEs3ems4UTFoWWwyNmdxMU9IY1JOUUdWZ1NoOWhEMUI1ZmhwNlVzQW55?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de34f4c9-8b4b-4765-3639-08dced90b763
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:14:58.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlpv54GmEj4ssnY9sxZRTHHEI7HDbwJVzc8v04qT+NPq//dGpuntrRkUgHQXOCxq9js8iWot2L6UqyjO1s9ycMM7hc7YHfmUn7z9bkaj1wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8823
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Hardware provides a set of counters when mbm_assign_mode is supported.
> These counters are assigned to the MBM monitoring events of a MON group
> that needs to be tracked. The kernel must manage and track the available
> counters.
> 
> Introduce mbm_cntr_free_map bitmap to track available counters and set
> of routines to allocate and free the counters. Move dom_data_init() after
> mbm_cntr_assign detection.

Regarding "Move dom_data_init() after mbm_cntr_assign detection." - this is
clear from the patch, please use changelog to explain *why*.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---


> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 43 +++++++++++++++++++++++---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++
>  include/linux/resctrl.h                |  2 ++
>  4 files changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 92eae4672312..99f9103a35ba 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -654,6 +654,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init resctrl_file_fflags_init(const char *config,
>  				     unsigned long fflags);
> +int mbm_cntr_alloc(struct rdt_resource *r);
> +void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 66b06574f660..5c2a28565747 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -983,6 +983,27 @@ void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long delay_
>  		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
>  }
>  
> +/*
> + * Counter bitmap for tracking the available counters.
> + * 'mbm_cntr_assign' mode provides set of hardware counters for assigning
> + * RMID, event pair. Each RMID and event pair takes one hardware counter.
> + */

"counters for assigning RMID, event pair" sounds strange and it seems like the same
thing is mentioned twice.
How about:
	Bitmap tracking the available hardware counters when operating in
	"mbm_cntr_assign" mode. A hardware counter can be assigned to a
	RMID, event pair.

> +static __init unsigned long *mbm_cntrs_init(struct rdt_resource *r)
> +{
> +	r->mon.mbm_cntr_free_map = bitmap_zalloc(r->mon.num_mbm_cntrs,
> +						 GFP_KERNEL);
> +	if (r->mon.mbm_cntr_free_map)
> +		bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
> +
> +	return r->mon.mbm_cntr_free_map;
> +}
> +
> +static  __exit void mbm_cntrs_exit(struct rdt_resource *r)
> +{
> +	bitmap_free(r->mon.mbm_cntr_free_map);
> +	r->mon.mbm_cntr_free_map = NULL;
> +}
> +
>  static __init int dom_data_init(struct rdt_resource *r)
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> @@ -1020,6 +1041,17 @@ static __init int dom_data_init(struct rdt_resource *r)
>  		goto out_unlock;
>  	}
>  
> +	if (r->mon.mbm_cntr_assignable && !mbm_cntrs_init(r)) {
> +		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +			kfree(closid_num_dirty_rmid);
> +			closid_num_dirty_rmid = NULL;
> +		}
> +		kfree(rmid_ptrs);
> +		rmid_ptrs = NULL;
> +		err = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
>  	for (i = 0; i < idx_limit; i++) {
>  		entry = &rmid_ptrs[i];
>  		INIT_LIST_HEAD(&entry->list);
> @@ -1056,6 +1088,9 @@ static void __exit dom_data_exit(struct rdt_resource *r)
>  	kfree(rmid_ptrs);
>  	rmid_ptrs = NULL;
>  
> +	if (r->mon.mbm_cntr_assignable)
> +		mbm_cntrs_exit(r);
> +
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> @@ -1210,10 +1245,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	 */
>  	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
>  
> -	ret = dom_data_init(r);
> -	if (ret)
> -		return ret;
> -
>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
>  		u32 eax, ebx, ecx, edx;
>  
> @@ -1240,6 +1271,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  		}
>  	}
>  
> +	ret = dom_data_init(r);
> +	if (ret)
> +		return ret;
> +
>  	l3_mon_evt_init(r);
>  
>  	r->mon_capable = true;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c48b5450e6c2..8ffebd203c31 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -185,6 +185,25 @@ bool closid_allocated(unsigned int closid)
>  	return !test_bit(closid, &closid_free_map);
>  }
>  
> +int mbm_cntr_alloc(struct rdt_resource *r)
> +{
> +	int cntr_id;
> +
> +	cntr_id = find_first_bit(r->mon.mbm_cntr_free_map,
> +				 r->mon.num_mbm_cntrs);
> +	if (cntr_id >= r->mon.num_mbm_cntrs)
> +		return -ENOSPC;
> +
> +	__clear_bit(cntr_id, r->mon.mbm_cntr_free_map);
> +
> +	return cntr_id;
> +}
> +
> +void mbm_cntr_free(struct rdt_resource *r, u32 cntr_id)
> +{
> +	__set_bit(cntr_id, r->mon.mbm_cntr_free_map);
> +}
> +
>  /**
>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>   * @closid: closid if the resource group
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index f11d6fdfd977..5a4d6adec974 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -187,12 +187,14 @@ enum resctrl_scope {
>   * @num_rmid:		Number of RMIDs available
>   * @num_mbm_cntrs:	Number of assignable monitoring counters
>   * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
> + * @mbm_cntr_free_map:	bitmap of free MBM counters
>   * @evt_list:		List of monitoring events
>   */

Please follow custom of existing doc and have description start with capital letter.

>  struct resctrl_mon {
>  	int			num_rmid;
>  	int			num_mbm_cntrs;
>  	bool			mbm_cntr_assignable;
> +	unsigned long		*mbm_cntr_free_map;
>  	struct list_head	evt_list;
>  };
>  

Reinette

