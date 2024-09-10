Return-Path: <linux-kernel+bounces-323873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7FE974483
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A27B2592E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE31A7AEE;
	Tue, 10 Sep 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4FDNJjc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8717622D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002363; cv=fail; b=dynieBj14wfT3eS75iuwvuE3BbE8BM2wzpdD1lFLZKpHcaJx3gSOSoLHGQDLn9dHucavPDVpetlwvDosl5b5amlAarD6lgU6fBNiN3hfH4erzRmZcANbwBYZXFCK2hWCtaNb9nGOOcnSyhebqBLQIMCmRG3rGqO7O6wYRgLeUeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002363; c=relaxed/simple;
	bh=NNES/qmIfSyfcLL6AV7gDZox7wNeyeqOs9dVPnwtfHg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xe9WnMLzhxAEX9l+8+FI5XYUj833N3va2BwhrVLicghjIQJrvYJ8uW8unXeNUca1eGf6Bw+jSva1swwTwb5hBT8xx2TJ3RRK3ry2S3YDCq3ItXC8GaCRrRpiZCr5zMqemk3jwPtq0sDBChsUNdCU+kVX+EQIxCIWAEBJP3nMOkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4FDNJjc; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726002362; x=1757538362;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NNES/qmIfSyfcLL6AV7gDZox7wNeyeqOs9dVPnwtfHg=;
  b=i4FDNJjc4sIaFzv+PJCaBOwi2RmuP9Kik3EFX/5Gw7zRSLsVsKFG9tzS
   Hq5o14sw2Njrh6Tg+vn30HXw+xKAiioWdO3BicKelaOhKUMZEZqhoprt3
   N5LKSH8puG91jX/M0qAtYpuUqVjKX2PGOHo0sgqgLEb+C3UF1861yUr8p
   o8bN1N0HTWJLEsBnvLXUfll+qE6N2sJ/0SIzkxyNZud0ynb2rjxrHyr0l
   sr+YDVTV0fDGOl89q4D+M6mM9vaq8yYEHWIgRey5L95RGaiiHqc4HRPT4
   lL4/ZxsQlS5Lo5tb0MJp0YqBPm0+jD5VBAC8nZA8mSZRKd7wrtDrNALoi
   w==;
X-CSE-ConnectionGUID: N9L92L7nSLKCDP/GyYMTsQ==
X-CSE-MsgGUID: SU2YtNzBSZS0KrvGrLN90Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24597678"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24597678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 14:06:01 -0700
X-CSE-ConnectionGUID: mNJ5630vQT6tiiohrzv52A==
X-CSE-MsgGUID: MnzO4JmkQi6xjnbEvPkmvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="66791272"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 14:06:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 14:06:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 14:05:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 14:05:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 14:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq89wLdVc9a8/N26oaK7+eUdzBIJ3EsWjAVV9Nj1YD+VkEIKG+6kc2SZolK8wbPEbkVYbEJHnnzJpXzUYeR9MaJlSoeMpN5RQQN+ZZik/6vnwFfSMzb6CuRFinTx4DmJtrcFZbBmnGAZDApGsDbmLedLQuMcExydYX3W8/OvobwSty3EuMIoRduIvpIfUTwJGrzOl18ohtal3DNJebM5bbSWvMpWXghqjM/tXTwwZMm697L7jF9r2mnT8KP7wnti/y2KnnFv67+YXHa+zWXI0I2Hej8cLuzYQIUPZZCeZzhFSfqSDNly4m0BAAJ+pLNAQe2zt/NGkfSNmeglFJaGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDLZgGh7etE1MQiJRI+l4Wyuvuvq+c/B11gfIcmCgxM=;
 b=XYwduC1ZNmT+59AvOG6xXyaLOP+BZGiH3gMW6/SUc73r1U0RMEdOyuNM4/K5c39sTDVRSBWZ9i7QxK1K4I1Yk7ZWjJvadNb15Lx7PD3MOI9LoQQUIAZ8E5usBSWYuTUzewtoal+yHDuy1laospRHpqz24thywPqbcEbeKpkwC6XYs03sqRngJGTIHOSx1RfyoO9LkqB9vkd2YB8BhMFlccBu84D8ErOhRzJUYVLiv7wterfVZCyRfbT/x8Vq0rCFqlCPV9fp1ec0Ux3KXmkyiDh1BAsr5gQSINz3a02SsvGUntCpriTJaTi7+UaQhUieGAds7TqKg9JzohGepP3RMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 21:05:56 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 21:05:56 +0000
Message-ID: <f0dca3f2-8653-4fd1-ab7b-cf6423037704@intel.com>
Date: Tue, 10 Sep 2024 14:05:54 -0700
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYyXSBsaWI6IEV4cG9ydCB0aGUgcGFy?=
 =?UTF-8?Q?sing_functions_and_related_data_structures_of_the_PLDM_library?=
To: shawn.shao <shawn.shao@jaguarmicro.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20240909071721.1768-1-shawn.shao@jaguarmicro.com>
 <a97f1b6e-66a1-4d52-9cfc-ac424263dbf8@intel.com>
 <TYZPR06MB3933635596B06AB3E2D438AD9D9A2@TYZPR06MB3933.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <TYZPR06MB3933635596B06AB3E2D438AD9D9A2@TYZPR06MB3933.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 490ceb1d-fc92-4bf6-f1a2-08dcd1dc5d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXMxenZSb214SEd2UXpNWW1qVFNDMmcwYmF3Y1hvOTJqRkdHQmZYVEpUSkJ6?=
 =?utf-8?B?VlVjdEtGdDZmSGV3N1ZlR0RrN21mNWIrMWIzejFoMlhzdUhBMEtyMUVMWmRU?=
 =?utf-8?B?OEVLQWVxRmhrWnM2UldvNXV0UzQ5bTQyQXg1dU9VejdDaE8yUWgwcFdiN2Jm?=
 =?utf-8?B?QXhRR3RuRkYwWDhzVjJLZXE4OForNVRISTZlTXJLYVAyckowRTFxbHJOMldz?=
 =?utf-8?B?UzhzRWE5b1Y3U2NBOGkxWkNNUzZwQUVjeE4wRGxpQVhiMnBTNnhOSFoxZXZZ?=
 =?utf-8?B?YTR0aUFFZkMxQS81STdaV0VTM2lrVm1jaVpuaGFZMjU2MzB3bDBhUVkvUFgy?=
 =?utf-8?B?R3UzakJaZ1VuOURLRHYwNDBpTEVmYVllNDQ4ZDJ2aFo4S25ucmFMRHRuQ1NT?=
 =?utf-8?B?U1FZRktlUUttVFQxWTliQWh4amF5eXpnQlhjdlc0ZnNIQnlMaVZ0MmJEcDFm?=
 =?utf-8?B?aW9GSEpvNXdTc3phenA3eTNRM092WEVSRVZRTkxlTVIyVHZIMEZPTThzbzBL?=
 =?utf-8?B?RWVXOHhtQ0hqb3dwcGVRano4MzdvVGNvU1FEVUFvQTFOaGx1YnB0SThxL1o5?=
 =?utf-8?B?NSt2ZHFCWFdnM3NhRWtqdE96T3lleDVIVkdxUXBnZUVkbkN6TFBWYUpXNkNp?=
 =?utf-8?B?QnB6ZnRVa21MOFR0ek5pdVUxRmNtanp3eWthWGM2dWFRL1I0QkpBbkQxZGRn?=
 =?utf-8?B?ZCtHWmx5dlh6ZFVSdFdUcTlKenZLangvb2o5UVZkbUYyQ3RsamhXSjJWWEhL?=
 =?utf-8?B?WnY0RUd3QzBYT0M4eDd5ZThWb1R0ajAycFArWndFNEErN0VFbUpyOFZqUGxL?=
 =?utf-8?B?eVlJa09sUlFuTFhmd0tyWEVVNHNrZVpRSHZaMmx1LzFlUGl5UnBhdVVYb1dx?=
 =?utf-8?B?UkNoNDNOclR2VjA1c0EzZUhONjJwZGtUTnBESUhNK0hNL3dpNWFjUWJsNThs?=
 =?utf-8?B?YW9qOHV6ZW9mRnhmVmNPUWJLWHplMHdacVVaZkh5aVhKZjFydXZRWlI4ajNq?=
 =?utf-8?B?UzZTWWN3dzRMMkQvNi9ERWRvdE01cW1UOVVrNXcveVZsQUFNREpPeGswUTZQ?=
 =?utf-8?B?eXJGTjZsRndwOU95WlhkVS95KzFZWnpxNTlGL3h4UDg2eVNndEQ0dWRBbGY2?=
 =?utf-8?B?b292ZFlFUnFpQ3liK1NYaHVhTWtLUWJRcVNQWEswaXM1NVNJWXdWY21xMGJC?=
 =?utf-8?B?Z2NKNjhkUmJ0TENsbUdrQzdpcTBMYXB6VW44WkwrTWl1dm10bnE3dWxDbTVM?=
 =?utf-8?B?c3BmS2RPNEVmaS9pbmRxdkJiWUpBd2xpU1MyMjZwVGtWTmJRR0JsbDYzQk5o?=
 =?utf-8?B?dTk0RHk1bGJZTTZnZnk3bWVHMlJVSnpDRitITmV6L1RBbmFPUDNoNmVlRGVS?=
 =?utf-8?B?Nkw0OTVYMlo5ZFFEWkRTQVE2ZGtKc0EwQmZ6ZTdLTFlyaHRzeFcrOFpQY1ky?=
 =?utf-8?B?d3BieE5Ndlg5cE5WdzRNRjJReUdBUWV2R0tyM1M5RVU5TW1mKzNDRHdyOTdV?=
 =?utf-8?B?dk5ZQWpZZDBLVmNDM1ZaQWQ3dFRERDkrTEFNckdNQXNib0t3clVkYUtUL3dE?=
 =?utf-8?B?OHhWbHR6Mis2aTFKNjROWUt5RVZHOWl0N3pEMlJ1YlMxbTNzUkx1WUpidjUx?=
 =?utf-8?B?bllZemxCa3VUTk4xais3Rmw5OHdEUGp0WWNtK2t5a29MdXhZMlM4R3Y0STMr?=
 =?utf-8?B?MTU4NFlTRlVTM3lFM2VPblJIbEJvdWRFckhJQWt5YVkxWFdyRExnRFBQdGJq?=
 =?utf-8?B?N01SZmVnSjRtdk9FdSt3V3gzYVhYd1FYV2QzZUIrSlc5SDNrWDZWMmdGbzk2?=
 =?utf-8?Q?T1fRcXnPXLkqlcxGmgki1YM4mzr9LozPOIeuU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDBwYXFJYkFUdENtdkpZbkh0cVd6cU9OMTB5NjI2eGNnQUlaMmZuM0JNa2RI?=
 =?utf-8?B?YWp4cjlRMU9zNENHcXNZVWFoQlJYNGdoNEFoWld2Z3NPcDRoZHJJZUwwdHBH?=
 =?utf-8?B?NDNlVDJqdldaam82Z1hGL3g1QVQxc1ViaUc0MjBYZlRzNHREY1BmY1dLTWJH?=
 =?utf-8?B?WUtid2J3K2doZVVwL2VreEFTdkM2RFpiZUljTUJCNjdjQ0NsMTNzTi9Oc0xw?=
 =?utf-8?B?MjNNc1BtdWlhaGxpYWdaZ3ZpUjh6RGpNaFdzbU4wdzRUUXUxN0JZT0tkbm5P?=
 =?utf-8?B?b0s4TmNVY1MzZU43M21rUVdzWHg3N3BnN1QrUFpxY21pVVNWLzlaOElLQ3VY?=
 =?utf-8?B?aXExb3Zqb1RKNnJHUmk4bi8wUU5qN1BoM3p6UW9tVVd1WXErTHQydkFEKzhJ?=
 =?utf-8?B?N3QxYk1hU0psdVNHQXY1VjIwVmVFY09ZcXUyQ2J2OTAwMjFlYzJPVDc5bndB?=
 =?utf-8?B?QjhuR2NOMDNwbVFQKzk5dUc4WWJYVFg1MCtTWkdUdjV2d3lHZUhDcU9GWnhu?=
 =?utf-8?B?ZzNBbisvQUI0WUFzZGlzb2Y0SkFsZ3V1eDZBOHFYWCthbUlZVlQwcUN1SEto?=
 =?utf-8?B?Q001U2hhUVUyVzlYaEZhRUh4aU5QZll5TjU5RFk2YlZFV2p2ZU5MUmo4THJl?=
 =?utf-8?B?Q1g5UkNpOExqR01yWUxJQ3pveEdMMDd1b29hVk5uZzBCT3R4dHdpQU0zUldP?=
 =?utf-8?B?MDJ5SWJLdU4yTVo0WEJQNUlGRFFVL1ZhTEpxTDBqT1FmRG03UTBiSFpNU2pi?=
 =?utf-8?B?Rkg3c1ltajRKV0lGeGJBRnJ1VUxXdTNVK21QUjZHQ3hua3NMMVdYSGNOK3hZ?=
 =?utf-8?B?T1dLK0ZMdnFWOXB0QkxVbzhoZ2Y2QUNiWTNWL0JhdUx4YWhoTTlUbXpNY25o?=
 =?utf-8?B?Um5lcFVMN1c3blFLMTZzaGoyc0NwL0dDcDdaVGRMQzdsY1NrZEZISis5SktX?=
 =?utf-8?B?a1hYOEZhcEh1aWZuV1lTQldMbHlBWnAyTkxiYnYrQ1BQTWxWSy84dXArN1Zv?=
 =?utf-8?B?TzRLMEpRU0ozamd5U3JyY2pOOFRCZVRtZ25OZXFxanVqNTRiK09HTTRzSzd6?=
 =?utf-8?B?VFF1R3o4NWtjamx5dlNjdXRSN3pBVzR6d0lyYklxdEpjN3YyUGdvdS9TSHk0?=
 =?utf-8?B?cFBNVFBERDh0MHNGZmZjOVBJRE1Dd0VuQy90ZXdtZ0M5bkoydTZuY1ZvOXlj?=
 =?utf-8?B?TCtzOXVCQzVOWGZ6K0ZzZGFBSkRuejJPZFJnQ2Z3VStiYm4vTHVIeEgyZllL?=
 =?utf-8?B?UllLNlJGcy96UDVzQkxYem1zNC9BeE9CM3BlNE1BU1I3dEk3VFQyVTFFTitV?=
 =?utf-8?B?bjhqYjljaTljMnNFNnlYS2orOXZwM1k5Q0E5cUJraFQra0VrU3RNZnQyRmky?=
 =?utf-8?B?M2RqN0JHelc5V1V6NFU3dU55V29QeFY4K2ZMbG9aNnRud0g2dlVVZ0drY0hX?=
 =?utf-8?B?dllRNEN5ZXpSTGV5QlM5ZFpFVzBYUk9KZmIrYk5TTkpPRS9vTDB3Vm8wdXNW?=
 =?utf-8?B?eklQTDdPU2F5bS9tQUlnWXhVdGRGU0FZZFJMMFEwenBmSlZpdkNIVzRjUjho?=
 =?utf-8?B?UWNGYnlldDZNOU9qVjMyaGpSaGlSMUZHWko4SWQ2bEh5YXNYalNYak56WThV?=
 =?utf-8?B?K1R5SVF4anRxZXhxcWttSGVjTGhyTnVHWU5PVHB5clN0b0dzcXVzUUNaYjlG?=
 =?utf-8?B?eDYxK1VNU0lWY2Nzb2x0endlVEw5TmJpYmNIS05OSWFMaWpTZTlvbHo2eDd5?=
 =?utf-8?B?UDJhVGg0eW9CbU1uS1FuVWpaUXhtcmptbmd5UXVwQ0ZCMmdjZFFEZEl3VXBB?=
 =?utf-8?B?Wk1YcVc4MmtBTWdJODhXeGRCblpTS3psMzI2KzNoK3IzZEpldGl2Um5OR1R1?=
 =?utf-8?B?RFFhMnZMNHV5VlArZmg5MWx2VWZzakIwWkVBbGZSMFFpaXJORXUxVTMxcUl3?=
 =?utf-8?B?aFAwT2x3NEwra1lrSFlQRVYrOVRLTmg1M29rTWFRWm5aM0lOSUJXNnJPbE95?=
 =?utf-8?B?UDRZaDI1MGh2eFJ3dDdDNGJPM215RGhzZnpDQ3BiUTlIbXYyR0YrMlJYZFVR?=
 =?utf-8?B?MnF2TmJpbExlTW1KZ2RraFVVZnpsaEFwWkJHWGV0ZDJMcnc0ejl2Y2trTUEv?=
 =?utf-8?B?NzQvMmwvTkc3NFN2eWdEM29uWXFKSEUrUGxoWWFLMGcrNUs2Z2htYzhNU1g4?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 490ceb1d-fc92-4bf6-f1a2-08dcd1dc5d41
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 21:05:56.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dO9tEgujvF9uFJydu1Aw9rHCeyEo9bxAVAPPxoRsE7BxNqP3r/IQzmuSH1oYyvSwFKQM3TLmNByIKUVGe77araZdi8ZUJlxSpy0G1vgw3v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7110
X-OriginatorOrg: intel.com



On 9/9/2024 7:08 PM, shawn.shao wrote:
>>> On 9/9/2024 12:17 AM, Shawn.Shao wrote:
>>> From: Shawn Shao <shawn.shao@jaguarmicro.com>
>>>
>>> v1 -> v2: Updated the commit message, added a description
>>>       of the changes related to `DeviceUpdateOptionFlags`, etc.
>>>
>>> The PLDM library is used to implement firmware upgrades,
>>> but the current library functions only support the
>>> `pldmfw_flash_image` function to complete a fixed
>>> process of parsing, sending data to the backend,
>>> and flashing (allowing users to implement custom
>>> logic using `pldmfw_ops`). However, this poses
>>> significant challenges for device vendors using
>>> PLDM for firmware upgrades.
>>> The following scenarios are not supported:
>>> 1. Only using the PLDM parsing functions, as the
>>>    current library does not support this operation.
>>> 2. The firmware upgrade process differs from this
>>>    fixed flow (the firmware upgrade process may
>>>    vary across different vendors).
>>>       |-> pldmfw_flash_image
>>>               |-> pldm_parse_image
>>>                       |-> pldm_parse_header
>>>                       |-> pldm_parse_records
>>>                       |-> pldm_parse_components
>>>                       -> pldm_verify_header_crc
>>>               |-> pldm_find_matching_record (xxx_match_record)
>>>               |-> pldm_send_package_data (xxx_send_package_data)
>>>               |-> pldm_send_component_tables
>> (xxx_send_package_data)
>>>               |-> pldm_flash_components (xxx_flash_component)
>>>               |-> pldm_finalize_update (xxx_finalize_update)
>>> 3. The current PLDM library does not support parsing the
>>>    DeviceUpdateOptionFlags parameter, which is defined in the PLDM
>>>    specification to facilitate the transfer of control information
>>>    between the UA (Update Agent) and the firmware.Please refer to:
>>>    https://www.dmtf.org/sites/default/files/standards/documents
>>>    /DSP0267_1.3.0.pdf P37.
>>>
>>
>> Thanks! I'd prefer the DeviceUpdateOptionFlags to be separate, but I
>> think the changes are good.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Firstly, thanks for your reply and guidance so quickly.
> 
> 1. I will separate the device_update_flags into another patch for submission, as you suggested.

Appreciated, thanks.

> 2. I have another question I’d like to ask you. For support of higher versions of the PLDM library, version 2.0/Version 3.0 supports ComponentOpaqueData/ComponentOpaqueDataLength`, and requires adjustments to the `__pldmfw_component_info` structure. I would like to continue supplementing this adjustment(submit other patches). I’m not sure if you agree with this, thank you.
> 

I'm not opposed to extending the library. However, we need to be careful
that any changes do not break existing files. Do the new fields come as
part of reserved sections of the previous data structures? Or do we need
to identify the file format version and use an alternative structure for
newer version? Or is this data something that was already there which my
library code simply ignored?

It looks like this is also further complicated because the extra opaque
data is itself variable length and follows the variable length version
string.

I think this will be tricky to add, but we should be able to treat it as
a separate structure, maybe __pldmfw_component_info_opaque_data, and we
can check for it based on some sort of version format in the header? We
can't simply append to __pldmfw_component_info because it already has a
variable length structure.

As long as care is taken to ensure that existing files do not break, I
see no issues with supporting the additions of future versions of the
standard. Hopefully the PLDM standards body properly implemented
version/format in the header?

It looks like there is 0x1 for the initial 1.0 release, and then 0x2 for
the Downstream Devices support, and 0x3 for the component opaque data.

We currently only support revision 0x1, but extending this shouldn't be
too tricky. Care will have to be taken to ensure the code is structured
to minimize exposing revision changes to as few parts of the parsing as
necessary.

Thanks for your interested in the library!

> Please refer to：
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0267_1.2.0.pdf P42
> 
> Thank you very much！

