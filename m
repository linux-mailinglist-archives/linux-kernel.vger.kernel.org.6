Return-Path: <linux-kernel+bounces-260554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA493AADD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986B11F2331F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A110A24;
	Wed, 24 Jul 2024 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hioey05p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C317C68
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786570; cv=fail; b=PAfy8RcWdSouSvWdWGTGHHLyVfAQbUgVltHtDhtHw6RpwKeItr/sx8ehMJPwHf57EwFh+kz4w75WyfxOoAfz1KrxFFy3XSHx3xvFJ92ebjjCV8rNKeH0v0xN5XaIHMrbzjg1JpfX1MkT1e3NNzAKGfptmiuMxkSpUbozjxx4qfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786570; c=relaxed/simple;
	bh=KajBDwPyqLKzQ7x+8V2Y+2AOH+Mi07foxeLI5DqVXic=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dau8u/d09+iqOJJvcLQsBjHExft/sUT8MeSMv72g2iY1Yv2SaMbMBc0v8oi82tzSbXDw1Q19PjqEg0JC14bGX3qJXsXzVwoLDCNdnuaFpE/UjErb54UWSgSZvkgPcNjPQnZDKq8Ds5ols8qXZE+m9bLsnOgC06plNKOt9kkG/gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hioey05p; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721786569; x=1753322569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KajBDwPyqLKzQ7x+8V2Y+2AOH+Mi07foxeLI5DqVXic=;
  b=hioey05poDpuQ6perZ93XXMTuublYS/ab+ed4lMFKIhxNmhIbxPNLvVI
   ht8S6ConlC34jEIWmFU95RsojpzxKeGZrEUQgNPzinpWp6qnP5tciYS8F
   Rf9fIWsxQt/+8JwV6eQIBszpE0SEQ17axRNbUsowLxNX1Wv3p1IjAEJO2
   kzzAk1aUoz+vCdzaewBtfhTjujTHe0zFMrC0R1gfSPzizLMa8UiuOzViF
   wGP4u8CUH8T9R+qAWMZQkkIGVYOuLdWmNpDAG7NvcVuSUUizK8cDfp3/B
   BNdK008ipbpwQlrBH/239CM9Hkhm2Beftxi5pjDQW/N7gkN7Qg5lAYQVw
   A==;
X-CSE-ConnectionGUID: PAe2jLKhSdqorlijq1FkPw==
X-CSE-MsgGUID: Or6NQirtSzS2We4gxF8T8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30031083"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30031083"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:02:49 -0700
X-CSE-ConnectionGUID: sdCoO6TsSLyC/wWptNXWUg==
X-CSE-MsgGUID: /Nf4MZvyRTukf2s+NsYSNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="56731244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2024 19:02:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 19:02:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 19:02:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 19:02:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tcnu3A39zfOFuHcStPwnrE4vPDqHw0uBdhkxLtPOIUs0nra/iNDx2gUpoON8BsZ7CjLL/G4BR8JyoV2Ip0SvIXx3NxmbUCC7CIInBc3gaJgSWdGNeMgu3oziJcqjSdELLdLQmnP3JVhhdyAwr3fUJ1/mzh+1smTJzJQSHRdNlyB2vGuM+ijUivqCv1TRktiMCLqzFFP++OxdvNxMxUmGrE4ZCrCa3oMGD4qbwe72NxVWbVQISF0kMxKfkKi0/GPicDiOBMlQRlA/ujgl4oDtvMBvJODwOrxnF7l3xYD9XZo8SxPTt4lWws0ZBN7GtTTZFirPfkRRuQPF1MvaIhtOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4nCZOOkGzDF2qnpdVvnfXyjIQBfSAwHvLKLA+gIlsc=;
 b=xN3wUAmefFlQcYH4Wd2/V13XcEYjNzc4vIiqCu03Zu4LeVV4/hrcuimUa8vU+V14D03HXx+LU3M56nR90Q0jze5rKu0eW15CgDpr4QdoSL5XAvfxjQOREvnrIGhGT8e+FT3/ScKkEVCfU2wqC6zkM1Rfef/ikQ+vWVVYLfD1cn2xq3Ax8+8mkUyUFUiOzD04Sb1OawIKu4pVKleefR4rloqMs109hLbg0gGv/a+q1+MLqVcawfXMEio6SKV4/qAxxCopt5vNSxF6FKLjc0bZbQ2KZbYIhL9MJaP4IYGVSLwWsPyaGZzK7nwTpBDnMz2q8+Q4St7weELuDvK3i3RlyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Wed, 24 Jul 2024 02:02:45 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 02:02:45 +0000
Date: Wed, 24 Jul 2024 10:02:37 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Qu Wenruo <wqu@suse.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>
Subject: Re: fs/btrfs/lzo.o: warning: objtool: lzo_compress_folios+0xb0:
 unreachable instruction
Message-ID: <ZqBgvYYl154a+bV6@rli9-mobl>
References: <202407232006.7Gelsbv4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202407232006.7Gelsbv4-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: fb14b8d5-117e-4dcb-885b-08dcab84b5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?63IAmbYh/HEGuRkYD9XNV8UbkqtWObQ6AcDwWlB1/2e9nGiIEdZBm34ThBx+?=
 =?us-ascii?Q?ohEFQOlB5ydaj6tx1mfOb965Q3BzHDITLzs4xoznxwbrO+fZ4H8wCNs+2KCy?=
 =?us-ascii?Q?J2t3I/qV+2Rs26ds8d9yrfspx0uLRQ9966WNICl/bSSKAlh6ZjdrPV2JMPzo?=
 =?us-ascii?Q?3fsNvgl8NbcRhoXjVma0N9MWromlX1s4hDKBYFKYI09OF/mbuKGcW99R6bxp?=
 =?us-ascii?Q?2OlRPepV1JftNAusWmbjUomSW7JaRxKrtVjsnowtr8BoAy7rZVO3zah6hzbQ?=
 =?us-ascii?Q?UKRZbmv5mre4lah4Ct4HsLWsulFNgx1lWLAnyGU93OhWt0Cq+CHVc27wM81Z?=
 =?us-ascii?Q?4uTWh94n4nCaeqnYEEHd+BQdJoFecNJX4SUQiBc7JL/R23bIDiNATEurSvwx?=
 =?us-ascii?Q?ynG6bRb+9Lp3rBMYwmzu8HBNmGxkHgv/bZYdOImdP10/snBKRCdFCzXVpugZ?=
 =?us-ascii?Q?hjakwj0V6N6BomtrK8ka509In5Tc+cnMUpZYnoHP0uTCdJzZK0A0jwuZ4c9t?=
 =?us-ascii?Q?uhgk0U2DgS9Pse/r5l3UdCL33Dzei5Otui9N7f7qfwdVfzUcHMYwVkVjC7+W?=
 =?us-ascii?Q?Ch1evip87UsoQP18VJyyffUusaEWWcn4zUOhDw9DcV58LvSVWTyon1JKRC21?=
 =?us-ascii?Q?XlCjoOt3mGhgecI17mu/sV/6Z/4U9kpRRNAsMz2idah/toF3Cq7yQ4dlHEqr?=
 =?us-ascii?Q?8+HhlQza2UbrIOtN8V+QGyYsVKamzq5UCiVXV1N+DurpptFhZMNFanmsJlDf?=
 =?us-ascii?Q?LAAv1kB2oiKgrqLyXGiI62lj6DrI+H/3AIB95hTro7GCMcgeFYEvE8KUoLuu?=
 =?us-ascii?Q?HEjc9ThAHR0pbJfOCdaAwMM2THMI4o6geTUjS2CjedemQCCzmekkWFJEJnuV?=
 =?us-ascii?Q?VpYgw6zQVaKZBzq47slScXYvDumc8iFv0m9pVlPgLGsD2K7eXk7d50yZn8rG?=
 =?us-ascii?Q?DfC6jkS6hUnv6VE9TPp5SE4K2+M6rKlmsLCAeBMQ2sXowAh9O1AuOR8fb0YZ?=
 =?us-ascii?Q?gRKVZUxBR+m5u9XEc6GCzCEtdts5BTkTcO0jZWL6rwuvlq2z5phC2UkeCp1/?=
 =?us-ascii?Q?rqT47Y0bgTSX156ILtzwxWnAPPBcfS9Fr6BsIj2vjbMWYmF0jR8kw1/Gf+qF?=
 =?us-ascii?Q?FU+rZD4HDBpTvRRZZnWB+LKurWCSLE0QoqvhC+Y+11ePtAR9ut6RT2YOXuw1?=
 =?us-ascii?Q?G/74MdECWYo0TR6TpU9b57+ogeclNrWNxA8/ssqDeKHycZmPBRGQm84RycLz?=
 =?us-ascii?Q?nwWwxoyPEEurS4j4EozptTTFNd7eWtgHxuMBK2P+LIEEdb2PiKLGSI9PsWWk?=
 =?us-ascii?Q?1bkGAGqxi7ZsWXAmp09f0CXN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PA8okGywSawrR5mHW+gaOjCiZEQnde8kEmFGXmClL5i6hni10m6qxXEbnqZJ?=
 =?us-ascii?Q?yV6ngnoiboV5qtdCEI2Yhv9R+2UyRp3U3Ab3bgVThArhBuFCOtWUcQGbkbzN?=
 =?us-ascii?Q?uof6avUQOK5e37NAPdDBblP4F29J5+wD6tzj/i2T2WPnsUe7hFu1T0WzZTfn?=
 =?us-ascii?Q?VMb3QLRGxfybhWibghn17IotFA0XzgSg7YWhZaAdZVRsjlXNZWte2JW4K0W6?=
 =?us-ascii?Q?yn8n6pb7XbQVhAWb/vhqrFpSadBGjmy1y1/+KPaqH8Og1F+Lv/DHw/+S1y+D?=
 =?us-ascii?Q?FqUu3Ep6v20Z6tv29n6XoDDOK/OD+JSzmPjqsB0Uks5d0hLuIjyE1xGWN/zZ?=
 =?us-ascii?Q?CBWglsOoOkKyY/8VjNlp8RUOq/jkd/zkr40mCZ3iSFBSi8TjG6WHlnLsDDiN?=
 =?us-ascii?Q?mklf/21EEAyPG0aOeAWOkJG0tu31/6vQugVNq/Z/EyJJvCVoNJZpAIXmAwzl?=
 =?us-ascii?Q?D+G2IuhmojR6DipCzO/yqHHHJ0tHK8Ptk2ecRXDTVkdbgd51CsKIx2uS+h6u?=
 =?us-ascii?Q?Q9NEJWlPoxXUy18PjOYZspFZt6UL5rtUWom7dGt+VSaH6CHXUuAIV+DSY7O5?=
 =?us-ascii?Q?CDECoCplU/NXdLlibIJlbkftIwJajtKmFemkWReBO4e8dnf3J2UidcobOoKy?=
 =?us-ascii?Q?hPQqGb3R1X3FurNZpPovOSJtVqVX2fUDcNK/vC7FInKZF3dowAnBIEg5hMS/?=
 =?us-ascii?Q?EqMn0gEs+9cZMd0ONwetzDrVHCv+Q/T5Z1M2NZfsDffZ7TqS1EXCvo0qll3F?=
 =?us-ascii?Q?pLyO3CGNkhapK/MqFvFGsghvGTxGDSeDjGJnJ+0DmSkoIwxW+08CH0FWWS/Y?=
 =?us-ascii?Q?myXbjfEkRk0d6noORjk8MbiKeKsXpGqjdcQyW0KcW8352U/v3r8mBjoNzft7?=
 =?us-ascii?Q?5XBAJk3OQmfFwoFFBuWqAvXRCfe1kQuB6LgEnjUKO1VS19nLb0SzrdncViH1?=
 =?us-ascii?Q?SsrrETW8hicu02FC+aRoqJwqJXUn7G3/oQ5UCpe1co48z6qrgJgjk7oLTrvy?=
 =?us-ascii?Q?1IYCiuwY375iyEcdN5JIOy9k0/KJVN5RgkxjpRuGpaA3DqxULtl4h3yUrtF5?=
 =?us-ascii?Q?YCBuk+ptMNz7dsFsUwJJDvt9AwZ5Uav5sK09Z3BFU+r+P1/qdkELTBrWZEax?=
 =?us-ascii?Q?oe1BudEbedl6ZRax5RLDuucErB15SoYZLmR7XetmuhM77LmkN86Dg9JLdz3R?=
 =?us-ascii?Q?4GrTFxqTLOU0l/u0Dl4KPIKZvi98PIgl69auhHfGmSK10TTIbv6lNONq84X5?=
 =?us-ascii?Q?RCc2ZpimXkmfMDw0oGitUkjqLpb0O7mUcDGbG9tjAZfVQROwDiK+v3UPIM8V?=
 =?us-ascii?Q?cbwdG8UBeZeIvONQoVv4hw6lRh9nUuMPjXhHfbWY9c0oI/bvVbHRTvooctyU?=
 =?us-ascii?Q?OLyuoTi/ALY8wp/Y4iUGggFrrcbCECj9gsUt21GyEZu+x+hVZBtacfLP4zrG?=
 =?us-ascii?Q?iraGhprjtBlMcjkzqorNT9QrRh8yYTvtAqiwRiGgcKCECNzBuu8bIKbtf0IG?=
 =?us-ascii?Q?6fQbVtp0loD/4H8BNSt+jR7O8eqgIqGPdBqdoRROumZtkhYyiY5EHkUuQ4do?=
 =?us-ascii?Q?+SdvTvVy9Eb44nSlVmjNeWzxWsD0Ty0Zy5nOrz91?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb14b8d5-117e-4dcb-885b-08dcab84b5da
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 02:02:45.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8c2uQWJB2v/u75al/Dtz7XyIwOPM3UcZBcFh/jc+uGZoCbMpSt9HbJiuuE3mhPj1AXpbCZL+1ZKH1g5WvCWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com

On Tue, Jul 23, 2024 at 08:18:41PM +0800, kernel test robot wrote:
> Hi Qu,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   66ebbdfdeb093e097399b1883390079cd4c3022b
> commit: 400b172b8cdcff87038697169fe9e4222120dd9a btrfs: compression: migrate compression/decompression paths to folios
> date:   3 months ago
> config: loongarch-randconfig-001-20240722 (https://download.01.org/0day-ci/archive/20240723/202407232006.7Gelsbv4-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407232006.7Gelsbv4-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407232006.7Gelsbv4-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry, kindly ignore this report which could be related to tool chain upgrade to
loongarch64-linux-gcc (GCC) 14.1.0.

We will further check whether the issue can be reproduced on gcc-13.

> 
> >> fs/btrfs/lzo.o: warning: objtool: lzo_compress_folios+0xb0: unreachable instruction
>    fs/btrfs/lzo.o: warning: objtool: lzo_decompress_bio+0x140: unreachable instruction
> 
> 
> objdump-func vmlinux.o lzo_compress_folios:
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

