Return-Path: <linux-kernel+bounces-557218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E35A5D543
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78DF1890917
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B71DC184;
	Wed, 12 Mar 2025 05:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIfDJq6W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B91C32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755896; cv=fail; b=m8Az1hV/VUCt6JLBd36kUpey4MwnWqUskh8tSDQ/qyy4kf1lQ/SdwqDIVsLpfXFijANZzy0EO/6wA0SpxCw5Gq+GxZTBEn4kfBjnle5uPLoADxZDv1N3Ow9HT+Nq+lk3ZAYH5ghVcI6Iw7T2NzzsNyXLNWeyUcEdIam89XSbjkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755896; c=relaxed/simple;
	bh=Vu3HpUnA+3f2UgUMzMBihQcfAhiRwC3CGlr4Ked7Zek=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQHXBBZ/KV9e1iXuNd+G8L+KS1WHREYHax7f6l7OFy6tb9l20+13H14+2NIssWCvw9pojtjsnOmayDS6R2Ko/6QBShi5eu7PIdNmofAbD7BPHSOskWoHsv8d0bm61UqbjGoSVNZB25eLyiDn6VAJTZGQ3UvJ38OICkfRDrs9Mco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIfDJq6W; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741755895; x=1773291895;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vu3HpUnA+3f2UgUMzMBihQcfAhiRwC3CGlr4Ked7Zek=;
  b=QIfDJq6W2Qy2tZNk3f6mFrabEo7U/s4mwxjto552FrfrHD3+L/8hOHFG
   LxgiLZAadQwY51IyCYfiJt82gflZCpMyIquMJEaNOf3X89032m8tRFLfK
   f7HN4YNYaZgtRt2x0tySn3Ac0gsQSZ2NNXzK8BP6jebyLVQpHXCI+PB2C
   v6xzT5O0l8285dbJTTp1xzQYbjbw/VetTv6ScWyRV/KI6w2LFAK6fpx+C
   6ZSs6olsW0TOlzwZsAcnn73SILvxkCLpayouYTvhqzAHCdrnuC/l5r9+7
   5sh6vKWAes9TmpxMTOg7yGW51EXSxWuRHhIPM6uyu0CyNJZrENJ53rPNg
   Q==;
X-CSE-ConnectionGUID: vR+0Tu7wRrqN+Hl+V6NAQQ==
X-CSE-MsgGUID: UTqhB1+xSDKTPOAdPO4ipQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42693752"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="42693752"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 22:04:54 -0700
X-CSE-ConnectionGUID: nWwNIBlfSQqvHw7gxw5UOQ==
X-CSE-MsgGUID: o1Ny4YAYSRGO6A8qlRbOUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125585598"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 22:04:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 22:04:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 22:04:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 22:04:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFqo2nTaZi7kGdaZTJXw/SmwU1fSKcXJcNK9c7dqs/t6lX3SFItr/plK1DUo3B32XoWZdq857p/7T66OLRUwz+JNhVeYJKyP3MZtN7s/O5N7OvSbCgosarCZDzlxx+ZWTtOi1aAocacczCyXoPLXpAeEVuMSJpXDJJRe7AUd9ji0StH+jy8t1C+zUEORaX0XHyHyk8ki9aocwUdd/eArhDud8Y3EGRcZM/2b9fbV1SUHo35AVKaGEkAnv+RL5e0j4IHLhadu3Ck0MfRdJaP6a3vpQ86iB0PZc+bbL82pcF4tPXJ1rWMWQf1Bso+vQXBduVBNOlWZv99TC/JVKGJCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rCdc1SKQ0l2/orn9vHdyLc/VqIUIiXVB5Q7VOXDAO8=;
 b=MActgCAfLOrvTB/oed+rGPv+J2lR6nPWnnKCzRyNj3tGCoVmhgRpsy/aM69lF3/VMjo39Gr1BWm8VI/l5Mgq91HvKc+AZ8RANNdmIlowzAlACsWBkdN7sa3ylHPW4q0F0JaU+mfhZ8waBUS9MieyRgI+y3yEaVG0GJybPL4uXZu0g7cfRgTxQNPyAx9tFXlnrTu6G2oFutyp2CdvVUVnRPm+bJ1x07KVO+IWG/XYtyPCjqgRDb8cFlUHq4/xEXk9Ou3PgJB1S/A0eGWyglk09jvGGQLOophpmjmBzW08+I7PEVBbrsU+2zapB4YTehKHjtk4yklIbEo4gFvFBhkUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:04:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:04:20 +0000
Message-ID: <8172004a-4e3b-4509-af0b-3b60232529f3@intel.com>
Date: Tue, 11 Mar 2025 22:04:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8:for-boris 00/30] x86/resctrl: Move the resctrl
 filesystem code to /fs/resctrl
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H
 Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250311183715.16445-1-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:907:1::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c64c22-4728-45c9-9487-08dd612358d4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WS9laU0vbzQ1aHpWejladFYrcnZURzg4SDI3SFhJakpWTFpSZ3NhSjZyN1Z2?=
 =?utf-8?B?a1RuY2F1UHhpVXZDdndjOUVNbUdJWVo5YmdJYVErNXh4anhuS2Q0U1pCaFND?=
 =?utf-8?B?czZYL1lqcnlqb3Y5OG9zU1Bpa3JJbzd3czRvbUVFVXB4ejdubmZTaVdjV0xT?=
 =?utf-8?B?N2hzanNCNERrNFpMV29pZFpwVG81Tm9SYnYwaVREeW4rR21RMXBKZGZ4b1Zj?=
 =?utf-8?B?WFJVK1FIS0t4Rm9IdWRUYW45c3FJZFViYXI0WEduRndpY1FYcWt3MTdJaEMx?=
 =?utf-8?B?UnoxUjRHNjZseHJwOTRHRmE0c1hBY1YzVkliSFJGQzF2cDF4T3hGWTFDYW5l?=
 =?utf-8?B?d1k0MlFFYzNBZVBsNGxmNmF6YTFkTUNqVE5WTjNSOVF4MVp5V08wOTZGSkJu?=
 =?utf-8?B?bko3SHNBbXlWZU5FZkdRTUp0enFlRUVvdVN1OVIwU1hIYS82VkdKNVJ0TkJN?=
 =?utf-8?B?cTdWMTI1SVBPbkpCei9ER1ZBUVhJdGllQ0dWMnlCcG53M3NQYUZ5WUdud0J5?=
 =?utf-8?B?OGZVZHFJSThkMFFrSUVXMnhWRWo3aU0vMGNrMnlHbWxCRUxNNEp4NXFzdSt3?=
 =?utf-8?B?VWNYcjdDUktLSW5LdTdPNGEvNE9YV0NYYlNFWmNZaTd6ZGdXOTYwRnB6SmtY?=
 =?utf-8?B?eVRtYjVncmFSWmxobm44bVdqbHh0dzhWbHBhYkdXdldGTDNRYzNBMndCSXhH?=
 =?utf-8?B?cVd3SHRic0w0UGtlV1ljV2FlRndkam5DWmVNdGpWN0ZEMml0ejlRWTBYTlB4?=
 =?utf-8?B?dmV0Z0gxZnpvOTlQWHJ3eFBIVXgwVnhtOTMxeERkNlBieStKQzVSeFFnTEkz?=
 =?utf-8?B?a0M2VkVMTmkxT0dmNkwzZCt5aHY5YWk4T3lLNExlUlJieHY5VmdCTTg4cmdq?=
 =?utf-8?B?TkdDSm1Zcm44ZzFESTdua24yemJNWEM2QTJYbHNaQ0IzYnkrUjBjNkpmTkQy?=
 =?utf-8?B?MWVha1diNzI1SHB4b2hxbVJkODVuYWRpOVZwMUhVSmxtNDBUeUE5R1RmRjhr?=
 =?utf-8?B?RzRlVFMxcjFQVmlOenFJYkFCbGhzQ0JBR2xDVXdybHRQQWVMdFdSWEhDdTkw?=
 =?utf-8?B?TEhCeTJ5K2o5c1o2T0l0a0VVZWs2WXVVNW9iUkp6RkJBYW45RHZQV1M0U3Qz?=
 =?utf-8?B?M3A1SFk3bHJ5Zno1cWY3T3ZpYjkxekoxdG4zbld1Nm1oVFF2b1RLQmdha05T?=
 =?utf-8?B?bzlRT0ovVlRieFVmN216dFo2ZVNveCtwSUdIc0Fzcmg5SjdTT3RIMTYwai8y?=
 =?utf-8?B?bkgvRjcwQnBhTUZ5bkN3TktqRGpxOUpDbklJblo4elVZMlJTRGx5d3JvYkpJ?=
 =?utf-8?B?K3JUUlJXRWcwZFpVWTdzWTZuREpyNjloSDhjNjgreW9BV3hSTjdwTE5rT3pG?=
 =?utf-8?B?d21JaDN5UnhPb05RMFBOY2d5cTVpaXdIbi9FZ3Rxb3lDUE5vL2hGNFZhMnVD?=
 =?utf-8?B?RERhZjF4UVdmK3B0UlRLeFBIeG01VUhkNGJJaUJWeWNIcmVoUHBCdi83T3Ir?=
 =?utf-8?B?YXhlUTVMaUk2YkhJTVFBcVBLRkVSM2o4T2I2UkFRd0hiRWc3U0Y1WFM5cmdE?=
 =?utf-8?B?d1R1V2RtaUdENk9SYzJuelZJR1dJS3F1dWxDMUUyYXpUQmF2ZnBCYWtiKzVw?=
 =?utf-8?B?SzNLMEdNMzFFaXRaNGdhLzBCUUcvSzZSeUh3QVQvMmFvRUIxdG94bWJad093?=
 =?utf-8?B?TXg3YWpvVzZBeHdmNi9Zby9QYkRWeHpEUVRRNlpMT01JeUtSNVRYZU9lYWNP?=
 =?utf-8?B?SWE5TWl2dGhKenZsNVVxL3VvQVV3NXNUZEsxQlFxK2NhNXYybnN0VGJXNGdR?=
 =?utf-8?B?aFozOU51Tm1JZ0Rza3JwMFRZeGY1Q2R2c0lOczcySDJlTWJoRVNLMXUzV0lh?=
 =?utf-8?Q?Z2JGgqGNrwyFW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3dBUXp5dE1odWQxaGR6WFBWU0h6RTlOeFI2YXN4NGUwSXR5bHl0VTRoYUhU?=
 =?utf-8?B?andQRHRjTnk1U0UxMUhhWGM0S1czMm8wRjQ4U2d1SHpZdFkxM0RsWkVnRUEw?=
 =?utf-8?B?WHZqSW5uZXc2YW1xOEF2OVpKL0xyT0tQUjNFbGs4NVVhbVZyelR5TVBpQlpn?=
 =?utf-8?B?TXBXam0wZFV1WjJsdGNPT3NxUG1INXFHd2UyT3hEbUl2NDNJNU9hcFhnME9h?=
 =?utf-8?B?SXZERzN0SEdHbEgrV0dmdm1uOWNBZ0RCRjIyV3UvU0l5Q3B0RmFERjJBOUFn?=
 =?utf-8?B?Z1kzSDdDTFIzWDVFd2RRbTg3T3RTVlltdnBqZll5MDVMaGE0eXFZcGkxcFdP?=
 =?utf-8?B?NDVNTnIrOVg2V3A5SzFSOXlwUmovQTBlcm5rUU1uOHVHSyt0WGVnMHRPWXlv?=
 =?utf-8?B?NDhKQ3lNZUlpb0p0SEFBemoyVCtiYmZCVFJFQmxucEVDc2VmRzNhalhkVVlM?=
 =?utf-8?B?ZGllV0hyOTV5bDhIMHM0aHA3TWVGY0tyODlVY3lPSHdFWHBnQVBPSHR4T1lh?=
 =?utf-8?B?bkg1TktVamM5eXJQTFVuR3JIdHBBUUx4aDl5bFpsRS9UWUJoYjFYdEhWZG5F?=
 =?utf-8?B?VFVwd3RiN2JWaHl1S2FncnZlTzVrSXNSTkxEWGtBR3JFaDVyUlVhOFY0djNm?=
 =?utf-8?B?NUR1c3k2NHhNYlY5VHJ3UWFZY09TRGtURlhvQkh0SUpWcGhiWFdrRG1SWWNi?=
 =?utf-8?B?alJQU2tMV2JaYmdZcXh6ODkzaS9VRktPTGlQemo5WnViR3cxeUtPaVhtL2Zh?=
 =?utf-8?B?SlFoT1ZpMTZ0SmNZdXg5V1ZYczdJTzRzZnNzcUJhSGJxN0hqSkRuZk50dlpL?=
 =?utf-8?B?bGU4Wktkb0txbmZDRzl3UVBNekpZWTBHZ2p2OUNqVGgrV3lBZzJCZ3hidnBM?=
 =?utf-8?B?K1dYbFFhOWlmRFdWSVBETUN6SXBZSG42Y3FDZFRwdnhnSnVvMjhwY2ZjNm9K?=
 =?utf-8?B?L2FSL0xrVTl5Y3k0eCtMMXdCa2pYYk9pRFBWMGIxclJTUTlqMUZSdFQxeGZO?=
 =?utf-8?B?Mmc2RnIxR3VtYzdROVFSaG1FZkZrNkJscjN5QUJZdzVraGlsUWxOUEt6SVVN?=
 =?utf-8?B?akw2VzQvSk9zalE3Mm9ZdnAzSGo1anM2aEtPbG9lckpRY2hTVHlsNkNXVkVi?=
 =?utf-8?B?bGtYU3AzNkc1Q2YycFNDWS84dDJyT3ZOSkltUlBYVGwzb2xVYjd1bC9KUmdp?=
 =?utf-8?B?a0RONlBGQld1eUF6RVNxT1BSUjYxc3VDdDAyL0JKYmFKa2liUTdUak9uNUNr?=
 =?utf-8?B?MGxSdC9tSGZ4eFhiZVVNZndGWVgwYkw2aW9DQ0JuL1hkNW5RQzRjcUgxOE9R?=
 =?utf-8?B?NlczS1NnWHdsbGlUcDVOMmEzSVdhR1h1MnlXaVRwSFBHd3JVaHkvd25lUE1i?=
 =?utf-8?B?Y1pTTU9BZHA4NDNYaU81OEYyWTI2dGZhVG5JbTJwTDUzYWZ3SVlmMFJTS045?=
 =?utf-8?B?WEhmYTNCa0ZRMExxWExDV2ZYdU1xZDNrZllQSFIzcS9WSTUrRHAxSlN2SnhD?=
 =?utf-8?B?Z3VBa0F5UGRjM3dxTlJqME96TS8yeEM0WkNrYzRhQzB3REZvaTM1OTNGVklR?=
 =?utf-8?B?NkpPbkZqTklzTnVZaS9Xc0FmckI2MU5aNTk0ZTlDNDBRLzhHUVNNUXpIVTB3?=
 =?utf-8?B?VVlxUi96TzFtRlB3UmI1T1B2SHA3ZW4rcFNXTTIwaHpzQ1BITjkxb1BOVTIx?=
 =?utf-8?B?a2d1ZFNFZWt5WXp0ZGhTWjVJWUhJOE1ueUFWZkdlTlJhTTBROTdEZkN5alZ0?=
 =?utf-8?B?NXZIaXE0QnZaZnp5R29zSFhySmFoMFE5eE1jREdERG9QR0I0aTVNc3cweVBL?=
 =?utf-8?B?OU9WQmJxRDlRUzJrSGovN1Z0eUdCdk41SVd2MndpbjJtMzJRSTgxSjRkVWY4?=
 =?utf-8?B?Q05qVFBLeEFTWGVFYkZ5aHJqZTNvMldOK0hlTkJEb0hyaUp2RGZFUWo3RitI?=
 =?utf-8?B?SU9OdUxHYmJUbDExSE9FbzVHWGNEd3RkcVVlZENRd1h4Z2Y2K0NPZFU1ZUFq?=
 =?utf-8?B?N1hxVXEzd2NWbExyelY3L1NyL1hzM3lWT2twMHl0Wnhoci8xMGgyYXA1K0lE?=
 =?utf-8?B?bGtLdkgzdDFkSHQ4ODBaMTIxVlEyckRaZUFaakpIbENiQU1KS0djc2tUeVBZ?=
 =?utf-8?B?UHV3M3FCY29KalZzY2lBVHlWakV4VnVrVkRDZnFoSlBsc2pQRVk1ejRxYnBD?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c64c22-4728-45c9-9487-08dd612358d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:04:20.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vK3GlWtkC+dgR9DfTKnCky6duRF5OGHh+3rOCaZT2ZzAAulnE5iIpGzx8EgAF0ETig2AC7v2qEn5zquh2Hr++p/LH//WxYgc0ubmskOXF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com

Hi James and Boris,

On 3/11/25 11:36 AM, James Morse wrote:
> Changes since v7?:
>  * Series split to the first 30 patches, requested by Boris.
>  * Fixed stale function names, definitions/declartions and typos.
>  * Dropped the use of the default ctrlval helper in cache_alloc_hsw_probe()
> 
> As ever, changes are noted on each patch.
> ---
> This series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there should
> be no changes in behaviour caused by this series. It is now possible for
> throttle_mode to report 'undefined', but no known platform will do this.
> 
> The driving pattern is to make things like struct rdtgroup private to resctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to disable
> it at compile time is added.
> 
> All this is to allow the filesystem portions of resctrl to be moved to live in /fs/,
> which allows resctrl to be supported by other architecture, such as arm64's MPAM.
> (What's MPAM? See the cover letter of the first series. [1])
> 
> This series is based on v6.14-rc3 and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v8_for_boris
> 
> As ever - bugs welcome,
> Thanks,
> 
> James

This series looks good to me (just one nit in patch #22). All patches should have
my "Reviewed-by" tag now. 

This series passed my testing with only a 0-day report outstanding. Since v7 passed a
0-day check I do not expect there to be issues with this. I believe 0-day will also
automatically run a check when patches land in tip.

Thank you very much.

Reinette


