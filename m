Return-Path: <linux-kernel+bounces-343187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4931398978F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAC41F21695
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E2873477;
	Sun, 29 Sep 2024 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6fodOvC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4DB65C
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727644512; cv=fail; b=gZmrer9XIrNhv4a/UqupK/0UojRvCm00plhYX8SxuDJqvKnhxji2Bjkwg9hcwF7xjgeUZ1nk2u3k8DW4+QU35qpPe2V4vndjAEb/Mm1u4aD7Z7BZxwRZ4lIaAvegdZoIW2/En+pROmnfJxguQQbe5tgOAW2QhzPzDgD/3IZx2sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727644512; c=relaxed/simple;
	bh=T3q1w0JH3fb/18ziyRbkvq5xJ/miK9V7H4YVMgO1sEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ITDHGim77HdD8LuRiY53/4Ms+THpZWvg9Mi1GikXwrcZBTB6tdwmP+t3eWkcrKyWEvg09Iq7hX852ChJ4jeqy1xbZXTJWfJwt7PO6ImZmYj62Ew3yUExYu2Q00Uq5EBKjCIwehp8084RMeGo8QPiP4eyRnPB/7mFEy0D3XCDN1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6fodOvC; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727644510; x=1759180510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T3q1w0JH3fb/18ziyRbkvq5xJ/miK9V7H4YVMgO1sEs=;
  b=N6fodOvCagCn9H9UYRVvDo0TQR78AsaIqrT+OQP1gl2uA8neax1AVipd
   13ssnTAoc/rPXQBpIGIUMVKWhksC1fj547zSF7lQb4jNkr9ZiHnpMeq4G
   RYdNBMsftrIlTM3SQNgpX170sJwSwBq2gr3qI0k8/PBmucLwXczKrXrXn
   DixeBj9d4ImXR8VBrIoCRpyWPaVlWgda3KiO90/kFiM3Pws75dtcUxMsy
   bQNSWdJjnel803Kr6xILgrwILw0HreMhK8BeLoLD2mP+ROAZ0wn1xNicL
   JNSjfI51N4xFYzOhtIGtHg61xD5C6wHDJ3S0Cip2mhUkzxtTZ39J6b7Z2
   Q==;
X-CSE-ConnectionGUID: N4jPW6BiSR+6mrXY8fMQeA==
X-CSE-MsgGUID: /Op4iMiVSDO1AwDhpzgtUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26850765"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26850765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 14:15:09 -0700
X-CSE-ConnectionGUID: iiCimgeKQnedq+ppV/iH6Q==
X-CSE-MsgGUID: sg/TWFKbS0ebThtCy7wxKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="110584211"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 14:15:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:15:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:15:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 14:15:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 14:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzZyfdN3X+dA2ydEax+S/azbcYqRVm+9vVdGRYt0SMMDGe1sDNwT1cjNAYlaegd2kLC7vW+QfKDoG5XgbqDeyT2HX7yf0TKlkTFoPdDQMRlUXA9wsgxjMxjcyppQitur47Pa/B2AjWdR9ejTPN1MSGRvEznMWrpnf9WRzJ1siy7+Bvh4OVYulA4bNkTj/zdiplYRenQU3Nhl69aOrmg3fDpy3JblbHSeI7JFdW7UVOnojZO2zHnS5XY6n+l5m+wDdQXBouCDP40Ud4XWNZ8lRBr/3UxlObbOOgw5xxcZXun2VCChBsAT+xE3tSDd2Jf/D8clyBcoPAyUORt7oiKSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3q1w0JH3fb/18ziyRbkvq5xJ/miK9V7H4YVMgO1sEs=;
 b=RJY0FTI/1uYV1TklAlGkePCteUT3vv8s5K2s1V27WFSnPtTVpL7JpGDhQzpGRferAcZMuaSgGhYeSfIsHYq1/Wr8BFppSLnTy2bNWIltkmT3vi9hCGmXHUGNDsW+ujlEVfVmZUmYLukPIJ0XBVfTiAMu+mE/zuZn2MieVc3JIFh+NM6BK2tqNWoJ3Jmj2Zybp5Baa4Vm8w9oUsQ6pW4QjAAW8X1kkDJOnzLg8544tkoprXrueTKy4JDplq13mq/1uaN1qsQJ1JXY1SUAUB+PzETutnNjIsTOHHWsW9fWI1uepTR9aTyHzsoebkXVnj7r07o6ad+46W5oVbDG/agEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Sun, 29 Sep
 2024 21:15:06 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 21:15:06 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v8 6/8] mm: zswap: Support large folios in zswap_store().
Thread-Index: AQHbEUxuGKWHQbb9n0y12+mOnhkTu7JsjjkAgACw2gCAAEIAAIABwuTA
Date: Sun, 29 Sep 2024 21:15:06 +0000
Message-ID: <SJ0PR11MB56780EABB1E37C98A0EDE4EDC9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkZRTAiEJQpg96zqDye3ViCfvBsMM1Ozmcs75e__WcF0kQ@mail.gmail.com>
 <20240928141514.GE957841@cmpxchg.org>
 <CAJD7tkbw7i=JB5NDYmmsxEw--NqkOidNeO-0+Gj0EvZfk627Dw@mail.gmail.com>
In-Reply-To: <CAJD7tkbw7i=JB5NDYmmsxEw--NqkOidNeO-0+Gj0EvZfk627Dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|BN9PR11MB5227:EE_
x-ms-office365-filtering-correlation-id: bb313a2b-0c04-4a0b-8dd4-08dce0cbcae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c29WdThYTExRZnlWVHM2Skx2RnNZUzhZam1tN2FucFY2WEt0cFpOWmhLR29Q?=
 =?utf-8?B?TnJLVWNSWlZ3NkhrQTViY3FWdDV4UkJUWmlGdzlCNzErcWNpbzZ3QUUzUUFL?=
 =?utf-8?B?SlU0OWVQQzMwT2lPeWYrWVpUSENrWHBKWGI5RmNPbFhVZlZEc0hvOUxMa21l?=
 =?utf-8?B?Q0F0U0E3eGVHRCtDVkVpdWM5UXhYYXhBYnh3TVZrL3FKNG1IRmIrK3JWZVpy?=
 =?utf-8?B?ZlpoK1RGMjEzQnc3cTRvK3RVTTUzL1hqbDdtc01tZXpYL0pBdHBCRGVlNU5o?=
 =?utf-8?B?SnBDNmRyVno4b0VXR1hNaXp3QzJMRnZzemwvRnJ3VXJnM2FDWEovQUFmZ25m?=
 =?utf-8?B?NmNCL2hPblR3YXg1NTNFR0RuMm1QNmFPSlhwMGp0elErcXFRTWx4ODRQZERm?=
 =?utf-8?B?L09YTFdlM09jSDZqNGlyWlFFMnFXRmhscmVGWEdHV1VnamhiNlBuTHNkMUdN?=
 =?utf-8?B?YmVPME81RDF3VTFBYVFxYUpzOXVWNHNpcUJOM1BPK09MdlZyN0xnc2hidU9B?=
 =?utf-8?B?S2hhSDF3bm8vcHEwNHhsU1lsSjRYUW9RQnIrSEd2c0VnTjN3WDNuUEltSVpn?=
 =?utf-8?B?a1JyVVFLdTc2WVB6ZHh3aElDdUx3NDZEUzFOYmRxNXVWRWduV3NLWDBXNXEz?=
 =?utf-8?B?cHQ5aDVGdGZ6RzYzNjF4VERUK01mZ3B6YzF3SFhGQlhGOVRYVDlzU3Jzekk3?=
 =?utf-8?B?eFpISHJQME94a2UzU2Z5NzRzdXRiV3FXYWFibXBxcFRFNTdXMTdtd0tpTVVz?=
 =?utf-8?B?S3UwUjg1RTJFcUp3RG04UmNmVWkvcmQ2MDNFbmw2NUZlYW54V1hsa0tuV0V5?=
 =?utf-8?B?YU5BU3NEVzFFaW1UNnFxZDZ6LzdyYkZZZEdnSEdyeldCSHBWMWs3U0tBWU5k?=
 =?utf-8?B?NW1Ub1lGcEFFNGx6b0FvTFNHaXp4VW51cWhxWmtCQ1FteXpUbjZ5UFhHRlRQ?=
 =?utf-8?B?b0RCd1ZiYnkyRm5qaHBIZGdjVjhGa0FLeVVxK0VtNDFwRDN6VmRlUG1BNlVP?=
 =?utf-8?B?S3M5MXcyeDNVSDcyWWxGeURGbm1uYml1d3FiUVNYOGk3QzZ6bHNndVJCRWpq?=
 =?utf-8?B?TVQ2bExRT3VUVGR1S0g3eDNUYytVdThmdktGeGhvNmVpV3MxdkkzSXUzVGx5?=
 =?utf-8?B?SXR1T2dYamFmQ2QwbnRudjhWZ2tUYTRGVU9XOTltT25adk9wZU9GTWdNaHEz?=
 =?utf-8?B?WU42REwzV25ycGU4N3UxR1dnMmNSaEs1SnRoMExidXFGUlZBK2VWUkxjOCt4?=
 =?utf-8?B?UjYyWXYvQ2s0MW41b2xIaXhsZlFwVE01M2J6R3Q0UnJkd3RnQUhHYkI2Mm5O?=
 =?utf-8?B?NGcrQzlPWW54cW16UFRFNXVoY1l5OGNodFRKNHhTQUZsajUwQjBsTjduVWJL?=
 =?utf-8?B?OVlkMXZKblpqdUtORmNPMjFGR2k0aGZQVy9xVzU4Q01td1Jsd2lkK0Jsamk3?=
 =?utf-8?B?dytGNkRRcHlEQ3BIUUhneFhlTzI0Y05oN3I4ck91M2hkK0RPT2NtM2M1OGJk?=
 =?utf-8?B?QWpwck55aFgvUDlBWDhqaTh1L21PZTZ2djlUTGRSdFhuU25pMWhrajFGN0hy?=
 =?utf-8?B?QllrM2Mvdjkzc2FCbURiVWk0d2t0R2VjbU9SN3l3N096ejJhT2xsQjUwY0o5?=
 =?utf-8?B?OEFZdG1qNVQzZmQ5M0hKMTBjbzlGeXFFRkVISzBKclpadlh1THFpUnptTFZ2?=
 =?utf-8?B?WTh5ZGt3UWY1Z1hPRE0ybGtzWkE0dXNLazEwbnlya2FoZVlVUFRRRVZ0OHd5?=
 =?utf-8?B?NjJldTB6RStOQlp2dmFRR1N5NUtDZjhZZnVCRThla21TeVN1K2syVUhZNkFO?=
 =?utf-8?B?WENsSUo0aUMxcW1hK3ZvZllYRUMxVkRvUnpLZUltckRsYjc0b25XRHc5TUJl?=
 =?utf-8?B?MXhOWENpU2FXUGFqbzFYMDczUThDSXJ5aVplVmVucVd3V1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clFGY1phbGtJdC9PYWZxd25nQnZuaUROSWRueFhPL25nR05uRUliM1dxcTRS?=
 =?utf-8?B?N1p3dU5rZDRsQmtuL29KVFVKZ1dpdUlNeVEvWkZZd0ZRTFpPMXQ3K0ZZSUE2?=
 =?utf-8?B?U29RR0tNN1ozSmRFZUZNWG1TY1lVNFJmMlBYc25UZVNjbm1teE94TGVyWXhZ?=
 =?utf-8?B?bFNja2lmZWlBSVhQcUgvc05JSG1pZjVqSmhPaENPUTlWOUNVU29WNGtrYi9q?=
 =?utf-8?B?VHUzT1NvS3NzUWh6OGN6NmVHRytZd3d5QTBCdTUxRk5UVk4zQjlHdXkya0tG?=
 =?utf-8?B?WUxEYkZsdjBaVGVtelBIQmVUK2twOFh6cVZoWERWMHl0MFErTndoY3U5YXBW?=
 =?utf-8?B?cmN1V3Z6U1FUYVlMZjJrK21CRFgzNlhRNjhKSWpXTVRhTHh4a1NIR1V4YmJ4?=
 =?utf-8?B?RHZrUUZZT2lwN1hnM2NNUDhnemRzTklCQkdndDBKTjh4WFpRYk9YTHVaVFZj?=
 =?utf-8?B?ZnNuank4TWxQanVPc0VldjhxNi9DaUFSYWYzaUJVaEg1RWt1TGplaGFneE5N?=
 =?utf-8?B?elBuSW5TZmRlNkRmQzdDTVNZaGgvN3BxM3doOWxUdk5nZGtzNXBxbGp2OG8y?=
 =?utf-8?B?TmdRdGJCc1lkWGZQNCtOY0lyUFZ1Rjl5QXdBWGF1aEtQNFZYWE9JT2pKSlVy?=
 =?utf-8?B?Y0VzRGNqTm9UeC8wWUIwaFlsVG1hMVl3VStnazNwTzRCMmZ1aTcvYkJUTWhH?=
 =?utf-8?B?bnpjWjVyN3pHemFtWUgrZEVoMTBOQ0NyYWVMR3FUbWhyNDg5Y0l3R1d1VVF5?=
 =?utf-8?B?dXJJZDhMV3l4MnhXUGlIMzJoVG1kOWtteU9qY3pEMXF3SHZUZmF5bzY3MThJ?=
 =?utf-8?B?cUZ4SGQ2SkpaMS85YkhtVkZHMFRwbTVLa1V0SU5rdUpic1h3eWd2M244Qmti?=
 =?utf-8?B?WGNCbUNseGF1bU1MYnU1VEllcVQwV016SUNRZ2FHUlJLajJaeXJUYTFTcktu?=
 =?utf-8?B?YmJ1QnBxdkNiRHB6cnRIQTZnN2xVaFJuT1F0UmdYK25UV3NUbTUrdlIwNTQr?=
 =?utf-8?B?Q0xmNjNSYlRneC9TMVJqT24ycUJmZzZkeGJYVmk2eCt4NjI0Q1MvQjlWSjhN?=
 =?utf-8?B?OE5JRk1WYmE5VlpyQ21zMUVrN0lIeWQzVEk1VXpwU0N2Y1ZuWDliaTV4OU9o?=
 =?utf-8?B?b2Z1ZXJuVS85aWRTb056MGMwK3RralJQUm9FTGJBRy8xN3FRbWhhU2tLSDMr?=
 =?utf-8?B?amxOOHlJcm9iR3N4YXUwV2IxVTRPckFJQUZEczloOXYreXNsLzl4YWxmVkhl?=
 =?utf-8?B?UGtzdzFjUjBtV3daUkFLT0N5VmJIUlV1bkRVY0JNQWN6TjVDWnVBZzl5ckxs?=
 =?utf-8?B?NWFhaHE1VE5tL0RlWmtiRW5pbzdsdjh1UDM5cW1PTzI0UFFTejlJTVhKdmpM?=
 =?utf-8?B?b0ptMWhMZlhsaSt3VFFZcmhHUS9CWWEwRGlvUzFlNkRZdnBON0Z3NmlVTkg5?=
 =?utf-8?B?NHpFNjBrWWYyeFRLdWE4MTFNS3FUOC9hU0Jqam5jSVhwS0QyMkVXTytUbnRZ?=
 =?utf-8?B?ZG42WTVnMXJibEEvZXBwSHZuUHBqdWdDZWRoK3ZidE9EZmNUZWRNakprM2Yy?=
 =?utf-8?B?ZUN5a2djRWNwRWI1NE1MTDEyVFhCdVNvU09XdkhkQ1V6MlEyaDg1VHJsVi83?=
 =?utf-8?B?TS9iN3JUSlM5WTNaV2dsOG5TaTdPWmg2bjRSNFRmb01WZVRNSUVtTjFzZmpj?=
 =?utf-8?B?RDVhdzhDRitjMkQwMWJiSFcvcktrcjl4VEg5N0dzSnczZGdmbkNZdzlLajdH?=
 =?utf-8?B?SGxjMWVIY05xN3V2L0FaSmVkRW9mQXQvTkpieXMrL2F0T1p2S0Y3b29BODZ0?=
 =?utf-8?B?eTlIeE9rMzhGNlRuQWlSbzNjdnJMZlNXTVpxSWxaK1g2NHY0dExRZmoyb0Iw?=
 =?utf-8?B?NEwydHVoSnNHYTV4L3o1ZitJNmQxRUVoeGJhZXhOcXZyMWZISDZ6bkpEU2t6?=
 =?utf-8?B?aXpxTy9HcDRHMmoveGRDWGEzRWFGTGdnOHB0MEhMYk5sOWpxM2ZzbXNvTTN1?=
 =?utf-8?B?VkwwOW4xbEZYNTdMd2JJbjJWUWd5YklNZHh0RVNhQkFnWGRLQkdqYlZSVFJz?=
 =?utf-8?B?WHJtWmlLMGFiUERkK3REdm1UOHdvMjVUd29ocktlZ1BtSm9ZTTdOcTdrN1hq?=
 =?utf-8?B?YXZ0RENsUXAzc2dnVjdjUnFEcEQ3RWdkS2Vyc1NHYUdxMkZWVEwzQW9xQlJG?=
 =?utf-8?B?bmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb313a2b-0c04-4a0b-8dd4-08dce0cbcae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 21:15:06.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWPWsnrFnkw3bERcMD1pzdOYcIS6vb9qwAOx2ojOJ9JPqdJlSLdHOu9umJFReBGVp22w+/THtdP2/yQM7je1zx4PGGQNm8oV28BSS4nRzK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDI4LCAyMDI0IDEx
OjExIEFNDQo+IFRvOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gQ2M6
IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBucGhhbWNz
QGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2OyB1c2FtYWFyaWY2NDJAZ21h
aWwuY29tOw0KPiBzaGFrZWVsLmJ1dHRAbGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsg
SHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207
IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGlu
dGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+
OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY4IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IGxhcmdlIGZvbGlvcyBpbiB6c3dhcF9z
dG9yZSgpLg0KPiANCj4gT24gU2F0LCBTZXAgMjgsIDIwMjQgYXQgNzoxNeKAr0FNIEpvaGFubmVz
IFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3JnPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwg
U2VwIDI3LCAyMDI0IGF0IDA4OjQyOjE2UE0gLTA3MDAsIFlvc3J5IEFobWVkIHdyb3RlOg0KPiA+
ID4gT24gRnJpLCBTZXAgMjcsIDIwMjQgYXQgNzoxNuKAr1BNIEthbmNoYW5hIFAgU3JpZGhhcg0K
PiA+ID4gPiAgew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0gZm9saW9fcGFn
ZShmb2xpbywgaW5kZXgpOw0KPiA+ID4gPiAgICAgICAgIHN3cF9lbnRyeV90IHN3cCA9IGZvbGlv
LT5zd2FwOw0KPiA+ID4gPiAtICAgICAgIHBnb2ZmX3Qgb2Zmc2V0ID0gc3dwX29mZnNldChzd3Ap
Ow0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCB4YXJyYXkgKnRyZWUgPSBzd2FwX3pzd2FwX3RyZWUo
c3dwKTsNCj4gPiA+ID4gKyAgICAgICBwZ29mZl90IG9mZnNldCA9IHN3cF9vZmZzZXQoc3dwKSAr
IGluZGV4Ow0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCB6c3dhcF9lbnRyeSAqZW50cnksICpvbGQ7
DQo+ID4gPiA+IC0gICAgICAgc3RydWN0IG9ial9jZ3JvdXAgKm9iamNnID0gTlVMTDsNCj4gPiA+
ID4gLSAgICAgICBzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtY2cgPSBOVUxMOw0KPiA+ID4gPiAtDQo+
ID4gPiA+IC0gICAgICAgVk1fV0FSTl9PTl9PTkNFKCFmb2xpb190ZXN0X2xvY2tlZChmb2xpbykp
Ow0KPiA+ID4gPiAtICAgICAgIFZNX1dBUk5fT05fT05DRSghZm9saW9fdGVzdF9zd2FwY2FjaGUo
Zm9saW8pKTsNCj4gPiA+ID4gKyAgICAgICBpbnQgdHlwZSA9IHN3cF90eXBlKHN3cCk7DQo+ID4g
Pg0KPiA+ID4gV2h5IGRvIHdlIG5lZWQgdHlwZT8gV2UgdXNlIGl0IHdoZW4gaW5pdGlhbGl6aW5n
IGVudHJ5LT5zd3BlbnRyeSB0bw0KPiA+ID4gcmVjb25zdHJ1Y3QgdGhlIHN3cF9lbnRyeV90IHdl
IGFscmVhZHkgaGF2ZS4NCj4gPg0KPiA+IEl0J3Mgbm90IHRoZSBzYW1lIGVudHJ5LiBmb2xpby0+
c3dhcCBwb2ludHMgdG8gdGhlIGhlYWQgZW50cnksIHRoaXMNCj4gPiBmdW5jdGlvbiBoYXMgdG8g
c3RvcmUgc3dhcCBlbnRyaWVzIHdpdGggdGhlIG9mZnNldHMgb2YgZWFjaCBzdWJwYWdlLg0KPiAN
Cj4gRHVoLCB5ZWFoLCB0aGFua3MuDQo+IA0KPiA+DQo+ID4gR2l2ZW4gdGhlIG5hbWUgb2YgdGhp
cyBmdW5jdGlvbiwgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIGFjdHVhbGx5IHBhc3MgYQ0KPiA+IHBh
Z2UgcG9pbnRlciB0byBpdDsgZG8gdGhlIGZvbGlvX3BhZ2UoKSBpbnNpZGUgenN3YXBfc3RvcmUo
KS4NCj4gPg0KPiA+IFRoZW4gZG8NCj4gPg0KPiA+ICAgICAgICAgICAgICAgICBlbnRyeS0+c3dw
ZW50cnkgPSBwYWdlX3N3YXBfZW50cnkocGFnZSk7DQo+ID4NCj4gPiBiZWxvdy4NCj4gDQo+IFRo
YXQgaXMgaW5kZWVkIGNsZWFyZXIuDQo+IA0KPiBBbHRob3VnaCB0aGlzIHdpbGwgYmUgYWRkaW5n
IHlldCBhbm90aGVyIGNhbGxlciBvZiBwYWdlX3N3YXBfZW50cnkoKQ0KPiB0aGF0IGFscmVhZHkg
aGFzIHRoZSBmb2xpbywgeWV0IGl0IGNhbGxzIHBhZ2Vfc3dhcF9lbnRyeSgpIGZvciBlYWNoDQo+
IHBhZ2UgaW4gdGhlIGZvbGlvLCB3aGljaCBjYWxscyBwYWdlX2ZvbGlvKCkgaW5zaWRlLg0KPiAN
Cj4gSSB3b25kZXIgaWYgd2Ugc2hvdWxkIGFkZCAob3IgcmVwbGFjZSBwYWdlX3N3YXBfZW50cnko
KSkgd2l0aCBhDQo+IGZvbGlvX3N3YXBfZW50cnkoZm9saW8sIGluZGV4KSBoZWxwZXIuIFRoaXMg
Y2FuIGFsc28gYmUgZG9uZSBhcyBhDQo+IGZvbGxvdyB1cC4NCg0KVGhhbmtzIEpvaGFubmVzIGFu
ZCBZb3NyeSBmb3IgdGhlc2UgY29tbWVudHMuIEkgd2FzIHRoaW5raW5nIGFib3V0DQp0aGlzIHNv
bWUgbW9yZS4gSW4gaXRzIGN1cnJlbnQgZm9ybSwgenN3YXBfc3RvcmVfcGFnZSgpIGlzIGNhbGxl
ZCBpbiB0aGUgY29udGV4dA0Kb2YgdGhlIGZvbGlvIGJ5IHBhc3NpbmcgaW4gYSBbZm9saW8sIGlu
ZGV4XS4gVGhpcyBpbXBsaWVzIGEga2V5IGFzc3VtcHRpb24gYWJvdXQNCnRoZSBleGlzdGluZyB6
c3dhcF9zdG9yZSgpIGxhcmdlIGZvbGlvcyBmdW5jdGlvbmFsaXR5LCBpLmUuLCB3ZSBkbyB0aGUg
cGVyLXBhZ2UNCnN0b3JlIGZvciB0aGUgcGFnZSBhdCBhICJpbmRleCAqIFBBR0VfU0laRSIgd2l0
aGluIHRoZSBmb2xpbywgYW5kIG5vdCBmb3IgYW55DQphcmJpdHJhcnkgcGFnZS4gRnVydGhlciwg
d2UgbmVlZCB0aGUgZm9saW8gZm9yIGZvbGlvX25pZCgpOyBidXQgdGhpcyBjYW4gYWxzbyBiZQ0K
Y29tcHV0ZWQgZnJvbSB0aGUgcGFnZS4gQW5vdGhlciByZWFzb24gd2h5IEkgdGhvdWdodCB0aGUg
ZXhpc3Rpbmcgc2lnbmF0dXJlDQptaWdodCBiZSBwcmVmZXJhYmxlIGlzIGJlY2F1c2UgaXQgc2Vl
bXMgbGlrZSBpdCBlbmFibGVzIGdldHRpbmcgdGhlIGVudHJ5J3MNCnN3cF9lbnRyeV90IHdpdGgg
ZmV3ZXIgY29tcHV0ZXMuIENvdWxkIGNhbGxpbmcgcGFnZV9zd2FwX2VudHJ5KCkgYWRkDQptb3Jl
IGNvbXB1dGVzOyB3aGljaCBpZiBpdCBpcyB0aGUgY2FzZSwgY291bGQgcG90ZW50aWFsbHkgYWRk
IHVwIChzYXkgNTEyIHRpbWVzKQ0KDQpJIHdvdWxkIGFwcHJlY2lhdGUgeW91ciB0aG91Z2h0cyBv
biB3aGV0aGVyIHRoZXNlIGFyZSB2YWxpZCBjb25zaWRlcmF0aW9ucywNCmFuZCBjYW4gcHJvY2Vl
ZCBhY2NvcmRpbmdseS4NCg0KPiANCj4gPg0KPiA+ID4gPiAgICAgICAgIG9ial9jZ3JvdXBfcHV0
KG9iamNnKTsNCj4gPiA+ID4gLSAgICAgICBpZiAoenN3YXBfcG9vbF9yZWFjaGVkX2Z1bGwpDQo+
ID4gPiA+IC0gICAgICAgICAgICAgICBxdWV1ZV93b3JrKHNocmlua193cSwgJnpzd2FwX3Nocmlu
a193b3JrKTsNCj4gPiA+ID4gLWNoZWNrX29sZDoNCj4gPiA+ID4gKyAgICAgICByZXR1cm4gZmFs
c2U7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK2Jvb2wgenN3YXBfc3RvcmUoc3Ry
dWN0IGZvbGlvICpmb2xpbykNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBsb25nIG5yX3Bh
Z2VzID0gZm9saW9fbnJfcGFnZXMoZm9saW8pOw0KPiA+ID4gPiArICAgICAgIHN3cF9lbnRyeV90
IHN3cCA9IGZvbGlvLT5zd2FwOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCB4YXJyYXkgKnRyZWUg
PSBzd2FwX3pzd2FwX3RyZWUoc3dwKTsNCj4gPiA+ID4gKyAgICAgICBwZ29mZl90IG9mZnNldCA9
IHN3cF9vZmZzZXQoc3dwKTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3Qgb2JqX2Nncm91cCAqb2Jq
Y2cgPSBOVUxMOw0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZyA9IE5V
TEw7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IHpzd2FwX3Bvb2wgKnBvb2w7DQo+ID4gPiA+ICsg
ICAgICAgc2l6ZV90IGNvbXByZXNzZWRfYnl0ZXMgPSAwOw0KPiA+ID4NCj4gPiA+IFdoeSBzaXpl
X3Q/IGVudHJ5LT5sZW5ndGggaXMgaW50Lg0KPiA+DQo+ID4gSW4gbGlnaHQgb2YgV2lsbHkncyBj
b21tZW50LCBJIHRoaW5rIHNpemVfdCBpcyBhIGdvb2QgaWRlYS4NCj4gDQo+IEFncmVlZC4NCg0K
VGhhbmtzIFlvc3J5LCBNYXR0aGV3IGFuZCBKb2hhbm5lcyBmb3IgdGhlIHJlc29sdXRpb24gb24g
dGhpcyENCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0K

