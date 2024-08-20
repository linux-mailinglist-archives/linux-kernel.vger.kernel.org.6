Return-Path: <linux-kernel+bounces-294572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ABD958F73
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACEB1F2346A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5621C579A;
	Tue, 20 Aug 2024 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLUmbhyF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5091BE222;
	Tue, 20 Aug 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188194; cv=fail; b=iwwyqzL0oajB7UdipTgsCc7HojlTi8y4y8a+JTmfeIdEjZHfRgE8dqm0G1Kock+9rD291p1M64FVvwFGdZTns2nNW3QifG9gjNYaR9t2GkPFFi8jUlQ2WTtS+z20eyz+BP1isWzdxpZZOjtrh6vOz9SopgcZ0f/RNgHFX7m+STU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188194; c=relaxed/simple;
	bh=HguXGRs++6l8VDiL5BYdT6SjeEjxcXm/Dz2tFTqKKaU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGy6NCF6Y/eIcQoncItUUvodtJCAMapnTVoilagiixiOcJ6t5u2Ynl40oRB67HfpP3w41B4xAsNfTmVQYOW7q5tYOrSv7sTfEKGXwz0n9fTiLSYqMr1USToj5Zw22kDbo4BWX/wxT9ZEgCE4Gd6q7Ot5rx2blb2RUDyWDCiaERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLUmbhyF; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724188193; x=1755724193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HguXGRs++6l8VDiL5BYdT6SjeEjxcXm/Dz2tFTqKKaU=;
  b=OLUmbhyFMW/hcLGLqJOAUoY+kc5EUDFBBcok89Ru9Tpfe7LsA3yJP0G3
   3P1m/5mrJTcSau31BAv7ni3/OIejtG6Mi780UL4P5j+bp6xqF+X5I2FBb
   F+YHA5muzZ5VwHVAllzvFKglyX2i5g+YdJqRbHM5s/l+n/DI9gPF2mZZ4
   g6xJCQfW9erXqPaWxT7tmyaC5xTXefLKbdh+w90TMNt2AFxKbAz4jW7TC
   qhK/rxaenmzTJIOb9u+XOyuYn7+9pm5gf/hDXK8n/NctrHr4vRklRj44J
   hzPowAF+CR139eOoqhySulQ52WemOXVJD1k6TtNOsl5ZmxIPZTMLmcay0
   Q==;
X-CSE-ConnectionGUID: MlqumKlNTQq58NTn7AkUyg==
X-CSE-MsgGUID: pjDPKcBARZyx0iZ99AR6LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22682904"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22682904"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:09:52 -0700
X-CSE-ConnectionGUID: Gu1xfiacQEumCx8ZRH/w/g==
X-CSE-MsgGUID: grVgVi2EQKK9G53MAXWRGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60903502"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:09:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:09:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:09:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:09:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O26hHdpSwjPkkyuxk3fSZkxeIEDGaMbVU339aAPd6pI+ZMNlwAJja0mnXb921KY0zoQEhpGSmDW0+fwunhF0bWAx0wljpg7qcV33sdl/FgS416IJzRrQzomDXErJR5dvpS8lQqOiauOK5D/p0AVUGb2WuhY+gQWJnyYaXuC/uzxLlVIrjpRrKnpPekwfLWmo9knnhJnvLiTiWJGS6igzQizBJBubBwFYZuzkOgWywkuOTS1PBdq4SzsjVAOwHnt7OazoCXMa358TdgEI+ogNMmNrBP5J9d1QdVskjUn+6BFJnD70grbPv/wRfq1gR4Jg16WM4E7RhEtVO0gYwCh/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFFPQwHrVmT6rdmORk737VX7WgKzOKocs6W5W1NywxM=;
 b=BOoCOrjVRWV4LmPgRE/Trwa3AnoQeEYs65Y4KrlFdzVAWGSLOy3K2yFpmhDy5b4XsBa1eq0BkH8pn220BaK5Ry60ut1SWPPeozpCsUcMiWHWmjsa6C/KJ5JgQb7Xuqyk3lTO8pgh1P5yhb6waOiIBMY+VG8lVn8TbXUNelSdv36pruIZpX5x1M09BO4omZPeNcKgRRnjRZTJG1/TiDvii5k3F3H0Am80o6FyI6sDHnEie5oP6nGBHirYlvB2Hm4skYae/+IReSBw9Aw10dzpVQVWjgiKa6LOCJeBxiCbXVzRVYzo+PpM2N+rw1JDTtAr+5rk0+BdKezN9esK0BJakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 21:09:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 21:09:47 +0000
Message-ID: <4dfc1e52-67db-4126-8b7b-81b400de0cbf@intel.com>
Date: Tue, 20 Aug 2024 14:09:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/22] x86/resctrl: Add data structures and definitions
 for ABMC assignment
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <337d3ed1eebc662dbc7e536aba49987c2396972e.1722981659.git.babu.moger@amd.com>
 <498fead6-8b03-4a68-8fb5-15c239e9b63e@intel.com>
 <49ee6ebe-96a3-4e3b-bb60-090be2e9e17b@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <49ee6ebe-96a3-4e3b-bb60-090be2e9e17b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:303:8c::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 11537c4f-b31d-45ea-1bc8-08dcc15c6c34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkNBeEI0bTVEWXhBL0t3VUwrOXdoNnJJTktuWEo0ZCtlcXp4MUhrYU4xUWpC?=
 =?utf-8?B?b0dFYlhHbkF0dGNoNlU1QWNPTmtkYVQ4WVhIYXJWTUFud0xNM1pRK2tGR0tj?=
 =?utf-8?B?QURDSy84aDJOYnFHSlI5dFpDc01iTVoyU2ducnlRUk1HSE9yYlFTaFlKdE01?=
 =?utf-8?B?Q2RWRUVWWUQwQ3ZibXl6eGx6NDRzMytFN0k3cXJEa0tpZ0pRbGhYWW50VTNl?=
 =?utf-8?B?YnpmSlhvOE5ZZXBJYUIrdUg2Q3BxV0F4dTVqeXRvb1pNSEpOOUFFdkhmdVFQ?=
 =?utf-8?B?Szk4WTRCRFh3T2thWTZMN2l3OWY0SFhnNTJta0F1ci95UzVpUDZWdG82Smx5?=
 =?utf-8?B?V2RZYXNQdGNwbVFDZGtSc3RzWTNEQ04zeExYdW1VWlV2bEt1TzRnczVkTFdP?=
 =?utf-8?B?eGF5eEMxajVjUHFHWUp5V3JyQzVIbHB3TXFtc3lGb24yWDQ4MFRMQkx6Zmhv?=
 =?utf-8?B?ZEE2WTFJZVhGSmo0ZFMwcXB4aUQ2d3VkYmM0SmlWVURTZStDVU5HZVBGV1Nj?=
 =?utf-8?B?RHkyQ3dYL2ZWWkVsRTdUNDNWbEtLT0RNT3dUK0JFTlBELzZ6VGRyYXJFWDQ0?=
 =?utf-8?B?ajIzRTk4anJpeWwxbzZ0MFpXdndSUFoyVVdZcGFGbEJvTWdRdWVMUjZFL1gy?=
 =?utf-8?B?N2pNRi9yRndBR3FNb0gwK0lMcUoza2t3SGp3ZUwzR2VFalEzOGdOU2ZBc1dt?=
 =?utf-8?B?SjhCUXl5emdMV1Bxanp0cTZEZjRTVFk0cjdzZXk5ZEtOZnVNM0J3eWI4Qi9o?=
 =?utf-8?B?Um5hL2piNWZ1SXl1bWxrYVdqRG1sTmxFeVdQMU5hWUpDR3J0eklrU29tZHYx?=
 =?utf-8?B?Q2VaNUszeS9ZWkFaTzNvYzIyajlUaUdwZ3ZQTlNCUmRqVDJQV0crME9BUGNN?=
 =?utf-8?B?dGM4T1FqTEYvYnVGRkRTd25tS1RyUjBhTXB2dVZISVJnanRnV2E3MDZGVmEr?=
 =?utf-8?B?NDUrbGNOaEhIR0l0N2pneS9HZ2dZWk53dUYra2MvVWRDdEpiaHc2U0ludjNR?=
 =?utf-8?B?SjJ6YUY0Y2NtdFdWaXJjQ1ZOZnMzR0R0SHMrc0hIeDZ4WVdGaFJoQm1NeU16?=
 =?utf-8?B?cFNhNHRPeUNNZUViUkk3bnhjZW1zWDRFbmFnN0EvekUxTGF5RnZFREZKUXg2?=
 =?utf-8?B?a1hpTlFiWGNSOWRYSll5VGx1dHllb0R2Q1U2ckVPM3Y1SzJqdnUwL1lPSXQ4?=
 =?utf-8?B?elZCa0NmWE9QY1JEejY5SVhFUFdLay8vZ1lPd3J2OVpQOFBramtzSEp4NXBu?=
 =?utf-8?B?MGF0MlFiWWZNUUpEd3E1dW5oblc5MHJDanIrOWdEZ2tZZ0g0Z0ZyMXk1U3ha?=
 =?utf-8?B?VVdQOFREdUl5YUhvTFBueEZkZ1QzdzZDR1l1Nm5BUmdJQkordmdMcUFnMEgw?=
 =?utf-8?B?RGlxbEpvcVVKK29aYmdNaHlJVDAxRDR5UXh2ZGdOTlFkSy9XVTZHUjFIY2tW?=
 =?utf-8?B?ZUZvUzhDMlllcFhXaytCcTh5SzEvUjVlMnpkZVQyR3ZjcjJGaERpL3RJQ21R?=
 =?utf-8?B?Y1BnSUJwMVhXcjZjTnhnQklXYjVYRitBM0YxdWRoYWYyZXlnQTNKV3d2RFVx?=
 =?utf-8?B?b2pWSU1ONzZSOXFUOVhKY21pTFhUYklxa2cwZGRJMThvVzUzV21CVC9rejRy?=
 =?utf-8?B?bTVxejk4OXhJd0FVZGM2dk1CRUVnWDRQMUlHRU4vWFN6WjZuQVJDOExLS2hU?=
 =?utf-8?B?TzVFeUZmSHhJYXpZTFlheThKTmx3OTlNY1djaThLa2xvVWsrVGdnTmJFdVZE?=
 =?utf-8?B?c0w3NDVyalhMeVV6VHhpM3RJdXg3azNjTERoVndRM1dsbXI1Q0szRG80Yk5T?=
 =?utf-8?B?L2t4NUZsMUFIbVhQelVidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU5Rckp3SkZjN2J0b3RuUXRKdGhCZmV5VkFTUTcwbWhTUk9tRVlncFhZVHhD?=
 =?utf-8?B?ZGtyQlNoTU9aVjY2SG1FRm0vYVJZUFphT0lIU2IrMHpGbFRtdlpQN1N1WHNU?=
 =?utf-8?B?cEdiN3FsbEhDejh2M0xQdngzRjVrUFNQam4rZTNjcUVrNTg4YURPcktnTm9S?=
 =?utf-8?B?VU5HZ0ZuMC9Kb1JhNXRtYWs1YkkzQVQvMlpiaStIUWozL3pmV0hIcHg0ZUY1?=
 =?utf-8?B?cDYvQnpKU1pxWXpqRW9hWW9XYUtseXNzdTlpTlJFa09tMVIxN0RIUzltQTd6?=
 =?utf-8?B?L3c2cE03MlRNeTF5bkhEQStIVmFZTlc5UERoUXpsK2RVc3VDUFU1QldmK1FN?=
 =?utf-8?B?cDBFQ2JiVjQwOHlrN0FSZUV6cU1ZZHo0Y1JZMDVBVkM0KzYzZnV6UGs3L2t6?=
 =?utf-8?B?SE1nU0RIR0c0Q1BkK2NvUDJOZDgwT3NXblZvemFkTk55VDhoMjJuMHYzcmZs?=
 =?utf-8?B?NTZYTVNJdS9UWjJOZWhKTFFVZmRDUjI3NW1lMG9UYmc5aEJDM281VWp4S3ZS?=
 =?utf-8?B?MjJ2Mm1DZGFLWi9uWEQxalN1NGU0QjNvM00zTXpPcUVaS3I4Zk50M1l4NXln?=
 =?utf-8?B?eWhxU2lOQjBTQ1UrdWkvcHhvOUZsbnhmVEdMZ0pDbkwyZWRjM0c0VC95SlhU?=
 =?utf-8?B?TWM5MVlISW9nSjh3czA2NzA2YUFzVFI5UFM4Z1JoMUZXQ0x3bi9yaW5IbzZD?=
 =?utf-8?B?aVFtUldWUi9hOHErRGRIWVcvcG9EbGlNckpVZG9MM2xtMFhPRDNuMm16SjdC?=
 =?utf-8?B?YUZUOXB2L1FlYlJBU2daNXZwMGwzTWdiU0lXYTJZb3lxQzROV012dDhUWUcy?=
 =?utf-8?B?UGlzRDFMTk5DR1BNVUdCODlneUhER3J6RVoxTEVYbUJSMkltUDdwRDg0bGgy?=
 =?utf-8?B?aHQ4NG04VWVGSVpUbGc1WndaY0trNnNWb1FQNldCRU0wSjVjSVYxd1VjQ2Ex?=
 =?utf-8?B?WE5jNzVHZkxSMHBUWUdGOXZJNW9jbERsTmx1NWZ0a0dxUWdCWmlrdXFKL1BT?=
 =?utf-8?B?Q2piMlJmRHM1QnU2eks5WXAyZnZVVks4MzY5M2ZCQzlBTE81ZTFFUDJqWDBy?=
 =?utf-8?B?czM5OEQwWVRBV2dleEFPNzZ6NUd1VUpGWFpKQ2U2WmhCaDFKWGZHZ0hmbUt1?=
 =?utf-8?B?QjJsaEJiM2JFb2pZOC91ZzcvdDhWRVJod1NvMmJldEp6Ui9uMDBNcUcvcFBP?=
 =?utf-8?B?TEZhcnU4RkNRRFB1amFySytFUzZWOTZ3RGZTMGR6NW1GS2RKTGw5RUNqdmw4?=
 =?utf-8?B?RmpVaS8vSlNFb1cyd1FuQUNYbWo2eG5VdEpocU1tU3hsVG12TkxkTnFkbGJQ?=
 =?utf-8?B?Z2VCV09RbE1yV3Z5TTRzWGV1ZDljS2RWdmgzckNsM0psdzJVV0RKWkN0UEla?=
 =?utf-8?B?dEtLeXRoaDZTaUU4bElYZ3JuUjd4SzhCOVhNQkRYUzNuR3ZmbGF5aExJcjZR?=
 =?utf-8?B?emJWUHRNbXRFU3VLK0sveU4wUzlnSjM3OUhCZFAzNW5NQlhwOHhWVDhPZzhk?=
 =?utf-8?B?d2loU2diWVNJc0VCZUwybG5CK2k0VGwyZ1UvQjBYR2xQTDNEQ1NZalpGTkc1?=
 =?utf-8?B?Z2VtZExwNDM1cDVtTC9qUXFwelRnSnRWVWQ4NWxhdTluUGdyeTV0b1NzL2s1?=
 =?utf-8?B?K1JUcjd1MWJVSHZYbUo0bWJnKzgzK3FReWhXY21PN3VQNFNTZWltR2hBcnVB?=
 =?utf-8?B?KzIwUTZoYS81T3RPcERmaTF3MTgwd2FtV2JGVUM2anZQbXlJNlpQQzB5Qjlh?=
 =?utf-8?B?eHhpTzMyWlVuemc4NmxyVGRISXZNNTl6Z0wvUHVFYUFraCt3Zjg5TitrYllx?=
 =?utf-8?B?VWdkVGZicjhTQk1HK3ZnVDNnakRpZEZZYldmWEJrcWZHd0hUaXg2QldwSXVF?=
 =?utf-8?B?emRYNkZZMnJMeitTNUl5L2E1dzgyTHp2WXZNUE9oMXkrSGg0RjFMenM4MDM4?=
 =?utf-8?B?Vk4ydUNZdjVKNXFkVFpDTzBzL25mTmlCS3oyUGNkYlRJcVd1NEVnUDdpMlEz?=
 =?utf-8?B?UXRmcld5YVpnVzFtUEVuSjJkNWErQ1dXKzJxZ0d0SDJwSHViZWw0QzJyWDZ4?=
 =?utf-8?B?YVQwQ1lUYjljMThSVmhIcVozbXRwamZpT1NJK1ZzNlNERUQ3ay9aZStmdTNm?=
 =?utf-8?B?YW5wUlpvWjE4bHRKSGxzM2N0eE5paStpRndHM2loK1BCVzdTTjZDb1hKdEFq?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11537c4f-b31d-45ea-1bc8-08dcc15c6c34
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 21:09:47.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcJNiKRPu+nikQn42UeLLP7h9oUqrbzXesrh4VURZvihZHRlw5cjmuZu6jKeF7po1m+rQG8j4HCw0N/3UYGicQcbZGkS5P1YEd6r0dgoIfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
X-OriginatorOrg: intel.com

Hi Babu,

On 8/20/24 1:56 PM, Moger, Babu wrote:
> On 8/16/24 16:38, Reinette Chatre wrote:
>> This patch now only introduces one data structure so the subject could
>> be made more specific.
> 
> How about?
> 
> x86/resctrl: Add data structures for L3_QOS_ABMC_CFG MSR
> 

Looks good to me, thank you.

Reinette

