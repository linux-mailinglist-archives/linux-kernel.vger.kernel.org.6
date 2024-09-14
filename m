Return-Path: <linux-kernel+bounces-329500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7FB979218
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED291C2143E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0021CEAAA;
	Sat, 14 Sep 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ/AmTGm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6C1D016A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726331773; cv=fail; b=pB+/vV1SYPDdmN32f3UvfXSB7YpawLiHikANxv5r52tbrK1F6JoVvcu3U4IaswSEmm7u0cKZ9/KFzMp187IU76eGS2HbO+uYK9oPG8z1S2vgrahcWTNAXUbuKst/pU8fMlSA9FknSwKeorB7zem7dZ1M0jHFJ6WmEXW2blNa1jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726331773; c=relaxed/simple;
	bh=kZ/ekLPL0D6FZaC2eCwVLUs8x1ityrSIWyturjyH/e0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N+8aLhhpDMhd2GOZUHF2yP2y2W3WA5T7n4mW4OOpHl1/eBMCtJNwgjVBeCGfLDN/VrtqjSaTCreEJI5xX9Twxpr8ejzfGPBzNZh8PSNCMQPdlVFke3mKDreHhNEnzQPVe3Eli+1cZpuGzQlbihfUCt8oRjD547/Cw2M0mjA/u+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQ/AmTGm; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726331772; x=1757867772;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kZ/ekLPL0D6FZaC2eCwVLUs8x1ityrSIWyturjyH/e0=;
  b=SQ/AmTGmcPEXL8Z1YXAuTBzM2o3FK5tTMgEiB+3cB5PdIkkXeC1L7nOb
   0p8gkeyKKBQ9032Zz7N8JzrgSeHMcG1+yMe7vC/4UA4qfz3mS3zy3p5zc
   Ep7zrwjfccP3os66aXewK7llXVenM8nPzlmPRq8RoC+FzBq7PWpYZts5X
   3fGMbyFb0VxBwrsHmm5a0C9GA4z+YK9sEnvQsgsqsdFaUeC9Vt+xyFQT7
   dwvqJ4wTydu2Jo+XZ+E8D5IRXT+9LRrUnnI6V0TlJXsh5MRFnNAeqGGLp
   0f1dMnWDaT4oZLUEDNaw7OmSoAtEWecZ+DnrvvmpX48a+ZB+FDYALZIDv
   w==;
X-CSE-ConnectionGUID: Q1c8qRN6QhuBJlIJZ0XIRw==
X-CSE-MsgGUID: VfLb+AFhQ8GOgQaV7rBuRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25421786"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="25421786"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 09:36:11 -0700
X-CSE-ConnectionGUID: e9sRGE+EQfWgMgyEVLFq+Q==
X-CSE-MsgGUID: yYq6aXmySMOUXJgP293xBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68423914"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2024 09:36:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 09:36:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 09:36:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 14 Sep 2024 09:36:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 14 Sep 2024 09:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdeRdpneu61FKW6zAqQc8XoVqTdOD6ezlxQPo76U7ZgVPyZi1QGw67qADEDfI4MRS5aZ+JfQNpYIo9hnASa8BNKxZcr+6+6YGaUfh7qOJc6omG+GFnk4pTAqHZV/6m6Mj49ByBrgjCqC0bg2e6XOT9NhmJwOkj3x1XXABBzaMGbAGn1Qp8whNNx0fKm03IJ09nR1NJ4qYtGm4IpLZj/p/P23qSWTHROxey8TiztaPYGmlqkSZptr+sw2dPzG0MaI1lPXx4R00z75f8lTmKPPaRwrpUGAX9PMQVwsNPfk2qziK5hNECUIN0+cl8BXlrf9r25ADT79H5HSB4QXuPmbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o2VmalwbcJjIidX6ZP5pL9bJ3LSzvndxSKG8WbjqvE=;
 b=LamB9Fsr9gU83Qb5ltnVLMVIvI4OXKzyGr6wMeTrkpKuMNCLg1+2bumY7sf8IaUQyHRWx7m6D4hbZr6or3yrZqbOJ/6ACsSZqynhuCftXz+OpT5iDCKnnCx1/ZUGelVrWu3sRmZLP49UIfpvPylfNb4PU4Oqvp6KgDdqHVaTGNNidJW5lj946Kwm8aC+gev4Uim0CRoDeOZcUJYIFANafE0igkNXs1CssfeKArQfHvF2lBCfaKHVm7wHrM42kmLXbqha08FPf+SGD+ZiG8YgsU8RFu3NEG1yWVIfUyvJ3HK28Z9CiYkYskTRVOR0HEXiuqYqg9y/y/oLLOHLVoIGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Sat, 14 Sep
 2024 16:36:06 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 16:36:05 +0000
Message-ID: <796ebe16-86a4-4109-9b80-91a238f975f0@intel.com>
Date: Sat, 14 Sep 2024 11:36:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] tsm: Add TVM Measurement Sample Code
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao
	<qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240907-tsm-rtmr-v1-3-12fc4d43d4e7@intel.com>
 <86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <86e6659bc8dd135491dc34bdb247caf05d8d2ad8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:930:8f::16) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac10121-e7bd-4072-8535-08dcd4db543a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2F0S25RMnhOdWltVFJxRHdZNmlhYytYNHk1NGFKZUI5YVg4TmZORnN0djNQ?=
 =?utf-8?B?SDZrZ0MwcjYxNThsaExBV3BZTjdRU0FqVWRLVVgva1IwZnBUWU12anNJUHQw?=
 =?utf-8?B?SUJXODFXb0dkU09QbVpZVHdrZWFKUzFLWWQ1TUF6NFlZMjU3NVptTjVEZ1Br?=
 =?utf-8?B?aUJ3RXJSWVk5WkhHV3dWaGl0eWVTNEpiMUF5RjdBQkxHb04xaFU0eXEwOG5Y?=
 =?utf-8?B?aC9FSjlyNGtaVHFGWlF2SktDT1NQZmxKek5Wa04xbDZmdzFEWjNMcmkreERo?=
 =?utf-8?B?WGJnZUd4TWdEbkQ2WGcwenZQVGl6VW5xUkozQkYxTmhWNUdRWmZWUm9yVG1T?=
 =?utf-8?B?OUpyUTZVUzEvVVowV1ZyYldIMHl4Y0YyQ0ZNdlV6aG1lTEp0S2ROL1JmeTd1?=
 =?utf-8?B?RGN0RjBLTlUvYVlhNUt5WXJmcks4QTJEaFAyQm1DV2lOTkhvWUlmc0ZuZkh2?=
 =?utf-8?B?SWFjajRabkQyNFo2ZW5weVJTVTBNaDVZa0RsWVBuMTBVbGh0akFEOEFMWmIw?=
 =?utf-8?B?L2czOUlkSGM1VmRxNERXcVhaNStOUEg2enFjNkp3K081M2kzM3VvMkdrd2ZF?=
 =?utf-8?B?T1hGNnJhcTVuWUYyV0ZIVzhjbjJoMHBPRlNuTXkyMG9Qd1l2bk1lWkt6alk5?=
 =?utf-8?B?TUtqb0hrdm5tYnJPN0ZoSC93R2trNWdnMzJmZFc5MmwxNTNVZ3ZUTUUwK0xS?=
 =?utf-8?B?am11MnBDNXpPMFhZRTR1Z3JoUHVpUXVuajNROUhiZDJob1JqV2hjbjFKY09y?=
 =?utf-8?B?dzNzc1VQcnVpUzR1RVhVd2RrR3BVNDAzaW5sdU95L1NHZ3B5N3l0MnlHOHRv?=
 =?utf-8?B?TkJ3VFhzL1RGaDcyeXJQZHBxR1JXc295cS9JcGphUGg0b0cvdzQvTmJwL0lL?=
 =?utf-8?B?UzBhcndXWVRkZUxrejlMZEh1MSttZExoV2lUbUdYQjZEenB6Q0VOWWNDTDBt?=
 =?utf-8?B?QnNaY3l3eFFRNjdZL2QyOWY1OGZLbmJXMGY5S2pETUExb2cwVnQrSys3Z1Vl?=
 =?utf-8?B?UlY2R3dIb0Y1UXdDUEtiMFhpaS93WktHL0hFZm5rZW9nNWY4dnB0SUswRXRZ?=
 =?utf-8?B?VjZ3bEtGZVlOZ3pBb1BIb1NOVzh0Sm93WHNHM3JtZDhUaUdDWWszQ3BzaGpX?=
 =?utf-8?B?TTBrVE5JdGJDNnBoci80MnlzR3Q2V3FLQkFZLzN2QzF1ZHBHZjR0bVBQRXpT?=
 =?utf-8?B?UFV0azB2NEgyOFR0ZEk4QXQzbWY5aXNmWWdaR3lSWjJvRXFMWGdmbEZqWmpN?=
 =?utf-8?B?aW5tQy9uRGxUUEVLVE1zQ2xIaU53YXE2K3pTSEpvdFE3ODh1TjVqQnRSTGdw?=
 =?utf-8?B?ZkdJc0NBaXlwSndTWHdBN1BvWi8vdzlOaDlNbXd6Z01CNXZwaUJtd3dtcy80?=
 =?utf-8?B?YlkrTHBRaGJvQ2tZVVVEd29IeDdRT25XRXlXQ2ZNOUZNci9iWG9rQlM5TnJD?=
 =?utf-8?B?bmJPVjh2NlN2L2t4aCtHSU53Nm1CcFhQTDE0MHJSNFZ1ZTlqN2ZXQVVDTXRU?=
 =?utf-8?B?Yk14TDJyMG5DN2t1TWFSMjI2ZWJMVDhwMG5KSFQxQU1oUnFMOUdraGZtRWtv?=
 =?utf-8?B?S0JuelRTMWZ2TEpDbTRzU0hZMzRGSzlmNFUwWVFWNTdGWk5YMS94ZDRGa0FP?=
 =?utf-8?B?TTUrNmh0anNUOXZBS3BOTGtXZEtuNlp4aGNpVHlJb3Y5M09wY2pTTVEzcjNj?=
 =?utf-8?B?YmJTY25hV1ZvUTU3eUZoVEw1WGJvdnJSN1FrNlZqTHUrVkJobEtRWkVSbUoy?=
 =?utf-8?B?T0ZmaFI0K204Q1A5Nk9XaFFVZUhkUW1YcVpZV09Yc0FoYnZubDBQQ0lsZXh3?=
 =?utf-8?B?ajNSWGZnYk5FVHJTYjhEQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHZFVXpyL2VnWFdLNUxncVJXZW54ckZxL0ZNakV3WlBDUWtQOUhYRWlCOUNu?=
 =?utf-8?B?dmdoS3IxbFV3OWJSMGJpTEhUMW83NUNkUFJvOUpFYWo5WFRFL3QxelhoTE12?=
 =?utf-8?B?TnlLQWpIRGhuSlYyU2tEQkp0T096eGFBcWR3VWQ5aHpiK013c0ZLcFNSN0Vs?=
 =?utf-8?B?emR0eHQvZmJJK1FmeFh4M09aWVlUYWVjdkh5WFhGVVNEclJLT0VNVmVYNko1?=
 =?utf-8?B?RlVuY0R0ZVgwS2l2RkUvdHNqTmFlU0dURzdwMmFVQTBOSngwWkV0UkQ1KzZE?=
 =?utf-8?B?VFZ3YzZqWmxQdDV6UExQUldMRkR4SUQxdWtxdFlXWkQ0bkVvS1YvOVI2aGpE?=
 =?utf-8?B?MmRPYVFwRis0VDY2ZjJDdkxWNTRRSTJVcHMxdXRMNnljMThDNUdjRDhvcGNr?=
 =?utf-8?B?VDdCMFZjeDdNR2tTdUZXd0h2eHVFbHNSd3dpSFcrL2grNnVxNzBNNWVwUi9U?=
 =?utf-8?B?UmRFRWNDMmVyV2NjVTJBc2tvQ1JqeVJwaG1qc29VUUwyRzRJdjc4VVJHVDdp?=
 =?utf-8?B?VnFVdHRGWTNzaVZ1VXkySk12ZSs4SENEajVEaTNJNk1rM292dUVscjZabzB0?=
 =?utf-8?B?K3dBQTBJdTdqdVlhV0VHR3htT0p0WURtM0E4WVQxUWZGVExrUmFiK2pkWjd6?=
 =?utf-8?B?cHd4SkxKK2YxUDFPMVFLRThjaXBuR0NBZ3RTOGNSa0lSendmMlV5Z3k4d2VS?=
 =?utf-8?B?WjRTTGUwaTBNVUk2bnRHd00za2toZWJzTnNFMHZHRU9pZDMvRHFXcEgrYTNS?=
 =?utf-8?B?L3hNcUlEUzJMcFVrSjk2NXJPYzU3cjZxRGZ1SnhrUnM4MmdCeHl5WVRYenZX?=
 =?utf-8?B?ZEVwQXZ4MmFXdzBtNkFvQUJtOTVScUpwV25kbUl5SElIL24xZW5pdnNLSDJQ?=
 =?utf-8?B?dElFVnhPeDNqNVhBMTFURUYwbldXbE5pQlVMMTlsbHEzbWVqeVFaT1NYN3F5?=
 =?utf-8?B?K2dPQVVmZVM1VG5welhoUlVJNkNzVHVCczdmVForSURJTk9lM2ZJQzFGQk5o?=
 =?utf-8?B?eHJ6WTRKYVBJOXRMcDFNYnE5aldSMFgvU0N5QjlpckEvaXV0RzBLdFRDZjB1?=
 =?utf-8?B?N3ZjOFVlbWtkT1M5dm04WFNMQjlLVUJHVFNTNWNRQW9SVzZ3ZDBCdDNiczVF?=
 =?utf-8?B?RUtYMEc4WGg3Y25mblJjeGRaWnFmM1RTS1R0aXM0YkMvSWJKNjJXQk1JSG9y?=
 =?utf-8?B?dXU4bXBMRzNoL085ZVl5R2FKNUZkRGpDUnJlUFQ2VVhDQnBWVnNiVkdTdCt0?=
 =?utf-8?B?Y1hhcTZRWml1dk5nR01oKzZ6TFpMczZaZDJJNll1UTl4V1dLeWlweG5EQyt0?=
 =?utf-8?B?aG1ZY3lSWVF4R3ZaNmc2Z01qRWxTVUFNSDZkWWtJQUdaTEFOSEh4eFhzMExH?=
 =?utf-8?B?d1RocXZVS3NFaStmbmlWMmxhaW1lUGdXcml6d053WGZHd2c3bjcxVXZNamxT?=
 =?utf-8?B?dEI2VDUwcDVnSW1Fc284SHdPTWJmR3dKRkpOMTRzMExXdXNMVVdGMmZXc2N0?=
 =?utf-8?B?TmlUbFZ3WUdQVVJwcCtDT3I5bGYrdDcxMUpzUWZxdTBnaTQ4a0FsSjFyNkhk?=
 =?utf-8?B?dldCQUpjUjdvdmxVcFFkeTFxNVdCV25nTThZc0c2Y3F3OVFHYVZJNDRkVGJP?=
 =?utf-8?B?RGRoaHgzdXIwcVJKMm9MKy9zbzQxZGVTRCtMNytqVVpSdmUrN1dxVWZoT0lU?=
 =?utf-8?B?UnZ3WVl5ZTdsWEFVU05tQVdtR0Q3UGNsd3NSbk1SaVJTZ1V6aUg5WnlsekdU?=
 =?utf-8?B?dVY3aGRwcHR1alFJWXZVRlRuZCtjaDR6bmRLcTdTNTJYWEZXZmxkSmhlbGxK?=
 =?utf-8?B?SmRtUHpQSWdwZitDbUdnNUZ2KzFpRGhYRDVZSExtMSt4R3NHNjNPRjVzdUN4?=
 =?utf-8?B?MDVQbTRSUGZBK2E2NGlnUUVSRUY4dXh0YnBiWTlKVS8zakZTVG4yeXB3dEVa?=
 =?utf-8?B?SU0wR0FpUTdHMDhHWDBJYkt2VnNqQnRzaVN4SXdkYTZLMHlqNXNFcGlncW5y?=
 =?utf-8?B?V3ZmTGJGNUoxSkpXdUdsam1zVHlWOTF0OVZvd2crcVU2SzRQa1FrSlhNNm1B?=
 =?utf-8?B?Qm5mVC9HMllBVEdvRk9ObFkxOVo1M25PZ2pmeGNSZGo4UVNEOEZ0Y3ZleGlV?=
 =?utf-8?Q?wWatV+2f3yo4vIOjVtXnvLizz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac10121-e7bd-4072-8535-08dcd4db543a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 16:36:05.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIenyaJmAoV2mI/Pe/T/T1lxwcEbNWRfbJNAik5f5Pmx/3FptnjB5Ry8qvxy6gqUtZTLcCpTY3sA4OSbIVQuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com

On 9/12/2024 7:28 AM, James Bottomley wrote:
> On Sat, 2024-09-07 at 23:56 -0500, Cedric Xing wrote:
>> This sample kernel module demonstrates how to make MRs accessible to
>> user mode
>> through TSM.
>>
>> Once loaded, this module registers a virtual measurement provider
>> with the TSM
>> core and will result in the directory tree below.
>>
>> /sys/kernel/tsm/
>> └── measurement-example
>>      ├── config_mr
>>      ├── full_report
>>      ├── report_digest
>>      ├── rtmr0
>>      │   ├── append_event
>>      │   ├── digest
>>      │   ├── event_log
>>      │   └── hash_algo
>>      ├── rtmr1
>>      │   ├── append_event
>>      │   ├── digest
>>      │   ├── event_log
>>      │   └── hash_algo
>>      ├── static_mr
>>      └── user_data
> 
> I'm not sure this is the best structure to apply to logs with multiple
> banks (hash algorithms).  There needs to be a way to get the same
> registers measurement for each bank, but the log should sit above that
> (appending should extend all active banks)
> 
> How about
> 
> /sys/kernel/tsm/
> └──<measurement type>
>     ├──reg0
>     │   ├── <log format>
>     │   │   ├── append_event
>     │   │   └── event_log
>     │   ├── <hash algo>
>     │  ...  └── digest
>     ...
> 
> That way it supports multiple log formats (would be the job of the log
> extender to ensure compatibility) and multiple banks.
> 
I have considered this before. But I'm not sure how to (define/describe 
criteria to) match an MR with its log format. Also, MRs are arch 
dependent and may also vary from gen to gen. I'm afraid this might bring 
in more chaos than order.

-Cedric

