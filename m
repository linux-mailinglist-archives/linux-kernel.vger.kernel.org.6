Return-Path: <linux-kernel+bounces-333631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC997CBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34F31C229F8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D319F49D;
	Thu, 19 Sep 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NShsVyO8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F9119DF52;
	Thu, 19 Sep 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760108; cv=fail; b=ZhrY3vXNDZWdQsi4l8GuwsQXGvX08XMVSmc8wRmTrGdri+B1R62osVeN0Qm+cJLua6bvnloLZEzBqyB8BkIGQZ8ZDfrdhkLOk4GdbENnXrqBtTBu2UUk8AD8Md1ArsgOtb0xCuCf2NJtt0lCZ/ITF4ah9t6aJCrm8oPGpM8tVXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760108; c=relaxed/simple;
	bh=MHhw+uRxqxshc7Hx6Dn1vmz3vmDrxLevEpyvSeVWsYA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IbaogkHifUpz7b7Gz9uCNr8vedP2n8dPdoUBCSH1jcH7GLVIHcZs8dwzJn7hRYHuA0TM/YLG0cedNphN22uemMYVUIgNI/IJMl6rm2WizK3sko25a4fRlQrIiw+CqkP/H+hgwpo71+P6ky2tMMmmKwfk2ICfgPL7C85MlChpPCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NShsVyO8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726760107; x=1758296107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHhw+uRxqxshc7Hx6Dn1vmz3vmDrxLevEpyvSeVWsYA=;
  b=NShsVyO8l6Q0omBERWEE+Gq2Ua8Yta3fucNaj+RrvRphvtTAVuKq4tL5
   gClKE3F8c9gtgAIwvsqA8TvzfDe+hBeJwu4qOKISVR9RWib8kS4a5WpjC
   o7L2JFaoKHeZPpYvd6t1Tcsp3YxG8hlOvhYVEJsZwxsb4Je+KP4mYXzRw
   N1qk1CQsf0kzbP4MK1nZ8zvPlLe9EA2IiDOtUDi4l73XN6nTIvRnN7EyW
   gsqNYT6hZ9mMKeWJFn+FRcuHiLufvPIBPxkX3yMpXIRft4ILPeP7Xuvmq
   62gSMauHV+WXWWNyl58sWIJf3M+f6RWX5rCjOYl5bKMhZzrB0bCF3zt4O
   g==;
X-CSE-ConnectionGUID: OB20PtqZQg2WRmCUUn8DBA==
X-CSE-MsgGUID: BrwWfC5STjCW7fjkFXSRsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36319739"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36319739"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 08:35:06 -0700
X-CSE-ConnectionGUID: j1OpCQPARfCacvgNVonDIA==
X-CSE-MsgGUID: H606YkDwTpCe+I6ALIGiuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="69859177"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 08:35:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 08:35:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 08:35:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 08:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0TTGfZ4eJnueffuKwz/ayAGyknR4gf+dmr6S6QFaRSgbvw9unqa5C+Ui4HulfVhRlwrJl6zhnxo6vzjKgq7uyOcUq9uEoJygcP30oIO5Uptp2YaIcsmF7RBTkSmjpUqlsoOfk2w8wFd3IYNKfOE8h5O0ltw62m3al2+BLpRTNqVZahIa/2xwKabTcY1V7k0Qs++nXvxOVLu8GS/2Pcy+8LIJMeUPUhYBUPMmms1cAHx3V3/9XJwxGLN+2sls+MttCi4wGOvCEcDqv+o/wPsK4dwYFA6tpoTrruGACSxK4Ak7LmWQSB+4jxlHy9+GX3ZCdEBlxC4bnDQll5dHxNaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR+MiqiG6pefTReu3Msrv3971Bj3pdWMW/gIYany7+g=;
 b=QDyXCQ/rC6dIAYq/ayCpD6IxuYVfUzh1NIMYsJr+9DfISHn25HjC7l/p1DTJyyxgUmcft/CxtRZ/m3mOuO1mL9Fi49Z7CGVX7/FcQr09VKs8hI2CpV6ugFqXWtIE+czZpJcJv8H/LlYX8R118tx2d2aW9l2T3a2ZJDI2q0Z2kx8PFvScBCEI3g0jCbRMfFVHDsoUj2Bo21JYN+gLY45EaGgbMWDZWk9qRcVB29kILw5VWibvoDJfpTRlC5SsWHUa9wUXykEvNVV5uhnPZTGB0L+8NH1OyQNDBHlBJBCwePmX8JqoXgFQDraMrwnVKnof1YumRa55HZYuLrM1LvWW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 15:35:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 15:35:01 +0000
Message-ID: <e26a0a3e-72ea-4284-978a-5d00e2cff20b@intel.com>
Date: Thu, 19 Sep 2024 08:34:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] x86/resctrl: Implement SDCIAE enable/disable
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
 <d40df35b8f25b1ce009863da5b53f43640fb426d.1723824984.git.babu.moger@amd.com>
 <e85178fb-7258-4bd9-b9a3-0114c1c41111@intel.com>
 <88b93600-ace7-4a0c-a61f-7f11d3f38b0e@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <88b93600-ace7-4a0c-a61f-7f11d3f38b0e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ef093d-aff6-4978-d145-08dcd8c0a076
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmdxdjBITGIvU1BCeWtCdXdXMS9CRnpQS3B2Z3hOZ1p3Rnp2NmtZN2t3cndK?=
 =?utf-8?B?dkZuaitlK252cXV4Szl4aVNhUGpSZXphMjNvSU5QbWZnZ1VaNGx1d1lOVjZq?=
 =?utf-8?B?TW9uZ3FSOTRsblRwTFBxNE81aVFYMHRxUTRNY3Bzc2F1aVU3MFJ1RXBsMm1H?=
 =?utf-8?B?a3VaKytPTVFxSDYwcUxvVjFlN2V3VUNYYms2VVZscVZoS2dQMFVkSGtnZEZn?=
 =?utf-8?B?aTNHWFcwUXE5M0UvVEEzQ3RQYjRsL2lzaWd2aDlEZWlmejhSVHFSSk9VRzV4?=
 =?utf-8?B?bjRTZndUL2h4Qy9SWklVclFFeXZxdDIya3hobnZQeUd0TXRSbE5wRytzSmtk?=
 =?utf-8?B?MUJzcTd6NFBuaWwyRG5hZ3JMeGQ4aDhRZEo2UkZrQ0tKUCtieHNGYmltdTNx?=
 =?utf-8?B?RGd6bDM1MExrR2lsd3JOeThxTUVNT1pZZWkrYnFhVlFaMVJaTGJ6LzVMMU9G?=
 =?utf-8?B?dUV3TTZhWmtadjRqNGw5S2p5RWdSMlR0a0RadzVsdkJKM00zQ3lMMG1uYktt?=
 =?utf-8?B?RCs3a09hVGJ0ZXE4cEJkZExBQVdQbUlSbk5KZG9ieXowK3JsRDlXZHNqUlRG?=
 =?utf-8?B?bnQvUGM5S2Jod1ltMitmcllJOG5ILzdEcjRJLy9XWFUxeVROK1FpeUVyQWNw?=
 =?utf-8?B?Uk5ycjBycmpCemY5MTN0UEx4MGRYb1RnU0xvWHNENVkzaWtxeXhFaUJub2tv?=
 =?utf-8?B?dnlUdkVBRzlUV3ZSVVd6aXBicVpFQmE2ZnpuVFBwUHNlaldjNHQrOVlYSVBH?=
 =?utf-8?B?TUlhWXV2S3lZbkVxdC9ZRGt4TEpZcVJ4aStqc2dxMnlPaFR1VkVEdEtjWk8r?=
 =?utf-8?B?SU9mc2ZDeTdFYjI0cmxZdHgwZHloQi91RDVNMlpCdDNMM3IzVDdYdjlCMU8v?=
 =?utf-8?B?b0x5OUpYU0tKWTh5Y1ZVaHkwOUM4R1Q3anNEUFdZdjBSN21WVzlzeVlHQVhP?=
 =?utf-8?B?Rko0UGRXMzRNd3U3azNObzAzcnVJSUZCVmRRK0NxOW4yYnBEbStwci84aXk4?=
 =?utf-8?B?ZUhIb1JkWi80R2taSnB0M0hnZ055eTFwNThwOXhSV2g5ZVgwSnRoS2tkYUV1?=
 =?utf-8?B?MUQ2NGhnRk4ybjYyRktSTGRreVZmTjRMRG9wZGUyeWdXOUNaakg4R2xKWnQ2?=
 =?utf-8?B?VTRZb0tZVUw3azJQTHBRaWdpcGlpMTUyVmhjUHhSYjYwWUo0YlQvRG1Dc3JB?=
 =?utf-8?B?bU1ES2RubGwvT2g1QTNVOUp1ZVJGdTBIT2NxNm1IRGVDS1lvMFEyTklTU0pq?=
 =?utf-8?B?YVgraWNSTjlVMFBtNmRwVUFCRGxWaEdEVDVoRlBwR1VieEhRaEdHeVdhaDhK?=
 =?utf-8?B?Vm9mYWt5aUtjT0s3Z0xhdnFKUXlvU1hmenRyaE5MOHVvaEg5Q015WVJCbTg1?=
 =?utf-8?B?VmpYY2lwcDdnYkVaZFVxNlpDYm9kWHJ4N2VyaGRwV2owSVRoWTgxelFjNXl5?=
 =?utf-8?B?ZFk2ZGZwdTNEdFhzb25MSURSVzIxbnhCU005cjJMb1U3aWJVa0ZXK3J4RmJy?=
 =?utf-8?B?cThKeUcwakZoc2VxM3RObHZVSTBUUXJOYk8xbnlzM2V2VklYblBXcTZCRWpL?=
 =?utf-8?B?eGlPTGpSbEdjUjMvazNNdHpVSEUzaW9CRTdhQzM3cUdSMWRDTEdJYmRQaGNt?=
 =?utf-8?B?MTNONkpTdFdzSlk4eE94cnVSaDRuK2xLMUJmSEtsV2h1dWpQUEt0VTU0aE5F?=
 =?utf-8?B?Nk0vbW4xNmJVYjZYL01TZmtxUXR6SnFZRXpGWVQ5YXlmeVFobmN6OFZrL2hY?=
 =?utf-8?B?dUhlbzlhZ0RRVVlWa0tKT21ma1J2aGNabG9HckdXYVEwaFV1QnA0WXk1TjZa?=
 =?utf-8?Q?4I2XBrPDyApoAZB0I+7qDzRx+SnUSGu7ghj9c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlHdW9KdGpWSWdTeHBzNkw0M0plaXBwS2J2RktZM1A5OWNRUllrYUFyUFNT?=
 =?utf-8?B?UDFLQVBTTVBXMkovOGtnWDdVNjNYOGtHaHErS25odmdGZE1PTElueXhsRzNh?=
 =?utf-8?B?OFFGMVBnTCtHUXdKcFhIelIxV285eW12d21aZzI5NUMzaWNMa1oyMmZCdER4?=
 =?utf-8?B?SzFPWWFxS21udHJBS0VpOG9vUzB5WnR2RlFCK0VWQkZueDN3a1E3ZnpOUFE1?=
 =?utf-8?B?R01TTm8zeGw0Vm1vNll2K09hWFlTbGsvVEkrRWNkSVBucy9kT0hzVDVqTUVM?=
 =?utf-8?B?YkJhRkpjL0szNHRJVGd6eXVmSDVtUWRqdEt1U3gvZTcxREUycXl3Y2JEaTV0?=
 =?utf-8?B?TzlnRHRIczV2aTEyRjZIV3JlWGpEd2g0RWpObmZySU5OSjA4RzRqU1lEL3V0?=
 =?utf-8?B?VkdKYSszT0tRek5YT2JlVVNtWFkwdjZlK2hXRno2cUJsbmpSSW9JSDcxNHVj?=
 =?utf-8?B?OHVvS1c1Q3QvRzgrbXl0YzkweVNsN01pa2tkQ0R4ZXRHcFdNS0tqWDR6Yldy?=
 =?utf-8?B?d0NSUEVSSzNNdnNyNll0SS9tVnNLUnhuaGpVWlFZYmZqcmhySjNuZGZ4U3Bx?=
 =?utf-8?B?bEY0S3J5SmxPSFQ2SENTTFEzSmdZRnd3enM4VmcrQmRYN1VlZENSZWRvdU5h?=
 =?utf-8?B?V0U4cmpmN1g0dGxha0c2R3lrVGdNV3U2N3AwWVE3NEFWTHREYlhudWp2N2cr?=
 =?utf-8?B?RW5IVXh3SkNzZHFjOWpaNWkrd1duZWZEY08xM0x2SFBobzRjUFpScWZ1dnM0?=
 =?utf-8?B?eFJFcTd6ZEJaSjdEd0F1ZG04MXJ3OHRjdHA1QkhGNUxsN2o2U0NpSC9CblJu?=
 =?utf-8?B?ODZ0Z20zZGJZa3NJRmhVR0x5TGlITGFaYW1rRi85dE9YbFdYbENqUXdYNWVH?=
 =?utf-8?B?YS9zaDdDYnhpaE55V1N6L3JVd2VrWVdKdXdvTjVnVFBrcVVIQW1SWVo0eDhM?=
 =?utf-8?B?UVB1ZkYyTFBiN1p6dEZ3YTBtR2JCd2NqSXREU2h4clQ5Q0U2b0hwcXdYajkr?=
 =?utf-8?B?bngrZFNMR3VCYlU0RjNXdDJNOFpmeUxMTnpmL1VhNWwzb29hQTN3OVlGN2dB?=
 =?utf-8?B?Ull4S1l2NDVUR0hMOGtUWE9WVzV5dzNSSnZBdDBFVnRrRHdkZWd3RGR2RG1M?=
 =?utf-8?B?WmNyQVZyd2xzelhGZUhQd1puclJXb1RFSll2UDEyclNveFpDU3FIMHJOdlZC?=
 =?utf-8?B?SnhRalRuZ1RKSnhHWFplcTFmbmlieXdGZ2RIRk95cStZT0dEYU96Z0RvbnZ5?=
 =?utf-8?B?V0VuR2ZSRm15NEhCaW8vdlZHVjN2V3ZOZzRtT2ZVcFpkZFU2NDFpb0dSZlRp?=
 =?utf-8?B?WkpFTkxXR3NweWM5dWw1cmd3L01qbkJZRmFKcUhXM1NadGFQd2JwWVlYYlIv?=
 =?utf-8?B?RHFaSTduRVBJbzFiQzJLTW9DWGVyRzdQa1B4YzhDdHcraitwVmxVQk1HRWJp?=
 =?utf-8?B?Mk5aZEhnend6RHpWYW9tZ1N2YUZPM29QaTZZakxHUkI3VUc5ZjhRcjd4VnRz?=
 =?utf-8?B?ak5sMkZ3elVpL2FSY0FNUjF2TFB6TmgxY29rbmZ4Qi92RjFySWN3SndTQWcy?=
 =?utf-8?B?UTk1VmdMc1Baa2lld0Rpekt5Wk1nZzZLNkdwK1dmYndEZ00vbkw2anhkUG5M?=
 =?utf-8?B?eVQ4MjI2WnZqV3hQaGhESndVS1ZuQzFSd1ZyZ2ZLZDJ4ZVRJUmFzNU1IS3JB?=
 =?utf-8?B?R2RQa3FHbUI1UERyMDdPVkxNV1ZCcUpoWU5rbUNpcTllZ3pqaS8yVkhxWTNz?=
 =?utf-8?B?MjVLM0FkUDZKSFkxNjlCemRYTjhmOWxFdzVyMm9OYkM2QmYzZkt1TUhUWDhJ?=
 =?utf-8?B?TkZVdSt6YkJvRGF6QjNUbUVjdktNUzlBM0dNUE94dXRuKzJiRmpOMW5QMmNs?=
 =?utf-8?B?aVhaM2FZWWs3dEZ5cW1DR1U2UFhaMlJ4bFNRdkRuM1ZOQWc2SUhTaXdBUndL?=
 =?utf-8?B?NjZuaGx0L1FmeWxNUWUrWjA0eEN0eUlBQ0xlSGZZaWJ2K3Y1RUVnZFJkQUJk?=
 =?utf-8?B?RXdMYS9SSGs0WnVyTk9OY09sVkhyQ0tQd2g2Y1AxaGVwSm9TNXEvMFhQKzYy?=
 =?utf-8?B?L3dZeDBGV0FwNlB1SFFvY1BEZmhsSERnR1k5aVk0QVl3K2xxMittRmFTUkFY?=
 =?utf-8?B?Nzk2cjZDKy9RVE8vcXMrdGF0c09sSHBmb2pJWmozdGZQTDMveStaWkdsUVQ4?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ef093d-aff6-4978-d145-08dcd8c0a076
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 15:35:01.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dkw1dPa0s5l+h0sw4G0ZmsCCIWubfqLwRKjHs+skUHcAPRriC0tacpnI1MG03D/3l2ZHbwcRptDZSIH183tekigw9foCueyjTncw28YrFJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
X-OriginatorOrg: intel.com

Hi Babu,

On 9/18/24 9:26 AM, Moger, Babu wrote:
> On 9/13/24 15:46, Reinette Chatre wrote:
>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>> SDCIAE feature can be enabled by setting bit 1 in MSR L3_QOS_EXT_CFG.
>>> When the state of SDCIAE is changed, it must be changed to the updated
>>> value on all logical processors in the QOS Domain. By default, the SDCIAE
>>> feature is disabled.
>>>
>>> Introduce arch handlers to detect and enable/disable the feature.
>>>
>>> The SDCIAE feature details are available in APM listed below [1].
>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>>> Injection Allocation Enforcement (SDCIAE)
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>> ---
>>>   arch/x86/include/asm/msr-index.h       |  1 +
>>>   arch/x86/kernel/cpu/resctrl/internal.h | 12 +++++
>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 ++++++++++++++++++++++++++
>>>   3 files changed, 74 insertions(+)
>>>
>>> diff --git a/arch/x86/include/asm/msr-index.h
>>> b/arch/x86/include/asm/msr-index.h
>>> index 82c6a4d350e0..c78afed3c21f 100644
>>> --- a/arch/x86/include/asm/msr-index.h
>>> +++ b/arch/x86/include/asm/msr-index.h
>>> @@ -1181,6 +1181,7 @@
>>>   /* - AMD: */
>>>   #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>>   #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>>   #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>>     /* MSR_IA32_VMX_MISC bits */
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 955999aecfca..ceb0e8e1ed76 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -56,6 +56,9 @@
>>>   /* Max event bits supported */
>>>   #define MAX_EVT_CONFIG_BITS        GENMASK(6, 0)
>>>   +/* Setting bit 1 in L3_QOS_EXT_CFG enables the SDCIAE feature. */
>>> +#define SDCIAE_ENABLE_BIT        1
>>> +
>>>   /**
>>>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring
>>> those that
>>>    *                    aren't marked nohz_full
>>> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>>>    * @mbm_cfg_mask:    Bandwidth sources that can be tracked when Bandwidth
>>>    *            Monitoring Event Configuration (BMEC) is supported.
>>>    * @cdp_enabled:    CDP state of this resource
>>> + * @sdciae_enabled:    SDCIAE feature is enabled
>>>    *
>>>    * Members of this structure are either private to the architecture
>>>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>>       unsigned int        mbm_width;
>>>       unsigned int        mbm_cfg_mask;
>>>       bool            cdp_enabled;
>>> +    bool            sdciae_enabled;
>>>   };
>>>     static inline struct rdt_hw_resource *resctrl_to_arch_res(struct
>>> rdt_resource *r)
>>> @@ -536,6 +541,13 @@ int resctrl_arch_set_cdp_enabled(enum
>>> resctrl_res_level l, bool enable);
>>>     void arch_mon_domain_online(struct rdt_resource *r, struct
>>> rdt_mon_domain *d);
>>>   +static inline bool resctrl_arch_get_sdciae_enabled(enum
>>> resctrl_res_level l)
>>> +{
>>> +    return rdt_resources_all[l].sdciae_enabled;
>>> +}
>>> +
>>> +int resctrl_arch_set_sdciae_enabled(enum resctrl_res_level l, bool
>>> enable);
>>> +
>>>   /*
>>>    * To return the common struct rdt_resource, which is contained in struct
>>>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index d7163b764c62..c62d6183bfe4 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1789,6 +1789,67 @@ static ssize_t
>>> mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>>       return ret ?: nbytes;
>>>   }
>>>   +static void resctrl_sdciae_msrwrite(void *arg)
>>> +{
>>> +    bool *enable = arg;
>>> +
>>> +    if (*enable)
>>> +        msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
>>> +    else
>>> +        msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, SDCIAE_ENABLE_BIT);
>>> +}
>>
>> (hmmm ... so there is an effort to make the rest of the code not be
>> resource specific ... but then the lowest level has L3 MSR hardcoded)
> 
> Not very clear on this.

The flow starts with functions called with L3 resource as parameter
while the final function hardcodes programming of L3 resource
specific MSR making an L3 resource the only supported parameter to begin with.

> 
> I can separate the patch into two, one arch specific and the other FS
> specific.
> 
>>
>>> +
>>> +static int resctrl_sdciae_setup(enum resctrl_res_level l, bool enable)
>>> +{
>>> +    struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
>>> +    struct rdt_ctrl_domain *d;
>>> +
>>> +    /* Update  L3_QOS_EXT_CFG MSR on all the CPUs in all domains*/
>>
>> (please note some space issues above)
> 
> Sure.
> 
>>
>>> +    list_for_each_entry(d, &r->ctrl_domains, hdr.list)
>>> +        on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_sdciae_msrwrite,
>>> &enable, 1);
>>> +
>>> +    return 0;
>>
>> It seems that this will be inside the arch specific code while
>> resctrl_arch_set_sdciae_enabled() will be called by resctrl fs code. It is
>> thus not clear why above returns an int, thus forcing callers to do
>> error code handling, when it will always just return 0.
> 
> Yes. It is returning 0 right now. Keeps the options open for other arch's
> report error.  Looks like we heading to make this generic feature.

This is arch specific code though ... other archs will not call this function,
other archs call (to be renamed) resctrl_arch_set_sdciae_enabled(). As I
am looking at the ABMC work also this can benefit from using appropriate
namespaces ... only use "resctrl_" prefix for fs code and then this should
be more clear.

>>> +}
>>> +
>>> +static int resctrl_sdciae_enable(enum resctrl_res_level l)
>>> +{
>>> +    struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
>>> +    int ret = 0;
>>> +
>>> +    if (!hw_res->sdciae_enabled) {
>>> +        ret = resctrl_sdciae_setup(l, true);
>>> +        if (!ret)
>>> +            hw_res->sdciae_enabled = true;
>>> +    }
>>> +
>>> +    return ret;
>>
>> Same here ... this will always return 0, no?
> 
> Yes. it is returns 0 always on AMD. Keeps the options open for other
> arch's report error.

This is the arch specific (note the access to struct rdt_hw_resource) AMD callback.
The function where the return code should be maintained in support of other archs is 
resctrl_arch_set_sdciae_enabled().

Reinette

