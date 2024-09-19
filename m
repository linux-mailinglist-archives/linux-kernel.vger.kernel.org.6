Return-Path: <linux-kernel+bounces-333743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5886997CD35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1494D285B1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182441A255C;
	Thu, 19 Sep 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLiBPss/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8951A072A;
	Thu, 19 Sep 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767534; cv=fail; b=Yr9OPaGYT5QrTJIL6IpYAUo3mCoSrTD4iOPa6gE6JUpQU/xx2BIu3qhOIn1c053s69zcQw7AHWsYZCaYIzl4gu83uFOdYkeFiB9j1NmPejM+OHYNxADna3kHXCeKg3zDNIMlXLcb5pvqPNnTZYg7QlslnuOMfxbvAbZoOiZ+VaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767534; c=relaxed/simple;
	bh=KnathcvwNyTuly13w1Qo0XPwYFOEYlUybkR5UEPNrh0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m0QfyIa3GUNtHBzR7CIgLuhdpz4uA+s+OMVgblDeYKChRbvmIAFhgGQZNRqY7WtXvnUJIhc/9HQdIXd4l6RyvOtAkkgJ96LBZnYNMddeF0pZg4SCOFAmvcw1VCyWxH1mkLwuiCAbDngFU9WeWZeDepFbJCSkDat6EtG68lvnbUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLiBPss/; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726767532; x=1758303532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KnathcvwNyTuly13w1Qo0XPwYFOEYlUybkR5UEPNrh0=;
  b=jLiBPss/z10lfH35ReMmDXSK6jt9jqK4JNY4Ae9qdihgNoYnomleDav3
   aeQK31NB7Im65ZbWFu4Z6Q72u17fGMD7k/h9dSxwEwB7WPlJIiRfrA4gJ
   m1BzNeJML2qKTlnwL+ssD+IttVzHwbxcg7T7aRpmxSMNttfKRpA0yg4tq
   kbLTaIEmgQXPwQpOKzDqFwKz1UCrwOANTdB87eEGOxCNVSN8FLPr84j/j
   fuTRq1MbssTRs/uO9wZ7j49f8HvoqeSt+pO612hTeQE+hmh3f/x+DSi+x
   dnG8pLtrmfS4U3GeUa1VEBd6J+qxN7P3xmZI8Rp/lWG8hgViJmsQDqyl7
   A==;
X-CSE-ConnectionGUID: J9v9Gs14TXazR6Y03MMgdA==
X-CSE-MsgGUID: Up2fNAtdSA2N4IFUSVNUaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25897051"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25897051"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:38:51 -0700
X-CSE-ConnectionGUID: 3fxrBHYFTY6vizSZ7OEAHg==
X-CSE-MsgGUID: xckhNpJjTLeoQPV7nQ3Vkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74370925"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:38:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:38:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:38:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:38:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulkF01eZ5623SQZIYTiiyxVHSETmoRgUfXKb/U7M7wnA7p/cXf2cqNUjfphVi1NrNNzGWQ5Nf0I4SSLWVDM7uCxniDS2ydGZJgasLPBP2V/8rzL9lU7vdQT089qYM0EdW5FSZ9xftp/1CtbiHtxVG59i5hpIL9jWONVtCTjELyWw079k+XfWJGQZZ+YruJrWoQF/hfNoSs+aqswt06E4kUSSMksW3TAwZJ9KKURmsNf7t3hX7cr/4jwCm/7j0VhFA7w54aKk5VeGCQbtWas/lpQEDpd5jfhvLEK78BWsbj4viY3YhPIHYFVo9gvrN85hmMe+zazPf/M/Xt9ZcLVpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkz6fAADzh8XkqxrauG/7hGVSnRBduvjgxbFuc/eZS8=;
 b=LzDr1ZiifMf26XWm1Xm1uN6FgB3up/v2IKWLfXns/OkTVgxngv+gVc6W5moR7AOZLCBT0ru1hS203SAsG5B+cDo9P4wi+vcwHZpQcWHKB94t0GTkBwuorYGBPDFEtui8N8CSFels+2HYOEBSUBPY9/BjA38OoZWgdn9YeuKnjxkyvAYsHMKxnvWlu9h8Sv4LlNI4UrgBvUnhdCcmbLs1tpQiERIFxyNwUtsOJY0xnc66rWmfF/Jg60Agn5egzH4VWlqKGAlpX+5FyPBR69x7b4GNVusMjHP4SWGmryCQWo6c/8aRxXPUurtNZIPbWKl/wWSNLgb4B8cvr5LcTgMUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Thu, 19 Sep
 2024 17:38:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:38:43 +0000
Message-ID: <b84fee44-d52b-45c3-8664-b2215074bea9@intel.com>
Date: Thu, 19 Sep 2024 10:38:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/24] x86/resctrl: Introduce the interface to switch
 between monitor modes
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <812a04c41c66824a212c2dbd30697fe0cad71523.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <812a04c41c66824a212c2dbd30697fe0cad71523.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5e241-0792-45b8-e424-08dcd8d1e84c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0ZlZXVyYnZyTU9IQU5vLy9qM1dtcmtUU1MwSVdaODZ4RXd1dWF2VXhJMlBT?=
 =?utf-8?B?emVIMDkxTU54QUpObllTVnhDWWJTZis0VlJVM2IrL1krL0NmTTYxOERYMVA4?=
 =?utf-8?B?cEhxVm9ITWwxakJVU3FPUUFDeFhFUVNCMDJ4SVBndWdZT1dUT0p2cFJ0cUxY?=
 =?utf-8?B?ckVVVy9wN1RiTWNTWTVGakhNaHJGMU90RGlYdURHTkdYSnpSZ0NmbktkR25y?=
 =?utf-8?B?aUE1a3hnSTZwbS9ZZkxQdzZhaktPN0VYRWtjT0JrNnFqdmNlNnMzZ3pacmhs?=
 =?utf-8?B?UmNrdEhJN1VyQlQ4K0djajU3U1ZJUytxbXhrc2gzamFITmFLajhIeEhoQ2FO?=
 =?utf-8?B?Vm55UHdRMFh2NUVtN2MxNUpGd3hxeEl5Y1E5WTJ3b0ZKaVdnazY0dlM4L1ov?=
 =?utf-8?B?REE4T1NMUmZvZWVXbStISTZYL2NDRUJ5OUtLVmhVYVdNbnNWb2NQK0R0Q2Jt?=
 =?utf-8?B?bWZuVlhJV1pJalRhWW1remRGVHZLdkxVdDFtT1Izc0FoWCtOZkp4M3FUVFhi?=
 =?utf-8?B?RlRVVXh2dCtMZDh4ZHlKeStWSkdqTVpjekw1VXEvWTJjN2R1TFJuYnByS0Rm?=
 =?utf-8?B?enFSOHB2bkZ5c1ZzRVJKekRHOUgwaGx5bGVzK05vV20wMk9XdzZ1d1hzUzU3?=
 =?utf-8?B?Q3hyUHhsRFZKN2wzR3lZNlJuTkZIUVZGVWVxTlpQNFUyY3o0UUdKOTJSbEtx?=
 =?utf-8?B?R052bVVLSXZ3dnQ2ejBwVGhHTEo1Ti8xZFVZaDdUcGZTdWt1Q3lsR0ZGQUVH?=
 =?utf-8?B?cVNaTkdaZVk0OFZaYTBlMXhzQXdYOW9DRklZUU9OTVdXTGRmRWVVbkcvMVc2?=
 =?utf-8?B?SXJDNUJmbDh4akN1bVBRTEIvdHdyZjNvOWtyT2ZEc2g4czB1S3BqZ3Jnb2hL?=
 =?utf-8?B?WGRLQ3NoWUpCNXFhUUd0OXdyanJOamUwWElBSUxKMXpPSm05dnc5a3lNeDFP?=
 =?utf-8?B?a1ZzUjMybytsa2Q4NUk1Q0xQS2NvaklEeEwzZUtrRkRCeWtnMU1sV1czakxP?=
 =?utf-8?B?WnFNL2tJeVFKOTIrVStPVmNJWlR1eERjWG1GcWdJSTJnT0w3Zy81TXJ5Rkg2?=
 =?utf-8?B?U2dTNElubHNLZHdrUWdiK0huWmp1RVRSZ3FwMnkyVWxIa1RaNnVVZnFBajd3?=
 =?utf-8?B?Y1k0eVkySHM1QVpwd0RpTk8zT2RqMUJNSXAxOXJoZW1DaHR1UmF3dEswcEVV?=
 =?utf-8?B?QWJnWFJZdUIwTkFRVmJwTTB3L0JUYmRmNTE0elozY0ZMR1JzdXlpQVZNQllJ?=
 =?utf-8?B?aVF6dlpPb0F1RGVUSUdFaFdGTnE0SWpzb3JJTlRwbkRaaHl6am5qTnE1N0Q1?=
 =?utf-8?B?YktieXd1UmR0L0hSSlphMUxULzdOWkNVT21IQVVOQjBaYTcweWtMRUs5elZM?=
 =?utf-8?B?dWMyTWp6RWZTMmlmTWIrRWFwS3owVXdoMkFCVWlvYzY5VWFYVm4xV0VVKzNp?=
 =?utf-8?B?QlVXRk5zM25hU1NwVUdvQVBWV3Qxb2YyOGpyaE5ZTU1IOFBCZng0UCtBeHpq?=
 =?utf-8?B?RHFtendEZnl5NFNpUWFsQ21iMkNZQndRbE9nU1NWNU9uT0hXdmhib1hUUGlT?=
 =?utf-8?B?T05kU1RiYThTVUFtZU1mdHBQWWdEelNrT1NNVTVBSWlMT2xzb3hkQnZFTlNv?=
 =?utf-8?B?QUZmVFlSa1pyek1BcWYzcWhMSkNlWXQyeVZwQ1QxMzkwYnlUNmgwWktxcnR2?=
 =?utf-8?B?SWhXSUVFcmNpYzRpNnQwQVg4MFpZZjBQN2hMK2JiQkhnbSs0U1BYdGlFcHBq?=
 =?utf-8?B?L2JPdnF0SVp3ZCtJeE8xUnlBNW9Jei9zTHFrUGF5UmFOTXM5T1NvcDZDUDFt?=
 =?utf-8?B?ZFVIYTAwcTl1cmd5UlJGdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdrN2t3TGJlZ1NPOTgzQm5CeWNSOVYxWVBuYlBlRytacURuRHBJc1paRFBD?=
 =?utf-8?B?QnN2QnQvTmdnTFErY2ErdmFTZW0zY2Y1YVJNTndEUlcxL3NEZTNwK1F2REo5?=
 =?utf-8?B?b1ZHOGhYdWpvT04rWUhydTh4eStHQjlycWxsRlk3U2FRc09kdkxTaDN1NmU1?=
 =?utf-8?B?Q3NrMldvQWNlZXd0VVRkcTBsZ0pUR1hNeWdidnh3REZzMnQwQnZDbWFmN0d5?=
 =?utf-8?B?VXZvKzVrK2JvbFNIRnNNdVlrWmxGRno1WG5hRWQ5aTk2MzhVODJCMm5TT1hW?=
 =?utf-8?B?ZE9BUVFIbFB5V0lLVHRza05FNXRucWN1MmZIWjdOWWNKVUlPaEpVUXVleUJ0?=
 =?utf-8?B?VFpOMFRYQ0hFSlh2T0NmbmowRWdNSWY3U1VRenEyeHdBMnBrYk1YdXdMdVg4?=
 =?utf-8?B?VHVmTzBwR3prc1FBb09oQ1ZmSE9IdHR6QkYxZnowU29BdUVTcUorcWxCekxR?=
 =?utf-8?B?eWNjSzJmNnFPMlFaRTBvUmpjMFUrMjRrUXVFVkVyMWJpZGM5TTFXNUY1UFE2?=
 =?utf-8?B?NStKU1loajBlQzZlVkxFUStLQkNOSUE1M2J6bjJRQm5JeVRIa2JjQmN1ZDlu?=
 =?utf-8?B?SGUweHY2UEJsY2hJVllnUmdqelV1YUZhc0pUS0FnaTFGSWJEWVd2dDNOMkpn?=
 =?utf-8?B?NjVxb1BYeUV3aDdzNnpjVi9PVkd5d3EyQUVzU3BqRGhSeHBrQWlNbWdOU21L?=
 =?utf-8?B?dXk5U0RXVVhTelFEVE9JUkVwSVUzSE81aHVKR2dzZkxKbC9hVWJ2cWVWZzVV?=
 =?utf-8?B?bzRzcDZGWTlBL0RXN01YMWk4Ull2dVBNWENmRzlDMDlrZTZ5NEZNT3l6UUsy?=
 =?utf-8?B?aWt1K0NicEozdldJMWJKbVhSa1U1VU1YdTZlL2N2enVlSUExTC9LbUY4YlpC?=
 =?utf-8?B?UkY0aHBDRndZOWZiNHNvZWR3QzI2YXVTNlREQVRkWkRnRGMwdk1taTdQbkZV?=
 =?utf-8?B?d2lZem9tL051Z211TkdxYlBmQnJXRytxY2hxZXVUcUVJQ1ZpYkJ5c1dPcnUr?=
 =?utf-8?B?MXRLTG41dXJHNkFycEg4NzRvd0N5akV6VWljNUpoenhxOGtxYjB0QTdjUjhK?=
 =?utf-8?B?YzY4WGRJS1p0eGhRSzd4a0lQQnROTDNEeCtPbUd1UjhRYzlhZkdrVjViOWxP?=
 =?utf-8?B?ZUxaVGNZZERpUWlGblZRZGZoZlZtL3lvVDBoTm9vaFJHUldRZ1JnNDVOOHpk?=
 =?utf-8?B?RVIrdm5zMkxVTk1WM21odDZWVEFRcTZzcHJ6WjZsZDY3ZjBKTHNPUGxzeXZr?=
 =?utf-8?B?MmEzLy9UbGx0N3U1cjlwbTVQZGlIbTQ2bUx1Nk1FaE4vdGdiZTNwL01CWmsy?=
 =?utf-8?B?TDREVXZoYkVtaVhhSVVXeUd4RXV6aUVTSlUrVGZLM0h6RWVvcXVVZjI1Lzlu?=
 =?utf-8?B?R1U3TVgwcUVqUDE0bDV2VlZNeDBmNG1KTWhLSzhCaVJBVngvU3dpQUcyMmxZ?=
 =?utf-8?B?WTdaZGd3ZzVmdmF2ZlFZN1VjWTNGTFRhcGs3LzNWdHlTaHIwNFFkWVhRRVcy?=
 =?utf-8?B?Z0tqQ1ltRUxTVldiNlVkaEpXaUpMcnhpKzNxWlVEUFNTTWJ5NHlmOFo2QS9u?=
 =?utf-8?B?Z3FpRlZ4Y0lJQnRpVmt4SnlaR2RoVEpYQlFERC9GMVFUUHdTU09QVUduZC8x?=
 =?utf-8?B?RkVlKy8zVktmWGJTZTMzVE1oNkh0c0RFb3VXWnV6cEVNSGN6czJxeDJIeVcz?=
 =?utf-8?B?eVcvUFNISFYzZm9QRy91OXlLcER1NXovbThpSmZ4WWQxR0JwUTdsTnA4NCtM?=
 =?utf-8?B?NTFPTGg2NEVxTnhBRkIydEpBMVNOaUtKSGNDM0FyMXlkQmlrbGNDU29tNmxa?=
 =?utf-8?B?bmg5UUwrd2VxSmhvWTVTSTBWek5JbDlhQ0NCZXQ3dHVzYldsS3Z2c2pjSHNQ?=
 =?utf-8?B?M3g1OFUyaTRpcG1SbDhrVGZSTnRObVFBbUpVMFA2Z1MxOVdvYm1JeTFLM0Zp?=
 =?utf-8?B?WDRsQkQ5citaaUF3andsUnF2NTl6Y2YwWFdYMmU1SkdEUkl6eHlSMlRUK1Jz?=
 =?utf-8?B?NmI1Zmc3eG5zenRlMU1ySCtEeVgwQ2NscE1GbTRRU1BVaVpzVm5ta3ZqeDUw?=
 =?utf-8?B?OUh0V2QxZGF0OHo2SlhYbW9pV2gxWUl2QXJyNDlqZXBQRTBuQmdxR0JxVllQ?=
 =?utf-8?B?MTBpNDRYZ210KzE4RGZnVFpYTzJFQ2xzZk85QlZFY2hHMXpwZXJJeVVmSE5v?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5e241-0792-45b8-e424-08dcd8d1e84c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:38:43.8150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C298x/l5bjTBl/oe9EaKnrUmsY0VpLjV+1JOh5ahug0xcCTLnpFeYN5oVdsP9hWeT2Y2Ze2MMYuSXb3t2P/2koPRzNfAebDgxJVYcLCyWbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Introduce interface to switch between mbm_cntr_assign and default modes.
> 
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_cntr_assign]
> default
> 
> To enable the "mbm_cntr_assign" mode:
> $ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> To enable the default monitoring mode:
> $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> MBM event counters will reset when mbm_assign_mode is changed.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Changed the interface name to mbm_assign_mode.
>     Removed the references of ABMC.
>     Added the changes to reset global and domain bitmaps.
>     Added the changes to reset rmid.
> 
> v6: Changed the mode name to mbm_cntr_assign.
>     Moved all the FS related code here.
>     Added changes to reset mbm_cntr_map and resctrl group counters.
> ""
> v5: Change log and mode description text correction.
> 
> v4: Minor commit text changes. Keep the default to ABMC when supported.
>     Fixed comments to reflect changed interface "mbm_mode".
> 
> v3: New patch to address the review comments from upstream.
> ---
>  Documentation/arch/x86/resctrl.rst     | 15 ++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 74 +++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index ff5397d19704..743c0b64a330 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -290,6 +290,21 @@ with the following files:
>  	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
>  	if there is no hardware resource assigned.
>  
> +	* To enable ABMC feature:

The separation between fs and arch did not make it to this patch?

> +	  ::
> +
> +	    # echo  "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +
> +	* To enable the legacy monitoring feature:

"legacy" -> "default"?

> +	  ::
> +
> +	    # echo  "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +
> +	The MBM event counters will reset when mbm_assign_mode is changed. Moving to

"will reset" -> "may reset"? Please also be clear on what is meant with "MBM event counter".
Note that "counter" has a very specific meaning in this work and after considering that
it is not clear if "MBM event counter will reset" means that the counters are no longer
assigned or if it means that the counts associated with events will be reset.

> +	mbm_cntr_assign will require users to assign the counters to the events to
> +	read the events. Otherwise, the MBM event counters will return "Unassigned"
> +	when read.
> +
>  "num_mbm_cntrs":
>  	The number of monitoring counters available for assignment.
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index bf94e4e05540..7a8ece12d7da 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -895,6 +895,77 @@ static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static void rdtgroup_mbm_cntr_reset(struct rdt_resource *r)

It is not clear why this has "rdtgroup" prefix since it is not specific to
a resource group but a global action that resets all counters.

> +{
> +	struct rdtgroup *prgrp, *crgrp;
> +	struct rdt_mon_domain *dom;
> +
> +	/*
> +	 * Hardware counters will reset after switching the monitor mode.
> +	 * Reset the architectural state so that reading of hardware
> +	 * counter is not considered as an overflow in the next update.
> +	 * Also reset the domain counter bitmap.
> +	 */
> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +		bitmap_zero(dom->mbm_cntr_map, r->mon.num_mbm_cntrs);
> +		resctrl_arch_reset_rmid_all(r, dom);
> +	}
> +
> +	/* Reset global MBM counter map */
> +	bitmap_fill(r->mon.mbm_cntr_free_map, r->mon.num_mbm_cntrs);
> +
> +	/* Reset the cntr_id's for all the monitor groups */
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		prgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +		prgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			crgrp->mon.cntr_id[0] = MON_CNTR_UNSET;
> +			crgrp->mon.cntr_id[1] = MON_CNTR_UNSET;
> +		}
> +	}
> +}
> +
> +static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
> +					      char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret = 0;
> +	bool enable;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!strcmp(buf, "default")) {
> +		enable = 0;
> +	} else if (!strcmp(buf, "mbm_cntr_assign")) {
> +		enable = 1;
> +	} else {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Unsupported assign mode\n");
> +		goto write_exit;
> +	}
> +
> +	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		rdtgroup_mbm_cntr_reset(r);

Should this reset not happen only after the hardware state was changed
successfully? If the arch change failed then this may lead to inconsistent
state.

> +		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
> +	}
> +
> +write_exit:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>  static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
>  				       struct seq_file *s, void *v)
>  {
> @@ -2107,9 +2178,10 @@ static struct rftype res_common_files[] = {
>  	},
>  	{
>  		.name		= "mbm_assign_mode",
> -		.mode		= 0444,
> +		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= rdtgroup_mbm_assign_mode_show,
> +		.write		= rdtgroup_mbm_assign_mode_write,
>  		.fflags		= RFTYPE_MON_INFO,
>  	},
>  	{

Reinette

