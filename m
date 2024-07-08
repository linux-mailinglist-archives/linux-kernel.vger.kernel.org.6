Return-Path: <linux-kernel+bounces-244716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A27E92A862
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8293A1F21CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D93148317;
	Mon,  8 Jul 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ed/9eY5V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDD13E41F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720460891; cv=fail; b=ae58Kp5GacvO/RWaxjMGT/lVxk9Y+4I5f9iukj70DcX+Pbl9pf3uChuwBHFl3Wbmrb2QDbvwDJ+7W2+NuT/3LpmK+XtMR4yyWmxog/MKUwfHvhpjGeAAqMADAcEMrxBBxlezt+5LdtmhyBXix2yFEg3kQWGql1Rd8p97xQ/4aJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720460891; c=relaxed/simple;
	bh=yW6z9AB3cUTpEIY2pQuC/wN4lYXxWZLJAO68ML/B9lw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k26f6jEyWo1ipeZ7Wibnk7i4Q5Rre5OJ28nbTtgMjc2kZx6QgpRxVLISASQHk5GTamVFS6+KMY94mGGavpnMPFLGkosD47Gr+6eYoSAFzbyT7qs9OMy3NulgEYv9QG1Hynvr9ZxWDoILCIiIamnq46SlJSPmwLDYzHBbT2PgOZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ed/9eY5V; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720460889; x=1751996889;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yW6z9AB3cUTpEIY2pQuC/wN4lYXxWZLJAO68ML/B9lw=;
  b=Ed/9eY5V2YKBPTVcWK3cn8wfesxVko0eTwYStFRqzlPmCnRLmC5TOnqD
   uhOgSNPgJcc+hidlmQONJGMX6QwcbVeG1SetTPC0GjmSQ98fvZZRj27q3
   h3rMExueyr4Bx5uPgnrDxTijO5XSUg2Ts7pGuigvT2lyo3SJ7Bz2MwprM
   NN/V22ZIG7GpAokbH+DZoM6H5XVPu6RfqNi/Hr2MAdBa4ajHafDZvfgiw
   PsFIb3bUCJ55Qks1ily6pXrqCC05PhdJfOLOs+G8cHI1wpqavVztqWtGg
   FijmgYLsciV+oYgG052/PZx/Uq7QgOW86B174koDMHZQpjwm5PLaAjasy
   Q==;
X-CSE-ConnectionGUID: uLE6E/D1TJ+cCr8otfksWw==
X-CSE-MsgGUID: 3uTnBu46QnOjPaQgwX9T3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="35214743"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="35214743"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 10:48:06 -0700
X-CSE-ConnectionGUID: +w67OdKnRoGBql1WKpo0XA==
X-CSE-MsgGUID: kf+D3DKHTM+Vc1uwp1Vvhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47677233"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 10:48:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 10:48:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 10:48:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 10:48:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FafF3XEMoTGvvULi8Shk1FBBmTs+173Le2m2AK2n7aYRb5X665hLvnXGcPCusMHYBcED2RgWS1nHKt8CeUhOpUZyQh3ip5JDYxlr4KZyFkUOHp+Hjzt2nDWtPGQ+MAjYS6+I7XI4YsR6BaRxMkvSIRN1RJFj8iqKxIXqgitRpQo6s1wN06Nk3NnwsrVf2gHL4mF0FNcWHYHQDLoWBg6P0X7O5ZvrQ1YIqVWFt+qkX66RnDd/vJTTzXaAZos6IoQXZ6U45WLUJFaWQXgkfy8c2vhX2hAIzChonxcneX4FTTRs4FMl7sCBnDbkBaZm7i0we2/bNtyTrIOBIAzPv/YRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r+8ECzPDcLfs+uN65FmvrnSeGyZ/8cv+pX6ne/nhNQ=;
 b=HHnRdzU1g6X1nd6YosbVdQGSVY9RZCGxEUYJjf+sqXTzZXg/FZM28GuyjqvUxfr54Zp/j1FZDi/9QNBsH5bL/nJDyZ1Rnvtsj5LcVytvJzPU0mavXPLrJiLCyvOtAaNFtjAQmcG5aDmvYSxSOeqgjpYWqVaEglQALFmPL5ml7zqfBLxgWkeXF1oJZFTaFRt4zJIAM8adsVcMmIIX1pa7oWlZ7G/5zJMOZooR4BVWy1iZqpwDDckwdPHHzwTJIfMA3c443YVJQpgAJVLqasXXFJe++4wq+qEt9tJZVAuIYTr3Xn0uQvLlcJK0MgxAx3ptwCJ6RSkVffMi3RljpubF3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6145.namprd11.prod.outlook.com (2603:10b6:208:3ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 17:48:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 17:48:00 +0000
Message-ID: <20735ea0-2a3a-4230-92c6-6007c0777e24@intel.com>
Date: Mon, 8 Jul 2024 10:47:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/38] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-32-james.morse@arm.com>
 <be5bae3d-a192-4ca0-9474-809774011f25@intel.com>
 <4b988afb-bc2e-4b4c-8ebe-e1db0b614f24@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4b988afb-bc2e-4b4c-8ebe-e1db0b614f24@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 327c1e61-3a49-4fe5-6309-08dc9f761c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGtGSVNpNENtNkJPVGdtNzBPZ2dxMTUrZTZJYWY3dXBjT282eVVlM0VUZmhT?=
 =?utf-8?B?T2N3cVpFdHNBZk9VNHFNVkUyYmFYYjc5enlOTFN0dHNmaDZUaGlYV1V5YlNN?=
 =?utf-8?B?bi9QMVpreHhyMkcwSG9Pa2J3cHpDOEVsd3M3bWNNYXc5Z2VpS0MrK1JGblJj?=
 =?utf-8?B?N1M3N2tMakhyaStsTGt3NXRKOG5xTUJIOFBsMVYrZXJTM2pFNk1NekpkejVa?=
 =?utf-8?B?bERQT0NtdWdVNGZDSnRiOHQ4amo0MndYMEx1aXpCRHlUbjJIdCtkQmdWK0Vi?=
 =?utf-8?B?ZWVZYms4TWZ6SU5qanlFK2YwcjVUaTdWYzIrTG5FYUdaZTZRbEpqY2JjaUpE?=
 =?utf-8?B?Vnk2aU5LWWRROUZTSzBYcHVUbzN5TDcwSTBBZzNSYm5ydEJxWkwyNEhtSyt1?=
 =?utf-8?B?cE1tOGZOYXo1enprTlNVN3VRNVZibCtpUUpqd2ExdTVzUDRKbmRwUk9EL2V5?=
 =?utf-8?B?OEZON1QwU0FnS2ozc0FpQ1NncW5jZ2lROUJoV3haemN3VW9LRDFRSVQ2ejJE?=
 =?utf-8?B?WS9kMjc4Ny9UZUErVUlhZGllNVM5bXlVZEhmcG14alh1MzFhRElnUnFkbjc2?=
 =?utf-8?B?QWVjL0EvdDI0MExRZ0JGV1JBbjUrK2xtbUVPQThDSDR1em8vYUVqWkRVQVMz?=
 =?utf-8?B?bHRIeUFGM3VsOE8vQjZIWUdrWUpJaGcvb3NmdkkzVHc1Z0VxZ3o3eEJyUzFv?=
 =?utf-8?B?WEQ2YU50MFN4MDBaaWdRNGIvSzUzOFpPeFZoTGlxUXVYZW41SmpKaVFxVEJS?=
 =?utf-8?B?ZGFHdEZLaW5TYmh0ODZIUE9PUzk1RVFHbWZDd25XRG83L3hTMS9adUxEdWIv?=
 =?utf-8?B?Sno0VHA4N2MxZ2NIaGI5WHh0NlNVRzFSUDNoWU52Vk83OUVRbXpaQ1p2b05o?=
 =?utf-8?B?TTZjU0tXN0UrYy9vMFhrZjI0Q29kRm05SlUrUGllaGlid0lCRWJIeCtRemZr?=
 =?utf-8?B?S2t1OHc3cVdidEMwRTdCaGV5cE0zUHhsVEtIcnFyYmFleU5peWc2Qit3RE1E?=
 =?utf-8?B?aXlZdWo1SkR1ZmhHaFlySU4yMG9XZHF2bWZ5bE0xN1hkRHAzSEhqOTRjdXRo?=
 =?utf-8?B?dWFBNFA1ZXEzMDA5cUFTZ1dsRWgvTE5qUTVKa2dNaW5MazRqemdJb2RmZXFh?=
 =?utf-8?B?UGc0U3hSK3J4U3B1NnRIclFSZVFrblVPb09LS3k4SzZldWU5Vk11MWdXSVky?=
 =?utf-8?B?MkNzU0htaXRwR2puc0lKQS9UdDVxbi9DdnNaeUtaUEpNdW1KeGh3cHZRQkoy?=
 =?utf-8?B?U01UamhUUytnK1dKcDI0Znc2bC9JVjJaQStFNzlsdzFmL21YdzNkZ1F4ZnJK?=
 =?utf-8?B?T1pSdTZsYkc0UlhVOWU0U3lPT2hWZkR1NDN4blJHSlIwVFh4TW9mWmdYZjR4?=
 =?utf-8?B?VmR0eVNjVWgzT05mVkNZczk5c2ZCZlhrdXVWYk1BZTM5SDk4SlhlZVRvS3lR?=
 =?utf-8?B?ZkswdHZzcHVYZWF6M1hVb0ZrZnV6NGlmS3FYNnFyRVdOaHRFNWtlOEhoZW84?=
 =?utf-8?B?SlY5ODhHTnh6UkMyc1JuSVVvY2NRbjZxZzVMa1dIVkFWb1ZIeG9EdnNWRGxx?=
 =?utf-8?B?VzF6RWVLcFB4eUJ0akJzRTBsbFpEZzhvYlYvTU1JSjd0dG8rWjg0SUIxTGRY?=
 =?utf-8?B?SFMybU1oSUhxUDExUDdISWFTVCtTM3FDMXB1Z2xvSzIweWZoS2JmajFuVklp?=
 =?utf-8?B?MzRPdlFNaGZhMHdidkVUYmdFUEk5dEZHMHZ1b3lBQStiMzBWdjgyeUpXbmZX?=
 =?utf-8?B?OURKOTM3Q2ZpZVIzbEk2Z2xSOFlEd0UzMXRGNXhyMi84aGc0WnBDR2JjK2t5?=
 =?utf-8?B?TUJSMlBIWWpXUGFUUnk0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFlnQ2lJd1VZUzdQTzR3K21YUnNTOTgwS216YzY1OS9zTEJnNGVodVBpSVJp?=
 =?utf-8?B?SXErbDlWUXl5ZDZibURDS0RkMUJWbTN1NS9JbkZoZG9wWWQ0TTR3ZzM4dGpn?=
 =?utf-8?B?QUduODMrbVI4UkRJTVZaWGFST1dDNnl1RWFJcSs3UWVtMnBlVVNSbGVUK3gr?=
 =?utf-8?B?Q2dkeEdJWVRTSXBxMnJPRC9yajQ1ZVNWRSt4UG1Td0R0ZFBvQnltdSt4NGUz?=
 =?utf-8?B?OVVvMnBYK1hudExYblJuaWNsQzlQZmxldEZCUkRIOU9DOUFmYjVWK0xsMUxK?=
 =?utf-8?B?Ky9FMzg3K3Y3NmUzUWJLaUJpZ1pIb3NmeEdMeE1WL0FyZk4yeXRrbjBVNFFZ?=
 =?utf-8?B?eUlzMkxKSW1JZ2Q0UFVucG9PMHVrblVkT2hsRGFoTzdSVUNzd1FNU3VGSHZH?=
 =?utf-8?B?TWZlSHpLRDRqREs1Ujk4ZXdFRmZmUXlyYnNEaE5UdWhaSmR1dERtSEpKYjJu?=
 =?utf-8?B?SWFwYVFEYnhteTFsRkpYT0JRUGwxUHdZNHArOEtERWpJcG1NK1hzaEdzV0VE?=
 =?utf-8?B?L25rOWFuNFVLK0hKSU5BS0NhOHh2OHRabHprM05iaFU2bWRIdW9ENXh0blBj?=
 =?utf-8?B?R1o5UzZSZkk2WVNYRmppTHhpWFpNdUVmV2lIK3JWemxnU3NxL2Zod1VpK2tu?=
 =?utf-8?B?dlI2WXJ6amRIZUIra3Y4TmljWVFnb285cW9teXIvazBqZ0pkaXBxb1h3VmIv?=
 =?utf-8?B?Z3NET2hhQm8vV01XdjdCSDA4SWNrbVVlZDBTcFRGbWlmSXQyZXRaWHFPNWlS?=
 =?utf-8?B?SWVOMmsvakp1aWZqdThBdzErT1lvMDBVblczczRJNnM5RHF5SUxlcU9uL3ZX?=
 =?utf-8?B?K00yMGtCMFpOVWZGSFkzRVpzQ08xWUFLZmtwRHJyMlo4OVBOSm02U3dkZWRB?=
 =?utf-8?B?YmpGNHZBYXlreDM4NStYU0FleThmVC9KUjV2dmlhTHpldUFLMk5hYUlsUis1?=
 =?utf-8?B?WHpvOVFtRnlkV1FlQm05Z3pMNWZkOFM3d0VLelRRSUxtTlA3bWtIanlLbzQz?=
 =?utf-8?B?NFlzVmFNQTZUaWxtNitscktnVWVQMVJrMmRMZmt4WGYvak5BUmoyZkVjT3ZZ?=
 =?utf-8?B?UGJmb3B3amdxTmc5b3NyUW9kQ0ZNRHNkZ25FblF6Q24xQmg4QzMyTG9oN0FF?=
 =?utf-8?B?MytiU0xpbTduT1BlWmltdVBLWFpoTWx5TFIzM1h3YVpUZmV4dVl5RU12eTJ2?=
 =?utf-8?B?Z3Q0ZTJGYlR6L1F0Z2pNQUVrWTR6WGlBQjVUZlJHR2NXeWxoMlNFTVdhUCsw?=
 =?utf-8?B?RmpBTG9xMTl0WVNUY0ZZOVo2cGhMOEJtTFpTeTJ0VkxEaDFhZHpubU5RQ2Qw?=
 =?utf-8?B?VjRkSnBpY3d6ZWJYWDJNVW5JMWhrdnVCdENxRlRONHNBUzMrbGVreko2VTFz?=
 =?utf-8?B?UERuWE41NHVtSElMWUxxaGd6NGhaR2tYRTNOdE5xR3NmdG1ydWtKYmcreU92?=
 =?utf-8?B?SGhPMmRRSkUra0kwaGtBbWZWL09VcXdJMisrLzFPanZ6aVZaaG9qcTIyY0U4?=
 =?utf-8?B?cDM3Um5Wem15ZENkcmpLWGVhdGRkeUdSQ2RDYzY0c2FYMHIvTmxKVWVrZ1Bx?=
 =?utf-8?B?TzFHNUd3V1hkU2VQcVBOenVmZ1pucmZYd2lZUXk0VExiRk5BWXVCY1E1d2Nm?=
 =?utf-8?B?dzNtSnZPQ3V3MlBYZGREN3J1eXBaNVk4T1EvZjI3R2pKMTI2aWVjMUpIZ2lx?=
 =?utf-8?B?NUtlbmdlLzFocWFCSXlvc0NLbkJtOHRHdWdKZ2kyVVQ2V05FVXd4ZmRjRVpQ?=
 =?utf-8?B?QS9hbFNjL1FnMVhUVWdMTm84OFE2UCtiVVRabUw0MEM5TmVhaXdhQStoVlVF?=
 =?utf-8?B?Vzg5ZmZTMmNXL1ZXS2hwU0N1MkwwYndpenZvWkdsMjMwUnNGWU9sK3ZQMXdR?=
 =?utf-8?B?R1dFbUljVWdKWHd3YTh3Q2J2OG83SHd6dmhEaGxkRWJUSGozNUhIMUFQaWRm?=
 =?utf-8?B?VzRVMTZzTDdYZ0phTnVRN1A4Yy84dnJGUGIzUUdud1VFM3lkVFlhbGRGQTR1?=
 =?utf-8?B?NlJGT0FCNkNHSUhvblE2Nnlxek1pK2svMHExR2tDZzg4Mm4wZWhDZWNDcFZt?=
 =?utf-8?B?N01VTW9uTFNmWDBzRDUvcGRCR3R3NDFNTmRhOXRia1VvRnRLblpVUXN6NmFI?=
 =?utf-8?B?UzQ0cDFISmorZUZXNldRZTJEc2RWSDM3eFJtRCs1YXVXcEZnWWpCMDFveGZj?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 327c1e61-3a49-4fe5-6309-08dc9f761c06
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 17:48:00.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHuHi39JCXv6mzgEPmo2mztftVQBDaz1DxaCIQ2wMBKtaCWWvolSQaKar/kHLbH+ZVUWRpLbBIZiO8EfequDS39RVpx7mT6NcOMShRAMxhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6145
X-OriginatorOrg: intel.com

Hi James,

On 7/4/24 9:41 AM, James Morse wrote:
> Hi Reinette,
> 
> On 28/06/2024 17:53, Reinette Chatre wrote:
>> On 6/14/24 8:00 AM, James Morse wrote:
>>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>>> resctrl can't be built as a module, and the kernfs helpers are not exported
>>> so this is unlikely to change. MPAM has an error interrupt which indicates
>>> the MPAM driver has gone haywire. Should this occur tasks could run with
>>> the wrong control values, leading to bad performance for impoartant tasks.
>>
>> impoartant -> important
>>
>>> The MPAM driver needs a way to tell resctrl that no further configuration
>>> should be attempted.
>>>
>>> Using resctrl_exit() for this leaves the system in a funny state as
>>> resctrl is still mounted, but cannot be un-mounted because the sysfs
>>> directory that is typically used has been removed. Dave Martin suggests
>>> this may cause systemd trouble in the future as not all filesystems
>>> can be unmounted.
>>>
>>> Add calls to remove all the files and directories in resctrl, and
>>> remove the sysfs_remove_mount_point() call that leaves the system
>>> in a funny state. When triggered, this causes all the resctrl files
>>> to disappear. resctrl can be unmounted, but not mounted again.
> 
>> I am not familiar with these flows so I would like to confirm ...
>> In this scenario the resctrl filesystem will be unregistered, are
>> you saying that it is possible to unmount a filesystem after it has
>> been unregistered?
> 
> Counter-intuitively: yes.
> 
> The rules are described in fs/filesystems.c: We can access the members of the struct
> file_system_type if the list lock is held, or a reference is held to the module. This is
> how /proc/mounts is able to print the filesystem name from struct file_system_type without
> taking the lock - it holds a reference to any module to prevent the structure from being

hmmm ... does this mean I am supposed to find calls to try_module_get() in the flow from
mounts_open_common()?

> freed. Because resctrl can't be built as a module, we can say there is always a reference
> held, and we can never free struct file_system_type.

unregister_filesystem() continues to be called and as I understand in new MPAM usages will be
called during runtime. unregister_filesystem() comments state "Once this function has returned
the &struct file_system_type structure may be freed or reused.". Could you please highlight to me
what gives the confidence of "we can say there is always a reference held"? Could you please
point to me where that reference is obtained that will prevent the structure from being
freed?

Thank you

Reinette


