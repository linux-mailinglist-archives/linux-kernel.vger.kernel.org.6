Return-Path: <linux-kernel+bounces-428146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 517209E0AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123DE1605D4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF71DDA37;
	Mon,  2 Dec 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvMpThlK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175D1DB54C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163022; cv=fail; b=oB4uzcI4Es9qa6sJH3KzduAy2u0uR02hA8as+EhLqQ6+msmua9nSdqzzExjYwg8bj4lq4jSLPSNfsd76SW+fyQsFU61K24IgIMLeruU0WoXhkw1hwKXVJe0tcqRu4hdSf9SyzVLlElRuWvpObLF61IITVnZzMMcCLkGiwAW/C6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163022; c=relaxed/simple;
	bh=hIU3j0TLsMCGArpx28X+eLCmCYGImFSV5n2MCbLEVfA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ifK096N5uoKp1vgZ+Xboibt6s0v04sH+N7wrxptVSqyZcV0Lwc4SJQap2eD20wDc2kr6Odw5BL1Wx+DGdrQ6Y5Y1EDgosYqSgnxjLZE4asq+yzVWrLMg2yGhAT5Rip7lmkTYB+YWhh59T4//WlA/WCrrUp4j/mEi3AJVKoOZjRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvMpThlK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733163021; x=1764699021;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=hIU3j0TLsMCGArpx28X+eLCmCYGImFSV5n2MCbLEVfA=;
  b=cvMpThlKOkebW7VlIEEA4sb50fF8J9hfZA6NnPa/+hBTWAbuzPkAJTPk
   o2NUfIAghYFHA+iyLD+5/fDBpHOuuDxXLYw025vgIc2jUP3RRBKwL6cix
   KjnrP/+U7xYja0Av7exf2c8D5L7VcqRr5wWe5E2xwnilB2IsxUtRcf6SR
   VqPQnY7x4bWnAzrnI95iUCPgoCFKmK0+1kyDcLp0JUM5W3VbXNqixeEo0
   q0qwh1Nv/gmP2xCyOV8/dQQ/R7VneaKLE6hJfiYTNxuPc6LmraCmykD8V
   FgkseNywz5BeJCyylVV80/0Bgtq+JS+rKsRn9grHjySRJjphtj3/5bNd0
   Q==;
X-CSE-ConnectionGUID: +kZZU8zFQwSShX5hvqob3g==
X-CSE-MsgGUID: BCZYkK5DTeiZqHHYX+FLjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44016867"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44016867"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 10:10:19 -0800
X-CSE-ConnectionGUID: UPq51AOlSPerxiGagj7BjA==
X-CSE-MsgGUID: 0h3xbLYzQaifr8Fr8kVHVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93505758"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 10:10:19 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 10:10:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 10:10:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 10:10:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGwRxT8qETSDfj2I92hsjMj/ISK2o9ToV6oVMvyVTAAYPcJAM++WKsZ6JwoyUXmWCe46nbQEPS5aLwRaPfB+jVOi3OFKtXicjnUaEYKopGAWubq1KKAXEpe5ViYCaNUN/PlCp83q6trbBtTFBs1Renn3qzsNSPGplP9ypbaUmMtUtYJsb2G7n/DwH8gLbqItequtj/ZJdHVydfmXvWttoPSm6TVMO4lqWL7Z5M8TtEDWDt61zPeD30ptZmPm/Yz/FkJwKtH/4jql4i/Fyj9L01o+6AfkKKITe2H7A/LLJDIX1L+8i6NHevZzhQTxQSJVPoc9NcM/i6Bm3S5+y3Y8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIU3j0TLsMCGArpx28X+eLCmCYGImFSV5n2MCbLEVfA=;
 b=AgX88Ee9tXrzP+ZvsPTkDrP04W10JO11qfHRCeixGJBD52bOUvYYNZ4S3eqHyXD6tKEkfVs5yqL9mwX3F13OgEv6hJfprhkshu+m6Swq7fR+c03F8J/14q1DwdzphobCGejtCXBSlbNiPUHsUX9t6UzKT/dcS1L0MjYO3uwi+idsr2ojqdqLJTuajVhkNHCJC+YjpeOG7yIERhNf3+3slKAeVG/akBb729xy27RQVNg/ChqEDL9kSZJ4kDJSOzng+91lkAuchQM29Yh3zX6wy2jv9IfUK50vwCnwT3u8/X1S8CY2DKBvQFdvhhp5AmAMijmol971Gn/kfdSaHy6jMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6877.namprd11.prod.outlook.com (2603:10b6:510:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 18:10:14 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%3]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 18:10:14 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Li, Rongqing" <lirongqing@baidu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH][v4] virt: tdx-guest: Don't free decrypted memory
Thread-Topic: [PATCH][v4] virt: tdx-guest: Don't free decrypted memory
Thread-Index: AQHawjpiYTlNCyETo0aBg6z1bqykdLLMU8+AgAfxUQCAAAFIgA==
Date: Mon, 2 Dec 2024 18:10:13 +0000
Message-ID: <bd072a45a755eb2be1fe4c1c95c27f7cd0635a27.camel@intel.com>
References: <20240619111801.25630-1-lirongqing@baidu.com>
	 <63a3e464f368b6103c637af384eb0b069eac3158.camel@intel.com>
	 <c248f101-4c57-455f-9f70-53b3bd9602f0@intel.com>
In-Reply-To: <c248f101-4c57-455f-9f70-53b3bd9602f0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6877:EE_
x-ms-office365-filtering-correlation-id: 4bcced83-3be5-4d31-aa3f-08dd12fc9196
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aUVEK1UxRjJPd1lDdWZXV2JBVm5EL05GUU96ZFJUSTUrb010aCt2ZnBacTNL?=
 =?utf-8?B?OUJEcWZ6M1ZkTUlSaGFBZmRLSjRWcXJjdGZJam8xWDBKVGhpdVB6KzBOVzBO?=
 =?utf-8?B?ZHZMRWpNV0NvdzI5Y2JtY1BvNURNOUcwbjFNdXpGWnY1WFRDeGJXL3BuNmsx?=
 =?utf-8?B?K0tEaHY3TUZmT21EMVhSZTZXY0lDUTVnTVY1U1JORExZMURzazZDOUYvUFhT?=
 =?utf-8?B?TU1RK2F1N213clRNdjd1ZnM0QVdubXdmcDdRVFQ1YmVvUENLdEtwR2I2alBi?=
 =?utf-8?B?TXZSeC9IenY5V2FybU11cTJRRlFmdGduRXptSEZnY2FHMTg5L0NxcEYxREpL?=
 =?utf-8?B?SUVnM2tFY252L3NsaFNpdFR5elFUcXBpZ3lPemVueHpkVkxoMjZoM1B0ak5q?=
 =?utf-8?B?dUFWMEVZbEsvU0tDYkV1ak9jRnJJWlI4TXkzNlVxUTJ1WTBqOUlLRm1oaThS?=
 =?utf-8?B?dG4wREJMQXZhSVZBQ0dqanZpMDdqOGxSVzVneW96U0UwOGdqcVBFcmhITUNM?=
 =?utf-8?B?YmZreWNwWTFUR0xWZlp1MVVIRVk2eUF3S3lEd1VKWlltVnBhQ0R2aTVhQlhi?=
 =?utf-8?B?WXFrZStTb1lNaE5YSVN5UUhkS2JvNkJBVkFZakowTS9Ld053blR3R1RWdnph?=
 =?utf-8?B?dkg2eGFuRGphN1MycDl5OGZuUVhrRTdvNklhQVFSOFlDNU1tc1FyUGhWeGdx?=
 =?utf-8?B?M0Y3NWpmNk9YZ0VSdlNISEJycVltbFpJMmNKdHVjYy9Gc1lUeWtXejV2UVdI?=
 =?utf-8?B?M09hY0wraVEwak85QXptM2ZPVVlVM1o1SnJQRFZvelU5alRsSlc4UkNpZUNE?=
 =?utf-8?B?emJoNU9RNjFIN3JtSkFKenVpQy93WW9TYmZ0NzVtY2dTQlBaK3JDTkh4YVEr?=
 =?utf-8?B?NUo4bUl0NHJ5Ym1WeHU5YmpLcU1POC80eTdMeldNV1E4VzNGNEJkT0I4NUk2?=
 =?utf-8?B?b0c0WGtUNDVESEMvU1RMYVg4S3dnT05PaDllUnNJYjFlYWI2V09mZGV3dTFj?=
 =?utf-8?B?RnNjT3IybTJQQmpwdEtEbGxIbWZncHhabFRGVXhEdFVYclVCWmNKU2l0YU1i?=
 =?utf-8?B?ODdYQnZLMmFpUERFemV0ZGViem0zUWFDb1Ayd3V6dTlhM0w2QnN1ck1HN1FQ?=
 =?utf-8?B?WVV1YW9iMUdWdEpvOHZHWUNMQUtuNnlCT3ZObXJNdE9OdHN5TmhUNWtuRkxR?=
 =?utf-8?B?cnp4TGxrM2F5dG5CeC80RkhYZVMvVXBxSGcrZVNqNUlQeG1WM3orMHQzdktu?=
 =?utf-8?B?YTRMZDZhL3FGYmF2RWoxWGZYNGJLeTdjQnJsLzUvUzYvbnF3Sm12WHh1ZDRO?=
 =?utf-8?B?SW9QaFZjNXlNOVlRS29jWHg4bm5CcHp6NTVKWjcxWXd1MXhSazlURmlwZVoz?=
 =?utf-8?B?aC9kQWxsbnF4ZnV4T0QzbEdPVVF1ZCtzKzkyaXZMK25hRDhsMVk3NXAwazg1?=
 =?utf-8?B?MXdicFdya0k2RUlFZ2JVMnpiQ2RIWXB4d0ZQYmtrbEQzbWlUdFdxU0hBckRS?=
 =?utf-8?B?alYrc1hsbTBvckpieURVUDRiakJBMGZyMHQ4VzJOMkJwZ081b3JZcEc3UHBQ?=
 =?utf-8?B?VkdTV3hVT0doK1M3ZHpiT3VRL2RoSSs4a1hTZUk2dGx4dVljT2U3NXA5dmhn?=
 =?utf-8?B?d3czZWg1TERLT0xMV0hKaTlRM1pnSjhMZ1VtbndVUGNRK2xiYnRUS2dPZ3RH?=
 =?utf-8?B?Zmppa3FNZHFvSXhaNms5Y0pMSi9GdGJXU245S21kYXdEMG1WbWNlNGZNRnJM?=
 =?utf-8?B?by8xQ0Zwbm83U1FjRllYQkoxcGNJVkdOSzljUUlEc3V2cXlDMHFRY1dFTnZl?=
 =?utf-8?B?TXdSUmFBdFdZd1FDRGZBTFRXM01VQllTK1dtbXB5RGF0YVFTVEdHeW1VaTRU?=
 =?utf-8?B?T2ZWSUhwaE42U1Avd3FNM3ltUHhiMEZ3cGt4Qm9rMnJzOXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1dROE0xakh3NFhxS3hKWmdRSndYME5OaVYzZFRNVHYwejJXT0ZzT1JKMEJI?=
 =?utf-8?B?VWovenc5MUNpZjlYT1YzNlJ3bDU3TG1sZDFTSExaV1FwSFpqM1lkQm1nOGJG?=
 =?utf-8?B?Z2pJK2ZtME5IdjNEWU1kcVY3all5WS9GbEllZjFRQ3o2eVY2SFhCMldxbnVr?=
 =?utf-8?B?aENsTlZNK1FaTnhKdFNKR0dEeHJzdmpHTzJGb3l1a2FJSi9POWVRZ25mdzAz?=
 =?utf-8?B?eFdoQ2xreHFkY1k2MU8xajdXS3BiRC94Ri9XVUkzWlp3a2NZQ1lUeTU4WFVp?=
 =?utf-8?B?QU4vaWxIVHErbjEzckYzSjJ0S3ZtM2lmeGRDcDA3K0gxU2lEYTZpSTFCbmov?=
 =?utf-8?B?UEZRQ0M0dzJ2aUYzVEZBWUtDeHNqS0RrMitzOTJOZHZ6cVdJbnFDQnZiTEl3?=
 =?utf-8?B?Wm9lTllLTStuYk5RSUdKZHNSLzNwM0VUZGdsVUFkdkRiOGVEbGNjaVRvNG8x?=
 =?utf-8?B?WTFjWktKRGFFbDhGOFF3OU9zQ0dNM0JsWTVoMkIwcXlydVBJWGxYc1o0UHFG?=
 =?utf-8?B?VG5TYUgzTVdoempKQ0hqMFhIaFl0c0VoM3pWUkhwK2FuYm5FMEFlQk52TVNn?=
 =?utf-8?B?TG1wQVV2Sm1yeVNhYmRDc1pvK09lSXpaMytVMTJlWnJ5NVprOUdQMWpKTU85?=
 =?utf-8?B?dFpCaVVlN3gxVVJqQklmZkhiS01oMWxkV0JuR3RWcWRIZmp5Wi9CMEJMaWl5?=
 =?utf-8?B?YVhqdzNzT2prZEliV3B2Mnh3WWFvUEZwY3JpVWNEcTFNV0trbFhOOXJ4Z1dY?=
 =?utf-8?B?M1JjUldqT3ZzL0xZU0tRWmdRRHgxbDAwTWZIcjcvbnIyUnB2SFdBN09HWElN?=
 =?utf-8?B?MktSanFVYm1Rd1dFVi9kYnFiUnBWLzJvYzZTTVAxTTJzZElUVDdwWkZoaTlV?=
 =?utf-8?B?Zk5qZktBZDBxaWJTM0lJOGg2Y1NVNkRhemN1dTl0VWxHTXFlY01lU3dSc2pF?=
 =?utf-8?B?NU9UdmU3VzFiU0hmRkYvVW5nRVpMQzBwQ0ZyY0R1MXI0UXlFNlgrWlZZN0ZP?=
 =?utf-8?B?VWFBTWx4WWdUUFNzVm5JOVBGdXlMUjkvZFltelVFK29vRkh4NDhCak1qdVZX?=
 =?utf-8?B?RDNpaUVMTTJYaVMxWSt2eElMdGFsOHF0eklXUVhZU1BucnA4bERpaGpickY5?=
 =?utf-8?B?N1JBRDVtL3UvdDhpL3p1eEVvNkhRMFRZb1VTdG85bUNWTlBkOUVGVkREMEFr?=
 =?utf-8?B?aHVVVVpXbFJNeEhzZm5mN2VEYjliUG5haUo4ZW9LdndMbXVueVRHNlZaOTVV?=
 =?utf-8?B?V3ZuUHhHWU8xN2ZkbEwwMWRWOVNzSk8zeCtrMlExeHo4NUg1WTZ5a0VsMXFo?=
 =?utf-8?B?NVphaEhRdGdOUFNqcGtwbWdPajcxOXIwdDdueFF5ajZkNTVEMTNGaDVTU3R0?=
 =?utf-8?B?RWtOTGdEeXh2UC9xajAvbXdNT2ZFZDZ6bWhyWGpZUER1SmNWakdRSzZHMFpZ?=
 =?utf-8?B?UENyWVBDOG93ck5rRVRYb1NKcklQU0k3dlJSK3ljUXppZStFOGpxa0U1c2ZE?=
 =?utf-8?B?SlRUYnlUdmdlU2laNXVFb3dNUjY3dm5RTjYxMTh3ZWV3TFJmTGl4MklxOG1a?=
 =?utf-8?B?bWxld1NycGRZdlhSTjIxTUtNRzVsRloyR1UzdWcwL0p0ZHlSZW9pcWRUdTBW?=
 =?utf-8?B?alVYbUVBSTh6QzhnYTVxNHFNd04wQkgza3Vxc244TFFCbU82SHFrSmRHTzhX?=
 =?utf-8?B?dmxtYlRJU0MvbnNTOFRzNjBuZXluTUMvRHl0enl4UVU0eFFFOGVGdGZWNHUv?=
 =?utf-8?B?RDk2Wi9EbzhvbjY1NlorKzlqdllvUk1icHM2SG5xVTVYdi9kanphQnA0Q1JJ?=
 =?utf-8?B?T0RxT0dtaTZIRGdqb00vcDZnSEVWekcvMHljUTR6c2U2Snh4clZWd0Jkejgr?=
 =?utf-8?B?YUFuaFJtVnVCSVR2aGFpNDhwN1BjanZhQWt5WllQbjd0aVc3SHRIbW5JaG50?=
 =?utf-8?B?M0dDRzQ4VW1xNTZBWEpPMkpKZmdjbTl1dE1JVnVWZXFlTzQ1Z09EYThublY4?=
 =?utf-8?B?YS9yd1VlUUtLMFBuUXBGVUFCbEpCRm9mVWRoc0dvUjZzNGVEdGNRSDBjQWJa?=
 =?utf-8?B?RUJoN1FVV3F3WkoxUWJNWnFNV0FYUENXd0FBdjlCaGFrNnNENGdTcWFKdVUw?=
 =?utf-8?B?R0RBdXJEWlV3UlhMMTB3Sm9RdVNLdU9rT2lOTlZCZVRQd2RWK1FKMERNNkw2?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFCF915C8F28AA4D8CEFF6D378D94D27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcced83-3be5-4d31-aa3f-08dd12fc9196
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 18:10:13.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDr8yy9rDqvbHTEcIxP0mDyTspuxWf+AngbK/TdqJtKrA3+OjARaK6wRUCBSuq/cqr/AR0Rj6F81rzbMehaXyeY/w5vCjvWPeEL+dGLTUy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6877
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTEyLTAyIGF0IDEwOjA1IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTEvMjcvMjQgMDg6NDgsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIFdlZCwg
MjAyNC0wNi0xOSBhdCAxOToxOCArMDgwMCwgTGkgUm9uZ1Fpbmcgd3JvdGU6DQo+ID4gPiBJbiBD
b0NvIFZNcyBpdCBpcyBwb3NzaWJsZSBmb3IgdGhlIHVudHJ1c3RlZCBob3N0IHRvIGNhdXNlDQo+
ID4gPiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIHRvIGZhaWwgc3VjaCB0aGF0IGFuIGVycm9yIGlz
IHJldHVybmVkDQo+ID4gPiBhbmQgdGhlIHJlc3VsdGluZyBtZW1vcnkgaXMgc2hhcmVkLiBDYWxs
ZXJzIG5lZWQgdG8gdGFrZSBjYXJlDQo+ID4gPiB0byBoYW5kbGUgdGhlc2UgZXJyb3JzIHRvIGF2
b2lkIHJldHVybmluZyBkZWNyeXB0ZWQgKHNoYXJlZCkNCj4gPiA+IG1lbW9yeSB0byB0aGUgcGFn
ZSBhbGxvY2F0b3IsIHdoaWNoIGNvdWxkIGxlYWQgdG8gZnVuY3Rpb25hbA0KPiA+ID4gb3Igc2Vj
dXJpdHkgaXNzdWVzLg0KPiA+ID4gDQo+ID4gPiBMZWFrIHRoZSBkZWNyeXB0ZWQgbWVtb3J5IHdo
ZW4gc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSBmYWlscywNCj4gPiA+IGFuZCBkb24ndCBuZWVkIHRv
IHByaW50IGFuIGVycm9yIHNpbmNlIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkNCj4gPiA+IHdpbGwg
Y2FsbCBXQVJOX09OQ0UoKS4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNv
bWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBLaXJp
bGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gSXQg
bmVlZHMgYSBGaXhlcyB0YWcuDQo+ID4gRml4ZXM6IGY0NzM4ZjU2ZDFkYyAoInZpcnQ6IHRkeC1n
dWVzdDogQWRkIFF1b3RlIGdlbmVyYXRpb24gc3VwcG9ydCB1c2luZw0KPiA+IFRTTV9SRVBPUlRT
IikNCj4gPiANCj4gPiBJIHRoaW5rIGl0IGlzIGEgd29ydGh3aGlsZSBmaXguIFdpdGhvdXQgaXQg
dGhlIGd1ZXN0IGNhbiBiZSB0cmlja2VkIGludG8gZnJlZWluZw0KPiA+IHNoYXJlZCBwYWdlcywg
b3IgdHJ5aW5nIHRvIGV4ZWN1dGUgZnJvbSB0aGVtIGFuZCBjcmFzaGluZy4NCj4gDQo+IERvZXMg
dGhpcyBuZWVkIGEgIkZpeGVzIiBhbmQgY2M6c3RhYmxlQD8NCg0KT2ggeWVhLCBwcm9iYWJseSB3
b3J0aCBhIGNjOnN0YWJsZSB0b28uDQo=

