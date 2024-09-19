Return-Path: <linux-kernel+bounces-333745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C611A97CD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41DCB229B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE7A1A256F;
	Thu, 19 Sep 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C56EChXZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC455198A33;
	Thu, 19 Sep 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767794; cv=fail; b=jSyocUM6zirXLRhR1yycxhMWBe3yV6OhqEqz7GlUFLkkhjODgyBkiAq9Y/rLlOCYDQVEatJgqfubpwunepMPVtg8Rb/9ie08pbKvEGkiUq9l9N9Yf8irhi9KVYj5vKPXweuRXOjHSa+PI4vqRecTHLjl7DRDDt36n+n8jJYSrmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767794; c=relaxed/simple;
	bh=ycgcYRudcCBCCT63xHA8YKh7L25x5ZamGkxItwHKCgM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p0xCxdK9MLXQX5cOUO2fPMXJkA+4uxzYR71XQvWGJhNKKcuiYDg/gRblZrs1Zr2kKqbWuN5Muky6cwKBTjjDczylKil/4r84DF/oVD29ODjn98WpX8AcJUMI9DFUfzN3/vajsjuGFzSKGz8wVSg8th+42uCRXPN44fSfkImI0nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C56EChXZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726767793; x=1758303793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ycgcYRudcCBCCT63xHA8YKh7L25x5ZamGkxItwHKCgM=;
  b=C56EChXZfodT/v5k/4NwXYpX/rbivZrmj8WmegGh5cwdwZhH66RH6uuf
   4Oh5I4qgPP2AVkl5eJS5hkQMwvvGwV3wJkmOwlnvpPKgK7Uhx9eOC+vNL
   TfUT0XcT27KqwADXHYKhRKVKZEzjYrYmYJ+HBcLgMeqo2JPbkyME5unVc
   4/q5AMPFStNCB0Xk0SP0rQpD1J/6L8mEhd60DBa+vF4OpyAzUeI70mYiX
   rn3eC/a6tBHVUEA0yZntsWoxeLgOUKc82+YYO9GiFygu4AN5ghnoCOYkP
   itskJz0fTSUfCiNukXAzixcvlTOHvJLk+ANmvzc2SlbAs/PGpHi8DYGO7
   Q==;
X-CSE-ConnectionGUID: r6tJo8fGTM6+Dyo7MMGwQg==
X-CSE-MsgGUID: JRYXDQ9nQKOjMnvmJPDO4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43266010"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="43266010"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:43:11 -0700
X-CSE-ConnectionGUID: 2D21VZFERhW4CugNkipsgw==
X-CSE-MsgGUID: o8nrKLUbRduHqZebIFmD0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="107486302"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:43:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:43:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:43:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:43:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyH640buzVQQsrdib37Jdz5/29n2PjdxiQQiIcdGYE2pOKwWCt+6gBOBsD0PGkDxqevkjlwXxPY97iv8319qojqMdSRh3bGyYSeJwTpJ6yyWyPKP7ga4/f4ha/EuzfnC+WDl+30QFRNOApk1t2qYNz7Gr/x2Bx39lJrnViIaqJN9V8B+QzbJnQOVo+qpbIdFa6BYjF/xsN6vyJWJPoR1vooTwZ0cGFD8eI6hkoxwfdrtp/BhukAG1t7aV2KMWkXvsN+zJ7dmdo548H2cJvfLY22s+oMpk+vNznj7NZNJt3bHnHP4nUmriGF8fH1GTi/4hGltaTRCqUzNYvgLR4sxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGmxzorn/y5wZsOIfcLw1m8oOKuP1nXOjjMugEV8SdM=;
 b=pLH/1pespjCPxKsb2syA9R9excozLWYOrbHCIa/yZLfTbjiy9+e5ZdQyjZOYDudt1Tzvuu3IsPYZIdNbxgs2v2sXWFqACSyCkiA2x+CjG8Pr52sUWyET9ry+RzLc6TnrO93+t+I29dY16MlRqvhX7oke6rtrw7G6p3z89hAd4R6Qvg+nEa/BviW7mQupeeMMXOYlkFRrmr6OR0eZUTtzPV5pzwKNXJvvkvGgcJ4G+e+e9iqmsfixAFsvE/AwyjKxUBBla4srUvC7Rcdre8cqi5plHleMEFMpisqM14pMFjAt3yG4wtcmTQyxgWGYymuRg12/qs0VbO4YFiF8hRTbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4934.namprd11.prod.outlook.com (2603:10b6:510:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Thu, 19 Sep
 2024 17:43:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:43:07 +0000
Message-ID: <baba42e8-022d-4140-9c4c-256fc6b44765@intel.com>
Date: Thu, 19 Sep 2024 10:43:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/24] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <d5687ef178320866b823445176b10a411e0e5ede.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d5687ef178320866b823445176b10a411e0e5ede.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0363.namprd04.prod.outlook.com
 (2603:10b6:303:81::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 209e8f6b-58c3-4be2-9bb5-08dcd8d28548
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em1xVjJEUGdkTTZxZklGNG9yR2VqK0g2NXloNnRmNTA0TGcvWm1rT2FzWTYy?=
 =?utf-8?B?VEhaWXJyaXhnaHRJMGd4dTNUL2pQS0Z0MXlmbTRiQkVvMkNUNlpkSU9SR0g1?=
 =?utf-8?B?dWgrMTVNSnZabGY4SHRQY3ErTnVBejRwcEVtTU53R3YyT1NuSkRqaUttUldQ?=
 =?utf-8?B?RFQyZTd3a2pRWlM3djRzOVRvVmFDd01ZaE5jMytlampqK28xay8xTVNpUzFj?=
 =?utf-8?B?OS9ZSFNMWTlVSWFoaExZUXl2eXdWYlp4bEpKVXFaelNJMkRhdFh4ZktvK1po?=
 =?utf-8?B?UHpFc1IyaHNEejAwaGN0OXNwVlpaeFpXdUF1V0RodTZWMllXMFdhZ0RnbXZu?=
 =?utf-8?B?S0xIRUoxVEl5ZjZNZ2U1WEFmOUNHQ0U3dmRNYUhId2JLV3I2OGdqVGNkNUJV?=
 =?utf-8?B?UXJzNk45ZDBLRUYzcjRaUEhXejRvUEJPbDlsVUxUQXViZ2lTdUlES0IxK2lx?=
 =?utf-8?B?YWJCTlREaWVqMGdRandPTmNuM2ppeWRvMUp4ZGhUMTlucDBoZmZRZUt2OE5m?=
 =?utf-8?B?WE1lR0JCSitJWFlyOGp5Z0lCZitteDZWbVdURGZvblZIc2UzR1pId0puRCta?=
 =?utf-8?B?T21pbFdBekdPWXkyU1ZZaSs5M0I3OGdRU1l6aXByVzVMM0l1aTgxLy92dWow?=
 =?utf-8?B?MndxMUFVZklPdjZDMW9GaEV2RFNIb2IyY2UrWUFhYkVCVVVwMHBoSWJKaStF?=
 =?utf-8?B?Y3c0cFY1dFRSN0QvWENUSEFheDRpRVhMZTVPdk1DTkFWc3czenA1NFBvY1dS?=
 =?utf-8?B?QTNkM2lVY0hCKzkrOE1SbmdjUk5kaWd1Zm1qNVFseXpJRm5IYlRBajBFQkEv?=
 =?utf-8?B?L0ptZmdzSTQxdU81TVVaTCtkUnl5SndHSE9YL1pYT0VBM3RlUko4Sm1ZbjZo?=
 =?utf-8?B?T2ZyQ2ZnV09vWUx3WS9NeStDSjhNc0Mwd1FHaWJ6ZlFFRkVXOURwQUdyR1Vr?=
 =?utf-8?B?TXhHUko3TzRjN3FOWXd6TEV0akZlMWVDM3VoSDVNSEJ4eVpPSE84OWl4RWRx?=
 =?utf-8?B?VHFGRThCVjkwNllQSXhWb3czdVBrM0VDUThkR3dZT0djclZOQWgrQ3E5MHdQ?=
 =?utf-8?B?bld4MTFDRDRSdTkwV242MEw1YldQNmhySm1rTlRXMXBzN3IxdTBwbWdrSGNa?=
 =?utf-8?B?ZEQxQ2NhWDVOemlnYmpQVmlycjd0aEtFWDh5QWFrVEJ3STN6WHdnTWt0cmFM?=
 =?utf-8?B?VUQvT2ZzaFJoVTVsS1hIek9BQnd1MmZUSGVWcmIrVkpNaDVzUzAzQzNoSkJO?=
 =?utf-8?B?MlBSc2dLYVBOcHVsR1RMVjNzZm1xOWgrcGJBc2FQaFlxY3RDT2dHWWEwWkoy?=
 =?utf-8?B?V3ZyeTFkMzNmaEJDQjR6ZHpBVjVCSnBweVlBQlpsWi9RRkRJUHV5Znl2b1NB?=
 =?utf-8?B?c0RGdjFXdWtoWmkvcUswRnk5dUlHdGY5SG5vNEtWeXBPaythb2NNOUgrVmxT?=
 =?utf-8?B?UmpiQncvMkN3cnFiMUkvTWRjVGVnVlRuNGtVeXlOa1ZkNVN3VzVaSUVEQjQ2?=
 =?utf-8?B?WWVxcSttVzErZXJPSDgrU1ZERy9YTkJ2Y2wrK29GMTlKMFdVY29mK09remU0?=
 =?utf-8?B?aXdXS0thR0tKbDN0dFY1SnlLeTVxT2w4UWJzQ2JKaHVibnBseTlNNGRIYmtF?=
 =?utf-8?B?QnpReVhoTDE4aHd3cldwVEw5RENWWFhiS3hyTDRIbEVqcEhmSi9LNjFweS9j?=
 =?utf-8?B?c1lPVU9QL05wQmRySWREWHJ5cXJTbkpqQjBBcHJMQUc4Z2lYK2FISnFpMFZ1?=
 =?utf-8?B?Vmw0WWl2WWdOYml2VDUzYUZYdDVQOW5rV3p4elYyRy8vT3RPZ0FpNmlFcW1i?=
 =?utf-8?B?VlQ4Q1Q2d1JUcWdDLy9Tdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5BVGFoMzV2WmZsKzREQ0dCMFYvbFFUYXRidmpscjdtdHdRb0loOFp6c216?=
 =?utf-8?B?RjNOZkRGcGlnRUxIK3JTV0RRTlY5d2ZQdk1LY09oaDh3eTJaM1dvNG54bWc2?=
 =?utf-8?B?WmcrNFJ4UDROdUZJSjJmdGFpTzFaU3h1Y0lwQzV5MWhZRXNRN00xUU1zcU9O?=
 =?utf-8?B?SGI4U2N0Ukkza29mbXQ4RmZHQnpRN05ncDE2a2FHTVlmTmRTdDYyb2tBQWR5?=
 =?utf-8?B?eHhzbkNTL2J3RXUxUC9GWlVHV1VPQ0pvVysya05zYXdXRFJpd0dJTWNwTENa?=
 =?utf-8?B?Tk5SN3ZvSzNBTHdlcENHUW4wc0I2U01oV3Q5eEhjZTlMUldBaFRLbHpsNWx0?=
 =?utf-8?B?T2VoWGNZZTBTTlFuanhUVC9XSE45eWJwb2M2dW03cEFCZWhXNEhMT09uZ1VU?=
 =?utf-8?B?N1ZUNUFoREJhWnROVUN3RHJLN2J6bjRpUUtCZ2FuTlVua2xTNkVucytqZ0M1?=
 =?utf-8?B?cW85S2xrQnhBRnVaZldZKy9jV1NPL2JNcDZSeEtHYVJadGZIL21sTEU5RDIy?=
 =?utf-8?B?Y2dSWVRtdEkwWkRpNm0vNFFoUDM2NzkweTV2Z3c1ZDZvdFlLdHRrZ1NiQlkv?=
 =?utf-8?B?YUJyYVI4N0NtQ1dXREZrN1ZySXZ6SWNYdFY5emN2Y2tXRVVadnBvOVN4ZWdR?=
 =?utf-8?B?MEs2UGQvWkJGcUFlQzMzdXpOenY5Sk1TajlVaGdTUmpoQWtKbXo3K05UNGQ2?=
 =?utf-8?B?Y283K05JUUZZMXRKdFh5ZEtQaDQxbTNiQTkxM0hkSCs3cERnT2p4RWtNM3I1?=
 =?utf-8?B?ckN5bkhOSlVKWDZJVkhqZGUwSlkrM0FHZW1iR2QzNElraHV4MzB6alVJcFkw?=
 =?utf-8?B?YURzNjdMejNWdktBUzk3dlJaT1E2b0I4RXliNzZkck1qSlVPRXY2QTJoMUk4?=
 =?utf-8?B?bjhUVlpmQlVEQVdtSEgwbGJTL1czMnMrcEh4cmI4aitvaWVCdm9vSU5tckFW?=
 =?utf-8?B?WGdSaGFrUjlXbjdWYmRvNGRhMC9YNHhCNnI3YnljL3BsREovQllob2tHQXFl?=
 =?utf-8?B?NVJKamE4WnZHdE9mQ0lsaHl4MklIWkxPZFRWeTVQY2xKMzN3T1RtT0Fmc1N4?=
 =?utf-8?B?R1AyOTd5ZTU0VWhQZWtEa2tBWkZXbzJDdW1wSkIrOWlpSkRKYkxxVllQT2RC?=
 =?utf-8?B?dTlob2p1am9VR0xhYjdmZ2VzY3hFcUZVZ0UxV25RNnUwZ1B3NXpOY0ZtMVVs?=
 =?utf-8?B?cit1SFRPVzJtUXJybS93RCtOSUlHLzJ3KzZxWVY0T085NVFPR2Vldkd2bG0x?=
 =?utf-8?B?N3lWakluaXYvQTRadDMwbzRFQnJWaFozdDRNdkJrMXNqWm84UitabWdxOHNN?=
 =?utf-8?B?OFFqVmMrOWlUUVRaZzhLMGNwekdmMy82bTNQU2VROWEwdS8wNVpQNUtIZmkw?=
 =?utf-8?B?TEx3cmVWcm4zaUtFNVpxdmhRRHlwVUhuY0RkUFVwOE1HcCsxek9VRC9WNjl3?=
 =?utf-8?B?OHhHU2czT3ppNnhTRGhqUHRqenJyVW00MjJhMWx1TWl4NGJCREpZSWNHUk1l?=
 =?utf-8?B?TkNrTnF4VEtvMlpNMEF0SWlnT0ZYUm54VWRvaVBGS3RoZEFyNmp6M3RXK2JR?=
 =?utf-8?B?MmVyRk9zR1d0RWNFeTFoRjlxczhPcVFvaUtwb3VRMUdSUyt5YlJXWkZCUk0z?=
 =?utf-8?B?Wmk2ZERFZHp2STFpeldrN1Q3bEtXSU9KYitFczV5a0JMbVZ3R3ZjRmtyY2pl?=
 =?utf-8?B?YndvRGd5QWRiSEk2cEtJYUYxV0huSWN6SWpyYWg5MXVYT3NLZllCZVNUQWZw?=
 =?utf-8?B?R2RYNWtJWGtzc1V1SWNoWTN6d1VpVXFPTitpV3RQazdHNUNSNXcxUDgxa0tB?=
 =?utf-8?B?MDZpcy8rSjd6UU01bXlFSVFSOVBPamVLQS9ZZVZFbEZRenIyNFN6MTQ5WGhS?=
 =?utf-8?B?WG0zME1pQ05FZVdqVnNsOWxmZjAvSkdDNk9Uc0pyeFNMMHk3OFJyS3N2anVp?=
 =?utf-8?B?OHFhUWxYd2dmYzYwVWgzYTFUN0VoSlVaN2JNVlRHZTlSc0N0NlM3TmFNdGZK?=
 =?utf-8?B?QmJnVStXZUYzMnpSb1d1WUg1bWk4QTgxbnVwWC8wUFErbkVCY21BZWpRSzRh?=
 =?utf-8?B?OGtzNU5mZFo1TWF2NFgwNTJQWDRUc29raGN4cVNYMHlqUENydURxdnR6MHFB?=
 =?utf-8?B?WGhHVHlCYWkwRGg4R05FbFgwbm1LRndVVEpJTnd1bHJDOU9udlcvbk5UcDBN?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 209e8f6b-58c3-4be2-9bb5-08dcd8d28548
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:43:07.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBs9uaFfN2BBn6mDgyILxFNjuGfOk+sTEnW/LP6JjAN3CfXf0uDLFgOs4suFjKKIK/e8xNNRBrwf03xcqclRhnFAZwyu/ZOjceERBdatEBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Configure mbm_cntr_assign on AMD.
> 
> 'mbm_cntr_assign' mode in AMD is ABMC (Assignable Bandwidth Monitoring
> Counters). When the ABMC is updated, it must be updated on all logical
> processors in the resctrl domain.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Introduced resctrl_arch_mbm_cntr_assign_configure() to configure.
>     Moved the default settings to rdt_get_mon_l3_config(). It should be
>     done before the hotplug handler is called. It cannot be done at
>     rdtgroup_init().
> 
> v6: Keeping the default enablement in arch init code for now.
>      This may need some discussion.
>      Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.
> 
> v5: New patch to enable ABMC by default.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 9a65a13ccbe9..3250561f0187 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -709,6 +709,7 @@ int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>  			 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>  int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>  			   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
> +void resctrl_arch_mbm_cntr_assign_configure(struct rdt_resource *r);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 09b1d8bb0aa0..314c0b297470 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1261,6 +1261,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>  			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
>  			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
> +			hw_res->mbm_cntr_assign_enabled = true;

This is a major change to require architecture to set whether this is the default mode.
That seems fine but needs to be highlighted in the changelog and descriptions of this work.

>  		}
>  	}
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 7a8ece12d7da..1054583bef9d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2726,6 +2726,13 @@ int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
>  	return 0;
>  }
>  
> +void resctrl_arch_mbm_cntr_assign_configure(struct rdt_resource *r)

How about resctrl_arch_mbm_cntr_assign_set_one() to match existing
resctrl_arch_mbm_cntr_assign_set()?

> +{
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +
> +	resctrl_abmc_set_one_amd(&hw_res->mbm_cntr_assign_enabled);
> +}
> +
>  /*
>   * We don't allow rdtgroup directories to be created anywhere
>   * except the root directory. Thus when looking for the rdtgroup
> @@ -4510,9 +4517,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>  
>  void resctrl_online_cpu(unsigned int cpu)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
>  	mutex_lock(&rdtgroup_mutex);
>  	/* The CPU is set in default rdtgroup after online. */
>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +	if (r->mon.mbm_cntr_assignable)

Needs a r->mon_capable check?

> +		resctrl_arch_mbm_cntr_assign_configure(r);
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  

Reinette

