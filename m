Return-Path: <linux-kernel+bounces-550437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C005A55F94
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632C03B12FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303EA52F88;
	Fri,  7 Mar 2025 04:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcpiutcG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF03398B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322243; cv=fail; b=fOOCSZm9Q7vT+0VVfm36iVrHgWa6xiLMLIKnzgBLjb6Uta++tkQYobW1GIE+KGGzo0tT4DFTULXXaoo1+/MpjhQaJqyrfSHGW9aUy5wbf5ozPYhlJU/jK37DJovZwgCXBdrNyCv4pYUeE038r+9igibQyrS61I30prrlUQDyrus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322243; c=relaxed/simple;
	bh=ZQxl0bDER64Q1LsnL4Nz0d5CEEkZoaH0zJThw/tjJgM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KPw5MwFnBJela1tOxD2Fl39WjMiZOC4duXi21FUoaY0yqdBCT5FHVfVPCw/T3bT1++iDwJzGWSwcY3ExcnKkn92zr5HDDeh0S38yLlhQskTG7z97Kjiu2kdgytIAE8SmXAQLqLfE9sSk/d7D+CK9bUhbAMiL7z6J9Vqb0pNzql8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcpiutcG; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322242; x=1772858242;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZQxl0bDER64Q1LsnL4Nz0d5CEEkZoaH0zJThw/tjJgM=;
  b=WcpiutcG3YRy0LbYNc5zZQ8dYTEZ7Kj1s8CVZjdd8DOApnIqDmydbCym
   u1LC53Lmgk6g7BWz0uBUpV8DpeymermAXkoircKmh2C4w+eRJT1tdjPL8
   eTWXAYAVVkhWOj83Aov795AwUfnME1uG9p2IsE5F2dcHzHbh1tlBZIgMm
   k/ty54sxNCbnnNBMOAqf6RcB+JAV2k/slCoo6GrqJtJPpM1byuw1E5BKj
   9cAkQGJru7j2D4iedf2a1pfReCxaMTC4KKVsgRrtdcPHhPJZFAIB6GdIX
   Ges+IwO5nIBbLFUDkZ44/0SnEKCAy43bUDWNDOVbHcihISlXiZWxL9ydy
   Q==;
X-CSE-ConnectionGUID: 2jrw2MSsRH2pKRwUA8dh+g==
X-CSE-MsgGUID: HUyRfVqzSPGyFAgZ8pKWyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53349629"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53349629"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:37:21 -0800
X-CSE-ConnectionGUID: Gyy+0y5xR8OnkPjPRVtwxQ==
X-CSE-MsgGUID: DCmXZA/BRaSzk7Wuq0cR7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156428423"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:37:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 20:37:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:37:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:37:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmdupKMr7jl+SBOPW/yev5/zTfAjvcxJOJ0GJwNe7wXXvpl/FrM6hHcd08fj20iOCgmP55J2AgyiZ+rKJ6avF2aEiXBDV7oEI3QOpOC0+UgXXgFKQOliuYnjDTBrqE34RTO57Op5PMu7fQL+SYBbwZnODug++P6yNCUgt7xNRVesigEofHLmyC0gPI7dDLDxPZ9TiBIcUmyIgli4X9pc53LoGWG1O/gQhFL/iSrSctL6vF5SWBsO73xW+ujRdxwGxhi/S6UPfETzz35KRBiKhfy7thWEo3hS6I1D2b6lYGlupmtW73GyUepfBW5E/hCDdKs97QD8RjeX4+7TnEvVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFL5t2EvD6YXBaoc5NgzZubP5KqwvuPNXMgV9KkwT70=;
 b=iX/T3Y/GCXV4bj13/Svdz+M0kPNvR8O6srjY71TRPgLqVzLzp7rKPMU/qLPUmnWeYoeVNjfYWWX1xzpqH7ppHmpczs0vO46JBEz4SedjbkEkyIqqD1zUBOqRSp3jypoqGuyXFcA8NW8JrcnkaX06kI1M9hngLEHzq8b7fd9+6KuiQUxoH+Y2vUsZ27vkGqZhTJrugVQvwJMrRabdYYysnHmDk8Rs93LJFmUcULZ0hzPM/NsCZji3scoYQ2vVyIt64hYJHeURa2WDgwSHcBV76a5aTNi61LQyAMJyW+4GeQuMiZ5si8bA7m4+TLwDwNEWD0ayzlNZ0On4A9WbCWgOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:37:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:37:15 +0000
Message-ID: <cd48b81d-43df-4d46-9fff-caf0565f6a7e@intel.com>
Date: Thu, 6 Mar 2025 20:37:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/49] x86/resctrl: Add
 resctrl_arch_is_evt_configurable() to abstract BMEC
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-20-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: e5700e31-e82f-441f-7308-08dd5d31bc6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmQxcDJyMzdhOTRiOEozV3pZU2dsbWk2ZWpZUUdQWXJBa3I2OSt2WXorYVBs?=
 =?utf-8?B?YUZ3MjYydFMxdStSMFRZY1ROMDdtMk5XRnJjYjYvc282eW9iR3dUbXBGVzlM?=
 =?utf-8?B?L3hwRWt1azBGeEsyNlg4R2g2OWJXL2x2aHJYSm9KQjY4UFB2OURhSk1xd0Vp?=
 =?utf-8?B?TDFmbDl1TFE3TVpsQ0VnY2hlNUh1TWFUUEtaZ3EzS2hZdUJkZDJoV3BCbHNP?=
 =?utf-8?B?L2NhcG9hU2FoVEQ1TDEvY3lhUGhhZ29LNk1YQndiellSYjNxRUNlRXM5djF5?=
 =?utf-8?B?cGE2TklPZXlmY00rMVNwcnd3RUlNWkVsVzEySUZUc3J3bjBURUV5SUVmUVU4?=
 =?utf-8?B?aGpjYklLNWF6d2hYM3FFeGFmSTlwTFZzcGlYck1udUhBL3Vtbi84S05qNjQ2?=
 =?utf-8?B?K3h3ZzNRQmFaSExvdDBCV25SZEdPeXJXYWlITDYxMUhpN0NSWFJqZy9pbVFD?=
 =?utf-8?B?dzc1TU5hWWRpR1hyNy9EeGpMa2ZZUEhLY0Flc0hGQThtTEszdE5zblJhdXNr?=
 =?utf-8?B?WTRxUGd0Z1EyQ0d3TUh2cE9mcDBZeDYwdXp6bENib2lPUDd3RTdMdDJVMCsy?=
 =?utf-8?B?VzYvV1NqNk9JQVJ5S3NmVm9hQ1E2c3c3eE94MXgwTnM4M1JjeHdCeWNPc0Y0?=
 =?utf-8?B?L2NZck1XWCtldTBZTUlheEtSQUtBVUFzTGVBdEQrb1MzaitsVmtXYzRFald4?=
 =?utf-8?B?UVBQdzBUTEdiMGtNb2Z6V0dIR2dTZ0R1Rnd5MmZUZUhlUXpMU1ZUNSt5VmM1?=
 =?utf-8?B?Wlh6UEVHK3ppL1ZXMG1CT1ZtSFl0T0JRdlpVVTJHUkhxMkJUWFozb01YZ3JY?=
 =?utf-8?B?QWZPaFdZTEZjZ2lyN0ZFZ2lWSFB2bkJzRmIvS0l5YzlwUHhxT3R2VTE5V1hJ?=
 =?utf-8?B?TXNRTVZ0cXBscTF1K3RpTSswZkkrYXRHTWFFUVFnTHNTSnBlcTh5T2hPcEVF?=
 =?utf-8?B?QzFSZVc2ZHczSnBtY2tXVzluSHF3KzhVdVVGczVGaFdRYUtTS1dwU0FkMGVY?=
 =?utf-8?B?TjlIdzNmREptN3NmaW00Y1ZZdTIwODdVaGtIckdDRzVvN2tVM21URHBiaEF1?=
 =?utf-8?B?ZmJLc0NYbWZxanZhVjFXWVVOOGxueWZ2MDdLbnp1UWM0UGVYOG5aK0poS2Nj?=
 =?utf-8?B?RVh6anlrQkJmWkgxVjB4WTlRbkN2ZCtiOWVoVTVMbnRSOU84cHVidjhQVkg1?=
 =?utf-8?B?UklrdHhYRGFJTHV1ZDdkZmkwaXZySmlJVWhVL0pialRqTnllRjYxQkZMWUFz?=
 =?utf-8?B?eUJBT0QyMGpYZ1N5VUtpUm4vTUp6U0YyOEtNalVMcEUzWmhwK0NpLzQ5alVX?=
 =?utf-8?B?VytRTEdteVZ1MTdVSGtJOHVOcmNUU09sc3lIZStrMU1XRUsyQzBkdnhtMU5V?=
 =?utf-8?B?UC91ODkwY0swOHlIZXJaSUJkT1JvMjRTMEJDVmdMdjc1RXJ4N1I4b252L1lz?=
 =?utf-8?B?bkFMY0M4NFhnR1FBMnpySWlUcm1mbmVyS3VwY0tvWjU2ZThmRnhtMWVidkRI?=
 =?utf-8?B?YkwvU3dTblpOM0MxOWhCU043WjRwY21nWWM4KzJjOGhvMUtCZUcxNWhIQUZP?=
 =?utf-8?B?dmpUdXZZTUdhVklmOW9Xc0V4azFlVFUrRTRMa2pUZ1d3TFZOS2I1bllycnJD?=
 =?utf-8?B?R09xcDRGV2pFbVZCR1UrNzM0M2IvQ2ZzTEl6QnI1YWtTQWpCMWRPVkcwQWJv?=
 =?utf-8?B?bkNZTEdoRlVNeUZzRy9iUWppWnI2Y2VmOVF6aTEwRC9IdmZ3SFRkdklaOGZN?=
 =?utf-8?B?dWNhbG5LZHFWNk1udUFWQnppMm1GY09GY3JyL0ltZmdOL21FZlNjbHpFUzdZ?=
 =?utf-8?B?VUpFZDAwK3NTVzI1S2tGbnRIUGZhSUZGdXFncGR1cXZYVUdVRWEzaU1vYUlO?=
 =?utf-8?Q?wnkdEw7Gsf1il?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRzU1Z3SXZFeVhHYW50cW1abFpuM0d1RXl6eGN1clRCODh4cndFbGFnZ3Bm?=
 =?utf-8?B?RXRzNWxacGRKc3RFK0RGWHkrbWdrNXFtSVdPYUdmaWVWZ2s0NFNJUmlpSVNx?=
 =?utf-8?B?NWY2VXFJTDFhODMwL1g2MWU4U2ZHdFovMmxuaW0ycXhDSmR6aWRudEhvTGQz?=
 =?utf-8?B?UEFIeUhCMFM5d2VTMkxiUGJ6Y3VNb1JFTkpWSEdiQjB5YVhlWUgxY0l3V2ZW?=
 =?utf-8?B?dTVWNjlISzhwaGkyZGJEb0puRTAvY3kvQmFZaFZjVWFzNVB0OTYvT2JnbEdB?=
 =?utf-8?B?TnM0czRxS0F2ZzJPcFdMaXFVOWdnRW5OZG9uY2N4ZG5WMTVsSTNtQ2FQdm8r?=
 =?utf-8?B?UEo4QWdkOHNBdHNXYlN6Nm5nUlpoSGNFM0hZbExkU3FzWXJvQTg0VU5YV1lk?=
 =?utf-8?B?cnR6NGhIWFIybnhTSjRrY3dEakFLSDRHK1E1cStzY1ZMdUVkOHZBZnQveUdz?=
 =?utf-8?B?RFoxUEFqaGhBOEVGMjRvaXY0RnFNV3hocDd2UFJxOWJPeEdoa0krcXJyRzUx?=
 =?utf-8?B?cHBPQWlwYTRtcXdJbnkvemZMM09JT2V3TUNWN1NtMlExSE9WaXEvekNGRFNN?=
 =?utf-8?B?RlZTbFd2RFhTOFl3Mkk0U20wUWZmZ2s2VGhWTGJsN0REOGVXWUR1dXdFa0hG?=
 =?utf-8?B?TXlPWWlzaStnMkh3bGpkUS85V0pKQTBBQ2RscU1wZ01JMlNaRVF0RmgySnpE?=
 =?utf-8?B?NlFjNkR2YlVyeXc3bTlERW4ybkVBUjQzMDBwZGZsRkV1RHByeDBmem5MbHh6?=
 =?utf-8?B?UVRMUlhXV1Q2R0cvZGtGMW92Qk51cXFCS2dOQXBvMXJJYmgyTFFaam52N3B6?=
 =?utf-8?B?TUMvRnU5ZTdXSVFGaytHczByZWdaVUhrSytvK1BXRC9rTWkyM2xsODB1S0gx?=
 =?utf-8?B?aXplckdwVlJONE1hNHZKL0JJMmFRRUVveFU2RkdjVE9MWHFCdUVGbG5semla?=
 =?utf-8?B?eDFUS2hhVW8xaFlFaVRjUzFqbVBnNytzYnA0N21HUzg5WWZFTUIxUCswejBK?=
 =?utf-8?B?TnhPNG1ydHU1S1g2b3d1bDNTWVhvUE1DMEVuMHV4TEFqZWJzeDRMUlJYb1g5?=
 =?utf-8?B?OGtBcU45TmhMZGNXVWRpR0xPdnFqeWtCRjFrekYxYmtwWWdkTGxvRzlDWUZF?=
 =?utf-8?B?R1diNHdpV2RKUDJpcGVPUlJYak92MmlZcDh1WnZnc1kzTjc0a0tJTEQ5ZEU1?=
 =?utf-8?B?aW96eWVYOVEwd2NLa1A5UXVUVGVaSkFHS2RVem5rckFQKzJ4VlNGMmphZUdE?=
 =?utf-8?B?Q3kxVlNpdjdVZmZra2V2ZHVxVnAvTWlxMlJZT2hSMmFqQkxMMytrUHNQKzBw?=
 =?utf-8?B?c0kwRDF5VFMraEZQSkpiUHN1QjZBYnB4UWlGN2h2T1FiaDJJWUhoQUZaNGx2?=
 =?utf-8?B?SmtobnRYS2V2TlRKSzdMMXgwV1BGNGQzRWkxVkp3eFp5UVQ0aGxrMHFZVStF?=
 =?utf-8?B?dk85M3diWjQ2SkY2aTdRZk5tWUZob05IWVpGcE9jVUhrcnRRc1l0K29BVnhl?=
 =?utf-8?B?YjVnMVJRZ3dQb2hIaG9ub0MzSGwwZFArZ1dyNFRnVTkwTVBsMWp3K1RycFhh?=
 =?utf-8?B?N2xkVk51bWhlL1cvdWRWQi9DTi9OZ0MxMFUva0ttZkEvNVpUcWJKMEFxM0h6?=
 =?utf-8?B?NGsvSzAzbTUrWE1pR0piZVJZTWErZXBtdlVkY3JTNkNKM04zTW5EU3ZuZTBL?=
 =?utf-8?B?cWJsdW41YWlISnRVYkpRWWY1VVRteVh3N21HNUY1U0NHQThWaWtHcUpRRE1s?=
 =?utf-8?B?QVdmeUNTczJWUlFTNUpZNVNZVG5LRDBFdUhUZGdWZksxRUlXTlJsUEFmSVMz?=
 =?utf-8?B?Mm1HWEthNGFMQ3pDVFBjSVUwTEFKUnB1OWZDbnNzZkpyTUNGSGoxMkhOQXpC?=
 =?utf-8?B?R0wyTnFNdklNaGxlb1F1cCsxeHdPRk16Y0dlN1VBV3p0MGpvNWI4SDNrRVpC?=
 =?utf-8?B?VTN3NExQbWh1S2JxMXhzZENkdFVSbWxCMlMzVk4rVWJ2d0dhZlJ5OUlHYlEz?=
 =?utf-8?B?NkdKM093akZVdi92U1FaNUwwWldvMEpkcjhHN1FwTnNZNldlcDVEdzFlN0N4?=
 =?utf-8?B?ZisyWll4SzRta3hOLzJzcnlnbUFiSUFmZXFWTzg1dFI2NVVOV3dabnU2WXZX?=
 =?utf-8?B?NElJYzJHbUphK0tEY0F1ZkdCSk5tRWs4UGJoVldiM1dhZUpyUjd5bUltbC9t?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5700e31-e82f-441f-7308-08dd5d31bc6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:37:15.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4HtFw0bMAN8pdzoI4TMepLOBKblGM7Z4Zu5lLldVTlVz841wPn/X5v3Si0YNu/C5/ui2XCcZoq1lnLLLOKRt1Y+g42251aqvgttK8etQyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> When BMEC is supported the resctrl event can be configured in a number
> of ways. This depends on architecture support. rdt_get_mon_l3_config()
> modifies the struct mon_evt and calls mbm_config_rftype_init() to create
> the files that allow the configuration.
> 
> Splitting this into separate architecture and filesystem parts would
> require the struct mon_evt and mbm_config_rftype_init() to be exposed.

Same comment as for v6 [1]:
"Please replace all instances of mbm_config_rftype_init() with 
resctrl_file_fflags_init()."


> 
> Instead, add resctrl_arch_is_evt_configurable(), and use this from
> resctrl_mon_resource_init() to initialise struct mon_evt and call
> resctrl_file_fflags_init()
> resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
> obviously benefit from being inlined. Putting it in core.c will allow
> rdt_cpu_has() to eventually become static.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v6:
>  * Fixed stale function name in the commit message.
Fixes seem to have been lost.

With changelog fixed:
| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

[1] https://lore.kernel.org/lkml/bbbfd020-ee0d-42db-b055-f4056d63977e@intel.com/


