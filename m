Return-Path: <linux-kernel+bounces-550456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03233A55FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88A93AFEC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851CA190482;
	Fri,  7 Mar 2025 05:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqT2pKPd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1CD12EBE7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741323979; cv=fail; b=rRQe9EMCjHn74MbxDmoaKeMUjVBdFYYuZes38A5O9jGbh3C/4x4i4YcaKWY6ajAuIAbU9mkJC8XK22bFPmWwnZX83P7DzlPTZqs971UFgLqTWXbNGJcT9ObTPKc5FF/0zXilCpQ2FFkKF2wB4EKLO2J8mhHSmbSiWyJvR2l6IIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741323979; c=relaxed/simple;
	bh=2DbNXCf0u0JORgyezF7/srIiuHWI7yIVw9cOmFNoH+U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bJdx0D5IF8QMcy+pYIGZETvkfSGtyc152DR02a/xfr+Yv7wnt9li8Dxz0Bdx2y0PZvnniqsySZOauG5/JmNuyGlqjzxX1Uo2MFY0IwEw43ri8PQbXoIsl8eRB9EQGUke/CIKTnjbP8e8U6zhBYEP4/xWAgTnFC5mgN905BHBoMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqT2pKPd; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741323978; x=1772859978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2DbNXCf0u0JORgyezF7/srIiuHWI7yIVw9cOmFNoH+U=;
  b=kqT2pKPdhujxJMxaZ5tZB/qQid/YUy/YQpDHPuWWstme0za8qomidt0D
   mYvW5DE5bO1uHZ5cERnso5BvFSvxeV59Vf/5f7EDdBe0EO1+h4q+YaJ2+
   6FsrM3fqrBihU5jVphSlJK9+j4UjL27MrbBRbPaDgNvHTGrtalextpfQg
   +kTiCYmJOr84UdZh/i9fpBatF3SyP0pIVhelWKb/i6hCnCj3VVIix3TIx
   3GTfs5Jw6rYqWEfpMGGk5vO6nHhS0o+pECQCcILVog9zy4nRMWmA3ugdq
   tmJhVWK/Fko1hAOChjhQRwmEJE/nuZMZ80LvJGlUymszCvGVRBVplYa+g
   w==;
X-CSE-ConnectionGUID: Fow7Aj7BQaeh+E0lQwC1Vw==
X-CSE-MsgGUID: yYy1zU3uSGCIo4ZJaXlTIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41617239"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="41617239"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 21:06:17 -0800
X-CSE-ConnectionGUID: jAqKtDPMRi6/9ovC2tmfIg==
X-CSE-MsgGUID: b1TUO1f8Q8iBdy2lVlLJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150167333"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 21:06:17 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 21:06:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 21:06:16 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 21:06:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgLio1+BFYV0oLIJlMFn4QRkK7O0cxxW0tMKbflFqN35roP8AIv+wg88pQn4Fd8KIp7zRhnprt3I6LQLyTDdoRV+j3qKnoB4mL1H+KxyV+wsL5N6/JTgS4jj7QukI+3Mc71rPITdhSLaSgNRQxPGHkVVcuCoVXJqGyWwMR9vtdKPYf9G5nWARSqxbNWMQggszBhhGseTDldyvnpTYrZE7z/Sa6kuQ+F210P9TdsVezeXpY2X/jl9ae5Fqn+3TXyby54utJjB/NDvj/mMUOmrzKabgk0HMbY39JcaIc51JV+cFWrtRfppGCzTAJiY8xWlkskEt3x2amUqNwPDPlGayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIFCVKd7jsHSew74jU4AanXtV0su9VGfLeI7GLx2wLs=;
 b=A5QIaHBhA7fPYc4LZjL0ZqUqWbU3YI1e19nUAef01tzCx/QG7Yr1cpa2PixdmQL+ZIFtnphgm5270BD7jSxvjpaZTcMiFZ0wvPPZiLEm7VXiXCUXGbrZ73Gslxafyil2mdt7IQcbbElNYQhsCduUneNFkiIVXRGlfK2b2VoFemEQJQSlNrjPogWELI4JaKr0id2eSnG3qeu8AhmBICxngHy4lLbh0y1Ufa+vy+pcPrfpZyPrHzXl7JvuOdrgz/H9bAqE8arV7Z5C9l2TsRBd2mbdrFau7Ul5AzWj+F9bb4A12S/+ktwMes/lSLihIJau9WoNIne7mQbKQWOrtpbsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 05:06:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 05:06:04 +0000
Message-ID: <86205c21-e0cf-4e46-8045-d5e504160a9e@intel.com>
Date: Thu, 6 Mar 2025 21:06:01 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 42/49] x86/resctrl: Squelch whitespace anomalies in
 resctrl core code
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
 <20250228195913.24895-43-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-43-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: f485e426-9f79-4fa2-9cbb-08dd5d35c30a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2tveDBnNFVjRWJxSFhGWmE2WngvZHRPODIrS3FBL1NVSmo3ZFhvekkxZFBw?=
 =?utf-8?B?YnJrRG9KOUMveVkrbU5YWGxFY1NTZXNaMUg3ZVByVXAwUUNGN3h6VzNRTXhX?=
 =?utf-8?B?bmFTUjh6SlZUelkzRlB0d0g5blR0SjltNm1YdHNFWHNyZHVXNzhIaFlyZURs?=
 =?utf-8?B?aFlPK241d01Tc05keWdDMG9DZVVKa2pFeXpBbHRmbG5xdDM3YXJJZ3ZVb2ha?=
 =?utf-8?B?L2FESmNLZGRnK045dW1yWk1LNGVsTEFzVXBmZ3RoYWZyVVFrUFdVMzM4WnFX?=
 =?utf-8?B?Y1F3c2pTOVdneUxMMXdZSkFSclVYV3FYb2xrL00zRlE5UUhDQ0NScUN6SDNC?=
 =?utf-8?B?U0tpcjNTV1l6UGt4Y2x2UFZOVnlDQlZvbis2SGxwb1ZWenNIcEJzNm1UdUli?=
 =?utf-8?B?Umk4MTNsZHcrdzlLdGNycG5EVUFJanFvN3NtNEU4MVVUbk9xU3VQUGxFZDdS?=
 =?utf-8?B?ckwyZVI5aURVOXRnSEFybmNZRmNEa2xUNCtaMVo5aVRWbHk3dUxGa1FNS1Rs?=
 =?utf-8?B?VTZXVHZZZDZvc1NVTkl3K2lyb2RXWXM1TFlEZ3A3aUwzUHQ0M09Xell6Ti82?=
 =?utf-8?B?dFFlYi9CTWMzTTkwNDVINk4zMG93MTlpTmxJT3AyaG5wZlJyaUFwWURJYUti?=
 =?utf-8?B?N3l0Tk1EUG5XK3JvZHczRTNOUndXUnM4VGhhSE53cmlhbnFEaFIxNjJ6VERP?=
 =?utf-8?B?b3pIUmcyQzlHbm96R0ZoSEZYWW5KN3N6cWw5RGkyNHoxYW50WHBsNHgwWnRq?=
 =?utf-8?B?NlB4cTVsTUVxcTlhSFlrT2k2NDA5UlpNdzJYREJQQzdFOHphbU9wZHJGbk1Y?=
 =?utf-8?B?bm5VbGlXRkI5d0ozRVFpOFIvWThGRVhLOGEwMU9nb2s0OHdVbW9lSGFxV3lY?=
 =?utf-8?B?eTJiMGxjV1IyTnljU24wbE0ybWpQODVTdlQzQmJXOUlLbVc4TUhDTTlVZnA2?=
 =?utf-8?B?VXJ6a2F2dWRCVzR4RWg5VHJmSUJxbGdVb2lvS01MVmE5eGY1YmdLRWtkaE1z?=
 =?utf-8?B?SmJwYkNic25ua0doczJVMDdVU3l4b2J3TGdpbGpVVUlMUGlRQWV0OHZ1VWsz?=
 =?utf-8?B?ait2Zit2Rk0rdGVCNVFGV2N1WWxrRllIejh3M3I3SnAzVDJhZzNwVTFJbmRE?=
 =?utf-8?B?SGk4NkZKdFhTV3hoTWc5NFZqOUtseDI2dFFTNFhsVVRYb2o5UUJLQnhyR0hq?=
 =?utf-8?B?L0JDaytSbFlsQlJ3aDJMUGpEY0EzZVNWb2dBSVJwRXREdGVDdWhEdEovTStP?=
 =?utf-8?B?a1liMnVnTU52THFHRkw2YVMrQXZwNmc4ZmF2U3ltZ20vRDU3SVVsWmhaTkFv?=
 =?utf-8?B?dEdMTk1JTmdtNk9VMllCeVdmb1BLRnlHQ29LSkpjUVBGck11VXV5OWlpVkJL?=
 =?utf-8?B?MnozeENISjBvU2Fpc3Jiakl2QXdwRW9yT0ZuaStjWjBDcnh2Q1dPU0d5SmJj?=
 =?utf-8?B?YWRMOE1DM2xpRm5penl2VlYyRzlWa3NDQXlBc0hxMXJxRExjWGRGVit2NVd1?=
 =?utf-8?B?ZVcxMHp5dGhqWFR5bHdqRU0ybFVwQXM3c3Y2UDgvMVMwOUtYWm14T0ZuajdG?=
 =?utf-8?B?Sk0zNVJlSVk5TnZ3SlQzTmVVTWg3bklOZWtycElWenRhOWQ2RlFqOWc4bjB6?=
 =?utf-8?B?d1dEeTYzM1ZsYW8xL0hraWpKZmRjaDUxbzFQU2dtOGZFODZjVUJxeWNsSnFM?=
 =?utf-8?B?R0xORU1wTEJnZnk2OTBMY2JNTHJKdWdNeUNXblp4Ky91T00wTVg1Z0ZjYnRq?=
 =?utf-8?B?aFJXUjlmSGhHMmNseFpNcWpiSnFpbEpKdmZZNWRrcGNzbEQ3UXVlMHpqTmUw?=
 =?utf-8?B?WlFqOGJYN1hZMzd0b210dFJqVlhuSDNoMlQ1OTRKWWxZVjFocU1peHRsT2Z5?=
 =?utf-8?Q?WAnZXeWc7RrPQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WitVYUUzcCszV3dNVkxPa0tJdjA1anA0YU90NEUwWnZySnJxL3lhRnp0QUlj?=
 =?utf-8?B?Tk5MdGhoRXRaN1h0dlhDWDFIRmdtcXE2ZkxFTkhsbXNRb2kvTmVhdUF0bm03?=
 =?utf-8?B?VFpKRGFXSmMzZVU2UDdGNEpWNzlOVXhlWDFreU5CVUYzZlVOZFN5OFlnTjNK?=
 =?utf-8?B?ZnA0anpMNEM2eHdoUnFkNm15S1FkM0RxY1NuY1V0c3lGTWpQdCt3UlF2Ync0?=
 =?utf-8?B?bDlaak05eUN1aGlENDlDSUE0QW5ocytKaTd6MFllMko0KzdZWjB1Mng3TTlr?=
 =?utf-8?B?WWhKdC9haWlTejRaeVBPTUdDZHE2WjVCb1V2RGd1TFU2dnd6WlN6M3FNaVlP?=
 =?utf-8?B?MmZaZTBaSFBTKzhUbmhCK0Y2YytqVitYS3ExS0pKWCtrQklBZmo3OGlkSkhT?=
 =?utf-8?B?QmVqMkZnSlZQMlZ1amFJblozTmh2TisrQ0REVVpTNGJpVEZaaXo3R0Q4OEJj?=
 =?utf-8?B?REtOK1IwSU53K0xHTE9ZN1FOMXVWWHNBamUvRHFCRTR5Nk9YeHdJM2xuSGJ6?=
 =?utf-8?B?aGoyMXE4QmRCOXI5VkdlTUxNYjkwVkZBTTNrVkdTdWk2MGQ1YWpVSVN6NDAx?=
 =?utf-8?B?WjNicFphSXpRT0tJNEY2MGZpMithY2hxY3U3ZkxsdmJyTFNLL29jYklPQXFs?=
 =?utf-8?B?YVpJaWo5VllPZXRyTzEwYW5WNU1XUENiTmQ1dUh5eUI2THhEc3U1WFVUc2pk?=
 =?utf-8?B?RWh1RWNzV0dWVTA5bDM0OHBzV1RQdzcxOThIbk92MnZiVi9VT1lLRU5uaVlH?=
 =?utf-8?B?eDRGSUordm5aTjhRb1o2QU1oUElNWGxJZ1lOYXh5dzRoc0lneVdnQ2dxcmdM?=
 =?utf-8?B?c1E3Y0hFL3hxTDJZT0V1NzRlMS9OU0pCckZrOFV5M0FzNXl0eW9zQU1tOXZw?=
 =?utf-8?B?bEFWcC9YYk94U0FLdldhVUdHenhxTVJXbkQxYWFWYzJRLzFtMDhVQktBWFNC?=
 =?utf-8?B?bS8ycGpRVFhWc0lGcjVmRUJOcnVYTWlmWUxzcGlwMkk0a2M0cFMrVWJ2eFB3?=
 =?utf-8?B?UGFGRFZjWkJtaGRTV3RqZ2Q5SXB0b3VyMWJHM1JFaC9nQk90bFFPMXRpVitJ?=
 =?utf-8?B?bjlsTEtDSUdLTUNHYUZha1BXVjliSS9meHRwS3lPS3duU3JOY1d1cDNqNnVH?=
 =?utf-8?B?NkpTVklOSStCT3FaWCt6ZDlnYmk2NFBKcnlPOFIxTE5iN05remFSRFlhN0Ix?=
 =?utf-8?B?VGo5SFZ3MVhDOCtKKzJNeW1FSEF3ZjJKZUw5d0RlWjN1Z2Mwb1FVeEJWcTlj?=
 =?utf-8?B?akcyRGcwa09DZVdIbU9IcUtPcXI0TmMxV3hrOWJtSjZXdDkweDRDeEpNWE8v?=
 =?utf-8?B?R2N4WWJmMmFQZVlOWXZQRUgxRUxaV3JjbkpFU0xqdlNINGt4ZFpZVy9tR1Y5?=
 =?utf-8?B?NksydzBNV0xiNmMyOHRrcE5SbFdyN3VqSmwwZ082Q09KQ3Awb1o5bTRpTmIv?=
 =?utf-8?B?Y3pVNVlHYit2MUtka1JoQU8zMGpkL1Q5bFFXRXpBNEZzdWFLV3NzUHRjV0RI?=
 =?utf-8?B?b0cxaG1aQjNkdU5JMTBKcTZsVEpHUytLY1FKZFpNMHJERXlsRW1aV3NkOE1O?=
 =?utf-8?B?N1g4clE5RmhaZG9lKzNtejA1NGRxNm9kNTQ4LzhENnZUbmxiZjEwVW9taWpy?=
 =?utf-8?B?TnUzSk5GSWpsOExZRVVYVXlQcHdHRFJFV1lZVHlHYWdHMnBUTHN2VlVqQlgz?=
 =?utf-8?B?NjIwRzNwVzM5d096c3JvbDh2dnJVZ2pzWENlNGdaUEtNaU1iU0wyTEFzait1?=
 =?utf-8?B?K2VETEMzMi9ONGhQYlFFNkVSMUphQUtRVDg1akFhamM5UlI4TXJsb3lJRU82?=
 =?utf-8?B?Ky9KT3hCNW5yVDBCMTJBL09NTmxGaG5GS1NDRWRVVGxKcTRsdXVHbGlhdmtq?=
 =?utf-8?B?RllkajIxU2F4YjQ3RHJSQ3NpRTNhK3dtUHo1enVqaUtvMzdIQmlyQURsNzc5?=
 =?utf-8?B?ZGw2b0dsUFZSWTdqVFNBQUhRT1ZDVXQ4Q1lJVVl4b2hQcFhWYzNFcURIU2t4?=
 =?utf-8?B?TlExRzcrV0R6ZHhkMGh2K3dQUkFLRFRxYlBBMWRtSGdIRVhBZjY3NXB2QnRH?=
 =?utf-8?B?WFNxVk5xeUQwVW1XWU1QbGMwUWpVSkM5U3FsRDBRejlBWng4TmNoREk4QTVT?=
 =?utf-8?B?YnB4bCs3dHJ3MFc2Z2FaWFRRWWQ0SmQwRU5sWkkyKy9jUnNjaCtkdUg5NWZw?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f485e426-9f79-4fa2-9cbb-08dd5d35c30a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:06:04.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NjyPzH6hVIq3/tlvUCWdiQLJ8nAn51//mhwzMhCdQIheSkkufDz/qcEJv9iiHaWcx8X6ZW+B8g5b98DIVTj8ci7JmoxIjhNP5PfQG871Fw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:59 AM, James Morse wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> checkpatch.pl complains about some whitespace anomalies in the
> resctrl core code.
> 
> This doesn't matter, but since this code is about to be factored
> out and made generic, this is a good opportunity to fix these
> issues and so reduce future checkpatch fuzz.
> 
> Fix them.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

