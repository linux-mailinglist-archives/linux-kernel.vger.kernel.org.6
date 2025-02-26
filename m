Return-Path: <linux-kernel+bounces-532699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040DFA45125
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57E71667DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC727137E;
	Wed, 26 Feb 2025 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+yeYMQb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041E256D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528301; cv=fail; b=O7K3VW049U0ki+6gpxYMN4PD0pG5Sv1D2qUkanzDoU6wh6OZ+JLY+AMK5PWgykUc+odxOfsNeyS9fSA9M8kBeJA0a/6yFSK06pJnSM+TsRaoQSemeLNEi/34jpifVpk+j9DQF9xCTU4u7bPBoF1Dnyj9G9badNsCvxEEc8IjZVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528301; c=relaxed/simple;
	bh=Is6BWEBBLuhP1m9BvHb+ThkQpUPZwzNtks3w42zJvyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pPuA4mkblAEJRmfXSohF3F68V/xc2GPqKZd9KKEFSawPxDu6SvvcIEQ8kYd796n77N3nc2BFPj0/NR8q8atrMOPHRTjMdWNT4uZoIcICAc/PDd1ubW6wQcRjOquFMTSeD7EfWnkAgG/imLBMkKYEGXsuBJPTk4FsVQ8PN1InfAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+yeYMQb; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740528300; x=1772064300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Is6BWEBBLuhP1m9BvHb+ThkQpUPZwzNtks3w42zJvyI=;
  b=j+yeYMQbeJolbRFnXMM9vIzsm3dHhDzA9+5Ph8rLCA5z2v/dvONxT8K3
   DjMf62VQTugBEJkMPML3UbnSCW+tkJ5cQEOs9+b+ncnrnAkXlZcgXLY3w
   Du5K7F3HZYpRCnI860VESeLuxWA/yKIcL7rseTlAiSGsePrcOIZ4QS9zj
   wkM6WVU1OX7yZuwiApFGrKsTmvkOTE6zrI6XZ3BrAMtTgUWDavBVYtzoR
   W7mdWjUV/JEf5EQxOpJEif7/n4cdAi7PNqea+SD+6W2YOYU7S5fH+3DPp
   wj/gA1a2amA/mzE9mC1JGCxdULwhVlZDhsJqHOSMX803Ik26z/l55x7Mx
   A==;
X-CSE-ConnectionGUID: PPMIi52RSSixdxMPUWH9kg==
X-CSE-MsgGUID: gd24nepfT7uvDzkEfooG6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41613281"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41613281"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 16:04:59 -0800
X-CSE-ConnectionGUID: aEvEHktYQ0WGZsz65w+h4Q==
X-CSE-MsgGUID: psKKArkvTmCJl4CfjF6+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121785891"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 16:04:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 16:04:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 16:04:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 16:04:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Skxl7cnsap4sWCcYa5E9IYRZt7WmOCqa4iGEpnc0E5+NBsW8mO8hu2j8bLgqyUCrQZczYaJF/S0ntd1boAZ9yANVoIFXIUSlWn44FR7gEv8qM/453gz3ZtoWreZJ7VS2V1qdJbF2Nt1gjycHJOcDtI/rzVg75A7PvWPl3QimhaW5nzCLNEDPAwjFS2mTvoa4wnidWLFB2u3NLB6RyX9fsZwxafiZmSe2lEb0x/T8X0xAHYen4B7N3Fu94wjtZjeaTYBrgVJqjVVWvUwSL17lhyYOpTErQeO9E2NrdRowxjuj8zkxn+kcporVh7jV+SkPCiYE1xYEhl7agm4AXuIdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Nw65sCyKOHGjk5+DaDlflT0qwyLSFq2A6n7n7silRk=;
 b=D6r8nFT0UiPJ/467eIwEZOgOMG/x20KevMWi6BDJp41EQAK6S0x4snPpWOzYTp1IvAt9cgD01i93YKM6o8GR3Jp51VjtbBr64SX9SroSltUsdd9EJfMo216cbllsw46/Wrwkd5Nl3ff894VpUyHj4ikpkxHpQpSaUSV2QqOu18pFIs1DeimODbfNARgXGdL9AUQObyf4dCgk2TNxkkP25I+ySBCzQiwKT2BAIy3iOSoZ4iUOT8zZX8B3gjlmOG9eDXw2OgyY0GdYxfhbRnhcdX4kWD3LctdBwdw6Lm+/mlxnNx/JcGoEK3GxtqsURPSPK2x0xCkHN10tx+jVDT7t0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 00:04:53 +0000
Received: from PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac]) by PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 00:04:52 +0000
From: "Constable, Scott D" <scott.d.constable@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Milburn,
 Alyssa" <alyssa.milburn@intel.com>, "joao@overdrivepizza.com"
	<joao@overdrivepizza.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"jose.marchesi@oracle.com" <jose.marchesi@oracle.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"jmill@asu.edu" <jmill@asu.edu>
Subject: RE: [PATCH v4 09/10] x86/ibt: Implement FineIBT-BHI mitigation
Thread-Topic: [PATCH v4 09/10] x86/ibt: Implement FineIBT-BHI mitigation
Thread-Index: AQHbhroXVKsz12Ouj0K5gSj+6C2AurNXvUKAgADWsfA=
Date: Wed, 26 Feb 2025 00:04:52 +0000
Message-ID: <PH7PR11MB757209F1FC089966E546384ABBC22@PH7PR11MB7572.namprd11.prod.outlook.com>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.820402212@infradead.org>
 <20250225091213.GI11590@noisy.programming.kicks-ass.net>
In-Reply-To: <20250225091213.GI11590@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7572:EE_|LV3PR11MB8765:EE_
x-ms-office365-filtering-correlation-id: e556922a-d5ea-4181-0bf8-08dd55f931cc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?AhvhxMLQpG/bqRHl7ytlL+SnF5gvCGXXXr37L7ONAAol20YbaVVVSom4nZqj?=
 =?us-ascii?Q?DVYeR1j9DX5eb+adgDM7vhuQbZvT3Chcg/knxoRZdmtzGWMy0WcnSf82IrDl?=
 =?us-ascii?Q?u6USNJjogsvGoh52+EPxKEhAmEcf3dZbw5Y/3JU2BCbfNcyvJPkXMUbGtiqj?=
 =?us-ascii?Q?yPEDYIDhX7e/Kyj1gRM9zEXZqdC2fqhJAe5MjI9YaJN1aiDT1h2fWD0s91Zm?=
 =?us-ascii?Q?nvQxmkxoFuL2RgcbEizSzgQ3xEa5gGkdJUkF+fsUbCaq5Z9cUPNf0y5E5OSQ?=
 =?us-ascii?Q?dVJ+zE1nenOWCWhvkvPzJozvjZqEd/VfOHBjbThhD1ETe6R9/YIGUIlS7o1g?=
 =?us-ascii?Q?OTTfJkPQJLpY/6ZW+osIijcjbchipPaFMA3BWiVqkjjygQSNOM13IeYn3Xgx?=
 =?us-ascii?Q?9STZxCgIg6mbLEyYn78hOGsbG1WRfzUGa912BEGaiagixLkdM4XmpYggHRCk?=
 =?us-ascii?Q?n/qseZ2jY0l5hXcw9ZY3PRe8TarcJFgABqvWn3XSzEjQTJ3Qk0gN790y7jef?=
 =?us-ascii?Q?rENXgh5/Zm5OSel3pzbqYcxuLQz5bzBWqrnVq4hY6RvTlRHaGecOrpzKRRmD?=
 =?us-ascii?Q?wjthwh4x/4Z+6Y6yN0QKyE3CyifMB0F1MJLYi7rxchzVLTeh9X5JmlvgTrBt?=
 =?us-ascii?Q?0YFk8gYYMCP1QORrlhBAUjbg99fbUkZoVFRJ/oWMkgtqQEGoS2XThtm3hBab?=
 =?us-ascii?Q?dNz0qSm/zbrdUH/jkko9qVTcpMcWYO5Q8+s4PgUW26p3beF5Z7Lq9NQH3j52?=
 =?us-ascii?Q?kNEK0gZZkiDVYka0IqkdX8jOE8LlASJXPNH8v4lCuchlEMYZ3Q6DgjvN7XNb?=
 =?us-ascii?Q?nNf07fz3YuNrz7UALYVdy1IaPgzK/BXi1s7lCN0cgGp2rDcsHdpJhr1zpSgM?=
 =?us-ascii?Q?IRpnBhQ5UpT7qdGYbUq92aZbyibCRVGfB4T/17IQWS0wGwZlPyJQmu9I0uVb?=
 =?us-ascii?Q?vWHMNMZ/XhMYtGzgGywhNM+JkxdXL1Ke+zt6Ps5xJiIv8PJgd8zY5AYLWyxo?=
 =?us-ascii?Q?S5zDOfXowxeqqNmefVXlhN5CdXgxEQo49inbD8sDiFVKo8EgNxNrVbyst4LN?=
 =?us-ascii?Q?R/pMl2VC11o7nMSKw/u2YSCnsTp5hlaafg6jei4unzslni2oPuhXbyklLB6s?=
 =?us-ascii?Q?AWIKXZStbjR2ibiz0jcEHciHM73PFT/Cet9Mx4CFistY2HlXuAEFPxnazb30?=
 =?us-ascii?Q?j1DXhQHKRl0DNSv/x3MouSZVOWPo3mE5Ha4F3OVeIoBeyywHExDxFgSNrM8p?=
 =?us-ascii?Q?le9zVSsi/fQH1GqBpe6Hu1ancJRjBW26voLPukNFmNCQ9C/T/SIYZNvQWA69?=
 =?us-ascii?Q?+OGpVB5tl0/0gxrnAt2G5hzQ6Il2kjaxmKz7bptvgqtwntX0qIblP0RViln/?=
 =?us-ascii?Q?1svtQBQcRc8qPYo+eK7c6dKZLO6AoOhGXi1BBc/SwK2v01vI7Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lbu1zM1ykuEILKzmXV5VGkeu8kvDsGQBmsRH5nlDzuxRars83/KRfK4ack3V?=
 =?us-ascii?Q?9exz7nyZ5TKtTTu6o4bgN78ZYbYAw4Il7kdcwvJz/qQlHwNr/ae5m6X4ZMHG?=
 =?us-ascii?Q?0xWwlBgqK+nxcUxs1EQfpWA5g4Ma3MIFf7hVQ6DyCBzt+3nlv4LUvBgOw2Ny?=
 =?us-ascii?Q?8kntJnpf3NqaDLa7J+/6+EhwRwMIL4QtQTAzQwcrWKwUw7q+hhAglovKPx6B?=
 =?us-ascii?Q?udXHYE47thxtzsMfULnuvYPyYtKn9lma6E1PhPoqpD9BcIZoNmZL4yxweTzy?=
 =?us-ascii?Q?ClAmpl9H8kVj/dqA8QvsTY5bQaRNYdBcqf27lZ9y3+un4UfK0LPjj+OmrYeU?=
 =?us-ascii?Q?K/WE0ufqqP8G9v9uPeskv54m4LMdXl3dhuJWLsG92EYP3BjKvTuJlVc5d3rD?=
 =?us-ascii?Q?8fDMAdXqqCwIM26COGaYGcVXEpsx5bg1ElNFRT5ebHl1JnMI690hPLcpTsB7?=
 =?us-ascii?Q?4VZ7Ep2gKbjAyX36/kH1OGJBDRW7HaRtvVtfAjE87mWtWJHl1gXJXu0p6zn4?=
 =?us-ascii?Q?YKGFzrXT6QTiVf/jyNXeJvNKGa26NZp1k4UKVPx7FWF7QY2ZzfN1eN6hyoxa?=
 =?us-ascii?Q?91v5fi3PL5Q5q/ALIyr+VW+81hsGTxtKlasZBTs0spdo1TJtql8Hv1x8dJv8?=
 =?us-ascii?Q?SDUXM/bc+d1h7FmDGzyLjoTXOI1lFtzlYG02sOL16bYuVWAZ/w1SKM3m9jaF?=
 =?us-ascii?Q?dzQxZWTzZzvvxeF592jQwhcTCCJ6UW0+79huHIW8Tf7QSs5TBw4SJgs7WIy5?=
 =?us-ascii?Q?9Tye3hU8/uxfHFKMiRk9MlCuMV00UYwCdWJZ7f79aFnHnWRMPPrdD8xngrx0?=
 =?us-ascii?Q?HqWaq0X+1VVHSBZZZTUQsIJbIOJ99Exh6M03n0DOUl8K6lBLKA8tvCuedb9w?=
 =?us-ascii?Q?nvSYsRX4wHhch4o651jb7XffYDuqJOd4yxJL6BCD67IPsdEpzRVyDiX3kzOY?=
 =?us-ascii?Q?uwQRQXXtiBt/lGiQcSH/lRXXQfGAMazl/z9sxMhsWNPvfq5ZtTQMsyt4D/8J?=
 =?us-ascii?Q?GJQfATMwKRINtwSW4HNDdDuQvQqIS8VAfyTH1rS8RfLbsXb8NbhLCaaBCovW?=
 =?us-ascii?Q?sVllLku80wJCub2TCJOGzerPI3ep2tb53QTCEOunv2S2u2+EOfZFaaDsg+d8?=
 =?us-ascii?Q?itusxwdmfbYXKabzKey+COb7LEQuqA2QF8b2v2L/9Oq93YuHDNMMrPmEuuJC?=
 =?us-ascii?Q?6a7/wJYJ4Vd1OpSz+G/a6GxFritMv865u+2gs6TM/4ZJchHxo2BFmDihmhKf?=
 =?us-ascii?Q?EhtWAoDpvCYZ/6rW1X6mn5ERstCQeiglcPeH9ucl4IapmRQl5PQ/7lwHfGWk?=
 =?us-ascii?Q?x8H6mNigprAQiVqq+qG5astTw+3NZ/p4TTYjlvAy0ys5/DeqM/KDy1WvcdAT?=
 =?us-ascii?Q?giCjd3WX1Te36qbcYLD34V7fwS4t/K1SlVR1jSgCNsQ+vYa7CmTNTGw07E4w?=
 =?us-ascii?Q?sUmiV0IcO8Yls8mx3Pxa3bCfmH8L7JqmE6EoIapQMK2NhyG4NUI9UpDPQ+z1?=
 =?us-ascii?Q?psnNUW7PovMfvsyX5Q4GwP+IgDnpdJx5L2rkH1pfettYo9Y3MnIEUynl3TMV?=
 =?us-ascii?Q?vRpMsgBkoD9XRo6j34yJkTHt4O9/LLyKwkszvv9+UtT/6Me69AQsRwB7cgor?=
 =?us-ascii?Q?tA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7572.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e556922a-d5ea-4181-0bf8-08dd55f931cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 00:04:52.6419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cYLGIWrgGuCbgKyBReAsKlJoDWMTttagWAmsOMoNb6Jg9ulr5OIeO8/stJRhVzx8t5zZtnCip3vYo83CeOASAE32xswbvs5QG2OWzz6u2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
X-OriginatorOrg: intel.com

Peter's example is perfectly valid. I can elaborate on the broader goals:

Microarchitectural attacks such as Branch History Injection (BHI) and Intra=
-mode Branch Target Injection (IMBTI) [1] can cause an indirect call to mis=
predict to an adversary-influenced target within the same hardware domain (=
e.g., within the kernel). Instructions at the mispredicted target may execu=
te speculatively and potentially expose kernel data (e.g., to a user-mode a=
dversary) through a microarchitectural covert channel such as CPU cache sta=
te.

CET-IBT [2] is a coarse-grained control-flow integrity (CFI) ISA extension =
that enforces that each indirect call (or indirect jump) must land on an EN=
DBR (end branch) instruction, even speculatively*. FineIBT is a software te=
chnique that refines CET-IBT by associating each function type with a 32-bi=
t hash and enforcing (at the callee) that the hash of the caller's function=
 pointer type matches the hash of the callee's function type. However, rece=
nt research [3] has demonstrated that the conditional branch that enforces =
FineIBT's hash check can be coerced to mispredict, potentially allowing an =
adversary to speculatively bypass the hash check:

fineibt_target:
ENDBR64
SUB R10d, 0x01234567
JZ .fineibt_target_body    # Even if the hash check fails and ZF=3D0, this =
branch could still mispredict as taken
UD2
.fineibt_target_body:
...

The techniques demonstrated in [3] require the attacker to be able to contr=
ol the contents of at least one live register at the mispredicted target. T=
herefore, this patch set introduces a sequence of CMOV instructions at each=
 indirect-callable target that poisons every live register with data that t=
he attacker cannot control whenever the FineIBT hash check fails, thus miti=
gating any potential attack.

The security provided by this scheme has been discussed in detail on an ear=
lier thread [4].

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/so=
ftware-security-guidance/technical-documentation/branch-history-injection.h=
tml
[2] Intel Software Developer's Manual, Volume 1, Chapter 18
[3] https://www.vusec.net/projects/native-bhi/
[4] https://lore.kernel.org/lkml/20240927194925.707462984@infradead.org/
*There are some caveats for certain processors, see [1] for more info

Regards,

Scott Constable

-----Original Message-----
From: Peter Zijlstra <peterz@infradead.org>=20
Sent: Tuesday, February 25, 2025 1:12 AM
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org; Milburn, Alyssa <alyssa.milburn@intel.com=
>; Constable, Scott D <scott.d.constable@intel.com>; joao@overdrivepizza.co=
m; andrew.cooper3@citrix.com; jpoimboe@kernel.org; jose.marchesi@oracle.com=
; hjl.tools@gmail.com; ndesaulniers@google.com; samitolvanen@google.com; na=
than@kernel.org; ojeda@kernel.org; kees@kernel.org; alexei.starovoitov@gmai=
l.com; mhiramat@kernel.org; jmill@asu.edu
Subject: Re: [PATCH v4 09/10] x86/ibt: Implement FineIBT-BHI mitigation

On Mon, Feb 24, 2025 at 01:37:12PM +0100, Peter Zijlstra wrote:
> While WAIT_FOR_ENDBR is specified to be a full speculation stop; it=20
> has been shown that some implementations are 'leaky' to such an extend=20
> that speculation can escape even the FineIBT preamble.
>=20
> To deal with this, add additional hardening to the FineIBT preamble.
>=20
> Notably, using a new LLVM feature:
>=20
>  =20
> https://github.com/llvm/llvm-project/commit/e223485c9b38a5579991b8cebb
> 6a200153eee245
>=20
> which encodes the number of arguments in the kCFI preamble's register.
>=20
> Using this register<->arity mapping, have the FineIBT preamble CALL=20
> into a stub clobbering the relevant argument registers in the=20
> speculative case.
>=20
> (This is where Scott goes and gives more details...)

Scott, could you give a blurb here? Would the below cover things?

The basic setup, for 1 argument, is something like:

__bhi_args_1:
  jne .Lud
  cmovne %r10, %rdi
  ret
  int3

__cfi_foo:
  endbr
  subl $hash, %r10d
  call __bhi_args_1
foo:
  osp nop3
  ...


such that when speculation of an indirect call is maliciously steered here =
from a non-matching site, the hash check (__cfi_foo's SUB) will not match, =
resulting in !ZF and non-zero R10. Subsequently the __bhi_args stub will ei=
ther hit #UD exception, which kills speculation, or when steered wrong, hit=
 the cmovne, which will then clobber the argument register RDI with whateve=
r non-zero garbage sits in R10. Making it much harder to control whatever f=
oo normally does with its input argument.

Additionally, CFI hashes are randomized at boot, making it much harder stil=
l to predict/control the non-zero value.

