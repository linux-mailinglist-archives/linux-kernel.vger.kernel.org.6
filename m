Return-Path: <linux-kernel+bounces-213115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4842906C23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9771F23A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF631448C4;
	Thu, 13 Jun 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6udFw1/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39F13D624
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279179; cv=fail; b=AS5r9gI7aCwOOG2IL57M4nV0Ny8pIvAGBPToZ9AI1PFQ9m2VdwvoGXq9ygoDm5JXTEbp+StwmpOH/E6HjlDaaYEeTQKSheeS4iPqHBWj/Uoyc0oYU7CN/Vnb7E2xT08pfwCR1QjcOtzMjMUXnVDflnk4KaOcB6P7ZA56YTNBdZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279179; c=relaxed/simple;
	bh=bZyV6p6GPHvoINbg84TRurUQvP25duMlMy6+Kc8pqwI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eOt9scvUWGdzg+1J7J76ClOLM7t7ykZCZmu6sfAJe/k8avxaoiaoO8Ev7ks3gNRxMm5wUUxICz70L/ir/Se2d8Q3dgFWYASCCKMz4DWmYWxPpdNdxANg9lii8kjbTPNEc4Xi44jGVv8v0eRplQd4gTh2ABblsUC5lUPApyAsOgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6udFw1/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718279178; x=1749815178;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bZyV6p6GPHvoINbg84TRurUQvP25duMlMy6+Kc8pqwI=;
  b=S6udFw1/qjdD6RLRIEt9NILJIn7uycAWqcml2ooLwv+55sR7pjA1/3sj
   PB4e84dXWT3iy7vOl5x8yN5Y+OCvYQ7AHINac0VJCsQ2VDb5MHZ4e79CZ
   xMVcLnTK5qoZrsRSSzq5lIz3UHXFFhDWOCBe2zIRmGVAhuBNmt8Loc6HF
   AdxfCYZ0QostzCY8P0HeXXc6dC5u4/Qb438e665fri7n6CLCW0fTLkYWs
   RWu6cg+9Y5RWKkY/T5kikYpHS0X7+u7xKLH1T3O0d9bUmi0kuHKX5D3mh
   2F90Hgh8b0XofsHQz12AuaH5UVxB6i3Mjeik02/oJupmK9evEzD4fGDop
   w==;
X-CSE-ConnectionGUID: qH7sMuzyR6uhdUzVf0SAwA==
X-CSE-MsgGUID: 1tMIbZlFQEClwCJAewhD4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15321193"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="15321193"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 04:46:16 -0700
X-CSE-ConnectionGUID: Z/ZJgtqOQTaTpn3nprt50w==
X-CSE-MsgGUID: nYKkvqC9SkKtuAR8yim68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="44494755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 04:46:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 04:46:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 04:46:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 04:46:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 04:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwfzVLTpovngRK5CXKQ7L4x/IDnC7zLu1+baFtnJjvpQL4Xb5gWm9s6NcDwb7SA5o+9CCTXiGx/j5n5s9rWWDWnN/AOrLkr+bm5wtv9HwQUC3+J6+2qoXu3wt8+0T6qocE7UdSUONs9owcnqFWemILvyU2rRVa0wr5K8nLRXb1gFZMps+m+4UdaoOdqV3yXWQbScvdRWcxd9i5x4XqXq8Bu4WF9NKCTjciS2fJJ+fDhgUkN7mawQRgu+4HNgii1DXItnVfD45pQJGvqeoNKcwm4POUhI8q7c8dj9S9SB3XMsK3SoZugzn9U11MwCPLkwTxppHn+sms2LABy3YVdMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DM/6XN7+k+VsvX3WhFekqXu+kNw2+UtroHarjdMM/Kc=;
 b=Ht87+nqGBeZk9TOup3lDh+iaX+LiSZ5F6MfC7UJQkWXCzY5uY/yTO3wuB+qUNFURCK6bDKRHYY80EPHHq0s9MVoI55b9P9FBF7EXGHsYKGU1Dav+/nSH6YGS3H2fpPK65rlot6Yzpt9jpPjV0Q/vj5EnVufzNMZeu5o6VYLffQCRlu90Pj49t2V7ULIsOiyNz5PtqsxDAMffaIL5i5zeDHvmFBY2ARPFghR8b9mjKllU7L/dli21IYKvsttkXjDhRmjZBSeZCCAIpUU3E3RYi8SEIUW9VeHhefMWeRzP5Ac48INOmtwGfAStPx/JkBPJJT2QO9uspGamArpCyvBfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB8041.namprd11.prod.outlook.com (2603:10b6:806:2ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 11:46:13 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 11:46:13 +0000
Date: Thu, 13 Jun 2024 19:45:57 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Chunxin Zang <spring.cxz@gmail.com>
CC: K Prateek Nayak <kprateek.nayak@amd.com>, <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, Jerry Zhou <zhouchunhua@lixiang.com>, Chunxin Zang
	<zangchunxin@lixiang.com>, Balakumaran Kannan <kumaran.4353@gmail.com>, "Mike
 Galbraith" <efault@gmx.de>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <Zmrb9YlcUAo10TsP@chenyu5-mobl2>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <ZlCyhDspcZQhxlNk@chenyu5-mobl2>
 <06649B84-DA1D-4360-B0C4-79C81A34BC08@gmail.com>
 <cf8fdb86-194b-34c4-f5e8-dd7ddc56d8d9@amd.com>
 <ZmCeBwNO2t2ikrcm@chenyu5-mobl2>
 <CF70ED2D-2566-4CA7-A9BB-E8536F353797@gmail.com>
 <ZmJylkNFg7EFgPmZ@chenyu5-mobl2>
 <9F5C4D69-4238-44DA-9247-5CE8E7B3ECB6@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9F5C4D69-4238-44DA-9247-5CE8E7B3ECB6@gmail.com>
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be80587-303c-4b48-4e89-08dc8b9e6d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|7416008|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?poBPbRZNvcYmvbKj70ZBLSHGpZFTmRvKTmBycIGm3r18a0zLNeF+bbS8LleX?=
 =?us-ascii?Q?LMOTKqmvRa9eMdu270XqmbvOw4CC17lMfYbo7x31MkogfocKvJL/VEXhpy8W?=
 =?us-ascii?Q?MyAFADnjKR38QT1j5QlqYDibSnlOe6UzOWzrtTD1+vaMM/aieLirhNfjMNK0?=
 =?us-ascii?Q?JeyLgzVwMnRS7Iv/Zzk16PHlZxsljJL8THVCDMEpyOPDhXP2hOSlZ0Qi8DBl?=
 =?us-ascii?Q?nllQMobX2P9ZGCPhaBnpekeQ+rohta547P3XvQH4jov9KZF7Df0V5DC4Dp8I?=
 =?us-ascii?Q?GMEaqysus6q92F1vpUI7XL8MLvpXXd5U5N573h490INNhtIYQSkx6ptvEdR6?=
 =?us-ascii?Q?Bi5jWuKAlwpkm6wsN+I3xY4vugHQ17D+KTmv4F4aG0qWN5oono3Rk+ExveJF?=
 =?us-ascii?Q?vDZJoz6n7+b8lKuFo+oWFAdL7fDoEiZTfM4wTMtmGDXwXw275mt7xopz1FEo?=
 =?us-ascii?Q?UA8GOK6eRlZ/IUgSk9xd/d7MktZS9D4m1k81JuNmKsXQgfkbZ2cGGzDV+Twg?=
 =?us-ascii?Q?GL6FcErttOGAnWjizpnQWailcyfk+nupfpwLyJcaYeLf+5qAvZJ+WR7XK1kj?=
 =?us-ascii?Q?3k0wJUgsFTn5CP0PzKGPnLGv4oSoiuPluT3zg8CNcdhBvxI+63ixNU/0LEQr?=
 =?us-ascii?Q?WUDRkzruGNQMx7l5++ISHJm72Rr+kBk/1T2bZuz95k1cuafmxbNgwAge6Jqu?=
 =?us-ascii?Q?yqrH9/Xcgkbq9xCQT0yq7vsT6j0NO3mT2zvb86joxNVTvgkR0cL5lyT9ay1E?=
 =?us-ascii?Q?TYN9RsP6wp15HjEPwuO8fdcZky9VfKgT7CkSEgp8whjiA6DqVrYoDGJ26TXc?=
 =?us-ascii?Q?lPliw8VBLNm2XN/P0iSgw00sba87/HupQ1wky7JKso5iXaodtP41FrI3HKhm?=
 =?us-ascii?Q?qatLnAwN0isizyCQKJ4U1L1ZZnXoGce70FjmVXmAIEJcstGqwI1zYmFGAQsQ?=
 =?us-ascii?Q?26sX8iZL3kvdBKkB2bU1fe7e8d+8d8InjEbwELjhMenEWf1pEK9uaaPQD44n?=
 =?us-ascii?Q?I8aFfhzLVfPa36PPi4VU9VTaaNyjVz6oRi1Ahk7IL5+yxU3KdDMyxa0Wv00C?=
 =?us-ascii?Q?wITLXc17HitaEoDJGLv1LrYvJLnfXwgIK2ITgiGzemCSfNXJ5sA+0CDaN8Gi?=
 =?us-ascii?Q?e4eqXfQWWS+EPERXq8PYeL6At7t8DN2e/L37UTnfRlu2R3zbfDO75bN2kM/U?=
 =?us-ascii?Q?riXrKJfm4oKPPjkOBbx2+2EdHMJsPjRRH+EuPLLSq9Ixa/1wwXF5O1Au8Ad/?=
 =?us-ascii?Q?1PCA0iJw5E9MvyF0E/ZRoJsgUli9gOMkjOke9gcs8mJnfRa732tIcJrJGCDR?=
 =?us-ascii?Q?M8Kakg0AGIyiDqAyXnVk8V0d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(7416008)(366010)(376008)(1800799018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gwiEPkbM4yOBg1Obuw9s2hSDiIf8/d9CdO1/iFBxFctgxt217ckF/abB9D6P?=
 =?us-ascii?Q?PkbkBnDPPnNlQ0XYpHIaxC7D/5jOoNZ/NeBiVzfVU2QuTbPOwYWatiLVqQx1?=
 =?us-ascii?Q?8987lYYaXBHkYICuDSSF4/wVaDcz79pTvT+Pztn5/GZNXIN8erFdsAV4eUp0?=
 =?us-ascii?Q?1u3GelOhWsTSI5i7wpVPYI4ULHMDf4V44PkJDMKLYQf/mr2Fy0ydsaY1AXEl?=
 =?us-ascii?Q?BbYRhCLoYLBsyB8tNU6uFuAGmSN4Vn5ePcvaTFbliMYK9egAXC2IPLDb8wjz?=
 =?us-ascii?Q?HaeeJhMZC7laSJQYT14PN1CfiNBDZEQeYxVJkT8ftWjX+5zbXV1LdUpX/MRF?=
 =?us-ascii?Q?cmoP3omFkRn5ATKpUfVftevla+RA4M7V8O2f0meduy8tL+7LiOn8EDibKnt4?=
 =?us-ascii?Q?Qv+k75kJ8SclvNt8zrIo8j+f0l7MCugQHqj5pwIyoVfBOnvZxmdNc1OjcaHO?=
 =?us-ascii?Q?bg5+rZ152J96XmthVcL9yuRSygO1CUbyu+y83khIfZmE7JLZNBkK7H1WbgQ0?=
 =?us-ascii?Q?Y28x7ucPvASDu07zoZxVyiZRUfSAXxyN4J6MRkyGD/lX5gJYWYY4FCzQ+fqs?=
 =?us-ascii?Q?dzT3hVXMa+Ok38iFxS1Q+Fnaq26hwu0wxMr09yZfbifEbgnzyVAbBrNaO1x4?=
 =?us-ascii?Q?j1FUvrruB9bBjHTu3I4eO3tKoIrNLomq79ak/wE3HzSQ5lzKFErtBopUBgKv?=
 =?us-ascii?Q?oLmw/vPMEHy6SUuqoz40SeAALNY8BnhJ6Yob3Eiwn0zr0DO7TgwmSVKuqZBJ?=
 =?us-ascii?Q?w603HOsiFWAbUq2lXaBZygPgWJVsO1UoN++CVzHavbXv4H18asOEKEo9edWW?=
 =?us-ascii?Q?8t4aW5jLDo183G0Bc0tN2DlgMHsgMsb/UJph4z+J24crvK7lIaDOeLfpajkA?=
 =?us-ascii?Q?qKvm2rXsUj1+QD70LCz8WulBmB7X/pnmYZ8cxtWlfdSGT/dVF1kZ82OPv6+v?=
 =?us-ascii?Q?z0FOnRQirFmp0zUT4pA86X7RARK2Lzeu31SfeFrPk9awx+Wl0bnw73qo6ray?=
 =?us-ascii?Q?DVNjCSzzYcYomNgSg4VmNj1WTCRm3uiE6mHQ0A3NAaWlEUWoFVGDclgSyB2S?=
 =?us-ascii?Q?KBeA0gn1yb3el1bGRV/izd2kTqW5NxGa98VcyBxo5idhGvxsso9L7qh6Lexm?=
 =?us-ascii?Q?wvK4TQVL/qJ70IsTCEUPC7CqsijKKT0feH3NBTbbZtBIbkSCimTLtKSgAFSg?=
 =?us-ascii?Q?Pxx8vf7UfnO5jcVadboYCnrnYqrm1beDmXIPiOxZmnRTlf8/Nv6cXD1ZnuJ6?=
 =?us-ascii?Q?oX8hjGwF0DWZQhpTXILMiaSwRct7OiddJTBwPv/kfYLSinmetGd3FbUrG3fp?=
 =?us-ascii?Q?KCD8xtnEozBWqi52XsqnOxVwc8OuIUt+anD+MSYNLz0Zm+HYiMxQMKWiEImE?=
 =?us-ascii?Q?SPPbrjEZTOTAB9HFfW25CppOFwIWMyfgSXy3mAWFJInv4WpPjLmIAWoyZS+O?=
 =?us-ascii?Q?85EtYeBLC/UkCKkS13NVYEG2bYP37rHIzcMZjol9zd3wMLh8lYsw2O/l1gcD?=
 =?us-ascii?Q?TVZWHksfNAf4qn56ORzxndQdofy2hyg1o/3XmJpxdM9nkFRhcoZ808KWw/ti?=
 =?us-ascii?Q?ClryjyVVSADViOv+G16PmGSofbLnM1bimvacBFFD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be80587-303c-4b48-4e89-08dc8b9e6d1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 11:46:13.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXIWPLhBsq4UYvltUjLqdTaEkaXSMzK03tp94az3mSiMrhP+Aune4RiXpTbdWxFWju1xJKXpUdGy5BfL5dJpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8041
X-OriginatorOrg: intel.com

On 2024-06-11 at 21:10:50 +0800, Chunxin Zang wrote:
> 
> 
> > On Jun 7, 2024, at 10:38, Chen Yu <yu.c.chen@intel.com> wrote:
> > 
> > On 2024-06-06 at 09:46:53 +0800, Chunxin Zang wrote:
> >> 
> >> 
> >>> On Jun 6, 2024, at 01:19, Chen Yu <yu.c.chen@intel.com> wrote:
> >>> 
> >>> 
> >>> Sorry for the late reply and thanks for help clarify this. Yes, this is
> >>> what my previous concern was:
> >>> 1. It does not consider the cgroup and does not check preemption in the same
> >>>  level which is covered by find_matching_se().
> >>> 2. The if (!entity_eligible(cfs_rq, se)) for current is redundant because
> >>>  later pick_eevdf() will check the eligible of current anyway. But
> >>>  as pointed out by Chunxi, his concern is the double-traverse of the rb-tree,
> >>>  I just wonder if we could leverage the cfs_rq->next to store the next
> >>>  candidate, so it can be picked directly in the 2nd pick as a fast path?
> >>>  Something like below untested:
> >>> 
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 8a5b1ae0aa55..f716646d595e 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -8349,7 +8349,7 @@ static void set_next_buddy(struct sched_entity *se)
> >>> static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
> >>> {
> >>>       struct task_struct *curr = rq->curr;
> >>> -       struct sched_entity *se = &curr->se, *pse = &p->se;
> >>> +       struct sched_entity *se = &curr->se, *pse = &p->se, *next;
> >>>       struct cfs_rq *cfs_rq = task_cfs_rq(curr);
> >>>       int cse_is_idle, pse_is_idle;
> >>> 
> >>> @@ -8415,7 +8415,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
> >>>       /*
> >>>        * XXX pick_eevdf(cfs_rq) != se ?
> >>>        */
> >>> -       if (pick_eevdf(cfs_rq) == pse)
> >>> +       next = pick_eevdf(cfs_rq);
> >>> +       if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && next)
> >>> +               set_next_buddy(next);
> >>> +
> >>> +       if (next == pse)
> >>>               goto preempt;
> >>> 
> >>>       return;
> >>> 
> >>> 
> >>> thanks,
> >>> Chenyu
> >> 
> >> Hi Chen
> >> 
> >> First of all, thank you for your patient response. Regarding the issue of avoiding traversing
> >> the RB-tree twice, I initially had two methods in mind. 
> >> 1. Cache the optimal result so that it can be used directly during the second pick_eevdf operation.
> >>  This idea is similar to the one you proposed this time. 
> >> 2. Avoid the pick_eevdf operation as much as possible within 'check_preempt_wakeup_fair.' 
> >>  Because I believe that 'checking whether preemption is necessary' and 'finding the optimal
> >>  process to schedule' are two different things.
> > 
> > I agree, and it seems that in current eevdf implementation the former relies on the latter.
> > 
> >> 'check_preempt_wakeup_fair' is not just to
> >>  check if the newly awakened process should preempt the current process; it can also serve
> >>  as an opportunity to check whether any other processes should preempt the current one,
> >>  thereby improving the real-time performance of the scheduler. Although now in pick_eevdf,
> >>  the legitimacy of 'curr' is also evaluated, if the result returned is not the awakened process,
> >>  then the current process will still not be preempted.
> > 
> > I thought Mike has proposed a patch to deal with this scenario you mentioned above:
> > https://lore.kernel.org/lkml/e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de/
> > 
> > And I suppose you are refering to increase the preemption chance on current rather than reducing
> > the invoke of pick_eevdf() in check_preempt_wakeup_fair().
> 
> Hi chen
> 
> Happy holidays. I believe the modifications here will indeed provide more opportunities for preemption,
> thereby leading to lower scheduling latencies, while also truly reducing calls to pick_eevdf.  It's a win-win situation. :)
> 
> I conducted a test. It involved applying my modifications on top of MIKE PATCH, along with
> adding some statistical counts following your previous method, in order to assess the potential
> benefits of my changes.
>

[snip]
 
> Looking at the results, adding an ineligible check for the se within check_preempt_wakeup_fair
> can prevent 3% of pick_eevdf calls under the RUN_TO_PARITY feature, and in the case of
> NO_RUN_TO_PARITY, it can prevent 30% of pick_eevdf calls. It was also discovered that the
> patch_preempt_only_count is at 0, indicating that all invalid checks for the se are correct.
> 
> It's worth mentioning that under the RUN_TO_PARITY feature, the number of preemptions
> triggered by 'pick_eevdf != se' would be 2.25 times that of the original version, which could
> lead to a series of other performance issues. However, logically speaking, this is indeed reasonable. :(
> 
>

I wonder if we can only do this for NO_RUN_TO_PARITY? That is to say, if RUN_TO_PARITY is enabled,
we do not preempt the current task based on its eligibility in check_preempt_wakeup_fair()
or entity_tick(). Personally I don't have objection to increase the preemption a little bit, however
it seems that we have encountered over-scheduling and that is why RUN_TO_PARITY was introduced,
and RUN_TO_PARITY means "respect the slice" per my understanding.

> > So I think NEXT_BUDDY has more or less reduced the rb-tree scan.
> > 
> > thanks,
> > Chenyu
> 
> I'm not completely sure if my understanding is correct, but NEXT_BUDDY can only cache the process
> that has been woken up; it doesn't necessarily correspond to the result returned by pick_eevdf.  Furthermore,
> even if it does cache the result returned by pick_eevdf, by the time the next scheduling occurs, due to
> other processes enqueing or dequeuing, it might not be the result picked by pick_eevdf at that moment.
> Hence, it's a 'best effort' approach, and therefore, its impact on scheduling latency may vary depending
> on the use case.
>

That is true, currently the NEXT_BUDDY is set to the wakee if it is eligible, not mean it is the best
candidate in the tree. I think it is 'best effort' to reduce the wakeup latency rather than fairness.

thanks,
Chenyu

