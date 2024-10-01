Return-Path: <linux-kernel+bounces-346737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6698C82E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171591F247B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029931CCB51;
	Tue,  1 Oct 2024 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZgk66M3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB3119CCF4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821393; cv=fail; b=DIEOET9et6IId8Adh8QImYX3Ch3pltPHkAEbqe+TjA3rvzkeXNwsUQJRONRwZwjpH5jb5PaduYQfyzsAz7ld8fYi8HKg2NU+ySYBzWtNHcv5EZIzgsiEOMsjIPhaCRR4tYliLagoIqyN0vczsOlCGptlNrZKCs8g5+vxmR6DQlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821393; c=relaxed/simple;
	bh=bdD+9qaUXkXvrGwqNWfaSaOr53VOE5KkhumtZmujeIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZA328d3fgy+VDjBsEZlqrLyDqAumdhLtFi32RMym87HExosUrU/ji2E0f39OKch6zE0l+ga77OQ6ZQPSWVMv0Mz5ZKacw3LW9gj0BrIl23KzEpOdNe8ncOCvhjzmwQBXl36SZ0hsSIODWA1TO3Um1HmR+l56dAOdrtSPvdW5JsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZgk66M3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727821390; x=1759357390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bdD+9qaUXkXvrGwqNWfaSaOr53VOE5KkhumtZmujeIQ=;
  b=aZgk66M3mwzDO9T5la9YvtWrplrQu+2URvNNSoxC+QHevGqKobbtBM19
   oVejm1HIAhv1hyRchtvcFpmPneqENeGUVClKCIxVwVdBsJ3n4B3z3Q4BN
   GDJ5gF+lp5l8QMBXLqmnq8z9q5BRRFPXEOn6Dq8ABUmLBj0s7rxosl8rY
   TWCB5nde/LnnY7nsWctSc/SJdAck7gpwI0fcRixjIY9dBp+M3Uj+CwIsn
   5z9U/Ruwk204DPOO7drK4WKdh+XHnGbXPiAidPR4KX+xdPrrCoC49+gjS
   UqWCTSpGOB3rpSTCzjGM4SD6iTfGVadR9gQTcEFcabcJ2PBmdzj03wwY8
   g==;
X-CSE-ConnectionGUID: /S40BG6jSqyjvhqRu6ZIIA==
X-CSE-MsgGUID: +OUwjb14RT2Z9JS0dPFA5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27073067"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27073067"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 15:23:10 -0700
X-CSE-ConnectionGUID: 2V45kwU/TBmg82uDYfbD0g==
X-CSE-MsgGUID: OUk0whrQTsyuXltl3XK0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73845485"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 15:23:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 15:23:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 15:23:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 15:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G97WHdGyOThYZFlk8DGg2k2zOSNvXU7S7EKYcBdeBCOVWrdLqzVh4jso6Zj38iLNGjPiXJcnZvA0/DAcWdtj1iTYHNUAkc+vXF+WmVc5Y/Pqz76eSnyKoE7vvs2n28OvcWh3MTVBq0CvK8S11p3fTNKa7nQiVJG7q/SF9+cPGe4eYSKFMmWdsggSUL+1gw/btdrQmiTYhF0TabcOdBjaj66T6ONgpfcWVxzDn7jgYD3BP+mkpH2TRlLC8AeW/lFEd26sMtoJjHRT+E4ineKaf1zg0k1EXwSOrRGESVQDmnYUUjtdghxbPlkxj2JicWIAlXrSEHzxIYb7/ewZyVMdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqyzg+JHw+XSMs1gyTdCnM5ktPoZojqUFcWZosM3tOM=;
 b=WJbxI8JCLZqHTPRNQf7KxbbLcmbnJjJ2ZO3pibcQJhrkCKa+SpYEEJR5/V+rY1JGvL2mQHaz9MoTdbvmCxCDIhIjQYEr52kchW09eaRrqauQwbFXAT4YdbAZLASXJSbk0QrNP9ynfwqNC6KPMQhKg4imDWfMAJiCBVRugvKrGb/VfDMJyHKiQsTbYt5RorujxYFcBh5nANTfMCzr4c4mpGeVUcuaNhYpnfVCe6HpHK1F9OTlMv17v2UULYqpXgUGthzBXknJ0fJGKKiv88AFUKTWM+lXb0GpScSkpHy+HxHy7R6//Ob2BYuBQ8mlexQ+6E3a3OzZXlDouIYeDos16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 22:23:05 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 22:23:05 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v10 6/7] mm: zswap: Support large folios in
 zswap_store().
Thread-Index: AQHbE8NS/mzK7ddAdUGteugGSqw7kLJxvZiAgABpsICAAFGeIA==
Date: Tue, 1 Oct 2024 22:23:05 +0000
Message-ID: <SJ0PR11MB5678B31EAB3325893AF28CFCC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
 <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
 <20241001111045.GA1003400@cmpxchg.org>
 <SJ0PR11MB5678A8B0774E6742AD68F8A1C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678A8B0774E6742AD68F8A1C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CO1PR11MB4882:EE_
x-ms-office365-filtering-correlation-id: 350508c0-9ac3-4313-fb52-08dce2679ea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4CPnL1wD+b+KFHc9vKi7a6Ng9a9Bg+JF5pQCK4u8UFa9llnkqV91MC8DObsm?=
 =?us-ascii?Q?a7OewZ8aFEvpNz90tNzOTR+4H2e2ASpqoVyLgwv85rqvTbdsvzQlh9I0Gv4j?=
 =?us-ascii?Q?bOupHHs8iaZOW0IYUwDqWzM8Zv45tp5huK9jZSkkB12tCgBqNDIxGgcY10rx?=
 =?us-ascii?Q?JlemluR94nVRpygxQ/7Cq250Mt9VC5Z/9KfWUyTQyXPeIqaHvzD3no/k5tdD?=
 =?us-ascii?Q?GIDfiBJ/TlWMTVZkadt2eprcSRKB05y+Csga37V66K8KyP68sI1KTUyl2p/x?=
 =?us-ascii?Q?gdHdWPJ5qVvJJTcgLXXoGyFfzHfv/2xYL8kgW+UU+fFZr9T+hPfGmoo0uyH+?=
 =?us-ascii?Q?cN8PM6VCmxcMPM2H2iWPAVJcijUvl6OdFlHZ8Su1hhUOSK4J47uNjObll8UU?=
 =?us-ascii?Q?Alx0Vm4opgfS0q595BJ5mX40eabmLK4JANRj2Z43BSN41rk8C6/MHdD4De8u?=
 =?us-ascii?Q?/ETZRiK/fV+SXuMyne6YuVjg4xSooDd4M+LHJlXPhSf2Km04OUp/kBZH6/+5?=
 =?us-ascii?Q?bOsKlQC6IjKFlDfrHqeIOU0H99PMQIUQa8kPuSbqJPW2iFQqRaCpt7d9r3qT?=
 =?us-ascii?Q?5pd/hm84aPdYmnw1EfDuJGVSQhHPR+t+jDiTq/t3J0xQhcCEH956yn4kn86a?=
 =?us-ascii?Q?ITmrviP1htcl3sA+sKLK8ccRVmz4fEguiPvYYiRv7qJ/M5UUZCa/+sRDhDg9?=
 =?us-ascii?Q?p0wpFMAPhwLi1HnFNte2Kp6UVgCaDBgTC4maZbUj2EISyPtnrY//piku9hp3?=
 =?us-ascii?Q?8k9xVXEf2ucyvKWgbkuYHk8gb7s8TkfaE8AcdPh47pdur5Ng3BBmCubzn6tm?=
 =?us-ascii?Q?j2P5Uc8tmWOtM2MmYdivAHprixN0oBzqJjYgv4s73n9PnGou2AfetOonpNWl?=
 =?us-ascii?Q?OcgYWCl46Wsq2+kLOPUYlFTefN1ijR0J8Vp+QtRfVmQJgadFCs5KddGl0mPY?=
 =?us-ascii?Q?8Jf8bKPNecWZRZLmhsyU4qfi96BHhpEUNmI+TdgzC96idN+4djNn7pqFFTIM?=
 =?us-ascii?Q?QBcjqzmi5OFA0O23jI/A7pUj7tlMekODSG1Xi1fQcMuL5WeC4BNFtl6Pt2Tw?=
 =?us-ascii?Q?3nL0DMoU5w/V0+wbb0INkWgoHZhWRATfrt3hOkl2399P6O7Bn/cxNGERS0yg?=
 =?us-ascii?Q?mraMA6WR89z/QSUzAcIrnKZWZh9Kj15hZdiNdCYSq2g3aoBZOs+dIG+wkWLi?=
 =?us-ascii?Q?2DyU8VXRY7D6ET657WdrXmagj2sl8FhbDdZUtvUoz15aUKQXvHD9o+8QZZmv?=
 =?us-ascii?Q?SsRS6lTh7jz3pIzN8oBy8dNsdvKZyq4+GOu3C086dxcPqJczhGpfgYNsPYK8?=
 =?us-ascii?Q?lf0pbnG7v/6HFOdUoLnAd5jE7/JJ14JNQCGHKhaCrrWYYpbQA9/yqcNlWaAX?=
 =?us-ascii?Q?urF2vcItoq6KNk+ji4J99r+zQORnc8RW6oQFx8UTIHRibdIskgXxsPpyrWTx?=
 =?us-ascii?Q?q09bNHg5sQU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YysnpG4Obcz2CXq4asB8JLqcsEquGpkpESzIRc4+OgyQ9WckN72hIFlbRSyb?=
 =?us-ascii?Q?WrZmduyduMbZ4K0eVzqslMrYkPZlSBpKij4j3g5Rqj68cCPAhdRE/uNYNqXA?=
 =?us-ascii?Q?quqenL507+gRbv/76Own4uacR7/q3JGlCNQv+25i+jpEmTVqaGVdQxiC00hL?=
 =?us-ascii?Q?QEOM3SBIr+YRUF+iHS9U5M8+kRkS7f75oCU88AcjhWrBXl6xkNsx+VIpOjur?=
 =?us-ascii?Q?beUSTncfmNQ4o10UozYi3+IY5UavQoUAoaLpuplAk83+d0E1l7bq0oKiTgPO?=
 =?us-ascii?Q?9HwakWD4T2eZdcoZykkoEOO2wxFpezlhkYcW+Xu7x8FOI6A5XNLkshisyWs1?=
 =?us-ascii?Q?Q2e6K6lUfx1gHTB5mfKiONr5TaeUNUpYGDsOq82b8MFjaeUk7Fo5BhNYmaBB?=
 =?us-ascii?Q?zIjzf9pBZVEUG/OiqiBTV2eTSmyEkfZ4aTWLlomr1AH7OerDeSwbhTA16I6y?=
 =?us-ascii?Q?TSxzajlqssIG8xUXsgFD0n09lf0y584cnHAACEsTP7TPaM9JwUurHuMzpA8m?=
 =?us-ascii?Q?63CpaFhVaV+uDTUmfWhTcQ82CxUYdE73nZGpiX2ucWParXmbZjb2Ypcwv+Xr?=
 =?us-ascii?Q?xP0ZeBt6JH+fM7C6QNBz92kEdk4niFCjvOZindZBwgr+4g4D1B/zIr9GDZ0N?=
 =?us-ascii?Q?VjT/ooakAx60Rpl7L8x03KPjzf3NSP/63Sz2hr3Mt5kNoL/rA3CASD5OpyoM?=
 =?us-ascii?Q?kvhXd6WSV5DH6GyEdKakeA2uOSztHQaDuvN84KaaS8CM5k0D0Oe8yWcvvJXu?=
 =?us-ascii?Q?zINeSblIpic8Bq6Vi/kEsTEobR16ditjiDP611Jp92P21C8353f7DctBJNBQ?=
 =?us-ascii?Q?VOK7Q/Mts8MycE7wyw2s/mqcWimBXNqNVyAicy+zfoQlMlnF475KKFJ0hC09?=
 =?us-ascii?Q?rDXwi3oHoCP8xU1h0wa/U6ylLTuZV+Fps7GDiUGqEoICdH5HjDqZd/XnVUK/?=
 =?us-ascii?Q?aEnPcGkkIiiFZWZSuux3b4+qGhBjZ0teEgrTQK/58GBbPKX+XwngtQU6pmH8?=
 =?us-ascii?Q?eT3XIR1r+xJMKXr20iqFGrld9mjjOlJYPuBNfwtSLPFpKQ5PBG/wBLv2iFTi?=
 =?us-ascii?Q?aE72iw8iO3wtCBEX1EjZd66eX5B+eMeJai7NH8RrLGXYBQegG1aRxOgUW0SE?=
 =?us-ascii?Q?kAxOi45W0EIdUXUyJdFB/sTO6ERfWfMUZzHCts+SBqoTzGttl/WJ9I6KrXsQ?=
 =?us-ascii?Q?fyrMlR2sFaWEqn+1H4WR/ZjH8Z2iSGV1BRlpOfuZr7CweQfwDe/EO5AwMAjO?=
 =?us-ascii?Q?VfC6tnwWIovk4rqbEOTZoDHTMuVoDi5LCUPPp0q+1iK8ylwZLCmp3ZzdaRXG?=
 =?us-ascii?Q?NCkp9kK2zy1HYnhBWKU1EDMEFEIRzXGxN4kMrKv6jJRLk3JhYoXCTsshipjL?=
 =?us-ascii?Q?0KNEEhPErRxnxKL5S5rIaFysEidZvRdltgyhdx4jxuao9WoDuT7w2Cex+VN1?=
 =?us-ascii?Q?OUJoOtr+PnqiSODRC7jo86q3XCWGkgYQPCYIKZuymXkgdD373GUsVaQnP8dB?=
 =?us-ascii?Q?Jfu31TaOTi+eaPUxCGEAeuUOyaUWGBX/Vn6a+cYiujnPH77Ol4Dw1xunw6CO?=
 =?us-ascii?Q?TEVaX8jGBNLF4/a5FDXV59ty+wcKLqzZf1BBUlOfCHwAz8goOMuosLCxNDcB?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350508c0-9ac3-4313-fb52-08dce2679ea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 22:23:05.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvUuEzwkCuTQ9/VtKKK/uHJOWcuw1/xEoU+JivkDDdVMLZ2jgpvdF/DJ8sUheeKMdnFiNqak59hb02FFxltWabhaixvqaMDeLok+bBVZjK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Sent: Tuesday, October 1, 2024 10:34 AM
> To: Johannes Weiner <hannes@cmpxchg.org>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> willy@infradead.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>;
> Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Subject: RE: [PATCH v10 6/7] mm: zswap: Support large folios in
> zswap_store().
>=20
> > -----Original Message-----
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Sent: Tuesday, October 1, 2024 4:11 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > yosryahmed@google.com; nphamcs@gmail.com;
> > chengming.zhou@linux.dev; usamaarif642@gmail.com;
> > shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> > <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> foundation.org;
> > willy@infradead.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi=
 K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v10 6/7] mm: zswap: Support large folios in
> > zswap_store().
> >
> > On Mon, Sep 30, 2024 at 10:32:21PM -0700, Kanchana P Sridhar wrote:
> > > zswap_store() will store large folios by compressing them page by pag=
e.
> > >
> > > This patch provides a sequential implementation of storing a large fo=
lio
> > > in zswap_store() by iterating through each page in the folio to compr=
ess
> > > and store it in the zswap zpool.
> > >
> > > zswap_store() calls the newly added zswap_store_page() function for
> each
> > > page in the folio. zswap_store_page() handles compressing and storing
> each
> > > page.
> > >
> > > We check the global and per-cgroup limits once at the beginning of
> > > zswap_store(), and only check that the limit is not reached yet. This=
 is
> > > racy and inaccurate, but it should be sufficient for now. We also obt=
ain
> > > initial references to the relevant objcg and pool to guarantee that
> > > subsequent references can be acquired by zswap_store_page(). A new
> > function
> > > zswap_pool_get() is added to facilitate this.
> > >
> > > If these one-time checks pass, we compress the pages of the folio, wh=
ile
> > > maintaining a running count of compressed bytes for all the folio's p=
ages.
> > > If all pages are successfully compressed and stored, we do the cgroup
> > > zswap charging with the total compressed bytes, and batch update the
> > > zswap_stored_pages atomic/zswpout event stats with folio_nr_pages()
> > once,
> > > before returning from zswap_store().
> > >
> > > If an error is encountered during the store of any page in the folio,
> > > all pages in that folio currently stored in zswap will be invalidated=
.
> > > Thus, a folio is either entirely stored in zswap, or entirely not sto=
red
> > > in zswap.
> > >
> > > The most important value provided by this patch is it enables swappin=
g
> out
> > > large folios to zswap without splitting them. Furthermore, it batches=
 some
> > > operations while doing so (cgroup charging, stats updates).
> > >
> > > This patch also forms the basis for building compress batching of pag=
es in
> > > a large folio in zswap_store() by compressing up to say, 8 pages of t=
he
> > > folio in parallel in hardware using the Intel In-Memory Analytics
> > > Accelerator (Intel IAA).
> > >
> > > This change reuses and adapts the functionality in Ryan Roberts' RFC
> > > patch [1]:
> > >
> > >   "[RFC,v1] mm: zswap: Store large folios without splitting"
> > >
> > >   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
> > ryan.roberts@arm.com/T/#u
> > >
> > > Co-developed-by: Ryan Roberts
> >
> > I would change that to
> >
> > Originally-by: Ryan Roberts <ryan.roberts@arm.com>
> >
> > > Signed-off-by:
> >
> > and drop this for now.
>=20
> Hi Andrew,
>=20
> Just wanted to check if you can make the change from
> "Co-developed-by/Signed-off-by:" to "Originally-by:" to acknowledge
> Ryan Roberts' contribution, when this patch is included in mm-unstable?
>=20
> Please do let me know if it is simpler if I submit a v11 for just this
> specific patch or for the entire series with this change. I will proceed
> based on your recommendation.

Many thanks for adding the "Originally-by:", Andrew! Really appreciate it.

Thanks,
Kanchana

>=20
> Thanks,
> Kanchana
>=20
> >
> > > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>

