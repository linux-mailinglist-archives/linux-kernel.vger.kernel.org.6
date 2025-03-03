Return-Path: <linux-kernel+bounces-542767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6DAA4CD6C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA399173D2E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF01EFF9F;
	Mon,  3 Mar 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8hnpNEs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D51F03D4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036893; cv=fail; b=fDjcLzOMKSWlju2RLY3gJiwe0DnmC2MVkV+GXWgjaeSsPDioeYUHjALOA7Sfr04maUUDVV3hO3H44WKWxKlCT0r8Q3th/ZPEy5Wax2WZ28ooljahMYNBmprw0uJSTz4AkzEQx4b3MO2DVYVT9ViQaFQgGJ0/04zPdNFTWefU6Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036893; c=relaxed/simple;
	bh=T/XDpxgzZBArRCSvrTSX8X78EwsUZx7nb/wfHNHotNk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HdUfF7AMd+njiJRq2KL93VVuCRQRxw4qe4iB5uX3Z+p1E8ODvyEBxdCvMWtr59p/+YHZ8ieG/dMSKm1noqRuZUMJtuO1G+0a2UpE7X14KMOKeioHQUmq4LW19jZU4kMTAVFEGsaL2LJd/Ia0zdYaTxEQ18XDwZubf+ClSn/Sqt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8hnpNEs; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741036891; x=1772572891;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T/XDpxgzZBArRCSvrTSX8X78EwsUZx7nb/wfHNHotNk=;
  b=S8hnpNEs8aSciaagZIrexiM2Z3qc3YCcr2ZHBQ4e618fev4Jdg2LcfVC
   R4610ZTrzgMhiZ6EEMR9dll7XNAFeLZKW5/Upg/bU/usjKM1tAaaQTVnM
   l8nD5IaBgDEhgZ22Xwkuvn1O88Mz4b6sqqw3BADFPDX4Imyf1zKKPb6Nk
   39Jneo1FmpSgHO4sYbsSBG48ftmGY0CpUuqrbt+4kXFXQWq7F5aCs9YVB
   ZmdXeF97pKsFs3fSn+SAK6nHWljUJdpLQeRLa94zvsVu65OUeZSQc7dFj
   YQOSynTYzj72FIXDtU5EPf4/HL43dXXtbyHj1jCyKKZVmAHIwp5X31gR8
   Q==;
X-CSE-ConnectionGUID: KOGl3+7tRVq9C6o8XIh2nw==
X-CSE-MsgGUID: /lQhj53IR4elUdzfwffpkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="64376923"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="64376923"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:21:29 -0800
X-CSE-ConnectionGUID: 45pi1Kl3Sced8IayYW863w==
X-CSE-MsgGUID: Wg7FIYNsTGSnRfC4iecmLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118692477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:21:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 3 Mar 2025 13:21:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:21:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 13:21:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Alf014UGe+6jIBULH6byZmhQP76cxxjWD72ZAcKf1plgn7o5eN4khg9htQcYVsr0MSK6UZ6J4U4x9ROkidp1l7aTd55vl+zsFssk7VndM7HvDL+d9Icul/3IJgSx9F015cnNoLp/CJGutlZMbUyBGIbFJmbMuqCDup1Il6nt0/O4ERRqqL4uQeyLEw5akG6tgaupd98lrVuoXzycYG0+Zz3DA+/HlJnYZbL7zGPRvLtDPSFp6t02HbA1Wu2uvbKCg89ven2g9NbuLFPLANLlA/zaBMSvlt8WrOlo1xTGASszQGmLj1pDHkX2MgO+PY7Tvi+ASoWkKEcYotvT0aSy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcTcEJmgqXCxi7BU457/QrXPpPyrvKUxE3YfUPrDwv4=;
 b=yVHn3FX10/eEf6C+j+LSTwYDrdJWZiSM8rgtf75hNGj57Fy9QF5CntggvY19w6+UBLS/rn7bdManQXi7ZGGBRAm1L3D3qS+CQNTWpsRAn9oSi4u6LQOwjWosVSg17zvUl8CKowM6VhDxSsgUroMykpCcAtcYKgiHYl2xGyJ4+xa5dtwAGEac9tXJDCpnSdJmukUUa8abCEr8RmvBHjPlWyrN60s3BYRsmI1mYJw4LzEszouT3g47efwEnYZHH85vas0Oy/8qPm2Jcn3/R8oDsVuAcWsRnTpNkA506lkfpX++jVsurz6ofadRJHegp436Kkf6fFJ1V1ex1qzlCo5vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 21:20:44 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 21:20:44 +0000
Message-ID: <1d3d10ae-f2a8-4d31-818c-03b890cbf3b0@intel.com>
Date: Mon, 3 Mar 2025 22:20:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/smp: Fix mwait_play_dead() and
 acpi_processor_ffh_play_dead() noreturn behavior
To: Josh Poimboeuf <jpoimboe@kernel.org>, <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Patryk Wlazlyn
	<patryk.wlazlyn@linux.intel.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
	<paulmck@kernel.org>
References: <e885c6fa9e96a61471b33e48c2162d28b15b14c5.1740962711.git.jpoimboe@kernel.org>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <e885c6fa9e96a61471b33e48c2162d28b15b14c5.1740962711.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|MW6PR11MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: cc63054d-5a04-4dfe-72cd-08dd5a994205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHk2VkhxNHY5Um9JOUJiV2NuZnRMemNIa3VrYUNieEdtdE1SdHlZVVZxREFW?=
 =?utf-8?B?aGR0SlJkTUxrenlaMkc4T3phRnFBU0diVDdXZnpWTEduc0dXOEwvOU1CVE5m?=
 =?utf-8?B?cGtNK2x0UFRjK29uTDVTbHNuZFRMYTdGbHJtTjJScFF0b0tHWUtKcWxlbkZn?=
 =?utf-8?B?a0JQZE1TN3NIUGIxNzBlTTBHWVNZT3Nnb3ZEclpZU0h1TCsrU0hFNWFGb1o5?=
 =?utf-8?B?K3YyQnN6dmpLNXFXTk5nQmk0YnpPcnY1WHBMTHJUcTRUTnBVQUFJSVJuaURp?=
 =?utf-8?B?dTdjcVpMNHJXM0pESUdvbjF2TklWTy9RNEdlZkhtbitOQ0ZwLzJSRXg1ZENT?=
 =?utf-8?B?eFdYZUVRNXBkcWRrdjRaYUFUN0s1d0VVamxLKzZDYnIrUDJyY3F5WFVFdFRP?=
 =?utf-8?B?K2lJL0I1WVlKUXFMc0UwNFIwUVN6c1lLZ0pyaWd2dVI4NE5GbHk1TnYvV2NN?=
 =?utf-8?B?UzVnNjVOQzJaRzVkTmF3dW9mNEhvUEw5OUdEWjc1N2NLUE9PYkxPZ2lpTEM5?=
 =?utf-8?B?bTNGcyt5Um9BVnlFanNTNjZsSjZBR3JvREM1RDhNMEcreWhPeFB1QldvSTVv?=
 =?utf-8?B?WjNYNHJzRkJ6V1k0djBrZ1NieUZGYytQZHlzdksvS1FNeHp1NVBLTHBmbVF5?=
 =?utf-8?B?SzZWRlMveEd3a0cybzQxbkZqYm1vem9hcVZTcHh1bTdkdXVGOS9YNFV4UVhF?=
 =?utf-8?B?Mm1wZmVabWZ1eEY4UnBjaVlnOFo0ajEwelZ3M0w1YVR4cFV1MnM3UE1UUTlT?=
 =?utf-8?B?aEZrNjNhcVlmZjVwR3NTT2dKaWovUTVrcDJKektEN3ZRQU0yWE5uTmlyNmg0?=
 =?utf-8?B?S0VZSHNZVXRiR1RURzc3a045cEtIZm9XUHdZNXFOcXp6QnhWRjIvOFVrNlhs?=
 =?utf-8?B?ZVhIL0xFQkJGT3V3bCs5UlRERXBsSGtnSDFxSW5NMDBrb0I2dnU1VW9RNW55?=
 =?utf-8?B?bVBtUUE2ZHJoaFp4WG0wdHB6ZlN0UnRWRHFDVDl2a1J0YUY0citFdEl1Sytq?=
 =?utf-8?B?Ni9rU1ZScGF4STJYZHhrUmMrMFRKK2ZkbWQ0UjNtSDFXckY1T0FlZWhLT0dy?=
 =?utf-8?B?ZEN4Y21EY2s1WWU4RnJOb1pWRldwODFIajY4SnZxdG9BNDhIR1YwTTVDaDl1?=
 =?utf-8?B?bUdOS1lxWEZWVFl5K3d1Kzc2VmgwbzkycXFEQ0U0OTluQ3I2OXMyblFkK1N2?=
 =?utf-8?B?SU1QMGl0SUpvRDBGakNWRmxmUVU2NkgxVTZMTW9EWXAwRDdBelB2N3AzZVZw?=
 =?utf-8?B?TFNoSnROZktNTjV1ZUxDZHB2bDN0Wmg3R0Z2SXY2b05acGlYZ0dka216YTJL?=
 =?utf-8?B?dkJNY2N0Nzl4SDJ6aGJOcHVxeVRNdmJrSDVvekpxYk0rTm5lVHBjRG9veTB4?=
 =?utf-8?B?VW1PZi9KWFAvY3hhYlVwc05wbEpJbTJXMTNZaEpmVkF4amZBU29rRWVRUkxu?=
 =?utf-8?B?M2FiaE5MQVpYa1ZIVGNFMnZyK0ptKzlrVTd0UFFsSFlJUitSNWRBZmJLK2tG?=
 =?utf-8?B?a0Y4RUpQVHpZWWJ1SmtHWFlpTC94a1BudlJ1NjhyMTladllDaERUM0JiamlH?=
 =?utf-8?B?Kzg3SysxMHUzelpPTk5PZjRHTjVvZnArNUUrM2JvaUhKai8wdnE1d0hLL2hD?=
 =?utf-8?B?WGRtWllHS1h5b3JVWlFmUUtLS0lyNmRIMlJOTVJPbDVPYzRGVHVwNllCSmU4?=
 =?utf-8?B?MzRkU09GaEYreldVbmdaMzVSVnBjdTFUTXZBNkJXRUptcVd2WXdUejdXdW9D?=
 =?utf-8?B?SlkxR1RTVFdsR1ZOQW5KeVNENGk4elpZY1RTTnhVckxDcWgvQnVKTUU5M1FB?=
 =?utf-8?B?TnVLSEpWTXBGbzVHazQ5MStyQzhEaWlFemo5cm9oa3J3RDgwenRaSVZCbGU3?=
 =?utf-8?Q?zuOc+PJU7ggbN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdqTWx6MnVMcjF1N2llQ0Y2UjFKSXF1dDc4dEVuTDNSQm10NkFhVFpHTFRX?=
 =?utf-8?B?THlhK1BNRU9jL3pvOVdiSVZ3MllZUDRmNS9oVE9NMnErMnpqbGlHdlRNc3lE?=
 =?utf-8?B?dG5qbDgvSUtHM0l6N010MjR2eFBabTVSVTBqTGhKNmdseG1PeDVKWkxldTRy?=
 =?utf-8?B?UTlmMzhzM3dWa0VZYm5vdEdmT3BJOUp0ZTJWeDJWQzUvcUtvMkhJcU1maEV0?=
 =?utf-8?B?Vy9BQXFuMVhiYnA0WlpoY09QQjJ6azkrNU1BMFBPL1ZLbHRUeHJxbXRtQmpm?=
 =?utf-8?B?T2RmNUJtR3dsWjZoWFE0Y05aQXBTTk1hNmF4dnRhWXFCaWMzWDNjK1RPY0Vw?=
 =?utf-8?B?VW9hU29KZFljeHdtVW9Ub2ZndlRWTHlCaGQ1QWMwT0xydlp3THdnTVgzQ0dZ?=
 =?utf-8?B?T2hKcFhCZThBWTdVOExHc2tVR3hGUDVIb3ZCRC9hQjQzOXBkRDRaVzFTbWdL?=
 =?utf-8?B?dndtZG04MmZmQkpFRFVJczBCY0NjVUU1Y0daNHM4WmhOSlp5RHlaWEpVSi9J?=
 =?utf-8?B?NDMrMmlDbDZUdVZjV2VlaHJ2NGdjQTlwVXB3YTJ0SjhRME9nL210dk5tcGI1?=
 =?utf-8?B?K1VKUXVDakc2RG5vY2s4d2xxWjh2UVRZQmdndUI1MFlKS0xOUFZhU1N4NklN?=
 =?utf-8?B?YVVuWUV2SFFzSERDWVFLNmNCTWVIaDJhSktJc0g4NWU1SnliM0ZsNXdscWdG?=
 =?utf-8?B?M0c2M0FrdFphTzZXMjBJVUo2eEROcDM5emNWTUZmUXdITlliRTEvL1hoQm4v?=
 =?utf-8?B?Y0s1bG9HbThzN3d5SFFGZG53OWx1YjBzWjZIN0FXSmNMWXNvdUdxeUtCMjRj?=
 =?utf-8?B?M2xMaytBMDFGQXNLVkJjOFNZcTg2aTJlcEVvOWYvaHA1aWw0bHprNVFyVjgr?=
 =?utf-8?B?dS9XZm9GL09VdUhRVy9RSnJMd1c5NG1lWU5tZUI2K1pDMTdTMDJBMHBteUJw?=
 =?utf-8?B?U1JFVnY3anRKbDhxSXNsS1ZsZXoySTJ6QzBaam9uUkdxMDAvYzVVWENKL2hz?=
 =?utf-8?B?b2FHNm9TSG9idGdzZFNaOEVWbHh0bHhZWlErZWZzRm5yVjBEZGVWcGtPTERC?=
 =?utf-8?B?TEhoU3Uzb3l6a0trUEtRR3NNT2llZjRZSGVEMlFxNlNPZ0F3WmhCaVlxUy9J?=
 =?utf-8?B?cEh4MGxGNEcvQjZxYVk2c0ZXMEp1UzJjU1kzcTdZWUxDODdBQnpBN3FWZHo1?=
 =?utf-8?B?STlmbkNrL2xKS3Brc2hmQkFBYTgrN05vcEMyUEVNc3R5Q1hxMnpneGxnUUk2?=
 =?utf-8?B?NkJGM29pcElZVFp2V2NQVEJJNU9wUnl6WFNZWDVtRi9ZeHM5cGFla2hKSzhH?=
 =?utf-8?B?dWdMd0gvejZwWXdlMTdCcDB4akhoSlJjS0QwK1NzNkNwTlJyY2QrME4zclEv?=
 =?utf-8?B?MEd5VnZKNUJGdkNuTVlrcDkyeDJNeTExUnZ4TjNSRFdUM2FNejhiVFBEZEJZ?=
 =?utf-8?B?YVVvV0lFOTRsdFduTGppaW00NmtUb2VNcjkyMUJOY0FYQncyblZoNFVqSU9r?=
 =?utf-8?B?dUtEVEl0UGpSVGI2YWNJY3h1emtmS1YvOGoyYTlaOEw1RHdvV1pmOHVDUldt?=
 =?utf-8?B?Y0Jmek1Vc3lieFZRZk9rd1VhbG9QbHZadm9xWWc1RmlEc2lIcU1oZWpOOEVx?=
 =?utf-8?B?eXJMR2taK2htSmQvdElFcHVKamF4dGlDSCsybUFUMEtWVitrZS83Q1g0QlE0?=
 =?utf-8?B?V3ZsQTN2ZGM4WnlqRHRsOWVhbVJpOGhJbmpKa1ltbzJvOTJEczRBd0lrbVFj?=
 =?utf-8?B?bWxZd3VxanRrWUJqejZISEluWWhISFNxTHFtbEV3eE5sdm1TNmxJTkdPKzBI?=
 =?utf-8?B?YUljY2VXWHVJVDBtbUxiVHc5d1FyZVlpVkJ3Q3RkVGVJNUh5MmE1TVNvc25Q?=
 =?utf-8?B?UmpYNzE0ZzRLWEIyMlBLOENXa25WUXFZVXZKV0I1SFlIc1F3UUxKeG1xSE5N?=
 =?utf-8?B?VGREQ2hNNDZPNlJmMnM1OWlDMWJPSXdQMTgxbGpMblIxZmxXYWU2M0FiT2x2?=
 =?utf-8?B?Vk9HNEgvdjN5YTM4TTZGY0NkKzUvMysrb2hqVmNFd3k5QWRtYVcxTy9HVEF5?=
 =?utf-8?B?dnQrS3g1aXZEcnNOTDdkNTNDMWppbnZSQ0pQWWRPKzF3RjN2eC9BanBFeVU1?=
 =?utf-8?B?WWNRd1ZQTGZLTjR3cXlDbFJFNjdCSE5jYWh3MnI2YzY1K05wNmg1NzduQ0tn?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc63054d-5a04-4dfe-72cd-08dd5a994205
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:20:44.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edCgxLsDwyWG64dx2mYpwSEiXDQbXuN1L5mDoePpRjrgJD9cvHKQP0xgi5xOktBvqhQ0U3ADhFIMJOH3HjbR8EtIPK+U0tMydKxAX5s/wTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com

On 3/3/2025 1:48 AM, Josh Poimboeuf wrote:
> Fix some related issues (done in a single patch to avoid introducing
> intermediate bisect warnings):
>
>    1) The SMP version of mwait_play_dead() doesn't return, but its
>       !SMP counterpart does.  Make its calling behavior consistent by
>       resolving the !SMP version to a BUG().  It should never be called
>       anyway, this just enforces that at runtime and enables its callers
>       to be marked as __noreturn.
>
>    2) While the SMP definition of mwait_play_dead() is annotated as
>       __noreturn, the declaration isn't.  Nor is it listed in
>       tools/objtool/noreturns.h.  Fix that.
>
>    3) Similar to #1, the SMP version of acpi_processor_ffh_play_dead()
>       doesn't return but its !SMP counterpart does.  Make the !SMP
>       version a BUG().  It should never be called.
>
>    4) acpi_processor_ffh_play_dead() doesn't return, but is lacking any
>       __noreturn annotations.  Fix that.
>
> This fixes the following warnings:
>
>    vmlinux.o: warning: objtool: acpi_processor_ffh_play_dead+0x67: mwait_play_dead() is missing a __noreturn annotation
>    vmlinux.o: warning: objtool: acpi_idle_play_dead+0x3c: acpi_processor_ffh_play_dead() is missing a __noreturn annotation
>
> Fixes: a7dd183f0b38 ("x86/smp: Allow calling mwait_play_dead with an arbitrary hint")
> Fixes: 541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   arch/x86/include/asm/smp.h    | 4 ++--
>   arch/x86/kernel/acpi/cstate.c | 2 +-
>   include/acpi/processor.h      | 6 +++---
>   tools/objtool/noreturns.h     | 2 ++
>   4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 80f8bfd83fc7..1d3b11eba084 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -114,7 +114,7 @@ void wbinvd_on_cpu(int cpu);
>   int wbinvd_on_all_cpus(void);
>   
>   void smp_kick_mwait_play_dead(void);
> -void mwait_play_dead(unsigned int eax_hint);
> +void __noreturn mwait_play_dead(unsigned int eax_hint);
>   
>   void native_smp_send_reschedule(int cpu);
>   void native_send_call_func_ipi(const struct cpumask *mask);
> @@ -166,7 +166,7 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
>   	return (struct cpumask *)cpumask_of(0);
>   }
>   
> -static inline void mwait_play_dead(unsigned int eax_hint) { }
> +static inline void __noreturn mwait_play_dead(unsigned int eax_hint) { BUG(); }
>   #endif /* CONFIG_SMP */
>   
>   #ifdef CONFIG_DEBUG_NMI_SELFTEST
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 86c87c01d23d..d25584255ab8 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -206,7 +206,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>   }
>   EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
>   
> -void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
>   {
>   	unsigned int cpu = smp_processor_id();
>   	struct cstate_entry *percpu_entry;
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 63a37e72b721..d0eccbd920e5 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -280,7 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>   				    struct acpi_processor_cx *cx,
>   				    struct acpi_power_register *reg);
>   void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
> -void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
> +void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
>   #else
>   static inline void acpi_processor_power_init_bm_check(struct
>   						      acpi_processor_flags
> @@ -301,9 +301,9 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
>   {
>   	return;
>   }
> -static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
> +static inline void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
>   {
> -	return;
> +	BUG();
>   }
>   #endif
>   
> diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
> index b2174894f9f7..5a4aec4c4639 100644
> --- a/tools/objtool/noreturns.h
> +++ b/tools/objtool/noreturns.h
> @@ -16,6 +16,7 @@ NORETURN(__tdx_hypercall_failed)
>   NORETURN(__ubsan_handle_builtin_unreachable)
>   NORETURN(__x64_sys_exit)
>   NORETURN(__x64_sys_exit_group)
> +NORETURN(acpi_processor_ffh_play_dead)
>   NORETURN(arch_cpu_idle_dead)
>   NORETURN(bch2_trans_in_restart_error)
>   NORETURN(bch2_trans_restart_error)
> @@ -34,6 +35,7 @@ NORETURN(kunit_try_catch_throw)
>   NORETURN(machine_real_restart)
>   NORETURN(make_task_dead)
>   NORETURN(mpt_halt_firmware)
> +NORETURN(mwait_play_dead)
>   NORETURN(nmi_panic_self_stop)
>   NORETURN(panic)
>   NORETURN(panic_smp_self_stop)

