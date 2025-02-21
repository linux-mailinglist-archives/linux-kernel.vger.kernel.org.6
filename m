Return-Path: <linux-kernel+bounces-525940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6D7A3F7A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B731016C256
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBDB210F6D;
	Fri, 21 Feb 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wp84yYVY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF5653AC;
	Fri, 21 Feb 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149139; cv=fail; b=SxqWXKS/rRQqyQg2FPsrAK5tZbFOgBwp2OyeOpZZ2KVcEnO21LwOpytWjoiC6pXPvtfGyJIdHEycesuS0Plrrs0DSLHHszh4bimklaCDk0b24EcimaegvkL3RpEeVl/+foplo2WTYDesVmeyLgLuKAWikx+11jJfzS6G82+Fg0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149139; c=relaxed/simple;
	bh=KB5K180KLaC4zw390u/d2a0B91GHQjrJB25Xvll6jbo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RiXYF5Ymelw5Fd5q9PqvI4ydDKlTPPWH9z6Pht7WS+hzg/YYa/mwqiIudJIwtiQVFOlbmVzgTjovIIui0n3FtEHdQYio96YTpDA2Flzvf9kOEkW/0qy0hAjYVuGy+0gTYvncPw2/5DzY4+3thrlbcERav/GEuTJgBNq7I47+fMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wp84yYVY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740149138; x=1771685138;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=KB5K180KLaC4zw390u/d2a0B91GHQjrJB25Xvll6jbo=;
  b=Wp84yYVYM6jyzPTdudzJc5a6HO0s3ofWpQMtB45mVAqTyqQaZnvq7jH5
   1jvcYC/WM4F1P3xf5MEc0Ug1WXdpcFxZe6WXjVtMwCO8h+FOuJcUtEew1
   owjIUpQblQl+zJ8NGIuV+5xTVpSJs/I4p30TI222bOGj5IoiYFUowd59J
   iWt3iM2p+Rst/BbUg9zycUgGNkb/tYUiEETlHENtjOztUiqog8C2ZWWES
   qEC5BXteH1ICX+7b++haY+AFODYJCvYbkhdW3MI4vOq5kH3iuEbOyE3xs
   5YyFKryHvbj4D6VUR2e7j4u9IkfkE7tF89crsfnfuOXzoFCfqWKEYgw/B
   Q==;
X-CSE-ConnectionGUID: XZYBYIAlRha/KFvuM91CtA==
X-CSE-MsgGUID: KIVDeLmETJG5PPoU+f2UnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40846374"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40846374"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:45:37 -0800
X-CSE-ConnectionGUID: XIYZ9mytSDaRWjpiEU+4AQ==
X-CSE-MsgGUID: 6W5lgCXLT+ys44JEyI2EqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120368837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:45:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Feb 2025 06:45:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Feb 2025 06:45:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 06:45:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKYAgA+KLTw8KRbqrL+nac5F2m0G4qao3Xo+IyhIBjq2WX4LuDEB9qTZYtZdYJxQ1JZlH48mZIl+CWZG+WWAxlTa/Y0DYfZHzv0CEjc6ZWiCSvxnHEJLg50RWuDUGNgkonMnIwHv/w4yQeOw9cDu1/7FVISb2IvARz0owHXhs7bWRSTLAmvi2moZqpqoYnez/8lYTiR+YXWcoKKTI8le8h0nIT/hgkB+t1KBNGpoUNUtwwadwLh+cmnCgqCdrmyS6wNHCs1zdJCp9t02J0cUBj7iiQle596LLexDZkhBDLpzTTv1ry0gvYDVI+EDIwaPI9hytNLzHkuA3ffU7wILLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AShZNeROo825tTT7CQ07Aeq0mG3a/fPAQcXhVEWYr4=;
 b=rUgR+Nh1ZICiT87fXBmHnKwrzVGf0/ddZLNHwCymFiIPa5p45aLhyNtne5C7/sjVbMDa+kStHr0uDsrefj7CxAwisU7a/tjBetIieTDGzW+efSk+Z7/FUSyYrNcGjncH6YE+E6ZYqcfGyjXqg8rWZOUy39pTQWPq3Kq0PYmiaSCp3T9qh24uUC4Y2vmjBfNuAjX28cjgyGMe/l6KBqkDlz16b5XUJkCPWAPYPmbKcjwUOHAt/DTCVEzUU2pBx2dhVdmO6ijkvjgFVhS1TTV0a8n40Hbuuq3bF4MPYu6Wc+iyI9sukvLBqJfl91c2zQ4pH5cA5gKUNOx16qzjLA9/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 14:45:32 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 14:45:32 +0000
Date: Fri, 21 Feb 2025 15:44:56 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: <kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <ndesaulniers@google.com>,
	<guoweikang.kernel@gmail.com>, <dwmw@amazon.co.uk>, <mark.rutland@arm.com>,
	<broonie@kernel.org>, <apopple@nvidia.com>, <bp@alien8.de>,
	<rppt@kernel.org>, <kaleshsingh@google.com>, <richard.weiyang@gmail.com>,
	<luto@kernel.org>, <glider@google.com>, <pankaj.gupta@amd.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kuan-ying.lee@canonical.com>,
	<tony.luck@intel.com>, <tj@kernel.org>, <jgross@suse.com>,
	<dvyukov@google.com>, <baohua@kernel.org>, <samuel.holland@sifive.com>,
	<dennis@kernel.org>, <akpm@linux-foundation.org>,
	<thomas.weissschuh@linutronix.de>, <surenb@google.com>,
	<kbingham@kernel.org>, <ankita@nvidia.com>, <nathan@kernel.org>,
	<ziy@nvidia.com>, <xin@zytor.com>, <rafael.j.wysocki@intel.com>,
	<andriy.shevchenko@linux.intel.com>, <cl@linux.com>, <jhubbard@nvidia.com>,
	<hpa@zytor.com>, <scott@os.amperecomputing.com>, <david@redhat.com>,
	<jan.kiszka@siemens.com>, <vincenzo.frascino@arm.com>, <corbet@lwn.net>,
	<maz@kernel.org>, <mingo@redhat.com>, <arnd@arndb.de>, <ytcoode@gmail.com>,
	<xur@google.com>, <morbo@google.com>, <thiago.bauermann@linaro.org>,
	<linux-doc@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 14/14] x86: Make software tag-based kasan available
Message-ID: <afc4db6mt3uuimj4lokfeglhqc22u5ckgvunqtiwecjan5vjj2@lvphketnxhhr>
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <d266338a0eae1f673802e41d7230c4c92c3532b3.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZezPtE+xaZpsf3B5MwhpfdQV+5b4EgAa9PX0FR1+iawfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZezPtE+xaZpsf3B5MwhpfdQV+5b4EgAa9PX0FR1+iawfA@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0316.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::14) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cc087b-9f3c-453a-0f54-08dd5286647c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|27256017;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnJma3NBRTlET09ZUlhBTmQ0Um9yU2RhKzdxRnN0Y1F1UEU5NWMyUy9zMEIz?=
 =?utf-8?B?TEdUdXRXZm85WjAzb2pzY1ZZV2ttcW1vTTNNTTV5MmQva0Nha3VOaUN0ei9H?=
 =?utf-8?B?VXQ5Z0hOOUl4a3dCQXhPbXRSK0FDU3pYWVNZenVIdDNPTmNsMndmTzZQdmZW?=
 =?utf-8?B?RG5QNjBPdWJKV2JiWklOMVp2VFlmenA2OGUxcFhSeU1sL1RUSUZ4QnNvU1ZF?=
 =?utf-8?B?Qy8veUhZbmZpUzlOaXd1TU5vWEZ5UU9pd2JrRUJRY0w1eHBiTUU2OHd2MWlQ?=
 =?utf-8?B?OSthK3BRRlpmaDdocmZnbFEwWnZGWE9PNDZVZjZtdE5pek5lTG5ORWVRNHo2?=
 =?utf-8?B?TnpOcnM0TnMxOXpEWHpHSTYxYzJHYlVSTFFLVkh1OG1oSmphbVU3UEpXOHND?=
 =?utf-8?B?eGJIWFZpVzVwRnFqZnIwMEtucVFtODQrZ0gyZGVDc2NQSzBXaC96SERCWjJM?=
 =?utf-8?B?OEhkcWNReEwwa0dMa0JHVWJYZTV2RTAzNFJzUzVHd0JJaEs3RzNWUFppZ21s?=
 =?utf-8?B?M2tmUkcxQzVkWnNWNzIxVWdhTkdxL2tqelE0bEdzRVJZay92dmY2aGI3MHZS?=
 =?utf-8?B?V1g0TVNURXBjZE02WEZTaTVJT3ZiQStwcDVyZVl3NG1QVzlKYVVVMzFtQnpS?=
 =?utf-8?B?bC9SNDN2U1h6VkhVZGNjZ1JQcVZHRHlra2N0NlNuNHkxWXpsV0R3THJnZGl4?=
 =?utf-8?B?eTRJSkVlMHE0MTlnVW1JTVFVRDZsYTgrdTNlaHp6RlJxTXhZMTVQdGRBd0Z6?=
 =?utf-8?B?UkxOZTZLUGpVNVFpeXJjSFRYTldJb1ZobnBBVXhoMEQ2MUEzWk8vdjBpUHNT?=
 =?utf-8?B?ZjBxWlMxMHRNSTlrdldwYmlFV3lqMEJlVnBKY2cxRFZxS0g2WmR4R2pxcDlQ?=
 =?utf-8?B?ZG5JZExXVjBBRDk4dlBUbWZaanlGQndNZ0EvWXNQTXRmbjQ3bTlndEQvWnU4?=
 =?utf-8?B?WmJCQk9PNGpCYUVBeUNZRW43VU8yS2lRRS9kVFBib0svOStRKzRpNU5yM1Ey?=
 =?utf-8?B?c2s4Z1JwbFZXR1ExTVZZd0RZZE5oVkUrSDMwb2ZhWVYraDJNK0tuUU4ybDhV?=
 =?utf-8?B?WDgydStIRTRuZGZ3SVZPU1pYOFdkYjNKRkdzdmliOVBGaUhNT1FIMThRZmJp?=
 =?utf-8?B?YXE4OHd2a1hVY2Z3RCtvQzVMK0p3MFgzaHlvNkVHbUp3SzN1Vno0V2hGdFQw?=
 =?utf-8?B?d0ZsRHVqTGxlUFBNZE5ObWliTXpJQlUyL3grbU5QTllOTGpWYnAxQXkvcFZn?=
 =?utf-8?B?bVM0NFNBZEVLbW9WT1JTcy9vemRMei9SZXcvaTVRZWhoZG9wS0Fqd3F5b09y?=
 =?utf-8?B?RjNRaVFEYTRORlJncS96cllRdU0vQU1LSVVtdkgySVVHUkFOQkgzSFVhZmFL?=
 =?utf-8?B?ZFdmQkdiaEVWSmNMZGlLZXdqMExTSmI5a2YwUFYrWW9oSEhjeFdYNVVwbVRL?=
 =?utf-8?B?enBTM3huYy85azlSd1hJRGk4dDZXeGkwZUd4bmpNR2ZHWk9UQndNREJhUHgx?=
 =?utf-8?B?SEFSNFY1Y2VPeVBJSm5tMTNiY1BReW9rM25qa2ZuT1F0bmVsRHRyVUdxVVY1?=
 =?utf-8?B?dzBiVWtmMjNkTjRLcTBzYnpIU3lUWjA1UldtaElpL1JEbXQ4VHVOWDJneFRy?=
 =?utf-8?B?Y3cvVVA4aXA5Y29CV3hXN1NxaWx1UjJmb2txTGR0QTNiMlRSeTdvd083cmpT?=
 =?utf-8?B?eGVGd3czQjBZVVg3blF5Y3VDejlDN3A3RGprUkYwZi93eEYwWEs4cVJSc1g3?=
 =?utf-8?B?bGwvVG5lclkrc0lpdGo5UU5OdkxhZFJ5V0Y3bFVaVnJyRmd6QnJFblVJaCsy?=
 =?utf-8?B?Qkh6YU1hTHhTUGdVcUx6QW9QSHpsaC8xTGgrODZFZDlXVTVJbDB4OVRzMUZi?=
 =?utf-8?B?di9veWRqaGpNMUFBbzU5cnRVOThDT1Vva2Q2TDk0YUJkUUU1VjB3USs5eHpa?=
 =?utf-8?Q?mEO7LB7W7/eq2XgHaNuXcd+janWBCYSW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkl5L3pLNkJsY1MxdW1iVEFvdGszRXVlbEtVTllXRHBzOVVOSUo1ZHVZOEN2?=
 =?utf-8?B?c2V5RFhDMkU3d1ZYN25WTkwzQTZDbEx3aDdFR1RRbmpHK216TzZkUnQ0bnQ1?=
 =?utf-8?B?NDZzdEYvblRlSXNpekxSQmc4Mjh6NjVPZ0g2dE9CNnNTK0NWdm1XY1lxMlJU?=
 =?utf-8?B?dW9nbkg3MHk5U1dMNHZTLy9Lcm9YZzBMR1Q3REk1bklCcFFNamdzZlFKMEcv?=
 =?utf-8?B?QVI1a3JHZVd2ZnloMko4cUpvSjluM0FUbW1wcFpGL3A0MElWU09LM2pueU4z?=
 =?utf-8?B?blpkMHVhMkVwSFpCN29laGZnQlZtR1dLUzNUNnZBNUE4Z1ZyeFNiYngrcVoy?=
 =?utf-8?B?cmd2cDBON0FDVzV2a2tPanlYSXhjbTYrNTB3SDhWZFJaaGFSUUgzTTduN2pi?=
 =?utf-8?B?bjNtSXBSMGhac3lqQ290SUhpMDlNNmZCUkdldE00K1B3ZzE5Nng5dWdETmdm?=
 =?utf-8?B?RndTRHRENklBN212RGZ5WHU4U0dpeUlwRUx6NnBGRmRyaHVPeENNV3czY3pt?=
 =?utf-8?B?d2EzTVRvbWVRbFdFa2dUMGgvVFd0UDBzM0JTRXZYUHVXZWp0WjhSam9Odmlt?=
 =?utf-8?B?cm55QWFzVEhkWlFaSGY4SlQ5NytSZzcvNjJOMHNyUDJXWVFTdDlwN0lDZkRB?=
 =?utf-8?B?S3dTc0ZlN0FQbHRQODRycUQvaU1MZ2sxVmtYQS9mZ1NUUTBjOE9Bb1duZmxK?=
 =?utf-8?B?bjd2cFNQSHNEcktpUzR4N2lJWmFOSFRtMzhITGFWN0xwOVpHdTNIUTRweWlE?=
 =?utf-8?B?ZzFqc0F2c0dlRzNXNHFaWllxRmowNjhmU2hWVnF3eUFOWWxtNUNEdU9qZWI2?=
 =?utf-8?B?eWwyWGVZOTlyQXJPQXBqTlJ1Q2xIWGMzZkVyWEo0THN1VHdsM0ZjOHVjdExS?=
 =?utf-8?B?RXFBaFBsNGRZMkdwd0lEdEkreCtGTWhacFNBTWRDWUJzdXNQSXJ6clVOczl3?=
 =?utf-8?B?Qm1TNmNtMW94SU5VK2dXQm9KQzJkSlU2Y2dBVzBEYWVqMkxvcDJseWpmUnV2?=
 =?utf-8?B?L0lxQ3prZnZOOUJFRUEwTE5DSUpPN0pMVFM3Mk5wTkZLa1pML1lMZHNqbGlx?=
 =?utf-8?B?NFRFRjIzZVoxcGlqd3BZVjFrNmVrM1ZtVG1uZGRBb2VZa0Irb0hRYm8zeFQ0?=
 =?utf-8?B?YTZYL2RDUWZRQitETlBPaFMxbzNSM3pDVVVIbVMyMWF4bE42OGl5NkVGZnF4?=
 =?utf-8?B?N2RBOFNXdnYxOWM1eDJNRGJFaUQrWmR6TFFXcVV2a0QxcllSdFF1cmJJcG5q?=
 =?utf-8?B?MWlIT3MyUDlIVitOUEx4VEpLNVdNSTd1MnNwdnp5TGJjZmQ4RnJqLzJtVE5l?=
 =?utf-8?B?dTdFZER3Y1ZqK1ZKcDgrbitHSFF5VEhEQTBGSnRNbTJBcngyeXZZSURFcFF4?=
 =?utf-8?B?QlFyQ1ZaM2wrOXFTejlobUxOdzM5OEJOZU1DNldNd1RtMjgyeUpEdHZWRUxw?=
 =?utf-8?B?KzlMTitsekRJQ2hDSHZIaVRVeWpVTlVFQzVXaW12TmZ0KzAzRjcyb3piOFVV?=
 =?utf-8?B?d3NSMXpiL0V2L0ljMHpLeEhIZHRETW1KUXE4b0VkRWlqSXNOWUVZRjUzL3RU?=
 =?utf-8?B?STRIeWs0bVBzODMxWGNqZTlzQzV3ZTIwcUVEUHVUUVFvOUp5dEpNc09xMi9x?=
 =?utf-8?B?TXNkTm5sMHJnT01EaHl4Um5DaVR4VWM4bm02TU1RVndHdUhRbkZjOVF6Mnly?=
 =?utf-8?B?YmZmWWdHVFMvUnNtb21CV1F1V05nNGkxUXFEdlBpaExPSUxKeGNDNmR6S25I?=
 =?utf-8?B?M2d6M3Zxdml3bVVtblZLeksyUTRYM1BYNTg4c3ZwS1Q4ZnBCZldNNVBxVmZn?=
 =?utf-8?B?dFVHNFZSS0Y3eFRjWDdQczlrcWJhSWdJS1hJc05NYWNFWWt4V2ZBV1I5SERl?=
 =?utf-8?B?dndxSkZPOVF4bnlSQ0lEVHJPVE42WDZMcll1NTFDcmovOUl4ZFBqUjhDb2x2?=
 =?utf-8?B?dEt3Wm40dkNWbG5BUGkyZXZLaUJmZ09HMHVWVzZ1VHByQTZvV2Q3T2VpaUxo?=
 =?utf-8?B?bi9lT3JaUDlEU3d0Q3dSZmhhV2JwcWtjaFM1Zi9EMjJ4bDQ0bU9FV3JBQ2Qw?=
 =?utf-8?B?UUZsZmJEa04rSzUyaWJXQ1FwK2psanBIVWttRkNCSEZZR0NxUStDaVNmaFI0?=
 =?utf-8?B?YXJYUStsNDQ5Q214S2lza2xPMlk4QlFtODNBYnJraWJBc1EzZ3oyVC9ETnBH?=
 =?utf-8?Q?ycHwb+3JSOQPMnQp2fX3470=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cc087b-9f3c-453a-0f54-08dd5286647c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 14:45:32.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AVJDYMZJyoVrHFyeL/leD3q3xuIG3T2VDwLwQOk5GbvsOg/86q24CzZxQE3SB1yqpEihwm2U5GKpHg1CXLrw2+9it//jzuG+4YwJQ90zPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-OriginatorOrg: intel.com

On 2025-02-20 at 00:31:26 +0100, Andrey Konovalov wrote:
>On Tue, Feb 18, 2025 at 9:20 AM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> Make CONFIG_KASAN_SW_TAGS available for x86 machines if they have
>> ADDRESS_MASKING enabled (LAM) as that works similarly to Top-Byte Ignore
>> (TBI) that allows the software tag-based mode on arm64 platform.
>>
>> Set scale macro based on KASAN mode: in software tag-based mode 32 bytes
>> of memory map to one shadow byte and 16 in generic mode.
>
>These should be 16 and 8.

Thanks, I thought I got all the dense mode stuff from this series.

>
>>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Remove KASAN dense code.
>>
>>  arch/x86/Kconfig                | 6 ++++++
>>  arch/x86/boot/compressed/misc.h | 1 +
>>  arch/x86/include/asm/kasan.h    | 2 +-
>>  arch/x86/kernel/setup.c         | 2 ++
>>  4 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index f4ef64bf824a..dc48eb5b664f 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -195,6 +195,7 @@ config X86
>>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>         select HAVE_ARCH_KASAN                  if X86_64
>>         select HAVE_ARCH_KASAN_VMALLOC          if X86_64
>> +       select HAVE_ARCH_KASAN_SW_TAGS          if ADDRESS_MASKING
>>         select HAVE_ARCH_KFENCE
>>         select HAVE_ARCH_KMSAN                  if X86_64
>>         select HAVE_ARCH_KGDB
>> @@ -402,6 +403,11 @@ config KASAN_SHADOW_OFFSET
>>         hex
>>         default 0xdffffc0000000000 if KASAN_GENERIC
>>
>> +config KASAN_SHADOW_SCALE_SHIFT
>> +       int
>> +       default 4 if KASAN_SW_TAGS
>> +       default 3
>
>What's the purpose of this config option? I think we can just change
>the value of the KASAN_SHADOW_SCALE_SHIFT define when KASAN_SW_TAGS is
>enabled.

Well, I was aiming at later adding the "default 5 if KASAN_SW_TAGS_DENSE", and
this way it would look much cleaner than the:

if KASAN_SW_TAGS
	if KASAN_SW_TAGS_DENSE
		KASAN_SHADOW_SCALE_SHIFT = 5
	else
		KASAN_SHADOW_SCALE_SHIFT = 4
else
	KASAN_SHADOW_SCALE_SHIFT = 3

But now that I think of it, it should be possible to overwrite the
KASAN_SHADOW_SCALE_SHIFT from non-arch code if dense mode is enabled.

That's a topic for the next series but I'd imagine all architectures would
normally use the 16 memory bytes / shadow byte and if they'd care for the dense
mode they'd go for 32 memory bytes / shadow byte. Or do you think that's a
faulty assumption?

>
>> +
>>  config HAVE_INTEL_TXT
>>         def_bool y
>>         depends on INTEL_IOMMU && ACPI
>> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
>> index dd8d1a85f671..f6a87e9ad200 100644
>> --- a/arch/x86/boot/compressed/misc.h
>> +++ b/arch/x86/boot/compressed/misc.h
>> @@ -13,6 +13,7 @@
>>  #undef CONFIG_PARAVIRT_SPINLOCKS
>>  #undef CONFIG_KASAN
>>  #undef CONFIG_KASAN_GENERIC
>> +#undef CONFIG_KASAN_SW_TAGS
>>
>>  #define __NO_FORTIFY
>>
>> diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
>> index 4bfd3641af84..cfc31e4a2f70 100644
>> --- a/arch/x86/include/asm/kasan.h
>> +++ b/arch/x86/include/asm/kasan.h
>> @@ -6,7 +6,7 @@
>>  #include <linux/kasan-tags.h>
>>  #include <linux/types.h>
>>
>> -#define KASAN_SHADOW_SCALE_SHIFT 3
>> +#define KASAN_SHADOW_SCALE_SHIFT CONFIG_KASAN_SHADOW_SCALE_SHIFT
>>
>>  /*
>>   * Compiler uses shadow offset assuming that addresses start
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index cebee310e200..768990c573ea 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -1124,6 +1124,8 @@ void __init setup_arch(char **cmdline_p)
>>
>>         kasan_init();
>>
>> +       kasan_init_sw_tags();
>> +
>>         /*
>>          * Sync back kernel address range.
>>          *
>> --
>> 2.47.1
>>

-- 
Kind regards
Maciej Wieczór-Retman

