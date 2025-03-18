Return-Path: <linux-kernel+bounces-565423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A3A667D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A16E1792EE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0D195FE8;
	Tue, 18 Mar 2025 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EXyfjo3n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689274C6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270095; cv=fail; b=dqDVK9xlY07B2mO94GJW+nBmKS3n8CRexeySfJ7uCrL1R01p+QvLnHoxRBXu6XBLRUXj7nZYkqAZW57ID8pUEc987FHeGFVBJKuuehbbJIrnTVVZR9basr9+7ZfsDTQKT46jJEeqSNAgAHA6b7uQcXkhFcCzmPLvyZRvsKjf2lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270095; c=relaxed/simple;
	bh=Ueg9s/ijvCdNwCAKJ1+9+7XNpjihF35P2jaY7ZfB5d8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcdKN/Ie1+eS7EkN0FUdfi3LEFHLPwpxk8pNvlgxnkFWj8n6JVLYDsZxtPeaDSTLR2gVI5d6epZWKLN45Fkchxcj4ViN3bW5pwp3eFkHm7ycclRUUc8yIx9MKOpt8Fa0YAhEre0oIcXGJBFQvHwbcgxx9V2gzcnV06C/lkKzOwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EXyfjo3n; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742270094; x=1773806094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ueg9s/ijvCdNwCAKJ1+9+7XNpjihF35P2jaY7ZfB5d8=;
  b=EXyfjo3n/6beYbulf/W8/3ucl9yHlkqJZWCaikOl5oLNRaQ4ZxEVd2uK
   mR89Foayy+7wJdsJfje4gConOiw9LvvoiYgiNIwgS0De/uxXORlXPF7TZ
   jPIfqFUL0aOkxgcTewouQpusem3+kxRbmyd4ByifuZ/nA3w2dNqjqZvi7
   s6ccN9lwseOCuqU5DaI/zvHbxlJR40AAm5kmCpEzzzo9XZpEG3FwiWY3g
   NsvAua+i/ouzOei57aI7dRAK0rprzPMvcm8kFmyHUl0Qzvr3U5+Gflqtg
   Jm9efLDR+IB5SSzH1nFdKfFZ44tTFTaxcg9Y+zN3ipCSv8l0kVp8OdXep
   w==;
X-CSE-ConnectionGUID: 0Dh6SMJmSkC0P+G1JDxJXw==
X-CSE-MsgGUID: 9G2h8hVAS7u/DIKceK+twg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="65850421"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="65850421"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:54:53 -0700
X-CSE-ConnectionGUID: OaNW629dSnKeybiDIG2M6w==
X-CSE-MsgGUID: zji621bIRr2rUy779SUKQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="127222869"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 20:54:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 20:54:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 20:54:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 20:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBrKevniSrPI71xIYLLnTsTK5+fKBmmubwqunJRcdW4/3tDy279XGtxwRlZ5mvst5RQWP4MVbgpAS8wLBLmRlzttD06ozXuYEuhbTryHbc3xC5lBnoMrUyUPCXwFoC9EWRhtahrJDZWuRXi562m2iaVxs7oGRnLBnok+/fkmhEzaEoogG8hce1OHSaOgILAUWnhI0VaK3kUcZwm0OqZ5sGNwAOoFlmQXF0iNMFmxaSJ4QY0dE9O/YhnMtyh6g7xVszxRHeagg45cqus95ey/JIR8l4NNJKnCwF+M6u/Go7Tb4kKP0kdWKIrjSomDE1yYPXG568SAob+MsYqirmEq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ueg9s/ijvCdNwCAKJ1+9+7XNpjihF35P2jaY7ZfB5d8=;
 b=MZx4Rv7VzzL6J/mykLmSeLNbPKJpamGvG09VF4Dl2gTh0P9XmpcF2oiucTw0S+Dz27t08REUHh9Mq/0LOup4437SoOY8oZ6P2K39oQ9VKbt0TncB5XHnK0HRDM1nD1z4eXFkRoWbuzAMsZo+TX5DXv8Kx3XTDBqJfegmQ36SMQH0CUQ1p2n9/pELpVH8AHjCFkYo0c6PZLSbfyVNVjO2lC6koOIyOOrDMBSnyOaA93YPLTHjp3ulTHljLsVjv2JdMzugMzoNQyFjuhMw54PjUtE4aiKZ7OncaNux8MyfqZix5lLkJ8+IVI4FzEpkFyFBIq10Vbgel9/hfx0Xb0pf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:54:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:54:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"david.kaplan@amd.com" <david.kaplan@amd.com>, "x86@kernel.org"
	<x86@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in relocate_kernel()
Thread-Index: AQHbk0LH0f/Ie6UWpUSQoMR8xfb+F7NxtZyAgACvV4CABed/AA==
Date: Tue, 18 Mar 2025 03:54:48 +0000
Message-ID: <15521a8142a83acfd2f41712e4cd93a3d1a8a28d.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <ebe4c0e8fe1b78c014bbc18832ae0eec8fef419d.1741778537.git.kai.huang@intel.com>
	 <1050a84caa9036e3ddb580fb510e634a216e692c.camel@intel.com>
	 <40b14084af8a35af4e07fbd394821f92d0973d32.camel@intel.com>
In-Reply-To: <40b14084af8a35af4e07fbd394821f92d0973d32.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB6818:EE_
x-ms-office365-filtering-correlation-id: 925ab25c-dc18-4f70-30a9-08dd65d0a120
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YktHdVBja09zSUlvM2V5dVFJNVNzb0VTbDNoNjlsTHpoa1h2YzdNTW55YnNV?=
 =?utf-8?B?Mm1qREUrRnVGbnlmaCtrTGs0ajdXOGlsSUQvZzZYaDZOZmFEYWRoNU9SSnd5?=
 =?utf-8?B?VzZhNVl0dGhMbDJCR3hNRGc2MTB6czdINEpVNGNwT0ZaOFFtSEd4WThZME5w?=
 =?utf-8?B?S05OY0d1TVAxQTVSWVI3MzdPcXRHVWJ5Qzdwc0I2SnAwUnlzYVFkUm5meHRN?=
 =?utf-8?B?S0h6SXVteHV3clRaUlZDemZid0pKcHRDWVBxYjZiMFVwZXFOMDZLdUc1L2Y3?=
 =?utf-8?B?dnpwWkxJV1NLZWFvQnI5VEdCQWNaT2hKS25YWjZOZkk3Y0RyOGZDR1U2MXNJ?=
 =?utf-8?B?am45THVvak1HUjVwbHR1MlQzRUdjdXorQUNZZGszTmI2T0tScllDK20vNG8v?=
 =?utf-8?B?UFlCVy9CZmZtZTZJV0MwOXJvSzVQVlgvWW1NMkRXQ2ZCTTlBaFJTL2ZXbVlE?=
 =?utf-8?B?U0lIZUdlSkVjSHFsN1V6Y0Q5WDdjNFphT1hMQWQwTEk3b1Iyd3NZUTFlRTlo?=
 =?utf-8?B?aGJFMnJ2S1ZFM01RYi9jMTVhRVNNTlN5bk4yam1tbFhUSGxOeWJsRmJyWWFq?=
 =?utf-8?B?RTlnSGxpcG02bU5ES2lMdFA3aVpaQlVBSFZQUklESlN2aVA2WTh6QUVNYkVn?=
 =?utf-8?B?eHIvU1FpN3ZQQU9LbWozQzh3cG1ua3QydUlkOXp5L051SmZRamtEUUxHWG85?=
 =?utf-8?B?d0R4eUw2cGdSdXFDeWRmcWZlREc3NHNSMUMzd3JCQ0I2YXdFU01sT2c2b3dM?=
 =?utf-8?B?WUlyckV4YklvVEc2SGxyYlplSlVDalF6alFSUjFCTlVjT3dSa1kvYnZubFlD?=
 =?utf-8?B?TUxMVjVCV0VDQWVidjZudm9qQks0aWwxSXZRY1dpVURBWGFUN0dVOFZuRVM4?=
 =?utf-8?B?b2MwZEg3YkQ5aDZkMU10YU1nSkdYYlRUQkZPL3AzdGdIcGdzY3ROdndpNkRz?=
 =?utf-8?B?UVY5QWZUR0NQZEszZHhpTkNzZ1RKdTFmdE15QjBUWFlOYUIrdjFpWGY0S2pu?=
 =?utf-8?B?Mmg3dW5TQ2ZtekVqek55YmtrZ3lubjNtdGRDRDhKMzU5WTQvV0RSUmo2eEhU?=
 =?utf-8?B?akhlYzNVUzduNFBXVDVGNEQ4TS9OVEhvMWNHQyttSGU3SlJudjFMbk1PVW9D?=
 =?utf-8?B?MitvbktZZkFGOTFheGZ3Rk9ON0FlOVg0UWk0TEdsaW5QekE2STBNSGxXR2da?=
 =?utf-8?B?Z1dwSFlyUFlEOTF4c3VEUlBKbUhWM2g0SHNYeGVUVG80UVI3aGwraXpPUjEv?=
 =?utf-8?B?UUNEV3p0N04waytKZlVBeU9NZ2NGRVhyblhMZkxRcklmTzBZUU1YY0tacWNI?=
 =?utf-8?B?NTg4ZGFIRU5FN3VZZFg5WHlMQmc3emZwVmRtc0Z2c1VuRFJoN0N2eUlBQlFw?=
 =?utf-8?B?T2xWZjY3bFJMVlRyNmljY0NEdkJibVpmeE5TTzFCVGJYNkpWUU0rR0FuTDJy?=
 =?utf-8?B?ZmpFUjlrMStVcUF0OFUweVVTZGp4dm0wclJWajU4WW5VSjFPdWRmWldoNUtB?=
 =?utf-8?B?N3lQdnlWSERXVnFwdXdoaUVnMkl6ZWZqbU5BdllKelJySmsrMlo3SFZHWmlU?=
 =?utf-8?B?MDFKL1VCSzNBS2RCRVJubWhmdkZjVkkwblg5Yll0SFdDZU9BRkg0UWZHcXNO?=
 =?utf-8?B?d2RwNWJKUlFKMVBsR1NiU1F1Wjl3dDVTV2ZOekpla0Ntb0lxNThHUHhWNHZr?=
 =?utf-8?B?QXphdk9KK3RRWmtydVpvc1BPUUpheU1QMlhDdEtyOWpseG16TWdPV2VHcHlt?=
 =?utf-8?B?aUZGczRuTFgxVHFpclFkcnd4ZmFXd3ovZDZNR0Mzc01FZWFoT0FxcnhGbnl6?=
 =?utf-8?B?NTZvd04xVTFkTDliMGw3Y0QzOHQzWjFTNndLVE5pbTRjd1JPMEJMRHlwQXQ1?=
 =?utf-8?B?WSt4VGVuTFJyRjB6UEZPOVJUazN1RUg2NUl1U3p1V1k5TkdyczB5TGtSeDNW?=
 =?utf-8?Q?+duHWXQYQ+5pZeFRdNKNEYOQtTfgRI9E?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NS9RMHRYdkxIYXNGbjM5bmczaDJtTU1rSy8wVzlxcVJBSEpobzlrNjFRTW1Q?=
 =?utf-8?B?Sk9kWUJOaGN4ZkdYS2dOSWcrQjFob1dXNEd1QktXLzNLZVFsYmdaZWtFVXk4?=
 =?utf-8?B?SXcxSjRFbDkra1lValIzTlIwVXNZd2ZjU1RLME1zVG11dURmYjBsZWgwRzdt?=
 =?utf-8?B?NkRWWnlvVFNidkF3VnRrTUxtKzB2c3FOS3RwYkxldU1VekNzK0IxVkEwUGZl?=
 =?utf-8?B?dXh1K0t0bzRibWRQcVhTdHVIS1F2MGRxMDJCb0ljWDVmZXBPMTByektvRy9O?=
 =?utf-8?B?SWxhbGV5TGZHb0MwRW0zM0h3SU9RMDFJT01JdnJWMWQ2bUlXUFJ5TzBRdVlR?=
 =?utf-8?B?Unpkb0hLT3k3eHdNOHNMajZDQkRmMTFiVlBIazdXcDF2aE0xL3lmNEpMMlNJ?=
 =?utf-8?B?MzVHa0xDNDhEMjN2dDVPa1c2R2VaQzEwR21wZm83SER5K0V0czdEcGRqL3dD?=
 =?utf-8?B?UVQ5bEcyalpGQ2tHUFh2UkpHRVBTQ25NaDVnTTdJbFJMUkdwM0Qyc2lmOHYw?=
 =?utf-8?B?Mk5LRzhDOFV0eWpyVHhvWjZPM1VacXJEWkE2UzZVbzZTc1JvNWt1bEY4WE90?=
 =?utf-8?B?RUJoS25uUURlTFFGMndHRUVYRVdXUHIwdGJWUlhrOXhJYnNzZ0pJNUtWdjJP?=
 =?utf-8?B?ZnExL1VTbDIzQmM0aDNuWEViR2dmTFlJSnRYRDUvditmdkxEcGpianVTWUQ5?=
 =?utf-8?B?TDlKZ1BNa256dmJpMERBc3BBV0syTFRDbzZIT0VjV3ZEWUt4VjVobUNjS0kr?=
 =?utf-8?B?SkZ4eHhtOUJRNGl4K2JGRkUzSERXdUI2ZzlHUzlKY2V6MGlzd25XRTBiQkc1?=
 =?utf-8?B?REJlOHN4TXE0aUM2YWtZcWRIZndVWm40MVBnMnREMEIyYit3L0N5elphUFBx?=
 =?utf-8?B?U05id0FYY3FFYkpON0YvbFV2MGRjdnZMNzVrLy9CT1htbUxCbHZQVksxVEgr?=
 =?utf-8?B?T1QzRExQT0E3R2ptN1RYWk5ndDNPc21sN2N5Rko0K3J0QnBjZGI3OWhBOWJV?=
 =?utf-8?B?STdRV0Q4b2dmTGFiUklzMzJ0Mll5bkM3UzRkSU9DTDIrTnV5RDBKUGMwdlBQ?=
 =?utf-8?B?SlRoWDVyVlNYclB1MEFwRnh6SEVhVWNJRzJYbSt2azFrckdsYXFrdDRGRktt?=
 =?utf-8?B?bWRIN0M5c3B0anQ4SEduMkFtOUw2ZDM0KzdqR3Rzb01HdVhRVDhweFpneHNR?=
 =?utf-8?B?d1NidlkrYmV0bk54NlV1SFB1aThuanF5SEV4MnJ1b1A0SzE5K1VlQVR6bHJJ?=
 =?utf-8?B?UmNYaEI1Q1J6eitpeGxpa2w3dzI0UWpCZHBzVnRkUkZQNzRCQVJOUE0vRmF2?=
 =?utf-8?B?NHJnK295M2s0NlNoR2RSdkJ0TFJZMTZMUFAxTEhzeElsNkhjVW9kNWFVQmNH?=
 =?utf-8?B?aTJIR2JhVEJOVDBWbG8vMGZFVnhPb3FUck03L2RYcGk5UXJ1MUlzeWRRK1Fm?=
 =?utf-8?B?eE5PUDhENit4OGNKZGRZT3Q1NitwZXZKRW9JUlJHcHN6bk5tRUREREZrZTJF?=
 =?utf-8?B?dW9xdTM4SnVBaUpvMVZpd2QrcVd2RUpGZFZSN2hBaDl0OE5qNHliVVRDYUlr?=
 =?utf-8?B?aEVhQmgzRnU0TnVQa0hraFpDTTRIQWxlZEd2eEM5UlZVYWdEcE45UjZZbW5G?=
 =?utf-8?B?aGJDSng0V003THFDNFc5VEYxN1FZcGRDNDBUNkhvdHk0MVoybHRnemZFQ3B1?=
 =?utf-8?B?WmtFRVZ0citDK3U4ZUQ5MUNYU2pMS1NoWFB4RXBuUVZPNExQMUJsNnZ1OUJF?=
 =?utf-8?B?cUY3ZjlIVGgxMS90Zm5HQVpWaUxGbUhHTmo4aWg2eWVYRit1VVRIQlVtK0p6?=
 =?utf-8?B?TjVwQ1EwNW5Tb09KeUtRR1JTUWdvWlEvcXRISUN4NUEyMi9QSmREK0w5Y2Mr?=
 =?utf-8?B?a0UxZWJtci9DQ1RRY0hKRUUvSG5RWmVZVmVGZlZIQUxBSWs0c3dENFB2eWVI?=
 =?utf-8?B?cFJEZ3ZmNk9xNWliL1hCVTlqOThYUWJCemZvSVBjTDRYSk9jd0xRbTlHSjg5?=
 =?utf-8?B?NTQxK0lJNEROaTUxdlBDeTduektGRWtzQ3NYMlkyVjhjNUlxSjQwajBiMmhB?=
 =?utf-8?B?WWJhN0tUWWZpNmk4VEZ5T3dmbTJzUXFjZDk4SmlHcEdKZEwxSVErK3hkemtG?=
 =?utf-8?B?NTRVN3lZSndMdERPWng2YXFtU3ZHNW5RbUExMHEveTEvTjJrRHExMnM2Zm9i?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1198E0B12330843ACFD43FF31D7849C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925ab25c-dc18-4f70-30a9-08dd65d0a120
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:54:48.6795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eq+RiUHqBM8P9x39ZOhgnpI0s8mxBEAm/faJped0V/cXXdZy2N0OXUGunj6aXA0PBC2brFuwA9VR1bSbpkUHY3LczDNcp5FyR+pptXqCwDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAzLTE0IGF0IDA5OjQ0ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjUtMDMtMTMgYXQgMjM6MTcgKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3Rl
Og0KPiA+IE9uIFRodSwgMjAyNS0wMy0xMyBhdCAwMDozNCArMTMwMCwgS2FpIEh1YW5nIHdyb3Rl
Og0KPiA+ID4gRm9yIGJvdGggU01FIGFuZCBURFgsIGRpcnR5IGNhY2hlbGluZXMgd2l0aCBhbmQg
d2l0aG91dCB0aGUgZW5jcnlwdGlvbg0KPiA+ID4gYml0KHMpIG9mIHRoZSBzYW1lIHBoeXNpY2Fs
IG1lbW9yeSBhZGRyZXNzIGNhbiBjb2V4aXN0IGFuZCB0aGUgQ1BVIGNhbg0KPiA+ID4gZmx1c2gg
dGhlbSBiYWNrIHRvIG1lbW9yeSBpbiByYW5kb20gb3JkZXIuDQo+ID4gPiANCj4gPiANCj4gPiBB
IGxvdCBnb2luZyBvbiBpbiB0aGlzIHNlbnRlbmNlLCBob3cgYWJvdXQgc2ltcGxpZnlpbmcgaXQ6
DQo+ID4gDQo+ID4gRm9yIFNNRSBhbmQgVERYLCBtdWx0aXBsZSBkaXJ0eSBjYWNoZWxpbmVzIGZv
ciB0aGUgc2FtZSBtZW1vcnkgY2FuIGNvLWV4aXN0LCBhbmQNCj4gPiB0aGUgQ1BVIGNhbiBmbHVz
aCB0aGVtIGJhY2sgdG8gbWVtb3J5IGluIGEgcmFuZG9tIG9yZGVyLg0KPiANCj4gIm11bHRpcGxl
IiBpc24ndCBhY2N1cmF0ZSBhdCBsZWFzdCBmb3IgU01FLiAgSG93IGFib3V0Og0KPiANCj4gIEZv
ciBTTUUgYW5kIFREWCwgZGlydHkgY2FjaGVsaW5lcyB3aXRoIGFuZCB3aXRob3V0IGVuY3J5cHRp
b24gYml0KHMpIG9mwqANCj4gIHRoZSBzYW1lIG1lbW9yeSBjYW4gY29leGlzdCwgYW5kIHRoZSBD
UFUgY2FuIGZsdXNoIHRoZW0gYmFjayB0byBtZW1vcnnCoA0KPiAgaW7CoHJhbmRvbSBvcmRlci4N
Cg0KT2suDQoNCj4gDQo+ID4gDQo+ID4gDQo+ID4gPiAgIER1cmluZyBrZXhlYywgdGhlIGNhY2hl
cw0KPiA+ID4gbXVzdCBiZSBmbHVzaGVkIGJlZm9yZSBqdW1waW5nIHRvIHRoZSBuZXcga2VybmVs
IHRvIGF2b2lkIHNpbGVudCBtZW1vcnkNCj4gPiA+IGNvcnJ1cHRpb24gdG8gdGhlIG5ldyBrZXJu
ZWwuDQo+ID4gDQo+ID4gRHVyaW5nIGtleGVjLCB0aGUgY2FjaGVzIG11c3QgYmUgZmx1c2hlZCBi
ZWZvcmUganVtcGluZyB0byB0aGUgbmV3IGtlcm5lbCB0bw0KPiA+IGF2b2lkIHNpbGVudCBtZW1v
cnkgY29ycnVwdGlvbiB3aGVuIGEgY2FjaGVsaW5lIHdpdGggYSBkaWZmZXJlbnQgZW5jcnlwdGlv
bg0KPiA+IHByb3BlcnR5IGlzIHdyaXR0ZW4gYmFjayBvdmVyIHdoYXRldmVyIGVuY3J5cHRpb24g
cHJvcGVydGllcyB0aGUgbmV3IGtlcm5lbCBpcw0KPiA+IHVzaW5nLg0KPiA+IA0KPiA+IC4uLml0
IGRpc3RyaWJ1dGVzIHNvbWUgb2YgdGhlIGRldGFpbHMgZnJvbSB0aGUgZmlyc3Qgc2VudGVuY2Ug
aW50byB0aGUgc2Vjb25kLg0KPiA+IEVhc2llciB0byByZWFkIG9yIG5vPyBJJ20gbm90IHN1cmUu
DQo+IA0KPiBJIGRvbid0IGhhdmUgb3Bpbmlvbi4gIEkgc2VlIG5vIGRpZmZlcmVuY2UuDQo+IA0K
PiBJIHRlbmRzIHRvIGtlZXAgdGhlIG9yaWdpbmFsIHdvcmRzIHNpbmNlIHBlb3BsZSBoYXZlIHJl
dmlld2VkLg0KPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhlIFdCSU5WRCBpbiBzdG9wX3RoaXNf
Y3B1KCkgZmx1c2hlcyBjYWNoZXMgZm9yIGFsbCByZW1vdGUgQ1BVcyB3aGVuDQo+ID4gPiB0aGV5
IGFyZSBiZWluZyBzdG9wcGVkLiAgRm9yIFNNRSwgdGhlIFdCSU5WRCBpbiByZWxvY2F0ZV9rZXJu
ZWwoKQ0KPiA+ID4gZmx1c2hlcyB0aGUgY2FjaGUgZm9yIHRoZSBsYXN0IHJ1bm5pbmcgQ1BVICh3
aGljaCBpcyBkb2luZyBrZXhlYykuDQo+ID4gPiANCj4gPiA+IFNpbWlsYXJseSwgdG8gc3VwcG9y
dCBrZXhlYyBmb3IgVERYIGhvc3QsIGFmdGVyIHN0b3BwaW5nIGFsbCByZW1vdGUgQ1BVcw0KPiA+
ID4gd2l0aCBjYWNoZSBmbHVzaGVkLCB0aGUga2VybmVsIG5lZWRzIHRvIGZsdXNoIGNhY2hlIGZv
ciB0aGUgbGFzdCBydW5uaW5nDQo+ID4gPiBDUFUuDQo+ID4gDQo+ID4gDQo+ID4gSSBtZW50aW9u
ZWQgdGhpcyBpbiBhIHByZXZpb3VzIHZlcnNpb24uIEkgdGhpbmsgeW91IG5lZWQgdG8gZ2l2ZSBz
b21lIGhpbnQgdG8NCj4gPiB3aGVyZSB5b3UgYXJlIGdvaW5nIGJlZm9yZSB5b3Ugc3RhcnQgbGlz
dGluZyBmYWN0cy4gTGlrZToNCj4gPiANCj4gPiBEdXJpbmcga2V4ZWMsIFdCSU5WRCBuZWVkcyB0
byBiZSBleGVjdXRlZCBvbiBlYWNoIENQVSBmb3IgVERYIGFuZCBTTUUuwqANCj4gPiANCj4gPiBP
biB0aGUNCj4gPiByZW1vdGUgQ1BVcyB0aGlzIGlzIGNvdmVyZWQgaW4gc3RvcF90aGlzX2NwdSgp
IGZvciBib3RoIFREWCBhbmQgU01FLiBGb3IgdGhlDQo+ID4ga2V4ZWNpbmcgQ1BVLCBTTUUgaGFu
ZGxlcyB0aGlzIGluIHJlbG9jYXRlX2tlcm5lbCgpLiBUaGlzIGxlYXZlcyB0aGUgVERYIGNhc2UN
Cj4gPiBmb3IgdGhlIGtleGVjLWluZyBDUFUgc3RpbGwgdG8gaW1wbGVtZW50Lg0KPiA+IA0KPiA+
IC4uLml0IGZpcnN0IHNheXMgdGhlIG92ZXJhbGwgcHJvYmxlbSB0byBzb2x2ZSwgdGhlbiBleHBs
YWlucyB3aGF0IGlzIG1pc3NpbmcgaW4NCj4gPiB0aGUgY3VycmVudCBjb2RlIHRvIHNvbHZlIGl0
LiBUaGUgcmVhZGVyIGlzIGFscmVhZHkgdGhpbmtpbmcgb2Ygd2hhdCB0aGUNCj4gPiBzb2x1dGlv
bnMgc2hvdWxkIGJlIGFuZC4uLg0KPiANCj4gV2lsbCBkby4NCj4gDQo+ID4gDQo+ID4gPiANCj4g
PiA+IFVzZSB0aGUgZXhpc3RpbmcgV0JJTlZEIGluIHJlbG9jYXRlX2tlcm5lbCgpIHRvIGNvdmVy
IFREWCBob3N0IGFzIHdlbGwuDQo+ID4gDQo+ID4gLi4udGhleSByZWFkIHRoZSBzb2x1dGlvbiBq
dXN0IGFzIHRoZXkgYXJlIHdvbmRlcmluZyBhYm91dCBpdC4gVGhlIHJlYWRlciBjYW4NCj4gPiBm
ZWVsIGxpa2UgdGhlIGNoYW5nZSBpcyBhbGlnbmVkIHdpdGggdGhlaXIgdGhpbmtpbmcuDQo+ID4g
DQo+ID4gPiANCj4gPiA+IEp1c3QgZG8gdW5jb25kaXRpb25hbA0KPiA+ID4gDQo+ID4gDQo+ID4g
IlVuY29uZGl0aW9uYWwiLiBOb3cgSSdtIHN0YXJ0aW5nIHRvIHRoaW5rIGFib3V0IGhvdyB1bmNv
bmRpdGlvbmFsIHdiaW52ZCB3aWxsDQo+ID4gYmUuDQo+ID4gDQo+ID4gPiAgV0JJTlZEIHRvIGNv
dmVyIGJvdGggU01FIGFuZCBURFggaW5zdGVhZCBvZg0KPiA+ID4gc3ByaW5rbGluZyBhZGRpdGlv
bmFsIHZlbmRvci1zcGVjaWZpYyBjaGVja3MuICBLZXhlYyBpcyBhIHNsb3cgcGF0aCwgYW5kDQo+
ID4gPiB0aGUgYWRkaXRpb25hbCBXQklOVkQgaXMgYWNjZXB0YWJsZSBmb3IgdGhlIHNha2Ugb2Yg
c2ltcGxpY2l0eSBhbmQNCj4gPiA+IG1haW50YWluYWJpbGl0eS4NCj4gPiA+IA0KPiA+ID4gQnV0
IG9ubHkgZG8gV0JJTlZEIGZvciBiYXJlLW1ldGFsDQo+ID4gPiANCj4gPiANCj4gPiBCdXQgd2Fp
dCwgbm93IEknbSBsZWFybmluZyBpdCdzIG5vdCB1bmNvbmRpdGlvbmFsLiBJIG5lZWQgdG8gcmUt
dGhpbmsgd2hhdCBJDQo+ID4ganVzdCBldmFsdWF0ZWQuIEFuZCBJJ20gZG91YnRpbmcgdGhlIGVh
cmxpZXIgc3RhdGVtZW50cyBiZWNhdXNlIEkganVzdCBnb3QNCj4gPiBzdXJwcmlzZWQuDQo+IA0K
PiBEbyB5b3UgbWVhbiB5b3UgZ290IHN1cnByaXNlZCBieSBzYXlpbmcgInVuY29uZGl0aW9uYWwi
IGZpcnN0IGFuZCB0aGVuIHNheWluZw0KPiAiZm9yIGJhcmUtbWV0YWwiPyAgVGhpcyBpcyBsaXRl
cmFsbHkgd2hhdCB0aGUgcGF0Y2ggdGl0bGUgc2F5cy4gIEkgZG9uJ3Qgc2VlIGFueQ0KPiBwcm9i
bGVtLCBidXQgSSBjYW4gbWVudGlvbmVkIHRoZSAiZm9yIGJhcmUtbWV0YWwiIHBhcnQgd2hlbiBJ
IHNheQ0KPiAidW5jb25kaXRpb25hbCIgYWJvdmUuDQoNCkkgZG9uJ3Qga25vdyBob3cgdG8gZXhw
bGFpbiBpdCBtb3JlLiBVbmNvbmRpdGlvbmFsIG1lYW5zLCB3ZWxsLCB1bmNvbmRpdGlvbmFsLg0K
Ik9ubHkgZG8uLi4iIGlzIGEgY29uZGl0aW9uLiBJdCdzIG5vdCB1bmNvbmRpdGlvbmFsLg0KDQpT
byBkb24ndCBzYXkgaXQgaXMgb3IgaXQgd2lsbCBiZSBjb25mdXNpbmcuDQoNCj4gDQo+ID4gDQo+
ID4gPiAgYmVjYXVzZSBURFggZ3Vlc3RzIGFuZCBTRVYtRVMvU0VWLVNOUA0KPiA+ID4gZ3Vlc3Rz
IHdpbGwgZ2V0IHVuZXhwZWN0ZWQgKGFuZCB5ZXQgdW5uZWNlc3NhcnkpIGV4Y2VwdGlvbiAoI1ZF
IG9yICNWQykNCj4gPiA+IHdoaWNoIHRoZSBrZXJuZWwgaXMgdW5hYmxlIHRvIGhhbmRsZSBhdCB0
aGUgdGltZSBvZiByZWxvY2F0ZV9rZXJuZWwoKQ0KPiA+ID4gc2luY2UgdGhlIGtlcm5lbCBoYXMg
dG9ybiBkb3duIHRoZSBJRFQuDQo+ID4gPiANCj4gPiA+IFJlbW92ZSB0aGUgaG9zdF9tZW1fZW5j
X2FjdGl2ZSBsb2NhbCB2YXJpYWJsZSBhbmQgZGlyZWN0bHkgdXNlDQo+ID4gPiAhY3B1X2ZlYXR1
cmVfZW5hYmxlZChYODZfRkVBVFVSRV9IWVBFUlZJU09SKSBhcyBhbiBhcmd1bWVudCBvZiBjYWxs
aW5nDQo+ID4gPiByZWxvY2F0ZV9rZXJuZWwoKS4NCj4gPiA+IA0KPiA+IA0KPiA+IFN0YXJ0IHdp
dGggdGhlIHByb2JsZW0gaGVyZS4gSXQganVzdCBkZXNjcmliZXMgYW5vdGhlciBjaGFuZ2UgYW5k
IEknbSBub3Qgc3VyZQ0KPiA+IHdoeSB3aGVuIEkgc3RhcnQgcmVhZGluZyBpdC4NCj4gPiANCj4g
PiBCeSBwcm9ibGVtIEkgbWVhbiB0aGF0IGhvc3RfbWVtX2VuY19hY3RpdmUgZG9lc24ndCBmaXQg
dGhlIGNvbmRpdGlvbmFsIGFueW1vcmUsDQo+ID4gc28gaXQgbmVlZHMgdG8gYmUgY2hhbmdlZC4N
Cj4gPiANCj4gPiA+ICAgY3B1X2ZlYXR1cmVfZW5hYmxlZCgpIGlzIGFsd2F5cyBpbmxpbmUgYnV0
IG5vdCBhDQo+ID4gDQo+ID4gSSB3YXMganVzdCBub3RpY2luZyB0aGlzIG9uIHRoZSBvdGhlciBw
YXRjaC4gQWN0dWFsbHkgaXQgY291bGQgY2FsbCBpbnRvIHNvbWUNCj4gPiBrYXNhbiBzdHVmZi4N
Cj4gDQo+IENhbiB5b3UgYmUgbW9yZSBzcGVjaWZpYyBzaW5jZSBJIGFtIG5vdCBzZWVpbmcgaXQu
DQoNCllvdSBhcmUgcmlnaHQsIEkgZG9uJ3Qga25vdyB3aGF0IEkgd2FzIGxvb2tpbmcgYXQuDQoN
Cj4gDQo+ID4gDQo+ID4gPiBmdW5jdGlvbiBjYWxsLCB0aHVzIGl0IGlzIHNhZmUgdG8gdXNlIGFm
dGVyIGxvYWRfc2VnbWVudHMoKSB3aGVuIGNhbGwNCj4gPiA+IGRlcHRoIHRyYWNraW5nIGlzIGVu
YWJsZWQuDQo+ID4gDQo+ID4gVGhpcyBmdW5jdGlvbiBjYWxsIHRyYWNraW5nIHN0dWZmIGlzIGEg
d2lsZCBjYXJkIGF0IHRoZSBlbmQuIFdoYXQgYWJvdXQNCj4gPiBkZXNjcmliaW5nIHRoZSBydWxl
cyB0aGlzIGZ1bmN0aW9uIG5lZWRzIHRvIGZvbGxvdyBkdWUgdG8gY2FsbCBkZXB0aCB0cmFja2lu
ZywNCj4gPiBhbmQgZXhwbGFpbiB3aHkgdGhlIGNoYW5nZSBkb2VzIHRoYXQuDQo+IA0KPiBCZWxv
dyBpcyB3aGF0IEkgaGFkIGJlZm9yZS4gIERvIHlvdSB0aGluayBpdCdzIGJldHRlcj8gIEkgcmVw
bGFjZWQgdGhlbSB3aXRoIHRoZQ0KPiBjdXJyZW50IG9uZSBzaW5jZSBSZWluZXR0ZSBjb21tZW50
ZWQgdGhlIG9yaWdpbmFsIG9uZSAod2hpY2ggY29udGFpbnMgaGlzdG9yeQ0KPiBldGMpIHdhcyBu
b3QgbmVjZXNzYXJ5Lg0KPiANCj4gIg0KPiBDb21taXQgOTNjMTgwMGIzNzk5ICgieDg2L2tleGVj
OiBGaXggYnVnIHdpdGggY2FsbCBkZXB0aCB0cmFja2luZyIpDQo+IG1vdmVkIGNhbGxpbmcgJ2Nj
X3BsYXRmb3JtX2hhcyhDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQpJyBhcyBhbiBhcmd1bWVudA0K
PiBvZiByZWxvY2F0ZV9rZXJuZWwoKSB0byBhbiBlYXJsaWVyIHBsYWNlIGJlZm9yZSBsb2FkX3Nl
Z21lbnRzKCkgYnkNCj4gYWRkaW5nIGEgdmFyaWFibGUgJ2hvc3RfbWVtX2VuY19hY3RpdmUnLiAg
VGhlIHJlYXNvbiB3YXMgdGhlIGNhbGwgdG8NCj4gY2NfcGxhdGZvcm1faGFzKCkgYWZ0ZXIgbG9h
ZF9zZWdtZW50cygpIGNhdXNlZCBhIGZhdWx0IGFuZCBzeXN0ZW0gY3Jhc2gNCj4gd2hlbiBjYWxs
IGRlcHRoIHRyYWNraW5nIGlzIGFjdGl2ZSBiZWNhdXNlIGxvYWRfc2VnbWVudHMoKSByZXNldHMg
R1MgdG8NCj4gMCBidXQgY2FsbCBkZXB0aCB0cmFja2luZyB1c2VzIHBlci1DUFUgdmFyaWFibGUg
dG8gb3BlcmF0ZS4NCg0KVGhhdCBkb2VzIGZlZWwgbGlrZSBhIGxvdCBvZiBkZXRhaWxzLiBCdXQg
SSB0aGluayBpdCBzdGlsbCBuZWVkcyBtb3JlIGluZm8gdGhhdA0KaW4gdGhlIGN1cnJlbnQgdmVy
c2lvbi4gQWdhaW4sIGp1c3QgZGVzY3JpYmUgdGhlIHNwZWNpYWwgcmVxdWlyZW1lbnRzIGFuZCB3
aHkuDQpZb3UgZG9uJ3QgbmVlZCB0byBza2lwIHRoZSBsaW5rcywgYnV0IGp1c3QganVtcGluZyBy
aWdodCBpbnRvIHRoZSBoaXN0b3J5IHRha2VzDQptb3JlIHdvcmsgdG8gdW5kZXJzdGFuZCB3aGF0
IGlzIG5lZWRlZC4NCg0KPiANCj4gVXNlICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJF
X0hZUEVSVklTT1IpIHRvIGNoZWNrIHdoZXRoZXIgdGhlDQo+IGtlcm5lbCBydW5zIG9uIGJhcmUt
bWV0YWwuICBjcHVfZmVhdHVyZV9lbmFibGVkKCkgaXMgYWx3YXlzIGlubGluZSBidXQNCj4gbm90
IGEgZnVuY3Rpb24gY2FsbCwgdGh1cyBpdCBpcyBzYWZlIHRvIHVzZSBpdCBhZnRlciBsb2FkX3Nl
Z21lbnRzKCkNCj4gd2hlbiBjYWxsIGRlcHRoIHRyYWNraW5nIGlzIGVuYWJsZWQuICBSZW1vdmUg
dGhlICdob3N0X21lbV9lbmNfYWN0aXZlJw0KPiB2YXJpYWJsZSBhbmQgdXNlIGNwdV9mZWF0dXJl
X2VuYWJsZWQoKSBkaXJlY3RseSBhcyB0aGUgYXJndW1lbnQgd2hlbg0KPiBjYWxsaW5nIHJlbG9j
YXRlX2tlcm5lbCgpLg0KPiAiDQoNCg0KDQo+IA0KPiANCj4gWy4uLl0NCj4gDQo+ID4gPiAtLS0g
YS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+ID4gPiArKysgYi9hcmNoL3g4
Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+ID4gPiBAQCAtMzQ2LDE2ICszNDYsOSBAQCB2
b2lkIF9fbm9jZmkgbWFjaGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkNCj4gPiA+ICB7
DQo+ID4gPiAgCXVuc2lnbmVkIGxvbmcgcmVsb2Nfc3RhcnQgPSAodW5zaWduZWQgbG9uZylfX3Jl
bG9jYXRlX2tlcm5lbF9zdGFydDsNCj4gPiA+ICAJcmVsb2NhdGVfa2VybmVsX2ZuICpyZWxvY2F0
ZV9rZXJuZWxfcHRyOw0KPiA+ID4gLQl1bnNpZ25lZCBpbnQgaG9zdF9tZW1fZW5jX2FjdGl2ZTsN
Cj4gPiA+ICAJaW50IHNhdmVfZnRyYWNlX2VuYWJsZWQ7DQo+ID4gPiAgCXZvaWQgKmNvbnRyb2xf
cGFnZTsNCj4gPiA+ICANCj4gPiA+IC0JLyoNCj4gPiA+IC0JICogVGhpcyBtdXN0IGJlIGRvbmUg
YmVmb3JlIGxvYWRfc2VnbWVudHMoKSBzaW5jZSBpZiBjYWxsIGRlcHRoIHRyYWNraW5nDQo+ID4g
PiAtCSAqIGlzIHVzZWQgdGhlbiBHUyBtdXN0IGJlIHZhbGlkIHRvIG1ha2UgYW55IGZ1bmN0aW9u
IGNhbGxzLg0KPiA+ID4gLQkgKi8NCj4gPiA+IC0JaG9zdF9tZW1fZW5jX2FjdGl2ZSA9IGNjX3Bs
YXRmb3JtX2hhcyhDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZUFQpOw0KPiA+ID4gLQ0KPiA+ID4gICNp
ZmRlZiBDT05GSUdfS0VYRUNfSlVNUA0KPiA+ID4gIAlpZiAoaW1hZ2UtPnByZXNlcnZlX2NvbnRl
eHQpDQo+ID4gPiAgCQlzYXZlX3Byb2Nlc3Nvcl9zdGF0ZSgpOw0KPiA+ID4gQEAgLTM5OCw2ICsz
OTEsMTEgQEAgdm9pZCBfX25vY2ZpIG1hY2hpbmVfa2V4ZWMoc3RydWN0IGtpbWFnZSAqaW1hZ2Up
DQo+ID4gPiAgCSAqDQo+ID4gPiAgCSAqIEkgdGFrZSBhZHZhbnRhZ2Ugb2YgdGhpcyBoZXJlIGJ5
IGZvcmNlIGxvYWRpbmcgdGhlDQo+ID4gPiAgCSAqIHNlZ21lbnRzLCBiZWZvcmUgSSB6YXAgdGhl
IGdkdCB3aXRoIGFuIGludmFsaWQgdmFsdWUuDQo+ID4gPiArCSAqDQo+ID4gPiArCSAqIGxvYWRf
c2VnbWVudHMoKSByZXNldHMgR1MgdG8gMC4gIERvbid0IG1ha2UgYW55IGZ1bmN0aW9uIGNhbGwN
Cj4gPiA+ICsJICogYWZ0ZXIgaGVyZSBzaW5jZSBjYWxsIGRlcHRoIHRyYWNraW5nIHVzZXMgcGVy
LUNQVSB2YXJpYWJsZXMgdG8NCj4gPiA+ICsJICogb3BlcmF0ZSAocmVsb2NhdGVfa2VybmVsKCkg
aXMgZXhwbGljaXRseSBpZ25vcmVkIGJ5IGNhbGwgZGVwdGgNCj4gPiA+ICsJICogdHJhY2tpbmcp
Lg0KPiA+IA0KPiA+IEkgdGhpbmsgSSBzdWdnZXN0ZWQgeW91IHNob3VsZCBjYWxsIG91dCB0aGUg
b3Bwb3J0dW5pc3RpYyBjaGFuZ2UgaGVyZSBpbiB0aGUNCj4gPiBsb2cuIERpZCB5b3UgZGlzYWdy
ZWU/DQo+IA0KPiBJIHJlcGxpZWQgdGhpcyB3YXMgc3VnZ2VzdGVkIGJ5IERhdmlkIEthcGxhbiwg
YnV0IEkgZ3Vlc3MgSSBmb3Jnb3QgdG8gcmVwbHkgdGhlDQo+ICJvcHBvcnR1bmlzdGljIiBwYXJ0
Lg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIG9wcG9ydHVuaXN0aWMgY2hhbmdlLiAgSXQn
cyBhIHZhbGlkIGNvbW1lbnQgYWZ0ZXIgdGhlIA0KPiAnaG9zdF9tZW1fZW5jX2FjdGl2ZScgdmFy
aWFibGUgYW5kIHRoZSBjb21tZW50IGFyb3VuZCBpdCB3ZXJlIHJlbW92ZWQuDQoNCkl0J3MgdmFs
aWQgYmVmb3JlIHRvby4gU28gaXQncyBhIHNlcGFyYXRlIGNoYW5nZS4gSSB0aGluayBiYXNlZCBv
biB0aGUgcmVjZW50DQpoaXN0b3J5IHdlIHNob3VsZCBiZSBleHRyYSBjYXJlZnVsIGFib3V0IHNs
aXBwaW5nIGV4dHJhIGNoYW5nZXMgaW50byB0aGUgc2VyaWVzLg0KSSdtIG5vdCBhZ2FpbnN0IGRv
aW5nIHRoZSBjaGFuZ2UgaW4gdGhpcyBwYXRjaCwganVzdCB3YW50IHRvIG1ha2Ugc3VyZSBpdCdz
IG5vdA0KcGVyY2VpdmVkIGFzIGJlaW5nIHNsaXBwZWQgaW4uDQoNCj4gDQo+IA0KPiANCg0K

