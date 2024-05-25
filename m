Return-Path: <linux-kernel+bounces-189307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DB8CEE37
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B26F1F21ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 08:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322C14294;
	Sat, 25 May 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IS3Ja0jc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85EFD29B
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716624528; cv=fail; b=QkzRaerMk1lrIK6M7szkTkhQB3MaJewTqfC7Ckr1R1gNSEJn3HsbiLGADZ2EmsIozZ5odAEaKY7MVYmz3Juuu2yHj191YAOA7KsianGiUdFnDZQe7WLKwDqe4cucpSflNGUKx3XNE1dZtsZdhcSTcY02eJ3MQZiTHkZ41aoAFPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716624528; c=relaxed/simple;
	bh=P7ZO8ylmuDGwojgerwKSjVCNqtfHmsFynsBIbDibKBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G1SvN9molulTx+gmzo1Cn8brBBRLvf2SjV+36WcIigMLN/YB2H1O3ICktB1p0bl720on1kznPnzEG4jYqjni2Q3K/t6ULLmHrET6pk+RqwhEwyAjEAbUgiVUEjw4gVwsmX6YhUBviaZgc1I778nt8LmwB5H+LU2soQeckSZhei0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IS3Ja0jc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716624526; x=1748160526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P7ZO8ylmuDGwojgerwKSjVCNqtfHmsFynsBIbDibKBc=;
  b=IS3Ja0jcl7JML2f9RmKUdI428/0DT9yNQEB72SszfyPHfmrg4EUagiie
   Sf0Plv0cTlcctR08RAbBiZeBlpyqHFif5n+ipQefVSsyonncZ6QtRTt+O
   r5dOBg9fF528vqu1lKQwKQp76d0/rqfssYuNxYuNtUjtpkbZA7iHt7eZB
   5DvxHwnDfD03BktdLwqp8htM/nEPsTGEAfTbM184GQGb20ipY95DRzc9F
   moYR9zW9OJt45PuSDPJmx+eulzjpnleDFbWPPd6MuSqw83myskW/raSHS
   kdKvSSaUW5bUZrS9CCJ2dfUOMZIENWyE6JXjh6z44VmjQg0L3Rsmp++jp
   Q==;
X-CSE-ConnectionGUID: cOtkzJrYQ8Ohkv2GbqvR4Q==
X-CSE-MsgGUID: UFfKQBhaSNqnQOjtp6ID3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="30536107"
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="30536107"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 01:08:45 -0700
X-CSE-ConnectionGUID: OUkIlfYKSN67tcpZAJluGg==
X-CSE-MsgGUID: 0/uEpS+/T0O71lHpP1kyQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="34257686"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 May 2024 01:08:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 25 May 2024 01:08:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 25 May 2024 01:08:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 25 May 2024 01:08:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 25 May 2024 01:08:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avEpXal3OpjmYub1zI1oA2XDkgQTa3mJeptbyjGeob5Nhfpm4H0UbvzDOFujzhsnOMHLHS7zN9WRf3Zwc4FwvETAJ4DMz9BcNoKaY4tlCYW8A62OKMt3GIfg4UxRpjVYm6HdDH/Fl5770R+8AVoB3YxAFlX22v/9F7w/gM8GZw/Ny88oWh2rLjs8Acv152aM40edbollW4UUT47wuM7JD2ywM188LABL6P2ZMxXTUNMOfx33JHHLQqLriz7XtWug610XDOcgpOsu7LIcGtKplMXQyIMl9zAY/3bpPrv8nUyY2HmnQH29tx94rhrSSUPa3guSgMang6NahazJh6HF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZUfyxPEqCusX+RnRdXHK6un5dp5fgl92JNkxIA9oY0=;
 b=HHgKgC2AmoO9SAAYOo3iqmg6q9wAN9SezHyzmuI8nFXQ4RWJGKVNOmG4gDp1kW1tNiALIqRBVjjuruFagVu6HLbfp2dVvLH3f8FtGgVC1hp5UhsJNMShqj67TSh2So9EugPQxhNv8SA1NoGKmhPht0PDdnli/NX+nl4grPiscTq8HSxVnGmhC+qkQZ7PjRcSnavC0M5xYwHXMOttFQj8OUsn0ydEJnhFwHXlUZzCxSaqfY+I6j9WGU2l05uTVxXNwLZEqxyRiVu4GM3em1c1oCu/bFVjfe7lRyk5imQmIgCX4xZoDrQOzRns4F7/T3364rdrIQaScFtTZsY8FozhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
 by SN7PR11MB7440.namprd11.prod.outlook.com (2603:10b6:806:340::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Sat, 25 May
 2024 08:08:37 +0000
Received: from SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690]) by SN6PR11MB3230.namprd11.prod.outlook.com
 ([fe80::c2dd:7cf8:6008:b690%4]) with mapi id 15.20.7611.025; Sat, 25 May 2024
 08:08:37 +0000
Date: Sat, 25 May 2024 16:08:28 +0800
From: Philip Li <philip.li@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: kernel test robot <lkp@intel.com>, Suren Baghdasaryan <surenb@google.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Linux Memory Management List
	<linux-mm@kvack.org>
Subject: Re: include/asm-generic/percpu.h:31:40: error: implicit declaration
 of function 'raw_smp_processor_id'
Message-ID: <ZlGcfHD3ZCNKWDdr@rli9-mobl>
References: <202405210052.DIrMXJNz-lkp@intel.com>
 <d5ldg2u6kqgpiv7p42al7yp7zn2bpd3qrwmv76ccmzbvw5ag6x@enbx3xdtry4s>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5ldg2u6kqgpiv7p42al7yp7zn2bpd3qrwmv76ccmzbvw5ag6x@enbx3xdtry4s>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To SN6PR11MB3230.namprd11.prod.outlook.com (2603:10b6:805:b8::29)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3230:EE_|SN7PR11MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 136d22a5-d003-484e-0541-08dc7c91e11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YFV5wtaeejM4NRcB14zicu5fgSgLuMMWmlwOJb+xIXNnZQw8kKYlSfFZJ3ni?=
 =?us-ascii?Q?k/3HRS3V5q7uodKoBB5xDE89kS9Pky+03QO4phJ+Ybo/0XUHw3+upoxDRCgW?=
 =?us-ascii?Q?d/f5x2G3lynNb7YAnPchIB7TdDyLBPwVaIJrJCM2LR1XG3lsVz3mYbFAAD8I?=
 =?us-ascii?Q?DV1wUMTizU3heGPhHUfJYf1zJlcOkTCYS+rk6OVRH8vros89oq8KHtgYobeH?=
 =?us-ascii?Q?dCkSwXTuN65PRRDmWzpgCLABn3w/sUNG1ma5+dlRpIJ7H1DDOFc4s4zcaZ2l?=
 =?us-ascii?Q?9JhV9PDTEhQZIwWvCpo/v6BZTYhdsI/Mu/NoIYQHk/TIMQewn48C0HJxXjFW?=
 =?us-ascii?Q?do76/YLUisB8nu7oOXkKS8VaNcLPraC1npq1qZ89jgMNgNkYj4DO3tyMeN01?=
 =?us-ascii?Q?fhlnY49bex9GFFpE9w1tD5QGIt5q6BkeOYG+z9OYnwSvJ8Jz782IpK9LneWU?=
 =?us-ascii?Q?B6QIoWfZbwycEWf1si/F0oDYEztbPjVEylfhLQqLVnApM/+uWY4cjwJXjCg8?=
 =?us-ascii?Q?xQisadFcINunbK7S8rwhVfuVqFpDY80Rmwbt6oTFvPQruzQb5bmRosb6lwfj?=
 =?us-ascii?Q?GKstftFP+KrY1jd37N0D+YanuJyYUIUaR7FMMwjg9sG+RUySrvownhDMADyJ?=
 =?us-ascii?Q?1QtTJRXhST5zmpx3wWYi9mroOjv6BCV5EwUrpTkM4zFWRqx+W/+04MSKJkp7?=
 =?us-ascii?Q?nWXjgaVIYB0VjBPx7Sw8QPj7C6SecnrfywwUutR/rnKik1nUhCIO/SC0WHL3?=
 =?us-ascii?Q?HUS2DzK5DibLAEuN6khOK0XIYNpSlgWXI/njm8qA4YCvHdjlWymkLxk7uZRJ?=
 =?us-ascii?Q?qMzt4Cp+FFTK0lJWR6tv4a54jsHkZUMCDns8zb/R5djYnv9vwTZXjBECFYhL?=
 =?us-ascii?Q?fwVpZkLbxyTDp2SC9WMxWHosTUR17vpXbxr9fO153/THylrBJQ3rZiAMA2ax?=
 =?us-ascii?Q?bcQSAABPMPYiuihdeM0i9Ey6qnIqNjTNMLNEXNYM47PjWlsKPcb3XKZiYMQl?=
 =?us-ascii?Q?fmwZU/qoK0q373eLqt7AsNwK+X18QhzZtOZ2lF6vE+Cxj3w6E5FtFoBcNG0Z?=
 =?us-ascii?Q?IastoZaoFTT6s/4hiWfDx9a5whcTFbrTU5wngHmhWImMs6ygLGdavBLYyd6g?=
 =?us-ascii?Q?cICHGV3G3LZon/PfT7jBXuw+zjypRI15o/zdZ5BzO5+65yZ+qoLMjr9zurB7?=
 =?us-ascii?Q?LRO9VEbaFATs+LA/Qhb3ElsBLnwdU9UhsPA8G1KwdFuWymzY93wHBft2Yu4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnCfunA8RnSDPV0vD+QR0MMr49lcEO7P4jm2oHdR8Ak31ESvUcZLEMEsFfSm?=
 =?us-ascii?Q?AWBdDCnRdj8TA7wXnMvemEd3dSEVqrI8vvJ78v96dJ0ZtGrUl+B9g7tLR1WP?=
 =?us-ascii?Q?kGHi8bevp+yPR/LQssZhUY6XW5tCFic0HCuVxrnPJoYffjZhYX5zjsfxH0Fw?=
 =?us-ascii?Q?9rZJoG0Pstj759ZgQIqDEsGENW39dxAeRZZvjEme8mYXrVGh3jBWRHF020nD?=
 =?us-ascii?Q?HsmRYdKuzSwDGKomiF+wz8J9t9NoRKr09Cjr/5bJ2Wl/pgvSMYMMkk0yqd3Z?=
 =?us-ascii?Q?CaVuZ8salaqwFXM4MT10nF5FVXl6fRU6M64/y03GUzl0BDKigrvBpUqfEKsU?=
 =?us-ascii?Q?0e29ig7J8RuTktTGlL/pFbIjC7jBxGGytkG24mnFDPLVlutiYo8NU5r8d96Q?=
 =?us-ascii?Q?xJBjlSVFd9oBRsDx29pP3hx9F7oY1AHJqZttnUorplkSKK8KFG0NpAvz8A63?=
 =?us-ascii?Q?9kQFAxDBptgUog+Pe7GECIq1A9FXXbkN+5wVlReuiejbJOarRCfLiTQxXIuT?=
 =?us-ascii?Q?5+2aINvnwOEHs4BX4vZ1wMkFbWRP0SG37bLhq/hYtUo1a6W3NxYuZTt7dvzc?=
 =?us-ascii?Q?6WkbLmMgjfxFeSm1CRHdSRx9FaBvJ+3E6Lna8X1WWC7UvGiH0NGAo29Cb8cV?=
 =?us-ascii?Q?nZ6tgbRYIErLz0Anp3Y3f2YsaNs5ROrvGyuHCIbb2/0/GChAoBxwg7m0MVI+?=
 =?us-ascii?Q?VykCZ2l109wnZ5SD9C5GHswEpLA+Iv4b6TaPueHVqOpjqFOK2VCTMQik20VK?=
 =?us-ascii?Q?jgVx7+CFjwG+RtvBIwCdsQbSrUQ/AaWHKbJP75LYCAol+Ot1xrFpNO3ZJoLD?=
 =?us-ascii?Q?j5+mNyuXvyOFUEj7LqV1Vnp3c8g9BP/yIrQp3ETAgjnPzuHo28A8/i7Uu9Sw?=
 =?us-ascii?Q?WRKoxxsPnNkp8VceqHimDYaSCiAfxaGJiQnLOWrKDooJARtc7DE2q09sNjaL?=
 =?us-ascii?Q?3+3s/2eizXdosm+wIQZ8ni2iY/bql1qvtL800fX3ZmCnl5n9CTttsUia0dN1?=
 =?us-ascii?Q?vi69rDG+4Exuz5kx9fmup7qltoMZhwn4mJrnaN03/ymNbf2P3vqnSvyXWFEf?=
 =?us-ascii?Q?vJgtQwebYtxQmn+WrBSbv8Zxh0g+TowqEPyIZrp+iHRZv4+V4ziE93RPouZD?=
 =?us-ascii?Q?710movYWVQo61WGtMvf0GZzRe95fjVmqQgFVd25EwuPhLpH/ea8AMHMhthch?=
 =?us-ascii?Q?KP5KXDRgJPoztMIIzUPYUJ9tjqu7rB35MTuGg9J7X6ysjXGR0eTKtT8fFNIB?=
 =?us-ascii?Q?FQ5SxoA1cCeBDwPmhGfBTeXWrc9tw9y2/8p0jOSBuXBK9Ikt++FwQLOqWVQj?=
 =?us-ascii?Q?gAOKDK5fUFcsMlMXFX5g65FAAe+H9q1/ZtBOAOyCOMboyVjQcEAmWj0/3Sox?=
 =?us-ascii?Q?mKtjFvYpsYBBIev1+CZ+iVYbFgQCY7xUACT+2mnURLro9/lZaZjpnJMjWr/R?=
 =?us-ascii?Q?6MI4WiQf5u4YBfOphekuMFzump1lLtz7jib3YAf9ae3BIhD2dIldnzlCD4Wq?=
 =?us-ascii?Q?7bXbdd8WJReYr6degF/jr/+bnQDFFgKhtvkRTD76v/pq+aArbdes4MTBzBGO?=
 =?us-ascii?Q?VCAvcXc0oOhTH+hVIBVqvn+XMs21npqnEqpkassA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 136d22a5-d003-484e-0541-08dc7c91e11d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 08:08:37.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z05pXrwIId+3TsR9yA+N2uAaw2gqgxq8mANFqFW+ijM9MJT7P9h5887sNSGdmP3y1l6i4LVfgSSDF8335KGOAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7440
X-OriginatorOrg: intel.com

On Fri, May 24, 2024 at 11:58:30AM -0400, Kent Overstreet wrote:
> On Tue, May 21, 2024 at 12:31:18AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   eb6a9339efeb6f3d2b5c86fdf2382cdc293eca2c
> > commit: 24e44cc22aa3112082f2ee23137d048c73ca96d5 mm: percpu: enable per-cpu allocation tagging
> > date:   4 weeks ago
> > config: mips-randconfig-r133-20240520 (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/config)
> > compiler: mips-linux-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405210052.DIrMXJNz-lkp@intel.com/
> 
> I have a fix I'm testing for this but it's going to need a lot of
> randconfig build testing on all archs.
> 
> Philip, could 0day help out with that? I don't know how you schedule

Got it, we will cover this branch with randconfig build tests.

> which branches for which testing, and previously the memory allocation
> profiling didn't get enough build testing before Andrew merged it.

Sorry about this, we really need extend the test number to generate
more randconfigs.

> 
> Running my own build testing now, of course...
> 
> https://evilpiepirate.org/git/bcachefs.git fix_missing_include

