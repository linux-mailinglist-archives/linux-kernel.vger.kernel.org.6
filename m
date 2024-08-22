Return-Path: <linux-kernel+bounces-297653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603B195BC06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8149F1C223D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235C1CDA27;
	Thu, 22 Aug 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtmyut1O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B61CDFBA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344438; cv=fail; b=GuYO9pXbSgnOVWNzM+53GjWOldQJhLq3vjQwe1T1Bt463+2cX+AFrx8S5Y/H1ZB2mhRdAhacUgIY6BE2wIjaHt7XJngJSkrURzMqmnwwI6UvvDTy3aOmXk79oKohirXg38f4nTJW5UMQ/lVozr+VsNWe1tfHatbWhHQ76hylivA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344438; c=relaxed/simple;
	bh=jsZnqNNw1Nby9AW77PwcPaEiDd8mvpS3WMorC3KutZ8=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNZKBygPMS6L1ofSu566eS6nhRCdcpYHmereJLgwT+gec3L4m8eMNK/TOHWOufIE27i3BRBa0OIgEW8jyURdY03dAsRkCVLEoVRIZC1HocrLFHmRj0aJaPDeKUKW4CC5GMyWegbqZex225P7h3nzmHGy8WcY/7q5qs/117c7GyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtmyut1O; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724344436; x=1755880436;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jsZnqNNw1Nby9AW77PwcPaEiDd8mvpS3WMorC3KutZ8=;
  b=mtmyut1OTiMVu141IRru4je6Pw4wuXa5DC9bSsSe+gjIy8VK976LWI/w
   UB2P1iqYnDoewynrDrdBchwdWIfd3GQH3X7wUakeiJzmZs4/vgtbj0078
   ceU3jpba6rluOE8UgbyKt/qifAo+L6jOKtpCJO5mNhbksf1d45pTMHrj/
   TUVE4rIQItuO4GHNeIATCnabkphPMrBf1Z5IthfqXQsSV12M10di2ACLt
   VaCyXjJWJSEi/6EdVyvJHq3WIZiGzHQlvfc9ra3veq6JZxzjd4mA8MVTv
   MLVG5s7cYsJIUAXiLit6hcdLuDF2bdIG2slyjHB3nGtkAB95DMQoUoppl
   A==;
X-CSE-ConnectionGUID: 1rrVAD4YTSuemEXbhszeLg==
X-CSE-MsgGUID: sb3k4MEjT1W8QI/JipoiHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22945834"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22945834"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:33:54 -0700
X-CSE-ConnectionGUID: Ru+BvfDpR3mQXMRAoAscEg==
X-CSE-MsgGUID: y4Aer+7DQLGf4KyANefBuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66396406"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 09:33:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:33:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:33:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 09:33:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:33:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biF6H/4vTRwCSBo2vBNo/8a+eaIDoaC0cfWnhA0lteizTDnffk8F6lAO4ewqk0VVzxO8AxFwpckyLVXbMJISWBGVpfns1Olilzn2iVQI8CuV7iRqI9PQvxqUlAggNMDLDARpS9kcYvPCazMkWBy1ZkNIZNtEpZhvaMduxXDZ5kRa5kIujieSYqxcSQosf792q1UPDW/uWLPD7cVTC9vkc3RxmSq4o8Yfn4GeODlm3tW3QCOwC+Xe5C4z7HRqeOh3ZJNBUkHXSKQ/xsh0aTI/9uIZld/0uWDAz1dBRSeL7DOYS4jUccpmbfUbF9Jfyc10WKb4iOOjGh+DaviMUz0Zxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRL4nFESiK7oDqN7jQ+atayVuwoam+haE8ZfohH2y6Q=;
 b=IqxIS845IsNepoX/t8gEXDdsKIK6uE+As/on7g2snQlXNlfa9ymA68gLdYP8NtFuZoPB5b05VZAgm+0quRw1BvjX552bBucWIjxz0brz8DQjxJbiqYBk6YxMS6wQbXztdoQdem8uefjnSJEx0QzM5zwbAYYER60WJSg3kCeE24wvFx7CFJD8iC7qkD7XWSoq0n0ZrSSBTUgRyVuIeTYfHM6jLmb8IfVNt9687vVYZOY9GZve4dAUruMXCgcGFbqMRUtanIb1ese7fm6xpw3sWjQ0HSSphHn7tIYbv/yVqLWo7xuwk1oCWQpyWyvRP4Rnz7yYfCN9QZ5Xw3OYaNyavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 16:33:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:33:49 +0000
Message-ID: <dd0342ae-7474-44c4-ac80-d12b69f093c7@intel.com>
Date: Thu, 22 Aug 2024 09:33:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix arch_mbm_* array overrun on SNC
From: Reinette Chatre <reinette.chatre@intel.com>
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Babu Moger
	<babu.moger@amd.com>, Tony Luck <tony.luck@intel.com>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <irogers@google.com>, <namhyung@google.com>
References: <20240722204611.3549213-1-peternewman@google.com>
 <f67e36b2-709f-485f-a0db-388247ff6b37@intel.com>
Content-Language: en-US
In-Reply-To: <f67e36b2-709f-485f-a0db-388247ff6b37@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0322.namprd03.prod.outlook.com
 (2603:10b6:303:dd::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 33593b3f-0565-4864-c809-08dcc2c8337c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?allmdEpSZEQ3STY4eEF1RzhmTjNPL0I1djlFNFZVdnZvQVZUeTRBV24zQTFE?=
 =?utf-8?B?YkhjbXhzZEx1QVM2Y2c0eWZURUtrM1dQS3hjanZjblQ2bCtDaGFJSmNIVGxW?=
 =?utf-8?B?WlMrcDlSdHF4czhqa0FPRXZqMlk3a1JvZ0djSWxTQ21aS2xzcTBxS0IzeTRa?=
 =?utf-8?B?djJtVGNUaVhrTGg4eWxQbFpzdGkwRTA5VExnWEZXbFNWS1B3ZmkrdGY2ektj?=
 =?utf-8?B?SWRxSDZ0eFlZa0E1OWd2SG51N2MwYlBUWjlxVlNqcmdwVzVPLzkzVi9hOWQw?=
 =?utf-8?B?Nlhvc00vQ2xYLzB6L0FFbEdyaFhIZktUOUZ1WTdaRGdhZEZKd083Mnd6VHBi?=
 =?utf-8?B?SXoyZVhDSkFERFZEZkoyWFUwemIwNUozdE1NRjZlVU0xR0EralZKQW1uRmgy?=
 =?utf-8?B?VGpGY2lUa2RqNUxpOUNOTVVITFpSSHhCbXFQOWxCWkpGRlJMYkFYYmk4TklZ?=
 =?utf-8?B?T0pURWF2VVFPK2dyZzA5TTRUOGpMTGVBVEtadnQvSk9hKzNrNnFJNHBMQ2NS?=
 =?utf-8?B?b3kvamJaNnV3WkFsODBSczBDTnpEdGJvdHowWUlWRHV3eENpWnlRdGFPaUhi?=
 =?utf-8?B?MGNNR1ZCT0dGYzk5Sk1sd2k3WHNSV1BTRXNhYWxaQWx5ZDJYbFNzZDZVeE01?=
 =?utf-8?B?RU5Sc2NLMlhtV2NiL1N0M3dWNnBjTkRBZVRQSFhsZHZJRzVOSTJqU2tTK3RU?=
 =?utf-8?B?dWlOWHpwWkF5eUZJNHlqVVg2TFZjR0QwckEzU0JpTUFPVVFoZ1IveDcxMmU0?=
 =?utf-8?B?NUJmVW8wNzJoOXhFeWNKN2YxelJETFY1OEpnRHNiSXJYcWZhTHZOU1ozb0Qx?=
 =?utf-8?B?Y1hNS29EZ3hqTnJmSGEvYnlaR2txL0VRcjVHZ1huWjFZbWF3Wk9wVTJkZkto?=
 =?utf-8?B?bEN3OW50M0VvZUl0UGRTdVUrakJBU0FkYi9IdHFrVE1waktyUGYzYXh4eTJY?=
 =?utf-8?B?dWhHSmltZWdXdkgrc3daVURLZDZNYnVnSE5Sc0o0MkZndVJ1bjZUMFVvVnRk?=
 =?utf-8?B?b3RoVDQranM3aTVTTmR1K3h5K2U0VmdCc213bGd3T2RiYkgyN0RpWUVBRFIw?=
 =?utf-8?B?TWJGN2RFV05GTURuSTFmc0I0NVlwcGp3Zk5pUkJTQm02cmRqNW14MndxcXBY?=
 =?utf-8?B?eEZEOGowOUdLcmZkUDhiSm43RkdUdzVpbi9ONlpOM0ZEeGdoS09rR1ZvN3pE?=
 =?utf-8?B?NldjMjVvM2V3UytIMkRIdC82RmdrN0xxZEdXeExENWwyL2dDNlFSV0dNQ0o0?=
 =?utf-8?B?RUhqZ08xZC9zclZ5MXZsMnEvZVRVSkc0cW5pNmtYTkk4Q1pUZksyODFOd0h3?=
 =?utf-8?B?NkpXMkZ5U3p0eHJyWTBmdWdhRlhORDZTZU4zZDkvK1UydnBWdGdteExQYkhL?=
 =?utf-8?B?MkhZM28wZzBkSXhodys4dkhsTElFNFdzellEeWc5RmRkNVl4T3dnT0wwdWR0?=
 =?utf-8?B?R28rOU03RyttZS9xTmhPL285QjhvelYzdXo2TDRCWjlFdytEMlJhMGdlT2E5?=
 =?utf-8?B?ZmFEb2Rjd0VtYlVwanZwUTV1M2M4QnZ5R2RVMkpLZTgrOGFYcndVZ3pYQkVz?=
 =?utf-8?B?cUpLOVN3eFFZQ0svSVVadCt4a3Jpbjl4RTJoaDRpMUNNMGlMZHdIVE9xSEFm?=
 =?utf-8?B?YlVrc0Fwb09ua1YwNS9xZ2dSTktIcDhKb1lmY2FEUkpIbjhmdHhDaDRhYnZQ?=
 =?utf-8?B?a3ZQWGhGRlhKUEpNK0dEcWhOYVViQmNmcXZ1ZmpvazdKd2xWOS9Fc2xnaWll?=
 =?utf-8?B?MGhtRkN3RXM1cXN2Z3F0V25ISkVYSUhyc1htS29sZHNiSUZqMkZ2QkNRYmhE?=
 =?utf-8?B?cldDM1ZyOS9PNzAwckg3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1ZiU1cySHFjWHBFdHVrLy82WDJ2UmcycnVMaGNrS3JhaG5GNDhHeXdjK1Vr?=
 =?utf-8?B?V09XSGcwSGMrUCtsVjgyQW9ja0h3Yi9oRitUMGxlQU1OVUsxeldwazZEWHJu?=
 =?utf-8?B?SHVGZXpERDgxcW8yVFpzMFZ1WW1SLzZiOXZMWDh1blJtaGpDR3R2NSs5enoy?=
 =?utf-8?B?RFBUdEo4YzlRVWhEcnlkQ0RWTU83cVAxaVdlazNjYkV4cmI5U0JZQWZwOC8x?=
 =?utf-8?B?Z0lJSVFvMUdOc3lmYStuT2lTZkd3dkROaFRLbVVpRGU3MmFVK0pjTTJmVjlK?=
 =?utf-8?B?d2xyUnUxbkhyR1ViNW9sTHVmSjhYN0phM1pZU28zck9DMm50eHJ0QkY2dy92?=
 =?utf-8?B?MkdZS3lVRTREUkl3enp6aU5JSkowUTYxK1cwN1YvUFBIbGNDR3psVXBrRU8y?=
 =?utf-8?B?MEFIT2o5dnM3SEN5M2RkMXJCRWlRYmlRV0ZURHlaVHZwbEVScm1TNFZ1ZkZp?=
 =?utf-8?B?ekxwTUpOdE9hZzNPOW9wbUdQdDZ6YlJpdElabCtaVWhoUUJVQ2hyblYzR2ZT?=
 =?utf-8?B?VEhYL3o2bm1hb2FRUHhFRTI5bEN6WjVTenJSc2liYXFtNnhSc0N4M2FSV3lm?=
 =?utf-8?B?TmlWNlNEWklQU3JSUytxL1Nic0FjRUtRMU9xSXpxSWlRY0lBeEhka2dDcDZj?=
 =?utf-8?B?NUxqVGxsVjJkWERDR25YOGluZE5hd0ZYTGUxQ3pVZmU1S1ZZUHZQdmFYeS9u?=
 =?utf-8?B?L1J4TitUQlFCdURjRXAzbTRFVlJPVmN4cm5NaDBKdjJkVzNiTFMraDhxU1U4?=
 =?utf-8?B?OEJjbjN0bkRjTk84Y3BLN3ZXR2dnRnpGYzAzVjYyUWtXcWNLZUoyWmI1SUx1?=
 =?utf-8?B?TDNQVWhRend4aVhUN3E4aWs0MVhJY3UvZGxZUlpHcWNPUDhtNC9MYXdPSy9T?=
 =?utf-8?B?a1NEL2xsTlFvOVpzN1JZc0Rsc1VLbkFDb3FNdUZHRy9DdG1NWmxRVk0zOEd1?=
 =?utf-8?B?SGJNZ3M4SkZlNHhRdDlTK1JCWkl0Ni9pTnd3QVhGZytRWVFjb1JHRzI5WEtv?=
 =?utf-8?B?UmJvNlRmcVlWQVYxcnBNcUtuUE9uOWY5N2k0QXpqQ0VubFdzWVgxLzRoTWJR?=
 =?utf-8?B?SW9kSFg1enl6dFp6dmRxeVBUS2NRTGFzQmZ6aUE5UDZpbVoyNmFCNHdvSFpi?=
 =?utf-8?B?SFFVbWxzVlAvK2FHOVVKL3M4OGNySTYzQkU2aU9XS3BEL3E1bERnc00xUExF?=
 =?utf-8?B?U0VHbzdEaysxcTU3TFRvUDdGRU0zTVQ4dmxhd0dvVjhXS1FpTzg2cy9kK2xw?=
 =?utf-8?B?WEt4Z2ZMbEQxNTV1bUFVTnJ6ZktpQis3NzRiOGZ2aHBhbGh1QjZ1elN6MnBn?=
 =?utf-8?B?SGpKZFl5NkZrZ3N5MU5vRlVCT283c0tCZExmeGpMbmtzUFp3M0tNM0pOelQv?=
 =?utf-8?B?WlVJU3BEZFBwMDlYMkUvSFRhR05pMUpVMFdIVjVaWkdmOHpKM1ZtUGVnVXVC?=
 =?utf-8?B?RExFNEY2Q0wzT051R0RBK0diTy9NMHIzeWZMVm0yMU9MS1JPVzNRNnBMelNR?=
 =?utf-8?B?TXRwTVk3YXJVdVo5K2ZLNnVPL1dIU1hPU2hjZVVCR1JoaGt4c0gzZ3JxVzZ3?=
 =?utf-8?B?dmlhdURYODcyZUZJZDVWN3JyeFpFK0NqMkFDRVNjdzdUM0Mwb0V1by82NTBF?=
 =?utf-8?B?TGJDQ2lGQy9xVVVFWnl4ckQvRHFNUkpzSlJWYm96UTFoYWhWWDdyb0xnV0g1?=
 =?utf-8?B?R3lObk5qMzVsdlRwcGJFYllIM05mVC9hLzVkVEFjUWpBVS9zNXV2TTlRdWFl?=
 =?utf-8?B?aGJWR1JLeVN5VGlQdjkrUTYxU1EwUjJjTTQxQlZiWTYxbE5yWjhhZHRLK3Rh?=
 =?utf-8?B?RVZUVFJpbEs2TU5ES2FDTEx0dHJEbE03NVBBRUJOc2Uzdmt3R21mK2kyd0Jj?=
 =?utf-8?B?R1R6WkYxajFXWDZMVUhBTWdCWjZTRXlMZ3N4TkMxNUZDdE9RSFRvY2lVNE5C?=
 =?utf-8?B?Tk80YWNNRUtpZktyclRUQ0szZHlqSDA2TndEWThEMmF5UnE1NEliOGVvMkZq?=
 =?utf-8?B?Z3RTNzJ3Umd5N3FZUk1ZYjBndjA3SmtVWkxYM0EvZG05bUptaWl2QzVFMnRV?=
 =?utf-8?B?TUNlRVUzbFlRZzliZ2M1d2d4L2JncGNrRlVtVExkSlNuMWJXbEZYUmJSZWI1?=
 =?utf-8?B?Rko4UldvNjhmblp5WnVrL01haWljTG5hV1JEbXBQMlRMNHlkT2lRRno3T01X?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33593b3f-0565-4864-c809-08dcc2c8337c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:33:49.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcqVPWeTJ8FAJzLKP0fOSsCiHNXmnzkXPL1C2MJt4TblO2wEN9x+fxD9ZTOUJqMRDvBZTkjQZ7vzOHKN3f8xLkLOK4ATYhtTlUsPELNOV18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
X-OriginatorOrg: intel.com

Hi Peter,

On 8/1/24 11:16 AM, Reinette Chatre wrote:
> On 7/22/24 1:46 PM, Peter Newman wrote:
>> When using resctrl on systems with Sub-NUMA Clustering enabled,
>> monitoring groups may be allocated RMID values which would overrun the
>> arch_mbm_{local,total} arrays.
>>
>> This is due to inconsistencies in whether the SNC-adjusted num_rmid
>> value or the unadjusted value in resctrl_arch_system_num_rmid_idx() is
>> used. The num_rmid value for the L3 resource is currently:
>>
>>   resctrl_arch_system_num_rmid_idx() / snc_nodes_per_l3_cache
>>
>> As a simple fix, make resctrl_arch_system_num_rmid_idx() return the
>> SNC-adjusted, L3 num_rmid value on x86.
>>
> 
> Thank you very much for finding, root-causing, and providing a fix for
> the issue.
> 
>> Fixes: e13db55b5a0d ("x86/resctrl: Introduce snc_nodes_per_l3_cache")
>> Signed-off-by: Peter Newman <peternewman@google.com>
>> ---
>>   arch/x86/include/asm/resctrl.h     | 6 ------
>>   arch/x86/kernel/cpu/resctrl/core.c | 8 ++++++++
>>   include/linux/resctrl.h            | 3 +++
>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
>> index 12dbd2588ca7..8b1b6ce1e51b 100644
>> --- a/arch/x86/include/asm/resctrl.h
>> +++ b/arch/x86/include/asm/resctrl.h
>> @@ -156,12 +156,6 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
>>           __resctrl_sched_in(tsk);
>>   }
>> -static inline u32 resctrl_arch_system_num_rmid_idx(void)
>> -{
>> -    /* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
>> -    return boot_cpu_data.x86_cache_max_rmid + 1;
>> -}
>> -
>>   static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
>>   {
>>       *rmid = idx;
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 1930fce9dfe9..8591d53c144b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -119,6 +119,14 @@ struct rdt_hw_resource rdt_resources_all[] = {
>>       },
>>   };
>> +u32 resctrl_arch_system_num_rmid_idx(void)
>> +{
>> +    struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +
>> +    /* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
>> +    return r->num_rmid;
>> +}
>> +
>>   /*
>>    * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
>>    * as they do not have CPUID enumeration support for Cache allocation.
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index b0875b99e811..43ac241471b3 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -248,6 +248,9 @@ struct resctrl_schema {
>>   /* The number of closid supported by this resource regardless of CDP */
>>   u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>> +
>> +u32 resctrl_arch_system_num_rmid_idx(void);
>> +
> 
> nit: the additional empty lines are unnecessary.
> 
>>   int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>>   /*
> 
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 

It would be great if this fix can be included in the kernel release.
Could you please send V2 with nit and tag applied to be ready for
inclusion?

Thank you

Reinette




