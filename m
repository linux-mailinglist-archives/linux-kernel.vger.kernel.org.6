Return-Path: <linux-kernel+bounces-400796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D49C127C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9073288543
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D91F4276;
	Thu,  7 Nov 2024 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vm1/U7aA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14A1EC015
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022214; cv=fail; b=S3krTxvug8zrTSgbiFsR/do29u7gDnhPm9U60+aKxSyUC1lKSjok+IEGsjKIMuVOarR0Tl3triA6lMnjKw1ZLTNBZdpZo1UtS2Yb3U3z+FvESFWQa2MlqOsh5VE4/JWMxMYYdYn4xmfL1cEMcwglC7pSu0ZVDciIwpLKyP+sM74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022214; c=relaxed/simple;
	bh=m4iTVV9d6lHlBaOTAUVYOI+7KKoN/dixMdjz4Y/ywQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e3E47TZY2c2OgaaqhZiEkSsK+bpsY8VZN3c67YVJ/TyncbrOfQTGZaRcB6Yo1y/W3+RPph/fM8FiyFFqQAd95pt1K0KXfJnOtFpxHmxt5lwj816vQolR8I54EdOdK8AkVReRLwCj2SfhWbnZkDSXmY0pPJstq06RrBaQhQta5SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vm1/U7aA; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731022212; x=1762558212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m4iTVV9d6lHlBaOTAUVYOI+7KKoN/dixMdjz4Y/ywQU=;
  b=Vm1/U7aA5SnlC7puBwluTrIYG5tnt7tnTsmbUqlZ3Z28qC/mq9BYuraI
   qeOwqUXUgRdMUi/O4WlDLupWXWu63waoL4PNKXSHVVD7koFkKCCO7rE5s
   ePJoVYNqEKx64RbmsGjynS2ppiBJdIdPnAC12qji/qqQYyIrMHM2Kgdv+
   DDX5AO4ngO2r7RdSPZZHAEr3fOWjdtMN2klAwzI4QF7Rb81m7cH3ICtAW
   ixrZpDXCVi1PUKmvtGp1BDkUdwR/KgMz+2mBX/BUiowsCZ8plIv+sa05o
   UAfdw7nRewiQ2Lu1+tsFq0bheT3NxzqIbERrs5+DFASCg+o67zWdy/tvo
   Q==;
X-CSE-ConnectionGUID: 0VihEc3LSxKZaMb5Bh3xcg==
X-CSE-MsgGUID: CLX8/LdlSDi3HMlXJY5xyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30667637"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30667637"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 15:30:12 -0800
X-CSE-ConnectionGUID: FGhTilt2QV+lSJMzTzo6ww==
X-CSE-MsgGUID: JuVAd6ebTYyeTAIJB1oB/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85477366"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 15:30:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 15:30:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 15:30:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 15:30:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqY/vQ/fLJ8cDg7CFVrtD0KrNOLV/L62dTB3FXtZH3DQmHpNmZcyE2k59sdOJFMj5sMENgbT7eXPgmYczXwbHdFIRouJe/N8IMJ/SbMY8lp9Zluxs92UOh1nhwwrbYjdmr+hzdKqUs528RdjCoTwqwbvelpiCH7/H291aIxUNOXxsNNYvD5Q20t3imRiRIJwOPF2Cm130dG7G8VTH7kviKbLVdp4C5a8KXMhZQg/aMDIwtUH79m9HcBnXkkmp744jfAB7SuGJqIiKpL4lx6WQFA5EUkbrfodbGEi2WJw1HowZZ2Avh72XiAzoytj/z/a7yUXe1lGCAungGeHqEH4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4iTVV9d6lHlBaOTAUVYOI+7KKoN/dixMdjz4Y/ywQU=;
 b=qmNs8pWdv6uVsgEdz3H6KbBu/TVLw2dqhf8OWY0MJIvPPPiC1tVqTnGzUCY6o4E0PW5a3gr4/WPSR196TwDe30b0roiJefsdgmf0NjBHM+uU70bpFCkUYKfgeKkDWqNbjSCFDcBwCvt7Qo/ssQvu7B189olZgmfnIWYf8t7izODA/gowvfTpmDZYX3Nlb+LhWrsI9VCJ5+sjCn+KgtzyA+QPq8nW7lTCvTK9XLE3HkZEmnxhhV/UJyJWVZrn+b57RTUwEqJ6YeMqmVhEi6DMyhl0ekWnnXcdn2pDtzdqjGLN02Lua2iR6X9bj6iC58jFmfuftxgnboQ3xhBjc7Ag4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 23:30:08 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 23:30:06 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Peter Newman
	<peternewman@google.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Eranian,
 Stephane" <eranian@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"nert.pinx@gmail.com" <nert.pinx@gmail.com>, "tan.shaopeng@fujitsu.com"
	<tan.shaopeng@fujitsu.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Topic: [PATCH v2 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Index: AQHbMGKkDArILeDR9kmWcus3jnj4urKrAt0AgAClQQCAADkYgIAAUM1rgAAapWCAABQ3gIAAAR6AgAALB4CAAAqFUA==
Date: Thu, 7 Nov 2024 23:30:06 +0000
Message-ID: <SJ1PR11MB6083D9983DFD226A1FE826ABFC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <ZyzxbhHQptbktfGH@agluck-desk3>
 <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
 <IA1PR11MB6076F9F222A98125974C5CBCFC5C2@IA1PR11MB6076.namprd11.prod.outlook.com>
 <c4ced27a-b3e9-4727-9c39-7d1fd0cb0dd2@intel.com>
 <SJ1PR11MB6083BA9392D4B176FA2DA170FC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a593dd7b-f502-449f-a866-5e6494de506f@intel.com>
In-Reply-To: <a593dd7b-f502-449f-a866-5e6494de506f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW6PR11MB8309:EE_
x-ms-office365-filtering-correlation-id: 6db4c2ec-9f73-479b-259f-08dcff841cf4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0NsUDV6UWVFbXVXYlJkSnZvejlCK3ovWCtyTDdnT0FzZ01ENS9CYzh2UWxs?=
 =?utf-8?B?ZEZKWGxFWk1FWTZ4TEdVL0Z5WlZYSjRvZmkyYjdJbFhRV1dSTkRZL0dvTDEy?=
 =?utf-8?B?RGlxT1c2QWY0NHZnbEFBOU90dTVGT1pNbXcwVElFdjgzS0F6VHFkWGYzTVFD?=
 =?utf-8?B?elpNODNzeUxxSHVKT2VTbUladWRrTmNaNGpIaHVXNTl0dTF1SG9uZ29sTWsz?=
 =?utf-8?B?WTIvVHRvZzYwVlVHRlFYSjltVm9BWXBKQ0MzbkxUSnBMbkZ3VVU4WVhoTVpN?=
 =?utf-8?B?aFVqanRhLy9zQVVNMC9pMEJYY3c3R3E4S0FFRlF0S1k5dTdDVFppL1hGYTJz?=
 =?utf-8?B?dUcvSHRpd2hNWXRaL2JqS2lDeERubzhweStoMU5rMHUxTmQxYllRM01qcjd1?=
 =?utf-8?B?ZlozV1NCV2kxeHNmT2ZDRTRIWHdLNlBjbjIrS0hRU2JyQ0JodFRxaFJGUzUr?=
 =?utf-8?B?djlHVytlbUd0NnJjRW00UVlYYS9ETDV5RU5KNlJzT1BpUHBlMHJlaUlibUo3?=
 =?utf-8?B?UUdIcDgwRmtJUHhYMW9HUy9aVGI3ZVYvNS81L2JMSEk1VFdTdlNkNzRCSFZ5?=
 =?utf-8?B?QTFKMGxtem5uT3lycVJvNDhhUWY2NWdiNlhKT1JZWFByMzRxeitOdk1HbEJq?=
 =?utf-8?B?MUJqMDFaeXR2TEQ0bStuZXU2cHlQVStmWnpYdEVKQXpTTlBkakRYWGliU2hL?=
 =?utf-8?B?aElKUVoxSGwvSy9yUm5SZmhIdGpodXlTQUM1U3RMMHVOU2pTWXN2b2J3YVNK?=
 =?utf-8?B?bTA1VDZVRmV3bGxqVmVTckhpeG5adW5BY0lPRTJSSFNDVkd6VzE0eDhtRy80?=
 =?utf-8?B?WDVGbFZ3RVNjS2FKNWNsYjZBeEdxekdMV2ZaaDR4cXZGbWg5RVJRNlk3cUFZ?=
 =?utf-8?B?R0JCM09pOWdBMEtFZVVTZjNCeHAyYzdNUUNKSm1yOXQvbCs4NjZ1eGdrVHBD?=
 =?utf-8?B?d0kzb1NwdUtnV0RyaWdFdVUrVnhWSXVQWVJ4TWY5YnRtUk4xQkZIYk5yMmFI?=
 =?utf-8?B?WVVXZ1JSdE5xTWNlUWkvVVFtcTUrQ3pKVWhtdEFWUTRiVXdBeWlFemlmU05F?=
 =?utf-8?B?OHdlTFlKVTQ0eDVWUUpNTXAva1EvL1lEMFJkeFNKQ0pwUitZWHRiQnZ5c0ls?=
 =?utf-8?B?bENvb2NYU29YdVF2TlFNQytXSHlqYkptVE9KdlNCcDJEajNLVzh0UDVrZzc0?=
 =?utf-8?B?MEhTRkVwZ0FHWG5HdWpSa3NlU2s1Unp3bjVJcnRHM1IzalFNMEh0b0czbjRa?=
 =?utf-8?B?RHhKU2NETDNGMGJKS05EMGJUdU8xRmhqTlNaelY1bGs4NkdqVVo4ODVSVFQy?=
 =?utf-8?B?WG5JLzVjdzBMWWs0b01CaHVEZnNDTWJMRmpPRzY0SUZxZktUU0VkbEVKNTE1?=
 =?utf-8?B?cHlVOHFwallaakN1bVJjZWRMT2RhVTRWY2w1MUJwdnJldkcwamJ4eDVSVk44?=
 =?utf-8?B?Wjltb0xJOHNwaHVOYUpHTFhmbHJ1S3JDU3pJVk9taHBsZUUvZ1Yrdm1qa2pv?=
 =?utf-8?B?R3gvT1lTOTQzczZRYmZIWXlIN01QY0p3Q1N1enRLRDMzTmNERUQzN3VndWVt?=
 =?utf-8?B?YUIrcnRhMXd5czd6M05KYmhUZmU5L3Z3RjVBbGVqazRwUmdvOHplRjhUT2FZ?=
 =?utf-8?B?blRDOWFBMlNFVmpmVm1mRksxYldkeUdLZFhCNVo1aTZYYWhhZWlBdmMrQWdV?=
 =?utf-8?B?TGx3aXFDb0NWS09kV3J4M0xmTlhLS0hqYzRRNHFHb2l3MVMxeW1vaDRreWt5?=
 =?utf-8?B?RE8xZXB6Y3VsekhST3d0bGprRTFGZjcxRFpkSFNDS2RDRjJ2YU5aUFRLQzBJ?=
 =?utf-8?B?WTN0VFR1dzhMUDhyZ20rb1hnVzRZM0RhMmsyeGRuU1crc2pRR25RK0ZjQTRk?=
 =?utf-8?Q?LM4iqVG1l2HGv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXIzOXE4TzV4TU1WaTRxd09oYmxLTmJ1dEpGT2ZEcjNKTG44b255cG9LcDNP?=
 =?utf-8?B?YzIyeXZXd0R2ZzZhTFlZdmpwRzdaV0YvbE5TamsxcDUxYWZYS1FUL3VjaFdO?=
 =?utf-8?B?M3RCQ3pPakNPa0hYOWpwZUlMcENMNHhGUGNQYzk3QkVlMWxYcWlzVXRTSWJx?=
 =?utf-8?B?c3kzQWM5K3VVSXpINENqd0JqYVd5Y1VKZ1FnQ3FaMitNSE5HQml5WWxVTDE3?=
 =?utf-8?B?YWw2b2hXNGNKQk1mY01GSEhvUEoxYjd3aC9DbzUrSlQ1M0hORE8zaE0zOUlx?=
 =?utf-8?B?N01SUDAzcmFZTWZQK0NqSlFIMjRuSTFQR2tGWWczTlBSNi9GS2RCSXhSenFZ?=
 =?utf-8?B?TEc0N0w4ZzJVY3JnN3Y4bTNhMThib0d2SEMwdGkxNjRtMnNPVzBHTEFMZ21Y?=
 =?utf-8?B?UmNaMFFwRmY2SGkyZzY1TlVPWm5weVNvakNxT2Z5d1F1RGtTSmMwM1VFK0JP?=
 =?utf-8?B?TmtYVGhyKzM5N25jN2lQRDdnbkhRaVZ2TDJNME5JWlliUFQrL1lJVGRaYWt0?=
 =?utf-8?B?SE44RnlFdHNSSkxEY2JWZGI5ODJyVDB6dS96ZHc3RzVwWXdERkNNNjdzbXVK?=
 =?utf-8?B?TEI2S0o2cFB6dUpOUDU5bGpDdnFwVUVCcE85NktXYU9zcHdKVFNLTmxiWEI4?=
 =?utf-8?B?aTlQTXVPZTR3NHcvY1U2Ty91ZDFxZVdlYWNmUDlhRm5VdWJGUHQ3U1hqUnMr?=
 =?utf-8?B?RFpuN2Q3dW1raFdMV0UwKys4NE84ekdEbGhWM2tJemFnRDI0K1JtMlYza0g3?=
 =?utf-8?B?MUJrUDhVNlE5bzVreHEzMHhTMUQwbkw3YUh2MXlESUl6U25rYVVpMTUrMzU2?=
 =?utf-8?B?ZGpiMWxETmpIQS8rNE9pUUJISDJEUWsrTlhDQjFURVhrY1RReUNrVkFxOGps?=
 =?utf-8?B?TU9rZ0ZwU0x1T1VjdVNzNjlEbTJaeklyNHNOb1huQ1VtNUZMbEZCUHIxR2Rv?=
 =?utf-8?B?R1RMVVFMaEVLbU1WVXBxVzNjdDJSZ0VyMUpROFkyTlhiNElqVWE5WnVGUENk?=
 =?utf-8?B?WkpaZENTbFRtTjdEalhlOU5aVVpyVTkwNlZOTmJ1cktxRnA4NDZ5U2VJYmVK?=
 =?utf-8?B?ditOVENxVXc3Vi9LdzVEV3A4czNMQzFaRDhHbGRqVHUwWHFRU1NYL1M2NHor?=
 =?utf-8?B?N1hpdlYraHVYTXpwYmcwN3BKcWNGN2c5ZlBMTnBETWpBLzJBelNYOWYvNzNp?=
 =?utf-8?B?ejBDS0NvdTVVN2I1ck9nSzZmbXAxZ253bFh2Rk5LZVRGVTc0c05lcy84RXZy?=
 =?utf-8?B?cWNQQ2ExakJleHRMZmZjZ1V2dkVhRUpodlR0MitBNEdrUS9XNENUK3BYOVRK?=
 =?utf-8?B?aVJVTHdPNlBZdUY5bWFrOTdSRW1MbkdYMzZFYkk3ZVY5bVNRWUg1RWNiZmhE?=
 =?utf-8?B?VnA1Y0RzaXgzYXVZV0xrNVY2NzFOZWVrNStpMWJDbEJZMUhIMTdqZEs3S2Vx?=
 =?utf-8?B?SER4dEQ4VnRXUmgyNzdGYW9Ba09BcDMyYTV2L1dFcC9xTHA2Vk5zZDQ5d2Ux?=
 =?utf-8?B?RnBBYWVtY0ZmNkdhNTJlSHVFQmF3Z3JrVXArSjJYM3I3c0NTaExIbGpWUWMy?=
 =?utf-8?B?VGRVS25SRHNXZTBybVBreXY2by9SZnZvOHBsNnZ4TVFkVkFMbWVJa25lMTBn?=
 =?utf-8?B?UFZnek5abTFEMlBWRGkyNHd3UFlob1M1YXJHY2RtSEx6Vjc3WDMxRmZJRmxV?=
 =?utf-8?B?ZnZUWFc4Mnozd3JQUHdGT2pobVNBdTRKWkNpOERrZXhVTUxnZEFqbU1xUU9B?=
 =?utf-8?B?SFRtdkF0T000U0g4Q1hyQmFTUzJ1REtBc0FheU9KbWo2Mjh3T1oxQ0hMSms2?=
 =?utf-8?B?TldOLzcyeDhSRXFGM1JZNDZZejY2amU3OVJKUEJzTFZkYnpOQmx1cWZ4bDNp?=
 =?utf-8?B?RXlHU2dBK0RLVjVyOC9XL2R6LzA0Z2dQZmdxd08zZlF1TnNGYmpHbGVXaUll?=
 =?utf-8?B?aTBSeDBJMC9EeWdPb3BoNjZZMDBlZmVoakxMRHdNR05OQTRYYWdmcEhvZkls?=
 =?utf-8?B?UGhnelVreGFRMW1IdWxaemU4cElQSkdSdktDa2tsQ2U3THN6SkN0dXZ1YkxL?=
 =?utf-8?B?dGVUNllTWW5WOWdCU1U2dlZsSmVyTk5OK001UFJPY3pJRHoySU9MZzRURWhI?=
 =?utf-8?Q?sWlSHFIJ3fgCZim/Dr3U613IZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db4c2ec-9f73-479b-259f-08dcff841cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 23:30:06.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hX740dlhk4cqmyCwpUazvY6sNAN4unSYBXd6L2ge59S6vqAE/WfiRdnUiGBwSt3M/sVdCvssVxzaqrswpBzGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8309
X-OriginatorOrg: intel.com

PiA+IEUuZy4gcmVhZCBhIGNvdW50ZXI6DQo+ID4NCj4gPiAkIGNhdCBtYm1fbG9jYWxfYnl0ZXMN
Cj4gPiAxMjM0NTY3ODkNCj4gPg0KPiA+IEgvdyBjb3VudGVyIGZvciB0aGlzIGV2ZW50L2dyb3Vw
IGFzc2lnbmVkIGVsc2V3aGVyZS4NCj4gPg0KPiA+IEgvdyBjb3VudGVyIGFzc2lnbmVkIGJhY2sg
dG8gdGhpcyBldmVudC9ncm91cA0KPiA+DQo+ID4gJCBjYXQgbWJtX2xvY2FsX2J5dGVzDQo+ID4g
MjM0NTYNCj4gPg0KPiA+IEJhbmR3aWR0aCBjYWxjdWxhdGlvbiBzZWVzIHRyYWZmaWMgYW1vdW50
Og0KPiA+ICAgICAgKDIzNDU2IC0gMTIzNDU2Nzg5KSA9IC0xMjM0MzMzMzMNCj4gPiBPb3BzLiBO
ZWdhdGl2ZSENCj4NCj4gQXMgSSB1bmRlcnN0YW5kIHRoaXMgaXMgYWxyZWFkeSBhbiBpc3N1ZSB0
b2RheSBvbiBBTUQgc3lzdGVtcyB3aXRob3V0IGFzc2lnbmFibGUgY291bnRlcnMNCj4gdGhhdCBt
YXkgcnVuIG91dCBvZiBjb3VudGVycy4gT24gdGhlc2Ugc3lzdGVtcywgYW55IFJNSUQgdGhhdCBp
cyBubyBsb25nZXIgYmVpbmcgdHJhY2tlZCB3aWxsDQo+IGJlIHJlc2V0IHRvIHplcm8uIFsxXQ0K
DQpNeSB1bmRlcnN0YW5kaW5nIHRvby4NCg0KPiBUaGUgc3VwcG9ydCBmb3IgYXNzaWduYWJsZSBj
b3VudGVycyBnaXZlIHVzZXIgc3BhY2UgY29udHJvbCBvdmVyIHRoaXMgdW5leHBlY3RlZCByZXNl
dCBvZg0KPiBjb3VudGVycy4NCj4NCj4gVGhlIHNjZW5hcmlvIHlvdSBwcmVzZW50IHNlZW0gdG8g
ZGVtb25zdHJhdGUgaG93IHR3byBpbmRlcGVuZGVudCB1c2VyIHNwYWNlIHN5c3RlbXMNCj4gY2Fu
IHRyYW1wbGUgb24gZWFjaCBvdGhlciB3aGVuIGludGVyYWN0aW5nIHdpdGggdGhlIHNhbWUgcmVz
b3VyY2VzLiBJcyB0aGlzIHNvbWV0aGluZyB5b3UgZXhwZWN0DQo+IHJlc2N0cmwgc2hvdWxkIHBy
b3RlY3QgYWdhaW5zdD8gSSB3b3VsZCBleHBlY3QgdGhhdCB0aGVyZSB3b3VsZCBiZSBhIHNpbmds
ZSB1c2VyIHNwYWNlIHN5c3RlbQ0KPiBkb2luZyBzb21ldGhpbmcgbGlrZSBhYm92ZSBhbmQgaXQg
d291bGQgcmVzZXQgaGlzdG9yeSBhZnRlciB1bmFzc2lnbmluZyBhIGNvdW50ZXIuDQoNCkFzIHdl
IGFyZSBkaXNjdXNzaW5nIGFkZGluZyBhIG5ldyBpbnRlcmZhY2UsIEkgdGhvdWdodCBpdCB3b3J0
aCBjb25zaWRlcmluZyBhZGRpbmcNCmEgd2F5IGZvciB1c2VyIHNwYWNlIHRvIGJlIGF3YXJlIG9m
IHRoZSByZS1hc3NpZ25tZW50IG9mIGNvdW50ZXJzLiBJTUhPIGl0IHdvdWxkIGJlDQphIG5pY2Ug
dG8gaGF2ZSBmZWF0dXJlLiBOb3QgcmVxdWlyZWQgaWYgYWxsIHVzZXJzIG9mIHJlc2N0cmwgYXJl
IGF3YXJlIG9mIGVhY2ggb3RoZXIncw0KYWN0aW9ucy4NCg0KPiBUaGlzIGRvZXMgaW5kZWVkIGhp
Z2hsaWdodCB0aGF0IGlmIHJlc2N0cmwgZG9lcyBzdGFydCB0byBkeW5hbWljYWxseSBhc3NpZ24g
Y291bnRlcnMgKHdoaWNoDQo+IGhhcyBvbmx5IGJlZW4gc3BlY3VsYXRlZCBpbiB0aGlzIHRocmVh
ZCBhbmQgaXMgbm90IHBhcnQgb2YgY3VycmVudCBbMV0gZGVzaWduKSB0aGVuIGl0IG1heSBjYXVz
ZQ0KPiBwcm9ibGVtcyBvbiB1c2VyIHNwYWNlIHNpZGUuDQoNCkFncmVlZC4gRHluYW1pYyBhc3Np
Z25tZW50IHdvdWxkIGJyZWFrICJ0aGUgdXNlciBrbm93cyB3aGF0IGlzIGhhcHBlbmluZyIgYXNz
dW1wdGlvbi4NClNlZW1zIGxpa2UgYSBiYWQgaWRlYS4NCg0KPiBSZWluZXR0ZQ0KPg0KPiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2NvdmVyLjE3MzAyNDQxMTYuZ2l0LmJhYnUubW9n
ZXJAYW1kLmNvbS8NCg==

