Return-Path: <linux-kernel+bounces-330941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E07D97A649
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681541F22B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF9415B13C;
	Mon, 16 Sep 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DejbZh2S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4110A18
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505770; cv=fail; b=aFljmNsU1UnjzOg305b2qWdTuoFvQ6Ucq7H5zFIWK51eLp3Pqihf3Sllx09FzdG1a4yuGWBbOv149Qu/u5kRye7xolsU7SvSVK9TosPJjgfDajBRnaPHDh4EbNs9AZGe5AET3oKe0d/kKpvH/FqNNqvb1NI75G6XHWhdCtIVkNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505770; c=relaxed/simple;
	bh=t4Q6dw5TeY2tfOZeSEjMLNTQqTva3ZR4Cf/7T/k8R6o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kDvN8Mk4AVZstovDza/AxUltn5Hd29k0ZhEiI9SrScMydeQEheJtiw6D+MesgNHlJNkmLUsFNCuB3bECMS87290wAd8xSik/SURvqwxgPBCjvAeTFiWrcVaMW22QI2a0n4dyKcvsC53+aq53lBksT4RzW9C/IvMgCoMQVY3zjQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DejbZh2S; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726505768; x=1758041768;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=t4Q6dw5TeY2tfOZeSEjMLNTQqTva3ZR4Cf/7T/k8R6o=;
  b=DejbZh2Sb24e5RIAzYAdMvgECI7F3XPduKL2mQkdvkcUWBgczNdWf+/h
   Myzu4ii57YGFTY2yunpKGEKHT5oLg9e+CpszdfpX/Ggf864SSSCQLCS6k
   1z4R4qoBDShGr54VriCmW82HbR3wgMt9dw8UmYdSmPc3fQlnJtS/m3Gm/
   fyCYr+8coeE122zvlXeFO2EkQvbO3sYxUlx+v9/48Vymna/ffuQC9lyNT
   0q2ol3UQiFRJNIzU9qp/W2Zu4Ezi7uj/ODx6uhOalohigqxCXDXGP2GKD
   nbB8cshNTeix3k68sBLnnwUN1saQvA8GH4E/+rLUWk899IQEqjOjx9Yo1
   Q==;
X-CSE-ConnectionGUID: JvsaAziFRMCbcpj1bYfhFA==
X-CSE-MsgGUID: gxlJEWgQTyOGUP8sm4eB/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="35920383"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="35920383"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 09:56:07 -0700
X-CSE-ConnectionGUID: 2z9ivqtGTjKP+CkLBgjmfw==
X-CSE-MsgGUID: KVmyOBhuSsm6SkVCpl9t1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68796214"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 09:56:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:56:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 09:56:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 09:56:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 09:56:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVng7akfDq+mRNga4fd6nGgBag2jHFJUylLB1/QDwGJiS4booVNOO9m9Vdj3VepktTjqbSbFFNhoMCXLtafRn+KmYjY6MMnh2nzd1/cJQ8poF0myc/xBuarD8Djz3vKc4BhwZYWHEX4G1No1Nll0/ZQj2+JwPrWnLdkltwvtxRD3M2R3VibclFf1IggUKpyv92gy1aKZS5RpFTGlgVS5ZEKwzlptvg4TCulQX9PbsicxxmXT5J19Z5GRpxfzUQ3/q24w5tQrm3HTKPxj55ng7SLVtTTFQEwIMXk/SmGCiNBf3eUYzwVwBDaq+c5sVymUfU80NzNYOdn/aLuXtxFgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVLalM2bRkNy3HvZcqHfAznXj31EyBYIGBfSdqI8/vI=;
 b=CuojH5QSuUt9zJyjDeXswPX2OAwYDGXSwZUQ30cnMoztyU8P1L36wS45tA/TW1ZsuxGN/LW2NzTyfeRqf6DkzmDOGYzUq/ggCGtHCytQGnVVd4yT8V6EzOCAXmWjwVbNTtmI/uAnOoLVoqIb/qWfT8qL7swgJbB9rtnrRcP+mjpWroLw9NtPkJ/s8tHQ+C8aHuWsxLJIR5/5Y6UKVrWuRGPCwabHMmtHyN2S+tah1w2J8NjZZejZ6pQRt4Vwm7zUC3YtgegeGBP6Hywwd/nXNd6PSUMCqf9PzW7PNUvnNGKr6IlWC0wT1kiVq432A0kQupZkwSbpsAM3dYb67iyojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB8246.namprd11.prod.outlook.com (2603:10b6:208:445::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:56:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 16:56:03 +0000
Message-ID: <abffe9bc-4c2b-4d44-b521-f138179033e3@intel.com>
Date: Mon, 16 Sep 2024 09:56:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
To: Martin Kletzander <nert.pinx@gmail.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 951956e8-aab5-4bac-efe3-08dcd670732b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjZ3ZWZTZWtFWWJDRFFxbFJTb3lEREtQMHp5SU1BMXJxVmJrVGpHUVVsYmkv?=
 =?utf-8?B?VWhDS3J0YXpwUUlDTWZONmZYdjBsdHExMzliUDBkKzI5Ni95QnRJUmN1VzBQ?=
 =?utf-8?B?d3hSejljWTkrRnFOZjZEN0FkQ3Y0eFJ6enhXbi9sbTVuN202R2JGUHFqZW12?=
 =?utf-8?B?dFpVM3ZTVWt4ZzlRTlpnRTBRaW40NW00cnV6cCtHeWttMjBydWsrT0tJSExR?=
 =?utf-8?B?Z3lIS01rREVCMHVRdW15aHpIVkxPWlJqMWVpZUZ3RlZEU2wxV0xRTWdwdWph?=
 =?utf-8?B?Y3NOM1JQWTNoRjhONTlBMXRURTNPY0xnbGVwckw3cVpTYXVJcTlmc0E4TkhI?=
 =?utf-8?B?WURqN2paSG81MjY5ODYzRURSNVdaWFl2cW41TVU4TDY1bGFoMVZnYUNCV1Vh?=
 =?utf-8?B?VVdNVktPSlIxNlBuZzI3anhBeGIzLzJ6Qkx4bCs0L1F2SUZ2d1R5WGd5VWZV?=
 =?utf-8?B?MGNXY0lJNnpJdDBwenlSM29xenc3RndBaDBtaG5QV3ZXZ09RaTZUZkhhNTdi?=
 =?utf-8?B?QlBRTmlZYVNNLzdqRHdPNTFLRlRKdW9oSVAyZzFjVnI2Rlh1QlhLYnFob2xT?=
 =?utf-8?B?NHIxTkp1SmUxNnViNnRUaGtoU1NRc0NYbmRnT2VzbFlzd2Jla3pjQXEvNkxV?=
 =?utf-8?B?eDZva3VvOWtxSEFJV3NWZ2V4RGkxdCtmNGM2MjBaMmJrMzNTaittTll5RGhm?=
 =?utf-8?B?RTJieWxCdjlVckN0TDBKVVNyc1o3UFdjeEdHVFdkWHZGMXpBUU1FVHVadmsv?=
 =?utf-8?B?QndWZTRsZkx4TitxOGkyTnNIMjR2UjJsb2FaRkJ6VHdWeENNOWRzU1VJNHNB?=
 =?utf-8?B?TXBWbEtwMm1jTmF6b2M2bzI3QUZPMjV5Z2FJWkEwU1pUeHM3cHdwVHY3YUxI?=
 =?utf-8?B?V2Jlb0NpTU5CQlFpTWp6b3NETkRUMlNhMXhlWEJKdTVkNGMzMkZsQmdaaGpI?=
 =?utf-8?B?RnN3ZFhTd3I1VUJoMlI4aHdpNXQ1U2dMNXhUOHZ4eTRkQWpZNEdhSER3YnU1?=
 =?utf-8?B?ZWtINWpNbmxBYnorVG95YkNPL2xHZzZlN1hnQjdnYnh2YUxyQi9ISEQ3d2lS?=
 =?utf-8?B?cjZhekpHZ2VMQWNXWlhOcExFbDdNeC9FTVBhbmN5aEtYMktsUnM2NW5HQmVP?=
 =?utf-8?B?TmpubkhlVTV0RXFVQWcxUDhDa3B6Z29BL1RsNFM1cVhzSkJJM2RBelY4U25Q?=
 =?utf-8?B?S3dwL0UzWUtxaXMyalN0Tmp6OW52aG94bnM4Rm9SbnFjNVFxamRLQ2RDUGxM?=
 =?utf-8?B?WHhydHFQTENxU2VRWVZHT3ZHbWxWeVMvaEw2SHdLUHlvRU9vemZrMzdzZmlv?=
 =?utf-8?B?RldPdVcvTk1ZeGNMY0hRMkpMTjZLMHB2VkduTXRHK1FLV2R1UVdheGVzTUJW?=
 =?utf-8?B?bHpLSUhza3BaTEM3MzlJcDROQmlEa0FFUE5FdGZVRVZHM2xmTjB3cEdHMCta?=
 =?utf-8?B?K2JsMkZsNHhRdTZhYXAvV1o2dCtWTzEweWNJWVVIUkkzejhxU1o3V21qbXQ1?=
 =?utf-8?B?Wk1jb2pwd0g0MXp4VzJVajZkeitGejRKc2FSZnVzN2xicHFNMllyOWhLaVJE?=
 =?utf-8?B?bGJqcHlVSTkvNWlkdFNkbUNRMmZhVk5WcWtpcWNadkdjZ3cwcWpEYnY2TVBB?=
 =?utf-8?B?QnFWV21Ib1FNVnduS2pUQ3ZDV0VRRFJuQmt0bmVTMGU0cFMxME02NEszd3NR?=
 =?utf-8?B?V3I0OFAzcHAyQ1BCR2Z3ZVo3WWovRW9JWDg3UEpjeWdhY1pRTWpSUHNXYm1p?=
 =?utf-8?B?N0NjeDIwUTRrQVo3S1Vybkl2WEFCTXhOSkhpWlZYNWNlN0R1aDY1aTVGUWFD?=
 =?utf-8?B?d2R3aWYzeGdCdlVRSGtrQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHd0N05yckM0SGQ1OGh6bVdWbWJYUkE4RzdxNThWVHBIM0VIdFhtU2J1aUVP?=
 =?utf-8?B?UmZmelpQSmY4V3F5TVpFenJKYU50UnJUcWxMVW1iYTZXT0tTMjJlQUozWTBS?=
 =?utf-8?B?aGZKaXJkVnJUWHRKWUIvQ3dPSEZ2NFFwdXlrejhSNE1lMWJRMUZkTjBuWEFp?=
 =?utf-8?B?cURIZG1SMURjU3lPMTJZdGlEdlJ3UFZweTlxOVJXeWRqaW9TNzZKdWxMaU83?=
 =?utf-8?B?MUs2Uy9scWpIUk5QOWVwdWFCQWVkRHQzaUNXV1pCVnRPTFFBaFU1TVhOS2FS?=
 =?utf-8?B?RXJPeVAwVmlmWnpCT3czOVlXOU1EWUVzTXl0cGcvT0N0eGw4L0V5UzMxWVFC?=
 =?utf-8?B?ZGszcjZvQWNEWnFJU0JsRzUrMzE5REYydkpPUFRENGM3cHF4OWIxSDFtaTdV?=
 =?utf-8?B?R3VuSEdSV29nbm5lVnZqZDRick5LbDNRMi9Hc3hRaUh3bTNrUlIyUmlEd1dj?=
 =?utf-8?B?NFRxSWtROVdPVXdPNG5aVnNrZXo4MWNOK3NsTjIzRGJiL3FxWTZlMEJ5Qkdt?=
 =?utf-8?B?cHFjZXZlS2N3azdLRFpTYkE3ZE9oYWk1b0F2dlovbGhib3RBelg2N0g5bkdT?=
 =?utf-8?B?ckZSWFE1cFEwTHpqOWRMa1NMcDUwaU1KNWdOUlpDek9RMUgzakExcEtyeWkz?=
 =?utf-8?B?TFdBdTNxeE5OZkNDVi80eVZoNjF5dTVJRFg0Y3VRVXZ5KzdDd0VMaXIvR2pv?=
 =?utf-8?B?RjBPUkwwREFoZHRyeW8vYUpwL1RZVlgrUUpGcHlUL2RHZTlCQVNIM3JOeThH?=
 =?utf-8?B?MVdGbTZLbGVxNUpleEF6ZFJNRzNsNGQrZ01qSTVyV1FwQ3BXZTNzSFpENXd3?=
 =?utf-8?B?QnpmdVBXMmtRQ0lKMnlwVTNjdVB4TW5tYm9DaFVqS0FSeWJXUzArajgrNFhm?=
 =?utf-8?B?VzBtNENTT0xnemp3K0twdEQ5N2YzOXdBdTJIR0JCM3UzWUlNSXhNbWkxUFRO?=
 =?utf-8?B?VVNMclA4clI4cDBRWkRnb0R5THdpNFFQSDlQUHFVMExycEdzMmdCR2l0UTNv?=
 =?utf-8?B?OXhwUkI1K0NZNHNpUENxVkJWUnhGZjlFYmpqSi9NRkRsNUp6SmdoOGNCa3lF?=
 =?utf-8?B?NVJ3dkQ1WWl0c2hTUTFURnBzRkwvR01WU3JuVEZEZXhERHpQM0lSeSs2VVFP?=
 =?utf-8?B?a0J0cEhrVStFY04rNTZ3c084dnBiM1VoNXBpV3NjWk8zc3R1SEZWSEUwWlg3?=
 =?utf-8?B?UjlURDdkZkxHRXdjNElZaHlGa29qdE1IK1RZSktYTjYvZ2dXM0JpMnB2Nm1a?=
 =?utf-8?B?WWlIVVZDcmhpUHpYdjdWV0V0ZUF3Qm9QTzBFVTdnNFdOQm94UHVWNjU2ejBD?=
 =?utf-8?B?RnRRbmlHQ3ZaVCsvNGRRMXVQZVVkMk5YWjl3NHYyV1plbjhDcWtHOVZ4NUFq?=
 =?utf-8?B?aWVCTHoxM1FyRWV3WnU0eURORHNUL3pSQjhzNmJtV2RNZThMdlY4VmNNUGJY?=
 =?utf-8?B?RzZHUnQ4R0Q3ZVo4U3F1MzZUVU8zUVdGSURMWmpHV1NOeVNsTzJaTmRMcFYv?=
 =?utf-8?B?MDRnczhyVm9pcDVndjI1ZG90MjAyanEwaFBXcUhsZDRtSXIvVFlueDRGbm5s?=
 =?utf-8?B?cXhLaFRTQi8vd0swNzM3Uk8xR1U5aGtLMmpSWnRsY3h2OXFUQ3Rwd282VSty?=
 =?utf-8?B?VzNmb0FkMjJwbzhnbUlBMDVDVHJDREZVcXUvVUUwS3pGSSt2Z20yajljanZD?=
 =?utf-8?B?Vm9PRHV5ak5hODAyeUQ3M2pUcldaZ3F1Y1hNRHNVWWZjWkNvQ0VZMzA1bDM5?=
 =?utf-8?B?V2J2NTE2SjcxeE15RHB6ZllXV3ZhT0U0L1BEK2lJRFd4YmY0SHdJNlE0THc3?=
 =?utf-8?B?SGVLSmFNdU1DY3hRR2oxNTVCQU5pU09FVE9FSTNZU2hRZjA2YUlHbFZ3NktK?=
 =?utf-8?B?MkVjZGhGNzdqNy91T21JcXhwQU1FOGM3dXBvLzhaZ3JyYjVXdEU2Zklxb0x6?=
 =?utf-8?B?bnNwWTRqSnZkUm5FNXl1QktVZEsvbWxIdTgzdGdVK0dJbG1CQ0o4TDc4OGYr?=
 =?utf-8?B?ZlloOEpDcnp4T0c2UkcxV0djS2g5enhvLzZZdFMyeDljelFDVzhLdlFOYWNR?=
 =?utf-8?B?ck9UYlRITm8wVytsdzJ1V1FvQ3JQS2VKdTBwaUwvaG5sTExzL1JuQjVCNEda?=
 =?utf-8?B?MzJ3MitKYlk2UnBvT2Qrd0hHcG5SM0dyV3p6YUczNnNTUG5IbXBmWW15dFJu?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 951956e8-aab5-4bac-efe3-08dcd670732b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:56:03.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udd+1IUm7gq5GbYkduH9NCKiDO6qNCQkrP47pgcfZq+D1iTH790EkE7gjE9oqXqpaPbyzeMLcRnO4RGkHJENXXqYbAwcl4BgcW4lj+gWA3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8246
X-OriginatorOrg: intel.com

Hi Martin,

On 9/16/24 6:07 AM, Martin Kletzander wrote:
> When resctrl is mounted with the "mba_MBps" option the default (maximum)
> bandwidth is the maximum unsigned value for the type.  However when
> using the same value that already exists in the schemata file it is then
> rounded up to the bandwidth granularity and overflows to a small number
> instead, making it difficult to reset memory bandwidth allocation value
> back to its default.
> 
> Since the granularity and minimum bandwidth are not used when the
> software controller is used (resctrl is mounted with the "mba_MBps"),
> skip the rounding up as well and return early from bw_validate().

Thank you very much for finding the issue and proposing a fix.

> 
> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
> ---
> Changes in v2:
>   - actually save the value in the output parameter @data
> 
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..702b1a372e9c 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -48,8 +48,13 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>   		return false;
>   	}
>   
> -	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
> -	    !is_mba_sc(r)) {
> +	/* Nothing else to do if software controller is enabled */
> +	if (is_mba_sc(r)) {
> +		*data = bw;
> +		return true;

While this would fix the scenario tested I do not believe this fully addresses the
overflow issue. As I understand the test wrote U32_MAX to the schemata file,
which triggered the overflow because of the rounding and is fixed by this patch. Looks like,
after this patch, writing "U32_MAX + 1" will still trigger the overflow.

The overflow appears to result from some inconsistent type use and not using
appropriate parsing API that is able to detect overflow.

How about something like below:

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..53defc5a6784 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -29,10 +29,10 @@
   * hardware. The allocated bandwidth percentage is rounded to the next
   * control step available on the hardware.
   */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
  {
-	unsigned long bw;
  	int ret;
+	u32 bw;
  
  	/*
  	 * Only linear delay values is supported for current Intel SKUs.
@@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
  		return false;
  	}
  
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
  	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
  		return false;
  	}
  
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
  		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
  				    r->membw.min_bw, r->default_ctrl);
  		return false;
@@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
  	struct resctrl_staged_config *cfg;
  	u32 closid = data->rdtgrp->closid;
  	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
  
  	cfg = &d->staged_config[s->conf_type];
  	if (cfg->have_new_ctrl) {



> +	}
> +
> +	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
>   		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
>   				    r->membw.min_bw, r->default_ctrl);
>   		return false;

Reinette

