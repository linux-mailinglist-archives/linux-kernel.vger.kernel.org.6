Return-Path: <linux-kernel+bounces-214159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E8908056
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0AD7B21902
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED84C8B;
	Fri, 14 Jun 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwzbuiaW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9214A11;
	Fri, 14 Jun 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326568; cv=fail; b=W9r+L0TdyMpAgwBYGmabu6VtKB+cTHiUy6ADNrki0nQDKmhgbXZQt5rGGhC0wWAC6rh3HZSLDDK3pUumUkuxLFs6jPoww9iEfu0+Heu+ixPAQmwm/IXf4vzhads2htGiuYRnDeTazVlOWHcsnLpgYfjQwd/ZQAztPjnzESb5nLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326568; c=relaxed/simple;
	bh=exvQZ679PaKiRHYkNSyCbGK/77cbMfV5WOwZ1fVfkRw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CkamkdzLFGYT/mNVVW80LHCcYuTH9h1Mp2mqwyWsDsedLEqjf0Lj99rKEdzJ8wUk3XMIu7pj7PXGg9eRbM7vkibQooVlTZ/dieOpPo0z7WQryY3QGhNYb25E6W0+DpxKvfZRDa3ljFRvFDvk4+I50N5HFtAUDavBBc0MpAAlAU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwzbuiaW; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326567; x=1749862567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=exvQZ679PaKiRHYkNSyCbGK/77cbMfV5WOwZ1fVfkRw=;
  b=hwzbuiaWMUNEkHybWdLiWuZZ8Eak1YkEb9zopKi5Xi6DW3veZFLGr4iw
   Ay/SoP+dziZtCfetIXggkKMS4fajuu1UCvpJ4E+6k9WrB1H8XrFXNC6fe
   R8M7Z9S/HQ26lfaFgnEJD8TtizNJXEd5zddgqUe7ef9ScAE7F/yY/N6+9
   5kf60tCDQfL18BBZvTuv2QBs3FSTNRs7OJKtNaKLBjiky4sjd/i9kbTTJ
   Ob1cDKt9ybiv79ccfedASF4oJLg6Hoz9G9eSPSSIafQ0tspLE1XnVUsnR
   4ffvcv8mwf8DEjspgHK50wJUIbxbZBlWhZkgE6h52bSjdswO6qaMCPlAQ
   w==;
X-CSE-ConnectionGUID: zDET7913Tm+L+jRF1JTy9A==
X-CSE-MsgGUID: 1765kTm3R32Mpwvcd00N5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25870081"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="25870081"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:55:58 -0700
X-CSE-ConnectionGUID: yEVgo5V6SxOD6beDYRPrCw==
X-CSE-MsgGUID: YejOguSQR+qcPjPRZu/tjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44759036"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:55:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:55:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:55:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:55:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/9UERPE0O3cwRb+nR8W6BQXfcZ9HnQDGq4SQecQ1PPnlxzmSdaOu7gg05rNuSMGXNZbTxXHDIXaDQYe3oTAaao4+38OTiSGaaOJ7AXUSqWENCAomkiiGJI8NLEgVpd1F8senwlAWiVR+DYV/beYw+LKDrAwFKtr15BkexIuhQ5RGHStJ7B6+aZ5vdwtdmCT7X7bGMQR1pZFS7npz1T+144/Hgh2sjyZEsrwd2BwyTAEi8JeGAzVUkKJTHtkTJo5cW/4VyA2iAp/OgOIvJAr/GaP6cFXY+I4KUjXJtZ6frGVQhladpOdzCQwWkqoUxdDxL5uUciojhWJVZFoHm8FKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exvQZ679PaKiRHYkNSyCbGK/77cbMfV5WOwZ1fVfkRw=;
 b=oABax++tRx1LoskAaQkrkAn9MRM1YCExy7xo5PXhjsdNMYTNGQG5O0vlptv2MJnYFm3tMegtbKQwRD5BVbCsyxs7Ycqqcwqr4oEdbNGf/cJ1aOKf4CI0+XeNReT1wIIHJYp4HbyCf+tgzu3rcUDpNNHdxIrTdtdt4jWv9Xxsm2QBAEBtcxmeZsPfFEZAT5Jt6YXZcp+ayQNNzGXQhZDVZX3ng0Nvgk6YFlsTHCsnQ0D/YcGqHJ5uZEKVKe5LZn9TQhGF7NLd2EVnR7lmyuB6FAIH4UZfG7+gIdHD1riPqTcgm/Y107AM2We9HjBb9GKzxadKouxsf6YZbxWP7t+tkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 14 Jun
 2024 00:55:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 00:55:54 +0000
Message-ID: <1c06a79c-e1dc-4798-9fce-3082597eee3a@intel.com>
Date: Thu, 13 Jun 2024 17:55:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/19] x86/resctrl: Consolidate monitoring related data
 from rdt_resource
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <8f73c9ec4c9999c262d9297d46a03209a8affe3f.1716552602.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8f73c9ec4c9999c262d9297d46a03209a8affe3f.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 3061fc46-889a-4307-7b6c-08dc8c0cbe66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NCt2aU9qUFFyaHNNejI1WHJ0RDlld050Z1VyRFZQQnlZVXgxMExXaXJrbVFE?=
 =?utf-8?B?WGlMaTFaOTJFVlNXZE4rZndaa1YwT3ZlWHF6V1BjT1YzM2ZEQ2dnL2FyR1ZT?=
 =?utf-8?B?blpXYWE4aWpiUTBrWVBZWC9sQUROWXBueTRHb0JZVFlOcnI3OGhqNmN5L0F4?=
 =?utf-8?B?WWN5dDR5OUdvcjFCZ21jYlN1UGg0Z21ycUZXR0V1YXIvYWJOeW9PeVFhTmtC?=
 =?utf-8?B?c2RtZ2ZuWTZoNngrTDhrVWRuQWVWYmFJNzRja2JZdDZRdU5NSXp3S2NDL2dK?=
 =?utf-8?B?ZlpMQTlyWWpnMUoyU2wvYmZzbHZ0SFUwUFkza1hXUnZ1V1A5NFFCMDh6cVFz?=
 =?utf-8?B?SXRGS3lWdTMrYUh3eWd1OTl5MG1tTndTanMrcVpkUnIva2x5bVQ2U1E4YmtK?=
 =?utf-8?B?LzhaN1JBNDI2NXRIWm5HcGI4VnZZQVQ1aUpuaUZhYUZNd09iV2ZIRlJxbEVK?=
 =?utf-8?B?dUNFZUVwRmpTUWFIWnVBOUFmNlEwM2FHWFg3NTcwb1dWWVlqR2k2SVA0dExu?=
 =?utf-8?B?TVAvbkx3OEgvWXYrZVYwV1lsSk9ROUdBeWg5OHlJbmpmdzJkbDc5S3REcURi?=
 =?utf-8?B?ZVB6T1FDOVRsb0hLKzNCVnUxWkpUSTdtWU1aNGlhRmdzRWM1aU9vencwUTQ4?=
 =?utf-8?B?Ly9hc0I3Q3pVeVJyd2FpYWRIdC9tT0VlMkVrYksya2JXeCs0TzJBNDR6TjZK?=
 =?utf-8?B?a1F4cWl1MHV3QlpRR2xUWEpzVC9obGloQUFLSmZCbTNpellUazlXbmowK05l?=
 =?utf-8?B?TURZU2N2Ry9lVk4xNllSK3JJS2N6U3loYWZTaGFaWkNFSlBCbWVKSXV0RHEw?=
 =?utf-8?B?Vm40R1pXWmFrWVVDTGwxeS9oTXJpNnNnT1ZGQUtiOVpSY2k2cXJTTHF4WUFT?=
 =?utf-8?B?dGNSMmRKS0FWUk5VcEUrQnRucldQY0sxL3pPeEhZcjRqMHRZcm83U0lsckdi?=
 =?utf-8?B?a29vWHZCMEt2UFc5L2VicTltWUVncTBJY01sZTNrWjhuY1dzUXNQQ1Fmc2wr?=
 =?utf-8?B?V1ZCVUJmbjNRc1FaZ0VhWnhVYmJNT245VmwyKzlhUjVDYm1uSk9wU2tLa3g2?=
 =?utf-8?B?cEE3VlcvcWEzVG1KV2VKOGI2NTY0dDkwbHlZQm1Dc0lrMTFCd2Vza3FPNk1N?=
 =?utf-8?B?U0NRSERYeGFGd0NYUitTVmFhUStLVzI5ZmhVTmltejZtdnBTcHdOenVYcGd0?=
 =?utf-8?B?cGh3a0tTenRjN2hTRjFyZktadWt3V0pvcXM1dXV4d1FPVlpoZVBuaU9wT01O?=
 =?utf-8?B?L0dqaEF2ZFk0eU5zUDQxNndITjBCcURYKzZQZzBHZXNGWk5RWGRXNlYxZmpW?=
 =?utf-8?B?Qy9Oa1JJaFdJb3g3YnlFM05hRm1hWlRlZHZ3Sk93d0czSEpRQWJPaDQ2RUhI?=
 =?utf-8?B?N0Z4OHI1M2lQTnJRTWRMYTU3MWo2WGg4REpvbXZ6dnFmZmpqSnZDSEFWdWtv?=
 =?utf-8?B?bVAxNDlJUm9KSjlhOHNLd29sMTMxd2IzeHFta2Fpa2trNktqcXlnemFUWlhJ?=
 =?utf-8?B?aGdmNnJwL05Ha2xTU0JjbmdKaTNTRW5ORVoxeCtwc3l4S3l0bElqN3FiV1dl?=
 =?utf-8?B?M0RZS09Rczh0M3FYN3dTWFdBOUJjS0QvNjl1WG1GREM0UDFLaG5jVUNadEh0?=
 =?utf-8?B?Y3dGVVpEKzNJRFRmenhGRGY2MTd4RGRSK2p1aWp3bldnWkNqQUxJcjdaNVFD?=
 =?utf-8?B?SVFJbkQzOWNESGFZOHIwLzhESXN2S2gyYUw3cHZhNkVLNU9PL2h1aUNFeUNW?=
 =?utf-8?Q?TlANhRpKMBfE6WntVG2H4/kidgELZ2DuJo/cAAe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVkVk5CQUJMMTNFTHlkbTZtM0lZWG9JZnFLdW5tSTJZUk5WWk41c0t1T0pS?=
 =?utf-8?B?eTJSaHF2SXJaTElEcEN1cVhsaVY4K09SY0pHZHhzS3I3enErL2pwVXAzcWFI?=
 =?utf-8?B?akVTVlp6RzUxUS9OcHhYL0FrRSthNFZzWXJLSWQzSGhBVlFwSHhDVEEvY2JG?=
 =?utf-8?B?Y0hUSEs3SEQ3Yy9VRWpLd01vSTBDVVZGL1lvV0huelRtQlZRZldiNGdWWDBC?=
 =?utf-8?B?ZENrVy9yZGFrU0lDMWRraFZwdTRYeDZhWHhsYU5aWWdEaExnaDI2Z2lyYnFk?=
 =?utf-8?B?YXVJbmVueHVWWDRzMEx4alJFV0ptU0IyWjFvTGNvK3crSVBxemw5bEdVYUtK?=
 =?utf-8?B?ayt1SzUrVUMxZDR2QS84VmdnNXcwR3dXZVpGWkRETWdrWlN6STVtUkZyN0hW?=
 =?utf-8?B?czdWNUNyVzZGclVCSGVhbnpubWxQYjlnWUlTU0lEbDVDMmlQWS9nTG10S0F6?=
 =?utf-8?B?ME9IQWhHSGJDRkJvYWVSZ3FBcm5zYXhic1llNmFiN2liSHNybWpHM0lmU1Z4?=
 =?utf-8?B?SVl1ZTNCbFYxeFY3WU5oRzBlUnc4SFFycCt1VklZNFBCVjJ2bVlqVzBweVhq?=
 =?utf-8?B?TC80SjZZeHU4V21jNHk2RU1scE1jVnlIUUdDZmFYOWdKR3lGaVZxWmJXUnh4?=
 =?utf-8?B?SkdTVDU0aURQMTBlcXlSZ3dpWEplWENCcUR0eE1ITitmMitjL0E1OXRRbjYw?=
 =?utf-8?B?dWJGSkNsem10YlQ1TUpMN2l6QjFEaDlxUVF6dHBGRThVZWJMTUhXMXBCd0xW?=
 =?utf-8?B?RjBRbjdXZjRFV0YrOXVrci9wZVdXM3orb0loSWxXWnB0VEIxTnZuVk55c1lt?=
 =?utf-8?B?VEQyZytYY3AySklqeHVoUks0ak9iWjdKQzlVU1Vka2xkY1FhUnprTzRZM3Jp?=
 =?utf-8?B?NENGaVk5YTh2MkpsUjJVVE83UnN1TC94dVVjYTgwWVpPLy9oNUhPQjhyZUxo?=
 =?utf-8?B?S1VOMVE4cytLSkhsSnlYOEQxZWNWRmdkQ3AyaWxudTJkNmRJWnVybFgySUZW?=
 =?utf-8?B?MEppWHJReFlueE9wUUhxdjdYaC9DR054WXp0MHYwTkxNcXBOUHBDWVFLNkRY?=
 =?utf-8?B?NDF3WVgvVEJGNHRtUlMwQ3VWSlo4ZWJENlpXaWFzbVd3Q3VQdDdUdEtXZ1pW?=
 =?utf-8?B?bzlickFsK1BySm5tVVR6YnhIeng3d0Z4Qjdnc1hCWE9XUVcxSnNDSldBbEt3?=
 =?utf-8?B?d3JKenBDYXJZZU5iV1RKMWlNVy9WVDdZdnh4U29GdENVL3ppZGltUlZjQmh1?=
 =?utf-8?B?QURpVUNqTUFHUEowd3ZQdDE3WERZb242blR0OTZUZjE2MTdmb3hXdDQ1QjBM?=
 =?utf-8?B?dHdRSDVpZGt3ZXZhLzVjUkdiTVQzSTVsL2hIZU5qWEZvMFFDVWVNM2xDNnpP?=
 =?utf-8?B?MCswbXk1cHJLb3krU1NsazNkT2JMYmFZK1RHanRnUmtCaHBMUGlBVSt0bnZD?=
 =?utf-8?B?WUpxUStKSmZ2bVhJMWQwVlhTVENWM2NqVmtmaE5aUk9mYW1HWWNPdFdJdzli?=
 =?utf-8?B?d3JhT1NISnIzSENyTGt6Wmx6T1dXbEpNVTBxYnpKOTRIWUUyRXRvZTZFMXRH?=
 =?utf-8?B?T2N2S1U5WlNldHdpSHVmc0RFQVA0eFl3SnMzTHV0SDEzTXpuL1p4cmlGYUhZ?=
 =?utf-8?B?TFpLS0pjd2tTSnBNcFFBejhOVnJpdUUrem05eFdJSlRtMEdvdjBiNUx1S0tY?=
 =?utf-8?B?c3lvd084MndWU3FUaTJhQW5JVG02TzI3MmladnpqU1pTd3UvdUFaZmwzdWhS?=
 =?utf-8?B?SlYrcTMwSktOc1ZmSFV1aS9MSHduNVd5bjcvcXlzVTFiTHVRK1UvVjFMbTB4?=
 =?utf-8?B?dExtZ0dZb21LRG1ic1NNTXBHV25uWmxRRUVSVVhMRDcvU25wY3pPNXpNMzI3?=
 =?utf-8?B?K3hOb3MwSnhwd05tSE11ZTBWbWRicFVDb21TbzZIL3J2UE9iUnBWWXdyVVE1?=
 =?utf-8?B?OHJHUFhFY0hqeWpMelh3SUpLWm5GRE1kaG9YQzdzN2RsdkkwOXVEdTU1dXdm?=
 =?utf-8?B?TlFMTU1EZ1RMT3VMclZHS2crUEJ0SmcrU1dKVEhBR05UcFU1VDhZalJWSHRM?=
 =?utf-8?B?blJQZWJNOVc0cG9ueTQ0Q0NYVUN6WDVaeXhuN1E4OUpMOVVOUnpBRjAxVC9u?=
 =?utf-8?B?dm14R1U5UEVWdTVNNnd4blJDb1ROUlMvclBscGN2S2N1RGJhR2pGdDIyWUNB?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3061fc46-889a-4307-7b6c-08dc8c0cbe66
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 00:55:54.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaOFrronT/n6piBFp8hfrZNKrvKpQSC1XQN0PMTrlT9HM+McrA5mM9hFjnGQBFnTtY/cqyxQfZxSn74WeVa+zOGjha7+hEOYhjvzNS6yfFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> Consolidate all the data related to monitoring into separate structure
> for better readability.

This needs a better motivation because "better readability" is subjective.
You can motivate this work by noting that this is re-organization in preparation
for more monitoring specific properties that will clobber the existing resource
struct more. To support this organization the pattern of the cache allocation
and memory bandwidth allocation features that consolidate the feature specific
properties into a struct is followed.

Reinette

