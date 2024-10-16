Return-Path: <linux-kernel+bounces-367183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3970499FF90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F138E2868D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86D17BB1A;
	Wed, 16 Oct 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMo7eo0M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3069157A41;
	Wed, 16 Oct 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049826; cv=fail; b=BjUscoq9TDl/4+kgYW8zbigZ/CTAPMxPPReTQdYXLotFuEZPlIC87tC2eFkY3YP710YuVnFwsLvRSAeHnO+f+Ysprp7hAoe2YyxK7ynhX0V86crnc2I9eBypY9Yix+/orONNp9Za6dtNPftQ5iUDxBjTbUp9cTp6am4/jAcuhC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049826; c=relaxed/simple;
	bh=F4sB52LHS+XzkZtAn4S0F9QKJF6YU8VDlrJGxjjlrhY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5bxZCegdmWIHkFdTbFO0Eh81sUJVy5U5uyqxEY/BujmcykUg9LinEVk18J+dCnS3M16S5CIUygBiLPCFDuda++MpvTt8nvcYkS3nO+9G5KrDNKveIFbzzPJMnC+fZp2bb8+5K91Z7FYOKBIhxm87G8NukBlwusbTw6YOA14FeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMo7eo0M; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049825; x=1760585825;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F4sB52LHS+XzkZtAn4S0F9QKJF6YU8VDlrJGxjjlrhY=;
  b=bMo7eo0MDPyr9f2U/oTGDNunKaONQryXcTWLPU4vGjLcBNad1OjKbWU4
   aFY8SvMOrsTI2iIONKEtc3JCv7rQZvXkAnLIkcFB7AlSvhTXigiNrK5kj
   gFCmh4ZNVT8atxWHVES42oZvdGdFnlHy/2+94gofa3PXCxh0N0nHCXlzw
   cHY3ncr1IwQEyy51uQ/WEbxNVZ/o5j92sqQq7ozkNCxafIWsemsPfm9KP
   uOUOyYDhaYAp6pigsGyI6cmIkrIW61v9fGhAOosstuyB0q++DW6d9dhht
   4aJq4P5KJioSc0b84tFmgwom1IkWUzIXQ20OOe7TeNFfsgXMSrPVpD4Ql
   w==;
X-CSE-ConnectionGUID: J+dpLgMaQh2iOIGFNBd/1w==
X-CSE-MsgGUID: E/ccmKY9TX+C5hB9HosA4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39869817"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39869817"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:37:04 -0700
X-CSE-ConnectionGUID: rktk2/9HTPmzt9rGeQ5s8A==
X-CSE-MsgGUID: vEpMEAO4RBGcHjUqjMh+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="82654770"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:37:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:37:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:37:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:37:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:37:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgA7jYzHkyhUdjCnInY79c3RgMiQM2e8Fhhrc17bZawtSxJvyA2WFGcj2c9SVOBPZbOOt2e1oKWHNlwcoluyIiD23mxQACaoZVZ75mEQAFtxQwGhvL/iX+XqtvRjPCzt40P6NQTOrEBQU9Kg60fAUTN/Rj0JCKVQckqCS9a8JLR+fps+DdH+LwV00SxqNIZhH8YRUAH43C0+BKvhix0WxLudBSj0v7AniCZrso/mesqAZodXjM6CyqBy9ieaGsf7OrZsIy4TxatlLxBqPSIikcKdv6+Ik+6szN2u4dBSuK/htuGKKL75dgNAIDgmFyBn8naLAfFABoqdyofIL2RLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD2SL2DXhIJs39SEyf3ysjDCKxHq6imox2CDzfXkeEY=;
 b=NvcWubbO4Zv8PtdOUHrQ6UkJJ5Z8MBTfbe4jGwBz3iVGfxf3wa4y0kLg8QGM2s62psSZtQOiMHA3eJE0FgS/7d0IPfStQpypOkoVQ4WBcrxfy1CCDpUCzvzslcTa4ELvqY9A4/Oz5x7pCIYcRQyxxHg68KW1UzYiF7or7x32EYfiqeV76jkdiW7qmSWzN0LE9YmsIKQw1LRXOX5lY23567NAdcJBxnaXyNEw5fHyPT2QUQIOgAxKcjUlVj9VsNdtaCKvL7aj9Qd42H+cRXODYD7FuCC6u/z98NqDn3DMh+ybfAksEkmRO7owFq/wvqfGnzUyIIg9llXDpMpZA+8puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7969.namprd11.prod.outlook.com (2603:10b6:8:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 03:36:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:36:59 +0000
Message-ID: <4d49182f-6185-49df-b9bf-29fbd17dccf6@intel.com>
Date: Tue, 15 Oct 2024 20:36:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 21/25] x86/resctrl: Introduce the interface to switch
 between monitor modes
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <d3d1238b58ba9d808a8094b2174a52df2fcc5e6d.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d3d1238b58ba9d808a8094b2174a52df2fcc5e6d.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:303:8c::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 05404df5-0a18-4ed4-31b7-08dced93ca77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEhUVFhNbDR4dXZtR0ZJdlgrTU54Z1lYUSs0SDVhalNGU1ZFa1VDRy9Mb1ZN?=
 =?utf-8?B?Tnk2WVl0d1lPL0MwcFpVbHkwelF2aHh0ZWoxWkFhdTVqSlJFYTY4Wi9iSUFz?=
 =?utf-8?B?ZUFrUisrVWpxZDVpYURaK1BGN3ljWFAwQXZHeG9NQkRZdmRLNDBaZ0RydjJC?=
 =?utf-8?B?MGFLQUk2MncxUXl2cUhDSzczaU1XSkE1cmpKd2ozSWE5NVd6QVpZV1RUZTZ5?=
 =?utf-8?B?Q05DcUMyLzd6MUVYd1lTTzJ2SjNhcC9TNHY4bUVuNVR2cUpDWWVWQXJSMEZ0?=
 =?utf-8?B?NmVtQW9qeXNtR01MMEJGR0RhdllQZUZYWHpLbEpNTUpPYWpDUHJnWElYVFNm?=
 =?utf-8?B?MldQelJIUFRkTXFYZWxCdjJPTU42dmFuUWRLMkp2ejU4dHlZWHN4T3JVTm5S?=
 =?utf-8?B?bkc5aURZNWZocE5ieG4zd25qTGRsR3Z6b0lTRWRiSS8zVWNiMllNcUtabkhR?=
 =?utf-8?B?cyswVkNNWlEwVUl6WG9Pblc4bncvM1BUQlRsVGpJbmUwdzQwZWZYb2YzeWhw?=
 =?utf-8?B?dDZuUkJBTEMydmJrczRTZ2s0OHdWT3ZUc1Z4bDRuclpLUTJXQWhZcXpyL21r?=
 =?utf-8?B?ZXhrY2RxL1o5Z3Z1eGVaV2o0S1MxSlJOeUdqN0ZMK1JnWEZnOEl0SUFRUnlP?=
 =?utf-8?B?aG9DNTVUSzE2ZE4zeCtmdk5mZTZkalAvNjZGVGF4Rm02T0hCcHEwQTZyS3gz?=
 =?utf-8?B?Vi9tbGVVdTBHV0pRUW1iRHNNSVdjNmczbWlTZ0hRZ3k5Vm9OSHlTaGFHeEVE?=
 =?utf-8?B?SUpaN2FqSTFNczdEcmV4ZmpRSGJvTldQdGRqM0RhRVIzdFQyRnpDYWhoWkFS?=
 =?utf-8?B?TFA3bFVmWlIxVnlYc2N4NzhNbis2ZENuL21vSTA4Zms2NUVPWmw3RFpCNFQv?=
 =?utf-8?B?N3N5N3A4bjJBN2tQeFF0TTg1UkVIaXk3US9PRklsUmFqQWM2ck5QM3FwR2Qr?=
 =?utf-8?B?bU9FeWJSd21JWXhlOEFGa3cwRnNjY014KzVJS3o0RVJBdUFCdytpMU03U0tB?=
 =?utf-8?B?c294NVQ2Y3VnSFZBclROd1FQL05xcm50SG1JNlhhM1U3VWtDOC9wVEJWVG52?=
 =?utf-8?B?TUN3TUs3Q3RIS1k1UFpWeDZkRHJzbHBVald2bVh6b3BDZFNSOWdGUnZFUy96?=
 =?utf-8?B?NlVBbXR0Ymw1Y1hyZXdkRmd5MmU2bVFJQkJ6cFVZU1Z0MTQ3RC83Uy90M29G?=
 =?utf-8?B?dENodTBiTmhyczRwenlPanQvN2puOGhvNkk2QXdHMUVza1drd0lENmY0OUFy?=
 =?utf-8?B?ci9xMlVCaWR3SEZxc3AzV1NQay9LamVoMDd2djFtZWhlZGJhVVMyNDJXM0l5?=
 =?utf-8?B?VllOZTdqUnA3VTdrTVVrKytvcVo3aDhHKzY3ZGhjNnpsUnhrR0ZIUS9sSTNS?=
 =?utf-8?B?UUtWRzdRZXJpMlFFdlYrbjQvd3ZNdzQ1OGxYY0l6Q1JxdFZ6STV4bDd6d3FG?=
 =?utf-8?B?MVp2amRIaVNYU3NnNzBGSk5VWHlqNDRnbndnRXcyeHFldlJ0SlpxdG56THpn?=
 =?utf-8?B?WnVBdDNKZnh5SEM2R2hsOGo5eEs0cjFkbFk0K1BBY1V5eTVKandnWjdkcncx?=
 =?utf-8?B?bm5zMjEvSVA2SmRrOHN3b1F3Nzhwc0RuTmlRYTZpSUIzWDZSaUphNkxwK3Bz?=
 =?utf-8?B?a3dVQy9kdUF4TFA1SlpVOUYrRTZCL1JqUmhWSEg3ajg4ZE5DSFFsY09FemRm?=
 =?utf-8?B?RVc4YUQ4YnNRbEd0TjM4b2l3ZE5RbTFUNllNd2k0MmlNZWx3Y3pQaHFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGIrOXJ3NTNuZmROZjg4OW1LemZ6a0hSV1Y4NEdHYkloTExzcS83MW5tZmJ2?=
 =?utf-8?B?NjhxODlFTzNUTjBtU1k3WDg0OC9aLy9GMU8vMEsyVVdSenZKNGk3c3ZtQlJl?=
 =?utf-8?B?U3BvWDROa1YvNVZlOVhhcWEwSjdrV0dqNjJQekN5SGFPQzZvcjBhbkpaeGV3?=
 =?utf-8?B?dDduUXpyZEJ3OUJFaUFwRHBpK2V2a2k5VXI4UkJpQTQwQlRReGgyRVd6TTFx?=
 =?utf-8?B?WGhxdmlabng1WGthQ1VTZkRKbGxPN1RQb2w0T3g1NzhXWlpDek1xRjM2OWxU?=
 =?utf-8?B?Lzl2RCtaYmFXcUFQZUVlSisyYS9xWXlKR1VOUHNaZ0NlWm1JaVJKQ1RRTlpB?=
 =?utf-8?B?Y0FDanduNTlkOU9RdmJIdzA2elNwdTBtVUtRb0tza2FYTUwrZFJSWFZINHJk?=
 =?utf-8?B?VDhJTjAwU05DU1pRTzdEb1NyNXBJTGVLWU9WTC96RFd6czk4Z0FrOFpZdXdQ?=
 =?utf-8?B?TDhXbmh4OUFVSnlweU1KWDg5WFBuODljQjNxSktwKzJ6MlRpeGFKQXU3akJq?=
 =?utf-8?B?VVA0dUhRd0tWV3VQZTlndVpRcFE3NWFhK3JyWWZSYW1aeWVsWkhXdTl6TjBQ?=
 =?utf-8?B?ZmowUWoxd2EyYW0yU2tUbXpkTFBsQVJkVzhZSnBmUFlqeTVudmtXS0cwcEk0?=
 =?utf-8?B?bFdZU3Y1blgvUkgvNDFUWmdLamRPNU05MTN6aG9nZzdwVFpic3dsYjc1dDRN?=
 =?utf-8?B?SVh1d2F1M1k5YzcvZ1JOSGs4djY3b2h5UWZFT2JlWlVTNjQ5eTRDU2dQa2Zv?=
 =?utf-8?B?M2Y2eU56ZGJnVENZVlBSNy82VnRPa1UxelpxVzFRVEx5bHdpeHQxVWZZbCsy?=
 =?utf-8?B?NklsUHFrd1hVdU1VYUw3Q2I0c1NrTmZ3azZIV3ZoSzZSMTJUNzRxak9jcWRk?=
 =?utf-8?B?M1JVdENCeXhSQ2RaK2VTREpNYzdVTnArZHQzdi92cEgwVFlLMTNlN3hocHZR?=
 =?utf-8?B?ZWVHdjdBeThVemtYM1A0S3BmeDVNS0FjMC9PalVYOUFyT21FdmN0d0RKb09x?=
 =?utf-8?B?dzVleWNPRmVMZjdpaTJObU40ZnFFL2RNaWJldkJoT3FoazRSZHBjOUlJVkRh?=
 =?utf-8?B?R3NuQjlOWXBZYlozcEhveTJKYWtGT0J2NlNya2UrOWUyQ0g0L0pSZGNjZktw?=
 =?utf-8?B?NFlVU0FkYXhEWUZiT2hUU1ZwbGpMaVFEdS9Mdmw1MGpwSHVzTFNXYWVsUGRh?=
 =?utf-8?B?dmlVSThEUzJMMUxMcFBmaWxFYkFzNE55ZGpuYndGenJubElqTnFNcDJlaUlW?=
 =?utf-8?B?QnFKek1LdlBOTTVsQzhvd1pWNmE1cFl3dWJ3U0p4WU1Xc3BZcWIrUVZOUXZl?=
 =?utf-8?B?bEUxd2hzajFBRDNLSWhaQjQ4T0Q5TFEzMlROc0lKT0FCMzZXQWQyeWYzRS9P?=
 =?utf-8?B?eHg2N0MrOHlaaHhGR1pQelZ5YlEzODcrYThhaTRLdE5PWWd4RjZOTkZXeXVt?=
 =?utf-8?B?N2liZGpmSG1ZdU5zcDlMR0xLL2U3a3VvTlZvWThuQzlyN3VuRUlzTmJ1dGl4?=
 =?utf-8?B?ZXJLSTVPSTRwK1ZsNjI4Uk15UE5lUm00czNSYkt3Z0xSOVpjY3ZPT2dpcWRw?=
 =?utf-8?B?TXRmSGZOblFoMUhmNE9qSksrWXJYMmQ3djJZV1g0SEZDcjEvMnoyQzFlUStI?=
 =?utf-8?B?WjhRMkFaaWhOYmxFeVNGMFZZb2puSXRyTU42K050MDkyV2hKZ3cyNlFDTlJ2?=
 =?utf-8?B?TTl1b2xzc0JGNmwza05Kamo2ZHNXd05VelBuam4vTlgvMTk2elY5RGRySjR1?=
 =?utf-8?B?ZHhnd0dvTVFWb3F6amhpUmw1RFJXMGY3cjg0cFZPaEVHbG1MeGNuN1FvQnN2?=
 =?utf-8?B?ZEt3ZWl1VkpwT2U5b3ZwZHRScS9SN2RacWhYZDQ3ek1CeXZybDFlNTJ3NS80?=
 =?utf-8?B?RHB0YmxLaWtQZlUrdWs5MzJ5NGZDMGNaNVVPbDNNK2NqNnAzdzU1bVNhcXYr?=
 =?utf-8?B?TlhQTm9yc0wvaHBjWDlEa2pFMFpiRWhmSHRLbXQvRlFoU2hVTHdnL21YOTd4?=
 =?utf-8?B?Wm9pSGIzRnJVQ2hZT2EyaWNmWmFTdFBRb0dLYnQxc2ZlWUl5U1JIREFscUQ3?=
 =?utf-8?B?M1orbnNuNlFtZ3pOTWFGc2pkaFhtOWtkZjdHTk9mMlNFcWpyZzhOTUhwZzk5?=
 =?utf-8?B?SkJqNzdaQjdyTzV5QmxpeG1NQ1dhM3owNGp0aDlWY0pIdjhST1hpcmFiSi91?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05404df5-0a18-4ed4-31b7-08dced93ca77
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:36:59.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9s9GlUsquuh83wDdQEhnPtHuQZrIdSRsNvl9+DNWganf2ByfruZ8x6YwFoGgOWnjkVqz62poZQnliO9gTiHzpomI6h8zPRhB6aW5KmEAkHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7969
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> Introduce interface to switch between mbm_cntr_assign and default modes.
> 
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_cntr_assign]
> default
> 
> To enable the "mbm_cntr_assign" mode:
> $ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> To enable the default monitoring mode:
> $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> MBM event counters will reset when mbm_assign_mode is changed.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/arch/x86/resctrl.rst     | 15 ++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 75 +++++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 99ee9c87952b..d9574078f735 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -291,6 +291,21 @@ with the following files:
>  	that case reading the mbm_total_bytes and mbm_local_bytes may report
>  	'Unavailable' if there is no counter associated with that group.
>  
> +	* To enable "mbm_cntr_assign" mode:
> +	  ::
> +
> +	    # echo  "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

extra spaces

> +
> +	* To enable default monitoring mode:
> +	  ::
> +
> +	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

extra spaces

> +
> +	The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated counters

I did ask you not to copy the text verbatim
https://lore.kernel.org/all/b38c93bf-4650-45d1-9aca-8b4c4d425886@intel.com/

> +	may reset when the mode is changed. Moving to mbm_cntr_assign mode will
> +	require users to assign the counters to the events. Otherwise, the MBM

"will require" -> "require"

> +	event counters will return "Unassigned" when read.
> +
>  "num_mbm_cntrs":
>  	The number of monitoring counters available for assignment when the
>  	architecture supports mbm_cntr_assign mode.
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index cb2c60c0319e..88eda3cf5c82 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -888,6 +888,78 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static void mbm_cntr_reset(struct rdt_resource *r)
> +{
> +	struct rdtgroup *prgrp, *crgrp;
> +	struct rdt_mon_domain *dom;
> +
> +	/*
> +	 * Hardware counters will reset after switching the monitor mode.
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in the next update.
> +	 * Also reset the domain counter bitmap.
> +	 */
> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +		bitmap_zero(dom->mbm_cntr_map, r->mon.num_mbm_cntrs);
> +		resctrl_arch_reset_rmid_all(r, dom);
> +	}
> +
> +	/* Reset global MBM counter map */
> +	bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
> +
> +	/* Reset the cntr_id's for all the monitor groups */
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
> +		}

Please use MBM_EVENT_ARRAY_INDEX

> +	}
> +}
> +
> +static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
> +					      char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret = 0;
> +	bool enable;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!strcmp(buf, "default")) {
> +		enable = 0;
> +	} else if (!strcmp(buf, "mbm_cntr_assign")) {
> +		enable = 1;
> +	} else {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Unsupported assign mode\n");
> +		goto write_exit;
> +	}

Please keep two things in mind:
* this file is always accessible, whether platform supports assignable
  counters or not.
* this is resctrl fs code.

So, considering above, how should user interpret the "Unsupported assign mode"?
Shouldn't it also return this error if a user attempts to enable
"mbm_cntr_assign" on a platform that does not support this mode?

> +
> +	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {

resctrl_arch_mbm_cntr_assign_enabled() returns true if mbm_cntr_assign
mode is enabled, but when it returns false it could mean different things:
platform supports mbm_cntr_assign mode, but it is disabled, or platform
does not support mbm_cntr_assign mode.

resctrl fs should not rely on all archs to duplicate the all the checking done
in resctrl_arch_mbm_cntr_assign_set(). It should never ask arch to enable a mode
that it knows the platform is not capable of.

> +		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
> +		if (!ret)
> +			mbm_cntr_reset(r);
> +	}
> +
> +write_exit:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>  				       struct seq_file *s, void *v)
>  {
> @@ -2115,9 +2187,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "mbm_assign_mode",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_mbm_assign_mode_show,
> +		.write		= rdtgroup_mbm_assign_mode_write,
>  		.fflags		= RFTYPE_MON_INFO,
>  	},
>  	{

Reinette


