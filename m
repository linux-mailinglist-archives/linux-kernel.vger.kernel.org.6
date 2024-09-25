Return-Path: <linux-kernel+bounces-339693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EEF98692C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603971C23AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38969156F23;
	Wed, 25 Sep 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIcmbaaK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD3148838
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303352; cv=fail; b=BBqqWMhsgfFO7L27sbkq+DovY9s64Hf6RrDbDqJNT/ZyNH7roQeooNquhp4Rdd98vhjkNYp4Ch9kAHmEzKq3wcwrktHyZXvha3Mshx3fjcFzVVi/q8r9p8+1OpdHuQQXBD3DEr/KkCDpTComi/rzPRc6KTm3KmnlE1Y8iZCz0+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303352; c=relaxed/simple;
	bh=u/jY07jj7B/siLunNHmlNPX+eskOqzBVRfrBWHvSo8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6NMD/WZ+gtsr+ggC+ER4p8khFxI3CDAORgBSKHfVaQ/vi4aenIYNSG+vQTBpghGiDc87sAJbZZfsgijZsgavXS8pCD3BOZ6ASSePKKqu3RAFjtWkUeQhN/vQ9u2x8K4hR7Ne58nnoMhOT6OJg13sSlZo9b9sW/p2ooFdmiQz+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIcmbaaK; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727303350; x=1758839350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u/jY07jj7B/siLunNHmlNPX+eskOqzBVRfrBWHvSo8M=;
  b=SIcmbaaKp2o6lgepED1mgVN6zuAezB+K4SMu9GGnwKjcAD+TBfybuaN0
   Ph4PZ2PTgxzSd/yrdNR+5s11XWIEt9fht7wUBVn4DgKQam0j8yjKFG83k
   Z/W/6Z7PX5wXq1q8EewcaWVHFPPhFZN3V8Kg8Plq54DNS6RCEJ6a0ZTkc
   YzNgOrfG9gznxQIk8YqhZtlD8Uc6WLDRqs+YZNTYHIJEt8yOa2I3Z5miP
   fe5OPWdEzHi2G/iGRIJkT1Ey7t/9iKr3Sn3E1HcGMqfLzk2nKeBFUPMs8
   +V2F2+BUhY/dE0+f7fWKlBJGXlcyItuP6NH0VPeAl4SmnPPv3EAm76EV/
   g==;
X-CSE-ConnectionGUID: gQzTWb5pTg2ChkOUUNHGOA==
X-CSE-MsgGUID: vJRtGX0nSfC1y/HM+L8UMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="43895610"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="43895610"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:29:10 -0700
X-CSE-ConnectionGUID: srnXdbopRBeEARTvzD8k7w==
X-CSE-MsgGUID: PWrrpBchTf+ZtI7wus8miA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71929842"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 15:29:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:29:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 15:29:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 15:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q91tWsctSPt+VKt/gsW8Wru9Ii3cst1vBrx0RVE1Cbr7kCvvu7+mKCoWJDrk9D4MuGwIGSL3O5L7zMQRrsvUKU2NHoakYua2/00LeNkbJn77j4Oz2ZCivAa265KeSjjtqwLqV6kR8aakMjeqwnBokeTb7cLfr5Pn3HSj+NBb6bdQjTJ5JC0h5t8e2kvhTlAwa3ya4q3zaXOv4dqXNbipsOMTECWNcmXR3iZKM5AT7TxMctOHWuttLItaq5mBn34+Qu5UYnwltrVjT0fFvWNgTlqclDDC6TmGWd940TTyhcKVPBxG67Bjwwq2cNlwF8T9SGM0UO59SHDB9PFxg6UToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/jY07jj7B/siLunNHmlNPX+eskOqzBVRfrBWHvSo8M=;
 b=tSlrbK53CvfRNo1Fhrhjq7OxP7DJGLJY9NWN1CHir9h8FfvM9jTV/Zuovut0Jtej/7RvziPZtoDoSMsDaWYbUY333jabeCONNlS2pDr585rBSEEjmlZw3+diO67lbv0wSMAFtqAAghlrpBfDtfL4cUEdS16IYqJ0iB2hjiZvEmynVtsKI5S6fk1uuiwMH+ICynhUqyPBuK7BZM1cGJKJluFqZX8QuzL5ywlq0hhnVWuFeUhY6d0tjj0D3bvl9YWXyreWIdBowMBHN6ip7u8uK2SEB44mowWzj6x3crGpS1qtN/tE50wY5njGUZEZLxHhOrLB9iMKB9priMZnq62pXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 22:29:06 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 22:29:06 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAADdcAgAAFSgCAAAmZgIAADtIAgAAWxLA=
Date: Wed, 25 Sep 2024 22:29:06 +0000
Message-ID: <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
 <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
In-Reply-To: <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: 14f0416f-0832-43a1-9e0c-08dcddb1776f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?czVzamR1TUo0aStHd0F3SjlVK2t0aXEyTUpSRmswTGdNcyswZFNzbGRWMjdQ?=
 =?utf-8?B?dUdYS0lhUmFQWHdXL1R3OXkvTm5nOWNoN0J4Y0N4ZVRTNVEyUUFsekh6WFBr?=
 =?utf-8?B?WFhLQlJxYmZ1Z3AwSjhydmtBL1NQdDBjbWNiWmt6Qi9CTUVTVUI1Nit3SnNo?=
 =?utf-8?B?YkgwUXd2NkRiMThmeHdZd2d1c0ozTWIvRHB0Vm9HWmEwdFBMN0g0Y0RaMnVI?=
 =?utf-8?B?OFFMTGZnVzVBdGphckp1OWJPTUM2TldJRlFVWm5GUTJTRkZyWldtRHg3THZ4?=
 =?utf-8?B?YjB1TEJieFM5bGpscFgxSkJCS29PTWVsVTBLQVhsQlNMSTZHUmFpVDJOQ3ll?=
 =?utf-8?B?QUZqdEljNGR4MzBVcVNsaG5qeGRoeDZBZUZuVnFtUWtnNUxvTVJOOXArekQ5?=
 =?utf-8?B?cDBpdVpyeGpRK1Uzcm9HT2xEQWl0Q2xzMVVJYW9xanFJUWRwN1VmT3FVZW83?=
 =?utf-8?B?TWJlUm0rTE9UVGhQYzJESXh6bC9mUGsrZXl4OTU4bkRtQTZjNzY5VEh1elMy?=
 =?utf-8?B?Y3k5MVhEa2pJVUplZUY1YmsyYW1mMFZQVHNUQ1V4Nkx0c21DWVAvVGEyMUlQ?=
 =?utf-8?B?aDNvQ2tMWW5mL0lWMnpFd0hYWjhaVnBoRWlNRy84U25vdmoySWREcFdTRS9o?=
 =?utf-8?B?WDUwWnRvVHE4eG1aaWJxNmRYUG43dFNMTHI1amR2RVJQbXVwZDlTbVBSNXZt?=
 =?utf-8?B?Z1NYSGFGRGJGNmIyZndXb2o3UzJOMmVQU2hkQ0hwZWpNcGVSNVYxS05OU0Jn?=
 =?utf-8?B?VFFkRFJnZWY0eEVSclZTT3lWMm5WZ1BWTlhpMnZtUGI2b1hjdFZRWDNYMWxQ?=
 =?utf-8?B?U0N5VFR6dE5FSjh6d0RUNDdocGRHem9wZXJoTzdpcWRXUUhUWVc3N292dEgv?=
 =?utf-8?B?em5pbC9nZ25Lb1pHZTcvWk1HbitMT1Q2Ynd2MEJVakg3aEg3eDliZXRRbDUy?=
 =?utf-8?B?R1JGVGJrUjVodWtXbHV4MXpkNHBjVFBBTkdheHdIUnhlT3p4YnFrMWJUb0RQ?=
 =?utf-8?B?RUhOblozMTlWK1ZnVUd4VnIzVXlnN1F3WEpEb05ZMzFPUHhXNXlVSlVSUUo2?=
 =?utf-8?B?R2tPYk1pcnhma29KWE8yMDJSQTlsNjBFV3U5aWlLQ1hTSXlOOW5rZkRFWWt6?=
 =?utf-8?B?VHpKRXlQWnRkSzZibktvQWtmbVdsZXhYVVVvOTZVNHpYZnI0aHlhQ3Zxem9i?=
 =?utf-8?B?MGVINHpZWHl1TTE2ckJkVG52ZVZzaUxWVFRsZDNocXpvM2hXQjNsT2VyZ3Y1?=
 =?utf-8?B?Y0YvQ1hIb3NWNVlNTDlXYncrTE4rWU5ySGtpWDcxM0hsVU1qeXJzNEg2S29z?=
 =?utf-8?B?RjBVU05ncXdtQ1JLUkR2TE9uZFMyMzcwVnRQMHgyaC9TMWduSXM5OW1XNjc2?=
 =?utf-8?B?elhOOTJBYzZTd2w1OVlldHNEanRGaHUrUUhsMWxsZVpHVjlZcktNM3UxYmFC?=
 =?utf-8?B?SzRYbFJxdjRGMythKzhsMWg3U3I4N3krRHdIT0xseTZmK2xDUW13RnI4TUhH?=
 =?utf-8?B?TWh0UFlXdlp1cEZYc1N0bGRYS010RzBrWWpRTnpQYVdzY3RtQTJGRlQ1Y2pF?=
 =?utf-8?B?bmo3Umg2Z0RobEtLa3dYRzQ2NERGOFhSTkhEKzNuTC84R1BHQkNibFlEWDdH?=
 =?utf-8?B?enBSZ3JkRkVEcE9ORUs1c09mTVZZKytTREloYThWSDRuWGt3UndIK0hPcFUw?=
 =?utf-8?B?U09oYTVEUDZheDRsV0dSUmdTTnpJZjl4WVgvbzBFOUNuVlFPdXkyQWc0Q1g3?=
 =?utf-8?B?RU1zSE9yOWxvaU1GTlZKTVJISmxoTURTSUtsaHRXcTFBRWhUWERWTXA2STA5?=
 =?utf-8?B?MWhxZU93Nm5tbXRPcmVNUS83Q2Y3VE4vdE1aQVNMQVAyR2FFQjd3ZS9XMmpH?=
 =?utf-8?B?VU85OXBPcHBpaDYrRFlQQkpiM25GZFJuYzNxVUtDZVhEaGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGdDU0F6bk9GeUh4ZFVobXFod3RwbFBWK3R3RDh1blpHN3NxTUdPOUpBTDY1?=
 =?utf-8?B?OGg4NTJBOURBRWg2VnBpRXVHUU9VZWNGbm9IN3pPdGo4Y05BNXphTmIyWjdS?=
 =?utf-8?B?bEJaVEZVeTljazl4YUp6c2sxczZVWTBzVDQ5UStBQlhhMmpPc2JJaFdmWG5Y?=
 =?utf-8?B?ckNoQXNsNkZHbm1TVEdVMDhlazdsb1dGKzdCV2svTmhLQ0VpR2xIRncyYzY2?=
 =?utf-8?B?SExjNUdkVFZoYnpaVDFwVHlMSnFLeUI5Q2VNbjBCeHVuanVvQ1RzUUU5TUNn?=
 =?utf-8?B?SVJXaUJ1b2c4SUxmNTBIR0wzTkZqZzErQU12TDgxOExVdmJHLzRRcExsNTYz?=
 =?utf-8?B?OTYvNWg5WE5TNGc3blMwNWdGLzNwOVA5QnhqcXFLZ2NsRlV2SFpNY1dlbXVj?=
 =?utf-8?B?R0RYUHZ3dTFkZzcxNTEvQWZFZjZIVEJmNlNoVVZwclJkYTU5RGNXZ0hYWnNr?=
 =?utf-8?B?YVRBNDdCd0VpQjBmSkE0Q2xlcmxMdlNkRlVEWHh1VVR5T1NJR0pnZmlLQnd5?=
 =?utf-8?B?UWRUekRRNlh4S1IrWFNwTllDS3BBQzQxa1BkclNCNDJhYmp4L1FZc3JBcWFC?=
 =?utf-8?B?aG9BbHkzSEJnTFRpeTQxNFRxb3VEd3l0bDR6SFhQcTdSVk12NkZzWHpBbHNZ?=
 =?utf-8?B?SGcwZ1RXd2pDdk5KZUVtSzlmSEdlamcvRWNZVTM3aEtFSFAxWVFEQlVrWHVJ?=
 =?utf-8?B?em8wUnNkOGdSS01CemUveVFXMnFTWDZUbVRCbHhsSGJpN2g0OE13U0N2T1VU?=
 =?utf-8?B?SXh3NmFqM0xEOXlvb3FGTjN3eUdKODNRVWpKZU52WlZqSWxtMFFQOXhrVWJH?=
 =?utf-8?B?ME5WYks3RmZ0bHFQSzFYUDhYSDNGd1IrMU9ha2JjdytOV081WEV4bDh1UWtT?=
 =?utf-8?B?ZFFmOG9TQnlrblZZZFRCcU1vREloMklFR1JBdWtCblZHMEtFcW4zOFNyS0lH?=
 =?utf-8?B?azhSSU1sbUlIRUtBK2p2ZWt3VkxuOEx3TUQwNXJMYXFkODlWUU5CR3pCRGZ0?=
 =?utf-8?B?aXlLSzNCczkzVzJCWXByaVM5Tk1tcm5JeUdtbkJjNm5NWnAyTlNJT01TdjI5?=
 =?utf-8?B?SmcxelMwenlCQ3Z4WU5mdzJTTWN5cVlyRzhBWHFTZGQwWldkblh1Ti82Z054?=
 =?utf-8?B?bDREYXEzeGJSNzhrRkdQOC9MNXJ5Ymxzb1VKeHozMDZ2ZU51aC9WMXJreXI2?=
 =?utf-8?B?WVZOeFc0MHM3ak9MbExEWFczVFRINWd2c0pjQkQ5N3dQZTFPMFQrQ2RXaTc1?=
 =?utf-8?B?QklmZzZyQ3ZObE56TlVrY3JVRlQvbEo0TGhIdGYyQzNuRytMZ21waERnVXFk?=
 =?utf-8?B?RWlPcktWVEY1SlFwL09vU2dEZ1pTbS9kR3cxWFMyQTVTOVdPVlQrVjF3SWxx?=
 =?utf-8?B?Z2U3TTUwZVVzTUlyZjlockpyUFFrWnhzSTRoZ1l3WG9FRENyM1VHblVUc21G?=
 =?utf-8?B?d1BHaVMvOXRvanBVOVNPVWVJczR5OE9VTTByNEpZc3VEZ1dHREVGWDRnL0p5?=
 =?utf-8?B?UDVzZXp6aHB2azlCTDljWkEvcHlIWmVnVFhVclMvV1ZCOU1aeVZNNDNLenZD?=
 =?utf-8?B?ZjFxYzFLSWIxZzZmS3JCOTNRQWhOcUVQS1QvQXNTYWFjaHZJU1hYWis3djRa?=
 =?utf-8?B?ZHFVSlpqRXJwTzNKcktac2lxc1o3SDlOOXpGcGNVdkVtQmg4WGoreWliNDUv?=
 =?utf-8?B?eDNvMFJvRDYrWHAyNS8rdEkyS3RGZW5Nb1puTmpZTlprcXA3UUl4VktBenlC?=
 =?utf-8?B?RTlQZXF1MWQzQW5NWlhPWVpRNTM2SHBKbzRzYi9DbE41UDJiaEtuSHJpYzA0?=
 =?utf-8?B?MmQ2ZWNLMVkrcDNtU1pRb2UyOUVGeXVZYXhJaE5mb2l2em9iYzEzN3FaM2Rl?=
 =?utf-8?B?Znk5YVpsa2tyRGFKNm4reHFVQnJUVXZSSkpGWVdRcUlPZ3RLc1R4TVhDcGNW?=
 =?utf-8?B?SDBKUEZSVnA3MGJHL2pFblpVcEo3Y3I5TDk0NU5JVE90bmRsbnZIakdIMW9i?=
 =?utf-8?B?am93L2o5U1ZDaFdnVmVFMDZHYXQxQWo1Mm4vZmpXQ2RLdm5rTDJrdVlaeDAx?=
 =?utf-8?B?UjE3MkxEVEpFZktNQzN5UDlVSUJOcG01d01zakdNVi9FNE5nYkpGT25Ua0Fn?=
 =?utf-8?B?YlBDVFhsd0kreDNjZU5JZUNiYXpqVDRDRUJFbVlVUEVZV3pac0d1Z0Joencz?=
 =?utf-8?B?QlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f0416f-0832-43a1-9e0c-08dcddb1776f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 22:29:06.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wPGdSyQxJl3q82C56I7fUCqrd86IsRIqnypXLOwIwhcmzpFo8IwDpgcRoAQfJ4gVarf9ifrncPLQorkm7s4QuHoinZFNxxkAfqsJ0d2WU00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwgMjAyNCAy
OjA2IFBNDQo+IFRvOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gQ2M6
IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBucGhhbWNz
QGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2OyB1c2FtYWFyaWY2NDJAZ21h
aWwuY29tOw0KPiBzaGFrZWVsLmJ1dHRAbGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsg
SHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207
IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGlu
dGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+
OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiB6c3dh
cF9zdG9yZSgpLg0KPiANCj4gT24gV2VkLCBTZXAgMjUsIDIwMjQgYXQgMToxM+KAr1BNIEpvaGFu
bmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3JnPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdl
ZCwgU2VwIDI1LCAyMDI0IGF0IDEyOjM5OjAyUE0gLTA3MDAsIFlvc3J5IEFobWVkIHdyb3RlOg0K
PiA+ID4gT24gV2VkLCBTZXAgMjUsIDIwMjQgYXQgMTI6MjDigK9QTSBKb2hhbm5lcyBXZWluZXIN
Cj4gPGhhbm5lc0BjbXB4Y2hnLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IE9uIFdlZCwg
U2VwIDI1LCAyMDI0IGF0IDExOjMwOjM0QU0gLTA3MDAsIFlvc3J5IEFobWVkIHdyb3RlOg0KPiA+
ID4gPiA+IEpvaGFubmVzIHdyb3RlOg0KPiA+ID4gPiA+ID4gSWYgdGhpcyBldmVyIGJlY29tZXMg
YW4gaXNzdWUsIHdlIGNhbiBoYW5kbGUgaXQgaW4gYSBmYXN0cGF0aC0NCj4gc2xvd3BhdGgNCj4g
PiA+ID4gPiA+IHNjaGVtZTogY2hlY2sgdGhlIGxpbWl0IHVwIGZyb250IGZvciBmYXN0LXBhdGgg
ZmFpbHVyZSBpZiB3ZSdyZQ0KPiA+ID4gPiA+ID4gYWxyZWFkeSBtYXhlZCBvdXQsIGp1c3QgbGlr
ZSBub3c7IHRoZW4gbWFrZQ0KPiBvYmpfY2dyb3VwX2NoYXJnZV96c3dhcCgpDQo+ID4gPiA+ID4g
PiBhdG9taWNhbGx5IGNoYXJnZSBhZ2FpbnN0IHpzd2FwLm1heCBhbmQgdW53aW5kIHRoZSBzdG9y
ZSBpZiB3ZQ0KPiByYWNlZC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBGb3Igbm93LCBJIHdv
dWxkIGp1c3Qga2VlcCB0aGUgc2ltcGxlIHZlcnNpb24gd2UgY3VycmVudGx5IGhhdmU6DQo+IGNo
ZWNrDQo+ID4gPiA+ID4gPiBvbmNlIGluIHpzd2FwX3N0b3JlKCkgYW5kIHRoZW4ganVzdCBnbyBh
aGVhZCBmb3IgdGhlIHdob2xlIGZvbGlvLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBhbSBub3Qg
dG90YWxseSBhZ2FpbnN0IHRoaXMgYnV0IEkgZmVlbCBsaWtlIHRoaXMgaXMgdG9vIG9wdGltaXN0
aWMuDQo+ID4gPiA+ID4gSSB0aGluayB3ZSBjYW4ga2VlcCBpdCBzaW1wbGUtaXNoIGJ5IG1haW50
YWluaW5nIGFuIGV3bWEgZm9yIHRoZQ0KPiA+ID4gPiA+IGNvbXByZXNzaW9uIHJhdGlvLCB3ZSBh
bHJlYWR5IGhhdmUgcHJpbWl0aXZlcyBmb3IgdGhpcyAoc2VlDQo+ID4gPiA+ID4gREVDTEFSRV9F
V01BKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZW4gaW4genN3YXBfc3RvcmUoKSwgd2UgY2Fu
IHVzZSB0aGUgZXdtYSB0byBlc3RpbWF0ZSB0aGUNCj4gY29tcHJlc3NlZA0KPiA+ID4gPiA+IHNp
emUgYW5kIHVzZSBpdCB0byBkbyB0aGUgbWVtY2cgYW5kIGdsb2JhbCBsaW1pdCBjaGVja3Mgb25j
ZSwgbGlrZSB3ZQ0KPiA+ID4gPiA+IGRvIHRvZGF5LiBJbnN0ZWFkIG9mIGp1c3QgY2hlY2tpbmcg
aWYgd2UgYXJlIGJlbG93IHRoZSBsaW1pdHMsIHdlDQo+ID4gPiA+ID4gY2hlY2sgaWYgd2UgaGF2
ZSBlbm91Z2ggaGVhZHJvb20gZm9yIHRoZSBlc3RpbWF0ZWQgY29tcHJlc3NlZCBzaXplLg0KPiA+
ID4gPiA+IFRoZW4gd2UgY2FsbCB6c3dhcF9zdG9yZV9wYWdlKCkgdG8gZG8gdGhlIHBlci1wYWdl
IHN0dWZmLCB0aGVuIGRvDQo+ID4gPiA+ID4gYmF0Y2hlZCBjaGFyZ2luZyBhbmQgc3RhdHMgdXBk
YXRlcy4NCj4gPiA+ID4NCj4gPiA+ID4gSSdtIG5vdCBzdXJlIHdoYXQgeW91IGdhaW4gZnJvbSBt
YWtpbmcgYSBub24tYXRvbWljIGNoZWNrIHByZWNpc2UuIFlvdQ0KPiA+ID4gPiBjYW4gZ2V0IGEg
aHVuZHJlZCB0aHJlYWRzIGRldGVybWluaW5nIGRvd24gcHJlY2lzZWx5IHRoYXQgKnRoZWlyKg0K
PiA+ID4gPiBzdG9yZSB3aWxsIGZpdCBleGFjdGx5IGludG8gdGhlIGxhc3QgODAwa0IgYmVmb3Jl
IHRoZSBsaW1pdC4NCj4gPiA+DQo+ID4gPiBXZSBqdXN0IGdldCB0byBhdm9pZCBvdmVyc2hvb3Rp
bmcgaW4gY2FzZXMgd2hlcmUgd2Uga25vdyB3ZSBwcm9iYWJseQ0KPiA+ID4gY2FuJ3QgZml0IGl0
IGFueXdheS4gSWYgd2UgaGF2ZSA0S0IgbGVmdCBhbmQgd2UgYXJlIHRyeWluZyB0byBjb21wcmVz
cw0KPiA+ID4gYSAyTUIgVEhQLCBmb3IgZXhhbXBsZS4gSXQganVzdCBtYWtlcyB0aGUgdXBmcm9u
dCBjaGVjayB0byBhdm9pZA0KPiA+ID4gcG9pbnRsZXNzIGNvbXByZXNzaW9uIGEgbGl0dGxlIGJp
dCBtb3JlIG1lYW5pbmdmdWwuDQo+ID4NCj4gPiBJIHRoaW5rIEknbSBtaXNzaW5nIHNvbWV0aGlu
Zy4gSXQncyBub3QganVzdCBhbiB1cGZyb250IGNoZWNrLCBpdCdzDQo+ID4gdGhlIG9ubHkgY2hl
Y2suIFRoZSBjaGFyZ2UgZG93biB0aGUgbGluZSBkb2Vzbid0IGxpbWl0IGFueXRoaW5nLCBpdA0K
PiA+IGp1c3QgY291bnRzLiBTbyBpZiB0aGlzIGNoZWNrIHBhc3Nlcywgd2UgV0lMTCBzdG9yZSB0
aGUgZm9saW8uIFRoZXJlDQo+ID4gaXMgbm8gcG9pbnRsZXNzIGNvbXByZXNzaW9uLg0KPiANCj4g
SSBnb3QgY29uZnVzZWQgYnkgd2hhdCB5b3Ugc2FpZCBhYm91dCB0aGUgZmFzdC1zbG93IHBhdGgs
IEkgdGhvdWdodA0KPiB5b3Ugd2VyZSBzdWdnZXN0aW5nIHdlIGRvIHRoaXMgbm93LCBzbyBJIHdh
cyBzYXlpbmcgaXQncyBiZXR0ZXIgdG8gdXNlDQo+IGFuIGVzdGltYXRlIG9mIHRoZSBjb21wcmVz
c2VkIHNpemUgaW4gdGhlIGZhc3QgcGF0aCB0byBhdm9pZCBwb2ludGxlc3MNCj4gY29tcHJlc3Np
b24uDQo+IA0KPiBJIG1pc3NlZCB0aGUgc2Vjb25kIHBhcmFncmFwaC4NCj4gDQo+ID4NCj4gPiBX
ZSBtaWdodCBvdmVyc2hvb3QgdGhlIGxpbWl0IGJ5IGFib3V0IG9uZSBmb2xpbyBpbiBhIHNpbmds
ZS10aHJlYWRlZA0KPiA+IHNjZW5hcmlvLiBCdXQgdGhhdCBpcyBuZWdsaWdpYmxlIGluIGNvbXBh
cmlzb24gdG8gdGhlIG92ZXJzaG9vdCB3ZSBjYW4NCj4gPiBnZXQgZHVlIHRvIHJhY2UgY29uZGl0
aW9ucy4NCj4gPg0KPiA+IEFnYWluLCBJIHNlZSBubyBubyBwcmFjdGljYWwsIG1lYW5pbmdmdWwg
ZGlmZmVyZW5jZSBpbiBvdXRjb21lIGJ5DQo+ID4gbWFraW5nIHRoYXQgbGltaXQgY2hlY2sgYW55
IG1vcmUgcHJlY2lzZS4gSnVzdCBrZWVwIGl0IGFzLWlzLg0KPiANCj4gPiBTb3JyeSB0byBiZSBi
bHVudCwgYnV0ICJwcmVjaXNpb24iIGluIGEgbm9uLWF0b21pYyBjaGVjayBsaWtlIHRoaXM/DQo+
ID4gbWFrZXMgbm8gc2Vuc2UuIFRoZSBmYWN0IHRoYXQgaXQncyBub3QgdG9vIGV4cGVuc2l2ZSBp
cyBpcnJlbGV2YW50Lg0KPiA+IFRoaXMgZGlzY3Vzc2lvbiBhcm91bmQgdGhpcyBob25lc3RseSBo
YXMgZ29uZSBvZmYgdGhlIHJhaWxzLg0KPiANCj4gWWVhaCBJIHRob3VnaHQgd2Ugd2VyZSB0YWxr
aW5nIGFib3V0IHRoZSB2ZXJzaW9uIHdoZXJlIHdlIHJvbGxiYWNrDQo+IGNvbXByZXNzaW9ucyBp
ZiB3ZSBvdmVyc2hvb3QsIG15IGJhZC4gV2UgZGlzY3Vzc2VkIHF1aXRlIGEgZmV3IHRoaW5ncw0K
PiBhbmQgSSBtYW5hZ2VkIHRvIGNvbmZ1c2UgbXlzZWxmLg0KPiANCj4gPiBKdXN0IGxlYXZlIHRo
ZSBsaW1pdCBjaGVja3MgZXhhY3RseSBhcyB0aGV5IGFyZS4gQ2hlY2sgbGltaXRzIGFuZA0KPiA+
IGNncm91cF9tYXlfenN3YXAoKSBvbmNlIHVwIGZyb250LiBDb21wcmVzcyB0aGUgc3VicGFnZXMu
IEFjcXVpcmUNCj4gPiByZWZlcmVuY2VzIGFuZCBidW1wIGFsbCBzdGF0cyBpbiBiYXRjaGVzIG9m
IGZvbGlvX25yX3BhZ2VzKCkuIFlvdSBjYW4NCj4gPiBhZGQgdXAgdGhlIHN1YnBhZ2UgY29tcHJl
c3NlZCBieXRlcyBpbiB0aGUgZm9yLWxvb3AgYW5kIGRvIHRoZQ0KPiA+IG9ial9jZ3JvdXBfY2hh
cmdlX3pzd2FwKCkgaW4gYSBzaW5nbGUgY2FsbCBhdCB0aGUgZW5kIGFzIHdlbGwuDQo+IA0KPiBX
ZSBjYW4ga2VlcCB0aGUgbGltaXQgY2hlY2tzIGFzIHRoZXkgYXJlIGZvciBub3csIGFuZCByZXZp
c2l0IGFzIG5lZWRlZC4NCg0KVGhhbmtzIEpvaGFubmVzIGFuZCBZb3NyeSBmb3IgdGhlIGRpc2N1
c3Npb24hIEkgd2lsbCBwcm9jZWVkIGFzIHN1Z2dlc3RlZC4NCg0KVGhhbmtzLA0KS2FuY2hhbmEN
Cg==

