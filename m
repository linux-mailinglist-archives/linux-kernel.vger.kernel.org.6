Return-Path: <linux-kernel+bounces-290344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD33D955280
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2237AB219DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4931C5791;
	Fri, 16 Aug 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXXcEkFj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19B2D02E;
	Fri, 16 Aug 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844228; cv=fail; b=DS4JMm/t/DyY5zfSMSTqMv3IDEgkiL3Y+WQOOKjfk9C0hz0sFLCVuDubzI995NoO0NHFjWsxygUHStHGiL0lOt4j1YFd+GI91YTHvIvyl9Cqa9AJwgBISvipGX9ScDD1sEyJb1X+HFNJGhywTt+7bFBt0KtGE394vUFC45t0CnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844228; c=relaxed/simple;
	bh=Iru1N8VP56e6Benl/Xs3lM7O1fcQ6jNUEfIp98moOVw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBKExAJyHvGpto+6bBxWesXSi++e0y61xPV5asxz2dDHb7jGyQh0zkiUpDZRuPFOUiJU9TX9ryDYhIx4T6tIe+6NIeeqdhQyzHj2wV/Edc0/0vTWAWrjYsgZ85+Uk944qVIgHvQ5puAt2iYtUfFHC3zztAC4oXd6fsYX4EzzFM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXXcEkFj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844226; x=1755380226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Iru1N8VP56e6Benl/Xs3lM7O1fcQ6jNUEfIp98moOVw=;
  b=PXXcEkFjU7NwALQkPBjFfFPhNdRdnz0Jf1Yyvdvgu2M2WVzkBoNvggRF
   KmOA8TAlQj+N2Iy727cqGxOfF9/luDg375oSK4tzEg68pmL547RXNao3f
   x3hxPbVwluviY4z4M1btOclRLvdNJC92TX5CjnPwbKDcCuvYi/Ne1q5sa
   s8zYBdDiLFHQz9jHsYjsdW/2ChOdUNT0snalC6O72fNV91TkPKYAPjZeJ
   B/GBquBgRn4ITFZHgW1cB3WtVTQ6PeXZDpuHjbNhqTD3mkcI/8X/1XczN
   Q/22Nv0IWk/UMDgVEQCjinWSKYTFpHpq77dJdRQrNEfK7Ht+YfOhMH/UK
   Q==;
X-CSE-ConnectionGUID: vFV05rjMQXqQvsC/t3EDYg==
X-CSE-MsgGUID: mhKlO/hJRgunC5sErkEt5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="39607884"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="39607884"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:37:04 -0700
X-CSE-ConnectionGUID: aO+WznybTreOXxPZKMswTw==
X-CSE-MsgGUID: SQ7yZYyvSdClmB8YdTZF8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="60335075"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:37:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:37:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:37:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:37:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:37:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5DRjB48d5bCF+g/OQrwNQZ4PW9fip8kv8Oz29t+YDffzyxAItqBxehpZ3CVghte4lgWxVWogi1vDzypk6NMpckiieCbH1Vr0Cm3U3Qrx0T+hc8E93SwCbiMjU8K8ztDxC6Un9ECZguFZTcI8tUG9qyz1WZQVCcqH6EZbM8nzNLvpl4jclpeNRLHVRby31LoCQ76tzGGIbm4F1O2/k+/FxIl5YvKPLhSeUBSzp5J9CwnMI7tMjpa4GdrXO2DxurJQDPstZAliugW74rfO8fBkZKJbUfMM5ze4JDkFhA2sI0psEeDe1izHk+BH/P6VF/4pbpQ6PTJ8VEYYsiL88MvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wrd20kvsIkfAYvRuAcpfh1XPpC3iKRqhsDmYAqnF4zw=;
 b=CtR+EagI7N6SALpZDBEFUf0+M91ThKjD4nGu321Nw+d+bYgrzOfEb5nN9mb8ISfHt93VQtXIYvORZdz4Wvwd9dFQ92vgD1G/TcIHi4VJYivcIXdz7nlFmHI57yu0pN7jHjItSJjVSGSWWEl4xWhTbhAZewTde2XwNLbfjE/+T48p9CD/ebP8bdakdD/MpdTkcJzeZm0ZeN2R67Ga3XXCBity9FNAEFFxYEXn8V344xDcvE2oD23IZiFF1fa/Iqkd3a2MfNVIlD3+bVedwFVpOSQC+QCj1SC3sKTzwxua3D4TLU3MLKRFHwinGWuda2MkkisY2af0E2sLXIgFGMT88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:36:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:36:59 +0000
Message-ID: <57c27158-13ca-4f79-9ff5-58033e3e3b9a@intel.com>
Date: Fri, 16 Aug 2024 14:36:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/22] x86/resctrl: Remove MSR reading of event
 configuration value
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <ce8ca46651c5488dff19ed59ba7c50009c90ac67.1722981659.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ce8ca46651c5488dff19ed59ba7c50009c90ac67.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a40a14-e397-46b8-7be0-08dcbe3b8f4c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2h1YVQ1V2ZsOFRKVVJTY0xSdXBvWWlpRTUwSUlNTXFLVHpsWjNnOGVuaUZU?=
 =?utf-8?B?ZGZHU1RHS0pwZHpzdzVHY20rRVJlaGVLM215RHYvNUc1QjlEN1BIeWZWeGxS?=
 =?utf-8?B?R09oM0Jwd2htcGMwY2tLckxoL3lQb3NPTEhlWWxkYTUraGxKQWlncTl0bUxx?=
 =?utf-8?B?NVFTYk8vWGZ0VzdBWmkvdlROcm1YTEpOMmtjZFBQUThOMjlmS0JBYXVYYXVR?=
 =?utf-8?B?RDh3RExHTGE4ekMwOEI1T2JPQnhmOUQvN3VqL1RWSUZuWm93QWR2TXlOY3lL?=
 =?utf-8?B?azNLR0RPd0VKejk5eER2eUNGWHZhVThEb1ZaT2dMQ1pRdFV1U2Qyc21QOUFI?=
 =?utf-8?B?T3FIUDB5dkVFeHlRclllM3FoekJvcnlBbFd3Y0luQUZaUFIyQzIzV3BvUWx2?=
 =?utf-8?B?QTlsOC9QdUdVWGljWVk0VU01aWpIS29zNjlacmhFQ1J4c0VXNlFjMUd0Vk1Y?=
 =?utf-8?B?WkF2MmpYT0ZEU1FRbWVDR0QzTE5IQW00eUpoQU9RNVp4SXE1NkZjdnpscnZv?=
 =?utf-8?B?STJYbXhNbk1Zd3lWMnM0S3c5VXdDTDFBU0xTYUxBamZaUUNQZnBmL2p2clRw?=
 =?utf-8?B?ZXkwRURoZmlRcTZUZ3FGMkkzYnFwMFEvL1NPazBvdTRMNjA5a29LYUtaZkxk?=
 =?utf-8?B?dUhhRmN2Q251aHdhK2E1NnYxU3V1bHI5cmhGanR4UjJYNFVxaHEzektmL3Zt?=
 =?utf-8?B?dk5SVlpKWnM1V1FLTjBBWm5DQlYxeUczR1N0cnUvMUcza2NUay9XR1p5bjg1?=
 =?utf-8?B?OVdOb2tVTnNLalA1WXRqNmRaM25DNjFJbk9iNjYwL1U3VXVaZThnZHRBL3N5?=
 =?utf-8?B?VzNudEZ6ZENkYmtJMkZHbjg4cXZsSDNDL0IvM0pJTzVMc3NZMnlRblFhK2VX?=
 =?utf-8?B?eHpiOTZmejIzRFk5Rm1TVXhldUMyS0lPTGV6VUliZTZEU3hZYlR6ZTdkQXpY?=
 =?utf-8?B?dmpubE9uamZoVmt2dy9heWVoaTNQV0tZQ1hFZkU2OWVLQ1NhenpGQWxmUEZz?=
 =?utf-8?B?Nlk4ZkI2YUJUVGNkU2hqU3h6MWxYUS9GOU93TE5CWURZUmxnSWV4a2RXTDV0?=
 =?utf-8?B?cmtaRzVqRmExQ21RdmVwd1BlbU5Qa0Q5NWg2dXZocVp1c3ZNSTNObURnYStZ?=
 =?utf-8?B?YmtZdTJoTnNOMmZkaC9LL3lKVHdEOTVyK0NianNmZVBsNmMrY3dWK3UyR0lx?=
 =?utf-8?B?cjFZQ0x2VXZLVGdRRFNUa3ViWmJrdVplK1grZXpDQUUyMzl1V1NFTExHVEJv?=
 =?utf-8?B?SVROU296a3dsNVFzcHZWUjA0ckJVNzhLUkU2ZHh0S3VUakdaNnpoalZnU2tX?=
 =?utf-8?B?bThRVlZFcWc0YU84YjlFeWFpcThUdGxsRk1DM2luU2lKeUFNQnp1ZjVwUFdV?=
 =?utf-8?B?cllWV1VrR2FLdjVkMmFNVXgrMm50UXF4Mm1rVDcyRFdiMVJabVhKQkpZdS9E?=
 =?utf-8?B?VDZVV1RkN3p1VzBFcDNTdzZzejFVa3hvenQwaHY0WGF5UDA0LzZFSDJiN0xh?=
 =?utf-8?B?UWZiYmFHQi9yNnRvOWdsaWxxdFFOZk5XWWtDdkFEdXZTWlRMbHZCL01xcStM?=
 =?utf-8?B?OTM1ZGhsRXBOcWU5UHNTbzU5blg4VFZHb2Z6bCtDb242b1dOVTBRMDFuWVFy?=
 =?utf-8?B?Q0lWcGZITm5mcHNxR3M1ZXVpSEU2UnVxQUdnc29Cbm5acGNIUGtGZnBzS0Fw?=
 =?utf-8?B?V29kUGMzYjl1UnpKby9MSk5ValJKZ1RDQzJ0YmIzcnJvR2hWUlJ5RXhJZE1w?=
 =?utf-8?Q?X6QX0OhR6qbs7U975Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K21UWnMwZlpYZ1M2eGU1cnJ4N0l6KzE4QlZmS0U5UFVKMlFnUGtvNXdOcXls?=
 =?utf-8?B?anNkczhjQURvSEVDRm4ydVo5anY3NnAvem5XdlA3QW9JdkxrQjZMajJ1NWg2?=
 =?utf-8?B?blFxMDJqeXR4TDF1U2JCOVk1SFdvcTBJcitkT3l5c29ZQktzMFRMc0V4cGxm?=
 =?utf-8?B?cSt1dk5XdnVaYnEzTk11QWEzbTljTlRBVndQUzE1QkYwZGZBd2RQRHBwSGJD?=
 =?utf-8?B?RmZoaXdKMytCbE9mSVhxenYwQ0V6Z3dTUkhSN2xydTJDbjBsUUhaREVsUktK?=
 =?utf-8?B?S0xnbjNvbm5xa0MvSk9DRExobzZXeTBWcEpTMDBCYnNqMEdmQUl2VGRHOFU3?=
 =?utf-8?B?OGlOSERFbmlPcC84OTdkU21YN2VIRHo2SG9ReU85U1QxZExpdWRmZlNkVlpV?=
 =?utf-8?B?cDFXc2crRGkveTJ5TFVVaXk0SytnYWxiSUVUY28wUVBHdmxSdmlBamJmc1lo?=
 =?utf-8?B?MUFKU2hYLzlwaEdZY25KSnBtWnJRaFhiWERmSHlEODQyTTVmZGF6STVMMG9Z?=
 =?utf-8?B?SWM3elVVaVF6ZUZWZXBzYnlGNzBZUzhjVEtOUmlzczI0bjkwQndUdzZaelpR?=
 =?utf-8?B?V1IwRGgyazlpZE9MVFlMNDEzSG5xWklzWFpXajAwYzhMaVhPN1FGUElPbUYy?=
 =?utf-8?B?aGs1NytBYkdlTzJFVzhaZSswbkgySXlrekFVNFloellFSDNTamtiMjhNRHhq?=
 =?utf-8?B?RlBaTCszaDZ6YXdub0U3T1dtMzB6WHk0VGdyUkFuSmdTTm82TFVjSVQrbVU0?=
 =?utf-8?B?eDVURnpwNUdreWZIam9iM2huZkVZZFJDUE51Y1JkWnYzbDk5UTJIVEZ5Uisr?=
 =?utf-8?B?SllaL1ZmVmdLTjE5NHA0cHhUTWF1VU9NN0RaeThRa1U3Z0RZcWVqZHY4M2x6?=
 =?utf-8?B?c0NZSW1MMndvZGE3Wmt1L00wMno4S1dZT08xZHU5Vk1QQ3ZSZEsvZHltYVo2?=
 =?utf-8?B?Mk02aXNFdlJZYmh1T2VmYXhUQlBUS3kzWkhFUkZlWTRIYWxpRGFCblVvb1Bp?=
 =?utf-8?B?d3YrMlVOVG55OW1TK1MrMWs5RzdaTURvTi9ubzVjdFRDZGovUkRxeHRwaERj?=
 =?utf-8?B?ZTZ0YXd1NHFSNXdzb0YvRFV2dTRlSTl3aGQyZERMckU2c0d3bVp0Mmc4MWNU?=
 =?utf-8?B?NjRWbGt2bHM5dWtSMmJGcDNUSlFnaXpGdkVUaDJJZWJVVlZoS0JhaXhlQ2Jk?=
 =?utf-8?B?YnQ1aFRhTFpJT3doNnF6ME95c21rSFR6S1NUY1FJN1VtMzMvYkFGWXR3UVFp?=
 =?utf-8?B?RlBGZ1pLRllueEdLZE5Qb25xM2YvVFdtVlR5eTlpaEZVT20ycmpvWU1PV2lR?=
 =?utf-8?B?TUo3bEJpVVYyVlVGa05GVHptMlIrakFKVzdqYmloSmJKQzZ4ayswUU84N25R?=
 =?utf-8?B?SC9vNDdEQjVLKzd6cVVtTExQdEk5TytRL0hsVnArdzBoVWJDUTQrR2Qxckpt?=
 =?utf-8?B?Ulcycmt4aXgvbFVJcllNYlhEZElQTk5tS1VmTWViNWhOeVpYbGZkRnpUaWJF?=
 =?utf-8?B?a2hDTVNLSy9GUG5ERnhFbzJ3cUxCRjJ3ZG5ZY2xCUVhmenBkZ2dJVTVFUWta?=
 =?utf-8?B?bjhGMzlEZ0NWaE82bGw0YVEwdW4zZ0tvVGZ2b2FtN0lTK2l4amZhQzduQ09z?=
 =?utf-8?B?czlVVFFFL016ZE91TzA1ZVVJbzBzdlkvOXpsWVRqOEhuU2lnbWRhbkptT29I?=
 =?utf-8?B?aVdodWg2R2pXT2hsQWZ5WjB3Q1RwdGZHNWp4cU8vYzF1eExObW9nZUgzOCtq?=
 =?utf-8?B?UjFBTEoyNGwrZnVLUVZpdjllUlFZT1hsSDI3QWI1U2F3NGhucjBuWXRKMi9q?=
 =?utf-8?B?TXJJL1pjVmFXU29BaVN0ZTlBWVRsWDVZdjVrcmlPRzcwbE1XeDJwM0lEcnZE?=
 =?utf-8?B?cnhOWXRSTmRTdDBFUlZDRUJsZjlMenBzUFRLcHFKVEZnZll6NU4vV0JOck0x?=
 =?utf-8?B?UkdrZ1duOFErWGloM2lwazgxZ1M4TXpWdjNtcnl2dGpuVUdhRnhFM0dwWUdB?=
 =?utf-8?B?MCt3amNSek9veVBFUUVuUmF0UVdtK0pNeVpDNXl2Y1dxK1RtSENDWm8vdmtD?=
 =?utf-8?B?Y2o4R3dEckJoQ1VNR3BybkNiOGdBZkc2SW9MWEtENnlkajlhVHBOWEJxcHNq?=
 =?utf-8?B?WE5La1JWS1hUMGpZSDlEV2JibzNPaExTcDRsTzhkSjk5a1lDbFpSSUU1YW9X?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a40a14-e397-46b8-7be0-08dcbe3b8f4c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:36:59.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTZaGV43uN7dH3pUh/ErDtsNprWNHCHADgZts4Qp+HvbUK61FGycIw/KslbIMWjN3/J7E8QqzWaHplm4fxrq0fVZ9ZsZ1DVFj7IHhkTQeO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> The event configuration is domain specific and initialized during domain
> initialization. The values is stored in rdt_hw_mon_domain.

"The values is stored in rdt_hw_mon_domain." -> "The values are stored
in struct rdt_hw_mon_domain."

> 
> It is not required to read the configuration register every time user asks
> for it. Use the value stored in rdt_hw_mon_domain instead.

"rdt_hw_mon_domain" -> "struct rdt_hw_mon_domain"

> 
> Introduce resctrl_arch_event_config_get() and
> resctrl_arch_event_config_set() to get/set architecture domain specific
> mbm_total_cfg/mbm_local_cfg values. Also, remove unused config value
> definitions.

hmmm ... while the config values are not used they are now established
ABI and any other architecture that wants to support configurable events
will need to follow these definitions. It is thus required to keep them
documented in the kernel in support of future changes. I
understand that they are documented in user docs, but could we keep them
in the kernel code also? Since they are unused they could perhaps be moved
to comments as a compromise?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Fixed inconstancy with types. Made all the types to u32 for config
>      value.
>      Removed few rdt_last_cmd_puts as it is not necessary.
>      Removed unused config value definitions.
>      Few more updates to commit message.
> 
> v5: Introduced resctrl_arch_event_config_get and
>      resctrl_arch_event_config_get() based on our discussion.
>      https://lore.kernel.org/lkml/68e861f9-245d-4496-a72e-46fc57d19c62@amd.com/
> 
> v4: New patch.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  21 -----
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 104 ++++++++++++++-----------
>   include/linux/resctrl.h                |   4 +
>   3 files changed, 64 insertions(+), 65 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 4d8cc36a8d79..1021227d8c7e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -32,27 +32,6 @@
>    */
>   #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>   
> -/* Reads to Local DRAM Memory */
> -#define READS_TO_LOCAL_MEM		BIT(0)
> -
> -/* Reads to Remote DRAM Memory */
> -#define READS_TO_REMOTE_MEM		BIT(1)
> -
> -/* Non-Temporal Writes to Local Memory */
> -#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
> -
> -/* Non-Temporal Writes to Remote Memory */
> -#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
> -
> -/* Reads to Local Memory the system identifies as "Slow Memory" */
> -#define READS_TO_LOCAL_S_MEM		BIT(4)
> -
> -/* Reads to Remote Memory the system identifies as "Slow Memory" */
> -#define READS_TO_REMOTE_S_MEM		BIT(5)
> -
> -/* Dirty Victims to All Types of Memory */
> -#define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
> -
>   /* Max event bits supported */
>   #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 02afd3442876..0047b4eb0ff5 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1605,10 +1605,57 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>   }
>   
>   struct mon_config_info {
> +	struct rdt_mon_domain *d;
>   	u32 evtid;
>   	u32 mon_config;
>   };
>   
> +u32 resctrl_arch_event_config_get(struct rdt_mon_domain *d,
> +				  enum resctrl_event_id eventid)
> +{
> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
> +
> +	switch (eventid) {
> +	case QOS_L3_OCCUP_EVENT_ID:
> +		break;
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		return hw_dom->mbm_total_cfg;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		return hw_dom->mbm_local_cfg;
> +	}
> +
> +	/* Never expect to get here */
> +	WARN_ON_ONCE(1);
> +
> +	return INVALID_CONFIG_VALUE;
> +}
> +
> +void resctrl_arch_event_config_set(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	struct rdt_hw_mon_domain *hw_dom;
> +	unsigned int index;
> +
> +	index = mon_event_config_index_get(mon_info->evtid);
> +	if (index == INVALID_CONFIG_INDEX)
> +		return;
> +
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
> +
> +	hw_dom = resctrl_to_arch_mon_dom(mon_info->d);
> +
> +	switch (mon_info->evtid) {
> +	case QOS_L3_OCCUP_EVENT_ID:
> +		break;
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		hw_dom->mbm_total_cfg = mon_info->mon_config;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		hw_dom->mbm_local_cfg =  mon_info->mon_config;
> +		break;
> +	}
> +}
> +
>   /**
>    * mon_event_config_index_get - get the hardware index for the
>    *                              configurable event
> @@ -1631,33 +1678,11 @@ unsigned int mon_event_config_index_get(u32 evtid)
>   	}
>   }
>   
> -static void mon_event_config_read(void *info)
> -{
> -	struct mon_config_info *mon_info = info;
> -	unsigned int index;
> -	u64 msrval;
> -
> -	index = mon_event_config_index_get(mon_info->evtid);
> -	if (index == INVALID_CONFIG_INDEX) {
> -		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> -		return;
> -	}
> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
> -
> -	/* Report only the valid event configuration bits */
> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
> -}
> -
> -static void mondata_config_read(struct rdt_mon_domain *d, struct mon_config_info *mon_info)
> -{
> -	smp_call_function_any(&d->hdr.cpu_mask, mon_event_config_read, mon_info, 1);
> -}
> -
>   static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>   {
> -	struct mon_config_info mon_info = {0};
>   	struct rdt_mon_domain *dom;
>   	bool sep = false;
> +	u32 val;
>   
>   	cpus_read_lock();
>   	mutex_lock(&rdtgroup_mutex);
> @@ -1666,11 +1691,11 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   		if (sep)
>   			seq_puts(s, ";");
>   
> -		memset(&mon_info, 0, sizeof(struct mon_config_info));
> -		mon_info.evtid = evtid;
> -		mondata_config_read(dom, &mon_info);
> +		val = resctrl_arch_event_config_get(dom, evtid);
> +		if (val == INVALID_CONFIG_VALUE)

Can this check and the "break" that follows be dropped? val being
INVALID_CONFIG_VALUE would be a kernel bug and resctrl_arch_event_config_get()
would already have printed the WARN. In this unlikely scenario I find it
unexpected that mbm_config_show() will return success in this case and the
below seq_printf() would handle the printing of INVALID_CONFIG_VALUE without
issue anyway.

> +			break;
>   
> -		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
> +		seq_printf(s, "%d=0x%02x", dom->hdr.id, val);
>   		sep = true;
>   	}
>   	seq_puts(s, "\n");

Reinette


