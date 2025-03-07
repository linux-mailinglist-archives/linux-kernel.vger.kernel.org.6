Return-Path: <linux-kernel+bounces-550424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF68A55F64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8C6188FC75
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E381624E0;
	Fri,  7 Mar 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3z6h7lO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC80C2E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322022; cv=fail; b=GixQRjEBH9O316m5IYJ83b/4FgI/W8xikibhtq6M8dUgkV5gN2XV6BDiMgkfDswZSoKj8jneBwN4HLcS32SMgoM/hXnDeHIfX0bzt5FkINaMiuZriaWNKv8V1Hbd8dNPLCgh2CUkafqiJIEYpUPjdtvYj/NZtMqbmTjkeMOupsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322022; c=relaxed/simple;
	bh=uIYKK2LUPi7Qs3aq/cAmhrA5eEwm7VKvzfquZ9YNfjU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKkIhi502/7iXB/t/zPWJrHEoYK4sAdqkLf2gMrRlijCJuV2pAlLg+yq702TdaqJYCUXZJGQDOlBJZXzsFHRmhizpE+2r6EmbBjonrRJQMuCG6+nxh6LsjmkVmg5BpZlN4yj4ClbjCIzItfhyqtgg+/YDHJ3Bpq1GuFKfXlk+pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3z6h7lO; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322021; x=1772858021;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uIYKK2LUPi7Qs3aq/cAmhrA5eEwm7VKvzfquZ9YNfjU=;
  b=Q3z6h7lOw10KlcnD7ESyKHDBqGNN3Jk59MidY4X6GNI/38uyRwMBiL5B
   iKLY3BVmc198OOY7GNbTdZMhjsdqIozdhREzq+6Paml7v+NYxy32wDFld
   2eSALqtgsjX0OvwFQ/p/GsWTNGBxjhgIRoYkPn/lVvmcgNeWm1TEk+Xn4
   jI50doKcn1aF91o1WEvukrAmJE87lsDcmEFdfgeDgeNnXEKgC9R5ATgZM
   c+ZOz848DosVeMUrIHKbaOj48T23GaGQAvgOoseumhGLMTJu3YWBUUEJb
   vd9r42Mevm2qf04JHLqk3k9hYBuOHKzt5xOg2RYWtTeDRZoKXc56fPiz2
   w==;
X-CSE-ConnectionGUID: IV5z/mUsRm6530pkqExJNg==
X-CSE-MsgGUID: genxL0lkSCKrzsHvrY0oRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53349254"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53349254"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:33:40 -0800
X-CSE-ConnectionGUID: fGmgEVhbRtaNH1wHc3Oj9w==
X-CSE-MsgGUID: ctA6p8GyRIWRRrarxugPGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="123809688"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:33:39 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 20:33:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:33:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:33:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpNanmIjk1q4H029fwYNXCP+t2BWgx1HoKs+FFb6kpBqs3ylW7x084U61RhcPHRM2UdxzpvJwwGbhWFNlv8uE0lQP7Ydf1HN+mzlmNSjrOXnK/CFErwu0dfLpZvYUaTet49mUJO/YqKl6C3GUrEFsKAd2uWnQD/3zGZp50PXWF9D+o1PdklJdoDSF4oMbFBdRo6ID0usjzyqrESNlOd4yscZzcX5MtdVbRbJpGiIX88zyqI3aT9wZETEYJfxu5Zr0cf0Sq+99DI75pBwA/3ZF44Gj5bWEhHDzLIXdcXRmIEbd9tT+moYXt8zoMkgAGA0eGMWXdJKrCXTSeW9h4MtBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyxKtICy7ujdts9ESVQ1bqZOIZhmKeLkgIHUrIvXCtA=;
 b=eZWeGSdB7bKvjYK4baoxU7tFo4Zu6wHRClYKk65mUku5rU3khUgdQ95ktfq57lASeYpaNx8VnqJICUJtQFkyh+KDF5jBF7ZP9lZ9F6Zww8JH0kcNyCGqO46AZPxMrq/1vdZTxv0fG+Le1ya63UzO12mbLwU24ZWh2uHVwlf6NFZbifIdANHofE2L3LHnIEH40JZ6Y1b86aetPeu8ERrjUNeFhOuGnekQjrZRZakxgT50hjZoHJfHSnQd4nBJTnMknSlpCmSFMiQhb0YoZg4TK7jWRIuCn2Bn6W7p6JW/DGCC0HwPmD70G9jIn8BW2DiObQTd3zsY7OMwwbohkpSSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:33:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:33:35 +0000
Message-ID: <ab7becca-7a14-44d2-b0e3-1b12655c8be1@intel.com>
Date: Thu, 6 Mar 2025 20:33:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/49] x86/resctrl: Generate default_ctrl instead of
 sharing it
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-9-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:303:8e::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5b266e-2eab-4e3f-8f6d-08dd5d313919
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTQ4Mm4wTEpmT2NPYzdkODJManFBaURHejlSMkZQaWc1V2VDODQ0SG5ISU1p?=
 =?utf-8?B?bkpiSGM1WmNwWUlFaGRnbm5mNTdYamQxOWxTVUdNM0lBZjFvSGpxRkFVMmdJ?=
 =?utf-8?B?K2ppQlZMOHlCbzdVWUV1WGcxWDh1WkV4OEdVM0p0STVjK0JBaEI5aEVCeTZF?=
 =?utf-8?B?L3JnaWtiMHBIR1hic0QwVGZZZEU3NlBob0lZTDNwWmNDNmlWZXppZWdhWmds?=
 =?utf-8?B?aUd5bzNkQmJGU0IyM2V6Y0gvYjlteUtvK25SWmpLcmJJblo4cHRKczJqV3Y2?=
 =?utf-8?B?REovUXRJcTNMS3dia0ZTL01tWk5DYm5IT1RMRmp5YTlCbkJQZVc3SWxGYkZw?=
 =?utf-8?B?TXFpTm1SbUlwMzJsN2pzOWxQVWJPbEcyQW82b21NMXRWZ3RieXcwcU5NbzlV?=
 =?utf-8?B?WjVBSytCRWdZM3dBeFh0cE1VSUJ4SDdwdEE0eDQ0dWlYZ2d6Ukc2WWNuNWZ4?=
 =?utf-8?B?MzM2WDVjVDV6RVFHVE56cTFhRUlFdDhnWU5oYmlxS2ZUaDAzN3BXdWJ3N2Yx?=
 =?utf-8?B?VC9LSlB4K3EwejlhajJJbE5oTUU4MEhkWitoUy92K3p4NnZ4cENkdTJtT1Nl?=
 =?utf-8?B?KzJkb1pTQURrQm9KNnVKL3hiSnY5ZUlxamVIVFcvYVVmTkkrNXhnY2tKQ05t?=
 =?utf-8?B?WVc3V0NqTDVhVVNqeW5mTjdmNW9MTndOVWZWVk1FL01XWDVVNldpa2ZEMFpZ?=
 =?utf-8?B?MTBTLytXWjc2aHhCcHIxWDJqVUNKOTN6aElEM3pIU0czZWcrcmVyVmVUdEtF?=
 =?utf-8?B?U3ZPZUMybkdwRGcwTFBMaFNNTEJISTdwY09VVUpEanVoeHJZamprNzZKUm9C?=
 =?utf-8?B?U21UT2U4czRlZXVycHIzMjkvMXUrSnZJS1NucGZBWFlZMitjT080RzVtWUhw?=
 =?utf-8?B?VERxSEJlVDRkYjloMlJOOU9PTGNEMnZlRU5OQXJTK2pJa1NBcEdXbXlJYWJo?=
 =?utf-8?B?akNPVkx4WkxONzJyeVBsRXA0QWc0cnZPU1UydjZjbkNienBtTkhrY3FrM0tk?=
 =?utf-8?B?enJzOTNzaldXMU1lRXowNDlucTFWelZ0Z1VKa1UybmRNN2lHVlRpVkl4R2VG?=
 =?utf-8?B?MGl2VFhNOWhFUG40NlU3NzNxQXZycDBGaEZod0xUM2tQckgvSnBENUE4bG1X?=
 =?utf-8?B?VEZMRzlaZXYxNGMzOWx4dVIxb1FMdmdCbWRpOWRER1k1ekcrZ3ZoYzhudUlM?=
 =?utf-8?B?TU9PRCt0aW1HQ2JYNkpaZlhJYVJmb0Q5YmlVQm55aG5kT1pDV2FLVDlrUlVv?=
 =?utf-8?B?Rkk4bmNaSFRyUGFwWHR6NE5RejJoaFRPQlJoMWw4UnpDcUhZQ3VKRGd0K2NL?=
 =?utf-8?B?ekdRcHlQMDFwbWJYYnJxTndsbS9oN3BSelVCZ1JrWVBBS05oWWVXOUhGWC93?=
 =?utf-8?B?bHZLRUErcS9wZFUyMFU5emZ2SlRsMHFNS3JqSEZVbWhhelFucTd3U1BXMCty?=
 =?utf-8?B?K3lwYWVXWThOMlBHVHM0K0JLYUNKQVFWdVUzeEN6Z0tLanNrOW1sMDlkdTNW?=
 =?utf-8?B?aVdnSG9ZWWV6c0M1aHVZVXgxM2Z2dk44QkNvT3pMd3l1Q0crVWdkc3dtdnVo?=
 =?utf-8?B?Q2JCV1ltTk1uSUQxM3JsblRoZTZMTlBFMEtsYzVVdU9zc1AzR08waE9VdGFl?=
 =?utf-8?B?NmRvbnNYUUovUWZhb1dNY3gxYzQ3L295aW8vRi9TS0xMaTdrZ1ZkbkhqTmM4?=
 =?utf-8?B?YW1uUkUzZUswbG5venVwM25hZTZ5OXRMaEE2dDRoRHdVcnZHSjYwY2RGalJK?=
 =?utf-8?B?VlhhdDdBNW1OM1kvbG9ua0dRMzl4K3RNOXkzbDYyNWhCOFZ4UDNxMnhwWlZO?=
 =?utf-8?B?SDR5d21LK3dWdmpCeWYvT21lakw0WEtGSzFVb1ZBQnJvQzNXRS9oVEVZdGQ4?=
 =?utf-8?Q?YfCef5xnEVYSK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRrUDhab2dpenRGNXU3S3B0TWNuSjNyajMwd3lFeWI2cFdPckpCaXp6NGZp?=
 =?utf-8?B?OUU1akpLK1hheUVXZy9maTRxN0kzTmQzczJNVnp4aHY1RFZYcGJqL3FVeHk2?=
 =?utf-8?B?SXlDZXRmWW1WQWZQeDJMY2lnbDlqMTZkajFBMjlEamk4cElnMVA0TzhQMS9h?=
 =?utf-8?B?L1JXNE0vQ0Rtbnp3VmFpclhFckNyR3h0aDJ0WTQvT21nQ2ZYSlN1d1VrMmZs?=
 =?utf-8?B?eS9vNW43S3NwN0RVU21KYjNRRkYzRWhlVnB2L0FqeWZFR3oxRlYvVm4zamJj?=
 =?utf-8?B?NXJTZjJKVkJUcUlSaEJYS2JoTHM5L0hONmUxTlljK01nRWgyblhXQkRENkJN?=
 =?utf-8?B?ZWpQbWpHZFhaOEVoZFlSdk5GSWVkQ1hQN3VNWFZVanFrVUhJeFp0a2JCVDBa?=
 =?utf-8?B?dWNFNk5VVjFPcEFVOERGSkhlRHM0aUlpWlZIWUNlcThNaXUrek02L2lHMTVl?=
 =?utf-8?B?ZVRPWHNia3VFK01TM2p4Ukc0MHljR3ZFbkRNZllPSW9QblEveGtIUVFDQ0Vs?=
 =?utf-8?B?WWZUdjF0OXprNWlhVXg1M1puMWVsN0s3SDhuU042OWUzcDE1SHExbTg0S2Vh?=
 =?utf-8?B?eHN6QXNRMUxua2VEbC9UWHI4ZE5OVTFucWZSRW5tNmtNdUk5ZkZVRFUva00y?=
 =?utf-8?B?SWgyS2RyT1VXZUhpQTliSmVwR0xRSnVUMnNxdE9zSE1IemRDMXgxaG1mUitC?=
 =?utf-8?B?L0ZFSFRhNGp0eVlGM0VPdWg3TEpPOXJTdlFnc09pODZPVG1PMEVRbG9ucG11?=
 =?utf-8?B?UzFmUCtVSVhHZm9CdlBKYW5pN05oV085UDg2UWp0Z3BWbjhvV2J4cG13aHIr?=
 =?utf-8?B?QWpibCtnZDdqVE4za09lakl1Y09UUGdNcnJSVFc4dWZwaWVCOEd4NjNQZ3ZX?=
 =?utf-8?B?SWI5T3ozU1JIWHVsQlVXWFl3K1FHckZaR0VJeUNVTlVlNUhMNzJ0Nmpib3o2?=
 =?utf-8?B?YVF6UkhFcGJJTDdMenVVM1B4SGUrd2FsdjZ0TWhxRC9kYnpJc0ROZ21UaVBL?=
 =?utf-8?B?emZqalUwUWdtOTA5ZWVyYWZqQUxTZm9ubHJnNUpYOUh0N3l4bnlkdXJodldX?=
 =?utf-8?B?clJKQWxVck92ZkJrU1BrL3V6VVdDamVDeDhlWUpIRDF6TW5uMnhwTDI4dHl5?=
 =?utf-8?B?a0lia2hJRDI2M3laOEczZHFOeXJRWThheG11QzN1WjJvVTlmclI4Qm9PbitR?=
 =?utf-8?B?ZHVmQmQzRFVSOCtVVTdDazV4aEZGT1VXN1JpVU5WNTNyN24xNUNMMUNVNXJ3?=
 =?utf-8?B?YzhUOTkxY0lGbGRyakZpRGtxclJtOGRpRXBnNm14YjRPYkp5Y1A5SCtpdGRt?=
 =?utf-8?B?cXJIdEFGYzRyZy9IUFRPSlp6WHRwaCtoWk1oYzQvQllrU0N3SDBzZ0V5UjAr?=
 =?utf-8?B?cFFOQWQ5Qk1DSzB4QU1XQ1JWNW1pU3JUakZ4M1ZLSXp0dlVLT2lHNTBPWUV1?=
 =?utf-8?B?bUtWMEZJUDRrNDFodVFGMzdLVzhFSHJ5V0tDOERtUmtDemZSdzZJcmlUdGxy?=
 =?utf-8?B?dExaekhaNlcvb2U4TVZFNDYxVlRtWEkxWGRVMmNxMGN2ZHhmWlBCcUpidHZH?=
 =?utf-8?B?Q2RtajBIbk1GcFlFbGVFcnM3ZVVUUVJETWE4U280TEE1ckZzdy8rZHMrcVNY?=
 =?utf-8?B?VEtBYU5vbGx1U1RJdTllL2ZCb1pDbGlWNmMxYUJLNmJnSFdmdHdSSndmWGNJ?=
 =?utf-8?B?SVNremFINGRIUUZ5bWVjUFNBbGpVZ1QyMEZ6bGsvY25lRmhJM0lwYVhpQnBh?=
 =?utf-8?B?MVlLMWloRlBJMmJtVktQZExycUdBRldrQUtVTmVaMXU4UUZjMmlaRnpPV0ZK?=
 =?utf-8?B?REt2UUVadVJ6WThpdGNsL211YzRPbUIyaWVMU1M4ZHpXQU9tUFAwSkFJUHlZ?=
 =?utf-8?B?SnAyZTZWOXpUQnZBd1M4bDhJWkgyYnJKRzlTbUt4OXhqVTR1Ynp1SlMyOXNT?=
 =?utf-8?B?UXVHTVBKL2kvZGVjbWI1akxNUHJRaE5LaG5OaEpVN3dtNmxWTU8wUi9veWZL?=
 =?utf-8?B?eXA2VmhrdGxwK1M3RU4rNWplaTF1dmlRTncyRnIveGoyWHV0NVMrU213NUZi?=
 =?utf-8?B?MWtiSTRBd0pVNXVlMEN1YzVQWk91WnBLSDdhM0Z2UCtiQUxubzdlclF4Smpa?=
 =?utf-8?B?dy9xNllBOXdmd2w3M1dHZUtZWmVOem5OUFFuVnpmRW5DRzlGZ3d3L0ZZcFdS?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5b266e-2eab-4e3f-8f6d-08dd5d313919
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:33:35.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjsQgik7DYk245tNzmGO2G4y5pPFhHhgBcjPmYtgJmYYvolPKovlgFYG1dBD8zdpJvWMy5OTVayk1gKdx9uL7llDfWfyQPpVF+03qQAUhbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> The struct rdt_resource default_ctrl is used by both the architecture
> code for resetting the hardware controls, and sometimes by the
> filesystem code as the default value for the schema, unless the
> bandwidth software controller is in use.
> 
> Having the default exposed by the architecture code causes unnecessary
> duplication for each architecture as the default value must be specified,
> but can be derived from other schema properties. Now that the
> maximum bandwidth is explicitly described, resctrl can derive the default
> value from the schema format and the other resource properties.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v6:
>  * Return MBA_BW_MAX from delay_bw_map() for improved readability.
>  * Generate the bitmap directly in rdt_get_cache_alloc_cfg() to make it
>    clear shareable_bits is being generated correctly.
> 
> Changes since v5:
>  * Rewrote commit message.
> 
> Changes since v2:
>  * This patch is new.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 19 +++++++++----------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  5 +++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  6 +++---
>  include/linux/resctrl.h                   | 19 +++++++++++++++++--
>  4 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 4504a12efc97..5280a2819760 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -143,7 +143,10 @@ static inline void cache_alloc_hsw_probe(void)
>  {
>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
>  	struct rdt_resource *r  = &hw_res->r_resctrl;
> -	u64 max_cbm = BIT_ULL_MASK(20) - 1, l3_cbm_0;
> +	u64 max_cbm, l3_cbm_0;
> +
> +	r->cache.cbm_len = 20;
> +	max_cbm = resctrl_get_default_ctrl(r);
>  
>  	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
>  		return;

It is unclear to me why this architecture code continues to use
resctrl_get_default_ctrl() while you switched away from it in the other
architecture code.
As resctrl_get_default_ctrl() is "intended for callers that don't know
or care what the format is" [1], here it clearly is required to be a
bitmask. Using resctrl_get_default_ctrl() here also seems to contradict
your argument for not using it in cbm_validate(). [1]

Reinette

[1] https://lore.kernel.org/lkml/fcad500b-3d8c-4003-b25c-6f54d2b5fbe6@arm.com/



