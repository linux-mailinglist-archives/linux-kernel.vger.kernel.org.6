Return-Path: <linux-kernel+bounces-329681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D108C9794AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F321C20FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 05:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544BA1B85C6;
	Sun, 15 Sep 2024 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/RAcSDz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C517BB6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726377315; cv=fail; b=BxRzpXD5WvhDjWMfIoQDh3zxgL/Dswg5uaidmTfKJnG0YwzvHGKYqaQJAtPyQN/5vQ0mf2fZXzB3hOzYvu1PhwiILv68vYM+U34FNCZKJ0FNQkC+0DnaiS3kAGNQlBx1pcipRLcDlCg8TgmDnyFMoc53zQsSaoJG8fpjh8IB9mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726377315; c=relaxed/simple;
	bh=Ck3U+STZiOVOuaTRWIhI6O30JDx6EvvxEtA1ujkZfsM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkqVHGs8qGkcb90pIeVlSqagcyZVwBsOgQbf+4VX8mllYYgiHkIdSwG8ScANrxT6ArLtlrnN+3UgJ5PkSOUaNXxuK2sqMiUSn+snxqNm+v5xwAFSpnKV1joizI4Ozxvmzyu5rOYXCQ5XYIdW7c/mEZE88Pn4PqDJ/jdCuO1nGCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/RAcSDz; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726377313; x=1757913313;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ck3U+STZiOVOuaTRWIhI6O30JDx6EvvxEtA1ujkZfsM=;
  b=U/RAcSDzxdxqeHOg18cB7miEv3UKC0zVpjOOOSUldAaHu8/ldAyq9vVL
   rVtwLzaRgMrwIBXDaR7EhrBmS3T0ZRgRhmk1R+Qy9WzvG/c6t0sUyoqrR
   laWbuEvnuKnGQSvhGhTOoRyAc7ituDbp4YlzVKam/eM8P4gF0dNoGpid8
   ImIcz2sDpPV4OIhHTzC2sAQ9J5Y4mqe2EQgVUpieVv7sQ8XN3YxeIj6z5
   erLJCcuJGjDedX9KKDvaiYcSCpfCX79I6FjjcDYl1hbIhV3FsCtAXm2n9
   JHYnlCNQAEH4EsBSXu9yrlbSjrxR6Bw3IA19u0ENMX1CLzFa4G+DkfNeC
   A==;
X-CSE-ConnectionGUID: fXBxCkwiQP6LxM5PJvJj5A==
X-CSE-MsgGUID: 40McAGfDS3iHqZ8OnOLFhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25124894"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="25124894"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 22:15:12 -0700
X-CSE-ConnectionGUID: BbjeWUyGTSC6f+l9gNv9SQ==
X-CSE-MsgGUID: WCD1yvqNTeuPTikI7hXrHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="68500965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2024 22:15:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 22:15:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 14 Sep 2024 22:15:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 14 Sep 2024 22:15:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 14 Sep 2024 22:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xL+LFBlmo/SsYHVbGDysKYmNT8UpmjhF3eDNZf17WW8hU6v2C9Wa092MJwAo9pScWxWWdxhXgv16ZzE5fij8SgXGg2I9FvPphLO79xMK9hRBhFMvlD1SBVnHYOQgpyE+QK/n8XGMkHkjs6/jJy0J/T+7BQmHUXBRGUqJX8n6nhB9nTXndCpaOIx4Pvw2SbD+sn3UjQW7ng3S7rw3xzR6z54OF4WIFCICOFwbb5TWaQG50PoT7eKCahGjZhcEPepYoBgdXLzg7diqFg7+/Kk97sPgCzR8IqXjckdFYqVmGpqkBKCFtK2HvvlQ+1pgHuw/uSbR909VkISJP9sOchhp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH82kOadRtH5pLhWc6gu0EdcCCOrpx/wiijqUEvxEDc=;
 b=ynEgCBlgkcaE15yLtv9Tf+H4/28Pl5fUw+MT5Xk9fn8aKMMErWxF3JK0HtKBkXLTS/tLTWKrITmtXBQAOownvgPBPUvWT5DfNeuYRMZYto3HonsoS4ZLyoS8PKF+Pj7g8feZnHwdUe+b96SU3qlFY8ic8c7E9dFYDLRzggpYEnx42P5JOW/qdZs6lL+V4Im3Kekx6BA+WsT2Cp4KAvmLUXYlgDg2PfjOX2JK4Woaa9BcX3JdXMdKqQvSAJN2cCl47Zm9cv6/nz8FrcynkLHcbbRvNOpN/CLhbDOyXVny9KUsEn0y0QqnJGkayprDcI8vfBsdsUt8GRdz1y5jWeVNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.22; Sun, 15 Sep 2024 05:15:03 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%4]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 05:15:03 +0000
Message-ID: <9be2f3c5-c72e-4f2d-acf8-2f70a513a2be@intel.com>
Date: Sun, 15 Sep 2024 00:14:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Qinkun Bao
	<qinkun@google.com>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Mikko Ylinen
	<mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>, Chong Cai <chongc@google.com>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
 <14fc2ce22d224f05f4d382cd22f5242297e9fb86.camel@HansenPartnership.com>
 <CAOjUGWfgYoXBzUB8wFvO5LDq+=t7hAEksu0EA4Dc7FwbmUJp7A@mail.gmail.com>
 <f92766c96c993276bec770e8a255bca6cc46c292.camel@HansenPartnership.com>
 <c7157fb7-b8d0-482b-9ec3-d60179a95882@intel.com>
 <0b334090c4bf21740b19371664ad0d78b66830c4.camel@HansenPartnership.com>
 <f284ce29-6afe-40ce-ad81-b6b2cec9199c@intel.com>
 <6fa6084fb9157ec453854aa5b7d34bdfddc63a75.camel@HansenPartnership.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <6fa6084fb9157ec453854aa5b7d34bdfddc63a75.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6f621e-0e9c-4d23-d93b-08dcd5455a8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXZnejRqLzFQZ2NEeWJab3pQbmQrODRXWHlleWdCS09aR0x6RFg4dHFYL2ph?=
 =?utf-8?B?UTFPb21uMGh2WEJFbjd0NzRSZmRPVmlZME9yYjc5QTIva3YwOVd2eFVDYity?=
 =?utf-8?B?aTRlVi80ajlTOTRGSWcyeHcwTTFHT2YwcXBRbUdxbll1OU02Z1c1SnlLYzVW?=
 =?utf-8?B?TDRJUDB2TXlSL3k3NnlzMlFEa3JIckRNaHJUcU12NkRFbGVGTzVYdWpCeG5u?=
 =?utf-8?B?OVE3WUNaNzZKeEhBME5lMlQxR1lvYlJTREFQbmt3VW5GZE02eG1XQ0h5WU5L?=
 =?utf-8?B?eGVkc2JkTWNvY09hMm9NWkMzN1RpTWxneVhDVlZ5RGRpZHV3UE9McEVodkZU?=
 =?utf-8?B?cmN5eGd0QUwyV0ZSWVVWdlpieTQ3SDZMVDh3aVdsMjE1UFNXSGNFbzVkV24v?=
 =?utf-8?B?OG5QejQzRjhjNTZadnpmM29tV0tOOGZyczNJeFRDL01Fb0JEdnNYTkhYZXJW?=
 =?utf-8?B?MmxmYWZlQXNxRGVNS2tVSENrMUpyVkptRUdTcUJlOWozUjhHZ2p4dUVSZGc1?=
 =?utf-8?B?T3BJQ0tveDNUMlo1T3pKVzJNYWVhaEVycHRzYmtmSU9vd2EvTzVXTURmQ0lx?=
 =?utf-8?B?alhCKysrSG1mdjNLeCsydTRBVm5sWUVzUDh3eHZqSDBPazg1VWp2Rmt6RzJr?=
 =?utf-8?B?Nys4djZidGhVMy8yWWZsNHVhOTBOUVJGVTliTDdYUzBzRXQrdXdSVkU1Z1hD?=
 =?utf-8?B?MzVXT3N6OU83RFN5NWZVS2VkUzk4Wkh6dG0ya1Q0K2hUUnhGTGVKQ0tvT3Z4?=
 =?utf-8?B?N1hIVVVCT0FVU3Z2dnBkNkpzOWhMYTBodDlNanRFZlNvN3hOUXUxdCtJaGxL?=
 =?utf-8?B?bDUvcHowaVF0QXM2NzUvdzN1RzVKK1U1OVdnbW5rUGZvclREMzYySm1ZMFpC?=
 =?utf-8?B?ZTVlVHhtaXYrZU5FYm1mWDVEbS9YL3E3ZUlicXNzTEMyVDlXalA2dGtoRExJ?=
 =?utf-8?B?QXBaWHc1YmVwa0xFbDZVUU5sZ2dEMDI2Rk1jUjdnYnp4S0JhK3VFdDNnR1Ew?=
 =?utf-8?B?TDRrcHBORlA0S1RKY1J4Q0VZNFJCa2NVcDF1SnM3ZnJpdUc4T1Fjd2tveDRI?=
 =?utf-8?B?RWxwaE1VNmI0bEkvR0s4OENoRGRVQjRYbzl1RDRnVThGdm9NOXJqUFo3a3pO?=
 =?utf-8?B?UmJoV1p4d3UySUxRUlNiZmZNUWVEVUM0aGVXdnBRbEFtWVpLRHJVejFuSERT?=
 =?utf-8?B?anVMc3JjdjBtT3Era01tbHZFVWM3SXFjNGo5S1RPT2Fzb2RCYitCbEU3NDNC?=
 =?utf-8?B?TnAyRGx2REkrL0N3RFU5WWhvVElUZGlWV29Icmg2cFBWajhuVm9ySUJLL1o5?=
 =?utf-8?B?ZU5TSml6N0tZZndRcU0xbkdQV0Nudlh2YmNFM0hOV1BrcXZFL3lLTFpPTDFj?=
 =?utf-8?B?NUp4aTV0dkFyWStRZXlZZDVlTDB4clROTGJpeHZLLzJGdWFhWXFYZVc4ejlM?=
 =?utf-8?B?dkNDVjBXS3Z0RU14M3J6NnFFcm45NURmVVVyVjJKbFJITUtrdXJYU1c3aVI0?=
 =?utf-8?B?RlM0WkVLcE42NkJFUDU2dVB6RjdzMDkraFhjUjBTblMyNkMzbDcyWXhneVA3?=
 =?utf-8?B?ajlsdnNuenUyaXFBOHlwK2N4N3VyV1hYVnJhakFhb1doSWdyWDA1Z0JDK0Jq?=
 =?utf-8?B?OHdSTTFPd2ducklFSm1DYmdQM25CYVVLYTdmTHpOdktHbG54T1pJbG41MVRz?=
 =?utf-8?B?enplTVlHTE42eHRYZ3NwbTYvNmhmcGh3SDZ2MnB3b2EyRFNOYW1lUWZzK0FJ?=
 =?utf-8?B?ZitFN0RNRTQ0Z09SVCtCRHpoRnZ3bzVwOG5SN1VjdXdoYWs3Qm5nbUE3U3p1?=
 =?utf-8?Q?Gde4ALiuafu86E/nxHxmg1dg1Xrzz22A3+LkU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZBa3hwbWorajl0d1dBcCtlMTZiYzdLa3czcmlDU042YTQzUFFpZUQwZ2lT?=
 =?utf-8?B?TExoUlhPdVo1cTZ1QzFvZlBWbnk0eHVMVHJQQ0tDWGR5ZXVVQ2V5UzF4cjBQ?=
 =?utf-8?B?bHJrTEo4aHlZRy95RVhQUHNsT1B3MzBPd1FUVHJoUVRNbnZUT09OUEZtdkds?=
 =?utf-8?B?eXBpY041T0dPQkMrVjBSZEc1QkUxd285TVFCQ0lQWVM1OTB0WEY0VmVMMzd6?=
 =?utf-8?B?ZXJqSFNWTm1tVkpDcC90eEZMRkJhS01UbWxUNHFCQkg3dmd6R1ZYTG5CUHIv?=
 =?utf-8?B?UUFYNWdrZmYzbndnSGZyV1hVOHFRWFdKNVJray92anBYM1lBbnJ6TEdOZ1c0?=
 =?utf-8?B?MHNkMjZlU09jMUpLMUNtck9BQldSZ3JEd0hkeUxSMGZMSE9kRGpBWU4xdlo1?=
 =?utf-8?B?c2p0Nlc0LzVZZFZGTy9oby9aRTl3ZGNwYWNUb2JYZ2t0UzZDbnFCSW9CYk9N?=
 =?utf-8?B?bEFnNjBaYzRmUFlvdXR2cWRYV05rMDVzWmdaMm82TlNSZWhWcC9JcVIwTm1u?=
 =?utf-8?B?eUZ3eGZVRG5zSVQ5a3NVOUEySm1jVXkzM3FlNU5aNUVWVnMyNmZaK0xWRkJX?=
 =?utf-8?B?ZGd3YU9wQUl5NVBXeER0YUowWUhtUGRvcDR0WHFRYlJqekFtb215REdQb3d4?=
 =?utf-8?B?L0NVZDZqWC94aGpTZTAxL2drVUVWRTI4d0NDKy9NVjJxQ21hQXlBV0ZQUms2?=
 =?utf-8?B?RlpvRHlMM1pubGNvRWxScTYyRTUySEVWdkd2SnFmNkU4SFFtbS8vcHBXdUdr?=
 =?utf-8?B?Q2hNbFpwUVdrZVpYUkxGS1lmekgrTktLMDdMV2s3WUx6VFdHZllZZVRHbnA1?=
 =?utf-8?B?MDN2OE4vNVZ2RjUxOFlDci8xZlZZSExEdEVubEFNVU5yMlc1UDN5VkxaZTcz?=
 =?utf-8?B?M2hCcDJCOGN6ZWFCQmhGSk1XSVAwdWRaNkEvNEg5SUUwV09FRUswQXhlSG5t?=
 =?utf-8?B?clVrRDFxYXUrenBqRHlVcUQyeWhuVE5ib3FhNThwNWRydXlHWUxDQVRxdjds?=
 =?utf-8?B?eTlsbjFzL2xJZHNDVG5aTmN2cnBYS3h6MkpHL01uM2hyeGxwQ2FaaDFrVmNu?=
 =?utf-8?B?Q3FHS1lqdEcyT245a0lGcWxlV3Y3VWk0Tlg4OUN5cFBEclU3cEIvak5kekNJ?=
 =?utf-8?B?ZzFDTFRmT2dHVllsMDZ6QXlReWl6UHhSSjRRbFExeXZuUE43MUlzRGYzaGxr?=
 =?utf-8?B?cTQyT2ZPSHQwdjRmQ0QvZVNLKzNpVjJibWlrOURqWHVud3k2SGVHeXMyWnBY?=
 =?utf-8?B?Z2wxQ0JJbTRWUkpFRmxXRnhOeUx6V2RPcDRLVFBMVnEyaWFiTlk1L2FPQjEr?=
 =?utf-8?B?UHpCODk2ZVdkeGJaR0hYRDUzajVjR2xVUmkzL1B5SzFpNXlxdHN1aHFUMUZQ?=
 =?utf-8?B?TVp1b01qWktTLy9LTC8yTlIrSFU3bDgwd2R0ai9YQ3AzOEE5bnlxRzJVa3pH?=
 =?utf-8?B?cFBZQ0tCcUx0T2ZEK3FqVGVQWjlSQUhIb2d3cnEvOU9zaEY5NDMwNVZ5aVdW?=
 =?utf-8?B?dXNkYVRYbkZ3ZTZ0S2RLTGFSYlA0OVgyNkR6MlFTTnVOeFhBY21qNEdic2o0?=
 =?utf-8?B?aHdPYWl3anpDVGYvemt2Y3NsSm1DTlN3WWI5bS83OVBTdzNrTmwvNjNIVXpu?=
 =?utf-8?B?L1hyeEZmYlFRcmw5S2NVZGFKZWFTYVVpN1lHWnBlc1Y2R2JZc25Md1FxNGxJ?=
 =?utf-8?B?YVk4UUtrZldWWmx0YUZTRDJMak14Uy9IZGY5eVhITmZzS0pHQnk1THVybUZJ?=
 =?utf-8?B?aUFUeHlYOUZHTHlDeUE4MUc1dDQ1Z1ZHQ05NaGpGMS9SQS9kdWtEd2JGVEM4?=
 =?utf-8?B?VVNERUp6M2o4RHZ2V0hNV0VhVUFhekVzSUxLWEFwTU50bXlSU25OYkJJVWJh?=
 =?utf-8?B?dWFHY3ZWRmxtVHNCdGw1aGt6TkVNZHZCeHBxRFh3eHYyay8wMTg1Rys5a2FE?=
 =?utf-8?B?WlN5UmpJYTJHSkl0elBhZGduNlczYmEwTjBGK3BKU01Va2VXWWdhZkNNaVFq?=
 =?utf-8?B?L3g0VnhRbXIwcjl3SFRiTi93VVFIRHpXVjFQQ1AwSXBoSVJvU0JyOUpIRGs1?=
 =?utf-8?B?dHF2RDZHOWFqbWhDeHJzc0hQSW5PMTJSNTRYR1p3NFg1aG1yVnloTDNXR2gx?=
 =?utf-8?Q?D0jnpy/zboeezKIjE3nDqazrR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6f621e-0e9c-4d23-d93b-08dcd5455a8f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 05:15:03.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVnOmih44v2AVZWK65Rr2j7I2xHjymm2wSrnPJW542b/6vPWdtSbA6BddPdtMiNpibo1LCzVYYODHWXGMhG0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

On 9/13/2024 7:58 AM, James Bottomley wrote:
> On Thu, 2024-09-12 at 14:00 -0500, Xing, Cedric wrote:
>> Unfortunately this is true, because this log format has different
>> design objectives than pretty much all existing log formats. Another
>> notable difference is this ABI is log oriented, vs. most existing log
>> formats are digest oriented. A log oriented design allows
>> applications to generate identical logs regardless of the underlying
>> CC arch.
> 
> So you're saying in order to get this to work successfully you have to
> design a better log.  I'm afraid I now have to quote xkcd 927 to you:
> 
> https://xkcd.com/927/
> 
I read that long time ago. Really a great article!

Am I defining a new log format? Well, yes and no. I hope my response to 
another email from you could be helpful.

My intention is to separate semantics from storage of logs. So yes, I'm 
defining a new format for storing event records. But no, I'm not trying 
to impose any specific semantics. In fact, with the shared storage 
layer, we will be able to support a diverse range of semantics from 
various applications with just a single RTMR.

>> Using CEL terms, ELCD (Event Log Critical Data) could be easily
>> encapsulated in both TCG2 and CEL, but ELID (Event Log Informative
>> Data - i.e., lines starting with '#') is not. One use of ELID is to
>> support off-log extension, designed to help migrating existing
>> applications. The  `SYNC` lines (necessary after off-log extensions,
>> see Patch 2 for details) would also require special treatments from
>> the verifier. Therefore, converting this log to a TCG2 or CEL log is
>> NOT always doable. It'll be better to convert log format only when
>> needed (and before any off-log extensions have been done).
> 
> You seem to be hung up on requiring a single log format.  That horse
> left the stable decades ago and isn't coming back (the CEL attempt to
> corral it was ultimately not successful).  I'm saying we accept that
> fact and simply expose and extend logs in whatever format they exist in
> today without forcing them to change.  

Can't agree more.

Therefore, to allow even more log formats (semantics), a common storage 
layer is desired to allow event records of different semantics to be 
mixed and separated at the same time. This is like a filesystem, on 
which data from different applications are mixed (on the block device) 
but still separated (at the file level).

-Cedric

