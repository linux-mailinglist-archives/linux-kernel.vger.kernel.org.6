Return-Path: <linux-kernel+bounces-522714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67DBA3CDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE4E3AA3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540D25EF86;
	Wed, 19 Feb 2025 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwYdsVjo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFB25D539
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008361; cv=fail; b=TDCgCGbkMNKYgYgIazTDu5/6YyNoKhUIxPj6Zwaj+5pif7CvbyzldLdNIFpke73uy4qBfFqWyw/UNd9WZfpHVVRp1RCh4CaKTBnstx8id0nOjeJgkuEgMitRvkuu2hlrTpdewPvHCVQ977xF/hBYUMQSF1rrSpZKrZ4VHxvDik0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008361; c=relaxed/simple;
	bh=yHUR959Davigjdd2/Obnj+KREphKI8f+mb0rcyon1Aw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bxgZvJsyaAK/i+6Me/Ud4bcYQuMiIDyb/oP9tjT0w19VIncliF0iiKUtgBlB/wafVPFQU4ahD2ZR2ekPmxHJJk19Y9eYnUcne+3+ruA+J/hQsN5488sggFZT8Rc0+cS01KhbxFC3tqFPXvqKTPdLmbu+RyyaP5P1R/nWezVtZDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwYdsVjo; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740008360; x=1771544360;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yHUR959Davigjdd2/Obnj+KREphKI8f+mb0rcyon1Aw=;
  b=GwYdsVjolmxIbVweFHKkIjdOB7PRdB4h6utqT613pn1xBvqmIUiT96Ze
   QUMa8RtZyvHLhdsj1OD28xkXUrZPMt3dzJYJjSGY0Krk1amVM+Wf/Fc0U
   fJPJJCsG8vlcvr3JUXPQp8CmZo1wzCSWH8eWwcny0DJnxBiOiUe3NPbOp
   gWIYT86BNyxhrjkWHyQG9mn1nNd+udKGMte0Q5FN7SnCRNz5e6L7TrpUL
   xYOIkIBN5W8gpXAWHoSFlFWVlyAM0HWsO0ZlZsQhmubouM9h4XflydDiS
   s+Dk8izUYNu8jcIVBOnHGKdLq7PpmkBw06uSsuF2u6oJ1k7GGLrR8SBLs
   A==;
X-CSE-ConnectionGUID: zzT0i7yJT+mZsIgKr4w7QA==
X-CSE-MsgGUID: kbfnTz1dTdaUel7VIHQkTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43599205"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="43599205"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:39:19 -0800
X-CSE-ConnectionGUID: FogFiSVuRF6El7YYoiKsCg==
X-CSE-MsgGUID: 42PVBWWJT3mSR0VJKl1gXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115345418"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:39:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 15:39:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:39:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:39:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7psuspMT+cdH3P/l1tKGXATDUwTpwaK21ZLQrZianpW8BRaSNSGRwz8+0Vg7+IDPXt2FGNxAZuAqBwWkr0P1u5fchtacRqUEZGdcGeUu3ZyldCduAa5FRXYkoMrwjm0oPmaWWThnFBFUJ66XjSRBILU8Vg8oB2v9XUS/NudOXtlIt+bk1OmkhdsL1dCYb5Ao3s5TDl287fQfGX4dRnOOwWprNA/ld4k3tK2Dx3+Sdcv2IGiFJ//55f/TdeoUwt0BtF5RCxHORVRtK+aRsvP+QYxpYTo40dC9iXnVFkhgYXNj3Laf9isOvOlbfP8UxK5VID/a+VBubfZ3ymHzfN+Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2UoLt381tIZNdqHPrbGbrijPAJyNo1MZsW8nsVBwr4=;
 b=vSw3DMj5UFVMSbfBYHOcsaqoJitIDxaf3OB6hPvwW9pMR+hnsry3XY/Ag+15yu+RW4I7wjMn8HEE9ntgqpCSk8hwXVLOIM1LVN0n8AAsrA8mcMAi6bVNMjdhSzevdU5GrqHOpUNxVNva8AstnrV3wSGemYBVmi5To48BDavb6Ld1t/PRwnKTFHgmD84EpEn2cO0CTLnPZe3EYHPBr6shZao164xFcgU2mpjQ89jsHuewPKofpwPXwiw2KSa76x+hpCSnnorva6y3S0/zqQz5tz2XQWmY+FGvYb6M8v+apOFo+AV0kUsBakqBgQDOa/hszCHc6psjk0YEUqkLgyd86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7350.namprd11.prod.outlook.com (2603:10b6:8:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 23:38:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:38:47 +0000
Message-ID: <d5e4eefb-d2c0-48f6-891b-ffd5200fc9d6@intel.com>
Date: Wed, 19 Feb 2025 15:38:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/42] x86/resctrl: Move monitor exit work to a resctrl
 exit call
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-16-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dffab95-13b0-4540-c118-08dd513e8e07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3N5ZzN1NURHMTdnYUdWbHRQN2ljVkJDQ2kzY1VZaFVYVFF3THNLVG13ZzRq?=
 =?utf-8?B?a1A4Z1hmdFl1WmMwQUtiVWFabWI4RGUyOWlPRGVJZWtBb1FiWnFYSXRDZlgz?=
 =?utf-8?B?TUozRkJvc3cxWVltYTBYK3dwMk9NbURtVHFoYkRWMjBLM1paRlhYOHl6cmFt?=
 =?utf-8?B?ZmgxdWpyWjZNYXpKdHZmWXVhZzBlTmFEZ3pNcDk2bTNUaXE5TlJ0MUNvZHRO?=
 =?utf-8?B?TzFQRTdRNjlaenVsakc0QmQzeXI0R0J5MVpDWTdidEtqbEhoR1VxcUYvaDBv?=
 =?utf-8?B?TlcwYWtOYnE1dG5NOSthYVJpZEppait3REVScXpqNWxqQm1GQXdlNUl5cml6?=
 =?utf-8?B?Nmo2cW4xYnZkNjVWN1RZKzFZUktpMEM3OXpWVHp0d2lyZHNwNlU2a1hXdWE3?=
 =?utf-8?B?R2N0cDdFaGFGbElyeXp6MHFwdGh1aEZQR3hTc002VlF1OHQ0dGVTLzFEUVNt?=
 =?utf-8?B?MDhLRlJCZmlYcWgvYlRDcThTTjVLSWRIemVqWTFHOHlLOFJsSWtvSlo1SHJE?=
 =?utf-8?B?blU2S1VoWDJpVi9uMDhHYThwTEhINk95cFBnNjRMb2dMMG1ETkdSenZ0aEM0?=
 =?utf-8?B?Ry9zZkR6Uzc4YStJRjRId3lwTXdEMUlqemlsVjg5UmdDdkppNi9kOWhFM05s?=
 =?utf-8?B?L3Vpc1M5NVZiU0xReWV0cm14MzdxT3piajQxckk3V2x1ZmU0ekVnNjBaYUhm?=
 =?utf-8?B?Qk9SOWNHQUtyQzhoczRrRTg1Um5aeVhENEFyaVF3WnNWZVJqSjR4ZDBHRzNq?=
 =?utf-8?B?N2RudU1vSGh5cmFCTXBoT2syVytvY2NCZ0Y3QkNXNUE5aWFVUDNrenlXbCtF?=
 =?utf-8?B?VlFpS3hwRXlDd0gzRTdVS290OUZud1pBZWFPT2YwbWJTbWR2OWc2MFltcG9T?=
 =?utf-8?B?SFFnUlBMSEY1d2VGN3dJY1IvaGpNb1A5YmhIc0xla3ZaZldBYzBsQnFpL1Vj?=
 =?utf-8?B?OFcvdzFBbWJNNjZRSW42aXFYb2QxUDkzM3ZmVUZhN09HZEp2NHozRmRVNzJs?=
 =?utf-8?B?aUZxMFhUVUhVMzNFMmJnTGlhRXJWbXlsNTlKWEpzdi8zd1Y4bTNZMjhmNHRN?=
 =?utf-8?B?aGpkYVZyL3k2NHM2U2w4RngxS3lhSUxneUNDU2N2ZmxIR0pUZ05PbVN4SXRJ?=
 =?utf-8?B?N2VndndkemRhSzVidDdDOVVCVTdsRFJKeThZa2JNZ1NEeEllWCtBRkpnN24w?=
 =?utf-8?B?T2poYU54RmttelB5QVIzakduQzNXNmp4enRkeWtHaS93NWhNRTNtM04xaWUz?=
 =?utf-8?B?bmFJSVE2VzJjWmpEdVdXM0J0R0F6dTRLSmJrclJ0V1JnT053bDRaK1JoQjRk?=
 =?utf-8?B?Z2V3ZXBlaDBqSU95WldWNFo4TURxS3hURXFTajhwYUZVbXczVXIvc2pTT24z?=
 =?utf-8?B?THlFNU1YUVNtTDJWTm5lcUE1Y0theThLN2RqOGlLdEtISDArUmltMTl3dnBB?=
 =?utf-8?B?NGQ0bDFucW9xa0szNjcyVWMyL2VKdjN6S0xuYWJlWTZJTGpvNFJ0THNCRFRL?=
 =?utf-8?B?eUYwU2FFNjlqTGs0NGJFbjlsS2xXRXM2M1ovUWhieXRnUzBBVXoyc1R6YlBm?=
 =?utf-8?B?SnFaeTNGZ1RDMEtienRyRmRHd1JCL09qMTZydnJsRnhpeHRYS3g4UmxWQ2Z5?=
 =?utf-8?B?K3l5MnNnc05McHFEOHdGMU5ZNXVselhXQldhZzVRM2JMMm1zbnN0MXhFdExO?=
 =?utf-8?B?RURzM254OVYzT0lvTjR1MVowYWhyRU91UjRsdkQzY2xBYnk2aVhnelJ3Y2lP?=
 =?utf-8?B?N3VUSkt0bTRUUjNjQk83cGRTWVNSckxNQ0tTUEd2TEhXdUphQU5tTUIvNmdN?=
 =?utf-8?B?VXV4dVR2eHc0VE5xQU5GUzk5LzcxaEYwVHhGT2hTcW14NVB6YWhJRXV3ZXdR?=
 =?utf-8?Q?L84qCldTxlCAy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9QYms4UHdzaUNRaWhIV2oxUTJMT2ppei8rQ1A4NVd2UGRCNFB3MjEzNDMv?=
 =?utf-8?B?RDBWQ25ibEVQM3owNTlkTWRHRHlzaThTbjZveDZMQ0hxNW03ZGxLWUphaXRl?=
 =?utf-8?B?SGdaL0s5dzJTR2llalJGZDZHYnE5MW5naGRIUHhiR2tBSHJOMFB2eTZuYkxq?=
 =?utf-8?B?RXp1blpNS2FBanlWMGxkZzROQ2pSTzNRckxUUjJvU1pRUHowRjJTN3hBN2s4?=
 =?utf-8?B?OXVOUXlpZ3I3QS8zSElaNXdhQ3M2dmJ4cmsvWWR5TVVxc0tPVWlBVmkzdUNX?=
 =?utf-8?B?U2ZjTVRpUldFd1E2QWU5aXF0TmZsb0VCeTB5YTl1ZmZKNFpmV2VIRk9uaUhS?=
 =?utf-8?B?cE5xNmNoVi9rckVPbjU3eXFUcWRjUktsSXBudHB4SHNZZUk2YlFERFczOG10?=
 =?utf-8?B?aG9Zb2JqdzFKclJ3S2FKUHZxanF5Nm1aVTQvYU9lSm94N1hGRmhZQ0tuTWpj?=
 =?utf-8?B?VU1UVjQwTkJ6TnBIQzlWcjl3K1lQQkJxR2xNc1lqMVc0ejZWVDFvYzVTenN1?=
 =?utf-8?B?dE9QY0RFUEhXNk9SSEdTeTFxNVM2ckVnS2tEaDk5bU5EUjcvMzh5VXlXT2Vp?=
 =?utf-8?B?VkZ0V0d5V1VvaFprSzEvQkdRTFY0L21lZzlFVENzTFBCbFM5eDI1ZEdvZzNW?=
 =?utf-8?B?ZHc0SkE4ZENXdGdNaWtVZzI1ZkE5YXc0MCtjRkoyTTNTVFMxNHNyT1daSER2?=
 =?utf-8?B?ODFDSnNTa1BqSlVabkk4QVN5a1ppU09GWGptOFdxamJqSmpnc1VQeEFvbHpR?=
 =?utf-8?B?STNBT2V5YTZSMDZ1UzJ5dldaR1BhY2EraDE4bVV0T3dlZkdqUWM5Zy9yZjl1?=
 =?utf-8?B?L0pJYytSMDUvbTBibFpDSFNCSDc4Z3NJVk5BVGovTDFHK1dHVXFGZFNGWWlW?=
 =?utf-8?B?V0RNNURrNExDNkdJQjJ4RnhVWTE0bUtXMi8va1plR3FTS1d0d2thZkJiaHdB?=
 =?utf-8?B?VFZRUEJqUkFxS2ZPMFAwcy91U2NpUGNETm56dStjVEtGUndnK2ZUR0doVCtp?=
 =?utf-8?B?NXhrbEcwdi9lT2l3TnVXWDU4b2xLTzV6SXdheCs5aHZxd081RzRSNGV2dTVN?=
 =?utf-8?B?S21EUFNOcTFWbU8zVE54Mi85MXcwbzNxK3l2dGo2RzdCTURyU0tvWDIyT2RD?=
 =?utf-8?B?ZndpRkNBTy9SR3ZqK3hpcFpNNUtUaUFqMFVSbGZHSjJsRFhKYmZUR0RqUm1r?=
 =?utf-8?B?TS9tZEpRYXlEQUlqTVY3WFYxNTB2c0tERTAwdnBid1RLRW5oajg3dEgvclJD?=
 =?utf-8?B?aVpUeG1HcXYxUHZEQWcwdlhpS1F6aWQ3S2JickMzTjBKRVowc1Nia05Ra0hE?=
 =?utf-8?B?RDUxRG01eU92WFVvc0lKeitvODdpN1g2OVYxa0hqZ0huK2NnVUdoaVl5Lys4?=
 =?utf-8?B?cXZXSHFDVFJQSDRqN0NYekpvT2ptOG82MXFDMWFtM29lL25QazNsMTlZellu?=
 =?utf-8?B?UzhQaXJPUGhBbzh2UEMyNnRxODJZek42VGhFSGJtZEQydzVnRGFYRFZsSHpY?=
 =?utf-8?B?Qkk4S013Nnp5b080cjhoRWlWU0RsdGxIY2lpcmR5U0R1a1FQaDBYSkNiMlpU?=
 =?utf-8?B?WVNqOXhzTU9WV00zMWNVSW90MUhPOWwrUWFzNGdwTGRybjN3eEdvWnFjSm5v?=
 =?utf-8?B?STlLa1ZmSmRoSmwzekFmT1ExTFpCUFFITTR2dmJvVTdSSWV6Q3VyaW53VXcy?=
 =?utf-8?B?R09wdWtxZGFHaC9uU2V5V1JhRUtoZmhmZ3QxVC9JMWZKUUNFMVN5VHU2WmNX?=
 =?utf-8?B?OEl6UDIzamtBV0hLR3ZBMUNIbXNhL0NDZUJ6akExaHRFeVBXdjlKbk5UUlBZ?=
 =?utf-8?B?MGk2ZnhuSUNkWTJkM3RNYXUwN1FTbDFFcjA1a1c1VURnVlRhaWYyTXhsSlpB?=
 =?utf-8?B?TG83M3hUeHNyc25LNDlpZ1UvU1R1QktGOFRBenRpakdmMFp6Vlk2KzNONnV3?=
 =?utf-8?B?VFZLb2l3TU1TQmxIYUtFbEhZMm9xbUtFdG1QZ00rQWZBUlFyRytLYVJLc05I?=
 =?utf-8?B?ZDJrODh2Z1pnR2o0Q0ZudGNCbzc0YXlyK2tuNEhNWWZMVHhiK2cxUjFJdFJ2?=
 =?utf-8?B?bHYwNy94c1JUVU85dUdrUzZEejZtNWxmTEhjbExRbEcvb2NaUm53dUhERVhs?=
 =?utf-8?B?Qys2aTNBN0ZTdmFIQy91dlQ0bmJycHVvQVl6WXRpNTIzdVFOdjJYK0tKT3Zl?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dffab95-13b0-4540-c118-08dd513e8e07
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:38:47.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPKZ0R6AE8VvbW75rnsewIH+/4bQ6kU80Mk1bLYMz73pqUvQbkVZGF0RCaskeHCPc75ScnDJEWwXqr2RNeV+5Tft44d74nsf/ZQwz8TaSwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> rdt_put_mon_l3_config() is called via the architecture's
> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
> and closid_num_dirty_rmid[] arrays. In reality this code is marked
> __exit, and is removed by the linker as resctrl can't be built
> as a module.
> 
> To separate the filesystem and architecture parts of resctrl,
> this free()ing work needs to be triggered by the filesystem,
> as these structures belong to the filesystem code.
> 
> Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
> and call it from resctrl_exit(). The kfree() is currently
> dependent on r->mon_capable.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


