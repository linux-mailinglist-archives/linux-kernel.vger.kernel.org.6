Return-Path: <linux-kernel+bounces-400519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4549C0EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4F82827AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8C217448;
	Thu,  7 Nov 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PN0V3cys"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41390198A34
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006930; cv=fail; b=cJ7RxgEtFqOw1kX3+F84mfwY4Qgq4KZJHBNiTJNOtUGmjceUuHhn3VTOQfsJJE3zH8jDOAiICa2eAvoQJblcbJ0A153KLMe9SsU8mBtnvZELzBt9tOdZ5PsS+hnD71MepE2/zzyJWmnbJSNU1tO+0wloYrroIaUelNzMyrRTLS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006930; c=relaxed/simple;
	bh=WBDfAzLDTxFH8lvhomQWf5qpuOCZxS31/Yko7tZmIkc=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qRF+08qvMTy+bBcByGUX63sxyKYWneE8FQQNEOCuBKtEetNLsB1yVfFXtVLHFaUz1Vvp3NfYJGX11cTBH2SxG+tIlSGzvFdNHmOuJ9e2H5A0JLodc5Qso8h8MfbWFeHuWTDHXhipbG61iD6n2nhEYmH815vWStHcFmEHu1+3+Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PN0V3cys; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731006928; x=1762542928;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WBDfAzLDTxFH8lvhomQWf5qpuOCZxS31/Yko7tZmIkc=;
  b=PN0V3cysLzTL9F3OVPWuzTXv93GuvvaOxyzHF3wq32Upgx414U972/n2
   uts2dY7Bod6BsZnFc5QtUbd7qYIU77itTbGj1PqxeBAbO7gkWwf5JvrlX
   kPE7q+DsYFoIYtarEQGskXXLm/ox3pK6PRNO7eNUumz1Jf/zh/W1//bOm
   uiT9WOLPizOVZnIbNJsbCr+D7vKHAlZ/FxIiW8Yus/6iXMo+UaNPJWHrg
   yH9GeAss7DPLTvVgZ81EQmhnCI847wQDgL8gUxskFmOHdSjRvgvi/LMRL
   MHeZhJQq+xXio6oJu16cGWZEJGTlMMhwAdTrOpxkNxvB1XNcYpJtAprbc
   A==;
X-CSE-ConnectionGUID: ZFpGEdSsRU2GiG61Ni6DaA==
X-CSE-MsgGUID: 7gxYUddiScy4mFGMBe/Bcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30273302"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="30273302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 11:15:27 -0800
X-CSE-ConnectionGUID: 2kecDYvTQbSYkN8v+64OfQ==
X-CSE-MsgGUID: q7KfNqg4TceRSETA+4DiUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85350168"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 11:15:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 11:15:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 11:15:27 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 11:15:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqfSkeLcG+EJwqrjAXUJF64pqT2YTiKzpj7kbXoYq+eaq/ob8h+VE/8V571AP4xZttern1DiiAtfnKwZutW/vWNWC0oGXupRNaS91IUlFOJY2MYBKZ7GMdURQ+yXVbSB7DFN7dAEMWgDEnGHUGj7psxrHFStNCMShvuGzCUXxi9Q1dyJloKpSupKbdy3M12c5bfP4RAWzvDDTJUrdBqDkZaHX5ghe0GGMZAqu0N4dHPRwLtxKKa3dCaNXuVcGPN/MO7W//GYNG+UpJ54Xv+6MYi0/HUSv/ZQ182Co0E0Mkgxt3AhZZZfwlDiWy3Oyrd3vYwGDcLjA3uA7pcKYUiO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75sR8HnCPIqIWf3dVzMvqmhhibTh7bbyyT51JfAZcKQ=;
 b=qcf4B3Pe4+ueLl7/gzMNbxibjfWS0u5GQ1J9h6DjhCZQQKC/GX+E69vZc2UVEk8hgBa3hteb6fhi6yDTZunXM5lOUVsQaJKb1VkSkLZa/wYqEcVqoQYWOUk+wPxiG3ghHzglDe86S8xYkDJpOkoxnnuJQ/rFFgEVhl6JbuWSQe9ReacKyUJCYTP7O7X3NilpaEN/8lEYPJlBGWES+U/0iAo4AYPBoAet5R3h/aeieYiiFDELnTdn3N8D92RbuodYn2us5cige8xzBwlrVK+CbQgCO/Jqz+CCCiZKeaiB0eeF4pNZUkUWyJ/gYU3ViQYZMbShRFKc3Cl7J/X1fF1bhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:15:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 19:15:20 +0000
Message-ID: <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
Date: Thu, 7 Nov 2024 11:15:17 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: Tony Luck <tony.luck@intel.com>, Peter Newman <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <eranian@google.com>, <hpa@zytor.com>,
	<james.morse@arm.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<nert.pinx@gmail.com>, <tan.shaopeng@fujitsu.com>, <tglx@linutronix.de>,
	<x86@kernel.org>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <ZyzxbhHQptbktfGH@agluck-desk3>
Content-Language: en-US
In-Reply-To: <ZyzxbhHQptbktfGH@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e67243c-c165-4e6d-fb10-08dcff608557
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEJkWlhmQ1Z0dlRPWEY3Tld1blhRZnZlMHBlYzJMb1VaUXFPMlRyWkw4R0Ry?=
 =?utf-8?B?YXo0OTE2dWhYM2xFMFBEMTNEZjVSTDc4Rm1yaWduRmZZNHNWeC9aTWF0Rncw?=
 =?utf-8?B?S2FFNE1qcExvTUxrN1hnOWpKRnNpK1dJWTVPSitPRWtnNFc0ZU5JMlllZ3NO?=
 =?utf-8?B?NWR1Rk5LdzlBUlBMdEczK1ZxcEJGOXYwanNlT0cyVEJ1SXJVcWFkU1NPcFdO?=
 =?utf-8?B?b2pSU01pVHdpUWljYkN5dXpRR0ZWdlhCNzJvTXBQckt4cHNnYW5FQklFWlAv?=
 =?utf-8?B?Zkxra1BYRVNnMEtJbGpsSjRrVkNtTzhrTVVpR1dhd2w5QzlGNnRoVXFGT2pP?=
 =?utf-8?B?bFNWU3pVQkwxYXhmd0JvbnpYSnR6Q3d5TE5PYWkzYmJ0ZkVCSjU1MjFWeG9U?=
 =?utf-8?B?M1BmTVRUMGlLdjBDM3VJSCtVdWdaQXYyWlBzTG9FVFAxT2FyRlBWT2Y1MVhE?=
 =?utf-8?B?QUxBU2F1RjVhS2srcnNseGtYUVpSZFFyRjNXMXpOb2ZWUXVPNUdjRjAxMVBi?=
 =?utf-8?B?K28zQmdhQWpCOHNHQWxWUVRSeUEzNjRtKzRnbERWemJ0MmorYjVhZlZXa0lz?=
 =?utf-8?B?b2NYYTRZZlRWVXhXOFEzT3RUMDF4dG42Y0lmSzRBbFNyUnFySHgwWDR5Sm1F?=
 =?utf-8?B?Nm5iajc2ZUloOWNGbGZRdHo0bDYzZm1sYUtTQWFaNDBCN1FwUlRDcWN4bEtz?=
 =?utf-8?B?VzVyZlVrdmpxaXVDV3V4S0NYZmp1VkoxNjhsWHJPdmRHNTRmdHNDdUlpQUds?=
 =?utf-8?B?K2ZRRWtyVGh6dDAyYmJQQXFqdkVyWlF2aXVFTW1PUXhKVFpnV1lGV3NMZmEv?=
 =?utf-8?B?TUNwVXF3czJrWG5nRURmZ2x1SmN2d3FvUzZhS0pvMWNEUEN2aE1HVGphQVpS?=
 =?utf-8?B?T0ZlR1RKOHdQYlEzeWlmeGpuQUtSZFV6YnA1a09mZXBEaHk2c3dmZDZRMzdJ?=
 =?utf-8?B?bXRRYis5aTVGMWZyVk93MEg1L1VEOGFEMk5qNXA1aWZuRThjQTkrVmFHdW4w?=
 =?utf-8?B?bitlWjhEOVdTUjd3WXNkYjN0UFYvM2wwb0U3N3lRMFV2QzhLVzBFb2hrWXdp?=
 =?utf-8?B?bCtBdUJNWC8rWFcxaTZoaEhwc2dkUjkyRlkyMTcwR3RPdjhGb2tHSWY1LzBj?=
 =?utf-8?B?VzF3V3l3THdCOHZGNEdhKzd3a2xHc3dRUFZIcEtxc0hhL0d1TmdrekNjQXJH?=
 =?utf-8?B?VXhmRllEdVhxa0J6R2FIZkNmY0hEVGYvRnRJNHl0Ym9qMmtKcmJGZFZDR2Vz?=
 =?utf-8?B?cFdNdm5mYi93YVVsbFh5VkFHMUNRREFtUUU3c0ppTW9RY0o1ZytFazFXbGVW?=
 =?utf-8?B?d0czWkNjYllRdDl1dWhqRDRIM3FHZVR1aVdLYlZiV25tZnlrK1pXMVRGdGdE?=
 =?utf-8?B?SDJmUWVTUnRjbURxZXg0aDZZN3ZjOVJGODJraStocWlVRlltK3J0U2YyT21r?=
 =?utf-8?B?TXExKzBWNm9oUU4wekQ4TENvSDk1SkVSeDRKdENUWEM2OGRoak5teWVHV0tQ?=
 =?utf-8?B?dDUwaFhMOWhINXFTMTEzVlBBSXowQ2hlN1krd1hOVG1abWdMTGFnYVpPU3lR?=
 =?utf-8?B?a3B0bEh6WncvazUxeXB3bFRWSTIwdkpnRkdubzY2elVrUGhhdzQvVU1PaXBL?=
 =?utf-8?B?QjBzTWxmMENLaS9BNUxQYnRaamlCYXI2T0ZSY2REbHF5WmZKc1dGeXR5QnNo?=
 =?utf-8?B?WkM5QVFsVENhMjIwU0lGQnBOWUY5OTlYNWxQZThlY1QvdjE2STNKNEp1dkJs?=
 =?utf-8?Q?0asWYRJa6rWrogOG35IUudk30MwKJcxiQJ5JRJJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmQwczlMNzRCNVVZeCt1dUdKSlBlYVJMWThIcnFzYjB2eVdjNytDSHluV1Ar?=
 =?utf-8?B?a2h0dkJ6MVZPWldQM1FxcEFLWHkwU3pMbEh1LzVWb2xGUk9DWUFxcEl6aVYx?=
 =?utf-8?B?QlpCMHFsUSthTjhUdEx6RE1VWGdFTzV4dENPVE12K1Qxb3dDbjhZa2JXUk9X?=
 =?utf-8?B?MVYwY0pZYklnaHVDdE45K1psZU5UWThDb3o1UGtJMmlkTjgrYmdaYW93SGNK?=
 =?utf-8?B?YnorUWF6MzFSblNqa0FNbEJYejRjVVBQakVqYlQxdzVkRzBmelp1dmNaUW1R?=
 =?utf-8?B?WVczcU5hdmt6Nm1YcEJaTWFGUkhlMVNwdHdwbkcvOWlHenRqR0hVZHo0NFUr?=
 =?utf-8?B?ZTNNTzFjWFl3ck1PYkVpME9YcHdBdmxsWUt1cU5qZlBPSk5pL1RhcFlCakJI?=
 =?utf-8?B?Y3h3Z3BCeXdnSmpXWmRtN25kTCswYWxpM1VLUGdXVm9rYVJwUm9idzlyRHZ2?=
 =?utf-8?B?aDd5NHVEWG00aUY0ekM5R3dTVGx4eExpK0U1Y2RuTnJaWC9pa1pVWWJSSEdo?=
 =?utf-8?B?SXcwcEFoRFFsdnRubzNTTGpjU0czbzZXMmNiaWo2KzQwb2tydEtCRkRGK1FC?=
 =?utf-8?B?bmVwM3RJaHJXdWZyaUJGbURublIyQXkzbU05ZXp4akludkw2QzRKMHA3ckhi?=
 =?utf-8?B?d1JxUUhTdUNJakZlKzVyZkZEVWs4d0p3bVc0WmVMTk1OUFU3UkV6R1l2dmFL?=
 =?utf-8?B?Wno2cFpKY1VtY0l2T1A3Tlc0NW9sTy9Kb2xiTm5KbUU0Tnl0Yk1RdTYxS3hK?=
 =?utf-8?B?T3pkcTNHM2hEUWZhYllQYWRZQXlkODdabVFTaXlGRWRya1pBYlE4NkpETEJT?=
 =?utf-8?B?RkZibitMTTMvY0w0L2FLREk1MGdqK2dsU2JiRlMzQ2s0ZmJ0UlE4ODlPbGs4?=
 =?utf-8?B?bVo1QUJXNVZrbGs0dm9PZStKQ291Q1o3Mm04YmkvS1lKSEtrQmpaTDc1SGpK?=
 =?utf-8?B?M3pUVHJYbytmSEZqZEdrZDVQS1Zsald5T3J5M3JHd3F6VVUxdm1palhnMkZZ?=
 =?utf-8?B?d3NuM3JJQVJUVDEzbWd1a2s4RnlZZVdOZU51YjZpK2xheDFoa05SbHNvdUdo?=
 =?utf-8?B?ZmFQdlIvT2N5SGV3ZmJ4TGxHd1pjS0xidWZGVnhIcUJoZmFQMHhTMTV5SzEr?=
 =?utf-8?B?V2ZKK05jNFpmWWVlY0RqVW9oRkg0cGNHbCtSeDhrbHU4VmJUU2I0ZWN3emE5?=
 =?utf-8?B?TFd0dXRZazFHYXFvaFlJeWptbmVYZnNaWWN2eDJhQXVhOGlQQkpwdE8xVmNq?=
 =?utf-8?B?aUFyQnJYZWNBNWdNU2hLdVF6clpYNXR5T0NLYVNUM0kyUzY5b2xxbk1DeEt4?=
 =?utf-8?B?WTlTU1VRWlRaZlBpbzl2L1R5SXlQWGV1eGJna2VjTk0vS3BKRmVKUm44bzZP?=
 =?utf-8?B?Sng5dmFzOWI4eE1sRExoQWZKR0ZmekFaSGpJUEovL20vTkNnMU9naERwdXFN?=
 =?utf-8?B?MkN2UXErQnhSdGFFK29QdUIrYm80MWtFTUlKNVNEYk04bjQ3SnNpMWVOQ29D?=
 =?utf-8?B?NGc0Q2FHVkgzWE1uUHJJTnhXeFN2MFMyY2Vyc0xONkFLQU9Mdm5ydnV4VlY2?=
 =?utf-8?B?UGRiYnZsYlpURlFhUkFkenp0ZGJ0M3JCYStrUHZRbFpzSE5MV285dytVYm8x?=
 =?utf-8?B?R0RlWmg4TW5ibnNndjY5bm1iUUN3QnBoYWMrNjYveVNvZ1hUcUt1K2kvOFc4?=
 =?utf-8?B?bjBHN0E5VEhpcjYzNlRDTGxjRXBLSTFMVytXV2RteG13TWQzeVlzRFFISXVJ?=
 =?utf-8?B?ZGp6LzJaTG5Ja1ZoTmVnczZtdTI0V0RpVHlRTmViZGFEbzJlR0VLbWJrcWZX?=
 =?utf-8?B?anE4c3hheXVqOVFnUnJkQnBjaHRSbW5EWERqUW5sQXVPVkZqcjY1K1V1Nmtp?=
 =?utf-8?B?bkFUdWRPL2ppNFZjSUd2d2p6WGxabko3SUJEVURYUWQxU3EyZktaT29JcU00?=
 =?utf-8?B?b0xhZ2ZNNU9YMEVDZnVNSVlDb3J6T3V2dzJJQXdOa1E1RU5LaWJlYTd5Rkhr?=
 =?utf-8?B?VWlQY0s1aEJZTysrYVZ3cnh6Ym1HNnFadkFYU040ZVFrdEM2MkJrZjNoZUNK?=
 =?utf-8?B?bFdhQ0xlSkRISE0wVHRnTS9udUJlRkxlbUtoZE5MTlZLZGdQL01sOVZqODNF?=
 =?utf-8?B?WXRqclQ5Rm9oWmFHR1UxWkFSZ3huWTFxeDdkcTZBQXV6MzR5V2RxVzNid2cv?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e67243c-c165-4e6d-fb10-08dcff608557
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:15:20.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhWisbZL8781a5VEyh9z0hWTgwyCBUsj7vm+r6+34wEyaIc/XUNYhfKO0Pjm7Vp3T5DlrCTl4fCSC968262HqyNNeyTY/K8j3TPt7PqQJGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com

Hi Tony,

On 11/7/24 8:57 AM, Tony Luck wrote:
> On Thu, Nov 07, 2024 at 03:26:11PM +0100, Peter Newman wrote:
>> On Thu, Nov 7, 2024 at 12:01 PM Peter Newman <peternewman@google.com> wrote:
>>>
>>> Hi Reinette,
>>>
>>> On Thu, Nov 7, 2024 at 2:10 AM Reinette Chatre <reinette.chatre@intel.com> wrote:
>>
>>>> This sounds as though user space is essentially duplicating what the
>>>> MBM overflow handler currently does, which is to run a worker in each domain
>>>> to collect MBM data every second from every RMID for both MBM events.
>>>>
>>>> * What are the requirements of this use case?
>>>
>>> Accurate, per-RMID MBps data, ideally at 1-second resolution if the
>>> overhead can be tolerable.
>>
>> Sorry, forgot about the assignable counters issue...
>>
>> On AMD we'll have to cycle the available event counters through the
>> groups in order to get valid bandwidth counts.
> 
> See below.
> 
>>>> For example,
>>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_00
>>>>           <rdtgroup nameA> <MBM total count>
>>>>           <rdtgroup nameB> <MBM total count>
>>>>           ...
>>>>
>>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
>>>>           <rdtgroup nameA> <MBM total count>
>>>>           <rdtgroup nameB> <MBM total count>
>>>>           ...
> 
> How about:
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_00
> <rdtgroup nameA> <MBM total count> <timestamp> <generation>
> <rdtgroup nameB> <MBM total count> <timestamp> <generation>
> ...
>>>>
> # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
> <rdtgroup nameA> <MBM total count> <timestamp> <generation>
> <rdtgroup nameB> <MBM total count> <timestamp> <generation>
> ...
> 
> Where <timestamp> tracks when this sample was captured. And
> <generation> is an integer that is incremented when data
> for this event is lost (e.g. due to ABMC counter re-assignment).

It is not obvious to me how resctrl can provide a reliable
"generation" value.

 
> Then a monitor application can compute bandwidth for each
> group by periodic sampling and for each group:
> 
> 	if (thisgeneration == lastgeneration) {
> 		bw = (thiscount - lastcount) / (thistimestanp - lasttimestamp);

If user space needs visibility into these internals then we could also
consider adding a trace event that logs the timestamped data right when it
is queried by the overflow handler.

Reinette

