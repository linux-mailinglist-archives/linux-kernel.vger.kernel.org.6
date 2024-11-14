Return-Path: <linux-kernel+bounces-408718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B49C82B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBD2282BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41CB1DFD8C;
	Thu, 14 Nov 2024 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMAdNxa2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A3143744
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731562844; cv=fail; b=XzH8/6Jt9IKE08XuA0yW07mrz2z54jeu9Z9XgOGdz2SG9Fc+tLdUpv7lu+tNwOzSK4FqRggGfj3DU3xUIO/zbU0cEnyW2X4apQBmAI49RRZgT7Wpa3TD7Ps8EAhz8Gyp2qSUaEGSBfH1W6VjFOMr/BXCmSj65aJA1nf+FirhI9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731562844; c=relaxed/simple;
	bh=vvPqKCS5nzECSZbeESLiSqgN99O//hfQwa+9PQOHGh8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I81wXgBpI4s1QuYDYW9H01jFOqV+N4gYSR2LiAVUq79zzO3Bah0uT+89KKydQKZMsvnAXi5B2665upSqdTaQB9wwmsOZ755MpQJFjgQrTsctyO16g/qTpIPd78N+J/vrL5RFQx5mCY0pkwJIFaMS0lhAvPSW5JZrlN0cL9kTS8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMAdNxa2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731562843; x=1763098843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vvPqKCS5nzECSZbeESLiSqgN99O//hfQwa+9PQOHGh8=;
  b=cMAdNxa2yKOrk96Mi7/4Uge3FuYTwphZmZc+0d7uTTOdwgRbmg0R6qt0
   E3x6Zt7S3vfdXI9Ns8WbET0Ths3D7kDCwHh2uA3fhFgslIiWqo38XbfWT
   OCz4o8DosFPQ5U/M2QZvHLiaCTzDrFu7dZtx0OCXLEqqvYRYBDEy6tDaU
   kk1lFHa32/2sr5hy7miMEqtlVg7wdblCcnUBbt5ZHLwOb000SXeAu5Vku
   nKa4I1b10FPC1qsWsAuih5mnLIbn6xVTIPsSe5AFZgcA8wUvWR6Xk9K4k
   zM1aN6y/IkUvjMp5HEsEaj5WFbTTZ7y2Vmq6KFZjXKAoqICxIjr2SQSuL
   A==;
X-CSE-ConnectionGUID: HVmpx7VUQHu9mgYorZkk7A==
X-CSE-MsgGUID: plgLWVxxQkaxP9SlOt+mEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30869518"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="30869518"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 21:40:41 -0800
X-CSE-ConnectionGUID: TGqGKUDGQzOTpt6P0rn9cA==
X-CSE-MsgGUID: fWAwZ/aKQfq1dUk0FT5GRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="92893428"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 21:40:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 21:40:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 21:40:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 21:40:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSamKPFwK/Z1yHGoJawR8vjTQft3ZucCv6/kh44+6yYuYRBUH5Me8UriiMN+C0r9Id7Lq/UZkZ8I5K4FkJLCsXTcB0G0ExRCW4yhKn5ZjjH8gxabRm+ArfnVoyUJfWj4ys8dtMnnfNHIfvQ8ZlTG+XNT/9/VKDBWxExxfFAq1H2SmX0n9s4SZAybn5/shfhkB+HrQfNUx4uGhrihPJObmXRGnb+XFnWduVbeaCrJD3Z0MPToh6IsDq0UaAxcJGOgD9Ho1CmhbuFcw0HG5S1yqB3n9ke8cYEqHNrW3XOQD9nldI+FOmXO6TmO8fF/PR5EhsbQE/ojQwbu7wWAmoJm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWFL5cuLlwWCitwI2ClkJbDdZt/G7yp/JmwX2lNz0z8=;
 b=c/99vj4TYMnaAXY31xslc7exs2wUfCm15sUtPOZX2a05bnf9mpgBhj0sFa5gAUeauCuzOwP8oZwTuINPrgT0Vqdt9tPV3dOBvJ8tJhSEJPKbbIID+HzlQj0tXecG5PHh1Y8sqwGfl972kLTM1P1fqhq9GKwLqtkTGrmNYyPVPjZEcpjj6NAWA+M7hTzOxOAjKTdY5+HPA7ctN4LDmO9KYOj+6bid3GTwcA1LXYgKX2PEBM0Ev1Vb6PymDzJXh3aNiruMJu5I1YAO03yWkK0ERURAnr5nNHc+V/EpWTcc8oDvnEEWLltIiaVsRaEMB3HdMClef+b19dzVcmU8xqX/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 05:40:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 05:40:37 +0000
Message-ID: <7ee63634-3b55-4427-8283-8e3d38105f41@intel.com>
Date: Wed, 13 Nov 2024 21:40:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: Peter Newman <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <eranian@google.com>, <hpa@zytor.com>,
	<james.morse@arm.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<nert.pinx@gmail.com>, <tan.shaopeng@fujitsu.com>, <tglx@linutronix.de>,
	<tony.luck@intel.com>, <x86@kernel.org>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <34fd8713-3430-4e27-a2c2-fd8839f90f5a@intel.com>
 <CALPaoCjCWZ4ZYfwooFEzMn15jJM7s9Rfq83YhorOGUD=1GdSyw@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCjCWZ4ZYfwooFEzMn15jJM7s9Rfq83YhorOGUD=1GdSyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0306.namprd04.prod.outlook.com
 (2603:10b6:303:82::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM3PR11MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba2e794-a332-4400-41fb-08dd046eddd4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SC9wSFlpUS9vSVBkOE5XRGlxd3lNa3NmNStycWxXaFAwSFYvODdkNlFJd3JZ?=
 =?utf-8?B?Q2tweXZNNzdTL051ZWh6Zk43dHg3Vm5OSTcwNkpHT3N6ZUE5YVAweEhLVkdG?=
 =?utf-8?B?NGZnNmwxalRKaFhpQ3pucm1sMzNkdWc0YkFIcEozNGs4L3lMZFZuV2U5Lytk?=
 =?utf-8?B?b1VtRDlxd016MTlFdGJodTJKNkhQSlhxQU02d3NsdE5SKzUvVWFselNJcE9s?=
 =?utf-8?B?Ylk4Q2t3amkvQ294WTZPbTlLeDZiWjNJTzVERVVKRGFoOTZhbVdIdDR6bmFj?=
 =?utf-8?B?LzBvYzhLd05LVmR2Q3hTaWR5ME03V0Y4eE1Fd01qd0hJTEljR3lSYXpoUnpE?=
 =?utf-8?B?UkxnS1JQVmw2M3paOFR2T1FYZUI2bGQzZXViZ2xCN2xieWF4VlE3UnN5THBE?=
 =?utf-8?B?WXlzTHZtWEFWcVJZeUt1THZwenRIbmVSeENxTHNoV3FLL2RnK0UwNS9yWEpB?=
 =?utf-8?B?R2hWQzBNdVN4WlUveG9zNmprV0cxSFhHeVFYb2NRek1naVV3VGMzOVd6dHFz?=
 =?utf-8?B?TFNETENOc0taREdvQWs2M0pOZ0xkS0pMaXgwQzVNSmtqbXVGU3UrK29IRERO?=
 =?utf-8?B?dkFqajZtWDhoN2RRaC9ZN1Buc2k3KzNtVFkvNC9KOGZyVlZnSVI1czhTZHNX?=
 =?utf-8?B?NE5QTDNnN3ZTTnUyQWduVUFOcXMrWVduVDFwcVJWNXdlYWo0L3VFSCtxcDhx?=
 =?utf-8?B?bHhUcVRrUUVBcjAxWVN6TDRaTnlqbi9hekNaeEZydnQySDlqemVqa2ZQbFI0?=
 =?utf-8?B?aEgvODRSa0N4NDBLQkg0VDNHRGc1RTlJZXZldlR6RkNmNTVPbFYrRTE5VzlN?=
 =?utf-8?B?NDEyQWtNRGV5SmhONzJsMi9zWEM1aVU5N0lveTc4Uk9IbFgydElWaTB6cUk1?=
 =?utf-8?B?Ny9ValB6M2tlTlgyS1gyVE05dmtxN1ZWNlNXT3psZEZhUWZ1OFZTQlc1cngx?=
 =?utf-8?B?RzJlOWZ0OGlqR3BDYU1id2tNaWJNdTgrbFRyS0luYUdNQ0p5UHVFNGo4Y2w3?=
 =?utf-8?B?dGZVdGswbkh2VUF6SE9ialR5L3pSKzRXVExvb1dDL3lvVklrUjVHaXdVWlIv?=
 =?utf-8?B?eUord0xVb3ZiVWR1QmwxMlo4MkFPbVZnNFJmY2NPTGpmMjUveXA2MG54N0ZO?=
 =?utf-8?B?T2o4UytEbFQxUTN5UHlkRVhFMGVsOHNsQzlQYUV5dUs3VWJDU2ZOSGJzY3k2?=
 =?utf-8?B?b0w3UGJWU1N5VFBpTXZ1THVtbys5R0xlUVk0dTVvNHQ5bTZZQUdFdE8rT3F0?=
 =?utf-8?B?b05qMXIxMU5Danh0T1Nldzk5cThNWnJWRjhMMTJ2WVg4OEJHNmRVUWk3ZzVJ?=
 =?utf-8?B?NjloanBSMUg2SEZoblBxeGpKY2J2UmZBbFZLbU9qNmp4YjB0RDBQOU1UR015?=
 =?utf-8?B?SloraStyUHFwZ25ZY2paTVZKT2xmeHluUjZIRXNSbThhLzJvT3hWRGtDNFpS?=
 =?utf-8?B?R2FHL0ZKQkVUQitLanEwUUdjOFJCbzFNV0lCQ1NNVC91Sm5HRjMrK3NXWWRM?=
 =?utf-8?B?M0tnb3pxelkxZzZNbjRzTHlCOVljVmRCeXBlS0lwV05iVUJXS29MWkp5bDRw?=
 =?utf-8?B?T3NybjF6V3B4SHBNYnpHQkVHalg5MlNsK3BkK0NkbkVUSzFlNjY3dzBYaG9C?=
 =?utf-8?B?dzZvQ3Y4MFJJR1NiSDdocDZjbnRVQytnMlJjZENuNFFYMnBvbnJzNDN3S095?=
 =?utf-8?B?emtHaFdQaWgrTlMvc00yOEFUcVRJM1l3OGVnb3gxOUhVaTQxR0RnakN0Z25D?=
 =?utf-8?Q?TnxYizGPubgf3StbnDW3PLsBWnAwa5Lnmd3VsTi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXducXdEQkM4OVNMbmFyU1I0cGlLWDUzdUszNjhmdTNMVDAzV2pVTzN2QlUz?=
 =?utf-8?B?Y0lRV292SUNWODYzazlTcFUyYzVDZHdVSHZUZDM2VnRLbmM1ZS9XMlVmN1Z5?=
 =?utf-8?B?QXczNG0xcjRGSS9LdnlMUUIxNGZvWVEraWxpMFh5SkMyNUI2NmxDYzU4cmcy?=
 =?utf-8?B?UFlBZDlEamM2R2ZKTklwbitYVGxNdGl5ZXJQNzFvaTVuVlA0T0s1SUFydVZU?=
 =?utf-8?B?bEh0Ui9Tb1o4OEJCTzFhVUNYY2lxUHpWNmNqRlZQVGxRK1FoajhkQ2E4NXVa?=
 =?utf-8?B?YnBicGE1WDZpbHdST1NJS1hEaTFvMkhjMmV4ckJzbEJzTThPbFE5TFR2MHMz?=
 =?utf-8?B?QklPbjdLcU5Jc0VDTkZoa1Mrb3BZcFFGdnJUZ2lNWkpZb3hDeVdpN2IzNVBV?=
 =?utf-8?B?ZGMzcWhHbGFWUjkrLzRWN2dBa1lxa0hETzQ4T0hBbTdLV0RpVmhSVWV4TUNK?=
 =?utf-8?B?QlZocXdtYjMwUkdlUitEY2xseGVTenkvc1EybWFjL0tzZjE2TlNrTlA1OGwz?=
 =?utf-8?B?dFQ5RU5CZStIRmU0Ni9wbUlqTFNpS1B3Q1RNcEd3WHVrOUkvSFFid3lrdXAw?=
 =?utf-8?B?Nm84eWFkbnNYbmlTRzlFYmsxamtRL1VDWE04d2FTVXVsK0NCSVNyK3c0cCtu?=
 =?utf-8?B?aG1mQXNYNy90RENaenk1UEF6bENxazh1eEZ2Wis3d3JxK2htdEdjREtpb1pU?=
 =?utf-8?B?bUtXbHQvL3hOV016NlQ5R3BpWnZSQW5kc1lOS1ZlTmRDcnVFYkJTZms1TSs1?=
 =?utf-8?B?dE5URlVSQzNxUVlQcEgwTzhEc1VsMG83MWxxNEU4WkM4N0xPQzVsZ3JMZGd0?=
 =?utf-8?B?K3lKaG5OTlhubysyUXV4M2c2ZU1kTTBRRm90NW9KVXZnYk9Rdm96L3dmbUR4?=
 =?utf-8?B?eGNmMVlMdDMxK0lGZ1NENzBGNlNWR0xOZHJQWURmVzVyaWREcGwwdXBkSkxH?=
 =?utf-8?B?MmkrVEVFd0JsbUxWMFZNckhJZ2lFbExxek9tVlFzcEltbmFGVFRGODk0OHlv?=
 =?utf-8?B?VTVVMnBSdmVLZnBaemJKSnJGTnlLNy85cm56OHFPckxnN1J4TmY3bzVSWU4v?=
 =?utf-8?B?R0lhODBYTmM0QU1IbnlqL29pa1d2U2RiTXFBN3lDYisrdHdNNFpJL0hRSi81?=
 =?utf-8?B?eXg0RUdjRmM5L0xEajVVQ3BYcjJVZmg1OE5xWXE3d3ZydjVaTkVVUEI1VE1z?=
 =?utf-8?B?eXNJSDVWN0g2WGNRVmZIZ29WeThmZzN4UXF3eG5QUmRPcmMrUUIxa3dMdnFo?=
 =?utf-8?B?S0V6Mk02VFBDK3pBcFRSRUhVdGZJT2V4cWk0UGdSN0FWdVl6Y0lnUTgwdkVO?=
 =?utf-8?B?VE5GamNqOXZWVXQ1bXZpV1AvbWtCSU9GSWc1R2NWbC9ibWg0aUJFK2c3NE5K?=
 =?utf-8?B?NkFJcWpSdWdHT1BaWWM2dnovS0lHWVB1dGlqYXhZMG5XVFE2RnhnZWtZZlBW?=
 =?utf-8?B?WkdiOUVnNGdsa1pOWmdNcCttM1JydW80ZHB6L2w0ZGtybjhLRjFmU2R2REZk?=
 =?utf-8?B?L1pEd0Nhbk9xMzQyN0p0ZGdrMG55bE1PSlBGd0o1MmRoaVhSYUFmVVFQZEMr?=
 =?utf-8?B?WG8rckdzYmR3RUUyQkxuNnBMV3d4Y1ZzV1pZSkxmeithTFFTNGN2MjlCUCtF?=
 =?utf-8?B?Y1VUbzhPSWMxdG1NVHk4SzBneG4rMUZYRVQvc0E4d0dJd1JFSnF4MDN6VGFN?=
 =?utf-8?B?bkJrZm96TUVJVC9MMGJtZ0YyTm52bmFNZ0NvL0VqU3YwTnVtNjcraVYrS091?=
 =?utf-8?B?Nnc3MEROVjNWYlA4VkZjbWhJQjFySURja3ptY3NldXF6a2tNL1hzNHhqMmFR?=
 =?utf-8?B?ZXZRSmJORXlLbHZ6R2NFQkx3bDhxMmQ2MWJOZk50RDJscmllUUFNZ1FwS1Vv?=
 =?utf-8?B?aGtLQUlhS0dHTTFCZFZOTmVwM3lGcEozVExUMCtoNkdocjVPaXZGQjVWeWcz?=
 =?utf-8?B?M1k3dkExWHNmdkk2dVRHeTZONEpBL01DNFdWTWlmQ1laSU81aG1XdGEwY0ov?=
 =?utf-8?B?aklnbTc5RDgyKzNhRk9WYWRLci9GbkxBT0ZBRUc4ZC9VWkhSYTVBY1Mrd0hi?=
 =?utf-8?B?bmxUUXVCY1pDRHFLOFlKaE4xaTBtMzNPa1FyZkhQdWxWSmw1NDNGbHFtdXg5?=
 =?utf-8?B?MzlNMytqV2trQUJObkNrM0k5WW1rTWR0dGpGdEI1enFvYmJBMVhDUnU2UjBw?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba2e794-a332-4400-41fb-08dd046eddd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 05:40:37.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek2SMgUiOLqbsDtuTA3YwhnoLrHLDDKDBy6ZwU5r5aAvwF/+HAhPQZ89z/nCtROrMcQW3LikbynD8ok23ZIkbSWPMptHBw1/q70uxjHixgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
X-OriginatorOrg: intel.com

Hi Peter,

On 11/13/24 5:28 AM, Peter Newman wrote:
> On Thu, Nov 7, 2024 at 8:15 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 11/7/24 6:26 AM, Peter Newman wrote:
>>> On Thu, Nov 7, 2024 at 12:01 PM Peter Newman <peternewman@google.com> wrote:
>>>>
> 
>>>> Tony had prototyped an MBM rate event[1], which cached a MBps value
>>>> per group/domain produced by the overflow workers. If the workers
>>>> produce the mbps samples immediately after directly reading the
>>>> counters, then this should be the best case in terms of precision and
>>>> introduce very little additional system overhead. Also, userspace
>>>> reading a rate sample that's 1 second old would be a lot less harmful
>>>> than performing an MBps calculation from a count sample that's 1
>>>> second old.
>>
>> I looked at that implementation. Please do note that the implementation
>> appears to be a PoC that does not handle the corner cases where issues may
>> arise. For example, when it reads the event values in the overflow handler
>> the rate is updated even if there was an error during the counter read.
>> The moment a counter read encounters an error it impacts the measured
>> rate so this will need more thought.
>>
>>>> Perhaps combining the per-second bandwidth rate cache with a
>>>> per-domain file for each MBM event to aggregate the data for all
>>>> groups will be the optimally-performing solution?
>>
>> I do not see a problem with exposing a per-domain file for each MBM event
>> that aggregates the data of all groups. For best accuracy I expect that
>> this file will be created on demand, querying hardware counters at the time
>> user space makes the request. This may indeed result in output like below
>> (naming used is just a sample for this discussion):
>>
>>          # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_01
>>            <rdtgroup nameA> <MBM total count>
>>            <rdtgroup nameB> <MBM total count>
>>            <rdtgroup nameC> Error
>>            <rdtgroup nameD> Unavailable
>>            <rdtgroup nameE> Unassigned
>>            ...
>>
>> As I understand from your earlier description this essentially moves the
>> counter reading work from a user space thread to the kernel. There are
>> options to do this work, most disruptive can be done with a
>> smp_call_function_any() to read all the domain's counters from a CPU
>> in the domain without any preemption, less disruptive can be done
>> with smp_call_on_cpu(). Some cond_resched() could be included if
>> the number of events needing to be read starts impacting other parts of
>> the kernel. You already indicated that reading the counters from user space
>> takes 488usec, which is very far from what will trigger the softlockup
>> detector though.
>>
>>> Factoring ABMC into this, we'd have to decide the interval at which
>>> we're comfortable with cycling the available event counters through
>>> the group list in order to get valid MBps samples for every group
>>> often enough.
>>>
>>> A counter will have to stay assigned long enough to get two valid
>>> counts before an MBps value can be reported. If the regular MBps
>>> samples is what we want, maybe we just want a mode where the overflow
>>> workers would also drive the counter assignments too in order to
>>> produce regular samples from all groups.
>>
>> The assignable counter implementation currently depends on user space
>> assigning counters. In this design the events that do not have counters
>> assigned return "Unassigned". The "rate" value can also return
>> "Unassigned" in this existing design. "Unassigned" is one scenario that
>> needs to be handled, there is also hardware errors and MSR returning
>> "Unavailable".
>>
>> We can surely consider a new mode that does not allow user space to assign
>> counters but instead lets resctrl manage counter assignments to support
>> rate events when assignable counters are supported.
>>
>> I see a couple of features being discussed in parallel:
>> - A new per-domain file for each MBM event that aggregates the data of all groups.
>> - A new "rate" event built on top of user assigned counters.
>> - A new "rate" event built on top of resctrl assigned counters.
>>
>> Which best support the use case you have in mind?
> 
> After discussing with my users, it sounds like "all of the above".
> 
> They like the idea of resctrl automatically dealing with counter
> assignments for them, but they would also like to retain enough
> control to provide higher resolution data for groups that concern them
> more. The auto-assignment is nice in that they would get reliable
> bandwidth numbers on AMD with very little development effort and the
> assigning work will be done very efficiently, but eventually they will
> want more control.

It is not obvious to me what the expectations/assumptions are regarding
efficiency. One efficiency benefit I can think of is related to what you
suggested earlier where it is the overflow handler that can do the assignment.
By doing so resctrl can ensure counters are assigned at edges of time range being
measured by overflow handler.

"eventually they will want more control" sounds like there are more requirements
that we need to be made aware of and makes me hesitant to add complicated
automation for nothing.

> They also asked whether they would be able to switch between
> resctrl-assigned and user-assigned at runtime. I think the importance
> of this would depend on how efficient the mbm_assign_control interface
> ends up being. If it will necessarily result in floods of IPIs when
> cycling counters on a large system, they will be eager to not use it
> whenever they can avoid it.

It could be possible to use both (resctrl-assigned and user-assigned)
at the same time. For example, mbm_assign_control could use flag to indicate
which event needs to be counted and whether counter can be shared or not.
For example, we already have "t" for dedicated "MBM total", and there
could theoretically by "T" for shared "MBM total". A very basic
solution could be for "T" counters to be assigned for two runs
of the overflow handler and then round-robin to the next group of
"T" counters.

There are some sharp corners when implementing something like this.
Tony already pointed out one scenario where reading a "shared counter"
monitor group's mbm_local_bytes/mbm_total_bytes
becomes unreliable due to counter being reset at each re-assignment.

On the more complicated side resctrl could perhaps learn more about
how perf multiplexes the limited PMC.

I do think this will be an enhancement of existing counter assignment
that Babu is working on and I do not know how much your users know
about it or experimented with it. You already mentioned that the
users would want more control so it may be most flexible
to leave counter assignment to user space with the planned
mbm_assign_control interface?
 
> The rate assignment events are easier to deal with because they can
> simply be retrieved from memory without the caller needing to worry
> about what domain they're reading from, so I don't believe we will
> ever want to deal with cached count values paired with timestamps. On
> systems with assignable counters, I don't know how much of a problem
> the varying update rate will be. The aggregation files reading from
> memory are cheap to poll every second, so I don't know how big of an
> issue it is for most of the groups to report some sort of N/A-value
> for bandwidth most of the time. They won't have any difficulty
> remembering how long ago they last saw a valid mbps value because
> they're already histogramming all the metrics they watch.

This part seems most related to issue at hand. I understand that
an aggregate file with rate data is most ideal. You snipped my question
whether reading individual counters are required but thinking about this
more it may indeed also be useful to have a per monitor group rate file
containing the rate of that monitor group.

Would existing struct mbm_state.prev_bw be sufficient as a rate exposed to user
space? At this time it is only computed for consumption by the software controller
but we can explore calling mbm_bw_count() at every iteration of the overflow
handler irrespective of software controller.
Please note two things:
- Tony is already adding enhancement for bandwidth to be computed for total as well as
  local MBM bandwidth ([2])
- Computing running bandwidth irrespective of software controller will need mbm_bw_count()
  to be more robust since it (as Tony highligted in [1]) assumes that 
  the preceding counter read always succeeds. 

Reinette

[1] https://lore.kernel.org/all/ZzUvA2XE01U25A38@agluck-desk3/
[2] https://lore.kernel.org/all/20241029172832.93963-3-tony.luck@intel.com/


