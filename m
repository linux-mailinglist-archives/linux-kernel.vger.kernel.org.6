Return-Path: <linux-kernel+bounces-522770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362CAA3CE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACCB3A74FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB42AF12;
	Thu, 20 Feb 2025 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hzhcyzlm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420F22F19
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013289; cv=fail; b=QikJPv+dStZEddRz5skNaoy+FjgXzo/liN7OpyG9R3JG3l/ahlxTOsp6+b/FraJhwFVXtpA36CFFOro1x5XOjI9a0pIUhUYckYqwriVHwH+XEsk/pXvwsRVeHvqsoCpKMjk/47Ua0Zwmw/oXcQhDk3cjPp7TJFI2VGuPYfUdGgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013289; c=relaxed/simple;
	bh=y0zZuaass6MKcQr4kWeGZa4CGMlkQdnTnh5dDRia7uk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qv4LgrpdASHLi9pKiKXK3LE5AIr2RHvXHZd/SPNFzZJ+rSvY3SWt0Tk0dR1NiLGJ5fL1FGoyqeti9xgjOSE1BGSiQOIHJAbgVCsr1rOO5nxj8qIhoBUOtr0FlHYVgKhVvXd7lek3GaH9Db73i7uRX5uD2DMZARBbxzdoQibaD3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hzhcyzlm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740013286; x=1771549286;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y0zZuaass6MKcQr4kWeGZa4CGMlkQdnTnh5dDRia7uk=;
  b=HzhcyzlmfW13AtUc/krCZrChBrJhr16MIL2VCO6+guL333SWSVnB80l9
   cFg948vdaj6eo8RYH1+cYAjcOXSh566HJZqqoZ2+bBYVrUv/vDo4qH+Yf
   VPCRmbot7Orp0Z9YFbhpdm00USyqxX6+bibh1fdnUPQDuE8CRUaexFpFV
   inFwUseDP4FtfvIuSVdd3rksxd3JZ/U5mKiYjJabnsQoSzRfy4qZNYbQ+
   7o/uxUVSWVnQoJ+rEeHgNmxpnYtlDWiRWxvqWN/VePG/WX2eU1PiTe+av
   RZer6082TbjHaAGvaz5LBTLJbw199k1LiYYaW96KSVJPyMBS5Qy6T0+En
   g==;
X-CSE-ConnectionGUID: xETG4d0/RjGmFlMifCSm+w==
X-CSE-MsgGUID: ozI9Wt4bSiek/jFk9WORqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63252595"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="63252595"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:01:25 -0800
X-CSE-ConnectionGUID: WLIn9vzMTWeaPfyJOJxMOQ==
X-CSE-MsgGUID: MzxTJ0a7R4yULqX+umUNiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114869653"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:01:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 17:01:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:01:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:01:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSXGF/9eYLD/7x3pRseg1bvjY4dcl2cwvMRJi893AijC6cM8Ph5HcosVHyK1JqF3Mc0Cbz2c0SKCs1cg2yZklFBe1B3GUr06FuEEzeGpko9TZ8G0YMdJs9Fq1+5pJP2ofr99aQq1wQ21BCTDT689dhqCfJ0JKn/a1nTr77wgVXx7jobyetdHtvIobSFqFSYgA52mD1iTsB69g5eVHZ+pvbxRKwsVhD0o0rbFt/srpNS1kZyyyYedCYmpl4SSqKireybgUmWXf7r/NpYR3CaFM+Imoz4xD2DM05WKPhAc2DiErPOZyJ+OYdmSXphDsOTv8JoeiYq6ydJi49lIi/7AdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJAFn4PFj2c441AoBwMQuaZMmiHOczuJBsMTOYSMMYU=;
 b=nREK/EOsNePndLR8PFOWd/9M4nTAK21KMlmgDDtt7qJEG2tZX6/E98AyXwFwMb7tXFx6pfbSOD+CS3gon2o7yGGYxtZuUG0SVDdGqN/ZIVTBjJ8MKgyIQhqAED0v2jcP/W2hS6LmbdSceoI4T0r8we1ww92t9aszhVk5/3oNaW4zwlLagbICAPLbwrLBuymU1aWHJr2Q7gT8oTAv+AZ+GicqAP81oVfwe439+VgTLvclkPOWAGJ4eGIJ2qDMMyamZcVT5Gjb6vEAqvQkLk3kRqnI69EwWq8HFQrFFy75Eqked8EH12yU5fao7ogrZhUrujAdY71mcgiBNmZmV7MMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.21; Thu, 20 Feb
 2025 01:01:19 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 01:01:19 +0000
Message-ID: <e725bea0-e2d0-47ce-9128-5187cefecff7@intel.com>
Date: Wed, 19 Feb 2025 19:01:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tsm: Add TVM Measurement Register support
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <20250212-tdx-rtmr-v1-1-9795dc49e132@intel.com>
 <e6124222-0dd8-46ff-abf7-3fcde963a5bd@linux.intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <e6124222-0dd8-46ff-abf7-3fcde963a5bd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c43eee-54fd-420a-9fe9-08dd514a15f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2VqeTBFREN1Q2VUWVBWSlNwZlRLMGRsME96NFpxZncyV0p2SFVGTWxGMmdz?=
 =?utf-8?B?Y1dYSW14ZTRQalFZT0ZOdXZ6NllCSjVBWEd4MXJoTHpUcjZIMVc1Q1p6SmIx?=
 =?utf-8?B?U1IrYUp4YUVhWWs3SlZFUDNJK0NoZjBYYWZIQ2VWdGVWV2hzalBHcmphOTVw?=
 =?utf-8?B?UlhPYnZrYlgrV21Fd3VvYzkvQVRrWWNuNGJZdi8yQVNiQzdhMEtjSzFEaEV1?=
 =?utf-8?B?em5nRCtwQU1ydU4rRHdKRm9icjZBd1JLendlZ0ZLTlJ4U2puamZob3RjeFZF?=
 =?utf-8?B?Wmc4SmVRQXBTVXJMT0RMaGt4MjV0ekRaQzRCSDJuWEFFa3V2TUFwZjZGMUpL?=
 =?utf-8?B?TnEwZ0taeEZ5MDdwWEh4M3Jab21mN1VNRGU3U1VObk9kQyt5ZDFhRmp6Nzh3?=
 =?utf-8?B?c0FoaVVKVXpMWVA0SEhPeW5MM05XNndzbUVCUWozckF5ZlhWN2dJK2lCNFNw?=
 =?utf-8?B?MDl0Q3hRZ2QvN3hLWjVZR3RES3FJUWQ0clZrNjl5YlJNZ0Uyc25hUzlEU1Zv?=
 =?utf-8?B?NXpBRGhZb1pRV1JEOUYrZHRpM3RVUlBMek9jNjhhSGN5V3BDUjFwcmJ5RjhC?=
 =?utf-8?B?RzZFMk9NSThMcUQ1c0xwdEl3YkJEQXRPa0c4UGovSjhVc0R3WnQzY0pQMGZL?=
 =?utf-8?B?eDBPeUV4UUJYUmxIbnhsdWZhVUd2R2NIWkZZTEtKUGZnMzB6Y0oxYWNZcWlV?=
 =?utf-8?B?MHVrME5pcFNaUGNOQmRxL2FwSWZ2Um9rY1NYWk5VZDc4SWozZlR1UGcrUXVk?=
 =?utf-8?B?ckxIZk9ackZJZjFndnRVSERDeTZlbjdLS2dJNTNvVTJYbExIR0tIZE84WkZJ?=
 =?utf-8?B?N2NoQ2wxdmMzZlp2TVBoZitka3l6dmxMQUlFRXVIbGx5ZW9tR1h5R0RVNDB0?=
 =?utf-8?B?bE9saTNrZlBMN2hVUkRGMTFvUkQ4Z1NydzhqbEdmOGtxTkR5WHVCUGZBSCtI?=
 =?utf-8?B?UlE1eFIza3M1MGZ3c0lUNW56WHNaOFk4RWJxVkZzTWpkcThDQ1VMNWY2MkhS?=
 =?utf-8?B?NVdRQzdyc3VHZVZrZzF1OER5UlRjYUtXUzZpZnpKWlovcE54SGJ0ak45VmJR?=
 =?utf-8?B?aTVsQmNBRTF0T0NkejVhcTVUVTBjYlBoWVVKZFRhYUhqY0JJT3BhK1Y5SGdM?=
 =?utf-8?B?SGcxdVQyMTFxM3NVU04xeEFaV3JxV3hpT3d5ak96eHNjTHRuM3JpYlhGdjlw?=
 =?utf-8?B?SHRITHNqZHNJYTZSbHRLb2VrTmZQcmJMTVlEcWJlMHBxNm0vNFNQSXd4RWs4?=
 =?utf-8?B?VVBIS3E5TDN2eU4zUERKd0FmVjFzaDZnL0c2M05SWEN2c0dMSWU2ZmI3L1VT?=
 =?utf-8?B?NEh6d3hYVmRHb0tWK2FnUEZ4WmJYZFQ1bCtndWhYM09NZlBUVUtWUmdzZlpq?=
 =?utf-8?B?RkV4ZDRoWmtvbG9NQmZXSHovalFLbUtDekdLTDE5YWpKbUxRQmVPSmI2Zk95?=
 =?utf-8?B?YkdwUXRxOGN5TUFMZUpnZ3NLc1JjS1BzeWdhMjlMalJjUHFLbGNMclBFK1lQ?=
 =?utf-8?B?Z2J6SXMrUStFenVSaWxUNGRvZDEzMTJqbDdRVHdnbFdOOFJuenRxWVljRXd6?=
 =?utf-8?B?MStVclR1YmVSaGF6SldZY2tEZW5WYWJHVkxaWG1KUzdpVm1jOTZJVENvOVR2?=
 =?utf-8?B?cGR3V3ppN2l6MzJTQVQ0R1QvMVJiMUgxYmdMaTlaNjNHc2tvN0JFTUtrZmhl?=
 =?utf-8?B?RExSdFBMUVYrbDBqRUJpQURUaExzRE9FVTVhN0lxRm5LQUVrQnJ4R1NVeTV5?=
 =?utf-8?B?V1RDNmdRQS9mKzkvdXdEek5GZ0dyNDZrbXYvV0JieldqajRpWEJiM0Z1dk1D?=
 =?utf-8?B?R2JjdzhwSFU2Y3pYOGFBTjZqRFYzUFZ4MzBCdExZWWJKNVUrRFdRRlJDNEhm?=
 =?utf-8?Q?gc8p2tb8PVAGS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGEvcGl5Z1BIbndjZGFKR2RZSWI3K21acnhtSDNobUhmdTd6QmhzUm8xMlNO?=
 =?utf-8?B?ZFYyQzgwcHcrbHJGRTZBYXpFRm02UkFzcmdrS01vY2hCU1AyTzMzTUtDbEsw?=
 =?utf-8?B?VnNYUmh2S3VGdittcVBqSlAydzB1aUZiVU83eUVwR2N2S1RWeTU1VzFXVm1j?=
 =?utf-8?B?emsyQm1yWXZ6NWN6b3BXK0svaUdsUmk3YnBkZ1FqRHd2VjdiTEo1VVhtUkpr?=
 =?utf-8?B?MFpVUHFnSVJZSGZ3dE9OaXhtaUtpdVM2blBnWjhwSEQzU2JaWWFHZ3FTbUhX?=
 =?utf-8?B?M0U0K2YyOVg4b0pZWkp3dHlPVTFEWmlOMkQ1RHhXaHJkb3VWNlZtcVhFVVR5?=
 =?utf-8?B?WElQSjdrZXU2dUhIQy9TeklrZlpXUGVpeE1TODhpZDlqZEZTTEVwK29RSnh0?=
 =?utf-8?B?Qi9KaGVYcU14bzl2eXlVRk9PMWovOGpFb2JITU9DTVU4SXVLSHVXVkNab1dS?=
 =?utf-8?B?QUJjOVJ0dllkYkgrancxeUp3WVVVWkRuYVltKytMUnZFelJkRzhCUjhvbndM?=
 =?utf-8?B?Y0tBaGF5N2Y0bm9PMWE4OWRvVFJ3VEU5Q05GeWVZM3NjT3c4UlZENGlja1Ay?=
 =?utf-8?B?YW9LOHRpd2F1eFlHMkZwcjZOQVRPWi9NNTBRMUtNRDlHd2lmK3BRZzdnb3Bx?=
 =?utf-8?B?RVowRzZITjkvb05LMkUyZnE2cWVLT3d4TlZ3ZWY4eXhLbzgrM1NGZHVTZXhG?=
 =?utf-8?B?Y2tyZ2ZOVitHVmI0TS9PRkUrWkNtWWVNd3pGd0c4aG1TZjlPbWs3aDRPM0xv?=
 =?utf-8?B?dVJpSFlQc3dKT201aDVWRzIwTHppZHZiVlQ3RHJtTnpoNkJicGNRR1ZUK3ll?=
 =?utf-8?B?OVVjUUJ2SHZNcHpudllGRHhGS3M3dHNiYUxmbEREV1VDMkhHSEpVMlN6aGty?=
 =?utf-8?B?Z1hScERTN0RkR0RqelVwYmZnL0NNcExMa29aSzR3cmRJN0J0VnBQM2R6NE5r?=
 =?utf-8?B?TzJaOXJDMy8zUXBHUmptenNHRnlNVW9zNUdYblpXNWVzbE90TlNNVCt4NEh1?=
 =?utf-8?B?RDExT0c1T3NLV1hVL2JpMjZyNURFNmlxck0wUEFyNlFOVXlkNXNMVDFid0s4?=
 =?utf-8?B?eTMvN2ZxWjVkNEpSM2FPMGhyeWw4QXlaUE5CVWlEQVozc0YvVnlOL3U1cGli?=
 =?utf-8?B?OUlXWCswOStMdm5aTnZaQnBrRWxPM0VHYytGN20rZVN2bnBqemxCVzJuU1Nk?=
 =?utf-8?B?bFROa0xWcnFjWUI0dzFWM2VwMEtPQkttT1hpejlRNDVHTDhwTW4yZmI0bmdK?=
 =?utf-8?B?Q2hyNHQxU3BYYkx3M2FMazIwQlFDT1V4TUNUSnZ1NmVtZFNoYmVlZFZRYVdX?=
 =?utf-8?B?M2pnMnhyVHhpcmRqT0pMcUk4VWx5eFJKQnhCbkpQQTBsK3VZcDNzM0JPRk1N?=
 =?utf-8?B?U1pudHpGZEdPU1doVUVHWlhXV1VETFMzQUhxY20zSnUzZFdQT2tvQllYQWND?=
 =?utf-8?B?WXIyNkNRdzBGOFZuREhxcDFrWFBaVCswMVpEUUlib01MelBrc1d2STJEUWho?=
 =?utf-8?B?dElKOWwycFhnZnZyckdQWi9rSVlJL3RFdDAyT0Q5UXVoM2orMFhwNFhmVEt0?=
 =?utf-8?B?WW5mczBzdittOHpzaTZEUE1nZ01iaWErekV1SkxYa3p1elgwemlkQ1RtSjM0?=
 =?utf-8?B?K3R0UlI1R01rSSs3cWhuTjY0elpqUlIyamJCRjVtczBDQktmcGI4MUhSdStt?=
 =?utf-8?B?czF3a1NlT0lpYnYwdFRkVGQ3ODJaeWJVR0lRVDExaGJzT0lXRmVGYm1tSWQv?=
 =?utf-8?B?dDIwdkJmQTl2dzEvTVhlbWxEd1Y3akRXQWdkMld2RTc5UzU1Yit0aUNLTEpH?=
 =?utf-8?B?VGp3NHgxTVRueWx2Zy9tNHAvMmRNQldYRkdsUnR6elR4VnByWmR4K2JUbFdr?=
 =?utf-8?B?eUxGcFlLbFFZemF4c09WR01pVkpQVVNzakVSYmRBanhreUh1bnRraU80cndh?=
 =?utf-8?B?bDlsa3YyTXB1bjdIVEdqZkgzLzJ5WWJ6NUVaTnpRTU1PamRDclo1bEFlb08x?=
 =?utf-8?B?R0lTZ1dOc1J1VWx5cGZZaWl1a2g4bTZ1QTRpUnMzSHRBUE1QZVBnQ0FSNWlW?=
 =?utf-8?B?eWl4MCtucHgvRC9mWmZkeWg1RERyRUIxNm9RYkJtTVp4Ky80VzRLSHlRc2FS?=
 =?utf-8?Q?Zhba2EAVxyFYTb6pXy4DhG/ea?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c43eee-54fd-420a-9fe9-08dd514a15f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:01:19.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vREz+o0uUwswqZS0oA6I79hvHqj+trDbou311mK8amtLokXh98QhktfgKbvimwNcRSdZ4u/0QbJVvscm2X9ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

On 2/17/2025 7:10 PM, Sathyanarayanan Kuppuswamy wrote:
> Hi Cedric,
> 
> On 2/12/25 6:23 PM, Cedric Xing wrote:
>> This commit extends the TSM core with support for CC measurement 
>> registers
>> (MRs).
>>
>> The newly added APIs are:
>>
>> - `tsm_register_measurement(struct tsm_measurement *)`: This API allows a
>>    CC guest driver to register a set of measurement registers with the 
>> TSM
>>    core.
>> - `tsm_unregister_measurement(struct tsm_measurement *)`: This API 
>> enables
>>    a CC guest driver to unregister a previously registered set of
>>    measurement registers.
>>
>> `struct tsm_measurement` has been defined to encapsulate the details of
>> CC-specific MRs. It includes an array of `struct 
>> tsm_measurement_register`s
>> and provides operations for reading and updating these registers. For a
>> comprehensive understanding of the structure and its usage, refer to the
>> detailed comments in `include/linux/tsm.h`.
>>
>> Upon successful registration of a measurement provider, the TSM core
>> exposes the MRs through a directory tree in the sysfs filesystem. The 
>> root
>> of this tree is located at `/sys/kernel/tsm/MR_PROVIDER/`, where
>> `MR_PROVIDER` is the name of the measurement provider (as specified by
>> `struct tsm_measurement::name`). Each MR is made accessible as either a
>> file or a directory of the specified name (i.e.,
>> `tsm_measurement_register::mr_name`). In the former case, the file 
>> content
> 
> May be include some info on when a MR can be just a file (like an example)
> 
Will do.

>> is the MR value; while in the latter case `HASH_ALG/digest` under the MR
>> directory contains the MR value, where `HASH_ALG` specifies the hash
>> algorithm (e.g., sha256, sha384, etc.) used by this MR.
>>
>> *Crypto Agility* is supported as a set of independent MRs that share a
>> common name. These MRs will be merged into a single MR directory and each
>> will be represented by its respective `HASH_ALG/digest` file. Note that
>> `tsm_measurement_register::mr_hash` must be distinct or the behavior is
>> undefined.
> 
> is this required/supported in any of the existing CC providers?
> 
> By sharing a common name, you mean internally there will be distinct
> registers for every crypto algo supported?
> 
This is explicitly requested by James Bottomley. And yes, an MR with >1 
algo is in fact a collection of independent MRs, even though they are 
referred to as the "banks" of the same MR in TCG/TPM spec.

>>
>> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
>> ---
>>   Documentation/ABI/testing/sysfs-kernel-tsm |  20 ++
>>   MAINTAINERS                                |   2 +-
>>   drivers/virt/coco/Kconfig                  |   3 +-
>>   drivers/virt/coco/Makefile                 |   2 +
>>   drivers/virt/coco/{tsm.c => tsm-core.c}    |   6 +-
>>   drivers/virt/coco/tsm-mr.c                 | 375 +++++++++++++++++++ 
>> ++++++++++
>>   include/linux/tsm.h                        |  64 +++++
>>   7 files changed, 469 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-tsm b/ 
>> Documentation/ABI/testing/sysfs-kernel-tsm
>> new file mode 100644
>> index 000000000000..99735cf4da5c
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-kernel-tsm
>> @@ -0,0 +1,20 @@
>> +What:        /sys/kernel/tsm/<measurement_provider>/<register>
> 
> Any reason for not using fixed name for registers (like mr[0-n])? May be it
> will help if user space use a generic code across vendors.
> 
The names of MRs identify the hardware resources, while the semantics of 
an MR (e.g., whose measurements it contains) is defined by applications. 
A good design should separate those two to allow applications to connect 
them as needed. For example, say all loadable modules must be measured 
before being loaded, and shall be measured/extended to rtmrX on arch A 
and to rtmrY on arch B, respectively. A portable implementation could 
always extend to "rtmrModule", which would be a symlink pointing to 
either rtmrX or rtmrY depending on the underlying arch. On the contrary, 
extending to the same mr[z] is equivalent to forcing z == X == Y, which 
_breaks_ portability as different archs tend to have different number of 
RTMRs.

One more thing worth noting here is: different archs may choose 
different hash algorithms for RTMRs, and that forces applications to be 
arch aware. The solution will be a "log centric" ABI that we don't have yet.

>> +Date:        February 2025
>> +Contact:    Cedric Xing <cedric.xing@intel.com>.
>> +Description:
>> +        This file contains the value of the measurement register
>> +        <register>. Depending on the CC architecture, this file may be
>> +        writable, in which case the value written will be the new value
>> +        of <register>. Each write must start at the beginning and be of
>> +        the same size as the file. Partial writes are not permitted.
>> +
>> +What:        /sys/kernel/tsm/<measurement_provider>/<register>/ 
>> <hash>/digest
>> +Date:        February 2025
>> +Contact:    Cedric Xing <cedric.xing@intel.com>.
>> +Description:
>> +        This file contains the value of the measurement register
>> +        <register>. Depending on the CC architecture, this file may be
>> +        writable, in which case any value written may be extended to
>> +        <register> using <hash>. Each write must start at the beginning
>> +        and be of the same size as the file. Partial writes are not
>> +        permitted.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 25c86f47353d..c129fccd3d5a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24098,7 +24098,7 @@ M:    Dan Williams <dan.j.williams@intel.com>
>>   L:    linux-coco@lists.linux.dev
>>   S:    Maintained
>>   F:    Documentation/ABI/testing/configfs-tsm
>> -F:    drivers/virt/coco/tsm.c
>> +F:    drivers/virt/coco/tsm*.c
>>   F:    include/linux/tsm.h
>>   TRUSTED SERVICES TEE DRIVER
>> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
>> index ff869d883d95..6f3c0831680b 100644
>> --- a/drivers/virt/coco/Kconfig
>> +++ b/drivers/virt/coco/Kconfig
>> @@ -5,7 +5,8 @@
>>   config TSM_REPORTS
>>       select CONFIGFS_FS
>> -    tristate
>> +    select CRYPTO_HASH_INFO
>> +    tristate "Trusted Security Module (TSM) sysfs/configfs support"
> 
> IMO, sysfs/configfs part is not required in the title.
> 
Ok. I'll take it out.

>>   source "drivers/virt/coco/efi_secret/Kconfig"
>> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
>> index c3d07cfc087e..4b108d8df1bd 100644
>> --- a/drivers/virt/coco/Makefile
>> +++ b/drivers/virt/coco/Makefile
>> @@ -2,6 +2,8 @@
>>   #
>>   # Confidential computing related collateral
>>   #
>> +tsm-y                += tsm-core.o tsm-mr.o
>> +
>>   obj-$(CONFIG_TSM_REPORTS)    += tsm.o
>>   obj-$(CONFIG_EFI_SECRET)    += efi_secret/
>>   obj-$(CONFIG_ARM_PKVM_GUEST)    += pkvm-guest/
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm-core.c
>> similarity index 99%
>> rename from drivers/virt/coco/tsm.c
>> rename to drivers/virt/coco/tsm-core.c
>> index 9432d4e303f1..ab5269db9c13 100644
>> --- a/drivers/virt/coco/tsm.c
>> +++ b/drivers/virt/coco/tsm-core.c
>> @@ -476,6 +476,9 @@ int tsm_unregister(const struct tsm_ops *ops)
>>   }
>>   EXPORT_SYMBOL_GPL(tsm_unregister);
>> +int tsm_mr_init(void);
>> +void tsm_mr_exit(void);
>> +
>>   static struct config_group *tsm_report_group;
>>   static int __init tsm_init(void)
>> @@ -497,12 +500,13 @@ static int __init tsm_init(void)
>>       }
>>       tsm_report_group = tsm;
>> -    return 0;
>> +    return tsm_mr_init();
>>   }
>>   module_init(tsm_init);
>>   static void __exit tsm_exit(void)
>>   {
>> +    tsm_mr_exit();
>>       configfs_unregister_default_group(tsm_report_group);
>>       configfs_unregister_subsystem(&tsm_configfs);
>>   }
>> diff --git a/drivers/virt/coco/tsm-mr.c b/drivers/virt/coco/tsm-mr.c
>> new file mode 100644
>> index 000000000000..8d26e952da6b
>> --- /dev/null
>> +++ b/drivers/virt/coco/tsm-mr.c
>> @@ -0,0 +1,375 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <crypto/hash.h>
>> +#include <crypto/hash_info.h>
>> +#include <linux/kobject.h>
>> +#include <linux/module.h>
>> +#include <linux/tsm.h>
>> +
>> +int tsm_mr_init(void);
>> +void tsm_mr_exit(void);
>> +
>> +enum tmr_dir_battr_index {
>> +    TMR_DIR_BA_DIGEST,
>> +    TMR_DIR_BA__COUNT,
> 
> Why not use single underscore uniformly?
> 
DIGEST is a bin attribute while _COUNT is the _count_ of bin attributes. 
If w/o the underscore, COUNT would look like another bin attribute.

>> +
>> +    TMR_DIR__ALGO_MAX = 4,
> 
> Since this is not related to attribute index, why not use #define?
> 
Now I'm thinking of making it a CONFIG option, default to 4.

>> +};
>> +
>> +struct tmr_dir {
>> +    struct kobject kobj;
>> +    struct bin_attribute battrs[TMR_DIR__ALGO_MAX][TMR_DIR_BA__COUNT];
>> +    int algo;
>> +};
>> +
>> +struct tmr_provider {
>> +    struct kset kset;
>> +    struct rw_semaphore rwsem;
>> +    struct bin_attribute *mrfiles;
>> +    struct tsm_measurement *tmr;
>> +    bool in_sync;
>> +};
>> +
>> +static inline struct tmr_provider *tmr_mr_to_provider(const struct 
>> tsm_measurement_register *mr,
>> +                              struct kobject *kobj)
>> +{
>> +    if (mr->mr_flags & TSM_MR_F_F)
>> +        return container_of(kobj, struct tmr_provider, kset.kobj);
>> +    else
>> +        return container_of(kobj->kset, struct tmr_provider, kset);
>> +}
>> +
>> +static inline int tmr_call_refresh(struct tmr_provider *pvd,
>> +                   const struct tsm_measurement_register *mr)
>> +{
>> +    int rc;
>> +
>> +    rc = pvd->tmr->refresh(pvd->tmr, mr);
>> +    if (rc)
>> +        pr_warn("%s.refresh(%s) failed %d\n", kobject_name(&pvd- 
>> >kset.kobj), mr->mr_name,
>> +            rc);
>> +    return rc;
>> +}
>> +
>> +static inline int tmr_call_extend(struct tmr_provider *pvd,
>> +                  const struct tsm_measurement_register *mr, const u8 
>> *data)
>> +{
>> +    int rc;
>> +
>> +    rc = pvd->tmr->extend(pvd->tmr, mr, data);
>> +    if (rc)
>> +        pr_warn("%s.extend(%s) failed %d\n", kobject_name(&pvd- 
>> >kset.kobj), mr->mr_name,
>> +            rc);
>> +    return rc;
>> +}
>> +
>> +static ssize_t tmr_digest_read(struct file *filp, struct kobject 
>> *kobj, struct bin_attribute *attr,
>> +                   char *page, loff_t off, size_t count)
>> +{
>> +    const struct tsm_measurement_register *mr;
>> +    struct tmr_provider *pvd;
>> +    int rc;
>> +
>> +    if (off < 0 || off > attr->size)
>> +        return -EINVAL;
>> +
>> +    count = min(count, attr->size - (size_t)off);
>> +    if (!count)
>> +        return count;
>> +
>> +    mr = (typeof(mr))attr->private;
> 
> I think you don't need to cast it.
> 
Thanks! I'll remove it.

>> +    pvd = tmr_mr_to_provider(mr, kobj);
>> +    rc = down_read_interruptible(&pvd->rwsem);
>> +    if (rc)
>> +        return rc;
>> +
>> +    if ((mr->mr_flags & TSM_MR_F_L) && !pvd->in_sync) {
>> +        up_read(&pvd->rwsem);
>> +
>> +        rc = down_write_killable(&pvd->rwsem);
>> +        if (rc)
>> +            return rc;
>> +
>> +        if (!pvd->in_sync) {
> 
> Since this path is only taken if in_sync is false, do you need to check 
> again?
> 
Yes, because in_sync could be set to true between up_read and 
down_write_killable above.

>> +            rc = tmr_call_refresh(pvd, mr);
>> +            pvd->in_sync = !rc;
>> +        }
>> +
>> +        downgrade_write(&pvd->rwsem);
>> +    }
>> +
>> +    if (!rc)
>> +        memcpy(page, mr->mr_value + off, count);
>> +
>> +    up_read(&pvd->rwsem);
>> +    return rc ?: count;
>> +}
>> +
>> +static ssize_t tmr_digest_write(struct file *filp, struct kobject 
>> *kobj, struct bin_attribute *attr,
>> +                char *page, loff_t off, size_t count)
>> +{
>> +    const struct tsm_measurement_register *mr;
>> +    struct tmr_provider *pvd;
>> +    ssize_t rc;
>> +
>> +    if (off != 0 || count != attr->size)
>> +        return -EINVAL;
>> +
>> +    mr = (typeof(mr))attr->private;
>> +    pvd = tmr_mr_to_provider(mr, kobj);
>> +    rc = down_write_killable(&pvd->rwsem);
>> +    if (rc)
>> +        return rc;
>> +
>> +    if (mr->mr_flags & TSM_MR_F_X)
>> +        rc = tmr_call_extend(pvd, mr, page);
>> +    else
>> +        memcpy(mr->mr_value, page, count);
>> +
>> +    if (!rc)
>> +        pvd->in_sync = false;
>> +
>> +    up_write(&pvd->rwsem);
>> +    return rc ?: count;
>> +}
>> +
>> +static void tmr_dir_release(struct kobject *kobj)
>> +{
>> +    struct tmr_dir *mrd;
>> +
>> +    mrd = container_of(kobj, typeof(*mrd), kobj);
>> +    kfree(mrd);
>> +}
>> +
>> +static const struct kobj_type tmr_dir_ktype = {
>> +    .release = tmr_dir_release,
>> +    .sysfs_ops = &kobj_sysfs_ops,
>> +};
>> +
>> +static struct tmr_dir *tmr_dir_create(const struct 
>> tsm_measurement_register *mr,
>> +                      struct tmr_provider *pvd)
>> +{
>> +    struct kobject *kobj;
>> +    struct tmr_dir *mrd;
>> +
>> +    kobj = kset_find_obj(&pvd->kset, mr->mr_name);
>> +    if (kobj) {
>> +        mrd = container_of(kobj, typeof(*mrd), kobj);
>> +        kobject_put(kobj);
>> +        if (++mrd->algo >= TMR_DIR__ALGO_MAX) {
>> +            --mrd->algo;
>> +            return ERR_PTR(-ENOSPC);
>> +        }
>> +    } else {
>> +        int rc;
>> +
>> +        mrd = kzalloc(sizeof(*mrd), GFP_KERNEL);
>> +        if (!mrd)
>> +            return ERR_PTR(-ENOMEM);
>> +
>> +        mrd->kobj.kset = &pvd->kset;
>> +        rc = kobject_init_and_add(&mrd->kobj, &tmr_dir_ktype, NULL, 
>> "%s", mr->mr_name);
>> +        if (rc) {
>> +            kfree(mrd);
>> +            return ERR_PTR(rc);
>> +        }
>> +    }
>> +
>> +    sysfs_bin_attr_init(&mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST]);
>> +    mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].attr.name = "digest";
> 
> Since this attribute reflects register value, personally I think "value" 
> is more clear
> than "digest". But it is fine either way.
> 
This attribute shows up only when its parent dir is a hash algo name 
(e.g., "sha384"). So "digest" I believe is more appropriate to refer to 
the result of the hash.

>> +    if (mr->mr_flags & TSM_MR_F_W)
>> +        mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].attr.mode |= 
>> S_IWUSR | S_IWGRP;
>> +    if (mr->mr_flags & TSM_MR_F_R)
>> +        mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].attr.mode |= S_IRUGO;
>> +
>> +    mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].size = mr->mr_size;
>> +    mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].read = tmr_digest_read;
>> +    mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].write = tmr_digest_write;
>> +    mrd->battrs[mrd->algo][TMR_DIR_BA_DIGEST].private = (void *)mr;
>> +
>> +    return mrd;
>> +}
>> +
>> +static void tmr_provider_release(struct kobject *kobj)
>> +{
>> +    struct tmr_provider *pvd;
>> +
>> +    pvd = container_of(kobj, typeof(*pvd), kset.kobj);
>> +    if (!WARN_ON(!list_empty(&pvd->kset.list))) {
>> +        kfree(pvd->mrfiles);
>> +        kfree(pvd);
>> +    }
>> +}
>> +
>> +static const struct kobj_type _mr_provider_ktype = {
>> +    .release = tmr_provider_release,
>> +    .sysfs_ops = &kobj_sysfs_ops,
>> +};
>> +
>> +static struct kset *tmr_sysfs_root;
>> +
>> +static struct tmr_provider *tmr_provider_create(struct 
>> tsm_measurement *tmr)
>> +{
>> +    struct tmr_provider *pvd __free(kfree);
>> +    int rc;
>> +
>> +    pvd = kzalloc(sizeof(*pvd), GFP_KERNEL);
>> +    if (!pvd)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    if (!tmr->name || !tmr->mrs || !tmr->refresh || !tmr->extend)
>> +        return ERR_PTR(-EINVAL);
> 
> Why not add this condition at the top before allocation?
> 
Because a few bytes can be saved this way (by not initializing pvd). The 
difference (in performance) will only be on the error path, which we 
don't care.

>> +
>> +    rc = kobject_set_name(&pvd->kset.kobj, "%s", tmr->name);
>> +    if (rc)
>> +        return ERR_PTR(rc);
>> +
>> +    pvd->kset.kobj.kset = tmr_sysfs_root;
>> +    pvd->kset.kobj.ktype = &_mr_provider_ktype;
>> +    pvd->tmr = tmr;
>> +
>> +    init_rwsem(&pvd->rwsem);
>> +
>> +    rc = kset_register(&pvd->kset);
>> +    if (rc)
>> +        return ERR_PTR(rc);
>> +
>> +    return_ptr(pvd);
>> +}
>> +
>> +DEFINE_FREE(_unregister_measurement, struct tmr_provider *,
>> +        if (!IS_ERR_OR_NULL(_T)) tsm_unregister_measurement(_T->tmr));
>> +
>> +int tsm_register_measurement(struct tsm_measurement *tmr)
>> +{
>> +    struct tmr_provider *pvd __free(_unregister_measurement);
>> +    int rc, nr;
>> +
>> +    pvd = tmr_provider_create(tmr);
>> +    if (IS_ERR(pvd))
>> +        return PTR_ERR(pvd);
>> +
>> +    nr = 0;
>> +    for (int i = 0; tmr->mrs[i].mr_name; ++i) {
>> +        // flat files are counted and skipped
>> +        if (tmr->mrs[i].mr_flags & TSM_MR_F_F) {
>> +            ++nr;
>> +            continue;
>> +        }
>> +
>> +        struct tmr_dir *mrd;
>> +        struct bin_attribute *battrs[TMR_DIR_BA__COUNT + 1] = {};
>> +        struct attribute_group agrp = {
>> +            .name = hash_algo_name[tmr->mrs[i].mr_hash],
>> +            .bin_attrs = battrs,
>> +        };
>> +
>> +        mrd = tmr_dir_create(&tmr->mrs[i], pvd);
>> +        if (IS_ERR(mrd))
>> +            return PTR_ERR(mrd);
>> +
>> +        for (int j = 0; j < TMR_DIR_BA__COUNT; ++j)
>> +            battrs[j] = &mrd->battrs[mrd->algo][j];
>> +
>> +        rc = sysfs_create_group(&mrd->kobj, &agrp);
>> +        if (rc)
>> +            return rc;
>> +    }
>> +
>> +    if (nr > 0) {
>> +        struct bin_attribute *mrfiles __free(kfree);
>> +        struct bin_attribute **battrs __free(kfree);
>> +
>> +        mrfiles = kcalloc(nr, sizeof(*mrfiles), GFP_KERNEL);
>> +        battrs = kcalloc(nr + 1, sizeof(*battrs), GFP_KERNEL);
>> +        if (!battrs || !mrfiles)
>> +            return -ENOMEM;
>> +
>> +        for (int i = 0, j = 0; tmr->mrs[i].mr_name; ++i) {
>> +            if (!(tmr->mrs[i].mr_flags & TSM_MR_F_F))
>> +                continue;
>> +
>> +            mrfiles[j].attr.name = tmr->mrs[i].mr_name;
>> +            mrfiles[j].read = tmr_digest_read;
>> +            mrfiles[j].write = tmr_digest_write;
>> +            mrfiles[j].size = tmr->mrs[i].mr_size;
>> +            mrfiles[j].private = (void *)&tmr->mrs[i];
>> +            if (tmr->mrs[i].mr_flags & TSM_MR_F_R)
>> +                mrfiles[j].attr.mode |= S_IRUGO;
>> +            if (tmr->mrs[i].mr_flags & TSM_MR_F_W)
>> +                mrfiles[j].attr.mode |= S_IWUSR | S_IWGRP;
>> +
>> +            battrs[j] = &mrfiles[j];
>> +            ++j;
>> +        }
>> +
>> +        struct attribute_group agrp = {
>> +            .bin_attrs = battrs,
>> +        };
>> +        rc = sysfs_create_group(&pvd->kset.kobj, &agrp);
>> +        if (rc)
>> +            return rc;
>> +
>> +        pvd->mrfiles = no_free_ptr(mrfiles);
>> +    }
>> +
>> +    // initial refresh of MRs
>> +    rc = tmr_call_refresh(pvd, NULL);
>> +    pvd->in_sync = !rc;
>> +
>> +    pvd = NULL; // to avoid being freed automatically
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_register_measurement);
>> +
>> +static void tmr_put_children(struct kset *kset)
>> +{
>> +    struct kobject *p, *n;
>> +
>> +    spin_lock(&kset->list_lock);
>> +    list_for_each_entry_safe(p, n, &kset->list, entry) {
>> +        spin_unlock(&kset->list_lock);
>> +        kobject_put(p);
>> +        spin_lock(&kset->list_lock);
>> +    }
>> +    spin_unlock(&kset->list_lock);
>> +}
>> +
>> +int tsm_unregister_measurement(struct tsm_measurement *tmr)
>> +{
>> +    struct kobject *kobj;
>> +    struct tmr_provider *pvd;
>> +
>> +    kobj = kset_find_obj(tmr_sysfs_root, tmr->name);
>> +    if (!kobj)
>> +        return -ENOENT;
>> +
>> +    pvd = container_of(kobj, typeof(*pvd), kset.kobj);
>> +    if (pvd->tmr != tmr)
>> +        return -EINVAL;
>> +
>> +    tmr_put_children(&pvd->kset);
>> +    kset_unregister(&pvd->kset);
>> +    kobject_put(kobj);
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_unregister_measurement);
>> +
>> +int tsm_mr_init(void)
>> +{
>> +    tmr_sysfs_root = kset_create_and_add("tsm", NULL, kernel_kobj);
>> +    if (!tmr_sysfs_root)
>> +        return -ENOMEM;
>> +    return 0;
>> +}
>> +
>> +void tsm_mr_exit(void)
>> +{
>> +    kset_unregister(tmr_sysfs_root);
>> +}
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Provide Trusted Security Module measurements via 
>> sysfs");
>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>> index 11b0c525be30..624a7b62b85d 100644
>> --- a/include/linux/tsm.h
>> +++ b/include/linux/tsm.h
>> @@ -5,6 +5,7 @@
>>   #include <linux/sizes.h>
>>   #include <linux/types.h>
>>   #include <linux/uuid.h>
>> +#include <uapi/linux/hash_info.h>
>>   #define TSM_INBLOB_MAX 64
>>   #define TSM_OUTBLOB_MAX SZ_32K
>> @@ -109,4 +110,67 @@ struct tsm_ops {
>>   int tsm_register(const struct tsm_ops *ops, void *priv);
>>   int tsm_unregister(const struct tsm_ops *ops);
>> +
>> +/**
>> + * struct tsm_measurement_register - describes an architectural 
>> measurement register (MR)
>> + * @mr_name: name of the MR
>> + * @mr_value: buffer containing the current value of the MR
>> + * @mr_size: size of the MR - typically the digest size of @mr_hash
>> + * @mr_flags: bitwise OR of flags defined in enum 
>> tsm_measurement_register_flag
>> + * @mr_hash: optional hash identifier defined in include/uapi/linux/ 
>> hash_info.h
>> + *
>> + * A CC guest driver provides this structure to detail the 
>> measurement facility supported by the
>> + * underlying CC hardware. After registration via 
>> `tsm_register_measurement`, the CC guest driver
>> + * must retain this structure until it is unregistered using 
>> `tsm_unregister_measurement`.
>> + */
>> +struct tsm_measurement_register {
>> +    const char *mr_name;
>> +    void *mr_value;
>> +    u32 mr_size;
>> +    u32 mr_flags;
>> +    enum hash_algo mr_hash;
>> +};
>> +
>> +/**
>> + * enum tsm_measurement_register_flag - properties of an MR
>> + * @TSM_MR_F_X: this MR supports the extension semantics on write
> 
> Why not use _E? Before reading the help text, I thought _X is for execute.
> 
I was thinking of HTTP and X.509, all extensions are marked by "x".

Anyone else having a preference on _E vs. _X?

>> + * @TSM_MR_F_W: this MR is writable
>> + * @TSM_MR_F_R: this MR is readable. This should typically be set
>> + * @TSM_MR_F_L: this MR is live - writes to other MRs may change this MR
>> + * @TSM_MR_F_F: present this MR as a file (instead of a directory)
>> + * @TSM_MR_F_LIVE: shorthand for L (live) and R (readable)
>> + * @TSM_MR_F_RTMR: shorthand for LIVE and X (extensible)
>> + */
>> +enum tsm_measurement_register_flag {
>> +    TSM_MR_F_X = 1,
>> +    TSM_MR_F_W = 2,
> 
> It is not clear why you want to differentiate between write and extension.
> Please add some help text related to it.
> 
R/W is for controlling the file permission of the MR, while X is the 
semantics of the MR. I'll try to clarify.

>> +    TSM_MR_F_R = 4,
>> +    TSM_MR_F_L = 8,
>> +    TSM_MR_F_F = 16,
>> +    TSM_MR_F_LIVE = TSM_MR_F_L | TSM_MR_F_R,
>> +    TSM_MR_F_RTMR = TSM_MR_F_LIVE | TSM_MR_F_X,
>> +};
>> +
>> +#define TSM_MR_(mr, 
>> hash)                                                           \
>> +    .mr_name = #mr, .mr_size = hash##_DIGEST_SIZE, .mr_hash = 
>> HASH_ALGO_##hash, \
>> +    .mr_flags = TSM_MR_F_R
>> +
>> +/**
>> + * struct tsm_measurement - define CC specific MRs and methods for 
>> updating them
>> + * @name: name of the measurement provider
>> + * @mrs: array of MR definitions ending with mr_name set to %NULL
>> + * @refresh: invoked to update the specified MR
>> + * @extend: invoked to extend the specified MR with mr_size bytes
>> + */
>> +struct tsm_measurement {
>> +    const char *name;
>> +    const struct tsm_measurement_register *mrs;
>> +    int (*refresh)(struct tsm_measurement *tmr, const struct 
>> tsm_measurement_register *mr);
>> +    int (*extend)(struct tsm_measurement *tmr, const struct 
>> tsm_measurement_register *mr,
>> +              const u8 *data);
>> +};
>> +
>> +int tsm_register_measurement(struct tsm_measurement *tmr);
>> +int tsm_unregister_measurement(struct tsm_measurement *tmr);
>> +
>>   #endif /* __TSM_H */
>>


