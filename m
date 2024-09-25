Return-Path: <linux-kernel+bounces-339534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739DD98667E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6528B217C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3E127E01;
	Wed, 25 Sep 2024 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuZaAa1T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3211D5ADA
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727289937; cv=fail; b=RfML7bhrsXT9GPE6Rawme9Yn6oF3lqsA1m7Br+p+WVmZIW9BGpYjqoTdAoXp38uYTiMUTPhW4KnKQUVasAcj8aM/ydlZd2V7pNnt3H9Cit5d+i1BfD/+9gXLUFnHvkiqvs4hAHSd6SQ47fD68Nct+oNSw51OkAC1NIcp3/bv6oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727289937; c=relaxed/simple;
	bh=qtUVSICq4mZooJxsDpNqo/5Mi7u25/gGrNyU4++5uBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EJb8S298kT4DF9ck+h0CipZSdotr7t077ZHO6TT8i2tcTsA7NTFt5S66+/exoMZWmuOKDOsiNoNey6vCVe8RYeFbA/aCHEG0LYzle1wgzZwpjC2iJ1z7S04UXZCHRbJwLg5RZhPz9p5TZ4ZvefA5QkUMbSG6vQbeg98ZcXkgQ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuZaAa1T; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727289936; x=1758825936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qtUVSICq4mZooJxsDpNqo/5Mi7u25/gGrNyU4++5uBw=;
  b=EuZaAa1ToFbsBNRrP8zKCIiVcHo+ElNEMj2xlOx+Ns6oebjnyvOUPDDM
   L0CjaSmIX6P6iUUEvtJpvEk7vgctuMQN+kKvLtV8swVoaEkdsdCFz0m8w
   6oPfeei/dEJM+QOebnaqOI/7c/10YxRcuoIcBeeycAJOI3paAxzH7JLua
   9h3KCWOu7J2rO0dk034k0V6snNwbaMaeMR9zRo3psPkR51jhR1d4vHG0e
   UIhu/1JxAFBgUWE90Si1fvt54+fyItllRtMePnQo1RFFKIFGo5x2e6JH5
   Mm6BA2Wz/IJgNIaE/q20c4/bNoUJ9A8N0zGrZj6CjmW+ZWeij3Dgsf96C
   A==;
X-CSE-ConnectionGUID: oLrfhh5vSQWhxAjLfJ1sqg==
X-CSE-MsgGUID: lrL8vL+YTfGFG3a4nxXIBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="36940902"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="36940902"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 11:45:29 -0700
X-CSE-ConnectionGUID: Obs5g4WiRvC18MRoHf5Erg==
X-CSE-MsgGUID: iU1orUo5Qlu9I+R/J+rFyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71879344"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 11:45:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 11:45:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 11:45:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgWhVbqhF6NXx/V6AZ/YtBSP7O7mvHpLrS9LSQbn3tG4EmflxgWL0Drf5YesCb4aZmtsr175vEAUGVDeHvRK5wYxYz9aupGfdp8d90Q7pl7QCHMaf05GPnMxSP5Va2P1BVxPLN3JO5oDDqxVG7BCUqRVde4YYDPEaIa+vJ8Pz76rUcYyMi6v6uav6s4Usbcg9L+vgTV0Fj0H898zAXxz4Q9k/2oXLpTOsb3PFD5Ym6Iq2enrhTNYPPs/0QTa7lfe9LpxddpahSYwrPCf/KCoh2ZhIygGaRSJcdUjazEQsv6zZjCQkJFUZA+nyRwouq+K1Z7vXTc/bwPu3KrJanbMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtUVSICq4mZooJxsDpNqo/5Mi7u25/gGrNyU4++5uBw=;
 b=EKS1Juyn6QzWfH0/+ziwdUZJ+FpDGYKLnP9/+PrLX2MMub3HA2Z56a6B99OJaekf/qwjN1JOytEHlpsXXWG1E5guC4DAvdSgL24RyyEhjDMRurWxuL8AR0IkJTxP0OajZ17U8C1lct/qIfPZimgzq5hq5On/sz1FOmdP67BoPf2+Bs9S9qslnYaGI5gIfHotYxcuoa28mjgRxgaorURRbxng4pxNRvF1FUIqSpt1lowTkyOSuLos4dEUxdVp5bqTDB5mcqxOoPVWnf139VQ5F8vqkGkxH7IUsDPVBad+TnvE9KODHQBYtGDxQ8aZZEh3BsjjslteFa4rTAoFCSYDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 18:45:20 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 18:45:20 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: Yosry Ahmed <yosryahmed@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in a
 folio.
Thread-Topic: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in
 a folio.
Thread-Index: AQHbDh+BiNTld7AyzkaqOvKNL8+CcrJnU8CAgAAzUCCAACWmgIAACLYggADTBQCAAFDa0A==
Date: Wed, 25 Sep 2024 18:45:20 +0000
Message-ID: <SJ0PR11MB5678DEAE7922ADAB8876F386C9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-6-kanchana.p.sridhar@intel.com>
 <CAJD7tkacF3hCXiZHy7_+E7xmdojnsUewDeP=BsamcZReHxCTtg@mail.gmail.com>
 <SJ0PR11MB567887AF292EC178BEF1CF43C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbCB9iqRc1Y0287rZjQnJaV41DxN+GzZJFkqxM1FM8R4w@mail.gmail.com>
 <SJ0PR11MB5678EA6E0A41B0C83CB7F8F3C9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20240925135348.GB875661@cmpxchg.org>
In-Reply-To: <20240925135348.GB875661@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MN0PR11MB5964:EE_
x-ms-office365-filtering-correlation-id: e0d5f96b-dcff-438a-b20e-08dcdd92350d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TGSeFX43oK/LRY4kenlnI6S9o6/qT2EKav4uQRPcuVuY4UDqqLLm800BywG0?=
 =?us-ascii?Q?lSMbqNKM+a+h85+j7hft8sTFal/YqZoucANQnImVydhx49Dx+f4BR0POmqoY?=
 =?us-ascii?Q?qHxaMqD30gWrqPJAYw1ymXVeVk6SvZZzzUNRUDQBqiJp/abtc6mNVb2PrmvE?=
 =?us-ascii?Q?1AUJC4omQw3WLIxUMWzHr+h3qe4Ja3Wqax19G4sZsODmXyFkYGYzijHPIZVh?=
 =?us-ascii?Q?vk6x3ABj7OMOBI9QVPllL1V4bNdK9OJ3Zkei6Di5y193xa5MX0M7PxMdgZ9w?=
 =?us-ascii?Q?AsOe+vKfEnoJdl9F/0yl7XxpLmP6CrTJ4/Hvx/Bp3aXaww7PswpyUwKdtWCw?=
 =?us-ascii?Q?y4aw7jcoMdkY/NSZg2ahiiaeTUarm6yeGw8uXUwp+2EjkdzHPn1Gauf+IeLE?=
 =?us-ascii?Q?bgnrqomqxhUWgWNjd6oc+FdmjhysaRp2YM4Ynih+8tJ/mDWd4F4+jS+SFi2j?=
 =?us-ascii?Q?6wvi8oR6NSkk0fAbo/GEoqhigmrXuXd4DsT6RVpjyCNYceaOT//CUfsVYh9h?=
 =?us-ascii?Q?bMEu3zjxwxCgNN+tXCx/owrfa8LD2ChjWvAaLSRMxC8UprAL9akvvXI1qvIR?=
 =?us-ascii?Q?YgOrp+W/KyItKZmxYtTXxpW0xzRYtcryevEFfeE6nsGXW5YE80BrP0146FtK?=
 =?us-ascii?Q?10c8sMaxdKRv5mWpgquq59OQaODc0fz6oAYbywqc/8k6vHXjmYgtVYfiVwch?=
 =?us-ascii?Q?AGDddStJqrgsQ2hkEQZbNtyIid4Vg2ZQARovls4EhjiI8d4j0An/37OT4QFS?=
 =?us-ascii?Q?NEkw/n0c5q89X9UuvT38eSnEDZuT7qG87+rY2C8aWhVmImFuCbYx3fdCi8oW?=
 =?us-ascii?Q?YgKf8GySs4T7n9QxWjE27/xEyKd7tYuFXyWZDD7KmLlN+GoHvfPtpUBrLl66?=
 =?us-ascii?Q?g+CgnKcOcOXnxt2niwMlwccgMbNRox3UqZnMqExG0hTn8btZ2YuCReVcFdEb?=
 =?us-ascii?Q?cavMaLBqbsro5juBrNoj6wW21D1H+5XK2WPEERTbavYm1g6e4I9tomxdhWdU?=
 =?us-ascii?Q?QsefsGOJB+/YN+PNHW/le+M8MTKlrBiJrpYiDIE8vgK9rrKf898/8VFvz2q9?=
 =?us-ascii?Q?eYEFIaAUwlDqIE0SUMKrdehc6PvI7VlStcbhm1cTUdNvfTsfM6qg8LH8AU3L?=
 =?us-ascii?Q?c150QxK6U+FAk479VocbgdQwXgANO4uTKdP0H+iaoy6g0GgvahfNDLtwHq3k?=
 =?us-ascii?Q?pufm+O36a39QfuqC2f56q9RBN526uuPVn4bIiv5aY7uQq5GHQD7IUaikx/eR?=
 =?us-ascii?Q?vmn+tsy1n4aNSCjjJk3PLDG5lzMh5Rf5lWxSDBShjK5ljHA/H7tZu2nKfqI1?=
 =?us-ascii?Q?9m39/K5FEJb5kqTkhK+qjrH4SeNITJoWM5ZZMfHQM2tgGw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oT7PkIurzqpfjXJn9pkJFJgkSVCu1s/GqSxC47nJ/JcDlBQuSMBLY5i1Cc61?=
 =?us-ascii?Q?q4OmHvGJUIbZ9wqOXw91Yp5UVYnnrIKw9UapTWCl9hBfHK6+jW7Z7Ohf0sFn?=
 =?us-ascii?Q?XFkYzfE4iuYc0FWqadBSTWNP25bsSy/kuGn87rCFccXw8qh+LRNOX2hYMt2m?=
 =?us-ascii?Q?FrwyGWo19pWX76vly+eYUlEV9/vMGNe7ltTAIgRQI6f3l2T5YKyWQj8lhRJT?=
 =?us-ascii?Q?WtpEilqF52E2azXYyWd2CGjnH4BvJkPFxDlMKzqNDQN6LKv2hs8nzvc7sJcY?=
 =?us-ascii?Q?n/0uXONCq0h2KYoMfP+Taru479d+ttDdTTnRZmjNsA4hNsaQBQasrN8q0r2k?=
 =?us-ascii?Q?xODdgPIGjAQnMXLjyiE5uxiYpSieVaEQgwM3CL4cU2UwXUlNXRhDAYLaqd8/?=
 =?us-ascii?Q?XFnjibt8JiOflQknd7VGOskk6o36ZLnUcKMrGtS9cTyoee4S+aTl85hc2eIH?=
 =?us-ascii?Q?R43dYHXS6Q9IYwgW59pv4fNY+P6OxXly6n9Z9sR9k0UKBkyADF5NYx/Y+dJs?=
 =?us-ascii?Q?wYIl5X0+oN1CH7/KFnIk7sf8xsE45HHmgXihi2hd2elJw0xErYoN3EFwVcAY?=
 =?us-ascii?Q?MHsEtltPBVHb++cKnpEXxwBT9Wla56p3ekNglXx9JR0OBrV94hR2DZXsA/Va?=
 =?us-ascii?Q?QCCN1bCra442tsB9L6gFXOqnufoAt2hFkqxXhMIIOY/EweWC0heHw806cICB?=
 =?us-ascii?Q?pWJ4X7vkCcItfpagvNp8q/txXdC8y7EIl88g6EeK4JJxcFIyx8feW+YBSoWK?=
 =?us-ascii?Q?r9vMgW3Rmxr+5Ljg5zb2LfBPsLGwBQMK8vtZdza0c2HMKfOeZpcvwC6pJRd/?=
 =?us-ascii?Q?a4YJtc3n6p/zrDfQtOQOUxMHkjvcInrh+JJYV8SzSexp4Y0zVukm4MLK6htl?=
 =?us-ascii?Q?lHHi6DMnNQDf7YBR7xBYoVGv4IWu7rwfT6tNK0MGqNQcTO76ku7V0TZ+9wMq?=
 =?us-ascii?Q?Nlwi+/uaNYJblEVoulyDQpzlS3j4K2pCO7CzrbudSukvDqDHMHpCoM5dHb5+?=
 =?us-ascii?Q?PjIFSw8TOPjjGkgXQMbwl5Gt/BFW1VPCc4bLTPWzN78geXwTHzhzgfow+p3I?=
 =?us-ascii?Q?gD2jjksWKA/mCBtlPwV95g4156kG0/XoatnM4dcgAGa2Y8KmK059fGzeI2pi?=
 =?us-ascii?Q?sNT2KThVmBKsUwjOvYFM/XLabVrQLrVDg1x8eXYb+Y7e5c49AfaEET+EFeL1?=
 =?us-ascii?Q?vk/Us47SXXmE2hMOH0GerLeshN18boJAfFL2qBhU5w3n1vd7zXiWwm7ZiVKR?=
 =?us-ascii?Q?vpccP9T+lOzPSreslAyyIspAK85AXm5U2XXWHDW6fuHPa8GRbF0904dscPJk?=
 =?us-ascii?Q?c0qYl4SrYtPx80NBkZrDKqiHwdi34T+hoZVfz2+w8CtzOYsSF7zBi6jtDGUT?=
 =?us-ascii?Q?Tn3OWujYGdxhWCwcA7Pyofb9NUKpEiYXXAGz4QBH6cW9o3yX9yhnyL8ROvDz?=
 =?us-ascii?Q?DNBbQRhHxai4yiGWmZrBdjYkKRDHAE02Guu7tPO+15jR+WjU5vH74Tfw+cIO?=
 =?us-ascii?Q?WEv33M7ugteQfgJ8/cC7ztf6viT234vQo3IvKneuNhZ1G4mqMc37+Sz6yAaq?=
 =?us-ascii?Q?bRegnkwX3kmcoh6KgVpVzMqZcYM9olyAEuw81whSZ7lahIW2/bEn6/8lFSPv?=
 =?us-ascii?Q?5w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d5f96b-dcff-438a-b20e-08dcdd92350d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 18:45:20.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZ8ZpQr8CVfNYYTq+u0wv9FQYZDMLBlgn3QKqW+8gZIhV5qPVxEFNUuGdPOTVgf7Pv2Oj5GbEzUl1bHPsvBBvnmEl53PZQ5VgT3V/PSwJVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Wednesday, September 25, 2024 6:54 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>; linux-kernel@vger.kernel.org;
> linux-mm@kvack.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> usamaarif642@gmail.com; shakeel.butt@linux.dev; ryan.roberts@arm.com;
> Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v7 5/8] mm: zswap: Compress and store a specific page
> in a folio.
>=20
> On Wed, Sep 25, 2024 at 01:49:03AM +0000, Sridhar, Kanchana P wrote:
> > > From: Yosry Ahmed <yosryahmed@google.com>
> > > I think it's more correct and efficient to update the atomic once
> > > after all the pages are successfully compressed and stored.
> >
> > Actually this would need to co-relate with the limits checking strategy=
,
> > because the atomic is used there and needs to be as accurate as possibl=
e.
>=20
> For the limit checks, we use the zpool counters, not zswap_stored_pages.

Thanks Johannes for your insights and comments. Yes, you are absolutely
right. My apologies.

>=20
> zswap_stored_pages is used in the zswap shrinker to guesstimate
> pressure, so it's likely a good thing to only count entries that are
> expected to stay, and not account the ones that might fail just yet.

Sure, makes sense.

>=20
> > As far as the vmstat 'zswpout', the reason I left it as-is in my patchs=
et
> > was to be more indicative of the actual zswpout compute events that
> > occurred (for things like getting the compressions count), regardless
> > of whether or not the overall mTHP store was successful. If this vmstat
> > needs to reflect only successful zswpout events (i.e., represent the zs=
wap
> > usage), I can fix it by updating it once only if the mTHP is stored suc=
cessfully.
>=20
> Yeah, that's fine as well.
>=20
> I would suggest batching them both at the end of zswap_store().

Ok, will do so in v8.

Thanks,
Kanchana


