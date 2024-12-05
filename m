Return-Path: <linux-kernel+bounces-432931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7F9E5200
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684CD167083
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5621D461B;
	Thu,  5 Dec 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJGmTpNu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E415FEE4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394077; cv=fail; b=m23MyRfOfxlHcdqlvlL3A2YwsYclh48x0vpLXwLUazm+KaCxQy/qiNkwCwGNEXBzN5iqtM3Nz9ioC3ROnTdSXY+fsypeYjxEoOPz0T+JhrTm8OUcQyX37i+fLEbWXkYueMOwWgk0MZ8oT5V6/fmieQUvcNvHkXUfydMrn6aJj5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394077; c=relaxed/simple;
	bh=kHXf3LDtIPSJtFwms7311r4dwXgp8X9bqgS1ZeuyJa8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYgGeq91BYBdqOXCfC6DCvqF3QMaHoWjwLrckMER12gOgUaR/oRHIqel4g6RcSITTIkFzuTfoiELhpJRWvVeoFE1DO+iRZ2QQ1coJADpgNrqMxTWJw6a3FEzdYztOlfmXxVWy1pIolzKOdI/e0519IBewaz+mhvjmuIL6uKEz2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJGmTpNu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733394075; x=1764930075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kHXf3LDtIPSJtFwms7311r4dwXgp8X9bqgS1ZeuyJa8=;
  b=RJGmTpNuUUoCnVHlVPjqfbfOZ/bgzaJzM6hVn0bwea9h6bX2YghGQteZ
   FE2KogtV2cBuqVsKRAZQZHCiDeQVJnLx1rNBbl2TvIBOABqNTD8oSOCM+
   sHWHS2R34aiK7tEODso3emlWmZABub71KKa49PetQLvYXiiPmc97JwRIb
   nEA+2wG9x3Tn/WCmyE3POQcVPMefsKPTh8xUfBUdPLAvPYyZbgtpa0R4m
   7nWi3cO5bZF/gcXo7sw50gdmpoP7N9Il1SOtZqw/k3R6UVFeRhZ+59D1g
   KRu2q07zso6PXdX+9aMfqTYU8Xk25ZuzMcGchPgk3Dn0UI9HLbJ0kRkLz
   w==;
X-CSE-ConnectionGUID: nlV28Ku0RNiGQe6rbIBc+g==
X-CSE-MsgGUID: tCivfefhSp2l1OWFChut5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33759141"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33759141"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 02:21:14 -0800
X-CSE-ConnectionGUID: Tk7uGAaITRGUG7wBnCkanw==
X-CSE-MsgGUID: f92WPYw+QWu9/6ap9Igu2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="117298146"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 02:21:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 02:21:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 02:21:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 02:21:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPB66Ikj8KtuKVND3VcPeUQP1mioz1AdlA802Vx0O4HkcYhqrOd7rjZgE+4tb4aXOSrIyzffj1k5mK7lfZA4zs43sXaZQaY1IMb5pm5zp3a/McLMj7RRwN+/NCIQmUtnGO6g5aId5WUaCbAER3vOf8OAhLIGHaiiO/5VQA5yjERcof6TO9CJTO2YnhOfctqd2sieQk+xDvkIpQ68IxMF06PTpbzOgYSySnKtMrQjp/1T2jrZ/2E96Jud8uQTsJoauVB2s4H4p6TULwH4YqVNOcSP/TOfZVvqt8AilnHfkjHp8i5H0SCrhP/Oy9qGTKz3nXj+quNqIs9qkWfBk+5z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31xtzVwV6XMLW4XcxlVVsxPQQSVsUFNoc0LNI3H+ito=;
 b=jztFCK2OXyz6P5ResfFvOuSUJ5Q/IGJB48UvoQjEC/+o/OiDNDRiBZ2j243dSvzMmwhWfi88ucrco9zkw9QJ8S61jh5EyLez7RU0E5FAw3tr6Wrk9Ex5RtHH5C3brytFA6YRdNErIRF5MZ0JbkVQVi0iJKOGfS4nA+See0CnMKgrAbTB2Psa8R7sDKeTDEH9QmEYqaJryHcNRKPZ5Ld0caXobQHWeeZOdBdIxX7oXpnM+EUKiNwTx/3x/ZmvkYXEw4VvUm+Cnmbop1Wwb9UJ4DSKPuzSWjmGyCAR31Ikor4BPdERwm5vcRTMxh7LnDimdE4VK0r5joPSPCex0ph/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 10:21:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 10:21:09 +0000
Message-ID: <37e7bcc9-d9c0-48fa-b4ce-fd543defb929@intel.com>
Date: Thu, 5 Dec 2024 11:21:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ethernet: fix typo in annotation comment
To: Jun Miao <jun.miao@intel.com>
CC: <linux-kernel@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<Shyam-sundar.S-k@amd.com>
References: <20241205065218.1288394-1-jun.miao@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241205065218.1288394-1-jun.miao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: 332512b9-d474-4b91-797c-08dd1516897a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0poQTlBVy9QNDRiSXplSHM3eHk5MjdDNEw5alcycCt5VGx6dUFpWE9zeGJR?=
 =?utf-8?B?MEFjNWRDdXR1YmhTZy9aUWdWMFNCSXZaVlhhajI0T1JXaGl0UlRVVU8vQkFP?=
 =?utf-8?B?QjliSzZtTVFBWThVeHVObmloczkwdlFjQ3Bybi92eVo5WGM0c3ljeEJGa0NK?=
 =?utf-8?B?NG9UcVdSM3Mza05DWnM3OUhVTmkvZndOZWVhdFN2blF1OHpKS2E0eDN1SlFa?=
 =?utf-8?B?RnlzRVFDZ2ZNTzdLeW85WEtldVJLYVRPRVY3aDhsSUVNb0RpREhoMzY0eTZo?=
 =?utf-8?B?aVNpZGQ2UTUwc2NUTk9GMlJCNDZtRHc2TlMxQXRUZkdqdmJKUTlZTmY3cytl?=
 =?utf-8?B?bnlERVQvNkliYmVKMUorbVBLNUxZNHVMU2d3OUpBclpKRVpyQzlRcHoxczhF?=
 =?utf-8?B?QXc3dmRRZlV1N2ZCMGNOK2tLMHhRZHJLRHBmUmVSUFZHVXg4eFlWcmV0aXVK?=
 =?utf-8?B?bGdma1RHUUhaRUxmOW1pSnZkV3hkOStRQjNSNThxUGJ2WTJDaDQ2MlpYcTJU?=
 =?utf-8?B?Vld5UHRtcEJyTkRxSVU0aVZXUjFhNkIyeWc0ZXlKdXZKNnJ5RTJ1K2d1bWVD?=
 =?utf-8?B?UVdPcWptODFHYVJ2dUlpQ3pYNWV5VUtPUWljbW4xanVpb3VPWC9HWUpLOXM1?=
 =?utf-8?B?S3Q0Uzl6TGozSDVqenlHRlpmMS9LWEozMHNPbkNMc0wzRzUxVnFqRWx1YkJk?=
 =?utf-8?B?M2llYnVRUld3cFU5RkJkWUl1UDZSb2ZxcTY5SEw4WXRNYlRzQ1lEZVllOCtt?=
 =?utf-8?B?a3FZUCtwZGdXaHFHNWhMclR4aGxFSkhrTnVPczhEVnE1NmQ4bWlRUzJrWFBL?=
 =?utf-8?B?N2pvYnp1L2NLYXZVd2xwNFd3eFlMZUgvZElBNWZwbmxQU29xVCsxN1dZYkM1?=
 =?utf-8?B?bFpQRnlxRkhMQ0RIR3IybGt1SUIrTGRZVXpWdjltWkNvQndqRnBnOUwzblZD?=
 =?utf-8?B?NGhoc1lEUk1WTURLREp2aFlIUHVNZisyN2xnbDJZOGNZbmtraWtGVzhhSFU0?=
 =?utf-8?B?bnlwSXI3MGl4bDZJNHNRNGJxcWdQazV5YzVLcVBDclplQkNUUU5CN01VZm9n?=
 =?utf-8?B?VlFZbWhTc0duUG1Ca0NWWnpwUDVwZ20zbVJEc1pGajE1M1ZpUkNOTlNLVXBB?=
 =?utf-8?B?dnM3ZUNXWVhoaXJ0NklnMnJocjNieW9uaTVYZThxMHdKb1lZSDRXYW1HQ3Fz?=
 =?utf-8?B?dm8ycUNPOUFBd2h3K2hhZDcxQUJwVEF1N0VmWGJjMGY4aDRzdnZaV2VIQnhv?=
 =?utf-8?B?azJBT1pSQjVzbStRZ3NlelRmZHNJcW42a24rdHd6S1RXL0hhdDBETTl1cWpt?=
 =?utf-8?B?b1JRdjBtd0xVZUs3OVBEUFp4eVJacS9zL09pcE56dVMxQ1NjcUc0eWZjZHkz?=
 =?utf-8?B?U0ZoOCt0cHlDYnJITGJnekNwRzQxaWVNdHBpYWhKSy9HQWhpNVJQTVVGWk5K?=
 =?utf-8?B?TWxlSEF2c1dtSzQxVjBRcjNhemNobU9PTHo0NXcrWWJreWFCNDM5YWJ2elhv?=
 =?utf-8?B?SXFUd2FxK0xsWUk1YWRqQUwxeXpmV2l6cGNhR3pxYlNQSllsWkZ1ampwU0h0?=
 =?utf-8?B?dm9BaDR2YTJDYXFqRWtUQ1RONE1IOGZIaU5pYmhCOTlram5EUXhiTFpIblhR?=
 =?utf-8?B?Z1JkV0w3WlNHOTkwb1VrWmtmTFpxQURHMmt5SmJtbHZlcTZzRHJJaVE1ODNE?=
 =?utf-8?B?UHN6K0p5MlpxU3UxTFlOa050Myt5OUZJNE56UW91bHpMV0V1VXdNZzE1ZURQ?=
 =?utf-8?B?L3RCVDN1b2ROdDNjUFBxbTFHQmNmYXg5SGxqY2pHN3hoTnQ3bkEwcUtpNHZC?=
 =?utf-8?Q?G+oyOVMNJMpG/ZnlhuOCp46qL1zYRRTeYCskU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dmODkzY3RvN2gvUlN4VUVvekQvZlRUK0YxNUVhTUVvam43OThxY002cmJR?=
 =?utf-8?B?VjhSMjM3N0xVNkNQNkR4cDhNU1BVTE9YRG0wMTZSVGZiR25TRHpKT2M3LzJW?=
 =?utf-8?B?Y3pQVmU3UzdtOHdMV1dHd0NvelFmcVBhNXdoMkc2dWFZK215cm9yN3M2dEdw?=
 =?utf-8?B?andGVXovRXN4WW5YNDcvb3dhc0RMK3ZvYWQ0eGVhZW9OaWpXQzlpSVpmY3Fa?=
 =?utf-8?B?V21hcXJMMmtZYllRbnZ0MlhzeG9LVXZYQ0lZMkZKWkowYmJ5azluMmNlTjVT?=
 =?utf-8?B?V0dkaVowZjVHckFlaHdFUERzV2g2VkpPYVRJSjNyY29vMnF4c05OcmdTQW9j?=
 =?utf-8?B?VWhIR0VqTFRwWEJObXFVSWVQZ3dPWll3V3VleFNLWmR2dTR6Q1Z6aklnL2Fs?=
 =?utf-8?B?OVI5MVFwZmF1QTlIQnBmTjU0K0VqbUcwaE1NUkVsZlo3QjA1QkpVUDFwbklU?=
 =?utf-8?B?bEwzdzkrbjVPWGpjK0xzVGFsek5Gb1ZkL29UNUdnOWZTVTlGVlo3NDZZQUla?=
 =?utf-8?B?OUZIR0RORlVFMVVzUnozSk9LVGE1VjBVMStlTzFEWXZRTTlNemd5Um1mVzlD?=
 =?utf-8?B?SWR1QzlsNW92ZElqRloxM1Nqem8xb05TY2VGc25acEs5Yk5pMk51MnhzdE9l?=
 =?utf-8?B?SmpnZnNlalQwWjVxTksrNS8wQ1NzRGlRTUJ5cndpZXBkcWQ4bnRQcm8ybWQz?=
 =?utf-8?B?ZzZwdktnQnNTR0xSWnN3dHVxZEtZR0NxQkdRSURWZDM5WS9HNTBTNHAyanpK?=
 =?utf-8?B?cDg4TUhXeG5PU05DWEYxZEZ3YitBcFZ1VHZBUW5lYTVwekxVRGxubW9pY3hm?=
 =?utf-8?B?TnRlVXlQcjdSY2NaZE1ndjhrbnhlUDNuNDFiMmVqY2FoNlJyaWwvMlphTkx1?=
 =?utf-8?B?WWxGWkJ2ZURoS1V5eUUzMitLdHphYUJtT2Y3eDIvRHZscGJoOXIwcGtoNzR4?=
 =?utf-8?B?RUhBZitsWWJrQkN0elVlMFlINkNyZ1lYbXArREk1NTZSU2hqVnpCL0pvNG5n?=
 =?utf-8?B?WForRHdETjZBbnpoTzV4VVJ1cW5JTVIyYUtsZmlucHh5WSs1S2xMcUMweW5Q?=
 =?utf-8?B?VUhvTHE5V2Uxa2dpZFZqVE9NQkN1ci91MWVMb2dzc1dyN1VDZzlZbmhDWFpE?=
 =?utf-8?B?SnkyKzdhT1M0UjFtc0cwMnVYaXJOTkNaSll5QTU3RjI2clFHVFkxOG9Oa216?=
 =?utf-8?B?ekJNTkdmU3BYSmNydUtWZEcycmtrYzRDRlNZUFZmdFc0MDdPNDZ2cVFaSjFz?=
 =?utf-8?B?UWlWS1B5ayt0U3VIaWM2YkdiZHVKRGZzNkJuOEZCN05BWW5nalZydGptNzZh?=
 =?utf-8?B?N2N5MlAvL1lGRWZ2MzZvV1RlUDZlM25WN295NmZ2QWQxVUE5MUd5Qmw3Y0Zy?=
 =?utf-8?B?TlkraFJNMjBNd3daSXVuRXRhVVdzcFk4TTM0a2dicm9hVHRnWWVidDI5VzRV?=
 =?utf-8?B?RFdPb2IxN3ByUmtYVkN3dEd6UjVUcWZDajRtNlVhSk8wTEVOd0swWmpLRTZH?=
 =?utf-8?B?Smk0b0xHdWc3cFVxSzYvR0hzMTZ0WkxzZW9CaE1WQ3NVakluZTJBWDlHblNK?=
 =?utf-8?B?eWk1MnVKWkhWbnpOcHFPUkpRRWRIanQ0cUtyWmxZV3UyRS9ISUw5MGd2VmZ3?=
 =?utf-8?B?YStpSER5MlNVWUtseGpMRkM3ZEdvWCtMTkt6WTM1QjU3TzdseFl4bE8xdUI1?=
 =?utf-8?B?ckcxNHlOdVdDY1FST0lCbk1iRXVTUEdZcHJwdEQ0QXJmL0dJeVBwbFF6OTZZ?=
 =?utf-8?B?Q1NBNldMR3hRZ0I0dTNoS0E1blEvNkdMNnI3Qk1jYkFva2pYbkFBR20vcWRq?=
 =?utf-8?B?UUIxdHZoNDFNZmFvV2dtZk1nVjZHbkd6Vzl0UzQxeStkcThjVmN1amdPYWxy?=
 =?utf-8?B?RTg1SGM1ZCsyV1daVXVIS3JhcWo5eHB2d1hoZTM3VGtrQnBzSXZuTGhYUUlL?=
 =?utf-8?B?V08waTBvNlFaWFNFMVlHblU2WXB2Y3RwblorMkhMUkVIemdQN0lQRzNOUnYw?=
 =?utf-8?B?WGdwT2NTSU03bkpad1I5Njg0QWFSdHFXK0tabFBSTHliWk5SOGxoUm5FRkJm?=
 =?utf-8?B?d2dYeUsyZktVZWd5NGZSVGVEZ0NOaU0xZWVVWDIvMjI5YVEwUjJnNGVmQlp1?=
 =?utf-8?B?ZGk4ZkI1Sm5UdWRSVmM3R1ozYVFWL2I2TkFUbi9CYmVXMkVnYk5IeVRmSE5i?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 332512b9-d474-4b91-797c-08dd1516897a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 10:21:09.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3zOKEaI1ETVsR6k211ArGcVPkfYjMu58+XnjkxxNCElw2OIzWQ5LX8aWzzfun1QJJ0C7dqiMlsmkFKng2ZyN0dI/5zoKLGtt9FUbYo7+Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
X-OriginatorOrg: intel.com

On 12/5/24 07:52, Jun Miao wrote:
> It`s "auto-negotiation", not "auto-negotitation". Let's fix that.
> 
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-mdio.c  | 2 +-
>   drivers/net/ethernet/intel/igb/e1000_mac.c | 2 +-

for the igb:
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

>   2 files changed, 2 insertions(+), 2 deletions(-)

you could fix also (perhaps as another commit):
arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts:273:	 * SGMII 
Auto-Negotation is enabled by bootloader for

nit:
I would also put "about auto-negotiation" at the end of commit message,
to make it unique

> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index 07f4f3418d01..5597e7df0aba 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -1264,7 +1264,7 @@ static int __xgbe_phy_config_aneg(struct xgbe_prv_data *pdata, bool set_mode)
>   	/* Disable and stop any in progress auto-negotiation */
>   	xgbe_an_disable_all(pdata);
>   
> -	/* Clear any auto-negotitation interrupts */
> +	/* Clear any auto-negotiation interrupts */
>   	xgbe_an_clear_interrupts_all(pdata);
>   
>   	pdata->an_result = XGBE_AN_READY;
> diff --git a/drivers/net/ethernet/intel/igb/e1000_mac.c b/drivers/net/ethernet/intel/igb/e1000_mac.c
> index fa3dfafd2bb1..2bcce6eef0c7 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_mac.c
> +++ b/drivers/net/ethernet/intel/igb/e1000_mac.c
> @@ -1581,7 +1581,7 @@ s32 igb_disable_pcie_master(struct e1000_hw *hw)
>    *  igb_validate_mdi_setting - Verify MDI/MDIx settings
>    *  @hw: pointer to the HW structure
>    *
> - *  Verify that when not using auto-negotitation that MDI/MDIx is correctly
> + *  Verify that when not using auto-negotiation that MDI/MDIx is correctly
>    *  set, which is forced to MDI mode only.
>    **/
>   s32 igb_validate_mdi_setting(struct e1000_hw *hw)


