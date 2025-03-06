Return-Path: <linux-kernel+bounces-550029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA6A55A33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B03172178
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B827C86B;
	Thu,  6 Mar 2025 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxkKOtxQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36925A2D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301587; cv=fail; b=eEktwkDjzTEX/Xof0MZb12gAN6VlvxY0qJkMLiiIZ4Kjw8UVAzL9lHXsC+8ixO6h3I4B0gYK1fVrHTU2kRzKB/mpEVtOd3r9Q9ouVJTiyup1+zNpjFK5CNWSMd3IcU59YP8Yo6OVC0KcSKYFoGptgd6QVP7RlVyRZh+dUnF7rlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301587; c=relaxed/simple;
	bh=QQMwi2044NRdSOqJ42yZZ6A2DbNobNp2iSxCN7Qnl/s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gjGXcfZbyoC9RBDwaCSEjH8D5iNWCQdCECK0hQfViVH/BAKgEvoM3Nepsrreaj0FbMJGiZxo9KWynWco062j2uojooySAvgYnMnRFlIOU0pET63W42C7tM688OUahExZhRGv9gfZCPV9D0Ixo+Wfv+IsJqaltk3UKU6csmqo2gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxkKOtxQ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741301585; x=1772837585;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QQMwi2044NRdSOqJ42yZZ6A2DbNobNp2iSxCN7Qnl/s=;
  b=cxkKOtxQ3ZGLLOuf4LgTTaNU6aX8nxybhN0wTl+oL5qUpMt5xJkPdBBe
   6EcCzw7uYF4mHRT5ohVr8HfLR//Dzex3wIMN8+ibpmttQSEHRYGhzCx8R
   yV6XJ3umYW8LsELJojhPbMWMt9ULRI1YKYVqAZLgktIJsyjNm2nxM8ZJZ
   ZJqTn5nt51sRyjUrzT2q408bMfdJFgShcE+Lxg5zwJJPJrSPEOYvHkKL5
   QTfssyitNoAWSOgQSTg2MDAzRO2MZ/L4kZtgtWbWfAay0m3ZykbJ94Mll
   GA2pMJsgYduiv7+EuS5WDDT5jUrdHY/GlkzMgzEiQn7tssXhi3/VigjQA
   A==;
X-CSE-ConnectionGUID: UyBkMuhZRvmAC8EQZJhgSg==
X-CSE-MsgGUID: VDnCj0DgQxe/LGz9ZGJaiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="59744031"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="59744031"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:53:03 -0800
X-CSE-ConnectionGUID: 1PUv3QPuTHa89pQcm6tAIA==
X-CSE-MsgGUID: tRNOjjc6QoOPipDgCTRKEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124361745"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:52:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 14:52:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 14:52:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 14:52:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTUpnwc6pLq8AmHBa9h9DpNY67H8nZKp0jgRbsLdRSEaK5tuCvnfhq3wr+DZz5XMkxyoOdTM/fJwH7QM3/QqSAgSZnLSEl6VaMlGOCAZtG7uEV5grFpArsOBFH+4sExRAW7R/mkdjeEHeK5klBNkjFSPmZ1q/BJ6/cu/mt1q2unfXQNN0+YSivNOvMvOAEnHcUTaW6/c7jgbfDJlxYxOW1R3M7fYopEVHb6ulD3qSnPpti7fMk1uZAaFIpeY7SO8tzR4+kcabH8OZg2OwaRjaLqAAJVRBGS2yV1aZ+2Gk1mAO6ji/vBPZ99OnHHJDDQ51Yt7LVRWl0S27V5UEqnOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubGRq0uNDys2zbsfJrv6bwm1GigZkG3vkTCmOEtqV2I=;
 b=agyOW3sEtcT3H/7RLua+LqF+AiKjXjsue5s5LFwYV//VTaTV6K0dUv76LhOUoPnCJ7P33/lk64W5nQBIcr2Hv5ZksvdjRa9IZ18XK1KWnUw69TN4XB2+J9XbEJchIiw6WUznaux6ndesY/YeU+KLKTltI1SAD4tfRZjtL0M/AeQirxnDoH6LAuxdRjKXskUR49h7NERGacDAEDhl/dfsg8KJxl6hCClix6ZJqQ/lCz28aJKpBr8nA+nLT/h11frbjPEGJFp8dsK8VQ11Eo1z2MN2gDq6CstmsjBhs95+/31EhcbpJ+nAZTfGO/uSjk9teiFKuSEqw7c2vo2dUUOOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 22:52:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:52:22 +0000
Message-ID: <d19fc03e-d192-4852-a592-6135011f234c@intel.com>
Date: Thu, 6 Mar 2025 14:52:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/42] x86/resctrl: Move get_config_index() to a header
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
 <20250207181823.6378-30-james.morse@arm.com>
 <3749ab92-6f6e-43b4-8147-22775e31d21b@intel.com>
 <44cf4fb5-fa3f-42bc-ba16-46645495d669@arm.com>
 <ce60836d-d482-45c7-842b-d7e28e9bf794@intel.com>
 <824605e0-35b9-4f26-9c71-f9104fa31a87@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <824605e0-35b9-4f26-9c71-f9104fa31a87@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: cd327267-b40c-415e-ac63-08dd5d018e32
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUxMVDh6REJ6OThtYVVMVUdMREZEMkdCS3BDZ0lNYnF0Nk0zZkhrWU95UTZt?=
 =?utf-8?B?TTlkb29rTTRNOHN0Wm9ud1puRTlqMXU1U0ZJQ0xhc2Q4d1piYk1QSFY2djFB?=
 =?utf-8?B?aUZWaVA0U1prL2JDUUs3YjNONjdqZjQ0L3dRVGxUSitFU1FaQk5hUkp2blBw?=
 =?utf-8?B?ZUxQM3djOGRRMmhNZE52VmNpbDZqc2F6bW1VMGgzeGhNK0ZxeXVYbWd5OHVI?=
 =?utf-8?B?cTRyQnNWK2lqVmgyZTdQajAwTGlhNG9OclZYY1FpMnhBeExPdnI4Y3FIdkJY?=
 =?utf-8?B?WDZmQmVXR3FueWRtbjMvb1V3UEFtaGxLZ3FIdjFxWUlnUWpSZno1M01CMTJ2?=
 =?utf-8?B?c3p0R1JBeVZoNHdNK1owVDBXYmxGeUxkU05TRzU5UWRxUGpCeDB4aXJzdzA2?=
 =?utf-8?B?cTlRNUQ1NmhoT29WTGY5VzVkTEVQdzJSeGpmODU0MEdHWlhRVDc0dnZvcStr?=
 =?utf-8?B?K0g4QXBtcllTVGhqQUVGT1cwanErZjlZcU1hTFdZemVzU0tSV3ZSdzFubTFh?=
 =?utf-8?B?N0dmbm1aZnJsekhJSE1raGZPUkF1ZkVhZ2pOYmVYV2lCM295MzhodFpGdTFL?=
 =?utf-8?B?LzQ2aUZwU0xDN0hJeWNSaHRLMDFGTzJRU3k3VGxUTHQzbnhISW9DVkJSNEFt?=
 =?utf-8?B?V0pEV3BtL0dURGRSWkNLYmlrd2VMN25QZjZRcFc3Q2FndmZuclAvMXNkVGxZ?=
 =?utf-8?B?NTcwT0ovWndWRzB1T0JENGhVNVgrRFRBY1BtUnpPbVZPOCtlZ2VDbUtBYlMx?=
 =?utf-8?B?QjV3WFBOdlZWNTVuTmRHQlRJNWhNb2pOZldSM1lyRi9PMHFnb1lSWGorYm83?=
 =?utf-8?B?LzFWZDJ2SVZ3RFJmeVBGOTcxd0NndWZLN284emtxK25Xa1pnRVMyc3U2T2U5?=
 =?utf-8?B?V3BOdlJIRzc3OUxCNEI5bDNMUUNIUTNzSjIwWmc1ZjZxckFoVGxLeGJZTEEw?=
 =?utf-8?B?U2lraWkyRWt6Q1FGOXB0YitYT3cyMWd3RDVSL3FaeVVaYlloc1MrWUJ4SUlH?=
 =?utf-8?B?d2RWUis4ZVd5QUI4cUorL3BHTTVLOW1pQS93YUt5NDBMdFhRNElrTndNbWtH?=
 =?utf-8?B?d2ZycjE1eVhCQ2h5YnJ5RU1VMVhDWVlrb0ZnTnhmTFY5K0czU2ZrVzZIVE5K?=
 =?utf-8?B?eU52dTF1dEorS25zOU43NHQ2Ymk2SzcyQXVland4S3VEZjQvVEJGRExEUG9I?=
 =?utf-8?B?MUxyRUhGMkRqZGpVU1BJeFFTMUNvUzQ4RXNWT1k0S0c4YmMzYXhocHVVTE9B?=
 =?utf-8?B?MnlSVDFmV2I4cWxBKzFJdmxRRWFaaDlzc0xEMlpocVpLZ3BscnQ4bW1yU1lk?=
 =?utf-8?B?WWxOVXNaQklkYmZzU2I4LzV2UWpjNnFMKytkUE9DekRBN3BKZ2VkazZuWFJV?=
 =?utf-8?B?dDNuby9sZW5TTk44MlcxWm55RTMxRWI0aG82eTU2U3hoMnhWbkFZYlU4OGxy?=
 =?utf-8?B?TWE4VkRkV083dlJHVE9lYzRWMlIzY3djWlVZdXM2UXhLczMxZXhZaUN4R1NO?=
 =?utf-8?B?QVVCQk9tKzIzZjh0U2lHOTFobStUSXVLakFsWjJuT091ZjBUMlcyREswVjFm?=
 =?utf-8?B?Z2pjcDFlaFpwQzJZYlJ0dGZyeGVpV2tpaFlVOFRMaFNvM0U0L2dBeHRQajBq?=
 =?utf-8?B?TWIzLzYrS2NtOGZWYjhOOWFacG9xbys1bEFJc2ZBUzFhZ1I2VjBRLzZlYUNl?=
 =?utf-8?B?d0dKVjBHTU4xTnNDL0F4eXdUUXNSbG9jZ3dhY2VENVFkOHEzbUplU0cram9q?=
 =?utf-8?B?SmpzSFh2TzRkZHl5K1lzb0wvdnFPdzg2MG5QUHFaLzdKQzFVU0Ric3BlYVpT?=
 =?utf-8?B?YUlnTWRJMnZIRVNKaENpQmw5cmZ1VUthRjZJSDNmY1IyU0t4aDdmVWtDWksv?=
 =?utf-8?Q?fkyzLX+S7KBZl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjM0YmFQY1JmUzNBTTZNZ2RlektSbEZtV0haNitqbWRxTkZFWGZYeVJyaUlL?=
 =?utf-8?B?dVVKemxKYTlBM25uWlMyaEdHTU14UXU1WDRjSDZuQUhYUDVlS2R6Y3JiTUtP?=
 =?utf-8?B?UTBkTUl2eHJLTEdmdjJLWldid0VRQ2phQjZQM2ZUUU04TEMrWC9jaXQ2dXFi?=
 =?utf-8?B?SExwWjVXbEg0RVJMNTNZVjhmMzk1ZmpIcjE2U1UzVEczV1pXeThPNmxMeVVk?=
 =?utf-8?B?WE8zQmcyd3I5MWtFRWRsZS9reUg0RE9VaGNvbVNjVEZHdXZCVkFVWVFkNjdH?=
 =?utf-8?B?aHczRUwzTmF0VndLT1VHd2Zvekl5bU1vMUlSam9aTkJHNUx6VktMTkQvaG1N?=
 =?utf-8?B?SUk3TGhPaklwWVJaVEhLZDBmdVNReGNVb2VMeVFsY3pPNDFacmUySlFpZVU0?=
 =?utf-8?B?TWFNWTE2NG5QcDZkUHNxWFFXZ3d5empXZUxUZUhFVHJTR0FibG1IblJDVW11?=
 =?utf-8?B?dmRmSFhaa204MndpSXY2dTZSa09SaUE2REw2MTQxbkMyNCt1eG5QYnJYTGVC?=
 =?utf-8?B?aENUQ2ZBZExsL1ZVN2Vxbk93Z0ZRM1poYlEyZGFCMCsva1BhVnpKM3lSbmNm?=
 =?utf-8?B?cHBiY1lWcC9SdjMzSElEQ1VqWWxaTzI1Y0JXMmVuV1I1OVVMUUU5bFRDcFdN?=
 =?utf-8?B?ZFA1MHYwbzBYZ0JCQzBKZ3ZzWXRQRjFLK0QrME96MlJubUpyR2FYMXpNMEd5?=
 =?utf-8?B?dVZBSC84SzI0cTFMTmw5R0d1WjNnd2NTbjBNT1ovQ1VOcFYrblJENmkremtL?=
 =?utf-8?B?U2F0QnR2bGVzamlubzM5eGsvb3g1OStNWDNIODBtams5bkpyc01XL3hCbC9F?=
 =?utf-8?B?Z21MeDlOdGhKd1cvdmFQeUFVWS9rMmcvcHFXTldDQ2hKd1FzNTVxdmE1S29y?=
 =?utf-8?B?WVJlam5rSGYwWWk4dERoVHlnODNOdUczbE9ob0ZOWEs3SWt6Sm5MdGNaU1pw?=
 =?utf-8?B?aU9iUThtVnRsbktPZG51aGFkNk1kY3ZDak04TjcyVHVFS3ZQNGVsYkhqdGlt?=
 =?utf-8?B?eTFyQkZ5MHhQTUVIblR0bGpnb0swNEorYkFVVEJYSWJ0VGlIUmo2bS8zM3dX?=
 =?utf-8?B?eHNiWnhOSElLVnNtc1JGdzU4c09wTFhXa0FmZjI3aU9zaklrbkJUay9HenNG?=
 =?utf-8?B?SkcrQytaVXlpa0xSaDhlYXFCZ0N0YVAzcTE3eDJsdk8rWkNUdXRDbzRmYllm?=
 =?utf-8?B?SngwaEVPbkQ0eWtXNHJ1bitoR2dRYnQ4SjlXaHpmZWE1bXZFczRQbVo5ZnlX?=
 =?utf-8?B?Tlc2cDBSVkZNeHFWc1AzS2VUMlBBNWtCekNXTnBwRWE5d1JTc0R6Y05sclVm?=
 =?utf-8?B?QWVsSGNGZUsyc1FtSllxbms2OWk1RlJOeTMwU1NqamI5SjlxOEFzenVVY1pq?=
 =?utf-8?B?RXhucUFGb1ZiMUJCZ2dLREQzbWwrTUQ2aTE1RkVsaHVYSWpiOEYvdjRtcHd4?=
 =?utf-8?B?OTVtYnY5L3czRFh5UFVEdUVaeUEvVlNsU2Zwdk91TXZlUDlTU1EvNHpWSGJn?=
 =?utf-8?B?aTQvM25xeDJnekZOVlB3TEFkQ2pZV2lHUkdONUhPRDFVdk84K1FUaHUwNDY3?=
 =?utf-8?B?TjVwVHdqSVVSZjc5SHlBOEgvS055d0IzdEJRbjAxSkdReVhsa0hTZ1Z0OEtZ?=
 =?utf-8?B?QTl4UVdmWXhra3REaTl4Q0pmbG1PZCtNbW1SUmFLSXBwbW0vQkIxS2ZYbld1?=
 =?utf-8?B?OFIxZ0VyWHJIZHgyUGNUNDRwVGJTN1lJUVZYRHhJVU1YTnhTeXY2NXIxQU9D?=
 =?utf-8?B?REJKZTNrZ1B3YWlxWVJGZHJDSVBqNWNLNk5rY3BqTEh5Y2VUSkNGbHhmTHFs?=
 =?utf-8?B?cExkRnBMMm95TndZYVVCazlObUNCbUVyRk1hZitIbmRXTW5xZHAvQkRmT3JN?=
 =?utf-8?B?c01HTXJuRmhVdVJ3Qy9ITGNpdnJmZUFtM3pvL0JLRXlDYmljVDZLa1REZktB?=
 =?utf-8?B?N1E1TEpIeFVwVVk1K25mZWhsdGozQVE4UjdHVTVIeXRBNGlCZkhrYUJzUytD?=
 =?utf-8?B?aG83Y2x5a2dWN05lWktWemdJY3NlLzl6L1BPRnFtS1o4NW5DbXRXNFptVEZm?=
 =?utf-8?B?USt6aUxjdHFxTWJNL1QzekwxQ0V3aUpOdFdRdStNcUphalIwVVdhVkZRZGdl?=
 =?utf-8?B?bnkzc29nbkVoMlNpUHRuZVhnU3NycVIyanM1ME1Bblg1cXU1WlM3SWpWYlpD?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd327267-b40c-415e-ac63-08dd5d018e32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:52:22.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du4l7H+jYCViri/50vBX70uRVs27nJCMNXQuZ6AL8pFn9qLEw9yXnz+F9LnF+l5VKOwC775wBrdKHsCyT36aMX8QKWs25fduW8ewmWknnaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com

Hi James,

On 3/6/25 11:28 AM, James Morse wrote:
> Hi Reinette,
> 
> On 01/03/2025 02:28, Reinette Chatre wrote:
>> On 2/28/25 11:51 AM, James Morse wrote:
>>> On 20/02/2025 01:27, Reinette Chatre wrote:
>>>> On 2/7/25 10:18 AM, James Morse wrote:
>>>>> get_config_index() is used by the architecture specific code to map a
>>>>> CLOSID+type pair to an index in the configuration arrays.
>>>>>
>>>>> MPAM needs to do this too to preserve the ABI to user-space, there is
>>>>> no reason to do it differently.
>>>>>
>>>>> Move the helper to a header file.
>>>
>>>>> --- a/include/linux/resctrl.h
>>>>> +++ b/include/linux/resctrl.h
>>>>> @@ -384,6 +384,21 @@ void resctrl_arch_mon_event_config_write(void *config_info);
>>>>>   */
>>>>>  void resctrl_arch_mon_event_config_read(void *config_info);
>>>>>  
>>>>> +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
>>>>> +static inline u32 resctrl_get_config_index(u32 closid,
>>>>> +					   enum resctrl_conf_type type)
>>>>> +{
>>>>> +	switch (type) {
>>>>> +	default:
>>>>> +	case CDP_NONE:
>>>>> +		return closid;
>>>>> +	case CDP_CODE:
>>>>> +		return closid * 2 + 1;
>>>>> +	case CDP_DATA:
>>>>> +		return closid * 2;
>>>>> +	}
>>>>> +}
>>>>> +
>>>
>>>> Could you please add the motivation for the use of an inline function?
>>>
>>> Putting this in the header file means it isn't duplicated, so its behaviour can't become
>>
>> I am not following this. How would making this part of a .c file of fs/resctrl with just
>> the prototype in include/linux/resctrl.h result in this function being duplicated?
> 
> Ah, I misread this as one of the functions marked resctrl_arch_.
> 
> 
>>> different. If its in a header file, it has to be marked inline otherwise every C file that
>>> includes it gets a copy that probably isn't used, and upsets the linker.
>>>
>>> Calling from the arch code into the filesystem prevents the arch code from being
>>> standalone. This is a useful direction of travel because it allows fs/resctrl to one
>>> day become a module
> 
>> Don't we have this already with all the needed CPU and domain management (
>> resctrl_online_ctrl_domain(), resctrl_online_mon_domain(), resctrl_online_cpu(),
>> resctrl_offline_cpu(), etc.)?
> 
> And the realloc threshold, yes. These are the things that would need further abstraction
> to allow the filesystem to be a module that isn't loaded. But these would all be changes
> to the existing behaviour.
> This one is just putting the definition in a header.

hmmm ... this seems a stretch as an argument since filesystem is not currently a module
and cannot currently be a module. Adding a declaration to a header file that matches with
existing usage seems reasonable to me.

> 
> 
>>> Today, the compiler is choosing to inline this:
>>> | x86_64-linux-objdump -d ctrlmondata.o | grep resctrl_get_config_index | wc -l
>>> | 0
>>>
>>> This kind of arithmetic for an array lookup is the kind of thing its good to give the
>>> compiler full visibility of as its good fodder for constant folding.
>>>
>>> For so few call sites, I don't think this is really worth thinking about.
>>> Forcing this call out of line makes the kernel text bigger, but only by 32 bytes.
>>>
>>>
>>> I've expanded the last paragraph of the commit message to read:
>>> | Move the helper to a header file to allow all architectures that either
>>> | use or emulate CDP to use the same pattern of CLOSID values. Moving
>>> | this to a header file means it must be marked inline, which matches
>>> | the existing compiler choice for this static function.

This is fair and seems to be only valid reason.

Reinette


