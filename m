Return-Path: <linux-kernel+bounces-523016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E0A3D0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F36D1891C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974131E0E15;
	Thu, 20 Feb 2025 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtDUxSuj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A381E2858
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030335; cv=fail; b=D0hcDgzWJlSg/S7qlPiULVom1+eaYyAJZHqFy4wmgIXcz6r6WGa/H9u3xgUHLWUia89Z5eNdMMjwhf1X7fv5y/mp9vSy0cTAgwJCLCL/2wzUraqM3B/RhyQoNZLKYElGfEoBZPCvImc/5+iwgLopI3E+oSpr5CDGnEFfBNDrQhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030335; c=relaxed/simple;
	bh=tfFAbOZBr4t4v0S41FqUvWORh4Qd9Swi3+PMeT8JMQY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7RIoRXmGDQ3JgB/HoXIagfpx6Yhw17S6Z5tvCFD8Rc0MgykqJMw2Jh5AMH0mwQtj7wSDqsoRU5hDq7yix3qnqozSda0mPU+dmOCQYGO4p1/F8wKRCS9lseZ5JKnSC8MxyG7gukT+wKjlgMdJZ1ZtUkWnLMsSVe0SRn0ci3nY68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtDUxSuj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740030334; x=1771566334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tfFAbOZBr4t4v0S41FqUvWORh4Qd9Swi3+PMeT8JMQY=;
  b=WtDUxSujUrizXgpIlxufsMb+TSXnWBybYtJKASrbayJRFlrJxvYzxrgy
   l5trfzZKCj+92A0tK9DL7ajDJhv2om6X7naTaMmXbZlWvnlFxZWDoG0jy
   xBwOhHfJy2OmrjKK8JvYbb+qFIoeA3tP/AoHwvR4fXBk93qlF1KvwBwCo
   wsnXA3mDA97+z5O+VGLr/HwEML7TPu+fAfVX8U4qKN14Ni4n/gEBXEQ1S
   z9NrLmnhkR/9MWGS7AR1dmiW63YHk6E+1hSIJfoG+uf6HS2MzD83LHod+
   SBrehgK4IcAS5zDECflUSPtWQQM/ZaM2MhYrGZgtT8bdwxMn5BHDm8fpI
   Q==;
X-CSE-ConnectionGUID: IrdtUWFTRVWuZmvBunS8hw==
X-CSE-MsgGUID: aqqtR4Y3TPay5CmXUwEMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66152075"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="66152075"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:45:33 -0800
X-CSE-ConnectionGUID: nj4YU1gfS7GV9Nd9JD8xGw==
X-CSE-MsgGUID: pQ+b0/z/QOedos9MvDszVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120164533"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 21:45:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 21:45:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 21:45:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 21:45:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNRtjhGMFmSV56zjXwqynvBRytoXhwhJb6VlJL0i8w9Z/2NUyPCP1PI9DuV+27CGDOcOxEukFPnOL0iaPBCwDP/heH2uA5FGXCqf2bCWupFUFqKybYV8yCe/VJ7vdY26XI8c0N6SDaWYrN3TGwDzyDjGSDqbn8BUxbyzdmnU5wV+i+g3B9X2FA5N6gT00RGx1gyS7FRn7/mmZJRiro+NsVoa3NIog4pEQ3rxIoxybSeumG9uhqT011NqO0b/pJcijxF53VG+4LSGK/LS5VMiaz7Z9tQdrkna7ycakdeVktdcsfXnyq8zxvGScDe5zGPimh2b7aQJr+4C/hX4C7C0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N948EsrkWbawOeaDCqtzjvuP96kmp9iKscnylqLshrw=;
 b=Afp4XVgZY3iJRePTrDokXd5M7NJ4PkRSevoKDqhIsoy43+ve4oGWcMTbo+FXQ7evQJ6t/J7N3VZPAWN/dFYV3iDwATk8zTN164RpdjhMkD0lgFOl/q3ffVj9VriSHdGpWC1Cc9optcb4/KcXQT/riwD7HZETAvXtCzwhFFD6LkhXFynMr20I2nDeyLUXzP0/f3riDkOahzvPlmCsXfCrk5e4J0K3357f0Rdqrefivt8oWu7Q+MNmCTl23bqqo5PH52nx1gVY0XMFj763AvZw+Ga6uPPYjuJuroZABAiVPTE9DBVfbQULHyVk3i5jFOhdsEmU05E8uNTUUF+QWX03tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8199.namprd11.prod.outlook.com (2603:10b6:208:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 05:45:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 05:45:15 +0000
Message-ID: <c481185c-9fbf-4c85-b1e2-ff95fc4cc18c@intel.com>
Date: Wed, 19 Feb 2025 21:45:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 39/42] x86/resctrl: Split trace.h
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-40-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-40-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:303:83::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe571c2-f14b-48b8-c99d-08dd5171bfe0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUFBcHorWEdheEhybnNxaVFSM3FMSks2U082NUtvSUpzTWdpdU5ITW81OWJC?=
 =?utf-8?B?U2diaGFhd0xVS0NtTFNPM3Q0Y1kxcENyRTZTWmdPRWhPUmF1SFRZeWZRazNX?=
 =?utf-8?B?VzR4Tk92V1BVY204UHdJdWUxdnpUODYxM29OdHVBamNGeXVvZUNpbFpEemxv?=
 =?utf-8?B?YjMrRmRObHZKTlpieVBnTzJ3Ym9KYUpnMWRiOXZRYm9LK3ZEditDVE95OWJX?=
 =?utf-8?B?ZzhaeTJOZ1c2TWJFbzl6UDhvVDZrdGZ3em5JYm11QldERUFUaG5hWHpXNVlV?=
 =?utf-8?B?Q2J2WUJSdWRnOWZXWmpRSmdLQjJnT2FoeHRKb2xKOEg5V2dIM1EzMm50MGNl?=
 =?utf-8?B?UFBTUENJeFp2ejd0bXpabFd1MEx3ZFVYa3JieHAycW45MFpkdHI1ajBwZHNJ?=
 =?utf-8?B?R1JIbVE1V0gzdEtGOFgrZFNLaldXa2lRcmN2TVJ0ZFIxcmFoOFBPaCtuSXB4?=
 =?utf-8?B?eHRVamhhSXlXL0hpTUEzaEZOUEo4MzJsMkhMMnBuZWxhN0FjRGJnakRFSzky?=
 =?utf-8?B?SnZrMVRDRzh0UVhwaWFsK3E0QmIvYkk3WWpaQjhzUTF5UmRPZm1BK3duSlJF?=
 =?utf-8?B?bG9sRkl3cDRXMFFOU0JlRi8wY0dQbm16eSsrQ0R1ZmxiMEIxOXVSQ05JVDJw?=
 =?utf-8?B?RnRsdm9QSVp3SUJNVkN2c0pUZG5neDU0MUM5YTVYNjlLa3lEbEE3R2pRSUF6?=
 =?utf-8?B?STdHWjBWZFc4Q3llVVlKSlYzVGM3R3BoWW1NbUFqdUE4T1RKYkswVTFKTldp?=
 =?utf-8?B?YlJlUzBnR0liZGxDdG9jOFZaUHJWZTNnZ2NYenZKZmhLNk9VSytKMkpRbHhT?=
 =?utf-8?B?aU5NWEh4NXFrOHovSXFqMjduZGhEc3MyL3YrS1JsOTNmd0F3TXBXV2NXVVNz?=
 =?utf-8?B?RG0walFKbHFPcmVybWdxYVdQeVJ2MnNGVzl5c0M5Vy80b2pHNnlNa2xOVW8z?=
 =?utf-8?B?WkF6TDR2ZXNqQkUyQlBmR1NLTHlDTmg5cmxNbTh3Njl4YWJNdS84RVVRVjNM?=
 =?utf-8?B?ck1uanA5c051UmdNQi94bzRncmEzN3A3T0w5L3VJSWVNcnNObUUvMlJsSlpa?=
 =?utf-8?B?VndCYWlJdHIxakZFaDVDUzc4WUp0elVhWW10OTlUSkQzYXhWNDkwNHp5VDNS?=
 =?utf-8?B?ZEMrUENDY2c5ZmU4UElTVnlNRUJiSk5Vb1FnMUhCYTlaM1NhaVZ4a0hiSnJY?=
 =?utf-8?B?VC9rYXh1NlhucXNaK3VLd1VXMnl1Z2pNVlB0Zy9DbTl5aE5vcTNnRzI1dytL?=
 =?utf-8?B?QlI3Ky95L0p3Q2NUYzkvZlNNaDBWWmt3YVg2am5vN0xIdVU5N1lscHJ6cjlB?=
 =?utf-8?B?ZGVzdzdzOWZXQUlEOGZMdTBQTUVsbEJzT1BxNS9qVG5TZmtLei90MEFFZWJv?=
 =?utf-8?B?UGg2UFhidi8vZ280TThaR1BUT3Fha3RSaTVuU3ZZcmYvd3VrcFltME1YdDhR?=
 =?utf-8?B?V1ltZEJpWnhpdmhIY3NzQUZkaGVERzhCSThkTUxTeTFMMkxSRlhZZzNPN0tZ?=
 =?utf-8?B?QlpmZGExWUtGQ1I2VTZBbGxGWmx6Z2trSk12KzkxbjhIWFEzMEhiM0hudURT?=
 =?utf-8?B?MmVpNzZYcUZuaWd2REFkRHozeDFZM2JhWEdBbllJanBMdHlVbTFRclRadERn?=
 =?utf-8?B?Zk1zNjlldEp2MnVHd0p0bDdaRUFpUGZQa1R6c0x1ZVJsaDJTemdjdzRud0t5?=
 =?utf-8?B?M3pYUW14N1lBSnlEN0IvOC9salBvT2graG94Qmx3ZklrTkpDTWZxVG5IVmRW?=
 =?utf-8?B?SFAvZVpTSnhDbytVOGlSV2FBdzdLVXo5VWdLb3VHdURheFJWaHJjUTY1Tm1p?=
 =?utf-8?B?amp3cVMrdVJxODVVRnhiUW1mK1Ztc0NnRUZBMUVadlpqMWN2Y3hZNldIaUgz?=
 =?utf-8?Q?0nsAdtz4duzq7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1pzakVSUm5IazFqZWQrNFN1Yi9EMFNtRnJ5MC9IbEw2ZWhvNUpnTjkzd1I1?=
 =?utf-8?B?cC81ekhCOUcvd2RkaUNGMms2bjJzRnRZaEV0UGJYTzZrazlzbjJKT0krVm0x?=
 =?utf-8?B?dWJjemNYcWpqV0tyRjlYWXMxSFJ4TXAxS1E0b3hsWVQyZkVRZHErdnBiZGJ6?=
 =?utf-8?B?TWpRN3RKVmNSbTdHMjBwN244MWFNN054SkZIeXdva1RrV1l1YzJQYTZMRE9p?=
 =?utf-8?B?RTF1bkt6VGJoZDVzL0ltdHl4MEVnSFJBRXhYWkhQOWxpRTJvbkFPaVVSaDBS?=
 =?utf-8?B?aFVXcVVUOWtFN0NGWUsvU0d3Q0VvV1NjSWxmTzZjRWdLYXZrUFREOVhnVy9P?=
 =?utf-8?B?bnp4MG9SM05LYTVoWjY4Y2dTQU9MNnp4dUdiQ0ZoZXRneUh2TUo3eUM0TkFM?=
 =?utf-8?B?YlRpTWlyRnhObFY4ckJGWWhBdkthQWtENU40UE1LNU4xN2JrOGVtbXdENkR2?=
 =?utf-8?B?dGpaSEhBakpaWm1vRWRpOUF2ZHA4ODBLR0IzZGlpVUhkZlY4dG03clZ6RWdE?=
 =?utf-8?B?dk0rMEpuVldVUGJ6OW1xbkJUY3dXM3Q5Uks3WGF5dURlRnZlbWMzMm5TU1cx?=
 =?utf-8?B?L1NybmtmQWlYa0h1OFZFWC9RN1pBd1IzTFo1VE9WNVNGWG1Dczdmc0oxdTVl?=
 =?utf-8?B?Vi9BNUExZDJtTlRLbWx6a1o3VGkwUFlVU01ralZIWWZzS2NUWGoxdjE4OU4v?=
 =?utf-8?B?ZUVrVktuT0JXU2FsVzk0WHFBVXZBKzZ0RExiL0NqVlQydU1tRndDaC9Xc2Nj?=
 =?utf-8?B?a1VHeFMwUXVzbkhhZlVmZXgvTjJiMUxXMGNYZXRzcEowNnJ0b29IU2NDRkNZ?=
 =?utf-8?B?NFlQbmdSaGp3enQ4QXU5SDdXdlp0MzlmZXFJNHQyMlFIOEloMGhhdldMZnI4?=
 =?utf-8?B?b2tabVRNbkdCdFpmMFY1Nlhoc0RVcXRiV21uY1IycElLN0VUSXhKYmt2dzlH?=
 =?utf-8?B?MENYY2F4OW1DSEtTdWpjMThBcjlaUWtEZUNscjR3RFNUeVd1S040aDJvZXpz?=
 =?utf-8?B?QzNpQjVjZTU4aGZWTEJYV01STk1qS1ROMlVnZUZNcnlVb2gvYmx4dnE2N0pI?=
 =?utf-8?B?RXQvV0gydEhiVmV5aWlQRGV3SVRaenU3MkczbGFmL0xRVU1YdGc3Qndpc1p2?=
 =?utf-8?B?cnh6SHh6dTdwTGo1Wnl6aDFEMTBidEtpSHB5MEhjbGVCQkE3Zmk5ZVYvOE0w?=
 =?utf-8?B?dXRyWjZ1VEExWTczSW02Mm8va2srRnc3UzhWME9oNGczUTFQK3ByQXhmUUtM?=
 =?utf-8?B?MVNtN2hCU3g3TDFveEpibHBxaFF3aWFMODhMMVRXN3pHbWhxYitwVXora0Uw?=
 =?utf-8?B?NWJWZEVUcGtCREJFM3lxM2VrTlpKV1pKSzZxZ2l1b1pnWTBvMmJ2aEtRWlEr?=
 =?utf-8?B?TUVLZjFxbTFZK0NzTXhSSlNjV0tmb3J2UnBrWjJPRkw2bG1TU0crQXAxbTBs?=
 =?utf-8?B?cHZ6bmdoSEk0MC91bEdGclNxbFM0anNHS3dzZ1VEVU52UWhCcDdLVmpMQitC?=
 =?utf-8?B?M0FhYUpGVnlkcm5OU2ZOdzUyK2RCZWJFZHFFL3FQUUlLU0VOZW9YbGNLZXk2?=
 =?utf-8?B?dFZaalBDWWFwOXViYkd0NVczTUZlVjdnejRzdCtWTGNmTkV0bm0vL2JPOVBK?=
 =?utf-8?B?STNKc01udzh2Q2F5QTFWdGlKNW9sUDVldU04eHdtTnZLTm12YWlOZCtZbitL?=
 =?utf-8?B?UDZ6eENqTFJqTnpFempUYzQ5STlOWWp4bDc0N00xdHJjVzhSSFN3d1pKZytp?=
 =?utf-8?B?WXd2VGxsSWY4VXV5UzJRdUxMVUd6NHVMM1RzQ3NJSHlnL21IY3A1NmVvM1pj?=
 =?utf-8?B?VGZBajZVSnVjWXNlV0RUTGhjS3ljREhjZmhMc21tRFpiRVg2MUxrZjFlVHN6?=
 =?utf-8?B?eFUxTGNHbDhTd1JvRmI2UlFqTEdWeUZ3TmF3OTd6SWoyYnNLKzByT1A0Zm9N?=
 =?utf-8?B?OTBIbFJxQW45YkUyT1QwT1paalBlcXAwd09YRGhnbU9lbkU5NUNtb3BlN003?=
 =?utf-8?B?bXd0MEtEaWNNblo1RVFmNDhCeWI4bTAzWW1QR2h2b1hGcnNJb2IzWTdGTlZm?=
 =?utf-8?B?cmNDeGczV29jejZaQUx2N240QTdJMWhKc2xPbnl1bjhQTEIzNFlGMkV3aC9C?=
 =?utf-8?B?R1hKS0VDdyt3MmE2Wk1qdklBMzRWOE45TGw3UEphUExTMnZHM1F3QXl0TEd3?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe571c2-f14b-48b8-c99d-08dd5171bfe0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:45:15.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTEzvMqjlb2uWzDJ71vDhlXGd/qqUcZi9TJgAF/gH2oxWN9MIQQ2py0qjeVX88q2jTc7GT2eaBeGaZwh3Dh8/l/6NHijNBUd+Icp1hN+ELI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8199
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> trace.h contains all the tracepoints. After the move to /fs/resctrl, some
> of these will be left behind. All the pseudo_lock tracepoints remain part
> of the architecture. The lone tracepoint in monitor.c moves to /fs/resctrl.
> 
> Split trace.h so that each C file includes a different trace header file.
> This means the trace header files are not modified when they are moved.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

I did not investigate if this originates here or after the code move but
when compiling the series (after running the file move script) with W=1
I see the following:

In file included from /home/reinette/dev/linux/include/trace/trace_events.h:27, 
                 from /home/reinette/dev/linux/include/trace/define_trace.h:113,
                 from /home/reinette/dev/linux/arch/x86/kernel/cpu/resctrl/monitor_trace.h:17,
                 from /home/reinette/dev/linux/arch/x86/kernel/cpu/resctrl/monitor.c:32:
/home/reinette/dev/linux/include/trace/stages/init.h:2:23: warning: ‘str__resctrl__trace_system_name’ defined but not used [-Wunused-const-variable=]
    2 | #define __app__(x, y) str__##x##y                                       
      |                       ^~~~~                                             
/home/reinette/dev/linux/include/trace/stages/init.h:3:21: note: in expansion of macro ‘__app__’
    3 | #define __app(x, y) __app__(x, y)                                       
      |                     ^~~~~~~                                             
/home/reinette/dev/linux/include/trace/stages/init.h:5:29: note: in expansion of macro ‘__app’
    5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name) 
      |                             ^~~~~                                       
/home/reinette/dev/linux/include/trace/stages/init.h:8:27: note: in expansion of macro ‘TRACE_SYSTEM_STRING’
    8 |         static const char TRACE_SYSTEM_STRING[] =       \               
      |                           ^~~~~~~~~~~~~~~~~~~                           
/home/reinette/dev/linux/include/trace/stages/init.h:11:1: note: in expansion of macro ‘TRACE_MAKE_SYSTEM_STR’
   11 | TRACE_MAKE_SYSTEM_STR();                                                
      | ^~~~~~~~~~~~~~~~~~~~~                                                   
[SNIP]                                                                          
In file included from /home/reinette/dev/linux/include/trace/trace_events.h:27, 
                 from /home/reinette/dev/linux/include/trace/define_trace.h:113,
                 from /home/reinette/dev/linux/fs/resctrl/pseudo_lock_trace.h:17,
                 from /home/reinette/dev/linux/fs/resctrl/pseudo_lock.c:34:     
/home/reinette/dev/linux/include/trace/stages/init.h:2:23: warning: ‘str__resctrl__trace_system_name’ defined but not used [-Wunused-const-variable=]
    2 | #define __app__(x, y) str__##x##y                                       
      |                       ^~~~~                                             
/home/reinette/dev/linux/include/trace/stages/init.h:3:21: note: in expansion of macro ‘__app__’
    3 | #define __app(x, y) __app__(x, y)                                       
      |                     ^~~~~~~                                             
/home/reinette/dev/linux/include/trace/stages/init.h:5:29: note: in expansion of macro ‘__app’
    5 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name) 
      |                             ^~~~~                                       
/home/reinette/dev/linux/include/trace/stages/init.h:8:27: note: in expansion of macro ‘TRACE_SYSTEM_STRING’
    8 |         static const char TRACE_SYSTEM_STRING[] =       \               
      |                           ^~~~~~~~~~~~~~~~~~~                           
/home/reinette/dev/linux/include/trace/stages/init.h:11:1: note: in expansion of macro ‘TRACE_MAKE_SYSTEM_STR’
   11 | TRACE_MAKE_SYSTEM_STR();                                                
      | ^~~~~~~~~~~~~~~~~~~~~                                                   
                                                                                
[SNIP]                                                                          

Reinette


