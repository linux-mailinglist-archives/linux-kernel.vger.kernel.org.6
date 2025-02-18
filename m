Return-Path: <linux-kernel+bounces-520209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC4A3A6FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05ADD188E37F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703B127FE84;
	Tue, 18 Feb 2025 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqo50yXI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C428274263;
	Tue, 18 Feb 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905743; cv=fail; b=DXpqsmW3g3BStlZ0n+/zmbff4gG9Es9VDR3jSBJOCp8qfWdM6SGCeGwGg9aIhuEusp66SvtPMwJoteP3zz0WIqtOpjclARSIxQnOB583VQR7ZJaKSBbizk0HtrXeUyrtTXr6V1xZXX1nIgYEt6J2B/DTKweC9i+P62ffhSgYxmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905743; c=relaxed/simple;
	bh=+btqpRZ67ueipb1Q7SoGG0ROF6NRftu+ttNsgKY/kGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIc5OexH6crHantlg+av1IJ4taeQOfPHnISibovaNDZBOAxZIOStLLud+ZnsYJGtU32vomWen6BypcsKA7qJvBXlb8pdAL0mqVR5jkzzWPtHI3QpRb385uJkTsJWGrNO/dKXjQoPPnH+j5NuRGITYFKZQ8ZLQy8UJqI1+USP8Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqo50yXI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739905741; x=1771441741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+btqpRZ67ueipb1Q7SoGG0ROF6NRftu+ttNsgKY/kGs=;
  b=iqo50yXIxCB26S7h3UJe9PnKNoD3hiD+a3RoTBj2/++2jkoNPoto5x+A
   pxJ46fGGC2DfojE/2Mdhb2/W3Ejuas2NJpO8rK3oLAEYwqbW9/qNeIhit
   FHKg2vqorHVsvuB8UDAxebZWd+IW8JJXU/3bJ1YTK0dFcQP0Ws7XSq90g
   JNJUOKt4Hy5xhTMyNIUxzc3rzcZcgRqrnWh1aEyl0ZmsDClcwacFDKKmW
   Oo5RFzU45XNc/MUlavT2eAG8+FQf62/EEQ3puquSfaKITWz7jegxeGvfZ
   yoVVhMvu4/kmV4974pJQEyqzsSDXddlEQTVlNLUQdjk0/RpMYAN/lbt3e
   g==;
X-CSE-ConnectionGUID: iJkSb5/HQr+WFuiSV2/akA==
X-CSE-MsgGUID: b8FUwjtqTwOA3DO4ZXvIZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="28219343"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="28219343"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 11:09:01 -0800
X-CSE-ConnectionGUID: LpmPR6/qQX+mvRun+A+R5A==
X-CSE-MsgGUID: kExMmumtSiCqtcP3zTh8UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114220418"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 11:09:00 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 11:08:59 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 11:08:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 11:08:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSkkasHIWTkCCB3rnHEMBEFC1alqsQktkzo+6cPwJmNjnuexhuHNHfKfdUDnKuJ8dLXoWtNU8t4uygKupUp2TEYLcfa5vG/ScYr4I7hV1i2Lo5YuF8fDdsHKMcsOriK4VL7xWU3f/Ye1vPZq7LpM1nuHAwK59W83L1kMWa9M/5Tl7mBisLnFwzSjF/6q/YNpz4K39jLrqt8Z/RSNUcSpwgbtyJjNBwc608YcqLuQ/n7L3TPOOIQa8bV4IjDaQWauVgrQLeRIy12Wl3UMhG5cQvrGDzolv0EvlhGhhHM2xx5Gu43V9rwIsReG+v5SCCRU8VlPOp9UA/LrgO3cvU+19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+btqpRZ67ueipb1Q7SoGG0ROF6NRftu+ttNsgKY/kGs=;
 b=E0nSvtxA2VFe1KSLi2g5ZNGYn7k51/Li/jNTgwXP9yZWnh88XQH/cDJqPbCp6XDw7ODorzuNR23Cs4ze08m06gMya9DLwtnsWYbO1he0JENiwUzzXI6gf7fjCBx/6SFnKywRJcg513V5qcckAZrLNETAqhZ0Oon8kaB3+3+/u3MD3nj2uL0K7zK/V8mpaGMvBn0gLaEk+V5bzgb4b2cXKlQpatRXRem8U09fnE5Ox/PTugFGM/q/q/qprl5wtGF5+qEMvXOfzur20VbqkIqBf/Tin3CRQdUxCK/6y3QgbLhsM6X03uVeaJeOD3UiyCymp22f1xK+0ArcBElT2xEjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 19:08:23 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 19:08:23 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Topic: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Thread-Index: AQHbbQsur7YXoEmn/USrZUfWgYnla7NEEeSAgABhEoCAAS7BgIAA1twAgADKhwCAAA0qgIAEIo4AgABpy4CAAZG4gIAAHQqAgAAKmSA=
Date: Tue, 18 Feb 2025 19:08:23 +0000
Message-ID: <SJ1PR11MB6083DDA12763F210D4378CEBFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <SJ1PR11MB608314CFF36D167483859044FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <feb03d13-e82e-422a-ba5f-ff9a937aad99@intel.com>
In-Reply-To: <feb03d13-e82e-422a-ba5f-ff9a937aad99@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: d1fb6933-d561-415a-f1d5-08dd504f9ddc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OURVZTNnUXpraUVDMTZXQ0VNZzZDbndTWkhla0I0U0EwdWFka3MyeGljZVdG?=
 =?utf-8?B?dU8yYXdLSmhuNlAvOGx6K2xzMjg5M3lucXIyTkpQZWRwZU9na0tJc3pmMXc2?=
 =?utf-8?B?TEgzU2l0R240cEJFZmh6c1VWK01OS2RPNVRlWDMxOXJBY2ljMWgwRFluSGpY?=
 =?utf-8?B?bUNoWlIxSVI2SUJ4YUtZUDd0TGhiOXJPUis4bHllUzhub0N1cE9IOStIZHJi?=
 =?utf-8?B?dGQzSStDRW53dTRQT0hsMVJMNVoza2ZvRmZBeU5vYTB1YmR4Wi9UZVNka0pt?=
 =?utf-8?B?SFU4NVV4TlpqZUx3WUNSM3FhWWdrSVBqUWJZZDI1RjI3bW5Sa1doUHVhK0U1?=
 =?utf-8?B?bGJTTmRuVXNoL0RJS3plcGVXTEdSMllEN2l6VnQ5ZGJ0bit5UDZ1emluanp4?=
 =?utf-8?B?MGwvUDlUVmtFMHV1dFFNbjhVUkdRR3R5SzZjdlk0T3JhWHVFQzFMekd5eWdV?=
 =?utf-8?B?RUc4ai9GVFFpYnRRdkhEYWZaT3hPb2pFdFJRZTQ1eXRHUlE1WlUvRFFxd3A0?=
 =?utf-8?B?dFdpWHF3RTdGZnd5UThOeW5NMjFxZllUU2RueGVOcU16VXhKVjBSaFgySGFu?=
 =?utf-8?B?LzY4TUhBWXpuNklVVXhjTHhDK1pZRHZXbWhvbGZLTEZzVTlnTEMzZ2M3dWVH?=
 =?utf-8?B?cXZxLzJ3bGJveVhJazZNYVVUMFVBbXFsOEt4Q3JkemtMZ21EZWFreGwzOTEz?=
 =?utf-8?B?a3dQUTdRUFVoQWU1ayttRHA0a0E0OVE1VkJHNHBTN3ErUEJFYWZtMXlwNmNK?=
 =?utf-8?B?dDFNeGtuajdPTjlJS2F6Q1BQZ0tlQ3RMMHJrUitqbDZVc3JIamsvZTJicHFU?=
 =?utf-8?B?aXFuMFlGcjRwbDhpcXJQNVVxd2xQZXhlZFFGYm1BOEQrSVoyNTdsU2dKbldK?=
 =?utf-8?B?S3Z0RFhaMUFOYXBVOW1Ua1BuV2RoTk0zQjNaOFpuMkxUUkEwSk9WVmJKQVEz?=
 =?utf-8?B?RUJNNGxDU2RvdUtRZEYzOW00cXFwMFhaVkdhcEpUQzFFNzVibUppREN4Z1lu?=
 =?utf-8?B?SEVHZTM3czBhb2h0cU1GazRVZHR3NTJSRjgvKzRQb3hjd0ZFSkw1SWpHUTdt?=
 =?utf-8?B?Rmg2V2Ivckp1bjIwNjY3OWpkeUlqbng1bzBzcmNzWGZ0enhadVB2T095YWpV?=
 =?utf-8?B?RUFhNTU3VEV2YVF3SllCVVFwTnI2bDllSDZxaytYYloydkxkYnNkbnoxMG9X?=
 =?utf-8?B?Q3VINUV3b3RFMzIvNWpVTDVGL3FsWUppWXhidkVQUEp1V25PS1BOY2JXVUxL?=
 =?utf-8?B?OTM5V0JVaVU0THNpRWUrd3QwbzZ2aVQxaDRNa0I5ZFppTzRERElxY0JpTGpO?=
 =?utf-8?B?Yk1DUUJPV1ZkSkRHNnJFbU1sN0R0Q3NIK3ZSZHFtd3Y0cWliM21yczJ5Mzha?=
 =?utf-8?B?YVk0K2lrMGRmdVJjbXhQTlNnZG96UnNYaWs1OFRFcHo0UEN6TUJWMytlRVFZ?=
 =?utf-8?B?RG9LaEttamg0SlhsTWRzSGRablBlMEFyeVpjcHFsZ3p0Q05kRXFGVGNRRjgv?=
 =?utf-8?B?K2U4b0t3NzZJZzYzUjNWL3RJSVlIY2paZ1RGMmlZUksrQk1XazdlVVllQjVR?=
 =?utf-8?B?cDU2eWE4NEtzTG0wcE5Wa3A4Yk9KcjJNeGNDQU52ZmF0QmF5S3ovRzNLQWY2?=
 =?utf-8?B?eTY4dnRaOXQrUlFtREdsZXdKMjZ5bUxhWlFTWkF2K0d5dTJ4bHpwanVPWWNF?=
 =?utf-8?B?VFkyWmJHbmJrOUk3UHFkdHY5VHRja3prb2N6Zmh4V2xTcTBZVTZjZzhCaXIy?=
 =?utf-8?B?M2NLTmhSNkczMnd0aExpTkd2cmFKZ0NITTRHUXVjcGJLR0d4aDlEenM3cGFJ?=
 =?utf-8?B?Tnd6bENOVCtmKzBVWXJ4ZTk4NGRvdkExZDZ3K0VJUEJaVHFPc2M0VHlwUGJ5?=
 =?utf-8?B?eFZSVWZQR0gxY2I4WGtKc3lzRmhHQW5aUnRaWjBHMXZnLzBHWXZVTENEMnZp?=
 =?utf-8?Q?6HO2wN5Gv6y43TCot1hQMc7ppSgoHKsY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T050UUFaUFdlV2lJZlp6UURhV0xYOCt3WVVPcUppekVWZzlZcy9GZk9lbSt2?=
 =?utf-8?B?NUQxVUFnUXpoZmtuVEVOZnA0aTRMQndSeDlQbnZuU3l1Tk14RjgyaDVPaE9K?=
 =?utf-8?B?M2FBVTJNT2pLdmx1dHQ4ZFhUM0t2SXpaZzVlTGFwalV6M2trUXFrN2tycWhV?=
 =?utf-8?B?TmNxMVNhenltSXNDOGh0YXFnVGhRdUk2TWZGNzBKTVUramZOUG91ZWtMR21L?=
 =?utf-8?B?TlhrRStsL2NjUkd0djB6bktKWXFHWUs3S3Z1S1JmZ1oyVTBSUXFUVm91N1NY?=
 =?utf-8?B?c1g0K2p6bTJxb3VYUXhPU1FGZHc5YTJxLzFZY1lVeUFFVWpUb1VCNDRNYlJo?=
 =?utf-8?B?aURXQUlTUWlUQm04eVcvZWdaRjNKUGlmL1Q0eW9Ca0k5WFdlcElHT3lTMlV3?=
 =?utf-8?B?d3JjbjcyYkhvVzErbXc1Vk8yd3FSMW1YWFFLRnhQV1ZaczlBT2tJSU1ZazRz?=
 =?utf-8?B?NEw5YWhpdld5VlNDd1hIa3RtTkovSzdtQkptdTd2QUZXZ0ZkdSsxUEJaLzQ0?=
 =?utf-8?B?RVQxUWlxYjk2OHFpbzNNZFBMNy90aHcrbG1YSkxEcUV4bEJXVlVKc1hFYkJP?=
 =?utf-8?B?a01PWVpNWWlZTTU5aXk4Nno3WDcwbDlqbUgvYTZjeXFlV0tvQU8zbkV5K1o3?=
 =?utf-8?B?SFFrYjdwK1cxWjBWUmNyL2hXcE1BRnh6clNaV1RkbGFFQVlxN1pVMDJsUjNh?=
 =?utf-8?B?eHV1QU1zcEVIRGQxcjNWY055SXRuYXpSVlYwd1lwUnBoRG5ES2R2OUlSSkZa?=
 =?utf-8?B?c3BQc1ZpdjNML1RGK3ZpOVFYZFZuYmI3Ukk0eU0zUXV5USthQTZsUWVzUGZO?=
 =?utf-8?B?ZDZTKzRkOEl6U0ZQWTNRQk1OZzdVMjBPSjRRNW52c3c1amFhdXV0OXZVQ25V?=
 =?utf-8?B?bnhydlgzbG1kWWJVNmN6cTRQVG5Ld3hyYnRVYkgxTGNFMHhJaVdCVWVITHI3?=
 =?utf-8?B?RktTek4rNWFuL3dIS0R4d21rd0lvV1ZRT3YxQzdBNmM3aEVMMXhqc0Zacmd2?=
 =?utf-8?B?MEdiT1NkcWxiVW5KU09vZHVBWmpSUGhaVWFESnp2dnFDWWhqSDJKd3A5QVZh?=
 =?utf-8?B?UE9yQXEzVm0yNzFoTTVIMWNGbVRzazRaS0tmL041OG5hVzRJek1iRGdLZjdw?=
 =?utf-8?B?ZTZzdTEzVW8zN2lGa0tPekFiUGlNU0MyV0ZBYTNCZTU3b2JnVi9LL3F0SytY?=
 =?utf-8?B?UldCT04ybUJtMU5PYnNuV1FCUGNoejg4by96am41OHRMT0p0N2NhMzRZSGJW?=
 =?utf-8?B?OHhKN3dnbnlvMm5RRHZhanJUZ1hLYWlQZnplQ1YzeFlKWkJDUGdQSWpXaWNi?=
 =?utf-8?B?K2RRUVZ4R0JlL1V3eGZuTldlQTh0b1M0Q1dvSzNTVzNmUnBxRjJKL3Q1NGls?=
 =?utf-8?B?UTloUWFXRTI1bWhVYnpsUzRrREJRd2liNkg5WU85WGNzbjBQU3MvS3R4N3Zw?=
 =?utf-8?B?VWVBVVFnMlB4MUNGZUpHNzB0ZzBuNW83QjFlZDBOeEhFeVh2VlhDdlhlMFUr?=
 =?utf-8?B?L1VqdHhSelUyMk9XMnpScVhVV2FGOUpaRWNqVjJvaUVTUHV2NSsyQWpyZktD?=
 =?utf-8?B?akVrbWdBTS84Y0s3NW5Bbytadjk4ZmNMdzdadCtrb2dMWmdmTGVwY09xbWNP?=
 =?utf-8?B?SDJROUJlbzUxYmo4eU9lNFNvQUMwUEZQUmZQRXVaRlJac0hoSTZPL2hPTEJR?=
 =?utf-8?B?VE1TVU5JejhaWmZSczlkcnpFRmdGQnFTQUkrMzZRYkRPRy96Z0YyYWx5VURD?=
 =?utf-8?B?T1ZjeE1jNFF1SkVNWGdpelhjUnNzMFR3TGNtZFdOUW1sT1lQeks3SmVtS3dt?=
 =?utf-8?B?Qk1Xem9BWDhwMlZ0cDdqOW96MHdVb09jRHEzZ2NUV0VqQkt3Q3FERGg4UTJu?=
 =?utf-8?B?T04wV3BNSXA0K1UyMExPa3dtR0lZTy9NV3E3TmNJWjV4YkJobjlEU0NDN28v?=
 =?utf-8?B?NkJzKzdUSWYzRHJnOVJSVnMzclF3Tk5TR25OUHNxTmRTVUlSSjdCSkhHWHM2?=
 =?utf-8?B?ZkNLSmpxZTd2cmtoV3IzSXNXcVhmbWllVDVtN1NWdWszV1RHMDhzUzl5VlFL?=
 =?utf-8?B?ZytiMENRNGhYS2dUUnNINFJNeWJxazEvSlkrazZneUt4SHE4aWRxcFk4aGY2?=
 =?utf-8?Q?WAqH9NrRiIjdEurG2z7TxH+Mx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fb6933-d561-415a-f1d5-08dd504f9ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 19:08:23.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8F4g26P91OUhQ8+TUJUMkqqJIYRR/sS4GKICQIIpfBQQbz1wm+MYA7v/GSBouHQV7OV2OJar9F2uEVORFNYzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
X-OriginatorOrg: intel.com

PiA+PiBCYXNlZCBvbiB0aGUgZGlzY3Vzc2lvbiBzbyBmYXIsIGl0IGZlbHQgbGlrZSBpdCBpcyBu
b3QgYSBncm91cCBsZXZlbA0KPiA+PiBicmVha2Rvd24uIEl0IGlzIGtpbmQgb2YgZ2xvYmFsIGxl
dmVsIGJyZWFrZG93bi4gSSBjb3VsZCBiZSB3cm9uZyBoZXJlLg0KPiA+Pg0KPiA+PiBNeSB1bmRl
cnN0YW5kaW5nIHNvIGZhciwgTVBBTSBoYXMgYSBudW1iZXIgb2YgZ2xvYmFsIGNvdW50ZXJzLiBJ
dCBjYW4gYmUNCj4gPj4gYXNzaWduZWQgdG8gYW55IGRvbWFpbiBpbiB0aGUgc3lzdGVtIGFuZCBt
b25pdG9yIGV2ZW50cy4NCj4gPj4NCj4gPj4gVGhleSBhbHNvIGhhdmUgYSB3YXkgdG8gY29uZmln
dXJlIHRoZSBldmVudHMgKHJlYWQsIHdyaXRlIG9yIGJvdGgpLg0KPiA+Pg0KPiA+PiBCb3RoIHRo
ZXNlIGZlYXR1cmUgYXJlIGlubGluZSB3aXRoIGN1cnJlbnQgcmVzY3RybCBpbXBsZW1lbnRhdGlv
biBhbmQgY2FuDQo+ID4+IGJlIGVhc2lseSBhZGFwdGVkLg0KPiA+Pg0KPiA+PiBPbmUgdGhpbmcg
SSBhbSBub3QgY2xlYXIgd2h5IE1QQU0gaW1wbGVtZW50YXRpb24gcGxhbnMgdG8gY3JlYXRlIHNl
cGFyYXRlDQo+ID4+IGZpbGVzKGR5bmFtaWNhbGx5KSBpbiAvc3lzL2ZzL3Jlc2N0cmwvaW5mby9M
M19NT04vIGRpcmVjdG9yeSB0byByZWFkIHRoZQ0KPiA+PiBldmVudHMuIFdlIGFscmVhZHkgaGF2
ZSBmaWxlcyBpbiBlYWNoIGdyb3VwIHRvIHJlYWQgdGhlIGV2ZW50cy4NCj4gPj4NCj4gPj4gIyBs
cyAtbCAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGEvbW9uX0wzXzAwLw0KPiA+PiB0b3RhbCAwDQo+
ID4+IC1yLS1yLS1yLS0uIDEgcm9vdCByb290IDAgRmViIDE3IDA4OjE2IGxsY19vY2N1cGFuY3kN
Cj4gPj4gLXItLXItLXItLS4gMSByb290IHJvb3QgMCBGZWIgMTcgMDg6MTYgbWJtX2xvY2FsX2J5
dGVzDQo+ID4+IC1yLS1yLS1yLS0uIDEgcm9vdCByb290IDAgRmViIDE3IDA4OjE2IG1ibV90b3Rh
bF9ieXRlcw0KPiA+DQo+ID4gSXQgd291bGQgYmUgbmljZSBpZiB0aGUgZmlsZW5hbWVzIGhlcmUg
cmVmbGVjdGVkIHRoZSByZWNvbmZpZ3VyZWQNCj4gPiBldmVudHMuIEZyb20gd2hhdCBJIGNhbiB0
ZWxsIG9uIEFNRCB3aXRoIEJNRUMgaXQgaXMgcG9zc2libGUgdG8gY2hhbmdlIHRoZQ0KPiA+IHVu
ZGVybHlpbmcgZXZlbnRzIHNvIHRoYXQgbG9jYWwgYi93IGlzIHJlcG9ydGVkIGluIHRoZSBtYm1f
dG90YWxfYnl0ZXMNCj4gPiBmaWxlLCBhbmQgdmljZSB2ZXJzYS4gT3IgYW4gZXZlbnQgbGlrZToN
Cj4gPg0KPiA+ICAgIDYgICAgICAgRGlydHkgVmljdGltcyBmcm9tIHRoZSBRT1MgZG9tYWluIHRv
IGFsbCB0eXBlcyBvZiBtZW1vcnkNCj4gPg0KPiA+IGlzIGNvdW50ZWQuDQo+ID4NCj4gPiBUaG91
Z2ggbWF5YmUgd2UnZCBuZWVkIHRvIGNyZWF0ZSBhIGxvdCBvZiBmaWxlbmFtZXMgZm9yIHRoZSAy
Kio2DQo+ID4gY29tYmluYXRpb25zIG9mIGJpdHMuDQo+DQo+IEluc3RlYWQgb2YgYWNjb21tb2Rh
dGluZyBhbGwgcG9zc2libGUgbmFtZXMgcmVzY3RybCBjb3VsZCBzdXBwb3J0DQo+ICJnZW5lcmlj
IiBuYW1lcyBhcyBoaW50ZWQgaW4gRGF2ZSBNYXJ0aW4ncyBwcm9wb3NhbC4NCj4NCj4gVGhlIGNv
bXBsaWNhdGlvbiB3aXRoIEJNRUMgaXMgdGhhdCB0aGVzZSBhcmUgdGhlIHVuZGVybHlpbmcNCj4g
bWJtX2xvY2FsX2J5dGVzIGFuZCBtYm1fdG90YWxfYnl0ZXMgZXZlbnRzIG9uIHdoaWNoIGNvbmZp
Z3VyYXRpb24NCj4gd2FzIGJ1aWx0LiBTcGVjaWZpY2FsbHksIGJ5IGRlZmF1bHQgYW5kIGF0IGhh
cmR3YXJlIHJlc2V0IG1ibV9sb2NhbF9ieXRlcw0KPiBjb3VudHMgZXhhY3RseSB0aGF0LiBUaGUg
ZXZlbnQgaXMgZml4ZWQgaWYgQk1FQyBpcyBub3Qgc3VwcG9ydGVkIGFuZA0KPiBjb25maWd1cmFi
bGUgaWYgaXQgaXMuDQoNCldvdWxkIGlmIGJlIHBvc3NpYmxlIHRvIHJlbmFtZSB0aGUgZmlsZXMg
aWYgdGhlIGNvbmZpZyBjaGFuZ2VkPw0KDQpJLmUuIGluaXRpYWxseSB0aGV5IGFyZSBuYW1lZCBt
Ym1fbG9jYWxfYnl0ZXMgYW5kIG1ibV90b3RhbF9ieXRlcy4NCg0KQnV0IHdoZW4gdGhlIHVzZXIg
Y2hhbmdlcyB0aGUgY29uZmlnIGZvciBtYm1fdG90YWxfYnl0ZXMgdXNpbmcgdGhlDQpCTUVDIGNv
bmZpZyBmaWxlLCB0aGF0IGZpbGUgaXMgcmVuYW1lZCBldmVyeXdoZXJlIHRvICJ1c2VyX2NvbmZp
ZzEiDQoNCi1Ub255DQo=

