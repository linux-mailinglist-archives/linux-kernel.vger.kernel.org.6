Return-Path: <linux-kernel+bounces-333722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6D97CCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BAC1F22D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373A1A0BC1;
	Thu, 19 Sep 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QP++M3rP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277219F10E;
	Thu, 19 Sep 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765727; cv=fail; b=UQdpMTo7vTm0XigNz362hSzHy7y/lZsknh5jky3rkANXRnDlEX68w44+mpdlQ/D2p1uU+pxo3iUkeU4R0yZZocoT+84akKQS8MEXAQ80Cg3DbBsQFvb2Xl6CDmt3pWdT4tWalThOikO+CsjkKIe+0mbn1MkxOFmam8fzpSYDU+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765727; c=relaxed/simple;
	bh=RZ0sC7lEtSORMUZKcexSycIDBvkt7eah5ifxdVm8W9A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SNVwZWw3kfr/5+kOI8Bw98fV7S4k5mY5WIukXKVd1tKF/VHa+D3QL4hUfCuNXEt5s4AofGFrIP2S1HoQES7x/gZbPTsQC/iOQhN535zxAzFCgvTsRtkktmfTl4mOZP7RhXZR+wC0zAz2EjJiDj76LEu1CLA4PAqD+ui/2xMNhk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QP++M3rP; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726765726; x=1758301726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RZ0sC7lEtSORMUZKcexSycIDBvkt7eah5ifxdVm8W9A=;
  b=QP++M3rP1sy/glwspsXzeOip7jvLIsfwnowntetei+x/aQ5D/ZFqywxy
   ZjCzeR7WA3BW1c0pfTrRUwuAPesBpWHfopXt6WLGQ74eoYIBFpjZIlfB1
   LXTXkxIUnw23gaM7zyr9d7hv8DWLMPEx6bSpCl1lRzbqCcpHIN1MXTUeK
   zmWKGHSDrVhUb9wN5/3od79xanWIYp6AEysnEKI9t+aOAWmpItCRXDM4a
   FzjqJC297PC475FKFsau5Kv76BsVSk8GVAuE2DEuPUPyqqrOARVK+2/U+
   cpQge8+EQezBm//7aq5iKJ2Swb+mxUMnYE1gxnrWf2V3yktY7tgWJj0E5
   Q==;
X-CSE-ConnectionGUID: X76Ya494Qo2FA8A8nIK6ew==
X-CSE-MsgGUID: uFuMDB8rSFybjIb9igs/jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="37125184"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="37125184"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:08:33 -0700
X-CSE-ConnectionGUID: 0r1t2gF/QZm4MdrfKwsF9g==
X-CSE-MsgGUID: TwWzO42cSTGr2ejY20LtjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="69605729"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:08:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:08:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:08:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:08:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLjFP7itHlMzbb66f5dJMapfQ/L8hwSO0CQGKrZ/ltZhvkZtIBbJkiDfumdkxgmF4QVCSAeuTUUxrsqiIBBd45wS0A7MN3/QEnd1pWbSoneVjaCtNoRDBqkUaFxEbjTNXfBMLvaWXQ0asHSWZh/dQ8CRo6hyrr/kvCVgChyx4YAv3qv9Xi3Z0c9WYeLdOBZCmgahXgALGzF61KqGhzmbd9gQkXt10tWyt+K8ctqNwUCYkybHary0QkVD9iW56oVZPvCz3/NkyMqylTbBoUOW/igFaHp9y25jlZVJD9QAmzt4TAD6x7hQAheLQxCAVyhU+BKv+fV0bR2nVZzvWZwE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX+G0JV8IJNGwhusYB75qRM28NwOvEvSt2FEC+dpvxc=;
 b=JGUuW9DnWwWfVcibAaOaFDFASKmpUpCyoF4IuO8nZSHr1NcWsF2nzqChgv9HGWWsW1pYUiIZ4T5S4gL30QOMxz8FHL040mnHrIhxjorTkkGRAEWw1K9Q+GpqN1IgCE3AjBOlVrbxPXmmSFnwb0J8rXSDb7vPlymuEijVyrz6g9ZjFIjrv3h72giEMH9WQGyeHc5Om/yN9x5x+rST0iAO8aGEvzbB6n+nMHmapw1hPcTXouo3C4mfKIFUY0Ms6BYEMJS0mvxDnAtJJ+sap+JYvWj6/NM9Y04enpfi8HTdmpyWUqyw8/3ntP1XlgSmiPHqJBby+1LUfilFqE7TDhBwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4599.namprd11.prod.outlook.com (2603:10b6:208:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 17:08:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:08:26 +0000
Message-ID: <02f1a542-f642-4efd-898a-a604e3a741f9@intel.com>
Date: Thu, 19 Sep 2024 10:08:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/24] x86/resctrl: Add data structures and definitions
 for ABMC assignment
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
 <e0520492d3417df6f708c7ff7b9163b64843fc77.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e0520492d3417df6f708c7ff7b9163b64843fc77.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c1a52a-7e76-4cff-976a-08dcd8cdad36
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEtGUE1ISFliOXJFbFFJdnJYU21yTnRuRWdJT1htdkdQcXVMQXphbmJVbHZJ?=
 =?utf-8?B?dVFoemNySkFodXE1K2VoVDhtVGFadGg4MC84cGRjdXIwQ1ZHdFJEUGVBaFNw?=
 =?utf-8?B?VHRPNzhUOUFweFZqR0JZaWJyYVZRaG1WbkhCaExQSWRwaG54RGhBOXdFV3lM?=
 =?utf-8?B?TTRQOE0xN05rRXFERU5YR1NSTUNDTk41MmFEWTBXZzJKNnA2R3NLL200c05H?=
 =?utf-8?B?WnIwNjNEaUFtbW1EajRjOXp3b0ZPUEYvLzZJMkV6cXlWb3JVMVNxelBXcE1L?=
 =?utf-8?B?YnF3UTNYcXE3cFMwZFoxdlUvNzB5citJdk1Bd0oyeHBtTzNZeHczYkUyQ2RJ?=
 =?utf-8?B?alRYMWJrSmlHa0E4OU5sTFZGOFhXcmlxMDdLVFE5SEl3SDFwZlYya1FJQ1Jx?=
 =?utf-8?B?S2tTU056Si84Nnk4RTNxL2N1T256L0pIYVN2SnhxNllNNjg3cFoxdk80dExq?=
 =?utf-8?B?SXhWMlBKcFRSdTJIb1kwcEhBU2tkalhoVVdiRGVMMnY1R3V6bVZZQTFTUm1M?=
 =?utf-8?B?UUJNRlg5Y3J3NUtyaUpnUWxHYTE1WjM4T2VWZTRVNmV1eUtGOGZ5VldHVGt3?=
 =?utf-8?B?WmQvZnA4bzZTbVBBV2ZEZCs1ZWVIT0pjQ1NQWXpkdEp0ZmRlNWo3cWRhQTlv?=
 =?utf-8?B?bmVMTXZ5WGc5WWQ5ZHd5Y3MydzlEdkhJQyswdHI1emVvQlJMbmJGRS9wMU1U?=
 =?utf-8?B?QVR3amRIQ2hhcmdDSURRcXdSYkdGV01IS2lVby95YndXNStxeE9lSU5OSm1u?=
 =?utf-8?B?cjErMWNTZ2tucjRtVUg5VlYwbW9pNW1BUW8xY1JRcDhHcTM5SVVDRVlERTVK?=
 =?utf-8?B?cDdNQzBFMFlxZFRCV3NDZXVGZkRreXh5eHplSndvSm9MejRvSVVtNzIzVTRZ?=
 =?utf-8?B?UEFyMkJjRERnYTRCTHhDWk1JL2pDdXVZTHBLSVhSRytqM0lwY2oxb0xzYWVr?=
 =?utf-8?B?UkMwQ1pudktaZ0lFdFJlYVpRRDJ1SEthZ2krOEc4OU56UGJWUkN3MFNiNXln?=
 =?utf-8?B?bEhTVm9BdVpUczNBYURURmUwYnlKelNIdXUveEt0UFI2RWxkd0pLeTlTVHBj?=
 =?utf-8?B?WW55bmFxTUVFK3MwY3pyYVlkb1dLdjJGeDZaQVFmdE9wMytSNS9HK2E2QmRO?=
 =?utf-8?B?OXFGajhsdDdzckV1Nm43UXNaQ3NsS3RySUNZNGdKL3NBL2JCaC8wdXBGV2N5?=
 =?utf-8?B?L0JqbWNxYURWL1hPN083TVRTeXZzZ2FZS2g1NWZFb1dKQzVqdmU5RWNVbHlY?=
 =?utf-8?B?cHdtKzFTcmYzejAzWjBGWnNycTB6RU9MQWgrdTZJeWxrUjA5RFkrVFlOTnFx?=
 =?utf-8?B?eXpnMUVKTVBWc1JMcG8wTzRWWjZiZkpCdzJ5M2c4bXM5QkdYSWhSM2MxS2dm?=
 =?utf-8?B?SUpEM2Y1RDBFUG94SjVocmhYTTBUSjdlQ0dTRzRCRUtQZnFMbnJINUptY01F?=
 =?utf-8?B?UGZ2ZjF6K212NHFUaUJHUkRjWnRwUzUyT3VaTklaSTdIaWtQRUxRdi9jREJN?=
 =?utf-8?B?YmRYYkN4V2ZHTjJ0a2dNUWZYZEVwVy9LekJyblNDaXB6cVNPeFlIalY1amg2?=
 =?utf-8?B?a0dkeW1YZ2wxbHptbTV3MUo0bnRRUTNlVGd4RW9yOFB4WVlOclArTllEU1dh?=
 =?utf-8?B?Nkl0VUdGRWZucytMRjRrSk03N2ZuSlJCSnY1dUVUS3RUVTJ6ZzdFb0szNlpS?=
 =?utf-8?B?eHRhWjBRU0UvUXZiZVR0WTgwVTl2SFZUMm0yZWVWdVB0NmxqaDU5MEtYMmgv?=
 =?utf-8?B?UlB6MzBMdmtEQVNEUXdkalM3bjBDc3BiK04rejZVK2ZhNXY3bGtmMUloWFhz?=
 =?utf-8?B?ZUJyNnFMYXNCZzloKzNXZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGovaXU0LzhVNHlBT2V0UEVyNzBQcHpEVlpCbmNDSWkyU2RQZVFVWUQyQUFT?=
 =?utf-8?B?SlYweGtWZnVXYVhVN0NnbGQrOWxZVnhGU3FVY3Frcm51MG1VMnhvUm9NSWlD?=
 =?utf-8?B?d3NtcHBlU0c4V2Q5aTh6RTBEb1F3L1JyMW1DZ3E4NVF0QUUrY2NaMGN0Zmk3?=
 =?utf-8?B?eElIWExBRGpwaGE5bG85Y0R5UzdTSTdkc2dpTm03MEl5Uzk0U3JtbVNNMDJz?=
 =?utf-8?B?dWtrbFhpVDhnbDRiMlhxbkZ0K1lKSERUU0lNYkc4MzdZUGlFMUIzTWF1eXVw?=
 =?utf-8?B?RGZ5c3pDZEU3bjZDYlVydC9jdHpoa20yd05xRWhOSisxcUViSC82SDc5RlZB?=
 =?utf-8?B?dlBUb1BPblo3Rmx0V05KYXA4ZGpZWStSbkR5OE44SXdRdm5FWitHb3k5SStq?=
 =?utf-8?B?czBxY0ZmSENHeElxK3JIVXU2MXY4ZUdYeDZwVUJvK3JSelJ6cDRXOFlZaXdu?=
 =?utf-8?B?ZHhuamZ6UmpEcHdjUGQwSlhobDBQWis2c1laYVVTS0M0YnJwK2YxQjVoRjNI?=
 =?utf-8?B?dFU4VDNRc0tBZ3hNdkU5c2ppb0NJZ1kweVlHOGZSZ0x4RkljUVhDd3p1TmJL?=
 =?utf-8?B?Q2QvdVhmZCs4ellTK2hnN1V6bWc1SWJiSjZBRHhYY0JkVEIvWWdWallyKytr?=
 =?utf-8?B?VnJ0RUNLMWs5U2tONGFCbE9JdnJUenNQeWtCNVpGc24yeFJXbEFXOFdGQ3k2?=
 =?utf-8?B?N3dTd01laDNHTGtpcVNTMHcxS1pBbzNRWnVwT1o0R1A2cHNDdFNsVVVhV1JQ?=
 =?utf-8?B?Y0NoVjU2ZWNvS3pCMi9Rdk9NakdMdGVjRWFhRUxnVTMrN2FyclZsYmFwR09V?=
 =?utf-8?B?dlB4MmN3a1dUcFJLSXBlTit0TmVmSGo1Q3psbllicXlaNmI3N1dEZTNjYnNx?=
 =?utf-8?B?OVFvVUdCVG40RDZzR014SEtIMEFyQ0V5cVNSM3dpNmQ3Q0xSNzBWUkhsYzQv?=
 =?utf-8?B?dFU4eFJtT1Y0RmlqSDF6dnEyamVLTS9WdVFTYkEzb2xvL2poV0c1bFhzREJa?=
 =?utf-8?B?TWtNMStPV1BLcUZDaXByQXFyUFFHZ2dRYzZTYUdmejVuY3l1TmZpY1c2QU9z?=
 =?utf-8?B?V1JScDBBNG5HMWx3SkQ0NGVwdkRzNVBZWE1ET3Zkd3FFTWpGSzZoVlhrME5Q?=
 =?utf-8?B?MUFEeE5YWTdGNko3dUpLZkVuN3BWQWZXVyt1cFNjWHUzeVdzL1hlc3pNdWo4?=
 =?utf-8?B?Ymw4dkRuc0RQV2ZlNVgrRDlocmQwYlQrazhLOGFtL3FmM2dIVDdraEw2WmJw?=
 =?utf-8?B?U3dYclN3d3pWWXNtTVN2WXMySExWdUlMQ3hhcWlWam1aTmdaK2d5V1E3SkhQ?=
 =?utf-8?B?NDZQSjc4SnJiVGxUbHREb1pMaUNHL1FNVEdsaEpaZEZmQU53OUh2dGdxWHYr?=
 =?utf-8?B?cGh2TE5jb1dQcXlkUWFES3E0MjBvWlhGbDIrajROQ1lrVm1GVlIrWWl2VkNq?=
 =?utf-8?B?UWhrL3BmN3g1T0ZhQUpjUkhNSEtWNUZhL0IvOGIwckg4dHpYTVFOTzl5endD?=
 =?utf-8?B?UHpVN2pjNlh3ckZNbWVxU2xLSy9lL0R4SWFVMlo4SWdwRzRGZFVwbHhBaEZl?=
 =?utf-8?B?QUFWQjFLSnBud1BWbkRCOEFGazdoSDFRVFFBdmR1Rjg0Q1BIYWNYd2FuQkFa?=
 =?utf-8?B?blg3MUNvUTQvS056QlpwQXlhcHp5VFY4RW52SXpCczV4NGNUeTlKTTJOM0Vx?=
 =?utf-8?B?TGttcGhTc0gwbFlISzQrT0YyTFlWajBoYWV0aGxFUFlKTU0yZjN2WURKZ3BM?=
 =?utf-8?B?c0Z1SVVPbmNzS0JSQm9JZGUvSExibFgyOGVFYWVhZWNOZHA4RE96SEhhaGhH?=
 =?utf-8?B?NW1CbXpoV04wM2h0WlFsK2dDYzA4MzRtRGNlQTVtaUdZR0xFK2NmSGYvdFE5?=
 =?utf-8?B?UDk5S2lVTkJPV0lkOVU4REpUREZKR2Y2U2ZJdzF4TkVhOVY0dHVDZFpBWDFv?=
 =?utf-8?B?bXo0UFVuTDB3ZEdWZlpnVjV5b2c3WWllcDFjeGJLdU4xTTBNMHRHajJpZWkr?=
 =?utf-8?B?YVFEOWtwWGEvajF0N2hMaTVqei95bVVzemVmeWkrV0t0Z3dPZU05TnhZMjBp?=
 =?utf-8?B?NHB5L1VDQ1o5UDlieThrT3gzeE5uc3NoK1lJck9mVDVScmx6OTRDWVV1SHd6?=
 =?utf-8?B?WFNycXlyRmdZUkM1ZTQ0NUdwYWl3WkxQUFRJSldyZFgybTVrdUtKVk1qN0dJ?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c1a52a-7e76-4cff-976a-08dcd8cdad36
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:08:26.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOYbx80WeI349uPW2CFOpHDxp1ujRUE+5V7Cg2DbtPPOf3inGI5uNJpSlar1pRkPuDPuEJgL1BulbdJ9BI5i3mYCJrGmtal/MbtDcqMXmJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4599
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> +/*
> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
> + * @bw_type		: Bandwidth configuration(supported by BMEC)
> + *			  tracked by the @cntr_id.
> + * @bw_src		: Bandwidth source (RMID or CLOSID).
> + * @reserved1		: Reserved.
> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
> + * @cntr_id		: Counter identifier.
> + * @reserved		: Reserved.
> + * @cntr_en		: Tracking enable bit.
> + * @cfg_en		: Configuration enable bit.
> + *
> + * Configuration and tracking:
> + * CfgEn=1,CtrEn=0 : Configure CtrID and but no tracking the events yet.
> + * CfgEn=1,CtrEn=1 : Configure CtrID and start tracking events.

Thanks for moving the text ... could it now be made to match the new (outside
AMD arch document) destination? For example, "CfgEn" becomes "@cfg_en",
"CtrID" becomes "@cntr_id" etc. Also please fix language, for example
what does "and but no tracking the events yet" mean? So far this work
has focused on "counting" vs "not counting" events and it is not
clear how this "tracking" fits it ... this seems to be the hardware
view that means "tracking the RMID to which @cntr_id is assigned"?
Please help readers to understand how the implementation is supported
by the hardware.

Reinette


