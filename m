Return-Path: <linux-kernel+bounces-523079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7FA3D1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C8617BD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E841E4929;
	Thu, 20 Feb 2025 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbl6YRn/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851F1E3DFE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035115; cv=fail; b=IRBo/Xx5UBmGS0RuDxRXdMFiC4K4yoFgplU/syn2MSKcSqQ19+NoEcxeqV/ZgbokNgpqq4MKEdlWgaX8JI/WXbGB6pdDxiOMcB8D6mozTcPBPNB0Z3BhaXJ/RZ8hhB+eOkYUz9yB4U/s742C0BWG6ds+BHLRf76C4K9+pziWfa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035115; c=relaxed/simple;
	bh=kVyxDsXFRYt0vZUYfvbqP7Z6bokDlafESe+IBSEwlJM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pk9TXEwgv3UUFfp1EQXX4Kmw4CAvNzzlvaCpsswGOFnjExnDAXzDRSbtAOI0sXG6yA8jXgMwKt7dzydrlRz4+oBuf4x+YsgPYkHuleq7va8ldmTiwuuKgMP8kH8Ld4CUcF5eua49OY/wE5UdzTgZzp7mARAZZXNcMb7//4F6i/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbl6YRn/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740035114; x=1771571114;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kVyxDsXFRYt0vZUYfvbqP7Z6bokDlafESe+IBSEwlJM=;
  b=bbl6YRn/tjMLgEdxg08py2/9XmOVFj6e8PJhVayQyRkpkhgJ7HSiIMMs
   S5nbQ82W7I/LV3iMRqO4qFmAcnnXrp6mpIuMF5Vl3DI9LKx1HS+UXzD6S
   qv1Hv7n35jzWwtmdwifstCnmjYAl8T05o0kyNAIckQ2bh6gsU+Y/2vu+g
   c0j5zj152WQLUD0HFExlAyT2WuzHXJo/BZYbmCzeR9cHwZ5RFZ8JS+ci2
   FV0+4oLCMxuBvotnmxVMZri7KucN0yAtZadOquHW7dq1etLVNIJRSzlbM
   U7t4MiSeSyuLhhMfSnb00MQqLds7GXxYah1j3sgfrIYFHVSA9v1iLyRaA
   Q==;
X-CSE-ConnectionGUID: 5Et4UN1xQOGoBZrEHqw4cA==
X-CSE-MsgGUID: eV+TZnK4S6WoV/e/ucWe1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44719050"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="44719050"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:05:13 -0800
X-CSE-ConnectionGUID: ehgXiwVwRrGN+SPnn7xiEw==
X-CSE-MsgGUID: WgrhHr8sQ6mFrl6cWSwQxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115853984"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 23:05:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 23:05:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 23:05:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 23:05:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZMY47Fqk2vtwwHmBzEE8FCK2aX5KkTUWsELpw45pUfHRwAxv77fO93PiycsbtAnA27ZaDX1BVZPaiksHJC8xHhHzZZT3S1Tw5cQeXVpmcHmnlvNW268fHaY19T9TlGYC0mp3ml0Ssl3td64bw0zzGsvmbZSz3PYSkuy7TaW8vsdGrArLtKYhZIb4JShLW3qiMzYWz4WUIN3C+gGpO+gE3w/jZEDzOEV4PjkFS586K1XovrjVoQExVB6fotPt7lcfTfpAfbXuH10M59e4gvz11damXGTQZLLohodQwJUWk/mCDlm2BCj6sZKv/cJBHZxuWpa9WPozrYG1RuNPMMh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ5gaK0m/kpMJAXS1Ba0hKPRRMEL6FVntuDQxmt0x4o=;
 b=ZYCuF1oisk1jieVW1LrM+4qxm14nrTN7AXyJXUvONU0la/lvD1BBvJwtPS75fXgKJtZdiB6Jur/Jl60foF7YIS5FHfIFOZLA4hdhbEp08FSfwHICDC+sKNLc//TSAccwXL49aF79uB7mY2l19QpEMSFia1NV7/EpvC2EmPg5oF74PPVHIMXrFQ9PQtSffuMZ1GsXQulEc+gyJqhkRMPov5yxsDXxEAjntPe/iR4BX+BSTg/q69VO7X4/fFISncZWSIbglqIuoVn2B4E/UTy0/0CDRkSuHj/cODYXRszz51qWB2WqeGsXwMJcOVQHrspALnnebNzX+EGY7CrESp1dXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7759.namprd11.prod.outlook.com (2603:10b6:8:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 07:05:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 07:05:05 +0000
Date: Thu, 20 Feb 2025 15:04:43 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Petr Pavlu
	<petr.pavlu@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [x86]  66fbf67705:
 kernel-selftests.kvm.hardware_disable_test.fail
Message-ID: <Z7bUC9QY815Cv6nb@xsang-OptiPlex-9020>
References: <202502140800.ebac2328-lkp@intel.com>
 <20250218144918.Rl33HhXh@linutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218144918.Rl33HhXh@linutronix.de>
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fab45c8-0cb9-42af-4611-08dd517ce72f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?w3h/aF8ZhrxMfpBtZ5rTSmu5d0csn16OzYM8S18EBbvKIhVjusgauHKdbU?=
 =?iso-8859-1?Q?BFRGGs44BvsArKdiOQd8TIW89HLCn+9CITyG2DoneRNh8RbpkjpScewqO5?=
 =?iso-8859-1?Q?o5fXgXfVXHbIEssfmobIoNwb1KudXGiyOT2+h8u8kM75CGl3IkAJtqfJmV?=
 =?iso-8859-1?Q?sn1FMUaSKVxv0jofIvCxuD7FXyx9K5tAeyiQHTQHN/Y1BxpbOkcbjmwPrt?=
 =?iso-8859-1?Q?6N6M4U3C2nSpm6Y1JCNjq2s4OG6k9WMZs4vE8J7qEKtiqDhwuadmF3ccUK?=
 =?iso-8859-1?Q?EvVx4Oul7+ejs4DyRV8RQGsgTKDZjDOi9E5A1dXi2zxT7CgyOOoBwK8x7/?=
 =?iso-8859-1?Q?sWoT7Z/tr24L2HZzehPZ5cXYRFYd9fUs3hQ0DHhSvhZlsD2G8EdUTH/ywJ?=
 =?iso-8859-1?Q?KKxuknj+7I44LQd6BwJp9TYOBVYDYXxZrVjiS6OgL7Oo4knFhUJ1qiPCGZ?=
 =?iso-8859-1?Q?w0F0kCxf/lI5tugpRXoyxokSl12x1r/KwWSW0G2m4Uga5lQw7CoaGR4pXB?=
 =?iso-8859-1?Q?30Otklq8QyCVPO4OZluHXO8TShzr276rnUdTVAzqxZZ/1O96z6IOCplNNM?=
 =?iso-8859-1?Q?PCYMcJ0N/ZB/sAlltAQTKGRiptK717oe+26ybeeJpQr4WOe5VvRj6fQYJB?=
 =?iso-8859-1?Q?wPDeIIh2O4uxn6guhvX/1I81egG9NNcuGOHoCHg0h4iCW2jIGJcxCyKedi?=
 =?iso-8859-1?Q?ZEVJ9tapCNQmMIaQ0XbWpwlWV70FomojU8StnvxDQUA3ese3Nu8pdb+RWf?=
 =?iso-8859-1?Q?P2oq9vhLHZ0GkrzxKbL4UyJP9OKKXlf9zOtgusleeSH17qKwQKHEdNQ5t2?=
 =?iso-8859-1?Q?vd7LN7xiFiSSljNln3j7Ac4M75NRPtVmmQ+XkdLyRh1i1WDZ3GjjihEEFT?=
 =?iso-8859-1?Q?mGr4z3pIBo1pQhSwttWT3y/Ey10EYXh8Ojcg3e8kr2wj90cFLZOUWLfnZ7?=
 =?iso-8859-1?Q?aGhtuFU+AWGKL24IPhyBErvguxV2YMOQSO4wy1QLpDO0vUYsd2V8b9KHZ4?=
 =?iso-8859-1?Q?IvwAbVzPZ51XOfV2/fokWsa3X+iCIQdaGqjkzXyICEorBW4II4ocGHAjP8?=
 =?iso-8859-1?Q?KfLbPukj4bIm3vRzJOr4hz5LyNhdOJi9KwfO7SSMcX5PgOjVT4E/5MLGYS?=
 =?iso-8859-1?Q?KWbN3MjQVML3hyufIt6wDWJPYzwSWolscG95P9/5jGuGf24g1+wzsx0QSC?=
 =?iso-8859-1?Q?Q4qBBLLzPDDyUOa20XkLVKhTVF+evDhPkOu7MRPQ7BjKm7+TDK/6d4EKDh?=
 =?iso-8859-1?Q?Tn+JeiTL17+XGXGFDohnmDyDxpECEKWmhO7q1z923TOMKxWRNErdMEjSvr?=
 =?iso-8859-1?Q?zYMMfVKz81AglmWxe323dfvLeeeVm7RQ97PqszJ/l+nx98ULyvulzHUJlx?=
 =?iso-8859-1?Q?L1NMRraFkVDVtNGeH5ZP6W+fU2ouuK8p5yYxE7F2lUk2woJu9KW6iRA1z+?=
 =?iso-8859-1?Q?vVsQ8ydRdRwPTXGL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MNhnaVuwePSbmW3hoBGjb5X2IdIh1v0uwOhaWgtgd4WkF5oW2ewrRXi1Gq?=
 =?iso-8859-1?Q?wWxV21ZXkaF9v69ExKs83Ul3VgV0tn7a2+ek/D1Ft1ERShLu+km3QpUzzW?=
 =?iso-8859-1?Q?Jwck+pDLagbxdAkk7X+JiU/oAh3sV5+549Uwsnjr7Ug6xIgxeWOVAC80vn?=
 =?iso-8859-1?Q?g7boo8WLXCNCDQfv1W7Ce+1byMM9Fq4SegdOFrJsBotR70t41UnPMiG/uL?=
 =?iso-8859-1?Q?2+PIV00ZEHHc/IfF0IYqv2CLvlQhdCj5Vbp71WDrp152dQucNEXa+tQJcA?=
 =?iso-8859-1?Q?EpGZHw4qoRUSH4A8gjIBqO1sEcZh58KuPBqIkzmMJzJ/cCf+8sY7rtXTJ1?=
 =?iso-8859-1?Q?AMCAvmZEJ1oALRX43IDQvEWI+ZwkcpG1slh1hF9XdrGNxWY2WiN2roXcV8?=
 =?iso-8859-1?Q?T+Tf6Ko9ZUQIOh/wl/SYsfHEtXrd2ekM4uCuODQh4XqtUbIiUvlYMI8H7c?=
 =?iso-8859-1?Q?sFZt2sSpiwFXb/nH34I6qsj9zx+2RdCP84eCdfek6MkWZHutscnoXf5zyc?=
 =?iso-8859-1?Q?UylaXoQ8tLMiWcT2f5CWNKWNHg44XAtraixkHWGIoLputdKc+vxrIyGuVI?=
 =?iso-8859-1?Q?XoWlGNNq2HNGCKaaCCxRtnEIV46yob+1/wuypL32WKkukZNk1aIqtkSnhz?=
 =?iso-8859-1?Q?iTHKjIUiXnRt6IhMvVFzoedG/Oxw3cmiPFRH+8r+m2WKb8vox/jGTymIVm?=
 =?iso-8859-1?Q?5Q9Amo+4x0KEywUK3GUwxnz81gfJTZzLCSfcsZ6IN/5/AL23+8YkF+JnHI?=
 =?iso-8859-1?Q?ECyWowj72Bnxlt1hkM7yhN+0oKRzdHGkwt6vDuZG9Ya+VlqAs+PDZfIe5B?=
 =?iso-8859-1?Q?zslNlep1f9O3NnoK7jBLeTyq2y3ZOxFBPhb+U3zmwVLndrDK3QfnyRjuBZ?=
 =?iso-8859-1?Q?4LLrDooVadWqzS0xyb7zsEmvvE/UeN6EFrJfKKE1abOidpxUyBiUvFRK0b?=
 =?iso-8859-1?Q?er9Ecf35r5o4rmOPbYxNHUAjtivXZ8YVItMxBD+L7jqBBHzLYeL2HVx3gE?=
 =?iso-8859-1?Q?LfKQmawStLatrLfIQG/YdXCV9ud1sV19GQe9nQlLrMIukkFhntjf0WrYMz?=
 =?iso-8859-1?Q?LXnj3UoM/4S76NFHezICZwSFPFg2bsQNXjGlbg30n+yBuUHXwnHhgF+28f?=
 =?iso-8859-1?Q?rANoj1Uc+BeJ3WKbIBTAi5wKHtQE5P/pT0zktRKlD4gCoP6o9vc5W8Q+U/?=
 =?iso-8859-1?Q?T2uNpFRCp0B6bP0vIROg8ThyQjEyGBxzWUk4eRjmKL1I0ZJHSrNpdYRcNs?=
 =?iso-8859-1?Q?3aAaysfK381lQdEQgyl13N/3CE5gb31FijZXEcmQBWDwjTveQl5m2duk2l?=
 =?iso-8859-1?Q?OuBA0stxnzAeAPWe/iQRbwCW7/BUybOvUYRmvRlFSCO+GRdVGCPf5Hr0qI?=
 =?iso-8859-1?Q?eFhcDDMKXbT5z3+4tan0vvTdJXPZEXg1IGKgv+JTomIE3gANIDZ3TdE3aQ?=
 =?iso-8859-1?Q?XTGqjWzJhlD7hybjuSTljw6HpHytc30r9Z0eB7wh3Wv+qNlb1NJUa2CQ8X?=
 =?iso-8859-1?Q?LYzcPWGO/JabOdulC23INnubTxc11+AfgrXk+l3IpaD08KjOsyqy4KBfSd?=
 =?iso-8859-1?Q?fJ9D85BRFZ5+/u05A59hAum5lFzCgwWJqS2A8U/okl/1HDwztUi6Innb/D?=
 =?iso-8859-1?Q?pOLHhZ0WVwg3EBTG+mlaRuVebUc/CqB/X1kHlb7lR5FpwHpuRMjLcScg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fab45c8-0cb9-42af-4611-08dd517ce72f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 07:05:05.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6GuRrOkkpFVxj8AAtwkvwAMeFHcD+7UpLU5RVXZGN8iLBN/zlubnFxluuWpAv95uSUo3ZiwitJvetR9PvGaeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7759
X-OriginatorOrg: intel.com

hi, Sebastian,

On Tue, Feb 18, 2025 at 03:49:18PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-14 10:03:18 [+0800], kernel test robot wrote:
> > kernel test robot noticed "kernel-selftests.kvm.hardware_disable_test.fail" on:
> > 
> > commit: 66fbf677051818b9b5339fa8bfeac1b2e288efa5 ("x86: Use RCU in all users of __module_address().")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > 
> > [test failed on linux-next/master df5d6180169ae06a2eac57e33b077ad6f6252440]
> > 
> > # timeout set to 120
> > # selftests: kvm: hardware_disable_test
> > # Random seed: 0x6b8b4567
> > #
> > not ok 73 selftests: kvm: hardware_disable_test # TIMEOUT 120 seconds
> 
> I've been playing with that. It completed after ~45secs. The linked
> dmesg had also mmu_stress_test timed out but it completed here, too.
> I had a timeout in access_tracking_perf_test and memslot_perf_test.
> 
> The box is very sluggish. LOCKDEP, KASAN and maybe UBSAN cause that. I
> would say the commit in question is innocent.

just FYI. we rebuild the kernel, and run the tests more times upon this commit
and its parent, still see the issue persistent:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/group:
  lkp-skl-d06/kernel-selftests/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-kselftests/gcc-12/kvm

f985e39203090cc6 66fbf677051818b9b5339fa8bfe
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20         105%          20:20    kernel-selftests.kvm.hardware_disable_test.fail
         %stddev     %change         %stddev
             \          |                \
    580.92           +17.4%     682.06        kernel-selftests.time.elapsed_time
    580.92           +17.4%     682.06        kernel-selftests.time.elapsed_time.max
    550.23           +13.1%     622.20        kernel-selftests.time.system_time

as above, the time spent is also longer, though it's not only for
kvm.hardware_disable_test (the time is for whole kernel-selftests.kvm)

it seems to us that the commit really causes some slow down and it happens to
make kvm.hardware_disable_test timeout on the older machine for our original
report:

4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory


then we make same tests on another newer platform:

224 threads Intel(R) Xeon(R) Platinum 8480+ with 256G memory


we see the test pass on both this commit and its parent. but the time spent is
still longer (again, for full kernel-selftests.kvm)

=========================================================================================
compiler/group/kconfig/rootfs/tbox_group/testcase:
  gcc-12/kvm/x86_64-rhel-9.4-kselftests/debian-12-x86_64-20240206.cgz/lkp-spr-2sp1/kernel-selftests

f985e39203090cc6 66fbf677051818b9b5339fa8bfe
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         10:10           0%          10:10    kernel-selftests.kvm.hardware_disable_test.pass
         %stddev     %change         %stddev
             \          |                \
    238.99 ±  2%      +7.1%     255.89 ±  5%  kernel-selftests.time.elapsed_time
    238.99 ±  2%      +7.1%     255.89 ±  5%  kernel-selftests.time.elapsed_time.max
      1130 ±  2%     +31.4%       1486 ± 68%  kernel-selftests.time.system_time

> 
> Sebastian

