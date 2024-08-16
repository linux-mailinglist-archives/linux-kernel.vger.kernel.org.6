Return-Path: <linux-kernel+bounces-290102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75582954F70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A16E1C20FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEB1BF33D;
	Fri, 16 Aug 2024 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxniWOFc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9A558A5;
	Fri, 16 Aug 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723827698; cv=fail; b=UdQc7+ferGMSWQd2HZkwVhnwAFQQILxM+GbCxbgefvc3tAnal4pExa2isTwjUMcpyBsjOecj+kwrppg/wK0BQZdtknG/uXEVrj2kT33cjMz3fHdNSVhiAS621nSkNK1ozD2P2zeDbPUnFA6tg+P9VN711XyguevVZdKTGC0Ojxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723827698; c=relaxed/simple;
	bh=I3eqPPXqquZXfWF8FArUmdsCDDk0hsvTSgLpOUAxwH8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3K4o3vgI6oTDKvJIg331V2QR3OAVONZTjr+YShCWnpoNpLsUAiRjTfNvEZfcwx6cq2UTixEg7UXg7BBJBPUUVslHjvU0JJRj0HYw095wY81lkzOcnFEfma5HlT0w9HqXWgXiAY4FloNAUEJd4Mh046/j1hkjvR6H76dQ+fgPwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxniWOFc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723827698; x=1755363698;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I3eqPPXqquZXfWF8FArUmdsCDDk0hsvTSgLpOUAxwH8=;
  b=UxniWOFchWO06EJjrPk7Z813tEr4ifYVGMY1Fc6Rn1bbROvtbH+3EFgK
   h0wmD0O4W97TgY7o42knybXUlZI5NI8B/+vxePDS8kZgtvLXbfwhA0UGv
   lvCdrU895ayWOKsSvZSbt5dSIO0SsJFI5BphNa0KHHQIdfQ30pF+TTvNO
   kkS408F0fTsIrVCskybU2NZLXYzaARcndXTXSRfFPETizBeilvsTD/GCO
   JVNhqyPKuNHi5SxzABNmMWfT08tUd6zoWbMvzE8AvOV6M3vPRNmDAWSc3
   fo6KOAp2qZN6JOYOa4MTtuPZunx4uCRJ8slvJWJLpJh7m8cYOR4zNLo59
   Q==;
X-CSE-ConnectionGUID: NgvelMnUSQuQQm/GQtHnkg==
X-CSE-MsgGUID: Ak+k/mflS6Gs+J6jbLn3iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25887663"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="25887663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 10:01:37 -0700
X-CSE-ConnectionGUID: qigkTmDrSva31ZBCZw20dw==
X-CSE-MsgGUID: EqqUv/snQRiv8n961jXF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59358865"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 10:01:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 10:01:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 10:01:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 10:01:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 10:01:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp9icH2drIi2bi8YBcMpm7nsKL6OUZKp6+W25uvyzKte/1AG2ttjdgbzXBRSv5S3wHdLrOTsbk7MiRPJZ4jVQNcygVusrwu1vmZTR3RZm2WCeSSWrU71Vl9YJkFg7Qr5o5qKwVqkeW0vCfD5s45Eiyei5bHzbXa8PbhV+KBryXkP897g+i43cOZhm5/1c0ZVVN1BYoCWZDmmN9db2dg9GZiMalF9R1Z1lDeCz7Wp/9YPZxxs2aUa2iH2QZu5+7VV9BTcmDzXUTHvX5L26sMt6/eMfuKyJwXVf2quBaMm05Wxt1Cj7vBzgJ+kWzp1XINM9BwewdvRhxPddATLpjjxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxqMFEoDUQ8CvzA0VfD3KQQCNOi5Pv/pcMptr2jcnHg=;
 b=iHWbsK3J+a3FEuNgjvko+zC6ma0nmPBZbtVLBO4db3nisIvw1rCIGz5Srv2i41bx1gcjNKmeKhvXPh34qKQKSc+JXmh+Dj32lnIQ9CDf9loYntjY2JqMPn7FoueESRMtMHG9JL0LX30SdOYu+dC/CHPCAuxdqBkvTF71BOV7GtXPf2paj5RUX3bmRP7bd57/Jj5afOd9wOulGtqJpuekxzfNK2wklDQwHQT6yI1A5o0tATv840H0qdkkSYUPEV2uwzNLrBuUN4f+dtAUG8PG/TBiyGGSE1aZDH61HZqC216gu2J1VAKn/8aHuqpo9B9bvAsICsBeOgKbMZwABK0emA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8473.namprd11.prod.outlook.com (2603:10b6:806:3a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 17:01:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 17:01:32 +0000
Message-ID: <8c93c091-39b3-4219-b892-9df2747eb91a@intel.com>
Date: Fri, 16 Aug 2024 10:01:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
To: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <mingo@redhat.com>, <bp@alien8.de>, <corbet@lwn.net>,
	<dave.hansen@linux.intel.com>, <fenghua.yu@intel.com>, <tglx@linutronix.de>
References: <cover.1722981659.git.babu.moger@amd.com>
 <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
 <983fded5-48f8-439d-8afe-45b60841985a@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <983fded5-48f8-439d-8afe-45b60841985a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: a511c999-0692-46ae-be88-08dcbe1513f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDJCVVFDOU5aTEtOUWN4a3VwOUtnVFk4eDRoMVArRWxQaXN1ejVhK2R0eFJh?=
 =?utf-8?B?aTZrbHBpSXZObHNudkFINVZBaUZPQnNVZ0s2NFhhbzFxS01mMmFJaXpkQVRZ?=
 =?utf-8?B?ZUI1MmRpSVN0eitlSGZDQnMrdlFEd1R4ajZNbTkyS3QyajZiOWEzZXFidldl?=
 =?utf-8?B?em82dDNod2wzY3l4aTA5N1lWRWJkaGVUa2dXOGFvOHRlaEYwdk9XbU4wZXNm?=
 =?utf-8?B?Mk5abjVRTi8vY1pKb3cyUTdTQ0R1T0xmakR2SlRYaERwRmxMMGhsb1gxam9E?=
 =?utf-8?B?TTdwNUY4YjJ4SlMxNjhNUEFlYTNoWlNEOUd1NUdRTklKVjhIWkczUE5Yamh2?=
 =?utf-8?B?R1BFYVpoTmNaU3FCSkNnVDZuSlNma2Z1RmV6RjJxY2VKNWo5QVpMUWZmQlF6?=
 =?utf-8?B?RG9OVFhvMm1heU1QOUdKZ1NBRHpWd2RmaitCbGhFK0VBWmdHTVZZUVBWMmUx?=
 =?utf-8?B?YUwzUS9ldnBNWEpjcW8yUVkvM0ZvY0FxbUR1c2FsL2k3Q0lMN3dYMmxjWHEy?=
 =?utf-8?B?VkthTUFYb0dhYXlsVlVrZWQvakEvK093L2trR3VZR003OVp6aEtPUE9HUkVk?=
 =?utf-8?B?NUptQk8rWDVnL0tnU3k2ZThwYUpHdlZOSG1PWTF5bU1TeHhUVzR6eG5LQ1ox?=
 =?utf-8?B?VS9jenVISVY1Q3F3U3RyVmw5VE5YeS84OVlZdjRac3ZDRnptQUlWMGpnSjZ3?=
 =?utf-8?B?RTJBcFR3aGZJbExFcFA3UlJwNzkwMXdpSFFxOHZObzJNUFFQQ3ZSWlZTUzMz?=
 =?utf-8?B?NmlQTDFUbWZBS01ON1ZYeXhsdDNaRkRYMm0vZ0UvSzZUUTVZK3JGQ0EwZ1Jw?=
 =?utf-8?B?bUdSNDM1UzVTSzUrRU0zMDhSTTdIWlVvemxGbjNpZGUvbkNBMnZnbGRuWEEw?=
 =?utf-8?B?SkZJQzVGUllxMXpGbGxEMGF6dVdiZjlZdnVCOWhzUE13S1ZaNElSSmRtTTJ3?=
 =?utf-8?B?MVpuamdha1QxZ0YyMkhPaEdUbm5xZmZxN3A2bnFPSEcvUTF5cTlVQ05DT0hn?=
 =?utf-8?B?Ukc1TkJFTTJHdERoQTJGRk1NS3FYSTRFNDZFQis0MUNXUGhEdWhnWFE5WmFI?=
 =?utf-8?B?ZjZXaVVFT0QvRkpkZnd2cW1aa0V3RGk4ZVpPVWhpakpEWHhTSTVsRGN5b1gv?=
 =?utf-8?B?OFZLdEdjTHNLTXlLMkJmdEJzeEVGQmFKRWh0RGVlaHhOcGxjdjFRQ1FTUHUy?=
 =?utf-8?B?ZXNYY1c2U2VTeG96QkorZnpaS28wMEhoU2tDZTZzNVJMay90Mmk0MWNpbktB?=
 =?utf-8?B?Y0Y4SEdKd3E5U1VWU3R4SGdrTUJWazhQNjRaRTJLck8yU20vMGdSaVRBbDJI?=
 =?utf-8?B?YnhPL0VhbkwrWkxybHA3dGZxWC96QTNHOCtVTzZLR1lPQU1mSkhDeHEybC9j?=
 =?utf-8?B?YXRMWk52OVhhcjlMdXBaMmoyMFRYTHpGL1RUeUJ0TkF0eWxzY1MralZrV3JW?=
 =?utf-8?B?c3VRYmQvcE9LY0JZbGQzWStvcFhsWlJyNU51cUZaL3JORHpCTzR6SEFwdDNC?=
 =?utf-8?B?eXRIVVYvTEtrOHNuK1k0bUJzalJLUW55ZUhCOGFDclJrSXBqcTlXazNFdEEx?=
 =?utf-8?B?T0FGWExVRG9palVHVTlLWm85U0NIMURZTFZyVHpaTldxN1Z5U2k4emJraFp6?=
 =?utf-8?B?ZmJDeHUvTG9MUmI0R3ExN2U3SXJRaXVzWC84OXRqalRPMzhJVHZzb2p5Uy9i?=
 =?utf-8?B?SSttUGxjczZYWTZHVjd5dUVNMkJLdzFQUXFxOVlHVXV1YnhYQjNiOGVqRlVn?=
 =?utf-8?B?ZSsvRFNuYnRUUHNxSTMzK2RpeitJSEJMZEtmNXNZQllLNWNaWlR6Y1BxOVU4?=
 =?utf-8?B?Tys2eVcwcE1Dc1RvRldyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVpSVU1qTTczUXMwUzR2Uysyc0VYcWtXSCtnY0piQ1Fva2lJb2k0SmtnSXBK?=
 =?utf-8?B?cllDV3ByNXdhbWdHLzM5R0swNmxnbjA3WWlUS1lVWXM3cDFyZlFxaFJoaC9S?=
 =?utf-8?B?aHQraFkyUlkrN1QvVG1ZWWs0RENzYUxZR1FsaS9JWlh5a0VLK1hZMTRtZ3Vz?=
 =?utf-8?B?UVFhRjdmN05meXpmaEppTFhGbUNzQXlGcGVHR21zN1J0Q2JpWDZUWkZpYTRu?=
 =?utf-8?B?VnlHQ2JRQ0Z0VFJ1ZnVEWExScnRYNU9wMVZ1a091SFhmZjliZXFKUXY1VjJQ?=
 =?utf-8?B?WXhVSHZYMDZHdGp4cWZTVldRNDluR0FBbWkvbE9uUVl4L2NYVzVmTkZzOEdN?=
 =?utf-8?B?dS9JelBQSzdNSUUrc21lMXY5SUthbGdhUkNjdzNHODIrVGNmbUhoSGZJYmtm?=
 =?utf-8?B?L3RTWmhBNm1IK3g3di9rTnlEZVk5MnRieDZSZHk5akZKME1Ram1QaXk2djFs?=
 =?utf-8?B?M3ZZTUdnMjl0SUxzV1F1b3Q3alRURXhkMnVDeUozcitrdTQzTDQzVEhCWHFE?=
 =?utf-8?B?eHdZZWNPNDI0d2F4ayszaHlFam1NcHhpcWZDMXNzc0E5TUxRS3M1RmRkVHg4?=
 =?utf-8?B?VHR3M2E1MGNlcXFSRVhsNzd6aTFia1BuZENpRS9seHM3QlFUU2VwZVFDeUQ2?=
 =?utf-8?B?NUduUWRQczJncFRaeXJTU0hIU3VJbjNwWFRCQTI1WkdDVlJoZEk0eCtlT0t2?=
 =?utf-8?B?bnNDcXJWM0xXTnVjMDBDcnZTeXVPNzBkcU4yOXF0STdpK0phM2tlZUFOTzRv?=
 =?utf-8?B?YWMzWFgrWUMvalppYzFJQ3NKYW1DYlFqaG0yV0JKZkdjM0N5VlIyNGh5L0ZB?=
 =?utf-8?B?b3RxaVo5M2NTNC9sK2plSDh4UWFjYVRsWXhEVVRJeGU4TjNoL0JkVFZTejlL?=
 =?utf-8?B?UmZnZEIxU2dVNDA4ck5XWVFFRXo0dWpYM3cycWFaSWJMVTdVU043V0pJSDh3?=
 =?utf-8?B?a2RSMDZzd2F3TmtLUDF5TmF3MmNyUk1wKzlLbkJSRC9Xajlta2RoYVJSeVcx?=
 =?utf-8?B?SENLMTUrNEV4YWdsekljUERYVHQ3TGVRRDRmUGlmT1pKaXduVW1MY1d5RWNE?=
 =?utf-8?B?UEtVQjY3OWhjVXVuczdWZzVhOS85NEdaNFNIUGlTZFN6SmhTR093L2VNWW9x?=
 =?utf-8?B?ZDBUN0hjUmRyemQyL2FoRE4rUTZKb3pDekFZdEZsdGpuUy8zaGZkOEZpNTgy?=
 =?utf-8?B?R0lBd1p2ZTVhTzZxdm5PSU0ycEJBNlB4MGphY3pJNkdnUS92MlpmdDNFd3Zn?=
 =?utf-8?B?cFdiVlF6a0hEeUNlZDFOZ1RzMmo3TzFyV1o4V2thZ3ZQV0xQVzBjcU1VM24v?=
 =?utf-8?B?anJnbVVnaThQRG1OMWlISVl2ekdzTFVPMFp6ellBdTNWTGk0K2R2TTVNZUQy?=
 =?utf-8?B?RytsT0tpSUZXNnEwcGhjZlJCK0kzTkt1aHNGaVJTSDJDTzV3Tk1RSEtldWRp?=
 =?utf-8?B?V2JyQTRVdWVQUm53RDU1SVJXcEtwQlNFNExLV1ZxcE1SVHdRcGRRWmp3UnRq?=
 =?utf-8?B?QUZabHZmSWZVZnVZUzFUOW81Y2VGYzlCTytxTVVXNU8ySFppVnUrNE1pOVh6?=
 =?utf-8?B?MkQvQkY5bWJNREhhZ0NvYllENGxOWmJxOEtWTkdIaG1ZcWNlUTFQL2FITjVM?=
 =?utf-8?B?aysyUkg4cUp2a2ROdW51ZysxZjJuaUdPV0NGeWtLTlNNRkxpdy9QN2IyR0pJ?=
 =?utf-8?B?bmI3MWtLTi9rbTdUaGFndjV6clZMWGt0RmRabmw1TFExc3o0WllJdzUwQ3Iy?=
 =?utf-8?B?Z0pkSFBseDV1allvMk5LcUJ1U3g3SWo0R1JzVnUzMDFUZDlIdmJzeTRxa3hL?=
 =?utf-8?B?UHNuR1JXWE11aURXd2lQbXhHM3Z3bWF5WkMxTlB5MHJucEhVSFJseFBZTmdn?=
 =?utf-8?B?aXJQeDZYSU9wMndPL2FlcHNEZ0crUGVNSytHeEVFeHNLRWxFNjFIWE1VcG16?=
 =?utf-8?B?U0VoTVdzMi9HdTcySXYvWmQzbDd6bDgxdU5SWG10VGJXSlhCM0dSZjBqRXp2?=
 =?utf-8?B?NEtYenBrcHlKZTFZbWd3U1V5b0FQMjd6U2hWbDlzYzUyeXdjWmlhZmQvQ2Va?=
 =?utf-8?B?RytNaXc5bzY0MWNBNkNBWU9NQkRGYXkvbjJzUHhHUE1RWG9kb3psSVU4d2M4?=
 =?utf-8?B?bFhTdSsyT2JSNzI5dnp2TXUraWZkeEEwMHprQldWYWpYcVl5azZZcEZ2dEQ3?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a511c999-0692-46ae-be88-08dcbe1513f3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:01:31.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ugtX1foPr9lP54pSGj8ftL3akmNEItetUWTX8gCjECwuvlsu6dkuQDTlmJv8lofYDqFpJ2yHR2tg6qaU+PF/2vPiCIIlDAQ2sqDB5SFVHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8473
X-OriginatorOrg: intel.com

Hi James,

On 8/16/24 9:31 AM, James Morse wrote:
> Hi Babu,
> 
> On 06/08/2024 23:00, Babu Moger wrote:
>> Introduce interface to switch between ABMC and legacy modes.
>>
>> By default ABMC is enabled on boot if the feature is available.
>> Provide the interface to go back to legacy mode if required.
> 
> I may have missed it on an earlier version ... why would anyone want the non-ABMC
> behaviour on hardware that requires it: counters randomly reset and randomly return
> 'Unavailable'... is that actually useful?
> 
> You default this to on, so there isn't a backward compatibility argument here.
> 
> It seems like being able to disable this is a source of complexity - is it needed?

The ability to go back to legacy was added while looking ahead to support the next
"assignable counter" feature that is software based ("soft-RMID" .. "soft-ABMC"?).

This series adds support for ABMC on recent AMD hardware to address the issue described
in cover letter. This issue also exists on earlier AMD hardware that does not have the ABMC
feature and Peter is working on a software solution to address the issue on non-ABMC hardware.
This software solution is expected to have the same interface as the hardware solution but
earlier discussions revealed that it may introduce extra latency that users may only want to
accept during periods of active monitoring. Thus the option to disable the counter assignment
mode.

Your point about users returning to "legacy" mode on ABMC hardware is valid. I do not know
if that is useful. Here I can only speculate since monitoring with ABMC is
more accurate but also requires more user space involvement to assign counters while legacy
mode is less accurate while requiring less user space involvement.

> For MPAM I'm looking at enabling this on any platform that is short of monitors. If
> user-space disables it I don't have a "at random" hardware behaviour to fall back on - its
> extra work to invent a behaviour I'm not sure is useful...

It should not be required for MPAM to have a "legacy" mode. resctrl fs can expose only one
mode that is always enabled. Noting this now is important so that we can get the wording right
in the documentation.

Thanks for chiming in on MPAM's plans for this work.

Reinette

