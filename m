Return-Path: <linux-kernel+bounces-234226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D658F91C3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058BC1C2036D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835E1CB317;
	Fri, 28 Jun 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCNWNRDU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501051C9ECF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593013; cv=fail; b=qz0yBLCntlpnHITM9GruVxllM7EGpMOuni8KTQhkEUK+TgYxPkq0X9CUtXdEuoZfMjecxveDdZ8cDcCNFPZiC9H5OVyZ87oTSdmOpQqPyoEsv4IIl85/SODEScrRARygJfJFl4Jo15tUBd6g0puzs0FdyN7DMHD3Vo5Lt9X2cJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593013; c=relaxed/simple;
	bh=tCvM/Oo0kAa+7VpQ7W0PqCHQCxj1aWGpPA2Z3IgeyPA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QubtlNXOQwPvFHRRlLuLEONoAllz2PzG8CooOjxUNzU+qABXKGX8mQ7uEuQaOarE9cOVvkHfltUnycY9VlOB1hyH7rTAueqXkVda0yPYaWK2BmKs/8yHNS9WobythOQq2FIYX0faprtkgufQ/kavxJ6S2wNfLq+g6nzg2h6F5ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCNWNRDU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593012; x=1751129012;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tCvM/Oo0kAa+7VpQ7W0PqCHQCxj1aWGpPA2Z3IgeyPA=;
  b=KCNWNRDUHov7RsrA13voMx+TIBrbhYsbmE2gtzFyQXfRhTgoKZajLa6/
   7IAo1RkqRiU1Cd0xWCUWkkr4tpf2wlI9cBTwvyf6XaelFqFVtRqfHVFwm
   69VW7HmzGF9aM/DPYAR1IMb74iBM4DLC5OCbkq5whFvKQxsLndQW4k4Ie
   qy3qbk8bhTY9ko26TEhsOqmUaw61xlG/L0pwXzuGY1793r0WBNdcqbsHU
   ngXmwlubeB8rReNo1ifFnHC4jfeJ+9hsFjpqNxgRh8m1YBXD+76SRqDLF
   +UbluK+bf2/bhALsJosY+aJBE+MRFO5KcrQTwDjhE7K4SBH1E5GCJ0yaR
   g==;
X-CSE-ConnectionGUID: h1l6i2ZGQUWjLjQll23eGQ==
X-CSE-MsgGUID: LjXiEUCTQiOhP9T2H10kCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12304193"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="12304193"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:43:30 -0700
X-CSE-ConnectionGUID: 3fyy7lmsThGDamwjEVPamA==
X-CSE-MsgGUID: aRgam1T5SzCJ6IACcKzdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49262807"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:43:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:43:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWhEulAtP1mFEV2NwVC+nLm6tA35iYBds9ALQr1wi6E9HPKX2jmVEIYqkMDCcI0jst6dk6C8PVPdVDew+OOOATmpKFH3iJDMsyUHXVlU2KKXoK1CePT/6zcE2ef8Ss3esLKLBoUtnhD7J8w4B3olvHUXGYefl2V7u0z2T1s97pXkH2TLP3Z0RJqvL1a6PkGJatNYFF6cY6otWQShWWNPCbVWwLSO7WI+XeNpjEOKCVKrN10usnKL5dtnvIRjleiMch1W4Lq40Z1y1z7lZR8WtwXNNz2b9InYf6jcO00/uOy6iTNVAJ7uBu/Qb2VHabbl6YXJzBDkdbLoUDVbljDbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5yJXl2qhwQqdLsDofKSYYQX1R9Uv+KnzN4g8XOeMgo=;
 b=dpV2FLsFGEh06dpSZt7631LiuW0+smh1cg9rJgIJqnjYIM7DDAi4kqgHL+0sG6Psz1GSOb7IRMSronuOz6GJynMiDSevg3YIElzwpIvZ1ks3LGExC5dNtWLHYJepiklTHxRouElEhMi+VFhnZCHMNeBntTK/NDNghr2Dn2W4yOo2D8m7uzpm0QUTvQaEM0F1H2DdsO9QDtq5V/J9D5sZ8rfNt6qEo07PiYB7+p9dqW+N/7RWcmyhZuh4YHe9VnTDHuX6/nwaMnM+tSHPfmFp5N0rpw9ibTVlgfHX2VNeOy0DYIfjI8l4H4H0/aZpPDgstga0iOMm4dlbUsndUVndDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:43:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:43:25 +0000
Message-ID: <2b2a57fc-c873-4029-ac96-3abb21363701@intel.com>
Date: Fri, 28 Jun 2024 09:43:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/38] x86/resctrl: Use schema type to determine how to
 parse schema values
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-5-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:303:b8::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 89535275-ed62-4caf-5f3f-08dc97916e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzdOZU5sTUlsbGNOVVBKRGZoRVNKT0pmRzBGQ1NsQjVadTFpTHdSaEZwSXhV?=
 =?utf-8?B?SVF3N2VDdDI1UHo2dmN0Nk1ZSjJ0U0JaTU1ucVd4alkwYjlwaGkxWnhmRXdS?=
 =?utf-8?B?Wk1MY002bHpFQk54TERDZkM4TTAvT1c5amJUMDhJWG5BekRtN1VsS2h3aHUz?=
 =?utf-8?B?WFg1Vk5yUE5rVzBpRWI0UFZyZnl1RVZZbU93YVFkMHRPY3p5SFc4RnFldFZG?=
 =?utf-8?B?Q3RoSHVFelc4ZnFGazNNQzI4Ukw1ZksvTUtGVWpSd3daUWJ1MGh3SXRiMC9p?=
 =?utf-8?B?SUlsTlVlOFFsdTY1YzZDM1FXWit2T0xOQXJVUjhpbnBiTWlLZ1ZCU1FWL2E5?=
 =?utf-8?B?c3EvYWM2NjN0NlZEbWVSblVjN1hUMkdDMnZ0UmFjckNLY1ZKQUhKVmE1TWNT?=
 =?utf-8?B?ZGd5S054TFJ3RnVqbk5oSjRTempPdHB2Z1lqaHpzSjYrQU90L3pBUmNTN25t?=
 =?utf-8?B?cldsOXZXd3JpSFdHSHhDSnJsYjM4OGdvZjgxbUxsL0pRWDdYa1VFTVhqM1I3?=
 =?utf-8?B?aDk1c0JXRS91amdhSkwzTFRjQnpmWWMwbHpkclRNaENvb3d6SytjeHl0ekcw?=
 =?utf-8?B?aGNZSXZQVXhaV1AvTlVOWkQzTGYwRTdIdklvUXZrbWl4QnVkN2E4MC9BYXo0?=
 =?utf-8?B?aDdkNWFkMVF1bE4vckN3K3pFVkU4ODlFSldkVDNsY2RJM1VORk9BZDdhZDRE?=
 =?utf-8?B?RG1yMVljLzJJdldPeUdrT3NsWENHdjN3Ym9NL002MUZTb05DQnlBazZ0ZXdF?=
 =?utf-8?B?MEFGaGh4WEdFV0xJYmZqSTYyNFl2UCsxN2czMDdnaDZPQng1U2h5aGtzMmFL?=
 =?utf-8?B?K3E0bHViV2lEOEMwUWdaeG5CWDRFUWFrZVhxanhTb1I3YTM1RDBUODVhanFI?=
 =?utf-8?B?aEpzditoSjVjMy9OWlVrK2ZVTHdNZzhLQXpNRk9YOEZsbmhPWEkyWDRJVkh6?=
 =?utf-8?B?ZXJOZkVZa0RRTzdaL1cxdUU1amhaV0crRzZPTUNrZHpDNDNUUXlsOVFLNVhU?=
 =?utf-8?B?TjlXUzFWTHlJVzYweHZmY3QyT2RaZ3RLZ3dRTkxXYW04ZEdlU0xaZlkyYkRL?=
 =?utf-8?B?R2c1L2t6VkVJemtIZUhqZ01rcitBUGRuanA0NkdVdzdKOEdaeHJCTFJzQ0pt?=
 =?utf-8?B?QmRLNEh5MEF5dk1zaldTK2R2WGRVM1djQnRORm9kcUpSMWFrcW1DRmE0UElB?=
 =?utf-8?B?RmRKNkVURjQ0bWlNSmdOZmg0ZTduUHZxemRjbmVLakZzQVZrSnhvTW9FNDRm?=
 =?utf-8?B?c3NpditKSGZERGI5czNjTys2cENTVlNhYXRlcjJQU1ZucEJVaHdYeFMyc1cr?=
 =?utf-8?B?TW5KenR4Z3QzTzhlb2xTb1YvSHdNWVplaE85Wlo4SUhMK1V6ZyswdkU3Tm5i?=
 =?utf-8?B?a2wwd2NGK3ZsZnBkekJrbVB3NzltZVFiOUV4TDFSd3kyODllS00zb1pic3F1?=
 =?utf-8?B?WXYvRnZIOWJjckRidDFRUVBtVTNXVzZCazNJVTEzSDQvYzlnaUNtOW9IOU8v?=
 =?utf-8?B?UnhSZ2ppU2Z5aWZ1ZlhkeGQ5VTZoc2JNb0RHcmt0aXRpK0prc09jUzVzQUNE?=
 =?utf-8?B?czJFNFIweFdhMW9MTzJrazlvUnFSdnc5QWsrdjJVNnRyTXNFNUZROXBQWUE1?=
 =?utf-8?B?UmFobkJQQjgwenpvZE9nQU9JbjBqL243dW92ZXlPaDBINCtZWnl5TmsyTldl?=
 =?utf-8?B?QXREaUpEald5bEIvUXIvZG1BdkdLSDgyVnZseXJFYU9OWGFSUTVSck9YbHUx?=
 =?utf-8?B?K1FUbUNYeWpMaUNaUnRjbUsyd2cxMmczZkxhV0RqblMwSW9SZU1sN3BWN1M2?=
 =?utf-8?B?RUd1NFBJbWREa0Y4OEhQQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJtZlBoZDlxcHBZN3JtdDU3WU01K1c3SW9PU21kZ2kxUEcycUs0UjJOK0N5?=
 =?utf-8?B?OGhlMG9GVkZnOHdVdVZjOTd3ODh5bis4dzVNT2JKUkJSQ052ejg3dFhjQVJL?=
 =?utf-8?B?djM4RENEL05WRTdiVEZKQnAvVG9XL3FYMUhQU3hlMG1jdGtxZFpVUE5VZjJR?=
 =?utf-8?B?ZUUyOFRrQmxFdk1ReXA1Tk9QQWFxeitUajI5c3FmcHhSQ3JSWDBWcm9TUHUr?=
 =?utf-8?B?blVRQlJKcjViODZmUDgzWEp0TisyNWsxckRGMU1Dai9NTXFlZ0FTVThEdGg4?=
 =?utf-8?B?dzM0Ly9jdFY2VFlTUEY5VVBjRUxVdEZCSExmZVIvQmpONk8reE1jK0N4ZllD?=
 =?utf-8?B?VHc2b0RmamIxbWUzbnI3MTZOTjFaR0RrcEx0bDhzZndDb0h2citEaE9rZHN0?=
 =?utf-8?B?K2s0SHMrNGJCeU9UM1Z2YlFZWFJ5c0RtNkIzRkpuR3dwTC9WUTlyelU2aUZ3?=
 =?utf-8?B?QVdnTndKL1RraXVqc01TTVBhSkhENE44bW93N2xjTHZuRSs5SWhOS01FSXZr?=
 =?utf-8?B?NEJMZi95ZnZKOStFSUk3MXFjQi9Fa2ZQN3plc2RyNEJZZkZ1M0Z4VUxwZmp6?=
 =?utf-8?B?MFZVUkp5WS82b2tndFduWkZBenNRY0Z1Ky9KbkRZdmJiZ1d1ZkFySHI4bVp4?=
 =?utf-8?B?UFprVjkzKzhaOTdBSkUxSmliZFpmSnVQWHYwbGtNUGtBV05ybXFSMzB4aW9j?=
 =?utf-8?B?blJva1BKZG9lMEx6SUtxb25wdGdEL1JCSWFtdnVTWkhiMWZ3Y3ZlUlhjalNa?=
 =?utf-8?B?eWZHZlRCVUx6RmdpMkp2Z0NMUjE3cUlDMEIyMUpNS3hMQThjY1EyNlU0UVAr?=
 =?utf-8?B?ejd3ajZxcG1jMXoyZUZ6ZkFHUEtZNE5zeFphTmIwYkE3SFJyS1JRaS9uZVBJ?=
 =?utf-8?B?YTg2Qk9Fc3JsbHY0akQvWEF4WjZCOGs4bThQY0phQWpDSUUraEZyUVRtYWpP?=
 =?utf-8?B?Vk53SmdpWW53RlgyclMxNGIvdTU2NlZrUzgzM1BOYXUvVTF5YkN4aHdIcVg5?=
 =?utf-8?B?YXR6dXdSdXJOQnIxdzUwWm5veUZLMk9yM2Urb2dHMUhWQVhoYURWYWo1YmxI?=
 =?utf-8?B?VFVJNXdIWmZsVnRENTNmbUpoUW5LRDhCS0pNN0FKWFVvbm5KMWg1UktxVEMx?=
 =?utf-8?B?bVVWbzJveWtFOGZSbDJGL0IvbjdzaEZieUFIOXhlM3d1dzlsTmQxdExkeXln?=
 =?utf-8?B?MzJ4TEgzNG5ZWElIUk91U3owajZQaVNGVmxaTkVsb2kxanpSVHZQMjlVa21o?=
 =?utf-8?B?UEJZRlNWTUprK3MrM1NiYW1EOFhsdWQxUy9aWEdNcnExWjExZ3VCbDhHMEtQ?=
 =?utf-8?B?aTM4YjVDRFJ5Y1c3d25YU1FWdlhmYjJzaHNhdXFrYXhtWjJRMEtzUUx6QnRY?=
 =?utf-8?B?U240Nkplc2Y1WnNmSGlXNHV1WmxDYTdmbk53c21VbEEwZ1J6aHZYR05ubEh6?=
 =?utf-8?B?ZjV2TkVJNjUweTV0bXNXMkdaYnJpbU5UZk1qVnc0UTZPeVdoZ05meWlnT0RB?=
 =?utf-8?B?dm5NckVZcitTNDQrejJCa0ZIb1g3L2s5YXB0MmZOZkZOYk1kQ1dQWVNlejkv?=
 =?utf-8?B?c3h4M2Rwc2d5dWJnc21DWEZyWWtqNUp6YXBKZXA1ZkNzbitjVjFvczVtdjIr?=
 =?utf-8?B?UmVNQXRKWFI2RTB0MnFhVHhGOGpJSUlWeUZNYjhZamZBQ0hlKzBDTXl5UnVa?=
 =?utf-8?B?M3BreHVmSFRQQUVtbi9PYUd0TlpHaEkxMk9nN2xKcS9RMmZXWlZBR3oxbGkw?=
 =?utf-8?B?NDdMdGxPSWcrYVVtM0lTcjM1OU9nN2JTb2RoTExuSjhkTHpIK3Z1ajJjeDR3?=
 =?utf-8?B?YkJWTUUrZHBEUlpaZDFjbStPWW10UG4vY1I4dWh0SEFSckRyTTBsaURyNFk3?=
 =?utf-8?B?QUhiVmxYV2tKdmlyc3ZnWkkza3k1VW5mcWVadU42YWpyL1Vmb0VYUC90NU5O?=
 =?utf-8?B?eEUwZEpFSmxvMHNwOC8wY3ZVYW1HeUVGVDZORFVGV3pEVTJpVUppOEp1QkJn?=
 =?utf-8?B?UjZqQUxvdFdtM0tUOHBTL2U1ZktGVGJ4ZGZOcE9XWWNHQUhTYzU1MEY5S3dR?=
 =?utf-8?B?Q0lEckxJeDFXWUJLTXpic0xUcGZyQm1waFVkZzJlTU1relQrRXZHSUJuRjll?=
 =?utf-8?B?U0JIWjVrYTUxVWhBWUMrNjdWUng0ZXdYdFg0akRoZVBXczV1dWZlMlhhdDIw?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89535275-ed62-4caf-5f3f-08dc97916e40
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:43:25.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl6HeUQIMnNIVd67oFxmU7n9sRCFYyKwwq2c4y8NSawWskKFAmJvB2ri+vGZJBmXwDcLBLosIXs69AvOFpCYWytvwJvNeG0Awa+hHnlYTRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 7:59 AM, James Morse wrote:
> Resctrl's architecture code gets to specify a function pointer that is
> used when parsing schema entries. This is expected to be one of two
> helpers from the filesystem code.
> 
> Setting this function pointer allows the architecture code to change
> the ABI resctrl presents to user-space, and forces resctrl to expose
> these helpers.
> 
> Instead, use the schema format enum to choose which schema parser to
> use. This allows the helpers to be made static and the structs used
> for passing arguments moved out of shared headers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

