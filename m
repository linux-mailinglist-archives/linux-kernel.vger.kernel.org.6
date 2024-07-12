Return-Path: <linux-kernel+bounces-251195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0059301F3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499F01F22BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C5502AD;
	Fri, 12 Jul 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5YL9nrN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C41BDC8;
	Fri, 12 Jul 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822051; cv=fail; b=NuR85pr8u2zdDZQkyt6aK+GnPgWbqnRk9dgpDEpet5AUcHA8xgRW7O0ggxLWVArzTwnf0wKfeBswtWqunxwDV/9uiOEd4EAzn8cTBcMXvmVzeg6bdSOjcAv+s6AIQ++znTV5AzYaGJyaLq44qYodiX06Z/8rpqAYDPyaghsJxlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822051; c=relaxed/simple;
	bh=jx3aZCsxczBev3/mv7lSmg0GMdqmjBt58qe/RQqr4Do=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iXoOJMRgzupFcKUCuG+3JQhtS4W8eaRtPjSceIqPXImtyBHyLbpWoU9FYO3w7XPZhHOzkZ2YDGuVD1dJdxBGK5Cumg9G6vpBOcbtwMvFvjclWKf17NEtwZrFdsSZNa79PgMVE1PDXBv8wa3XkRoU1Tw3EqZFISmoxSXiWXU0LPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5YL9nrN; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822050; x=1752358050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jx3aZCsxczBev3/mv7lSmg0GMdqmjBt58qe/RQqr4Do=;
  b=K5YL9nrN6kar9luugUHJIITuNGWleGpEEHESbc2xIdjtOEP4wSM8qMOd
   31sAgV9p4WfqDJsmkhaz6mIQeEFbpGJFinqgvjyE0vTANGdgWZPuYqI9U
   kPa6JUMPddP6Lzo//P/+YORn25HKifhQk51yspbIJs1bBIjywGMnLPgGM
   wBTuq3gzqU8uDNh340YkpAmKPv1XKoaxYH6/69LDIqTYIGzLr0F6AFZ8U
   Ec4CGG8ybiTIWLFiiyYZmo+9ZDuajZYfaDBjL3lWg4DoSyiKhen31fLkF
   xk0vFmWpjDrwcdqRm2o9T4ReC6d5mPV3nduXW2h6T7iUce5jgzP3MitXl
   Q==;
X-CSE-ConnectionGUID: KN3DYsMhSDGqdAF7i+HQEw==
X-CSE-MsgGUID: q+YPY6UBT/ugyfo8lk5ABA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18412471"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="18412471"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:07:29 -0700
X-CSE-ConnectionGUID: mREe2mjHQhGHY4rw3uU/1A==
X-CSE-MsgGUID: wTTYXODRQ2Cw60ABjnldAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="49030664"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:07:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:07:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:07:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:07:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iehqwjTu7eQbdIZg5rF+sKksF3MvFmbAhsMZcWsKXbjDeAOV6UhoXHLn+s1klNVhS90aP9aFSEpXkbZ/zztCpuo0tdaWORK1qrDr16OG8AiDTjyCCjpAYzjthdTe0iu1pIqKyvskpbPiXySU/kxdTiubcKm7pInTodg5akl7CtNfGvpWswHWPnserMRLpJp/P/204N6k+QAxotYxHLEo0aRuhL0omsk776uyj7e2JDywe1P4jN49eEOf9guTFcfjbM53S7FedzcFM1qukDGQY+ddl6a0nlPWFf3ltEH8uFudXWWY8I5ELKzftjSwjqNJvKJhy2a/44XgR64qSOh6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45eFo+L2BQhZl6/RaL4cO9jH1Dy5owWhKrT0Rx31EmA=;
 b=TGA/xat+a0XuNl1kk7fe7rzePM3md+j6evkuClcWPU2xIGmxL4VD3E2iCIGFMF7x1x8sFpklynb2L/Qf1C0UiWmN4l4NFHwMR8GFontPi1R+Qpe69lhwncuvVGIV6xvXtEc546afwi4Fu+U+zPxeMgZmXx8dHPOE0UQh89st11nP1Ogp9pnRddwdhizE2Q0in8z+tC/NDDte+BBlUThAynO1lDJnPad1NM865PCOjXSpKWuNjRVLiXi2r8RFbVfif/B8QQSCrHCwiewaRapri5Q5bzB9SVWeXi4vX3Hy63PcBoRAGWxZPaju9xfC9/rzxfpo4pQlqnmLhfN2CV3Y+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:07:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:07:22 +0000
Message-ID: <75e18bbc-306e-4cf9-841b-a261fb62fe42@intel.com>
Date: Fri, 12 Jul 2024 15:07:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/20] x86/resctrl: Initialize monitor counters bitmap
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:303:2b::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f6afe2-98d3-48b2-0882-08dca2bf012b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnpDeDBVMnhQUWsvcVU2Z1oxTGtpaWMwVnIzZTZMSFZmNDIrMmlKSlJteVoy?=
 =?utf-8?B?N1FrVkxVZ0IrVE1RRHZXdzJXa00wQVZuYlVQMmNrQXJielIwSFN4VUU1SDh6?=
 =?utf-8?B?dnF6NHJzTVMyaHFrQSttQVp0RTN4WWFQMEd1NWZEKys0SXgvTmpkRGxEZkRi?=
 =?utf-8?B?WTJDaUxQRzQyMjc1RmM1L1cvWGQ4RHVUWmlRUTZiMEZZcTlYUHdlTWw1T2F0?=
 =?utf-8?B?OGk3bEZYUFVkbmRBUjRjOFlaSldEZWFCL2drWnpHSUZnZWZPMm1aUzF2U1p2?=
 =?utf-8?B?dGxFeDdNZHRlaEJoOTRORHNPa2I5SFBjVjFJcFIwV0xxTElUdVNER0YrdzBD?=
 =?utf-8?B?L2RmaXhzOTNCTEd0TnpzN1pqZmZUZlQvQ2wwQjFFTG4rWk5XWXdGOE1rQlY1?=
 =?utf-8?B?Y2pSWE9QRm5xSFI1TWJ5NDJ6ejFSQm9haUQ5TDZqSzFrWkUwbHJwZ1BvR3pl?=
 =?utf-8?B?T0tzSEZ1Y2dQN2lvVHpSdE5pZ1gwZ3ZtZEdmQzNjTVZZTXh2aUlkRVZWZTBa?=
 =?utf-8?B?UDJuK3d0SXkyalNER1VsZHFBSStHdzh5VzVYN1ZaZ3RuRVg5NWcvNk5tVFVa?=
 =?utf-8?B?TTdWa1FJN0Nhenk3S1R6bmxnTTZGU254U3luVkkzZEM4cVRBQ2QzQjFkcTFC?=
 =?utf-8?B?N3B6cm90RHgrcWoyVDRpRjY0c2pzUitLRnYxRVBSUVdDZjRhNGNqSTNvanJ0?=
 =?utf-8?B?b0tTV1lHRDdmdHNyNk1ocTlpczdia2pXbDB2QmF4QlJaVUd5enlVSmMrbk96?=
 =?utf-8?B?Si9JRnI5N08yaFR0eGtlUEhYZlYxMU5rckMyUkd0VDZHNm44MmQ0R3JnNFlQ?=
 =?utf-8?B?VlRHMUhHUllmNXdKSDhISmo0V1kxQjc0ZWtHdG9ZektJT2VYVVVMbTVBVVVm?=
 =?utf-8?B?ek95NlVGOUZJdFBaTXIrM0F3YWhzZ1poaDRNcHFBM3g2V3hTSCtrKzRnMmR0?=
 =?utf-8?B?dm8reW1xUWJPYkF4dnlIcjRaTEFJN01BVzI0dGRuOXZNRWJ6MjNUaEl5SE9r?=
 =?utf-8?B?NGoxRE15MGY2VGp3eGl4dzlzMk4wcXo0VmJwVER3bThqS2t4YkU0cmVxaHFS?=
 =?utf-8?B?QVlCYXppc3dxbXFBaGplMzE2UkNxNzFKRkVxNGo5c3I1OEl3TkhBelVFZGV2?=
 =?utf-8?B?YVhpYlhnd3ptbkdxMEVYUEJNRndIV2huSGh3T3NNN25jc3J3bndCVGxaYlg1?=
 =?utf-8?B?TTZXd1JHamFqZmxQcGY3WnpoK2pncVBHUkY4R1ZtcW1zdjlGejdBUllReFho?=
 =?utf-8?B?czNPODhCUkdMaHl4eTNsL243YmFsSGEva083akR2K3ZXREk0ZjdBaURkNVBW?=
 =?utf-8?B?M1Z1cENKK3hvaXBpcStuRVNCN3h0TUc1Q09oaHoxVHVXdjZUSGMzRURxV0VB?=
 =?utf-8?B?Szg4ektGQWZqSTlONFpGMXQwOHJScHUzQnZoMnJaVTR0cUwrQkdZK1QrSVg2?=
 =?utf-8?B?S1RjbzNlOEdPZG5HVFZrZjhNNmxDQXJpb0FXSXhmRUI1YlQwdkVjdlhRZzUv?=
 =?utf-8?B?cFNXQWNpdkVoeVFtcXpieWF0M3Nqczd0eUpCN0tPeFlNSXFlNmFZWGV5L0lD?=
 =?utf-8?B?ZjBDRTBPZThEZTFjUVh0UFVDaEhKemViRktQR1lzd3RQNUpSaFJPUkxlUDg2?=
 =?utf-8?B?UDlHVlJTVHY2WHdPblhaMFVHMjVLdDQ4RnlmSGVmSUcrVnB5RitIaTUvYVRh?=
 =?utf-8?B?UW9EWm1XZmM1U09kandlWGJWWXF5YkVCNVpEMXJJKzVJUmVzOHVrZ1djYi9D?=
 =?utf-8?B?QmFxREYvWDNCc01xamlxNzUvZERWZHBTajZURzg3bDdpV1VKczNHV2tFMFJJ?=
 =?utf-8?B?R3MyQnV3bkZOd1g3RmhnUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3dYOXJuRW81RXNKbWt2R2xkdDBiRVVQQ1pTamdHR0J6NWJuUmZ0TGV4T29o?=
 =?utf-8?B?bTUxby9iazloNGRuSmFrVnZFQmhOZHYxMk9lMU1kekxrRUg5ZTlOZ25mckNB?=
 =?utf-8?B?WUIyRDgrRzl4cEd5SU1aZW9LU2pRMysvTnZFUjBDazZ6R3AxLzN4ZW1aanN2?=
 =?utf-8?B?M2F3L1R1Q1dMb0xkVG9QdENNRXNIYlNTV3ZMcnM0QnYraktNSTNNd0txSHIv?=
 =?utf-8?B?QXI4UVdQRStyU0RIeUFBK2dmQW5DWk51VXllYVc0QjRtc0UzMm9nYlFoQ2Vp?=
 =?utf-8?B?R3RNSVRyWDNSWlAwNjR2TTlLS2RieTR0T21kWGhld1FGSDVnYnJTamdBMXVq?=
 =?utf-8?B?NWRid0Rxb1JrNXUyQWozU2krM1o1eGdUY2ZBZ1kzT3pqVEZaYXVtY1VpWUVU?=
 =?utf-8?B?eDZsYnRwbiswK0ZTNGk2V2xxL2x3TlRQby9CRldFaFUxS2krS2pZWEh5aklZ?=
 =?utf-8?B?V2VKS2JvUFhqb0pYbDdsblhHdUlNeWg0VzJEMXZaa3dOQnNtSEQzaEZTbTRD?=
 =?utf-8?B?b3ROTmZ5ZDd6UytWS1hpRk1RZ3doTk1pTUk2emlZM1diWW4vcFExRzBRZkVz?=
 =?utf-8?B?N0FkL2hvbVlESGNLQU16cmk4cEVDNW5tVWFodk5qcW50L2VNZkczYlhHWHR1?=
 =?utf-8?B?cW1hTGZBWXZzSDhvU0ZRVW5ibmkvU0JNb0JEWkdtWEFBeXpWUGhUcElicmw0?=
 =?utf-8?B?NG9rWVI1RkRNUk42TmEwaUw3dkNFT2tUdkFhWXdrL09SYVhDVGkrbFNqb0hw?=
 =?utf-8?B?SVZScysySERDcmhuMDBEZ2NnbmlZVkhFeEIvZ2xYcFRLQW9JeFF2Rmt4cklh?=
 =?utf-8?B?aXJWNjNUZmZ0QmNNN1pMK2d1NHVacGZiQTNYbnBTRVc5OWJHVWluc3VCOHYy?=
 =?utf-8?B?aDM2VVFvNk1kaTJSSjMzWndwTE41OHVXd0U1aEV2V2VsMVN1MFVYWllCcEFR?=
 =?utf-8?B?VEx3Vjl0SjV5OFVnd1M4ekZjb0poNlZZYm9hN2QySWFybkM5Rk1ZZU9pQWFI?=
 =?utf-8?B?ZkNlOFdCMXViZEpZV1cyTUI4VjhRcVlDMGUvQmZmL05KNUhSdFROSWNmTFkv?=
 =?utf-8?B?M3Q0S1l4S1BqRWZQWkI2MUJUS3hhdWdicXNGMG50R0VjUXVpb214L1NwYWxa?=
 =?utf-8?B?K1ltUy9URHZUd3J2dHZDUE1QMWxpVk5SS3pmZ21IZHhBN1o2YWtJaXUzNUZq?=
 =?utf-8?B?QmlyU1EvY0FWY1hwVDJEMjFlVmxHTjZWbHZJc3g1UHNCbG1XQWJGOE85YUgr?=
 =?utf-8?B?Yis5VC9OK21iNTdPYkd1TGN0aFpYT3JFbFN2YnMvY1dLVEhBK3V5QjNXSTFL?=
 =?utf-8?B?NkpnUWtwa0c0RWpEWThoeTZObmYxbkVXQVBicWJLQkJBK0tmV1pNM1lDdW1G?=
 =?utf-8?B?dXR4bXcyNTlJZnJVaDBmcUg3U2RNeGJlRHAvd1c3UVgyb3FaTDVyNGRJVnBE?=
 =?utf-8?B?VlZWQ0VhdEFxdkltb1JybTN3cjlheEJiZVpzMTc2Y0U4ZmhJZk9SOGExZ3VZ?=
 =?utf-8?B?TGdraC9Xa2pCQTA0Q21Id3FUS1NHdUNQQzl4NnNKZjNWK1dHUk9VakJFT0s1?=
 =?utf-8?B?RDFRbjNJZTM5NVlmaGtWUXdLVXBqejU3bTRPS3NhVHRiQk1QckY4bWpJYlRp?=
 =?utf-8?B?eXFCdUpXWDJNangyb0NzVGM3T2xlaDd5SUFpWUVyeldaYTFUU2RFL1NJNU1V?=
 =?utf-8?B?cjZpeXg1ejFqVnlpczRqK0ZuN3BhTUk0MTdtcUhvTUVKWHZ5V28yUlcyblBr?=
 =?utf-8?B?RjZvZm50bm1kK0RENjlkZDcxUmpPN1g1eE1KdldXK2VueDYyemU5elNJYmtI?=
 =?utf-8?B?Nk5tK1FmR1MwKzFQVXJCMWRySEhHcmYvOWprSExNMDV1WC9FYkc3dXM2b0J1?=
 =?utf-8?B?V2dSc0Z2T1IyYzNMb2tiTCtYbzI2cnlmb0FFQm5RNmpYRldkbnI5aHM4blpU?=
 =?utf-8?B?ZG5PRUs0RGdSR1JUVFRWU3hHVFVEVG95bzYzdDc0c0U2YTZGVDVvQjZnaU9T?=
 =?utf-8?B?dnp3ZFhaRFFMb0lQRDdRUnJ4WVhoYUV4ZnJZb29wYkNMVnVIcTkyWjZPb0FZ?=
 =?utf-8?B?dGZMTGR3UEtJSGdQeDZmNDUrVjR2N2pNNFh0Mmk5ZW1SV1RqL1F0VWNIVU9I?=
 =?utf-8?B?cGZxV1U2YnhkMU5SaDhKZFRVc2hQZy84UFZwbVJCc1NVTWlua0xTS1J2STlH?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f6afe2-98d3-48b2-0882-08dca2bf012b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:07:22.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JluuvLY2eY9nEtUwfgzrD/D0/gXFNmez5YeVklVnbt9VrqnkS4Q66lILsK75ZFn7sHc0a9vQit0NWmORPBySz0L/dlUQuQVLF2Kiz7W4jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Hardware provides a set of counters when the ABMC feature is supported.
> These counters are used for enabling the events in resctrl group when
> the feature is enabled.
> 
> Introduce mbm_cntrs_free_map bitmap to track available and free counters.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5:
>    Updated the comments and commit log.
>    Few renames
>     num_cntrs_free_map -> mbm_cntrs_free_map
>     num_cntrs_init -> mbm_cntrs_init
>     Added initialization in rdt_get_tree because the default ABMC
>     enablement happens during the init.
> 
> v4: Changed the name to num_cntrs where applicable.
>      Used bitmap apis.
>      Added more comments for the globals.
> 
> v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
>      from the name.
> 
> v2: Changed the bitmap name to assignable_counter_free_map from
>      abmc_counter_free_map.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 29 ++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 4f47f52e01c2..b3d3fa048f15 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -185,6 +185,23 @@ bool closid_allocated(unsigned int closid)
>   	return !test_bit(closid, &closid_free_map);
>   }
>   
> +/*
> + * Counter bitmap and its length for tracking available counters.
> + * ABMC feature provides set of hardware counters for enabling events.
> + * Each event takes one hardware counter. Kernel needs to keep track

What is meant with "Kernel" here? It looks to be the fs code but the
implementation has both fs and arch code reaching into the counter
management. This should not be the case, either the fs code or the
arch code needs to manage the counters, not both.

> + * of number of available counters.
> + */
> +static unsigned long mbm_cntrs_free_map;

With the lengths involved this needs a proper DECLARE_BITMAP()

> +static unsigned int mbm_cntrs_free_map_len;
> +
> +static void mbm_cntrs_init(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
> +	bitmap_fill(&mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
> +	mbm_cntrs_free_map_len = r->mon.num_mbm_cntrs;
> +}
> +
>   /**
>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>    * @closid: closid if the resource group
> @@ -2466,6 +2483,12 @@ static int _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
>   {
>   	struct rdt_mon_domain *d;
>   
> +	/*
> +	 * Clear all the previous assignments while switching the monitor
> +	 * mode.
> +	 */
> +	mbm_cntrs_init();
> +

If the counters are managed by fs code then the arch code should not be
doing this. If needed the fs code should init the counters before calling
the arch helpers.

>   	/*
>   	 * Hardware counters will reset after switching the monitor mode.
>   	 * Reset the architectural state so that reading of hardware
> @@ -2724,10 +2747,10 @@ static void schemata_list_destroy(void)
>   
>   static int rdt_get_tree(struct fs_context *fc)
>   {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>   	struct rdt_fs_context *ctx = rdt_fc2context(fc);
>   	unsigned long flags = RFTYPE_CTRL_BASE;
>   	struct rdt_mon_domain *dom;
> -	struct rdt_resource *r;
>   	int ret;
>   
>   	cpus_read_lock();
> @@ -2756,6 +2779,9 @@ static int rdt_get_tree(struct fs_context *fc)
>   
>   	closid_init();
>   
> +	if (r->mon.abmc_capable)
> +		mbm_cntrs_init();
> +
>   	if (resctrl_arch_mon_capable())
>   		flags |= RFTYPE_MON;
>   
> @@ -2800,7 +2826,6 @@ static int rdt_get_tree(struct fs_context *fc)
>   		resctrl_mounted = true;
>   
>   	if (is_mbm_enabled()) {
> -		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>   		list_for_each_entry(dom, &r->mon_domains, hdr.list)
>   			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
>   						   RESCTRL_PICK_ANY_CPU);

Reinette

