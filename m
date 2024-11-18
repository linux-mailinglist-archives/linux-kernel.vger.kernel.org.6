Return-Path: <linux-kernel+bounces-413442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D515F9D1922
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EF9B222C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273741E5714;
	Mon, 18 Nov 2024 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWJosW00"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40171E1312;
	Mon, 18 Nov 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959039; cv=fail; b=fxOyvBCCMfkDiQKBbLght5E+rq65WY5TMf5N2gkkn8stUrGX3L7SJ6qNrweRYE6wn/O9ggxugxvaAnFM7V2bp0HIQeIFADyvigyeb32aLVZI+Xb6PYziNcrwbcwC54lIIau+reGagAauuckx9s6hVQMOPTYrBGXIqfjFnuUib8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959039; c=relaxed/simple;
	bh=rhopoSRr7mdoHtbBnXYSel5s/XmlJBtdbsviqMuEtV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m4mLeC0ae4JGsxg6/OhERtPg+66TpvNPGmOx0UDhRbyLUB3AQ79U3qF+f2dobWgupITHxc2RkpfdmZWddVJnkEVm4TaV6OFQr2ZU95CUSn+aE4b/rorsJdXttctoO6uPGFNXuCNFURfswBweSfzyO5ur/NELprV6nJAaks0kyvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWJosW00; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731959036; x=1763495036;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhopoSRr7mdoHtbBnXYSel5s/XmlJBtdbsviqMuEtV0=;
  b=FWJosW00PtrmKcgYPOFxmEgkrV89mnIYXXgRdmQirG0UIiJEzbCAzqoi
   12UdHNPU9+hSO7cNBwdGrh+zcVImhP8d3nOYTz+8XFypSCWeyeQ04ehzZ
   LkL9ZdfrUswuX2a7zqvNxJxlN4pVYZOhnqZsJGmRakuEyFsz0kXx0JO82
   i5crE7jZrySvm78YkK5W5fK0WZOTLO1A79vodsLG9Ypq5R+0IMghDVSaB
   cGSlCSo799WWoiDb227uRNceMysQ+UYmbbbFkXetC+VxVtrrg/eEco6Ka
   LVS6eB3F0myHVevzAI2Apb1PYRuYqIys/3+pIkLOqDLWSZK9Tnf30Icfi
   Q==;
X-CSE-ConnectionGUID: hH51KL2kQsivfUnS+b88nA==
X-CSE-MsgGUID: R4C8ZWvJTb24DMfZ9RBnDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31858264"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31858264"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 11:43:56 -0800
X-CSE-ConnectionGUID: eMgBxAiLT1yz8NluwOT91A==
X-CSE-MsgGUID: cT6dSr/zS2m/2214qAE6jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="120267726"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 11:43:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 11:43:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 11:43:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 11:43:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFcUJ8T1thDdd0eZ3AeYghpRZ3P6QObTKjii7hK+P2QBje3JW22qz74UaQuzNBTahqHeNH6X3JoloHUqbYKv63SdO1KUVmY/OwPrzOTLV2hLfJOGGV9FFEzVIhsj9Kcif+Zn4HfBiSXDflBJOE/nnBis/Q8G78ruVfR3T6FL0sv2yQ3Rqi6N7eRGKNNlGdv8xOx+EgvFdrya8+Btc/nCZy4/z/szkMEpi7zRS2r5R772Ry71wKidvCOp7k1Ga6A2fMm2ox5x4LF/EDNTXYyAWtSPEEUUbgKs1v09ExctZVvuX/evm+ZV3kKt8iA6d3pJa9LwepJfOQEHvGYrNc7R+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hzaKrS8P6hXvfL72B5XHEe3sDNuSR8N+1znBSbakx8=;
 b=BFhtxsK6zkcNgN2PQFTKgsFr+ZyjDdeHTUtHhDR4jC67+VXMQbAppG8zwiD7PoNpWFSswa2p6ItvkoxmdwfhCeZZlR2jjOotgzX7sOfRe0VJgKkwQL9pJEsqFT7zIJ8Jy9By3zyADXA5moIJxFhIqsi3T4NEPBMdQ3rEJS+HY9HETbVFar+XcbNPKR0UusYLaTyKOpr8W1FB0XQHvcF5gBOpS4G+TbdB//TwwM0EKXU/zVwRwNGN1m6dd8SJiVCP6zucReNH7cYEKAzZYOr+dPQd4rPF/sDd7ff4DvhqDTWPSehnwEot5RC0ZxMD6VF48jQHO+2RvkEILofUyzY0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 19:43:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 19:43:51 +0000
Message-ID: <b78a01b4-3583-4689-a894-96dab5dfb9fd@intel.com>
Date: Mon, 18 Nov 2024 11:43:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 24/26] x86/resctrl: Update assignments on event
 configuration changes
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <89e98891f50d1d57c1cf8bc18c1f562ac58d2cce.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <89e98891f50d1d57c1cf8bc18c1f562ac58d2cce.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:303:dc::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: 772175be-704d-45cd-4e79-08dd080953cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1hsbmVFRS9hb1VtQlNreHh2VVlKNll0YU9VUU9YcG95aTc3eDZTcndsdVh0?=
 =?utf-8?B?RmM1TmtPQ3ZqR3h6d0hqNFBON1k3T2hGV1ZWdFloWlFXdGZKR2QwTzcrbSth?=
 =?utf-8?B?SjZPUytudTM2ZWY5czhIQmVrVFBQbE5Eb2Z3aHdRTTh2ckgzZStIU0pXQ1dt?=
 =?utf-8?B?Yy82aUZmWnN4dXY5dTdtT01IUXJIaWVaKzNCYVptd3J0QUNoM2JMTjlrZVRW?=
 =?utf-8?B?ODZpLzdCak9MeE02M29ZSmJoNVNDQmtoVGdVeCtBWDhqcE9YOHdGSWVUY3dn?=
 =?utf-8?B?c0dKVHQ3TDRlaUdxdE1LUGFTNVNJeVJxSWk5NzRVNzlJdERZNlBYY0ZnOVlK?=
 =?utf-8?B?bmdhbk90OC9mbkEzWnJsOXJBT1g0d0NxN3g3S3VDNmVodmVTVHorNGs4bm4z?=
 =?utf-8?B?Q3c4b2Mwa2E3ZGFYMDYxQ1BtZHVZbHExT2N4SGJYa01UeEtVRUVWMmMyZ3Zj?=
 =?utf-8?B?SHU3V3pkWi9zMDY5ZkpjejQxanVEdDlhZTFITHdRRkJDUHBrRW14Z05hRWZF?=
 =?utf-8?B?T0Q2VFlqcDVjZzBKY29QdWhDWnlPOEk4NUFyMXB4RWFaYWppZkkrZmtaSkpD?=
 =?utf-8?B?bWVqZERPNlExUnFFcGtZR3A0Z0U4RmwyQXFtQitlWDREeVA1RUpxZCthQnBr?=
 =?utf-8?B?WENDMVozRk5jeWc0cE4vS1QxQlcxSWxRaUtjdUdJQU55L29ocWJIblhkT0dn?=
 =?utf-8?B?TDFKTlZQVFU4bGF4bmdOaENEeFB2cTB5ZVdzM3ozOFJFc2ZNRTFTYkV0V0Zk?=
 =?utf-8?B?c2JrVCs1K0J5bGVNR05DR0tTNjVhbE8xVVdzT0dzUDl6ZnlPVDVYOGppSnNJ?=
 =?utf-8?B?L2ExYmZWNDB3RnJXY0w5RmNoaG9SbDYzNDR1OVNlYmZ4ZkFzbFJpSHJha3VI?=
 =?utf-8?B?dVZEOTZGUzl1UzBBSWo2ZlMzaHZNWVphaExaZjNYQ1owdVhOVS9ub29aa3VZ?=
 =?utf-8?B?bnI2NjFoeVltT2hZTGtuOXBucVpwTjU4a0FNcXJNcHd6TTNqZk9HaVkvZmF6?=
 =?utf-8?B?dUdPekllcXJCUllKL2djblNuWHBPUXMvMHlleU5NSCtoa2JCeTlnZmxVUk53?=
 =?utf-8?B?MGdpN2lpL2dzV2lUODdxcjNrVXlsdC9SOXZqU082OU02UzdMOTB0SFk3RzlP?=
 =?utf-8?B?bVg1VzBiR0ZTZnJsWFkrZGQ0TkRtbHZyZzBvMnV0UVpNRTEvaXQweG1zTTI1?=
 =?utf-8?B?ZUJHWmo2MXFwQk16NXB2aGExM24zbmtEUE9rTVNhN3o1UlFNdWNwTlA4Wlll?=
 =?utf-8?B?UUhmN2VUVXRFTjNnd0h0andIM2xldW1nd2hFY1dJMGR5UzBoaTNuNGh5d2cz?=
 =?utf-8?B?RXlHblNSTXdDMDZJZTYyMkFsMEs2YmRwMkNVSEFyZmxoZE0xVDhjMHdicnFT?=
 =?utf-8?B?azBnZWR0Sm9kQlN0VUNXZW5TdlRiRWg2WEpXbmdoZzhQd3p1TnM5clFpZDgy?=
 =?utf-8?B?YXh6VWJsckIzZ0pNMGVzdy8vVWk1aDlDKytNbXlRM2QvS1A2emRCUWtRck1D?=
 =?utf-8?B?eDNrRms3SnAyVk1zelVyOWszRE1CQnFzUm51SlpGQlVrQWk0VFhrbEJHSlpk?=
 =?utf-8?B?bk1Kc3B2bjhoekRGUmNBTWdiTkdpK0Z5TjREL2FEcjVnd3NSRmFxeUlYbXdw?=
 =?utf-8?B?eTlhN09ncU9Xa0R0Y20yUEhKb3h6MzBVN0pybXppc3d3aEdveklEWUl5SExN?=
 =?utf-8?B?QzlHQm5CM0h4VlYyY1FDV2w4RVpGbStPcWF3UGVpY3NYdWtHR1NuazhPZFIz?=
 =?utf-8?Q?RH/Nj9aABQmXlKRLlrt7zHzAwmbHNmcwmD6YQXn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmdhc29HblVIQVZzc1paRjV4WWNJY2RiR3p3ZENjaktHUVVUNmplTWE5cDBt?=
 =?utf-8?B?cU1IOW4xckRoT0dVcXkzOVhCeHR4WGc0U0pLdzlDQ2N4MWxaSlcxbk52emp2?=
 =?utf-8?B?V0l3Rmh0QVBuY1lzOEF4QVB4VDBQcFVCUzM4TndkTXM5RkhXdGxxQkYyMDF4?=
 =?utf-8?B?ckw4WUVDdGRFTDE1Z1RQbGJKdzZwVzVqWEVYNHJzZE9MZGtnSkZCVjJZRmh2?=
 =?utf-8?B?ZG1GdUsvQWJlcnQxZVh3WUtOYk0zcmI2Vzh4ZDJvQ2RRVWl5WElCUVVJVWlG?=
 =?utf-8?B?dVFIdjYzeGs0R3JQZndNWEpoMUNGcDhOQ1RwUCs3cllxSzExRDhKS3M5WmhB?=
 =?utf-8?B?V0s2ZWl2M2FXRlNYeXl2Si9yam42bDdpK2NzcUdBNVZLMVJDVGQycDMzU1lN?=
 =?utf-8?B?dFFlRm43WWN0bGM3dW0zOVY2a2prK0Y0eDRDNWhkNXRmS2toUUNGU2RhTity?=
 =?utf-8?B?dzdVOTcza2ZibkJKMVlpZ3FQRUdrOUxqM0ZTRkJKd0Q5V2V5b1c1dGg4N2FQ?=
 =?utf-8?B?S3BEY3RVUFRPbXVya096V1ZGZHVUWjRkUXhKcmQvS0pvNFViNzNYdWFaUTls?=
 =?utf-8?B?ZlFBNUl0SzB1YmJSVUV4WkZkb0RSd2QyTjE0MWNnOTl2eUZXU2RvcWxYekhY?=
 =?utf-8?B?VEVFYm1OZTlRandpYVliSGZkeHNCTHZqUnFRMzFMamdvRktpN3pxUUhQRDV1?=
 =?utf-8?B?bWNEZWJud0lvaDJ3N1d3MjdDc2sxVXFXWW51SDZzaHJScDJPYzdxbGhINklY?=
 =?utf-8?B?MGFtQTZMN3Zna3l6dlJlR2p6dUN6TmxZZTArazZmai9PZXhtWGswWHgzbkx3?=
 =?utf-8?B?Rmo2QWdpSkwxZlNMSnhlajlpdXBhNjZyOU5yeTN6bTJzejZuaWxnNlFIdGM0?=
 =?utf-8?B?ZldWQUN4ZCtVTEMrOUZCWjVmdkhnekF4VlNRQmpaTWdLbnZ1cDF3eDcyRkhC?=
 =?utf-8?B?cEVJREpXZE1YQ21wc2IrNkUzSVJyZ0EvUUJtYW5rQVNlWXhjL2FJOEZ0VHd2?=
 =?utf-8?B?MEpTYStNcHRDVi9GS05Rd3JXVnlGNDlzUi8xRC9jVTZNSENqc01hNmpaRUhJ?=
 =?utf-8?B?anJpaStsZkVSTEQ1TkFmYlZFaG0yeGEwcWYzN3V0eklmeTBoVlVyR3ExQnRn?=
 =?utf-8?B?MGp4UHErYlBWK1ZoV2JrOXY0WHBiU0laTGpqRVJ5ZUF0N0ZWR2dwQTc2bVlt?=
 =?utf-8?B?c0w4WC9zaEQ4VVc0RHZUeHRKWVR4QWpJUEI4Q3dFVTEzT3Mzam9EbHNsM2NN?=
 =?utf-8?B?TUNnWjFYbFoyblo5N2EwRTFTRy9oVGlhM1gra294bVFBS1NiOE92VE1ieTF3?=
 =?utf-8?B?TjVqbTNLQ284cmJIVFVDL2xvK3F4d1lKMWI1YkdlYmtEQUh1dENTWmJ6UkpB?=
 =?utf-8?B?TE9vMUtNMTBnODJzSGdVQnRZbnhweitQY2xLVUFlc2hnWHp0RVI4c2ZNN29Z?=
 =?utf-8?B?TGhVN053Y2Q4Q0hMc3NabnV3Q0pFNWlyZkdSRVI3VnBVZGpwdUZFNXpnU0Zy?=
 =?utf-8?B?Qmx1MHZNdU9CTXFRS1FNUXhmaWE0aU44VmdRS244OXYyWWFhc1pZRXZSZ3Q2?=
 =?utf-8?B?aFhUN2dIZ0Q4NFEvWjJsZlR2U2RtRCtUVmt5L3FGeitYV2J2ak1UV2dQTkhH?=
 =?utf-8?B?S3dKQ1BPV3V5aWdseUY3WlpMck1aaXptNVFlNkRQOTNJOGhqcUdYWnFyRCtY?=
 =?utf-8?B?a1hWS0N0UHc0eU9Cb2l6WUFEYTRsTTJxN2ErNWMwUnQ4L0lRTk5hVzZJQ21I?=
 =?utf-8?B?K0RaU0NqenVibFF1aVY2STRiQ2tZa1NzVDZlK2k3c0RvQ01RR0lQS2xBVTlG?=
 =?utf-8?B?ei9vNVhxZ2l4bDVMV1l6QXhYZXJUdEl3QTkrcEZub2g5UFFnVzRiNHlIcll5?=
 =?utf-8?B?eDRWalFzWFhLQkhkZ2E4WVgvMmJLMHJybjc4OEpFRXQxMjlRZmVOZEovek5l?=
 =?utf-8?B?b2lLaWNmR2JBbEN5KzZYZTJMckNvMTRZZjdjVmJHYzVrUnZCLzloVUo0TEZm?=
 =?utf-8?B?REZwVktHNlZDUW05UmJFYUpFckxjOXorUUV4ayt6YkNaWHVHTDZMdnhjOHc0?=
 =?utf-8?B?K0JWU0hKcHQ1MVpVZWlPMm5QbXVrUTFDZjZJaGlmdk9lQVAvQzd0aUQ0d3JJ?=
 =?utf-8?B?RjlLTEd0dGJvRE9vcTRPL3ZLTG1IUmRJQVcveWV2NHVHWHc4dTIwSEwzUGNt?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 772175be-704d-45cd-4e79-08dd080953cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:43:51.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhBsNyUheVMKRz5hiQoPCjeHf0ketVSP4hC2KzpeeifO295/AnIGKZr1xlZjqOVkHPJPS3Idmmh53hqeUzIDJ/xKfmtkiHp0isO7s5xPwaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8396
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> Users can modify the configuration of assignable events. Whenever the
> event configuration is updated, MBM assignments must be revised across
> all monitor groups within the impacted domains.

Please revisit the "Changelog" section in 
Documentation/process/maintainer-tip.rst

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Again patch changed completely based on the comment.
>     https://lore.kernel.org/lkml/03b278b5-6c15-4d09-9ab7-3317e84a409e@intel.com/
>     Introduced resctrl_mon_event_config_set to handle IPI.
>     But sending another IPI inside IPI causes problem. Kernel reports SMP
>     warning. So, introduced resctrl_arch_update_cntr() to send the command directly.

I see ... the WARN is because there is a check whether IRQs are disabled before
the check whether the function can be run locally.

> 
> v8: Patch changed completely.
>     Updated the assignment on same IPI as the event is updated.
>     Could not do the way we discussed in the thread.
>     https://lore.kernel.org/lkml/f77737ac-d3f6-3e4b-3565-564f79c86ca8@amd.com/
>     Needed to figure out event type to update the configuration.
> 
> v7: New patch to update the assignments. Missed it earlier.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 +++++++++++++++++++++++---
>  include/linux/resctrl.h                |  3 +-
>  2 files changed, 79 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5b8bb8bd913c..7646d67ea10e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1710,6 +1710,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  }
>  
>  struct mon_config_info {
> +	struct rdt_resource *r;
>  	struct rdt_mon_domain *d;
>  	u32 evtid;
>  	u32 mon_config;
> @@ -1735,26 +1736,28 @@ u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
>  	return INVALID_CONFIG_VALUE;
>  }
>  
> -void resctrl_arch_mon_event_config_set(void *info)
> +void resctrl_arch_mon_event_config_set(struct rdt_mon_domain *d,
> +				       enum resctrl_event_id eventid, u32 val)
>  {
> -	struct mon_config_info *mon_info = info;
>  	struct rdt_hw_mon_domain *hw_dom;
>  	unsigned int index;
>  
> -	index = mon_event_config_index_get(mon_info->evtid);
> +	index = mon_event_config_index_get(eventid);
>  	if (index == INVALID_CONFIG_INDEX)
>  		return;
>  
> -	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, val, 0);
>  
> -	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
> +	hw_dom = resctrl_to_arch_mon_dom(d);
>  
> -	switch (mon_info->evtid) {
> +	switch (eventid) {
>  	case QOS_L3_MBM_TOTAL_EVENT_ID:
> -		hw_dom->mbm_total_cfg = mon_info->mon_config;
> +		hw_dom->mbm_total_cfg = val;
>  		break;
>  	case QOS_L3_MBM_LOCAL_EVENT_ID:
> -		hw_dom->mbm_local_cfg = mon_info->mon_config;
> +		hw_dom->mbm_local_cfg = val;
> +		break;
> +	default:
>  		break;
>  	}
>  }
> @@ -1826,6 +1829,70 @@ static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static struct rdtgroup *rdtgroup_find_grp_by_cntr_id_index(int cntr_id, unsigned int index)
> +{
> +	struct rdtgroup *prgrp, *crgrp;
> +
> +	/* Check if the cntr_id is associated to the event type updated */
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		if (prgrp->mon.cntr_id[index] == cntr_id)
> +			return prgrp;
> +
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
> +			if (crgrp->mon.cntr_id[index] == cntr_id)
> +				return crgrp;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static void resctrl_arch_update_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
> +				     enum resctrl_event_id evtid, u32 rmid,
> +				     u32 closid, u32 cntr_id, u32 val)
> +{
> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
> +
> +	abmc_cfg.split.cfg_en = 1;
> +	abmc_cfg.split.cntr_en = 1;
> +	abmc_cfg.split.cntr_id = cntr_id;
> +	abmc_cfg.split.bw_src = rmid;
> +	abmc_cfg.split.bw_type = val;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg.full);

Is it needed to create an almost duplicate function? What if instead 
only resctrl_arch_config_cntr() exists and it uses parameter to decide
whether to call resctrl_abmc_config_one_amd() directly or via 
smp_call_function_any()? I think that should help to make clear how
the code flows. 
Also note that this is an almost identical arch callback with no
error return. I expect that building on existing resctrl_arch_config_cntr()
will make things easier to understand.

> +}
> +
> +static void resctrl_mon_event_config_set(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	struct rdt_mon_domain *d = mon_info->d;
> +	struct rdt_resource *r = mon_info->r;

Note that local variable r is created here while the function is inconsistent by
switching between using r and mon_info->r.

> +	struct rdtgroup *rdtgrp;
> +	unsigned int index;
> +	u32 cntr_id;
> +
> +	resctrl_arch_mon_event_config_set(d, mon_info->evtid, mon_info->mon_config);
> +
> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r))
> +		return;
> +
> +	index = mon_event_config_index_get(mon_info->evtid);

This is an AMD arch specific helper to know which offset of an MSR to use. It should
not be used directly in resctrl fs code, this is what MBM_EVENT_ARRAY_INDEX was created for.

Since MBM_EVENT_ARRAY_INDEX is a macro it can be called closer to where it is used,
within  rdtgroup_find_grp_by_cntr_id_index(), which prompts a reconsider of that function name.

> +	if (index == INVALID_CONFIG_INDEX)
> +		return;
> +
> +	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
> +		if (test_bit(cntr_id, d->mbm_cntr_map)) {
> +			rdtgrp = rdtgroup_find_grp_by_cntr_id_index(cntr_id, index);
> +			if (rdtgrp)
> +				resctrl_arch_update_cntr(mon_info->r, d,
> +							 mon_info->evtid,
> +							 rdtgrp->mon.rmid,
> +							 rdtgrp->closid,
> +							 cntr_id,
> +							 mon_info->mon_config);
> +		}
> +	}
> +}

Could you please add some function comments to explain the flow here? For example,
what should reader consider if there is to rdtgroup found?

Reinette

