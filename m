Return-Path: <linux-kernel+bounces-234231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FF91C416
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4261C226DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D69D2E5;
	Fri, 28 Jun 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8npAtoz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728D157A67
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593227; cv=fail; b=mmvIsyBTQowBsGrThHRaKO8btrWWciez7BLdMkYlfgWwpTtz+8kSIT0LgaAvTMPk8KYiJMY6moVAJyWpwguie98wpTIuLN3QKjJY3WoTG3K7wcU37jLdIvKKJbhnYItYMuckgwFmRCMTFUCN6Umcs75RmWJaOwtF2lI+PE3QP4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593227; c=relaxed/simple;
	bh=WK3R77OiLHEFTqVusrI2Y/b2jJCRms3Sgz15z97S7bs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KW8gM/kQeYG/FY1NKHBPbE5dzOVTG0VfjioY36UPa0IOy95BTKPB+dPCIFxCf+O+4bdmERaEUji397stoLu+w5bqPsBlTW8fhdZLqb33ML0ToxG/f+7LLYuTMiQtNvnWd0RC+T/NtornsJ6uZ9A0Pc7+5/KgV1o2m38bJVJbzV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8npAtoz; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593226; x=1751129226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WK3R77OiLHEFTqVusrI2Y/b2jJCRms3Sgz15z97S7bs=;
  b=i8npAtozXbY2f/YjNXc3cVNIHeg272Q/pzye9ri/yl7ihNcoZ4VRjCuU
   YC+6BKj2rj/aiP3Pwug5EV4ujLOdz+omwDmAfySO2KHHPcMghl7I7oGSn
   fXcvnaNpHG9nscMxs3bx7JXghSU18XPQ+J3arglBLnbpvAfXrEMH2LC5M
   WQsWoJNqgha7Rlj2uwsvscCPbVvbxLNZH2KTfUB9cgQiGaO6NeDq5+4dI
   8PLbAj/ucvgWyhxHne8+p9D6/cm0dg55BfKI8/+LYC0UO7eKD9SzSR6bp
   x6cpJBBoPuD3f8pImoVLMhg24dQmbaTvcTZKG9bSdnb6ceJaiNb3s/1sM
   Q==;
X-CSE-ConnectionGUID: ldMp3GauQkCMP20ab8B5xQ==
X-CSE-MsgGUID: C0ROWdtSRjKOF9TT5rAGDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27918170"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="27918170"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:47:05 -0700
X-CSE-ConnectionGUID: aIsX3mD3TI2YVIst5lyAmQ==
X-CSE-MsgGUID: zeWKMGsYToaEypegDhMQMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="75987275"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:47:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:47:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:47:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:47:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os62TEyx81icPOKFRWR4DTuIlADE94ectkI7MiYQznAACyYuAg3n4orvrm39N1/626aPpMw5XDEgLUGYdxPNroy1P3F20bWdATFMUhwoXRKyas5oQ/VukrI0QqnPtSSAH3i9vreXHwKuvhzHwoZdRhKwjxjsvcZ6nlyHUAOsomA/z8H0LmMeEPAI2qHs/ZZc9LPs4VC0ALnNARjyD0gS9KL1RGk65TLKElHY4u7nY/rwZgZGJ5nBamySGHxHPpn1hz/eyGD2Bl4CUNaRvpo0boo/idhXU1EVRm2Qob12sjlRhO3Wb3Oq6D2pSqdppUR4ONthda56A0bMm2RmCNcepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODDeb5yjaFNG+06rhXYyyx9hJa2yIm7n6em94bwuSuI=;
 b=OSw8d42n8D3G6RlFSl2LSeBm7vEbmidKho3KbLglebCTTVNJLnrr9VotYnTpNZvZsZ/ZLFHxoYcbhfmOOY3RDjHOVpe+whyjhZDIfE+yDFxD8a1OPYPGh1rSaNWKP6CZBybGM2Gz5rSUpuHgPoLn/0vtd5kAM3gcK4KoC1DIbknGx/0qjPhgcX0lIeVAIJ03FRk2SST9vU4+PNTySoGxMUxuQaqWG6HcSj60fzp8lWAyQKkQ8bSWh+FojqD2Px9DT7QDOZsOfg+ik5wbGvEQE9v0NLc2zeDxUrONf3v2/YfS469gxxUZsEPwVZ6HvIQBFib0qBD07N+zRVXXZee9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7553.namprd11.prod.outlook.com (2603:10b6:806:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.37; Fri, 28 Jun
 2024 16:47:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:47:00 +0000
Message-ID: <a4b5644e-347e-48a4-a777-893003788920@intel.com>
Date: Fri, 28 Jun 2024 09:46:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/38] x86/resctrl: Move monitor exit work to a restrl
 exit call
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-16-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240614150033.10454-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb625e1-7d82-492c-a76d-08dc9791ee1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjRueXYwbGxzNmVBZkVSbnFibWJSVi9KWlpXbHhmL3VFU01YRjAxSkhqR2lT?=
 =?utf-8?B?bUN1OS9NOURDMm5jMEpFS05uUTdXYzVmeTAyanovYUpkOVd2MENwU0Z0VVhG?=
 =?utf-8?B?Y3hyWmdwN2RVeVc4SHlxZzZ0Snp0VXFaWWRIei9JU1N6bFVnKzVjODU0SVVq?=
 =?utf-8?B?Uytwb05nVllHcE9kRVdhWE5SbFVhaDhNZGRQcjZIZGwrUFY4eDJ5aXpRWFRP?=
 =?utf-8?B?YlBDMTRIZ3ByZmFCOFRwZ3QzL3FiNDBRTTZZUmxBL1E1bWlKdWxRSG4vdUU1?=
 =?utf-8?B?bC9wanVzUFcrZ0x6K21YRVNEM041UjZEaFRseEg1RXpQelhFTi9KZkpCK3JW?=
 =?utf-8?B?QkhaVzMvRDRXMEJmbUFZSXVxSkErOW9QbXVpWndKUUwxRU93Z1lrdGI4ZFR5?=
 =?utf-8?B?dUw0UUkxb0JkMFZhZFR4S0xyOW9LMTNVYmsyQkpUWk9YbTBUUTNaVWoxQ0x3?=
 =?utf-8?B?MXN0YkRra1ZjTFhCam9yclc0OTRqajdJeGFUWUV4QkRRSG1wSUhXOGJZQU5q?=
 =?utf-8?B?S1FxM0dRYVozMENzaEtxaHlpUDFrK2JBdzQ0WWRUdGJuV3N0WWtLYWE5NkJZ?=
 =?utf-8?B?N2ptQ3FjSnQyclB1T25aOTFNQWVKR282SFBmN1pFU1pmWkJsVUdXQzd4RU5q?=
 =?utf-8?B?N0pXMElzR0gyVFVnSFp2eGNVeks5WURXcDJNN3kvd3FIZG9LaFZLdTUrRWlj?=
 =?utf-8?B?YW9mcGdCaVJxUXkzRDFrQU1ZcjhDbmYrOUNiQ3g3WXhsTkx5cmU5YkdnN2Nr?=
 =?utf-8?B?RnZUUmZSaHpvWHdVaVpxSktSS3RDejFKYWVXb2lGb0FwK1VyMDZVMldFczZ5?=
 =?utf-8?B?ZHRza3ZnQWhVdmgxTVRoUFZ5bUNTVnNBODhtOE1mOUxnVDkvdzdzRUNEYml5?=
 =?utf-8?B?QmNhdnpENEdmSDZyUFl0OCtWTGppd2NvYWdvcThtWG5kcExObGtUYVl2Yjd0?=
 =?utf-8?B?Q1VCOXJ3SE0wakRjS1czYW1LbGVhN0pNc0xKZzNWdWRaOUYyUStCWTdFWGRP?=
 =?utf-8?B?T3JnVEY3UE5Cd05YN2FoVmtjNFFiUitDNThabGw2eGVJQ3BxT2EzOGdsL05h?=
 =?utf-8?B?cU5DblZJS1cyNWxZamVoSEhCWUxiYnE4TkRVMXlBTFA1NW5DNkRMZkdBS1JD?=
 =?utf-8?B?cEZPOHFmclRkT2FRMnhNSjJ0dkhrUzdqVUJsRlNST2VpVkdqLzRNamtJS3M4?=
 =?utf-8?B?WkJuOWRINmJRd0VMaW1kekxHVVVwbGQ0aXVhQWxWblFmb21yVC9yclI0a3Bo?=
 =?utf-8?B?NDlhVG5IT3FOZUFSeWtqaDNxT3BGaW9INW1wU3Urc1R1MTVBWDdYUytqcmVQ?=
 =?utf-8?B?MW9TYWhoK3FFYUZHaEVKN1I2WjB3UzJCTmlNZ3AwdFlPSTY5NTVTa3lTelp5?=
 =?utf-8?B?YjFnSFlBM0Uzb3dlRjRNMy9RNmJwVU9OeEVyckRwN3lEWk1QWlh2RXgra3lT?=
 =?utf-8?B?eE5HRDdheU9kVXVPR3VILzdmZ0t1YjZPU1daYnFtWEZhaG1iaGN1RzlaWjVL?=
 =?utf-8?B?TW9QZ3NhbE16SGxYTGkzYnNEdVhGV0JxajdHR2NYdEw3NitBdG0wZjY5UVY1?=
 =?utf-8?B?djBSdWNRL2dIT1ltYmhvVWlaLytjRzl1VHE5cUQ0VTRSbUs5TnF2RmY5cExa?=
 =?utf-8?B?U05NYjI3NkpHeTNpSGJOZ04yMnA3a0cwbjVTajlwVk9DL0Q2U3RINVY4TDN4?=
 =?utf-8?B?WmJGcWpmeUFxV0JMaXh0QlhYdUplVlJLd1NIVG1jL0ltL0xuWlVFQ3lFTjFP?=
 =?utf-8?B?QS9xcW9DazJwYXJ5dnJvZkhBdng5bGF6U3gxaHA2RHFUUHVYNnB5RjJWWGJW?=
 =?utf-8?B?STBXdGZJNlZHajMvSmxDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZQaVFSakhhS1VUQWk3SXU0aktkOGI1cmNvTElmSlRQckFWNG9iTWhrYVRl?=
 =?utf-8?B?TFczS1RYWjFVVWJ2WWI5Smo5dW5OSXlGOHJQb0lBY0pjbWhmdDNzcFRjMnN5?=
 =?utf-8?B?YkgvZ1J0aFlFbkIvSkVGb2h6YnZYNTc1SzhVUmVCUmJWWXhZUUhRd0l2ZlNk?=
 =?utf-8?B?TzZSWmYrejlQa3lnajV1UzN1MWgrYTdNeEdsQ3I3ZEtzK0NoemtveVBybVE5?=
 =?utf-8?B?MEJaMlZwbWdkN2xYa2g0KzJlT2pLQVR3bFZIa09hN2lXTk9KY3VNWUs3ZDJy?=
 =?utf-8?B?eitkbmY1LzNjVENsbE5mNWl3ZEVwT3pGNUg3cG5FWVArNVFRZGdSSVd4d2hy?=
 =?utf-8?B?VjZZeS92RHNDdVZMWnJHUkFYaTk3c2hrTjJ3d3RUNWxlWFJYZElyS0l5VkFH?=
 =?utf-8?B?ZDJDZUpnZ3ljWllaaU10d0gzYVJvSWIvZzlSZTd1NEpnYmxHclJRMVU5KzJG?=
 =?utf-8?B?U0ZkOXNiR1pRYjY1ekxQZkp5Q3J4cEE3amExbGt2UDNsa0psak1qekYwcW1k?=
 =?utf-8?B?YWE4Ukd6dmo4M09aWDFHNXk4WThYUTFDNUd3bFZFZndDdURaR1hYZ2FQNFFS?=
 =?utf-8?B?aElNUkZra3VyeDBjRHZML0Rpc3VCV2s2TmU0bUh5eUk4Ui9qVUZQWVNESmhT?=
 =?utf-8?B?VVEyUUYyMTRqMzRaRWR1ekNmeEZmcE5TTm5oUStldXdmbmxrZE8rUk9SOTJJ?=
 =?utf-8?B?eWREaCtMREtRVG9LUzM4ZmdjU0dPUUxCaEhGSm5MZmhNSDZmREVQTTJEckp0?=
 =?utf-8?B?TEdxeDRJMEgyZlJvRmp3M3BKZE8vaXF1VS84MnNGY01VNWw2SzUxb0Q5dUto?=
 =?utf-8?B?cWVrcUI3OFE5aDRzNkVjUDVIcHRjRkIyVHFCdGQ3enlRNWVTVVVQeUlKWlVY?=
 =?utf-8?B?eXc0d0VyYy9Ua2RYRXhiOE5Wdm8yWUdXTjByeGp5Zkk0aEJNWUtWTjJyVjZJ?=
 =?utf-8?B?MUFaTCtKQkE4ajE5VVBlZ1ZMRGIyL3h2SUZGM1pZbWJBdnJkOVk0NjVNL1ll?=
 =?utf-8?B?R01WaUhYUTdsanlWSFRFL2hYVEEwMmp2YVlmSXJpVTdVeVdNdGY0L3pZaVZS?=
 =?utf-8?B?L3ZTNkRUdlljOUQvSks0bzBOOWlxVWRVc3kvSjkrNDJuT0FXaDFBR1JsbVMr?=
 =?utf-8?B?MDczUFo1TkMvMzQyd2JvU1NoaUEyNkN5TnVYNksvTWRsMjc5YTV1M0gxMWky?=
 =?utf-8?B?akZpRGxhL3EyN1k3ZTBlMHhqYTUyY0ZPMUR2TnJFQ0lmUWZrS2tmWU5yZDk0?=
 =?utf-8?B?UTlzN2k3WTVLRXVjVTRERnhBVExGMlpUbUc4dVlaN0hZbUptaTNwOXdvMWRs?=
 =?utf-8?B?cXJ3WmFQNWZmaVJ5dXFUcVBJbE1kTHdJbWk2SC9QQkNON09yU2lWZ3JxSjVh?=
 =?utf-8?B?R2VwWXNTVWJJdE12MVFqOFUySTJnSVBrYzhPUDF0amxOa0VMWk40Njk3QkY1?=
 =?utf-8?B?dXptdnVEOVpnV1YzREtrTjc3R25VZFBod0IvNzJjLzROaGhIZWo5dUY4Yi85?=
 =?utf-8?B?YnhOREF1Smc4ZENtK1NhNFdqa1hDRHQyTkpQSTNQRzIvdlYzUFVyaEJUWHhD?=
 =?utf-8?B?NnNMVzZNUnhHMlRIdldheHd1RkJ1b2c4OWJ0QnR6ajk2RWlDWklxQWxNL2l3?=
 =?utf-8?B?TmUzUTRYZ21kL0lFc0RTNUk3dmx1Q3llbHlScEczQnlGZzl1bDdzak9qdlJG?=
 =?utf-8?B?MUF0SVhQdlpnWkFHbWJBbDhTb2VqWG1zT0dDOG1LS2dUTzY2TEpIeUZ6Nm04?=
 =?utf-8?B?TGE3UTZSVkNNdUFkc2IrRGxkcmpVK1JzMkpGT3BQTTJ2cDRNeUtJbm9PWHdC?=
 =?utf-8?B?bUtXMTlKbUdMUGFPQmUrbTA0QnZFa3d0WVVmZEsxbTl1OTBvUzVSVUdjKzNJ?=
 =?utf-8?B?L1RiS2pLWWtiSEdnUUZXUEZNQnByUWVXendlZTk1R1VTbzZ3NVpUcHNQRk5v?=
 =?utf-8?B?N0ZOcWJ5K2lLZ08vYVZ5VGcxMnNVSGl5RTNFbSt5VjJIUlVGU241UDBaNVlO?=
 =?utf-8?B?SlBackxRUlVFRzBwVU9IUkV4NTFLWVhaNHcwK3JMTlNTY0ovOEw0TDNRVEE1?=
 =?utf-8?B?U21oOWFTK2wvd3lUb1lpNjZXYXlQQm9sNllqV1hFSXRmUm5Bb1VSWTRSK01y?=
 =?utf-8?B?TWJyNnBPb1JhYUg1akhTZGRRVGMwWTV3Q3BiNkhGbmtVbmNuMVpQRnYxRGh2?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb625e1-7d82-492c-a76d-08dc9791ee1b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:47:00.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE1hlEQlKZuqUT4BQtn8J/LFsx12USfRF2vJbOneTwahgobyriLzK2EXjgVQ0QIFms8CIezowo97VERXgkNbplvmHRoIXglDZnW2wJLVgtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7553
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> rdt_put_mon_l3_config() is called via the architecture's
> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
> and closid_num_dirty_rmid[] arrays. In reality this code is marked
> __exit, and is removed by the linker as resctl can't be built
> as a module.
> 
> To separate the filesystem and architecture parts of resctrl,
> this free()ing work needs to be triggered by the filesystem,
> as these structures belong to the filesystem code.
> 
> Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
> and call it from resctrl_exit(). The kfree() is currently
> dependent on r->mon_capable. resctrl_mon_resource_init()

resctrl_mon_resource_init() does not exist at this point making
this motivation difficult to follow.

> takes no arguments, so resctrl_mon_resource_exit() shouldn't
> take any either. Add the check to dom_data_exit(), making it
> take the resource as an argument. This makes it more symmetrical
> with dom_data_init().
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v2:
>   * Dropped __exit as needed in the next patch.
> 
> Change since v1:
>   * [Commit message only] Typo fixes:
>     s/restrl/resctrl/g
>     s/resctl/resctrl/g

Something went wrong here since the subject and changelog still contains
the terms that were intended to be replaced.

> 
>   * [Commit message only] Reword second paragraph to remove reference to
>     the MPAM error interrupt, which provides background rationale for a
>     later patch rather than for this patch, and so it is not really
>     relevant here.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     |  5 -----
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 12 ++++++++----
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 ++
>   4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 9ad660b2b097..2540a7cb11b0 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -950,14 +950,9 @@ late_initcall(resctrl_arch_late_init);
>   
>   static void __exit resctrl_arch_exit(void)
>   {
> -	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -
>   	cpuhp_remove_state(rdt_online);
>   
>   	resctrl_exit();
> -
> -	if (r->mon_capable)
> -		rdt_put_mon_l3_config();
>   }
>   
>   __exitcall(resctrl_arch_exit);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 7ede340b1301..9aa7f587484c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -535,7 +535,7 @@ void closid_free(int closid);
>   int alloc_rmid(u32 closid);
>   void free_rmid(u32 closid, u32 rmid);
>   int rdt_get_mon_l3_config(struct rdt_resource *r);
> -void __exit rdt_put_mon_l3_config(void);
> +void resctrl_mon_resource_exit(void);
>   bool __init rdt_cpu_has(int flag);
>   void mon_event_count(void *info);
>   int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3e5375c365e6..7d6aebce75c1 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -965,10 +965,12 @@ static int dom_data_init(struct rdt_resource *r)
>   	return err;
>   }
>   
> -static void __exit dom_data_exit(void)
> +static void dom_data_exit(struct rdt_resource *r)
>   {
> -	mutex_lock(&rdtgroup_mutex);
> +	if (!r->mon_capable)
> +		return;
>   
> +	mutex_lock(&rdtgroup_mutex);

I know there has been a bit of back&forth on whether the mutex is needed
here. With this change moving dom_data_exit() out from __exit I think
the locking should aim to be consistent with existing runtime
and thus the check of r->mon_capable should be with mutex held. Having
this little snippet outside mutex will just cause confusion. Do you
have motivation for needing this be done outside of mutex? I think it
ended up this way with this patch aiming to keep existing flow exactly,
but that ended up as convenience in a flow where mutex was not really
needed at all.

Reinette

