Return-Path: <linux-kernel+bounces-573514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EFDA6D886
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D970188BBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8C25DCF4;
	Mon, 24 Mar 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSr/aDpr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517425DAEF;
	Mon, 24 Mar 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813053; cv=fail; b=JtQHZd25GS+9ZNoaBEXOjkdUXGry2mB3Eqm1UU+myXUgmTs+9CdKq7cUH9DjQRla7cdGZd8V8xlmG2MuPliNzQbQq4b31Vpv4UV3YecsbKub1KZuEid793Ua8APWWFq2IOQ5qBD251ZMcemX7clVcr/Rs5b4xSnTaJ3/y3U1PlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813053; c=relaxed/simple;
	bh=CnlwJ/GjJLaglkO7oyExuumnw046xD5XEWjVq7ogW2g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qGRys0fc0LAoLqA0ug0us0MZY2nTG1Rp7f6HJdVJXkvj2MU4eR0Momnx1BPv/5AblvN945QVXeFsBl6NzwfpOqawcE/JDy00jWF9ziayTDJPfx9gdE4oqhUouEPhPMoSO0lkGLutmaui+U+WXPorWq3nLF6jxWUSEcd8MlSrDfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSr/aDpr; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742813051; x=1774349051;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CnlwJ/GjJLaglkO7oyExuumnw046xD5XEWjVq7ogW2g=;
  b=jSr/aDprpfOTnH3VT+FE5lrjOYUpOWZTkhA0Y6qkRD6pxxwhNqdqGE/k
   bUs1Wo1F5RKBjfnWmWXxtDG/55O1jVPccRKPOcZKWQ5zb6a2XuDbCjp1I
   SXWM+JT/YLIzvjbvKT8tVImq+IQAx2Lw8Woz/tuXOcNepIeiMqJwevGpw
   LpyytCrPFsfcYOxyuyNx3hJJyVOaeV6XCE/jiuVFaL2+wA6CFYMoCL66N
   Gxs5UaZmD+teDqWRjNhDtBfXwdftK7emc3wrIZgNR9N28iLigBgDm0r9Z
   3HJAhN24SLWgp3p5t/giToR9M7lNsT2yAzacIQfEB3hXoxDAih3hkpJLY
   Q==;
X-CSE-ConnectionGUID: dBNAb9qJTlCGbkf0/AGL5g==
X-CSE-MsgGUID: v3qupml+Qcq/YSAuIuaIAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="54217545"
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="54217545"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 03:44:10 -0700
X-CSE-ConnectionGUID: sDTaiS58Qke8cJU0xo1IuA==
X-CSE-MsgGUID: xBj05LOORweOcZ3SkxgMFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,271,1736841600"; 
   d="scan'208";a="123736159"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2025 03:44:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 24 Mar 2025 03:44:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 03:44:09 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 03:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZTq3TYw4ptK1jRAV6YKl76npwA2Y2y9IaMEBUaH3fMokpE6oO1OTKRchrSNKvzGXhYrzzjqE3L8Q88XRPAUGemvsM4kLBzTXERi0WgQywU/76rFTr0KfT67aItMnMYcS63f2/VUSrQ/mhpPVfMCVP4qWBAm2ljDGNDjJEwFvzf7r3zssoziw5aDxTdu+O1hSoXK1F1BnUCKZe7bYgpHgva2zdwqCvCf4GRjNQioPo1DYKz5q7R8/w0e6hjUsmKlq38PWb09Mg7tsbftYBczqP5XPQcTqZ423AkM5C31dlXpXTpDiivj0L+MmdSV9Sn8Ygek5LVc8CKy0Ypp7zB7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/pcBCXDpjk+A9RmsfbYv6Q+n1unqa5TcAqF4jLcSQk=;
 b=SYcjx1A1VTeXKyIlebbv8KA1dtAFvWlPkNPWlkuK5XMDoYqC7Ev6VVnnGULjQ+u4WR4YJvBcLX7NnKi11I2w5yV0biGhR7/4U8KjeEyOUrlWALU5BtteOzSMlMKadjZ9tv1H6x3aNCYJ6hVHVhWEpeRaiiwwLylICK/FRqdQFaFrmvIw6twwHzL6OjXNem8AWrF6mClbtr4iX2wKq+ht42wye958iM13hV7ICmGcyCEKoBFOiyhA5HAkljsm1dNNDWTvl1nREWNS6qoV+lkY/2hbkxV3fZKjF2yZq/CnZ5UU1odxoG634oBKdQaYJvmvtacFJLmi5/LnUQAs5kJ/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MN0PR11MB6182.namprd11.prod.outlook.com (2603:10b6:208:3c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 10:44:06 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 10:44:06 +0000
Date: Mon, 24 Mar 2025 11:43:27 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
CC: Florian Mayer <fmayer@google.com>, Vitaly Buka <vitalybuka@google.com>,
	<kees@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<kevinloughlin@google.com>, <peterz@infradead.org>, <tglx@linutronix.de>,
	<justinstitt@google.com>, <catalin.marinas@arm.com>,
	<wangkefeng.wang@huawei.com>, <bhe@redhat.com>, <ryabinin.a.a@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <will@kernel.org>, <ardb@kernel.org>,
	<jason.andryuk@amd.com>, <dave.hansen@linux.intel.com>,
	<pasha.tatashin@soleen.com>, <ndesaulniers@google.com>,
	<guoweikang.kernel@gmail.com>, <dwmw@amazon.co.uk>, <mark.rutland@arm.com>,
	<broonie@kernel.org>, <apopple@nvidia.com>, <bp@alien8.de>,
	<rppt@kernel.org>, <kaleshsingh@google.com>, <richard.weiyang@gmail.com>,
	<luto@kernel.org>, <glider@google.com>, <pankaj.gupta@amd.com>,
	<pawan.kumar.gupta@linux.intel.com>, <kuan-ying.lee@canonical.com>,
	<tony.luck@intel.com>, <tj@kernel.org>, <jgross@suse.com>,
	<dvyukov@google.com>, <baohua@kernel.org>, <samuel.holland@sifive.com>,
	<dennis@kernel.org>, <akpm@linux-foundation.org>,
	<thomas.weissschuh@linutronix.de>, <surenb@google.com>,
	<kbingham@kernel.org>, <ankita@nvidia.com>, <nathan@kernel.org>,
	<ziy@nvidia.com>, <xin@zytor.com>, <rafael.j.wysocki@intel.com>,
	<andriy.shevchenko@linux.intel.com>, <cl@linux.com>, <jhubbard@nvidia.com>,
	<hpa@zytor.com>, <scott@os.amperecomputing.com>, <david@redhat.com>,
	<jan.kiszka@siemens.com>, <vincenzo.frascino@arm.com>, <corbet@lwn.net>,
	<maz@kernel.org>, <mingo@redhat.com>, <arnd@arndb.de>, <ytcoode@gmail.com>,
	<xur@google.com>, <morbo@google.com>, <thiago.bauermann@linaro.org>,
	<linux-doc@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
Message-ID: <s7wo5gqrvqfiq3k5wf2pwdurtdrzixlubmck5xgrr4eoj33hi4@vjexcwpp7g4g>
References: <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
 <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
 <CA+fCnZcOjyFrT7HKeSEvAEW05h8dFPMJKMB=PC_11h2W6g5eMw@mail.gmail.com>
 <uov3nar7yt7p3gb76mrmtw6fjfbxm5nmurn3hl72bkz6qwsfmv@ztvxz235oggw>
 <CA+fCnZcsg13eoaDJpueZ=erWjosgLDeTrjXVaifA305qAFEYDQ@mail.gmail.com>
 <ffr673gcremzfvcmjnt5qigfjfkrgchipgungjgnzqnf6kc7y6@n4kdu7nxoaw4>
 <CA+fCnZejp4YKT0-9Ak_8kauXDg5MsTLy0CVNQzzvtP29rqQ6Bw@mail.gmail.com>
 <t5bgb7eiyfc2ufsljsrdcinaqtzsnpyyorh2tqww2x35mg6tbt@sexrvo55uxfi>
 <CA+fCnZdunJhoNgsQMm4cPyephj9L7sMq-YF9sE7ANk0e7h7d=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdunJhoNgsQMm4cPyephj9L7sMq-YF9sE7ANk0e7h7d=Q@mail.gmail.com>
X-ClientProxiedBy: DB9PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::17) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MN0PR11MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 127e1b9b-34ab-4bd4-f8e9-08dd6ac0cce7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm1KZVNBNkFZWXlvN3JHMmpHa0NYQzlrUTQ1TGNoWnNsOWJ3Q1kwWjg2QmtT?=
 =?utf-8?B?c2RTa0I5cysxOUdLMTl3K1hFb1JXWFRpU2lxOTc2TEFWOUhsY2RISEFNSmJ4?=
 =?utf-8?B?RlhtMnkvRDhEb1JwMU1YeXVENWY5eCtxalRnM21wU1RtRFdlMmg1TW45Q2hq?=
 =?utf-8?B?N2FlT2xiK1RMTXl6UnU4NGVlUWRtU0dzL1lBZGQwSWF4eS9TMUs3U2pReFY4?=
 =?utf-8?B?ZnZQQU5OWHRWZ1NjZmIwV2xZWkNiSUNYcFpBdkZGY1Q0MGd5SWNtcmhETGJz?=
 =?utf-8?B?RXhRODlqTTdnZlJrUVdYYitiYUFIckdMNGlQK2RSTjFjRzE4SSt4SGcvSGtS?=
 =?utf-8?B?aE9LWFA5K1ZOWFBRdnlrd1ZBK2hlbVlDQWFadmNrQk1BZFVCUlRyNUliT0l0?=
 =?utf-8?B?WXloYnVlNDduNlF6RFA2TXpXT1BqYnE3SEJsdmVoU0xsWjNOZDU4UFdrYTJQ?=
 =?utf-8?B?OUFrN2NzQ3dxNlcxVkVqKy9TSGJUVDFvUEU4NzRwOW9ZWVgrckZpaTB1dmxp?=
 =?utf-8?B?c2FDWnh2YUhUVkhvalcra2RDRDJEYkloa2pTSHpqNU03OGprQVh5dERzb0tC?=
 =?utf-8?B?MDJxOXFQT2dtVUF4bm5ZRTNvQ0NINXMyK2VwbXFTWG1hNTNzMHBsZTVEN0JW?=
 =?utf-8?B?UkJ4U00xeThzOHRKRjVjQUVrcG54d0N0RWJWc2RsSWY0NVIrbDlINERPc3ds?=
 =?utf-8?B?MVdnR3VwbE9vQ29RWHJVWUpkL3N5TGVXN3JuZ2pmRU8yMkdSUHY2S2Q5Z1hJ?=
 =?utf-8?B?V2dRZm44UXlLSm0vM0V2T0JEeHlMTTVVZ1VibkhESWhGenpXZDExdXNCYUpE?=
 =?utf-8?B?SXRKQWNaSXdwY3ZucHZtZFFuMURoV1YwZnVvUXdNVFNnNDFUVVAxMWIwZ1Fz?=
 =?utf-8?B?SjZ3RlNHSWpxdDZneU9vWjA0SHQxNENNVEVzOGU3N1RmcFphRkYwLzRHaG5N?=
 =?utf-8?B?RGNsVWhwUG8yTkpFeExPRjJzSzZqNGNWWWw2N3FNVWk0QUpXdkEzS2hCM2pV?=
 =?utf-8?B?N1VnM1hoVGtKQ2M0QUNJVVJBOUZSWFVha05keUJyVXFlL0NacS9vUVVGd29Z?=
 =?utf-8?B?UkNRQzdUQVliSzY1S3VhQVY3eTJvOURCZllrcFpUdENndHRtZ2FSL1loM3Zz?=
 =?utf-8?B?Vko3aFFKSm5Na29DTE4xZlMzUDlVTFU3RG9HQ24zMEloOWNSNHJkNWdDWTRZ?=
 =?utf-8?B?M3BhZjk2MGZsRlJvYlBIS09rS1JsdFB3WkEyT3Y2OC9mM2VxOHVzTzUxNUZr?=
 =?utf-8?B?dDRRS3g5MHVkMHRVbUY2Ly9Zc1VYZDhDcmJZTnZ5MFdmdHo5VHdnUUg4Rkg3?=
 =?utf-8?B?QXE5eTU3R0tsUHljWUpLM1VoMW5xUldKTkJ5bFVtYVVJODBKOG9OcmxnTVI3?=
 =?utf-8?B?aFAxb0JGcy9senQrTmZTdGxpWVgvNVVCWTl1UDltTjM3TGZjTmo5andNVFJH?=
 =?utf-8?B?R1N6ZkdDaU00dFQyZVFiUGw1enIydjBDWEJmbHZwcDhtQUZqZG1PSlAwcEtI?=
 =?utf-8?B?cFRJcmdRLy9JOUZPTzVEdDUwS0trN1dtbU5NUzI2STh5cm5FTVFBU3hzcFMw?=
 =?utf-8?B?blRMdWs4WHNvbEN0M25zNWZUdUtvUzNsU3RtYktneDlTM2dVU2ZwT21sZG9B?=
 =?utf-8?B?ZUJnejFkNE5Ed3R6VHlIVkphNXlzWDBTRWlJRVF2cExjNmVHVi95VGpZallo?=
 =?utf-8?B?MFNITWNRSzF5Z3BCKzg0ZXNxM3JIY0tESDBhTWRXTW03a2dVbHFtL21ySHZT?=
 =?utf-8?B?akxIam1JMVlkcGs1U3daN0hIdHh6SVN5RzVwOHY2WWF2bjZzRUZQd1B4cWpY?=
 =?utf-8?B?elRzWXM3cVdKQVBweWZhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1kyZWU0N2JpM0MzTGdVZFE5WW9yNWR0bHNidDE0RnVpQS9jdUVCejhJRHhN?=
 =?utf-8?B?TkV2U0QvbjNWa1psSGNma25FQ0gwcllqbXF1Sjc0b2xuV1FJbEFPV1d3YWl5?=
 =?utf-8?B?WVluR2NCaDRGNGZxUVRZMmxsZXRiUkhQL3FLbm1uZHljY0VER3pQVkhRMUVL?=
 =?utf-8?B?SmFzS2dhdVBIbEdZUnFJSmtiZko1ZTdLZmtBZGd3MU5iR01aTFNsZkNBWFZX?=
 =?utf-8?B?TFpGSDQxcWdQaGtDOFlnaWZTeFJIb1R3ZXNCVjMrdVdZVlI3Zmo2SHJ0SUN5?=
 =?utf-8?B?dFYxbHlTR3NTYkVJaUk2cUFuRlF1ZGMyZHVSdW5PajAvY3NEc0dybjlrY1JC?=
 =?utf-8?B?ZUcrbkJYeVh0M1hId1pUYTVWeHF5QmVzYjkyVjRqUGt0cVRuN3A1c1B1d3JG?=
 =?utf-8?B?Y0lQSVNJekx6cFdJenF3alhpSjI4SmVJWHRGUzFONFJxOFRhK292MXFJZXlB?=
 =?utf-8?B?RDVKMEdZR3dmS3FiWXk2cXo4dExyNnVOL0xzOTkvYWVKbHNPcEVGQWU5Q0Nu?=
 =?utf-8?B?c0tPcWJ2dEh5NkMyOXdGMW94Nk4yVkJ2U2FCY1E2Y29EcWtFWkFwdXRSYncv?=
 =?utf-8?B?YUp2bXhUVXZldGpHSXhpLzBGUnNlQnAxZ3BwUlRiMU1UeXFWbjBuTERYZi8x?=
 =?utf-8?B?MDJ4eTF1WWU2Z25OT3lKMkgzYitpdXpscDV2UVljZzFPL3BPRlZsdTJPZXpS?=
 =?utf-8?B?TFNGMjFGQmRiTkw3QlFOQ2p1bnBKZTRaZVR5cVlXbzNobjRSdHVxc253MWw2?=
 =?utf-8?B?SUdhZXRKWGNCcTJIZDloVGNwTVl2RHZYMm9VV2Q4aG52S2kydWw3S09DaXJO?=
 =?utf-8?B?dkZpT2hFUkpkTFgySkNPS1FLNFRBWmJRYVZtLzZTSkhUL2xmcTR3WmlyeHFS?=
 =?utf-8?B?WFFBSElOMXZLT1BORHJ6ckgxbE4zdFdUUWtKVUd2UDRPSXpYNi9DVzdTQyts?=
 =?utf-8?B?aG80Y3lUdU1RYXNOUVV1M3d5dFpGV2hwMGFrK2NEY2dwbkxlT3lTSXNhNmdC?=
 =?utf-8?B?WjF4Tk51dmo3V1N1Qlc4ZVQzTkZ3dStpRVlGQzhxckZGRUtUZTM2RXFhcVUx?=
 =?utf-8?B?bWt5TThUTWt3MEhNNE5Rc0JoS1grcTNvM2JFMk9RdzZXdHhEcVhTT01PVkhO?=
 =?utf-8?B?bmdBVXBXbGpaWW0vWGxHTnhPOFdObGphZlpDTnJranVEQXFtSllHbGE5WDhJ?=
 =?utf-8?B?V2NQSlJkazBUcy8wTHJMNVdySy9EMmtvSUpnWkZrazZNaDUxZVd4NjFndlM5?=
 =?utf-8?B?QUoxNlVGQVB6UmVCTDVWV3ZXWHBrYWs1dkh2L0kvMDhRcnYrUHpRbmhPMFBu?=
 =?utf-8?B?VWxkUkc5UDU4UnMreU8rU1kvTUprZzkyb0lESDZpWFJnbnJhRGQzOUxOalM3?=
 =?utf-8?B?bGROMXVRdFZtblFXZmxLZnhFQlgzclNNNFJBaEh0dDA4a2tIbFdoVWJmdDdl?=
 =?utf-8?B?UXEvRnBLOXdCa0hVVFVPbGM4QnA1T1BwODdQaHVOdmVQcGhldlNwdDlucGpq?=
 =?utf-8?B?bFAvcjVhZkowQ1kxUm5DWWNOajdiR0FtcWc3YXZLWmlrdlRDSG1zTGVXZVVw?=
 =?utf-8?B?U0I4bGI2OGtPQjQ1UW1sWW1PeHBCTjRRZkxoWks1cGhtY3ArZS91VDN6Um9p?=
 =?utf-8?B?QnZKU0grZVArOEdaTytHdExld2lIbXQxVU1BcWRJeHBGdEIyZzdoTW1EdU5M?=
 =?utf-8?B?TjRYeFBkditibEdjMXZPN1MzOGlXakRSaUJMRWVVdWx5OEZzRFhSSnRMRnpC?=
 =?utf-8?B?UVlBUFAvSWd6cmhlcEFGNUFUeWJFR3lxY0NFTDZxR3RLQXN4MHpLTTl4TU1i?=
 =?utf-8?B?ZlRpQjBDK1A3Z2FiTWo0dVgxTnRncW5GY1J6WmNQaEJpL2FPVjZoZ0lXc1NK?=
 =?utf-8?B?RTRESnM2SENMM0VJcXU0cXM3QytxQy94RDZHajBVS3JESUxhS2wwS3Z1c1l1?=
 =?utf-8?B?QTN4RW1ycDVhZ0E4cTBya2tCN2ZHYTY3UEVsT2ViOHphQklSUjJTNkhuQjJl?=
 =?utf-8?B?clR1VHRVdzVBS2FXd0lFRFQ5RE5RVkw0TWRqRTFaajkyZHZEd3g3K1BHOU4r?=
 =?utf-8?B?a1V2WnNRaXpvMXhWdmZybHVSRUZpMHlYWUxWR2dZK1VHWXhQdGhQbmFlTTM5?=
 =?utf-8?B?TXQ5NDAzTXQxeWNIb1Y3dXM2ZE1vMzFjU3BqVndIOVgrT1lIdnFwZW9iUThY?=
 =?utf-8?Q?j0JYB9M/XzVJ11FFd9K9PU0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 127e1b9b-34ab-4bd4-f8e9-08dd6ac0cce7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 10:44:06.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6mkA4a8Ymb2mnrT6fy6qSZ+AsL5hGrWgmqlE/8+98xSdpxO6UfqvBs905+PmwBowYrWzHwQjcdz4vn5EOpf9oJX99oj59JD/BGC85RTU00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6182
X-OriginatorOrg: intel.com

On 2025-03-21 at 21:16:12 +0100, Andrey Konovalov wrote:
>On Fri, Mar 21, 2025 at 8:21 PM Maciej Wieczor-Retman
><maciej.wieczor-retman@intel.com> wrote:
>>
>> >To account for this, let's then set hwasan-instrument-with-calls=0
>> >when CONFIG_KASAN_INLINE is enabled. And also please add a comment
>> >explaining why this is done.
>>
>> After adding this option the kernel doesn't want to boot past uncompressing :b
>>
>> I went into Samuel's clang PR [1] and found there might be one more LShr that
>> needs changing into AShr [2]? But I'm not very good at clang code. Do you maybe
>> know if anything else in the clang code could be messing things up?
>>
>> After changing that LShr to AShr it moves a little further and hangs on some
>> initmem setup code. Then I thought my KASAN_SHADOW_OFFSET is an issue so I
>> changed to 4-level paging and the offset to 0xfffffc0000000000 and it moves a
>> little further and panics on kmem_cache_init. I'll be debugging that further but
>> just thought I'd ask if you know about something missing from the compiler side?
>>
>> [1] https://github.com/llvm/llvm-project/pull/103727
>> [2] https://github.com/SiFiveHolland/llvm-project/blob/up/hwasan-opt/llvm/lib/Transforms/Instrumentation/HWAddressSanitizer.cpp#L995
>
>Hm, I only recall looking at the compiler code when investigating [1].
>But as this series points out, [1] can be considered a feature and not
>a bug. Other than that, nothing comes to mind.
>
>Thanks!
>
>[1] https://bugzilla.kernel.org/show_bug.cgi?id=218043

So I assume that if outline mode works, inline mode should be fine as far as
kernel is concerned? If so perhaps it will be more time efficient to post v3 of
this series (once I'm done with kasan_non_canonical_hook() edge cases and
unpoisoning per-cpu vms[areas] with the same tag) and work on the clang side
later / in the meantime.

-- 
Kind regards
Maciej Wieczór-Retman

