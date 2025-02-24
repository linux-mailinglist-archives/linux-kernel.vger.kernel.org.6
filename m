Return-Path: <linux-kernel+bounces-529630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C68A42905
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A019E420FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F2D263F29;
	Mon, 24 Feb 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gL8mI7Qp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C62264A8B;
	Mon, 24 Feb 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416535; cv=fail; b=P9lFuDh2L0sQcJwMN3zr+tgZrGmNlYsQnu4NDeR4MzrWKmX75ArVi+Dfdoyjd3HgL2YfZH8+HAaN1ut/JlMI42L8S9P3WddgiDsIWfv6cz5Id94EllbfoQYcqVqy6hzugJ0na29uNCv4AzcDDm+Ur7Jrs8jnSsEQUetF0adVr6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416535; c=relaxed/simple;
	bh=5Sb7Lvrq6rVa7XXn+W2vbFUI5wTpRYYJzWjfpHKNWY8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rX2kmwYuUl8f+o2RlwfWMovEL0BhVVFBPYHQ5ofuV4/E6B7pZcpV7dz87EoB9VKAEu2n8jDEr+wTK0SfJcllIdCL1AGP4uXfUu4MBtU01HT4CciJ36b77Y6K8DQ71vqSgrJJ6LGDBdUPueyUGguGQYjDZLw+eK+AgDHpGlxjBaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gL8mI7Qp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740416535; x=1771952535;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Sb7Lvrq6rVa7XXn+W2vbFUI5wTpRYYJzWjfpHKNWY8=;
  b=gL8mI7QpKygBkVPowPrEiLB0LjvAjYQ9TtoKA4ZUBSlluJDTah8tz9R5
   YAW7xrwTl/RpnmJw2KMzYbQzTGwMLtao3EMYEtGA3Aoou3YfuZ3wcKKVg
   W5bZXs8IzSNFJYkZLor0J1eXk9Gc2ahqxDhI0o3c6y9Y2ZcAjD9iB9Vkk
   urAixixnSDV+fxF+bz6fJIrz6VONt2T+Va3BUXk3yLwly/nuKhHbUyiZU
   0LXldFmD+3TuUh+vpxD3UtFQmMigXUwrSuVXieByGTX77LDNEkF8kbIoW
   s3QM6vUosiio2S42z3IskKrcOw3VwbjZtN3mKBrbLi6kiitr8ZjrUMMwj
   w==;
X-CSE-ConnectionGUID: rLysdvI7Q1yN4BVm2nGCvg==
X-CSE-MsgGUID: GW7fuoO6Q6akDsfynJJWtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44961652"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="44961652"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:02:14 -0800
X-CSE-ConnectionGUID: QiGyCoOnR4uN7w9JNdcAZw==
X-CSE-MsgGUID: xlTuy0oxSrOR2II7zYuNOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="116742480"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:02:12 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 09:02:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 09:02:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 09:02:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwPplmECe1iUDcsMG5t3VsiiaZPYWjKZH20gyNIy7lRFMXfBMp/cbjJiYqeEZ21RctAGSJJDBJD2H9tc58m+XugMX512eKd/T1tSUjkuY7kEn3yQdRLNRYPzPdbY1KjGoQi7CggpMt3otZvUjjkgGUMnf2eIoTp6nw0NepciFbHmEJ0TVSZQwGDp86Ypsp8uC33oiOQT56xHCMEH2GtwqETa7S2Jb/y2uuhx5frHRc7/Nf9qMxhjxoYE99zHi3J/GeWjaHu9Qvc3Qg5d0wzpb5QYmQmW0qlHjRlvZ9vwwWd27CELM/HVV+/UY/NA0D8AQwO/qrDtadYXkb8ud6b/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWcH4S+IxKs8lPO8VxhwM8pFg4uIai3p6th9HgUwOgM=;
 b=vqNO29sapmE5Xdg7G4h9MDn7AALBPqXnr/2cp0BZc1RIVepmLl7sHYJyLnAB7aeReMOGLQ+BoEGuZP34gqB9Ig7Xr5BNc2/n8kf7WXfTMIvxApZudMON4pjKGendxgDEGe9WOSCyeJivL+JEzuM/duS/Iq5WwotVQSyUYaD79cAoKC/p6e+Y3CsF3P4ptBZP8GrMAhY0lPLyqdJjrYWdk7fUQOqQFDmr8/M75Lsu/EkrFE55BD5XkD/y0s5CxvCZLoalpxGJf8ZHu+v6hUhmccJxxHNj0V8bRdl7zprMo6iSU7IcOE0ZYvMiyFl0aUpIl+pJPmRoDU7FgqW5D1kRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 17:02:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 17:02:02 +0000
Message-ID: <3fb20135-1b8a-42df-b670-5fbf29acfa85@intel.com>
Date: Mon, 24 Feb 2025 09:01:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 20/23] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
To: <babu.moger@amd.com>, James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<peternewman@google.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<akpm@linux-foundation.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <4a48aabf502897bec1e015305d7b0b826bb20841.1737577229.git.babu.moger@amd.com>
 <b3dc2fc5-4ee6-414d-90bb-97baa0d67dc5@arm.com>
 <7b3d18e3-1f7d-42cd-bc32-fda4a81dfc82@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <7b3d18e3-1f7d-42cd-bc32-fda4a81dfc82@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: e289d22c-c5be-437e-37a1-08dd54f4f59c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3dXdHZoWDY5cE9nVGJIZkxZRjRUZnkrQ3ZFa0ZEUXlNMjZxdHhlczFZLzQ2?=
 =?utf-8?B?dSs0VnI0MWVWYnBKc2EwcU4xVlBKKzR4UlAwMEg2ekl4QVoyeFNQbnF1dVpD?=
 =?utf-8?B?SnNEMWJkNFNwKzNVeVBDZ3Rnb0lhb0Nqa0JQa3kvQ0d4NDY3a3gyUi9yeGRv?=
 =?utf-8?B?MERyczdMei9RQlF3N2tKNXY0YUFXQ0dZeU1tZkpFdGtQYktUdE8xZCtaMWVK?=
 =?utf-8?B?VVF5SlB6T25qMXRTTUNtMjlCZDhSTDhaU3hOQ1VucGpDenA2cGNzTEJ1UDVx?=
 =?utf-8?B?WGVFWUhPNmllaXZleTB3eDJOQWZOeDVvaGt4RjQ5a2YzWFhoZW5vcjdZaFIw?=
 =?utf-8?B?eHJOYjUvY2ZtUkNuOXdiRmxVeWpFQkFEZXNzQjZ4MVl6aSs1b1ZaczYyUURk?=
 =?utf-8?B?R0x4TWk5Ukd0dHhWZGZFSytGdjc2NUowTkVmaEl0ckdzTitYeDFqbzMvaC9j?=
 =?utf-8?B?SnNaQThpU3BsaDh0MXJYbjM5QlFzelczWjFjdzZqbjFjZzZDMzdFd2tWM2RS?=
 =?utf-8?B?VUhyMGMrVldoN1p5dWpvTCtyWnp1TzRqUDgvMUpLOS85dXk3cTVzQnN3THE3?=
 =?utf-8?B?MGtKMTJ3RFBLZXdvaldSRm5OVG9VZzJMR0VGeGZRLytvUmJMMHh4NDVadnNN?=
 =?utf-8?B?TFF4eURVY3hJUWhTeVZiV0taQW5Mc0cwbFBmSFMrOHFsd2FwOXptTnhVbVBi?=
 =?utf-8?B?a0o3TGV0dVd6NkdjS0VqMlJxSDk3RXR3Z2ZPR243azZUeG0zaldDMnAzd1do?=
 =?utf-8?B?QlFHaG1qSHFEbUdHQXRFenNCM3BJVlhFd0xVYSsyaWl6bE1OMDIrTUpqZk1Z?=
 =?utf-8?B?NENaUUh1Vnp0MXZWQzhMcUpVblVNdzBhKzV0d1M0cVJob1pObmtGQ24vTCta?=
 =?utf-8?B?UGxtaytmZFE0S3U5TmpyT2xDZThIK1NQODBRUWx4VVVmYmQ0c1BNZnFPd0RB?=
 =?utf-8?B?aEFsTjVxdmZuMC9DUGgvdC9rT0c0eTF4Tkxvcktobk4vTmtPaUlxTmJqa0dM?=
 =?utf-8?B?QmRsUVRlb2dMM2NQT2Fwc0t2WHo1bldCelJuMHZ1bjcvOVJ5WWxLVlNEdnE5?=
 =?utf-8?B?NnUrU3ZHYTJOei9XdFEvRk5adXplQXVPUXRYcmIxSGM5ejY4S1hqTnV4T0lO?=
 =?utf-8?B?Yy9VbzhLYjlWN09EbWdDVjVuemRZR3JmbVJVdDRmTmRHZmFUTFZ5N1RBZ0JN?=
 =?utf-8?B?SjBhSFZNUkFMYnUwN1p5czhObkZzVlJrdHlZYUp6Tnd1VjdMWUwxcjFkU0h6?=
 =?utf-8?B?dFBaa0pZaGY1bUdZZCtvZEhNWkFMTU5RVWhGT1FMWjlYNVZoNFBpN2hnZ1pT?=
 =?utf-8?B?ZVJZaC9MSzBzekRqRDRRbjZ5V1FpZGM3RDBPWm5ZbDRzR3lTblFUTnVDR1NX?=
 =?utf-8?B?YXFxazdqV2czS0ppQkc3bXlNNG91OGs0aGFLNVIxWlREN21KQ1Z1aTlCaUgx?=
 =?utf-8?B?NGo3bjFmZUNwNlpwSG9IVTltRFI5MWNxWW92RkVuVW5JTy9wek52RXlJVHFY?=
 =?utf-8?B?RElPY3ZSWTNxekVXb1prb1ZLRVNXM3JLU1pDWDhQZHQ4TVl3bDJWeXJ5bUtK?=
 =?utf-8?B?czZRYXE5bEVMd09UQk1PTTE3anVWMzlFS2RrU1pxa1J1NDZlS00rei9iME5w?=
 =?utf-8?B?alI1VW1mcVVUWS9hY0ZjM2RXY1NLZkRKbFFaM2p3THRVMHI5WmUvb3dtaUE1?=
 =?utf-8?B?bjhGNytONUh5bE5YMHJzY08zd1FmWklmZ0toUFJqVVc3aU1hVURVZVhaVjVC?=
 =?utf-8?B?eXhwVllnRTg2RDJwc2laS1BlWG9FMjVpZDB5Rk5PZk5wUk54THQ3clUrdXBv?=
 =?utf-8?B?Y2tzL3Npc05hbVFMWldzNytWQ2hzSnpOK0lTNVdWM253cTM2SzBzSWNzSkRM?=
 =?utf-8?Q?tljSkwTHTEAVY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1RhRmtKT0M4c0lITEJyNWRZT1dnc29IMWd2S3RXZWJ0SE1ISHl0RG83Zkhw?=
 =?utf-8?B?cUE5VUtHQ3pNN3V4eEd0SXJVUXlxYU0zOGVpcnFUcWEwVWtzRnAvd0ZJOTBO?=
 =?utf-8?B?QWpETnNSSWpzeWQ0VVZRaERFUmJtRjZzbk8wU2JNOUZyZEcxU2dpcGVpWEdp?=
 =?utf-8?B?QmtaRVhIL2c3blRYWEZSTCtlUkNJNjFrb1pNRmxKL1hQTXhUQ0lINUViNmh1?=
 =?utf-8?B?L05ES0pwbUg1cTNITHpNdkN2M0l5a2l3U24rMnhkODEzTm5wbGt4WnNJYU1m?=
 =?utf-8?B?UUtSWWJjMUY5bWwrT25wOHZWcXFBMHRVUTNtNGxOeGc4UDUwQllPOGozekI1?=
 =?utf-8?B?QkxWajg0cmFJd0QvOWhMRmNqaERNQjAvVSs1L3pNWVdRMDg5bHpRSHFsS3Ru?=
 =?utf-8?B?Sm9qSGtpVE9oWS9SUXZrZnlRcXMxOXJIb2gyNkN4cHVMK3lQKzljT0R4S2dO?=
 =?utf-8?B?TEtCajJDQjlBUGxBa2U5RnBQNVI5SW5FcmZGRkpzZVRVRG81WW0vM1I5VGFs?=
 =?utf-8?B?NmpOcmhCc3Y4SVJ0eTRBTmUvQkhuekk1MHV5TjFqVExBamE3bWxqVHZqcE93?=
 =?utf-8?B?RDllcWMzQVkxWWRFMVN3SGxiUGtGVTY0RjhTTXdqV3Jtdk05cm5hSXlSRkRn?=
 =?utf-8?B?Rk9WWGNDd0lEZFZFdW9rVnRNU3JLTGlua3BlYkNNNG5RbHkxVjhJZnpyMUZH?=
 =?utf-8?B?UFV4S2RuUVJ1MGtzSkVEd1U2Y2NwK1MzTTdqL3NTZkFFZkJWMUI3Q1BGQVIr?=
 =?utf-8?B?OFh0a0lsTWZzUngzOHMwVlBtR0h3YWdXakhOaWRURTlIejV6cUtUYkNsekZN?=
 =?utf-8?B?Yk9LVEQ2V0JmVXVpNEJHdHlCcVFwQlNEK2JiaElGd1h2YVZUOG1PQkJlcGV4?=
 =?utf-8?B?TmtwNU5SZmM4bmNwTTdyeXFyaHFYeTFoOGVRaFh1VThlRUZpaEx0c0FCdU96?=
 =?utf-8?B?cnZVZU54U3lOcXJMUWk0R1NyVkwrclM0OVZZdnVGRmNtK3NIUnpveEhSRjhx?=
 =?utf-8?B?TEo4WUIwRkhMMC8xR3J2c0V1SlJHeW5LRlgxa3RHc3d1dWt4ZmlQR04wbXk2?=
 =?utf-8?B?SXJQVU5ETDRrK0s1Um5tS0hWemdmOFg1Y2RsSzE5NExCbzBrUDloV2I0ejZ3?=
 =?utf-8?B?T3F3T1hwWHExcXN0VW54N0Rrem13NnhELzZRcmI2cEthQjRaT21SR2U0emJI?=
 =?utf-8?B?eHN4eHpBbXRPTGtDdEJKaWVldkpLMkZUbEhWODIwVlczS1ZlT05JcDJlazlm?=
 =?utf-8?B?M0RDL0JpSzlZb2VQajBrK0tTNXc3ZnNBd1NqOEdUMGU3MjEvUWs1STcwTFBk?=
 =?utf-8?B?L0kyV0F2ZjRLT2dDdzlQc2NtQ1NWdmVwcnAyRzNaVDdMV2pmQUlsTEZWaEV3?=
 =?utf-8?B?Z21TR1BJMFZlNGoyRHNlL2FEZXVpaDF1K0pNWUZQeWdzbTVrVTY4U2o4WC95?=
 =?utf-8?B?czNsRytsejZEM1lPMWVJRlJsN3E5OFhqQ052U2srRDdDalFkRWxCV1EweWFz?=
 =?utf-8?B?NUpNek5KWFlWM3pvRVdXQm5XT0pmRDBKejFsYTR4ZWV0QTB6b3hkOWowQzc1?=
 =?utf-8?B?TFVyVDI1V3h6NEljVmFyeUtCR1JwYisyZGJFRDRKeU15UFpPcTE4NDgzZEpo?=
 =?utf-8?B?WE9OUFlyZ252Vk5Eb2NTMGxCS2JydElvNzJ6ekJlcU9Ha1lwMTQ0SGtTdHky?=
 =?utf-8?B?UWdQbHdKNHJvcVg4NVZVYktjT01FOEtYTDZDdmd6NSsyWHVWMkM5cytnbWlv?=
 =?utf-8?B?K0N3TDdjcXJYYURidFJua2QxbzVPZzhtYlNJQUZLbnJBR2NvNDFJK2dmZTRD?=
 =?utf-8?B?RFl6Tkk2OGh0RDREMUxvVE4zOXlxd21sY3lXdkJUcUlYT01GN3htTWVqSHBm?=
 =?utf-8?B?UFZmOHRnZFJaaE13NTFnVVAyV0FLdjZsVkZIUktjeXg3ZVhNdGdwUi9rQW4w?=
 =?utf-8?B?V1FtTTBPOUpMcXo4b0FOVEpJZnVON2VQVlF6UjNXQ0h5Q3ZKV3VzMkNBZTdS?=
 =?utf-8?B?UHNaS1l3WWFBVk4wczQ4SGxvM0JJamJGTmpRT1hSZDZuS2ZEUzk2ZVkzbWV3?=
 =?utf-8?B?aksxc1NndmVSOWpkRG1QSjFXTHkrczFIa3B4V29lNklwNGt5OGxSYmdvZkZa?=
 =?utf-8?B?M1FTWUM2anJUa1NrcUZtQ1RCMitvNjUyMkdhaVpsZU5JN1ZRZENGNGRzWTFP?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e289d22c-c5be-437e-37a1-08dd54f4f59c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 17:02:02.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr9zxaeo4RR3W5yFGeGPluJCxqnFJ7xnDD9fJefnH6Q6kM0Q0YxO+eFi20lIW6utrkzoPvgTN3LcZnKaQq4YXbTdeXHrVk7RLt0vuBE4o80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-OriginatorOrg: intel.com

Hi James and Babu,

On 2/24/25 7:49 AM, Moger, Babu wrote:
> Hi James,
> 
> On 2/21/25 12:06, James Morse wrote:
>> Hi Babu,
>>
>> On 22/01/2025 20:20, Babu Moger wrote:

>> This sequence has me confused:
>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 3d748fdbcb5f..a9a5dc626a1e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -1233,6 +1233,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>>  			r->mon.mbm_cntr_assignable = true;
>>>  			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>>>  			r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
>>
>>> +			hw_res->mbm_cntr_assign_enabled = true;
>>
>> Here the arch code sets ABMC to be enabled by default at boot.
>>
>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 6922173c4f8f..515969c5f64f 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -4302,9 +4302,13 @@ int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain *d)
>>>  
>>>  void resctrl_online_cpu(unsigned int cpu)
>>>  {
>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>>  	mutex_lock(&rdtgroup_mutex);
>>>  	/* The CPU is set in default rdtgroup after online. */
>>>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
>>> +	if (r->mon_capable && r->mon.mbm_cntr_assignable)
>>> +		resctrl_arch_mbm_cntr_assign_set_one(r);
>>>  	mutex_unlock(&rdtgroup_mutex);
>>>  }
>>
>> But here, resctrl has to call back to the arch code to make sure the hardware is in the
>> same state as hw_res->mbm_cntr_assign_enabled.

Another scenario needing to be supported by this flow is when CPUs come online later ...
after resctrl is mounted and potentially after the user modified the assignable counter
mode.

>>
>> Could this be done in resctrl_arch_online_cpu() instead? That way resctrl doesn't get CPUs
>> in an inconsistent state that it has to fix up...

Could you please elaborate the inconsistent state that would need to be fixed up?

>>
> 
> Sure. Here is the diff.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 22399f19810f..f48b298413bc 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -771,6 +771,12 @@ static int resctrl_arch_online_cpu(unsigned int cpu)
>                 domain_add_cpu(cpu, r);
>         mutex_unlock(&domain_list_lock);
> 
> +       r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +       mutex_lock(&rdtgroup_mutex);
> +       if (r->mon_capable && r->mon.mbm_cntr_assignable)
> +               resctrl_arch_mbm_cntr_assign_set_one(r);
> +       mutex_unlock(&rdtgroup_mutex);
> +
>         clear_closid_rmid(cpu);
>         resctrl_online_cpu(cpu);

This would require every architecture to duplicate the above, no?

Also, please note there is more appropriate domain_add_cpu_mon().

Reinette


