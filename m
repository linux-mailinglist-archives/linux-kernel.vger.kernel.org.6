Return-Path: <linux-kernel+bounces-575922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A2A708EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CA91761D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550017CA1B;
	Tue, 25 Mar 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l20wL/w3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058913D531
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926638; cv=fail; b=di4vn+PlwLgUh0z/jMzUFKtzras++BZtQGDxP4ErcKdW4CfZwZ6H1BQLQOATrjKRe7+QdUfh8WH6YPtEMqOd/tqraBeeFetRVmxXKuPkbycG6aaQj+ayqCCt6ALvpuARO6fzGiaeevBSH4WKjFcmxmQPF8n7AjReZBbuYh40GIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926638; c=relaxed/simple;
	bh=/WzTAev5vEgkcbgdzeozSrCCLi4cH+ac1SCSm39DBOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wx8gZOVqoWAjEAi6fU9KTj6kHTOGDf4lybGbPrO6U3ogTgHQCpUZdWTT4NccAyjBNMpijxtdpLNAf7ywS5TXHGDIA/VLG0Bf/PWzjjW5Ez87fOsPriv5tzQw+FZftX7qYkM/uc9YvyMPLJAoIcmfyWwe3OPaiq/F5c7DyfnxTJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l20wL/w3; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742926637; x=1774462637;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/WzTAev5vEgkcbgdzeozSrCCLi4cH+ac1SCSm39DBOA=;
  b=l20wL/w35ufpGZM/bhfnzQf716t8D13P0dr5XGPVtQuZ/vBeWV7atgTt
   Gg5X7im0O/D+rV0bbUwuzGAXGZD0k0yQnvgp9/lX+uNRabfFPetAXSkJO
   IWFZnOmB0PrVSTbDbK8Dh3th5iqqW9Btr//DHQWTEmVZ2cLchZfawv5DF
   j3vvfR2erW699b8bBUCS/nflPXLu+TLaciCsWtvZJz2bcRr9dX0SvekrX
   CrZHgKAPvNAaSoxAzTyZNspXvVYVXa1bnV13vqJwHrbe9iYdPhIfB1fnj
   RYIfZaXo4/5oBecfhqZxGGch78CwroxdLIyTbWPfZavypNXlluxWj1yKe
   A==;
X-CSE-ConnectionGUID: phHDV0MmRWe78NDYQgWaaQ==
X-CSE-MsgGUID: oUUcA2w2QAGw888FzhCqCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="48066390"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="48066390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 11:17:16 -0700
X-CSE-ConnectionGUID: EL1HurxLTUOQ+xvqnxDILg==
X-CSE-MsgGUID: sGleODSiQ/qyzB5exbZHMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="129127722"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2025 11:17:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Mar 2025 11:17:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 11:17:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 11:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+nO9STVcKjDwj8kMNF9QKb4/TpS6knZ0c8xXUlI8hEtzwy1fphPWaUBUYZuUzBGAQZaNLu14xD3R8qRohCwTyjScg2e+CBgy+dyTGsX2JidKhkp4Zsk5nROGTg1YF00wH8BNhRcEWjdZxKidyuuOjdtV2WRPzGfybqKtZpMjRJ/OVejJtN2XlWK0Pkg3988Nih+dynAgr2aFuwdNbxtOYyIznoQcUa3xZ/C8HCNSXLjWkpc2eFpojxjBTVmLwWgogqzbuG+dJ31i81A/1rUk9ubUzgNOfvJWg+6KLlAYmyy9LQILHlsruqEP4tzPli/B6+BUXQim4TGjIJPtzfK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDq8zW1PJkB8vyv1k0K4ufFyMh7TchJnu8rqRW/ogV0=;
 b=GUji6ookicEMQh0O54gEmEszAJxF4Bw+nsyDKuyq76ghkhddV9wzsFTldBvlDHTcKRF842MhUA5CV2P9ben9PtERRKKwqvRhoKqokuBnHx76YpEOoCcsAMO1wocjyA3vb4qg9lhd7xFnrsOFebMWGzf7pnneEPt2dPLpNPx4AgnZwbe2XXpV09BfHZP6MsMMEDM1Td2yVB7B5VeShMDtlv3QU7R0+c6zPp6j2fzLeIR8jEHbhefOWthDMWE3Vswr9g0Pu+e7zLZCZpNX5Ly6is/xQd+ZO0GvRj9+nqxHd+zwcS47fPSQzJU7FOWXtbtKOV+DvNruDZSSwAOlG5dN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9252.namprd11.prod.outlook.com (2603:10b6:208:561::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 18:16:57 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 18:16:57 +0000
Date: Tue, 25 Mar 2025 14:16:53 -0400
From: Dan Williams <dan.j.williams@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Dan Williams
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>
CC: <kirill.shutemov@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <vannapurve@google.com>
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
Message-ID: <67e2f315af42e_50a3294d4@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <67d9c447ddcfd_11987294c6@dwillia2-xfh.jf.intel.com.notmuch>
 <327a23d5-d5c4-4227-aafb-9d4ddd90289e@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <327a23d5-d5c4-4227-aafb-9d4ddd90289e@suse.com>
X-ClientProxiedBy: MW4PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:303:8c::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: c10f4597-cf13-4f35-d274-08dd6bc93acd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLAeOV0A8bIeUHggHI5sDsY33kLvoGx2stFz3SQNOTuFdz30LituiCbUPqCr?=
 =?us-ascii?Q?uuup6cPVxf+yNAq4LyE2+CccI7pwVQjp1TlCFT5YFgt5xlFhSHq9ai/BuitI?=
 =?us-ascii?Q?K+Fv6vIqqPKgNJRcd9DzCJDH8/tPTku4XkGMDHUCZ19H3tqipc0wQwHq1XMC?=
 =?us-ascii?Q?QEadqwLTxQgTtOc5Wndw2f/IszusGJyGefLF/NLlRC9YoRLO63F+GSX26Ob9?=
 =?us-ascii?Q?PLkxeJ8aRBrJGbFvm1A7542N7G3PVdPVDAYswLVIOay9+1eXBMm6hGTWKadL?=
 =?us-ascii?Q?OQJ3eoFw0XLZnftRHoyNQeTTD5JnO+H5/bCUOfuk3Fn3bgrJytNnpq3v9PDA?=
 =?us-ascii?Q?R817sWj3gGVmC0iEf0i3LPBl7Zlg6x3Ok3XP05OgCLC5Gwv0cu1kjODPb+uh?=
 =?us-ascii?Q?a51wEiLiRyShwpJ3AvjzQo9Ro/QGh7hVuEy/VaukRidVSYkoeOUsJIkkaDzq?=
 =?us-ascii?Q?jlle8MAS+SmD6Ai/YLL66lFrPEvMRlqggi3IpSq5Mov6jJREArWWX/H3MSnh?=
 =?us-ascii?Q?6E4w7u8V/jLHqUDRh51Yv70X89v9YZrR+vZW3VfYOVYoDpFnhGMtCiblcFQb?=
 =?us-ascii?Q?jXSEDJohsrGs2PK0oeqIpy7MHL5YUZ2MjG+maGkb0TEVhmc7dViboCmJJRnv?=
 =?us-ascii?Q?XpC+GrU0EYRWh0IIXD3tI6GFpfOn0Dc62vosjtsbUfYikZYhYJ+UgVjVxZUP?=
 =?us-ascii?Q?UwjL1VPjlxsZJ28iJH+rXwcQOLDTFc9NXkRegAsNqMx17OthNJqRI3jHpMNK?=
 =?us-ascii?Q?nh3T7B2FXf7YY3ZjoMA27+TJFHMm8X6av5eLaAAYcpOjIyVvUrVan7swEZx2?=
 =?us-ascii?Q?qLRmlgh4kGAE0hxFoDCNrP8NcLCUj+IwlI9Xw3OAMcOe+GA+SA6gtls2Tm82?=
 =?us-ascii?Q?8st9zlvyBWudh/izh9RygW0MJGe2weS4rKV/JSLnVcqCYmq/V8aJfWkkRFIo?=
 =?us-ascii?Q?Oi7EHZC/UqEiALPWTU4sQsh1xJipQpuVT4Lg0yZMswzpTS1wXLqt/YOcjnkH?=
 =?us-ascii?Q?oS+Jxr3hJO7KZ+dADzdyEuIopqW1ud6TX5YfAmXcvIbwq6eAZoZVPaQs7fzz?=
 =?us-ascii?Q?cwAzRjVXv0ItMTbTd7NGUeKj74fUpoS2fbHYPkLtLJt38gfqUc+L4xgjRiXe?=
 =?us-ascii?Q?AZtMUyJ8MBDVhm2xcrWAfZav2uTjBh02ZtyHSrOcCQb3xb7ZOVST6VB9785+?=
 =?us-ascii?Q?MAI6ZLsVHFuMpcFaBez+UpabUa3qF3EGonuXVwntGA66S2GFFbz0/fjWPMEY?=
 =?us-ascii?Q?0vGd+afAXbMEBi2oTaaS2eU0lzweY3w7/27tb8DyIAZ0YsngU9E5jaFz272p?=
 =?us-ascii?Q?oXjLH4nUtNGbYQqVR5QXhBeIItdbYoVsvGxfNbJOVur+0zxJ8bTOHaWfFuvo?=
 =?us-ascii?Q?egnzZzl9YIDpLEZ9+plcv/el1ceU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGGnovZvQu3jtuUgOqvTxh1PiZqtXfnbyCu17IgD6zBpyniqvEikA1V6x0oQ?=
 =?us-ascii?Q?/jIVyzbHXD/nx9HJ7TA7iQZrcnhbjnl7gDcxnEfkCX4LOCSiUeSehZz3WaBz?=
 =?us-ascii?Q?M4sL2zX4p2KmOtHfGtvnIHk5D7/+XLPVk+4eJDP1xNU6Gq+skZsVLCwszc8a?=
 =?us-ascii?Q?7BANbf2tvSOFBvv053NnEhFL5Lt2ZP+Eu4zwe1/O4gwFW9RiYuxL0czDlDBZ?=
 =?us-ascii?Q?HzvvOwxnCW+9Vy8yURjbY3hVFtf4UgLnk4rkvf2x5e1dQrfQVRYxEJ1wK9Jg?=
 =?us-ascii?Q?1fP6LL4H+2g9ea9c0g8tSfqvtWnGv6/TAruC2rOS7qLxfFrbZlP0wfDDgnQ7?=
 =?us-ascii?Q?OS8pu+ND6bqp6OiPQ8SabVb88PhUtbL9tsoAJCHofcKiYBgceK9c3OQUkEal?=
 =?us-ascii?Q?qHtXNwlfotSgWhHAJ8R1DBiV3yJp7WzgOLNsbCA1FDPA7UwJcTGAMaKel1WA?=
 =?us-ascii?Q?dAyN/XcCBD7oW5A6s26IyGJisZypuvshNd8qqvSPrJsy0+u7y3IXamWCGFFe?=
 =?us-ascii?Q?u7TcuEUi0tCKEd3yXZdC3oZrX9CW1Ehs8HMZ7/LZcE4iz6AdatmtKotOst/e?=
 =?us-ascii?Q?gNtFjaljmEqCfFvReXYTCytw33e0TOaIxO1okY61qhDR9TTJ/3HJzWCjh4jQ?=
 =?us-ascii?Q?bJNSZRIHXCth8R+GmCV0CzDzWwSwu2mu0Cm92nqi3E0iLzhSwr7T5+KDA2Us?=
 =?us-ascii?Q?ERR5RHKlrV9fyiTiR6+3K3hLKjxopq1pN91xw7BBHnn4G7ByPp0tdEpShObv?=
 =?us-ascii?Q?WQdhBSBTMQ2BkDTzoWXE+1j4DP67nZF0p8WCqKfWcRWTqAe/3WdJOIMJX9V6?=
 =?us-ascii?Q?ZdVjHGTf77dcOwxdLhc+1MdvMlu9/vbP+qF3vT0K99hWf1TVuMiidE8TqOWT?=
 =?us-ascii?Q?mZENrnTmhg+VQ4p5HH16FJhJlALN2n437YKqHXQyfG9oBGZJkdE0qZ6Odikv?=
 =?us-ascii?Q?65/qN16b4LNKSXMn7GPdAN6sBvfVRV3qnDwqli1UJ+erglMOVnKlDP8Gi8Wi?=
 =?us-ascii?Q?3E9BI6dEzgh4wbGtM1yhVVsO6o+Y67+tEzfNJpltkNMOLIKX0XKF1PhfrrIg?=
 =?us-ascii?Q?nZfLMJyhQQabVSXIu+c9AkXcdIDrDLMVGulCuKxzdFp2l0w/r5AMh2idvwhW?=
 =?us-ascii?Q?KtszV7ufEpi0sZID04L4sklDKrF368gE9O5j2VLXq+z2/zeAN4G5P0fTSLB+?=
 =?us-ascii?Q?gdSTD8ZtY7MXi/Lx16MKh7RIppREq4gewoBL/FKgO/diLMveRevImOf62CiR?=
 =?us-ascii?Q?ylcgO8llP4SHPgCAAfwCWuFoCuDe7EFnQGaI9pHBzm0mIv28DChO9l4Lzhy5?=
 =?us-ascii?Q?bz98TnBKickoawjZMYGi3ywowDJnQWisB9XAchDANOLpdB4vsbnyYdPShbkp?=
 =?us-ascii?Q?mafI9zElqHb3KGQeCIvrUygKQRDlyP1ZSLiaIZWExLkyQ0ZTqIJQqhaF+HpN?=
 =?us-ascii?Q?aibfLIrgg7M5fBTy7zesMm6ccsgT/IUW8KOL08cC0OcDL7MoRXHyjVuveUzM?=
 =?us-ascii?Q?zUhWNifOB8O0xAfADfq0z6UhMmtXs5luVDkVKTqP+a8eIIdQ9D6qR+GlqUYv?=
 =?us-ascii?Q?4GaN18Zwe8Un+r/gHhzER5QT+Vi4eIxZ77KxTVEkDMFES5Hof+glzbOV+r0w?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c10f4597-cf13-4f35-d274-08dd6bc93acd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 18:16:57.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH3L1+3TTCot0OT2GB3V9X+44zVI9N9E4pWKFHgIc0LHfUsC+awimVtVT6W0bJwAtUCegqDCJZC13OjR/2z/S+ypw0Qif1RbLen+8kJXnNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9252
X-OriginatorOrg: intel.com

Nikolay Borisov wrote:
[..]
> > It seems unfortunate that the kernel is allowing conflicting mappings of
> > the same pfn. Is this not just a track_pfn_remap() bug report? In other
> > words, whatever established the conflicting private mapping failed to do
> > a memtype_reserve() with the encryption setting such that
> > track_pfn_remap() could find it and enforce a consistent mapping.
> 
> I'm not an expert into this, but looking at the code it seems 
> memtype_reserve deals with the memory type w.r.t PAT/MTRR i.e the 
> cacheability of the memory, not whether the mapping is consistent w.r.t 
> to other, arbitrary attributes.

Right, but the observation is that "something" decides to map that first
page of memory as private and then xlate_dev_mem_ptr() fails to maintain
consistent mapping.

So memtype_reserve() is indeed an awkward place to carry this
information and overkill for this particular bug.

However, something like the following is more appropriate than saying
/dev/mem is outright forbidden for guests.

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 38ff7791a9c7..4a7a5fc83039 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -122,6 +122,10 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
                return;
        }
 
+       /* Ensure BIOS data (see devmem_is_allowed()) is consistently mapped */
+       if (PHYS_PFN(addr) < 256)
+               desc->flags |= IORES_MAP_ENCRYPTED;
+
        if (!IS_ENABLED(CONFIG_EFI))
                return;
 
...because if the guest image wants to trust root why enforce piecemeal
lockdown semantics?

