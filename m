Return-Path: <linux-kernel+bounces-218665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B590C36E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 08:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3321A1C23284
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED07346A;
	Tue, 18 Jun 2024 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jB/3sd4H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24F3B295
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691539; cv=fail; b=mSgL3gjrJojhncAYPQqQxxqT2UCVnyLEVHHLang0kSRCDUw6xDdAm4BKNvikG40O5Htk1Hs/QjlWpcPa79NyGB9au9DrNZgltBwvAVKfhZc8sdEGk+WueSc5uRNCGtKWd8KISHdlFemu9PsjaWgwDMfTxhpE9bKdwkAmn8F7l1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691539; c=relaxed/simple;
	bh=jlrCJnPZPXSlbrj5iX76wiEjFVTqEUfX7HyfyfsDXAw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YrZ80NeQohjlnADQgEDsiSfTFJo7NOKVHb48TP9JL317vagWnLpjNrQuBYteDL03ChSw5EPrNREfdoyWWfY7IXXU6Lp34PXClbdNZKWeRHQ48pIuCzwgJ0AXn6saz/++ZIW7knmUPylXsgafFuCFrOMhygbu++sYwi6p5scuHB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jB/3sd4H; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718691537; x=1750227537;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jlrCJnPZPXSlbrj5iX76wiEjFVTqEUfX7HyfyfsDXAw=;
  b=jB/3sd4HmFoen1w0AJeM4F4HMJfYnYGTBmKfdzAdwFNmNFgPwxF1XNUf
   ZsjJPXscQizw3EJEGeYZdfOCPt+JFHKLCpdxdDTwT1fuipIhOjL+01jPF
   Q+nPeXI7c2XbomUDLlwK+GO+FvJmVt+Il7e/iO0aDKdQd71zXvcUG0PEK
   R4RIlqzSTwZQUOAGEEjePy9b52G95plODm7/V8ax8zIjhVQOlFYcKGmTz
   ouvFPnh8QZzc1E+B6JKxvYwXW3fAN3UoKi0vcOd+X4QU3forBZJbu2gNs
   og1dlcK/KsVWAcnZI9u+s7ivaWfQHiD8mEgWm4VnFe/Wt5YTcW7jbllq4
   w==;
X-CSE-ConnectionGUID: NcjZ7PRtR6GO5/XcKGbmhA==
X-CSE-MsgGUID: RoFDS2L5R6iSsOFxIPqVGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15263337"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15263337"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 23:18:56 -0700
X-CSE-ConnectionGUID: YReyL54XRiCH99rjb78j7w==
X-CSE-MsgGUID: 9O1fdf/iTbmg6PDGNdsrPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41911306"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 23:18:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 23:18:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 23:18:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 23:18:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 23:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CS138ZTKa8AfFKatP5Q/W027wW+j8BuWuxwjN91aZhhyWqxpQ/yqgOLfR1nyu9YZbq4Ef0iMoOHCgALGKbOwsiyhv916jj45AxziVZl02eHkEsgxdJkGmyQ4kOf0qhPeamZkVaT+BfsBhgZd1CTmCvGTUhtC+RPB4vipK6N3EMmx0niUo8ZAhvQPSerXZCQWZARevLqqKP2UTs2Bx9XEq3au0HUR9bAIKIV8MTUS3Tw2O4RfA4STGMmaC1+ZeaJpLmxTaVknnO3NwaIR9lbN61Den7UcZX+7Djbu1Z+j6C1qmG98m/MVgFTd5PFzH9lenDBL7zs2NSuTrZVY6ZF96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrGd19kMJj1CswqMfewOm+DgIblB17d8N2jzEh0/gU0=;
 b=VUipGYekAZdm3WfgiFpWv93d12jP1vK1lawkOeDFSPUSJrqVRZPpdQyArc/PutTZ3mGddOvDr8q+M1jwiA6KGrX+ecKhzjh7qpJQ+zM9nUV2iapNNUMiVvTTV6z4BaI31cbUVZCoABWSeWWAogAYpEiW8RWMA47pqWuiJQp/8YtxkqtyDMMU+v9MKYJQ7eeRPpSQBnD3SVnmXNI+NPSGtjZqbNoJGc2vwgNhzXla3alSQ12e77JG/kkF4Rk7KO9wHFYnxCQgCdjeYoNSyOo7VxXOviNr6SXNosyuiF4BHV8PRlkN/mIZ83n0DSOMKw+hWtNNHZzECzhb0uNyX8cfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by PH0PR11MB5829.namprd11.prod.outlook.com (2603:10b6:510:140::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 06:18:53 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 06:18:53 +0000
Date: Tue, 18 Jun 2024 14:10:39 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: Chen Yu <yu.c.chen@intel.com>, Mel Gorman <mgorman@techsingularity.net>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Chen Yu <yu.chen.surf@gmail.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: Re: [RFC PATCH] sched/numa: scan the vma if it has not been scanned
 for a while
Message-ID: <ZnEk3yARRPP9WXr9@yujie-X299>
References: <20240614045649.133878-1-yu.c.chen@intel.com>
 <021e0e63-7904-b952-af9c-7e1764e524dd@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <021e0e63-7904-b952-af9c-7e1764e524dd@amd.com>
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|PH0PR11MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 1510d602-7722-4c07-65b5-08dc8f5e86b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rEjz/XKUdvZ4zq/7MEpUAJMcXLezaexb5ukWICJ7Crymp6YTfrXunRzYM+3/?=
 =?us-ascii?Q?QvTpYqkeBOX70krEsxArrAKHb5oBTUtpHp+tItG58+QsyNdYLR42JSYMGPnn?=
 =?us-ascii?Q?+V7F8nLIHfkAqU0yoSLbpALZtg6Io8RRcttQSJgZkh7YmqCS+UU3Xqq9zYuf?=
 =?us-ascii?Q?9hmYmW5oW6sqvqpro/ATj9LLBhk+QCANx0l6o4IhzQpd/Cadd8A6K0KcGnp+?=
 =?us-ascii?Q?Ey6Ili0WdqT5DA+NgK8OG8uaJkNPS+rjf0v0B/qBi1J9lrmV/5OWLAUbqRTN?=
 =?us-ascii?Q?3l+q8zO13JIpNa/M0fTQjnRPbtXgfcp8t2ajKltIYpQurIx15/vn+psUVOv7?=
 =?us-ascii?Q?/qzRwSFAWQ+nLkn7tZP9p6mpGGHLjo4245mklnVRlsWTFUR03BaeJg8dzAHk?=
 =?us-ascii?Q?C1VseKRaJLiW7sICoFU88ob5BRISo/RHG+DEwPJhq2ixR2GMvzK6IVyWYldG?=
 =?us-ascii?Q?z4EWrtxPEG3AkJM7Yk90Pv9g0ssmC5hNnQjlo6kKTstx9+yF38dlGwQpNiGP?=
 =?us-ascii?Q?SoX2KPXH8an+56JRMwtZf/jm3w7FP4dcNi/cOrfYJ44+5oYwhIqJSFPfnKNj?=
 =?us-ascii?Q?yuWp59KhwJzh2bbv4YqQVzuA5U3DSYkjiejsCjkm9pvoFfA3eu+Y8t/1UHH/?=
 =?us-ascii?Q?pBSsQnHhJAk6qPT5YdAkWrr/n/Dhs/8rNh4OLwy1bPnzvoofx4eMeFMdzgy1?=
 =?us-ascii?Q?MNIj+qNiTZgVijiOjWcIQ0ecV4zMIAsZQjSnDkECJFPejP+jQSJc7JuYH922?=
 =?us-ascii?Q?AtKVi15L4QL8sYKjrGfWgo/AdndwXUDKL1T1MtG+e6yI95+vwrRaeHud0aV6?=
 =?us-ascii?Q?9JEQ3/s4Nhn4m6p5iL/CMeXihoPlVVVGk6PQUTz5w8Q6+Cvi7u2+CHdy80C8?=
 =?us-ascii?Q?LACbF28vKmuYkWSA/7XDucPApQMeneTPecyZJ4XIQEkN0yOyQjA58aolPbyV?=
 =?us-ascii?Q?5ktWW9zGsomEVQpvs+8t51ClIPo22PZFKRh+aMOWZDP2gdLozAtKdcY++jZ3?=
 =?us-ascii?Q?wzG2aqXLH6g4eyJDi+6EEPbccVkKqig5TLHCv5N6bZ0xhArNVilc764IPHOP?=
 =?us-ascii?Q?80PijJ5eDBkkAM57tFRTZijdkmi1Yi9MWEk9ERtstZEJ0JoTEsraxOOQDqG8?=
 =?us-ascii?Q?8o031var82/OCCkA++944LZzeVcMhmYWoU+Ou6UQAYEsFcDglswujYX4FYPo?=
 =?us-ascii?Q?tEain7Divcf923eIVVQNcCgD4MMabM1zzz+2Wcp44sYqnAnpTNP8HHZdunA8?=
 =?us-ascii?Q?68/ay+T6r66UrYNxt+3gfOcL16Pw67fyISPuBR9rIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9lQBDexaYlQo8qsmVFQYBMclyQunkqHeHcJQG73sRG8xUu+P63HlweKCH60?=
 =?us-ascii?Q?N2GQZC4MsQ7vOsnyD4hAbw6EDk7zZp7BnHJsZszdSWwi9b3+WeUrAfl5gVrB?=
 =?us-ascii?Q?MEmmf5v+F4VJ44h0sRkUN0ps/eQl5XRxufQp3VNnT81DgoIkN3YirOFB8oSq?=
 =?us-ascii?Q?ZmxMjwbpmW5Y1bAWFpmohsfoubNQW4eUONDFvax2hTeiI1JQof+LxhiDVymo?=
 =?us-ascii?Q?pswVImFVWKWhrrhGTZxd++VtM9Wqr7g6dWSF00AO8WkSWFtinnFPwS8Q6IRY?=
 =?us-ascii?Q?l55tk88ltAY7ySScu/FK/YteDz4fsEk5gSmZKBXnfXSVsjx2KBfHsE7hispn?=
 =?us-ascii?Q?nZC/aODsPlfTya9obiA+3Sl0Wct3vcnrcpaMNGMKOzyD30HV+Eo0H2ixdEjO?=
 =?us-ascii?Q?YC7QK4b+pQE+5DDlJV7j2W0ncz9TaMKxB8SBBnYYQp/yW8Nty899NPI1ItgX?=
 =?us-ascii?Q?vVZajabMBOfvdtoWwFkB2OH7sTRauLsgruFROM6+FBMxnOOqv/y/vmpsjg7a?=
 =?us-ascii?Q?9eNpupQo0mLq8oc7rqWQijZg5EaaiBKy3E046UkuaXmggukjh+MQPK/M78jH?=
 =?us-ascii?Q?1XcuCd5zBXjnBi3ieFYIgUn+ZR+2nFhVkd8lhclZILXWSii+5f+4sTvBqKyK?=
 =?us-ascii?Q?H9XSme//FbD8AaQYb2jFq1/A9zCGxXnHHxGCeLcTlbQxM+Wt15fn/k7Q3rf+?=
 =?us-ascii?Q?SkPhTGNEKiyuj9c8qnL/9lR33NW2UVE4aur8+g8oAfhfSHL12O4iAi/xxt0U?=
 =?us-ascii?Q?L//AOOKQu8pWaU8baZHCwDflZBl4lb08iWowAyqCtEiDa+fE7tT2DIOE27GF?=
 =?us-ascii?Q?QsCOr3d6vWLB7Ohnh3+Q6bTEa2x72KFN+7yOKw9OD8EXx/sk7oFmnux6cgZe?=
 =?us-ascii?Q?cVJiuyoz2joV0hCT194Oqg5IqC0ICIm4U6RdRVtI6Texr2jwQ4JJQQKnfiHN?=
 =?us-ascii?Q?0XmBsCNQv6/hvtq48ltv/TWyfmdVHKt2MEeEtBWm+pi3Lq+UuDMkKpCoJi6M?=
 =?us-ascii?Q?qAIwfy9lGyGzc4A213M/6WJ21x9o97OYO4uW7fLyF++vb/VDDHWm8BlcDF33?=
 =?us-ascii?Q?/fN7WK8+jbRyzTAjap3m/3PlYeUnLqGZDcY6NUia4+UD8mEfroBbmHLNOqko?=
 =?us-ascii?Q?SYJAQzcEv2Cdxpwm7LxV6kyp89Hu1R3KMY9QsHjyWBU82qtVYR/SRq1UevaM?=
 =?us-ascii?Q?VIBeDngsXQdrgl2J+doT1z6XzTm5xRLZne8e1TEkUpZxmEOqcn2q3LWF+gfi?=
 =?us-ascii?Q?h2FsHGIAzjixkwMXqHSMZrpP1hOaStIcGrwUn8MHaotKyOy0hSCl/0Klc1c0?=
 =?us-ascii?Q?0pieB1Z6qWyyryqVB+7+1toYTZQsZVzzfbnm0h3EEBFz8p9raf33q/cd75CO?=
 =?us-ascii?Q?pjbJo//ib1nDLAkciwqW0OfPLbBvVjQlkOqmiVinyyEC//XLWn3c2nax/vxL?=
 =?us-ascii?Q?D8SMXYR9OlFJ8XEGyWlgiSE1Gks2xd2WtRGEqAZQiUigsE/OVGGoU5Og9Y9b?=
 =?us-ascii?Q?IYSl7u9zx6O2r7TpMkT/KZyg38nt1L7jxw15+SPR+HDucrOI3rgUaaGa9qIE?=
 =?us-ascii?Q?ivpL7mmEocKhieWnsVTVfasc5mjaOLHDuQ5D14+h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1510d602-7722-4c07-65b5-08dc8f5e86b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:18:53.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvFYBgxlxJyCDF1TrKgVzDMY7Mp1qWfwh9teczTw2YMRg7M6JMQE5AFeYzWQr38a5/Dimy2383ihFBHsCz//Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5829
X-OriginatorOrg: intel.com

Hi Raghu,

On Tue, Jun 18, 2024 at 12:41:05AM +0530, Raghavendra K T wrote:
> On 6/14/2024 10:26 AM, Chen Yu wrote:
> > From: Yujie Liu <yujie.liu@intel.com>
> > 
> > Problem statement:
> > Since commit fc137c0ddab2 ("sched/numa: enhance vma scanning logic"), the
> > Numa vma scan overhead has been reduced a lot. Meanwhile, it could be
> > a double-sword that, the reducing of the vma scan might create less Numa
> > page fault information. The insufficient information makes it harder for
> > the Numa balancer to make decision. Later,
> > commit b7a5b537c55c08 ("sched/numa: Complete scanning of partial VMAs
> > regardless of PID activity") and commit 84db47ca7146d7 ("sched/numa: Fix
> > mm numa_scan_seq based unconditional scan") are found to bring back part
> > of the performance.
> > 
> > Recently when running SPECcpu on a 320 CPUs/2 Sockets system, a long
> > duration of remote Numa node read was observed by PMU events. It causes
> > high core-to-core variance and performance penalty. After the
> > investigation, it is found that many vmas are skipped due to the active
> > PID check. According to the trace events, in most cases, vma_is_accessed()
> > returns false because both pids_active[0] and pids_active[1] have been
> > cleared.
> > 
> 
> Thank you for reporting this and also giving potential fix.
> I do think this is a good fix to start with.

Thanks a lot for your valuable comments and suggestions.

> > As an experiment, if the vma_is_accessed() is hacked to always return true,
> > the long duration remote Numa access is gone.
> > 
> > Proposal:
> > The main idea is to adjust vma_is_accessed() to let it return true easier.
> > 
> > solution 1 is to extend the pids_active[] from 2 to N, which has already
> > been proposed by Peter[1]. And how to decide N needs investigation.
> > 
> 
> I am curious if this (PeterZ's suggestion) implementation in PATCH1 of
> link:
> https://lore.kernel.org/linux-mm/cover.1710829750.git.raghavendra.kt@amd.com/
> 
> get some benefit. I did not see good usecase at that point. but worth a
> try to see if it improves performance in your case.

PATCH1 extends the array size of pids_active[] from 2 to 4, so the
history info can be kept for a longer time, but it is possible that the
scanning could still be missed after the task sleeps for a long enough
time. It seems that the N could be task-specific rather than a fixed
value.

Anyway, we will test PATCH1 to see if it helps in our benchmark and
come back later.

> > solution 2 is to compare the diff between mm->numa_scan_seq and
> > vma->numab_state->prev_scan_seq. If the diff has exceeded the threshold,
> > scan the vma.
> > 
> > solution 2 can be used to cover process-based workload(SPECcpu eg). The
> > reason is: There is only 1 thread within this process. If this process
> > access the vma at the beginning, then sleeps for a long time, the
> > pid_active array will be cleared. When this process is woken up, it will
> > never get a chance to set prot_none anymore. Because only the first 2
> > times of access is regarded as accessed:
> > (current->mm->numa_scan_seq) - vma->numab_state->start_scan_seq) < 2
> > and no other threads can help set this prot_none.
> > 
> 
> To Summarize: (just thinking loud on the problem IIUC)
> The issue overall is, we are not handling the scanning of a single
> (fewer) thread task that sleeps or inactive) some time adequately.
> 
> one solution is to unconditionally return true (in a way inversely
> proportional to number of threads in a task).
> 
> But,
> 1. Does it regress single (or fewer) threaded tasks which does
>  not really need aggressive scanning.

We haven't observed such regression so far as we don't have a suitable
workload that can well represent the scenario of "tasks that do not
need aggressive scanning."

In theory, it will bring extra scanning overhead, but the penalty of
missing the necessary scanning for the tasks that do need to be migrated
may be more serious since it can result in long time remote node memory
access. This is more likely a trade-off between the scanning cost and
coverage.

> 2. Are we able to address the issue for multi threaded tasks which
> show similar kind of pattern (viz., inactive for some duration regularly).

Theoretically it should do. If multi-threads access different VMAs of
their own, like autonuma bench THREAD_LOCAL, each thread can only help
itself to do the pg_none tagging. We have observed slight performance
improvement with this patch applied when running autonuma bench
THREAD_LOCAL.

In common use cases, tasks with multiple threads are likely to share
some vmas, so there could be higher chance that other threads help tag
the pg_none for the current thread, thus we can tolerate more vma skip,
and vice versa.

Thanks,
Yujie

> Having said this,
> I do not have any thing strong against the approach.
> I will also try to reproduce the issue, mean while thinking, if there could
> be a better approach.
> 
> (unrelated to this, /me still think more scanning needed for tasks with
>  a bigger vma something like PATCH3 in same link given above).
> 
> > This patch is mainly to raise this question, and seek for suggestion from
> > the community to handle it properly. Thanks in advance for any suggestion.
> > 
> > Link: https://lore.kernel.org/lkml/Y9zxkGf50bqkucum@hirez.programming.kicks-ass.net/ #1
> > Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
> > Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> > ---
> >   kernel/sched/fair.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a5b1ae0aa55..2b74fc06fb95 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3188,6 +3188,14 @@ static bool vma_is_accessed(struct mm_struct *mm, struct vm_area_struct *vma)
> >   		return true;
> >   	}
> > +	/*
> > +	 * This vma has not been accessed for a while, and has limited number of threads
> > +	 * within the current task can help.
> > +	 */
> > +	if (READ_ONCE(mm->numa_scan_seq) >
> > +	   (vma->numab_state->prev_scan_seq + get_nr_threads(current)))
> > +		return true;
> > +
> 
> I see we do update prev_scan_seq to current numa_scan_seq at the
> end of scanning. So we are good here, by just returning true.
> 
> >   	return false;
> >   }
> 
> Thanks and Regards
> - Raghu

