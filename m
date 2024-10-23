Return-Path: <linux-kernel+bounces-378868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15A9AD679
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED61A2826B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182CA1D2207;
	Wed, 23 Oct 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtrQazUz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9141E7C16
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718177; cv=fail; b=NwqPTjT9t6RsqD6SZkt5jKLYYaBKA/BQUJ2QVspnWnjvR+ciebt2A/V1ahkvzRDtX6P+EJiow5XRQhPBSKWY/a1Gjn8m5BBiaxmkBjIYwr/8pt7qs7hdZSH8V5BkGAxtwIGQfMSDJPqmeVQK0XFAwMuVQmiESnZ+GW8tajvEosk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718177; c=relaxed/simple;
	bh=WULe/v7lafckkPR8Ql2DvfvboVQ/cWoXW1Yk1JQ+iDE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eY4maQ00Sy6jArjRETjYXQ9LGxs18UINCu5fT43xNZujJNAMg9RfmqICZaLcmj1WFTXFtyf4KbfF7wZNykPILtXHco3dpAhSmm9GhUPF0rmZcULeM4n+TIF2eR9FnRUyfTDNqjZnEU2XTAUId0hl60ZqrZmFqpwu0uVbPZzNJrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtrQazUz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729718176; x=1761254176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WULe/v7lafckkPR8Ql2DvfvboVQ/cWoXW1Yk1JQ+iDE=;
  b=RtrQazUzpYdz80m+mWQaVmoDmt7LLaGA0HkfzNxLJzBo1uBJD4UihGUh
   cxzl1zkYxG/DAD8oIi6X+Ps2bdGksr5erMRAiViJV1JqTtJZo8l/8Q18x
   r7ejkQfwUiNi1pspLtqydO1bC49zHlapt9VDDfIMq/azzZG44RNoU/VsU
   j2z5ZU5oUMloM4ZqaMm3TCifeB9Jfv8pwWu9OcKz0wokYkal8VzzcuiGG
   a2bwtQHk1aTkYH+zBh8ZuTh1GmnutoRhRjteyl50L77CAtrcBhhdV6+Mf
   RAOMYeUlKDqemLzhh4DGwPrAfK+sa6WFR2hVzzncoaBmx1LtRnXKo1S5u
   w==;
X-CSE-ConnectionGUID: iSyEa8sGS32BebfZf1THeg==
X-CSE-MsgGUID: Thg7o6nbRzqrWEYoud0RcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="54728340"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="54728340"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 14:16:15 -0700
X-CSE-ConnectionGUID: pX7/v7LySM65mUBA4xyOLw==
X-CSE-MsgGUID: 9/jCYJPiRoyljbCqLYv8cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80393412"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 14:16:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 14:16:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 14:16:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 14:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp8WsGeS5qFzsbkcBegMg1UxpDR9EXtXxf5McuOUxdtEOQ6ZoN5u7H/EENzONhtmlXnI7vIxNqnT788IOe55KmxdL6I50nFtw783Gn2S78/7t2b0+w3WD6I0r74T5TE11tY2xnv+ProqM0s+H+ClJT1fQYhVrqulnFgNVRRSdjlFIzXJpKglyK6aNhq/kkRxx8eumNi0Abqi5NQWpT+g0qzFvLjzADKWPPqpPXhjgiuF0fwmwgc0pYMx3kA3VXc6orhBNPTcfWDpHvhLJyV0BdtxBxZqaWCnCqfdjIylkSRj4BB6kANAaqYtMX00afKfIJg4EZhnZFRJ9KF0x+fhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QWJvS1eRaB03RKiybKSNDBVKh2MOqLLHeY5u2H0n2s=;
 b=gP/TdGRPiaLJu16+cD+sEr8rRWM5FlqTp++I+OQsklOjiTzxVOJct9YMbEOLnBkLFyzLx3eXo/7Dls9Q+IUYnX6swuQfyvDk0zP8KVFwGIp5o9KbDd/EGbZKxtNRPbu31M9Xf4l5BeGJpzllCK7FSHUjjjPAOMsxmYReKMQR63RW5j6pBQNvijBdkvproyeP7qF/zV50tNm4P/4T51MBJoaDxM1O/lnmSyRGiZvgix+lWndHlbs5jB/btdiDvKB6PQqV2AeCKAuGA/v+usV1I4O1BW54fPi/V81I+us2x11BX3oIj/HrDWJxMhzybFVta6BhdzTVL6N1I0KbiOwvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 21:16:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 21:16:10 +0000
Message-ID: <8861c2c5-7377-45c3-93be-4be699163fe7@intel.com>
Date: Wed, 23 Oct 2024 14:16:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/40] x86/resctrl: Wrap resctrl_arch_find_domain()
 around rdt_find_domain()
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
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-13-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:303:8f::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc43169-faca-4d4b-6e35-08dcf3a7ea8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW5KYzA4WHl4bVBvbUcxako0eFdDaEJTQnVERDY5ZktzMFBvaWdodC9xRmxD?=
 =?utf-8?B?NkpGenE5TCtDZTNKcFBCMHpOd2lSZ2xaallHZk50SkFaem9jeW5ZOFh6TXBa?=
 =?utf-8?B?ZDlkZTFRd0RKd3JRWUVDVXNuSWR0TWd5NUJNWjhaZ1RENW1KQ0tibGptWisv?=
 =?utf-8?B?RkZNK2VEaHVQQW1aTmFKV0NPSCtxQzR2R3pDNWluZUFwR0xySSszMDBxdXJv?=
 =?utf-8?B?MlloWU5aSnRHdTE2UEdQbVljRWFpSVFFQldwSzAvcVAzbW1TRk84K3ZwdGVM?=
 =?utf-8?B?UTJKWFYrL09qenFjdUIza1JDczZPUmVjVjk1cFNnVEpTZ3hQZjB3bDVWeVVv?=
 =?utf-8?B?ZjQvM1FERWFhbEt0UjFFVlBaVmYrREhrL1JpVHFiWTM1RFg0VzZEYmNwZlF2?=
 =?utf-8?B?bkl0d3NjQzlQaDZHbm1YTnNUUmVZRnFUcERMSnJMVW1tRVpOMHd1SDRlbmhI?=
 =?utf-8?B?UkRBSng0UERUUFB1SjlOZk9UVXJGaEsxdTdLc1RyKzFaN0xvaXFRSUFYQTJr?=
 =?utf-8?B?bE56SVB5aWNHRUFjOTFSV29LdEw4WmJxYkNSNHZGNkdXamd4aldaeStqcXIy?=
 =?utf-8?B?S3NmUUpINWRyaFN1ZCttV3VIZ3pUd1dBemhuNDN0Q3UrNmZEZysvRGVWUVlX?=
 =?utf-8?B?SkZqaUtoV25lcU5EYnZYV3BURDhqVURLZ2prTEora0x3SW1CVlpTeE5XYjl6?=
 =?utf-8?B?RGdjVEJJOTljVWpOVmxEbFJicmlFK3lPdmNpUWhqWTlvaXdCS3lXM1pjYlN2?=
 =?utf-8?B?U0Y5aFkxSlhGaVBzRmJJTkw5MjI5MmZ4MXU0YTNmNXJIemNzU0JtYWVMNElh?=
 =?utf-8?B?bHptZVphRnc5K1JLdDdsU0s5MkxDdXViMnBqNHF5a3I1ZXFNVlhBZ0R6Y2s5?=
 =?utf-8?B?ODI5Vkg5LzRSTGJFbWR3cnJkVkk1MmJUV0xiK3FPTzNFemZtTU5SRFRPdWpV?=
 =?utf-8?B?dWtjVXA2ODZnZHAyUFpYeXRweUE3a0hVcG9jcjQ5cXV0dEhjUzNIUGFILzlt?=
 =?utf-8?B?d0xjU0Vqa1NrT0M0eUhaTndQM2pMbDQ1OUh3WUN5Ri9KTmxYa1NkTW53b2xQ?=
 =?utf-8?B?UW84QnVXdHY3U1JKaDNHWXFtZVpwNExGTFFwQXdPcnMveVpvdnhlcm1tenQv?=
 =?utf-8?B?bldBUThycUk2Sks4UnZnQzNvdEhnTWdQYTNJMUdBVGpxTGNqOGNLcGxNQ2hw?=
 =?utf-8?B?eURuTjdUWUtJa3dmVmtpUkVYdDh6N3psdGxFREQ5ZHl5OGZjYzV5TmQ1TXJX?=
 =?utf-8?B?ZWIyc2hZeGo3cWxHTUEvVlhOaFdLdG11RnJ1YU1zeHBhY21iK1ZndXNNcWZn?=
 =?utf-8?B?RHFPUk01VGI3djlyMmxlRHd0TUFQRVVkc2xsNHFKUE9ZYUlyS05nL2ZidnJl?=
 =?utf-8?B?ZkdiMDE4cVFNdExweFpjUmhPOHdtS0VzUXlwc3RvMkpFaENCQ3MvYnU1akIy?=
 =?utf-8?B?T0ZRWCs2cUVpa20zNWtMM0JlR1h1Q3g1YmRTY091V0l1eTZ2emVDWUxRdUZD?=
 =?utf-8?B?Z1Fid0pKbEQwdG9PQjBYenJBVzlGOXBJaUhFMXpKdEFJMHFlRldlUHYvTktL?=
 =?utf-8?B?SkNzcGlWc0FIZXFpSkpadUZPWjMyMHRXN3FjSklNbjlycjZoK2V4RlYzRFJP?=
 =?utf-8?B?eklmcGJtVDhkeEtDdDd6cFZqai9uYSt2cWl4aEY2Rk9YdlRsV3NrWVRxOUtT?=
 =?utf-8?B?Vm9qRlF1bmVxS2wwTDRaekdNUGhGUkhoZDFRSkVvZXNyMmo4ajQ5aEdCelY0?=
 =?utf-8?Q?O51+hGuwKouHEVzRP2+Px3EOvHSln1waW2xKWDH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVlhdGg1Sm1pc1UzdUh2bzQ0RDI3YnlrUjMwZVBObDJjaGVYdE9WUVBKRjdO?=
 =?utf-8?B?eksrNmxZemhZT3dTNWs5U0Q0NXltTGl4eUJzRUF5Nm12VXdCOFpHOGUzM3ZU?=
 =?utf-8?B?ekkzU1k4aGgzRnRmU3lmYjlPK0orNUh2MUI2SzhJc2owcmZDUGFrVzNTN0Fr?=
 =?utf-8?B?NmtNVjhTMWh5MzJDTTJZdTNZMWNzam9ZWDNrc2thMS9hU2lOSU4vblNvdXdB?=
 =?utf-8?B?eGRMVS9YRWI4UGQ5V2pSY2EybzR0M2pYT2ZXanVUZWc4ODRFcnQzZmtKOHhp?=
 =?utf-8?B?eTJmUmRJbXdSSzJXeDdlZExzaTRWQW9VMWIxbTNvTHowVzRlS2FYb0NDYWRJ?=
 =?utf-8?B?VElNV1NVSUMxZklGaTZNaUJIb1RPUWRWWUhXcEo5NE82c295aVAwZGlWRisr?=
 =?utf-8?B?K0wyNkVxSGp1T2hjb1FrMTVZTy9wUkFMSkZBQ0ZQVWoyTUJNWVViVk55emVj?=
 =?utf-8?B?L2ZvS3pZUVZCR1p4enBFZjZ4WXJXNUw4em9WSVA1ZUVxSmtqQ3lWY1NsaTN5?=
 =?utf-8?B?ZmhCSnVwcWNvK2hITmpTQzlGQkVpZ0Q1N1FlZ013c201ZXJJVmVHSlEvczJI?=
 =?utf-8?B?TDluK0dPL3dhdkppbHRoTTNyTUY4R28rMSt5NzFZUjBSSjZVS2ltVTJmcVpE?=
 =?utf-8?B?TnErMGorUVhkT3YzYmNsVEFERTFVaHIreWMyQVRIMWUxUjdmOGJrbWhaRjZN?=
 =?utf-8?B?UVlHSDB4MU9BYmRQUTlTTnZVWXNKc1U4cnlWYWM5S3k1N1Vtc3UzVURLalE1?=
 =?utf-8?B?S3VOSEJJR2cza3NVTTh4aUZsNmpVaVZUNmh1S05XclBTbzdMQWtEUVlMaTMx?=
 =?utf-8?B?Y0x0Mk1mSkVMZ0lSZWU4WElBOUpEOE9sRStpa1hxck42RFJPZk5EL3Y2bXJZ?=
 =?utf-8?B?bmpVaUI2N1BtbWlaWE1sZ2Y5b1RmQzQ3aWJjaDJTTnhIYXN2R0w2d24yVVJV?=
 =?utf-8?B?VFRqQTV1K3FvUmNLSGF4MTBLMzFRajRxNzhaTStjT0hZS2NrMWNPbXNtU0VY?=
 =?utf-8?B?Q0FuR3hWTUZvcFhqZExBTkJZVnZmK2ErTkhpKzhieWRTVTZoWFA1Vk9GWlZP?=
 =?utf-8?B?Tkw2Q0hHTi9WT1IvRngxQWp1T0lRbXdaZzJZTmdVWDQ1ZmIxbkNFTmFzd2M4?=
 =?utf-8?B?d2ZzamprVFFCWFM3YW9HRHE5dDIxZjE2cFNuUWdCS2FNekdmODdYRVNkVmVh?=
 =?utf-8?B?bGVuK3Z0QUxNcmFhMUV1OHpHdTdYNmN3UWZkcjBJYUxnVHhaMVFYVndpMlBl?=
 =?utf-8?B?dnFPbGZXMFJ4bkhmc0lFUjJscnQwR3FUUFVha3pNeEZUa3lIS1MzOFJ2Z2xL?=
 =?utf-8?B?MlFGZTVhQ0RXR2lkcDAwalJBWVVvTkFkOEdNWjNWRjZNKzlBZHNHTUhHaW12?=
 =?utf-8?B?cG9FRWNCaGl2SVlYRzg3Y2JLOC80czRHNnU3WFBUaG9ZdEdEVzlsbVE3WEtP?=
 =?utf-8?B?Y2dxblBTRmV5QlhvSjkxNm1sbDRsOFI1VGt1L3J2RkVTRUg1WitaZjQ4U2lU?=
 =?utf-8?B?U1ovMmdBelpSNk5UVDZHSmRjSm8vaW0yNm1XNnQ5YllIcS9iQmpvR3pScEtq?=
 =?utf-8?B?TUszajhkeklDMzRxeUlGalVtSEJCTjduVDBWOVd4UGF6TlFxK1k3cHNQOXMy?=
 =?utf-8?B?WDJmaWFlRkhqRkFiMUE3WkFyeHZES1hDWFRXdDZPTjVsaUNRY08vanJtMzhN?=
 =?utf-8?B?cnE2aE9XMGlVN21PQ05EMkxIdFJ0K3hzZktoOEd0Rlcya0hIem1JQlc2M1FZ?=
 =?utf-8?B?TlEvcUdWWUZRUG5CYlVyb2xxbU96bDhnSHlWMXA1UGdQa3dXcVMvOXd0d092?=
 =?utf-8?B?SXhQZVF2V202dWhqbTFMZVNiQ0s3MGxYRTBmZmRURW54MWNLWTBXUlNkNDl0?=
 =?utf-8?B?bFRMNktpUGY0ZE1objZMU2hEc05OUCtpZTRJS2ZkdlF5c2dHVTNnV29KTkE0?=
 =?utf-8?B?UGQ3MTczeUh1ckJLMk1rcVk2KzU3NFJNSHBTVFZNbE90SUhweTNvaUtIZTli?=
 =?utf-8?B?ZjM1VjMzSU1PZmYraG5QZFFvR0hDQVFaOGxxZXRKQXdxRUJsZ3lReVVyTnEz?=
 =?utf-8?B?WllucG1obUtncFFYOFdrd25kaHZBY0lnZnV4aG5uWnpYd3VBQ044QjlOaWxj?=
 =?utf-8?B?bGw2R2xoYW82Rk04L01ubzJBd1JnZjBmQW9XOENJODBIUTRNeXd5VHFtbWpB?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc43169-faca-4d4b-6e35-08dcf3a7ea8b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:16:10.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3r5VowI0y2XqFN1CQ3bwlRw76W3uWZKu4YnfxEFH/ncqKk4yuw0pab+UU6dTYsyNSZnRBLkJU/uQE1MhaQrPCrFZNN6qVnRrTK9Dcu3aeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> rdt_find_domain() finds a domain given a resource and a cache-id.
> It's not quite right for the resctrl arch API as it also returns the
> position to insert a new domain, which is needed when bringing a
> domain online in the arch code.
> 
> Wrap rdt_find_domain() in another function resctrl_arch_find_domain()
> in order to avoid the unnecessary argument outside the arch code.

I do not understand the motivation for this split. There does not seem to be
anything arch specific about rdt_find_domain(). Why does this need to
be arch API? Why can resctrl and all archs not use rdt_find_domain()?
Will MPAM organize domains differently somehow?

Reinette


