Return-Path: <linux-kernel+bounces-399113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B681A9BFB2E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B6FB21CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894A8F40;
	Thu,  7 Nov 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzZNX6TB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE17746E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941830; cv=fail; b=LOyhePTnw+EbCgmB24FCoPS722b3SReZQtvGoi9pN3pT79u/0X3tDRoVKGX1uufwL2Qvf9FRiuB3qdFtUj4np5QjDWYKRSRZcT/iR7Ot/G3CMIbTRfodlN5NpNOsxHJxl2ZGmN8ZXrAi5bk/fjT6z7Dzve+SIOzXGG0khsM+dcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941830; c=relaxed/simple;
	bh=H96rwcSO8stNIHVtfr7IHvSRQIUi+dq1BadBhAsIUOc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UOxRXBaUCxIA3kUn83DqsyCmb3wftyXwRz29o19dH0Znv6gsOzjJNa06y6Dp0OqyQTg7fLjjAL9EoFeiE762pN9gsSp4+aGasaZZkamzYAarVpXI3MJ5NsdDpNAaSAT+SyVyF1I2Q31vdSbUFd/3BEEMSUbEHqMeMdFTxq9gjg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzZNX6TB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730941829; x=1762477829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H96rwcSO8stNIHVtfr7IHvSRQIUi+dq1BadBhAsIUOc=;
  b=VzZNX6TBo91awdqpJnOhAlhwemRCxqN/o3oT4un77SoaZKQvoaMjnq8s
   L2rr87Rl/jv7onVcwQ6qUxIoUBgAx4B4uPd0sXDv9nVCFKaGNPjtxHB+x
   gdsy7cdmPNn/3gSKPQexw4eBz9FVHpRzxqz08JwOQB2uhsRacEIgyXNT+
   USCZ0hGWRqzsfOT2mWe+Fyw6TyDgx0aKWKYhb76jU86qdemt9Z3WWMsah
   sOpreWjAI421OW8u0MKwH0Vfc/6oYSWzqOSs/qfxqZP8oK9D/Ww3VHE3s
   uEaEQA/5jemueLa2NLE5RUaDUtjKF6ripAz+WbXYDi3oNPMTqM2+WvO3H
   A==;
X-CSE-ConnectionGUID: EVajhZVYQTKrcNBEt6vZIQ==
X-CSE-MsgGUID: X02OUVhlQfiOm9SUraPJEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48229580"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48229580"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:10:28 -0800
X-CSE-ConnectionGUID: 2kwB3mRoRAmmI6ZwrErvcA==
X-CSE-MsgGUID: 0YHKq6sBQWir8jAthlD6pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="89702245"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2024 17:10:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 6 Nov 2024 17:10:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 6 Nov 2024 17:10:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 17:10:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gITBhjTlLp9oEegf+9mRSGSOxlu5xf1vpo2lT2DGgAqoJIaeCCssduEKN22+Ic25eWzRMGs3JyBYozxk3yNHcUExsTuF3jVV9K4qVMJlTiKUxOs/ypUUB8VzgjXjy8QI0z4ZfolWFEZh4+H3Yd7BVSxTMCIKH1f7Bk/1VyM1C8Up+qBX9AzB3L6GgxYEu58f9rBAbi9IbRZmiK3uhzcsvKWPdhhGAmSjoWxPBs7ZYGTO58dsIyYr9PU1agXuNIzU57YpSYAkAMZqWWqBoXuGZnyUyjVIVP4PatC9/Kp1MpJF+bgXIzfCxdlbS9pniuPfO6oYwVnB4/wj5zRIuckCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhXpzK60ALU/7ZgDctLmhBuqUXwALy6zKW3aoU81Kuw=;
 b=Lhx5diodhFH0wigz9wwuCBf06lyeo19Q1Viq4r96o4qMb/7sqbBEpz4x7kVDOZCFQzkS3+uFwJ3Xw7uzsx5YsDYzmbY9QhwSgWNz4rfVd4aoj2EV1xiX2Pg6161Q2lzIVsPCmjTel5CrTg8lTSCpRcrNn3+y6a3A+VNdZVCAYb+ddeofjiIM8N4NbFeP7H0/VIsIm8+/d75vyg5vjZn5Y/9xUuX5z5qcN33QGVFYxbuSC6MSs6DM/DgmCt73+95SBNvedSBUIKg302FO8SCdbQPw6gpd8mJlPOoTK2k5yhzKtkpJLB8y/65zxWs13SYjg6Q5+fRT0MNymlAh4EjorQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB7153.namprd11.prod.outlook.com (2603:10b6:a03:48d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 01:10:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 01:10:24 +0000
Message-ID: <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
Date: Wed, 6 Nov 2024 17:10:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC: <babu.moger@amd.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<eranian@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <nert.pinx@gmail.com>,
	<tan.shaopeng@fujitsu.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
	<x86@kernel.org>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241106154306.2721688-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0356.namprd04.prod.outlook.com
 (2603:10b6:303:8a::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: a0249124-e2d4-49a6-bf62-08dcfec8f596
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmdnUlBXdlh4T09PV0pMeGFuZEpFOVVIOWxBZlFoc2Q0S0g2Ymx6Y2xwL2Zp?=
 =?utf-8?B?Tmc0cXhGQ0JKQkpSdjJwMjZPTCtpZWdlSGlLRWpESXVDbGVKSU8yamhQMXdt?=
 =?utf-8?B?SnhNRmRWYXpaY0tpdWtmNXlmZE0vWGxLQUlQa1VpTWxRSVJsZk5Lc1hTcE9U?=
 =?utf-8?B?QitLT00zY0pBL3B0VjQ2dmRTdVBUUXBKazNYYUxGTjVkSHNsTCtsc3Y1QWxZ?=
 =?utf-8?B?bzJsdm9JYkpXUm9waUdhRXVaVjgwMTlZSkptK2R6cXhuS28xOXVENTMxT1lI?=
 =?utf-8?B?WDVvMkoxdnJRc2czMVVZcmx3OGdZL0ZubCt0K3lqL2hxZ0VWZzlxT3JOTjNZ?=
 =?utf-8?B?YWsyWXFPZThQN1JkSlJ4QUUxcXF3MURObVRuRkJpWVI3bUlKVjFWSTd1WHpL?=
 =?utf-8?B?d1lzNEVJOUsvVEN2a3BHcVF4UzloTVRON0gzNmIwR2ZwS00zZ2IrbTAycmxz?=
 =?utf-8?B?Y0w4VGZ3L0ZVd0paZUE1TGNhWmVpeTBRYlF0NEtGK1lVSEsrR3dIU2w1MDhw?=
 =?utf-8?B?OGlZTmdxQVZoU2xZTEI0ME4yV1lOZkVqN0xRa2h1alUrbkJkeTIvdWI0OFYw?=
 =?utf-8?B?QUhteE5pMFNNc2Y2RzNDa3B3VFNYbHlmQjN0WU5TTUYwajlML0p3RjB2MHlI?=
 =?utf-8?B?M0k5YUtEK1J6MGlFU0FSdWsxa29POHFpV0FaaWRrbkNhQ0V0UmRUSmwxMGMr?=
 =?utf-8?B?MnFRTk01U2lhZVdwRE1vc2FGTUxCb2k4ZkZzSGFOWkZvT1M2bmxuN2srT3Vq?=
 =?utf-8?B?dE1VNDdDVUpNcGxPTjFaRW1pYTd6bUlPRXVqeGV1RFBrMlphdmZUWm9BZUsv?=
 =?utf-8?B?WEVJTitQYjdvY2p1MVc4ZFBCYnRtVUtKMHgyNWpBWDFEQlF1VUdlNVEyQlVQ?=
 =?utf-8?B?R3dBUFlsNG5mU0NkNHhSZi9sTEdFM3pmRS9DeUt0N0RQSDcvQWZkS2VHOCtI?=
 =?utf-8?B?dk95KzZoSW9qWE9wR1p5TjN0Rlg0Wk4zSS8rUHFLeWRHcjN0RWNJb05GRndz?=
 =?utf-8?B?TjlBOTVsdGhZL3k3dDdhRkNRT2Z3YzlWb0tsM1MveEg2bnR5ZHZQSk9ZdjV3?=
 =?utf-8?B?MkdCWFgzRURaUGE2QVVtdmhBMDRnRitTMk5WdTBEODJFa3pBRW5zeWJubFd1?=
 =?utf-8?B?Y1Y2TER3Z1lLOWRNSG1kTlZMdlBrbWN6TlY4M3A0NHVJdDVJSmxXWWFSNkJi?=
 =?utf-8?B?TWZtblh0cWZpLzQ1WGdSM1o0Zm5DaGp5SzdmSDllNnRwS0JUU0svVHRxSGFk?=
 =?utf-8?B?MG5JeHo1YWtnVXlkZHFQS2ZQOXM4QjJkQklDQzdLMllkLzhQUU01TGlTNk01?=
 =?utf-8?B?Z25jSWxJNEZjQ0dRTU8yRTU4OGU0eTNaK1lNK252emUzY2FYWUlvL2J2SHJQ?=
 =?utf-8?B?ZUFCOEp3Tmk2QUhNVnJsNTZteVIxMVRRSDVnaDhnOVc4ekIxZ1NHL21qVEcw?=
 =?utf-8?B?azlyRGpWWG9TOHl3ZVA1Uk1Id2YyeEFSa0FNWUIwQTN5dUVrbEhtOVkwQ01Y?=
 =?utf-8?B?SHZiTE9DbGJIcXhtTUgrV0lSLzhCYWtuNTZYTWV6TjZ3V05BNXNLbzBnLzdm?=
 =?utf-8?B?Sm5WaUlaWFlWa3gzK09rMGdEZ1RoZVFUN0l4LzlCNTg5djF3OEViZE9ienBY?=
 =?utf-8?B?K0cyYSt4SVdFb1hXNGNHYklEdy90UVJETGRpR0hJNnREVUhxSHNkaFhBMlNy?=
 =?utf-8?B?YjJ3ZFgwVUhERUJFalU0NnhabTNwRTRoRGhaUnZhZTZXc2RYMFpKa1FJZVNx?=
 =?utf-8?Q?EUaxeUN1So2vfPasotlNKkowLTFknVkRfV1dEFe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0RnOVNPUlh0Ym5lNjdqODA4UTl0YklEL1c5L3pRSGx3a2RMdGpVNmpSTGpQ?=
 =?utf-8?B?MkJSUjYzLzJBSUtiUmFDaThUL3JpelArSDlDUnFXanBxeHdLb29sOVVpTXNY?=
 =?utf-8?B?VTdPTzFiRFFQZkZZT1NvaFlnZXNzUjhobXRVajFjV1RqZndNcnNra1ZxOTNN?=
 =?utf-8?B?eW9VWkl6UGJhckF4NWFEWFNESWVBRW1EWFk0d0VtU1VmaXJLY3JPdzdZNS9O?=
 =?utf-8?B?UHJDNUpqbndSd3JmRnczckkvVXRhOFFzeFpsdk1yelptQ3ZwMHBuT05vL09G?=
 =?utf-8?B?eEJsY1FWWmV6TnV1VEdmMFEwbE5iNlprQ1ZzbjkvVmNydVZmdWpkUWNwWDRa?=
 =?utf-8?B?N253OHRReUpVRVA5UVFmNXFjcHBQWEpDMVVkcHpyaUlzVDcwU0JwazdKZTRt?=
 =?utf-8?B?R2laM1hLL3JYRUlnYVA0Tm1WOXc0Zm5Vbk5hTThvaytiL2RzNjV6alhGU2RB?=
 =?utf-8?B?cCtEQWt3VVV5MHl2VjE2a1RzV29PK2M1eE1pQjc2MGZyVzEzSTFVZUJvTGFo?=
 =?utf-8?B?VUJMQldqMTIxc3N6czdxdDhud3JFR1BXUnVZVlM2SHc4NWoyQlpNYWpPRUVa?=
 =?utf-8?B?VWRzRklsNGVWL2V6YkxwVkhUSGNpZ1RGRDhUTGRXQU5YU0lIVUJSalI0QlAv?=
 =?utf-8?B?eGoxMVp4SEt5Nlc0T0ZtNTZ2MWxIQlhiMWFDVDc1bjJZcEkxRjhTUlVMMmVB?=
 =?utf-8?B?VzV1TzQyZzdHWE16RkQ2d1dxT2NIaS9vbG84TU1SOG1VNlA3RitHczNROUtw?=
 =?utf-8?B?dHNSZEFDZW5LeHkybm0zMXExbDl6cExJTjMrK09LTVdDci9QWkpBM2hiZWhj?=
 =?utf-8?B?WGViWnBiQVAzWk9PZ0ZRU1FsVjZoZFJ3Qk1MM3RjZTFwZDBvemU3cUJTVys2?=
 =?utf-8?B?ZE5Ybm1zZHNWc0t6Yi9kMHNpMC9EUGVZS1FFZVAyTDh3V1ZvL3l3SFBIWkZW?=
 =?utf-8?B?MEkzd2ZaV3JLRTFMTGI1V3VqcElsY29pSXJkdHJ6RmltZmFrcjBPandISytY?=
 =?utf-8?B?NVVNZ2x2TGF3cTBFT2dyMHZkQlVTV2dxUkVsb2x5bm0wcTh6SDZMRys0OWN4?=
 =?utf-8?B?OCs2NUp4K1VldEc0WmtlditwTzQxaDJNaHptUVhhRzN3N3RHUjl3cVJ1TzBi?=
 =?utf-8?B?Y1ZtbDlqbjRaOTFHejh4Mis1OFZRTlJsSUtsekdyR3hZUFBtVHhscmZ6MUl0?=
 =?utf-8?B?ZlBNalg2RW9CSW5MWFA0dnBOenhBK3Q2QWJNTGZRYTJiS0lMVm9vdlVwTFBh?=
 =?utf-8?B?UytQL3BZVnI4V001UTZPNVZXdG9wSDVJQmRFUWtoZHI3N01PRTNrWlJUblRm?=
 =?utf-8?B?amNhaTlpNDV2NGpvZnNoYURZUkNMOWRCcS9GMkc1MGMyQUx6T3BLRXpvdm1W?=
 =?utf-8?B?akJHOW5uQWtWY3oxSVdWc1d0em9GYitnNXI1WmJDcWVrSnIvNldveXZaM3RS?=
 =?utf-8?B?aHBGdkU0Rk42eUhNUUhSM3lxSHRZdUhLZytXVGlVNkVTYndZUmJadGZDczNR?=
 =?utf-8?B?cjlrQzhXWUFyajRHNk9uU2dCdzM1Rmo2Yno2Vk5ZeldVQmhWOUs3Tk5INDQ3?=
 =?utf-8?B?bC9Xck5jL0xFRnVwcWJiY095UlZQamZCM1o1UmliWG5NclhSR3B2K2tOWlAy?=
 =?utf-8?B?ZkdET21NcTlUODV1MVh3b3hLazg1K1ZDclQ2OVh1UTA3WDlaZGZHUjNlZ2dR?=
 =?utf-8?B?UkpsMElaamxVVTIzcVFhYThTUGJXV0Q5bjA1UXM0Uk50R0JjZDhJNG8wbTRv?=
 =?utf-8?B?VmN2QjdtUFZVVHZNSmFNRFcrWHpKd2lqdE56QWhyZVgybTMrRHJmVk9FT0Yz?=
 =?utf-8?B?SHo1U21RZ1hEbkZYSm9BZGVVb3pVS3crbndRQzFCRTVhUk40NUtMNWdsUGV1?=
 =?utf-8?B?bGtTaFBSZUdXMkU3N0lEOFpLVTZReU9rVXpLalMzMDZGNXVXSkY2ejBQaGZG?=
 =?utf-8?B?R2Vpai9NaTF0MVo4anR6dFdIWER3cklQSXh1TzhHWTVUbWtFRGZYdnMveGhu?=
 =?utf-8?B?Qld0bXB2bWFBbjBUMlhGVkhTNzJQUndqcjN3N2Q2M1FSSG9YZFArM1BVYis2?=
 =?utf-8?B?NHkxajREdHg5U0RNZzlpUlpFdkg3WSt5SjBrYThyaUE1V1lIWkFiaURBdjk4?=
 =?utf-8?B?M2huS2ZEWGd3clJ0Wmpvc0MrZElMZVNlOUtaUjF1cHRJV05nTGZsSUNwQVhp?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0249124-e2d4-49a6-bf62-08dcfec8f596
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 01:10:24.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHXFRA6aw8HojI9svbVhFoD6DSvap/8U+KzFbZkKQsnKAw1rUA0aBYNTjYirVjCRANzLIUEKLFF4OJuiWqE+9+z1WWNG6EZd/p+bVE79g9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7153
X-OriginatorOrg: intel.com

Hi Peter,

On 11/6/24 7:43 AM, Peter Newman wrote:
> Performance-conscious users may use threads bound to CPUs within a
> specific monitoring domain to ensure that all bandwidth counters can be
> read efficiently. The hardware counters are only accessible to CPUs
> within the domain, so requests from CPUs outside the domain are
> forwarded to a kernel worker or IPI handler, incurring a substantial
> performance penalty on each read.  Recently, this penalty was observed
> to be paid by local reads as well.
> 
> To support blocking implementations of resctrl_arch_rmid_read(),
> mon_event_read() switched to smp_call_on_cpu() in most cases to read
> event counters using a kernel worker thread. Unlike
> smp_call_function_any(), which optimizes to a local function call when
> the calling CPU is in the target cpumask, smp_call_on_cpu() queues the
> work unconditionally.
> 
> Introduce resctrl_arch_event_read_blocks() to allow the implementation
> to indicate whether reading a particular event counter blocks. Use this
> to limit the usage of smp_call_on_cpu() to only the counters where it is
> actually needed. This reverts to the previous behavior of always using
> smp_call_function_any() for all x86 implementations.
> 
> This is significant when supporting configurations such as a dual-socket
> AMD Zen2, with 32 L3 monitoring domains and 256 RMIDs. To read both MBM
> counters for all groups on all domains requires 32768 (32*256*2) counter
> reads. The resolution of global, per-group MBM data which can be
> provided is therefore sensitive to the cost of each counter read.
> Furthermore, redirecting this much work to IPI handlers or worker
> threads at a regular interval is disruptive to the present workload.
> 
> The test program fastcat, which was introduced in an earlier path, was
> used to simulate the impact of this change on an optimized event
> counter-reading procedure. The goal is to maximize the frequency at
> which MBM counters can be dumped, so the benchmark determines the cost
> of an additional global MBM counter sample.
> 
> The total number of cycles needed to read all local and total MBM

This optimization proposal aims to reduce the number of cycles used by
the code that is eventually called after user space reads from a file.
As you already noted, this causes a regression in this exact optimization area
in one out of the four scenarios tested.

As I understand this is understood to be a slow path and there are many things
that can impact the number of cycles such a query takes.

I wonder if we could perhaps instead change focus from shaving cycles (after
obtaining a mutex ... ) from a slow path to understand what the use case
is so that resctrl could perhaps obtain a better interface that supports the
use case better overall?

> counters for a large number of monitoring groups was collected using the
> perf tool. The average over 100 iterations is given, with a 1-second
> sleep between iterations to better represent the intended use case. The
> test was run bound to the CPUs of a single MBM domain, once targeting
> counters in the local domain and again for counters in a remote domain.

This sounds as though user space is essentially duplicating what the
MBM overflow handler currently does, which is to run a worker in each domain
to collect MBM data every second from every RMID for both MBM events.

* What are the requirements of this use case?
* Is there some benefit to user space in reading individual counters?
* Would it perhaps be acceptable to provide user space with a cached snapshot
  of all the MBM counters in a single query?

User space can use a single read to obtain values of an event for all RMIDs
on a domain without a single IPI if the architectural state from the overflow handler
is exposed. It could also be possible to present data from all domains in that single
read.

One complication I can think of is that data from the different domains may have
been collected up to a second apart. Is this something this use case can tolerate?


For example,
	# cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_00
	  <rdtgroup nameA> <MBM total count>
	  <rdtgroup nameB> <MBM total count>
	  ...

	# cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
	  <rdtgroup nameA> <MBM total count>
	  <rdtgroup nameB> <MBM total count>
	  ...

If the use case cannot tolerate data up to a second old then resctrl could add new files
in info/L3_MON that will take the mutex once and trigger a *single* IPI to a CPU
from each domain and read all events sequentially (which is essentially mbm_overflow()).

For example,
	# cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_00
	  <rdtgroup nameA> <MBM total count>
	  <rdtgroup nameB> <MBM total count>
	  ...

	# cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_01
	  <rdtgroup nameA> <MBM total count>
	  <rdtgroup nameB> <MBM total count>
	  ...

As I understand an interface like above would be an improvement over
what can be achieved by user space by optimizing queries to existing interface.

> 
> AMD EPYC 7B12 64-Core Processor (250 mon groups)
> 
> Local Domain:   5.72M -> 1.22M (-78.7%)
> Remote Domain:  5.89M -> 5.20M (-11.8%)
> 
> Intel(R) Xeon(R) Platinum 8173M CPU @ 2.00GHz (220 mon groups)
> 
> Local Domain:   3.37M -> 2.52M (-25.4%)
> Remote Domain:  5.16M -> 5.79M (+12.0%)

In my testing I see worse regression when I look at just kernel cycles.
remote domain before this patch : 17,793,035      cycles:k
remote domain after this patch:   28,131,703      cycles:k

> 
> The slowdown for remote domain reads on Intel is worrying, but since
> this change is effectively a revert to old behavior on x86, this
> shouldn't be anything new.

This does not sound right. It sounds as though you are saying
performance regressions from current behavior are acceptable as long
as the poor performance was encountered at some point before current
behavior?

It could perhaps be argued that performance regression on this slow
path are acceptable ... but doing so would contradict this work.

> Also note that the Remote Domain results and the baseline Local Domain
> results only measure cycles in the test program. Because all counter
> reading work was carried out in kernel worker threads or IPI handlers,
> the total system cost of the operation is greater.

This sounds like speculation. This can be measured with a small
change to your command line, for example, by using:
	perf stat -e cycles:u -e cycles:k ...

Reinette

