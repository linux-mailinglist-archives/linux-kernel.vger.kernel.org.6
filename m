Return-Path: <linux-kernel+bounces-405431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033389C5142
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D01B2569B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499C20B808;
	Tue, 12 Nov 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/MHSKrz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26120B7FA;
	Tue, 12 Nov 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401554; cv=fail; b=j9Kt8ud2asLUYWc5l9NdBKjDt1FwUOBrUgEOpdxsV+rDSdSs08RE4xiAVooQyOIjXywV4W0M46daYhEYqFvr7LZSEDEWSEfNZkB0+2oNnv1af1dBtEx0ZbyRe7adG1y7nxHIxJ4YWWjeKF/x9k/8qSijq042hqZ9s2yROnB8wnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401554; c=relaxed/simple;
	bh=uSlde0IslZ+7eWgZl0Lh1BeeTwolt/WpLhvWnnhcfG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZfK8Oxl0MJXE66SlqJyj4n1n3sDVZKcZNOfP4pyXtavFCd0B3lJi3dKfls6vQBMm7Y6NXUpu7fbIJjCbh0+b/JiNXS0hfY5A5mYzDhxQSQdsJ1yd/dk0dEHi/ZWwNv4ijVut8kjOWDARArwv+ZBTgHeT9PSp5iLU8kMtpj72J0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/MHSKrz; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731401550; x=1762937550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uSlde0IslZ+7eWgZl0Lh1BeeTwolt/WpLhvWnnhcfG8=;
  b=T/MHSKrzWNLSjdVM5DIdFgQ4OXKs8R4UT9HJdhSAALdSNwrMpHA8cKzW
   TB3nsueC0WvCtZglyKAUnxQybsIb5YULk6yjqIROS1JqLXsOfAG8FFREw
   ZIlexMS8ylU+ZQQQ0/gBGxzQhYvJH9vDCneP0pysgMkrV/fKoh+OjBiwm
   dxzi5A4OburBYisaDAw6dCvwMWom3VDHGy4+WZdTOb/w/xhXl05+QLZ1o
   5ud8tmeSz3OpSfO33IvXWQutalgcF3Bw6/LJ81OwjvNv1Tl3OrRdzFn5e
   E/1qtuZpXqOBwJlg2sNvYsi8PJXk+5rr/+nwKyaB71fQMIP5I1QBXo3hO
   w==;
X-CSE-ConnectionGUID: 7uhLEcdqTQqu01EzJ4t1MA==
X-CSE-MsgGUID: Fcrz7LI9TyGmTMvK367KHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="18836024"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="18836024"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 00:52:29 -0800
X-CSE-ConnectionGUID: DJGyBp0LQKyEmgBphKVp0g==
X-CSE-MsgGUID: MwdrMK8SR6akR3lsmB1n2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87761009"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 00:52:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 00:52:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 00:52:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 00:52:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTiMkE6hNy0xL+Tcgjipu5Ld2U5KkMfb/IL2lgmKPZi/Oogaq5mYXNtTmsdjLVotlBa/yMWSISMw46EwHTz84rWKoAu3M2qv6NUE1+9BrrBYlCe8LDBDO/2VgOR4OrpqAbcBBBQqwYdS7hP2SxdkyAMkUQ++/qsXU4VKee/hZCuRy2xC39NQP75DBveDRkg5IUnDBCK5+vtajJ7GGRtBIaXbQQEazuYkfhzN7KFOkMOjnbLy324Qyc3Ra321MP+bxuWRBcNzd3gHXeDCFkewknb+yBVJ7L1T9VfXN/xhe7NbnYGdBFN3e/900tGTCPcQaRtHAZP5VwnZRfkFPD3unQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSlde0IslZ+7eWgZl0Lh1BeeTwolt/WpLhvWnnhcfG8=;
 b=mPo8B0EVwKXCQw59shHyJLghif63wdOLXrbSVmm3zA78Gu1s/HjBoH2gKL31Xk48mFeVI8FMMj0To3PYVy0d4UJUCYn1uFD/famb1eorpttvYXAO73xqNJ5s92g5Yw7jBizenAM1v+amNFg9UBvNFgpwHJqtS2Fc+hqpLCvwLMh9QlOO+zn1NeLQq6umaz6ie5gXcpGswlopKjM13Tv02unjk7V0HadUnUmANTopOyFHGUTIFBRPyY7SJjEYojkWXhCXd5VA4doRggsu3HEo1+zlByrj0Rta8YPakVnDadJZxBTXOep1oglHjwTbdA+PLOD/+sQgwUiOtWbW33vGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 08:52:26 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55%3]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 08:52:25 +0000
From: "Xu, Even" <even.xu@intel.com>
To: "Aaron, Ma" <aaron.ma@canonical.com>
CC: "bentiss@kernel.org" <bentiss@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "jikos@kernel.org" <jikos@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui1"
	<rui1.zhang@intel.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Sun, Xinpeng" <xinpeng.sun@intel.com>
Subject: RE: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
Thread-Topic: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
Thread-Index: AQHbJexOlqStX2GM7kymeEIvMWZKNLKxt2GAgAACx0CAAArCAIAAAG/AgAGULACAABgnAA==
Date: Tue, 12 Nov 2024 08:52:25 +0000
Message-ID: <IA1PR11MB6098FA19368C76792457FD02F4592@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20241024081023.1468951-5-even.xu@intel.com>
 <da650a93-6d21-444b-adb7-045566f53d5a@canonical.com>
 <IA1PR11MB6098D581A332E576528FD30DF4582@IA1PR11MB6098.namprd11.prod.outlook.com>
 <1a8f80ab-135e-4e57-b9b7-1940e4bfb4f3@canonical.com>
 <IA1PR11MB6098DE17D19343A9C077F248F4582@IA1PR11MB6098.namprd11.prod.outlook.com>
 <53ed1dd8-2949-4f05-a180-39c12fbe2597@canonical.com>
In-Reply-To: <53ed1dd8-2949-4f05-a180-39c12fbe2597@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|SA3PR11MB7584:EE_
x-ms-office365-filtering-correlation-id: f2467e68-c905-40c7-f68e-08dd02f754c2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cGFIVVgyTnNsWUVLRWFnck5QZmdReFhMV3NRb3BxZ3ZKU3lyVURQRFdKUmJj?=
 =?utf-8?B?MEFqZHh5Y3pEVFBwRm9lT2ZBc3RvYVU5NjRtK2ZOdzF0M2VqaUp0bXQxSDJ3?=
 =?utf-8?B?UVVZT1NrT2g1eUhrWnpHU3VrQUZBMnRxd1p4YURYemh3WUluS3VCS0dTOWpS?=
 =?utf-8?B?ckJJVjZJV0hNYjNBNHYwak5yU09nbnJJb1R4UjBxcEhvNDhQR3FPZVBIMnFS?=
 =?utf-8?B?YWYxRWZFSitSeTc5WnpiUnZQcjR5WXlGMC9Ta1RyaDJEV2JHNzNwUy9aTzM1?=
 =?utf-8?B?ZXBmOE90cFRwTUtLSWMwVXFKcEZxdEtacm1mSnQybVJiNHlIdFBmSGIyb1BH?=
 =?utf-8?B?UkFPZ3BWcmR1bHFyNWR0b1dSd2g1cHVOQUVTaEFjSnVyS1lxNFNnRkRNK3V1?=
 =?utf-8?B?Tm9JZHN1aCtqdWV3RDlDTzRmYU5hRGFmUHBCOEVubFh5ZlNxa1M2M0JhVjFp?=
 =?utf-8?B?OHhNdUF6VG1ucjd2Y0JSRlRtNk5TcWhDRzJZaGUvdmFtOUlweTZ2MTlwRUZi?=
 =?utf-8?B?WXZUdjdhQzdZbUhMeC8wZ3JuQTNUWVZIQkMyVTFzWklsUXk1Ym9Cckt4OTln?=
 =?utf-8?B?WmVrNThHaSszdTllODdaNnJ2RHNSS3ZsQk5TOHVneGpFUlhUZFBvMUU0TnhN?=
 =?utf-8?B?MVczVVR5bE1RSEdEU05IT0tmWjJhZC82SllpeTdkU1pXVlBiSU5qdm83Qkp2?=
 =?utf-8?B?a1lHblJXUHJvcWJYQnJzb2ptanBHd09hQmdZVjdOS0p5RU5TZGJHUHBHNklB?=
 =?utf-8?B?clJ1cGMyRHVKQ092ZFE4Sm9INjh3REVKYzNtVXpxTU5IbGJLdHVNaVlHUXZW?=
 =?utf-8?B?NklhbXRENENBczlJQ3dzVENySE42dnlueVMzeUdzNUsvOGlGbkM1eGpGYnRs?=
 =?utf-8?B?dWxLRHBnRUJQaEErZFpsdFVjLy9Dd2ZrdlIzQlRVTnhMUDN5aEFIblREQm5D?=
 =?utf-8?B?cTVSUzB4MU5uRHVrMGEzOVZHWUJJN25TcThGTllHUTBycXdha2dwYnJmY2Yw?=
 =?utf-8?B?SnpPV2FnSCtjRE8vME8zcHJqMWpSajdhSW0vV1FLVDBKVFVTTlY4WjZ2RkVT?=
 =?utf-8?B?cTRkMmo3RlR6MmsxLzQ3U0ZxcjBoOE9qdnVvYUJ1RTc2VjBZZzFkTzhuMSts?=
 =?utf-8?B?UDZFRUVMVk1ab2JYZjNxWWtEUWtlZk1qQ1d5OGtteUFxVTJyRFRTRFFyVGg0?=
 =?utf-8?B?UEoyM2VjalRYbXNEZUUrdVZLSzJVWWh6VjM1alRiUTdSZktGcWhmZERlKzdM?=
 =?utf-8?B?eHFvUmo2bGZXcEtGRlV5eE1aVGRWUko0ZFBya2VCbnNadDgvSEd4ams0T0xM?=
 =?utf-8?B?V1FJVFVHd0sxb1RhVG1va0JYaEVNR1UrVzAxRmh6MHhuUndNc0xSQmFDWnV1?=
 =?utf-8?B?VVR0bFM3TWtpSG1lSE1hb1hsb3NpbU5VREhpMWdXYTZCNFRVbW5OcG5sRExp?=
 =?utf-8?B?Y2lRYmhEbEppZUtPWjdCWVNPVUs5dGZnV3N4Unl4TVhWUjJmdmNRdXZLaXJF?=
 =?utf-8?B?UG9pRTc3L3JMcEdUWng1aG5iTFNvWXlxOE5CcnZMeWI5SWV5TStvZlM2cGEv?=
 =?utf-8?B?Sms1U08vcFYvOVZqREJZY1BwOHVxQTBTWDBCb0cyYk9oTUFVb3NvZWhKM1B4?=
 =?utf-8?B?TXJpL2VYNTl2WFVOaHZieEltMHMrczJST3MzWHJ5ZDBMQmQzRHE5M0E5R3RT?=
 =?utf-8?B?bUNaa0Y0cWFvMVdEdVNXcGw2dG95c21MMm9tYmdHTTZOeWZwOGJxWHdLV1hK?=
 =?utf-8?B?ekxQQ0VTUzFUVnliN2luOVA5a2VsTW9reG5vVy9xWEhLQzk4ZGlXNWFNaGpr?=
 =?utf-8?Q?t4MGbJ+5Xkr5ClATKMX4nQGgXwu1eYMAKlVl8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFZ0UGtWZlZmb1IxZWJzTG52a29Gdmc4aGlFam9qUnl3SytwUWFjaFZnRU1x?=
 =?utf-8?B?Z2lTcjJpRVNuVEhqNjAyN2VRSGhGQzJXVVJEMWtub0tveE1TNm9BWklYVFBE?=
 =?utf-8?B?MnVNRDVpa24valEyRnBIWm4rVjNjN2F2UFdSaDNCQzkvSHlaNm9Sd0dXL3Fz?=
 =?utf-8?B?eXlQMTNSQ1J2emQrd2N4RnpUbHJyQVlqUG5lOElKeHhJMDNxQ0QvREFHTWpv?=
 =?utf-8?B?b2ZCQ2hISld1Nk53cERyNzdKWkVEY0JGVnAvS2VIajMzNTNvZVBQS0UzeTcv?=
 =?utf-8?B?UGFHNDlUYzZFV1RWY2k0aXpzYjVjeWJ2VWFValltZEU3TWpKOTB5QWE5OEhy?=
 =?utf-8?B?ZFE4NHlqY0V0RjB1VmxmVE4xZVVxMzFFVDhHeG9YT0szMkdrSnVyZXZTcTBt?=
 =?utf-8?B?bG1VZXBYQmpGdkJvRUJhVEVHekVZZXc4Y3dwRnRUNE85VExkUnNCeE5MNmRq?=
 =?utf-8?B?U3EyUDVCK2hVMENScmVDNW1INXVhdDZ0V1NYaHNxRll0cmRxVlJRaXFRWmZm?=
 =?utf-8?B?QW92dG9oWmlmcjhRcnJCUnlxdXJJTHd1aEw5ZmhuU2ZGZk93dWZrNUpHYnhz?=
 =?utf-8?B?UVZnU1JqU0k2RXEvOFpwSkJFbVp3QjZoMmZxWTVpV2hjditGdC9GYUxSdlh2?=
 =?utf-8?B?TXAzcnhlZkQyejBpSHpyZjZZWkUveUdGYlU2YUxBZnRGS09pQ01CdHVwc3N2?=
 =?utf-8?B?eVlIK0dyNTNVSmFBNklPZlRobVNNTi9IR2QwVW1ZanhjU3N0a05BQllablEv?=
 =?utf-8?B?VVZKa1dwcTVGT3RGQ0xjLzJISml4cjArSkc0ZWIrNHhpL0hNdzhTakFsa1Nj?=
 =?utf-8?B?cG5VTmd1MWg3bHhYd0oyMzcwcHhIWXBGbS9LUXYwTklXejBIVVduRGxYZ3Zw?=
 =?utf-8?B?czZkeVhKRHNMNTZlK1ZLUG9NeW9NL1Y4VEVRNVRHdVV1dEdNSUFTaXpWTlBB?=
 =?utf-8?B?YkpybUtXV2Y5VWVIcUsyc3REdFJ1bDdtZ2pncldJbkNCTDJvZE42cUg5UHoz?=
 =?utf-8?B?WWVZc3NZS3JIUkp0YWNwbXc4cDNqZGh3cXlJdjVzRWVSTVpNaG1NN2ROU3cr?=
 =?utf-8?B?NEwxOXlVMWEwaDZFMUZXWGtSTVpCL3UyallYc2lKeUtaTzR5Y3hqQW53enBW?=
 =?utf-8?B?SjVKNEd6T1RtRVB6QUFPODZXZnlVUElHRHJ2aEJxV3JuOS9EMUR6alZMRVh4?=
 =?utf-8?B?NEpRUkZ2WWliUjQzdkw4YlBkMFE2OWJIRVkxNmpFTjJ3dDZUQk9yMlZHcTVj?=
 =?utf-8?B?M2E1aFNWUXd0MFpzazBOM08yZ3JGa0gwTnRRL2pVQkcxeHkzTW1MT2M3SWU0?=
 =?utf-8?B?SWhubTdqYzArMitsZ2piNVp4YjJzY2hvUEhOWm1tVmpnV2k0cjdVeDlxOEFk?=
 =?utf-8?B?cHExSEYrYUNlTm90WE9veHUzQ1h3SkltdHpFeXRqMXkzN252Q3pGYUk3ZElk?=
 =?utf-8?B?TEZvL3AzR09tOFVNRzVCR2xkTGs3SVZOYnhPMzA3aWZ0eXVtdXNPTjBaeTJO?=
 =?utf-8?B?SDdDaG0xSzZ6U2h0VlV0QnBOUjNBMVdJTVl5QnhDb0cxa1dKdjFSdk16NEow?=
 =?utf-8?B?anQ3dlhyZ3FrUGhXMElOUTV6VVBadUlZWjRSN1JsRlRFaXF3T1JiUUFYUUFu?=
 =?utf-8?B?VVlFaWg3UUVkQUJQYlAxZVNPTEUrelhJTThWajNsaTN1WDRjc0hqamFqVnJO?=
 =?utf-8?B?UnhVNm1tT1ZsNDZoWUtRT2J4T09Ld3BSaXROYWF2R2liUGhWV3NkZVd4OXNx?=
 =?utf-8?B?NExLSHlXUXJmS1d4U1d5YnJzdEdOWEY0TmxWOElqUy9ocEhzZVJ1Yk43ZUQ0?=
 =?utf-8?B?RWIva1Job0xWY2JHZWUyNXNIRG1nR2gzL3FRWG9qcVdWTDJkRVNVUDZlUnB1?=
 =?utf-8?B?b080UkxvdVB4WXZ3NG9tVnA1dWdwcm9ibGRvbzd0RVJYTkI2QWFaR2cySTRh?=
 =?utf-8?B?RHZ0QlRleDk1RkVOQUlDcHdhSnQ5T24wU0hOS0hxdTdtZUpaVXZlNWdaR3lR?=
 =?utf-8?B?VVNEZHNCTDErM21IenZ6OHQxOXJ3TWYvbjZINU56NXNKVmtnRjhSbDhsdDEw?=
 =?utf-8?B?Z05ncU1sVXcrb1FPYUQzekIwSUUra1c4Nnd6NjRNRGxvaWduVzNESWJXU01C?=
 =?utf-8?Q?aueg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2467e68-c905-40c7-f68e-08dd02f754c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 08:52:25.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+vmAOQ/fpnEnBXuOmqHMCjMlei7VwO4oJSbhXZFiroAzU3C37m/gR42Q2Ws8vIBrkVDAYlqcgewLm39KMOPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
X-OriginatorOrg: intel.com

SGksIEFhcm9uLA0KDQpZZXMsIFRIQyBkcml2ZXJzIGNhbiBzdXBwb3J0IG11bHRpLXRvdWNoLCB3
ZSB0ZXN0ZWQgb24gV2Fjb20gdG91Y2hzY3JlZW4gYW5kIEVsYW4gdG91Y2hzY3JlZW5zLg0KSW4g
Z2VuZXJhbCwgdGhvc2UgYXJlIEhJRCBwcm90b2NvbCByZWxhdGVkLCBpZiBzaW5nbGUgdG91Y2gg
Y2FuIHN1cHBvcnQsIG11bHRpLXRvdWNoIHNob3VsZCBjYW4gYmUgc3VwcG9ydGVkIChJZiBwYW5l
bCBzdXBwb3J0cykuIA0KRHJpdmVyIG9ubHkgdHJhbnNmZXJzIGRhdGEgYW5kIGRvZXNuJ3QgY2Fy
ZSBkYXRhIGNvbnRlbnQuDQoNClByZXZpb3VzbHksIEkgbWV0IGEgc2ltaWxhciBwcm9ibGVtIG9u
IGEgdG91Y2hwYWQsIGFmdGVyIGRlYnVnZ2luZywgSSBmb3VuZDoNCjEuIFRoaXMgdG91Y2hwYWQg
ZXhwb3NlcyBzZXZlcmFsIEhJRCBjb2xsZWN0aW9uczogTW91c2UgYW5kIFRvdWNoUGFkLg0KMi4g
SW4gb3JkZXIgdG8gYmVuZWZpdCBVRUZJIGltcGxlbWVudGF0aW9uLCB0aGlzIHRvdWNocGFkIEZX
IHdpbGwgd29yayBhcyBNb3VzZSBtb2RlIGF0IGJlZ2lubmluZywgc28gVUVGSSBjYW4gZWFzeSB1
c2UgaXQuDQozLiBBZnRlciBlbnRlciBpbnRvIFdpbmRvd3MsIFdpbmRvd3MgSElEIENsYXNzIGRy
aXZlciB3aWxsIHNldCBzb21lIHNwZWNpYWwgY29tbWFuZHMgd2hpY2ggY2F1c2UgdG91Y2hwYWQg
Rlcgc3dpdGNoaW5nIHRvIFRvdWNoUGFkIG1vZGUuDQo0LiBCdXQgb24gTGludXgsIExpbnV4IEhJ
RCBjb3JlIGRvZXNuJ3QgaGF2ZSB0aG9zZSBzcGVjaWFsIGNvbW1hbmQsIHNvIHRoaXMgdG91Y2hw
YWQgbGl2ZXMgaW4gTW91c2UgbW9kZSBvbiBMaW51eCBPUywgYW5kIG9ubHkgaGFzIHNpbmdsZSB0
b3VjaCBmdW5jdGlvbi4NCg0KQ2FuIHlvdSBzaGFyZSBtZSBhbGwgdGhlIGtlcm5lbCBsb2csIHRo
ZW4gSSBjYW4gZG91YmxlIGNoZWNrPw0KVGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMsDQpFdmVuIFh1
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWFyb24gTWEgPGFhcm9u
Lm1hQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDI0IDM6
MTYgUE0NCj4gVG86IFh1LCBFdmVuIDxldmVuLnh1QGludGVsLmNvbT4NCj4gQ2M6IGJlbnRpc3NA
a2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGppa29zQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBk
b2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBaaGFuZywg
UnVpMQ0KPiA8cnVpMS56aGFuZ0BpbnRlbC5jb20+OyBzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4
LmludGVsLmNvbTsgU3VuLCBYaW5wZW5nDQo+IDx4aW5wZW5nLnN1bkBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMjJdIEhJRDogaW50ZWwtdGhjLWhpZDogaW50ZWwtdGhj
OiBBZGQgVEhDIFBJTyBvcGVyYXRpb24NCj4gQVBJcw0KPiANCj4gSGkgRXZlbiwNCj4gDQo+IEFm
dGVyIHRlc3RlZCBvbiA4MDg2OmE4NDgsIHRoZSBtdWx0aXRvdWNoIGRvZXNuJ3Qgd29yayBsaWtl
IDQgZmluZ2VyIHRvdWNoLA0KPiByb3RhdGlvbiBhbmQgem9vbS4NCj4gDQo+IENvdWxkIGhlbHAg
Y2hlY2sgaWYgdGhvc2UgZmVhdHVyZXMgY2FuIGJlIHN1cHBvcnRlZD8NCj4gDQo+IFJlZ2FyZHMs
DQo+IEFhcm9uDQo+IA0KPiANCj4gT24gMTEvMTEvMjQgMzoxMCBQTSwgWHUsIEV2ZW4gd3JvdGU6
DQo+ID4gSGksIEFhcm9uLA0KPiA+DQo+ID4gVGhhdCdzIE9LLiBHbGFkIHRvIGtub3cgaXQgd29y
a3MuDQo+ID4gVGhhbmtzIGZvciB0ZXN0aW5nIQ0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+
IEV2ZW4gWHUNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBBYXJvbiBNYSA8YWFyb24ubWFAY2Fub25pY2FsLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBO
b3ZlbWJlciAxMSwgMjAyNCAzOjA4IFBNDQo+ID4+IFRvOiBYdSwgRXZlbiA8ZXZlbi54dUBpbnRl
bC5jb20+DQo+ID4+IENjOiBiZW50aXNzQGtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBqaWtv
c0BrZXJuZWwub3JnOyBsaW51eC0NCj4gPj4gZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgWmhhbmcsIFJ1aTENCj4gPj4gPHJ1aTEuemhhbmdAaW50ZWwu
Y29tPjsgc3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb207IFN1biwNCj4gPj4gWGlu
cGVuZyA8eGlucGVuZy5zdW5AaW50ZWwuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYx
IDA0LzIyXSBISUQ6IGludGVsLXRoYy1oaWQ6IGludGVsLXRoYzogQWRkIFRIQw0KPiA+PiBQSU8g
b3BlcmF0aW9uIEFQSXMNCj4gPj4NCj4gPj4gSGkgRXZlbiwNCj4gPj4NCj4gPj4gU29ycnksIG15
IGZhdWx0Lg0KPiA+Pg0KPiA+PiBUaGUgcGF0Y2hzZXQgaXMgYXBwbGllZCBvbiA2LjEyLXJjNy4N
Cj4gPj4gQnVpbGRpbmcsIHdpbGwgbGV0IHlvdSBrbm93IHRoZSB0ZXN0IHJlc3VsdC4NCj4gPj4N
Cj4gPj4gVGhhbmtzLg0KPiA+PiBBYXJvbg0KPiA+Pg0KPiA+PiBPbiAxMS8xMS8yNCAyOjMxIFBN
LCBYdSwgRXZlbiB3cm90ZToNCj4gPj4+IEhpLCBBYXJvbiwNCj4gPj4+DQo+ID4+PiBUaGFua3Mg
Zm9yIHRoZSBpbmZvcm1hdGlvbi4NCj4gPj4+IFRoZSBmaWxlICJpbnRlbC10aGMtaHcuaCIgc2hv
dWxkIGJlIHRoZXJlLCBpdCB3YXMgYWRkZWQgYnkgIltQQVRDSA0KPiA+Pj4gdjEgMDMvMjJdDQo+
ID4+IEhJRDogaW50ZWwtdGhjLWhpZDogaW50ZWwtdGhjOiBBZGQgVEhDIHJlZ2lzdGVycyBkZWZp
bml0aW9uIi4NCj4gPj4+IEkgdGVzdGVkIGl0IG9uIHY2LjExLg0KPiA+Pj4gQW55d2F5LCBsZXQg
bWUgZG91YmxlIGNoZWNrIHdoYXQncyB3cm9uZyBhbmQgY29tZSBiYWNrIHRvIHlvdS4NCj4gPj4+
IFRoYW5rcyENCj4gPj4+DQo+ID4+PiBCZXN0IFJlZ2FyZHMsDQo+ID4+PiBFdmVuIFh1DQo+ID4+
Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQWFyb24g
TWEgPGFhcm9uLm1hQGNhbm9uaWNhbC5jb20+DQo+ID4+Pj4gU2VudDogTW9uZGF5LCBOb3ZlbWJl
ciAxMSwgMjAyNCAyOjE5IFBNDQo+ID4+Pj4gVG86IFh1LCBFdmVuIDxldmVuLnh1QGludGVsLmNv
bT4NCj4gPj4+PiBDYzogYmVudGlzc0BrZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgamlrb3NA
a2VybmVsLm9yZzsgbGludXgtDQo+ID4+Pj4gZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgtaW5w
dXRAdmdlci5rZXJuZWwub3I7DQo+ID4+Pj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
WmhhbmcsIFJ1aTEgPHJ1aTEuemhhbmdAaW50ZWwuY29tPjsNCj4gPj4+PiBzcmluaXZhcy5wYW5k
cnV2YWRhQGxpbnV4LmludGVsLmNvbTsgU3VuLCBYaW5wZW5nDQo+ID4+Pj4gPHhpbnBlbmcuc3Vu
QGludGVsLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA0LzIyXSBISUQ6IGlu
dGVsLXRoYy1oaWQ6IGludGVsLXRoYzogQWRkDQo+ID4+Pj4gVEhDIFBJTyBvcGVyYXRpb24gQVBJ
cw0KPiA+Pj4+DQo+ID4+Pj4gSGkgRXZlbiwNCj4gPj4+Pg0KPiA+Pj4+IEl0IGZhaWxzIHRvIGJl
IGFwcGxpZWQgb24gdjYuMTItcmM3Lg0KPiA+Pj4+DQo+ID4+Pj4gVGhlcmUgaXMgbm8gZmlsZSBp
bnRlbC10aGMtaHcuaC4NCj4gPj4+Pg0KPiA+Pj4+IFJlZ2FyZHMsDQo+ID4+Pj4gQWFyb24NCg0K

