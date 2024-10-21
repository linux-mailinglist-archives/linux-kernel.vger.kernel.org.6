Return-Path: <linux-kernel+bounces-374656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24339A6E29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB9D1F21F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD11C3304;
	Mon, 21 Oct 2024 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Us8aVbW+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534816F2E0;
	Mon, 21 Oct 2024 15:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524704; cv=fail; b=ga6eT7zp13w3NA/Lmp/zxdcXkMFCE7LQb4zkYryP+GRmT/ZfPNiNcyRpuPEy0FJWdrjyOANnAXEBezjP8NfWK7CEH+IgCA5eRjHGUILk2rKY2ieLIrKA/ZVqDjDsobyal6vwXIGne1mxIThMdCBTB4NiYVVZweAO6FOwzFBTcuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524704; c=relaxed/simple;
	bh=DX0d4p+7x58OaX72fqI+0xAdf+5b55scUJ3k8fj+HV0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XI6zQjC0MQX51A5sT0SYwehx5os+PtBEmCMGZZWSvMk2u+sqExBK4lAU9nJ7zx1saGE7NMCVAuUsJRCeiWYSf2VhWIsMMTLyhm8+NVwsD/aPGZLtQL0BJnZLDr2bpH8qdCe2ApOHOyZ1L6c3mgPRtv4Yc8UN2DTH+q0HlRM9I5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Us8aVbW+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729524702; x=1761060702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DX0d4p+7x58OaX72fqI+0xAdf+5b55scUJ3k8fj+HV0=;
  b=Us8aVbW+JOSVSxUL/6Lu+dfzBRNby2+7APkB7RBfI5Lu+xbUpu632dTx
   3X07DmOlgMYrBKpP4zdNykJP6ix319+uxMsLhv780WiuTGowsX6nSVLaO
   cclKuPj0i/MsVdn3iApgu3iq+Y3so+GTcIZ2l2tb17jgKXB+JxfoxHPGJ
   je2sA5ZY/NF9PBoZ04+nMf+f+5+pKaT66eb5nvtqg25cvZ2LIH3/xJnje
   K7RuvW3PfcKbZJvN5PE7OqRm/ZwoMjjrKULcMPScaV8v3i0FYQVEnJlF5
   tomZKXeEXdaj+BZq204ujf86LNF3b17lDOanuFVqLhgrnUBgVFhAwUYvo
   w==;
X-CSE-ConnectionGUID: 9cvA2nSjS9mXU/o+IEYZgA==
X-CSE-MsgGUID: RdoT1AqwS8Kj44w1ZpWPhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51562557"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51562557"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 08:31:40 -0700
X-CSE-ConnectionGUID: BgO2Ud+qQmODXPTDwzf7eA==
X-CSE-MsgGUID: 6t5bA/l8Tm6YwHrNNzAc4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79557596"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 08:31:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 08:31:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 08:31:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 08:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g84r219DCuw36PoGTHGaPpYFWqxrzWLcWjxA74++Z3l0KMBYPerdqJHkW2k4egZxsy3bfka5ttV18azCn93LSYF0eHd0rQptZAlAkVJ3QuFErsV6xZ1Ng/RUMuaErZNJ3gJjrwtRdyj681Rzi9AFiGS80LNlzMwYwyGGUTqmACBrCUnDlleAnxn5imOaJcW5tI/XM7+p1cIsKu0S5V4NmIc7F+avvsi2bPsvD13esrsuk9fNp5YiwuhDmvx8mRFjLxIxKp76YhNuFTdFtx77539ftf1qeExWqBhQkJSyZJeyBgk9hHxRujXz7arHncBliJb6hibwHPNtFlXBbkP+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOqu24q4ETkLVnbgSCtGo4T0zjYu9Byp69ibfFRCToU=;
 b=U284qx8AkXOhY6oR0waDbe+uWX8xUUzPQF4ZwqiX5zg1Pxk9JES+Mbp/cqN6d1j+zagTf3IhOQylYMngKCqokniul7zUT6PWHQNqs0IVA8OpjIIW0jBiWQ1awWMWjmXEDr9ykFkul6WBqeJ7yvswUVUcrSej0JVqpYXRlqP23+9xlqFJLrXgp43K+jZpH2E3Lu1X5PronnaPn6xPV87fXev3hg1szz8act/lyjiE7F4TwdKeTPX26aFeWqtgfHB9lKwMFoGpMSt9NaOIsjk/jH5MqG+LnoWs7gWONB6LlP09WPjjd12kec/MYZ62BXnTuslnO6UDGD25nQwJlXKiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:31:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 15:31:32 +0000
Message-ID: <379acb61-0afb-457b-85d8-916f23b39e4b@intel.com>
Date: Mon, 21 Oct 2024 08:31:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/25] x86/resctrl: Add the interface to assign/update
 counter assignment
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
 <86c8fd4db89f264b1382cd22d7cf53c4510bf07a.1728495588.git.babu.moger@amd.com>
 <367f3877-e23c-4115-a004-1480ad2ab17f@intel.com>
 <78674f8c-963c-c6bb-ce8f-470d068299ca@amd.com>
 <c36e0c76-1666-4a31-984e-1ee6aed2e414@intel.com>
 <cfa7ef63-feb2-4afd-b05b-76335af888dd@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cfa7ef63-feb2-4afd-b05b-76335af888dd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:303:b5::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b49139-6dd3-401c-ee14-08dcf1e570f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjJQaFFjN1MwRG9qQWpSeURIWVRwRUU1Mk0vK21meFZJa3hWQ3RUQm5MOTNI?=
 =?utf-8?B?SHhpTmNuZUJSZmtqbUxMeWx0aGUxQzEwV3h6UWF2TmM1UzRnc3ZIaWxiS0Qw?=
 =?utf-8?B?d0xzU0ZsV3o1RUdyeXN2SlZPekVQc3V4TE9vRFFJdXcrYi92L1pzTjNzVjZz?=
 =?utf-8?B?amVOY1pqRGh5QlJyNU1lR3ovcU5rQ0djalRDVEhhV2tOWHIvS0JPbDJLUkpR?=
 =?utf-8?B?ZEE3ejcrRUsvVDR0Ymp3dWpkR1ZqS09GeEJFTUdQUkNtVTZIejRmNWx1TmRi?=
 =?utf-8?B?d3MvaENvRDBYVVVhcHY5Sk1vbk9iNVU0S3oySFd5QjVPODByNUcyWmNpZE9V?=
 =?utf-8?B?d2orZW9EeHg5Vnk0bkJBeXZMb0piWko2RXVucjF3QWJJZ1BIY25mTTRLM2tz?=
 =?utf-8?B?WlZHMEFFWVdHM2hOYTVvZlFBczgxMnU3ME1wTXhKOHdGd1ZYSDNtdm1NckRV?=
 =?utf-8?B?SkdSVk9oSVZZOHJ0YXZuVFRRY2hMemkyZXpEVFRGMnRIWmExeGRQcnFPQVNE?=
 =?utf-8?B?UkxodklLdDJ0WDA3VWllbjZKcTgvRExpUjBKbkg3WW16R05rcGI2bHkybS9w?=
 =?utf-8?B?bGRSaWZkcDVEWVllNUZBdEdZZXlXTVIwUHZQYUdkcW5wSXJlc1VWY2F4ZGpT?=
 =?utf-8?B?TjExUmY4VEVrTXIyb2lUNTRyNG1YQTh3Sm9hYTliL3lVZUVjYVk4cEt6cXhh?=
 =?utf-8?B?Mi9wMStHekt2dCt0V05mY0dFSzBZN1l4U1BNT1NkaEYrVFltdWgvN3B6bEJx?=
 =?utf-8?B?SXR5U3VqT0VYUVZzb2RhUUhjb3l0VGphMWNEdGlLOExzMUNaYnZxMThlR0NG?=
 =?utf-8?B?Y0VMTzRqWEoxUFlmdUp0VElldTBVK1I2ZTB3bUxHRDdlbU80SXBneFplV2Zk?=
 =?utf-8?B?eVl1aHE4aXgxUlNJdE9yL2xicjIxaTZzMVBYbUFmUG9XTXBzSk9SNzFDUUk1?=
 =?utf-8?B?OUx1cS9uZFZRUkhBQWRkNFVzUllaSmZaVG84NDNuN1gwdTBXaGlxbTRyQk1H?=
 =?utf-8?B?Q0ZNdFZxeUdLdllKRnRKUTNDbmpaTHlvNGVVU21EeWVVZ1Jzb09DZDdJOFov?=
 =?utf-8?B?MXBSTmNVK1laejVObndic05BbEplaUlGRXdaMDFmdXhidkZsaVJaZEhvNllz?=
 =?utf-8?B?NlFweFdqOUFsYUUyS3U1V3hiU2R2THpENk84YjhSVU9ETWF5cWtadEp2Vjhs?=
 =?utf-8?B?dzJQNEdFV1d0YXJOOG9kSWE2RlFvTkI1TEd2cU1mekkzQk1sdGhMUE9KWE92?=
 =?utf-8?B?ZVhOMERJb1lZWkN3MU5RL0JJcWhVVUIwTUZOTkZWWDBjK29HYjV4WDdELzFj?=
 =?utf-8?B?QVVPclFQMVJHcXB0VFplWkc2a0x5MmpRanVqTFRCR05SNVhOcnpvdDJLTmhW?=
 =?utf-8?B?cW1uUE1LQVNMQjdGSVk0QzFtZ0RxdS9uak1xZGFucFErK0N4WFlMWWdJY1Nz?=
 =?utf-8?B?OVoyMVJ3Z0NMR1IvRnJmclVCNEFhdWZSZjR6eWRrTnpXZ2ptR0h3VmlmU21t?=
 =?utf-8?B?WVpYQXl3RWpFcElVRyt1WDBUVXYzbTJhOHVIVkZ3NnhqVHJET1h2c0swOFQ0?=
 =?utf-8?B?dGpRRnc3YlU5aFc5NVJqTVFndldYZDRtdXFOMTZJMk4vQUUxTmpRSDRRem0v?=
 =?utf-8?B?S0N4d3lKcmNud2ZLZjRIQUNIcW85UW0zMVFTOEhqdGp5YkRTK2QwUE43TUQ4?=
 =?utf-8?B?VkxhVlpTT2FBK0hGWHJ2MzE0aFhJTmVhVVpqTXFhNFVBUzZHKzUyTmR4VllI?=
 =?utf-8?Q?rx/sWxu7O/3SKc1J0jSLtHhqb7cHD843us/8Cvd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE1Db0lPUmliclhzM2pKeXNMaC83dkFQTGdlMFN2a3c5c0ExUWtaMWRDM0hu?=
 =?utf-8?B?dGkvL3ZLUlh4eUlyK2xmVzdTRmVrK21lZndVSjl1dE9uZk5tMVBCcGltZi9V?=
 =?utf-8?B?VUhrL3hCcy9NTDFUb0tSTG8rVWlGNW1WWS9rR0Y2QXZHd3FMWFFkOU9oeWI2?=
 =?utf-8?B?V3RZd1czMlEvUzljZE5xT3NBc0FibEFWRGJlTUtKWFFrTXhOQ0RHMUx3bzBS?=
 =?utf-8?B?K1JkUHIxT0U1OENPTWw5M1NOOTc0d1pIL3JZSEhvN3lTdWpScmN6RXFQYlNs?=
 =?utf-8?B?U1RLL3pLYU1FOFlpMGRRNE1nei9UelNzQXpWdUJHbHhDTHNReVRWeTVZVnh1?=
 =?utf-8?B?c25RcUFSWjNOKy9lL2ZiMWI3L0thRjIyV3g4VGpmZ3NiR2FZU1J4dzVvQ2Fh?=
 =?utf-8?B?V2JOcWlheG5Ed0JvamQ0bUlkSFhnZ2laQU5qOFBTdFhTRy9UZmV6TFVvQ25i?=
 =?utf-8?B?VzNZeVlBc2QwczZEM08zNVFzQlBzNkZFWGxaeGtOSHVzQ3Q2T3ZqbzlZWXFu?=
 =?utf-8?B?RlMwOU5XNW5kMXlJQ1l1RmV6aERobWE1cmRqLzVWUmRhYUNoY2NxcXhwSVdB?=
 =?utf-8?B?S2lvRXBCV2VHM1dVUXdyMDRrR0x2OS8zNStOdk9HQURmbHczd3BxcjdPV0Z1?=
 =?utf-8?B?T2UrQURVOWNqRmwzNXhBNWZ4c3pHM0lBU056cDZ2L092UHpEUjJCN1ZNeG05?=
 =?utf-8?B?a0VROUw1czNmUnpZM3BML2o2VXRuT2RRSURRV215VXZ6NnNTRit0SC9JU3hQ?=
 =?utf-8?B?NkpHd1RiWmJ4ZHpSTXlSSTZxaUdtRGdJc01CWGlzWEJMZG45SVNQeFhqcmpz?=
 =?utf-8?B?eUExMjVGdXdrWjEwN0daR1JzOUZNWHJHcW9NTUJPQ1BhLzgwdzk2a3VSWW1K?=
 =?utf-8?B?N25UR1o4a3h6SktlMWRWSnFaT0I1SW5aUFhuOHIyR3R5UFlLblQ4ZmxUbVJR?=
 =?utf-8?B?UkhlZWxmTml5TUoxSzB4ZE0wU2pPSVF2bW1wcTVQWmhTb01WOS90ZHdXY3NH?=
 =?utf-8?B?aURwYTN0MXBpaUxkdUhtNnNJT0JIKzd1eUE2bXYzeERrMlhlWnRyUGk5ek91?=
 =?utf-8?B?ankzdDFhdFB4OFd0ZGxOMFcvZTRRN3BQeTBlbVAxTFJPUHM3STZFeXRYbXk2?=
 =?utf-8?B?am9pTFFkbG9PeDFERjVrMloyZFdGbHV6QWE3bzMyZEg1YUhrVlhiNUY2TXMv?=
 =?utf-8?B?UTRMSldsRnpuelRwRHkxUXZjWXVqNDhvbk9LTHpZeHUvYURDOWV6NU0xK1lq?=
 =?utf-8?B?cVRUMEtXUEk5L1VQQWNRaERZeTFMSWV2YUxtWUIzM0M2bXFGaGxaSlcyUERs?=
 =?utf-8?B?WlM4VlgyazJsaXA1YkJxWXpQcVl5bFFlQkwyeEg0Qzl5eFRYdEJpREJMbWVv?=
 =?utf-8?B?L28xcGYxREYwK2ZxcHkzVjVrZkpmTUhYcDRVaTZKL2RGOUNNR3FCd09hNmNX?=
 =?utf-8?B?bzd6ZHN1RGt1ZHhGNkk3NU5XMi9BdmYveVg1TzB2MGRMRnllMURvVjFSMy9v?=
 =?utf-8?B?VldtU2hicWYyQkMyQ3BxOFR0OVhCTUQ3djB1Snp3UUs0S2U0TVhzVEtVajFE?=
 =?utf-8?B?Y1Vmc3BqUURkREUrMW5NanI5S2ZBTTJpa3d3STlzQmo2cFV6UjQ1RXp4d0dz?=
 =?utf-8?B?Mmk2NEVMZWVkR1p3OWVVNjY2TEpkRGtXTThQV3pyVHc3cnh4RGFvQmV1dmxX?=
 =?utf-8?B?VDhVU0VLV1JsT0tGN0dkQ0E3SGRoaEdCSnJvK0lVTDlIZFBINGlvRXErRkdP?=
 =?utf-8?B?bDIwa1h0WWlneFdJbFJXM3haQi80R052b2J0THZrZEpuYURZN1V3aEp2eWM0?=
 =?utf-8?B?VUZ6VzBWdXl3SkFJWWtjNDI2NkNWQndiYzc1UFQrWXF1T3BBU0diTWxJZ2pM?=
 =?utf-8?B?Z2l1SUM0OFVqM1AzSW0yZjZURHhWaWJ6b2wrc0VGVDRld3l0Zm1leVNHOWEx?=
 =?utf-8?B?R00vVFNFR05XaU50M09RMjYzWkZMSkQ2RXpLbkdLUytIOWxnVlhEaTl4enli?=
 =?utf-8?B?QXIxYkJWcTMrdkR0VitRRlpTN0lpS01DYXB6dVdSQ241S2oxMXpMYittbFZ1?=
 =?utf-8?B?R05RYjF4dnBaaWpadGhrNm8yTHl0SFljdUZxdlVKeGk5MXZiR29ZVE85Sytp?=
 =?utf-8?B?V01tVWNpbFE1cU9OZjBBOFord00vRXVNUjY1Nkg1M0h6MFNTdXFBK3ZpRmRG?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b49139-6dd3-401c-ee14-08dcf1e570f5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:31:32.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc0ZIC+X6i0+Q3JjwSM9byUx/zZCLXy0xWfxjoJke1U6xmEleBBEzjqRzVBnTm7pisdkuZxdBYPiJ4hoZipq9YnjFhf30VA+SUK12XxBa3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/24 7:40 AM, Moger, Babu wrote:
> On 10/18/24 10:59, Reinette Chatre wrote:
>> On 10/17/24 3:56 PM, Moger, Babu wrote:
>>> On 10/15/2024 10:25 PM, Reinette Chatre wrote:
>>>> On 10/9/24 10:39 AM, Babu Moger wrote:
>>
>>>>> + */
>>>>> +int rdtgroup_assign_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>>> +                   struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>>>>> +{
>>>>> +    int index = MBM_EVENT_ARRAY_INDEX(evtid);
>>>>> +    int cntr_id = rdtgrp->mon.cntr_id[index];
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * Allocate a new counter id to the event if the counter is not
>>>>> +     * assigned already.
>>>>> +     */
>>>>> +    if (cntr_id == MON_CNTR_UNSET) {
>>>>> +        cntr_id = mbm_cntr_alloc(r);
>>>>> +        if (cntr_id < 0) {
>>>>> +            rdt_last_cmd_puts("Out of MBM assignable counters\n");
>>>>> +            return -ENOSPC;
>>>>> +        }
>>>>> +        rdtgrp->mon.cntr_id[index] = cntr_id;
>>>>> +    }
>>>>> +
>>>>> +    if (!d) {
>>>>> +        list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>>>> +            ret = resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>>>>> +                               rdtgrp->closid, cntr_id, true);
>>>>> +            if (ret)
>>>>> +                goto out_done_assign;
>>>>> +
>>>>> +            set_bit(cntr_id, d->mbm_cntr_map);
>>>>
>>>> The code pattern above is repeated four times in this work, twice in
>>>> rdtgroup_assign_cntr_event() and twice in rdtgroup_unassign_cntr_event(). This
>>>> duplication should be avoided. It can be done in a function that also resets
>>>> the architectural state.
>>>
>>> Are you suggesting to combine rdtgroup_assign_cntr_event() and rdtgroup_unassign_cntr_event()?
>>
>> No. My comment was about the following pattern that is repeated four times:
>> 	...
>> 	ret = resctrl_arch_config_cntr(...)
>> 	if (ret)
>> 		...
>> 	set_bit()/clear_bit()
>> 	...
>>
> 
> ok.
> 
> 
>>> It can be done. We need a flag to tell if it is a assign or unassign.
>>
>> There is already a flag that is used by resctrl_arch_config_cntr(), the same parameters
>> as resctrl_arch_config_cntr() can be used for a wrapper that just calls
>> resctrl_arch_config_cntr() directly and uses that same flag to
>> select between set_bit() and clear_bit(). This wrapper can then also include
>> the reset of architectural state.
> 
> ok. Got it, It will look like this.
> 
> 
> +/*
> + * Wrapper to configure the counter in a domain.
> + */

Please replace comment with a description of what the function does.

> +static int rdtgroup_config_cntr(struct rdt_resource *r,struct

While it keeps being a challenge to get naming right I do think this
can start by replacing "rdtgroup" with "resctrl" (specifically,
"rdtgroup_config_cntr() -> resctrl_config_cntr()") because, as seen
with the parameters passed, this has nothing to do with rdtgroup.

> rdt_mon_domain *d,
> +                               enum resctrl_event_id evtid, u32 rmid, u32
> closid,
> +                               u32 cntr_id, bool assign)
> +{
> +       int ret;
> +
> +       ret = resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id,
> assign);
> +       if (ret)
> +               return ret;
> +
> +       if (assign)
> +               __set_bit(cntr_id, d->mbm_cntr_map);
> +       else
> +               __clear_bit(cntr_id, d->mbm_cntr_map);
> +
> +       /*
> +        * Reset the architectural state so that reading of hardware
> +        * counter is not considered as an overflow in next update.
> +        */
> +       resctrl_arch_reset_rmid(r, d, closid, rmid, evtid);
> +
> +       return ret;
> +}
> +

Yes, this looks good. Thank you.

Reinette


