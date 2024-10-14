Return-Path: <linux-kernel+bounces-364070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD999CAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31270283BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449B1A76CC;
	Mon, 14 Oct 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBv6ceaj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB31A76BC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910403; cv=fail; b=TX9HKf6pX9TJyPLYUuEBAD3n5ypCzmLE8HTHsUK3dTmrNkhDA3JiPSrwFJR39bey/GvXjVh7uPhHxZfXLQDowhlJT9vJRAg26UcanLIf9UXyFOGEu5KT8t3FYJCTNP4/xlJmFjw7njKuyk4n90shTNE4+eVWBmr8UAo4MiHbwLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910403; c=relaxed/simple;
	bh=hzavRb9YIzX7Y0cE4IJYmzdPTGR5ClWnNHHjesvIr6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmZyaG11cKk1K2ocnS/CDDqvXbvF0A7F9Ar5G6B/pViroeaeBV8ff2g7qQYATQFneJVmCRU+l4iogpu9ziKLUMk9gQd2e2Hfkbej6b+0qBpXtaN3nCh6YzKh8qTdKj6igT98QeNj2IAe5UT+2kr3gq2njuAYmwwdzPXeUt0UAEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBv6ceaj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728910402; x=1760446402;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hzavRb9YIzX7Y0cE4IJYmzdPTGR5ClWnNHHjesvIr6c=;
  b=gBv6ceajwToteQ9xqu1079cxeUzzws5iSRPeRuZfEW5Zfh34UkMdS8xN
   YeCqxaE9xStTUgaGjXDJIaQyivpkDzkZ8eDEKA3+u9rNfttLlmG9iNnPJ
   uXFElMKK1aWWbDcCzgr+p8G4bfFLCSDqZPgkIWSYEL6cQ/3Pzi254p36K
   qcDibuEuDayVhrM2NiyABGqeqvcrdN/KDnYJEporuNKPTnDLMRP8GhwNt
   D5CGPy0ws381UucJPz3OnsJ96Yq0dJe00NEtV6KRnygIHFjwwStJOoTcb
   BmS6alMPw+KCeVI1wSD8eMUwx3Tt1/MwjVkFXM/QFyGeCJOmdXIHphZFg
   w==;
X-CSE-ConnectionGUID: ax2xoX7gRA+Th3g9bZg/hQ==
X-CSE-MsgGUID: rPDT4UTVTziXo3TboFb/ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28139727"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="28139727"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 05:53:21 -0700
X-CSE-ConnectionGUID: 51h6/UDYRYGhtcVixzbCTQ==
X-CSE-MsgGUID: 2NqHdEOxSFGS/jp++sGwHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="82131503"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 05:53:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 05:53:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 05:53:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 05:53:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 05:53:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 05:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix4UoYVHAQtHFlqmsVRr/BSQD0eHuylzMbF8oPNnpqQsCyEOW1CklnauEDhKLH8dxPhlx91kGbo0fXmSK34dWsR5vtPtCADP3O+H+flQwREcNziN6fwqiE0O/hP+qtqx18Z/wEkCb7DYyaB86ENFpsLeg5O9AwAn8VmyIYxOu6esm/a1NYiatb+vWWTdk/oGLPv31ezW9ecreiWpZKrzKHgnIppnbL5iySb6tFizvUU+VcFeXjPUS7pkz1jM1AUxJSGZhJl1Osg3blwZE7VWClZ85An4xc9HQJSg6D/k53TPtB1XluRRrTuxLfJaZjNCBrbgT6d1wok7WQG2aouvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kQDce433NQ+MgNPZMA6IdbZXJf+v3TTKKswjiShkKU=;
 b=d3B0UChpcMev6Rw71XubxiYdwY9Bfsu1he0aNXadVb0hE3cclCodW7us5yLdyn5Co/80P0jXQqrrOknu8fhBL9uMlTEKg3b6s+WJaDdv+LP7tccIupTcW+D5E1Ai3Qs//OTOXLYoB4Vj2kgifasLNGvhoOLrFTZoGDVOVqTE5a6shQ+bu70sgISNyFDAYZaTcDRaaegiWa5SiVdOxhcQsQ//OSoE6aUdV8CPJpQYx8HyMj5PGlH8OJ0kFg4uG8BsUzC1Vkv+ucfQ3hy+mhIpARDAtA6CVaio0Edgey8bEE0YVRGJZua68WvabyVnbA2js7zweWuKbhkMSmMaaqClBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Mon, 14 Oct
 2024 12:53:12 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 12:53:12 +0000
Date: Mon, 14 Oct 2024 20:52:58 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Marco Elver <elver@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, "David
 Rientjes" <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, Alexander Potapenko <glider@google.com>,
	"Andrey Ryabinin" <ryabinin.a.a@gmail.com>, Dmitry Vyukov
	<dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
 <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
 <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CYYPR11MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be3400d-eb01-4783-933a-08dcec4f298c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HlQW5fHlm72XO2izmIrF9rlmp9IDSecWSlN2/qdsq81b8MfAb0gs6UVPieAU?=
 =?us-ascii?Q?tQZ+L9oO0YLhrzVcI8P7BngUZ3XBeDaaP7Bha4A/x95HHXMVPEeMq8ULFzLB?=
 =?us-ascii?Q?YSZbBtF0dbqYK5n6dg0dGe8Af3sVIbA9GraAznZOwZlNGNDbAB7OPsebgJ0G?=
 =?us-ascii?Q?Iraf8gn7iGhL1HQ/k3n89w2FUMCPugcrkfMozEioCP88NHYgyPIwc/z9W+7F?=
 =?us-ascii?Q?0F2f0aZK0KDe9K6GZmJ02MBpKV/6Krir+WhYSitwptteXFLPHJwJQjuKcoWT?=
 =?us-ascii?Q?ED8zcOGh3JSr0SG5PvwKV2ZIkcX8UjQbil6v/INsuAg0T/wQSBvkYA+lG5tZ?=
 =?us-ascii?Q?mCm2pX0zYhY4K4NHbSLl7z4EQ92b4xAROBCWSk5jQPCDUJmJnpT/DhPs1YqN?=
 =?us-ascii?Q?HKBR0Fhb+vvp2LalhLlmbShbjco7aGSHgV+tm57mi7EzrXvy5Us9V3HdyiVe?=
 =?us-ascii?Q?Fy5Fzk6DGvPLG2s9abRtLTQrjdqrYKDDwN654OD1X7nI9tEixFLYnFsAEfbD?=
 =?us-ascii?Q?nvYgabEwrj/lRr6ijOUr9hKuWAYWP+uH0jc2tHv9vMHztQcXdAfvOwYbEmQa?=
 =?us-ascii?Q?O/DkXRXH6DBl3OOTBuqIAgTADDEowhql5nNM1osELkBmPHXv+GaVN1BQkllA?=
 =?us-ascii?Q?AVd9DX/o4hKeEk8O3kmXRE0VWohoN+kU27ol/4F+3203NG6kEjBp2BtO7iXu?=
 =?us-ascii?Q?S5x2aheMCp2mJykzrt0VhMhLMF38QPMT13EVpSN/JoUOxOCsYrd5A/F48Clo?=
 =?us-ascii?Q?XMvsN4M8B+4/XTciYCXD86QR4xFmzj/mMyg/W7xpW6szp1PlMajI574r+ASp?=
 =?us-ascii?Q?WDEBP27fRxk7v+tvnxVJjbvSSXV2843sp9+ezQ4Gl2IJl96ClmE2d6TaoEjS?=
 =?us-ascii?Q?dqJFFXQtaX7MGyuWXQ+PxK4O/NTXwRhSo2FzuMtAmmWs2BQxqE2vGsCe73et?=
 =?us-ascii?Q?NS4ujVnTnVN6UVuRDWzqee+ZRgD0qsOwglJl4/FQw93Ii26e/jS8yn+r47qU?=
 =?us-ascii?Q?XpeUdBOG1Sedo69vvX3jsj+jie7Og3S64qfwUb52V75L6vRV29Tzsv/B4TI/?=
 =?us-ascii?Q?rdLTwlmDV0VtY/wrn2Dh56W2GbYl3vJ5Aum1KBjCxTQ08ZqsNsXdLuk5dgMV?=
 =?us-ascii?Q?TXW4iKHH4iuUY+hqMpr9GlDX5RF/rozRf6Fv18AV5FIdUoDhRbunMxcwwnbi?=
 =?us-ascii?Q?8XGnoBFdAsPNg3+5lvKJwQ2YA7ortF6l4dYfd12q5791CxJPLIs4N8K6k/il?=
 =?us-ascii?Q?qtB6N0oxZCuSrYoeFub3Q+bTam/3n1+oIeEstNMTZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NqynKHDT5KmKUty45UKXvTUW4PtZEk79FVDauY1ICDn36P3cXD5Xznod92he?=
 =?us-ascii?Q?0uTFSkqfCOT+yroaRdaDM0GufHAU+Po/lGMnz3CcSoSrO3Kb/xRDa1BGTxjH?=
 =?us-ascii?Q?RrsK/QfO1/HS6K9DUbuQZL9YhHeXZLSAcXLNpl4MCrBlwjqGJ85SYpNXd40O?=
 =?us-ascii?Q?jpS335zCdgk70jDRjTO9k3MNCwtOkVC2o/pcv5E2Da3xlJR9XLvwVIrf/0xe?=
 =?us-ascii?Q?lGQPv5N7kAwMWHGChiU3j4Y0IlO1AKVcjVRLdSBrXXnOMWcKH4GqrC1ncGcM?=
 =?us-ascii?Q?vnmZ8y3QhTLEk4mBGno8acJDozwKjhGmD1gHo9fGOYg0Fz+yDusdZEIUVIwU?=
 =?us-ascii?Q?ZGPC6YlsLvJMh5w4g/OmnqKgcsUTFJyq7wl912ug0+VU6UCdSPOY9Yf5Dn7+?=
 =?us-ascii?Q?UUxnpwlIu3hqcQbnk6M5Xtu/hgXv8ExoOxeNbA2SqFUiKcjMGhJOJU9VKQII?=
 =?us-ascii?Q?FAtTaBbB3jbvk0p2Jf+8Y0EYVgmzx1fwyt217Aciu1t5iIx4h9/5L1eTVLCu?=
 =?us-ascii?Q?6ijgE1hwDAMzzBZRUjswmPw3OFU6Fjw57adlzklLzWG/G62oAUvNVU4vH5FA?=
 =?us-ascii?Q?XhAf0OtXLO5ARLC4+vwP97UXi0mH7erLovzpX35bZuDKv9chfA9zhmS16xoK?=
 =?us-ascii?Q?RxKKnO54zSXe6wpQANi4NMU6Aqq7VUVVrhbX2dRkW2bncfDo336C4xjmiY/v?=
 =?us-ascii?Q?wyIbCNRHDTAJkMzsaA9+XyhxEB+sPcPzI0T7apBRtVY4at8umMNzDYXU6fYN?=
 =?us-ascii?Q?3u+rNdtfwbo0FF69uC13BBZX2km5LzkF3t2TYf5A12mlsdLSMY9PQYa00HkG?=
 =?us-ascii?Q?aXGBS87dECTrqJ/nS2nICbA1hBZ0+AqqhnX+8XBEQlEdTy9qUNUwH+RD3PR2?=
 =?us-ascii?Q?+vufXCWw6NiKd/W8Hp8H/Ei6bEUjGRh/4yX+UZJsLw9pO+hQtuLjF/hV+fE3?=
 =?us-ascii?Q?urmRBgWrQha51VNwS7lOSo7ZZ8yfTFM4Q7XEFRajYsvAtdKrwLON9zHeAqgY?=
 =?us-ascii?Q?brbtDsnVlxHJPjRLiH+cG/QzcfZ4+LkJScNTF3BQrusZVVI6bxCKuez1Ewwm?=
 =?us-ascii?Q?yyp6kdt4rq3Mdq2hqMhJGeKqImhE/7PVPqGk84mls3vNWO5W5YZwJ8zu0t8g?=
 =?us-ascii?Q?roausxitG8wi+PoVCmHkIlJI3CkmKXBfuUCD63OzfypCS33eqMaVE91s3Wup?=
 =?us-ascii?Q?y9afjCaSqpKVmWIY/92O4r5zXFaLspGefzvtvV3rkHyU54wQjOC2Kcu9MocZ?=
 =?us-ascii?Q?yGLdasBU2of8EqDA/OoAbjOWPWZgPb7xfH1I03OJhiQN7z0h8n4h2DTZQ/N8?=
 =?us-ascii?Q?OdFoseGRXXlWI3CGS9v8BwF4IjJq8KhxXPAFDL6whMNqoIJjBVZ0gBLjaxnX?=
 =?us-ascii?Q?SptmsxOrDPHtwyO4li5yHhRX+BnpA1D6pjF+wiJ0FySFFNhgjSC7WNlkApUp?=
 =?us-ascii?Q?3XpqarDAP6hKpqLVaPiis5Zib0puEv2SmEOF8VGA/vIjDU9SC/uzjWDMV//o?=
 =?us-ascii?Q?3D8/iaueEb1j9DBOAILDH9glnF5ZeG5toBY6rMh0Ss6YNn0PYNpu89fXDCVc?=
 =?us-ascii?Q?8OOhQHfDlmA8eEZPaqx3ONh3gAcqKOk/zCszAgEX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be3400d-eb01-4783-933a-08dcec4f298c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 12:53:12.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLt40vR+j3IgSoayyCwpZDc4Bh+esYIjsb296l5KmeeHopKsw8FC2mPXoIDX1KopvP+Dja5pJ8gq63Oxl/PnoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com

On Mon, Oct 14, 2024 at 10:53:32AM +0200, Vlastimil Babka wrote:
> On 10/14/24 09:52, Feng Tang wrote:
> > On Fri, Oct 04, 2024 at 05:52:10PM +0800, Vlastimil Babka wrote:
> > Thanks for the suggestion!
> > 
> > As there were error report about the NULL slab for big kmalloc object, how
> > about the following code for 
> > 
> > __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> > {
> > 	void *ret;
> > 	size_t ks = 0;
> > 	int orig_size = 0;
> > 	struct kmem_cache *s = NULL;
> > 
> > 	/* Check for double-free. */
> > 	if (likely(!ZERO_OR_NULL_PTR(p))) {
> > 		if (!kasan_check_byte(p))
> > 			return NULL;
> > 
> > 		ks = ksize(p);
> 
> I think this will result in __ksize() doing
>   skip_orig_size_check(folio_slab(folio)->slab_cache, object);
> and we don't want that?

I think that's fine. As later code will re-set the orig_size anyway.
 
> Also the checks below repeat some of the checks of ksize().

Yes, there is some redundancy, mostly the virt_to_slab() 

> So I think in __do_krealloc() we should do things manually to determine ks
> and not call ksize(). Just not break any of the cases ksize() handles
> (kfence, large kmalloc).

OK, originally I tried not to expose internals of __ksize(). Let me
try this way.

Thanks,
Feng

> 
> > 
> > 		/* Some objects have no orig_size, like big kmalloc case */
> > 		if (is_kfence_address(p)) {
> > 			orig_size = kfence_ksize(p);
> > 		} else if (virt_to_slab(p)) {
> > 			s = virt_to_cache(p);
> > 			orig_size = get_orig_size(s, (void *)p);
> > 		}
> > 	} else {
> > 		goto alloc_new;
> > 	}
> > 
> > 	/* If the object doesn't fit, allocate a bigger one */
> > 	if (new_size > ks)
> > 		goto alloc_new;
> > 
> > 	/* Zero out spare memory. */
> > 	if (want_init_on_alloc(flags)) {
> > 		kasan_disable_current();
> > 		if (orig_size && orig_size < new_size)
> > 			memset((void *)p + orig_size, 0, new_size - orig_size);
> > 		else
> > 			memset((void *)p + new_size, 0, ks - new_size);
> > 		kasan_enable_current();
> > 	}
> > 
> > 	/* Setup kmalloc redzone when needed */
> > 	if (s && slub_debug_orig_size(s) && !is_kfence_address(p)) {
> > 		set_orig_size(s, (void *)p, new_size);
> > 		if (s->flags & SLAB_RED_ZONE && new_size < ks)
> > 			memset_no_sanitize_memory((void *)p + new_size,
> > 						SLUB_RED_ACTIVE, ks - new_size);
> > 	}
> > 
> > 	p = kasan_krealloc((void *)p, new_size, flags);
> > 	return (void *)p;
> > 
> > alloc_new:
> > 	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
> > 	if (ret && p) {
> > 		/* Disable KASAN checks as the object's redzone is accessed. */
> > 		kasan_disable_current();
> > 		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
> > 		kasan_enable_current();
> > 	}
> > 
> > 	return ret;
> > }

