Return-Path: <linux-kernel+bounces-333923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCF897CFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071C81F24E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32A5C148;
	Fri, 20 Sep 2024 02:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ct6GtD93"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F787625
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726799453; cv=fail; b=skZaxLH+tJ2RdxMNV1ZKCb/U1JA7Pl2JEdCaGvqV4PTYRji911W9BLM/tex6fJgjPLXo58j1Cxwd/DI8IQ86kP8NCSDkkyafcYrbBQ6PQeNSy03QcxUB81PH/MozFx++sffWjIoZDCRQoNSuitJrTby7/E5VxctatoHy8XeNdRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726799453; c=relaxed/simple;
	bh=tXlg95Wq8PLyHV+t6sVQ3hEfd/P4mmv3J9CJmpdNxdI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAeL/5Y0hOCHAgYPp5ny/K9jLprrLFoSERiwfhugwgVTuRncsfBRlX0wwuhxhdFJ2uUN++r1ia+QIMNCynzTWnJsP1pjMKfD2aUaQv8g5JLyjEkO251+0aOgOvPaMlbx3ZBGQsm+B7UbSLAAua6dtUoZjnAXZ+cVeG/R5nwnmno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ct6GtD93; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726799452; x=1758335452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tXlg95Wq8PLyHV+t6sVQ3hEfd/P4mmv3J9CJmpdNxdI=;
  b=Ct6GtD93V4XIS3mqvHKPpCDfG1gf2Bid5J1vUo6O+8aiB/B1YwTwSKBy
   VBBlMett8/NlbFrYaE60l5YBZ1ARE6OKNbCtUxLDECykgRXBkNNlewaJn
   dWdCmJLh2AUqdqs+VopX33UXSzmGLPxn2X46Gw3+UMWDKBB7u9omXhlZW
   GvNB54bDg142lO3K3nis4pgY6hk/yAIvC7Ya6cGPCvX/hPfsEQEArHUey
   t9JNp/tb+KbVlwjXU1zrNh58hAgpjVfift6VGjloxJPvemDxQpg6C1Isz
   fbLMIPToDkNYgs+jSR8KDvdVEkLjJoXl75jUS0i8S8dkuLIlltMJnHCLf
   A==;
X-CSE-ConnectionGUID: UiDQCeA/QW6I6TNzyFfXCw==
X-CSE-MsgGUID: iCfGvwiIQsKjl7vb1ykOwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13602111"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="13602111"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 19:30:49 -0700
X-CSE-ConnectionGUID: akTOCeprSTeZHBC3xPMfpA==
X-CSE-MsgGUID: pV7fF9ZEQPGAxpT5kLZD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74675064"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 19:30:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:30:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:30:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 19:30:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 19:30:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2N+x1NVnrqJJpm2JDfaZRjJ/hidDjnU6X1wMUwrI9gye/ONQ/U+rJ24jZuUjBV0dDtqk29zsUXpX0YvG24BRJYYtEhGRXhCu4fycoNFHKzBKRFJ0xuWhNrso65CwnXc3mWYiV57jWMb4QwLaNvK683S4HusgwVTTAkUV/fkhppqEG8LYFVn/02S8nS+qk8nS9KuzNPcxd/gCEfZNfeL7q4rQcNVVcvaOuJaJ+VdlaTNuUPuVPZsfTTWPEK/U2jJSsD3ygY4APiHzkTBv3/PwPRd/j3S4D8KteuUMVCarNVJbWlZN8hWgWxa9J+VeA9mw/VWdYwg3Z0HHVaQNd8XjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXlg95Wq8PLyHV+t6sVQ3hEfd/P4mmv3J9CJmpdNxdI=;
 b=v0r4mDuX3MlOXiXi+eRYfytl3xw3H+QbIUBnL9JMEWv73qkQEVuHyRTwAx7/rjNKkXxWFBZI6cKMiGOk5+khtOPiHLut5dQgNYjZR0H/ZwUCj6q8MLly/uQeAs0iLZil6QDLSP6+X7gWj98iin4d1q0LD/3FgWjHZqcuetpUamb2J/EOANSz28KKxaFyFAE45Wv4jktG12wZsC21L6vxlxE9VNVMDmxfmrkYut7cVZ6cha/oaEOx4mJcT2yd6uDOA+MCt/ZopZDsk3oJ3tMA1oyOuibgnJSXZANifTaT0jHKqb8NC3yldJ2bv7/vLEkwYcYeihJoHagRhMnCcv8hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 02:30:40 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:30:39 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+lo8ysIDIejPvUy4b6yFKhIRqLI+1o8AgAAPzYCAAAKegIAAA06AgAACG4CAISZMUA==
Date: Fri, 20 Sep 2024 02:30:39 +0000
Message-ID: <SJ0PR11MB567817BD31202F651F181B76C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
 <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
 <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com>
 <CAKEwX=Mz_tmU1Qjm8ExfnmCVvkNcd2cYpcLQLZBBx0QCXJvOpA@mail.gmail.com>
 <CAJD7tkY9SQ3NOukRY3Zh9ML4yyN-zC0krNkpoUzeCd5tyE1Zgw@mail.gmail.com>
In-Reply-To: <CAJD7tkY9SQ3NOukRY3Zh9ML4yyN-zC0krNkpoUzeCd5tyE1Zgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CY5PR11MB6319:EE_
x-ms-office365-filtering-correlation-id: 666a08ce-03f9-4703-d6e3-08dcd91c37df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?clBVK1pPV3dqYUVPNTdnaWdVaUpJUW84WnNKZE96dGxiK2V3RFN5ZEErc29l?=
 =?utf-8?B?VGt5OVArbG0xdzBKcGJuZm5LaFBOZDJUeDRqNDlqcG9lTENHaEh6Tk5XRTBl?=
 =?utf-8?B?ckJqYUpSdHdFSFNQbHRMR0xOalFtY1NiU2FkaFAxOWU3Y09TUFA5d05LVW1l?=
 =?utf-8?B?Z2VFeXd6aHVoM20yVnMzdGtEd1dQTjkvaEV5NTR1N1l1U28yK211V1VCWU1E?=
 =?utf-8?B?cjAwT0FOam00WmJTMUdwZFpHaENXbGQ2MjVndmx3b0pKVmVGZExuak5HVzNh?=
 =?utf-8?B?dHVhbHowYlkwM3djL1p0QW5lSnBWbTRNRXFIQkszUkVncTJZdlRVSVc0cDcz?=
 =?utf-8?B?cTh3VW9FL29RNnBJOTVQNzF0ZGlWblA2clFScmF4SFZ3MkxmTlZ1RmVWNjIz?=
 =?utf-8?B?aXZGT2dHVi81b2VzZGtCU0pPTTQ0U1J6enZjMGphSnFrR3B2aFpvbHVjdlFO?=
 =?utf-8?B?cDc1Wm5VMVZtRlpzVXoycGVCQ0pVUE01WmdiZmhxZmR0NFAxZDdWWnVPaFQz?=
 =?utf-8?B?YjVIdUxxZ1hVUlZsdzBpKzdYcmpUQ1ByOWlYc1ZydllhZm1QNnVRNzFzTDhq?=
 =?utf-8?B?dHRRc3ZFSmxpalhveERGV2lGSno5bjVmbEJUM2xTNGR4OFUybVlobXBaQ0g4?=
 =?utf-8?B?dENKK2JWeGVoL1duSWlrejcwaFRlWnFhZG93Sy9rSlBHaG8vTzNWbU1VMVJW?=
 =?utf-8?B?V09zTTVMM3NvS1VRd2t4NjB5TU8vMnd2ZExycXVieVRsZFl0ZDJocXRYSlRW?=
 =?utf-8?B?SlE0SEtSaHBzRThrVk5jbCtlL1RDeEM5UnJKdG8xV21QWGNWNHdTMjVrZUQz?=
 =?utf-8?B?ekVPZERvRFhTcWF4WWoxeE9iM1lDUStDU2VzdjYyaWFNZDYxRDhJSG1HbDZn?=
 =?utf-8?B?bjVONzZpN3JMcnk5TmpCdVVGQ2cvVWhPeGZmdEs4RU0yQ0h5RWU1ako3ZkNz?=
 =?utf-8?B?SEZIa1RCc0g4NC93d0t2Zi9UNit5REwzVHlRa2ltNDRrWU1nQVlmY05Nb2Nu?=
 =?utf-8?B?VGk0U0c3NzhiVjJVTlpYS0lCWlowbnpKNGd2anNNS3A2N3JGRStYZnRaL3lz?=
 =?utf-8?B?UUlBZlRyZzlmN2kwclVoL1Zid0EwRC9XanVTVUNIWVNwTHpPdXVBL2d0M2VS?=
 =?utf-8?B?NHlBUi9CdkxUM0ZvSENBM3htT24yb1NMM0VXMVphQ1d1TlR4aVJab04rNXVD?=
 =?utf-8?B?d0RUczJ2aFQ1MHFTY1QzSmF3VFNFVW9HVmVWbUF2U1owcmtDNGVhZExRcy9w?=
 =?utf-8?B?V1p2V3F1RXAyOG80YkJqQkNqYWVIL1RLNmVwWFhjK2NmUkNuQ2MrVEVqRlRV?=
 =?utf-8?B?OFQzVlQvaHpjZUphemtJQVg5WUs5VFNrcGhEZjhkZklXdHpwQ2o1d3JPeU52?=
 =?utf-8?B?NzVURzhrMG9aWUY1VDJSMnpnUGdnWFJ3aGZXRkJvSzQxYlgyeHBTdDFOQkpS?=
 =?utf-8?B?YzJYTks3Tm4wTXFBcWxEMDhERkRwZVppYTMvc2oyWmhMTmcyb2srQlk5ZllB?=
 =?utf-8?B?SnBoalVSa2lwUkZUZU45ZXE0UzZkR2VZeExXRnlLZW4rTTdZVmJUTjlOelNG?=
 =?utf-8?B?VEtBSmlzZkdyUldxS0pFRjJ3cmR6SzQvUC91YXRsSWM1YUlRRGR2UEdHRlJs?=
 =?utf-8?B?VFl2bWc2VVh1WEpTTm1ibnZETTFFYWhjV29RdE4xeEFaUWFMcmJKbXN5QWhI?=
 =?utf-8?B?NjRDUlp2VjhhcVoxUEFSb1V4bVBTdDE5SUMyeFd2MDJ6QjNZbUZGZW81R1hk?=
 =?utf-8?B?WXY2TUdXSkdSdE56QTJDZjZNZ1NQL1dadEFsSXhUWG03ZTRucTl2RXFkcnJn?=
 =?utf-8?B?OVFTdVVpT3F1Q1Z6QjByck9Ca2tjdFlQaGRpcEJTdVQ4NVhnd2FjZk11Zkdz?=
 =?utf-8?B?UmgxZmZJbnJlMEdpRTJza0RyUFE3ZmJWdE8zSkFpaGFQMGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU9yUHZGZGNnVXd3clg4MUNJZmRNZXB3Ui9YaVZvRmFnbzJFa2JzOFZhcGdx?=
 =?utf-8?B?bzBWZWRqMFNvRiswd3p0SE5KaHlxaDFqUG9qWDVsa2VoY2Rubi9kY0RTR01t?=
 =?utf-8?B?cWVwaHYxZU5nUVJ6eUpwSTR4bUlQazdIRm9mN3h4Y0Zsb2wrNDFIdjIwWTZL?=
 =?utf-8?B?aUJpQ1JuOFJOQW4yRUdaQVBEcThQZ2ltaVZmbzBKUTZsZ2tWY1Jlb3FVcmd4?=
 =?utf-8?B?ZktLaUUrS3NoZVFnUFRhWWtRZVNVdzlSMEFqU3BYQ0Rra25XVnBDd0VsL2tq?=
 =?utf-8?B?Sit3QjJQU0c0WEEvSWo4ajBjNmVHNDduOGJpdUhBbUtXWGRBWm9RUmhKNUFV?=
 =?utf-8?B?blZWdmRhRmx3Qll5RE9zTGZnNVFpeGo0eXBuZDFYWTY1UGVQTVo4b3BaYmgw?=
 =?utf-8?B?RFhYY2dla3diUzhFbWNESWFyRGlzT1BCaXUxQ1gxOXBVLy9oTG8va2NWcGRt?=
 =?utf-8?B?a1d2MzdNRkFVZXhJbHRUeW8vKzVVVlhqb2JoTjNYU1FiVzhYbFY4a2tBNE9h?=
 =?utf-8?B?MGZzSDU0c09GcTV3TzVLUzRBc2UweE5PRGVhTWJPRVhaeE9SSlB5blV0Z0lo?=
 =?utf-8?B?eVpqR1lWTnM1YmorVnA1TTVZMWVJbjB4a3QxeXk0UG1BMmVNV0dra3EzNXBV?=
 =?utf-8?B?Sm9JWG1ocWlJT0JTYnVoZTNTdTVRZWFCM3lZb2svUVdlQjlkSDBiS0VrZkU0?=
 =?utf-8?B?NW1RRGdQeXB1aE5ZYUduVXBlVXZyRkVXTnFvb1NYb3VsTG5SZE02R2tsRVRj?=
 =?utf-8?B?dkh3ekVNdk1GQm9NMkhsSWZkU3JPWkVzSTBDdWpRV0VOY1VmSld1bTNXRG1I?=
 =?utf-8?B?QzJadTltZWtFaVFEZU10aGR4M3J3b2NXSXFDb0dyMGtCKzJzTmJvcExxRTV3?=
 =?utf-8?B?OWJWVmZPQU9DWUx1aDA4b1NZZDVFU2lob3JHVE02dGsxT0hzYmNJZ0tqdjZX?=
 =?utf-8?B?NVZQbmZHWWZiYno5Y0VCQXZWU2ZpMEt4elpwbDlaa24xMVFHQnlEYU01QWk5?=
 =?utf-8?B?alNyZXNFcXdIaEdMdXNOUU9UMFBjbjI5dWJZM2pLMWplMEkvQ0FyY2cvaXNH?=
 =?utf-8?B?dktxZDZUWndmVzNucXNJY3FWck9CTjBETkdYNTNTR0c4enRhNlhlSEpQbUM4?=
 =?utf-8?B?UkNTbXErRm5qYm15RDhNcGpIWWRYL3YyZ3BqV2o5dytwM251M1NCSXN4K0wy?=
 =?utf-8?B?aDU5THYwWVZKWmdibzUrWk9uSWxLZWNOV2tMRXpldVpJdThFc0NsVU5iV0pa?=
 =?utf-8?B?RGhEU2JkNFdMa2RYaGxtd2g0VkZDM0NRcmJEQ0ZQTDJHMys3VlFmaW1PbXdY?=
 =?utf-8?B?SDVjTEh4RU92dDkrSW1PZ2ZYaFNrTmpxdkhCRTJqK0I1RTg3UzNOczJNUlo5?=
 =?utf-8?B?UlVhcU5wYzB4SGd2TVF2c2dIRk40VEI2NTBFNmRDdXA5Y0h4Z2tRY0JwdDZ2?=
 =?utf-8?B?MGFJdG1GR2c1RkcvUzhhVkxzUG9KSVRxblcwdnV1OFMvN053VEQyc2xqNGQw?=
 =?utf-8?B?WnZaUis1WTBnZDY1cWlqZUpkeS9oTTNlM2pRbXRVNVFBR055RFVkdzEvSWFR?=
 =?utf-8?B?RmViYmJ0UFkwN2RaMlhxOVpHWHVwZTB5REhid1ZIL1JvQTAzVVVsTnZocVZw?=
 =?utf-8?B?QndJMTVreG5RT0xzejRZRElrN25kYjB1SldjZ2RKa3NjamQ3endSUGxjUFZj?=
 =?utf-8?B?Wm85UXFnT01GaEdVUUpOZWRNVkdaVEQycDJ5SDJNd0g1TUdUMG9QQWF6Z1pS?=
 =?utf-8?B?ZHdROSs4dWdpRWppVUJVWXR1eTh4MG1aeUpQQmhheFV6cGpXV1JsbnNxKzFy?=
 =?utf-8?B?bFg0M21YTlp3OVBZQWcydFExb0JjOFJZRnRUNXZ1ZHJNejc4Wjdrb01RdUZZ?=
 =?utf-8?B?Ykd4Mk5WZnlGZ0w3azNDMjFTaUx1eE9IVGdjR1YrOGNtQUV3eUcxOFlrUkZv?=
 =?utf-8?B?TVdJZUl3ZWtmNDYzcU1CeVZQWCtCTFA3ckduRG1MbnBKekVxN2ZFN1MxclhR?=
 =?utf-8?B?eFZWZjFKTzdzTFBvVTlBYTNraThWM1JZUnhYNnBkaEIreUdqdDlWQ3BlK21B?=
 =?utf-8?B?SnFJN1ZSdkJiWWhRMkVlakxQNkJVK3dtSTdVTnNZMWxCbWFsUkhmSEtMTEhp?=
 =?utf-8?B?K05BUWphdmFwVndLSHRtTXlsL1lKbmRhc3BuU1NubU5OeDZlSkl4MG1PMUxl?=
 =?utf-8?B?dlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 666a08ce-03f9-4703-d6e3-08dcd91c37df
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 02:30:39.8908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjYlvJvZ8Q4uQhfdw2MKDbB5BLfMf8F0UzKDg5eF18NUgpLsfTghKIxsc5VDEbF1l75t7dRKIogRx2Kz8LZyC7qz9SCElXdiBYdjUc9ieo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjksIDIwMjQgNTox
NCBQTQ0KPiBUbzogTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT4NCj4gQ2M6IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBoYW5uZXNAY21weGNoZy5v
cmc7DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNv
bT47DQo+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBab3Us
IE5hbmhhaQ0KPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLIDx3YWpk
aS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsNCj4gR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwLzNdIG1tOiBaU1dBUCBzd2FwLW91
dCBvZiBtVEhQIGZvbGlvcw0KPiANCj4gT24gVGh1LCBBdWcgMjksIDIwMjQgYXQgNTowNuKAr1BN
IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCBB
dWcgMjksIDIwMjQgYXQgNDo1NeKAr1BNIFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5j
b20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDQ6NDXi
gK9QTSBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPiA+IEkgdGhp
bmsgaXQncyBhbHNvIHRoZSBmYWN0IHRoYXQgdGhlIHByb2Nlc3NlcyBleGl0IHJpZ2h0IGFmdGVy
IHRoZXkNCj4gPiA+IGFyZSBkb25lIGFsbG9jYXRpbmcgdGhlIG1lbW9yeS4gU28gSSB0aGluayBp
biB0aGUgY2FzZSBvZiBTU0QsIHdoZW4gd2UNCj4gPiA+IHN0YWxsIHdhaXRpbmcgZm9yIElPIHNv
bWUgcHJvY2Vzc2VzIGdldCB0byBleGl0IGFuZCBmcmVlIHVwIG1lbW9yeSwgc28NCj4gPiA+IHdl
IG5lZWQgdG8gZG8gbGVzcyBzd2FwcGluZyBvdXQgaW4gZ2VuZXJhbCBiZWNhdXNlIHRoZSBwcm9j
ZXNzZXMgYXJlDQo+ID4gPiBtb3JlIHNlcmlhbGl6ZWQuIFdpdGggenN3YXAsIGFsbCBwcm9jZXNz
ZXMgdHJ5IHRvIGFjY2VzcyBtZW1vcnkgYXQgdGhlDQo+ID4gPiBzYW1lIHRpbWUgc28gdGhlIHJl
cXVpcmVkIGFtb3VudCBvZiBtZW1vcnkgYXQgYW55IGdpdmVuIHBvaW50IGlzDQo+ID4gPiBoaWdo
ZXIsIGxlYWRpbmcgdG8gbW9yZSB0aHJhc2hpbmcuDQo+ID4gPg0KPiA+ID4gSSBzdWdnZXN0ZWQg
a2VlcGluZyB0aGUgbWVtb3J5IGFsbG9jYXRlZCBmb3IgYSBsb25nIHRpbWUgdG8gZXZlbiB0aGUN
Cj4gPiA+IHBsYXlpbmcgZmllbGQsIG9yIHdlIGNhbiBtYWtlIHRoZSBwcm9jZXNzZXMga2VlcCBs
b29waW5nIGFuZCBhY2Nlc3NpbmcNCj4gPiA+IHRoZSBtZW1vcnkgKG9yIHBhcnQgb2YgaXQpIGZv
ciBhIHdoaWxlLg0KPiA+ID4NCj4gPiA+IFRoYXQgYmVpbmcgc2FpZCwgSSB0aGluayB0aGlzIG1h
eSBiZSBhIHNpZ25hbCB0aGF0IHRoZSBtZW1vcnkuaGlnaA0KPiA+ID4gdGhyb3R0bGluZyBpcyBu
b3QgcGVyZm9ybWluZyBhcyBleHBlY3RlZCBpbiB0aGUgenN3YXAgY2FzZS4gTm90IHN1cmUNCj4g
PiA+IHRiaCwgYnV0IEkgZG9uJ3QgdGhpbmsgU1NEIHN3YXAgc2hvdWxkIHBlcmZvcm0gYmV0dGVy
IHRoYW4genN3YXAgaW4NCj4gPiA+IHRoYXQgY2FzZS4NCj4gPg0KPiA+IFllYWggc29tZXRoaW5n
IGlzIGZpc2h5IHRoZXJlLiBUaGF0IHNhaWQsIHRoZSBiZW5jaG1hcmtpbmcgaW4gdjQgaXMgd2Fj
azoNCj4gPg0KPiA+IDEuIFdlIHVzZSBsejQsIHdoaWNoIGhhcyBhIHJlYWxseSBwb29yIGNvbXBy
ZXNzaW9uIGZhY3Rvci4NCj4gPg0KPiA+IDIuIFRoZSBzd2FwZmlsZSBpcyByZWFsbHkgc21hbGws
IHNvIHdlIG9jY2FzaW9uYWxseSBzZWUgcHJvYmxlbXMgd2l0aA0KPiA+IHN3YXAgYWxsb2NhdGlv
biBmYWlsdXJlLg0KPiA+DQo+ID4gQm90aCBvZiB0aGVzZSBmYWN0b3JzIGFmZmVjdCBiZW5jaG1h
cmtpbmcgdmFsaWRpdHkgYW5kIHN0YWJpbGl0eSBhDQo+ID4gbG90LiBJIHRoaW5rIGluIHRoaXMg
dmVyc2lvbidzIGJlbmNobWFya3MsIHdpdGggenN0ZCBhcyB0aGUgc29mdHdhcmUNCj4gPiBjb21w
cmVzc29yICsgYSBtdWNoIGxhcmdlciBzd2FwZmlsZSAoYWxiZWl0IG9uIHRvcCBvZiBhIFpSQU0g
YmxvY2sNCj4gPiBkZXZpY2UpLCB3ZSBubyBsb25nZXIgc2VlIG1lbW9yeS5oaWdoIHZpb2xhdGlv
biwgZXZlbiBhdCBhIGxvd2VyDQo+ID4gbWVtb3J5LmhpZ2ggdmFsdWUuLi4/IFRoZSBwZXJmb3Jt
YW5jZSBudW1iZXIgaXMgd2FjayBpbmRlZWQgLSBub3QgYQ0KPiA+IGxvdCBvZiB2YWx1ZXMgaW4g
dGhlIGNhc2UgMiBzZWN0aW9uLg0KPiANCj4gQnV0IHdoZW4gd2UgdXNlIHpyYW0gd2UgYXJlIGVz
c2VudGlhbGx5IGNvbXBhcmluZyB0d28gc3dhcCBtZWNoYW5pc21zDQo+IGNvbXByZXNzaW5nIG1U
SFBzIHBhZ2UgYnkgcGFnZSwgd2l0aCB0aGUgb25seSBkaWZmZXJlbmNlIGJlaW5nIHRoYXQNCj4g
enJhbSBkb2VzIG5vdCBhY2NvdW50IHRoZSBtZW1vcnkuIEZvciB0aGlzIHRvIGhhdmUgYW55IHZh
bHVlIGltbyBpdA0KPiBzaG91bGQgYmUgb24gYW4gU1NEIHRvIGF0IGxlYXN0IHByb3ZpZGUgdGhl
IHZhbHVlIG9mIGJlaW5nIGEgcHJhY3RpY2FsDQo+IHNhbml0eSBjaGVjayBhcyB5b3UgbWVudGlv
bmVkIGVhcmxpZXIuIEluIGl0cyBjdXJyZW50IGZvcm0gSSBkb24ndA0KPiB0aGluayBpdCdzIHBy
b3ZpZGluZyBhbnkgdmFsdWUuDQoNCkp1c3QgcG9zdGVkIGRhdGEgdG9kYXkgd2l0aCBTU0QgYW5k
IGxvbmdlciBydW5uaW5nIHVzZW1lbSBwcm9jZXNzZXMsDQp0aGF0IHNob3VsZCBob3BlZnVsbHkg
YmV0dGVyIHF1YW50aWZ5IHRoZSBiZW5lZml0IG9mIHpzd2FwLW1USFAuDQoNClRoYW5rcywNCkth
bmNoYW5hDQo=

