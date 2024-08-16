Return-Path: <linux-kernel+bounces-290335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA9955264
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C361F2435B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0971C6887;
	Fri, 16 Aug 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1bXAng/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81A1C4638;
	Fri, 16 Aug 2024 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843802; cv=fail; b=ch5YZ4M+pR6nc70xtEsr4tQH0uowZ/HiMHJisgrsLA/0W1eHilqXGKsDY5ZnFf5I21qCuvU4zZB8Dn34d5SbrsPphm7hx3RvfpSBHC9NPfSF1lyA6TzMcWUHdvR5NSAhMWgOfd48zxkrWi1r1ckk5/9Y8DQgNUcRc7bftwCaH3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843802; c=relaxed/simple;
	bh=Ywpmt8lF4oTiB7UXLxy1Vxh92CFgonV3oVyAr9xPAqk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aHlxfGboaMa/XGF7V8dM+Dgs3138lyA2afBYXB3x8s7XMdqx9pQ6iODxHSU7n+s2fY7E4WJIwtZSVzK7s0mO/CIGvYjOxM/JiZqjG/wNF2D7drml/d085jOwWxXVft0r0dOQEhmlH5EYj6sbkWN8A/q7U3CPBa+ekNepgsgVUfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1bXAng/; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723843800; x=1755379800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ywpmt8lF4oTiB7UXLxy1Vxh92CFgonV3oVyAr9xPAqk=;
  b=L1bXAng/PdLxPE75iUEnuzx3t2zQm7Bp6jJ8pbTpG3LdcX41O3273L1O
   ZDbbO5RMMdvAOCygs09AY8/w7O8yF8G0dt3BvHovJyPBU+M8qDOfYaapf
   EihooBEfzqFDdcJoKZCSuqVrPK0uIzw8psuBQAmcHc8DVhXC7PYeBUW5B
   bpT16i7MqiJ36kcL4H6Nbe1ZA14zWb6UfDINeoSWSdiwaF/ERs609V3J1
   2HcrnopjSoLjCfqvKIUOGtDNKZnUB5TGTpX36OskJCemW8ugAeSMr/vDi
   VSHk+Mc1COwEJ45fTF6zeqpcy+/VGEily9SwvR4NZ7EQW3FXNppMhZclL
   w==;
X-CSE-ConnectionGUID: ChtKjorhTBSMseE0PSgv5w==
X-CSE-MsgGUID: tKwRHUKET7yFFnU0NzF83A==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25053828"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="25053828"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:29:52 -0700
X-CSE-ConnectionGUID: uSUZum1RRe+9sgMMp+v5OA==
X-CSE-MsgGUID: LtjVsGSvQ029bLpCfDK3JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="60563435"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:29:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:29:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:29:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:29:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/8+nOsP5VJvYSu2e53g+f+NTXYXdqqMobA0Oj5o4QJnk9o96BpMI/imc4fVVoo93BiF9dV9cQgjzvy9LLTI3AXOms5HaXn6f2eGJRHSFkkqskXYp9Lvc349vxv9swDCPrB+fl7dQ+UPOqGCOS9eobDgP6fsyxdJfA80/3rykWzDYuaVJmlBnX5bDmO8NRe517RBafJiurhOwbjjuEX36OplXGLoQe+uLgPegs/EBZa2rthc8VI1ofNpNPTrIxN+jr3Nxe4FjR/FBEROlGS3MOzNHsUVsnK0vuNeonkzrz/vsEE+Nf82HQU2JIMVAOLn4wt8kUG7ejthvVmaUPs33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwRiqTFqapJaGaNEh5j5gmVFN9qlxk806AYO7SWT05w=;
 b=kVz/xpHJQiKJoLgaP6E57uNhUPyMkpv35/63s+3Kqdv/sMAxIhk8yjuZVtpXglSoydCwZWGg86i+Kp1VYl0ntBaFFNuogPHX3LvwMfo8GV8H1beVj6Mhca91X5L5Gs9JoYNqN2osoev153MZiP3kBwkEtUhjznzzDBJ8o3gLjbyM0Ux4O1EMJBCdYyQBxF/K8NMmYk17uDcvqk0V7k7kqyPaMH2G8ObCBUkP6EfNwibQ/ERtZ8YFGJQVzRih225afJk7tZzIwdJJ4Dlr2J4m81/yZFWwrKts7e0PdZLFLop1qUmWvIINRLhbu7bQIDVGrTEYvyXRBbvpzadNND9XLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 21:29:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:29:45 +0000
Message-ID: <f098bebf-2ea4-4fc8-aa20-8dc2fef79f03@intel.com>
Date: Fri, 16 Aug 2024 14:29:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/22] x86/resctrl: Consolidate monitoring related data
 from rdt_resource
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
 <de0a8fc4b8f6093dd74516ca7ef569107de7b213.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <de0a8fc4b8f6093dd74516ca7ef569107de7b213.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: 077a0ae4-2125-4dc6-6b0e-08dcbe3a8c85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmdBVjVWZmVkUWJtQkFwbCtsZ1lia05LQ2ljdDk2NnUzYkdIaHl0ekZOaGhu?=
 =?utf-8?B?Y3dOb2ZFY1hBMFBydVhQU01Wb3pFaGtkc0M0RXNsNlg0Vm1NRFNXTVN1MENM?=
 =?utf-8?B?QkQ0SnJ2VEhkOXJKc3VqbW9iTTZTYjRRWnpuVEJ6Z3JvVXo3NTJiaE9EaGxk?=
 =?utf-8?B?aXZuUjRLZytsM3lxRFdUZjI5bWJJY2Q1Z1dEWk4rREp1bDNoRDFiVXhHUWhK?=
 =?utf-8?B?WVkwSGV2UGxjTWVUd2dFS2dLM1ZTWjBBQndhS0JRZnNCdm13VlpZQW5GQ0o1?=
 =?utf-8?B?a2FENGtDRk53ZE5qSjh5d3ZUTWNEalAxYXpvQWlFdjhEMkI1MjczaThLRTkx?=
 =?utf-8?B?SlVxWGN5cURzQzJtS3h2TG1WUWpQWnY2V2RjN2ZoMlVrSm5QU2lQUVV2Wjhw?=
 =?utf-8?B?Rkcxc1VSenNFTG5DUmpsQ3YrR2N2Q1IyQjNZRGN6RXBKTFk5WGdpenFQcFJ0?=
 =?utf-8?B?OUVnSE02M3pPRUVjM2dBU0J5VXc4dXJtYTFWK2p4ankzZXNKRG9YL1lCM3Er?=
 =?utf-8?B?ei9XdXp1Zm1QbS9BSFc2Z2ZHZVRwQzA4NGZ6NDBZS284MFFGeE1NQXY0RjBq?=
 =?utf-8?B?L0wzZFBSYnhYVFhwd0Y5ZXRmT3NZbUdQRTc0RVhyTFNoSUNOWFU5Z05VME93?=
 =?utf-8?B?ZlcyUDBLc09kYjM3b1NzUXV0YlBnc1l4VjV4TzBGL0M0MmhPL2xFOTJGZGc1?=
 =?utf-8?B?aHJqMFVrMitTUVhzZkovMlM4b3VGSXpCem1SUXNXRm1Mak1TNHkxemJ4Mmt1?=
 =?utf-8?B?QTJJUklYQjByTTZ5MldmbVg0Q0dJL2ZtV21RNHcyTldOYVdqUUlPZjRXVTlz?=
 =?utf-8?B?UmJNaU9PODliUVUzNms2aE56VkJyUVNHU0dsUmxOV1NPYTh2WkEvMGNnaWJp?=
 =?utf-8?B?dmVKbHdHWnM0OGI4VnVGd3oweUZYRkVaS2oyUk5IOENyUnFIRUc5SVdxSUF1?=
 =?utf-8?B?Unk2aTdBMi9WLy9LalEzak9Md3JzVEFoQXE4c09NL1NqbEsrYVZLT1RhcjR4?=
 =?utf-8?B?TlIrTDNyZU5EUGtlSEtEMGpBbjJrTE5FdC9TcmIyMFlvUUErMEtWU3FBdW5C?=
 =?utf-8?B?VmlJbVFEek1HSytjVVUrVjZHdVJ4TWUwYndmWmVFZ2JEMEI5ajhCYXd5NEln?=
 =?utf-8?B?Rit1OEtIdzJHd21wT21wMzgwSS84UjU3TnBqcjVFeUNUeFNRZG5UZXREaVRj?=
 =?utf-8?B?aDlXdXpFZW45RThFYTdPWG9BWXpKTkxubmc2TEdxRTBlMmpDVjdRUEZOWWI1?=
 =?utf-8?B?RGxsZlRCL3lrejRWZlVweW0ydXo1QU9Pb1lLS0JxZ2NEYndEcWNQSU1CNFE2?=
 =?utf-8?B?ZHZRWjZMd1VlcDRpOHZ1NFJvTWE0dUtPdTBCR1ZPdnN0bVFyeFVmZll1VXA5?=
 =?utf-8?B?T2xJaTNaeFdNd1grSnA5RmpydnhKY0FRSitQTWV2U2FrRzRua2JmNWhITURL?=
 =?utf-8?B?SFFlaG1LVE9zQlFBRUErcnp1cGdneVN6Ujk1VnBTVnJKakNQTlFMRjExbEJi?=
 =?utf-8?B?dkpiek9uM3diT2dIT3g3bUE5bWNwVHhFK3pXWjlyT1h4a1FJL054TVRwN09W?=
 =?utf-8?B?V2lVYWwyNncwT29BRHNuTHFrZ3RJN29rTHV6UUJwUmN2TGVEVUJmeFA5TGVT?=
 =?utf-8?B?eVAzZHZiaC90c3R2NGlpRmJKZ3dGbkwvVTFXT052eUVoSkpXVk1HV1JlY2w1?=
 =?utf-8?B?QlZXMEtsTjhJb2toQkJXa0tOSFlaemlzQmIyVWVOMWd6WEJTYnpCbk1ieE54?=
 =?utf-8?B?RGVDejZrSS9wcEE1aGIrNUEwdWpjK3VRNksvaGp0YnB3R2xjTE9BS2FzNnBq?=
 =?utf-8?B?ZVhlRVFjWWVUZVdraFFMQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1UzbHdmak5FaVpINXV4RFBBWlVmcUx6Q2Z3SVBjbmk0NFR3OFhqSnhadkNv?=
 =?utf-8?B?clc1NExYbzRnN1pRTVFmY0hDdEdMSDh4UVFFODA1ZVBRTGRPbERxL1dmYzVQ?=
 =?utf-8?B?enBjeUVNQnFHc2xYRDh6cWRVTm1sNU5iODN6aDhsWVo1aXh2TEZVOHROQi9j?=
 =?utf-8?B?UnhzRzlQcTBSTHBDenRRSDJBNldzZ281cXRYckJ2L3VmTXV3Q2VHT1ppa3Bj?=
 =?utf-8?B?T21hd0J4RWovZkxXSHFvdi9mcEg3THdjRExrd0t5OXNmbnVWdVpWNWh6SVNL?=
 =?utf-8?B?RUVrbllpMS9IM08veE9KRmpaVUV3UHRDSXZtUlUvNW96STZmZkJqQTZERDUy?=
 =?utf-8?B?QXM5WndrT2xOblhoL0NnT1k3MHgyRkl5aFBNWXNvOFJaRnNnWEd4OGExbDVK?=
 =?utf-8?B?d3FqeExablZIOElhV1JXMlRtaGxINHJPQ1V0L2lOVVBpZE9oMTVCc3U1eE5R?=
 =?utf-8?B?TUUwTFFSWGZhWWNYT0E5NHozUEhtdUkyTnVpenI2K0thQ1g0R25xdWlPTTFD?=
 =?utf-8?B?YjBIZlNNeXBTVS9qbktNdzBYZUpaMEhtbU83NlhKRlV0M25vN1cwUlc1K0J2?=
 =?utf-8?B?UFJRVU1aZkR4TkVxYkE0T2wxR21LMHVvVVJOYTZGdnpYek1RaXJRekVURy93?=
 =?utf-8?B?NWY5MkZxVkZDNE1sTVVRdWZNbkdEZEtvU0x0c3c3ZHQ1a3QxWkxFdzN0aFR2?=
 =?utf-8?B?OEpuajZUWVdaalR2Uml2YkRnNEtoZkdFL3JrNXR3NFJVTHNzL1pXRW11U3Vj?=
 =?utf-8?B?eVZLRWtXbmIzRnI0dERDb3FJaVJKRUVJMzJnRUJjd3MzSkhlemkxZXZjMnM1?=
 =?utf-8?B?d0lCcnpDdWZWWGs5cUxZN2orT21sQm9GV29OVGhOK3NDL09USEtJRkd3UlZ2?=
 =?utf-8?B?WTZYLzRZVVQ0OWFkcDhpaTdnSW1VL29BNEpaVkJKM0kzZnZMSmVFUlJtb1J1?=
 =?utf-8?B?dGg2Q0lUeVhQRzlMb1lRc1d6bDcxVy9nU3NteTBpa0FNeENmOHR2akxTOU4v?=
 =?utf-8?B?LzVuWWlaYjdDZndCcnRmMit0ZE9MeU1XNlBkTVdrUmUremQ4anYvdGRyVExa?=
 =?utf-8?B?SHFMRTVteGs1cVBZYVJ4U2lPamVxaVR0MDI2NE5NUmwzNDFMVEhacy9KN0VH?=
 =?utf-8?B?NkFsMDF5SW44bVJ5bSs2MW9adVBmWVNTYlR6T29BVDBjakk0aGlPeXg5YUVa?=
 =?utf-8?B?N1ZIdTBuYW52VHg5Wk9lbEVqa3VjRTZWcjhoTStaeVlyKzZ5OGhKUmZpNCtV?=
 =?utf-8?B?LzV2ODV1dEYyOXdQTDNBYnhseTV6QjlLRTN3YmM2RVMvYmh0MC95dlh2Z1FU?=
 =?utf-8?B?TXBqOUJWOW5maVZNUEpwd2lLcDBTSlBTSm54K3ZCL09NdzdNOG94bEhxL3BN?=
 =?utf-8?B?QzJXY1BFVlQzelR3dEFzRm9GZEp0MXNTOGdrYnJvNkNLMGkwckRRY084VWc2?=
 =?utf-8?B?L0IwUllldTJCcTdESVNiTWlvYStwUXNucHpRZGpoU1dFU244V1ZjSm13dWtB?=
 =?utf-8?B?cURQN21VRzlRTUtZTzF0Qlh4a0ZicGt0Mmt6VXZFMzc4dHY3ZE1sdFUveEpM?=
 =?utf-8?B?RjRmZHZZK3p0a2pFMCtmSkw5TGhGa2RUbmJzVWN5TFBLeFA4OURuQ0xHVTVu?=
 =?utf-8?B?Z2dvenJreDhpbEYwTjRYVGk5WWZpU21ta08yS2ErS0NUMUxkTVYwTm5MdkZT?=
 =?utf-8?B?UFpjWWYxQ2dORmFJZDhES0h0YWcweFVMNTV4RHVuTnRkMlFwcXlmaDJTZG9q?=
 =?utf-8?B?QXgrU2U2NUt4ZnZSQkU1N0tPZmc0UmtuV2Z0NTd0UnhTdnFkckxiZExrNDFF?=
 =?utf-8?B?aGh4clc0S3FnMWtuOXlER3BrWURtdjRHN2ttSVAya01FYjRlL0FBNStXTnBk?=
 =?utf-8?B?SnhhWnRaUGRnbVdMY0p5bjJ1OVlCUDhUMHo5d3M1ckFkOWZreTFaL2xoNmU2?=
 =?utf-8?B?TytuV25zSTBjTWw5cDZmSVlsOW1CWGpFVEdjRkI2Z1VTWTVvSDkvWmpScURR?=
 =?utf-8?B?MElCWnZRWjVvVzd4bndRWmpxN2xub1RtY3dyOFp6cER0R3F6aFNjOTdzZ3NR?=
 =?utf-8?B?TzA0OXBSUjZnRHNraGhuQTdPZ1kzeHh0SFFmVEQ2RkpqWkdVMm5pYzlWTVJu?=
 =?utf-8?B?RENmSnFzRnhoTEZTNDV0Q2NjaGNleEUvNlZ6dk1tQS9zaFVneEZtc1YvTlZm?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 077a0ae4-2125-4dc6-6b0e-08dcbe3a8c85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:29:45.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miHAHJBF5kyNuZaMHoL0Pez3Kiww0dXu89F3XtAAvJ+JtJhU8GzQW2Ox4XB09U6StxRrC5v1QmRGCraTbRzA3wICLparaz/XI9HombeBZg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> The cache allocation and memory bandwidth allocation feature properties
> are consolidated into cache and membw structures respectively.

"are consolidated into cache and membw structures respectively" ->
"are consolidated into struct resctrl_cache and struct resctrl_membw respectively"

> 
> In preparation for more monitoring properties that will clobber the
> existing resource struct more, re-organize the monitoring specific
> properties to also be in a separate structure.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> @@ -182,12 +182,21 @@ enum resctrl_scope {
>   	RESCTRL_L3_NODE,
>   };
>   
> +/**
> + * struct resctrl_mon - Monitoring related data

To capture that this is not global monitoring data but instead
resource specific:
"Monitoring related data" -> "Monitoring related data of a resctrl resource"

> + * @num_rmid:		Number of RMIDs available
> + * @evt_list:		List of monitoring events
> + */
> +struct resctrl_mon {
> +	int			num_rmid;
> +	struct list_head	evt_list;
> +};
> +
>   /**
>    * struct rdt_resource - attributes of a resctrl resource
>    * @rid:		The index of the resource
>    * @alloc_capable:	Is allocation available on this machine
>    * @mon_capable:	Is monitor feature available on this machine
> - * @num_rmid:		Number of RMIDs available
>    * @ctrl_scope:		Scope of this resource for control functions
>    * @mon_scope:		Scope of this resource for monitor functions
>    * @cache:		Cache allocation related data
> @@ -199,7 +208,6 @@ enum resctrl_scope {
>    * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
>    * @format_str:		Per resource format string to show domain value
>    * @parse_ctrlval:	Per resource function pointer to parse control values
> - * @evt_list:		List of monitoring events
>    * @fflags:		flags to choose base and info files
>    * @cdp_capable:	Is the CDP feature available on this resource
>    */

Please add a kernel-doc entry for the new member.

> @@ -207,11 +215,11 @@ struct rdt_resource {
>   	int			rid;
>   	bool			alloc_capable;
>   	bool			mon_capable;
> -	int			num_rmid;
>   	enum resctrl_scope	ctrl_scope;
>   	enum resctrl_scope	mon_scope;
>   	struct resctrl_cache	cache;
>   	struct resctrl_membw	membw;
> +	struct resctrl_mon	mon;
>   	struct list_head	ctrl_domains;
>   	struct list_head	mon_domains;
>   	char			*name;
> @@ -221,7 +229,6 @@ struct rdt_resource {
>   	int			(*parse_ctrlval)(struct rdt_parse_data *data,
>   						 struct resctrl_schema *s,
>   						 struct rdt_ctrl_domain *d);
> -	struct list_head	evt_list;
>   	unsigned long		fflags;
>   	bool			cdp_capable;
>   };

Reinette

