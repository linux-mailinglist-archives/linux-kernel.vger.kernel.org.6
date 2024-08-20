Return-Path: <linux-kernel+bounces-293838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8519E958591
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C545286CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097518D63E;
	Tue, 20 Aug 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mc3vqUGB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C218E351;
	Tue, 20 Aug 2024 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152820; cv=fail; b=KRfYsxF4meynN2ZxP0HltkMYVBsmgZuuDTtb0n0K5bsa5QpsqpLAObV/O7sETKK7X6HDfIhg3/IzptlLR9LecSlzRRlboyfZ7J99gPqM5m71OkDmaJp8xI+bMWgsWHkAYAPrPXyxI3C8aQN7HHWi7vPXifcS+qoKf0RRuiwOwbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152820; c=relaxed/simple;
	bh=85a0nnf+85KmBCDQxW4z57W5vEQOvEVsjjzsL6dgYMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X0fP72DPY9ubGKhsRTKkmKnNkEQSusufpZfwOHxpYrfJyH0Q30BmV8K0nnx+DjNwSpxtyw0pcX1ZPQaIhNRZQ5Ga090nHiQKPtiWceLGJ459UF/1UGumIduAIlHPMb+W1DFRxgnxL7L8g0GVQiBOyUXOukFPXXlJ4Au8ry+0Sz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mc3vqUGB; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724152818; x=1755688818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=85a0nnf+85KmBCDQxW4z57W5vEQOvEVsjjzsL6dgYMU=;
  b=mc3vqUGB9+G7vGdeMjlEqhcPR142bYVmAlUEZfUNU/4TtOzWiZyGp5ay
   uLYbfW+xSuNnpywKcd5JCRaLn4QsvgE3IZ8uYhTvp+iSq0DY3hfX+GLuU
   PVK8loaL6UcUJPPi8oJdlAu0c5uxTjMFDkpbLj7Ms2IPhMhY6T+BCXuB8
   Uxr6O9kN+WjUTnclAgcWXpwEcMSnGbcovLqbWvPfjScI5FOUXBOpd+Sja
   jrMkCwKQHFuw/FYqi7utq1POWGPViwfKSc2gXYddLr3e5CI3N4SZnW3M/
   74KYaqMJptCSxtSM+xDqz4sV8PXXMYTHFGgXZxjL8MZ8iDhj7P4z4E4K+
   g==;
X-CSE-ConnectionGUID: tk8fi5x8RMaVdz7fUl4D6w==
X-CSE-MsgGUID: 2+2i/x0DS16nI73JEBOfdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39949478"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="39949478"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:20:17 -0700
X-CSE-ConnectionGUID: dFAZm/kUTrGXn6mseeXfqw==
X-CSE-MsgGUID: NWOeqLqMR0CwW+vfHVhnMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="61244470"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 04:20:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:20:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 04:20:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 04:20:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 04:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QokKglfo1ddIf0XAz0TIhJ8gkn4cmGp4UDTteS63Mbl8Sls2DwtGIgH6J4R7dFccK4fVLRlAud/DE0H2K6cUIkIGGPYsGkU0VnER7q9Loee0ElCb8Qi6URSorMkKRCrrAckn5rJpiLPsBLwPeAZB3v16ZhvyOrtv7/cE9hV7cFTOn7voEYMkMvJ0yf7OWiWMCPTeDDqA/npCPhu/I56F6cND2Yu3WrOc6N9q+J2Dm7eXjvh04UaF3giKy5NIDSJVxisyj3U/7DtE+lMvgWp7X+8F2biZllnzWh0xmN7KSWqSYyLLZsWqntFe7Hjf464GHQpW/Ir/56e3It+0xent4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaDjNtVhKpA+d7DLdNOpIEKwV1Y6CfDBDxBJPASLTwk=;
 b=fGleI59w/3CduOe69o1Br0rCS+WLxhHvRyLhB7ZcNGuyiBjCqk9zWxqPJQ51Z9wGzN5y43tqtQ101eUjB/idq4m/YyAZPGV88WH0/XuQAUhL7h4klc6WvP3hGFYT/tgKfvRYBmL9d3HRUl8VL2ju1LPINgF8mq9NnZfgRzAb4t/wUkyRQsFWM0T4LvMF2XTfoB9bhhyN07axmpjLzS7tVO6d5+mDaqEgzDZ7hC1OKcd9w8fNvP95aDCly41RGEhIiHkP9vn5DvPeEipu7bZIzB1oqQxRaAwLaj2mo1bFkRlkqPWbMk46SScy8M7txpyIkQ4KPEv0PyoqzWp4vKCdmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 11:20:11 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 11:20:11 +0000
From: "Mohan, Subramanian" <subramanian.mohan@intel.com>
To: "Mohan, Subramanian" <subramanian.mohan@intel.com>,
	"linux-drivers-review@eclists.intel.com"
	<linux-drivers-review@eclists.intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "giometti@enneenne.com" <giometti@enneenne.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, "Hall, Christopher S"
	<christopher.s.hall@intel.com>, "N, Pandith" <pandith.n@intel.com>, "T R,
 Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: [linux-drivers-review] [PATCH v11 0/3] Add support for Intel PPS
 Generator
Thread-Topic: [linux-drivers-review] [PATCH v11 0/3] Add support for Intel PPS
 Generator
Thread-Index: AQHa8uLLxVIfrIkAF065cPQaut+vUrIv/48g
Date: Tue, 20 Aug 2024 11:20:11 +0000
Message-ID: <PH7PR11MB5862059184A37C7282C71D10F78D2@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20240820092420.9185-1-subramanian.mohan@intel.com>
In-Reply-To: <20240820092420.9185-1-subramanian.mohan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5862:EE_|PH0PR11MB5144:EE_
x-ms-office365-filtering-correlation-id: 856752c4-6794-4231-bead-08dcc10a0e64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?z5yOcgXoC6zWk/htYZyL6xdQrIlzioE1/4XQrigjszyu/WgsCGYYgycYbobs?=
 =?us-ascii?Q?f2of8kI6hdN0LYV2cW6zHJzAA+KfuGa/aUv1b2Vtmq/XNI9VKARn/4xUAr3V?=
 =?us-ascii?Q?3ct8RnjbfEeAP6bg9LVWX6tyBuqii+hH/k++V/2sg+3dYpSYKrJGqfhFflM7?=
 =?us-ascii?Q?Th+OLDDLlOfQkQYQNNOLxBb1tDQM7jntKymPprN8MxPyvmRW+2koV1wyAG7G?=
 =?us-ascii?Q?5YyHXQFQFe5RSIatEFff6I3s2FxeynYCbgCwdwGERtToKIpd5Um4z12CSMdn?=
 =?us-ascii?Q?MlBZjK0NpMUgvRZoCF+fj2a77urgHTG/C5oQ11V5SVw/Ck1sj4J2vhPoZ5/y?=
 =?us-ascii?Q?QNXaTtHTnVRNHgKF3dVW4ZoLLeEIdcFMK6Y2XxG+z6c7pxqNDeBU9tAqb3/A?=
 =?us-ascii?Q?ooKZObvxcSnKs2BbIhfvvp0DKQCOskl1OEvY5xOpBsdsDUMpQ0bVzG+x9rl8?=
 =?us-ascii?Q?aX5nSqVvT/eqrhX+fyUhyNIQ+SabBvHQLzVsAPS4aDOP1Tf8OtB4SpDh9N/2?=
 =?us-ascii?Q?CIsnJXMRJrAVBGvPZIsp98YjPC1b+dGRh9rRjUV1e/6ofSHXQlj+WvgBww6I?=
 =?us-ascii?Q?9zO5CyuWbxXfc1gsCuYsVht5aqZ655jyr4EYAeD0dqovIXPH+570t3OrkyOH?=
 =?us-ascii?Q?egGXEiFubxYxMpqErk+nKXqxz8JCYqOw6k+oFPWHaIdCyaTnwmqgVc30WoYi?=
 =?us-ascii?Q?vxqOUTyeEe9b4d1OnIpTNljwD8ssepwSx55X1sO4qBMAVGlIqO9cEZnfA0MN?=
 =?us-ascii?Q?b3hMsUr6zO9B1a2pci4eknDt7Vct9XOixdeLvnw40DEnpv6N8E9wL+ze2+/F?=
 =?us-ascii?Q?qROrTeVqmo+gOsK4OZKPzabt2BGx+ge9xV9K053UjYfQsaHXD7kC5VNqRSZS?=
 =?us-ascii?Q?98mgJYUi3nMgkhedXzWHTSYpIeM3Rz6zXUVl5sgP8KpdT0gEeVge1t0uSQz8?=
 =?us-ascii?Q?6zNttuvSXpveC1Qqh1JW2aeK9db2beCZVDkZGBROpw15Csf+iTWjzqfs82QY?=
 =?us-ascii?Q?hBDvXmQzsmh+ec+TbxwgZzv6iU9OtpWFgkK9pzuutPnDhLPhAJrXg/ScRt3H?=
 =?us-ascii?Q?w8N9qg0Rz0j0mNNHa7juJwiDefxJGbxbKwOwflGpXd7KKfaMdrmcdf5cunQb?=
 =?us-ascii?Q?yUq5hsDWAu3f/yKKZRUdCuZu/yIi/9x40V3fDCDSKNk51grKXpAyMzrZLgs9?=
 =?us-ascii?Q?QQfsz+ledCcqr48/B6Z5Z7kT17I5k5C2l/CgJe5TIzeOy5Nn7zZdetqCg8lQ?=
 =?us-ascii?Q?TVhl5/VvPd55PZMGNiJge00wpcNY0GrlwFrc/9JcDbMS0H84GI1qfSxoX/Sn?=
 =?us-ascii?Q?dw0ydHxnc7oh9YEkHRIi6DquCIz11gzktjYQ9OswnKiy3OaQQczKQv9xN+wx?=
 =?us-ascii?Q?50uw0qU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?47l74wqwUDmiDbaCd850PvQKtXP9J87tZIperAwfDiDr11XjKZKKyM2skkAO?=
 =?us-ascii?Q?EwTRc+jzBojlL8xpwCWrWiiEExcI+m3/wXM2ONowwPxxSIDji7v/lazOYd9/?=
 =?us-ascii?Q?bv5O4D6OtwTA8GnS/3m7QIv/bFlgvpqdKScMuuZI8sAwalUB7NMkxxjm1yGM?=
 =?us-ascii?Q?MFGHAsf1+1jcB2d6tiqG/v7zaZGJDgmuAGLxFUv9OUdeEuc19/Q5sEjgjmI0?=
 =?us-ascii?Q?VnVyc5CU5N7opODvaA4WTWwBb1Z9J20JxYw7poDD3lc5Ert477/VYIX5FJPc?=
 =?us-ascii?Q?gms+xywv2zeWud5ic02pNzJsV9JJxLGXhB7VzoRJ1AgOcyz86sZwH2g5KolJ?=
 =?us-ascii?Q?Y0VClCO1hHBmPHyEfk2q+1G5bs7QoK0HfH4nbIisLDbO6ehwWaWbSqmmexEo?=
 =?us-ascii?Q?k9ce2S0fVzP8tDA0oHmRlTXrH+7mEF7x6nMdGjoLDT1Co/ccIWaF8t8SS5hm?=
 =?us-ascii?Q?+5UcgUufjdEhDtLT8DFjjjiPGL68Bge52J677imryUam+vaFRN0h+sBH+sdT?=
 =?us-ascii?Q?V7OoZdfAvej6FiSo4hCLsQYmUs3dS0n3aSawgAK6N2CREtTbFVUtWC24WEpm?=
 =?us-ascii?Q?dhwbkWK734V9qZ1UlFkN/gYCQVmrV8Wb/KI4K6nlmtNX1Kwo9BTY1qe33+Kn?=
 =?us-ascii?Q?W628UteoSEzhG/P6EmU2cgqqWdJ8KnsOaI6WzCChUYsvznuGL6InmohWzhsS?=
 =?us-ascii?Q?j+XI7IIbMbHjl3nPEqTP7lmPSwr4TfGNehRb+n3eKbU8X4d/qaM9sYSJtG3G?=
 =?us-ascii?Q?02rNBnQinXgieSXg5/2pAaJ8cN0ZxMc8iiHcBjVXRmHVCkqDwimqRekcA40G?=
 =?us-ascii?Q?XOV/+zsiDmHlmlMfTvrSJYOdtsplEuOIYm2gk9EY7u0d2l9Amb9T2pebjdgQ?=
 =?us-ascii?Q?Kg3vctyv0txsVNWnFbtUgbhTyvB8LpnvGxHQEqEZWkrWCYhzhkJh2fEFEmfY?=
 =?us-ascii?Q?G6lovzlrfwG/jlDbEZFDG3oEoM7sdtITgbc319+G3AzSnpjDccq425jeZM3/?=
 =?us-ascii?Q?Fo31Wf0XKSKkhK1m5TOk+POfx12irHORQQRVN1rBgUGDRLbzzgtGpNHMqYSZ?=
 =?us-ascii?Q?F3EqSmpPwzsaYVd40eV8qOl6lH0h94sMt+GLTGr1acpRXecKUjQqvbQsqC2R?=
 =?us-ascii?Q?fZAHIeICGQ9T0PD/fyAwr3WYDGPaDslW0B0UveDM8GWHkQ8LzniGVo9QZjq2?=
 =?us-ascii?Q?M8CG7FAvNcyzrGgX0PTN82TY6vojeWPZ1u40RNwP4G2jjMqQ7m53rCNZAa0E?=
 =?us-ascii?Q?ozaHdmUJwYHl+ZqdhZErASfvmSMDHRgDFChz6jm3XimU+Ae2n35WCKTYD9j0?=
 =?us-ascii?Q?f0KjnJuJJeu3MX5Gf4wcAgMI2PawCMHqMsGp224dd60rLFHX8Psk6m4DTMG4?=
 =?us-ascii?Q?141gZPSV2KrF4Zn7VmZ4GyJ6z3cS0yHSiHddVQt4eWlxcHsHn08lmSqGb44x?=
 =?us-ascii?Q?ekHqqDDXhrpymwYkc1LLVcaBgBCFAYTv7m1VR50wLSbdYiIk9Ra3Nq8B6yMP?=
 =?us-ascii?Q?TDcVboRN2Cm5ktYZxrJvnfI+0tBn87g6Vd04aGqlSaspZ4V+cgi8VPs4x8PU?=
 =?us-ascii?Q?qhP4Mtc0004hUxwSiPMBT94fxPKKZx8+u3j8Lbre?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856752c4-6794-4231-bead-08dcc10a0e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 11:20:11.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5OZjPhZ1JMx+SEBr5SxaW8SwMtLadss+qir1/Ke0fvVaUje5bD2JYHo/7OgWIiePiS6riuzyVBmXIxZhRYTGxfo5j/y4civPijt52gnTXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-OriginatorOrg: intel.com

Hi All,=20

Kindly ignore the v11 patch series, new v12 version will be sent accordingl=
y.
Sorry for inconvenience.

Thanks,
Subramanian Mohan

> -----Original Message-----
> From: linux-drivers-review-request@eclists.intel.com <linux-drivers-revie=
w-
> request@eclists.intel.com> On Behalf Of Mohan, Subramanian
> Sent: Tuesday, August 20, 2024 2:54 PM
> To: linux-drivers-review@eclists.intel.com; tglx@linutronix.de;
> giometti@enneenne.com; corbet@lwn.net; linux-kernel@vger.kernel.org;
> linux-doc@vger.kernel.org
> Cc: gregkh@linuxfoundation.org; andriy.shevchenko@linux.intel.com; Dong,
> Eddie <eddie.dong@intel.com>; Hall, Christopher S
> <christopher.s.hall@intel.com>; N, Pandith <pandith.n@intel.com>; T R,
> Thejesh Reddy <thejesh.reddy.t.r@intel.com>
> Subject: [linux-drivers-review] [PATCH v11 0/3] Add support for Intel PPS
> Generator
>=20
> From: Subramanian Mohan <subramanian.mohan@intel.com>
>=20
> The goal of the PPS (Pulse Per Second) hardware/software is to generate a
> signal from the system on a wire so that some third-party hardware can
> observe that signal and judge how close the system's time is to another
> system or piece of hardware.
>=20
> Existing methods (like parallel ports) require software to flip a bit at =
just the
> right time to create a PPS signal. Many things can prevent software from =
doing
> this precisely. This (Timed I/O) method is better because software only "=
arms"
> the hardware in advance and then depends on the hardware to "fire" and fl=
ip
> the signal at just the right time.
>=20
> To generate a PPS signal with this new hardware, the kernel wakes up twic=
e a
> second, once for 1->0 edge and other for the 0->1 edge. It does this shor=
tly
> (~10ms) before the actual change in the signal needs to be made. It compu=
tes
> the TSC value at which edge will happen, convert to a value hardware
> understands and program this value to Timed I/O hardware.
> The actual edge transition happens without any further action from the ke=
rnel.
>=20
> The result here is a signal coming out of the system that is roughly
> 1,000 times more accurate than the old methods. If the system is heavily
> loaded, the difference in accuracy is larger in old methods.
>=20
> Application Interface:
> The API to use Timed I/O is very simple. It is enabled and disabled by wr=
iting a
> '1' or '0' value to the sysfs enable attribute associated with the Timed =
I/O PPS
> device. Each Timed I/O pin is represented by a PPS device. When enabled, =
a
> pulse-per-second (PPS) synchronized with the system clock is continuously
> produced on the Timed I/O pin, otherwise it is pulled low.
>=20
> The Timed I/O signal on the motherboard is enabled in the BIOS setup.
> Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>
>=20
> References:
> https://en.wikipedia.org/wiki/Pulse-per-second_signal
> https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-
> DxLW6t_V/view
> https://youtu.be/JLUTT-lrDqw
>=20
> Patch 1 adds the pps(pulse per second) generator tio driver to the pps
> subsystem.
> Patch 2 documentation and usage of the pps tio generator module.
> Patch 3 includes documentation for sysfs interface.
>=20
> These patches are based on the timers/core branch:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=3Dtime=
rs/core
> These changes are dependent on patches that are merged in [1].
>=20
> Please help to review the changes.
>=20
> Thanks in advance,
> Subramanian Mohan
>=20
> Changes from v2:
>  - Split patch 1 to remove the functions in later stages.
>  - Include required headers in pps_gen_tio.
>=20
> Changes from v3:
>  - Corrections in Documentation.
>  - Introducing non-RFC version of the patch series.
>=20
> Changes from v4:
>  - Setting id in ice_ptp
>  - Modified conversion logic in convert_base_to_cs.
>  - Included the usage of the APIs in the commit message of 2nd patch.
>=20
> Changes from v5:
>  - Change nsecs variable to use_nsecs.
>  - Change order of 1&2 patches and modify the commit message.
>  - Add sysfs abi file entry in MAINTAINERS file.
>  - Add check to find if any event is missed and disable hardware
>    accordingly.
>=20
> Changes from v6:
>  - Split patch 1 into 1&2 patches.
>  - Add check for overflow in convert_ns_to_cs().
>  - Refine commit messages.
>=20
> Changes from v7:
>  - Split the if condition and return error if current time exceeds
>    expire time.
>  - Update kernel version and month in ABI file.
>=20
> Changes from v8:
>  - Add function to enable Timed I/O.
>  - Changed the updating of tio->enabled to a centralized place in
>    disable and enable functions.
>=20
> Changes from v9:
>  - use tio->enabled instead of reading ctrl register.
>  - change error code in enable_store to -ENODEV.
>=20
> Changes from v10:
>  - Rebased to latest codebase.
>=20
> Subramanian Mohan (3):
>   pps: generators: Add PPS Generator TIO Driver
>   Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
>   ABI: pps: Add ABI documentation for Intel TIO
>=20
>  .../ABI/testing/sysfs-platform-pps-tio        |   8 +
>  Documentation/driver-api/pps.rst              |  24 ++
>  MAINTAINERS                                   |   1 +
>  drivers/pps/generators/Kconfig                |  16 ++
>  drivers/pps/generators/Makefile               |   1 +
>  drivers/pps/generators/pps_gen_tio.c          | 262 ++++++++++++++++++
>  6 files changed, 312 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
>  create mode 100644 drivers/pps/generators/pps_gen_tio.c
>=20
> --
> 2.35.3
>=20
> -------------------------------------
> linux-drivers-review@eclists.intel.com
> https://eclists.intel.com/sympa/info/linux-drivers-review
> Unsubscribe by sending email to sympa@eclists.intel.com with subject
> "Unsubscribe linux-drivers-review"

