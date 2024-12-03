Return-Path: <linux-kernel+bounces-428513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A2D9E0F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0797A283067
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B01EDE;
	Tue,  3 Dec 2024 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaGrZytt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13FA2D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184239; cv=fail; b=dEe/YO3mcTk1y3yQ352HntoySYaX0acbAD4GY7nSNoSEcFu29upAbdkWSzer4QsiGKpqL5fgt0MJTIEpRfRs+SirLd6xGWWFQ1jRyA2/pCxgFrfdcqTv0gORcfjWNDYA5GwsljLe/xo7qlN136Sf35BA5waTAV+i4JEZJC8ZrvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184239; c=relaxed/simple;
	bh=iDk1u5jEDEzn2A0Vx/niTm4m/5XUHFZBCJcN+h3yfdQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=odjMA4m2ar4MK01QZFHIfJ6RhxV3VcZjY39iZaSVVRSEtqiLggweyb5Dy/MaFJ6rJM+eOvwRrToaw39TFSEhY1rj4XOtJSqRMaSncCIy1H6+Yc9ymbcmgf8S7RN89Tah2tR9QiIkovLLs52YsshF3an99dhGywfvf855PyhCQws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaGrZytt; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733184238; x=1764720238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iDk1u5jEDEzn2A0Vx/niTm4m/5XUHFZBCJcN+h3yfdQ=;
  b=IaGrZyttSJf7utgTSV4ouEV1312jWKMgj8fMixQ1KMrwtIRSuOTRGpZo
   Egar31F8sp8m0GRfW3QIGS4E0JmVoLgIhcsFyf64oQc3ty8SO+IJKpDqK
   fZC6XX9aQLugqC2iN9+EPKpEG1wOxedAHErVVNl/ig7y38/W1QCMFwT75
   oCoYjYrD9EasZ1pcezG5G7WWEzCg2hkxOzH80ZS7AOjOXaMdp3uh2schz
   YY17a+CvA/ezpoFQbL8zmgW/l3TIYUkaaLPWap2uFG7WkF/5Zvo5pvb/B
   2z7VgfAIUBmaaiFhFH9njgmDkgUS1K1bIPUvL/S/nM81NFWEnXAQqQaMv
   g==;
X-CSE-ConnectionGUID: GGVh6ZnOTKilWIHCndyejQ==
X-CSE-MsgGUID: YnQZaY7AR+e10UFxDgPJqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36232116"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="36232116"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:03:10 -0800
X-CSE-ConnectionGUID: dyJLutk2R9mg68IayS7i1w==
X-CSE-MsgGUID: L2gnzq0cQTuYaHgwfDZucQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98276129"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 16:03:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 16:03:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 16:03:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 16:03:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbqLvwi7GQdS3Z7Dqe2ZUVGJyktdc0oL0RcteVaO7FcHFYbJqnVXXGRx46XHyIVlgQka2o5Rvg918ZWuELiSI4fsTw34WoLwS/oCbbevqw5+qzMzOR63TurtwiZVLt99XXkzJYLuNfg7TIDwViJBTVgK3FDzXV2KUy3PO8hcRyW+8CnV1xeH50MnvoB/66vR5PhdCr+/ydF605xxCmT84P5kIvki5UcAowPFzxujUWnsVmmewdI0bLbu7qdvcLzowRY2TbPGtmNGSghE2XozHnKT3aq2J/FGBvTQlWEhFMp3hxrnEuBne/6gCstI/KkSkOyfuoZDmDPr6N2SZuYmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc8brih8rGYab8W6n9aBzO4Cfc9zlb3zHOStOERNEjY=;
 b=J0aC1R9yfAtJhu6ChEkA9ZtRlvIFoJ2LT5FkBTCtYIxs6cJJCIvtimMXcrOgJb48Uwh6x+xPwWlE5FHBDQAOq/YYA44XJmox5i5E9JuFfLVD7NkUNrCztS2fh5Cb6gvJtlpU78s196tgQ42NByoF5RdCq0egpRG9Hp8y5O1JVASHSLwEwxCe8bzOsWdfStXtXZu4Y250QSD8n17Xu1ZSSyJSrGXRGc2wdNUphPpc/OF/FZ7WA+VpRTlvBUcaxBoOB8ecXXcvNgm/FYC8GTHgdTY26wfmrbDvIlue+Z9JTUa6Tdzbv23GpVSdENhSI/DRsn/XMafq5LngGXmnG0rBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 00:03:01 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8207.014; Tue, 3 Dec 2024
 00:03:01 +0000
Message-ID: <643cfdaa-b43b-f445-f7aa-cc444797368d@intel.com>
Date: Mon, 2 Dec 2024 16:03:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: resctrl mount fail on v6.13-rc1
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>
CC: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
	<linux-kernel@vger.kernel.org>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z0441XN_KoCP-fNz@agluck-desk3>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <Z0441XN_KoCP-fNz@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 98178c07-aa1a-4616-419d-08dd132dda1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVhUR3MveG5QVlYzUk84S0JOZ3lCNTFvb2gyQTQ0M215d3REbFRJYmI3OXlV?=
 =?utf-8?B?c2k0YUFJVmxlRHRRSlpFbVJwRzlOSFpjd0t5WnljNWR5NDN2UmFCci85TWhX?=
 =?utf-8?B?SzNEazZ3aWhWVHBGcjFzQ2phbGNXUVhWazFXSTNnU24wNWZFZDVaa1hPNjFk?=
 =?utf-8?B?MHcrYmxSZkJRV3JaZFgyOXRXcWpQaThaM1hJMWRPM2RraFlhOFdramtJUDI2?=
 =?utf-8?B?Q1hOSHl3MlozYk9TYzZlczdvajdyaDN4aHlSaTduY3I1TzFsUXF4bVYxV3k5?=
 =?utf-8?B?VmpUWFZETHZta25Gcm9pcTBEZHRjNTd4dlNvUzY5dUJpNWp6dkd6OVVpdTRm?=
 =?utf-8?B?aGg1cnp6Qk5qcDBDaFRONGJiV3czRGhMb0c4OEpDQnphNDAvVSsrYlRBWEJp?=
 =?utf-8?B?TEowSEdJTm9lcXdMRlJ4T09QcmNLZ2xLNW5oS1Q3dzdXY213OXRHbDFqS3g3?=
 =?utf-8?B?UGtQM1NaOFJ1OWNXMGcraWg5cmFzWHplL215c1JhT280b3BwVnppMExySUdC?=
 =?utf-8?B?QWZzNFhTTTlKbjV5TzZPWFJORk9BbjQ0b1AvQmtiZnBHekVQdDZ4bHhCbjVG?=
 =?utf-8?B?d0NsYUdnUkdPckVIMVR2bXFkTEY1ZnhZWnEyRW1sTllUUS9XZmU1YVY1c2pL?=
 =?utf-8?B?cWt0amxHTnk4dDZhSkNDd0MyUGR2L3VIeVI4ZVZvMUZHeWZJM3FqdU1VZm10?=
 =?utf-8?B?MURRdmtibExDcjVTS3hxRUJnRHRuUFJXU3ZCL1QwRWNpdWhjWTVwTGUzTnY4?=
 =?utf-8?B?dnR3RkdhaXhTL041QVlCOW5Tb1NYc085Q2FZODJsTGhqZjlpVCtlVW14UzBv?=
 =?utf-8?B?ZkU4R0hDKzVyczVrZTRUZkFGVGoyNE1JVkoxL245NDlndkFkMGRYY3FNcG1p?=
 =?utf-8?B?ZHdYUTljZTI0RUgwVU13cmlFWDUwbFo3eXRLL3ZKSWx1V2xEQXM0YThLd2RB?=
 =?utf-8?B?M2lEOFg3VzBSaHB2TGZFYjBud0YwRnVwdVh5a0dwbllyWDRBcFgzZFo3VEtT?=
 =?utf-8?B?ZUFGRFh3VWgwTnY0cmhkTDk0S1NnT3FkK0gycGhMdXhTeFR3c2VDZTBFdEhs?=
 =?utf-8?B?aktlcGIxcHQ4UFNGOHh0ekg1VjVlMEw4WGIwVXA2b1dNd0RkaE1zYjZJcW0w?=
 =?utf-8?B?aHRyb0RyZ0tFZG9zVjl1ODlNS09VSVNsTGQwTEtXRTdKNHlWOXJiQlNhOEEx?=
 =?utf-8?B?Mm9CQ2Y1c2Rwd0xVMlB6Q1FSMXlvdUFjaUFhSUx4aFluT3ZBSm1mTjVKR1Fa?=
 =?utf-8?B?ekpnQXlRWGIyR3orWDZBa0Q5RzdBcEZiWktISUo1bWpmT25jTDl4KzN4WWhC?=
 =?utf-8?B?SVYrWm9vbUdjTXNJRkIraERNRi84MFgxQjJqSDNLZjVJSFdOUEZXNUEzUjFq?=
 =?utf-8?B?cHowMnVqM1pENjR5M3RWTWN2UXVjQU11ZDZYV3MraExFRXRxNmFPZUNMMmNI?=
 =?utf-8?B?Z1FqY3Vsd04vdmtSRUFPQWR3TENiS29yb3FFV2NiaEV4eVVPdEc5TDg5eEhV?=
 =?utf-8?B?SnlsQVJYU3RkRld5S0E4ODhENFBHSnIrTDNGNkEyZk94bTRxM3BxODVIaEhI?=
 =?utf-8?B?L3YxeUNJRTlYTWpxRWloSnAxUkZKcXBBMGFXSGtNQUo5WlQ2aHN4a2ZOUUl1?=
 =?utf-8?B?a09yWG1MQ0hVYUo2a1VBWjJ6MFZMR1JYMmlKUW5zeGtaSWtRczVnMDBVdFFz?=
 =?utf-8?B?bHZEQXVsYVBpL2tlK0d5ZGl2dVlzMEZYcTY1OHNRUDhqU2R2eSswbU1HU0Fu?=
 =?utf-8?B?dWNQZERCazRLZWtreHNsVHRmS2crRDFZWkUxd1RjaVZiUjEwN0IvUVYxblpt?=
 =?utf-8?B?aDVUUnNFNzI0SW1kamVDQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9aY3RQdDA1T3JhdHJTdlcxd3BHVlpSbUwrcVNJbHZ5em9QVHJDUnN5eXox?=
 =?utf-8?B?cXQ4MlRuYTdwMXZDeHFvbTZQK1huRjd6RTFXUTM1WFo1TnVGNWZrbnl3cE1u?=
 =?utf-8?B?d2hZeDdPa2M2MFNWdFBvTXFFUURsQ2x6NWI5dW5zWnV6aGs0eWtoTzg5SFJh?=
 =?utf-8?B?eFoxQnJRSmVsODhBa0loSzZ2eXBNeTl0K0pJRWV1cGZudEEvd2tWcnpxUDF4?=
 =?utf-8?B?V1F6cFI0ZXY1L0Y0MlVlRE0rMnBxZm13a21aQm5rSVZsdC8xd0FXOWorUG5B?=
 =?utf-8?B?SjNudVNpT1NkSG1JT1RlbEM1SlZ2aHNGSTk2L2FJcVJob2FYRGhDcmtyZUZq?=
 =?utf-8?B?TmFYcUZJb2JaZ3o3L1FKVTFvUTlwQjJWV05PTm5aNmpSMU5SMFJQK0swTFVh?=
 =?utf-8?B?dlpKVFVaUW1Zb2IvVDBBWkZsL0xpNHhjcHZya3FoMXk4dFhPODdhSXl2M3lM?=
 =?utf-8?B?eFp4SHB4aVJMOE83b0N5WDZmWSszSmdWayt2czRkb1hRdG81ZnhiTjRjNjRy?=
 =?utf-8?B?bHc4OFZPWVg2V0NrWEZFV1RLYmpTRG84VFU1djJyVUlnTHlKZkpoVEFwc0lq?=
 =?utf-8?B?cXowL1F5dG5LUExramQ3VUZrTGZwQ0EyeDFIdUxUVHI3UEVzZjBkVTFjY3M3?=
 =?utf-8?B?S2t5RFBqOWVLUzZOQ0xLalRoTVJiUXljMTdXaUVLemxxU29EN1dWdTd5WC9M?=
 =?utf-8?B?Q09iY3p3MW56MkczbWc4emdwS1gzdndmWHY3UkYxREdEM1B4UE5RYVVNWkxI?=
 =?utf-8?B?am1GaUdKYXlxUVdpUndZMWptRTluME5kSjBpRWdMWGNpVklLVm84cWdHNm9s?=
 =?utf-8?B?amJZSDh1UjNvR1R5TlZodmlyeWlZTE1QcHhMSzN3dS8xakJPdEszUGRrRW9r?=
 =?utf-8?B?Y0FzcmtNM0VJWTlTMVZ0TmNHRzB3MEtQcDcvNkdXbEpKUDR1MmRwMHFZeFVQ?=
 =?utf-8?B?YkFNZXhyNVUyWFNsV1hMVkZ6WlozWWg5WHRaQisrWDh6eG56TTgybUVtRURC?=
 =?utf-8?B?SzkzNEx3dFpkTWFFeU9xZGJSVlRSVllFYnY3L2owS0ZaUEh3ckhvWnJjSDRh?=
 =?utf-8?B?WTNGQndzdExLWlliS05oSUJxRzNZWkc2ZFYzeDhQM0pTWEVMbHB1VUQyZStG?=
 =?utf-8?B?b0NTb1RiTmNXQngwbVozZE5Sa015Sk41MnVCaE9vTld5d3Uwc210RzhjYkpQ?=
 =?utf-8?B?Skl6azdmenBZRnViWVdxb1U4aVJQS0MvSlBVL3FRWGgyb3haUnB5TUxmdnZR?=
 =?utf-8?B?eFVBeDZEaTJNSGp1WDQ5enFwZ1BZaW5RRHVYbEdGdCtBay9hbHBuQjFDdGJq?=
 =?utf-8?B?QWVTQXNKUzY3NGtQditEcVplN2pNR211RURtdEZlcDc4YkhoT0RNZXVsY2RX?=
 =?utf-8?B?cnh2Tml5TExNblRhUm43K1FHSWZUVUN5STNhaGEwSE1xR2FJMG5ZQjQ4LzVO?=
 =?utf-8?B?S1lqbVpVdERVMFltRmR3c2tBZGlkTE45MnRqUlUrREl4dUhsOVJPUnVQR3dx?=
 =?utf-8?B?OS9LNEdJM0xUQ3hLUnJtdG1tYUdEdlpIbHArQnFWV2ZMdmNZZVpaemIyRm9E?=
 =?utf-8?B?SWp3dytIWHdSVkxmaDRXajZkNCt4V2d0ZnM1d09sZXNZcWJQY1drK0pnV3Y1?=
 =?utf-8?B?V3FVTjNJRzZqQmpIb3Y5TkdROHQ5ekxUN2NHSkZxVnUyeXBwNVNudTN6Vm5S?=
 =?utf-8?B?a1ljYlJIYmNMdEpXRjZtdnZCLzV5OHBKOG1WZ1hhL3h5UFQ3c251ZnptUG9Y?=
 =?utf-8?B?UnpuMWpMOW1XbE1uUVhwT1dSSDhUbzZ5U3NraTBVQXFqUXhIdks1L1VRRDkr?=
 =?utf-8?B?OHM2RHpMem9Nb2ttWFMxU2FYUnZjVGJjaldSQ0JNR0FtYTRReGlWNXlFaUFV?=
 =?utf-8?B?cngxZlUwWW1ZUUdlb3Y4Y2lodEFvLzlPanQ1K29ma0pSSlJTZ1Zwa2p4ejgx?=
 =?utf-8?B?UWNIRHVsbmE0MDNyQnFyQlVMSFV1bGVXdjZVZzVWcGFLMXdqWWJGbklpdkZy?=
 =?utf-8?B?Wk96R3RTZmRWMWpZV2hFdE92akUvZ25UYWpEVlJGOWNHTG1Fa3VzQWVuVnM5?=
 =?utf-8?B?TTlwcWljZ3NqZWN1NVM2UHBlTVJBcnZaQWoyeVFVZC8yRzI0TXptNnBCL24y?=
 =?utf-8?Q?jfWxbIhKTtjbwjg09+HLHW0So?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98178c07-aa1a-4616-419d-08dd132dda1c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 00:03:01.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAMvB1uAkl56JVASSkvjHhm2ybi+LfwJS8LhW6IQBKxUhvV/HZJwvkLxamLeHWDkCjio0GcZrGosqfxSuiKCgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com

Hi, Tony and Reinette,

On 12/2/24 14:46, Luck, Tony wrote:
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
> 
> I did have SELINUX configured. Disabling this CONFIG option
> makes the lockdep splat go away.
>>
>> I am also not running with any btrfs filesystems.
> 
> My root and home filesystems are btrfs, so difficult to
> check if this is also connected.
>>
>> Is this your usual setup in which you are seeing this the first time? Is it
>> perhaps possible for you to bisect?
>>
>> The subject states "resctrl mount fail" - could you please confirm if
>> resctrl cannot be mounted in addition to the lockdep warning?
> 
> The filesystem did get mounted despite all the lockdep noise.
> 
>>
>> Reinette
> 
> -Tony

I did see a similar warning on ksoftirqd before mount resctrl during 
boot time:

[   65.611812] WARNING: possible circular locking dependency detected
[   65.611813] 6.13.0-rc1-dsa+ #62 Not tainted
[   65.611814] ------------------------------------------------------
[   65.611815] ksoftirqd/4/44 is trying to acquire lock:
[   65.611817] ffffffffa787fbb8 ((console_sem).lock){....}-{2:2}, at: 
down_trylock+0x13/0x40
[   65.611829]
                but task is already holding lock:
[   65.611830] ff4ed95eefb32898 (&rq->__lock){-.-.}-{2:2}, at: 
raw_spin_rq_lock_nested+0x27/0x40
[   65.643035]
                which lock already depends on the new lock.

But I did not see the locking warning when mount resctrl. I don't use brtfs.

Thanks.

-Fenghua

