Return-Path: <linux-kernel+bounces-400763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9BA9C11F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8FE284B0E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBD1218306;
	Thu,  7 Nov 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxqbkAA8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4B1DC04A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019602; cv=fail; b=ZRkXqrgocndBIzMJyqhcnKCPnl36ESTcGLrgF4cMDn0BKNL+WR6V3d4ozAQxz3zxdCoB2tITNn+ju81452fpqE872a+mOGCqOhPz6hck9AsnF4ut2b7y63m0qOzz4Q4L0AzWsQGEmfVF6uqz6O+kK7gT/ogq6qSZMhkMzlpbeAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019602; c=relaxed/simple;
	bh=19j+PCgYMADOV/PZFhpYDGTvqxVBVBKejyBtnfU9Xys=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KDAJcRrskParkwfKYSjH2Brw/1d91FbXDxcOAc3aV5dINyGIKDIinnst1z0q18nUQthwId+OcJ4xzg+IntIGEXXxi91Jviukt76j8rnGS1eBnNBo3CR9EAShzWntpwZm8Ntf6O5/KqVudz1faNoLLSUQ3so/LP9K6NjgEM8XPms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxqbkAA8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731019601; x=1762555601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=19j+PCgYMADOV/PZFhpYDGTvqxVBVBKejyBtnfU9Xys=;
  b=fxqbkAA8P+QwVwX5DRth4m+R2IHsDqn2D0rlAjlyOqaasMgTVWUiOjm6
   fhBk7k3u64tvWNMm9aoG0IzrxxcC1T1LxPnJMPW6CNmvvxzLdkwDuAZqG
   HixPJnkxYIj0uY42gm3BGC0QL8Nyz6cnaQ4mfA4e3b7xJFEWvjkQZIdKt
   itlrRUfaKlAA5iEhJCmZajT+Cm74FBx52caXI5pCuD2OW0IvjC9zyxfhh
   ybUdmzAqKqqcUEwHzLQPGjXEZXvFmm1H4UcJSFgCAHEbQv2GHa0K7K9f1
   ukcMeqr0cWdZC4IQsqK2dnQ9/9TGdo8iz2p3WNpyatEmOL6P91Zw5pTAi
   Q==;
X-CSE-ConnectionGUID: D2oijnn3SvCrb9Dtj7bfUw==
X-CSE-MsgGUID: DX3T9nnwTUqMXbNK5Aiscg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="33736279"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="33736279"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 14:46:40 -0800
X-CSE-ConnectionGUID: vo36lmw2Ssy7aU7t6v22jA==
X-CSE-MsgGUID: qnuQ/wX2SD+/M6DCeueYkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85188826"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 14:46:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 14:46:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 14:46:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 14:46:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7puitGSHe2ybw1l6NAPuF9kdwASwyrpDPMDGDTRibfABKEPbmP4r2oXGfyFTbboLTUl8xwYyxOAwsIHnSb+4JHGsHjwtKYdPZXL3SCXNFDCYM66r04RgtrukDDkHZLuefe3i5FSgLxr9VHrK5vEyVh1kiAGVdV3+eu+lPT6Hri4I/PENyJj7+AuHBqEABPshbtnA5jnpoZe/bgmWoDUyueMgg4G9IVP6ggLJG7rUdZQuAIHVjgseSswnC8EavVP85AUnLu1e+oK4CopDf8C1Wa6d+RKPdkR9obyqt+RslJHDvWXfFdz4ybZQRIB/Yg7gqajF7YvHm+KQwxrSc08kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pIKh93pu5K+9BFbzjOaXWAmGPaMquHzD+9E2On0NPw=;
 b=g14sAKQeoHCrhIsy6iGXTYxj1ChkaFhZkyVDY1ZTOZ4DQmmek0XjYBRAzUMYT4c5/ykb+QBM8KMMHHW2LS0W3pTzxmUyeC8FgGvfQo1So1y4r1cZSwG74bgY4IABwHzUxPlZthG6o19Gu8bWiFeGBjg9y4hS6Y6WyWk1lZNlyraAFlnr6I3rdu4JZfst6Zj+RIuohpLchEvqEYryx1bklGsZC8Jr5z681dnO3XnpZG1IltObwJm118HiH1nY5VWO9/qmEad6jqE9rQWVMDkpKoCNghyostQ6RdhPn6QwilT8JjJOTuDq1dCfj/Adj3AZxgOZ61gng58cKbDM61o4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7089.namprd11.prod.outlook.com (2603:10b6:806:298::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 22:46:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 22:46:36 +0000
Message-ID: <a593dd7b-f502-449f-a866-5e6494de506f@intel.com>
Date: Thu, 7 Nov 2024 14:46:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: "Luck, Tony" <tony.luck@intel.com>, Peter Newman <peternewman@google.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Eranian,
 Stephane" <eranian@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"nert.pinx@gmail.com" <nert.pinx@gmail.com>, "tan.shaopeng@fujitsu.com"
	<tan.shaopeng@fujitsu.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <ZyzxbhHQptbktfGH@agluck-desk3>
 <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
 <IA1PR11MB6076F9F222A98125974C5CBCFC5C2@IA1PR11MB6076.namprd11.prod.outlook.com>
 <c4ced27a-b3e9-4727-9c39-7d1fd0cb0dd2@intel.com>
 <SJ1PR11MB6083BA9392D4B176FA2DA170FC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083BA9392D4B176FA2DA170FC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:907:1::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcc05cf-b048-41d9-5441-08dcff7e08c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1pOR2FneGhpQ3I1d2cxY2tjYmhrS2tyeE91Qm1CWEdxOUhpcXpFaXpVUHhz?=
 =?utf-8?B?WFRFbUpHN1BlM3dyakVDaU1zaXdkcnpMdHkyK1NFc3lueGZZemxGc1FBSDlE?=
 =?utf-8?B?bGYxY1ZNMlZGdEpkdVlyYWIwbHJlclNwYU95N0EzeHh3d1JMajB3bUxuamVO?=
 =?utf-8?B?WjZ5dUcyTFFudnZvUDh0djNpOWowOGdjZVNoWU9lbU5NWW5LZVI2UjZoVGRI?=
 =?utf-8?B?dmlkYlI4RFV5ZW9KUFpwdU1BRElPU2l5Y3JqZGhqb0doNUJGNXk2OC9NTFBj?=
 =?utf-8?B?b3g1bnJ2TFR2SkN0VE9OZzB3dUN5am55NHVDT3MrUm05dkw3amtzNEtlY0FU?=
 =?utf-8?B?QzgyYUtiSUxlS3FkSVgrRVg0Mnc1bFRUd0RrSDBCaS92QUwwbGtzU1MxeUky?=
 =?utf-8?B?SnJ1MWhac0NQa3pyS2VlQysrSTZpUGFPcXhSbUZpY2xiV3hXeURJcHRPc0Zq?=
 =?utf-8?B?blB6VUkxbDA5MXB3cC85czJ6VFk4MEhGMytMWXZBZ3NmK0Y2SHJES0g0UGZk?=
 =?utf-8?B?Mno3TzE2c1VTL0JaZzhiRHB0VzRXaFdoWWRkSEU4OVN4ckRWakhXemlMbGll?=
 =?utf-8?B?VG5OUm9PYWZjelJOTGQzRWp3cUw3RmIrT1l5UFZSd0xDMWdmNWl6Sys2Si9O?=
 =?utf-8?B?MWVSVHNOcmYwbUNIQWM1RUdNSkNVOWtYUkQ2K0ttTmxReFdSN0V6TDljbGJD?=
 =?utf-8?B?Y00zT2hXR0FUcUU2VDdlWDJXMEw3TUJLYlQ4VWlkMlNJUlFNOEF0bnltUGhR?=
 =?utf-8?B?ZllDZmgzQk9ObHFuS3pJeWhidzNiVWRqbENYbGhGWGVxWGJwOXl6RHlHZDcr?=
 =?utf-8?B?cDhJZGE0UVRkN3Z6OHFheVJldEpkSXNYNitkR2c2SVl1Ri95dk80cloraktk?=
 =?utf-8?B?QytwUmR4MkNxUjNvVm5IMU84NXRtZ2hlQStZYWRsOTB6WDVLODhoRy9TbXRD?=
 =?utf-8?B?WHRtcGlEWW9JNmdTU1QvQXlDaTdVeHdseWJtMit3cXJYbUhQRk5aS2tmRjVZ?=
 =?utf-8?B?YmZnT1pEYm4rRmp5WkRwQkl5UGQ1eW1JU0c2T0RDelNHSmErVjd2ckcxazFC?=
 =?utf-8?B?b0dlK3R4SjIvZTVKN21Xa215eU42Ulp4V3VCNjdBd0FoeVVLT1oxTXVjWEc0?=
 =?utf-8?B?bmxRSzNZVm9oYzlEMmFxWDg1V0Q3UlIrM0NsZmdIcFIvUFJGTStYZDRxL0J1?=
 =?utf-8?B?eHc3REo4SHpUaVhvWHVOUVVHdjZIeEFpalVoaklKaURwZ3hSaWthbFVqOFBL?=
 =?utf-8?B?NEVFZ3d0c1hNaEJWS1VNR0IvUlNXdk0wMUg5TmdvMmV3VUJLZkwxcnQyNDRa?=
 =?utf-8?B?cjZIeTEyQnhSVkR6M0d2MFNvVDhMaUViSzA4OVJ1ZythcHdGbDRqQjdvVDZj?=
 =?utf-8?B?ZHRLWGx4QlRnVzVGeENwb2VMOVpULzdVUXJnMVdsTVI3ZS9JL29tUEtsaFlW?=
 =?utf-8?B?cTg1R1BrYmZ1WGF6a2o3T1BLM1ZyY2tkdUcxL20rZUFhUmo1cGZiTW5MdUZZ?=
 =?utf-8?B?WUQrTnVmcUJPVkpXOUp5dUNmVmVsY3VDZlZWMWZPMENRVXdORkxJQy9xakVv?=
 =?utf-8?B?NFZ2dUlKTFp5ZDF5RU9YMTBOcXp5VFYvK0FGS2hjeXpOZzVjV0tZdStyVTVk?=
 =?utf-8?B?NlZjdGdHZk9SKzZLYmhkRGRHRmVwZmsvbVZtZWJPd0dOek1Mcnh5ajhmZkYz?=
 =?utf-8?B?Q0dmRTB5WTRrK2V1S0s4RTJUWTlIZTlWV1M1b09BZEVyclBrYmF4NHdGODc1?=
 =?utf-8?Q?U2UgwGhjCtZ1KmFfr+i7YSibebs38u3JIyv4Usn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0kxVmd4d09Hbll5RFZBOGo0anZjZkU1YUh3Y1BHbWtZT2o2b3VDeCtlWWQ5?=
 =?utf-8?B?ZUlNb0JjNHUxenh2bzhUZWVzZXpyQXZQc1hLdTh3RFpqTkdHSGVOVnV6bXVs?=
 =?utf-8?B?dTJqYkI0K0tjbXlZVVFUZUNKNUVweE1RNlZyU2NqMDVCelArQWJtRGYxTndL?=
 =?utf-8?B?REV0SG1xWkZQSjE3MnJPY0VWSUhSamNzTUJHbmJxMWxPWDR3KzNQS3gyWGZw?=
 =?utf-8?B?clZYU3E3K3FCZ2tyY3RnbEswZCt3WnIrRlkxOWczQjZIbDk2aktSbU9TMmJ6?=
 =?utf-8?B?OWQ4ZHNjNkYvcHZzMXl4QWp5bmFBMkVDc2NNenlRV3E0bGtMWjVKd2R1c2xH?=
 =?utf-8?B?dCtzNnR1VEtva1JCK0VNb1BLUG5jYmVDVmlNeVpndVJmU1g2VE11ZHkzMWFr?=
 =?utf-8?B?L1lkL2VWV0NLV3I4bndxb0FGODZvZHJYSm9sSTJpTEVCSmIrdHdKZHNKY2JD?=
 =?utf-8?B?S2hZd3pjWmZJcG5xam5KclNMdU9kNWFaelhEWXpXdjdJd3dVdnpiTHFnMUFz?=
 =?utf-8?B?KzhWOVdScWZWTWpCNUh3cjc1cmwzS0gxakxRNFZSU3JYWUhOQnNkbmpjakp6?=
 =?utf-8?B?cU5MQU01OWN5dnJsNTBhTFVwK0pCODQxZmJDcGw1SXpkVE5aMGV6Z0R5OVQw?=
 =?utf-8?B?L2NmUE1ZYUVzSlpvRS9HdW9FMG5zVEpiS1U1aGgxZmpQUVBUeVlzR2NiaEZ4?=
 =?utf-8?B?TzNITHZURy9CRzRMRkJjN2R6UWJ5eTlKL0U2TFZLYjd2T1F3enVMcFVRckpB?=
 =?utf-8?B?WnVMRTU5cTVQVEo5Q3NBZmFmQXdWVWUvQS9aQVBZVmFsMFhLV3BBZG5YN0tl?=
 =?utf-8?B?TlZJMjN3SC9pMFpid3ZwTDh5emI5ZzVBdTVtK3JvM1JNYU00NENTT29oOE5E?=
 =?utf-8?B?WlhHRHYrZzIxL3NMNGxOR2h3TGd5Y3VPWjB1bnFaQTdLbUMrQ2xyNUZSaXF1?=
 =?utf-8?B?Yy9HRFN3WkFGVlYrOFora1hWTW5EdGRkVEYxRGRRQnBSaW03RWQrRlp2a25T?=
 =?utf-8?B?TVd6WWg3NU5qeWhFMFRocEo3NXhZakJDV01CeTE2VTRsM050ckRnb2RpN0tm?=
 =?utf-8?B?dWhwaHIvV0U0S3R3SHFnL0hzWjRlblVGOHV6S1JJeXl6Q0YyLzV4eXcyM3h2?=
 =?utf-8?B?eS9vU1hOSG03QnZhSFppbWNVR2ZyTytJYVNHbjJxZ2t2WGpJUFRjbEp2ZFc4?=
 =?utf-8?B?R09wdWpTdGFTQ0l5Q1o3dnl2VHJoUzdQZDZQWVVJcGswb2dWd2tQU1YrNTBm?=
 =?utf-8?B?R2d3RDBGUGVHaVl3Ny9uWEZsbHQxNW1Odzd4WEErRHZuSEo4Um5YV054Vnho?=
 =?utf-8?B?QVl2THZHeGp4NGxUMHltYWg1Tlh3dmROUlNDbzgwU2gwMEN2Vm84ZEJrWmRN?=
 =?utf-8?B?S0pEdGlmcnEyVkw4WHp1NFFuTVY0VGcyU0ZHRUw3dFI3ekJSZHY1YmJaQ3d4?=
 =?utf-8?B?WmZwc2NVMi9jdXpQQlI4cnhQQmZTNkg4R21wWlBscVd1YWJlcDFsWHZrRVJE?=
 =?utf-8?B?ckJrWFpWWjc3QmRkSzg2WHRBNCtuWXBZZExDd0F0c21SL2RoMmRSWHZ6QVli?=
 =?utf-8?B?d3l4U2YvZmk4RzlDVEpKMUplc1pQYks1YUlWQ0lmYjNya04zbzVZR3VVdWtp?=
 =?utf-8?B?QUcyV2wvcTgwaGdzVzZlSHhqSk00NDBCaGlJcUovWlo5aGpZNmtiSmJwSGIz?=
 =?utf-8?B?N3JTakxWM2p0MVE2ZldadUl5TEpHSmZ4aUVwYjF4ZXVjVVRUY2c4TjJiVC85?=
 =?utf-8?B?YU1YeHNwbDJJM0tPZXMrV0xvQmJ2d1QwOWRMemRMZ3VnUXJwT2NZTkdoNDF5?=
 =?utf-8?B?UmFCYkVzc2k4VkJFK3NhY2MwamtGbjdtc1drMk10WkUvNDJVY3JJdDVSRDNW?=
 =?utf-8?B?VHozYnJQRWtCK1lHUGhwVEg3V3R2TWt2YkZzZmZUNUhLZU1PZ2FJT3pucWwx?=
 =?utf-8?B?OFlFZ0ZTNjI3Rm9FNWJPb0RGd3RxNmx4cVdBcVhwcnorcWZlNVYyMXU1OXgv?=
 =?utf-8?B?aW91cUEzKzRtSFNxNk4xUGtZQ2VQMUZ6aW5VdWV3akd0dS9RUWsrNyt5eHJZ?=
 =?utf-8?B?dmo5dlBqcVBxdUFOVmE1dUxBL1FVR2xnTFFBcHlWMC9VWitTQVQ1L29XNGdy?=
 =?utf-8?B?SDdKUmxmMlE0V2doMElmREFBWDhRcDlBN2tjMDhFWkdHbXNlaTFiY2xqZldX?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcc05cf-b048-41d9-5441-08dcff7e08c7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:46:35.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L35DCJdGLCzed341WipNLHR7Jgiogt6StdOJ765wF9/fjFqqBjeiZa799Zt0qUkQ+b3GydYFLdCOATgQUTXlud7us0/f47uR5YAOTh/BN6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7089
X-OriginatorOrg: intel.com

Hi Tony,

On 11/7/24 2:14 PM, Luck, Tony wrote:
>> I think maybe the issue you are trying to address is a user assigning a counter
>> and then reading the cached data and getting cached data from a previous
>> configuration? Please note that in the current implementation the cached
>> data is reset directly on counter assignment [1]. If a user assigns a new
>> counter and then immediately read cached data then the cached data will
>> reflect the assignment even if the overflow worker thread did not get a chance
>> to run since the assignment.
> 
> The issue is that AMD's ABMC implementation resets counts when reassigning
> h/w counters to events in resctrl groups.  If the processes reading counters is
> not fully aware of h/w counter reassignment, insanity will occur.
> 
> E.g. read a counter:
> 
> $ cat mbm_local_bytes
> 123456789
> 
> H/w counter for this event/group assigned elsewhere.
> 
> H/w counter assigned back to this event/group
> 
> $ cat mbm_local_bytes
> 23456
> 
> Bandwidth calculation sees traffic amount:
> 	 (23456 - 123456789) = -123433333
> Oops. Negative!

As I understand this is already an issue today on AMD systems without assignable counters
that may run out of counters. On these systems, any RMID that is no longer being tracked will
be reset to zero. [1] 

The support for assignable counters give user space control over this unexpected reset of
counters.

The scenario you present seem to demonstrate how two independent user space systems
can trample on each other when interacting with the same resources. Is this something you expect
resctrl should protect against? I would expect that there would be a single user space system
doing something like above and it would reset history after unassigning a counter.

This does indeed highlight that if resctrl does start to dynamically assign counters (which
has only been speculated in this thread and is not part of current [1] design) then it may cause
problems on user space side.

Reinette

[1] https://lore.kernel.org/all/cover.1730244116.git.babu.moger@amd.com/

