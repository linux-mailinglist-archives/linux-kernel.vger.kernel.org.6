Return-Path: <linux-kernel+bounces-294457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D4958DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAB91C21A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386251C0DFE;
	Tue, 20 Aug 2024 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOvP1O5t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BF1990B5;
	Tue, 20 Aug 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177865; cv=fail; b=Vyi+bNVoSKvr5WIROXrP54Odw3tYrPj9TNHZO2Y+x8KD6lNLKuIF3c0kv5Bl9jQTWUm8gyKAg/5lGizWFqC1VQixs/8ZK+QTGGERmyQS7gGKZNh/PKwOxfiWLiF0//Lg7RMn3t7TTQ55i2pA/TdVEaWtUWc3Fqjqx8PqVZh0/8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177865; c=relaxed/simple;
	bh=M3tueG9mr4xf/TZutY5W9mABgbFaPUE9mwBBDPamFPg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvFnFXwGb3PAZ2PwFzNkYNd80zLiSmoMgOfT5RZAmOv/c42O+lI/rxhtmxK5vra3remVFLi4Ih6VPJ7lhAtjW4hwtiFvLfqfeY4KbBdSVfVWlDd5PRpyz694snfqfgYZxMdKUXtPylD98S7QX13Nlm6IPb4XeRNvIrSWpjLEC7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOvP1O5t; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724177863; x=1755713863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M3tueG9mr4xf/TZutY5W9mABgbFaPUE9mwBBDPamFPg=;
  b=kOvP1O5tFaXKiYX5VQV5MTfWmkagCm3bRNQYo1P2hnP7PrU4azqA3ZiC
   0KWuzJDMSExj4x+3ydE+RJ32lHEpohI7Qel0xJlNTHgM7lCPSmQdAQk/S
   lq/VA9WQ2Drgd/+nzWnGsusQLmp5hXDnCoo/NFfoG+/AEJQmSGtkKfCMo
   sv7IM+iaTxEl0EHLz7r7apDOtiNIkZnSdIWbVK40djdwJBrcUJt0aa8ji
   /aHos5E4VgdONfADrn+kcqEZnganKm40d094CYB5Y6GH3s2Qqpky3WE8C
   roxaCiAYiuV5uwGeXvy7tW6bzPcWMoSDgJfPLVwG+0QJwxW049RoKHZjE
   Q==;
X-CSE-ConnectionGUID: iBPPMZMhR4CYaCRBSGQavg==
X-CSE-MsgGUID: YaGHj/n0QnuHSdI30vE+HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33651400"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33651400"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 11:17:42 -0700
X-CSE-ConnectionGUID: EGkGI563RCq8Gbf8qtxUvg==
X-CSE-MsgGUID: gRfKKhRnQ8u6Nf3g7dJCnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="84007979"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 11:17:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 11:17:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 11:17:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 11:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXM+E7XMdplzYOfSAlD4Q0sASR2VMWzgaUVwP5ooQz3i4d52YZ7hcA3y7hr5ZP5uL3h8rR1DYP/y9OG4YcvGjDZD8htpfNEjVuhLsbwgAwP6DhOmOx49Jg8+hIJX1/k+ydvRb/9VAbGWVsIDW9Ccux849tCF+vQwyAf/6OPo2/StSqlT9bzHFSRK1sAANvRMln9aHCA4OQPCKs1UJeHWHAZN4pvl6XqQk7Ggzw3kqkk7MISAqOK5ymMNG9nntGkMUINHO192BkJd3zyBqJ9plLnzX0oEL0liOxKACWMP8CpDJmxS9+ImqWMUM1QZW/ZRw3fvae5RzLsbS5m6qLgJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAPcdSsiu5hxseuNq4CqLzmVOlk/UBxQQRPwPbIqyRI=;
 b=tQ8l5gPd+aTDzNgq5mpepewFBarybmzr90CUh/F6Lwj4VMsvNJV8sTZ7eq5X66FP2eqM/oyfPdOOSsnrjSAiL0xBWcdvXmsQhmShX5IQ4wxoBLX9UD96BXYlp2ewtIfBKY4xMcrxV9vZ15tvT1bAwoTYbqUzgskVaz4kkFyMS1RL1MYgHsKZZvPQRa9JbmyU54EK7/UvLU0PofzPejLvL98OW9jwg2jdSD1VSWYZoh04alA8BKdPZaE7812AD2ihRNccScvhQgVhyV+lVfxsjhgpeW2xjb5JWO2LAcbbbpTKupYxstts2ABDY/jQ6pifIMupBDixJHaf52eIIsRCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 18:17:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 18:17:31 +0000
Message-ID: <aad023cb-fb80-4389-b9dc-c3468e397598@intel.com>
Date: Tue, 20 Aug 2024 11:17:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/22] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <140e4e7bb26db9bbad3e37d910c0cea0060e99e2.1722981659.git.babu.moger@amd.com>
 <272538ff-0608-4bec-be22-3cb32d3a5ae3@intel.com>
 <0256b457-175d-4923-aa49-00e8e52b865b@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0256b457-175d-4923-aa49-00e8e52b865b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 13715468-15f5-4b82-7009-08dcc1445b56
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjVCTnUvLytwZlJ5RXNyYTFXQjV5Tm9uQlZzYmFLM21aalNlem5TZFlIeFFV?=
 =?utf-8?B?WUVIZGRTMnF2MmFjUDEwZFZRT0lHM3dRR2ZuNU1sbWVGb2ZTQmI3Q0tkMHNG?=
 =?utf-8?B?UnJYQVN3Z3hyWjZDMUloa2tDaDBuaHVNQWI4eFRNbStOdFFnRG5FTERsL29a?=
 =?utf-8?B?U3hrYVZab2FjQkxFQm56dnA1ZFRleS9scmtSZUVuOXdkSWNQdFdOWmhFWm4y?=
 =?utf-8?B?THhuZjRPczV5aUJVaGlUZEJlQXhFWVZKMnZndjNtY0xNaW9VWmo2Ynd4YWY0?=
 =?utf-8?B?WWtJUEhKb1kzNnhPMTBGaW04ZllROC9lUFZoSzJuZlpOdm1GZWRvVzB0R0JL?=
 =?utf-8?B?OTVTdnFpaHA1SDNBbHpMc0pNbkJGaE5YRml0cE42ZzkwdmpQNytzeXZKSzJG?=
 =?utf-8?B?U3RXMFBqZTlsYzdkVXRsT0htSytweXdpMmtNbTludlczTHpoQ0RmTzlSclpY?=
 =?utf-8?B?UmJ3MzZSZjJ1aStRZzgrejdtU2J4VnJNRGdYYmhaUGxvbk1TbUZnWXdqQnV4?=
 =?utf-8?B?eDVzS3lWczA1dFhXODBrcWxYUlhNN05ybmg2eDVFb0FhZ3IzazJoQTd4bURL?=
 =?utf-8?B?ZmlYM1pGWlJ2V083bXdBV3ZTMEt4NGZhMHR4dGZnSm5ZNmEyRTliKzVHODZU?=
 =?utf-8?B?VTc4NGtjYUR4L1dGaTdma0lJR0JXMkx5TXJiMkN5UFZveStLL3NXZmwzVnZq?=
 =?utf-8?B?eXh6b0ROVTlyWnA0NkhramRKSStNeHUyUmRabFRaWEZhSXFMZVptRWo4RmMv?=
 =?utf-8?B?TEU1T3NvR3Fud21zNHdkOCt3dnJJWW5qWDcwQlBMR0RFcVd0TDNXVW5PbS90?=
 =?utf-8?B?dkJGSUdEK2czMFU0bXFob0crMmxoM2NBS3d1UXdIWGIxTys1V3VhdzlMQTNF?=
 =?utf-8?B?cFd0YStacDhGdGtkUEpEamFzMGVWeHgzbmNmZXFUVU5na25jQVlFVkk3bjNK?=
 =?utf-8?B?ak9qSURjR1VESEJkMHhZTFdMWEF6dnhNYnFFMitUdmppZk9NV21zWEY4WXpx?=
 =?utf-8?B?T3JiS2VhN2NKbE5QWlJ2VElVR1Y0OWZwS3VkRmxQajRJUWlBYTkvd2I3dGhJ?=
 =?utf-8?B?NWEyR2FMZ0xKREREcVhOK2xwSjFpd09GU0RmN0p6VXdBandqNHFWT3dZSHlQ?=
 =?utf-8?B?a3VncytvZ3g5MEhiT1ZPb0ZkOXZhSXJRM0lCWExyOEFwV0dFN255cFBnaW1p?=
 =?utf-8?B?SjFqRFB2QXhuQUxsMTduTER3QUhDckZPN1k1M21JNEg1YmVHUGtVdUZWY095?=
 =?utf-8?B?cFloMVZVVm1lR1ZQN3ZaY1pGV2loSFVIZ0xRSEVZNXI0TktIaUdvTDlsZk0r?=
 =?utf-8?B?dWZFb0VrdDd3TlkrV2J5cW1rK0cvR3ViYWJtVlNuVlYwcjVGSHpMN1l2SzBF?=
 =?utf-8?B?M0tLS1hqNG4yN0RSWk42OGJIeFU3czRYVDlLMEpycW8zU3ZOSk5TVTZNQUtj?=
 =?utf-8?B?NG1kYTJzVEJjYW1rdVErV0ZSemc3OTZjVXQvNmhCUTlxTGdpK3NEOU01QW5N?=
 =?utf-8?B?UzIwdnY5bGRBdG5Ia0MzbHVNbm9BdzhNbFJIdENDMmZEWTBQSjNWMUZwN2ZR?=
 =?utf-8?B?Y0ZHUnZlN0gzZnd6Rm5tS3lQTWFXZkl4WHpQazQzNGdKZ1c5RHJ2aTBOTHZD?=
 =?utf-8?B?ZDRHZVprUGptM1RScllhN3VWVUh0TXRSZ3VibDRLMTJHN1gzdHRzd3Y5cGRI?=
 =?utf-8?B?OEEyVmZ3c3ROQ0xSYzltSTNtWCt2QjIwVXNjZTlZWkpQYVVKZ1VycXNMTlBh?=
 =?utf-8?Q?dD83+32/VnMcTM2sH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejNRWnp2V3FuNHJCUDk5dlRGOXNnZlBzYVZxSjNqeXk1YndHYUIvcWpWWDVB?=
 =?utf-8?B?b2JuQVB4UVpMaUdHSFJzSzhFNE52eHllQ083aXp2YjRMMGo5bGZEdFQ5K2xZ?=
 =?utf-8?B?Rng4MDZhNGtzQlU0bVFpeFR3S1JuUENvVU1hU1ZoZ3R3MkFVNTg5MU44RWlL?=
 =?utf-8?B?NXUxZWErWFpyc0FlNWlsUjZvYkN3c2hZdjVpL0VVZnBST2lnWU43RnhlQyt0?=
 =?utf-8?B?eHRIQlhRSngzalhiaEVVdHpybWFEYVlybFVzdjlSTnJBc0lhcHRFbG5ZVXox?=
 =?utf-8?B?VTh2NVdFWVdjdjRPaHA5Sk43Q2FnOE8yem9rdWZqcXNMeVR6MWU1WE9VYzRU?=
 =?utf-8?B?Z2Q4bVd3aUJQTVRBd2JHZzM1bWRQR0hTcFltSU9tL1hJZE00Wnd4VVJVTFo3?=
 =?utf-8?B?ODlRUWNlc0g1NWkxMWdYazdrWmUzTUZKVmE5SjRydkY1YTNHSTVjeVF2UFlS?=
 =?utf-8?B?blo1eXVNVE5yb1VMQVVvRVBDNmNrVDY0Ti9yN09xUGpKd25iNG9sMkhwOFBO?=
 =?utf-8?B?bmFCTDVKRUdGbUxVMmQyWEJ6QjVXUTFMSUpuZTlrT2ZwQ01NL0VMWWErbVNz?=
 =?utf-8?B?VUJMSHlCUFZObU1lY1F0azFHN2lyQUpNcG10bnJDZTF1MnRwTVVidWtqQWdF?=
 =?utf-8?B?bUJrNm50TlNFOVQyV1lvRG1HNkRKM0dlSnMwaFIzOFhCNGtqNlU0cm1VYTBq?=
 =?utf-8?B?VVl1WFR6VVkrMXdCWXdRdUxjcWVReElpaXNjZXk2ZEZaN21uRUo1alN3Tkdy?=
 =?utf-8?B?QWM5dnluY1NnaVNYbHl5eXVNNzZVdHh2d3kxeGFaTTFGRzduOElDaGNpTDlL?=
 =?utf-8?B?SlQ1dmZxZG5BZldJeG9QTHpFZVU1dlhDSHM1ZHZDaEJSU0R1czc1bmtMbTh0?=
 =?utf-8?B?eGgyajFra2lnNFM1Z0FtMVhFSENvSkpLK256dFJQcUhPTlVEdSt4RGFpMG0x?=
 =?utf-8?B?UTQwTGp2NXBkdGpWYUtjY0JXZ0VOYzhxYXNoR3c3dEE0MU5wcStHcXh6U2pF?=
 =?utf-8?B?emRaQzdNejRmRmdEWWRTWWcyK3cxeDdIK0pNdHB2ZU12Y0dHSDVGOFI0b0Zw?=
 =?utf-8?B?dGFGb1RQbTg1WEgrcjkydkRNSlNMY3Y4MXNha1lFbk9DRjJxNDRYSUU1Z1Qr?=
 =?utf-8?B?TnV1MGVaZFVmSHFycUdjUyt2TXBzTnlxVGl6d3V5Nkd1K1BreU1UYWR2a1lD?=
 =?utf-8?B?WDg2Qk5ndkdqWHpZdUZkVmJQQmdWK1A3eWVra0dMZndLbWliNE1Oc3Z5bEtu?=
 =?utf-8?B?Wm0yVnRhd0dXYllwYy9tMWtVWGdLT2NUN2RnWUpmZHN0N2JlS3R0VU01d0VJ?=
 =?utf-8?B?YXptNFhCTG5zNlJFdXFxSW1xeUVVaFJPSlhtTmNxejZUWjJPcXRCR3IvYnJO?=
 =?utf-8?B?bHJCZWxhdm5sM2w1Vkdad2tiVjViOTJubEpiZ2lJcWczMUhHTERMKzNOQXh5?=
 =?utf-8?B?SkdoeUxWUXVEcG5yWlRZWUJvS1dNTmQ1MXB0dnoxbWlvcWoyZVYrQnRPTEhp?=
 =?utf-8?B?LzdtZFFQSGFhekp5RlFRRmRldnRWb2lQemFvRVZaTXJFNFlnTkVZbzlGZ2dH?=
 =?utf-8?B?TW5nMkNQeTlwSkZYY2h1dTN1Y2p5K0srQkdxN0cvaDlpQTVmdEtxc2gvVmhQ?=
 =?utf-8?B?bUZsVTJEcDRYWDBRTGNWYURuamVXU3BEbDNvSG1PbFYraFZCeU9YOUx3dVd1?=
 =?utf-8?B?K3dDL2krZFZPcTRIQndDNVBTeVlWOHZ2bDFHYUQzczBwNHkxWGRkSUJDaG1j?=
 =?utf-8?B?RE15c0ErUkExcnhaMWNaVGJEYkFPTjVocVo0eTZCZHZTS2dZcjUwUzJ6VGNa?=
 =?utf-8?B?eTZXNFJpa2JEM2g2UFNhVXcyN0pENGxFYW1tbDBSY25uUnBoempmSEdzWVpZ?=
 =?utf-8?B?cEZ2citwRjZvUUJGN2ErYngvMTI0Ym9GMnBiYWFlUDE5cllUWWUvR3hoZy9F?=
 =?utf-8?B?SnppNFlySkxWQnZpeCt6c2t1L0ZySUJ4VjU1Q0ovdGs2VmpJODlrcWJ5TXpK?=
 =?utf-8?B?R3VGdUZEMDZMUUlBTE1idXFJOXJwM25XUlVWd0s3U0xkOE1LRXRrcGRJQTJu?=
 =?utf-8?B?emp0SmdPWmZraGdITHJJTEZHZnlVTkNPdnEySUtsOEZKSWVzT3U5Y1VkeGZF?=
 =?utf-8?B?ZjBPZTVRZUR3T2RueG1kNW95elRtQ0ZubDlRRk04ekw2MzluUDJRZVJXL0h2?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13715468-15f5-4b82-7009-08dcc1445b56
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:17:31.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqZ8rHsW46Q9fva96G0yA1oqXAlWNvBqIx/cU2yFcLMqlzT9Krf4g+vstqNS9lciKukIAFST7X2Rgh+CweHhw3W/OMEp8xNQGby6r8woQCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com

Hi Babu,

On 8/19/24 11:07 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 8/16/24 16:31, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 8/6/24 3:00 PM, Babu Moger wrote:
>>> Add the functionality to enable/disable AMD ABMC feature.
>>>
>>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
>>> to be updated on all the logical processors in the QOS Domain.
>>>
>>> Hardware counters will reset when ABMC state is changed. Reset the
>>
>> Could you please clarify how this works when ABMC state is changed on
>> one CPU in a domain vs all (as done in this patch) CPUs of a domain? In this
>> patch it is clear that all hardware counters are reset and consequently
>> the architectural state maintained by resctrl is reset also. Later, when
>> the code is added to handle CPU online I see that ABMC state is changed
>> on a new online CPU but I do not see matching reset of architectural state.
>> (more in that patch later)
> 
> Yes. I missed testing this scenario.
> When new cpu comes online, it should inherit the abmc state which is set
> already. it should not force it either way. In that case, it is not
> required to reset the architectural state.
> 
> I need to make few changes to make it work properly.
> 
> We need to set abmc state to "enabled" during the init when abmc is
> detected.  resctrl_late_init -> .. -> rdt_get_mon_l3_config
> 
> This only happens once during the init.
> 
> Then during the hotplug, just update the abmc state which is already set
> duing the init. This should work fine.
> 

The discussion about this flow is now split between this thread and the
discussion of patch #20. I tried to merge the discussions in my response [1]
to patch #20.

Reinette

[1] https://lore.kernel.org/lkml/6b1ad4b2-d99f-44fb-afcc-b9f48e51df6e@intel.com/


