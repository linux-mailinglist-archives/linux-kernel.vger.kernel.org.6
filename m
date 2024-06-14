Return-Path: <linux-kernel+bounces-214978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649AF908CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6531F276C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6689441;
	Fri, 14 Jun 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpEE6YWH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA90EAD6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373566; cv=fail; b=c5IYTn6/wi9law7G8nu/Vn7WcuXRfPgYxWEFST+d2vtB/UqI71eQTWA+tc2Y8B8jd8fb0fSm8e0lTyz1a2iz3QgHS0sBL9LW7bS3C4ddH6sAcSbJZyuyEMQTfTo/pm4uqiY43KJi1oqou8SJ0fv0nhwz6o26QQ7v1EjLd4gSYXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373566; c=relaxed/simple;
	bh=mb2nTatnMyeMBc8uLKkd0pNsG8ZE3L0vRkuErbvtmPU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QYyQq/hPKQ0UZB+1r9xrWjygElvI8W0ANSubC+jsE53LDysmdRFeQwK33tjt8UV0iQSEh7dcriLbpW2TT6+IBq3Bz58zMGwiCurxkd6/meYyvI3Xtqic0bgkyVQgNgaet0yn5pvCAD9Yfycxev3GvtU8IO2iTHLRhC1wEvwfs4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpEE6YWH; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718373566; x=1749909566;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mb2nTatnMyeMBc8uLKkd0pNsG8ZE3L0vRkuErbvtmPU=;
  b=HpEE6YWHDSqsWc6Mi/O9rDMjXRywEW/cIsxDVTlrLvzcGJDA03THnAtY
   1fvpwr/oymnY3J8bF2Bq7J4orX9DReLGjc/X/f70SmJ3NwoWtmEWLUpKJ
   d+RlPW+IEOdz60ucPyc2d3Ssjp4M+Ei8ffvnbXxaKELqevEDQftOLvLYs
   Zl8NoL6VkuKh+J3NwnJkleUIB8p9e7pC8dZZf06pjpTIf2cdG17oE1NBP
   qOJN3Gunio/dqGAb9W8rMatvTOQMb3L7f7ubg0QmFGAossd0Heln9z8tC
   Dg/4aQLhpNuzOWSxD6bNq1dqPRElD5oWorAjZxtwlIZtEB8H4fTrbGT9v
   w==;
X-CSE-ConnectionGUID: P1lYSxwSRWGKciEu8tJLWg==
X-CSE-MsgGUID: ihUZtZjWSDGz13srV6p0JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15383868"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15383868"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:59:24 -0700
X-CSE-ConnectionGUID: Zup//hLcQouef1df8juXEw==
X-CSE-MsgGUID: ozA/btU6QzWF/ZzCD2geIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="41014605"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 06:59:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 06:59:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 06:59:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 06:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx6qVzJd6kw0h39iJ0X7bDMGmbjzAp7BX1PPWnIiefhJaM7hIZctUTXpA02KbmKv31IekLaDSAMuVqyn/K1xRGN0QAObR9Ft/I+1qGdvVTQQTQjuRhTyP1cf2CcTYxsU+Mr510WpwUasXxDZq/qDlaUkwQn4re7bxsKHfsyfG3P9kNu6Qv+jEps6XSwqcQrsbuZsHdA5KCbG8Q5J5tXTdPmBPiv40PzhM/E60/LqrTGoxqrW9tdBKGj2Fihm2SuJ/zV68iwFYVc/zOwk1EbQ617nYmJe1kncZTKZPVqXq8NRGG5wyL5SQLY2+FUve9uZuJRjfCMcWAMP7ri+bmm55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqpziNeItzbNmKA46l9OUAG+BB0TvDMr/Lcu9CTKjrc=;
 b=ZjBCmd332YVlEIcNvrZNhy8EfE7apBJ3wRSbmPhYsjrplSpewJpmjE54hfPVnrMuW8zANbDAp4EJ8aBXtIE/9nEY1yEbR2QvjElF4lMOfweZ3BzXu1vUXGGaOUBpbv6gIFsMTNJP11gk4SK6xw0nRn/zF/yRw664O1NuncaplEL2tp0X18R8aWSk/tEWojEGiTyhHU0QdDNFhXsPXzuVgm0mESAMDEdbY/zq9sUyPaIDrKqiapol/zmpc38p5QflodtJJoQNPwzxGQXQPnTvYFlk+/6KNBKbxjLnogKAc3Qpvg+unPc440ZVhHhlaoEsMXrkSA2f5WMgqnd1W4W6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 13:59:20 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::3a48:8c93:a074:a69b%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 13:59:20 +0000
Message-ID: <7c223157-3e82-4cf8-aec7-4a7dd6e32d76@intel.com>
Date: Fri, 14 Jun 2024 15:59:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idle: Remove stale RCU comment
To: Christian Loehle <christian.loehle@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot
	<vincent.guittot@linaro.org>
References: <5b936388-47df-4050-9229-6617a6c2bba5@arm.com>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <5b936388-47df-4050-9229-6617a6c2bba5@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::39) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|PH0PR11MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0559c4-e163-4e54-fb2a-08dc8c7a3062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVNBQ3BpSjZuVU9ycmFRb0VvOWt2LzVMTi9jSmN4bHhpUDRsenBjbDd0N2Y0?=
 =?utf-8?B?MFJycitJaytiNHJVOWpRUlF1eS9yOVlvY253YjhHam1PQVFock1aR09kUHJ1?=
 =?utf-8?B?SUl0bFEwNk9mSGNHMkNGVGRPMmQ0dlcvdnM0RHl6WFZxajRhQkdjdDZIQ1Fp?=
 =?utf-8?B?WU5VaHJsbTh0Y0o3RUROczNCRlJRR1FhOEpSTnFzNjBqdTU2U2xRUTlkRURF?=
 =?utf-8?B?czgraFBuRG9MNmoxV3ZhUUJCTTM0UHVuRHIzSHVwN1hJZ2VjWWx5aTNBcUVB?=
 =?utf-8?B?Nkk2Uk9Vd1cwSkxIOFE0bmx5Rk5hbDJDOXlodk5SMTNyR3BLaTdJVkU1WEtM?=
 =?utf-8?B?bHVFRVFjRXUzVVpWU08xWUY5aU5YMk5MOGhqQm5LcU5vNG9JQ1c1cTlPVENP?=
 =?utf-8?B?N0pKVkgwaUNNYVpBcFdMM0paS1dOYkFxK1ltcGJwdHdEeTBHcjZaZ0hIYWZ3?=
 =?utf-8?B?WGwzeW1wSWJEb3FmODNZRzU2eXVSeW5QOWRWMnJhbHUyMUhUQkZNUWdUL2xZ?=
 =?utf-8?B?NHlpR2VLM21ZSkhteStvUVBUaUJZck93TGs4MFFlU0VyMGZGNnVHS3lhS0tK?=
 =?utf-8?B?ZzJ4TzVPSjhET2VPTjZ3NVAyWjRsL25YaHZXWEN4MFA5KzJ1djE5UnY0ZE5v?=
 =?utf-8?B?R2ZwNkJqREpBcGhJeGEvRVBhM1FhdmhJNitORzZVQWJPZlJ0cHE2Z2k1UHZV?=
 =?utf-8?B?WlhmNjgyTS9wWDB2ak1kSEtCczd1ZmhhOVlkNU5UODhzMUNBcGlMekNOSUtE?=
 =?utf-8?B?YjY3S01XS0gzK2QwZldkeGd3N1gwOTZwUmRraFRxdmFzc0RzeDQxU3pqc1NL?=
 =?utf-8?B?bzdVbGJySWpHRHl5ZEkycU13VUNIYU5qVUJMQ2NLc1dGVTlxdmozQ05OYkdT?=
 =?utf-8?B?Q3VVSks5UnZrZE9qRXhSdHEwWDFIUWpIbWN4elFVMDZlaXFqNU11ZElIM2Jp?=
 =?utf-8?B?SEJKOGxWU3NZdEtPcThFcVoreTdocFdLbVNZWkNwRlBYTXdZT2hxRitGQnVt?=
 =?utf-8?B?aDFMSUR5ZktCWDJQUTVNU3dYWDNsSlJDQUNwak1aQ2ZQUHVUbkFYeWZNeWw1?=
 =?utf-8?B?YjliYVZwdTMvMGhNN0NSUDdsdytMUHRLM2p3Nk9QL1NWUEhzWnhIV2N3dGZo?=
 =?utf-8?B?a2c2MTUvK2RzWHh6TEU2NFF2S2F5dXdFalQzdTAwcmx6MFRGczBzeG01OEJT?=
 =?utf-8?B?NWpoQmlpdXpKKzlLYWZWWlFsSUhPWm9QWjNkWGdKRU15eVFXRmJINXpxNDVM?=
 =?utf-8?B?ZUdJNG5EMy9Kb2tmZnVIRWgrdTB3TGVHV1huZXdqSVVqdWNHWUVQOUE0YXEw?=
 =?utf-8?B?K3lUbGhFbW8rZG5mUXFTUGJJMzJZbExEK2lwNGVyYXZKSFZjcTFkbTVTM0FW?=
 =?utf-8?B?VWxRL2o2S2hqNHhkQWsrcWxJQjZBZnUxRDFRTnQ5MUlsckpOT1JieWdTS0dr?=
 =?utf-8?B?ODY0YUR5QmlDdUdMWGxLSXBJaE1rQ2IvZm43YzE2SURnOTVjVUVJN3kzWDU1?=
 =?utf-8?B?M1VmbUZqWTRpZkg1TFBreFNidjZ1TS9CTEtJNDRxcDF6QjdOSnBCTUpsSTFH?=
 =?utf-8?B?SitPZnhkeEhUSk5nOFU2M0l2M1N2eDlaNXIyUkgwWUNsb3BOTDRyUUNUU1F0?=
 =?utf-8?B?TW1xenpwNUtHeUpZV25mNGNadGN4VVJKVE96b1pMamxsY3Q0dnlFYkN0REdz?=
 =?utf-8?B?aEY1eERzMjA4dWFrYXBMbDNJb21nS25tTytUY2NtK3VjcTBZbVM1SnlVdUdY?=
 =?utf-8?Q?asHgqiR+9ylUHv5o6Bhktj0mIFHmvu2kE+6lAL3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nys4MHhDQVJiT3lwNHdtUGo5SjdqRklzYlJRTCtmOGhycmR2MjBvZEhnZHB2?=
 =?utf-8?B?ZTdrZEtXck9iUVRMeU9FWldleUhONjZKNmNTdXFQSTRiUVFBMFBvMzBabGpo?=
 =?utf-8?B?bkJLNGxZWTBEMzZmWHdtSEQyZWozRHp4TVhQNFhtNGJHVmZlM0FhRCtUaERr?=
 =?utf-8?B?SkpObnNGamZTSC8wR2JnR2N4VTBEVVVRMDdnbjZmbi9RMjBmcHdibUR6R211?=
 =?utf-8?B?T0NkOGVDb0VUejZ5emJ2WDVqNEVxNytFR1pCU0tNK0NEcWNYeVhhZ0NyR3Rq?=
 =?utf-8?B?eno1cFVwbmJHYWxJbDQwcUxCcmlTaUZBT3BHSFJ5NUdGYzEyN0FST0tVdlMz?=
 =?utf-8?B?S2l5VWVVVWJNK1NoeXNzYUxQTVdmbC9mYXZZUytmNEhFdFRlVGhpYys0aFFk?=
 =?utf-8?B?ZjJIMTJ1VDFidVJnNTRrQlBwQnRPMkRaYXRnaENHeXo4MzB0Y29oRDNUd0N0?=
 =?utf-8?B?cStVazJYeFZSR2U0RFhLMWZXWXRkcHV6Ukc2bFlYODJHVU13MmdYMzYrMWtF?=
 =?utf-8?B?RUhoZjlVSzVFbWtGTEdrRUhYMkFnRTJXSUpGWlBacDVPNjM1dVpaSHVUbHBO?=
 =?utf-8?B?T1hFbHBtVnFCWXBVbTlxaDNqNEtSeXZ1ZnN6eE1QSy8rbFJJUGJQT0diYlBm?=
 =?utf-8?B?M2loWW9jV2pMTXdrZ2FQLyt1bWxIa2Q3NiszZm9BdkdkOEcyREVxWGpySXJ2?=
 =?utf-8?B?ZXhNc2dzQm9GZFBJZGZlSGo5UDdrdFV1Z1lWSU16Wi9zNTcrREZFQzhJM2ww?=
 =?utf-8?B?dTNrVjl1Z0Z5NU1hU3hVbnYrQkFiVmpxRVlZdm5OK1ZnWXpMaXgwMGtvRTJT?=
 =?utf-8?B?YmRxaGp3WGhPRTN6MEJMS1hmZGtHT0NuTGFuMGdHTG04c1JRbGJMbnJpdTBy?=
 =?utf-8?B?Z09vdHhNOFZUSHVGQUZ5WUNGOCtiWWtlY0hyaW5LR1J4aGFLTlVPUUx5cy9X?=
 =?utf-8?B?MlZwaE5UQVNLaERjZnpqT1VFSnpNditMRWtrcDJxZ3Evc3VKZmRidElmU3Nk?=
 =?utf-8?B?WUZHN2EzOWV2eUN6Y1MyVkRxMys5MG50dVh5OFJzQnhvSUp3RUFwaWpDbCt5?=
 =?utf-8?B?L1Z4VEU2cVJTS3lIbzZoaEs3cXYwTlVnQmhhZkFZQks5RnBJZ0w2UFpneUFh?=
 =?utf-8?B?UWhDb29tazNvMmRhSHNRYUdpRUJtMmFua3ZpZnZSZ0kwRnNBMUJVWUNndzh4?=
 =?utf-8?B?ejFIMVFVREg3eFpwWHFqQUx1b1E4RG1aZnpVcGd3MkRuVzFnNXNNVlRFYkZV?=
 =?utf-8?B?RnBmck4wSm9GNzFUZEJHOVNUSHVaclk1SHNmL2FMUENHeXJMV2Q2Z3JGcU9l?=
 =?utf-8?B?c3dXTk1HVTlFN1I3Nk1tcjZaTEdGNEJaRjBnZFBOR3FtYWxvcjRmb1J3R29q?=
 =?utf-8?B?Rm1NZ3dsN3FRcUdRSWFlM0Z2RzJiemJSV0t6ckd3L1FyQ3lyb0h6UUQ2T0Nh?=
 =?utf-8?B?UTJjUEN4dm9DMFJob3o2cHlMeFM4bDgxZ3dkY2ZpT0FyZ3FHZWYvZkUvK1Vh?=
 =?utf-8?B?UkNKRkJZUUpjczNad0oyR29iNzd1K2t0ZWNHVDZ0QUhBUmpGNlhoc25TZ09p?=
 =?utf-8?B?Uk5LMUVMb3pyZXNXeU9LV2IyeFkyY2oxMkhXeGJZUjFHOVZKZlAzZ0JnUVM4?=
 =?utf-8?B?Y2VUS3ZPMFI2MzVEcXZnb05vcXhpMncrVFBOZW9QeVZjMFBoaFNKckFNNjZh?=
 =?utf-8?B?SjRKYUlWcmxDK2VVZFZGM0krQ01pQnFzUHR6NEpyeEZxYm5ndWRzTEYzYnF5?=
 =?utf-8?B?UVh3ZXJKVkNxR2wvcUFCaXF5WTBYSlNIc3V1MWJJY0RWM0hYb1JpOTNTUE9w?=
 =?utf-8?B?cEk3Y0h1aWZkYlpWZjUvZ1BJUFF0UzFId0J6SFlWcUJmLzlwTWRZbHFLODhO?=
 =?utf-8?B?YlZQOFpyU1o2UmZFdmNzaHlodWdzUkxYcUpsYmJvYzVsYmRXYnAweXNTUHo1?=
 =?utf-8?B?dUtFQzdYVXBNK2toRTlOdG1IVFNSVHp4R3hsYnExaW11L05EN0Z0K2VncXQr?=
 =?utf-8?B?c0xuNVgwOTBIdytwT2l6WEZWVkR4bkxHR1F6Yml3SVdmSlF4QjlLcERFc0ZJ?=
 =?utf-8?B?NlBWeDhSaWNrSmtleDlWVGw1aUQzQlB1enlkVGxaamkwRDhUQ2x4ZVB6aUVG?=
 =?utf-8?B?Z3RGdnpQZ0dPNXZhUzBHTXYxVGhUdEI4M3MxV2JnVjFTa1c2RWFUL2Fpa2ZJ?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0559c4-e163-4e54-fb2a-08dc8c7a3062
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 13:59:20.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQBYARH+akHG6M7mroBPbAH9/WwwVNqrkYyseyj6PNeziTbN7me/6Ck3lCdRW79fn8Iv3eZvOiFdYB4lwZCk8Ungt90NdyV5Yodc3I8lTSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-OriginatorOrg: intel.com

On 6/3/2024 5:30 PM, Christian Loehle wrote:
> The call of rcu_idle_enter() from within cpuidle_idle_call() was
> removed in commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle deeper
> into the idle path") which makes the comment out of place.
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>   kernel/sched/idle.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 6135fbe83d68..3cc1a592d9a1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -179,12 +179,6 @@ static void cpuidle_idle_call(void)
>   		return;
>   	}
>   
> -	/*
> -	 * The RCU framework needs to be told that we are entering an idle
> -	 * section, so no more rcu read side critical sections and one more
> -	 * step to the grace period
> -	 */
> -
>   	if (cpuidle_not_available(drv, dev)) {
>   		tick_nohz_idle_stop_tick();
>   

