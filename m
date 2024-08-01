Return-Path: <linux-kernel+bounces-271848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB19453E4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD08C1F222FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765714AD2C;
	Thu,  1 Aug 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVhq4U18"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501D4778E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722545893; cv=fail; b=dGdZpw8qM1VKepiWmsJGMKGEZOhSb5r0ROgvEvxfsDXvizY+YvKMhIfmeyWkMSDjR+hMQLBrIenPQJrWQLrW5D7isrBoa20P6w5W+lgLC9rm9A84KARdKFqAd5XDo66FXu6eFRpZh15eWodcAg1IA8CvdHWnLh4Qu/4E0PEFLMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722545893; c=relaxed/simple;
	bh=u0l0C7qo1iICKBWAzBgQN99ieMIAsgwm778PRtemv5Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxvDh2aemgMLpKn/TfXKk05PwP+TVuwupZ+XlhCiXyJzkV3pDxZc92qjnAoBz6/Gef5m4H7NNyXSjVT6yMbp8F+87iJSYxhg0uA/O5ZUUWWfMU1teW+aZ23WKLUw0pokEH2r/i1qptVlSH8OUbtHb/xiBT9EoNa0xlTAA6jU6Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVhq4U18; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722545892; x=1754081892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u0l0C7qo1iICKBWAzBgQN99ieMIAsgwm778PRtemv5Q=;
  b=cVhq4U18fVlU733R0PqxJrvLvem6XnOiXTm4iGM9kePDdih1qy/o/aZu
   WIjI6JkILYbQEzVGSYzsjI7JXQhHZtfq/M+1S4MEqf7gHfXg+y1tnlpPl
   Ca9oHg4K0VUeIKMuEtF1/01E6/60j39Qs72COMj/DvrQneEsGBbutOYtC
   EnkSx/A6h8GWPbo0f16DJS+malaHxQkMvt/uNm0OGRMXhES4J2hBJzxPx
   +MTSYj5o1e+z1zKQTklvLTRrRx4OFgHgWx/PcvRqb0cxtpybFUlBJsk5V
   vfeUdHJ8GKMu7NoNt1KP2f4MmRM8S5A8R9SsyHmckbvMqwdg5rxI5actG
   w==;
X-CSE-ConnectionGUID: 3C7roamkS/6aJ9kEP+aE/g==
X-CSE-MsgGUID: +TMgGaQwT9iYtFNxL//m4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="12839418"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="12839418"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 13:58:02 -0700
X-CSE-ConnectionGUID: ry0UKFFdQdq2hqSsNsD5hQ==
X-CSE-MsgGUID: 4nTOQSz5QLmVp2ak/jSQ2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="55403381"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 13:57:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 13:57:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 13:57:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 13:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arv5KGbpVVPBro72qplTyzucthCm6A425lntpyZ7Y0PN2II3ishdcKN+uo2KC7mi+8PUDqANs+L4rYnl78b7BC6tk90jHkuEW5PA9YHrsnhBs36u9kC/exyMBUUMyg7KoEHEF1xgcPq0ggQNBZhAOBmkDHgkyQbcyQu2sHgzNz9+rse+dad0cvg4KIhu30+vLy5lwmus4RHgdk/KT1Ily//OP/SPrWd1OwuFKtPPhx2ZT/rrpqG/FvfN73hx662hsyumjHR47pP2SF/wkUAF/ldauKEaERhyBmtDYq0poBSqkTMmfSJM7xe6vpq6GMvn6VVtyCoNeORdmiBOYZ1sRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXfFqLGDOqXI5UjD2hwDUHXjFv4bwgYpAOD7s+zRfNY=;
 b=GOgjE2ncASQCqAlLcx/NeK3lU66iNuuGWIMyNAclLrL25PYt8Un2nbiPkfncizwSs9OXxqROB6TrAhwGFr8gKj5rXzPgB4DWTiLYo0adaAKommu0IPkTpMQiUPI2Z9hGA8oNYPGv4f964AonoStsw4wEOzb0nNDf9FvUY13NfL423MB31tXOuIxqnlghwUhNYh4nXv1HbkDsBoS1BIeif/NfXJLB6zM2AEhA5L51LytbNquylOUTEtEiGL/BX/lWl4hqr6hnOMTuRDbHS2yzK/QcJPTQqytnQN3jHTReq1vnyEvh+eE5ihYYBP3HrpcQq+QUn91zWvK7DaxweRHNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 20:57:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 20:57:53 +0000
Message-ID: <3e02c4c3-336b-45d9-9dcc-407d0f413405@intel.com>
Date: Thu, 1 Aug 2024 13:57:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] x86/resctrl: Use kthread_run_on_cpu()
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton
	<akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@linutronix.de>
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-3-frederic@kernel.org>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240726215701.19459-3-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:303:2a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfa9b4d-22b5-47a8-f6ec-08dcb26c9cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjJ1ZlJqYXFPa1dhbGpMWStYdWFqRmF3Z3JiN2dhODlBSUd4T2NYeTR1cWFE?=
 =?utf-8?B?ZlU0RUZsdVNJYStGVjNaVkxNY0dtWURja2RhWDEyQ2pGWUwzajgva0E3anpY?=
 =?utf-8?B?NGVQUkRwYXpvRkR6YnJ6THBNRkhuOUpGa242cTRuR2dzM2NCNVNMaXo2WnBw?=
 =?utf-8?B?RnpjRTdJTy9lYnc2ZEdtN1grVWErOWxZR3lKOG1kcytDTS9JQUVoRGlqYm9C?=
 =?utf-8?B?MWIrcUZRcHppcW1nME5sb0U1RjFUV0MzalNEMDRmdzZQQ3VzMjM5ZTdtbVlS?=
 =?utf-8?B?YzQ1ZkpvNy9wQTFUVmxPWnd6VkdwZXZOcFRDVDNlS3M2UTUrdkxGaDFTZzVi?=
 =?utf-8?B?RDhDc0hZR3pySkM2WkVVRXFCV2U4SDljT05yN05GSEVYam40TWtCK2ZSelhO?=
 =?utf-8?B?R3FqWTRMOWIzRE9lb0pSMllVVTdLQXpMTncrVkYwV2g2cG01TUxMeFFQb2hQ?=
 =?utf-8?B?Ryt4dGY3Qk90czEzYVBxWmlIcXZ5bHo2TUlGeXlMdE9qelh4UE9IRWhsK0l5?=
 =?utf-8?B?aFpCYWd3STVlbVpmUVJsNGFUZFBia1NHdkc2VzZRbGUzdnU2YzdBZ2wyZDZT?=
 =?utf-8?B?bEZ1THduZkpRZDNsRDkrZE9rYi9KVDZwQnN6a2hVd2N6YXdqdWZOZWYyWmQw?=
 =?utf-8?B?a2tOWGpIalNOYmsrZjg4VWdrMUZzbEkzR21ERzlPa00rQ0ovbkV0SEJnb2xE?=
 =?utf-8?B?YVJtd1MrNkFFWUFHUm5JVWlGbk0rUjlSWmUxdUZGREE3MEc0eUxFb3JRVHU0?=
 =?utf-8?B?MURFU2dJNmlCdHVSc21TeHU4UVBuN3hDTnNlUldEQ0dJZU5NVUI0WDdpSXF0?=
 =?utf-8?B?djR4VHVUMU9TQTdyY1BLck9lSkZRcWhBRldpUGN3bk5oVXNLbmt2aFNGYWZF?=
 =?utf-8?B?L3R3RXgydDNVZ1ZWc0dmZ004NTJtVG8vTGtOck12eGZBQUNHK2lDdko5YWU4?=
 =?utf-8?B?THRtSitIU2hXQ2E0VGpDdm9YUEY1ak9KTmcrcjRMS1Q5a0hIcldxVDA1ZXMv?=
 =?utf-8?B?bUMyM2tQRXpvb0QzbU1ETzhUdkQxa2hFWndGN1Rlb3pFSzhNRlBPMldoNWpz?=
 =?utf-8?B?bm9WK3YwZ1I0MTc3S3dWcmM4dzFIbG1yVGRrVHBiUFpoN3N3L0JMSEZ0TVYw?=
 =?utf-8?B?WFdQa1B6NHpvSGpRdGxoOS9QNFNGZk1NakxZMWU2WEpQa3FSZHg3T2Q1LzVh?=
 =?utf-8?B?M2RpVzA4UWxibXc5aUdVT2dySVZrU2paU1l6dWMwU0NPSHVZcUlBOFZ2VTlZ?=
 =?utf-8?B?TXJZS2FEUjV6ZDBSekNqSkpVZ1dBVkI3SG5mcEMyNGVtb0tpQU9GUkVYY0Jp?=
 =?utf-8?B?ZXZwMnY4MFVGQ0thbXRXTVRxY3JIejFDNkhRYzJzVi9rOXpSUDJtNkFkQUln?=
 =?utf-8?B?WjUvc0U4QjZuTlV4amdCN2xXQ3YrZHQ1YmlkZ1h2OGk2TlREdE9QMXkwVmxh?=
 =?utf-8?B?SHlRZk9IVnZjQXJiTVFYUFdMZW50NzgxQnhUMjg1YWd5eDZaMytUeEdWbm8z?=
 =?utf-8?B?VzJPM05kOTNmN3JWODhYZDEvZzJVYzIvR2FmOTRhbWxvZDFQbFo5UjNtdEdU?=
 =?utf-8?B?dG5RVFNSd3BKUVo2UGNVMnhYZWF5bVExRFF1eXJ2VXRrVUQ1NXFaYm8vZk1i?=
 =?utf-8?B?K014dHYxWEphaDNKYjRVcWQxSStZS2lpcTdVODhtTG1zZGFXNE9QZEZoRWFm?=
 =?utf-8?B?WjhhSWpBeUs1TTdCSlJDYmpiUVVOb2wxZnNMRFVMUDFoMER2Rytna0d6elFt?=
 =?utf-8?B?R1F6cFBoNmdqdjZJRk9PemUwZWFNQkgrdHNNbUllazlQSC9pdFRxU21vaEpB?=
 =?utf-8?B?cHpUWTJaVk5XMXJhMzdqUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkYvTXF4Vm1RenpzYlU2bEdXQzV1akt6SEh0ZTBudEJFdm5waXVla3FyYXp0?=
 =?utf-8?B?NU4xNUZSU255Z0wxVHlZQ1h5OW94eEhNcnVrYVNIbU1xaVkxa0NoRWVGUm1K?=
 =?utf-8?B?VXQyTDZERTd6bmcvZmFjejBPVXpNSGtXSVo2akJzeDdhbzhTc2NyWE1UNWFY?=
 =?utf-8?B?MDV2N0lkTzgwM3BxNnhtcUN5NTZ0eFJiL3lLc1JsVUhqbTRZSGg4cXVxYXR5?=
 =?utf-8?B?cjZRWHRyeEpENUxLK3ZwSGxseTI0Vi82WkZtK2ZVU3pSajJoc0JxWGUrczBK?=
 =?utf-8?B?UjZETnAxNkwrN0ZrSnZxWStObnZlWmFsazhUUE00VWV2WVJZWVB3SE0xVXBX?=
 =?utf-8?B?bXBBWUIxa3VKMGdkUmg0R01xdUR2UHFUUHF2OFVsWEpTSnlEeHQydHpHSzcv?=
 =?utf-8?B?bllLdXNyU1hDWnFvTVBneUk5dlNJYy9QbWtndzk4ZXFsZzBURG1vVlNKRmpz?=
 =?utf-8?B?SDRrVGRtcFBoeFZURkQwS1BuZ3BMSFFRL1Q5T1JkdFljQnl1OXlSLzhFSFAv?=
 =?utf-8?B?bVY2R0Rob0dKLzJwWHY2Rm1XQVlBUTgxM1Njd2lKSFdRdEFiUDV2RUJCRFdB?=
 =?utf-8?B?ZTBTQWU4RzZzNS8rd0xzUTZIVXppMm1UQnVFRTdLWkhZdHhmYU1yY2ZQdWVy?=
 =?utf-8?B?UHpGTmxMcVFaTU1Tdk43bGx0SzBncjI1VEtQeTUycktPcGVSQ2N3SElhY1Bo?=
 =?utf-8?B?U2M2UkF0d1FJam9Gb1BhanFqWlplNnc0ZmlvUDRqYjZFei8xYStMaHBVWWk4?=
 =?utf-8?B?Ulo5ZER5ZytMeXV1MjJKQ0xvZkFERDFxMEtDazBNQlJpZS9QR3cyVkJTY1d3?=
 =?utf-8?B?OTNIMjFWYno4bmp4Wm4zVHZIcnVacUM2QW4wbWxGNStVUW9YUjRtTTA3T09x?=
 =?utf-8?B?Vm1UK3ZhWGJ2ajd0cEo0eWhlREw2TkVoY0JmN3RnZGJ3Mm9Jc3JMK1pFTzV1?=
 =?utf-8?B?Tm1TMTN2QWFnZmE0OHJlRG5YT3FDSEsvZWFnRG45VFNDZDF3UWtCaVllNWdD?=
 =?utf-8?B?ejdHaWhlbkowOEZMWFZJQWhhMXhCUUlQdjlHV0lrTEE4WE0zY1FPUHV1U1hD?=
 =?utf-8?B?dTBMQ2hWMjAwY0g1K1pvWUtLL2ErNVhDS1B3d2x3VTl2bStrbGNIejRBaTFo?=
 =?utf-8?B?T2JHdUtFN0k4S0cwelpDa1dEanFQcFhNdGYxbTdVOEJjWlVydFdaSS9zSzNl?=
 =?utf-8?B?MWpCM3R6cW1TTUVJTTkzRmpWTHNlVnR5bGdGMmw5WFB0dHVzZEdMbmVKTVYr?=
 =?utf-8?B?QW5odDFqOVpFamhETDArK1dtYU9WcXQvM0J4U1FjN3ZnTHdRNFBxc0JsMGx5?=
 =?utf-8?B?S2JLajVSMk9KZDdUUDQwR2lwRGQ0NGdMTHY5RXBUNFBsdkxtbHF6ZG41VDJ3?=
 =?utf-8?B?RGVUZnNCUWVwUDdwUzlEdm11cWM0dVlWQUQycytIVFdVdDlUc1JmdG1SVUFE?=
 =?utf-8?B?alh6dnhSOVNsWnpyYjBXU3ZQSG9FWTg5VUtMTEFqeHdGaTZuOGJGY2pEcE91?=
 =?utf-8?B?Tks3OENOTGhhdUY3V2VtSldJNG53VzFxdXRnWWJ1bE01c3AwZFQ0cXlWUlRi?=
 =?utf-8?B?ZXRHaFplcWJjeHErbWt4Lzk2dlFST3d1cmJtU3V2dlZMVnJSeGdQQ2JrZ3Bs?=
 =?utf-8?B?OXpyNVZydlNJNUsrM3hrNkMzS1ZXNlcwOXljSVFLRkplZngrL3ZLaytwV2c3?=
 =?utf-8?B?c0lpWXRzd1A2VWxoT2FNUS9oOTlYMnJ1RGxOK3ViUlFEbzhFWWZwekFUTmlN?=
 =?utf-8?B?dVBvVHpDVUNxSkQ5eEdRSExQUFlldGYveWZYMGVjdkV0Qmt2eU9MZ1J6N2dS?=
 =?utf-8?B?R1dyY2dWMHhYWnoyMzYrb0dWYTdubHlnYnRYOFpDU0RmQ3lHZmtTdS85OGdH?=
 =?utf-8?B?UXJRT3lEbTVhdmJVTkwwY21TZTFHOFFicG85THhsbmNRaGNxZjZIWEFmZTJZ?=
 =?utf-8?B?YTY2eHBmYXlqbThPbnphZkcydHpuT09qcGdHQ29ra2tXalhRcSt4SVY4K09k?=
 =?utf-8?B?TnB5aFAzWk43cmwxejhTQVgzVWtjekxGZTcxelJsQk9XR3FseDhJUEdQT2Vo?=
 =?utf-8?B?VklHb2ZPbTJPM0ZUaTlwS01OS1AzeG5ubzlwUDlqNUtNZWcxTld6SGpoSGQ5?=
 =?utf-8?B?di8xVUw1UWlvd3JJR25pQVQ2cVNJcXNoQit4ZHdzVkhnNUV0OHRrR1BiQTly?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfa9b4d-22b5-47a8-f6ec-08dcb26c9cce
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 20:57:53.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkStaA8PD0fB6LuYyjzlEty6Veo0ZaMW+m7AVAZ/0QXU6/a134jX/acaoq0+Yme2Fk+bXWFbDzC7XwKxCUEBDsiCaO0GCD2G1k/sRA1DfVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com

Hi Frederic,

On 7/26/24 2:56 PM, Frederic Weisbecker wrote:
> Use the proper API instead of open coding it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---

Thank you.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

