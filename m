Return-Path: <linux-kernel+bounces-564470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE82A655D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7C77A9D37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117E82459E3;
	Mon, 17 Mar 2025 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+Jpl9hc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCDC8EB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225748; cv=fail; b=JQcDZaSCpNFhQgn9sDJrKjv7B0mmGd0EvHdI5RjPeJQrd5hxlMln7psEEVKEnKFiuTKU1y6unZOzOZhWE6RBycRrkt6LLq8+25hpultDMyKGcpWY1SHuGCdd7TlrEPR8eMQDdiiHtM79MAezPcmEgNMGOZaEov5zAtK7f+KIMEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225748; c=relaxed/simple;
	bh=1i/e1PLs/0gR9ET0nMLEZ3KbaZYTRxbb0Jb0xo9nsE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pSpWNTZW7MyjuNXHjkQ2HCPsLwdUkeP345Pm94mRGrY/xm+hkcNbTumlwJT19b9pgk8mZM0GauIgbDoaTSrgqPIQVXmztW25bco5El89AOG1cYOOT+9u3i7cUBDwOCJTpDlzxf5yano7RzXjM9+zdzMmrxwWeFyrpWJ4QFXvNZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+Jpl9hc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742225746; x=1773761746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1i/e1PLs/0gR9ET0nMLEZ3KbaZYTRxbb0Jb0xo9nsE0=;
  b=l+Jpl9hcW/JPYXDFXrA5VHfVWR7DMXFrGdsC0LPzSRKYhm24VSNaBPRf
   Wv5hatnllOoJALRJLrP+VCxk9ZS5DOAra9woGvHaImdru26M0q2u3MIDT
   BS4tYvuBDYo0MicXTnvMGnild/o1g3hymXxUpHK57G3SX5dl5q+Mv6WF2
   +DwYyXDVlk5Js9K70fgcSjW2GNbcYuDDBOth+ovBw1DFbT/+H+QOuRBQ3
   RP0y+1bJMjslyLoz57MTDaF9xOdc04v4+pM//Li9w26dNBM9OzcMKcflI
   /7mZehzzpz1mni18ZVn3C83ijllVU0njaRiG3ehoFOHEVBtENBbt0qx5q
   Q==;
X-CSE-ConnectionGUID: GFu8K4s3R5W6sMZykaPYtQ==
X-CSE-MsgGUID: mWfmX0VxQxaZXmvLuT4ZJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="46973013"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="46973013"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:35:32 -0700
X-CSE-ConnectionGUID: UbOf1HdnRBS9uLhariy5nA==
X-CSE-MsgGUID: ETfRdVg/Td+bYmXeKz3pPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="159117756"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 08:35:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 08:35:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 08:35:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 08:35:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcmsN6ALJkvsLeFwSenomlUXJrODV3WxMpP8xQBTV+8PJFXQ9ElJch+AToiCKnYum5b0GAbMAQYHy21+XK9NXyIHxQj4VmvkmZSAHx7agngQUPJLTTPAHcs/+0WGMflGGV1cHJoMb7MUxKf58Hs5DMrwlKXBBIBaRDJtA33QpoVLUKN90xgMOji1Z1yDug50yArT2P0hUGlu/PVa/ploEiAK7ux9KV3zF40QVm/8XM4GuozDF+XJlt0lkKqI5YFkgqCiq8BShoyTMWST6HZyBBLHTuSXedXEL9tIHxM/i3yDXpKQiYqMvrMr8XYEFoL68wUUfn345+XUDBSo9s9g2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kisf+9fImEWiAvQPKB97pnKWgx2DVDfQAmOj3fgDAWU=;
 b=DA5PUySdoukiZl+aQ3JK19AxZjnT3de9ExIGKDkh3xd2gKwW51mUVDn6TbJS5yaIBcreVJGWLXGpGNH00UefpM6pyUr7ksPfJN9HIJ25sW9zGwskzp4iAtnBcm2XBombGu/0D6bbN0w57LDWinJNknOvLEXWJ28HnM6lFzmwnznfIIsukUdpjTLlrzpHqnPYNmuqHUs/SrYtFu4Q/m0cHJ292Y9ruG93vGXtov2iL5mceFvbd0zQbSWOsnbW3x/sC0lNp/91KHQZWZgpgzQ/Jh8423G32svRNvkeTVbaJ0wqV3SUiU127nZx6QO6x/s/w8sO5UcHQ68LIL7iImPRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:35:29 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 15:35:29 +0000
Message-ID: <bc4a1940-9932-4d96-aac6-4dd11169c4a3@intel.com>
Date: Mon, 17 Mar 2025 16:35:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:x86/asm 3/7] lib/test_bitmap.c:1269:2: error: call to
 '__compiletime_assert_279' declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(res)
To: Uros Bizjak <ubizjak@gmail.com>
CC: kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
References: <202503161004.ZmMcxxeB-lkp@intel.com>
 <CAFULd4ZX5NvpmvrtSQzz=iBQ20AGZqR2PSMZP4p7PrzE4qNJyA@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <CAFULd4ZX5NvpmvrtSQzz=iBQ20AGZqR2PSMZP4p7PrzE4qNJyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 90dc1a71-d52b-4fe3-49c8-08dd656958a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0NtWnZMZDhwTUdwRWpyQUg5WUIwb0I5MmxUMGlEQ3hlNVJuTEhyN0plOFZI?=
 =?utf-8?B?NVg0YjI2ZHJsTTNtcXk4SzdMRk5SY0d0U2R1Snd2cExhSkx2azFpWHRDblMy?=
 =?utf-8?B?NWt6VFZXb0FqMFNhRFE4Y3VnaVB1UTBnMjVNSnNYZE9TUDZXWktVQ2xZTjEy?=
 =?utf-8?B?bmZyR2xkVG4vMHc3Mk51a0xQbUNWN2RQNEhxUEZzclhQVHFjZm4zczZ3SEtj?=
 =?utf-8?B?dWZ3QXhPQWc4QzR3OXpLb2l6L0dQQVV2SGc0eGt1V004Tkp4NEZKZlhJbUFX?=
 =?utf-8?B?MGV2a2YzWWpMbDBnbDFhSW4vTFQ5R0tkRHlnajNzNzdYUFJSdG84ajdJZXhH?=
 =?utf-8?B?bmhjU3ErYW13OFA0eFRqYTArOVdHczQ1dENNV24rRGtRUCtqaDYxMlh0MGdm?=
 =?utf-8?B?TGlqZ3dkQ2xIT044OERVTlRYSmdwUjJqUGdOQnlRcksxdERxK0ZLV2J1L0hI?=
 =?utf-8?B?ZkhMRWQxZ1FvOXF4UUw3aHBmYmg1QlFpLzdGUk1kNkFoeXhkcGd3SENDTEor?=
 =?utf-8?B?R1RDU2c1WnNZSDRVbURreDBtNU00KzdoYTNjbktRMHJ5VzZ3c1lMOHoyN3dt?=
 =?utf-8?B?bXp2YXMxcnlaamxHeUQzOEdKenFtSUpxQlduVVVNVHNTRzgyekZGMnZ1bjM0?=
 =?utf-8?B?RzdxQlNVTkt1Q01UMlgyWGR0aktGcFRWOGVtbjVpMW5zcEZCQWdSSE1uTkJU?=
 =?utf-8?B?dWJhVDJHN2M0U1RFNmRZSG1qRG1uWWM2V1laQXN2bk1KNm9zMHBHVHlqLys1?=
 =?utf-8?B?dGVJL1FZMmh4MFlZMFJNNjloUkJCSWVVODJSZlF0Ni9ZQ0JKZ2JZRnM5N09k?=
 =?utf-8?B?RHFuUm5PbENzOFVRTDRrL2RxTGRaczZsU0tXa1ZaWVhGbnBEL2JLTHhQdVNz?=
 =?utf-8?B?QmY5RC9KY2x3anZBbkFwc0dmK2RWMzNkQTBmNXFCc21sTXlhMmJiaGhnTitE?=
 =?utf-8?B?NmJoUUM0eTBRWkZwT0Z3azRXeDlCWnMvcXJmaGhlODh6MmpQd0pVdWpCSzhH?=
 =?utf-8?B?b2I1bXlVaElLTTRNcjdNaHZxYVNlQ3ZOYjR0U0JaR2drcDVOOC9TN2ZlVXZI?=
 =?utf-8?B?QnFQQUQ2a202UHZNb3M5WUdUY0ZGRHhpejd0VFR5RUdqZDg3N1RVZXVMa01H?=
 =?utf-8?B?Unh3YmxzY0NseEF5a1NLSmFtdnVYNElia1ZMZ09vVXNPa2Qrcnhrb3NqSTBh?=
 =?utf-8?B?S3A2cC9JZS8xS2xNUzM1Kzk5MGcxUWhncnFMbXZSUFY0U0x6Q203ZFdSVjJE?=
 =?utf-8?B?WlJyenI3MC9RcklqMjRycm1Od1EyOEhhbzVleHNxcG91UlZIUG95SjZwU3NS?=
 =?utf-8?B?L05DTncrQ0xZdytaRU9uL3ZEdElraW1GQmdYdVlnNGs0R0RldUdCQ25hYjBs?=
 =?utf-8?B?ZXFnbnM5UGhTcUVxK1YvaElSTHorcUc5SGxoaktrNUJEWkExb2gyWnF3QTFy?=
 =?utf-8?B?bHN5R0pMZTNlOE9KcldVRG4rVTNBQnV1bVVUZm5kdTlFUzdtZnQ4TjhXRmVI?=
 =?utf-8?B?UEZVNmtJbVhRb0tidnVXR1NucFBPcVlObzduck8reWYxNm4rT1p3TStNdGFi?=
 =?utf-8?B?cmIzUGJ2bHRHLzF5ZDYydmtVSUVVc0paL1Rtb2NRMHdLd3gzVDNESG1hRlNM?=
 =?utf-8?B?Nm5FTWpDczlkdnRyWjRjR0I3anFQVCtTUi94bjJXUXpoL1djUXJ6dXRGRlVh?=
 =?utf-8?B?eTFKeEVMck5lRWhrb2hJMlZ5QnF0a09HSCszQVUyODVha3BUVlY4TGdzSnli?=
 =?utf-8?B?NFhySkRrWFFDbnBQQVlPTjdBeWVCdDM1ZWlSNkkrTzdseXVyL2lpOTFJZUdC?=
 =?utf-8?B?U3JzajBscUwvV3A3bWlaQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmpMS0h4NnZub3dRZjUyUStpQ3EyR004bzM3dXc1VXhQMllUc0dQQU1TQmRL?=
 =?utf-8?B?NVIzYUFkSVg2czF5cW9xY1dybjlpVmo2RG1jdHN4YUk5S2l5REsraS85TlZ6?=
 =?utf-8?B?NEhramQ0YzlxRk16UHU4Vm03a3daUkNuU1pJV3lJeFowVjFUcmE2bW51bnFi?=
 =?utf-8?B?bnZCbXVuYStiRHJYa3VUdE04aC9QZTJGOTlLN0RHeEVqeExkWnhjWis1UkNT?=
 =?utf-8?B?YWI3M3poUHdXcEs4V0xKV1dLYVlvTmp3dmVTMlhsNEdXNVJsUnUxOC9wREJ4?=
 =?utf-8?B?a203U2tpb3hWa1FzZzVpdU4vTlBoT0Z0ZGM0RWFGQUU2Tk11U1BYRWdiNnFX?=
 =?utf-8?B?ajlscGNsRExHTlJoSmd1bmVyTDNnNjJhNVRlaWtENkRlQVp4aDZMWCtQd3Bp?=
 =?utf-8?B?YTZ5M0t5bWYvN0tLb3lKaWVoVGdIbzdYZ1Q1d1l1UGczZnBjdWZIVjNzMWJj?=
 =?utf-8?B?aDVkZHlQQisrM0NsekJGRGZCSVNRSERURjFNR2wvcDdGNiswaEUxT015b3BK?=
 =?utf-8?B?SjZTQ3RVVVo2dkxnMmVQQThWNndPY2NvV1g2RzdMU1g0ajNpTHN5T3Y1QkIv?=
 =?utf-8?B?NktkLzJVLytDU1IvTi9laFFySnNvVzBaZTRwYzdBdThFa3N5Z3V2RGNkd3NO?=
 =?utf-8?B?czJRUTh3Sm9ISGFXbHAvYk1FZ2VzZHRmTWIrQWRxRUd5SUFEb0hla3owN3dm?=
 =?utf-8?B?ZnFnVDVaa0IzTEMzdjlMRGJkc2Y0ckszYU5TZ3Azci8yRjYzSHRVRy9aaEZL?=
 =?utf-8?B?WUUxVGxQcFdtOHAvTzY5c1k2cTFyakR0VzlKQWkrVmJ1S25hbUtEQitQaXFo?=
 =?utf-8?B?WG9FUW9nU1pQL2NpcXl3WGZBUWVIampVQ1JuR2NHNEdScTAza2hyZ256eXhj?=
 =?utf-8?B?YjRLRUFad2lTekhIRDR3ZndQS3l2TWxhM0hGNnp1VXVnS0o1MXdmdUJTWlVE?=
 =?utf-8?B?NUNwdm5rbkU2Wk1PWVRaRzExaTRFNW1MeDhiSWVDbHB3MC8wd2dPbXVpYWFz?=
 =?utf-8?B?TkVtdERoU3pIZDVNL0UrNmJkVGRmYTFmNDNtTkgrU2UwWVpQVUpXK3laaUwy?=
 =?utf-8?B?SkdqZnBGR0xEQXVhVDVIN3hjU3ZGcklvVWhGNENjMVFmamZqWFRZbHFzY29N?=
 =?utf-8?B?b29nVWV4Y1VITVlWWk1BaXJTallpTjBUTmdmWFdpYWpXQVVGa2VkM0R2UFhK?=
 =?utf-8?B?R1Q5Mzl4bVYvdG9TUFZ4TGxSOENyU1dZejJUZmpkeDZpMWJUNmg2cnVjSzFw?=
 =?utf-8?B?NFMrMGE0enV4NU5yQ1BoQUpSZmpRVW5YMU1WL3JKT2swalZFYzBrZmJ2ZmxG?=
 =?utf-8?B?VGUvTXowd0NGVHRmS1NpVHI2VVBiSkVSNnk1c0JPUDlGbVJYcnNRMHFIY04v?=
 =?utf-8?B?RkdqMCs3VlRNZUpQeEQyakN5SXUxemlsd3dld2k3VytPSUQzMnJjL2FmUktO?=
 =?utf-8?B?OWl6cHY5RjNuQm5PcVNES0VHVXEwTmVsWGRoV2lndmlMYjh3ZEcrbGxkTnpi?=
 =?utf-8?B?TzUvVFN4dDZEbVFWNEtKWkUySm1DNklaeGFEMlVPVnZqSU9QS0RrK1NrZXdN?=
 =?utf-8?B?Zko1VmRGODVzUjB3bFlKckRXK2ZDazFSU3psOGdBZThFLzVaY0lPQXFFY2M3?=
 =?utf-8?B?dUdHeHF2WjhUWE5wbXRqVEdYdUZJczJmN0FRMUpnYzAyTWY3R2tkRnFQMzRt?=
 =?utf-8?B?aUFPNU5ORmJFZ0MrZ3phRVpybUN6Tk5CMjJ1TlhLSUJaNVRKcHY2bEZSdEh3?=
 =?utf-8?B?OVArdVFMQXR0QjdJbXVCeXVmQkhvaTF2bGF5OFE0dW5mMW92VFd4eS9vRXhU?=
 =?utf-8?B?QXB1YkR1NTk4bnVmMDhqWDNVekw4SjRSU2VxRjBKdVNTR0l1QzhXZ2JtOVE2?=
 =?utf-8?B?L1gzeUd4eHFmV3RpdjlaQ09zSksvT01uZEFiVTFYb0gwOHVPRTdSU2w3RldX?=
 =?utf-8?B?dm1kNk9lQ0NUWjRLV0NuQU9rbEtFY240dGpOVVZyR2g1OUJHemxNbnVUSEFJ?=
 =?utf-8?B?MGhJQndLT2NQWEYrdjdVRVBQTkVCYWtZUU83SnhKdHBFcjg0dlp5M3dnM3Qv?=
 =?utf-8?B?S3NTT05rWXFTZDEvQjNSSDZIV0owb1gyU1pqVy9sakRBYWYvUUo1SkhhbFZF?=
 =?utf-8?B?NFExcklFZzUvTGN6N1F0dWhjMUpOT1FIejFQeEJKL2JrY1NkanVYNUlXTHVD?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90dc1a71-d52b-4fe3-49c8-08dd656958a5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:35:29.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6dY4I60FKtCLIBEAMuVXiebun2WiEh4/yLm931D90n7+Z1UUIR8e5oMqL+q12N1YbuBVkOamYfuRUrg8uqo4VdQG9hguUJ0wQg3UnqyicE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com

From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 16 Mar 2025 09:28:51 +0100

> On Sun, Mar 16, 2025 at 3:52 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
>> head:   9628d19e91f1ef9e7b1321e74a88bfa646d2a8d3
>> commit: 01ba23bf1b3f9a4035faedc2aa450e251bcc2c7c [3/7] x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()
>> config: x86_64-buildonly-randconfig-003-20250316 (https://download.01.org/0day-ci/archive/20250316/202503161004.ZmMcxxeB-lkp@intel.com/config)
>> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
>> rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250316/202503161004.ZmMcxxeB-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202503161004.ZmMcxxeB-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> lib/test_bitmap.c:1269:2: error: call to '__compiletime_assert_279' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
>>     1269 |         BUILD_BUG_ON(!__builtin_constant_p(res));
> 
> I fail to see how the referred patch can cause an error in:
> 
> /* !(BIT(31) & BIT(18)) == 1 */
> res = !test_bit(18, &bitopvar);
> BUILD_BUG_ON(!__builtin_constant_p(res));
> BUILD_BUG_ON(!res);

Kbuild bot sometimes fails on randconfigs and random commits blaming
these commits even though they're unrelated.
Esp this function, I dunno why, but time to time on different arches
(um is the winner here) it fails to expand obvious stuff. This for sure
depends on debug stuff configuration, let's say in the attached config I
see KASAN enabled, but not always and it's unclear how to catch and
reproduce stuff (and then how to fix) reliably.

Re Clang and KASAN, there's this in lib/Makefile:

obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
# FIXME: Clang breaks test_bitmap_const_eval when KASAN and GCOV are enabled
GCOV_PROFILE_test_bitmap.o := n
endif

This was added a while ago not by me as I'm no instrumentation expert
and have no idea about those GCOV_PROFILE etc. Does 19.1.7 want more
than that to evaluate obvious things?

> 
> Otherwise, the patch fixes a correctness issue, so there is nothing to
> do with the patch anyway.
> 
> Uros.

Thanks,
Olek

