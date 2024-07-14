Return-Path: <linux-kernel+bounces-251810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C33930A26
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC38281282
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE00132103;
	Sun, 14 Jul 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/xel3if"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEF481AB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964084; cv=fail; b=CK3QRv6Ru2vKlb6MDA/1EB4GWWv/4P4ffChpW6NXwsPhkgoFyesb/n86NP+B6lfYOEqdYr8xOabdBc01a81tYOc9EpWaLaE5Pm1tv5bajaD6d7liSbov5+JLhhEYBI1FB9Jb+UeyqmjdYw7RyIOiAgfjQs21gqTqXVmeg0Dw1mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964084; c=relaxed/simple;
	bh=aZWiKCLDM4XAj5IDBk/L22ICIxl07tHrX4nBwdrvSOk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bMwpVZ6+miLHuFJ3DRJmyz+N6QnkEFW5kJl0AbcrrOATvY1LmmlbM/4FIjDDJZYFoGm6/K2xX5Dv55tAIfc7mZ27eEyBxiKScY4+L8Zj+WPo8IgQGUxJJhQQlsjB2B2rdwIAHwExGMXKic+P0I+zsOJxVC1OSKUIapUpV65KwOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/xel3if; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720964081; x=1752500081;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=aZWiKCLDM4XAj5IDBk/L22ICIxl07tHrX4nBwdrvSOk=;
  b=n/xel3if3digIPmkGT4Q4MXrmsIAGxo1WJYW++FMuDk9A2/5hobXNaQ4
   /1M3cPV8xfFpSN+fzL4DCOMpyYejO48gmhMXHsgVFkB4gYA1yxu8UxKqv
   WsL266ArtwzdwU3Csv7/EY8yEv1yrE8xZdh+TdyvV4yk5G3QUMvvSnL3P
   xZyPzCVf/1aUSzZss/EmBkpeyBTBjwpxmhlRsnfkGSi+3QTxwHMsjV0nA
   TCLbFJCNQFTnLO7ndXZLf7rTb8YsSwtxBskna8YnNYomqqSZUe9rzaNeU
   XooJ33+omz4q7lf++p/HaxokmsHqVPxzpfpSITBBsgivHQph9oqkk8IXz
   g==;
X-CSE-ConnectionGUID: +1PrBuZWQkS2VOwAMR+f+Q==
X-CSE-MsgGUID: vXG9O5XuSxeImDPwDvW3Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18301280"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="18301280"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 06:34:40 -0700
X-CSE-ConnectionGUID: WOV4GjNkSaSlOB3Hr2v/5A==
X-CSE-MsgGUID: UnURKfM1T5ynGO6jz1Z9FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="72590158"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 06:34:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 06:34:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 06:34:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 06:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZsStgxLH5rWe5mLM4ygT6WvBqBsrm/01TNDs1G5XYt8XzxZBUU13BAqKbwX2BLa1010KGx6WKB3Rqf1rz/aogKaydsA3U0NKdvicV3tjguf9DwfI1dcw6mFF16tLa5WsN4MNrsV5CbrJ4UTuAFNKg6YAZ3ogajxfbb1y4Iw4RkJEkPU86IGIeuDBO508phInI1TVHF/1lrwHOVLSFPj4Q32UdEZMqnwHEyrAjqqpBPSvhjYK9pchrdrhEQH6K/oPnTqmOz6+3K0PVhmxKWnu2HLMX00T0hiX8z2qTMcbnh1vqspFUUnCyt42K6PTvCImiK+seUI7FCuEccPVayw7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fybqt7EUm7Yf6MMr5Fik+X4EcyuNU9xUvsp1gYbaKU=;
 b=a/8jb8/WxMQYOQy+JDVpW1SgcvMUGWnkKPQRVtY3TF3ju/cEhBCLAhQSErwI/AE5dKbKIgKvbPiBstoKqOXJLr8/wIAqCTtlUDoBoIGMu5LI6xG2L41R7HJIUNlNCdxalikq5IOc7/CRubMBqBpCFh20IL59HucgZgQxCyftHd4cEdEBBu3jC9rqedp7IjDAn8d0wPGJMsAFJn0Or3IZI9sN4xR0mofm9joBToTqQ9Hl+q+op4D7nEJOSUd0T+IgJJ8yAC/xB3ZR4MOQUorTJvOHzs8+cImZ65ngVyMoz9m33cfpfFbAwJ1aQyrB84y+gh011z/ErZFz+UCG1GBTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sun, 14 Jul
 2024 13:34:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 13:34:35 +0000
Date: Sun, 14 Jul 2024 21:34:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Oleg Nesterov <oleg@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "Christian
 Brauner" <brauner@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Jens Axboe <axboe@kernel.dk>, Jinliang Zheng <alexjlzheng@tencent.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	Tycho Andersen <tandersen@netflix.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [akpm-mm:mm-stable] [memcg]  d73d003521:
 stress-ng.exit-group.ops_per_sec 118.0% improvement
Message-ID: <202407142117.5b960c0a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c9bdd67-79f6-4f39-56cb-08dca409b388
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?uUq6t31vNCdqRDRBbFWyY3M9uyR0MS2tsfoQIib/16EZToqoxB/CoYM9o+?=
 =?iso-8859-1?Q?yOutOQDXxsOgD6KXrpQk8XhRuoagXfASw2JROVdTTgimJJDQelzccXKqdM?=
 =?iso-8859-1?Q?csHDSMG8S8LHMFRRf9ltspVvFaEqcB2Ey+qD+FqVp6HYbTwxbvYlZURHgq?=
 =?iso-8859-1?Q?lcbh7FamIGhF1GQQpwDgWaHyxeWuP1Exz/Jes3yRYeZQq/xA1xyrop6YsW?=
 =?iso-8859-1?Q?ZyWqbsHsfFsm9miMkQTaAr9JEVkU2CQMMcki9tvTIXee1lzKkCW01lnCEp?=
 =?iso-8859-1?Q?B5wJlG7FnTOAvQj5ctJMxVGE7umLvnaaM1SoUHeh04FX1z+zksaw4tNlcF?=
 =?iso-8859-1?Q?uptnteyXuvoNyqJb/xzE1UIam4p9MmlpiolspDOd/vYsOA+6+H+fkujfSt?=
 =?iso-8859-1?Q?m2hofLcxwt79TUTKx40sVCszfM15ZEOPmncR2eMfjkCvyNctMWC5eLtEeN?=
 =?iso-8859-1?Q?/A/Xh+1AEOIph7EiwkNsg5NCqW32/APxUBGAQhODrXotZ/arlhzGb95Rmb?=
 =?iso-8859-1?Q?VoScBIrHG1hvj26I3OLeWl5xIhOd52Nt2AIMAKqrjJu/xX1CYVxu/M+xV8?=
 =?iso-8859-1?Q?vt1kc3FIpoJIoAYjAmWgxaD72cZKAnGxXfhL/hz14KfGHHJunGI8s/j8Ky?=
 =?iso-8859-1?Q?M2nNXd9vbklVlxbXJ7PWLrVZ+a9SLs8TNyD7nYca3G5jRYAh1qn/DSQ/Ga?=
 =?iso-8859-1?Q?UyWoaqoZ9hdoxnlsqJ9518xMBMA0lkDBqvVZOFx3lMuplY/TcqUUzycVOv?=
 =?iso-8859-1?Q?MPRHiVu5YboBeJBLYPmggl8JWM+6KPDDxcgONiPfTgGR/qK5gFi++eaXW7?=
 =?iso-8859-1?Q?4Cv6wZ0bSTtAf3HSv+hkw3a9Y9Z6AiNk7sbDaBe0EevW/rwIpXNMcR0icj?=
 =?iso-8859-1?Q?ZuJGgiutJLQYN5KK+I+roC2h1za5d1AWccrU7InXSGwQqGckLa6OStOTdD?=
 =?iso-8859-1?Q?IuDFNairoslqxQ4eWWDp/xlbniX7FpyuiM3uWlhsx2bekeohjlM3oo46wu?=
 =?iso-8859-1?Q?JVyKJDiMJEmHgq+sE+8JXQ627B9J1+mGRlmxt6zEuow5mGljyFMtJAim7S?=
 =?iso-8859-1?Q?YQjMmLaV5EWJ9vP3dvejfb7hTmB/dkZfgW6Y/WOz/rkYDySTDTHrS65RHA?=
 =?iso-8859-1?Q?v2/d0Y9LOfaPWov4QcUSPc4Wd3etYtwyyAfS5bFLoRpvviQrh87f6BOYUE?=
 =?iso-8859-1?Q?juu0RgTDfaF8uefO9dh7MGmsNC66tVw8DmjDNM1rGxzDdzn34ha0Em9EOq?=
 =?iso-8859-1?Q?a4IOXRvoG++MGn6h/D3qZmWs/Doz0e0hkui2V9Y7SnYax4i1KXpSZAgjNd?=
 =?iso-8859-1?Q?ZkyIFifbHvSdidHVAEGi4DDv0gvnxQglogT9qXc3PNyiTvg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qq22KSmsW2PoXfh5OocC9TAemwrO8uKEDDdvahxdBI85Orff/vSsnaTJKx?=
 =?iso-8859-1?Q?C/pnPZuoxsjqzqOgWLbr9wRIrgbc6PzJPsNgn1YYMRCMWhXC/yk/Xxw2S+?=
 =?iso-8859-1?Q?h8JBVX9OCBUewF3mutE2ARN/OC99O4b2CBWcdmA++YBniDaxD/IEhWJ0z6?=
 =?iso-8859-1?Q?mgfTe/A5GEIsyWH0mlp66jCQlKq9K06kWOuhH1UKoZfBoPaxm4S6qw5o95?=
 =?iso-8859-1?Q?tN/gLlySvvIzXxSj0Iz2WrgtS8fz7IqBT8nVaPD/hKXzXiNaHUhnPHs3Nd?=
 =?iso-8859-1?Q?8Wyfqe19jQpF78Rv3wZIJhQoWZ6ayoGBYJ/LMe9AzWA3T+0uOCm8xQ7pLJ?=
 =?iso-8859-1?Q?Z2RNG+o2fz99K+j8Gh72Zlts1NDdrnvVerouybsY3hPGhXH9/MvpmnozjJ?=
 =?iso-8859-1?Q?W4eXzhdaxChtzVvAp5wlUzvJLer0cOGOo0Rxa3+qPTB0JoISK/uWsNrzGO?=
 =?iso-8859-1?Q?WrFjF+3KIzJ+2tVxYAlXQ5oaNxF0pv7QbrY6n+E90VN8C4VeMh5mryVQ2P?=
 =?iso-8859-1?Q?CxHyuuodF+m7H+Qw/97pan8dmzW52NwmV5haVx027VewxBP8vM1ucmvjW5?=
 =?iso-8859-1?Q?sBz9+x0kR5dJDqsVROHxZffJFaul2r+sHKpHjHaARvm8/oJ6DLTgTLV1eg?=
 =?iso-8859-1?Q?H24EVagUY9aiVa1KFyXUdac8Yd7EYxZoRnTQC03tkgfJyETdfu7zaveUHY?=
 =?iso-8859-1?Q?Q7fjGdbNoBE0xrxo2z7gIdfjWL+PRMY4e9mzttM6exljnRwBwgamJObXpO?=
 =?iso-8859-1?Q?moyhlaM6QePu54n3lnH0nfmilwnTSrcU5AEHWi8ZjhY+Dm9DB9L3XmDrae?=
 =?iso-8859-1?Q?6VCF4PnkTW8CYoR5nuMtq59yP0lq8KG2Wf/YijCC4RHKNgAbc4J4i7OOqv?=
 =?iso-8859-1?Q?PEGn8V0GmoZjNpGkbDmT5ZzQ92C3Vc15cWjOQaq4tOGuEfr1t2oWENLoij?=
 =?iso-8859-1?Q?QbpFp9OSayowBw6VieC0q6da0JXuxcPCbIUrJ1L/fwAbzM2h6oaOq0TBi/?=
 =?iso-8859-1?Q?4iBYpwM0+Y26d5+X3Sr+7Dg7E+stOgVDsESRbPgZciXY3Odxmx7m7Qvz8c?=
 =?iso-8859-1?Q?XLVxeKmnP96F8DKvQcG4P7CbsrsOl7+2N/HWlPiwJ1zNqAU3hwVhAMYS3K?=
 =?iso-8859-1?Q?Kv/nGIdVTAn0ntmdzoKR+BCsOXL1eoVa4W1IsVCbA5A9oZ9JH1C4rmzq0q?=
 =?iso-8859-1?Q?E3FswDxqHkRuL6V4NqfA9HeSE5LQXb6oHUzxbTCzOoyTf6EBxdSpPyM/Rd?=
 =?iso-8859-1?Q?F1Ru8HS29ozWnQxLFcCyvZdNwU0JhTN6kQnun4AAYugm5jwb6buQJQTY4W?=
 =?iso-8859-1?Q?UVAr2PFE7aQYd9O/dcsCCI1FxXszRy2KwGYxSBASHSozc8mjsjTcU6luEy?=
 =?iso-8859-1?Q?1n+bz51S+kxFUzWoir7Aq9cHTx0vLLGrOWj+DDaKpSHZVAAQXIkBHBd2cb?=
 =?iso-8859-1?Q?8iLi/AtEAcotXaviN4URbiRvvczKk/ldFZaE8iVNJ9JRUZHeqa8JUXP1ES?=
 =?iso-8859-1?Q?YTq7J2L8xM/DdtUUI0XNGDZoAfCmZifF8BZf01vg2Ue5P56MKSbQEBjeKm?=
 =?iso-8859-1?Q?MfN8CjGTcPMLfKxZBXMKow7vLqxN9ye4tKTmvqIXVQ2AaLMyZVoF35A/US?=
 =?iso-8859-1?Q?P5+ZhHrv7/rAEjz248fY1ev+aHlwtuQD7UyL9daJPcg6ABYraYwTCgyA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9bdd67-79f6-4f39-56cb-08dca409b388
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 13:34:35.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Djir09vtrDxWLes/M+bhihJhgeUWfNgXgOKr/meC+GsnSpmxPq5l4hiMvMLkemJnvcEhCReGsZts28CuhhldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 118.0% improvement of stress-ng.exit-group.ops_per_sec on:


commit: d73d00352145fb51d31771047aa939850d87fa50 ("memcg: mm_update_next_owner: move for_each_thread() into try_to_set_owner()")
https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-stable

testcase: stress-ng
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: exit-group
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240714/202407142117.5b960c0a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/exit-group/stress-ng/60s

commit: 
  2a22b773b1 ("memcg: mm_update_next_owner: kill the "retry" logic")
  d73d003521 ("memcg: mm_update_next_owner: move for_each_thread() into try_to_set_owner()")

2a22b773b15f5aa9 d73d00352145fb51d31771047aa 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    217222 ± 17%     +24.3%     270050 ± 17%  numa-meminfo.node1.SUnreclaim
 6.935e+08 ±  5%     +27.7%  8.854e+08 ±  4%  cpuidle..time
  10397830 ±  5%     +78.6%   18573294 ±  2%  cpuidle..usage
   1072213 ±  2%     +90.7%    2044784        vmstat.system.cs
    640290           +37.6%     881054        vmstat.system.in
   5762593 ±  5%     +13.0%    6512102 ±  5%  meminfo.Inactive
   5762381 ±  5%     +13.0%    6511890 ±  5%  meminfo.Inactive(anon)
     69720 ±  3%     +31.1%      91405 ±  2%  meminfo.PageTables
      4.72 ±  2%      +0.9        5.60        mpstat.cpu.all.idle%
      1.32            +0.1        1.45        mpstat.cpu.all.irq%
      0.19 ±  2%      +0.1        0.31        mpstat.cpu.all.soft%
  15497381 ±  3%    +114.8%   33295491        numa-numastat.node0.local_node
  15678782 ±  3%    +113.8%   33513606        numa-numastat.node0.numa_hit
  17225380 ±  3%    +101.3%   34666712        numa-numastat.node1.local_node
  17308088 ±  3%    +100.6%   34716308        numa-numastat.node1.numa_hit
  15655629 ±  3%    +114.1%   33513526        numa-vmstat.node0.numa_hit
  15474228 ±  3%    +115.2%   33295411        numa-vmstat.node0.numa_local
     54310 ± 17%     +24.5%      67597 ± 17%  numa-vmstat.node1.nr_slab_unreclaimable
  17291453 ±  3%    +100.8%   34716388        numa-vmstat.node1.numa_hit
  17208745 ±  3%    +101.4%   34666792        numa-vmstat.node1.numa_local
      6726 ± 12%     +37.1%       9224 ± 23%  perf-c2c.DRAM.local
     13006 ± 12%    +104.2%      26556 ± 18%  perf-c2c.DRAM.remote
     21716 ±  9%    +113.1%      46284 ± 19%  perf-c2c.HITM.local
      6664 ±  9%    +140.2%      16005 ± 19%  perf-c2c.HITM.remote
     28380 ±  9%    +119.5%      62289 ± 19%  perf-c2c.HITM.total
    187699          +118.0%     409232        stress-ng.exit-group.ops
      3128          +118.0%       6820        stress-ng.exit-group.ops_per_sec
   3187621           +86.5%    5944966        stress-ng.time.involuntary_context_switches
  17981166          +115.8%   38799479        stress-ng.time.minor_page_faults
     18658            -4.1%      17889        stress-ng.time.percent_of_cpu_this_job_got
     11273            -4.6%      10756        stress-ng.time.system_time
     72.34           +39.9%     101.20        stress-ng.time.user_time
  48758120 ±  2%     +93.5%   94323443        stress-ng.time.voluntary_context_switches
    333694            +2.6%     342211        proc-vmstat.nr_anon_pages
   1438355 ±  5%     +13.0%    1625776 ±  5%  proc-vmstat.nr_inactive_anon
     84819            +4.5%      88651        proc-vmstat.nr_kernel_stack
    409590 ±  2%      -3.7%     394468        proc-vmstat.nr_mapped
     17524 ±  3%     +29.4%      22670        proc-vmstat.nr_page_table_pages
    141599            +3.0%     145847        proc-vmstat.nr_slab_unreclaimable
   1438355 ±  5%     +13.0%    1625776 ±  5%  proc-vmstat.nr_zone_inactive_anon
    330806 ± 11%     +21.5%     401991 ±  5%  proc-vmstat.numa_hint_faults
  32924026          +107.2%   68224812        proc-vmstat.numa_hit
  32659916          +108.1%   67957100        proc-vmstat.numa_local
  35864613          +107.7%   74476192        proc-vmstat.pgalloc_normal
  19332723          +108.2%   40254654        proc-vmstat.pgfault
  32823616          +117.0%   71226488        proc-vmstat.pgfree
    402063          +110.1%     844870        proc-vmstat.pgreuse
    187670          +118.3%     409594        proc-vmstat.thp_split_pmd
   4707478           +10.4%    5197309        sched_debug.cfs_rq:/.avg_vruntime.avg
   2972418 ± 11%     +21.9%    3622813 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.min
   2327686           +10.6%    2574969        sched_debug.cfs_rq:/.left_deadline.stddev
   2327520           +10.6%    2574808        sched_debug.cfs_rq:/.left_vruntime.stddev
   4707494           +10.4%    5197316        sched_debug.cfs_rq:/.min_vruntime.avg
   2972419 ± 11%     +21.9%    3622815 ± 10%  sched_debug.cfs_rq:/.min_vruntime.min
   2327522           +10.6%    2574808        sched_debug.cfs_rq:/.right_vruntime.stddev
    854.12 ±  5%     -11.7%     754.18        sched_debug.cfs_rq:/.runnable_avg.avg
      5062 ± 33%     -36.9%       3195 ± 23%  sched_debug.cfs_rq:/.runnable_avg.max
    104.75 ± 46%     +99.4%     208.83 ±  9%  sched_debug.cfs_rq:/.runnable_avg.min
    632.35 ± 13%     -30.9%     436.89 ±  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    413.72 ±  3%     +21.6%     502.89        sched_debug.cfs_rq:/.util_avg.avg
    204892 ±  4%     -15.6%     172847 ±  3%  sched_debug.cpu.avg_idle.stddev
   1389929 ±  2%     -20.4%    1106690 ±  3%  sched_debug.cpu.curr->pid.avg
   1558303           -15.8%    1312053        sched_debug.cpu.curr->pid.max
      0.00 ± 11%     -33.1%       0.00 ± 11%  sched_debug.cpu.next_balance.stddev
    130604 ±  2%     +91.5%     250043        sched_debug.cpu.nr_switches.avg
    234172 ±  3%     +64.8%     385912 ±  3%  sched_debug.cpu.nr_switches.max
     75225 ±  7%    +134.4%     176318 ± 20%  sched_debug.cpu.nr_switches.min
    -17.67           +45.8%     -25.75        sched_debug.cpu.nr_uninterruptible.min
      7.62 ±  5%     +25.8%       9.58 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
      1.68           +38.5%       2.33        perf-stat.i.MPKI
 1.255e+10           +30.9%  1.644e+10        perf-stat.i.branch-instructions
      0.70 ±  5%      +0.2        0.94        perf-stat.i.branch-miss-rate%
  81910304           +77.4%  1.453e+08        perf-stat.i.branch-misses
     20.08            +4.2       24.26        perf-stat.i.cache-miss-rate%
  91235100           +86.5%  1.702e+08        perf-stat.i.cache-misses
 4.533e+08           +54.5%  7.003e+08        perf-stat.i.cache-references
   1102560 ±  2%     +91.9%    2115419        perf-stat.i.context-switches
     11.87           -26.5%       8.72        perf-stat.i.cpi
 6.447e+11            -1.4%  6.357e+11        perf-stat.i.cpu-cycles
    233144 ±  3%     +66.0%     387058        perf-stat.i.cpu-migrations
      7407           -49.0%       3776        perf-stat.i.cycles-between-cache-misses
 5.511e+10           +37.2%  7.559e+10        perf-stat.i.instructions
      0.09 ±  6%     +34.4%       0.12        perf-stat.i.ipc
      1.38 ± 44%    +221.5%       4.44 ± 34%  perf-stat.i.major-faults
      7.02 ±  2%    +112.1%      14.89        perf-stat.i.metric.K/sec
    315810          +108.8%     659340        perf-stat.i.minor-faults
    315819          +108.8%     659348        perf-stat.i.page-faults
      1.69           +36.9%       2.31        perf-stat.overall.MPKI
      0.63            +0.2        0.87        perf-stat.overall.branch-miss-rate%
     20.30            +4.1       24.45        perf-stat.overall.cache-miss-rate%
     11.82           -27.5%       8.57        perf-stat.overall.cpi
      7004           -47.1%       3708        perf-stat.overall.cycles-between-cache-misses
      0.08           +38.0%       0.12        perf-stat.overall.ipc
 1.211e+10           +29.6%  1.569e+10        perf-stat.ps.branch-instructions
  75756600           +80.6%  1.368e+08        perf-stat.ps.branch-misses
  89620471           +85.9%  1.666e+08        perf-stat.ps.cache-misses
 4.414e+08           +54.4%  6.815e+08        perf-stat.ps.cache-references
   1079290 ±  2%     +92.0%    2072296        perf-stat.ps.context-switches
 6.277e+11            -1.6%  6.178e+11        perf-stat.ps.cpu-cycles
    228129 ±  3%     +66.3%     379319        perf-stat.ps.cpu-migrations
 5.311e+10           +35.8%  7.212e+10        perf-stat.ps.instructions
      1.27 ± 44%    +236.0%       4.27 ± 33%  perf-stat.ps.major-faults
    303833          +109.4%     636319        perf-stat.ps.minor-faults
    303841          +109.4%     636327        perf-stat.ps.page-faults
 3.206e+12           +36.8%  4.386e+12        perf-stat.total.instructions
     49.34            -4.0       45.30        perf-profile.calltrace.cycles-pp.exit_notify.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
     88.60            -3.9       84.69        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     88.60            -3.9       84.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     54.27            -3.3       51.02        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.27            -3.3       51.02        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
     54.27            -3.3       51.02        perf-profile.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     54.27            -3.3       51.02        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.33            -3.2       51.12        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     27.38            -2.9       24.52        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3
     27.48            -2.9       24.62        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64
     28.54            -2.6       25.91        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit
     25.93            -2.5       23.38        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.do_group_exit.get_signal
     25.41            -1.9       23.51        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
     25.53            -1.9       23.63        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.do_group_exit
     28.06            -1.8       26.22        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     23.25            -1.6       21.65        perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.do_group_exit.get_signal
     28.66            -1.0       27.65        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
     28.66            -1.0       27.66        perf-profile.calltrace.cycles-pp.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.65            -0.5        3.14        perf-profile.calltrace.cycles-pp.mm_update_next_owner.exit_mm.do_exit.do_group_exit.get_signal
      4.90            -0.4        4.52        perf-profile.calltrace.cycles-pp.__do_wait.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      4.93            -0.4        4.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      4.93            -0.4        4.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      4.92            -0.4        4.55        perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      4.92            -0.4        4.55        perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      4.92            -0.4        4.55        perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.94            -0.4        4.57        perf-profile.calltrace.cycles-pp.wait4
      3.34            -0.4        2.98        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4
      3.34            -0.3        3.00        perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.__do_wait.do_wait.kernel_wait4.__do_sys_wait4
      3.38            -0.3        3.09        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.mm_update_next_owner.exit_mm.do_exit
      3.39            -0.3        3.10        perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.mm_update_next_owner.exit_mm.do_exit.do_group_exit
      1.74            -0.1        1.60        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone
      1.75            -0.1        1.61        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      1.53            -0.1        1.46        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait
      1.54            -0.1        1.47        perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.wait_task_zombie.__do_wait.do_wait
      1.55            -0.0        1.51        perf-profile.calltrace.cycles-pp.release_task.wait_task_zombie.__do_wait.do_wait.kernel_wait4
      1.56            -0.0        1.52        perf-profile.calltrace.cycles-pp.wait_task_zombie.__do_wait.do_wait.kernel_wait4.__do_sys_wait4
      4.76            +0.5        5.22        perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.get_signal.arch_do_signal_or_restart
      0.62 ±  6%      +0.5        1.09 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.63 ±  6%      +0.5        1.10        perf-profile.calltrace.cycles-pp.common_startup_64
      0.62 ±  6%      +0.5        1.09 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.62 ±  6%      +0.5        1.09 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.00            +0.6        0.56 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.6        0.64 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.53 ±  4%      +0.7        1.20 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53 ±  4%      +0.7        1.20 ±  2%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.57 ±  4%      +0.7        1.26        perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.56            +0.8        1.38        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone3.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.83        perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      0.26 ±100%      +0.9        1.15 ±  2%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      0.84 ±  4%      +1.0        1.79        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      1.10            +1.0        2.05        perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.84 ±  4%      +1.0        1.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      1.10            +1.0        2.06        perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.get_signal
      0.00            +1.0        1.00 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.00            +1.0        1.01 ±  2%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00            +1.0        1.02        perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.02 ±  4%      +1.1        2.13        perf-profile.calltrace.cycles-pp.clock_nanosleep
      0.08 ±223%      +1.1        1.21        perf-profile.calltrace.cycles-pp.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone3
      0.08 ±223%      +1.1        1.21        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone3.do_syscall_64
      0.00            +1.1        1.15        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task
      0.00            +1.2        1.17        perf-profile.calltrace.cycles-pp.sched_balance_find_dst_group.sched_balance_find_dst_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone
      0.00            +1.3        1.30        perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      0.83            +1.3        2.13        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      2.70            +1.3        4.03        perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.74            +1.4        4.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      2.74            +1.4        4.13        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      2.73            +1.4        4.12        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      2.73            +1.4        4.12        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      0.90            +1.4        2.31        perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      2.75            +1.4        4.16        perf-profile.calltrace.cycles-pp._Fork
     85.36            -7.7       77.70        perf-profile.children.cycles-pp.queued_write_lock_slowpath
     92.04            -7.4       84.65        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     54.98            -4.1       50.89        perf-profile.children.cycles-pp.exit_notify
     54.78            -3.2       51.63        perf-profile.children.cycles-pp.get_signal
     54.78            -3.2       51.63        perf-profile.children.cycles-pp.arch_do_signal_or_restart
     60.22            -3.1       57.16        perf-profile.children.cycles-pp.do_exit
     60.24            -3.0       57.22        perf-profile.children.cycles-pp.do_group_exit
     54.62            -2.9       51.68        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     97.59            -1.7       95.91        perf-profile.children.cycles-pp.do_syscall_64
     97.60            -1.7       95.93        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     27.49            -1.6       25.89        perf-profile.children.cycles-pp.release_task
     28.66            -1.0       27.66        perf-profile.children.cycles-pp.__do_sys_clone3
      6.82            -0.6        6.18        perf-profile.children.cycles-pp.queued_read_lock_slowpath
      3.74            -0.5        3.22        perf-profile.children.cycles-pp.mm_update_next_owner
     30.78            -0.5       30.27        perf-profile.children.cycles-pp.copy_process
      4.90            -0.4        4.52        perf-profile.children.cycles-pp.__do_wait
      4.92            -0.4        4.55        perf-profile.children.cycles-pp.__do_sys_wait4
      4.92            -0.4        4.55        perf-profile.children.cycles-pp.do_wait
      4.92            -0.4        4.55        perf-profile.children.cycles-pp.kernel_wait4
      4.94            -0.4        4.57        perf-profile.children.cycles-pp.wait4
      0.40            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      0.40            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.40            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.36 ±  5%      -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
      1.56            -0.0        1.52        perf-profile.children.cycles-pp.wait_task_zombie
      0.37            +0.0        0.38        perf-profile.children.cycles-pp.cmd_record
      0.37            +0.0        0.38        perf-profile.children.cycles-pp.main
      0.37            +0.0        0.38        perf-profile.children.cycles-pp.run_builtin
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__sysvec_thermal
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.intel_thermal_interrupt
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.sysvec_thermal
      0.11 ±  4%      +0.0        0.13        perf-profile.children.cycles-pp.asm_sysvec_thermal
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.11            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.sched_tick
      0.11 ± 14%      +0.0        0.16 ± 10%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__free_one_page
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__libc_fork
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__split_vma
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__wp_page_copy_user
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._copy_from_user
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mas_find
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mas_wr_bnode
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.zap_other_threads
      0.06            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__put_partials
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      0.05            +0.1        0.11        perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.perf_event_task
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.sched_clock
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.schedule_tail
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.vma_modify
      0.07 ±  6%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.shim_nanosleep_uint64
      0.02 ±141%      +0.1        0.08        perf-profile.children.cycles-pp.__get_user_8
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__rb_erase_color
      0.14 ±  2%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.06 ± 11%      +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.05 ±  7%      +0.1        0.12        perf-profile.children.cycles-pp.___perf_sw_event
      0.04 ± 44%      +0.1        0.11        perf-profile.children.cycles-pp.__mmdrop
      0.07            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__task_rq_lock
      0.10 ±  8%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.05            +0.1        0.12        perf-profile.children.cycles-pp.perf_event_task_output
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.acct_collect
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.add_device_randomness
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.06 ±  9%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
      0.07            +0.1        0.14        perf-profile.children.cycles-pp.os_xsave
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.perf_event_fork
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.sched_clock_cpu
      0.06 ±  6%      +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.syscall
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.15            +0.1        0.22        perf-profile.children.cycles-pp.tick_nohz_handler
      0.07 ±  6%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.06 ±  8%      +0.1        0.13        perf-profile.children.cycles-pp.__mprotect
      0.09 ±  8%      +0.1        0.16        perf-profile.children.cycles-pp.intel_idle
      0.08 ± 10%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.03 ± 70%      +0.1        0.11        perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.03 ± 70%      +0.1        0.11        perf-profile.children.cycles-pp.do_mprotect_pkey
      0.05            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.06            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.05            +0.1        0.13        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.detach_tasks
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.insert_vmap_area
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.sched_move_task
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__vm_area_free
      0.05            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.05 ±  8%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.06            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.06 ±  7%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.set_next_entity
      0.05            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.06            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.refcount_dec_not_one
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma_batch_add
      0.06 ±  6%      +0.1        0.15        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.cgroup_free
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.mprotect_fixup
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.stress_exit_group
      0.06            +0.1        0.15        perf-profile.children.cycles-pp.__memcpy
      0.07            +0.1        0.16        perf-profile.children.cycles-pp.perf_iterate_sb
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.find_unlink_vmap_area
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.free_pid
      0.07            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.do_task_dead
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__put_anon_vma
      0.08 ±  6%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.02 ±141%      +0.1        0.11        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.07 ±  7%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.07 ± 10%      +0.1        0.17 ±  8%  perf-profile.children.cycles-pp.copy_present_ptes
      0.02 ±141%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.09 ±  4%      +0.1        0.19        perf-profile.children.cycles-pp.futex_wake
      0.07            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__pte_alloc
      0.08            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.do_mmap
      0.09 ±  7%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.__memset
      0.11 ±  4%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.07            +0.1        0.17        perf-profile.children.cycles-pp.mm_init
      0.07            +0.1        0.17        perf-profile.children.cycles-pp.pte_alloc_one
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.07 ± 10%      +0.1        0.17 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.07 ±  7%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.wp_page_copy
      0.01 ±223%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.01 ±223%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp._raw_write_lock_irq
      0.07            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.up_write
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.11 ±  8%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.__put_task_struct
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.free_unref_page
      0.07 ±  5%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.futex_wait_queue
      0.06            +0.1        0.17 ±  7%  perf-profile.children.cycles-pp.remove_vm_area
      0.08            +0.1        0.19        perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.08            +0.1        0.19        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.06            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__exit_signal
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.12 ±  5%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      0.08 ±  4%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__mmap
      0.08            +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.__futex_wait
      0.08 ±  4%      +0.1        0.20        perf-profile.children.cycles-pp.futex_wait
      0.02 ±141%      +0.1        0.14 ±  8%  perf-profile.children.cycles-pp.folios_put_refs
      0.09            +0.1        0.22        perf-profile.children.cycles-pp.__slab_free
      0.10 ±  6%      +0.1        0.23 ±  6%  perf-profile.children.cycles-pp.copy_pte_range
      0.09 ±  5%      +0.1        0.22        perf-profile.children.cycles-pp.filemap_map_pages
      0.00            +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.07 ±  6%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.update_curr
      0.09            +0.1        0.22        perf-profile.children.cycles-pp.vm_area_dup
      0.10            +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.do_fault
      0.10            +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.do_read_fault
      0.16 ±  6%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.11 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.07            +0.1        0.21 ±  6%  perf-profile.children.cycles-pp.vfree
      0.11            +0.1        0.25        perf-profile.children.cycles-pp.pthread_create
      0.08 ±  6%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.00            +0.1        0.14 ±  7%  perf-profile.children.cycles-pp.cgroup_css_set_fork
      0.08 ±  6%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.11 ±  8%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.copy_page_range
      0.11 ±  7%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.copy_p4d_range
      0.00            +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.cgroup_exit
      0.07 ±  5%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.10 ±  4%      +0.2        0.26        perf-profile.children.cycles-pp.clear_page_erms
      0.11 ±  4%      +0.2        0.27 ±  3%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.10            +0.2        0.26        perf-profile.children.cycles-pp.get_page_from_freelist
      0.09            +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.process_one_work
      0.11            +0.2        0.27 ±  2%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.00            +0.2        0.16 ±  8%  perf-profile.children.cycles-pp.cgroup_post_fork
      0.00            +0.2        0.17 ±  6%  perf-profile.children.cycles-pp.cgroup_can_fork
      0.12 ±  4%      +0.2        0.29        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.09 ±  4%      +0.2        0.26 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.10 ±  3%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.worker_thread
      0.12 ±  4%      +0.2        0.30        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.12 ±  3%      +0.2        0.31 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.13 ±  3%      +0.2        0.32        perf-profile.children.cycles-pp.do_anonymous_page
      0.00            +0.2        0.19 ±  6%  perf-profile.children.cycles-pp.cgroup_release
      0.08 ±  5%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.16 ± 13%      +0.2        0.36 ± 14%  perf-profile.children.cycles-pp._compound_head
      0.08 ±  4%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.13 ±  7%      +0.2        0.33 ±  3%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.08 ±  5%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.rcu_core
      0.14 ±  5%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.16 ±  2%      +0.2        0.36        perf-profile.children.cycles-pp.__x64_sys_futex
      0.13 ±  3%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.17 ±  2%      +0.2        0.39        perf-profile.children.cycles-pp.do_futex
      0.13 ±  2%      +0.2        0.36 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      0.08 ±  5%      +0.2        0.31 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.18 ±  2%      +0.2        0.41        perf-profile.children.cycles-pp.update_load_avg
      0.17 ±  8%      +0.2        0.40 ±  6%  perf-profile.children.cycles-pp.zap_present_ptes
      0.00            +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.osq_lock
      0.40 ±  5%      +0.3        0.65        perf-profile.children.cycles-pp.cpuidle_enter
      0.40 ±  5%      +0.3        0.65        perf-profile.children.cycles-pp.cpuidle_enter_state
      0.56 ±  4%      +0.3        0.81 ±  2%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.41 ±  5%      +0.3        0.68        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.14 ±  2%      +0.3        0.41 ±  4%  perf-profile.children.cycles-pp.kthread
      0.20 ±  3%      +0.3        0.47        perf-profile.children.cycles-pp.ttwu_do_activate
      0.24            +0.3        0.52        perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.18 ±  2%      +0.3        0.46 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.20 ±  3%      +0.3        0.48 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.19 ±  3%      +0.3        0.48 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.20 ±  2%      +0.3        0.49        perf-profile.children.cycles-pp.dup_task_struct
      0.21 ±  6%      +0.3        0.51 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      0.20 ±  2%      +0.3        0.50        perf-profile.children.cycles-pp.enqueue_task_fair
      0.22 ±  6%      +0.3        0.52 ±  3%  perf-profile.children.cycles-pp.zap_pmd_range
      0.16 ±  3%      +0.3        0.47        perf-profile.children.cycles-pp.dequeue_task_fair
      0.22 ±  5%      +0.3        0.52 ±  4%  perf-profile.children.cycles-pp.unmap_page_range
      0.11 ±  4%      +0.3        0.41        perf-profile.children.cycles-pp.alloc_pid
      0.16 ±  2%      +0.3        0.48 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.23 ±  2%      +0.3        0.55        perf-profile.children.cycles-pp.activate_task
      0.18 ±  2%      +0.3        0.51 ±  3%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.26 ±  5%      +0.4        0.61 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      0.66 ±  3%      +0.4        1.02        perf-profile.children.cycles-pp.try_to_wake_up
      0.74 ±  3%      +0.4        1.10 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.76 ±  3%      +0.4        1.14 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
     31.40            +0.4       31.78        perf-profile.children.cycles-pp.kernel_clone
      0.77 ±  3%      +0.4        1.16 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.26            +0.4        0.68        perf-profile.children.cycles-pp.unlink_anon_vmas
      0.30            +0.4        0.73        perf-profile.children.cycles-pp.__handle_mm_fault
      0.31            +0.4        0.75        perf-profile.children.cycles-pp.handle_mm_fault
      0.12 ±  4%      +0.5        0.58 ±  2%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.13 ±  2%      +0.5        0.60 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.63 ±  6%      +0.5        1.10        perf-profile.children.cycles-pp.common_startup_64
      0.63 ±  6%      +0.5        1.10        perf-profile.children.cycles-pp.cpu_startup_entry
      0.62 ±  6%      +0.5        1.09 ±  2%  perf-profile.children.cycles-pp.start_secondary
      0.62 ±  6%      +0.5        1.10        perf-profile.children.cycles-pp.do_idle
      0.46 ± 16%      +0.5        0.94 ±  5%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.35            +0.5        0.84        perf-profile.children.cycles-pp.do_user_addr_fault
      0.35            +0.5        0.85        perf-profile.children.cycles-pp.exc_page_fault
      0.88 ±  3%      +0.5        1.42        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.14 ±  2%      +0.6        1.70 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.36            +0.6        0.92        perf-profile.children.cycles-pp.free_pgtables
      4.97            +0.6        5.57        perf-profile.children.cycles-pp.exit_mm
      0.23            +0.6        0.84        perf-profile.children.cycles-pp.down_write
      0.40            +0.6        1.02        perf-profile.children.cycles-pp.anon_vma_clone
      0.51 ±  4%      +0.6        1.15        perf-profile.children.cycles-pp.do_nanosleep
      0.53 ±  4%      +0.7        1.20        perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.54 ±  4%      +0.7        1.22        perf-profile.children.cycles-pp.common_nsleep
      0.57 ±  4%      +0.7        1.27 ±  2%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.50            +0.7        1.22        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.51            +0.7        1.25        perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.56 ±  3%      +0.7        1.31        perf-profile.children.cycles-pp.schedule
      0.52            +0.8        1.28        perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.92 ±  2%      +0.8        1.69        perf-profile.children.cycles-pp.select_task_rq_fair
      0.24            +0.8        1.03 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.48            +0.8        1.30        perf-profile.children.cycles-pp.anon_vma_fork
      0.60            +0.9        1.46        perf-profile.children.cycles-pp.wake_up_new_task
      0.74 ±  3%      +0.9        1.68        perf-profile.children.cycles-pp.__schedule
      1.19            +1.1        2.25        perf-profile.children.cycles-pp.exit_mmap
      1.19            +1.1        2.26        perf-profile.children.cycles-pp.__mmput
      1.03 ±  4%      +1.1        2.14        perf-profile.children.cycles-pp.clock_nanosleep
      0.83            +1.3        2.13        perf-profile.children.cycles-pp.dup_mmap
      2.73            +1.4        4.12        perf-profile.children.cycles-pp.__do_sys_clone
      0.90            +1.4        2.31        perf-profile.children.cycles-pp.dup_mm
      2.75            +1.4        4.17        perf-profile.children.cycles-pp._Fork
     91.99            -7.4       84.58        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.39            -0.2        0.23 ±  2%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.37            -0.0        0.34        perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.17 ±  5%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.select_idle_cpu
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__free_one_page
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.acct_collect
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.intel_thermal_interrupt
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.unmap_vmas
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.filemap_map_pages
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.clock_nanosleep
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.05            +0.1        0.11        perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__rb_erase_color
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__switch_to
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.enqueue_entity
      0.06 ±  6%      +0.1        0.13        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__switch_to_asm
      0.04 ± 44%      +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.anon_vma_clone
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.insert_vmap_area
      0.07            +0.1        0.14        perf-profile.self.cycles-pp.os_xsave
      0.09 ±  8%      +0.1        0.16        perf-profile.self.cycles-pp.intel_idle
      0.06 ±  7%      +0.1        0.14 ± 10%  perf-profile.self.cycles-pp.update_cfs_group
      0.06            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.05            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.06 ±  8%      +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.zap_pte_range
      0.06            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__get_user_8
      0.06            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.06 ±  8%      +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.06            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.refcount_dec_not_one
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.dequeue_task_fair
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.dup_mmap
      0.08 ±  5%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.__memset
      0.00            +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.folios_put_refs
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.mod_objcg_state
      0.11 ±  4%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.vm_area_dup
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp._raw_write_lock_irq
      0.06 ±  7%      +0.1        0.17        perf-profile.self.cycles-pp.up_write
      0.08            +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.06 ±  6%      +0.1        0.17        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.09            +0.1        0.21        perf-profile.self.cycles-pp.__slab_free
      0.00            +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.update_curr
      0.10 ±  5%      +0.1        0.23        perf-profile.self.cycles-pp.down_write
      0.10 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.clear_page_erms
      0.16 ± 15%      +0.2        0.35 ± 14%  perf-profile.self.cycles-pp._compound_head
      0.15 ±  4%      +0.2        0.35        perf-profile.self.cycles-pp._raw_spin_lock
      0.08 ±  5%      +0.2        0.31 ±  2%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.00            +0.2        0.24 ±  2%  perf-profile.self.cycles-pp.osq_lock
      0.24 ±  2%      +0.3        0.51        perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.48            +0.7        1.17        perf-profile.self.cycles-pp.update_sg_wakeup_stats




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


