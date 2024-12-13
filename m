Return-Path: <linux-kernel+bounces-444670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D99E9F0AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0E1883095
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E91C3C10;
	Fri, 13 Dec 2024 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5ng2w/R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8B44C6C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088697; cv=fail; b=Yzuj8NINPWKjvHjljNXVxNb/GF1vOBUS4pFzFx24WZmJyEA/1TJ/iFbY3SYiXRso0teWSyK6KfK0io8JEUxUKuDxCMCu19LA7QLylKg0XzBFUbizmQdmQjIKMomCPJ133tZXX0OW3YoKTNZfrQPm5Zd9eGpmwv+5KtysXPsIons=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088697; c=relaxed/simple;
	bh=M2KmnSi7eJoyBKjfhxDwBWF/2U9rseAonRicsjMcA9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bzY/H6rm7aFEmitAbeBX9qxYhplNCmKPUlySANlhr1K1VI+7U6PPmgV2OkCShIf/gcMLaMVWMNGj2vtVwBQXzB6J9MucBirn6G5BHbc177u0sLZKNQZQ4L2WZR8+moanPKl/uvW3TuJEsaCMYZVY7LuonaRJP5lSPPtoZXVNGec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5ng2w/R; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734088696; x=1765624696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=M2KmnSi7eJoyBKjfhxDwBWF/2U9rseAonRicsjMcA9I=;
  b=Y5ng2w/RxGfzphJ/Za2yOk/GQYQl6vI73az7hAcsoat6Oq7+YdCGjafU
   DRqieeNNH6BEYEs+etCb24L0XgfdhiXd1fgTOWtIaeGX8PFVCzYnD6nC0
   AIzuQooud5NlagTNwjiY0nVJdIu89Et84DXkeVHed876p4YNyFGnyVlOv
   9Q45pm00XDCQu5D3E4K+Sf01xaZiQsZuO8BULYR9hSu1k7wOwWSL6RgwL
   qfNLzmr0y4l0TLLgMs2ssChFhXkGhRqrZOKuxqogesEVNuQ242PY+kxG9
   LenRKE6wGm505+7WO2/+yNOwiaXSxX+pLo7b3NL1EjSf2DO5Hhb0moUHb
   Q==;
X-CSE-ConnectionGUID: AN9zsv0uSlqnaJCtRE+byQ==
X-CSE-MsgGUID: OT5MCmd3T7S06MufB/WQiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45011705"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="py'?scan'208";a="45011705"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 03:18:10 -0800
X-CSE-ConnectionGUID: pz0Ai4eMRTG2NTypxu/fBw==
X-CSE-MsgGUID: 9zJhVkruSeK/weNMvaCSkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="py'?scan'208";a="101523821"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 03:18:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 03:18:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 03:18:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 03:18:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFLnGvVI0Btrfbk+VPbwGkPwvrdhKMpzpGZZ4gf7wGR0IBZmrv/GY2NnHjeN9/VXdHD80tVNq4Uu+00NX69wKfLv22cW2UGgvGlrABVa/3BklB5iDohUs7a4Q/4Kitv6o5F5UOH88Fvgccgej4FL6/rBiwvLAUdYeSBIODCHQ2gm6Lur47WqqaSsaFc8B/Ydf7kCZDY8TchxMO7Qz5nJmnv4Qyukf/QRF76Zkf7FBuGxl/rZ3olU5Gt5IIitth1WY+Y+6Nn1o8KG2mnekaSqlRG7H1HXMnApdEZdlBIMk/M5khN9ufIivaCbNK7q4IO0pddW3aF4aoDB0s/rLzCQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZHwP0LQZBIWIHncCeIx+AOjDE1U1rWU5G1aMQinzHA=;
 b=TX7514cjo9j2K/E65pe9djzNhhfmX1eRqI0VuDyLwRzLq2XNRXAijFmzxSRrJ9EpNb8f6aBiYBUIgbWzgZM3OCVegtoVS1fYhlMMo7TzX3zGaLJs9vzSQnhLDf74VhlnQO/Rwj/c6IOZfaFbojaqJjODZB18yJZ8USLRTaV9VHxi5h1ApyewJ3HvzSKXlRvfS/8vAOyLGJwIf1cVP+gGQ4fC989vApXmVbCKJjY1lH8qZY5LNWHKPhem/Rb+v2JbOURQEi6exn7wST3vo/OX744YQbITPcx/m9PLuBPsElTFq4CV537rNZESUYzvCKZ9+/+v+ddkoC9le8QjImVONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Fri, 13 Dec
 2024 11:17:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 11:17:45 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v8 3/9] x86/virt/tdx: Use auto-generated code to read
 global metadata
Thread-Topic: [PATCH v8 3/9] x86/virt/tdx: Use auto-generated code to read
 global metadata
Thread-Index: AQHbNcNALWS+z6yLUE6LyTjPGIp3xrLkNbiA
Date: Fri, 13 Dec 2024 11:17:45 +0000
Message-ID: <762a50133300710771337398284567b299a86f67.camel@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
	 <daace74503d012cadd2e0b9c06ea39f60e0c2ad5.1731498635.git.kai.huang@intel.com>
In-Reply-To: <daace74503d012cadd2e0b9c06ea39f60e0c2ad5.1731498635.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB6574:EE_
x-ms-office365-filtering-correlation-id: af04db53-6985-4d53-fcc2-08dd1b67c502
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?ZWZmM1hvcnBaMjZkMWpySk95RkVFb0doQkZSSWUyV2RGczFYejNVK2tGZXQv?=
 =?utf-8?B?bk9KR2RETFVEWkZHNC9oenA5NjN3UU9OeDFqYXJ1TVhvT2ZpMDd0MVVEREVS?=
 =?utf-8?B?NHFLZ2lLNnBuL1lueTdKRnJneEVMZDJtT3FiR2dIZUhZc3IxaWx4YmdLNHZW?=
 =?utf-8?B?eTQwWTVlMC9MYTMwRUpGMXBkaW9STXk5MzhPbFJ6SERvZVlaYWZ0ZTJ2c0Fj?=
 =?utf-8?B?U0hUSFNDellscEQ3eVZqS0c4cHZ4ZUJMUmxrdHI3NHpRMm9zYWU1MFhrcFor?=
 =?utf-8?B?Ymk3UVlIRXQ0MFRRQlZRbnRmVHc0Sm5lcEdRZHhOaTgvV3FORnE4QXV4QUpK?=
 =?utf-8?B?RndpLzJwZjQ5ZVNGaGxqYzZEQmNDbkFxQThmbVhocmlPOCtjbk9jelo4dGd3?=
 =?utf-8?B?YkNYVTVvSi9EdVVpOFMyK3RGVXc4RFVrOFpUWm9tZWd3MWpuSUgvcjRxT2kr?=
 =?utf-8?B?UEwzUzJ4QnFhT1A3Mlgza2pDd0lYVkFwRVdlZjdKUlNldUFFKzYxbm9xdlpk?=
 =?utf-8?B?OFFtbTV1Z0d0NjlOMGlyTXEyNXQ1UnV1RmJLb3R1eTNWNlY0eFJmaDIrd3p6?=
 =?utf-8?B?NmgxOGlxU3lNeGdleG4zM1gvNXQ5ZW0xMzZ6T1FZVkNmUFI5bk14dU56MlJQ?=
 =?utf-8?B?Ri9Tdk13aytzYldhRXdXQllCWnluNm1raW15MVNYOUdrcXRheHF2UTMyL05P?=
 =?utf-8?B?WHFxdk5uYit3dXVtOTIzdGlidWh5Q2F2Y0U4NFhaTGM5c00wUEt0eDE4eFBZ?=
 =?utf-8?B?disxUUJtdHhGbGxuc2Y5aGZZN2RLSlFaWTlLTVF4b2U3QmV2TjZ1YU1Lbmtr?=
 =?utf-8?B?a1pEZEY4QlRwZUF5WjBKU3hHUUtCcmliYXY2WngzSWN2c0I5YWNMZ1ZSWUVq?=
 =?utf-8?B?ZWVTRTBRNjFmR2dlOUdvQWhOWUhWTTVzSno5OG5Ob25mMWtiSUNHRE1mSlpG?=
 =?utf-8?B?TkMvdW5WYkdiWHg3SWM4aDlLdzVBeXpIemtwdTJTc2xUVERMTTZ6US9GVWZ6?=
 =?utf-8?B?NFZHVktPVjdpOVc2ZmZiQUtXSmhMZHZBUVFNWm9oQXVtZkEwN1dJc1hVMXA3?=
 =?utf-8?B?V3ZVejQ4c3ZIMXFtN0FJQWVoWDF6Z05YVXdiNnVRbGh6ejFKRVdPazZCN21H?=
 =?utf-8?B?dVZFaGFWWk1tZ2syK2pVVHJrZ3psUXZrWTJ1TC9zU0IrdUJmL2kyTy9nQ0t5?=
 =?utf-8?B?WjBsbmFiWGFUZDVSQnhsbG81UDI4VjRPUXFWZVAwcTlXa0YxL3FsVVpIY05l?=
 =?utf-8?B?OVEyTy9pTHY3V0FVZ3EwMEVta3EvUzgxWXFQaG50QWdHVnE3M1hHNC9zQko5?=
 =?utf-8?B?NUN4ZHh6WW9DUk55VzBrM1JLZFE3T2puTUNJc2tzY3RybUtsTkM4QUJwY0J0?=
 =?utf-8?B?N0RsSUxyRlc1ZTVRb2dpTW42S01ja1d4c25ZRi8wM0sxYzdaMm92N1dOR0Q5?=
 =?utf-8?B?MDJ5Z2V4NzFpWmpkRUU5VGV5WTd0RmdLaUo4L0FFRzY0N0J0aTM1RDdkdlJn?=
 =?utf-8?B?VlorU2JHMm83RXJwUHVkN3BCQUNHSzkwWHRpTTd3aS9EZ3JjeTZtaElWbU5N?=
 =?utf-8?B?ZzNDd3Z0TVA5eGJrSUd2TFgyVXpBNW93N2VwNlpJZmxNcU90SGRKSHdaR1E4?=
 =?utf-8?B?SllTdHJQeWQvcklJbGl3M05rTHh1UDQ2OUFWOXozL2RucmJKUDg0Q3VybXBT?=
 =?utf-8?B?enJIMU9QNHkxR0Ntd2ZXMnM3eGRSTnVVTWZkWlk5RlV4WTU4YlQxNWs0RTQz?=
 =?utf-8?B?ZzRDRnRlWWd2ZkZPenQ5OGxGWk1kZUlmVjkzSnBhNGZLVC9LK2VJR21pUk1I?=
 =?utf-8?B?U2xQMzNpb2xWeWppQU1Qc3RUdzhqWWVnS1lnUzRHRHN1NzQ5L3BhcElYMEVH?=
 =?utf-8?Q?1+G3NvUd6aOqz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG5qT21xcDhIMmZlelBVanpnbTgrR1lrNDV5eW9xM3licnU3Q3RZTHcxYk1S?=
 =?utf-8?B?Kzl2eDY1VkRuZjVSSDNSRkpHMVMwZEVWV09zUUU4UEt6KzkvUitrUzZQVnJU?=
 =?utf-8?B?R3FyMU9sa3BGeEF1RzFVT0FUSjNxNUtjQjQ4UUNFWEJ3dkpRYnNFNlh6emdS?=
 =?utf-8?B?UVdXb1dPMEkvWnR4QkViV2N0UmorTm9ORkZ5VVZ2MitFUnNJeVY1UWh5anJD?=
 =?utf-8?B?M0FUY1lDR2t6N2ZrL1krTm9XdFo0VGViVHFHRGdlK2JyMGNBYVVtR3RTeEtl?=
 =?utf-8?B?d25aaHNZVGlFSUdEM2htKzJXcjlqWUJQUGk1dUQ3VzhjblRwYU1WYy8zTm1P?=
 =?utf-8?B?WlRFL1hLSzZ3V3VFc1pIYWsyWUhiMXlNNmw2d09YVVZKS1dxTGQ2N2RRNk1r?=
 =?utf-8?B?TGR0M0JtRWpqMEk2U2ZLVEtkTlE5ZWtJVU12aFJDakZiUUsyQ2VzTXV6ZEpa?=
 =?utf-8?B?K0MzODRkeWMwNzhOUjhhTDBhYy91M2dMcTdUaG0vdGx6dWwrQnZlN3JSYVVX?=
 =?utf-8?B?N2VZOWk5YnB5VG5ndWo3REI3MnhFZzZMQU9jdkt4VldGait0cEliMC90blA4?=
 =?utf-8?B?VVpnNEtQdzNtSGpqeTFKYWpGVVhzQ0ZoeWs1V2pERTVXN2UyTGFqMGUrM21V?=
 =?utf-8?B?d1BOOHpBeU9LL1pmMDlwWHY1a1g1RXZVd2Ewa1NQbzJJazBBdi9kYnRONmhP?=
 =?utf-8?B?MjBEQitIRVpKdzAwclpWRGF2eU1LcmJuUzBIZ0hkR0ZFMDJlNEEvWGI4c3Jv?=
 =?utf-8?B?VldvVHAvNTJwNW5HVTZUQVBDQnpIRC94V042ZU5QbmdkY2JtVGRDdk12SDRH?=
 =?utf-8?B?TEthRGdZQk8vUlNPdE9VL25HdnNTK1Y1VEY0T005MkpHOXc5QXpoOEt3ZVVy?=
 =?utf-8?B?UnJ3R0NuM3VOd1BlYVQ2cm9lMlFrdmRmSnZPTWVBZCt0K1hZQ28xSEVJNmVy?=
 =?utf-8?B?V2dtRDE4emtnYkNOMEliOElUMFF1anllTlpXcFRrUy9XTGxYdFJUWDVlckFn?=
 =?utf-8?B?VVB3N1VYa3FJR1hnckVHblBHck0xdFVNN2tXdjhEOGZQWWl5U0xmQUlpdHdq?=
 =?utf-8?B?RkE0d3VxaVlmSFNrclB1VUZ0ZEtFcnlZcU1kUXhVQ0ZpcWdyTnNITUx5TkJK?=
 =?utf-8?B?TlZ1bTFaRVpRMmh1Q2RlVkxKSG5yS2oraC8zVUFZREU2T25qSzZtWW5xUSs4?=
 =?utf-8?B?aUZDd29XV29zQlowYjZDSzBBV24rNmcxRUZPTm9XdmRiaFoybEdwZkZzc2RQ?=
 =?utf-8?B?alRaWjRwM1QySmlCbXJWOFNGbU1TaS9jQzJDcGlRRHRMa0JoenBrNzhJTXla?=
 =?utf-8?B?bnNud1JIUXMyWDNhVENFU1R5SHU1VXphcDlpTXk4bUI4NlFWQmNQNFJZRzE1?=
 =?utf-8?B?QVg0QzIwaTRUWU9mcTlJNE1hTnFwQTZCZkY1bHpIQWl2cFpEN1plckdrUDBw?=
 =?utf-8?B?b1FMUk1OVklZZ2JFUGt4d0VSWHBieUVmTnhCaFN2K1J3ZFFReWxJYkJkblFO?=
 =?utf-8?B?QlZpdlJHNDFPV1R3czVGQ3V3UUx3NVA4THFjSDY2L25qUzNaZTltdi9iR1Yz?=
 =?utf-8?B?ZVdmVTVTbU1QampLamdMc0pnWTFHMCt3Sks5WmRTUFNsckRSZHloTUs5dVg2?=
 =?utf-8?B?bEk5RjA0WHNheXZpU0NRSWpvTDQrYXVBWTRmZUI3bndGOE5ReFNEWFRxbFlw?=
 =?utf-8?B?aWRQMm9tZUhYZVZ0c1MvSTRvREQwZ0NGbGVnWWQ3TnNoV0hNOTBZeXh2LzJM?=
 =?utf-8?B?K3pMTFNEOHI4MHlZT21wR1BLbDhQbDBWMFlwN0g1Q2FKUkRBcnI1S0xGdUxI?=
 =?utf-8?B?QkpvdFZ0bThaL3NvVzFxSk9uV2g5cjBpSWt1Mng3am1HQldPNlJoWU1hcEor?=
 =?utf-8?B?N0V5T2lpU1VpbFpTOG1CR0Z3aGY5NHFOT1FvU00xR1VDejRRNldKSWpBYVVS?=
 =?utf-8?B?a2Y1VDBvdXhUUUZkWFhscEc3U0ZKNEkxZGs1Y3F5TVYyM3IwTFI0bnlEN0kx?=
 =?utf-8?B?eDVrRUNQdW9JWDdlcWxmbnF4RWZsUkNIMG5SdlBTTWlscW8vd1ZXcWp3STI5?=
 =?utf-8?B?Z00yQmk4Rk44U2FsejREUy9sWXdvRFlWbnpaNHVMU2hZeVhRVXZaZ1c1NzVU?=
 =?utf-8?Q?VsG37Sid078VkehhzFE06ngo8?=
Content-Type: multipart/mixed;
	boundary="_002_762a50133300710771337398284567b299a86f67camelintelcom_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af04db53-6985-4d53-fcc2-08dd1b67c502
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 11:17:45.7329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwboER4eeBWAIxgYMTubYm7cMTFa15KhJtgLoVwIyBmUci3m8GyDvqw+wPcsl26kjChOJqI/Z55KNZ+fbJFNoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-OriginatorOrg: intel.com

--_002_762a50133300710771337398284567b299a86f67camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C0168D82FC6584AA4F7178E494414A9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI0LTExLTE0IGF0IDAwOjU3ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IFRo
ZSB0ZHhfZ2xvYmFsX21ldGFkYXRhLntoY30gY2FuIGJlIGdlbmVyYXRlZCBieSBydW5uaW5nIGJl
bG93Og0KPiANCj4gwqAjcHl0aG9uIHRkeF9nbG9iYWxfbWV0YWRhdGEucHkgZ2xvYmFsX21ldGFk
YXRhLmpzb24gXA0KPiAJdGR4X2dsb2JhbF9tZXRhZGF0YS5oIHRkeF9nbG9iYWxfbWV0YWRhdGEu
Yw0KPiANCj4gLi4gd2hlcmUgdGhlICd0ZHhfZ2xvYmFsX21ldGFkYXRhLnB5JyBjYW4gYmUgZm91
bmQgaW4gWzRdIGFuZCB0aGUNCj4gJ2dsb2JhbF9tZXRhZGF0YS5qc29uJyBjYW4gYmUgZmV0Y2hl
ZCBmcm9tIFszXS4NCj4gDQoNClsuLi5dDQoNCj4gTGluazogaHR0cHM6Ly9jZHJkdjIuaW50ZWwu
Y29tL3YxL2RsL2dldENvbnRlbnQvNzk1MzgxwqBbM10NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvZDVhZWQwNmFlNGI0NmRmNWRiOTdmZGJhYzljMDE4NDM5MjBhMmY5Ni5jYW1lbEBp
bnRlbC5jb20vwqBbNF0NCg0KSGkgRGF2ZSwNCg0KSSdsbCByZW1vdmUgdGhlIGJ1Z2ZpeCAocGF0
Y2ggOCkgYW5kIHRoZSBDTVIgcmVhZGluZyBjb2RlIGJ1dCBvbmx5IGtlZXAgd2hhdCBpcw0KcmVx
dWlyZWQgZm9yIEtWTSBURFggaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KSSB1cGRhdGVkIHRoZSBz
Y3JpcHQgYW5kIGF0dGFjaGVkIGhlcmUgc28gdGhhdCBJIGNhbiBoYXZlIGEgbG9yZSBsaW5rIG9m
IHRoZQ0Kc2NyaXB0IHdoaWNoIGNhbiBiZSB1c2VkIHRvIHJlcHJvZHVjZSB0aGUgZ2VuZXJhdGVk
IGNvZGUgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KSXQgb25seSBoYXMgQ01SIHBhcnQgcmVtb3Zl
ZCB0aHVzIGlzIG5vdCBpbnRlcmVzdGluZyB0byByZWFkLiAgVGhhbmtzLg0K

--_002_762a50133300710771337398284567b299a86f67camelintelcom_
Content-Type: text/x-python3; name="tdx_global_metadata.py"
Content-Description: tdx_global_metadata.py
Content-Disposition: attachment; filename="tdx_global_metadata.py"; size=6106;
	creation-date="Fri, 13 Dec 2024 11:17:45 GMT";
	modification-date="Fri, 13 Dec 2024 11:17:45 GMT"
Content-ID: <61069585D594C44F92B9AA91D3B0DB1B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEgL3Vzci9iaW4vZW52IHB5dGhvbjMKaW1wb3J0IGpzb24KaW1wb3J0IHN5cwoKIyBOb3RlOiB0
aGlzIHNjcmlwdCBkb2VzIG5vdCBydW4gYXMgcGFydCBvZiB0aGUgYnVpbGQgcHJvY2Vzcy4KIyBJ
dCBpcyB1c2VkIHRvIGdlbmVyYXRlIHN0cnVjdHMgZnJvbSB0aGUgVERYIGdsb2JhbF9tZXRhZGF0
YS5qc29uCiMgZmlsZSwgYW5kIGZ1bmN0aW9ucyB0byBmaWxsIGluIHNhaWQgc3RydWN0cy4gIFJl
cnVuIGl0IGlmCiMgeW91IG5lZWQgbW9yZSBmaWVsZHMuCgpURFhfU1RSVUNUUyA9IHsKICAgICJm
ZWF0dXJlcyI6IFsKICAgICAgICAiVERYX0ZFQVRVUkVTMCIKICAgIF0sCiAgICAidGRtciI6IFsK
ICAgICAgICAiTUFYX1RETVJTIiwKICAgICAgICAiTUFYX1JFU0VSVkVEX1BFUl9URE1SIiwKICAg
ICAgICAiUEFNVF80S19FTlRSWV9TSVpFIiwKICAgICAgICAiUEFNVF8yTV9FTlRSWV9TSVpFIiwK
ICAgICAgICAiUEFNVF8xR19FTlRSWV9TSVpFIiwKICAgIF0sCn0KClNUUlVDVF9QUkVGSVggPSAi
dGR4X3N5c19pbmZvIgpGVU5DX1BSRUZJWCA9ICJnZXRfdGR4X3N5c19pbmZvIgpTVFJWQVJfUFJF
RklYID0gInN5c2luZm8iCgpkZWYgcHJpbnRfY2xhc3Nfc3RydWN0X2ZpZWxkKGZpZWxkX25hbWUs
IGVsZW1lbnRfYnl0ZXMsIG51bV9maWVsZHMsIG51bV9lbGVtZW50cywgZmlsZSk6CiAgICBlbGVt
ZW50X3R5cGUgPSAidSVzIiAlIChlbGVtZW50X2J5dGVzICogOCkKICAgIGVsZW1lbnRfYXJyYXkg
PSAiIgogICAgaWYgbnVtX2ZpZWxkcyA+IDE6CiAgICAgICAgZWxlbWVudF9hcnJheSArPSAiWyVk
XSIgJSAobnVtX2ZpZWxkcykKICAgIGlmIG51bV9lbGVtZW50cyA+IDE6CiAgICAgICAgZWxlbWVu
dF9hcnJheSArPSAiWyVkXSIgJSAobnVtX2VsZW1lbnRzKQogICAgcHJpbnQoIlx0JXMgJXMlczsi
ICUgKGVsZW1lbnRfdHlwZSwgZmllbGRfbmFtZSwgZWxlbWVudF9hcnJheSksIGZpbGU9ZmlsZSkK
CmRlZiBwcmludF9jbGFzc19zdHJ1Y3QoY2xhc3NfbmFtZSwgZmllbGRzLCBmaWxlKToKICAgIHN0
cnVjdF9uYW1lID0gIiVzXyVzIiAlIChTVFJVQ1RfUFJFRklYLCBjbGFzc19uYW1lKQogICAgcHJp
bnQoInN0cnVjdCAlcyB7IiAlIChzdHJ1Y3RfbmFtZSksIGZpbGU9ZmlsZSkKICAgIGZvciBmIGlu
IGZpZWxkczoKICAgICAgICBwcmludF9jbGFzc19zdHJ1Y3RfZmllbGQoCiAgICAgICAgICAgIGZb
IkZpZWxkIE5hbWUiXS5sb3dlcigpLAogICAgICAgICAgICBpbnQoZlsiRWxlbWVudCBTaXplIChC
eXRlcykiXSksCiAgICAgICAgICAgIGludChmWyJOdW0gRmllbGRzIl0pLAogICAgICAgICAgICBp
bnQoZlsiTnVtIEVsZW1lbnRzIl0pLAogICAgICAgICAgICBmaWxlPWZpbGUpCiAgICBwcmludCgi
fTsiLCBmaWxlPWZpbGUpCgpkZWYgcHJpbnRfcmVhZF9maWVsZChmaWVsZF9pZCwgc3RydWN0X3Zh
ciwgc3RydWN0X21lbWJlciwgaW5kZW50LCBmaWxlKToKICAgIHByaW50KAogICAgICAgICIlc2lm
ICghcmV0ICYmICEocmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoJXMsICZ2YWwpKSlcbiVz
XHQlcy0+JXMgPSB2YWw7IgogICAgICAgICUgKGluZGVudCwgZmllbGRfaWQsIGluZGVudCwgc3Ry
dWN0X3Zhciwgc3RydWN0X21lbWJlciksCiAgICAgICAgZmlsZT1maWxlLAogICAgKQoKZGVmIHBy
aW50X2NsYXNzX2Z1bmN0aW9uKGNsYXNzX25hbWUsIGZpZWxkcywgZmlsZSk6CiAgICBmdW5jX25h
bWUgPSAiJXNfJXMiICUgKEZVTkNfUFJFRklYLCBjbGFzc19uYW1lKQogICAgc3RydWN0X25hbWUg
PSAiJXNfJXMiICUgKFNUUlVDVF9QUkVGSVgsIGNsYXNzX25hbWUpCiAgICBzdHJ1Y3RfdmFyID0g
IiVzXyVzIiAlIChTVFJWQVJfUFJFRklYLCBjbGFzc19uYW1lKQoKICAgIHByaW50KCJzdGF0aWMg
aW50ICVzKHN0cnVjdCAlcyAqJXMpIiAlIChmdW5jX25hbWUsIHN0cnVjdF9uYW1lLCBzdHJ1Y3Rf
dmFyKSwgZmlsZT1maWxlKQogICAgcHJpbnQoInsiLCBmaWxlPWZpbGUpCiAgICBwcmludCgiXHRp
bnQgcmV0ID0gMDsiLCBmaWxlPWZpbGUpCiAgICBwcmludCgiXHR1NjQgdmFsOyIsIGZpbGU9Zmls
ZSkKCiAgICBoYXNfaSA9IDAKICAgIGhhc19qID0gMAogICAgZm9yIGYgaW4gZmllbGRzOgogICAg
ICAgIG51bV9maWVsZHMgPSBpbnQoZlsiTnVtIEZpZWxkcyJdKQogICAgICAgIG51bV9lbGVtZW50
cyA9IGludChmWyJOdW0gRWxlbWVudHMiXSkKICAgICAgICBpZiBudW1fZmllbGRzID4gMToKICAg
ICAgICAgICAgaGFzX2kgPSAxCiAgICAgICAgaWYgbnVtX2VsZW1lbnRzID4gMToKICAgICAgICAg
ICAgaGFzX2ogPSAxCgogICAgaWYgaGFzX2kgPT0gMSBhbmQgaGFzX2ogPT0gMToKICAgICAgICBw
cmludCgiXHRpbnQgaSwgajsiLCBmaWxlPWZpbGUpCiAgICBlbGlmIGhhc19pID09IDE6CiAgICAg
ICAgcHJpbnQoIlx0aW50IGk7IiwgZmlsZT1maWxlKQoKICAgIHByaW50KGZpbGU9ZmlsZSkKICAg
IGZvciBmIGluIGZpZWxkczoKICAgICAgICBmbmFtZSA9IGZbIkZpZWxkIE5hbWUiXQogICAgICAg
IGZpZWxkX2lkID0gZlsiQmFzZSBGSUVMRF9JRCAoSGV4KSJdCiAgICAgICAgbnVtX2ZpZWxkcyA9
IGludChmWyJOdW0gRmllbGRzIl0pCiAgICAgICAgbnVtX2VsZW1lbnRzID0gaW50KGZbIk51bSBF
bGVtZW50cyJdKQogICAgICAgIHN0cnVjdF9tZW1iZXIgPSBmbmFtZS5sb3dlcigpCiAgICAgICAg
aW5kZW50ID0gIlx0IgogICAgICAgIGlmIG51bV9maWVsZHMgPiAxOgogICAgICAgICAgICBpZiBm
bmFtZSA9PSAiQ01SX0JBU0UiIG9yIGZuYW1lID09ICJDTVJfU0laRSI6CiAgICAgICAgICAgICAg
ICBsaW1pdCA9ICIlc18lcy0+bnVtX2NtcnMiICUoU1RSVkFSX1BSRUZJWCwgImNtciIpCiAgICAg
ICAgICAgIGVsaWYgZm5hbWUgPT0gIkNQVUlEX0NPTkZJR19MRUFWRVMiIG9yIGZuYW1lID09ICJD
UFVJRF9DT05GSUdfVkFMVUVTIjoKICAgICAgICAgICAgICAgIGxpbWl0ID0gIiVzXyVzLT5udW1f
Y3B1aWRfY29uZmlnIiAlKFNUUlZBUl9QUkVGSVgsICJ0ZF9jb25mIikKICAgICAgICAgICAgZWxz
ZToKICAgICAgICAgICAgICAgIGxpbWl0ID0gIiVkIiAlKG51bV9maWVsZHMpCiAgICAgICAgICAg
IHByaW50KCIlc2ZvciAoaSA9IDA7IGkgPCAlczsgaSsrKSIgJSAoaW5kZW50LCBsaW1pdCksIGZp
bGU9ZmlsZSkKICAgICAgICAgICAgaW5kZW50ICs9ICJcdCIKICAgICAgICAgICAgZmllbGRfaWQg
Kz0gIiArIGkiCiAgICAgICAgICAgIHN0cnVjdF9tZW1iZXIgKz0gIltpXSIKICAgICAgICBpZiBu
dW1fZWxlbWVudHMgPiAxOgogICAgICAgICAgICBwcmludCgiJXNmb3IgKGogPSAwOyBqIDwgJWQ7
IGorKykiICUgKGluZGVudCwgbnVtX2VsZW1lbnRzKSwgZmlsZT1maWxlKQogICAgICAgICAgICBp
bmRlbnQgKz0gIlx0IgogICAgICAgICAgICBmaWVsZF9pZCArPSAiICogJWQgKyBqIiAlIChudW1f
ZWxlbWVudHMpCiAgICAgICAgICAgIHN0cnVjdF9tZW1iZXIgKz0gIltqXSIKCiAgICAgICAgcHJp
bnRfcmVhZF9maWVsZCgKICAgICAgICAgICAgZmllbGRfaWQsCiAgICAgICAgICAgIHN0cnVjdF92
YXIsCiAgICAgICAgICAgIHN0cnVjdF9tZW1iZXIsCiAgICAgICAgICAgIGluZGVudCwKICAgICAg
ICAgICAgZmlsZT1maWxlLAogICAgICAgICkKCiAgICBwcmludChmaWxlPWZpbGUpCiAgICBwcmlu
dCgiXHRyZXR1cm4gcmV0OyIsIGZpbGU9ZmlsZSkKICAgIHByaW50KCJ9IiwgZmlsZT1maWxlKQoK
ZGVmIHByaW50X21haW5fc3RydWN0KGZpbGUpOgogICAgcHJpbnQoInN0cnVjdCB0ZHhfc3lzX2lu
Zm8geyIsIGZpbGU9ZmlsZSkKICAgIGZvciBjbGFzc19uYW1lLCBmaWVsZF9uYW1lcyBpbiBURFhf
U1RSVUNUUy5pdGVtcygpOgogICAgICAgIHN0cnVjdF9uYW1lID0gIiVzXyVzIiAlIChTVFJVQ1Rf
UFJFRklYLCBjbGFzc19uYW1lKQogICAgICAgIHN0cnVjdF92YXIgPSBjbGFzc19uYW1lCiAgICAg
ICAgcHJpbnQoIlx0c3RydWN0ICVzICVzOyIgJSAoc3RydWN0X25hbWUsIHN0cnVjdF92YXIpLCBm
aWxlPWZpbGUpCiAgICBwcmludCgifTsiLCBmaWxlPWZpbGUpCgpkZWYgcHJpbnRfbWFpbl9mdW5j
dGlvbihmaWxlKToKICAgIHByaW50KCJzdGF0aWMgaW50IGdldF90ZHhfc3lzX2luZm8oc3RydWN0
IHRkeF9zeXNfaW5mbyAqc3lzaW5mbykiLCBmaWxlPWZpbGUpCiAgICBwcmludCgieyIsIGZpbGU9
ZmlsZSkKICAgIHByaW50KCJcdGludCByZXQgPSAwOyIsIGZpbGU9ZmlsZSkKICAgIHByaW50KGZp
bGU9ZmlsZSkKICAgIGZvciBjbGFzc19uYW1lLCBmaWVsZF9uYW1lcyBpbiBURFhfU1RSVUNUUy5p
dGVtcygpOgogICAgICAgIGZ1bmNfbmFtZSA9ICIlc18lcyIgJSAoRlVOQ19QUkVGSVgsIGNsYXNz
X25hbWUpCiAgICAgICAgc3RydWN0X3ZhciA9IGNsYXNzX25hbWUKICAgICAgICBwcmludCgiXHRy
ZXQgPSByZXQgPzogJXMoJnN5c2luZm8tPiVzKTsiICUgKGZ1bmNfbmFtZSwgc3RydWN0X3Zhciks
IGZpbGU9ZmlsZSkKICAgIHByaW50KGZpbGU9ZmlsZSkKICAgIHByaW50KCJcdHJldHVybiByZXQ7
IiwgZmlsZT1maWxlKQogICAgcHJpbnQoIn0iLCBmaWxlPWZpbGUpCgpqc29uZmlsZSA9IHN5cy5h
cmd2WzFdCmhmaWxlID0gc3lzLmFyZ3ZbMl0KY2ZpbGUgPSBzeXMuYXJndlszXQpoZmlsZWlmZGVm
ID0gaGZpbGUucmVwbGFjZSgiLiIsICJfIikKCndpdGggb3Blbihqc29uZmlsZSwgInIiKSBhcyBm
OgogICAganNvbl9pbiA9IGpzb24ubG9hZChmKQogICAgZmllbGRzID0ge3hbIkZpZWxkIE5hbWUi
XTogeCBmb3IgeCBpbiBqc29uX2luWyJGaWVsZHMiXX0KCndpdGggb3BlbihoZmlsZSwgInciKSBh
cyBmOgogICAgcHJpbnQoIi8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovIiwg
ZmlsZT1mKQogICAgcHJpbnQoIi8qIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIFREWCBnbG9iYWwg
bWV0YWRhdGEgc3RydWN0dXJlcy4gKi8iLCBmaWxlPWYpCiAgICBwcmludCgiI2lmbmRlZiBfWDg2
X1ZJUlRfVERYX0FVVE9fR0VORVJBVEVEXyIgKyBoZmlsZWlmZGVmLnVwcGVyKCksIGZpbGU9ZikK
ICAgIHByaW50KCIjZGVmaW5lIF9YODZfVklSVF9URFhfQVVUT19HRU5FUkFURURfIiArIGhmaWxl
aWZkZWYudXBwZXIoKSwgZmlsZT1mKQogICAgcHJpbnQoZmlsZT1mKQogICAgcHJpbnQoIiNpbmNs
dWRlIDxsaW51eC90eXBlcy5oPiIsIGZpbGU9ZikKICAgIHByaW50KGZpbGU9ZikKICAgIGZvciBj
bGFzc19uYW1lLCBmaWVsZF9uYW1lcyBpbiBURFhfU1RSVUNUUy5pdGVtcygpOgogICAgICAgIHBy
aW50X2NsYXNzX3N0cnVjdChjbGFzc19uYW1lLCBbZmllbGRzW3hdIGZvciB4IGluIGZpZWxkX25h
bWVzXSwgZmlsZT1mKQogICAgICAgIHByaW50KGZpbGU9ZikKICAgIHByaW50X21haW5fc3RydWN0
KGZpbGU9ZikKICAgIHByaW50KGZpbGU9ZikKICAgIHByaW50KCIjZW5kaWYiLCBmaWxlPWYpCgp3
aXRoIG9wZW4oY2ZpbGUsICJ3IikgYXMgZjoKICAgIHByaW50KCIvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMCIsIGZpbGU9ZikKICAgIHByaW50KCIvKiIsIGZpbGU9ZikKICAgIHBy
aW50KCIgKiBBdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCBmdW5jdGlvbnMgdG8gcmVhZCBURFggZ2xv
YmFsIG1ldGFkYXRhLiIsIGZpbGU9ZikKICAgIHByaW50KCIgKiIsIGZpbGU9ZikKICAgIHByaW50
KCIgKiBUaGlzIGZpbGUgZG9lc24ndCBjb21waWxlIG9uIGl0cyBvd24gYXMgaXQgbGFja3Mgb2Yg
aW5jbHVzaW9uIiwgZmlsZT1mKQogICAgcHJpbnQoIiAqIG9mIFNFQU1DQUxMIHdyYXBwZXIgcHJp
bWl0aXZlIHdoaWNoIHJlYWRzIGdsb2JhbCBtZXRhZGF0YS4iLCBmaWxlPWYpCiAgICBwcmludCgi
ICogSW5jbHVkZSB0aGlzIGZpbGUgdG8gb3RoZXIgQyBmaWxlIGluc3RlYWQuIiwgZmlsZT1mKQog
ICAgcHJpbnQoIiAqLyIsIGZpbGU9ZikKICAgIGZvciBjbGFzc19uYW1lLCBmaWVsZF9uYW1lcyBp
biBURFhfU1RSVUNUUy5pdGVtcygpOgogICAgICAgIHByaW50KGZpbGU9ZikKICAgICAgICBwcmlu
dF9jbGFzc19mdW5jdGlvbihjbGFzc19uYW1lLCBbZmllbGRzW3hdIGZvciB4IGluIGZpZWxkX25h
bWVzXSwgZmlsZT1mKQogICAgcHJpbnQoZmlsZT1mKQogICAgcHJpbnRfbWFpbl9mdW5jdGlvbihm
aWxlPWYpCg==

--_002_762a50133300710771337398284567b299a86f67camelintelcom_--

