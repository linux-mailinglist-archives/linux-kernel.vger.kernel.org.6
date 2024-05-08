Return-Path: <linux-kernel+bounces-172927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890EF8BF8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C325B1F247F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0860548E5;
	Wed,  8 May 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahzyW9Nt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87953E00
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157478; cv=fail; b=BxE7N0XZ0+lx7W0TLTOp+YBRK3dsm2e8Sw+s2p36owJRcIcOrxSjQjfqIOoj57FR797JX87jXaK7XEy4G6GDOklHDITMb/lzAETtpy58A5OriT8GoCgroXQJ2GjT3XSChLdaNldTRIVjv5CmHNtCeWQqFgR6f8DFRg6gHyj/918=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157478; c=relaxed/simple;
	bh=PuS0DnVGNNyV9NqGQHxi5A2MhHuZcko3+2wartNN9kw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELutYo0cid3XolFntWd3WkRrmHjjqUVVcnAdsnaU56ocZr+rW5Hn/LXf5GeNqwFWeTzztcRVIjkpIKaMkDA/3fk1WXdvLGXdDkDTz3uxKogEcgTFzZBhZhNbAQ/oxYyxcGWdLm12nVokWhK49qHUnAyAN/sBxz5sC5yZ8Dj2rOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahzyW9Nt; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715157477; x=1746693477;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PuS0DnVGNNyV9NqGQHxi5A2MhHuZcko3+2wartNN9kw=;
  b=ahzyW9NtsNy8vwpZ6hYUEIfC8edYznbZmuhGknAMWmcbuevPq65Hklib
   GOqfZFjX/iZIvYGwspYACS8lThuUFVZjoreURfjGzqg1U7hKqm2lDjN42
   8Np3QLe9OzCwlQgtT1GHCClv8SL7LxaDXfBz4UGWasCxuKpTu41BKNoRg
   VoAbBiwRRB3+FVo9AXE925X8lz3gukEsmUZcPSwrghufg8rCLfkIczwIE
   5pLqXRsGa7c0Tb72L9IVeh6LhDP73M8XIIeOR6xJCT24QhQrTkWDwuNZG
   AkywrzB1IGAKFpxAGnP2gmKwcE+l8Gm9xKh8a30Io4XK9tfJcrNSYoTi7
   A==;
X-CSE-ConnectionGUID: 7cwOMUHQRcuMzNLFdsHeWg==
X-CSE-MsgGUID: Tlzf5Dl8QH61bfqMwq9ckA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10855602"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10855602"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 01:37:57 -0700
X-CSE-ConnectionGUID: Ma9hA/HfTM6jr4Cn3pRguw==
X-CSE-MsgGUID: ok2Muu3sRjCF9vzNkurZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="66244065"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 01:37:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 01:37:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 01:37:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 01:37:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 01:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foq55IU5dBoBeNiuITtqYMvPqdlAzcjsBN6srvmGnuG5QyDdOhPAdx2YsT5yQ8ET4U+qmd2uQcE9y9ESpd4FuJyFBYX2LeRQIjEBOHmFre0fa3iyIA9sRIHsbksHn/g63aUCV2CGoR0IpiKZfYYis50O9WY7SwpjJXHP2Pjkwfef+hwddY2tvhIjV3DPj6TwvUKHS4lCzKrvNBRH38u6xvkU30+DihsLw9iorYSykF36IyOFUTrTSA3YnmEvmsRbVjtitXXwyl/X6VQ55R3Ph9CTRKRcYveSQQyT+YAj7H7cNLjevaremtDIPGLbbNke9HMwYsQLFbPjkYL7/oF29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZRIE8QP+YJQhiYSLJwDMS2viN5R0wCmbWBCP3GA4ok=;
 b=ijB7nCNFp1yBJ+mKZqPqAF4bwEDPGUrxvwtsrvB47d9QdqrhS15IBHsoof0gcu3cqVN3csBeYuwpqPMNoO7hXrE2cTvrQ6lcXi921kUbae9foW4DsYDallMHqaURaAC/EjHyr4BazjSRTUk6w+m2jR30U0/+THK/lQnYlhSaYjUPb8TxtmpKfIZrMqkF09MTRTvnP4hLTDOKOzkR0Vbz1gG5+jn/HWwcoNcotbLHJm+QE9axFgtlNIn4gGTGgvRdud59AdNnu3bm0YNzTRkb2WgZsLSjD8to9i8mDIObBeCI1S6JA/3Wxf85IP63Ou2bm8w8PvbsVgP426ClA3NimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 08:37:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 08:37:52 +0000
Date: Wed, 8 May 2024 16:37:42 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Sean Christopherson <seanjc@google.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>, "Ingo
 Molnar" <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>,
	<fengwei.yin@intel.com>, <yujie.liu@intel.com>, <oliver.sang@intel.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
 WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
Message-ID: <Zjs51oZWhibDhWa3@xsang-OptiPlex-9020>
References: <ZjFLpkgI3Zl4dsXs@google.com>
 <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local>
 <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <Zjj3Lrv2NNHLEzzk@google.com>
 <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
 <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>
 <20240507114814.GBZjoU_u5kYBhLips3@fat_crate.local>
 <Zjsy8v0pZHPMkjPY@xsang-OptiPlex-9020>
 <20240508082438.GBZjs2xsn4diYXU4ud@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240508082438.GBZjs2xsn4diYXU4ud@fat_crate.local>
X-ClientProxiedBy: KL1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:820:d::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dbf7d0-ab32-47e8-916f-08dc6f3a2626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d50ABQLw3XRN0MN9yYwBXtiNZ5Yft2a5wgQlXw8lf3WrS0IUbQMDSb47Ejq0?=
 =?us-ascii?Q?rnxvQNcn4J9JtXTZnxjK9VHwqac5bVpE75qln5ms/th8UIi6p3n97JiaNLqr?=
 =?us-ascii?Q?SaJz0XK/PBJRnJ4cvMTa/b7EVVolDaHat+82d5wr/38cytxUkhBESfv8ZJSm?=
 =?us-ascii?Q?wO/ypypl/zE7qNDRNU6OhOjLlK3T6zfsA9U4JtjCJkZQQ/fol6FeGcwV5MDb?=
 =?us-ascii?Q?cPdOTzSxljrAiLbs0jsRLUcqdH5mIcywS0dGxa/fM+pdAI+1K4TElPdvr00H?=
 =?us-ascii?Q?6a6V0NTVBxCXPp5tccxRoB6hQEYlpDMTYSKb9ubmVyohJtANmzfFTyaWZpsJ?=
 =?us-ascii?Q?037RkGGbUGdGK3VyZzQ71YyGtDSRNAjhETV7s+rxQSdvHtAMpntfVnAklrEZ?=
 =?us-ascii?Q?cLoVpiE1zfCE4aSXnWM+JasdAVnm9LNvZC4sBdUx3DqxKDC1str0jNpBvGSq?=
 =?us-ascii?Q?5LptwRI1Mk+zyfsAvNwYjjaJ/gtRrMLBtLuAuV1VQ943qqofqeVpkPpb1WCx?=
 =?us-ascii?Q?hcRj2f1e945vLGe7fPO5GHJuryi1xL18D4GOHVVOBYIAS/4d8PiTfJfVwYmq?=
 =?us-ascii?Q?DacSgtjrLg0ntBpdfp5D1arwmvgRFhzKteFsiXasujlxlFlh5TVqayOB93g4?=
 =?us-ascii?Q?LUBYJMk0o9rGzS5h8AQZ27c6njMtkEkyxKZCd441UVT5h715uOKPU2vCJa2I?=
 =?us-ascii?Q?sqB0tCQ2fcVxuKTo+DtXAmrjY/hLewo94YrGCQxUy5IdM/vdbouEdExwQfJ4?=
 =?us-ascii?Q?hCVkuBgHPWarrFRyvu13djz9sjfM3q2LO/14oDomcTUTBLJWYKM+F6SNLtbY?=
 =?us-ascii?Q?S79A/XsSC+Io13Hji6TUTJbSawqb2wBwbQUNFriV8vaO5H6IbzX6FZIFaVWs?=
 =?us-ascii?Q?g1bsYxQk7si5vsVkGmuY0Hr1YTh/uFWh31x12DgWM/b4VPqFYwttBnNBhMwC?=
 =?us-ascii?Q?BCoBW50D/3vnTgbxXLGv/n0pHhdFxOixUak9iqdV3wYT3DwnIXfRHyC/3INr?=
 =?us-ascii?Q?0I+3Un8lOKO5GDFwbHIHdjp6T47y06+TOjHkr+gnKcL0J9mGExFPkA2aDj5y?=
 =?us-ascii?Q?Laoa1JGv2XBRr1iVKLu/1atJYz/9cQwwKt10Y+kCW9l90zWIL6TgO/hvU3iv?=
 =?us-ascii?Q?RnCSoJdH1TKwmlcvV/+uqUl3NP2HqjWDEhIY8akLy+saBLsTgqRv5EQMrfSR?=
 =?us-ascii?Q?5Dr4nuA6Yy9duUQFWqi1vmR5a+E2JZuqhMpVcxmgD5IEDVdiHbGEOrg13X0?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+RQ4huqoQESBeCtyMSxQbyrP6ULrfFwAxkDE4JaB5Ams4zR6MVbudWDovCRx?=
 =?us-ascii?Q?F8e5E8i1PI9Cqj8S0khDjR+v094ycWGACFoM5gHZGDZflGhCI7NiCjIGla27?=
 =?us-ascii?Q?QJq82qAQSkaqoYLuoIOdMUxPkHNt4abJWylgZihccNUrY7n4r694NP/+2hnk?=
 =?us-ascii?Q?D2AIHrBn0kyq2fKG6diu9EfuhGMdgQ/lf5P2zyNfwmCS5w4Gma4dy/YE9o7k?=
 =?us-ascii?Q?2/1Ds5ZYsIT0f2Ba3w1UvZ/HdLfke24rzJguLpzE/u6n18fRDQG51zbYy96e?=
 =?us-ascii?Q?OtUPKZ1L0bFaw++2ldb9bhqb+gTLiXjEXzUcYnfZHx0FaomDffUGYnv3qpRX?=
 =?us-ascii?Q?GGGgFu43M5RJ9jRaW9LOZkGJnQvQbdXN2tcpCYx+tyx/S7O8nFtTBN4N8zR/?=
 =?us-ascii?Q?0JnmqNl+nkVz4OwceR7CchSeWOaMHQn4Nny0722zvoiGcsY/4JLuCyY+HEsM?=
 =?us-ascii?Q?crA+SsZq8bafucxOUW+Ntmx/Z8rkctAOKfLpEVDmMr6KvTzA8uSNVaSuLRGE?=
 =?us-ascii?Q?x+PqyuEepN3jwj7CoijTBObn2Q7XgWRRdl7WyPMDZDyQEnLfR3x78CGlANRR?=
 =?us-ascii?Q?HAsXWR5snchbHSFAiLhJyPNIYCnClhm/aS/X8QPimVwP5waTVfJOalOFXiJW?=
 =?us-ascii?Q?jX/UGcBrLIRB4fSo+VPY9nXK+dGBQ49RdmOyVHtq6KarEanblL/C8iwtBDWE?=
 =?us-ascii?Q?7VBKagRS12Tp1rLrcsB5AN/qng8oeazMOUX25Hmf0dCH5t/4Yjmj1RP3Dust?=
 =?us-ascii?Q?8SDCZYjP15EfwwCj3TMoWp5ynEMMBJbjbx0xYYZ4XwQIOanxPIED86kILBOr?=
 =?us-ascii?Q?M/2G/lgK6N++ZS51MGE3JeR48ny1cbmvVDss5cmx20lBNKfDon0K6xq1bhkX?=
 =?us-ascii?Q?4TASTsKYI4r/Nkjn9eIaoj3h8X6/gWYQ3LNyDwtUaXWsWkWsaAdZiPufzrWd?=
 =?us-ascii?Q?T/TsC9wJCzjNi6/bprfPn6mEKi+3rN95TmgHqkaQB6qlmPp7BwpJERoz+zIR?=
 =?us-ascii?Q?RXs6GP1MOTY/77yAk4heIKkcbjmhZCfx+kMBuMDM+dNAgqi+44XVm010ksBS?=
 =?us-ascii?Q?6IDTshXrm1P4KpqwGzDkUHhvLyMHaoEdZyoMYI6eKmL5r0eqmxZ/HCLK+ZRp?=
 =?us-ascii?Q?h4rxFtvuLKcAOrDymyL6wYpFagfguNTUikhVDweYc2TuOg9lZzEGV7Bc4Vxb?=
 =?us-ascii?Q?ru0gu7Cl4Be0x5r0SkzBlKiG1xWelQxUPsSjI8xgnO4gAF5SQNPnwo1YJjGl?=
 =?us-ascii?Q?/emkE/gms59K2pbFHUge/JX7lsDDRgiPRFCb4cHVNmhkqQqQjhjVZDciBnd+?=
 =?us-ascii?Q?UOC4RJ0q9eMi0wDZeLBjuAtfLsLuBstgc4rbjGfmfMXS6TsjZTHDNr3lcFu7?=
 =?us-ascii?Q?Blxay5Dvxv8SLCph76awnKJQcuiQx5vg9iQNU3Z1sV9wprJkZrkwGgdEz1iZ?=
 =?us-ascii?Q?q6AON8P0CWAeaAMmYqDalTcTHCCLc72JIYUfwnxOq3eJzQWIJwdJhr13nf3s?=
 =?us-ascii?Q?5qB/NBj5ItF7ImctfcWXkIMQnGKfHuN+ZdJQNj2j40v4dpDcMo1lPPfwvPx0?=
 =?us-ascii?Q?dkfk/yQvtDrzx+URowY9d6E8M+w1wWmyNrpj5UhBYTn2LIVCWwR8zoNzB/cF?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dbf7d0-ab32-47e8-916f-08dc6f3a2626
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 08:37:51.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hI/F4+OjJqy/pGeFSPcDy7eqWMJ+xvTQOyP0hblQLXYNAFwWwJ3AS2vyC9Zh+7RwQ25yCAL7pZfa9sUnUwI/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com

hi, Boris,

On Wed, May 08, 2024 at 10:24:38AM +0200, Borislav Petkov wrote:
> On Wed, May 08, 2024 at 04:08:18PM +0800, Oliver Sang wrote:
> > we really don't do any manual change recently, however, per your reminding,
> > we rerun tests on both ee8962082a and its parent v6.9-rc3 again.
> > 
> > while we made original report, we always saw below for both commits.
> > "x86/cpu: VMX (outside TXT) disabled by BIOS"
> > 
> > by rerun today, we cannot see it again, on both commits.
> 
> Yeah, from the last dump you shouldn't be seeing it.
> 
> > then for ee8962082a, the reported
> >   WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
> > disappeared also while no "x86/cpu: VMX (outside TXT) disabled by BIOS"
> 
> Yeah, it does feel like something underneath the OS has changed/is
> changing for this to happen.
> 
> > we are using kexec to boot into kernel, and the kernel images keep same,
> > so we are sure this strage phenomenon is not caused by kernel build.
> 
> Hmm, kexec won't go through BIOS so I can imagine if the kernel has left
> FEAT_CTL in some weird state... but then if it has been locked, nothing
> should change it anymore.
> 
> > now we doubt it's really a bios issue, we found another similar machine,
> > which also show "x86/cpu: VMX (outside TXT) disabled by BIOS", but after
> > several rounds of cold reboot, the message disappeared, too.
> 
> If you see that again, please run my branch with the debug patch - that
> should at least tell us what's weird in FEAT_CTL.

thanks a lot for education! sure, we will do that.

> 
> > we will investigate this BIOS further and avoid this kind of misleading
> > report in the future.
> > 
> > sorry again :(
> 
> No worries, thanks for testing kernels and thanks Sean too. :-)
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

