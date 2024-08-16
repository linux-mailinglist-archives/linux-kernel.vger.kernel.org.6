Return-Path: <linux-kernel+bounces-290189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E570E95508A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0DC2840C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64A1C3796;
	Fri, 16 Aug 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltDJZmhA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056A71482F4;
	Fri, 16 Aug 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831765; cv=fail; b=oyN4D74qVbmZc3XuRO1hKiu//gMnIf1xq5pvbDqMBmGT8sQH8PoFKITexvw5S8V/Gx5TjJ4+0y1Zxpg+e06sIQInC3Pq69PW9O5LdzpyKT81NGdtYMALKAlv3hVOy+xVJEduQkiRXxdPi5DSthEiLcC+8i/bz6qf9q5PD2UEzEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831765; c=relaxed/simple;
	bh=Joahxcl8osLw9uMrtBWa7uTzqVFVj7kn7p6ZhQSIpiY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bD6OQ/lvLpP/0wH2rZIykP5euJIi0N69Jj51XbCDF5rSgmy3aKwfeVyhGbZ4p1SbG4HoDGs9vedG36qbFxRTPgWmgXwSF+xvKMieRdL9gpeacogriZBkHd2phpCnuvkUsEVt82mOFJPyxZrABLM2cjB1RuTDR6ofdHnwgG0KLIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltDJZmhA; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723831763; x=1755367763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Joahxcl8osLw9uMrtBWa7uTzqVFVj7kn7p6ZhQSIpiY=;
  b=ltDJZmhAZI5yuDp+vfIsB2WS3Bw/3IPh7YQMwGyoHz2qnXPt6eAzF+nD
   NpEpghhaZ+xh87UV5FzaYsW31I6bqYRVHcI16MOo8KCRc+QUWwhim/y+O
   t55Gi8HdbB4zTN9HvTbEpKOXjVrJjBlxs4BDKUHWVuUxz15iEArJltwtK
   b6H4c++lhfR2i0R84UNjuEuzGtNShCOiOvT8pL19tcX7qForB0SAVpEEe
   +wMj6VunLrBbRXhbHRTdaufYQiLKDjfxnomr7IDxg3PIBEWF+5Q7XD9BI
   sNgsYNrz83JZU+vadxMluE2uNYkgZndcYyqtehZ5BiECHHeZa+NqgqDkE
   g==;
X-CSE-ConnectionGUID: qfO584YYTJONsWLVMTmbLg==
X-CSE-MsgGUID: KXcoX1ubRPmcM4pk8exaQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="39652037"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="39652037"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 11:09:21 -0700
X-CSE-ConnectionGUID: KbNhurR+SymVcj90avPY8A==
X-CSE-MsgGUID: noAEh+rMR/qs3EZzKB81bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="82954260"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 11:09:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 11:09:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 11:09:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 11:09:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1buPdPcPN0LbrO1PJB96sUsxCBrlPD26GZfQUF++H1J+oLTMuln0EzjAqatNes5pXh5Geh1bamhtccnEnNwTXlBKLBxX0pEqszSIH9paHzWr4SKLecaBo70nViBSkEx8UW3RMKk4UtQoOjk6Iycu7e3N3QOkwcLJlvXkN7WpqYONfuYo4wUe7W95b7LzIf+7dKQ9JK0072ufLX7TY40XAUAHWMcAX5+IKunA4V4F3GSnTbm9YI1fjvYoO3c8YYlfVCfVxMG4xW9B2173ti0Bb6XOw/GJCo6prwkB8G/xrK4AYcYchqDviD5a+aRaJ7cOx6MOFYKMPwoxCrd6ArKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJr3U9Euy6OujDkJooLTGTQ1ZO5HP1NGf5lK3SDeh5E=;
 b=jhXLD3HjMmb1SBL9OAqtPO0MBfKAQNKv+8Jv/zN4Nh5q6Q5gs1/SW+Nw541iDwcy1jiZnV1q+Z623jZeTi/OzHbGS9yhriUmq1CDdWbTIFgxrUys7you0Pvc07+95yXOo/lkoyMsSKSi3RRA9hL4HPO7n3FPkf4EGICLoCrF0YepQlJX4B1eW7dreThVhPVSYUkLMJPA1rnmtLOhsa4/cWLO5lLqJ1i6xIWrqI/gJFmGGRtWzqBV3UdYLqDrIaY92v4K2/34DNqaVJv+zgypB006oLiaMqnRQJXLjqXrr/TmUUVy85TkPLC8Y9ZJ5/A0A5txLr8WH2fSR5RzHhfZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 18:09:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 18:09:16 +0000
Message-ID: <56aae68f-b590-42ec-a6b5-de3af97a8091@intel.com>
Date: Fri, 16 Aug 2024 11:09:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
To: Peter Newman <peternewman@google.com>
CC: James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <mingo@redhat.com>,
	<bp@alien8.de>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>
References: <cover.1722981659.git.babu.moger@amd.com>
 <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
 <983fded5-48f8-439d-8afe-45b60841985a@arm.com>
 <8c93c091-39b3-4219-b892-9df2747eb91a@intel.com>
 <CALPaoCjmRyP00b9rTCjpxwLDJ2rYkQ8HuNMYJA+qVNo5a4Q9JQ@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoCjmRyP00b9rTCjpxwLDJ2rYkQ8HuNMYJA+qVNo5a4Q9JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0357.namprd04.prod.outlook.com
 (2603:10b6:303:8a::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b812bae-1b92-4491-184a-08dcbe1e8a58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0RITllKV1c5eElhK0Z6WkFUNDlzdFFMYmVUSEpmaDhJN0F6ZC9vajlFUzRk?=
 =?utf-8?B?Qng3R3grbDhkckQ3RVFOdGlNT2l6UGdlWlRHU1hKY0tvbk9VdEpZMUsybnh5?=
 =?utf-8?B?U0xjckNuaGRnV3o5TG80bFJ6K0JSaDJEOUFXa2YrSE5aa1VFdWZVc05kNEN4?=
 =?utf-8?B?eGU5WGNPUmIybFNBUld1eElxR2xtczRLQXIwdXBKWTRzanNJVUVxZTYwRDZM?=
 =?utf-8?B?VDV5Y3BVWWFrWFdaK2FER09Wbzc0MlEwVWNRcGRUUFNHd1Rib05xdjRFU09E?=
 =?utf-8?B?Q0RIZGNoZTdEc3BXR1ZNTkUzY0srTHk3bi94akVRamxsTjE4L1BoencyeFc5?=
 =?utf-8?B?YkhDT0I1dHlJZnZVVVVsYW1saUZiMDloU3Y3T3ZJdDZlZEczcUhRenBiczYx?=
 =?utf-8?B?bWp0UWlzTk45Z0kxTjNZZUhnbytITUFwMnNXWDRPNjM0eXBKMHRoemhBOUNK?=
 =?utf-8?B?dk5QUDhmQU1VZy9kTjlLaUVZOFhPcXUwa2loaFp2TFVITUhPR2MzeXhLUVpt?=
 =?utf-8?B?L1hweDlyL2ZsRWtVYndEeVVjbHBHTDViS05oNE5IWEpENE9BMlB2MEdqMkly?=
 =?utf-8?B?dnJQeXcybktZS05nd3oxNForSS9OazlEOTgvZWlzRCtrUTZzYnZHZzM4ZTA1?=
 =?utf-8?B?L0JYdW1tMlFoaVFoT29oell0anYzYzlRWW11c2RJbXZ5ZTdFRmNHclYrR0Vr?=
 =?utf-8?B?YU1UQ2J5OElFdDN3UzVZeWRWSXdOV3NnYWlKS1Vaa2hBTjBmZEFaY1B4VlAy?=
 =?utf-8?B?REd2bG9hVnlTdGJ2SElGbEZYcUNpMjJObkZnMXhYS2VsUW5tUXpjMGZ2MnB4?=
 =?utf-8?B?dnZnTVBFRmVkNUtacDBxalN6cyswL1k3UVI1R3VnUzE0UWEwUDh5VzhLbHdh?=
 =?utf-8?B?TFV4L1d1Yy9RZ2hISUwxb3hIZGVRaEJYQ1Jpdm0zdzBZUHRUZW4zVE00Q29Q?=
 =?utf-8?B?Z0xaS3VlYy9NaUtuSmI0MDR0QURSRjd0RjM0MGZEUXBRd2dUTk4yMmErRkUv?=
 =?utf-8?B?a0NSOHllYXRvbzlQWWpJRzJZaWIwMm9SbElJUURxTlFKTVdCVGE4ZjVta3JV?=
 =?utf-8?B?RGM2TVd3Qlh5VDY2U0s3TnExQlNRT0ZqS3hVeWVWWmxhNFJvV2U2Znd6YVJ6?=
 =?utf-8?B?YU9tSVQ5MkdWNEh1OFhKd0JFZWtwSlJUdVRMd0tQV09mTXAxcjk1dHg4bm5P?=
 =?utf-8?B?aGhQZFhwNU1rNlhabnBYSXV5bjYySGFYWlZ2OXR4Vm1mRFZXaERvamxUL1JC?=
 =?utf-8?B?bC8wZ2RMNVhxdmlWL2h5RHJqNXh0UHVXSitiL09IQWxwRXpNaWk5SlR1Qm5C?=
 =?utf-8?B?SFJzRTdQdHFHTjc5ZUVvYlNuTFJwZHROMDh2eTg4T2o0Z01zVmJsUzN3K1lT?=
 =?utf-8?B?ZjZLV1pUUzc1bE5uSWFKTUtldWU0b2ZuZmU5VXhodmpKMG9kNmN3ZmtFd0dC?=
 =?utf-8?B?c1doZ254emtJUW5LWldxRk9CNytxMjBjSkVnRGdMT1d3S0NIUW1hanliS2NJ?=
 =?utf-8?B?cVZFWHhsSlBDb0NGMGMxNUlsOWg1d0UzYTRDN21aRnFlbTBZbmtHd1RGbUVP?=
 =?utf-8?B?UXFWS2V2MGxqcXV5YTVabGZCRUY5eU5RODFKQkJxeklwMS9yV0RTL2hvZXpk?=
 =?utf-8?B?RlBEMXlEd3pkNDVZbFMySWdZQzd2djNxM2doMjJnaE1ORjFXL1kyWFNrTm5X?=
 =?utf-8?B?YUhWekRlckdsbThDQ0owdlFUYjlSWDljbkNGQm9MS3dLcVI0RXZBSEl4YmI1?=
 =?utf-8?B?d3NKQmtzR0dWdUtDbnRGUDY4ZDRKUUxaSWUwQlRlakZtUSt5Y0JpZ3hESlVF?=
 =?utf-8?B?dWxHc1B5STFPMlhjWHppQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnlKdDVibjVvaGNSbjgxdFFvVU1RSVhrSUhqdlp0V1h5L2hJaDFlMDdPa2Jz?=
 =?utf-8?B?cWxmRGt3VFVyRHd0OW53bnMrT0lDQmRHRXM3V1V0VzArZFR3QXZKZnAzSXdk?=
 =?utf-8?B?SlZSMDBHMG11eEgxWjRyZUtaLzdLOFk0TWdqWGs4cFNBYzQ4UGJlV0oyK0Qr?=
 =?utf-8?B?VkRsTXg3a1dqUG9wQzVXTm9SblR2ODFxSkJEQm9aOUJsNEd6eXQwM1lsTk1Q?=
 =?utf-8?B?R3pmemVjVFhJZ1JaNDkxRXJ6M2FNZ2o5Q1J4blp5R2gvQkNCVGhDSWRPMGd3?=
 =?utf-8?B?VGRtTE5aaWVvVGJZWFdrN2ZKSUdidnZCcVVWZjQwc3ZLbzFtUDZXbHJ0T2tH?=
 =?utf-8?B?MHZ6bVdsYmVDdExNVEtzeXZ6SUFqdk5VT1hGYVM4a3ZUUTZxVmJTN2VTcEU0?=
 =?utf-8?B?QjFHaE9uVmsxUHFqQVdzV0lEQ0tEb0daUWFrZlc3V2poK09SdmFhcEQ2K0do?=
 =?utf-8?B?amtrc1hINzVwYWw3akRQVHB1emdTNHVTYjNFdytYNlRZdjRBaEhTNElwWE93?=
 =?utf-8?B?OFJEa1o5ZGZIVjhmOGRQcnFORjVJbm9tVHh4b0c1Ymc2elllOUJ2Qjdpb0dv?=
 =?utf-8?B?aTRUand3RS9XclFuNWJ0aTRUeGsvNGxGUHZvbG1zUnZBYU0rbWJSeEJ2Vm1i?=
 =?utf-8?B?VHE5UVFFSFFRRlBMQXY3b1RWdlpKOXVlQmNJTXRXc1ZneG51aVBoOVlTcW96?=
 =?utf-8?B?SHE0Z3ZyV255dDA2ZmxGNk94OWgxNTl3b2t2djZCa2NoYjV1KzJwRi9pUWwv?=
 =?utf-8?B?U2RIc24yWHpFYVgzNkozZmhQSnB3dzEwbmFsWWs3dEtHQXBvdVFMM3JQTFJK?=
 =?utf-8?B?R2FkWU9RZTA4QWEwYXFNZ3pQR1ArUW5OYXRVaTZjOVhMbGRrQUtwcHpheTJZ?=
 =?utf-8?B?b1E4NU0xRVdiSDZtYlhmS2pnNkpwTTVMN0taWTJDdjQ1R0J4YldMZFpRMzNw?=
 =?utf-8?B?eGp0cUk5WStueEk0REs4VXdNd2d6bFV5QktHQ3NEQzBVdnptMDN4YnZvSkRs?=
 =?utf-8?B?M0F0Tk11WWlxRlFVS2U3dmsweUdqblZscFlLQXd0M3Z2aDV1bmFnYUsrRXpV?=
 =?utf-8?B?ajgwMFNkYi90RzRIaytUR0xtSGF0Si9yV29BdVUydmxFUWE2aWgxQjYyaU12?=
 =?utf-8?B?Qk54Q1luVEVEQ01nTXZtL1RVRnNOcHlkNm1pQkZMMEdxQ1dOTk5tdndhNkRF?=
 =?utf-8?B?S2FRcVdlWTdvYmFFZEV2SVhiMkswbkpFR2RKOHo5cHYyejBqYmJvb0YvK2dj?=
 =?utf-8?B?Q1FseFZJUW5nZmhMRm9pQXhUUThXNHVud1VtSDcxNTBuOEJvY2h4T3puZnJE?=
 =?utf-8?B?cmttWEg5Z0wvV3c0WmdOZGhNaHBQSDRqOEJ2ekNXcWwwNnVpV3F4d0h6VUI5?=
 =?utf-8?B?QXBiMUlIY0ZkSDg3S1dSc0FYUDdpOGpxcWg3SmtqNmNUb2hZdElvc00vbjE0?=
 =?utf-8?B?cmVveFFUNlpucDVmQ3lxeExxbXUyT3BOZnRDWDBsYndackpQc21PSDJxNlJj?=
 =?utf-8?B?S3k3R2tiWmhDQjVYSnlzbG9pdk9zYjIxRXpuWWFTWW5PSDJ2T1RQTjdqS29I?=
 =?utf-8?B?Q0dsVFpKQ1VkRnh3N3NPbVdpVVZyYWs5M2Q5ZUM1WXdCL0JPejEycm5acHJ0?=
 =?utf-8?B?RXNiZ2xmeDExMVZUdTVkMFlkZUhGbmJBUUNIRGd4VldsZlJyNWg0cWxTd3lS?=
 =?utf-8?B?ZzMxbGo5KytIQ3d3ek4yMjZrT0xnUXJKTGU1Tk1KLy9yU0Jhc3c1N25GK1Jq?=
 =?utf-8?B?ampFL3Z2c1NYTVFhMnFpYitVM21lU1JiWmxWMkRocEZkNi9RRVBvc2paaUE1?=
 =?utf-8?B?T016Q3RYdk14ZExiYTk5ekwyM1J5OStjVHZMSUhZRWF2d3lQNGp4enNCVlVF?=
 =?utf-8?B?aWQwQTRtZWd5LzVDZmZvNnlmUi91ZXh3VVA3WlpxVWFoNGRpWS8rbjVaQlU4?=
 =?utf-8?B?Z05FTXlXek9qa0o3ZEdrV21PNmhGZXRoTXNJanJwRldFTjVIUlh0MG1vclRj?=
 =?utf-8?B?WjFlWTBVbFNoVndFbUFnbmFvVDhSa2d5WWNVTjB2dU1GblZDQndIeFNSalQ1?=
 =?utf-8?B?VDJiU0QrSDloZlV2SU04VXR1S1RHSlE0Z1JJQXE2UXcvNEE3NTlVSTc2bUJ2?=
 =?utf-8?B?RFRXWHZsR0RYdU1OR0FYSWgraVdKeDFjaUFZMWR6SXY4ZC9ZUTE0MG1iejdv?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b812bae-1b92-4491-184a-08dcbe1e8a58
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 18:09:16.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exuWvMYaLRiafS7Zn0GwXoh6smQNoGuiPIgoYfAcqSy5aZg7whoiGS9JNfhvlmN3+cjvfa9vLD+la5yBGP5LIfDI3QtMR9n9ZS03beqsuVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com

Hi Peter,

On 8/16/24 10:16 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, Aug 16, 2024 at 10:01 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi James,
>>
>> On 8/16/24 9:31 AM, James Morse wrote:
>>> Hi Babu,
>>>
>>> On 06/08/2024 23:00, Babu Moger wrote:
>>>> Introduce interface to switch between ABMC and legacy modes.
>>>>
>>>> By default ABMC is enabled on boot if the feature is available.
>>>> Provide the interface to go back to legacy mode if required.
>>>
>>> I may have missed it on an earlier version ... why would anyone want the non-ABMC
>>> behaviour on hardware that requires it: counters randomly reset and randomly return
>>> 'Unavailable'... is that actually useful?
>>>
>>> You default this to on, so there isn't a backward compatibility argument here.
>>>
>>> It seems like being able to disable this is a source of complexity - is it needed?
>>
>> The ability to go back to legacy was added while looking ahead to support the next
>> "assignable counter" feature that is software based ("soft-RMID" .. "soft-ABMC"?).
>>
>> This series adds support for ABMC on recent AMD hardware to address the issue described
>> in cover letter. This issue also exists on earlier AMD hardware that does not have the ABMC
>> feature and Peter is working on a software solution to address the issue on non-ABMC hardware.
>> This software solution is expected to have the same interface as the hardware solution but
>> earlier discussions revealed that it may introduce extra latency that users may only want to
>> accept during periods of active monitoring. Thus the option to disable the counter assignment
>> mode.
> 
> Sorry again for the soft-RMID/soft-ABMC confusion[1], it was soft-RMID
> that impacted context switch latency. Soft-ABMC does not require any
> additional work at context switch.

No problem. I did read [1] but I do not think I've seen soft-ABMC yet so
my understanding of what it does is vague.

> The only disadvantage to soft-ABMC I can think of is that it also
> limits reading llc_occupancy event counts to "assigned" groups,
> whereas without it, llc_occupancy works reliably on all RMIDs on AMD
> hardware.

hmmm ... keeping original llc_occupancy behavior does seem useful enough
as motivation to keep the "legacy"/"default" mbm_assign_mode? It does sound
to me as though soft-ABMC may not be as accurate when it comes to llc_occupancy.
As I understand the hardware may tag entries in cache with RMID and that has a longer
lifetime than the tasks that allocated that data into the cache. If soft-ABMC
permanently associates an RMID with a local and total counter pair but that
RMID is dynamically assigned to resctrl groups then a group may not always
get the same RMID ... and thus its llc_occupancy data would be a combination of
its cache allocations and all the cache allocations of resource groups that had
that RMID before it. This may need significantly enhanced "limbo" handling?

Reinette

