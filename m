Return-Path: <linux-kernel+bounces-522949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC83A3D077
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A989188593F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76991DFDA5;
	Thu, 20 Feb 2025 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYkemApc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4BB286291
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025597; cv=fail; b=MiAdvW6983yHVoU8TjSnN59+B4juJrKiI32yEH+9IpU3xEdBSgnOxE85F6FCfFkFcphMopKbz3k3CBWT4atPjQK28pnOza6WnQxWAX8CY+5xjCGIEDscSZzk+EA6dOrwGpStYLDchTk7AHa079qgNhp5pLQTT/iYVlG5P4ZQEg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025597; c=relaxed/simple;
	bh=eCA/Fs7hVYrAIbbgBMICybmtZ8Ml5ZuGmJt0EnLGfL8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D06+uZnJL5XXLdobIKdOBj6a8NxdJjXqnWA1cD6M1q7jKvOc64S6oCNR7aPgnyl+z2uXSNH7VMAWe1KoCZxXvmzt9zK6zXYVGKaGk+UDmqGHkh9XdtJ1oSIIVk0j7wfpHoYUifFR/zvYtxDUxRxsPKI2kLIc1ZPX/2Mh7hvtDYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYkemApc; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740025596; x=1771561596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eCA/Fs7hVYrAIbbgBMICybmtZ8Ml5ZuGmJt0EnLGfL8=;
  b=DYkemApcxLrHphzTiwMVUNptKwGXkXQZTIJ5hhzknoPets/0zJ550GeX
   I/DM/m4jRcSv+SnqQ/1nfn38/KoPXlaJ787R6PfxGEMSCvXhFeuWQFKDx
   tblqtX5AxNXe+sGm413DQa9N41qdVua/6Z2jRWtZDrRXmyrTbyi8+eynr
   zZMr3LzZYD6BP6XqFcI+SNzTjs1MbBmRDARqwznQOJSawr8I99wqeiy7J
   DM4NXGEu31cdgNTuzcrDPm21STdqxSIMatrsylPeylfzFPUOWRbeA8564
   glGbKq5VOQweWiMi4MLUjr/K+6reUyfEg8T1o/yah+1pvY1llUZTNI/7+
   w==;
X-CSE-ConnectionGUID: Clud3GjNRPq/kMEEDFHlhg==
X-CSE-MsgGUID: GRn2e1DqTK22h3TjT0Ek5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44708109"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="44708109"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:26:35 -0800
X-CSE-ConnectionGUID: nZtrJ8pkQNCz5yPzA0/opw==
X-CSE-MsgGUID: GkhobpE9R1WJTwtT0cYjvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115120095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 20:26:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 20:26:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:26:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:26:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZa7D7OQLp7gx2tzwmkYZMHUelbhOzg6Wbc6f4r4KyxSbjuIalMOI3T05HmP9hUJfbJoIYhORkD+ayRH6RCSBrP8/8PxihQVSEh2onub3CcDiO8dz/0pPwSU6JFDjdNpGYlKSHF3yv0SidBnXYHGOS3qEmR2wlyzKn8U8w4WJS4rrF12IyUIbzasJvI/i74AYJkob5aIZeSXwvwP1I/n7aaoDV8XeUGHW9XsWZNGUr08Q96HKVIwER/JJHInI6rS6DkPwG8tf/NVyQBgU5lGklPk9705YuSGVWnQDjf6gaUWEAzgVBUi90sFk98cRYe9FFh151xSfrYQOhMByNqzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn2kFShGZ3J8tVBA1/XCdJcRQqpqID1CMjvxgG3Isuc=;
 b=xbopT23BaUsE5uuvoXb4S6LozDZsvCCakql3aZ6+MIUjcAV4unwU6kuM3XXGK1L9UfZhm38g3/7OfTADboDq2tFdbQSkZbuSDllGzqGS7/w9oPZAd3s25LaV1nwLcinO2jH6C4Z2kLyOD4TEToPsCV4aoldVT2nOIoXpPRW5ovPrs0HZ0q2uxDoL12et34kL12GTiVC8gto2CggMVXUoFbXkdp2ctSFY+clHlRLiqCgtw57LbFJoE4IqcAZXZ/dRxPO2vUyxyamQRcxKW1f6Pm8CtezfXl4AjcMgk4UiH6+xshAzBevURwOAkwhBdWStJbhWmNDj+Qq71eSbUVn4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 04:26:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:26:28 +0000
Message-ID: <2864951d-df68-4a2c-9793-695e26a1903f@intel.com>
Date: Wed, 19 Feb 2025 20:26:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 32/42] x86/resctrl: Rename resctrl_sched_in() to begin
 with "resctrl_arch_"
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
 <20250207181823.6378-33-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-33-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: c24ecb0e-ea12-40fb-6d60-08dd5166bebb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUJOSnZtOTVoeXpFZTFHYWtCOFpLdDRkQnNQZ3IwZ1F6elR4cE96TnczNGdV?=
 =?utf-8?B?cHZraFdXK1dqY1MrdGtDZlR0enYwWTErMmlRSjRXNVMxQjJaZ1ZxdXRXNmxH?=
 =?utf-8?B?NmZHNXA1eTZOVVkyVHM4dGpZTjNtaHJIZkpqd3B4aU1lb0xYODliVHlZMkxL?=
 =?utf-8?B?OGVpSWgxb09jKy9CNzBwRzBHSCt0WGdYN1dpWExpb3dtSFlTWU1oNHFjVGVC?=
 =?utf-8?B?emduY3ZHWEVNRzk1eTkweTRBVVQzbFNkenlJb0JDYmsyQVYwNm9IL1NRVVhw?=
 =?utf-8?B?eVpnTHJ0NFZyTzFnalNnWkZRREdZYTZxdllBYXYreWt0b3RXOXg1Z1ZEM3Fw?=
 =?utf-8?B?OFFPTzd2VW1KV25ic01wMjN4amlHYUw5M29OSWdLcWZCU1pJY1ZaTmdSYVox?=
 =?utf-8?B?Yy91bklCeERGTTZ0Uml5L05aSXpreWJFV09UNExhT3I1MG1pb0NmUWJybXB2?=
 =?utf-8?B?cC9zVzZNZzhzSTlDWDdEM1hOV01mNnJ2N0Q0bFpBREl3YXRHRXpUQ3IxcWhO?=
 =?utf-8?B?OGltdXUvSlIwWFdZNzhKV2IxaDcrOWdxeVRCR0loOVluaHJQSXNmK2I2bHl6?=
 =?utf-8?B?c3puYi9zeVlGMCtpMUtkQUhleXNKWTFRaEFmUnpPUGV3SStxYjdtRmVpdXNR?=
 =?utf-8?B?djlyNnBnYTZ2aXJuYjVraTZkTlFGNmxUVTEwaXlWMWRUM1lJWDRuQ0hYQ1oz?=
 =?utf-8?B?WnpPNGZiSFg1Yy85OFRZS3NTUFZEeEF1VVljNjNQclk0OTdsSEx1VisrN1E2?=
 =?utf-8?B?TDR6RFY2TjE0Vk51VCtGZlNqd2E3QjAxNWU1WnIrdXVnb0hXQXVYWnpKSDFT?=
 =?utf-8?B?QkdrdzVFeVVhdkhQZzllT3c4eXlDQ3VWT2ZubXk5MUxnak4rR0FOUk5uaXo4?=
 =?utf-8?B?eXZQZmhWL00rN3RYbXl6TXFwb1UwWDdrS1VETThPWDFLZ004UFc1QmNJN25r?=
 =?utf-8?B?OFhaUnNxWDN4cmNmQTBQQitITWxtQmN5OHlBaEpIdWx2OXFEdExkQXdWS3pF?=
 =?utf-8?B?c05acDc5RWJQZndSMHZBT0xJQXozMTMyVEZvVlk2L1IreFNyaldZWXA3ZzVm?=
 =?utf-8?B?dUhDdyt0QVlQdDh1NU5FSXRHL1pLYkZkSkJ3MStKRFNJWTFBT0ZDRFBDOXAr?=
 =?utf-8?B?Q2pIS0NkZ3FBcWZtdkcxcDZaelpkNUxON0RBUW5QQWQ3L21kN2VnVnlKdHls?=
 =?utf-8?B?ZGxYWjRVeWxVNlFOaERzQmI3UXc1OUxwZFNWaGpOT2oyOThMYU5ZaDhNdHlo?=
 =?utf-8?B?VGRvYzE3VXpLdWR6bDdkd1JmQytWMVV1dzlKMVpQNTR3UXlOYjBjNWlLY2p6?=
 =?utf-8?B?K0hPKzJIUUxGbWhtSVdzOU9WZ3lWam5QUzVYU0tLNlJyL1Q2U1hyaG5NWlp5?=
 =?utf-8?B?ZmFpbVlrMzVueVprL24rbmpwVksyZ3A4Wm9GQzVCNVlqU1RjdDMyKy9EdGMy?=
 =?utf-8?B?NG9zMEhZd2RuRUxtbjNwdUJma0FlVVNvYjRNMXV4U2ZKcFdSVWJ0SExFKzl3?=
 =?utf-8?B?VEIweFJHYW1NUTVCLzlHUjU0VjMrZy9QMGVJcWk5Mll4WjJUMDBablJrampY?=
 =?utf-8?B?UHFhTWtZVkVHd2VNZ0p6ZnRXelhVVi9KWmlqK2FVTzl2K0hEbytoSlpBRU45?=
 =?utf-8?B?MkRoMzc0VjR1VEVRWDltajU5bC8rWkZYRDZVczdiVEI4L2VYOGRuOXN0Ulo3?=
 =?utf-8?B?N2t2MUhOKzk2UmxocVByNm5pMVlHYmVXakQzbko1UnN5MkYzREhuQWRISHZz?=
 =?utf-8?B?K0ZPTW53RmI3N1JBb1JLVmNwRlMvVWtMT1hveEl1SEVKaWJjRkhGWWZKNUU2?=
 =?utf-8?B?elRzTGE1ejJ3TExpeUxsNURnNE92OWVRQnJZak9OcEFCUzdtcVBsd3BDaWdX?=
 =?utf-8?Q?rqX/4zKxMYrz8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3A2VE9aYVA5ZVRtakRyN3YwdVRMUmtGbWk3SnpXLy9BSVhlV0JMdW5zbHVE?=
 =?utf-8?B?bzJHYXV4TzNkaVg1UHUxTDNMVkdMZzE4amFTTWduc2toc2hUUlQxcVV1YnpN?=
 =?utf-8?B?dkFnbTJndDJjSkZpeDY5WkRnRndXWW1KNkhzbTVXVjdUdzY1Nng3K0VhVVl1?=
 =?utf-8?B?QzE4MjFDOSszNDJ1ZkVpb2dIRE5OckZ5aGNCTmRLeUx4a014aGZXRXpWa0Jx?=
 =?utf-8?B?ZWFsbXE4T0RBOS9WTklZQi9DOUE4MVlyUDgwa1c3dVJKdERyMksyRWpsL2dr?=
 =?utf-8?B?TEkyUHNNWDFlWFF0dXhFNVJMeHNDekVFallkZmNYZjlPTjhHWkJkYmQ2L0Fo?=
 =?utf-8?B?MytxRUpiazJoamNsN2x3dEpFcGxHMm1vV1JnUlZ2MUlXbGlrZTBHcVZxVGYx?=
 =?utf-8?B?K0d1RU5LcFhkMGVsQVRoS0R6UCt6Q29VN2VaUzRYcHBnOWM2dnY0WkgwVHpQ?=
 =?utf-8?B?T0JrYnNERHJnOTI5SXlxYXAzY3pZam5paVJMUi9yYUw4bDlvSDVaWVJkdlFX?=
 =?utf-8?B?dm9ud1Jjd2RqYjhKOFBLTTE4dk1qaS8ydG01aE1zV3ZLZ0o3ZExUWkxuRGRS?=
 =?utf-8?B?Zk1hY3R6MzM2REMwYXRnOTJtM1Y1NWVjTS9ySTYxOE1md1NFYkdDbTVHbUlG?=
 =?utf-8?B?cmlxNThTemFpWE4wRjAzclJ4Mjd1YlcxSDZXdHp2YU0xVGhlSEZEWDlQT2dp?=
 =?utf-8?B?WTNSaTd0eFl4ZXBIKy8xV1FyUm9QNU9LWmFIVE5GY2M5YzBVaVhhak1xb21C?=
 =?utf-8?B?YjhXWk1ORFhDR0hwU2ZRTjE0djNQZ3Q3WGNuN2NjeEVEUU5MVzQrYW5rU3Mv?=
 =?utf-8?B?Y1lDQ0FYaUFSWS85cDVCTmt0cHdLZjQxZXdLd2p2T09TTkN6WE9mL3Q1WHFX?=
 =?utf-8?B?b3ZzeDFuNGZSa1BZSEIxVE5oSk5rUXBLWlFteGhaRitGUCsxY2tiTnA0OW90?=
 =?utf-8?B?aXJFa0drQ2xBeVpGTFNqeUpyQ2VTZkgyaS9ZVy9NV0pMTDRZb21XZVZEc1pu?=
 =?utf-8?B?eFVlWFBLbDd6dHMwT05aMi9IQm02bmVQVlcrbTNsdmdOY0lacFBxVDFFdVJR?=
 =?utf-8?B?OGRjdU1VWDBSSnB3ZVRDemxZY21YaXdlSnlkYnZvekU3SEpwQ0hnMDcraEV1?=
 =?utf-8?B?WS9DZzZ5OUYwNWVBdnBRQUNjUWdzZFpZSDllVWFWSS96WW1VMm5DaEIvSTdn?=
 =?utf-8?B?MGo5MTV3NFB6UkptY05GdGNWdllMSEk2QnNkN0tGT0gxTllLWkxhZDZ2b2Np?=
 =?utf-8?B?WUdCaFQ4S2dCT0pZMHhvREVvOTV4RVdYVkJPS3V0L3J6OHVweG5EbXlhK3FM?=
 =?utf-8?B?ZUJUc00wVlB1aXJJSDR5cnFYbGJsbi9ueTVBSDhHa3cxa3NNMVh4T0FOUVV2?=
 =?utf-8?B?SVl5SURwRDlINjN4NGZKTHB3Y0l5ZVN1QTBodnFPOW51bENsczVzaEtNaDhk?=
 =?utf-8?B?Y0pQRkk4empUdTVLUUM4YktLdmJ5SEZqcWp6cGZkWWZjM09SZWtZVDNlbkJT?=
 =?utf-8?B?bXNlejhvWC9RR0w0cWdJL0NjZmFkQWZRSE5wM0ZpQy9xRTRqNkNHRTNDNk0x?=
 =?utf-8?B?TStmcTlzUlNEQ2l3L2YrdXlXSysxOHJHRi9mSEx5aTc5WEl2UGFoSWJBVS9s?=
 =?utf-8?B?Q3IrakJ6MERsZFgrMkpkajZNT0t6ZFN2SUNXc3NjanZkQm5qRWlVM0c2bVY3?=
 =?utf-8?B?bWZGV3V4RHQ5eHErR05vakk0YXhiV2Z5S0tla2ZFaFpmUXRMRVFZdmt6ZDk0?=
 =?utf-8?B?czUrTVB5T01OWUprNW5tOGpvZHdRdDRhWnZqb3ZLZXpvUXFLazMrek1NZC9J?=
 =?utf-8?B?bmdhcjFXUjd3SkE5ZjlKcUpqcVBZN29LTTNYZ0phR2xmZ3QrRS9WRGltS3c1?=
 =?utf-8?B?Mkcxc2R4aHFXdTJ2dnNuR2lINWszeEVlK2NCZmlDZ3JlUlNGMFZjc3d3RTlL?=
 =?utf-8?B?Q0gweFplNTA3ZDZUOS9jT3dYUmJjVGFvWTQxT21lcGduMTFPYVhJRDUrV3pX?=
 =?utf-8?B?MWJ1UzU3ZmgyRkhWd1dZRHE4MkFwRWZ5UXBJZFJyZWJzdFpEVnVYZzJrcTN0?=
 =?utf-8?B?WWVadWx5dCtSMitBWmlIY1J1WllOQW5hM0RqMWF5cVI4NHpyQWQzbVpwYjBD?=
 =?utf-8?B?a0xyaGhxbktjbUdNanh3aWlabjVDRGdTNFJnNXd3UVcwYjByUGZGaHRLRklD?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ecb0e-ea12-40fb-6d60-08dd5166bebb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:26:28.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/NEMtrpew5qygj6DP6wWsAs6VXM+5WcoZdm0TQoeDCJhotsgHBNYwsgWRgjN6Z8wW5BPYEThMAs3BgHnxDV5dS0/2c0TQW8xRLRgYnD7DI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> resctrl_sched_in() loads the architecture specific CPU MSRs with the
> CLOSID and RMID values. This function was named before resctrl was
> split to have architecture specific code, and generic filesystem code.
> 
> This function is obviously architecture specific, but does not begin
> with 'resctrl_arch_', making it the odd one out in the functions an
> architecture needs to support to enable resctrl.
> 
> Rename it for consistency. This is purely cosmetic.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


