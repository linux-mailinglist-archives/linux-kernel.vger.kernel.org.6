Return-Path: <linux-kernel+bounces-564899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A621A65C79
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B65884A42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF91C84A2;
	Mon, 17 Mar 2025 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZljGRpr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719819048F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235823; cv=fail; b=hXr67+hygltiXQs91FYpowICbR8h6wttjf3aiY7MMG/NjFAnkv2O4MoOCxL/vK4f0Skwr6OlJ6BhTAnR61LSFJoEbZXuTOJTC/tDOxHo5SzeBxaRkrpN2QCLmZftLpUKWUkijnqugumfKxMUOyB63xCPUTBLqFxfPj7RObmEtgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235823; c=relaxed/simple;
	bh=yfX9XBhMT+eJSzSUpgAPW3MW4ZoBwZTh+Vxf3Z4y9cY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LY6D/2hQgYYdRoVir+F0lLsYifWkaB8obCDASu743NqDJbS3jRceNsWT7eJAliAzyi42rB7hE71le/iE5qEa9wcKRuMXSYJ4JEFfGvTQU5B3GdFHB4llDtmOF1lpQ42uBVI3IKYJ/YaWfIy5TQ7+PofeuMtz4OhmVmRsUM824C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZljGRpr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235822; x=1773771822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yfX9XBhMT+eJSzSUpgAPW3MW4ZoBwZTh+Vxf3Z4y9cY=;
  b=jZljGRpryiosWjRUehWtp87hZTttXfRiXDrBC+5qV4PjyLa81+LviqXG
   IdVc907M1YD8Pgcz5dYtcEPTti/8MmpbTGfhhMtD+Q/8X2z9VgZNAmwtd
   qBb3t+8RP+gM8H9ASGGxnDyN1UYo6wM+AzkL0q3Wl0NbKCvbCWlKGtxAL
   sbCoBCtyopttwC7djK6xPviT0KLombWhWDropB9tK1EyH+H+Wgvh+H7nS
   S8TWzrB8OczmF+zgbCMR/prOfPHI9dqoAGKPwOp0jSZ6BoIkcsotH13JF
   /KHu7Au224aPMVlvPTkWct7/RjrpqLCdUl0aSIgzTUgz1UJOFtMXdkjyf
   A==;
X-CSE-ConnectionGUID: cBHkN5ZZTuuqSfA2bO31rg==
X-CSE-MsgGUID: N2n3NHubSxWE88V2S6eCiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43083032"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43083032"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:23:41 -0700
X-CSE-ConnectionGUID: 17ygfVHcT0KLkA3sf+BISQ==
X-CSE-MsgGUID: cIamau+DQEW9ZU0c8H+b7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="145195263"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 11:23:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 11:23:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 11:23:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 11:23:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxD7lae5tyddSWUEhs8kL/Tc00qrUw6gWN8KcY3WtMaOyIjjzNr7SpF6dOCWwRcYziZIzitIprP502lG+7RY3uXWRgVnEfRvxoYmnMWJCHe/YxjUpjh/aJTECHx67f/uWalkhLoSRZ0ocao3uuhGgqgdvVOelbjfCACg30aXUlozGXpval7SUBaCCQTxp+o68L2p0hQUfl3XeiVNlKZyaNzJImkUstzOD3OzDCjXqs8wtAh87Q5X2SNNJIriDnKbZik15s1mTM6IvbMuLfgw1sOt4Un0KeRa191MFNULRT6kKS4IHxhdjQPCNOFWFf/iN0RCT05mBpl0EDHLNyepdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSxyrJzAX38HSrIAhQ+l3mG2E4WFJEvLJDilwcqEWvM=;
 b=ErGb0kxjcoyr8BVU5WV4xeVN9v4DLZ5LvWYgIB5MHJQEO0J4a3SQmtL1TaQ2xbe74r49s2LRqfCmoWeAqVbUu9G0HHGvuFtQxh5ygGLCDKTERt55UWWkMWYf7/mk+V3tXEbHpkEL0FFwB1meOdj9RMtg8MLyZiWjRrDEBc1p7aicXOEcMeE8DdM9o4AmU4gIZ/vFgEyG5uEGlkfEfqcUPcyxx8XEm0u7Au5cgV2fEDZRzMx9naRN1JBeNEWgO4lEbcno0Zs0A0XwK/NAld2wBidf8RO07hsfzeAhywp+fbDuQXSh2+/nMRUwpN1fIK9WXhmbLI6rPqCBmNB3HXC+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6005.namprd11.prod.outlook.com (2603:10b6:510:1e0::19)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 18:23:22 +0000
Received: from PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a]) by PH7PR11MB6005.namprd11.prod.outlook.com
 ([fe80::39d2:ae29:6e3f:1b6a%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 18:23:22 +0000
Message-ID: <0d5200bb-5070-4225-8166-20b8b63af33d@intel.com>
Date: Tue, 18 Mar 2025 02:23:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] sched/fair: Propagate load balancing stats up the
 sched domain hierarchy
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, <yu.c.chen@intel.com>,
	<yu.chen.surf@foxmail.com>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
 <20250317172536.GF6888@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250317172536.GF6888@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6005:EE_|SA0PR11MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d95fda-04f6-498b-486f-08dd6580cc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmtweDlmVHZDZGFOdGUxcHZiVWlYeitJYTRvbWxvdGZDM0dsYkRBWEgxNXpx?=
 =?utf-8?B?ZlhNMGppUU5wbWJYNWxNeFFia3hsM25HVlJJR3lMZndDc255eFhMTk55R2tN?=
 =?utf-8?B?ZUVzMnJLeXFXRG96KzV3Z2RZRGUxWXpDdXV1NXhJRUYwY3lTUDFvM0JjUkxK?=
 =?utf-8?B?ZDIwUjM0ZTkvMG5PUWpZaHpNeGgvQnJnWFdkT1NNU3lEVmlodzBkZHNzbW00?=
 =?utf-8?B?QnVLTGhhQ3RQM3N5TmZ2Y1FqWURJdFFnZ1RmR25iN0l5SEp3TmdDWVM5enlM?=
 =?utf-8?B?eURxSnFKdHllOURlYVNBbm53WmVPbndicUZLczhGMHZldmx4YUdtUi9mRW1J?=
 =?utf-8?B?RXJDdW4yRzg4Y3MxUFlNcjRKWWVVZzlqMjh0K1JIRllUdlYrbE03VVZ6T3FF?=
 =?utf-8?B?cGdXMHFYYzdSR3c1b0dCQ2FZSVhYUzlGVVhDZFhsZGI1R251b3hsa0ZrUUEz?=
 =?utf-8?B?Snp2VXArWTM3RktnM0NqeG5XL1l4RytHa0NmRWtxYjQrRzRhaGNpcmpBTHhZ?=
 =?utf-8?B?TWlCTllSR3hDZGs1TUNVT0cxWWVhaE5kQWxyMExqOU51RVNlUWxNR3pORnlX?=
 =?utf-8?B?TE5NZ1Vhd0RxMXFsbkNBL25wMHArZTRtWDduVFVOL1FhdDNCVW1mTnQ0ZURF?=
 =?utf-8?B?eGIrY04xV0RoaHF3TkZjTmpZMDRIQURlaTh4dkNSYTYvSlpVQ1NCQVVjb0h3?=
 =?utf-8?B?SmNTblVEY0paaUdEdzNzdDQ3Mkxvb2NqSG1LKzlwVVoyanUxOUVsSk1qNWI4?=
 =?utf-8?B?czV4bDRnYzFkcDRtQ3YzeGxsRWc0MU12b2NVdlZwT3BBQTY2OVlVd05yKzFG?=
 =?utf-8?B?SmplUE5RQ204MEJYVXBJUklpRm1xeW0yZFEzOHI5MjZteXdhODFQM1pMOStn?=
 =?utf-8?B?TXVaVGVtQ1c0dkJuT2ZzWjNja2dlSUEvY1RiaGJiVVNXVVRBb0I5SWRMSDQr?=
 =?utf-8?B?RjQ2TDJLRC9Rcm9BemQybTZCdmNuTHB1S0lSZHpSbklURW1FdEZOSWUwTXlp?=
 =?utf-8?B?Mm5Za2NlckNFMkoyYXY5Mm9PbWhQV3cxWVZoQWgzWHlmbTdHMnVwSWpIaGRY?=
 =?utf-8?B?Y1lpSTFXQ0xrbTFRbVBiV2Y2QzRXQXJTalpCVG1ScWxhc1hBOTI3cTdla0ZO?=
 =?utf-8?B?eDZuYlhkZExMSTBNUE1hc1k5bE15aFhqd20wZWgwcGp5NEpCdWhLUVdVK0o0?=
 =?utf-8?B?VkpZNTNwT0p6MGtJU0tBd05TKzFzbG1UdFRQVGdNUFFxb0lmV2RGY0pzSVdU?=
 =?utf-8?B?K2xBKzVrSi95enBzbUk5bWlKdzJiblp5SnlmSmVyVDV1bGZoSWMrUHM5NkhR?=
 =?utf-8?B?UXBVbEMrWGRHMjJ5VHRESnFJTVRQcnFhRk1KVk9sbVgxRDA0ZFpEeWRMYi9v?=
 =?utf-8?B?cFRaVjY4NjhZa2R2aGhnTncvamM3R1ljSWZyVzRlLzBHWFBWQ2xBT3JVVmhL?=
 =?utf-8?B?ZEY4MEN0SmgyMkl1T3NoY0lYSUZMYStaWnQzaWhuc3JxUDBiWVJzd1BjczhZ?=
 =?utf-8?B?UUxNSTJuaUFHRk03Uit6NGNRMGtRWlArV2I0TTk5dFRPNDA4c1I3VWlKamxZ?=
 =?utf-8?B?UThFZkRaL0tZenBwdzZpNkU4WXI4VURLRDBRZUgxaEpMWk5pc3VnTThPNlll?=
 =?utf-8?B?NUZYaVdoSCttZnY5ZWxaa3hZMEtkOTdxM2pRYm5oTVpWV0lQLzhXSGxpSW0v?=
 =?utf-8?B?ekRpbmcrM21CanhiVFc0ZTlkL0ZUNTJHOUhPNzhuSWR2bG5wRW5Ya3h0R1M1?=
 =?utf-8?B?M2hWVXU1eVpHZHp2VHhacy9XWTh4Z1hJdytwNXJWWis3R2dSQ3EwQ2JaeWVQ?=
 =?utf-8?B?U29RaDlqLytVUGxVUHhjWWdseE9TUlJWQnI3disxZTlEM0VqZ1dqcW1naUdP?=
 =?utf-8?Q?beIY/pK82fW5U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BsUHhHSWgvdXNGMnV6V29YdnRmbmN1ejlGMWkvUW42V1VjdUtUN0FZVDlt?=
 =?utf-8?B?cHRaL3MrK1I5UkcxM0ZnbUFsWDZyQm1rdEMzRWNQMGVNUUw1WW52MTRXVTFI?=
 =?utf-8?B?RnUyU1dsaVI0TG1aQnFpNERoSi9ZdVZ0enVzdGIzYVpzT2E3MENXM3JteUR3?=
 =?utf-8?B?ZmE2c3VFczZRZXM4M3lqTHlLdy9lZzczbUV1aTdOS3Z2eXhBVUhQaDZyZk5h?=
 =?utf-8?B?c1JtVm5xOEJZd2lxQkUwcFg1elV3bUhNM0l4SVJKeGpVajVQWVNQTlVFbjZE?=
 =?utf-8?B?a3J2ellZREVDcm14cGFna2ErZW95MmUyOTRUdkxEY2VWWVVWZXEvd3FGWldz?=
 =?utf-8?B?QmUwN2FUcFMvVWJ2aTAyWmpscEhjZzBDL29yelB1THhxTFdEek9oZ1R2d3hH?=
 =?utf-8?B?OE1ZVkpCQnMyT3VENy9qdVRJNVB0QUZSVzBQSm5TS3RPckhxWDJFKzdzc2sz?=
 =?utf-8?B?d2pYRlJwSVhWM1prQXZySEx5VU1ka3dOQTZ5Myt1TmdvSWU4cEhBYXc5UFhV?=
 =?utf-8?B?dlVJU1FNVGFselFXYmVsSjZJejladmtvMzdSTk9GYWpvck5NWmgvYTRGc0hR?=
 =?utf-8?B?aFMzTnBDbXlGVEFCUDdDTDhUQlBNeXV5cFUzNHoyQ20xbmxZQ0x0VDhKMmYz?=
 =?utf-8?B?RDNXU0tPLy94N3lpSSsxU05PYXRTbG5XNGRsb0VrbkVOeUdIMmxtNnNBcmV0?=
 =?utf-8?B?Z09vOUtMdS9mMS9MZzNtNjI2VWJLKzUrNVVkQk9KQ251TStKeE5qUGV3YzBS?=
 =?utf-8?B?c2cwWlRnTHEreWk0d0dOcktjdW9yK0h0UXUxbG5sVXJ3bUs1ZW1BLzRIRlNF?=
 =?utf-8?B?Nmw2anRBdTRoQlhhbWtPcHBkcE1lWmV2cG1INW41V29VdlJjdU1tcWpnTTlL?=
 =?utf-8?B?dStPS01HTG9KS3IyY09DTGYxb0VpMjlLcmVsN2VMRGp6UXR4SC9RK0daUmZr?=
 =?utf-8?B?OTNEbWxkelNLSWRYZmlRVWN6VHVlN3JJV1dhME9iUXNPeis3UUV6cGFUcmMw?=
 =?utf-8?B?RzRJNG9LOTVvK2plbGViMVVoZUY3UU04R3M5Z1lJc3ZRay8raU9nejY3aUVG?=
 =?utf-8?B?NjNnWFRmMjRoQjVBNkM1NDN4UllOTk1EZ1BIYzlDMWhwM1I0dFAyRExDVUN5?=
 =?utf-8?B?dHN1MUxJYVA5MERiTkQzYzV0WmdUc3FjUWFzcGd4MWMvRVg3b0FuS0NrYnVJ?=
 =?utf-8?B?Y25tclNHOENWSVQ4UWd0V25qSGVhMml0RWVkMzY3cFlTSXpGMzdVUFE0MFNY?=
 =?utf-8?B?aGpzOWhYZDNicm9Wdm5YYkpGVW1POWx2OVhIVXdQK2RwRWxNSEZrMStQRUpS?=
 =?utf-8?B?VVdQYUhoZTJubzU3d2NzRkJCdHZPeE9mTlpoZnBXV3BPRE5LYm14NFc5eUU2?=
 =?utf-8?B?ck8zcFJPQjhoYjNNb3JQV1RCMTUvL3hzd0ZOcmMvSDcwaXkvaHJPMEhHSFA1?=
 =?utf-8?B?MzNWSnZ3cGt2dzNpUngrbVR4VHU2cGUxMjdON3NXVVZpZFlsT0h3Sm5rVjkz?=
 =?utf-8?B?NTFWM0ttZ3kvV2tLVUhYb1JaeUREQWZXVmowRmxudGl2VFNtVVRIRGgzK01Z?=
 =?utf-8?B?cldrQnNqcjRLRy9KMjJvMlJTbHR3NHplWnRGUjZpd3BqN2Nrc09SYXIxT3cr?=
 =?utf-8?B?L2RrL2lROUNxUEwzdndrQ2V5NzY2Tm5pVDNmbkVBOGtMVFJTR2hZRWxXYmFr?=
 =?utf-8?B?b0h3SzdpbmhMelcrTk1FckFORG5IOTdVRlUzaFo2K3doUnZmbThKZTRUamI5?=
 =?utf-8?B?dFlRM2UvemFwUW1PalRna011bU1hZEpod0I3NUUzeGQzUVljNHZWL0JOejkx?=
 =?utf-8?B?VU5yZkFZY1lIdXRESTU5MElRbHdpWnFCaytFODk4SldmZTQ2SVR2N3hmK1Zl?=
 =?utf-8?B?UG1xRk1YaElkN05VcENIdFAwUW5WY0VxeVlCYlJWcFE4N3BONE1RdXczREw5?=
 =?utf-8?B?WDBxNGNvczBNd1IvVVJSeHI2N0ozREcvYm55QXRjOWxjbjRiZWM2TUUvVUd5?=
 =?utf-8?B?aG1MQ0o4UzUwQ0VHWXdJT0ZUb2JtcURVQnJmSUFOcVRTV0JpbXd2S3lZdkRB?=
 =?utf-8?B?bGFoaVA5ckNYbFpvdWJRYm1wcFhxeHhHaVMxRCs3Q2JsOWVPLzdyVjZmQnVz?=
 =?utf-8?Q?LS6BWOxsCuAxTcQxMgtC86AYg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d95fda-04f6-498b-486f-08dd6580cc2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 18:23:22.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roxvVPaiyrqNwLPfVyYlE9aKEDV/vfh6K99+IkiWJMFuEXA7+wc2iiTHxy4oyy9MzvUefBKI/UER3RBJvSYNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com

On 3/18/2025 1:25 AM, Peter Zijlstra wrote:
> On Thu, Mar 13, 2025 at 09:37:38AM +0000, K Prateek Nayak wrote:
>> tl;dr
>>
>> This prototype is currently limited in the sense that it can only reuse
>> statistics for busy load balancing. Reusing stats for newidle load
>> balancing specifically ran into issues elaborated below.
> 
> Right, it makes sense for busy load balance, newidle I think:
> 
>> David had proposed SHARED_RUNQ [4] to improve on the shortcomings of
>> newidle balance for Meta's production workloads.
> 
> we need to look at this again. Something around the EEVDF merge made the
> thing unhappy -- if we figure out what and fix it, I think this makes

Could you give some links on what the issue is? The newly-idle balance 
fail to pull tasks after switching to EEVDF?(I don't
see the connection between EEVDF and newly-idle balance on top of
my head)

> more sense than trying to optimize the current scheme for newidle.
> 
> newidle really is about getting *any* work fast, which is a totally
> different game than the regular busy balancing.
> 

The newly idle iterates every CPU in the domain to find the busiest one, 
would the following work: find a relative busy CPU and stop the search, 
say, rq->nr_running >= 2 and also consider the candidate task's average 
duration.

thanks,
Chenyu

