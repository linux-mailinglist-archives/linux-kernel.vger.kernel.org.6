Return-Path: <linux-kernel+bounces-572070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB51AA6C626
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7FB47A65B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8422D79A;
	Fri, 21 Mar 2025 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACkFKKsz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D51F3FC8;
	Fri, 21 Mar 2025 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742597955; cv=fail; b=DKoVgQsG6l5VrlRQMcyYJKtOTCLp2+b3/3aEs416KsLs75rz5dQx9LJl+7x1gHSV0eDrtQMKtYQihhHk2eYBx1O0hyheIXMiSKithcGMIg2eVIywXCc4SbC5nk9MnQedK+Pfw3bKFMGGCsS94Vue7BKzZbMG42soVUrVbngRYjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742597955; c=relaxed/simple;
	bh=oKh/jH2A8YoedhXfKyNwXIs1UI5+krrgO5kNXE9SQaY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PodoZDaCaOJwamiAEl1lAOLb+FUajI2trkTcmZthlR2U9KIN5CmlNk3q8waELJ5LVQbGFy+VOiT/xcQBMmZgKVd9PoVsCHt4tQE7Copy+xDrybircNyvks9DO2hBW7Tfr+d3SPspsvbgRn0K0FqMnR2juQOx33QLNDT6PMPzpVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACkFKKsz; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742597954; x=1774133954;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oKh/jH2A8YoedhXfKyNwXIs1UI5+krrgO5kNXE9SQaY=;
  b=ACkFKKszIICs3gykjRQ2MMQ3nUGGIBzYpE2Bdx6d8uKil0EqMx7csR6u
   J4TDYDmJdeZbhO080WppqM1wvbARDkYwi2RmdTJQ4YHZKObW7ut3uUAKV
   Zm92ld6l1CffIyNkUzyk19Ekt4dLfRfqDed1/KVVEWfp4p25lUjL0MlYK
   0c/faJtXxxul6dYk+QNLieNPAGP/XUEiNq7kIdNdywEAyZYc0m5x1Q4+h
   hhysU1UST49SdTsOmowjPmki+LiA7vLQr0TANWcUNyDsNJXzUi1BpQLYr
   DJRCvvk5zQ9pwfe3IVxzaTz5eBg4PaH83hgmkKkPZIcTa7nlyuS/yvRlo
   A==;
X-CSE-ConnectionGUID: JNrgvNE9SsuirYfI3AtpRQ==
X-CSE-MsgGUID: iQWf/YA0TWSRhsEXn3dnxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43804985"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="43804985"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:59:13 -0700
X-CSE-ConnectionGUID: jHDnimv9Rh2wiwkYM4edqQ==
X-CSE-MsgGUID: u8+sKS+ESPeEATeO4OBzcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="123477350"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:59:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 15:59:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 15:59:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 15:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgijklCvfe9U6PmlWW5sKdhyYI//QAYYZjKfF9nNcEBcsHM9BvogYXmqLR0T3Ev1I1G2puZrVfLukIjq2GRzrqWB6ekTEkSvE6nEQpPFcHEp/x2xROACSd+VVdcGoBMvoc/mmignsMDBFSKjOv7ERVWXN1tjZF8M6H63Nl9G7bTv9CvkSyfOKEv7I960pYxkiw0K/xcaJpHnvzI7IDws+4ud45ksOBwtiCsb4f5ONGN9pHnREfvxP+7XyX8pVmvUy+xi5DE+B02RQ7zujx0M4iYj5IPsg4sea8xGvF2Xn3KS3k9I7zE76G+UBW49bWOGSqyJWOuEiiR9JCCQGVNh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBeM5GEFRW6XO/eP10UoYiaUVUS9jG0MBx9Zr4rMHUI=;
 b=EyLjZ/YrAZMrfVVZdCt766FyjNPhmB67ya3LDoYt/ozeaXTDnxlSJSKm0hbUlLDaWjYnG9zFNizb6IWoZKgsbzR3w8iebdSZaqF/d8jcZb6B87KXF8R9Aud029Pt9KPv/9FO7scybUpK3JK3cXIfqofflPCtoTKDByFQL4TNEM/umQPtQJFM+Z8sZx+/E/XUJvT9c89/qW3nFbtSNt1SDOXMgLlFf4WrxFJfbqcPq9V43Z9ojOIOsXNMEaSo4wHXwTNmn0zXJ1Xamifd+/M5MHdNI3pOKlx1BWz6FEkU+Oriu3UV3TFUIDp9jeD5N+bzVqrma1TPGBZDuNmcres+/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 22:58:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:58:42 +0000
Message-ID: <65124831-2c00-4ab7-91db-f8e348686d7d@intel.com>
Date: Fri, 21 Mar 2025 15:58:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] x86/resctrl: Introduce interface to display
 io_alloc CBMs
To: Babu Moger <babu.moger@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <thuth@redhat.com>, <rostedt@goodmis.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<jpoimboe@kernel.org>, <daniel.sneddon@linux.intel.com>,
	<thomas.lendacky@amd.com>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <seanjc@google.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <tan.shaopeng@fujitsu.com>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <peternewman@google.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <corbet@lwn.net>
References: <cover.1738272037.git.babu.moger@amd.com>
 <873d649aa0e5f6c24b6340cdcf9ac96ea57d7331.1738272037.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <873d649aa0e5f6c24b6340cdcf9ac96ea57d7331.1738272037.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c4c3e3-347d-447e-3844-08dd68cbed27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTJ2dEJTMU9TN3FicUFDa1JOVHZ0VXB5QjhGd0xBSkZMamIrL2Y0ODdsdm5R?=
 =?utf-8?B?enV1VDY4cUN6a2srelVoZlFKUTBRUk9wRDljbnlRQXlTRktnbTROL0ZmMWRP?=
 =?utf-8?B?TldVVzFxczgxSURRSmVyMnIxVmlyWTFBUU9lT3RWUEdFTlJiSWcrb2hESWpK?=
 =?utf-8?B?ZFNOK3MxYWRBY3RIS3lFNDRUeUtsZDN1UFZxUGFvQ0F0U21SQjNiQTFsTkdH?=
 =?utf-8?B?azQwQko2VUh5NmZSa1Nrd2hpSzZoOVcydVZwMHp4VlBEekhOdGkxd21wOFhr?=
 =?utf-8?B?SkxwRG5WSzdrVlFqNUNacSt1SUhwUEpZYjlUd1BZVVYyU3FmeGVzbUY0S2ZI?=
 =?utf-8?B?YjNubnJwMEs1MXQvcHhQS2NUWndWMTl4Z0VYS2EwUHZWVXBwMWQ1cTdZMzNm?=
 =?utf-8?B?ZTk3MC9ud0dtMnAvRU95dWFWVHhETlFhNHlRUXc4aXNkcXUxUFpzS2IzbGdM?=
 =?utf-8?B?dFd3bUpaOGI3WTBYK2VWOHBEZm8rN2ZKc0QrV1d1Z0hWcDYvdXNobHYvUFNa?=
 =?utf-8?B?VG9yY2x4Z2pvbmkxUCtCVHVRa1EzOEV2SGVwWlRLYmFjZzMwZ01pRWVTcVFq?=
 =?utf-8?B?ZmVQdTRUQXJpQUZINlh6T1IrYkNKYWpHZ0FYeHhVSnQ0S1RCRmNtWDVlRGQr?=
 =?utf-8?B?YnhaejZXL3FsVDdwRDBDRC9wOHZaeXp6Vjk5eDdKVXJSUWJJMngvMU9VYXEx?=
 =?utf-8?B?WHJXTk1aZElPb044R1Q4YnZLVFpXUnNFaUdPbElXQXZ4UGRrY2RoK2VWUEtE?=
 =?utf-8?B?U1p5VStlL2NuZjNZL216SHYrY2pkbEFYeHVNUzg4bi9Kak9EZ3BSdVFyeVVX?=
 =?utf-8?B?MVlua3ZHT21ubjdtckFSM2JSSmlnUnRmOEh5WmxWZEF1dmEybHV2eXZrVFo2?=
 =?utf-8?B?SE5LbGs2QzhXOGlCK2IxdXVRU2F6N0wvR05icUpzNXExSXQ2and6NHBhV2Jo?=
 =?utf-8?B?SEJIN0hpRWlRaGhEYUtvaGZjVExpcmxsUWVqRnFaL0pFdlRhanBnVDNaR1I4?=
 =?utf-8?B?NWdUS2hja1BkQ3RDRWkveDJwVllSNElaS2FrK1c0NFJTaVdiMCtzWnBYZCtI?=
 =?utf-8?B?RkJHdE5tNElqWWxXb3orUnRZRmVKS0xia3JkdjlMcm1WRG9kR2Y1ZjZDRTJk?=
 =?utf-8?B?cUZDVkEwcVdBSk45K0FWWVl5aUpFU3ZYU0ZTYkVRaHMwUXl6aVh6U2Z2bXli?=
 =?utf-8?B?T01CYmw4dFoyWFJCRTlDUElneGlFUHY4Y1VQZlZMTk5jUERtSXl1ZEhTblVN?=
 =?utf-8?B?S2VYNVZwY3Ayb0JzWTR3U3hhYUtDdERKR1pJSGUxbGZ0ekR4czFQYk4rbjRx?=
 =?utf-8?B?bUs4MzFmOE13Z2NWQmdQOVhRY2MzZ1RLSEQ2bDlGSkhYUEhIaHdiM082c1My?=
 =?utf-8?B?dkE0LzNvNDhYWW1xY2xiVTYxempJU1NmUFJOYkZyN1VSbWlnbWprK1hlQmNy?=
 =?utf-8?B?ejJIelJsWTlNODdySkVJb2Y3RWJ5MEZHd1Btei9rMGI5RTFQQ25FaExIVExi?=
 =?utf-8?B?TXkycFphLzRpZTNuaFBaMFFaM1Q0Znd5VlMwWHZPd2dXSktIbkdJSVg0d3FG?=
 =?utf-8?B?WFBsZDIwQ29BM3IxVmxEbDlKQ0lESmNyZWd0Yk1rZEJIZWRFNSt4N1ZvTUxu?=
 =?utf-8?B?cEV5Y21KaEh5MDNZM3JqVlZaQnQyWlJOUDhjdTR3ZkdlMktyNk4wRE1yVDBG?=
 =?utf-8?B?d2RLY0ZReFJKTERLTFBKbkpzRU9sRS9QNWRud3JlM3RCS1kxV3R4OGdWWmRY?=
 =?utf-8?B?bXRWWVNLUDZUU1ZMM040bXBqaTdtRmZBMWxWYW1zUW9mZFMwc3AzUUw5QTdS?=
 =?utf-8?B?YjljTVd4OWRUbm8zTVhEcDlURmEwWmdtbmlUd0RObHltTUFIbFZRdzBJKzlk?=
 =?utf-8?Q?FAFUoZoW4EISZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnZLbmxGNjNremJLNmxsc2l5aHVJWU9rY3RWUjltUEwxbGhjSFBqNHAzb1h6?=
 =?utf-8?B?eDNvcTdyVHVlM3VNNnRQL3V3RDNrNE91TUl0RVlONkZ2UWJ5N1F1SHJ4bDhu?=
 =?utf-8?B?QllPbWs3Z2dKVTlqMzJHbFBoN2JXRklWMm5ZbXdMeUxjREVkR3R0dUhtV0o2?=
 =?utf-8?B?MzlUeTVJQ2xHV3I1clc3SmdpUG1sTTBSWFZvbGpiN0Z3N3lFSy94eWk2SVZs?=
 =?utf-8?B?aGdKUm9lMENiK2UvTHhlTDZBZ1pBc1V5VzQ1emx2Y3RLcVE1bk5Sd1R0TGl1?=
 =?utf-8?B?SHIvVTVqYWZCelFlbUVLL1dIRktKKzIvUFdobGFHdzR5eENEcDk2STNRM1JK?=
 =?utf-8?B?ZUJCRkFUOHI1OWdiaUpYT3VORk1US0VyMjQ0WHA5TDc1QWJQRmQ0K1BOcFQz?=
 =?utf-8?B?WmVpdmdGMU1EMUd2YnFpdEdtTktXMmxScVNVSWJOdllFTDZIbkw0ZTBYZG1Q?=
 =?utf-8?B?MzlaaUJQd084NWJzOTBwS1YwaGNaK1dGSlVVRUNhRXo0K1BVakZGd3VDSTA0?=
 =?utf-8?B?bjBFenVTVFRsRk9CSlc1eExyU05tNVRrUzVVcFlta2NZUWJ0QWdwcC9mQWZP?=
 =?utf-8?B?NmFCS1ZnOXZzUGlqNzlBelFYQTRvemNlSE1TQ0xKOFRSU0dlYW1HYjBiTUtx?=
 =?utf-8?B?WEVqOHp5UklQZ0orNGtzbnN5ODJaelF6UUg5RUt6WEpiUzVGd2JPNlhEODNj?=
 =?utf-8?B?NjRZT3hwNkd3MmZySjlnRWhwT2lYTEFqeGt0c3BDRGJGRlNMUmU0Zjk5RTNx?=
 =?utf-8?B?RGRnT2xURDRsMkMyRFFsYnpyL3pxV1JySkIvNGk5M2JEREJmNHJSQ0lRYzNJ?=
 =?utf-8?B?R1BPNUFYNU1TNGpsMDdGU3N3Ny9KeXJGNHVtZW1XSUFSU2N2MVE4NXB3SFRw?=
 =?utf-8?B?WUM4VU9ZenNSTURmZkpueHJoTUR1VFZGcnczSUdZaU9kK1NlRE01MGpZMk16?=
 =?utf-8?B?WE1pOWE2NUxFTEhGYU9VUUxpVituUU9meVpwbk1RVmZnNHJ4YW50L1pybVZV?=
 =?utf-8?B?MjdoZmxLeVV4N0p5eWw5b2RtRFRMUjNYUW1HUlZrSXVUa1NOYjM2S1l2WWlE?=
 =?utf-8?B?SDBHc3JNVUVQNFMwS3d4Q0VpWHVmc3Q5K1JmZjkzSTh6Um9CNU9NbU4rYnlV?=
 =?utf-8?B?bkJHV2IwSDhtNDV4K0x5enFCekYrNG1SZlZpL1ZlOW14WGhheG12SlIzaDJM?=
 =?utf-8?B?cXFwQktJdzFzRk4vMUtucHJRZUVLRVpzVTVrUStRbUtaTjd4Tkh0SHJicXVE?=
 =?utf-8?B?dEs4bUNzYlRQNStpbEQ1L2x0NWNwYkViWnRpbUcyc25vaklWUGpqMHgxMC8y?=
 =?utf-8?B?Sm56dlcvWXVRMmVId2R5ZFpXbXhrRDBpajdXb1VTU0l4UlRFVU5ENDg5Ukww?=
 =?utf-8?B?bW1qeGpBcFdzRVVJekNYb1l6TDNPU25Hckw2UXRRVnY1blhhTGJzSXU1S2V1?=
 =?utf-8?B?U1dGd2FDYU51QmZ4QUhoWGN1NEswSUZaSVhidzBKSklPNlJjeStnQ3pXdEgr?=
 =?utf-8?B?TExwc3BnMC90Kzh3Y0xGY1VoNTFaeDFhQUVSNVJvTElub25PY0VUd21PNU9V?=
 =?utf-8?B?N0ZMVDYrbSswRWV1ZU1Qa1F1ZmIvWnNzS1BKQkFUcWt5OXI0WjFoQ1Niek0y?=
 =?utf-8?B?UE8zbTU1ekVxczMzRitOT0xhczhuMUx0c3lsZW5sc2lpRkpJajdpWEI1a3Mz?=
 =?utf-8?B?bnJLTlQxYm5waTllSUlGM2RJYzFDbWdueVJUa0xXTHRuVUJjM0I3QzhUUUUr?=
 =?utf-8?B?bk80dm1hK2xtcWVWeE5ZYkJjTm0wVERkRUl4VVg3NGUwT1l1dmdhc0ZGdjdq?=
 =?utf-8?B?YWc4dVEwRzlWaHlEclhQRXQrTTZ4allFdlZ1bW5HUnhYbm16MDRuM3laY3hh?=
 =?utf-8?B?ZCtrc2FIZEV1NVJOcHhuRm8rakVHZ0FOb3MyQUVlOStCdlBKckJ5TzdKaGl1?=
 =?utf-8?B?K0dnL0hCUW9EY2JCVGhCMUpHQThlZzJibXhCenh5WllLS3VDN0N5TGczSGtF?=
 =?utf-8?B?YzJHbFh2T3dqcHFvd0pwKzBqR1JIM0sybERqY1NVZWZRVllxdmtqY1o2Ym1t?=
 =?utf-8?B?dGdpSll1VnJ6RHJVdzRuRUwwWVJDTUs1WTZxRE9kYXNNZjlwSytGOVAxcDVo?=
 =?utf-8?B?SXc3RDY1QWJWYjZTN0V3cGwvWnErZW54SkNNWGtiVHFFQTBiejBHcUgzeXVM?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c4c3e3-347d-447e-3844-08dd68cbed27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:58:42.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR/YEmhynC7DIU/atMc4KzKUbDo2+zJBU0YDrA90KueyavXk81PKUXw1ojNelUq8cDYUjacGwE/0CBlSIagCe01QxIzo1tibth0w9G9dbBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-OriginatorOrg: intel.com

Hi Babu,

On 1/30/25 1:20 PM, Babu Moger wrote:
> The io_alloc feature in resctrl enables system software to configure
> the portion of the L3 cache allocated for I/O traffic.
> 
> Add the interface to display CBMs (Capacity Bit Mask) of io_alloc
> feature.
> 
> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
> which corresponds to CDP_CODE. Add a check for the CDP resource type.

It is not obvious to me what is meant with "highest CLOSID
which corresponds to CDP_CODE" ... how about "highest CLOSID used by
a L3CODE resource"?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v3: Minor changes due to changes in resctrl_arch_get_io_alloc_enabled()
>     and resctrl_io_alloc_closid_get().
>     Added the check to verify CDP resource type.
>     Updated the commit log.
> 
> v2: Fixed to display only on L3 resources.
>     Added the locks while processing.
>     Rename the displat to io_alloc_cbm (from sdciae_cmd).
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  2 ++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 38 +++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 88bc95c14ea8..030f738dea8d 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -311,6 +311,8 @@ static void rdt_set_io_alloc_capable(struct rdt_resource *r)
>  	r->cache.io_alloc_capable = true;
>  	resctrl_file_fflags_init("io_alloc",
>  				 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
> +	resctrl_file_fflags_init("io_alloc_cbm",
> +				 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
>  }
>  
>  static void rdt_get_cdp_l3_config(void)
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 536351159cc2..d272dea43924 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -444,7 +444,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>  	return hw_dom->ctrl_val[idx];
>  }
>  
> -static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
>  {
>  	struct rdt_resource *r = schema->res;
>  	struct rdt_ctrl_domain *dom;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 61bc609e932b..07cf8409174d 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -668,4 +668,5 @@ void resctrl_file_fflags_init(const char *config, unsigned long fflags);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> +void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid);
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 37295dd14abe..81b9d8c5dabf 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1967,6 +1967,38 @@ static ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>  	return ret ?: nbytes;
>  }
>  
> +static int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of,
> +				     struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +	u32 io_alloc_closid;
> +	int ret = 0;
> +
> +	if (!r->cache.io_alloc_capable || s->conf_type == CDP_DATA) {
> +		rdt_last_cmd_puts("io_alloc feature is not supported on the resource\n");

rdt_last_cmd_puts() has to be called with rdtgroup_mutex held, also clear it before use.

> +		return -EINVAL;

How about ENODEV?

> +	}
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
> +		rdt_last_cmd_puts("io_alloc feature is not enabled\n");
> +		ret = -EINVAL;
> +		goto cbm_show_out;
> +	}
> +
> +	io_alloc_closid = resctrl_io_alloc_closid_get(r, s);
> +
> +	show_doms(seq, s, io_alloc_closid);
> +
> +cbm_show_out:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return ret;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -2126,6 +2158,12 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= resctrl_io_alloc_show,
>  		.write		= resctrl_io_alloc_write,
>  	},
> +	{
> +		.name		= "io_alloc_cbm",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_io_alloc_cbm_show,
> +	},
>  	{
>  		.name		= "mba_MBps_event",
>  		.mode		= 0644,

Reinette

