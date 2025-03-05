Return-Path: <linux-kernel+bounces-546203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F8A4F7AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B569E189101F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05101EB5D4;
	Wed,  5 Mar 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VomTd448"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27F1DFD9A;
	Wed,  5 Mar 2025 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158552; cv=fail; b=ajhhdzUMnJ+PWOR2DqD1CsZgf+0IJq77IgV/gwbbNeV/U83+0lC6ErsSW0QCnwk36Ihh7TuvY8syhHeUq5GTik7esYOAlsHLvayJok6N1gEoP69wQaVAl988tBVlvgqZAEYqDToP2MZ7Y6l83u7aqfTuRrKXp7g21ku0e3hHnpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158552; c=relaxed/simple;
	bh=Co82z+2BSqH534oX1tp6bjDSqVK290O1JrTTzLWTS0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qU9y0BNsON6NOwrKJEhsEPfNRQ/akTZ2wtC6jahI2ZvT01f9UlAZp27j2TuBrQODITmeBvsDASjdNtBJZZGwaDOUBp2hFPxUfhYLXLWr2Le9FGgKU0hySuxmy0lhSmJVtaeDbLozQZF6B+Nisrt+m7drJOEZmIibbOR0d5TXGwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VomTd448; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741158551; x=1772694551;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Co82z+2BSqH534oX1tp6bjDSqVK290O1JrTTzLWTS0g=;
  b=VomTd448rCV7aOptM5i9n3LVQ3deFW8Cg/muKaPFsTGzksxf4HQ4PeZ6
   xHU0ywYCYbvfrPGKoh5UCnD5WQNJq0UGZEhC6x5RmTi+clx0C1cWzVDAX
   iMqYC02BpM9rpYGcWk9YGPXGmevrUioji2fxDVbTx0CgOljVAoKDr3UFV
   JjRmYnQ+35Xm7aobkhszKlZLa86wNmeMPCNxf4/xECjs8UK7ogo7dlcap
   XXrA8cByN81q2USYUPH7it1bPC60iFj0QDd0Pa1InyxTjCDHREbXhon9W
   nlfmv2APHQCiJI6/qe1gFIQ7/c49MzQEJzN0GUDn7MHkMu0RC9BXnh9+4
   A==;
X-CSE-ConnectionGUID: L1w7hYRsQSOMa9XuWpqATw==
X-CSE-MsgGUID: uTQ2f5hBSm+bFykmcpumQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52740838"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="52740838"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 23:09:07 -0800
X-CSE-ConnectionGUID: V5/idN3rSvahJBZj5PinNQ==
X-CSE-MsgGUID: yRQq9C55Tlql8YcI0KAyCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="118428510"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 23:09:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 23:09:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 23:09:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 23:09:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTkz/bvkXOvaYZRY3eW0YpwfYNYRuscb+ZkTAoZGKKavJAQkkQDKXqebSZEP8BzBa+FEhknaBQZre2x3NNEKTboFBCAovwLiJYU6nE/jVjgFP5rBzJD5TFmhS1/up62S5NrC6ys6iHa5nOlljQe1Q6FNi9D0DYI++XAtuRGDhljN7WfFJbPkC6/pFhDt3OOf0a4/7UKqd6VE+PiC7rKx8TkJOLrNgdgJW74NqQ9Aeu/Sje7DSjcWuYDg0a33FgiTobmBR0ngsOjamRbZRXdRXrDQZflsmjxLjo+8SjemB6IUl0ylACafgC4nCsnN5iNUnI363jiNXZvdW0tBMj4cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Co82z+2BSqH534oX1tp6bjDSqVK290O1JrTTzLWTS0g=;
 b=rELZnQK4MFm5ERoPKQ9I9uU1mMXsf1hJbNf2l4pLWNxAvnX7PQfWdT7deK3mOOELdTRzn2HS3NlWzr5fF9t2MeJFyU5xV7OgFY/NRpL37V1vWUU/3qJO6gfnJ9KPidmw5eqORjhAwk81g76ZC723dPW68wA7rQ1g0JUiSOghyFyhbjEYIcLq0foElxoDR1/BI12+0Wk5G6BxEcNV87/Wa8XWSsPr7zWxxkSrroDeaqLimW/6OcYSdID+t88mOnZogDjvV6xkm5gFgE9EkCVbDOcQwLXhKQN3s8Q9i5VI2jTht7sexX8Y4MKjyWoJrhxx9gzmK8RxUAAzrYCItlaNTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 07:08:48 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 07:08:48 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Tomas Winkler
	<tomas.winkler@intel.com>
CC: "cocci@inria.fr" <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Thread-Topic: [PATCH v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Thread-Index: AQHbjSxaSaCK5JKqh0W83bn0tQAnSbNkH1Sw
Date: Wed, 5 Mar 2025 07:08:48 +0000
Message-ID: <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
In-Reply-To: <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|MW4PR11MB6981:EE_
x-ms-office365-filtering-correlation-id: 7dc1e284-4245-4e09-c844-08dd5bb493a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WjdHQnBEd1pPZVBLQVJleXBtamtsdDJsVnBOK1J1Z1BWbitpYVpZS1BMNG9n?=
 =?utf-8?B?d1U1Y0RtWFNOb2JPUGlvV1VBeVhDSTlpUUV1RjZEVm1CbnVkMU1BWlNCS01Z?=
 =?utf-8?B?Ykp4bFVZMUxxcVJFY3FQLzNpYVVrcnJ2Y2tib0UzeW1ZdjFGSDhML2ZRbEV4?=
 =?utf-8?B?MmNKK1RJNWFSQm5iL3NFcTVpNlpEeHcxWFVyNWFSUFJ4UVB3SEIyYkE0aWE1?=
 =?utf-8?B?THZrWTVsQ3F2RVgxM1dZc3RyNlBPMEM5cmZ3UWpiejhzRnlNNFFHQ0dhb05z?=
 =?utf-8?B?V2pEeUM5TUxIZzBneTFGajNlQ0w3QUJSc252TXlXcEVvREFOR0YvRFBKR1E5?=
 =?utf-8?B?ekV2WkdpL0lNaWYwVUlZMEU2blY4WEVKNW0zSlkwTml4blZZdmZWNW43ZG4y?=
 =?utf-8?B?WXpMbmFrMXd2eDFpRU5IUWRxQ2pTQ0RueFc3K2ZXMGwvZ2lLUTRUV2x6UzRX?=
 =?utf-8?B?SlF0Q1NramZqZWRQeFc2KzFtMHNBRkh6Vy9xQTVQN2NpMW9FTWNiNHBieW9w?=
 =?utf-8?B?eXEzZTFQZXcrcWhRUE9YM0hZRGhxcklGQzZab3NScGhuSEQ0TUtjNXhEN3pH?=
 =?utf-8?B?Z1ZHTC81MU1qUHg2MHhJNTI1dVRGWGFtcEpGOHVKNGNNUVdydmtnUTlkRThW?=
 =?utf-8?B?ejdXTldVZnUxd3NCWWMxaTQ1cWYvQ2RXNkhVY3BUSzd5bjNMSG4zMWM3RnpZ?=
 =?utf-8?B?YlhtN3RiWE03YmRUc0EvZ3VYKzVYU1F0ZW1QaFd3Z1YvaHNjWkVlYmlCM1ZW?=
 =?utf-8?B?Y2RnY3VxQW9HMXUyWklRV0NtZ1dmR0Noc1FXT2lIZUpYOEk4TTk1TjBHWkM3?=
 =?utf-8?B?ejV2dFNjbU9XUnJOQTZSZzZTQzdjN005QUZXMFhGYTA5clZRRllKb2JPajZl?=
 =?utf-8?B?WHB4ZUNUUEsrVnpSTWNIL0NQVUNiRzJRRHN2TDRKZERNajBWcW9MUmFPVzhu?=
 =?utf-8?B?MVRuSThjYmtjcGh5TmhESzBPckdXZ0JIZEFnQlBWUHd5cVVFOHZ5ZDY5Z00r?=
 =?utf-8?B?VzhkTVNYWGRRSEt4ditOaE9OZVp1Z3ZOSk5vcll1bDRSWExPUTVHTk9KbmFE?=
 =?utf-8?B?MjN3dW5XbERHcVM1ZHNINUk3ak9LMWk0aHNnaFg1S1NyTlJpWkVkU2EwMkY1?=
 =?utf-8?B?Ylp5WFNlbk9pS2pBWmtwbTVFSUxzL2w5SGlrUXB4QW05OGRkbkdJVTVGTnE2?=
 =?utf-8?B?VjRJSU5LbE9WQ1MwU3VpamF4V2dSaXN6NlBrRlc3cFNKY3BqZzRobkU3T2pP?=
 =?utf-8?B?M293SjZxcVl4Vms3SFo4V2FjeG5GSmZYT0N1Mk5ZOWtJaDRBb1Y0U2ZZUEpR?=
 =?utf-8?B?R2hQY1IzendSNlF4WmRSL3RJdy9RTzN6OUJ0YzNnNUcyeDRNQk1OTGdveTlE?=
 =?utf-8?B?Vnk3ZG0ySnJBZFZOYmpWUEMvR1VYakJ0RnFFSUplR055LzcxL2R0YlJoNUgx?=
 =?utf-8?B?cmtOc0ZjMUlUOGhyR3VTd0ZNdkgrZFhqVS9hQU1wZ3JjTEMrZUNRWFJsWkor?=
 =?utf-8?B?OGhNNHFXQzI3YUhNT1doNG5MRDM3YU1pZEQvVXFIbU1jejZOQzFIemZvQ09Z?=
 =?utf-8?B?MHlhLzhjWmtxVzhBbG5ObnNkNWMyaG5jT2p6REZlWGtkdDh2NFBwTXJobzN6?=
 =?utf-8?B?czh1MFdURnZyMjRFQmtqY0U2a3J1NlRVMWcvNFJFTmVpcW1HbmNYNndXdEFQ?=
 =?utf-8?B?dFAvSVgzTXRscVhSUGxGV3lRYkRsd0J2Vm1VM01HODFTYWlua09Gc0xEMUIv?=
 =?utf-8?B?c1lVRjBmcEYrRldSWE9MOE52RGFUY2RmcFlIZitoZUp4amRYKzl6S1k2Y3g3?=
 =?utf-8?B?eDg4djNZYjFqcXRENzVZK2llMUlBbUt2c2VOSXZqaUFMYVRjekJXeGVLaHgy?=
 =?utf-8?B?akc5V1B5REdiKzc4a1I0ZlNmUFh2NFRETkZ1QlNxaDB6eE5EMGk4bEVnREFw?=
 =?utf-8?Q?rc2B+fXnbm/DKwXqCKRTYFGF6NMx7PGj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJrNVZLT2YyMW1YeWpOc1RLQ3lrRjFzYUZ4ME1uRVJLZHg0ZnF2ZWE1cWJ2?=
 =?utf-8?B?REtFOHBFOCtDVmpoME9wc1dNMlc3aTZuNU1uN2tDaHhhc1pPRlpyWnlJNTk0?=
 =?utf-8?B?Z09CaWR3RHRrWkVmNEwyeVpEcUZZYUlKMUhlSnVpMHVGRm1aSHdCUFpsNVZL?=
 =?utf-8?B?ZVQzY2tIRm5BMnFXRmlLTForRlEwRks4eS9rNjRuUnlvUDB2NldYUmovTk91?=
 =?utf-8?B?eW5EOHAyVW51Tm9tOXNHWVg4L2xjNFNSUXMyWmovN2pLcFI3bGRGckdlR0l5?=
 =?utf-8?B?M2Ivemx3Y0ZQR0NVV3ZFdEQ1RjE0YUF0dzVYNEhRYTZSUGo0VUR2TldjL3I4?=
 =?utf-8?B?dks5OVkweDI5cEYyR3pWdXRIdVBPaFBwQkRrZjRoczcvMWQyZmM5bjhsbmo3?=
 =?utf-8?B?dWwwS0NLRlpRQVU0VW5EdkYrZFBDRkE1Z2pRV0tIeC9CVlNwN1ovZDhrZWk3?=
 =?utf-8?B?eC9GMi92NzB0aC8zWjJ0SklST0RqU1V6V3RFd0ZUZ1lxRFpWbytobVptWkE5?=
 =?utf-8?B?ZlVLeFNBdDA0K3RtRWEzYXRFQWpqbHVzK0FuTTFvMHpJaUpreWIvK2V1U3BR?=
 =?utf-8?B?MkZRM0lYZDBZejZlN1JOcFI2aG5JZEdFQis2YmFHSUlocVk3R29kem9QMGN5?=
 =?utf-8?B?RkMzLytaTU9MaDRyWFIwU1hqczZyNGhQak1IeTlMZVNpK3RRZ0phQmpKNlp5?=
 =?utf-8?B?My9rWXVLZGtlTWFQYWJzRndvRUNjZlB3V0FlVzlRUDZ6a2srTE01Vmp3WURn?=
 =?utf-8?B?dDBab1NRRURwcWljUDlkbUFxbmNtbFZZWVR1M3p0dG9JL2xlM080RnhDV3p3?=
 =?utf-8?B?TktTdm5hS3pjb3VkSlNTOFZXbEJsRXRWYVplYldpYWZtRGNQSmN6cUdnUDFt?=
 =?utf-8?B?SktGbWZLbjdCa08vTG0rc09DeDNZNnRkTUlqSU1zekZHdGVtd2p5VlVpZk1h?=
 =?utf-8?B?UkpianlUbDJCRGxCM2pFcmExVXVhckpyd3k5ZWhoRFEvaUp5UHJXcnhPM3g4?=
 =?utf-8?B?NTdhaXJyNVJkamIra0FWeVFSQ3YzcmY2dy9NL0VJa3dGNDl4YTBveVpHYzE1?=
 =?utf-8?B?UHozckVmZ2YrTjJZK0Y4QWNJOG85czlxRm9CbDJDaVI3VFNwL1JmcHhjQVN0?=
 =?utf-8?B?aG5IY2UrTXczVitwOGRvMlNoV2dTKzN2U09mNFN6aVNpTU44UlNoQUhaMDBq?=
 =?utf-8?B?Rm9jaFZZSlhxdklIc1dOVm1SWUVOOWVBN3dTbUErR3g0bDA0WFJsRjNMdU4w?=
 =?utf-8?B?WjZlK1BnaG8yRG5Damh6NHlJTVpGajJOTHdOUnF0ZXdvdksxTXVvTkYxcHBr?=
 =?utf-8?B?VHdBZVRxNm5tSWtYbitYUVVHT0UrOWxLOVdzZlI2cVV5Z3VmeCt6QjFJbVF1?=
 =?utf-8?B?QnBoclh0YjJEU3JRUEdFdDU1Qk5GNkV5cHYwSVZ4RHJ6c3JDZDlDd2U2WXJR?=
 =?utf-8?B?TXNXYlF4VGl5dnpNQnNXbmMzbjNaY2EyNnZLaVJaQUphZUpZZkNES1RuNkVB?=
 =?utf-8?B?WHlzam5RMWZlNkxsZzNpYjhuOTZzK2lDenoxTUs4WGs4NHpzdDBSY0RqQXlp?=
 =?utf-8?B?ekhQcnV5QUViWlpoNXZRZGt1TFRYWGI3dUhHY21kRUxQaktFY3c3NFJrT2N5?=
 =?utf-8?B?N1QyYVBSVys0SUZxMU5oRHN0THBJTm9DKzJsR1A4L0YzWVUzMGtGTW9oSG1q?=
 =?utf-8?B?TUdiS3d3MlJ5b1IwSDEvdXBMME4yVU8zQ2pITXZvTkR4RmJjMG5TbSs1TUFr?=
 =?utf-8?B?cFFwWHUxNTY0MExHSDhnWWkwdUFKZUtRdStjeHR6a2huMnQxTndUNzJWcVJN?=
 =?utf-8?B?ekI1ZVNDek11NklVQmJNb2FYNkNRTnozVVJ5MThqM2xuaFpKWkk4bUlWbng2?=
 =?utf-8?B?dXh4YlByK25WVWpFOEljdWxiSVFTd0s3NXNFd0kzcFY5QWsvc2h2UHJYTFBW?=
 =?utf-8?B?dFlkZDJEMklBenI3WGJMZEw0VXlqR1Z0U05saVVBU0ZYS043M1I0MDJ4TGp3?=
 =?utf-8?B?dzhCaVp2NzdiQkxFa0NFb1B3NXBsSWhVdGJCMUM0Q1ZZVm9iSE5wcXpKVy9n?=
 =?utf-8?B?TEV5Q3JqMkFWRW9qWFhkR25pSTRkQjJ4QlpsajdCSUl5V0lIdVVEYVlmMDZY?=
 =?utf-8?Q?BsYYTKs7QxwGvtOoES+BuQxwM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc1e284-4245-4e09-c844-08dd5bb493a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 07:08:48.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Mp7O5WXuklkpqgWdm1x2fO99fv4DJOHKaJcxDpm7SLEOa8z1dquRqWAmOnecji0cOR9ylZitKAsh5ue2fNUAn03h7FMOS+9udzdY+TyUTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com

PiANCj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0
Pg0KPiBEYXRlOiBUdWUsIDQgTWFyIDIwMjUgMTg6MTE6MDUgKzAxMDANCj4gDQo+IFRoZSBsYWJl
bCDigJxkaXNjYXJk4oCdIHdhcyB1c2VkIHRvIGp1bXAgdG8gYW5vdGhlciBwb2ludGVyIGNoZWNr
IGRlc3BpdGUgb2YNCj4gdGhlIGRldGFpbCBpbiB0aGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIGZ1
bmN0aW9uIOKAnG1laV9jbF9pcnFfcmVhZF9tc2figJ0NCj4gdGhhdCBpdCB3YXMgZGV0ZXJtaW5l
ZCBhbHJlYWR5IHRoYXQgYSBjb3JyZXNwb25kaW5nIHZhcmlhYmxlIGNvbnRhaW5lZA0KPiBhIG51
bGwgcG9pbnRlci4NCj4gDQo+ICogVGh1cyB1c2UgYW4gYWRkaXRpb25hbCBsYWJlbCBpbnN0ZWFk
Lg0KPiANCj4gKiBEZWxldGUgYSByZWR1bmRhbnQgY2hlY2suDQo+IA0KPiANCj4gVGhpcyBpc3N1
ZSB3YXMgZGV0ZWN0ZWQgYnkgdXNpbmcgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5u
ZXQ+DQo+IC0tLQ0KPiANCj4gVjI6DQo+ICogVGhlIHN1bW1hcnkgcGhyYXNlIHdhcyBhZGp1c3Rl
ZCBhIGJpdC4NCj4gDQo+ICogVGhlIEZpeGVzIHRhZ3Mgd2VyZSBvbWl0dGVkLg0KPiANCj4gKiBU
aGUgY2hhbmdlIHN1Z2dlc3Rpb24gd2FzIHJlYmFzZWQgb24gc291cmNlIGZpbGVzIG9mDQo+ICAg
dGhlIHNvZnR3YXJlIOKAnExpbnV4IG5leHQtMjAyNTAyMjjigJ0uDQo+IA0KPiANCj4gIGRyaXZl
cnMvbWlzYy9tZWkvaW50ZXJydXB0LmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL21laS9pbnRlcnJ1cHQuYyBiL2RyaXZlcnMvbWlzYy9t
ZWkvaW50ZXJydXB0LmMNCj4gaW5kZXggYjA5Yjc5ZmVkYWJhLi5hZjVmMDFlZWZlYTQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvaW50ZXJydXB0LmMNCj4gKysrIGIvZHJpdmVycy9t
aXNjL21laS9pbnRlcnJ1cHQuYw0KPiBAQCAtMTM2LDcgKzEzNiw3IEBAIHN0YXRpYyBpbnQgbWVp
X2NsX2lycV9yZWFkX21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwNCj4gIAkJCQljYi0+ZXh0X2hkciA9
IGt6YWxsb2Moc2l6ZW9mKCpnc2NfZjJoKSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICAJCQkJaWYgKCFj
Yi0+ZXh0X2hkcikgew0KPiAgCQkJCQljYi0+c3RhdHVzID0gLUVOT01FTTsNCj4gLQkJCQkJZ290
byBkaXNjYXJkOw0KPiArCQkJCQlnb3RvIG1vdmVfdGFpbDsNCj4gIAkJCQl9DQo+ICAJCQkJYnJl
YWs7DQo+ICAJCQljYXNlIE1FSV9FWFRfSERSX05PTkU6DQo+IEBAIC0xNTMsNyArMTUzLDcgQEAg
c3RhdGljIGludCBtZWlfY2xfaXJxX3JlYWRfbXNnKHN0cnVjdCBtZWlfY2wgKmNsLA0KPiAgCQlp
ZiAoIXZ0YWdfaGRyICYmICFnc2NfZjJoKSB7DQo+ICAJCQljbF9kYmcoZGV2LCBjbCwgIm5vIHZ0
YWcgb3IgZ3NjIGZvdW5kIGluIGV4dGVuZGVkDQo+IGhlYWRlci5cbiIpOw0KPiAgCQkJY2ItPnN0
YXR1cyA9IC1FUFJPVE87DQo+IC0JCQlnb3RvIGRpc2NhcmQ7DQo+ICsJCQlnb3RvIG1vdmVfdGFp
bDsNCj4gIAkJfQ0KPiAgCX0NCj4gDQo+IEBAIC0xNjMsNyArMTYzLDcgQEAgc3RhdGljIGludCBt
ZWlfY2xfaXJxX3JlYWRfbXNnKHN0cnVjdCBtZWlfY2wgKmNsLA0KPiAgCQkJY2xfZXJyKGRldiwg
Y2wsICJtaXNtYXRjaGVkIHRhZzogJWQgIT0gJWRcbiIsDQo+ICAJCQkgICAgICAgY2ItPnZ0YWcs
IHZ0YWdfaGRyLT52dGFnKTsNCj4gIAkJCWNiLT5zdGF0dXMgPSAtRVBST1RPOw0KPiAtCQkJZ290
byBkaXNjYXJkOw0KPiArCQkJZ290byBtb3ZlX3RhaWw7DQo+ICAJCX0NCj4gIAkJY2ItPnZ0YWcg
PSB2dGFnX2hkci0+dnRhZzsNCj4gIAl9DQo+IEBAIC0xNzQsMTggKzE3NCwxOCBAQCBzdGF0aWMg
aW50IG1laV9jbF9pcnFfcmVhZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+ICAJCWlmICghZGV2
LT5oYm1fZl9nc2Nfc3VwcG9ydGVkKSB7DQo+ICAJCQljbF9lcnIoZGV2LCBjbCwgImdzYyBleHRl
bmRlZCBoZWFkZXIgaXMgbm90DQo+IHN1cHBvcnRlZFxuIik7DQo+ICAJCQljYi0+c3RhdHVzID0g
LUVQUk9UTzsNCj4gLQkJCWdvdG8gZGlzY2FyZDsNCj4gKwkJCWdvdG8gbW92ZV90YWlsOw0KPiAg
CQl9DQo+IA0KPiAgCQlpZiAobGVuZ3RoKSB7DQo+ICAJCQljbF9lcnIoZGV2LCBjbCwgIm5vIGRh
dGEgYWxsb3dlZCBpbiBjYiB3aXRoIGdzY1xuIik7DQo+ICAJCQljYi0+c3RhdHVzID0gLUVQUk9U
TzsNCj4gLQkJCWdvdG8gZGlzY2FyZDsNCj4gKwkJCWdvdG8gbW92ZV90YWlsOw0KPiAgCQl9DQo+
ICAJCWlmIChleHRfaGRyX2xlbiA+IHNpemVvZigqZ3NjX2YyaCkpIHsNCj4gIAkJCWNsX2Vycihk
ZXYsIGNsLCAiZ3NjIGV4dGVuZGVkIGhlYWRlciBpcyB0b28gYmlnICV1XG4iLA0KPiBleHRfaGRy
X2xlbik7DQo+ICAJCQljYi0+c3RhdHVzID0gLUVQUk9UTzsNCj4gLQkJCWdvdG8gZGlzY2FyZDsN
Cj4gKwkJCWdvdG8gbW92ZV90YWlsOw0KPiAgCQl9DQo+ICAJCW1lbWNweShjYi0+ZXh0X2hkciwg
Z3NjX2YyaCwgZXh0X2hkcl9sZW4pOw0KPiAgCX0NCj4gQEAgLTE5Myw3ICsxOTMsNyBAQCBzdGF0
aWMgaW50IG1laV9jbF9pcnFfcmVhZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+ICAJaWYgKCFt
ZWlfY2xfaXNfY29ubmVjdGVkKGNsKSkgew0KPiAgCQljbF9kYmcoZGV2LCBjbCwgIm5vdCBjb25u
ZWN0ZWRcbiIpOw0KPiAgCQljYi0+c3RhdHVzID0gLUVOT0RFVjsNCj4gLQkJZ290byBkaXNjYXJk
Ow0KPiArCQlnb3RvIG1vdmVfdGFpbDsNCj4gIAl9DQo+IA0KPiAgCWlmIChtZWlfaGRyLT5kbWFf
cmluZykNCj4gQEAgLTIwNSwxNCArMjA1LDE0IEBAIHN0YXRpYyBpbnQgbWVpX2NsX2lycV9yZWFk
X21zZyhzdHJ1Y3QgbWVpX2NsICpjbCwNCj4gIAkJY2xfZXJyKGRldiwgY2wsICJtZXNzYWdlIGlz
IHRvbyBiaWcgbGVuICVkIGlkeCAlenVcbiIsDQo+ICAJCSAgICAgICBsZW5ndGgsIGNiLT5idWZf
aWR4KTsNCj4gIAkJY2ItPnN0YXR1cyA9IC1FTVNHU0laRTsNCj4gLQkJZ290byBkaXNjYXJkOw0K
PiArCQlnb3RvIG1vdmVfdGFpbDsNCj4gIAl9DQo+IA0KPiAgCWlmIChjYi0+YnVmLnNpemUgPCBi
dWZfc3opIHsNCj4gIAkJY2xfZGJnKGRldiwgY2wsICJtZXNzYWdlIG92ZXJmbG93LiBzaXplICV6
dSBsZW4gJWQgaWR4DQo+ICV6dVxuIiwNCj4gIAkJCWNiLT5idWYuc2l6ZSwgbGVuZ3RoLCBjYi0+
YnVmX2lkeCk7DQo+ICAJCWNiLT5zdGF0dXMgPSAtRU1TR1NJWkU7DQo+IC0JCWdvdG8gZGlzY2Fy
ZDsNCj4gKwkJZ290byBtb3ZlX3RhaWw7DQo+ICAJfQ0KPiANCj4gIAlpZiAobWVpX2hkci0+ZG1h
X3JpbmcpIHsNCj4gQEAgLTIzNSw5ICsyMzUsOSBAQCBzdGF0aWMgaW50IG1laV9jbF9pcnFfcmVh
ZF9tc2coc3RydWN0IG1laV9jbCAqY2wsDQo+IA0KPiAgCXJldHVybiAwOw0KPiANCj4gK21vdmVf
dGFpbDoNCg0KSW4gZ2VuZXJhbCwgd2h5IG5vdCwgYnV0IHRoZSBsYWJlbCBuYW1pbmcgaXMgYmFk
Lg0KSXQgaGlkZXMgdGhlIG9yaWdpbmFsIGludGVudCB0byBkaXNjYXJkIHRoaXMgbWVzc2FnZS4N
CkxldCdzIHJlbmFtZSBleGlzdGluZyBsYWJlbCB0byBkaXNjYXJkX25vY2I6IGFuZCBsZWF2ZSBh
IG5ldyBvbmUgYXMgZGlzY2FyZDouDQpBbHNvLCB0aGUgcGF0Y2ggd2lsbCBiZSBzbWFsbGVyIGlu
IHRoaXMgd2F5Lg0KDQotIC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoNCj4gKwlsaXN0X21vdmVfdGFp
bCgmY2ItPmxpc3QsIGNtcGxfbGlzdCk7DQo+ICBkaXNjYXJkOg0KPiAtCWlmIChjYikNCj4gLQkJ
bGlzdF9tb3ZlX3RhaWwoJmNiLT5saXN0LCBjbXBsX2xpc3QpOw0KPiAgCW1laV9pcnFfZGlzY2Fy
ZF9tc2coZGV2LCBtZWlfaGRyLCBsZW5ndGgpOw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtLQ0K
PiAyLjQ4LjENCg0K

