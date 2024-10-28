Return-Path: <linux-kernel+bounces-384209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB1E9B2864
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8075B20EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9D18FDB0;
	Mon, 28 Oct 2024 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3C2FPcG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5218FDA9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099173; cv=fail; b=jiOGODt7O52+E+r0yar9oqA56K5BVSbIgrFnwngmeNLCURzmSs/GpAem0RpesamgnS2+36WB1PU//8g8sISmVN5rJryytrJXzZYQFhTHZa53hayvqmsOdF1gwChaSsWcwBL751kxl46owHW8Y0UPvODGAW0+DZelqH38zZL9QWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099173; c=relaxed/simple;
	bh=h112HRr99iM5BCK3XKaAUnobuHlocPXMNaMcW+DFA68=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uVNaP4dgol6crqqH41gumWsSTv9DeF3omaQrey0ZzCoWSaVa9A5Ekw0LPfzfvmqJrU5F0YQEkmlN21f7FdupjQPBYYcwHSrWNqU3eThXtXX2MYpFBrUcjMVitT/kXaaP8vUbhdEyRtmNw9D+WQEopFxgpGxwpysRD+z2b2jM0uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3C2FPcG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730099171; x=1761635171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h112HRr99iM5BCK3XKaAUnobuHlocPXMNaMcW+DFA68=;
  b=f3C2FPcGv4gJe4uyuwY6Z14wEJiYOWEqOxG4atVVwCpRAAHeKD4AISDf
   1zsFtPcP/x7iam34SY0CBmoT+tpF+59OewNm4jp/trPCvt2RdrSdFEuiK
   UCHsB/X6OHJbib4/V9AaPbD2wwhXVrDrQTmkOwGEoZ5zgFDQnroRS6rO6
   IS2HKXKVa/GebEv4ulZocI10bl2TJ1fYlTBwhNzr70/BKQvUIb+PPLTmk
   JK7VNDKamrukBUpGMLDf18IHnItW2chH8DFJw0g2mnyX0g45IASPyM7Km
   yf4crLpB7Xn46yFxq2bV6YymN3BMp+E6BbHra8N3cEr0/1Sft8TnDgjkq
   A==;
X-CSE-ConnectionGUID: RH2EyGpCRZ+kmzZ9kr6v7w==
X-CSE-MsgGUID: yAebtbJqT7ii/qcoiMLnJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40306119"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40306119"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:06:02 -0700
X-CSE-ConnectionGUID: FhpKdZdUTvOMd2afElyQhQ==
X-CSE-MsgGUID: ti9Y/IumRjac8+c8zROxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86671096"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 00:06:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 00:06:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 00:06:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 00:06:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5vVdXSBBQCnCrGQjTTiAFdaVm6BUL94MP4NWk+PqLPEc8vMi2K1IOq1aU0LP9bLur+RDlC9lA6eyfFikxHB/zQhCWd+jpjQSJKZMq6LfclGySOQferRCY3ON/mXwjiGlokgVfFskGpJ+GKuk4nvCZrwDtis502Zou3lKgjX3i6iiYtNOIzKcMB7IJpJ0NQ+gdVupXcICcyY2tjtTGFOUnFf3XEhyBNTEMTcwfNVSyj34TbUxUmABrC1oh0jPSdlOfDIk8O/nMkPfTmgUtlPahp3JXSHWkB7u9zMLsd5i5ueslK4eV9JdM54hExA/whWNUajqT6Wk1EYIF9UNwjBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dcPHd92mDBxzsMDUPbq1Ug+lLeVCMAcb4UZ8xjVlVc=;
 b=qtlm9etLd3VWnEwSMGDf94vw6zNzk/z/pm5hKsA1InQpoAltQgQAXz/z3tbdtBuN3au6/aEINeyO2jluktzQ8K3vgDwFccS7+6tGND1KYvwCbhOrwY0OfXHJOKKgKovgVRLYkU2YG+O/L5a4elk4soJfle5JHoBDx73WtqJoaAiTZs6OEpMD6obsrhcIuEVpPq7EjBs6dWhCxpakmQ7rSQgeUfFRovuJeauuaVHdCNOmB/u0OIIos4rWr1ljQcCA4mykh2mvnfTa/sdn0bYPlGvsO3nKInbm8eIUjTOZmrzTevVKxAvPLtXPDdqqLmRs+G1u7qyggS0TcYiMTUujhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB8131.namprd11.prod.outlook.com (2603:10b6:8:190::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 07:05:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 07:05:53 +0000
Date: Mon, 28 Oct 2024 15:05:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov
	<bp@alien8.de>, Christoph Hellwig <hch@infradead.org>, Daniel Gomez
	<da.gomez@samsung.com>, David Hildenbrand <david@redhat.com>, Davidlohr Bueso
	<dave@stgolabs.net>, David Rientjes <rientjes@google.com>, Dennis Zhou
	<dennis@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, John Hubbard
	<jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Kalesh Singh <kaleshsingh@google.com>, Kees Cook
	<keescook@chromium.org>, Kent Overstreet <kent.overstreet@linux.dev>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Mike
 Rapoport" <rppt@kernel.org>, Minchan Kim <minchan@google.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, Sami Tolvanen
	<samitolvanen@google.com>, Sourav Panda <souravpanda@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas
 Huth <thuth@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka
	<vbabka@suse.cz>, Xiongwei Song <xiongwei.song@windriver.com>, Yu Zhao
	<yuzhao@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [alloc_tag]  a9c60bb0d0:
 BUG:KASAN:vmalloc-out-of-bounds_in_load_module
Message-ID: <202410281441.216670ac-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 358bc94b-3036-4c8e-ee39-08dcf71ef613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HW9Pyi47wMK3CLZzEsK2r77QUTa1M6by0HM7+u82vb9iZD7DdzMTsJ6SLEgL?=
 =?us-ascii?Q?ISKkvwkOwTrmkiBwXYzJhUjfAtglmUIngD8hgrQHcnjS0uxQUw7suuYje4dm?=
 =?us-ascii?Q?yb2QdBw+VI40n2Vm+zh9RZtM+2fRTSwLF9UqG9UiNmUZ6w/o9kCykHO0rRGT?=
 =?us-ascii?Q?7We8U6DVu8sxOOdC6PtgxV43leRGPG0/DQqIWax49E5k+ZTTYFeKes1drSIe?=
 =?us-ascii?Q?ZNuyUftLy/SnPVVAzYsStnAPtvmeETNsLeaKoRctPb3YJfubhGC6Tfv8DiBF?=
 =?us-ascii?Q?sbUHY957JuotofTAfiuZcfDoIwAGFNmM8pyIcHb0w6iC+GvRuA0PZqKU1kPS?=
 =?us-ascii?Q?7YCynf2Km7TMkqVYmMR58T83UqlwUTlRe+tWFoShbOBYXKv8hptUHpQIltOn?=
 =?us-ascii?Q?lHqN9Qr6hZCumpxHqYQp/4VMAEjcf2CbC7jST8GPXN9zFtXmukjsV6WRN9Cm?=
 =?us-ascii?Q?2GoPBCQqiIdZTxoMX4oHMNloKlI2lgBwf/1v16h8pE4018wymj57sLZaQPdW?=
 =?us-ascii?Q?sk9POHEuRDCqmqpXSI+QrX80LBsaiZb5c6YdGVp4OvwskLTTgePuxYhrN0Hb?=
 =?us-ascii?Q?ZU+V4+2W8dOp0VuE+9sChsyXpNsX+bpdp5b4JscSQvGatUIia6bqspRjNskJ?=
 =?us-ascii?Q?hblUatRbzg+Ac6xfpJUTjy2Wr3C1hOiYLZlHKes9zltI24n+dbHwp03EUsGU?=
 =?us-ascii?Q?GqO9m0/2GpPVvHolHVKFeNPabmBwrH1DzF/F9rN3FS0KUCJi2lhkDUg5kvLF?=
 =?us-ascii?Q?87zAJehuK6mPYtAHtM2711rikRmTm7d4Uk3YHAWEYZJ/M6iL1ovuZkCPZiUv?=
 =?us-ascii?Q?OYoCwB2juqXjil2RdgOqQm+KhK/a0pZAv8pESOo6TocDcLJCHywqlVd++jw2?=
 =?us-ascii?Q?tl4G+qrCMdPYyejWvkDNt31RBAJaZ4KRItuLKQ4bJTT5QTnB6FdVQF3VQpoq?=
 =?us-ascii?Q?bdXwHNAqCjtJQNzbFU7GL/KOt/bFgtG8zg3H5Y6IL5fhHrbYgTjkIh6a1tC4?=
 =?us-ascii?Q?t8eS36F+ENomc1UcKG1ZpqOtE079/8ZjjOnegjsoYMtKmZCp7LnJzebshDOK?=
 =?us-ascii?Q?ODfjPb9UjGwXNoTeLKiQnoOSYPsOCminYB4uKMKa8l/YMS55QmthFwbXKWgf?=
 =?us-ascii?Q?tZ2RP8vke4gVK0IxssnqBtwtxcQ5yXEu66Bkwto3OOjju4GRQ4kkaWYj5g+H?=
 =?us-ascii?Q?7dqUJ+uQJvDm7mL4fVjIPctTRvlLkQ2+3fOzfuBLtl1KhdK8kHeLIj0FFheh?=
 =?us-ascii?Q?RIse192ojhH6lwKAoSq9hjxF9hgYFF5m3r775GqzFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j5V0H/+U+Ud+isYUXTA6uQCj0Go9eBG/7I/VWHQGDV898CadfsWbabKj9hlR?=
 =?us-ascii?Q?Xy7TOSpdqfUddQ7R5MlN2dyC9krlYGUq+LL5C6RUumV5r82AjIlNxV20kL/U?=
 =?us-ascii?Q?IRJe4NOB3o+o5hTqzkNkADdqBVviTmsNLKZUNBclzKKGBdETe5mHdMkNIepz?=
 =?us-ascii?Q?1KoxcIkftfkRhTILU/v7FTD5ZfawKxED86TFO7z8FYlWLGihDR940A4xrcfD?=
 =?us-ascii?Q?V9Q/vYTIa3Noc9F2A7xhaLZwfU5cAlPbmdrXsshwILBfh68fxP2y8gYqGz1N?=
 =?us-ascii?Q?s9Nr1318vSc2wTSft5Rsp8FCQK8HDrYSiAY3Hiuls89MzaThpsuCroiSeyRa?=
 =?us-ascii?Q?c7/b98bNj12rG4ZDoZwN1feRJpOCKBbUWSIAUZmcpFigtMu3koubrpww90O+?=
 =?us-ascii?Q?J2C4XzPnWXlKPVflkb91QqqXgm8AiGJWsa7ClRTtV09GsgmIiPY6hxcZDLeF?=
 =?us-ascii?Q?ZaH9oFQPRNbBicmpYzJiYnvoRMAJr6B2T8nkaj8iTK/p8mc2vXVpHP0gnGTb?=
 =?us-ascii?Q?ekNOiFoMorMmhLG5Y9iM62aQHMUa/lbVv/NzZH5u6LModokOGDxz16A6Rchy?=
 =?us-ascii?Q?y90Jbl86ahrJAttbMpFaZjXQ3atjTRsyr0a7FxsoJOOJYuvhhY+wnc5NTE/U?=
 =?us-ascii?Q?Yg3I8LeZtHjUJ5Oq9zXdMepo6+7xBU/ZDTWWdhcQxVg9eabDL3cZMU7WyIM4?=
 =?us-ascii?Q?leyia/7UPwASEmRGuYqhTKSSp8Jl7QwNQefm7nx2+hPHuJaxB3MsbNPtDyMU?=
 =?us-ascii?Q?cQ4jmdFBURUxvVyfaHRZuCTE5g+kg1248PlzymXSTuHCftW+CmqTxkJ0GRkc?=
 =?us-ascii?Q?YVrthzJ0rWTvsj4gtIYFsQKYduMDTNjJ0xL7X73zHraUh3RtkUUhw6c13cso?=
 =?us-ascii?Q?DQD0y/zNEwZ04ou6Hn9vKjP48Vlz1N+rrx67QfuKz0tExzNiXRfMhqg7Lr0i?=
 =?us-ascii?Q?QT63nawZOxhQxpyT5zemmWewz3zOeOdPdsZ26A+zeZM6L0/jBOiktB0NA58Z?=
 =?us-ascii?Q?wvAw/KWOUzOiI16JFFPHP+4HNydwzlkSYj8JVHQGtAAdRRRnbO7T+Kq871JF?=
 =?us-ascii?Q?R3WzMB3t1/A3/ABcdyI1PSwTN2Nsfg4oszvB0wCBXEpWcbb0KrrdD56lX2KC?=
 =?us-ascii?Q?2TIf22N4FW3hq0xPk5v7m8Gx7ItZLm0G7cq0bil6d1+BWp8EVx+Kf5SFc+wb?=
 =?us-ascii?Q?Z3IBWYquST34Vyyfi1yPACtPY0Uazb+08jWer0P44RSU7TZdrnhfMZ+eKEuy?=
 =?us-ascii?Q?tToyEOOUjm3/ZOeq9OuMyw7b3AhRPA8ZWpcTimtpEexTReuUyjfwFFssc47J?=
 =?us-ascii?Q?2ZH3hrqbt1VNzJb07rWX/nW3/4Vxj31v+Ln6PdsgcREdbp/5wB376pNdBBE8?=
 =?us-ascii?Q?0b1WlMPV+D2+KAgvzaDRENOUfv9GOJ3xAoH9X6Jmed+JAXZ2lgywsXeFob68?=
 =?us-ascii?Q?XEmdUnR9BDAN3kXZO1q9dsPTKuPuaFbs1jHIRejAU0dq7LcVr6wY4ByRtgi6?=
 =?us-ascii?Q?myFZfmf/f85YtOffRBZyvQN16LyQaJLHZWeYievrwHmpYoxfAAslfEOy4GIR?=
 =?us-ascii?Q?diKxukzo4NWf0lhrDFEiHS6sqGPpZQ8qPznjwmG33p7TzkB6EV/DySs94LQE?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 358bc94b-3036-4c8e-ee39-08dcf71ef613
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:05:53.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcWgsEOqZWEuUS5DbPWjNeJb3bRVLMCjB7hyK0khO9cY5FF2Pt0s1giRPO+IKYCEqYbtqCTzgKt4zcfsRDslNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8131
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:vmalloc-out-of-bounds_in_load_module" on:

commit: a9c60bb0d0e58ca30b8bfd00bddbe5bf79bd120c ("alloc_tag: populate memory for module tags as needed")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a39230ecf6b3057f5897bc4744a790070cfbe7a8]

in testcase: boot

config: x86_64-randconfig-016-20241026
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | e88dfe467a | a9c60bb0d0 |
+------------------------------------------------+------------+------------+
| boot_successes                                 | 6          | 0          |
| boot_failures                                  | 0          | 6          |
| BUG:KASAN:vmalloc-out-of-bounds_in_load_module | 0          | 6          |
| BUG:unable_to_handle_page_fault_for_address    | 0          | 6          |
| Oops                                           | 0          | 6          |
| RIP:kasan_metadata_fetch_row                   | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 6          |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410281441.216670ac-lkp@intel.com


[ 42.810547][ T114] BUG: KASAN: vmalloc-out-of-bounds in load_module (kernel/module/main.c:2353)
[   42.811473][  T114] Write of size 520 at addr ffffffffa0000000 by task modprobe/114
[   42.812394][  T114]
[   42.812758][  T114] CPU: 0 UID: 0 PID: 114 Comm: modprobe Tainted: G                T  6.12.0-rc4-00199-ga9c60bb0d0e5 #1 18071a02e852b21a65d5fedadb69938108f9c3ec
[   42.814382][  T114] Tainted: [T]=RANDSTRUCT
[   42.814943][  T114] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   42.816126][  T114] Call Trace:
[   42.816599][  T114]  <TASK>
[ 42.817020][ T114] dump_stack_lvl (lib/dump_stack.c:122)
[ 42.817627][ T114] print_report (mm/kasan/report.c:378)
[ 42.818207][ T114] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107)
[ 42.818822][ T114] ? __virt_addr_valid (arch/x86/mm/physaddr.c:?)
[ 42.819469][ T114] ? kasan_addr_to_slab (mm/kasan/common.c:37)
[ 42.823016][ T114] kasan_report (mm/kasan/report.c:603)
[ 42.823612][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.824202][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.824819][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.825390][ T114] kasan_check_range (mm/kasan/generic.c:?)
[ 42.825997][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.826578][ T114] __asan_memcpy (mm/kasan/shadow.c:105)
[ 42.827149][ T114] load_module (kernel/module/main.c:2353)
[ 42.827719][ T114] __se_sys_finit_module (kernel/module/main.c:? kernel/module/main.c:3298 kernel/module/main.c:3325 kernel/module/main.c:3308)
[ 42.828345][ T114] __ia32_sys_finit_module (kernel/module/main.c:3308)
[ 42.828988][ T114] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-016-20241026/./arch/x86/include/generated/asm/syscalls_32.h:463)
[ 42.829614][ T114] __do_fast_syscall_32 (arch/x86/entry/common.c:?)
[ 42.830291][ T114] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234)
[ 42.830316][ T114] do_fast_syscall_32 (arch/x86/entry/common.c:411)
[ 42.830334][ T114] do_SYSENTER_32 (arch/x86/entry/common.c:449)
[ 42.830349][ T114] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127)
[   42.830370][  T114] RIP: 0023:0xf7f77539
[ 42.830381][ T114] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
All code
========
   0:   03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
   4:   10 07                   adc    %al,(%rdi)
   6:   03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
   a:   10 08                   adc    %cl,(%rax)
   c:   03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
        ...
  20:   00 51 52                add    %dl,0x52(%rcx)
  23:   55                      push   %rbp
  24:*  89 e5                   mov    %esp,%ebp                <-- trapping instruction
  26:   0f 34                   sysenter
  28:   cd 80                   int    $0x80
  2a:   5d                      pop    %rbp
  2b:   5a                      pop    %rdx
  2c:   59                      pop    %rcx
  2d:   c3                      ret
  2e:   90                      nop
  2f:   90                      nop
  30:   90                      nop
  31:   90                      nop
  32:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
  39:   00 00 00
  3c:   0f                      .byte 0xf
  3d:   1f                      (bad)
  3e:   44                      rex.R
        ...

Code starting with the faulting instruction
===========================================
   0:   5d                      pop    %rbp
   1:   5a                      pop    %rdx
   2:   59                      pop    %rcx
   3:   c3                      ret
   4:   90                      nop
   5:   90                      nop
   6:   90                      nop
   7:   90                      nop
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   0f                      .byte 0xf
  13:   1f                      (bad)
  14:   44                      rex.R
        ...
[   42.830390][  T114] RSP: 002b:00000000ff9f932c EFLAGS: 00200292 ORIG_RAX: 000000000000015e
[   42.830406][  T114] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000565d4214
[   42.830415][  T114] RDX: 0000000000000000 RSI: 00000000565e7420 RDI: 00000000565e7090
[   42.830424][  T114] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   42.830433][  T114] R10: 0000000000000000 R11: 0000000000200246 R12: 0000000000000000
[   42.830442][  T114] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   42.830455][  T114]  </TASK>
[   42.830461][  T114]
[   42.830464][  T114] Memory state around the buggy address:
[   42.830478][  T114] BUG: unable to handle page fault for address: fffffbfff3ffffe0
[   42.830485][  T114] #PF: supervisor read access in kernel mode
[   42.830492][  T114] #PF: error_code(0x0000) - not-present page
[   42.830500][  T114] PGD 417fd7067 P4D 417fd7067 PUD 417fd3067 PMD 0
[   42.830522][  T114] Oops: Oops: 0000 [#1] SMP KASAN
[   42.830536][  T114] CPU: 0 UID: 0 PID: 114 Comm: modprobe Tainted: G                T  6.12.0-rc4-00199-ga9c60bb0d0e5 #1 18071a02e852b21a65d5fedadb69938108f9c3ec
[   42.830555][  T114] Tainted: [T]=RANDSTRUCT
[   42.830560][  T114] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 42.830568][ T114] RIP: 0010:kasan_metadata_fetch_row (mm/kasan/report_generic.c:186)
[ 42.830586][ T114] Code: 86 e9 e8 fd ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 66 0f 1f 00 55 48 89 e5 48 c1 ee 03 48 b8 00 00 00 00 00 fc ff df <48> 8b 0c 06 48 8b 44 06 08 48 89 47 08 48 89 0f 5d 31 c0 31 c9 31
All code
========
   0:   86 e9                   xchg   %ch,%cl
   2:   e8 fd ff ff 66          call   0x67000004
   7:   2e 0f 1f 84 00 00 00    cs nopl 0x0(%rax,%rax,1)
   e:   00 00
  10:   0f 1f 40 00             nopl   0x0(%rax)
  14:   66 0f 1f 00             nopw   (%rax)
  18:   55                      push   %rbp
  19:   48 89 e5                mov    %rsp,%rbp
  1c:   48 c1 ee 03             shr    $0x3,%rsi
  20:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
  27:   fc ff df
  2a:*  48 8b 0c 06             mov    (%rsi,%rax,1),%rcx               <-- trapping instruction
  2e:   48 8b 44 06 08          mov    0x8(%rsi,%rax,1),%rax
  33:   48 89 47 08             mov    %rax,0x8(%rdi)
  37:   48 89 0f                mov    %rcx,(%rdi)
  3a:   5d                      pop    %rbp
  3b:   31 c0                   xor    %eax,%eax
  3d:   31 c9                   xor    %ecx,%ecx
  3f:   31                      .byte 0x31

Code starting with the faulting instruction
===========================================
   0:   48 8b 0c 06             mov    (%rsi,%rax,1),%rcx
   4:   48 8b 44 06 08          mov    0x8(%rsi,%rax,1),%rax
   9:   48 89 47 08             mov    %rax,0x8(%rdi)
   d:   48 89 0f                mov    %rcx,(%rdi)
  10:   5d                      pop    %rbp
  11:   31 c0                   xor    %eax,%eax
  13:   31 c9                   xor    %ecx,%ecx
  15:   31                      .byte 0x31
[   42.830596][  T114] RSP: 0018:ffffc90002107a60 EFLAGS: 00210802
[   42.830607][  T114] RAX: dffffc0000000000 RBX: ffffffffa0000000 RCX: 0000000000000000
[   42.830617][  T114] RDX: 0000000000000000 RSI: 1ffffffff3ffffe0 RDI: ffffc90002107aa0
[   42.830625][  T114] RBP: ffffc90002107a60 R08: 0000000000000000 R09: 0000000000000000
[   42.830634][  T114] R10: 0000000000000000 R11: 0000000000000000 R12: aaaaaaaaaaaaaaaa
[   42.830643][  T114] R13: ffffffffa0000000 R14: ffffc90002107aa0 R15: ffffffff9fffff00
[   42.830653][  T114] FS:  0000000000000000(0000) GS:ffff8883aee00000(0063) knlGS:00000000f7a65700
[   42.830664][  T114] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   42.830674][  T114] CR2: fffffbfff3ffffe0 CR3: 0000000195e7b000 CR4: 00000000000406b0
[   42.830689][  T114] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.830698][  T114] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.830707][  T114] Call Trace:
[   42.830711][  T114]  <TASK>
[ 42.830716][ T114] ? __die_body (arch/x86/kernel/dumpstack.c:421)
[ 42.830736][ T114] ? __die (arch/x86/kernel/dumpstack.c:434)
[ 42.830753][ T114] ? page_fault_oops (arch/x86/mm/fault.c:711)
[ 42.830770][ T114] ? number (lib/vsprintf.c:574)
[ 42.830788][ T114] ? kernelmode_fixup_or_oops (arch/x86/mm/fault.c:739)
[ 42.830801][ T114] ? __bad_area_nosemaphore (arch/x86/mm/fault.c:793)
[ 42.830817][ T114] ? bad_area_nosemaphore (arch/x86/mm/fault.c:835)
[ 42.830829][ T114] ? do_kern_addr_fault (arch/x86/mm/fault.c:1199)
[ 42.830843][ T114] ? exc_page_fault (arch/x86/mm/fault.c:1480)
[ 42.830860][ T114] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
[ 42.830878][ T114] ? kasan_metadata_fetch_row (mm/kasan/report_generic.c:186)
[ 42.830892][ T114] print_report (mm/kasan/report.c:466)
[ 42.830903][ T114] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107)
[ 42.830917][ T114] ? kasan_addr_to_slab (mm/kasan/common.c:37)
[ 42.830928][ T114] kasan_report (mm/kasan/report.c:603)
[ 42.830939][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.830956][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.830968][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.830979][ T114] kasan_check_range (mm/kasan/generic.c:?)
[ 42.830991][ T114] ? load_module (kernel/module/main.c:2353)
[ 42.831003][ T114] __asan_memcpy (mm/kasan/shadow.c:105)
[ 42.831017][ T114] load_module (kernel/module/main.c:2353)
[ 42.831035][ T114] __se_sys_finit_module (kernel/module/main.c:? kernel/module/main.c:3298 kernel/module/main.c:3325 kernel/module/main.c:3308)
[ 42.831054][ T114] __ia32_sys_finit_module (kernel/module/main.c:3308)
[ 42.831067][ T114] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-016-20241026/./arch/x86/include/generated/asm/syscalls_32.h:463)
[ 42.831084][ T114] __do_fast_syscall_32 (arch/x86/entry/common.c:?)
[ 42.831100][ T114] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234)
[ 42.831121][ T114] do_fast_syscall_32 (arch/x86/entry/common.c:411)
[ 42.831137][ T114] do_SYSENTER_32 (arch/x86/entry/common.c:449)
[ 42.831150][ T114] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127)
[   42.831167][  T114] RIP: 0023:0xf7f77539
[ 42.831177][ T114] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
All code
========
   0:   03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
   4:   10 07                   adc    %al,(%rdi)
   6:   03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
   a:   10 08                   adc    %cl,(%rax)
   c:   03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
        ...
  20:   00 51 52                add    %dl,0x52(%rcx)
  23:   55                      push   %rbp
  24:*  89 e5                   mov    %esp,%ebp                <-- trapping instruction
  26:   0f 34                   sysenter
  28:   cd 80                   int    $0x80
  2a:   5d                      pop    %rbp
  2b:   5a                      pop    %rdx
  2c:   59                      pop    %rcx
  2d:   c3                      ret
  2e:   90                      nop
  2f:   90                      nop
  30:   90                      nop
  31:   90                      nop
  32:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
  39:   00 00 00
  3c:   0f                      .byte 0xf
  3d:   1f                      (bad)
  3e:   44                      rex.R
        ...

Code starting with the faulting instruction
===========================================
   0:   5d                      pop    %rbp
   1:   5a                      pop    %rdx
   2:   59                      pop    %rcx
   3:   c3                      ret
   4:   90                      nop
   5:   90                      nop
   6:   90                      nop
   7:   90                      nop
   8:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   f:   00 00 00
  12:   0f                      .byte 0xf
  13:   1f                      (bad)
  14:   44                      rex.R


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241028/202410281441.216670ac-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


