Return-Path: <linux-kernel+bounces-324182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A047B974902
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B991F263AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE43FBB3;
	Wed, 11 Sep 2024 04:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOZUpYZs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1772A1B8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726027353; cv=fail; b=crFEIx3ExWjxtMhdQbx96wpgzsZg+laLo6vw7Gv+HLiLutGP6v+oLKMrypjXkIgIfZdOdxT1L3higMSwPn6DjVf6D1Xn77Yq/oPPRFgdxNtbYNif8W+KZ2BCt9HpkxPnerlMQxQnGCxay7ZFaq6awQoxfrVpXlrrbAsNQt6fXcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726027353; c=relaxed/simple;
	bh=xyZgWyC0ItXoKKbDBrOly4kOioHN6Y3nyAHSqSPiAUs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bFiw1ryhfOiKOJLyzg41Gc3vjMefjK0/4y5Hya+e5lKGRuhW0YC6dDpDj1IdSLMMTjlAsT0VjBAg7ZBYQwZzoHiHy5jOwoL5VIMnbB6fWIQ/L5cLxwuvTjgmqrGBaz5TIOAN1XbbbYjw0YiTKFLI+dc6wnQ1p6u0xCoVRXeSAlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOZUpYZs; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726027351; x=1757563351;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xyZgWyC0ItXoKKbDBrOly4kOioHN6Y3nyAHSqSPiAUs=;
  b=YOZUpYZswYdlK5Nonfe6JsSXVzwDsBN2rP3fi+Yc60HWpG/HIDVOaH5c
   6iQmId/rYbMy00TibVKLxEXV3lJVXGdrlOgAC3QEkZStOt8d6MCV+EQNO
   uuNaH6V27Cjgb8e569sK3r1AIwmoWK+N+N+vaa8EdzPlu5b/N80d+tajK
   ttfq+wetoG0tZxnTzAv73bm0iE5fME+wXu9VzvuLPJ4DeuQOqoipVHbQd
   V6m78AgxJM8qucvcDoK+USCOVGmszmbDdzz3ZItVmQgV12rcKcjeEzRlW
   H7cun33iAIHaU5gVXyceSAyP8rfad4N6mZHymztpVcTgNRiaRDCO9/Su7
   Q==;
X-CSE-ConnectionGUID: 5ayO2muCRwmoqhVQ7jhi8w==
X-CSE-MsgGUID: uy29+mzgRESDZoqQu5i6dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24680749"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24680749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 21:02:31 -0700
X-CSE-ConnectionGUID: ZkB3qNLhQxC0sC/swg6F1Q==
X-CSE-MsgGUID: FB41xixkTci1Om/E2h0FCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="104706720"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 21:02:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 21:02:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 21:02:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 21:02:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 21:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGZCEx8koV2klz7SnMAgKNgYuiXbJ1V7EXOsuiku5U6wYgRMug302/6xvmWc6KJxdZAJKbb/tDJ/Mwr1h+mPOzdbYWq9NAfPjSQCC2qy9WnMLoH/JbGSlKIC4MxXoOkpMI/Ph9Z17X7s4Ui0kHQiO/1RcVlhjsLFk804JeoLg1OnchIv1iUqL6XY502wHHnGWnxdg/G32aIORdpQVShSAT3hwr+pyUYbJ8nuklA7qnIyf158C+Q1cw42zQ/GqJsd8KdOY+v/BbvQ1J8oQCxWyufn/RdVTfcB2aite98hnms1qkZVpirdsLU3LATOgogajPvSxQJKtAdn0BZh+4vcGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+8NuLpd8K+iCXsvMMPSTAvbtHRILju6BilInK4H/Ns=;
 b=kxnik/qtGLo1czIKkwnVRms7hLVON7w3SPBBJwcWOeTRbasG9QL0zwddatPpY54/wxeAjWoG4QciwFbqVAKbQupruMCatitljj8YNMPuvdxr4yJI3AHbF8D3fdEqkiD4Ik8Wco11H3uRa9C0/PUn8fqcfhj/CdOAwOhgcsptAI/bSilYvcGF08pKKvrvENs8ooZE9v95JCjLQoj4BRqFUzcmGczylzP3wnKE0KKHgA2Y7PR552AhDXHPej2o2bke4flY13+jXildYhBvVs378nhuWi/x6XsfVTN51jelA/7CxP8JrHW1dnOsW3zIjDq9P3CsgbBqKGC8gmY3rHquaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Wed, 11 Sep 2024 04:02:26 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 04:02:26 +0000
Message-ID: <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
Date: Tue, 10 Sep 2024 23:01:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <20240910170959.GA213064@myrica>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|CY5PR11MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c05d9a-ea8a-4f29-c7c7-08dcd2168bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFhBMlE4YzlwWnhSdGN4bW9yVmJIRWRnL0hvQkJJVWNGQmRnbEVVK1pNSEd4?=
 =?utf-8?B?QTBCOEQzMlphTVl3dnpIOW9FVjgzWWd2NlJRNTlvaFByUnJqT0lQblhzeG1W?=
 =?utf-8?B?d2dRc0lQTmZoekFLZjFXYVJQMCtEaTcvdlpGc3BHbUZsTVZCNmNleVNrWmZN?=
 =?utf-8?B?eG4rY2ovVDNxRzBLRm9NYjlva1FiU1JPMkdlOG5VbzUxU254d01ra3Q2RHVK?=
 =?utf-8?B?Zzd5cytJdVVrdlV0Y240b0MzajE0VnhuK01CUWdyR0I5MUYzMTY1SEFJRVE3?=
 =?utf-8?B?S25LdjM1M2FPYlJVcVhkU1pJN3BqZ044VWR0Zi85YXZOWWlybGV3YmN4dXZu?=
 =?utf-8?B?SFZBckJnS2NHY2tSbXJ5ZWVKbEdXUW9Od3NZUm5kUzcrQWx2Q2xjQ0RJRUNm?=
 =?utf-8?B?eUMzdlI2T1JDYlBqYXovbUpGeUEraFpPWVpWcnRlSUVXb0JvRlJwU2UrNmQ2?=
 =?utf-8?B?eTZIRU43V1E0VWkwckZzMHlFaFFhYVFQeFdCUFpFVlB1QlBQQ09DdE4rcWU5?=
 =?utf-8?B?eXkxRHVaM2w3My9PZ29kSTRxbTJyNlBLdTNHdVJSU0xtMUZZOWRZZWppNkxH?=
 =?utf-8?B?YXJWdlVkZE04cVFDVEFEMTV3M1BPY3hYTThQRjIvc0IwYVRrM0Mrdld0b2c1?=
 =?utf-8?B?amJ1ZVEvTEFianVqY0tJMm1iWVU4VHdzc051cXlTR05nMnQzWDV3aGNSdnd3?=
 =?utf-8?B?RnhXTUpHbmRzbzN6YWJkTG9mY29lZVdDUERBMTRUaHpOOEFMK2wxc2tjWGRD?=
 =?utf-8?B?ZHh5UDRtcENMc011dHkvNkxzdTlnWnN1bDV5LzliNkFsLzJ1ZWtwK2g4R0pT?=
 =?utf-8?B?ZmdINW9pSTBVZ3VCMlNCZE9xeEsvdFNhNFZMSGxuN1JGMWZFS0gyTittWldV?=
 =?utf-8?B?YVVYNjZwSUNST2NuempHZ0Y5eWJYWUJiMTcrV2p3V01yanBmY0k1a2xhNmxT?=
 =?utf-8?B?VnNRLzNwUVhEb0ttbnlNdnpHVm9pT0lSTGl2Z203SG5hcW9pcXozVStuVkdK?=
 =?utf-8?B?SUR5K05CUmhSRjZxUlA5NGtIZEl0TUF2OTF6RTNlZWNZOVkxV0gyK3BENDRM?=
 =?utf-8?B?Y0dwVXNsdGVrZGxKczNuSzkrOHZYN3FoRllUNkdKVEZHdWU3YnR6STFnQm8y?=
 =?utf-8?B?L1pKMnUreE1VNzZPU1Z6N01DQndPQnc3VlhDbHM5Q1p0YW5ESXg5UDRpcnRL?=
 =?utf-8?B?b3hBdEJTR2VsbllJZFZTZW5TcGw4K2ZQK0dTNW53eWhWMmdraEFndjFkYnN6?=
 =?utf-8?B?MU9ZMGJIUS8wWFZKcmpPbnM2dkJlUXo0a3d4NzNjZGxFSGxDd3V6QVJLQU5R?=
 =?utf-8?B?RWpBbm1oazFEdjE1bWk4SHYrdFZWS0NHUElSb2d6VVY5bzZZaXp0WGtJOTgy?=
 =?utf-8?B?R0NlY1IrZGxXL0ZJTVFUdmdKaHZtaHRpZHgwd1M4SkM3MnhHUjBtYVh1aE1G?=
 =?utf-8?B?eHpRN1ZkTVhXZWpGNGhnVmxoWGlHQ1czcGZHU0wvQ09TS0kvczRseHd3akhH?=
 =?utf-8?B?WmZ6YzdWQ3FVTG1ZYS9ncDcwcHhCUnFTV2E1NE5nRkxTNm5iUUFEMjBMMDZ6?=
 =?utf-8?B?NkNXK29nQkRLeE1wSHEwei9mMXE2RVQyYVowVDdlRmVNYVk3SHNCcFlEcFU4?=
 =?utf-8?B?YjIzc2xkRm5vY2k4Y2hueFhFVHR3R3hSQklwZ1gySDRHWVZiNzlTN3ZSNnZC?=
 =?utf-8?B?bWdpQ0lqUTVRRVZZUlFpdWVQeEVrTzJvWHdVa2JRSTVtK3J6czFPS3Nwd2s3?=
 =?utf-8?B?N1lVZkx2d2JOV1UvSkVnaEtaZ29CalozS2l1cDFYMmZGTWVkc0tib0E2aU9v?=
 =?utf-8?Q?PxH+TnqZP560id53IeWzgtu4xlJ/F1+XmCz/c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1YyUVliN1VadVh3bUlwbGszbXhOZlpQS1lZQ1U0Y1gySlhjOVY5bXIwengx?=
 =?utf-8?B?dytXUFF2MnpYaTlmS0hjTUJMU3VqRGxhak1tK1hLTHgzdDV6OVhrL2l3SkNl?=
 =?utf-8?B?SDJIVW94TFV2WXV5c1BTbUIwZFd6Yy8xcU5raHdKd3VackJHbFd1eEFiNkM0?=
 =?utf-8?B?NmtNMnMvVEdkWlJTZlhPUFlaRlFOV0FYK2xlTG1qVTZ1L2E3VUNxbnJUNjRm?=
 =?utf-8?B?Q1l3MWt4b1Q0bW1nWUF5UzhvSk5zSEh1Z3lFV1JEbDFiVGJoUnNIUG5Id3dV?=
 =?utf-8?B?OEIzNmZ1WjFQaWs0dXFuRXJid2dYZDBuSmkxdzJHbHArWmpVRXhjRDFkRis4?=
 =?utf-8?B?MCtlOU5QMGg1U0YyTlFmdjBKTW1ueGwwbWRudGpmWm4vc05PVFRVaWhwNFVZ?=
 =?utf-8?B?Wm05elR5TW1XeU5JNllLMi9JVmtsSWpvS2U0UzhKSXZib1NhY21paXk4MU9x?=
 =?utf-8?B?aGF5blBRYUhEdC81emFUN3VmNk5RQmw4VmxVS3dNY0tzc2RkUk4yMWtpRXRK?=
 =?utf-8?B?UWh0WXdoS3EvSzZkcWJEVG5uUXRTRHRpazVGQzl5emRtZldPdVd2OEs3d1B6?=
 =?utf-8?B?VnF6RVVIKzkyZFkxOXZrd0ZEVk9JZTZKVW0wY1Frelh6TWE0TDlrU1J6SDhp?=
 =?utf-8?B?cDkvYzIxNXJBcWhjUEx3QXBoOGZ0WjYreWJsS3NNT2RHU2ptZzF0aFZqbWFT?=
 =?utf-8?B?d2JyUWRTZjBQQmgxV1UwSTVFTFBOTTJxNE5WQzFaWFgvVHh1U2VGd2h6c3Qr?=
 =?utf-8?B?V2QxRDJ3RVRoMWt2SHFaMURUTHVPY08wdFYxcTVSSlZvZWJvdy9GdmFTaDFF?=
 =?utf-8?B?RkcxcU5DK2VJWjF5VHdueDNJeW43cVdKbnJYSEpiWlhoODlJWEdDNTJPWDY5?=
 =?utf-8?B?RnRBTlJXTWw5VFBUWkFPeW5CVkJ5TzRUWXBSQlh2MTY2N3lVUmdONy9lcldG?=
 =?utf-8?B?NGhWQmRJZHM1SGZBS2I4R1Y1a1dSOVN6UmRKampjNWc3ZzBVZ0hNczdvaGFj?=
 =?utf-8?B?dTRpdHlvVHdIYXlvMko5YVhYTytrK0pDdy8wK3RGeUpIYVQxN1kzeFplVFQw?=
 =?utf-8?B?bGRwd3NFaUl4RG15dEZXaG9obXNFSjc5NTlkUnNhR1lLN1hRUnlUWEw0b3BO?=
 =?utf-8?B?UkhxUTU3S1ZUNzNCa29jY1hmNUNPMHBpeE13T1BMRWdwQml2UHljbFR1dmxz?=
 =?utf-8?B?MVhCd21BU3hnTThTS0tCbFN6SzdWK1hhME45cjIrSkNCQ2V4b2pBbmRPcVVH?=
 =?utf-8?B?dnNXbGVocUsvZXRtRVRoc0lublNiVk0rdWlnOXFxOHBmckcreml0QnJUNkIx?=
 =?utf-8?B?TTJDM0g3a0VuaVl5cm4yM0loR3diQm9Wd1NFVkZubG8rNW1QTTkzMTZrNnFN?=
 =?utf-8?B?eUE5R2dzQUNxamdtb2U1a3FkZ0lZMTFUMFVlcldXLzFsTjNTWVhJdUgxQ3ZO?=
 =?utf-8?B?ZTdqaGI4ZERnS1RXNGZxaHBuRU52RW5hN3ZJWUl2VklpTnMyNGltbFpGMTd6?=
 =?utf-8?B?M1c2WC85VGpmby9sVjdUY0ZSSERRSTMraCsyM3c3ODE1UGU1VzB1bEc3ZGhi?=
 =?utf-8?B?TjRrb3VqOFNpZ3RUOUphOHY0TUVCcW5sWmN3UzRJTCs0c1EvUGVJSlh2RVdx?=
 =?utf-8?B?dW1OR1MwUmY2bkRSQWMvL3Q0WGllSENMR1BQVXZVcUpjUjZ4bE51a1JKKzBF?=
 =?utf-8?B?U2VGMEl2aWgvbzdLdnc2d2xjNmZJMnBMZTRkTjFwMmFSNFd2bVljWWhrRTRC?=
 =?utf-8?B?b0RIVkltUU5vYk9kUjJobnkwRS9hQVZOWXozdVhLT0I1TjNkWEVMUk5qelZL?=
 =?utf-8?B?MElYVG5oUEZzNHZJcDcvQU10YTNsay8rWnZtN0thdGcwVUxCOWo1ejJrN2hh?=
 =?utf-8?B?Nnc2SEpEUjk5TGlMSnNjZzkwNDF5NnNEVGQxT0ppcDB0L3VQRy8zWjVDRk43?=
 =?utf-8?B?YzhYYnBRaGdLUUpEVEp1MHpIL0FJUlZ1QlR5TTdaRFBiNEFYYVc4RUJESVdZ?=
 =?utf-8?B?alhjeFBnL21Yb1k0T095L2Q5eW9jVTVSa2gzSGF2ODVyRWVwWUVqYmJHMEE1?=
 =?utf-8?B?MHFyK2YxYXlpUmJxOEsvcHJJSXJRZ3hHNXhJMXRaai9vaS9MaGY2VXZXV3Js?=
 =?utf-8?Q?2hv+o9K5Kh2L0tK/5kS5cOVha?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c05d9a-ea8a-4f29-c7c7-08dcd2168bdb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 04:02:25.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHAbmW5outnV5kTzzP+FOc/L9Sz1QUYyPEU3PyjtIlqhuwOBR0lgT4e2ZqRe1ME+rz7YcXS/Pg0bzRe/jRJ2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com

On 9/10/2024 12:09 PM, Jean-Philippe Brucker wrote:
> Hi Cedric,
> 
> On Sat, Sep 07, 2024 at 11:56:18PM -0500, Cedric Xing wrote:
>> Patch 2 introduces event log support for RTMRs, addressing the fact that the
>> standalone values of RTMRs, which represent the cumulative digests of
>> sequential events, are not fully informative on their own.
> 
> Would each event_log include the events that firmware wrote before Linux?
No. The log format proposed here is textual and incompatible with TCG2 
log format.

The proposed log format is based on the CoCo event log - 
https://github.com/confidential-containers/guest-components/issues/495.

> I'm wondering how this coexists with /sys/firmware/acpi/tables/data/CCEL.
The proposed log will take over after booting to Linux. The `SYNC` line 
in the log captures the RTMR value before it, which can be used to 
verify CCEL left off by the virtual firmware.

> Maybe something like: CCEL only contains pre-Linux events. The TSM driver
> parses CCEL (using a format specific to the arch, for example TCG2),
> separates the events by MR and produces event_log files in
> /sys/kernel/tsm/, possibly in a different format like CEL-TLV. Is that
> what you envision for TDX?
> 
CCEL will be pre-Linux only. Given the proposed format is incompatible 
with TCG2 format, I don't think those 2 logs will be merged. But if we 
get any success in this new log format, we may influence the UEFI/OVMF 
community to adopt this new format in future.

We have evaluated both TCG2 and CEL formats but arrived in this new 
format because we'd like to support ALL applications. And the only sane 
way I could figure out is to separate the log into 2 layers - an 
application specific semantics layer (a contract between the application 
and the verifier), and an application agnostic storage layer 
(implemented by the kernel). The common problem of TCG2 and CEL is that 
the event/content tag/type dictates which part of the event data/content 
to hash, meaning the kernel must understand an event record before 
hashing it. And that has prevented an application agnostic storage design.

Anyway, this new log can be encapsulated in both CEL-JSON (like what 
systemd is doing today) and TCG2 (using the EV_ACTION event type) 
formats. Please see the CoCo issue (link given above) for more details.

> I ask because I've been looking into this interface for Arm CCA, and
> having unified event logs available somewhere in /sys/kernel/confg/tsm
> would be very convenient for users (avoids having to parse and convert
> different /sys/firmware interfaces along with Linux event logs). I would
> have put a single event_log in /sys/kernel/config/tsm/report/ but
> splitting it by MR should work too.
> 
We have considered one global log vs. per-MR logs. In fact, a global log 
is equivalent to the concatenation of all per-MR logs. We've adopted the 
per-MR approach to keep the log optional - i.e., an RTMR can be extended 
directly (by writing to its `digest` attribute) without a log.

With regard to the location of the MR tree, we picked sysfs because the 
MRs (and associated logs) are global and fit more into the semantics of 
sysfs than configfs. Dan W. and I are also considering moving both 
report/ and measurement/ trees into securityfs. It'll be highly 
appreciated if you (and Alex, and everyone) can share your insights.

> As Alex I believe we need more similarity between the interfaces of static
> and runtime measurements, because verifiers may benefit from an event log
> of static measurements. For example Arm could have a configuration like
> this:
> 
>    struct tsm_measurement_register arm_cca_mrs[] = {
> 	{ MR_(rim) | TSM_MR_F_R | TSM_MR_F_LOG, HA },
>    	{ MR_(rem0) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
>    	...
>    	{ MR_(rem3) | TSM_MR_F_R | TSM_MR_F_X | TSM_MR_F_LOG, HA },
>    };
> 
> Here rim is a static measurement of the initial VM state, impossible to
> extend but could have an event log. rem0-3 are runtime measurements,
> extensible by firmware and then Linux. None of the digests can be written
> directly, only extended and read with calls to the upper layer. The tree
> would be:
> 
>    /sys/kernel/config/tsm/
>    ├── rim
>    │   ├── digest
>    │   ├── event_log
>    │   └── hash_algo
>    ├── rem0
>    │   ├── digest
>    │   ├── append_event
>    │   ├── event_log
>    │   └── hash_algo
>    ...
>    ├── rem3
>    │   ├── digest
>    │   ├── append_event
>    │   ├── event_log
>    │   └── hash_algo
>    └── report/$name
>        ├── inblob
>        └── outblob
> 
I see. The desired/missing feature here I think is to allow a CC guest 
driver to supply an "initial log". I can define a LOG bit, which if set, 
will make the MR its own dir with `hash_algo` and `event_log`. And if X 
is also set, then `append_event` will appear as well. Does this sound 
like what Alex and you are looking for?

-Cedric

