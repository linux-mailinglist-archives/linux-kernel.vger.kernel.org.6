Return-Path: <linux-kernel+bounces-421463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA699D8BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF2D163BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526301B6D14;
	Mon, 25 Nov 2024 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZutVKIDN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894D1B4F24
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557254; cv=fail; b=Bf0l/V8/SyqE4m1p7HluhexkRwG2OxSvwgHZlpbo9bVctmbhgqXJE88mYjchxtBGf+Ru+08yxRlC3JkCDtFe11EGziScJEpAUQofQWSJao4KPbmWlInRCKIJtw/xOmV8goXZAVwr0W15r+wyVPnDxE1R9P9/UlCpov5Y7N/6zfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557254; c=relaxed/simple;
	bh=ylSLA+l6AXkUXwFDM8AFf04ZoTyKgdoz4QMzkr0WLM0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAjR07oE/U+2aWzeujsFMdYC2E16w8eWOLuuxq/654rC+p0XZmU9q1irqFx23PAaYgb8HAWw2gKMiXq1fO2cZmDf9Xifqqq6VQTCwLwJO1JW0Fe+iMlo+1npRwVsPQKjam2QsBWvi+P2SxPaxDJQ5aSKW1cDDHYpzrD1MigMxhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZutVKIDN; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732557252; x=1764093252;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ylSLA+l6AXkUXwFDM8AFf04ZoTyKgdoz4QMzkr0WLM0=;
  b=ZutVKIDNVY4AvrPdlYCkGNjMyrL3m417NP8zVqh5pK+4OPEOxC1E2VGP
   lVH9i5S4g3oxcoSv/ZHF/2Cqk5SkKvqklfoojUxJF36ck7DL3vXH4GBdr
   VJFrRaY4UhAkAXCb7nxxeoje39SDJEBMAn1qj+cYeZANyGVWXCodCJTsa
   /LbtcVJc8y/TUL2/TkPZmEgLDcJRna1XARqQWZkg9Ce2Rpo2xjFWEA99n
   wBcwwAagQ/AetREJZRRnoB1NmR7ffYCQ3KR1s5/K4Gvd1iqTICVU2cttk
   l1k2kp10vVaa89zy9dYWbS+gfy4havot2dTagZudKp/vxupG+adnDbAOB
   A==;
X-CSE-ConnectionGUID: o9I2i+SJRTOqNvYe6qZx9Q==
X-CSE-MsgGUID: DLtb7hX0Qi2fktI/mjSzIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32050953"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32050953"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 09:54:11 -0800
X-CSE-ConnectionGUID: l5XEIwhgQ2eXsvY79DqnkQ==
X-CSE-MsgGUID: aqmYmh22RISg52Iz7rc23A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="128861347"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Nov 2024 09:54:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Nov 2024 09:54:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 25 Nov 2024 09:54:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 25 Nov 2024 09:54:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCof5ZrCkrRajEfNG+x/+rWIXGu1dECVIc1R4WtwU4udD+h6Dv3RsZfsVE0gvhVqGyPNjMTYda9MhxN5mEu1mMkVXTt+7S7GAJaCBaiK8ORyCJqEx7MSkqwnj7dRJujJ9maGcl5wKp9fZCqZE/Zdob8UpsY5Df1YO+8KZ+L3Pk2Iiri4ClyIrnsu8gveUHiByNVPe0P1saWlHNAoHLoLR3RGi9BuNesdaOu1JYZQ5QpwsIBO1TnWIyCRkduXwASwzAUlDzPkyA0UIPw1PoW8kdenF9zETHj1w+MdjnG2Y9IT2ZZsLNo5+A7Jb1epuDeWYdAqV6vCoV7VA7pkUoiZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwV/uIrgii7J592fuLhXjowrXxIdrEhphvGVnlN+VUg=;
 b=Y2+hwHCHP4q0Dn0X2Z/GSbflANKhz8U1JOVRHrV8M3zKh7KcnZOSL3A4HR3JrmGJyr7P5WUvySoAjyxPFGSTP4vZI6Jg1Qhw5+mn/ffbttdFOXZ4YroblVEobGU3tjdXkbObz2MS5Zg8bXwrvY8qLmTHSzze41Wkbq7mxuMGqVXheC99WiPu2dgZi2VOqzQ6wWhFieSDzIYOJuWLLoPEHw14bXCVrshqy9cz2b5cn0n3VpFkvsZPQk4qhoqIA3B6hL6tph5CmO+RuMjbx8/v79Usd23gBWNiYZGBlHkGHHKRg/p6F6f1SBeUiRsQS5xHZOYH0u22riYwasPydp5ucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6449.namprd11.prod.outlook.com (2603:10b6:510:1f7::17)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Mon, 25 Nov
 2024 17:54:08 +0000
Received: from PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::9a1f:5bdb:b4ab:171a]) by PH7PR11MB6449.namprd11.prod.outlook.com
 ([fe80::9a1f:5bdb:b4ab:171a%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 17:54:08 +0000
Message-ID: <224ee788-1371-4b57-b2e8-c595aa0a2b2a@intel.com>
Date: Mon, 25 Nov 2024 09:53:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:6-11: ERROR:
 invalid reference to the index variable of the iterator on line 665 (fwd)
To: Julia Lawall <julia.lawall@inria.fr>, Jinjie Ruan <ruanjinjie@huawei.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, "Simon
 Horman" <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
References: <27f489a5-1758-c0a2-f977-bd17a26d6dbf@inria.fr>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <27f489a5-1758-c0a2-f977-bd17a26d6dbf@inria.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0062.namprd19.prod.outlook.com
 (2603:10b6:930:69::9) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6449:EE_|SA1PR11MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 113815f4-0ca4-4eef-ee22-08dd0d7a281b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGZPajBqWndTamlPbUpMem05T0dEY052aFRRVGNaMXBGYXc1VE8xUWJUanFa?=
 =?utf-8?B?SjE4QkkxbS9Rc2dQMUoyMFdmR01XN2xyUDFESVVVanh3c25aYVVqV08ySFRB?=
 =?utf-8?B?dmtvaU80RE9LSVoxU3o0Nk1pdGlBSEFRb2hUKzRRUXpmUENiZkdnUmVhTWlF?=
 =?utf-8?B?aUtGdUJ3SVBnRjJGbnhuQjJranF6Q0E2WnJ1NFpISVV6UGVkZFUxYkV6Mm1x?=
 =?utf-8?B?dTR6dG1rNWxxalg4bUwzSFdqOFhVSzR1My94SmE0RGVrMmdQc3JHOTBoeGUy?=
 =?utf-8?B?WXVVemZTbU10cm1PR291c3V5N3MrVS9mWUhwTUllZXM4YTU3MG1hSTRtQ2lo?=
 =?utf-8?B?VFlPczVxTEpQZkYzRTB1TlFoYkdOZVFVb0pBc1hVakFrYWp3d1VPb0JiUm5V?=
 =?utf-8?B?KzJqUUJic2NPeTcrWnVHVm5wSWdRQnVkYUtXSGhPTVljY0h4bUdPc2pVMHF4?=
 =?utf-8?B?U2ZUeTcwemsrSVZPajQ1YjRxOS9xNVRQMUJnd0RmMlVkeUFwZWF5VCtYd3Ix?=
 =?utf-8?B?NHdpbEllU09WZitMaDd0L241K2gyS0FPSktXT1VaL1c4QWQzbjJ6K1p2N0JQ?=
 =?utf-8?B?bDBhTEIwMzJKYkREY2VZNTN5SURkYTZ2TEtEWXZRL0xmRzcyZFZ1Q050MGRT?=
 =?utf-8?B?Tk1vU2M0cndkWHVkWEp3Z2VpSm4xcGVIdDJ0YXB0UlFHNVlOVldWd2ZtOHYr?=
 =?utf-8?B?aGgyMUduR0NaNjgzQlY1OFUwRjJtcmRJMTUySzByUXRhNUw4MzhYcFhNcVdu?=
 =?utf-8?B?MlYvTE5iV2tDOUJwWFQwSDgxYTdtcTlDV0N4aWR4TFB0YWxIWWlTNlBYY0Nh?=
 =?utf-8?B?NmFKUjR2QitSTHI0VGozZ0crU2ZueUhXeGNTSDRkN0Z6bTh4R29na3lsQnZR?=
 =?utf-8?B?QzFjN3R6cTB6eDUvcDBPTGNGcXdDOUxXTTBJaGF5MTZDV1ZHRTg5MVordTlK?=
 =?utf-8?B?aG5wYWZhMm1pcWh4TVFmbzQvWm5LNlVldTJoVjI5RTdBMUJSSkVsT3NySkhn?=
 =?utf-8?B?S28weHpBUlczdXFMV29Ya2xLTHluK1lKRXhrN1BzeEhxT3ovT0tUOGlwNHhi?=
 =?utf-8?B?TFBTSVkyalJQbHhVa25CbmZaUkxQSkUzWXcyZ3dsbGpzeVZlVlNESHc3ZGhL?=
 =?utf-8?B?TXVSUVJEVFJ6cXg4azIzR1p1TFYvNHNXTmc3TWZlVzJlN28xVGJhZEFVbFZG?=
 =?utf-8?B?cksrejFZMTBsQVppWVNJVUJvUkRrM1IwZk1EcXB1Z1AxRVhpWDhRenkyN1Bv?=
 =?utf-8?B?U1Y3aTNJUjZNSU44aG51cW1HR20wK0pIVnBvSkIxcmJpNjkvWnpUcCtjSUty?=
 =?utf-8?B?aDlLbTRIdHJQR09ZanhscG5qZk5pM2FkMWRLeWtzNkRpM0M0LzI0N1VIZHFH?=
 =?utf-8?B?MERvYmJRTzB0TFZ0bmZFMlFhRVhyWG1tMGJVbDVaVnU0TWloWTZnbVVUOEhY?=
 =?utf-8?B?dHVaWWZGOUd1aDV4cXJ5ZHBTdS9jSm94WUFIcloxKzJvNmZxaXMrbjJuY3R1?=
 =?utf-8?B?RFVIcHB2bmlvMmNENzBENEQvQVg5V1pVRHg0UG5nbUh1aHVOODFKWkZhVFZN?=
 =?utf-8?B?RlVETEZ1bk04NDM2SGpyUHFzZUFmcmJkZU44QndVb1F1a1pDOXoraWlzR2JL?=
 =?utf-8?B?TWtOSlFoZVBtTlB2RG1SQW9MQmxwQUFYdEk2cDc1K0JSbXlCVWdmSW9ybzUx?=
 =?utf-8?B?RTI5WmsySVFmR3lzbHo2THlrTDVieVpqTjNLTWdJdzhjWEJmL0NjM2NHb2Zy?=
 =?utf-8?Q?iFpi5+Y7e5VUb2YC0pomcRbE9sB/iFfI7m/PLNH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6449.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNndVVsRktqMkl0VmtEaWRjVDNNZkVBYkErWVFlR29pbko1Q01UMjZLWEpH?=
 =?utf-8?B?ZjJId3A0MDlYMFR3QS9UU1RUWWgra24ydmRBTVVqWjdOdGw1M2xINkRqZFdt?=
 =?utf-8?B?T3RNSFMwTzNkLzNCcVJBMDd0bFdQeExZZi91SHk5ek5VMlNhTnVkRGlzVWpw?=
 =?utf-8?B?dGpqVHFwczZqVUlwb2RldnQvTFlWaW16SmRtZVE1QVNWOWptMEQ0a1ZQai9P?=
 =?utf-8?B?ajJaUjBIVEVFSDZPaGZySDlTeEhEcjV6a3hMNUF1L0xNWUtZbnVoQlNObkgr?=
 =?utf-8?B?QllWRVZDRHc1WVRTVWtTWXRXQnB2amNiOU0wdkpJUlBLa2t5bDBRWmxJZmpk?=
 =?utf-8?B?SVpMUnI4S1dYMmp4MEYvMFN5M0FHYThPK3ozSFlOTVZpV2lpNUwrWmlBbERP?=
 =?utf-8?B?dVduRGNwM2IwcW0rUVFZRkNmb29WakRLU0FUZCswMElzQnVaR0VVcU1YeXlB?=
 =?utf-8?B?UUFHS24zK2FSQTVjRVE4OHo0Y2JabVpkN1BpWHpGYllCVXdHQndKQUkrdWJ1?=
 =?utf-8?B?ZUg5RHRjN0M1MTJqVHNOMnRSMjlieStBdlM0WmRaeVpQQ3NYOHZRakhRdHIz?=
 =?utf-8?B?dlhPZnhlRWRkVW9rVGx3WE9JQm9GNW9DVk93c2FRZkdPcFBNb2owREUwd3lR?=
 =?utf-8?B?NnNndER0ZVhuZ05ZeWZnWTZ3WGdOTWVrbWxobVdRZHVQS0VRckNKVkZJWmUr?=
 =?utf-8?B?ekdWNml4b1ByMkhGNHJSekh5SldBQmk0QytsaWJOT25UTTFMRmFhUm5qU2Z3?=
 =?utf-8?B?MHJBTWRVZXZyb2FJOEhmdFZBazVGaEZmanBxaTE1QzBBWXFqT2FjUUVDRnhH?=
 =?utf-8?B?b2wxRDZoOWVCNXJnS0VRbGtHYVdoRUhkdVY5SEdHNWdsUm9xaW5Wa29yM0Rx?=
 =?utf-8?B?b2M1d1NaUnkxQjgrNCtMSy9BMUNmd3ZUSWk2UTk4SjZVblZTUHFNazVNSTJJ?=
 =?utf-8?B?Uy9GSzNDN1RKUVJUUm1OZDIwclpSZUY0bHRMc0pLbWUzcnZyRFR5N3lVbjB3?=
 =?utf-8?B?RmJzZHUyNGZzc2Q4K29GaE54YzdSVldlQ3F4RUJReUc2L2lmOTFsWWNQVmVh?=
 =?utf-8?B?V1NKVStXc04zcXkyamhONEsxcHBlSE81cVJBY1prWE1SOGIvbXpJamFFaFNl?=
 =?utf-8?B?YW5FU3lScjJtU1JONW5HaGRMOTVKN1oxZkQ5VGJ4Z3hHQ2k2ejFHRVIvamRZ?=
 =?utf-8?B?cDFyZ0hoYUUxd3BBYmt0SFNBcjNlVHowbS91QXVJVnpOSVUzelZHdWVqSUtQ?=
 =?utf-8?B?L2RVNWpacXh3SU9qcmdoRU9Qb0t5N1JmbEdZN2dBWDBTT00wVnFySnFiaFFk?=
 =?utf-8?B?NWh0Yk4wTHhoYXMwYkFHbHlHVTViZTZrdElEU1BFcGdHQmMvc0VLZjB2WDVW?=
 =?utf-8?B?dFlFa25KYkcyMVBPZHRuZG9GTW5ZSTFNdWdXdEtkNXlPQTVNTnJrRS9KdEtN?=
 =?utf-8?B?OEJDQVJtVkhEaStvaXlPZGM4STUwL3dvTzlxeVl3bEQ5cTNCRll0M0RkbUFs?=
 =?utf-8?B?OTZDdGZZZHhxblBGRXVkWkRuNWJyU0ZvSjlpd0FpOFA5MHFhVTBZTDBwRTho?=
 =?utf-8?B?MGxLYUlaRjlYazdLSTVJb0NxdHZRMDBwaGRwcXBpYzdwdzUrdk1wV0Y0TDZD?=
 =?utf-8?B?a3FFcFhMckVvN3B4QWpKeWFZS2NveDFxemVkVGwzMk9VZjVZZkxvb2tPVnhX?=
 =?utf-8?B?cWpoZVFPMmNNSXJVdFlsT0hwRThWb3NENm5DWDBsdHRQa3A2WVFoRWdQVXM3?=
 =?utf-8?B?clRrSGE4UkVGeUtGUlRFN0tqcytvRnVZNGorMDJ1eVhDM3VyTG1XbWVyOFIw?=
 =?utf-8?B?aWlLWUZHZWxDQUVoVDlRU09yN0ZaQ05nVHFWTkNFVGxiRWRlU0RBamt6Mzdj?=
 =?utf-8?B?a2x6MkZJaE41TElrclJlL2tyRm1vU3pmdUpwY21LTXBmNlBOUzV5MjNCZGhQ?=
 =?utf-8?B?TGR3anFFQXpVd0pMdDNUM0NZNVJOb21ZVENlUEE3cmNMbEVIWkJFdkIrcmVq?=
 =?utf-8?B?eXM0RTRac3JoMy9GOTM4V0lES2JmRDgycCtRV24wSlJFN3VmcHZMZm5BRzJj?=
 =?utf-8?B?c0dSQVlMNCsycmpNKzlPWm5yT04wdXY2NXBBZjdNZkRKaGhwSmJlWmdBMkQv?=
 =?utf-8?B?NEVDQ1VZSHNPQXZDSHJEMHNmaENIbWY1YWdVZmVIdHQ0TnRDZkJvWlRiT2FI?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 113815f4-0ca4-4eef-ee22-08dd0d7a281b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 17:54:08.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJhI60nPnnMKuy1ttPMcJNkjfcWgDpheBZXVUgl8ibrB31inwt+Q5xpxXFsvJN2mupz6WKlsXkcF2d5bEWjbVu9L8CvV5Mt46IK7NE10oOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
X-OriginatorOrg: intel.com



On 11/23/2024 7:11 AM, Julia Lawall wrote:
> Please see lines 663-679.  Setting entry to NULL is useless.  The
> list_for_each_entry will overwrite it, even if the list is empty.  The
> !empty test on line 678 is likewise useless, and the !entry->free est on
> the same line may return a meaningless value if the list is empty.
> Consider adding a flag variable to record whether the break was taken.

Hi Julia,

I believe this has already been addressed via commit a41654c3ed1d 
("ixgbe: fix end of loop test in ixgbe_set_vf_macvlan()").

Thanks,
Tony

> julia
> 
> ---------- Forwarded message ----------
> Date: Fri, 22 Nov 2024 14:07:03 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:6-11: ERROR: invalid
>       reference to the index variable of the iterator on line 665
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: linux-kernel@vger.kernel.org
> TO: Jinjie Ruan <ruanjinjie@huawei.com>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Jacob Keller <jacob.e.keller@intel.com>
> CC: Tony Nguyen <anthony.l.nguyen@intel.com>
> CC: Simon Horman <horms@kernel.org>
> 
> Hi Jinjie,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   28eb75e178d389d325f1666e422bc13bbbb9804c
> commit: c1fec890458ad101ddbbc52cdd29f7bba6aa2b10 ethernet/intel: Use list_for_each_entry() helper
> date:   1 year, 2 months ago
> :::::: branch date: 7 hours ago
> :::::: commit date: 1 year, 2 months ago
> config: riscv-randconfig-r051-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221358.yZAZKbuI-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 14.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202411221358.yZAZKbuI-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
>>> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:6-11: ERROR: invalid reference to the index variable of the iterator on line 665
>     drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c:678:16-21: ERROR: invalid reference to the index variable of the iterator on line 665
> 
> vim +678 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> 
> 4c7f35f679f592 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Alexander Duyck 2015-11-02  637
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  638  static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  639  				int vf, int index, unsigned char *mac_addr)
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  640  {
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  641  	struct vf_macvlans *entry;
> 0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  642  	int retval = 0;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  643
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  644  	if (index <= 1) {
> c1fec890458ad1 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jinjie Ruan     2023-09-19  645  		list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  646  			if (entry->vf == vf) {
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  647  				entry->vf = -1;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  648  				entry->free = true;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  649  				entry->is_macvlan = false;
> 5d7daa35b9eb14 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jacob Keller    2014-03-29  650  				ixgbe_del_mac_filter(adapter,
> 5d7daa35b9eb14 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jacob Keller    2014-03-29  651  						     entry->vf_macvlan, vf);
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  652  			}
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  653  		}
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  654  	}
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  655
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  656  	/*
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  657  	 * If index was zero then we were asked to clear the uc list
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  658  	 * for the VF.  We're done.
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  659  	 */
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  660  	if (!index)
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  661  		return 0;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  662
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  663  	entry = NULL;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  664
> c1fec890458ad1 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Jinjie Ruan     2023-09-19 @665  	list_for_each_entry(entry, &adapter->vf_mvs.l, l) {
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  666  		if (entry->free)
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  667  			break;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  668  	}
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  669
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  670  	/*
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  671  	 * If we traversed the entire list and didn't find a free entry
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  672  	 * then we're out of space on the RAR table.  Also entry may
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  673  	 * be NULL because the original memory allocation for the list
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  674  	 * failed, which is not fatal but does mean we can't support
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  675  	 * VF requests for MACVLAN because we couldn't allocate
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  676  	 * memory for the list management required.
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  677  	 */
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13 @678  	if (!entry || !entry->free)
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  679  		return -ENOSPC;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  680
> 0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  681  	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
> 0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  682  	if (retval < 0)
> 0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  683  		return retval;
> 0e1ff3061cb529 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c Tony Nguyen     2017-07-19  684
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  685  	entry->free = false;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  686  	entry->is_macvlan = true;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  687  	entry->vf = vf;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  688  	memcpy(entry->vf_macvlan, mac_addr, ETH_ALEN);
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  689
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  690  	return 0;
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  691  }
> a1cbb15c13971b drivers/net/ixgbe/ixgbe_sriov.c                Greg Rose       2011-05-13  692
> 
> :::::: The code at line 678 was first introduced by commit
> :::::: a1cbb15c13971bd5d41626e9e5ced9f9de132c47 ixgbe: Add macvlan support for VF
> 
> :::::: TO: Greg Rose <gregory.v.rose@intel.com>
> :::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 


