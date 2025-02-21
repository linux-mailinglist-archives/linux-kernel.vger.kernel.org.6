Return-Path: <linux-kernel+bounces-526774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530B9A402FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF52E3B33E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC382185BE;
	Fri, 21 Feb 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBLQLEGd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E2D1D5166;
	Fri, 21 Feb 2025 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178169; cv=fail; b=Da4Bb7a1gOaeXx90VYM9kpIxRE2PZa3i/DyiGcL9NEaWgldDREhzC2tFZgi/9HXmzHjG8Ybu+v02BJ6YanmiY0dfh5OW0IVsCJGV1/NiXDmRQivzE4Rq6agC9+YomNcX1BCsHBppXcz2yUNujCMaRaWl4R5mtxtjW4c08ZM1U2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178169; c=relaxed/simple;
	bh=HJw9/uSJ7QEKbIhEUxJurKirxy/aRQTwU3VQB2mJjMk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MIYYHy3hVy6o/cy4QYEUAhawUOhpuVc1kzBixeA5blgi9ArZyx7+VWO82FPzfYLZyGdal/f9EY9wOVjFY2V1HTxrej8XRvgSo5kr1vloZM+osTnMhsfv+cuOwFD65tdqBsqNOzcyeLgQk2pYQmR71stNSftHbdfakfMCKUXev6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBLQLEGd; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740178168; x=1771714168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HJw9/uSJ7QEKbIhEUxJurKirxy/aRQTwU3VQB2mJjMk=;
  b=BBLQLEGddMLHDhKKXRfYt2c4vD+k8fRkuEL/jfsrCPv6joPvt/0+pKwl
   s1KHjO8mZj3URvOT8qFyFyNvo2iTkgTGUxaUyq+ZaojZO7b7W4jw4v+bn
   SRcz5/KYRvNBLsoIbHRthfZQj7Y69OqGr/wVOKVzDwqs+ouEQaXYDg6E8
   vMiwtb/ekQHbI5ZsiJCYHtC7EzTPCgMiE07GwLAoxNcdVyjHCt55TkVMZ
   /cBuIOwn8bO7SQXpdrJ+o3g33rzmbe7wQ/s7FLgvQWhr0+RCzxH9qdZ8q
   32fUMvJID6JZbblUX+0PXY8dOnimEGxqG3k+FAeTRfghqk2ThOOdXEfWn
   g==;
X-CSE-ConnectionGUID: u+caN8yvR5GMMrCNyXTvKQ==
X-CSE-MsgGUID: 1ZZF0VSlRUifLcI2TtKccQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44661045"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="44661045"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:49:27 -0800
X-CSE-ConnectionGUID: g6cwvfhjSjuiq0oE7RKGsA==
X-CSE-MsgGUID: iCbNUhmLQ+2mpV3+K/JkWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119612857"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 14:49:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 14:49:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 14:49:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 14:49:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQPXlnoM/Pr6FgD73QDXfTOO31yBM3rL+knkqnQKeQIm1jR/BnfSit/Ppb2SBhFoOsy24b4D358AIPme+ATFwlzZf6RnOB3tLoyPVPc2ASxIOlenYbYh7h/+/oGmYoMq/a8lnGBf/Rr3tl2GBIJk0g7fxVITF8JGsEk5tmpP4xoqK85A+8dYKSNQAeLlHCzjnlo6IiZ/Muxqg20KCF+g9oQoF2S+rvzVhgvfnkrTF8GXUrd5mCPqIAujXxkZikeZ6TDsc5MsDxMnytEZpH6YkHsM6Xez4fJBGnxsNxFfgBu6E3oSWyTB/LzT/sxBii7Mhj8bh89fNkiMWS5xt8NkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKpSYwZEamMSAc8BiqU1brK5c7RfFFY0Y4pgQGy5xf0=;
 b=XO1znH/VU3WXS05p8mb0b4+6mp3BM3Ki6QZFWNwSrT7FvmXGncC5Hm3/E5RpY9RRAGvCx33GLhuyJWW19XfSyX9YK2ZOBF8rrVGK8nukHBmwS4NxD057E5uC3DG+ERVCO0tv7A6+8VYxbVeUs/jZVdBXziF6jC+XdMuxeApfkvA0K62GqftAZuWOqim7fwdo9x4bHmkPLIfHojJ0Oqiqe41DupCkfXvvvnl6hdJPtbesCqaq0AUKC/slgZENwWo1ClxAFYD0LIcC5YP7NrkCEy6NJqxtkN2+AsIGKc/khYM3mcw7RZ7SR9KLp44r0100LmWdJJRyySUxb5q/31ADoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 22:48:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 22:48:49 +0000
Message-ID: <84e31944-39a2-4e15-9772-56f82e70fbe6@intel.com>
Date: Fri, 21 Feb 2025 14:48:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>
CC: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <akpm@linux-foundation.org>,
	<thuth@redhat.com>, <rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
 <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
 <ac6860d4-92b4-424e-af4f-d6e3d5722232@intel.com>
 <CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com>
 <Z7cw4JTp3Hfx/4li@e133380.arm.com>
 <2889da50-b654-403c-910e-13b9144596fd@intel.com>
 <Z7i0etOZcZ9jM/ZU@e133380.arm.com>
 <5f651b5a-3470-4ca8-80dd-4593acef6df4@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5f651b5a-3470-4ca8-80dd-4593acef6df4@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:303:85::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: be241699-d618-4a04-8da2-08dd52c9e849
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3c0Uk9XMFh2VXZoNGsyUzhyVHB1SjZiaVRiRUxZd3RTdzNFRDN2Z0M1RXha?=
 =?utf-8?B?WWlTMG1MNWhxS0x0MFVtZUFqSDNQdkV4Zi9kUWZQL2h2QkVnbVJhTWVDb3l5?=
 =?utf-8?B?SzBpWkthRFdRZHN3dDNXY1o2NzAzVTlCWWxQeWFVWExBNW5IcE9PZmJOUnp4?=
 =?utf-8?B?bTRQKyt6MW1XMXM0VEt4SmVkTkZQYmo2VWpZL3paSmF3blJLcjJsQSs3dkdx?=
 =?utf-8?B?ZU91YW1SZTFsVGFlbitnN3pRaU80Z2dTbWV0V29qTjhlRWMvT3dZeXFETmlL?=
 =?utf-8?B?WERmZVN4VC9MZE9qMHBKdEtXOWc1SXVEMG9xSXNWVmJUTmUvQkZHcjNGeFNr?=
 =?utf-8?B?cGNnSmljK0NBWHJxYkluV2tNUFk5WSs4bitrSXBWZFQ2bXVvVldUN1hUWXBi?=
 =?utf-8?B?cmZMamtJNWYxUjhRZmRLdG9hUlJPWWVPQjh1ZktoNDBDSDVTM2UvVGt5VjlQ?=
 =?utf-8?B?dW5za3YxSjk3LytzbDkwejBQVFVaSHdka2VSeFBmUVNaRmwyQ3NTT090OVZx?=
 =?utf-8?B?bGp6UTNsSXZYcnlTVGxEZGNVakN6RHlDV3BKWEYyRDc1Ry9RdHk1Tm04SFVR?=
 =?utf-8?B?eEtWUUtBdmJUZmwxSGpndW5YRkFSYUwvajlQT1lMRGtwYXgyQTdFdFJJTzNo?=
 =?utf-8?B?OWJOQU12TkJ3dWo4UTJmakdQZEZabUNXMndXMGdUcWE2YW5vZXlCOENIcGw0?=
 =?utf-8?B?cW03SmhFbmliN0ZPQk9IczFhZHRYWDcvRWJoN1ZUcGZFT2lmajN5eXNXbkhD?=
 =?utf-8?B?MzZJdWJKMDBLV1pQM1gwbStyRkRJOXZDcTVObmhQclcvV2MyNytValQzVlBL?=
 =?utf-8?B?MWZ2NjFQd2ZUTWxubzQ4cTdFa2MveVM4bGNoSDZORGo1VmdPaVpMdC9aLy9i?=
 =?utf-8?B?eVJUNVJiaUtEMmVrY2JOdHRudytPMFgySFdmYURYQ1R6R3VwRE9QQXQzVmZx?=
 =?utf-8?B?WVlUWm1Zcnk4aDVxMzhPZzBLb3JqU1VLeXc4UzhVdmQwVVdJOUdFbnIzaDRG?=
 =?utf-8?B?aE9OcmhzM2puS01PNzhjbkZIZHBwRzVuaXJtWC9nT0tzQnpoMVJaNHQwZ3do?=
 =?utf-8?B?R3RRRkZTL21seG1XckdpZ1luZC9iMmJucTRGNzUybWQwdk9wVzgxdFV5S3RF?=
 =?utf-8?B?NnczSDJ6a3F3QkpzNlJ6aVEycHVDbUhFNU9XVCtxcW1ZL3d1SjEzdWpWRnlB?=
 =?utf-8?B?Mkp1MnB3a1RXdHNlVEQzWVlBNyswVmRxbDc0Q0gzdjMxYkVWcDc2bU9TRGJy?=
 =?utf-8?B?Q28za0Y2K0Vmelkxb2RXSENWeU4xNWV6TVZMVjBJSXp6cVNHSFlNVXpjUE9I?=
 =?utf-8?B?QVdTM1pkdFZWVHZhSVA5cGc3Uk1IeDA5VllRVmxrM3RCR1l6NUR0ZW1UUE5v?=
 =?utf-8?B?S1BqNkkxTTRwYkc1YnJEcGdqSE1uZzNDblNYVjdlMlRPcldqV0duQ08rNkVG?=
 =?utf-8?B?S2dYM1hreVh6U3JEQmMyVUV1dVgxSndRajMvS2hkd1FLc1FFSHBraGkvQVE1?=
 =?utf-8?B?aUFJTVpkRlA4WTBMLzZYNkh3ejZmcFN4ZnkycEQrK2s4dEUrUERFZVlnRG9q?=
 =?utf-8?B?VkN3VW0zM0R0U3BXZjk3Q0UzckJUb0JjZFk0emZab2UwTkJ6L0o0VDBJbE1i?=
 =?utf-8?B?K1FuTGppWDA5QnVwYUVLZ2lHZVIwM1A4bG5RME1pRUNsZjA1U2gyVTdBaHND?=
 =?utf-8?B?c2l6d00rOUF3cHRaYmx3ZTdabWpCVjBLelJHWFg3eVIxbGZhVEhNS0d3U2wy?=
 =?utf-8?B?WldSbUdBc3NFYTRPNGJycUs5WDJReFR5Z0ViVmF0U0gwbjQyRzdZOXA1bW1E?=
 =?utf-8?B?QW1yS2tYeEtqOG1PZ0JUOHBpd29sZURlbThnSXJlVTZqWHpOMW45YzNRZ3J3?=
 =?utf-8?Q?dU3Jir+mV8cNc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZpWUtjRHdsNnhqYjlLRUdkYjRuald5SkRhV0hJbFNYVFlieFR0dlRiYUNm?=
 =?utf-8?B?TW5wdCtVaFBBbTNJdWpYaGhnZjdRSkJTdmhJQTBmSHo5Mm5jajZ6bVRMSld1?=
 =?utf-8?B?MXREUW1JYlM5c2lvaGdVZ3hySTE2cmswVFFveEJWcFZiK28yTVphZzZ0VWh4?=
 =?utf-8?B?TzBGK0d5UzUxdlpIcVJVcDcvMTByZmhRL1hRVitmTFo3aU9oM1I4VEt3ejdx?=
 =?utf-8?B?Z0RROXFHTkFTbnVVTnA3ZkVuRUszRmVWTnJobUUyRlp6RlZvTE5qSXkxOU9D?=
 =?utf-8?B?aFlPSE04ZmVxc3lTa0llS3MwdkZsSmRldlpxOC9XblliUDEzaW1GTlhZRGZF?=
 =?utf-8?B?c3RPWW9FOEVyR1RTNWZ4TmhFeWFUU0RGUmJ5K0drK1VtWjIyRDdIUU1NanJP?=
 =?utf-8?B?aE8yTFZET0lKSlpyU2hmcElGcFByTm1HRi9ycnhpMjA5UzBWYk1nbzd0bzRj?=
 =?utf-8?B?VjN3QVN1YjZrckhmbGpYV0lVZUFHOStSS2lDQ2lZQURGRFVrZEM0akJURHhW?=
 =?utf-8?B?bDNLalZLeUtLeTVoTjV3TEwxWFdtWFlaMmxBLzd2U3ZLdTloeUZMb3pqN2pL?=
 =?utf-8?B?TS9JTWRkcGQvamVVYTM2UXAydjVlNUNiWndZdEo5eW1mWTg3WXFzRzQzemQy?=
 =?utf-8?B?eE1keWFoNDBQTk1VSTRJV3pWUkN6RTA2eE43NndTVmhqMXZKRlMyckJ2a0p6?=
 =?utf-8?B?T3RDYnhPeFBoUy9UYzhkVE1LK2VDV2tJK2hTOXVYUzlBN053YTFuYWpZZzVU?=
 =?utf-8?B?cnVDNERxaGhCU21HSE9ac0NDSVhmeGxUS2E3Nm1Xb3BhdkY3LzNkSXRCKzM1?=
 =?utf-8?B?YUJRMHBMdkxIMERYSmhIZ0JFSmZJbldEM0lFb2lHRU9LRXlzN3lDU1VvVUU3?=
 =?utf-8?B?YzBoN3lvcXdLMnhzOU1UM3hnUjB2UFRFSlJXL1J2L0NmMXA3OVYxOEkzVVBE?=
 =?utf-8?B?ZVlXM2xOTlVPWmxZTEx2MGRhVVFBOG96M0FtMVo4UmZ1eWxWbjdOUzhSY2cw?=
 =?utf-8?B?T01YME4yVlRjVXRwKzMrQjYyUjNnNzh3c2NlcTZlRDhEaE1iU3lkTUZtNjh5?=
 =?utf-8?B?NTRlY0FFeTdoQURvUEI3YUJ2cFY1eG81WWhRTGVHcVcwWkhBWlBPbGx5NjJQ?=
 =?utf-8?B?dHN1YUEzQmNaSmJoeW44VHU3eENDMHlvZkVaNHY0eGRsMUEwdzd4Y1piSUtl?=
 =?utf-8?B?R2dpL25LVlVERkNuSjg4ak5xZmMvN1h5Y1N5YlhMTW9JUDE4MC90MnhTbXNj?=
 =?utf-8?B?ZlBEOEh1M1JGUzNFR3JvUDJkYTc3Q05NenY2MDZGbFVxa0lWdXVESG5Zd01H?=
 =?utf-8?B?TWxWbHJHZVRVNU5vN2FHVDd2U0hxd080YWM0R2xVekJSTjdjNGdJOUMwemky?=
 =?utf-8?B?V0ZaVm9rR3NvTE5JM1VUeVlZRnEvRS9Fc0hxanA5TTBySGRaRmRZNjNyV2xJ?=
 =?utf-8?B?TzZpUllKNDhiNjhDNGk1U1NSNVBlNCtZSkplUkJVZWFDLzJDQzdXVm9weThk?=
 =?utf-8?B?TkphUTBwc2swYjZZWWpFUHhiVm5Nd0pmUTMxNXRyd0tVdTArdlYzL2VFVlNs?=
 =?utf-8?B?SkUrN2tRcERrNGRIUFV1QURyWHJRcERtWFR4Q3owaWtFaHIvUVlTZ0dJMWhn?=
 =?utf-8?B?bHhoN3NwMVJiNVpaYkFvTTVFZE1ZNi9wSnNFRCtrS1k3NmxrMmtMaHlsV05a?=
 =?utf-8?B?eVNPU1llR1Y0QTFwQ0VoOGF4M2xYRVR1L1Nab2pTR1MxcU9wWStCVFY0OCsv?=
 =?utf-8?B?dkNjVGtSemUzQ28vMkxZQ1JvSVV4b3Nra3YvRk1Rcis4dVBBVGJXeGZCT3Rz?=
 =?utf-8?B?N2EvMThMOCtJUk5Wd2w3OTZCWG5Cc1JielRqZ1c1ZGlNcVI2RmNGdncrM21T?=
 =?utf-8?B?bHJ4c0d4YkgwdjNuYWRFSG1raUcwZlZQNWNISkE3MGlKL2ZMRVpFWFJTUXhN?=
 =?utf-8?B?RlN1a0JUZ2svNU1udy85NHZoY2RobE8vOFN0cjJTdC90bEt3am15MzhWemNK?=
 =?utf-8?B?aDQvcmRpYjhVMEpmcVlENDV5cTQrUnc5OW5sMlBkd1BUZmpMcGdRbHJ5ZlFJ?=
 =?utf-8?B?NWRsaGNzY2x4TUMyZzhKdHVsMVhTUElrbUpLN3R0WmhYMEhMdkpqVVdFWXBM?=
 =?utf-8?B?ZldhVTJkNSs0ZmdWNGVkYjZ0T2d6S0Y2Sk4zVStGV2VWTm9SVXIrWGtFamhi?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be241699-d618-4a04-8da2-08dd52c9e849
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:48:49.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0++E47tyxH0kGty+TD7RsLS+PJaufvOGx1e6G5nGvd97ocsMXntyjJuEzTKlj02SXdjVi46RfiA8GokrBx8FkcJU+tgC2yduk2tltgNpBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

Hi Babu,

On 2/21/25 10:23 AM, Moger, Babu wrote:
> Hi All,
> 
> On 2/21/2025 11:14 AM, Dave Martin wrote:
>> Hi,
>>
>> On Thu, Feb 20, 2025 at 09:08:17AM -0800, Reinette Chatre wrote:
>>> Hi Dave,
>>>
>>> On 2/20/25 5:40 AM, Dave Martin wrote:
>>>> On Thu, Feb 20, 2025 at 11:35:56AM +0100, Peter Newman wrote:
>>>>> Hi Reinette,
>>>>>
>>>>> On Wed, Feb 19, 2025 at 6:55 PM Reinette Chatre
>>>>> <reinette.chatre@intel.com> wrote:
>>
>> [...]
>>
>>>>>> Could you please remind me how a user will set this flag?
>>>>>
>>>>> Quoting my original suggestion[1]:
>>>>>
>>>>>   "info/L3_MON/mbm_assign_on_mkdir?
>>>>>
>>>>>    boolean (parsed with kstrtobool()), defaulting to true?"
>>>>>
>>>>> After mount, any groups that got counters on creation would have to be
>>>>> cleaned up, but at least that can be done with forward progress once
>>>>> the flag is cleared.
>>>>>
>>>>> I was able to live with that as long as there aren't users polling for
>>>>> resctrl to be mounted and immediately creating groups. For us, a
>>>>> single container manager service manages resctrl.
>>
>> [...]
>>
>>>> +1
>>>>
>>>> That's basically my position -- the auto-assignment feels like a
>>>> _potential_ nuisance for ABMC-aware users, but it depends on what they
>>>> are trying to do.  Migration of non-ABMC-aware users will be easier for
>>>> basic use cases if auto-assignment occurs by default (as in this
>>>> series).
>>>>
>>>> Having an explicit way to turn this off seems perfectly reasonable
>>>> (and could be added later on, if not provided in this series).
>>>>
>>>>
>>>> What about the question re whether turning mbm_cntr_assign mode on
>>>> should trigger auto-assignment?
>>>>
>>>> Currently turning this mode off and then on again has the effect of
>>>> removing all automatic assignments for extant groups.  This feels
>>>> surprising and/or unintentional (?)
>>>
>>> Connecting to what you start off by saying I also see auto-assignment
>>> as the way to provide a smooth transition for "non-ABMC-aware" users.
>>
>> I agree, and having this on by default also helps non-ABMC-aware users.
>>
>>> To me a user that turns this mode off and then on again can be
>>> considered as a user that is "ABMC-aware" and turning it "off and then
>>> on again" seems like an intuitive way to get to a "clean slate"
>>> wrt counter assignments. This may also be a convenient way for
>>> an "ABMC-aware" user space to unassign all counters and thus also
>>> helpful if resctrl supports the flag that Peter proposed. The flag
>>> seems to already keep something like this in its context with
>>> a name of "mbm_assign_on_mkdir" that could be interpreted as
>>> "only auto assign on mkdir"?
>>
>> Yes, that's reasonable.  It could be a good idea to document this
>> behaviour of switching the mbm_cntr_assign mode, if we think it is
>> useful and people are likely to rely on it.
>>
>> Since mkdir is an implementation detail of the resctrl interface, I'd
>> be tempted to go for a more generic name, say,
>> "mbm_assign_new_mon_groups".  But that's just bikeshedding.
>> The proposed behaviour seems fine.
>>
>> Either way, if this is not included in this series, it could be added
>> later without breaking anything.
> 
> How about more generic "mbm_cntr_assign_auto" ?

I would like to be careful to not make it _too_ generic. Dave already pointed
out that users may be surprised that counters are not auto-assigned when switching
between the different modes so using the the name to help highlight when this
auto-assignment can be expected to happen seems very useful.

Reinette


