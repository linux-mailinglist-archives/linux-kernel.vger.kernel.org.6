Return-Path: <linux-kernel+bounces-343259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CA9898B9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BE91F21886
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83EB3C39;
	Mon, 30 Sep 2024 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfwEx0Bj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A62904
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657782; cv=fail; b=sxYn1CahJQov/mY42fMHTuszoneAYLay1ox0YvrV0ms8NKH0uE46zWZmlKVqXnsdsdDp02mn4pqNQg11K6xFssanevzPveni3TwufJ1RslZJcSilrVkYsEF5y8JkL0GmVF1xu3qeNWUXo/JZyo4DbHnRnpvTkEmx2CiOWBlFUjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657782; c=relaxed/simple;
	bh=ZyF5uF2Pg4F7NzJwxsL1sD6fKKZNMct7rBYGSHDjmHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O7Jml2JYn0rXKrD/Y5DlbVkIy+kdS721RjVTzMB5+ict9YeGBLI9RiI7nfsgHwO0HXda44MIas6dcylS9KNEtMfjMV9uGxqTy2FUs1zdq+biIkxFPN7pRACGGWT2WMbs6LwPHPS/N7Cpmd0Y3pl41DQm0PDNZRCUF7SHK1+LUnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfwEx0Bj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727657780; x=1759193780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZyF5uF2Pg4F7NzJwxsL1sD6fKKZNMct7rBYGSHDjmHY=;
  b=IfwEx0BjnZu3/z7GkgP16IrA+2tQ8RUt6Z4TUMzzQ8CBFZpCYWYSp8/Q
   2aA0nz/LMNQyJf+xH4lB7fKyuuL4PW55oW4fm5R13W4ereE1V3YkY6gZM
   23kCxDl3SVZkadWRMbSXCnGvTV5tSzHVHI2enXwH5Dhq9nevZDleGol2T
   9kaRzcTVtmYRY843xUBnXBLhDWC/jjNagazwQt8SNXbmo4kgn4QX7Udee
   RA2+p3ScKLT6XBRD2G4T9nB1ZYY3YOSS3/N+iXmG3OfHi0iDSN+FyVZew
   lpCNs8KAReFsczOCr8DQ1rQSowQO4I6L6ECXLaLScwy4lfYzjVcW9FB4i
   A==;
X-CSE-ConnectionGUID: ZlcxxFRRShm2YtshXotRAg==
X-CSE-MsgGUID: +sxbzaheQAu9CxSX+kEmzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44191043"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="44191043"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 17:56:14 -0700
X-CSE-ConnectionGUID: RpRppVSnQyOhX8+3hCOvUA==
X-CSE-MsgGUID: jvqD6XhXT6CB+9dNNsOH3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73182349"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 17:56:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 17:56:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 17:56:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 17:56:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 17:56:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vu1QBh+9RrkA4xRd7WNyxOnQY9cClyXjRQU+tZfUZ6AJqEaW3LBTepUdQ4EOGmmJQOoyBVVQv1s/DUN3+EYZWPT1KLVNZkZDgvwhoQKUCrPCjY4cPUMqQWj9qIx6hG6cPmZTD+ZvG4vGzA3MIuJh4glmwwVglENO2gmluF0Nt5ndRzEDFXa4Owd/h1POK+ZD6WUvSaTGmt5Ja3wUcgsZFTC7W8GvnOWTalII0lJa/FM5xvEm1RrzI0Z3RrPa6FuDqfdRZeKW564dmK0ms8uQ+RhGJfwUm9qyG11kdhixh7/YM0VqR7VQyLQo3R2x0JSIgEV2xinCrhr4xtYLFtAZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyF5uF2Pg4F7NzJwxsL1sD6fKKZNMct7rBYGSHDjmHY=;
 b=i7DliiGr255BPCbGGn5UfUqY/zB8UM1m7mekUBxJPtnT1HNZifYn82IZE8/a2JO+ORwEFWTH3l9SF2FqqQ9ExqgrSoXYePSJmrKIIvB5K5NPCE6TqIVPM3IMok8P96Nc+7ri96FN7SwGDhL3XJe1D/LmcxeVFVIXfIVJ1BF7cRlVKfKBmclnX48jdCTRfbq0HphHqMjFsYW2T0Z1q6lswU64mGOTfmSbDLjqEzifs95+yAlTfKtSqvve2STKxVvO/vPfNXDQKRkeqBLgxL4O8LbJVYkEgE9ecSCVMd/XprTVAle3euQXuquqFuVr56bxhn/piPbtgO+sLVyQWQzr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.11; Mon, 30 Sep
 2024 00:56:05 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 00:56:04 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v8 8/8] mm: Document the newly added sysfs large folios
 zswpout stats.
Thread-Topic: [PATCH v8 8/8] mm: Document the newly added sysfs large folios
 zswpout stats.
Thread-Index: AQHbEUxvUJ/L6m6H+0G7hRnO10KBsLJvXQaAgAAm6pA=
Date: Mon, 30 Sep 2024 00:56:04 +0000
Message-ID: <SJ0PR11MB56788F42E3AF18F0D4EF5807C9762@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-9-kanchana.p.sridhar@intel.com>
 <CAKEwX=P0tfz01r7kQgmoZVeChHjk9QPb=9yTgeQk34ndptocMA@mail.gmail.com>
In-Reply-To: <CAKEwX=P0tfz01r7kQgmoZVeChHjk9QPb=9yTgeQk34ndptocMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|LV1PR11MB8790:EE_
x-ms-office365-filtering-correlation-id: f9237171-b6eb-4200-6986-08dce0eaa970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R0xKR0xVR0V4M2thaVVpeGo4QTN2RUNuWmlzelFhcHBEL1dmOWFUbmVkSXBV?=
 =?utf-8?B?Smc4L2FLQzNRY1gxUm5KWUFFZUoyTHBKTGkrSUE3aG9TUm1nYW5CSHFMa3F2?=
 =?utf-8?B?OC9HbEl1TkRmSWRyN01VcWJJQjNyaDRHL0xKb0NzTk5MMlpWaGhzWjkwczg3?=
 =?utf-8?B?NXp1djlIQlVvaUFXZ2oxZnNpZ1VIKyswZGRjeVNXWXY0ZXFkaDVaVlAzK29W?=
 =?utf-8?B?TkpxbTV3TFNLc0RUTlN5UGpWdEdRV1BEZ0doRzlDdFBlN1RCamdkUUVnR2dG?=
 =?utf-8?B?aXhJWFQ3QndZMllxYjBIc3NYdWZmVDNYUG1UeU5xRjgwL1BVQ2pQNE0zSkp1?=
 =?utf-8?B?YXV3UlBlckxvTWNReTZGdVIrd1VZTDhjaFpSRXVLeHVjOS9PZURsd3Y0di9X?=
 =?utf-8?B?Y3JJRkE0WVZoNTMxUHNIOXk3eUZIZm9wM1R0WndqbGM3Y0Q2UUNBQVoyU1pU?=
 =?utf-8?B?OGJNQ3FzNDhBMkJmVXo5OVNWbVpScUhuc29sRmVESzlNL2o0WkNzbE5UVkc0?=
 =?utf-8?B?RkRjNnJuby9JVVRXZytMZVVZQUNkZnA1aTZQNTRxRXdGNkgrVFVhQ3hMTkxw?=
 =?utf-8?B?YkI1Q2FNZnpVTmwzM0xJVldqRjhzbnR6MmpmSWdLTzlzSWIwZSt4SmppQWZj?=
 =?utf-8?B?L3pRM01tRGZ5aFpDTUtabldQRUN6QmgzQjJhaUcvcitnMUpEeGxzb3JxbGRx?=
 =?utf-8?B?VzNtaUJITnBML1poQVRVcEVjQ2d4NmR0ODZJNi9TM3UweUtSUkUzUUNIdGx3?=
 =?utf-8?B?Q0lNMm9Uc1ZNRDR0YmIwK2ZYWXE3MDVzRisvcnp4WHlkT3NoVGxvanFLcVdt?=
 =?utf-8?B?L2c5cHVvZkt3Nm5JRHcxYXlMc1lNUWVqV285OWRVTjYyQVJtOHc3RFc1WWF2?=
 =?utf-8?B?ZFFrSGN6cU5UK043WWozRmNzejFrVks3cHBsb1pNVmNCbURFMU42ZWFUcHZ2?=
 =?utf-8?B?U3NtSC85SzVBcmUyaHphRTVUNVZJcFdhUzdoL2ZTVUVSVXpjc3krVENORzZ1?=
 =?utf-8?B?ZWZDNWUwWCtKSzE1M2hKMTM5bjJ5aVFlLzR4YS9Za2djNEhGQVVWUjhsY0cz?=
 =?utf-8?B?WXZLeFRGODlkNzVXRWdvVGlCeG5ielZ2Y3hoR0pXdVdPSzNPcjJuZkJSQXg4?=
 =?utf-8?B?MEJNZXhaZU5yR3BoSHA4alRHb05IV2Z1Y2xpQmZ1R2NaL2pjYy9yWkYvMDN1?=
 =?utf-8?B?eXFTL25RNmxPQk91ZXhaM1l3enhZeVloSlFQV1RSQng5Y1JtSnl3Z3M5NXd2?=
 =?utf-8?B?Wjh4VS9YMzluMGE4WGhrcDNxSVZjVlloTlUyOGxFSzVIbDFwQVZ4Ullzc3pu?=
 =?utf-8?B?N010TzNLQ2o2TFJNanlaYlNRdEFubHBpcXFWTXl2UW9HSE85UzFrUjRkRDMr?=
 =?utf-8?B?TnRrWFhrOURuQmp6QnZZQ2lnTjZuR0g3YVJNY3U3Q0dGeGp6eEtYcEpiTU16?=
 =?utf-8?B?U1lleGh4elV5dmhCKzVYU09zVW40d2kyMmRYd01jMlVBUDlEdSsraHVJR0xO?=
 =?utf-8?B?RzZwOFBrMnlKODZqWTh5d3RLNmVJUHlYbUhPaEU2eFJ0Mktoc3VOMTBOMUJH?=
 =?utf-8?B?VUt0N2MvR24wVlgwVlRRdzBlWncyMUlicGJpdzRUOTJyZFZtMmY3NWtVMGFk?=
 =?utf-8?B?R2JWRE5McVB2WFphSWYzNXVYRW5WeHJpNko0V01xM0V5cmlmcE1YdXB2dGxh?=
 =?utf-8?B?STJ4MmRUZ3NLRnJFK0V0SnRpaS8xbEVLT1owUlBTTy8yNE9zbnlLUk9oVVFB?=
 =?utf-8?B?cXRuN2dZRG95dFM5ZUJiSkUyaWE4ZHNGWERUVHgxNzc4OXYvekpUclk4akY5?=
 =?utf-8?B?bTc5RWJPdGZxSVd3aGppQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1h1Qm9KQmlmM1RQT0QyUFFYUUVLc3pCaFpxd2tQNzhSKy9jdWdLQXZVTkl5?=
 =?utf-8?B?VTAwdGx1amR5ZlZ5TXlXaGlFQkhIYkZnaWRpaVNWUDl5ckxvVGc3TFdtQkNh?=
 =?utf-8?B?cW1BdVBkUFl1eFRHNkJ4L0hBQm1INWRnUjVQRy9qa05HVDNKOE9tMS94ZDlR?=
 =?utf-8?B?c0lEV3dWc3p0ZmlXc0p0L3U5YTgxQkNmTTQ0eExDRTlCMGxldkwwdEZCNktP?=
 =?utf-8?B?bjlpcTNhUzJlbkMrRFlaQzQvZUl4QmI2a21NNEhZR1Fkb0VzM3RnU3RpWmUv?=
 =?utf-8?B?SytnUkJRZWRKeVpXVkI2Qzdub0NwT3NLU2Q2WC92UmJKM08rTWZFSGt2RlVs?=
 =?utf-8?B?czYzdnlUUEhXb0hjQzRwdktvRDQwS0IvSUlyTWhyUEVkV3VTSkErYkdmOUtx?=
 =?utf-8?B?TnY4SWd5K2VUVjNrQTA2RTFqTU8wa1ZvQmtXeDRRZm85RFMvdFVsNzhERCtC?=
 =?utf-8?B?andPMVpkQzNqM0tDeklnSzNkVzg4S1FkN0pySGg0UEh6N1JHRHI4eit0NjNQ?=
 =?utf-8?B?WG9HazZxSHcrdU4zalVKNXdGU3czN2dWL2FjbGFaeWhXckpkZjdleU40eHdx?=
 =?utf-8?B?Rk1PdW80MWZtR3hIanlzbUo3SUZVU1JQcVBnbXVpZ1djcFlXcFZIZGtBcWFt?=
 =?utf-8?B?Q2Q3anpxRkVyYzRSaTJTODlYQmpGUmtsZzJneDBmTWF6ZVYxc21URElYZm5Z?=
 =?utf-8?B?VUo2dElOUThiRU1uR2dlVXl3TTFZbEc5L2Q3WkVWZUZ0aFlwR0lwOVJpWVFt?=
 =?utf-8?B?SGc2azdNV3VGYllnZ09wMDVKVFdMN0FRS2xYbVRwSENnS0pSWGJvNzJ0NDM2?=
 =?utf-8?B?M1FtOEFPQm81VFNoUlQ3UlMrRTZYcnM3Vm4wV1FPUThhRXlqSFNvSE85anhs?=
 =?utf-8?B?UWFuOCtEMnY2NllZc1cxQ0VnVnM0dzhLVytqUWZRWmwyVXlJeDNvYzVKUlZz?=
 =?utf-8?B?eWxxMzZoSWVkTnZVRDAxdCtnQ2hUUk8zcFcxY2NHd2J6OXNvWm9MUDc5M3U2?=
 =?utf-8?B?SDVEaERKOGtyWlpyRVRHcVVsSUdTOUpYS0lhV2FNM1FXbTZSbjZjVWdNOFRX?=
 =?utf-8?B?VDR1SnhtQ3JVeUVUTEJZT3pzWmJwL1dRZ1lUbXNMekFZY0M4OFZxUzFuaUpV?=
 =?utf-8?B?VVhPN3BqaVVZVlBVOElWbG5mc3JsWjExanNSdkx4R0FxY3VRTjdNaTcwRWdO?=
 =?utf-8?B?enpIeFJ1V1ozRUxkUUh1ZUFjQUNTa1FCcDR1VnpPWVRXWXFUczBoN2N3MHpq?=
 =?utf-8?B?d0dLb2dPRGNTeTIwVmFaUHh6a002cEh5OTZJY3Vxc25TVW9ic3ZBbmVyV3ow?=
 =?utf-8?B?WHRlSVAzbDZYZTh4anBhRU1zbXhpL0UwaGtpY0NBTzA4RFo5bGEvVlRiWXJS?=
 =?utf-8?B?TkpXUGNETWJ3citYN3pnMXA5THNyZnhtSzlsTGdSMXUrRzFlaWkzMnArblQy?=
 =?utf-8?B?QzNGSU5mS2ZnTWlQRjlFNWdFWnpjYzFyUzQ5SENEUjJwWW41bVpSeEkxcE1v?=
 =?utf-8?B?S0taVkhFYVNQaFladHNDNzFBT1djeXdPUUp6dzNnUXJpWDBKTGVtY3ZPK0VW?=
 =?utf-8?B?cnh3bWo0TFhWREwwSFZNREJ2S1RTQVFBTklDMGZzL1RrTjdTUUpOdUhPSGMv?=
 =?utf-8?B?VkoyWTFBR2tDTlVaNUNXNHY4K2Urdjk0SDhxdkRkQjM0WHZrWTYvRHI4T3Fw?=
 =?utf-8?B?VGxzbERjVmJJeEFSR3ZzajNKMW5JWUpWTlc1OGNJZFRHdkp2eTJSNWhRL2Zz?=
 =?utf-8?B?bFhiamtKb0lrOFJ2dGNQWUxuRisyRVh5NHV1VFZaUWhTZ3psOXVWYlJUaEZR?=
 =?utf-8?B?WE03WmV0Tmd0NlF0eGpxZ3U5U1dhWlF6MkE4Z2hsUy83MEhzT0k0dWdPS0Ft?=
 =?utf-8?B?M0xpTHJPVjVUaGU3UjRJeFF6bExxd3FHNk5sNE1XNVZJc0FmLzluUWZoeHNX?=
 =?utf-8?B?WmMwSnBrSTVQVjBhaXFSbVpaWEhaOXF3VHc2QWErYmMrVmpoTU5qa1l0RE1I?=
 =?utf-8?B?ZnAwamdORkhDbjNiL2x2TTRoc1FSVTdqT0VoMHI0dEJQVjdDWFptdTJnSEFy?=
 =?utf-8?B?Y2tJMmFjTEV5dVVTTGU5SEZJcCtNaklHZ0NMamtNVXpSSFJBZGlJQ1BoYmJW?=
 =?utf-8?B?eWRGZmFNVGs1bnA4UjhTdmNhSzhvSW44dTBta1RKKzJRVGp3M3B0LzdwbSti?=
 =?utf-8?B?eUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9237171-b6eb-4200-6986-08dce0eaa970
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 00:56:04.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9e4azoiQc7zluaOajOs+e2UApuTeLeBF1j5syhSAoRz+eU07jOYLy+s4mKGKBjmViC+IfF/WbyahszEh6f59BeTTSMGt5GTBscVWIG/XNmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8790
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJlciAyOSwgMjAyNCAzOjM1IFBNDQo+
IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0K
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0K
PiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbTsNCj4gY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2OyB1c2FtYWFyaWY2NDJAZ21haWwuY29tOw0KPiBzaGFrZWVsLmJ1dHRA
bGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVh
bmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc7DQo+IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRp
IEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGgu
Z29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDgvOF0gbW06IERvY3Vt
ZW50IHRoZSBuZXdseSBhZGRlZCBzeXNmcyBsYXJnZSBmb2xpb3MNCj4genN3cG91dCBzdGF0cy4N
Cj4gDQo+IE9uIEZyaSwgU2VwIDI3LCAyMDI0IGF0IDc6MTbigK9QTSBLYW5jaGFuYSBQIFNyaWRo
YXINCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRk
ZWQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIG5ld2x5IGFkZGVkIHN5c2ZzIHBlci1vcmRlciBodWdl
cGFnZQ0KPiA+ICJ6c3dwb3V0IiBzdGF0cy4NCj4gPg0KPiA+IENsYXJpZmllZCB0aGF0IG9ubHkg
bm9uLXpzd2FwIHN3YXBvdXRzIHdpbGwgYmUgYWNjb3VudGVkIGluIHRoZSBleGlzdGluZw0KPiA+
ICJzd3BvdXQiIHN0YXRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlk
aGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiANCj4gTEdUTS4NCj4gUmV2aWV3
ZWQtYnk6IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+DQo+IA0KPiBJIHRoaW5rIHlvdSBj
YW4gc3F1YXNoIHRoaXMgdG8gdGhlIGxhc3QgY29tbWl0IChpLmUgYWRkaW5nIHRoZSBuZXcNCj4g
c3RhdHMgYW5kIHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGF0IHN0YXRzIGF0IHRoZSBzYW1lIHRp
bWUpLiBCdXQgbm8NCj4gc3Ryb25nIG9waW5pb25zIDopDQoNClN1cmUgdGhpcyBzb3VuZHMgZ29v
ZCwgTmhhdCENCg0KVGhhbmtzLA0KS2FuY2hhbmENCg==

