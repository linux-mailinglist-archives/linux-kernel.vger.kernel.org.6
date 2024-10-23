Return-Path: <linux-kernel+bounces-379011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FB9AD8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816541F232E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12B1F5829;
	Wed, 23 Oct 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9UCypli"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DC1A2C32
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727419; cv=fail; b=GuTPurCCa3yq+RcPI259spAWtUs+eH4xAAbINOykapC9WDJCyn6ZlDAw/EuXBIRyPzz7DDaFJ9MwUwNkJAV4L1oivCumvShhDSzS7xwbo22I48SVgh5HR1lUW4ClV13uc2mCnyBWnS0zLhCP4Dl64KGatzaB2W07JtwH4gu5+m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727419; c=relaxed/simple;
	bh=H1Ldvko94rms3LIz6bzuG1h9wBZVXshM68DZdDxNvho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FtONe1/msxUepNCClYQUelVieGms+bU+aYobHlSCJclAyFvE2/kxlWMmo7je0JsD7esTGRSkp/kQ5qAlrHdg90U6fImmlQo8AWmDjfYN/BEFVLBTRmpUH8+B2wTTd6PH/CJTbtsWQb0lDvuYeNHEhCB4EBQzLnJHwXc+EbGZkrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9UCypli; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729727417; x=1761263417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H1Ldvko94rms3LIz6bzuG1h9wBZVXshM68DZdDxNvho=;
  b=D9UCyplixyFA9N/Dn5yel+tDLFRIHxQn8ERubJNzT4b7vxV7yfYlsPjk
   l85IQjEXazbSIM5J+iu2HWitn9l+Km6ArhUFBP3GaVS6srb+A1SzDOFmu
   17h3mqJ8Wjnb7e9povingtHFy6U0TqzOnMP181sYtq5VnJoUBh/vFjozH
   2OlIa0MTv2+kiy/uBagoc5FFgzzw5govH6YWlfJVB9O8hQ4lEwhDx27bc
   JveQVUeFWEm2CbFvE/TQ1ffS8ZeZ9W8bdvB9MDkt51SAWKONwT2YJaHAy
   qBVZTtB3aY6MIkNggi8LH6Cm8Y1L4XrZJy39BdAaEX3tnKo4nUGEkgnRZ
   g==;
X-CSE-ConnectionGUID: 415W4je5SYifXaFnOE3bxw==
X-CSE-MsgGUID: MSKVOckoTIqN2+ijXZEd5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29237524"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="29237524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:50:16 -0700
X-CSE-ConnectionGUID: V5mEK5QvRhSqiEIE8bhbkg==
X-CSE-MsgGUID: 9izRzGlXQ+KMNwf/ZhTtqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="85028685"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 16:50:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 16:50:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 16:50:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 16:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJbBAhkplHaoDgCvOUWFs40nzY9TSBDeS4W29brEUphdFk/uI5Wk/DvIvw1mlkpC50OqCmlvGmcKNvkrIT8sBLjLFhu70dEcJ5CSmygCq6eTMkCtiMi/JB7i31//FuioHhHZ1Hc4l/BTgHSRIQWtnO9pEgBnW2VrsCdifefUYJJ6CXLSg//FN3Wx7KACoTC2+sJkvJ7Wwj59YulgYE7qCkrfuD6g4VDh73EP5Zlcssw+Rk6VhMVKxYFyT1AdUFKc00VuhY+O+4iWmzGAoGJRHfXUUGWHJEgopfPuWgJjRGscPJ++gT7PW1SZixm0E969Zo2BlixFEGoE9ya3oxGLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBrNCCFrvUxJMr89gz91hzaeuE52ktkhG/266qQfC7I=;
 b=vfbXb6LvQSVLAPz8yUGHi/KtZneN8J3qcrLaKmtsR0bQa25N3eehOLKppMif0l6hJfyC2hkMrXmF+rNVVdvLpxX0LmoXTooZK+/q7qsHFsydsJqsH+yD5fA2tCrnt+xEwTq0HZ2a6EW73ksubCVtbCfG+cFwwG68EjxYrfILeg4cHZjE2vTrYJCP3osP9l1+IuJsyWNeY40JbWxVURf5CvPL+jCupoRvElFc8d0hkSrKNkSwwh/0r9mTGCNIX9FxP5GRUdeLpNFqEG57R+Kby8B+nBTSSuJv41uj5QSxOO4Zo4oBYaLOuuy/UJ6c4K1eRdlmfDlQ2STBJNh73+a67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 23:50:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 23:50:12 +0000
Message-ID: <93fe977c-e5c4-407e-ad84-dec7f81e6b87@intel.com>
Date: Wed, 23 Oct 2024 16:50:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/40] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-33-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-33-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d233b8f-f4fa-42fc-da73-08dcf3bd6f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnA4anYrbTVTN2xlSHhyMG41V0szbVJ0eEJsZmgzdHZnNzJhUVNxL0JLYmxr?=
 =?utf-8?B?cy85UXhlUW5hTWQxZ0dzbXY2YWY0eE5UaUZua2VpbGpubTRUQzh1MWQ5NHpG?=
 =?utf-8?B?SE1KdjdiMjYrOFZOK2pQTGFTRGk2emRXZWhCckJZUmNpMWdaSXZ4N0h4Ullu?=
 =?utf-8?B?L3VmaGd6VERGdG1lWWd6UmFUMFc5Yi9VOVcwUUlpcnR5Zk1xTkVXVFE1VEIw?=
 =?utf-8?B?WU5JUnNnMEtRUXY1NWJCUDVHSnVzMWVna2tKUWVHRU9XTmNtdHMxSmVFb2Mv?=
 =?utf-8?B?TnEwREhXcU1YRTd4NDgwK2w4WWhTRERiK3FvZjRhb05QcmczK0swNWpGOTR2?=
 =?utf-8?B?R1dwaVJMZElITUlJbkRhUXdFQVd2M0RpTHEvc21hYlhRYmtsK2hnYyt6TERx?=
 =?utf-8?B?Nm0yNlZ5MVJxTTlEbVBVdzZ2RFkxNlg3WTRIVHBHYjR0czc5ZjJRcXJ4VlJs?=
 =?utf-8?B?MjRVanEwU0lPeVdQT0E1eUd3Sno4SUNZcGFyM3BCeDgrcmI4UU1HdVFSUHhI?=
 =?utf-8?B?eFJTNGNxeWNHL1VsaVJ0QitucG93VCtMbXZsa1NjV3BjeWdKYkJWVGUvVFNM?=
 =?utf-8?B?eWNjZEROUnExaWNrQnlNcFYwUjM3c205dFNrRThpeUc1Z1RrcDBFVm8xNlFi?=
 =?utf-8?B?U05GbUdwT3M0N2RLUWxUbThHRFh1d0NMVjdBRCtlOEtwL3JsbHU5eC9TRkxB?=
 =?utf-8?B?TURtZVJtWEFrQ3Q3b0FQUEVwMlFDZ3dlMDhlNWhOYVZXTkZFWnBNaWpwUmtM?=
 =?utf-8?B?L1oxbW1XUVY5R3Z0S0VMVkJPdWxYUlhZZVYzaDJ3R1h1dGo4Ly9CYkwxRHhV?=
 =?utf-8?B?UDQyNE9JYVlzc0dQQlM0QXVoTmhTTnlwZC93Y3BzTG93bjROUjB2UmVySytr?=
 =?utf-8?B?a2tDMTVPNG1JbCtBR3NCRklaaC8wZ1lrREc5SmxOdGp5OGFTNEdrcEVYeXhy?=
 =?utf-8?B?N1VlV1ZOVHpvK1c5UWNHSTJZQWZya05FenJ6UWo1VmE2am5YcWh1WXVmUFVl?=
 =?utf-8?B?a0JKVGg0dlVlUUtTdjd4eG9DODBHT091dU9uSURxMFdqcW9wdFUzdkhiZ2l4?=
 =?utf-8?B?bVdjMlREeFdYMzNiZHpoUHdaczRyV2xmc1JsYVdLWDlscmoydGpDNEcxeXJT?=
 =?utf-8?B?QXdUT1M5Rm5BVzhwNUI4TnMzUGU3Q3lVcUtwU1BCRWdkcTVnSlJ3Zm5Ma0Nk?=
 =?utf-8?B?RVd5YSt0V1gxOTRTbW5wa01ZVUNOVEdJdGMxRHl6MWNScFltTkJTL0lNZlJy?=
 =?utf-8?B?dmtrM1h0dEZGRjRJSlp1OFF3VWRIWk1nNHczRUt2NmY5eXhDSUZCNDBoUFdq?=
 =?utf-8?B?dXdFb1VPLythekZKTTdPSFQyeFBDSTVQbW1uUzhZSy9ldWhtZjk0K2FRMjVx?=
 =?utf-8?B?VHVqb2E2eXpDWHBxbkdSMWUxRkZJWW0vNHh3SFQwcGdaU3RnTzFTaDgzK29U?=
 =?utf-8?B?clNvNGU1dk1LMm5MZlhuTkFJTGR3S25jWmVLK3F3RVVRa01MMGF1U3R0Mmdt?=
 =?utf-8?B?Y0plM0F2WDlEdFh4V3p5RnNZUVpPUHptVEY2SUN0NUljYmthZGhOb3ovWHpl?=
 =?utf-8?B?eE1sMFpJOVYzS1JEUWpseGxvTU5oeWlpVVArdjBOK3ozRTNxeVIyV2VNSWVM?=
 =?utf-8?B?V2JuS3doOEVPTjJPYWZVZVR6Vll6VUozYnF2czNFOTBSSng0RG9URWdQVjdR?=
 =?utf-8?B?ZGUvSDVEbGpxaEJnb2ZLYmtYd2lDZFQvdFNCM2hqNXM4QnhzZ3MycDRybzlC?=
 =?utf-8?Q?tjG3u2c82ZpTb8as7V2T1/EMOKtVF9vOgClX+zJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVFOUhaYU1OUTZGVExCaFNWZEFSQ0szZWdqclZzcS9VRi9GWTgzcTJpbDBW?=
 =?utf-8?B?bVJpcjFTcW5HODlVNHBvM3FkbHVuTmxlQWY3VjlNOFZNRlQxbUJFY0RwVXNy?=
 =?utf-8?B?QnovNzNBTDgvNTVmY05KZENYY3oyU25iejNkRFR1R2tyTmU0bEp2bzNjbnQr?=
 =?utf-8?B?TWtkcndBZklmQVF2S29UZmFwaU1iMWl5U0FpUEg2NDhnc3FqSHB0TnRXNk1R?=
 =?utf-8?B?Tyt0U2FwY1BtMnhyMUhKR3NBL1haL2pMY1Iyc2t5Rmd6dEV4MWRwYStJTG9m?=
 =?utf-8?B?Rkgzblp3OGNxWXh0bUZqQlhVc0VQVm5yM1I1Y281aEhEb256VzRrem5pNFgr?=
 =?utf-8?B?NnA4TXZxNmpRYmIrTDNSS0ZsaVUxdXFhRmVBcUVSN2t2Q1czdlhVMElBZUxx?=
 =?utf-8?B?Szk2THY0MWE4VHVXTk9kWDhOMVlUVkFvV3ZvYkRLcnRzanBhWWFIdUVadUxM?=
 =?utf-8?B?Vlh5eGFGZm8ybE5iYnkvVzJjdmIvVk5QNTJNZGNPVWRVem9IVnJqcWRkblF2?=
 =?utf-8?B?a3FGd0NGTmEyZGJaNjQ4S0dDNHlTVFhZSjlUaUlLSnRJTnpKZ0JGUFRCa0tP?=
 =?utf-8?B?dXlzdW9kUzlFMjdqanMwK1BVVlIweGRMZjBqdGpjajVTWFdZYnJyKzNqZnlW?=
 =?utf-8?B?Vi8vWEtsMjJ2OHlTWEtzRTRwR2tvZWVUOUlYZFkwSllpWlpqRjhuOE9ZYUQ3?=
 =?utf-8?B?M0QzVFFRQXp5cGp4K0c1a3hvUzlVdThnUHd2d1lRY0ZQV2UrNlF1d2ZaYmx6?=
 =?utf-8?B?UUVtb05NUjZoSmVJeTY1S0VDMW9EaDhoUDh2WDRaV28vWGZNakpYYmNGRjFC?=
 =?utf-8?B?Z3R2ZVg4RCtyUmFzK2ZGTkFwTGI5Q2kvMHNKODFYdXMzb0h0WUU0eFpLeGN0?=
 =?utf-8?B?VDhaZWlnTEdyeFBPeGdPcGRYKzlyTUtMbHQreDhTVEJYbGFGbW55VndwYW1J?=
 =?utf-8?B?M3JFS0RKbVZIQ0tkMFUwbStUL014U3RCWGVtcXRsc1RCR0ljbWJCMzRLa1B3?=
 =?utf-8?B?MHRQck5iaVhJYktRQ1FqUmV0UzBDdndhSUcvREdiWitFVk9zSnc5ci9DSnZE?=
 =?utf-8?B?c3pOd0lrS3BiUVkyTmw4dk9YVlJkbVFUWlYyLzV4WXo1bXRIV1JoalNFQVhh?=
 =?utf-8?B?dG1oWUFsdkZtMmlNaGN0NlBvV3h3cWNsU3ozbGNRMHJUdStrMDk4cUh5VzBW?=
 =?utf-8?B?bk1Geklic01pNG52enduakhOZnpVTVJ3S3RmNCtnVHNYQ0NkZFQwTWhEV2hm?=
 =?utf-8?B?dStJQlhCNStLM3BVT3BOVHc5S1VkdStJNlp5amRHVTlVUWRXd2RsZnl5RGZN?=
 =?utf-8?B?MUlmbFFoZTl6NzBuT0ZXb0ZrTjN5b28vdTNsWXFWUWl1ajlPYVpWV2FORXRQ?=
 =?utf-8?B?Vy9vOXNBd2IyS216cGhRLyt5SXhRRWVmZlBDSjFmaEl4UUU2d2h5eFkweEs3?=
 =?utf-8?B?UU1ZTkg1cGtXT2h1QlUrT2ozWDRMRERUa3c4QkZtOTN3a0ZaUDJDczVzRGlC?=
 =?utf-8?B?SFl5UHpSbDJQS1o1Nmd0YUUrUURsWHM2RTJQZ0pSRFhGYmx3NThPei9KRUdo?=
 =?utf-8?B?Zm01TllxNHBEM1VKOXV5TmFMY2ZrSVBMdUtNT21lOU1uSmR0NE5hTkdndnJT?=
 =?utf-8?B?bFVZc3EzYU93T3o2aUNIcTU1MHZYc25pTEZiRkE0QkJQTnowZUFFWE1ZODlr?=
 =?utf-8?B?VUI5Sm41dVo3a0dZNEt0bXRTSXJ0Z2Y4U1oxVmIwdXAyeGRZcUUvZWhxeHZP?=
 =?utf-8?B?M1BReStPK05NSUJ2d24vc0ptYjlHd1BJWlR1VEYrS1NVZUVXVnJhTU9mS09k?=
 =?utf-8?B?Y1hQZEZFV2lYL3VxMUQ4Q2FrbWRwcXFiZVdkVXVrUWZ0WUtaOGIxZEhKdGdr?=
 =?utf-8?B?WmYwZmhJcGdHejQreTdDVXZ2YVRIR0V5dEg2RVRMdFRxRGxyM2N0S1QxVnEx?=
 =?utf-8?B?OFh0dG9aWUMyU0RzZ21zZG9PUEFaNlFwdEF2aWhOdW5VYlBFL1c2Ty9CbTM5?=
 =?utf-8?B?QlJmSDZnNWxzTEkrbmlDdnR6YlhwTEwxbWNQaHkvdTBPYk9wa0EwOStxblAz?=
 =?utf-8?B?cmlsZlYvK3V5V0wxeDZka3NIc0tPWUhOVWpENG9OQXZyVnhxOW5sU3lNY3lk?=
 =?utf-8?B?R3pXRkJOeEVWc1JHbEVvcitaN2ZvTkl4ejlpL1hMMm82WXhEbXZxSWJCMkRG?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d233b8f-f4fa-42fc-da73-08dcf3bd6f9c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 23:50:12.8086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /biUeExM+EM1vsa8OiCCZGyRylgrotj4YTRncD7VosJKFiKCt/POzzvJ3uz2mpxRERaT2jqoGKqwZa8UhFExwmCLaRtfYqF3n5vKcDAWscE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
> resctrl can't be built as a module, and the kernfs helpers are not exported
> so this is unlikely to change. MPAM has an error interrupt which indicates
> the MPAM driver has gone haywire. Should this occur tasks could run with
> the wrong control values, leading to bad performance for important tasks.
> The MPAM driver needs a way to tell resctrl that no further configuration
> should be attempted.
> 
> Using resctrl_exit() for this leaves the system in a funny state as
> resctrl is still mounted, but cannot be un-mounted because the sysfs
> directory that is typically used has been removed. Dave Martin suggests
> this may cause systemd trouble in the future as not all filesystems
> can be unmounted.
> 
> Add calls to remove all the files and directories in resctrl, and
> remove the sysfs_remove_mount_point() call that leaves the system
> in a funny state. When triggered, this causes all the resctrl files
> to disappear. resctrl can be unmounted, but not mounted again.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f77fab859c35..bb5aadaf99b6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4319,9 +4319,9 @@ int __init resctrl_init(void)
>  
>  void __exit resctrl_exit(void)
>  {
> +	rdtgroup_destroy_root();

If I understand correctly, rdtgroup_destroy_root() can now be called
twice, first during the error interrupt and then on unmount. Would the
second call be safe? I am not familiar with this code but  I
see kernfs_destroy_root() and __kernfs_remove() dereferencing pointers
without checks. I wonder if this needs to be made safer with a:

	rdtgroup_destroy_root()
	{
		if (rdtgroup_default.kn) {
			kernfs_destroy_root();
			rdtgroup_default.kn = NULL;
		}
	}

	
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
> -	sysfs_remove_mount_point(fs_kobj, "resctrl");
>  

This breaks symmetry with resctrl_init(). The changelog describes the
motivation clearly but once this line is removed it will be difficult to
get back to this motivation. Could this function get a comment to explain
why the mount point is not removed? This will be helpful to anybody following
this work that may attempt to "fix" the asymmetry by cleaning up the
mount point created during init.


>  	resctrl_mon_resource_exit();
>  }

Reinette

