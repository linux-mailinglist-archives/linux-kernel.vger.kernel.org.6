Return-Path: <linux-kernel+bounces-413320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A104C9D174E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0711F22A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2367C1ADFF9;
	Mon, 18 Nov 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4E1/GCg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2FEC2;
	Mon, 18 Nov 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951595; cv=fail; b=SpZ/Ml4FzfVlXJAcoEnDmn1l1K5BHhc7AMuf9kz3EXiXhrE6rbQ47V1mLgq+MXJUU0X33VxnK/ARo2t7O1tNG18h5N+EsMz3+pn6fbVm9ygiBkfZ++nt6hMJKLNmBz6bh8ZHWA3KVax09VvEKRdOO+O+82U1XsaMWur6ynBLmfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951595; c=relaxed/simple;
	bh=mMIkUN3L4OlvVv+SSBiG7bga4EFbOseEer692Mab0dU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VY4UNY8WiynqIe+aeTJqLnHPJ0rroO892rfNQ5mXjceDFH4TVYC9X03MExzzi3mwwFQ8hahj+Zo+Yg8jX3I9KK/ZdKhS7IXyL15vUaZ1WPBExwlx7ozQx8VbkWXPUlMztu/WwVn0oTYHccWATGt8ynxjHT6uDe5ArNGvYQhi5rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4E1/GCg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731951594; x=1763487594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mMIkUN3L4OlvVv+SSBiG7bga4EFbOseEer692Mab0dU=;
  b=i4E1/GCg/8B49xdQFCL3c5XYn89Xm2zrck2dE2h0oqM6hgFYErRp3HvN
   Hbz2xJ+zVyxC2wXASMhIT2yyYO25kXoFpQbMXjEL7mjUXEHc7ggc80BxV
   DDQBqYM33NCwok973Yp0XSIH2sDfd/EfB9LkiZzjwqjog/Ke6Cw5dOFdq
   clM2W6FrUsqJ2wpjRLnXy8w6L///B5s2RHRbu6F0tjv0U/9tTnD4GOSZE
   EoVRiOoEW6mzuKBWGPQn6GdQiwCEkbuZMwQH8p0hyVheSdsWDnrI63Fzq
   IJfTF+YxMOeXIWnebP2qhtwK9RJ8HfRQaGDZEbBrm49rJufksDgg2XCFX
   Q==;
X-CSE-ConnectionGUID: oArOD6qTTPONRf5NdZY6UQ==
X-CSE-MsgGUID: bTBcLZF0QP6hOhv4pLthdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="49458640"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="49458640"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 09:39:53 -0800
X-CSE-ConnectionGUID: 31LQcXDVRHi7LnBv+HQvyg==
X-CSE-MsgGUID: 0ap4XG9JT46ec0hrzA6MZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="93358657"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 09:39:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 09:39:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 09:39:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 09:39:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY7RWCBIyRtvYtoFHiCRKiTCWlCfUq5CebOs9ddWTv/wNNKFngO5Dw5hM+uiI/wCX7z84ZVrn2BGA7SeXg6Z62Pffe/IPFyyF06Ys/LrvkMC2/Ij7VOoUPcHxT3xkI3PIP/RJPAhYN+ojbXgKx+Pni/GHXPpRk6zmxGYKDFGXhMKV+WJodSFeJ8uC5WOyyNA1wDjjHnktznBvuHCafnKvXLjLSmo/cFTqIIXl1xbkxhIDU1WpO7rwNjY1Q76pPN6vdFgyKRofigYYYOKraUQfpWFNWuUi76W7a1oaW4pqiqjxs3Vq3Gqj0Wg7smH95Q55DYQz/bSM9pdQAu6jKKBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVbu03EPRrfU1hPscr4WlcqsJfPn7lfcKUxSaQhBiUQ=;
 b=yuBQms6riSTTnqD58vXz2jVIzLN+D8BojYICDU0etnP9OpJ4Z0vptNKSzG8xZmXuoGnsBdNIRlni/o9ONWcC41+untGTAM8u3Ir26USFnfkBWCaODSn+NYWWlM8zbSEzQFkYbnKKSWVJaz+48sQfTK2W44wDFPzz1XZ+/mwGDOy5yfKG7A7+pJxCzkCDbMcJrMqC/kcnS/aEUHK6seE6H9BvAXdDng4rBAB5EM20xfniAyQs+TCF8w9h/IfAd9CH9TwtD7HXHNH39HRf053rh4lyR3GkjonjtKh2jJjoOclCNcaB8hRDLzxcjTBmEQtpLbDAKZfUje/v7Hi7QRvRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8696.namprd11.prod.outlook.com (2603:10b6:408:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 17:39:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 17:39:36 +0000
Message-ID: <ae12f5d7-2f38-4f38-ab19-0875bd393443@intel.com>
Date: Mon, 18 Nov 2024 09:39:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 21/26] x86/resctrl: Report "Unassigned" for MBM events
 in mbm_cntr_assign mode
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
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
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <fcc0d1cc4e0f60626417b0c3bffe7638d6de9071.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <fcc0d1cc4e0f60626417b0c3bffe7638d6de9071.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b29c20f-dd1f-45d7-b802-08dd07f7f7ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEQ4NVlyOHNNK2Q2UytmakVNaTZDMDd6dExONXMrNGhaN0lVSzR6aEVRQ2NJ?=
 =?utf-8?B?WkpvNlg5NmFQMHIyakxYWkl2S1lCbElwdTRER3FMSGI0VWh1Z0N2R3VPUUt0?=
 =?utf-8?B?elRvQ3BNeFVKYWhCTHNsOVE4Q2N4OGx4Y1FiMkZ4Ry84QXljaEVyckV3RjVy?=
 =?utf-8?B?VnNRbnVlZ2lmTVB5elVRRU9sRXBlbU1ZZG5PTExRSWp6cU5yQm9md1F3VlBN?=
 =?utf-8?B?WGlsd2tEdWNjU3VnclhpMFM5TFVBRTRaRktRRzY4RDBYakJpRWdiTFh0VS95?=
 =?utf-8?B?T3d0Q2E2czhCelA2dXNmM1JnQ284SUkvQWpuRUVvb3grNHRWaTRzNnN0a2Qx?=
 =?utf-8?B?aW1VT1VyN1ZmZzR1bllxd01sRlJKQlhiYXJqYW9GUmt0YURNWlluanptdnE5?=
 =?utf-8?B?WVR5U3FNcW5QbE5CSnpkbCt1SmhsTDgwK3dUNmtzWW9iZEdGQS91UHczNDR1?=
 =?utf-8?B?V3dxcFRMY0J5TXAvY3dveVZhVGpJRzYyNC9OWUVNbk41alFVNUN4Q1ptcm1p?=
 =?utf-8?B?YTRUQ2hURnZ5a1lsQ0IvWHMxMUdYaFp1K1Nzd1pEVUVLN09sclRORHZmcjJ0?=
 =?utf-8?B?b0N4MVZMcWVUcWVMbGRBK0drdHg0VkIvWGdyb2thbmgraVV0UGlPTkUreFJK?=
 =?utf-8?B?eUZVQVF6R2NLbTd3a1MrT21QalBJQ0ZFeWZKNHhMKzZQU0pUWk9EWTdWM2VY?=
 =?utf-8?B?T01MRWZCLzRyN09VaTFiL01TZDZNWXlDMCtqbFM3RmhQODd0UGVMeGlrQUlV?=
 =?utf-8?B?Y2RYalltVjE1by9qcmJjRzV5UjBWZU5zQkF0Y2NIVWVycUczMjA2Y0lJL1du?=
 =?utf-8?B?YXpKR3RYSVBmTHVxUHYyV04wcWxHQVo3WjlUcjl3aDFyVUdqc1RjUFZwWktU?=
 =?utf-8?B?UWIxWTM5N2d3andEY2N3ZUs4OTNleHVKUFBtRDNISTJWajd3dXV4eU45cFda?=
 =?utf-8?B?TTk2ZHJ1T1BkUWQzN1ZidkZVSWorRGtBV3ZIZUxJSGpFN3hkK3JldU9acGlj?=
 =?utf-8?B?NFI4bWpuZXRZc1ZYMmRBYVo5NXlpWGJBNzMvNEhLYTFMdi81Mjl0akRBMVl2?=
 =?utf-8?B?RkVBYUltYmpOT3RmNHMwN21SeGxyMFVRL1J6VzQyWGczb2Nybmg0WXA4eXpF?=
 =?utf-8?B?b1Vzcml2V3FqbmtGNFVFQi95aHk0a1Nla1dzNi90aFhhR1lrS3dyQWhPTVY2?=
 =?utf-8?B?cXMreFYvaVFFOS9zODBMbWM4TWJ4SGdsRm9sRWRGb0lOTE9WQUFLdGdvR2xn?=
 =?utf-8?B?YXp3V2c3aEZtc1pCSG9xQ0hOSVVyZW5qRHh4SDJ3Q0J1b0hYOEEyNXlGR2Zk?=
 =?utf-8?B?bERybFpKQmNraDdEZDBiSDJlUExKSUs5K3JTL3BNMXJsVkEzWjVCZGRiTTVW?=
 =?utf-8?B?Nld0dE5sSUJodUhhaktSTkZFQUZlcGpqVzBTLzNuYWtqa1VoYnFtUmh6N1dX?=
 =?utf-8?B?cTRKZ1pTaE9QMFQrcXNSS2t5Y2lRYXZnamFwYXA1U0NKbnlBV3ZscnpUSXQy?=
 =?utf-8?B?NnB2MGoraUpqQ3ROZXo0aXZIL1dXcVh4Rkp5bjlXZjBDenNGUDV3NFlTYnJD?=
 =?utf-8?B?S1MyekVWekZmUGgxc25oellvbVJyY0ZIK2dnQndjVFFkOVJZejdIUkEvLzB5?=
 =?utf-8?B?dXFWRzkyQ3RIM2dBdUpKdXhIamovS1BVMlVMMkNFS1BxdExpcjdGVXhTSitq?=
 =?utf-8?B?MHJVbVk1cXZ3Z2R0d1E5RE82OExsWlBRcHhHY081OHFVVkhOL2VGWFBQSlBF?=
 =?utf-8?Q?zkOUNXqqakxfeZ2K+PFzQMmvTJPA7w7aPIu3hPu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDRwUFNNRVR3N3R1aWgvUmtUY05hbkdyMkIrSHBuNXljcTREWHZSSlRlTTV1?=
 =?utf-8?B?YS9ZUy80NzYwYlVqTWg4L3l3QlhGUG9OWWJsVnRrQUZTSkxOTjJEb1ZsM0tD?=
 =?utf-8?B?ckVGaUU0dm81SFFhZDZyRERWdTZuME5nUEFlQ2pFMXE0MDZDVWNvVW5JUkF0?=
 =?utf-8?B?ZmVZS2lwcDQyTk1LNm9iU1J0blRTQjI1TVlRQ1o0dDMxWWtYYUdKbFQzR0Er?=
 =?utf-8?B?a0lmVyt2NTdjbXZQUHhkWFY5SGs2T3NTMFpLaXh6WS9rTEttZCtBS2FMVEhM?=
 =?utf-8?B?N1kyWGszSWQ1V3ZaOFZGN3hhQ3RVUk5uS0RxT3FCSmFvWFBGU2E0bEIxbyto?=
 =?utf-8?B?T3lNTEpnZCs1dWl0SFd5U3VLb2dTT0tHTFVIMWZxdzQvVEpOSzFoekpSUkgr?=
 =?utf-8?B?NUZYY0JsYjZOaFpJUzVpSmVMZWxFdkpuQW9KVDlacmF4a3ZIbGV5YXVHQWh0?=
 =?utf-8?B?YnUvUytWbHNZNkcvUytXQ1FsWEFhM21RNm1lYWo5UVJxU0RQNDVacWdUT1Jr?=
 =?utf-8?B?SERxMExwRFJ2ZllJY2pCVlpabE05NkhvcTFSSlhDQk5YZ0dwYUNuSnVUTnJO?=
 =?utf-8?B?ZDdncDdBNHh2bEhNK3RDVXAvclhCVUVzZ2xPNHVyS0dUY284ZDRLazA3YmVB?=
 =?utf-8?B?WUFTUElBTGV1TCs3SU9MRTFJOVNYRHVXdmIrTHlLUGR0aEpoZU9QRUV4VnR1?=
 =?utf-8?B?T2dkdUhjaS8xNHRkbDljVnZWS3dRS0dRMFNRb2hxNXVCQ2FmN0NiT3d0ZmM0?=
 =?utf-8?B?SjZpUmN1b2YyNUFpSW9KZHRSdlBHaHVxUEJPUXJIQ3U5Tkp0RkpOcG5BTHNu?=
 =?utf-8?B?N3ZNVE00L3M5bXlKL0xOQmp0ZzJmZGRBNzRkbjRQQmdEaWNOOWJ4Snc3Z3RR?=
 =?utf-8?B?bm5nbjZLSVUwWFZyU3ZRQ2ZXZHFvRW53WjRsNFZMdGZoS0lia29qZlphZG1E?=
 =?utf-8?B?NXlVa0hoZGYrS3BPc2lXSnBEOTBadEptaVRibDdGWG92M2ZmNHc0K2V5ZFNz?=
 =?utf-8?B?d2FNNWdOS01JVXdLWWczS1Y5NkpCbys3UDkxc1p6U1hiN3NFTDZjOVJlRG9a?=
 =?utf-8?B?WXB2aGwrS0ZKSm13RVp2R2hRRGVIUkU5RTNnaVh3aiszckQvalBaVFNsbEo0?=
 =?utf-8?B?NkR0YzlnaGNZbnFMeDZkSnRGMEE5d0xBcDZld3hacTZ0VmZTeFBJN1dBQ1Q0?=
 =?utf-8?B?MksyTTREUVVteE41aVFPdWZXTmp4V3ZWaW5pMjdOcWR1eUg3a0s3YTgwZjZx?=
 =?utf-8?B?UzFlcjhsSWpWVmF1VldibGY2bTdTckVCbm5mZ3M5WnRPR2NoaE9nOVhzYXdN?=
 =?utf-8?B?QTUwRkNha3BBNHlqN0xCVDJiMVc2bVpKTXg1ZGhUSnF1UnRXemZxVm5PNklI?=
 =?utf-8?B?VnY2ekZERHpZb3Vpd2RJUVhwSFl1Q3l6YlA3RTVoV0FsU3YwOEFOZUhha1d3?=
 =?utf-8?B?NEpxdHhvMCs3VmFTU0pTcWpyZkJLU3FlcUdxc2JkTlBBcHhaRi93L1piWEpw?=
 =?utf-8?B?cEo0R2lqaCtWRjBlQUIzeFdJVE1oYVhZRWY2VEJkNnluWVdBTlJaNHNJcmhl?=
 =?utf-8?B?MnphQWpsc3RJTG5DZU5rdjVXQUw2TEF3dXhiajNuSXBzMGRrSUJSaEtya1hz?=
 =?utf-8?B?VTRuVW1MTkRBMy8zckhtWGpsQis4WHVKMzJSZ3pxNUFuOGFBcGZYSWRHNmVO?=
 =?utf-8?B?YlNHOGc2aUl0K3NlVkZ5RWlSelhWYnNPSFVTSGdqS0QrdFRsakdTMkdIZHJ2?=
 =?utf-8?B?MXpoeW1wNjk0WWRvMU5QQTRuQStDZUh6bFlWMDlRZHBlN3laU2R3djM3bVNK?=
 =?utf-8?B?SDZDcEZGNmpCZkNZWnpJbzVWVEVhZjJ1cVdSZzEwSmFjU05ON1Y4NXRBZmwv?=
 =?utf-8?B?M2plei8zYXMyMVNtMWdOck5YWUwySDRPSGVoZjVGRlJ0a0ZyNTBvdlRvNGJM?=
 =?utf-8?B?SXYxeUNxeW5NR3lYOHMzWU1KckJNb3Q2QU10cWorb0tqaVJOamkyYzRiRmIr?=
 =?utf-8?B?ek92RFNqeUQyUndmd2tGVnV0R0JSaEt6OUtOcHoyem92ajVEVTdXSDZYeVJj?=
 =?utf-8?B?OTJuSWE4V3V0WDQ5TmxaYkpWN1ZNYWxGdFJvN2xyR3hSTTVzbmI5RlZFODNs?=
 =?utf-8?B?RzRTNTZnN0ErTW02V25WUkhScC93Wm9CMXRjQ0pHNEo3ODVyRm1DN05EcTQ4?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b29c20f-dd1f-45d7-b802-08dd07f7f7ed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:39:36.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +E0tvEPn4GjBT4qqCgXjt6geqgomH0+eoza8xNwAHdLrZDXBXhlyGgyAN6+o1KovRJH4HY/MgWN/SDnhuI2pHZXyZkIj4HHtWkmgt8A9DA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8696
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> In mbm_cntr_assign mode, the hardware counter should be assigned to read
> the MBM events.
> 
> Report "Unassigned" in case the user attempts to read the events without
> assigning the counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Used is_mbm_event() to check the event type.
>     Minor user documentation update.
> 
> v8: Used MBM_EVENT_ARRAY_INDEX to get the index for the MBM event.
>     Documentation update to make the text generic.
> 
> v7: Moved the documentation under "mon_data".
>     Updated the text little bit.
> 
> v6: Added more explaination in the resctrl.rst
>     Added checks to detect "Unassigned" before reading RMID.
> 
> v5: New patch.
> ---
>  Documentation/arch/x86/resctrl.rst        | 10 ++++++++++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 12 +++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 2bc58d974934..864fc004d646 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -430,6 +430,16 @@ When monitoring is enabled all MON groups will also contain:
>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>  	where "YY" is the node number.
>  
> +	When supported the 'mbm_cntr_assign' mode allows users to assign a

Could you please do through the documentation changes and make all the quote
usage consistent with existing styles? For example, in this series "mbm_cntr_assign"
is used in doc in various ways ... within double quotes, within single quotes, as
well as without any quotes.

> +	counter to mon_hw_id, event pair enabling bandwidth monitoring for
> +	as long as the counter remains assigned. The hardware will continue
> +	tracking the assigned mon_hw_id until the user manually unassigns
> +	it, ensuring that counters are not reset during this period. With
> +	a limited number of counters, the system may run out of assignable
> +	counters. In that case, MBM event counters will return "Unassigned"

Please review style for all quote usage, for example, "Unassigned" above is
also not consistent.

> +	when the event is read. Users must manually assign a counter to read
> +	the events.
> +
Reinette

