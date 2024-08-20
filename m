Return-Path: <linux-kernel+bounces-293435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4FA957F38
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866EBB21825
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A229188CBC;
	Tue, 20 Aug 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJF78yg0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85D40BE5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138210; cv=fail; b=E0CgxUMKg/QINRWcT4E4bJu2Fr6QB5XVPszBZcmwX+vubbTgIR5rRs2E9dVfbwjwqXjXe9qKQ8Yz38Y0ptbjnQlBuWfkmLfQfEg5ng2TMLQ3BtVSOvIjFdJRzk01gK8qfvXHjdFL4+/B3N5CCpi7y6gOdot4xitOzkutHxm88p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138210; c=relaxed/simple;
	bh=Wba1Lyykoky6DkHsMXep94MC6bAlfoNl9xnHmgEDB1o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mIfW3rgsoL8C9NA4oyz/D9kA+OwgFqoI2TYJ4JtCvKPfN5Pdx3J/NOU7nyZdHH0s0wXafkdMs0WI55tSVuDhzC2eJN9TH0r5ETFJcBhSCuTPoKw3ymA3IV/OVQGPOKuNRWwZt/cvjZUgRizsNhkCZete0NYf41mfMHBkX21mF5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJF78yg0; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724138208; x=1755674208;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wba1Lyykoky6DkHsMXep94MC6bAlfoNl9xnHmgEDB1o=;
  b=EJF78yg0xkEZFw+7CKJrTZJ/pFMF5p2Bp1Rx5CVM8OtSPBYkKx24jos/
   4xiHWHNxEkrx3pkB70Mw3RLDuM6yUmZwgWA/cQ/aoDkh4FV62rwFhx3mS
   ypnqEPgdChxz0b6kZdPHgOCvmrn4kfdun1FcI9AyzSatD4VINLXLj0XKB
   OE0zWWouy9stDLLSTZLphxeeXnKJLKGUIFM+i+EolgXMYsrqT9A5gdchs
   CIzDAM0lDQc9c7jFt+U6ZIbrtyIBWkhfmFu7I+/yxCb4hVgi1jQNeQ/J8
   VI/0qsbu2T8uwUk8buJS6dlwekAOe+rJzQLL+V1ZZBhaGbJ0iBzZjkHXA
   A==;
X-CSE-ConnectionGUID: FjQDXAYFSPStpzQf7WGc1g==
X-CSE-MsgGUID: xPtRz6hBQJOoYFdDpSAhpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33573467"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33573467"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:16:36 -0700
X-CSE-ConnectionGUID: a7x+iBsHSRuj+dyDNsXRQw==
X-CSE-MsgGUID: eiPaACs9S7+XkDAw/HGcrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="91353655"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:16:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:16:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:16:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:16:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFq5eqo9OFfV2u2q09eafzBaDCYb3iAXemH4sXDdczi19oUl6ePfvVqVJ6Is4oulu1+VB1hTIGrPKFJMxKWHvXE/oSay2aER0kXWoKP7R/PTJk3nvhQU1Ohk2ldhgXcnCL2mLA87l8+Yf5Iy/qN0eb85yQoRv89qTIiZAvxrItbi24Yf0ulRRWVNJFufuWbQ+etyM3rLmnO23QXVPxM9YpoN3MsvwpV1KKBTS7wWJRkmfeMPG4B/FbUSJTxgX72tNEb++Zc2gzSBMFBkIHnSsPxjK+IVuLpVgQu9/cvQglMSTlGSvsgYCFEec+EKm3aNrSe7gvhiFy3P16/ysoYRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlZCmtUnqD2RdbL9wG/KUSDpsMqe8sBe1FUKaIKjt3g=;
 b=s7rt6wk32/xZwzjAuTJu1gEJPGnwf9A7M3rC6WHeoaSTSfpD2N/WpicCMUXqAGX7xY4/MMJ6wu8gE74uXQ7H0ghk7e/vdSto+wOq84ejWQOFYxbri2cf4NB/PqMUU6a+Y7WXEqe8FXOlyvENnnMiZaGqgLDw8G6UzTb2pIVaZW9N9yhmLJMH42I5M7zphVti0SDo8d0nzHafAjEa4pebjO9WcUTRLIWP23tIo+TY5pEQMH8U03Ls5P/A1SsXuikGw7DhHG5NWMoBgslp8N6kCMP7LFaeSqBOR++AITt4cIrJzMUN2Cqoh+ig+Smzl0VifzsxN1bgG+DhM00P4irPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 07:16:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:16:33 +0000
Date: Tue, 20 Aug 2024 15:16:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Max Ramanouski <max8rr8@gmail.com>, Alistair Popple
	<apopple@nvidia.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook
	<kees@kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [tip:x86/urgent] [x86/kaslr]  dfb3911c36:
 kernel_BUG_at_arch/x86/mm/physaddr.c
Message-ID: <202408201529.498d4d4d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 28091e5f-2398-4302-154c-08dcc0e8053f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bEzSWnQmWxKHcmBbwDLLdzM+BmLgSVST5lXk8fZKLk43BRuPy5a/u8pDngVw?=
 =?us-ascii?Q?Z1HfXkn2pU15gryMiy9yWi/yIs7/3VZq2jewpmj2/kwfZO9aCbx/akFbOBAt?=
 =?us-ascii?Q?L0hv070i9wiC0T1Tx3HKfjrwfBsMYm44p9kT9Yp+SfpQSZQuYWMHIolnxRix?=
 =?us-ascii?Q?zuzi/dTe54goJ6BE2gjgVYiEcQ0Ru30YpHFJUdaRcyANse+k/vpZkKVaiy5t?=
 =?us-ascii?Q?BZnipl3QnTw6DJUpSsBV+QJmhiKRv2xbs37UXEYONTcQXOIgKs5b8DK8jVwR?=
 =?us-ascii?Q?KbIAwZ/gH8HJfqmSjT3/QmKHnT1MV9ka7Y8owl9H0dQa2S6JxNoklRXmVEd+?=
 =?us-ascii?Q?jsf5sn28s/eR4BR9ih7uJRkozchwEGS9GIoMukNDspI7emvyWykwIFgB9nNU?=
 =?us-ascii?Q?wIEbPcvDQE5EyWeQk7CWVN6wLU6CmF9eSopmWkPER0bJ9jCsh66Bd+dQLhRO?=
 =?us-ascii?Q?DpCLuW/mmun2Q3+fBJ1iNMBHHIK0tpI4tTCxE69R+m7PW5wUSh74wv5K13Np?=
 =?us-ascii?Q?PZKcRGQqDZRcILH5j0mvV58SRck7ZqEwJHQm76nRfq2kmpmGOhjaeZPsTDE5?=
 =?us-ascii?Q?CvCxVzAZOGv4vYX2x3fFy9DK96Vr9TrWgNadFKNV/QRsL9qLD6E7GbBdltoK?=
 =?us-ascii?Q?R53/mv7OcekSVqS0mhu/qrX2mvJdCUiSluV4+iHU2dGJ7jxolTDvbdvGKIxx?=
 =?us-ascii?Q?Rw7XNoZHyCVO07F5pMZO7rJo/dwWP3QwaYLGpFCG1DFJ68meDe1FdMFZ74o5?=
 =?us-ascii?Q?nMZYAMgoRZQCuUA7CFYSdPYUNJCWHko1Zv5WkSdEH2a9bkz0o9lLyxho6gCE?=
 =?us-ascii?Q?PfzeDpyUQxnB4IEUIvJ62lcoGJRnNtcJEyGEmrqPXWTjjiZcLl3U+YHCL1Nm?=
 =?us-ascii?Q?ldp74mBt6JW6nOti3tbRFwYk0k8+TTvyXYWTEjdjOnZYcIcwixS/diYu8Ymt?=
 =?us-ascii?Q?5BwAXfBgeGZMdIf+NzdmEk5AX6xoxC1VZI1PO179PnVamFVdpC9iewa7PZJw?=
 =?us-ascii?Q?jmh3tLe1sYGIovnDcNNBlG1BrVtw5Z7l+rjOTRBvER1Qz48HzfyNphf8LZIX?=
 =?us-ascii?Q?azJKzB6fX4IVgfw2PB3lfbaq1j/B7r5NJGEqMvENDcnKEC/6w0Rxe8tbPaUY?=
 =?us-ascii?Q?hIy6+j1+24GfVe5hmQUE1+j1Sm0HQplOMmPOgD36m0tezD2tfXOykT4pL+sQ?=
 =?us-ascii?Q?tYcj0dFjvBLMcBFR7uFy7ybX4J6igAijpbNmdb4fvS7iMNOBT3xVVTZSWj9c?=
 =?us-ascii?Q?1F0E1ZSgNEIxOh8St5DW1AzR0fOsNm8BSBKmwgGSg8YWQjE9k0nxU5tOVXgR?=
 =?us-ascii?Q?sNkT7YgSnNcE/VERKsdXLMQB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l16XP0O4+hKSOiopRIK35byKBHDodfWX7gU4gXtTJzX0lQy+ppswi+9jcWdo?=
 =?us-ascii?Q?vlVOawmELvsFoFUQjKZ15gDL30SLdCusg7lXq91eNb2ey3sEUsYrSxmtbkzD?=
 =?us-ascii?Q?E9+qpAvh3WqswJniKBghS0DkOFhnHb93Xvbb+Yh0ewWVTwtLN2fZ61Avd927?=
 =?us-ascii?Q?qMZS5Tdu2ENcjajmDPrX08AYA7kXGbNUDtEOutA6I09R+61ae4liqpc/xQgW?=
 =?us-ascii?Q?KHJKUBsg3T+nrWn3rhgY375GT2vTkrhWZsKSmdv86d2NpXlvnq+/Z4qVLMes?=
 =?us-ascii?Q?Ah7o/UtH5/Xv+J/VewukY2EHrCoWvepCuZoMlXOh4abE0FJT1kJAtGnhMTKj?=
 =?us-ascii?Q?2+mPuc8ao3EhkZg03k6khWpqQ1u9oXy2263lY/CUAL94UPjEQD+EisGI1Rv6?=
 =?us-ascii?Q?Obio9/OR1bUUPfMBRihygdQGyJcI/EIazk9pTu3XuEEuOOcs1NEEyc5cqCIZ?=
 =?us-ascii?Q?K8vQfhh3N96tPgfxJcaRlMCNCbuA6vaJUo677agvpKrb1pR64hUoJfOreVyl?=
 =?us-ascii?Q?rTw+rXMjDk6wjT9DmdoX/LzOp6ntEuXDelkVnUdMaWtFHJb8JEb/ulzxIzfB?=
 =?us-ascii?Q?+NH9OYt2szRdegCAP08abTSZ/qagFeVNr2cXIgnOg/y81PUB4LX7dKwmgx62?=
 =?us-ascii?Q?ZixbL7V13qmKI4UwY+B3AKnExcLmpHY5Tta11nDWohI8OWPl0hR3IqGNbDxq?=
 =?us-ascii?Q?oCKrPVa3egdEi87hcbhwdN7tUHTpJhzMyHWsX0Ql/y8XwgLV/F9JfaQINSZK?=
 =?us-ascii?Q?48w0XuzTzTLaq0kBmDksLNdqVRWMkHTc48QhSXvAlEy7MFiF8vbJK7RPSRgn?=
 =?us-ascii?Q?dLLgScMTw3nlg1/BCKn5vZeiwrgS8eoRMxNd4sBG1C4/QYgVv6sCQJJXobQM?=
 =?us-ascii?Q?zHESFPqD2i+E5xpvI9ZFKsMlBwJzln2XXyngBzPNdS2o24TfvQZmh6OlsYGn?=
 =?us-ascii?Q?DhaAP07ysglySwIfCxyoKBkgJj4UlkotNdQvM/UJ5SWDfxUjmcmsYatdW6R9?=
 =?us-ascii?Q?fRqJIOYCfz4CWpTPjZtSnEAs2oYVuy7Um/JWJHTOxFHeAkxcwJDDrkW+chbz?=
 =?us-ascii?Q?e0YFMGBQht1MkuvbRybN/n+eD/0w2hhksKOGXqbhbNUqjXczZpex+5lHqzJ5?=
 =?us-ascii?Q?6GjW/IFGxVT9zP2wWDuCCuUEGd4FSaDzwqPJJbG1juwAz36bOAL8avtYw8cA?=
 =?us-ascii?Q?d09l2Gqcgo885BlNNY9b3EZb2cjnnLzzyDyjd9y8oWH8PPOYs1nW6Zwm04mQ?=
 =?us-ascii?Q?x1LaLORYwjsSNeiu/QKkqinl0qVW6Uvut7YGLoAsRQMrpvp5Cdwxdcegq2hi?=
 =?us-ascii?Q?nRbLEqEWk5B5P6byf9UFjDVkMkXk//6stwaHG6Lj7cxw+hWtVwgY/VPGHAJ0?=
 =?us-ascii?Q?vAQryl1s1xEwS6Jz9MZ5779UZxbmMnHNi57GTPnN01lMQTfirDvQ6IxySyvq?=
 =?us-ascii?Q?tDCAKpixSaB/RDn2NXQ17mWzOvA1SpFYeI5HoYFM/xm/GEkg4DgE0Ci8g9NC?=
 =?us-ascii?Q?VObN+7FqatIz0QqRjaan9EqYA/RgivklMjofVsZcCnInJ2xmNu4Mz7kDSxKw?=
 =?us-ascii?Q?wDIRWpubHasdOVP+tTBOPFR+dk5cHOUnI/GGRefFliBvHEkHLvRGPIdELh+M?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28091e5f-2398-4302-154c-08dcc0e8053f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 07:16:33.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJB2RY4L6urW5syAeqv/bAZFsG8sIPvXqf2Wqsx4NLHcVWUhvo/hPjXBToe1nQpcl8mo+/c9jiE6k6HBnZt9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_arch/x86/mm/physaddr.c" on:

commit: dfb3911c3692e45b027f13c7dca3230921533953 ("x86/kaslr: Expose and use the end of the physical memory address space")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/urgent

[test failed on linux-next/master 469f1bad3c1c6e268059f78c0eec7e9552b3894c]

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------+------------+------------+
|                                      | 2848ff28d1 | dfb3911c36 |
+--------------------------------------+------------+------------+
| boot_successes                       | 21         | 0          |
| boot_failures                        | 0          | 21         |
| kernel_BUG_at_arch/x86/mm/physaddr.c | 0          | 21         |
| PANIC:early_exception                | 0          | 21         |
| RIP:__phys_addr                      | 0          | 21         |
+--------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408201529.498d4d4d-lkp@intel.com


[    0.010309][    T0] ------------[ cut here ]------------
[    0.011020][    T0] kernel BUG at arch/x86/mm/physaddr.c:28!
PANIC: early exception 0x06 IP 10:ffffffffb08e3511 error 0 cr2 0xffff888038627ff8
[    0.012655][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc3-00003-gdfb3911c3692 #1
[    0.013805][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.015203][ T0] RIP: 0010:__phys_addr (ld-temp.o:?) 
[ 0.015856][ T0] Code: c3 48 3d 00 00 00 40 73 23 48 03 05 19 8b d4 02 48 89 c3 eb dd 48 c7 c7 d0 02 81 b3 48 89 de 4c 89 f2 e8 c2 26 45 00 eb bb 90 <0f> 0b 90 0f 0b cc cc cc cc cc cc cc cc cc cc 48 8b 05 59 a2 64 03
All code
========
   0:	c3                   	ret
   1:	48 3d 00 00 00 40    	cmp    $0x40000000,%rax
   7:	73 23                	jae    0x2c
   9:	48 03 05 19 8b d4 02 	add    0x2d48b19(%rip),%rax        # 0x2d48b29
  10:	48 89 c3             	mov    %rax,%rbx
  13:	eb dd                	jmp    0xfffffffffffffff2
  15:	48 c7 c7 d0 02 81 b3 	mov    $0xffffffffb38102d0,%rdi
  1c:	48 89 de             	mov    %rbx,%rsi
  1f:	4c 89 f2             	mov    %r14,%rdx
  22:	e8 c2 26 45 00       	call   0x4526e9
  27:	eb bb                	jmp    0xffffffffffffffe4
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	0f 0b                	ud2
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	48 8b 05 59 a2 64 03 	mov    0x364a259(%rip),%rax        # 0x364a299

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	0f 0b                	ud2
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	48 8b 05 59 a2 64 03 	mov    0x364a259(%rip),%rax        # 0x364a26f
[    0.018297][    T0] RSP: 0000:ffffffffb3603e80 EFLAGS: 00010002 ORIG_RAX: 0000000000000000
[    0.019380][    T0] RAX: 0000000000000001 RBX: 0000010040000000 RCX: 0000000000000028
[    0.020378][    T0] RDX: 000017562bdbd039 RSI: 0000000000000000 RDI: ffffa0d640000000
[    0.021374][    T0] RBP: ffffffffb4808710 R08: 0000000000000000 R09: 0000000000000000
[    0.022382][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffb3603ea8
[    0.023182][    T0] R13: 0000175600000000 R14: 0000000000000028 R15: 0000000000000000
[    0.023800][    T0] FS:  0000000000000000(0000) GS:ffffffffb362f000(0000) knlGS:0000000000000000
[    0.024489][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.024995][    T0] CR2: ffff888038627ff8 CR3: 00000000397c0000 CR4: 00000000000000b0
[    0.025613][    T0] Call Trace:
[    0.025863][    T0]  <TASK>
[ 0.026089][ T0] ? early_fixup_exception (ld-temp.o:?) 
[ 0.026502][ T0] ? early_idt_handler_common (arch/x86/kernel/head_64.S:542) 
[ 0.026951][ T0] ? __phys_addr (ld-temp.o:?) 
[ 0.027298][ T0] ? kernel_randomize_memory (ld-temp.o:?) 
[ 0.027735][ T0] ? setup_arch (ld-temp.o:?) 
[ 0.028082][ T0] ? start_kernel (init/main.c:927) 
[ 0.028433][ T0] ? x86_64_start_reservations (ld-temp.o:?) 
[ 0.028866][ T0] ? x86_64_start_kernel (ld-temp.o:?) 
[ 0.029268][ T0] ? common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.029658][    T0]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240820/202408201529.498d4d4d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


