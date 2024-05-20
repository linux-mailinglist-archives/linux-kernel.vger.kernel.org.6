Return-Path: <linux-kernel+bounces-183417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAC78C98BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AE91F2165C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 05:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A16134D1;
	Mon, 20 May 2024 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ipd7GUZx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3EE33C7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716182502; cv=fail; b=FxMXlkR1j2XGCJjGWn4IPhR/uQ/4GxWD5h8YKYbPy9+bfCVAxaoVelbK+wpO/Qzvs6G3DR/KheimH3LMAb/lHctsm3qT6IPaifoA3T3EJigwl+/ilEIWD0EkOxfXJB+7VqsXTkGSUOgkGKD5WPvHHLsQ3DZWPACOfEw3psb7lJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716182502; c=relaxed/simple;
	bh=ZsmfZ3nJY/JxXcSCiBZsZc+hc/NUBmZmRx3Sm4tMwpg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LgnDXGwOnasKQk2e1B8bBUl68/QgJ9mFuleAcAD5NL0iBbXQ4ZNVkARjuAgkaEXzWKHo+n5z+XGHpHxlUXAD2yMZ75e2DSob/H/+BBZKhASJZx1y6zV6ER9vsU0LsHmcEFk+L9dX9qo0UtQA2OhCkDWcEjqDwNIbyax5vQ5nZdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ipd7GUZx; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716182500; x=1747718500;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZsmfZ3nJY/JxXcSCiBZsZc+hc/NUBmZmRx3Sm4tMwpg=;
  b=Ipd7GUZxftImQNwiMnCB1D7IV4D3I5BlKe5S44rsLeDjh6a6Gcj6BLcM
   dAUSm92Eqz2dwqq/X5apriwulY49p7+6FaOiCB8yi+evzlDamnhSW4D0G
   thxXI5vX/7RM+knHmRK/r7obtnBy1qyhHblOv644E6EHZjd2bcLZHMbql
   KtodxvTsEPFpXnnvr5bGCN1T75Qhy8+Pe2WFv+XPaZq4TkqWjcQdlvotj
   mduzVahyijnTyqPQPhX4Ae0UCOcSb47KzFST8szQN6CyGYuf9X7Z1Exf7
   NyJ32F/zH64QBnJbq8tUPD/KsivTZqiS5yhm7NauMaQxjUDRn3w8XonEz
   A==;
X-CSE-ConnectionGUID: QSN4ZEKTQ5mYZ8WvziwDHA==
X-CSE-MsgGUID: 5iAJcJkuT1CVm5KLVL91rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12139281"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12139281"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 22:21:40 -0700
X-CSE-ConnectionGUID: J7bgapjlQn+YRVjSfrZUhg==
X-CSE-MsgGUID: Jn7Q7M+CSFCBIFJOT9xTxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32839055"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 22:21:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 22:21:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 22:21:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 22:21:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 22:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbA+1Xupvn5WfpiPIrxwWfta2kVFG1zKrWJxgmLpW6K2qDMYW4x4lSPB8OZigq/L+WcwaMOSamXrNPnNjqkZctYXaSdHwz4MfaHRSeTCKr626K156/VkqlWahm8X9x9j5mIXpOr6VZ7D6+pexjjwGtNFGfuRbhc+CK2pp8MhYxwtvC4GgZuxmJTcOwS6chRg4VCGjfZ4L01pzEeM6cHflnh1bMiYNR+HkvJ54DuUfMOt2XYYkuFWddHd9APAGEVYUEQNQmEjgVJFejzz5bAphpGDCNTOzIQBXXzEEXlD5nufMyc5RteqOca7EsI5aymefBs8F+0c3ydp6/UfCrSb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMG3XcHSaOI9XWJ1r9CM2Jux1nGJzVHukGJtd/QqHno=;
 b=IWh3o4czGIx2C7Dz7CfX2riqFpzuPZzRP5l/3BGYrBqBcdWyxgsqtPTgaplXS1FM70Ndwd/TR7gCfp14g8MRT+DGs/tRlAu74+jm68Qi5hh4A4QuDW8eJ3SsPDa6xNUpu1Pa5O2uEA15doKNDR9m5X84IY4InIpXegqQoDESBVGxVRYtmB+lxHiUTElpft35KJ+M9mQqMRCUkjSYmBYAdoy5euWvGL1wUDgXexKoecV1AhloPIfMpaAupBdmy9FLgqPwim8i0HrRCiMRQ9wwmb35pYiHCkosPHmUfenLdm2EIthalDWtRFqmK+jXWXEj6PmnbLrPBaOw6FQ8xXe4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by DM4PR11MB7758.namprd11.prod.outlook.com (2603:10b6:8:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 05:21:36 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 05:21:36 +0000
Date: Mon, 20 May 2024 13:21:32 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sean Christopherson
	<seanjc@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, "KP
 Singh" <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 1/5] x86/bugs: Only harden syscalls when needed
Message-ID: <Zkrd3Cnh8EBXwGAR@yujie-X299>
References: <982d05a2f669140f26500bee643011896d661094.1713559768.git.jpoimboe@kernel.org>
 <ZiYbPZ1biNCEndKZ@yujie-X299>
 <20240507051741.4crk2pd2fuh4euyd@treble>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240507051741.4crk2pd2fuh4euyd@treble>
X-ClientProxiedBy: KL1PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::31) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|DM4PR11MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7337d0-945c-4598-a1f9-08dc788cb80a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KQSEihKQu1MgZ1LGf6xRKQ+NFVqcwoAZcCWnpOv2xqcvh0OB4X06Htv55bVM?=
 =?us-ascii?Q?St3/j+Td/oGXE5WDWErLK0w6XLJhqAdgHVINl+xoPQJFqzt/lA25gJGrwq+y?=
 =?us-ascii?Q?+P+cggpTYgTtMygPjvX0YX568pGeo4k90ADrjVJqrZHrFmt5KH4hvNFJ016I?=
 =?us-ascii?Q?zAKTVsM6fjXIU+k37BPTDk+8t0+33GhS06Fxtd/tJR9MZspCeOMZb3AAXw0E?=
 =?us-ascii?Q?LajhKPNQhBC9uZrcKx6ZD8pyfUGJBA1/ovUMlOexQF+89j6BlA2636e/ff9W?=
 =?us-ascii?Q?3mbwaOR3tGI9orGBv7seCbONnZtfs6vJGDmzlQp9ghskp7GAQSF+04u1jwlo?=
 =?us-ascii?Q?GMa7p7pTOJyNqDrnA5zsXkeUh6am2sMdkLNY+DIH0HIrK1AKEQHJ3xP3ACmN?=
 =?us-ascii?Q?Xw18UMj5P8Kq5kkciykRszlMDvN1MYAeSfxS/AJtdatCItqYEirtrvw65tQD?=
 =?us-ascii?Q?1fXyoxkMBUSBxIid7oU2M2Q2coqmyyNDzR0LFgPo0nGDmbnAYsPBb68JEiTh?=
 =?us-ascii?Q?nJ5Ha1RPR2iy35fGrHeiFCmVQesRDU0uDvhUBTP3NSkAk4rBaUplnCO9Il8f?=
 =?us-ascii?Q?Uc68AZJ4Cj6zbiRT/a1RAxKUdPqBxnr0/GA7IokE4d1RRTmtMygltaOZMNoO?=
 =?us-ascii?Q?WUdHc5RW+m+7Fa45UzbiHFEfxt7B4HSPaKrk1+XLzW9HMliHQ3YiZarFFp4k?=
 =?us-ascii?Q?XYsF6NnK2chmjt76M0fV6jv5KwFnkFw1tXjXG9oi/a/7+nFdOOmQ8KT1QCX0?=
 =?us-ascii?Q?t1K0GWNMZ0qR2LS9B3pPm5IVE8nTELCEtlnEHK+RB856k2dUiT1c8HhA/1nD?=
 =?us-ascii?Q?d7eBLEjNB9CuoLRj2Q3iA2394+2kTwErOlaEFROE+bkftWk2SAAFe92hqIRS?=
 =?us-ascii?Q?+jLkpjyk0l/qVYzetsmRAm7x4UNeXEygLuBFa2n3QtQtjFInfn+qbrtPGsD7?=
 =?us-ascii?Q?EFf03qjx7COesvUaWM8veKAXz/utXCbC2Hsq8V+KSQTF0ghLJ9hUvWOvE91+?=
 =?us-ascii?Q?F6Ubc+EBxQLnuo/h9T536guXmetMMmXY+7lmZg9sddkS5R488vIXAeOmvagE?=
 =?us-ascii?Q?pjoQlqPEcltr6fq5n24ICZZLzSo8yFbcku0BFGbwGNeQE8e71HdwMF6thqvs?=
 =?us-ascii?Q?QRI9glD7eX8t4BFjf7CZH4oIPlx/0DV+MbZKfpE4/7YoLFuRQj7nb1g+SVih?=
 =?us-ascii?Q?aDoipUb7kMugOIq2huTm5u2zz1HNv5oR4Pyv6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4WmQLBLH4785qiqUQaAQwT+mAOlz6baYUWDS2nImX1GzWzCAiglad1h+rit?=
 =?us-ascii?Q?MTpzXKg6Vaeb1J0TiEAdTvqZJsVL/gOZUHeib1jiLokjYLsZRrz3qKqvj84x?=
 =?us-ascii?Q?Fx4gK1PuT9QRc0q/9XaZWoL8DV5QNGjcihkOjB8MfNsERL/iHJRa5Upy1rAW?=
 =?us-ascii?Q?JGZGUYYHz6P5s0ogw8Bcuxz6fcUx2gauwn123zjlning3yKoRBN2WSz/G+Sc?=
 =?us-ascii?Q?7JPGEWOyHKsg+GT6WC35ycjCb6BufHtqJRuvdf5TJvE5SJFE703ZIi40a1l3?=
 =?us-ascii?Q?cjfsqCkaZdQ309XGWi33G3whC2hespckl5AqHPSdzkgJxXkuPFU9egWcFgmW?=
 =?us-ascii?Q?Y5Zo5ycsEqGdmbnRhe9aE6Rk2yXfdQVQlAHCbtFMkALIYl5yi9A+F1iRokjZ?=
 =?us-ascii?Q?s5xbTegQxeKhqTTbxvwNw89x6z/aqFtGQ92yScUR+KBRLCwUtiMkubBxpukD?=
 =?us-ascii?Q?9y+wI0MDG1gpl2EhtTQqWbrzXd0kKxBWJFiWoTIO/pQoJ1ESa9NQ2z7yH2mh?=
 =?us-ascii?Q?tMrnTWNf6YKTjDcBckOi+DXOb1Ci/7qQxBJFAVdy1KBZ0dxRyKzVV3GrTcZM?=
 =?us-ascii?Q?BvGW3Mt24tsugNKY79feaK9LZ1wSpDRfY/x1Hogx7mkJYd6nzI8mahlbwU2m?=
 =?us-ascii?Q?6fLl66PWrIvW6RpiRn/LCdYJStKeD84LfCm+BGsX5FxPpatX7unZ4W5B2l5X?=
 =?us-ascii?Q?fQG03OnT+NRvD01o0fAd3nW5Ywu0pXv0Fa8yJpwOTWEoMGPUD9KWdp9/lSVs?=
 =?us-ascii?Q?KZ11+4o/ANovnfJUlYilM/wAIrjl1POvKIoVr++84SwrMOWjHKoABtAliuaT?=
 =?us-ascii?Q?Uw9SdDDuDtTjb3FLeWy6b0jroE5YMSG5qMY2FS1tDpxlf5mR4Ev3UsqcZ0uA?=
 =?us-ascii?Q?UnUqtSoQTiTOw7p6o/kYBSwIFiSWTQXnZ8Afk7GCbGyEo9/rZRzaO4WLSRYM?=
 =?us-ascii?Q?tn4qjDo3N54vyPDRV4tM+jH7Osg7E8mTNRS/n3caK86d/hfuX9nDh4/kRNNI?=
 =?us-ascii?Q?WpMM/rFHVjkiKpHYUujlAP1lu2ZTUqwOG/azJYNkawi4O/J6HmQ0LKcgEfIT?=
 =?us-ascii?Q?7EhgGmUkMPpqYLQmlDXUOjfAxbktLFZOulTeB6dqAa5JmTM9r1xeexhlH8IU?=
 =?us-ascii?Q?NRTH1AE3jDxlesmH3iEdzYz/l/CKMMSdqDTktf7vsQmmTXvAuMAywmncfaSZ?=
 =?us-ascii?Q?tgG4QcROJKoNli0yhxnOG9F0bSekGotMT+PWa/RWBxOQY3nKEdjZNRLEkqsH?=
 =?us-ascii?Q?NZQfruLWQ1MxyQda2/00bhFyhTh7RPslGfxvQ/1JBH7OZNVkInDLXM6IJD17?=
 =?us-ascii?Q?RqK4coZijX4Io1kxgaqRxeowp03boEvbpknrbxOgHOZKUMwW5gTcLTt9AuG8?=
 =?us-ascii?Q?A6GijJ0MkUCjSK2AR/EgQ2nkNuWkjABuBwetO3WEUwVs3hwtxSZaMR2mupyL?=
 =?us-ascii?Q?LzT0w03/er9Fo3R+Yj4W/+jeu58//Bl3rDeqlw+C9njMicT600Z8/QBU4638?=
 =?us-ascii?Q?PErONSUq6TXDJlkVYKPm/1V14YWqrggPLjU8un88oFLR2YFYWwl4zYtKuvQL?=
 =?us-ascii?Q?HQrFWB5YEcW1wjwXGxp4ukngRzL6EfoXGZ4KcX1r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7337d0-945c-4598-a1f9-08dc788cb80a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 05:21:36.1540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lllULvm0bnQmMmsCjIxZwDDydVmfE5/rhw90wixvuGOXEDLtI6IItjtFHptsSGh237wQjH7aEKOn2A9I5ZtZLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7758
X-OriginatorOrg: intel.com

On Mon, May 06, 2024 at 10:17:41PM -0700, Josh Poimboeuf wrote:
> On Mon, Apr 22, 2024 at 04:09:33PM +0800, Yujie Liu wrote:
> > On Fri, Apr 19, 2024 at 02:09:47PM -0700, Josh Poimboeuf wrote:
> > > Syscall hardening (converting the syscall indirect branch to a series of
> > > direct branches) has shown some performance regressions:
> > >
> > > - Red Hat internal testing showed up to 12% slowdowns in database
> > >   benchmark testing on Sapphire Rapids when the DB was stressed with 80+
> > >   users to cause contention.
> > >
> > > - The kernel test robot's will-it-scale benchmarks showed significant
> > >   regressions on Skylake with IBRS:
> > >   https://lkml.kernel.org/lkml/202404191333.178a0eed-yujie.liu@intel.com
> > 
> > To clarify, we reported a +1.4% improvement (not regression) of
> > will-it-scale futex4 benchmark on Skylake. Meanwhile we did observe some
> > regressions by running other benchmarks on Ice Lake, such as:
> > 
> >     stress-ng.null.ops_per_sec -4.0% regression on Intel Xeon Gold 6346 (Ice Lake)
> >     unixbench.fsbuffer.throughput -1.4% regression on Intel Xeon Gold 6346 (Ice Lake)
> 
> Thanks for clarifying that.  I'm not sure what I was looking at.
> 
> I also saw your email where Ice Lake showed a ~10% regression for
> 1e3ad78334a6.  Unfortunately my patch wouldn't help with that, as it's
> designed to help with older systems (e.g., Skylake) and newer (e.g.,
> Sapphire Rapids) but not Ice/Cascade Lake.
> 
> Whether 1e3ad78334a6 helps or hurts seems very workload-dependent.
> 
> It would be especially interesting to see if my patch helps on the newer
> systems which have the HW mitigation: Raptor Lake, Meteor Lake, Sapphire
> Rapids, Emerald Rapids.
> 
> For now, maybe I'll just table this patch until we have more data.

FYI, we tested this patch on a Sapphire Rapids machine in our test
infrastructure. There are both improvements and regressions across
different benchmarks, which does show that the impact may be very
workload-dependent.

Intel Xeon Platinum 8480CTDX (Sapphire Rapids) with 512G Memory:

+-----------------------+----------+---------------+------------------+
|                       | mainline |  + this patch | (percent change) |
+-----------------------+----------+---------------+------------------+
| will-it-scale.futex4  | 5015892  | 5118744       | +2.05%           |
+-----------------------+----------+---------------+------------------+
| will-it-scale.pread1  | 2720498  | 2721206       | +0.03%           |
+-----------------------+----------+---------------+------------------+
| will-it-scale.pwrite1 | 2143302  | 2164511       | +0.99%           |
+-----------------------+----------+---------------+------------------+
| will-it-scale.poll1   | 4046943  | 4095046       | +1.19%           |
+-----------------------+----------+---------------+------------------+
| stress-ng.null        | 19400    | 18689         | -3.66%           |
+-----------------------+----------+---------------+------------------+
| unixbench.fsbuffer    | 369494   | 364181        | -1.44%           |
+-----------------------+----------+---------------+------------------+

Thanks,
Yujie

