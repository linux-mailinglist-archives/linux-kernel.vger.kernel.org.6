Return-Path: <linux-kernel+bounces-557213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C58A5D526
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBCB3A4397
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101411D618C;
	Wed, 12 Mar 2025 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaONH18+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431873D3B8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741754886; cv=fail; b=dmIQjigyl9kijyHqlXf77HAHvtQKHBZN4nIsDpsp3l2yzAwS9J5as5aSl0Dr2D6Jv93fb/9xSaftxM1BWVGmZ/m/Ev3IQp9c7TNIdgFx2DUl2G0XexRgXKP3cUNb2cK94w8REel3SXxkspn5mgYJPN9BjASCGo9yyy4ppCHqfd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741754886; c=relaxed/simple;
	bh=i/mcFRZuwjjHOjEg0ZOK/JjF1CWHZFvqK9Dzcf4wpG0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nStVIbyIfCZWqejo/Ue1hNXn8dgVnc2m6xl/hd1qEQUBrRRNl3cdOb9f8GqLOc9kxR0GB7BoVqOJmcltUxrLghkZXpwQaiNj9BMJyC2F/ir8j1R7vjirWtaQLLpIdw2qhqbK0Vgwn43G0jPf5/qP+aek9FbXFSw4+Peg4kwvQL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaONH18+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741754884; x=1773290884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i/mcFRZuwjjHOjEg0ZOK/JjF1CWHZFvqK9Dzcf4wpG0=;
  b=PaONH18+1BUxV18kIu5FpgRNz6LWRy2k3MWMjlaruQjmsj0uq89k/KaX
   MGh3Od/xQeQvS+Dzbl/L+ndzW2QIvh9wy7cx/ztsWu8YCCpwyGHEMCI/C
   oLXiPK70iD6pKrjzSPKwOT69nSa+CxMsQ0EiXdZRhd3UqqbdVEfYk3bd5
   HyBCWMGiAjhlBlPy/Km/6T5JLzverwNNygoRuxVU2jaAPY1mFHZqvHpEu
   wZQzks8FsgV0GWLPFwswVlCYzNe51/TRU5C5Bt073G/w9bEoZiBrKph4M
   clzJkEoVIZLqSTSbaAoc+or8lEtuZ9ONDpGFF69BK2fUo3O6WnKmnC2uD
   w==;
X-CSE-ConnectionGUID: lj/hldpsReao3AbrOrupWw==
X-CSE-MsgGUID: pb3M/foVQV22CaL4cQ++8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42927880"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42927880"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 21:48:04 -0700
X-CSE-ConnectionGUID: UZrjafv7SXmvK/1lsxo44g==
X-CSE-MsgGUID: W5RUvbmdQsmCJ7r5JNMhFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="121010177"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2025 21:48:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 21:48:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 21:48:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 21:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+tCpPfsCPnipRNcoa16mKgvSf3M0rE2DUy3KUwpgvPTSl10BfLdiIQTzAu47Ug3CM5FwApNSh1jkZfHt4WDIyxB58LiOSW4gkTtLY2XaIX+F/GZsM0S8QWX9FMafAkULfxsWT1Lk5czXkZ2LjUMBsJhD7SgC4E5T1Nd94lFniV60KO25sbMvZBXhj0Eglo7GvyPhZX4X5GseY6cH2NRjsuFv4avUKHjvc3jtJIZ6XOrV/nmG1XFolYhWwHydPpza9oLxJrB453QzJme70ixv96hJmOf6vz4nkOfhBNS65ExScYDNkB7/Ml7pgQZVZLAzIns29ahigBd+Yl+nO50PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu3XGKdXr2fPBDJ4+X6DtxJwmLOh6LZVk7iHi3stM+A=;
 b=gBeGwveECFVI4MWXhztkTUMZXT2SmoNIw9oaAg6lTxi4f9RPgZEOGbVEW6YNqpdWIFhOaPzzVa5ubU7s74O9n0EslpZh2eLTho+QZ6dARNs8umJf9VGcWqgcs2gXCBfb0noEU95R76sz4ZGKWIfstH7eWUXqaSFS7cnWsunlVR/t1SVzIwZb/fVW0ZMOBW9J8iSDyks6AQOBq9KLsZeIrAkTeQm+/TiTXKaBu9aWF/Xtuv1P+0F5BIWX+oF8+zr8RH3D7Hr9Y0UtlY+S8ddLr6uiYSnsa70HTWHEydVX3ZkhtT0YQn4DcAYgt0RuSgIyt2eRaz4wRo7cvBn5FnRX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 12 Mar
 2025 04:47:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:47:41 +0000
Message-ID: <dd428220-ac94-4410-a90e-18c69cbea619@intel.com>
Date: Tue, 11 Mar 2025 21:47:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8:for-boris 22/30] x86/resctrl: Move mbm_cfg_mask to
 struct rdt_resource
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250311183715.16445-1-james.morse@arm.com>
 <20250311183715.16445-23-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250311183715.16445-23-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0312.namprd04.prod.outlook.com
 (2603:10b6:303:82::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 094b819d-2f7a-439e-8623-08dd61210592
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUMyWmlUUTlPQkY0dEw5Y2k2WCtFUjFjc2RGVmVQNzNQSjFDdU8yR2w0amp0?=
 =?utf-8?B?QlhIQVJvRWdYeDhMalpmdG1pQnRnMlNYK3RDMlVhV0N0WExqZEdKbEUxYWN3?=
 =?utf-8?B?T21wZmc5RzYwbmZUZ0V6b21JQzN0NlJqbldZUE5lSVQ2a3RIOFNJN1lxMGpm?=
 =?utf-8?B?anY4Z3lhV2N6V1o1dEhaRUowUGJKcEhUbnM1UWtrcXpja2o5WXR2ajhiS2Rl?=
 =?utf-8?B?WnBCR3VaZmZ1VGZOZ0ZoRHc3a2g2MmVmZUt6VVBMK1hCSW00Qkw5WHI0ZjFv?=
 =?utf-8?B?aE9FSEJkdVFPTzlubS9UOGFiQzBZWUw4S3gzcGVncGZxWnE5cEV0cDdFVXhH?=
 =?utf-8?B?ZDRKa3JTbStXNnMyWmRsSzNmekFZK2JsUk1XeE5uVXJkc1BubnUrNUJPdW9u?=
 =?utf-8?B?eC9mZXFUTzBSTVAvcU9CcW5rSnpqUXZSMUJJcFRVcHlXekc2cEh1cjhxVWcz?=
 =?utf-8?B?bUx0VW5RNWJ4RDg4eC9Nc3NiVkw0V3RBNUNQZEVlSGpOUE9hOUJhVjNaOUsz?=
 =?utf-8?B?V3hYVkpQVEpHNnAxTlh0dGJia01iaGRmZEhFSUE3ZFVzakkvVWFIc2swY3ls?=
 =?utf-8?B?OVZtdTlIaXpmaGk4ZVFUUS9HSmdKdlhmc1hCdk5kZjVoYmJMT2hBQTlheHEx?=
 =?utf-8?B?aEhMdkZDQ29CQkYreEMyTzdZQzZTak0yaGl5WGx2Zm85eGtENllyaHBsb3dm?=
 =?utf-8?B?UVJWWnFlbTZ1NWxERWk1ekhoRnh0YmFVdGh1MkNOL1RHNW4xVUdUd3V4RGgr?=
 =?utf-8?B?T2xTa2dDUkx6RVRJWXQ5cWVrNXBjT1R2QS9maWFjTEp5S2xtR2k1dFN6Y2Za?=
 =?utf-8?B?V1VkaFkyZmtlVGVRVWZPbHRZdE95SVYwSW85V0dnZURpYWxJc1hBZWFNQXZ4?=
 =?utf-8?B?UktNSTFCRFN2UkNJRGFkeG83MXdkZWFMOVZSNkZDUFN5aHJhU08wWG45d0V0?=
 =?utf-8?B?UzExTnJrZ2pMRGNRcWVJZEFJcUxWUTJUR0V6TXI4aGhKd1VOdWU1N0psdENE?=
 =?utf-8?B?ZzlDNEJoZFRncG8yakdQWDNkRWN2ZlhVbFM4cnkyckE5eEtibm1GbjlZbm9H?=
 =?utf-8?B?aFp6a1ZONXpHM01UNTZhZVBwMGt2U1JyR3diRUdWOGhkd25CWjllQU11QmFv?=
 =?utf-8?B?Y0RxbWFaQUJkVWMzeE81aUc2RHFBSWoyR3JtQVl1S09TN0JscEIwNjU0Ynk0?=
 =?utf-8?B?aDZ4YUJjT1hQTWovYjVmQXlYVm9mY1ZLNVZpK3UvMFp3TnBjMjZxa0tVWTc4?=
 =?utf-8?B?cXN2OHpFUDkxVVgwMm80dmNSUVlEYmNWKzNYYkJSaEpacDFWN2Z6dC92QjRx?=
 =?utf-8?B?MHZjWnYvSmdHdzNCVzY1bmw3blVMRHluT3JiQmQvZk9PMnZKWVozZ3phV3A0?=
 =?utf-8?B?bXM4RjREMjhxeEZSRGEwOTJPV216dFVUZ2x2MWx3QWM4anhLUzZ1ZWkrYW5G?=
 =?utf-8?B?bzN2T3h2c3pJYU10TENZOHByOU9NZFMrUlllaU42a0ptaUNVU0UwUXFtQXRP?=
 =?utf-8?B?em5NM1RQaDlCNm95U0VvcEVFNm9BdUh5VFVYVXY2VG1DRU05R1Z2RWQ2NW9j?=
 =?utf-8?B?TTh2b2ZiVENsRnhMQ3pJd0pBVmRSNHU3ZWNaNngwMmJKaWNpRmZlVzdLMjR6?=
 =?utf-8?B?bEdjbndXMS9yRGZUSmtpdWs4UTJKQW1ZMDhKQUNSaXFaTGF5SEZiOTRCVGVa?=
 =?utf-8?B?MEN3c2E4eC95Z01ISGtENTJWOEoxMnFMTzBWVGtpNDlCcXhabXozYmJ0amI3?=
 =?utf-8?B?ZkNUdURZbDdOZ3J3dkhTTTMwbW5QbGZNeGpjeG9iM1VTc2JrQ21nNkZwdmtx?=
 =?utf-8?B?YXp1V1JWK3puL2hRU2JDMlg4R1lCN0ZLdnVDai9XZ1RBcFdhZmFuYTd3S2Iv?=
 =?utf-8?Q?YtBHxW3Yz46ik?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0VxdUpUTDg1SWdLK0I1SURUOGxtY1JpM0JBUEFlMjlHL04xdGR0Z0l1TmF6?=
 =?utf-8?B?MGlZUVNoZ3VWeGpjUmRoMjNSREptb0lwM2x3YTVDcXJZdVJycGNFN09jQ0ll?=
 =?utf-8?B?N0xJQjhsVDJ5c0dlNjVnSnR6R3d0WXlOTzg1S0paU1JMc1BzTWpaZ0Z1ZkdB?=
 =?utf-8?B?T1pOeUpaWEsxa25NMDRLOU51SE50M1Z1alpmZVo3SkF4SzV6cVpXemMreXB4?=
 =?utf-8?B?WFpFeWcxb0UrVWVvdDlzQ0N2WmR1MU8zaHBuM0ZBcHEyWUlQdlN5a2NiL2p6?=
 =?utf-8?B?cTYzeEJPc1lWdXh4dWRseUZrQkIxaWlaa2N6WUZQM3pYeTA3ZW5HM2N0TFUy?=
 =?utf-8?B?UC9tUGhET1Z0a3E0K25mblREWGRpR2VGa1RPNWFIMlQvRExLVXpidkJJejQy?=
 =?utf-8?B?OTd1aDNJczNnbUZyVnZkcVNxendESUFTK2ErQmJXMDlkME9RUUQvUFM1S0Vl?=
 =?utf-8?B?bWx2bXlybURNSlM2U3hIZHRUQm90ZFVhRGVmRkZBdko4NmFHZkhpM1kvMXZq?=
 =?utf-8?B?U2ZPbS9ZWmptTVEwajZDUy9hVkpHVmxJMjBhdk0xT3pzbkMxTWV5ZE8rYy9W?=
 =?utf-8?B?SlpZQnYySDBpVzZZbGJEVFFtbEdnRFdJNk1SUzNkYVhGdzlPMzZYUFRUdmxs?=
 =?utf-8?B?aHVWZURHajVPcTBKdTFrcytCalBGQmpkcWlSZTREZDg4c3BTZTFpRXdLMmRl?=
 =?utf-8?B?QnVhZ0RJbndUY1Y1ODFkVVBnVzgzL05HcTZNVjBPbVIrejBjNDlLWU9UQ3h0?=
 =?utf-8?B?SHJTSnd0QVlCN3RxTitTT1lvay9iMkNHQzZjZ01EZks3L3krYUhNd0hQUVJh?=
 =?utf-8?B?NFIyTXR3ZUt4aXhiS1o0K1pac2xRRkhIazFIZTJDcUhlTmVXR0Z3REJGYm8r?=
 =?utf-8?B?WjRIOHB2V2dHeW1HUnVTbHZ1MDdNbndUUUVId2Y3Z1lvaC9QNWZVZis2Q3Q1?=
 =?utf-8?B?T1hGcFpXWXN0b2ptRVdmblc0Umc1VTdRdHpWVU4rdStzemI4STVnNElRcmdn?=
 =?utf-8?B?S1BCcVc0R1M4UW9CYTZSSSs3bGRMWVMzeWp4S3lpL3JsQjBlK0RSN2FJT3Bp?=
 =?utf-8?B?WlU3TCtDUm4rSWJuTUE3eWxKZ3BKd09ESlRnYkRYS1ZGQ25kb1NsS1pjdjZ1?=
 =?utf-8?B?QlFiMTcxZS9iWE82S1BxQTk4TWhpcWRSOUNtcnJ1MmdSQVJ3STk0WUZPWXBK?=
 =?utf-8?B?QklNNGJ0aTBqUlMyNVNUc0xOdnJZUWs1VGZHYzNqYzlJRk5YYTNhTlAwT1Mr?=
 =?utf-8?B?bkZyTUdxYnNLY3dUUUxnMi9PRld5SHkvdkRHcXZNbDFadkY2c01raUt6SS9G?=
 =?utf-8?B?aXlaQk1ZUnNXOUo5ZitLZFNybDRrVTd3ckFyUGhIZGtVZjU2T3ZpMkQ4OGV0?=
 =?utf-8?B?OXZSYzdWclE2di85RzVJQWxzUjJla1hkRlBTbUZwOUhKZUNuZVRtanB1ajZ0?=
 =?utf-8?B?ZnlLWFh5eCt4aENQazNzMzV0WWtTM0paTWhlN2RUdWVWSjZrdUZkTXE4REZF?=
 =?utf-8?B?Z25oRDlhQWtQRkhSRVVLeVhtTjhrQ0crbUNNbzZvaWp4MWwyc1NHU2tpcDd5?=
 =?utf-8?B?Wm1sZVZqdHNYcTE3NlEvYTJsL2duQ0Vab0E5bzMxSXVNQ0d0MmRubHVxb05k?=
 =?utf-8?B?eGJEVHJBKzg4TnlmUTFhRHpoTml3WWRPdjFVSVhPNXJQd0xwY2NOSGZOUEg5?=
 =?utf-8?B?d0Z4d005V1RsczV6Uis5M3ZoSlZpNG93Zlp4WWVUeW1uNFQvUU5DbVR5Y0pE?=
 =?utf-8?B?OUM1eVhRb0Z2UXMrM2c3ZHRXS0lUOXRPZXdwOXowTlFYNmRMWWY1bDU2MXRo?=
 =?utf-8?B?Snh2TmVPa2swWmJRWEh4ZTZ4N2xlR1hMOHkyMC8vc29PcTNUNmZVMXRDeGht?=
 =?utf-8?B?M2JtdWZhSFZvM3psZHVGWHpZWFRBUEZLK0ZqL1BxN3VkbnE2dnQzTkxnZ2VF?=
 =?utf-8?B?WGpXZU8wYjV6S0thL0tva3hCRkwwYXYvbnUxS1BEZC9lMzdPTWNLdDRUWTV4?=
 =?utf-8?B?RWtRaXZpeEF2dnNSRmVyYmZHU3p6QUNMTFlBaVhCbmc2LzR6bE9zTXcxeUd0?=
 =?utf-8?B?YnFobTQrbkpyTzk4VlNWQUdpdnZtalJBRVUwbldLTGc2cGwzaUU0ZlVQanhz?=
 =?utf-8?B?WWdZUjdMck1OdEZub2ZiclhXTllFTWZzZ3ZQeUJhTVBNb0tSODBlOVNRTFNp?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 094b819d-2f7a-439e-8623-08dd61210592
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 04:47:41.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXmb0QuE5Br6QEOOWyGQIOna1I7rsuhtt+Dz9i5XIHHCT8Hx+Vr8YrT3vBfv95+lUXkJNw5vgjMmsOmuHW80QCmo+gH2zuQIQWBnyn9usOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com

Hi James,

On 3/11/25 11:37 AM, James Morse wrote:
> The mbm_cfg_mask field lists the bits that user-space can set when
> configuring an event. This value is output via the last_cmd_status
> file.
> 
> Once the filesystem parts of resctrl are moved to live in /fs/, the
> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> this value is output to user-space, it has to be accessible to the
> filesystem code.
> 
> Move it to struct rdt_resource.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
> Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> ---

Nit: checkpatch.pl warns about the duplicate signature for Fenghua.

Reinette


