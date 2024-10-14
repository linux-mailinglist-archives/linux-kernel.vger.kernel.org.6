Return-Path: <linux-kernel+bounces-364424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E7B99D47C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F566B22943
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478841AC450;
	Mon, 14 Oct 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewHhbKyb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCE28FC;
	Mon, 14 Oct 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922717; cv=fail; b=AvYW1nqn0dhpTno2sGhpkVHhG1e86A0q+CJNExwVmcpQA5N5xPdgTHW4xWrLWgX+aIBcc67k+YP1q4r2UBnPTny99RrXrY1bVisCooWjDOQI2XuHgXID1MiPauHl5IUSNR4s5rkGSNJMJCbX6XYm/G4DIiH21tyn2jLVPsNr/nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922717; c=relaxed/simple;
	bh=rGrgIOZ9nN/HBbetI+y1m4FK9wuDW4TdsfMbsJh4az8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YzWIhVu70diJ+P7k3fHaRZxETl0uS7gcVfARETBOpu6eAdfdgg+b7u5UMdKAHikK7auX1bGbN/PB1zN0w8RcNzA55naqEKsWXaFiIIKwWua8iY0huT3tJmtfcVLQN1s7wJESK+9DfJtQ4TsvQy0HfXnKbiGIUWp2KstIjdPbT98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewHhbKyb; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728922716; x=1760458716;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rGrgIOZ9nN/HBbetI+y1m4FK9wuDW4TdsfMbsJh4az8=;
  b=ewHhbKybe+y6o03HGVnezGyiA2e9LsyTyydnAhYrF8kmJg6Poa/0Mq78
   Nf6zMF8jTwpf9P3zQqAfVzUHiwsJ+OTazqi38SDEnpzn5/i+MfLGW/r9M
   uPb3FRCPobuIO8GSAwINHF7VyMLf+Fl7BsKwWYmsf0lnSXmrcHiq2MmIW
   qmm2FXrLD8xKdezv8yYRmtiLdLmJhGO1GcLv1vWdRMIxFc2iY06XGDdid
   CcmtBnvoOrFV+BWLppQDecf4C4YFXleXEA+t9PR/gO78TyCxH/aFIvv9w
   4jj18te5YJoYIFkJV5YzN/N9GD7LfMYZ+EzHEfJZvxMqLMkXprtof/Rt+
   Q==;
X-CSE-ConnectionGUID: wunKazQATHiQQVu8wBv6pQ==
X-CSE-MsgGUID: b6GX8LUZRbq+J6Wd85jX4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="27733695"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="27733695"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 09:18:35 -0700
X-CSE-ConnectionGUID: AHl0/gIuRMGXYw2erf2f3g==
X-CSE-MsgGUID: rdxBw36sQXOB+2q/cYI+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77554296"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 09:18:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 09:18:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 09:18:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 09:18:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 09:18:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 09:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL/fx+7q/aHgJDAPLhDKLYmZsMk0c9Inlm/Wkf0qhOT/VM0X42xu3dLjX6ysE2MyMbeeHia2tKpoKGPdSaX5nMidIgwlexi/ZsmqytE1bFDQtu0oVqwucgNWwiVbwtUYyfCX2FQQxVRXZyYYFEJmP1e6/qqlzyipgI0Ah2AoIeclngKpv1K2tqEZnHnioQQFQ4YWUr4Bls017GiZDA4u6dr+dFyRB/U/VEpr1NgVjndlItyVGXV41RWBhQnWOJrZD0bm4ZUDORVGdaXP06YIJYcaHZw+1mWKtEZchSh1JpTdvrIQ2jNJ2rYX8z5OL9UdJpuSfxxLyhPKC+TJy2LhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGrgIOZ9nN/HBbetI+y1m4FK9wuDW4TdsfMbsJh4az8=;
 b=A0/UBFrl8QKEAFTQRRkoC9R9ScfyRq9nYVK+OnsRN2V73XRes3xG0whs+5CHcTVt6IW3c0byO9fLFBi8xImBCKhOyKKrp8rA37TJoLgldlK8eE4LNRQOu64CxjS09FujoXdtqpCTZ5wCTQfaAi8180C7Be91yakT8N+5Dje8YCM/jbCe5zTw+fJe53+7bTtp6/XblwoIVOuQVVI7Rmk6YhmW7MCw3qeuEis2KhWOP9AYawL8uRFwvLbUq71H6KqS8t2Davt4G2J9k1qPwUjyTzwSctc9FJLxrtN2B3xELtp6rvH4pjTeADUok1RMhaVWk67iQgH4lJ9onSGZSNPVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 16:18:28 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:18:28 +0000
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
Subject: RE: RE: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters
 when mbm_cntr_assign is enabled
Thread-Topic: RE: [PATCH v8 19/25] x86/resctrl: Auto assign/unassign counters
 when mbm_cntr_assign is enabled
Thread-Index: AQHbHCMZy8Wwr2V7rU+ufFFthG2iObKCDytggARYDQCAAAj58A==
Date: Mon, 14 Oct 2024 16:18:28 +0000
Message-ID: <SJ1PR11MB6083379F790967B379C4232DFC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <ce07d802260f537b24b3affec57c2d2e65023709.1728495588.git.babu.moger@amd.com>
 <ZwldvDBjEA3TSw2k@agluck-desk3.sc.intel.com>
 <541d6c15-ed5f-8794-506c-8fa4065ca170@amd.com>
 <SJ1PR11MB60838F3FFF40AE2718ED7833FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <43654ae1-c894-409b-bcb8-065940644906@amd.com>
In-Reply-To: <43654ae1-c894-409b-bcb8-065940644906@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: 5fbc0e76-814d-45e9-36bd-08dcec6bd6c4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWliQWpORm96clU0aDVyVDM5bWNQMnVFbFFIeFNNaWVIQnRXQStBK1ZoSDA0?=
 =?utf-8?B?NFFEZ2tkN0pjbVZFUWFLQjJBR1NPOE1YKzNnRUZLb2RWamNremtCbTBSbDBN?=
 =?utf-8?B?Zm1VYnRoVGVKbGZzaHJZVXNaRVg3UkhFVk5mK25GclluNzFTeUlSM3dWcGND?=
 =?utf-8?B?SUdkMUEwSThOamp1Tk1UL0FCM1ZLa0FVYzQyb0RSRmxwTWlBSmdaK2RDNFpt?=
 =?utf-8?B?cFZDc1h2Y3NTcHA4L0VFZW1GaWtqdWtaSHBKbmZ4L2cwR3IyNVFZTDhFWDZP?=
 =?utf-8?B?alY3NXhNaUhGWjNheUpDWmtDcityMzJQb3poTXNmRGtnRU5abTNaVG5ER1VJ?=
 =?utf-8?B?SnMyRlBGNGM2cCtSZHU4S2plRkRiU054THRmekhiY2dUNjJOZ29zMmloWjZL?=
 =?utf-8?B?TXBoRlo5OVBIbm5XZVFab0pjeG5RWTZHQ09zeERHMXJ3ZDY0bERqQXBlVFI1?=
 =?utf-8?B?UW9MRVhMcnYyYkl3cEloZ2NWQTNScGY1S3lEaDNJU1F6a3dDbzVGWHRQZUsz?=
 =?utf-8?B?b3haYTY5eTBtemFZeVF5QlZ0VXUvejN6T0R5Y1FPWnhrYlhjN3owUVROQm4z?=
 =?utf-8?B?MmV4cXhWOEtQUzVxcFdnTlNPUGlObG1sTXRnTE5XTmNYN2oyQzVNUHBJMmFj?=
 =?utf-8?B?bi9VUi9sK0F4cGw5VHJlc0VieXdzNGJyeGs1VXhUZXA1OTJaRllvMEpyNzZ5?=
 =?utf-8?B?cDQ3RTJtVnFFbHBrKzFVUkJ6VS9BSmF5WFN6T2J6NW5OOWpZRlhxaVhrSlBq?=
 =?utf-8?B?QVhKelQ3T216SzZDK08zY2ZaRTZEc1kxMnF3em1kZ2l0bVVLbWp0bFZJK0N3?=
 =?utf-8?B?M3R4N3d2eVFYZ1YvaEhuMjVIY3BjalRMOVlmcHplWlZuU20wc3RqVGl0eUFQ?=
 =?utf-8?B?cjdEeTkxRVJ5VUYyWWUzOW9KQXVPbkZxZjdkVmVWMFlwcThrKzluV2dtQk1j?=
 =?utf-8?B?bktCcWRSejA4ZVVrRU4xeGQvbkdkcFVxWmE4ajFDeWxEeENvRmxuNDJKZ0lH?=
 =?utf-8?B?bjdZOXFuNTZRYjhDRkYzUXYvbjlWTStLVkRGdnR2cWFXRWZUdlhRSHZGZHM0?=
 =?utf-8?B?RmZzTmc3Ynd3ek1ERFpETkJTZGtvKzcvSUUvZzZOTXdLbmVKMUs5TjdTOEZN?=
 =?utf-8?B?ZFBhZGsxMHZVeVRXSGNZWUVyS0pFbWd2Y1NJRmJZVjUvSmpXc0JwY042bzZV?=
 =?utf-8?B?SzMvemQweUwvTDhVZ09MMGNnZm8xR29CQUQwbVdqT0pDdEYwVUNWVmRqeDN3?=
 =?utf-8?B?ZTVSVGFVd1ovY3B4dWpGK0dKcTZXWFFqY2lPb0EzMTdzUEpnMy9wREE1c0V5?=
 =?utf-8?B?bEoweU85blVTakxxRnAwb1VsZjRhcFVqVGcyV0RaU2RKYWdyYjI1SUtPNXZL?=
 =?utf-8?B?aWpwQXdPYkljTGJCR3VFckNDSlBvZ25SMU1FK0t2c0QreHVBbWZVSjdvV0sr?=
 =?utf-8?B?Tm9SMVM0ZWRDeGRjWnBTNG9kUWZxRktoZ3NPRWJzVDdtSXkyaWg1bEYyMEti?=
 =?utf-8?B?M0dwRFl6T3JoWFczVHFjMXprSEduVkZyR2Vkd3JZRVRmcVFGRHNMMjM1VGlU?=
 =?utf-8?B?YmdMOW9yMkk2SkIxZXRJcmp3Z3Z6K2plQVZFR3c2MTVsWjJKNXRvQ1gxVkcz?=
 =?utf-8?B?V0ZGMlpqa0ZGQjRyMFJHRklpRThsdHVnNVdGZGFTY21lMFYzdzdzMFlLNkF0?=
 =?utf-8?B?VENpNVdwcEpzb3JyZ0xac1Q3aEwxNHRycndMZ3hZeE96L05udXBNMjJQTTdZ?=
 =?utf-8?B?YldWcTVUem45S3dSZ2E2MVVDL3I4aWxBaWRIUU44dXMrdmFsRVpXMHVzNUtO?=
 =?utf-8?B?aUx5OVFmTVFFbmNvZW9sdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0wwRmM5QkFCcldGVUlzMHFhZ3JESkhyaWk1dGpDUWtaQkV2OUNMUWpPang3?=
 =?utf-8?B?RVREenZMMS83YkhBak1oTUpIbUEvZEhURXYydWdRMzBTdlRRSUN0YUtaOGw2?=
 =?utf-8?B?ZHZhcGE5c2xaMTh3elU4R0twMWM1aTFDRE1QYWtGUmFnSzdOcEJkTmxFaEFJ?=
 =?utf-8?B?disySFBzTGU2ZjNHaml2RXY1RnRqeXhRUzhzNUFvSndQVVhSZlRxNCtqMGdD?=
 =?utf-8?B?R3dLTW9tRmFwU0Y4d1RxRGp5OFJ5Q2RiZGV5c2l4aHNEM05aUGNac0FRVVdI?=
 =?utf-8?B?WFU2VFE5TG1KZ3lnSzJOYk40ZjRRTmhKazN5Y3pUWDBPenhmanpXS2RoYWtJ?=
 =?utf-8?B?SnQvcFBjbWNIRkxoNWRnb252Qng3allSZUx1WFo2RTdjUmpFNU5SUHdmOFNP?=
 =?utf-8?B?SFUvWERFdDZOS3dnM0JjQUlRL3ZTZXZaYjY2TkpZUWVGdDVLQm85ekRMWnBL?=
 =?utf-8?B?TnRCWnBnQXNVTXhFaU5ZblJhMGpkRkk1SUlIUnZIYWRiSUdYNytET0Fmb0dx?=
 =?utf-8?B?eGVUekpGdmZCK0NrQU83ZndVVXJ4UE9YRmVqc0R6MnVQZHNORm1EN0JXV3o2?=
 =?utf-8?B?WFlNanhMSjR4K1JHNGhTWGNoeGRJRGw5NGFCLzJUZ3BDZW9STXNuTUttd3M4?=
 =?utf-8?B?WElMVDlNSWRQK0JTYzJaR2ZvdUlqMy9OQkZSYVlyTWo1VVo0dGpmSVZLSVpa?=
 =?utf-8?B?enVzUlhxVXQwSFEraTNzTW5UUFROS21ucC9CdUZUdjJ4dmRIaS9Wb054U3hS?=
 =?utf-8?B?eTlMaVBhTVJkcGJKMHVYTnF4alBwVC9lMkU5QnE5RVpraTgyYmlGNWVmaFI0?=
 =?utf-8?B?ZTZmSytFekNHRlQwdFJseFlSVDdjQkhiN0JiV2kwMWxlcWp4Ui9qaUNFNXdN?=
 =?utf-8?B?bmVaN2pGcDkyanJpTHJUYXhVbGZ5L2ViQ3pITjNSSjhTZE5EcUdIRzhiYWg0?=
 =?utf-8?B?WFlnUVlHWmlUWHoyelYxc2NWWlp4cnBwcEEyNWJPcTNMYit3aXBDTHpnZTVl?=
 =?utf-8?B?U3ZZSGg3TnhaVHhDS0ZubndFQjlFdWx3MXdydTFJN2xHUzN6L25IUHlhd1ZC?=
 =?utf-8?B?emR5YjIwMXNwOG9jUUlmMGMrQXkzcG0yR29uK0taRVdTRmxrSVRITUppN3p6?=
 =?utf-8?B?aU1XWnZMUFlUT0o5cXg4N04wUzEyc3RIbk03T0JPT2cwWmhJNC9rSkFnaWdx?=
 =?utf-8?B?c0ljY3ZWV1kvc2ZhaDFLT3p2QUVWMmVCckMrSVRnMlRXOGQ0clFHWGZma3Vn?=
 =?utf-8?B?cTZYUjV0WFJPM1l4T092U1BvWVJTNVNGVmU0R2NBdlZZS0NDZHA4ODFkcEo4?=
 =?utf-8?B?M3E5N3Zsc1huL3ZIa0Fvck5CTGZyV0hZN0NMWStYRm5XWVMwS01pY3FId255?=
 =?utf-8?B?WnJXOTR4M1FvbGpsaCtzeHdZZ2NmRS9URVc5cjBhcVdYT2k3ZkhnWG1TSWs3?=
 =?utf-8?B?Qk9QM2QvS3F4ZlNSbHVnRi83MVdBQUdXMHBMS2NjTkoyU3lmNklsTzc3aEp1?=
 =?utf-8?B?ZXJzRndrcUlIZUk2czR3SENpZ1ZBVm9kWXg5M3NuVTFHSTAzVW1ybktEZnFa?=
 =?utf-8?B?M3hLbXRzWGt0eFgvNmdKczFaaTVEN0pUUDFNaThaakE2WnZJemh2eUExbFJR?=
 =?utf-8?B?SEtyTFZYWHh0MTRZL2JXSldSOU54Z01rdDc0MEpjZXgrbmlRaW1MbjNrVG83?=
 =?utf-8?B?bDlvWkpzWWczN2xLQklqRHVoSlptK3ZxMUF5VXM5MmR0ZFpVck5pUzFRNTZr?=
 =?utf-8?B?NFc0cUZLOWc1cTZyQUszUDhJQjdoeFo2YjZlTHBRNERNWlJOUkcvQ2ZaUDNu?=
 =?utf-8?B?cDlNdGlhOUFCRUFDdDg3WmhsSkFWdXpmaXNGTmlKN2pnaEFNMVBlZ2dldnZ3?=
 =?utf-8?B?akU4OFM2T3FTbVZNTGtWUU1JbHV6ZURSZ2ZHYUxMazIxQ0xwZnZUa3JGcGt0?=
 =?utf-8?B?clNVRWVJMCszQmtrUE1KQ2k3RWJRWCtwakJuRnJ3cXdyQk5lTzZFQ2xJVyty?=
 =?utf-8?B?M1Mvb2JZQ2txZEV0eHRGdi9QRjBIa05wQnhrTlFqbi9DUjlGWm5jMzRZRFNq?=
 =?utf-8?B?MnJoTW8vMzNWTURFcUlpTEtZNUVNbUJZRkRibHlVd0s1bkorS21aVGdBRWlI?=
 =?utf-8?Q?NhOX24NtXxqB0Qegc4Qt2Oot3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbc0e76-814d-45e9-36bd-08dcec6bd6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 16:18:28.8386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOphm53Lbcu/slcqB0YkRRAEuk2rH76R7vYveJhJLQBirgpsGho3gQrBsSJ6RZ0FhvX/vjpVoxCKemRF+9V9rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com

PiA+Pj4+ICsgIGlmICghcmV0ICYmIGlzX21ibV9sb2NhbF9lbmFibGVkKCkpDQo+ID4+Pj4gKyAg
ICAgICAgICByZXQgPSByZHRncm91cF9hc3NpZ25fY250cl9ldmVudChyLCByZHRncnAsIE5VTEws
IFFPU19MM19NQk1fTE9DQUxfRVZFTlRfSUQpOw0KPiA+DQo+ID4gTm93IHRoaXMgY2FsbCBzdWNj
ZWVkcy4gVGhlIGZhaWx1cmUgb2YgdGhlIHByZXZpb3VzIGNhbGwgaXMgZm9yZ290dGVuIGFzICJy
ZXQiIGlzDQo+ID4gb3ZlcndyaXR0ZW4gd2l0aCB0aGUgc3VjY2VzcyBjb2RlLg0KPg0KPiBJdCB3
aWxsIG5vdCBtYWtlIHRoaXMgY2FsbCBpZiB0aGUgZmlyc3QgY2FsbCBmYWlscyBiZWNhdXNlIG9m
IHRoaXMgY2hlY2suDQo+DQo+ICAgICAgICAgaWYgKCFyZXQgJiYgaXNfbWJtX2xvY2FsX2VuYWJs
ZWQoKSkNCj4gICAgICAgICAgICAgICAgIHJldCA9IHJkdGdyb3VwX2Fzc2lnbl9jbnRyX2V2ZW50
KHIsIHJkdGdycCwgTlVMTCwNCj4gUU9TX0wzX01CTV9MT0NBTF9FVkVOVF9JRCk7DQo+DQo+ICAg
ICAgICAgcmV0dXJuIHJldDsNCj4NCj4gSGVyZSBpZiAoITEpIGV2YWx1YXRlcyB0byBmYWxzZS4N
Cj4NCj4gRGlkIEkgbWlzcyBzb21ldGhpbmc/DQoNCllvdSBkaWRuJ3QuDQoNCkkgbWlzc2VkIHRo
ZSBjaGVjayBmb3IgcmV0IGluIHRoZSBsb2NhbCBjYXNlLg0KDQpJdCBpcyBzdGlsbCB0aGUgY2Fz
ZSB0aGF0IGNhbGxlcnMgZG9uJ3QgY2FyZSBhYm91dCB0aGUgcmV0dXJuIHZhbHVlLg0KDQotVG9u
eQ0K

