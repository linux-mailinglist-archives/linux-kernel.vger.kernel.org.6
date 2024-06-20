Return-Path: <linux-kernel+bounces-223599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F20911566
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190DB1F22443
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A2F130ADA;
	Thu, 20 Jun 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2hIhVOX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCF482ED;
	Thu, 20 Jun 2024 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921117; cv=fail; b=fa977GfOQ26PbiUbcjiceTYeLwEzuK9A6QmhJSAlXG3Hxuz8ZG1+oIupaRSnDFn0lV1fa11sue2PR1AjlBgdAiXEdhikdFbHkE5K8r3Sy+kQGcerUvbfJC6B0tMlVLoI9c+PhoYu7xguFUw9uggolTXaS1clEhVWCB/AG1Rbfmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921117; c=relaxed/simple;
	bh=r+XjqaRrmoGfzMIDuM5Eo1zQR3kbAP+5tfgASnEO5l8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XCgxk1gckNj7q+Cdb/6RYM5FvSCE/RfSuL4w9KyJt8Nx4rCoRy+SdChNkJgX8/05be4JnN23LZoTnMqWsqHfWxSSkqv6Qbn0CkbCdMjqeCEPDex0XrQE2R/3kbd3baZy9D3srHGnOzcOQcrZObE3uEco2AJDsNPkLZ0Rl4lrcjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2hIhVOX; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718921116; x=1750457116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r+XjqaRrmoGfzMIDuM5Eo1zQR3kbAP+5tfgASnEO5l8=;
  b=k2hIhVOXTaylRAObILwh/c2c2EEIcOxrW8Ht4nCYurEFxUvaikjlNzvH
   +lMuqpFjIBm66qy8lqNLkcJ53s5NtIgQ2Yn//a2467fBaKa7jmbSEKKO0
   TIWMCGmHyze0zmKPDtV7jsZmGSvA1MqwgIt2Jo8tHp6/OsTLN/xz9QC8V
   u70JTYXcFxlxJWNxFCtytM0rnzdRLTe83t4nFuQN5pIJu9mwDx9TZLPPQ
   ZM9JM4K4igag9qeH1X9HuP/LaKa/LTjDSKeVGdC8oRZOr1HDeA88a5y8L
   mgKbn/YW3N1de2cZxRCGHv0g8EyTzPMz3LN3S479jvXB313r3aSA5tNBJ
   A==;
X-CSE-ConnectionGUID: IXlIn6J4QNSet7On3Q+JEg==
X-CSE-MsgGUID: MIjKe/u6Qm2zDN/ut/YDRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15767275"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15767275"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:05:14 -0700
X-CSE-ConnectionGUID: 06ALTHyCQW6X5sRdQL2uKg==
X-CSE-MsgGUID: svPobaT7T7azY2n6YlDhkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="47340087"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 15:05:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 15:05:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 15:05:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 15:05:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTFR54F2QIZIfIXCvaMxZgUKs8n3OQapXjfsFHWEOWZwnrcRkT9wSqfzsNPOPQSLg47gXbrZR9ApBJ1FLdquzKhvpg03CZ5WbV3wrTekLLNt6HvYrfjsbaksorRJfEwAwyr5lk1suEPVs0Tas34IslBkiE+nYaOQXNoKPaVQk+0OP6kx2X44p3pnDEAeLEfh8APyppIgEqT/XJN0q5mp0L08s9n3d/yQDEupwKbjOJbK2bhEO8kn47xbOR8bE4BsvsUl6fU7Sa2fehT4pfEjK05RCcTxrMPVnCd/SyfYAPLMqPWQ5SMKaS+zs8dw8IHjUan10WvczkZaQiZGOdd45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WlUqV92FbCQb/obNF6tZVhMRaOUi2edkIwRXGFcnG0=;
 b=CiJckYXVTgmhDV80F0nVLFhV0HQYAIJ+woHsSu62tKT6e2J55+fM2CQ5Lgfs8OaRmSEOx5gBETKuG8lwOzjPsmHDnr5655p+guQ+pWQqU1yqTv7L3CkE7QbPQbeUThQ7v+h8CcD8QfBRgr7+vVTaxl2a75B0qZY49qx4UojOkijnZpoo7AXqAhvXQNVHP0TGcpK/TPf9Xf7eGMlYaSgwYJv6tRucdR+In+fl1VHNYNM0CxRsGWzz35Zd7NUiLGn48hbXlivt7LOcvsIM2gZheUFjOV33nIAdO4opCyXhitJR3+c+8wGLxcxHSjgFGepIrmPx2K1Ejok49Uc9MG6sVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Thu, 20 Jun
 2024 22:05:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 22:05:09 +0000
Message-ID: <a14ac6eb-0ffd-4c11-9c9e-ea70f8d4a70d@intel.com>
Date: Thu, 20 Jun 2024 15:05:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] x86/resctrl: Introduce the interface to display
 monitor mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <3b9ef8bc03c1004794a087537c6f2f051760402d.1716552602.git.babu.moger@amd.com>
 <a453b19b-a909-49a5-9512-ae69c48db6c2@intel.com>
 <b792d729-669b-4785-bdbb-23230f2e993e@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b792d729-669b-4785-bdbb-23230f2e993e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:303:b8::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 62194f43-74ee-4df0-c4ee-08dc91750ccc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmloaDB5UHBIeThROUpmaTVUWm5kRFMrTi9Pa1hSRGFCSEpuelJua0xaMkxF?=
 =?utf-8?B?MXhGd0pCeERIL3pBc0JPL2dDYXF5aXFFWkxuMTUrZytDeHlzWXZJM2xXczll?=
 =?utf-8?B?djBUb08xZm5Gc0F2NWNacnVzMmZDTzNtbytwcnZOYUFzZTFJRkpWN2lXcFBY?=
 =?utf-8?B?ZWpGSkt6T2U3bzkvQ3FkRlRRZ3dTK2xla2F0cmhKdCtPTHdycG5nZUlCVWlG?=
 =?utf-8?B?ek9GWjJ6eDBnU3RmUEpnQWNNTWtCdHJzY3V1WlNoY05UYjZYeDVwTUFCdXVs?=
 =?utf-8?B?S3hJNFo1RzNVUXR2ZVJoT2Q4dGJWRDYxNUpzeFFkTjUxYkZFMGFrbXZsM3pR?=
 =?utf-8?B?QUpIMndBU3lURHRRRjhUaHFYL0xUVHdVeEpMbDAxaGlKa0REYlJiUmVncEdY?=
 =?utf-8?B?VElJcVBJNk5nbWpka25aaEtQRDYvcmJKTFB2akJXMkw5emlwMDk1bGlGYzhT?=
 =?utf-8?B?cnh2TGlJekRpUjRaRE50cFRBYkdzRVpvMUNYQnhPWDNMM05tVCs1OE1JY05S?=
 =?utf-8?B?c3NRMWdHS1VlcXFHTFE2N2x2V1pCcDFreW5PTG5nMHRmUlA2UnpnZjRMUkM1?=
 =?utf-8?B?QjdkQ0JMa29NaXZyenlCUzN3RkVaczZhNGlYbSt4ZHFaOE82MlRUeHNnRS8x?=
 =?utf-8?B?aXVndnV4ZGpkNEZIdE1NYkZqVm5nVWE4VXk4bWJWQzRDWkV0ZUMxeGNYZ0VD?=
 =?utf-8?B?K1pUWEhCT2srMjU1bEJmNEpHWHRNT1lLbXJ0bFdjRjIvUFV6bGI0NXIxaE1E?=
 =?utf-8?B?YWVrcUxLV05YTVVJd0duLzM0WkhvTWhXUXJ3MURPTFdBQzN0cHkxNHczU1BV?=
 =?utf-8?B?YkUvWFVaSGpGNzVxa0hrVlRoaWxQUzdtbE1JUHphMEJxSnFadnprQm5TamQ4?=
 =?utf-8?B?M2x5MERlTUExdnUrNExkTTN3bjc4QlcvOWFlUDhEUDNOYTJ3OVZmWU1INlh1?=
 =?utf-8?B?SzY2YkhDb2E5U3d3WHNCT0gzOUo3U2YwV2QxS3psR2VvaUpYM25oOVBpcUtv?=
 =?utf-8?B?QVhKcnhUR0tHdEF0MGJxNU9LakEyQklEdTFxY04wa0laMzJzZlp3ZWg5Y3lM?=
 =?utf-8?B?K3ZMWWlrb0dLdHJ3VGh3VER1bVhoQmJGTUxORnc4V2FhQjNuYkxMQUNTcFpJ?=
 =?utf-8?B?dm4zQVM1UzM5alZvMkJwTktRaGxGSlNGMkVzQ3VQVG9RdkZ3dTVGT2NZVDIv?=
 =?utf-8?B?d1dwVDBvQitUK0JvQzlXZzZSV2w3WUlrTlhCWjFlajZkdVVmVHpLbExQbVl5?=
 =?utf-8?B?eE9ROFo3ZWYwS0c1dkVxaW9Jbm1SaTZDQm92R2RRdklVNk5TaXpIMVY3MzFi?=
 =?utf-8?B?UUJKTGZ5R3l2NW44UmR5UVFDOE9CNmMxYUk4MUtpWFgyZ1pFUVA2MjVLTFY3?=
 =?utf-8?B?bFdUcTJlVEZCRWRpUTZ4THVzc012ZHhBREp4MkVqdkRpemlGelhUNlFvU2RV?=
 =?utf-8?B?ZmVHbElGSDVNbUtHYjQrTG00bnVjWnRPTXZFWlNQYUU3b3BZZXNkRG5IVElu?=
 =?utf-8?B?Y3ArZU4xSjd5bC8zVWVYcTBuRXE2cHZlUGU4NHZhdXRRZE1KZWJYS3k3VVlq?=
 =?utf-8?B?NEo3UmFkQUxZVnpza3Y4ZERBdVQ5RlFOVjQ4VElhUWlWVjZvOXR6eEdRREh0?=
 =?utf-8?B?RzMvemZ3ZXltMU9sTU9abWUxcWFhZnZTeUg2NWRzRnNkTHpuMzhaMGx3SDFw?=
 =?utf-8?B?TlRxbzViQnBnV3FFZXN6SmF3MEFGQktwREFmS25mQWFSRVNXSUFkWXRLT0V5?=
 =?utf-8?Q?FGvWEZldecudw1D8FsSeC9LL8mowXe+xWys/3jX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkxNQk5TbFdPUzlKR3lRbENUQ05USW53bDEwenZWZklRNVlHVzVpRnpDeEZv?=
 =?utf-8?B?V0kvTjJ3dGNESFVCQkZQOWoxZmRpWkxJY1FFUW1weHpaQ1kyM09UQjc4UGFZ?=
 =?utf-8?B?TzNDL25ha3ZUckhKbXNpSE83dVYrRmtoL09MdHlCM3pFY0dqNFFCNTdYMlc1?=
 =?utf-8?B?ZVVPRWtZaCtvSnBZY1grTWR0aTBnT3FteFJtQTlGT0lmdEJzTXNVclhXS3RT?=
 =?utf-8?B?VVcxcGtnV0F0cE4zQ3dMN1ZWTVFXRUZGeVJyMnAwRGsydVdkaWpkQjMwQzhP?=
 =?utf-8?B?V1dad3RVeUpjbGFGVlp1Z2NvdUg1blZEN21hcHFKZlVrbVY1eUwzSysvTmk2?=
 =?utf-8?B?TC8xZWFFWjMrLzB3T0JBdnl6b1ZveVo1Mm1pQ3Y5ZFpKYUR1b1Z5Y2lTdnBK?=
 =?utf-8?B?OS9VTDdCeVQ1c3lxMjhmb0ZaaUNBSG5obUdsUTB5YkFxMHNReWdGMzdWaHdG?=
 =?utf-8?B?c0N1Y1JMRzJmT3p1emljNy9xLzRmK0YySEp0UzdhbGlsUWNKNjJ4NUExMkJS?=
 =?utf-8?B?aGYzckx4RlEzMkRtb1Z3aGMvWmtteGR5bTJwb0VyelZxOTNLNHlQYTdWZ1Rk?=
 =?utf-8?B?ak5YTy9sR2RPcTdRbXNxU29wRG9MaE93SEJJZDVHemNmTVpxZG9GWTI5ckVJ?=
 =?utf-8?B?TWlFQk95QmhwVHFtS3dpY2g4ZUtJRXdEalc3MU5kS29kdlFNcWx4QUx3dXBB?=
 =?utf-8?B?SkZHclZGNjNNcXErbUNnWDdkWmJOZkc2ampCQ0VmMVdGUnQ4cC9mZEpPVzNX?=
 =?utf-8?B?cHFqZDlFdkN6ZXBzbHpEUTMxMFpRVUNpZzhDcDdLN1c0Q3FZVUhtTmlBYjR3?=
 =?utf-8?B?Y0hndGtGSUVDN0IxcEZ3MWZZMWRGRmVrRWFtWVludGdBcFQrdy92cExsbE5Y?=
 =?utf-8?B?QTdKSHI4QkI5amJVZERkNkErNno2cHZscFJ3UEYwVG8vTExTcmtCL2cvMSt2?=
 =?utf-8?B?aVdFQmJLN0FvTjRVVUQ4R01makJSeUtKZWMxdVNqSUZQdHlreUo1cUMyTHJH?=
 =?utf-8?B?L3Q2SEovM1VubkM1YktuMGlhVzc4cm1WMWNpbm5ZZEI0cXh6U2dCMFFVby9h?=
 =?utf-8?B?a1ozUThmTXg2ZmVNQ3VxK2MyTWdBUU1RUHc3WEsyNkZjYytRRzNhbUc3VWdt?=
 =?utf-8?B?U2xMZDR2U1pNcDVWckNCT0Y2SVhCMVczSCtEdVlSR0lOczhBcVpaeWlDWkhW?=
 =?utf-8?B?Skd6VXZrKy9FdlBPSjZuQ2IzQnVCMG9UMEhWQit2eTNDa21yZEt2NWMvc1VU?=
 =?utf-8?B?Skw3UVBubitIOXJtdFlDTHhnejZIOFNVbGVTQ3drdXg1cisxSE83NGtxQmw3?=
 =?utf-8?B?S0lGWW91c1hjUGFoZ3hNL3FIcTQ2YzhrdUpJNW5sMklSTzUvSzdyQkR1Q2wr?=
 =?utf-8?B?VDRuSUdzajZhQXNYWm5jdmM5QjlOd0lFRkdxeC9IMFYva29EMWlkYWNtRmJy?=
 =?utf-8?B?TDF0dDlWZTJqV1AzZ1M2UTZHN1FYcmlvOGY2anB4SlVhcFNYeCtYTTgyZ2xt?=
 =?utf-8?B?THN4VDQ4Y29NQ2ZsRmxpeWxpemNDZjl3VWEvR0lSQ1hUcVVQT2U5ZFhOSVRL?=
 =?utf-8?B?alpOdWU5aG9tbjlVVHEyRTIyZzJpY0V1Wjg1OHJyQWpaVnJQVlpxaEJMalBo?=
 =?utf-8?B?cVJ3NjNVUElJTTRDSUVHZUY2OGJoUXlpQXZ3dU9YYjQvd05tL0FsU3hvK2VP?=
 =?utf-8?B?SEhSVXkrbWh2aUEwa1dHVnNjSW1hSmVzRXNCYklRNzQ2WmZlbzdOVS9zcFF6?=
 =?utf-8?B?Q2NNTDJzVGJDcmtFVERKSjBMMExXSEU3SDhobXVUU3ZmWkt3U3NtTllCTWtv?=
 =?utf-8?B?Tk1NNFhrdit5ZW1QQlk2SS9ZcSs0U1B0aDB2T0wxWEM3SmhuZ1RTOE1MdDIw?=
 =?utf-8?B?RjF2am5xQlh0eFhRcklmQjFWVE1ZMHNPRTNSTDhwQ0QraURwazJxcDdleTNk?=
 =?utf-8?B?b0hVQ3I0Sm5jS2kxZ2xKbG1Sc2FFUG11U2ZUY3BIWmd4ZDQyMXprWDVONzl1?=
 =?utf-8?B?ZjYzS2VtWDcvVG5TeWJyOUpJVTFJVVUvYXBCUXV5REo3cnhzeXJhM0phNVdr?=
 =?utf-8?B?VkdxYnBmNHlxWldTQzBkTUtQVnVtQUhuc3ZHNllvZFF5a0g2dzUvRFZkWi9x?=
 =?utf-8?B?YUFxbVVaWDFiRnNicFlNS0dIZWZRWHRRekVVVzNzUFYwdHRpa2dsemxxZWU3?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62194f43-74ee-4df0-c4ee-08dc91750ccc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 22:05:09.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P95N9p9edp2iiGJe2ImP4h1SASw3OkRks02qxtzlnjotiRzdM9iuZZZw31f32ti9ZNpFb7Ozr4iBZk9QsYsCsi9KKBDF+jRqr3JPaYFxCtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com

Hi Babu,

On 6/19/24 9:25 AM, Moger, Babu wrote:
> On 6/13/24 20:40, Reinette Chatre wrote:
>> On 5/24/24 5:23 AM, Babu Moger wrote:

>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -261,6 +261,16 @@ with the following files:
>>>        Available when ABMC feature is supported. The number of ABMC counters
>>>        available for configuration.
>>>    +"mbm_assign":
>>
>> This name is not ideal but I am having trouble finding a better one ... I
>> have
>> seen you use "monitor mode" a couple of times (even in shortlog), so maybe
>> that
>> could be the start of a more generic name? "mbm_mode"?
> 
> mbm_mode sounds good. Like this.
> 
> $cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> [abmc]
> legacy
> 
> Keeping just "legacy" vs mbm_legacy.
> 

Looks good to me. This sounds generic enough to build on.

Reinette

