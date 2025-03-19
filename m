Return-Path: <linux-kernel+bounces-568841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14509A69B10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2347A6E46
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AC214A8D;
	Wed, 19 Mar 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIUOE7/g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9C134B0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420582; cv=fail; b=PqbWCJ9tc1LtXE8ILN1qfiYMYWrQd2xeAmgLDr8jvmH+VPIRnd2EOPMxuODyQxS2AQ2FieCGewjtcnjRysr+Zo3TiJ/AbrZLHIB/To7pxVZckHAi8DnLF+zXF4M9TI8BEt3CTkkyJOlIxy7gL2yxzzsHjlYMsdwivSZA0CG7WtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420582; c=relaxed/simple;
	bh=kL159qEXv75iZAbny6Rj1a3stIgmIPqOh3omqp2FpiU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DLakrL7eYvGFA19qU417LEIMEf6tmiRo6QytISgxyrOyXcpFdnJB0h9Scr/1fTK8JLxBeUQ2hg0jUgfM51VQ2g1PQ+MUBRDBrSmypTB+4dy3Eu2J7bKEXM4M9Wmrlcbb6aVIRMuRToYSTbRXmprP+MoNqrm0IIhfeDfbXxOj9OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIUOE7/g; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742420581; x=1773956581;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kL159qEXv75iZAbny6Rj1a3stIgmIPqOh3omqp2FpiU=;
  b=NIUOE7/g7EM7op5IAhl+rjEJEXnUjFzfahyZABu0l1Poq0d4o8MaWE15
   FlThTNDPEFHtvz+ncLJ5bJR3Pr8FDuFxBAvRlwl6iUyKIjHKzVwSkf3Cl
   l0JNUeDHpdQ2pS91I352hLMJ1FnKAsnnDK6P8WSvcWMkT9Wt+VaQn83fh
   rfdu4DqggDgJdU5DRzHkpsiBwj4WTjMuMSsByw7GGGcLolxopHbYZm00f
   RsnK7MzaVlQKDTaJIuuHKTCkQF27ofQPln1bX+JJRGkwhsIm7zmvf1pfB
   Tt2foUzLdubr6cFLBJWDg/AyseD2GH2mLHWtECjlEUspVQEyD/AJ9vMSm
   g==;
X-CSE-ConnectionGUID: xldsMQTjRY2/UCj6Ts049A==
X-CSE-MsgGUID: Y/uLmeUxQo6j401ltCaSfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43742089"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43742089"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:43:01 -0700
X-CSE-ConnectionGUID: AGVen70gRDOJMzMxq1qwow==
X-CSE-MsgGUID: mSCp4aYdRxCe+TQtg8PSqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123572875"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2025 14:43:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Mar 2025 14:42:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 14:42:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Mar 2025 14:42:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTZAod3VKaAuYUj4kVFhnruRiDB1BYS8+pkZWbEvOvleijJeKG9NVbWdGZAlnS4sWgN+Hh3tYoPaqUzQ7WZ4ncwibnO3rYmUggUGePemB4jC+vbPMlEEU8V7zZr02k3o5RLgF0aHc03icTBGJ5UcH9NFYZEdu9KhFojo4NhmZMdjeUSu6Ps0ksLXGP3UMD/EM0r3ulBbq2J9DP+7eSJi+GcrT8++dd+eHw6wcG0qxJrIpz0vAu83p/Shd9MTlWzs7dH3OPJMi2iWMZeJzAWcY3l9rcVSj6JEtAXHu011zo0/EzVcFbRs3qh0TDsHpIPcgk9jeATSVlWeT6cx1uIXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL159qEXv75iZAbny6Rj1a3stIgmIPqOh3omqp2FpiU=;
 b=BpQwaYXgA5ikEq7IZ6m6lGv6e93uGK0kb+hA8zhshoxAM8mxTild7Ay3k3ZKpBHbsykbiZd59lkE9JGQgKToNfLZxOQIj0HeHyXXiAEGCSninkcrXbkXqWPVUB7W96WaDAkJV+saHJeUGz7aTV/sSbka8U/jRFvfU0QfHc+9a6kT8+ZwPkv68tYPtYOt0JCem4mBP/PR5nwodF3eJ6Hk7oyRPO3q1Us4f2AeYzAWVQbNe83eo4ASBWCwAnbLpvT7tVssP7J54uw5e0C0tMLfKkqHQ6C2X2CCrbeQDpH1BB7cgm6/M6P12QULtz8d58wNz7wgMEIBXzrLn5KjqKABQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB5820.namprd11.prod.outlook.com (2603:10b6:510:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 21:42:57 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 21:42:57 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "dyoung@redhat.com" <dyoung@redhat.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com"
	<sagis@google.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0Lbd/o5JJJNyk6v5kYhZVWKCrNxaCuAgAXoSICAAJjWAIACy6YAgABURgA=
Date: Wed, 19 Mar 2025 21:42:57 +0000
Message-ID: <c2b4886c449f96a423b2c0f0ec978550c16ef58e.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
	 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
	 <gbxpvgmmzf354g3gccflrv5shtaque4rd3uklrgltlbnedip7y@hhwvyhxh46nk>
	 <c7cec9118a23220986c1894f18cafb3aa5b9fc1f.camel@intel.com>
	 <eb2e3b02-cf5e-4848-8f1d-9f3af8f9c96b@intel.com>
In-Reply-To: <eb2e3b02-cf5e-4848-8f1d-9f3af8f9c96b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB5820:EE_
x-ms-office365-filtering-correlation-id: 1b84213a-8a3c-4b6e-19fb-08dd672f032e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmZTeGtrVGlxSXdpRjdwTTRUTE0vVTYwYi81ZXRNdU03TzFTQ1YwK0dXUjVS?=
 =?utf-8?B?OVJzT21aQkY0eXFDU1lPMFhUdEZ1eXd1cmF1YUtqSmE5ak9iUmppcWlsU09Y?=
 =?utf-8?B?S3FtUWtnb0RneDlDamg1cnNxK1luUThUZjZVTzg2RlJHblpZWGN5RmlpbmZk?=
 =?utf-8?B?bmZlem5ZOWMwa0FGL1g1YmpHb3RrWUh3QzM5SWlkQllyYzl5VmtkUW0zSmZK?=
 =?utf-8?B?QzV5WmNvTmcyVmF6S0Z1N3EyL1hQQUxzeFpDbU1DSEFMSDNsU3VUL0tKVFVS?=
 =?utf-8?B?RHRvRC9UMzVEdnpxeWozTjRLREk1WnMyRzg1ZzNSZW1JLzRjL1dwVllxYmRF?=
 =?utf-8?B?M2xOSExFaXZ5blRJOEROd1Y4VTkzQmRubWtEOG5aSXc4TTlrY1gwazZiQ3NQ?=
 =?utf-8?B?QjlUSmlSakw1TElLQnA0UjRZRFZ3NjlBaVZuR1hwcDBtT05PNDBMdUhJWEpQ?=
 =?utf-8?B?YWZ1WjdmWDEwenpNYlRjZlByOXJ0Kzh1aHJGTm9FZ01jZlMxRWYvV3pyY3JM?=
 =?utf-8?B?WGM1Nko4Q2t5SkY4Mkt6ZVd6MVNKMFkzVTE0ZjhnQVVlQVpzN3VrbmZMUmlF?=
 =?utf-8?B?a2VOaEtEMzZEdXRGY25aMHl5K3p6YzdIa2ZvMlRNU00vazk4L2lXQmxVdlZK?=
 =?utf-8?B?SktycnN6a1FBalBCdU9XanRqWEY5YlBITE1VcmRROWw3dVdqbC80TExFOGFD?=
 =?utf-8?B?bWZCL1FhMmdXNDFWS3FqcjFSaWZJRm9IZGs3SkRwaUNBWk1RS0s1QzVzWkhv?=
 =?utf-8?B?MmxiN2E2UGVLSWU1NkI1aW4rUmZNWTY3b3hBUGlmM1ZxQkVpNkUrUWswRElp?=
 =?utf-8?B?OUxka2x5d2RWaWladXBXNGFWTzNwUG94OHBXa1Q3clJkU3R4ekNVNS9ydEhR?=
 =?utf-8?B?ZjZCajlZWDRIcEloNGhINUxQNHNRZW5xR3cyRUQ4aENtaHRuQ3M3Vzk1RnNZ?=
 =?utf-8?B?MkxibFVlZExycEJScExkaGcvM2d6WEM4ZE1mUVlNV05iSXdNejdMbStRcXBI?=
 =?utf-8?B?dnYwYmhjb0pZaE81am5tU2lRcGlpQzk3TFplOUtrUFJDT0NJVEFvMWxqSDFh?=
 =?utf-8?B?bTlja1BUZUNSZk1XbmpPbjZQNVNrY2c3eEIyd1A4R3FucS84UXZ3MmMrYnIw?=
 =?utf-8?B?Ull5WDIyalViVm12RXlrUFRPOEVvc0I2aTZTL085dWFkT3dJcVhOZHk0Q2RH?=
 =?utf-8?B?Q25icnhQa1c3NlM1WTM2WEp3NHJSR2VOa0s2SEhGRUxuYVN6RUlrNFN2TDg2?=
 =?utf-8?B?ZDZ5STNhanU1SlhnaEF5NzRFdExLN3NuVC9taSt3cFNEWFNFY3F5QmErQzhm?=
 =?utf-8?B?YlYxUHJ3ODhFSkV4c2FyUDZmdFZJUGhUVzRGdmpyZHRKRExsUnYxMlJZaXhS?=
 =?utf-8?B?MTNoUnFuZ1Y4U0VzVXlPZG8ybnlsRXdUUDE4c2lZUXY1aEpqNk55RTlwSHpt?=
 =?utf-8?B?VzN2RWRQR2I5VWF4U3Fnc21LQ0xTeDNGb1Q2d1JsaTViUkRhbWt4d0FsVnhm?=
 =?utf-8?B?YUN6aXBhY2tTZ1NvY3NUY0swaFVFSXNnWVdzcGJjTVBLMUFNeXkxRUxNeThI?=
 =?utf-8?B?OHRuSmMvRDYvTkdQVWoyZk5rRDVoZlQrbkpFY1A2RjVnNi9CWWhhdFRqZmZj?=
 =?utf-8?B?Ui9FSldQZEpKa1FlVVdBbWNkNXRIZjQwMjk0WlRLcEF4WGE4b1hmdGYybE9s?=
 =?utf-8?B?REJ0clhicHVtcjhpczZpZ3B4VG1KSTExTDMxeVAwbXIzbDUrK0ttRFoyMGty?=
 =?utf-8?B?WVpMajNscWZtcExsaDY0SkNETEMrRE9raXpBMytJUlVKbkg3QkZZWVpnQnZS?=
 =?utf-8?B?NzVNSWY5alZTQWFxVmlyd0tFVnRiZ2d6VVlzYUdsMldwZk84R29hVjBmY0VG?=
 =?utf-8?B?Yk1rMGpsTTFnMWNnTlhISCtkRzlzb1JNdFVvWGtFazdLMWtxb1dRSlhFY0lB?=
 =?utf-8?Q?3BmaAvMi3K2BUoYcO1c0+nvZFlKhabzq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlJCb0JpN0ZkN2w5d1c3WUhmTVlHTUZwdllCRTA3OTRZUDJ5UVNaTG9nMTFa?=
 =?utf-8?B?bHpsdmVpRHhyVkgyL1U0UlFWZDV6bW0vdGtUZHhjaGZTS05Ka3NxY2EvQVFl?=
 =?utf-8?B?aEpGRktWWXZRSzZnemJQaHk3QWkyY2dETklFOG1MbHNKMXRXamhzWWtOa0VE?=
 =?utf-8?B?NHhKZWJwR3pRKzlHR0RpZGc4d2dTVno1UUl5empxWTVTRk9lbXNuNy90Q1RZ?=
 =?utf-8?B?VHBvaGhOQzhZWlRQVGhYWTlENk03eThtQ2ZTeGRkL3paWDRocDQxZHVORmpC?=
 =?utf-8?B?dnBQRnZYZVdaZlozeGxMVjU5THk4LzdZZVJlUUJabXJFaHlkeS8wMDVoRGtm?=
 =?utf-8?B?ekQ0NDRsUDk0M0dnY2daelYreXJWVXpLbHcrVXdQOUNYdUk1RVM4YksvdVBK?=
 =?utf-8?B?WlAzNFFKZHBjSDc5UkE1SG1BSHFrMjhqWUlwOGhzOXdLSHU3TlFMYzFlNUMy?=
 =?utf-8?B?S21CTHpnMEhzV01ZQUxNS1AwYUlERHJ4bk9GU0hLdVB1TktJcTc4Qm1XU2Jx?=
 =?utf-8?B?ak5xT3ZYTEtMcmlndmVWbHZFTVhYSW1MYnN6TmpFcERNYXNSL05YcnF5bWJl?=
 =?utf-8?B?T2VsbG9sVFBocEY5WEVGWXZkd3ArN2ZrRUFENWd5bzd0VWlBUGFnTi9rZ3JK?=
 =?utf-8?B?MVhsM3U0RjNXdUNKNDBkNTg1d0lJdEprZGFYa2gydFJQREl1Y1JvYk1kWHRu?=
 =?utf-8?B?MkhKanpxdGhkb3pPdk1tMjhVMmVPMG1XM2Z6QVN1RjkyTnJzL3NvdGdtSVlw?=
 =?utf-8?B?ODQrNSsvV1VvajZXczg2RFFjNVQwb05rVEFoSndGNy9vYS9iVVRQY0VEUXNH?=
 =?utf-8?B?SXQzZkRXdlQxQ2VaNlZER1RScm9BVUU2WE1lM0cvMGh0YUpjWmV4L1JwNmtr?=
 =?utf-8?B?bWtJVmw1TFNpdnVFcFAvOEhOU2d5Wm4vYnlUcTA0YTdSYkphdkVibUowTVdz?=
 =?utf-8?B?Z3A3dWRpanNGYm1HemtWWmcwdittK0lIWWY4MEN2ZE9xek9WeGZpZ3BlOC9J?=
 =?utf-8?B?V0ZzdUNJRjlzT0ozRkRqYkdrUUYvd0F5ZHlqclBYUitORXhGYUd3UWhMNjV1?=
 =?utf-8?B?N3JKTVFrcnlvNUdTUjU4OVZnL05qNFFleWcwTmxoUUJXcjEvcDNWamFNQnBI?=
 =?utf-8?B?OWNHNkxJcFZPQ29vMTNWcTVuNk0rUmRGZmUwOW5FeVJJc1RmVnNXOGRFVzZs?=
 =?utf-8?B?QTF5MjRYMjFRYkllQTJoaFpaNzYwMEFFakx6S3BvTksxbE1LUkYwcVFjVE84?=
 =?utf-8?B?YkJRMGNnZjkzcnM2QktQRUdVdTdxc01ReGZ6R253QXRrcXdUakRIZFhRN1Js?=
 =?utf-8?B?TnN1bHpSTGl1bVJFVjlZcG9mVkFteWRRSC9JbTdvbU5CYWlZeFVpWmg5cFRj?=
 =?utf-8?B?S0RLMVM4alpsSFBGYXU2ekxUUEJkZXlQVWRqS3hGamFIdnZ0eXFzMGN2cVhG?=
 =?utf-8?B?ZHp6ZCtZTXRVNGZydUt0MnZNRTNkRXRuY0RzaG9USWhHa0dUVlBhL1FDM3dS?=
 =?utf-8?B?TjRwZEw5NUY5cnI2Uk13Z3ZuWENFL0JuaUtPSUJObFk0Ly9WQllETGswOXAz?=
 =?utf-8?B?NnVjV05GM0NDdEE1MXVDWUhzdml1a0ZiOVA5bVNmZHJUZ0d3NnVjSFpvUTEw?=
 =?utf-8?B?ZElGTTFxY0Nsa01wSGh1T1FQNTlGVW1RUWdYdFJPWHZOcmZsNmN1SW9LQTI0?=
 =?utf-8?B?OUFaSWlIVnpMMXRmekVFN3I4dkxvWWYyclZEUk40Q3I5ZWJKemYzZjFRdnd3?=
 =?utf-8?B?anlQdGVpUW0rRnkyK3Mzd2VxQW9CV0dZaTZpWTlFMkUwK05sK25sRGpNQ1pa?=
 =?utf-8?B?b1MvUkZqLzRiMzhjN0tBSEhBVXBxc1hsNEw3MUVZZmNMNVZGdFVhRllVTlJ6?=
 =?utf-8?B?bGNKamxBc25nWmF3eXVZWndDVFpiSXBnR0xSOEtnd3JYRlJ1ZWVMcVNkTDlV?=
 =?utf-8?B?Uy9uWlZuWGtvYVIyakhyV05BT28xODdRSjB3NE5OLzVib2JmWmZxaDlWZWgx?=
 =?utf-8?B?elhMdWJnekQ5dEpvVXc4L3liaU9SVzJZb1pTVU14YzJBTEs4Y1NFQi9vWGhn?=
 =?utf-8?B?d2hCV1NHekhkL1dpaU1PbWsrQ2RuaU9UZk5jdzlVeDViMmVCSXZXV2NZZmc0?=
 =?utf-8?Q?uJKduZ0rHCYnbl/moydEPDD6q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CEEAA9B3301E24BB34C2893D1C71604@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b84213a-8a3c-4b6e-19fb-08dd672f032e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 21:42:57.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9A5MAnsZRaax7CrLHhljI8aVEbR/GvAk3j5Mx2QNJlOI50mVbp+LAxpePeEqRNq2KqJRDxuJCY5x6KnfOye+xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5820
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAzLTE5IGF0IDA5OjQxIC0wNzAwLCBIYW5zZW4sIERhdmUgd3JvdGU6DQo+
IEFzIGZvciBrZXhlYyB2cy4gUEFUIG1lbXR5cGVzLCB0aGVyZSBhcmUgb25seSBldmVuIHRoZW9y
ZXRpY2FsIGlzc3VlcyBvbg0KPiBvbGQgaGFyZHdhcmUuwqAgVGhleSBfdGhlb3JldGljYWxseV8g
bmVlZCBhIFdCSU5WRCBhdCBrZXhlYy4gQnV0IHRoZXJlDQo+IG1pZ2h0IGJlIGVub3VnaCBvdGhl
ciB0aGluZ3MgaGFwcGVuaW5nIGR1cmluZyBrZXhlYyAoaW5jbHVkaW5nIG90aGVyDQo+IFdCSU5W
RCdzKSB0byBrZWVwIHVzIGZyb20gZ2V0dGluZyBiaXR0ZW4gaW4gcHJhY3RpY2UuDQoNCkZyb20g
dGhpcyBwZXJzcGVjdGl2ZSwgSSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBkbyBXQklOVkQgZm9y
IGJhcmUtbWV0YWwNCm1hY2hpbmVzIGFueXdheT8gIFBlcmhhcHMgSSBjYW4gbWVudGlvbiB0aGlz
IGluIHRoZSBjaGFuZ2Vsb2c/DQo=

