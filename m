Return-Path: <linux-kernel+bounces-245174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18A92AF4A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2F228201A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C1212D74F;
	Tue,  9 Jul 2024 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCXZ5/DA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16E1E898
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501893; cv=fail; b=ATDUqDMk3l9Te3outEkDf+a1Dm7qgZSN7zEMg8ieV09kL3yQmMvS7oI9qfMjq/jhpb+L8JVcvIlT9NGTSWn4GHT/ce4UIjk572BpgD4egaw+S5hqbdRu8TEVYJZ1lYizo/tyHud4PzKlv2rcdReTPkbg+imkKEhJ6kaQjCD3svk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501893; c=relaxed/simple;
	bh=77rrFoi2ODjNUcGuxCZYT+G9XvkBj3g9ub85gFRlJMw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lLozARxYxjle7DAuKuIbukiZlgd4ia7+t+JN7v00b18vIzbGT+O353gcMfCPQa86nRTi+f2H2iFCD1SdbYJkA1SIwwWGVKMql9JkQUCqMTioRDZlGk4PMCTAwSiy4sng5klsQOEMA4COz7jke+gGIuwDt/RToKvapU8+nvcGkv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCXZ5/DA; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720501891; x=1752037891;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=77rrFoi2ODjNUcGuxCZYT+G9XvkBj3g9ub85gFRlJMw=;
  b=MCXZ5/DAV6pRzjsku7jzi1p6Pbu0VhFfkKr14HehX75ROFJ3Ugz2pYj9
   854uvnT8RX1LfQaSB4uASd5sqmjqFPYv6UT6WokfWBzAJ0hhT8Oi4lbhd
   HA9cfGxzKiudaFgr4kHT3wW+Vj3FHpDTSEnrjvECBzKARDQsmLOd6OJny
   wj+zrZ0hbQGQMKsJn37+BIeGpCe54cVDZkvuDvH8DabjG3EWsE0d36MmL
   TwOrJrgezBurEmkAq9t/SAQAWuzQHHGQCZ/Hf74ptDFx4d2tcNrOM/NcD
   1q2CjXRAQCm8NIxnWp8UsMs+VzCVdfeC1RaWHfkTWiD+xhBuvVK2StRSz
   w==;
X-CSE-ConnectionGUID: 9pl5h06PRLC7W1jZ1jhvfQ==
X-CSE-MsgGUID: vI6ZpNpZQKiBsOd5Xkp4xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17867606"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17867606"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 22:11:30 -0700
X-CSE-ConnectionGUID: NSPt9hu9R56Vd76Ckx5n0Q==
X-CSE-MsgGUID: 5WRuvZ8hRqOJ/ifbSSsqFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="48148978"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 22:11:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 22:11:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 22:11:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 22:11:28 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 22:11:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QicPQZv0x7cEg4I9L4WsZo7g4XnC8FsYTOr3Our5/7ckVJv/HExWpGDLHT0pLvOW93H0XmHRJT3qXHwGas9hlw3dnBpzBmsQ2Ja571cZGHK6J9YmyWra27wflIz9BaMNOaoVnpF3Rr3KVd7uhkig45sJym72P8lxmOoE/GjjibbCFjvti8zf5OqgBz4kV4HL5Z6XTegrSGbh/317xEdW10p+Qs3AjlsO+nPhxTXOh+vbiyxJ6ffhuNhUAA0Q0z7D2IA8ofa88/S4h9yodtcra6xlMecuI2W+FM8xNdQEk0B1r4d2gZn4POHI/XTDibDKgfMIptJRTEIP23xFvni8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhRHZ52YkzmR7VG27nDmip+hub7jGw5i0hVusfgSMKU=;
 b=IpyI0QdqymtAvcXbNviiDj9pCZHHW7Pom3aok8BDPDgm7Z9mAXdYd/9PmTvuCwkJ/FDLHE2QCr7jfHm0AjOCo/ch1CiXymSwAsUvu9k6CQp1hAv9CupaacS+EPfVbciFQckF7tyqCe8Xhi7QeedHa9kMUYs/Vi9BpQNW+4lY13BMKEO174WXxkfAkgl43gnJKtKRdwZgcoDD4yqUDhnz993GzYLTtsP+7DTLO741Vc9BFNmSMl68ymoN2swfl/or7MlV7LSgGwqoRQHXhlsZO1u4UgIYTuGU1vD0WBAMLb+BYew041cJeuBD+J4XP8bKQbQYuv+iYRYTGPDvXJSXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 05:11:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 05:11:24 +0000
Date: Tue, 9 Jul 2024 13:11:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Zhao <yuzhao@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Muchun Song
	<muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, "Frank van der
 Linden" <fvdl@google.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu
	<peterx@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [mm/hugetlb_vmemmap]  875fa64577:
 vm-scalability.throughput -34.3% regression
Message-ID: <202407091001.1250ad4a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd94dc2-2b18-44a7-1c59-08dc9fd59407
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uLHb1im37r6D9JlqQCDPQ12ejcmo16p7fxr9bOZjaDJNwTQKhSCAabnJEj?=
 =?iso-8859-1?Q?wzp3UdKPFCGGLEC75aUe6y+BKZJr1FvU/oNsis48Hd4ade8f1eVPnezfD2?=
 =?iso-8859-1?Q?J+od3pO9LxLp1wOzJCHe3bzKr3mwigms+d5dJCduarrPYA8KJqJPCAvh70?=
 =?iso-8859-1?Q?9Div5tJy6k6CzK5L+LQSnwTRCBCIbMm/q+gAdoHWno62SZkbxywFLz+OU9?=
 =?iso-8859-1?Q?EMOM3YLsf0pheY3x5qcnfdTpfYDnULTl2N9x9kJvBBXU4v24SK90UI9Sdf?=
 =?iso-8859-1?Q?ksMUjo1KylSOWMJnyh0Uthw3d601SAh/SuNfiUvMkGf+htUus4odlAstkE?=
 =?iso-8859-1?Q?9Ms4/wp3JMTtMeXH6sCLcUaEDhgRVCzHZlTEv7F5RRrKa9CjJrhhXceJUH?=
 =?iso-8859-1?Q?KJRk5VAu/sNcRg+Z2Dly6/YbVxTvD3mxdYr9mJxRVHN/BLH3JrzuZYQK+i?=
 =?iso-8859-1?Q?DcBrQeumUuZl4kBAC3C5IcOZyIDoDBh/S1S/i8JvsQv1/dOqrfsldciJ0M?=
 =?iso-8859-1?Q?byUbXLt3cXmtqEhj6XO8X90G6akTrZ6YhSuikfOm7KFA9a5UG+eyLkdprC?=
 =?iso-8859-1?Q?ngInwUSagMGFGBLJm1tBKBgk+yPCSWcgB9K1kpxPvPH37ZJBs8CQAlEjAa?=
 =?iso-8859-1?Q?o1DH1c3do8PLeweSqaCxZtfB1E8PUaOjq9HAMSQAJyzSMzGoIjMRa2cXik?=
 =?iso-8859-1?Q?GyEszCSo4x0niGsEjgkalhXemNgwjQoXDkeHmkXPAGsClMmOyq/TpfUL+Z?=
 =?iso-8859-1?Q?bZ0l+UB8Bi9fjQlYQQ9kfQw313tD0DNnSkVPhlbj8JSLdyHa+a4MOgiWhg?=
 =?iso-8859-1?Q?d4vfp+P9+vHHnHcg98PYLahfgfXyhhHxFBTPEG75kyA/BgcyOKb02eO8wZ?=
 =?iso-8859-1?Q?QtApaeWZCzh4L8XlBiEzeld54nsa3WmuIkEdb/TgerUevlKxbSAVnRw8dr?=
 =?iso-8859-1?Q?hZAfCqOMTcD1v6wVV6F+Tt5hjXvQu3LQpPVr+wB069A1uLU5abwgDEE5Q4?=
 =?iso-8859-1?Q?natJ9bqAeZ5iWUeUcTXiI1ar/s6PhtQK30U6d81+1igbxVlr7ySSdTcH4z?=
 =?iso-8859-1?Q?eZHFdfLxPpdzifEMvTeRuUt9b9ZWlTxEbEmeIxiOV4qyk7BkbYf0tOHczX?=
 =?iso-8859-1?Q?0/lzibuXkyAd41ZQBB/5WiBf3SX9it6qwXFuhFhxdd+zJTBeKVmtLhrmh/?=
 =?iso-8859-1?Q?lpUal7dEvzRrYIcAINIoCaeZesP09mMya7snQHBIsC1JXfPDa6Im0SoWFc?=
 =?iso-8859-1?Q?c4IyFx36RZdyaDEYRuxcvNNpPzfrpnqivHmJvo62HIlIuWl0Mpnynkymlm?=
 =?iso-8859-1?Q?YD8CNYLbQ9j0Uh+qdGZ+6WQadmG93AN+fLIvFIn+IiBDS35qtmQlnsCzIY?=
 =?iso-8859-1?Q?D2s2WyVM1c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?i7VUAFUxRxkWHeMZDNN199Hh4PoCASekHrJo4isFBZUa9/9NGzTcbqEY21?=
 =?iso-8859-1?Q?9BqN0FhrRkn3BFxdZ9pJdT4tsw9L3+EvxtNvjTlZZKqA4llFJ5Ha1JO7NL?=
 =?iso-8859-1?Q?zTo3CNPmneADBeXM7d9SXdTdrxcmVc5l/tyPK4CVawkSdh7wCLwT0AfCPJ?=
 =?iso-8859-1?Q?G5plc6v5NQecydeTPGyn6vNhvYzajUyXzBqfCUDIsUiM7oWcQVK1opeTeD?=
 =?iso-8859-1?Q?dtNqJolfEf/jv5wVT8GROKFDDSadEXWZKtUqxN+4CfqwJAY8CrtFjMkVw0?=
 =?iso-8859-1?Q?LuBy/eIdmwAXqmvFpeTU16m152pwK2lmE/5Avx0UHVwsXENl5cQtqjJivU?=
 =?iso-8859-1?Q?3TjdV7a5/YAkDNHmhHb334UJSQq/lU+Xc/K8fnZkA8Xws2A/jwNkJ7a4no?=
 =?iso-8859-1?Q?MOFVkez/kPGNaah2hjH682hIXtRSI1Ce+/u/WPEHD/n+xP/0h0lAsSb6mo?=
 =?iso-8859-1?Q?BdL0UnpWJ2bmesONsnSAffGrQK/+JyLsxh64sZd0R63A0UWjuwocKX9Alw?=
 =?iso-8859-1?Q?avfNtcyWNuhL12YOA1M8Wj5HPco2m0bRQtETtf6rTjlyJaly0EfM0qUqCE?=
 =?iso-8859-1?Q?6SnbbFhUuUQgORpaKvHG78Aw+oU/Q5bwZqOHoAYkTCM7cpRd6lsnqvedCr?=
 =?iso-8859-1?Q?whraZAvWxeLWxQmlNHHL+oTSEM3XF4YPDnAGNciupITiZDyH1spN3764Ff?=
 =?iso-8859-1?Q?vJe+j8pJC4DlZF81mYCtL2BZxo2fQnir5p3P6MNutr1gkM3CIoFH7/dEfP?=
 =?iso-8859-1?Q?74qOES/1okEIEiL6Q8Hvg5ePRJfw6n6srZel4+U/SPxw7dFq13+OlV5PQG?=
 =?iso-8859-1?Q?wpAcRrEhHies77tiRYZY5InnUCbYaDHD3gcKW9osoqYC1ObPLBcr6aNhA2?=
 =?iso-8859-1?Q?NotgWES788DAo7g+yQE8tlv4RNMHmYFo1DGgVopkrfR09F6ZPF81UnFJIP?=
 =?iso-8859-1?Q?iuMp9sVELdTOuCGtjtCT4mPyEByMb4T0GLf5H0972Gz/SysjIfdQsq+NJo?=
 =?iso-8859-1?Q?PxSj7x9eku7tX3qZtJSTfpKTW2DPlQ4BIiEypPyKgWrqSNTEjmbnggmiT6?=
 =?iso-8859-1?Q?6OQzGVgJvEkkHDFrKy7uDA1KHKk7MnSIESJz6jjlocx0g0vtRUO7+f/SGX?=
 =?iso-8859-1?Q?WziubTaRdb2i2ePF10InizEt9UccRoShg39r9T6jYOeSbWqzhYF1nuTUIB?=
 =?iso-8859-1?Q?0okKBxdzynqKnp2k9eicYbe5v88G4XGCRnD4+tnTiRB5HdXgCCBxeFXipl?=
 =?iso-8859-1?Q?f0zeWghlctVyUN5Hu1rDdk5F1CREUtCTSZXloud+LXS7FXLmEKSScwLzH0?=
 =?iso-8859-1?Q?7DH5+wFVU/mlX0UcaLhNSDW2ByX8t2XuVSQ/QqsOKpV1w+rcxh7/f7UoNQ?=
 =?iso-8859-1?Q?MDGEmlmI0BFOKyvWgrj34Jde522cw0YMYPb3ITydOVtf7OXqd6PQuTUAlP?=
 =?iso-8859-1?Q?q6/vAU8KVmfqUa8UGUKtKhheD18zxJmP4lo18nlTbAlP1k0NP2jMVtiDv/?=
 =?iso-8859-1?Q?quFYsUG7J2YC8YEytrhtrulNbNuLyA5+1k9gox9pQhGRus3xp0EGRjrAAS?=
 =?iso-8859-1?Q?IdT0m9Oo51JaVS1tXFffCZpIX2zuaWPqxUDDT5fdSPJVTXef7IU2H2xk96?=
 =?iso-8859-1?Q?Yd+/x9AmDxxi2yA4HC/F7C4DBIhrUyvvmhMh4eIKggN6FD0F4DUMpWoA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd94dc2-2b18-44a7-1c59-08dc9fd59407
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 05:11:24.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrzG/IosN/fok7FQTgTELcjiMld/Yyc2WUry1JTgetLiRIr8ZWtuVyywuZN/Q+L/SEFaL87Txn/zRtZF8aVyIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -34.3% regression of vm-scalability.throughput on:


commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[still regression on linux-next/master 0b58e108042b0ed28a71cd7edf5175999955b233]

testcase: vm-scalability
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	size: 512G
	test: anon-cow-rand-hugetlb
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407091001.1250ad4a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240709/202407091001.1250ad4a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability

commit: 
  73236245e0 ("cachestat: do not flush stats in recency check")
  875fa64577 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")

73236245e0b47ea3 875fa64577da9bc8e9963ee14fe 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 4.447e+09 ± 13%    +342.0%  1.966e+10 ±  7%  cpuidle..time
    753730 ±  2%   +1105.0%    9082792 ±  6%  cpuidle..usage
    582089 ±  6%     +20.7%     702337 ±  8%  numa-numastat.node0.local_node
    658053 ±  5%     +18.3%     778277 ±  3%  numa-numastat.node0.numa_hit
    255.89 ±  2%     +32.4%     338.76 ±  3%  uptime.boot
     10264 ±  7%    +147.3%      25384 ±  5%  uptime.idle
      2.00 ± 76%  +72475.0%       1451 ±125%  perf-c2c.DRAM.local
     38.50 ± 13%  +20427.7%       7903 ± 92%  perf-c2c.DRAM.remote
     23.33 ± 17%   +1567.9%     389.17 ± 61%  perf-c2c.HITM.local
     11.33 ± 35%   +1902.9%     227.00 ± 84%  perf-c2c.HITM.remote
     17.44 ± 10%    +208.4%      53.80 ±  2%  vmstat.cpu.id
     71.79 ±  2%     -37.5%      44.87 ±  3%  vmstat.cpu.us
    107.92 ±  2%     -43.9%      60.57 ±  3%  vmstat.procs.r
      2724 ±  4%    +151.1%       6842 ±  3%  vmstat.system.cs
    134997 ±  4%     -23.8%     102899 ±  7%  vmstat.system.in
     16.63 ± 11%     +36.8       53.43 ±  2%  mpstat.cpu.all.idle%
      0.34 ±  3%      -0.1        0.21 ±  2%  mpstat.cpu.all.irq%
      0.03 ±  6%      +0.0        0.04 ±  9%  mpstat.cpu.all.soft%
     10.61 ±  3%      -9.5        1.15 ± 38%  mpstat.cpu.all.sys%
     72.40 ±  2%     -27.2       45.16 ±  3%  mpstat.cpu.all.usr%
      6.83 ± 34%    +195.1%      20.17 ±  3%  mpstat.max_utilization.seconds
    102366 ± 29%    +115.2%     220258 ±  7%  meminfo.AnonHugePages
  70562810           +14.4%   80723780        meminfo.CommitLimit
     43743 ±  2%     -22.7%      33821 ±  2%  meminfo.HugePages_Surp
     43743 ±  2%     -22.7%      33821 ±  2%  meminfo.HugePages_Total
  89587444 ±  2%     -22.7%   69265470 ±  2%  meminfo.Hugetlb
     66355 ± 18%     -40.8%      39283 ± 15%  meminfo.Mapped
 1.341e+08           +15.3%  1.545e+08        meminfo.MemAvailable
 1.351e+08           +15.1%  1.555e+08        meminfo.MemFree
  95643557 ±  2%     -21.4%   75182673 ±  2%  meminfo.Memused
     49588 ±  2%     -31.7%      33871 ±  3%  vm-scalability.median
      8.02 ±  9%      -2.6        5.40 ± 12%  vm-scalability.median_stddev%
   6842353           -34.3%    4498326 ±  2%  vm-scalability.throughput
    205.20 ±  2%     +40.7%     288.76 ±  4%  vm-scalability.time.elapsed_time
    205.20 ±  2%     +40.7%     288.76 ±  4%  vm-scalability.time.elapsed_time.max
    149773 ±  2%     -47.3%      78866 ±  3%  vm-scalability.time.involuntary_context_switches
     10634 ±  2%     -43.5%       6008 ±  3%  vm-scalability.time.percent_of_cpu_this_job_got
      2772 ±  5%     -84.9%     419.47 ± 42%  vm-scalability.time.system_time
     19039           -11.2%      16908        vm-scalability.time.user_time
     14514 ±  2%   +4380.2%     650265        vm-scalability.time.voluntary_context_switches
    617106 ± 42%     -67.8%     198580 ±130%  numa-vmstat.node0.nr_file_pages
      8937 ± 42%     -65.6%       3075 ±110%  numa-vmstat.node0.nr_mapped
     18779 ± 30%     -35.4%      12124 ± 40%  numa-vmstat.node0.nr_slab_reclaimable
    603050 ± 43%     -70.7%     176415 ±148%  numa-vmstat.node0.nr_unevictable
    603050 ± 43%     -70.7%     176415 ±148%  numa-vmstat.node0.nr_zone_unevictable
    657413 ±  5%     +18.2%     776975 ±  3%  numa-vmstat.node0.numa_hit
    581443 ±  6%     +20.6%     701035 ±  8%  numa-vmstat.node0.numa_local
    214166 ±122%    +192.8%     627105 ± 40%  numa-vmstat.node1.nr_file_pages
  11263349 ±  5%     +35.8%   15297395 ±  7%  numa-vmstat.node1.nr_free_pages
      9478 ± 59%     +72.7%      16368 ± 29%  numa-vmstat.node1.nr_slab_reclaimable
    163852 ±161%    +260.4%     590489 ± 44%  numa-vmstat.node1.nr_unevictable
    163852 ±161%    +260.4%     590489 ± 44%  numa-vmstat.node1.nr_zone_unevictable
     49.90 ± 29%    +115.4%     107.47 ±  7%  proc-vmstat.nr_anon_transparent_hugepages
   3345235           +15.3%    3857626        proc-vmstat.nr_dirty_background_threshold
   6698650           +15.3%    7724685        proc-vmstat.nr_dirty_threshold
  33770919           +15.2%   38900683        proc-vmstat.nr_free_pages
    196929            -2.3%     192368        proc-vmstat.nr_inactive_anon
     16843 ± 18%     -40.4%      10031 ± 14%  proc-vmstat.nr_mapped
      2693            -7.6%       2487        proc-vmstat.nr_page_table_pages
    196929            -2.3%     192368        proc-vmstat.nr_zone_inactive_anon
   1404664            +9.0%    1530693 ±  3%  proc-vmstat.numa_hit
   1271130            +9.3%    1389279 ±  3%  proc-vmstat.numa_local
     69467 ±  7%     -34.8%      45284 ± 22%  proc-vmstat.pgactivate
   1263160           +12.8%    1425219 ±  3%  proc-vmstat.pgfault
     37012           +16.6%      43157 ±  4%  proc-vmstat.pgreuse
   2468473 ± 42%     -67.8%     794312 ±130%  numa-meminfo.node0.FilePages
     75120 ± 30%     -35.4%      48496 ± 40%  numa-meminfo.node0.KReclaimable
     35040 ± 42%     -66.3%      11825 ±112%  numa-meminfo.node0.Mapped
     75120 ± 30%     -35.4%      48496 ± 40%  numa-meminfo.node0.SReclaimable
    227978 ± 10%     -17.0%     189123 ± 10%  numa-meminfo.node0.Slab
   2412201 ± 43%     -70.7%     705661 ±148%  numa-meminfo.node0.Unevictable
    856474 ±123%    +192.9%    2508266 ± 40%  numa-meminfo.node1.FilePages
     25221 ±  4%     -34.1%      16618 ± 13%  numa-meminfo.node1.HugePages_Surp
     25221 ±  4%     -34.1%      16618 ± 13%  numa-meminfo.node1.HugePages_Total
     37917 ± 59%     +72.7%      65467 ± 30%  numa-meminfo.node1.KReclaimable
  45044169 ±  5%     +35.8%   61184692 ±  7%  numa-meminfo.node1.MemFree
  53983914 ±  4%     -29.9%   37843391 ± 12%  numa-meminfo.node1.MemUsed
     37917 ± 59%     +72.7%      65467 ± 30%  numa-meminfo.node1.SReclaimable
    153538 ± 16%     +26.2%     193736 ± 10%  numa-meminfo.node1.Slab
    655409 ±161%    +260.4%    2361959 ± 44%  numa-meminfo.node1.Unevictable
      1482 ±  9%     -17.5%       1223 ±  9%  sched_debug.cfs_rq:/.runnable_avg.max
    661.67 ± 14%     -93.0%      46.09 ± 15%  sched_debug.cfs_rq:/.util_est.avg
      1286 ± 12%     -61.4%     496.42 ± 37%  sched_debug.cfs_rq:/.util_est.max
    123.89 ± 48%     -57.2%      53.08 ± 29%  sched_debug.cfs_rq:/.util_est.stddev
    125242 ± 11%     +35.5%     169710 ± 10%  sched_debug.cpu.clock.avg
    125264 ± 11%     +35.5%     169723 ± 10%  sched_debug.cpu.clock.max
    125213 ± 11%     +35.5%     169693 ± 10%  sched_debug.cpu.clock.min
    124816 ± 11%     +35.6%     169267 ± 10%  sched_debug.cpu.clock_task.avg
    125011 ± 11%     +35.6%     169465 ± 10%  sched_debug.cpu.clock_task.max
    115620 ± 12%     +37.8%     159344 ± 10%  sched_debug.cpu.clock_task.min
      2909 ± 14%    +172.9%       7941 ± 10%  sched_debug.cpu.nr_switches.avg
    715.68 ± 18%    +470.7%       4084 ± 23%  sched_debug.cpu.nr_switches.min
    125215 ± 11%     +35.5%     169695 ± 10%  sched_debug.cpu_clk
    123982 ± 11%     +35.9%     168463 ± 10%  sched_debug.ktime
    126127 ± 11%     +35.3%     170626 ± 10%  sched_debug.sched_clk
     15.81 ±  2%    +357.5%      72.34 ±  5%  perf-stat.i.MPKI
  1.46e+10 ±  2%     -32.9%  9.801e+09 ±  4%  perf-stat.i.branch-instructions
      0.10 ±  3%      +0.5        0.65 ±  5%  perf-stat.i.branch-miss-rate%
  10768595           -27.8%    7778807 ±  3%  perf-stat.i.branch-misses
     96.93           -19.0       77.95        perf-stat.i.cache-miss-rate%
 8.054e+08 ±  2%     -33.0%  5.398e+08 ±  4%  perf-stat.i.cache-misses
  8.26e+08 ±  2%     -29.1%  5.855e+08 ±  4%  perf-stat.i.cache-references
      2668 ±  4%    +159.7%       6928 ±  3%  perf-stat.i.context-switches
      5.07           +42.6%       7.24 ± 12%  perf-stat.i.cpi
 2.809e+11 ±  2%     -44.1%  1.571e+11 ±  3%  perf-stat.i.cpu-cycles
    213.40 ±  2%     +41.5%     301.92 ±  5%  perf-stat.i.cpu-migrations
    360.56            -9.5%     326.39 ±  5%  perf-stat.i.cycles-between-cache-misses
 6.256e+10 ±  2%     -32.6%  4.218e+10 ±  4%  perf-stat.i.instructions
      0.24           +39.6%       0.33 ±  3%  perf-stat.i.ipc
      5779 ±  2%     -18.1%       4735 ±  2%  perf-stat.i.minor-faults
      5780 ±  2%     -18.1%       4737 ±  2%  perf-stat.i.page-faults
     12.99            -1.8%      12.75        perf-stat.overall.MPKI
     97.43            -5.1       92.33        perf-stat.overall.cache-miss-rate%
      4.52           -17.5%       3.72        perf-stat.overall.cpi
    347.63           -16.0%     291.93        perf-stat.overall.cycles-between-cache-misses
      0.22           +21.3%       0.27        perf-stat.overall.ipc
     10915            -3.4%      10545        perf-stat.overall.path-length
 1.433e+10 ±  2%     -31.5%  9.821e+09 ±  4%  perf-stat.ps.branch-instructions
  10358936 ±  2%     -25.2%    7745475 ±  4%  perf-stat.ps.branch-misses
 7.973e+08 ±  2%     -32.4%  5.389e+08 ±  4%  perf-stat.ps.cache-misses
 8.183e+08 ±  2%     -28.7%  5.838e+08 ±  4%  perf-stat.ps.cache-references
      2648 ±  4%    +157.5%       6819 ±  3%  perf-stat.ps.context-switches
 2.771e+11 ±  2%     -43.3%  1.572e+11 ±  3%  perf-stat.ps.cpu-cycles
    211.28 ±  2%     +41.6%     299.23 ±  5%  perf-stat.ps.cpu-migrations
 6.139e+10 ±  2%     -31.2%  4.226e+10 ±  4%  perf-stat.ps.instructions
      5815 ±  2%     -19.4%       4686 ±  2%  perf-stat.ps.minor-faults
      5816 ±  2%     -19.4%       4687 ±  2%  perf-stat.ps.page-faults
 1.265e+13            -3.4%  1.222e+13        perf-stat.total.instructions
     60.25 ± 15%     -13.0       47.20 ± 55%  perf-profile.calltrace.cycles-pp.do_rw_once
     47.47 ± 14%      -8.3       39.13 ± 57%  perf-profile.calltrace.cycles-pp.lrand48_r@plt
      2.17 ±130%      -1.5        0.65 ±159%  perf-profile.calltrace.cycles-pp.__mutex_lock.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.57 ±127%      -1.0        0.59 ±160%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.hugetlb_fault.handle_mm_fault.do_user_addr_fault
      0.56 ±146%      -0.6        0.00        perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.hugetlb_fault.handle_mm_fault.do_user_addr_fault
      1.30 ± 48%      -0.4        0.88 ± 71%  perf-profile.calltrace.cycles-pp.lrand48_r
      2.11 ± 14%      -0.1        1.99 ± 49%  perf-profile.calltrace.cycles-pp.nrand48_r
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.alloc_hugetlb_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.alloc_hugetlb_folio.hugetlb_wp.hugetlb_fault
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.copy_mc_enhanced_fast_string
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.copy_mc_enhanced_fast_string.copy_subpage
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.prep_new_hugetlb_folio.alloc_surplus_hugetlb_folio.alloc_hugetlb_folio.hugetlb_wp.hugetlb_fault
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio
      0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.2        0.17 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio.hugetlb_wp
      0.00            +0.2        0.23 ±145%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.2        0.24 ±144%  perf-profile.calltrace.cycles-pp.prep_compound_page.get_page_from_freelist.__alloc_pages_noprof.__folio_alloc_noprof.alloc_buddy_hugetlb_folio
      0.00            +0.2        0.25 ±144%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.3        0.25 ±142%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +0.3        0.26 ±144%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages_noprof.__folio_alloc_noprof.alloc_buddy_hugetlb_folio.__alloc_fresh_hugetlb_folio
      0.00            +0.3        0.26 ±144%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.__folio_alloc_noprof.alloc_buddy_hugetlb_folio.__alloc_fresh_hugetlb_folio.alloc_surplus_hugetlb_folio
      0.00            +0.3        0.28 ±144%  perf-profile.calltrace.cycles-pp.__folio_alloc_noprof.alloc_buddy_hugetlb_folio.__alloc_fresh_hugetlb_folio.alloc_surplus_hugetlb_folio.alloc_hugetlb_folio
      0.00            +0.3        0.28 ±144%  perf-profile.calltrace.cycles-pp.alloc_buddy_hugetlb_folio.__alloc_fresh_hugetlb_folio.alloc_surplus_hugetlb_folio.alloc_hugetlb_folio.hugetlb_wp
      0.00            +0.3        0.28 ±144%  perf-profile.calltrace.cycles-pp.__alloc_fresh_hugetlb_folio.alloc_surplus_hugetlb_folio.alloc_hugetlb_folio.hugetlb_wp.hugetlb_fault
      0.00            +0.5        0.46 ±144%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +0.5        0.48 ±144%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +0.6        0.57 ±144%  perf-profile.calltrace.cycles-pp.alloc_surplus_hugetlb_folio.alloc_hugetlb_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
      0.00            +0.7        0.72 ±144%  perf-profile.calltrace.cycles-pp.alloc_hugetlb_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.9        0.90 ±143%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00            +1.1        1.14 ±142%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +2.1        2.06 ±143%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +2.1        2.09 ±143%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +2.1        2.10 ±143%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +2.2        2.23 ±143%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +2.3        2.30 ±143%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +2.3        2.30 ±143%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.00            +2.3        2.30 ±143%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.00            +2.4        2.35 ±142%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.00            +2.7        2.71 ±143%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     12.15 ±106%     +14.7       26.84 ±129%  perf-profile.calltrace.cycles-pp.do_access
     10.20 ±128%     +14.7       24.91 ±142%  perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     10.20 ±128%     +14.7       24.93 ±141%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     10.22 ±128%     +14.7       24.95 ±142%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     10.21 ±128%     +14.7       24.95 ±142%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     10.23 ±128%     +14.8       25.05 ±141%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      7.77 ±127%     +15.5       23.22 ±141%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault
      7.83 ±127%     +15.5       23.34 ±141%  perf-profile.calltrace.cycles-pp.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
      7.84 ±127%     +15.6       23.40 ±141%  perf-profile.calltrace.cycles-pp.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
      8.00 ±127%     +16.2       24.20 ±141%  perf-profile.calltrace.cycles-pp.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     84.24 ± 14%     -17.2       67.02 ± 55%  perf-profile.children.cycles-pp.do_rw_once
     24.51 ± 14%      -4.4       20.11 ± 57%  perf-profile.children.cycles-pp.lrand48_r@plt
      2.17 ±130%      -1.5        0.65 ±159%  perf-profile.children.cycles-pp.__mutex_lock
      1.57 ±127%      -1.0        0.59 ±160%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.59 ±136%      -0.6        0.04 ±152%  perf-profile.children.cycles-pp.osq_lock
      1.01 ± 19%      -0.2        0.77 ± 47%  perf-profile.children.cycles-pp.lrand48_r
      2.81 ± 14%      -0.1        2.71 ± 45%  perf-profile.children.cycles-pp.nrand48_r
      0.10 ± 57%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.main
      0.10 ± 57%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.run_builtin
      0.08 ± 92%      -0.1        0.02 ±141%  perf-profile.children.cycles-pp.__cmd_record
      0.08 ± 92%      -0.1        0.02 ±141%  perf-profile.children.cycles-pp.cmd_record
      0.06 ±112%      -0.1        0.00        perf-profile.children.cycles-pp.perf_mmap__push
      0.06 ±112%      -0.1        0.00        perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.05 ±113%      -0.1        0.00        perf-profile.children.cycles-pp.record__pushfn
      0.05 ±111%      -0.0        0.00        perf-profile.children.cycles-pp.writen
      0.05 ±110%      -0.0        0.00        perf-profile.children.cycles-pp.shmem_file_write_iter
      0.04 ±110%      -0.0        0.00        perf-profile.children.cycles-pp.generic_perform_write
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.io_serial_out
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.prepare_task_switch
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.seq_read_iter
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irqentry_enter
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.delay_tsc
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.copy_mc_to_kernel
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.vfs_read
      0.06 ± 17%      +0.0        0.08 ± 36%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp._printk
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irq_work_run
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irq_work_single
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.irq_work_run_list
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.dequeue_entity
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.00            +0.0        0.02 ±144%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.0        0.02 ±144%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.0        0.02 ±144%  perf-profile.children.cycles-pp.read
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.enqueue_entity
      0.00            +0.0        0.02 ±146%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.0        0.03 ±141%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.0        0.03 ±143%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.0        0.03 ±143%  perf-profile.children.cycles-pp.note_gp_changes
      0.00            +0.0        0.03 ±147%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.00            +0.0        0.03 ±144%  perf-profile.children.cycles-pp.sched_clock
      0.00            +0.0        0.03 ±141%  perf-profile.children.cycles-pp.activate_task
      0.00            +0.0        0.03 ±142%  perf-profile.children.cycles-pp.native_sched_clock
      0.00            +0.0        0.03 ±142%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.00            +0.0        0.03 ±142%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.0        0.03 ±142%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.03 ±142%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.0        0.04 ±141%  perf-profile.children.cycles-pp.complete
      0.00            +0.0        0.04 ±141%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.0        0.04 ±141%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.0        0.04 ±142%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00            +0.0        0.04 ±144%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.00            +0.0        0.04 ±142%  perf-profile.children.cycles-pp.schedule_idle
      0.06 ±  9%      +0.0        0.10 ± 79%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.00            +0.0        0.04 ±141%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.0        0.04 ±141%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.04 ± 45%      +0.0        0.09 ± 78%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.0        0.04 ±141%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.0        0.04 ±141%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.0        0.04 ±152%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.try_to_wake_up
      0.04 ±101%      +0.0        0.09 ± 78%  perf-profile.children.cycles-pp.free_unref_page
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.0        0.05 ±151%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.06 ± 77%      +0.0        0.10 ± 76%  perf-profile.children.cycles-pp.exit_mm
      0.00            +0.0        0.05 ±145%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.__get_user_pages
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.__mm_populate
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.clear_huge_page
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.hugetlb_no_page
      0.00            +0.0        0.05 ±141%  perf-profile.children.cycles-pp.populate_vma_page_range
      0.00            +0.1        0.05 ±141%  perf-profile.children.cycles-pp.__mmap
      0.06 ± 77%      +0.1        0.11 ± 76%  perf-profile.children.cycles-pp.__mmput
      0.06 ± 77%      +0.1        0.11 ± 76%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.06 ± 77%      +0.1        0.11 ± 76%  perf-profile.children.cycles-pp.do_group_exit
      0.06 ± 77%      +0.1        0.11 ± 76%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.1        0.05 ±142%  perf-profile.children.cycles-pp.rest_init
      0.00            +0.1        0.05 ±142%  perf-profile.children.cycles-pp.start_kernel
      0.00            +0.1        0.05 ±142%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +0.1        0.05 ±142%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.04 ±102%      +0.1        0.10 ± 77%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.06 ± 77%      +0.1        0.11 ± 75%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.1        0.05 ±143%  perf-profile.children.cycles-pp.update_load_avg
      0.04 ±102%      +0.1        0.10 ± 77%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.04 ±102%      +0.1        0.10 ± 77%  perf-profile.children.cycles-pp.folios_put_refs
      0.04 ±102%      +0.1        0.10 ± 77%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.01 ±223%      +0.1        0.06 ±149%  perf-profile.children.cycles-pp.task_work_run
      0.01 ±223%      +0.1        0.06 ±148%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.00            +0.1        0.06 ±141%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.00            +0.1        0.06 ±141%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.00            +0.1        0.06 ±146%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.02 ±144%      +0.1        0.09 ±145%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.00            +0.1        0.07 ±118%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.16 ± 35%      +0.1        0.23 ± 79%  perf-profile.children.cycles-pp.ksys_write
      0.16 ± 34%      +0.1        0.23 ± 79%  perf-profile.children.cycles-pp.vfs_write
      0.16 ± 35%      +0.1        0.23 ± 80%  perf-profile.children.cycles-pp.write
      0.00            +0.1        0.08 ±145%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.00            +0.1        0.08 ±145%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.08 ±148%  perf-profile.children.cycles-pp.schedule_timeout
      0.00            +0.1        0.09 ±146%  perf-profile.children.cycles-pp.__wait_for_common
      0.00            +0.1        0.09 ±132%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.00            +0.1        0.09 ±145%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.1        0.09 ±145%  perf-profile.children.cycles-pp.wait_for_completion_state
      0.00            +0.1        0.09 ±146%  perf-profile.children.cycles-pp.__wait_rcu_gp
      0.00            +0.1        0.09 ±142%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.00            +0.1        0.09 ±141%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.1        0.10 ±145%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.1        0.10 ±143%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.10 ±145%  perf-profile.children.cycles-pp.hugetlb_vmemmap_optimize_folio
      0.13 ± 15%      +0.1        0.23 ± 68%  perf-profile.children.cycles-pp.sched_tick
      0.00            +0.1        0.10 ±141%  perf-profile.children.cycles-pp.sched_balance_domains
      0.00            +0.1        0.10 ±134%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.1        0.11 ±146%  perf-profile.children.cycles-pp.schedule
      0.00            +0.1        0.11 ±143%  perf-profile.children.cycles-pp.sched_balance_rq
      0.05 ± 76%      +0.1        0.18 ± 76%  perf-profile.children.cycles-pp.io_serial_in
      0.12 ±125%      +0.1        0.24 ±144%  perf-profile.children.cycles-pp.prep_compound_page
      0.08 ± 57%      +0.1        0.21 ± 83%  perf-profile.children.cycles-pp.devkmsg_emit
      0.08 ± 57%      +0.1        0.21 ± 83%  perf-profile.children.cycles-pp.devkmsg_write
      0.07 ± 57%      +0.1        0.20 ± 70%  perf-profile.children.cycles-pp.wait_for_lsr
      0.09 ± 37%      +0.1        0.22 ± 72%  perf-profile.children.cycles-pp.serial8250_console_write
      0.00            +0.1        0.14 ±117%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.13 ±124%      +0.1        0.27 ±144%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.13 ±124%      +0.1        0.26 ±144%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.console_flush_all
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.console_unlock
      0.10 ± 38%      +0.1        0.24 ± 72%  perf-profile.children.cycles-pp.vprintk_emit
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.commit_tail
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.children.cycles-pp.memcpy_toio
      0.13 ±125%      +0.1        0.28 ±144%  perf-profile.children.cycles-pp.__alloc_fresh_hugetlb_folio
      0.13 ±124%      +0.1        0.28 ±144%  perf-profile.children.cycles-pp.__folio_alloc_noprof
      0.10 ± 38%      +0.1        0.24 ± 74%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.10 ± 38%      +0.1        0.24 ± 74%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.10 ± 38%      +0.1        0.24 ± 74%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.00            +0.1        0.15 ±144%  perf-profile.children.cycles-pp.__schedule
      0.13 ±124%      +0.1        0.28 ±144%  perf-profile.children.cycles-pp.alloc_buddy_hugetlb_folio
      0.10 ± 36%      +0.2        0.25 ± 73%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.10 ± 36%      +0.2        0.25 ± 73%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.11 ± 36%      +0.2        0.26 ± 73%  perf-profile.children.cycles-pp.process_one_work
      0.11 ± 36%      +0.2        0.27 ± 72%  perf-profile.children.cycles-pp.worker_thread
      0.09 ± 12%      +0.2        0.25 ± 89%  perf-profile.children.cycles-pp.clockevents_program_event
      0.12 ± 35%      +0.2        0.29 ± 70%  perf-profile.children.cycles-pp.kthread
      0.12 ± 35%      +0.2        0.29 ± 70%  perf-profile.children.cycles-pp.ret_from_fork
      0.12 ± 35%      +0.2        0.29 ± 70%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.2        0.18 ±143%  perf-profile.children.cycles-pp.prep_new_hugetlb_folio
      0.00            +0.2        0.18 ±145%  perf-profile.children.cycles-pp.synchronize_rcu_normal
      0.24 ± 10%      +0.2        0.45 ± 69%  perf-profile.children.cycles-pp.update_process_times
      0.29 ± 33%      +0.2        0.53 ± 55%  perf-profile.children.cycles-pp.do_syscall_64
      0.29 ± 33%      +0.2        0.53 ± 55%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ± 14%      +0.3        0.34 ±106%  perf-profile.children.cycles-pp.ktime_get
      0.27 ±  9%      +0.3        0.54 ± 71%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.28 ±  9%      +0.3        0.56 ± 72%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.3        0.34 ±144%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.3        0.34 ±144%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.03 ±100%      +0.4        0.39 ±119%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.13 ±125%      +0.4        0.58 ±140%  perf-profile.children.cycles-pp.alloc_surplus_hugetlb_folio
      0.39 ±  7%      +0.5        0.87 ± 79%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.40 ±  7%      +0.5        0.90 ± 79%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.14 ±126%      +0.6        0.73 ±141%  perf-profile.children.cycles-pp.alloc_hugetlb_folio
      0.43 ±  7%      +0.9        1.38 ± 96%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.59 ± 15%      +1.9        2.48 ±108%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.02 ±141%      +2.2        2.20 ±134%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.02 ±141%      +2.2        2.20 ±134%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.02 ±141%      +2.2        2.24 ±134%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.02 ±141%      +2.2        2.24 ±134%  perf-profile.children.cycles-pp.cpuidle_enter
      0.02 ±142%      +2.4        2.38 ±134%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.02 ±141%      +2.4        2.39 ±134%  perf-profile.children.cycles-pp.start_secondary
      0.03 ±102%      +2.4        2.46 ±133%  perf-profile.children.cycles-pp.do_idle
      0.03 ±102%      +2.4        2.46 ±133%  perf-profile.children.cycles-pp.common_startup_64
      0.03 ±102%      +2.4        2.46 ±133%  perf-profile.children.cycles-pp.cpu_startup_entry
     12.44 ±103%     +14.7       27.14 ±127%  perf-profile.children.cycles-pp.do_access
     10.22 ±128%     +14.8       25.04 ±141%  perf-profile.children.cycles-pp.do_user_addr_fault
     10.22 ±128%     +14.8       25.04 ±141%  perf-profile.children.cycles-pp.exc_page_fault
     10.20 ±128%     +14.8       25.04 ±141%  perf-profile.children.cycles-pp.hugetlb_fault
     10.22 ±128%     +14.9       25.08 ±141%  perf-profile.children.cycles-pp.handle_mm_fault
     10.24 ±128%     +14.9       25.15 ±141%  perf-profile.children.cycles-pp.asm_exc_page_fault
      7.82 ±127%     +15.6       23.38 ±141%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      7.83 ±127%     +15.6       23.42 ±141%  perf-profile.children.cycles-pp.copy_subpage
      7.84 ±127%     +15.6       23.48 ±141%  perf-profile.children.cycles-pp.copy_user_large_folio
      8.00 ±127%     +16.3       24.27 ±141%  perf-profile.children.cycles-pp.hugetlb_wp
     83.41 ± 14%     -17.2       66.25 ± 55%  perf-profile.self.cycles-pp.do_rw_once
      1.56 ±127%      -1.0        0.59 ±160%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.59 ±136%      -0.6        0.04 ±152%  perf-profile.self.cycles-pp.osq_lock
      0.72 ± 25%      -0.2        0.49 ± 53%  perf-profile.self.cycles-pp.lrand48_r@plt
      1.92 ± 14%      -0.2        1.72 ± 47%  perf-profile.self.cycles-pp.do_access
      2.53 ± 14%      -0.1        2.44 ± 45%  perf-profile.self.cycles-pp.nrand48_r
      0.30 ± 15%      -0.0        0.28 ± 50%  perf-profile.self.cycles-pp.lrand48_r
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.io_serial_out
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.note_gp_changes
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.delay_tsc
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.copy_user_large_folio
      0.00            +0.0        0.02 ±146%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.0        0.02 ±143%  perf-profile.self.cycles-pp.hugetlb_wp
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.00            +0.0        0.03 ±143%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.0        0.03 ±150%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.0        0.03 ±141%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.0        0.03 ±141%  perf-profile.self.cycles-pp.sched_balance_domains
      0.00            +0.0        0.03 ±144%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.0        0.03 ±144%  perf-profile.self.cycles-pp.tick_nohz_handler
      0.00            +0.0        0.03 ±146%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.0        0.04 ±143%  perf-profile.self.cycles-pp.copy_subpage
      0.00            +0.0        0.04 ±141%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.00            +0.0        0.04 ±147%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.0        0.04 ±144%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.00            +0.0        0.04 ±141%  perf-profile.self.cycles-pp._raw_spin_lock
      0.04 ±101%      +0.0        0.08 ± 77%  perf-profile.self.cycles-pp.free_unref_page
      0.04 ± 45%      +0.0        0.09 ± 78%  perf-profile.self.cycles-pp.get_jiffies_update
      0.00            +0.0        0.04 ±141%  perf-profile.self.cycles-pp.clear_page_erms
      0.00            +0.0        0.05 ±141%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +0.0        0.05 ±148%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.01 ±223%      +0.1        0.06 ±149%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.05 ± 76%      +0.1        0.17 ± 75%  perf-profile.self.cycles-pp.io_serial_in
      0.11 ±124%      +0.1        0.24 ±144%  perf-profile.self.cycles-pp.prep_compound_page
      0.10 ± 38%      +0.1        0.24 ± 73%  perf-profile.self.cycles-pp.memcpy_toio
      0.08 ± 14%      +0.2        0.32 ±105%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.3        0.34 ±144%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.00            +1.1        1.07 ±138%  perf-profile.self.cycles-pp.acpi_safe_halt
      7.77 ±127%     +15.5       23.22 ±141%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


