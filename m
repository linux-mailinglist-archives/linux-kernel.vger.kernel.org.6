Return-Path: <linux-kernel+bounces-400518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66D9C0EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCEC1F27F81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB73217915;
	Thu,  7 Nov 2024 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxUmihLc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09C217670
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006908; cv=fail; b=BdO++pH9OC+e1z8kgZ2OseQcLfvX2NGlEaqfgFRmxoZWclKML8Sh+NHfvmwAZQNr5uag2+eH1n3/neUkNIeyIoGu/o5rb0Q+cjYnRREIMxBsGVHRDVJX+WItTupzkD8BBkNO7rFRtm9vbm1pdbUCPY06KbDx/voe/2aXAcpYRp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006908; c=relaxed/simple;
	bh=q4dYX7Tnp8ostrctp7LsSfKKkPPbPyIU2Pp5ZS243LU=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhuPwQ+oVihSY7LXRRD1IT8+v5Sd7iKhwk6o0bs3Ao90mP2ZRsSPu93GYZPRukSmMbxVEpJB/da/gE1ndNEyoHVOJb4UgU89m+KLggPAUS/TyqQL5e9bh5VbqAsAAFcMy5XueKRL1WTetBfnghxxTKxHlsZKTnhHSq+J2JCVJbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxUmihLc; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731006906; x=1762542906;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q4dYX7Tnp8ostrctp7LsSfKKkPPbPyIU2Pp5ZS243LU=;
  b=mxUmihLcDJt/BEQncMSmH6QKJRDt9RmHsfxaZsAJrc9vVdBhUQmg/ozl
   aJMsELrT8UzJuvkme0gbfLHhuMLB6ebEFQa1j4OdhCGMh4IWCHhehEuSY
   xsPA/pfqKhcFWVOmXUha3AUQ/NtDp7Z+AaL0Z/XhdBzLSbixLT2DydsV+
   BBAdw9q6KnUK3t2oajbxYCK2KRU8V4KHdyZDeBKgCpJNg+sjE2UGi4ZG9
   rZfiiOs6PVV6JPLkhMgjraHwDc5oUMJaRfLThV64OeXCzZ7kUuAjsehKf
   bb0s+SOaHwktvTKmTBUsx6E3hQtNJCrbOH8au+E6DecymwpGlif6xvVXp
   Q==;
X-CSE-ConnectionGUID: C6HKsox8RKaaookGs/Jsog==
X-CSE-MsgGUID: 8mRlIk9yT0CNWMe8qfv3Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30273117"
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="30273117"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 11:15:06 -0800
X-CSE-ConnectionGUID: lMZSyntxRLeHyhZxOwDHQQ==
X-CSE-MsgGUID: 8xsDxK0bTEOpsykFWfBqRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="85350139"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 11:15:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 11:15:05 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 11:15:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 11:15:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDdhB299OyJWcPQvuEUS49Q99Lk/xe2C2S05dc03VtVhFApDmR4A9QtDSTX+I2eRbZbJ3y+XDKJHBHRv4ZV8UbKeF2PAbtTmOZwPTLTZGGatDfBC3w5EYiJZko8zDOM5Y2nNMAZ1QkT4BQVVcwp3sWuHP2dYjhZoXE9LZoATp7YHGAsScFwEP4/mVYzS3kXlCY4yK/AR03fFAZvMP0wlinIjdI0UUr86RvYw917/RLRZhYbt9iTw9GkP6MoPqNjCnqZJQJO+jvFZ/KnM5RY9p/ez2qhp4I/SPv81zpHwx0+Y0IH1BZaPhBpNjMG6mm0zMXuNvAlSR7dK/KBahrSMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRIkdcYIAfBH/BiMO0aVsp7iG9ewKHbBn11A2w23ANY=;
 b=fxI0hKBne4oO+oC6x51Nkh6BnKd8lyAIN3ThUFf/OvrK/oGVCdeGjtwVDQIgsKvOtTOAgYWl0KEZ43Rfk4D4bGtUNrW6JX7L0EIrUDa8QZarbTS56R7polZGt9gkvCTRd8JmjrOnSZTxTVxzlVQF7ncnB/7on5xG3XiaB9u9IJmSzbbrTseU9vaXHcNbjC3gT22j8tvfbyJZxtHDJeYekPl32Jkat9G3Suyr0zcUmXVDBDPnst7FsWvXJoOCcFICcQ32FdkTYpsbr9G5OmXi2FEsLKAEJAeFgLlZqoNCca2xqRwVykRe2eSHg6wKiymcYtMIPUIhAX5ceCOgb+S6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:14:57 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 19:14:56 +0000
Message-ID: <34fd8713-3430-4e27-a2c2-fd8839f90f5a@intel.com>
Date: Thu, 7 Nov 2024 11:14:54 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: Peter Newman <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <eranian@google.com>, <hpa@zytor.com>,
	<james.morse@arm.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<nert.pinx@gmail.com>, <tan.shaopeng@fujitsu.com>, <tglx@linutronix.de>,
	<tony.luck@intel.com>, <x86@kernel.org>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:303:85::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5292b1a0-b2b5-421d-1da2-08dcff607789
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2dCN0RYRytieGhHb2hTMDIxS0I5UEdzdWNIQURJSWhrdnVScDBGVTYxN2dX?=
 =?utf-8?B?ZDEzVjJiYlQzQTE3YnBUVXdFa0NtV3hjVUxHZ05JKzUzR3RaMzB0WnJTaFpJ?=
 =?utf-8?B?ZkxuOXc2NWVKbWFHWWNXZWhiSG5qMjZNSnBtVElQWWlqUmUrMmxjTVdzUWdG?=
 =?utf-8?B?UWJ1SEZoQ01udzVjOTZPdjhwZUV5eFJZNVBoVi8wK0lTeFJ6cWVxVUlxVytS?=
 =?utf-8?B?cGxwQmd6Q04yVms1aDNVUFErV2xYKytBSFFnbHBFRlF5MmltUFVzUGRTQWRw?=
 =?utf-8?B?dmVyWGlNT0J1MTlIZ05qa0JhVHpLTXJ0NVZrUzF6OEdYeDhKeEtpZUtLWkRy?=
 =?utf-8?B?NzlqY21BKzd1UDZnWnVzbUJvOEtTZXFOM3l1REM2NU4vVThJMWQvR1NKY2JT?=
 =?utf-8?B?YnNyTzdXV0ZQVmlyOWRBMHFqeFVqY0lXaEFjVzRyaVRnNTZnSmY4L00zU1Vy?=
 =?utf-8?B?dVdBVTd3SVRqT0NwQXVQRGlXUjhmTFIxa0tUUzh0dW1OVWVLMTYxUTgwK1FI?=
 =?utf-8?B?cFNPdjAvcFhUa3JsM005Wnkya2hFaVgrYVo0eG9xSVRXSzdJc0FZTG1rWVRv?=
 =?utf-8?B?UzAzOWxReUd0cVFTM0cvN002bDE2N1hnSEU3UkF3d0pYQkxJNDlnMzlrTDhy?=
 =?utf-8?B?dUxjdzB4dnpUMzBCUE1zQi9IN1kzQ0lzSXYyNmdjcTZVajhFbmRtUit5eXZM?=
 =?utf-8?B?V0hJekNJMWR6NDJwOTl1NExzYmRPVEE5WkhhZC9vZXdQbTNxOWxVKzRDZXh3?=
 =?utf-8?B?UjhFbytvNTg0OS9GQ3ZNL1A5Q0U3Zit0Y2RxczBVQ29NcTNTd2JjdW1Fd0hK?=
 =?utf-8?B?bmY2Z2xqSXBPM2FNRTdUdld3eFA5amdmTGV1TkpEZUZyRDEzZlNxbHYwQUs5?=
 =?utf-8?B?cmdhQkdZVDRmQVJ2cHNiRllVTENJQnAwd1ZCcGtpaVlqanVHMUhoY3lQY0NW?=
 =?utf-8?B?YlM4VkE3VnRGNTBWK0JwRDlkWXVOUG91aFlYVEludkRrY25IcEJqNDRBU0lu?=
 =?utf-8?B?VUFGd1JTK3diM0lWUlR1ejdQbEg3WkpUVk9NTklIblpsZE0xL2ExaTVPNnd4?=
 =?utf-8?B?OTdFZVZSM05XWE9xbUd5Zi9aQ212NXhlUXZMZlR3dG0rTVVETFVrVk9NaDA0?=
 =?utf-8?B?VVNXL3kyd2hMd1hISVlDWVJuVlRGK2ptVDhKYmZrTjB1a3VpSC9YMW10ZkEy?=
 =?utf-8?B?UXcwclZlVHNMN0QwU2UvbnlNNWtDWHZLdGFwSlpFNUltYjMvT0JTU3R4bHZB?=
 =?utf-8?B?WS9CaUdEU0xzVkhGQWMvUDBma0VuVVFlYjNMNGUvM2Q4eWk2cGJWR0Z1NGJh?=
 =?utf-8?B?RmJUc0dNWHEwcjlIT3dIRXB6NzJKNVc2dmxvYXVyU2kyU3F2ZFNPdTlpcElT?=
 =?utf-8?B?TGFMM01mU0Y4bWNmd2xzMTZ1eDhhaVFhQlVGYkkvOGdjNDFraFphZTJ4RVMr?=
 =?utf-8?B?UWhVTjFERWxKeUV6SFpSRWlTNlFFcHlHd2dXcm9FblZ6ZUtoNDVwcnVYL0tH?=
 =?utf-8?B?SGRFYmoyTVVFU2xUWHpRMzk5a1JnMGIxZHRoOCtTWTViTXBVWkpsZG5pKzRw?=
 =?utf-8?B?RVVJdGpYVXFvRWxKdlFYb2FyazEwTUt4NDRNbXJ2MW5RUG5hZ3N4RndreGdE?=
 =?utf-8?B?NjZZUTVnYmd1Sk9qRnBXem9IWTR2V1p6Vy8zTjVxOXdhWkQwS3FGNkFuZWpt?=
 =?utf-8?B?RzBkMHBOc1hRVnptQzFsbW5GWTY5ZlpzM2ZzWmgzM3pGSkI3Mi9SWk1RM1Z4?=
 =?utf-8?Q?HmQzWI1/sCnN/s/ZNysvPnlz8Y6o+O4+4r+AqiL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRndElka3l0NmNub2ZhdXdxQkx5YWVONjN4NUVyYncrL1g1c2dqelo1ekJG?=
 =?utf-8?B?aTh4UXZZbnhZdjd3aklmYzl3VTc2K2wyeFBFZ0JsWXlqbDlKOXEzWTdQNlBI?=
 =?utf-8?B?WXNiQTRTSC9iYVJ2SXRMcHcrUEpmenYwYWo2NEJLVmdYUGRrZHMvTktmVmpK?=
 =?utf-8?B?S0NFZ0p4dzlGS1ROSE5UQ01IdFVLQzlhZ3QzbXhDUmpHV0JrM0E3Sk5LaVZ2?=
 =?utf-8?B?bnpNak50dFlidEJYVkVMbkxHb2EvbVBhMGo2cW9EZW1tWUtvNmlIdENJd3Ft?=
 =?utf-8?B?UjFuQmwvQUJnNkh3SXRrellYM1VQWHhyRzhtT3NKbVlnYkxNVk1PdnVOdE9P?=
 =?utf-8?B?Ymk1NGVtb3NDbStrcmZyRVI2ejNFTFVSeWJ3cTZ3ZWMrc0dsY0FvNWZsWDcv?=
 =?utf-8?B?TlNSTlArRnpUZmtpZ0x3K3BjQXJFY3BMM0U2WlpBNGZyOHlGQW5aa2tqLy90?=
 =?utf-8?B?blp2WThEWGZnbTVjNU1oRGQ5bmlGYWdpSzl0UTh3T1EvSXVGM0tqZHl0bEFH?=
 =?utf-8?B?UExWUkZNSDlZTXJTMlRLQnhQU0prTXBpdStGUHNWR2UrNHZMSzIweFNaMDY2?=
 =?utf-8?B?RnhsdERUcU40a1Z6T1FrUFpJdGI0MUY3VUxnU3pIVVFHT3pjdGZ5N0kxalh4?=
 =?utf-8?B?WnVMTHYvMjIrNWVLTnhjRFBTTHdNOHZvRkNMOHh5eWpjRjM2ZDVudUhTaDQ4?=
 =?utf-8?B?czVlckw2bWlqeHQyUDkyTXpmaUYyZE5DZUVrSGc0M1hPTC9mUGFEQ2s2U212?=
 =?utf-8?B?OFl6NUtiR0ttSmo3NGtuOGJZR3JKNnFwbFNKSGF0ZC9ab3QvK3I5K0Fjc1lq?=
 =?utf-8?B?NGNGcmg5c2hvV1dlcEZwazNHaWhMSFNiZGg2SUM1a2pKbkRFZXkzcHpqelRQ?=
 =?utf-8?B?ZFA4bklIWjhPc21OTHorTnV3UnlTM2dORnFvem03L21BUzRuRlk3K1N1NjJ0?=
 =?utf-8?B?dURGeHZaQTg0enVlQVk0WGRZenE4SzliSzNZa2svVHR5KzJOelBXM0YzRkt6?=
 =?utf-8?B?dit6RFFTOGtpQTBwd1hHT3RtcXBvQkRBOWVBTmJCcGoydWg2YnZSTEZ6cEpF?=
 =?utf-8?B?OTBtZExobjJjUHZKb0hXU1RDMUNWZU5BR1d5YnB1dG50ZnJvQVo3SW5SNU5H?=
 =?utf-8?B?d29HZlQwS01YdGEyOHMwRk1FcUNiZmoxQUEwTnNPSDZ0bVNzODQ1RHRtdEVP?=
 =?utf-8?B?enBaQ25TSHRDclZ6SEhkdlRPdTVEQ3dPZjhDRnVDOWI1OW8vbzJ4OUQ4T0Nk?=
 =?utf-8?B?dzRKZWxnUHJOZG9iV0ZaYXg3Z2hCWG9hdTV3bFZwUmFhck1QTXQwdFpPbGVa?=
 =?utf-8?B?WjIrQlVYWlU2a2JOQUJkZXVuWTJZNDdFWXJIWGpYRC9jR3cwQ2FMMUlYcHlP?=
 =?utf-8?B?U0JiTmhqY3djQ21BS2RGeHpveEk3d1RPQStTTUYvVVV4SkFkWTI0YXppLzJy?=
 =?utf-8?B?eVdLMm9YSUw4K1Q1Syt0czhmOXRwbFYzTmNCVytBTXJwRVRlZUtuREwrMXdS?=
 =?utf-8?B?d3BML2tPaHRFcWNJbnpIZ3BEVEkySnhKeVNwVkwvbTlEdjFnMHRWd3RLOXhZ?=
 =?utf-8?B?Nkw5OTFtWWVtQjBpTEFxTTVTZEhhaTUwTDZsc2QwT0RhZ1ZWQjdCbkt4b0pn?=
 =?utf-8?B?MzBlelh3b25QUk5SU0grSXQ2aktMZlJLMk1VWWgrWnhnbm5DMWZ1RU5tUTla?=
 =?utf-8?B?S2hvYkkwdXdpN0d1R1Y0ZWdTTnFZQ0FyOWJWTTJxSG1jRy9HY1Z0bDJsZEcz?=
 =?utf-8?B?RThnWHRhRGEzeDIrQVd5UUJYLzRLVm52RnNTM0NDeWlKVkhSbHFzM3QyOUtX?=
 =?utf-8?B?THVJdXJPVFhpdDltQjVFVVV1VDhIS2F6VmNZdnRmdVJjMGFFWkVHVEhHRjlW?=
 =?utf-8?B?MkJJeFJqckg2aFdBNE1vKy9pNUhRYnppU2IzNmwvK3B2a0pRQ2QyQi9oR2to?=
 =?utf-8?B?SXVtYVlzbXJvekUzT2NDeFdNU1dpcmxVVjdBc0NwbC9LYVJzMGsyS3F0N3do?=
 =?utf-8?B?TWREUmxUeGRMclVQTXY0NzQxeFNMUVFBeTZJdnA1VG5IdzQxb1E0UENHMXpR?=
 =?utf-8?B?eG1uY0EwUUx1aHFtWk01Tm0xaDl3a0tYQ3g3RUlPcFRLTHVScTNPWSt0amdh?=
 =?utf-8?B?UUlkZFBPcWtOa21BYUwwaHJmdHA3UU5MVk1PSHZ0R2VVVU1lY3ZNQW93c0pX?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5292b1a0-b2b5-421d-1da2-08dcff607789
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:14:56.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2JP2oGToSo8Alncv+l+qqs0pMX66ng/z82973qWKockfE43Z7ZsBJwD7QFIf6HQVyWrIQKGy/nBCNu9tkYRX2nQ90nL7QMEw3YX5tH1fLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com

Hi Peter,

On 11/7/24 6:26 AM, Peter Newman wrote:
> On Thu, Nov 7, 2024 at 12:01 PM Peter Newman <peternewman@google.com> wrote:
>>
>> Hi Reinette,
>>
>> On Thu, Nov 7, 2024 at 2:10 AM Reinette Chatre <reinette.chatre@intel.com> wrote:
> 
>>> This sounds as though user space is essentially duplicating what the
>>> MBM overflow handler currently does, which is to run a worker in each domain
>>> to collect MBM data every second from every RMID for both MBM events.
>>>
>>> * What are the requirements of this use case?
>>
>> Accurate, per-RMID MBps data, ideally at 1-second resolution if the
>> overhead can be tolerable.
> 
> Sorry, forgot about the assignable counters issue...
> 
> On AMD we'll have to cycle the available event counters through the
> groups in order to get valid bandwidth counts.

ack

> 
>>
>>> * Is there some benefit to user space in reading individual counters?

My question was poorly worded. What I would like to understand is if there
is a requirement for user space to keep being able to quickly query individual counters
like "query <event> of <monitor group>" or would it be acceptable for
user space to get a dump of event values of all monitor groups in a single query
and then post-process to dig out individual counters? 

>> The interface is available today and can retrieve the data with
>> somewhat acceptable performance. After applying this change (or
>> selecting a kernel version before the MPAM changes), call-graph
>> profiling showed that the remaining overhead of reading one counter at
>> a time from userspace on AMD Zen2 was around 20%, spacing each series
>> of 250 local reads by 1 second.
>>
>> With the 1.22M figure I quoted below for a single domain from
>> userspace, this comes out to 488 usec at 2.5 Ghz, which is manageable.
>> Even if userspace serializes all of its per-domain reads manually to
>> avoid contention on the global rdtgroup_mutex, the results should be
>> consistent as long as the domains are always serialized in the same
>> order.
>>
>> (apologies that my figures focus on AMD, but its high MBM domain
>> counts make it the most sensitive to read performance)
>>
>> Also, if all of the counter-reading work is performed directly by the
>> thread, the time spent collecting the information is easier to
>> attribute to the management software rather than appearing as an
>> increase in kernel overhead.
>>
>> Clearly not optimal, but an acceptable baseline.

Thank you for giving this insight.

>>
>>> * Would it perhaps be acceptable to provide user space with a cached snapshot
>>>   of all the MBM counters in a single query?
>>>
>>> User space can use a single read to obtain values of an event for all RMIDs
>>> on a domain without a single IPI if the architectural state from the overflow handler
>>> is exposed. It could also be possible to present data from all domains in that single
>>> read.
>>>
>>> One complication I can think of is that data from the different domains may have
>>> been collected up to a second apart. Is this something this use case can tolerate?
>>
>> This +/- 1-second drift would apply to the denominator of the mbps
>> calculation, so it could cause some very large errors. To produce
>> accurate mbps numbers from cached MBM count data, each sample would
>> need to be accompanied by a timestamp.

Reading more it does seem that making the raw cached state available to user space
would introduce too many problematic corner cases.

>>> For example,
>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_00
>>>           <rdtgroup nameA> <MBM total count>
>>>           <rdtgroup nameB> <MBM total count>
>>>           ...
>>>
>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_snapshot/mbm_total_bytes_01
>>>           <rdtgroup nameA> <MBM total count>
>>>           <rdtgroup nameB> <MBM total count>
>>>           ...
>>>
>>> If the use case cannot tolerate data up to a second old then resctrl could add new files
>>> in info/L3_MON that will take the mutex once and trigger a *single* IPI to a CPU
>>> from each domain and read all events sequentially (which is essentially mbm_overflow()).
>>>
>>> For example,
>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_00
>>>           <rdtgroup nameA> <MBM total count>
>>>           <rdtgroup nameB> <MBM total count>
>>>           ...
>>>
>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_01
>>>           <rdtgroup nameA> <MBM total count>
>>>           <rdtgroup nameB> <MBM total count>
>>>           ...
>>>
>>> As I understand an interface like above would be an improvement over
>>> what can be achieved by user space by optimizing queries to existing interface.
>>>
>>
>> Yes, this is an option now that the ABMC work is establishing a naming
>> scheme for groups. It would also significantly cut down on the number
>> of open file descriptors needed.

ack.

>>
>> Tony had prototyped an MBM rate event[1], which cached a MBps value
>> per group/domain produced by the overflow workers. If the workers
>> produce the mbps samples immediately after directly reading the
>> counters, then this should be the best case in terms of precision and
>> introduce very little additional system overhead. Also, userspace
>> reading a rate sample that's 1 second old would be a lot less harmful
>> than performing an MBps calculation from a count sample that's 1
>> second old.

I looked at that implementation. Please do note that the implementation
appears to be a PoC that does not handle the corner cases where issues may
arise. For example, when it reads the event values in the overflow handler
the rate is updated even if there was an error during the counter read.
The moment a counter read encounters an error it impacts the measured
rate so this will need more thought.

>> Perhaps combining the per-second bandwidth rate cache with a
>> per-domain file for each MBM event to aggregate the data for all
>> groups will be the optimally-performing solution?

I do not see a problem with exposing a per-domain file for each MBM event
that aggregates the data of all groups. For best accuracy I expect that
this file will be created on demand, querying hardware counters at the time
user space makes the request. This may indeed result in output like below
(naming used is just a sample for this discussion):

         # cat /sys/fs/resctrl/info/L3_MON/mbm_current/mbm_total_bytes_01
           <rdtgroup nameA> <MBM total count>
           <rdtgroup nameB> <MBM total count>
           <rdtgroup nameC> Error
           <rdtgroup nameD> Unavailable
           <rdtgroup nameE> Unassigned
	   ...

As I understand from your earlier description this essentially moves the
counter reading work from a user space thread to the kernel. There are
options to do this work, most disruptive can be done with a
smp_call_function_any() to read all the domain's counters from a CPU
in the domain without any preemption, less disruptive can be done
with smp_call_on_cpu(). Some cond_resched() could be included if
the number of events needing to be read starts impacting other parts of
the kernel. You already indicated that reading the counters from user space
takes 488usec, which is very far from what will trigger the softlockup
detector though.
 
> Factoring ABMC into this, we'd have to decide the interval at which
> we're comfortable with cycling the available event counters through
> the group list in order to get valid MBps samples for every group
> often enough.
> 
> A counter will have to stay assigned long enough to get two valid
> counts before an MBps value can be reported. If the regular MBps
> samples is what we want, maybe we just want a mode where the overflow
> workers would also drive the counter assignments too in order to
> produce regular samples from all groups.

The assignable counter implementation currently depends on user space
assigning counters. In this design the events that do not have counters
assigned return "Unassigned". The "rate" value can also return
"Unassigned" in this existing design. "Unassigned" is one scenario that
needs to be handled, there is also hardware errors and MSR returning
"Unavailable". 

We can surely consider a new mode that does not allow user space to assign
counters but instead lets resctrl manage counter assignments to support
rate events when assignable counters are supported.

I see a couple of features being discussed in parallel:
- A new per-domain file for each MBM event that aggregates the data of all groups.
- A new "rate" event built on top of user assigned counters.
- A new "rate" event built on top of resctrl assigned counters.

Which best support the use case you have in mind?

Reinette




