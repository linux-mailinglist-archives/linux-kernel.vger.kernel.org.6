Return-Path: <linux-kernel+bounces-414881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C7A9D2ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B29B26F28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68250153824;
	Tue, 19 Nov 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZeURfPP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12E126BFA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044176; cv=fail; b=CnAocipzdyTaNqymfcEtAPaI7FfbfDTfYwAYTDi7/JPAdUqOFK4Q264ByyYGqLW+sC5WsPDmNYuAdAlhnWSNDvplpFu1AtcyGV88AuqRO0gyPEaQzVybtsKHVYOyFBj5Ug705yyJcB9n4gH/Zy4DMcVVxA9bpTgx+QdbEqvEyfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044176; c=relaxed/simple;
	bh=gKu9QrhOhS3p2chYpM/44GD7SnUgTIklyDWODkaMG3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBofKkHqvp5IyZa/eVdQsCUZBCsFvJy8PAKmukJkrwfwkRNgy6oCoVjJJn5VZc+CpVUAEudAQrcBKXJI6FdEvGlkVuzYOerMW4KnuHN2ELpQpCCV2U9GSwiuy6QcpWtEHL/fk4jiyTaHuxfU7pq1x7ATBplaNLxYw5/+oANYqX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZeURfPP; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732044174; x=1763580174;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKu9QrhOhS3p2chYpM/44GD7SnUgTIklyDWODkaMG3E=;
  b=nZeURfPPHjBzdeD2dDw7Did3XCvO5cIqWi1dXD81rFTMs7WxENEqJIsS
   xaJyA8qloDVl+CHwmNHi3Wgvj45oXGPmK6HuvVQEIYzt8JLtZRMrV3exC
   vktZP/Tya1x8S7ZwrxvgldUKK9jCahlRPRPVsRNu7XeGGR5Uwfre0dYms
   AaE4D1PVy5kZtoZvqKT+WdvWeAs2XmoTTqvbTCrTC9Abbuw8/GW/v3XzS
   o6F2JQ54z8imUWMK2cuGXejXortOhR8sUlLgpuLTKI6Zq4NlyZkknchyl
   ZBtuu/BjIFhlDTDgqzO/0zeAV5twlzFh1Ec21X29wCzl305O0vTPhWBN/
   w==;
X-CSE-ConnectionGUID: knSvo+tcRk2hSbsUevLi+g==
X-CSE-MsgGUID: 7PcAM69PRMCG1NcSvFiFnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32316913"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32316913"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 11:22:52 -0800
X-CSE-ConnectionGUID: Ew82WC9vRsqYEbcES3GxYA==
X-CSE-MsgGUID: lVREitGoT7eRVNKHezfO9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="90078266"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 11:22:52 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 11:22:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 11:22:51 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 11:22:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRRFK2rF3u+yIGJH7rjv5ZAJy6PN9EuVho83JINd0/QElN/d4gaaG3sqTPyCkM2ANl1lQz56BI7HeBo4ZtmtKGVMLCrJZAj9dFkI2abQzqm991Hvu863263twQ51/cR6bp2QFDzHjrR6XtKHeVipRdoHGNB6dBRrYQsrq+kho4LcC+cEnkKR8nBmJ8ja0/v3rIOhWBpceWP6B4yDNWkNsjbRe26Y6sy77UNtHca5X6ma2+elr3VGQgVlhBgZvwPIrT6MEB4DMv90m02Vie2bc/bdvFlScTRCJ0pYQHPqzDQL/rUGtFtHKJXC4ET5PYWub0oAC7GyXHNxs3J8xRtfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKu9QrhOhS3p2chYpM/44GD7SnUgTIklyDWODkaMG3E=;
 b=W2qPltUyZ4JVvrmyPgQIq5cENNU6UHGoSJ3DwdMgPFCbOLkEE0xKM7Cii8H/mf+HsBHim1CrurA69y0MXem5Y6kXo9eab0px52WnhaTXWJZQPFoO7lh1BHgt9J0bOPSplAJir+fSv1cGPDo7RTcCNIqSJ92FY4YtNJbZEPnVk6HajUZMnlDPe2k+k3DcruSovcvuXf/z3PLa/K9wk825BNEZNtfAbcj+bt37WeMv7MliYnteLXh3xuANvrxUDKnjWJgdPlplPCFOdPVW+lIBfCDJodIfo+jWQysHAvjNydzyGvZayX8eHSZ+K8ZkJqE+MlOgCvH4mmAj4HtFGR4lew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB5779.namprd11.prod.outlook.com (2603:10b6:806:22b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Tue, 19 Nov
 2024 19:22:36 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 19:22:36 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwIAALQAAgAAWEyCAADkJgIAAFDJAgAAQz4CAAnAwsIAAE8aAgAYeOFA=
Date: Tue, 19 Nov 2024 19:22:36 +0000
Message-ID: <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org>
 <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
 <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB5779:EE_
x-ms-office365-filtering-correlation-id: 9e34fa88-3405-4fca-e8e3-08dd08cf865b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VklkYkdxSUV1ZkdQK3ZhclZacHJ3MjRnamUrTFNtcmV6d0UzZk1RYnphTk05?=
 =?utf-8?B?U3NackRleTlnZlhiNTgydStiL3VTaGZxb2d0dVZsbjNyUlRFU1kwRGNvemI3?=
 =?utf-8?B?YjlZMGRGUm5yNzV1YUNtYm9FUDhkcHZrYWE2cmdXbENZWnIzM084eGtVc1pQ?=
 =?utf-8?B?UDhwaTBRd0ZMS1R5ek5BTkhJcXRwaVh0RGJ2SlZCNEFML25mSUJqWkNIWUJv?=
 =?utf-8?B?UVJrSzdSWWhtbGYwUUZPblczY2dNTUFMTHhta29DVzZxUUt6c3FwUDdGcXJZ?=
 =?utf-8?B?WnV3OHNRWTl5bnhSVXRMYlV4cDNwVHlJdkZud3UzalIvUjhiRDRmbC80NzJD?=
 =?utf-8?B?VzNmYzVHN2pRZTRyZEg4ZmphbUQ4RzVrQ2lleFBvM0hONys2V3NlRkRNM2JB?=
 =?utf-8?B?c2JhSmw2bUVrL1NSZlJJNkhCZzdtUUJlU3JpUUF0cVhyVHpkRnRlS0h4OHpl?=
 =?utf-8?B?Mm0wa2VRa3ZRR3J2VW5FTWVWRjZ2Q0hmUkNoY2k0VjJGR3V5cWZxS1lYTTl0?=
 =?utf-8?B?WGF3UlNtMnNKd1BRZlVPTTB1Smd0SG9vdlg5cHdrTmFjcEhnUW9CWUFnS1Vj?=
 =?utf-8?B?RTliUDJlU3FqRjlUVXYvQ1ZOWGNqeU9KM1VwVWtHOU1VOWxNblRHSkJWdEhN?=
 =?utf-8?B?WC9zdk1Fb1FFWHpFbE8zQVYzVWFnMGdOS0gzTTM3RVRuaktnbUZHWktpa2NI?=
 =?utf-8?B?OE0vTmE4OFBTeTZoSVJqc3VJWjh4ak1rcnJlU2hhZmNiNjVSM2ZrM0syWmhH?=
 =?utf-8?B?SzB3eTNYc1hEV1g1RzlkdFJ6dmNNZ2lLWC9yWjZLelp5Rm9IUjdUQzBoRFNJ?=
 =?utf-8?B?by9zYk9MaldyNWQ1MGFYcFhxT04vZkl3MGJLUFRSbC9lbEhqWTRpQ0ltcDlU?=
 =?utf-8?B?RXNwRWQrQmdCZUdIN2lDUWcwNzRTd3RhekxRSDR4V2JhdnJMekY3cnNGU0E5?=
 =?utf-8?B?NHU5MFErQmxnMzZJd1llek94Zno3c2pZT2FXWi9GQ21kdEVPODBhQS9YMC9M?=
 =?utf-8?B?NXJLcWJNb2NNWjhwTldxaGdjYldHNDM3dDBrNUhwRHdVeG1VMk5lSkxKRnZu?=
 =?utf-8?B?ZUFoU0o5Vm82b0V6YVFnMzJYb25PZnB4T2VoZE5yNGltQTU3VHRyQjR5Y2p6?=
 =?utf-8?B?Q0N0S2FKNGRVMURBazZId1V5K2syWnRmVUlCRGJ0bUE1aXc3WXFYZW1rWG1E?=
 =?utf-8?B?NGNzTEtCc21tNjluL0xXV29YZ3FBSUhndjYvQjY3bkluWk5TQjdPSXJJK1lo?=
 =?utf-8?B?VVhxUVVuSXowSkNrREZMemJKUHpFSmNqb2xKY0tDcC9ZbDVwU0xMbkFiYjdI?=
 =?utf-8?B?ZHlFRWVQb0RnTi9NeEZuS2hVQTJkbnE4STI1SGNXbE1WOElZeWE2aHorRk9V?=
 =?utf-8?B?TndoQ1hzaDhiSmxjR0s4T09ZQ3dVaHpkbEhsWjZPSGVWNVREYnNaYnlUekVo?=
 =?utf-8?B?QTUzQjlQeUJxNW5NdXM1QWhKN2dXY3pLdllnaUJkb2JXWGlVd0g4VXV1eHVY?=
 =?utf-8?B?aUFRYWVnVG5JRjYxaTY0NWV0UEJCbnhxYkx6dlJmdWhFVHUyZGNaNDhZNzh3?=
 =?utf-8?B?Z1ZBYmJwSlNXODFRbTZQVytEMVVKWE95UGdKRWdBaXlQWUozV2RNYi9lemwr?=
 =?utf-8?B?a0lQN0ZhOWlyNnJFaU5HTGtmN01ncGRjbys2K2FLY1BoSVpKWjNQTUpucW92?=
 =?utf-8?B?a0JvL1pXUGM0TWJoNm5GL3daMURsS3BjNVVvMURIT0dkMm9HZmhHc0EyaTZQ?=
 =?utf-8?B?NE1WZ3VqbngxZng2RGh5RnAvR3g2U1JwMUlIRkVnaXpsQjNXd3hQMkpYM1dv?=
 =?utf-8?Q?o0jqXEohmRtiUCk3yYZ1pq6RdMw6+0+ig3oyI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFg2K1BMVXQ1cHdkeHlqTVlybWlrZzFUSTBXQWZWTG1JekhJaXg5aHcyMTlj?=
 =?utf-8?B?cVBKWUdsbG45WFNrMzZNZVBvQVBKdkN2UFV2M3piekpCUlU1YlhzZzZxcDdx?=
 =?utf-8?B?cXJCRzk2V1dLcUY0c2F3VkJHYXBtRmlhWlNnSGJZektuc3lIOFV0NEpheFdQ?=
 =?utf-8?B?b2FYNnRvMFRDbjdCc2paT0Y5eGtlRVBtdWFPS0FFT2swbUZudG8vaXRyd0lU?=
 =?utf-8?B?anJrMlUxNVBGVXVqQ3hHSElrNWF1T3NvMjgrQlpKVHl0MG51ZVllNXoveWhv?=
 =?utf-8?B?RHJOK3VBSW5wTEFENnIzWFVvKytQK0JVWVU4NEF6UDI2cVV0Z2FiMGpycEov?=
 =?utf-8?B?THFvM1JpaGhuVDNyZUNUbGQvdVE2OGRDUFlSTklsend5ZXcwczVJdU95dk8r?=
 =?utf-8?B?RXZCRGRWdDhJNzhKTEFvSFFWV2FTZnFZcXNDMmZaQnA0UWUxR1FvUkNuRWxh?=
 =?utf-8?B?dVp2THh0Y3VsaE1ld0JHeXVzKzRyRjFzdWFtUlkyczZZTmIwU283SjI3VExh?=
 =?utf-8?B?elV3VXNsTGoyUmx4S1R4Z3lhRk5mZUIvY0V0ME5qZFdvMEI5ZXRFVGY3SFhG?=
 =?utf-8?B?L3dNYjNRWmtyRS8vYUwxTW5sbGovaFlPdzZxZWoyRDFONDRNSUVLTHUxMTdE?=
 =?utf-8?B?VmlXWlcrcnFTaitmSUpTVkRMQmpVRDdzZ1Jsdi9UOVJ0TWgrcDd1YW9xRk9N?=
 =?utf-8?B?YVMrVkNTYkJwZEMwbE1xdlRkNjUrR3VQN0E2OExHQnN6T2hEbi9kWFF1eVN5?=
 =?utf-8?B?a3d2THlLeVdXYmpQczZGVGs2TUtvblA5WlpDZ2pWQ2xtUU80MmZidWt5aDU3?=
 =?utf-8?B?WnJubkRzejF0MUxqVGQ5cEk3T2t3a1JwUFRFSlF3dlFIdVlKc2NoZitJeU5K?=
 =?utf-8?B?OHk2LzJpNERzNDI5QTZ2WUZZUklKUFpsb3pjRDRwc0R2dWZnb25HcTYzalJW?=
 =?utf-8?B?a2JJdHc0TERicnRWYytSbnF6QTZVY3NRTWMrN2tIWnNTS0dMSFBHd3N4Rmtv?=
 =?utf-8?B?NmoydlAycm9tWFY1YStBS3RIUXdXZ21waVJwekhmY3VwSG5qZ2ZBWjAyOUZi?=
 =?utf-8?B?UFZwNnhaSkM1L3lGTEd6WkR0cFBQSW1QWlk4OU5GOGtkRmdRWXM1V1pkZ01L?=
 =?utf-8?B?N1BlRjEyM0RuTW9NTVRZUU9hS0xYZWJveWt4bjVpTGNiOTd0eTlNNTQ4YUVs?=
 =?utf-8?B?Smo2SGJrVEo3ak9Pbk9GendGYy9MTjJRT1AyMjJmaDRKQXd6SXlEc292NTIr?=
 =?utf-8?B?WUhyK3dVYmpmSWdxNUtBUDRZemdVTlY0MmRab2RJOHFsdGozRlhhaDltTHUw?=
 =?utf-8?B?dlBpVVpTTUljbVJpd0VpNmQ1S1VjVEZJcTVuN25nUC8vMmZXUVc0RVM2Ly9H?=
 =?utf-8?B?OUx1VnFJYTljTURUclh5NTRnai90RXY5VnBVYit2cTVvNW83QzMrZHhyVWt1?=
 =?utf-8?B?bFdNWXMraGZuc3FJVmpjV0RNQjlBb1dhWFh0MktRR2tYbGlDTVFHWUhOaTc4?=
 =?utf-8?B?N0g2T0pEZXNvSmcxc1NYd0Y5YStadzNTeElWdi9sZ2Y4OGFHQkw0ZU1ZRTZ2?=
 =?utf-8?B?YlhoUDBQY1FGdWg2L0U3S212MWwvVFpjcjJGZFIzOEgxdWNhSG9aZ0pSVmE3?=
 =?utf-8?B?dTgvRUgzeU9LY3hBYWh6TFFFcld3bVgxRnVvckJBcUtkbkNIemtPRHVHZzBa?=
 =?utf-8?B?SlBEUVd0SjJWL1ZEQnMxMGZVdVhHWG93ODRqenF5WExuSmtBaFY1QlNrSUNk?=
 =?utf-8?B?czIwWnNXb0toS2QzeFlLWDlCMEVHMHZIbTJrRWxkSmxzZDhnNEZkTzk2MEdY?=
 =?utf-8?B?SDFuZHI2SS9tbmFKV0wxclFWTTc0WEV5Z0J5UXYxNjY2cUIydkFZTUp2ZjlB?=
 =?utf-8?B?K3FkUkxuSEdyZWNLdmVZSHJ2NE5BMW1NMUpWbjhTdkNyTGdNZUdFbWFraHZz?=
 =?utf-8?B?ODBlKy9qQXVaVm5GSjJlSkZOdUF4RVpkbGF5NTFxU0Y1NWdhZjVjTVdPZGVx?=
 =?utf-8?B?VG1mMDNLZHFFZzFKK2RVeXR5Z3A5V0g2RkIvMUFJbUM0SnVRWjlhUkMyM1Ni?=
 =?utf-8?B?WlRpTXJhb21LWThtZnc0NWY5UzJqMjRnK05tZGNnNmFjOFM2YzQ1WmluTWVn?=
 =?utf-8?B?VHlZUnZHWmFlRVduY1dodFFOSDRKYUtGVjRrUFlkcFU0K0xTTStjYkU5NEsx?=
 =?utf-8?B?bkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e34fa88-3405-4fca-e8e3-08dd08cf865b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 19:22:36.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THIv8f1JTiMOk/IK1dHUi+pQs+nNaMvB+7oo8Q9lc6RImhQLkXHuZc79Er1V4cMSV8FPUn05FaJFkZ8C7x5hj70cTOtaKNa5nE83eJyotyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5779
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTUsIDIwMjQgMTo0
OSBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4NCj4gQ2M6IENoZW5nbWluZyBaaG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+OyBK
b2hhbm5lcyBXZWluZXINCj4gPGhhbm5lc0BjbXB4Y2hnLm9yZz47IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1A
a3ZhY2sub3JnOyB1c2FtYWFyaWY2NDJAZ21haWwuY29tOw0KPiByeWFuLnJvYmVydHNAYXJtLmNv
bTsgSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsNCj4gMjFjbmJhb0BnbWFpbC5j
b207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRp
LmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBtbTogenN3YXA6IEZpeCBhIHBvdGVudGlh
bCBtZW1vcnkgbGVhayBpbg0KPiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+IA0KPiBPbiBGcmksIE5v
diAxNSwgMjAyNCBhdCAxOjE04oCvUE0gU3JpZGhhciwgS2FuY2hhbmEgUA0KPiA8a2FuY2hhbmEu
cC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBDaGVuZ21pbmcsDQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBDaGVuZ21pbmcg
WmhvdSA8Y2hlbmdtaW5nLnpob3VAbGludXguZGV2Pg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBO
b3ZlbWJlciAxMywgMjAyNCAxMToyNCBQTQ0KPiA+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAg
PGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBKb2hhbm5lcw0KPiBXZWluZXINCj4gPiA+
IDxoYW5uZXNAY21weGNoZy5vcmc+DQo+ID4gPiBDYzogTmhhdCBQaGFtIDxucGhhbWNzQGdtYWls
LmNvbT47IFlvc3J5IEFobWVkDQo+ID4gPiA8eW9zcnlhaG1lZEBnb29nbGUuY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiBtbUBrdmFjay5vcmc7IHVzYW1h
YXJpZjY0MkBnbWFpbC5jb207IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiBIdWFuZywNCj4gPiA+
IFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGlu
dXgtDQo+ID4gPiBmb3VuZGF0aW9uLm9yZzsgRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdo
YWxpQGludGVsLmNvbT47IEdvcGFsLA0KPiBWaW5vZGgNCj4gPiA+IDx2aW5vZGguZ29wYWxAaW50
ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBGaXggYSBw
b3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4gPiA+IHpzd2FwX2RlY29tcHJlc3MoKS4NCj4gPiA+
DQo+ID4gPiBIZWxsbywNCj4gPiA+DQo+ID4gPiBPbiAyMDI0LzExLzE0IDE0OjM3LCBTcmlkaGFy
LCBLYW5jaGFuYSBQIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+ID4+IEZyb206IEpvaGFubmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcu
b3JnPg0KPiA+ID4gPj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAyNCA5OjEyIFBN
DQo+ID4gPiA+PiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGlu
dGVsLmNvbT4NCj4gPiA+ID4+IENjOiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPjsgWW9z
cnkgQWhtZWQNCj4gPiA+ID4+IDx5b3NyeWFobWVkQGdvb2dsZS5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+ID4+IG1tQGt2YWNrLm9yZzsgY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOw0KPiA+ID4gPj4gcnlh
bi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+
ID4gPiA+PiAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgRmVn
aGFsaSwgV2FqZGkgSw0KPiA+ID4gPj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3Bh
bCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiA+ID4gPj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBGaXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4g
PiA+ID4+IHpzd2FwX2RlY29tcHJlc3MoKS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBPbiBUaHUsIE5v
diAxNCwgMjAyNCBhdCAwMTo1NjoxNkFNICswMDAwLCBTcmlkaGFyLCBLYW5jaGFuYSBQDQo+IHdy
b3RlOg0KPiA+ID4gPj4+IFNvIG15IHF1ZXN0aW9uIHdhcywgY2FuIHdlIHByZXZlbnQgdGhlIG1p
Z3JhdGlvbiB0byBhIGRpZmZlcmVudCBjcHUNCj4gPiA+ID4+PiBieSByZWxpbnF1aXNoaW5nIHRo
ZSBtdXRleCBsb2NrIGFmdGVyIHRoaXMgY29uZGl0aW9uYWwNCj4gPiA+ID4+DQo+ID4gPiA+PiBI
b2xkaW5nIHRoZSBtdXRleCBkb2Vzbid0IHByZXZlbnQgcHJlZW1wdGlvbi9taWdyYXRpb24uDQo+
ID4gPiA+DQo+ID4gPiA+IFN1cmUsIGhvd2V2ZXIsIGlzIHRoaXMgYWxzbyBhcHBsaWNhYmxlIHRv
IGhvbGRpbmcgdGhlIG11dGV4IG9mIGEgcGVyLWNwdQ0KPiA+ID4gPiBzdHJ1Y3R1cmUgb2J0YWlu
ZWQgdmlhIHJhd19jcHVfcHRyKCk/DQo+ID4gPg0KPiA+ID4gWWVzLCB1bmxlc3MgeW91IHVzZSBt
aWdyYXRpb25fZGlzYWJsZSgpIG9yIGNwdXNfcmVhZF9sb2NrKCkgdG8gcHJvdGVjdA0KPiA+ID4g
dGhpcyBzZWN0aW9uLg0KPiA+DQo+ID4gT2suDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IFdvdWxkIGhvbGRpbmcgdGhlIG11dGV4IHByZXZlbnQgdGhlIGFjb21wX2N0eCBvZiB0aGUgY3B1
IHByaW9yIHRvDQo+ID4gPiA+IHRoZSBtaWdyYXRpb24gKGluIHRoZSBVQUYgc2NlbmFyaW8geW91
IGRlc2NyaWJlZCkgZnJvbSBiZWluZyBkZWxldGVkPw0KPiA+ID4NCj4gPiA+IE5vLCBjcHUgb2Zm
bGluZSBjYW4ga2ljayBpbiBhbnl0aW1lIHRvIGZyZWUgdGhlIGFjb21wX2N0eC0+YnVmZmVyLg0K
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSWYgaG9sZGluZyB0aGUgcGVyLWNwdSBhY29tcF9jdHgn
cyBtdXRleCBpc24ndCBzdWZmaWNpZW50IHRvIHByZXZlbnQgdGhlDQo+ID4gPiA+IFVBRiwgSSBh
Z3JlZSwgd2UgbWlnaHQgbmVlZCBhIHdheSB0byBwcmV2ZW50IHRoZSBhY29tcF9jdHggZnJvbSBi
ZWluZw0KPiA+ID4gPiBkZWxldGVkLCBlLmcuIHdpdGggcmVmY291bnRzIGFzIHlvdSd2ZSBzdWdn
ZXN0ZWQsIG9yIHRvIG5vdCB1c2UgdGhlDQo+ID4gPg0KPiA+ID4gUmlnaHQsIHJlZmNvdW50IHNv
bHV0aW9uIGZyb20gSm9oYW5uZXMgaXMgdmVyeSBnb29kIElNSE8uDQo+ID4gPg0KPiA+ID4gPiBh
Y29tcF9jdHggYXQgYWxsIGZvciB0aGUgY2hlY2ssIGluc3RlYWQgdXNlIGEgYm9vbGVhbi4NCj4g
PiA+DQo+ID4gPiBCdXQgdGhpcyBpcyBub3QgZW5vdWdoIHRvIGp1c3QgYXZvaWQgdXNpbmcgYWNv
bXBfY3R4IGZvciB0aGUgY2hlY2ssDQo+ID4gPiB0aGUgdXNhZ2Ugb2YgYWNvbXBfY3R4IGluc2lk
ZSB0aGUgbXV0ZXggaXMgYWxzbyBVQUYsIHNpbmNlIGNwdSBvZmZsaW5lDQo+ID4gPiBjYW4ga2lj
ayBpbiBhbnl0aW1lIHRvIGZyZWUgdGhlIGFjb21wX2N0eC0+YnVmZmVyLg0KPiA+DQo+ID4gSSBz
ZWUuIEhvdyB3b3VsZCB0aGUgcmVmY291bnRzIHdvcms/IFdvdWxkIHRoaXMgYWRkIGxhdGVuY3kg
dG8genN3YXANCj4gPiBvcHM/IEluIGxvdyBtZW1vcnkgc2l0dWF0aW9ucywgY291bGQgdGhlIGNw
dSBvZmZsaW5pbmcgY29kZSBvdmVyLXJpZGUNCj4gPiB0aGUgcmVmY291bnRzPw0KPiANCj4gSSB0
aGluayB3aGF0IEpvaGFubmVzIG1lYW50IGlzIHRoYXQgdGhlIHpzd2FwIGNvbXByZXNzL2RlY29t
cHJlc3MNCj4gcGF0aHMgZ3JhYiBhIHJlZiBvbiB0aGUgYWNvbXBfY3R4IGJlZm9yZSB1c2luZyBp
dCwgYW5kIHRoZSBDUFUNCj4gb2ZmbGluaW5nIGNvZGUgb25seSBkcm9wcyB0aGUgaW5pdGlhbCBy
ZWYsIGFuZCBkb2VzIG5vdCBmcmVlIHRoZQ0KPiBidWZmZXIgZGlyZWN0bHkuIFRoZSBidWZmZXIg
aXMgb25seSBmcmVlZCB3aGVuIHRoZSByZWYgZHJvcHMgdG8gemVyby4NCj4gDQo+IEkgYW0gbm90
IGZhbWlsaWFyIHdpdGggQ1BVIGhvdHBsdWcsIHdvdWxkIGl0IGJlIHNpbXBsZXIgaWYgd2UgaGF2
ZSBhDQo+IHdyYXBwZXIgbGlrZSBnZXRfYWNvbXBfY3R4KCkgdGhhdCBkaXNhYmxlcyBtaWdyYXRp
b24gb3IgY2FsbHMNCj4gY3B1c19yZWFkX2xvY2soKSBiZWZvcmUgZ3JhYmJpbmcgdGhlIHBlci1D
UFUgYWNvbXBfY3R4PyBBIHNpbWlsYXINCj4gd3JhcHBlciwgcHV0X2Fjb21wdF9jdHgoKSB3aWxs
IGJlIHVzZWQgYWZ0ZXIgd2UgYXJlIGRvbmUgdXNpbmcgdGhlDQo+IGFjb21wX2N0eC4NCg0KV291
bGQgaXQgYmUgc3VmZmljaWVudCB0byBhZGQgYSBjaGVjayBmb3IgbXV0ZXhfaXNfbG9ja2VkKCkg
aW4NCnpzd2FwX2NwdV9jb21wX2RlYWQoKSBhbmQgaWYgdGhpcyByZXR1cm5zIHRydWUsIHRvIGV4
aXQgd2l0aG91dCBkZWxldGluZw0KdGhlIGFjb21wPyBJZiB0aGlzIGlzIGFuIGFjY2VwdGFibGUg
c29sdXRpb24sIGl0IHdvdWxkIGFsc28gcmVxdWlyZSB1cw0KdG8gbW92ZSB0aGUgbXV0ZXhfdW5s
b2NrKCkgdG8gb2NjdXIgYWZ0ZXIgdGhlICJpZiAoc3JjICE9IGFjb21wX2N0eC0+YnVmZmVyKSIN
CmluIHpzd2FwX2RlY29tcHJlc3MoKS4gVGhpcyB3b3VsZCBlbnN1cmUgYWxsIGV4aXN0aW5nIHpz
d2FwIGNvZGUgdGhhdCdzDQp3aXRoaW4gdGhlIG11dGV4X2xvY2soKS1tdXRleF91bmxvY2soKSB3
aWxsIHdvcmsgY29ycmVjdGx5IHdpdGhvdXQNCndvcnJ5aW5nIGFib3V0IHRoZSBhY29tcF9jdHgg
YmVpbmcgZGVsZXRlZCBieSBjcHUgb2ZmbGluaW5nLg0KDQpOb3Qgc3VyZSBpZiB0aGlzIHdvdWxk
IGJlIGEgY29tcHJlaGVuc2l2ZSBzb2x1dGlvbiwgb3IgaWYgaXQgd291bGQgaGF2ZQ0KdW5pbnRl
bmRlZCBjb25zZXF1ZW5jZXMgdG8gdGhlIGNwdSBvZmZsaW5pbmcgY29kZS4gV291bGQgYXBwcmVj
aWF0ZQ0KY29tbWVudHMuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4NCj4gPiBCYXNl
ZCBvbiBKb2hhbm5lcycgZWFybGllciBjb21tZW50cywgSSBkb24ndCB0aGluayBpdCBtYWtlcyBz
ZW5zZSBmb3INCj4gPiBtZSB0byBzdWJtaXQgYSB2Mi4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBL
YW5jaGFuYQ0KPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzLg0K

