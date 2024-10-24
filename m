Return-Path: <linux-kernel+bounces-379036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA19AD8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270B11C21608
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A2136A;
	Thu, 24 Oct 2024 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVez7aU0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7C19A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729728521; cv=fail; b=ciIDGfb4LsIA/a5xaSLiiS2PZMw1PP3YvnMUwD3q2CvoHdhg7iLoLSDEretghVLsQgEgIqKFdfJu+Lucny/NN3i6EMr9B6w8NIJ2Tv71iho4k6y9YS+Fh+ZqdeY8mL3DWD8unuKqjFZkaTn5apWxJVJZPqQEKe0f3f2jO9uerWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729728521; c=relaxed/simple;
	bh=FFjFDLuQv18FB2wRm0FF11WsjMEHgjTk3rwuxJ4uj74=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TAnurjtuWizSm/oI7my10ycT82vPxFmFud0CELazCvoiJ+r8Qiji6SKbKJ6z2dSEXfexp7dZr+qNGPdNj+GRVxlNLBAEIrvqWLn7jACICxGzTBpcBKy/wuJ1niswYq24e82ioVIF8Dc0fWNCq5L6sj57Cuf1GEmlV7t6u4Mq+M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVez7aU0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729728520; x=1761264520;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FFjFDLuQv18FB2wRm0FF11WsjMEHgjTk3rwuxJ4uj74=;
  b=SVez7aU0ti3F1VjO8y76OME5immsNU4zwc4JooZOdbNv2bv7hDTj35uc
   bCbsD+wwR84yScblwv89cctCOV9U2nhEo2gXRWPHnkfB6qXxMjwsIselX
   NndLI36Zftwabb/vW11INdw7tMeeopnI4Jbn51bq0A+ugrmEpBUXB4aqD
   ckewSu9t0IA70cBHrMRktJTblT0Imm6lrJIW+Zaxfjm+8INO9JxMTAL7/
   CcnDoMmqAduqtmnlV+glX7YGK3aCOFctjq2YkvCuwAri526ZkkCbcagA0
   r7qLgsAbykcIqz8C6pUaRRNd0gIAXoQUlc9/7fKDdKGR9BgJxdEtUgXjj
   w==;
X-CSE-ConnectionGUID: OTu4z4GXRyueJ+RaWaq1cg==
X-CSE-MsgGUID: UyrX7bYATfOQo6+V5lN9gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="40734443"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="40734443"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 17:08:39 -0700
X-CSE-ConnectionGUID: s122hWiIRkS7pGdsNxYpEA==
X-CSE-MsgGUID: G8AsVp51T5Skj2Lac6JyNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80090449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 17:08:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 17:08:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 17:08:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 17:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQPsn0LYy75ZQK7VVTmucNW4BCD8o5p/0olBTpmRRQXR4r6hkm9ER6kFm3mjqwV7xJYzIvZkRf6eSoCqGd5Au4pHNcJRCMrrw0XqbWNYRl/5yRgfqioTZlzamdvX3KjQOJ1vMZpoue9bQZG10rmSPKxceEQOu2CnMJw2POvUbxChj2eYQ9AoW6BKvh278IPS9YiIbBaeL+j2OdcWSGYX4Ru/Zet2P9WML+E4DkaPJKJxvMcZNZogiOc8egC/nYGrTi+AQOpD3GqRmj5LudVCQmVEL3D93qzn9zgs6oAGcNLUOJdK0YJzSp6gXR5MpHELvQs9VTw/FHpbXhMciCgECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE05Qrx6ncjxP35wVKmZHj2mVnzlLcNJUqzyiDwJKQs=;
 b=HdqnPSIe0sEiS/bSQEh5DC+BhjwNhURkwumFjx+QZAb90ZEFvdu701Br4TYpf1UP9uGHPXSY9gsP8yywVGsOMYaw3amJoPVA/feh/xz8yyjHiBVdtHXSthPr0WoGq0Zke+r1qbcQlX3HLzwFRbr5ekn1HX0PpQS1IFUowFxvAYV6Gh9hHAJnj+DTCf70Rsrkuv36BwgxFY4hqZ6cdIdklE5W7kzyFbNDS8N2E6GK45MhzCrpGUd+hml+oFkTQtWck47ZfBBWTKJRh7uh8zB7fT0+E3kocnXw/0nwOdPJtK/gj47g1eBgE95/JWiveBthzhQZN2+6Qhw1EdasbNVXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 00:08:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 00:08:34 +0000
Message-ID: <b674aa71-bd06-4cd9-be3e-13e99fb23f15@intel.com>
Date: Wed, 23 Oct 2024 17:08:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 38/40] fs/resctrl: Add boiler plate for external
 resctrl code
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-39-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-39-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: d05b7b6d-15ed-4d12-b65b-08dcf3c00084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGc1bTZuZUVKSmMxdmhGS2h6dS8xb0ljbS9OR3dtdEVtWUFRRDJONTFKUnI1?=
 =?utf-8?B?OVpXTVZkRTVLemd0QjdTb2ZnSzI5cWNqQXJlcngxSS9WU045cW5VWnVDWnlM?=
 =?utf-8?B?eVB2UFJUZFZaQTh0eStxbktiWUwyQjl3TmQ3b0QwQzlORjFTTmU0cGp5aFhH?=
 =?utf-8?B?TUcwSHhpZERDN3NRdmRNNlMwcDcxMzAxMUg2aXdOcjFxUnhZM05rMmJOQzVX?=
 =?utf-8?B?amJKd2NHQkQ5dUZCRVJQMTZEbGNZckU5cmNsdDhEZHJoOTB2ZllKRFhBNlZ4?=
 =?utf-8?B?emQ5SzlJazBjTTFyNkYxbU1EbVB0RVY2UEcyQ0ZiWWZndFUvZDJKZzQwck5U?=
 =?utf-8?B?ZWVmTG5VK2MwSWdRTFZzUkhvL3E1dXIvTGwwVGNiMXByS0Z1dThlRGpaYlZE?=
 =?utf-8?B?U1pGT3ZsMXZHbWttUjNOUDZ3S1V6QThUSGNHTFRCd2JKZFo4RWRkckRxckpo?=
 =?utf-8?B?bDN6bkNTVk41NHNNbThaeCszQ3cwSTVGUXJ2azZEdkI0T3kvUTJKZC9FWHpX?=
 =?utf-8?B?TU0rcXAyWS9IelorMTh2UEk4ODdta3lSWWZCWGNrMlM4L1czZGhjMTZPb3BE?=
 =?utf-8?B?TDFFZmNJbzNKYVFNaGRjMFBGSGhrMnFTbU16OHQ5U2hsb2Z2RUpqVUJPR01p?=
 =?utf-8?B?V01PbU5McGNuQ3lvb1lCcmJzd3R0NWtZRGZWeUxOeFdRUUNrV1ZsdjhwNjEw?=
 =?utf-8?B?dDZHdTNzeWRNTlRQOTBjL2VTSXRVcTNVdXgvVGRnVTd1ZTlMVko3L0t1RGJ5?=
 =?utf-8?B?bE5wdzg1OThkaHpCbGN0Ni9ZdUhtOHNVRUV0a1ZNSzlZTmdPL3JPVXkxU3ds?=
 =?utf-8?B?Yk43UkpiZDdTYmo4YzN0aG9pNEFYemkwQXcySlZ3K09qeUQ0TWJxeS9GaENU?=
 =?utf-8?B?eUVkUkFWa0pKblB4NHNKbkJnNlpINks2RWFtMzdwS1FRZHgzdVNZeGgrdmdn?=
 =?utf-8?B?UW9HTk4zS3V5cVFqRWY1bUpDcGltbzJHUWFPVTNvZzZJaWF1Y0gwKzg1L1dt?=
 =?utf-8?B?OVZJY2xrYVVrZEFQWjk2UE14QzluSDNzMG95WjJCM3hvTHNVZHNoU09EMFZm?=
 =?utf-8?B?QitYbU5Yd0JPK2ZKUDBjaDA3YU4vaW4vYzZJVTNKUDltRHRHTDJYT3ZKQ2lS?=
 =?utf-8?B?ZVZ3MkFSR3VuNW9iZlh6RktvVG9sczcxL0lteXI5WHJidTc2R0drNnJLdDhk?=
 =?utf-8?B?dzJFN3JLUFhDNW1CVVlwNmk2NGxVZDE3Q1JFVEVObUp4V2lCYkhSZS9Tb3kx?=
 =?utf-8?B?aW1aRXZncjY1NzBzc3IyQTd3bFZuZy9oZTFNQTNVNTduU3YvaGlPazVCQVJx?=
 =?utf-8?B?bjlqUDJOT09CcjMzeG8zaVo2TkdrZWFvQzVsS0UraHFuZlkvTW13bW96dnZY?=
 =?utf-8?B?Q0paN1hqWW53cGN4amdzY3lxUXl3RVI0NDFZVjhlRy9OTUpZaEdhVWNxZkdS?=
 =?utf-8?B?SStjMUJxQjBuWjZxendmNnhGWmZMVVNXdHR5SExVOHptaFQwVkl4TWxhdW0x?=
 =?utf-8?B?OVUrL1NKTEk2VlpwbHpKRzZINWV6ZzhDeUMxWE1Iak8xSmdxeWRFQmp0TUM2?=
 =?utf-8?B?WEp5eGsvSkpzZ1RoS28xZWZLQ0pHUXUzUldLTEV4MFF1OHdJa0xOUmlicm9o?=
 =?utf-8?B?T3lsTjV6R29vZWJVbTNuQjZqWTdqVTZ2U3FEbUpUTjZDaVFDTmE2dlljRVV0?=
 =?utf-8?B?NW5QWDJYeEh6aE5kNnNrYi9DV0FEbEZ6SmdRMEx3N0UrSVRCN3RXQ05HaWps?=
 =?utf-8?Q?V1277PraagABKKNNAA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHVTdW94cmN3OGJXNzlCNWYwR2ttYjc0NzlzODZsVTlWejVWTkRWTnFJU1NJ?=
 =?utf-8?B?VUwyclhzRUFmb3JMM3U1bnZRYWMxeDF1VFNmSnpHTjh5WUpKVDIrbXk3c0pR?=
 =?utf-8?B?eTk0RWMxdGk4N09HQ1B5MXpsYlZ4Wk4yZ2dWY01qdlRFbW95cFRCZ0V1ekhr?=
 =?utf-8?B?cU9JNWYvaHlFL090YVg4QmQ3Szl2ek0yeEE5NXh0TXcvTlZQSXpncXgvOGVG?=
 =?utf-8?B?SVZEUWNmYVpLTmpNVUlnRGJHeUVNQzU0b1IxQ2RVZHFnMVN1N0pyaG0wYngw?=
 =?utf-8?B?K0wxSmtqZmJGd3IvS2EwR2JxMTFpcFhwUTY3M0Z2WkRJMm5mUXFPSGJqbTZk?=
 =?utf-8?B?YkQ3V3ltMHA2RXdRRmZpWWcyMU9VekJGSWVCM2FpamZ0NkxBUUxUdVg2R0Y1?=
 =?utf-8?B?cU95Q2lESkdUZXYrMW9MWXZ2SXlIR0RqLzc3Mlg2eGZ6Q1NpR3N2dHcwZjBQ?=
 =?utf-8?B?YlF4ek1MTGgwVnRGSUlLcERHTTJVM2xQUmF3TE04MVA5RWs5MlUvR1VURTVB?=
 =?utf-8?B?dGlKOVY1Y29IZm1zWHdXN085c2Z4U0NpTHdrWW1iSkpCbVdzRHBSRGhycEtq?=
 =?utf-8?B?UG1nZnZ1bDN0YlRjQTZNSjBSemp3MHNISVNNV3I0WkVwWDU0SUhYdDJIalhw?=
 =?utf-8?B?a3F6eURnQTZrYm51SFQ5enAyVUtpV2pOWTlFSm1nU0J0ZEhNZkpsbGU4ZkN0?=
 =?utf-8?B?dkFRdUZoZEtSbGFwaWUzNjU5NzltMEFUeHJNeE04TklTbXRRdW44S0k0Sjlp?=
 =?utf-8?B?bUE5ZzE3NDRkZFI4dHBTbDJNUy9LMnJlbjFUQ1hDWXZrZm5EZFY4dUZvcFh4?=
 =?utf-8?B?Mkhvc2pHY0NjdmFTUXNMQVI1UnNpN1plVlYvTm42NFB2WXRyVzVoS0ZNUCtM?=
 =?utf-8?B?T3ZkOGxTbnN4VEJXMm8vSEVyanZkQ1hQZW1PWFF2SW5ZeTNhY3RGa1I4QjZ5?=
 =?utf-8?B?LzlMRUtZU2cyb3A4My9LMDZuTUVyQWdoeExCYndaTlNLK0tyd2NkOGY3d01y?=
 =?utf-8?B?VHRnWEM2QXhDTDE2OUNqMmhJdE5Rb3c0VURVSVdSRWtEdXJVRGg2UWVoM1RN?=
 =?utf-8?B?a0ljczlBMHBXdnRyYS8zNEpaOVZURC9Id3JMWjhnR3FMekhPWklqa0NJeXJw?=
 =?utf-8?B?REJnT041bTQvZTFiRWFvUGMvajJPNkZnZmxXd0Yzd0FLQ0RtY3loaDlsMlJv?=
 =?utf-8?B?UVRDVUVtVnlxY09YRVBIeUsrR2NTNGsreTJ0T3o1ZFpuZTBkWnpPaTVLMFFq?=
 =?utf-8?B?RTVhUkNXanBGckpQakIvbEV1Z0hoNytRUXZMTEJvbGVldXF3UXY5dlhWWCth?=
 =?utf-8?B?WEJxbDl0aWVIRmR3SmFYdFNNWWJYNDIxREtDeHh2aVJYZFUzSWJKV1JZOStD?=
 =?utf-8?B?cjh4cndOVHhFSHk0SEszMmhOS3ZRdDg5Z0NxRVVDWkR4Vi9kWlVIUnhLZ0NZ?=
 =?utf-8?B?bzZMejJ3QTR5QjlOV1kxQ2RaNFgzWk9taWFKYUVUOStJTVNFS3NUTHkyT3Rn?=
 =?utf-8?B?N05pRHpCcXdoWnRpb1NzVjVUa2cxTkxPOGdhQmgwd3NnYXdxeW8yTXJBYlBw?=
 =?utf-8?B?emc5UXBUZW45WEQ1Y1ZudlFReExCYVJWeGcrQXpFdlZZZ2xiNklUQ0RXb3Z1?=
 =?utf-8?B?VGxCK3kwbk0wK01ONGlaQTBtc1VDTTFqaE5sSm51L2Z5bm8xeDdUZzFINzgz?=
 =?utf-8?B?bW52WnpzTk5PYzNWb1JoT05VeFB4RzVNaUt1TnlweDRZNXVON2hEcHB2dWs5?=
 =?utf-8?B?ZTlOL25RdUN4bk0wVWhmUzZnMmkwMy9UaFVwL1pwYyt2MXdiQS9BUVE5aUpC?=
 =?utf-8?B?THV3SUFXK0k3czMvV05XQjl0L3ZhYnNpdTluZGgrME56OThtOTNCQTdNVlRN?=
 =?utf-8?B?NGV5aitlOHF0R1pkek1sdHVrc1ZoVWZnQVR2MVNuMDc5eDZkUUVuaklZSUJ4?=
 =?utf-8?B?d3cvRVVSdUZTSzVEUDlyc29jSUVHRWE0UlFlUUQxQzZ0dG1VTVBVb1AvT3Bk?=
 =?utf-8?B?VHk2UUZka2tEYzd6Uk9zaUREcTJuMk5RZHcyWlVpQk1ha3FNOHM4WUdvV3Rm?=
 =?utf-8?B?MUQvL2VpTWM3a2pFOWxKYkxmS0pldVhTQjk4ZmFHSEViT2FFZ3djcHVkc0Ju?=
 =?utf-8?B?R1RsdzdqdlB3d1JpSHgvZWd6cEg2TUwrN2gvWm1YY25MQzNuQWxpR1FxT2xG?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d05b7b6d-15ed-4d12-b65b-08dcf3c00084
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 00:08:34.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iifn2rCAAvYRlrYTaIN5+TeeSH5joIJyfcf0cs2jWzE7stbWd3Emfnl77972ge9yNuRiklfOyY9R/iJZMz7kIfnkb9eJAR/WWDWq5VT7guE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
...
> +++ b/fs/resctrl/Kconfig
> @@ -0,0 +1,37 @@
> +config RESCTRL_FS
> +	bool "CPU Resource Control Filesystem (resctrl)"
> +	depends on ARCH_HAS_CPU_RESCTRL
> +	select KERNFS
> +	select PROC_CPU_RESCTRL if PROC_FS
> +	help
> +	  Some architectures provide hardware facilities to group tasks and
> +	  monitor and control their usage of memory system resources such as
> +	  caches and memory bandwidth.  Examples of such facilities include
> +	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
> +	  Platform Quality of Service (AMD QoS).
> +
> +	  If your system has the necessary support and you want to be able to
> +	  assign tasks to groups and manipulate the associated resource
> +	  monitors and controls from userspace, say Y here to get a mountable
> +	  'resctrl' filesystem that lets you do just that.
> +
> +	  If nothing mounts or prods the 'resctrl' filesystem, resource
> +	  controls and monitors are left in a quiescent, permissive state.
> +
> +	  On architectures where this can be disabled independently, it is
> +	  safe to say N.
> +
> +	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
> +
> +config RESCTRL_FS_PSEUDO_LOCK
> +	bool
> +	help
> +	  Software mechanism to pin data in a cache portion using
> +	  micro-architecture specific knowledge.
> +

There now seems to be two copies of this ... patch #23 added this exact same
"config RESCTRL_FS_PSEUDO_LOCK" snippet to arch/x86/Kconfig

> +config RESCTRL_RMID_DEPENDS_ON_CLOSID
> +	bool
> +	help
> +	  Enable by the architecture when the RMID values depend on the CLOSID.

"Enable by" -> "Enabled by"?

> +	  This causes the closid allocator to search for CLOSID with clean
> +	  RMID.

Reinette

