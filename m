Return-Path: <linux-kernel+bounces-321632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A401A971D46
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25A71C23472
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8FB1BC060;
	Mon,  9 Sep 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibYzerrS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB91BBBEC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893755; cv=fail; b=Rd+JyoszfTi7QaBos0t9WTAUGkNV2iKTl6IRl7d8iPlnPQi7Ia1B0aKHZjybmcW9dzU3i7+QD9HSnRlP2Pj2Mhsj/RqM/mBfGbMBuUr2GslPGPYOaov3C+IUZe3xhDlWezqog1K1Y7+zRg+a9LZcU6k1bEIhz5lM+qder8ohuoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893755; c=relaxed/simple;
	bh=/DcFm0haTP1jHc9GqujY5a5rcP2EFn1RKzysL7Bekf4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSuUjPj1PxO3ecu0kCpR6DqHLvO0kfWeyjo921pfRKzX2D3YwVmA5iT0Wak4mzKb2clnXpHo/0AMvHVjPXFVBNq9Pd+xCyYXcsTeGDhXXrcapkR9eoapNlDaSkGgdl5pFchn3B9XPes9V2O2CWATypYALkyhKzrPKTdQE7y1550=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibYzerrS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725893754; x=1757429754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/DcFm0haTP1jHc9GqujY5a5rcP2EFn1RKzysL7Bekf4=;
  b=ibYzerrSXo5k1e7CTcUPavOhulYQKVJMYjXH4zNmaELvMyzJxSwg0RK7
   y2MNYz5M1JQ6ok4uqf/ei/VN77mqd/161w2efVftCOd+4EpJRP359Batw
   amcbqiy4RwGMU6L4wYNMo2ZzIihWmdop/MlSoFddeRbeOAKdRXrsj9XIO
   vdxWIUgFzq1Zj2mRE1MhK38o1xyxnwLuws1KOrYogjLjRWIQaiJg2QXl3
   a2SEw9z8eHn8euSwGHJhEIWXnNiL7XLs08vRpFXfynAUzWQ3T7+1d3KPe
   L3dAUuiL+8uWYyY6at4PLTLYI+PyWPJ+hvvZ+mLDUh2s5H4Liou318gU4
   A==;
X-CSE-ConnectionGUID: B+zHq8bxQtWYaoVlwLNAhA==
X-CSE-MsgGUID: mGikkUktRUefj7OnJccIpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24470252"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24470252"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 07:55:53 -0700
X-CSE-ConnectionGUID: akRgXr0PS1SAkFuh6ZyLJQ==
X-CSE-MsgGUID: mHof/zKwTxqScdhw0ktLuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="66326587"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 07:55:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 07:55:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 07:55:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 07:55:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vk3kTeH9w0Z3MCGJIXkyfiDZmPgV1G0Y0f6eck8HWy7HN4gUV3guza//LMeJp/+I2rZiNyruKSg5ewMZRjh/TcnaiqRk9QkS1+u1V7fYcIUy/h3e+et7OrCBRggNs2IgvFPi3sWM6XW9C0lUh7Uy0CKeSgl4IxuMIW6Pr/Zi9FgU1iiadSMqN8fBk1kjPpXL0vTwV4ymI3TT0qagdESt/HNqQwrylbcmxaqDdFgSOAfw2i9LACf5N1CnOOhtScYyn5iz/6AaH2k6rhlFNVP8UCcEBzOmHmubDoFWeKWBF9ezCd8V0fpvq/IoN4jHEDZSDLc1U5ugHpBoj49WZRjtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok36XLgwHlLGRaMJoa5fulYAFvzDrMZkDT3BcGdjYAk=;
 b=KWLsOIVbKRZoD4F0tIdk2IHnNgxfepE5yloh6yLlrd/tP7rt9cjTERtCAFKb4lNJ3WQXz6qFFdnHdZuiZ97z4qY0RYkVXK6iUd9dmguBsvPrwYYCDeCqKDIwFJACW5zYJ2f9Aqrgsm+lYj8WOdQg4p4Sf5oQMA5pwEHLbiuKwvAQMSSUMaX1tf/SBRsvRKT0aizviclNSVLpJG1KlNvtc23Of1xcoq5S/q8trvZKdx9bwQmtd4QX/4qGUIWNY6MVFQGNYsPyap2PeUcyO9jc02CMCT+5wAEZBxdNLs0a7jqhbUfrUQm+yKQDP857IC9//dZSZQ/2ed7iz5Me8ETSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 MN6PR11MB8172.namprd11.prod.outlook.com (2603:10b6:208:478::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Mon, 9 Sep 2024 14:55:49 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 14:55:49 +0000
Message-ID: <b1965018-6663-4bf5-b8e0-8210d0429333@intel.com>
Date: Mon, 9 Sep 2024 09:55:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: Alexander Graf <graf@amazon.com>, Dan Williams <dan.j.williams@intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <10ffa4f1-e3f9-4b7d-9a6f-e4dd843f6d44@amazon.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <10ffa4f1-e3f9-4b7d-9a6f-e4dd843f6d44@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|MN6PR11MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: cfff6d91-ed69-4c95-2641-08dcd0df7e0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qi9wR3hVaXRzZU1XSkNpT0FNOHlGQVVGMU5qVHZNNHM5VlBqS1RiY0U1OERY?=
 =?utf-8?B?Z0c1L1ZvK2h0UnFHcVB4VmJEZTZza1FLTUYydHpkNGFRTFpGNVJxTUNxOHN1?=
 =?utf-8?B?em9VeEhSNUR4WjY4Snh3Vm5iWG5zVG0wcFB3L0lTcmd2UlRtOVdVdmhLb3Bj?=
 =?utf-8?B?cXljanNKWUMzWS9maGdTNzgzTkpINWczTWlFWld1VXpBNVB1NWdXOWxsVVc0?=
 =?utf-8?B?YWl1NTgxdFN5MXNHWFIzZGtQQzJQeEQrK0hMNWdWVlFtS1hIb1Z2WVlncUJM?=
 =?utf-8?B?aWZIMXc4SFYrYzExVmdSU2pmR2hjUk5TQWV4M3ZnMGY5YUliUDVaaVg1dFh4?=
 =?utf-8?B?NVJVNU9wdXk1OUN4RWh4NDY1VkJka280Yk1RSXA1OGhveU90RXpGZzd6WXl5?=
 =?utf-8?B?OFp3bCtSczhoWkgxd1JoUWgxVGZmMUM1K3ZuYlF5enIrN3RGb25zTkRIeDA4?=
 =?utf-8?B?WE5Oa1VxVHhIMi9kR29TaEZReFMwWUVNWjZMTStvQXhUbVlBV01NSFhTYlhL?=
 =?utf-8?B?NGdad24rOWhLNzNObll0VjZQdzI1U1hGM2M5R0MvV3Nnb1JkeGlIbjl1WEJK?=
 =?utf-8?B?UzJKS2xFNWR2QitZcHZBUkVKVTR6M3g0TjlyUWI1Q3VQQTVxWW96OWszT0xu?=
 =?utf-8?B?cDdmVys5bkJVUUJlcDVsaWdiTitKbWNlNzk4RFQ5WUUrVmQ4WHIyMUVHVUZy?=
 =?utf-8?B?OUkxYmgvQTVENENrNjBJalZBVnFtMW9kYW1YbFZwd1ZQYnFOMTZTREFYNlpF?=
 =?utf-8?B?QWM3bG44eW9BNHM1eFNaUTdtOVFuVVFtTGZzcHE3ZUM5M2laT1lVbWhKUUI1?=
 =?utf-8?B?UG5jeGx5YlFsdzRQYXdoTzlKaXRabHZJcE50cEcwQkNnK01ydHR0U1B4eUQ5?=
 =?utf-8?B?Z1NJQzc5WjloV1ZSdDVFdk51bGhOZTV6ZGtWRkkzRm1KTGhwbkNXTEVjWVdO?=
 =?utf-8?B?Mm15M3NuQ29oUGNDaHFpejBNVnBmTjQ4OGVQdGorZnpWTjVMaHZaNjR5MnEr?=
 =?utf-8?B?R0hhb3dGS0Q1VXR4Q0RpbGdCaFMzR2V2RXJBVUxyZ1J0YVBObTVOVmd3U2c3?=
 =?utf-8?B?eVZ1TlFmbW1zZVZlNU9JTWNYVTk0UlhvTTIyQWN4N0lVdURkUk54Vlc1Qjlz?=
 =?utf-8?B?MFNPaXR4MnVuQ3FxeTVJUFBzOGlBN1NpaXdxeXFidGNrL3JGRWJVYkt4cWdz?=
 =?utf-8?B?T2RZVmE4SkF3VEFZOC9qRTd2OGN6VGpaYktiSEVjTEdIRHBUWEl0dzFINjZm?=
 =?utf-8?B?aTdDWmgzSDUxZURmZ3JGWTdyRk1Mc0xucExjWWpCMXFlWS9Td0plWlhRc3Z3?=
 =?utf-8?B?anBIUHFmUmtlOC8rb1RPMjhHVEk0Yll0dDRXdFp3Qnl5dUI1MHBDcC9tMi9G?=
 =?utf-8?B?bXhRN3k2UERlRkdBdjZMa1lYZTQ2SkhncE1VcUR6MitBVWNPVW44SE9Xbllp?=
 =?utf-8?B?QjlSUm41Vk9yRDBmQkxpZEN0bDdtclFLSVEySnF6RHBGNmluYi9qa3QwN0RB?=
 =?utf-8?B?Wnh4Y2VYNUdkenEwVEo4V3g3ZER4QWNIZVF3MUs4aVBlZ1RMTStWb2dqdGZX?=
 =?utf-8?B?MnZHU0wvL0hrUzJ4b3k4Rk9pODZ1d2V0T3RVaFR0OGFPWHE4RkhhekZhalJQ?=
 =?utf-8?B?WnNHTUdFbVJvWUVyeE1oZDc4eVVqTXUvbjFHdk1TUE1YRk5HWDZIRGRscVFV?=
 =?utf-8?B?MWwxc21yd21sUGlqeFdkUUowN2RHTS92ZHNVeXJwMVU0OTRYYTVZRWpjNk9B?=
 =?utf-8?B?emo4bC9VY3Bra2h1ZWY3R09RUlFrVmlnVEdHWGZidGJ0SGZHcnNaamlySjN5?=
 =?utf-8?B?U1grQXBNTTdndjdYUFNpUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFM5MDNvNWVSNlFnK0w0SFo1aEkwZUMyMTdJQjRVaFZlc0VnV0FSVUVQenhn?=
 =?utf-8?B?bmRHdTh3Z09UTVg4VWVJZXhKQ2M2eXprVmZCR0U5VGtDM1I1d1pjRmx4dFFQ?=
 =?utf-8?B?Rk5idFdWODlZYUZJRlVEdlgyYmJZUjlkVk5ycHloTDZEZUk4UFVxUDUzaDNo?=
 =?utf-8?B?cGNDUmY4TkhkWGF6dmpwak83UkdRNWdhQzZlTnh5NHcxSEpBUDgwNE5DR09o?=
 =?utf-8?B?TGUzd29IU1lUTS9FZ3YvTUVYelZ0VXB3Q0pCUGxvczJFSXhrUHRUckVSd1dD?=
 =?utf-8?B?Q0prSHlBNzBlWXlUMG9DN0ZiYUtaZE52clZSK1VHMVQvY2krTDQzTzdxU2NP?=
 =?utf-8?B?Mi9FYXllMmdvSmdJRUxKWmR3dXFBa0tjSEVHRjhMMWVhZ2FtTTR6cjVEWG8y?=
 =?utf-8?B?T2ljUTRuWFNCWFpjR1o0V2dyV0hmVWcwYmJaenVMYmh5OWRyVUQ2S1F1RkVq?=
 =?utf-8?B?L1RSTlZDQy9QWTNtSkY1bmEwS3JCT1ZYeUxkNGpzYyt2Q3pFRGdHYTdBMXJl?=
 =?utf-8?B?c1VlM0toc1hEbkVwTi9iYkN2cWlSV1FJekhnWUUwTnZ6YnJ0b0pjOXRCQXVs?=
 =?utf-8?B?N241UkV3OUlRZHJ6Sk9ab1dkY0hxeUM5UU1MN2tuS3BkVWlhUnY1bThqcFkv?=
 =?utf-8?B?R2dDelpiSUpYeVM3NW0rN2ZJNEFjcCtXTFA0OXFpa2dSVnF3RjFnMW14dTUy?=
 =?utf-8?B?VHk4ZElZR1JqQ3ZMVTNKWnVScjBOQmlTU1cvTkI3aHhCUFNraXFFZU1qUzZO?=
 =?utf-8?B?QkdRVEJIVTZEVnRDcy8rMlNuS3NsdnI3L01QRTNsRE8xVXNwdENiZm1oZnNF?=
 =?utf-8?B?ZjMwdWo4bmxJdmRnajBSUUQwcnZYM1pIQ1FsODcrR1dra05jM2wranc0MkZQ?=
 =?utf-8?B?L0tsRzNjbjhvWlI0dHc1cTQzVW16R2d2MmZBR2J0WUU5UDV1clBPNktQUzBL?=
 =?utf-8?B?d0FKN0R5OEtleTRQVkh3SDNGOEN6ZVhGSDZpTE12MDV6MW9jbUsvOXRwdnVC?=
 =?utf-8?B?TTFYOStPazVwRW9QdFUxVVgrVHdEVFN0NG9lRXFUUVI4YjVWT1hveFdFZU8w?=
 =?utf-8?B?eEpBTkc1SDNOMjdYV1A3bXVsWkMzWnJTeWFrSWRLU09NZlN4SEVGTlVORmJi?=
 =?utf-8?B?R1Z4OEFUd085UGtvZThqQXF4ZFJGcDlGTVU1blBuTWRmS1U0dUxDUHFpSzZq?=
 =?utf-8?B?V0NjamdBQ0JFQStzdklzOGYrZit6NWxiTjc3bkRQY0FkM1hNVXZYbk5lNHFF?=
 =?utf-8?B?TU9wMi91SjZiYkI3MEtOU2xTQlRhTkpJdmxJYzlvYkZ0VFFnN3BiZTNpaGFv?=
 =?utf-8?B?bFNWT2M1a1NuWkZ3M2FTeWFubXB4TFZoUkJTV0hPLyt6c3J3cGl5VzU5VDEy?=
 =?utf-8?B?dEFWTGwxdGtOREwvTzdidThVYzJuc3ZiVkkrck9jWSt1NDZzM0NPQVIvSExl?=
 =?utf-8?B?WC9mOGR1eCs5R252YUluSzlDSnpPcHV4YkpnUVpkck1LMGl1WkRXMk9Va29G?=
 =?utf-8?B?THY5S0dBZG1lMVlFeGwvMVZFTjZYSGdHZURRaEpnSXUzSHFxZ3JNMjl4dWwz?=
 =?utf-8?B?R3FubnNZTFFFNm45UlBPSnJVNnR0OTE4Qjc0SWNEcm1FR2syeDdKZVJBZHpo?=
 =?utf-8?B?ZEd3djBZbkU3b3RzNjcwNWFtU0hwUGdoZmw2LzFQcVpvVVZGR3phTTZycm1k?=
 =?utf-8?B?QmNiZW1GZWZrREdJT2dtRzcyWEduRkhzVnBDTVZJanZTSFlYL0NDYWFPdXAz?=
 =?utf-8?B?Z0p3TE9RS0RPZXZQZ2NLcFhZbXA5cWkwTlpDVk4zSU84UFpWbzNlY1FCbUdq?=
 =?utf-8?B?ZDlsL3ZQYTNxVFZFaWJDbG5pbjF3SVdvckRpNUZIOVZ5RStDVy9CSnlJa2RT?=
 =?utf-8?B?cGxkREsySGF1WkJQekVnTlp2SkxFeWpaWlpScWZmVkp4WDdmL2RrMjhJRkNH?=
 =?utf-8?B?b0VHZ2tlK09VL1lvOGdsNjllZzlXQmlKQkg5OTM0OE1vY0NHYW9Ja0xJRzR5?=
 =?utf-8?B?OGxTN3RpRHN2NnJBTmJXRXRYOFQvcFZCQTdXR21PSFYrZDJFa1hoMCtTVnc2?=
 =?utf-8?B?cjNodzZnQk9rTFh1ZVcvQzhpQUJpaWxYM2VmTlVPTGR4QUE0cHVuWWZGNkY3?=
 =?utf-8?Q?GSoGbgPwDePcptOs+1k6MDgqW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfff6d91-ed69-4c95-2641-08dcd0df7e0e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 14:55:49.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJtlNvWpcBgLgUurq1+xTeSs8cZR53KyPVIG0y9shSeugv6+XYLbv2cxZCplEZTYd/c5HsOJv+zETkv6qlr3/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com

Hi Alex,

Thanks for you comments!

On 9/8/2024 12:37 PM, Alexander Graf wrote:
> Hey Cedric,
> 
> On 08.09.24 06:56, Cedric Xing wrote:
>> NOTE: This patch series introduces the Measurement Register (MR) ABI, 
>> and is
>> largely a continuation of Samuel Ortiz’s previous work on the RTMR ABI 
>> [1].
>>
>> This patch series adds a unified interface to TSM core for confidential
>> computing (CC) guest drivers to provide access to measurement 
>> registers (MRs),
>> which are essential for relying parties (RPs) to verify the integrity 
>> of the
>> computing environment. The interface is structured around
>> `struct tsm_measurement_provider`, which holds an array of
>> `struct tsm_measurement_register` and includes operations for reading and
>> updating MRs.
>>
>> The MRs come in two varieties: static and runtime. Static MRs are 
>> determined at
>> the TEE VM (TVM) build time and capture the initial memory image or the
>> configuration/policy specified by the TVM's owner. In contrast, 
>> Runtime MRs
>> (RTMRs) start with known values, such as all zeros, at TVM build time 
>> and are
>> extended with measurements of loaded code, data, configuration, or 
>> executed
>> actions by the TVM guest during runtime.
> 
> 
> Is there a particular reason to treat runtime and static measurements 
> separately? In Nitro Enclaves (which I still need to add tsm integration 
> for), both are simply NSM PCRs. "Static" measurements get locked by the 
> initial boot code. "Runtime" measurements can get locked by guest code 
> later in the boot process. But technically, both are the same type of 
> measurement.
> 
My apologies for the confusion! They are in fact treated in the same way 
from the CC guest driver's perspective.

Here I meant to describe that static and runtime MRs have different 
properties (like "locked" as you mentioned) so in order to treat them in 
the same way, we'd have to define the properties in code (i.e., `enum 
tsm_measurement_register_flag` in include/linux/tsm.h).

> In fact, other attributes like an additional "hash_algo" to the 
> measurement itself can be useful in general. If the underlying 
> infrastructure allows for a generic event log mechanism, having that 
> easily available here is useful too.
> 
`hash_algo` is indeed a member of `struct tsm_measurement_register`.

> So I don't really understand why we would treat static and runtime 
> measurements differently. Can't we just make all of them directories and 
> indicate whether they are (im-)mutable via a file?
>
Distinguishing them in the user interface makes enumeration of RTMRs 
easier. Also, there are RTMR specific artifacts that static MRs don't 
have. The most obvious is the `event_log`. `hash_algo` is less obvious 
but it is in fact applicable to RTMRs only (the only thing that a static 
MR has is its value). Adding those to static MRs would confuse users.

-Cedric

