Return-Path: <linux-kernel+bounces-275429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77294857C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CA8B218D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124016DEA6;
	Mon,  5 Aug 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk21DlD2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5442A9F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722897662; cv=fail; b=NSLdmJZ4lFtD9e+hsUpp0q789ti3cdvbryQN+lP17c1POebnUSDvEZNIga4aTYU+QSX/KK7Rw+Uj5mpFKF7Za261SvdqAcWAY0fpNYDCa17fVcJNwFvPszMiZorcmyCe+AHvwvgOPg4Zke28rTP0y4+Z+6aDqb/9rIs7H8SKT90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722897662; c=relaxed/simple;
	bh=sWHr2UKmwr46Lxc2nVklKaoNqb+cgK/6akjFYdYpDak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ol19SIrOA0eR4BSOyffH6us0dtt+M2SRMdQyO3AFIGkMImVvYTRyodVUEFx+Ic5qVD1dSA8KLNT9gs6Q1D+2BflgPk+MzedCCf5GAFD81p3FtqBFpbLIKkSQm7DpBhEmM/xfSRu/N2BI40EpYcYkDWJmtvCKYzQQzV2Mnis5v1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk21DlD2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722897661; x=1754433661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sWHr2UKmwr46Lxc2nVklKaoNqb+cgK/6akjFYdYpDak=;
  b=Vk21DlD2kRSrIvuXbmV3ocUcJwp2A4rmlec0ebLJ0YmGJMakIZZym9wG
   ancD7VsvAHMQIbJ32DzIMLs0JO62kKm/643YbAChdP24+SpoIvmLLU+Kg
   YpXmDkKd4/2hTFlpSvD/rAiwDQB4/kipmKS5VqRgb0jLArlfTKcVudlOW
   g4GwJKk/aTVGRcwAi3o+N4bkheF5gdlTY1TGQXDRFlQQg6j8KSLUK0v9M
   5Ih2j0Jh79sexHRgdiJS6wO6ySqQ/luKwP0mU+KvpygdLNgTbIXE0n7aI
   GTkCE3xrYByJQXdHWslPmucko/5BBUYqPrSCm5LAGOkVxZktQVZ7P/qLK
   Q==;
X-CSE-ConnectionGUID: k8w013GJRD+6zVYaywh7XA==
X-CSE-MsgGUID: /nFWSffQR0qTg/tDTFE0Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="32043136"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="32043136"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 15:41:01 -0700
X-CSE-ConnectionGUID: CTInz1ShRvas52joZqOSZA==
X-CSE-MsgGUID: MluiAAX1TKKsNHVWdMmNDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="61159513"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 15:41:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 15:40:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 15:40:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 15:40:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 15:40:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAtLJhwL7Bg7Rc28wrKAy2eITH+F8275JWdc9y1+9rhpwQ24Nbfu8VDGHftkHw5FuJdtXW8UAzK9oZsQPvezHcHcO5lknV6Q9Z+brWMLXWN/KhD+Nyez69+LdXoK6Ajgp4mWNk+4q77Ae3JCbizRYZvgnBdgskLJZ8H5///Tx4nVuPYzWWy+5EC8j+uOmq2camWh1z0QkeUAYwb+wXK1ZGB+34AAzs1OMstQVGEAx8hYoG1DQS5wpwDCEhPj1Fztcs9E7cCiGrNKSGRPVNw2mJiHqn0Y0PvWnCuXZ2OPgCQpUDQzsnrwyBLNiBZJDNtuRX1QjaOO/2GVCNjvPudywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWHr2UKmwr46Lxc2nVklKaoNqb+cgK/6akjFYdYpDak=;
 b=H3TJ+g3fA0V9BskJk1kDAi+rtnQsHb3XndG+CVl26zMyNgwFI1x8KRWnxmmQaaH2dGAL67Ai1zrOrm7ibQ2u2UfrBkY4CNQSqpWnuvLRbG7wKd6k8P/Wte8/kiIF60lKq7f6h+4goq1uyaViOwxcpgLnpRaDxY1ablHoZVDAsRHY2DQwuVbYDZFGznSsqhGC+DwoC7J33/6YeG0aLBtg5+jBYYC+nG2gN83cCPMA6htVt+sS0/wf9THDs+T0D2wItlrNMiY0IMBzq+RTmkL1PdMm6+txLNKR6ioRv68IieQCOGNoNWnk9DLM0G3h5pksUI/TJZxgYqz+8brK1imuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 22:40:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 22:40:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"legion@kernel.org" <legion@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "ytcoode@gmail.com" <ytcoode@gmail.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Yao, Yuan" <yuan.yao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"John.Starks@microsoft.com" <John.Starks@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Cui, Dexuan" <decui@microsoft.com>, "oleg@redhat.com"
	<oleg@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "geert@linux-m68k.org"
	<geert@linux-m68k.org>, "cho@microsoft.com" <cho@microsoft.com>
Subject: Re: [PATCH v2 2/5] x86/tdx: Add validation of userspace MMIO
 instructions
Thread-Topic: [PATCH v2 2/5] x86/tdx: Add validation of userspace MMIO
 instructions
Thread-Index: AQHa54iI1+JWwFieEE2ovQPdp/nR1A==
Date: Mon, 5 Aug 2024 22:40:55 +0000
Message-ID: <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>
References: <cover.1722356794.git.legion@kernel.org>
	 <cover.1722862355.git.legion@kernel.org>
	 <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
In-Reply-To: <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ1PR11MB6131:EE_
x-ms-office365-filtering-correlation-id: 1bf79804-13ee-4135-1c8a-08dcb59fab10
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlFOZGtocGZNblNQcnZvMWNrVHV1T09NTzdxVkpkRllablpZOW1zUFgyd1gw?=
 =?utf-8?B?Q0pNMTAxS0ZrVzRYVjRkdkhETkd0Wk9YYjdjZUlXOHJnQTFudlNlZjFVR2ZH?=
 =?utf-8?B?VWVQYWovSXQzSXNBWlAvbWs3RkhKckNqUWxkVEQxM1RldUtDbFJWL2FkYUdM?=
 =?utf-8?B?WU9lckhNamt0N1VLNUw1TzhOTFZIUXJRREFIamQzWmNnY016SG5VZFQ2aUhZ?=
 =?utf-8?B?M2dBa3JWazJXSVRCYklGSGJTVTJmUjMxamRIZnAvc1pTcWJZQkdIT1FPVVlu?=
 =?utf-8?B?dldZdUoxWjQrY2w4aW5KOERXRzJwQVZhcngyN1AwMVBpdUJlY1ZIU2hJVk80?=
 =?utf-8?B?MXk4Q0h5b29iK3NVN3lqVmRyZEJpT3ZEY1ZzMWZRV2M4Z2M0eEJMTWlXL1VM?=
 =?utf-8?B?Q1hVaGpTVk1aZ2Y4Y2NJSzhZbXhoRlJnREtDRVVlbFpocjhMTmk1Vnl1ZDE1?=
 =?utf-8?B?TVFJYmlCTnJYcWxMV09QR3NpZ01lV3FpK25Va2p5Uis5MVlsYW1Dc1dSd0xz?=
 =?utf-8?B?MVgzVzNRYlNyNUZBMmkycUJZWmlWOWZuaXNnaGNaTTQxTlB5Q3VXcjhjRjJJ?=
 =?utf-8?B?OHpBZllCZTNaOHl1TDZCdUNKSjl3ekZ3dGt5NEVaQlVQeVFMY3pvdC9vSk9v?=
 =?utf-8?B?cUxjNVVBdFRwUUNyOUFGSVBDTElUV3N6QUgvNnVlU1JiUXlQQWJ2dWlTZU54?=
 =?utf-8?B?VTNJV05RaU05bUVTR1RRSUE2THI3TmVSU2hLeFdPYmgzK0NPSlpFQzZGcmEy?=
 =?utf-8?B?Y1dteTBFdnZMeXZyY3hYQ09DRUZ4aU9FY1BpMnUvLzVPSE1MdTg4K2Flekdm?=
 =?utf-8?B?NTF0RjV3ejNJMWlCQ0JqTEZQTjRqYUV4a1Vya1F5V3l2NmtpVG9nK3NQM0lG?=
 =?utf-8?B?NWZvbHBTTnJrQThIS0dJaVg1MCtGS09jNWVPS3EyMXBiUEsxRnB4NEJmR3Fp?=
 =?utf-8?B?Nk42K053UTZwQkIvQ2R0ZG5IV0VleTY5MmVvU2hlaFQvV2RVbnJjRkVVUWdp?=
 =?utf-8?B?TUhITVY5aHRQWE95Tk9iVDJuTXVLeDVtYnI4MVA0ZjZ4eWNaSXFQSXZEanc3?=
 =?utf-8?B?aW1La25yZmxMV2h1cVU4SXplbVh3bmNxaEIwUzZEQWhrVVppUzg3RG51VEFT?=
 =?utf-8?B?bEVnbWZTSStkK0pxa1FOZjM3U2l1ZWpidGJ4ai92T2dPUUV0UkIzNXZ4Vlpx?=
 =?utf-8?B?YUtzNkdST09mTXEvb2xJQ1hBTXJQQTFxdFdhWWh1SmI5M0EvNmR0aEJBT2RQ?=
 =?utf-8?B?UzMrczN3ZGdvK25NYk94M2Q1bXV5aVVYQm81Q0hPV1ZRekIrSGlWbzIycFhK?=
 =?utf-8?B?dEpMMkEyaVE3cEJHNmVRLzYvd1Z0RDV4ZDMzL0Z6Q1ZvakMwY0oyRjkyaTlZ?=
 =?utf-8?B?QURMU296ODJBcHlWc1NabjVnSysyWG9IYjNPUjF0OEFmSXZWRlNPekk2WXlZ?=
 =?utf-8?B?Y0pSeExFTi9rRnVsUWZnZzJpbHl4alNvVUQvcnZ6aHozTGJMYzdqNVJML1Fp?=
 =?utf-8?B?YVFlS1pxVXdOVnluQ25BN0hxRGNYb0J3QzF6Y2NtdjJlSVd5QUpiVkJSenlI?=
 =?utf-8?B?MHRJdkVMNnBvdmFSMFRXY0QwT003MEpTcm1BdzhFSnhlSzV0OGFRb0VXWDdk?=
 =?utf-8?B?TGo1Zm9lOGwxVUtFeDR6ZU5DcStxWXlhenZnZ0RpVmxQc0pPR3k1dzQxK0Iz?=
 =?utf-8?B?OEFwQmg4bnpURnBiTU9iMS9UYkJYOEFpaGEzV1RlWmJRSEhJNTRiRjREMDVj?=
 =?utf-8?B?WlI4ODZVZHZjWjkxc1BqbjNpSy9HWHRIQWFNa3MyRnppeWV2dDFvcGFjdjhZ?=
 =?utf-8?B?bmlwTVdMVERJeGNVYmVURDVSU3lqVWxiQ3IrN2E4VHhDYlZ5NC9EZkJmc1Zl?=
 =?utf-8?B?cjZwUS9sMXJUOTB6WjlidUtlNkNCZG04UDQ3L2NFaXlmTmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFhka01mbHY3Y3h5QWZaVDZ2THpKVks3REtNUjN1UDFmSUVDRi80NlpBWUFl?=
 =?utf-8?B?QXdvK20wdDMraFltcng4OHQwYnc5OWVSY0ttZS9KZVVuSGR5QXJiRjI0cmR1?=
 =?utf-8?B?cWd0UXlmL1NRam9PYmVQZXpRdFU3cWw2UFcxdXQvZDg1VFRFV0VqZ3BOZjR6?=
 =?utf-8?B?b0tFcmVJVU4wSEpRalpxUTZYTTk4RnVhNkd5Z2UyK3A4a01IQmpxRjVlVGdp?=
 =?utf-8?B?cmQwZ1dhTm91NzdobnBSS2ZjTzFQb0xyUDEzaXBKdmxnWXk1Q0wxcFpweGRR?=
 =?utf-8?B?YjhUVytkQU8rVHlhU3NMbm1IYjh3VkZwMXYrbzJJNlN1aGk5REVFditibHBC?=
 =?utf-8?B?YlFhdXF3a3pneGVZREJ4Y003UUpJeEVsa2VhSHhPTmJlREJ1b1ZkbmJGUENx?=
 =?utf-8?B?bkZNZ1FWS2tZQ2ZYMmZSellqak9RUTdUNDNlbUE3WUg2QUNtSTVDOVJKNktI?=
 =?utf-8?B?dk1BNVJZS2xZSWxNa0s2L2hMRjJqNkd1bmR1cCs2RlVHVUFPM09rMHRJU3d1?=
 =?utf-8?B?U0JpSzFiNzRkVnVXZGFhTm8zc21zdnozQzJDcGZVUXRrWnpNZVBjTmR6V0NF?=
 =?utf-8?B?WUFLRmdjSkVDY21wQVhzb0JhWFQreXo3V0xZeW44Tml4TE56eVd5T3RDTUxq?=
 =?utf-8?B?eVBuVWRjS2F3b2xIZUFWbUY1MEV2NHBXNlhVVTBmc1FrYi9zWU0zNENGbUZq?=
 =?utf-8?B?dGhCWkhvZVhJU0E1TklNWmhvOGNXcnlueEpmVVVsOS9pVnh4dkYySG9MQ0NB?=
 =?utf-8?B?WjZqekdaMGZmeWdSMWlzdE9LTEV5NS9XQ0NObG9nMVJCNHhnRGZuS2t3azVL?=
 =?utf-8?B?cHhPMjVaV2d4SGJVUWlUSnlONi9DbWJKS3FHbC9vb1czcmF0YjI5aTJpVVU5?=
 =?utf-8?B?ME1abjJKUWJzb3pyTHAyZkI2ZS9xSFhCM3pqYkFudElLYkp3cTZLdnk1Z2JN?=
 =?utf-8?B?S1pkVzAvWE16MWNIMUppTUdEdTE3NGl4U0ttNlFDVGEyc0lPQzVTWjl3eWx1?=
 =?utf-8?B?bnArbWtUdlUzamZGRE9JNVpRczBZQjVKTUNRV0hROVZHeG1RS0s4UG0yVHYx?=
 =?utf-8?B?YmJrWEhqckg3dzE1L1VRNHJNZFMzUkFHSlVsM1pFNHBmTmZUTy9VUWkzbEpM?=
 =?utf-8?B?VTVablJVbkxhbVNEaEtoNVZoTEpDQ0N2MmFNWTRSNDk4RVB1V2gvZDU1bytV?=
 =?utf-8?B?NHhJTCs2MmJhSXlMNjhITlAyWE5HTXVYK1dYMUprdHNlK0o2ODlRRG9DMy9y?=
 =?utf-8?B?RFpxZVBYdjNDZmJEbWRFYnZtK25kVERjZXExTXV3MzF3K3RkL1FtWkdRV0ls?=
 =?utf-8?B?RlBPV1dQd0dJL0V4Yk9iS2U1aWpVOEZpSVhIbUhueGZRNFFLd0lybHFELzBy?=
 =?utf-8?B?UVVQUkNSNS9oSEVpellrZlJHWE5mRzA4YXdUTmdSZUdSWkdiU3RteFlCRVRP?=
 =?utf-8?B?K01kQitVL0gzczdFWVNDd2xTVVJoLzVhYUZQbjJSbmUwN3hnZUR5QnJScjVj?=
 =?utf-8?B?U0ZQY3J2ZTJ2WWZKZ0pyckw5QzdqWGRhUnhjRWpVTXh1QldUYk5MQXlvV1Rs?=
 =?utf-8?B?cnBvbzRqd3FYWkt4bnlud0gwNmdNS1N0WlQvalJsWFJRVnMyWlI5Rmp4MmtV?=
 =?utf-8?B?VHpLZUtjVFdiK3hLWUVSclBHdjFDNkFHQWEyUkdUVnNicGV1a3huaWV6WlJp?=
 =?utf-8?B?STZ0ZTBjUDFNTTZVS2tpVmhybUdDV2NjWHVlVFdKeDZtUEJKL3BDTmI5bzR5?=
 =?utf-8?B?YUQwNUs5ZmhLeTRZa1doMzJ6VEwyaXFFczJnOUwvSTR6cnIwMitMZGVJL0h3?=
 =?utf-8?B?TkIvRGJJOHJ2ZTNmVldtVlA2cEJtQUY2bnJuc0ZQK1o2N3VZNlppVEhOQ3N0?=
 =?utf-8?B?V21BQ0I5YTNDWVJSQzdzNXY5L0RPb2pzNitBTld6SFo4bFQ3bjl4N1JMWkJW?=
 =?utf-8?B?azNHMWUycGJoNmpMTGdZQ1dkdFQ2K0JhdFVMMm5PcThkT1hLdUhJZEFUWFZk?=
 =?utf-8?B?WnliOURoQnpIYXpHaThTaDA2ZmoyTnB3Z1Y0MXhyNGd3Q1lnVkpDRzZOMERx?=
 =?utf-8?B?N0FoU04vNXNDUDU2NTFrekNBbURsMW1ISk8vQlp3Y0JqMzZ5R0l3L2hXYTFO?=
 =?utf-8?B?MG5nQVplYTZ6NFB5STVoVSszNFhJMEx4Zm1UbThOSndWMlNYcE16TU5FMjZC?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3976E9E7ACEB76499297A19E4E3B643E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf79804-13ee-4135-1c8a-08dcb59fab10
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 22:40:55.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SfXOECIu9rCmGUQG6ypyd1d6QWdyI0K/++4iSvlShQotB4PZPbZQ0cIQI1hgDhNuQF0mla7t23Izv8dVKp/Nk3V5eCnTTig0a7WtbQeWIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDE1OjI5ICswMjAwLCBBbGV4ZXkgR2xhZGtvdiAoSW50ZWwp
IHdyb3RlOgo+ICvCoMKgwqDCoMKgwqDCoHZhZGRyID0gKHVuc2lnbmVkIGxvbmcpaW5zbl9nZXRf
YWRkcl9yZWYoJmluc24sIHJlZ3MpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAodXNlcl9tb2Rl
KHJlZ3MpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChtbWFwX3JlYWRf
bG9ja19raWxsYWJsZShjdXJyZW50LT5tbSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlRSOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0ID0gdmFsaWRfdmFkZHIodmUsIG1taW8sIHNpemUsIHZhZGRyKTsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gdW5sb2NrOwo+ICvCoMKgwqDC
oMKgwqDCoH0KPiArCgpJbiB0aGUgY2FzZSBvZiB1c2VyIE1NSU8sIGlmIHRoZSB1c2VyIGluc3Ry
dWN0aW9uICsgTUFYX0lOU05fU0laRSBzdHJhZGRsZXMgYQpwYWdlLCB0aGVuIHRoZSAiZmV0Y2gi
IGluIHRoZSBrZXJuZWwgY291bGQgdHJpZ2dlciBhICNWRS4gSW4gdGhpcyBjYXNlIHRoZSAgCmtl
cm5lbCB3b3VsZCBoYW5kbGUgdGhpcyBzZWNvbmQgI1ZFIGFzIGEgIXVzZXJfbW9kZSgpIE1NSU8g
SSBndWVzcy4KCldvdWxkIHNvbWV0aGluZyBwcmV2ZW50IHRoZSBzYW1lIG11bm1hcCgpIGNoZWNr
cyBuZWVkaW5nIHRvIGhhcHBlbiBmb3IgdGhhdApzZWNvbmQga2VybmVsICNWRT8gSWYgbm90LCBJ
IHdvbmRlciBpZiB0aGUgbXVubWFwKCkgcHJvdGVjdGlvbiBsb2dpYyBzaG91bGQgYWxzbwp0cmln
Z2VyIGZvciBhbnkgdXNlcnNwYWNlIHJhbmdlIHZlLT5ncGEgYXMgd2VsbC4K

