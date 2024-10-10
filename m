Return-Path: <linux-kernel+bounces-359865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B419991B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4111F265CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0EC1CF5CD;
	Thu, 10 Oct 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zpj4bAwN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE37F1CF2B4;
	Thu, 10 Oct 2024 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586658; cv=fail; b=SH2YZrS9K4QCdMMMqxzg1g+KiSSQ5YKFu5A2NFBUA4Zg3WhXEoolVbqcrnD57wk1jCyj46CPNVMyQlkn/4aEguibFhfvxLsDUWiVUlMUIrklQjpY0AfrGSQ0Cs9/6bQ9qSTZBvPSJOx7q14WCl9DwcQnaGzQlkLmIuaBx5TA6yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586658; c=relaxed/simple;
	bh=593qkRKxlI3JC1LZA/5mk70pD8P6x4eM3QxZjyRVzBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jtBpeDuhobVi2ydpDBx1dLpc+k34HTdLFmy4DeMebhFlyZR4EfsGrPiZxR9co343UNw6tOjlXf242N9Y5+6COeBNxp0Kb5aQz+dE/z80ZScSOWLmagIiu+SAJ0VQg0ax6ehq4lnjGuarRsF+W0qxWfNAyIXrjGCR29Uro6QMYdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zpj4bAwN; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728586657; x=1760122657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=593qkRKxlI3JC1LZA/5mk70pD8P6x4eM3QxZjyRVzBU=;
  b=Zpj4bAwNIyBU5+rd2Jft291m59ZKIaTHA/EofLBBGpajbpExIWmuGTMu
   BfaYgUkHf0w0YYQ8Zn2Vc3BmWtDKv+iXsTaVpGR2tJnLDi7xD+DdHN16H
   dsRuu/sZ2onEVkWIO2EO62y2ftn8eEn1PttrtfxsPnQqQ/UFcPN3GNNk1
   uWnclBwEV6Ecsqvtwu3hi+zRUOMjcF7CCyM8kmPvZk0XLRo+KhjneUfpT
   G2zLpV41d8IaBEOTLs6fur31MHMVGXxaVcakzcP9lh47pcO7z207oylTl
   1W7GflwobbPSIucNGqD0UTnaFrKEk8huwgCVgT3KxF9ssfIB3aVsvSfka
   A==;
X-CSE-ConnectionGUID: /rH+MQs+SbmsqMrGc4SPhw==
X-CSE-MsgGUID: 089GWvwJR0SaFum1rs/Q5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28110410"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="28110410"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:57:36 -0700
X-CSE-ConnectionGUID: PMca4bBxRdSAa3OwMgh51Q==
X-CSE-MsgGUID: k1X1tDL2QwGp2VIDH6iQNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="100018781"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 11:57:36 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 11:57:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 11:57:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 11:57:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 11:57:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFmeO///3Nf0knFeHfMWyaqzATKAwP7kkNnHdhgMijqfHkYyM5s1SYTYDLeTEFlAGt28SdjhggJ8cYsAIDE1TgUnwzTQlEowf3ndJ150mKA4mlKk/wSZfgr8Ef2/S5mRzSRfSprWGLl6yaoVEx4ypIvKKYoH5WCKsGUBPoIWCVL/27r3iiqj04MnvXOO7ZN8GgcsiYMeMzGz5k0NVvm2aD1hs5/waZaRqsWhVgESWIFU/GdCX6tDQr+g5vQ/kjO8YUxnfN4sP4XRW9Y3GdotczCYxpe6TcJz5ubPM9+fvzzjAvihKFGbzpb5plulRnJ09HRe8XReBvRnmFvQUWC6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=593qkRKxlI3JC1LZA/5mk70pD8P6x4eM3QxZjyRVzBU=;
 b=LQ5go74Ha8LXiNY1iM3PN58BQ5pU8/xQaFl6E4y5hKTR9Ow69qQ+WCIUhUYsNJTZUphgeOF58wFr5gwlBHk3ynubr8j0WgF+bO3aIVzhQ0iMDjakdu7xuHI8mP7BM95dXFSpIMzKwmAlzk7ncMForOaIOABHX3TmEbLwfgx9CqB6Z+C/Kg55ISaJ42oPXnQUjZDA070DYOUPwED79X6H7gcGvbnzH905ibxej+Cje4vPqR5FvTLgX0wSJl40l83BrnJ3EHGsTmFufCVz7DIG1Z+sDImQSO0RhxVjFIiNom0pQqd7Jn0WTuO9nDtWirND8vnrJjysJA7hYvTMPsZTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB7446.namprd11.prod.outlook.com (2603:10b6:510:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Thu, 10 Oct
 2024 18:57:31 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 18:57:31 +0000
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
Thread-Index: AQHbGybdEonESjxpIEK+MSvEee6fXLKAG/3ggAAYpoCAAACqQIAAGxsAgAADIiA=
Date: Thu, 10 Oct 2024 18:57:31 +0000
Message-ID: <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
In-Reply-To: <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB7446:EE_
x-ms-office365-filtering-correlation-id: 84915fc7-3d6c-4c97-a133-08dce95d64d5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1NkaTJxdGgrNVlESzFRY0I4OE5LRVJmamcvOWVtOEFRYkFGbkpUN3pjdUNR?=
 =?utf-8?B?NE8wOHpBOC9JK3N4U3hSSGRlc3k2OWQzcGpLOHhjc0hRb0ErNzFpWWdxRWdD?=
 =?utf-8?B?R05CbDBCR1FkRG1sV25PclRHZkQ0d3p4Zit0NCtpclIvanFUMThIOUNCanM3?=
 =?utf-8?B?YU9RVHhBN0JxL1F6dVpQYVJTK0FES090R2c4djFWR21yNzlsbkovV2Y1cW1H?=
 =?utf-8?B?MXJDOE1sRFJiVlZLNitmLzRuM3RKRU5tYkszWkd4MGtOK25Kd0tQV2dVaVNx?=
 =?utf-8?B?UE1McUlydDRwbzlKOS9jSVIvaWNDQzhHK3R3SzhEaWpiby8wSlgrMEliZFpy?=
 =?utf-8?B?Qm5UTjB0eTZUTTFGa215L1paOExrdXpVelJCMkhtTWdwNjlDdlhRcTB3c1B3?=
 =?utf-8?B?cGZpdE5aNGtnSzRZSk9uVU4zRk0xV3J3Z1QyVW1vamRDQjdWTWZocXhZVTJU?=
 =?utf-8?B?VG9nV2d3ckN3UGV0VjlaZ1dsZVhPN3NBVk9obHo5L1ZSWW5WekxQclJnMXFo?=
 =?utf-8?B?bHVrcTZJOW9EL0VCZjk3aFRWbms5VGRQQWVjQnI4WUQyYnhNTUM0UktqVVNU?=
 =?utf-8?B?aGdRa1VkV3hBcUt1UjE3bkdMa2paOFlYS1lpdFFFZGhZMllESStZN1RuNEFE?=
 =?utf-8?B?aUdldURrVFRNR2N4eDNMNlBZWlRZYTAvQ2EyNWZFYXZaQ3l5RUlhWitJa0Fa?=
 =?utf-8?B?VHhTRzBoVFA1dmxYakNlZER1UEY5Nis5akpGdW9MZnpXRTFaenA5SlNxZklh?=
 =?utf-8?B?WnR6QSswSmpIMUxPZm9USEkvWjByd2FvZHh5N2IweHBtVEFMUFk5VVBpVUdT?=
 =?utf-8?B?Szk3SDlsZ2c2QWp5TU0yWVc5eWtJclI4QmUrWmRXQjhLTDVmOGM5dFp0S0Yw?=
 =?utf-8?B?bnNMQklXVTRvMmhWTmhjMTliYU9BNVBIUWtRSHY2d1JXTTBMM1h6SXQ3bUpl?=
 =?utf-8?B?N0hEMkVtYXlmanNRZzVzV3ViOHpmN25DMEdGSG5yUE9teUNZanV6ZWZkS1R4?=
 =?utf-8?B?c1ppbzduUDdIaEVsMDdYaXlxNHRjczg3NUtMdllHK0ppRW5XU3ZNVVk4ZFZB?=
 =?utf-8?B?T2xnUTVzTm5XbWFEVTU0clpXNTJrUXBQUm5Ba0JqYW45S01nYVUxRTZ3RStk?=
 =?utf-8?B?eTNiM3hGcWJDUW9VRVN1dURuY1hScmNRM2Nac3JKM1NQMmpLS1V1NkFRMnFW?=
 =?utf-8?B?ZmhVUjFQc3BpMzgrd1IyTTMzdzU4ZVFGRkQ4L0YwblJuMWdyWkg2ZFB4QmZR?=
 =?utf-8?B?cU1QZmJhVE9UQ1JGQnFDd0RJTjBJcEZEOUZJNE1yV1lDeUMwSHROV0RkcjZR?=
 =?utf-8?B?emI1ZElXOVJRS1RQRGFCM2Vxcjgvaklqbkx6ZDdmeFEvbDh3bVYvNnBzMlpF?=
 =?utf-8?B?dEpQLzJnL01BNHZGK1VUUEZKK2JGN0U1UThSR1M0di9pMTEvVjl3TDVkcEM3?=
 =?utf-8?B?ZU9ZQzBEOWF5Zzd4TEFuNmdYUGxVbUllTW1pVGU0ZXBZQ3k2aytrWWlJdHht?=
 =?utf-8?B?cDZ2RmIzUUdxcTZPYnNVZ1ozMXYwMXdOSGtIWUp1c1IzMEUrdFU4ZEJTMzNR?=
 =?utf-8?B?V1JjRFZHTjdmYk85RFY1OGJnUnBpb1BhMmh4Vml4M1J5c1UxVmxjZnpCcEVP?=
 =?utf-8?B?UUNsRE9rVXkybE9NQW03VjIwWE9iQ1pxdWJWUlJhRkhjVEkwSXhqd2pkZGFv?=
 =?utf-8?B?SzAzZWdPNm1HTC9BM09Jd2FOYmpBaUhCOWdkNGV2c294NEovd0liM2hqckdI?=
 =?utf-8?B?SWFYZXhiL1NHMUpoalVLaEtTcnp1bk9TbjVTb1VFQWorNHJwaDJsZjRGN1RB?=
 =?utf-8?B?b0lGbFM4QWNvUEhxRjFTZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vkc0Mi8xbEhqNGhwNUc0cUFrNDVOKzQveElhMVRSd3QyWFVwQzRoVHFYeFJQ?=
 =?utf-8?B?dzBuR01pUUhrOVdoZzFwUVlaak1lcUcvRlBnQktJZGhMYXlBcUF6dHcxU0xU?=
 =?utf-8?B?YlBJSklQUElSTzR5bFlneXNJMzhWUlpoQnlON3lTWE91ZThBb3hFa1B6aGtC?=
 =?utf-8?B?ajdTdXBscld4WEZMeFYrRWVKakFGUzREWnpjN3JxNmtDUWlXM2FMai9hWnlE?=
 =?utf-8?B?bnlYd2tKTE1SblhURXdpZHQ5cG9CdUxpVzRQTmJVSWprdC9EM3oyOHJyOHFH?=
 =?utf-8?B?citpRUdPbnQxdXJaVEF0M2k1WmdMM3h6amx3Nmx3SDNWSVM5QUlSaXMrcUQw?=
 =?utf-8?B?emo1TGcrQXRvcGN6cHlWdkJ2SEpPZndsY3drakNYWFNCL0g5QUdUT1lEZ0Vo?=
 =?utf-8?B?NXJhUUxaeERrSk04d3ppY3ptcCt5NmdONFVwS1NTMU9WMlZXSFlHQkU1UHZJ?=
 =?utf-8?B?UHFlSTJac1BoNFlkbjBYZEF6aEQ0N2FLSGpUT0NURmtzWUFnVHRJbmd4WjFG?=
 =?utf-8?B?Vkx4L0N4S0VrSG5OeXNmdFc1RzUyWGR0UmYrQTV4bTRzVnF0N1IyVzg5Z2t3?=
 =?utf-8?B?YWZpS2E3ZXYzWEV1REZrVk9WL1VyMXRHUnoyeUdUdzIrOVd6OFpkNDhqN2hP?=
 =?utf-8?B?R1pCbWtyZDVYR2N5ekdadkdGUElPVDVIbDFVeWs5NFBsb1UrWUlIWlJUaVFU?=
 =?utf-8?B?L3FYMHNWNk1hVS9jVStjV09zanNsRGlnbHp0cHlpcGZWaTZOQ0tzc2tpcWZZ?=
 =?utf-8?B?dFR4alhuLzJCT29wNUFyVFhXV3c0djU2SkxhbWRjV3VGUHcrRXRjVS8vWldz?=
 =?utf-8?B?Sk5PWDdGaDZtYjRlcEtMRWxOVitqZGx0RkduWGd5MVRLeXpUdGM0aVU1VE9q?=
 =?utf-8?B?RGkvaXF3WGVXMDZ0QlhsZnBTOWdLZ3BQNVhiVDhNeVM0eDU2YUNRRHVOK3k2?=
 =?utf-8?B?RUM4anAzeXVnMFdVRVVBc04vRkxsM01MbUIwSXFWMUJzQXNwN3FNZys4N0xH?=
 =?utf-8?B?b0t2ZUcwNkxuTmtPdVBwcFQvcmp0SERlR3JEZUxIdGJxV29Kb0hqVExpeGYr?=
 =?utf-8?B?YnUzLzQxbURrTGtzaXl0R1ZOeXQwdXBYc2YrcG11S1JOZDhsM0RLWUh4TGZH?=
 =?utf-8?B?RGV4eElhY3JEeVM0VThXUEo4NVNObUc2dmFwWXZWd0ZiVDhmS2Y4Mm8rRnJ6?=
 =?utf-8?B?bWNIMkVieE4yUUlKNVJwSkJyWVRGNmE0eittWHA0aVl4eDNHUmF1Yk41aFlN?=
 =?utf-8?B?U2VFc1JpbHFEbEVHS2VqV2E1cEVhRFhBdEdTTWRFdzg5OENZKzdub2R5M2Zw?=
 =?utf-8?B?UTQ3cXpyMFZ5WHB6TjBtVWZwbUkvdmtqamI4cDVJZ3ZqemZWWWxVMXBMZklK?=
 =?utf-8?B?VlhEUjdDeHZUbGVEVEQvcys1blYrNGo3L3d0NTJuQmlWUk5JV0pIYlpoVi85?=
 =?utf-8?B?d1NIQ3pBSWVWVEVtTzAyNnlxclZ3c2lCVWRBOC90eXV3dlZkVlQ4eWhocjFa?=
 =?utf-8?B?dHJ2Z280UWRURWpxU2ludE9aY05FemdJZUdlYjd5YzM4aWRMNDBaVFU0WFpW?=
 =?utf-8?B?c2Q4QTZSYllTK2hyT2tuUUFrNTNaTWxiSzM4a2hKd3FPQ3JkT3RYMlcyWVBF?=
 =?utf-8?B?Ty93UHJ4eXk2L2VCcDc1T2NOQitScWFYZDVCTEd6SklrSDNMbGpBTTc5VFlZ?=
 =?utf-8?B?cHpYMUE4WkQ4UFlEZWRSVFIyUEU1U0dxenl0SDV6bmRRQVZ3bXVVWmJCcEln?=
 =?utf-8?B?Y1NSZUN3OEpxdWpBSTBZaVhoeE96SmRCSzhqRmNKR2svZWxTamYyd2FhT0Nh?=
 =?utf-8?B?WVRNZkJTWHVKSUQwVExVSXYrU0N0dThpaERKVDJIbkg2M3Nwc2plWm9GY1RT?=
 =?utf-8?B?d2J4Ly80YTdsZFNrSFRjemErNHZwK09VVHE1YWdIeHdxVkFrQU5CU3NReDla?=
 =?utf-8?B?SWJMS0JEa1BuSkR3TkNSK2J4RTRGaU5lU1JmWnl4M3BIbkhMdzdmcDVPL0dR?=
 =?utf-8?B?WUVqWUNtTW9sbUFPeGx0RWhpQnFIN0hUWkRQekdCZXpDdGtMSXhzeU9JejY3?=
 =?utf-8?B?d1lndDJEaXliYWE0cGl6Wm5EWjJwQk5rNWxOalBrN01HTjJuVmlrUzEwMTBQ?=
 =?utf-8?Q?bWn62U5id5hV5A3sHg2UteU/Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84915fc7-3d6c-4c97-a133-08dce95d64d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 18:57:31.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5sDFJBgR8UKYNKvTkPhyq07sg96x/DH0UiiyfLEOWxz7zgvuBIM7PNs0JtjszeFY16P2QVcdsdkePMTgToi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7446
X-OriginatorOrg: intel.com

PiA+IFdoeSBoYXZlIHRoaXMgY29tcGxleGl0eSBpbiBtYm1fYXNzaWduX2NvbnRyb2wgc3ludGF4
Pw0KPg0KPiBMZXRzIHRha2UgYW4gZXhhbXBsZToNCj4gJCBjYXQgL3N5cy9mcy9yZXNjdHJsL2lu
Zm8vTDNfTU9OL251bV9tYm1fY250cnMNCj4gVG90YWwgMzINCj4gQXZhaWxhYmxlIDMwDQo+DQo+
ICMgY2F0IC9zeXMvZnMvcmVzY3RybC9pbmZvL0wzX01PTi9tYm1fYXNzaWduX2NvbnRyb2wNCj4g
Ly8wPXRsOzE9dGw7DQo+DQo+IEhlcmUgZGVmYXVsdCBncm91cCBoYXMgdGFrZW4gdHdvIGNvdW50
ZXJzLg0KPg0KPiAjIGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19NT04vbWJtX2Fzc2lnbl9j
b250cm9sDQo+IC8vMD1fOzE9dGw7DQo+DQo+IEhlcmUgZGVmYXVsdCBncm91cCBoYXMgdHdvIGNv
dW50ZXJzLg0KPiBEb21haW4gMCBkb2VzIG5vdCBoYXZlIGNvdW50ZXJzIGFwcGxpZWQuIFNvLCB5
b3Ugd29udCBiZSBhYmxlIHRvIHJlYWQgdGhlDQo+IE1CTSB2YWx1ZXMgZm9yIGRvbWFpbiAwLg0K
PiBEb21haW4gMSBoYXMgYm90aCB0aGUgY291bnRlcnMgYXBwbGllZC4NCg0KSXMgdGhlcmUgc29t
ZSBiZW5lZml0IGZyb20gZG9pbmcgdGhpcz8gWW91IGFyZSBzdGlsbCB1c2luZyB0aGUgc2FtZQ0K
bnVtYmVyIG9mIGNvdW50ZXJzLiBZb3Ugbm93IGNhbid0IHJlYWQgdGhlbSBmcm9tIGRvbWFpbiAw
Lg0KDQpZb3Ugc2FpZCB0aGUgY291bnRlcnMgYXJlIHN5c3RlbS13aWRlLiBEb2VzIHRoYXQgbWVh
biB0aGF0IGluIA0KdGhpcyBjYXNlOg0KDQojIGNhdCAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9MM19N
T04vbWJtX2Fzc2lnbl9jb250cm9sDQovLzA9dGw7MT10bDsNCg0KdGhlcmUgYXJlbid0IHNlcGFy
YXRlIGNvdW50cyBmcm9tIGVhY2ggb2YgZG9tYWluIDAgYW5kIGRvbWFpbiAxLg0KSS5lLiBpZiBJ
IHJlYWQgYm90aCBJJ2Qgc2VlIHRoZSBzYW1lIHZhbHVlIChzdW0gb2YgdHJhZmZpYyBvbiBib3Ro
IGRvbWFpbnMpOg0KDQokIGdyZXAgLiAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGEvKi8qdG90YWwq
DQovc3lzL2ZzL3Jlc2N0cmwgL21vbl9kYXRhL21vbl9MM18wMC9tYm1fdG90YWxfYnl0ZXM6MjYw
MDM5NDY3MDA4DQovc3lzL2ZzL3Jlc2N0cmwgL21vbl9kYXRhL21vbl9MM18wMS9tYm1fdG90YWxf
Ynl0ZXM6MjYwMDM5NDY3MDA4DQoNCi1Ub255DQo=

