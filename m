Return-Path: <linux-kernel+bounces-558267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5BA5E3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15AF17C726
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5623256C9E;
	Wed, 12 Mar 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiP6AmVI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C91BD01F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804052; cv=fail; b=WqWwf6PngxMXYZ7vZiZDP4gY8h7Yv3jbR+LhmM+px1xwYjyGUlTE3FQo8KMiC+vmfXVRCY71xgPPFI00BhpGyAeL6Vxfl/Uk3GC6neVHBT7g9i0coNU6XfeRWoNMJCEEMJvslTeT0y6/v1AeiqNkHXeaQkff6fhi76stby7nz88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804052; c=relaxed/simple;
	bh=VnzJjzIGyiamlvxPSDoO2yoBjDD2dVyaNXa1XJf4wtQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHXnbb95Uw3EzC35m9Y8a7ReEGgbZoi5viSCFqaozvQf+dS9vmXCpGcorCZel/7myqhaCxS3ezpU3zaEneULtxJqXjv2Tddl8HfUslO6GI5TT+ThB0asot1AhU3BKa7s68e02jWFP0xcUT9+JNm4ZsroqJInhCKDz4t/xG5JSbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiP6AmVI; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741804050; x=1773340050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VnzJjzIGyiamlvxPSDoO2yoBjDD2dVyaNXa1XJf4wtQ=;
  b=kiP6AmVIxQWPLhnSZkUjIg3M+oiZASfHeZ9rdVOwzi2+J2AKDBHtUrC3
   aTiRnFs1XBk1BsM0hbD2+ppGFDwjszHhduQi/pGepSOAygggLkM/IjdzQ
   2/dbig1h3eHRXWktgxbvQPHDdNOx6y1WvPGvnnZYicssHxm2RROq00qwB
   BsrhjpJq5XoUx2zY50LQh0iuUlQoNcHJ959gkocM+gfHcUyHdx+CcTmkr
   /gfmklOZrfztfHUI2GIuwBHVaEiHAhc7D0q7D+dm2l19F2Srvb5t0gput
   Mgn9vOtBEbsgX9t4JwUFMZMo5To3io3Jo5n5qbX7Zn+8WoqACMfqHEpYj
   Q==;
X-CSE-ConnectionGUID: 4nucOM3jRp2mroJiF21Ziw==
X-CSE-MsgGUID: X4rExTORS6Wbmx7P3XIecg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53528609"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53528609"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 11:27:29 -0700
X-CSE-ConnectionGUID: xQR6+4lRQGe9kPTmzhVQgg==
X-CSE-MsgGUID: 58a47gLySNOPuR9t3bxz+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121634149"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 11:27:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 11:27:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 11:27:28 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 11:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jeuq459YtEp8/s4v/MsGHK10KefVH9AsLbPAYouF17vJMho3IeCP2vR6nuKl1HIEvt6+BTgUf9dyS1FVZurf3l+FBcdmjOONz17GmXfbc2AgERx6glF6g1Xhkf8tCSCUU9z0dFQfCX/LufLk1E75sNpXRNIrjEmZ32fLdJ6h8Dg+8ynfCoF6wTu04xbrcpZypuHlXpFSyY+KnYazCsY1MSzHjiEzn2GsdpSguP4NeceKoMyG9vSJz0mMXHATp9pKYwTT7Sn0Rp0zWFFFCqUf/rrRGw5zs/2FX2Lk+d8u4HDUwb9UQ4gsW4lleF16D+xVu8XRRjUBHmKJ9JdPCWPA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9OptkyyCGYjtIIrqIU2VR11N9MfxcCG5zh0vpjWvd0=;
 b=AcuAFmCDPhheCFm/MXG2A6wq6bKu1Me9Xz4iuBLNu/lmVeP5yln5DevTQ5Bdlx6K8pWmLushv3wZhuBt1XktiQ8pdY/TzHDAIeDGXE41ujUumBEZyIrVwhVUQ5XX4IjWCiKoGCdm2Y7BpCKZW4ry/54+CT9YiKbfRt+ZQ1INIJE7k4XhfoHCMsRLuziZhbGQYxj5rcqeETiQg2639+QuT7iHhtbdbugzL2WbD5+awIpYr6RxYRSbuNe+39uw/+QFQeUr1ZXjgy5KPu5LoY8+GwWJcrzEcR1Yct94vhAL9rxKXbHMlqdbcpRNJ2ObUcIpmlHd6NJfjrbSZseqaUCLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 18:26:44 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 18:26:44 +0000
Message-ID: <aa492474-e975-4121-8e0f-54414a7f5e65@intel.com>
Date: Wed, 12 Mar 2025 13:26:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] tsm: Add TVM Measurement Register support
To: "Huang, Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "dionnaglaze@google.com"
	<dionnaglaze@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "mikko.ylinen@linux.intel.com"
	<mikko.ylinen@linux.intel.com>, "dan.middleton@linux.intel.com"
	<dan.middleton@linux.intel.com>
References: <20250223-tdx-rtmr-v2-0-f2d85b0a5f94@intel.com>
 <20250223-tdx-rtmr-v2-1-f2d85b0a5f94@intel.com>
 <8e3736c1a0b650179dab177feafdef1a596f81c7.camel@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <8e3736c1a0b650179dab177feafdef1a596f81c7.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DS7PR11MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: c8991197-db66-4c5e-5c55-08dd61937134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVdCdmxxa0krM1VUZktWZEhNU1U0NktVRmlOSFpCSXRocVdhb01aaGNXU2hF?=
 =?utf-8?B?UUI1NnFQU0JKMTVoSTBRNFhuUzNEK2Y0RlVPTCtFVEVWVmI1OW1XamtQTnJz?=
 =?utf-8?B?ejRYSkpKOWlSSU13MExiZlN6cHRjVGQyMSs5WWlESDBqc29FSW1STXJjcTVq?=
 =?utf-8?B?Z2ZJbG84enlFc25jWlZJMWJ5ekh3TkRtYXlsN3FZSzZRcXRtcE5aSWRiVFhY?=
 =?utf-8?B?MVJVdFZhdjR6anI0MVhFamZhZy9qb3ZMYmNoakF1R1FkSHA0RXIvaWlHQjZl?=
 =?utf-8?B?cnFxcXlUZWF0NDUyTno2bmQ5OUxiQzhOZVBzWmdaZ2swaFNvZldyMVgydE9m?=
 =?utf-8?B?cjNwcXQ4emtUK2tqcWl0MGRFVkFMSkxPdCs5c2NkcXN6bndMa0gzOXVmMVdC?=
 =?utf-8?B?dlAzWVRndThPMWZjS1JvZm41eWpOcGpFYlpSZnFXR0lEUGpJZ0lGKzFRdm9l?=
 =?utf-8?B?Ymh4TitIalNMUXFDV3I2VkRrMTJKdXEvZzBsR2l6OFBhMTNDd3dxMEIrTENo?=
 =?utf-8?B?YnY2SmdhdndXTytEQ2hDT3VIU0FDT0hlVnFKVk92cXVQUWUrbXJQNVlCckdU?=
 =?utf-8?B?TkhETWs2akFCYW9nTUdTcEZDKy9DeVIxN0IzbEFGVS95SVdxM0xpK25oVUhu?=
 =?utf-8?B?T0g4N09KRGp4QzhQKzlKc2NzOWovUHIvOU8zN1c1ais1SW9JSWJYVjhIazhy?=
 =?utf-8?B?UzR2TnVSVVlLeUVLa1VDOWhWcFJUcDc1dVkvaDBjQk4reVF1M2dXYlJyQldu?=
 =?utf-8?B?bHZ6K3Y3WlNrS3pYcjlMSW00UGhTb0xhZk9BN1JoanliampSdGpkdjlIb3N2?=
 =?utf-8?B?Ri9FTXU4T01oZGZGRXV5dzdMbWRuWTdwcndmNlJNdG5ldDVwMXlDeU1MNjZY?=
 =?utf-8?B?M1NXNEFMWGZGbzU1ZzRCR0Y4V0ZHckdQcFVGTUQ1elpMVDhMYVhPcmFuZCtz?=
 =?utf-8?B?RndldWxYOGFVWGVIdHlMZ0EwU2xHbUg4cVlzb2k1TnJQY3lObnJMbGU1b0Uz?=
 =?utf-8?B?SEVOMWlTOW5HeDY2YzRXU3dLS1FYRjBGbGRIakNSbERmNVltRnpNSnNXN0p0?=
 =?utf-8?B?WDYxdFNRc3JqQ0Q5TlVSR0g2VWhFQWNrM0RoZllCMWNUTTJLbXlCRzFXeTVR?=
 =?utf-8?B?Rm9EaUpQSjhGTHRDbm1TSGNUaG9Odyt4NmdGWFhEdllLdC9udDdwS1JvUkZS?=
 =?utf-8?B?NjFHbTFmNEhDdlBBRm1zeVkwdTZuNlU2RlhKank2b1d0S01pSWRUcm56Ykp0?=
 =?utf-8?B?NDVCYm9EcUxSVXZqVGljcFpXRmJsR1d2WlhERkthQU1ua3gxV1Y0YzlNMUpV?=
 =?utf-8?B?ZUJlaUZZYUFsT0tZMlJtYzI1NFlmTU9JOWJYYzc1R1FmcHUzZHl0c2R0Z2ZC?=
 =?utf-8?B?MjlCbGUvdFltUnRCd2lwR0RvWkVhcnJPRHN3dWdZeTZZemJYZk9PUCtKR2s1?=
 =?utf-8?B?TGlvZnZnUlhhWnVSbE9WQTlmdlBOT2c5bHZ1ZWlPK2V4ODVDYTM1YS9mblQ0?=
 =?utf-8?B?MWVmSGtHVnNxdE9NS2VYYXJLZFpRUnJIRGxNREtSQlVHU3lHOEgyM0dVVll4?=
 =?utf-8?B?QWREK1VGNytSUjRGWVpZRmVxUWhTTFB5OW94SmxFdkJ4Wlcvd2pMeFRWeXVL?=
 =?utf-8?B?NU5sa2ZyL2lnWEtLQ2RuRmZ4MjJLeHNuRGcyb0ZxSGsyc1grdGJSZ1oybVR6?=
 =?utf-8?B?dCthU1pLRmVPMXFoTlpMbVBpRW5NeWc2MXdoMFNiM09YZmQ5QjBlSDlocXpj?=
 =?utf-8?B?cERZTXVvVU5KTzkrbmoybnBxYTkway9iVXcxSEpobkhtRVVYNUlvYzV4OXBD?=
 =?utf-8?B?U2daM2xRNDJKVitDeTRFK3U2VXFhSCt4cHFwRll4QytnK0hFMXRyWXpBUzJZ?=
 =?utf-8?B?YXhxMUJpQUpYMEZwL2huMlNkU3RCRGRrMjVYeUlsVnFxeFRTTmo0OHl2S3ZP?=
 =?utf-8?Q?Oxz8jv+IsTU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3B1VXB3dzlBdllyTDdkRTFUTmVzeWphQWJtbkNUNTF2TVJGR2pha3NOWDA3?=
 =?utf-8?B?VXlrQUFlSHU0ckw3WEVOamFHV1YyRXNUUnhTUFJxdEl0TjdUOENOdm5kMmVE?=
 =?utf-8?B?Q3FFY3JtOXAwNHhUbkxEbXRUL1pUdjVQK2xnWDQycVVObitQU1ZvUXY4OUs0?=
 =?utf-8?B?cGJnbTRIdVIrQWpBa1Z2QXJiS0xjT0h3Wmh6eDVLRWZFdnB1Y3EzR3Z6Yk5E?=
 =?utf-8?B?T0MvT200YXp0aEFUMWg3Q0gwN2hoYXFzZDBkWmhvQ0dmeXhOS2c0ejZsa1kz?=
 =?utf-8?B?TXV1VlJiNHpSNkV6Z2Q1K0Jvb2gvTHZLMWxlMk1kMTBLTHZDNUlBSFl6dlcz?=
 =?utf-8?B?b281YitBTVpOZHBiaURoQzFrMkgvKzVNem9aOExzSVdlRWdEc0pLT1gzL3pt?=
 =?utf-8?B?bkNQajFuVk1Ed1FmZVlnTVFSMkxvWklicldDc1prdmtTSEFWY1huSHFqcWlQ?=
 =?utf-8?B?ekJ1WWVTZ1dEK0Q3VjBkWFRtMUZqYkxEcGM3NnJNVWVJRWdCZGNFaHVLTkZW?=
 =?utf-8?B?UEhBTVovbkVjdVBxTVkyRC9TZ1B5Y2dtTTcxSzhBb0VveEFZMCtZVFRCekJs?=
 =?utf-8?B?VitzdXF1Z3pxVGxHZ2tJQktmdWdtWUpySjZPZXhEc0pZWVRVMmF0OXYvWnQy?=
 =?utf-8?B?YmlyYkxCbHZDc081bnYxd2xJTi84TGhTaXVoa0xRNlVBK1ZubDlneVVHQUM2?=
 =?utf-8?B?VjlpY1hKMUUydktkaVpEcEw0OVlwNkdNVEtFTDhITy9rZytMckRIeDVseFll?=
 =?utf-8?B?aFNPRVNQRGZmWUZXQTl4M1FWbmNPL01iaFE3K1U5aUhIamNObjBBc1M2SkhN?=
 =?utf-8?B?R0pjTUgyUjNrWThuM2lEeEFQdmNydXQreW8veVpIYmpPSFJEUmcrSXhVT3k5?=
 =?utf-8?B?b0o5eU9UdktzNzdkU0xZdS94V1o0YkNOUGpuU3E3RmtDZUljb0UzOGdoSXBz?=
 =?utf-8?B?VFJ1OEtRNFNJbk55MWVPR0hkVTdDekN5MVVGdzBUOFR5TnNMYW9IRjYwRmlD?=
 =?utf-8?B?c1JPeEpSL0piYmJOY0F4MUJMc1FmL09Ud3BaSVIvL2RseTBEUHpSRGZuTHpm?=
 =?utf-8?B?RnJnOEFJZWs1M0xUdElMZWNjMndUdmVkbGNIUC9HRTZVWnhlVUQ3bWk0OFlp?=
 =?utf-8?B?RmRMV29hazhTUTRYL1ljbDlSZ2JhRW02VUdlQnY3WVJEZlNOandwbm11VlZm?=
 =?utf-8?B?bzNsMEd2NlFKdmNkTW81bkpSNFRsSmhibkdKdEZXS21SNTNmMlpqRXBjY2xH?=
 =?utf-8?B?UjhQTjRKdFZKOGVkdmZ4ZmZMVUwxTnhmZkdiUGMyMy9LWnZXMDY3SmhtTk9S?=
 =?utf-8?B?d2U1RGxkbkFNWEJaRDB6NzlSNkZVcFpHMmFjNm5EV2F1c2swaHRaRVpoMlY2?=
 =?utf-8?B?aDRMVHRlNGFLbjlOcXlWdXBIa0xjck9Hb2dqUmxTdjVLUHdvT2gwVXQrV0ZF?=
 =?utf-8?B?TVhQcGtadWs1U1ZkaTFGdTRrUE5GSnpheHdjRmtIVEIvNm9IbEpqUDk5OUlB?=
 =?utf-8?B?alFERmhqa2x6WmMrbTc2TndrejJ3TG1FZ1NOMmNvdzRad2oydHN4TTMraWg0?=
 =?utf-8?B?cGRaR1BiRUdudkZ5UUZya1ppcGo5RTFselNRTWlSRGoyQkxENnRmS3BVUXEr?=
 =?utf-8?B?aWxyRGlhQ3pyWWlCMDRHQUZ4TWIyY21PMEZpdVl3WUZCNWpIT21nRnVrVjBP?=
 =?utf-8?B?aXdOb3o4R292V2xQQmo4UW5yVnF6MERhcmVnVExzd3RVdlhzKzVzdTlnUWVo?=
 =?utf-8?B?VXJFdW9iSVVoOGppd2ZTSEV6V1NZZnVlWC9kMVpsQkxHZlA3bk8yN09sVkFJ?=
 =?utf-8?B?MXJUTWN4d1MvZTR1T0F0SUUzbGlQRkVEVWt2cXhqZ2kyRW1wVnQ4R0RHeDVj?=
 =?utf-8?B?WFBPV1hSUUVmRTN4dVJBREJwL25kSURDa2llUklCUWFMd25FVlBISm9tSHBa?=
 =?utf-8?B?d1pzYktxejRWZ1dJWllWaVBqenFKaEJYWk9Ha0x2aWNyZ2FrNVZWNUlLdjdQ?=
 =?utf-8?B?Q3lUajNwckh3VThhY2U5WlYrRkYxb1BIZWszMDVmRHovcFM5MkJLMnBnckth?=
 =?utf-8?B?OU5Pd0NYcE9BOGpQOE5TNkhNYnZ1YzFxZE9ySVhrUld4OEFBQWhpRmV6SFlW?=
 =?utf-8?Q?IGBQQ2ZM66BUJwszXzXt/0MfM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8991197-db66-4c5e-5c55-08dd61937134
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 18:26:44.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QW7xhTY06GUsyJTIIM9EnGJQbGMnOOZ3YYu1QqHuo3ANXYBKkaGOD+nL++Ss7N+gWGdEDPfwEyufbAqfpiXBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

Hi Kai,

Thanks for your comments and my apologies for my late response!

On 3/5/2025 7:20 PM, Huang, Kai wrote:
> On Sun, 2025-02-23 at 21:20 -0600, Cedric Xing wrote:
>> Add new TSM APIs for TVM guest drivers to register and expose measurement
>> registers (MRs) as sysfs attributes (files).
> 
> Hi Cedric,
> 
> The current TSM is done in configfs, but not sysfs.  The reason, quoted from
> commit 70e6f7e2b9857 ("configfs-tsm: Introduce a shared ABI for attestation
> reports"), is:
> 
>      Review of previous iterations of this interface identified that there is
>      a need to scale report generation for multiple container environments
>      [2]. Configfs enables a model where each container can bind mount one or
>      more report generation item instances. Still, within a container only a
>      single thread can be manipulating a given configuration instance at a
>      time. A 'generation' count is provided to detect conflicts between
>      multiple threads racing to configure a report instance.
> 
> And the link [2] (where you can find the relevant discussion) is:
> 
> http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com
> 
> Could you elaborate why do you choose to expose MRs via sysfs rather than
> configfs?  Is the above reason not valid anymore?
> 	
The key difference between MRs and reports/quotes is the lack of 
context. Reports/quotes benefit from having a separate context for each 
container, ensuring they don't interfere with each other. However, MRs 
are global, and creating separate contexts would be confusing since 
changes/extensions to MRs by one container will always be visible to others.

Below is TDX specific:

Report0/reportdata is an exception, as report0 serves as a comprehensive 
list of all measurements rather than a container-specific report. 
reportdata provides an easy way to request a report if inter-container 
race isn't a concern for your application.

I can see the confusion here though (both Mikko and you raised the same 
concern). I can (1) take away reportdata but leave report0 as it; or (2) 
take away reportdata and break down report0 into tee_tcb_info and tdinfo 
(and strip off report_mac_struct) so user can still have a comprehensive 
list of MRs; or (3) take away report0/reportdata altogether. Which one 
do you think is the most reasonable? In all cases, I'll incorporate 
Mikko's patch into this series to allow per-container TDREPORT under 
configfs.

> 
>>
>> New TSM APIs:
>>
>> - `tsm_register_measurement(struct tsm_measurement *)`: Register a set of
>>    MRs with the TSM core.
>> - `tsm_unregister_measurement(struct tsm_measurement *)`: Unregister a
>>    previously registered set of MRs.
>>
>> These APIs are centered around `struct tsm_measurement`, which includes an
>> array of `struct tsm_measurement_register`s with properties
>> (`tsm_measurement_register::mr_flags`) like *Readable* (`TSM_MR_F_R`) and
>> *Extensible* (`TSM_MR_F_X`). For details, see include/linux/tsm.h.
> 
> Nit:
> 
> We can see those details from the code.  Personally I think you don't need to
> describe them again in the changelog.  It would be more helpful if you could put
> more _why_ here.
> 
Did I describe them in the changelog? I'm not sure...

> E.g., Wwhat is userspace's requirement/flow that involves reading/extending
> those MRs?  An example is even better.
> 
The intention of exposing MRs as files is to make it obvious to users 
how to read/extend MRs. But from your feedback I can tell it isn't 
obvious enough and I'll update the commit message in the next revision.

>>
>> Upon successful registration, the TSM core exposes MRs in sysfs at
>> /sys/kernel/tsm/MR_PROVIDER/, where MR_PROVIDER is the measurement
>> provider's name (`tsm_measurement::name`). Each MR is accessible either as
>> a file (/sys/kernel/tsm/MR_PROVIDER/MR_NAME contains the MR value) or a
>> directory (/sys/kernel/tsm/MR_PROVIDER/MR_NAME/HASH/digest contains the MR
>> value) depending on whether `TSM_MR_F_F` is set or cleared (in
>> `tsm_measurement_register::mr_flags`). MR_NAME is the name
>> (`tsm_measurement_register::mr_name`) of the MR, while HASH is the hash
>> algorithm (`tsm_measurement_register::mr_hash`) name in the latter case.
> 
> Please correct me if I am wrong: in my understanding, the purpose is to provide
> a "unified ABI for usrspace" for MRs, but not just some common infrastructure in
> the kernel to support exposing MRs, right?
> 
> Configfs-tsm provides consistent names for all attributes for all vendors:
> 'inblob', 'outblob', 'generation', 'provider' etc, so it provides a unified ABI
> for userspace.
> 
"attestation reports" in this configfs context refers to opaque blobs 
consumed by external parties, while the guest acts as the "wire" for 
transporting the reports.

> But here actually each vendor will have its own directory.  E.g., for TDX we
> have:
> 
> 	/sys/kernel/tsm/tdx/...
> 
> And the actual MRs under the vendor-specific directory are completely vendor-
> specific.  E.g., as shown in the last patch, for TDX we have: mrconfigid,
> mrowner etc.  And for other vendors they are free to register MRs on their own.
> 
In contrast, MRs (especially extensible/RT MRs) are consumed by the 
guest itself. They are vendor specific because they are _indeed_ vendor 
specific. The intention is to unlock access to all of them for user 
mode. The semantics (i.e., which MR stores what measurement) is 
application specific and will be assigned by the application.

> Could you elaborate how userspace is supposed to use those MRs in a common way?
>   
> Or this is not the purpose?
> 
Sure. For example, CoCo may require storing container measurements into 
an RTMR. Then, a potential implementation could extend those 
measurements to an "RTMR file" named "container_mr", which could be a 
symlink pointing to different RTMRs on different archs.

Of course, we are hand-waiving the potential difference in the 
number/naming of the MRs and the hash algorithms they use in the example 
above.

Generally, as shown in the example above, common names (e.g., 
"container_mr") don't provide common semantics (e.g., different hash, or 
different measurements may be extended to the same or different MRs on 
different archs), so we avoid using them. A full solution would require 
a log-oriented ABI and a virtual measurement stack. We're laying the 
groundwork for this today.

>>
>> *Crypto Agility* is supported by merging independent MRs with a common name
>> into a single directory, each represented by its HASH/digest file. Note
>> that HASH must be distinct or behavior is undefined.
> 
> Ditto.  I think it would be more helpful if you can provide _why_ we need to
> support crypto agility rather than _how_ is it implemented, which can be seen
> from the actual code.  Once merged, the _why_ will be helpful when some random
> guy in the future tries to git blame and figure out the story behind.
> 
The reason for crypto agility is to allow introducing new hash 
algorithms without sacrificing compatibility. It's a lessen learned from 
the TPM 1.x to 2.x transition. I thought it was obvious, but will add 
clarification in the next revision.

-Cedric

