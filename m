Return-Path: <linux-kernel+bounces-172554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3838BF380
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC34A2817F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114F385;
	Wed,  8 May 2024 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F+cqL4B/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35F748E;
	Wed,  8 May 2024 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127557; cv=fail; b=K+m/k1l2tXQSc4nKUADJWfyYbc0+Iwud3oHKGG7cy1t/A1+18pVfuDu1F/oIHj1O3x9oE3AFMpvas1A5wdC9qGqGoMDpW4l2jfp2tAI5JPBMQ2pB3xZvjwNkzfjrGB4RqJYPihBemyObM6k5rEfhRVbb8I/8+/oF+ABcl4J8l6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127557; c=relaxed/simple;
	bh=xL1NtROtMS+3zjJ1fSGqYNytgKJf9qbJHTly5H3eFKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CSJfI03u1dqNchRQM+lN6aH/AtNX4WQ13/LT0F4Zq9y1o2Z1+Y4y8XFmMoTiSD9mG3EbUfgRoRcRUbnfiTEyGT6DptSzSiJA6EK+ZuA4WSw9WCKmgVEQQrPDMXh//+mdgZMZMGAlXogbf7n7kz6um3C4LMZ9UK1UjKzzl2Q1Ruc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F+cqL4B/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715127556; x=1746663556;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xL1NtROtMS+3zjJ1fSGqYNytgKJf9qbJHTly5H3eFKQ=;
  b=F+cqL4B/RrzVPV3z0rSFjOgn4SjVrQt0d4YgMNlHBLiK53wD0R1jePYh
   VXz9/8rD/jjEofZ68Q4NDGyIw9U8uC24A4EQrWMWLD8TL2gZEL0Hr9d5u
   elcsB+OwqNXseQQ++Yg88t6V9RzRbNrq1mKiyTRYqWrHXynsJyBAgafJ3
   TlZm6EjAMRDoPgg4UETggfnFVMuIul9LopzF//xWHdUQm3yoGvtZjdFpy
   DSphKccaVcO6SZXvVmXd3w2Muv8Su5wNqQbHLEVw1JD4YAfrd6X1GTl55
   4WKw1HT0AjUKd7NGdctIutrO74qADXShOwjzbQcSc9bE5FqI8hd6K1sk+
   A==;
X-CSE-ConnectionGUID: 6vj0drUTQsSwwiKxhjNfsA==
X-CSE-MsgGUID: myB+clOjTvq1D9eWtiO75A==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14768104"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="14768104"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:19:15 -0700
X-CSE-ConnectionGUID: cgeJiwHUTsCqzb53zlpV7g==
X-CSE-MsgGUID: 84speKoqQH+UL3RnvT01iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28653033"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 17:19:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:19:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 17:19:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 17:19:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 17:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1f0x9TcCwfF+QEsqloNh1EJc+6Szt1rYshAC9hkqOaWvimXGoDd+YaV5G/24gMF+a5/Js3x+1vENx8eT1oxa1z3LWxwdUJp0auB/E4UaUK25hwAv/P5nuMHOX6cre631UihwjpsnVYex27KdN+m52zZESHy8X+NgcL1bLdlvPP3dV9qQfS+2K8YsOW9GDwCQH1g2QkqZeZeUzCodvyjIv75ku+l1FRnPoWGjtca0ZxB5U/w1f9VqJlgcEfwj+XzlZQ6OYcj4cRT1nkZDEZ/AnBiuoZmZkcMlsa2FxPFx3Q7Tms/r0HEk0Swb181bqll34nin8M8MQj+RudLAG3AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8arLihPsJRjQ10YczMojDSQF7dF10biaRjBbPdLRUxg=;
 b=TIeH5DiY0wy8ZjGREm7O9iZtub/oaSJA0F32kVkOj02vuGeTr3ViRVpFfG8Aa3rzkon9LuxOLMR2g74ojnKKLvJqbxfZfmVgBTQu2w/UxV1pcvY7QwPzdG7CTZJGFGLzt8yQ31dc68snKfijhLUgBGgG0pULRpa6orpnyRfWuAtwpFUTEQt3o9q3va1NQz/ZvOyetf1UqajCKZApDtTK39M4aUp2cFXTMnv8qBUtCL+ISixZVQzmlz0Mcz8tUW1tFonbyeDC/kaIBMWsJ9dh+XTs1i8OGI7vHcA/ZPCqBiNCM5n1sw/LTfOyyuPfxOCgw3DV9nkOfKDjA0u1f1VNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 00:19:11 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::d8c3:32a9:ee81:b6e0]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::d8c3:32a9:ee81:b6e0%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 00:19:10 +0000
Date: Tue, 7 May 2024 17:19:07 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<tony.luck@intel.com>, <jithu.joseph@intel.com>, Ashok Raj
	<ashok.raj@intel.com>
Subject: Re: [PATCH v2 2/2] platform/x86/intel/ifs: Initialize AMX state for
 the scan test
Message-ID: <ZjrE+6UEhKFFYvBG@a4bf019067fa.jf.intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240507235344.249103-3-chang.seok.bae@intel.com>
X-ClientProxiedBy: BY5PR20CA0031.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::44) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: eb893489-8a97-4ab9-64c5-08dc6ef47bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mJ2gMfTwLjIT5IkJ7qb9ZPx2oM4FktKl+rT4fh14Z/xnrQe1ej7PVU/KsFvq?=
 =?us-ascii?Q?rvpll6C42SOBXR1P6pVRHpUhKiQg2NZSJqwbqw9dcrVLCDtj9dM2uKudkNWf?=
 =?us-ascii?Q?o7+0DZ7Z0lphqv+oqRaU4KJhIMc07iMyzSn+FNpLt5AClkROTTB5Rb1u7GKU?=
 =?us-ascii?Q?3zye4i58kd4CTIGCWUSAv19J5r/224b+eChl/no1MzceQQwRTh/6e1DkWL15?=
 =?us-ascii?Q?HFeTO7ttlB631zR0ZM5imZdWgA46mk3abZRInXGF0jWIyaffilxBBbiDiHrl?=
 =?us-ascii?Q?5+EB5poFZkhTqmFX6vuoPx7xxrHDMwa6op26WAdykyRwhDnC7VC4LNr1o+E3?=
 =?us-ascii?Q?D+LHMNL5vKNjvK7yU0LQFUNY+W6vQPvYYbo9zRtV/iUWhPE7PVWzYZILKNyI?=
 =?us-ascii?Q?88XBleb2Emu88u+iAEghqvatVjyilP6pKoCkf4TpvLy7oJSaRSbiL8a4CNfK?=
 =?us-ascii?Q?+j8rVQi8zEerqE5I6pKquyOvJglsoZDOWxIP3RYXN4C3PtjPexPcuziZPYZ0?=
 =?us-ascii?Q?E5pVfwD2MHKx5xYpSw7r+BZD6W75ysCfzKr6xoc0O4+aZ+3qAOUha/lPdSoH?=
 =?us-ascii?Q?lHZRphO78h37/O34f3+xxSjOJW2qjqk+7c40I4sqmKDXTUW669wazuwcoGgT?=
 =?us-ascii?Q?pj06/NP2RTh5Bh7XGPu5UeKlNxg+cG/py0+oej6uzQ8kv/ibTvf0+mY27iU3?=
 =?us-ascii?Q?FWb2YBBYr4Q1kEJtKJxtxmd8HNzAX1BOuxfEdTBYGv4BQrPPmJpr3Xj2FMjg?=
 =?us-ascii?Q?+0cKP6AcjUAhFoAV5dfkh0iq8pXmLEGba3irBublNSP7ifuX3jmOHOfQw+7a?=
 =?us-ascii?Q?n62WPWdQ7vJ46ObAOKWXXXCkqxNtOK9qXCt63wtmtdgCmwIKWGaJGtYKxrDa?=
 =?us-ascii?Q?kr+kcoRtArD7LEwgJc805UGLuC8TZsMyApt8hmnjA5q2+YstIY/DhELCxmkz?=
 =?us-ascii?Q?vxivipfgKC1A/HmJp7X5D/gdF5OGwYRNXKf8rQ/pMLJdzSdHrruBDl4tqBND?=
 =?us-ascii?Q?6YT3D+mj7543QUUVP8JC1ZlXtryzDnQr620Duwup0SrtCTQv5hyJXIIn9Dk1?=
 =?us-ascii?Q?oe1zYvBzYG4oyqQmBuEWGQM1Tk3xG9a5KGpqHnge6l5lCYV0BupzgRB/V3qB?=
 =?us-ascii?Q?CycA98v8UZ/nASylTDKtXMUeNgru6YWxf55/Y/+rCf0z7xf/rLCtCNrnZdwq?=
 =?us-ascii?Q?KgQure7z5KSYy0xazghxoIqr8+4WfpDaQhMWge+RlgszV3yyRfdbG02vsI3v?=
 =?us-ascii?Q?+Syo5bdtWfN6gAF7KrfR5dgd9T1quLk1A1TqgLdM7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7AQkUiP4ysHqKVoy43/ZSQsisdn6+j/gHDTTYTLmgvNoy7Vqf+F7Dng1VzGO?=
 =?us-ascii?Q?qEVwh7M5YgH+e1nXdTKiCs8m16QSZ8kU/ZozzucwQax69eK6kttfY2Xl9I4i?=
 =?us-ascii?Q?ukIBdPo8nj2eZ1JzzZBsOO5OGHMIP1WiRmWfdZJxem0uBnXbEup/uh2vMDIe?=
 =?us-ascii?Q?Rg/O3IyKpqDaYx0GmgidqxNIo9iw9qybHnU1d7zhAJzpSPZI4KFF5FVsLUbb?=
 =?us-ascii?Q?QdZgPunC47g8NCGbR1NzDknkKVn9QlQEhOFf2VrOY8TdwmLdeAcPAMDDtjbv?=
 =?us-ascii?Q?nbKbQe92ko9dhN4a8ctY2BuVBlcQ+ZUA3s8fBnWdccft8y5/RQH+fsHJ3rbF?=
 =?us-ascii?Q?+LrCtWroXLhnkzmOd3uPhQO9k95YtpQ2NrH4bI5nPkWThcPhW3ZRjIknkNrf?=
 =?us-ascii?Q?cwbJTBG6peL/Z90KWozgmjBr90hj79rrszngEXkhp0VZWMb0BB0v+0VmxGns?=
 =?us-ascii?Q?MxffLnBStZU+82phdM1L6sXiaRmj0Nokh3PfhqNAW0lyce8J8QlJUsggjYmR?=
 =?us-ascii?Q?0Ds9u0UX+W3Rrdi2rLk8ZdbGV2QnVPYJdN2Vds9/8u//eOlqxPHU5q+yxiCk?=
 =?us-ascii?Q?D34xt1U+5ecM5z82naKR6jBsnqVQBl4v4enCJcLGY6uDDadc9C7Vvyz0vLc/?=
 =?us-ascii?Q?UWn4MksYuctQ9ZDGRAGfGdOyAkLEUaDRw7u+IK+LsYRNR7ov2xKoNkW/1Xmv?=
 =?us-ascii?Q?M9BKvnRlZaDrG0ud82aP5CjAyua0ry/8i5+x1O35bgHSxcju8PdS9cHTmYDT?=
 =?us-ascii?Q?GIPmmC2knp9nvuNb33OZd7vNfFj+32Sjz4svjS4hfvo11HX3it+sa8tAhG9Y?=
 =?us-ascii?Q?zkJ3fno9qxdoHKzwwhFUjLikEvB5xCyvQOLnGk1Msgv+k41TglfbFezOu5ML?=
 =?us-ascii?Q?P9sHi3w8EPEKM03pYOb31qeZ6W2Cvm7mc9Xp1vDU8SUXNfVBwUw/Oral4UlY?=
 =?us-ascii?Q?8n3e+04M/OMzPkdChHIoRLopw+dyyIear7aZwfnURYACnnoM3pltBeT31UYX?=
 =?us-ascii?Q?LrtL8mMWbDQNredyUQeSBTVgvUDEBzrO9Vh0kG5O6rYM2G5YdphNzqwMrrDd?=
 =?us-ascii?Q?fdepVFggaJVgkbLwUIK+tbrXUy+WLBNg8bI2391vdDrFWVr/90XrwgZjEk0y?=
 =?us-ascii?Q?5a/9JUhjmrPVN+Ufgm6zz+2fdsMTWCikaup/qpPGTbfXd/0803oL3xDmESqi?=
 =?us-ascii?Q?PjuZCl2wVMeCj5xLI96kXHEtZVSx9xtyRg8NkmRAlVQvCJo+BmljyNhDvFLq?=
 =?us-ascii?Q?yMf0Y98ZYHKLbXYywYQF4S0r3Z3CKTl/3KMXkOBEqEGxpp4HBmypi143iqgb?=
 =?us-ascii?Q?tS3eYSTByTuKEh9wzaUQPHVERn0zs8yMv70peTBPWmMt91AWwAl2nBgb3N7t?=
 =?us-ascii?Q?i0WaGLdQLNlDvf+wj2i1ZlBr3Il490Dzh8UURO0FbQcE5AyO52GKEj0U5hyo?=
 =?us-ascii?Q?0+9GhuR3anCmpBAnn3vIXufyE+9JOd7msfdkzSR0AwZupHy7sdLATqpZpuKN?=
 =?us-ascii?Q?cys4JPYoqM55BjIegevExJ4x4DK02JGo8fWQToKNOucYkj7evz2SBpiBokjW?=
 =?us-ascii?Q?MpqAAbFGkAQQOXb1qP87A9NCIYOP9FgXbf3XE/PI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb893489-8a97-4ab9-64c5-08dc6ef47bba
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 00:19:10.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF514tTjgMVSyfJFVI6XoUVcq2AP9t9o+Uz6CCjR6zKM4ya5xIQjsIUGxZat4iLXKBb0wkqIbdEsgbE1Sjro/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

On Tue, May 07, 2024 at 04:53:44PM -0700, Bae, Chang Seok wrote:
> In-Field Scan aborts if AMX state is not in initialized state. Use
> kernel_fpu_begin_mask(KFPU_AMX) to ensure AMX state is initialized.
> 
> Introduce custom FPU handling wrappers to ensure compliance with the
> established FPU API semantics. This change follows the EFI case from
> commit b0dc553cfc9d ("x86/fpu: Make the EFI FPU calling convention
> explicit").
> 
> Then, use these wrappers to surround the MSR_ACTIVATE_SCAN write to
> minimize the critical section. To prevent unnecessary delays, invoke
> ifs_fpu_begin() before entering the rendezvous loop.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
> Tested-by: Jithu Joseph <jithu.joseph@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

for both patches. 

