Return-Path: <linux-kernel+bounces-447978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF599F3976
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42788188AB82
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A888207677;
	Mon, 16 Dec 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErAuBIKh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE32F5B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375928; cv=fail; b=KfFLOGQT7+2UEvOmnZTBJgKclI8bm6EGTjhbGYIJyTg0nTe4uNpjSyFmAzL66NpW+RR10ERypEp3EOPlKZpw9gnGG2nukmAu+azNbd9192nfO9t3d1qBYtVyNWAXTlVgG+dcTfDnMaAdqIDoM5j0/jG7WowAsYgyL6xgqYK3n5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375928; c=relaxed/simple;
	bh=w1t3C8xhD4XrZgoY3UBwjoe6ZDNSjb+UcoL/TYYfNFE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPXQ1gJFL4Zby0LL52fFSO7Kfv5GxnB9I5y2VlcgJ/+vvc0QFv5oRHaK+L+kCC493RNsM1bWu67N9IPqFGdZXB9kbKMcsZjhXbCFw4G2deiC/jsHFp2S4UzDT8Ge8IBEoSxTqj1dwb3mtP7XrY1VuyYD/SP0AlHGW2P9eOJJJuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErAuBIKh; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734375926; x=1765911926;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w1t3C8xhD4XrZgoY3UBwjoe6ZDNSjb+UcoL/TYYfNFE=;
  b=ErAuBIKhmF6LkvCvSeS71b54cZYY8qbegSBPWOZ5z6YBhQ2LYWEdNDUF
   KbeSG/FihmtRZg9DGY1XR4vEiDnd3xzKdWuU1rkKb62djFcZM0NuuBZjy
   RWICcVrRnEsHrnGHHggfdwaxN0lw95BSUAdY1D2u2k6AKeqCq9aFTOd9D
   unItqFG0RAQiJrOpsHG/CrluFuEbKdfQ240NK9qkggjg0vaAFdRWRQ9tM
   dVMBLTPxtX14hkpgUyZ+IlyW9NZtlapB8vUdzlcl1nzPtXnCuoFCSeZ1M
   31P2U0D+z7vrwfBJxgffQ9wX8lT7QT/YzVHEzlIy9R2721jbgkxRr5OMP
   A==;
X-CSE-ConnectionGUID: 0sVw0YsETIGs38uPDGV2NQ==
X-CSE-MsgGUID: UaxsJc8DSG+U46EQYpkqVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34934363"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34934363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 11:05:26 -0800
X-CSE-ConnectionGUID: 2iAZzpLwQKa624h513hBkg==
X-CSE-MsgGUID: KKeNuYJLS1qwu3uJvwVdzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101440142"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 11:05:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 11:05:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 11:05:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 11:05:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZL5ZIiJX4p3X17WNkNY332LcG+SiOZUbzWC3q3HGAuNW6z29O9qZvGvotUqGkY85tK2R8DR/KULZUQQFAJLdOe2yFpmm5ir+GZB1utlgEiC9FaL0QO3G6dqoNKoj6GKNF2jc8NhTNIqzfEjwyW/PS+AXsFfRzxl5Szrn31ymgiKdgzLLx3alTQgMTmGVSm+t610nvubE1pU/I3eIIaaoIGRD8ldWwanum5rqzoizhFCbTVWueRed1YrRLIcVkVUEocdmy7SDWQ2DCagJptKUK5KQAjkV09G+2/cVWh5e9IPLIjrC4CyKVC7YKsaA2rXQUh7U23mK8XaAS+8Be/r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hscvhq6PZLyjdY0xob0wKw9DSJoL5dsJ0v0QLUgytkM=;
 b=mzJ50wXcR4Z6XNyulWYHg7I8brr9HvMGWD9qh9YB5H+YBiDGD6bu8hT6kcftcJBdbAt9Dh/ZpcEn1dXAXuAr/WpXyg/pREXXMeTrsCrBRcKFWccRl15zpHZdL1P5UxYxY25U90svbQndd9+ohFb0d2HOUAvpP9CtL9GAm8LrJKhm9fc8oqD+ZzBk2PSMC0VErRtEmATRzTmuaEZMn8dXYSSEjZ+FyAgv3LfoinzQHQCR2bHBz4fRYlo8pAlHspCAoeMYXIEVRyPBiKCDhbBJ5OXpiUC5YpY4LFQocnKIgFip5QT52EuiH/ZqKb4tMSRkL1nafWryZq6VzgiVFxMXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Mon, 16 Dec 2024 19:05:13 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 19:05:13 +0000
Message-ID: <f3d50e5c-5779-4cf4-b279-31eeef2462c6@intel.com>
Date: Mon, 16 Dec 2024 11:05:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] x86/fpu: Remove unnecessary CPUID level check
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <bp@alien8.de>,
	<rafael@kernel.org>, <lenb@kernel.org>, <dave.jiang@intel.com>,
	<irenic.rajneesh@gmail.com>, <david.e.box@intel.com>
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
 <20241213205038.6E71F9A4@davehans-spike.ostc.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20241213205038.6E71F9A4@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: e5763dad-15c8-470b-4ddd-08dd1e0491a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjBkN2RWeWFDSmpudU42ZWhUblJsMnJEU3FIc0FRKzlQYkpCRWV2bHF6MkFW?=
 =?utf-8?B?QWc0STd5THkvdkg3MFd6SmNtcFBaT0pEWStZOElTc29TZjFxcStjWlRkUmtB?=
 =?utf-8?B?eW1jRjlsTTRtdkJvMjAyZXRSSE9pVytLMFpJYVNkVzNFbVJFcFM5b2gxNG4y?=
 =?utf-8?B?Z3JqanRUMEVLV2EyTWdmWlhCRU52VnNqZjM4NW9YRVh2OWVGWitNNEFhOFRL?=
 =?utf-8?B?MU5XWEpWTTcrYUJsMERJL2lJd0EvdVZWejdlZnlQa29Bc3g2V2tvNTVhcjlU?=
 =?utf-8?B?Z0hQaGEzeEt4SlBrY3B0eGpYeC9qQ2xEeEZlQStBbFNBeU9xdnQybG1GSTli?=
 =?utf-8?B?ekE2L0NwMXlvUVlwdzVEY1FpR0JZYnN1ZVBsM2RjbTdnTTJpbXlrNWZabnNn?=
 =?utf-8?B?dTJnbHdjYVlQeUxGaGUzSlpleEMrVGtWOW9sVWpibldsKzRTaXhiZFhRbTZa?=
 =?utf-8?B?QlZnbHhmU2hFSHYveE9VdnVVVnFJK2NNNDdqR3FYTlVKREprcHdBNXl5Q0p0?=
 =?utf-8?B?dXplVkNkdjVzb1NGRlAzN2NwZjVLOFVTQ3h5dC9adEtaYk4xYU9YNFNMWCtj?=
 =?utf-8?B?WEtEVVZUZlNrM2RQczExZEdoUk9OeC8vcHBpMS83azMwbllGQkFtQmxqSjZ4?=
 =?utf-8?B?OTUxSzQrTE9PS242dFNaNjBPcUczWWxRZHk3RFF3Z2FqQ3NBT2ZaV0orU29Q?=
 =?utf-8?B?K1JsQXlqakhVc3Q3NnRJeE80TXFNcjBnU090UHB0Snh6djN4VTBHMm5MK1Nx?=
 =?utf-8?B?YkgzSDJOTjhiYW5XdWs0S242NXdzc2YwdW12OXVQTjU0M0JVYmdEU2lXb29r?=
 =?utf-8?B?RkRNa01sdHFPNldwLzd2d1VlWkFpSHAvdlhpdkNqMUVRNU9mUW5oYWIwS0hh?=
 =?utf-8?B?WVZ2aW9ldjd4U2tRYkFKSXR4SFZIT2ZZWWRjQkk4K2FlaTVWS2NhdVp1eDNr?=
 =?utf-8?B?c0FROE91MHdUd3BZMTdiU2JucEhqQkJGcWdXVjNUOGNpZ3lXR3Byc2FFYzkz?=
 =?utf-8?B?Mk1sS2pBZTZTR01zaVBsVElocmd3VU5xWlNUK3p2NTRkMXVBMEZQaG1zaFpw?=
 =?utf-8?B?YUFxSjNiUEt6L1pOQWdwamloazgzaEVYRkgrZWwzdVF1Qkp4Q0w1MlBZRU90?=
 =?utf-8?B?bUNTUXFHekdCSUFBaHFRZktUVGhBN1JUc2RxVlQ0SVJ5UXo5QkdsaXlvUzdm?=
 =?utf-8?B?bVNlQmJXcnFZOFZGSjVaZEJSbkZPUUJQME13UU5SOXVMTmtUTEpMb1dTRUti?=
 =?utf-8?B?TUpuR2czWGJkMDZ3SVFsQWRYK2NRZzk1dHdJRXRyVXlZbHdZU21kaWZPWVpY?=
 =?utf-8?B?aHJGRTZuSVhSQm1HWitOakppUHFpN0Ftd3dDaHZWRHdNOXN3cUQ5MGswalJZ?=
 =?utf-8?B?SmE0VWNNRUxUQ2s3RFgxSnBFTmQ0dTQ3bHU4UmpHLzRGUThKNGx2dlg0SVZV?=
 =?utf-8?B?MndKYnJSN2RHVUJuK2FuWmxvWkNDSm9yYkhuQlVkL3pKcXd6eGNrdFZQem91?=
 =?utf-8?B?QUtoSXVyeGc3cUdoS0ZFMGNxOEdPc0UrMWh1cmMyMGR6dlowcnpNcmRsS2pT?=
 =?utf-8?B?b2krZzBwTm5KczFlSHg5azI2YUZtL1E3azcvTDRKZ3VPbXExSUtKeklBTzJ5?=
 =?utf-8?B?YVBBTjBycjJud3VxR1FoMWNCcWZnNmJIYlVaWEhGODQ5NklpZ29DdmZLRVdQ?=
 =?utf-8?B?TGxXbUUrVTlsVHZ3bDA2OXRlS2dVeEtBVjJYRkNqRFp0VU1FR2tldmJ4NCsv?=
 =?utf-8?B?S0RPdHo0ZStkbld2bXNvTkx3MFlDQWZaZitocldMQXlmN3FKaU52OGsrSUV4?=
 =?utf-8?B?WjB0eVVXaitjdlVIckp1OG9qTTQ1QnQwbG1QV0cydFh0UW5GMHppZWMyVHV3?=
 =?utf-8?Q?uiBqWqNfbW0Y5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXYxbHBndjZ6Y3JsMEpIejJMWmYzTGw3aG1iVHFqeUhqcUptODcrNWRPSk9G?=
 =?utf-8?B?MmxQNGo3aktUcm5IQzl3Q1NzMUxNWnZvMnp3UHVpRXVPZUp4K25sNWtXMTQ2?=
 =?utf-8?B?SmFYS01PL3FHMldyVmFEd1NkeWdWSytIYzVGZDI3VkthNFpLaGRLNFY1czJR?=
 =?utf-8?B?ZDV6R3FJcEt1SCtjTVM3UStKSENsSmVWQ2tPUFdEYmNNdmxtUmFCbDN4dWky?=
 =?utf-8?B?SEhBZTdELzBHalRjZU40MnJtWXNZcldVN1BRQXpPcUQ0VDVRTHQrRGxJWVh0?=
 =?utf-8?B?TW9wLzM2aStEcTErQldicjlYNHJRUVVqd1piNmhvVjhWSFdLTkk4Mk5zUzJx?=
 =?utf-8?B?SlQ2emVCZGNhaXd6QjE4enAwQWpweDVKU2hVOTIvT2ZDbXRSQ1cyQXovZURl?=
 =?utf-8?B?cno2cGZadFlTdjRoSitQSElIcnFwOEUwMVFsanpWMmxyYlJLTEphd3JVL0ZZ?=
 =?utf-8?B?dCt0M2hxNUhQRXdFZGpjNEs1eUNFaVVFVlF1TGdXWmk2WE5kendyQVRncEx5?=
 =?utf-8?B?dG04ZWZpcU9PeDRGdEFrTXZWOHJFSU9vd2FENlpEQWxPWHV6VU81MzRVcUpv?=
 =?utf-8?B?WkdDaTZGcmw3SzFSRFFkQXZKdW0reHpxakkrWDAvOUVxMmc5UEF5K0NCY01u?=
 =?utf-8?B?RG5uSVFuNEw5eENMS253ZThuVEJOSnVpakRJYmJteTh4MFFyK1FrLzBXSEIr?=
 =?utf-8?B?T1JDUjdsaG5JWWZ5emJ4WUt5NzlLd3pzYVZ6RXBrb2RmdDE5L2dRblpib0pF?=
 =?utf-8?B?LzJBY0oySUZEMEk1V3RpVTV2c3V6a2p0OS9EaTZjekNzTzdScE5DYzdzcUc1?=
 =?utf-8?B?bVl0U2VTUGQvL3R6LzAwdXBib2U4b3k3TS9WaVpwMHA5K0xzby9mUVNmSHBo?=
 =?utf-8?B?N1N1T09RMGU0ODNHMnZDaithUHJsT1hxVk0wd2VqcitxeGg1QlpBV2IvQVlS?=
 =?utf-8?B?T0tUcjQ5UFlxS0E5b28rR1dzNUpGb05MZzdGb3htc0lnMzYzY2luRXhNT1cr?=
 =?utf-8?B?cmpKTjJoTERleXF2ai9FcEIyUWtoQWhUNENyWGxDenU2NFFxdjRyci8xK2hH?=
 =?utf-8?B?U2llSG9vWDd3WGxoNDhzUlRlbWVoQ21uRlE5NkFGUjlaU2hjSW4yVDN3bC9I?=
 =?utf-8?B?SG5VVGZPVHgrVEwvOGo0M1FaRnU0VkUzeTk1bnQzSFlzUWJXblYwWEYvWXE2?=
 =?utf-8?B?TUpnWHNiSC9sM3dpak5BVGtWeU1sUG02eTRLOWcxMG9DaTR6SDhtZlJVMmZC?=
 =?utf-8?B?dTI0cTJnNzREVTE2VHR0NHMyQVY2NGVIOGdSRFRSRTVmbVRtQ1ZHOHloTTBx?=
 =?utf-8?B?NVY2ZE5TcjJJWlZrSVRKSjlDSGpEaE1lZEFKYTNPZklkNVFRbDY1aW5ZY2Na?=
 =?utf-8?B?RGUrN3ZMbmJZaU9WSy9EUHF5NnhTUm1MQ1FWVHJ3RGhEZVorRDVXYm5qWXFl?=
 =?utf-8?B?WnN1RHlBcXB6MUMrdkREMnBhcTJPekViU2EzajlqL1JVK2g2c1pBc1crSW5G?=
 =?utf-8?B?QjgrWnlCc2QvVW9SSFc5bmNqNjdzSkdpNWJMQTdnbmJKdFhrMHQ1eVRTajZt?=
 =?utf-8?B?TkQ3M2F1eS8rZkRaTUErRWZtRjBqU0F2c3BJN09uS0d1M1pFc3F5MSt1U1pC?=
 =?utf-8?B?RXEvN1BmQXBLSkpBbTUzNFVHSElmbmdUTUFSc0U3UUJQK2pKdngxbzRMejVh?=
 =?utf-8?B?cU8zYTFaTjFhRUJvMEV5N3MvQkkyYVBVdTNsMGlpYm0rMzM3Zkk5L3hzVkxF?=
 =?utf-8?B?d25qNzFJTHoyZEN5c3huVkRkZktYRVpVc0hEWG9OZ2tBMThpNDI0eUR4Mnhs?=
 =?utf-8?B?UWdUbXgwcnk5dmhVTEpEZkIxcFZxbWZYdEdrM3E2KzhzYncxWkw0NldvRWFF?=
 =?utf-8?B?QW80QzQwRi9yV2RWVGpETDdKeGhUdDlrUzFrak9pUGl6Z2N0V3JWZXAvS1ZO?=
 =?utf-8?B?MzUwVXRmWDkxMTdBbUZabmx1RWtyN005T1hEb3BtRTFWanY4TE40eU4vMnNL?=
 =?utf-8?B?VEprQ2hvRG1hdFdRS0tPSHc2cGZBTzh5ZXRUemJURldBZ1JHc1RJKy9OWWxr?=
 =?utf-8?B?bzd2Yk5KZC9SaUJQM2k4N2lic01VMm5qS2FGU1pHWFYvaHdUOXZRYno3MllR?=
 =?utf-8?B?bkNTUm1CSWdnWUc0RitqNEZYZ3RlNGRPamxGYjdOaFJzYWJOdWZwNnM2dk44?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5763dad-15c8-470b-4ddd-08dd1e0491a0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:05:13.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AHH0tdyAZes8tg87GIGM391IRRzpsq6TWCy2NQZposjhmLR/Liy6gHjc3ee+2z4oEksdftP4FoM/Og6RSOKTUAsSYY0vUvnzzZtMD/DxKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
X-OriginatorOrg: intel.com

On 12/13/2024 12:50 PM, Dave Hansen wrote:
> 
> diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2 arch/x86/kernel/fpu/xstate.c
> --- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2	2024-12-13 12:45:36.903226562 -0800
> +++ b/arch/x86/kernel/fpu/xstate.c	2024-12-13 12:45:36.907226732 -0800
> @@ -764,11 +764,6 @@ void __init fpu__init_system_xstate(unsi
>   		return;
>   	}
>   
> -	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
> -		WARN_ON_FPU(1);
> -		return;
> -	}
> -

I think this change effectively reverts commit ee813d53a8e9 ("x86, 
xsave: Check cpuid level for XSTATE_CPUID (0x0d)").

At the time of its introduction, commit b38b06659055 ("x86: filter CPU 
features dependent on unavailable CPUID levels") was already there. The 
cpu_has_xsave flag (now boot_cpu_has(X86_FEATURE_XSAVE)) should be false 
for CPUs with a lower CPUID level in this:

void __cpuinit xsave_init(void)
{
     if (!cpu_has_xsave)
         return;
     ...
        xstate_enable_boot_cpu();
}

Then, the sanity check introduced in this code path appears redundant:

xsave_init()
-> xstate_enable_boot_cpu()
     -> setup_xstate_init()
         -> setup_xstate_features()

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

Thanks,
Chang

