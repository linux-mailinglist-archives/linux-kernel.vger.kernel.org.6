Return-Path: <linux-kernel+bounces-417477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E69D548D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48655B226D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D491CB50D;
	Thu, 21 Nov 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMkfgvPR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592071A2C04;
	Thu, 21 Nov 2024 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223583; cv=fail; b=FLRZP08nQHcFXZRNzDEb6u60arkOloflambrlRSVXR+/jg6Ypt+sJfjxY3b6fy077W41KSJWJS1WnAE3b9K1dZx46ge3yfzxCWhKuFAfq9B/qMaXtBpp9PiO5dT6Z4uz/JkYY2ECDvupcFRGoKFxWXaT9Ez74ipbv+155652/QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223583; c=relaxed/simple;
	bh=VKb6nYYheMoYq52SD1XkzEHys2/jcrfd6BXZMECwCs0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yoi56NV4QxqVa31K0RTqzLGU1kxUTnskMkSGvZycJrfCp8UA59JCv1crgLAW6NW2WdHsfK316k516ocTSDzn9DnGofY/JIh3mprZVi1hURZHSos8EAQ7U99esHjl5/+o1HolLFhUWHJHhA53WODG5uGgk26PF+dY9ux6INJoQRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMkfgvPR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732223581; x=1763759581;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VKb6nYYheMoYq52SD1XkzEHys2/jcrfd6BXZMECwCs0=;
  b=VMkfgvPRHS+R26pFKNi9iIU6yawJsqLR+YCdNw6khRYzI6NrAewN0OlA
   ZwfJcBJY1gZjXWPGWJh5l3XnDvchTx0JIfZmrlrOzW84WxmvjRbutrRwK
   sRdYn79pWcIuuWx5k9Zy69Z5LbsV1aj4zl71hTRAESr8ecdy6OOgg3AOe
   UJgSu9WtZaikS2Jf/d2nz1cu9mA4tAc+ePw74fYve3U1S+5Zs4LuEepEw
   YbN9qSfQstCSR4ban7GACYGUe4w4dOYOR2lZetSuEBplo3TqBJ58gbdBb
   n2/bTwjanLK/YCdBhYMDAUG4dMHS1wd6SQFqyJcsQkYcu/0yQVGK0gNR7
   Q==;
X-CSE-ConnectionGUID: gcPTX5UGRPS2Jc7+KH3SoQ==
X-CSE-MsgGUID: xsHrD+7BSLWPweaOYW7HcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="57763185"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="57763185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:13:01 -0800
X-CSE-ConnectionGUID: oqRE6USZSBKRc4uLieQL6g==
X-CSE-MsgGUID: a1tWcsHwRgSsYH7R/iOteg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95173822"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2024 13:13:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 21 Nov 2024 13:13:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 21 Nov 2024 13:13:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 13:13:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBtKiNwBfaXkblzLtCX7aBZfLylAljN4jKm6n3gH5kkeygZ5qFYTOabQKjtBzrEtjT+U4IQzfoFjMWrBWXZviUgpNSWugs0C5Yrr1KVM6vWD+xU2EETN/n2aRFtZkIlowHFB1kIIrc/jtUUoJlo2HIXXXxE9OMmY3k1/M7LxqhiHAwvYKWw84nAh3jevqHy7/uJABU0aCn3Ggn6kEe6ME/NWbbdypVckuTtWXK+9iOWkIUophytuSyiT6L1vqzTZLejDPH52ywqN8LbaHFIum3zu2w9C2ew/rJ0X55q1GvONvA1PNqfvVJi/72etobUHGLFj0Z6GQYTjR9AQZOY+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmHXtj0lvdAod2xSHIk2pch1vhomePxViUdH85wu5Ns=;
 b=AxUuJGNIU+wEDNyeVZTEufFtW3v4uz3GeWqG61x665HOE23nRhCNYlvvmruNfEBKR9pqk/X6IIKhOpAhr4R6c0k2YeMZ1vx98T82pzuk2dAyrL612Io7xhMPTMrw5Pf9qUhnnE/E7FooU9USpBupUcELQBXKUGWle4Q6xZv8eR/dSnyRm09nr4ClcUIYoao96uRkDC+D9EzQVfASV7QRX73mhCklXfHtvNNK1/LeI2o1Rs+0zNBDgqmD8FkfOKZ9u8b4SAgegGE6JkcBzDtybVpTJMUVu7GvfZSCci+Mm/hbHny+p77Ig3C0vcMlO8cCn5CAOpYI7B7fu07obzs3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8676.namprd11.prod.outlook.com (2603:10b6:408:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 21:12:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 21:12:55 +0000
Message-ID: <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
Date: Thu, 21 Nov 2024 13:12:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8676:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b530d0-f83f-463d-d9a3-08dd0a71443c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUZvT2J3MVdUd01pQUZNc0IrZmF3NENZS2ZUU0trRWg0NmJkNHBPTWVaTlNt?=
 =?utf-8?B?cENXOFVodjVJYlJhTlErVnJHYjgrYVJNNjJVd1V6RGtubE1ybE9vekJsRjFu?=
 =?utf-8?B?ZzJjLytwN0RvUkd4UDlYaTEvSkpSYWlTQTdLejIyODhsbjlLUjMwZnNhQ2FD?=
 =?utf-8?B?ZGd6TlZxZXdadnpOMnpoWm1mbXhlbTdpajUwSkpINTY3L1F6eG1YVXVHMXEz?=
 =?utf-8?B?ZDdqend4Q1hwM2hraXBrNXdBL09IaTNYK3FRaUFNdi9oZWFiQTJJakJkalNE?=
 =?utf-8?B?Wnhmd0hDcDJQdDdRbVA5UnI5MkNKWWI0ZStCNHo2OXZUdytabFRnY1Z2cStL?=
 =?utf-8?B?OExwK21velpQeVh5MW1iUUFlakgxZjhlQW1rT1NUOVBJc3FScTdEOWZmT2Vt?=
 =?utf-8?B?eHZoUDRBaUYvYmhWd3I2ZFY0czNsRW4vdTJvQTZ6SVZ3WllYTkV4WFl0cEpI?=
 =?utf-8?B?eDVodDRTRFBKSnhqSS9mVGJoV29NdXcrN21qQ295Y3lJSWhZUFVSUXdlN3Br?=
 =?utf-8?B?dWM4ZWwza05SVzM4Nzd1ODBoVzhEcGVycFBmMVZlWEorUlFNZ1p5cWtJWjBV?=
 =?utf-8?B?TG9iWXhkQ1NhR2h2cW4wYXdneUpVMXNKZ2psdnB4dUc0ajhCMytQWUcxVWxQ?=
 =?utf-8?B?bG1kai94QVJTZW90VTF2dHArUy83bnpaODZTS3dWVGdEN3gvNkJlNU1RUzZq?=
 =?utf-8?B?dG8rc1pmblQ4bUpqV3czNlVJdDFUU29aVFRjZ3U1RVVlbk1CUC82STZIeGpC?=
 =?utf-8?B?Z09LRndXekEvQ25CZGFLd0N3a0FMTm9nVW1PQTZza3UyUmlNc1FONmpWK1A0?=
 =?utf-8?B?UTNEdEVxaEpjSU13VlpZYWtORDVJVDhGSUE1SUxYUmhGK0JoNkswaVlvMHVG?=
 =?utf-8?B?NXBQSklzaWdGelFyVEJtL1FSeVRhMElycEJQR29XeWsxK0U4S2x0cU94ZUtK?=
 =?utf-8?B?c1lvRlZYODR5bFgxQTBpT0hHVVJTaDQ2UFcrUktNMnp5V3A3a21kY05ueUhE?=
 =?utf-8?B?VzhJcThtSmxKT0R4dStSOXQydzM2QUljc2tqMmF4NXdkYWpXZVluYjBDRTdM?=
 =?utf-8?B?T05VZHMrTWttNnJGaDZwbk5mTU1lWVd5a1lSMzAzMU5POTVTemtadEh1ZWk2?=
 =?utf-8?B?elpNK3YrTkdUQmFOVXdta1RacTA5KzJBVHNTbktNSTFibjBSa1d2SzBHTDJ5?=
 =?utf-8?B?Z0o5YWQ1TFRJOHFZMTB3RFFrRzNpcnh4VnVhMldsL3BUZ21WUldqVDZSd2RE?=
 =?utf-8?B?VTBMVFl3b0RiNEM1QW1LTFlISVdLL3BvU0hWR212TTZpQnNObk9tL3VmVnow?=
 =?utf-8?B?M3RVVDdOMGhySmZDc2YyaWhMMVd6alZ6Rk5DU1VVSm9vcncyMWRxMk1sWkpD?=
 =?utf-8?B?V1JrbnNQSUpvSHFOOFR6QlFPUmg5cFBZdTcvVVh2YzI1RnFneGxYcGxXYVR2?=
 =?utf-8?B?WTFON2l1bm9zVW9aZ1V0ZWd2ZC90clU3aE5NbFpNNlBZaWl4NlljNUR5cGpm?=
 =?utf-8?B?WnFyM0dwamNDVHJKNGlDWU5YYnA0YUV1MnJuOXhSV0dLeE1YZE14N3drZGpC?=
 =?utf-8?B?aXBRZnJHdkplZm5GeFBHazNHdEV2RHN5YUFuWHJ5S2FUOVVKM1drOU9uVHJo?=
 =?utf-8?B?VVB2OEhyRVowR2NrV2xKcTlXdjF5YnNiVlM0MXpVYStjZE5oSnoxRnV4Y2RX?=
 =?utf-8?B?YkZrdEd0VUdOWnlzZzFtTnQ3eVMvRGpsUU0vRFFUWG1qUWhQc2YwUklVVmQz?=
 =?utf-8?Q?cuQMfVKDpzkbI++8Qngc0Mi/oH1WjtPIYjwQKZ9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2puY1djZ2xqMmxJM2NPbnVBQ25TRWRWL0dUQ2l4R1liYllqOTMwajJPTXJh?=
 =?utf-8?B?SWxCcjRYNDBhVDNlSWJ1Y0hXTUI4ODh3TnJUbnl2S0IzUGk1Zjk1blVJOTNM?=
 =?utf-8?B?bjE0TmQ0cGJjZW9zZmlaSmF1ZzNxREJSSk0zRFFOek5GZXJyL2tQbTU5OU4v?=
 =?utf-8?B?QmVTN2o1ZnBSUU9oYitualFCMTBReEVNdUc2aG03bkFWTUxnWFMwWTJKbk9a?=
 =?utf-8?B?S3l4ZXpwUlNUeUpXV0d4TUVEQTR2K3VLSGtOdUNKeHRmYjBMdysxT2VFK3l1?=
 =?utf-8?B?WHo4MC9GdW5FaUNDUjJKL1F6WVU0VTc4cDN2R3o1N2lkNjNENGRhbTNFQlg1?=
 =?utf-8?B?aUpuUk1Jd3lKK1VHdk1HTFRXM25tdmNMRE4xZnhNbHdjN3VKSTZGOUNYK2hm?=
 =?utf-8?B?RXEwTm1pdm9mOGxFTGluS21aS3hmZUdoSnBjN29XNXlIcjBzVmRuSlAzWExa?=
 =?utf-8?B?dWUxM2x3NHU3dDFSV3A0NkxpU042QjRMZWlGVGkvNVdvRTBGNFVnTWcxRk1a?=
 =?utf-8?B?Y205Sm5BaXYxUzd1TDdQTENPS1NBbGxiMFQvWDYra0RPMEh2cU1Ocmt2a3Q0?=
 =?utf-8?B?MUhVWUgzQjREUUR5WW53UWdLQ2F4T3QzSHJtZGZwTzB1b3IvLys1bEZDb3p6?=
 =?utf-8?B?eXRtYWoxUHRoaFQvbzBJWHM2aTVuTVdxYS9xcTlRRHI0N3V3cTVZc3dGTXpH?=
 =?utf-8?B?Q3lKWU1FV2hFem9KajRlL3BvV3MwcDBzNXpaSFlwMEw2dmFDK3FpaU53Q3Np?=
 =?utf-8?B?anlENXA3WTA5aTJlcDRHeUgzUmtabUd1YW5TdDBNeDh0UGYzaldjZmZyMko5?=
 =?utf-8?B?bUVLM0JqRU5PYUFiRlBXWW9xcWhScGkyUFVoK1pUa1ZMWGl1cHhTUG9aYmhX?=
 =?utf-8?B?SlJ3V2srZkxoaGo5SHZJczVHM0FvY3RsZW44RDlUZWYwRVBQaktEa3JZZkNJ?=
 =?utf-8?B?VVpsdVZDeHNIYXNpNHhtaUlzRklsN0lSU2ZhdjJpRlhlUmJicEJzVW1xUmdh?=
 =?utf-8?B?UGlMVkZNNEE0aWs0TmZBQVpPYjNDUUE4NUZHTTc1a2F6YncxcUlmanNaK1Vq?=
 =?utf-8?B?U1Z2VlA4MWdIYkVsYmczY21DK3FrMnVxaC9SK2dVdzcrT1liQWpxMnBZRHlJ?=
 =?utf-8?B?dXhRc0tZYkc0clpaclhTV3pIVjlMaDkxRk1FMG04RVQ1ZmV6TVpuZ3ZyNFVE?=
 =?utf-8?B?SlEwcXQvNzNiQmFYa1Q4SEpCMk5PZkc3ZjRES0lidlZwWW84dmEvVjN3WHAz?=
 =?utf-8?B?ZlkxUUtzU2U1bFhZNTYyNlZVaThyVVErSm5zcnIzSW9BYTlKQzRVakNYUWJY?=
 =?utf-8?B?TkFabGQ3NWI2S3d6eU9RUnhHVG9IQ2R2Ti8wYUVRaVBhaTNiUUZRT2dORko5?=
 =?utf-8?B?eGdBZUhZakhwRk5aRFpCVS9Ub0dQQnd3OUZhUGVESERURVY0TUpQdjVaa0dJ?=
 =?utf-8?B?enkvWVZSVGpjV0toNUd2OHFBTTNVN1hLRHFTbmNHb1UrYjlkMzBMR1N6RjFy?=
 =?utf-8?B?WDBBM0hqMFpPRDVrcnlneUd5SGYzeTBtOXJwRnNnUDBkVWhFSGltUjd6MC9p?=
 =?utf-8?B?K2tmMjkySzJIREtvR2dSd0VFR2VhMGNFME5DWkZGT0Z0NGlYb0orT3FSS2FO?=
 =?utf-8?B?SUZWRURDVlFEVzNPQk41UlRqWTh4aDlOWXpyL2srVzRpc2dsSU1VVWpTNVhv?=
 =?utf-8?B?ZWVpVEcwYVMyaUZXdjdISkZ0Q3pNd0VyL2NTcGhCRE15V2VUWVpVWTdBOGNM?=
 =?utf-8?B?Z2J6QUkxQjZhVWJQZ0daMFMzSjBXRlNBTWM5TzJkOE5janN2UE90NHUzQ0Rx?=
 =?utf-8?B?R1JZK3R0NmVERk1ISmFMQWdzemRvSjlJbTZhUzhFN0JaYmtrV1Q0ZitoK00v?=
 =?utf-8?B?a3NpNHE4ZlV5L2JQWEd0VWJhT0tTWUdZVVBuT05LU0liVFVud2hIbEtSOWwx?=
 =?utf-8?B?aWdlelo0VmhpZ0V5S3E0MlFxVnJOMzNBOFhqSlo0dUQ2Z05DakJLRmsvQTR4?=
 =?utf-8?B?WVdxSWI1cStNa0VLd0c2Z2ZtaWhpVHE3U2tUMCswczRpby9OQTlmVktRelBB?=
 =?utf-8?B?Nm9tRXNhV1gvMVZ6VmdNOGx3U0owK2VENXp4SmszNkpXdHZFK0ZiWmFCOVNk?=
 =?utf-8?B?ZWs0YzNHcnVSV25pL2Z6WU1veXdDNjljczRjV3dJY1VMeHZ0SCtDNzZvZTQw?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b530d0-f83f-463d-d9a3-08dd0a71443c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 21:12:55.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWU5jh0ZSJ92dtWVJKhsdId+Y63NLdO68gBHH6njL+/nHpsiO+SsKTOLOOqCJgohaNhI/zcR4zu1iGpFV2bzeU2jsWsxjOIAVMBwqg7P9wM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8676
X-OriginatorOrg: intel.com

Hi Babu,

On 11/19/24 11:20 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 11/15/24 18:31, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>> Provide the interface to display the number of free monitoring counters
>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v9: New patch.
>>> ---
>>>  Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>  arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>  3 files changed, 38 insertions(+)
>>>
>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>> index 2f3a86278e84..2bc58d974934 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -302,6 +302,10 @@ with the following files:
>>>  	memory bandwidth tracking to a single memory bandwidth event per
>>>  	monitoring group.
>>>  
>>> +"available_mbm_cntrs":
>>> +	The number of free monitoring counters available assignment in each domain
>>
>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>> counters available for assignment"?
>>
>> (not taking into account how text may change after addressing Peter's feedback)
> 
> How about this?
> 
> "The number of monitoring counters available for assignment in each domain
> when the architecture supports mbm_cntr_assign mode. There are a total of
> "num_mbm_cntrs" counters are available for assignment. Counters can be
> assigned or unassigned individually in each domain. A counter is available
> for new assignment if it is unassigned in all domains."

Please consider the context of this paragraph. It follows right after the description
of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
I think it is confusing to follow that with a paragraph that states "Counters can be
assigned or unassigned individually in each domain." I wonder if it may be helpful to
use a different term ... for example a counter is *assigned* to an event of a monitoring
group but this assignment may be to specified (not yet supported) or all (this work) domains while
it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
needs to remain coherent if future work decides to indeed support per-domain assignment.

Reinette

