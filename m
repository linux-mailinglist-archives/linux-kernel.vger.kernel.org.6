Return-Path: <linux-kernel+bounces-434349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C53D9E6554
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FBE28551F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBC1940B2;
	Fri,  6 Dec 2024 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/XCN3qr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254728FD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458496; cv=fail; b=Zmx1ACCmKoC8Za7KymRmOfvk6BiGVPFbR2rao8Mpa89DNsLaZGjwc1sRe+0XeN//iNAYXV3zqdIgC7AqwHHoIdPT0HOSJBb2YUq04qGU+T4mzobhYQefXxGEFDHAOt4o/piwUK/u15yMmzkfsSmjNuVXlgc9y5Xm7AH6A0j4waQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458496; c=relaxed/simple;
	bh=/h4gNDR5A2dqRBiENlK+bDwgUa8Woqy/DqTKHK6XRXk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UcJ6Vw9VAVS/sLN9foUzx8bsmEk7tShR8i+E0Raz7euO6y56c2/Pz/8VMBuc8Fmog5aat8Cwmcqtjj1ghmlVKjW3F9ub6XVEVPhdPet2mgU44/4AhR/j56FjNOryZCGtAtcvOIrFJf3mbR/d8BUQ9PQUrMhyCHHhG/HLMx/ckUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/XCN3qr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733458494; x=1764994494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/h4gNDR5A2dqRBiENlK+bDwgUa8Woqy/DqTKHK6XRXk=;
  b=S/XCN3qrOtA2+I24+QWYB2kSxtHlEzIGt0Mga30C53VyQ8BcProDkbZ8
   pwt19QfWMI9dUi/OMyCNTJzGkW8h6IcYwP9RzXDK8nUS8fHgUbuygA3aV
   3uJvDWVa79dQJWb3bOAdi7lD7gQg/yYPqnHNqdsd1BdeaZ4Tw1yOz3xzQ
   m0itllBO2XIWOZ6/+ARSvIYvASL5FW5xZxhcsuPTwrESLr6HAwokb6ZFV
   OOlnyhyhxWFmG3zqWd3sBTk/SdweNQZU8M6XYpfDiM4puAXCQ18KOBuwm
   8hJhKctkBLqOS78WNqCyhwHkzIzv5S5JxogvGKucqcUNEqeKBGX+7+e6P
   Q==;
X-CSE-ConnectionGUID: 36ytQLouTGOVhPhjlru0dA==
X-CSE-MsgGUID: gr5hEgEeRlu8u010mJeHwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33932147"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="33932147"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 20:14:54 -0800
X-CSE-ConnectionGUID: 9ew6CM6qQ7OszFQ6QJO2dA==
X-CSE-MsgGUID: 5+KEnuFmQyKU0sBBqjnwQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94494819"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 20:14:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 20:14:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 20:14:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 20:14:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsdu5dl+VmeCnh9oLH1rrty6rvGcBz3rHrD/CVSQZU3Y8cjzL+mxuTzgy5ZNRq87L88U0nozVzo2dZn6U3Yg5tRod2cmNEuNk9FGo89Vy9jWD9y9E/xjICawOEv64O+FLpFqKE47BhTxgePKe96yGsIgwqRiQ7DrePUVxl2vzm+c2+WVcjJxmXvFDrW7m0eF9hej1FCzRYabADDTbMEfoh71t6Hrq7CnW/rYhk/s3O0HrrKRNYgY+RdBkSNdYlIQmToewk9IcPmN+3t2RevtGUGxrN0u0/sRUz+rif7Y+KxHsiYWJUX2Y3b7enMoOH3nP/mBraTetJzAdCcnTR0QUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5jOHuN1FQMB5U2MZtPWJaEs5TFK4HGOyh4JSl04BFM=;
 b=rPqTn10+lycEP/b2Hj4HIwfCs8KY9dMGy31KYTHahT1PP5c2SJRJMnfypkxFx8nenH0m222TvPrX6kEVsvyH1hNqbEC0ctaRq5nBfz/10nX8ObPZB/f5UuFp64+8GTbnYubfwYUs6pfiCC7w0mU7Q+qL1iEBYIR2G1f0n58ZiMfcnh3pqwv+G8TrN3eXfmkeCMMxvb5Oy57pExX3epZMqq9o6nJn0zQF9SZZxfxg0xziXRyjsOxTO6OmqxjP+3iEcqsh/pp4OOl48wOuvdyufNkDJwyN3x5TrNyDdUK/rpqe0XHYfwKoZAZw7fV+DA7uQ2A7+VQ/HBcCuzRkDubDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7089.namprd11.prod.outlook.com (2603:10b6:806:298::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 04:14:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 04:14:50 +0000
Message-ID: <2214f589-03d5-4037-8997-bbf78077a101@intel.com>
Date: Thu, 5 Dec 2024 20:14:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] x86/resctrl: Disallow mongroup rename on MPAM
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Uros Bizjak
	<ubizjak@gmail.com>, Mike Rapoport <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-4-peternewman@google.com>
 <4a6b1645-c72c-41dd-a455-bdf0ec57d4c5@intel.com>
 <CALPaoCiH0CZgEL8UQZeTrRtV_b-Oc6JyvaG4+txuZzsHCv976Q@mail.gmail.com>
 <CALPaoChad6=xqz+BQQd=dB915xhj1gusmcrS9ya+T2GyhTQc5Q@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <CALPaoChad6=xqz+BQQd=dB915xhj1gusmcrS9ya+T2GyhTQc5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:303:6a::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 624191c7-9fde-4ca4-fec0-08dd15ac86fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0I3dzJlbjlIc200RmdyQXZPaHFOK2pabkMzNVBiR0J3THpFc2F0YnFlNFBl?=
 =?utf-8?B?dERZaHJhaGkvUmR3WlZFSnZmN2N1dGd4V0U4Ti9QSmQ0bFVubW9Sc1lmMVkz?=
 =?utf-8?B?TlV2RGtwTDNRYXNtb3lxb3FSekQveEVNQ1plUGxYV2dCa3d0MWZOMThmandu?=
 =?utf-8?B?VzVJUmlNVjNtc3BQckp6dC9YTm0ySHdIaURkVkMyY3BEc1V6SjVtQkF3WUph?=
 =?utf-8?B?Sk5HSTRUM0NydUZOaHVpblUwZHZNZUxkYTdVdXloM2hVOTFpQUh3a21zaTRl?=
 =?utf-8?B?c2FZVUYxY21NNUtid1BSY3FYamtxaUxkckpYTnIxVXIzYWZYV2RZWExTVVdT?=
 =?utf-8?B?RXFKRG5zdEJHWm5jZUFYZnZHdEV4ZTIvbEZ2WjR4RGI3aElsZUQ4VlNsRHYr?=
 =?utf-8?B?UUMyNStBcms2TGNlSmlLZmxSNnFuekhEcFdZNytrNm1BSU9WMkpyenVDR3FO?=
 =?utf-8?B?ZWE0Ulg1QVp6UHFjSEFYQVVzQXJwYTQyb3crREdCd3prclYxYWY0WXkyak03?=
 =?utf-8?B?TVJRVFNzR0xzNklNZ0NiVVFMalBLS0h1NllKVWFoSkVUMjZqUXRHTThUR2lB?=
 =?utf-8?B?a0NWS041bHNWL3FJczQ5enhKR2lWZC9kcU4yV3lZTi9NYUoxUjVHS3Qwa2Nt?=
 =?utf-8?B?RlgwbnFxRXZKb291RmZNQWRJK3dhUEs5UmhhY0xEekdxR24waEF3UmpPNzlv?=
 =?utf-8?B?QzVqaWpRWU1TZUE3NEdXeU1TNEhYaGJUNVh0SmRKMWxyTFJDdXgwcmN1UHA2?=
 =?utf-8?B?aE5yUTR3WUg3OFU4Rkd1UzhpWEtVQUg4V0NUZ0hzdTVTQ2FRenNvU1lvVG0w?=
 =?utf-8?B?WjFaeHF1Y0djQkVVcHJObE03KytCaTdicnh6L05hSE9hL2Y1c1RWakd0TGt0?=
 =?utf-8?B?L2VEYWZmMkxuaEZqS2MwWFZsQVByQVRmZEVTRWRvSnRKZ2lrWFkwVEpNWGxv?=
 =?utf-8?B?Wko4eEltdm1iZXA2dnkvVW5DVGNFUTBhZGduV1NhcmZlT1c3VTVucFliMU5y?=
 =?utf-8?B?VFpWZFpWTlJ6T2F4Y1dHcjR1R0phWUUrTFdSR1R5aTI2aFZUQ1ZuK2FvcGgv?=
 =?utf-8?B?NVFFQldtRjRGWUxRa0dDeWRWcUJDOW1NU2FnRXhydUxQV3NRRzJyclcvQk5i?=
 =?utf-8?B?MUxNMmFnajBldTg5SVU1eVpFTXRmUktuQTViWFBKTmlpUDFnbDBJNEljK3hu?=
 =?utf-8?B?QU5hMWpycDJxZnEzZ09yZXUreXovNi8yNy90aVE3UlNGNGJVTUw0cnhCT2lr?=
 =?utf-8?B?WWNSMVdDNU5EMHl5cWZKWmtQdFdPbTR5cUVSelV0QUpWdUZ5L0s3Q3lvQkVt?=
 =?utf-8?B?Ui9XRjk1aUlrREN2T3RHZUxpdEdVTkFsUnM4ZFVlc2d1aHhIS3huakk1WXgw?=
 =?utf-8?B?NkdUanppRlhPekVpTUl2Y25ER3Vnc1BST2ZQbm5Da0t0Q2tuSFBSSk5SQ1Z4?=
 =?utf-8?B?NEM2c0g5ZnJpUDZ4ZUswd0FNeHk1OXhpQ0l5SjlQWVFIQmZqdXN5bHAyNEZL?=
 =?utf-8?B?Q2k0RzRWSWE1Z3FwWDF2N0NRT0FIVk1DOE54OG9wNFZSeURMV093MXB6dW5u?=
 =?utf-8?B?QzFqazFUZmJqaUh6Z2lUZ0ZycGFLTGhPMnJmOVduSlJqTkVMdGR0VkFHYTQ4?=
 =?utf-8?B?ZmR3TUpaWFdPT01uV1ZYNnZQUzVaN3pOWGQyTE92eWREVUszeUkrM2pHTlJY?=
 =?utf-8?B?Z2RielNUWk82UEJwYnd6RnBjd05POXc2ZkFGWjJaZ3VBLy9zYm45blRsbENj?=
 =?utf-8?B?cGcreFh6VGhyKzFZSGc3c0VDVzFrL2ZwMUdIVmR6bEIyTlpielZUdEwxVGly?=
 =?utf-8?Q?mlOUWUL1kd13ebfBi5zD740LjKWYJ6yqjO2iY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RitkalJDTGlTNUNWbllvZUh2ZzFkMmsyNmQwSlV5bTFLTzF0YXdXVGVWcnl6?=
 =?utf-8?B?WUtIdWVSRjZPZkd1Z215SWRVNmVEeisreGlHdnlLRXhhekpLZGJKbU5tRm5Z?=
 =?utf-8?B?K3FLUkVwTGltVmY2VGVhZE5IRjBjNmlwamlibktyWmNtRGlSVG5IU1lXTUQ2?=
 =?utf-8?B?R05aMWtFQy9BdzZRQ0xiWCtUNHdleEtvNU9JTnRYUURNRmFPc2s1Sm1Wc1hY?=
 =?utf-8?B?WE84TUZ4Y0FwUWhrQ0NyYXVlOGlPRnVFZURsczJmTWRWa0JYY21YVWdzMjJs?=
 =?utf-8?B?NUVmVUxiQUVid1ZEMmlSVXBna1RQaExUaHQ2STV4NTZEZnhmNHVCbU9FVTl5?=
 =?utf-8?B?VkMyOUZHOVY5UGttS0JLWEpVQU9VNXUvcTVNOS9ZcmI3NW1aRGtUMWswcURL?=
 =?utf-8?B?a1NFU3hacjBEM1hEb3Axa0J1T3JobDdNNzNIcE1xUEtRTW5saU1Rc2txZUxz?=
 =?utf-8?B?cTZDZkxwU1BMdkYzZ3JwL1pVMmVpR0ZlQmZvcVNWRnFjR0ZhdU9vYk92MllG?=
 =?utf-8?B?Q2RvTEcrVEJzR2QvMG1qMndtdjludGxFUVN2Z0NpMGtYR3hjK0VWVDVZbE9w?=
 =?utf-8?B?QmNwaTNDS3oyb2U3NWNBMmxIMWh3dERaZC82aUFDaHdYd0FPZjljT0VwbS9S?=
 =?utf-8?B?bUVFYldLbTkvekc4dlFUZGZXNkMwSzJMaWZjaWcvb2pqS1RvK2FaeEcyRTUw?=
 =?utf-8?B?bXZyQ0QrRHhRS1kwWGJFOFJORGR1QTg0T1M4c2xpRTIweWpmWFRQOGx1R3hI?=
 =?utf-8?B?b1dkU1pBMEV6QktPbnFiYXRaL1NxQytEWnQyeVVmeU96N3VoQ3lIOWJPWlpq?=
 =?utf-8?B?d1VmUmNUanp4UjRjaHVrS3NDT09laysyc21VWWRDbVNNTmNFNUVROVZkTXJB?=
 =?utf-8?B?QU1RK1lhZHJhNU9POUJ5azd1bW5yZzk1bnkwcXc5NUNmQzFoWU9oRUFsUE4w?=
 =?utf-8?B?SlZLSHo5VVViMnkwN21uWVErbUlmTVdIUU1RMWJ2c0NQLy9wY2t4U083WG5J?=
 =?utf-8?B?Z3JhekIxbDVraEFwY1grSUw4M3hoSzNBUTl5aGJJYUtMbmdBWmpPQXRnbXg1?=
 =?utf-8?B?SExYWmlkbFdybFJwMUFsM1pjNWVWZXJ1aDlnY0w2eXhHQ0x5ZXY1cWh4MEU0?=
 =?utf-8?B?dnlIMlRxZFdlZjJwclliYXBMeVdCcHpjZEh0c01OT2tVUGJyNklYNDI4SVkz?=
 =?utf-8?B?VVIrb3gwMHUwR1pXcmFwR1VZNTNhdjgrVStjTkQ4T0dKYzhvZlJnMytMaWVp?=
 =?utf-8?B?N2JTcW5UZms1cDVWUG5hRFN6bUdyMUROTVNFdEpUNEJJcUpsT1BtR1BBNENn?=
 =?utf-8?B?bklLbC9VdjMxbUxTOUZwOWJLUVJlZ0UrT0ZUaUFENGxTVnJTcS9pb3VjV28x?=
 =?utf-8?B?eFhxOTZUK2Q5V1lkbUR0a1pjOVorZ1FkTThMODB0NWRJN0JkZkxTV0FIZGlS?=
 =?utf-8?B?Y2FkSXBETzhURXFhcGJIV3BzdFRMUHl2dUYxazE3bktQWFZPMWFEZXFabTU5?=
 =?utf-8?B?UWZGQnV4Ni9QekU2ZHNkdTRJR3BseG5RWnBrS1dOOWZnT0RVeS9Gc2pGbnR5?=
 =?utf-8?B?dXVVNVRLQ2o1UHNicGhiU2k1MkkrbFpjb3JoWUJoaW0xUFRlbTR1Um5WRnFl?=
 =?utf-8?B?Nmw5aU5TeGgxa3JsZkFuY3hBZWZTUmRNQXBUeGlxN09MY0JLRFVWZlVkNXBR?=
 =?utf-8?B?RGo5eEFwUkF0ZWRzNnFlWXljRzEwZFFZdmsvNWdWRnFaU28wcWJYZkxMVktt?=
 =?utf-8?B?K0hEQjlNSWc0blpndm5YSEZuZ2kwTnhIZGl3bFJQYjB4V0QwbkszQzUxbnl3?=
 =?utf-8?B?SDFSZzFtNUlxWi9JNjNicVpCMmg0S3hJdVBPUlMwU2xiYmpEdXlaZTI0RnpL?=
 =?utf-8?B?dkRvZFNaRytsWUhxYlpma0xLZ2Z5bVhtOEhNenBpRnQwNVJsZE5aQTZubTB0?=
 =?utf-8?B?TWNTTkplRUZSY0tRa3YxTmJEeFlFU2dGVG92cjBRWEk0ajUzc1FpT3lKQmta?=
 =?utf-8?B?N3QwZTFZQXU1V1VySXgvVG9vK0FkMk9vVDBOSGhRVU8xamUvQjdGdyt0aGd5?=
 =?utf-8?B?OFBtVTd5SnpDVHhrQ0dPQmdXM0IvaUtIUTgxcHowZmRmRXBiUEY0VGRXTFQy?=
 =?utf-8?B?N01oWSt1cWNtS2kzeHQzQmRlcG81Nkh4bWRUS0RBNkJsYXlEOEF2ajBHSXJ5?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 624191c7-9fde-4ca4-fec0-08dd15ac86fc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 04:14:50.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+9L+HjAPlCDzhRuaxV6kjwjF2JU3IEjw1kcaud2UwWEjuzlfbmhKNUdToiHIhEOIhoeECC9n0NzPebIkYKgEhKcwVG4yPlOSAMtIXveggc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7089
X-OriginatorOrg: intel.com

+Tony

Hi Peter,

On 12/5/24 7:03 AM, Peter Newman wrote:
> On Sat, Apr 6, 2024 at 12:10 AM Peter Newman <peternewman@google.com> wrote:
>> On Thu, Apr 4, 2024 at 4:11 PM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 3/25/2024 10:27 AM, Peter Newman wrote:
>>>> Moving a monitoring group to a different parent control assumes that the
>>>> monitors will not be impacted. This is not the case on MPAM where the
>>>> PMG is an extension of the PARTID.
>>>>
>>>> Detect this situation by requiring the change in CLOSID not to affect
>>>> the result of resctrl_arch_rmid_idx_encode(), otherwise return
>>>> -EOPNOTSUPP.
>>>>
>>>
>>> Thanks for catching this. This seems out of place in this series. It sounds
>>> more like an independent fix that should go in separately.
>>
>> I asserted in a comment in a patch later in the series that the
>> mongroup parent pointer never changes on MPAM, then decided to follow
>> up on whether it was actually true, so it's only here because this
>> series depends on it. I'll post it again separately with the fix you
>> requested below.
> 
> I'm preparing to finally re-post this patch, but another related
> question came up...
> 
> It turns out the check added to mongroup rename in this patch is an
> important property that the user needs in order to correctly interpret
> the value returned by info/L3_MON/num_rmids.
> 
> I had told some Google users to attempt to move a monitoring group to
> a new parent to determine whether the monitoring groups are
> independent of their parent ctrl_mon groups. This approach proved
> unwieldy when used on a system where the maximum number of allowed
> groups has already been created. (In their problem case, a
> newly-created process wanted to determine this property independently
> of the older process which had originally mounted resctrl.)

Could you please elaborate why users need the information that monitoring
groups are independent of their parent ctrl_mon group?
I understood from [2] that Arm can be expected to support moving monitor
groups so I am concerned about userspace building some assumptions like
"if the monitoring groups are dependent on their parent ctrl_mon groups then
monitor groups cannot be moved".

> 
> Also, this information does not require an active rdtgroup pointer or
> CLOSID/RMID. The following will also work:
> 
>  resctrl_arch_rmid_idx_encode(0, 0) != resctrl_arch_rmid_idx_encode(1, 0);
> 
> I propose adding a new info file returning the result of this
> expression to be placed beside num_rmids. I would name it
> "mon_id_includes_control_id", as it implies that the hardware
> logically interprets the monitoring ID as concatenated with its parent
> control ID. This tells the user whether num_rmids defines the number
> of monitoring groups (and ctrl_mon groups) which can be created system
> wide or whether it's one more than the number of monitoring groups
> which can be created below every ctrl_mon group.

Is the goal purely to guide interpretation of "info/L3_MON/num_rmids"?

The "mon_id_includes_control_id" seems unique to a use case and if I understand
correctly needs additional interpretation from user space to reach the actual
data of interest, which I understand to be the number of monitor groups that
can be created.

A while ago James proposed [1] adding a new "num_groups" inside each "mon_groups"
directory, on x86 it will be the same as num_rmids, on Arm it will be the maximum PMG bits.
At a high level(*) I think something like this may be an intuitive way to address this
issue. What do you think?

(*) If considering this I do think it may be more intuitive to have the file
be at the top level of the control group and be named "num_mon_groups" (or something better)
to support the idea that it includes the CTRL_MON group self and not that all monitor groups
are within the mon_groups directory.

Also please keep in mind that during the discussions about moving monitoring groups
there were some ideas of needing to provide additional information to user space about
whether counters are reset on a monitor group move. I think that if we are starting
to look at these random properties as files in resctrl (like "mon_id_includes_control_id"
and maybe "counter_reset_on_monitor_group_move") then we should consider some alternatives
to present these flags to prevent resctrl's info directory from turning into a mess.

> Without this information, I find it difficult to create test cases
> with a maximal number of groups in a portable fashion.
> 
> Also, this would be a good opportunity to generalize "num_rmids" to
> "num_mon_ids" and add a symlink between the two for backwards
> compatibility.

I am hesitant to add "num_mon_ids" to the top level since it creates impression of
being a generic file but is difficult for me come up with a value that can be
interpreted accurately by user space (without knowing the underlying architecture, which
we want to avoid). I think we can perhaps focus on alternatives, like new per monitor
group files, that provide accurate information to user space and through that
let "num_rmids" become obsolete. 

Reinette

[1] https://lore.kernel.org/all/cbe665c2-fe83-e446-1696-7115c0f9fd76@arm.com/
[2] https://lore.kernel.org/all/f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com/

