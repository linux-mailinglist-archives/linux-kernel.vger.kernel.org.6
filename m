Return-Path: <linux-kernel+bounces-523031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AF6A3D128
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8866C3B446B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D7E1DF960;
	Thu, 20 Feb 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzvE+07L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570AE1DED4A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031834; cv=fail; b=YLsPCOdRsHmrRon0Ef3PzYqObilLpEkF4yqkT4WSR+2Pzt41ho1zAfWO6qCVlkcCGKpGXsLM83ziBWtCB1I3Z++6lVTXWoAgzOQROf1ffmP3Vtro3UgoGWCc3aY4yhkwwMTu6CG1DOxTXJ+3vQD+L6Juj0U3O4QJV2nL7h0/Hgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031834; c=relaxed/simple;
	bh=MzXWI8/EwYNY6BYSCEPtf3131cqkxtAKxBN0vmkqN7s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgDnDbzgPQmlk8eANrjrZoGy0qjJ3dTRyzMebKrajq5DreDZbJ/gg/c3sSZ0IYSEjXjUyCZTvMxacxSb3j+FH5/ZcOI+sueBvEeHujBpI/DhFsQVCXpW7AnrcVZoOtqV6QFVXMfc0BaWofp3/Qe5x6eJZjCrAAUf9oA0oVKIuEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzvE+07L; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740031834; x=1771567834;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MzXWI8/EwYNY6BYSCEPtf3131cqkxtAKxBN0vmkqN7s=;
  b=hzvE+07LTuzyjf8CNMVlBMVrKP049GSb1hGwI6Bf3jtmVId1VB9a+DMz
   PK0NxDP08BCwOVdchB0cQuUQBOY9VS+OJ8vq1NVGN3SQrM9EcO23T6ZOG
   Qg5O5YuLMR+CV6MawGUStYP6EZsOGIOfafSBRBZZCMHvAcHhc7ySGYU9N
   TAvUnPVku0I0kUjQScehUPqh3M/I0sXJz+1odoqbmYpXXQAE5tuX/Vbo3
   75sUjwDL4Z4j2R2A4PKhhYg1y8R3Ed50PNdIm4FHs4to0YDNfQaGpWoI9
   UTMCPal2Ynlh6HOh2J49bRekmtlu8ZZDYODC3vcZi1ljytOoIM2YwqLDK
   A==;
X-CSE-ConnectionGUID: klbLaL2eThurZcSJUopKnQ==
X-CSE-MsgGUID: pPewVUALRjGX44Wslm7gAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58204039"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="58204039"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:10:33 -0800
X-CSE-ConnectionGUID: EiC4TSklRGeMhbzeSLFuqw==
X-CSE-MsgGUID: S6n43qqxTO+QcaiCCM36JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115431910"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:10:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 22:10:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 22:10:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 22:10:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLIGdW3VxaGlTWkcyYGY+RLyRZ/gN6IvxvoQazDCDh7k0pYjMo3o8tzb1VS51mpro5nQIpHA/XmRq8ltDnaX4pfUoHFV9E3iCOcwXQUgAJlIRTARKhB2EiFfPWaBT7i3coNsB7SePmVLoxH3phjLg59oEvcRUcW3mfjQat7XfycTQN56khiiommzpXY6KyLaSo2LarcckAUUmsRxuVi+w94ZMc4MeN1tn5GAQZRHRp6rnztx8syweZHp2YmJZ37945SD+CMUta9U6n5iPy0JexlosLET3O1YBAMw6lk9RtD2dtz7z9zXeClo96C1sIwJLZ6rWndrQX1mn8AHdEu1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZhmZXPeLwI+4A/UCfpvhSArrTGrrzUYBSXiHGO1gjU=;
 b=Rju/AMtBo+LWxRVP2GL1sH7BGfzc2gJhy/t56qfW6iomuuM82TumiHl8JdNaDHALENW1kGZlB56D4HvHzkyfuQ+C9k9dxFQpqlWFq+dhzxLEdj1BtGj8JIyVRxbmV1WXNtNvwPqQB6jZ11qds0RmRk2J9e0BzJUDh6gaZJ61Bpu48v2AUjuBdusWVsXVcj45QXOE6qyvTxLx7SKDOo2yDSSs2gp9A4gKkmiNh132+U1mmNP7ozGDPkSbpBl6TKU80ywydgsO/aFRmWakNL+Zb/lQWmTRCmzaDS0S4QB6DCxY2X+dukHzCtYasr4Lv9tFhsy2b4YC6jk04jf1qb2X6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 06:10:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 06:10:28 +0000
Message-ID: <baa225e6-65bd-49ec-baf9-166ae4f2926c@intel.com>
Date: Wed, 19 Feb 2025 22:10:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/42] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
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
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-43-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-43-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 441fa163-0ee0-40b7-6825-08dd517545ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEVZR1lIdDdJaGhPK2MwMW1rQ0tkMS9NWjByMEFubHNoeHlXNERERW5GbzF2?=
 =?utf-8?B?N0d4ZzhnQ3RJbmwvTEdQK3J6WUozb3FIWjlKakFUU0NSaTUrSDV4OUYxQjA5?=
 =?utf-8?B?SUdqL3B3ZXRhdWNmVDBLZnhJaDVpYzlrQVZwd1hFUS9JbTh5dmExa1FlUW9w?=
 =?utf-8?B?SzdkbnRyVlhhTGZtVHB5c1BLK2NETGM2REp5Z1hUSy9Ddit3OHllSDdsd0ZR?=
 =?utf-8?B?bTdQQ29YaEVRSFNqS0JuSlJZWjZQbStpTmJsWHBzbVh6TFZnTXRmRUxwN2Nw?=
 =?utf-8?B?UEV2UWV4Q2N5YjhYbkU1NTRvSWN6cUk5a3VoQjdaRnByRmVuOG94amgzWG9H?=
 =?utf-8?B?OWprR3duYlJJemRneTdqU1c0SDQyMk82ZXZOdlhyVjRuRExqMHV1dW5KbExQ?=
 =?utf-8?B?RnB5R25KRGl6alh5blgxK3ByTVRRdHBvZmxGN0NucnVmUEVxbEVkQUhMRjZF?=
 =?utf-8?B?dmNyZnJiUXdaKzZhSm5wdEo3T0NvelNnZlJsZlY0UHR5dVNzL0lZZ0szMHRJ?=
 =?utf-8?B?TzVHVUtEZkJVMG00RXVsTnBqSmI0Wk1ZbldIQmlpTjRQdFNtcnFkWk9zcXd3?=
 =?utf-8?B?cDFscVFWTmYzaEUySU50dlFCUjJCaWlGeHJ4WlVKT1pwTEg1TzF6TVJaY01C?=
 =?utf-8?B?ZDVQdytTaUI1OXBKT0ZoT2ZlcU5zSG9aY2drWElTTlVQbHFZTVhjc0RCL1Nz?=
 =?utf-8?B?V0dnS3I2VTA0cm5KMytaaDU2eUhLKy92WStJV01VQkJvNzdvaElyakdyWkc2?=
 =?utf-8?B?UEdXZnhBTEVUTXA2cms4QVQ3R0JQdUZSMzFJTU9rUk9lMXZnQ0UzUEFjR3pN?=
 =?utf-8?B?MkRjL3p4MktoRWRRNHZKTWhVM3FWR3QwbE05MUozQldYWjc4SzdBa1RBdlZw?=
 =?utf-8?B?aGdLblNNU0pMOTlzVmlPOVZIaTdKdjJva3FTZDBGQzhiZjVUVThEK0w1UWp5?=
 =?utf-8?B?RFBBbXl0YkUxa001N2lOcVd3RVdNNnRSQzgvTVJTNnh3bTlaWE1PYzNheHVj?=
 =?utf-8?B?S0FXM1FlbVVQbUlTMkovTFpTanFseEp1bXJRVGlYZVVrU2xhUzhnVWFqNlN2?=
 =?utf-8?B?dFpUMm9sTHVydkxvbnQ4aGd0MW44eDBkRUpDZEs4ZlVhTkc1bHNUMHRkN1VX?=
 =?utf-8?B?WCtOYmxGaEphaHdjMEpMVjg2WDc0Sjh4MTdNelV6ZXlGWXU0QW9BY3JaSDdv?=
 =?utf-8?B?NWZUMXVVVXhNR0dzNXhyaTlWeVA4RnFlc2pGeS9YQ1hvS0JPSTU0WW1DaE9r?=
 =?utf-8?B?WWMzV0lXc2tOMjNIcjNERjVJRTdWUERmYXY4Q2ZhZjIwU3g4MUJDVEVMd1hJ?=
 =?utf-8?B?dVUrSTgwMFNFeVpEcTd1OHRnSXYxcGFHTDNvYkxrWG1MT3BWTU9JWFJ4bzRy?=
 =?utf-8?B?eFUzTHdEeG82a2padU9tOW1yWDJMS0U4QWVYb0VJMFZSZkRXek5RNVNjcVlB?=
 =?utf-8?B?QjlCYjl0TlVVQWEwRGZYa0prbGRiOUp3ZnBxMVFkMEY5VlYyck9mcGg0Tmsr?=
 =?utf-8?B?cVFJUDdEWU4rZWhMRkM0cVhaY2NFQ0d1NEFuUGR3MGU4QytWeW91OWpNUmJv?=
 =?utf-8?B?bmU2S2U2Mlk1aU5UVVRJZXlZSXc1a2duZkppeGNJL2UxN3RMRm9WSTFpVXIr?=
 =?utf-8?B?Q1AxQ0wyYklMSzcxSUxKMFR4RStRUmU0eHI4bWZOVDhweFV4Y0w5M0V1ZE9N?=
 =?utf-8?B?UEdvbFF4dlkvOEIzcFJPR0tXMjh5ZWNCODk4Q2UyS2w0YnBMYU9xKzhmQ00v?=
 =?utf-8?B?NFRiSEM0T091RHBpekFnTTd3SWpyRDkyam51dXR0a3E5cjJ4cmlHTHdiQ29U?=
 =?utf-8?B?SUZ6L3J5d2x4TlJWcEpBQUtGTEZyYXA4a3ZBQkYwQUNGbHhwSmc0dCtYdUhl?=
 =?utf-8?Q?0lB0MrspUszIh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFVOTnFkTloyRDFCSGhzMlR6blV4TU9nZzhuMlFnUitYMjhsZVQ0aG5odW5I?=
 =?utf-8?B?Q0xOR0xTSnJEYnZNRHRETDhUdmc5TVRGMVdXQlgybFN2M1BZUnhOVXhMakhU?=
 =?utf-8?B?VjhGaEJqanJyM0JqMTJ6NzJHUlMzR2U4SnBCK2kyd2tMR1lUa0ovVk1pMU9y?=
 =?utf-8?B?cDlOOUliSi96dVFYSjhodkp2ZmViY0lFMzBUZjVHSFFWL3BTbSswODM2ODEr?=
 =?utf-8?B?MGh3Mmd6YXAvOXdta0d3YlFHQzJnZThxUERsSHlBZFExVW5HcUZGY1F6elB1?=
 =?utf-8?B?T25kQmxFa3JBSHVJOXJCNlVMcjY5dUpTUmNrQjk1cmI1bmtQNUd4S3JRNjM0?=
 =?utf-8?B?U1U0R2l3Z0pTdXRtUjdSYmhORzF2OWlqNitZQWpJZXB1VGswSlBReXNkUE1z?=
 =?utf-8?B?RWlWMmdwLzlMNkhiRVBxS05xRHFvekRBdFRucWRjb3RjUmx0VWZWU2JWV0xo?=
 =?utf-8?B?ZDBQallROEI3dnB6YUZWajRBM21vbk5DblQ1R1hOOElybHRzWWVUODFBU2Ni?=
 =?utf-8?B?VHdQdzNlRzNsZ0lhMXhGUmZHSzZBT1NUZVB6ajN3dFJnemhZR2l5MEY0Snlt?=
 =?utf-8?B?S2ZXNi9HMmgwQmxTSm5KTnA5L2FuamVHUm9uS3BpTGJEN1NvVDNPS2k3Unk0?=
 =?utf-8?B?dkhTNC8wV1puTUdsU1ovWUpZOGNyQ0JUSWk3TFd3dXhaYm1Xb0hac2hrZzMv?=
 =?utf-8?B?VTRmaTNDMklLcGF3SFg5WWZudGZnUG9jbGRzV2s4cVZMM01JNmRiU3g1YnBD?=
 =?utf-8?B?bFhkUUM2M05hQXNGMWRPWktUQzNncmlub3Y5VkltSXdWWnFqMXordDhYTklK?=
 =?utf-8?B?UXNROXo5UVV3R2s2cXMrallmeGdybjFUNytxdVU1ZTRPNDQ2R3Brb2tKWXR6?=
 =?utf-8?B?ckVSZ0liMnhMZnJGdG1UTkMwYS9WQzExZ2wzUG1kdDBOdnd4RWRlcW9UTWFV?=
 =?utf-8?B?eXUzcWE4MHE2UUl1c1Q4WFZLU2VqZ21CWVFMSFJxaVREQzBDS0ZrM1Y1N2lp?=
 =?utf-8?B?dUZ2LytwUGZya01OQ1NEY1JvT0VzR3dRbHBqUkJ3MU10VHJ6am1ZZTRjNWQ3?=
 =?utf-8?B?d1hRenJ4emg1bWtxQ1ZGMzhaSnhoZUNGV08zNVNvMm41aTA2Q2trQWlIcjBG?=
 =?utf-8?B?eExZcDZIOHhsWE9UMjRqeHd4Mm5nbzFHQ2pyTzE1QmVibWREMHhkelJCcHZV?=
 =?utf-8?B?ODEwRjdjN0dMMmpSVlU5Q2JmcGljcC9ZbmFUb1RSOWxyTWpwOTIzVXA3TkNX?=
 =?utf-8?B?aW5iSGVsdzFkdEFXT205SHgxMDM2bFBrYnNOUlA4RWZNV0dRU1Q5cWsvV25O?=
 =?utf-8?B?TzdtUkZHUTVCVjg3cHprbmlvT1o5QmJrcWVmMEs5WUJkUGF5aGZCbERwYThy?=
 =?utf-8?B?T1Iya2dvRlNrblhwQTg2ZHVad1JoN1o3RHU5RkJhZ3hYYWFjZzBUd2p2TXFj?=
 =?utf-8?B?MVN6dlpUcFJGSjhqYVhDNmpoRHVaamhNK1MyU3RmRU5GT0FLaWN0UnljeCtK?=
 =?utf-8?B?TWpDN0xZeTl1QVd4aUw5Q2JFY08rWGppZHpBVDhOMklTb2tsWVZPbDZSOW9I?=
 =?utf-8?B?RVZmU21sSDI2ZFg1OC94aSsyWVc5L01Na3pySHpucGVzWmlvcFdrdkk5WVNk?=
 =?utf-8?B?VE1GY25pUnhWWlJybXVYY1FwVjEvc1pZb3RXekdIU2hiYXVaK1U1MU9JWERh?=
 =?utf-8?B?S3E0MDJEdTAwOFRzanJoRnNmVEhxSGJ4M3ZhUWU0VnhlV0Iwc3pBampSdEUw?=
 =?utf-8?B?TzVaSnJQbTBPSHFyZDVZUWxVOGNMQ25FVExHbnhxekxRTnpkNkRTZGFsQVIz?=
 =?utf-8?B?dkI5VFFBejQyOXRBRHdIdExCdlNlc21EQ2F4M05SWklITkxlWXJSTUp1akl2?=
 =?utf-8?B?N09mekV3dms2Y2VsdFc3MjNJQVVMU3Q5SXYvRlM4MjdmUzJsdmszUTBtT0xr?=
 =?utf-8?B?Um9xcHBmeTdaSkVqQ2lyaEhBUGdvUktIeXBUWTNPY1VDTFVkcDBNTnpGWDh1?=
 =?utf-8?B?b2tjWURkU201ZUdHNVdmaEUvTFlYQ2FqNllPUXFDaHBZOGJrbm94OTFHRnJj?=
 =?utf-8?B?d1BxcFBpb3JaNkhwRHA0aUpKT3psR1JtRUlOK3JkMTJpcklPeDN3QmY0M3RW?=
 =?utf-8?B?M0ViTzMyMWJTeWpnOWpaV1JpRnFRUFNzVmFIZENlZ2FBb2JZLytTRDZMbVBL?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 441fa163-0ee0-40b7-6825-08dd517545ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:10:27.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfV2s9zRHZ6zmdcHEPhF5Ajj3M6YXeeS5Orz9kG7FuFTQsrKSMji84bR/SRWFOfMce0Ut7QZ8iTPQrb6wIPgcQhaeYYkmHS6KA+IXiQObow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> To support more than one architecture resctrl needs to move from arch/x86
> to live under fs. Moving all the code breaks any series on the mailing
> list, so needs scheduling carefully.
> 
> Maintaining the patch that moves all this code has proved labour intensive.
> It's also near-impossible to review that no inadvertent changes have
> crept in.
> 
> To solve these problems, temporarily add a hacky python program that
> lists all the functions that should move, and those that should stay.
> 
> No attempt to parse C code is made, this thing tries to name 'blocks'
> based on hueristics about the kernel coding style. It's fragile, but

(heuristics)

> good enough for its single use here.
> 
> This only exists to show I have nothing up my sleeve.
> I don't suggested this gets merged.
> 
> The patch this script generaets has the following corner cases:
(generates)

> * The original files are regenerated, which will add newlines that are
>   not present in the original file.
> * An trace-point header file the only contains boiler-plate is created
>   in the arch and filesystem code. The parser doesn't know how to remove
>   the includes for these - but its easy to 'keep' the file contents on
>   the correct side. A follow-up patch will remove these files and their
>   includes.

Related to the tracepoints I also noticed that there are some leftover
tracing defines in files that no longer make use of tracing.
For example, arch/x86/kernel/cpu/resctrl/monitor.c contains:
#define CREATE_TRACE_POINTS
#include monitor_trace.h

and fs/resctrl/pseudo_lock.c contains:
#define CREATE_TRACE_POINTS
#include "pseudo_lock_trace.h"

I assumed this will also be removed in this follow-up patch?

> * asm/cpu_device_id.h and a relative path for 'X86_CONFIG()' are kept
>   in the filesystem code to ensure x86 builds. A follow-up patch will
>   remove these.
> * This script doesn't know how to move the documentation, and update the
>   links in comments. A follow-up patch does this.

One unexpected thing I noticed is that fs/resctr/internal.h contains:
#ifndef _ASM_X86_RESCTRL_INTERNAL_H
#define _ASM_X86_RESCTRL_INTERNAL_H
...
#endif /* _ASM_X86_RESCTRL_INTERNAL_H */

Reinette

