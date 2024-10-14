Return-Path: <linux-kernel+bounces-364477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B657099D519
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D43B1F2435B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C6C1C3050;
	Mon, 14 Oct 2024 16:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6LLADnA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CC1C3027;
	Mon, 14 Oct 2024 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925183; cv=fail; b=KxmDxxSHV4GFr7JqNJlZXd6ONO4/8xbensQuVXxhGnqdDel+cr3YyNTvei3IN/dswC7kpBw+JsyApEEG5ko9/puU1zOvegVLIb+BCtebv3uGn4vw11SGXTbl/Xl7kx3ZRejJTPDp3BMJW1Vq4XOd2eGveTbDyK7YNCR4wAtkTmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925183; c=relaxed/simple;
	bh=Q0V6fXuaxQqokU/kLEnA/f3gGwg+Mg+Ij7I25TZ1xS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fwxkmddxS0zYizITz2O4LFmWhy2tbPWY48XqIcnIwSYAQbbLJQntUXqmTXxQ7alCxb8h/yppS0Y/vQOJZr5gCNNqQWcTKhJROwwCQPjBI49LXwxHOU/KTunVGZTlMcM62q/o8MADKnP9gDauBO3xq7hJTfv7pEmbMSwuX1adb/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6LLADnA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728925181; x=1760461181;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q0V6fXuaxQqokU/kLEnA/f3gGwg+Mg+Ij7I25TZ1xS8=;
  b=d6LLADnAa5v9RIzknUdWqRjgeQ5fJzJswKCjn1LdkNNPZPyclbKP/b5y
   SFo/rgEQbNmbnMWtTOyiCDSERMA/rb197ipdF+g+9uW1kIKq/plkO8Gnw
   fehL43+okJAbVEWrxb5lD7JAK8ckI8begtyMsbDWMEabTW+2HFGIJDWen
   mbWcxTWWMRfyc0X+vA2ZcxF3bkePun2W2GMXj+6onWlwJ31PcEv6jJy5J
   XAK9nYcPG6Q6QRtUgJu/tQPdT5YA16ADl5N+vy+c2rBBJFiamtebdx4Q5
   cG7pu7RTPc2HxBt4u6MMKD/nWxL7460aF9IkUdwyaLhNAhc9oDywZeaBt
   g==;
X-CSE-ConnectionGUID: CmLZ1epkQ5eg2kX6FJzRrA==
X-CSE-MsgGUID: 4HcqukZVTtWcq/w3G0D11w==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="32084335"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="32084335"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 09:59:40 -0700
X-CSE-ConnectionGUID: a8kX9hy0SdCKoCIug5JELg==
X-CSE-MsgGUID: 8GPnqTIURiWaDh/V54NdTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77565002"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 09:59:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 09:59:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 09:59:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 09:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS+gCY9xPgXvj08DpoIxMpkswwYn8whiGBdcVQnExomZqNK6bXJFUZia8fFy7VkLJLjTQsVzoMutnsV7IXhKDFpcCLxam+hLdDDYN5j3PVXJ6dztDkwNyJlrie+RlU/YP4slpe8WrE38xCG5b+LxI+NULZOagaIL0uMDCCfIjSK/4G/i5Zpc/+gnIvqsj8JXsf2gS8SRyk/PwOygIgEXVl3ZZBI4WuKpPtBkpj630HJFuyc7YtbBTDrhdOaDKxdIn3ku5wWcT/ebQWCDNSf0KBAaRhNibiOXvrG0ftCfTUWRTOnZYKe9/vUqAx1mO/kYT+qIYFMHhtRbmkugC87K4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN/bLpPQ8sdN7WBOml8/y8wbZQw4snTJN5Hw3PZkuDY=;
 b=nFc9uuGHF2bZPkaL+CWb4DN0djUiLJb62NK/tmjjgsQ1OL7t6jWjdUrP9a07XGnUfrpDOHYD8gsIwzIdtBNvWto7ITatZ8pN4EdmkuxGDXx0uAcoGlIaGsgGHCR9DSW8eIWKJqfYL22JCHhzW6uokiQR7ioN/TdeCFLwq+ZLWOreDpJYwgckzQp0jq80ubPok9ChLbP4PBW4SP/IZqQmWb70Xx7lFz6fM/AmwJtYDA6bTzZzJoXDF3oYK8gKq1m0Tf3cNSphjPaU812Cd4mxel9/FxR83yaXIW1rEfcxJVasIOzSkDY0eomTbhs3LyBz+C3ZE9RzEB7DiGRw0RsIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 16:59:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:59:34 +0000
Message-ID: <aa991714-0f08-4f30-9bfb-b34e4aebcf86@intel.com>
Date: Mon, 14 Oct 2024 09:59:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: <babu.moger@amd.com>, "Luck, Tony" <tony.luck@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0307.namprd03.prod.outlook.com
 (2603:10b6:303:dd::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f20736-48c6-434d-9c54-08dcec719440
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGV3aE42cEtHNXFKakJybGpwaGFBYy80NXBMTFh6bExvUnFaKys5Rml6dnhh?=
 =?utf-8?B?QTNxY3ZEcEpZUjRRSWg2L0M5dWc0TGZtSGk0RW1uOFd4cy9DMFNjbDArU3Fz?=
 =?utf-8?B?TjlHU09ydWl2TVU1V1lNRlF0UFRvL0UzU3ArVmVoVnhYVEx1eWdodUxGYkRB?=
 =?utf-8?B?VFlleS9QUWJPdEpteG5lUlg1bEVsSFBVNzZ0M3dFYXhuU0pkU3hXeUxlUlNj?=
 =?utf-8?B?OWRHU0pBNTZNRnFJNkZUZjBQSzB5MEhnN0QzMWdwNG4yRFN3Mk44aVZOTzVU?=
 =?utf-8?B?YnhIbWUzODFHMkdoclRiRU5FTHV3bFVGa2kyOFYyd1RBZ21NZnNLaURlSjNT?=
 =?utf-8?B?RGVMbmZxb3VnUzNGcGRsYnZ1ZmM0RXo4U2ZCalJtN0RuNFl2OHZITzR3Nzhl?=
 =?utf-8?B?TW9hVGxpRXlSNXlBWC9XM1BVYTBZQkN6RkdyNVBwbm5MNEFSMTNSUDZTbVNU?=
 =?utf-8?B?YjVQbU0wTkIwb3hTUVdLOEhzYmxWY0w5T2FKV3ZxYzl6NWtFdEJiUlAzNGdZ?=
 =?utf-8?B?Zlpla3FvNDhadEJ2L0g2SjBzbmxnSGJ0cjRWTVU0TkN4ZFNlUDlrNkRGcGRY?=
 =?utf-8?B?eSt3QU5Fd0ZPdzJFcHliTHlwVlBFckt2VHBUQXZlNmdhTlp2eWtlMXQwMG53?=
 =?utf-8?B?TlQwRFlsc0swTUJmZXFnVmFPZ1pDbGx2TWJyMHRvRU42aVUzN1I1c3ZsbHQz?=
 =?utf-8?B?RHBOV3RMYU9qdVhUSnRJYWhmdGNlUXJQSWNpbk5rM3VTWkVucGxOSmFNeTF2?=
 =?utf-8?B?U1prVUIvdTBGTHBrMXUxZ3ZpWkdMaTBlR3p2aUd3YlFHUENJTUFLZUZoTDdz?=
 =?utf-8?B?TmZqR3IwNDlIVlpUS1FIT1dZUlNWWEcwNmVyb1R6TEJzYWVsZ3JzNkZOMDRl?=
 =?utf-8?B?cTBqUjVBNDJWRldkYnVRckp0Q1VJRUlEUmllNEZ5bmlKNHdxNUZ2Q3hCaFVq?=
 =?utf-8?B?WGlham5JVWltam1aUE9tc0lWYytKcmVGMG9PekRxZVcvcXhxMzREeFpMVXhP?=
 =?utf-8?B?SzVUL1dQRHU5eGIyeEUyQ05QZDR3ZnhvQzFLdTFmWjNhcXczMklJRk9NZmx3?=
 =?utf-8?B?TnVoOUJGajhVenA1MjFONldjSDVCdE42UDhzajNLZzB6WGxRTVNHQ3dUMzlx?=
 =?utf-8?B?a2krcU5XSENyWFBuMWpoeE9ncU5yclZwd3ZsZU00WjFkT0FMM1VoTHc0N3No?=
 =?utf-8?B?WUcvaXJoL2xtY3JoR2IwSTB5R0l6ZGRQbFRoTjQ0OW1LSzU2OHk0OGFtZTBR?=
 =?utf-8?B?dTVuMTlPWlJ5Ri8wc1JCRm5aNmYzTE1iNDMxVmZhZEdRQlJXanl2S1hXOWJE?=
 =?utf-8?B?ZjZWeEMwQTN6VlZjVVJ1SWIrdUptU2NRaGxTWkR5Ui9SNklIRER2NmhPZ0ti?=
 =?utf-8?B?a2dYang0RG5ZelBlakY1WFNTL3dBZitpWlhKeEorTVdpcEI4VStNMmR0RkJq?=
 =?utf-8?B?a1ZMQnZPSzArelkveEtNZEVBN0dGL1UwK3BSUngvNmcyR0NBVFhKTG42bHpT?=
 =?utf-8?B?S3RkUktmMGcyUFBNMnhjRkc5c21aZUVUdE42eUlDenlvSElEREVjcHgxV1Qr?=
 =?utf-8?B?QkdQOWFtSlBmSU1wNnFlM0J6VmtUOUpVOW5TMUhCaDlRVENjU1pkRFJoSkhN?=
 =?utf-8?B?N3FMbjVHZGMwazJhQTVQVllLTDZUbStIbDl1SlJzemJNNDcyVWdscnE4SkU3?=
 =?utf-8?B?dTZNdzN6eHoweGlnekNZcUFlTURrWHovbUxaTk9PVVZ6NWhPR3BoSEJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0dWNW1Jck83M0F5cFFycjhrZkpDeXZIS21GaElxV2c3SzYxU0c2YXFaN3N4?=
 =?utf-8?B?dGlNU01NMlZmRmZycHVEaVlBTEZYNWlmRkZPM0RYRE1uK2ExN3dGZ0FzTUh0?=
 =?utf-8?B?akJ5R3RyMUhxVzBuSWErSGYwc0diRGtvUVVTT2tqOWFIbnFBSi9BMVdNNkZU?=
 =?utf-8?B?Q1B3UzlyZXhUTDNUUFpFaHdMY1pFY2sxZDZYRkNLaU1IOUlKeU5ZTGNZTytX?=
 =?utf-8?B?VktJOXlIRWhQZWpLTFl6ZmhEdE5YWXMxR09xMkRIU09JOGcrTVNDMVAzaU5O?=
 =?utf-8?B?cjZYNjVHM0VDOWdHMFppYVZXN2FhQTdFcHUwVDV1TnlvS2FUemtMbVc0MC94?=
 =?utf-8?B?Z2hjZjNLTDMzckVXalcyMGdCTjNveUl3aE1zVndkN2hjc3FTbFh5ZXVjaFZP?=
 =?utf-8?B?cmhwMGg1aGU1cWVwbk81eTBYM1V1TjQ1bExvbVAreTRhc0JlQkZheHRFZWIx?=
 =?utf-8?B?bk5qRTJaVCswendXNXloRGFxV1BQV1p3Ry91ZWZmc3FNRHZzTmQrdkNFVjJ1?=
 =?utf-8?B?cFBYK25CbERUS2NGUmc2dlQ1ODRsWHNMd0pTVy9yengvYytJRzY1SlpwZk5v?=
 =?utf-8?B?SGZGaENNUTBFcHllRHI2aFcrQlp1elF1V1dja25RWUhHZEtsTVNObGc0NWMx?=
 =?utf-8?B?aklFajQ1bHBSNDJiQk5tTkFmYndWeWlwUHJhNHNYeDhtSVpVeWVWV0hLM3NF?=
 =?utf-8?B?OFlwNWJ6U3VYVVN1c0wwVmhQRDhpQnFHejNteENNWTRTMTF0UzZNcHkvcDZP?=
 =?utf-8?B?Mzh0ODZWYzQ0Sm5SZUU2WUhxeDZaVmd4THArRWVKUUl1MEZhbENhd0plSFdL?=
 =?utf-8?B?c3dQUjRqSG1ZYkhxeUNNUDVKd1pzOFF3azJUK1ZZa243clI0aGRZaktxKzNI?=
 =?utf-8?B?SjNyVGhtY1JENWUyMVY3dXRQN085RHV2RE9USUxORDhuRFNNaGYrMTF5emtX?=
 =?utf-8?B?NmFDRVpSaVlpcFpXNHQ1eUZoS1ZMQnlPZVc4ZXpob215WG1ZdjRkOHFtWitQ?=
 =?utf-8?B?MDUxeVFpL2I0TUZaWE1FdVZCNkFWdlBaNlBqbHV3MW1XSHl5UWVuZGVCWkpD?=
 =?utf-8?B?M3l1WWNadFFpWFR4RE04S21QUlg3MlJPY01zd2grZXNobUszaG9GYUw0VnhE?=
 =?utf-8?B?MHlJZlRmS2EvMDZ0cGhHaDUreGJsUmtGQk84QmJxVnpvVVRWSktRU0ljU2xl?=
 =?utf-8?B?Q0taamx1RGdYUWlDaGd1M2J3YnhFNCtSTlc1RDgwM1NDcXp6YnpLd2MxQklC?=
 =?utf-8?B?UE5lVm15dUMyOE1MellYK1FJZ3dtU1RpV3QyVTYvaHY0RGdnb2NJTXNDaTBM?=
 =?utf-8?B?anpUNmZIWS9RbkJ1WStNMDNUWEc5RE1TSUQxaDduZ1JLUEJSQ0NvS1VFeTU5?=
 =?utf-8?B?bU50N3laaE5iYkZTQnB6MWRNekxXdWk5Q1Y2T1JGTGgwa2xjVFIxbkhHcjhW?=
 =?utf-8?B?N092NkI5anZ4cXhiQW44NTB0cDA3dmFLM1NOUnFYQk9Dc29EeWJTVStoMXAx?=
 =?utf-8?B?bG5vQ09hSkd4UGpMNkI5WGpZaEh2Y0kxZ2JTcEcwREd3WU11cXhYQUNQVzBk?=
 =?utf-8?B?N1lORmJldmxKd0JXaDBNMHQzYVp2L2cvRm0zK0M5WDhjL1NMTm4vWXVQNnR5?=
 =?utf-8?B?WW04emRPV3dJVTJGZFBHREJtK0dqcHNBNnpmdEM4cHoxa09PQWxQUHZYUzdn?=
 =?utf-8?B?N2RWSmRqdlVHQzgxd2I2UnFsRFdsdEtCUWlIbXg4VUtFYlZ0dkNTeXhNaytt?=
 =?utf-8?B?bzZGbnAyeVJIcmxhT0JQWEgzTjhvSithRmYxVEdrbll3ZGdNNUhrdmRjemNO?=
 =?utf-8?B?c050UkgyTytNTllRK2lBMlNZUUkzZWloMyt5Y3RVeDVGbWJMZytaWXJQelhx?=
 =?utf-8?B?czlJU1VjRWZMajlCTWJPL2htMFhjYWdKb1MxcXViaUpHdXBiT1NpVFlzalFz?=
 =?utf-8?B?SVNQSFJtZVQvT1RZU1RNT1hkTGFoaTNBbTNHeXc4Q3lYSkZQV2UrM0piYVB5?=
 =?utf-8?B?by9SL2hpNDl2dmJJMWtmSjZubUd2eVhpbVh0djdGVTdKdkNialVXRzJ2K0Nj?=
 =?utf-8?B?QnB2SWU5RVJMNXZJb0x0K0gvYVN0cktDelVqUkFBWG1URTRsMCtTME13UjRQ?=
 =?utf-8?B?Z3ZyTTRkQXVrdFV2R3ozS3JoNHRHNGtUKzgzMXN1SURxcG4ySHF0LzBBU1NG?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f20736-48c6-434d-9c54-08dcec719440
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:59:34.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkLONY4l020B1bQa6OwR15IorUL6sKfXuTZiiS8MBLSyCNWgVT+ebo4uKcYEhKV7rFNuhHecHahd8IX7jjRAhEo1kCknWgY1IyQDDcUeZD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com

Hi Tony and Babu,

On 10/10/24 11:36 AM, Moger, Babu wrote:
> Hi Tony,
> 
> On 10/10/24 12:08, Luck, Tony wrote:
>> Babu,
>>
>>> We have the information already in r->mon.mbm_cntr_free_map.
>>>
>>> How about adding an extra text while printing num_mbm_cntrs?
>>>
>>> $ cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>>>   Total 32, Available 16
>>
>> Either that or:
>> Total 32
>> Available 16
>>
> 
> Sure. Fine with me.

I think separate files would be easier to parse and matches the existing resctrl
interface in this regard. How about "available_mbm_cntrs"?

Reinette


