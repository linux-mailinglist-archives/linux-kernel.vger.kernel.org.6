Return-Path: <linux-kernel+bounces-277007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2AE949AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06334B27431
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00417BB38;
	Tue,  6 Aug 2024 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyMCtCZK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019F17BB1A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981851; cv=fail; b=MBgADgAyCV4gElR/Uba9TRaafokgf/Y1r60YQDVqDKFHRzCS6X2pizgoY9/z2P3Zq79Q2wAsTWV8E0BuW87TcGQ79itT18ZjDLE1GDI42515xnk+8a4T+LW9R2DxUeeJZncjAaTmSyGriNLe5KN+5zDjIYEuDTcP+aG/4Lvh+fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981851; c=relaxed/simple;
	bh=QJyKgbGy47qEIqdLkBpp1Sg9dcKR0vLZmgNUizSdcDA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MKTJfEWrrnJURYje9LRMnIUtn85YADCp1hltnVkgGXORk3CIXabhK5+4q2qWloHuID80Gzvp73vVOt79MqnZdM50mgjzP+O/tm6JbH8Xl1BConMmfRPzCQ5KvukWLeB9jt02BjnLPOnX0twwsmJ0WF1J8dTcdRYKe8PpbUTVT5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyMCtCZK; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722981849; x=1754517849;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QJyKgbGy47qEIqdLkBpp1Sg9dcKR0vLZmgNUizSdcDA=;
  b=XyMCtCZKe+uGUUAmZAjV5cLm9cerqxI8yUMOgz89zQAJhFsKKLrZ9vmD
   0Dy1gSAChJGJ5Ql5x5/wp9Q0eqkACeMZWLXpWY6pK1x0LMV6UEu616iVm
   jUvEGGduv/UEfsRaHUjINpFFg1Fx3AEs7SIClFNbAQqQRR6XvKdMN7siV
   MWR145O/uCSsCs6/EvP8xfEf+nI/wvKY9huonPlP3blhDLPZzujgO8O2/
   193oZ9V26GKbtbwQUHlweVBilHoGy6EiLVxa4OnVGI3V/RjABwCDv1SJd
   f8zEeZIHYxTXb6N+1NnxqnIlcJSqp1SFVfhyIXUW7XTL0xJ6Iq5KVv93S
   w==;
X-CSE-ConnectionGUID: 2BR046jWTH68E6cVwmKmvQ==
X-CSE-MsgGUID: vRVDmqmxSwOmbRyzcvQ4jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32177711"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32177711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:04:08 -0700
X-CSE-ConnectionGUID: IejArbBbTduPGPrva6VkeA==
X-CSE-MsgGUID: UgMi94pATD+dempEjvebJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="57199010"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 15:04:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 15:04:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 15:04:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 15:04:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd8jERniXKP0q1Ps57wtZFhzu41Nkel3/IVy7hw2E6oUKrzL3gd3OUTYVUwo9UM62WZbFRrKTnSiAXUmJtUAQKpXrqPMnjFk/dxe2QZG1gFKTs1gNromPSXSA1uLy0Xbf6A3UseVlaaHzB0ppn6fRSdVhR1Hng66NfknG+uX7kwSZ2OLWtSWDJam88+FtQxL5fZEDxMRD2A7QiG706i4H70XYJPdkGV3QW6iiX2aqSpYcdtm6/h7DNH7qikXwFy/qkd55PVdDnVDgi/CTbbqThHnb3uZKswkW6tVIuWlK+67ERm64HW6r7mnnFslxrWVsF33zlwyX3VjwkCThHA8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hSj7b1cgaz3jmPP3Auy505eskNahIXzwZMTw1Xb2ig=;
 b=O+ka+aaDyYIGKUgT5P1RpcLiMN4zdROV9mPgw4IkHzza7EogiTGyDvJjqHDKfzqCt3foRI4/tsohXfeEnmxCKJa34FdsoM4KQbI3U3HIIwgcnnMJr+lu4+BpZU47IQz+PUByiyWvF6NWZIn4buLzf1Jai7OlthwcjuhS+XIkSCQxfMBuLNTyaIFcxZ9qIcwAjhzqFFF77k9UuQ6XrfLAXBKzF+mmSLMvBZsgu4tRu/74lyEc/TY1H5KTpokrop+9ktgUPrQuHHHs+bcrQAOTevVYNk6B4QIuz55xgvrNwcObCdg/A+sDe0saLcceUTycc9bqUrH+q1tHl8WGvWdJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB8035.namprd11.prod.outlook.com (2603:10b6:510:245::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 22:04:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7828.016; Tue, 6 Aug 2024
 22:04:03 +0000
Message-ID: <6adde20b-2345-49dd-8502-c2a68c8f1c1e@intel.com>
Date: Tue, 6 Aug 2024 15:04:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] HID for 6.11
To: Benjamin Tissoires <bentiss@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>,
	<linux-kernel@vger.kernel.org>, Konstantin Ryabitsev
	<konstantin@linuxfoundation.org>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
 <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>
 <f94c747c-7ee4-41b9-9851-610cecf2e555@kernel.org>
 <39ec733e-c49f-44c4-b998-19c7cbaf6ad1@kernel.org>
 <3azgpqym2yaceheefnnj54rjjb5vz54haqayxmgbnjvb3rr3sj@aoiwdpfjo65s>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <3azgpqym2yaceheefnnj54rjjb5vz54haqayxmgbnjvb3rr3sj@aoiwdpfjo65s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0261.namprd04.prod.outlook.com
 (2603:10b6:303:88::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: a7dbf6ff-4e6a-4135-27af-08dcb663ae97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnBUN3VxcFV1SFRTUTBTci84KzMzYXdONjNEbi9lY3QwVE53eVA2WEdLQytx?=
 =?utf-8?B?WmIzLzBURExNQlU1MVZHaGtmZWpmc2FPTktyNE41aTE0SWs4NjhZOGRZaXgw?=
 =?utf-8?B?OHA1Nm9jeUNkU040YlkyRW1mTG1vcXh6K3lwTXBpOUtvNmdnZDl1UXR0U2pO?=
 =?utf-8?B?RDBDYXgrWGJMMEIreEVzVDRHUy9YbzErQS93emRtQnhVazRiRmJvZzBlaHla?=
 =?utf-8?B?WTFjQ0l6VDFMUnpMVEc1ZWo1WDRCSXRWcm8xeG1sZGhLU2h1SFRXVXRlUitM?=
 =?utf-8?B?a3ZIM3FTS3F0Z0IxVGFMSE1Ua2I1M21WVUlmb21GYTlBM0FIMW8xWU1UQ3BQ?=
 =?utf-8?B?S0JqY2ZHUElIWFhhNE1HbkFyaFV6dzhUVGM4b0lha2VYeEpuSFVndnJpcVVP?=
 =?utf-8?B?a21vYnpib05yU0Q2b0ZiNTdnQWs0NER6RFIrL0pCTzY1OEliZFlSV2JYV1Qv?=
 =?utf-8?B?K09neFZOVFA2SnVGZ0tVQ2VJdFhzWW9XUHZFZlJHdURpYXV4UmpLeEJZQmNU?=
 =?utf-8?B?S0RPdFBGaXM0V3hhamlJWUtsTHVqaDVJN2dvd0duNG1XeE91UTJwT2trY0JD?=
 =?utf-8?B?VGt6VHFCSDQ5Z25NcVR3dmxmZnlROCtSdzJLNkF6bVM3VDFaU0ZjWXZJbzI2?=
 =?utf-8?B?TkJJMktRM0lXc1ZncnFyR2RsSEVTQnVBcHVmaVVYenJtbE9Qb3FRbDhWU3I4?=
 =?utf-8?B?T2M5S1NiSGo0Tk9odXpTSmlpWm85ejhma2Q1eFFIT09oUm4vNlZ6QUxNdVla?=
 =?utf-8?B?bW4zTm8vZWh2K0o4WmhWaXErN2tGRDN1a2dCOURyOXE2TnhBaHo2aWQrZFQ4?=
 =?utf-8?B?cWZnTWU1c1lPWEJjZkJSV002Zll4VCsyM1FNQ01VSTdNM0syS0VGOE9nUlpp?=
 =?utf-8?B?bEF5Lzl5TXZnZEVWRElicTdNUFJOTStpTUM2THpzN2NQd21WVk04dnRZSjdy?=
 =?utf-8?B?RlhFK3IrTHJRUXVUTGFVeWRTMXg5b3JqUEN6NVNVNktXcXU2OVFXZC9hV2Rz?=
 =?utf-8?B?amZTOHcrN1l0eFlDVC9IRkFRZEJVR3dsZlFQR21LdHN4dzhXZ3VQaEx1VXpy?=
 =?utf-8?B?djZrQkllSHpObXFEbzdxUFRUWStOMVBiUVNzTHpRc3VVZEFNTkk5eGs0Qkhi?=
 =?utf-8?B?enBLaVphVFVsMlhYNDRsMThlMllNbWVjazRvdmpYWG9LZlpwKzFSQWZBU3NO?=
 =?utf-8?B?N2h1OEVEK3VkdnpDZ0dCcVVNaTVUNWk5Y1RzS2tXU0kybFNKY1QzanNFZ3pL?=
 =?utf-8?B?SjU1YUlISExlR25zS2xqdThCditHVElvbHRRYTdHWjBRVmRvVWxhVm1vQm5m?=
 =?utf-8?B?VVN5YU1aZUs0UWJpVGgwejYzMUt6SDZaL3hSb1NxRW1RVmswakd2czB3RkVo?=
 =?utf-8?B?VXl1MXo4SEYxbnZadnFzNlRWcEsycnpNMk4vbUxtL3ZZQUZRSEZRTE03OXRu?=
 =?utf-8?B?Z0tteEpQRVNycWI5aFNtUWU4R1BsbTJMV2d3Z3dSZ1R0U09RMGs1cEFGUm8v?=
 =?utf-8?B?dzduZkxXM1VqU25vTHRqeS8xOThpZUZ6em5PV1ZSdWgrRnRMTy9FbDlXNDFn?=
 =?utf-8?B?eUhldGMrL3Nwb3IzSlYwTHplTTNNazhvVC94U2JtUS9mVUxwOGpHTmhodzhn?=
 =?utf-8?B?aFF6dXZYRTFjWmFxc2RXaTZtcldtMlUwN1VTU2tMYVNQM3Jwa1B2WkVZYmNH?=
 =?utf-8?B?SzE2eEhDTGl6dzhHb0FnN0RNcWxyMG5jQVNHdkJOSnVsYXlObktBdEJlMWhI?=
 =?utf-8?Q?MiOk98lvwUbevKLQ/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG4rVDI4OFpKeStUZmNMMyt4NTBqWDFQTldPOXVsYVcwTklTWnd1UXA1NVlX?=
 =?utf-8?B?N2dqUjhZR0VlNkFnRDJtWmZMNCtwZmhlWHdxNnZVS0QwQit5Wm90c0Rvb294?=
 =?utf-8?B?UEJUd0x2bWloZ3JrRlVibnQ3cGkzWnlDc1I4bFlKTWt6TXFOd0pyQTFNK0tU?=
 =?utf-8?B?T1JwNTFiZnk1UjRyRlAvU2dEaU9uanFkbktwK3ZLb1NTUkRHSDYraDREUFEv?=
 =?utf-8?B?K0lBTXh5NlRsNmM4WlQ5NjhUTmo0bC9Zb0JzdG5OUzdyN1BxSjRGLzVDb2h1?=
 =?utf-8?B?VFgwSFMwSUd4SHlsbno1LzVPUGsyOUxmTTdoZml1N0J3WWZSbGZWaHRPUE5a?=
 =?utf-8?B?NFNNaHlPelZ2RlBFRlJ4SU14dGkySlVtb3VGVEkxNTJYSmtyWEVjeXBzcnN5?=
 =?utf-8?B?NWp5R3R6c1lPaUtuRSs3VkpjNXBNQnhuWWw0WFFUSWVNazdvQVZkbGxiOVJm?=
 =?utf-8?B?RVJSYUdoZEtkaUlyR3JBK1BoVlZ4bG1uaGlSdlFVazdLR3o3VTl2TzZWRm4x?=
 =?utf-8?B?dU80ZnI5N3NMY2xjQjlpNG94ZzRqMkF3Nk03bmoxL2pXREo4SWFwbUhmY1Z4?=
 =?utf-8?B?azZrejdaY2RaVkFtUnd2a2FIVWp5Ry9uRVc5QjJZTiszRjlMWllMYVZjcDQy?=
 =?utf-8?B?SzZCTWR2NjdqYWJLclJoQWdkbDBXb0h3azRqY0JNbEo0NzZvcUJrMkY4R28r?=
 =?utf-8?B?V0JFeGNmNDZVMzRZeU83MGJ1eE9rMWhYWWVzdmU4M2FDdVo0cVBZMEZmS2pC?=
 =?utf-8?B?YlVuUWZYRHdrK1dLVWxTd0h3ckZzUlExQWFHYzVtTUJYRkowSVBkMWFxb1V1?=
 =?utf-8?B?Uk10ZWFBVXhGanUwdzJXT01WdUc3YUg2dUZOY3FqTVpadmZHTUxXVUtsUjBE?=
 =?utf-8?B?UHpSUTdwbVpaMkFRUExPcmJNT0lnNk5ZYks5eVd3TlR6dDZLU1R6RWZtem5O?=
 =?utf-8?B?WnhpSE84TEcvNE11Tlp3cDFpZ0tSYmcvVTQ4djJBZ3VMVnNnS0sxVzF5bVdZ?=
 =?utf-8?B?Ykc5L3FWczVoRXZ1ell1amphTEs2dEp4Mys4NFdlWnUrZlFseW4wN1FpQmdT?=
 =?utf-8?B?ci9qNnRKRmU1T3FBNWxZY2NQUTNIakROOWErY3VwZEhaK2huZ0N6NkZscG9q?=
 =?utf-8?B?clBLVWQxTlJmU2E4amxqeGtQN3ZFVXhQYUlRZlVtSVU0OXlOTFE0bWNxcGpi?=
 =?utf-8?B?b3BLcGdHdnFva1RjUkxERmY5ZTF0MFNPV0I2c0REaWxEencrcDRvbkY5ekNL?=
 =?utf-8?B?TmxIcUY4MWlPOStqTE5XNXdOaC9JbmEvRXZ0REs1ZlhIUHNWaWcrVmR5NEh4?=
 =?utf-8?B?Mk51TTU3TWhWZlA2OHlUNG9jRGRNVWkvUWdSVXR4a0l0dWN2S3p1V1NqWGR4?=
 =?utf-8?B?bHR2cURteTdra3V3MWs4YXJyOEpJUkVkVG5UNkhrRk5BdTFuV2Uzd210SkVK?=
 =?utf-8?B?NnNnRzJKcFlLTW5xNDFJQ1FVSWM1c0dWZGVqN2trWnQvQUZFamE5QVpZenNh?=
 =?utf-8?B?aGdJTjZHWmZkSFVYZTRvUnBpWHNwaFQ2RVorTHVxWFlObFpUblhOcTZvcjF5?=
 =?utf-8?B?TSt6eFhDdTJnWFZEdTBXSXZuUHdtb2lpQ3BtL1FjUk9ZUW5FYmdFWjlKTjZT?=
 =?utf-8?B?eDRLQktFdC9maGJQNVd0ZWpoUEN2aWxLalpZS0Y2UEV6cFd4VWNhWHJOQnNT?=
 =?utf-8?B?MEF4TlBMOHhQSE9kZ3FyMkZpRUpqRjNwMEhLMVkxdHhYZWQ2WGFxVzBQalRp?=
 =?utf-8?B?emIwM0FDcjdIbURHams5MThSdFlJUDdDeVNrR1lNblRVYlZDMXNyNjR2NEZr?=
 =?utf-8?B?WG0zNDBlUmZLcFFhQjJTcUk3VGRFWHdvYzZaSXRZanlQMVlSamgrZitGY2JX?=
 =?utf-8?B?RkplRWxPc0h5T00xYVcxWUhUMWtnN1I2cXJ0NW5sZDRLaXcxZVBWWUdnbm9y?=
 =?utf-8?B?OVpMM0pmQlpzY05NcjJqKzNBUEZSbExJeGQ0aHFIbUhmMExMTHNlSnR6Sjk0?=
 =?utf-8?B?YzhNY2FPa3I2aW9lVkIzTWZWaTNhZEc5dUJJNGt0anRIaW41VlJCcndseEFo?=
 =?utf-8?B?VzMwTzZBUmd0ZVNMS3FDak9iTWNzcTk3NHpTeGN0a0cxZmdTaDYrMzc4bVBC?=
 =?utf-8?Q?CrwiVjsU7/SW5d7NCmzzrl8Ez?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dbf6ff-4e6a-4135-27af-08dcb663ae97
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:04:03.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrCgJu16H+e1eX1D2xnqqBoDITBTZbHjdhUhtv+Rw5iWJQyPBDUFHls4E472hosdi8uVisLwAOiNC+74/dKeh352RyRu4og1vHVYz9MrARo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8035
X-OriginatorOrg: intel.com



On 7/22/2024 6:51 AM, Benjamin Tissoires wrote:
> Is there anything we can do to rip off that commit from the tree and fix
> b4?
> 
> 
A bit late, but I just got bit by this comment and i worked around it
using a replace ref:

$ git replace --edit 3a904d2c771115154380caaae7ffaaf0095fb88f

This let me generate a replacement commit with an edited commit message
so that b4 scanning for a commit won't find this particular b4 meta-data.

It is only local (as refs/replace does not generally get shared to
others via normal push/pull) but it worked well for me.

I thought I would share this with other folks as a potential workaround
for their setup. replace refs are special refs which git will
automatically use in place of a regular commit when it finds a matching ref.

https://git-scm.com/docs/git-replace

Thanks,
Jake

