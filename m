Return-Path: <linux-kernel+bounces-560450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA5A6046B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A8519C5A01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD11F8721;
	Thu, 13 Mar 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oqdhtfan"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FD1E8329
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905223; cv=fail; b=pH+r4qUhKRCb/8UQSPAb9st4LXvCFkCdHGCeqaAQ/Zn6SdTKnZskJPo+76iI0wcOZghJr8a4r9m+s02OxpYhlsh7ixL3/Y5batb7H1r/OUcEHRZ4j5pq6s/uEKgM+5yk2mEncIj9NkjlOlCSQ/RUwWto9RUk45zAMDHFMmUrrGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905223; c=relaxed/simple;
	bh=WZ4YM9w4ta4kzFgZA5sBI+7kX/I9hzQgD7lrkbq8/zY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UF5FX6If+Yq+Uv0I8trgWWnw6jkR065rLYNMqa19DXWwguyQlKAX5ZJcG14vNbPYNc7+NZ9z1B9zC8eTY9f+H1WncByr1LTFZXCC+RhVPQ4f0tXU6NGaAe8CyMhz9cDk/8JeoQkJqGylP5jlk+UNpXM0JfpLU4JpYK6UrWSUQnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oqdhtfan; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741905222; x=1773441222;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WZ4YM9w4ta4kzFgZA5sBI+7kX/I9hzQgD7lrkbq8/zY=;
  b=Oqdhtfank1xllrRyaLn48cMQk+Rw9lMr+KCE8eD5vnYioXp3qRpyopDw
   tV7w99bQ7/oHDQBHY7URunlWWXdkB47otDoSq/CEm93ehuILkbMTAs6SV
   3pnea6JZ0tV6pRHuw1IpoReSabTDRT3ec1E/uTGYi0MmeoF7mj8BWbFac
   6+c4e15RufjtDzToRnRfmLV3Y9lVV4bZGR7Qylbbkf2iurx0eaCbAqcwj
   hUHMza5IZcpmEPBBP0KNhBuEO8z8va7nUdNp9fPwkR5q8bx7ru19C8Z2n
   xxuTuNtkDnqO5g658n9IyJVKqCY+YncVqNVpl6R3mmBX4T8cyq7iPiWMh
   w==;
X-CSE-ConnectionGUID: 8Aeja/BdTmOj2uu8rbjjDA==
X-CSE-MsgGUID: RUG/e2eqSmObtha/wkfFmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42933388"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42933388"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:33:41 -0700
X-CSE-ConnectionGUID: jbyTp0YYSGCafIot6AyuwA==
X-CSE-MsgGUID: 8UHi8GIoSDiHSbuP7UGsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121135339"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:33:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 15:33:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 15:33:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcyHHoHGXSe45eWqceEVikgZqTXXuSbEMnLyOx4HZoVpAEIdxfxUVdMXl9ZAu1ylMPraPh336nUrqPeBHXpX/OfBfoCTdgFoekcf2sh/uQFiAML743p3Tbzc4S8vDJgwtmcQlelnN/jjKfmbGoCK3Fr3o5hgz2YMHzw26bHLBJ98mg7Rv6RozMd3Qgun+e4B1IqZb5j6V+KF3tXFP2kSmMR8ilktd5FdSMI6IXCBy8f/Pkj34KqETFZv82HAa626M24QZRM8l6PLgvJyQbmjOSpoV1AbWmZXJwwE0BCn2b91IKuERsG8o8sR0B3mAFTz2zmD3cVVwMbELSYEiGSZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ4YM9w4ta4kzFgZA5sBI+7kX/I9hzQgD7lrkbq8/zY=;
 b=xIlR4jxfFB9ZoGW2ZzRTAmPlIP92DoP8ScLnNDPk0lZCHrMgzAUhhIat/L/XiB8r4fvf+MCCB7eMQcbAsoth9V696ckK5UZJIgOYHtGz0gjQyqw/nQrL2il+TKH5jZPT/LwCpoVCHNGmb67MrymADQ0kaG7dn37JwDBMVVzfe+yRNCEiXdpfc0Fm3d+sp0QjsNgVEmy7Lvj4elqRpkhwT/aEboYX8iQ/v+fnYKpQ+rfbXo6+BTuPARPti4hRHgGG5o3GXjc27hR1xKGQg0SJQ4q0DFjZrI8A77Tdmzc0wUGsmKrJBnnLRovO3Imx5Er+DREGuhrzWDeVFkUKd9j3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 22:32:56 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:32:55 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "sagis@google.com" <sagis@google.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0Li0j4hIZraA0O6rldQIQB4e7NwJfwAgAAZWQCAARIBAIAAV9SA
Date: Thu, 13 Mar 2025 22:32:55 +0000
Message-ID: <da02e1d5a489526770ec737eac41237226cdb5cd.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
		 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
		 <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
	 <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
In-Reply-To: <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH7PR11MB7593:EE_
x-ms-office365-filtering-correlation-id: 470d87b2-682c-448b-37ec-08dd627f001b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ek10SlBVTSswbDduNGNXTjhYOUNDYU9GR1k3K0JGejJGR3YyTzhqTVBhdEFB?=
 =?utf-8?B?WFcrdHJMNFRFZUhvSkQxck1rcnZsUkRYbE1xL3pRZDVLd1ZEeEZScXJiM3FX?=
 =?utf-8?B?cVV3OXNMKy8wOVNOOXh4Q0pPUkF3LzA4Vll0NU1pWUl2KzZyZGY1OGZkU21x?=
 =?utf-8?B?RFhjRFpRTUdPT0lvOXlrUkMvYWNKeXNpQ25EbTAreGluVWozbllhU0Vwenpk?=
 =?utf-8?B?TituKzVTRk04SmxTTllLcWF5Qy9lbDI1OVpFYVQzeTRRc2RlVWYxWk1oQUhU?=
 =?utf-8?B?a0w1U0tvMXdCN2lXd2FiMXhJMjhMY0ZZTS9MUkJ4VDNXVmFLU2ZrL0NPN3lM?=
 =?utf-8?B?NjVTT3M2TXFWOGtFTGVlcW9vK0tjbTlvWm5VclBNNFU1YWxQRWN0OGl2aHhj?=
 =?utf-8?B?a3NHa2pNYjUxYmM5bnFTbU5ISzVFamZxTHN5dStUcTNvZnRsL3JWV1ZtZDI2?=
 =?utf-8?B?NitzUVFYcC9uV21xL2YvSEd4TGxqYUdmbUxmN2ZTaXRZcTVUdlY2WXFJRHNi?=
 =?utf-8?B?c1F3Mi83YUowSVR0b00zVDRlMHhCbUQxNE5LWWtobmpLc2lwb1hWblVBMVZt?=
 =?utf-8?B?ajFMWWJTR1ZoM3FBV0lOWmJsblNEZFhUWDdSWkoyTFZ2TEZyY1pPZ1p5WnpF?=
 =?utf-8?B?dExaelo4OXQ4L3NYaDNNRk4wbmtWc3FqOHNhWmQ3ZjdSdVlTYVgwbzZYUU1p?=
 =?utf-8?B?SGlKaEdyQXNpVmlZb0dVVjFUeElrOUlpQzNpbFFWVlpCb3dSeXVOYjRMejlD?=
 =?utf-8?B?VlIxVzFYaktJV2FVVmlnclhaMklRc1IrMzZKZzBtMGlubFRJR3ZmNElCUUps?=
 =?utf-8?B?WmN1VzRPSC9Vb3hXUXo0TjZNa29hN2FhUmZtLytHbmwzMzc2dU4zTS9wWlJZ?=
 =?utf-8?B?em5md3JzeDk1NE9IQUc1U3NkVEo2MWJoR3FuVUNvbkdESFlFaUZYSWFkL0ph?=
 =?utf-8?B?SnJKZWhkdkFJWXFuSGw5Vk1iK0RFcVlMMmZBSmwzMlVwRy9wWEpzOWh2VzA1?=
 =?utf-8?B?V3Zva2VKeE5vcUF3ci93d1o3akQvWXZQcW1zV3lveDhVZXBONHRNNVBZNDBj?=
 =?utf-8?B?ZkpHZWM3UXo4aGN3RGUvMjJqSk4vVWN5RTB6S09qS1ozbWx2NnFxWVNlNUNl?=
 =?utf-8?B?VzhxMWFSK3B0bnVDVHAxWGhYem9Yc3NwZmVFNDhZSDJzQUtiRHY0OEZNclAr?=
 =?utf-8?B?d3ZLaDVBMjJhRUhPQlJIQVhiN2p2T2dScTNMMXBtQ09Gd25KVmk2UHhMYjBk?=
 =?utf-8?B?TGdmM0VqaUlGcmZCblpud3g4V1dKSGVTdlVZbWsvWGs3UjUwYS9JbS9rZHVJ?=
 =?utf-8?B?V1N1RTF5Q2ZYYXJoTHUyUC9SUlhhaG1Cd1AySGxMeEtMQTYrd2oyVmQ3V0Jy?=
 =?utf-8?B?c0FNTXZtWEZsS3MvNkFNWVVsQkU5ZXZJZi9KWE1WdVNIdGRQcmNUU3NBNnlH?=
 =?utf-8?B?ZVNOekFPVW8rbDJrRFBJVlVtWUkwVVJDVGtTaUhyVXVpeHN0d0FlUC9WWHZw?=
 =?utf-8?B?RHZXbm1OWnhkN25EaG0xbmhTanp1OWZWem9YZlZCUWtpcEQ2TEh6bXo0TEZR?=
 =?utf-8?B?dSs5bk9ERVBIWEdqVEhrc3hlRlVzK2dzOTdJQlZUL2w0Y2tHZ05ETVZmMUhp?=
 =?utf-8?B?RVgyZFM3dkdobzJNMDhKdGpoYzluRCt5UmtZRFhrMnJEekZYdFFkZWZkdU5u?=
 =?utf-8?B?UGtKblZJT2ZnbWVjOW96V280VkVzN3hDclpCSVZ5K0FycTBleFJzaEprb2h4?=
 =?utf-8?B?MjZndGpadXpjRndyS1dyZWFZQ0VMendyOHh0M3o5MDB6c3FSSkdiTHJaN0RU?=
 =?utf-8?B?UmR6bTFpRWpsMFZkV2g0K2NRRGdnQXRJSUlyckYxV2prdWdjN1FheUxWbk5v?=
 =?utf-8?B?QUgwWjNSU1o2TzdGS0diNkR0NytHazFYS0ZhTXVIRlhYOUt2dHV0OGIvdGxp?=
 =?utf-8?Q?ZsINT8g0sNxqebw+H7GOitLZKcSF/iTE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVdjQncxVEl2d2t2eDk3dnYxNTN6Y1lwb2ZiTGozQ201U0d5WG1aZzJoQ3Ft?=
 =?utf-8?B?MjR2MThCRkx3TnVQd2ZCWFMwOHJDYnE1VkJLUjdUajU3Z1VySVV0a3kvajJ2?=
 =?utf-8?B?ZVNtYXBSVG9BSnZTTUtoMHlOdkpoSVlxSS9kL3BQZEsrc3I3M0R0RjZqYkNC?=
 =?utf-8?B?VzNzekV1MFpOdGhiM2tadjlIUkdaM0lkaktZeHZHemFEVzdKVkM0NHBudUxw?=
 =?utf-8?B?UGlIdnlOUkN6U0RURFJrQVBwMjlnMnRnYWJBZDJzNmJOUzkvVXN0N3VzZEdk?=
 =?utf-8?B?ZmJEQ05qZk1MMHNuTk16MVdOMlYxWmtMWEpmZG82SXhlSXZlbXNEODJWdWI0?=
 =?utf-8?B?RlJrTTlyUEFwRll0UGRiRGcvWGduNDB5aUNFTk1ZMCt2YldPeHhRWEVFbWkx?=
 =?utf-8?B?WDVydEU2WHhsSkJLZmRLbTBsMXl3NDQrTXQ3aGUwZjJRdHE2emFpUnAzQm1X?=
 =?utf-8?B?cFdvcThFVHhDS1RsNlJtUS92ZnBkazhwOVhoNk4yRnBSdmxhQ1h6R0FLWWRx?=
 =?utf-8?B?VWo1aWZlVllXeWlkU04wRXB4ZWRicnVlK2hIYWkwblYweis0T2lxYmRLVy9v?=
 =?utf-8?B?U0t4a0VzWmtQaEV2czhMRVNUWi9XRTBqeGJXQ1RoYm14VFFSVHc1NThLOG50?=
 =?utf-8?B?U1BBaDhHZ0wzNzBuaHo2Q3JjQVZFampHdVJpM2tlYitXTUZSVnUyREJNRnpG?=
 =?utf-8?B?aHdIVmlna2plZ2N6WmUwSStUNGxueDBIQ1dYd0FlNDNMMmpwS0J3dlprUEVN?=
 =?utf-8?B?RWc1UjFWb3VwUW1mcmNIcmExVmIzdmg4M2xseGdFa3o4NGM1SCtsS1RSa3dF?=
 =?utf-8?B?VlJSaXZHbHJZT2wrL3VOaGwzZ2thWXJUaFZVcEp6R01mSmZobkEveEVIZCtX?=
 =?utf-8?B?YlBTbDhVRms0U0VwUTh4c1BmQmtBMmlQdCtyVUNFR2VodXVKYnloS3hHNDUx?=
 =?utf-8?B?aFV3bWJheVp3S0RhUWVJMnI5QUk5V1FhcUlmOW5kMUVtSU8xemdpK1JnVU5U?=
 =?utf-8?B?YWJ2T0RPdHRWakdRNFdvQkc1ZlRGNUduVHZVOU1uRkNEVDlOUjkzcExvOFBj?=
 =?utf-8?B?THkvSlZFQXcyelMyVVlXcUhvTHhWbE9XNHlHVFl5NFdrc3ArUHptNllhKzN0?=
 =?utf-8?B?K1pacFFPbGJ5NE9iWjZqK2o4YkU2T0ttVG95U3dpYVVRV0NvdG4yZDBBNm9u?=
 =?utf-8?B?ZXVSVVFLU3dwVUliRnUyYSsyb1FwUUxaMEo3aFE1TTJVRi9jcU1vbFFiRS9z?=
 =?utf-8?B?cmRpUEFiNjJYVFBuTHNNMi9FbVV1ODY5V3NJZlJ0bWgwQVlqYVBNUWExM2Vz?=
 =?utf-8?B?NXd4ckZiUzl4aytWZGMxb3N6MndmdEJqUXFkdjBWaFBRbXVsYUtqcFV0QkZx?=
 =?utf-8?B?Zk5JdENuQk1zWGlhZEMwL3A0TEJOSXVHdnoyUlNJaG00NHJKT2d6cFdxUmtS?=
 =?utf-8?B?NmpIcDl6aDhXRHhGclUwOGhubjd0OFFOWURsWmlEcm5VTVptejBNcU45Wmo5?=
 =?utf-8?B?MjBBRERVaG9jYTNwVUZwblJqektQaHR2UkpjYStrVHpQQ2dTeVVVMW9sYzdx?=
 =?utf-8?B?N1B0cVdUdVloNlhiMmVVd0s3N2h2Znk1S3FBK0ZOTElScFM2L2x2bVU4bFg4?=
 =?utf-8?B?Y25HdFZyWDlDU1A5V1hqZ3dkOUlRWjB6NmZ3bmJzMlZCT1BDcWRCampMOG9p?=
 =?utf-8?B?NXpHaGt0dU5xNGFmTDI4dnNnNW12MEZ3UG5RdUV3bUhQOW9HR1dCR1g1V2M5?=
 =?utf-8?B?OGFpcWVRMlIxUmgxUmxTd3NnTGxFVEViUXFQakJhQXk3WTRlS3NjbkxuU29W?=
 =?utf-8?B?NjhYWDZJb0JwNzVFVm84dVBTd0s2dnNUdklVRHA5ek40R2FrQksvS1dCMGJW?=
 =?utf-8?B?Z3RDcTJBcnltSVgyQmZKdHZNOVh6TXVpc1BZSHFvcHZzQzBDMXJKMHh0WmI4?=
 =?utf-8?B?TWMvTzBsbU1xRDh5UHFqMkRQUlZ1RmxQL2t3WW9kQzR1bUk0RDhwc2ZPb0k2?=
 =?utf-8?B?ZFpKM2UxcEwwN0hXNENjUXVRSmxtNmthRDZuUTMwK1ZSS1puYlNxUDM4ZkdG?=
 =?utf-8?B?YlNyc0psUW9YdFpNVXEzQjhGQmZlcUxTV3h1blNsMHFCeFA5am9uN3huZDU4?=
 =?utf-8?Q?jcuRkmsnwK+sqNqqoVtlheo5P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89181657DC38354AA69F22A501345515@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470d87b2-682c-448b-37ec-08dd627f001b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 22:32:55.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShvFJUtdHdtIXDH2LgtEcV2v2vowWNk23YIBMwnUEZLSg2QI7j3a0gk2fPaonbGisFY2HHqX2/2LGk4kngd1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDE3OjE4ICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gT24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjU3ICswMDAwLCBIdWFuZywgS2FpIHdyb3Rl
Og0KPiA+ID4gQ29udGludWluZyBhbiBpbnRlcm5hbCBkaXNjdXNzaW9uLi4uIEEgcHJvYmxlbSB3
aXRoIHRoZSBwbGFuIHRvIG1vcmUgc2ltcGx5DQo+ID4gPiBzdGFydCBzdXBwb3J0IGZvciBrZXhl
YyBieSBub3Qgc3VwcG9ydGluZyB0aGUgZXJyYXRhIHBsYXRmb3JtcyBpcyB0aGF0IHdoZW4NCj4g
PiA+IHRoZXNlIHBsYXRmb3JtcyBjb25maWd1cmUgVERYIHRoZXkgd2lsbCBsb3NlIGtleGVjIGJ5
IGRlZmF1bHQuDQo+ID4gPiANCj4gPiA+IFByb2JhYmx5IGEgYmV0dGVyIGRlZmF1bHQgZm9yIGEg
bG90IG9mIGtlcm5lbHMgd291bGQgYmUgdG8gaGF2ZSBrZXhlYyB3b3JrDQo+ID4gPiBieQ0KPiA+
ID4gZGVmYXVsdCwgYW5kIHJlcXVpcmUgb3B0LWluIHRvIHVzZSBURFggKGFuZCBsb3NlIGtleGVj
KS4gT25lIGlkZWEgd2FzIGENCj4gPiA+IGtlcm5lbA0KPiA+ID4gcGFyYW1ldGVyIGJlIHJlcXVp
cmVkIHRvIGVuYWJsZSBURFggb24gdGhvc2UgcGxhdGZvcm1zLiBCdXQgdGhlbiB3ZSBhcmUNCj4g
PiA+IHN0YXJ0aW5nDQo+ID4gPiB0byBhZGQgY29tcGxleGl0eSB0byBhdm9pZCBvdGhlciBjb21w
bGV4aXR5ICh0aGUgZXJyYXRhIHBsYXRmb3JtIGtleGVjDQo+ID4gPiBzdXBwb3J0KS4NCj4gPiA+
IA0KPiA+ID4gU3RpbGwsIGl0IG1heSBiZSBhIG5ldCB3aW4gb24gY29tcGxleGl0eS4NCj4gPiAN
Cj4gPiBXZSBjYW4gYWRkIGEga2VybmVsIHBhcmFtZXRlciAndGR4X2hvc3Q9e29ufG9mZn0nIGFu
ZCBza2lwIGFsbCBURFggY29kZSAodGh1cw0KPiA+IG5vDQo+ID4gZXJyYXR1bSBkZXRlY3Rpb24p
IHdoZW4gaXQgaXMgb2ZmLsKgIEkgc3VwcG9zZSBpdCB3aWxsIGJlIHVzZWZ1bCBpbiBnZW5lcmFs
DQo+ID4gYW55d2F5IGV2ZW4gdy9vIHRoZSBjb250ZXh0IG9mIGtleGVjLg0KPiANCj4gV2hhdCBl
eGFjdGx5IGFyZSB5b3UgdGhpbmtpbmc/IEFkZCBhIHRkeF9ob3N0IHBhcmFtZXRlciwgYnV0IHdo
YXQgaXMgdGhlIGRlZmF1bHQNCj4gYmVoYXZpb3I/IFdoZW4gdGR4X2hvc3Q9b24gd2l0aCB0aGUg
ZXJyYXRhLCBrZXhlYyBtdXN0IHN0aWxsIGJlIGRpc2FibGVkLCByaWdodD8NCj4gQmV0dGVyIHRv
IHJldHVybiBhbiBlcnJvciwgdGhhbiBwcm9jZWVkIGFuZCBjcmFzaC4NCg0KVGhlIGRlZmF1bHQg
YmVoYXZpb3VyIGlzIHRkeF9ob3N0PW9mZiBpbiBvcmRlciB0byBub3QgZGlzcnVwdCBrZXhlYy9r
ZHVtcA0KYmVoYXZpb3VyIG9uIHRoZSBURFggcGxhdGZvcm1zIHdpdGggZXJyYXR1bS4gIFRoZSBk
aXN0cm9zIHdpbGwgYmUgYWJsZSB0byBzaGlwDQprZXJuZWxzIHdpdGggYm90aCBDT05GSUdfS0VY
RUNfQ09SRSBhbmQgQ09ORklHX0lOVEVMX1REWF9IT1NUIG9uLCBhbmQgbm8gdmlzaWJsZQ0KaW1w
YWN0IHRvIHRoZSB1c2VyIHdobyBkb2Vzbid0IGNhcmUgYWJvdXQgVERYLg0KDQpJZiB0aGUgdXNl
ciBpcyBpbnRlcmVzdGVkIGluIFREWCwgdGR4X2hvc3Q9b24gbXVzdCBiZSBzZXQgaW4gdGhlIGtl
cm5lbCBjb21tYW5kDQpsaW5lLCBidXQgaW4gdGhpcyBjYXNlIHVzZXIgaXMgZXhwZWN0ZWQgdG8g
a25vdyBrZXhlYy9rZHVtcCBjYW4gb25seSB3b3JrDQpub3JtYWxseSBpZiB0aGUgVERYIHBsYXRm
b3JtIGRvZXNuJ3QgaGF2ZSB0aGUgZXJyYXR1bSAtLSBrZXhlYy9rZHVtcCBhcmUNCmRpc2FibGVk
IGlmIHRoZSBwbGF0Zm9ybSBoYXMgdGhlIGVycmF0dW0uDQo=

