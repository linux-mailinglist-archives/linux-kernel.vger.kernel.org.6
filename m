Return-Path: <linux-kernel+bounces-550457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C83A55FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8081895C39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710813D503;
	Fri,  7 Mar 2025 05:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUxVjUOW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B68635D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741324010; cv=fail; b=Bbk4ci8abepByZXkrlQN6jx9rL74iMg4dP+1aLcPeS/56prcsLnUG5wSS5YifFa28Uck/HNNeQz3uWuP9KYOqQXgjofGp3kT5QaeZEjeZis4RJgi/LETG/LTyxXCXBq1teh0JE9X/cGyeqkH0i1d/GDDvHfWWXMq8qBSxFlAtDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741324010; c=relaxed/simple;
	bh=uHfkNMlHQL8s40hfGZ/Uph0z+IrHJiNZlch0f+rySOo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DZnfB99xsMG8pFjmJhnkyXXf/GpOVNcMiQ1+symKk8LH0gbjM/Uj5VRrsZh8s2JTqQsigNx3ZStPLH8CrKw4SDJErRJex3fnwjZ0U3DFZWGvM2qhDV6IvOQJJ+PlczfjGVohg9ojeRTAu7vHvU9BML/fkhC9YAyvxRH6gspsLAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUxVjUOW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741324008; x=1772860008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uHfkNMlHQL8s40hfGZ/Uph0z+IrHJiNZlch0f+rySOo=;
  b=kUxVjUOWH4xfTLD1wJmyhYR/aueul1WQWSN6YAaCbTbj54r+e0/uaXJZ
   WmQQ9H0DeDcIj7BCrEZOWCjJtzWYGQp9btFjsXnwcepPb0nSiNGUwjtZm
   +z0R7segCT8kdg9jMpIZ6seprSVFlUxUwcEr4y4SroDGTicEC8OI0eCQU
   ojshPvE4Zjth5cKnwgGs2WCzWQ2v6o/6Mp8+Kmv3XUlnBQXopuZWloJC/
   JQCKyewfHQczeslhxF5czKfxwBYaskGkUzTbhvXL6P+W4fTRtn9JxqUQK
   fmiKuUTrLRen430WrvUBuZxmK4YS9oWH50WW1SIzMbMQOX7RJNBH5ckpG
   Q==;
X-CSE-ConnectionGUID: tXGZ73aoQwWLqD3bgrepRw==
X-CSE-MsgGUID: xcj+M9i1Qlm9J4qlZU6H9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45170792"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="45170792"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:06:47 -0800
X-CSE-ConnectionGUID: X0GeeQKnSAOQg0smVpvwBA==
X-CSE-MsgGUID: 4SvTpC5pS2uxwJilOm7W6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124430380"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:06:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 21:06:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 21:06:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 21:06:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmsB+D8u84fvLjD4IMK03KuIqb/Z+KHo3ej9vao9uUBe+Gmz0eQD3UoOkRe0HVgJLhceYMyu25DuJC2HKLI7UYdAKG++VlR0F0C0xiogbW8nnHFAwOc/OyTBDNndpWdRRt/LTDj/RF2Gg67l0of6h90sMUC0G9/6/DXKr5gflQYZxYq408rnPSslTov/GivWA0HDAc2eoWJtPP5KUFyK2i4dKUHUoPFuuV1sN0O2IkEDfOcj7J/1KwB6u1He1aOS2EKO5gJjWzx+ByOrvd/g2frODIueAERC5xTiFIjKbEuDvJ+A6S5hP3M6Ko2pNm0WRMsFoSWBnrWoEGYnq9ZYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2NYDTx3CxnwQ5e607Jito7iXSyaf4A+z0lCQFUPoBg=;
 b=VG+6G+sk+vatb/1JLT6kq7jK3CX05UFSdXe2hQa22CqT4ZRXurA8ryD4K3f3ifvrxYdi1oz3uG/RC1t7yZ9mcKX+5XMcxcjoVPnv3vco0qwnCBaUPIWH8nQB3mqULpiW1SPhy4+JTH376O0z9nqlA/0thLuvnvmqHxP6WrI/Gto7F1KbwAMJpLwBl7+soIvqBkgW1XuBzY9mnP1nOgAYT0XyPVflF1ndR2qARS+1IdvVmFH3knTLFLzwIX4zJz5BWHHdGa6ZYaspstJLytU32RM08XF6pzLq6F6D55zxdwuqa8aRXHx0R/PoOxKrhFXtiEcMzYianb95hdZidu63ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 05:06:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 05:06:29 +0000
Message-ID: <8b197a3b-2074-4b88-a712-2834ca466e1c@intel.com>
Date: Thu, 6 Mar 2025 21:06:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 43/49] x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in
 rdt_init_fs_context()
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-44-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-44-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:302:1::43) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b6d7aa-c27c-4301-3ad6-08dd5d35d1ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkN2QnB5aTc0MW5FSnRBdEk3TnBLOGMzOFhQZHVMSUgwVEFrVGxpamx3dEZJ?=
 =?utf-8?B?YnQvT1RmZk5OUEZvcmRhSGtZNWZycktuMkNHOENKYmM2b25FaUFRc1JHNTU3?=
 =?utf-8?B?ZTI3a1pHREFaMWgzajc5aVlScnJKWEk3MUlMREc0MStaejBZQmxuSzZCdS91?=
 =?utf-8?B?QStkNTFMWFY1T3FEL2s0M3grU3gweWw5eTF5M2pCc3hLVkZUM2p5ZzhtUTRz?=
 =?utf-8?B?YXNZeDVOWTBiSXF0eDkyK0pGQWpaUFlkenAyVm9hSEFJMzhaUU9xaDJjM1NT?=
 =?utf-8?B?SGVoYVZDRjNyaGh3TEkxV3VGKzlKT3JPTGo4U2Vwakh3eG5UTFQxQzQ2ZTVs?=
 =?utf-8?B?YVJ5M0dlaUJLakNDbm1hYmR1VlFKRlMvem5IaHpaU2VkZmtQcmZxb2kya3ZU?=
 =?utf-8?B?bU1palh2RUlhbTEvbjJKaHdPK0tFUGE1Y2tXVVVybjUzd0MxN1BYMnJHTUhw?=
 =?utf-8?B?TldNbDJhalc1RGswOFR2K25sZlF4eDdjcUNtWVozOFhTNnoxQmgrSHFQU0pJ?=
 =?utf-8?B?cWtESGxSZHpUSzI1QVhKRFBhR015ajFSRzdIY0NEdTJiUlFoVVh6Rk80dm00?=
 =?utf-8?B?VUR1SXZQTzBnTDNYdDNmQjlFYVBpZ0lVZkpyYkNmeVVwYVhmV0NKbkEwbjI4?=
 =?utf-8?B?TVdDM3JscWFObE9VVnBvQ243aVp6akttS3R3cEliS0MzVzFHeXlYVmpUeDVH?=
 =?utf-8?B?Ukx1K0pQRkFTdmpmSHJtZmlPYlJldTVJVkhnN3ZSOXJNaWNtVzZZNHhoZG8r?=
 =?utf-8?B?VHQ0NDFsYXNLK0ViYkNnYUgrUjJ0NlBtU20xTk03WC9lVE9DUWYvdEN6ZGNC?=
 =?utf-8?B?N1VrRUQreTMzOEthdC94Z0V0TWJBaUFLdzdWS3RVUnNhS2IwQzYxK2k0SitD?=
 =?utf-8?B?WUpQUXI3UEM0RTlnZ21uUXBkTTdTTHdXS1Ixd0Uzck5UbStqNnZtcUFkc3lt?=
 =?utf-8?B?YmZzVkIyemZuZWhNNGt1bTh6dldvS3JCZmJXeGNScWpIUFlzRmpJWU1SSDI3?=
 =?utf-8?B?T2l6Y3FPcCtyc0RFd096U0lXRXdUUHVpVkdQamw5eUora1BndGpMWThnQnd6?=
 =?utf-8?B?cW5oVGh0b2VFNkp0WlNvK0JYNi9KWDFUSkV1THBnRFBUYWkrNElJNG9CT2hR?=
 =?utf-8?B?VkR0aWJWNmdheGxSUWQ0akJwNVFSTm9PSUdCUFdXclZLay9VZUhtUkt4N0Ux?=
 =?utf-8?B?Yi8rbGxOelN4SE12Z3UxRXJrSFluMEVIMHNTcUNjK09HOGg5SVVZam1TZVE3?=
 =?utf-8?B?MFhGQU9PUzZhN2ltaUdBcFg5TUloUXFsRkZUT2FqWmljcU9BY042Z1d1VVJu?=
 =?utf-8?B?UnY5dEFmcmVWYU5BUHlxWnFCRjZLNnYwVVJWdlhhZE0rR3dEd3k5aTZPMmN0?=
 =?utf-8?B?azJiTnIvRWMxdm5kOUx0OXNXNWpiOG5OSVVZcXRYVFgrVXNRWEVxREdSQTFI?=
 =?utf-8?B?NSs2TnozUG9uekhtOEZ1cU4wT2pneFpzYkZyUWxTMGZiY0krZURRVWVjVktq?=
 =?utf-8?B?Zm1pQWpJSUpjaTNueXRjemZrcm9WdWNYLytCVjZIOC92NDd6a3JYTjlIc2hm?=
 =?utf-8?B?TjQ4YlVCeUZpa3pOL1pWeFdVMUozTForSUpxbGlwcFZiVnc1TWpGMk00NElu?=
 =?utf-8?B?dExxekt1R3Y5Nnh2SVg1UDY5WEdZM2VFRi9ZcEd1am9lR1Z5ZWlCTVVjLzFX?=
 =?utf-8?B?KzM2ZjVWY0JoWDlqOUljY3dGRXRoVmdiOHhPUHZ5RXdibFpOMmo0WFZqWjA1?=
 =?utf-8?B?L0IyRDloYnVibjlsejhMNFNhSzBFUHB5U2pHalMrSUlhalhTY25wN29Fc1Z4?=
 =?utf-8?B?YkcwaHpuQS8yQ05OV2dIUTlNNlY0RXluWHNrL0JGVEZJa3FaVzJxSWJXWGF1?=
 =?utf-8?Q?krduwsUP0mwcr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmpJM2dGTUZDejFOdXVMbTJTVzNJYS9vZ2ZKeTVlVzY3c1VLc1RzT01FTFpn?=
 =?utf-8?B?dyt6TGJrSjNWZWhXa3RESHBIREFGZkhpSGZaL0xsamJZc2hVRXZ3NE9jWVVx?=
 =?utf-8?B?UlRFaWx6MVB2OSt5Q2tTMjdRRktOMDJKU0N5UmRJRHlPN3hRdzF4YVNWdHRv?=
 =?utf-8?B?bnVQN3Q4QkJ2NzZYY0EwRFpNMmk2RUc4b1dWczFmM21YZXM5ZjVmb21FQkVY?=
 =?utf-8?B?NFFwY0tOUW8zbVp1UmdrTGl4WWdVZmhqTWRkMm1neWFFb3VuNHYxdGZQUFpk?=
 =?utf-8?B?ZEc3MnZ3QThuUDNjMGtxQjRKSXdvY2tqRWIzZ2dvRXpVWDU4WjF3Skg3NDhy?=
 =?utf-8?B?QWNLVjRMbUdFaU42SDJpeWJrcFREU2hnL0ZwMlJPdzdIa2Zma1lYeTdGeTdP?=
 =?utf-8?B?U3dRU1BNTTVieW1LZjhKUlpoM0pzME0xbDRMdEhBd3Q1VGkzODFsaC9GaWM1?=
 =?utf-8?B?WXo4R3Jlem4xaDRyRHpTSXdlSG00UnQvTzZMbWNvU3E0WnkrdnV5bGZlYWlZ?=
 =?utf-8?B?aEFGZDVENkRZaUFraFVyMHlieEMwTkticHBGZXQyT05teGt6SnFvT2JUQlk0?=
 =?utf-8?B?TlFjc0MrN0szd25oZVJRcUZac2tqY2VzOW8zY2RrUlVWREg0dFhVQXRVSVVN?=
 =?utf-8?B?UDE3YkFhcm01NGQ2YUdwSGZwTUJHanlUYTczMkE2RHBONzExR0RVSnVmQVA3?=
 =?utf-8?B?N2hlZjVuWVZuYkxOcHpRV1RjMXNFczdocU54SGp4RkJGS3M2bzhwa1dCc0h4?=
 =?utf-8?B?b3ptcFpmekpBbzhuQ05GMzJrR3VuWDg5VGtCclB2Y2NCdWxvL0FBMmtvOTM4?=
 =?utf-8?B?NmF0Q1loNERZd0tMcWJjZjM2dFlLUUFKT2JJdzJyQkEwRERCN09NRzEyN1lQ?=
 =?utf-8?B?ZUR2c2xJY0hLTGxRdlRrdjZPNjBHN0JadGZRVG8zRVBFQUdBRE5scDQ5Titn?=
 =?utf-8?B?Y2grYWJZWDV1QWl3emxrTlVUM0syTFMvaGd2bDllWmlHNXdLT0d4cENPeUZP?=
 =?utf-8?B?VXN2ZFl3YktueFZGdFFiMXhvL2ZURjVwcXJlSXJJbitMSTFhK0lNY0dBR1Nh?=
 =?utf-8?B?YjJEQURiOTFWeFFMbEFzVUdHb2VNVk95QmxYKzZYdzhVUzJUazNobzZEMnhq?=
 =?utf-8?B?alpLWkJtNUhOUGt0VC9DVE9ndE9mRkNnWVJldVY0Wk9rNXBVRDlpais2am9h?=
 =?utf-8?B?QWZ4VTkzRFBWTEVCVDJna0R5OE9Gb0hiOTA4ei9OaUJGeXFSOXptZEJlUXov?=
 =?utf-8?B?L3RIKzFZSXdHZFVkNTNOL3dyV3VFRmFMYTR3SjR2a0lJYW9HdjZPUklqa3pZ?=
 =?utf-8?B?ZSs0NjBwZmgrSkg1UUhmQ2hZRGJLTWFubkpiSk9iZ2xRTE14cDNYR3cyNkhY?=
 =?utf-8?B?L21qUGVYWVVxcFg5NDRJbmh5ZnAxS1ZtTWZmRCtrMHhVMzM5QkxBdFpuRWVx?=
 =?utf-8?B?T05vZlFsR3hjTS8vbTlXRUo1YVl2L2FWWE1SZWU1M0wyZm9ZVmNDbFZEZi9l?=
 =?utf-8?B?VDluVkU1TXZIMno2dkZic3krQU00ZFl4bTBEbjdkL1RyR0NhSHJiZVRURHpQ?=
 =?utf-8?B?dEpqMGdWZGV0VFVVaHhRZ0ttUVVRT0NTc2N0d1RqVTRSZ3Qwc2JUcEplVWgv?=
 =?utf-8?B?ZEpEMGxwblRQazQyWVB6K2pvMThjbkxDN0VkUkFwdjhmcFNDQXVVR21iUFhJ?=
 =?utf-8?B?YWJMMXFjNU9FTDg4TFpuQnBlWW1NalhKejBhZ1pWM2dsemhYai92cGYwRm1L?=
 =?utf-8?B?ZDVRZ3IyNWE1V1Rvbkt1emV6Wm5NVTZsWWdGb2pZMzhzM3MyZnkybXNrZ01P?=
 =?utf-8?B?T0x0T1VEZzFhZENqT01WZkNXYVZUVk1Nc1JSM2czM1kwbmxRVjFNSEYzVXpB?=
 =?utf-8?B?RGxGTHFiYXJLcnlsRzNCSGhBZEhHOTFGbUR5MzFqQ2QxVmxrM0c2UUpmbXUv?=
 =?utf-8?B?VWFEM0xjbFQvQlNoWllESHlZN0d3cUE4cmoreFJvWDBXUE9WczBhWjNtSlRi?=
 =?utf-8?B?bUliMXg4YzNEMWJCMU0rUmdvWXBJRWNxOTl1SGNPeDJBUmt0R3AyQ3FPbWxD?=
 =?utf-8?B?ZnUxZWhMcWpINjRhNmNocFdDbmNsQmRDeUI5NXJPWS9nOElNeWJJenVDQjNS?=
 =?utf-8?B?L3JxYmUyRlBadkZDSVFJamZ4Vm1kMGFXUkcxaHhYR055Nkw0NGFuQjFXWFQ5?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b6d7aa-c27c-4301-3ad6-08dd5d35d1ef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:06:29.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38hYbYTkqO4n3c1OPLQWfiWozDUFWFfrEtJ+XsN01zqpI7FfffkmnDh6RKmdWAeDVNX6eSrVVrnDB0nFWDqw619OTpZaf4r6oE0iwewvJsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:59 AM, James Morse wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> rdt_init_fs_context() sizes a typed allocation using an explicit
> sizeof(type) expression, which checkpatch.pl complains about.
> 
> Since this code is about to be factored out and made generic, this
> is a good opportunity to fix the code to size the allocation based
> on the target pointer instead, to reduce the chance of future mis-
> maintenance.
> 
> Fix it.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


