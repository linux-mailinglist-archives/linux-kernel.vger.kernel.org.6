Return-Path: <linux-kernel+bounces-251201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD7930205
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDF61C2189B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0A55E49;
	Fri, 12 Jul 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPvl+rLu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13D44C9B;
	Fri, 12 Jul 2024 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822438; cv=fail; b=irD3KLwjHyvMuKpqPKxd17xJnbT561alwKXiiaqpvcLNVbgoXUeX+YC0oVJGA1EzDeFVcl1vR2oYIJrTJiKGqZKFEh1jED6CER10e4601+LctF5mR6awqcfVZoyFwhl8SvG1n98ZubpPp3xpP1EEzoKcZdCpWF/QJdWHXz3TGww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822438; c=relaxed/simple;
	bh=ZELwp/qDqe8MQ9Nh8HKOyyylkW0twDLfHzK0WUkHn2k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ObxMLcHC58JVHpA2AfY0tnOvdUXZMB+UeVNfg4R2NcDb82LITMprrQgH9aXpDPzh6wF2i9x6EKJZyBGJU54rIjepkmWTQmmxp7R8IXuLj++ela7HuvGUZ3LvTfqB0n7cLCnfBGhDGsx4cV1vYxJT89MX5tUsICGJVEwCzBJUTT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPvl+rLu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822437; x=1752358437;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZELwp/qDqe8MQ9Nh8HKOyyylkW0twDLfHzK0WUkHn2k=;
  b=CPvl+rLu5cBCtFq3SBhWYu7lVC1GBWgcvn1wpvk4fMVXETKxqSNYtTgh
   Q5gDZ4q8maeHB0nXSnSnV+znWqirp1xiVE9yP0nWizMijDglp4laZEzm7
   WRAXoVKFAWeeUYRpBbG6cHUMZd8JdJgZnazYDfxveiggP9bpPxGdrcn2a
   AR6VJwCRA/u2Uxql5gN20PFiacLyVD3lAbEBJcpapDotoAj+UV1tLHRxN
   A7IEQatB4tVDeYVLrqxxiX3jradMf/ufsaJnvUa56WbhsOmFvHyhIFzsz
   qgwDEN/HYzsVvQNgrk/MQF0wbXC71HtLS8K/cJteDA0vGsMt8m5oJj18a
   Q==;
X-CSE-ConnectionGUID: IkaG52ymQSyYhUwaNifxZQ==
X-CSE-MsgGUID: hmQzewTbQL28tTEiTdKXNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18398064"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="18398064"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:13:57 -0700
X-CSE-ConnectionGUID: jzEXbX4DRMevDTE5V31CJA==
X-CSE-MsgGUID: 1NF+PAijQeWEnJ8/TqvD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="72248489"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:13:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:13:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:13:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:13:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWAy/CFZn6bK68y+1uvhkFoonUPyItzHv/h5APC0m9x9SqrI4WcxM/kcOyLXezl6PYoTjOczmGGA0VICCx4MIEK8HcbcXlQtv1ZPjYH+LhS22gKcZelglyn1Bzlusb7l8emOL1Y4BAcsoigCl1cbn2yvZAqJG4aW68DIdXhbl6+6/kReh8vbtShq+w6zlfHy6i7q/tOyoSFV/8LMZTDBp6ly1dX/IctTQIOAt95UDsTqWl33sAEH4ly2CPmNlLk2rDO6bju2lwPIvSz28Dj0iPjymngUcz+kLskHuiLAZT2/9thHCteIn+3aLlHaRmLPK2sQ2c+15P1tcIKr31xYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRaikQ+5FgGcDG5u/Lns/2s5JWN6fwxm++2fLMQ5AOA=;
 b=oEsZ0R1ADYAES1j2NdkJdmhkBmYt0n1TmfK2SHFnJ+DetHpLnqNO8WiRdf8cmC0FmZyrc9TvyhSHYwN1F19Xt5eYEVx36zVbGROte5hukK4rleTHAOHLTiQqXewAXBFfqodRpCbRdMs3aYGB94QVdbJGrCpi1jVxMeWCv1l8eTzODlx+ZWQV9ItkYj8Ex9aErXAXP6dovT2MoH4AOO7HODkkFfTpAdE3Tvb/abMGhI0Ke/fPcjxOvia8701loQQv/vuIsT6lEuXG31wWAkEY22hmBYLUcn9Al2/oK05BFT5kmtqYHmD0Q4rkoq8OuXpQ0Sk1Q8Wn/jENKERphogheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8003.namprd11.prod.outlook.com (2603:10b6:806:2f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 22:13:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:13:49 +0000
Message-ID: <826860ab-e87a-4d2d-8b41-3487a951f759@intel.com>
Date: Fri, 12 Jul 2024 15:13:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/20] x86/resctrl: Report "Unassigned" for MBM events
 in ABMC mode
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <81ca60c0029ba63fab7cfd6903ad115fad1d29fc.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <81ca60c0029ba63fab7cfd6903ad115fad1d29fc.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:303:b4::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cbe2bc-a9f7-4556-6baf-08dca2bfe811
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUtaOUgvVkNPZ3k4cWV2ZWRqdHpzKy8xdm1aS1N3andlenBrVEdkZjJjTzh1?=
 =?utf-8?B?b1NndWtCWVBxS1ZKVXNKWjNEVkYwd0p1aVJmMlFiS010RE1aanlPNC9ySGd6?=
 =?utf-8?B?ZkFLdnQwbTFZcEgvM0tEU2tHMUpQNjhwSk5IVEMySmc3Z2NVYURHanFYTUFW?=
 =?utf-8?B?REdXaGpSdUhaeTRkaTFUNGd1OGJOVEpYRm9WT3dOSndRelp0YmRtdTNqRUxp?=
 =?utf-8?B?SjFzMFl6RDd1UjFaSHNMYnFGbS8wVmpBaEdPNTRTeHVpb0hrUmtEYXhZRDMz?=
 =?utf-8?B?blJaR1J6ak9ua1VCNHFsZXVhekVkYTY1OVUrSnAvRmhsNUVVYldqbzBCeTRN?=
 =?utf-8?B?WkpLTXpTK2tlRU5Kd2tLYnVYRUR6ZXFvTmNhL0gzb3d4ZHZWVDJ2NC92ZmlI?=
 =?utf-8?B?TG1Yeng0WVA3V1JkSi9FdVFCT0FzTG0wSThKbVNLZ2pZSjZZVjdlRkZLUnBN?=
 =?utf-8?B?bWFxNnArNGZ2TXJCWGkzVzdFUmRxL3R1SHEyMGw2Ti9ucUV6N20xOEJFTVlM?=
 =?utf-8?B?bHhEVGxhaEJTM2JTVTBOenB4MFFmekJpMlpCSC94Q0dkNlhWTm9NQzVQNkVO?=
 =?utf-8?B?TGdxV2xqOXVDZ053d29jbTBFWHVqRUJHK3RIK0IzY24vMVFseWtlNmtjdVhj?=
 =?utf-8?B?RzlxRWFrd1hkM2c2eWttUjhVKy8xWDVHWW9LWmtwdTdmY1BXUlh4WXRHTzVL?=
 =?utf-8?B?V1hsNE53NWpzOVMxV1hlWWtrZllDZDYxUGZ3SGMwNUV4bjB4dDNmVE1FK3lM?=
 =?utf-8?B?UnRMQU12RGVxWE1tK0hJWk15SG4zTkxGZkhTbXc1OTIwUmUwbis3MndLMjdQ?=
 =?utf-8?B?RkM4Y2hWNWdCSnFPRHplS2JMeTZKVmNHS01KNXN1QmhxM1pRNytKakpxZnZz?=
 =?utf-8?B?S0ZPemlmSFlqMEExYUV2UTlTRDFsM25yaEVnRnF3SHdUa2IrTkQ1YzArUDRk?=
 =?utf-8?B?UWprZTR6ZnJ5YlU5a1FQVE9hUHpVN05wQkRaU1hTTFFCN0tHaCtzV3IvY1p2?=
 =?utf-8?B?U1gwNWpmdDVWOEFZMmdoWnRyMW42eWtnNFYxRUd5bnRaeWJCZitGSEg4cjlR?=
 =?utf-8?B?eURIUmxKbDNyakZiamJhSVdYc1B6Zi9lSVFsdjNDd2xxZ3JXNWo3TnBmU29G?=
 =?utf-8?B?T0IyTFMrL2tDVGp1ZTlhTmZNL1RUc3lsMHRGU1Q5dXpsd0xEc3dMdmp1ZVZP?=
 =?utf-8?B?RnlISHBYSVhjSmNnV09BcXZaV044aXYwVjZaT0k4UWYxMDJ4MDBtSzAxeGJs?=
 =?utf-8?B?TG5YMUVnaHJDa1IxSDJVaG94b1JZcGd3VjF6eGhQbDFweHhTNEZPdVZwT0lo?=
 =?utf-8?B?VEdGMHNzUEVaM2hDQ1djcTBTWG41WXdKZjgvMXlDQ0VnYTNKUDVlQXZQaHFa?=
 =?utf-8?B?UkhEWDRtRks2RytrRFB2ZnBRNFJLZTZ2ZzNXamlJdVlLYTlpUzZUWUVBL3U1?=
 =?utf-8?B?Qjc1M0xkQ2c0WTFNNEUwVlNHQjN2OUY0VDFNR0V0ODAwOGZnZGc0elduM3p0?=
 =?utf-8?B?c040d3lHRDBmQVJseTF0RGtUSncyWVBxcEk4NnM0aWJwdEJnZjMzOGE1V0Jq?=
 =?utf-8?B?bVYvUnNpZFArUWJUM2Irdzd2c2xXNXA3ckVtTjBRakN5c2FwWHdDZDE1S3Ja?=
 =?utf-8?B?RUpsdE8zYlJLMEdTZWoyNHBBa0dybm9WV2VWRHJPN2dkd1FuYlRkQmpaY2VI?=
 =?utf-8?B?Vmdnd2FCZXU5VStDZm5OUWRZTGZPcHpFTzVCbHRGU3RaRzlMbEoxSVJmNjhU?=
 =?utf-8?B?K2tTazVTQm9VVExGQ0N4eURxNitOWGdkL0xldnRwSElFM2lNd1VqaUVuYjZ4?=
 =?utf-8?B?ZVVxS0hMNHlaT1NQbTh5QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhQYUlDMnR5cGhkalJIdnFpS1JPZk5wZzYwNnl2aTZRL0NDempXQXJZTjZ1?=
 =?utf-8?B?b3J4TTRWZHVMQ3ZVT3NIVWpEK2lzM1c4QzZWZ2FHbnBNallHalY1bVJObGdo?=
 =?utf-8?B?a0wzMnE1bDllWU5na2Rad2duYldqTXMvaVhQVXo3bE5ibUVKQXdVNVE5UldX?=
 =?utf-8?B?VTZNaTZ2OVpHNmNIN1czYW5GQWVJa2d5dUpiRXhWMVB4M3hoUUIzcjFrNXpu?=
 =?utf-8?B?NmlFTE5hVW9aZmFBQ1kzSEpmUEtiNnQzME1GMDlnZkxabnpPaUdkTUZyMVJK?=
 =?utf-8?B?UjRSNjJ5aFpTSThueGk0VUhBM1ZwRWo5ZnpMUmk3YkxGa2x5Si9JVmtiNkQ0?=
 =?utf-8?B?L250ZUhDQVJ2UU16MW5OU1BtTWR5R0pLSitKQmU1ckIwNTZkOUxTd052ZW1C?=
 =?utf-8?B?eFlHU0REZjdxUy9QMGdLOE9MK25HQjA5aGNVbGRaVXlGSlFQZVM5eHhQQUVK?=
 =?utf-8?B?WXNWKzdPemxFNEtKWnl0SzBYcGNQTElKNGlWOHpKcHZjZlVOaW8vZUxBclpu?=
 =?utf-8?B?Q3FXalR6dnVFM2hnRFNiTk5ON0pYcjRBVjl0QlZKTEJvVVJ0N3pLaCtNU1RL?=
 =?utf-8?B?ZnZ2NFVOTFBqVkNuUHUramJ3ZTRFMnpMbWZCditSN21ld2hYcWlvdmdaUUFZ?=
 =?utf-8?B?SnlIUHRqeTZTUUQ5bmNlcUxwMmxWVXhCU3doVXVGUFIxRndnYmZxOWhZelVl?=
 =?utf-8?B?RUREbzFOOUVTL3lxRWFaVm1Ld1NvMjhmRmhCVjFqeGcyU3MvWlAxOXBEbmdm?=
 =?utf-8?B?SU9IQXpNQlJQSEovbXcxMFdSRTJNYndKQURVWi8yT3dVK1R0b0dMYnhEaFl1?=
 =?utf-8?B?ckc5aW1qb3M1T0lyOExOdlNkMmlWZnJFQ2FZMG1PZ25CMzJkRUFHb0lCUFIr?=
 =?utf-8?B?VmFMTFhxYVgwUTFTNFZpM1M5blRJK2J5MTNhUVBkRFlxaWIxcjRvYm1jNWp0?=
 =?utf-8?B?WUQ0NnllUDllTDVGbUVFeDNrU2JIUjIrTTB6UjR2VkMxOUpYR1l1WFNxc3Zx?=
 =?utf-8?B?czdQMm5CUjJ3ZERKNVRobnZFbDNOZW8rdzlrWHRRc2RnVHB0bFNqZEk3RmRS?=
 =?utf-8?B?M0U4UFpMNmpiMWZtTFl4UCtqT0tJQ09qcWRaNGZoMmtQZHNPMDFTZHVrN0I3?=
 =?utf-8?B?QkJmK0d0WHZPQmlGV0Y0Zk9JZnEybTBNdld0V2VZZFRHMDFmR0VzOUN6Yllr?=
 =?utf-8?B?SU1tUmFoNUdzRTRXeDZNT2pHS0djY1VmeFBUcVRLaHU5SUdYOFY1d3JkVFZ2?=
 =?utf-8?B?SC9lZEpKT1U0WDkrdnNkNzhXaWpEVzc2M0w2VEpPengvRmJ1Y2w2OUQyeUhF?=
 =?utf-8?B?dGtYVlprZEJkM1Y3M0lLT2NkTU1Wbjlod1VZbUQrVnhpcWFFYXJxREQydDl3?=
 =?utf-8?B?MlNMdlNFeHl1Q28zekdHaTlUd2c1NXFxMmxwRWw1TGFJcGc2alo1eXlxSWV4?=
 =?utf-8?B?ZjgvZXlSMEhwS1RsY2liaXY2Q0ZmQktldUVrT05XRC9heWcyRlU5ZHJ3bW1U?=
 =?utf-8?B?ZWVUQ0xKelEwT0RDYzdIdVQ2N1F6dTZLMDJMRDV4ODJDQmdKSzNaTE9KTGxI?=
 =?utf-8?B?M04zdE00UVJNUXJiNTVOTUw5c3gvUklLNmQzOElBMm9zV0ZxSXJzYW5uMkZT?=
 =?utf-8?B?QVNOOU9tMUZDd1UxVllyRmZVcUJXTmNUTmZqa2l6Sy9LNVRXVktTdDh2R0RN?=
 =?utf-8?B?dUdQbVR2UDF3anNhUnlCdFcvSmMzK215OU9YdEtIWW1Qb0N5aElnRnVWeTBz?=
 =?utf-8?B?ZytxSmdXYjVOMmloeTZSVzVENVBWeEF5NDh0NlZUR0RVLzVlZC9BbjlyOEp5?=
 =?utf-8?B?R2I4VFdTbnplRXdNNnlWbVdxNFp3VzV0dUVVQm0xRFBhWUEvVThYNGJ5NW81?=
 =?utf-8?B?WkNSSmErbWp5cWg3MXJVY2pLMWZIRm1BamlhOHA2Z2p4em4xN1NleXNCbVlk?=
 =?utf-8?B?NVpPaEhqaTVIakUwWno1UmlnRVhQUi91enFwdWZSa1F3djBOVGdVek1GUzc5?=
 =?utf-8?B?MUxSNnBaT2ZvQjdBVzE3OUNrbXVTaE5GL2hQek92MUhTZk9IUUVkREZtUnhy?=
 =?utf-8?B?MStrcTdxQ0dBYlAxcHpQK2Q0OHNiR2hnUytaWVo3NmVWQkd2RHh6YzJmR0pJ?=
 =?utf-8?B?SmJ5cTJOSmVJd2w1Q25WWEs3L0xLVVpPQVNkcmdyV0hsMkc5b2dSUkIrU3A3?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cbe2bc-a9f7-4556-6baf-08dca2bfe811
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:13:49.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKcBmc0alk5i6BMPqged+gng6yRo0cYeLLBsjbJDmcRZogL5BGTSdJscn1kgXW7bJkr/dkLPo/oZuNxzu2RqtsCV3qWkSKf09RFOPozyS4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8003
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> In ABMC mode, the hardware counter should be assigned to read the MBM
> events.
> 
> Report "Unassigned" in case the user attempts to read the events without
> assigning the counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: New patch.
> ---
>   Documentation/arch/x86/resctrl.rst        |  4 ++++
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 ++++++++++++++-----
>   2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 4907d0758118..11b7a5f26b40 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -284,6 +284,10 @@ with the following files:
>   	until the user unassigns it manually. There is no need to worry
>   	about counters being reset during this period.
>   
> +	In ABMC mode, the MBM event counters will return "Unassigned" if
> +	the hardware counter is not assigned to the event. Users need to
> +	assign a counter manually to read the events.

This no longer seems accurate with counters assigned by default.

> +
>   	Without ABMC enabled, monitoring will work in "legacy" mode
>   	without assignment option.
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..e60b469b7d12 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -562,7 +562,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_resource *r;
>   	union mon_data_bits md;
> -	int ret = 0;
> +	int ret = 0, index;
>   
>   	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>   	if (!rdtgrp) {
> @@ -609,12 +609,21 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>   
>   checkresult:
>   
> -	if (rr.err == -EIO)
> +	if (rr.err == -EIO) {
>   		seq_puts(m, "Error\n");
> -	else if (rr.err == -EINVAL)
> -		seq_puts(m, "Unavailable\n");
> -	else
> +	} else if (rr.err == -EINVAL) {
> +		if (resctrl_arch_get_abmc_enabled()) {
> +			index = mon_event_config_index_get(evtid);
> +			if (rdtgrp->mon.cntr_id[index] == MON_CNTR_UNSET)
> +				seq_puts(m, "Unassigned\n");
> +			else
> +				seq_puts(m, "Unavailable\n");
> +		} else {
> +			seq_puts(m, "Unavailable\n");
> +		}
> +	} else {
>   		seq_printf(m, "%llu\n", rr.val);
> +	}
>   

This still attempts to read from hardware that is futile to do knowing
that a counter is not assigned. Why not just print "Unassigned" right away
without trying to read data from hardware when knowing it will fail?

>   out:
>   	rdtgroup_kn_unlock(of->kn);

Reinette

