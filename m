Return-Path: <linux-kernel+bounces-372000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263319A431F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F207B224AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CCB201101;
	Fri, 18 Oct 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG5NSNQG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23FE13BADF;
	Fri, 18 Oct 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267271; cv=fail; b=qKydP/y+iYunJyVWqjjTEk2yJuieePGViuacI/4eqtKtSdIzJ7yeLa/EFRoTxURVd3HBt3pSyN1usaUctwl0Traf2gxLFeK63Vn8aYMYb1Xs8pDpvT3YyYGVgYSJsF6OE6llUK6uOqXOLgTDBr01V2+TXrJRJfMV9pVI03mYggo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267271; c=relaxed/simple;
	bh=OWwIq9nQPttfAxgJSExzRa7aFKEI6kG6lgLVZB+7Xxg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDjC0Gz82dLVMtzdMYndAtKf2j1/V76Tx/X2buoEb+Vw02ADzVLI3YK1KhkMf83WyHNYadoVm7GTTd7VfoeZURiHHbOZpPtv2bflfC6ZfWzGsvlHgDhe7CHrkttOfB9mel0rJ8qs3dCNWCDzcZExvFe1SeyH+R0Ob+Yr1VccWDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OG5NSNQG; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729267269; x=1760803269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OWwIq9nQPttfAxgJSExzRa7aFKEI6kG6lgLVZB+7Xxg=;
  b=OG5NSNQGUiBtC2Fo/Lj+yBBpFARLnezIdoMnH/xbOmV9dzJXhe7tPvvb
   MrQy72Kp2rC9CvSG2UStumKlueFwEy8gawpQX6SOYNOetHBCkM8+SwYcY
   z1s6NPWo41Ppqz+fsTywjvocUl4cE7cFRyRnXC7ltHe8IAqnn+B+lZvzk
   mp6XmSEJxKBbDTn8IingZe+IPlXLoCeZKWeudQ/47vteO4+0WMh91QDBH
   CaPaek4pz1bhHNpIz2jk4HDPfOHeHjlp3Fipk3IVr4lUVXbUQjBCrMPuX
   9NFtESadH89EUEPa7JgH4rk5qtcP5nP6l9HHmTIfG72WP6jBArJq8LBnf
   A==;
X-CSE-ConnectionGUID: oI7I1DRDQMS29N+TEHCnow==
X-CSE-MsgGUID: wi7uEziySQencTqKWSSASQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39349767"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39349767"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 08:59:48 -0700
X-CSE-ConnectionGUID: oWXP6xVKS2Kldx5jOtL5Ew==
X-CSE-MsgGUID: Uwslg8bdRs2OKORGKdeY7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="109729054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 08:59:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 08:59:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 08:59:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 08:59:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 08:59:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPNwG3Zkje37JX3QxZ6/rmdDgPyECSK0loAYm3lMPCEo1vMAaqDwWyYUaiT7P253lI2UgGGQVrL5VCOUDWoQE2e5rXCEI2UKYX4SKndq9lHnO4V2Id1hM5Zte39TyZJ7Cz4C/+wv4r500XtEfQ3BvF2ZhgvCOUMvxf7uT4RCIhvJaeRW9z7iW9BPfaN+QpkZzdnOuSthCL8UWyOQRP+cmTR2ivBHpKazoX8v7L3QelY+TajXwL61fwMukTnv+OYyPC6pIXUOLheIMTfiLwZl+MfWoFD/vP2nfVmDQ8PoGgCyUep1JzYemLlK9Gzi8H078+vAiMjAFwi7iNcqVtUftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHk2VDIiBUiELipdoeyQ4J0j00aKC8P1V8x/+iPi6cY=;
 b=XP3BVUzXk2Vlogk1oNnNULpSlyYmYBnl5SYBuwXXf7tqytMl39xjm522TtOYTokQO7H8/i6fTRlkAHN/Tewys0w+wpB9k5js/6IR6a3TBum8XTOibNCjWQ9YLXa7TYGPkuXGlveJAmXQNwrRe8+zsBAKPxBhQoNboUmxOk7ka5XQBFrWikGpu7EtkBwTRDKbNUZH1jaFFb/VN1D6iBIudLoeWUXbxLBDm+8ltrjBdtG7wcg1o/2A/BtU8y9kwkM8XRqnmZNJq4Ry7reLH+HUEyDevIbKV/vlPDIz+VCvGhPm/RvLPe5dAzRZ8fZDwQtt2XGVgaTVxpimZ6AysySe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8399.namprd11.prod.outlook.com (2603:10b6:208:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 18 Oct
 2024 15:59:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 15:59:34 +0000
Message-ID: <c36e0c76-1666-4a31-984e-1ee6aed2e414@intel.com>
Date: Fri, 18 Oct 2024 08:59:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/25] x86/resctrl: Add the interface to assign/update
 counter assignment
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
 <367f3877-e23c-4115-a004-1480ad2ab17f@intel.com>
 <78674f8c-963c-c6bb-ce8f-470d068299ca@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <78674f8c-963c-c6bb-ce8f-470d068299ca@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:303:8c::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8399:EE_
X-MS-Office365-Filtering-Correlation-Id: d15fc442-069c-453e-5b96-08dcef8ddc23
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXZjcXRMY1ZFUFdGbDdtN1lWTUdFQjhwUGVSUHE0OHFWQWdOYnE1WHpJcnRB?=
 =?utf-8?B?NWM1Y2R2L1J4TVBCbUFnUCtLQndka3Z6M0ZjMEZUMXp3Ym9rZ0FOV05sVlE4?=
 =?utf-8?B?Y0FiQmRRdno1aU93WXEvNHk1aFU3L3MxVTFOYVovSzUvMkxSb0o1ck1QcHRk?=
 =?utf-8?B?a3M3eFF4dkRBVWJGbWxocFVNTDhnYjJIaklWWmpmWERpa2RXOFpVc1FGeUQy?=
 =?utf-8?B?WkE1bWJtdkV4Sm5YSTRtK3dXRld0dUlma1U2dXZlamRldzNNYUJmaFlPbHFy?=
 =?utf-8?B?ejVOanc1Z0NYMlI5QXMrWS9MREYrR3EwaHdvTERHZmRCSjFNTEJwaHp4aSs5?=
 =?utf-8?B?ZFRpRElqY21aZkwxQWZoZE1sRHlEVU9qTnl0cnM2Ny9TVnNzY2RJVFY4Wmhv?=
 =?utf-8?B?Q3U4aVlHejBUeHViVGYwYjJXVTBweHN3NU1PeVpUdXplS1QrUm9LZmExRm1u?=
 =?utf-8?B?ZjlIVGwxc2JvekFNMXh3MzhOSGRTMFdzSiszbVpxL1RETDJOUWk0VEc3MHEv?=
 =?utf-8?B?ZGhwY2xzcGJjT3QxSUR3dXVnVjYxalJFMzAvaXlPTThaalVUalVZVmJnNm9B?=
 =?utf-8?B?RlFNLzVJcUlDR1JmMDFGWWxJNzNmdVpBaE04SmttNVJacGxBRjM4UERtUW5u?=
 =?utf-8?B?V0xtTWs4V3dPQ09YeU41VGlQamRRVXFqT1dQK2hXTkQxL0hSV09saEZ4dWdn?=
 =?utf-8?B?cWlwb0ptcGZBY0cvVlo1WDVtbkw0MGJxTlVsVkdIQmlFbUpVQ0VzMnFBSGdG?=
 =?utf-8?B?cHcweUs3OC8xUXFUeER6UlhJcnJ1amZZL0R5Yy9kZHBudm9EZ3I5T2Vsbjl3?=
 =?utf-8?B?bWk3N3ZOSC9SeW4xRW5xZVluMFNoT2ppWENmN016L1ZUNkZDRlhUQkZNWHRs?=
 =?utf-8?B?d3JqU09KTEhxd05wMzJYSERmTGhPOU16aEZiM01tbTNCb1pNRjZnNWkyZDdS?=
 =?utf-8?B?MXU1S0lLWE41bmpFV3prZ3llYkFxaGErVlpUWUJmMUU4NEZESXArUmQ0dllt?=
 =?utf-8?B?RGhyUVcvaWRlQ0ZSR3ZCU3BLUVB4TUNDVHd4TXkwU0h1eVo4dHVaUGFvU0F3?=
 =?utf-8?B?czUxR0pFM0pxVHRrV1dKMkRHa2FNaVRBRjFmNUhKYitJR283ZXdGa0VMOVhz?=
 =?utf-8?B?U1VQRUpsSFEraXYyREVvakZjcnhRcnZTMENKQXpoVTZwQmVqOWZ4WFZ2MldM?=
 =?utf-8?B?Zk1KUVpCUFZLVkEwenJ2OThUT3EvV2g4RVJBTFJFMnAydituMTQ0NWxjRWFy?=
 =?utf-8?B?T1FGTDdnUi8zYW1YMXZqWCtCdUJLMHJHN0hmaWQ1endxaUtFM00wUmZub1hk?=
 =?utf-8?B?YlM3OWx0Y1ZsTllBRGRuS0xHL2JZUEdpUmRpaENHSDU4dkdVWUVSbTkxVm5z?=
 =?utf-8?B?TlJpYVJNSXp6dU1IcDlDMEQ1M21Ydm5VMXZYakZPT1IyU0EyTk41dEdiczIr?=
 =?utf-8?B?dzM1UnhlVWZsMFBvdUM1NERKWnhGR0g5V0dhcEtvZHJKbzdJeVkxL3V5YWZ3?=
 =?utf-8?B?UG50azhQV2NQTnBub3J5WXZxa2h2TzVHK0ZLUm04dWhpelZ5T21Bd04rd2pl?=
 =?utf-8?B?TU02ckV5OWg3RVFSTEpYVE5hejZ0NlpYUlZ2V2RNM3M4Yi9ialFjZktsMXhL?=
 =?utf-8?B?NW5CLzBpY0VuMEpGZTV5SWRhNTNlNFQvdlUzcDZkdEtkODJsajlGd3NLaWRX?=
 =?utf-8?B?U3RKemNCSUFXS0VrOVl5YkZla291eDkxUjE3UzdjbXBIT05pbnFZQ0J2VkNn?=
 =?utf-8?Q?y9O5YUiDd3PgVNcWY0TRYo+9eC4PCGm/MRjbFcE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFEMjFXNzl0WGE5cFdsbXdhV1RjUHNia1ZMUlBKL2dxcVo5dTIrMEtVajZH?=
 =?utf-8?B?S2IxRXJ2SGlpSWZ5ZUZxK0pSQW9KejlKbzZRcE1MYU9UOHZ6U2EyNDhib2VI?=
 =?utf-8?B?RzV1eTI2TXpuaStLYWxUekVLZ2MxMFhvZW1Uc3JidG1MWUx6aEJyYTJmY0lJ?=
 =?utf-8?B?VHVaQ3hYSitnaHpkY1dLdUdXTlZueDlZdlhxKzRIUkN5WlE0Ui9Jd3JaTnN2?=
 =?utf-8?B?emJnNE8vdVQ1K0JqRHorTWZ3eXh4MDRMdUVBZjdIc1BzV2hzb0t4ekVwbWdB?=
 =?utf-8?B?NXF0M2FOMS9BYk9mYzYwdkxIV1JxczJTQnNDWmt5VDAxQVJxcmJ3dldYSWRG?=
 =?utf-8?B?YndBUm81ekNqT0pFZWNwdmx0eTczNGV5eThUcE5nZlR6NkNYa0ZsNzMza1Q0?=
 =?utf-8?B?RkNiRHRTWkR2MUp6cCs2cGQ1eEhqQTF0d3ZzdWZsbU93eEtaNUJmOGpZaHQ1?=
 =?utf-8?B?UWRKa2hPMGsvS3B3YXlhVmJGV1B0Vk1PcFdXenowWWdjc1JhMzNuTnhKUXox?=
 =?utf-8?B?RjlRSnVZam8vL2UrWlB1MTFVMHdiVFZmYm1NUjZHQlpKZlRUeTFYZnFrYXpo?=
 =?utf-8?B?dlZZVzEyUGxFTjNZNzRGY292eEJ0a3dlR0tMcUJwdk8xNks5MVViWXI4bUFE?=
 =?utf-8?B?QXBsSHUxWndndmloVFEyZFgreFNORDc4d3NJWWI0OGpKL3ZDRzI2WnlUV3Rr?=
 =?utf-8?B?TTdTM1IxNEp2WUF2aHBERHBOdWFFWUM4WXdGck9xRHRqMXQvejc2cXN3NU9Q?=
 =?utf-8?B?cnd3UkkzWUo0V0F5ZzVDQWtNTFdZcFdDeDNkNitoTFlzWmJxRFdZY2VVSWND?=
 =?utf-8?B?OVE4ZVh5dkRGWkR3ajhvWjJuVCtYQWxlNEN5Q3hodEVzQ0NyWXUreE4zWFFO?=
 =?utf-8?B?cHU0ZU9rVE1PZ2hmNnB3T0tyWmM1TGM3ZitsWW9NTFdmSWtYOHpIZzZSVE5S?=
 =?utf-8?B?dk9LMHEzTm4yRHBiWEdQeUEyUTFsdmdUM2tQQ1FuaGJpdlhTMU5uZHRTbEk2?=
 =?utf-8?B?UlpLTG0vdEhyZzRxc01CMU1OdzVrMzVTRW1NaFNYMkkxRnFHZDIycm5DYmtM?=
 =?utf-8?B?YUpaVS9VenlQQjNQR0szaU5PeGNDaXk3WXBHTFMrVUZRRWRlRWlaRXpxdlNl?=
 =?utf-8?B?VXRvN3RhVXJBUVEzS1R5a1lTZVZycWJEVG9jSjY1d0ZBOXJQelIwbW5aQjNX?=
 =?utf-8?B?QjU0YTZWZjdzODRHRXF5NFgvTXY1alNoOS9yTFJDRjArM2I0eGJQNzRhMVNP?=
 =?utf-8?B?WHlHMkNyaGJqQ2Nsb2ZlS0IwTHBwVDB4WUJZcW0wajJuaWhETE1GbWsrS1Ix?=
 =?utf-8?B?VWxma0FmMnBmUzF1cTh6SmVZelB3SGNwY1FvU3prLzdTemN5WExKcnNpRVp6?=
 =?utf-8?B?Q0xhU0JBQ1htWkJNMDBxSml6elFGU053YkFRbGx2ejBFeElyb1VMMG10MlY5?=
 =?utf-8?B?V3NIY0lreGJsZUlsTlNnQmQ2ODJ1OFE3TGR6RHpmcnd6S0ZmTnoyVSt4b2Mr?=
 =?utf-8?B?aE1Hbm8xTXRkQ3NYSzUxa0lmUkNVR2ZoaUhOaDc2QWlRSTJacEE4dVlrbVRr?=
 =?utf-8?B?Qjk0UmRUZGJIUC9iSnRrQTZPMG84VkZRWGg5UUtHbmNLeUhmS3QraFhRUHhB?=
 =?utf-8?B?dXVzRHdIb0swM0cvWHFCT2hURkc0NXNJc1JsdUgwZDY3N25iWS9Od3B0VTZu?=
 =?utf-8?B?clUzN3IyWHN1elNtMVhoUTUrYWI3enkzOXJSQTBQdVJtRzU3dmxFOXZqRXor?=
 =?utf-8?B?bjRWci9nbHQ4NnJTVnNReW5DcWZJaFRRU3dkUUpQSHY5LzRSaUNKNWdjNjk0?=
 =?utf-8?B?NDBDQkdqalk2dWRrV2NZT2RvcG9QWWZMOFBqaGpHNUhKQlR1KzlLWkhXd2N0?=
 =?utf-8?B?bkJoNkpBMUxENVF2eDM1RmQxcGpZQmpxbVlrTG84L3VGYWNJeEZkYnhvK1B4?=
 =?utf-8?B?Unp1dk5jam9TT2prTEdRMWYxdVpCUEdkNmVvelI3Q2w5REVSU1NFMFVUeXZi?=
 =?utf-8?B?UWR2QlBnNHQrOWpHb0JoRGpxMmN0aXBCOWlHVk4yeXRFZ0psWXFNLytJWWNO?=
 =?utf-8?B?SitzalUza1dGUnEwNTBCS0JJVzMwZnVlcWhHb0tuZG00d0V3aUc2MEJYYlZY?=
 =?utf-8?B?UnRsMzE3L3JjZ2VLbWVXMTBFK09VSFREQlk2eTdUN0Fsc0pyaW8yQnYxV3Qv?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d15fc442-069c-453e-5b96-08dcef8ddc23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:59:34.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9QfUmgHpSzhLEj8FcB+czKQ+B8u5qiyuPfTPN6UcioHzKRdxmNlngtCsEFDNbnR+Qrol2AkbidZpJLGM7icu7XkRth4wPjXjYqd4XW2BIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8399
X-OriginatorOrg: intel.com

Hi Babu,

On 10/17/24 3:56 PM, Moger, Babu wrote:
> On 10/15/2024 10:25 PM, Reinette Chatre wrote:
>> On 10/9/24 10:39 AM, Babu Moger wrote:

>>> + */
>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>> +                   struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>>> +{
>>> +    int index = MBM_EVENT_ARRAY_INDEX(evtid);
>>> +    int cntr_id = rdtgrp->mon.cntr_id[index];
>>> +    int ret;
>>> +
>>> +    /*
>>> +     * Allocate a new counter id to the event if the counter is not
>>> +     * assigned already.
>>> +     */
>>> +    if (cntr_id == MON_CNTR_UNSET) {
>>> +        cntr_id = mbm_cntr_alloc(r);
>>> +        if (cntr_id < 0) {
>>> +            rdt_last_cmd_puts("Out of MBM assignable counters\n");
>>> +            return -ENOSPC;
>>> +        }
>>> +        rdtgrp->mon.cntr_id[index] = cntr_id;
>>> +    }
>>> +
>>> +    if (!d) {
>>> +        list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>> +            ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>>> +                               rdtgrp->closid, cntr_id, true);
>>> +            if (ret)
>>> +                goto out_done_assign;
>>> +
>>> +            set_bit(cntr_id, d->mbm_cntr_map);
>>
>> The code pattern above is repeated four times in this work, twice in
>> rdtgroup_assign_cntr_event() and twice in rdtgroup_unassign_cntr_event(). This
>> duplication should be avoided. It can be done in a function that also resets
>> the architectural state.
> 
> Are you suggesting to combine rdtgroup_assign_cntr_event() and rdtgroup_unassign_cntr_event()?

No. My comment was about the following pattern that is repeated four times:
	...
	ret = resctrl_arch_config_cntr(...)
	if (ret)
		...
	set_bit()/clear_bit()
	...

> It can be done. We need a flag to tell if it is a assign or unassign.

There is already a flag that is used by resctrl_arch_config_cntr(), the same parameters
as resctrl_arch_config_cntr() can be used for a wrapper that just calls
resctrl_arch_config_cntr() directly and uses that same flag to
select between set_bit() and clear_bit(). This wrapper can then also include
the reset of architectural state.

Also, I do not think we need atomic bitops here so these can be __set_bit()
and __clear_bit() that also matches how bits of mbm_cntr_free_map are managed
earlier in series.

Reinette


