Return-Path: <linux-kernel+bounces-244714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1C92A85C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7514E281C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D37146A85;
	Mon,  8 Jul 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTHTpqdT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA673C30
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460844; cv=fail; b=pQgp+Se23UFk0kyqnOddU07Out9CbQANFZwLGi08805ZPCr8B+eUrzW06yiSciQYV3WwQ7VRvyPOmTgY6lkJS/7PzPBJJnGHCOUqQRgyhHw+mWu/kOZ85rnza/4GoEEmGX9+c7PNATS6SV8QcDMY33IEG1XyZ9jLfEPQy4zavrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460844; c=relaxed/simple;
	bh=k12cTWHJH2sE2pXYaO7MxuaIbCn4V+ion8iZMD/LpAo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bNH/2dde98nboYU3XeCLrFurCnw0fv50XNesBrtYjNWa+x8ZIjnwdR6qhU5qEOi8CgHZ0ZhFAQXUYab6RjOCYpnqE/AypqtUdQVtf1ih7z+kDnYOZYVhYIprAqMDt4EIzmcJYNurFAlvtys1qJ6wzIFiwgvecDzqWRC95ytGjdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTHTpqdT; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720460843; x=1751996843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k12cTWHJH2sE2pXYaO7MxuaIbCn4V+ion8iZMD/LpAo=;
  b=gTHTpqdTsuPhp+KChjiMmr6FQT5KVUQ657pCrvcksApxQ/529rl22Ad5
   ODBqxG2y17s87+oVEOKOSTRbN2YUgmiAB1fWWxXdttU69ReuvWZu/QW4M
   4qre/PEuLF8Wj5j73f2rJedrwWfoYP0URtHsE/KfrLFjWIlHg2p3nxEGk
   VGkl6yLSfb1Cbi0Ql9j4Th4OG47QPJbScSkXjNn2e+QaydlGNytLeED/t
   y3hW4pLcPYYds4GqRQJ2WW56AJsKIv9WWzia9WkN4vTSqDmU8p2luiclZ
   499+MNMwbGCqWlmI+IdZoCGFGJAD4DrCBChLU0mhrr5SAY/EjlclRtV+l
   Q==;
X-CSE-ConnectionGUID: 5h4NvNArSCi8AqyRqR2MhA==
X-CSE-MsgGUID: 8DbTL/nyRYiIGarf+RmIRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="35214648"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="35214648"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 10:47:22 -0700
X-CSE-ConnectionGUID: BTABmD+eTy+BQNXtDsVi9w==
X-CSE-MsgGUID: 9uooUASXTVu7r5/8ANWjYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47677105"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 10:47:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 10:47:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 10:47:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 10:47:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 10:47:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T52sV4jZMZI45VkRTWt+nGpoN8Pa1trCiBsznDal7Crbee0iXJbmusL8sKv2x2tPr93Nr7PGKyvOvDfWAYtABDkn1/aRyacDy1HDAL2FZu/OMUPIMMNbm6BvE63qwWhr2vVCgWLg8HZGjx1JlGnge51t4AdY1Qt71heP6hqbGsh0f4KUUbQ6NIap2zCtODy2vNEAOP0RaRib+EUQzxIuX+0lYx9cVhvre3zLG9BEpYRFMALwGf3LTAjkUCb981h0xsZrhR2zy9gXiNWF+381RDqv6L6SC7KAwD5M4/pQxO9tHqrRiUDVZ2YqWBojOrD++CcSmB07WYLPur2PLOiR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0kp7IzJ9PF+9AIJOUp3IRytYPrBzzVkHYgtlCsidYo=;
 b=CgYftotUBak+vggJVHnO1/yc5BlrsLCCtJnYZlBl/WUvBfM1ryqNrwlfrTIFgHVJgp6g/jJ3DBAyTUfym1cqt6qVP+dsUBXz2sm2zyLtc2B6ok4p/iSJ3XeHlJcEHHQFiMyNnuS7c87TSyIHq7PlDLa5/S7VhH30LqUD7Ynk4bF3rc9QivC+aHLfHXrS7jEbbnPOly7QSx7iNV71KiCD0fHnjK7Vzkm5JQOHseKyhaBRtIOPJpyeJD61unhWt7rPjnIuybda9qdqs7iDvIKD8LUhrlNyehDnaGz5DSYYShy/SACKL7IMmzk2MQLWwYsXug+/5XeRIK2Pblieba9zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:47:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:47:16 +0000
Message-ID: <ea8692da-b3b9-4299-aced-bd4e03edd030@intel.com>
Date: Mon, 8 Jul 2024 10:47:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/38] fs/resctrl: Add boiler plate for external
 resctrl code
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
 <20240614150033.10454-37-james.morse@arm.com>
 <d7aa590e-7ad5-4eaa-9ea0-94322b802dd5@intel.com>
 <a7122237-969d-4757-8c93-af261a8d69d1@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a7122237-969d-4757-8c93-af261a8d69d1@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d3b90a-ebca-416d-3544-08dc9f7601fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUdCNEVrZnl2bVBVQ1NwRDhpQm1Nc3lRT1o1ZDdLVEw3MDJURGRzclk4eDNU?=
 =?utf-8?B?emVTTDM4Y3g4MWlCRnF4aWtTNzREb0tkVlBWcytUTlpDKzNoMFVWYkdiQTU3?=
 =?utf-8?B?dHlwZmsyQVo2S0VEMHdTTjJzaUliRHl6N0RTdGViZjBmRGtSMElSdjlXYXRF?=
 =?utf-8?B?WWNTZGh6SE9OUnlXUEtHQXBpRmNGWUZid1hJZlF4MlN0eDZITXlYbGZWYlQ2?=
 =?utf-8?B?MjdPeGVDUGsyZjVmcHNsdFA1ZEJxdVIzVUFnUmZKNFdRYi9YVjdoRE9mODB6?=
 =?utf-8?B?Q2FXU2M2ZkN0eVRFcTlKODM3MmlUcXQrWTRaU0xJaTRFb2tjUUlGMW93ZHA2?=
 =?utf-8?B?T1ZLTm9ydjkxZUY3WUtBejJZRGZOdzdXZDllSmtlM3RPUXd0dEUwWkZvVVEv?=
 =?utf-8?B?cXBPb2FkRUlOb2srWUErVWxBQkhHU2daQURwcVNoS21TRCtaRGYyY1ZSYnZ0?=
 =?utf-8?B?Zm1Tc0N0bVo4bFppRXZMQS81M0lhNjY1ekd5WFBFSUhXT09EWHNtT08vdFV2?=
 =?utf-8?B?azNLb1ZmNXp4NFlqS2NzUy9RM0NRcjBUazZPSG1JYU1kc0FhK1Y1QmhnSTln?=
 =?utf-8?B?NlRVRXVJcitPM3Zud01hZ1JGbVJFSGJQQnhwUktBTlpiNzZxMG5vNURzZGxO?=
 =?utf-8?B?U0FPbWtOSy9LZS9sY0VSQnFLRG1wQkRHUUdJYU9IcWtTakYwTEIvQStkZWUw?=
 =?utf-8?B?bW90dEV1WHIzMnNObFI3aTRMS3llY1JzWThoU0ZWU3I4WlJXMmNFQkF0VlI1?=
 =?utf-8?B?dFVYNnFjMmhKUFlqK2dkdkJVRklRNDQ3YWhuR0hHVGZKMFhVVlBXMzZzYXNJ?=
 =?utf-8?B?T2p1aElNQk9DZGQ4L2NTOFNFUmhMaUx2VjFrQnA5M1lpMGFjNWZlL0hzT0Nw?=
 =?utf-8?B?U1VRakJMRnNOQzlQT253T2JxYkNMbEN4d1gyR2lPWUo2WXQ2cTVsN09tWHE4?=
 =?utf-8?B?MlFQSmJLVVNkdnlXMThXQ2pzZzEvck5teUg4VnJoMEpuV2VTT3pHR1BTbmg5?=
 =?utf-8?B?aHNtcDdJUW01ZmVrWDNiZCt4THNmNlNIRy9OajltaURpbUdTYmFremxrTnFw?=
 =?utf-8?B?S045b3VaM1dtNFFHbncwVHJWZTBuOXlqVnUwTDhaMnhRd2ZVM0trMUlPc1Jn?=
 =?utf-8?B?ZHFpdFZZQTV0UmRXcnpkaXgxQ1NqZnBmK0VVcHpGY0lBMFZBTzY0OHNRSXB1?=
 =?utf-8?B?QUJXZUtrOWpValFxOElGUjBlaDJYR3JLOHIveHpjdmp2a2tFL3hVV2wzQkZT?=
 =?utf-8?B?M0VES1dTc3lsUSthVkdXN0dWZlE5ZkIvbGpvaUE3dUVLZUVCRm5DSklqY3lF?=
 =?utf-8?B?ODVSZEIwcUtvQndNU0tMaGlCS2YxRkwxakdISVpxcEFoMFQ0SkVNcmZ6TXNU?=
 =?utf-8?B?dWwyblF4aXRNbkNHbzlJQkp4T1lteW40dnJSS0RxaW5NSEVuOEgrT0dlOCtJ?=
 =?utf-8?B?V2dhMDJCcjVaa2VpTkh5aGs3TmRGd2JiSCt5ZUdPdk1MMC9NQmpvdjY1dita?=
 =?utf-8?B?RnExYmZSZitSUUd5QU9HUloxZ09uZjdqdDZPRkZibnprY3o5a1FjV0VDNHVk?=
 =?utf-8?B?SHBab1B2YmtMUzdNa29vWGtpNEFlZG5RMFE0MkJSdGlYcjFPbVUrSXdtUzBJ?=
 =?utf-8?B?Q3VvNFdZRStJb1NrVGFKVkRKQUd6aFRhZ25KVndpOUhwQitBV3RTRzVzdnBM?=
 =?utf-8?B?dEc1R1JhQmRXSUdKaUtnT1FKdUZCb1F3QTMyZ01HdTVyYWVqaDRGSlhET3cy?=
 =?utf-8?B?eEkxTUY1NnU1WXA1RU4xMnpuVWdzLys3d0xPQklzNE5SOVhVSk1EdWdCb0Jx?=
 =?utf-8?B?Q2NxM1dsd0lSK0ZuY1A3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlNiL0U2bkk1c3RLMjdvNWR3cGp4MTVXT01LV2dNQjFkL0g5ZUw1c0lGUFc4?=
 =?utf-8?B?eUcvdDRSTkkxOFUwZUNSQ3VIVXRvVFJWb3V2eFBpakJwM2JVMVVwY0tSQUVB?=
 =?utf-8?B?MmlvT3JUbmhOeUdCV3hLNVkzOG5qTjBjYS82bm5YQmNsWGFRbVc3UlpkajEw?=
 =?utf-8?B?bE1PZ2xrVnA4U3hSVjM5dStTV3BBRXFPK0ZZQndGNnNCLzZxMWdaaldxb0FI?=
 =?utf-8?B?UVRPdk1HZ0U2NHdaSGYrWFNnbklkbUI1dXlLQVZsbTlKTDZQV3FsTGJJR3Jp?=
 =?utf-8?B?T25mcjQyMll0SytjOUdBS1Fsd0tHL2R0YzQrRlVWaE1QVTBXdlJORDJRV2lI?=
 =?utf-8?B?eDdldy9EekZZc1ZpSDB1QVZXaC9UR2VwaW9peEVuS1dSMDVoSU5IdTFUZmRz?=
 =?utf-8?B?V1drcExEbzc4UlE5VXYzUFU5OTFDcUxCTkpuenRudjJuSjI0cmZmNVlLTUpX?=
 =?utf-8?B?VkIyaEFRUmZPNEl5SDA2WWFnd2Y3Q1BwejhLdGM2UDFrSm1hbVNkWVRicXpX?=
 =?utf-8?B?ZjhFNG52QytRMGNyREpFVnlhVHl1cGhyYzFjcVRWSWhLZmx2eGFqdzNkOTdl?=
 =?utf-8?B?YmpOcXVsdXJQQmR3SFhlUjc5aTBKeDU5emptdE9UamUrSlVhSHJ5YVZWOFlE?=
 =?utf-8?B?bjFkcUx6VEczVVlwdk9KY2I4OWJtT0tXMDhKZlBMNWV1MFJnRC92STA5T3JM?=
 =?utf-8?B?azJ3cUc2MDRTcU9RN2RlN05Wa0tjYkFHWmZtcnF5NkpsYzhOcEo5TzZOYUhM?=
 =?utf-8?B?TDRMNVhueUFLRXJUb1E3dTBIaEtMR3UwSGpmVnZUc0NTQ1YrQVRKa1ZOTGxW?=
 =?utf-8?B?QmFnWlZuM00zS1k4akRtRVZQZHdLUXhNblA4TU44YmQraFQ1VXB1RDhQRkw3?=
 =?utf-8?B?bmYzWnRoVXNVWWRTa1kvOWhmUEpIUStaU1pYQ2pQZ1duNGEwM08zaGNoVUt4?=
 =?utf-8?B?R3dLVE9KQ1lJclUrYlZDRFpCSWJRMGlKeFBJUkhrRTJIMjBxTUtyNllPWjdn?=
 =?utf-8?B?QkNFRXdwN253eHlyWUFuRGNZZVdET3ludy9qUityYzBLVUxCdVd5cWlBT2hZ?=
 =?utf-8?B?UllFSy8zSmllZ0dBTlNwdXBUQXZRNCtMT0dFM3BuQ0hBL2N0U1lWVW50MWdp?=
 =?utf-8?B?WFlkWkdXLzljU3AvdGVEbXNVRElXb0FXUG5obTcxaU9OdDJZTjZuUGFjSVNo?=
 =?utf-8?B?enpBK2crSmRMcVB0ckhZRmJ4Y0R6b2J2Mjl0eHFtN3JBdktiMVhHK21HckhL?=
 =?utf-8?B?YlppcDRjeTJyM3k2V0xCT3MzdUhxTnE4SmZNaVV5M1g3V2VPWk9yRTlFOTAr?=
 =?utf-8?B?RURwY0pibnl5SFVSL2dpc1lXZTVCbklndWQxRkY5cDZQYTByNk1Uc3JUYTg1?=
 =?utf-8?B?eGtMV0M5YWcrdE5rZXk4WjdkYTRzbExyVkxUemZRV2RHZlRBTmFJNTFKc0Ni?=
 =?utf-8?B?emkyYUQ0bUNTV2dpcG1ZYXNBVi9tMnhKUDJIVWpXZXp1eW9aMW5vRnJsd1BM?=
 =?utf-8?B?Y21hVk5haEtGdnhFU29KVlMrYS9WdU9IUmVocGQzbFVZN1J2V3FsMTRrV1B3?=
 =?utf-8?B?bi9waFc0dGdVVlVOb0kzanZVT2V4ZU1NYkl6MjU2MlFVNE9qb2JHL2tiM1Vh?=
 =?utf-8?B?b2I1TVArQ1h0cnpqeHNmRGxIUWJtUVlJQk94SkZnSyt3ZDBYVjkrZGJJc2F3?=
 =?utf-8?B?bEpaOG1rVzliM3k1OVBqTnc3QkdIZ2VNVHF4OGVvakFYZzU4OHNkclZ2STZJ?=
 =?utf-8?B?NzlJMzk0Z0IrNjdSRlZ6cUhhYTRPSmlwWGZad2gwZ3R2NHphNlVsV3BIeHVH?=
 =?utf-8?B?YjF3VGRmREdUbDNQeXJMYUh4WE9NbHA4N3JFNjZ3YWFIVEFTVnhrendQek5F?=
 =?utf-8?B?ckRabEQvaGhnSXlPcmU2SFZVOExLbkI1VktGUHNWb25tajhaV0VZcW9TcDh4?=
 =?utf-8?B?YzF3UW1FR2Jlb1JDSE9CU1ZLSHk0OXQ1QTI3bGtRWUd3TVk5UW9hb1R4VFNC?=
 =?utf-8?B?MHZPTHNRUXlzSUZHZHQ0UmdhcEdHSXUwWVVmL2o1U2lRdFRybDViNDVuR3Ex?=
 =?utf-8?B?ckpOQjdKMW1XYTEwWW9pSm5Ia0kxRWZGRTFvakpiSzRhTW0yQk5hYVdCazEz?=
 =?utf-8?B?OGZXTkNGODQvYWV2S3EyWnI3bFE5WjhzM2dlSUZhUWUzcEFSN1FScjdMNlZo?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d3b90a-ebca-416d-3544-08dc9f7601fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:47:16.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zb+bFdBghhWEIjw34YTbIzkQjKTqG6IT4ZQU0tuULqCn30h3p492NDhYsMO1u5kecHB9gDPo727vTX4Tv1IpVIdIgURDuubN0y5V66H/CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com

Hi James,

On 7/4/24 9:40 AM, James Morse wrote:
> Hi Reinette,
> 
> On 28/06/2024 17:54, Reinette Chatre wrote:
>> On 6/14/24 8:00 AM, James Morse wrote:
>>> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
>>> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
>>> depend on this.
>>>
>>> Adding an include of asm/resctrl.h to linux/resctrl.h allows some
>>> of the files to switch over to using this header instead.
> 
> 
>>> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
>>> new file mode 100644
>>> index 000000000000..a5fbda54d32f
>>> --- /dev/null
>>> +++ b/fs/resctrl/Kconfig
>>> @@ -0,0 +1,36 @@
>>> +config RESCTRL_FS
>>> +    bool "CPU Resource Control Filesystem (resctrl)"
>>> +    depends on ARCH_HAS_CPU_RESCTRL
>>> +    select KERNFS
>>> +    select PROC_CPU_RESCTRL if PROC_FS
>>> +    help
>>> +      Some architectures provide hardware facilities to group tasks and
>>> +      monitor and control their usage of memory system resources such as
>>> +      caches and memory bandwidth.  Examples of such facilities include
>>> +      Intel's Resource Director Technology (Intel(R) RDT) and AMD's
>>> +      Platform Quality of Service (AMD QoS).
>>> +
>>> +      If your system has the necessary support and you want to be able to
>>> +      assign tasks to groups and manipulate the associated resource
>>> +      monitors and controls from userspace, say Y here to get a mountable
>>> +      'resctrl' filesystem that lets you do just that.
>>> +
>>> +      If nothing mounts or prods the 'resctrl' filesystem, resource
>>> +      controls and monitors are left in a quiescent, permissive state.
>>> +
>>> +      If unsure, it is safe to say N.
>>> +
>>
>> Will user ever get opportunity to say "Y" or "N"?
>> It looks to me that
>> RESCTRL_FS will be "forced" on user as it is selected by the arch specific
>> config X86_CPU_RESCTRL and be invisble otherwise because of the dependency
>> on ARCH_HAS_CPU_RESCTRL.
> 
> I did it like this so that this change is invisible for x86 config files on the principle
> of 'least noise'. Users can't enable RDT but disable resctrl today.
> It isn't actually possible to enable RDT and disable resctrl until after the code has been
> split from the architecture code.
> 
> I have ended up supporting this for MPAM - you can enable the architecture's MPAM code and
> the driver, but not resctrl. This will eventually be for in-kernel users of resources that
> resctrl doesn't understand.
> 
> 
>> The text about when to select "Y" or "N" thus does
>> not look practical to me and it may be helpful to instead provide
>> information about when it is selected? I do not know the customs for this
>> text and if it is intended to document any future usages also.
> 
> I think Dave wrote this text because its traditional for Kconfig options to say this.
> 
> Describing when it is selected gets messy as this varies by architecture, and Kconfig can
> already tell you this:
> | Selected by [y]:
> │   - X86_CPU_RESCTRL [=y] && X86 [=y] && (CPU_SUP_INTEL [=y] || CPU_SUP_AMD [=y]) &&
> MISC_FILESYSTEMS [=y]

Right.

> 
> I don't think it makes sense for resctrl to be enabled/disabled independently on x86.

I was not asking for resctrl to be enabled/disabled independently on x86. I commented on this
patch that adds text to guide user for options that the user is never able to select.

> If you want to support this, we need a few more IS_ENABLED() checks and stubs to make it

I did not intend to suggest this at all.

> build. The only reason I can see to do it is to ensure the architecture code is self
> contained.
> 
> I'll reword this as "On architectures where this can be disabled independently, it is safe
> to say N".

ok

Reinette

