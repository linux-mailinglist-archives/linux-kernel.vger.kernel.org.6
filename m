Return-Path: <linux-kernel+bounces-413554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2559D1AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD22281F83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A91E570E;
	Mon, 18 Nov 2024 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aitcmRF7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1813DBBE;
	Mon, 18 Nov 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967660; cv=fail; b=LMosNTdthKFoXrIhFFUKcJW6RL2ZcS2OgsayQ16rS8Vna+HjXhcmUcTj7ZcOUnoKN9q/DO8bwP9kt2yHrGXS3S0Tnc6E3AQBQxIsbyQWVGaP99q2q4+ZDxfw0jAtgXxB+qdnaLeGGnlj2u0pXePCteZtwPpPJtj4Tob38d0Yy4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967660; c=relaxed/simple;
	bh=DBKbruSUGyE4bN29ZxyiKDm8erJ1OGUDjDf3MqeS9Sg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBK5uMyT8TuHvdK3+uiARh+m/nOLmLgoQGlkFkqItPknmezysNQ+SWd9rEwZD2hKmuObau5zDGmyRCVp7HDUcSupB7wA4UMMVxPyuhh2UC4PoOFsUGSfnvA6xcxDs54oZfu0P7i5y6fwEO2R3Q73KLupUqiY3iEsPqBbLfi3sZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aitcmRF7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731967659; x=1763503659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DBKbruSUGyE4bN29ZxyiKDm8erJ1OGUDjDf3MqeS9Sg=;
  b=aitcmRF7oWrijFMEMXr/h8c56jSq7DcyILSRM+AnXfe7AX6SkJYvHx42
   XhAGTmqnvH43Z2vVfFxSxOw++M4aqid4H225dGvTivyxK3mlnl6zxXYJ9
   iTt7Wm1RYlEg1zBWwSa4+yi4o1TinSXPiJYGAa0BqSOpqcJteKN94iPcl
   itxoafgXh3R5QV+PHYsNS/JLhLZGwm5Dx24vJeF8IDS4swE3cKeEYiW1R
   h2EczcepegzUkswDti8wMa9w6kMyQh5WuLjOZZdrXrqHSIbO/IhC++8jQ
   /1XRy/U2LoZTEBgjZeH8eZr/jGSzk0j0kD6rHS1E7OrZaM8NdKVH9KuuA
   g==;
X-CSE-ConnectionGUID: iwuCSLNoQdqEJs91IhxT7g==
X-CSE-MsgGUID: pPsU7b5vQ52L8BGQyMFRfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="19557397"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="19557397"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 14:07:37 -0800
X-CSE-ConnectionGUID: Wk1K9k53TiWQr3QgWg2UAw==
X-CSE-MsgGUID: oNIPH15HSMOaq+i9DspMBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89783214"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 14:07:36 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 14:07:36 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 14:07:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 14:07:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoIlBx8M7PKaczET0QhthBAbTnzzeIrpdb3jP0jWj+7xdj9N+psnc3vBtXPryGqZYeLVvV8gXl0nRFv4l/uyc+hl1ZqIjn8PBEFs50auXwiCiT/JOse1LUmkVzuBmPI0zWMqVX4P3QZKMmC42n5Kzjy9hE/7/xOoY3KNF4XtTX1+lhftYd11TzjR4dJ0osrFbHo1xlnOmxGh4LYDDB3wp6U2iMvncJe/QW1OwAYQ5+oltg9BsHRTCrGTD2+BcobPEeqzH/v/cCxJ8bkx42TpYQDd1gRKTL47JcRW6oA490mZ2ApDfqcKsgnBdPNmlDJUS2OHG7zVTuoFixjpZ/amdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Kg9TBXcMXZitNhd/mNaV5oKShvWnehwUynrMFVyTGs=;
 b=NSRqV32t9OzsAznbqwvtip+UkPSJPTEjHpUFp19rQ7NIaPTuBIoaMeTqY4puv0XgsAB0ohedG0bw+yQ1dmRB9kbyD2G0Ri+hKagYfx6Jw/vm19mGAgM9YftWbcS+uWzTkQN/bwjiqaZRvR9CCevKs8+D1GTTeJm06o1T2F/SLEVR7RgTp5DuPbnXHPBemkrlFx5GDp7LjWaRP77iOY5MMFcpewooyQXjqN9ywzR0eg5p5BTMNr7M5xqOFyc1pMSTBBa/YX+VEeVFtXR8tbNiVbo6Q/JPx3sNLfzpyMOQPy0JZyQdzqh6CKIloBLS9TxXWYjJzXwE5csiBnW/xvECvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Mon, 18 Nov
 2024 22:07:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 22:07:33 +0000
Message-ID: <d5bead60-6a38-426e-afa6-e7980a268d6f@intel.com>
Date: Mon, 18 Nov 2024 14:07:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
 <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
 <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <33cd0cc0-4f81-4a2d-a327-0c976219996a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:303:8d::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2336bb-2984-46a5-0e05-08dd081d66c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmkwRlAvdklOL0U0dDJxVlRqUGpBTzc1L3NpTmlCbmNjZjJtR1BKbEhNKzdj?=
 =?utf-8?B?YmxXR0VsYUlzNjFOREMyRGw0OWo0d0hqN0RvelM5RHlTZGl6NVloamJUa2FW?=
 =?utf-8?B?aWc1bzduRUpKcDRMbmlNQU5TSWRQQ1IwNmVZcGhGU1Bjakx3STZEb25PVm5z?=
 =?utf-8?B?VkZsR1Y5SnVHaVJibTJpdEdiaXlzcC9JTC8vR1I1L2daS0JVcCtDdlViNTNS?=
 =?utf-8?B?NWtydDdlZWRrRGNBNXExZDlXcm12UXdlMGEwUnE5azJ5N3ZKdEJ4SkJwb2Nh?=
 =?utf-8?B?aGNWdDRjcG5iODhnVkdGaklZWVZBUklWdFNYKzNDK21hcGJNK0RRbDJMK3pp?=
 =?utf-8?B?UHEwWk5aMUcxRlMweGQ1by9wRmNMUno2M2M4dEE5cnMxV04vRXRMdGU3dVIr?=
 =?utf-8?B?ZS95U2lIUzhJazZIZTIyVG01emxSL3BaZjVLeDZWeTBKbzc2bUVPWEsxcnVE?=
 =?utf-8?B?K24veFhQdERNSnJiNnFrNXc3NmRaNTE3VEtKUU9VUmpWemRGZnozbWlLVlFY?=
 =?utf-8?B?NWRoL1VUOFVLb3Z1SEpXSWZleUNBY1lSUmxmRHVKTUsrVjdwZXJ6dTUrNlBU?=
 =?utf-8?B?RGpwS3k2VkFqOVl5Y1VEdU1GTkJUcDdQVHEvT1AxVm56U1Jid0hOckhBQVdz?=
 =?utf-8?B?dFRoYUw1dnBRN1RKU3ZoNUJYR1d2Vk11L3MrN05HQ1VGZmtzWklaaXVhRnRi?=
 =?utf-8?B?NDVyMG5MWkxTQVp6ZkJSK1ZqU3RhNmhTMG0ybUtNK0JIMVJOZTdWNFV3VFli?=
 =?utf-8?B?YjVpdDJuYWxROU50YWswbnVpL0RTNjM1RXE1QXI3bWsraXdvMWRGL3JlUWgr?=
 =?utf-8?B?Z1JSK3JvanBYcHBVRGgyNFlNSDFOUklnVEVHWGtTVG9KeGpqalByemxUVWs0?=
 =?utf-8?B?VmVBY1Nuamx5UTlPeFZ0ck4zUU5pUis3OVM1amw5akxWc3dEQU54cUZpVVVo?=
 =?utf-8?B?WnJvR01CZWVqWTJUTnJ1MDFTTDhzbnB3R1Fsb2xzZU5jeEtqSUU0K0NDUzIy?=
 =?utf-8?B?SUlHd3M4OWVkK2UxZXBjb2ZCMnBoNnpUTTNuNk9YamJ1Zm5XRjYxRmdlNFdO?=
 =?utf-8?B?bWFISVZ4dmRwcFRRVGtmQUlFTlNVRTg1RGFBQkw3bmJ1TUxydEVsUlZBVDVT?=
 =?utf-8?B?WWhWd0tveXVBaUZUMUprcVJoYml3ak52Z2Z0MXJuNHR3YTlJd2hhRzNOZGtP?=
 =?utf-8?B?K1VRc2hhZjl1Z0FRUTJHU3A0cVVYdEl3OG5vWElGT3NIdVJqc09Wb1F3bDht?=
 =?utf-8?B?T2NIRzg5VGp4aWRHZnZTWFNUc2ZZSmN6U0FEMWE4WGpKc3d4ZGllWmZKOGYr?=
 =?utf-8?B?M3BMK0pMdEFQZ21rMnVlRWh2Qm5XaXM2T2ovYkdGWXVla1pYZzcxVVB4UENm?=
 =?utf-8?B?eXhEVXVQY0NIUXAxSzQ3T2ZsSDZXM3VzYnd6NHp0SndIMlR5c0xxSHorR20x?=
 =?utf-8?B?L0hxNkxxaDJOdXdzSEI1VTI5M3JCQmZaM21BMmRRSjg0WWdIc0R0UTVrbnNM?=
 =?utf-8?B?dVRvSS93cEF0WGdxK3c3bW5IcVV0czRRd05PUE9yenJpTUlVSmttMmNNVkFM?=
 =?utf-8?B?RzB5VEx2UW0xeGI4ZE9TQmF2cDFUZWozeTNYejlGd0h6SEpJV2lPL1F0TUhH?=
 =?utf-8?B?WWU1Mlc4TCt1aWR1UGw4RStXQzJPYUhzeUc4a0lpV29iVTN1cmtGckRFc2ZG?=
 =?utf-8?B?MGhGeElJMWpKako0eVM5RExYM1k1SW54V2phV0t0cFk2bmJBMkxHekpvajNq?=
 =?utf-8?Q?bnKbLNngxTntbfz/pg4kaFaWb7tkGZUmA20dtzL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3pvbkdLcWRVbzZiQjZ3YmR5WTUzSEFvclhyN1RGMkRRVUhBdDlOTmZPcThp?=
 =?utf-8?B?UDhFTnhtNC83V2RUY2gyRndpWFdLSi9NSldkc2RMMWwydzNzTDBOTmdaUzVr?=
 =?utf-8?B?QTJSNEQxVms4VW9Xd3AwazdrdHVURC84OThlaUdaZGM1NUxhMnNMUkljQ20z?=
 =?utf-8?B?OW5OUEY5QStud3ROMWVPa0w1YU5WMXJZWjJVUVlycEgrdndlSU5ac1JXUlNq?=
 =?utf-8?B?dVBtcFhwOS9Dc0FKSGszZndyVU5ZUkhmeWdjbG1IZjhhRTVVTi9HVU9GODhy?=
 =?utf-8?B?cG9FaDJ4L3FvTTQyTjlnSi9mZ2U5L3hYYjNEOUs3eFN1UVVDcnR6MzFhY3RO?=
 =?utf-8?B?bGlSdTYvRjdJc3d2WldNdVc4THpWVTNPY0crdHVkVkFjYkNJTVRPYWlva0FR?=
 =?utf-8?B?WGJSUFd2c0RNWW8xcmtaYktON2U5T3l5eklNTzVpUGFHVHp5Q25pbTdTZGt6?=
 =?utf-8?B?cytWdTJObDNYQVpIanBXLzBvSUZuTEprZVF6b0cyT1RYUXo1QnZ5Vms0b2tx?=
 =?utf-8?B?ZU9NT2t0WWM0UmZML0xFaXhaQjA4WFlRdFZjUmF6QXEwV0Q3bGlMM3JaNFBO?=
 =?utf-8?B?MldaL0grRitBak1EZ2pnYU4zeis3L1EzOGJ2TGd6Q25FemFkWFRZNHlJTG5Z?=
 =?utf-8?B?VTg2VFdvQzhtTTI4bm92cWo4SitEdnNNV0F1VzRrWFpPNXRybDdVWXdNbWhn?=
 =?utf-8?B?ajc1bWVEelRQUEdjcUhHdERlajUwNi95UWVMMzhUc3R5dmE2NVVyWi9qbllZ?=
 =?utf-8?B?NXRxRjBBS3JiUVZYZ25UVERVNHUvc2tkV3Y3bnI3L2hsR0lxNkxJZDdUbGl2?=
 =?utf-8?B?M0gwOEY3MkdqTDB1SHU4Vm56cU05akNJbzVOK1lZTkU4NVlYR05rZXJDck5E?=
 =?utf-8?B?RFFNYnM3eXhETE92RWw3SkVTSWsrMUh3TFNGdEhvN3ZLUEhWWkpSQVNQQ1k3?=
 =?utf-8?B?WklHdUs1MHA2ZldrK3h1cmJua1MwN2FjSkdWQyszN1FnMmxTYnhVUkd0UUNl?=
 =?utf-8?B?bU5lZUQzTG1jd2tWdWRlL0x5Nk51c0lTbDAwZDU5cGt3ZTc4cVVEbzk4L3Fv?=
 =?utf-8?B?R3ZTYjNzaDJ0SFVFbUoyeE1Za3l1ZE5MYjRoSHJNMmRhZ1c3aWtnOXZNVFh0?=
 =?utf-8?B?UTFRNXpzQmUwWEJ1dzhDTm1NV0pJZ0VjcXlOa3ZKc2FocVJobDBDQ3VhT0Ji?=
 =?utf-8?B?RUxtcG14YmtzaFpma3pPQkxFVGxDZVUxODRwbTBkS2RoZFloYzZoVUYvYlJM?=
 =?utf-8?B?dCtmM2V4YTdZcEt0ZklxRDBtRFRjVk93bEVJTjdFTC85KzlGbDJiNkk2dlQz?=
 =?utf-8?B?V0JObkMySTI0YlRkT29RQlZDMHNKZGtWYWwxYWxiSkN3dStod1Nhc1FyWHdF?=
 =?utf-8?B?c2lhUkdIcXNjU1FhbjJZajB2NzFYbFYyVVZFUVdTdkJQY2tzb0JSeXZSUW54?=
 =?utf-8?B?WVlGT0k2YTMxd3BWYVZaQm9EejJWVE5KWm5vU2hwVFpzV29IWEFZbSsvUmZr?=
 =?utf-8?B?Y0FzM0oyYUxsdC8zTDJVYUYwWnRxY2EzMDZ6MHl6ODVqN0ZTRC9tUmRzNjhK?=
 =?utf-8?B?WWwvSG92VWl6c1MwZ1FPMEhlOWxiLy9uSzR4ZldqWEkwTS8reHBLNk92Rk44?=
 =?utf-8?B?L0U4MkxWVk84TTdjSFBKMzZZdnZhSU1hcklQOS9oYXhGU1JzWTllTFdhRyt5?=
 =?utf-8?B?TUYxMHZYdzY2ZUo3TnBNdkYrUmVYeVY4K0RkUEZYMURHTGU0aEdCNlJJNEZy?=
 =?utf-8?B?TWcrc3NTNUd6cjl3VU1LNWxya3hPU01Pd0JZdHJTZlEyazFWZ2FraW1tMEh1?=
 =?utf-8?B?Y2ExQVhSZzJYdE96dUJRUERzeHQ4eTgrMTg1eE5MZ1Bsam53NUVlQlVXYVhO?=
 =?utf-8?B?a0lUa09LQ2Zjelg4QzJMeE55ZHc0ZnJtOUZTdHJXVkdocGh5cDFscXFNWjdh?=
 =?utf-8?B?Z0F3QXQ0bmpWb1NiVnNuWkw0SEZOZDZBdDZ1dGVqVU9yUkJBK1EvbFpZOWUz?=
 =?utf-8?B?c05vaEwzN1VZTVBaVUtBd0xySy9JTEZpeFZPNkN5ZEFRR20vbDBpYXVGbTFq?=
 =?utf-8?B?REZzbVBUWW5HcUpyVTRrOVdML1JqRE1paCtFdnVpZEJpUXRnZ0R6blBVWnRn?=
 =?utf-8?B?ZFM1YjdiQlVDS2hFS1FqR0ZZcnhmNkN6NWt5VWorb2FkcXlqbDFETXhYQmV3?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2336bb-2984-46a5-0e05-08dd081d66c9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 22:07:32.9202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etJbY0b8472CCnIuSqmhrjChIvu3Bx+nXX/xMKe1I8mgJJZ9SYTS0thYqHIzJhM8ZK4fJfyBRrGurLJdDe/CDa1hSbs8e6inWScKupUIlws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-OriginatorOrg: intel.com

Hi Babu,

On 11/18/24 11:04 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/15/24 18:00, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>> Introduce the interface file "mbm_assign_mode" to list monitor modes
>>> supported.
>>>
>>> The "mbm_cntr_assign" mode provides the option to assign a counter to
>>> an RMID, event pair and monitor the bandwidth as long as it is assigned.
>>>
>>> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
>>> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
>>>
>>> The "default" mode is the existing monitoring mode that works without the
>>> explicit counter assignment, instead relying on dynamic counter assignment
>>> by hardware that may result in hardware not dedicating a counter resulting
>>> in monitoring data reads returning "Unavailable".
>>>
>>> Provide an interface to display the monitor mode on the system.
>>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>> [mbm_cntr_assign]
>>> default
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---

...

>> I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
>> to make the event data "more predictable" and then be concerned when the mode does
>> not exist.
>>
>> As an alternative, is it possible to know the number of hardware counters on AMD systems
>> without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
>> users to know if their platform may be impacted by this type of "unpredictability" (by comparing 
>> num_mbm_cntrs to num_rmids).
> 
> There is some round about(or hacky) way to find that out number of RMIDs
> that can be active.

Does this give consistent and accurate data? Is this something that can be added to resctrl?
(Reading your other message [1] it does not sound as though it can produce an accurate
number on boot.)
If not then it will be up to the documentation to be accurate.


>>> +
>>> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
>>> +	enable this mode by default so that counters remain assigned even when the
>>> +	corresponding RMID is not in use by any processor.
>>> +
>>> +	"default":
>>> +
>>> +	In default mode resctrl assumes there is a hardware counter for each
>>> +	event within every CTRL_MON and MON group. Reading mbm_total_bytes or
>>> +	mbm_local_bytes may report 'Unavailable' if there is no counter associated
>>> +	with that event.
>>
>> If I understand correctly, on AMD platforms without ABMC the events only report
>> "Unavailable" if there is no counter assigned at the time of the query. If a counter
>> is unassigned and then reassigned then the event count will reset and the user
>> will get some data back but it may thus be unpredictable (to match earlier language).
>> Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
>> "unpredictable" event counts (not just "Unavailable") ... this gets complicated
> 
> Yes. All the AMD systems without ABMC are affected by this problem.
> 
>> because users should be steered to avoid "default" mode if mbm_assign_mode is
>> available, while not be made concerned to use "default" mode on Intel where
>> mbm_assign_mode is not available.
> 
> Can we add text to clarify this?

Please do.

Reinette

[1] https://lore.kernel.org/all/35fc70fd-0281-4ac8-b32b-efa2f4516901@amd.com/

