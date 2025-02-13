Return-Path: <linux-kernel+bounces-512422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1BBA3391D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBD9164858
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0672820A5CF;
	Thu, 13 Feb 2025 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dq/ab+QU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709F2063C9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432724; cv=fail; b=trijpPR5VLR6JcRwm1juP5IgSlwnd7b+y0GamdoDh3fWx/As0twoFiEnCe9l8j32ELjIBnDnKhElETvsbtFMtyhW1Sru6NgdJtBdx5No/xxYewQecRmo0n/wuU30njVaoyZzuu+02l6gRuUmBbMmAPsqpELejsH3CQlgNCyMEeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432724; c=relaxed/simple;
	bh=BjVvhyWUmv5UckkuRHYigjbV+rrB78Od8uTBxU3VWc0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y8tr1xXwHB/OO+8NQ1JCnmFRYGjm1GD3BmVqUJAPcA2xkpHwIX3bjug3yciRq/8O/RlKq2Md34dRFjefRofvNmIS/q8NmlQrhbczNWGuRbQd770yxIsmkgMtlcZ0FzFmu4M5cRRDKP/oGJIkxhE/+QfxpjPVD/BQyfT4wohqzfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dq/ab+QU; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739432723; x=1770968723;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=BjVvhyWUmv5UckkuRHYigjbV+rrB78Od8uTBxU3VWc0=;
  b=dq/ab+QUMV8dxLDkDRGYdG9f0SEq9CFz9T5L40gxatzEp6ImT/MtWWum
   4NiY5/acGVt0YMkUuHSsIZKNsyn/IlTm7YUlThnz5NxQDpsTmQhCz6uty
   qzjVfVu1yInmiAXL1Rz5HhzUGhizA47oyGyIGxOcDD48M36qyExso5m1Z
   xB8jl0o1AUtASDIY6WKPzPSGt5SKdlNwmqqyL90VQ1c8zvpWyCaEIwagb
   mfwHkRWYF1Ewp50BE78XgHwzp9za7NVdtjClyzhDI4vbaF6//DF9dAL+T
   mEyYP2UQ8zvEiXE0AP93YMIMvLX9bp3/fAiVr4nwbCoNkIdAh3+ulIPlN
   Q==;
X-CSE-ConnectionGUID: ai2tDg7sSbyxGlQ7bVydEQ==
X-CSE-MsgGUID: vCf03qQzTzuS+ZD/Ks2s8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39307697"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39307697"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:45:21 -0800
X-CSE-ConnectionGUID: 0uI+yzehR0GKmYVDJzHJxg==
X-CSE-MsgGUID: LgWJ1LlBQhy8sDVxIACuIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112907843"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 23:45:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 23:45:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 23:45:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 23:45:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwinPUH9smv5HfEK0vXBjBoj852Y8/r/7UUIJB4SNfw/fLGrol0nL99wwvIEjDIq+Ws87wkcAo70tPJDmVXrx6NVHgQUgaYC6ZW638zLOCAGTmYkUzCt4xGKILYaqx/yDByvp9nRoojaDuX18s0K9WjUQ9o/Br5Hzxc2vhHrdC5s1HUCT1G0VJW5lI0ihqNeZdNO1yXNQ6D+gv2hthcxywBxRlc8w/NyNAkN/LHhClTu9eRN6iRVS6BapkE8hy8Lii8KIeJ4/5WV2HHADFHHMQe9B3PMuXi72sz/4HRe2oA1RhoQNzc1T+jraVTn/WEdP7CGnw/B9IOnavNTFufUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COBc/mEnec+03zdVBVMHfZjkDWyvELpGEjbNiNb7qZw=;
 b=GI2aertjxyFP2E4n4Az8C5s7gGbhIeeiHXai359Dp5yqfHBKKaqHnJ9MHEeCfXnhFwZ24KGNng6y77nLR2Kew06izXYUl62y8U9D8n8Ej8ifmRkp6H2vjR6+mcXVD8A6xVCfcmGxvXw4apTeVhTdV96z7qpJ07Up3OtwXaGuDFu1Fk08VGr80s4mSfR7SXOxTgKC0A2+owb8zsADu4hsVc0UeTrMpJaPiNNP6shJrLtA1D8N0bxDnLtH+XOwr4/9TnxXQXoVeSwnYBZsbKdvyv2vMqn2r+Wh98bpEZso514/CB3qToHNIPC5ZXuWvr3SraFA15tiHuusyNra6fuGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 07:45:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:45:11 +0000
Date: Thu, 13 Feb 2025 15:45:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dave Penkler <dpenkler@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-staging@lists.linux.dev>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, Dave Penkler <dpenkler@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] staging: gpib: Remove dependencies on !X86_PAE
Message-ID: <202502131453.cb6d2e4a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204174254.16576-1-dpenkler@gmail.com>
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b2f1bb-ccea-49b7-a172-08dd4c02585d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eRYXtLuf/UlosXG4d8AdrFSR9+Lpq8IqSU91jViGRAKKLki4GQnX1ZOe1cb5?=
 =?us-ascii?Q?9uPrlW97Uy6nrCYoOipMJll4lpWZFUz7ii6kqTLISD/xXB8rDMQquQI2omRt?=
 =?us-ascii?Q?+luNfnfOE673hCsMLacr0pk5i21L1DHdlTaNmC69h/UoqmonG9sKxRYdgusO?=
 =?us-ascii?Q?RvbsZTQAmmocWWbZ9tx321WYfSnsCW6JC7YT5lKgvVHwbGvSJdrPRoRi5uEh?=
 =?us-ascii?Q?+ci0R0qma8R3b8PcTHrqd41b1RoGdLoTxrPi8tlIO1LMZrvCrGREPASLmaQS?=
 =?us-ascii?Q?J7/c7iefPxK9JTdURvjAU9ZuaabTnTUtwrWn6bwaJJS1KCpY63zzXlilVZ/E?=
 =?us-ascii?Q?GLxzF1bJ2UnWjEZzqzctpFg48xmUuSv8HNW9DyoiJGjs023Z02rxhcpuh7bp?=
 =?us-ascii?Q?mVSS4Y/cdxUhQizknBGi2rJfkiIsM+p/jjiiC0tdWWunOMNBLadGkr1I1+Of?=
 =?us-ascii?Q?DWVKdTH3wIUyCXv5DPV3IWKpdQPnkFliHJIFJY7Y152B/ZYn6kbOK+qL4ZGk?=
 =?us-ascii?Q?iAGeJKq7rbdG6br2nQH7VeNAkRvG6gBP/4bYb4k3gseb2Gsywps00ptePztD?=
 =?us-ascii?Q?+Y0JdPlKmhwX2xhkAaBjDj2MXL+IfD8zsTmrOzsHZyPQdSjF1l34VItncbQp?=
 =?us-ascii?Q?mSL3X4N5/qj2d/exe6NoufDjVogV2nOKinHJgP1tN6sqNIaJQS1LMu3ryB6G?=
 =?us-ascii?Q?iyRMp1pHuTWONOryXcT4KszOJaU/E3pFXDYgPdnA/8pcj4Cg5gd1G0mozE93?=
 =?us-ascii?Q?JLCigLg+RpJAH4V4XvmABCMNvIy646zCMhsuLDe6LjHp2aj2ECXWL/91S5sl?=
 =?us-ascii?Q?c8JM2GHMXKeg5cx/5vwACfI2rzTtfq2DqL3zP3NKG75H+AFVKlYnKdjvtTzB?=
 =?us-ascii?Q?A9ZY31z7Rc05MF/+8/xloAc3ciS555yoNlAhe9aUy0a7W+qACV4YFW7k/5u1?=
 =?us-ascii?Q?1wiIMX4XYrQm8gq17TZHr188iBu2Pz63I6HBhJ1hp6uYjf0fMFaFx8YfhsKg?=
 =?us-ascii?Q?/Pit78C3m+mYSX2B+zIW1Z3jnVkd1JDkR/83TdVDdcUVkt/cNEC0gb8lizo/?=
 =?us-ascii?Q?sJa8pmC+VQuy5rgvcuhLRkcvzObD+m1ruYx1Us9vzxC5GOqSltOC0pjtgJVJ?=
 =?us-ascii?Q?FXgfk2kFFIRam7D6ZchNj3pTdQ+xbziw1ygtlPQl2O8ctGS2gYsuKhLEvOSu?=
 =?us-ascii?Q?fkmZ/eaaHNX0+J0q6bMlb34NUjmqz2t+xFRbnAqrqB5Vpb/ze72+4K+qimGW?=
 =?us-ascii?Q?WS6j639g4keX/tSjCcqRK4ue9tQJx9j7t/Div0o4wChgi/EY/ADIRLLu2dVG?=
 =?us-ascii?Q?CXgmj8zGKWWzI8eEL/IFSQtuPV8lGBBK3klK1CTI/ZadPg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hdJMHuFVQwUeC96W6VQWke5UrB87WIpnzwOCPR4hGSco33I2wokHv6B2bUo?=
 =?us-ascii?Q?9Adzr9XfMjLmFcjLMw4SldwV0TaMNQq8HCaNXB0OBuF1BfjxorvQ0xJfnrJj?=
 =?us-ascii?Q?y3/ys9JqCzMjCKdFAvm5QXJgV3iMzvmB+wcyc885jfO5Mr+qtTlSjkmvKja9?=
 =?us-ascii?Q?ZiIXThvH2sYfn7RJmPGUpLYeXiC0AEh9ae8Bt1RUWwHed4uwJJbnuoazXoap?=
 =?us-ascii?Q?e8c9tjcVEv9ymTKyQ2mUxv8+8or8k7/y8oNM9aQcxvP0fsHu3lsAf1fGCmTz?=
 =?us-ascii?Q?Xhsu8xVH09FyTtj8OaUBG0pJDb5QSp4HuQ+J4yMn4broNGaeCek+n9C7LMSN?=
 =?us-ascii?Q?KLuDE4KGbLeLyDEKIf2/hfyc5X4r/6L+HXFv4Ncrun4H08m9uM3czrjHjD7g?=
 =?us-ascii?Q?d/HpJwQcLnlFb3e4Fq9CA/r91jIZ7U4T3IeU1vdBn7B/KKcBERbFYHpg1XZ6?=
 =?us-ascii?Q?wvIZvnDFzIIgzZVX54WTvWkmtqVQAdxb/yeN5V0LCuLcnsPBv3Kgj5CavUWS?=
 =?us-ascii?Q?GPI683/bz/Ydox8UqTMAxzw1exg+SKdLTF0dJRKTNThwtOP8S2O9ilV+8KEf?=
 =?us-ascii?Q?keifM5likL3M7gp6pFfLgGIXq8ii5iXH64jpCOhwVN315Ol8tHwq8Hzwosob?=
 =?us-ascii?Q?jmMya5B0saWl7QMeAuP20nOV2aRUK3yJVIClhy0Xk0Rqp7c0Az4lbHQl7Dwq?=
 =?us-ascii?Q?Xkvi/645g1SqbpzDBikzbZLp6hXxQz8rpGlMCigSGu6luV9ouZZgOgBhcJWX?=
 =?us-ascii?Q?guS5c1pIMuyx/57lgpYm3ekLvFzQlDNAk5LtdzK42lZbMFYxEhIbmxGLEpcN?=
 =?us-ascii?Q?Zuh3g2GcbVp9Yw6UB/Ni0TVR8N1CdlRvE+ghyKlXPmXmsnGOgfVRIF2U8iqf?=
 =?us-ascii?Q?GLrCAO4DrgLsIk4aHJ5yH0fBxjMYFUEzH7/Kvx+6B6N2oWEV+3/F7FzVRqIT?=
 =?us-ascii?Q?lmXnW5u8awtH6j2axNqQ75HKT4N9j6Jp4UuC2s4d4hWgj2trV5Ow7BdK6XN+?=
 =?us-ascii?Q?hm/o4JUUD1dLxcOE9KpkamER+8GzOIKvfx/03Vqm7KuiQNQzZd0fWLNrYtPI?=
 =?us-ascii?Q?oZv1958SlrhTxs8B0ARNJ/Hyo4y2ucXAfAp0pSAa7Lg4d/rrDcUVXmBQ4OL5?=
 =?us-ascii?Q?P+qsmliWGI1V2OkfClYeb2kheA/lKfIFxvBJKlywnUmtrLhqh3aWp5r65O5Q?=
 =?us-ascii?Q?cC0HS/8j81WtE6E/p9xmDOWwvvTktxx72XgAZlN/GChpHaFn0jeLwbasBxhD?=
 =?us-ascii?Q?69k0y68Om0i9rMu+E5rsgbVUiLW7Lrxxuf1EZMTbj/3Z9GSNIDwFYid7Lo/f?=
 =?us-ascii?Q?GFinxZ+FB87xWw/TnadPEIDdNHA5lAw8rWdwhgS+VbSSoi0yZYwDzUWRrYtD?=
 =?us-ascii?Q?RsH/X8DdmMZtbCPTBmbwKQiNMfgLfEbx3YtWXlFS7kS3OpVLb9ypNT9dvkit?=
 =?us-ascii?Q?8UA/7XBFLKYu29eQmpVVAXgaYJlS4HFoZ1JfGJLh1pGo6y+T0D521BDS0Ci+?=
 =?us-ascii?Q?TGlh7iPn7JuklvxscmdNj/l7ZzQaKAW2+EUoEAbwi+AOqjRgfhj1y2kTZljm?=
 =?us-ascii?Q?WRd67hvuOCk5iyLYR2lw1J8st06795EygAxgVq2XRreJvgLGcK+hIyNhQthW?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b2f1bb-ccea-49b7-a172-08dd4c02585d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:45:11.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoWTiHqaj8dvhp+RgIZNDRhWR6+WiJqnpJn2leId6NK6W7jrR1rMeSeuHxs7RcDCElm6hAVbTbfjWMD48jXk7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com


hi, Dave Penkler,

by this commit, we noticed the config diff with parent:

==================== PARENT FIRST_BAD KCONFIGS 7b66aae77da56f2eabd92d3fb012d2fb98212bbd ====================
--- /pkg/linux/i386-randconfig-005-20250211/gcc-12/7b66aae77da56f2eabd92d3fb012d2fb98212bbd/.config     2025-02-12 21:02:39.882369919 +0800
+++ /pkg/linux/i386-randconfig-005-20250211/gcc-12/01b060a1e15939da2119458ea676709c33f0d26e/.config     2025-02-12 17:50:30.932361132 +0800
@@ -4569,9 +4569,14 @@ CONFIG_GPIB=y
 CONFIG_GPIB_COMMON=y
 CONFIG_GPIB_AGILENT_82350B=y
 CONFIG_GPIB_AGILENT_82357A=y
+CONFIG_GPIB_CEC_PCI=y
+# CONFIG_GPIB_NI_PCI_ISA is not set
+CONFIG_GPIB_CB7210=y
 CONFIG_GPIB_NI_USB=y
 CONFIG_GPIB_HP82335=y
 CONFIG_GPIB_HP82341=y
+CONFIG_GPIB_INES=y
+CONFIG_GPIB_PCMCIA=y
 # CONFIG_GPIB_LPVO is not set
 CONFIG_GPIB_PC2=y
 CONFIG_GPIB_TMS9914=y

then we found the reported issue after below two lines:
[    7.884853][    T1] agilent_82357a_gpib driver loading
[    7.884906][    T1] usbcore: registered new interface driver agilent_82357a_gpib

but for parent, there is no this issue. below full report FYI.


Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 01b060a1e15939da2119458ea676709c33f0d26e ("[PATCH] staging: gpib: Remove dependencies on !X86_PAE")
url: https://github.com/intel-lab-lkp/linux/commits/Dave-Penkler/staging-gpib-Remove-dependencies-on-X86_PAE/20250205-014405
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/staging.git 7b66aae77da56f2eabd92d3fb012d2fb98212bbd
patch link: https://lore.kernel.org/all/20250204174254.16576-1-dpenkler@gmail.com/
patch subject: [PATCH] staging: gpib: Remove dependencies on !X86_PAE

in testcase: boot

config: i386-randconfig-005-20250211
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------------------+------------+------------+
|                                                                           | 7b66aae77d | 01b060a1e1 |
+---------------------------------------------------------------------------+------------+------------+
| BUG:kernel_NULL_pointer_dereference,address                               | 0          | 24         |
| Oops                                                                      | 0          | 24         |
| EIP:strcmp                                                                | 0          | 24         |
| Kernel_panic-not_syncing:Fatal_exception                                  | 0          | 24         |
+---------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502131453.cb6d2e4a-lkp@intel.com


[    7.884853][    T1] agilent_82357a_gpib driver loading
[    7.884906][    T1] usbcore: registered new interface driver agilent_82357a_gpib
[    7.886405][    T1] BUG: kernel NULL pointer dereference, address: 00000000
[    7.887131][    T1] #PF: supervisor read access in kernel mode
[    7.887739][    T1] #PF: error_code(0x0000) - not-present page
[    7.888347][    T1] *pdpt = 0000000000000000 *pde = f000ff53f000ff53
[    7.889046][    T1] Oops: Oops: 0000 [#1] PREEMPT
[    7.889536][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.14.0-rc1-00010-g01b060a1e159 #1 f08c34d46b2d33c70805190edc7163ed78d17b6d
[    7.889552][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 7.889552][ T1] EIP: strcmp (arch/x86/lib/string_32.c:100) 
[ 7.889552][ T1] Code: 8b 4d f0 49 78 06 ac aa 84 c0 75 f7 31 c0 aa 5e 89 d8 5b 5e 5f 5d 31 d2 31 c9 c3 3e 8d 74 26 00 55 89 e5 57 89 d7 56 89 c6 ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 5e 5f 5d 31 d2 c3 3e
All code
========
   0:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   3:	49 78 06             	rex.WB js 0xc
   6:	ac                   	lods   %ds:(%rsi),%al
   7:	aa                   	stos   %al,%es:(%rdi)
   8:	84 c0                	test   %al,%al
   a:	75 f7                	jne    0x3
   c:	31 c0                	xor    %eax,%eax
   e:	aa                   	stos   %al,%es:(%rdi)
   f:	5e                   	pop    %rsi
  10:	89 d8                	mov    %ebx,%eax
  12:	5b                   	pop    %rbx
  13:	5e                   	pop    %rsi
  14:	5f                   	pop    %rdi
  15:	5d                   	pop    %rbp
  16:	31 d2                	xor    %edx,%edx
  18:	31 c9                	xor    %ecx,%ecx
  1a:	c3                   	ret
  1b:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  20:	55                   	push   %rbp
  21:	89 e5                	mov    %esp,%ebp
  23:	57                   	push   %rdi
  24:	89 d7                	mov    %edx,%edi
  26:	56                   	push   %rsi
  27:	89 c6                	mov    %eax,%esi
  29:	ac                   	lods   %ds:(%rsi),%al
  2a:*	ae                   	scas   %es:(%rdi),%al		<-- trapping instruction
  2b:	75 08                	jne    0x35
  2d:	84 c0                	test   %al,%al
  2f:	75 f8                	jne    0x29
  31:	31 c0                	xor    %eax,%eax
  33:	eb 04                	jmp    0x39
  35:	19 c0                	sbb    %eax,%eax
  37:	0c 01                	or     $0x1,%al
  39:	5e                   	pop    %rsi
  3a:	5f                   	pop    %rdi
  3b:	5d                   	pop    %rbp
  3c:	31 d2                	xor    %edx,%edx
  3e:	c3                   	ret
  3f:	3e                   	ds

Code starting with the faulting instruction
===========================================
   0:	ae                   	scas   %es:(%rdi),%al
   1:	75 08                	jne    0xb
   3:	84 c0                	test   %al,%al
   5:	75 f8                	jne    0xffffffffffffffff
   7:	31 c0                	xor    %eax,%eax
   9:	eb 04                	jmp    0xf
   b:	19 c0                	sbb    %eax,%eax
   d:	0c 01                	or     $0x1,%al
   f:	5e                   	pop    %rsi
  10:	5f                   	pop    %rdi
  11:	5d                   	pop    %rbp
  12:	31 d2                	xor    %edx,%edx
  14:	c3                   	ret
  15:	3e                   	ds
[    7.889552][    T1] EAX: c2f01073 EBX: c66fcd00 ECX: 00000000 EDX: 00000000
[    7.889552][    T1] ESI: c2f0109f EDI: 00000000 EBP: c4759ea4 ESP: c4759e9c
[    7.889552][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010282
[    7.889552][    T1] CR0: 80050033 CR2: 00000000 CR3: 03a47000 CR4: 000406b0
[    7.889552][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    7.889552][    T1] DR6: fffe0ff0 DR7: 00000400
[    7.889552][    T1] Call Trace:
[ 7.889552][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:478) 
[ 7.889552][ T1] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 7.889552][ T1] ? __die (arch/x86/kernel/dumpstack.c:435) 
[ 7.889552][ T1] ? page_fault_oops (arch/x86/mm/fault.c:714) 
[ 7.889552][ T1] ? kernelmode_fixup_or_oops+0x55/0x63 
[ 7.889552][ T1] ? __bad_area_nosemaphore+0x31/0x17b 
[ 7.889552][ T1] ? bad_area_nosemaphore (arch/x86/mm/fault.c:834) 
[ 7.889552][ T1] ? do_user_addr_fault (arch/x86/mm/fault.c:1279 (discriminator 1)) 
[ 7.889552][ T1] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 7.889552][ T1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1488 arch/x86/mm/fault.c:1538) 
[ 7.889552][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1493) 
[ 7.889552][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1048) 
[ 7.889552][ T1] ? rs690_fix_64bit_dma (arch/x86/pci/fixup.c:801) 
[ 7.889552][ T1] ? psi_show (kernel/sched/psi.c:1241) 
[ 7.889552][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1493) 
[ 7.889552][ T1] ? strcmp (arch/x86/lib/string_32.c:100) 
[ 7.889552][ T1] ? psi_show (kernel/sched/psi.c:1241) 
[ 7.889552][ T1] ? pvclock_clocksource_read_nowd (arch/x86/mm/fault.c:1493) 
[ 7.889552][ T1] ? strcmp (arch/x86/lib/string_32.c:100) 
[ 7.889552][ T1] kset_find_obj (lib/kobject.c:912) 
[ 7.889552][ T1] driver_find (drivers/base/bus.c:1333) 
[ 7.889552][ T1] driver_register (drivers/base/driver.c:243) 
[ 7.889552][ T1] pcmcia_register_driver (drivers/pcmcia/ds.c:187) 
[ 7.889552][ T1] cb7210_init_module (drivers/staging/gpib/cb7210/cb7210.c:1571) 
[ 7.889552][ T1] ? agilent_82357a_init_module (drivers/staging/gpib/cb7210/cb7210.c:1507) 
[ 7.889552][ T1] do_one_initcall (init/main.c:1257) 
[ 7.889552][ T1] ? do_initcalls (init/main.c:1317 init/main.c:1335) 
[ 7.889552][ T1] do_initcalls (init/main.c:1318 init/main.c:1335) 
[ 7.889552][ T1] ? rest_init (init/main.c:1449) 
[ 7.889552][ T1] kernel_init_freeable (init/main.c:1570) 
[ 7.889552][ T1] kernel_init (init/main.c:1459) 
[ 7.889552][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 7.889552][ T1] ? rest_init (init/main.c:1449) 
[ 7.889552][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 7.889552][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[    7.889552][    T1] Modules linked in:
[    7.889552][    T1] CR2: 0000000000000000
[    7.889552][    T1] ---[ end trace 0000000000000000 ]---
[ 7.889552][ T1] EIP: strcmp (arch/x86/lib/string_32.c:100) 
[ 7.889552][ T1] Code: 8b 4d f0 49 78 06 ac aa 84 c0 75 f7 31 c0 aa 5e 89 d8 5b 5e 5f 5d 31 d2 31 c9 c3 3e 8d 74 26 00 55 89 e5 57 89 d7 56 89 c6 ac <ae> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 5e 5f 5d 31 d2 c3 3e
All code
========
   0:	8b 4d f0             	mov    -0x10(%rbp),%ecx
   3:	49 78 06             	rex.WB js 0xc
   6:	ac                   	lods   %ds:(%rsi),%al
   7:	aa                   	stos   %al,%es:(%rdi)
   8:	84 c0                	test   %al,%al
   a:	75 f7                	jne    0x3
   c:	31 c0                	xor    %eax,%eax
   e:	aa                   	stos   %al,%es:(%rdi)
   f:	5e                   	pop    %rsi
  10:	89 d8                	mov    %ebx,%eax
  12:	5b                   	pop    %rbx
  13:	5e                   	pop    %rsi
  14:	5f                   	pop    %rdi
  15:	5d                   	pop    %rbp
  16:	31 d2                	xor    %edx,%edx
  18:	31 c9                	xor    %ecx,%ecx
  1a:	c3                   	ret
  1b:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  20:	55                   	push   %rbp
  21:	89 e5                	mov    %esp,%ebp
  23:	57                   	push   %rdi
  24:	89 d7                	mov    %edx,%edi
  26:	56                   	push   %rsi
  27:	89 c6                	mov    %eax,%esi
  29:	ac                   	lods   %ds:(%rsi),%al
  2a:*	ae                   	scas   %es:(%rdi),%al		<-- trapping instruction
  2b:	75 08                	jne    0x35
  2d:	84 c0                	test   %al,%al
  2f:	75 f8                	jne    0x29
  31:	31 c0                	xor    %eax,%eax
  33:	eb 04                	jmp    0x39
  35:	19 c0                	sbb    %eax,%eax
  37:	0c 01                	or     $0x1,%al
  39:	5e                   	pop    %rsi
  3a:	5f                   	pop    %rdi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250213/202502131453.cb6d2e4a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


