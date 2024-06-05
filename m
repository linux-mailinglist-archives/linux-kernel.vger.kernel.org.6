Return-Path: <linux-kernel+bounces-201994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE848FC648
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B8B1F249A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F1190077;
	Wed,  5 Jun 2024 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8MV64Sc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941D18F2EA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575833; cv=fail; b=ok9Q4D7lKbn9SQLwSmcAztaffIriIwmsQd45d5Nqp3mhmZUd1sxqYZx0FSd7qW4K4bF8ejLyDX8Te/lR38b5I5HlHU5S1TesjOXWkNhLwfyJByT5cpTznFE86k9eaG6nQAa3gwbujBtbTP4nXKT2gNfgvyZgnmaMyURBxZTDlaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575833; c=relaxed/simple;
	bh=Jwtno5gUzXxgN4bG/48dY6ycTCD0bSlht25ZLJAV/3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G9JbZHyrj5Qnifw7F+GmlmiDCVdfzX1o+bTPGsLzwSmDPAjR2w52urk9vwWdAgQvCrGqCBPvxg+MpzleA2VO3dXYL3x5DxCO7Hr0JIeXiexGK99oOYwIC60EzEO1b+6EPBC+VzHrYulxX85RA6TosTtLqjCKkBmiAY03YDSJ2qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8MV64Sc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717575832; x=1749111832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jwtno5gUzXxgN4bG/48dY6ycTCD0bSlht25ZLJAV/3o=;
  b=k8MV64ScsYnG4W2Uq/Q6O0j1Z1EuEZEZff+fda31Y4g3ii5oNy7OWTi8
   83/ozf3Pwcmm1fL+ka20IrBPihWgyhU7OB4Nvkyag208PpZyDvOsibauY
   3zuMSERPgq11QWvBp8JvLRyOBUeq05lu2Sy+WzUhp4jz3HjdBZB1yGTPc
   W1lEb/xoN1X2uyhVeDz06LPStRjHIEqTQbaRDELHSeYvgEMn3vLdibEc7
   /3tIInn6UWazICH4PCacBdWKVmNKvo3sq7ePCPEUQtmoNNkKxhEdxZ1Lk
   ehbqzI5TV/q+5NujNyWpqyWe/7HnJhWal3N+yaMPVnzrl1Em34NN6/hoM
   A==;
X-CSE-ConnectionGUID: QqkSPUxSTp6kqkNekcGLDQ==
X-CSE-MsgGUID: hJNGUvzfS0m/iX29Ojjxeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31706697"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="31706697"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 01:23:51 -0700
X-CSE-ConnectionGUID: RlkGEJ+iR6WieNwX0gYVGA==
X-CSE-MsgGUID: 0NbUVahGT7i75ZqRi9SrZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37451984"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 01:23:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 01:23:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 01:23:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 01:23:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 01:23:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4h7q56hZz7PU/YgIMUFB/MJPTtlMfkCNmLP1w+rqsYhK61cNWs50YeV23mlrSMsn1FegPFCcCFItr4Y/+DOOl1fHDpiQ0Y6eBkZx8RgKh5hohzbbyutCQ7s/vs+uNmP1uVhVx8T5eCPoHzyy9vXZeuH+NbGxF5RX7QRFikE/4GwylTDonCUYJNxFnHDuZLCATYIVlflp0Dn4+46QX6WsciHe3nRt2vkM6vXtgZloIVWgyRxricK2A6tcZC+XwN3Z8nWv80uZ7+/U1yTC69i8c0VxMuoY3788Nc/obMe/9Yu9NmP+7wdx3GIqsdqF5XoH1/r7JB6rQA9qd0GRRj3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnTRJkws6lb7Xd95QfFfxXbyzTeIhF480E2FwwXA5yM=;
 b=dBLZ4DjqmWH3nxjJXLFPr9MLw/iF+/r2u0agqkczN8YMNIn1E8wRn99hYjDgB1sammTS9447GVDqC49DioWEyjYIw4SdMf0repFU26nD1fphg40XLCt/7ABI6v4p4Oh/X+28mhuaOT4WSDi8t9xAXSGmQDO8ccqP+lVKhxCqqVCt+mFxpC88xcLIFxKef4IgUHl4wlqZYa/5g2ShoIjdrKdSBi5JjUzh09ELz5od42/hRd9RuAn9WIPIkVqTCMQZBnJh1Nq2MCuSbiueW5BLIXcIYGi6fKSSmoUwkgrHz6KErdiWPEvixxFsD+IzFFMLVp/dQzJ9cxRll8iFfT6LoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 08:23:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 08:23:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Jacob
 Pan" <jacob.jun.pan@linux.intel.com>, Joel Granados <j.granados@samsung.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Thread-Topic: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
Thread-Index: AQHar+trvfMHAAWIn0yqbyY6VjzW47G44V2g
Date: Wed, 5 Jun 2024 08:23:48 +0000
Message-ID: <BN9PR11MB52764CBD6B889A07A8CCB4918CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
In-Reply-To: <20240527040517.38561-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7520:EE_
x-ms-office365-filtering-correlation-id: c5133e7c-473a-493e-0d85-08dc8538d2f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?us-ascii?Q?XNzlnM6kALoM5hcrPFiZLCISASSdmcMg0Sl0ll7eYnS70ziQb24xwuLMcuX6?=
 =?us-ascii?Q?P8/A6erAyhRJzkEYBF4A47Aa8DSFtXYTw9lUM/xfeMIj1n/0zRh3gRcvsqk/?=
 =?us-ascii?Q?3R8xfB/h3vaGgBaEAbPQuTvjsDEOVGDEHVtFsKD60apLs3/3xhH8PrBe/W7E?=
 =?us-ascii?Q?qQSe9Jd3+qHvdRNG5rId2pMkwRnKDb5z9rQI4Nh3FoiSeeKylfufw32GpD5z?=
 =?us-ascii?Q?edP6sOUKF81YPPO3GStduZoFywTp3kQLeXhQjdnYGmFJ5Hd0MuLmm5KaT/EZ?=
 =?us-ascii?Q?ODqh2B8EcavBcf7VNzrFjeb1e5a3qGZAHcpWmwR85ZJKS3J94Nn4GOraEtJv?=
 =?us-ascii?Q?jfqsMrzun4FOplQiLnB52hpLIcmwviXHyi9vKJbv/nKaz4MgSBIk/5H8p+jn?=
 =?us-ascii?Q?LN+09ih/n3jVfzfJsUaM1LoOrAg6SAHNNrltrTHD+PgqYUWJbk1tQkUO3v1q?=
 =?us-ascii?Q?j/pZo5nyB7aERB3pbE6mWKRXeVxC6n/TjPLWHNOrv6+4ZSRr+PU538PACPq+?=
 =?us-ascii?Q?EYK590RrArTj/lq9d1fFpYKqPwSnMmEmhsPybgVnp9O8rsA6B/GZBk7jhAox?=
 =?us-ascii?Q?dU3cl2/vP10nso/jur7pIlWbkJTbMcLFHyoHdZX3DKpe0G5OHs1Iw+AxH+gC?=
 =?us-ascii?Q?U6vneXj4jqUMTjBxFtClLOYrJR8tW04WkRzZJdN3rCiTl6wVeNMdyrPkr9NJ?=
 =?us-ascii?Q?JEQ1ftr7MCzt/pWopfnXqL9oV39L5s+ujwfVluniMZGBM9Vge91P0vkS8qfa?=
 =?us-ascii?Q?SoIGwNBFDGChmFz9lGbmqitCYw9y0dtWm+7cWm7DDcq35xFsOdPVkogkt09z?=
 =?us-ascii?Q?AkZmRXeCqtj8ReR8+M9EhYGVIVoV0HS4p3k9ZSaimNI6LGLFIk6LxL16ajCr?=
 =?us-ascii?Q?BnxG9srtDulijsJRN9rCDbJ+Zw97csSVRE5E8qU77UdqU8aOx0td5JlmTL8b?=
 =?us-ascii?Q?TSBlfrbXDSjCexNRwf+yzxvfp/HK9E3hJHDMI2VQWeTLYVMFqpTXGDxi9sxb?=
 =?us-ascii?Q?k/c9Zce9UwnwcamKl/hHYlaNLp4GcfeswTUF2mM0xY/LPdEaLrsozZYnzl+v?=
 =?us-ascii?Q?zxZkjyuGtxICHbIXbyrEotyA2UzGLPqhAWDGLK6Hy+AxZ9JgkAsg7797KVB5?=
 =?us-ascii?Q?PRGTrWbpxgJ3fSWH9szOD2dezvUALMSVEVPnzyO6Zg2krHawz9UNtV4u3QGB?=
 =?us-ascii?Q?wb3WloIR1h9MDhbGBR+6j5qwUW+BlfTKAtN9XRkv3C8b4G6qjmb5yaECHhCH?=
 =?us-ascii?Q?WaOa3l9AQDknVsMdej41DgVrvR/OWQGlJnBW8ARgBTjMrWPD4GGKq82qOIBF?=
 =?us-ascii?Q?YcDIwIB92hnOSJ8gT0egRE2LD5SXONGZ1DR8hnS1fYCWMrOpUQ6OK/PYsyn7?=
 =?us-ascii?Q?7HIxoMfYKRWowFYmROribOG97B9B?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qcyjCY8egMDtZB4cRCXDu0wiTM7rI2Sry2R1aekqq/Nd3wnKZpkP0XWqqshs?=
 =?us-ascii?Q?pvVk2CX9zbTv0E/X95af+uPxko5SSmulmMKF4wn++mJ9sSerDrMpAk6k31X6?=
 =?us-ascii?Q?ifqxy7l7840IGnUHvvQSgxiUepyEW0lbcLwfF+lShK/Xi2WzLxC/z99BwJ36?=
 =?us-ascii?Q?yVY662YbqdoM0xcW6RCIj1pvexPZpkrnsxPuyQ0Vx5BQ8kBllIhdE0saR6IZ?=
 =?us-ascii?Q?9+yYr4y/4cXh+kr16wre1xpdu5av44ZZUdyi+BhgfQ7bUy3+qY3JDx+iftuM?=
 =?us-ascii?Q?CJb6FkxppqH+ZONVPHEww/L7QIPua5AVAwjSx06gA4ykiSq6ElvN3H2i3X4W?=
 =?us-ascii?Q?k3l7VI4OJNtoENhuJIzCLNasGPG7U35XOJ4m1OfofEvzni/tVfARAYNHSjcO?=
 =?us-ascii?Q?f7B9lmsXYM4gA3xkvKVUlCudlEv/et7KeM8ElJit4VK6Q2L6arL8qCOzQYuW?=
 =?us-ascii?Q?jseviRBUXSGv7C6KoiOXYZSuj+1C1AyNQQ1p9a2PRw4dplR0qZk0xZAnere/?=
 =?us-ascii?Q?K+uyH6RPiLHdRZ1ReWDLbBWZsdmDsEeFAHrXilhVNHMtBi+705pVWFYzDBTQ?=
 =?us-ascii?Q?oiYElc+2pIrpUlxKCD7c4jsOm18Lv4M5wGV0j+308fIMYeP06I3pN9ErfNI8?=
 =?us-ascii?Q?T9xsm996zbIBRI4ZZlKuLgHar689MzFl/39XHTsgxdjTv8+U3unV5uS97R7h?=
 =?us-ascii?Q?HzrRMyn6Nw4LgQfu0JuXtsNhAwKYfbNT66HTVSmQpTMnq/rn8FTxWQ7dw71Z?=
 =?us-ascii?Q?VpDt71JVf4ecgIUvhkCzcJYV8iRANyjegJkbLyIw8eNHicF7Cvbpg/N8x4P1?=
 =?us-ascii?Q?SvI9RzUJW51tfjYS2WOmeU1Bm+7S8q6OTg9Mkj7gacHXOOtaQp2CiIJrlY0g?=
 =?us-ascii?Q?EnXsKyxBV8RtZ1JmamY+p3NlY8KvVWkGPrJT/VQzzvCnyLKGRXdp1qCXu95B?=
 =?us-ascii?Q?dAp2XeD2/nsAhaXANoY38BkR7Bn9EUoX46FM1HsgsgOpHbj3RTSS67MO+v5x?=
 =?us-ascii?Q?3V7HuvI6Mr8jrW/wAlnlil9Ci6Csb8Qjvb8qZbDzjYIX5sfB9SDqZSCd3rlc?=
 =?us-ascii?Q?3nO1vILIQYJBeNx/nEw1eoFGUxq6ag6Y6hWQIl2NLDbrDTBqcxgifo1eOKn1?=
 =?us-ascii?Q?F19IjIiRFoP+xuDfOlGLL3qZVyCeH/XTeD4FUSRc32eV+Yf6nuK2I5/4Vtw4?=
 =?us-ascii?Q?tMd83gyO7x1FuWiI06t4EF5Q+Q4bS+itv9qE/1lvNJoAGL/pLsuFD8M2keLd?=
 =?us-ascii?Q?DDu6AEcsqpMvMyKPdqQJ4VQthMYH8iUqaAqN5MYvFywlgzLLBfVE4YB9pXxe?=
 =?us-ascii?Q?sT9DOx+6AzuLrpXXoN/WAOvP4kqqJd/CsASZBckFSmait3pi597h9ezlron/?=
 =?us-ascii?Q?TeInNOrv22n3TnAx5feR/2M/v5leYlMoEfhR7HqaIu7N5FEklUFclqwd4yGA?=
 =?us-ascii?Q?LWPtU8AyhXcoKnHXkzLZJAOEG6EjdAwz1dD4XBMYPf4dLBXC5hFCTdV6udxl?=
 =?us-ascii?Q?zxeQS4MK9xQtZqUIym4725k4jdYcjA4L/t0tXkktCqejuijiMLfL6huvowyR?=
 =?us-ascii?Q?tGcBZ24INDh4EJ69crdgU72m0TcMB+6tCLl2FMUb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5133e7c-473a-493e-0d85-08dc8538d2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 08:23:48.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPzaIGL7NP5MJgRGu8ezVPzG3Bhyci/sZSIzrhuJGh1d/XIaJF1cex4zMlo22s4rM4onA0wtlHpG2astvNEzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, May 27, 2024 12:05 PM
>=20
> @@ -249,6 +249,12 @@ enum iommu_cap {
>  	 */
>  	IOMMU_CAP_DEFERRED_FLUSH,
>  	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty
> tracking */
> +	/*
> +	 * IOMMU driver supports user-managed IOASID table. There is no
> +	 * user domain for each PASID and the I/O page faults are forwarded
> +	 * through the user domain attached to the device RID.
> +	 */
> +	IOMMU_CAP_USER_IOASID_TABLE,
>  };

Given all other context are around PASID let's just call it as USER_PASID_T=
ABLE.

btw this goes differently from your plan in [1] which tried to introduce
different nesting types between Intel and other vendors.

I guess the reason might be that you want to avoid getting the handle
for RID on Intel platform in case of failing to find the handle for the
faulting PASID. and save a new domain type.

this looks fine to me but should be explained.

[1] https://lore.kernel.org/linux-iommu/0de7c71f-571a-4800-8f2b-9eda0c6b75d=
e@linux.intel.com/


