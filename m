Return-Path: <linux-kernel+bounces-173969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B738C086C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772CD281D43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958951FAA;
	Thu,  9 May 2024 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFhJLMPi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98210F7;
	Thu,  9 May 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214554; cv=fail; b=Kt9oen0e3VoGzU5Z2Be/RvR26Uov9F6vXS7pRwyrbkoxsJrhjxkCEANDtelU8voFy8j/Ja17atG3eoosX6XQ1wgaFOAm4qv4f60SNtkDWykehPT/SK1PlbfrxdlXbRikOlgopvTkyzRCIqHolD6hBVRFdcL9zlNR6I8bRN38cLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214554; c=relaxed/simple;
	bh=+ozUMF/t3J+EB47IRKY39PV+jwEn/FkP87DPAaj4AHQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W99U9OdEjgHxBS+UcLbeNLpaX1EbYcWVwPspPQ9c5xAvJQ8DWkEbLYpsssKiF83zXoHhRylnzDufHF8ho53yLOxQv6eatCv+zJi+ZRZvLLBt5DL5Ooljv33v6XrJxNXaRhvP1rBHbWBpbrwr5/ebSafsCxZo3hTGHlqTOuf/MpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFhJLMPi; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715214551; x=1746750551;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+ozUMF/t3J+EB47IRKY39PV+jwEn/FkP87DPAaj4AHQ=;
  b=fFhJLMPiEbhuUZOzG+awzBe43UC0U1U87vMPbKyijgc4ed115gJdDYv4
   GaaKjyR1lSyuzet/JvjigpRGFZ/U5KA7ty4upgV2y+Kea2DTVb1n5PrAv
   9k+2V7O2gi4gZsjsXO2awuJMUlkToUvSQjO4hEht/JCPB0//+acNaDglm
   o32vPgUhgH1QAnCNxPioRgK2M/YPpFOtVkDasSCXkiWzC7Je3ELfzMB7h
   stmCP04lEzgLCjuQdnrwB5cv3Ec0Qui3Rbmy9rX2s1f5mKyd0lrTQpVHF
   Uaepq7sg6UDOJyQJI1Fkcui/H3WGeKGw4MRrL6H/Si7jOTj21Dr7KsZP9
   Q==;
X-CSE-ConnectionGUID: jnF/kIfcRTycBLK1zwKUgA==
X-CSE-MsgGUID: Yz5f0o7iQ/ustViMBLEyDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11321440"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="11321440"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 17:29:11 -0700
X-CSE-ConnectionGUID: 8gmt8XQjTzmI4on227Sf1g==
X-CSE-MsgGUID: UZIsM1HiRUCuhChAp97S5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="29003734"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 17:29:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 17:29:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 17:29:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 17:29:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 17:29:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmAkWpKNBivhCNweeASQmei/zFpOh4h8cUNlPOV+AXPtQdBdeZG2YC3vtNg3DNJWVDgwRoTyO8XunBkNoUVM/h0Lre00B9MTuvWqVRI3qCmvc8cOKEbJbfS2SHOxY0ZlFRxTSS+bjXAMzekw6r3BhEe2xSxOO1UL4UO8mzvXCLFt0tHnGakATUVulv8KdwTTVc+S8WAx6BKIsD7dBM1qGANavnfBjtm6l7gPjPwWNVjWMYpi3qswUIY21xvBULV5n0Uj+zU0xfogY4VV62CSD4oMcUD1uYoW1xIku1X5iEdPFRJKWwVCZm+rhH+NNArYqbjSDeVbn4PU5NbNIHEdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8zGBtZXcKaMFWKqd2xh8GunVHhvQuYpGRIOnXtohOQ=;
 b=dTwUGqkBMjPzfT3tto4KY995QavujOHDQlEonT5yJjx+WBNHuJOta4rDE1t4l+eWLctXSVQdYRcGEnZ1QH3q/nyZ7bAiKGV1Vj4LPo4g6fXSttOsmFkpNB9VPEuTzY0VsfdKYQ+e1+cHBUxa2VnJk96q0LFtxYRiZJ0XYxuHAf0xYOr8SXEq8CmbFFkV0s0ijrwCpR5ih4Qu3vKXo1OWNgdiqqbVcriNEayGVnSNjzVSgTGOthVr5OsDF47N8bHDzhXO4iAiI3bjGbMkIHXpACAho+oYYerNSsx4YAbzFoBMMhpk89++QMNQRAECWVVAR+zFLuY8sSPztsZhQp6yCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 00:29:07 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%6]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 00:29:07 +0000
Message-ID: <7e589b35-4ff8-43fa-99dd-d3b17f56d3ea@intel.com>
Date: Wed, 8 May 2024 17:29:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>,
	<ashok.raj@intel.com>, <jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
 <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <f82879a5-f3ca-436f-8c4a-96d4c5d90354@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0247.namprd04.prod.outlook.com
 (2603:10b6:303:88::12) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bda192-b1b4-42c6-f5cb-08dc6fbf09d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajVIQmdrOXJLWHBwdDJuTTFUMzF3YmMxTVM2Vk5ZK0tqVTRjUGV1VHUwcnp5?=
 =?utf-8?B?bGhEeTR3d3FqRGhNL1NwdWlOR2JBck5jWGlQdFY3d05LY2htNzJGeUNKZ0Fr?=
 =?utf-8?B?VEU2RWg4MCtnN0JrVzljdDBzVEp0UUovcU1MWGFzUmRRWFRXUGpPM29ZdFpN?=
 =?utf-8?B?KzFhbHFMRGJZZTVoTE5qd2d0aU15Qy9qSDlJUEpXZzFwSTBBNHJJZ2Z2d0oy?=
 =?utf-8?B?NTdUcjI4aFk2c0hkSnZQOXVHOVJ4TndXdTdGTGtUOGtoTWp3eE55WktXMi9j?=
 =?utf-8?B?MHJVVG5oczdtakZFM3JxcWVGcUEwSHY4MEFjakJwUU12RTdQOWJtMjI2NHA5?=
 =?utf-8?B?QS95UHNJQWVXREdKYnUzdGdZS2d3RzVoaDB1Q0kxdDhlYUs3U20yKzdhUk91?=
 =?utf-8?B?UTU4cVQvK01pUGZ0WjhDZGo5aWJyQjVYUlI0R0t0VkFWOXBxMWk1ZG9yTnl6?=
 =?utf-8?B?T2tZSGoxVTdnSHUrNFRSYlBhbFp0bEpxaWdwVUkrS1JlU2MxM3RSWWgvNGZZ?=
 =?utf-8?B?cGJMZWo4eXliN0c1WEJDUHF0SWJCU2RVdE1pUGxNZHJZMXdYeVRyc3c5ZXFC?=
 =?utf-8?B?UHp1aDNSaUxMd0pWVmVab3hHWVVmbjdSY3FCYzJEWm9rT0tLUUdqMXdTVHd2?=
 =?utf-8?B?cmVucEhaWG5DVmdDM1dzU1g5UkdKZnpqbm9nNWJIU05pUDEvWjVFWFNwZzZo?=
 =?utf-8?B?bnFib3g1Y1lKRWZ3bUE2WGVNeG5salFha0p5NG1VcGVnTzJtS0pzMGRiRlp3?=
 =?utf-8?B?dUJWK2FMVU5HZDlSM2dOMU9TZ0NnTUEwZFhWd014d1FzdlhMa1c2QTkwZisz?=
 =?utf-8?B?THdDamhwdFQ4QmFsNElTcGQwd3M0NEliblNySWdIZG1hYlpCRmIrTVhyTVdw?=
 =?utf-8?B?ekU1WTVQZzRBUDhlOUhMdjMveUVhcHR1cVFUaC82Y1pFaURFL0UzU1ZmS3g5?=
 =?utf-8?B?R3FGVHRDdTJJdzlEZTFiRDBtT3ZaY2pJRnM5RTJYenZSVms0VlFMc0VPb3Jq?=
 =?utf-8?B?QW95TVVJdWFweGJWczNCL2Y0RERvTVhnTTcwUFFNNzJrNEtVeDdPT1MwZ3NL?=
 =?utf-8?B?M2RiZkFkUSt6MHRaVDlnUDJuSDhhdEZHcmtTWVJVaDB6a2ZKUVh0eXd5NnNn?=
 =?utf-8?B?VHgwU1VYYlJVakR4UTRzVk1CZTVFS2FmWW80cDhSdnB4QzdaM1RuSVgyeUhU?=
 =?utf-8?B?ZlpsWkZsTnBkMmZhWkdCS2U4Y1JSTExsOUlsbUtSZ3NiKzlaSmZ1cmEyMFhr?=
 =?utf-8?B?Y25ZM2FwejE5YWowZlRpN2E3dUxlYm40UG9CVEpiOU0vRzFmcjhEaGJLaktY?=
 =?utf-8?B?bzVtbm1MNHIwaUtiM0wrcEpqdFgrakQ4emdxMTE4NTVFTGtWUFNZRE1OU0ps?=
 =?utf-8?B?NlZ5cGUvRlZRMjQvUGlLenREK01oVDI1eUJ5ZFVobFpiTWQwTDBCVzZnZUlZ?=
 =?utf-8?B?U1FkZVJLNHd2QkcxSE00UlI0OU1ySHRmQXBHeUVzRzM4NVpMSHBRYTA4QW82?=
 =?utf-8?B?T3hIL0FENmVvVHFhMUQ2NGNPWGVyUzR3VkNMZlQyb1J3bm9mb0kwNktCMFdM?=
 =?utf-8?B?c1p2bHhhVUN4UTc5cHNMZGJLWE5yaHFYYnFIWWFXaUZXNjZqSGo4SGhyQUZT?=
 =?utf-8?B?aGdoRzVYdkJkVDZtSkxlTGJUczdCQ09UeFF1UjBESEhEWVkzWWkxbkhoQTZt?=
 =?utf-8?B?N2ZIc2xRdkVHeXRWeGRlMzRmYnBQNVkwUWVwSXRMUW5lbU5nR2J0MXp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjcxZHRweHVvRXRnd1p3VVVLK3BCcnZiS1NXOHhnTmdROTN4YXVsb3JPdkY5?=
 =?utf-8?B?d25mL1BrM28zM0o1OTg3RHROWHU1dTZwWmJWNnprQWJvVHR6OUdRWVY5RFZr?=
 =?utf-8?B?dWFKVUtjdjFEOWt4bEJCMHQzcEI0ZHlwNGxScEtSRXlrcm1icGtSMWZrOEJu?=
 =?utf-8?B?U0ZaTHBnZFJRdmI0U2o5dWxZalNQTDZ0RnNwWHY5UzI5K1c3V3BYeW0vRm1v?=
 =?utf-8?B?dlBOVXpyeVBhTUx4b2RHS2hpMEx4SnVlU3FrbVlObC8xN2xuTE1uQnJQK3E0?=
 =?utf-8?B?akd2Kzd6dUJxUEQwTStpWXliT3ZYUFRTYXdlakYvcTZUTEw1RjhOQTBFbGtj?=
 =?utf-8?B?aC9BaEFTaVFuQWlVOHVCU0VzWWtKY2ZnWFV1eVlmRW1WQ1dZNS9mcUtHdmND?=
 =?utf-8?B?N3hUQkgyRWw4VHgvSlZNZjlZRnhielhKQisrbXFsR1pSelFROHVDMXoxcFdx?=
 =?utf-8?B?M0hUbnE0elNoZ2gyV0NuSVJsVHZiRlBGSHFWcXhieGtsYm5iZ3ZXdWdxb3NT?=
 =?utf-8?B?Q0RoaVBnZkZ1d1Q0VE4rOEYrQjRvUjl4b0xGS3pmbUQ4cUJtTFhQRXlJSlFm?=
 =?utf-8?B?aXQ5N2ZyQ2ZZQ3RVcWs2aHZYOWgwS0ZrZTRHMlZqaW4zUFQvWldJSEdwSi8r?=
 =?utf-8?B?S3dpMUl3REdlR0liTzNTMzFCWi9OTHBMR2V2L25JbEI5YjRVdXcwUmpyZklX?=
 =?utf-8?B?N3doS3U3Sndhb0pmeWlSZmpGQXlnN080bGtSOXF0SGwzbW4xd2orZWl2OFkv?=
 =?utf-8?B?VDNwTUVjRzVKamhvdGN6c000ZnNTa01oTDVsUndrSmNrenRLSy8xb2orVFdi?=
 =?utf-8?B?VkxnRVhMdmJnNG1UR0ZGL1FWOS93TzA3NG1ySGpKTG5FYlFSa0NKNVNiek5I?=
 =?utf-8?B?UWR1TlFxQi9aTCs1MmtxdDkvVG16OHVkdmZPY0wxZVBuSnhTZWVUOUVHZ01w?=
 =?utf-8?B?a2lLT3p6bnRoTys5dGZ2UWd5Z1g0aEViSEFPRVc3VWM4Vi9jOG8zeitGVEZh?=
 =?utf-8?B?QzlSOEVRTVVGYUNONU1vR1c2d1RQZG1KaEdNcHhLVithSzRTT001UDFZbC8y?=
 =?utf-8?B?NmttUExZV2JOeWVtOW1KOWVGVngzdWU4UEhDMlZRc0FkTzhmQnU4Qjlvc0FC?=
 =?utf-8?B?Y0pUNGpCT0NWZXI4QUQ5ZzY2aFlOWjNyL2FjWEZFWnNqMHhSQ1VzaEFZK0ZM?=
 =?utf-8?B?Q05NSkJPZzRFVzUrQ1pwQTFBSDVHdjR4cU5TVFFxNW5LRHAvMXN6ZEEzejdC?=
 =?utf-8?B?Si9zUWxoaUpaa21mcWZIK3lKOFJBV3h2WTBIVFhiNitBZU4yOUpjVWo3RnAy?=
 =?utf-8?B?UVpoY1lEZ0Mrc1B5aTBRYTczdXd0SFhobm5lSFNzbG1RL3lUWW9lQ2ovSmx6?=
 =?utf-8?B?MSt6Q0lqZm8zb3FpYmZMKzhrTlh1TEdQSFVydkoyelhtS2VkVHBEVWx2RFJh?=
 =?utf-8?B?dVFZZFk1aEJUK3RRNVhIT055ZVN3c1Q0cHpYNDVZaWVTYVlPTUZJdWRJZWc4?=
 =?utf-8?B?QVl5UVh3WlBRUmk4cWo0NTlsRVZwaFlaNEQ5R2ZnSUtlUmZQZmt3d1ZCem9U?=
 =?utf-8?B?aGc4RHBlR0tTQjBtS3VJdmpLVDQ1YVZxejhVZ0R3WXdhQzRJQU5lZnlVcyt0?=
 =?utf-8?B?dis5NVpKWE9vNnIycWJKRklobmtvblp3Yk9JR1lBWFpVeUc5WmhCcE5uMDh6?=
 =?utf-8?B?bWZhWllFSVQvWFE4ZzdqNGFUSVAvOGJNWmtXbkg1RmRNaGVTR2hMZlp1OHNC?=
 =?utf-8?B?dDNYNXpmUG04cXhidm11V1ZGV2dOQlZ2bVd3VDFnSDlCTTAvU3l2QXlnSEh6?=
 =?utf-8?B?bU1kK0I4OE9vdXhXU0FSTGZTaUordXdXcEMvdFFjVXFEUnF1RS81aXhIc01B?=
 =?utf-8?B?Vk9Wa1dtZDhKWHFxeVZ6US9wRWF0Zkp0OFI3T1RBRnEwMjVsWlk4YW5aSXhT?=
 =?utf-8?B?aUpGSGxsYXRvbEM0SmJBRWU5LzRqY0VEUHJNemNmRlQzQXZOcDFETUEvQWY3?=
 =?utf-8?B?WC8vc3lNejRQTGNtSXBCQ3RqTmM2YVMzeHpCdGprcFliakdkNC9JRW4wTVNZ?=
 =?utf-8?B?YVh3aC9RU0tmMmFnQ3JyRWFqdSt3M3RwYXZ4R0V1aktDdE0veDBKODBsVzBo?=
 =?utf-8?B?UmIzdHVxSWFVNGMySzd3b0tpUEluN2VwaS9GVy9IRDQ5ZCt0ZVVaVUYvZTZK?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bda192-b1b4-42c6-f5cb-08dc6fbf09d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:29:07.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 552N3O4/vI+RTPmvjQiF+IW0S327FzHG+r9yhlBOy9ugGyjfI7OFiquxzrcCJ3zT+GCLCcLWJvmMZkcx9TZb4IDewKUSX+iim1xflQXP4GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

On 5/8/2024 7:40 AM, Dave Hansen wrote:
> 
> As I look closer, I'm not sure I think this is a good match for the two
> other KFPU_* flags.  I don't think either KFPU_387 or KFPU_MXCSR causes
> any XFEATURE to be tracked as init.  The SDM says that FNINIT "sets the
> FPU control, status, tag, instruction pointer, and data pointer
> registers to their default states."
> 
> Off the top of my head, I don't know how that maps to the XSAVE init
> tracking but I do know that MXCSR has a very weird mapping to the first
> two XSAVE features.

FNINIT does *not* set the component to be tracked as init. Indeed, the 
SSE component is somewhat convoluted. AMX state will be likely tracked 
as init.  But, I believe this init tracking mechanism is 
implementation-specific, not architectural. Beyond this intricacy of 
init-tracking, KFPU_* flags all initialize each state:

/* Kernel FPU states to initialize in kernel_fpu_begin_mask() */
#define KFPU_387	_BITUL(0)	/* 387 state will be initialized */
#define KFPU_MXCSR	_BITUL(1)	/* MXCSR will be initialized */

> I really think it would be simplest to just have this whole thing do this:
> 
> 	kernel_fpu_begin();
> 
> 	// Zap AMX state
> 
> 	kernel_fpu_end();
> 
> Where the zap is either an os_xrstor() or an explicit tile release
> instruction.

If I understand correctly, the change could be something like this, 
although I'm not sure about this new API naming and prototype at this point:

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index a2be3aefff9f..906634402ea6 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -28,6 +28,7 @@

  extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
  extern void kernel_fpu_end(void);
+extern void kernel_fpu_reset(void);
  extern bool irq_fpu_usable(void);
  extern void fpregs_mark_activate(void);

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1209c7aebb21..0351f9ee3e49 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -452,6 +452,15 @@ void kernel_fpu_end(void)
  }
  EXPORT_SYMBOL_GPL(kernel_fpu_end);

+void kernel_fpu_reset(void)
+{
+       kernel_fpu_begin();
+       if (cpu_feature_enabled(X86_FEATURE_AMX_TILE))
+               tile_release();
+       kernel_fpu_end();
+}
+EXPORT_SYMBOL(kernel_fpu_reset);
+
  /*
   * Sync the FPU register state to current's memory register state when the
   * current task owns the FPU. The hardware register state is preserved.
diff --git a/drivers/platform/x86/intel/ifs/ifs.h 
b/drivers/platform/x86/intel/ifs/ifs.h
index 56b9f3e3cf76..5e7ba94b4054 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -129,6 +129,7 @@
   */
  #include <linux/device.h>
  #include <linux/miscdevice.h>
+#include <asm/fpu/api.h>

  #define MSR_ARRAY_BIST                         0x00000105
  #define MSR_COPY_SCAN_HASHES                   0x000002c2
diff --git a/drivers/platform/x86/intel/ifs/runtest.c 
b/drivers/platform/x86/intel/ifs/runtest.c
index 95b4b71fab53..33ef4962aeba 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -188,6 +188,8 @@ static int doscan(void *data)
         /* Only the first logical CPU on a core reports result */
         first = cpumask_first(cpu_smt_mask(cpu));

+       kernel_fpu_reset();
+
         wait_for_sibling_cpu(&scan_cpus_in, NSEC_PER_SEC);

         /*

> It's just a matter of whether you want this to work like a regular old
> kernel FPU user or you want to tie it to *only* being able to run in its
> own kernel thread. -- Aside: I don't think I realized IFS had its own
> thread earlier.

While both approaches aim for the same functionality, the code change 
seems to be smaller for the above. At the same time, it is notable that 
these new APIs, fpu_idle_fpregs() and the other, are *only* for AMX.

1. The diff state of this series' approach:
  arch/x86/include/asm/fpu/api.h           |  1 +
  arch/x86/kernel/fpu/core.c               |  3 +++
  drivers/platform/x86/intel/ifs/ifs.h     | 15 +++++++++++++++
  drivers/platform/x86/intel/ifs/runtest.c |  6 ++++++
  4 files changed, 25 insertions(+)

2. The above code changes:
  arch/x86/include/asm/fpu/api.h           | 1 +
  arch/x86/kernel/fpu/core.c               | 9 +++++++++
  drivers/platform/x86/intel/ifs/ifs.h     | 1 +
  drivers/platform/x86/intel/ifs/runtest.c | 2 ++
  4 files changed, 13 insertions(+)

Thanks,
Chang

