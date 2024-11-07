Return-Path: <linux-kernel+bounces-400735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A369C118D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FDA284F80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03505217447;
	Thu,  7 Nov 2024 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGm43Y9J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01C218D6D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017705; cv=fail; b=WZqdiWsTj8NreD3NNLRel+wPKyQM7PW/mVknc9LNudAWClYWBOiWngKFhy+kY1tBKSaMk7VxZ3wFSQ2n6uvsRqwlJZhmrq1y9+paRbCAD9M/DBhx0sXXZHYWFTGotPtZp/A/9o3OYl0R23CKv1QI0Q1Jde6+JVTqEnYeFee64Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017705; c=relaxed/simple;
	bh=MQNddY3lWCPbSHmjEeqYLC0niDHCbjowLxArijVFRds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=blQktCIZbmJ/Y3LQ6azmpCSMwWJfxZAM9mtcQasn7EIvnPygvL815haqwFraA3n8G+xvGSMbPYIhr3HLBgloUqC3mKBCbx5qY3P9gmX9e77CTZNOSzlfRE04L2KFkbR5vsGkOMhWKF6k9AqJhfTt3yUO0EvvVtKIomA9lYLtgW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGm43Y9J; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731017704; x=1762553704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQNddY3lWCPbSHmjEeqYLC0niDHCbjowLxArijVFRds=;
  b=gGm43Y9JjaxNWX1YFXX3M2AUSJ4TFaMH048ZzrkxHypaNDo9XqHmFbpT
   2AO7JYUc36nHIAPQp/Tx3QJKNkV/wqdUE5qj428rktiBiM09jN6yQd5WB
   k+MNMMlP4qY+9OLMSKDyO3wdL7oJt/bB1ezWrInly/z4WTgICPIh+GGu4
   K6+PxteGBa3NLb1zba7C+Km+UphAdc7x5eDluk5aJ51+yGwLkow+X8Y0X
   rw/1GQoZXLqWDkArEtlRI9Kk5WbShR/14Y5MxT89WJOda8zp3V+3wBjo5
   yPShFuxVPk3nbPwy0UCiMsh3jP7WRH9Fgrpq5l7D9P73Ynsse6ufpdjKW
   Q==;
X-CSE-ConnectionGUID: dL+0N8h3RR6aPCZiaddsqg==
X-CSE-MsgGUID: LIYDL31LS5ySCtJzAgFOLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41486911"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="41486911"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 14:15:03 -0800
X-CSE-ConnectionGUID: V9kzhmgpTTWHvyYFSLwjFw==
X-CSE-MsgGUID: Hio6LHi8RoaloHwPFbloAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="89808717"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 14:15:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 14:15:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 14:15:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 14:15:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTLxNQBlmhlQau2rnO6EmDe9Wa8nYIeHcnzDPEaNXWave0rty0nK46bxBPl1P6btEn8PxMMTWc4RelDpm0MJ6yywqV77reGJK4QsdBaPjR3iALMxGvND4bWqiAYiClSiMlTIMyl/J6ntC3mateIrPUU9UhALKC8+OQJkm8BWZbiIccyx+fleVoz30tuAapXBBz5Pc9RrgJFOmXPiG9ea6IdxZKi7OfN8GXrI4YfW5IQsQaBoqSI3+m7uOsrvFVU28DtO+DSHjLT8QrjWiMIcVUYqzQ9I9pt2cWRBq7JUZbNX1SZUUHjtUQDp15aMCfA7GKq7KQLJtngQpgRXoo31cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQNddY3lWCPbSHmjEeqYLC0niDHCbjowLxArijVFRds=;
 b=Cqam1FSe84P5K6ULl2GThkA6dZKvBCHZkqIaqzzE2vES2r61Cd2aMZA5P2df44Jr3lhDXHoZ+SzPevxzboyUeEfRU/OCJ2Xed0zUd2ogr9mOCgZu66zdZimEnJJb71fSTBwrraNUl4WIcp1WfOGEeLHa8hzQBB2IsoOqZ4pwJ2E/odRt9FELk1/xuLSxIWxxuMxrmFWjkUfajUGbWgs3OZfQdsB+6obImM4u2Clq9fguntvjlxAp18x3P9+FVrQwlI7fIz0Ery5TiwBTYaq7i9498o714YQt3vt/m7qFZXd4pyWRqsf8U6GBd5rQZczU4XEyrF8oINR4yba5kAItqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 22:14:59 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 22:14:58 +0000
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
Thread-Index: AQHbMGKkDArILeDR9kmWcus3jnj4urKrAt0AgAClQQCAADkYgIAAUM1rgAAapWCAABQ3gIAAAR6A
Date: Thu, 7 Nov 2024 22:14:58 +0000
Message-ID: <SJ1PR11MB6083BA9392D4B176FA2DA170FC5C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241106154306.2721688-1-peternewman@google.com>
 <20241106154306.2721688-2-peternewman@google.com>
 <f6b7dd9c-5ace-4816-842f-ac1265c0f9ee@intel.com>
 <CALPaoCioRrjwZPYDdkAApHAecqZVA_Z4rLctjmcpEaV04eq9Ag@mail.gmail.com>
 <CALPaoCgwCwUJHF7fCQrf98kFVdCjPyUTUiCOfYOi3XHJzvqiMw@mail.gmail.com>
 <ZyzxbhHQptbktfGH@agluck-desk3>
 <034d8377-6276-417a-983b-1af4617d60ca@intel.com>
 <IA1PR11MB6076F9F222A98125974C5CBCFC5C2@IA1PR11MB6076.namprd11.prod.outlook.com>
 <c4ced27a-b3e9-4727-9c39-7d1fd0cb0dd2@intel.com>
In-Reply-To: <c4ced27a-b3e9-4727-9c39-7d1fd0cb0dd2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV2PR11MB6045:EE_
x-ms-office365-filtering-correlation-id: 9c253e38-cfd9-4563-3f62-08dcff799e10
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YlN4c0QreUFLajluWlQvYUF0bXExWHFia1J6OFBEYUlUamhUM0RMNHE2OFpP?=
 =?utf-8?B?c1JnMUQ2SEZFbmFReVBDbWpQRlZkekpXRDYybVhzZ0kyQWJVN1dVL05qYWpP?=
 =?utf-8?B?a3dwQkVUcFc0a1VscHA4NlRTZ0plRkhVcmgxMWwvSXNvUEpxc0FKMHVGbldt?=
 =?utf-8?B?MyttNEVydVBxdGhzeFd6MDI0a1JnUmt0RGN4YVI4RTBwalY5aCs3bHRFY1lh?=
 =?utf-8?B?MHp5U1FQSXVFN3dhdEt1WHlTaGNaWnZUMmZpNGQ1MkVNUzhONjNDbEpKelZi?=
 =?utf-8?B?RTZHVUhhcjFJVGtKQjF5QWZjUG1ZSzRpMGpCcGVqdTUzOEh2ai9YWitpeEZU?=
 =?utf-8?B?OSsrVGJ3cWJpOEh6S0w1U29oQ0daa085M1RvczR4WTY4OXY2M0wwTy9XMC9T?=
 =?utf-8?B?RkJiMm5Ud2lVeVhSajlDQ3ZUcURaU1A4RDlEcVVyZ0g4YWVSK1VxU3huK21s?=
 =?utf-8?B?cUhOQ2p0K1RmZlhIaGFyY0x1VGQrK203MDM5b2g5WlN0TC9JM0Z5RnR3TzFV?=
 =?utf-8?B?VTJhTTNwTm5RSkViOGxSekNSSlUxNktYR3p3TktiN1NPZWxDclhtR0VSbGdU?=
 =?utf-8?B?bjRUdS9rM2twYXZnNEprYTZSZTE2Zjd2Tm0rQytaejNFLzZxZmNteGQ4Y1JX?=
 =?utf-8?B?WitVcXUvSk80eUFuZ1h2K1VUdWNDbXh6UWhwNlZxbnVacHhydEVrTzhTRkxv?=
 =?utf-8?B?K09ha3FPWVNCaDkyRm1XRm9YbEs5eHhWb0w5WmNGNWxtd0ZWbjlHSUFuWlRh?=
 =?utf-8?B?c2pnTmpRNFVOQVh6L0twcUFqQm95bDIzd0hvbXJNNVZGcytHR0lUZW1WbU9I?=
 =?utf-8?B?RXNmREJsam9hYXBnb3crSGhvbmlBeS80UlpudG5NQWpSeXpsZFQrdVg2WUt5?=
 =?utf-8?B?b2VFUm55S2Z5Mjd5Uks0ZVYyOVB4Yjc1MUg0YlgzNlArYnRoTjQ4NXFmcmpK?=
 =?utf-8?B?L3FiNEQvcUhOWXhYckJ3RGl3WE5zcEZ6MzNUdmVzYWQwSGVOcEFtMHF5Q242?=
 =?utf-8?B?SW92QzJYdVd5aStJMkhiNllVQ2E1QVhiUG9iMC9nNzMyRmFZY1U1cnZFRkhk?=
 =?utf-8?B?MkFFR3lXemRGQlJSVTNId1NoNjVEYkhhNGNPUHF2Z0tkSGtPMlZaa1NzeEp4?=
 =?utf-8?B?dFNkRHg5Q2JiSjQ1NHpEM285M2QwMTQ3OEswOEtONFExZGlwNVRaZVk4amt3?=
 =?utf-8?B?c3NjMURQZU82d3lsVkVjUTRFQkRnc1AzVnRJemg2Z25WWDdlai9SSnFQWmZm?=
 =?utf-8?B?SVViZzZNdklDQ1IycFN3ZlpGUDhmWW5KRjNuZkVhTHZoZ09RRnZDRS9oYzNh?=
 =?utf-8?B?YzBhcUxDYXVnc0ZUZXNaUXVqcXp5cmpNRnBJOU9qN3Zod0d5MU5FU1htTkUz?=
 =?utf-8?B?enJYaU0yNm5uMGNoT0hhSTNGZ1VpbkIyUmF3eWl1VXpnV2ttMUdCYjlSTmpn?=
 =?utf-8?B?STlnM0tqMzhxYTNzb3N5cFp1bDVLd2hSeHRKRjBERk42amczMFJhdHFRNUxp?=
 =?utf-8?B?OGpWV0hha0FyT2owYWdqWnhBZ0k2ZjhKQzhQS1VmQW00dGhFV045SGNkQk1O?=
 =?utf-8?B?b1BnakI4bFpZaWNicTRuMWxrZTZPaXhrNjRxTVlkOFRwY0pQNzVsSzhUM1NC?=
 =?utf-8?B?c080ekM2NDVQNWNCQVBQY01MQWkra0ZKcVAwZDVCSVI0Z1FKeWhuZEJNS3Yx?=
 =?utf-8?B?cnNLeXNCY0hMRmZ4amNCZWp4MzVSQTJBZXp6a0c3WmxqMkJ0aFFSYjd3Nisv?=
 =?utf-8?B?UnRoYk1LdW9NV3cxdTY3NVdqNmtHRy9YU1RZcUtoMmtNQnlxZmozWW14Q2xm?=
 =?utf-8?Q?65r+gNExgmTzLL7MyhRzOCwdoS+1/1bqYNrbk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHdaai91STZiWTR1cEdXSEUwVEE3QVA3Skk5NVpPVGZuc21iZFdrZDZ5cVkz?=
 =?utf-8?B?WWVZQm9jbTk4eXI3YWhXTFZoRW96UWsvQU5ZL1JEc1MzREJCbzB1YTkxNVZS?=
 =?utf-8?B?MTNaS2VPVEVwdStSWFZyb0ZZcWppVlRaOGhGb1kzWkVob1Jkei9WRGxQR2dK?=
 =?utf-8?B?Vkg2QzEvRWJQeGhDdHB3dEMyYzJSaTV2N3JxVFhwSnh0MjRqYk8vb0pHZU0x?=
 =?utf-8?B?ajZ3ZzFDUjJtNU1ROGlSVml3b2dqRWFHRDV1Y3VvYTNDZUZ4TTRrUXREL2Fo?=
 =?utf-8?B?dk5SSUVyQ3lsK0k5ODZiZWFiMzdLL3JveFp2aDlwczFPNzFOOS91ZTJKM2pO?=
 =?utf-8?B?Z3ZDRUtQSmQ0QkdQYUF4Y2toUXFqYXlPSEFGbVFOdjJYTDBRTEExaFNyS0w5?=
 =?utf-8?B?dC80VFNqNWluWitZcUVxci96TzlKcTZEMGFNcmE5eEx2eVo3UkkyUmUxSHFL?=
 =?utf-8?B?YVVDZVMzbGQ4Q3hocStlbHhXbUhKZ1hwVFBzb0Y2QWtKUUhjWFU2MW12U3lI?=
 =?utf-8?B?OWdWNlYzcjkzaDBhTmlDR3p4bW95VVBtWEdjZWNRa1B2K0lKcWlsYy9BSEN1?=
 =?utf-8?B?ZnZBbGU2YlVPb3hpMk5jenZldkFCK0xhUjU3Mmc1djJpdzk4RDVQU3BTcTlL?=
 =?utf-8?B?MUExTll1WUtLdHMzd2lpRzZDZXN6aW82M05iUXB5YVVjM3dQWlN6MXpZdFNx?=
 =?utf-8?B?QnZydGtBWE5zTVc4a0l5dERIdUFWb3RuSkg3czNhQXRBTkJqZEcxT2lKM2V5?=
 =?utf-8?B?QmhoZkgrNjNDMk9iZUtLS0xDQkRaaUZBdHNBK0p0a2VFMFZOT2grWURqUDNL?=
 =?utf-8?B?MnJCUXIza0l1UElIVkJXeE5XWE8yd2N5RnRYbndWRkpJcUx0N3FXMTJCWEdp?=
 =?utf-8?B?L2JERzkyMVNUbTRqWjJRYjBobzRBb2JJK3RyNnBxMUcvbi9vMFhlOSs4Tzlm?=
 =?utf-8?B?czJqOXVsRnBwbnZTeG8vc0ZlTG1rakRCQWRwd3JoekRMTFdpQ24wZy9HWFJy?=
 =?utf-8?B?a29ua3F1eWd2SWN4cC9qZ0RUeGxWb0tyZXQzMDRQSHJGZlhFQ1JQVWdJRURJ?=
 =?utf-8?B?Y0s3WWkzdk9acy85V3lTd2Y4b2kwcGg5MEtCVDN1Wng5QXlLZlBwN1N6azZZ?=
 =?utf-8?B?V1gxVmR5TTNYVTB0NXBRWkYrbHpxM01aVzlNYzlKUk9hRXRrNGZwWWNjWkhp?=
 =?utf-8?B?VFViMmZWRlM1VmFDN3JKV3NzeEQ3QnBBVWdVeEd2T1FGZ1ZJTXFmYmNMWkN6?=
 =?utf-8?B?alBNZ09RcHpXRWRsNVJjd3ZiY3dWd1ZkMjduOE9jNHFaWlI3RlBiYmp2ZGp5?=
 =?utf-8?B?MzRMMTUvR0NGVCtoVkJxaUVJeFB1TVNxS0NyUW9uVi9CTEZkZGh6bCtzbGVZ?=
 =?utf-8?B?akNDS0RseXlVcHZwRnJvd1JzZEMzZVRHR0pHQVJSbmhkRmpzZHUyRDJaTytI?=
 =?utf-8?B?c3VZVHllVm9vZjdia21RMnZUZW5BRmZ4MmgxeTBIVElRamxXRUZ6c2NHaXVO?=
 =?utf-8?B?ZWNUNVNqd0dhcmxwRFh4a1hick5uaFRqMUQ5NXFhK2w2WmZPdDU0ZmlKOE9v?=
 =?utf-8?B?cnM5YWFRTkc5QU5IdlhnVzRuK1M4WCtnZ2tWdDNnZmd6Ym9FTkJISDFPSUZw?=
 =?utf-8?B?K1JrOXJzRzhoOGkrcE95THkzYlFTZllwdzRyamw1YllGWWd2bXM3K2JqN2dh?=
 =?utf-8?B?WFZZUFBDY2lyRjhwVEp3bmtJaDJBcURkMFByK2hzbXZBeS9FVXI2TTFvM1RK?=
 =?utf-8?B?NTFsTkNLbjlyTTRiUUUrSVltN1hxdmJycDRZZGM1L0VIRGVZUWJIaE1JbnVo?=
 =?utf-8?B?NXM0OUZ6RUpOTnZOY1ZxSVEzVGZ4eXIwM3dqc1poaGlISEtzd2NiMHVYc3lo?=
 =?utf-8?B?ai9JcGJEVjM4K1RWcFRkeHhtY3c1UGtrQ3QwNjM2QzlNUzBNM1U5M1RKalRx?=
 =?utf-8?B?cUJRZnVTRWhPaW1pSmZmZUd1N0xwdU16aG9EQ1ZGYWwzYlRrRzcyZk1ZdUVY?=
 =?utf-8?B?RGdYSXV3VGRucnM3emtpNlBwMGdOTnpTdmJ1cHBWS1duY3NmbDVwRmFLbGtp?=
 =?utf-8?B?Tmx3ZytjQmZUdHdiZnNmQTRTMm4vY0tYcHk5STd0dmRpb3JRSnQrMk5HcVJG?=
 =?utf-8?Q?6hFKoTZC9IpVcfc15v940PB3M?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c253e38-cfd9-4563-3f62-08dcff799e10
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 22:14:58.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lv2eB2ECnox7lH/aXAtcHc+pTOrqBhmzJM9bVV490/12Z/ixZhZIpTu30DtcJGKstTh/ySKhO9ARogRnCg79ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com

PiBJIHRoaW5rIG1heWJlIHRoZSBpc3N1ZSB5b3UgYXJlIHRyeWluZyB0byBhZGRyZXNzIGlzIGEg
dXNlciBhc3NpZ25pbmcgYSBjb3VudGVyDQo+IGFuZCB0aGVuIHJlYWRpbmcgdGhlIGNhY2hlZCBk
YXRhIGFuZCBnZXR0aW5nIGNhY2hlZCBkYXRhIGZyb20gYSBwcmV2aW91cw0KPiBjb25maWd1cmF0
aW9uPyBQbGVhc2Ugbm90ZSB0aGF0IGluIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIHRoZSBj
YWNoZWQNCj4gZGF0YSBpcyByZXNldCBkaXJlY3RseSBvbiBjb3VudGVyIGFzc2lnbm1lbnQgWzFd
LiBJZiBhIHVzZXIgYXNzaWducyBhIG5ldw0KPiBjb3VudGVyIGFuZCB0aGVuIGltbWVkaWF0ZWx5
IHJlYWQgY2FjaGVkIGRhdGEgdGhlbiB0aGUgY2FjaGVkIGRhdGEgd2lsbA0KPiByZWZsZWN0IHRo
ZSBhc3NpZ25tZW50IGV2ZW4gaWYgdGhlIG92ZXJmbG93IHdvcmtlciB0aHJlYWQgZGlkIG5vdCBn
ZXQgYSBjaGFuY2UNCj4gdG8gcnVuIHNpbmNlIHRoZSBhc3NpZ25tZW50Lg0KDQpUaGUgaXNzdWUg
aXMgdGhhdCBBTUQncyBBQk1DIGltcGxlbWVudGF0aW9uIHJlc2V0cyBjb3VudHMgd2hlbiByZWFz
c2lnbmluZw0KaC93IGNvdW50ZXJzIHRvIGV2ZW50cyBpbiByZXNjdHJsIGdyb3Vwcy4gIElmIHRo
ZSBwcm9jZXNzZXMgcmVhZGluZyBjb3VudGVycyBpcw0Kbm90IGZ1bGx5IGF3YXJlIG9mIGgvdyBj
b3VudGVyIHJlYXNzaWdubWVudCwgaW5zYW5pdHkgd2lsbCBvY2N1ci4NCg0KRS5nLiByZWFkIGEg
Y291bnRlcjoNCg0KJCBjYXQgbWJtX2xvY2FsX2J5dGVzDQoxMjM0NTY3ODkNCg0KSC93IGNvdW50
ZXIgZm9yIHRoaXMgZXZlbnQvZ3JvdXAgYXNzaWduZWQgZWxzZXdoZXJlLg0KDQpIL3cgY291bnRl
ciBhc3NpZ25lZCBiYWNrIHRvIHRoaXMgZXZlbnQvZ3JvdXANCg0KJCBjYXQgbWJtX2xvY2FsX2J5
dGVzDQoyMzQ1Ng0KDQpCYW5kd2lkdGggY2FsY3VsYXRpb24gc2VlcyB0cmFmZmljIGFtb3VudDoN
CgkgKDIzNDU2IC0gMTIzNDU2Nzg5KSA9IC0xMjM0MzMzMzMNCk9vcHMuIE5lZ2F0aXZlIQ0KDQot
VG9ueQ0K

