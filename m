Return-Path: <linux-kernel+bounces-343794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A07989F87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A141C21B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C021D18A92C;
	Mon, 30 Sep 2024 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8057xtq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9618BC36
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692626; cv=fail; b=SQADn8He4/ZCpjNUkmxUNO5rC1UTD/AtD46blBk+6I4+ciHOC44kjbFh5jf6NSZ0vT61mvbfjulswiZ59iq/mPQ9Ictf95cpy+Eb27MHCdYOgems7KZkD+LiVCZ+ZgOtYB1cp1zvZHCQhtkUB2FJU+GkzSJD5uevFTRJdgjdBT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692626; c=relaxed/simple;
	bh=arYp4JJcgUI9BVD6TE8HF2UVrA6HoYexsCfhTJGh9xE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afVeuVNk78yZJSEfvn2GpoK/5eY/ul2pCrR6tg3E0R/XgXNxNS90hyhUD52rXgc9NRRsI+4rt0fNiq7FLCEEnI+9v/Wdnl/cnVV/5gppacZK2+FbRU1+OqHx9wO4h505ti1szomTnCUel42mP7TFmDcVcxnTqbp4tf41abhN6c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8057xtq; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727692624; x=1759228624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=arYp4JJcgUI9BVD6TE8HF2UVrA6HoYexsCfhTJGh9xE=;
  b=a8057xtqxTo5U8ZM4lcWNUcaZeG24E4hPcHktke1MRB3VJ5KkGK8kMDT
   mQLGG0lJb4z2ibRF1weLkZQjQBYiKV9mqa0aWYqZOmxt+t5YoUqhDGXXb
   GnxbSjXpsCdUz3m0mggm5AxY1PXMMZGCGhPfVkHIpT0ajebRn4TEvubG5
   A95EB8vFwa25exGWH+BKfUjjVGSfRL51L0MNuB9H0mu5F7demsy0VHNWN
   K2R85AlvTaMoP4JAESClO3FWgOoz0HjMIWMUK8qFB5aAioGslhNXl8AxH
   +P3L/zt5bp58/EHgWzsBjQbCZoje6evRNAJS+zeZS4nTJCyQpZFKRWFkI
   g==;
X-CSE-ConnectionGUID: DZyCcQrPSK2avqgg0fZGVA==
X-CSE-MsgGUID: Mclxpmi9TGy6PwEYzOaOzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="14398641"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="14398641"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 03:37:03 -0700
X-CSE-ConnectionGUID: KZS33mJyQwCEOc74UsZ3yg==
X-CSE-MsgGUID: rliK9iKZRi6e7z+HPA/FuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78016936"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 03:37:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:37:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:37:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 03:37:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 03:37:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 03:37:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYFtW4BeE/9GK25P6qhNLzS7958YDI5ufLcQMMKNSFedbUYuV+12ukGORkam7W8JWBEd798m7/bKKEcm2KhGvkHlfBrQW0vgqcSgpXt6kH3uZIVBJmBgeOX+qADcVZHfQG15hxHgu7pzCWz4jvC37vVSQ4Dk/wltUKPj6L5OFnVm/XIUueIhXY0Nj5K6uf4VVZg+0IirNS5G3CKlVkRSljhpncqFnAc0m2NAsApJfPflp4W8zI/Mu5VwINtKlu344BpIs6GptkAXePxCUn12KLym1yj0Uq0xrvfim00N+yhSalI6+0DEQ/XXGLtCdc7/GFdflqOnu7LOHCPsnrxaIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arYp4JJcgUI9BVD6TE8HF2UVrA6HoYexsCfhTJGh9xE=;
 b=ssKmVe3PfiG7pStLFyUmVIj7/5z2VJRvSM9rpYtgZkRMvn17JKu5Su9fRNQxRxFnt3Azsd3+MpAEAoNzFSRNYDOaEeTICF9pUiINvuwQHv89yutuUvAUvTq1PsxaRtTsi+pdRo18ip693Bu5ucq1/VnrrY4ELqD8mSf6nFub7onwXiPZhUJ4rY6JDMeLhEioaZyDxIxXAtmSGoD26GJrpEtbtXMEKFNJjfHvwyTfIlneyu60NhTXx4TFM8MOFJf7lw1RU9+7VU/UmH2Kpn1rvysZFLki+YS46A5xdu34YjA9jUfev8nViggDD80bd/aDP1TWy5S+f71wOwOpjCSYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 10:37:00 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8005.026; Mon, 30 Sep 2024
 10:37:00 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: MAINTAINERS: change mei driver maintainer
Thread-Topic: MAINTAINERS: change mei driver maintainer
Thread-Index: AQHbExgMM5BhMOIKyEyTIrB3wQrfF7JwIaKg
Date: Mon, 30 Sep 2024 10:37:00 +0000
Message-ID: <CY5PR11MB63668F224709F374C4C16D0DED762@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20240930090604.1788402-1-tomas.winkler@intel.com>
In-Reply-To: <20240930090604.1788402-1-tomas.winkler@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|PH7PR11MB7145:EE_
x-ms-office365-filtering-correlation-id: 62a7a7f1-49f5-47cb-979c-08dce13bd0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWNlT3V3cDdGQ1puaHk3K2FId3g0NnE3Nms2Z0t5ekxKc3lWWEIzRVNlVmRK?=
 =?utf-8?B?dGxnZ2JMb1JoSm5RK1FNTUZjbjdVbEhjcTQ0aEhiZXY1L1RVbVQyVXdCVHdq?=
 =?utf-8?B?TnZiZXhWbG5ncndydmJ6Uk5ZbTZTbGhqcUlwVjRxd1RxQ2JMNUF0Nk95M0I3?=
 =?utf-8?B?Ti92bGpib0F5b1kvVWNKUnNWQUtmT3dZS1B4bzErWWljYS9OVVRyR2xXZk1r?=
 =?utf-8?B?d1FNbmN4RFZZb2FtVkpEcUNRK0dCZEJtQXY3RzNQM2NUQVVoc2p6ZkovdnVz?=
 =?utf-8?B?TTdNbGc3WnR3UC9laG1tNFFUZWJBenM5MnNtY0IyWHZYb1AyL0UvNHBHa3hO?=
 =?utf-8?B?ajdzRDM0UVFwSHFqRHJ4N0lleHMyZ05DWmYxRXR0VE1HVWRxbjY2dXNlSmJV?=
 =?utf-8?B?bXhOcWlxQlNlSkJ5RE9LcXI2NU40Wm1QK1FPQlptZmY3c2VkOHdrUVFXSGRy?=
 =?utf-8?B?OFJ3Z2E1VnoyK0VCbXVwRGt3MHZJOVBTSzRmTXEvNVozUndpZWdSNzZOTEt0?=
 =?utf-8?B?SmZVYk5QQWVSU3BPQmZXVWpNbWY4c2J1UlkxSDB6SnBka3BKaGk2MDczK2Zj?=
 =?utf-8?B?MllyU1N3aHhVYTI3OS9lUlJ4UGxCNnduM2toanZUQnpKT21qK1J0aUIrZTFm?=
 =?utf-8?B?R2RiRmVKRTA3dDlnSHQ1enRFM3l6YndrVGt6bnNSL1prL25YenpNTTBWT1V1?=
 =?utf-8?B?bnR2enNjZVh6RUl6bnUvUloyUDNFYVMwdXBtem9LK3AwMmxoUE5iOU5vUUdD?=
 =?utf-8?B?NjhyRXh4Y3l4Ryt3N1FtSTlGSkFWc1FiNWxQYmI4Q0JyamkzNzJQQ1ZSUEZ4?=
 =?utf-8?B?STdtdHNDYnUzSkhTS0FGbnNMVExCTFBzZDFkRlFIYzZIRmxYTEplRnBJMnp3?=
 =?utf-8?B?ZU5LbHJrZVFJMHJ5blQ3SzBpcXNMU3pVSTZsQnpyQWFsU3JEUlVXV3Q2MDFm?=
 =?utf-8?B?cEVWakMzdVNNcCtXcDI2dnc1MW5rU3hXWXpWeExBaERMVUM4TzM2MkcvZ1Nv?=
 =?utf-8?B?OTJjeTlUbFh0aERkeHd0WU9EREphVnRHdEU4Z2UwYTRFakQrYWZjZDdSd3Fr?=
 =?utf-8?B?TU5wd2JtdkJoaGRDTWJscC9oVXVma3M1bFY5OVRlZFBxMXE5cG10VGxCUURs?=
 =?utf-8?B?U3F4L1BlTStla2JVdGpkUkx4MlBRczN4cHRMMk9aMi90d0NOWU5iZWFqOHRt?=
 =?utf-8?B?VXQxYXpFNDk5TS81U2RyY1gwb0R4UVkwZGlKdlBWS3NxUS9zSllCU0ZOU09W?=
 =?utf-8?B?cjk4UHVBcmxpWGdUTERZVHQ2THhWZENGdUZ2Z1lEWjNnRHlOSWNLaTIxUVBq?=
 =?utf-8?B?d0JMOXJNNjZRbW5URXA5ZFozY2xoZnY1WkcvNUJoQUdUL1ZiQjNDS2QySTdV?=
 =?utf-8?B?WUNPdWlqS0pJU0V3N20va1JXWThFTklZVkRNNVUvNS92dWlZME1Ub25OdDU0?=
 =?utf-8?B?OTNSYW1lMWJqa25PRUZGRHA1Z2ZaRTJrVVdvQ1hQTjBQSG5FYmRlN0wzUEJR?=
 =?utf-8?B?bDNSa1podUJ4a2VnMVJrelhXblpSWjV1TlVwSFArK1BoQk9DLys1OHdOY1Jx?=
 =?utf-8?B?Qy9GY3dSWVVEZys1UjRjNzExOXJlRmpraDg1a1dxbHZsQzlVNzNlT0dEdzVB?=
 =?utf-8?B?UnFLWHdHRFo4M1RWaDhQN1UwelAzQWR6ZDJNUXVMU3hpS3V3SXBXTHRUNTV2?=
 =?utf-8?B?UzJGalp1a3FoYnFBTkVxQXRNZXpncXdRWGVDNEFtdTZSdU5DZ2J3Q1ExV3A1?=
 =?utf-8?B?Nm9kSlBmVlYzcjFjcVdGTWxOL0dIdExETGxzWjVxZ3V4WkdzZGxkT2hvS0dC?=
 =?utf-8?B?Y2JTMDJJUm5ocDRzQTlSYlp3Y0ZhUGRJS1Q3d1dZaVcyak1ZeXpLbkh6UUs1?=
 =?utf-8?B?eEdHRGhzMU1UdkVFR1RsZTAzdEpOU0d6bGcrNG1aUjBXSnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K08vZ0ZWNVhwaXBzRGFRMDJZMU1Wa0x1RWQ2RXh6U2phbXd0T2xYRThhK2J4?=
 =?utf-8?B?K05vSjA5cGFsa0l6cVVlKzFsQlR3ekhyZHZUU0xxUmJxZysxTis2dHNzSmZM?=
 =?utf-8?B?d2J5c0N6c1BGck5IYkIwd0NGRThUSzR2VUwzMS9CSEtVWExnSHVvUlBRRlg4?=
 =?utf-8?B?b0FSRVh5YXBtMjVtNjdycFJybER3QW1lVnhCOEJsd1gycWVROXpYV0x0QzNP?=
 =?utf-8?B?ZGR1b0ZmYm5ERHdGdUZKRysxYkFSZ1pZT2xJdzYyaHNUaTk2NlZBWVRrYkJS?=
 =?utf-8?B?ZWROMmRkZ0thZXd5Ujh0dWZQbHFyQXBWaGJFb28zUzF0WnF1WFFRN3JyR0JN?=
 =?utf-8?B?ajdsdnVqRCtvcFYxZTN0YzFmcEtvZmdSUFF4SjM4OE12ZXBTMnNtZGdZeU5m?=
 =?utf-8?B?WW90dlVOMk80c0l0Zmh0cUNKYVYwMnVST2xtNWpFZXFPR29iVWpSeWllQTlP?=
 =?utf-8?B?cVpEWWdMbXBaRnpHWUZqUVIrVTc1QU94N2M1VkVGSU5venFjWlRBSGVMRHRV?=
 =?utf-8?B?bGRLYjQ4WE9rYzVOejl6WS9sUDNDdUsyeFJWNHlqTGxsNGQ0bzc1bmNFZFdv?=
 =?utf-8?B?RFlHelhzSUVMdWlBWEJYUk9NcnlOR21nY3BSZU85cmZScUgrNXVGbEdRcy9B?=
 =?utf-8?B?RGRCaFJDOVIwcEFPVzBCL1N0RWx4UmszTk96MGo3ek5FVXJJMWg1VWtGK0N5?=
 =?utf-8?B?TDNaT0NWcUJTY1VVbkhibXkxRWI4YkU0eDgrdmJVenJ4RGp1emhNSXhoVGJu?=
 =?utf-8?B?aGQ4aHhRNEExVjlNY3QrZVlCem1waVZvbkRvays0VG90Ympoa3RDY0tHOVh0?=
 =?utf-8?B?QnN6akdJU0N5WGxlMkpkbDhZNjNRSUZLbzZCQ2RTTnd3RE9lSng3cmF0aDlr?=
 =?utf-8?B?UElERDBjajMyaHAvcXNWcVFEK1lsNk1KeEtvOW9Kc1I3cVpxdHdJMkx3cENr?=
 =?utf-8?B?SWQreFIyeU0yN3RqNHNWc1R4UG12NXY2SE8rNUZxekRUOU0xcDRsNHRlbm1G?=
 =?utf-8?B?OHIwZmVWUWxDUGNQSmZZblpnbytkZDBvRkJwdFViN2NidEYwbXludnR2bHlG?=
 =?utf-8?B?bVd3OU5Sb1FSOWhURzh3WVp0RnlTSjlQeEhaTVo5N0JwQS9iejNPVUJqQWlL?=
 =?utf-8?B?WmozT2twYWJLekpnVDhjMHNOL0dwQll2bnpLRzdnSUhMenRvK1lMb2lLb3NE?=
 =?utf-8?B?MXBpZXlrbHVGVWtWQWozVnp4anlPdmtlNFR5RUcvcVgyRkU4MTMvaWxONFhW?=
 =?utf-8?B?aVNudVlaNGw0MUJQNVBFSlYyaEE1NzBtUEtEVEhaT1hETy9FekpEdTB1TVVF?=
 =?utf-8?B?V1dSSjNyYyt5NWFldTRwM09MNU5IYS9FSlRFakhySVZzOWVUTmFmNktzVlU0?=
 =?utf-8?B?NUlWV0ZRMlY2bDY5cWZUbkJUSFNmS01JeGpVRnhQUkVTV21adXl2Vm55a0t2?=
 =?utf-8?B?L0pISGNhWWt0cnBHZm54SXRuZFNkUVZnOUhtMlFhNjNZWDdDTnUrSEg4a3M2?=
 =?utf-8?B?TG1aYmdkZm9JRGVBc3R2anI0YUQrTFU5QWY3bEN6Znl5K21GbXl3UWlOanlr?=
 =?utf-8?B?RmlwTHBJcWwxdmlFRWZtSFdSekhCOUoreitVZHgwbnp3Sm5QK2JVL0p6YzlU?=
 =?utf-8?B?NnhrWXQ3NmpFUjM0SFNmTUVIRERiQ0Y1MklHVjNrc1pqTGxWenNzYWJ2Wlpu?=
 =?utf-8?B?MURRWElRZkErcGo2WW81NVVpVUtZVWxwSXM1ZFZodjhLRWFIR3RMVHhqc3BY?=
 =?utf-8?B?MjNGUXJPTmlaeEJMNlhjNTBHT1FDYms1SU5oa2x6a1NCZjd1b1Z0YWsxSzBW?=
 =?utf-8?B?UXpRYnBEckI3OW82WnFWNElCNlBRaEU5ZFk5NkltcGxCU2hRVm1EREdCNEEv?=
 =?utf-8?B?UU1lSDdSQ1ZOU3FNN1l5ZjB0MVNtWERsbDY3dW9uc3cwV1JseHZpbGRuK2k4?=
 =?utf-8?B?ekEvVmhuOERvOEZjQjhBWklIVTdQUXFtUDhqbktBTGN0eDYyRGdnOHFJbTVQ?=
 =?utf-8?B?VkNKbTl4K0J2SnZhYXN5LzY1eXZ1b1NZclc4WnFpNS9mYXNIbDN2S3ZUamor?=
 =?utf-8?B?Y0I2NmtKUDBKNGFwOGhPR3hFbHBRdzBWYmVKRlM1UzQvU2Fhdnh6a0h3NHp5?=
 =?utf-8?B?Z2phdmRLRDhrWGhnL2cwZTF0V1JpOGZLcnZRVG9rQklmMEo1M25UVHNtVk5i?=
 =?utf-8?B?eVZibjA2akRaQlptZVhvUkVnN2dpVWVmTUsyUE84NXlGSXBVZUxHd1loVDFE?=
 =?utf-8?B?aHJDL2o4UmlLck4zRHd2TXdHRGlBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a7a7f1-49f5-47cb-979c-08dce13bd0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 10:37:00.5394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7L2RMGN+o5J4PTO/EkXUsg0YYfUcJ3m7qwsC1Ir8yD5VF5yU9727EdD3S6pYMlZfvgtvNpmdgt1tTweqgAgEeK0e0oZKts9yl4SHCTlEhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXaW5rbGVyLCBUb21hcyA8dG9t
YXMud2lua2xlckBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDMwLCAyMDI0
IDEyOjA2IFBNDQo+IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPg0KPiBDYzogVXN5c2tpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIudXN5c2tpbkBpbnRl
bC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgV2lua2xlciwgVG9tYXMg
PHRvbWFzLndpbmtsZXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBNQUlOVEFJTkVSUzogY2hhbmdl
IG1laSBkcml2ZXIgbWFpbnRhaW5lcg0KPiANCj4gQ2hhbmdlIG1haW50YWluZXIgb2YgbWVpIGRy
aXZlciB0byBBbGV4YW5kZXIgVXN5c2tpbg0KPg0KPiBDYzogQWxleGFuZGVyIFVzeXNraW4gPGFs
ZXhhbmRlci51c3lza2luQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVG9tYXMgV2lua2xl
ciA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQoNClRvbWFzLCB0aGFua3MgZm9yIHJlbGVudGxl
c3Mgd29yayBvbiB0aGlzIGRyaXZlciENCg0KQWNrZWQtYnk6IEFsZXhhbmRlciBVc3lza2luIDxh
bGV4YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+DQoNCi0gLSANClRoYW5rcywNClNhc2hhDQoNCj4g
LS0tDQo+ICBNQUlOVEFJTkVSUyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJ
TlRBSU5FUlMNCj4gaW5kZXggNTgzNGExY2QxMGQ3YjgzNjU3ZWQ1ZmVmLi5jMjgxZGQ4MmY5YjM3
ZDY3NDVjYmNkM2UgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlO
RVJTDQo+IEBAIC0xMTYwMiw3ICsxMTYwMiw3IEBAIEY6CWRyaXZlcnMvY3J5cHRvL2ludGVsL2tl
ZW1iYXkvb2NzLQ0KPiBoY3UuYw0KPiAgRjoJZHJpdmVycy9jcnlwdG8vaW50ZWwva2VlbWJheS9v
Y3MtaGN1LmgNCj4gDQo+ICBJTlRFTCBNQU5BR0VNRU5UIEVOR0lORSAobWVpKQ0KPiAtTToJVG9t
YXMgV2lua2xlciA8dG9tYXMud2lua2xlckBpbnRlbC5jb20+DQo+ICtNOglBbGV4YW5kZXIgVXN5
c2tpbiA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KPiAgTDoJbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiAgUzoJU3VwcG9ydGVkDQo+ICBGOglEb2N1bWVudGF0aW9uL2RyaXZl
ci1hcGkvbWVpLyoNCj4gLS0NCj4gMi40Ni4xDQoNCg==

