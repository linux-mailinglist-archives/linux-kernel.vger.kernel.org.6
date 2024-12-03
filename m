Return-Path: <linux-kernel+bounces-428723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E76C9E1290
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2EBEB22062
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369A15B12F;
	Tue,  3 Dec 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tzjp+OTM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AD17C68
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201659; cv=fail; b=iwPB/I9p8NK6H+2s1dlI+dcWewxYWgEXuLIVTwvzjoxRt20J55ShfoMO+VpJJug7bcf8Q/ix9RouhhHR1FD29qgNANaGxDYMQGMd6SLetAkDVTSSU1Bq3wMddyDxmJmsg6BCVBEjmF0+ePfnj5nG2LO+VuSKEQNuESRFQ9aEmgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201659; c=relaxed/simple;
	bh=1UhSXSZsnXb11SkWDf3WcENbeeP6KQljGsE1O7Fs/3I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pg9rtSfldR9opDhUW6BDZJMwtogjvMYcwuYqyJ8k3Dgdbd8pxXzSBWynoJ+er2pkDjQ5PBeYrq5Uf1rRCCcFACiD0HVmhXiZH0FyOxNbceQtdUY1qvvdk/P1B1Cue/J+xd+ZuxViQTuHvC2NSC3eknHiyfJm3kWRR8lH1B+yDZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tzjp+OTM; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733201658; x=1764737658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1UhSXSZsnXb11SkWDf3WcENbeeP6KQljGsE1O7Fs/3I=;
  b=Tzjp+OTMgmdSoXLQ3bFYsuhY2/QUJY1ZzkaqGecruj7xF1UNxm4gVkTn
   8voeT5FX/OAGEkNED8mbsGaCb8GqYZPlqMsOI5rAsKuv6l26IU2luAl5Q
   XitBv3OicjmVZ8qe520XHWQ/IQ4F29JE7V8tZNvZEJUSeW/I50EAC7E7j
   k1MsKfsli8NATyIg/m+0YMWcTqEytbIGOZa9Mjkpgl1ZSiuYs5pxoWrVC
   SGFf+rFqntKRx+n1CmM0X2WUMRsmne/cDZAyHTE7YlqvAN5eKHP8HSVpA
   b3SqaSUfYKdG/GzwHq0MndyOozX7hrT2iimQ7pJRc7q/dXZJFJhA0gvZF
   g==;
X-CSE-ConnectionGUID: VGs/YfKzTvOfqbcqHsMgXA==
X-CSE-MsgGUID: wAjpjWEuTLil3PvDy4C47g==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33455627"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33455627"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:54:17 -0800
X-CSE-ConnectionGUID: EKpZiZzARaCdAaiigvf3fg==
X-CSE-MsgGUID: XIOkbj7bRECZUJsD58fCxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="92980198"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 20:54:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 20:54:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 20:54:16 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 20:54:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeOYdlv/QQmNK7UfLmirAVIb9GSyrbDN0Aq3fc02gkD4kngmTz2uAVOJxyq0VSWSFhce1pPHRiZ/i25BWSd4lUlwlq4HWtWjHh+F4NYf+u7RYHTyBfuAkfIyJr7wcVBUxRPxwYwk0ZzwOhLTdN0Cp8U6lQMOfVR2iuSuIa4G4AE+FWf+0tJBAWr64HXQImYqc/GUbL+SlDy6MHWSgigDufQvh8ugia53kDA+WwIIeAoEIzmSF2RcrpYx1Aki0vIdS8lKuLUH/zUxGUlrCFtAReZ50LTmORz59Ou8AHftQPAenOa+hlYd/lNB0LkYZwdpypBR3BoezTtf8mrZrrNMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFNlS3gJVczjfl+uCEcVgx+Wm6AOFqNSzrLwy1v6cW8=;
 b=rsrH4/MDDlG4hZdWWHenQf9niSoO+yOd3pxCdFJ0wZMPti8INRI279kDUpHuHT7xxp3vqN56dUGHHrnS2/YJwgAtAQSkPkCzzEuQuBFp3trBHsMqE4d+d5YMWPO9g79PVuNGyXlY2CoA3G5cxYY8skXef7EWs5w4Z1glJmLrMcthR+8/Pn2EbG4u/JyHQMbGYUxLKFmX5ZRdiFCfZBBIJQcPPiVyLGng/cn0yrKvoiHVNFKFKMB5MO87B7BZiyhtRy6u2aOSZzeFQOacPRphel+9l0xV7Oynj4EnGAEcFnjPEqE+7PcAsXVTINTGKlExZJNLi4ZPE8AOIYgDeNFTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 04:54:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:54:13 +0000
Message-ID: <e1dc44c7-94e4-4055-84d3-8fdd5c22d161@intel.com>
Date: Mon, 2 Dec 2024 20:54:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl mount fail on v6.13-rc1
To: "Luck, Tony" <tony.luck@intel.com>, Ming Lei <ming.lei@redhat.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z05xSqIeNeHh19MZ@agluck-desk3>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z05xSqIeNeHh19MZ@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bf4c44-6fce-49b5-1685-08dd13568831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk5IT2tMZWtiQWZTN0JvSGpLcXl1bzI1UGwyZnBuRHRxek5SSWE5SkRJcWw1?=
 =?utf-8?B?TXZFRU1KdCt4ZDdrdjhxT25wb2NkeUt0VGVNcVpkQ0xjcjMvbFVMY3BTdEZO?=
 =?utf-8?B?YVZGV2I3K3RGUjRGanZ6OCtTU09pbUhud05FUWxzOWV1M1ozVUJuZ1F5LzR2?=
 =?utf-8?B?VG5nQlo2WWdzMlVWd2k4cldwQWFvUGM1YlI1TEFDMnMvWEQ4ZHVSSkorekVt?=
 =?utf-8?B?cC91SE9TWDNMZldmdWpKY3NrRVVWbHk5a2VRYnJYdlRZNHBnMktYNXhzOCtE?=
 =?utf-8?B?QkdpNE5nL2Y0cDA4RlpNcGNtZVFZVWptdzFXZXIzblRNZk9naEZodi9kcnBV?=
 =?utf-8?B?ajBKem9lSEtrUHFRS2U0bzFQaFNPZHI4bEJDVG94SG1ESFBKa2hEdmcxOEJX?=
 =?utf-8?B?VVFrTVA0NmpsVUJXbEUvamc1YXM1SXhVMmxST082S3p0WGg0TXA2WTc2MjBl?=
 =?utf-8?B?Z05tMkxqVjJpNVJlOW9qZHRiTWZSemV6L1dlR0hpWlZUVkE0YklDTWhaMXM1?=
 =?utf-8?B?YXJkZjVkWDhhUDJDTXpZTlNCZnNOeEpvR3p1djduSnNkRHJ3UENyR2k4MzZK?=
 =?utf-8?B?TlNKRXRrNGRBNGxlcVF5VmZhcCtwWUZvdDRCMlhOLzhUK3MzR0g5aFlEcGtU?=
 =?utf-8?B?SmlxUU14aGVTRTIrOUh0QVVhWUh1U1hjK0JuWXloWWZCbUhxc05KT3N5WkRt?=
 =?utf-8?B?WTh2WGo5VDhtQTJjRkNCZkx5cFVNUGg5T0FaUFVCZTFVSTVrYk5Kc3h4V0Za?=
 =?utf-8?B?MXllc1U1Znk2T2w4cXJrSEF4Wm44UVBnTHFGeTU4eDNuc0FDQURmYVhGenpS?=
 =?utf-8?B?NVUzMUJHOTVMUkRDTUxMNVdxYUpSWHZZZVdndXM0SDJKeWhlV00vV2VBcXo2?=
 =?utf-8?B?eFA4NnZZSmlCRFlzc0FmVDUvTzN5MFl1UFN5YTVPclQ4VDhaSUlNbmRGemEx?=
 =?utf-8?B?bi90eXFQY0NSRUZiVURiQ0x1WmtUUTcvYVFacGxXM3NQcjNKbW95QmhLZ2Rh?=
 =?utf-8?B?TEFuQlY0WDNJOWsrM0o4RGtmZ2V0QzZ5OHNoampjWGhNYk1vQVhuNENvZTh4?=
 =?utf-8?B?ZUd5dFFuT0YvQVFiWXdNdCt1cWticFdJQkFOcmhXbStaUGZrMG9EMmt4d1BS?=
 =?utf-8?B?Vmh2VG42ZUZaUmdzMDEwU0puZFB3QUZ3SWhqSUp6ZGsveEZrajh4V0EwdXE5?=
 =?utf-8?B?RXE2QWZZU1Q0Z0MxT2F2VytaZVBxYnRaMjFkQVlaeUxZM0o1RnN1RmU4ZHl1?=
 =?utf-8?B?WnRURW9sdGZpbFpDK29IRlcwMzhiWTJvSUpPWStpZEhuZlpwTlQ0Y2h3NTVF?=
 =?utf-8?B?bXhIMDVCdWp0eEFJNHdpd0dWWll5RUg1UVdJV2ZhL3hkc0h4TU8yRnJESkZx?=
 =?utf-8?B?ZHdNTGxCanVRdUw3VW42SXQ5M2ZOV2F4VDE1UjEvV3hrWk1WV0VCODdadjFq?=
 =?utf-8?B?U0NpN2VyVS9lTk1CSTNGeVZDaGQzQWExUDgxWFpwK05aM1dqVUdFN3p2OFNr?=
 =?utf-8?B?Qld1cW8rNGxJSnp3QWtnUjZmQXBWK3NaS3JkK3NsalFvUWFRVitrMVhvZTNC?=
 =?utf-8?B?eDJxcEpZWCtpUCtFYlNpNVpqZlNFVE1mSGVmMjE3d2tCUjY4Z2ZLZFl4cis4?=
 =?utf-8?B?Vnc2SGJxMzRyOUJrdDlhZkpER3RwbThjcnZta0F2bmxCa0NMbFlxYVdtSDhH?=
 =?utf-8?B?OHF4c0d5YThaaHlxdnU2VVFXVmpWb09CQk51MFc2R09zVmRsb3VmNG55NEov?=
 =?utf-8?B?UVVVZndLSW53RmF0cVd4VzBwcmFyc1poTGx1dlBVWlVSMmpkNEYrWHNxQVc3?=
 =?utf-8?B?cndvMHBwOWJqTnFaOGV6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djB4d1E1c0wxRlJSdlRYTldmbkl3OUJua3U5djM2dGo4Nkt0NEt2LzNWck9p?=
 =?utf-8?B?WWNCSG1rczZTZHhVZ1dwc3JEeEl5ZmRIQm5ESWxuQjBNY2RidllaYkp2ZWNy?=
 =?utf-8?B?WUp0RHNaKzZPOGRnNmliT0RFQmxUeFZHTFhDQy9IRnk0TW5meEFaWTVUeVB1?=
 =?utf-8?B?SEpHWTl0ZXBFaUc1eFl0OUZLMmFXWWNGV1AzVm5GTU5OMDFaM0RZdEM3UTNC?=
 =?utf-8?B?Z2NSZnp1RklYdjQ4ZFBhU09nRWc0SXF1VUJPWWhlVW91WGlTUndLYUNlbGhx?=
 =?utf-8?B?d1d0eGpGRnhFU0dCRy9WZzZ4bGJrMEtuNzYrbXgwOGhSSUVHT09BRlRjcEhw?=
 =?utf-8?B?aGl4TUVrRzE0Um9obXlJSnpCSG4rdHo5RXNrVnQyaG1JR1FLamZRdThDN3dO?=
 =?utf-8?B?SFVFd1lSOXNvQThNWWJuSnBWbGtGdlNJdmtZSHNuUnl1TVVaOHFsZDVmeDh5?=
 =?utf-8?B?KzQxY0lEc0VxZUUyRGVuQVNmaUNYeWswSURwMEJGWGtEN0hZekxMZTdURmhq?=
 =?utf-8?B?NU90cERid2hWUjFhTXR3UGhVb3I5UUFOdlA3MTJDNWE2ZnFxSWdWa3YxSWJR?=
 =?utf-8?B?d2I5SnQzdmpOMzNXaGppVVVxSGJRb3hrRkQ4V2tGNVlhUTBHWDdSdHZJZEhG?=
 =?utf-8?B?enY1WnUzYmM1QUg2aU85aWF3MjBjaExzdWFuajd0dHI5Q0JuNVJGUTEvdTQr?=
 =?utf-8?B?WkRENkp2SkJyd1Zhd04rWnFvdGwrZTZTMlpwVDArUndHVFpVN1RZb0pRR2dE?=
 =?utf-8?B?Si9rMStuQ2dhMit2aCt2TDZEcm42eUN6WDd1KzdrNVJTZ2tNQ0YxVkJIZVRE?=
 =?utf-8?B?bUwzaDhaN05hbjNvRmFNdG42NzZIU1BJbUIwWWlPeS9ZSkJrRUZEaFpaOVFs?=
 =?utf-8?B?OWhrMElFUHRDZytaK3JSalVKRWZxcDNPOUhmMkpTaGFNNkV3bk5rWnJIakJ5?=
 =?utf-8?B?TktnSVZBWTVYSWNmb2JhTHhCT2ZpQm5RbWpWOEQ4L2lYS0ZodVM4MCt4SWRR?=
 =?utf-8?B?S3ZlMTdHVVFGdHdDdjBERUZmdHJoRERRelZER1hRZFdCTmdJaGlJZ2R6dFgx?=
 =?utf-8?B?d2ovWEZzY0ZoTC84cThSVTVlbXhJckpwSjJiekkzcWdPdzBhb2M0SXEyTU92?=
 =?utf-8?B?cFRhYkVvNkltRGZlRW1Pdk1SWmpGM1lBbGNIY1hpZk9XdkdsdGNZQlRMQjBa?=
 =?utf-8?B?WUh5eU5PTlpScGF1SmJqbHJkeSs0d3hmMk9CSUNzYVo0SUxOc2VnZVRVeU40?=
 =?utf-8?B?MG9TZkxVTWxRN3ZVL0pCOGk5RUxEZWJPN2VFTGVYdFhudTBibndPdjE1dmcz?=
 =?utf-8?B?enJ2ZlhtaFlJdHduaTdWOExpRlVxaGUwb3N6KytTTGRDZmdnaUNvVjBOeGhI?=
 =?utf-8?B?aEpsN1E2SVdyTFBlODd0d2JoOFdqTnJYMkhCWUZUS3RvRjV3dURsdHhuakxs?=
 =?utf-8?B?VHZRa1lNYnJYYjY2TXNlWW1JQnk3ZTNUdTJXUTZwaDZWSk82WFBoZmY4WFhI?=
 =?utf-8?B?K29YUnpPdHhnb0RhbjJ0enZvODRFK1k1TEJpNkt6cEpDMm5wNEZKWjRwczFy?=
 =?utf-8?B?bTkydVBtSHBXMjhaY3NWZVowV2oyMStIMlBSMmJBTHJrVC9UdWdVbUxkdWg4?=
 =?utf-8?B?NEFHeks4c1A5RDNrRXhLN3BKZkdrREhIVXdDeDFTUExSY1M2YW5BVmUyRm8x?=
 =?utf-8?B?SWxkQnhYNU5NUk95WjhGc05TQW40SG1oVHlFYkIrVDRQRW1DOFo4end4NUZo?=
 =?utf-8?B?aUpVRXVZUzlRSlZEb0hhcXJhYVRhL3oxMzJ1VDNYbk5OTGlwWjYwOExqZFRt?=
 =?utf-8?B?emE2MmJHWkZzUG5CK0E2T05NaHJXeitzSkpHdTQwQlIvUmc2dDgza0xMQjkx?=
 =?utf-8?B?Kzh0SmxDY2M0N3RHbHF3L0tGNUdKWEFwRWZMVU1vYWVJVnV0cWxKaWIwZTFI?=
 =?utf-8?B?OGJ1dTRyUVRJeGZuQ3lxZmt2QUFja2M2SytYMERwWk1RSXovMWFzU0ZWdHM0?=
 =?utf-8?B?S083NE9tcTAya1BXRWVITWpsaEhnZ1dKOGxFbWFCQ3JSYlAwRUpSeHZxOTF3?=
 =?utf-8?B?MTFHWXgrTTUxV3lYMXlHVG9LVGJuNHRmV1JoMGVCeSsrVGhnK1MwTUhBMU9E?=
 =?utf-8?B?TEZ0eklZUGpzLytMUlZaYzFEMHhRT2d4dzZJb016SWZpTjN2bGI0aVdIVmo3?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bf4c44-6fce-49b5-1685-08dd13568831
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 04:54:13.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLUbiqoTMfOzzOs+HlvqvzqdpMROHBLhVfe2Eg9/17yC6sgUJ6B8wF3YH7ol46cQSQlwc7IgIdBjioTvCySQadGuUMxbNUKxdzKmUkzLP4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com



On 12/2/24 6:47 PM, Luck, Tony wrote:
> On Mon, Dec 02, 2024 at 02:26:48PM -0800, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 12/2/24 1:42 PM, Luck, Tony wrote:
>>> Anyone better a decoding lockdep dumps then me make sense of this?
>>>
>>> All I did was build v6.13-rc1 with (among others)
>>>
>>> CONFIG_PROVE_LOCKING=y
>>> CONFIG_PROVE_RAW_LOCK_NESTING=y
>>> CONFIG_PROVE_RCU=y
>>>
>>> and then mount the resctrl filesystem:
>>>
>>> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
>>>
>>> There are only trivial changes to the resctrl code between
>>> v6.12 (which works) and v6.13-rc1:
>>>
>>> $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
>>> 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
>>> 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
>>>
>>> So something in kernfs? Or the way resctrl uses kernfs?
>>
>> I am not seeing this but that may be because I am not testing with
>> selinux enabled. My test kernel has:
>> # CONFIG_SECURITY_SELINUX is not set
>>
>> I am also not running with any btrfs filesystems. 
>>
>> Is this your usual setup in which you are seeing this the first time? Is it
>> perhaps possible for you to bisect?
> 
> Bisection says:
> 
> $ git bisect bad
> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Fri Oct 25 08:37:20 2024 +0800
> 
>     block: model freeze & enter queue as lock for supporting lockdep
> 

Thank you very much Tony. Since you did not respond to the question about
bisect I assumed that you would not do it. I ended up duplicating the bisect
effort after getting an environment in which I can reproduce the issue. Doing so
I am able to confirm the commit pointed to by bisect. 
The commit cannot be reverted cleanly so I could not test v6.13-rc1 with it
reverted.

Ming Lei: I'd be happy to help with testing if you do not have hardware with
which you can reproduce the issue.

Reinette



