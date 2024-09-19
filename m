Return-Path: <linux-kernel+bounces-333630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD4397CB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83519B23016
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FF519F49D;
	Thu, 19 Sep 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9kPKH7j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5A1190477;
	Thu, 19 Sep 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760022; cv=fail; b=WBE3ZeXOCxS6Mlfk3TmHKk7G4oshzDp/mpQJfpaAjA4QqVm7NWIEqEoP7/OZ/ViRgaUVwFeDDuXO8tbC3a07CBCePVFgnxmgMpvXfOEzwmFXRkGxULYAKrhU8/aQblqg13QPPfNll5CEs5Az40Htf+lDV37jDlwcDBh57c7/M9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760022; c=relaxed/simple;
	bh=wqriQbYgdAKwGqcYtP1VuamO7wJ2XjeiGY6fsGijurM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tphn0pZkeV457o8ojlNwKS32hPPKKncTKi2q9Qmyw4dmdpOkEvT+RIGAkLxzvRcgtBxwZkTMItSc16shCBewhnbaYXSFYcnPPZbiTKFbQkcRTsd1YYRy2GQWM0+5Lrj4MJf6QzSoF4OjxP/tMaJqWL55tKyZOzofnHm7UKAktsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9kPKH7j; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726760021; x=1758296021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wqriQbYgdAKwGqcYtP1VuamO7wJ2XjeiGY6fsGijurM=;
  b=V9kPKH7j7S36QsVTrThbJMXNYHNOIt26nCTwAI6ehA48H9s7IzLklBb8
   uvVt+jI5LeEVwTNoWZN+xxnv0EpZt6w4qtryMcbWUNl1Xw3SQqNkPOo9o
   0HkJeX6oQAu8aerXSqF8l1915u0ivcUz7dyMxqASEeQ0erdYfV+9L/t9B
   hO1ETSguRhwVdRDKF+PbvoEPKpiD4ShwPaoDbepQ9WdlG2jm9AG3R1N8a
   QAydGawPMLY1v9n20QFaZ+ry2oZjjya8RAmqEIT7bnlQBn1/53uKmcHX0
   NQEJH7oS2LR8jXzrB91ydzNJkSqrYZm7jO3cfNerwG180zNm53fC+nX0V
   Q==;
X-CSE-ConnectionGUID: sSsMoadWRietJtKGSHSIKg==
X-CSE-MsgGUID: 7io8A7geTXeoI25ehtJrdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="43200652"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="43200652"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 08:33:40 -0700
X-CSE-ConnectionGUID: 0xyyFIpbQdeDTa/VTGnpkA==
X-CSE-MsgGUID: Lkxrf7zYTMmpF5yH/nLhtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="70427004"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 08:33:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 08:33:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 08:33:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 08:33:38 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 08:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AT1DQKviNn0c0QWZk/HtPnXMGNwqb0q4l10tEdJ2/PPi2GZUQgYS2HPPtvG5zeEl8AUQWBjJfPuV2kTNGxbCzvb78u1IFRIl7H5H1A5mnGwQFjX2BFzK+ZiBOQLmokjBvAFAsLtRRGbeIW3UACKdhINxh3gJPVL3yp8ifUZHrTjlmOqL4mtNmN0dv16bBQMTKu3PBpDSJ0nVjDlOIJF/M76ocj9k8pgg1cihD01521KjZjS6UBHIkhxMUZY05/uTid4b3LbqLO7jxcbZ0xJ6G9uDBZfjIW+La942kwCj+M9SIFBVouwj5JL2/z9ReYSYm0MuMiHgvw5CnpGuSamyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXfIXs3X6x0Vl50XJa9ER5f19gL6wkHS+sI7Ng1i07k=;
 b=nxtOxwvP+Col/TK1UME9OW+NNU9MRZo9alXIScgF7cl1Zca2oBXBXh2L72qYvRTtK6YH97N2XqoaxVsaSaZ7aOO7aSbdap3IjrtXuhMSPhyrvJVBK8ysInTQ03Wpall/BWMFhAifeAuHMS8WWGQAaWopVoPrq3Vv8DkGe+c3tZS2XrUqky9jdjk3kzn78SOVlJS9w0bR15P9qCYhq8FLmIBnNERPfUEEpH+Mov1Ns855xysR4eoJliikRvhwTcA6hos05FIWUz3hNwJjaaXeZDEiBZ8urtW9lNJSEcXkin2wPwZRsolwWqX0NI7ubUnn+VqdJT5K9twCIBah49zNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB5245.namprd11.prod.outlook.com (2603:10b6:5:388::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 15:33:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 15:33:34 +0000
Message-ID: <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
Date: Thu, 19 Sep 2024 08:33:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
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
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
 <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
 <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:303:16d::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d74bef-a305-4528-d0c9-08dcd8c06c90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGdLd0UzcFRqQTNqVEpEcHpBVE1ENzdEcEsyVFdlamVCcVBkZFlVTDNIMWF3?=
 =?utf-8?B?Wkk1Y2ljR3ZJL28rSU1LYnM2aHBnWTl0T0RLVlg2VitFMEx6emhoSkd5Qkkw?=
 =?utf-8?B?NFU0emQ3c2o1Y09waWw0bzFmUDNsWXB4OXROOHkwcTlNUjFwTzNxZkswUjEv?=
 =?utf-8?B?Q1dYTGtsbmhSWDcva2xKUTVwa3Bxbmxsby9MbzNoanlQdHJpSDdGbnowa0ps?=
 =?utf-8?B?K0tKMWV1VFNpalVPWXNHeVJWYW84Slliclc5YzQyQmxhbEtUYnlLcjFkV2l4?=
 =?utf-8?B?bGsrNEpaL2E5ZFYrTG1vOHA3QjcrOFdlcEdFNHIvZSthc2pzV1M1OFQvVFVU?=
 =?utf-8?B?bHExOWdYSmJZVG0rN3NoQ0VQSkpxR2c5Tmg2RnZjMjdkclV5aWthNFhTTWRv?=
 =?utf-8?B?MHV6MEVwWEtsTlhFNVdpUFRobHZyNHJwazQ3eTlnVUdmRUFaVXltdit5VVVu?=
 =?utf-8?B?NU1yaVd4bEtwZkwwWG1zdmRmeGxvcGhGNG5YOFVrV2lSUzFEUmxqQ3JQaHdE?=
 =?utf-8?B?U0xqcEVBRHFyWkY4aFRHc2Y0MGVFcFhYWVZQRVZ2UXdZaE5qbDVMSjRYSC9T?=
 =?utf-8?B?Zk1WL3lPb1VPelphelFxb2oweE9JSHJuL0FDeExWdHo5bHlVWjRkV2xiUDNL?=
 =?utf-8?B?TExmQWtxc25YN3NxRWNLQVVDM0hGdithUzVHd0kzUWFKaDJMNGdkZlpsY2s5?=
 =?utf-8?B?YnhSaGlXNGJ2bGorNkQ1aVdTSGd2ODZwS0Q4VUpUZXZxYVNnSSt2cmE4N0Yv?=
 =?utf-8?B?eThpR0dtZzdaVi9nL1R6YkxDQXMyOXl6MlJYejdkVzllT0NabC9PUHI0ZHdB?=
 =?utf-8?B?UzJvS2ZQZnhySVJUQ3A1UnNnM1V5TklMbGpOV00zL2kydFZWNU5BM0crQUtw?=
 =?utf-8?B?RzE5c3NSNUY0aWd2SE8vZ25tclMrT05ZbDBBR3BSNEdRdW5YT1Y3WmJWU3lw?=
 =?utf-8?B?cE5EdkFuRFZUVkhrbHRYYkZ3eTBqVHdQNG1iS2xsWnplV1JnSDlobkZGb09U?=
 =?utf-8?B?RjFQZHRZa2dZV08rRGszRmZUY3M1OE40U2tKY0UxV00rK1RNU04zYUNuZW1N?=
 =?utf-8?B?dlVobTllS0o5dk05NGZRYXlJZFh4anA0UnAxSmY4enU2RVRuT2ZiRE9jVEdr?=
 =?utf-8?B?K3JxNU1TeWRLSkVONmJSZE0weDRXRFNZaVV3VmVQNS9haWQ2ZGVScDJFSlk5?=
 =?utf-8?B?ZDdZdmtCN2ZmMWI4akd2L2JQS2Z3YnlkdVJhK01wZlUrdnJEWlNpVlZaUzMw?=
 =?utf-8?B?ZjVHWXFMa1hYcHpyR1JLTU1JeUtGSGVQenc0RVhkTEJ6TWY4MzJZbGRWUkdu?=
 =?utf-8?B?QjlrQnFMellyTDNYUzJLLytobHl1UCszOTNTTm5BZDU3eE5pZ3dSSFFsUXJF?=
 =?utf-8?B?cFV6WEJoamlxeWpjUUtlNlZCUWM5L0xuZDJFcnQ1NDBtQk9vWXBXdzJkYnFU?=
 =?utf-8?B?cEYydytMOE5yMGxSYXVlYkNRcWpOZWE4TjVhZWdmK01wcWNTUEx5S2J4Vmpz?=
 =?utf-8?B?TmhyVldnT1RpWWJUVFRmbzQ3Z0FXSmtXMDVrQVZtT0tmT3g1MFMyd1dWMXNP?=
 =?utf-8?B?NGkxVzdnWkhYY01ndlBUcjNKT2lDNnJpRDlLUlRDdmRudjJuS093cHdDNGh3?=
 =?utf-8?B?UnBDOWhHdHdYTFRyKzd6b1dHNnd6RmFyL1FlcFYrOERjNnRPQWNNLzNtSUFp?=
 =?utf-8?B?bFhXZDFaQTM0RVNhdzJubkxhWDFvZzd0S2hOU3l4WFgrSFZ0NVJiaFE3azhu?=
 =?utf-8?B?clllOGR0Y2RkcFUzUkRtMFJQNVBZWlk3UHdWYUJuK3IyZHJ0ZmwxcGFTeHh2?=
 =?utf-8?B?S1JmNVF5SkxCNjBkZFJNZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHNha1BMNGxlOVQzOXE2OEFFTGtPRnUvMkplQVFHVy8ySUVFZnc0TGtOZHBv?=
 =?utf-8?B?TVowQUpPSmg0aVR2bjBwTjRtVWJOc2tTWjUwa0RzcjJXUDE1STJtdktnUENB?=
 =?utf-8?B?VWFHS2lEeHZMRDkvM2w5TzZmcTUrSmtGWWtsU0w2dEc0ZXlzSHdlVytZYnU0?=
 =?utf-8?B?MUhHakIwRkdFaVFCK1QzTFQ0Y0hIQkwyUjlHRTByaUd2L29nMU5adTlKVEpE?=
 =?utf-8?B?SlRqR3ZlZm1pcktjQk9FUjhHcHNOcWo0bmFqY3hkVUJmZlhRWENmRnU5RWZj?=
 =?utf-8?B?UzA5Y0ExRjBURGRhSnIxT29ZY0ZZU0RMRUJ4bFlGem1ucmI4Tmt3UFdOOW5m?=
 =?utf-8?B?K0g1dDhqNmpGZHhUVjdDcnBxS2ZBMWIzL2ROcG0xQVM3MVhQUnM5SG9EUXhp?=
 =?utf-8?B?cXR2eHgzc1A4NTlxNEVQbnNYcnZ3dllOZHBuMkozSytsTFZzY2M4SGx5bmp0?=
 =?utf-8?B?UGxqcEwrcTBIZHV0ZU5WbDczK1BZRTltUFZvMlpoNkJ4cTB1c3hvekRMWElK?=
 =?utf-8?B?Wkt5QkRqaHJWdUJ1RDN1ck9zdWxkNnUvOG9tVHpacktoNWlYbzF6RjU3WGlM?=
 =?utf-8?B?T3JhL3JiUENFdytFN2VhNlZzdU5aalp4NnpRbmwzTHBKRmJTYkNrNTdLZ0h1?=
 =?utf-8?B?eC9mRUNTdGVSV0p0WGRHd1RYV1V6bDYzYkVReFd5bnJSMVU5NUNlSnVxSmVO?=
 =?utf-8?B?R2h4cndiN0t2Ti9Kclkvcm9BWU5yUTNlUG1wK3pvVHU1cHdxbk5qa1ZaR1Jo?=
 =?utf-8?B?QVpPWjdoOFZ6b1h3bmo1SjI4MEpZRjhFSjlXSHk5cC9HdXFnM29TWDhuVVF1?=
 =?utf-8?B?dVNCL0ZNUS9nbXZ6Rkwzb0lid0tHYVl2U3VndUdHNXNzNVptSVJTTllKdCtv?=
 =?utf-8?B?c1VNQ3d4ZWkwSElITWVzVjltUlN5a21RdXN6VGFTenRMbDVXQlMrRW4wa2hy?=
 =?utf-8?B?LzAxSDhlcnFwKzdTSlNFVjBuSHRFam5uT00yY0E2Y28vajA2bldBMHRSRFV0?=
 =?utf-8?B?R2xUdlh1WXVNRWxiOEdmVXQvamVGOFNmTkJnYmxZLzZya3NBK01idS8zNmdG?=
 =?utf-8?B?bVpTbUg5MG1YeTdYanI2Nzc5Ykp1TnQ5aVpYV2N1VDFnZ2tFZzlHQ1JGVHh0?=
 =?utf-8?B?WGQrbUFwRWZPY1M2NnNhb1k1YlFSck9WK3BRc3BlcU12QVBndGFTZGxlMkhz?=
 =?utf-8?B?d01ITTJPY2NOZTB3L0xMMW43Q011UHdQMEMxYXhYZkt0NUNrQUtwWFpVQ052?=
 =?utf-8?B?MDg5SXZRZXU5cFRVdEJ3TU5SblBLckg4bVVPbC9zcWp2VmxrQmgzeUZpZ09L?=
 =?utf-8?B?UGZlYytJc05xbjVNK3pnd3hnb0Y2Z2x3bU9UWG1BRzduL2hIYWJZQ1pTZDRJ?=
 =?utf-8?B?ZmcrZXBJVS9ncWwvSUxwSVVFN0RoR3M2NHM4NW5CMmxVUjBvbEpOckVQaFY5?=
 =?utf-8?B?Z2I1Sm1xMXhVTXlTMEZrUVdYbkRXRWRnSGR0b3Y0TWFJZGNWVW5KMG5LOWNx?=
 =?utf-8?B?NTIwaFhkMW9IZnJrNkJOQ0d5SjlaUXZ3dVhvV1lkZ0VMV0VWTDBsU21QeW9P?=
 =?utf-8?B?L3ZORkNSeUNVeXQ1OGtQZUNMaFJPUmF0OVU5dExZNHliVnhTNzRnUXRBU1Iz?=
 =?utf-8?B?cFJKMEYvSmlWemVOZnNFeU5sTGhqdTEvZEtzSE9taHk4RG1ydXNrVFBPZXds?=
 =?utf-8?B?R0R2WnBiUUFuRFJKeCtKbm5lOWJ2YmxGQ0lNMTdlbXdNZkpHeFFvVmNZc1Zz?=
 =?utf-8?B?UXV6UEoxVDFOTzhTa2VhbTErYzFrVExDZVhSY1U5SDNQdWEzOHZ2V25zV1pU?=
 =?utf-8?B?Y3BvQWM5MlZmbGU1MjkvWlVrcFY0ZE5pZEVEVXJwdTBwKzBUZ1dkZVE1dFk0?=
 =?utf-8?B?bk9FbmpTamp3NVFaeGlrZFZoenNQVlBhUjdUdWtFQTF6L0lkRUcxeURmUkJS?=
 =?utf-8?B?ZytSVXNnK0Zuempsc0dBQ3Avb1U5cmh6SkdBNmFGeTFueGIwU0RkM0x2ODI3?=
 =?utf-8?B?U3ZDUmhkNVlOT2t6L2tPbGVCNk9sS3FpUGQzdVJXVkZiSS9tMDloNGFQU05z?=
 =?utf-8?B?LzRXWXF4WXQ2dU5qU1ZPNWFNZ0cvbWZ1aWJ4ZitVekorV1dYaU1mMjRVWkhD?=
 =?utf-8?B?UVRzVnpnTlhFeU5SR1RERzFadkVzOWV5TVRhVFJxaWJsbzNkRUp1OWhDVXZr?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d74bef-a305-4528-d0c9-08dcd8c06c90
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 15:33:34.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLyMcCHVmV/n6eGfmeScFTGSnGwtOEsVQ3R1uPaUoNS4GirOj88GLOuXGJPRYpIVE/gboJt6uz/jwi5k2pbAborO+UJssPxQgWe7oCndBCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5245
X-OriginatorOrg: intel.com

Hi Babu,

On 9/18/24 11:22 AM, Moger, Babu wrote:
> 
> 
> On 9/18/24 10:27, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/13/24 15:45, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
>>>
>>> (stray ` char)
>>
>> Sure.
>>
>>>
>>>> feature and initialize sdciae_capable.
>>>
>>> (This is a repeat of the discussion we had surrounding the ABMC feature.)
>>>
>>> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
>>> becomes a resctrl fs feature. Any other architecture that has a "similar
>>> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
>>> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
>>> needs something generic that could later be built on (if needed) by other
>>> architectures.
>>
>> How about "cache_inject_capable" ?
>>
>> This seems generic. I will change the description also.
>>
> 
> Basically, this feature reserves specific CLOS for SDCI cache.
> 
> We can also name "clos_reserve_capable".

Naming is always complicated. I think we should try to stay away from
"clos" in a generic name since that creates problem when trying to
apply it to Arm and is very specific to how AMD implements this
feature. "cache_inject_capable" does sound much better to me ...
it also looks like this may be more appropriate as a property
of struct resctrl_cache?

Reinette


