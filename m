Return-Path: <linux-kernel+bounces-343178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A8989785
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C251F216CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35CB18593B;
	Sun, 29 Sep 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bP/dM5yF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012EE18132F
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643607; cv=fail; b=JGGkpHpAhj8xmhmTAPk6KQayMRUtBQ2qaLaOwmukooJ26TWvmfUohFspH2PhsXRF3SY9wZ/4TJfmk0Sg7ee9+lZznZ3yDMoB9OyiBw1MESQ22WRA3eyVHif42UzaCrKU6GF3nJxkOviGz0SABS7npvz8fgIRWLSWvX/WcEeeXSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643607; c=relaxed/simple;
	bh=FbWeSLmCni0bioT0+S7VPX+UOW3WzYergcnoc0zE8nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EaVhc2Nczt0n92Qe51hcriajM58Ngyw77Vd4+lrt9r+Zk3Afs4UdW9I/acHhINXiGDH1gUdW6N+9iJiiEIdfs1gUucij5ZGbt/Gx0epPYgpBrYdW2f50r19po9hS0HPkUK1An9z83xHe4DP9HAeYbu0e9gh3G5pP0MA23FbRjUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bP/dM5yF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727643606; x=1759179606;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FbWeSLmCni0bioT0+S7VPX+UOW3WzYergcnoc0zE8nw=;
  b=bP/dM5yFxpGFRTik/6XWFsLj9qGAWWiZOYh6DmcxrxcY+rD7gIZEGrrw
   s9BfzJE4FzZnYw5bqz+SaDjqBFSAtvRflpt14txPQv1Td/S6UP0YSsaIu
   lSoOexI1kbTHNRlIXoPuCbhc+ceareicqHmXW8L9hNytSX20SMIm4V92q
   Q2AuwvIxPsb54IAWpSiWG8lmRJSh4Q3T1+/xSC0G77D5LmenE8ClHE0mz
   uzYOX5Y+lk0/xo0qJWctS+TEJVzpa5eHSvCPaDWWcBitjHZFNqNVybBF5
   dXZfHTyd/zDta6baLngxQUNz2X93+nunpiWaJO1qFzH//98O0NZtVQk1k
   A==;
X-CSE-ConnectionGUID: 8JI6QvFGSBSaBjlouhll0w==
X-CSE-MsgGUID: gwHe6gE/SBy0ADP1rgHVgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26898686"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26898686"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 14:00:05 -0700
X-CSE-ConnectionGUID: SoImu9/YQqSTpVv/2MXGIw==
X-CSE-MsgGUID: Z8r9BngRRh6LCgYdLxFGZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="78039332"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 14:00:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:00:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 14:00:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 14:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLhmdosHTf+hVoWGuuOLETmBvPlm1e/wx2hLbPcEQctpj9p/qMvEWIpnkOxjHmIIZM70EDJ5yO5e7UQEXirDJhCoS1H3fykKc3aCiVpeQExdtkF+xg92WtkFSs0LwLFZ0ZaKjoOGGbE2WFThGd6z4rYfLCUmBuUd9OacqN7z9V/oiFqAXl+d7eZVYVz44QL63hjqnbr+Ulbu+1gfoaatfm4m+7pVrT14s4LkBv7s26Tt4W03si2yEFj5IM/97ALGXNqVzRDPSGH6zP9W3FeF4jYrZQnqQdywBIQVq4w/v1dlmz1rzPb2hzAPZ1rM6bQRf+i4IGwT//+7hvmcRE/3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbWeSLmCni0bioT0+S7VPX+UOW3WzYergcnoc0zE8nw=;
 b=Z/VUfgA8BgiuULU1gopn1PkhZfe59UYlDjdy2D2Uq0OSAcr/J+7NsV/ht2iOpmjLtlaMJxD+7dn+Xb8ifKJmjcOyzTf8GWq6aRfnXzKcusub8HNp6eQodYHD80nOvgD/sRPcvWSET4i1RPodstzckN8VP4lLBHVHhHVCFbO+0NdD0XPQyvYnWwDVgyr9cFUf05NJ0/JKSd+PMpo0AFpOd5S34i25WCGv83WjVKR2SlCZ+Kr4fQaSLI253lzHcThHxsaEOI51n2VfMsEUZwdrlX1IXmmXB+G7TB1vkpRWn5nK61v1oIQcJ2uehlYPBb0Aor81u0D3aa5lefR+HWvYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 21:00:01 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 21:00:01 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v8 4/8] mm: Provide a new count_objcg_events() API for
 batch event updates.
Thread-Topic: [PATCH v8 4/8] mm: Provide a new count_objcg_events() API for
 batch event updates.
Thread-Index: AQHbEUxtDUzi2O2tGkCYhQyIuKA3+bJsgwoAgAK/QeA=
Date: Sun, 29 Sep 2024 21:00:01 +0000
Message-ID: <SJ0PR11MB5678003F53A48919AAEAECF0C9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-5-kanchana.p.sridhar@intel.com>
 <CAJD7tkY_PG6vMwExts28Wa2+QcRYcLubbMfctjyVFv94yd9w3g@mail.gmail.com>
In-Reply-To: <CAJD7tkY_PG6vMwExts28Wa2+QcRYcLubbMfctjyVFv94yd9w3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB6967:EE_
x-ms-office365-filtering-correlation-id: 6b1a6fba-ce55-4393-707f-08dce0c9af5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkRKL0NldEE5dVRwNmsxSUVuL0c3NVA4SmFNRXd6T2g3Z3ErMm1GZnJSWWZT?=
 =?utf-8?B?THNXOURGV1hFQVhBTkY4OXNSMEpseUFTeWxQRGQ0RHBla1o5KzRodXU1OEdN?=
 =?utf-8?B?eXBJVkRMQ1JnVktyTkdnNXByV09OWkNZUldDMnYvOGNycXBnNGlweTBiQTND?=
 =?utf-8?B?ZVJXa2EzUjFPWWNYdGN1Y0dXUXM2ek02ZXRKMTdsVE9XK0N2R3dSMGp6cmJ5?=
 =?utf-8?B?SGdwSllnakJ5elYwN1l4WXZPUjZyR1lYNjZibEJIZ0Mwa3JOb3ZCZkpOcFA1?=
 =?utf-8?B?aWtkOE1NUm5ZSWk3eEYrQW1ZbHo5S0xRVC8wdm5tSWNhYkJDNUUyeVlCaEV5?=
 =?utf-8?B?M0pTTTdzYUFPcWpBV0xiWWJQeVN6QWhwNlFQVjRhRHE0TExHUmw3aVRDd0lD?=
 =?utf-8?B?TWVJanE3WHdkNDV4V0JMUWQvdzhyc0FaLzRzbmFta2Z6bDVJS0RxaVkxN1hI?=
 =?utf-8?B?NFJWQ0xjR0QxSTE4ZEcyaUZreFVoU1JxOXBFYW1Tb3dwSnl2ZDdrN0taODdi?=
 =?utf-8?B?TFVqRTFOY0JobkZRNGFKdFZUS3NDVmh6cElpTnArSDhIYUhkK2hTYjJKUVJQ?=
 =?utf-8?B?azBYTkZKcklESHVwWXdvSFhickJVQmRKN0Q2SmRCcGhPQWVzakxkQkF5RUFm?=
 =?utf-8?B?dStMdlpUM0phanZ3NG9rQkFoTmRMMkJjL3RBZC9PTGFXVDJzZisyRjJnQjEy?=
 =?utf-8?B?MlVTa2djb1dPVEc0YW5kcUU5R1YxdjVEZDM0SXhGM3hScWVZZDM1eW05SE9l?=
 =?utf-8?B?Szl2YUdWQTI5RXFvOCsyNS81dy9Zcno4K3k4UEtiODN5M1JwNS9pSlRiTTRi?=
 =?utf-8?B?bXI3U1JBSGNLUkMyR2NYa29ORWp2WmJQVm82TXRkN2c3UWt5N3hRZFQwRTMx?=
 =?utf-8?B?Q0ZJVzBGb0Z4OHVnaHJLV2laRHlDVjZiT2hsSXY1aUpIOFdHVHUrQUR0S3Ax?=
 =?utf-8?B?d1hpU2taVEhUcWZWUlRZbHFha2pyT2V1N0RDdFZwS3kyM1gvRTJMN1l2Qm5z?=
 =?utf-8?B?TVo0a1lwTVg2MTZSRjNySFMxdU9aTGJkOHRUMHloUG1QQWNURThMT1VmcXB4?=
 =?utf-8?B?RzZYdEJMOW9La2lQSHR3VXc4aEdDTCsrNmxTUUxuQ2krblJ6cEZ4WTJheUht?=
 =?utf-8?B?OFRZdmExMXRuREZpOGtaRHZMUG9MME0xRDlsMThRN1lxS2xXZy9FaG1UenlY?=
 =?utf-8?B?WDhKSFYzOWFpMkRmR3I4MVRybTlWTlV0M0ZkK0FTdS9EUi9LODZTakJXWGVi?=
 =?utf-8?B?cTRKK2ZkWXRiZS8wNVlyRmorTEJJdWMzMFY4WkoyN29yOWtqVUlzRThEazlt?=
 =?utf-8?B?cGh2T2xoeWRBeG5pNDZrOEgrYmlMU1NuZnZSZldhaFp5NjZWYlBxbUV6S29H?=
 =?utf-8?B?N1Q2YXRTWnNtVkh6ZmptTDdMUFdtTjY3dkNjcDBsSk92d3JaN3NReFhjUm9P?=
 =?utf-8?B?dC8rQjFxMWEyWndScWk2aWlxUFNCNjYxU0NCYU15Mkh1VnZpUitqQjA2eUYr?=
 =?utf-8?B?YUFWaVc1TEFWSE9JeVVGdytzWm4wVWhSUUo1QmJ1cXZ0Z2poZ2h0VEVKRDlH?=
 =?utf-8?B?Vmw3eDB0eGdXckN5RUVTekxHb3B5eExESk11MncyOFpySjdBTENWcmduMDlt?=
 =?utf-8?B?YWp5VU9DYWRYZ0RMUWVzSjQwR0VrQ25vT1BWMm1tOGdZMktCSm9ObGdiT1By?=
 =?utf-8?B?ZnRveURUQ2dLbkFSUUNQOUtCVDUvc3R0d3plUEZjcjlBSUdjTEp6TVFlWGNS?=
 =?utf-8?B?REN1c2ZDd1N6bUxub3dWV1puZjdBbXZvVjFoaUt6Wk1LRXMrY0tORU9Wd0M3?=
 =?utf-8?B?bXVqekxqUkxQZGZQK0syZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFMyQ3hyUXNzUTN5bzVmRXYwOCtXTlJPTXkrU1RNNXJKblptVWdqTUJoWUw0?=
 =?utf-8?B?UlZ0dlJOQ09TMFVWT1YzdW5aSHZwVWhWcXpITDZEYjFJQzIvd3hCb2pnTU85?=
 =?utf-8?B?Rm5FKzhBK0xSaE5QKzFWWmQ0U3o1NmVCSVMzUDJIOXZCMUxhZUNsb0taWXlN?=
 =?utf-8?B?Z2VRdHp1eHh3di9HUFRyVFBFMHdKVEJlZjAxMVYwOG9zcjhjQmNZd2l3TVFq?=
 =?utf-8?B?M2p0UXFzYWMzWHp4RnlqMit0QnZtaXVoT1l0cTRMRkQxY0I1RUJLZU1FWjZG?=
 =?utf-8?B?Y0xQVnRyVjE4QTZveDBkRzNpTjQ2L2pYVjZUZktPQ0tyNDA3aUw3QUVpZURQ?=
 =?utf-8?B?MkV0aHRCL21vYStLNVAyQ2d2Y1hLWmZ0QlNkVWJ0TEhLUTNqdzJoV1hheFoy?=
 =?utf-8?B?dlNLSGpKYkRiaXR0UFN5ODc0bmM5V0Y4Rkx6MVhTUXhDTlJjcXFhTnZKbk5t?=
 =?utf-8?B?bmlSRjh1dTZudFNaSzdtamdKMEV1TXc0S2ViSTNjTkxRM0JqTXlvSjRoUlM3?=
 =?utf-8?B?bnYyL2tMOTU0dGZFcnhvQVR4TXJyY3lNRjdsRno5dnJINlBEV21kQUdFNGtq?=
 =?utf-8?B?Ry80cks3eFdsenNXL3dWNnFwSVV4Yit6ZG52VEMyd3hTeVpYb1JsWm0rcmIr?=
 =?utf-8?B?THN4enFyV25rTDVMZG5OTTZjbWNPRGhuNmVpV0pGbGFnTE12NEpUa2N1ajZS?=
 =?utf-8?B?SHhiZ1B1TENQOG1sZXRkaWFZTncwQmo1OUd2ZXhMdGZIWUpiS24yRDhodWI3?=
 =?utf-8?B?K1VrYlNJVFBjNFROMFhpdUZUelZUTHFHbU1ISFZtc1JiSnB3TElWbG1NQ3dT?=
 =?utf-8?B?Vk4wYlJWUzZWY0tlNHE2clNlL3BRdlBkQTAxZitZaWRoYTZ1YUUzbjJ3bXAw?=
 =?utf-8?B?MitVWFlYemUzY2ovWmFKR0ZSZGhwcld5MWdXWDFrSmM2MHNWMFJmZ1A1OHR6?=
 =?utf-8?B?cjBhZVV6TjYwUzUrSys5QldMSTRZWkgxV0dzZUlucGJDdTRJcVliZGRreXpx?=
 =?utf-8?B?WEZyV0NxeUlUWVlFSWpkYTY3djFSY0VKY3ovUm9hOWNJaHZCQ2VNd1k0dUUw?=
 =?utf-8?B?QjFnQktOcm11SEl3OVd2Z1hFYytaaUdUOWEyc2NUbnNPaUtXbFJYenpGcW5O?=
 =?utf-8?B?amtEeGVZeTJQbGM3TUNkaGFIQWh3Y0RNcUZsVE8wa3k2TlJtV1I3R2RvVStG?=
 =?utf-8?B?Wk4vMDRxVFdjNEtURFYvaXc5eEt0TGluSDF2Y3NTcm5TeXM1Vk1iMHk0dHBN?=
 =?utf-8?B?NzRqRVVqZ0lxNzl6WGJ2aWZYQVpUdFNUZy9FbG51UndLZm5iNCtjYldWaFJx?=
 =?utf-8?B?YTJVWWszK09FYm4yK1JqWDBna0dsUEJRSk5HV3lCclVhWCtnSHg3NTdaWElH?=
 =?utf-8?B?RXE2ZW01ZXJFMlJYcStjWk1Mek9QWGVYM2I0YTFMYmh6c3NXRmZWelpTMTVp?=
 =?utf-8?B?QVJhZmZZVXBJcUI1cExlTFBRRy9GWnZSOERMUnEvWXFMcGVyTENaZkpPdkdp?=
 =?utf-8?B?NmZFME1Pdmg1YTA5OVRVeXJKSkRyazhaVnhRRmgxakd3aTBhRE9jS3E3S2VK?=
 =?utf-8?B?NUFMVmtWVUVzSm14ZGVZcHVZOU1qWWx0dFRDamZCdmROWmRmVnV0blpsdGhq?=
 =?utf-8?B?Y1lpNmhmR1Y3SE1CTm1MYTdXbDg4MmNUK2N0QVVoTDlheEhtVGpmdlJJSUc0?=
 =?utf-8?B?ZXFBekJuSEcrclU3T0ZiWTJqMWlPRTJ0QmRKaXNCNDIxQXkyM1dIUUgvUHA0?=
 =?utf-8?B?SmVjU2oxamlYQk9GazkzRUdneHZrbkdIQ2o5Mk9IRmRYUEFMTmtjSXZ0K0sr?=
 =?utf-8?B?TkJLdUZTcDVqVm00UlVxSUV2cGY1Yk53b2RQaDgzTElGdFBRQ1g5Q1pKcDVP?=
 =?utf-8?B?RjJYcmtoNkR6bUw5T1FSSDZ4eGJDeWFLbXRKUjlOMisvNFRRV1dHQllBWDBI?=
 =?utf-8?B?Rkc3d0c2bXVsNDFEczNtVjA3YlMrcU0ydTdGWkg1ZUdIbmpmcWZSUEJSRGdX?=
 =?utf-8?B?MURleS9SSnI0VXZLY3JRWW9PTjZSQ2Iya1JOaWcyUGJ1cENaYUZtb0w5Z3Jh?=
 =?utf-8?B?R3prSDdNUUZhY3hyNEI0UHpRZXhKU0dJU0hBTWhDT1Y2bGhPYWZlNUdVVzBD?=
 =?utf-8?B?dm9DY1VvUmQ1bVVvV04zeGRmY0U0L3ZPcHNtdW1Gc2JNYjRrWDJ4VEtaNnZz?=
 =?utf-8?B?Qmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1a6fba-ce55-4393-707f-08dce0c9af5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 21:00:01.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9tC/peZdF98O7/IB63TJY3y31Kvr/canvkZYHeaolBxV7cV1vg33tinc5eZp40zIBYJRNlnOTxySOCqq6WtthGdIH8MUKJhzd2uYosxYUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyNywgMjAyNCA4OjAy
IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2su
b3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IG5waGFtY3NAZ21haWwuY29tOyBjaGVuZ21pbmcu
emhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHNoYWtlZWwuYnV0dEBs
aW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiBIdWFuZywgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gZm91bmRhdGlv
bi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRp
IEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGgu
Z29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDQvOF0gbW06IFByb3Zp
ZGUgYSBuZXcgY291bnRfb2JqY2dfZXZlbnRzKCkgQVBJIGZvcg0KPiBiYXRjaCBldmVudCB1cGRh
dGVzLg0KPiANCj4gT24gRnJpLCBTZXAgMjcsIDIwMjQgYXQgNzoxNuKAr1BNIEthbmNoYW5hIFAg
U3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBXaXRoIHRoZSBpbnRyb2R1Y3Rpb24gb2YgenN3YXBfc3RvcmUoKSBzd2FwcGluZyBvdXQgbGFy
Z2UgZm9saW9zLA0KPiA+IHdlIG5lZWQgdG8gZWZmaWNpZW50bHkgdXBkYXRlIHRoZSBvYmpjZydz
IG1lbWNnIGV2ZW50cyBvbmNlIHBlcg0KPiA+IHN1Y2Nlc3NmdWxseSBzdG9yZWQgZm9saW8uIEZv
ciBpbnN0YW5jZSwgdGhlICdaU1dQT1VUJyBldmVudCBuZWVkcw0KPiA+IHRvIGJlIGluY3JlbWVu
dGVkIGJ5IGZvbGlvX25yX3BhZ2VzKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFu
YSBQIFNyaWRoYXIgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4g
IGluY2x1ZGUvbGludXgvbWVtY29udHJvbC5oIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L21lbWNvbnRyb2wuaCBiL2luY2x1ZGUvbGludXgvbWVtY29udHJvbC5o
DQo+ID4gaW5kZXggMTVjMjcxNmY5YWEzLi5mNDdmZDAwYzVlZWEgMTAwNjQ0DQo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9tZW1jb250cm9sLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21lbWNv
bnRyb2wuaA0KPiA+IEBAIC0xNzc4LDYgKzE3NzgsMjEgQEAgc3RhdGljIGlubGluZSB2b2lkIGNv
dW50X29iamNnX2V2ZW50KHN0cnVjdA0KPiBvYmpfY2dyb3VwICpvYmpjZywNCj4gPiAgICAgICAg
IHJjdV9yZWFkX3VubG9jaygpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSB2b2lk
IGNvdW50X29iamNnX2V2ZW50cyhzdHJ1Y3Qgb2JqX2Nncm91cCAqb2JqY2csDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIHZtX2V2ZW50X2l0ZW0gaWR4LA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBj
b3VudCkNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnOw0KPiA+
ICsNCj4gPiArICAgICAgIGlmICghbWVtY2dfa21lbV9vbmxpbmUoKSkNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuOw0KPiA+ICsNCj4gPiArICAgICAgIHJjdV9yZWFkX2xvY2soKTsNCj4gPiAr
ICAgICAgIG1lbWNnID0gb2JqX2Nncm91cF9tZW1jZyhvYmpjZyk7DQo+ID4gKyAgICAgICBjb3Vu
dF9tZW1jZ19ldmVudHMobWVtY2csIGlkeCwgY291bnQpOw0KPiA+ICsgICAgICAgcmN1X3JlYWRf
dW5sb2NrKCk7DQo+ID4gK30NCj4gDQo+IEluc3RlYWQgb2YgcmVwbGljYXRpbmcgdGhlIGNvZGUg
aW4gY291bnRfb2JqY2dfZXZlbnQoKSwgd2Ugc2hvdWxkDQo+IGNoYW5nZSBjb3VudF9vYmpjZ19l
dmVudCgpIHRvIGJlY29tZSBjb3VudF9vYmpjZ19ldmVudHMoKSAoaS5lLiBhZGQgYQ0KPiBjb3Vu
dCBwYXJhbWV0ZXIpLiBUaGUgZXhpc3RpbmcgY2FsbGVycyBjYW4gcGFzcyBpbiAxLCB0aGVyZSdz
IG9ubHkgMw0KPiBvZiB0aGVtIGFueXdheSAoMiBhZnRlciBwYXRjaCA2KSwgYW5kIHRoZXkgYXJl
IGFsbCBpbiB6c3dhcC4NCg0KVGhhbmtzIFlvc3J5LiBUaGlzIG1ha2VzIHNlbnNlLiBJIHdpbGwg
aW5jb3Jwb3JhdGUgdGhpcyBpbiB2OS4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gPiAr
DQo+ID4gICNlbHNlDQo+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbCBtZW1fY2dyb3VwX2ttZW1fZGlz
YWJsZWQodm9pZCkNCj4gPiAgew0KPiA+IEBAIC0xODM0LDYgKzE4NDksMTEgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGNvdW50X29iamNnX2V2ZW50KHN0cnVjdA0KPiBvYmpfY2dyb3VwICpvYmpjZywN
Cj4gPiAgew0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSB2b2lkIGNvdW50X29iamNn
X2V2ZW50cyhzdHJ1Y3Qgb2JqX2Nncm91cCAqb2JqY2csDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBlbnVtIHZtX2V2ZW50X2l0ZW0gaWR4LA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBjb3VudCkNCj4gPiAr
ew0KPiA+ICt9DQo+ID4gICNlbmRpZiAvKiBDT05GSUdfTUVNQ0cgKi8NCj4gPg0KPiA+ICAjaWYg
ZGVmaW5lZChDT05GSUdfTUVNQ0cpICYmIGRlZmluZWQoQ09ORklHX1pTV0FQKQ0KPiA+IC0tDQo+
ID4gMi4yNy4wDQo+ID4NCg==

