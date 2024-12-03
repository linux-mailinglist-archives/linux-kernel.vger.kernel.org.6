Return-Path: <linux-kernel+bounces-428672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D099E1205
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D418163E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4124154BE4;
	Tue,  3 Dec 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3Qi7ThT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE62AE68
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197770; cv=fail; b=Wrbpn14fkGkVc56bXzt0Fes9o+1hMOFB+s8/qGXzWWW3DfFBLZtZ+6M2ujelRth+OFDqhW7h4JLWmfFnaRJnW/XEXziwYA1mvnx/aUhxdSmHllzoQJFEqMw4uU+rG6b7Q8Z2cEfe3IzBnhH7OYRed2Jz0yMJhfRKAZXPsfnS2/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197770; c=relaxed/simple;
	bh=GGrB0LSibK2vUz8QMK0Ysn6iQAr/8Xwo0FNn6gxWVaE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQL7ZvInk6ldZxKgug4VOHWIuMcH/mE38jjoHckblyXOmzLb9MTuMIKNBPsOJh2hNSrMpKgrN2Qf0ZAO/h3jjDf9Ks2v85qU1atzLq3Jd6l8UXOiYq9TJyHZmmpNzByGRTO4U0TSHQmSZ0bXhAisSzGudPlZnJ3rntDMXQR7f98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3Qi7ThT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733197769; x=1764733769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GGrB0LSibK2vUz8QMK0Ysn6iQAr/8Xwo0FNn6gxWVaE=;
  b=W3Qi7ThToLAP1yuLdve4PhSOeDXPxPmrnG5a7ufmKAZoGrJD02igVsJC
   KhGztLPWOD+Zt9BK75IKtb7tYIG/TpneTBJuHyoOBvo/pGsKCqCt21nxx
   WjG7xr+CM7JaBX6vmLr3ttvLKAXq8LRApZv8FaS8HYAYfHQ1t/7csr9+f
   vG4x+fd6dIoIA548UOR7QC0sm8N1nhW9AnpnN1Bj1uf9AwJnz39401z4O
   /XS03hwyIpLAb/u06W+ebB/5jMGM0AWTzBWgZCHp40wtuyKka5/pz9N3b
   5gua7oFjJucXZqWYiOxTIvAe5UbuFxRYEM8JKJphoZmokm5xRzXxcVifr
   w==;
X-CSE-ConnectionGUID: sSw8bHVyTBGH+bDlPDde8w==
X-CSE-MsgGUID: oaaY0NPeTDektHxkk1y9jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44780647"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44780647"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 19:49:28 -0800
X-CSE-ConnectionGUID: bi+I/k1aTnSr9PuiRsHKNQ==
X-CSE-MsgGUID: rsiesQyQQkivteFg3/QCDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="98393837"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 19:49:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 19:49:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 19:49:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 19:49:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8mx2fF8ylMaHnR2+Fs/1vtS9WLltzEvSzLgBn+yxJRi+sdA4dYDfOZZXSHBtRjWj1qOX9PQJ2QAhEG+wN93SY3RPxJYVpWnkBSeLhg2Q3EYN96dyUKKNkSf4OxaSoVD129oBaqkNwzF/1/p9szuRzSWm/VtI0QufxHKtrg9FuHik/4c1I9hmEwUxnSYO4Pmh2GW3R/meji5kiVtMDfLdL3Cgg49Bpnc9AjKuePIYfT9jgsKtuo2W1TuHiWsNqguqkkFvvvACZ7q++H8lrTbP9tHAJshM1suWwhZY3nHsFrCMqPksNgx5L7P5ez8PGWj6XDnxxG9X1Ck6SFLA9i2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yULpd8DxPBbWwSUaqZo5Woq0Y9LrMZ642635ifrn4NI=;
 b=OK0FHrKnjwV5Br4SoVUSbD/7IXtcF3o/GPL2phqllclj6Mm+6k422SLPIbNhdRl0XwVjUYlAfC/si2lTnuVbTAwG4LAdns3y+nTPOjANCehUaJpdzl2prDx8uSgLmMLfrnxzFei3h5RAQabS139hjBfT1BnbHJ291VmiBPAtW3NVWGX3cJo8CJr+PfjUqSFMo0fbfCEidDhqVL+gJFg2CqgXFby8JxpyDFIc7yaKQTzgtl3q0zVYsxlA7M9RNVDlhN40okZBgWl8CRsbtXeR3c+miCYBNTX5fxWACwwq9oXfo35cro1zZ8yA3ImLo9XRMWSIF54StKMx0aMSVoPg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 03:49:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 03:49:24 +0000
Message-ID: <220a2fb4-26aa-4491-a58b-9a3e0b22353a@intel.com>
Date: Mon, 2 Dec 2024 19:49:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl mount fail on v6.13-rc1
To: Ming Lei <ming.lei@redhat.com>, "Luck, Tony" <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z05xSqIeNeHh19MZ@agluck-desk3> <Z058nbqa2S68-28e@fedora>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z058nbqa2S68-28e@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd6f967-d4ab-4520-6528-08dd134d7a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnhXc1pKREtjWElwQlpsSmlkR3hCWCtlOGZYL3I0VjVKQlNsN2FLeVdmTUl0?=
 =?utf-8?B?dzdnVzBML3ZEcFlGYnNhK3FCOUlVS01ZcTlkeTVEell0aWRJVWRjSzluaVI2?=
 =?utf-8?B?Q0R3eXJEVERqV0IxcjYrUUUvQzFBSGRHR1lsMnFCS0lsTVhEWVFPaytNbDdw?=
 =?utf-8?B?b1ZScG9YcFhCc0o0Y0hmNGVESU5FRzVvaTB0SnhYUVNoNGFjMlFTTS81OEV1?=
 =?utf-8?B?MzZyaVR6cXBQOTFMTmNvNXNRSzdlSHR3c1FjN3JFVVhOWG9hUm9sVUI4Mzkv?=
 =?utf-8?B?cncxTWI0MUNJSlB4bW9LY3BzTGFMNG1Ga0RjS2ROQ2MrRmIxMWJtU29UdXlu?=
 =?utf-8?B?R3lkVVNHU0dHQ0pZRllsdDkwMGRuMzJIU1hPYXVkMVVHd0VLMTMrNE4waGZI?=
 =?utf-8?B?SUYzcWRyeXZSbzVITkhMNGRxeG1jTDh1RUdtYi9ZakY0cFpBOXdkNzBXQkpD?=
 =?utf-8?B?SnZCaEJtWXowVmpZU1hYZHN3WURGOWVIcGVZdm5BWUNkZTJMM3ZMMTVSNmQy?=
 =?utf-8?B?YklXTGlhMy9RQ2lEWHFZVk1sbENYNEEzZEtQazVlSkNNck1QdmUrN0tRSldt?=
 =?utf-8?B?QlJBRFFLRTU5bWlUc2p3SGMxaTlqdWdsYlpBQm1wSktvR1VUVm00UHo3Y3BB?=
 =?utf-8?B?bFAyUTRCTjlkUDNXcnNhZW42dVRheXZHV3U0VXdPdGJvUHEwRm1HT21mT0JW?=
 =?utf-8?B?Q3BxdHd6TVZEZjJmaVc2QVIvSjdGRUc5ZUpjOWtnazRrQjl1NnV6disrYVY5?=
 =?utf-8?B?QzZtQVlPajNWRnB6T3ZQdzlmMS9FRUpkc1A5ZkRsSndmandlVEJlT3lxNHpa?=
 =?utf-8?B?STh0eTlvS0dMUTZPcytsVHROdUNXMWlLdi9kanJYN2Z1STZBU0ozUUJySlZw?=
 =?utf-8?B?a0l4YTU1TDdyNDJocXNweTBKU01DMGREcTdPYVdPdTRkUjNYblVNMVNmWnBD?=
 =?utf-8?B?ZmtrRThaK1l2d2pFd1VrS3duN1lSWXprNWhtenF3QjZsdEpHd0NyU2xiR0pQ?=
 =?utf-8?B?NEN2Z3N6YjJLUHh0UmxIdGtOeFlqekFQbjFId0ViT1FuNUtHZmZxMCtwM2Na?=
 =?utf-8?B?eW8wN05iTnJUYVMzeGNkc2RVbmxaQkVvSW45bE1BOGJXY3lINHdjWG4xOUZP?=
 =?utf-8?B?R0JOREx5eWJ2dk9BanpEUnZ6VEhPZ0VCdCtNbUpPQU1ERXdzdVlKdUZ3K0FO?=
 =?utf-8?B?cmNZZGdqL2pEM1hhUjhFUUIySlNtcGV0ajJZZmQ2R0oyVEdkakJSRG5yTXJM?=
 =?utf-8?B?Z2FRYjlnTUFOQUZVQktrZ3V5UTNjUFpVNnh6Q0xKd3l6bVZuTDNWQ3RQVXRM?=
 =?utf-8?B?eHVocWEyOW12bUZubk5GTVRTYTRVMFZZOVJPd2VqM29kQ05JTXNzY0RrOE1n?=
 =?utf-8?B?ZDRRNG5seVZtTGJ6SWFlSGxQZVNiUm9ZMSt4Tk1wdkJBMURrY3BBdXVIU3Ro?=
 =?utf-8?B?b3AxN0pFSnUraXU4SGZ1T1lOekNUWlZlOVdkbUxqaXhZYVlBN1RONEZlRytm?=
 =?utf-8?B?NjhMZmt3WU9kZ3F3NzVyVkl5aWRuUEFVUUttSEtrbXBkbWdhL2VlR0RyZzlo?=
 =?utf-8?B?S0N2MzJhK1ZWRWN3aFBsbXF5UkcwNmVJSnNJT3ZiamJyZW1nY3JRUWhEQ0FS?=
 =?utf-8?B?TThVVjY2UjhPckttVmFLZjJNZFByUHBKdXFHRUpHRDZnQnhzckcxNzU0cnpD?=
 =?utf-8?B?bWl2R3ViWVhPbnBUeUE5VThyY2lvbEkyTmJCaHo2SXpKdndlZVlERWFuTllj?=
 =?utf-8?B?S1UydU4zdnZ2ZjdJK28wKzV5Z244Zmt1UzkrOXFmV0NQM1k5Zi9TelJFSU0v?=
 =?utf-8?Q?AddzhXhAFw5+vG243GYuttQ7fsKiveRL1tNbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRXZXFaUmloYmdaa29iUTk2ajd2QlhpZklxcVJWZ0FsQzBmZm83aENOK2RH?=
 =?utf-8?B?dmg4eGpqMzVGeG5MNk9UdjJlNEh6TytKTmRFa2RicTBuU1hGZnhsTzF4dDBl?=
 =?utf-8?B?elJMMFA3TzVELzZDcHpPT24yZkJScDF5dDJySHowZ3B2RSsza0VyL0hUemg5?=
 =?utf-8?B?dWJZZUF1ZjVEcmpHSUIxcy9PQm44MlNsVWVzV1JvcVVrOTh0TFg3UmhLSGlD?=
 =?utf-8?B?RFI1ajFrbCthZlRuZEpxOVBzdStwbzhhOC9NZmZOQU42dkU5eWdZcUkzelRK?=
 =?utf-8?B?d3Z0TXJCY0V1TnZ4WkpLQzUyS0RESnpoRStmY1ZxdXM1VEtGSzB1dDNuQmxV?=
 =?utf-8?B?SzJxUHZ5emcycWM3Mm85ZEdGUnFhTEEvQXNLV2JkS3JpcUp3YUtOZDdidDlm?=
 =?utf-8?B?Y3RpUVlrVU55VXdnMlNhazVpalJPWXExUkVUdDJqdVpSa0NXUTRkSHAyY0x2?=
 =?utf-8?B?Ti8zOVNydjBxemNtR0JBMEwzRGJvQ2tFdHhiNWN2SEZ2RUxFWVRpSVpqU2RX?=
 =?utf-8?B?UTBOeU1CdjdCWEpQQjZ4UXlpTXN1VFg4OU9USTFBeUlGdVIybHpra1k3OVlm?=
 =?utf-8?B?QW9yejRnRDlBckNlQklJRmE2eXQxbXpNV21ZZ21XMVVCamkwZWFNdUZXZmI0?=
 =?utf-8?B?NGZjaitTdEM5cVovQVE4YkZ0OU1wQW94WXN6OGl2elFwTHRCdUNVRW0yR3FW?=
 =?utf-8?B?TGhCTVFHMGlhSEJic0pqcDA1S1c3K3d5QVFCWTNtYTBneGFTUWFFelF1d2lw?=
 =?utf-8?B?UFFTbWdKUjZtS1ptZ1VUOGY5WTg0dFpIR0grS0tWbXhLNy9LOUhmRExtRzBi?=
 =?utf-8?B?RXJKRDAxa0FWU0xrSWVjRVhBc1l3MFcxR0tRYjNtcENzY09hWkQ1cS8rTzQ0?=
 =?utf-8?B?alhnRzdKdkY1cmFFN290d1F4bksydktQbkdydVU2RUFqaURhZGl4b2JQTHpD?=
 =?utf-8?B?TU95c0pCdVRjaFg0ZDBVT3dEaFp5K3IrNEtKbEVhQUFSZDQ1V1NtOXl6K3Mr?=
 =?utf-8?B?MlJLQzhlam90ZEtINmFabjc5cU1wQUxhbnVVSDlLREQzc29CcG5TRC8rUllF?=
 =?utf-8?B?d1F1ZTlldHp4YW5DWldRQ0ZwWS82cXlkQkNleXZ6Q1l4WDhzUHRVTW1uU0ZH?=
 =?utf-8?B?c1hyQjdLUDVJRGJra3plY1FsbnFoM3NheGNBcVdJSTVKWEZLSzlhV0Z4TG9V?=
 =?utf-8?B?MVBQRnJ6TmN0L1VEQUtzWFhrNTF2L0c0dURHOFVVQm8yakJuYzdONm0ySWl6?=
 =?utf-8?B?SmMzZ0M2akczSkdrWEx5cUd6ODZVYkZOSFdaY080NVBNdEluNXJvYmFhQzVP?=
 =?utf-8?B?R25CVzhYaWVBMTBZRGFYOWIwcUt5WVR4ck5weWpXdFZ4NnFhSnBHdzZQK3Mz?=
 =?utf-8?B?M010c01mWTluYUZVRU5ySUVrRDI1eFdCNStPd25VdElvUnBFODVnb0I0OVhz?=
 =?utf-8?B?MXIrdmlrckM1SzlRSk5PUGMyK09kMkZVeW00a2Q5SXRtRk1RRjliK2hVK3RT?=
 =?utf-8?B?MjFGL2ZlN1pXdE16SXpjTFc1dkdIVGxzdG1VNUlHcCt6Y1Jhak9ZMG5SQWhi?=
 =?utf-8?B?M1lMcStmWlhzNFczUzJKb1p6UEVjdGRXMy8rUDZ3R045WEY5OGpMbUlXRHh3?=
 =?utf-8?B?Y1hVemRFU1JqblB4aGhQWGgvSTE0ZVdnZ1ZFNEZuRkNKTzRsTkNWemxmY3J2?=
 =?utf-8?B?TkFhU0RvTEhOS1VMRHRGdnRiM0V0UllOdU5aL3JoVk1naGlkY0FNSTlLbVpa?=
 =?utf-8?B?aFcwMzFRWUJjQ0JkdXVQT1M5Nm0xU2lBT2ZycXYyZUtHVUVKcndKTW5oTDJp?=
 =?utf-8?B?QldWQmNDdTl5U09uQWFTSEZvT2tDTkwzdWl0RUpyTVJoM0s1K3RRMlR4SHFp?=
 =?utf-8?B?OXdpQVZiSVlCcVlkMGQvcm03NjdWaElJMGx5cFIxT1ZLN1NvNjVvQUFQcFNQ?=
 =?utf-8?B?RFRqdDA5TnlBNHBEVkN4R01MekJsbWhYZERNbE5rUkZvOFJnaFhRL0RLcEpQ?=
 =?utf-8?B?cWVlU1JBMklFdi9YdGFnYkRJUmM3RlpJUFdXbVJaWUlHKzRFWngrMVhFY1Zt?=
 =?utf-8?B?Z2ZpRVQ0VXo4QmszUmtZUlJKdE9JeFB6M0o1Yk9PRzhuaVJYdFYrQTI3YU9U?=
 =?utf-8?B?b1Q3Rmx2SG1ZOGR3cTNpcUdhczVFZnhHZ0RaU1RDZ2hpQUZKQzAzVjVVVHZu?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd6f967-d4ab-4520-6528-08dd134d7a54
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:49:24.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoiLJJmP2uO8LbfNjB3/QSHOeZu6bviXFzQNWvkzbPoEWm27qSwHTICIISDlY/qikjRerYZLZR1o5/0V/aLLfkSVnTKk40OCzWfnv17vZcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-OriginatorOrg: intel.com

+x86 folks

On 12/2/24 7:35 PM, Ming Lei wrote:
> On Mon, Dec 02, 2024 at 06:47:38PM -0800, Luck, Tony wrote:
>> On Mon, Dec 02, 2024 at 02:26:48PM -0800, Reinette Chatre wrote:
>>> Hi Tony,
>>>
>>> On 12/2/24 1:42 PM, Luck, Tony wrote:
>>>> Anyone better a decoding lockdep dumps then me make sense of this?
>>>>
>>>> All I did was build v6.13-rc1 with (among others)
>>>>
>>>> CONFIG_PROVE_LOCKING=y
>>>> CONFIG_PROVE_RAW_LOCK_NESTING=y
>>>> CONFIG_PROVE_RCU=y
>>>>
>>>> and then mount the resctrl filesystem:
>>>>
>>>> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
> 
> [linux]# make -C tools/testing/selftests TARGETS=resctrl run_tests
> make: Entering directory '/root/git/linux/tools/testing/selftests'
> make[1]: Nothing to be done for 'all'.
> TAP version 13
> 1..1
> # timeout set to 120
> # selftests: resctrl: resctrl_tests
> # TAP version 13
> # # Fail: Check kernel supports resctrl filesystem
> # 1..0 # SKIP resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.
> ok 1 selftests: resctrl: resctrl_tests # SKIP
> make: Leaving directory '/root/git/linux/tools/testing/selftests'
> 
> [linux]# grep X86_CPU_RESCTRL .config
> CONFIG_X86_CPU_RESCTRL=y
> 
> Can you share how to make /sys/fs/resctrl so that I can check if the
> recent changes in block tree can avoid this warning? 

Thank you very much for taking a look.

You may not be testing on hardware supported by resctrl. A /proc/cpuinfo
flag bit that indicates hardware supported by resctrl is "rdt_a". When booting a kernel
compiled with CONFIG_X86_CPU_RESCTRL=y on such hardware dmesg will contain
information like:
	resctrl: L3 allocation detected
	resctrl: MB allocation detected
	resctrl: L3 monitoring detected                           

> 
>>>>
>>>> There are only trivial changes to the resctrl code between
>>>> v6.12 (which works) and v6.13-rc1:
>>>>
>>>> $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
>>>> 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>> 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
>>>> 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
>>>>
>>>> So something in kernfs? Or the way resctrl uses kernfs?
>>>
>>> I am not seeing this but that may be because I am not testing with
>>> selinux enabled. My test kernel has:
>>> # CONFIG_SECURITY_SELINUX is not set
>>>
>>> I am also not running with any btrfs filesystems. 
>>>
>>> Is this your usual setup in which you are seeing this the first time? Is it
>>> perhaps possible for you to bisect?
>>
>> Bisection says:
>>
>> $ git bisect bad
>> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
>> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
>> Author: Ming Lei <ming.lei@redhat.com>
>> Date:   Fri Oct 25 08:37:20 2024 +0800
>>
>>     block: model freeze & enter queue as lock for supporting lockdep
>>
>>>
>>> The subject states "resctrl mount fail" - could you please confirm if
>>> resctrl cannot be mounted in addition to the lockdep warning?
> 
> It seems one lockdep false positive, but it shouldn't cause 'resctrl
> mount fail', I will take a look at the lock chains and see if some of
> them can be cut.

Tony confirmed [1] in follow-up message that resctrl mount succeeded despite
the lockdep notice.

Reinette


[1] https://lore.kernel.org/all/Z0441XN_KoCP-fNz@agluck-desk3/


