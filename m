Return-Path: <linux-kernel+bounces-561848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17289A61759
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42FD1897A89
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E12046AC;
	Fri, 14 Mar 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYxOf3rn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE920459E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972777; cv=fail; b=H5L09CEUuDYeRicCVPb1v8z4HuGMQeDzZtDba0s/vnIoYgvAYRpKIv0FTO8t1ZcvFobymLOfG1qRdanNc3k6kwZPyyIGHDFqsBDMYgkmtGOKCSVDreFhTR1E3IRGWZGMEEGoJRtCIAms7rjpwgAigT9MzNF5Xo/4tWfOTD8pdLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972777; c=relaxed/simple;
	bh=xSa9yI0mcMzzN4DeJ10WUdSGeO70i03UylfF8NkWMCM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QJkCP49AVvidhqGkyRfu4nsbCOShH2JbzNU2ce43DA/b54i4DOSoBWmvqqVUAe7p4QX+4TaHlXAZwbz2wUZR0G8nq5imY3NVifKVg+ESj4IsE/qzHOrMZfi5Y65KrDwKohjs1Qp14cKZ18pPVB64y4aYCJwKxzwyWa/2gVQT/oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYxOf3rn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741972775; x=1773508775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xSa9yI0mcMzzN4DeJ10WUdSGeO70i03UylfF8NkWMCM=;
  b=AYxOf3rn4cU6yKI05tVgZOCjZBdZvfgiA5yEbV8ykjT7cHpL+LjFDAJp
   wJApku/CUk7k55by4OrAkdDqlIy50NvXMDyCRfbM+P/REyfcF12JeA02g
   foT5j9NuuiLOfZnDuLfuJlOswWLqopM51lSZ+Ro8GZmKZOq/3Oh7jAUoH
   nQzSsmbe/W1WNUrPky6eoS31MIn5p22CXlPpvonpIkCA9x7E3rW6jCis6
   AZaPyyDQCtwRGaz5PJXlYU48L8diGGJTyB135PTskD8qUKQ8eBEwmgJ55
   +V7IE10LAR540OpcV77bogM9HK+4i8n5WhVH63+brdCRFvAf+z+6B5C/E
   Q==;
X-CSE-ConnectionGUID: Zp/YJTPcSmO1G0yxP9A2sA==
X-CSE-MsgGUID: K9S6Z6JYRGuJl3j2ZYd8oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43022302"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43022302"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:19:34 -0700
X-CSE-ConnectionGUID: dBtjnkqcTiGbE4m1+5zPrQ==
X-CSE-MsgGUID: 7cg/K9iQReCbS79KNAK6tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121291729"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:19:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 10:19:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 10:19:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 10:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4MLunASuKBZ1xiUiUP2VtuGnZQCp+fWTXuJSAw4HKrPFw5L3qN92Yal0LqLguJDNt5TNB7AJXT0seKuGOc5tU9Mcu+gJqYe6KKf16PVC5r6TPoD+uFpy5+M4q4LJJNaqfjdoAIF2xoIxxSsykE3Mknif3R1a0oRVHXbR8Ct/+zZ/DKwNHB6PZoAw7y1vDLXC3vHf5RLVCBJO9HinbJaHo2VF4+5j5yBlMh6JKIhqsAMmyDqq/tGnHPZeS1DmHh1ZZc5fgiJ6KEVGN593dLqgD2HoxJ5Umlfb7z+Q2PPgwvMH7GlZus/yBUi18BcLLap0URNrJevVZ5qcVQQuCvx6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ccj52JfT+3sj03FTXXJn9XGoNfydVUoZ9l0Wl6D6MKw=;
 b=HW21w8YAQqjecZyqkR9sj+epGUCq9C5u5zTcwSo9q5a0glbSMPlVOYD1JwyrdCv70/YkjZZj2EwpQGCQa3lwR4nXMPus6guCR5ifqW5ysNr5PQ7couQUuUEdwUfidT72tdv5yJEFN3z8R7+ZBbjw4sHZOofGWbxxYaj2HNBnJr01+7C83WajE4UhhxmSqEKHve05iVqgJKYftJbNvOJ+n8dQlTKW/0aTmfrF/7BE7zNL+VelemW9Kehf+au7VcCLBFUcJgaKNl+ch7rTAydG9uQ5QTUD2yJMJrEfsV8rI3vN4sexGBCIgj35XJYpDszBsQUZd5JPFNe/4jDX8pkgGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 17:19:30 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 17:19:30 +0000
Message-ID: <b72d0040-99a3-4f20-9557-099d00b1b3ae@intel.com>
Date: Fri, 14 Mar 2025 10:19:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] x86/syscall/32: Add comment to conditional
To: Brian Gerst <brgerst@gmail.com>
CC: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "Andy
 Lutomirski" <luto@kernel.org>, Juergen Gross <jgross@suse.com>, "Boris
 Ostrovsky" <boris.ostrovsky@oracle.com>, X86-kernel <x86@kernel.org>, "LKML
 Mailing List" <linux-kernel@vger.kernel.org>
References: <20250314151220.862768-1-brgerst@gmail.com>
 <20250314151220.862768-8-brgerst@gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250314151220.862768-8-brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BL1PR11MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 045b38a8-48c3-499b-9380-08dd631c61ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFFUd0VXVlhWYitOdzlFRFNMWXRNQW9rTG9ZT1ZKNlJuazdpbXdvUVNLZ1Qr?=
 =?utf-8?B?YlUxa2p3MDNGKzFiRHVhbFZoQWxiT3dHSk9peEpnd1k2dTJza3JCZklqRjBn?=
 =?utf-8?B?cmZuYndYQlRiMC9aUFRRRmtIekRhcmE5clJydzIwMGY3SXN2T1BhblBpbmo5?=
 =?utf-8?B?ZjR3R1VXejM4UzJSUUhqeXgzRGs2N0RKMFA4WmZWVUk4SmRKNXRHMng0b0tH?=
 =?utf-8?B?YjM5M3U0R3FId2NMTFJxQ0w0QlZ2SGpHN3ZaeWdZbkVZUzZ2VnYrRHZuWk1K?=
 =?utf-8?B?d0RYYUtueFdoSDZwVkh4b1prOGRKMWhYTkFzdUJ3cG5ud1h0djVRSDd3ZFFt?=
 =?utf-8?B?UXNsNDlxQzJGQnNmWlc4cWk3NlUwb1c0RDhzUGFwdE8xWjBZS2hGNWc4Z1hm?=
 =?utf-8?B?STRGdEFBRm05VFVMbE1abWxnQTdKV09JNTZKR21MWFRWR05YT3VRYVRBdExV?=
 =?utf-8?B?WEpNcmNBS0NTdVZraXVBcnB3SHFXMjVrOWZqVG0rVk9iR3BJUytBSlVTdFFB?=
 =?utf-8?B?NkROZVJBT1dIU05IbXJmZ0ZBWjhFQnpmUWtxUTRGR1ZHNUM0ZlJTdFB0bXZo?=
 =?utf-8?B?NUlMQ2o5cWhpT3dqTEduczRxOG5ZemtxMjJ5OEdzZVBHUEdzc2Rkczc1amhw?=
 =?utf-8?B?YjZRaTF1bjE5Smh4SjExaVhFak92MkEwdWJ4cXFlNGhXWGVLaHNHUjlKVzhS?=
 =?utf-8?B?SVhmdWFGZzRFalRQbkJERmpueGFpQ1Q4NVRrWDVjYkxBQlVLUW9LMDF4eDgz?=
 =?utf-8?B?RlBSU0NraFF3NTU5RWp4ZzJmUGVzazZsNDBsUEFUMnh3Vkh4VmxVaGhyZklp?=
 =?utf-8?B?MDNseG5pN3BpZ2xTN1RjeENLbFAzTUc3RS9mSTBGTGN5Wi9PeWFaRjB1djg0?=
 =?utf-8?B?RkFOOWpLcGIwQnlHUWhVQ0IzNUtpL0FFNFNSR0hlaCtYSVhpVjJCU1JFY3hW?=
 =?utf-8?B?dDVhSU5lUG1nVHlqNlFZUFJFZ24weXlUWDZMZjBKQlhWWklpRURGVDA2R2Nr?=
 =?utf-8?B?L2lNbzNva1FXV2pqT3NxY2lZeExQVGxMZkUrWldoZU5uaDV5eDNRU3dBQVV2?=
 =?utf-8?B?eXVudWpTa2g3NUdtbXA5cWt1WnFrbTY0anlUUi84UXNvSzNNdUtQZUJUVy92?=
 =?utf-8?B?Q1hLaHg3Rk1JOGR5eWkxeTJSZGlrV1FONitxNDNrUm54M0xTWXlDV1FLQytL?=
 =?utf-8?B?YkgzQWt6RDByNWpYZDMyZUs4SW9mVElkcE9GZVllM1FSbDFveit5ZmFIbmRF?=
 =?utf-8?B?NXpWSi93T1p4dXIzS045bVdQemxOMXdQcTAzSGpYc0hqUDRRV08wbXcrVnJx?=
 =?utf-8?B?VU83dWU2L3psdDhrRHQzOVlvNWJxbDZ4SDVCa015bnNIbDRHNjdtdnRoN1Q4?=
 =?utf-8?B?VmNReUovdW1pRUNFZ0ZQZnNjcXlSTXdUUS9sYzlFZlZocFp2KzIrMnBINGJn?=
 =?utf-8?B?RmV3ekNpUVI4Tk5XaXpCVU51VzZ2WVVXblVMTUFhd3F5elRkRXVnQnVLd3Zx?=
 =?utf-8?B?WVVwSHlZMTBncks2cGVhTEx0cUpVSHBxU1lmTHZLZ1dxbWNtdTBxZmEwZlVL?=
 =?utf-8?B?c3NpZWFpQWxBcFoxdGQrV29Wa1lqNjdwMi82OS9HaEtnN25Kd2M1YlJ5MURt?=
 =?utf-8?B?QUYwdThIMEdTbVRlOGRYWDYvT1pjYXJHWTF2bnNYV0ZWTzZjaytUa1JWa0xo?=
 =?utf-8?B?eURxMGxmTDFWV3U5UXJUN3BNM3hvdGN0azhPTGpGbHBJcmhhZ0wzcGJOUVEx?=
 =?utf-8?B?Q0h2U1BkZFUyMnZMNUdKNE5FRytlL25UT0NSeTdVYks5NXlMRDVWR3hUSVBk?=
 =?utf-8?B?SjdHSHdpUzBMdnlSN2wySUxOT3lIOFRMTU1tWis1MmhPeVRpUGNtb3pOL0xJ?=
 =?utf-8?Q?+HlBvYvdJD1NN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBDYWFjVGN4SDBXSlhHUDZaWUIwdml3QUNFeHhFVkZ1L3UrZ0MrNnNjcGVK?=
 =?utf-8?B?czNDZmtoKzlnMUFHenBhaVIyb1djbHJnM0pvSEtKOS9wQVlRcVBZazlYeGtK?=
 =?utf-8?B?ZFp4a1JnMzJmQWJDRExyaHJTMHY4a0VqMnQzWXhOTVhtZG9rU2s1bndvSk03?=
 =?utf-8?B?ekZHdi9vLzZVT0RvY1FCdWpHcFFFeW9uQ1pvbmN2NGc4SkdvM0EvTDhydzZD?=
 =?utf-8?B?aXRBaTZZMFBpWlNkWDA5OGVaSE1FQU5pdDJocXZrOXJSRTU2R2hzeWdBajA3?=
 =?utf-8?B?L0tET25nZ1lxNkFmVEZCTE1sV2VVU1V0czFjWnhyUDlVSkV2R01Ydnd5bHdw?=
 =?utf-8?B?Y1NoV1Nlb0RKcTQ0TW80cnpUYkZXNmVZL3lGVURZdTFQQUtneGZKM2UrNy82?=
 =?utf-8?B?ay84bjN3YTNEaklhRzJqWW1wYmw0SmFocjBLcTd6Q3hoREJXOWs0U0xJc2Jn?=
 =?utf-8?B?a2psTmowYlUzWEFubWtJelZ2aExSQ3BuYTJ5d1lwcU1ZcFN6cHRZMDFpc1E1?=
 =?utf-8?B?dTEraUxDQzJjbXV1WStRNmRaVEhHZEFQNnVQcU1sREhFcHJsb2xZZWVzNTA4?=
 =?utf-8?B?L3J3eVRmdlB2NXd0T0V2NEpLU2pkdlJRTVhBLzhVTWFVeThhUG0vaVZReU50?=
 =?utf-8?B?cW1DRkdPeDU0Ny9tK0ZIcVJyaGNraU16UldOK2pZdTVhdDlXWGRSaXpNRWJi?=
 =?utf-8?B?akdXSXUxOUZJUm1MSHZNdTlVVElaTEhmOW9lMkxpT2Y0L0I1ZzR3M1RFNmZ4?=
 =?utf-8?B?c1prSit5WnVDSEhyL2NtWWtFNUFHV0Z2WUlHL2xuV2tkTXo4NnpHOVJSelJY?=
 =?utf-8?B?VlRqNjR5c21oOXJiM2VyZmFKbko0bWRqQ3luaW1wTjFtS3U3T084bFVjcW52?=
 =?utf-8?B?NXBPeXNvYzdlOW9KOThFaVFkOXdPRzVIdGV1UXRNUm9oeTd5WDN4QzYrS1FI?=
 =?utf-8?B?Uk9QREpWemVGS253MEgxc1ZtZjhGUitCVHpGN3lrcCthZWJXM2w4QUd4S3ls?=
 =?utf-8?B?Zk9KeU1PbWNRTHFmdm04VktWYk1lbGF5U3JmWnZ5cGxNZnQ2NWlZMEZ4QjJ1?=
 =?utf-8?B?Z1hXT3g4OEN5ZzdIUkNWY3JIU2habDRPRTgxMzJyNU9KMzVoMC9RS3VqbjZ2?=
 =?utf-8?B?RFFIMkVQMEZ5UUNuVjEvcnJDdTdRUmNTTytuMG42OTgyc3JkVWNnbGZhK3Jm?=
 =?utf-8?B?aW51SWlhV2p6ckJJYTI4TjNsNVN5V0hCNkp4OTd1REthTVVlb3JYVWZkb2RV?=
 =?utf-8?B?NWFaQkZYV1FDNmdWYUJPK1NLK2xFSFN4RjVZYzU0WmNvWVpKNmQ2Y1M5M0lv?=
 =?utf-8?B?ODZvZnhlVFpXa3hJS3QyWWpidFZWQUs4Q1ZIVWVzaitzb2NmYVoxN0JoUkVw?=
 =?utf-8?B?dUNyMDg1N2JwWEkvSFVXeE1rUXVQRXgyZ2YxeUVpWFM0a0M2QkxUS2ZWRElh?=
 =?utf-8?B?MnJiTXhWUFpaNUZQb2RQYUhnbG5lZmpxQks1YXYzazA2M3docUlIY3FwYkls?=
 =?utf-8?B?R1dJRW45VVlyMy9XcGxCajZqeVZFdWhFc2U3UzFQQ2FEd2c5SHpjY0laUW5h?=
 =?utf-8?B?MmhYMk9CeUR0cCtUUE1BUlJXbTdsL2hGYU9EZ0k3cXJMZ3pSTW5ZNVhCVzdh?=
 =?utf-8?B?dkVacjdUeFpzcHZZWmQrcFRJcjY0a3dieEI2T1RKczFMSXZWbWxYclFZeVhT?=
 =?utf-8?B?ZVU3SDdITmtyYnNjRGJndkw3ODFJYy9qVkhGTExtMURBZUZEb2t0YW1SWU15?=
 =?utf-8?B?QTdIY2kxZFpxKzJqQmlOTlpJbHo2cm4zL0pjR1JGa1kyK0hSaFRXZytKdmsr?=
 =?utf-8?B?c1gybGhsemJaMmw0VXhxamtzV0ZJNi9UUXgrUUhNUmQ0ZmZoNnJob0UyNm5u?=
 =?utf-8?B?SzZkZktGZWJoK3FXVE5vWWd1SUI3bmd2RXMvaVVGbnlURjZuZTUzbFRIcHFJ?=
 =?utf-8?B?NENIRnNNMElvbllOak9vcWJxS0VXeS90c3VsWGxReG1RWHJhMG1qeFNzcm1i?=
 =?utf-8?B?b1RKb3cvd3lWU252SXh2MWJJbHRoU1dYYzdJZVp6T3VjRGo3TTREVDdLTVRq?=
 =?utf-8?B?R3duYkZvc3ZsVVc2WFNtUkRJUjFkaVJsb1NLa1B5NTEzdXEwN0s0NjZiNWc1?=
 =?utf-8?Q?LTUGti8Hpm+uh75N1kIb8B65I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 045b38a8-48c3-499b-9380-08dd631c61ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 17:19:30.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgGezqtVbdjZk+vJ7f9FYVa92wrZ4A2gP4ZgEtbLzJalwTb43T2aBoXKLWVzCZwhcqkfm4tLA8r5lnWyT4L/lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5979
X-OriginatorOrg: intel.com

On 3/14/2025 8:12 AM, Brian Gerst wrote:
> Add a CONFIG_X86_FRED comment, since this conditional is nested.
> 
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
>  arch/x86/entry/syscall_32.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index 993d72504fc5..2b15ea17bb7c 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -238,7 +238,8 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
>  	instrumentation_end();
>  	syscall_exit_to_user_mode(regs);
>  }
> -#endif
> +#endif /* CONFIG_X86_FRED */
> +
>  #else /* CONFIG_IA32_EMULATION */
>  
>  /* Handles int $0x80 on a 32bit kernel */

Also, there seem to be a couple of adjacent CONFIG_IA32_EMULATION
sections in the file. It might be better to bring them together under
one section in this patch or a follow-up. Something like below:

> diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> index 2b15ea17bb7c..a84f9d3c1695 100644
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -57,16 +57,6 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
>         return (int)regs->orig_ax;
>  }
>  
> -#ifdef CONFIG_IA32_EMULATION
> -bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
> -
> -static int __init ia32_emulation_override_cmdline(char *arg)
> -{
> -       return kstrtobool(arg, &__ia32_enabled);
> -}
> -early_param("ia32_emulation", ia32_emulation_override_cmdline);
> -#endif
> -
>  /*
>   * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
>   */
> @@ -87,6 +77,14 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
>  }
>  
>  #ifdef CONFIG_IA32_EMULATION
> +bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
> +
> +static int __init ia32_emulation_override_cmdline(char *arg)
> +{
> +       return kstrtobool(arg, &__ia32_enabled);
> +}
> +early_param("ia32_emulation", ia32_emulation_override_cmdline);
> +
>  static __always_inline bool int80_is_external(void)
>  {
>         const unsigned int offs = (0x80 / 32) * 0x10;



