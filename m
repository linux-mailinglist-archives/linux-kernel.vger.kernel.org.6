Return-Path: <linux-kernel+bounces-428726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3AA9E129A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E30B225FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C54013CA93;
	Tue,  3 Dec 2024 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGqpnStw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F50170A1B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202172; cv=fail; b=oFtWbtx8rHesgW6bbKPM58UtmbzDwXJsa9vbO5zJDxaM/yGhyWl+MY9OCSxlkbhsneVf0Q2685n2IBpqB6r4t8K9ZBd5xE3dF6XnTAfqxDfaD7mdyfr/9TvYcGMfHc0sGQow6mqv2BfHa2NcHs22OLWmtIBhp/uJEUYMMX9AaZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202172; c=relaxed/simple;
	bh=wA/DDCrI9kf+CW+LJn1gCxf0nIgJ581rSoRZOEQ8N4Q=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nEcDpc/jt/ArHDe3+3CaCI2gEC5ipulikJp/0GpyhFiT/7sNSu7KUCQFmwqUPqtvsxdLRbAbEMF9iOtbYi9JEW4dpaBUgVKfrs2J7rIZ3M9xpaHuOdjGpW8p1zzpxGDN2nGaY4/DkeZIteHw7UqQOCNJELk7C2v4+J5KpGVNMLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGqpnStw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733202171; x=1764738171;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wA/DDCrI9kf+CW+LJn1gCxf0nIgJ581rSoRZOEQ8N4Q=;
  b=FGqpnStwGO4XhSq1YDsPTe6zqmOqFwddqLHYQ1cytTxNhGrr2DxRb1VZ
   BH2Ab5jaQkyafjdgYzQYFf3FyTspwJMYDkU++hSNVqtRI7Td/pHuLhhKb
   rZJYZWs3oYFhbneRn1PQm2fPwKGpLMT9kX6o11Mu3upPr9tgCYKc4Kwhz
   WUqmhg+NMPy8HUbLeYdrqhPZA5dXOeS/RednK8d65PwrbW+Gu3SPZREly
   93844auKgSMceTcutnnazVxMvPC9igxon30NuPcCdknYqVjvqWfvuiKsg
   BbZCUaxJQCvrD8VXs5Vw0y/gv2sFS850mOFe6MqhnCY+MuJzhRf9T3Bl/
   w==;
X-CSE-ConnectionGUID: KTn28YKRT66771OFUsCwdg==
X-CSE-MsgGUID: yh3/jTHgRm2rPld3U1Go5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33549704"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33549704"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 21:02:50 -0800
X-CSE-ConnectionGUID: mYJhQnKrTSyjCLIdMc5vmA==
X-CSE-MsgGUID: nxn0AEo5TO6h6evJbRWHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97382931"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 21:02:50 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 21:02:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 21:02:49 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 21:02:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyJoztH4Pik3KWMalVTQZVVBcen1vZY1bwXraOqSbTPVe4D5FqPXez+RHMqkMAXt8VW6l1HatBS16UUMhl9BQ7xJdT+JwT19jDxJRzHqnDYJuc8vp02Q0lng5eHw/ngaBLXQRD12jkqITO3Wj3jboVyORjHnS+dVugUCpslskaz1HUcNkUYtYK+VZp6x6Nvm6ohSdnC9tk0bmAud80w8q5lbT/DMSQusD2+dNgEwQuzwM8aurSUPnRjTOXrh2JstO3Qdr4gb0vjtkD0tSDhXxYw/FRkjQoRjp8Gx9NxDCEO4A2LzhBsDiQwWvpTaM00589/RjuW5Q9yqvp0tSUaOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz3zfnb8JeM7tjayZsr/R7UZAywSzanFsG7XNDbXqMA=;
 b=MkznWfydm06DiLVkfS1Av7dRs0ocfDjCVPXJtQmfFtFvu394MbV6DW2rFJMk44nJTTsyQv5lelca4uU2gu25791fRTR6gHJ5dlE5IduRRXVFsZmFVjKCQANbof5PmENMFMKyNGPABIHqnY/I88LiF6Iq+hZwA4xqZheB+X/YoNyzRE44bGzGAiScZcNqfQrPfYG/jrXOiCZLnN8LnQ5ImwUtIt05JWrYr2AsrLPQEhS8W0eSZovHQFArCdw1HvMbOFqmEqfDBAWLnWzf/NSy+O41OlDaoG7nDnYMBMFuyIYTyJ1TkyvePHSdGjvlU31NmP+oPG08twAl13VSHaaNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 05:02:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 05:02:47 +0000
Message-ID: <542a0c87-935a-4b39-8210-22a7d46de6e5@intel.com>
Date: Mon, 2 Dec 2024 21:02:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl mount fail on v6.13-rc1
From: Reinette Chatre <reinette.chatre@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, Ming Lei <ming.lei@redhat.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, <linux-kernel@vger.kernel.org>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z05xSqIeNeHh19MZ@agluck-desk3>
 <e1dc44c7-94e4-4055-84d3-8fdd5c22d161@intel.com>
Content-Language: en-US
In-Reply-To: <e1dc44c7-94e4-4055-84d3-8fdd5c22d161@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a98178-6dcd-4b44-0f91-08dd1357ba7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDZFM3kySU1pMEJxaGhPSlJKcTZ1ZkNhOHpSTTFDdE5wVnRrbXFrcis0MEtY?=
 =?utf-8?B?b2syeGhQanhYenh5KzYvSW0wTTZSd1ptdTNtVDVIRGlYQnZvM3pqRmRuL3Iv?=
 =?utf-8?B?M0pxTllic0c5eVExWEg1ZExpY3kwZmh3eHRvT2RzYUxjdk85SEFBSy8zN2FS?=
 =?utf-8?B?cHFaY2c2cFRBd3dnSUp2ZnV0UFplWXRjZHh1ZXErYjhTcytNS0E3Mlp0NWhX?=
 =?utf-8?B?enQwaDR5R2JyczZwYU1oY2k4SWFmSXBwVmVMbFZvM2RaRFdCSWFJQ0ZoWVpr?=
 =?utf-8?B?L3UrdkY3Ly9hN2M1RVZvU0xYZnFwdjhPTXJwRXZlQTZHMlJsemxvWjRXd2dH?=
 =?utf-8?B?SGpqb1FRbXE0N0tyUEo4MG0xNDdmb1orRWpkTGdOa2I4QnRjaFEwOU91eGZC?=
 =?utf-8?B?ZkNhbUZzYi9Edk5IV0xXanZHUTBPbmRrQ0lPUWdnUUptbWFXdmh6RFVlR1Az?=
 =?utf-8?B?QjR3TitNWnVNRHRMWXorQ3dBM2ZuZTFuaDV2N3ZoUEFEcG9FWUQxRlN2MHVH?=
 =?utf-8?B?blM2dmxqUG9naEpGb2VOOUNHeEFwQmkxcUNpa20xR3RtSnVHb0Y5VHUySGlK?=
 =?utf-8?B?KytMUDg4aGdqeVFwcUloR2dEVkNESzJyNytKU1dON0VjWVZib0N3ZDZnVWEr?=
 =?utf-8?B?clZuU1pwR0dDcnU5NVFhT00xK0dMS01WdVZyT0hsK0dzUUJkQzErU09kc1Y2?=
 =?utf-8?B?YlJ3aGpXT28yWEdjSU1pSDJwcVpUa01RRmVGeU4rUWY5VXBzRk10c0o1Y1Ny?=
 =?utf-8?B?TkxaQXRlODFVVzZxdXJudEhDMXpMam5odDgrYnp6M0x3ckxqdjI5TG5WTmIw?=
 =?utf-8?B?TUYyeWRtcERpSzdyL3ZJOWZVdzAxenJBTHdabGp5azF4RVJ6T1dEdE01NnJv?=
 =?utf-8?B?MldxY1lOMU15WEJPOGNzYVY0YUlYQ3JSMy93UXdRZ1Z1UEhNV0lDdmR4Mmtr?=
 =?utf-8?B?N0ViQ1pGdEZTdTVNQXVyeGNIcFpuVDV0dDVDdTBnZHcxUGNNK1I1TXN0OGYw?=
 =?utf-8?B?Zkd0REV2cjhhTjJOQ0w5eGdHSHo0cmVBL0VEZ3MxZE55TFFYaG9FL1BWamMw?=
 =?utf-8?B?TjJpYjFJaklGMlNhZEo5eUttY0FmODJLZWc4Z0lGUU84UXFpOTJ4ai8wNzNX?=
 =?utf-8?B?bXpkbEVub0pST2N0SG5aVHFTdWJxWjB0QVVxV0hlMmQrYlhXYUJ3NDJJcEdn?=
 =?utf-8?B?NnVGTjlxREsrOVoyVjhYcFByUUdXaHlpQ0xQWmVrWFBPREJySU1leWFpN3U4?=
 =?utf-8?B?RlZiYUdGODByOVgxMlM0MEI3VURESWlZZnRIYkVjK3dBMjBicTBKRWY2MWxj?=
 =?utf-8?B?M3U4cGdDbm1ZcDlwdzgreWFRTU1US1prb2JIeC9RQzBMN2NobjlTbEZQOVJF?=
 =?utf-8?B?NDMwZ1UwUllQank3Zk1RNi9OajFNOVBxVWxZemRIenFENzVzdjh1dENwQk02?=
 =?utf-8?B?TUI3b3l2VFZXblY5U0pHZTkxa2RXT05DUVhCdkFPMnVIOExudG1UZTBYdjVU?=
 =?utf-8?B?T2RHMEp4ZDZLa1FQUzlhVDlPeHc4Tyt1TjFRdldWL1o3ZGxWL0RZeURUQ0Zl?=
 =?utf-8?B?TndzWHJxMnREdlVYRFdtdkhhTmRCRnVFZ3VKMEZTT3MyaURQaWkzVm5KWkcv?=
 =?utf-8?B?d3A4aWxWTDUrYWF1RndkU1AxS1BEMkRDUWtDeGVhL2I1ZUgvTXRqcWFreGxR?=
 =?utf-8?B?L0t4WDI2cUFGV0RnK0tjREVMZzJlVldmQ3o3NGtiYnRtUTk0d0UwVEE5c2tq?=
 =?utf-8?B?dlhtM3FpQ2RGcFBqd05halhUa0g1KzJWZVhXWHloY1JjaXZnTG4vbFNOSkhN?=
 =?utf-8?B?RXNKVGxZK3hWb0dyUjhkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJvaEo2OHFGVjhKUHZ4RUJQRTFJa2s4dDVoaFFONmZKMjVTYkV0YWF5ZWIw?=
 =?utf-8?B?OFFQWmtBNTBqam8wTUxVcW5Ub0pLelFXZlh2VWdOanF2WXFsNVQ0YUVyVFBP?=
 =?utf-8?B?bUtpc3kxTEQ1THJRZ25aN3VNZlErNkhtbkk2QmVQN0xhcnAwU0FDZ0xVbGhp?=
 =?utf-8?B?VE5NNVRmTXRsMk0xL25Rd21ITktKYUN3K1BNbmxDdFpLdG5QcnVwUnlwOCsr?=
 =?utf-8?B?NUJpZ29IemxSc0FiU2wvZk1ScXhxUUJQTTVzYzFKQXlDemNzbFNza2V5SG84?=
 =?utf-8?B?S0N3YjhmK2ZJbkMxSXJQQ3NjMVNKZ29pajBVeUljMjc3R0NxazNKR3VzeE5p?=
 =?utf-8?B?OENnT0JnQXBSVWgwaXNPN2ZoZXgwcU1VUzY1a01NT2dyTjVNOGpDeDloY3FH?=
 =?utf-8?B?c2hjV3RjYVJUWjlJbmR6N2R4K252SktVVGZhVk9HU0F3UFRNSkczSXNJemk5?=
 =?utf-8?B?MmpzR2tsZzl0MUtKcFVSMXFqU1RIRVM5TEZsN0sxWm5TakVWNW9PdGFsenRO?=
 =?utf-8?B?Z1RrTHhhRXRsaU5Yd2xLVldPdkYyTS9SZDA4eUkycHNIaGl2MFpqdHBVclha?=
 =?utf-8?B?YzhpRXl3UW8xdmVnTFlQRGFMTm9LMmN4N3ordWlMZmw0VkMxc2Q0ZjcxY1lh?=
 =?utf-8?B?d2JscGlIV2sySFM5OUlCaDByQlk5VTJuQm85QVBETGdLL1Jma0xJMzZaUWQx?=
 =?utf-8?B?MVovb3QvV2hhbHhick82a0FxKzVoK2RiaW93ZElCUEFzdkwyWE9BZDNEc1VN?=
 =?utf-8?B?WFZTWTdtbCt1ZDZVUHMyMmJJejFaT2l6U3ovVVNHa0s4dXVVVzRuaTVvZXZQ?=
 =?utf-8?B?UjJEU0hyWXJpYkNXVFo5L1RwWHNZKzZwU2Fzcy9jQXRjczRwOGllbUlwamJx?=
 =?utf-8?B?bFE4OW1DT1BBZWVPcHhOSWQwZlpka1hMMzV6eDBTc2JIN0J3dlZKc1Flck05?=
 =?utf-8?B?NDRHVTBpeC84ZG5idmVRblp6NnVXMTUxZjg0a2dsczB1SUkrRHhVQ1o5eUxK?=
 =?utf-8?B?R0ZyUGZFTUdXQ0E1VHVOajJHK0RTTjFKWjBGZ2tjMmNUeTNGcXFmOUJBU2JV?=
 =?utf-8?B?eU1IdVhkVUE2UVFzOVArY0xVdXhDSjB4bE8vbTRnUVdjYi9mNEpyQ3JZY2pL?=
 =?utf-8?B?NmxQSnNuVGo0N2J5V2tUZDYrVDJHM0g0SmZmdWV5dWt4R3pleWRtL0FUbmt2?=
 =?utf-8?B?QU9DcUVUc2ZDRnJteE50WHdKMFkwQzF6TGlNdSs1SVVCQzJtMzBvYjVHdyt5?=
 =?utf-8?B?bFlWSk9qcGkzWGVhWFI5a3Z5cXQ0aFB5OWhOSE9vZWNiSkhQaVNaZEFoZk9a?=
 =?utf-8?B?QnlxN21TMWpvV1dvNVpHV2J1Y3g3RThoLzVRcUtBTlpzZWcyZWFKZDJ1Tjk3?=
 =?utf-8?B?emdFSHdldnpPUjliNVRhcEFQZTJuRUhmQW5jTDlUeUNZNzM4b296NkZyTFVh?=
 =?utf-8?B?WnNMQjU4TXZCSDgvVE9hVDIxTXg3cmp4dk9LdUUvRHd3K09FT1QwNHdCK2Fr?=
 =?utf-8?B?QlVVa1ZkajM5MmhYdDRRMVF3ZzJ1TmFaT3Uya0ZJMGNkQ3hBRlNJSDU3cWR5?=
 =?utf-8?B?RXFyQlJDU1RTcTIvSzFGbHYzcVAzVnQ4blpQNVV0Ulgxb3NDV2pncnpMZHMw?=
 =?utf-8?B?d3V3ajJ6TlRWQ2RYK0pkWnpKWGtaUFB3V0pHNGtaMW9TMHFiWHU0K3NVN1pI?=
 =?utf-8?B?eUlOZHE0WDVzemQ0OUdpMUZpQ1MvY2FFc0xQNk4wdDU4RmtLTFkyTE5xZVJa?=
 =?utf-8?B?VzRzMHJUWUlsWUhuZkt1U1ZmQlE5VkJUWmRKUmV2OWFvZXdKdUI3L1djVzU3?=
 =?utf-8?B?TFcwSTZJY0JxdVUwbUJpMkZZMlpvWmUzWTlkL3dwamc0dm9jRkw5dk1uLzRD?=
 =?utf-8?B?YVBReUplVDI4V2M5akR5dGcvdC94QzM1S0kwazlQVmc2eGIzYmlFWVpuZnNs?=
 =?utf-8?B?Z1pzU1NxeFV5ZmN6M0hLRWlCbnBma1V1TTF6VkEwZWVPQWNVK2ZVR3EyeE04?=
 =?utf-8?B?UWczTTBYVXNJa1dXS1MwbnVyWXBncjE3QklCOFIvM09SSktSY2grbWl0MzlJ?=
 =?utf-8?B?d0J6L3hTd1ZpR1FiKzRLdVJldE1xbGxtZFJBY2JnSERoMVpRTlh5SGFVejRO?=
 =?utf-8?B?QVNZRHB5bmdmbjU2VVh0ODMzZVB5bmFDUTBJWUlZZVJ5c25kTXBQaHY1Sjl5?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a98178-6dcd-4b44-0f91-08dd1357ba7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 05:02:46.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYCjqoMf/BhBqEJoTPO7j4brPViMfHLG/Z92Lnl7vv/9D/dJAw6a6twg7gs5XkAUkID3SSoqOrMaKN7xkczd7QnJ1hagbW3y+9HYmp5/WgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com



On 12/2/24 8:54 PM, Reinette Chatre wrote:
> 
> 
> On 12/2/24 6:47 PM, Luck, Tony wrote:
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
> 
> Thank you very much Tony. Since you did not respond to the question about
> bisect I assumed that you would not do it. I ended up duplicating the bisect
> effort after getting an environment in which I can reproduce the issue. Doing so
> I am able to confirm the commit pointed to by bisect. 
> The commit cannot be reverted cleanly so I could not test v6.13-rc1 with it
> reverted.
> 
> Ming Lei: I'd be happy to help with testing if you do not have hardware with
> which you can reproduce the issue.

One datapoint that I neglected to mention: btrfs does not seem to be required. The system
I tested on used ext4 filesystem resulting in trace below:

[   67.598375] ======================================================
[   67.604562] WARNING: possible circular locking dependency detected
[   67.610741] 6.12.0-rc4-00037-gf1be1788a32e #1 Not tainted
[   67.616146] ------------------------------------------------------
[   67.622326] mount/2738 is trying to acquire lock:
[   67.627031] ff2f341adb984578 (&sbsec->lock){+.+.}-{4:4}, at: selinux_set_mnt_opts+0x71/0x730
[   67.635481] 
               but task is already holding lock:
[   67.641312] ff2f341ad746a0e0 (&type->s_umount_key#65/1){+.+.}-{4:4}, at: alloc_super+0xd9/0x3d0
[   67.650013] 
               which lock already depends on the new lock.

[   67.658183] 
               the existing dependency chain (in reverse order) is:
[   67.665654] 
               -> #5 (&type->s_umount_key#65/1){+.+.}-{4:4}:
[   67.672525]        reacquire_held_locks+0xce/0x1f0
[   67.677317]        lock_release+0x11e/0x2b0
[   67.681503]        __mutex_unlock_slowpath+0x3b/0x290
[   67.686558]        rdt_get_tree+0x1b9/0x5c0
[   67.690750]        vfs_get_tree+0x29/0xf0
[   67.694762]        vfs_cmd_create+0x59/0xe0
[   67.698948]        __do_sys_fsconfig+0x4f3/0x6c0
[   67.703567]        do_syscall_64+0xc5/0x210
[   67.707763]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   67.713341] 
               -> #4 (cpu_hotplug_lock){++++}-{0:0}:
[   67.719523]        lock_acquire.part.0+0x69/0x1b0
[   67.724226]        __cpuhp_state_add_instance+0x3b/0x1c0
[   67.729546]        blk_mq_alloc_and_init_hctx+0x44d/0x4c0
[   67.734945]        blk_mq_realloc_hw_ctxs+0x15e/0x190
[   67.739998]        blk_mq_init_allocated_queue+0x138/0x480
[   67.745485]        blk_mq_alloc_queue+0x7b/0xe0
[   67.750015]        scsi_alloc_sdev+0x281/0x3c0
[   67.754463]        scsi_probe_and_add_lun+0x1f5/0x450
[   67.759514]        __scsi_add_device+0x10f/0x130
[   67.764133]        ata_scsi_scan_host+0x9c/0x1b0
[   67.768753]        async_run_entry_fn+0x31/0x130
[   67.773378]        process_one_work+0x204/0x590
[   67.777912]        worker_thread+0x180/0x340
[   67.782182]        kthread+0xd0/0x100
[   67.785848]        ret_from_fork+0x31/0x50
[   67.789947]        ret_from_fork_asm+0x1a/0x30
[   67.794394] 
               -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
[   67.800399]        lock_acquire.part.0+0x69/0x1b0
[   67.805103]        __mutex_lock+0xaf/0x740
[   67.809205]        queue_attr_store+0x61/0xb0
[   67.813573]        kernfs_fop_write_iter+0x13a/0x200
[   67.818546]        vfs_write+0x29c/0x540
[   67.822470]        ksys_write+0x73/0xf0
[   67.826311]        do_syscall_64+0xc5/0x210
[   67.830496]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   67.836069] 
               -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[   67.842852]        lock_acquire.part.0+0x69/0x1b0
[   67.847557]        blk_mq_submit_bio+0x81b/0xab0
[   67.852179]        __submit_bio+0x97/0x180
[   67.856277]        submit_bio_noacct_nocheck+0x324/0x430
[   67.861589]        ext4_read_bh+0x51/0x90
[   67.865601]        ext4_sb_bread+0x75/0x90
[   67.869699]        ext4_xattr_get+0xf5/0x250
[   67.873973]        __vfs_getxattr+0x7f/0xb0
[   67.878159]        inode_doinit_use_xattr+0x63/0x170
[   67.883124]        inode_doinit_with_dentry+0x36b/0x530
[   67.888348]        security_d_instantiate+0x39/0x50
[   67.893228]        d_splice_alias+0x52/0x4e0
[   67.897499]        ext4_lookup+0x1e1/0x270
[   67.901599]        lookup_one_qstr_excl+0x6f/0xa0
[   67.906306]        filename_create+0xcb/0x1b0
[   67.910665]        do_mkdirat+0x5c/0x140
[   67.914589]        __x64_sys_mkdir+0x46/0x70
[   67.918863]        do_syscall_64+0xc5/0x210
[   67.923056]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   67.928629] 
               -> #1 (&ei->xattr_sem){++++}-{4:4}:
[   67.934633]        lock_acquire.part.0+0x69/0x1b0
[   67.939340]        down_read+0x31/0x150
[   67.943178]        ext4_xattr_get+0x71/0x250
[   67.947448]        __vfs_getxattr+0x7f/0xb0
[   67.951634]        sb_finish_set_opts+0x1ab/0x290
[   67.956341]        selinux_set_mnt_opts+0x4d9/0x730
[   67.961220]        iterate_supers+0x7b/0xf0
[   67.965405]        selinux_policy_commit+0x24d/0x2b0
[   67.970373]        sel_write_load+0x4ee/0xbc0
[   67.974739]        vfs_write+0xe5/0x540
[   67.978577]        ksys_write+0x73/0xf0
[   67.982415]        do_syscall_64+0xc5/0x210
[   67.986604]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   67.992175] 
               -> #0 (&sbsec->lock){+.+.}-{4:4}:
[   67.998006]        check_prev_add+0xeb/0xd80
[   68.002280]        __lock_acquire+0x11b6/0x1640
[   68.006811]        lock_acquire.part.0+0x69/0x1b0
[   68.011515]        __mutex_lock+0xaf/0x740
[   68.015615]        selinux_set_mnt_opts+0x71/0x730
[   68.020407]        security_sb_set_mnt_opts+0x54/0x90
[   68.025460]        vfs_get_tree+0x81/0xf0
[   68.029472]        vfs_cmd_create+0x59/0xe0
[   68.033656]        __do_sys_fsconfig+0x4f3/0x6c0
[   68.038276]        do_syscall_64+0xc5/0x210
[   68.042461]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   68.048036] 
               other info that might help us debug this:

[   68.056033] Chain exists of:
                 &sbsec->lock --> cpu_hotplug_lock --> &type->s_umount_key#65/1

[   68.067419]  Possible unsafe locking scenario:

[   68.073331]        CPU0                    CPU1
[   68.077863]        ----                    ----
[   68.082393]   lock(&type->s_umount_key#65/1);
[   68.086752]                                lock(cpu_hotplug_lock);
[   68.092931]                                lock(&type->s_umount_key#65/1);
[   68.099806]   lock(&sbsec->lock);
[   68.103122] 
                *** DEADLOCK ***

[   68.109033] 2 locks held by mount/2738:
[   68.112873]  #0: ff2f341adbb5b070 (&fc->uapi_mutex){+.+.}-{4:4}, at: __do_sys_fsconfig+0x4bf/0x6c0
[   68.121831]  #1: ff2f341ad746a0e0 (&type->s_umount_key#65/1){+.+.}-{4:4}, at: alloc_super+0xd9/0x3d0
[   68.130966] 
               stack backtrace:
[   68.135327] CPU: 109 UID: 0 PID: 2738 Comm: mount Not tainted 6.12.0-rc4-00037-gf1be1788a32e #1
[   68.144017] Hardware name: Intel Corporation WilsonCity/WilsonCity, BIOS WLYDCRB1.SYS.0027.P82.2204080829 04/08/2022
[   68.154528] Call Trace:
[   68.156973]  <TASK>
[   68.159078]  dump_stack_lvl+0x5d/0x80
[   68.162744]  print_circular_bug.cold+0x178/0x1be
[   68.167364]  check_noncircular+0x14e/0x170
[   68.171466]  check_prev_add+0xeb/0xd80
[   68.175223]  __lock_acquire+0x11b6/0x1640
[   68.179238]  lock_acquire.part.0+0x69/0x1b0
[   68.183423]  ? selinux_set_mnt_opts+0x71/0x730
[   68.187866]  ? selinux_set_mnt_opts+0x71/0x730
[   68.192313]  __mutex_lock+0xaf/0x740
[   68.195892]  ? selinux_set_mnt_opts+0x71/0x730
[   68.200338]  ? selinux_set_mnt_opts+0x71/0x730
[   68.204782]  ? selinux_set_mnt_opts+0x71/0x730
[   68.209228]  ? lock_is_held_type+0x85/0xf0
[   68.213328]  selinux_set_mnt_opts+0x71/0x730
[   68.217599]  security_sb_set_mnt_opts+0x54/0x90
[   68.222134]  vfs_get_tree+0x81/0xf0
[   68.225623]  ? capable+0x3a/0x60
[   68.228855]  vfs_cmd_create+0x59/0xe0
[   68.232524]  __do_sys_fsconfig+0x4f3/0x6c0
[   68.236623]  do_syscall_64+0xc5/0x210
[   68.240296]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   68.245348] RIP: 0033:0x7f1fcd171d5e
[   68.248928] Code: 73 01 c3 48 8b 0d b2 40 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 82 40 0f 00 f7 d8 64 89 01 48
[   68.267672] RSP: 002b:00007ffde8bb54b8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
[   68.275245] RAX: ffffffffffffffda RBX: 0000557854ef36c0 RCX: 00007f1fcd171d5e
[   68.282377] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
[   68.289507] RBP: 00007ffde8bb5600 R08: 0000000000000000 R09: 0000000000000001
[   68.296641] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1fcd2ecb00
[   68.303770] R13: 0000000000000000 R14: 0000557854ef47a0 R15: 00007f1fcd2e1561
[   68.310899]  </TASK>


