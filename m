Return-Path: <linux-kernel+bounces-321679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADF971DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A63B22EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75D3A1AC;
	Mon,  9 Sep 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qo9paGV+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078C137764
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895216; cv=fail; b=V4SLX4RjHHdUijTWECkpTfBLAD3UD2pL5/4rgmt7hgFZ9f4ujDv+6ZzwXhzMVog0T9VSzW46NHj4cdDXI3YwJ2M5Uf1lPuKA8D3WV1ZOzDuOjEB3nzlzT/Hsy3Do+7S6rXqXkJu6uGlkvcHMftMjlVroFSiUGPvGuu8La9pu8Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895216; c=relaxed/simple;
	bh=QuD/VHU6wK1uMNWeqKUojVkjsZwYlr3Qx2ArqRS17bk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UBnW79mLfqgv537y/lzf8IQVvK0lUCOHsasNutPlnfw2sIf2JGJE3tD8LtlOeBZJtyrvyHAuduEK9j4hoqoZ1JR/4lgA6HtZ/5RsW1QFrQkBCTmiz28SHwf8+3GNVGzy4TISPRancBPvdoB0jnZKMot9d/sPNPo0KG+bBE7ZXsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qo9paGV+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725895214; x=1757431214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QuD/VHU6wK1uMNWeqKUojVkjsZwYlr3Qx2ArqRS17bk=;
  b=Qo9paGV+tYkneQjkUZG6q6omfyhX16uwLPnxIQH+WlQmpYLx+yFJpSz5
   RCY1qJsc3RTVCMtZX69N5PjaJfcZPo7jWKtwIyShNNCCf4schEU65logR
   wPpZIuTulGVq3DdG3k1zrHF5SjyVcKtQoQgLh/yt6s7P+eP4xXbgPIlCT
   8daNoqnYfHivLjnl9zyPa7rExZP2Jg4z0i2Sj9vlDUKe6oPMBPepe4hq6
   1KwPLIKhnTNGlpSX5J8sQPxq03BEGdvB56Bz1JGGS3muWdhpGHrCbwBgQ
   MJpuixIJxiH1OKagFHKpz/DHwrIvao29mKCEriiKSuavKWB6N+Y3It1M5
   g==;
X-CSE-ConnectionGUID: 13rLt4OQTf+bbhk27TDEng==
X-CSE-MsgGUID: Qv5cG7YwRfmjWkvGHweAdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28483117"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="28483117"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 08:20:13 -0700
X-CSE-ConnectionGUID: dWlHKwlKTpewZBshVmoEyA==
X-CSE-MsgGUID: ckI8lOKXTwKu676MGV/sOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="97511558"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 08:20:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 08:20:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 08:20:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 08:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+D0v5aZJmqUR3CGDS9hpO3SyeU4Cs/AS4DQ538TLmG4u5LrpsPMU3RgNsjzixgm6zceXGW0ino/YB2fT7/iFoFE68pXVy9QEhsnyb66dVlDCQYGPrzp28q55Z7ITywh6B+fU0b6J5h1evn42XhdGWQr6+OMiTVzDBQMa4OdtT3kjKv/SARCWAuv0bKMrlnwRCEM+VORdc6h68QL+5C4KguGWLKXOyVQxY/WDEvegVGsz6UxrPA3lZa6knbCCNVoai424FhUjK/7rbAMa90sB5WSe39lMXccZ0WDcbVq2rC4Vz2lpcxmTQ+W7FN6meEvA0ifA4heFilJc9iaS2Rzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/pEaaRdykgqgRhPxHPQKQno0VotcE/saA6Ue9yafVk=;
 b=ICGDXM+z2YH5HpVJ5W/oaw4Am7yqz5BYYAbeYxhTtMQUZQbp8DwcW9DKeiqfMfRNAN0SulB2e+A3lw61TrYXITvdrbmSN6lYqBqMkVpdX26i271QngEeybHKYYP7ZofC33yysOxhEUUcbObBxtwgjwriWaK0BXQ/NcWFCZsJdHRfu77F+PHAeDKDf3Mje6vDOKiNfs1pmOIzVAFWCWiB+KMKeIQ6yuC/7GAUVW+2WWlSG/QPjP5lasyhvMxORrn8SPDVqFKf4EoqqtQ9NWZmDGmgMXnKiAgRH8uapiG244SVs4ADN34QHNaLZoQgI0jjRqSplDVEwnZu3XGYdrPoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DM4PR11MB5328.namprd11.prod.outlook.com (2603:10b6:5:393::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Mon, 9 Sep 2024 15:20:09 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 15:20:09 +0000
Message-ID: <82784b04-7f07-4804-9f61-0198890fbb5d@intel.com>
Date: Mon, 9 Sep 2024 10:20:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] tsm: Add TVM Measurement Sample Code
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao
	<qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
 <9c2483cf-d66b-438d-ae77-3c0d18704d03@quicinc.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <9c2483cf-d66b-438d-ae77-3c0d18704d03@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::21) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DM4PR11MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: 398b446e-7cf3-4af7-b2d6-08dcd0e2e457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDA4bVgyazd5VXBrWlhwSGZBb25oQlhlRXhCRzBGVU1yU0lCNmVVM1Q4Qnlp?=
 =?utf-8?B?WDc1dmJUVkdSNTQzMklrOXVqOVhyZWJQOUxWMkRTcGJFQy92VUhIekNCYUky?=
 =?utf-8?B?N1RmUG9mR3ltN2NZeUh1QmJ3WEhLQUN2TlJJa21jTUZNb0luNFB6MDRJbEhh?=
 =?utf-8?B?OWhuS0d5ZUdOSmFqekZGd09NaWV1bTNpQlhDaUw2MGV4WHVNSnZBKzZRNjdr?=
 =?utf-8?B?QnpzclZMRXRuMUJMbkdSS3B5OG9CMVNqZzNreWZzdGI2M2x2b2JUd2ZNTUZW?=
 =?utf-8?B?UlNybHFWc0tkYVlWUkIrT1ZuUUdCSzJGSjJCZU5INkRDZkl0Uk4xN2RCWE9J?=
 =?utf-8?B?MTZ0Wklrdlg1bEl5ZzNyTHBoTGpmMk1LbWcyNlFKRyt4dTVuQmtwd0NURWd3?=
 =?utf-8?B?V1pQK1VDdGNXMVM1UDl1aE83Q05vQzJ2SnR4VGM3amh3QzhsVWtPT2J4QlQ3?=
 =?utf-8?B?Vk92RkxVOGxWMjdaVWlscEJRV3hHU2Q5VnlMcXZ6Smo4VjdoQ1g3dmgzZGNj?=
 =?utf-8?B?d0xzS0p3SFUyQjR3aUlTOG9qLzc5WnlETGJLS1JJWUljblkraTdsb0VBUUFD?=
 =?utf-8?B?ek1IMTQydWVyRUxKTkxOS1BqWGVBYmFWOGc4SFBJN2VodmdFUnZ5VkpTR1FM?=
 =?utf-8?B?akZvc0pndDhHdzQ5YWNPRVJGVTdGQlpYMzFzNlM0TjZkcGFCL0VvSVJCTjBx?=
 =?utf-8?B?TjdFRENWZHlDOFVYVk4vRzlPQnRWNVhjWVJjVHVRY0pOdk91VldMVE1iQU1u?=
 =?utf-8?B?OUcrblRMRmRmTGJyd1dLSWptOFA3c3FyWE95SVhRa09IbU5IU3FVM0s3aUdU?=
 =?utf-8?B?dGdDWHZ3eWJVUHBmQ0M0VVJ5YXd4aFJxMlY5MjUwZkFlbnpSUXpzUGxhcXZa?=
 =?utf-8?B?ZlVrSzNCNGVDS1YzR3AydmZ1M2tnekFIbncxWURpcHo3NmFNVC9wbHBhSnZG?=
 =?utf-8?B?OUJlbmd1c1hJZVRFdHpVU0NQTXQyTEY0eUl2bW5oQTczaDFtL2R3SDhaTGVl?=
 =?utf-8?B?dXVqYi9YQzg3blVpdHgwV1JLdERSK3l0RFJsVnplaEo4YzFFUi9CTmlra0dm?=
 =?utf-8?B?L01HaFZCU1dycEd0Um9TSFBtL2RsbkpTQWJoZ2lERW1NR0g2VXBlVm83ekhD?=
 =?utf-8?B?ZXRscU96REtCQUhkUUFWVFd6V3ZvaHFndzB6TkxWUnVibzJVTWFFL0VTL3Nn?=
 =?utf-8?B?MjFpdFhwSjNEQ3hYVy9EM1VDRGloQnJKU2trbGIzRGYzK2dQQWh6T3I0SU9h?=
 =?utf-8?B?M0FMR2tDNE1peWRlSitkSlRtSmV2Z2tMVGxzamtyWkFuYkxoRXNweEMva2Ft?=
 =?utf-8?B?b3I4b3JWRUxLNkd3NU12U2djdjByTkU0QUJpblNrN1ZwYUdEdTdvaXR4Zm5R?=
 =?utf-8?B?T3p1ZTl0dHVJclQrMUtpUUJRYzMyMHBTQUROblRmbEhnbEQyY2lqbnZTOTR2?=
 =?utf-8?B?Wklsc09jWklQTDZEOFNHbFR1MU5mU0lJYzFmMWlKNHZ2Y3ZJZkcybXBMaXNh?=
 =?utf-8?B?d0xhQWdOTzg3RWc5SWthRGpORUdkK2RMNUI2RllIUkp1MHVIMHZLUjJSbnpZ?=
 =?utf-8?B?THY3U1lnOFVOcTF2bG1ud1pLdVFaQWVIZ1lYUmFOWVkwUlhtUVM2WmZRRjdE?=
 =?utf-8?B?c0dsSDdqeS81bDBnZDI3a1hCc1BoeWx0TUFKaDF2aHMwcmNOOGpJOFpOUWpy?=
 =?utf-8?B?ZUpKZlZDRUYxV2c5OU5Uc1p4cmFMV2NRSnhYQmZ1aFNKSFg5cTlLejF6bWxY?=
 =?utf-8?B?QUhWbS9QMlAyeGxCczhqdEFkS04rTHUyeE5Ud2xDNGFsdjFzTUhvSUFTaFYz?=
 =?utf-8?B?ZlNLUmwrT0FReTBQUzFSZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytpcDFBSkk4ZWxZazB1UnZUd0ppaEVGNHMzbU9vZmFCcmhFak1FcHppNWRa?=
 =?utf-8?B?REdMd3FxLzFWWjRhcWd2eWVoZUVUYlJYYkQ5ZHVtS3ordlFjZVpXL3dqV0tq?=
 =?utf-8?B?VEdWbjFXc0FMeHhqMGZBa3NUZllwR3V5b0lUUUxtcDQ2ai9pUzZuYnlJRzJR?=
 =?utf-8?B?bkVTcnZPZTlJUE1lWW4zMHcxYUpUeFFXMmNHczdsS2YrbklQNkRoLzFGMjNj?=
 =?utf-8?B?QlNxLysvSmZpaVVWOENKb2IvN055ekdGdCtkWWNWYTFHYk8vNWJyaW5tbGd1?=
 =?utf-8?B?NVFTNlBhYzZGbEU5QlBTTjFjcjRvS1NSZWJkK2NEMHpCeHZ4eHRyM0hicHpE?=
 =?utf-8?B?UGg3WEFxdzFjRFZtK1pNeWdKZ1BwcjBnaW45SC90S2E0SUhBMmRWU3E0a3lT?=
 =?utf-8?B?VVgxMmlSUVp1TDk4c3FnYXo3YUxPbFBoNUR0aGFJcUhaMnVJd092blNpUjRE?=
 =?utf-8?B?L3dySXo0NzhQcXNMdDE2bzd5WnFoN3F2MEJMRVJYQnNXZklJbFJFQ0hlRlAx?=
 =?utf-8?B?VFFpZzh2LzMrcEg5dk9FS3U2dEx2M1JwdUZCZGxnWnJVNWhEWVFLR0RxRW5a?=
 =?utf-8?B?eGxIR3NWV2VvM1pHN0FuNjZwcHBwNjdDazFIOW1RMTFDMi83bXEvbGc4T0ps?=
 =?utf-8?B?VWlrOWhIeXE1TjFBR0RxL0F3VEN1TjczUnN4L3M0UFYrYmxvT0QwZEtKSFlM?=
 =?utf-8?B?am1rN2liZmZkenBjdDhTRkpjTlUwZWJLcUZMUURqOFdBemdQVno3Y2hVbi9n?=
 =?utf-8?B?MTBybGFZYjhGYWVFUmlQSlhCV1l3RDJqZXpWS3pQOHgwa3RCWjVtUW5WZkc5?=
 =?utf-8?B?cTAzVTJYSG5iZVV6enk0OWpCUERNNUpYVHZMSXpGUVJFaVNZemxTSlBNdE5j?=
 =?utf-8?B?c2UwdTRibkNBZWJxSDZVL3lTcDc0MmJtQkdsbTY4R05JNzNFYzdOdktldlBu?=
 =?utf-8?B?ZXFYaWV5M1Y2dk5yRkZZYUtMNmhpc3p0RytKUGtPNGxBN3orWWM5ZVJoK0o5?=
 =?utf-8?B?M3hieTk1SGc1RzJvdzhiaWtxSVBTVVJzVEhId0xrUzVxdkNPWUNFMitwNklU?=
 =?utf-8?B?d2tSd1IyLzZFTHdHU09oY2ZnN0NId2VsdVRFbDNCVW1PYlJXaVFLVFh3d0lG?=
 =?utf-8?B?bm04Mk9YVFZ6czVocnJ6Z2pVYWZEM05jWlVCRDNGRWpIa0g1dStOaUVOM2Yv?=
 =?utf-8?B?SnFQaEVCU29sSDFPc2dJeW1wS0hyejZub000TVd4RGp4K1NTSnpKN3hvMEZB?=
 =?utf-8?B?NkRJaWc4M1R2dzVwL2tTdk5sTml5VVFiQlIzc2lpQ01ZYnFYVm85MS8vOGUv?=
 =?utf-8?B?a0VYL3dXQUVlTGZ6S0FCM1VvcEcxMHR0YmtjYkpUeUhERmQ3WXBFd0NLblBV?=
 =?utf-8?B?QlhQTHFsWFRiY05idzhUUHRkdmVYMTRmekowRTBiTEI5ZEZheTVUSkNkVEJt?=
 =?utf-8?B?Q1QyNHh1bFA4RjMyRU16N2VLRjd6cS82RGZJMkpmRm9vQnJRWEN5eVZPREhQ?=
 =?utf-8?B?dGxldklyOVNoS0h1RFc3NW1EelRSd0dhYi9zOTF6RFJDd0hwMWFSMGdMYnV6?=
 =?utf-8?B?MHB2RWZ1Tm5nd1JjMUxjcnRRWERsVjdPR0dZSTIvNnc0OWZPb3htOWxCVXVi?=
 =?utf-8?B?d0hDOFNhOXpMQk1jRENuN01yMDdYZnhMNGFab3pJY0V4cWtmK1MzOStRYUhq?=
 =?utf-8?B?c1dNckRnOVNiWE9kM3hXYXJZY2M3QVdqNnNjVlladzBvSG5Oak1QTGFJTnE5?=
 =?utf-8?B?UFUzTnF1TkdYS1NzL0NGVHZ6NngyMWtQcnE4TWZtZUc2NHpkUU5oRll1c1hH?=
 =?utf-8?B?aXkybUEzOGZSRjRIK3IwRnBxakNMZUoxd0hSYmQxSmh3WmRHY0Q2TUdGdWd4?=
 =?utf-8?B?R3E2TGJDSS9seFl2UWtYeFBJMGNCVWJ4M1NjYmNldDgwb0lZdmpzdGNPZUxF?=
 =?utf-8?B?Sm85VWJBWkdBQUxvcUxwdk14c1NRVkpRZFVUa0VScllGekJ2VTVDT05Bc3FL?=
 =?utf-8?B?S0cxZkp4STNKbWhHdS9neUVjS1ZGYWdJakw0a1RJekhHSG5keUdDVnpZb2tQ?=
 =?utf-8?B?Y1owczlHOXJxc2hJRnBJUVNPbHRpQXJUdTR0VEZGcEdJWDlrTk5HejdOMzA4?=
 =?utf-8?Q?0yjykxcWJO9CXOZfhR+UvQWU+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 398b446e-7cf3-4af7-b2d6-08dcd0e2e457
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 15:20:09.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcA7d6qJYAEK3spW0lratAoib9y8P3MJDelGaFCqKW0/Ttt511ll11LbES1AyF7ko4oP2piETliiNa/ueuU3iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5328
X-OriginatorOrg: intel.com

On 9/9/2024 10:14 AM, Jeff Johnson wrote:
> On 9/7/24 21:56, Cedric Xing wrote:
> ...
>> +module_init(measurement_example_init);
>> +module_exit(measurement_example_exit);
>> +
>> +MODULE_LICENSE("GPL");
> 
> Missing MODULE_DESCRIPTION()
> 
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning when built with make W=1. Recently, multiple
> developers have been eradicating these warnings treewide, and very few
> are left, so please don't introduce a new one :)
> 

Thanks! This will be fixed in the next version of the series.

