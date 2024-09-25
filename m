Return-Path: <linux-kernel+bounces-337879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25DD985095
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9269F284527
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E6243AB3;
	Wed, 25 Sep 2024 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U439ez+a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7ADC125
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727227102; cv=fail; b=t9qkgcgXNa9UHjXmpDn02E+5kwCwLjso+pvPnyF36yZWYcxX9hUe6E0ydZGTgXayt8w0TKBx5fC1tH3IhYXlnQijWkUDnUoOCY3lBeHHxIRjSK9zCnd+TLFeDGhFkAwXXrHSqkGvKS8OpksmCggc+Tq22OTw8pGNJ+KdhMSfZOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727227102; c=relaxed/simple;
	bh=LA0TpwlxxzF0UJEInRRxCmQnzKIbij1Km/iIIqZBjO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JzmsxX3zSVWP7eS9xX6L39HTMuPIhv7KWubENuxDxFTI3ehRGndVNn7ShbXbT9wMgiW1a1n10kPrb+w6b0/h9fWoOd9wc5ZaRrEcGOujMqpw6c6o2r4W28Nvb4UtUEDkDz7QTi3/h8h12iNc8JWth0anHjGLLJg85sOLfxkJkE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U439ez+a; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727227100; x=1758763100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LA0TpwlxxzF0UJEInRRxCmQnzKIbij1Km/iIIqZBjO8=;
  b=U439ez+a6C4V2JAolJPO85qLNwj9HdDMDyoxMa0g2RgTSlcw8et+XdX+
   ycmYB8yAcUDAy6WpnYXaP+8zJEqAQ6iedRxXOFy56e7bH3JDGm9LIHynT
   6FxYMlk4l02owSPDJlNCKXD5pr3UbKbA+5CKyyRPmaIgjkvY4LsD0T5fu
   eO07wZQJV+6zbSllhK94L8NjxGMaxUkjFD1KOPgefOXH+o5CM2l+pqFSa
   WBaUOls2CxXlO7AUI/pn+4zJYZ/KFN6IfQ9FqbHULyvNkKA+pwhvQh2Ez
   unftKaFaMILML5mrmiY2pZwPwTKq9WJU2Zn+KZbK8owbuiMDkZtUdpl+V
   w==;
X-CSE-ConnectionGUID: E2ZQPH/ESSyV3DHYcjjMOA==
X-CSE-MsgGUID: WrH87t9JSfC5GlwwV7C+6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26439602"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26439602"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 18:18:19 -0700
X-CSE-ConnectionGUID: Hsr0L782Sh2BwC5wqm85iw==
X-CSE-MsgGUID: KMyo7TKnShimUVtIhvf5tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71217351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 18:18:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 18:18:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 18:18:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 18:18:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxzBwW94/tXwBePzGFw59ehvrY5Y0MiXFFXU+De7xX/7Yxt7AR1PxgJ8vwl/W+YvA5jpTOvbU8PsTDmEnKO095dh5UfGIIwBlE1nl/sT+Eahr1KXWFSIllTaytCOKJh6955kYUYJCPff7oPxkG8tphGhBXs6TQerbtkyN+JBiGQw5dct3tZrVEhaO9z38G8CwXSjhVGp98lfVCsRvJ4OQbuZ712U22I0MO6t7lhwCR4mYcZ7YvpNc4gCMCt4Y19C4kupCnVBL1qq3Qbw943dQtzGghi9UTiNSgXcSBvz/BRibUg8TCNDX1sSzo05dqLLm+o0H0F4J30rSdqisgtnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA0TpwlxxzF0UJEInRRxCmQnzKIbij1Km/iIIqZBjO8=;
 b=Hu8VsK2SfAfL8iGTIydkp6vObeAiamOrL0EAtyY+jPxLYLN+ji0LQRfpgZ8yhkvrpq+kDAj9mRIOS4xkBYEP+02BPHOialLXU7ND+OqUbW5/NdkkdOd9IAOl6DJd7EDt7jznma5tvo1gFWtAZpqeuU9/c3nNxc0wz6JJoufcmHo4EwInVprIclRSn2meNObdhIMmvao0olkHSJJJRGnL1gkjVEfKxPTa82hzgeRWvzzz9ZvP6Dm/tGSDCNVqvZoaT5hYztM/jY5vgPbHAdF/4HUVqlIZ8TFOR1dR8kMrNZ8fXiiThRJ28DoD8fzhWfUYp6GRr1bYyGg4jOKHpPL9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 01:18:15 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 01:18:15 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Topic: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
Thread-Index: AQHbDh9/7v3nj1Rpsk6L/K4X0ZY53bJnUVKAgAAzI6CAACckAIAACXjQ
Date: Wed, 25 Sep 2024 01:18:15 +0000
Message-ID: <SJ0PR11MB56785A70F28FB3A7B6A644EFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
 <CAJD7tkbdRPKxOoVJMg5XdQuoByE1yuOjEENuM=wDnh_cOQZ7mA@mail.gmail.com>
 <SJ0PR11MB5678E588D9640C92E06AB0A8C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbRewK-L07GPzX6YtBnw7zpA1NboBCEyszoT4=-PvpdYw@mail.gmail.com>
In-Reply-To: <CAJD7tkbRewK-L07GPzX6YtBnw7zpA1NboBCEyszoT4=-PvpdYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS0PR11MB7736:EE_
x-ms-office365-filtering-correlation-id: 3701c03e-e82e-4cb7-b207-08dcdcffeea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YnNGTkxDdlNQRzJYcnZqejBKMEpEYWNzT3lIUDhSZnh1OFBBSFBIUFlDYjZ2?=
 =?utf-8?B?Z3BhSU9nVHdYcW1HQk14eThNMXdQY2pUQVYrZ2kzZ2hUMFNlRGxXUEMydGt6?=
 =?utf-8?B?ZzVGS2hqRnhPUDZoMFV1aXFKWnhTeTFyNDJQNkdKL1FYTFMrMzJJam1oMWhV?=
 =?utf-8?B?Y3AxS3lxbElvVy9udnJyU0l3L0dpZVRwelJxUytyeGVqaVhvNGpXRzg2ZUgy?=
 =?utf-8?B?VVdJKzJxTnVsNVVDYjNFNmhsVk1mbXBMQzhQRFpiSEZDTDNQbDlWR1puOUlU?=
 =?utf-8?B?MFBkeEcvWDBKR1h1d2lUOFFNemJ2b3R4YXlIdytuTlkyakc0a25ieVgyQy9V?=
 =?utf-8?B?ZVU5TXV1WENSbTA0U2lVVDZBUDVNR21rSW1jdlJuWkRXTlUxMHJBZGtvZ1Q1?=
 =?utf-8?B?d284MGxwK0o4Y1NoOVMxT0lnQTNEMkFuQ1lycVdua0dQVjJSaFlvcVh1REpG?=
 =?utf-8?B?YVk1Mzl4QnB2SVh4b25JMWZmSlZPL2xzRjNTNGNxcW4xZkpYdzJUWk9jbTVP?=
 =?utf-8?B?SzdjeUF6dWsrQ0ZiNTdXN3UrZXVlSithQmRFY2hDRFFoZ0ZqMTB1ekprNk1L?=
 =?utf-8?B?SkM4Tm1HYU04NGIwN3ZCMmpKc1lPZStyU3ViUVNKN1ZtZXJJVzQwQ1M2SGdv?=
 =?utf-8?B?QkdxSGJadmx0ZlRrOU5wL3htWmp2Rm8xRVBhNG1vNVVsWk0vb00xT3A5RGFW?=
 =?utf-8?B?dmFMMTdySnlpNkN3Q0U1Q3lPNGpGNENYUUZoaDRZZTVBNTdkU3NyVzlLV0h2?=
 =?utf-8?B?eS90Tm1KT2tNR0FnWXM4UHhnOVM4SVJFMERrWG5Oc2FiWkxjbm5hK2lDMHdI?=
 =?utf-8?B?WkxQRG5naGVDcEdqRUlwMnVrSUJUa3BxUDRMbUthbi9qMXQ0VUxPMytSYTE3?=
 =?utf-8?B?ZFF2WjRuaW1sVjg2SllvKzJGQ21QU2d2cUgyRXFsQmUrZlV6WWtEdVNoNHRV?=
 =?utf-8?B?MFpKMG5pQldrTUVpUE5aRDNsSGVocEJleDVXcWsxL2wvSUs3RTlOT0xIM01E?=
 =?utf-8?B?Q0RVL2tGUzUrcnpXeGx2Y2JkdmtXdTBhQmNRSFVYZTgzVmQ0b3M3RUFKd3dP?=
 =?utf-8?B?dFVxNkExZHE1ejFQUXlPVDlBNDdvRUwvWHhwL1RtY1dkSmdCL2dSRnRuK3Zl?=
 =?utf-8?B?QnJLUlN6ZTRqMDV0dkxvMDBtNVpJVG53dnN2cGY0V1pmZ3JPYTNKM1lYQi9t?=
 =?utf-8?B?WUQwUExJNCtQenV5UzRsQWpZblZPUVZveGJ1RFgxb0RKTjM1RVg5eWhzTi9L?=
 =?utf-8?B?ZlRQWFNPbnNwVkhHT3JlcEhibmhMQm92N015eENHdG9zSExXTlA5KzRqcEN1?=
 =?utf-8?B?bitaM0NHSnU5Zm0rZ1NCdnpCdi9kY05vTUpjK1VLNHhRazFjbnhNdHgxdDFB?=
 =?utf-8?B?emM3VTB3eUk0a1lGdVMwWkl1RS9CU1FidG96d0ptRFh6VGQzSTdKMll1VnFv?=
 =?utf-8?B?VEFHRi82VkVKandCbFAwUHVDVHRDRERWWEtSazdISE1VZUljbk1UN3phRWdn?=
 =?utf-8?B?Y1lSTld1Wm96R2lGQVkvMXlMbldTdmUrQTh3UjZGYVZvcitMUjZxSW1xMUg5?=
 =?utf-8?B?cUpSSWVrVFdFZllRSCtnR1A1cUhib1hNWEF0RlE2WlRlS0FRT1lvUGQ3ckNM?=
 =?utf-8?B?ejBKc2VDaXhNYUhxV3RoOTBtbDFnTzJOakpDVTZLcHkxbzJwKytHeC9tMkgz?=
 =?utf-8?B?bGszRlFJdmUvMitNaGdXemFtNEl5S0thTVJ0ZE1UMVFEWFJwamxtdmVWNHBR?=
 =?utf-8?B?VHpTaHBWWTNKOUJ2a0Y3amRKM1hnMFlvRTVSSHkvZEppVjlFUlhCUEw5UlJY?=
 =?utf-8?B?c3FyMTkyOWFHQVI3T2c5NnN3WjloU0dyODc5Vzg4Y3dOdUZXaDlZbzNGMWZv?=
 =?utf-8?B?YmFURFVoakpXMnZ3UHM4R1lyNDl6V0g0MGhtb2RCeUIvcFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHlkNUtpSC9hK3Z3QVkra0U3STFmOFVxRWpqMVg2REFhcDgrQ0ZaYkZraTZu?=
 =?utf-8?B?YXczRFVTZWJteE5rTHFhK21CbHptS3RqcDBleWduUGtJazdPQlJOL25VRGFy?=
 =?utf-8?B?SUxwMThCbENpVXlEVWh5dU85TGp5cmI2R0FXeHNVSVh5WjR2eVp3SXl3NTYw?=
 =?utf-8?B?M2xpbm5ubGNlV2FlYUt4cytjL2tYK1hSUEhTenhDN1ZjbzNDdVFTV2ZLUi8y?=
 =?utf-8?B?L0xMT1BoZ0VVL2hFTVJEdDN0Nm1WSHJFODcyalRNVXc0S1lPVFF3QStNVHRT?=
 =?utf-8?B?SEdSUnBKbmVOeUdzWnR4cVRyRjEvQXZyREFiYzdkcGpZOXhJTFMwRzNOTDFF?=
 =?utf-8?B?bU1tcDNWTlNmQ0huWklRZnFIUXZsOE9MWUNoc093a1YrMVpuVjVmbXJLek1C?=
 =?utf-8?B?cmVYUGlzaEdYb1F5VXhIUHlTTUxGRjdxRGU3MG1KRnhvcTZ1OUZ6aEZCMFlG?=
 =?utf-8?B?dDVsdm1acnF5QkRnbXlrTDhZci9qTFZnTDFvWW9LZHl6ajRPR0hhYkJFU2h0?=
 =?utf-8?B?Ry9SNTAwMjBGWUV3amxwU3dHYVN1YkZLUW5LWWdDZ01KRXJZY2NmSWQzSVhE?=
 =?utf-8?B?V0k2MVg3c2VyVHV1a2VJZzRjMzdJY1RSVjhrQzFoczNZMkE0YVYyUk0yVXJC?=
 =?utf-8?B?Z0h1czNFM2JjVmVPTmF5T0p6Vi9XU3VJc0xXYTJnMkV1SzV5R3NDYW50YjZv?=
 =?utf-8?B?R3lvZ3VoZ0FYWW5XUGF0UUJwSEJJN3JPV3lxSmR4M3p2U3JjL2hjVlBZSzNC?=
 =?utf-8?B?eFRvRkNaalJkS21BVWJ6Z2tSdnFlQ1JqMVRUMW5HYkNGbWF2NmswM01MNlY0?=
 =?utf-8?B?WGJIbExjdXUxRG44QTQ2TExRaXdyb2tUZWg1d1pqdU9MUUg1bG5HRnZSQnJT?=
 =?utf-8?B?RmN5bkFSczNUUVBVWTdGRWhBL2JZRitsQUVnWWVXaEQxTDZFTXBJR2RwTHhi?=
 =?utf-8?B?UXI5c0d4K3NCVVFaMDZyU0t5eUVVWXpSMUdIOXpublQ2TkJDMTVGVmVhYXNM?=
 =?utf-8?B?NEV2Qk1qRnB5QmZGTDNVYWxPK1VPT202eUN4UU1MRlpuMTZGRGpPL0RERHRW?=
 =?utf-8?B?c2tVSWtRblFSZnFnTkhQRzNxNXRZT1p3R1U0NDhYdTFBSy84emhhU1dzNitw?=
 =?utf-8?B?M2dEbVQ5Rjc2UkF4am5JbHp0OWtBajg2VkhkZFF1Z0c3NHRIWTFWczZLbklW?=
 =?utf-8?B?eWlyb0lCR21leFFRWUdreDZtcE0xTzVoaFJCMXczWnN6MHhCUHBTdzAxMXRP?=
 =?utf-8?B?QTdpQjRJTWZ1azYvM2RsKzZldExnY3BhSlNVQWpaS0RndENXb0ZEcWFGMDdT?=
 =?utf-8?B?Q0JpWVI3a3Mwa2VVL1RHN0xZM2g0dEM0TjFWeE9oaFlYdkUrUWdhVE1LVlFT?=
 =?utf-8?B?bzJDNjFnanF6UkpyYmJIRU9wUEljY1haOVdqUm5PcW1GeFhTVUMrdEI1V2JO?=
 =?utf-8?B?Um9HcW1QZGV3UHlFZndKY2JxYkJJNlVmc3NSeW9QMnE5SmNYdHVKbTcvbnJ6?=
 =?utf-8?B?ay9GbVVYajRNcnpvQlZlZ1JYRjU1RWpwZHFUTWpKZ3ROeXZDMG9jWnZaVkhu?=
 =?utf-8?B?KzQ3Q0krRXlPa2FpUFB1djl5TGdDMWl1WVAyU29xalErdlJjQXQreW5kbWJo?=
 =?utf-8?B?SHRhRkdva2pLVFVMeWlOZmhZL3Q1akovb1dmU0NLTmpxTWF4bVhoL3NpNG1u?=
 =?utf-8?B?UVpOQkYzZFhyZ29WOFNDUXlkY3BkL1hXT0VvU0luSTdLQ1l3alFhTkFDM1Zz?=
 =?utf-8?B?OFYyaGpnMzRFNjFTK0NveGNvOGNJMldMQWR0ZmlkcHo2QzByVlRVZ3JKQXNF?=
 =?utf-8?B?WGV2YkFaMTM2VUlUYXdGZW9xdHZaMWhockpWK0hhSGtBQzBFQ25rVzlYRGFJ?=
 =?utf-8?B?cnYxR1BLUnF4S29oVGRnVmtSOHlOZGh5dnB5NE1JdFdteUI5a0xvenV0dUZr?=
 =?utf-8?B?ZE02bnFjcjV4Vm9ISTlXWHFiWUJzSTNPL1dPWDZoVEIwL2RnOGlVRWJIaEJO?=
 =?utf-8?B?dnl1aDRIaU5DdEFJcGovWjk0ZGd2YjZNZlMxNmVRMjREOXBFYVBRM2xEMUpY?=
 =?utf-8?B?ZFVpS2oxNEFqRU5NZk93VnpTVUt1UkhPNzRXNGZGU0x1bnRLZkpxSzJscE96?=
 =?utf-8?B?bzhXZFZ4cERxSUlzLzUrMDBTaHZ0NGlBNXo4RHF0NEtRV3ZDZmZxQnh3MnZZ?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3701c03e-e82e-4cb7-b207-08dcdcffeea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 01:18:15.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27ijKkI968899RAfkYXWi3hPAEQqn1ebyfdUtt/n8wg1b1sBSfTFQGHdzMuSJHsnNqSAegBB8CL87DKP2KGBc4CzrB03aP4XZG4tSOx+OfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgNTo0
MyBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNr
Lm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyBzaGFrZWVsLmJ1dHRA
bGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVh
bmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZvdW5kYXRp
b24ub3JnOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpk
aSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2Ro
LmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyA0LzhdIG1tOiB6c3dh
cDogUmVmYWN0b3IgY29kZSB0byBkZWxldGUgc3RvcmVkDQo+IG9mZnNldHMgaW4gY2FzZSBvZiBl
cnJvcnMuDQo+IA0KPiBPbiBUdWUsIFNlcCAyNCwgMjAyNCBhdCAzOjMz4oCvUE0gU3JpZGhhciwg
S2FuY2hhbmEgUA0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBZb3NyeSBBaG1l
ZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVy
IDI0LCAyMDI0IDEyOjIwIFBNDQo+ID4gPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hh
bmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+ID4gPiBoYW5uZXNAY21weGNoZy5vcmc7IG5w
aGFtY3NAZ21haWwuY29tOw0KPiBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+ID4gPiB1c2Ft
YWFyaWY2NDJAZ21haWwuY29tOyBzaGFrZWVsLmJ1dHRAbGludXguZGV2Ow0KPiByeWFuLnJvYmVy
dHNAYXJtLmNvbTsNCj4gPiA+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIx
Y25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiA+ID4gZm91bmRhdGlvbi5vcmc7IFpvdSwg
TmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPiA+IDx3
YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGlu
dGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgNC84XSBtbTogenN3YXA6IFJl
ZmFjdG9yIGNvZGUgdG8gZGVsZXRlIHN0b3JlZA0KPiA+ID4gb2Zmc2V0cyBpbiBjYXNlIG9mIGVy
cm9ycy4NCj4gPiA+DQo+ID4gPiBPbiBNb24sIFNlcCAyMywgMjAyNCBhdCA2OjE34oCvUE0gS2Fu
Y2hhbmEgUCBTcmlkaGFyDQo+ID4gPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IEFkZGVkIGEgbmV3IHByb2NlZHVyZSB6c3dhcF9kZWxldGVf
c3RvcmVkX29mZnNldHMoKSB0aGF0IGNhbiBiZQ0KPiA+ID4gPiBjYWxsZWQgdG8gZGVsZXRlIHN0
b3JlZCBvZmZzZXRzIGluIGEgZm9saW8gaW4gY2FzZSB6c3dhcF9zdG9yZSgpDQo+ID4gPiA+IGZh
aWxzIG9yIHpzd2FwIGlzIGRpc2FibGVkLg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3Qgc2VlIHRoZSB2
YWx1ZSBpbiB0aGlzIGhlbHBlci4gSXQgd2lsbCBnZXQgY2FsbGVkIGluIG9uZSBwbGFjZQ0KPiA+
ID4gQUZBSUNULCBhbmQgaXQgaXMgYSBiaXQgaW5jb25zaXN0ZW50IHRoYXQgd2UgaGF2ZSB0byBl
eHBsaWNpdGx5IGxvb3ANCj4gPiA+IGluIHpzd2FwX3N0b3JlKCkgdG8gc3RvcmUgcGFnZXMsIGJ1
dCB0aGUgbG9vcCB0byBkZWxldGUgcGFnZXMgdXBvbg0KPiA+ID4gZmFpbHVyZSBpcyBoaWRkZW4g
aW4gdGhlIGhlbHBlci4NCj4gPiA+DQo+ID4gPiBJIGFtIG5vdCBhZ2FpbnN0IGFkZGluZyBhIHRy
aXZpYWwgenN3YXBfdHJlZV9kZWxldGUoKSBoZWxwZXIgKG9yDQo+ID4gPiBzaW1pbGFyKSB0aGF0
IGNhbGxzIHhhX2VyYXNlKCkgYW5kICB6c3dhcF9lbnRyeV9mcmVlKCkgdG8gbWF0Y2gNCj4gPiA+
IHpzd2FwX3RyZWVfc3RvcmUoKSBpZiB5b3UgcHJlZmVyIHRoYXQuDQo+ID4NCj4gPiBUaGlzIGlz
IGEgZ29vZCBwb2ludC4gSSBoYWQgcmVmYWN0b3JlZCB0aGlzIHJvdXRpbmUgaW4gdGhlIGNvbnRl
eHQNCj4gPiBvZiBteSBjb2RlIHRoYXQgZG9lcyBiYXRjaGluZyBhbmQgdGhlIHNhbWUgbG9vcCBv
dmVyIHRoZSBtVEhQJ3MNCj4gPiBzdWJwYWdlcyB3b3VsZCBnZXQgY2FsbGVkIGluIG11bHRpcGxl
IGVycm9yIGNvbmRpdGlvbiBjYXNlcy4NCj4gPg0KPiA+IEkgYW0gdGhpbmtpbmcgaXQgbWlnaHQg
cHJvYmFibHkgbWFrZSBzZW5zZSBmb3Igc2F5IHpzd2FwX3RyZWVfZGVsZXRlKCkNCj4gPiB0byB0
YWtlIGEgImZvbGlvIiBhbmQgInRyZWUiIGFuZCBlbmNhcHN1bGF0ZSBkZWxldGluZyBhbGwgc3Rv
cmVkIG9mZnNldHMNCj4gPiBmb3IgdGhhdCBmb2xpby4gU2luY2Ugd2UgaGF2ZSBhbHJlYWR5IGRv
bmUgdGhlIGNvbXB1dGVzIGZvciBmaW5kaW5nIHRoZQ0KPiA+ICJ0cmVlIiwgaGF2aW5nIHRoYXQg
YXMgYW4gaW5wdXQgcGFyYW1ldGVyIGlzIG1haW5seSBmb3IgbGF0ZW5jeSwgYnV0IGlmDQo+ID4g
aXQgaXMgY2xlYW5lciB0byBoYXZlICJ6c3dhcF90cmVlX2RlbGV0ZShzdHJ1Y3QgZm9saW8gKmZv
bGlvKSIsIHRoYXQgc2hvdWxkDQo+ID4gYmUgT2sgdG9vLiBQbGVhc2UgbGV0IG1lIGtub3cgeW91
ciBzdWdnZXN0aW9uIG9uIHRoaXMuDQo+ID4NCj4gDQo+IFdoYXQgSSBtZWFudCBpcyAienN3YXBf
dHJlZV9kZWxldGUoc3RydWN0IHhhcnJheSAqdHJlZSwgcGdvZmZfdA0KPiBvZmZzZXQpIiwgYW5k
IGxvb3AgYW5kIGNhbGwgdGhpcyAgaW4genN3YXBfc3RvcmUoKS4gVGhpcyB3b3VsZCBiZQ0KPiBj
b25zaXN0ZW50IG9uIGxvb3BpbmcgYW5kIGNhbGxpbmcgenN3YXBfc3RvcmVfcGFnZSgpLg0KPiAN
Cj4gQnV0IHdlIGNhbiBrZWVwIHRoZSBoZWxwZXIgYXMtaXMgYWN0dWFsbHkgYW5kIGp1c3QgcmVu
YW1lIGl0IHRvDQo+IHpzd2FwX3RyZWVfZGVsZXRlKCkgYW5kIG1vdmUgdGhlIGxvb3AgaW5zaWRl
LiBObyBzdHJvbmcgcHJlZmVyZW5jZS4NCg0KT2ssIHNvdW5kcyBnb29kLg0KDQpUaGFua3MsDQpL
YW5jaGFuYQ0K

