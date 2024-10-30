Return-Path: <linux-kernel+bounces-389453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C19B6D45
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20246282147
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037F1D130B;
	Wed, 30 Oct 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drDfGITv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9561BD9D8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318892; cv=fail; b=X7WHpPtRyaIx14UBdwpFerIh+MHcMnHcCEw7j7NlQ5GZjOt5JoAaROefomjxQLaz8RTfj6KJFmbLghNBYYFZQrKnmq0EvQ7g9j5STY1OzDd0Tszo0mpk0iLlRpqr9nittVaofOoPrMo9LMubOQqIy9K6qMQrm5ZSDqbA5Jq67ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318892; c=relaxed/simple;
	bh=xb0lQibpRTX+UUlaRNN6pKksvMDuj8bFe7/zgIpIGmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HV1c6EInE6l+j4doTrq3yk1D1hfYgeQ9pYF++x1gVV6qDiLYVMyZ4WJL9M2V+vsgje368tVeiuPni0TVEFzYTTlP1LRTmPruKAMFrRbXyfkkxzpC+2TJVJBkUAqSYv/P9yuZ5mbU8tr//RMPTfzatNLbHYN6TqBmt7vPyEP/nlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drDfGITv; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730318890; x=1761854890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xb0lQibpRTX+UUlaRNN6pKksvMDuj8bFe7/zgIpIGmk=;
  b=drDfGITvuk6+1vX4beogH5H8zUnb6lT6rQs4M1A3G3pKYzV6kd4Pz7U6
   eY9LJZsPfqJltTSFPqN8pLevDJ4TQN227u58VrTH4pBXVuT2VAD0m9KPA
   I3TAfM2IQoCRjCSqUsDLC2mXvcEj3shWX5d/rd9QR2y9GdKptmLucHqly
   veusAVbW9iNYRd9yD3trxiFB5cBaWhXatfB+6KKQqndQ+qD/1RmrT3oFv
   n2AGFD/4FYW6jtP6VdgV/kR0Fcr2q9dNAZtPA0/E7G65i1qGCSO+3Ravs
   1ZPW37o/T6xpl20k301hlAwBBzTSFRVwMotsjZgnYb/USsrJe+pvxP6ni
   A==;
X-CSE-ConnectionGUID: tzNuQa10Q7uRqQuVLi4Fmg==
X-CSE-MsgGUID: 5W0Ic5xBRpSx4HN+p2JgGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29810001"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29810001"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 13:08:10 -0700
X-CSE-ConnectionGUID: /3NedgkESx6i7tqrz6PQNw==
X-CSE-MsgGUID: Ub9Fl0faRSqO5cGU6FMyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87213205"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 13:08:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 13:08:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 13:08:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 13:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvL6Q3rruH4fv5B8YuXh+YCrnGXi7YKg5SBt8XpSyCjO4u4b5Yq0IEjD09P9cQVTbLKDyWNnya1zKIEuQFq6N8a5FIlqmqwvSvARKETO3+2aa0TjjQ6yStPr0muMXFErgzwIHQ1V30+QmlSBuKTLM4O0CbVcKL5B7jbgaTQ7yNCth/Rbh5LEL1T4BBIEiJkF5n/mwz97suNx2cTYy+NofYHjs+7wuWoEhDeSHIdQl+U/HMeMqCch5MODPQNXSG0BSAdfnwgLzA3QcAb9Q7QmcDSKSctoTXWZBRvy7bROKTg1nZofWelrQuUFrtTGKYFulz33DNPiwCjusNBdGCU19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb0lQibpRTX+UUlaRNN6pKksvMDuj8bFe7/zgIpIGmk=;
 b=cdUVYnDuozJ212h2dkt5xqhvm2IhPgKazHfvVVTH/rK7rwhDT0UG7E3WVIzdUACmbNZ+mQXUvGXxJN0IAJb5y9HT+OWR2E6Lm0NBqvNfsn92E3UU3Wn3i19ossZonqTrcjMthS1v4iRdIYich9k84ACeQyawoMl5kBV76FQsuEsvFj5HPhb8nnoo0adEqTZVcSM1+N60yxl2BfFxBycDa1c1AmwyqlssfrCMlEqJninPGZUF8bPbaSSW82VpXR2VO7wf6bjVZxUg/RaX8jU28m4Zj7zbsdyxApk1hYCOPdLk4Wj/AFlmIvETkUUj2Ah/JI/vj5PUYgm8zgF8y6RQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 20:07:59 +0000
Received: from PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac]) by PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac%6]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 20:07:59 +0000
From: "Constable, Scott D" <scott.d.constable@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Milburn,
 Alyssa" <alyssa.milburn@intel.com>, "joao@overdrivepizza.com"
	<joao@overdrivepizza.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"jose.marchesi@oracle.com" <jose.marchesi@oracle.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>
Subject: RE: [PATCH 11/14] llvm: kCFI pointer stuff
Thread-Topic: [PATCH 11/14] llvm: kCFI pointer stuff
Thread-Index: AQHbERaYDzK8jBVcnECFIEYLVO29VrKfA1eggADk6eA=
Date: Wed, 30 Oct 2024 20:07:59 +0000
Message-ID: <PH7PR11MB75722452CAEDFFE4C80FC05CBB542@PH7PR11MB7572.namprd11.prod.outlook.com>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.498161564@infradead.org>
 <PH7PR11MB7572C2DD0A7B5963D1ABA77ABB542@PH7PR11MB7572.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7572C2DD0A7B5963D1ABA77ABB542@PH7PR11MB7572.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7572:EE_|PH7PR11MB6476:EE_
x-ms-office365-filtering-correlation-id: fba6faf9-a8fb-417d-ac9e-08dcf91e8d7d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXd2U05XTzA4NW52TjBOZEFwN0x1NkZTZi9id3d0azJWSmYwWnpVc2V5cm1M?=
 =?utf-8?B?WnpJQ1kwaEFwRVRoelZ2VDNJVTdXODVhMlVsM1grSjcrY1BZWDNUSkhSd2U2?=
 =?utf-8?B?VU91VWxJNkVONHhTdEp2WXdTMVVnNEphOFRpUlV1Ri9GYWtuNEJtR1Qrd1Nr?=
 =?utf-8?B?RGpSdXRXK01MQ2FwRjlsN2JYWDBhUEwxREV0c2NXTG1BcEZNbHlNSzVBaHYx?=
 =?utf-8?B?Y1BsNjBGS1NHd1dxQUlML0pxem5HNi9acU5PZVlkMWNobEZoYklSUHU3TDlu?=
 =?utf-8?B?VWF1OCtvc1krWGJIZEVRQTAxWDZsa0h4V21tSHZJa05uZUVqaGg3VmhjOG9w?=
 =?utf-8?B?VHRWOTVwTHZMbm9FOWk3bmxvRFFpYStJazI1ODMwa255L25oSFVPVkxubis1?=
 =?utf-8?B?RnNmNmNuK0FTMm9mKzFRYisyemt0RnZLT2JXK2dMTnd3anU4WmJPckw4RElK?=
 =?utf-8?B?WjExWFJEUmh1QXZmWVkzbEk1bCt3STFIOTdVRjJUamhWMTJuN2xpcEhrSE83?=
 =?utf-8?B?ZXZKQndWTFRkdVNCejVJd0FSL0lmOHcvM2M2cStJQXM4NStLZmxzZktlb2tS?=
 =?utf-8?B?YWRwRVFUcDh2d3ZKMGV6ZkwyOXRENEs5K2VGL2JaNTlRRFVFazFKYWwrN2NO?=
 =?utf-8?B?dyt6ZGhIM0s1Y3dVMWIzQUpGb3BlVHA0bFZjdDZ2WG5Yalc4WEZrdldXelNS?=
 =?utf-8?B?eWlRaW42RjNEMHBZTFpHNjkxRFovV1JMSlBjaWNhaHlxdnV5SWJhbDgzUFNE?=
 =?utf-8?B?OEpBb0I5Y3FVRjl4RFdiR3lCNGt2TlhzamVMUDhsSWY2TllXWjIvVGpMVlhV?=
 =?utf-8?B?T3BlT3o1aEttSjBMaWRlUEhSb0svWU40ZzFqOGhtSlhFZkhmbloxVG1IZmhQ?=
 =?utf-8?B?TXQwdDlEbFNuR0ZNWnkzcmV5VXJxZWlZSjVVMExDcXpmSDZZajhZQkxNMENv?=
 =?utf-8?B?WDFxMnRxVWt1TFpjVVJMNEx5TGc4UkREZXhqTS9KVEd4cWNPd21jSENOZ2Qw?=
 =?utf-8?B?aXVkYUFIb3A2MzJ3ZStpdiszbksyai9zZEFrUjZLQ0IvZUxaeHZtendYYzcz?=
 =?utf-8?B?VkczYjhiTER5UmhUL0lTVHNqQ05Udit2WER5T3hyVjN6aG9sK3Zja2hwdi8r?=
 =?utf-8?B?N2ozMjBUQzVJMmdybjZ1SU9NZzB4enpvdFptRkFyTmppWGQvK0ZrL1M2TkJq?=
 =?utf-8?B?MzZlb3ZndGx1T1R5emNJM0l6eDc3RitDNHo0YXNSYnMwcWtTaVZDVEJqbmpQ?=
 =?utf-8?B?b3YxdVpqWlRuTC9OaUdsUk9CK2NtUU1memhGcElISHlYWnc1TzFCcnhSeVZI?=
 =?utf-8?B?U2d4dS82Q0IrM3pNdEtJZ2EzaWwxbzQ3aENDSEdkL1pkcVBJeUc0RzhROTAv?=
 =?utf-8?B?MkZNbHVYNk02M3lLMGVxR251WjRidW9oYVg3VzM3KzJXUlJXZGtGeXYyOEhk?=
 =?utf-8?B?N0NSZU9Gd015SmZtQVpKU0UwUlNOZTNkcjEybzVUaDFhWFRCQUhrNE9yZFdx?=
 =?utf-8?B?NUJpNGtaVUFJRmNKOS9iblFZanJ6ekVqcWdQMEF4TmFoQmw5M1hnSTBMd3E0?=
 =?utf-8?B?d1RKYkZJMFNJWFF3K2RyQkxHS0xGUCtFSS9KRGdTTy9vYWxLU1pUbk1LTVdq?=
 =?utf-8?B?TnVXRTdmbTlJck03KzFKaWtuMGVzNE5FSjJBdDZHMi9IbGV2alpHSldKV01m?=
 =?utf-8?B?OUlob1VuZFRQeTEzK0dkS3lwNUg2bFBmYlpaK3IzeHNDT0dBUVVlSkczWXV2?=
 =?utf-8?B?WHFLNzJCRGZyZmFkVmh6TFNWMTUxamYrZFlod1FmbjQ4TlRJWEwwSE93S3di?=
 =?utf-8?Q?qa+x/zOHJMMVE+/SNQfqRv8q8/sMDcg0qH0uA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?andWSUErOU1mdzkxdThKdU4wZ3ZoUVUvblQ3UWJmMWF4Ym54V01KVStBTGR4?=
 =?utf-8?B?aHVUcXlYUE5mMGcweDVmWmlNREkweExpZWdBeGw0eFBObmF0dEIvcTMvUkFB?=
 =?utf-8?B?TUtvZTB4ZWFXOHM5VHFKZGRaSkxIcGRqK21aQS82VE9nL2s4VWdkMGxGbGh6?=
 =?utf-8?B?YWdjYkpJZ1F4ZE9LNWZRQ3R2aitvb3krMFBjUk1ObGdIYkxwR084M2tNNGlr?=
 =?utf-8?B?UWh3NjQrMGtPUE5QT0ZPcmthaDcxN1dzMmJxTHFFTnBCMmVtRmpkNHhnbUpT?=
 =?utf-8?B?b3A1STVGbjQ3UTJIQWo2cE9iekc0Ti9iaEhJY0ZnMHQ4SXJ3QXRRSHJHaDZJ?=
 =?utf-8?B?T2I2Ulo4S1NYbWpWb3BsY05FOGdDVTlmaGRzL29zeEtqT0R4dTN2ZmhUeWlO?=
 =?utf-8?B?cGFjUkFjay92QUUxTkNmMEs1ekFoOE5WbkFITEdhb0xVZEhPUTZZQlhjZ285?=
 =?utf-8?B?Y290WWNseldWRjNMZno1YXpJRmJCazlDeldiUUZqOUo4SlpMUHN5RnpXQTlj?=
 =?utf-8?B?bmtBQjJEdElmQnZuWmZXOFBod2NIWUNDeXprdk40a3M5UUYrQk9uWnJEWHYz?=
 =?utf-8?B?YWhFVkpHSUQ5ZWx2cHRlWHo4ZVVuNTdyRklNTVoxamhZYkpFSEw5THBMSHdC?=
 =?utf-8?B?dWwrSXpmK0ZwY2c3UGdMWHBXTGNLOHhITXZ2OFJLNHlZVmlNUmhGSXNldUFD?=
 =?utf-8?B?eTR0UFB3czJVaDc0YjFYRE9RbWdUcnc1djVPUFFKREZjQ1lGSEFWTThIdW5H?=
 =?utf-8?B?VGVvb2hidndsZEIxb2FlcjdiWTlCWk5zZmFLWWRWSVdvWTJtYS9WM25oMi83?=
 =?utf-8?B?TWduSmdGNDlZWjlvT3V1R3VWN2hZUnFWeXVpa2JOSHpZd2JvZFM2bTlhdEcw?=
 =?utf-8?B?UTBnalZpQmJxZHpkVnVVdS9jRWxydmVqRm1QY0YrUkFDRjNscDg1aE9pWHY1?=
 =?utf-8?B?NFh3RzJRMEhFei9iSEJ1cVRBT1lBVHVIb3QwaWwxdW1jOTgxZ0FTeWFxeE1i?=
 =?utf-8?B?SFpCS0JhRlo2cS9wVHJGQ1c2RVhWNjVmdnFqMVRWUjFDVzJKQUZPRmtTdlVR?=
 =?utf-8?B?U2huQlNrUUwvRE0ybGRUQ0pPdk0ySUtFN0o0eFRLaUNiYTRHcHk1QzRubFVu?=
 =?utf-8?B?MS8wcHRlOGtoM0JqK0hKb2lLS25HOWlvdUlmTFJITnJRa1JpWjVBNk50UDhL?=
 =?utf-8?B?dlpoN0NQSVcyWTVqYllHTEh5d01TZWhFNlh0ZzZ5Ty8vYlVuRS9HaFQwd1RM?=
 =?utf-8?B?MTJMWllxT2N5d3NZK0tIS3JZOVNWVW0vL2VseE5MSG9Ea0QxZDl5TUtxQURT?=
 =?utf-8?B?VmZzeVpJRUl4WXVnbW1MUEdrOTM2ekxPZVAxTnh3N0lzekduR21PVTNQQ3I0?=
 =?utf-8?B?Yy85dXFtOUhPNUNpaEs1NkQvZnBmZlpPT2JONExJSzNhekI1Q1lHYkVhTGl3?=
 =?utf-8?B?ck5zeW0xS05SYXVWZlVrQm9nVmxBaXg2SVdrQWttVDZ0QURGRGlaK0ZmT3Mx?=
 =?utf-8?B?clVFRjdkWm9xLzczUlNIbGFCWDlIeGlETk03cnI4OXVqTHhQWVdPb3RCb2Jm?=
 =?utf-8?B?a0dtbklnWm0yWm91UGcxWENhcWltTzBLMW1RUEM4amZJVDk4L1FsbURKdTha?=
 =?utf-8?B?eUE1RktnR2VKQnU0SEtCdXpySDJiMEhwSTNuaGFXNlJBTUdGWGwzc2hHRWdr?=
 =?utf-8?B?aklMQ3BkUXRrVENtM1VyMTdYR3NCTTRBQU5POWVVemtMck50K2hHVjNYY3hr?=
 =?utf-8?B?aUVqVmxzWE1HRXNVU0hkV1crY0dEUndVR05vWVFDRmtkVTlKR2pSbkFtbzB2?=
 =?utf-8?B?MUFrMWhSK1U5L3ZSNFlZNkNyeWVEbXMwbkFhNEZzbDUxVTloN2hqUzB2MFND?=
 =?utf-8?B?aFdoM0RCYXc2OXI5dWdxaFRLcXZFQVU0SDNhME4xUTJIVkZQMld6MlVFczJt?=
 =?utf-8?B?TzFZQW1nQXRKZU14aklvaS9QMm1zcUlvN0hTRjJCeUlySzlrbEp6ZDJzd2lt?=
 =?utf-8?B?NHkrSHBUbWR6cVlSSHlqRnMweC9HUzZIOHZLb0JqQndXeGIwRWhSOTdxUll6?=
 =?utf-8?B?YWEwZmlXemZzeDRzMWFsdTVWbldXUHh5UDJRTmlGS1dLdU9HMGhrdnRXdEhz?=
 =?utf-8?B?VzBEaHViVkZRZ2lBRG1mekg4TmtjWWE5L2pBbXVjdUpSOCtEdE5hNytxQTNU?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7572.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba6faf9-a8fb-417d-ac9e-08dcf91e8d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 20:07:59.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dm0zk8nxVeurWEVj6saqM3qRRhyC35YvnoBsLigZfxBfTZF1NuZnY/RFNWR8HAstWWff6FvkqxQ9S2LGuX1tmCNrKzEkSgBWbFZWGkKy194=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com

PiA+IFF1aWNrIGhhY2sgdG8gZXh0ZW5kIHRoZSBDbGFuZy1rQ0ZJIGZ1bmN0aW9uIG1ldGEtZGF0
YSAodTMyIGhhc2gpIHdpdGggYSB1OCBiaXRtYXNrIG9mIHBvaW50ZXIgYXJndW1lbnRzLiBUaGlz
IHNob3VsZCByZWFsbHkgYmUgdW5kZXIgYSBuZXcgY29tcGlsZXIgZmxhZywgZGVwZW5kZW50IG9u
IGJvdGggeDg2XzY0IGFuZCBrQ0ZJLg0KPiA+IA0KPiA+IFBlciB0aGUgY29tbWVudCwgdGhlIGJp
dG1hc2sgcmVwcmVzZW50cyB0aGUgcmVnaXN0ZXIgYmFzZWQgYXJndW1lbnRzIGFzIHRoZSBmaXJz
dCA2IGJpdHMgYW5kIGJpdCA2IGlzIHVzZWQgdG8gY292ZXIgYWxsIHN0YWNrIGJhc2VkIGFyZ3Vt
ZW50cy4gVGhlIGhpZ2ggYml0IGlzIHVzZWQgZm9yIGludmFsaWQgdmFsdWVzLg0KPiA+IA0KPiA+
IFRoZSBwdXJwb3NlIGlzIHRvIHB1dCBhIHN0b3JlIGRlcGVuZGVuY3kgb24gdGhlIHNldCByZWdp
c3RlcnMsIHRoZXJlYnkgYmxvY2tpbmcgc3BlY3VsYXRpb24gcGF0aHMgdGhhdCB3b3VsZCBvdGhl
cndpc2UgZXhwb2l0IHRoZWlyIHZhbHVlLg0KPiANCj4gR2l2ZW4gdGhlIG9uZ29pbmcgZGlzY3Vz
c2lvbiBvbiBbUEFUQ0ggMTMvMTRdIHdoZXJlIHRoZXJlIGlzIGEgZ3Jvd2luZyBjb25zZW5zdXMg
dGhhdCBhbGwgYXJndW1lbnRzIChub3QganVzdCBwb2ludGVycykgc2hvdWxkIGJlIHBvaXNvbmVk
IGFmdGVyIGEgbWlzcHJlZGljdGlvbiwgYSBkaWZmZXJlbnQgZW5jb2Rpbmcgc2NoZW1lIHdvdWxk
IGJlIG5lZWRlZC4gSSBiZWxpZXZlIHRoZXJlIGFyZSA4IHBvc3NpYmlsaXRpZXMsIHdoaWNoIGNv
cnJlc3BvbmQgdG8gdGhlIGZ1bmN0aW9uJ3MgYXJpdHk6DQo+IA0KPiAwOiBGdW5jdGlvbiB0YWtl
cyAwIGFyZ3MNCj4gMTogRnVuY3Rpb24gdGFrZXMgMSBhcmcNCj4gMjogRnVuY3Rpb24gdGFrZXMg
MiBhcmdzDQo+IDM6IEZ1bmN0aW9uIHRha2VzIDMgYXJncw0KPiA0OiBGdW5jdGlvbiB0YWtlcyA0
IGFyZ3MNCj4gNTogRnVuY3Rpb24gdGFrZXMgNSBhcmdzDQo+IDY6IEZ1bmN0aW9uIHRha2VzIDYg
YXJncw0KPiA3OiBGdW5jdGlvbiB0YWtlcyA+NiBhcmdzDQo+DQo+IFRoZXNlIHBvc3NpYmlsaXRp
ZXMgY2FuIGJlIGVuY29kZWQgd2l0aCAzIGJpdHMuIEkgc3VzcGVjdCB0aGF0IGl0IG1pZ2h0IGFj
dHVhbGx5IGJlIGJlbmVmaWNpYWwgdG8gc3RlYWwgMyBiaXRzIGZyb20gdGhlIHUzMiBrQ0ZJIGhh
c2ggKGVpdGhlciBieSB1c2luZyBhIHNtYWxsZXIgMjktYml0IGhhc2ggb3IgYnkgdHJ1bmNhdGlu
ZyB0aGUgMzItYml0IGhhc2ggZG93biB0byAyOSBiaXRzKS4gVGhpcyBzY2hlbWUgd291bGQgYXJn
dWFibHkgc3RyZW5ndGhlbiBib3RoIGtDRkkgYW5kIEZpbmVJQlQgYnkgcGFydGl0aW9uaW5nIENG
SSBlZGdlcyBzdWNoIHRoYXQgYSBqLWFyaXR5IGZ1bmN0aW9uIGNhbm5vdCBjYWxsIGEgay1hcml0
eSBmdW5jdGlvbiB1bmxlc3Mgaj1rIChvciB1bmxlc3Mgaj42IGFuZCBrPjYpOyB0aGUgY3VycmVu
dCAzMi1iaXQga0NGSSBoYXNoIGRvZXMgbm90IHByZXZlbnQsIGZvciBleGFtcGxlLCBhIDItYXJp
dHkgZnB0ciBmcm9tIGNhbGxpbmcgYSAzLWFyaXR5IHRhcmdldCBpZiB0aGUga0NGSSBoYXNoZXMg
Y29sbGlkZS4gVGhlIGRpc2FkdmFudGFnZSBvZiB0aGUgMjktYml0IGhhc2ggaXMgdGhhdCBpdCB3
b3VsZCBpbmNyZWFzZSB0aGUgcHJvYmFiaWxpdHkgb2YgY29sbGlzaW9ucyB3aXRoaW4gZWFjaCBh
cml0eSwgYnV0IG9uIHRoZSBvdGhlciBoYW5kIHRoZSB0b3RhbCBudW1iZXIgb2YgZnVuY3Rpb25z
IG9mIGVhY2ggZ2l2ZW4gYXJpdHkgaXMgbXVjaCBzbWFsbGVyIHRoYW4gdGhlIHRvdGFsIG51bWJl
ciBvZiBmdW5jdGlvbnMgb2YgYWxsIGFyaXRpZXMuDQoNCkkgaGF2ZSBkb25lIHNvbWUgYWRkaXRp
b25hbCBhbmFseXNpcyBvbiBteSBOb2JsZSBrZXJuZWwsIHdoaWNoIHN1Z2dlc3RzIHRoYXQgdGhl
IHByb3Bvc2VkIDI5LWJpdCBoYXNoIHdpdGggMy1iaXQgYXJpdHkgd2lsbCBvbmx5IGJlIG1vcmUg
c2VjdXJlIHRoYW4gdGhlIGV4aXN0aW5nIDMyLWJpdCBoYXNoLiBDb25zaWRlcjogTXkga2VybmVs
IGhhcyAxNDEsNjE3IHRvdGFsIGluZGlyZWN0IGNhbGwgdGFyZ2V0cywgd2l0aCAxMCw5MDMgdW5p
cXVlIGZ1bmN0aW9uIHR5cGVzLiBXaXRoIGEgMzItYml0IGtDRkkgaGFzaCwgdGhlIGV4cGVjdGVk
IG51bWJlciBvZiBjb2xsaXNpb25zIGlzIDJeLTMyICogKDEwOTAzIEMgMikgPSAwLjAxMzgzNzY1
LiBUaGVuIEkgc2Nhbm5lZCB0aGUga2VybmVsIHRvIGlkZW50aWZ5IHRoZSBudW1iZXIgb2YgdW5p
cXVlIGZ1bmN0aW9uIHR5cGVzIGZvciBlYWNoIGFyaXR5LCBhbmQgY29tcHV0ZWQgdGhlIGNvcnJl
c3BvbmRpbmcgZXhwZWN0ZWQgbnVtYmVyIG9mIGNvbGxpc2lvbnMgd2l0aGluIGVhY2ggYXJpdHks
IGFuZCBhc3N1bWluZyBhIDI5LWJpdCBoYXNoOg0KDQojIEFyZ3MJdG90YWwgdGFyZ2V0cwl1bmlx
dWUgdHlwZXMJRXhwZWN0ZWQgY29sbGlzaW9ucw0KMAkxMjY4MgkzMgkwLjAwMDAwMDkyDQoxCTQy
OTgxCTI0OTIJMC4wMDU3ODEyNQ0KMgkzNzY1NwkzNzc1CTAuMDEzMjY4NDENCjMJMjk0MzYJMjU0
NwkwLjAwNjAzOTMxDQo0CTEyMzQzCTExNjkJMC4wMDEyNzE2Mg0KNQk0MTM3CTUxOQkwLjAwMDI1
MDM4DQo2CTE3MDAJMjIxCTAuMDAwMDQ1MjgNCm1vcmUJNjgxCTE0OAkwLjAwMDAyMDI2DQoNCihT
b3JyeSBpZiB0aGUgZm9ybWF0dGluZyBiZWNhbWUgd2VpcmQgYWZ0ZXIgY29weWluZyBmcm9tIEV4
Y2VsKQ0KDQpIZW5jZSwgZXZlbiB0aGUgYXJpdHkgKDIpIHdpdGggdGhlIGxhcmdlc3QgbnVtYmVy
IG9mIHVuaXF1ZSBmdW5jdGlvbiB0eXBlcyAoMzc3NSkgaGFzIGEgbG93ZXIgZXhwZWN0ZWQgdmFs
dWUgZm9yIDI5LWJpdCBjb2xsaXNpb25zICgwLjAxMzI2ODQxKSB0aGFuIHRoZSBleHBlY3RlZCB2
YWx1ZSBmb3IgMzItYml0IGNvbGxpc2lvbnMgKDAuMDEzODM3NjUpLg0KDQpSZWdhcmRzLA0KDQpT
Y290dCBDb25zdGFibGUNCg==

