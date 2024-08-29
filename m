Return-Path: <linux-kernel+bounces-306059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D669638A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200F01C247E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90947A76;
	Thu, 29 Aug 2024 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmjbHzyP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3688738DE4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901043; cv=fail; b=XbXH9NwotzQyHNRBqNr/kpyaDuzqVSgqACSpyQ0lS19lZyogf31e4eY2pSQN3BQG98PgAeUM5RfZwYz0MvJxISBUDEYOpQZcQF2uOw43d1oA5q3PC9sgemm5saBJfNM3+/or/C2qY72+Due2ZLWeDCy4/frYFTkAzDOLrNLooR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901043; c=relaxed/simple;
	bh=YVnmjLqyQXbQfh0/0NTXFRo+2Fc/dlw2piBWA4D6YgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFHAypO9wQqisx1sSiLlRlAL+fDNOx97s6aN8U3etetp73Ppl0TtSI/X8XVUtjq/GFHmj9IRzP09zVvpIAs9lNJd+hmKNCNA61omSCOc+2504Zt7JHpGib2p5x1O+KZeyCH5rMo6NxHB3VRQ7MoYpEAU8qMnlqYhq27CyU9I770=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmjbHzyP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724901042; x=1756437042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YVnmjLqyQXbQfh0/0NTXFRo+2Fc/dlw2piBWA4D6YgA=;
  b=WmjbHzyP5Zj0AsFGt7+UvQxV63dIAG/9Rrypg7/NO1gDDmUgywCZLkeO
   qO3LKKwuvWjtSJ4WCJ2Cg/KBf1eivI0V31gcND1uJBeC6ogpt1Y8GTvad
   N5hFCbWArP1BE/cSxTeZEwr5HSgJ9U6ejyEI7M2XpZpQxYRoZ68DUJjMc
   Jsta3foZxviNGdqIeWH+2RZRn8xEkTOAvIo1gm+HjXpp4BvWbW1ULwP3u
   2n9pZ0PupReGj6f6/exepFKIZRridv4yF+8uOkXlul9MTjcSMG/OBsL8l
   qF6g4TGhR5rkihkTH6xwduZvq53qvjQINYsFk2IxyJPTDvKIM2d77Rg4x
   g==;
X-CSE-ConnectionGUID: Awsdqbv7TQaDlxZxSjQQKw==
X-CSE-MsgGUID: lSk8m0zuQwyeSXNi77fGRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23613122"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23613122"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 20:10:41 -0700
X-CSE-ConnectionGUID: RBD+7TlIRU+oamf7z/746w==
X-CSE-MsgGUID: /Fhqn1QAQVSIhkRla1qpBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63507797"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 20:10:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 20:10:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 20:10:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 20:10:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 20:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1kUpoi1WeBmesI9QWDPEpXhxjOkZHSgFpf/4Fi0Iok9uPrEGnyQOlDQRBI0JioIJbCklseDvO8KLTcSIX6wmC0zDvQZY1LcAponu+PTHkUALu7zMxDsgqggh3yXqXjofZYnHyA79+3WjvopdaN0AT0t9x8abbnB9N8zAvFSyniWgxNHUm23InztI11p1N61HhFZVwzQmVa5Hqsg39rJ2crPijmm2EPH2VAw0o3cWUKV/XWKPxsgLC/MSjRr8ak9g1e60N8cO5rhTHsyL1B6B2VfJKvhYfll7k6mhnsvsy72VXWhNdQTM7sTWyLdfVIj11TwmF342J7xJHrcdqh61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVnmjLqyQXbQfh0/0NTXFRo+2Fc/dlw2piBWA4D6YgA=;
 b=gihly50DUUY7oTan09zfXDXMFqgWEUjMtSf1h4kksTYiQPeDGhX86IZAwNJrieinKd/Z+hFIpd9dbRPY0srXcD9PKZrreWQZBxXdlopj2cFFLCx5NI4lRBArRL2SDfcmt1156vHpZV0AHuxTZik5NwWIw3RysXlFe3J1kY+axXyAvptOmTEI2jyP38kJkZzM4GjParc+fLjqjF1Wn8qkF+Pi3ntjNfq+Rle95p4Wq9sDlE6uUFFlmbRpvkJUa6VQq940R4NOTzbxEt1qkRkbhnEMRNCXfbe23oszpL6PhfjZ7dcHlGDrFgGHH5XwAxZ78SL/fejczfYf07wJaps4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 03:10:36 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 03:10:36 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, Chris Li <chrisl@kernel.org>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+S2hY1M67nGQo0+E71Bgb79m17I9Q10AgAAbRdCAAA0LgIAAIq5w
Date: Thu, 29 Aug 2024 03:10:36 +0000
Message-ID: <SJ0PR11MB56780CF8B669BE97DEAE8DCAC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZv3YnhxFo-rvHNB2_mro1+UuKOP69yXV8KmaeEz5F1mA@mail.gmail.com>
 <SJ0PR11MB567808155B93421F4EC004FDC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYBaHpJG8Uzo592cXYwNbzRJ0G8Ju71mkFA+T8uS3eARg@mail.gmail.com>
In-Reply-To: <CAJD7tkYBaHpJG8Uzo592cXYwNbzRJ0G8Ju71mkFA+T8uS3eARg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS7PR11MB6296:EE_
x-ms-office365-filtering-correlation-id: e901d9e3-06da-477b-cda8-08dcc7d82767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YVJueDl1UHBtbkVDZk4zMEJqN3ZMOGF6K1BPNVZBc1FXU2VWZi8yZ2pPMW1T?=
 =?utf-8?B?d0NIOXNiWHA4ZmExUWRGTGp5bjMwU3lPeGVjRG1qNXNJZU0rWjZVY0FsRExH?=
 =?utf-8?B?M0xDYlVEYTNydzI0ZlpJbDlEMHEwRGxZblpMamJKaDhydm1rVnltVHdRSXph?=
 =?utf-8?B?d1lTWXdMZXZNYlFWVXNuY0VYSHhxTy9qeUYyU3c3TmVKbDZ3UlkwNWpOWldO?=
 =?utf-8?B?V3k4czVzRVg3d24xa1RjWS9rWC9CZHB2bUIrN1Fxb3NvYzE1MjAreTlyekFj?=
 =?utf-8?B?YjZ0MUZkZFBKNnVJOHdvWGdKaE9tbzkxWkxPY2kxZlhwck5XWTU3c3hYWWtQ?=
 =?utf-8?B?VUdoY0Fyc2tDbWd3K3dEYXNIbU5Tb3QvTnI5VS85L3dRMzZ6OERLOEhkTkR3?=
 =?utf-8?B?T1JzcEtWWjZpTDBOeG54OTEyMlFzUTNFQ1NBRFpwTVRKNTVOVHRXdEZnemxV?=
 =?utf-8?B?WW9qOFgwc0t4WnhaTEtJRkpTcS9FZGxweWZjVGZpR3lBRDVOVzlRTlZ2Z1Vz?=
 =?utf-8?B?M2wzOXRLdXF2cEVXVkZOQXZqRjNaS2REQWtET1NTaG9TM3ZmY3g2WXZzYWtz?=
 =?utf-8?B?N0lLWTRtRTlyYXBGcW55UDdYSmdXeG5rWGRwbzJHYzhCUFJ4bCtuTUxKSTNS?=
 =?utf-8?B?cTNRZnZkVC95cjl2RU1wTS9HcklJeXdtcWJZaU1wRFpuQm13NUV1R0NVdmRn?=
 =?utf-8?B?bHE3bEZDenpoK0xCSkhyNUpzMElUanplY25CTFZ3cjRIVks2cE5jWmM5a2p4?=
 =?utf-8?B?MlZMbVl0N3YzcEkrbURJdHJONElEdHM5UUVWb2tOSGtPNVloNVdWNWdBZ2NC?=
 =?utf-8?B?dlkzVGl1YjlYd2NwdXpzWVQvZGZrTFNoQSsxUTFWam5KMVFvazlqcGZ2MTYz?=
 =?utf-8?B?ZFpzNU5IUWN2SS9UeldNT3NjM3NWVmFIaGpaN0IyMHF1cWtTREVINjdFa09t?=
 =?utf-8?B?M1c3TFh6L29FbUd5NzRDaFFmbVh5Z1ErcjVRelZ1ZFdOUEhOYjlXb3FjZFN1?=
 =?utf-8?B?ZXFCZ0dVZlhyZ2JDajlDTlEzVkZPdEhGTzNQREFPNDVFNENqVXg4WXY0NlVw?=
 =?utf-8?B?aUZnZGVndjU5Q1d0ZnFubjd1VHpYc251WlNIY1V1aHpFM1Uwa3pocUNPVUFL?=
 =?utf-8?B?a0NQMWoyeFQ0bzZxL0FOS1owdmlCU2tJQTFaSHNYZzB1S0cyNkI2YllFaWl1?=
 =?utf-8?B?dWt3bVNTZnkrZzNzR1JlSFh5TUl2ZnRrVXB3Nno5T3VFVEVZSktOMFBEajYr?=
 =?utf-8?B?Yko2blVHVlBlZWE0NENOVjdWU3ZZWXRoSlFuS1h0YURWY1hVQlNjaHhKK2xY?=
 =?utf-8?B?Vkw4UU5QUUFMaUZFd0czOWhaRTlrQ1ovcit1a2pVUVFmbWNIaTdYQkVTMG9h?=
 =?utf-8?B?TURDTWU5QjFxSDBBTUtyQVBPQi92ZkhRVkxuSnJvbU1ZWmFvZ21RYVFRRFEz?=
 =?utf-8?B?c3pURVhWZGQxOHo1K3lNL3h1bkY3UEQ4ejJLcXAvb1dPRWFFM2tRUUV3STZp?=
 =?utf-8?B?dE9MdmJOMVBJMkh3ZUp4K1NWUkpMYk5GNjdMWTdPNzg0QVdmN2dTSFh1dzZN?=
 =?utf-8?B?RWQ4am0xTFV3TkQzK1VPQjhpbnVOek1TWTMzcEVHc0tTTUJzTXZmTHlaS3By?=
 =?utf-8?B?MWl5VlgyL2t1VEkyQmZVTEUrQi9hV0VKRzk0Vlgydkl4WFlCdWs1UUpjKzQz?=
 =?utf-8?B?bk8zR21qeWFocHFFVXhnd2Q0SVlEVzZycWN5S3VhazZEVytMT2F0Wk5kdU1n?=
 =?utf-8?B?NG1XQkhmQXp6S0w3eWJmU3NDaHZYZmM0VWtGdnMvUE5lL1IrTVJTQ00vYUgx?=
 =?utf-8?B?N3hFWkNReW9POG1zTEczalBGYTlNdG9UVEcxRUlBaUU2WkY0a25NMm9HOHpF?=
 =?utf-8?B?bWVSRUZYK1NqWFgyL0ZKM3RmNkJ5Rm9nY3pWYnl6ZExHV0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUw2WGNTZzJobXFiQXgveEQ1R1M2NUxTYmN1V09wb21BaHZta2xkK2tHdWc3?=
 =?utf-8?B?bUFGUWdTZUdGOUY1UmZFUE1kQ1d6bW1jM2pNVXdTcHZEK1RCTDRmNkw4OUtB?=
 =?utf-8?B?M2p3VXlhV0trWGoyR1FkeWM4d3FyRHJMV2hwWUxwYmIrLzNMemdwb2J0ZDJJ?=
 =?utf-8?B?c05aYy8yY3lWREN5T1dQZTZ1a2hQWVhqZS9aV1ptVk4wK2pFSXptMFVZVUds?=
 =?utf-8?B?OHIyUVZaekVDQVRRK3poZWlCekJlUUVNb204ZFlZMzIrWi9SREhyU0J3ZnZY?=
 =?utf-8?B?cDZpeUpVVDIrQWpvS2pNYlkwWERCTkpHcUdrVTZyRjNUMFVzNUxFazhGQnZu?=
 =?utf-8?B?dk5WZ25WM0FNay9yMjQ3ck5iUGZJZm04dHd6R1JrNkhGRk5uNG0wdXkwVEFJ?=
 =?utf-8?B?RlFISzBWeTdDQWdhM0Q1UU1vVUZjUUpCejg2ZjVKaWRka2JmdFAxdkV6dGN0?=
 =?utf-8?B?QkVxbktwZnBpK2Y0WThkeVVtNFFjUjJ0S0R5VGV0WFVxb3ZyMWcxcDBnRERG?=
 =?utf-8?B?YzBOeDMrT1hVQUs5eWVQRVpHTWU4OXhxNjdXUC9RNTBUSXFCM3V3Z0x6Z05r?=
 =?utf-8?B?NnprM3Fxb1FSdjNSeTBJVzF1RUljVHRKNTZaY0t3RXFZQ25MZTV5b2JCL1lG?=
 =?utf-8?B?Qm1UQTJTWFRzMmtsVUhSb0pLclhaNmRVcUJNazJBa0MrcUF4eTJGT0Z5T2pm?=
 =?utf-8?B?MEh1QUVwWW0xeWhFbURYeHdreE5IM2tjK3lkMmdRc2tJL0RDMFlOeDVFNSt6?=
 =?utf-8?B?aTVqcFg2dm85bTFMTFJvUUo3VjE5cU9hRzlzbzlNUEV6U0hXZVVReXM3Snc5?=
 =?utf-8?B?VW1VY1Q3N0pGait6UnVnaDdSTm9MQ1F3c0ZES2c0NUMwVVljUnlwbHQ2M0Yv?=
 =?utf-8?B?Vmk1T1hzMG1laStZSXNxUDQ0Nk9mUmpVLzZtT3hZUkcwSmxTb2dsQzZnN2hE?=
 =?utf-8?B?RlhsUzNGdmFKdHNjUmgvbVowamxvYUhxRWFUN3VtNURWd1QyQXBzVnNOTDJX?=
 =?utf-8?B?MXE4NXYzQXBFeGFlbjhXUkN6TnoxcmFUdGJVbHAvZmwvaWp4Y1EyS3NhR2ky?=
 =?utf-8?B?RWZickkwZEZIQzd2TFdoR2lXeFUyWG80T1pqVE5vT2RWS1N3Q0ZLQnRHemly?=
 =?utf-8?B?WGtJZEVQWmw2L2ZVMWFGM25WTFVDMFJYZFBhUnRWQ0RFWDZlYm5mR2tiYm5W?=
 =?utf-8?B?czdyVUluUXJJYnRRbG1Dek4wVGlEM2J1NHFKa0lkL3FGZzZVY0RIcmRqaHlv?=
 =?utf-8?B?Z0dtQzkxTEd6R1dQK3ZTZTJ3emxiMDBBZ0VycGFnbXRkNkMwVDRFcFdWYXZH?=
 =?utf-8?B?dUp4MGNCaG9XckUrQTRkck1DOHlERVJkYVRKdkdtMGpoaGhtY1IvYnptWDFn?=
 =?utf-8?B?bjRlcEgrYTcrTG5oQW0rVFc1YWpNa1EwQXhBWVhJbFg2SWdnd3BiOEtvdjF6?=
 =?utf-8?B?RlhhcWtvbWFJb1QxTFQvSVdkUVRqbTJWQXB4bjhzQ28ya2ZNQlQ3d0MvMlpm?=
 =?utf-8?B?aDZOWnFac3BNN1dYejJiZkpBMnpnTjZVc0dQV25iNXNZTStDWGcyRTdiMHAx?=
 =?utf-8?B?eFFQcXc1bXdiS21LQ2ZtOVZQUmdpdmZDcXVKTnBkUHlYMTlmb1lwQnN0M2xX?=
 =?utf-8?B?Y3c1ZFo2cWhVazBBa2NUQ05uVHVJRHhZMXdaT3BkcWlwMTJueGVvZEZGQTVi?=
 =?utf-8?B?eGFvUVY1bkR4YXI3Ykphc3dYdjcwRnpMSEdRckxlRXkyZDRZakhPcUNqTEtZ?=
 =?utf-8?B?cDM2QTZVK1RwWWNqY2tLWGNTNkNkdWVIa3Q0NVNzbVdXT3BGY29uZE9WR0xx?=
 =?utf-8?B?MUNzcUUrdlduMHhvVFZVK0tCSWp2aXE1Mngrc05Nbld0ZzdEZjRmMVFLZjJz?=
 =?utf-8?B?aExNei9aQ3llLzdXMUJTMis4NUJ0bWxVa3hSSC9UU2RvSmdNT3V6UDVYekIx?=
 =?utf-8?B?cnlwY3Q2akYydUNHRzVmTHE3Z2tNcENnVmc5NDFTM1pGY3Qrc2V4TE1GdXJm?=
 =?utf-8?B?M0xtN3Q0WElNdzBrQnV5ZHpya09kVVlNVnVzaVlzd1ZrVzlodGdYK2syWDJw?=
 =?utf-8?B?UXlJMyt6eGJiTzM0dkxxSFR2YmFVY0s3OEdYVUNGT0JSWEF6YW1pR0NaV0sw?=
 =?utf-8?B?T2hmSGFyK09pS0g2Z2E0NGhvUGpLUjRmSEphSGNjK0E1MWROc0ZwQjVKMDJD?=
 =?utf-8?B?Znc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e901d9e3-06da-477b-cda8-08dcc7d82767
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 03:10:36.7169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DQJkv21ozZKDTFQR9PYyy9Ct9xbubn9q7pTXJRd/O3MoByKZVia+97xBFyztrKDqUz8/Mwl5Mfs8SC9BSRs3Bku0LemSn1qFI/sDc0Nvx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-OriginatorOrg: intel.com

SGkgWW9zcnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWW9zcnkg
QWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3Qg
MjgsIDIwMjQgNjowMiBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5z
cmlkaGFyQGludGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LW1tQGt2YWNrLm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNv
bTsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVs
LmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsg
Wm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8
d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBp
bnRlbC5jb20+OyBDaHJpcw0KPiBMaSA8Y2hyaXNsQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjUgMC8zXSBtbTogWlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xpb3MNCj4gDQo+
IFsuLl0NCj4gPiA+ID4gSW4gdGhlICJCZWZvcmUiIHNjZW5hcmlvLCB3aGVuIHpzd2FwIGRvZXMg
bm90IHN0b3JlIG1USFAsIG9ubHkNCj4gYWxsb2NhdGlvbnMNCj4gPiA+ID4gY291bnQgdG93YXJk
cyB0aGUgY2dyb3VwIG1lbW9yeSBsaW1pdC4gSG93ZXZlciwgaW4gdGhlICJBZnRlciINCj4gc2Nl
bmFyaW8sDQo+ID4gPiA+IHdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB6c3dhcF9zdG9yZSgpIG1U
SFAsIGJvdGgsIGFsbG9jYXRpb25zIGFzIHdlbGwgYXMNCj4gPiA+ID4gdGhlIHpzd2FwIGNvbXBy
ZXNzZWQgcG9vbCB1c2FnZSBmcm9tIGFsbCA3MCBwcm9jZXNzZXMgYXJlIGNvdW50ZWQNCj4gPiA+
IHRvd2FyZHMNCj4gPiA+ID4gdGhlIG1lbW9yeSBsaW1pdC4gQXMgYSByZXN1bHQsIHdlIHNlZSBo
aWdoZXIgc3dhcG91dCBhY3Rpdml0eSBpbiB0aGUNCj4gPiA+ID4gIkFmdGVyIiBkYXRhLiBIZW5j
ZSwgbW9yZSB0aW1lIGlzIHNwZW50IGRvaW5nIHJlY2xhaW0gYXMgdGhlIHpzd2FwDQo+IGNncm91
cA0KPiA+ID4gPiBjaGFyZ2UgbGVhZHMgdG8gbW9yZSBmcmVxdWVudCBtZW1vcnkuaGlnaCBicmVh
Y2hlcy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBjYXVzZXMgZGVncmFkYXRpb24gaW4gdGhyb3Vn
aHB1dCBhbmQgc3lzIHRpbWUgd2l0aCB6c3dhcCBtVEhQLA0KPiBtb3JlDQo+ID4gPiBzbw0KPiA+
ID4gPiBpbiBjYXNlIG9mIHpzdGQgdGhhbiBkZWZsYXRlLWlhYS4gQ29tcHJlc3MgbGF0ZW5jeSBj
b3VsZCBwbGF5IGEgcGFydCBpbg0KPiA+ID4gPiB0aGlzIC0gd2hlbiB0aGVyZSBpcyBtb3JlIHN3
YXBvdXQgYWN0aXZpdHkgaGFwcGVuaW5nLCBhIHNsb3dlcg0KPiBjb21wcmVzc29yDQo+ID4gPiA+
IHdvdWxkIGNhdXNlIGFsbG9jYXRpb25zIHRvIHN0YWxsIGZvciBhbnkvYWxsIG9mIHRoZSA3MCBw
cm9jZXNzZXMuDQo+ID4gPiA+DQo+ID4gPiA+IEluIG15IG9waW5pb24sIGV2ZW4gdGhvdWdoIHRo
ZSB0ZXN0IHNldCB1cCBkb2VzIG5vdCBwcm92aWRlIGFuIGFjY3VyYXRlDQo+ID4gPiA+IHdheSBm
b3IgYSBkaXJlY3QgYmVmb3JlL2FmdGVyIGNvbXBhcmlzb24gKGJlY2F1c2Ugb2YgenN3YXAgdXNh
Z2UgYmVpbmcNCj4gPiA+ID4gY291bnRlZCBpbiBjZ3JvdXAsIGhlbmNlIHRvd2FyZHMgdGhlIG1l
bW9yeS5oaWdoKSwgaXQgc3RpbGwgc2VlbXMNCj4gPiA+ID4gcmVhc29uYWJsZSBmb3IgenN3YXBf
c3RvcmUgdG8gc3VwcG9ydCAobSlUSFAsIHNvIHRoYXQgZnVydGhlcg0KPiBwZXJmb3JtYW5jZQ0K
PiA+ID4gPiBpbXByb3ZlbWVudHMgY2FuIGJlIGltcGxlbWVudGVkLg0KPiA+ID4NCj4gPiA+IEFy
ZSB5b3Ugc2F5aW5nIHRoYXQgaW4gdGhlICJCZWZvcmUiIGRhdGEgd2UgZW5kIHVwIHNraXBwaW5n
IHpzd2FwDQo+ID4gPiBjb21wbGV0ZWx5IGJlY2F1c2Ugb2YgdXNpbmcgbVRIUHM/DQo+ID4NCj4g
PiBUaGF0J3MgcmlnaHQsIFlvc3J5Lg0KPiA+DQo+ID4gPg0KPiA+ID4gRG9lcyBpdCBtYWtlIG1v
cmUgc2Vuc2UgdG8gdHVybiBDT05GSUdfVEhQX1NXQVAgaW4gdGhlICJCZWZvcmUiIGRhdGENCj4g
Pg0KPiA+IFdlIGNvdWxkIGRvIHRoaXMsIGhvd2V2ZXIgSSBhbSBub3Qgc3VyZSBpZiB0dXJuaW5n
IG9mZiBDT05GSUdfVEhQX1NXQVANCj4gPiB3aWxsIGhhdmUgb3RoZXIgc2lkZS1lZmZlY3RzIGlu
IHRlcm1zIG9mIGRpc2FibGluZyBtbSBjb2RlIHBhdGhzIG91dHNpZGUgb2YNCj4gPiB6c3dhcCB0
aGF0IGFyZSBpbnRlbmRlZCB0byBiZSBtVEhQIG9wdGltaXphdGlvbnMgdGhhdCBjb3VsZCBhZ2Fp
biBza2V3DQo+ID4gdGhlIGJlZm9yZS9hZnRlciBjb21wYXJpc29ucy4NCj4gDQo+IFllYWggdGhh
dCdzIHBvc3NpYmxlLCBidXQgcmlnaHQgbm93IHdlIGFyZSB0ZXN0aW5nIG1USFAgc3dhcG91dCB0
aGF0DQo+IGRvZXMgbm90IGdvIHRocm91Z2ggenN3YXAgYXQgYWxsIHZzLiBtVEhQIHN3YXBvdXQg
Z29pbmcgdGhyb3VnaCB6c3dhcC4NCj4gDQo+IEkgdGhpbmsgd2hhdCB3ZSByZWFsbHkgd2FudCB0
byBtZWFzdXJlIGlzIDRLIHN3YXBvdXQgZ29pbmcgdGhyb3VnaA0KPiB6c3dhcCB2cy4gbVRIUCBz
d2Fwb3V0IGdvaW5nIHRocm91Z2ggenN3YXAuIFRoaXMgYXNzdW1lcyB0aGF0IGN1cnJlbnQNCj4g
enN3YXAgc2V0dXBzIGRpc2FibGUgQ09ORklHX1RIUF9TV0FQLCBzbyB3ZSB3b3VsZCBiZSBtZWFz
dXJpbmcgdGhlDQo+IGJlbmVmaXQgb2YgYWxsb3dpbmcgdGhlbSB0byBlbmFibGUgQ09ORklHX1RI
UF9TV0FQIGJ5IHN1cHBvcnRpbmcgaXQNCj4gcHJvcGVybHkgaW4genN3YXAuDQo+IA0KPiBJZiBz
b21lIHNldHVwcyB3aXRoIHpzd2FwIGhhdmUgQ09ORklHX1RIUF9TV0FQIGVuYWJsZWQgdGhlbiB0
aGF0J3MgYQ0KPiBkaWZmZXJlbnQgc3RvcnksIGJ1dCB3ZSBhbHJlYWR5IGhhdmUgdGhlIGRhdGEg
Zm9yIHRoaXMgY2FzZSBhcyB3ZWxsDQo+IHJpZ2h0IG5vdyBpbiBjYXNlIHRoaXMgaXMgYSBsZWdp
dGltYXRlIHNldHVwLg0KPiANCj4gQWRkaW5nIENocmlzIExpIGhlcmUgZnJvbSBHb29nbGUuIFdl
IGhhdmUgQ09ORklHX1RIUF9TV0FQIGRpc2FibGVkDQo+IHdpdGggenN3YXAsIHNvIGZvciB1cyB3
ZSB3b3VsZCB3YW50IHRvIGtub3cgdGhlIGJlbmVmaXQgb2Ygc3VwcG9ydGluZw0KPiBDT05GSUdf
VEhQX1NXQVAgcHJvcGVybHkgaW4genN3YXAuIEF0IGxlYXN0IEkgdGhpbmsgc28gOikNCg0KU3Vy
ZSwgdGhpcyBtYWtlcyBzZW5zZS4gSGVyZSdzIHRoZSBkYXRhIHRoYXQgSSBnYXRoZXJlZCB3aXRo
IENPTkZJR19USFBfU1dBUA0KZGlzYWJsZWQuIFdlIHNlZSBpbXByb3ZlbWVudHMgb3ZlcmFsbCBp
biB0aHJvdWdocHV0IGFuZCBzeXMgdGltZSBmb3IgenN0ZCBhbmQNCmRlZmxhdGUtaWFhLCB3aGVu
IGNvbXBhcmluZyBiZWZvcmUgKFRIUF9TV0FQPU4pIHZzLiBhZnRlciAoVEhQX1NXQVA9WSk6DQoN
CjY0SyBtVEhQOg0KPT09PT09PT09DQoNCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAgICAg
ICAgICAgICAgICAgICAgIHY2LjExLXJjMyBtYWlubGluZSAgICAgICAgICAgICAgenN3YXAtbVRI
UCAgICAgQ2hhbmdlIHdydA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmFzZWxp
bmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmFzZWxpbmUNCiAgICAgICAgICAgICAg
ICAgICAgICAgIENPTkZJR19USFBfU1dBUD1OICAgICAgIENPTkZJR19USFBfU1dBUD1ZDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KIFpTV0FQIGNvbXByZXNzb3IgICAgICAgenN0ZCAgICAgZGVm
bGF0ZS0gICAgICAgIHpzdGQgICAgZGVmbGF0ZS0gIHpzdGQgZGVmbGF0ZS0NCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWFhICAgICAgICAgICAgICAgICAgICAgaWFhICAg
ICAgICAgICAgaWFhDQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIFRocm91Z2hwdXQgKEtCL3Mp
ICAgMTM2LDExMyAgICAgIDE0MCwwNDQgICAgIDE0MCwzNjMgICAgIDE1MSw5MzggICAgMyUgICAg
ICAgOCUNCiBzeXMgdGltZSAoc2VjKSAgICAgICA5ODYuNzggICAgICAgOTUxLjk1ICAgICAgOTU0
Ljg1ICAgICAgNzM1LjQ3ICAgIDMlICAgICAgMjMlDQogbWVtY2dfaGlnaCAgICAgICAgICAxMjQs
MTgzICAgICAgMTI3LDUxMyAgICAgMTM4LDY1MSAgICAgMTMzLDg4NA0KIG1lbWNnX3N3YXBfaGln
aCAgICAgICAgICAgMCAgICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAgICAgIDANCiBtZW1j
Z19zd2FwX2ZhaWwgICAgIDYxOSwwMjAgICAgICA3NTEsMDk5ICAgICAgICAgICAwICAgICAgICAg
ICAwDQogcHN3cGluICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgMCAgICAgICAgICAg
MCAgICAgICAgICAgMA0KIHBzd3BvdXQgICAgICAgICAgICAgICAgICAgMCAgICAgICAgICAgIDAg
ICAgICAgICAgIDAgICAgICAgICAgIDANCiB6c3dwaW4gICAgICAgICAgICAgICAgICA2NTYgICAg
ICAgICAgNTY5ICAgICAgICAgNjI0ICAgICAgICAgNjM5DQogenN3cG91dCAgICAgICAgICAgOSw0
MTMsNjAzICAgMTEsMjg0LDgxMiAgIDksNDUzLDc2MSAgIDksMzg1LDkxMA0KIHRocF9zd3BvdXQg
ICAgICAgICAgICAgICAgMCAgICAgICAgICAgIDAgICAgICAgICAgIDAgICAgICAgICAgIDANCiB0
aHBfc3dwb3V0XyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAwICAgICAgICAgICAwICAgICAg
ICAgICAwDQogIGZhbGxiYWNrDQogcGdtYWpmYXVsdCAgICAgICAgICAgIDMsNDcwICAgICAgICAz
LDM4MiAgICAgICA0LDYzMyAgICAgICAzLDYxMQ0KIFpTV1BPVVQtNjRrQiAgICAgICAgICAgIG4v
YSAgICAgICAgICBuL2EgICAgIDU5MCw3NjggICAgIDU4Niw1MjENCiBTV1BPVVQtNjRrQiAgICAg
ICAgICAgICAgIDAgICAgICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwDQogLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KDQoNCjJNIFRIUDoNCj09PT09PT0NCg0KIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KICAgICAgICAgICAgICAgICAgICAgICB2Ni4xMS1yYzMgbWFpbmxpbmUgICAgICAg
ICAgICAgIHpzd2FwLW1USFAgICAgQ2hhbmdlIHdydA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQmFzZWxpbmUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCYXNlbGluZQ0K
ICAgICAgICAgICAgICAgICAgICAgICAgQ09ORklHX1RIUF9TV0FQPU4gICAgICAgQ09ORklHX1RI
UF9TV0FQPVkNCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBaU1dBUCBjb21wcmVzc29yICAgICAg
IHpzdGQgICAgZGVmbGF0ZS0gICAgICAgIHpzdGQgICAgZGVmbGF0ZS0gIHpzdGQgZGVmbGF0ZS0N
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpYWEgICAgICAgICAgICAgICAg
ICAgICBpYWEgICAgICAgICAgICBpYWENCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBUaHJvdWdo
cHV0IChLQi9zKSAgICAxNjQsMjIwICAgIDE3Miw1MjMgICAgICAxNjUsMDA1ICAgICAxNzQsNTM2
ICAwLjUlICAgICAgMSUNCiBzeXMgdGltZSAoc2VjKSAgICAgICAgODU1Ljc2ICAgICA2ODYuOTQg
ICAgICAgODAxLjcyICAgICAgNjc2LjY1ICAgIDYlICAgICAgMSUNCiBtZW1jZ19oaWdoICAgICAg
ICAgICAgMTQsNjI4ICAgICAxNiwyNDcgICAgICAgMTQsOTUxICAgICAgMTYsMDk2DQogbWVtY2df
c3dhcF9oaWdoICAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgICAgMCAgICAgICAgICAg
MA0KIG1lbWNnX3N3YXBfZmFpbCAgICAgICAxOCw2OTggICAgIDIxLDExNCAgICAgICAgICAgIDAg
ICAgICAgICAgIDANCiBwc3dwaW4gICAgICAgICAgICAgICAgICAgICAwICAgICAgICAgIDAgICAg
ICAgICAgICAwICAgICAgICAgICAwDQogcHN3cG91dCAgICAgICAgICAgICAgICAgICAgMCAgICAg
ICAgICAwICAgICAgICAgICAgMCAgICAgICAgICAgMA0KIHpzd3BpbiAgICAgICAgICAgICAgICAg
ICA2NjMgICAgICAgIDY2NSAgICAgICAgNSwzMzMgICAgICAgICA3ODENCiB6c3dwb3V0ICAgICAg
ICAgICAgOCw0MTksNDU4ICA4LDk5MiwwNjUgICAgOCw1NDYsODk1ICAgOSwzNTUsNzYwDQogdGhw
X3N3cG91dCAgICAgICAgICAgICAgICAgMCAgICAgICAgICAwICAgICAgICAgICAgMCAgICAgICAg
ICAgMA0KIHRocF9zd3BvdXRfICAgICAgICAgICAxOCw2OTcgICAgIDIxLDExMyAgICAgICAgICAg
IDAgICAgICAgICAgIDANCiAgZmFsbGJhY2sNCiBwZ21hamZhdWx0ICAgICAgICAgICAgIDMsNDM5
ICAgICAgMyw0OTYgICAgICAgIDgsMTM5ICAgICAgIDMsNTgyDQogWlNXUE9VVC0yMDQ4a0IgICAg
ICAgICAgIG4vYSAgICAgICAgbi9hICAgICAgIDE2LDY4NCAgICAgIDE4LDI3MA0KIFNXUE9VVC0y
MDQ4a0IgICAgICAgICAgICAgIDAgICAgICAgICAgMCAgICAgICAgICAgIDAgICAgICAgICAgIDAN
CiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpUaGFua3MsDQpLYW5jaGFuYQ0KDQo+IA0KPiA+DQo+
ID4gV2lsbCB3YWl0IGZvciBOaGF0J3MgY29tbWVudHMgYXMgd2VsbC4NCj4gPg0KPiA+IFRoYW5r
cywNCj4gPiBLYW5jaGFuYQ0KPiA+DQo+ID4gPiB0byBmb3JjZSB0aGUgbVRIUHMgdG8gYmUgc3Bs
aXQgYW5kIGZvciB0aGUgZGF0YSB0byBiZSBzdG9yZWQgaW4genN3YXA/DQo+ID4gPiBUaGlzIHdv
dWxkIGJlIGEgbW9yZSBmYWlyIEJlZm9yZS9BZnRlciBjb21wYXJpc29uIHdoZXJlIHRoZSBtZW1v
cnkNCj4gPiA+IGdvZXMgdG8genN3YXAgaW4gYm90aCBjYXNlcywgYnV0ICJCZWZvcmUiIGhhcyB0
byBiZSBzcGxpdCBiZWNhdXNlIG9mDQo+ID4gPiB6c3dhcCdzIGxhY2sgb2Ygc3VwcG9ydCBmb3Ig
bVRIUC4gSSBhc3N1bWUgbW9zdCBzZXR1cHMgcmVseWluZyBvbg0KPiA+ID4genN3YXAgd2lsbCBi
ZSB0dXJuaW5nIENPTkZJR19USFBfU1dBUCBvZmYgdG9kYXkgYW55d2F5LCBidXQgbWF5YmUNCj4g
bm90Lg0KPiA+ID4gTmhhdCwgaXMgdGhpcyBzb21ldGhpbmcgeW91IGNhbiBzaGFyZT8NCg==

