Return-Path: <linux-kernel+bounces-221982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A386A90FB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8351C21159
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D21CD23;
	Thu, 20 Jun 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM/gHTgD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873E12E78
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718851210; cv=fail; b=XwjokglCLky4xfoeVYOK3efU6K0yfVJW3wgkGLsmKCcDdIaVa6xfdYkE0fjwoNhBfZTr+u3qgp5Pyk5qvFLJ2ei7vIu9/hRH8UD1XITYb/NudQFxnU8gITdgGnKY1a6hD7e9J4KAfsqxqihFDOJ9432C8dp5C46ml8bUr98fB4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718851210; c=relaxed/simple;
	bh=ZZqtPHQ9BX9RqlYweXFvitNiKTzxt6OCLqCSank35dY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CrwZt0s9kZlMNK2jyhB04oF+nU+qne3arhuuALfKdPoVhryTj/lDbZmvOayxGhccCg0Q89+1riUgcXxHoWkJNB99ueOtv3m7y8KAPRyvJYnYVqcrzhPPqjaT8r1Z+/Y5exgBqHWMbbS9Zyk7rYkZ5d2aamVsrNEJ5K3ny7Ci8Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM/gHTgD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718851209; x=1750387209;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ZZqtPHQ9BX9RqlYweXFvitNiKTzxt6OCLqCSank35dY=;
  b=gM/gHTgDv1FmSJlDgzuYV/6WD3hOiSDq02ltPctJUXJZlr2bCgZhgW4h
   1HVbdah2l068NkqB3JWdWdVUqOTIhgCGhCowky8Wr0ypOLkHfLAF5yIT1
   YijYJArGnX0748K0R8eP8C+jiq0vd2/UYzgnR+ba50gVaPBJ8eGk5uKRO
   B+gxcnr2FOXxVkl0o18+Pi3xLW2KMfVqA5b4i36JVhyMvZCIg5vIKYXqs
   RQ7uGBeHv5Lm8I2SBB4lrjw/B8jYnP9s8KuM/Shmwh/RfW4P9zWgoAE8E
   NHZkRfNcH23izwt2QVpc0RplkaehLLUknrF5BmvocZbMdGA/I4ReC3iPM
   Q==;
X-CSE-ConnectionGUID: izt0CwyrTNmwC/3ImAlQ9w==
X-CSE-MsgGUID: MDAD/E5JSJ+OlTcakP9x7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41212483"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41212483"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 19:40:08 -0700
X-CSE-ConnectionGUID: Y+Yk4o67RSyZScFu72oUwg==
X-CSE-MsgGUID: Zoq01ZiRSVSwZmd0pDmMrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42551607"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 19:40:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 19:40:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 19:40:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 19:40:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+xD2jdqNwLJS7nAEIIS8IH+NnDjXXuIyYC09K0RTpB1WZM4iAS01IKEw9dahOX3MIOwakqRfrwmXYJIY/pWxkAfcQbYSiPihVMk9XpCrLRwZZaSoxGTmNQDYR2ewwMoLxmGaBcrfamqXaQK16lTUPzRtu/fjCzX/U+EUos//6ggGjEuGhILqcy0rwCrcQ2RYBU14puMp3SL38SRbGWP384izgUZjHyBWks4tqqHHMatXxYd7DwoQsep+653E+r7jaUi5R/Hxn4t6p+NuB5dVqN7BHlKt+AHNnTgP+rGyotOzjiA8TKD/MwAQk8mik8EJCQUdpDKTiTgFXF2YZKn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoxcZyWtReBygnsfn+9A2+ho8Aa/U7LSTdW9NbzO0SA=;
 b=hP2oK7qZ97hhQw20SVke8GKkjlsVCsR7ejdev8FaJCvXhcbhKBcBWJZ+C3LPcO+ZuHHlV3Yti7GxYDWrUp5z8TlzHo/RIelZ41IUT76BM0+MXWP72mK66iLPd5GC+aoYy9mhGcFRMvYMi0UeBD8LKEQl44YfCkJ2dbMXNhZ7VNhx3xopHiGzy/IYb8tx+tFzc0upk06uBuKDUfhnma0MPV6sKxudDnacfaBKSGGAAtAWCdAMqZjCpHVOgm512mCBKHn0ynigDYR6mkuLmsH5o1RPz5LzYNcal08Ome0hkpIBIQB6Er3TL+3ld0U7ILnsV+o3VsFiKJIBuxYD932mBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Thu, 20 Jun
 2024 02:40:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 02:40:02 +0000
Date: Thu, 20 Jun 2024 10:39:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
	<ying.huang@intel.com>, David Hildenbrand <david@redhat.com>, John Hubbard
	<jhubbard@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Mel Gorman
	<mgorman@techsingularity.net>, Ryan Roberts <ryan.roberts@arm.com>,
	<linux-mm@kvack.org>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [mm]  d2136d749d:  vm-scalability.throughput -7.1%
 regression
Message-ID: <202406201010.a1344783-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e08086c-673a-4f4a-d280-08dc90d24910
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9MBdUijiMmJfnok00zWj/mnpiyTkjEJUZwczt25d7o+Pa4CkHN1sd3a++6?=
 =?iso-8859-1?Q?kb1j5sxEytyQklCBdREYoEdSXEaIlTOHd3bP+CDTE5z5dFIkyPY7FIHXnR?=
 =?iso-8859-1?Q?1fg9R3UgglNqdG8Ptbg6BKUIAhwg9tjbIDK8PTDJ3T6El6RCxkXChlXV2e?=
 =?iso-8859-1?Q?fpUhWHu2qzJ0BsRCAFfFEdvIeXlrZss43lywbJbcFJ+WR78YC/PB3U5LAR?=
 =?iso-8859-1?Q?CX5jOqOnJBkFwTZjJZNhlaxbxYoxUUhVvD0/l2kR5uY12JtoT0R2lscDd4?=
 =?iso-8859-1?Q?+DNdJCCQw9YsvPmU9LNEmMrLQZEoWos/YL0eyvXfLQhBzMD1qebLVCUf8i?=
 =?iso-8859-1?Q?FAiPwRSW+W1ZYuhk+T90+cW50nS0lmZ+GTaWp4T2qbtosmC03kMRWUN1s6?=
 =?iso-8859-1?Q?M3r1qJMeLMM+Q8nFRmOZVwpEntj6sbtrCWQL7S+HEX1jXYXw9qmLS0+H62?=
 =?iso-8859-1?Q?ZzAc9B1I/qVk8Jltk2lFXn0ooUb4dhqSVzB3IAL0bZoSR2pskLTlLRdr9A?=
 =?iso-8859-1?Q?/JOHMbIslpsS3Ey9u8ntuUVaaTqHnCYH0ai1MTkNUcK3gNl17wDgtduaLA?=
 =?iso-8859-1?Q?Y1XglBR7oxPoiISbkzVnuzRhXSzmrAEzhwUsqtnhpoKPnjg/cXdHiKVGZK?=
 =?iso-8859-1?Q?2DEIrq91jc4zKluqRb+clvDIdlt9kYSubWpKChmF/2iXGF9+LlN5q3g2US?=
 =?iso-8859-1?Q?mbCcXmpe0Qpzo98S/M+dYxWC8A3QAouhst9i0zKkMYVp7CWqS/Nbn3oZsG?=
 =?iso-8859-1?Q?NYpBUA+hE6dk3meUzNuGwlnvKCAZRCQ7BAp3pr32WYfIkKu2cq2Piw8Y+H?=
 =?iso-8859-1?Q?SGFdsxT7u/oowYa0jM+JQgRSIDld+n04klqa4fUsTRTmldDfn3q3t4o3q2?=
 =?iso-8859-1?Q?UFdt8FNR7PhWXfpM+Xbi10d5or0c5abxzNXEbT1nVg+sShTHdnWD9gLTKm?=
 =?iso-8859-1?Q?TqKvtuobxYG8fFsuC78NVv+a3Z6fw5R4RBbV2eyrE3sWeoL5aIkfN+ctMb?=
 =?iso-8859-1?Q?eq7CHBxghYOJ/nbgfecK+s5TKvuSz0B3KN/imgVFqJ/XIJ7fnnPL4rV6TA?=
 =?iso-8859-1?Q?GH7wWOfW3/P55cojKWuuFmpY4QOeO4i+lMEdrCBoSGvRhZROBtSXDGywVL?=
 =?iso-8859-1?Q?ICnMpuIWj+cy1a93N3mz5R60QjclDiVHri8NrASwPEe/3ZJomWmcGS7Pqe?=
 =?iso-8859-1?Q?fzbwX9WzMJGQcV/B4qMB40lAaBFKQoH7RuhhzepRoaQNS10wWgsCmpB6Yo?=
 =?iso-8859-1?Q?bo74VmksSJ2L6roKCUtVR7pLazjtvYpUJgH+bVFslNmO7b/6oP64oUbnIp?=
 =?iso-8859-1?Q?kt53cCy8gDykyNihP8WX6L7DqQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MpYeMR/Q735Y9PtJggH8B8vYQ9c+NKbtZCS6eBq+CmV574zt+NUPQaEl25?=
 =?iso-8859-1?Q?LzDUPzJYbSwuOTsPCq5tnzRASmwQLUmTC7nXjsicD12dPcOahqVAfnvwbo?=
 =?iso-8859-1?Q?ygVGo/aMjFXkuytSiXiGUp3yED6vcwJQdtUHqzQehzUoV4UhEMt+A8A3mw?=
 =?iso-8859-1?Q?3POw87lStHooORN0T/5qa6n0VeRV/FEKwVi/bb1uvExLdqPCWbecXbZeBD?=
 =?iso-8859-1?Q?5BQFgOrgKNbd95TdJugHEtw6SOOMSZPJikzjyAQxUjOlPwmrwznG28NLVX?=
 =?iso-8859-1?Q?0ZVTOFkSIZAgewj64TfCDxsCWzUvUypfcYUDp3OGSwAx1FcwRyb2mtDLvV?=
 =?iso-8859-1?Q?Y8AgQzEwnaj8nQVS9Ur7WtbakjFde+lV5CsVfP5CN6IJnFrZje2x+kTyjm?=
 =?iso-8859-1?Q?7xv4VkY9wmE6j4cMFodY6vO0mMk+ZRg1tC+4iPjRLiEQQ/spliOXFoLOzv?=
 =?iso-8859-1?Q?feX14MyRRjJBWDv4eJUmbr98XRVy369N6HWOUws1xgiX6yQF1voN77YUWC?=
 =?iso-8859-1?Q?IRFMK3yo/zQ9DEwbDYoAo2pSjgwJw/3rnAP2C8W6PTUTpj56RRj+8PIhrb?=
 =?iso-8859-1?Q?6mRIf/wU55B3LnsLDtKFcD4xRZPspP33+oTLzm7t3D2DLLs3RB/Z6mE90X?=
 =?iso-8859-1?Q?nMEew8vcnmKTPJDsey9Us5fnr9DP4xk0m0DWLn8s/nsTfhAE6HmHMcg3kJ?=
 =?iso-8859-1?Q?znZo0jkalJj1L8M2/g+ZTn4nA4ib7u46Bm+ZKQxpUn5Yk+EIzNGbFAy6ii?=
 =?iso-8859-1?Q?uLizD09fcbzhLGykHclEqbEWR/aGMSe5O/geg8d30laL/MqoVzpi5Wigwv?=
 =?iso-8859-1?Q?CIs0bTxPlDjpJNTeYdPIsx8UMelBay6qc2P1p8sPzANv+G8BJr3r8XlZFN?=
 =?iso-8859-1?Q?0NPTNkvrwenpqkJk/vIuBo2sK6GqA2/OEnWsCIGxaMmYIFi22Oe52Qhncu?=
 =?iso-8859-1?Q?CB4J9r0dbdi6naX/0oTBHBn3DGar69ycEgw43JHqqFTp8M1BqiWZqtiP50?=
 =?iso-8859-1?Q?ZINSsCPGpUBk1MUQDqPXOTP0FvFNJHKA6LJf5qDo+UkrnhDAp9B13IXtkw?=
 =?iso-8859-1?Q?g7B549PO555tbEJqTD4qIs+awEUHFglPr4HQNkGjW/VBtPzwzowf/RjMPq?=
 =?iso-8859-1?Q?2OTAAQ+rUO6z8TmQG7l8X44+Myt37Y7jXAdMJwNuUL8tgVJOY5fg1jugnk?=
 =?iso-8859-1?Q?rgFSgQGAqtWdx2KhpyNcmuSRUMBaUg0kihOmEImMHQsFB4f991zEq4REC6?=
 =?iso-8859-1?Q?Pq8od1oq/89vZ7DeFdblIu9mnVFY27jrv8Ysgsu1H0oaqEaGFn0I57SR7m?=
 =?iso-8859-1?Q?QhiSB0p+8kGfvRm4MNII+866VdYSC4Rv1zh6dxZlYH3DhR0A5xkDCDqy0x?=
 =?iso-8859-1?Q?ObZRF3tDiOb1sira0yhMJBEAFZeJi7kKYBCL7C/yDECuILYVb9O0rL6C+N?=
 =?iso-8859-1?Q?U4bVQYR+1zLdjkdno9lL2SicIgrSOf1cGY+eFt1vh8pLVHTyndcFX4JhOg?=
 =?iso-8859-1?Q?49w9jP8YoLkhP9g0UGkFXsANox/Ofaz3x37P/r1YZXofvwemaMf5qpNZDT?=
 =?iso-8859-1?Q?y9O0xVdId+WGd0xsZm1+HpBijDfsYdBMU1qQk+hEvkmX/9Ou+yeKN/TGRe?=
 =?iso-8859-1?Q?ydJKFoLtD4R/8v+z2c1xZLhilb23RhOcyJl/BzAvK5wnFzmnLcrc79TA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e08086c-673a-4f4a-d280-08dc90d24910
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:40:02.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5PCw04mB+j9xFv5+uOEaMMKuEmWMNICBnqzObei8uQBnbO171kO5/7a8shcx8B/tvVi2Oztuk23DubH9FDZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -7.1% regression of vm-scalability.throughput on:


commit: d2136d749d76af980b3accd72704eea4eab625bd ("mm: support multi-size THP numa balancing")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master 92e5605a199efbaee59fb19e15d6cc2103a04ec2]


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
| Closes: https://lore.kernel.org/oe-lkp/202406201010.a1344783-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240620/202406201010.a1344783-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/300s/512G/lkp-icl-2sp2/anon-cow-rand-hugetlb/vm-scalability

commit: 
  6b0ed7b3c7 ("mm: factor out the numa mapping rebuilding into a new helper")
  d2136d749d ("mm: support multi-size THP numa balancing")

6b0ed7b3c77547d2 d2136d749d76af980b3accd7270 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     12.02            -1.3       10.72 ±  4%  mpstat.cpu.all.sys%
   1228757            +3.0%    1265679        proc-vmstat.pgfault
   7392513            -7.1%    6865649        vm-scalability.throughput
     17356            +9.4%      18986        vm-scalability.time.user_time
      0.32 ± 22%     -36.9%       0.20 ± 17%  sched_debug.cfs_rq:/.h_nr_running.stddev
     28657 ± 86%     -90.8%       2640 ± 19%  sched_debug.cfs_rq:/.load.stddev
      0.28 ± 35%     -52.1%       0.13 ± 29%  sched_debug.cfs_rq:/.nr_running.stddev
    299.88 ± 27%     -39.6%     181.04 ± 23%  sched_debug.cfs_rq:/.runnable_avg.stddev
    284.88 ± 32%     -44.0%     159.65 ± 27%  sched_debug.cfs_rq:/.util_avg.stddev
      0.32 ± 22%     -37.2%       0.20 ± 17%  sched_debug.cpu.nr_running.stddev
 1.584e+10 ±  2%      -6.9%  1.476e+10 ±  3%  perf-stat.i.branch-instructions
  11673151 ±  3%      -6.3%   10935072 ±  4%  perf-stat.i.branch-misses
      4.90            +3.5%       5.07        perf-stat.i.cpi
    333.40            +7.5%     358.32        perf-stat.i.cycles-between-cache-misses
 6.787e+10 ±  2%      -6.8%  6.324e+10 ±  3%  perf-stat.i.instructions
      0.25            -6.2%       0.24        perf-stat.i.ipc
      4.19            +7.5%       4.51        perf-stat.overall.cpi
    323.02            +7.4%     346.94        perf-stat.overall.cycles-between-cache-misses
      0.24            -7.0%       0.22        perf-stat.overall.ipc
 1.549e+10 ±  2%      -6.8%  1.444e+10 ±  3%  perf-stat.ps.branch-instructions
 6.634e+10 ±  2%      -6.7%  6.186e+10 ±  3%  perf-stat.ps.instructions
     17.33 ± 77%     -10.6        6.72 ±169%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     17.30 ± 77%     -10.6        6.71 ±169%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     17.30 ± 77%     -10.6        6.71 ±169%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     17.28 ± 77%     -10.6        6.70 ±169%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     17.27 ± 77%     -10.6        6.70 ±169%  perf-profile.calltrace.cycles-pp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     13.65 ± 76%      -8.4        5.29 ±168%  perf-profile.calltrace.cycles-pp.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     13.37 ± 76%      -8.2        5.18 ±168%  perf-profile.calltrace.cycles-pp.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault.do_user_addr_fault
     13.35 ± 76%      -8.2        5.18 ±168%  perf-profile.calltrace.cycles-pp.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault.handle_mm_fault
     13.23 ± 76%      -8.1        5.13 ±168%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.copy_subpage.copy_user_large_folio.hugetlb_wp.hugetlb_fault
      3.59 ± 78%      -2.2        1.39 ±169%  perf-profile.calltrace.cycles-pp.__mutex_lock.hugetlb_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     17.35 ± 77%     -10.6        6.73 ±169%  perf-profile.children.cycles-pp.asm_exc_page_fault
     17.32 ± 77%     -10.6        6.72 ±168%  perf-profile.children.cycles-pp.do_user_addr_fault
     17.32 ± 77%     -10.6        6.72 ±168%  perf-profile.children.cycles-pp.exc_page_fault
     17.30 ± 77%     -10.6        6.71 ±168%  perf-profile.children.cycles-pp.handle_mm_fault
     17.28 ± 77%     -10.6        6.70 ±169%  perf-profile.children.cycles-pp.hugetlb_fault
     13.65 ± 76%      -8.4        5.29 ±168%  perf-profile.children.cycles-pp.hugetlb_wp
     13.37 ± 76%      -8.2        5.18 ±168%  perf-profile.children.cycles-pp.copy_user_large_folio
     13.35 ± 76%      -8.2        5.18 ±168%  perf-profile.children.cycles-pp.copy_subpage
     13.34 ± 76%      -8.2        5.17 ±168%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      3.59 ± 78%      -2.2        1.39 ±169%  perf-profile.children.cycles-pp.__mutex_lock
     13.24 ± 76%      -8.1        5.13 ±168%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


