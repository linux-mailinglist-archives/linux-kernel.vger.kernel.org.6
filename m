Return-Path: <linux-kernel+bounces-276068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3613B948E05
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF0B25C96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6151C3F13;
	Tue,  6 Aug 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1e2zV/G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD001C3F3E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944523; cv=fail; b=M81hAZ9HRTmgljKL+l3PioPyBgPGO+H4EjK5UXT7SH0ZSxJ+mjedzecCzFD9puAxosE7GuueMPWqsrefrz7OmwCd2Jg5fWqiNi+UvduKLYfr6xb0H/sH8jF2Lx7gbNW4gDZKm18zs58Qi3j1bhDsMF9t+M7ON3/23l/IDMOsnMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944523; c=relaxed/simple;
	bh=n9rUzgLi3ztiGOSAy7+/0KUbBpT+kYhrJXywhcj5sI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HnHe+uIu8v3JL/xLHM3jb6Mr0pKdyVEdOyw0B3XNrhd90tLDGHvwQT7NulaxV0Nv+B6uexe6f6gUWmho3i22PMLm6P2+w717b0u2t/FY9pc0D7TJY9SmW8t1jLz2YQInx6i/E5Vm6WsQwUXDU7P5X/Zj9aF+eoGrLUiYq8fG/20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1e2zV/G; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722944522; x=1754480522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n9rUzgLi3ztiGOSAy7+/0KUbBpT+kYhrJXywhcj5sI4=;
  b=Z1e2zV/GsiyFi3AQHdrlCPSb29rC3bwbC/3yZ2dIaMF4ptxDZO1khqbk
   z680n+wWWggIcoDuA+4F3rwN0GuVMATWROCqWHMGiRty7Me+9hxqVdtZI
   Hai2Qjgn6QaRPY412mytFlW78RSC9MQ58iuep6XM9aiG1V2bC7Aur10M+
   Io3+cd+TWwAsCD4CYJglMoJcB1nlZUGPWGn89t9yWmEcaKP6mq5b9a4fe
   pA3a4XXZalcpuZHxJVSM6K4KF8QPtlPA1ZpOGLwq6oSxrqYWXc0S1jReJ
   JbWJkH+iAZWZMN6i9vHUhVFh5sUowYpD0lDBhbVDwawOJIA8THJrLp8r9
   g==;
X-CSE-ConnectionGUID: LStzarTITICXOyqUcDwO4g==
X-CSE-MsgGUID: yrGwgBAtR1ShY/B9KcuNog==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="32105775"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="32105775"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:42:02 -0700
X-CSE-ConnectionGUID: 2WnrR+5qRIKEA7N8wtNDGg==
X-CSE-MsgGUID: jmBmdm0URiSTq7+6N8+jBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56139414"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 04:42:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 04:42:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 04:42:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 04:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCwfE7CTuDrnL9+bzOJWPf/59LKL5YGuwvSAGan9yVhEOfAhwt/H9+9vkOHp0kvwhfBMCa6HNAAbXoo2hYhqEAbC/Pa47Zy1TRVwhV/PZBrLPQ7nxCgakYjkXU6g0FmyHGOJwfKHda+7YEnrqy7DhSnzkDa8tvJ2Aqhalbv9vpVWD+okIk6w3Dpp6wZEPyV0IHpJmxhVlxX68a1j7NgP+HHzwuqaBIn7us8ctpmH1glpqs6vp4fKAZwONw17A19rijpP2ZYj+G/LtE5msC1v0/CQ38kLV440/9FwdOg28fG4e6b/ihmtAiUnBJYU6trn/mogexeWLSF+Cse+VdQXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9rUzgLi3ztiGOSAy7+/0KUbBpT+kYhrJXywhcj5sI4=;
 b=efymB3jIqFBQa9hrsh2mr3nJj2oider25nQodqhfTgvEBl5Wng6kk0FIjUhdzFCDBElrLO9zHIoeO0TMR1/osdZW5xljmcZBGPiiiops7pPlZqn6wTaOWtTA/8PdcUo5bhEsZyCtA/WcOSlT5EOuiRoeGktDOkw3Kzg6CnlNS2yQWdRWGAdwOamYV79mhK9LvNaCbEyjfiwXiUP5thEGFd7TiJWEIMdN9xCrfceHUg9Q+bNdm0mYa29vtyvNMw9yysE1aqDKEuBE9sVwL5hgqBm8wUFyzzIP4ktQEm35+e8BXvSlzQoFQONFuQZ76NnPe1ku5LuPpxhjZzPtpXA4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 LV2PR11MB6071.namprd11.prod.outlook.com (2603:10b6:408:178::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 11:41:57 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::4df9:c236:8b64:403a%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 11:41:57 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Alexey Gladkov <legion@kernel.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ytcoode@gmail.com" <ytcoode@gmail.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Yao, Yuan" <yuan.yao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "John.Starks@microsoft.com"
	<John.Starks@microsoft.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Cui, Dexuan"
	<decui@microsoft.com>, "oleg@redhat.com" <oleg@redhat.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de"
	<bp@alien8.de>, "geert@linux-m68k.org" <geert@linux-m68k.org>,
	"cho@microsoft.com" <cho@microsoft.com>
Subject: RE: [PATCH v2 2/5] x86/tdx: Add validation of userspace MMIO
 instructions
Thread-Topic: [PATCH v2 2/5] x86/tdx: Add validation of userspace MMIO
 instructions
Thread-Index: AQHa5zu2NsQPG6novkuXSabIiecDDrIZQpmAgACQkACAAEEjAIAABsfw
Date: Tue, 6 Aug 2024 11:41:57 +0000
Message-ID: <DM8PR11MB575097797C8CA3779F11C303E7BF2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <cover.1722356794.git.legion@kernel.org>
 <cover.1722862355.git.legion@kernel.org>
 <6f989aea155817ef2f8a5fd2240ccff3f74d4edd.1722862355.git.legion@kernel.org>
 <83c9b05e7d359c0486a061f3bd31920ddb5c33a0.camel@intel.com>
 <rtqr63t6lyehdkj4ezobhgw5o7hyewoaqnhmxgxbfbrjxzyyo4@5v3thwohmzse>
 <ZrIE4FVBflJrJagX@example.org>
In-Reply-To: <ZrIE4FVBflJrJagX@example.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|LV2PR11MB6071:EE_
x-ms-office365-filtering-correlation-id: 18db3bc6-d423-4993-c2e4-08dcb60cc701
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cVVXa21BejUzZGJaWXRVLzZWNlZub2k4QkZ3RzZXa3R5MEJFRHA0RjBKYUg4?=
 =?utf-8?B?Mk92aXFWNXpYMmFMVXExR3JxMDcrTVRVNFU2UUVmcUVibDZPdjFTWTRDZHhR?=
 =?utf-8?B?ZnZwMVl4c2MyUndKQVRpM2h2NUZHUnV3SC93bWlZem5WeVc4TngybTRIU2Jk?=
 =?utf-8?B?UWZKcStiM2x5YmNWTWhRZmNVM3ZwRXRuKzNKNWpTSUpSUndpWXF1ZHREaDU5?=
 =?utf-8?B?ZCsra0tmdWdSbGJDSXRsWk01b3pCNjA4dmppY2hDQ015WjNaRjJDNnBvZ1pL?=
 =?utf-8?B?ekhSNmNTRFdMSDBoaFZXVmNCU0VoRy81djQwOHJxMUw0UURqblBjR3AvSEk3?=
 =?utf-8?B?cVR2UHNLY1dURG15SEt0ZHlVQUhlZVhCT2Y1c1JBbHR2cWZHQTVPdGQ5aU5C?=
 =?utf-8?B?SmRTSk1KUm1lYk5GTDg4L3l3SnhKeVZZTTY0Mkk2elRsSTZzZEFsTm83VGxD?=
 =?utf-8?B?c3RuVFJZSEx0anFCcmRmK0pXdVdkb1dDMHBNc2t2YWxvTTNyVWVtOW05UXY5?=
 =?utf-8?B?RGtadVVGdDNZdnNZUWwxUmpPVlMvQ0dOYmNGWnVXZW5ZK2paaEVRc2k1MWZr?=
 =?utf-8?B?dEdEVDhHWFR2OC9xQnd4bjVqM1RPZkF1Rm4waWNDRXNlUDA2VWp1SkhOZTA1?=
 =?utf-8?B?M1lqdlR6L2RFcFEyMnRyd0tWcFRlZE9ob0pKVjlTYnBzbUJMU0VWOTRVVkZ6?=
 =?utf-8?B?UEhvcytnQnRoWVNTY0x3TmRJNXRGaHo0QmczZnloUGtSVllRaTBMeFBlL1F4?=
 =?utf-8?B?amhFQkRaU0RzYi9LTFFmMmtxYTB0dlRSdC9PZ1c0c0tsMW5XNnd4ZGRmdmlq?=
 =?utf-8?B?RmJON3ZpRkYwWlk2ZlM5QlN0eGRkb2FCa0F5am5jUjlJLzhlVlVROE52N3BC?=
 =?utf-8?B?cDlicWIwZzVBMGEzV2Z3cHd5Q2NaMWpNR1ludlpEcklmRVpHN21mbTZ0d2Rj?=
 =?utf-8?B?Q0FUNHZYTFFVOGtidXhCMjlSUjh6OHB4am42TmZXVjFHOU1ja3VENDFXSCtq?=
 =?utf-8?B?TkF4TmFiOUdqVU5sVTBBWlJ6LzU2RkVQWWZHMnJWS0ZRRTh3UXdRSndIT3Va?=
 =?utf-8?B?SlpmVG9TVUpDYlE3bTcxUXM5M2h5Tml0Q09Fa2FZSkVqek5DZEtkLy9mdXBH?=
 =?utf-8?B?T0hUYW04a3JRN1lYckhXVFZyUHQ0TllvQWRwbW5TbVV0OW9DcXUxL1o0aXNP?=
 =?utf-8?B?cGZIbzRaWi9TdmhoaG9aZ0FheFpNeVoyN0tRN2NuSE9pOU9EZjl5U3FZejlx?=
 =?utf-8?B?VGJ5SitFbHpRekRJMEtqMnZsU2tGYlREMTc1MGRSRWpzc3FIc3Q0TDIwYUhl?=
 =?utf-8?B?T1BrbXdlVW1NdjFoYlcxcXVTK1M3NC92YVM0V0pQbWUrNG9TL3RzUUw1QWg4?=
 =?utf-8?B?T2Nid2lnMExqNkdKOURhTXBtWXdsSG5Pa3M0eXdGbEs1bFFZZ2d4Mlk2WjVl?=
 =?utf-8?B?MDNPK0pWWEhvOXJPT1FMZGdaeUdib0hiTjZoNzFEV3gvZmttc1RXRWxHR0ZY?=
 =?utf-8?B?MDVTekR2Q1V2TkQ1RnF4bkQrMjhuYUdQYXppQUdPOGhOQ0hpWnI1S3pGTWFS?=
 =?utf-8?B?ekJEVUg5cG15OHpZdmRMTDkwS1RVVTgxK2l0NnZvdGpRRmlHZmFFTFA2YXR3?=
 =?utf-8?B?ck5PZlVRRVlZVmNDeURFeTlMbjNVcUY5RFJLbE9XMDRjMUxHTmFreE1TWWh3?=
 =?utf-8?B?RWlTbnJUMUM0ZUNWalQrYTA1YThVRGpjdElJUjlwZWtOb3ZySGRiaUwrQWJM?=
 =?utf-8?B?UW8wWGdGbFE5czlHNFAxdlJ0eUVIVjJlOXprejJiMzFGUWEzR3ppMk1tTVJX?=
 =?utf-8?B?Tk5GSVBQbEd6bHV2Y3RiVXVuMzVxWi80aXpjVkdnTnZqOTVoQVJZam53ZGFj?=
 =?utf-8?B?YUx5MDk1OWVGN0R5L24zOVNEQmozaVJYVkU5V0tLMUU5UEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0t4THYzdnRHUDZrL2Z6UVFMaGcwOFV5WGlxQ0VUTkVCTlg0RHFsL0dsamZ0?=
 =?utf-8?B?akFIOWlqbHVZazVFQlFFalk4QURhSTNST3ZSQzFlOHFPZzB2Z0FrbUt3M3pn?=
 =?utf-8?B?TVo5OW84WDdtd0JDOXZNdDdZdDVRYmMxemZDbUxqNitWYzcyNEUrMjNkUmhq?=
 =?utf-8?B?RGFRbFRINFFnWFI0QmtaSnRVYzFWclpRTW56cTVEVm16NWFhbE5GQXhjZHN0?=
 =?utf-8?B?RGZRamZVQ09Ja1FXQXFUSXVoSG4wL3A4SkdlYXJGYnFjc0JZbVA3YlpXQnBH?=
 =?utf-8?B?N1VOOEFyU0dJMS9xRllHZDB3ejVXR05KbHlHTVFsNkhFblhqemNoWUhTbjhj?=
 =?utf-8?B?VnYrKzdaMmN0b3gra0VsME5yd09xZjZ0aDN3V3dVc0N0TWJ1SHNyYm85NmdS?=
 =?utf-8?B?SUQvUkpEUjJMajZtUUJxYkpnazh6VFpIbzhoRzlLQzhLYVYxdUhjYTluVWZ1?=
 =?utf-8?B?NlFtbzdMMUgvcldXbWp0NWhOS00wbDVSNHlOV3poRjJ2ekg4djB0RnArME5r?=
 =?utf-8?B?d0haZ3d1cDRabEhSUWUwYk5hTFFCY3N5QkRTNzNDVHkxV0Q1UXBJNk1PbEox?=
 =?utf-8?B?OCtxRWl1cHBwYlpSNDZvUlplVkZZSGpwTUZKQm5tYXNqbVZWRk5tRUtFT2J0?=
 =?utf-8?B?ZUh4Z2pqc1U3RDdKdktiazlYOVBiYmUxUVBXNy96MWI5aFpPcDdYSXg0cDJj?=
 =?utf-8?B?M25xZDlsUlpIOUE3ck9aQzROQTRGWHdxMjRJUjNJWnYvSXZLRUVKaklQSUN4?=
 =?utf-8?B?WG9XNktZSlJpbC9Oc3NQTVEveml4d1p5TW9iVGhJZGN5eGcraUl4QitVR3Ax?=
 =?utf-8?B?Zzh4NDJvUk54R2xIWEk4b3o3SUFjK0pkaEhwbWJCb1JZeENQeTdYVFB0LzdG?=
 =?utf-8?B?V1NFZTZFUzJhOGxoMElaeThWREFEVmVQOGhuQTgrOHBQb2plREVqbEZaN01a?=
 =?utf-8?B?UVQwRWxIMWNTai80UFlWeFNZdWRWdDQ2a2ZLT2ZuUHpKWFJBcG5ZZTBEczRv?=
 =?utf-8?B?bk9BYm5lNzEyWkhKdWNNakhVMFlzbFFVMEFVK1hmdHZBc2ZlbzNLand6eU52?=
 =?utf-8?B?Z1RrS2paWkFzT3BmZ1ZmbTBLalUwTjNVSy9jejM5UmpzMzJnYzFuUDRraHVF?=
 =?utf-8?B?V0ZrZ2xnWEdHcGw3a0JadnpaTlBrQmdVUHJpNWFNaDE4UThBdGF0Z0NnV2xi?=
 =?utf-8?B?TThKb2twTndMSUJEamdCL0Fwb2lDZ2g4d0lTaGVibDJrK0Nlalc2R1hBS01j?=
 =?utf-8?B?RTNGQnF6eDY1cVZ0a2JJdWEzSmlnMUZ3ZWJUeWJ4UWphbGN4VkM0ZzBteGVR?=
 =?utf-8?B?THgxZWYzdWl4eWUvbjR3TnBYd1l4c2h6WWJFNS9jUlRXUkV5blBZdW0vUW1p?=
 =?utf-8?B?eU5JN1hNQnlIbWYranp4bXZVVjJWeHFzdnpscjQzZlVHMXBPZi94ZWpraHBF?=
 =?utf-8?B?MzBZcVZnWW1tcWJhK05HTDhtc3BXOFN1WUFIbXNObVplN0REbVkrdkRPVlJG?=
 =?utf-8?B?Z0Jvek5aa0E2TVB0MUN5NngvMjBlcU9zSEZlcjNNcm5sdTdPVng3bkFvRS9h?=
 =?utf-8?B?NlppNTZRUUY5a2Q1Sm5TRHpqMmZ3ZTMvZDFhV29CU3lOelhGL1NFWnp0M1Fj?=
 =?utf-8?B?ckhSRDcxUWhITVhxbmVPa2JDa3Bpc05pMnVWQldhSFdhdjZkVzBFbmtaa0Fm?=
 =?utf-8?B?d200RlhZeXFUL20yT01Qb1dyZzBlUzUxWmttK1dGaUdndUxWcjR5Nm5IVzcx?=
 =?utf-8?B?TzZZQUVLK1FaYnlPS2hMNWwzODZqSzBLVjF0KzlaVFRrSC9DcFVFQ0RwYWVh?=
 =?utf-8?B?a2RQMXlVNEpxZ05ndXNQUTNZL3NHeUxkblN2b2UwTXV2U2NQWHFBT1JBZ1Fa?=
 =?utf-8?B?QU9NS0I1VEpWWGxZREtmL2pwdUVDNjE5bHFLTHp6K21oMG9NeWM3SFZkL0xy?=
 =?utf-8?B?QXJEbC9UcjZQaldFc3Ywd2NpcTRza2Z5bUtFeVhFbDc5Zi9ycFA2R1hhYlRD?=
 =?utf-8?B?U3QzTHhidG1BL0ZpdDhKcmlub2ZPWno0UWVUVDVud0t0UUpaR3QvckljdUxM?=
 =?utf-8?B?dFQzZFBCeXJPbnlRY0RjUld5SU4zN002d1MyU3RRZlo3blBwSWtFQlpoY0k2?=
 =?utf-8?Q?QQzSL9xj+Zn2YQGbf26849Yu6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18db3bc6-d423-4993-c2e4-08dcb60cc701
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 11:41:57.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: je8Z3IjUb0IxU+oRI9EclzfKKEP2PfN7Tq4VMxqOqO2aLZMWWI0+Au24olcz/Cvpo5bb9WU6USff8tlrImbMGL6LE8+/Hbz9TxgOPKZ4PPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6071
X-OriginatorOrg: intel.com

PiBPbiBUdWUsIEF1ZyAwNiwgMjAyNCBhdCAxMDoxODoyMEFNICswMzAwLCBraXJpbGwuc2h1dGVt
b3ZAbGludXguaW50ZWwuY29tDQo+IHdyb3RlOg0KPiA+IE9uIE1vbiwgQXVnIDA1LCAyMDI0IGF0
IDEwOjQwOjU1UE0gKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+ID4gT24gTW9u
LCAyMDI0LTA4LTA1IGF0IDE1OjI5ICswMjAwLCBBbGV4ZXkgR2xhZGtvdiAoSW50ZWwpIHdyb3Rl
Og0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqB2YWRkciA9ICh1bnNpZ25lZCBsb25nKWluc25fZ2V0
X2FkZHJfcmVmKCZpbnNuLCByZWdzKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqBpZiAodXNlcl9tb2RlKHJlZ3MpKSB7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAobW1hcF9yZWFkX2xvY2tfa2lsbGFibGUoY3VycmVudC0+bW0pKQ0KPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAt
RUlOVFI7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldCA9IHZhbGlkX3ZhZGRyKHZlLCBtbWlvLCBzaXplLCB2YWRkcik7DQo+ID4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gdW5sb2NrOw0KPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqB9DQo+ID4gPiA+ICsNCj4gPiA+DQo+ID4gPiBJbiB0aGUgY2FzZSBvZiB1
c2VyIE1NSU8sIGlmIHRoZSB1c2VyIGluc3RydWN0aW9uICsgTUFYX0lOU05fU0laRQ0KPiBzdHJh
ZGRsZXMgYQ0KPiA+ID4gcGFnZSwgdGhlbiB0aGUgImZldGNoIiBpbiB0aGUga2VybmVsIGNvdWxk
IHRyaWdnZXIgYSAjVkUuIEluIHRoaXMgY2FzZSB0aGUNCj4gPiA+IGtlcm5lbCB3b3VsZCBoYW5k
bGUgdGhpcyBzZWNvbmQgI1ZFIGFzIGEgIXVzZXJfbW9kZSgpIE1NSU8gSSBndWVzcy4NCj4gPiA+
DQo+ID4gPiBXb3VsZCBzb21ldGhpbmcgcHJldmVudCB0aGUgc2FtZSBtdW5tYXAoKSBjaGVja3Mg
bmVlZGluZyB0byBoYXBwZW4NCj4gZm9yIHRoYXQNCj4gPiA+IHNlY29uZCBrZXJuZWwgI1ZFPyBJ
ZiBub3QsIEkgd29uZGVyIGlmIHRoZSBtdW5tYXAoKSBwcm90ZWN0aW9uIGxvZ2ljDQo+IHNob3Vs
ZCBhbHNvDQo+ID4gPiB0cmlnZ2VyIGZvciBhbnkgdXNlcnNwYWNlIHJhbmdlIHZlLT5ncGEgYXMg
d2VsbC4NCj4gPg0KPiA+IFRoYXQncyBhbiBpbnRlcmVzdGluZyBzY2VuYXJpbywgYnV0IEkgdGhp
bmsgd2UgYXJlIGZpbmUuDQo+ID4NCj4gPiBUaGUgZmV0Y2ggaXMgY29weV9mcm9tX3VzZXIoKSB3
aGljaCBpcyAiUkVQOyBNT1ZTQiIgb24gYWxsIFREWCBwbGF0Zm9ybXMuDQo+ID4gS2VybmVsIHJl
amVjdHMgTU9WUyBpbnN0cnVjdGlvbiBlbXVsYXRpb24gZm9yICF1c2VyX21vZGUoKSB3aXRoIC1F
RkFVTFQuDQo+IA0KPiBCdXQgTU9WUyB3aWxsIGJlIHVzZWQgb25seSBpZiBYODZfRkVBVFVSRV9G
U1JNIGZlYXR1cmUgaXMgcHJlc2VudC4NCj4gT3RoZXJ3aXNlIHJlcF9tb3ZzX2FsdGVybmF0aXZl
IHdpbGwgYmUgdXNlZCwgd2hpY2ggdXNlcyBNT1ZCLg0KPiANCj4gSSBrbm93IHRoYXQgWDg2X0ZF
QVRVUkVfRlNSTSBhcHBlYXJlZCBzaW5jZSBJY2UgTGFrZSwgYnV0IHN0aWxsLg0KDQpUaGlzIGlz
IGhvdyB0aGUgWDg2X0ZFQVRVUkVfRlNSTSBjcHVpZCBiaXQgaXMgdHJlYXRlZCB1bmRlciBURFg6
DQoNCnsNCiAgICAgICAgICAiTVNCIjogIjQiLA0KICAgICAgICAgICJMU0IiOiAiNCIsDQogICAg
ICAgICAgIkZpZWxkIFNpemUiOiAiMSIsDQogICAgICAgICAgIkZpZWxkIE5hbWUiOiAiRmFzdCBT
aG9ydCBSRVAgTU9WIiwNCiAgICAgICAgICAiQ29uZmlndXJhdGlvbiBEZXRhaWxzIjogIlREX1BB
UkFNUy5DUFVJRF9DT05GSUciLA0KICAgICAgICAgICJCaXQgb3IgRmllbGQgVmlydHVhbGl6YXRp
b24gVHlwZSI6ICJDb25maWd1cmVkICYgTmF0aXZlIiwNCiAgICAgICAgICAiVmlydHVhbGl6YXRp
b24gRGV0YWlscyI6IG51bGwNCiAgICAgICAgfSwNCg0KV2hpY2ggbWVhbnMgVk1NIGhhcyB0aGUg
d2F5IHRvIG92ZXJ3cml0ZSB0aGUgbmF0aXZlIHBsYXRmb3JtIHZhbHVlDQphbmQgc2V0IGl0IHRv
ICIwIiwgc28gd2UgbXVzdCBhY2NvdW50IGZvciBib3RoIGNhc2VzLiANCg==

