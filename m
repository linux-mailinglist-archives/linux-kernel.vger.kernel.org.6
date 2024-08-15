Return-Path: <linux-kernel+bounces-288233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6A69537B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B041D283F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B21B1514;
	Thu, 15 Aug 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIQp8wZq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5E15E88
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737471; cv=fail; b=FIICjoKHpdyI44tmeJHmFY7zi5IP/k91H0iw8hym9F8vQ4fRnq5LZVVoywx7K2OTi1t8Fhgm72/mJ59ScK9QcRFwicwXpz7RFwCG20F6GFBGH1+re7c82LEEMlNa8LFAjpS94Z/L4BGDeLKwv8XSSdQmkIxl6D7sDPgonNI46HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737471; c=relaxed/simple;
	bh=Z1cL9hdBeTP674oPTwiWhuCQiy2EDc9dob2FXvLRb9k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LvBtf9aaGvaf3St8S0lyUvQObsgYS9K1CKx+YgvqO5ktSYgboDUowYm+tqqt4eOv1+wjrLknuMGVq9rZgzmr/B2jrYwdhdhyomv5njPwZUU+K9/t2tLRxKMUS4pT3CXTCHrxrfrWUDqxEgTXLnNc53fww1OIVOI28+F3x87WpcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIQp8wZq; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723737470; x=1755273470;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z1cL9hdBeTP674oPTwiWhuCQiy2EDc9dob2FXvLRb9k=;
  b=RIQp8wZqMm418oeIrXKdCnpT/WHyclYSxD38dJGUR9YDKaXdXuhs3eCc
   56pAK1dp6b7yDcMbFfkaqzNQhga3WAvSTPV5/W4MFCeKUyrPCX+uBOTK8
   CGPQEUO74JJm2Zh/Q84ykVwRhCNYqZoCGSEH0zfPJVsQ3IyMAr/ChOa2J
   FHLhO/Wr62lMRNHuhDR1dKsjlqAEtBwUULPo1ymkk/aZ5roUEjti+REch
   rBhsBQ+Zsva/RICn+fdrQwWz2hPCJCjmEOc/6ohAWxHppE55p3OWVAbVD
   QUDszBF8tGZcLMNMi5sGmOLC2pyG48dMqry/Sr7R7KQraBRwwT5KLUsZC
   g==;
X-CSE-ConnectionGUID: Mx34W9bNQ7yJQcImNJPboA==
X-CSE-MsgGUID: ugSfT9TaSJW+DeFjNp1UTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33392137"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="33392137"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 08:57:49 -0700
X-CSE-ConnectionGUID: uBYYPFdJTkeKSuD9KcdsSw==
X-CSE-MsgGUID: px6tvTv2T82J0uxgzcqpMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="59240455"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 08:57:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 08:57:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 08:57:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 08:57:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 08:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3NPWQV/EbFXjG9oqFVplT1kCiCrH/5VJcZxTphQ/MfYyL5fxVRrmnaCZgSN6eEUJZsC3+TfKG+kTyTIObABnjjV5tjF5s+McRLpZfBGHo40OaZqg6NlADhoWE1rD10wkLVpOxmgEKQ+CsoKPLUDL+1tp3u5pLWfW24b39H8X23n/OJpozfWUbs3TooqJqloxCuj8iqr1/67+DjtSCjAnFjZKDYDeS7qtVyjoB3YCtUlktUJCjwMjUPSp2/yP0DHYW/+mDgSt1axni4chluwe+EpG860aZySuXoIUYc9Y11S6CpYo+t9dgY4aLCm/WG151IxkgXGFwHLP/npapkTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goMIUMyTdFvCZ/dnmq4jserN2IlcKC4KBqTNz6cwjoA=;
 b=McqC9KgtsqnW2kv5dnADCFrmt1fgS4Bh+7zpCyIPy3/SfhRKD+dX7mo27s5ckV47ITj/OXywFjgMf+UtGMGLJ6qVpKhs9NoOKsOOY6WOKu9aWx9RBzYmPmcVXozUPNFdXMuuEjJ3Q84UiLKeZCKeY67LR21zLrOoRdVjFRzXRAXLjMPVsw/6H50xTlBtAFY0pw31DUYgJd8io+zKz/3Gu4xyWu1WwA99osWxfSPgBl9E9qnLezrLgD590imNbpziVBNjkKq5Ppu8aE9ir1j2RQ4tSqSb+3+z1PmhhS6rC8yjiNL5o1R2z+TYYuXGxlEkmWWsV+YvA98YpH7FfWV5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 15:57:45 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%5]) with mapi id 15.20.7875.018; Thu, 15 Aug 2024
 15:57:45 +0000
Date: Thu, 15 Aug 2024 15:56:39 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240815072427.GC12106@google.com>
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d4e01c-7348-4ef9-9b67-08dcbd430107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?seoZjQ+TlmLk/Odh+cA6OldSFh1kScSZg3i7i+UDOJCdFty2sKzGF6QIRv7F?=
 =?us-ascii?Q?RI2XpjWncVWBHr8K/e808U0hGnkgld68tupl2CPtYrSnRM2HiZ69ixTYdmgb?=
 =?us-ascii?Q?NKtf068wbNiLDLVPWR2/dk39dGmki3aMbGqvFx/VWnAVR4xi18Ooj1O0mhIa?=
 =?us-ascii?Q?4nTUKljFGz+zncbyRUplt15IOna78vS3qNJwJtfbm+8L8KPA9NzOLz19VtPH?=
 =?us-ascii?Q?1ru82DJeXF8dUjroMmoyIO3BRx5Wa/ygOs7Q0znN8Vskq5TMO9cjJchSstX9?=
 =?us-ascii?Q?yxQFBckdHKkSyp42QiQWfZ4zRYaxd8ciqxN98npOQY9ZyAnRTmwC2T/R3Dav?=
 =?us-ascii?Q?Rpgkit7qLrQ741zHymMxQg4u8hZ1JiX0km32VBgf/TyR/i8nErt9FRz5MYOU?=
 =?us-ascii?Q?MsPCZ/KH+6s3xjyQi/+6m/lt6YsUJvpYzrKxwFGJXPXRHO2SfpsAhRUj5E5d?=
 =?us-ascii?Q?tXQLp23cTmFSS5jx+SXijVA2z3oM2gVYY9Bg6GGhgkaYOVk/k3zAHorlaUpf?=
 =?us-ascii?Q?X3ORNE8cczI/7KRYB6MqOTB37tmgEl75VzXSsi0xVznRkLrWSLvc9Vcf80UB?=
 =?us-ascii?Q?G45WqJG7UtEKDFASECukrZrxN8xoeanTwlpyi6hYh88B8zmM5TzupI9OTrIK?=
 =?us-ascii?Q?oU8cwUaSGGFwwF5lNdmFBgo7w1po2xDJoOEAkq0GHN7luClbBGn3uP6SBpxo?=
 =?us-ascii?Q?8jg0GbXrtHvhS8vc4pEc3FfZQ6DRnfaKCXFxFxc/PwGsWhrnmji1C2bgeYto?=
 =?us-ascii?Q?FpQYcJBkLD7opaYCqZ+JGbl5Dzp77GIsVq4ad3rh1agqsmI/k3bkzmajonYz?=
 =?us-ascii?Q?DpyGqA1cKh4KWRHt1eAw9WeAuiurr4TOE10Z2oqgyW6FEDgE7CfW0qSmycaN?=
 =?us-ascii?Q?8090v3lAIzQpXGmucTRPKdZYWD1t9Tctsk+TgZf6xAwTMIxoLnnBlW+0empE?=
 =?us-ascii?Q?sLkecX6EOnlw+jrJC9383tTz/ATcl1dDvfcC0W35OQoXLiZmzAwdB4vVp1Gp?=
 =?us-ascii?Q?YjIs4jkoq086OOKslUg55r6OQ0LAPWGq3FZHtTTFze7wb2CasjVN2qwTXuJO?=
 =?us-ascii?Q?1JjBlL5ekbOd0eLsdoYz9F9v2uv67ogu6gorwtiZM9/AzxkT3R5W/ctdn7HS?=
 =?us-ascii?Q?JLG73Zs1TjgFoibnWOCkP7p0KMDJHg/Fdsk9LJGbjuxoauiSyDCtlI5MSWLF?=
 =?us-ascii?Q?PaTGAmlaE2BFF1Ku4U9WnHyVQcLbTsOZ8q6E9sF47kPIP5wWAdwxt3pMsMX8?=
 =?us-ascii?Q?mNJlfBCNrClvmCsZyUXLn80w9HySbKRE1LkL+dMIFP+/PGOu7IjnbvhqI2X3?=
 =?us-ascii?Q?r48=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d4BjFQjYsi2e7Rn0VTiwhS7MJ2AwMreAmmdOH8VEJbJrN9xjlZK5z9pZZkWH?=
 =?us-ascii?Q?11znFJChBqeh6IL37nH4lMVPERFdHs5h8viP4yvTkz2mOSQ4IMEkgszYTDli?=
 =?us-ascii?Q?u8QJIspDqYd5ZlKgZqrjv/NUrfeqO2L+MrqnSN5l3rtN7SBecnQqrgZa8Teh?=
 =?us-ascii?Q?wMhFoOpLBIIztYwBwqN4UQMKyFdWf2XmCX7lJ+HAB8f1V6nY7vGuYojEPLX+?=
 =?us-ascii?Q?qbNEN3vmiuoGZgRQJ2Phhlx5/TFRa2rb0zQwHF79vHX8HsIvEBTP39XCmzdH?=
 =?us-ascii?Q?8aPrno6xHnhrdNfx2qZjRdOMECpldtKegeV8AlKoZCgLj25TxU/fi66Le2Ht?=
 =?us-ascii?Q?AjbK9scCAeoOjo3QSokoOGwAZch0Ns1xcIrurwhD+HjJK/ecyj4/sPQ5YJW6?=
 =?us-ascii?Q?qOesiw4J0ypiHeTDrZomOMSUwirdVwfcGM0zZLYbsirCIJt/nUuom0YsTeB/?=
 =?us-ascii?Q?k51Mg0rfZaCgIZVUhEy3N2x/tsakLvGAjjGER5hNRa+HSKHct8SZpX7Z9jt2?=
 =?us-ascii?Q?tg3xYUdpmvf1b6QUDTUadamZ+YFMiwX4qQQvk86e7jin22hSNGAIb6D6E+um?=
 =?us-ascii?Q?LxTQaieclCbqkRAj9zlgXVwGpG0732nLdwZpebfFpKLuGOKYQIyra4apTB8e?=
 =?us-ascii?Q?AEriqJCeZSQovtKgt89mHndnAqeGblE86z3VKGtAR+Qnbm0G5P5pzlfBE3LO?=
 =?us-ascii?Q?ds+gvEO7ASwk3UZlfMzr5VlEANWFrZnd0aUDqY2CQqlTkG+nb/NCdfp4EoyD?=
 =?us-ascii?Q?UKTUX/mYlmdnufue+S1tqsYVm9Sq27LsKrYhl9hc0ULKAIIQK1gGA4ZUEAX8?=
 =?us-ascii?Q?M0OmHesC2FRT7vk3AuKPoXbbkYvp0oLado+6lv8D3Nm61fzuUOTf8TGXJWcx?=
 =?us-ascii?Q?n0V151iTWNGld+4/CKD7NGVCehCvKCfWeh/J/JcFncbBYQ7u9I0ypna92+4Q?=
 =?us-ascii?Q?I18Gujey/h1tUHhjKj6kodwasjtLMPxgXvQ++n2ZjmPckAPYXBRCJf3KCQw4?=
 =?us-ascii?Q?blNP3dGGlClpeLMOFD9HsVdq9orvzEPzDRgDsFZ8c50l9rDVRO0yOSoPwiLN?=
 =?us-ascii?Q?b2B/YT2kZnO/jy2PgSc5RqmTuGRMhhTXv/fRvkiFOLpJDjDzO1usxn7SUkdR?=
 =?us-ascii?Q?ZDfEBygESz0Uh5YEhcS2shRHWNE/F/+Zn5wMa6VB7qMDqagUBQ8yh5u+V4Kn?=
 =?us-ascii?Q?J02Vyumpm4Gx49MvupPXChPEFQH88zGJEoZdpG3C7rd94oUMrjpbUw1arJzy?=
 =?us-ascii?Q?ODguyaXoqr0TTIysYODcc24s8ckO6td7Uaop1yIgx/c/X+qjqWXbVvcd0Out?=
 =?us-ascii?Q?tE2z7ZJZ2Oyx9varCasPUGy3V2AQK4A0tBIEm1DHaGA/SK0pj0M+H9alwfB1?=
 =?us-ascii?Q?kizcIPKj5ksEHhqKTOcXKyt40U3W0dDN43eHabVZxQ174290lSkfAl4eMnJW?=
 =?us-ascii?Q?uA4n0Et7ROot+SgpkJ/SaF2Ifnq9PNJRGfzmLsP7kU+dY4R40t6rCbDfVZIS?=
 =?us-ascii?Q?Rso58dcsyd/tpezKq8l5QYEXyEInDX2nwq4HPyvMuXyjazgakAkZddttgc9f?=
 =?us-ascii?Q?7iChpKrBxUYh/VK89rg7KLjGLvG/RueIn7uGoBudVk2MB+Ffex8OB1hjX/zh?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d4e01c-7348-4ef9-9b67-08dcbd430107
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 15:57:45.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaDcpXrwXznBBPsLvp9FEg/myfY6+U8OMU5hrM3zJM7vxQ96Dpyrt/boGKYjpkb6iB7q4xV6VElNiPrN1W27oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com

On Thu, Aug 15, 2024 at 04:24:27PM +0900, Sergey Senozhatsky wrote:
> On (24/08/15 16:09), Sergey Senozhatsky wrote:
> > On (24/08/15 16:02), Sergey Senozhatsky wrote:
> > Oh, okay, so this is related to [1]
> > 
> > 	workqueue: Split alloc_workqueue into internal function and lockdep init
> > 
> > Cc-ing Matthew on this.
> > 
> > [1] https://lore.kernel.org/all/20240809222827.3211998-2-matthew.brost@intel.com/
> 
> Matthew, did you mean to do something like below instead?
> Otherwise it breaks boot for me.
> 

Yikes, my bad. My change worked locally and in Intel's CI for Xe [2]. So
I did not realize this was an issue the way I had it coded. 

I believe you when you say this is an issue.

With that, the way I coded alloc_ordered_workqueue_lockdep_map could
also be dangerous. Thinking that also should also be changed back to a
macro too.

Let's see what Tejon thinks?

Matt

[2] https://patchwork.freedesktop.org/series/136701/ 

> ---
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 7a2f4cbbe8b2..55e0e69ee604 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5615,12 +5615,11 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
>  	} while (activated);
>  }
>  
> -__printf(1, 4)
>  static struct workqueue_struct *__alloc_workqueue(const char *fmt,
>  						  unsigned int flags,
> -						  int max_active, ...)
> +						  int max_active,
> +						  va_list args)
>  {
> -	va_list args;
>  	struct workqueue_struct *wq;
>  	size_t wq_size;
>  	int name_len;
> @@ -5652,9 +5651,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
>  			goto err_free_wq;
>  	}
>  
> -	va_start(args, max_active);
>  	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> -	va_end(args);
>  
>  	if (name_len >= WQ_NAME_LEN)
>  		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",

