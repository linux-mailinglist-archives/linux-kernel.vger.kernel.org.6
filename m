Return-Path: <linux-kernel+bounces-343182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F0989789
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E3CB21F5A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC08757F3;
	Sun, 29 Sep 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qb4Puk6Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6781F94D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643815; cv=fail; b=Ag8xX96x9R+mq6dB5MVn8BSi6BY47LUWvbHm4Sj4M8VtVh1JkwB2U/fqon2VG4CvieGV16YgLlzQ5esutX1l0pJ5isThLzcqtcmMYeWzS5rjNLqir3C4BuxSaiwuo3a7a9Stj96tIrZjBvWfxekedYrY5jQsyWUuChFeAxU4sdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643815; c=relaxed/simple;
	bh=7L0Mb1ip/kJf2tieruDP5cCala+WgwHS6UStWz+BL7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+VPjUOxrf6QawfEIpaySh0wEPThOwHJVy0IOqTNo0vAtZAFypaDJL/f62oXXWBcol6B2AuVxE5bueKtCPl1X7RKMivsy6/M9ZhRtVqDt1XLH32kzkusL/rSO7N4rKNEKV+O1wU8f9IAHjS3Dxb4V/tuXggNqwZcz3j4dGYEAOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qb4Puk6Q; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727643813; x=1759179813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7L0Mb1ip/kJf2tieruDP5cCala+WgwHS6UStWz+BL7k=;
  b=Qb4Puk6Q4eCMHYtlH8p1tGttH+Nxz1LB4gLamJt1pEyv1lL7ro8QMnyH
   y0ag+unXhYU+aN5mUU3VnpfB25fCKwTexZzUYZmAHoKRUPPNVkLhtpV7Y
   9tJqRfTQit5Sjq63MspAP1cX/H1kM/AU5PyRw+GuP6l5nIXTUMGmjwM3A
   1ZQNMfG3m7CaTQWOZ08wLObdjXrtwL0WNZz7/VqFprKBnmNyZQcVPn/A6
   dgWm8wsTsqnqhrvHfaYPvPnaZDTUTQ2+tFVRieYCFpS/SDDZ1fKiB/NM/
   z8ITL/7d7g7Hg1nmdpEVPbXNgvYv9CLh+OIvXeJmlrkbLCpkKxemaKtGA
   w==;
X-CSE-ConnectionGUID: OXC9el+mRX2J+zpGaNzfiA==
X-CSE-MsgGUID: Bh7covlkQcygSTl1mUCyYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37860511"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="37860511"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 14:03:33 -0700
X-CSE-ConnectionGUID: TolquxG8TY6fFsQb4FCbpQ==
X-CSE-MsgGUID: KrJuVIO4SzC3X4mAkufvXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="77175581"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 14:03:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:03:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:03:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 14:03:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 14:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNLCsTwLDzeA2lFaiyQK81IpLWXwRu2MdlNvRnGKoZTx4tX3aF7S8HiKKMcuKX/nhVLeSaEjFOoHuzuwhs8UK4BCER3wXXK/qWMlVcTaRsxl+KjlRBL0IXCp78VebHSYvH5JiZqWGkDT3YlcVL0iZ+noKI6+TlCQ9B8WHHpaXgSMbuCLtSVIhYcN6o7Tu0w+XtpI2YF2SSDoxU4aEBEnQTfB6fJR/FQkkVDFpRCPp7IigSHdBh17MUrflST25umyZmhArb0YHWeEfr/Vrn8x89c5mRX74HgG3dExoLALTq5g6J0iAja/GzJM6Ji6PTVZfjNzGBLuU5vbhUU7/G5eHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L0Mb1ip/kJf2tieruDP5cCala+WgwHS6UStWz+BL7k=;
 b=YwOFkq44wS71WgWRIhmtc+A5vQJf+vwacqMPB05LcK3J8RzjJ3i6f1QUikeMfJQ8harcEa75FKEkZmk+uMr6JLq4u/sNmMTlfMTXGBB3pHXhQmlo2ayuukaXWDY66HwnOIPRRm133sqbJc0d94MZ7oS4srg37po3f3LEcVhn8p8kSYzVLytdPlSE5EKgpVxbXMup3ZKdPftCIDCUjE7CZIh2lYp9k3r1cPng/i2zyjtpeIimvKhbCnL9+g7jaksLH59L29991R/7rsRZ9IAAMMMWLaFrxQA2VaqJaYgqOb12VIwNdidwJAx3QKKw0t0nit+IIhoVuUdcbw8HSWSaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 21:03:29 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 21:03:29 +0000
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
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be
 atomic_long_t.
Thread-Topic: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be
 atomic_long_t.
Thread-Index: AQHbEUxtX8wJ6hQufk+pvmzXqUB7f7JtORMAgAIKJDA=
Date: Sun, 29 Sep 2024 21:03:29 +0000
Message-ID: <SJ0PR11MB5678CADC4658BDB1628C0238C9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
 <20240928135346.GD957841@cmpxchg.org>
In-Reply-To: <20240928135346.GD957841@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB6967:EE_
x-ms-office365-filtering-correlation-id: ff1ed610-e254-494e-f624-08dce0ca2b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hRMQsKSZ0bMyuw0pS0+sxLxLBKNxYsYC1N4yH3ytqhJEpV2Av9NykLqR+F93?=
 =?us-ascii?Q?Le0OzJtkIR1PQ8nt6x4k6wZVl5cUmecViL9Di/S7YcnPz4Yx5F4AwkM9rHqJ?=
 =?us-ascii?Q?ms37HpDiH/4yxuF6t3YF1Rv6rf+DR9y/zc+m+wajj0PZakBqRiTITvjmnYdZ?=
 =?us-ascii?Q?5tjkJNYaTiNbEpQs94aippb37lLA2xsgiwzqTsi7ZCZPFeRFs2Ep0xnMpOfq?=
 =?us-ascii?Q?NLu9op24Q/P/j080ci5vuSS52rqWQu4KSIjQCDZgitIfkhzkUCWwv2i9ITpG?=
 =?us-ascii?Q?o7kJXTUXTzSFjJdDFicZsKvY2WEdZ/PKLijE6HfT5Wj0PzLGJIvdKbKzQnMd?=
 =?us-ascii?Q?+gGe+PzMYb/5EX3zQMF2TnkC6VkwoUFlpg/UkFiEWZxZbTr1ZVw227M30t5w?=
 =?us-ascii?Q?tClG9sPd3WewTs+GQlhjYL6+YoBySP5SEBwsfRjH9M3sjOKVawRxl0urVJNs?=
 =?us-ascii?Q?OJ8LMJxqMR+eQqE5f5dfdjfc0m13Guuqquumv0nhlgWn78jzKJcT7doD0Qre?=
 =?us-ascii?Q?vaP6Hg9w4j5ePIr4aM/gSXGUAEnm8T5Dm11IQB/3sFEfIeiuzSf8G1hn3PKx?=
 =?us-ascii?Q?XG0Szfn2lziYG6pP76ZHimsdMfZTYkpP/T4UqgoIIwAL67TmRfrOFd08Js4N?=
 =?us-ascii?Q?9R0ItuPegMDTclO4yInKX21Pbep0yEvUQP5nFDLy6Ep7JlV4BAXdjW3zq7Q3?=
 =?us-ascii?Q?fjrRb/cUHQMzYM4JiiatSHymn9C6HhXgLUlJXeflM70u20XmherleUeTfr7c?=
 =?us-ascii?Q?gw2SbbAonoTDoL0Q9AhcIr5Pu7nKpnv9iOu9A2B8bQfvrQmpaLQGkT9LD33B?=
 =?us-ascii?Q?jjrY74md875uDZLT2JtNzQFgha8dZinmRMbZSPZ7zJnvLy/trTqzm+HcY5Bp?=
 =?us-ascii?Q?pxU4350LAsf1Us6OwRtHXqT4PgEPlF5pGKtTQqWD0+7Csid4hrUMNvcwfGKK?=
 =?us-ascii?Q?ibDWuybUMWJXKTAVM1Ng1OvkurXATxSOBsF0JiLL/UuTl2ERcAUI7K0XIZBX?=
 =?us-ascii?Q?e/Rw7rJWbChSEssNIAyD7aVDPLN0uxSYleG3mnJ8N3VEn/pf+2CCVEbb7B69?=
 =?us-ascii?Q?aWZqywleQFyXtbIcn3GGAtKDDnW7W0aEIPUT9xXsNNBTAhac3kGuRjX8TZx3?=
 =?us-ascii?Q?I3MjTlO0drYeT8UC0ELl8Pv+Lm1WLpr/HssxCXfC/+BSrb+dUz2MnEn3JWTu?=
 =?us-ascii?Q?IMTAf7AB+N1GtjKlhkWs498JAYL9m2+Mq8YdxhrQhvD1SgNLVhXVER0V6hw3?=
 =?us-ascii?Q?OkSSqFSLVGWGCj8NSvbhMPLEe484SkyeLl2IS9q3CnBZTETfMsi/mzEyp05U?=
 =?us-ascii?Q?6bdT3D0wXVTFIEZlh4waLL8kVSZ/4XAAUHJXtbRsAo719Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WBK/KhuA0u+/9RZgjadzmszpxX7n2nyGR340OuuP2SMbWGn03Ozmp7NQPnd4?=
 =?us-ascii?Q?nAca1nWX8sP/0YUt7EgH0e92WaJeStez8yXTyyRovZT1+xFSYs8Lf41SlOZm?=
 =?us-ascii?Q?kohzESP8MXYgvCDwTtEEn+H6vNE2nzTE158RmSwxFKCrefByWowQW4zYdns/?=
 =?us-ascii?Q?lYV6AmO+vk/h44+H3yXbZ8lrNf7/eRY+eOw93a2F+bokPb6tZlS49FMQyFd3?=
 =?us-ascii?Q?wTsfzmShLKHDMlTWrrXij278PtuIFHuGOfdl7XNdDhtiFfIhLnJbqgl2Ydzj?=
 =?us-ascii?Q?o79lM1msAs8HYlbXeQRbyd3t2/DsHYfFnb2kLgqe22PbgzeXSm2bbPxjA26G?=
 =?us-ascii?Q?/HwfxHYUgKg2pEZwLiPZKsQoQ1/Vmfqcxhw1lgk3mOaRNG6M4jGEmwKk/wi2?=
 =?us-ascii?Q?R91PZkWOdc/4QUmmFv7+AI7dVFnw19bw63ORhSBigZOhBybcdgJI95UOC/c+?=
 =?us-ascii?Q?SKUM5OdQQsB1NtfFy9ILjhEcL3UtExPejiHfo447/cCTjXlc5Lk/GSpIzAmc?=
 =?us-ascii?Q?OFraXV7DYPAAQNQbRs/NlPbcA8p3cx5ONDnDkWLSsVX07OZgCEwS2qdAwNCe?=
 =?us-ascii?Q?1sG8BEmrpnGfhml3RbeRHlQRiQEpW0/XdlFJXSULJfzAqgdTWa6V7SYqDGf3?=
 =?us-ascii?Q?DDeyhz2ulxKgf3qgcDmGdMdWPREsr0Mr2AzJUyVE9Mqu+q6boM94eg7Y06f7?=
 =?us-ascii?Q?y+v7uzp339S+ahyZGS/ti0kZQIu20rhHUw0mDMVqHdajmbpBhGLvCJQWv7wc?=
 =?us-ascii?Q?iBDop2BX0peEmBGtoksMRFLeec4RuZYOMAZh1S/KrQOzrcadBxYOxzaS90uk?=
 =?us-ascii?Q?6aw1/0mE9Oz/rekrnGpfNcJC4y9tiV/H2HLGzXnXPMpYl4B1DAFmMaeGA/s+?=
 =?us-ascii?Q?Gt0QP04aX3Ap5tc0mJpkIBoNyDUsjeFd3JzU1Avy2vyv2QxtVznnjzQkBavx?=
 =?us-ascii?Q?vkdTcVcTZbP5S34Vj68TS5MI+zqBbKnJGF4ClC/lVLbFSEid3IcQmqS6HHZh?=
 =?us-ascii?Q?zIkRw9ux9ym9U8zKZ01ZxeXAphNzkdupaog/TDwhnbK/bKX5plUqTh9J7+sR?=
 =?us-ascii?Q?caLqMclN5vwYcWOAw9IwjjUuf39PgE/y/IqKoBfzvt5JvDu4sscytKYpsWsN?=
 =?us-ascii?Q?6OZxT6bDJoVOHDd8FtwQiD4sotvrnDKQ+GpweTWQ6RbX9pBO8LYjpqQ9FK9m?=
 =?us-ascii?Q?+fDqbfrdXGZiv88Rw6YIhpVSMfLbYud7AA68B4Qq6mb/QtcdAZ50k3i4OIX7?=
 =?us-ascii?Q?gJdC1oN4Qp0i4/2xKOm+nJEw/grp3M1X1BccNzaoECxODOdS3aXK3IBZrsWF?=
 =?us-ascii?Q?DdIn575fGg7dgxHmPh85AoCiw4rQK3IFGdor1LwYWYDrB8CLjz3EsLIzWBfR?=
 =?us-ascii?Q?3EyUYNKkTfHkLQm7WLCZaaCTJLR/gqhd9aiHkkxBcM8rQab6NzbB1vLEBT6w?=
 =?us-ascii?Q?LaXSKt7HgRwbp1JYMkt79JydVEuIJZHqeD4lYH11MJmCWKGSQ/JiEPgmIEp8?=
 =?us-ascii?Q?mv1oI2GyObuNrhbG5Nx7zBTXYtTfccnlPoYcwabW0QsHWmmToDdOJuoKqNW5?=
 =?us-ascii?Q?Ss1C2VfK4iFeG0zJq1r/iJPX28vHKjunoemxKnbrUXcMyc1ShAnIgKzeZ4t+?=
 =?us-ascii?Q?ew=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1ed610-e254-494e-f624-08dce0ca2b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 21:03:29.2090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTVANthlxs1oIFY1P4r36F3R7gQJizCygymPm9w6pTJpPaeR843wTD1am5giQccHm8UPLLSJAdd6j/GQEVCS9DhTII/UzM1x8Jb0Y+oBHPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Saturday, September 28, 2024 6:54 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be
> atomic_long_t.
>=20
> On Fri, Sep 27, 2024 at 07:16:17PM -0700, Kanchana P Sridhar wrote:
> > For zswap_store() to support large folios, we need to be able to do
> > a batch update of zswap_stored_pages upon successful store of all pages
> > in the folio. For this, we need to add folio_nr_pages(), which returns
> > a long, to zswap_stored_pages.
> >
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>=20
> Long for pages makes sense to me even independent of the large folios
> coming in. An int is just 8TB in 4k (base) pages.
>=20
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Johannes for the Acked-by's!

Thanks,
Kanchana

