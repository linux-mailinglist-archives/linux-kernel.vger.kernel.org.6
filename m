Return-Path: <linux-kernel+bounces-251794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62279309EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1CA1C209EE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581E7344F;
	Sun, 14 Jul 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgXlwqyW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F314433CD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720959985; cv=fail; b=cSrLj6ysjctu81DJz2FVxx2SSbh6Ls0TM5vAeH1TsoyfqzoubzsdrFn2uCdYfX6Nuvt3fSL4R9jHHU5/sozVrXZP7KGnhPlBpktAKj2ZCL/RrKeYLJ//vb//to5+kNqCUAGnpzjZbUyjionqRM55G4uoC3G34m3oTX4eNoJLuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720959985; c=relaxed/simple;
	bh=WfiB09Qsy61CqGuZe1gNYPJbm1CVAPtjvGJDTCsTIg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYuZq+zRdlwR8iYaFjMmVxDOJlLWOwOTvEmq0dtYiyiEQKcV4FfcHh4OHVwCbTHz+QBfIOFEzACw9N0WWGL8YBPtJW9/o+W1ywZRZ3jFoq92T88GsIQyjH7Rdd+ngldUI7EHay42bUMYoLS5JrywlPtshVxfSoKLuSqvL4ueo/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgXlwqyW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720959983; x=1752495983;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WfiB09Qsy61CqGuZe1gNYPJbm1CVAPtjvGJDTCsTIg4=;
  b=JgXlwqyWNwrv1qkcIZkhna9dR9t0/3Lv4m2uVGs/EI87Np8u7IAgZm+V
   88Ho7tjW4YKIy0B2JuYUh6NWQJwFW2wupUjXKFdQMcanE/YW8jfPqPHJ+
   yKM+P2b2AfTVm4wFEpFTFGBYOBYXjKl/g18U3z/nJNOU56CHdItDe8nZr
   92v6HC1KOVzmHO+Pa5ux8o6ho8CEfGt924zQzk4x3rgERyYfFFx1EmR6z
   0feXN/pgtrLIfY4IztyzeugaLk3nxoq9NYdJsd1tgA34z3H+KIZVC/xe9
   MS6E/JC4Zb8pkdH26KFPguXizhvnCJj3m/OCefeUC/2KSB1NKdEueaaDK
   Q==;
X-CSE-ConnectionGUID: TgyXqW4dSji0q2oJ3G74HA==
X-CSE-MsgGUID: WCVh/FrIRNGh5FZJThbjDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="22215463"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="22215463"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 05:26:23 -0700
X-CSE-ConnectionGUID: swKwAUW7RraKrR91GENu7Q==
X-CSE-MsgGUID: 9pdWz909RN2k9fxAYCYi+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="49081611"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 05:26:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 05:26:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 05:26:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 05:26:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 05:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9W90iTA9xghpcr1TJ/fqa+4LhDSMAWY4UF3w1l4ikTrG6YUXQk8sK885dU225/vlk/p7+CZL92z7LiWstQAc7187yhPKJWwE+62rAFanDa+29A0fieIAW670jqqP3AOSGxCpiL3gViL+uwqOGknLtG0f+I00xkFxDiFgpngDUej8d1T+z2AdJFO7yjwBF5wbnHptiXYZUDWCzuzyrocFnkiB14wZeY2FSltu+NvOAPQlsajcD0ohcNK/8g47cYRmJELLK52vk5Xc/2QViKCcWa6J4mTQRZ6ACM5PG7xTafgOlj+Xjwgw0mFNiXDQG9AgY1CkDH1lZYqlDHriDRQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAzWF9rYwHg1x+s/tkiy4tL9yvqjfLHNz0hXUciCH4w=;
 b=Zr1SlsVdOW0QiCxjjZDuOC7d7PlzC8dDIKlbdeYEyjWOtWkU0GGa0jlqugAW9cOkJxXA5ODNT779nBdXVM1MMESJLhH9WBmcRXVbss/m7m4Yu+OPdeycJEa12OmvODipRKYgYfeWVLvdUOSwi3Bfp+OoYgbjxf/ZUNfYieTE2MeLJrWUIyq7pDebUeg9TkowpQC6rAc1CrrVpSxf+IUxg3ZBMXeiOEiLWs49TN81n7hGXvmw1NwWb2hw3MQi+TdjoKKi+02ItEG1lX90V4Xfg5grjRqOubtNxL9y0ZXcAf7JjVG+DuyQGjGMPTF7q+szyV+ihFqQotsaFdQcQMeNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sun, 14 Jul
 2024 12:26:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 12:26:20 +0000
Date: Sun, 14 Jul 2024 20:26:08 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Yu Zhao <yuzhao@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song
	<muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, "Frank van der
 Linden" <fvdl@google.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu
	<peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
Message-ID: <ZpPD4Mz3t5xT87aN@xsang-OptiPlex-9020>
References: <202407091001.1250ad4a-oliver.sang@intel.com>
 <CAOUHufYdGbgnqNprKVUH8woMR_R5Wcc=281vcmm3+NRO-=+-jw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYdGbgnqNprKVUH8woMR_R5Wcc=281vcmm3+NRO-=+-jw@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: b9786a0a-9163-44d5-f066-08dca4002a71
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFZ0TUZPOGNxdlIwdzhlSDliU21Nb285UURiOWlTc0I2RFNWOFQ4blJmL01a?=
 =?utf-8?B?ejlBbXFxbVV2aVZVTk5yMGJDVWYxR2R2VHkzY2xvSDFNQzBSZGtzVWhBMnhz?=
 =?utf-8?B?MlZlN29mM2piYVpneDFGQUpYbVg1VURBTWlrZy9CV0NlREhjenBrTENMMm1B?=
 =?utf-8?B?dEVkbU16ZDgwMUhLNDAyVmlNQUVvRGF2RFllUUhQeG1UVWZVdUpOdDNaWk1j?=
 =?utf-8?B?TzZvWC9VUG9aUFJQTDhFMnNaWGJ1N1QzRm52MHJVUXo3ZnNtTk83b0lOcmtX?=
 =?utf-8?B?MW1CaC9kc0JocEdlS3g4cFdCaFRhYkp0Mi9WU3JYR1cxUGl5cTgySlBsZ3Mr?=
 =?utf-8?B?T3lRNGNGK2hKU1N0cGlFcmRydnpKL2Y3N0JCS3dBS1IwY0NuUnpSU1o5Zkxv?=
 =?utf-8?B?OGxRZjBneWlnZ0NTMU1IQ08xZlN6TEhQYlRSQ0Zjb3Y1WmlPWWdlT3h2aU8x?=
 =?utf-8?B?eWlmR2JKdkZhcEpTdnl1TGx5cjJlb0FtMHVXZUFtTHI0cEs0YW1vclRPWmJB?=
 =?utf-8?B?ZHNZNzZrbElRNzlOYmdzK0lNSXlzSTgxdlUyZTg2SmRmbnErMGZic0F5L3BD?=
 =?utf-8?B?ODhwK3dhOGFFSUZleitDcG5TODcrNEFneWd1NFR1dklzWFdWdjNTQ1drQWNM?=
 =?utf-8?B?eS9FeWZrak1aRFVTaUsrT2dzSmQ3QWYxU1NKNDZuRG00MExadzUvNGVoc3Bq?=
 =?utf-8?B?clhoUnBWMDFDUE1uejV1QmZib2ZJRWhIdm85NWZsR1orT0RXcWJlSHZFYVp2?=
 =?utf-8?B?MlNzWWdUa1o1dEFCWms0N1haSk5qM3Z4Tkk4RXJYN254ZTEvMXFrZDI2MGs1?=
 =?utf-8?B?dmkycFRveDFhT3ptK2p6NGdsOGVLL0R0L01DN3p2a3h4ZGsyQWNnMGhBdlVX?=
 =?utf-8?B?Rm1ZOUV2ekNpYWdkeWdRK0Y5WC9KVE03S1grVmZ5c1M3WHdmVC9wcXRoVXJM?=
 =?utf-8?B?TDM2cW1BWTJ2UXpyMEltSkxiQ1FzMWJEMjlEMmY1bFdnd2lCR3AyS21ZekJN?=
 =?utf-8?B?OFgvOUJBTnljTlgxSjN5aUFiVS9OWXNyWkVoWW5VMUs2VVdoQTV4UC82NGsx?=
 =?utf-8?B?eklwYXRaTTFXalhYS3hIZ0F4T0tCNC84L1FaQmlGNEViZXg5NkFlekhzVHJx?=
 =?utf-8?B?akFWTmxHSGZWd2ZjSE5KRFd6NlRUbmk4R05jclJNaFowdVlTVHAwRnVmL1U4?=
 =?utf-8?B?S1dTZFdhWERoZGNpUk1QVXJEY1NPYzlFKzhnNEduNzhuOTU1VmR3MHZCSFlq?=
 =?utf-8?B?a3dwUW5yQ0NrcENYR094bkN0M3dEY0V3Y1N4R2dxZFZMSnBnbi94Zmh4dTBB?=
 =?utf-8?B?bEZqRkJQM0VxeVlGUXlNVVU4N0NQSDZEd21aWmg2Zkorbk95OGY0Z1dxTk8y?=
 =?utf-8?B?ZWtTZEhLQkNYMll4aXFwRG8zUnhXdk9hZ093am5EVXV6SEljRmJ4YkR2T2Fn?=
 =?utf-8?B?cjRSYThMRGF3UHVCQy9IN284QTFTSElKWWhlY1dCQlRhbTVoaWVENE54QmZK?=
 =?utf-8?B?bjk0U3VkU3UyZDJPZVNXb09sRGlnemphS1U2LzdLYnR2cnFRTGQzSkIzT1hX?=
 =?utf-8?B?aUIxU1ZZU1J5NUxiRWtyeUZ0UnI3T3dNdGtCcy9TTTJrdmxTUlZZampneHI3?=
 =?utf-8?B?OStabmZTMVo1TWw2NXh5R1lCc1prQmR3djN2SzhwMFdzUUNVRHFqWUtscVp6?=
 =?utf-8?B?RTlJL3dua2JrdEM4SGRvVWljdUwwZ3M0dUtGRnZTTGZUYlFkRHQ4V2grRmFp?=
 =?utf-8?B?REcyNVpTOUV1UmRJbWkwbEF5Y29WZFc0bStIYlo4MitJdVJrYzYyK0Robk5X?=
 =?utf-8?B?RS83a1IvR1RIMnQrOWRvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWw4TTZndXJ0ck1RaEUvais4MkhlaVdCTHhVUXNkRWtWV2MyYkc4ajZXR3lS?=
 =?utf-8?B?aTFKa2hydHNXS0R1NmZLVDlIMGQwKy9qcUNEb25wdU9vckNuWXhFa1FSUzQ3?=
 =?utf-8?B?by9pU1VxVWZrM1plNTRzL3AyVkllMzl4UzZqWndBN2NSNVlNck1VVFFCanls?=
 =?utf-8?B?Y3p1M1NUdkVaTW5ldDE1NHFWL2x2YjVicHp5eGtDV2djYTZZOHhCTC9qRFFP?=
 =?utf-8?B?aFhsaDB0TlBCOCtWT0tLYWpJN0dNRjM4TDFMZll3Kyt1VkdBWjZqdUlIMll6?=
 =?utf-8?B?U3gvOWp6TmVodTVVVXVLc0ZpMXlrUFY1dmhUMmJTY09EazJONlFla3hHc21m?=
 =?utf-8?B?cnl0MU5NOXptcjh3ZmVQSy9zWVlzbEg0SXpicXFBZnJOdVA4V0ZJY1VRaUtF?=
 =?utf-8?B?SHNoUlltQkMxcmVJWkVlTktzM3phR1Vydkd3ejQ1MENSV3h6S3d5S0VHeE9S?=
 =?utf-8?B?TGg5UGY3V2cxdWI2YjY1ald0SzhhMTdjUUd6dmcxZGk0bk1sbG9zSXdSQVhJ?=
 =?utf-8?B?MS9YR05nbGR1ZE9lU2p5TnIxZDlzNjk4ZkVzV054MDBhcldRd2tadm85RWpl?=
 =?utf-8?B?dnhNYXJhei95enlXOE5WY2FJYmNpTW1CaHBhYWEzSTVkZGRXK0tDNTV2dkZt?=
 =?utf-8?B?M2h6b2tKdGIxNU8yUFRtZVJXNTk4b2JOd0xFTzV5YmNYd2wzMlZDMXduc0JY?=
 =?utf-8?B?SGxPamJ2QzB2V1luTEpkbUt2VG1JZUE2UFJJb3FjYUk3b2JIUnB0VTVXR3l6?=
 =?utf-8?B?WWVONzVxY1hESWVlTU5iWlJ2M2REMHBteG5GaUp2SzRqakZGajhvMEhpc3Fm?=
 =?utf-8?B?U3pzeEs2N05uVExWYkxwUU9XMmRLWVpMRE5adlRHV0cwOFJlNEJuc1E5US9T?=
 =?utf-8?B?cHp2azVWRXEybzgzWXpYVE1qZWVWWElQc3lvRFBRYU02ZTdZQktIcGQ2bnBs?=
 =?utf-8?B?RWx1UUYxbFY2b3UwQTNibHdCQ0FLeCtIemlwZndkQSt1cEVaaVovZEVIV05v?=
 =?utf-8?B?WTNkSXJPMEtKdkpEdjV0aU9xUmxZNTJlN0NCYWk5R2xjcWRicFNQZGp4eHRR?=
 =?utf-8?B?Q2MzTUdJdTVmRzdLOWpXMFR2SWhXRk94YVVqTDIxV2Y2djh1dHBCai8vWWdE?=
 =?utf-8?B?M0UzamVseTVWclBNUFd6K3dWLzBDVWlncjEyZU1JWk96RjhDeHhVZVdPK2xW?=
 =?utf-8?B?Ykg3RW5uTlFvNGc4VEtOZU1QY2E1c2JSVUphY3JrMDF0ZC9GNXo5WkRMcFBU?=
 =?utf-8?B?b0Z6MDlqQlBNNHoyNkpKMHFSVjdIVDFhQ0NjeGdDdlVsVTlkK3RpL1hucnhp?=
 =?utf-8?B?bE9aUjYrcUFqQ1VDOVdHZ1JRZGgyU25XalZUcUdoS2lCRnBzUGswWElWR1gy?=
 =?utf-8?B?Y3BiVkZhVHN6dE9lUHN2dzkxZUxYeGp5d0dwd3BpRXJHakxVRFZNVW1jSlM1?=
 =?utf-8?B?YThPOEpyVndpVzVFRHU0ZUJtQW13cVJhMTVqU3Z2eGdNUlF0KzVUMEJCalFt?=
 =?utf-8?B?Ylhlb2R1WFpjWGxLT1NnNjNtWmpxSGN3cXhkcktvcUFzWU0yWDhWcUtzb0x3?=
 =?utf-8?B?c0dvY29LamtkUEZNOGJZalJ0Q2RVblRYaTV4VFc2aXpWR2tjU2NnOE5Fczls?=
 =?utf-8?B?ZUNBdEtnREN5SWpQSnZ5ZDMwUFFVUUlIdk56dzFEd2lXU2lmem04Y1NraHgw?=
 =?utf-8?B?cnp3azhjLysvdTN5am5TMG1kYy96a0tLdTFLSGpxUTJmYWZRZ3dNVkUrbjFa?=
 =?utf-8?B?MUNZR2REOU5NTTlVeVE1cVFRclRVS2pYa3g3NVVETmNlUGlqcE5haGVoSmxE?=
 =?utf-8?B?M1J5YWs2ODExWmJ3Z2tpVkRSdThwbm55ek5iQnhlZjk3aVIxKzNYRkhZbVRp?=
 =?utf-8?B?R08rY3FLVGFYTFNTS2J0QXBUdjNUSlRxYkNQckN5c3JmMG0xVFZvaSs5SGNP?=
 =?utf-8?B?YUZ0U0JnS1ZXOWkwUzVnYmNieHVmdk5wNXZubGVGR3I4SnJ4NVhhdVZCYVVW?=
 =?utf-8?B?bmtWd3VVWmRCOEcycFZ1bjRHM1JhbW5tb3NHaGx5aVQ1aGZJL3B0TnlTRXNL?=
 =?utf-8?B?Nkdna2x2WTRQcmh3L0NWbHJMbmdvQkJEWmlIRWZIL2JZbjdNbFpMbEhmYkFo?=
 =?utf-8?B?Z1FKbGcrZ3VhS01CakRCRi9LWjIzVkszQXJLZ2thUmJBVWlQS2pEZ24xWmk3?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9786a0a-9163-44d5-f066-08dca4002a71
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 12:26:19.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LGlUDRAHUCPI9PuLR8Hxq4vqtVut07CMFoWaJp+cPASHC5m5JbDyuUf0ZofRlNg/+6DM0jBgPhnJpsfyFDa/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-OriginatorOrg: intel.com

hi, Yu Zhao,

On Wed, Jul 10, 2024 at 12:22:40AM -0600, Yu Zhao wrote:
> On Mon, Jul 8, 2024 at 11:11 PM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > Hello,
> >
> > kernel test robot noticed a -34.3% regression of vm-scalability.throughput on:
> >
> >
> > commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
> 
> This is likely caused by synchronize_rcu() wandering into the
> allocation path. I'll patch that up soon.
> 

we noticed this commit has already been merged into mainline

[bd225530a4c717714722c3731442b78954c765b3] mm/hugetlb_vmemmap: fix race with speculative PFN walkers
branch: linus/master

and the regression still exists in our tests. do you want us to test your
patch? Thanks!

