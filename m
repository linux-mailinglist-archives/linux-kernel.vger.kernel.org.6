Return-Path: <linux-kernel+bounces-367169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6499FF58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF89B244B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34617624D;
	Wed, 16 Oct 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+d7lDTu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC9C2FB;
	Wed, 16 Oct 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048989; cv=fail; b=RVKdHgJW23qfFGwGBtroviXfjyy3K/UYYzM4ak9YTXEZj0ki1+9CUvkd/R2Uh+1IvGI9CEdw05L6qS4FfPmGeEJED5WfEeHMmJSPwA591m/vz2U6ydt19r28jtwKJS5OE2r4xPgymLOxEka8dmWtmePZ/QussadvlOGpmloth3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048989; c=relaxed/simple;
	bh=iOJxrg68TTQZ80hSr5gxfsIc5sKDJcjyKOaWYhGg8j8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E/PDcgX2jNNPmOeSY/FV68b0JBEuzK8CnCw6uT8UsAIazb1514eQA9CCGdMqNzvPYdTd44oNoXvvcdIB/9nCttenySe/19mP61dw5iBuAd//EVLZGR8B/BSZenoDnemvusOw8IGyuj9b2MCSC+Jw/FRnDHKo8FuTLjnP4D9vDtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+d7lDTu; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048987; x=1760584987;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iOJxrg68TTQZ80hSr5gxfsIc5sKDJcjyKOaWYhGg8j8=;
  b=Z+d7lDTuYe3tOEh4b5njEQT9fVRGm6VJBnF+VC/A287A/o2AVxjacPCR
   FLOGGQ4ilq/bo5/RhwdwSKpvZimwsgk1fVQ5AM8Bhorh/ZX5mztxbJG71
   mTvIhEjgdT+S8rhlUEfkJwXLBWIsbTLgvojZTka0TR+qbN5LyNz/8uqdw
   hTQ9upljt0DZ8Rhc3esFp50VJC3740u3bRZVqHfamPp4FqV40hSMmHCkc
   goZXghiMz1XfJ5eHF09dRnkgxClnriTcyjCHxCcyX8ZT1bibWnKqtRFNf
   rKy4/j4wJWSD06vzNFQ4Htz4s5sw2Zc7gs2oO5phVdsjj213AO7CfXaLd
   g==;
X-CSE-ConnectionGUID: OZr7FCP8Tui7AvUsvQVjIg==
X-CSE-MsgGUID: A2MMcKbFTCe/r4UbeNneAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="39850511"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="39850511"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:23:06 -0700
X-CSE-ConnectionGUID: cgaiTrLWSj2t5LkQX4bjZw==
X-CSE-MsgGUID: G7o6pmHJQ92yIpR7wgAriQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78553969"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 20:23:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:23:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 20:23:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 20:23:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 20:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo2Otul0Xu1pxYDfpRLg4qj+J5UD/3kRpD1GTU7W8o15ODWaA4N5EBcRo0BNWd7/nEwNCGcW3UHnTKtBnlDI4N+WIU18CdHgdAXqmWYTw/OoeI2kqKA+8Zpybn60GSj7Mvc2fOcsJ+GXCdAtxGUiPGipbrIDC5ZutShufZwP5YYvMRNnxdqK1+b4SQMmp4iQ3ONwzg97AANXGnEx6BE4+1kvj2+Kv2FYBTmith658VMEm0Qv1RSShj0tu2MVgiJjgR3Ii/keXvO5zzfPwUWc3GN9QZLj7ABp3AwXSnbIrrMvZsHZWOgrYbIAlYRKFaoJnRGtn/jR++P1bxqEhwS2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHscxBx6YZ7Sfvpv0SlHR8PwNMnamOLwWO9/xL0g5UE=;
 b=KzF9nqAN5mbuNgupsdACtPjpH0xbY3M4pFmWvmLAnPNJwaHn5uLt11jIxbxQiuCAwfhLJHKm7jDQNF/Q6KfC8U1hl/vJ7BHs0kH8uXjpUaq54qNvVWdooqAzrVILaKUookV2XMbwmgwds9uDP1iK+et5HRxV5h/4mS8f16l+UR7rJwxZkRV7kw3Jb/wVD65ItEW0OK6g+iIwHdzYzBGL+D6eJVD8P6h+N4ms2WTZOTZwNwnRad6AHSAs5b/iiOmExizTcuHoX30C22UBLNptQTycJhTR3EaaWPQ+4fleAsBt6nJTAyfssv771lhT6X9r5oPaErm/DIOtOn53OiGPvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:23:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:23:02 +0000
Message-ID: <dc8d11f2-38ae-4745-ba19-82cf8a6c4dde@intel.com>
Date: Tue, 15 Oct 2024 20:22:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/25] x86/resctrl: Introduce cntr_id in mongroup for
 assignments
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
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
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <0af9b74cc32cbdd26fb0d9adda40c359e8bf1bb9.1728495588.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0af9b74cc32cbdd26fb0d9adda40c359e8bf1bb9.1728495588.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 61062535-dc01-49e6-e13b-08dced91d76e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVkxUEZKYS8wc1B1MWthMTF3RWdqYVRQbUdjdkxPQ1lQdVhyMzNJeDFVR01K?=
 =?utf-8?B?NjRYRk1LYTk2dnZlcEdOcno1dUkrQnA5bnF4V0EwYmUzVVVUQnppN0pPUDFy?=
 =?utf-8?B?ZXJaeE9ORi9VVzhLSUtJenNYVVpzR1ZISlR4OTVJMm9UN1dyc0ROS1NaaXhX?=
 =?utf-8?B?S0tieXRWNlpOcENvZTJreU1waXNZWGNvakM1Y3hOTVdsZWFwR004aUhSM1dE?=
 =?utf-8?B?Zlh2TVZMSEtZYnV4OFJOMG80elFyYXhtdGFMUU9Jb0tZaXJ6SFpyWDBONEJZ?=
 =?utf-8?B?WFpDOFFQZml0Z2ZTeVF6Skpkd0R6bk91RENhVy9UN3RqTEdTOHdWV2Juc0xy?=
 =?utf-8?B?Q29JdWpDVVZlYWpTcVJocit2aGl6YjhWdHRwN1JBM05HTUh1cGdkRmx6OWFI?=
 =?utf-8?B?aDNzQlJvZ2JMaDNMdFFsQnlyU3dJd1A2M2hmVTZnaThJSzRKUGs5T2pWRllw?=
 =?utf-8?B?SWxpNC9uUXY4czJmeUxNbjhXa0NreEo5QWVPU1BxVWNTckpVSUNzYmgvSzhp?=
 =?utf-8?B?TVdTVEg5alV2WU5EZTZvR1NaYUdCSkRCVVZBRkNIMms2WUozY3NJdmdVNTV0?=
 =?utf-8?B?U284b0JTNy9acXFOTGVYZ0RnRDFGcHVFRkYzRHlFWlFFRytUUjc3MEJJWE9D?=
 =?utf-8?B?OFNUYmV3cWtyTVkyNnF2RXRvbGh0RzN4VWl6ZzNlcWNkZzN0bERaNC9UeEhm?=
 =?utf-8?B?TjBtZS9ZOXB5NnZtam55TFN2TFMzeHhzSndiMkVwcUJkSmFaYTB5VVY2Wk54?=
 =?utf-8?B?S2Nudkp0eWJmbEdSWStncXorNUZmY3pqdHZvRjBWMnFScTNPdk1NRENLMko5?=
 =?utf-8?B?bHhoQlQrdjhkbURTU0pBZjVSR3hDS1JQUkc1ZUNtUGRoc0IvWlk3bzc3QVA2?=
 =?utf-8?B?aW90bmlORVRyWXlYNW1YWmpnSG9oTmI0alczNTU5MkkrQ2UrcERmdFBHNkNG?=
 =?utf-8?B?aE5CV0xuMTdzZUNaenYvYk56djl5R3BpYWhKNWdMQWt6NmppZDdmbmZkbk9j?=
 =?utf-8?B?RHdFbUxSWXpZV0FPWnBaWkhPRDJoUUx6akhtTzlIN1ZOMlFlNWxNNmk5bEdN?=
 =?utf-8?B?VHR6ZDJrcHAzcThYajV3bjZGNVU0OWpFbHp1bEp4eVNQMnhDRzNvbzNPb0No?=
 =?utf-8?B?bTV1Y2lFbUgwYjdydG5DTHBIakZCb0ZRS0JaeU5VU3NqWlkyaGpuWnUyRndo?=
 =?utf-8?B?WE5JNjUyUW5tbU11VmRqWFM3dTl4V2hyajJ5WVJsQnNYK2o3NGJtQzNpSmdM?=
 =?utf-8?B?SzNKMjJzSUplQVRSSXlhdW13ZDhjc1hCMTRvVEhXVlhuaThlU1V5VUUwSnd2?=
 =?utf-8?B?ZzBOaUJ3ckJDaE44SVVTbXNDKzBncTZHNlVBOXdoVU5qaE5RK0VTSkVFMjE5?=
 =?utf-8?B?eGFuUFluenNZNlJTTTkzV29Kc1YrdUkyZWxYcnVtMGNpTUxKRGt3c0ZjdlVa?=
 =?utf-8?B?YmZyYVZxZi8wMjAxS0owVEkzNkpoOFh1Z2pWQ05UVm5YS1hDTFQzRkJSNG9B?=
 =?utf-8?B?aisxcXU0WXlEWWpxZHNlYmpnODFaMi9ieVlFY0VEVXMvdHVQZWh2KzFWWG9Q?=
 =?utf-8?B?NUl6ZHd1bFFZaTRwY2hEcHI5dDlCQmVVSXBCc1ZwajQ2K0Z2N09vR0U1L0ZX?=
 =?utf-8?B?S0JDRWdPY2VrTnQvVW8wWFJ6UXcwZW5XTGVuejZlVHE3bCtnZzJzRnh4SkxF?=
 =?utf-8?B?Z1REOTZaY3BCdzgxUzlxS0NqbGNMR3Q5MkF0RUxxZElVVzVFUjlNT2xnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWVzck9PQ0R4SzZDZEpLclVPcis0Z3FoREZPTW5mQzlkcktoVFl2RWNlRVB4?=
 =?utf-8?B?cTNpOUh1RldkdElzMWVWeHJCdHR2NzVweG5QVXRrWk5GTzFTek84eGYzT2Rn?=
 =?utf-8?B?Ly9BVm5mc0IwbWM3WTl4dDVad1liUUs3d3NiZnYwNHZtazg1bFJwbVhuUzhV?=
 =?utf-8?B?dFBqVEdHaVhxK1d2Y0VmRlk2eWdRRmpNLy9qTTR2Z1hhQjRUbXppMFpUN0dn?=
 =?utf-8?B?Y3ZOR0EzQ3pDb1ZRZnhqeElUWU5IV1NZZjdRbDBNZ0ZBVnJ5S0wzVnZqMTZI?=
 =?utf-8?B?bVgvZHM0NE1hdk1qUVFBR0dKQmZLTTczcTVORGF3OUdJamhRY0JiYXU1djBj?=
 =?utf-8?B?d1FRcWs2aDJqT0tNY0sydmpwL3h1Z0xGTVVaK1NjVGZGbUZjNXBiam9aNXI4?=
 =?utf-8?B?ODcwQ0ZnNngyTmw4Q1oxbDVUWTVSazQ1SnNNWHZSbTlKQTFVdlNKRFN1NVo5?=
 =?utf-8?B?ZUhCdExZaWZWaG0ySmFVb2xwWE9ZeGVqdHRkbEVSdVZKWllpUWQvSlBGVVBL?=
 =?utf-8?B?YVZIWkZ5NXk1YlIvcGFZcHo0czlLTFRNb0szT3lBREs3b0ZmdUtDZUprKzVo?=
 =?utf-8?B?Uktnd3krS1BTVm5pZzEzUGIzaTNUOFBCQWExRlFsRlRyZWcxbTFVdWF5RlBC?=
 =?utf-8?B?WFRvVktNckRDUGwveDRaVSt3MWpFMlVaTEY3b0lFazFrejcyaFZBNUtZbzRH?=
 =?utf-8?B?M0poWDNtT0ZFbmRML2U1eUhuVnJYbFF2cnJuVjNxd0FNK1RVQnRONWZlQmRk?=
 =?utf-8?B?K0hqalhRSVRuU3BvSTN3Z2dKa0gycEJjalN5bmJuSnAybVNtOFUxMkRjT0ly?=
 =?utf-8?B?Q1kzUDFickI0cFl6amVPZHRXSlRXaHl5MmhwbXZJenRpbks1OG9pS0psREFw?=
 =?utf-8?B?UktYbk9NUjVuQ1BOMDg2UWhtTU5WbVRCQm85SUFYbUdFbzY0Z2d0cStHeUpH?=
 =?utf-8?B?TEwvUHRZWkd6WDkvUHFhZ0VLVkxMVml6c2owRSs5VnpFRmI4NzBTQ3FrMHUw?=
 =?utf-8?B?anZld3FiQitiY3NxTGU2Q21qOWQwYmxYeGNGeEdsaTkwS0YwRXFKTEJhYm96?=
 =?utf-8?B?QjVuN1J2VmxnOWJRbkpTeHVrL0QxanF2RVhSUmw1djZNNnlPRVgxTnNLMU9X?=
 =?utf-8?B?SGlJNVhnUnhmQzdLQ1FJQ1dWQUtVbnd0TXkxeGJYc0Y5cytLeTdSTlBDNXNF?=
 =?utf-8?B?MExEZnhuNGJyNWM5WXNXN3VKNnM5cWEwYW8ydWZ2MkpmVU1tWVU3MVkyekJ3?=
 =?utf-8?B?K0JiRFJnRFQ5WUFvZ0ZMcnliWVRjL0VmTGRZSVFkUkx6RlF6OG90K3hYa2FT?=
 =?utf-8?B?VUZwc281K3lzS1M0SDJaZ250bkVUL3VaV0xJNzZXWmxOZUg1VDRGanQ0MEt1?=
 =?utf-8?B?OEZHSWV0WEkrV3k2bzZLZC9xQW1mbklKbFRVaGZucHNQTGorMjc4Unc2ZVV2?=
 =?utf-8?B?TE5LRXZOTVdvSFZZYmcrUGV0RHRST3FDWU1JQVdZcWxmM2hLZUN2WXdhcHRv?=
 =?utf-8?B?M1JEUVZ6Q1ZOcFJPSVB6aHBISVpvS1VkV1F6TGtOVCthZkNtOXpoMU9ic0tB?=
 =?utf-8?B?RW5HOTgwaFdVUENWYjlnUUI4WnZHOU5MMitXOUVTUnNnV01lWm5WSWVaWWM5?=
 =?utf-8?B?WWpmVDhDM2FiSnF1ZDlaTkUrVHUzOWxySkNOWHdvVVZKeElLWGZEYTBDUHlp?=
 =?utf-8?B?RUlPazNZL1VzWGdlOTdQZDBOWTBYL0dkY1VKYXJhNDF2bHRpK3dCQWhrZE9z?=
 =?utf-8?B?R0drWitmV0gvYnd6SXM3Ui9relZEa1dPb05BL21GNmcwOURPVnpMWEZCYVZq?=
 =?utf-8?B?S3YzYWdtOUE1VDJkNW1odXVFcDI3SVhqa3JEaHREY0htQ3J0eEJ6VEFIQ056?=
 =?utf-8?B?YWRFOHVNdDYyQ3d6RlpnTXRhV3VCV202TGRhRHFGY01hMUhBSXdZS2lCYXZP?=
 =?utf-8?B?emJ5aEx3MXRoQTRXZHdjZWxvbzM3ZVprQ3BGc1JPeFFtY1oxQUE0VGkza21r?=
 =?utf-8?B?d01MeU1YczhtVDBWaFVxcTRZNitUT09EVzUwblRPdlp4MjZPVmJ1QnMzeHZM?=
 =?utf-8?B?bDgwZmNGUVQ1L2NhbVhBcVoyamphTTJnZEJiS01IRnNBamxVSDhRc243N0Rn?=
 =?utf-8?B?cGNtdEh1OE1EMDRBVkswcjljaVVDdXBHWDZXdERFQXk2c2lrT3MxUU9TeWdx?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61062535-dc01-49e6-e13b-08dced91d76e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 03:23:02.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43VuKhQOfxw0sEUxsJBiMp08kbz1cTGfl5paABpbYdlxZqm/ElQ7hcIhl6jYEEgV7/EVUeDtnwli6FjnahdmvRZcqnhq8UcR0c5uEvAV0r8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

Hi Babu,

On 10/9/24 10:39 AM, Babu Moger wrote:
> mbm_cntr_assign feature provides an option to the user to assign a counter
> to an RMID, event pair and monitor the bandwidth as long as the counter is
> assigned. There can be two counters per monitor group, one for MBM total
> event and another for MBM local event.
> 
> Introduce cntr_id to manage the assignments.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v8: Minor commit message update.
> 
> v7: Minor comment update for cntr_id.
> 
> v6: New patch.
>     Separated FS and arch bits.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index de397468b945..58298db9034f 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -62,6 +62,11 @@
>  /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>  #define ABMC_ENABLE_BIT			0
>  
> +/* Maximum assignable counters per resctrl group */
> +#define MAX_CNTRS			2
> +
> +#define MON_CNTR_UNSET			U32_MAX
> +
>  /**
>   * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>   *			        aren't marked nohz_full
> @@ -231,12 +236,14 @@ enum rdtgrp_mode {
>   * @parent:			parent rdtgrp
>   * @crdtgrp_list:		child rdtgroup node list
>   * @rmid:			rmid for this rdtgroup
> + * @cntr_id:			IDs of hardware counters assigned to monitor group
>   */
>  struct mongroup {
>  	struct kernfs_node	*mon_data_kn;
>  	struct rdtgroup		*parent;
>  	struct list_head	crdtgrp_list;
>  	u32			rmid;
> +	u32			cntr_id[MAX_CNTRS];
>  };
>  
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 610eae64b13a..03b670b95c49 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3530,6 +3530,9 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>  	}
>  	rdtgrp->mon.rmid = ret;
>  
> +	rdtgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +	rdtgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
> +
>  	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
>  	if (ret) {
>  		rdt_last_cmd_puts("kernfs subdir error\n");
> @@ -4084,6 +4087,9 @@ static void __init rdtgroup_setup_default(void)
>  	rdtgroup_default.closid = RESCTRL_RESERVED_CLOSID;
>  	rdtgroup_default.mon.rmid = RESCTRL_RESERVED_RMID;
>  	rdtgroup_default.type = RDTCTRL_GROUP;
> +	rdtgroup_default.mon.cntr_id[0] = MON_CNTR_UNSET;
> +	rdtgroup_default.mon.cntr_id[1] = MON_CNTR_UNSET;
> +

Could these magic constants be avoided by introducing MBM_EVENT_ARRAY_INDEX here
and using it for the array index instead of "0" and "1"?

>  	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
>  
>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);

Reinette



