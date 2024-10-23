Return-Path: <linux-kernel+bounces-378986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501D09AD822
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E8D1C21978
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA81F891E;
	Wed, 23 Oct 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdY/ORBP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35E1474B8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724570; cv=fail; b=eFfiaQyP6uVuozIk9FttVndLyQrkc7OvGD6PCE4P7aeO+0UxyN6UfCrU5Cy6/UbeyMlEdN2bzeJmGxn94O8MjSLuH2vfZCR5SQGIXUJ1ZO2uoKYyavQE22W1K9q6Lu84smM2PmGC2z9PG8aQ4D+9rbcDNsDbyusbFTyHKD83IvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724570; c=relaxed/simple;
	bh=0rV7HTjosSKytCIU66321WciiHuvtxHX+1GeFSEvz/c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qLTA9MvGyNgzB2JOdkqvOVoZKVq9YnBXsZUMeNxAowQtdJuUcur0sQ1e+CRvPlp/Y/cPauUeOKaM5YO0N91QWhYsMrUmt/ptpQ2a6chOriGcl98T2pJzk+DpO/eHwsLjiRy39Ovxqwphs+zFDg5FhF5nAQ1fQjrvaRMwYwyFDKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdY/ORBP; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729724569; x=1761260569;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0rV7HTjosSKytCIU66321WciiHuvtxHX+1GeFSEvz/c=;
  b=KdY/ORBPBfPDo9NZcRTbllGcAUDrTOPoRSM71//SrpKrmq8rg/u8qoiK
   k2UF1NYoXG25TSVIA/r9aAQ9OuY36D+Raq46hDNhOFXjKVqqhX0TE2WHd
   D2UoycWyroEiu71KpGsudNNjuEwKNAF3dXxbssZ5TeeUKU/xmXTflEW21
   Acwr+inGtHA9r+8O7Rq6JiIKytYiqTM+WC76dC4/K9ipxYegn/+E31pg7
   1z0Jr0cYwwvc/yXb0/m172epURojEG2cwOKRZKPYS/IG9PYTYZc2OMwiY
   M/vurBZCnPbpX25g4loozhUK4HFBt2b2EDULG1yR9Sv7bIk7XhcJA2FZo
   A==;
X-CSE-ConnectionGUID: /v1u50LwRyiOuZO4pgOIBA==
X-CSE-MsgGUID: 8nTp8tfmQI250jDt+0rpqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29458710"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29458710"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 16:02:48 -0700
X-CSE-ConnectionGUID: ug/Tt91QTQ20MLHLZDifuA==
X-CSE-MsgGUID: yfC2800/QbCDBh+GYycLVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80076558"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 16:02:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 16:02:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 16:02:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 16:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+zN7in495V7S16s+injTDM/gYaMeaiyfc+g59yLS64QA9qrYJlfJiz9mrmiLrnJsaFKYmwtLHWH0d6huUcp1D7yRlhPwqbXd/VsYlZ8ciWwCY7QBabgPpWgMM7t5FK1rxDK7GQBCDhRsgaZuFNSxVI/ZWH93SAilI+LEyZI9h8BIURQxlxdf8qh2gip0f1ayULXY0jkeqNPYIP4biOfBYgoQcoPhHYtgbWblaWzx31dQUlz34KR4jacGE0OQxM1JI49XH3LrD2CfFzH8X5kX8lwFhC51BxAVA0w3BkSYtQwwrS7EvNLc4hhEODLLL9d+FLaUtGFlTVLydmTLm0ZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN/24xzJX9JfqrP2rvHIFdItfmduxsq6l/qtdzniLV8=;
 b=CUXh7BYtcJ6Jabx8twwo1w7w6If3Y2UxXy7pWYTxeD/ynWGC3w/afYmrseu3PmgCEGZ8WG2zpRQZYGQYdRo4zD5P3+BS72pdQNcRCQd2DWrZqGADa2Z9aAtp0yLorSp2EkSJxMOx0+Ieg+pZz3Gyj368/hLZvrRHTnEK5S9zoib4JEfwns/YPS92qhpGC5shqLBeP1UiJBWpZ6Lzmto7eMgjJXZIeujNJqtbHP+jTQ64xNf0woF/4Z1YsB8DanNVwelNlahxYfBZ5/DjI9Gn1Tbxk71qA3pOSZvVxdRZXiEYq4UhGB7cBQZFmSr75hC+SZ71wE79VhfUy/TslQaqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Wed, 23 Oct
 2024 23:02:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 23:02:39 +0000
Message-ID: <b68d4ed5-ca6c-4835-bbbb-3c9059c8e687@intel.com>
Date: Wed, 23 Oct 2024 16:02:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 29/40] x86/resctrl: Claim
 get_{mon,ctrl}_domain_from_cpu() helpers for resctrl
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
 <20241004180347.19985-30-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20241004180347.19985-30-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: 515c201c-ae96-4619-98dc-08dcf3b6cadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHdwMjZnSlBGOFdFQm9VNlUySk5ZVyt5VGFwbDdROTV6ZG96UHJsM21rMU9D?=
 =?utf-8?B?WlJhWElHeUtkZjlBSldoOHdPUmxrSFRoMlFYWFRsNDN4YlF5VDJCV2RhMVlX?=
 =?utf-8?B?U3Q0UUc3U2Yyb3NhWTQ2bHBUYUhERjhSdWRHcXR2S1VINENobStkWExBa0JT?=
 =?utf-8?B?eGFUR1NWejZVZmw2WFQySzhiMjZCMmN3dHhGZkJHUnU3MzhPaEFXNWUzSEpY?=
 =?utf-8?B?a01jNUpUdzdpNzlsenRCc2tJQy9yNkNjMlAvQU9oMEFaZDd0RGszSUxTVyt3?=
 =?utf-8?B?R2dMN1pwb1pzS3EwN0tvRWcyVXNYNnAxaEFnZXVYbjRVR0E0Q1VzU1J6ZE1w?=
 =?utf-8?B?RlB4OU5GTUxZcDBxTmZuZklCOC9JNzFDU1NtdWo5YmlKc1d4ZHZTSEk3RVA4?=
 =?utf-8?B?d2RubTVPaEZEZnJpUkh2UmNEZ29HYTRTdnVsc09zRnZEMk5aMUpwUGRGbnMr?=
 =?utf-8?B?ZVpOOFIraUovdlR2b2ZuTVd6TnJ1OW1lM0NwWmpGL1hJY0Mwcm1aNDd1cXgw?=
 =?utf-8?B?WFViTUNyNnp5SWFOSER5RFF2MFNBa1NRWnRDcmQ2MHI5LzFIeWp4VE5Lbkhy?=
 =?utf-8?B?TjJlZ1E5RXJBN1dtTVVUdkFRUERQUkdwUkczakFPYjdvM05Kd0lneks5TEpZ?=
 =?utf-8?B?azh2ZDBLUWcwN3YvRFRwOEdIanV1eFNpN3NqYm13UDBEMkNxeHEwYWdKQkZh?=
 =?utf-8?B?cjh6Ny80Mitlc2g2VDVVK1F4dmhpS3lsNjh0M3FqTDFURy9TSUZ5d2IwNWVO?=
 =?utf-8?B?b1V4Z3JsV0hCdGx5aTBxUDN5SFZUdVcyVTl1bHAveWFybDFiTlg3QmVGQUE4?=
 =?utf-8?B?UE0vdDdtUG1acjZaQWxsbGdSdTdHUnJQem9RZjZPTVBnOHpjdFZRZ2dORm5y?=
 =?utf-8?B?UmtOWkNRQzFMSW9rMnc4aHp3bTlNZWdRdmgwaEZXUkVrUHpyS3A1bk80WXJO?=
 =?utf-8?B?MTdPVlRwejBrdk1pYWU2dnlFbVZiekgwNWdIZXpVQUdXMG43bTIzNURlTnF4?=
 =?utf-8?B?T0orZE54aktlenBicjBmUnhQQVZTZjBibXZpbWZ2dHZBNkI5cmlZam0xRkR5?=
 =?utf-8?B?QmlvM2d0SHZOTGtuTTM5RUFPYjl1cllYK2tXOHMwVUVla3JWWDQ5SE5LUGxR?=
 =?utf-8?B?VnB4SmpmQXNhR2dQblFvdnZVdzBqaURXY1MwcExuMFJoak0rVE91bkF3SUdq?=
 =?utf-8?B?L3NrbkRuV1Fab3hQazlteWNaVjJBcEpwUEdlcjVQZ2hZMmlNWHZCZ1M2WHhL?=
 =?utf-8?B?V3ZmOWQ0eHNPNFFrb0dIY2VGUzdUM1dsSXVHY0s1L0hwdFhaNlk3ZHdJdE9U?=
 =?utf-8?B?WENhR0lXWEVRSndYeHZXNUt1MTdrMTl2MHNVaVd0dDh1VHVOOFlwN01RcDlj?=
 =?utf-8?B?c1ZtVnBlSGp5MXFRVkNnM3Vsa2ZpVktXQ3ZxZjZkcWZ3bCtLYktuRk5IN2dH?=
 =?utf-8?B?N3dnY1ZzaktCNzFPQW1zRVhGT0RiWFlUdnpiYzdGYkVJUGo3SUNkOWUxQUVZ?=
 =?utf-8?B?alVqVW95K0d1b3RSUFpjZXRLemJHNTdlRVo0UnVJRU9pRVQvQ0g3TklWTEZ1?=
 =?utf-8?B?M090TXNSSmo5QXE1UmsxVFYrZmMzMFBzZGo0RFE3THovMmlDSHhLWlBmSjgz?=
 =?utf-8?B?QnQzSkpsKzd4RUhQcEZtN2xBdW1IUUpxZ1RFeW1QRzA3NEkrL1JicTE1YXpM?=
 =?utf-8?B?eGJUUXNlMUhuOFcxU20yQ251d3A0SE1PcGE3OC92OGRSNzBhNzVqZTRTK2Y4?=
 =?utf-8?Q?V75UR1XxEmQ9eW6FCBX1Ahi/WgEAHxJg6OSbdCm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmVCNm0xcmF2dlVNTFh3WDlWWHZJVS9NWklPOU1jcHNXcHowSm1pdDVxcHcr?=
 =?utf-8?B?eVBWREphcW9kMjJNSW9UUkhiajk3RTVHeXFXTlk3bnMwN3NIQTdjd0hEeVBD?=
 =?utf-8?B?dmdXZTdtdXVVTnNXOTJ2bjhWdWdlSWhiek4ySXB4dGM2b0l4WmlCWit5dm1D?=
 =?utf-8?B?M1pWdXd4NksxS053cjZaVEN1eXZyditvdDdEbWtzYi9WUkRHSzYyTG5Ka291?=
 =?utf-8?B?MFY4SWpMQmRYWXFRSWN1eG1QeWdNdngxS3ErREh1cTRQQWxYWDJKd3FWOVor?=
 =?utf-8?B?U3lEa0JTeXhvQ0pEUFdtWVNOWmw1Y0o0QnRhOGhaR01HTitPZS9vVXBMS3VZ?=
 =?utf-8?B?K0lJVUJqMXYwUXJ2OVFGaGM0cUhYSjhaSUpHVkd2V3JhdTFWdzVxMTVkU203?=
 =?utf-8?B?dHhqYnVKMVZMUzgwWUhWUU9Yak5rZVFUVmNHSW5FZ2tBNG5wWDNmc1ExbVgr?=
 =?utf-8?B?a0JONDN2ckQ4Q0hBZGdzb2RaNzlDOVVmVVgweXA5ckJUUzdrdHBER2ZxbUpB?=
 =?utf-8?B?UERhblE1aTl0WmptVmh4QWhVNGVCVkZSU1FibWh5ekI4UWZXMmZ3L1cxclZn?=
 =?utf-8?B?aGFUa3dIbG43RWJhL3gwN1AzbWNCclh0cWx2ZThLMEpHZ1dSL1lHSkJNQWMx?=
 =?utf-8?B?T0JPQkNCejc3TWRKdTBYaVJGbk1hM0RRV3VqUUgwRlFzUWg4eFFHVHJ1bWVU?=
 =?utf-8?B?ditIa3Y4djRVZEdHWWFlTXZJditEZFNQVkkwTWwyYldKMDF0TW5jQ0pHN2cz?=
 =?utf-8?B?TjBZblJDTE5QZmh5b1hYUjI3VVpPTEJrM01KWVdZZnF2Rm5JdjNEK3YwZ0Fn?=
 =?utf-8?B?anlLblROYWNpVUtCR1pLS0ErdDJqb0FXQThpcUpXL21GZW51Ky9nMUZnaEY4?=
 =?utf-8?B?d0JlVmptd1NaOStWOUpMQzRTZTlSU0w5MnBBNElNRzlhb2Jic2Jub3Zpa3Zr?=
 =?utf-8?B?c3ZQUWtEV2plV3F2Q3JQVzkrMEdLLzhzWFZ1UG9sQ3RYeVhzRkY5b1I1WCtr?=
 =?utf-8?B?VGVpbVlWcjFXK2hGOUdrdCtrQlZDS0M4bkl0NDE0RnR2Qkd0OXpESGZiR1hm?=
 =?utf-8?B?Wkg1QlRJbnhsbjV6bUJ1QXhEU2djbzZuSTFFeHpId3hDdFlZaWZqOVhuTWRB?=
 =?utf-8?B?Z2hINEJrUXdvZWN2bGh5RnBDWmpJTnRtK2ZYNjFtWDk4ZUN1Vk9ZaGUxZUlw?=
 =?utf-8?B?VGU3TzRWTHFZRnViUWFDY3IzalR3KzIxczlGRGdsK1Q2QkpxbnRpOEQyOCtk?=
 =?utf-8?B?OUFQR1paTWRmTzlWNHlEcGl6b0tNVndtVVAraEF1ZUltRllncDBidWdsNkVh?=
 =?utf-8?B?am16Y0JuRk84aU4yY1FxZzJFeGhPL1J6VjZabU13bmpFcks5a1VLaGdxWGFF?=
 =?utf-8?B?KzROSzdVZC9BRFovSElmbkFJTjVyS1hRZFN5Sld1TVpmemJjWUNXc0txT2Jx?=
 =?utf-8?B?ZWd0ZFEwRTZ0UEJ4aWxENnNhSGx6S3RwTFEyU0tZcXlWWkcwUXpBSFBIdncy?=
 =?utf-8?B?VjZ6MUw5RHNzWVVMMlRsZ1lTdEZmck5JZmd0aEdnQkpxQ2FxWU1oQ0lpNXlD?=
 =?utf-8?B?TjRLQjBybFZNRkpiVXBLajhUN0NHTkFueHJqRVNjKzFmVUNaMmNrcllNN1Nw?=
 =?utf-8?B?WnlkK2M0NVhqaTN3NXVub0JUR2F2RCsvZVZTK0dLQ2RJbFBlSzhIZ3NBLzJW?=
 =?utf-8?B?SXFIdlJZa2FRSTFQWDQxMlRWY2xnRW1XQ3pNY0h0RGkrTElCejVTdkVtT2Y1?=
 =?utf-8?B?Yjl3VHdvZlA0Z2NGOXJJSjhTRE80aGY5U0plbmc3M0FEc01VR0w2WXBjdzBv?=
 =?utf-8?B?Wm1lU1BDS3ZjTlRZT2k4OFBEMW9CN1c3dEZtRE5hblZtWlhtQ1J3a2lycjg1?=
 =?utf-8?B?b0ttM2JiYjF0MTU0MzVCOTBJM3NSOE1lRGVXbDFSYVgyZVFlLzRvTU10c1ps?=
 =?utf-8?B?S1A2Z0NyUW5heXhwNGRnSzFlbnViaHFwY0FSUGRTTWRWeThkcVBVQU96ODVU?=
 =?utf-8?B?OXlBMUdxMnh5TFlhYXl1RFRrOHd6cGFUREJaOE1wQWdIU2ZjeUtUOWhhR1I4?=
 =?utf-8?B?aGRrTWhIb1ZpbkFRZk4zQ1FPVm8xa0E0alFVM2ZSWVlzTGJ5bGpKenhicDF5?=
 =?utf-8?B?UU9ISW5CYWdRdnJSQUc3MmRrbm9vNUFkZjVKUm9LME1Idm50M0F1NncrNVlo?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 515c201c-ae96-4619-98dc-08dcf3b6cadf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 23:02:39.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcqgbNeBpGvhpoe/DNx4+CHV26k+XYUBFux3pEWWk+VH+EcMoakqDoqD32YVhAOYUqxzoZ/DQWmGiil82BY13FWTjgCC/q5QH7d96krvM7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 653d7cf41e64..bbce79190b13 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -3,6 +3,7 @@
>  #define _RESCTRL_H
>  
>  #include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/pid.h>
> @@ -397,6 +398,42 @@ static inline u32 resctrl_get_config_index(u32 closid,
>  	}
>  }
>  
> +/*
> + * Caller must hold the cpuhp read lock to prevent the struct rdt_domain being
> + * freed.

"prevent the struct rdt_domain from being freed."?

Reinette

