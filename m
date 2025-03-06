Return-Path: <linux-kernel+bounces-548097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409F5A53FC3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C1C3A8F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C915C14B;
	Thu,  6 Mar 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1c639QD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B7156F39
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224073; cv=fail; b=uVtzRykzF831lba//BLuktEkBTLf0MqWoQMJDcawZFfEDwo6P9kcuFl3WTQ6KC0uxkcgL4SaAxYv5S23StKjE4tb73FkACZv7RTh5KBxxxwXunVJkCPpKBOFZIW0l0yH8sVSfkHMPZP8CCuYz8Nij0LVfbdlraABp+BqnX7V/CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224073; c=relaxed/simple;
	bh=K0DrI80tqhTTIlEhysaM2xsISmms1HVlBWkKOXY1kCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WnisB2rLwzoBGYKA3Tpy8QC9DK346Q640M01YBjscO/j2Sp8BJ+Fzo2GaAiyOOToHSJDPNiPy3nT31+OEix1WJvIJejRJvuMB+XMgT5mffKAlKHc6+rBWeSpBBDytZEPljDY/AynruavfMwCKCl6gsHx8NwGIX3admjWSnklU0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1c639QD; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741224072; x=1772760072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K0DrI80tqhTTIlEhysaM2xsISmms1HVlBWkKOXY1kCA=;
  b=V1c639QDFeczjFdQaZo5ciyHYDz8Q1O33xojRCJXCrzKEHeIbpUvtPg/
   UAwohrTBRU1crk7YASMN+v6fFvzJYBF6H6a+4cJ0wcYmvwALVMeatdZi7
   93X+71bJPQtmp3zYGb6/vLLiCxPcsSveyX8MRypguWOERMcrFeRDOBp9y
   iP1kLYtgHABKL2Hc5DRetCx4WggHjJTtrHviJORj6GjUea+RP4zND3f2o
   DJR/h6MsYkSuNnexmTOE5lRb3Co8mCY0yOpbuJPasjR+rEz99htM+OqP0
   0yPwvuuEqUWKaiIvXX7gxwuZBYJNKL9lKy+p3F3DwwPq45M1uwKjoTSH1
   g==;
X-CSE-ConnectionGUID: 4wzWy84CSiuHLwEJwUajig==
X-CSE-MsgGUID: X7+erTg8QP2g2dlVVM/SvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="64665079"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="64665079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 17:21:11 -0800
X-CSE-ConnectionGUID: r2of31OFS0yeBE8ARbRFdA==
X-CSE-MsgGUID: SZT7l2zXTemCqOUz/lY+Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="119554970"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 17:21:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 17:21:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 17:21:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 17:21:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vyt0Knt+Y9A0e09SuIFpPa6jJCyNwq7QhVjZ/GXhz77Ip+OspuloLT/+1RK9oy0yor/C/qHWxphXR2c85h6A+HnH90Y3kW/I2qWkoI0dzTHrUFkBQ4+G/dwxaMADAV6XJlyss0fXHbi7jswxEZ6BGS/bhE9NdciKb5I+BIKQ8T0zgbDnLWFyeTlnc6g0/vEOlBOTJYgyEwvB3aMe3xYmMEpzetQJftw/vIjXklmy88YhkYTtsoH9r6D/E6s/RR/KZ3kbjuxflnaKYIygsXBLEp8GKJKepkCGu8BauFJUI+9/BVKgQH3X32wbXFuVl43DhpOyCnnjeLixEpso3+kvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0DrI80tqhTTIlEhysaM2xsISmms1HVlBWkKOXY1kCA=;
 b=tmGP28oo5BtgSUv61cPRSmnpG+iwgso8gYy3A4O9RWyNhuxV3iSarwE5I7L8favEJyNxwO+zmDdxdVqh6x8jTSdR9fripWL38bE1QYLzRNOQXr5z4z6TvDsvdCZmge7UEf5dlIIA8LpITLM4CbhgZnAxNVkS+ZXitYh8yvuKbBDrapJhuyUv0bs/xXvHFWblvsw0lrhTdHKjUiYbjZz9tNU0J00YFG9UlZNHcmw3UlkierUUReGXZ7Or3sMPlRI+Au/oyb6DvELMzHJc8FNctOSq2St/eJ7KXDRBJkAchVf2nwbsWlTIWW1amiS+hdJXGrbiHXNnPp8W7boetnV/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 01:20:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 01:20:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Xing, Cedric" <cedric.xing@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "dionnaglaze@google.com"
	<dionnaglaze@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "mikko.ylinen@linux.intel.com"
	<mikko.ylinen@linux.intel.com>, "dan.middleton@linux.intel.com"
	<dan.middleton@linux.intel.com>
Subject: Re: [PATCH v2 1/4] tsm: Add TVM Measurement Register support
Thread-Topic: [PATCH v2 1/4] tsm: Add TVM Measurement Register support
Thread-Index: AQHbhmtS+wnlBv+r+0+BoP5y9+oL1bNlXyIA
Date: Thu, 6 Mar 2025 01:20:52 +0000
Message-ID: <8e3736c1a0b650179dab177feafdef1a596f81c7.camel@intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
	 <20250223-tdx-rtmr-v2-1-f2d85b0a5f94@intel.com>
In-Reply-To: <20250223-tdx-rtmr-v2-1-f2d85b0a5f94@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA0PR11MB4719:EE_
x-ms-office365-filtering-correlation-id: 897984d1-6c2c-4157-438b-08dd5c4d22cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?U3lpTU5BQldOMzlxT3JmWnhZcTZHdU5IZ2VLRjZqaXdiVTNMbU9heldWQ3NF?=
 =?utf-8?B?djM2bUtodVJBOE5ZTXNMTHl3T0RWSUw3SSt3NUl0WmVVSVVya3lxdXB5MXVV?=
 =?utf-8?B?UmJFaXUwZHN3WTY4b20zdVdnbVpkbW9NNVZFZ2J6ZnN4Z1VBK1pVSHpnTnZm?=
 =?utf-8?B?d2ZkeHBGbmYzSjhlNzJtVlI5eEx2VE5yYWNWWG9oWkNpZUszTnRacmtUM2Vu?=
 =?utf-8?B?VHpadFdTN3V3TnpUZHlMNFFnY3lvVm1YaW9PMG53RmJodFJuQ25hYnBEVXgv?=
 =?utf-8?B?SC8rYS85SEdVd2RDVVk5U2FjcGFDenJmUktUZlFZVkQ3eUNjTVpCaEZqKy9w?=
 =?utf-8?B?SDZDdDFVZVZtRnY3UWhtT2FUY1FLRmw1eTZHa3FZcGN5YS9WM2pJRTFUY1ph?=
 =?utf-8?B?emMzalNtMWhIN3VlcHV1clYrcWQwZzBpZThyOFVKOUt6QWFJekpqbjRXS2JH?=
 =?utf-8?B?UXFvS3VmYm1IM1ZVdDZYK2FzU21xOUF2TGVGSE13V3RWV1lETUU3R1dPVlAv?=
 =?utf-8?B?Z0ZHUVduTm4vRjRyOVVEYUpiYTN1c3JNVEpEUUt6L0tVR0ZIdmdkNWhUa0kx?=
 =?utf-8?B?b0t1a3ZJVmtueFpyRFVaTVRLTnM1b3dnT2VyaCtpclhpUUhCcUJlcFVOSThP?=
 =?utf-8?B?U282c1FmQmRhSXpNZkNRby9pTCtMdis3RVArUXZ0blFEeFdtbzZQNWd2Nldy?=
 =?utf-8?B?TzAwTWxKdm1ueGV2L21Xd3hsQ0RzYVBJd0U0RGhkVjBYMDhzcUlIajlqR1dJ?=
 =?utf-8?B?RjNnMjhueUpYdmk2WkJ6bzlvVDNLSitYMjFxYlNxc3p2VXkzcHpPbXF4bXJI?=
 =?utf-8?B?TkZQVVNhTmc1NnYzWHdXNXEvRWJpVEZFaWlUcThOdmxIV3dpdmVEeDVqWGZ3?=
 =?utf-8?B?TlRsSklWZ2lRYTJuOU1Wa3c1akh5SXYrdE5QZHNyaXJob3V2OW0yYmgvRWMw?=
 =?utf-8?B?aFNVQ1NxRHBCdHY1c2VQZTVkS2dhdUFKYVAzenhXVWt6ZEx1ck5sdUJxT2No?=
 =?utf-8?B?b2FVSlhjWGRiK2xDaDNraFZTMUhlb1JLWVdYTzc4NXdEOEVkWjVGdGpyckt6?=
 =?utf-8?B?UnZnM0VzOSt6TW4wOE1IdUlIUnc1WDR6UlQ3L29VMWRycVpVVWV6ZHM5RVha?=
 =?utf-8?B?b0VXdWZYUVJoT3h5OWlvc0JWaUdMVXRCM2dlbVNpci9TL2NENWpSVU5UWkd1?=
 =?utf-8?B?akRJTWhqT0dIMjJwR2F0NW1wOGxOTEZMRWF2NCszZHhuSUlYN0tXMFhBSFVC?=
 =?utf-8?B?S2M0TmVGSUcwMlliZVFJUEE2R0JQRGtxdlp3c2lCMUt2TUlCY2hubWVqSUVV?=
 =?utf-8?B?RVRicFI0Yi9jOGJGZ3NJUEJiald2Sk5Ybnh0MXpvdHBpekFmdlpuaGVYNFBZ?=
 =?utf-8?B?a1Q0MVRRRSs0OEJxR3VUQ0JhTjNQZkZsOXU5eUsrYnVTeUVwZXBNZ2k0cEto?=
 =?utf-8?B?U2tVay9OOTBLa2tYK1NzdUxiZm43ZW1CSjM4V1VBcHZuY1RiTkpZaGJHeDhI?=
 =?utf-8?B?ZzRQQU5DRWRHaS9janlYR1JEQzlvWFJrM2ljdUFwQkVLVm1YaXZqVWdhd2Fi?=
 =?utf-8?B?VUhYbTg3WHVDbmppeVdIeFJyY3NVWEdIeFkwYVB4RWlCbXhKSVY5cjhySUJT?=
 =?utf-8?B?d1RpN2NvRlFMVGlLRHkrVFJuNUVEbEhiM08ydXZpRm8rNzRpMlJkaFloYTlR?=
 =?utf-8?B?YmJPR1FLT3B0TUF2T3lWVjJHUVQ0WUxFekxtN2M2Tnk4NlhBS3BFbTljSXZU?=
 =?utf-8?B?MVUreWd2Q2pFc2xGR0dESnYxVk9VWmorbHNJUHNmQjRjTXcvTTZiNm14TFBV?=
 =?utf-8?B?ZTE3NFJvZUs4Q21XbHpCeXZ1OTVuRCswUC9pbGtFZXJqa3Z5RmdrWlIvY2ZG?=
 =?utf-8?B?ZzlQajg1bzNJaXRkV1k0VzQ2bTdMbzJXb3JQWk1pcDgrdW0xcmh1OEhKaW1T?=
 =?utf-8?B?VmFYRUZXMUdkMVlFU3VGY2FLeVZxc29aRXlKcDV1QU5QWWFGRW1nZjc3STBM?=
 =?utf-8?B?RXRUck0xY29RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGkzM00zTEJDcEpJQlp1dGp6RDFya0hacDVrWHo0alRHNXUvaytzZS83aEVE?=
 =?utf-8?B?MXo2Y1J0Zks3L2FqN2FtZ1pqVGJ6LzJMTTZOcVhuQktFcVVTNVZpTWFGcW1w?=
 =?utf-8?B?Rm9MODdXTlRrVkpNNVkweUlhMGpmYzk2TG9PZ2ZxTzBBNG9ZZ2ovTEFvUlIz?=
 =?utf-8?B?c0ZBUm5QZVlpMm5FR2lqWExHMldvSHorQmtMWEdZci9qQmhDcmhhMWEreGFl?=
 =?utf-8?B?VzBDMzlUNFhqOHJibG9SbXdmYjFGdEVPT3ppeStIQTQxSGdMeEtnNHhvT1Jq?=
 =?utf-8?B?OWRrbWZZVUowM0E2ZEdJbm42U0FYbVhoVi9OdTZkSzlleGFRTjJNVEpmM3dH?=
 =?utf-8?B?Z0dnVUxNNVorbkhkUVR3Z1hJYUd1R01VOW9QN2ozdXRsQUtXWEpUUHI0UWZq?=
 =?utf-8?B?ZE50RXZHZ2xuOTRnbFVSbFYxZ2VTNkVSN3duOU1ZSVNBcmlnUUd0bkJTcTFP?=
 =?utf-8?B?cURaV2trWW8rQkZxaExjZ05PM2dDeGpyZ2p2TEZWZ3FuV0ZZSUtabytheThS?=
 =?utf-8?B?d0xMYWpucXpnNWJyZjNnb0F3WUd2cFpQYXBxejIxNTBhSkxVeGtCUFVUcE55?=
 =?utf-8?B?ajFBSnhQM1poLzF2N3hxTll5WDhWcmFRb3RMOVNUQW05Z3VsZk1QcnpIUDdr?=
 =?utf-8?B?VW5zUnRoRldKcE1xbXJuNTI3SGp2MUpNNFF4ZHFrNHd3NXArcGFEc2hka2VT?=
 =?utf-8?B?MWJQSEk2Y3o0OXNoaUhDNVkvbUF5Q0lIWHgzdzg3eDE2KzlDRlhvMXBxZ21S?=
 =?utf-8?B?V0JRNlU5RUppbDdsS2d4cmpVWDY2TVZjakFrazc3RzBtVVJ5d3ZFaGZMc0tH?=
 =?utf-8?B?cGJQR3h4VzlzUk0xaEtzL2xSS2VjdXF1NlFTa3pTK2pwNWdQdEdoU1dPNndY?=
 =?utf-8?B?MFBGRGt5elhJeVlmVmkvajV5bU5sMGNkZFJ1QkZscGZLSHZCZ2s3R0JwZUM4?=
 =?utf-8?B?bCtqMHV1RnE0UXFEeUwySWpjN1AybWlEWDk1RDBLd2dHL0RSUnBBRDFaY0Fr?=
 =?utf-8?B?cS9CeGhZQ2lCNkxEMm8rN091TWpxMVkwQUJ0Z202M3hsdnZ6U0RiVU5wajRY?=
 =?utf-8?B?UTZiMFRHRmdvek5PeDg0SDgrQVJxNlIxZmtRdlg4OU5PK2Jtemo2RysybWtp?=
 =?utf-8?B?MVhaQzJQOWdmYlZhK3AvUCs0NFVIQ21RVXk5SmkzclJqcld2RGNSWTRxM3lX?=
 =?utf-8?B?RTNMVFQxSUpZUXJDVS8yenRZSXcxcURpSFFXUU9wLzY0U3ovRm9zN25WWFVW?=
 =?utf-8?B?a1lTYVRCWDRzRmRydThCS3ROV3FRaTdnU3hwc1AvZmp0YVlvNGxveEZ2SjlY?=
 =?utf-8?B?dS9jbnRqZlRVL3NmcUVEQ2ZFT0FaTEJlelJaOXBVM3BVbVV2K3Q2MGMwS0RR?=
 =?utf-8?B?ZmxMVnB0cWpLVzc5RmVwQWxwejRTREozN0hvRzVmNDh3VGJva3BaaW9EYjNG?=
 =?utf-8?B?cElVOVB5bklpdk1VcW4xa3lheUJlSUxHNTBaS3dKMTY1OHdzWDlEVUdRM2c3?=
 =?utf-8?B?UlBDZXVJZUpuT2pIdFNhbG1Kd3Q1c2U2UmoxaXU0djMwOWdvcC9QV3ZUWGtl?=
 =?utf-8?B?WVRiQ1AzcFZMOXBuNUJWUmsvMGM4Y3NQc1VEbHNrTFBPTk5EY2htVXdPU2ta?=
 =?utf-8?B?RTVTTHQwaTZHQi9TNW50OUtvYXFVZURRa2c5WUhxdFllbEw0R2VJM0tkcFI0?=
 =?utf-8?B?Wi8xcFdDMnhsZ3lvdExzRTF6UzZlM1IrTEpnZ1lyMW11ekIwVXdWVkJwcElT?=
 =?utf-8?B?Q2ptbXovR21DUTVRSnlaTDdvTEpGWWZUdDNaZUJKcTUvSS9Cc0pZZ3ZzcWVX?=
 =?utf-8?B?b1AwMldMVGpsZWt5SDNQV05zek1jRWNsN01IOTJyOG84RUQraFczRjgzUEpi?=
 =?utf-8?B?ckJPd0lDUTQ3amxhWlFleVBvNFhhQ0FDU0xhSWxVWCtFcVlmTDhsazg1d1VU?=
 =?utf-8?B?c1Z0VEJKZVFwYXNoRVFjazZ3UEtqaXFyNThVSU1kMlB3ZUpoeTJHNVhYRTRJ?=
 =?utf-8?B?TWVkdERjaG02YXBsVTg4Q01DYjg5ZWZ1OXJOR1dhYzlPRSsxT0l3aDdHV3JJ?=
 =?utf-8?B?TGNWN1lEdmd0dFV6c25SNmg5R0c3bVZJUm1QdjRremlIYnZWU054ZFg2S2NI?=
 =?utf-8?Q?UxH2Md6+IwDDeqUUfxHOEYsf6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D63231BB78D75B43AD92FC2CF79885B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897984d1-6c2c-4157-438b-08dd5c4d22cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 01:20:52.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hw3gJVANHT8kZab3MruglbHg6Ktf/RxhTxost8Z6UwjWZvNaVWk0N839TXBxr9VnfmaCCphsUC9IUOUbDh/4Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4719
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI1LTAyLTIzIGF0IDIxOjIwIC0wNjAwLCBDZWRyaWMgWGluZyB3cm90ZToNCj4g
QWRkIG5ldyBUU00gQVBJcyBmb3IgVFZNIGd1ZXN0IGRyaXZlcnMgdG8gcmVnaXN0ZXIgYW5kIGV4
cG9zZSBtZWFzdXJlbWVudA0KPiByZWdpc3RlcnMgKE1ScykgYXMgc3lzZnMgYXR0cmlidXRlcyAo
ZmlsZXMpLg0KDQpIaSBDZWRyaWMsDQoNClRoZSBjdXJyZW50IFRTTSBpcyBkb25lIGluIGNvbmZp
Z2ZzLCBidXQgbm90IHN5c2ZzLiAgVGhlIHJlYXNvbiwgcXVvdGVkIGZyb20NCmNvbW1pdCA3MGU2
ZjdlMmI5ODU3ICgiY29uZmlnZnMtdHNtOiBJbnRyb2R1Y2UgYSBzaGFyZWQgQUJJIGZvciBhdHRl
c3RhdGlvbg0KcmVwb3J0cyIpLCBpczoNCg0KICAgIFJldmlldyBvZiBwcmV2aW91cyBpdGVyYXRp
b25zIG9mIHRoaXMgaW50ZXJmYWNlIGlkZW50aWZpZWQgdGhhdCB0aGVyZSBpcw0KICAgIGEgbmVl
ZCB0byBzY2FsZSByZXBvcnQgZ2VuZXJhdGlvbiBmb3IgbXVsdGlwbGUgY29udGFpbmVyIGVudmly
b25tZW50cw0KICAgIFsyXS4gQ29uZmlnZnMgZW5hYmxlcyBhIG1vZGVsIHdoZXJlIGVhY2ggY29u
dGFpbmVyIGNhbiBiaW5kIG1vdW50IG9uZSBvcg0KICAgIG1vcmUgcmVwb3J0IGdlbmVyYXRpb24g
aXRlbSBpbnN0YW5jZXMuIFN0aWxsLCB3aXRoaW4gYSBjb250YWluZXIgb25seSBhDQogICAgc2lu
Z2xlIHRocmVhZCBjYW4gYmUgbWFuaXB1bGF0aW5nIGEgZ2l2ZW4gY29uZmlndXJhdGlvbiBpbnN0
YW5jZSBhdCBhDQogICAgdGltZS4gQSAnZ2VuZXJhdGlvbicgY291bnQgaXMgcHJvdmlkZWQgdG8g
ZGV0ZWN0IGNvbmZsaWN0cyBiZXR3ZWVuDQogICAgbXVsdGlwbGUgdGhyZWFkcyByYWNpbmcgdG8g
Y29uZmlndXJlIGEgcmVwb3J0IGluc3RhbmNlLg0KDQpBbmQgdGhlIGxpbmsgWzJdICh3aGVyZSB5
b3UgY2FuIGZpbmQgdGhlIHJlbGV2YW50IGRpc2N1c3Npb24pIGlzOg0KDQpodHRwOi8vbG9yZS5r
ZXJuZWwub3JnL3IvNTdmM2EwNWUtOGZjZC00NjU2LWJlZWEtNTZiYjgzNjVhZTY0QGxpbnV4Lm1p
Y3Jvc29mdC5jb20NCg0KQ291bGQgeW91IGVsYWJvcmF0ZSB3aHkgZG8geW91IGNob29zZSB0byBl
eHBvc2UgTVJzIHZpYSBzeXNmcyByYXRoZXIgdGhhbg0KY29uZmlnZnM/ICBJcyB0aGUgYWJvdmUg
cmVhc29uIG5vdCB2YWxpZCBhbnltb3JlPw0KDQoNCj4gDQo+IE5ldyBUU00gQVBJczoNCj4gDQo+
IC0gYHRzbV9yZWdpc3Rlcl9tZWFzdXJlbWVudChzdHJ1Y3QgdHNtX21lYXN1cmVtZW50ICopYDog
UmVnaXN0ZXIgYSBzZXQgb2YNCj4gwqAgTVJzIHdpdGggdGhlIFRTTSBjb3JlLg0KPiAtIGB0c21f
dW5yZWdpc3Rlcl9tZWFzdXJlbWVudChzdHJ1Y3QgdHNtX21lYXN1cmVtZW50ICopYDogVW5yZWdp
c3RlciBhDQo+IMKgIHByZXZpb3VzbHkgcmVnaXN0ZXJlZCBzZXQgb2YgTVJzLg0KPiANCj4gVGhl
c2UgQVBJcyBhcmUgY2VudGVyZWQgYXJvdW5kIGBzdHJ1Y3QgdHNtX21lYXN1cmVtZW50YCwgd2hp
Y2ggaW5jbHVkZXMgYW4NCj4gYXJyYXkgb2YgYHN0cnVjdCB0c21fbWVhc3VyZW1lbnRfcmVnaXN0
ZXJgcyB3aXRoIHByb3BlcnRpZXMNCj4gKGB0c21fbWVhc3VyZW1lbnRfcmVnaXN0ZXI6Om1yX2Zs
YWdzYCkgbGlrZSAqUmVhZGFibGUqIChgVFNNX01SX0ZfUmApIGFuZA0KPiAqRXh0ZW5zaWJsZSog
KGBUU01fTVJfRl9YYCkuIEZvciBkZXRhaWxzLCBzZWUgaW5jbHVkZS9saW51eC90c20uaC4NCg0K
Tml0Og0KDQpXZSBjYW4gc2VlIHRob3NlIGRldGFpbHMgZnJvbSB0aGUgY29kZS4gIFBlcnNvbmFs
bHkgSSB0aGluayB5b3UgZG9uJ3QgbmVlZCB0bw0KZGVzY3JpYmUgdGhlbSBhZ2FpbiBpbiB0aGUg
Y2hhbmdlbG9nLiAgSXQgd291bGQgYmUgbW9yZSBoZWxwZnVsIGlmIHlvdSBjb3VsZCBwdXQNCm1v
cmUgX3doeV8gaGVyZS4NCg0KRS5nLiwgV3doYXQgaXMgdXNlcnNwYWNlJ3MgcmVxdWlyZW1lbnQv
ZmxvdyB0aGF0IGludm9sdmVzIHJlYWRpbmcvZXh0ZW5kaW5nDQp0aG9zZSBNUnM/ICBBbiBleGFt
cGxlIGlzIGV2ZW4gYmV0dGVyLg0KDQo+IA0KPiBVcG9uIHN1Y2Nlc3NmdWwgcmVnaXN0cmF0aW9u
LCB0aGUgVFNNIGNvcmUgZXhwb3NlcyBNUnMgaW4gc3lzZnMgYXQNCj4gL3N5cy9rZXJuZWwvdHNt
L01SX1BST1ZJREVSLywgd2hlcmUgTVJfUFJPVklERVIgaXMgdGhlIG1lYXN1cmVtZW50DQo+IHBy
b3ZpZGVyJ3MgbmFtZSAoYHRzbV9tZWFzdXJlbWVudDo6bmFtZWApLiBFYWNoIE1SIGlzIGFjY2Vz
c2libGUgZWl0aGVyIGFzDQo+IGEgZmlsZSAoL3N5cy9rZXJuZWwvdHNtL01SX1BST1ZJREVSL01S
X05BTUUgY29udGFpbnMgdGhlIE1SIHZhbHVlKSBvciBhDQo+IGRpcmVjdG9yeSAoL3N5cy9rZXJu
ZWwvdHNtL01SX1BST1ZJREVSL01SX05BTUUvSEFTSC9kaWdlc3QgY29udGFpbnMgdGhlIE1SDQo+
IHZhbHVlKSBkZXBlbmRpbmcgb24gd2hldGhlciBgVFNNX01SX0ZfRmAgaXMgc2V0IG9yIGNsZWFy
ZWQgKGluDQo+IGB0c21fbWVhc3VyZW1lbnRfcmVnaXN0ZXI6Om1yX2ZsYWdzYCkuIE1SX05BTUUg
aXMgdGhlIG5hbWUNCj4gKGB0c21fbWVhc3VyZW1lbnRfcmVnaXN0ZXI6Om1yX25hbWVgKSBvZiB0
aGUgTVIsIHdoaWxlIEhBU0ggaXMgdGhlIGhhc2gNCj4gYWxnb3JpdGhtIChgdHNtX21lYXN1cmVt
ZW50X3JlZ2lzdGVyOjptcl9oYXNoYCkgbmFtZSBpbiB0aGUgbGF0dGVyIGNhc2UuDQoNClBsZWFz
ZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3Jvbmc6IGluIG15IHVuZGVyc3RhbmRpbmcsIHRoZSBwdXJw
b3NlIGlzIHRvIHByb3ZpZGUNCmEgInVuaWZpZWQgQUJJIGZvciB1c3JzcGFjZSIgZm9yIE1Scywg
YnV0IG5vdCBqdXN0IHNvbWUgY29tbW9uIGluZnJhc3RydWN0dXJlIGluDQp0aGUga2VybmVsIHRv
IHN1cHBvcnQgZXhwb3NpbmcgTVJzLCByaWdodD8NCg0KQ29uZmlnZnMtdHNtIHByb3ZpZGVzIGNv
bnNpc3RlbnQgbmFtZXMgZm9yIGFsbCBhdHRyaWJ1dGVzIGZvciBhbGwgdmVuZG9yczoNCidpbmJs
b2InLCAnb3V0YmxvYicsICdnZW5lcmF0aW9uJywgJ3Byb3ZpZGVyJyBldGMsIHNvIGl0IHByb3Zp
ZGVzIGEgdW5pZmllZCBBQkkNCmZvciB1c2Vyc3BhY2UuDQoNCkJ1dCBoZXJlIGFjdHVhbGx5IGVh
Y2ggdmVuZG9yIHdpbGwgaGF2ZSBpdHMgb3duIGRpcmVjdG9yeS4gIEUuZy4sIGZvciBURFggd2UN
CmhhdmU6DQoNCgkvc3lzL2tlcm5lbC90c20vdGR4Ly4uLg0KDQpBbmQgdGhlIGFjdHVhbCBNUnMg
dW5kZXIgdGhlIHZlbmRvci1zcGVjaWZpYyBkaXJlY3RvcnkgYXJlIGNvbXBsZXRlbHkgdmVuZG9y
LQ0Kc3BlY2lmaWMuICBFLmcuLCBhcyBzaG93biBpbiB0aGUgbGFzdCBwYXRjaCwgZm9yIFREWCB3
ZSBoYXZlOiBtcmNvbmZpZ2lkLA0KbXJvd25lciBldGMuICBBbmQgZm9yIG90aGVyIHZlbmRvcnMg
dGhleSBhcmUgZnJlZSB0byByZWdpc3RlciBNUnMgb24gdGhlaXIgb3duLg0KDQpDb3VsZCB5b3Ug
ZWxhYm9yYXRlIGhvdyB1c2Vyc3BhY2UgaXMgc3VwcG9zZWQgdG8gdXNlIHRob3NlIE1ScyBpbiBh
IGNvbW1vbiB3YXk/DQrCoA0KT3IgdGhpcyBpcyBub3QgdGhlIHB1cnBvc2U/DQoNCj4gDQo+ICpD
cnlwdG8gQWdpbGl0eSogaXMgc3VwcG9ydGVkIGJ5IG1lcmdpbmcgaW5kZXBlbmRlbnQgTVJzIHdp
dGggYSBjb21tb24gbmFtZQ0KPiBpbnRvIGEgc2luZ2xlIGRpcmVjdG9yeSwgZWFjaCByZXByZXNl
bnRlZCBieSBpdHMgSEFTSC9kaWdlc3QgZmlsZS4gTm90ZQ0KPiB0aGF0IEhBU0ggbXVzdCBiZSBk
aXN0aW5jdCBvciBiZWhhdmlvciBpcyB1bmRlZmluZWQuDQoNCkRpdHRvLiAgSSB0aGluayBpdCB3
b3VsZCBiZSBtb3JlIGhlbHBmdWwgaWYgeW91IGNhbiBwcm92aWRlIF93aHlfIHdlIG5lZWQgdG8N
CnN1cHBvcnQgY3J5cHRvIGFnaWxpdHkgcmF0aGVyIHRoYW4gX2hvd18gaXMgaXQgaW1wbGVtZW50
ZWQsIHdoaWNoIGNhbiBiZSBzZWVuDQpmcm9tIHRoZSBhY3R1YWwgY29kZS4gIE9uY2UgbWVyZ2Vk
LCB0aGUgX3doeV8gd2lsbCBiZSBoZWxwZnVsIHdoZW4gc29tZSByYW5kb20NCmd1eSBpbiB0aGUg
ZnV0dXJlIHRyaWVzIHRvIGdpdCBibGFtZSBhbmQgZmlndXJlIG91dCB0aGUgc3RvcnkgYmVoaW5k
Lg0KDQo=

