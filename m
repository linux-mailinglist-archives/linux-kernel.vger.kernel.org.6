Return-Path: <linux-kernel+bounces-318344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4996EC11
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D64D1F23E36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309914D71E;
	Fri,  6 Sep 2024 07:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnNDVYKE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995514AD3A;
	Fri,  6 Sep 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608152; cv=fail; b=p/rPFjAeqD+ZPzcTXWp0X01PDSU2RRahNM4O2u/a6hsydcZM01C6wtWP99CpIJP7pzKDYiQB7j4GGvx3jmMrBFuBf0vyEwnnJ2xkPu/vzzCslK8BGharpZQIYhHePfI4Wb8F/uIwdMWdmtIDsy9kPelXizin4dFd78josai/aV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608152; c=relaxed/simple;
	bh=wrX3+BMDelQJBeRnSrmbW/yfyCK2f+ElMqS5NV7HPkc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fY57Mv2mCaKW5VP9YDAk0FyiPvOM1/bdqjmb/EahLsI/lD4VmOB6a3p5pqriXnwLvTIFmyFTYWtVSTIFzR1ILi8mGj0mHl9Q4DfA4hJWDeoECsd+ZF+jzZMnDUHWbR9Vtjnt+TP27xjz5mL4RyMqENi6qGu6elnYTgidU7lF6sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnNDVYKE; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725608150; x=1757144150;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wrX3+BMDelQJBeRnSrmbW/yfyCK2f+ElMqS5NV7HPkc=;
  b=ZnNDVYKEvQThy+rLuDd1tidGFA2fz2LKwjN/GspqzsSeOXoTG27PEZsc
   qWzBhWTb0HNDm6qe2JB1D4KAe64ZDXEddQDssAWQ1jCz24ODbHQmaVUAh
   LK9xjmzCcbwhdKowOoq9ZcvM5PgZfsy76X2cVvELK/B/nwJqrITyqu238
   GgLAK3eI5+eTgvcboZskVltmOzqo75KDX4kaUDCJXx5iUWbi6E3vCnn0R
   VwdyiRlDofbQSsqEVlXvgAkS7n/WXsv0k7GwK3gfHAfAfrWNlDW4Ah3Nc
   yEhN/+6xn7hlv8fxHVZeIGdSKDHiJtXjzWhY+rd89RIQKqxMunyg4SNeV
   g==;
X-CSE-ConnectionGUID: deo4A9cyQUexw/z+XWM92Q==
X-CSE-MsgGUID: UlzwI+lpQdiGml2/7fXRsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="23916495"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="23916495"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 00:35:49 -0700
X-CSE-ConnectionGUID: QZN72MlnQ8C4uKqFhUTYWw==
X-CSE-MsgGUID: oQkd+dXQSR2q665PRBP2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="96659994"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2024 00:35:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 00:35:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 00:35:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 00:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkhG7IuM+7bhxOk6OHmAat3ucKmy0U62xsIWFtrwfzNPc0m3nPBAQGcBa2U3gk6UXUJ+m9RAAl29eR2iz0gV/NqpT6bo9//QvXnewE1HXOqrwxp5aiP+IqiZowPDhlf1YH8gDLKf8+95E8wBQkdvWgrmOApLMu9sSvLq9z6DV26i054W6+JBouAGOauKKEQQvdtJOC+Zgdv/E8yacL9Z09YZQKZqgs1fGIyMbNMJwEaNhFsXLtKlVNKDQjeTBBMoTHe2ZZVq/oAgTRMdInNf5cUo75i8MagzCCOVTH4EYTCuFw2UIZ5dF9fobHBIKq8a3k53RAfN4wsHytJw7Aqlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99E+IXQ6ZjiFuvb5Xuqsb1Mps1tA2ODRwYss1Nl/9so=;
 b=W/E265YSqHxuquArR2i9ZhjHSdutXRGL04gx/1cdo9kU9V7/JeN2hiQXFEEftMiwBEGtaPdxCdiXqYUKH2rNG9eLP08TCBNlJDsD7zN4PBl7DdFxwHk70RW8em+tTSJWh09irA0SRw0BygX9JUnleWP4u9pX5pkWcDb8E5KhV/qeHl7Ga/u7TJN6KJLCh/DuaTmlzNelsexNb58noiTsmL/QSF/dVO0EfOQoBoUZDIGnuud0cT2kXp7qR7d1DGC5Y6hT94RfQ4pvi3KuS729w/1cXxibWHWwN6LAlbmuN30GlCMT4vsiSi6BxbzHNeY/X8T/gVv6DJmA8RkHUQQyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA1PR11MB7294.namprd11.prod.outlook.com (2603:10b6:208:429::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 07:35:46 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 07:35:46 +0000
Date: Fri, 6 Sep 2024 15:35:31 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Danilo Krummrich <dakr@kernel.org>, "cl@linux.com" <cl@linux.com>,
	"penberg@kernel.org" <penberg@kernel.org>, "rientjes@google.com"
	<rientjes@google.com>, "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>, "42.hyeyoo@gmail.com"
	<42.hyeyoo@gmail.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"hch@infradead.org" <hch@infradead.org>, "kees@kernel.org" <kees@kernel.org>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "wedsonaf@gmail.com"
	<wedsonaf@gmail.com>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "chandan.babu@oracle.com"
	<chandan.babu@oracle.com>, "christian.koenig@amd.com"
	<christian.koenig@amd.com>, "maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <Ztqww1HBGpopK5kW@feng-clx.sh.intel.com>
References: <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz>
 <ZqQBjjtPXeErPsva@cassiopeiae>
 <ZqfomPVr7PadY8Et@cassiopeiae>
 <ZqhDXkFNaN_Cx11e@cassiopeiae>
 <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz>
 <ZtUWmmXRo+pDMmDY@feng-clx.sh.intel.com>
 <ZtVjhfITqhKJwqI2@feng-clx.sh.intel.com>
 <ec7bca4c-e77c-4c5b-9f52-33429e13731f@suse.cz>
 <ZtaAGCd/VlUucv6c@feng-clx.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZtaAGCd/VlUucv6c@feng-clx.sh.intel.com>
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA1PR11MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: f077595e-006b-4607-b57d-08dcce468536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?84dDXqUo8oS0Rr6s0SKBWQ61gw/LjKdZLFdrmtpNPj+d1HhplZxN/m+cIxmK?=
 =?us-ascii?Q?MVhr2PvORp7rDHFVR6Nju6C5hWWR/vYE0TmGqA6Sp7Z4urt7V1haJaMQIGaZ?=
 =?us-ascii?Q?V57IIquo1gqYdEpqGTRVIeCVHyWsSx6vZhalCeGiCvSXDTsCv7P6OYbn+StP?=
 =?us-ascii?Q?65kkdcCxrh0jMxOXH6DS//fxrsBkq30/Ei7uSNniYQQ1gCtcDwi3CnSKo78U?=
 =?us-ascii?Q?FI2WHXN/gWluxu8lu7au37MJDpG0Yr+wkJ0vzB4TEQ7+GASkOCFxokQhXuTY?=
 =?us-ascii?Q?h3zk1e+bTWOCJJw8YFiuikVR/1K8aA9QvWzGJYlyYy/WBGLcjoxvissjQ3Sb?=
 =?us-ascii?Q?R1V/uPjghiUspQ1okpflqj9CnEaMo0Q+lC8EEuHAHsbnr4tj4XMbkqoWeaKq?=
 =?us-ascii?Q?e1ak0mOrgMvXZ3K8y/0LBNvx9Olhz5BWq3dRE9h4qrZzWml5qzxn7sZioQpo?=
 =?us-ascii?Q?jDI0RdJ6fpgcsh+fLyvJpOd64uZBLeCIojOJr5vpTPfk0742cMQPAwltSmqy?=
 =?us-ascii?Q?lzKygToHnyqNK02r2DAqfYRaNeR/bI6RzH3s9IKkZaVrPSg6RejRUYeBqZpM?=
 =?us-ascii?Q?W5ZnOGs54ylakecsTEAHCPXwZK33mAn7ojT2l+TWK2x2MUGPImYkZdEmzJKq?=
 =?us-ascii?Q?IH1F+qS6GgFhLOKKvgfRVpHGg33/b1vqrOHkZEaH/e1ctUWrIo00V9UJFip4?=
 =?us-ascii?Q?t3xLi5UC4ENCW6rgEgYegnz06XUwrBW1bOkT1QX9wT7jNo0GJ276UV7pBmbb?=
 =?us-ascii?Q?bzyrh0uxQtB/cAA3V3Sh4/pkwZvdjV98KScIDPBgnxuE9UQdL/VS6pXU3ZSq?=
 =?us-ascii?Q?nGm2L6LKatkobUxQPNlWWCwDHbBHCJ/2H0n6q2YV9kmda9lMhX3RXxwk0vQa?=
 =?us-ascii?Q?6bZhxeblY+RVoB1wpqXygSqohHN2iClR7yZMTVPeeEIFPC1mfb9PceCq8t4P?=
 =?us-ascii?Q?BQKYzzzVBvLzXaOEQCwU1rVpspZzz9tJcVqpCZZvARvHqA+Ro5GDM7D/7AKX?=
 =?us-ascii?Q?yLubUcP0/e9DpGd6LWzA/qQsO22ygMyIHVQ0beoEVnz4bs3DqiLP7/Rey6NW?=
 =?us-ascii?Q?dIXcEZ+61kf51L4bTgPlb4Y/OV5FrqBiFe9hJBaY5V5hqYlbKSOar22PlRPN?=
 =?us-ascii?Q?myZta36ZoZksaMss6TcKmxkCZ58J2G2x+9svgw1Vv+7u9I2KFhmXjury7DQw?=
 =?us-ascii?Q?Z5WC4IgWeayekWLTo5j2zYaiqn0p2dVlnavCfRTb6WF0KuonfjEMbazaDn+y?=
 =?us-ascii?Q?74E1T//iE5STnvQcUAV3mmgnHhbr7zYSjQWmJpGdEDBuccZ6688vUg9Mo48v?=
 =?us-ascii?Q?4F/GAcIJ49DNmelFP81DRaohpf37CHGD0Rlty5MYjKoOvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+CFNzlkgSgY3EKIG8xkjzNmHtD9BKD0tlPiYuxmz9cakwSoyWvJBZe3E7Ko?=
 =?us-ascii?Q?n5Tiu11pl+EJcsKSw/MixCJX+70L31Tj46Nql2PL1BQJQPRY2EnwLxEoUCaJ?=
 =?us-ascii?Q?p7einD5AQtUTDpZ0jexASDPGANsIBqHpWAbSyZXqlkCXGb4TCQegeKtkrg3o?=
 =?us-ascii?Q?RyCfbmFW3oM+paJEUCwJGJZP+WG5u+evHScYd6F9EnLYlm7IqhbchLgZKKB7?=
 =?us-ascii?Q?bxAmGe52a84mHalSce0G5ci25A6gVO6TX0nELQ8pit0MJqy1yV6PeFc4ITQg?=
 =?us-ascii?Q?c4/FJi41JwtUT9YnK7ghLOHMuQd3rTqoNsZ4r92TonnsRUTuM6o+YI0hrPtk?=
 =?us-ascii?Q?RXsS3EWZXUE0pJsnNX6E1zYHPXIVeJST074heQYBuNLJKRfoxJPl87EGkAbS?=
 =?us-ascii?Q?N03L02pev9mr3o3sBLmeYMUM0y9r/pC1IZ7Xen30ei4zC4nSzY0nlaCg0UOC?=
 =?us-ascii?Q?xCLX6SXZxF+a1wWBSntWb17qwjwKYoRbJvSVU4kvT8VEXcYcvuInfj88HmKj?=
 =?us-ascii?Q?7i7EvmVFwGRS7i0TEGlkJ/BdZtKbEedLELkA/5atqcaQ4H87EvFtBUyYEEXE?=
 =?us-ascii?Q?xWBfuuVGL2rXIQDwivNTkmlA0qSrzj2/cCjdrUL0z6qMA+1+U4ExdMy9Ssre?=
 =?us-ascii?Q?BgHJCP+t0Y2dM82EIlf8ngNEUP31sJPSaTn2FDdd1v2W7vcs5WlLu0DrfwBD?=
 =?us-ascii?Q?kny2+YcLv+HkhZzoOYiGeke3c5s6Wgqfd1CnwS10DqV6ukwfR9Ol9Ubm23iD?=
 =?us-ascii?Q?Xkz1rzmwqn4o5OQFUmcH6NKGp4ECpZL/Eys/7U+XkPCULV7yotSHM4cOH/4j?=
 =?us-ascii?Q?O/jaeMt5jZ4FMIGOsXuV6B0MIMQ56jV/UDZulyVJdn4/EP85hlCos1WM/aKh?=
 =?us-ascii?Q?ZcR8Zt6zd6hUc2uskTQiSb1JIdJ7V5DXO3BAsZCs4kIHPlgPQ8MPzlYzzIaz?=
 =?us-ascii?Q?EBTSY12GI07u3pisluM5hLgAS8aUTzXooSU1W21FMpmHjJ93yU7xLsNzbLAH?=
 =?us-ascii?Q?XE5bf9qeWakxQiYdm5W1YW3w+V/maStD0xcoWoNt7IGYxtpNz+fzyg1kB6+L?=
 =?us-ascii?Q?j/opT0BFxZwz1lVt5sEjw4Ft3OeebQBq5ho+4VOqLKF1jz1DTbT8oH0KVclV?=
 =?us-ascii?Q?z8gbQ2Qqtghk+TOJ4HM1D9fiP+tZEFr0n1JXJ0f8v3NCB7HTpKn+a8qijmVu?=
 =?us-ascii?Q?zm2voW+astVItxJR8ByyTjSh3ZkPgam16hVHQ4WS95RLRgab8zxRGNGcg+0l?=
 =?us-ascii?Q?ixS4Fl8jdQVPgGz/6/Os2wqrW/fDZ2wlDsTqWR4w0VK7EV6CkipT4/VngOtV?=
 =?us-ascii?Q?A6wqBZ4AuUa+G/GCRqpGOvhhtorWWkU0yameSyR4nR+O/1ivY8pyP+T5bTCK?=
 =?us-ascii?Q?g4lKAFjb5ZicfcNoYU2os5PpSUin+rD/GTOligiAZPha2ss4w8teFXh+XB7m?=
 =?us-ascii?Q?fA7PwPnQq1FyRvC671CAaewMoKyZTgquSsBcW7lpVyfVUO4SRQSYSfV6CgMc?=
 =?us-ascii?Q?dRWdxRjRgyvv/TXxW7Z5b4ckM1qSXy9eK8avJPXCCOepzqIsVk+nk5tMp2Po?=
 =?us-ascii?Q?1MRd8cm6/Zz5ouGyRLbFn8HcmPA6kEmyR2ht681n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f077595e-006b-4607-b57d-08dcce468536
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 07:35:46.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4qqlPp70jLMDt/7NwBashU7IIXbWlSoHtwk+hE5vMWbkqWQQ5bPTl0Tsv33QaHX2qAZ63oY/VcD2oQOTOR0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7294
X-OriginatorOrg: intel.com

On Tue, Sep 03, 2024 at 11:18:48AM +0800, Tang, Feng wrote:
> On Mon, Sep 02, 2024 at 10:56:57AM +0200, Vlastimil Babka wrote:
[...]
> > > If we really want to make [37, 48] to be zeroed too, we can lift the
> > > get_orig_size() from slub.c to slab_common.c and use it as the start
> > > of zeroing in krealloc().
> > 
> > Or maybe just move krealloc() to mm/slub.c so there are no unnecessary calls
> > between the files.
> > 
> > We should also set a new orig_size in cases we are shrinking or enlarging
> > within same object (i.e. 48->40 or 48->64). In case of shrinking, we also
> > might need to redzone the shrinked area (i.e. [40, 48]) or later checks will
> > fail.  But if the current object is from kfence, then probably not do any of
> > this... sigh this gets complicated. And really we need kunit tests for all
> > the scenarios :/
> 
> Good point! will think about and try to implement it to ensure the
> orig_size and kmalloc-redzone check setting is kept. 

I checked this, and as you mentioned, there is some kfence and kasan stuff
which needs to be handled to manage the 'orig_size'. As this work depends
on patches in both -slab tree and -mm tree, will base it againt linux-next
tree and send out the patches for review soon.

Thanks,
Feng

