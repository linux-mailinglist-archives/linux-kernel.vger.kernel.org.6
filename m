Return-Path: <linux-kernel+bounces-430487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3029E3186
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BB1CB22E80
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0437082C;
	Wed,  4 Dec 2024 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwT75Ivv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB13EEB5;
	Wed,  4 Dec 2024 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280291; cv=fail; b=AnqITbhtA35Sm970EGqEoY+CaYlOXDfKYNlU94cNmw5CLP34hQO7T9SPrYTZxzmbM0GmUmU2q9RjhN0zifbw7/5rcPrA26+E7hatz09zBqB5EGOdSQTBlSaRv3NxAs5VzkHDbtfYxH6B4XKJMlDtnfNctnIIyOlPGjd2RIuv1lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280291; c=relaxed/simple;
	bh=4p5XX1/OE5tEPWSoV+0aGmh1oMq+RKylZCh6Wpr7s3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i6Z2JaHVlv1kVLwsismzo+2+H7igOC6f+JDPiqWE7dtviLieqmsTD+Xtt9ew0hc9u2kkecwl+9KY9kUP01K7GEyttwATf2WUNb34h5eVkdpFFzzb8fsvzS/ciHR4ng/l0EftwOZQtSW6pShb1oSZNR5VzXqnpBI6VF4b6YR4ItM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwT75Ivv; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733280289; x=1764816289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4p5XX1/OE5tEPWSoV+0aGmh1oMq+RKylZCh6Wpr7s3c=;
  b=iwT75IvvbAO0wuWIVuVDOxTKKHlhm5dzU1ecPuNxN8RvreuYUAfVXlrJ
   rUGh9EMf9/X8WkU+G6MBsuvG4tiJnpCSoY52wzdRsT150BK2ZL//zunnJ
   JkwDfner5AGIL/52zS/eZIe2fJIz9nQ3uwJRU2JRa9S7BFw3yg5Fh1m4B
   /N/VisRPqdjiSzrlqP0Hsj7OamV4JowbDy2/mZXj9Zgj3fFOa3hlWkROQ
   4ZDq3f7XHW9E/DAG4q21ZLwmb4rllFkTjKCaffQyzo3uw7sChFTRrhUw4
   lJO4wLB+CoDVXSLAG4ZZ2ErI26huwNUZ5Xzk+mKUjszoZWlYMjW2VYL/m
   Q==;
X-CSE-ConnectionGUID: YgDIPNSPRCSAK8+JsHH8xQ==
X-CSE-MsgGUID: /CN4WWg/Td6S0rBIXfkdGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33449896"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33449896"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 18:44:49 -0800
X-CSE-ConnectionGUID: WA/Ob/YoR92TrMZ+QmbPTg==
X-CSE-MsgGUID: R4P3sONJR5aQEVjaA8i/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98638975"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 18:44:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 18:44:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 18:44:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 18:44:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoDbDtgrBWiShLDIVkXDBVdOJJhgtH6lT1mcoInlgZ/GFqWnzp7YQ/d0iWru8BtXOgm8nE78jlJRNIw4eQImjTJLNSTYQLwihrriA+zNq3aXPIlp8bpTxNEI48/JnbjZJQdyKzowiFpsb5k0N6EjQ32z5Z9HnAQsG+r+TZxskH14ddIl98lW6JjcSrtH0XhJlxiKqsHsTHkGsVCi602KFkxVQBF5xKFrpbgBYj2YeiJX8hBAJ5Hdd/Xe31nfsV4MXvfGOjFelnWvaaNboyaoRbOyJKXKYR6ck9F+CZFuRr9oHqUH2k+nGS8NvGugDdbd3hygurySU+BBanF2R31gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p5XX1/OE5tEPWSoV+0aGmh1oMq+RKylZCh6Wpr7s3c=;
 b=r43lpigi68BG5fjrujq8C7Sa0x53zFKaHzX3jVxXoFY5gd/Y8mvNbjhB7NAJ4SjYtScs4NqDxdWs0q6qWSCITtY61VGDhRv3EqD0Qp/MAwhW6lca3ns0wEUaK9LdWb0jU9zwquRwdXKeCqFtUmnVS74/lCg4GFbgKyZBfBkf/z+BVScFLRDleVs31ybiB5yMyld7pJrYY2pVwKDK3EZzFk9C8H7mWPUuJ0eID1Q49LsgAIxTBB91NPVx7GsdoRyi+8R+flViiOlMR0+WevZxVgbSLbDsElIzLHC32KR5GdmB29D48RERItMGSxvQIzQMLTXLkLoT69fUP5e2dLz2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by CH3PR11MB8442.namprd11.prod.outlook.com (2603:10b6:610:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 02:44:38 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 02:44:38 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>
Subject: RE: [PATCH v2 07/14] Soundwire: stream: program BUSCLOCK_SCALE
Thread-Topic: [PATCH v2 07/14] Soundwire: stream: program BUSCLOCK_SCALE
Thread-Index: AQHbRYXlBFnSg984e02tPPVLPhqSLrLUieWAgADXveA=
Date: Wed, 4 Dec 2024 02:44:38 +0000
Message-ID: <SJ2PR11MB842427417C7E659B2127B905FF372@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20241203131813.58454-1-yung-chuan.liao@linux.intel.com>
 <20241203131813.58454-8-yung-chuan.liao@linux.intel.com>
 <e888ffb4-90a6-41d4-b081-e084b09b3780@opensource.cirrus.com>
In-Reply-To: <e888ffb4-90a6-41d4-b081-e084b09b3780@opensource.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|CH3PR11MB8442:EE_
x-ms-office365-filtering-correlation-id: 5c03f14d-be79-4213-f873-08dd140d98b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFQ3TFVLbHdIeHpTWU1uTldwVkR3WXNUUCt5Y240L2R3eFIrWDhkTUdLU285?=
 =?utf-8?B?RjVlS08vUUpRVDB6bjhJa0RkbE1LalJRSjFtZTZQVlRMN2F5N3NvUUlMTGNT?=
 =?utf-8?B?T3FyRHFjcEdUdDlFbHF4S3J5dkNIcUVoMkxWZmNOa2NGSWNPR0g0ZHltZEx1?=
 =?utf-8?B?WGlzajU3MXNRUFhsR2Vjdng5MjF5cVllS1ZLVUVDRE92eUpBZ2RBbVZxa0hB?=
 =?utf-8?B?YlRQZkVtcFZMVjczdDNWRmlwN2ZMdHRtUHR0aVRWSmJhUm53MnJlWGp6SHVB?=
 =?utf-8?B?ZmhzaVVKOXcyRkdmN2EvclE2S0xIb05oUFp1clEvdFpRd05PSXhvTGVMWC9B?=
 =?utf-8?B?RDBFejJ2Wmg0R3hWejBCVEJyenR2QUdQSHh4NEd3SGdUb1NrQ2x1RllXUnpk?=
 =?utf-8?B?MHg1eXIzTWxpQjlxV3llVXlqU1d5VUxpcFlXaWZQUzB5T3RoU0JRUXZhQW9W?=
 =?utf-8?B?SldaUFJUdnFCWHBwcFkxWVI5cUZqNG9BRi94bGUzQWg3MFpmS21DaXowQ1Vw?=
 =?utf-8?B?bStzZTl3ZS9CVTFNYkFFMWVmb21mNGNLL25GQ1ZsU2hKK01XL2swK2tWakxw?=
 =?utf-8?B?cW16cWRHNVFFYThQTjhOUVJpR2tJeDBRS29tS21kSlByaGI3dnRJdUhJU3NH?=
 =?utf-8?B?TTYvTEUwWi81SUdDU2hiNDRaMExrbUhZRFo1aGNlRUlXN1d4dk1zQ1FQL0k5?=
 =?utf-8?B?SzVpcEh5V2pQb09XVjVkclJJR0grbmJUSmZaUXllb0pPQmxBR0I0ekpYb0hV?=
 =?utf-8?B?czB3bVhTYmVCUUxuNVFnYndhL3IzWTNlQVlIeEI2UlhXWCtGU0Rmd2RROHBT?=
 =?utf-8?B?eWczbVIyTk9IY0c2cEpVcWFsR1o3Ymw1T1JJL0wxKzRqMzI5UlkvT1BkMllz?=
 =?utf-8?B?bERlTG96ZzhUN0xsU0VkaXltNG1LUXg1ZVVUZnJlQTlGL1NiWFhFVUhTelhU?=
 =?utf-8?B?SDRLbXNFZTA4bHRuTFdCYnFzeEhmZG9Wa0xYaHliRCtPWU40TTVUNkFCVHRS?=
 =?utf-8?B?VERFbkZrdWpDRFJiSTQyNHZsVUZIRGllVm1wd2liaDVCdEprT082YTN5WW1G?=
 =?utf-8?B?b2lSQ0l3dFdBUnRzS1hibU5QMzl0bUFjZHJJTFFaT21yM3poS0JRRlZDY21J?=
 =?utf-8?B?eXFlMkJNTEdRQUJnSWpNendBZEo4UXdWSlVhMnhVOUxONGFCTWczUFJROFJz?=
 =?utf-8?B?UU8wc01yc0VnbDdPNjFPMFJwMCsvQWxqWWVCYVJKTmdWN3pzZ1dDY05HZUd2?=
 =?utf-8?B?bmVsbXBrMTc0K3hrTXJjVnl3N1pxOWt4cmRWbDZsMHJSeWMrM3VFNjJIY0dr?=
 =?utf-8?B?MS82THdUOWQrOWVzU2hBV2tqOExUcXZpYjU5NjVBY1BXV3UwSy9HYWRLYTla?=
 =?utf-8?B?TEU3MFFkb3ZEYUErMUlNMnV4Z0tlbk5XM2VQWVRwT3oxTmZ6SGJmZEx3ZWRN?=
 =?utf-8?B?dDVoc0NlLzFmcS9SWHlFQTBSdDE0NGRWSUVGOGY0am10ZmtrZmJINXFka0xJ?=
 =?utf-8?B?T29SOU5CRlBNNElRWHN6dnhvbTNiVmdYbWVUUlZaaWhCb1dSb2MvZ1dBSGda?=
 =?utf-8?B?SDVuNFp2bzZPQ0pWYW5ObExTNVhHTGk1aER6cUtZVHVhblB4d0R6TmxBM3p1?=
 =?utf-8?B?V1RpQ284eWY0V1cwaGtOVlk3RGN5eHVuWFQ2OEtqUVZCeVhoOVpHQXkzQ3B2?=
 =?utf-8?B?dnFRK2Jhb1YyZjNpWURzOW9WWnNOSVY4V2l3amVoc09meE9VSnBmSkEwWmpw?=
 =?utf-8?B?ZDZ3RE1zM250d0kzNndOWHRTSlFiWWRYWWFaM0JWME4zWmdoeHppY0h4Qzcx?=
 =?utf-8?B?UDF2cVBtQ0p1b0h6S3AvNEtJcU1XZ0NuazM3Qk9KVlB4UENKcmV3RndCakM0?=
 =?utf-8?B?RGJpNlZ6dmMwM1FLc011RnBXV01GcjVBaXdqQUl6YkswYUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmhXQXRyazQwYnZiWEpqcmNWY1BNOHF2eXM2YjdDTXhlcGQ2M2dabmFLVnhu?=
 =?utf-8?B?eTBtNmRaano3WU5nVzQ5TWFKblU0Rm4yKzJIcXhQT3EzeUt3YmF5b1VkYURD?=
 =?utf-8?B?eXIxREhqdGN2Sy92NnFxbnFjUHkxc1p1aHJzcmpTR3JVdEFuWTVqT0JxZTNL?=
 =?utf-8?B?OFJhdVgwUnBGMHdNZDJ3NEdUd0pCZk9MamJzMXRpNnRhc0pFbkNNYUpDYWVO?=
 =?utf-8?B?RUJvVjFSMXU1MHJBdWJuSjJMSEFNSzlscEFQdXJLcFJ4Z1p5WVZ2YlNncDlu?=
 =?utf-8?B?M0VxZjgraHRjOFJ4Unh3K0lOSjNXYWNCcGtNK0Jmajg3YVozNlpZR2JaZTk5?=
 =?utf-8?B?SEtpU0RpSDFwbVEwclFPVElXbVhnS2pSMWcwcEI3bHhnNHAyc3M5V2Roc3dq?=
 =?utf-8?B?YlF3TzgrdEhJd2x1WjhYVitNbVEyeEZ3cHJRdFRvVWhpSFZVcVNhb0xNZzNk?=
 =?utf-8?B?QnhBV3VUdjhLOWd4Qnh0SnZyek83WGxoSW05SEtNV1JZbXYvN01iM3BrMUF6?=
 =?utf-8?B?cVdhNDhXMmdMVm5lTUdTcVFFZThVc203TllqMW9jejQwNzJNN3hqM3BVc2Fj?=
 =?utf-8?B?K1FsdkFEYVpGU0x6UVdKWGRSUFIxVlJOd29NazhWa01HL201dm1QUGgxZWhh?=
 =?utf-8?B?Y3NNN0tEM3dmT3FGdk5rSDhJM3F2Kzc3WXlPTllhY3V2bjJLV0M2QUJibVBx?=
 =?utf-8?B?dW5IRHFjek1XVU92dUQwUGZGYlc3L3FYczdibTBqZXRxaTNzYlpyS2hLUVJ5?=
 =?utf-8?B?OFNYT0ZlVHJBTWRFSU16ZUFycGVMV1BlTWMvdHJCY09hZFBaOXUrWFRuMExt?=
 =?utf-8?B?NVZvQlJoN0NraExJSEdhZzJLaGtvSmhmSkhHYkpPRDBtOXZabjRDWUUvTDBM?=
 =?utf-8?B?a1NnWGQrbGYzZVIzTVp3bUZzZG4xMENGRjRHQmtqRFlkcUY3NUcySFpCU3dO?=
 =?utf-8?B?RHpJNmxJWVR2TVFTQ2JOVEZlTlJtR245SjNEYWpZZk9KNzVqOEhVeGRhbHFw?=
 =?utf-8?B?SVRRTDNGcVVNc21samx4NEpBVXRHMmhyL0ZKa0JXSkN1Nlp6anhGUEl1K2Nz?=
 =?utf-8?B?ZXY5MWZDK3FvUmVDVHhLOCsvTDFEVVVFbTUzM3V2emVzMlAyWklZTjB0b3Vz?=
 =?utf-8?B?OHhPb3FMQTFCUXgrazZ2bDZMMERORS9rY3R2R0xkTENLWTNmdElCRGVEQldj?=
 =?utf-8?B?ckh4NElXYkxqUFRKZlMwOVhPMmdFeWxZcWRoVkhDMlhBRUtNSU00dFFVNkJW?=
 =?utf-8?B?cW03T08xWkJ3K0d0cVRiRkdCd0tpdDlaTndzOXdIVkRWUC9oa3VIUlVoWFkx?=
 =?utf-8?B?WWlFMExaYTg0b1JCY1NublRNcjRpNzlGc3YrcW9BUlpFRzVaNFVUUlAwZDEr?=
 =?utf-8?B?QUJQZmFRZGV4dXJoQ0MwaFhDaVRuWkJnZm95MzRId0I0RDhQNnp2RVI5Nmg1?=
 =?utf-8?B?RDZlUkozRll3eGxlREF2ZXR6NW9UeUlRY1A2UnRaVlJHVVRUR2IwRkJSQzFa?=
 =?utf-8?B?emtSTU5uVldLTlkvU2VBOWFRZ1ZlQzdRREdoaDRHRlBsbjNzVEJMZC9DdGtC?=
 =?utf-8?B?ck1XZytyYkphU2d3ZXg2TTk1RHNqcDZabEs1Z2pCOVcyRlc1WTByZUk3RWh3?=
 =?utf-8?B?eHlBOGRZVjU5MkFvNXI4bVdvaWF2cUlDbHByaDliQmJiZUFCakV4bHFwVFUz?=
 =?utf-8?B?UWd3aDc0UVUyZ0Jia0VmVVRnUXQwTldUK3dXMGVKTXRXOC9zZ3dUOEczeHRI?=
 =?utf-8?B?RXNMc2RVR3p0ZHlVZlVUcWNYZ2Ewc1kyU3MveFJuVC9WdlVLeElPTDY5SmNJ?=
 =?utf-8?B?S2FRSnJEcWpsZWIxVlZGeEZDK1FZR0tzU2JLamdBMGdHSk5SWW1wVlpCVXRS?=
 =?utf-8?B?cEs0RTRVWDdBVVVwVnB6RGNpMVRjS3czSjdRTlRBSFBteGFqYXlveDJmVlBF?=
 =?utf-8?B?dDI4QURwbXE3Q3lCdkxXODRQUXcwV1BUdUVJN0hsUzdYRVhjcmhrV0ZZd1ZK?=
 =?utf-8?B?cmREQjlHcldCMXk5N1puOW96SC9GbE9RbzE3ekdvN2JZcnlEMElkYnhjOE5r?=
 =?utf-8?B?SS9laVkxNW1iTWRzTDlRZVRIUDJGN2JyWkI5YTl3N0VRa21XdkpUbGcwSElq?=
 =?utf-8?Q?236o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c03f14d-be79-4213-f873-08dd140d98b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 02:44:38.5223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zn36ioJ2Mp+nmnracO0Xrowd5JrKi8AdIDGY/S6okR73ded4Lh9poVLhSOkOjqlS5dXzjEYudg/GE4EMbBifOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8442
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBGaXR6Z2Vy
YWxkIDxyZkBvcGVuc291cmNlLmNpcnJ1cy5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVy
IDMsIDIwMjQgOTo1MiBQTQ0KPiBUbzogQmFyZCBMaWFvIDx5dW5nLWNodWFuLmxpYW9AbGludXgu
aW50ZWwuY29tPjsgbGludXgtDQo+IHNvdW5kQHZnZXIua2VybmVsLm9yZzsgdmtvdWxAa2VybmVs
Lm9yZw0KPiBDYzogdmlub2Qua291bEBsaW5hcm8ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBwaWVycmUtDQo+IGxvdWlzLmJvc3NhcnRAbGludXguZGV2OyBMaWFvLCBCYXJkIDxi
YXJkLmxpYW9AaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA3LzE0XSBTb3Vu
ZHdpcmU6IHN0cmVhbTogcHJvZ3JhbSBCVVNDTE9DS19TQ0FMRQ0KPiANCj4gT24gMy8xMi8yNCAx
MzoxOCwgQmFyZCBMaWFvIHdyb3RlOg0KPiA+IFdlIG5lZWQgdG8gcHJvZ3JhbSBidXMgY2xvY2sg
c2NhbGUgdG8gYWRqdXN0IHRoZSBidXMgY2xvY2sgaWYgY3VycmVudA0KPiA+IGJ1cyBjbG9jayBk
b2Vzbid0IGZpdCB0aGUgYmFuZHdpZHRoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmFyZCBM
aWFvIDx5dW5nLWNodWFuLmxpYW9AbGludXguaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBS
YW5qYW5pIFNyaWRoYXJhbiA8cmFuamFuaS5zcmlkaGFyYW5AbGludXguaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9zb3VuZHdpcmUvYnVzLmMgICAgICAgfCAxMCArKysrKysrKysr
DQo+ID4gICBkcml2ZXJzL3NvdW5kd2lyZS9zdHJlYW0uYyAgICB8IDMyDQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L3NvdW5kd2lyZS9zZHcu
aCB8ICAxICsNCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
IA0KPiBEb2VzIHRoaXMgc3RpbGwgaGF2ZSB0aGUgYnVnIEkgcmVwb3J0ZWQgaGVyZSB0aGF0IGJy
ZWFrcyBvbiBzeXN0ZW1zDQo+IHRoYXQgaGF2ZSBwZXJpcGhlcmFscyBsaXN0ZWQgaW4gQUNQSSB0
aGF0IGRvbid0IHJlYWxseSBleGlzdD8NCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90aGVzb2Zw
cm9qZWN0L2xpbnV4L2lzc3Vlcy81MjU3DQoNClRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoZSBpc3N1
ZS4gSSB3aWxsIGxvb2sgaW50byBpdC4NCg0KDQo=

