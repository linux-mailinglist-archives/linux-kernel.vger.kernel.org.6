Return-Path: <linux-kernel+bounces-341052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363C3987AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94B32832FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6160118872A;
	Thu, 26 Sep 2024 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxK7ftaM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1518870F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387093; cv=fail; b=exdJJWYYFD2svqLWxqvHr57DMZo7NN+fgcD/3WiomR55uTnJ8tj/tGuQ0I9jb9yzz3ChjgLvFVuh4VaSQR/Nk4HqhdxnYH+06B9sPCAPpdjX0aEKm+xmjmBHiZ5nOAwMhN98Ml9LrnNnTrpxm/4n+WF3Ff6NJFfR84X8ApCxTyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387093; c=relaxed/simple;
	bh=SdFNyRJEqbMDsmDQfzsFOmWHDzcbb91nmdexzWQ/nyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fOEEGvHOXna/2TQtHXRtkV7mnV5c+opX/keY0DEnOu5XwfrZ9KZ5VIZaxz0BmOsZT9QtzAOCVcQTTPoi2P0B7liQDKG//3w/Va8xDMtrki18vFZGOirCWiqpV+oOa0mGJG2+xJ1uQaC0oQUhwMkAMleljjlIoDl440g+YlZttDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxK7ftaM; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727387091; x=1758923091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SdFNyRJEqbMDsmDQfzsFOmWHDzcbb91nmdexzWQ/nyE=;
  b=XxK7ftaM8J5bZ+qxVk3jRgQkZ3Oxc1Up5xuwRCaXskAu68Q3RFcGpX3V
   VrN7zSd6hiMO9Hb2+XomRH2JGAkBLMydHQLM6VEWHOnYWPaDgLq3v5gEe
   yyDW2kcDtGW9Z0BDd+l0j8Y95eSq05oiINS09sBQmJshSbFiErRtC+k6m
   2pmYl5AjjcA+8M7hv9rZKo3D12bJbWKgabq/NlrphXjx0x5Y/cnh/nP30
   JYHvfpwom9+ziuQgm9JEpWFgv2F4U3dhhbx+mR2jP4wBhqbkBM1Yl/17K
   VTGX7Ihr8g19QIvqNjJTUj3gDf2OLLdMTETMBaKEcy5Ukx0uqp2RR3o4L
   Q==;
X-CSE-ConnectionGUID: YPXwdS+0ScyBJp/vNNcJgA==
X-CSE-MsgGUID: mCGXqTjsR0ykpCtvl7mVqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="51932196"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="51932196"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 14:44:50 -0700
X-CSE-ConnectionGUID: erawEV+tSaCS0fS8G7TOMA==
X-CSE-MsgGUID: WPM/D5bBSAmQquqrbIT8eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="72610473"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 14:44:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 14:44:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 14:44:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 14:44:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 14:44:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzBoTv60BXItmDWBpfKA8QYf90GZ3uMj1nv87hzBnEKjb6NYLmO/DOBjmYYK4IteoOERULN6/kmp5p1N+mRHxvKMSI8UUFJfOq4WJQkduLDqhdzON6D2Ft8NpPt5L3WAwE5tiIScrr5MhJ1tPhgVlvcynnWRtmx+LUbik/7uOSbtGsUbYxYQBP36Zw1NTwsiCuC1jXGJGmDx33nmdLZZ5Iop2LEMJ4T9x2g6Xm0s1HUkaTMA6UrvHxUQBuCJoCRlD/B/L4Nsa5MOoDcBJdbqceR/jkYHDZcdkd52XQOMyjPrqubu7YEFGKnDIHEqDRsVjnfG5jbSG1M8OLuvrwbfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V/XewjOFz1v3Xg8kmLTmiZIfJUKk1hZaZIMa2MIyOU=;
 b=T2rHLMHfFIDnCQ0EcIIIULLhjRu+aEf7DxB7ieirrN/9O2bieGJpruNFEuVW+iFSMuwc+IV3iTxVyYEwlm6LdjGAJkrlzBsdcesCX+V9ejJj57Jp671XMS5xPSz4ujD2p45iQB7NsvMCgmv0m3uKayz+s7CwSWraMyKRGZ+6jpCDHjg9z9c5cg4Wcy2lxZ6U1Q1rV2UFM/3jiMo5ZNa4uBXpSbkXhBlgbC0NUloc74oZWLjNgFxMm4Lqwk/rCfal7dW/SQ0i5SA0b3yrzZc+0xVj8cJZyjDGY3luI0MsFUEltYoXvGxTek0iX7FAROt6AbYrD19Cmg6A65lrcC4J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 21:44:40 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 21:44:38 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHbDh9+WG1/kyAOWku1xyL3C5nTY7JoDu73gACtkACAAILSn4AALdHggAA3qFiAAPk+sA==
Date: Thu, 26 Sep 2024 21:44:38 +0000
Message-ID: <SJ0PR11MB56782FBA16D086D6264EFFD3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
	<87v7yks0kd.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<SJ0PR11MB5678BC6BBF8A4D7694EDDFDAC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
	<877cazs0p7.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<SJ0PR11MB5678899F41B3F243E54C59D2C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <87msjurjwc.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msjurjwc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB6074:EE_
x-ms-office365-filtering-correlation-id: 45a22db4-a8a7-492e-6cad-08dcde746bff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uVxRN3c7fzqaKAJDbjbNkDEzA293SOXMwmBGtn+GX7PnLphmFiulxqVu7Xaw?=
 =?us-ascii?Q?SdmX9+UgjgpA2M1ur8bhsYZQ+E7zRQwdE+3qbOXE8E6PrBKCSVEqj9H2bCNZ?=
 =?us-ascii?Q?cvMrrCYgfcuvhkfBtOCckCiYdU7LyCmayCkOCKKdmvZLW2H93SPFOX7jJ7Lu?=
 =?us-ascii?Q?iqEIyGyfycxQ7WW9VYApO3t8OL7RDIeBAnxeKMxutjqac6FS78De6/zy2ozZ?=
 =?us-ascii?Q?tWvlR2WxeFct0lyS6dFmSBlM9OtHU6su79GxL6MXt33tgcUZFo7k8Q9yT8ix?=
 =?us-ascii?Q?Wls81rhwWGyxTm0b8XrhLd1kZbucGCTDHBYbrS5gnY0XXMOy4cm7pIHNQ+M7?=
 =?us-ascii?Q?lFTzkkgbq07mZW7tlfFu+23CkBDJaNRlYFjwwNLNrntV480pieue7HHwA3Iw?=
 =?us-ascii?Q?jrEuq7CTWE9zmd0a+Y2EM8LOzJbA0ERHtgvHSMoW73RsnyPudLa5iuOD8iFd?=
 =?us-ascii?Q?ik9ohOk+lCvFQGhL2u97f5SEZMZpYWRmcxoXIRGWBjOziom2XxeWSn7Y1O4g?=
 =?us-ascii?Q?suBYmwURc6sRKRK7bZ3awILaqvjEDORvTMG9R/wqfOlKzPqta5MTYm8QJHIC?=
 =?us-ascii?Q?NAMuu9eiOtVzuG5n8G8Ys7ETaRgHDPbYt1BLnbxVs3LFIY3WQQ4jUjhOg2BW?=
 =?us-ascii?Q?O0qSrd2AZPDpAsmAXtnMHzVHcrxbTOPyo60UANSNAMqjCbRnY6+26l0TVjKH?=
 =?us-ascii?Q?okLq+gxYJwa4zBuqbxCLja6jy16RreC5QyNj8kEm35ALYtyAWTN87Z2QWzBD?=
 =?us-ascii?Q?OgznP+BkjN9lkexELZpAGpEcL+xPTSy0iRVUdi+IHMtHrZuvrOFtEi3vMRFr?=
 =?us-ascii?Q?XFIqhhDiP8qgb2xOgg57Y/Gg9JbFls/vJJ4ydGuKvligWTLTmHhM8+LKDIv3?=
 =?us-ascii?Q?Yc1HbsTCjkK0cB8cps23zZeyoK5O2hGK6oq63S2k9+e03jBk+O3mtJwKO+5Z?=
 =?us-ascii?Q?BIMf+PtoKJfrMDeSEj9FGyoTqPxPeVznNAQq8L77vL+1zW0ASiXZv4XfMpwi?=
 =?us-ascii?Q?lh2mbS0m/9vKcV/W+cT04AOF26+2njJ9pSFSeOh7HsT4FKEnrSaiGVctYa/q?=
 =?us-ascii?Q?Z7st+VN4zyi1nx1qHyOa/6W6rUGUnS9vhO7HTX3pbo+0PF4wnwGl1HfTWrHC?=
 =?us-ascii?Q?/sXp63pyuJRpcUiZ254g6tW9q3dAWW36OUWuHYgkGEi22nKTF3+V9EDlEpmO?=
 =?us-ascii?Q?/c12BMOf4ABmDHTm+a/CZIQAJg2UwtcMCEEE85Y8FZrCvynuR/EgE4b28elV?=
 =?us-ascii?Q?p+U5CO22JEssF1tHrAcdD5rUxma2oM88Z6raoiWK+r1qB4YASuGRNGAN3gLW?=
 =?us-ascii?Q?nbIzxNxjoX2ahrJWdg7P9Znovm8CSnER6x4jxshzezV/cw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?foqO1pBzKNvrcBwOJHlg7VG6Rzeu5fEEFz8WmN99hJKE2tUdeHoI7EypPo73?=
 =?us-ascii?Q?nnvNor/GAmLFscKE0CeVOIogboPXxrdGIYQb6TLwGrvyhtCALIsLQDZVFHDO?=
 =?us-ascii?Q?4BpgMkYeVhWojLJdZ7DfQfOzodJ/KcOsD9PiG1e/uPNIVViiE3ZZB/TqP2zQ?=
 =?us-ascii?Q?IWxNQ5KtOjHps8UCJuwZxGFsuC5isH25+1dyD6k6oHHGuX26NYdNxpENS2yz?=
 =?us-ascii?Q?/KJYOHxHUGoi0R5M/T2ATmPldgnlZ40J+XGh5M9x31fff6oGurzyrjHMDBc9?=
 =?us-ascii?Q?RjOANvH7XhnK6UxREQpFh3wKyV0/Zr1Olpa9CvqcRnEib4O52wvFxFHeEZg6?=
 =?us-ascii?Q?eyYMrahbtGiNAA7oK6PdwryeC9VcbJomr/X7VUaokwEWTVG/BqcIR/wEJdTX?=
 =?us-ascii?Q?AytTpv4cTi5tC86A40HoDQMhJO+6Dz/kLmjUzPnQJsqpUisNMA3ADPtjKyrZ?=
 =?us-ascii?Q?gdIXYldI5wzo4kdhWckulUzGtsmKEyOj1YW/FHlXbWsEoMCutMoCkRu15n0Z?=
 =?us-ascii?Q?ZRwaRTAvg6ehlgdUS58bmDnmmmsu9w6wbxxqzlsSkEUMt1cBxdsr9e6Ug+sJ?=
 =?us-ascii?Q?LJHSTyw5L1FEperyAjP7h6wTV0qYF089GVdtj5oiYBHxjuEMgXFuL9QaNhQb?=
 =?us-ascii?Q?tkyhpsd2R1Ys3bXp1JBNBoRRGWe97KwvHJzvQXfmbCPv+0vISnMscYEpAcwR?=
 =?us-ascii?Q?+SEFFV4R0pSNX4yOZkuxT0rby7fB+ctzrdv4J/KleyUDe6CRj0Sbw70xxtyn?=
 =?us-ascii?Q?YaIbjdpljUWR5MXTB3oeqxflglCsk1TLk9D5oC4dJKvQBr9KmUNXm1xk7pAj?=
 =?us-ascii?Q?+yTINwQkT+EaibPN8ovkIKhdBaDmA7TE+X7Ffnu7x84KU8JMJecV72c5jdG7?=
 =?us-ascii?Q?/Un2vjTjV8u/09WwAIlHsFR+bnkbK10PmD+GZl4Xg84aVXf25Pv7ofXzWUct?=
 =?us-ascii?Q?NSS/8298NHxyYGgX/EpYDKTO31qZZB7XwSl7LIdO5YBE/dwsnbXc1ywiXrfY?=
 =?us-ascii?Q?Eokhf/DpkbZVKQD0CI3uNZ6vbBqNbpQuuq2ufvTMskTzt7vEvnXX2P3pfuxN?=
 =?us-ascii?Q?sAZLkxKRbiZFkdnQDJ5GZgIG+w7jEQQCAmntSUXo1m8VoeWwO6cHQ1O4NE1e?=
 =?us-ascii?Q?9XsR9ICIW+z2iyodPfbac1Xx/brsl7s79BCINKdVFpU6pteWk3EC5mnsa6FI?=
 =?us-ascii?Q?a/eOt1haWoS0c1Hn5u42dR8T8Ky+NS3k6kD+nyNo3h4Hd7/WpFuObwADOX32?=
 =?us-ascii?Q?NwDjNapUa3Ky19d4ruicvJcygTbU+TM9Yu7ZfIGZ/gEuHd8gSa4m3e4jcaSW?=
 =?us-ascii?Q?sbf92rMd6bmVgg5wzdkRwKiys1g2Md6Pyd1YYLVUNCqQq9ARkhUZz91GHwn4?=
 =?us-ascii?Q?qP2xdT8/vmiyQwSj03PdR66uVy2NEpEIMEZ9Tsh2tM+WzZ7cW0+2bdP6jeev?=
 =?us-ascii?Q?z3k3b3pA1pYSPOewS6mGCkt+h6J07yIwsfyp+vM9nBEFfz2JtgoKd8TjLN2V?=
 =?us-ascii?Q?2DoGu3MzloOGO/rvsTk8HMM4AlG3c+7YOmClOgyGVjfPFuCGs6FS94pXJp9E?=
 =?us-ascii?Q?dPdrAMQUDXUdVDdWsh+K2PBSgtER6VTDa47Yk9CZ4gF4TtUt8J/MbkerN5t3?=
 =?us-ascii?Q?Ug=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a22db4-a8a7-492e-6cad-08dcde746bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 21:44:38.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPSk4viJShXUa3yiP4yA5eBwLraonpKD10LUPDywvV7+eIMaDEvMT2MQE4RlpBTahuYUfMqMpI7jb007HPBeDeY/BS1CDAbUQYuQOFWQLLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Wednesday, September 25, 2024 11:48 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali,
> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
>=20
> "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:
>=20
> > Hi Ying,
> >
> >> -----Original Message-----
> >> From: Huang, Ying <ying.huang@intel.com>
> >> Sent: Wednesday, September 25, 2024 5:45 PM
> >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> >> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> >> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> >> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> >> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
> >> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>;
> Feghali,
> >> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> >> <vinodh.gopal@intel.com>
> >> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
> >>
> >> "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com> writes:
> >>
> >> >> -----Original Message-----
> >> >> From: Huang, Ying <ying.huang@intel.com>
> >> >> Sent: Tuesday, September 24, 2024 11:35 PM
> >> >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> >> >> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> >> >> hannes@cmpxchg.org; yosryahmed@google.com;
> nphamcs@gmail.com;
> >> >> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> >> >> shakeel.butt@linux.dev; ryan.roberts@arm.com; 21cnbao@gmail.com;
> >> >> akpm@linux-foundation.org; Zou, Nanhai <nanhai.zou@intel.com>;
> >> Feghali,
> >> >> Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> >> >> <vinodh.gopal@intel.com>
> >> >> Subject: Re: [PATCH v7 0/8] mm: ZSWAP swap-out of mTHP folios
> >> >>
> >> >> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
> >> >>
> >> >> [snip]
> >> >>
> >> >> >
> >> >> > Case 1: Comparing zswap 4K vs. zswap mTHP
> >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> >
> >> >> > In this scenario, the "before" is CONFIG_THP_SWAP set to off, tha=
t
> >> results in
> >> >> > 64K/2M (m)THP to be split into 4K folios that get processed by zs=
wap.
> >> >> >
> >> >> > The "after" is CONFIG_THP_SWAP set to on, and this patch-series,
> that
> >> >> results
> >> >> > in 64K/2M (m)THP to not be split, and processed by zswap.
> >> >> >
> >> >> >  64KB mTHP (cgroup memory.high set to 40G):
> >> >> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> >
> >> >> >  ----------------------------------------------------------------=
---------------
> >> >> >                     mm-unstable 9-23-2024              zswap-mTHP=
     Change
> wrt
> >> >> >                         CONFIG_THP_SWAP=3DN       CONFIG_THP_SWAP=
=3DY
> >> Baseline
> >> >> >                                  Baseline
> >> >> >  ----------------------------------------------------------------=
---------------
> >> >> >  ZSWAP compressor       zstd     deflate-        zstd    deflate-=
  zstd
> deflate-
> >> >> >                                       iaa                     iaa=
            iaa
> >> >> >  ----------------------------------------------------------------=
---------------
> >> >> >  Throughput (KB/s)   143,323      125,485     153,550     129,609=
    7%
> >> 3%
> >> >> >  elapsed time (sec)    24.97        25.42       23.90       25.19=
    4%       1%
> >> >> >  sys time (sec)       822.72       750.96      757.70      731.13=
    8%       3%
> >> >> >  memcg_high          132,743      169,825     148,075     192,744
> >> >> >  memcg_swap_fail     639,067      841,553       2,204       2,215
> >> >> >  pswpin                    0            0           0           0
> >> >> >  pswpout                   0            0           0           0
> >> >> >  zswpin                  795          873         760         902
> >> >> >  zswpout          10,011,266   13,195,137  10,010,017  13,193,554
> >> >> >  thp_swpout                0            0           0           0
> >> >> >  thp_swpout_               0            0           0           0
> >> >> >   fallback
> >> >> >  64kB-mthp_          639,065      841,553       2,204       2,215
> >> >> >   swpout_fallback
> >> >> >  pgmajfault            2,861        2,924       3,054       3,259
> >> >> >  ZSWPOUT-64kB            n/a          n/a     623,451     822,268
> >> >> >  SWPOUT-64kB               0            0           0           0
> >> >> >  ----------------------------------------------------------------=
---------------
> >> >> >
> >> >>
> >> >> IIUC, the throughput is the sum of throughput of all usemem process=
es?
> >> >>
> >> >> One possible issue of usemem test case is the "imbalance" issue.  T=
hat
> >> >> is, some usemem processes may swap-out/swap-in less, so the score i=
s
> >> >> very high; while some other processes may swap-out/swap-in more, so
> the
> >> >> score is very low.  Sometimes, the total score decreases, but the s=
cores
> >> >> of usemem processes are more balanced, so that the performance
> should
> >> be
> >> >> considered better.  And, in general, we should make usemem score
> >> >> balanced among processes via say longer test time.  Can you check t=
his
> >> >> in your test results?
> >> >
> >> > Actually, the throughput data listed in the cover-letter is the aver=
age of
> >> > all the usemem processes. Your observation about the "imbalance" iss=
ue
> is
> >> > right. Some processes see a higher throughput than others. I have
> noticed
> >> > that the throughputs progressively reduce as the individual processe=
s
> exit
> >> > and print their stats.
> >> >
> >> > Listed below are the stats from two runs of usemem70: sleep 10 and
> sleep
> >> 30.
> >> > Both are run with a cgroup mem-limit of 40G. Data is with v7, 64K fo=
lios
> are
> >> > enabled, zswap uses zstd.
> >> >
> >> >
> >> > -----------------------------------------------
> >> >                sleep 10           sleep 30
> >> >       Throughput (KB/s)  Throughput (KB/s)
> >> >  -----------------------------------------------
> >> >                 181,540            191,686
> >> >                 179,651            191,459
> >> >                 179,068            188,834
> >> >                 177,244            187,568
> >> >                 177,215            186,703
> >> >                 176,565            185,584
> >> >                 176,546            185,370
> >> >                 176,470            185,021
> >> >                 176,214            184,303
> >> >                 176,128            184,040
> >> >                 175,279            183,932
> >> >                 174,745            180,831
> >> >                 173,935            179,418
> >> >                 161,546            168,014
> >> >                 160,332            167,540
> >> >                 160,122            167,364
> >> >                 159,613            167,020
> >> >                 159,546            166,590
> >> >                 159,021            166,483
> >> >                 158,845            166,418
> >> >                 158,426            166,264
> >> >                 158,396            166,066
> >> >                 158,371            165,944
> >> >                 158,298            165,866
> >> >                 158,250            165,884
> >> >                 158,057            165,533
> >> >                 158,011            165,532
> >> >                 157,899            165,457
> >> >                 157,894            165,424
> >> >                 157,839            165,410
> >> >                 157,731            165,407
> >> >                 157,629            165,273
> >> >                 157,626            164,867
> >> >                 157,581            164,636
> >> >                 157,471            164,266
> >> >                 157,430            164,225
> >> >                 157,287            163,290
> >> >                 156,289            153,597
> >> >                 153,970            147,494
> >> >                 148,244            147,102
> >> >                 142,907            146,111
> >> >                 142,811            145,789
> >> >                 139,171            141,168
> >> >                 136,314            140,714
> >> >                 133,616            140,111
> >> >                 132,881            139,636
> >> >                 132,729            136,943
> >> >                 132,680            136,844
> >> >                 132,248            135,726
> >> >                 132,027            135,384
> >> >                 131,929            135,270
> >> >                 131,766            134,748
> >> >                 131,667            134,733
> >> >                 131,576            134,582
> >> >                 131,396            134,302
> >> >                 131,351            134,160
> >> >                 131,135            134,102
> >> >                 130,885            134,097
> >> >                 130,854            134,058
> >> >                 130,767            134,006
> >> >                 130,666            133,960
> >> >                 130,647            133,894
> >> >                 130,152            133,837
> >> >                 130,006            133,747
> >> >                 129,921            133,679
> >> >                 129,856            133,666
> >> >                 129,377            133,564
> >> >                 128,366            133,331
> >> >                 127,988            132,938
> >> >                 126,903            132,746
> >> >  -----------------------------------------------
> >> >       sum    10,526,916         10,919,561
> >> >   average       150,385            155,994
> >> >    stddev        17,551             19,633
> >> >  -----------------------------------------------
> >> >     elapsed       24.40              43.66
> >> >  time (sec)
> >> >    sys time      806.25             766.05
> >> >       (sec)
> >> >     zswpout  10,008,713         10,008,407
> >> >   64K folio     623,463            623,629
> >> >      swpout
> >> >  -----------------------------------------------
> >>
> >> Although there are some imbalance, I don't find it's too much.  So, I
> >> think the test result is reasonable.  Please pay attention to the
> >> imbalance issue in the future tests.
> >
> > Sure, will do so.
> >
> >>
> >> > As we increase the time for which allocations are maintained,
> >> > there seems to be a slight improvement in throughput, but the
> >> > variance increases as well. The processes with lower throughput
> >> > could be the ones that handle the memcg being over limit by
> >> > doing reclaim, possibly before they can allocate.
> >> >
> >> > Interestingly, the longer test time does seem to reduce the amount
> >> > of reclaim (hence lower sys time), but more 64K large folios seem to
> >> > be reclaimed. Could this mean that with longer test time (sleep 30),
> >> > more cold memory residing in large folios is getting reclaimed, as
> >> > against memory just relinquished by the exiting processes?
> >>
> >> I don't think longer sleep time in test helps much to balance.  Can yo=
u
> >> try with less process, and larger memory size per process?  I guess th=
at
> >> this will improve balance.
> >
> > I tried this, and the data is listed below:
> >
> >   usemem options:
> >   ---------------
> >   30 processes allocate 10G each
> >   cgroup memory limit =3D 150G
> >   sleep 10
> >   525Gi SSD disk swap partition
> >   64K large folios enabled
> >
> >   Throughput (KB/s) of each of the 30 processes:
> >  ---------------------------------------------------------------
> >                       mm-unstable    zswap_store of large folios
> >                         9-25-2024                v7
> >  zswap compressor:           zstd         zstd  deflate-iaa
> >  ---------------------------------------------------------------
> >                            38,393      234,485      374,427
> >                            37,283      215,528      314,225
> >                            37,156      214,942      304,413
> >                            37,143      213,073      304,146
> >                            36,814      212,904      290,186
> >                            36,277      212,304      288,212
> >                            36,104      212,207      285,682
> >                            36,000      210,173      270,661
> >                            35,994      208,487      256,960
> >                            35,979      207,788      248,313
> >                            35,967      207,714      235,338
> >                            35,966      207,703      229,335
> >                            35,835      207,690      221,697
> >                            35,793      207,418      221,600
> >                            35,692      206,160      219,346
> >                            35,682      206,128      219,162
> >                            35,681      205,817      219,155
> >                            35,678      205,546      214,862
> >                            35,678      205,523      214,710
> >                            35,677      204,951      214,282
> >                            35,677      204,283      213,441
> >                            35,677      203,348      213,011
> >                            35,675      203,028      212,923
> >                            35,673      201,922      212,492
> >                            35,672      201,660      212,225
> >                            35,672      200,724      211,808
> >                            35,672      200,324      211,420
> >                            35,671      199,686      211,413
> >                            35,667      198,858      211,346
> >                            35,667      197,590      211,209
> >  ---------------------------------------------------------------
> >  sum                     1,081,515    6,217,964    7,268,000
> >  average                    36,051      207,265      242,267
> >  stddev                        655        7,010       42,234
> >  elapsed time (sec)         343.70       107.40        84.34
> >  sys time (sec)             269.30     2,520.13     1,696.20
> >  memcg.high breaches       443,672      475,074      623,333
> >  zswpout                    22,605   48,931,249   54,777,100
> >  pswpout                40,004,528            0            0
> >  hugepages-64K zswpout           0    3,057,090    3,421,855
> >  hugepages-64K swpout    2,500,283            0            0
> >  ---------------------------------------------------------------
> >
> > As you can see, this is quite a memory-constrained scenario, where we
> > are giving a 50% of total memory required, as the memory limit for the
> > cgroup in which the 30 processes are run. This causes significantly mor=
e
> > reclaim activity than the setup I was using thus far (70 processes, 1G,
> > 40G limit).
> >
> > The variance or "imbalance" reduces somewhat for zstd, but not for IAA.
> >
> > IAA shows really good throughput (17%) and elapsed time (21%) and
> > sys time (33%) improvement wrt zstd with zswap_store of large folios.
> > These are the memory-constrained scenarios in which IAA typically
> > does really well. IAA verify_compress is enabled, so this is an added
> > data integrity checks benefit we get with IAA.
> >
> > I would like to get your and the maintainers' feedback on whether
> > I should switch to this "usemem30-10G" setup for v8?
>=20
> The results looks good to me.  I suggest you to use it.

Ok, sure, thanks Ying.

Thanks,
Kanchana

>=20
> --
> Best Regards,
> Huang, Ying

