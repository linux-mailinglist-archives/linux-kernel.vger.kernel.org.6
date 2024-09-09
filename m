Return-Path: <linux-kernel+bounces-322082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976599723C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FC6B2232B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6D18A922;
	Mon,  9 Sep 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cs387SHZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEA175D20
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914075; cv=fail; b=BKZLVDK0mqhaXsC1e22x0Vq9ItVIe6Wg1juIHieYusSIFNH9sgUUhKf3IF4qQT72+FUclmhE8eFoUblsb2Byw3/PX+TRkWYjotsUx/7oK/puKxxM8l5zgii749EypYc3tKevF6O7ont5Z/kEF8D/pRMhOp8t72eMtDSFcaafQ04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914075; c=relaxed/simple;
	bh=+Ukjl826qVy0YyN1UUWTWXCeg34wYw+qxCRFektGibg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHe7QsL8eQtnANl5Qjyq0dCKpaJlA3UCmGQJuU95Uiy6QsCLb6lF76l3Qey5wHfdIkusNCL8nGswyqP9crYxJd6kkEePC9OVZKHYTH4XzjHrGxMHaXFFxN20o8gWCtjBTcAfN2FJIhweq+6lnrASWR2Fzd+J4k/jN1RQYcdRtto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cs387SHZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914074; x=1757450074;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+Ukjl826qVy0YyN1UUWTWXCeg34wYw+qxCRFektGibg=;
  b=Cs387SHZvjJ+sA41+bu7/d7KGOahceHmFqOoy1WZixb1Uhpm+bSlGwmC
   MvKwltgzqQ2E5hRx5HJtbzXc8AXLIig+t/rh8sH2uTwCHITP3xcu0RkbL
   7Tned/arx2xL2Pq0flV2UfGvFrOycJOaChHkrKXRiSAag7sfEqVJ+hsMx
   J+XdQ4UfagQzQjd0XRnJC/wiJx1jA3wNJ4poOL9lE4FCqlO5/wb1H7lYH
   ybAN66UgC5nnd3IKr3w3RLSuHBtAlxRamRqRoCbCbQ9e6ZWTCZrhI0r5P
   72AmZooukFHOOR0s4FeG7hBCRt3YJlUQIf/z9txtrxGGl5fnhpAdjMIrQ
   g==;
X-CSE-ConnectionGUID: 37zV1Kc1StymFwfiS8sFqQ==
X-CSE-MsgGUID: K7at1lPuScWnKxTfE2/AOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24133355"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24133355"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:34:33 -0700
X-CSE-ConnectionGUID: zvE9oA23RbmfpjnGod7GrA==
X-CSE-MsgGUID: 0vossBS5QJq+pQIwr323Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71587943"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 13:34:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 13:34:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 13:34:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 13:34:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0vRSLgUXPlSKIAshFtv7AguClv/+pHu/qBBdd1wenZHLfyENdVHbVb15sWFwn+LvtuMPILhd7kkYYRvbmQ8V75x2CC8E5C2ZxHiAUBSv8nzf4ie5jv3ua5tqltleCb3AW4mVxgUAbr4aXmvY1RmsH1r3OhXnFsb1Xeq8Amwkq3/OsyejJAmw/G4+8rQ6jCGoiwp1kFayog4mbZT4XNW5j8Vp9nwJO+FMfw7VOeuLVtgd30eLlveTTS9q5z3661WXiM0D23wL9xuEYvtw3iQhcX73JzWRO2fjOL1zyGChkcHSrpi4v/9liWpTVZgH7qF3I7Bg3Es5vtLr9rTV0zROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5/DyLaFmWpFI7V+KIzib7zHm8p/9S6+B5o8mRe5Oz8=;
 b=JQf5/RKKkvEU7iEvQI1f14ydVLgCtV4DBWqqwQDL9A1uUBGOh4X1v+0XKe/TvnIAfws9UYq7AiKRyKtR0+pvGur8J58i1tj+/MFhCNIecYaudNaN2ihmIGvffbu7SvSjQjOHUbOc6+EQM0dCdQsF74mcFRTeNxeej661LiLjW1QPtlod2OPwMvwqzfadMljBAt+hIMjlIdE9ZGSWGLvh12MKH7tt6IIcpIJIlZnlGoYrQmldDazBpdMrwmBFwAP2D3tx77nMtPHjk0oFWMWUoqUBpJOpOZZ7fWUGPoNx092nNPuZfNQOCnq2x8AZZ0NfcB42TJikUMLXpbjrdVTFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 20:34:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 20:34:29 +0000
Message-ID: <05b7b857-ba73-499f-bc92-4397af2006fa@intel.com>
Date: Mon, 9 Sep 2024 13:34:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: Export the parsing functions and related data
 structures of the PLDM library
To: Shawn.Shao <shawn.shao@jaguarmicro.com>, <linux-kernel@vger.kernel.org>
References: <20240909063310.1730-1-shawn.shao@jaguarmicro.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240909063310.1730-1-shawn.shao@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN2PR11MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: 650d14b4-93f8-4307-4afa-08dcd10ece07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjByWWJCc1IzaGd4UkYyNmFDdUNWS1JoMk56RlFVMkROU21xMDk2dXFlQmly?=
 =?utf-8?B?SllZTlE4M1FBMGcvQUV3WENCNVovT3lRUStlRXVXeTRXNXhPZTFleFFQQWJI?=
 =?utf-8?B?QXZkbndWNVl4YkVNOTJZTDlUNHhKM2lSSUFwVXNTamxndGxWL3dwbWZHQ1J4?=
 =?utf-8?B?QVl6ZjhQaExpVGVCQ1k3cjlDVW5RZ3FDUXFTKzVDeTUyeGZrMkNJRWNzK0s2?=
 =?utf-8?B?c0c3QWFIWmc5VWpDWllvenJLRHVhcEh2YlFaQTZvd3hqekJJbmFmQUs4cktn?=
 =?utf-8?B?QXNndUw5cUtpRDlybzNCeW1zRW85d2JNeS9lbW85TXVxb0p2ZDA1QzRQVkl6?=
 =?utf-8?B?d1cwVDdCaGhIOHBKS3dCWFVBZWNMbmVIOFBrRXZWT0h2RHh2dnlmckJwNSs3?=
 =?utf-8?B?RUtWMFdnOWRFdlZ0bzRxeWtZd3RkVE5IaEZreGtjRzdPdS9sL2hvemo1RlMv?=
 =?utf-8?B?cFgvQVQ3SXltc1VxSzdmbmUvY1NaYVlhM1ZYK3ZGNFE3Sm5pV2hJU2ZlTHU5?=
 =?utf-8?B?VEt0SHBtWmZxU0dLczlqUGJvRi9wQm1HaGVpZXVOTzNvSFJKcldJVS9CY1kz?=
 =?utf-8?B?TmxvU2ZleTVrOVRDdG13MjJFRytiTEc3L0p1cHNFSXAyWW1FWEZkLzRNUlJk?=
 =?utf-8?B?TWIyUUFacUZxRGY5NFpVK2ZQc1I3SmQ5M3drZXR1aG55YmhKRUpvS0dnakNF?=
 =?utf-8?B?Qiswd2xXWFQxbG9tcXVmNXVRTTNIMERGQ2FNS2ZWR1RTQjhnZ2JBWU02UFhh?=
 =?utf-8?B?UWhwMGZDZnJOSWtXZk5CK3NaeVpLWmwxczAxamZ5RTVWSmdFSkFPdkRRREJN?=
 =?utf-8?B?Z1YwcXdUVzJoa2tyKzdOK0Z3ZThXQlZEYmU4TDFwWDRXalIrU0RiOEJDZy8x?=
 =?utf-8?B?d2JIWldMNWRKeG1ZME5YSU43bnJOY1RsNDNXN1JEc0hBQmpJYXdTOHNFMFMy?=
 =?utf-8?B?MmZRS0swY3hkZHBPQXAxbzI0eCtkZklPMGtid0g4U21CZTVOTC90eGh6MEZE?=
 =?utf-8?B?dTVMbDg2WVdaUUxQYUNJN2RrdTk0UzRja1pKejRBUDJ3NVU3WlhvR052S1RK?=
 =?utf-8?B?RE9hTGc3OEpobWQ0QWlwR0RvK0hObEd1US9zMERuOHlZd2p6b2t5aElEQ3BD?=
 =?utf-8?B?T3JEYVlyOFlYQktTWnkrUVJqSDEwTmI2b0s1R2lzeW4yRkRZcDY5aXJJZXpJ?=
 =?utf-8?B?MnRDYU1uYk9PeExBcUh6NzVRRDhDZkM0cEhrcS9WK3dtN3hkVHFTeW92K1lD?=
 =?utf-8?B?bFlISHlHVjNudisvUy82NU1IQXpSclVBcU5KZ2EwZWtRMnE5ZDRibzNyTUtt?=
 =?utf-8?B?V0dRSWxUUFIvcDFBcXVyZzR5TjI5WDJFY1VUWUxyTldXc1lFUmpWK0dydUgz?=
 =?utf-8?B?N1ZqREYzYTBXem5ycEVZQy9CRFAyckF6elJRb1d2aE5qUWNoYXduczVLMVhi?=
 =?utf-8?B?cExJQzJpRi9Mb1JHa05RUzNHZHFvSTlRTGVJcnhmdVloWDc5UVQ5dEJpQ3Bm?=
 =?utf-8?B?VTh3em1IU0IyeGVmdXBBeDVxdWR3amViNzVXSTlQUlFTTURhL1BmZXpVMWRV?=
 =?utf-8?B?VHNUVWxVcnd3cFRIT3VqNEdlVk1jaHcweUpnYjVZTkQ3dnZvMTZsTmxlcmVL?=
 =?utf-8?B?ZHIzSEExcTNkRThWSGNCUGlZTkI2ckVHZ204TkZZMFlueGl5ZTlOZkI2Skc4?=
 =?utf-8?B?N01PTDduRmMvZjdhOVlRWFFnTHRxb0dpUmlZQUp6elFaMXBWNWJMVFFVMXRu?=
 =?utf-8?B?MGhudHZFSkkwN25VVk1ib3RCU1NKemZFMFRDVlJZL2VSelZIZUxwaVU0RUd5?=
 =?utf-8?B?MEErb0ZLK0lCWnU5eDRZUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckFETEVuUmx1ZHdqQzlUNHJTZzh4NDVPbjdJc3VqL1FZQWNYTXRLUldWa2dh?=
 =?utf-8?B?d05TZithKzNqWCtMQ1c0SEM1MldHSEcwVXlxaGlCd1F6Ri9zRlpWUDlFaDIx?=
 =?utf-8?B?ajZWcXJISGNwbW5Da2o5QldKelllK1QvYmlacHNaaXpZT1Y4RVk5cUUxelA5?=
 =?utf-8?B?YmFjcVF3VHF2d3R3TkhYdTMxY0sxL0tFMlQxSXRERFl0aC9zcDM0SEpjMFA2?=
 =?utf-8?B?ZWttZWtvZ29tZ1VJb3I5emRUSDdYTVNCam00eGFXc21GRXRvb2YzQjdmbFBN?=
 =?utf-8?B?OU5JcFhzNXlZRHFXUi9XWW4yOUxtcDloL0tVNmYrd2NBYWE3NWxTaFgxcFlP?=
 =?utf-8?B?MmtVOWI5WE56bzY3UllNakhtajZuM3YrVlFDVEJ4Z29MaC83NUtRN2NWTWVB?=
 =?utf-8?B?cG1hOGxIdDVDbnRoSWpmMVVyaDBtZnRmeDljb3QrY25YakJ3UHFudUsraWhy?=
 =?utf-8?B?RTA1MkUwanV1WTJ6dVJsK3AvYmQ3eVVQU0hwbURDNEk3MmIwMEhsWG5WekZa?=
 =?utf-8?B?U0d1NXBwMUdCYndpdVB6Y0t5MGl6aS9PaXlJWEpld09pZlgyVmp2OTdZdUNP?=
 =?utf-8?B?UFZTOWNrMVBDaUlQVEQ3aS9HTGFRdDcrTVZsQ1FqYm5xVTZxNlJBSDhXNkNx?=
 =?utf-8?B?L0lNT1cyR0hORFZVSzBTdEtBaTJ0YVNGRW1mZk9HVFV1RHRxMXA3YjFQQVVW?=
 =?utf-8?B?S3lVQTRwUk1OMU1xV2JBbFM4aWlIUVFSRUhmeWdFejJEamlYMGFJWFgvWEwx?=
 =?utf-8?B?YVQ0RENHMUFrRTdFS3dlK1RwdEw0QUl1WGZUMlhEbmI5QTloUTR5eFBDYm5U?=
 =?utf-8?B?RkcwdnJhTlZ6N3dmbU1YRE0vSU8xUm1XaklDNlRISGlySXlLeXdIYjkxWHZu?=
 =?utf-8?B?cFQ3TjcrcmRUUndzTG44dUNWY3E4bXMvYlFVWWdPak52ejVTSDRkcjBEbkRH?=
 =?utf-8?B?ZVN6V2VIcXFPbUFwZmZweTZrYS9HRzNmdm5ORTN0WmNJMi9nNnFiMGN4S1kz?=
 =?utf-8?B?ZmJiMmY5TDA1dWJBSHRCUlE0dVFDWGlQcHF0T1Nvc0lzR2dQUElNT3l4OTk4?=
 =?utf-8?B?d3ZCSnY0bFpBOGc2c2tJaHdQNWJLckZFejZhM2owRUhnNEY4K3dQM2RDK1hS?=
 =?utf-8?B?Sld5bmRhSjVnclEra1gvM2EwN3VJTFZwdXdKeUVqMzV4dGo1NndRVmt1c1dZ?=
 =?utf-8?B?bnU4WExROGNSb0NhRHM0ZUQ0VjVWaCsxNS9PZ3NxRXROMDNsdDRLb1duQ2VF?=
 =?utf-8?B?dXgybGl2TUhSK0RweUxvK2lFSW1waUUwYk5scDJzRDl0MlJ2NVhiQnNUSFBI?=
 =?utf-8?B?N1dRaXFiRmt5clNhclB2cGNDNWtaTHhIR05iQ0lBV2RQY2h1Y3ZZa1NveGFk?=
 =?utf-8?B?MndvWHVwMVFmQ0pHS3RyMTA2YmVnaHNoZXJvVVNZOGZIL25xaGdqdE5HeXpn?=
 =?utf-8?B?VnRUelBrWUYybCtvRHlNbFpMUmdCUmZPcGNCV2VWRVYzQnB1aFFQR0ZIdEhS?=
 =?utf-8?B?eTBFUG9nekZyMVk0VnVaVG00R1llK3U2dUYrcFduemxUQ3RGa0VtZW4zSnN0?=
 =?utf-8?B?bUVLelJzMXRhdFFocTdpYjFzd0x3SlZwbVVUVWtnUm9neU51eVNlR0xiOHNk?=
 =?utf-8?B?RWNlbFlRSCtEWDlvQ0gyRCtWTS9KTlg4dWlxblJaaDlqZERxZmFIdmhjYmU4?=
 =?utf-8?B?cnNkdlovOHFXcHhvS2dVSHo4TFhYdzk0VEhqMThXOVhUZDNMbkk1aEl5R1Rx?=
 =?utf-8?B?NFJjM1BnSmlzU1A4YjFzMGpSQitjTDlvWWFUM0RySnV3RExBQ1BzdGRzRkY3?=
 =?utf-8?B?THFhY3kvdGxNaU4vY0JVWjB3dHRXNTcweUFxamYyS0VmRzcxcEpxemFkSVdO?=
 =?utf-8?B?dTNZd3JrMk80bHdVRU94MGF2eXhudURvanlHQ28vS001RGk3SEVjakV0SnBz?=
 =?utf-8?B?VjA2RXhaU3NUZUY5ZExyRitoUlRSUE1welVUbGpmcDA3K1dUWERyQWt3ekJH?=
 =?utf-8?B?a0tiMGY4bkVzczBEMG5HVXp6MUt3Yng4Zk9oZ3Znb3F4WEQ4MHhmYWY1eDlQ?=
 =?utf-8?B?S1Y5NUVaUjlQZ2dtWVJlczJHckhiVkdrNFBCSnJSWWRiSjZhRVNDZjJOaUZ0?=
 =?utf-8?B?U2dCRkcxb2FMU1JjdmRxQU1XUTJMMHBxYlpWdEdEc0FFYlo2RitaVFZNUnlt?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 650d14b4-93f8-4307-4afa-08dcd10ece07
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:34:29.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8hJOGE2/0RtEYsawkPWl1bRDSdJSYL35kLie33rCaRQu4hZqHR1EercCGq3ympVi9HkgBg3yqDafHtRSVAqMkrCKWa+nXrSeZZt9eVvvL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com



On 9/8/2024 11:33 PM, Shawn.Shao wrote:
> From: Shawn Shao <shawn.shao@jaguarmicro.com>
> > The PLDM library is used to implement firmware upgrades,
> but the current library functions only support the
> `pldmfw_flash_image` function to complete a fixed
> process of parsing, sending data to the backend,
> and flashing (allowing users to implement custom
> logic using `pldmfw_ops`). However, this poses
> significant challenges for device vendors using
> PLDM for firmware upgrades.


Hi! I would love to see lib/pldmfw expanded to support more use cases.

I initially focused primarily on the use case I had for driving a flash
update via the functions exposed through my device's firmware.

> The following scenarios are not supported:
> 1. Only using the PLDM parsing functions, as the
>    current library does not support this operation.


Right. Exposing the parsing would be useful to enable validating the
image without necessarily running the full process.

> 2. The firmware upgrade process differs from this
>    fixed flow (the firmware upgrade process may
>    vary across different vendors).
> 	|-> pldmfw_flash_image
> 		|-> pldm_parse_image
> 			|-> pldm_parse_header (UUID/revision校验)
> 			|-> pldm_parse_records
> 			|-> pldm_parse_components
> 			-> pldm_verify_header_crc
> 		|-> pldm_find_matching_record (xxx_match_record)
> 		|-> pldm_send_package_data (xxx_send_package_data)
> 		|-> pldm_send_component_tables (xxx_send_package_data)
> 		|-> pldm_flash_components (xxx_flash_component)
> 		|-> pldm_finalize_update (xxx_finalize_update)
> 
Right. I think there is some room for interpretation in the standard,
which leads to different vendors interpreting some aspects of the flow.

I'm open to extending the library to support other users.

I think the overall change is good, but I might pull out the
device_update_flags into a separate patch.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
> ---
>  include/linux/pldmfw.h | 38 +++++++++++++++++++++++++++++++++++++
>  lib/pldmfw/pldmfw.c    | 43 +++++-------------------------------------
>  2 files changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
> index 0fc831338226..5058a07a5ea4 100644
> --- a/include/linux/pldmfw.h
> +++ b/include/linux/pldmfw.h
> @@ -130,6 +130,42 @@ struct pldmfw {
>  	struct device *dev;
>  };
>  
> +/* pldmfw_priv structure used to store details about the PLDM image file as it is
> + * being validated and processed.
> + */
> +struct pldmfw_priv {
> +	struct pldmfw *context;
> +	const struct firmware *fw;
> +
> +	/* current offset of firmware image */
> +	size_t offset;
> +
> +	struct list_head records;
> +	struct list_head components;
> +
> +	/* PLDM Firmware Package Header */
> +	const struct __pldm_header *header;
> +	u16 total_header_size;
> +
> +	/* length of the component bitmap */
> +	u16 component_bitmap_len;
> +	u16 bitmap_size;
> +
> +	/* Start of the component image information */
> +	u16 component_count;
> +	const u8 *component_start;
> +
> +	/* Start pf the firmware device id records */
> +	const u8 *record_start;
> +	u8 record_count;
> +
> +	/* The CRC at the end of the package header */
> +	u32 header_crc;
> +
> +	struct pldmfw_record *matching_record;
> +};
> +
> +
>  bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
>  
>  /* Operations invoked by the generic PLDM firmware update engine. Used to
> @@ -160,6 +196,8 @@ struct pldmfw_ops {
>  	int (*finalize_update)(struct pldmfw *context);
>  };
>  
> +int pldm_parse_image(struct pldmfw_priv *data);
> +void pldmfw_free_priv(struct pldmfw_priv *data);
>  int pldmfw_flash_image(struct pldmfw *context, const struct firmware *fw);
>  
>  #endif
> diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
> index 54e1809a38fd..cd1698e9c340 100644
> --- a/lib/pldmfw/pldmfw.c
> +++ b/lib/pldmfw/pldmfw.c
> @@ -14,41 +14,6 @@
>  
>  #include "pldmfw_private.h"
>  
> -/* Internal structure used to store details about the PLDM image file as it is
> - * being validated and processed.
> - */
> -struct pldmfw_priv {
> -	struct pldmfw *context;
> -	const struct firmware *fw;
> -
> -	/* current offset of firmware image */
> -	size_t offset;
> -
> -	struct list_head records;
> -	struct list_head components;
> -
> -	/* PLDM Firmware Package Header */
> -	const struct __pldm_header *header;
> -	u16 total_header_size;
> -
> -	/* length of the component bitmap */
> -	u16 component_bitmap_len;
> -	u16 bitmap_size;
> -
> -	/* Start of the component image information */
> -	u16 component_count;
> -	const u8 *component_start;
> -
> -	/* Start pf the firmware device id records */
> -	const u8 *record_start;
> -	u8 record_count;
> -
> -	/* The CRC at the end of the package header */
> -	u32 header_crc;
> -
> -	struct pldmfw_record *matching_record;
> -};
> -
>  /**
>   * pldm_check_fw_space - Verify that the firmware image has space left
>   * @data: pointer to private data
> @@ -341,6 +306,7 @@ pldm_parse_one_record(struct pldmfw_priv *data,
>  		return err;
>  
>  	record_len = get_unaligned_le16(&__record->record_len);
> +	record->device_update_flags = get_unaligned_le32(&__record->device_update_flags);

This feels like a change that belongs in a separate patch? It looks like
its fixing an actual bug in missing data?

>  	record->package_data_len = get_unaligned_le16(&__record->package_data_len);
>  	record->version_len = __record->version_len;
>  	record->version_type = __record->version_type;
> @@ -540,7 +506,7 @@ static int pldm_verify_header_crc(struct pldmfw_priv *data)
>   * Loops through and clears all allocated memory associated with each
>   * allocated descriptor, record, and component.
>   */
> -static void pldmfw_free_priv(struct pldmfw_priv *data)
> +void pldmfw_free_priv(struct pldmfw_priv *data)
>  {
>  	struct pldmfw_component *component, *c_safe;
>  	struct pldmfw_record *record, *r_safe;
> @@ -566,7 +532,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
>  		kfree(record);
>  	}
>  }
> -
> +EXPORT_SYMBOL(pldmfw_free_priv);
>  /**
>   * pldm_parse_image - parse and extract details from PLDM image
>   * @data: pointer to private data
> @@ -581,7 +547,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
>   *
>   * Returns: zero on success, or a negative error code on failure.
>   */
> -static int pldm_parse_image(struct pldmfw_priv *data)
> +int pldm_parse_image(struct pldmfw_priv *data)
>  {
>  	int err;
>  
> @@ -602,6 +568,7 @@ static int pldm_parse_image(struct pldmfw_priv *data)
>  
>  	return pldm_verify_header_crc(data);
>  }
> +EXPORT_SYMBOL(pldm_parse_image);
>  
>  /* these are u32 so that we can store PCI_ANY_ID */
>  struct pldm_pci_record_id {

