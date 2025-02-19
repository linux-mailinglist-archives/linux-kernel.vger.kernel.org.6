Return-Path: <linux-kernel+bounces-520666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6DEA3ACF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB1D1733D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960648F5A;
	Wed, 19 Feb 2025 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAw8bK4a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE363FC2;
	Wed, 19 Feb 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923815; cv=fail; b=nJKsNLp/xy/6kscbIwKNLVjpX0VCf5eKkfCAktKQArleeFesOCq+Py5f8wx1Gx5h3IBzechVX6r00YbbKGKELsOMmp+iNQDcKlI1ox8wOxmdThgPnCxXnpD1UaEqV0XZGczRIvF4P+YnzKmbQfe19szy7AM+ESB8iQMcHKVJPOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923815; c=relaxed/simple;
	bh=u1zDUesmyR5SOk1zbShEIk+xzLlNFPlyI4oE1nBxyOI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iVMYuQ8p4ml99p44SenMu752fIXn/6k6K9KoOve0H63dIs0QpHSRea6N5IcPKg26hsa75Wgbz2cOsADgVzm+G/bK0ZewYQ0aRIo7bauaBNT3YMtA9qNjUvjIbcwgMl29H5W2lnqRTairw3wPFTYQVU/rq0XhN/5NMLhgmF7lnCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAw8bK4a; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739923813; x=1771459813;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u1zDUesmyR5SOk1zbShEIk+xzLlNFPlyI4oE1nBxyOI=;
  b=WAw8bK4aozFJVu9jRlyXnd+gFBsobbLlXhacRVq3lBD/ibnJvZ+CcExd
   TWQHbnK2OVgAeLUYzpGyK+27USyPsBLk4qAGAi6CRObkMFTRBT73+xDwt
   dXonfsPoS0+7bj5nuBKaOmSlK3sTAKKL6qUTlYC2F85q9ySuAWoZpQjz7
   pdmgaVWZReIu08JRuDEDLb5ifcq54CuADDuUXohzS1bfM/efz5WnwU1ok
   FhhhSxIn7VDN7OK2AomnfsSHErMRBivSjcN0EbBA1iiFp2ijDlpau/x0f
   XBXGJSWpUTN5ljoPxNrBDcPfdwBMl43esqlseP0mTe9fr5F5NJai4iXbd
   w==;
X-CSE-ConnectionGUID: Df5DNNSUR3+0B/FOyXpRiw==
X-CSE-MsgGUID: meibsTEbTyqk40xOUdXBPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51286251"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="51286251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 16:10:13 -0800
X-CSE-ConnectionGUID: VM31KMF4QdaH9+Yy7JoJlA==
X-CSE-MsgGUID: VoOLdm5HQfGFJKJ/TDt67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119493060"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 16:10:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 16:10:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 16:10:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 16:10:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCvTx3lPWsejFldTvqIz3ajbNoWTignXnbx4ELowEU8iJpqQ1Tcd/p9W0orSLp4RO6mRcWRUes+qJ+vvO5VLlTIm3uERlNaRg3hvpZa6vrAWh2+diERZXpEZyygJPP78OSaHU6WAk1f1ygi14Q6SHzVZZbssq7jVjBIG1yy7BcyNO3bTahS2VJjdLdw0Sb3ojU1W+ohfN7LJIaBeHctgn99f1Co80a4afuyaN1OHVsTv0Nun4xIiIO2UQlzwnBsoOcU+EEoM3RRxjdSqN3k5STPH5AdpbHQMmJfQQVWVaBUmaOO1UC0SqRghvjgwW/7TsJ1qJXL4eVKFCYvsucRgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//evphwKhZuqE48A+qJRI/kEkVhDjx0NMeXd12bbK1o=;
 b=lD69sEbxURe+cy0crbIVu9NTyPSfSy0Zb0pRLxa31eJzBsU86YTWUi1bnwCixxIJO1DlPw1WNb3vJTCQg5XGR/sB0+r9wykxZP1xkavv3ptDHJ0PJl4u9wRF04lkLe6xQT2W10kY5rezDY6YiPPwP2csNL9az+mpX/fwD3eTDShIfqW2dQE3OMyMOOWJgiZI0aEaVEo0SCI2jNydjlr6sWovjZQ2VE6dxLJrznQZ61x3iHHfVwFkpfsm3ASFUsI+sftnUJygUSnGO6O3mkggj3M2rn0iiaySHyt6yEWEQwILgWMUwNW2l70mTNS9EiEkFt5BPiy+PhAyPtOG1JYGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5758.namprd11.prod.outlook.com (2603:10b6:408:166::18)
 by DM4PR11MB6142.namprd11.prod.outlook.com (2603:10b6:8:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 00:10:08 +0000
Received: from BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::5183:feab:8a06:b19f]) by BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::5183:feab:8a06:b19f%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 00:10:08 +0000
Message-ID: <b5f539d9-8aeb-4272-938c-e3046df9cb50@intel.com>
Date: Tue, 18 Feb 2025 16:10:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] platform/x86: intel: Use *-y instead of *-objs in
 Makefile
To: Kurt Borja <kuurtb@gmail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Ashok Raj <ashok.raj.linux@gmail.com>,
	Tony Luck <tony.luck@intel.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
 <20250218194113.26589-5-kuurtb@gmail.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <20250218194113.26589-5-kuurtb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To BN0PR11MB5758.namprd11.prod.outlook.com
 (2603:10b6:408:166::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5758:EE_|DM4PR11MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 87244ac7-6015-4ac3-6daa-08dd5079c4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWlraFF2djVMQTNENlhucndFcCtXa1I0WmdRbG9LSkdqZVdVaVhRNkp2T1Ji?=
 =?utf-8?B?TFdLd3NGaDc5YlRmcnIyUVd2WlczamxWVWUrK3JYWFVBVmZ1Yy9jZTNjdzlU?=
 =?utf-8?B?YTlRazhKUExnK3pEdHgrdlFrYk56aDduV2NiMVZBNk1qZ1F2Wnl6VEMrOE56?=
 =?utf-8?B?UUdiZGw1VncwMTV5RTZrM3dBOEk0aGI1d3dWMnFidnRrREtnWmdScnhPckRs?=
 =?utf-8?B?c25RbUpPYmFPQ1MrN20rVWtTcStiSkV2eHZYWVFqTFNBeitQV3R5TER0YTc2?=
 =?utf-8?B?TGJER3c1V01tSmEvT1hIci9DbGg4WW9OQ3gzUC9SSXZVdDFyMnhJbWRtcDZB?=
 =?utf-8?B?UFVpaTJXWUlTYUpCYS94YTZWWkpwVkZyWVUwcUNLaUthdEtsVjBtUDV3bXVo?=
 =?utf-8?B?YjFqTk5hUlR1MnFWMWVGaFZhQWdTNDR6UGVDQ1VPOVAwZDRPS0d3OTZJcDls?=
 =?utf-8?B?dThqOFRQc09YWkRNanlNL09TakozYlpJeFNLNXlIejBOYzdWc3c3a3ZjRFZq?=
 =?utf-8?B?RldIWFZJUXIxL3gyOE0xWS80aTU3SnJMTHRwWW9uQnhEaS96SnBjWlRrc2xY?=
 =?utf-8?B?ejN0UEQ4SXozZkkxT21vTWFkQVUrT29EcGtMeFZlcEJCaFIyLzJXKzdmZ2pw?=
 =?utf-8?B?WVJVR1hlbThxTmhucDBZNFZPTEh0ZkNSd0hHeXFVSnpXYlBrc2NQbm40a1NF?=
 =?utf-8?B?ZnpVcy9saW90WmhxTTNaUDF3NDlzM0p0bm5xN1VPcnlGdFE3b0ZPTEkrbVlw?=
 =?utf-8?B?ZjQxQ2hYMnBSbS9sbFUyNFY3NGI5SVl6cHBjNGJRWXk3YWxZc2w4QjQ3eVZJ?=
 =?utf-8?B?ZTVBeitIRU4vMHhSTllkTVBuTG44T1JIY0dpUGJJWWVsMGtlYWdMWUJDZFRz?=
 =?utf-8?B?QmZadG1FeXpxbkwxcGhQbThZVkU5OEJTOWN3MlVDM0pvaDVvMzIzSDFHb25j?=
 =?utf-8?B?M0JsSWc3WTVOMk4yUkhYQnZ2cUZXR2RqdVp6OTBaZGFnRTdBUkpXVlY4VDVn?=
 =?utf-8?B?VTRNRm1zVFdPNGIvY0M2bDFLeG5tMllTQnhuSHRmaXVOb2ZLaU9rcWR3aHFE?=
 =?utf-8?B?bXpJWUd6R3VSVTNGM1VzS2ZZUXJmdlJIdHlSUFlBQ0dORlVrNkxMQVJ2QVQ0?=
 =?utf-8?B?QjUxVG5LdW90VFZZY0xodVhBSEZOSXk2YXVxaXk0eDQrZU1sYUVSTmNmaXF3?=
 =?utf-8?B?ck5waFVBbjNybDRJTE1TSDA0d1M4cWgzdlJTVVZIQkZWVVpzZlljNUhkbHpH?=
 =?utf-8?B?OFZKV3V6REdUM0RneHZMRnZoNlA5cGU2Y3IwdDFzWGpLTEhmUk5NTk5zVTFP?=
 =?utf-8?B?MS9UMUdnNVhQUm56Q2x2ZW5CdmV2eTMxZTdFRnV6YjJZMEprL2hWeUdyUnQw?=
 =?utf-8?B?NzZ1WTFmcGhMNmJZTUJXTk93OVpkbFU4alFFem43VWxIZ1d3MlNIVDh6MDV4?=
 =?utf-8?B?eUFFa3B5M2d4N0tIM2RNMFQxS3hDS2R4cW5ZbGVCSGJlTHYvRDBRMTVhaUdk?=
 =?utf-8?B?VURPNTZWdTZ4T0RaazAzbDF6LzRwTTZNNGtPV1M1V3duTDVlOTBkb05iTjZ6?=
 =?utf-8?B?ekdKREhEMlJLYWd5dFZXM2V1VWl1ak1FVUppc0tmMjVhbCs2Ri9lMUJ2Z0I5?=
 =?utf-8?B?SDdRbUN2dUJobkhLekUzQkRLVVVhbGhpUkhCL0pPb0lUNTlhV0xwTTFiYWJl?=
 =?utf-8?B?eEhJRlZIS2IrRFg1TllrOG9yQVdmRUJkVFVHS2N2aS9ZMS85MmlWOWpXckti?=
 =?utf-8?B?V0JqSGtJbTNqQUNiYjVRQjZibkVWRFZDeUs3aVJldjlRb2dTQUEyNGtzTUxs?=
 =?utf-8?B?WGdtVkpMYmp2QkQvaVRGd3VtU2NHNlV3bG41WC9TelRqdmNybXBIWGo0UExv?=
 =?utf-8?Q?IfsAnTBGD7jpo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTFXMXFNWjZtVU5rOEkwYm5ENng0dkRodFM1cEhLa3pPUXdpQmNNUkV2V0Ju?=
 =?utf-8?B?cjZNakhacUZ3dXA1ZVdiQVdZSFBxUGlxV0FmU0JsQU1rSVV5bXRNUjF6S1ZT?=
 =?utf-8?B?LzV3SFJlSjFuSlFKYXUxZThhYk1xazQyTkcrMXFCTWlMakNuVWtQMWJVSzYx?=
 =?utf-8?B?OHppbU0rVzFYbDFrbDFlVjdVM0RGcDFrL3lZSWU2YVFpc0VFcUYvV3RpVEJu?=
 =?utf-8?B?a3N6NW1GRkNKR1A2aVlTd0hjMnRzMmk4Q00vcFV5aVgwdW1EZWs5eW1mVWUv?=
 =?utf-8?B?NndDRHZROEtLMkFhOUhXaGsyTU11K0J0TnVxN04vNXRabE5jRVNjd1Ziallt?=
 =?utf-8?B?cGNvZ2d6STZNaVpOOEdpNitDa2RTeTI4QTI5YUJsMXpsZVFQMW5QQ0FyTExU?=
 =?utf-8?B?TlVPdE1oOHMzNnphakZwS2JHRS9LZkpxbmFuMmtRMEREbkNNakY0T2JmN1lu?=
 =?utf-8?B?L2ZWVURCU2h5NTlKUVNNUzUxVkY3TUZlWkdsbnpKWk0vR0FrdzdyckdrcGtR?=
 =?utf-8?B?LzRHeHBYVFJrNk53bXNIRGc2Q3ZqVXJRTlNDZXZ4eklyU1ozai8raVB4YzFM?=
 =?utf-8?B?Nlo1MzlsWWpEcXBJOURTSFNnYlNnK05qVzZiZ0wzdkovWklkQ1k2ZEVkYU93?=
 =?utf-8?B?d2VNZ0FDcTQwV0ZkUTlDMDJZNnRnaWp2R1ZkQVRMQ1VLYm5PenZTVDB3NXYx?=
 =?utf-8?B?Z0EvY21ibm1XeFNVSUg1TFRqQU55MUJEaG9PQkZkYzd1Rldjc3FETmR6VG5Z?=
 =?utf-8?B?NnlBM25zYk1TUm55SjU0K0o4MHcxWlZ3WXlzV1lrSHRJWVFmaCszSldqRU9n?=
 =?utf-8?B?d3FHZVVZdi9BOEZZS2IxK1R0cWFpeXdGb3F3N2Znd0VOSjI2NUZJcnhBK0VM?=
 =?utf-8?B?Wjh5RG5tZkNWU3RjUFQrTHdWbFpXZ2lRQVdCWUlkclBFZHJNNnRncEFRRjk4?=
 =?utf-8?B?VDVlOVc4UFcvU3ZVVlVQTWQ2Y0NDMUhRYUtHNUhKVFZzd1IwdmJNeHNWaTIx?=
 =?utf-8?B?N0k4N3ljR0hhNWV0SlZCNGJocndwTlBSNU1ubkQrRGQwaXhuTkVreUVFL0Rj?=
 =?utf-8?B?cjhmOFkwaDE2OUNORGVCTDQxbFAyQitacE5QeXV6OG5Dc1ZDWlBSalV2L3ZG?=
 =?utf-8?B?bnBRNG85THB0ditYQUdkK0pJNTRCVXBmUWE1MGFvS2JBeFRyN3FDa0pVc3Iy?=
 =?utf-8?B?NVZNc0haUExoZDZkMERHSHlsU3VhSCt0L2VHN0dTb05kaFdFVWdOdjlJN3dY?=
 =?utf-8?B?L2pBdkZCbnA3am9rUzR6R1NaK2p4MjcvRXFoc2N1d1dROHNqbktyWGdXS3Vp?=
 =?utf-8?B?dWgxVU9BdUdVdkRFYVBBODZLV3RrUm0yc1NGZTBtb01FT203V0xLSGswRzly?=
 =?utf-8?B?dmxBV0w2ck8zakk5VFZzZ1ZLejZZUTNsaVAxVld2dlJHc0FQUHpCRnRFRGNN?=
 =?utf-8?B?NThWTG1aZlh5VUQ0a1lIbE9Kc1htUkEybThVa3d5dnFoVUNQeUYvbkpCclRt?=
 =?utf-8?B?L2pOZGtvaXQ5MmMrang3c2RsVlJ2K3BPcTNXMXdzOTJLalRHbXR2dXd2bmw5?=
 =?utf-8?B?MmNWZlJneVJSREJvZ3Rhd0FRT2JtSG1aM1ZHR3dtaERyRnVmVmh1ME9iTHBv?=
 =?utf-8?B?QWpHQ05PMW5jaUcvcC9icHRrMVgwSzFFdnFwS0NGb1dzMjVRbUpNblhwU2I0?=
 =?utf-8?B?ZHpURUJwbTdnQUtMaEhaZktvUitoWXR2RUwrL0loY29zTllCT0pTQjkwWU96?=
 =?utf-8?B?MVpjZmN0ZG5hdzNNRldVem1XWFRwUE15Tkw4MU0zY3BnRWJXWWdFWTdlc1oy?=
 =?utf-8?B?QTN4a2lySktZenU2b2ZIcEdROW4rREVHK21YSVJzK2FTQmVvdEV2L0ZEZmxm?=
 =?utf-8?B?Zk9qa3FOL2xqRHpjQ0tGNThtZDZIaVMwS0YxL1hLQVhvM01CTDIyUmNPSnEy?=
 =?utf-8?B?K3YrcVZqdWp3UmxJT2RqbG1ia1Z1K01NRXN2QThDUkVqRlQ0ZW01ZEtUejNL?=
 =?utf-8?B?RnRpQ2ZDVStOMzIvQWN3MGZiNXJZaVZuS1ZBY2U1WGZxRVBGSFJFTjBRcUgy?=
 =?utf-8?B?YTZCYVhtaGFhRy85NVNiTTRjeVRPMWNJWWlROU9XMDBxNXhRdDQ2aWc3ZFpY?=
 =?utf-8?Q?OSbOAaEb6AR4fkqmqEsc5oier?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87244ac7-6015-4ac3-6daa-08dd5079c4c8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 00:10:08.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vW4yCaN/XPWl/CpXbidS314Ml45XsO68Rt8Jx3+SP9OAjEFBXrAkRpUHTEttlJQPaDBCjVLCc12uWABJYk2JXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6142
X-OriginatorOrg: intel.com

On 2/18/2025 11:41 AM, Kurt Borja wrote:
> The `objs` suffix is reserved for user-space tools. Use the `y` suffix
> instead, which is usually used for kernel drivers.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/platform/x86/intel/ifs/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me (and verified that driver is getting built)

Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>

> 
> diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
> index 30f035ef5581..c3e417bce9b6 100644
> --- a/drivers/platform/x86/intel/ifs/Makefile
> +++ b/drivers/platform/x86/intel/ifs/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
>  
> -intel_ifs-objs			:= core.o load.o runtest.o sysfs.o
> +intel_ifs-y			:= core.o load.o runtest.o sysfs.o


Thanks
Jithu

