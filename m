Return-Path: <linux-kernel+bounces-359611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452A4998E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E143A283E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596A19CC32;
	Thu, 10 Oct 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmkCkVb5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00119ABC3;
	Thu, 10 Oct 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580128; cv=fail; b=tqsObnOvHGAXgB7HaC+ogyPnluC4uTirVDDtGKZ1o+BZwjmkY8se0a7eu0aLL8FwokxVcB9FOdc9RUj1h/EVTNXgDEgo/9HExQ7ngKQl4HeodadDy1MHfEyxoJswCEspoREqye9KoY6ckjKOY9SnkgtVNu2HJ83RUUULVUDRiQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580128; c=relaxed/simple;
	bh=AO0jpHdTRCSyXzxtm0d5sycWQ/+dsNQ32+cto8QcM3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+arV3JzRD+mmaKIYEl2YUNOY5P7AhG13pKLeidZBme7IElB+6BhLkB0jS0AxutxhvNn2EPVgqS593h4POtk3aaEuiRzWvMj5Nul7eeXNr5mPtgtYbaO+RHd7n6HEsbBFhIkGKZ7J4pZyH/899IddjyGZ5kewyd/2RjI5RmtyOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmkCkVb5; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728580126; x=1760116126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AO0jpHdTRCSyXzxtm0d5sycWQ/+dsNQ32+cto8QcM3w=;
  b=HmkCkVb59StV2coVKrMVl2PhDt5ybox3xp/g/Ub3xoSoI41Rw5gfbsNR
   xetxSOw2wCJihr5tl4t6N591R2s+B3ObvrXVt0pE8qfCRNIqyu6WY8MIv
   ErvJpewJBpxcLGqoR2IYUxzCq530xpJgKSn3cE9zD40wjXjRF6IMic6k7
   SZp9E6+0NjV/Ke86aOcD3eSfXBkagIzQmAyVjJ8yt/C6U4RYoGoYmBmSF
   JUWfzFT+NzCgQN9ZVzUQV/TzFtWYKig0KP9rWufj9OhsQCNrTcVtA0tvW
   gNzcBHNOI4zc2QoNMaMQwIFoEfvTsTzPU9XuFckmznOhCT2aK2K5fm93D
   Q==;
X-CSE-ConnectionGUID: ejC/8ihkSTmtbhKcLW/iyQ==
X-CSE-MsgGUID: J39ztDPIS9KSk6w7rmdO8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27405404"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27405404"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 10:08:46 -0700
X-CSE-ConnectionGUID: SonDIWx8R/mXq9WTauPYqQ==
X-CSE-MsgGUID: 6fji/r7RQSGle2xxHr1TjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="77138863"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 10:08:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 10:08:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 10:08:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 10:08:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtH9MxEpHV4vCTsocJpD/fh4txpKJbPpYHI03vuikXK3F6Ml15f8CWjeP5APboV8Mu4GOSRxi3xHcVh/PLtlg33iMjQ4FlbkYdbOyLulvqmQp8BAlKZbf2hcgulhS0PLvrKIOo1gDMBpBo6LVsabXZfoSSEI7OZVl+AD18G2P5GzzGZM831jlq1PA0F3HQJ7c7jBa7bxds+qF6cSh2Vi9DOQWz/ZP08WPwZOuTw3yPOF/Lo+c/A+IcgbT3nnvoq3OxzTVR692TxdyIApXh977ifmYFxBIZXfxVtDXZktCD59XWCJC4hD9Aa/swBDiOQ7HQZF0SE+qZQMKBoR4XvvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO0jpHdTRCSyXzxtm0d5sycWQ/+dsNQ32+cto8QcM3w=;
 b=QYmRQXpV4KSvERVh5SmX5TfE/1pJS3s4v/Qdd0FJkp6J6SxQq+ymYBW1saiI5d+S5kLZwIYzR+s7MjlMVe2POeHFf089JlFaXpgm2vqiwYzPHobVG/7Ef5ttiwLf1nN7/w40hu5X/+zqxnuNIG87xi92wj/JXuVfsFR/J6Ses+54joz61awyJTEWaIF1VkAGBVhZR2EtWWLk0yght0VD0yR0+qXBHVSYIDvVcjgokGhTxNwgYHINxxLET0+DKzZfZTg1rcSkPDpJllTDB/2T9gUI8FQqOjXUnqujHNLhwuaywQNz/b0rW363+ytnOvBOBXTTmM1Ul9z3g5wdtMRlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB7005.namprd11.prod.outlook.com (2603:10b6:303:22e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 17:08:40 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 17:08:40 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "tj@kernel.org" <tj@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "yanjiewtw@gmail.com"
	<yanjiewtw@gmail.com>, "kim.phillips@amd.com" <kim.phillips@amd.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>,
	"leitao@debian.org" <leitao@debian.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Joseph,
 Jithu" <jithu.joseph@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "peternewman@google.com"
	<peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: RE: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Topic: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Index: AQHbGybdEonESjxpIEK+MSvEee6fXLKAG/3ggAAYpoCAAACqQA==
Date: Thu, 10 Oct 2024 17:08:40 +0000
Message-ID: <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
In-Reply-To: <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB7005:EE_
x-ms-office365-filtering-correlation-id: dc74c1ff-222e-4db8-335c-08dce94e3055
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bkpzazBtT2JoZGg2UmNIMU82SUN3OG1ZNVllQjhDdXVYa3JTMHBPUjRoTWhC?=
 =?utf-8?B?ZVJxVU4yNk5IT2lBZEFVdVR2ZThlSEhKL1lsRnc0dmtYOU0rdXhRVCtsWXkr?=
 =?utf-8?B?TGVJL3VEMjg5TUhBMkptM2x1UkZVemNZR2xxWDdTU0RYSmYwMlNyU3UxNU5a?=
 =?utf-8?B?VjJjOE9SS0lHY2RRTmJKQStodzdTbHhyM2VrTUZad1BTZTdscEZoZkxtVTZT?=
 =?utf-8?B?ak9IRFJOVlgxdEtsQjUxUCt6cjFjNmNGWlFiRFZQNEhmQUxzc2hyc0t0RDRJ?=
 =?utf-8?B?a3kwRXJCdGpyNng3ejE0VDN2T1dka1RnR0RnOXZVZWlJSFcxcnZTcWhkd2FV?=
 =?utf-8?B?TDFQSTk4T1VIQ1Z0dmtsRk5NK1NtbjhFSnA2VWVLMG40eGhlVU9UR0Y3Z3RQ?=
 =?utf-8?B?Rk5zMUJjNmpEdlplaVRLMnQzM1FMZkRBbkNNK1Z2dzM1WXVsR2lSUENNY2tS?=
 =?utf-8?B?ZWR3RW81aHRpd3hHd2FXYlVNRHhnTjRMZ052VlRTSGt4ZS93UDJKVUphcmRD?=
 =?utf-8?B?dE80c0FYMzhrUHV2cnVqSGFkQ1A4SFd5b3dHNEF3QmpGajVweUc0U1ExdnlJ?=
 =?utf-8?B?YnhVb29PSDIrcjlJUVluMmhUM3hUajJaaWNBVFlUZ1JWbUpXRHFXUCtQRTdR?=
 =?utf-8?B?WE5HTFBINER1ZzU5NHBObDE4TGI4VDI1RW5vWktvZDBreDA3ZWlEM09IVG9t?=
 =?utf-8?B?Sk9reDl1WFdGNSszSjNaR0lBYTVtalFqMXRFajlYaVNJSVpjV3FjbTBvaXNo?=
 =?utf-8?B?ajZwNlEwU3JZT05hSkJ2TlFVVGdNK0Y1dTlGWS9XNnljTGFWZHV1aWFUTUVS?=
 =?utf-8?B?ZitiRjUwNEtOd1dVUXNiT2I4b05KN3VKMTdqR2hhMThXVGNGMlNBUXRPWjdS?=
 =?utf-8?B?VVk2ZENJWmw0WGtFbGNYK0NOM0xXdy9nemFHSXUxRVZMTVFGRHFTZFdLRHky?=
 =?utf-8?B?K1c3QUJhdDFkY2JUbFdVVzNRL00zSk1GS01JS1RWNjNQR0pnaHN1VVhSbXVo?=
 =?utf-8?B?N255WlMrcnRwT2ZDZ085UytZSHZtU3lXa3dQdjhRSFVObTBMSTU3UksrM0Zr?=
 =?utf-8?B?aEZ5Nkd0UVMrcFBXOVBISVd5R2NmZk9QUVJlak9ONm4yK2ZKZVo0R1VNSDVB?=
 =?utf-8?B?MFpCb1BhS3I5anMvajRkTSsydDh0VWNyaUwwNmM3RXJKQWpzMlY2c0JiWnRQ?=
 =?utf-8?B?Wm1wWEsrUSs1dzl3Z1N1TWJNQitmZzU3U3NMVXkxMmNwc05Hb1RWMFJIMXlF?=
 =?utf-8?B?RzJyRnNiMkJvTzFZVitFencyL25pQWpFMVdLRnlqS201dVg4UEZkbFI2cno5?=
 =?utf-8?B?VmVRaFZtK1ZjcGJkbXhrRGwzUkc5c2ZGMzhWZjNPRkE4NSs2QmE0a3Q4WTRN?=
 =?utf-8?B?VEdWbkdEWWpJS0tjMkk3SVZKeDhZQnJXQWVoUXRkaFkreVNRQzVaejhCKzNU?=
 =?utf-8?B?RjNDUUgyZXdyUWJJYTBGdWpRdk1JVUNaRGdtc2pRb1NxMDFxU3NUK3NaVU8r?=
 =?utf-8?B?Zk9NVmhZZVIvd0RJTGpUQUd5Tk1SNFQ3VjFiTEl0eE11Z1k0Y1U3eVNrRGVT?=
 =?utf-8?B?b2hmOTdaRXNoand1L2lzQ1NUdDRlMEZzWE8vWGVRb0NORHEyWkVvOVdPS2t2?=
 =?utf-8?B?UVFlWlpzZGcwTmZncUNFa2FvelE0d3RoZzM0bElrcjRHdWhoSlkrdE51d0ZP?=
 =?utf-8?B?cnMvSWRtYkxLTFh5NWsxNmtSMkV2bGpMRnlNQUNJQ2x3TllhMGJsNXYyVS80?=
 =?utf-8?B?ckJtTU9JVjBLdC8wNGc0OTR6VTRJZ3JtMElzUXBaVUc4TEdTRmRyMVFJZ2xX?=
 =?utf-8?B?N0ljb0xBL1p1OEZENDJDUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amNid1BETzI0WXkwaTdpTnRSbTg3WFdQeGdGUHNYQ2VIOVI4Y09QSmRQVk1n?=
 =?utf-8?B?MTExRXNXYVIxQ1lzRFhWakVHNElUR0FueTZudk9lalMwSGRySkR1RXQ0TVJ5?=
 =?utf-8?B?T1dXK2M0R3hkZTRpdldBMGxMZEU3ZW5jbWxnSHdJQU93RWViYURLdEVtZCtk?=
 =?utf-8?B?d2dJYXdKQkxtRElLL2J2dTRIT0xIMjIwZjAwc285Y0Y3RzJPYVMyaXNiQVZu?=
 =?utf-8?B?OFB6aHVKS3A1N0FEWG5UUVd3Q3RFcWdKNllRM2x4SDhrZmtOZzdaaDdXRTlx?=
 =?utf-8?B?V2VxSmd4ZG5nV2E4Zks1KytsdDhzWC9NU21ablg4REs1OWZjVTJKM3RTbHVJ?=
 =?utf-8?B?VWEzNXl1Ky9qZmdqNjgzQThMMm9laGkwM2ZJRTlDQU1rSCtsZ3BTalVjRlU0?=
 =?utf-8?B?cDJlQTFtYzhHNXgwa3cvVGxsZHFlLzNiUHhIb1BKNllWd0liblpTNGlZcnlK?=
 =?utf-8?B?MkQ4ZXNIL2s3a2tWWnJxUGYrV3pVUWpoNmlHTGpoaTRLMytZTUQ2NitzbkNx?=
 =?utf-8?B?clg3VGY2cWJ2VUtTSi9BM2cyR0pxRUFuL1Izdmx6enc3Tm1SU3NPbFcwQk5C?=
 =?utf-8?B?d0dGYy9xeWlaeUE4VXQ4a2FSTkI3T0NQUm1qcWMxeGEvZXlaOW5vaVBJWTdM?=
 =?utf-8?B?K1RVWkRKUE0xQlMzM2xNR3crMTJOcnlYSFN2eVplNlJ5SWpXcGN1eFFMaG44?=
 =?utf-8?B?dEt4ZElpSmR5bFhrZTIyV1lEOGVLdkNLQ3ozdCtEOERsZlhuN3JrUi9VcFBV?=
 =?utf-8?B?TFFPcU5yY3FTMGlhdGdWMW1Gbyt1L3N1QjFyam5WUUpESlFVRnE4UG15a3RX?=
 =?utf-8?B?TS9hZVlqa1AzQnJsTVdXNlVVc054WnhEb0VBVTFmai9ONUI0MWFTWjVHNnkv?=
 =?utf-8?B?WXZzdy9HL2phVllMaThKWi8wUUdrOG1SRzBIM1BDbUtvYkFFbHMxVHlYN1Yz?=
 =?utf-8?B?WjIrZC9qRk5HdWRQWkVZYTRXNi96eVIzUnVnS2pZNkppMXFkQlZSNURHaU1p?=
 =?utf-8?B?TzdacGl1anM2THo3VmV2dnVkdTZkeDY0RGlQWXVwR25ETUcxT25maUlXa0RJ?=
 =?utf-8?B?eUlIVENDaWZSZTRUNWZ5Q1RJcTRkRTFINmNQZ05STU9HRk1nT2l4czdqcVVt?=
 =?utf-8?B?Z1hLQnU5ZzdGOEkwQjBNa2R1RCtaQ3p1M2VxaUNGcWlpMC84cGJDSWNzNFgy?=
 =?utf-8?B?OFN2OTlCQlFGSUVpL2pmNUZkMDUzT0hVaVZwd3IzczFzMmtaeTFIeHN3S1JS?=
 =?utf-8?B?ZGFmWkxMcFMrU3hVZVIyRFQzUEw4Nlh3eU1jQk5PZ2xPUGIzVjZqQm9lQ05P?=
 =?utf-8?B?cnVVZkt4eHFNcFZ6TFYweVorYWt5aEwzdFh5RC9YWGtlTjhsc1d4cExFOS91?=
 =?utf-8?B?dUtkZk5tbktVTEF6MUpFTzNVNEpRYmlPMURsVUJwdWdjYzBFVlNBREIrL0Rs?=
 =?utf-8?B?SGFVZ2J6M1h2NHlpZDdObDdaL01HOTEwWFA2eUVNS2s1L1RTRnZsY2UvRUZz?=
 =?utf-8?B?Q0dlLzBtVXQ5aWJaZTBCQkFJR1ZuY1NxbHE2S0NEdlowL3o3alFVWmRzakda?=
 =?utf-8?B?SGxvc1k2VnAxQ2dUWkpGb01KTXpncWFhY0JUMnFiZkdwM0d1MHBkRkU0Wkdo?=
 =?utf-8?B?SVN2R0d5NEhOZWpvOFpyUWs3bmNabDhCaDBxWFUzcEY2amZJYlcreXBPQUpi?=
 =?utf-8?B?MGpIT2Z5YU80eGl6MStJMEpMR3VTRG5GVi8yZ2lBTVpWdy9qMmZMeFJadUlV?=
 =?utf-8?B?U1VNdHpRYmRsZkRmZ2gxUEtaN1UvekxTNm9yWmVNSjRiYXVucmVxR0dhQzZi?=
 =?utf-8?B?aHFTS3VHTWs5WXJaeFhiZVFGaVNDK2xwb3c2MExCNjQvejNoekQ0Y01yaFNk?=
 =?utf-8?B?SW5yMGgzVkl5TFpFL1JkY1dESjBTRVVNZmxYUHIwaFJVL2pHQ3ZhUXR2azFO?=
 =?utf-8?B?Wnk2MURmdFBEV3crYVdPMlRIcVJSek1qUWNNdE1RV1Jpa0VQQkhMVGxSaERR?=
 =?utf-8?B?Nm5FNisvZHhsZDE4azhtaWpVME1YZkZmd09DQWdvSnlLZzYzZlF1MGVPU0dl?=
 =?utf-8?B?S1VtbjJnNUxVNEFCUGgwNkVzeFpIcEhQem5pZGxEbVRiVWZXUGRSSk53UTRj?=
 =?utf-8?Q?VGJG4WKwbZiTLXvFhKgDLEqIm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc74c1ff-222e-4db8-335c-08dce94e3055
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 17:08:40.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cR64uvEHdO5VUChfIiZnbNs0kGngsVmsCuRPhiXRULkeFnpnkRs07f66CIlTFX9P9fx4A5+Q055lzdjMWnR5MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7005
X-OriginatorOrg: intel.com

QmFidSwNCg0KPiBXZSBoYXZlIHRoZSBpbmZvcm1hdGlvbiBhbHJlYWR5IGluIHItPm1vbi5tYm1f
Y250cl9mcmVlX21hcC4NCj4NCj4gSG93IGFib3V0IGFkZGluZyBhbiBleHRyYSB0ZXh0IHdoaWxl
IHByaW50aW5nIG51bV9tYm1fY250cnM/DQo+DQo+ICQgY2F0IC9zeXMvZnMvcmVzY3RybC9pbmZv
L0wzX01PTi9udW1fbWJtX2NudHJzDQo+ICAgVG90YWwgMzIsIEF2YWlsYWJsZSAxNg0KDQpFaXRo
ZXIgdGhhdCBvcjoNClRvdGFsIDMyDQpBdmFpbGFibGUgMTYNCg0Kd2hpY2ggbG9va3MgZnJhY3Rp
b25hbGx5IHNpbXBsZXIgdG8gcGFyc2UuIEJ1dCBJIGRvbid0IGhhdmUgc3Ryb25nIGZlZWxpbmdz
Lg0KDQo+IFRoZXJlIGFyZSBhbGwgZ2xvYmFsIGNvdW50ZXJzLCB3ZSBkb24ndCBkaWZmZXJlbnRp
YXRlIGJldHdlZW4gc29ja2V0cyBqdXN0DQo+IGxpa2UgbnVtYmVyIG9mIENMT1NJRHMuDQoNCklu
dGVyZXN0aW5nLiBTbyB0aGVyZSBpcyBubyByZWFsIGJlbmVmaXQgZnJvbSAiMD10bDsxPV8iIC4u
LiB5b3UgYXJlIHVzaW5nDQp1cCB0d28gY291bnRlcnMsIGp1c3Qgbm90IHJlcG9ydGluZyB0aGVt
IG9uIHNvY2tldCAxLg0KDQpXaHkgaGF2ZSB0aGlzIGNvbXBsZXhpdHkgaW4gbWJtX2Fzc2lnbl9j
b250cm9sIHN5bnRheD8NCg0KWW91IGNvdWxkIGhhdmUganVzdCB7Z3JvdXBwYXRofS97YWxsb2Nh
dGlvbn0NCg0Kd2hlcmUgYWxsb2NhdGlvbiBpcyBvbmUgb2YgXywgdCwgbCwgdGwNCg0KLVRvbnkN
Cg==

