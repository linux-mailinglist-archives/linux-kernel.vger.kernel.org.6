Return-Path: <linux-kernel+bounces-514608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E30BA35942
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCAD3AF662
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C41227BAE;
	Fri, 14 Feb 2025 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHmKLpbG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD8227B94
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522712; cv=fail; b=rXZZ1pnYgHG18H+xhbs5GjGgCKPLyAzsy07hQEMA7RJdzPihLUICzcPbD551e3Baeq0pR4F4H5ehh1DUC4TaLfHckmr7l4KaOAcJna921tbrXtklVKpAdY/VLHLP78LaEoWWnH2zwaBUL0xKbNKkojFuK8HT6ig4vBOpQzh8mDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522712; c=relaxed/simple;
	bh=PFnP+InWpl88hjKekA4Q2V9Eh+L3bN8iKijjRUVwcaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uht/b0IcDDucZz14gHpJKZsY2HO3LrU+f1ne2mnGEJPwM9iSfw/GfWyrsCC8OyL1tLbAuOpKoEJON5QzjqXVWNcY2E/0ahz9uFqnN7C3K7VXh0cU3WqRF9FtVgmzNrF85OaCHJ5jidKrFjuAYiQuIOJDNIXuB2JNq6fHVkTNsSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHmKLpbG; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739522710; x=1771058710;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PFnP+InWpl88hjKekA4Q2V9Eh+L3bN8iKijjRUVwcaw=;
  b=UHmKLpbGc7/WGXe0ZMkLP+VEpyGr304Vrv1w1AGJc614vIqVdRZK7qzs
   sKtFh4X2X/RASjInVRyYjlPOjJPNqSLrh/PLgjpIJnTmsWUAoe1KI7a8c
   Xj316e1ia5u3umz3uCmYcwIDy5EwP1AF+RObZrjeMuAzTRRystDtbBTxo
   9/eyA19xM4Yrshcn49NJnxI1Mk8sXSAIC4+dqmjwjGYDP3hkEcMWTQMQ+
   d1YvebE30XMTxYct9E719g4JwvJEsZKVHElAXAZihxO+F35qOykF0Rdp8
   LEkZobo8vPICAJCGQw/MFoe2JEtKWsSGEfUEwJugSY58WVlXa3wF+lq+y
   Q==;
X-CSE-ConnectionGUID: hwEtCFlUTe2uXgHh+GPSyg==
X-CSE-MsgGUID: cg4HW6F6TMaMau5QTkt6kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57670988"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="57670988"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:45:09 -0800
X-CSE-ConnectionGUID: al00anAVSJCbm/MEaL3zog==
X-CSE-MsgGUID: lYngh0GYRvCv3ufGeZyyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144337866"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:45:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 14 Feb 2025 00:45:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 14 Feb 2025 00:45:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Feb 2025 00:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnAvM2iH0cGSMi2taHmKHzGtxdOqUyfed3kqkUs6xe7K/cCnYnF1hqE9wavy4OYdZBPAR6wuExC4Z5YKlIETVG0ytnLeOQUPnmCevd4SR1Fe4skDLt+FVu8NXnb79f0j1B/fbzu+L3zdDdcPncDbwcDTt8v4vkJZkSva+2aUlFl3LMNwLgnhoFF6+8zjt4z5eOia3+RIfkZNXZO5aCFxSpvHmA/m2drUKucH8Om8EPm2SdYLSvmb8sH6rNyr9Z5vRpG+mPSWGl7xhLgcOn1qp+vtc1ZfeNBVyuSQf7OqWu/r1vsTE7nwC0Rj8fuULwKlqRuzIjo2k8Uciv3mnLtrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctQ3hlxlkGvYr2Cj/hDIcwhWfIhcWS/z6vmYoBlMLWk=;
 b=jXOax1gjX4xKrj3XsG40Vz7xMmofhnFHj1azinIrnu9j0usMR3rQ519/4ng9JyiXo5d3qtB3iRXFwerbJjunFFwnaC3CYzJQI3w2X8KsdwVXy+TWtLUSfIx7/Vi9ZY5odrV7eRbOmutL9bYhnv014fGxjQ0AZO/DlGl2RgJyDXW8vPXSYHXtBJUR9VQfA1fw7zjRo3P38lwcr+pgLXOGPxypt8iMfMWg+Yxurw0a2MvD/+BusYkaMdAXD6SnbSaLVGiB5YuB9AxXFblSMwhPXmvKe3E6I75iw2Ip5VVcV74vPmQ7acTqcOxLgcOQ1QAujRStWMVNealkI83+OvhgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by DS0PR11MB6518.namprd11.prod.outlook.com (2603:10b6:8:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 08:44:23 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 08:44:23 +0000
Date: Fri, 14 Feb 2025 16:44:15 +0800
From: Philip Li <philip.li@intel.com>
To: Elizabeth Figura <zfigura@codeweavers.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: include/linux/thread_info.h:259:25: error: call to
 '__bad_copy_to' declared with attribute error: copy destination size is too
 small
Message-ID: <Z68CX3HMEUW00WYi@rli9-mobl>
References: <202502072019.LYoCR9bF-lkp@intel.com>
 <2421077.NG923GbCHz@camazotz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2421077.NG923GbCHz@camazotz>
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|DS0PR11MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae696a0-7b2d-40f6-0a56-08dd4cd3c810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KtZa0JcF2aci0ynbpGvctPYve1uSUsKUFK0M3prAFEGNR1XN2oRXWvLPeWV1?=
 =?us-ascii?Q?sGQk790vN+Rkb/9yDrFoIGWTf0EzLYOWc2U9ODJgCNn8N57p0BoXBPNv4Fku?=
 =?us-ascii?Q?0vCpRK49c+dSVuc7L+VzW/oIT+mYHajxK7veWdtcNdvciriiErsTaiuJ+EpG?=
 =?us-ascii?Q?CzqmMI2kYSS2KhoM3U9zIPQ3JinrHReUe0ZAc7uUJrfeKWT0RQ6StGdDWhH2?=
 =?us-ascii?Q?KAhz4bwd7M2NOIXPBV3lVGbJxhtx3iypH5vLZaaQbX3esa+jpMDaLK6HZTCZ?=
 =?us-ascii?Q?JSblCL2xxftZC1HHfPDAdEHUtUiy57ohZbNBJFxT6TomREs0F7Vq2yE1JxoQ?=
 =?us-ascii?Q?2Y6xKOx6rJydDOKEcUIgPif7kbLZpPMXYDSaZpPQAbnxhGwUfwN3vJFxoRst?=
 =?us-ascii?Q?r+6uLlbaztFa19WXsUoe1ZYFKk5+JlXlhxjsLriZOcAYQONgllmi2My8bap4?=
 =?us-ascii?Q?Tuo5qlBpB3sNe0R04edS+tEa7QznXtv17IwH6Ci6jyyahh+Mz3tu7pVrJjrP?=
 =?us-ascii?Q?KSeTYBAxqavoWM5dvycqxgWSEUASWy8sOadRES9o4uVrMIMNOqYqX7XiHcIx?=
 =?us-ascii?Q?u9D5pDcRJjroqxXFkJAraJOyuIxw7TrdL9gK1s25+/3GlF5naCXC43V6My36?=
 =?us-ascii?Q?6ur1nvThasK7UFjzhIOfnx/XW84waT2meN+TLZ4VYgO8BTxFbdwrDK6N6Cmv?=
 =?us-ascii?Q?0pM9yspXTv3wUZj4BFZy3gxR4Zs4Yld4hQjP8rp2/dY/s0loxdKJvzulTQA4?=
 =?us-ascii?Q?U0OvPAUzX4DysN+Ht9TP/XEMFKXzgr8remM6Z38J15QJHManVFMzRlIfSj5d?=
 =?us-ascii?Q?3Aoun4uhMP/R/Hqqw+/qVNMzl2d8ZAkYGNK6GYlqWfQ3q8YU/czBhjKNVxUA?=
 =?us-ascii?Q?wfFnDE3fw53wR7L23NzscJT1h7x2hGqWEAaZaK6s7L78zs4d6HFR4Cx4GGVC?=
 =?us-ascii?Q?d6qUCSjQDy5Y5EGPjzLqbd6SsHi260z23OTxGoITjLSan+y32jY7+46NeBRh?=
 =?us-ascii?Q?HLCFtrEqGhFzE5GEHj9QSlgvVEdD+bgbLJZfUL7eMpZrRCsDZfV9vk+rc6De?=
 =?us-ascii?Q?j5NfGDQ/TnoQCFdSnuNLzWgrthPhWg3EQ53lDvz2l/uWACriVhtFh673rm/A?=
 =?us-ascii?Q?/hN10REOOZ7wD/JwPyFb82cLpqapsSKSdKZJZWtWBhvavGypForxj5htxY1B?=
 =?us-ascii?Q?siDxMW0fR7iY+WyIAvrTGjVdcFmp/s9xB8bw6UD215roz40B07amSmNE+HVU?=
 =?us-ascii?Q?X4PmMHdEGGiYUhLrrIj8ybXweOpNfKVXJgCgWtYWAydEU1upSkJrMI98SA6U?=
 =?us-ascii?Q?0FMnJmhJFK3LC/MZtYr9jPbUpAKZZZSU5Kjg5CqmKhjgbtzybtGgnvvX92GK?=
 =?us-ascii?Q?aljLaWR8u8Cw2rzzmxuKlhDieQ9V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhDDSvLeSE2NRV4PHbnpmpHYeLNU6r6S78E+gfK1b4WcT4m9NAjXLmuoOKKc?=
 =?us-ascii?Q?CtKBsHcX6kV2r72ba1WCsSMdyX1gDtIArxE3zW/6WVVHSsA4RAFq6vhwUuAV?=
 =?us-ascii?Q?UAxiAOzYSW1M5se4g+C0vYWxCPWX7QhJs27krvEU+KbxfBGOhb6us/q+lsf9?=
 =?us-ascii?Q?gg7DxUA5qsTG1iIlXjgEq4yrmqB4q+94z3XCxnJYl39BetEAXLUabjvNX+xf?=
 =?us-ascii?Q?6rapah/IThBAEXbrr642PN6ilDCRDOhDaIlI1TR+iwpYh8ARmdSQf4pfGEgq?=
 =?us-ascii?Q?Fk+I7D2tv7zCLEjXOCv2k0Jy9RpE+ZyQrmpiCYqqVFxYku+LmRD5FQrRSjDg?=
 =?us-ascii?Q?nZqJwnUFT8GWxnyfGIHhwBr+7XrtDeb/SA+WNiN6DDCZVJQ2CsEytrqIOYkS?=
 =?us-ascii?Q?oC9whN7GJAj6uCnTUmbMsH8zFkDDBwsloLfSyx0QhMIl2G4MYz6mLBG7UIXm?=
 =?us-ascii?Q?9VUGmmpAOF5ZgzPPMLSjg3gYKRkVjkhltvTRPS/Bb6vnGs1mQBEp4GoejlZ4?=
 =?us-ascii?Q?XfyZi6JGYlyqnKptXlkzHT3o1GUIxDfYwQ3fZ7JoEwntq3Krfi4ZEOBhgbA6?=
 =?us-ascii?Q?1YQSOAp4uM8UvoYN42w/vB/JBD2t/ve2dBNNeE4Xk3jZgN62HGJ7rqlt+/sA?=
 =?us-ascii?Q?cAb5LeoCRnjqiFw5enQOu8iY+vEX5lsNBDsokeB8qaV5qnnN1cAyqe1BLoaU?=
 =?us-ascii?Q?rWkJTsmCx5Cgcfck04rqwK0W6WCT4Sz1BLXQGQVUZ5N7Z/KizN+NKXsA4ARk?=
 =?us-ascii?Q?QlkmNWf6M5WecuWAZYyyJB/9eJb/vsbrfVpq1UjmfYlzlpBvYJS6p6e+6iD3?=
 =?us-ascii?Q?y2RihqyO2y0lAvvwNhplOHoiOO7ciDjrZkRNLFkjEsA1t90WCorTwAx5DAV8?=
 =?us-ascii?Q?FKx42GpMTKOuotCKU7bBPWtgf+jjjYaA6FCYvBDwEZe7/4DroWF/TQG4C9Na?=
 =?us-ascii?Q?guEdWpaW5pWVsLy8GMhzqbDS0ZM/X6cTaA0PsKzODKLQACfDICWhoy23TtIO?=
 =?us-ascii?Q?ENhbJ/641Ga082THsxzV2LtqGTfbQpnG0Fe80Sl7T8zdigy2Zck5XNtbxWtV?=
 =?us-ascii?Q?oHjG1YND+QNhLLwXJj6qA0PDb7KJQhiZOyp3tQL3JNt+eRO6D2JauWTPO0Ku?=
 =?us-ascii?Q?cqinAMD/1jGKDPfR+ldTZJ37k91AgfLGE6IozN81RfE0QhKuNeEJQXIVbXuX?=
 =?us-ascii?Q?K8lvfF/jkZDZSfATuqqE8HPmPmXy5nKViQVtwA7ZT6RyWVG2CHsgL0oCuYL4?=
 =?us-ascii?Q?HRwgoUKycOrl1/sZ1r2U8dT/WD+Sp4s6daEm4kK+6z233NYXwT1bazUNK1VF?=
 =?us-ascii?Q?OF/qxM1kijk4EoLEL0Jawa1mTLc8o4hypor8xiOxnqI04BtVKsa5mohkoqSh?=
 =?us-ascii?Q?hyEfmBAh/5sS002Dhpp7bz/jg0HF6cDMnIoen95NcMU/ziBJUEDTFDq2Y2cH?=
 =?us-ascii?Q?ttWdAVedxObWoSLcyFWVIz+sBGax1yPqTYwNAH1rYLT0w6gdLKcQOtP3m4kW?=
 =?us-ascii?Q?DaGV6m2iih2iaHAX4Et9nC+q+3yUTVajiAICP/O4DtRF9SLLVC6+RbAQ018c?=
 =?us-ascii?Q?CEBeh/b/3sffcsqXm08hhZlAz90XJiM8H+1pSlhY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae696a0-7b2d-40f6-0a56-08dd4cd3c810
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:44:23.8073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oema/pvi3jJtMEZSJwzVjLpBGgfD4Gzej1N2VlP13CC0o1zQ/Tk7yrcwPD1zGPeGCotOgeArD/rSKamNbntKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6518
X-OriginatorOrg: intel.com

On Mon, Feb 10, 2025 at 02:39:46PM -0600, Elizabeth Figura wrote:
> On Friday, 7 February 2025 06:11:47 CST kernel test robot wrote:
> >    In file included from include/linux/spinlock.h:60,
> >                     from include/linux/wait.h:9,
> >                     from include/linux/wait_bit.h:8,
> >                     from include/linux/fs.h:6,
> >                     from drivers/misc/ntsync.c:11:
> >    In function 'check_copy_size',
> >        inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
> >        inlined from 'setup_wait' at drivers/misc/ntsync.c:888:6:
> > >> include/linux/thread_info.h:259:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> >      259 |                         __bad_copy_to();
> >          |                         ^~~~~~~~~~~~~~~
> 
> This was caught before and mentioned in [1]. The suggestion there of changing "args->count" to "count" doesn't help.
> 
> Somehow gcc 12 thinks that the array_size(count, sizeof(*fds)) parameter is constant, although it's finnicky and depends on exactly where __builtin_constant_p() is evaluated.
> 
> The bug goes away with gcc 13. Is this worth trying to work around? I don't have any ideas for how to do so.

Thanks for the info, at bot side, we will ignore this error to
avoid further reporting on old gcc.

> 
> [1] https://lore.kernel.org/all/21811752-06d3-44cd-b3e6-f8124676df87@app.fastmail.com/
> 
> 

