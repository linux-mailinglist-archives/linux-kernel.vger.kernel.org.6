Return-Path: <linux-kernel+bounces-435558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA089E7953
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44620282D12
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580861D95B3;
	Fri,  6 Dec 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvxZ2iQs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B1146A87
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514956; cv=fail; b=rfQHooGhhTthrjF571kBbAXxSBaxu6MtXn2JvdouQNeLC0CshPIQjBKM+5YTP9dHvUJV+2DsEJL6KUFdED62R0UBjR2o7ysghmXA9NXe5+hv0AqjAdnSJXYjCtZlIFAeecixokEp8VV3TPYkKAzcdrqaQ9mYVZpuKqKV4nHZlpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514956; c=relaxed/simple;
	bh=G/VzmfNXQDyAmrTFjwvmIsY6er2zdtoAf+TVDv9Qb8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6byD0IJfy5QaJTvPVFrpKT2X0muH6rHentdrOZmkIQ1s7lZta25HTY/GohoDOkGC6T3hkuTk0CbVYFX+PJv5AoO1ZlL8N7AxGRYl5iaMSQez9j9lvSclwGYjflNCrpi3aIxBFlPTfliZPnU8J3xaI5BVnkBRM6ZPSdKO2HNtP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvxZ2iQs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733514955; x=1765050955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G/VzmfNXQDyAmrTFjwvmIsY6er2zdtoAf+TVDv9Qb8w=;
  b=HvxZ2iQs2hq3vmyD93VczH3X+3agyop+c0sgUEUKrqOlJt/2Bpjq6WBN
   RL73f6s2/RW+xibQMBibonZNnnH4PduC2dOGUXhLytQspd7gxmr0ER5Xq
   YkqGsXuSN97R4p5THdwoKen6cQ5mrYC9+huHYmPDTacP2vWRIKLaC8osc
   EsZ+B+CpvYbW1C8hnBattZlVUW4kyf6l9+8HHsrvj+5+ZRHEcSdB6QBPb
   gFdhU2fTW9ywLi3enlPKDgMrEEtrt+hynzxzB1qAQxiMP6XukctDUWGrV
   IZgNvSsSLIhrjm7/6mT0LhJ6f2xp6bHSTDX/Foe5RxePsjvZKFVua2ANE
   A==;
X-CSE-ConnectionGUID: wu1YDvs+R8aCnWt7Qoc50w==
X-CSE-MsgGUID: icvYtUoUTHq2U/VnkAnTyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34028986"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34028986"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:55:54 -0800
X-CSE-ConnectionGUID: f502Ya3kSQ+l4kuxg4TJSg==
X-CSE-MsgGUID: OPEP5mCXQtKoec/Ll6wBng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="98940851"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 11:55:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 11:55:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 11:55:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 11:55:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9/M4guNzSErpMeLHj5ZL2sMS+7Jd9lDKYAEzBM50eg3Cb/1quVOmLo37ZCxRtgGmYI6f266tRWiTIrNXJ2+RDzcy63hvWYi/9t2Q+NuAO/pqXlQMiyoePi+RFiwNWJAXInoeLOQWxEF0KNI7HCmLI5vZdKCNj254cYdAx2Ab8d7YJTFjmd6nYzrguIOAsesDP3wVl5LZmoDs+FoOpsK3EAvNr7cSczNQYr/J5CcS7zIv3AgLXnbjqQCxiWA2vPHkgpzkdV8LOMKBbPUyzd8KKG7zhASk5ny3TJ+YAYqxhxOkZo/D36YmY3yfSaBajZW5+myNdiXBq2Xv4SSfWoynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/VzmfNXQDyAmrTFjwvmIsY6er2zdtoAf+TVDv9Qb8w=;
 b=VWLj2yStG2a3JFNsxqTdOdBOcMGCRo1u4yPIZsPszO1U++1+jpLHburxlrv+jsjbP/tKRuNdsrVWhJVzhapS1CD2kxawmYWadMiiLDm3KZqk0PwHbZ1HXiPXhYmX0MHsKRDw24DNZwQxr2WsMLGpvCk4OEW1qwoP/80f9ZP93QfstUtdi0UTjgf+CL6Dy5ainXes/+dDRhhfDJ7muzwbjzJkt3sP+Ix4UV3dgHG2+GMugGp/hLvcNc3/bJMHRVCOENvy9GoPS1LJHQ6lqXy3SE8b+WiXGCRuiAjkBNe7gJyudQePenV8Idnto2ArLaNnENr/LSW3KbgFeKqvb9MZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Fri, 6 Dec
 2024 19:55:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 19:55:47 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>
Subject: RE: [PATCH 3/5] x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with
 'x86_cpu_id'
Thread-Topic: [PATCH 3/5] x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with
 'x86_cpu_id'
Thread-Index: AQHbSBZ4+u+lX0PhPUWHThBcaWOvG7LZoP/g
Date: Fri, 6 Dec 2024 19:55:47 +0000
Message-ID: <SJ1PR11MB6083BB886A09D6850ABAFE7DFC312@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
 <20241206193834.3ABE2E95@davehans-spike.ostc.intel.com>
In-Reply-To: <20241206193834.3ABE2E95@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7778:EE_
x-ms-office365-filtering-correlation-id: 36c3a258-4d7e-49ea-6633-08dd162ffa70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3uCrYT0olpz9q1gCttnxfFyx8nA5zRHTljbJJvFJbpdhBqW/GvBbtXzQ7R8/?=
 =?us-ascii?Q?dXbmUqMgCKY7hb3QtOJ8iw/fMz/5MI+Fw3JaCAHzKv+AqwARQIAMroAEKAq2?=
 =?us-ascii?Q?zuGxgAOByRrQpkAR8AqWezDdhiTQJBXRmBqtjs1eaLaSYmcsPtlWMjEsG+RM?=
 =?us-ascii?Q?ZKd63ANBktT4bDCTfhqFO+WwApPmhfCZ5PFtYN9Vo8javDk5WKk6CyuZS8g5?=
 =?us-ascii?Q?eoDZd6ByOM2eCgMC6B+VhjJYx0wJEdvl1uOZhtCYnMvamqJ2MXB1Y2FNjrxe?=
 =?us-ascii?Q?Dv1/ziBkkx7nKkdbArUA5CaCkJFhF+pRSDGNbPj4NhWoAB9LuiSPh6VMawyW?=
 =?us-ascii?Q?4j1ubUD/WVRPetxNGrlrm7RlFYR+C98+ml4LzMaLsh8yRC+8O9yt/006av1V?=
 =?us-ascii?Q?bfHIgaX+TxZVjgDcyCLEOM+VTDZs865mMYbnqYVYRLj8g3td/X59jGsJc0yI?=
 =?us-ascii?Q?5KzUMVMZXDl0SD/5xg68KJia0s/bOoRac4tT8VW/YWqU1tkleoU+3VIcKIgA?=
 =?us-ascii?Q?lkx+ydt5AlnUwy7eBS5Rqfmlnc9xPjEIaKoVXoT9QGLbr64IU+64P29Fidgt?=
 =?us-ascii?Q?3SyinmY4eXuWUH9wMLxAu+agY+JdPgyES1x58YcQ6dov7VSpMf9qwqrPp+Hy?=
 =?us-ascii?Q?6UZ6RfyAgDr7fBECnBysxMKUpcRsyR5uso/c66FGgU3eeoJQE1FxNxvuy9Qy?=
 =?us-ascii?Q?UPVspyyQZQVG/+o7PwS/UtZwDTA1dsZ8zhZ567yR/y7HJ4xGV07Sq1223o4i?=
 =?us-ascii?Q?KrvQH87IkjfRbtU1QMASDWXlvuoKuC2quF/MXwHqnK4Q3CkcIR3SkCT827W0?=
 =?us-ascii?Q?BeBTdMXuVRtdG/FSK5DAAklbgyxYUAhbklMplbHaRVnH/ekR59Df1qCzKSqM?=
 =?us-ascii?Q?eYP4Ds3RutGbyJszWLs1Q5BJ8mZLmECMzjJY97ZUFvu3fh1C658pkrDwTA++?=
 =?us-ascii?Q?5B3Hsazt8UVTYFsJntE6dip/Xtnm8Q1FsH0DQf5B7XhxGwD29wFOm51kQN/8?=
 =?us-ascii?Q?k5aIb3bPeFpKCZ0Np+mmOWGL7gnc0YzyEQbdvqu9XTpaxVOGg0FjwIxdi0v3?=
 =?us-ascii?Q?l1dVm9+vh4ImgUGw3MbeHw21LP5MLjT8rwNL8r1D71NYe66YTYuNBcaaOyOp?=
 =?us-ascii?Q?3elC9A9TnpgftKb80QvSLj2pphTC0/H3fVTEeC65BT8VNiyQRzfQUrpdRVmk?=
 =?us-ascii?Q?aAvW7dKzW/xdjG7P/KYkwgMqYQwXQfFW7hAEnmNBmEeUU4KPD0KW8OgBb1jS?=
 =?us-ascii?Q?sbXpc7xTfD49KUZByuWSkc23CscwC5lmzUW4F1a/xrG6+AnE3684KHh+pTAR?=
 =?us-ascii?Q?NnVHwatyJ7xafrAAalcMKuwVANMWHP9A34ETKuZa4Jx7Pqj/tiFyoNZTrqfa?=
 =?us-ascii?Q?R46Mxp++qzTQSxUWSuC9k8J63PLSi1oBxzviHEUYYk4mEYhE6g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HzEwkv4JFKSnWj37AqKijRKqbtj6BaQk1C5VsCFrTF5n0cl97pJYgfjEPNCb?=
 =?us-ascii?Q?em/UsLVprO4CIKBe/cgDVhNfyFISZMjCSYsUuTohUwovnVWTw3zCLtiumNKl?=
 =?us-ascii?Q?ag5lfgXHx5BpwtO4/3xvuCVZzHUAuAEBXk3RtdOp8fqbG1JybyzEPQxRM/RV?=
 =?us-ascii?Q?p6jlit4BMIYrzJ3NVZOx/NuTWuDkn9l5T/JAVivY2DSaIzEJkg0fNJtsGAy7?=
 =?us-ascii?Q?8uOXPqquGZ5cSfPE6F1Qh01TU2REea89tZtUBlaMxcGdKNlgnBZC6VIDVo5Z?=
 =?us-ascii?Q?zfhszjgtlhlzKLhA57d2UXa4pztk/MnNP3FfzhjATY7DmWWIHH7+iNVq7/q3?=
 =?us-ascii?Q?yDNQnb/Kw46f5YykIZWqCIyyvlcvc2VK0ecHP915INncc064cqMS3Tej91PB?=
 =?us-ascii?Q?suOm2XVvXBMOEl9LTxokThVjVu/OkCKINzC57SnPMapEE59HuPcGHEpCmypI?=
 =?us-ascii?Q?/ckKoXRrtUEOZ1r4Td7zntfAQ7FpxjWkOjB8Nc9irMySdovCvH+42/F3JeMs?=
 =?us-ascii?Q?NW3KWLfrrIQDOsQYqYfqbwtcdughvpfOWfHLVADlNSvHlqJDC5420WPbG7LY?=
 =?us-ascii?Q?frQS0CHZT+ChwWXC6lR3+UpwWo33xJkVcPi3jL5reH5x3T6J0ECc7P/oSGMh?=
 =?us-ascii?Q?8Kt0jcOf4v0KNi+/uyQcuPfQ49awB/6P++b7g5jBW6y50Q6BVEe4Fk1ROthi?=
 =?us-ascii?Q?dP1hqeB3pi9qETSuvi4A5nUY1TTkleDuPIteoMuAiyBawtWQuTXIwDo0tBqG?=
 =?us-ascii?Q?2+H90eILZ7LMOcCAH8psFfo4qvjY75O9OC2FP13O2btQblSq2017lBErDssn?=
 =?us-ascii?Q?2x7nvkPa+T1+91qLTtvxQ8agvHK+XttULN0UQM9QN0rraOXqpfkG86KXt2wt?=
 =?us-ascii?Q?Vj9WB+IvpnzCQbjnZoK2B90/HwBpURcJ2Qkm0CbBucl5d+9m2uD0yqlBNNo4?=
 =?us-ascii?Q?tJ4f3Ii//oatCXx8CeSoM+MijkRO5OfbHotqzMG/lYy34xISyaIiAQnnL1d9?=
 =?us-ascii?Q?8y1/4Em3UG4GR/hU9vJL55y8D+u858UUorZ/p3AjP67lPMF39Kz1COnEaRGV?=
 =?us-ascii?Q?tZlpBrb6jFGOYDch38nu+4xXYerSoqIpGraMBRhjJEPvZeJB84RxajBqt5DS?=
 =?us-ascii?Q?24fBWcN8u3RUFi3587ph1euIraR1wvoeIFo0g4BFdlNAfAEVNQAManUCZXJL?=
 =?us-ascii?Q?yW4/Jvg/NOUfnmcYrzsvcvyvzKLa9PgYC2xeTK1efRJajIu2NbzKgvgmMh3h?=
 =?us-ascii?Q?swtN01m5uV3ZSnH95yNowxZ06b+6iiA3B7j0uMyUH7d7a33qk6jlTUd9R1MA?=
 =?us-ascii?Q?tZIU26JdkGCX9J7AH/Bm28/g04gFh2xQNwr/Nova46F7USQAvQIBWoXI4zKj?=
 =?us-ascii?Q?Bgb2pDZUX7ctE8IJ6SNAMb3seAlui5WGGTdPOmvV543jOE6z7ln6Q6ppnNEZ?=
 =?us-ascii?Q?OO/0up7Ycl58Soir0CdFBF8go4RapKW40yP6p83oBSjdnxJxevJsB73G0gai?=
 =?us-ascii?Q?jLU/ecOBXYy0HxpljH89zBWoGY2fJEeRkohQ0quIdeaZVqWygn3HKCb3c5St?=
 =?us-ascii?Q?fhAOXztinr1BnKYcEhC1Q93N6FxbF89vcAqenX40?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c3a258-4d7e-49ea-6633-08dd162ffa70
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 19:55:47.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4eN/x1IeW9DnDA4K2iFJp2LOpd0+52O7faDmVTKWnNP/sPO6v8c0lf91RNsmO4ISpJw+LMiGZPEQnDQCRCkNmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com

> The 'x86_cpu_desc' and 'x86_cpu_id' structures are very similar.
> Reduce duplicate infrastructure by moving the few users of
> 'x86_cpu_id' to the much more common variant.

This paragraph is backwards. You are moving 'x86_cpu_desc to 'x86_cpu_id.

-Tony

