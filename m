Return-Path: <linux-kernel+bounces-333632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF8197CBA4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BC01F24361
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F2519F408;
	Thu, 19 Sep 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/oeEAxk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC5190477;
	Thu, 19 Sep 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760136; cv=fail; b=aObi3DUzqD9JqviyLmtOg8hBnwy/0kGoygurZWB2bkk/RFEjVRkIXpaH9M9yL5A+KCC3xoRLReg2UuLgf0MAZV0lIxTQ4A18ool/rws0IISLywKQD2frzWEYeahWdF4gs6Ly1kcz7k/70HZn8pgibU2N+4yxDauq/XxEgTbdPSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760136; c=relaxed/simple;
	bh=em+BbUztf1QPhVlsOl2+BTPAElRjr3MLSjg8JzdbpNg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ReIznCwiecBbvR2RhB2Zm3ffhqCQUXxhhT7XQ/Ki24Kzq7ZOd3M3EOFDuLQbRW8wm5KVMfqF4B+qik9XVEPpIlS5UdamonEX9P0mEBe2IMIdI/ew3X9N7D2WVz17Hypn7T09ClwHXaP2Dn9Vem6IlkD3sfmx/ysI2Otl32HzBvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/oeEAxk; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726760135; x=1758296135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=em+BbUztf1QPhVlsOl2+BTPAElRjr3MLSjg8JzdbpNg=;
  b=U/oeEAxkcf9r75jlf90vdCJblhxtN2ocjEGBHYgIVZ1gE0M8ZjAtyVId
   cIdEy4dbZfoobnNbKcfZHzbGzIoAMi2NpXtp7vZgCLlmuP+pr1W3X9oko
   xqxh2I8bzuuevlrhp+JKpMP0LSrMgNpprGO2tLio8AzTxyJF+htEKAeqL
   z2W3eLYScM2JI2TOaWzNpcpsmkA2p6ec4yP32m9lvsjAPfhfi9RNUR5Lv
   kSD6XZqUOZL+mN3Agy5Z3Q0gxGytP3VJeIyPZdn9qz75w5wnJ5eAYVZ64
   zu3WIbJMAxX/iJ6Ljayr57OcU81DY/h7cQZBDmh6uUX9+mo/kQZieO8zi
   A==;
X-CSE-ConnectionGUID: MrJy/PoXTZ+NF2JnKRS6bA==
X-CSE-MsgGUID: Fzf+7Hy9RperxcJ0IcxHmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13594850"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="13594850"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 08:35:32 -0700
X-CSE-ConnectionGUID: Rl8McKIATdC+p4AxuzFFOA==
X-CSE-MsgGUID: VxTP5EctTt2ZtRC5MZyJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100809994"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 08:35:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 08:35:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 08:35:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 08:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwyQSV7UOsXbNeQubjbhD8NUgiGOcM7XfGhICVvpZzFQcx/gic/Qivudjb9NKOI8FqjnPxsoF8TnraO/oStyLPiz5AZQVoGPIkPNiGF9I8On8efpnhz5yiWQ+Sz6wjvIRQeA89W7ZNiN39tmNcCaxm6Sxx1vuBzg5SREr6ulsSODKIcmxA8PEX3QQALDoAPicwrW+6/oJxMRfA3JCc6nPMeGD785X2Y6w6dWbiGV0A4ZEU4mZb6nbMo8NGdlkzxuylpy+rE+iiXt4GGFjhXCKnLSMijBzplAn6EjbfJi100eUxyy13yPb/K+/0b7rgxitBKL2tEkE6bXrb/pVox2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GTqeBkYkMe5gQ2N1yDpKVX1HiD5SMQt/PMBwFoUrbs=;
 b=ZLn5rodFL4MrMZwNj4+q7TOxnGKj5cSscZJK5uMS/A+RJwYMm1yG/2WX+MeUKx5ncg7gplLUoNP3g3gv2pgGwqjgpZZhP+bn9L1btHBVKjz3t9ECjHKWeDipMrNDn3x7XpJDf6PNremEe/02nnfNDR2nFhCuJSO2N42lfd908ast06KkR2bc9vtLnk9IYeibhfsJNuRK7SbjQBDdiPz8jFM1Wj6+mdIgGfBb99d+lMwQX+0z3WhyyWvtvQpDTOevv6D1f8wm2sVVxLrBD+8RmCOBFrvAakbsisFCNAoBdiJgm8/gAwjbrzgHQUhOMEaxv81Av5kheRIliEnfClyuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 15:35:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 15:35:23 +0000
Message-ID: <ec170d40-7390-4cc7-9128-d200df7405ee@intel.com>
Date: Thu, 19 Sep 2024 08:35:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] x86/resctrl: Add interface to enable/disable SDCIAE
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
 <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
 <cd0585f6-1d90-4ef1-9a10-7db50cb879ea@intel.com>
 <ecdffce0-796b-4ebe-8999-73f2be1e703b@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ecdffce0-796b-4ebe-8999-73f2be1e703b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaf64f8-66c5-48b2-628b-08dcd8c0ad26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnkyM3dVdEVJcGJCUTcyK0xQUFF0anNOTldGQ2tzd3d1blVXeXM2WnFqdEVw?=
 =?utf-8?B?cC9sK0VEUGI2YkdtbVpjczBJNTJwZlA5VEpQa3hMKy9DTjBMVGMycUpRMmV1?=
 =?utf-8?B?VFFDZjZTTmJJQ0FqdE9KTWM4UEpGWFl2MGFmQXBONWtldk0rQStBcUUxNmk1?=
 =?utf-8?B?L1ZzVGkrV3RONFRlSFdXRldHOExLWWt4bzRTazUyQlpsSDlKQ1BXaFQ5VGhK?=
 =?utf-8?B?aWowaVJrNDBHZ0xmZStFMzhCNTRRMzAzVzRKYkREVXFsMnFPU2NoWlYxK2hn?=
 =?utf-8?B?YXZaYW9mcXB2bndIQmV0Q1VjNWtnWkh4bDZMK0duWitMWGpHOGtES0NBazZL?=
 =?utf-8?B?YWdXa3UvM1hubFBUOUxyOTcxWE9hVnBTQ0VQSFZDSkpnWTEzdXE1WXlQeVda?=
 =?utf-8?B?N0ZGQlB1Y0pOMnlqdzhpQytLSXoxMWwxSzAxaHdkQ3dybi9XZkFIWGJDcnpJ?=
 =?utf-8?B?R3FDaEVGb2hSeHV1U2FFcjB2OVQ5K3FFTkFXcUVqMTE5dnlCNGFPMW96dTIv?=
 =?utf-8?B?MlMzOG1BZ3kzZHlnc2hDRnhTTHBQNkxnTVp5Z2NQN0krZk10ZkxHQUtFTkFl?=
 =?utf-8?B?Z3VvZm5sZjg4M3lYQlBMSWhvaVRnNVNla0k0TkRkTlRPTURadFBNZ0xSaGtz?=
 =?utf-8?B?TFNoemRXbVlFR2o3eGNIb1BpR1ZiNTJBSUVBazdPcWpVcGVrblpyK2RLZzAy?=
 =?utf-8?B?RnphazJuYm1pM1A3NkxnbW1Ib3I4YkdWY3ZuVE1tWnFaR3lEcjFacEU3N2E3?=
 =?utf-8?B?c3JkQU9hY3M3UW1nTnBrVGtxY3pqNnhGczk2VktpYkM4U3lMam5hWlJLWGpM?=
 =?utf-8?B?SEI0V3hIQVNsdG9sK3lwcjRHc0dIazdqOXpnNTkyTi9LMGlpdUwxN3Jva0NF?=
 =?utf-8?B?M3orNUpWNXAzLzhLUXZsRVNBRFVrWHlIYmV3V3FDV3duOFFMUTdOQmtuRE92?=
 =?utf-8?B?NDl4MzhCVzJmczYzWmlmWWFWdGNsak9NVEFKWXBjbDZCeXZRVXFVaFNyMkZw?=
 =?utf-8?B?aHprKzN2UGVhdXBGUXNXWDdnY3IyTS9aZGFkdHVtU0ZVQWRmVVR4MUF6dzVR?=
 =?utf-8?B?T3hTb045Zy9yTzd1bllUNG5VSXl5d1Y4YTBrL29WUmNDRk5LN2ZuYlh2Tks0?=
 =?utf-8?B?UnpSSDJMZTZQVlJXZCtRVVdKOEswVzVpZW1NVE5HU0svNlFrUENTeUt6QlhS?=
 =?utf-8?B?L0hqTGVnUHJsbXVJdERMeFk4bEw0U0RjNjFiYno5ekdIK1VYTXIvckVqbzhG?=
 =?utf-8?B?dDZSMU8yNWpqWmdSQWVzZERoS1VONHZBTFpiSFhwdU1lRlRIai9PVDFBZy9V?=
 =?utf-8?B?SHIzYk5vZllBNlJHM3JpVFFDdVRBSWZjS3FQcEJMelBHT0JYWlZkR1gxSlRo?=
 =?utf-8?B?dlBVekJDMGR1dHVveUYra2c4RzJ5TVN5SmhFN1VKMFFNSjFGRmhQeE1JVERh?=
 =?utf-8?B?YXg1UE1lcWhDT01FUm5zTXVYY1A3cVdZUkswSDZLNFRIWWlHc2J0bzRac1dN?=
 =?utf-8?B?ZlZpdjA4aEw3RTJERVd3R1RjL0R2d0puclVhbHIyOWhOQnp1UVNkTVY3ZnNx?=
 =?utf-8?B?ZWw0dndNVnZIWnZ0bTZzcFFuUWZpY3A5bnlYdVFiMXl0S3JjUk9MQWcvRnZo?=
 =?utf-8?B?bG1QNXlOYzA1blZjRHhNWlp0TmxWaUtUY0M4UzBnVzQ4a2pBZmpxRUJuc2NR?=
 =?utf-8?B?N1QrSXlFSXJqQ1ZoVDJxRnNLU0FGUnhTUE1paGdRUG9Ic1czNnFhV1VyQ0Fq?=
 =?utf-8?B?Wit6RXNsWmU2TXE1U2kwaGN2bkhaMGY5UFJvNThhWUFuL2NnbU8vRHpGSjQ4?=
 =?utf-8?B?VzBNRjI5ZVlvWlk1SEFuQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTBCWkFwdjJ0K2pLNE9malhRTXNkdXFJcDZIbUtrcDJDUVhyY0lBYVo3S0ts?=
 =?utf-8?B?RlhOcTZIQTdDelpGMkxYWGY4T0VmNkRVdThNbjRDMlJ5QkNUZnl0T3E2NG9E?=
 =?utf-8?B?SHg4ZmhWYzhoblM5L0VUM2txOXI2NWx2MlBqaElyRnZkS1hBMldNUEFMOUF4?=
 =?utf-8?B?NWFFOXMrWm5ZMGdTTWhGTW9tcHpCN0FlY1hXclhwU1pPZWNrQ1pDSHg3eWJN?=
 =?utf-8?B?cUZiM2l2V2VRZ29yb2IzWUVYdnJsSVhhUEFhMDQyTmNRUjUxalo3K2ZlcXN2?=
 =?utf-8?B?VC9iTnRURDZCVVFyeWZwR2FRZkcrWGR0aFVuSm51bmF0d3cyc2tPcjhJblVY?=
 =?utf-8?B?MnJNWWxnRkc2c1VvdWRWQkcwV1VBbzFhSTZPaGViVjBTdWF5bldtRFFKNEpC?=
 =?utf-8?B?L3ZxWU8zdWdvTEgvSkJTemJXSVhZenF3TDJSd1B6dmZrU2lwNkJaWVdvWVQx?=
 =?utf-8?B?TnU4aisyZk8yZHlWSWlCb2F2WUZucEdUWEZxSzB4UWRpczBrbTN1QWNGdDN4?=
 =?utf-8?B?ZUlTU0RWVlN6WXhTUnJ1UlFHWTVydzhJM1I1WGI3NmhYZmhKd2VGdmlnVjlJ?=
 =?utf-8?B?c296QmpNZmEwZ1U4UlNmaHE0cGlJQk1leWUxV2ZvaWttVkJ4MzM3TGNLNU9m?=
 =?utf-8?B?eUkzTW9FYURhVmlkRi9wbE1UYnpTdWs2c3FPRWxhclFublgxOWR6ZGNpcExz?=
 =?utf-8?B?NEtTTVE2U1pYOGxaeUxOV3laNmp6b1l0MEZVSTlDVFpvYW5aSGw5SENwWG85?=
 =?utf-8?B?bXV0RXRrVXJ4VDhRcXlPdmNTSml6ZU12S2RBdDQyV0VwSmttMUlkdnZlRFlZ?=
 =?utf-8?B?Sjd3YlFIb0tnbnlUS1J5ZEZSM09iUVBNV2d4dkxibFh6bGQ3WjMrRWo5c2E0?=
 =?utf-8?B?b28xbEcwWFFzcjU3QU9XL3VhOG9YMHZTVG0xZjB4dHAwOGFSTHJaU3RLWjR3?=
 =?utf-8?B?VXIvazBqN2ljZXFEVjA2MDM3b3BZbG91dUV4WWhUZzNzczJDdy9oZ3YrVzM3?=
 =?utf-8?B?UmUxY3I4d0ZSM1JBbVdNZUdId3FCd003MUdTTEhrZFQ5QWFGY1plVDVPeUNz?=
 =?utf-8?B?Q3VTUUpscnFWenRwR1VCVGxHWlYwMDcwZndjUjNPZk0zTFNjYlhqYWlWcUhQ?=
 =?utf-8?B?VVhocmhxVmNDK0lqdC9CYnVsMmMzM2RIS3pBa3l5cXJFcnhMN1NVOXJJdk9H?=
 =?utf-8?B?emdwaFIxRlZ3LzdwYXVka2xnK0JTOUZKUzJVRTVjOFo2ZDRsSzU0NGNUeUU4?=
 =?utf-8?B?L0pqZEhnSkt3QlhsZWtuY0VNMzJLSjA5a1JsZCtNamVEVWNYTDJ0Tm9wcGd6?=
 =?utf-8?B?c3FrWExacVQ4UnFiQlV0SEJhVGhQTFhkV05pN29qTU5NQWRiWkxpNmI0QkVZ?=
 =?utf-8?B?YVY4V3NlUmtEckNUSEVrem5xZDV2NHVLbmp5N3JUdW9UY0RKU0ErODFheWJB?=
 =?utf-8?B?RlYzcFd4Z010THM0SHJsOGdFckliL01XY2JrOUlPbFA5STRmS2lNWFN5enNn?=
 =?utf-8?B?bVYvaTJqbFFkTFBYMEk5TmpBVWduN2tVOHhVVmw4MjRIU056Qm9ZOFg2RmZK?=
 =?utf-8?B?OCtCNXNjbHFXRlJYbGlYdlJnUndQN1NmaHMzMG5MamljUElZK0NubXlwTWov?=
 =?utf-8?B?ekp4dldXQjdJdWhuaGtpOEdiZ3l6NC8xNnh4Vm1MR1JNakNsT1UzU1RkNGdp?=
 =?utf-8?B?eTIrZGxoMHNQNnJSdUxVZi9zS1UyMUtWczRhVkxKRkErWWdZcFF0cnBKV2s1?=
 =?utf-8?B?TFJ3eVc3YzRSYlZTK0VHUXgrT2lhTFZZLytlSFBQSWFEQUlaU1RPSFM2SlMw?=
 =?utf-8?B?ejZKTzVrWXZaQVlmQXRQRGVmRE9RKzVteTh1SUNRYUMzREJSYkNPeWYzSXY2?=
 =?utf-8?B?ZkJXaktzVk90SFRDVW85NG4xWTdyWHQ4OXR2d0JsUUo2dUUzVWltNkVGTGIx?=
 =?utf-8?B?bmpaNnFQSjN0NTgvK2lPWEw4eTNEWG9kZzFEd3NJN2UvdDdQbnd4cVVQMGlk?=
 =?utf-8?B?ampCZU1YbThWRk43UVJsbS9YbDNHMkx6NGdQVkN0NkI1RnY3T3pBaDFzZGVp?=
 =?utf-8?B?S21yTUVha1ZLOE5qQlAwbzhiTEZua2ZpU2tHeDh2QU16ejNveEswYVJRb2Rt?=
 =?utf-8?B?aTBVYlpUT21FYWtGNEN6Y3RKa0xKUTJ6VURsSXNxT05YcmQ2SmlxWGZiRmdT?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaf64f8-66c5-48b2-628b-08dcd8c0ad26
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 15:35:23.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URKLIBWITaK2V5wIWNA1Oe2J0Mx7FBIsQw1PQgSLT9XtrlPPm8/vzWPeFIz1y+CMawIXvQJFhxxyLYTtQv2jbr+Yw9B1x2WGkt0wt6iLafQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
X-OriginatorOrg: intel.com

Hi Babu,

On 9/18/24 1:10 PM, Moger, Babu wrote:
> On 9/13/24 15:51, Reinette Chatre wrote:
>> On 8/16/24 9:16 AM, Babu Moger wrote:

...

>>> +        if (enable) {
>>> +            ret = closid_alloc_sdciae(r);
>>> +            if (ret < 0) {
>>> +                rdt_last_cmd_puts("SDCIAE CLOSID is not available\n");
>>> +                goto out_sdciae;
>>> +            }
>>> +        } else {
>>> +            sdciae_closid = get_sdciae_closid(r);
>>> +            closid_free(sdciae_closid);
>>> +        }
>>
>>
>>> +
>>> +        ret = resctrl_arch_set_sdciae_enabled(RDT_RESOURCE_L3, enable);
>>
>> I assume that once SDCIAE is enabled the I/O traffic will start flowing to
>> whatever
>> was the last CBM of the max CLOSID? Is this intended or should there be
>> some default
>> CBM that this feature should start with?
> 
> It will start with whatever the last CBM for max CLOSID.

This seems arbitrary based on whatever allocation the previous resource group
using the CLOSID has. When a new resource group is created resctrl ensures
that it is created with all usable allocations, see rdtgroup_init_cat().
Letting cache injection start with whatever allocation remnant programmed
in a register does not seem ideal. What if, for example, after that resource
group was removed, a new exclusive resource group was created that overlaps
with that allocation? 

Reinette

