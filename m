Return-Path: <linux-kernel+bounces-334699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05197DACC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5CB22062
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0018DF76;
	Fri, 20 Sep 2024 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkJj6iKp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051832E634
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726874901; cv=fail; b=hv1yn9q9OOB+nrqAc+AwuIeSnivSiU2ibMt8j7DqFmRvsBcYErLONWMJkvD8liep35+/8/Fh5oQP31RXn1N/Rz3H6V4gkKZtGTXmUESKCTV6In6i+sBcNxtCnjgyC6F4qS6tLM8t10T/l2V/JLQQVQ6hBMN3wfSB7utjyIUSAOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726874901; c=relaxed/simple;
	bh=F4krmN2+qv2wZh4nZthR/h3d8x+PKoq5LgNXExfJhBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s5Aw5I87q4J3HuWQ/sXKFX6+pZy4Xk2DJkDWnSPwXRO7yt32ORT0eVyc78nIN8p3Mcry12txJcFDcSQgTg3C/aWH94EUf5no3X+6lvFPoBnX4PLEVWqQrL1wxsAMvYK+VXyCAgZHzxsMVwH8k2P2LApIhuYnwQWlcDOq8dIFQMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkJj6iKp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726874899; x=1758410899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F4krmN2+qv2wZh4nZthR/h3d8x+PKoq5LgNXExfJhBw=;
  b=PkJj6iKpHJ5Anj5v0W7IZ0U4v9OINU1w2unbtB9onW4axsDJYZ1KP9nc
   6LdcebgUCDin9YEi/kkNAhW1aKZL4ENh8PBGYQ9jyXiW2BM8AbsoaI9nz
   9IMfxPf6vR1ZGp1frI8PluKIvbWilOVDwgASoel6aUJf1CKI8CNVTxato
   kk5csohNkYGIRQrNNzObNqOymCE+KdqR0I4lITKr6VJU12iTIKmfvTwJy
   lRKwvmuwWiwTFmvYo+Q7xmuripPUMchoppJZKg0JE56IdKaxMJsQvWjcl
   Ul252VUdpCfiCV5X7tNMZ301jh8SHnQuQdgcLQXIRHo6OCyzGsHMwxZx4
   g==;
X-CSE-ConnectionGUID: XzycHq6jRye5QlwkEfk/0g==
X-CSE-MsgGUID: PIRBU9FESBaA4xNYTgeA/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="36483294"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="36483294"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 16:28:18 -0700
X-CSE-ConnectionGUID: KTPfDk44S8KHo11nfEikIQ==
X-CSE-MsgGUID: hi8ynJ+BQSqe8w0pdikNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="74578036"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 16:28:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 16:28:17 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 16:28:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 16:28:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 16:28:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 16:28:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLJI/LJDBE244K8y6zTysD9sJl+RjDPYdIO/qcjq3MonJApPRl6EEOBX3LtewVNfQIdRtVhMyLAcsFUeExpcqNzy4dr4J3UD9puVeF8wotrNmR0oLf8oXsVr2q/D93hf650Tt0qq7Y/9HuDyWyJEff3LLPGAusjZw4SWL8fl5pU1Wkbzb0F8BvmoZHW/2XN/uDhx30ESE2nD1uAb88OgP5FHMNgDbIKodOALeIDUwGfZ2yv/jFvcW9ua9COVhuyMZaNWLsQcrCWBil7Mt3XAokkOGPBukC31o2c4nUuT2d4LHs5rAsGEvmMvdvj4oA8Lq7iLdCEXbvYXO95YU/LZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4krmN2+qv2wZh4nZthR/h3d8x+PKoq5LgNXExfJhBw=;
 b=My6dlp2e3/xNhPcjE9F9OO+reXBxLMmUfJOqFo7b0PsKee/bw5ruX1JDm2YTFWOt9yVfGirNhxPWErtjCJbTB9P2oni6zYRniJBmwE/sjE8f+jSavyOzLMjKyB/v2Odw7ehlatrFCp2YglRb5ONOCwOUDza+4tIIelYp03RCvpaUyoETGq2u4sOAVaUirJhsnQxnniBn5d8PzFCBYKwwZ3smsbmKWgAz7himT1pE5kB2atZTcAogU51jkTWXxAP3RM5xkPEy7i3d4LaibDtmmIiDB76EOyctg8tClaHeQa32m3DhQgcPp7GP6I34sUMGbj/zKNelkQL3LWpi/titow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by BL1PR11MB5253.namprd11.prod.outlook.com (2603:10b6:208:310::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 23:28:13 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 23:28:13 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 3/3] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP zswpout stats.
Thread-Topic: [PATCH v6 3/3] mm: swap: Count successful mTHP ZSWAP stores in
 sysfs mTHP zswpout stats.
Thread-Index: AQHa+lo+/g+JraXASEmsFJLqyAt0i7JhbD2AgAAIZ6A=
Date: Fri, 20 Sep 2024 23:28:13 +0000
Message-ID: <SJ0PR11MB5678FB71A85B86672F83B1F6C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <20240829212705.6714-4-kanchana.p.sridhar@intel.com>
 <CAJD7tkbnZHCPu0Bqs2xNyP6FQviuq6kGSQa840H+sVhiPEbYpA@mail.gmail.com>
In-Reply-To: <CAJD7tkbnZHCPu0Bqs2xNyP6FQviuq6kGSQa840H+sVhiPEbYpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|BL1PR11MB5253:EE_
x-ms-office365-filtering-correlation-id: a239b982-fc46-43b5-9d66-08dcd9cbe5c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aTBkV1ExbFNLODE0M214alBsMFVHOUlGVnBGSWV5NVRFV0pMSGVZdDFSTTRN?=
 =?utf-8?B?alNVNlE4Q0N3a3VldTkzcm5aVlJ2QWtjLzVkZ0ZzOUQxODlUNjRqL015WGNr?=
 =?utf-8?B?OGgxMjJ6Ym84TW56L3dvYjJkdUwwcndsSStGSERMT0FNTU9Ha2lhQXdFdGo1?=
 =?utf-8?B?MGxHalNkNDVXajNrekhUZGxJckxiSUljczRXQTdtY1ozZlcrNmh6bkpzeGhv?=
 =?utf-8?B?Vmc0SG5aTzUzUFcvNzVhWWVRUWJsNUFqc01jVHVqMnNIMjJtZ295Q090YVhP?=
 =?utf-8?B?WVRFbEhQRm9IN2poNHVPVVFHa3o4ZXhmTk1BTTltUVRWWVZwNStTYXVMK3h2?=
 =?utf-8?B?TnJpUklWbXptNU50YU9yQU9RMzM0R0N0bnlTYks0R29RZXlzZ2w1WWpHU01q?=
 =?utf-8?B?dmZBNGV4dUtwMUZ6REIxZDRQWFltT3B5YllJSVp6ZHpsMHFqZGpqdUFmeFov?=
 =?utf-8?B?TTBNbUwvQ2wzYm5vOXpxRDF2akduRjJONjFvbmpaeE9lc0hCMjlRRFRWRjhZ?=
 =?utf-8?B?RVJBbVRSbkJyaFpkaVpyWWxBNGNNcEVKMFBqd20rejBzYzMyaGU1aVFVOUN0?=
 =?utf-8?B?YjBYblVOY2U5bzE0RnVaaUxiZmRjcWY5UVRqOGJIazhiZmt4amNqWFlITEEy?=
 =?utf-8?B?YWd2ZUdBTzhEclhSTFJMOFdDY0JhbG12cVkvNHZVck9zak9heGNqSFBqZm4x?=
 =?utf-8?B?NG9zOUd6MVJ3aTBDczNBNU1tcmt1TWlTNjllSGRjUVAva3hpOHRGSWpxQWZh?=
 =?utf-8?B?bUpBNTFiZjdoYXJYblNRMllOcTZwUlBURG9BSVk2V0lSUXpaY0tPZnNLaDJN?=
 =?utf-8?B?Q2RQK0Q3NXkwNEpzTmJBdU9KZGJYR3pRd3NaQU0wWTluMEJQL2VHY0pjRzNy?=
 =?utf-8?B?YVZxWlI1THQvaldsZVJndmpHbC8rRXJBelVrSUVtQVptak1vVHIvUThBbU90?=
 =?utf-8?B?NU5rcVdiMC9DSkVyMENPeVpidDZ6NHcrQ3BScERTdUhnVEs4SUpQZmY1c2wr?=
 =?utf-8?B?ZDdjY2J2WWdPZHBxNUwzbEhIT3NYV3NmdFBwWDNRNE43VXhXYXJjazhrMmpK?=
 =?utf-8?B?ZWZjZWpZU1E1M0hpazUxZW1XYThMU2lYRk1XZ2FBL3NQZFJaOFVtZVhQUDZs?=
 =?utf-8?B?UFRNWitPMkZWQjZMdk9DWjZBR1RRZmVtM01oQUYrcExrSVhVeDliMHlQT0pP?=
 =?utf-8?B?cU1UNXBpK3JLT0VIb2c0MThyWUh1VFNWNklVNkpESVhZZFExemxuTm1tMWU0?=
 =?utf-8?B?YzZUVzRFS2JnUExKTXFYc1cwVFI3TVdITW9YMVFvMDk5YW93MTFOczYrS1Rh?=
 =?utf-8?B?bkVGQXJCeGhjKzVwZnhSN0JwaDNqdkZUWVhCWVEzMVcveW5MVDJRVW5HeEk4?=
 =?utf-8?B?UFVHc0VoVWZwd2h2WnkraFpGbnJrWWJDNkZEenFPMGtMb2lzWnlQRnB5dHd5?=
 =?utf-8?B?UzcrcTF6OGtJV3RlRzF5UnN0T2wzd0xJT2hURWIxdWhTTUJWMjAvc1k5RHov?=
 =?utf-8?B?b1ZCeUI1VnQxbE53cmN0QzNKRnV6TFFtcVJaU2pVT1NlT01uQ0kwdTBmVWc1?=
 =?utf-8?B?V3lRK0ZXM3U0UnVHTkV0eXlZQ0t4cDh0eVNJNDNXUGhlZjNFRDZuQnVKYVE5?=
 =?utf-8?B?a0I3d0dnamR6eUg0NDVVU0ZxNlZmY0FXRXBpR205WHZDR2lQU0pWelNVRHlm?=
 =?utf-8?B?YnFtTkZZKzNGY1VjbUNJWFNUdlhUNnVxdkYxQnEyU1Qvc2JEcDZ4OHRXOHFY?=
 =?utf-8?B?cjZtYjVxUEFQUk1KQUNTcDZXL25vWG1BRFlHSkg2ajFFRXBjSGthWFFGNnd2?=
 =?utf-8?B?dlBrQ2NnRjZiS3Z0SGoxSGozT0NlOVRMNWNnRjRzZ0RqNVNYcEE1TlVGYmMx?=
 =?utf-8?B?YzRBdmgrSXQvL01FM3RlMXJrcUE5dkhDRWl6ZTBsNUpqS1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzNrNnFkTmxaNW8wS1dUN1M0NDFQdmo0Ym55OUcrSHZqVFFtRkY4QlJIeFBx?=
 =?utf-8?B?VzQraUdmZkdjNDhtaU9nUTNhM0FiQ29yZ2p1ekRxRXBhMjFlZGZYeHFuZjdG?=
 =?utf-8?B?Y1F5eGRZYlVKV1ZuUnhVb2hvQ1pLeDd6dXY3V3ZtMndDWE5qZHNXd3lieVZS?=
 =?utf-8?B?TVAwSHBXMXo5VzkwY3htaEZNZHYyL0tGOUFrQTRFelJneHR4aXovVDVtWXFI?=
 =?utf-8?B?aEZINHhQendVcVJnUG9xdW9TaHh2M1lmWE8xMmc3aDJzeW9mazlzbXpLN3JT?=
 =?utf-8?B?dU9ES2hxZmtseFVxWGlRcURzei9Bdk9CUUNmb0lYMTQ0TjZTbGliUVRXeTdI?=
 =?utf-8?B?dVQ1aWFxQU9kNElqR0VOaE02Ykp4S3JmZGlrTlFuWG53Y29nRDR6dnBMMndt?=
 =?utf-8?B?TUZpbGlCT1NRTTBnOHgyUktXU3c1bEJFR3pvOTA2S0I2MUJ1V1M2bTFLMGVP?=
 =?utf-8?B?a1RkS0hMVFd5eFFRQ1VvdVRMZGtCbngzL2FUQ3YxdkVNbWhTTEdjeDVEUExK?=
 =?utf-8?B?SXc5TmU2QmNSc1VuNzJ3TzBrNERpY2c1ekxmY0dVK2doNUg1UVp4bEwxbnEy?=
 =?utf-8?B?VkNINllwU3gybit1RDl6YmJPZUNtNDlBZmVkbGczcjk2R0NhU2FpOCsvTWVp?=
 =?utf-8?B?NlFmRkRxdzV5UzlRZDBmOVliVjJ5Q2hiU2dmTUx4TWlHY0NkMmVVOVdQY2hM?=
 =?utf-8?B?bmRtdUZDRWI3blhXL1RmbE5ucTJMQnMyeWVFT2IybTFPd1ByL1dZdWtGSjgv?=
 =?utf-8?B?SzdzQXdVZVplb3RGcTZEYUVMbU9oU2ViazJWSjdxUmJoTy92UkMwNVp4OWhj?=
 =?utf-8?B?NGs0Sm9mb1lCcmZDbkpDM3pxMkI2U09laWRva1dkaVZELzQxZ2k2U1B3aEtO?=
 =?utf-8?B?N0lTNkE5VXJ2d3N1WGlrNmRXVk9wc0VMb2NCL2xPYmVuRmJ0RlB3LzZ1b3Bt?=
 =?utf-8?B?cWNIV1FaN2pCYkhaczhJOG5wZDd6aDgyVjArMk5vczFFV2gvQWNjeEJjak1v?=
 =?utf-8?B?azhVazBaajhiM2RZb1VRZlorV25yY0lBcGdFUDVqdjlwamZWdzVuTlZXb215?=
 =?utf-8?B?M0lJb0hDODRmbGFaQ0Jpd2JUMDRENXJpTE1XTy9Fb2tnNzd6VHorc3d0VE5X?=
 =?utf-8?B?Q3F1WGRFeVhMMHpVQmRQSkZubGVqaFB3WWF3N2VTL21CaUd3czdUa0dlbFpM?=
 =?utf-8?B?cVdhdmJ6RURzMytjcEdteFYxcWFLWXhjR0VyZWR2OS9uS25WeHJhdFlMVTRG?=
 =?utf-8?B?S2NLek0rWVdaN3Q0T0FPdFFNTEJ2V0VEODl4VkdHV0hBdFFaUERiNng5VWJG?=
 =?utf-8?B?cDlNZWRTTVJjZjRvWGZlMC9BdktycUxLQkVoaXRFUXVaL1dUdW5Udkc5NE1Q?=
 =?utf-8?B?TmZTNHJ5aGNhckRYbStNVDRKTWFRTlg4elB6M1o3Yy9lcGk1S3R6ZTFQMVJQ?=
 =?utf-8?B?R2VjSno0dWNLS2w0S3pxR1ZXRXhPVGp5SUhnS0p0S3JRTGcyUzhvOHRPK0I1?=
 =?utf-8?B?VjRlTis4Y3dLMm8yWmM5dzEva0lzVHd3SW5KeUFsODFIUDJTeG10WG8wd05h?=
 =?utf-8?B?UGU5TWJNYWZwSmVvNUVBc0NMMEhwSUlsSS9LSEV2S053cHJ2R2lneUMzdXF0?=
 =?utf-8?B?MXcyQWpYTG40byswSHhraWtjOHN6SXhGTkFjeTA0VzJVdUpxZFMzM2dJN0Yx?=
 =?utf-8?B?Y2Y1bGs0aHJtWDRybFJnaEN4MFFFM3cyNDZtRUdWMzI1NGxCTXlJQ0ZCSFhW?=
 =?utf-8?B?V1lGV05QWUd0ZEZnemJGbWRvK0pqU0NoS2NsdGttaXFKTzhZcnlzT1VTcVV3?=
 =?utf-8?B?S3BsdS9LSkppZzhGc2pJM1lzYXB2bFFjTW5vUVMwQVcxaU5NVjl3SlBJRlBT?=
 =?utf-8?B?Y3RCa3N5am5PT3FRV1hpRU9ZVUFaU1lVTXZYbURTb3ZWYXpLZ2dTaHJTeDFT?=
 =?utf-8?B?ZCtsYmtXcThibEpGTWRrZ1hGbS9NZzJBbm1ubW9KVTB6N2R6WGlaYnNEaTZt?=
 =?utf-8?B?eHJJOXhaZU5PT3FadzJLdGZPVVZBWFJnQXpNUTBZS3Budk1LeXFXZXJDNi90?=
 =?utf-8?B?NFkweUVsNFVSVVNjRmxHVU0vNk9vYWtLZE9NeTc0VFhFMWpsTThyMzlibWVC?=
 =?utf-8?B?dVZ0NWVxR2hnMTVGSFhBN0dmSXNaUmNMWkh4RVBqOWlleWdMdVdpcmJ2OWNF?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a239b982-fc46-43b5-9d66-08dcd9cbe5c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 23:28:13.6463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idG3yUNuqanR2NnFXGeLM5PhxDAb1Kp6a9r5Sia9+IQhOB4Ixb7IovijE4lbCAoJHOCIFrtLjVU6UcY+JvqrZocrFFIxD9AGG7MkUW5YL4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5253
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyMCwgMjAyNCAzOjU4
IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2su
b3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IG5waGFtY3NAZ21haWwuY29tOyBjaGVuZ21pbmcu
emhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHJ5YW4ucm9iZXJ0c0Bh
cm0uY29tOyBIdWFuZywgWWluZw0KPiA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdt
YWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gWm91LCBOYW5oYWkgPG5hbmhh
aS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGlu
dGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMy8zXSBtbTogc3dhcDogQ291bnQgc3VjY2Vzc2Z1bCBtVEhQIFpT
V0FQIHN0b3Jlcw0KPiBpbiBzeXNmcyBtVEhQIHpzd3BvdXQgc3RhdHMuDQo+IA0KPiBPbiBUaHUs
IEF1ZyAyOSwgMjAyNCBhdCAyOjI34oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+IDxrYW5jaGFu
YS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBhIG5ldyBNVEhQX1NU
QVRfWlNXUE9VVCBlbnRyeSB0byB0aGUgc3lzZnMgbVRIUCBzdGF0cyBzbyB0aGF0DQo+ID4gcGVy
LW9yZGVyIG1USFAgZm9saW8gWlNXQVAgc3RvcmVzIGNhbiBiZSBhY2NvdW50ZWQuDQo+ID4NCj4g
PiBJZiB6c3dhcF9zdG9yZSgpIHN1Y2Nlc3NmdWxseSBzd2FwcyBvdXQgYW4gbVRIUCwgaXQgd2ls
bCBiZSBjb3VudGVkIHVuZGVyDQo+ID4gdGhlIHBlci1vcmRlciBzeXNmcyAienN3cG91dCIgc3Rh
dHM6DQo+ID4NCj4gPiAvc3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9odWdlcGFnZS9odWdlcGFn
ZXMtKmtCL3N0YXRzL3pzd3BvdXQNCj4gPg0KPiA+IE90aGVyIGJsb2NrIGRldi9mcyBtVEhQIHN3
YXAtb3V0IGV2ZW50cyB3aWxsIGJlIGNvdW50ZWQgdW5kZXINCj4gPiB0aGUgZXhpc3Rpbmcgc3lz
ZnMgInN3cG91dCIgc3RhdHM6DQo+ID4NCj4gPiAvc3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9o
dWdlcGFnZS9odWdlcGFnZXMtKmtCL3N0YXRzL3N3cG91dA0KPiA+DQo+ID4gQmFzZWQgb24gY2hh
bmdlcyBtYWRlIGluIGNvbW1pdA0KPiA2MWU3NTFjMDE0NjZmZmVmNWRjNzJjYjY0MzQ5NDU0YTY5
MWM2YmZlDQo+ID4gKCJtbTogY2xlYW51cCBjb3VudF9tdGhwX3N0YXQoKSBkZWZpbml0aW9uIiks
IHRoaXMgcGF0Y2ggYWxzbyBtb3Zlcw0KPiA+IHRoZSBjYWxsIHRvIGNvdW50X210aHBfc3RhdCgp
IGluIGNvdW50X3N3cG91dF92bV9ldmVudCgpIHRvIGJlIG91dHNpZGUNCj4gPiB0aGUgImlmZGVm
IENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRSIuDQo+IA0KPiBUaGlzIHNob3VsZCBiZSBpbiBh
IHNlcGFyYXRlIGNoYW5nZSwgaXQncyBpcnJlbGV2YW50IHRvDQo+IE1USFBfU1RBVF9aU1dQT1VU
IGJlaW5nIGFkZGVkLg0KDQpTdXJlLiBJIHdpbGwgc3VibWl0IHRoaXMgYXMgYSBzZXBhcmF0ZSBj
aGFuZ2UuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaHVnZV9tbS5oIHwgMSArDQo+ID4gIG1tL2h1Z2VfbWVt
b3J5LmMgICAgICAgIHwgMyArKysNCj4gPiAgbW0vcGFnZV9pby5jICAgICAgICAgICAgfCAzICsr
LQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaHVnZV9tbS5oIGIvaW5jbHVkZS9s
aW51eC9odWdlX21tLmgNCj4gPiBpbmRleCA0ZGExMDJiNzRhOGMuLjhiNjkwMzI4ZTc4YiAxMDA2
NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2h1Z2VfbW0uaA0KPiA+ICsrKyBiL2luY2x1ZGUv
bGludXgvaHVnZV9tbS5oDQo+ID4gQEAgLTExOCw2ICsxMTgsNyBAQCBlbnVtIG10aHBfc3RhdF9p
dGVtIHsNCj4gPiAgICAgICAgIE1USFBfU1RBVF9BTk9OX0ZBVUxUX0FMTE9DLA0KPiA+ICAgICAg
ICAgTVRIUF9TVEFUX0FOT05fRkFVTFRfRkFMTEJBQ0ssDQo+ID4gICAgICAgICBNVEhQX1NUQVRf
QU5PTl9GQVVMVF9GQUxMQkFDS19DSEFSR0UsDQo+ID4gKyAgICAgICBNVEhQX1NUQVRfWlNXUE9V
VCwNCj4gPiAgICAgICAgIE1USFBfU1RBVF9TV1BPVVQsDQo+ID4gICAgICAgICBNVEhQX1NUQVRf
U1dQT1VUX0ZBTExCQUNLLA0KPiA+ICAgICAgICAgTVRIUF9TVEFUX1NITUVNX0FMTE9DLA0KPiA+
IGRpZmYgLS1naXQgYS9tbS9odWdlX21lbW9yeS5jIGIvbW0vaHVnZV9tZW1vcnkuYw0KPiA+IGlu
ZGV4IDE1NDE4ZmZkZDM3Ny4uYWQ5MjFjNGIyYWQ4IDEwMDY0NA0KPiA+IC0tLSBhL21tL2h1Z2Vf
bWVtb3J5LmMNCj4gPiArKysgYi9tbS9odWdlX21lbW9yeS5jDQo+ID4gQEAgLTU4Nyw2ICs1ODcs
NyBAQCBzdGF0aWMgc3RydWN0IGtvYmpfYXR0cmlidXRlIF9uYW1lIyNfYXR0ciA9DQo+IF9fQVRU
Ul9STyhfbmFtZSkNCj4gPiAgREVGSU5FX01USFBfU1RBVF9BVFRSKGFub25fZmF1bHRfYWxsb2Ms
DQo+IE1USFBfU1RBVF9BTk9OX0ZBVUxUX0FMTE9DKTsNCj4gPiAgREVGSU5FX01USFBfU1RBVF9B
VFRSKGFub25fZmF1bHRfZmFsbGJhY2ssDQo+IE1USFBfU1RBVF9BTk9OX0ZBVUxUX0ZBTExCQUNL
KTsNCj4gPiAgREVGSU5FX01USFBfU1RBVF9BVFRSKGFub25fZmF1bHRfZmFsbGJhY2tfY2hhcmdl
LA0KPiBNVEhQX1NUQVRfQU5PTl9GQVVMVF9GQUxMQkFDS19DSEFSR0UpOw0KPiA+ICtERUZJTkVf
TVRIUF9TVEFUX0FUVFIoenN3cG91dCwgTVRIUF9TVEFUX1pTV1BPVVQpOw0KPiA+ICBERUZJTkVf
TVRIUF9TVEFUX0FUVFIoc3dwb3V0LCBNVEhQX1NUQVRfU1dQT1VUKTsNCj4gPiAgREVGSU5FX01U
SFBfU1RBVF9BVFRSKHN3cG91dF9mYWxsYmFjaywNCj4gTVRIUF9TVEFUX1NXUE9VVF9GQUxMQkFD
Syk7DQo+ID4gICNpZmRlZiBDT05GSUdfU0hNRU0NCj4gPiBAQCAtNjA1LDYgKzYwNiw3IEBAIHN0
YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICphbm9uX3N0YXRzX2F0dHJzW10gPSB7DQo+ID4gICAgICAg
ICAmYW5vbl9mYXVsdF9mYWxsYmFja19hdHRyLmF0dHIsDQo+ID4gICAgICAgICAmYW5vbl9mYXVs
dF9mYWxsYmFja19jaGFyZ2VfYXR0ci5hdHRyLA0KPiA+ICAjaWZuZGVmIENPTkZJR19TSE1FTQ0K
PiA+ICsgICAgICAgJnpzd3BvdXRfYXR0ci5hdHRyLA0KPiA+ICAgICAgICAgJnN3cG91dF9hdHRy
LmF0dHIsDQo+ID4gICAgICAgICAmc3dwb3V0X2ZhbGxiYWNrX2F0dHIuYXR0ciwNCj4gPiAgI2Vu
ZGlmDQo+ID4gQEAgLTYzNyw2ICs2MzksNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZV9ncm91
cCBmaWxlX3N0YXRzX2F0dHJfZ3JwID0gew0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgYXR0cmli
dXRlICphbnlfc3RhdHNfYXR0cnNbXSA9IHsNCj4gPiAgI2lmZGVmIENPTkZJR19TSE1FTQ0KPiA+
ICsgICAgICAgJnpzd3BvdXRfYXR0ci5hdHRyLA0KPiA+ICAgICAgICAgJnN3cG91dF9hdHRyLmF0
dHIsDQo+ID4gICAgICAgICAmc3dwb3V0X2ZhbGxiYWNrX2F0dHIuYXR0ciwNCj4gPiAgI2VuZGlm
DQo+ID4gZGlmZiAtLWdpdCBhL21tL3BhZ2VfaW8uYyBiL21tL3BhZ2VfaW8uYw0KPiA+IGluZGV4
IGI2ZjE1MTlkNjNiMC4uMjYxMDZlNzQ1ZDczIDEwMDY0NA0KPiA+IC0tLSBhL21tL3BhZ2VfaW8u
Yw0KPiA+ICsrKyBiL21tL3BhZ2VfaW8uYw0KPiA+IEBAIC0yODksNiArMjg5LDcgQEAgaW50IHN3
YXBfd3JpdGVwYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBzdHJ1Y3QNCj4gd3JpdGViYWNrX2NvbnRy
b2wgKndiYykNCj4gPiAgICAgICAgICAgICAgICAgc3dhcF96ZXJvbWFwX2ZvbGlvX2NsZWFyKGZv
bGlvKTsNCj4gPiAgICAgICAgIH0NCj4gPiAgICAgICAgIGlmICh6c3dhcF9zdG9yZShmb2xpbykp
IHsNCj4gPiArICAgICAgICAgICAgICAgY291bnRfbXRocF9zdGF0KGZvbGlvX29yZGVyKGZvbGlv
KSwgTVRIUF9TVEFUX1pTV1BPVVQpOw0KPiA+ICAgICAgICAgICAgICAgICBmb2xpb191bmxvY2so
Zm9saW8pOw0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgICAgIH0NCj4g
PiBAQCAtMzA4LDggKzMwOSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3VudF9zd3BvdXRfdm1f
ZXZlbnQoc3RydWN0DQo+IGZvbGlvICpmb2xpbykNCj4gPiAgICAgICAgICAgICAgICAgY291bnRf
bWVtY2dfZm9saW9fZXZlbnRzKGZvbGlvLCBUSFBfU1dQT1VULCAxKTsNCj4gPiAgICAgICAgICAg
ICAgICAgY291bnRfdm1fZXZlbnQoVEhQX1NXUE9VVCk7DQo+ID4gICAgICAgICB9DQo+ID4gLSAg
ICAgICBjb3VudF9tdGhwX3N0YXQoZm9saW9fb3JkZXIoZm9saW8pLCBNVEhQX1NUQVRfU1dQT1VU
KTsNCj4gPiAgI2VuZGlmDQo+ID4gKyAgICAgICBjb3VudF9tdGhwX3N0YXQoZm9saW9fb3JkZXIo
Zm9saW8pLCBNVEhQX1NUQVRfU1dQT1VUKTsNCj4gPiAgICAgICAgIGNvdW50X3ZtX2V2ZW50cyhQ
U1dQT1VULCBmb2xpb19ucl9wYWdlcyhmb2xpbykpOw0KPiA+ICB9DQo+ID4NCj4gPiAtLQ0KPiA+
IDIuMjcuMA0KPiA+DQo=

