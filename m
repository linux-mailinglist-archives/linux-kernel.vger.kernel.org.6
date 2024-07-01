Return-Path: <linux-kernel+bounces-237023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031D91E9FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B932B21427
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D6171663;
	Mon,  1 Jul 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPHHiNvF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A08171651
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868227; cv=fail; b=nG8dhtwlb667UFs/iaAncFR5na5h+V7mZmDx33E4IOrVru02cN6MiKzc7P8jXwjnpgne9Vuttjqkz5dygRaSpaIKaA3qSHbvwQdNt13CA+5kthr3X/1VP4sEXvq9hEmhWPvS4oGCtc3evnhruRtWHcIkYobcMsFmW++aRk/0OQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868227; c=relaxed/simple;
	bh=sLHNuP/2pA+L3cpzXbB/PWg5zOUF2M7vE4d5890n5rM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bb+s85Bt1P92c21ObXoNvqZhHznh6lIgj5BepFXXgQDKN5Z/ueYyUbcaZisqQcMa6SgYThWO54BFTmx3Tmhv007gHDXgbmwYuBMAm2aKwyXdcq8Srr6lpSsd1fJ4nSVyxzDkhdB1u4flbeHIs58NEG0XOxI4+yctRA2SrEZbWg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPHHiNvF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719868226; x=1751404226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sLHNuP/2pA+L3cpzXbB/PWg5zOUF2M7vE4d5890n5rM=;
  b=HPHHiNvFC6mzA8BNniYgzY8RmsbTaY47ZR4wpLCe+0x54ybbqG3tO3sl
   q8gRcDfIU7D8o/REQvlQOeU+RqQdmB4+oyo9sfoAq7VKbXKa/vf4d+5G2
   5V0P4CyoLOou5wkeE+HBbCSoARUWzVkT1zjAKDbmbEr4igA3m43uTBvTy
   PbmdrNcxAGQXlm7d9acHLWZszClKigQgiDKovdMwI5nRCFB4Ybxl9tb5Z
   xydmVFCIW0JLYaE1dfrQOhNQcuaLAGH5pRpsBihGP/HG+K2lRwmxvdwNf
   UiOn89EL+r/HHRAzC37vVqor6MCHQnXxMvhP7t2WhIphu16VvBPtSR3QG
   A==;
X-CSE-ConnectionGUID: oVcqhgSGQZGtvnpNxj1H9g==
X-CSE-MsgGUID: 306/k3COQb2YHLklBlnOlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34466671"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="34466671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 14:10:26 -0700
X-CSE-ConnectionGUID: gFll+1+6T2KmK3dYq6bH+Q==
X-CSE-MsgGUID: y1AMwBMKRJ+ObIXrFcSI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="68872511"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 14:10:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 14:10:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 14:10:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 14:10:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 14:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+2cj02sVLwIouqQT+5uNKdpm0GSdO/RdSiEOeLBp/IzKbRPkMV0K96MrxAW2N4EuGyVuGm4CaXat5sYLnd7NBhTqLofSpTwphWwjU8K9HSbBS07Ua8HIrhScQWur7dLVP/NT8fH8w3sF+4lBrde4fyHN3vRXFFQjqHjHjb7nmQGv+e7dkabJz2tFtu9Gm+B+Q6CO8mxZJTdGRpBZni1zgFqrP1Mkrn3LbQy7IgTXy7qenxd8SMMwWxahIwZxqx14DxgcShH23djZDw93ML68SEwMndO4Hu9JbV+tG7PaG85KkKuP4n7f+jPEHFqwKJnxDMTExQ+byHMpw+shiovuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7PL4dBwPjQaAKXLqwzkQX04CExJVaqYRUrksmJTdAU=;
 b=VGWQ6klBziEOQ3JF9dTDm/FLro2tq1nnHySL5+hnSrw7qxtvDozQHEB09GNOHui6WkzBh/0TSFIsLXPDZsacXrNz73dsc6/znuXSrGmbQuWJto3nsLP35F47kin3/o3jcgwiM4bcZvzGG7qaVmXKufDcLJ+ce1qH91eovwpE19iO7NmCrFLvm1qG+Fbe8hZqz5xOo6GEs5lUpiZ3xWaudXlChMnpMdk4QtDH9dC0779DtlOSqhUZusI6Vgp5QDtC2qSQdcmXJo6oHpckPQNQHV+nHOKIzpdo1EeVO1SzSC86A0KHu6/So6WRnWcW61RfY3UrCCgX27N/Z1IeMhFGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5115.namprd11.prod.outlook.com (2603:10b6:806:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 21:10:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 21:10:20 +0000
Message-ID: <f629e958-39c0-48cf-870f-8f76cfa7b815@intel.com>
Date: Mon, 1 Jul 2024 14:10:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/38] x86/resctrl: Stop using the
 for_each_*_rdt_resource() walkers
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-18-james.morse@arm.com>
 <2b163af7-12d5-443d-a302-22d98c1facf1@intel.com>
 <68cc21ed-71dd-4ac4-8af2-434f34988a51@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <68cc21ed-71dd-4ac4-8af2-434f34988a51@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8238df62-84b5-43c4-9a4b-08dc9a123758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW01VWpPb0JlbUY5Z1lLQm1TRk5JQXVIeUR6VkZrR0xzbFFUZmNIbzhrZjRG?=
 =?utf-8?B?V1VOZzdVbW5wRENWN0RUaFVDY0loS0FEMitHaEJ2eHRjMWJUV3BqWFBhcWwv?=
 =?utf-8?B?QjhYY01HcHBKckk4WnI4cjJ6bUdCM3Z4djk1ZmtiZGF3VFpPeEgzSUJNWHla?=
 =?utf-8?B?Z2MvYTRmQitjSzdDSDVDS2d3eWtHZE1aaE5JbXdKOHIyaTNWVG44am1vQlRt?=
 =?utf-8?B?Z0xFYXFPRTV2bzdGSVhZM0Y1amtaZ3BEd3NuSzdKRjNKSUdUN0pZNnBQRlB0?=
 =?utf-8?B?T1NBRkNqR3V5T056bTAwaHlQam5vR0VlNjZYSWJtaGUrNlF6b0pxVzk1dG40?=
 =?utf-8?B?WHBrN1pML2xZak9nWGVjOG9rR3F6bWs1cFhmR0FNWEpBcllvVi8rdE5CZmJW?=
 =?utf-8?B?ZWpYZWk0K2Z4T3IxUVlWMmRnR0Z2dGowQkpXNHByMUF1WGw4enRmSkJ6NFdt?=
 =?utf-8?B?QnAyeVVqYlJsUlU0SFErdnBrZ1pRRVpaclpoQk81TkJJMHF5YkZMam5HTE9S?=
 =?utf-8?B?Y3EwQXJTd1hXSlZ5L3JoU0t3K25QSXREckpCenVhQXZ6anlVc2JzcUJmQyty?=
 =?utf-8?B?V0NOQU5QaC9GOGE1RlJWOXQ1cktBZ0dvNk9uMWQ2djlyUWU2cjJ6NStFcDFa?=
 =?utf-8?B?TUJjQS9raW9rbDRtV08yallpdDFhNHpPRlV6dk54SWlteHcwbThFMkpUUm9J?=
 =?utf-8?B?RTJHRDVUa3kxU2VJNjJIRHhjN3lENHBHbmI2dXBrQjZkb1o1TDZRK1VWMjVQ?=
 =?utf-8?B?cnN2RDRXaXNYTVMybHFsd3NMMUFzT3htdnZXRWxyYjFXVEo5dlBjVFJqem90?=
 =?utf-8?B?Q1pLS1lZQVZTcnlRYXVxTldoUDZGdnhaMXdGSzNsaXBIRGNXMUxtTExRY3BW?=
 =?utf-8?B?WFdnMGcxRU5xVUZOYU1yUVo0d2kwNnJKVUtpMVB4Rkh6YUxhbE13L3I2UGtq?=
 =?utf-8?B?aHNaNTVWTU9hZURqc0FJNVB3bktTT0NBaXp3R3dhejJlZUJOMjJaQ2swNUN6?=
 =?utf-8?B?RHBhQVBxWERMYStJbjlQUVRIaGtlNS9lYW9od0ZSeElVaUppUHpNQnFtdVFV?=
 =?utf-8?B?NFo4M28rMG0vdDAwSmFFNGExTVVjeDl0YzBsaW5QZU93eEs4ai9MVGR1Um1a?=
 =?utf-8?B?K0syUDB0VzV2Z3VhVjN4TVBRQXFQWXBZaFlCZGM5ZWZpdWpvOVYrbDFXR0hQ?=
 =?utf-8?B?dk5GdUp5Ym16ZVVJeldOY0h4QVAreGlVUXJQRm5QaWIxdFBINERkU1VaUi9T?=
 =?utf-8?B?WGU0N1Y2Nm9PaGh3VHBndjZ5TndScktNY2RMZlZvR1BVaFdFNzY4WlFiN01t?=
 =?utf-8?B?R1gxQkdxM1BOZkF1cTJJWjJnRDNyMCtlSkExSHlGaGRVQjJDQnFvbFpFLzQ4?=
 =?utf-8?B?blhsazBuMDJuUHloMGpDMEtMMzliWm92MkhvUTRWeHBGclFrQUh1YlNDdmRl?=
 =?utf-8?B?TTE2ZDlHT05PSFQ5T0tjeVVWeU9Lc3lENzFGRWpVTEpZWDNHWjgzTVcvK0xa?=
 =?utf-8?B?NWUwT0thVzhnVzhPR3hjYlk0U1FMYUNiUmtkRm1PUDdyTmhwS2hyaVROWXlH?=
 =?utf-8?B?bVRLQWZSenhWTWhKbzhUTUMxK1BCVWIxeFppajhOa0g4YXEwNTZoMjZObWE5?=
 =?utf-8?B?aG9VNjYyMWRhcUpRYUFmZUFEYXNVNy9NOXdKMHBEZVpEMVJXUXhVU00xN0JT?=
 =?utf-8?B?RStJcVhoYk45Skl3cnpVTU9SaWFCV1pqNnpTaHZNRzRLRFR0RThSeUpkdWRW?=
 =?utf-8?B?TjF6Umw2NWNaV0JYdXVXNFdvdEw0S1JsTy81dE91TEpCK1QwSnp5eTdTS3VH?=
 =?utf-8?B?UDRQUGRNQnRoZWdSL0R2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNhOUs3WmtMZVhlV2J5cEE1TnNMODJJU3Nxamk0c24rZ3c1RTZIcnZScHJo?=
 =?utf-8?B?WnRsTFhvOXlReVEyc056WFdRZjlyVFg1WUR1cTQ4VVNXV3RXcGNCWURXY2xx?=
 =?utf-8?B?UUVrb2FCa2REako0WWtMK3RTNGUwTHZKS24wMVM4U2hIa2NoTHhOUHU4WkRq?=
 =?utf-8?B?eFhjWUZLVFBVYjcvQkZaMGhRRGhtaFVEODFiQUlXcHlYK2o2M0JhdkxMMDVT?=
 =?utf-8?B?dHh1TS9BL3g1WC9CclhMRWN3U3BSMlRCV1o2UHRMamc4Q3FkNFFiOXltbVA1?=
 =?utf-8?B?b2ZLTHFScFozaEc4NnQ3b2VnVzhBdG5VODMzSnNlaDdwdHpMNEQ4WklUN21C?=
 =?utf-8?B?cFljSVVxNXlwdHQzODRYa3dJdzhMRzZhQ0tLeXloUW1SSDRXSVR6a2UvZU1T?=
 =?utf-8?B?U2pNNFd5WW5naTlBQXNOck42R1FVaHdWb3hYTUhqYjFxVnRDSkk0UlFXSkpj?=
 =?utf-8?B?bVZWNDYreXNWZmppbFB6Zjh1LzZvaXFWTWF5ZzY1V0Zpamg2MWtTYzFtYTRK?=
 =?utf-8?B?VDJIaTNIL0hIZVN5cXcyZVVrMzJXbnNzR1psZHlUNVlhTTd6MHliZHVXengx?=
 =?utf-8?B?ZHlXVzhJdGRpQ3FVZkdoVGdWRHZNRWppODRnaWVQelZBemhKWGtnVnpkbUpF?=
 =?utf-8?B?cHZqQ3NPMDhXR2FBY0hvYXNMbyszSnczOVdFT0J4SWpPcXU3TGQ5aC9xRStu?=
 =?utf-8?B?WXBGcEg2T3NXZ1IyUDJCTTRYMW5SWmN5Mk9ibitMM3BiWEJRVzlhTG53NWJY?=
 =?utf-8?B?WEwrREE4SWpEejV4enE0Y2o3eE1oWTBLZ3ovZXl2TnAyKzN0NmRVWElWenV5?=
 =?utf-8?B?dzd4YWdlSTN6YkJSL1k4NTJTSFYrMHJBMDFRTTh4TTAwOFowcGtmdG1WaXpG?=
 =?utf-8?B?bzdFSlliVTU3cTgwTTRJT0hzUUFTT2dLbUJ0RnhhTkRhWlVrdzNDUjhkRzIw?=
 =?utf-8?B?L0k1YlN1RlJycmVaNVkxN1JwUUorUlppc21tUUYzekRZY1ZJWURnajFISW1H?=
 =?utf-8?B?L2lrdlpxcXdyMmNFdSt1ek51QmJtMi8raGpsdzlSblVybysrQUdiNzd6alVh?=
 =?utf-8?B?ZTNxT1hPQU5HSWN3czVObFBUNmFIVWhqSWxPQlB2bkNyUVFIeC9pa0lZOEMv?=
 =?utf-8?B?RExNOTJTclJPVHpoYXNPZzhiMUUxK09aYTBSa2g4emoxSnhKd3ROaWJqU3Nv?=
 =?utf-8?B?OHhxdzFKOVF0VDN0UDJkbGp4cFkxUUljenowRGkrYzVTZ0lzeVFjQmsrTzlx?=
 =?utf-8?B?Z0RuVC9HNFFIRThrSDlvSlFoS2k0cjl1OGwrWFJsZXVVcnBIcDJTWkhWYngx?=
 =?utf-8?B?M1dxRUpScktjbC9RUFJPSi9OSWZ3a1psemRYRGVRSFB0M2VsOVoyUUNMT2U5?=
 =?utf-8?B?ZmxjdTVPTDJCSERidWVaN25XUWcyYlI0c2Vyb2hXY2VMbTZqQzVFRVhYMHkr?=
 =?utf-8?B?eittQW1VZWtHdnpHNHZqQTJHdXZqZ21FTnoyN21lQ1Rra3lUNWkvSUwvbXNC?=
 =?utf-8?B?aEhEUVVuUXcyaE9jdi8zc1RJNm9oaysvN3Jxc0p2RlE3Y1RhcXgwMkM4Zy9x?=
 =?utf-8?B?MjVpM2kzaktuNWN4dHliRUd4ZnZZQnQvZFdkTm0wK2pmenlCTVdUZkZlbnEy?=
 =?utf-8?B?RTFRK0VHdWFOWHJhUEhCTTltSFYyM0U2SUpSWWdvTVErUm1aZGdSL2VQWjRn?=
 =?utf-8?B?bTB3cmZZUS82eEpyZGp4YkV4c21BMGladHpNNWRvbFp4Z21RYWR4UFpPbmNF?=
 =?utf-8?B?OU8xMVJHTUtJNWdTc3A0c2NIY0VodDhJWmlBblhxTDE2dW9vMVVOUUJIOXQ5?=
 =?utf-8?B?Ny9SY3JZNzF3NzRPNWdKKzdvY1gyeUtZTFdUQitnOExSdkhOaTJQWllaQ1B0?=
 =?utf-8?B?aitJRmRLOW5XMVFOZ1NCQkV3UmRJb0ZpcjFrai90V080d1BySmpYdzFGRXl3?=
 =?utf-8?B?WU9SS1JjLzdSdW9wZjNuTWNtMnQzUlY5RHU1cThFMUp4bjB3RmlWWGx4UjZM?=
 =?utf-8?B?clVDUEY5YndNQWx0bG5pb045SS9CL2FHTnRUUHBxV09RYzYxRTQvRlB3aGJk?=
 =?utf-8?B?ZFZUbkVhMExXVXZMVnllQ2tTMGN3Zk1janlsenlJMUsxTStJQ2dEcVNLVmhi?=
 =?utf-8?B?SjBOdnlBbDJMUlgvUHB2WFdVRDRGWXIrUURyTHQ1b3Q5R3VLVUV3Tm42U29U?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8238df62-84b5-43c4-9a4b-08dc9a123758
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:10:20.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKAjDkQrK5gHAi4zhg4yyg4OGhzlQVf+Cw4dA1tT1A1bFkJuSDpgB1b+KJwXeQCTEJI1t9nfriLwra/NU5wH8t47LvlMUbiPbkDmA7dB1aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5115
X-OriginatorOrg: intel.com

Hi James,

On 7/1/24 11:16 AM, James Morse wrote:
> Hi Reinette,
> 
> On 28/06/2024 17:48, Reinette Chatre wrote:
>> On 6/14/24 8:00 AM, James Morse wrote:
>>> The for_each_*_rdt_resource() helpers walk the architecture's array
>>> of structures, using the resctrl visible part as an iterator. These
>>> became over-complex when the structures were split into a
>>> filesystem and architecture-specific struct. This approach avoided
>>> the need to touch every call site.
>>>
>>> Once the filesystem parts of resctrl are moved to /fs/, both the
>>> architecture's resource array, and the definition of those structures
>>> is no longer accessible. To support resctrl, each architecture would
>>> have to provide equally complex macros.
>>>
>>> Change the resctrl code that uses these to walk through the resource_level
>>> enum and check the mon/alloc capable flags instead. Instances in core.c,
>>> and resctrl_arch_reset_resources() remain part of x86's architecture
>>> specific code.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> index aacf236dfe3b..ad20822bb64e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
>>> @@ -854,7 +855,11 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>>>         * First determine which cpus have pseudo-locked regions
>>>         * associated with them.
>>>         */
>>> -    for_each_alloc_capable_rdt_resource(r) {
>>> +    for (i = 0; i < RDT_NUM_RESOURCES; i++) {
>>> +        r = resctrl_arch_get_resource(i);
>>> +        if (!r->alloc_capable)
>>> +            continue;
>>> +
>>
>> This looks like enough duplicate boilerplate for a new macro. For simplicity the
>> macro could require two arguments with enum resctrl_res_level also provided?
> 
> I was hoping to escape from these clever macros! If you think this is too much:
> - we'd need to come up with another name, as the arch code keeps the existing definition.
> - to avoid touching every caller, it needs doing without an explicit iterator variable.
> 
> I guess the cleanest thing is to redefine the existing macros to use
> resctrl_arch_get_resource(). Putting this in include/linxu/resctrl.h at least avoids each
> architecture needing to define these, or forcing it to use an array.
> 
> The result is slightly more readable than the current version:
> | #define for_each_rdt_resource(_r)                              \
> |        for (_r = resctrl_arch_get_resource(0);                 \
> |             _r->rid < RDT_NUM_RESOURCES;                       \
> |             _r = resctrl_arch_get_resource(_r->rid + 1))
> 
> This leans heavily on resctrl_arch_get_resource() not being able to return NULL, and
> having to return a dummy resource that is neither alloc nor mon capable. We may need to
> revisit that if it becomes a burden for the arch code.

Replacing the repetitive four lines of code with a single line seems good to me.

resctrl_arch_get_resource() being able to return NULL is introduced in this series but
I am not seeing any handling of a possible NULL value. Not being able to return NULL thus
already seems a requirement?

Reinette



