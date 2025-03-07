Return-Path: <linux-kernel+bounces-550439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34DA55F96
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA301895658
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E86195962;
	Fri,  7 Mar 2025 04:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErnpsBUp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974E194A6C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322322; cv=fail; b=FEptrrYt/TwBwG+Ukhdbl/1nHyDguDjQDnpmKW+hw+6CDbOlo1qhStBZKx/NuJviDmg+o8n797jFwaJ80xGOvrV3Xg5AsU/4MoWvxLq8kcudCUkhE4vwsApPEsL+QdUHBV3PQ0jMzi+johkS3n53VAaHrWaGvpbowKJ+KannWEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322322; c=relaxed/simple;
	bh=CNaEIa+dDSUDS0QY0LtEp0mSHtCH0jHrbenjP5Tw6tg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQZgUx81+eFTgAqScBYiyXJZ9Y+FwPi2lpI/IhJlNxllF2vWTo6bipOTopTHx/ezNtdAzsrTSdo4dJmTjiiVC5NHjRthD5p2rFq/mn/8MjYsAy1ZWpdUZYcFdZ9T0s7ERtUEmnSo7NBxvh5vPWw6x/0h0aWvLfgA/V6MdX4i0yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErnpsBUp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322322; x=1772858322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CNaEIa+dDSUDS0QY0LtEp0mSHtCH0jHrbenjP5Tw6tg=;
  b=ErnpsBUpHmrjU0APhCQlGeUk73RJ8uAeYSu8AJsFdqgHj7PwHm/Buxd4
   N+LnZsFK14M4hqbiyhZVgimhv7B1SNiu2Dhq5JZzf6vqBCTfCmUwzj1QR
   7yEjcSqatO/ZUNEcaumxjvvpuDiAGVTFW/ZQQXhtVH5CMTN1q2NSc1LF2
   vJBSQ70gNmKLPuFqRSpprKpIrJTIdPMyuzbRytO8OuuOs7ImCQaeRavhb
   HMskUv0kkKjNntnwbVZGHtslZhpUMRIugrXbLwAmm72DZ+Iruy6j/K3Y3
   UNGcYKY9E8Nu3OEFhuFT/VRZPzWVOs052TeMCj4/aK9eCCv3m4oQgIJyH
   Q==;
X-CSE-ConnectionGUID: +W3MRhcoRzWXtKsKTNH3rw==
X-CSE-MsgGUID: mDGdZB9cRROm3AFnxajTLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42559763"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="42559763"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:38:40 -0800
X-CSE-ConnectionGUID: 1AhWWBDTRkKeBAHx9D32AA==
X-CSE-MsgGUID: 0dc7piSrRO2I3q1/O07YJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="124145519"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:38:39 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 20:38:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:38:38 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:38:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4gPRjxhdnA4aej6yVc7xIHl2xT39WG052n3AXEq8I/XCTpl6sCff49cq/AK/+40hfkeGfEj/huTpfmhyPAkJ2x0wKrEPCCVQE2lY2VpXli6MZtQurwkhrBhc8zkOXIp47Z+mzRsRYWEgKdOdzVnMPgPAxk3uW+wOiu0dSFwRXlQqepgre5s2SC7GnwksrM/OGqq1fyFDL2zqNXGoBM8qt6YtNs624ocSPN5wtZ56DxyfCftfqDrviVg5NYtoCfhnmxlX4MlMECmIyqm/tZ1PbE0gbTx5H1w1Y8Vk+nSu2ohdzEDCMVAZfvpxZCGD5bkEFTVmtNum+AptdtqyPn84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpgDUIXU+Mro2VOaALW0fIIwzEUqZs6yGOJTzy+FVCY=;
 b=NPEoJk22tXAxDM2vEiweW6St4TCStNzHOjjNA7UzUYGgUilpSHMArGtLcP/CAkpG7LTM3CwUHw98BNGmyHFc8T8Nw3PDBLCM1Phpe6iDbZHk/tVWx4w3SpqwalkzMZRzCq3iy9q9RRN/ara8mOjExNjv6lC0TaGRuARRoohR7Iz6WwBZPh0MzGVeXvNuzBK9cessCC6kzN7nA0UUjP+xN8NGnJFslk7bhfsOM50/fIWa14q1iYVajn0hQovl0ewSZLfOgjeO/CGNURn28UcRtw2tGEQZqAcQwBplLgK2sidcZps6a2vJ1FU5gRYcXC9XC70az94ihA43ETyZwSVv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:38:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:38:35 +0000
Message-ID: <7b30f6cc-f12f-49d6-8cf5-9c972ffacec0@intel.com>
Date: Thu, 6 Mar 2025 20:38:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 30/49] x86/resctrl: Move
 get_{mon,ctrl}_domain_from_cpu() to live with their callers
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-31-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-31-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b14525e-9a0e-4d49-b558-08dd5d31ec11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFI4dXJ6cFlyNXdxK3ZJNjdNcGYyaHY1M2M5TTB1dnA1Nk56V2FwaEtnVEQv?=
 =?utf-8?B?N2ZPYmk3dDdRek5CeGVoMDdJWmxHTVhOb3h0MThVaWhRak1zSjF5WkJWa2M4?=
 =?utf-8?B?ZitiU3FFWHRXSEJHWGNiZGdPRU1rL0U0YXhGNnlmQkt1dHFDdy9UTUlxWHJh?=
 =?utf-8?B?MG9ManllQkJBTEF1NEJWckNVM2VGTWV4cXdCZ2doL0hLcEk3TkFFODAzTzJD?=
 =?utf-8?B?Z1B6dDlyelBJM2N0VFRjZ1VuQ3FCbUZGQksyLzBjMEpyQzBEQjFFQ29jTklp?=
 =?utf-8?B?NGo1dHFOY1B5Z2VUSkZhS2dEN1J6S212ZERNMVFHTTZyV3pEU0tXTnlNTmxs?=
 =?utf-8?B?MkE5M05yemdHY3ZZL0J5L2orYmtkRnRDZzdTVjh3M3JncHpKeGJodG9heWFr?=
 =?utf-8?B?RXFlLy9TWURWald1dE1xY1dCcVZ6TDcwelk3UXpxMkpCMm8wbjN0RFkzenFP?=
 =?utf-8?B?aTc2RU56TnkvNmpQTDlXeE9aMWQ3YjJEcXB2c01VQmRNN2hEWEtXTHdDclBs?=
 =?utf-8?B?MnhCWk8rbndLWVFaZmE2cjNha08yVGdvY2RMY1ZjdHp1eDZnTkxGWmlNSGhY?=
 =?utf-8?B?RGwxejRXcEJMTDNTdE54ZVRiQy9NYnJOaDFtcHZjZHZobWVTVThWWllWSFdL?=
 =?utf-8?B?N3ZZT1VsV1M5bEM2K09TTHNiREx2bDVlZHV2SjBYSkh2bEMzc1piajRnL2Zy?=
 =?utf-8?B?L2ZlWmxNS0RTR1Z6QlBxZENJam9jTWU5Z1U1enpvWmNGcjJLdlFBb1RFT3ps?=
 =?utf-8?B?SUkvUkt2M3BFYS9zVVFyUm5FMVllNnFTVm1IeDEwU0VNUFhRd1pOVGYxTzNF?=
 =?utf-8?B?WWhFU0E2V20ramlFK1kxWTZZNzg3cS9ld0lvNDJ6TmxndEdwSEF4ZlViaCtT?=
 =?utf-8?B?TG50NDVTQVV2MG5sOXdZOXVKQ0pQTDRISlQ0RTcvL2hBQjhNcUE0N1B2Qzk0?=
 =?utf-8?B?OHBmRndLTVNjSy94U3NqRGlwVjJacktFdnRqQ2FXcEFkNnk1MWxmR1pVQ044?=
 =?utf-8?B?UnVDSXFIU1dxTE1CTEt6bGtoK0FSMGRBN2NNc1pXQXYzTVc4L3VWZ0R2NGRC?=
 =?utf-8?B?UU9JdGluY200L1NGZHA2YXltVEtJb3NvbFVPQS9zV1Q5RG9GSVZEV2V0d243?=
 =?utf-8?B?WkdaR3pyRXY3Z0RXbEt2d3cwaWVwcDU2MzNMcS9DU05GY0VGME0ybVN3RS8z?=
 =?utf-8?B?SzdDaDlPdlAzbldkU2dkN3IvS2dyNmZObjJIbmxOMUVkYzRRYjlmMU1oNTlR?=
 =?utf-8?B?NHVTU1ViQUFQN09oNTduTVRjTWNDQmg1bU1OUGRwek9pZVBvQ05ZRjFFdUFH?=
 =?utf-8?B?QXVDeFc5Njh6R2V4UXlJK0h5d0dDTmpldm9tY0NERzVleHlUVXFrc25RQXRo?=
 =?utf-8?B?UU1PSElQK2N2Y1ZHaXlqalcrelFjUkJ5L1lOd3dDZ3JGVkx2OWdxMmZIVVdr?=
 =?utf-8?B?ZCsxelk1RXlZeDRYN2o2RURpcWw1ZlRreVcvNi9YUXlYSmZkcDhHb1VkVDVo?=
 =?utf-8?B?RHZGaVFmMlVuNjVnbnN5WGNlVFpMaHh0WjZYMllqM3dGb0k1STJrdXJ5Vmx6?=
 =?utf-8?B?K2MwbDlHUTFCVTRzOEE0aE5nblNGRytPQVFNNU4xNWowMTVqY0FDR013OXRC?=
 =?utf-8?B?cGJ5b1NxZ0xZZUczaTVFY2ZFenFEeDV6NUp0RnA2M0FyeGZOQjFCd3FxUWIy?=
 =?utf-8?B?Q3MxMHBoTk1yeFlvb25xdGZNRERDdXV0d1ErUCtVSGRoMHJxeWVyL0pXOTBr?=
 =?utf-8?B?bU9EOXBha0lObjl2ZThML2l1MG4yVWRiTWZGZmVTRGxiS0NoVFJTMlExNjVm?=
 =?utf-8?B?VVVVL0dLZFhJR0ZWSVdMWkNOUTZzSmVOMkF5QktuNmx2ZUNYbUhVOG5tWGdW?=
 =?utf-8?Q?9kFyhj8vZd5gJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVJlSkNCcVlCdjBKdURIc3VrVkhuMVEzSm9NL1FHODJKcTkzQWV0Nm93NEtL?=
 =?utf-8?B?anZBQmJMMWZ6aklPY1Z2UTVxa2hmdkdEdmx1NGJwZEJuVFVVUGJyMFp4YkNZ?=
 =?utf-8?B?TXVOMmtqWCtTcFdzeHNGdDJiTWtQNEtLVjZyejc2elAyU0JsdUtxSXM5cXlQ?=
 =?utf-8?B?ampNaWdMVFVMeTlTVWtJamxHR0o1Y040OUZWNThteWo1TFhJMWp6NnZmU1la?=
 =?utf-8?B?TXI4TnJpTFlacXhoMmFRYjB6dEx2c05jbkx5RTRnUkw0R011aWRmY2tiVEFQ?=
 =?utf-8?B?aUxkYlNTTG9VRnJzOUVYck8vRS9aZ2xsZHk5dFdSZXdCTFpvQkk4YW8vY0xL?=
 =?utf-8?B?RFdWVWE5d2RMTXUwWUFPVVkvTEVPa3cyNDBuWGlocisvMVY3bTRaQjJ1eERy?=
 =?utf-8?B?WDllMUlicytOaGxLTHJnSTVxNjZPd2VISUNYMGNtUjkvdlB4NDdIK0ZOTkFV?=
 =?utf-8?B?anhBRFAvWTQrWmFUYXF0VUZSZkZIZkd6WHhWTnlSQ0h0ZHVudmlhekxvS1c4?=
 =?utf-8?B?eG05SmJSVTk0YlpsV2YxcXljbFdHUDhPbzd2N0NTajl4Q2lWN044VWZreEly?=
 =?utf-8?B?Z245ZUU0MFU4bERVM09XS1NWUEdjUmlGNERGUnFyWnRlbDlMKzVLTWczNThk?=
 =?utf-8?B?OGZHdGlQSnB6cCt5MkF6dlRzZ1VJRnVVV0t6UFY5MHc2US9iUStpejkzMFNx?=
 =?utf-8?B?QnhnU1RhTHBiY2hOQ1pUalBsNTc0YXoyamFIK3RHODVPQ3c5VnpUR1Vrbnk3?=
 =?utf-8?B?MmNyOGI5MHY3REVOdTE2R3hzYTdyMmdEYzRGVWpxVUxvMnN4NXR1YkhJbWFQ?=
 =?utf-8?B?SlhoTkV0ZnZiUmF2anBrRDRReEo3Rk1TNFZCWW1QcXFDbjI0VkcyMjlhbFB6?=
 =?utf-8?B?bmtUNVp6MkV2dkZhSE9XNXkzaTZjRnkvdlZqbTJPTkk5ZndkbXpJdFg4M1NH?=
 =?utf-8?B?Ynk4eXJ4MEY3WmMvWkZZdDh6Rmwzbm1nb2xiRXRnV3U2REp5MDJlL1lDdXhK?=
 =?utf-8?B?NFVpeVpPdmZhemU5RC8yZzdxTEpJTjZyUUpRWUt5WFhFKy9OMlZjcTRsbGNi?=
 =?utf-8?B?bFVTV3E4K21QSTVwdE5OMjJSS2Zqcm5xOEdkYTl3OTNsSGRpZS9rU2FyK0lt?=
 =?utf-8?B?aUEvSXA5QmYwbVc5cHZoSUY5TUFuQ0ltSEkycklRWEhRSHdKWkZ3VThOa0Ez?=
 =?utf-8?B?UlkvS1ZVRWNqTmNjc3RmSUtKaWJaRGFKdzVSZXdaSEhaVTRxZFdMRXVXQ1Yw?=
 =?utf-8?B?ejlrc1l6d0lrVmRoeHBOTHhNQzlianVtOUlKWER2WXNBcFd6QStMdHM2dUIy?=
 =?utf-8?B?dG9RdHN2SGdWcEZNQS9uRkJFV3JjR1NFY1hMejF4cDg5SnNacXpNUllsU2ti?=
 =?utf-8?B?SVRrdkVBeFhVcWUzeEhTaDl4NGNZOFNkTHp6S1Jnb3dCd3d2NlFVTHoraFN2?=
 =?utf-8?B?WXRaWUVJdDFtM2pJQVM4YTNRWkJxaUg2RXVVTmFNM3pqYndTSEdVeUg4dnRp?=
 =?utf-8?B?RDV1UUU0TzR6alR2VktQZkFmb2ZXaVptVklKM3YvWXVOQWZZY1ZTVkhpVVBk?=
 =?utf-8?B?Sk9jRE5TWTV1a0dndW1pKzNTdEorS3hPN2VGWExYczNSVHpyZTJpcVlKTjVj?=
 =?utf-8?B?RjRQMUM5NGRSN1FPekpnR3BZbHU5b2s4VW50UjA2VTg0WDkxVU84ZUdmOUdI?=
 =?utf-8?B?TzllakJUTTFpNlM1QmR4MWYzTXpjTjZoZHJQWDZyc0JIQldReGZWQUVMTWNR?=
 =?utf-8?B?eWZRYng4UGxtdlo3REpIajNWTy9ZK3VmSHZNR0pROXV5VUJRUWo1cUNZVXpr?=
 =?utf-8?B?VnZJcCtJaEFXOEpLTWFoSFNDa0hMTzNWSDVuY05hbmxWbG03WXZpRURoOGpx?=
 =?utf-8?B?Nk1ZT2dUMmt1KzQ4NmUvUTJackdUblMrNUpZUWJrZzV4aFYzLy91RXVWbVUz?=
 =?utf-8?B?WStYdExpRGlCZ1N1bnNncE5UQW9qbC9IT3hhNzdVMnhiOHNQZFMvZVhMaENE?=
 =?utf-8?B?L3ppczIvUkJ1eG1MbHE4aGdGUC9pUmw0S0liTkNHYlJVaHp1RnpHWnZXUlor?=
 =?utf-8?B?V05TcVMzaDFMeDlLUmNadjZRMGU0dSsvY1NQRk40d2J0aUR2LytsZ25xRXd5?=
 =?utf-8?B?ejhRMnJHZkpuTC90blYzbU5lMlRPcm9sZ1ZDb0k2eUU2NVhvbjhvN1Ayc2hG?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b14525e-9a0e-4d49-b558-08dd5d31ec11
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:38:35.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46vS6EptzngINoqO8/LW/tXP+k415JHEZWxk9SfvohdxG/N32ook0IdfqQr+xevyez5RT6eq5fUc01FFxiY6Dtq21+V2tgUIsiBSYEj0+Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> Each of get_{mon,ctrl}_domain_from_cpu() only has one caller.
> 
> Once the filesystem code is moved to /fs/, there is no equivalent to
> core.c.
> 
> Move these functions to each live next to their caller. This allows
> them to be made static and teh header file entries to be removed.

"teh" -> "the"

(found by checkpatch.pl --codespell ...)

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

