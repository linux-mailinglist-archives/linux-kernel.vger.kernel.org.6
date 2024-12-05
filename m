Return-Path: <linux-kernel+bounces-432767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22A9E500A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED45161B76
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819461D461B;
	Thu,  5 Dec 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZC8eITN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F6189B94
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388225; cv=fail; b=Iqs66A/kpDRKQ9bAT2nzLF3EQPT8UCiGpEm94+iPqPwckxZPmtNUd3TsHJaAnATk6VszxuRv0YjQ8qHuBU9epDbDb7cN782jko1rgoVHJskBPbPT6KAO+2JrIsbDIGoebci8V2uLLLpNTNe73t6MsUqz6B9SsYjmfhwqlHkUx2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388225; c=relaxed/simple;
	bh=sjIfoEX1GA1sKogpYgwcHxB5Bzg4Wph0klxdCUOrdlE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=D3o5uGfzMM3a0ofMYNR9wWDFIUwiscG/68HNSGNIY09tmxxtwrpqYPz61WnUPyndmttUZFqUc9oJJg57E4kLwHh4WjYSbm2YmgRCquS87hmfA98K4CVO5czZXpUIZ1MnldaZAKHkOIMQzGpcMjpvsDLHyubUEoGbobfJ2Y20HOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZC8eITN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733388223; x=1764924223;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sjIfoEX1GA1sKogpYgwcHxB5Bzg4Wph0klxdCUOrdlE=;
  b=EZC8eITNmnvfIFVPxFwgROLwPdbBlf4A8LBXMBkqZeDFnuLEX+ct4A60
   sGF2kCdQYNSLWMp7F+3jwq3kWfLBgb+QK20ly/dlacuQusss/9cpiODxY
   MfWpdIT/y3zXFYUdYJ7saO45RIaK2w3MtnfLzYo5p0LUdx3+fNJfTqrtm
   mYo5/Je0Jl5+v7amDZaPG6bkFjpjKwuT1Os/p7VIByix64PNh3D5sbjyN
   pt9JMcJiwJWtqTBmEx2dRxZdwDSNqPw4xYdMJ5SP/IY6i5I5HbG4kJG3m
   Cgf2OYzzfHdkiy29YAYbq0YypJAa1de24b4L+bWVBM1QOZCCXmmAkrF/S
   g==;
X-CSE-ConnectionGUID: 1QqnXZ61Q46EuvIM0t4ZKw==
X-CSE-MsgGUID: 51tNPB4ESTqUthPU5OqT+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56164938"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="56164938"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:43:41 -0800
X-CSE-ConnectionGUID: MH2JXIFyRYOYZInOqY5D/A==
X-CSE-MsgGUID: xwbn9RNWSZeZ41SNGAiUxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="117276310"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 00:43:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 00:43:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 00:43:39 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 00:43:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2zCWeIG8Cd/7kpZ/J359D9CfIBJwBz3s4dcuX3mWZBmqM2YJEQuVlA+V/Cd94Hcmesz7P+4nsWsDOfhXH/CuMIuE0/3VmpMGjLs9XZ/ibKY25BNL46LUVJc+j7hoWg18DbkrK1p0bc6n7aDfyUfLuWPXwCHH1nOhU0c9VjiDfmauAfCtMmBLn82g90dBt0euZLKCT6dBdt9YCcJmWXtoYUZLTM818wzFUDkDtAAFDb9JsRd1ABaJaNOl5UfI4MwN/5//gNu69poJUiWecsn4Jv62k6tJH+TYvbsV/z03+wkSD8MnT/wDapK71RbjljpcmiHcAlWp4/gWIeQcN1n2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAEBLHA5uq0wJWwT8Q4LuORGulBHN1Gh2ZEoOdteBSw=;
 b=V1gysxwohynRJlg/8WlNDADyl2iCPqp5Qe1Ot1HtCxQRka1l2johPH5VtWGsFaN35bA8sRGQBY66Pb/MMX52KLLDxN1ttjbOE+3WgT3NPYdxwRGQgM+1/9knMpRllVWB1ae8xID4PjzO4PzFgDBquI00LqR2TvXrfndg7ulSdtgyR1FpWX1Q3WoIZCAU00ND2/tYVq5OJQtw1tnPACy3Kb1Y+XDPD/dVzxaSFsf+IDh00jl+4y/JJH1msdHR85ZLKFhk4/0GqekErY2VU25rlSk0h1z+CXmVsSS9Ke4EA/EWBdRlLqgWNHjqKSG4+UOUigEx5z153bLpTcuc9z6UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 08:43:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 08:43:35 +0000
Date: Thu, 5 Dec 2024 16:43:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rik van Riel <riel@surriel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
	<dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
	<oliver.sang@intel.com>
Subject: [tip:x86/mm] [x86/mm/tlb]  209954cbc7:
 WARNING:at_arch/x86/mm/tlb.c:#flush_tlb_func
Message-ID: <202412051551.690e9656-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: bf28b153-333b-4c94-fb38-08dd1508e823
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sKxqeyZFjQlnXwnM4fRPKLW0f6tGRHvUw1LV/amC/fArWrxCEaFZwEtNg9yj?=
 =?us-ascii?Q?5mjppWoDZCrE/8Hpyhorh82tnXoZV5s9THNfanoNv6Uoos2TjHEmbdc/BtAi?=
 =?us-ascii?Q?CX4KG//+BW6Jbxm1lP8AY8MvSqrLMz6mexbZTJsVMYvbVHIWsh9e2kPDQyPM?=
 =?us-ascii?Q?GltLPmuqqEBrgWDcO7eNcZ0kH0DZMOhh3ASqYXhADpXOAzgagx+IkCUmMw0K?=
 =?us-ascii?Q?HfQRpAr/uyEK5zfrHq7If4RITRtlr2akKxqDunsN7OryYwLsFxWO7ji2Boyw?=
 =?us-ascii?Q?WLDlREs5oV2sKxg+WNsV3qLbrFuvNLn/wSkUCoQ4CeRjyfetDhUWNzKkYkrH?=
 =?us-ascii?Q?I4Ked/0c7TyBBde0ARm/xeFf3aBj0BJg5AEp1jh/lmLD0oCbj0meVbNAkDNN?=
 =?us-ascii?Q?mo3ewqsoiAW8gACj47Qmkfsqwdqj5E7QzdxOmnx3GaQJJh1XGhOcOaXSkfz4?=
 =?us-ascii?Q?V1e4XjWB/wW3P51PZDiDc2j8gvABpduqDoo5oIBIdH1CKNahttXz4HfmvOwS?=
 =?us-ascii?Q?NbyI7CurClRiYcpTxZZmuM41245r7eZpnEFGT/zcflzvq3mPO9p1ciYwzWg3?=
 =?us-ascii?Q?2auPNV1I8bw9UZQtR/uqNFxBWZrek5WRLSAqzXO6sKD3RClVfrzWXAh4Yxdq?=
 =?us-ascii?Q?JnO7cEGScFP8x4DDJdWZf8giNbV7n2jYYPrbhG7PnKkpnJqjeiLXvZ4IvPFz?=
 =?us-ascii?Q?tOJQzZLJb4SPwGrwQaJGh30Qt5FNC/GH21829tvkHRAg25LGWbeDknETUHBN?=
 =?us-ascii?Q?4JZ8XrtYRiyzNrIg+ABpPy7/+e5QARzVEDRfD1E8Z84l84ZIoIpmZE69nn6f?=
 =?us-ascii?Q?64Sk6XIsRMfWSWbwsHRM6Mf3N+zy3hI6wurrz0YgxwvXGOBMtXmlrz4O44X1?=
 =?us-ascii?Q?wgXzmbTuxc1CBAqX/N74l7VMoVSnxMaVnhNSU+lFcz175Cwlkkan2DnojvBk?=
 =?us-ascii?Q?wCe5xyiD/RuDeO5sJqD2v0LaNJGtnhT9PnMPmHKSK6cVsypXlqZ/L+HZlJ7v?=
 =?us-ascii?Q?ZxZfeIy5dy/yYOAqBoZYzarWmLBvxnULy2WLHtrJFCIb5qZ37olh/VAbxT9E?=
 =?us-ascii?Q?dIaoN5GUKcdID55BNnge3huk0s/EegseeE1vPc14vpuxri6Wuy8waPU0td5u?=
 =?us-ascii?Q?TxKhDUWLA4d0rzW9upEZDItZIUZvQBAAbYVT57d8stgGuEnOWKg9WLJIiEoq?=
 =?us-ascii?Q?k9LV6a5hib8HgVytP1F4VgkFvPY4zbcGybIzObEDVjEC/dBMGnrKhP5b8wrB?=
 =?us-ascii?Q?K94occbmUfxVIzr0EUPgly/cXOkbA50cwuuPfki5TFQ8zlQ/tPdpJLkgWmvB?=
 =?us-ascii?Q?5Pa1FCrHXe3m9cwHRUL23LPK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLLAj1V/ZSwUWvTF/SNxhGPdPCiki/f2iNb9zHtpMaimwErOIzv1iwonS8tT?=
 =?us-ascii?Q?ecftkmBhopWq6t9sT/Rly92cwuo3bUDdJ8Pt9VstadOLiSfL1it0Jfd7EKgf?=
 =?us-ascii?Q?Sv4zs515QwbtCLWSo7epSlDIb6MTB661wJvIhLk6o2q5t1y4XgPc2VfB9tfJ?=
 =?us-ascii?Q?0GM2voVFMmwNrGkloRuYrjROgygd4eDOrEvNWjW2ln8H2VR3MSf2FBoMzrkw?=
 =?us-ascii?Q?PRFBKvYSbnG8cC8sSAyhmnuD8t1RVt0IDxgQV5SrQ+VZGoGsVjuTMTsD7q2Y?=
 =?us-ascii?Q?KQPDSH3wFZbwMAfPnjii7sPZhnjN3jzPoF+5K7AGniMusJq0oYufq+cgiZmQ?=
 =?us-ascii?Q?Fgc7gotEzwDaKXG9WcZ3i1kKXuH5p6rFTHSGXBkGXkBGkGcmJlheRHAXNont?=
 =?us-ascii?Q?NJFQ7s4zBbIUWd+vX5aK6bC9vIYHVHV49lK5OB2DURlks4IRM4JyLAaaqX1J?=
 =?us-ascii?Q?rlsjV6hrdZpYkmaABaGvqBJ+ly0ih+GbFacckXPIjRGjPJFIZmOlWdtKg/jw?=
 =?us-ascii?Q?9mn0oRRPZ2Q/UDGKnvbbQYlnGHg0eBQmzlyWJe0k6D5rSmwqjNFO7A148ikE?=
 =?us-ascii?Q?W6ZIg6xjbo9Zr+2YAH0RKrrrDesel3CEfINF71r/gm+m15z3yC3UEfjx6hh+?=
 =?us-ascii?Q?sKTdwgxPrDBOm4AWUeXoVCl4yNaXoiIVETgTVGdDRrV2Ucx3zSGJuBhD6aFA?=
 =?us-ascii?Q?vltt1ByMaMlAKTN4pXelvmJPOjkj1X8NzGqksO+m2RC75NHWNGWvwGyyEFZd?=
 =?us-ascii?Q?tQmlovC3vC7MTebxg++qU9Ag0Nnrw1Al2neRAoUAtmTXG7o/ccF33k+Z98DF?=
 =?us-ascii?Q?QXRz7tqE4qbLyBCanV1i/ymmlU2Bb19yqhoSKOW/0AkUN58eOumuY8jisV9K?=
 =?us-ascii?Q?jexgVuz0eTlLsP5sEiHzJftiDBkLSgPcdCvnaQTmk7Nxff9Yj4NGmQWHIK+f?=
 =?us-ascii?Q?kEefdnTnNu5ZzQtwF64p/DBAn1+6bTeidru6+novOOCNoxla6aKhuZXJitz8?=
 =?us-ascii?Q?EI7QdcThhwviPNLI+skMBTDKNkbdVdNDIggAFG/yrfyjX4+2/cUYsXUQT+0T?=
 =?us-ascii?Q?Ct9fmvlGcq/HPOBKyhuwZ4nlywRGi+8rHnwl72XVIy4599aqtBzDBRqpfimp?=
 =?us-ascii?Q?gUKdS6v5czFB0ST6mLin5CPuLfVohdoSrUzLDaSTBJ5h0V24QgGSQOCfis8/?=
 =?us-ascii?Q?kuBMTXNiPPXTdRVr6ZC4XO7r3EGt2ecfwF2f3byEsVl5ugMxK7Z8omOpTUA2?=
 =?us-ascii?Q?y4tO9GFT0iRw4C16GQViCXNj7QRWJqDVZoofIaeNvGVEaoCROKr8U9sVQCwM?=
 =?us-ascii?Q?Di83eEz9XaKW9oS/a++T87fQDRsR/YNedj8HA1X2p8tVEtiSTEln4Q/XNUlO?=
 =?us-ascii?Q?TZ7Hh1KvArjePopsW5cZeuVsdKEVMeZHtP303NXw1C9onlhYkJy9rY69MWj8?=
 =?us-ascii?Q?6bJDEDcSm30Af7fiCEBQlCR06826/WRwdSjMmaheKcCT2WfLR/ABMdyCjlDA?=
 =?us-ascii?Q?vX321kVIOm4Em+n4HCkBa4UCXfv6JorXqsxCHvYRvgmd0sQg3B/1f7EiEeTb?=
 =?us-ascii?Q?U4FaVlHCrGkf6miLl91nl1ihmVBHVCF2qzunGAachTyE+scOp/agRK136Kx0?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf28b153-333b-4c94-fb38-08dd1508e823
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 08:43:35.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8Z0m3CK5gIsRDiZ0hNRLSCdF9ByJ1/yep/+iojL00X4Tl46ALFzvR8s/JXg3kE19TUbbjBml288UoY+aGeKfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7752
X-OriginatorOrg: intel.com



Hello,

besides the performance report
"[tip:x86/mm] [x86/mm/tlb]  209954cbc7:  will-it-scale.per_thread_ops 13.2% regression"
in
https://lore.kernel.org/all/202411282207.6bd28eae-lkp@intel.com/

we now also observed a WARNING from another test. the issue doesn't always
happen, so we run it more to make sure the parent keep clean.

we also tested the patch in
https://lore.kernel.org/all/20241202202213.26a79ed6@fangorn/
as below [1], the issue is not fixed by this patch, still happen with similar
rate.

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_ssd/nr_task/priority/rootfs/runtime/tbox_group/test/testcase/thp_defrag/thp_enabled:
  gcc-12/performance/x86_64-rhel-9.4/1/32/1/debian-12-x86_64-20240206.cgz/300/lkp-icl-2sp4/swap-w-seq/vm-scalability/always/always

commit: 
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
  209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")
  40036730a9 ("x86,mm: only trim the mm_cpumask once a second")    [1]


7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 40036730a9566a8abe36ffe2bf4
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :50          58%          29:50          56%          28:50    dmesg.RIP:flush_tlb_func
           :50          58%          29:50          56%          28:50    dmesg.WARNING:at_arch/x86/mm/tlb.c:#flush_tlb_func


below full report FYI.

kernel test robot noticed "WARNING:at_arch/x86/mm/tlb.c:#flush_tlb_func" on:

commit: 209954cbc7d0ce1a190fc725d20ce303d74d2680 ("x86/mm/tlb: Update mm_cpumask lazily")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm

[test failed on linux-next/master f486c8aa16b8172f63bddc70116a0c897a7f3f02]

in testcase: vm-scalability
version: vm-scalability-x86_64-6f4ef16-0_20241103
with following parameters:

	runtime: 300
	thp_enabled: always
	thp_defrag: always
	nr_task: 32
	nr_ssd: 1
	priority: 1
	test: swap-w-seq
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412051551.690e9656-lkp@intel.com


[  210.338271][ T4668] ------------[ cut here ]------------
[ 210.343902][ T4668] WARNING: CPU: 38 PID: 4668 at arch/x86/mm/tlb.c:815 flush_tlb_func (arch/x86/mm/tlb.c:815)
[  210.353137][ T4668] Modules linked in: xfs intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac skx_edac_common nfit libnvdimm btrfs x86_pkg_temp_thermal intel_powerclamp blake2b_generic xor coretemp raid6_pq libcrc32c sd_mod kvm_intel sg kvm crct10dif_pclmul crc32_pclmul crc32c_intel snd_pcm binfmt_misc ipmi_ssif ghash_clmulni_intel snd_timer dax_hmem ahci cxl_acpi rapl snd ast libahci cxl_port intel_th_gth intel_cstate mei_me drm_shmem_helper cxl_core acpi_power_meter ioatdma isst_if_mbox_pci i2c_i801 isst_if_mmio soundcore intel_th_pci intel_uncore einj libata drm_kms_helper mei pcspkr isst_if_common intel_th intel_pch_thermal i2c_smbus intel_vsec dca wmi ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler acpi_pad joydev drm fuse dm_mod loop ip_tables
[  210.425152][ T4668] CPU: 38 UID: 0 PID: 4668 Comm: usemem Not tainted 6.12.0-rc7-00004-g209954cbc7d0 #1
[ 210.434817][ T4668] RIP: 0010:flush_tlb_func (arch/x86/mm/tlb.c:815)
[ 210.440408][ T4668] Code: 4b 24 b8 01 00 00 00 48 d3 e0 49 01 c7 4c 3b 7b 10 72 e2 4c 89 e2 45 89 ec 44 8b 6c 24 04 e9 1b ff ff ff 0f 0b e9 e2 fe ff ff <0f> 0b e9 00 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
All code
========
   0:	4b 24 b8             	rex.WXB and $0xb8,%al
   3:	01 00                	add    %eax,(%rax)
   5:	00 00                	add    %al,(%rax)
   7:	48 d3 e0             	shl    %cl,%rax
   a:	49 01 c7             	add    %rax,%r15
   d:	4c 3b 7b 10          	cmp    0x10(%rbx),%r15
  11:	72 e2                	jb     0xfffffffffffffff5
  13:	4c 89 e2             	mov    %r12,%rdx
  16:	45 89 ec             	mov    %r13d,%r12d
  19:	44 8b 6c 24 04       	mov    0x4(%rsp),%r13d
  1e:	e9 1b ff ff ff       	jmp    0xffffffffffffff3e
  23:	0f 0b                	ud2
  25:	e9 e2 fe ff ff       	jmp    0xffffffffffffff0c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 00 ff ff ff       	jmp    0xffffffffffffff31
  31:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  38:	00 00 00 
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 00 ff ff ff       	jmp    0xffffffffffffff07
   7:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   e:	00 00 00 
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[  210.460431][ T4668] RSP: 0000:ffa000000b2a33c8 EFLAGS: 00010087
[  210.466646][ T4668] RAX: 0000000000098246 RBX: ff11001ffb534e40 RCX: 000000000009e7c5
[  210.474768][ T4668] RDX: ff110001ea4acd00 RSI: 000000000009e7c4 RDI: ff11001ffb534e40
[  210.482888][ T4668] RBP: 0000000000098446 R08: 0000000000000002 R09: 0000000000000000
[  210.491007][ T4668] R10: ff1100108017daf0 R11: 0000000000000002 R12: 0000000000000026
[  210.499123][ T4668] R13: 0000000000000026 R14: 0000000000000068 R15: 0000000000000001
[  210.507231][ T4668] FS:  00007f4d1dbe1740(0000) GS:ff11001ffb500000(0000) knlGS:0000000000000000
[  210.516296][ T4668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  210.523016][ T4668] CR2: 00007f4ccba00000 CR3: 0000000122dd4005 CR4: 0000000000773ef0
[  210.531122][ T4668] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  210.539219][ T4668] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  210.547317][ T4668] PKRU: 55555554
[  210.550982][ T4668] Call Trace:
[  210.554389][ T4668]  <TASK>
[ 210.557446][ T4668] ? __warn (kernel/panic.c:748)
[ 210.561631][ T4668] ? flush_tlb_func (arch/x86/mm/tlb.c:815)
[ 210.566597][ T4668] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[ 210.571215][ T4668] ? handle_bug (arch/x86/kernel/traps.c:285)
[ 210.575658][ T4668] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1))
[ 210.580439][ T4668] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621)
[ 210.585573][ T4668] ? flush_tlb_func (arch/x86/mm/tlb.c:815)
[ 210.590529][ T4668] ? setup_object (mm/slub.c:2395)
[ 210.595137][ T4668] smp_call_function_many_cond (kernel/smp.c:134 kernel/smp.c:875)
[ 210.600963][ T4668] ? __pfx_flush_tlb_func (arch/x86/mm/tlb.c:735)
[ 210.606263][ T4668] on_each_cpu_cond_mask (kernel/smp.c:1053)
[ 210.611474][ T4668] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:91 arch/x86/mm/tlb.c:937 arch/x86/mm/tlb.c:1023)
[ 210.616593][ T4668] pmdp_invalidate (mm/pgtable-generic.c:205 (discriminator 4))
[ 210.621280][ T4668] __split_huge_pmd_locked (arch/x86/include/asm/pgtable-invert.h:18 arch/x86/include/asm/pgtable-invert.h:24 arch/x86/include/asm/pgtable.h:273 mm/huge_memory.c:2750)
[ 210.626839][ T4668] ? page_vma_mapped_walk (mm/page_vma_mapped.c:241)
[ 210.632309][ T4668] try_to_unmap_one (mm/rmap.c:1705 (discriminator 1))
[ 210.637250][ T4668] rmap_walk_anon (mm/rmap.c:2635)
[ 210.641932][ T4668] try_to_unmap (mm/rmap.c:1992)
[ 210.646351][ T4668] ? __pfx_try_to_unmap_one (mm/rmap.c:1637)
[ 210.651812][ T4668] ? __pfx_folio_not_mapped (mm/rmap.c:1964)
[ 210.657273][ T4668] ? __pfx_folio_lock_anon_vma_read (mm/rmap.c:546)
[ 210.663421][ T4668] shrink_folio_list (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:822 include/linux/page-flags.h:843 include/linux/mm.h:1243 include/linux/mm.h:1260 mm/vmscan.c:1305)
[ 210.668443][ T4668] ? __count_memcg_events (mm/memcontrol.c:569 mm/memcontrol.c:832)
[ 210.673716][ T4668] ? scan_folios (include/linux/vmstat.h:80 mm/vmscan.c:4452)
[ 210.678379][ T4668] ? isolate_folios (mm/vmscan.c:4547)
[ 210.683210][ T4668] evict_folios (mm/vmscan.c:4592)
[ 210.687771][ T4668] try_to_shrink_lruvec (mm/vmscan.c:4785)
[ 210.693024][ T4668] shrink_one (mm/vmscan.c:4824)
[ 210.697315][ T4668] shrink_many (mm/vmscan.c:4885)
[ 210.701770][ T4668] shrink_node (mm/vmscan.c:4965 mm/vmscan.c:5943)
[ 210.706219][ T4668] do_try_to_free_pages (mm/vmscan.c:6143 mm/vmscan.c:6263)
[ 210.711356][ T4668] try_to_free_pages (mm/vmscan.c:6513)
[ 210.716227][ T4668] __alloc_pages_slowpath+0x303/0xb70
[ 210.722654][ T4668] ? get_page_from_freelist (mm/page_alloc.c:3417)
[ 210.728214][ T4668] __alloc_pages_noprof (mm/page_alloc.c:4748)
[ 210.733419][ T4668] alloc_pages_mpol_noprof (mm/mempolicy.c:2267)
[ 210.738802][ T4668] pte_alloc_one (include/linux/mm.h:2886 include/asm-generic/pgalloc.h:70 arch/x86/mm/pgtable.c:33)
[ 210.743228][ T4668] __pte_alloc (mm/memory.c:448)
[ 210.747484][ T4668] do_anonymous_page (mm/memory.c:4752 (discriminator 1))
[ 210.752432][ T4668] ? update_load_avg (kernel/sched/fair.c:4500 kernel/sched/fair.c:4837)
[ 210.757290][ T4668] __handle_mm_fault (mm/memory.c:5909)
[ 210.762227][ T4668] handle_mm_fault (mm/memory.c:6077)
[ 210.766990][ T4668] do_user_addr_fault (arch/x86/mm/fault.c:1339)
[ 210.772008][ T4668] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 210.776595][ T4668] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
[  210.781445][ T4668] RIP: 0033:0x5612c90f0ad4
[ 210.785855][ T4668] Code: 01 00 00 00 e8 0d f9 ff ff 89 c7 e8 6c ff ff ff bf 00 00 00 00 e8 fc f8 ff ff 85 d2 74 08 48 8d 04 f7 48 8b 00 c3 48 8d 04 f7 <48> 89 30 b8 00 00 00 00 c3 41 54 55 53 48 85 ff 0f 84 23 01 00 00
All code
========
   0:	01 00                	add    %eax,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	e8 0d f9 ff ff       	call   0xfffffffffffff916
   9:	89 c7                	mov    %eax,%edi
   b:	e8 6c ff ff ff       	call   0xffffffffffffff7c
  10:	bf 00 00 00 00       	mov    $0x0,%edi
  15:	e8 fc f8 ff ff       	call   0xfffffffffffff916
  1a:	85 d2                	test   %edx,%edx
  1c:	74 08                	je     0x26
  1e:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  22:	48 8b 00             	mov    (%rax),%rax
  25:	c3                   	ret
  26:	48 8d 04 f7          	lea    (%rdi,%rsi,8),%rax
  2a:*	48 89 30             	mov    %rsi,(%rax)		<-- trapping instruction
  2d:	b8 00 00 00 00       	mov    $0x0,%eax
  32:	c3                   	ret
  33:	41 54                	push   %r12
  35:	55                   	push   %rbp
  36:	53                   	push   %rbx
  37:	48 85 ff             	test   %rdi,%rdi
  3a:	0f 84 23 01 00 00    	je     0x163

Code starting with the faulting instruction
===========================================
   0:	48 89 30             	mov    %rsi,(%rax)
   3:	b8 00 00 00 00       	mov    $0x0,%eax
   8:	c3                   	ret
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	53                   	push   %rbx
   d:	48 85 ff             	test   %rdi,%rdi
  10:	0f 84 23 01 00 00    	je     0x139


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241205/202412051551.690e9656-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


