Return-Path: <linux-kernel+bounces-560481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74715A60532
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E47119C38A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753421F8BAC;
	Thu, 13 Mar 2025 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISNkr7el"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE92AF00
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741907850; cv=fail; b=tM4XXGGyYyjtxRJajNC4iGXNiOVTQQmcytQY5EaZOO7xPrypH2QSkWk68GxiThv6rT+tl1gRKAuVUMq3ibDzgSCuhOkXladmkvEt5CfkpE2h0PfiXIDsU2tUciiFHfkFN+8cQDWotvedMTUEAs/Mq/1hfirZo7G+41oVZKDSV5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741907850; c=relaxed/simple;
	bh=3DmEOQsk5A4KgDmZDVhTba6fi/r7BkAvRgb/dvRQ6PA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b61x0JyaUOwr1zy0t82ZkG0mYQObK1fOINGrZQBe8826Sv+oKNpeE0RPqJvC7weHBzk2BCHKU5GJidmDzInD0+grfsJZBr6cRPZg6ngjgX0ZhP0jBBuEl8Z6NMD6Rk9eGsWkB3NTeqJSUba9tpb/o6XkOJDYveNGrOBvJyutB08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISNkr7el; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741907848; x=1773443848;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3DmEOQsk5A4KgDmZDVhTba6fi/r7BkAvRgb/dvRQ6PA=;
  b=ISNkr7el0n5HHKshjr7/f9+qniH4F+yNw2wivjLDZihgv/AObe83etXK
   3iYk4EyOtTOQr5gx8vB3NSutyLzHDZYcFPG9l0axYmuXY50NwcataNzPv
   rD1NEeJcfilzPzHgYqfuRC4713l8SetACfTIwSmHzV3NzFQ3uCtTR/UHJ
   EHCQG50jARlwI5ZAsTOVphiyD/+SedeUy8LShRigtzRMfWSL0LuymVx1k
   HAZE4nFCbok0uTorPgqhC8PcXlCEzMmCoYlhxpGLnka+3XsNPMkwnTjbH
   vUnd1s7fPBJGkbVpaazAbU90NRZ4IIsFCxGe0RI2tsTdffHVrHeKWcef+
   Q==;
X-CSE-ConnectionGUID: +FU+sUP7QtiPnaxJquj0Sg==
X-CSE-MsgGUID: PHu8o/KpQReFUNEcbYKjHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53687618"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53687618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:17:27 -0700
X-CSE-ConnectionGUID: 6KTi/Jl8Q6y3Jt0Mx72N4g==
X-CSE-MsgGUID: 9jtFDvdgQDKpCVzXBNhK9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="125725222"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 16:17:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Mar 2025 16:17:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 16:17:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 16:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m31utkRJoAX/sl+wAnUDEPO9L8nwr2g9+OEH3hQL9I5ISYBjGuHmheSAhX3cHtxzXPiXbNkuhFesBXNuCejzfV/8uoq5oBUiHnTI8oA+n6NVq1GY20OOaOkVZ8buuCPEyo/0bjXOAfAj3vZn9/SJ6XWRb1eJwK/r66P6QkMLhp1B26gxoNBAM8HvO5HbSATOwSxDaB7oWF9E9fQOoI8ZpO+q610NunkdL9AwBuwAce6W/I9jUAUgyZq2Z+caVFwfLWOZOnXnaeOIVX5KwQc9vfMibU9PrI3Jp6cW1XQDlBQyXCr60uJFeQ+yzjFgZ27nVqPr0Fq23nf+qgp4KoZiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DmEOQsk5A4KgDmZDVhTba6fi/r7BkAvRgb/dvRQ6PA=;
 b=T03U8mColHXjEL+Dr2G88+ynzkOyfc0avAWOqtJo84AGJrHZAvmGCrfyfEjtBjy6+TBx+/2vyUb51b+65wmvdQDBNfzZLOrwvJKCYnwPyaQD92uVm2HDeMe5AO2MAlvoUrlxONqW5jh2MU/+hGyQ5/R6Caq+cbN5WgQW3w+Xe6JWId1jwGrPZQnJqAGhktSQIfsBC5lbxsilEKKK0zR/JhVdTbvh5pFBo9+a4RybEMsi17i9sGfpdwQAgoFAm8XEbBr9hdWnFsMleY+/D/6eDWR2FQ1f5iLxky4up87qVh2Vuk6hgvhlWc5/3k2I1l998aFINtPHdszTUlVkMIMEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 23:17:23 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 23:17:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"david.kaplan@amd.com" <david.kaplan@amd.com>, "x86@kernel.org"
	<x86@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in relocate_kernel()
Thread-Topic: [RFC PATCH 2/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in relocate_kernel()
Thread-Index: AQHbk0LH0f/Ie6UWpUSQoMR8xfb+F7NxtZyA
Date: Thu, 13 Mar 2025 23:17:23 +0000
Message-ID: <1050a84caa9036e3ddb580fb510e634a216e692c.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <ebe4c0e8fe1b78c014bbc18832ae0eec8fef419d.1741778537.git.kai.huang@intel.com>
In-Reply-To: <ebe4c0e8fe1b78c014bbc18832ae0eec8fef419d.1741778537.git.kai.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6804:EE_
x-ms-office365-filtering-correlation-id: 8dfd6462-4903-4d75-12b7-08dd62853639
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y2ZWSkhIN09LUWs2NEJwd0wyN1lYbGpJY2VlY0hEb0dWbXc4eHhIUTFKeE5O?=
 =?utf-8?B?ellNM0hUMkROaG5GaTdtYllpS0Z2Rm5HdUh3L1R1K05BUEoxSG5CdmRjM3RL?=
 =?utf-8?B?by9SN041ZUx0YXdvQWNKQmpUdGNhRHlmRmhlN1Y0NXBqSnZvUk0zaGxIQmdl?=
 =?utf-8?B?R1E3NUdINEZPajI5TzRaLzVyT3BsdDZBZzZXQ3E3Z2dhdnZIYzZTbnNXdnJr?=
 =?utf-8?B?VjhzSFZZUlViblFCZHA2Z25PTkhLM1dHNlFxN2UxbHJyZXhidWUySGRzaUUr?=
 =?utf-8?B?VStickZBS1RQMVVtUUJkNzByWnZlbGxZWC82bU9UTi9haDZnNzRpU21YbUx3?=
 =?utf-8?B?bXRoUU5UOFZLS1JuOWFHeTRkbUNPTDN4R0Znb0dacTN0RFFZcnpNS1NXSWhy?=
 =?utf-8?B?SDFnU2l2ZHJ5MTdFK2p2WW8rbWZVR0VIbHlnbFNMU3AzcEVZelF4VlZBMUlQ?=
 =?utf-8?B?Y29tNE9JL3IyM283dk1rL3dZYTBza0E1bTFIOUhsRjRaWEY5NlZENjZIZ0Fx?=
 =?utf-8?B?Znh4NTVsWXMvRGMxOFUzNFJNNEI4dHF5K1AzczZTaWUxMU8xdVhDVEJZL3B1?=
 =?utf-8?B?d05tWlRMU0l6QUpDakxTWW9FdlZ0VjVyOXhxRS9Bd1R2UHFqNmhPWWo3a3JY?=
 =?utf-8?B?K0hmdUprYlVCSEJQRVFUWG10ekZhUXNaNGRIK3V3SlhIREJWQWhnUzNONGtU?=
 =?utf-8?B?NmJjQUM4QnVxNThodnk4R1ZwcFgwUDh2Q0xkMktTN0FoaTBncVpUYTJvYS9i?=
 =?utf-8?B?VFJsSnlUVEQvOE1vNGNHOGdKNkdTQmVWYkpNd0Rib282UVhpUm8xLytwMnhP?=
 =?utf-8?B?N2ZiNndrQ3NsUE1Wd2xwSzQrYXVQNTRBSnVxNDNQNitpb2haT2tVV0hJTVF4?=
 =?utf-8?B?L1BmOVZXd3pDUklBWjZwVXg4YmJKRHNsbHpNYzlXS3FaS1pHdmNPSlhMSTJX?=
 =?utf-8?B?dU9hZWo3RWx1Q3hObmVpWDlramJicjFWczk1Z2hzRXZlK0kzb0ZNMzB6RWlW?=
 =?utf-8?B?NG1vTE96bkVCc0pPNmg0TFRhK3ZJU0FCWjhjT2dpRVdmMWI0VXQ2ay9DeFBy?=
 =?utf-8?B?enRtbHV2TnRCWTdPU3lRRzJLOTZtQkJBTm9vL1ljTkEvYlNPdmJ6SHQ3SzdN?=
 =?utf-8?B?Yk9aa2Q3b2l6anpRQ0Y4QXhlcVd3RE9HYmdsak90UU5JUUFNKzZxckN5ZmFB?=
 =?utf-8?B?RXQzQWg3VVN1SXl2WVNqeWVoaTNQSFptZTE1dVRJSmFkazlGQmx4dlk4akho?=
 =?utf-8?B?ajNYdVh1U3RrY0FUaitMUklhcDBFSGdGS2s3QjVncE93dWlCTjZ6dDlDbUpT?=
 =?utf-8?B?OURlVncyV2JOQWl5Uk01ck5nVTMxYTdqSDhBK0JtUi82aTlmWHV2NXpsdFVh?=
 =?utf-8?B?QldhdUFKRWVONmtkMWZqdGdod09vV3dtcFE1UHN2MHFLT0dFQTBFK1RKdk9l?=
 =?utf-8?B?VnVFZHM2R1BqUUN2R1hYY0l3azZaTTVsZVkxZXlOL0RPckJYUXR2bXYxbk9R?=
 =?utf-8?B?REtmb250NHFyaVE2RHN2QTdzSk8vOXpjZk1la2ttV3QzMzZiSnU3Y3hyN0w2?=
 =?utf-8?B?bFNNZTV3QjF5YkRGd0lxNjkrY1FvRUdpb3VSNzNUTHN6S0JEM0k5KzhIVWdw?=
 =?utf-8?B?S1JXMTk2dzM3UUZ2dDhmY29DM29iODltR0Joako1MDVVWEk5cTNXUXA4dHlk?=
 =?utf-8?B?RW45V1lWMkU0aDl6bzYvbGpaRDNlZ2tkcUdVZytCd2dmandIWDZKUU5qTy9D?=
 =?utf-8?B?Ym9rSE80ZTl1eWpUY3VmbUVxUFRPMW5TejB0engzNUlnbGNuVkw0YzRWREZa?=
 =?utf-8?B?OWtGQTRSWS9yYzVubEc3Q1I4NmU1aHZUcE9tVFp3eHNWZFFHQUNvcUpPalox?=
 =?utf-8?B?anZBTmJRbWVLOEI1Y1U2alNIY1RIUktuWmRnKzJpcTNjMkV1aWR6NVdjajkr?=
 =?utf-8?Q?4gCUVaHCrBRJUjfEp6zol6ybyYZX/owC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmpERkpGRWFOejc2N3BhUE5BK1dDV1VSeU1LSXo2eXNFaUYzTkY4WDJ1T2NC?=
 =?utf-8?B?K0xjdmt6OVBPREdEUGdMamlPK2xnK1pyZUkwOW9DWklWbDlHVmdEOWtCZHVi?=
 =?utf-8?B?NmFTVEtwcmNCL3d5UXdxYmYrQ2Vvc1pEUGtPYk0rZWdIemplS3NSU2lOa0x1?=
 =?utf-8?B?SmpjaFFkQ3hzV3hscVlsRURXMWR5RWs5dTBrcmd2V2JDcHhSdGJsQVY3dGpi?=
 =?utf-8?B?WW1wQ280d2xkY0JnaHd2WHpMOVRuMGlBOXlSTWdsTVV2Tm9uaS9vUmpGUnFZ?=
 =?utf-8?B?ejFkY2FqVkxidU9ETjZtTGtYOTRneE05WmFUaVlCMjUwMzV3V1E3MGlqNDFD?=
 =?utf-8?B?aUhadXd6cmZrSDFiSDVNOWlkVDlUdDNQd3I1V0VXRlQrcGlHWmZ5Y3ZsTmdp?=
 =?utf-8?B?TWpsa2xVb0h5WEpDbTZFbW1qT0JBV3Yyd2lndGRyYVc4UGFFenFNbERMbGtN?=
 =?utf-8?B?MG5LNUlwaTdZOUxRUEZYdmRKVEEwOW95aXQyMlRrcE5jRWNGbDl1bFZnMGds?=
 =?utf-8?B?WktjRFN3TktGZGhNL3R5aENnbGZUcUtoZkRHWTd0U2JvaFpVN3pRcXUwbW0y?=
 =?utf-8?B?Qk1sbU5nemFZUmp4NGJNbC8xenY5V1pQa1hyOVJRZ3YwL3ZiZWF2K1JPQThu?=
 =?utf-8?B?UzlKYkhBb0E2Y1NhUllkMUZheDczN2lnVHJOT0F3NXFuY2E1eWpCVE95dkEw?=
 =?utf-8?B?ZWRoVGhpSWNzUEtOeFRVQjB4ZUhJQVFsLzBLaGw0VWs0dlVoc01TM0NhNkVN?=
 =?utf-8?B?UnBBWmZnUUZhV2VaRlhnQTNlUmIyR0JlLzNmOUY0ZDJRb2w2WjJ5TUpSK3ZH?=
 =?utf-8?B?Y0w1Z21hM25ZZzd3SDJ4SGd1cHRQTjlTYUVuZThIZnBySk1vWENkMjBONi9O?=
 =?utf-8?B?cnBFaTkwYUVNdlI2Y0VOZTlvVDhlc0NraXZ3eTVCbjJkVC9BSU8yZWZ0b0pp?=
 =?utf-8?B?cU9wM1hYeUpvYUFwajNTSUJ5T3dWNllIK253MW5xNGgwVVNLUCt0alZaYVBl?=
 =?utf-8?B?clBDQmdKOWlrakI0d2FMdlFDVTZtYXVOVnI1eDdoSGlibDZwdWVlNTJNYVVD?=
 =?utf-8?B?YkVmOFR2WGlTbStRMHJhM1dQQmgzWmJWbktYQmprNFJlblJ6SjBxSis0bmIv?=
 =?utf-8?B?aU8zekIvUDlSZTlaUExXbzd2NmE1Rng4ck1rNkZRQk5OZkNzRENac1RrRFQ1?=
 =?utf-8?B?U0MzU3ZiZm5ZaklzM09qTUJmOU55dWsvektrSjhucjRRWlhyYVk4My9nVDkx?=
 =?utf-8?B?aFhJZjRDMGtSTTdvdm84ME5SVk95ODFVdUE1RFlTVk5oV0k0Z0hBMHRhcnox?=
 =?utf-8?B?cnU0RmNNSTBLaGViNTMxeGxDV0ZYOXJndHRIR1Z5bG91WHh3OXlpN2dhTDAw?=
 =?utf-8?B?YlBYeWIvTDNwTGtqb3BWd3RjVWRZcmNiU013UmFIaEVFNXNmajZHNTY0OTRt?=
 =?utf-8?B?Y0lIdWdJN215RktNa0pMd0xrckFzWGRuQlRKajFHZTdQNG1VRENveFoycEdT?=
 =?utf-8?B?SjFVMHJLRFRVZ1piQVA0TThGWXBTTUdqZ0srUDRDNnRRbEoxVE8xVVA4emFN?=
 =?utf-8?B?eSs0Y3dIQit3OGJoUno4MlBkZHhXK2pDSmkyZXlaeXUya1VsSkYrVGhBcWp6?=
 =?utf-8?B?K1VyTFhTKzlnWlFtcnpnTWs3WW1QZjFJM2gweUhaY3BxMGtpcjVJRCtvMEJp?=
 =?utf-8?B?TWtkV0dNejRRT283YzdvU2dXVWFqQzlJOXpSWERJdENuYkdLeld6dG9SZXNB?=
 =?utf-8?B?bjEvdFB6d1VFSGJnbTg3ZGcyRklIcVFZMjloYmViYUQ1N1lZZkZqVEEyR1pU?=
 =?utf-8?B?RGpiSVBSbUZTVHZ3VWJic21TWkkyWGh6Q1dlemFwMzFBZUpSL3h2TjBNd3Zp?=
 =?utf-8?B?YmRqYkZ6YWxteDJJR0R4emFFMFVXdVpZRlZFK0FvR0ZQdUNzUHg5NjdwZVA0?=
 =?utf-8?B?SHJOTjI0QmdIeXNvNVJVejdsOGJyc0FGbnZFVllURFluci9lTmt6a1VVSnlD?=
 =?utf-8?B?VEk2VGdTQUtHRVVNZTFkUEtTS2tlVUJ2bFhHK3BHOW1zUTZ2SkQza0dFbTJN?=
 =?utf-8?B?Z1RzY1F0dFJTVkx3eENNRjFtV3BmNTNaVnA3dllONTViTzVHQjZmQk1YMDE2?=
 =?utf-8?B?U3VCdVZiTkpUUnZhWWJqVzdlT0NaSFVEM2lvNDVBQ3pmZkdUWGhmS2tVQU5Y?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <690681890029384392DED9E6D51B40FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfd6462-4903-4d75-12b7-08dd62853639
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 23:17:23.5959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUZpy2YEStA1oh6my+6qfv6hOjzAUU2nAb8lq6hhyH9QwpXvdrGtZ68YNgBcyxhfmQAkPWhvDoP9iEvZe8v18dn0mtvup/bv9wWPmMIRM0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDAwOjM0ICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+IEZv
ciBib3RoIFNNRSBhbmQgVERYLCBkaXJ0eSBjYWNoZWxpbmVzIHdpdGggYW5kIHdpdGhvdXQgdGhl
IGVuY3J5cHRpb24NCj4gYml0KHMpIG9mIHRoZSBzYW1lIHBoeXNpY2FsIG1lbW9yeSBhZGRyZXNz
IGNhbiBjb2V4aXN0IGFuZCB0aGUgQ1BVIGNhbg0KPiBmbHVzaCB0aGVtIGJhY2sgdG8gbWVtb3J5
IGluIHJhbmRvbSBvcmRlci4NCj4gDQoNCkEgbG90IGdvaW5nIG9uIGluIHRoaXMgc2VudGVuY2Us
IGhvdyBhYm91dCBzaW1wbGlmeWluZyBpdDoNCg0KRm9yIFNNRSBhbmQgVERYLCBtdWx0aXBsZSBk
aXJ0eSBjYWNoZWxpbmVzIGZvciB0aGUgc2FtZSBtZW1vcnkgY2FuIGNvLWV4aXN0LCBhbmQNCnRo
ZSBDUFUgY2FuIGZsdXNoIHRoZW0gYmFjayB0byBtZW1vcnkgaW4gYSByYW5kb20gb3JkZXIuDQoN
Cg0KPiAgIER1cmluZyBrZXhlYywgdGhlIGNhY2hlcw0KPiBtdXN0IGJlIGZsdXNoZWQgYmVmb3Jl
IGp1bXBpbmcgdG8gdGhlIG5ldyBrZXJuZWwgdG8gYXZvaWQgc2lsZW50IG1lbW9yeQ0KPiBjb3Jy
dXB0aW9uIHRvIHRoZSBuZXcga2VybmVsLg0KDQpEdXJpbmcga2V4ZWMsIHRoZSBjYWNoZXMgbXVz
dCBiZSBmbHVzaGVkIGJlZm9yZSBqdW1waW5nIHRvIHRoZSBuZXcga2VybmVsIHRvDQphdm9pZCBz
aWxlbnQgbWVtb3J5IGNvcnJ1cHRpb24gd2hlbiBhIGNhY2hlbGluZSB3aXRoIGEgZGlmZmVyZW50
IGVuY3J5cHRpb24NCnByb3BlcnR5IGlzIHdyaXR0ZW4gYmFjayBvdmVyIHdoYXRldmVyIGVuY3J5
cHRpb24gcHJvcGVydGllcyB0aGUgbmV3IGtlcm5lbCBpcw0KdXNpbmcuDQoNCi4uLml0IGRpc3Ry
aWJ1dGVzIHNvbWUgb2YgdGhlIGRldGFpbHMgZnJvbSB0aGUgZmlyc3Qgc2VudGVuY2UgaW50byB0
aGUgc2Vjb25kLg0KRWFzaWVyIHRvIHJlYWQgb3Igbm8/IEknbSBub3Qgc3VyZS4NCg0KPiANCj4g
VGhlIFdCSU5WRCBpbiBzdG9wX3RoaXNfY3B1KCkgZmx1c2hlcyBjYWNoZXMgZm9yIGFsbCByZW1v
dGUgQ1BVcyB3aGVuDQo+IHRoZXkgYXJlIGJlaW5nIHN0b3BwZWQuICBGb3IgU01FLCB0aGUgV0JJ
TlZEIGluIHJlbG9jYXRlX2tlcm5lbCgpDQo+IGZsdXNoZXMgdGhlIGNhY2hlIGZvciB0aGUgbGFz
dCBydW5uaW5nIENQVSAod2hpY2ggaXMgZG9pbmcga2V4ZWMpLg0KPiANCj4gU2ltaWxhcmx5LCB0
byBzdXBwb3J0IGtleGVjIGZvciBURFggaG9zdCwgYWZ0ZXIgc3RvcHBpbmcgYWxsIHJlbW90ZSBD
UFVzDQo+IHdpdGggY2FjaGUgZmx1c2hlZCwgdGhlIGtlcm5lbCBuZWVkcyB0byBmbHVzaCBjYWNo
ZSBmb3IgdGhlIGxhc3QgcnVubmluZw0KPiBDUFUuDQoNCg0KSSBtZW50aW9uZWQgdGhpcyBpbiBh
IHByZXZpb3VzIHZlcnNpb24uIEkgdGhpbmsgeW91IG5lZWQgdG8gZ2l2ZSBzb21lIGhpbnQgdG8N
CndoZXJlIHlvdSBhcmUgZ29pbmcgYmVmb3JlIHlvdSBzdGFydCBsaXN0aW5nIGZhY3RzLiBMaWtl
Og0KDQpEdXJpbmcga2V4ZWMsIFdCSU5WRCBuZWVkcyB0byBiZSBleGVjdXRlZCBvbiBlYWNoIENQ
VSBmb3IgVERYIGFuZCBTTUUuIE9uIHRoZQ0KcmVtb3RlIENQVXMgdGhpcyBpcyBjb3ZlcmVkIGlu
IHN0b3BfdGhpc19jcHUoKSBmb3IgYm90aCBURFggYW5kIFNNRS4gRm9yIHRoZQ0Ka2V4ZWNpbmcg
Q1BVLCBTTUUgaGFuZGxlcyB0aGlzIGluIHJlbG9jYXRlX2tlcm5lbCgpLiBUaGlzIGxlYXZlcyB0
aGUgVERYIGNhc2UNCmZvciB0aGUga2V4ZWMtaW5nIENQVSBzdGlsbCB0byBpbXBsZW1lbnQuDQoN
Ci4uLml0IGZpcnN0IHNheXMgdGhlIG92ZXJhbGwgcHJvYmxlbSB0byBzb2x2ZSwgdGhlbiBleHBs
YWlucyB3aGF0IGlzIG1pc3NpbmcgaW4NCnRoZSBjdXJyZW50IGNvZGUgdG8gc29sdmUgaXQuIFRo
ZSByZWFkZXIgaXMgYWxyZWFkeSB0aGlua2luZyBvZiB3aGF0IHRoZQ0Kc29sdXRpb25zIHNob3Vs
ZCBiZSBhbmQuLi4NCg0KPiANCj4gVXNlIHRoZSBleGlzdGluZyBXQklOVkQgaW4gcmVsb2NhdGVf
a2VybmVsKCkgdG8gY292ZXIgVERYIGhvc3QgYXMgd2VsbC4NCg0KLi4udGhleSByZWFkIHRoZSBz
b2x1dGlvbiBqdXN0IGFzIHRoZXkgYXJlIHdvbmRlcmluZyBhYm91dCBpdC4gVGhlIHJlYWRlciBj
YW4NCmZlZWwgbGlrZSB0aGUgY2hhbmdlIGlzIGFsaWduZWQgd2l0aCB0aGVpciB0aGlua2luZy4N
Cg0KPiANCj4gSnVzdCBkbyB1bmNvbmRpdGlvbmFsDQo+IA0KDQoiVW5jb25kaXRpb25hbCIuIE5v
dyBJJ20gc3RhcnRpbmcgdG8gdGhpbmsgYWJvdXQgaG93IHVuY29uZGl0aW9uYWwgd2JpbnZkIHdp
bGwNCmJlLg0KDQo+ICBXQklOVkQgdG8gY292ZXIgYm90aCBTTUUgYW5kIFREWCBpbnN0ZWFkIG9m
DQo+IHNwcmlua2xpbmcgYWRkaXRpb25hbCB2ZW5kb3Itc3BlY2lmaWMgY2hlY2tzLiAgS2V4ZWMg
aXMgYSBzbG93IHBhdGgsIGFuZA0KPiB0aGUgYWRkaXRpb25hbCBXQklOVkQgaXMgYWNjZXB0YWJs
ZSBmb3IgdGhlIHNha2Ugb2Ygc2ltcGxpY2l0eSBhbmQNCj4gbWFpbnRhaW5hYmlsaXR5Lg0KPiAN
Cj4gQnV0IG9ubHkgZG8gV0JJTlZEIGZvciBiYXJlLW1ldGFsDQo+IA0KDQpCdXQgd2FpdCwgbm93
IEknbSBsZWFybmluZyBpdCdzIG5vdCB1bmNvbmRpdGlvbmFsLiBJIG5lZWQgdG8gcmUtdGhpbmsg
d2hhdCBJDQpqdXN0IGV2YWx1YXRlZC4gQW5kIEknbSBkb3VidGluZyB0aGUgZWFybGllciBzdGF0
ZW1lbnRzIGJlY2F1c2UgSSBqdXN0IGdvdA0Kc3VycHJpc2VkLg0KDQo+ICBiZWNhdXNlIFREWCBn
dWVzdHMgYW5kIFNFVi1FUy9TRVYtU05QDQo+IGd1ZXN0cyB3aWxsIGdldCB1bmV4cGVjdGVkIChh
bmQgeWV0IHVubmVjZXNzYXJ5KSBleGNlcHRpb24gKCNWRSBvciAjVkMpDQo+IHdoaWNoIHRoZSBr
ZXJuZWwgaXMgdW5hYmxlIHRvIGhhbmRsZSBhdCB0aGUgdGltZSBvZiByZWxvY2F0ZV9rZXJuZWwo
KQ0KPiBzaW5jZSB0aGUga2VybmVsIGhhcyB0b3JuIGRvd24gdGhlIElEVC4NCj4gDQo+IFJlbW92
ZSB0aGUgaG9zdF9tZW1fZW5jX2FjdGl2ZSBsb2NhbCB2YXJpYWJsZSBhbmQgZGlyZWN0bHkgdXNl
DQo+ICFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpIGFzIGFuIGFy
Z3VtZW50IG9mIGNhbGxpbmcNCj4gcmVsb2NhdGVfa2VybmVsKCkuDQo+IA0KDQpTdGFydCB3aXRo
IHRoZSBwcm9ibGVtIGhlcmUuIEl0IGp1c3QgZGVzY3JpYmVzIGFub3RoZXIgY2hhbmdlIGFuZCBJ
J20gbm90IHN1cmUNCndoeSB3aGVuIEkgc3RhcnQgcmVhZGluZyBpdC4NCg0KQnkgcHJvYmxlbSBJ
IG1lYW4gdGhhdCBob3N0X21lbV9lbmNfYWN0aXZlIGRvZXNuJ3QgZml0IHRoZSBjb25kaXRpb25h
bCBhbnltb3JlLA0Kc28gaXQgbmVlZHMgdG8gYmUgY2hhbmdlZC4NCg0KPiAgIGNwdV9mZWF0dXJl
X2VuYWJsZWQoKSBpcyBhbHdheXMgaW5saW5lIGJ1dCBub3QgYQ0KDQpJIHdhcyBqdXN0IG5vdGlj
aW5nIHRoaXMgb24gdGhlIG90aGVyIHBhdGNoLiBBY3R1YWxseSBpdCBjb3VsZCBjYWxsIGludG8g
c29tZQ0Ka2FzYW4gc3R1ZmYuDQoNCj4gZnVuY3Rpb24gY2FsbCwgdGh1cyBpdCBpcyBzYWZlIHRv
IHVzZSBhZnRlciBsb2FkX3NlZ21lbnRzKCkgd2hlbiBjYWxsDQo+IGRlcHRoIHRyYWNraW5nIGlz
IGVuYWJsZWQuDQoNClRoaXMgZnVuY3Rpb24gY2FsbCB0cmFja2luZyBzdHVmZiBpcyBhIHdpbGQg
Y2FyZCBhdCB0aGUgZW5kLiBXaGF0IGFib3V0DQpkZXNjcmliaW5nIHRoZSBydWxlcyB0aGlzIGZ1
bmN0aW9uIG5lZWRzIHRvIGZvbGxvdyBkdWUgdG8gY2FsbCBkZXB0aCB0cmFja2luZywNCmFuZCBl
eHBsYWluIHdoeSB0aGUgY2hhbmdlIGRvZXMgdGhhdC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBDYzogVG9tIExl
bmRhY2t5IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gQ2M6IERhdmUgWW91bmcgPGR5b3Vu
Z0ByZWRoYXQuY29tPg0KPiBDYzogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBsYW5AYW1kLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+
IFRlc3RlZC1ieTogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBsYW5AYW1kLmNvbT4NCj4gLS0tDQo+
ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oICAgICAgICAgfCAgMiArLQ0KPiAgYXJjaC94
ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyAgIHwgMTQgKysrKysrLS0tLS0tLS0NCj4gIGFy
Y2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUyB8IDE1ICsrKysrKysrKystLS0tLQ0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oIGIvYXJjaC94ODYv
aW5jbHVkZS9hc20va2V4ZWMuaA0KPiBpbmRleCA4YWQxODc0NjJiNjguLjQ4YzMxMzU3NTI2MiAx
MDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va2V4ZWMuaA0KPiArKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy5oDQo+IEBAIC0xMjMsNyArMTIzLDcgQEAgcmVsb2NhdGVf
a2VybmVsX2ZuKHVuc2lnbmVkIGxvbmcgaW5kaXJlY3Rpb25fcGFnZSwNCj4gIAkJICAgdW5zaWdu
ZWQgbG9uZyBwYV9jb250cm9sX3BhZ2UsDQo+ICAJCSAgIHVuc2lnbmVkIGxvbmcgc3RhcnRfYWRk
cmVzcywNCj4gIAkJICAgdW5zaWduZWQgaW50IHByZXNlcnZlX2NvbnRleHQsDQo+IC0JCSAgIHVu
c2lnbmVkIGludCBob3N0X21lbV9lbmNfYWN0aXZlKTsNCj4gKwkJICAgdW5zaWduZWQgaW50IGJh
cmVfbWV0YWwpOw0KPiAgI2VuZGlmDQo+ICBleHRlcm4gcmVsb2NhdGVfa2VybmVsX2ZuIHJlbG9j
YXRlX2tlcm5lbDsNCj4gICNkZWZpbmUgQVJDSF9IQVNfS0lNQUdFX0FSQ0gNCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMgYi9hcmNoL3g4Ni9rZXJuZWwv
bWFjaGluZV9rZXhlY182NC5jDQo+IGluZGV4IGE2OGY1YTBhOWYzNy4uMGU5ODA4ZWViNjNlIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jDQo+ICsrKyBi
L2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gQEAgLTM0NiwxNiArMzQ2LDkg
QEAgdm9pZCBfX25vY2ZpIG1hY2hpbmVfa2V4ZWMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpDQo+ICB7
DQo+ICAJdW5zaWduZWQgbG9uZyByZWxvY19zdGFydCA9ICh1bnNpZ25lZCBsb25nKV9fcmVsb2Nh
dGVfa2VybmVsX3N0YXJ0Ow0KPiAgCXJlbG9jYXRlX2tlcm5lbF9mbiAqcmVsb2NhdGVfa2VybmVs
X3B0cjsNCj4gLQl1bnNpZ25lZCBpbnQgaG9zdF9tZW1fZW5jX2FjdGl2ZTsNCj4gIAlpbnQgc2F2
ZV9mdHJhY2VfZW5hYmxlZDsNCj4gIAl2b2lkICpjb250cm9sX3BhZ2U7DQo+ICANCj4gLQkvKg0K
PiAtCSAqIFRoaXMgbXVzdCBiZSBkb25lIGJlZm9yZSBsb2FkX3NlZ21lbnRzKCkgc2luY2UgaWYg
Y2FsbCBkZXB0aCB0cmFja2luZw0KPiAtCSAqIGlzIHVzZWQgdGhlbiBHUyBtdXN0IGJlIHZhbGlk
IHRvIG1ha2UgYW55IGZ1bmN0aW9uIGNhbGxzLg0KPiAtCSAqLw0KPiAtCWhvc3RfbWVtX2VuY19h
Y3RpdmUgPSBjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9IT1NUX01FTV9FTkNSWVBUKTsNCj4gLQ0K
PiAgI2lmZGVmIENPTkZJR19LRVhFQ19KVU1QDQo+ICAJaWYgKGltYWdlLT5wcmVzZXJ2ZV9jb250
ZXh0KQ0KPiAgCQlzYXZlX3Byb2Nlc3Nvcl9zdGF0ZSgpOw0KPiBAQCAtMzk4LDYgKzM5MSwxMSBA
QCB2b2lkIF9fbm9jZmkgbWFjaGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdlICppbWFnZSkNCj4gIAkg
Kg0KPiAgCSAqIEkgdGFrZSBhZHZhbnRhZ2Ugb2YgdGhpcyBoZXJlIGJ5IGZvcmNlIGxvYWRpbmcg
dGhlDQo+ICAJICogc2VnbWVudHMsIGJlZm9yZSBJIHphcCB0aGUgZ2R0IHdpdGggYW4gaW52YWxp
ZCB2YWx1ZS4NCj4gKwkgKg0KPiArCSAqIGxvYWRfc2VnbWVudHMoKSByZXNldHMgR1MgdG8gMC4g
IERvbid0IG1ha2UgYW55IGZ1bmN0aW9uIGNhbGwNCj4gKwkgKiBhZnRlciBoZXJlIHNpbmNlIGNh
bGwgZGVwdGggdHJhY2tpbmcgdXNlcyBwZXItQ1BVIHZhcmlhYmxlcyB0bw0KPiArCSAqIG9wZXJh
dGUgKHJlbG9jYXRlX2tlcm5lbCgpIGlzIGV4cGxpY2l0bHkgaWdub3JlZCBieSBjYWxsIGRlcHRo
DQo+ICsJICogdHJhY2tpbmcpLg0KDQpJIHRoaW5rIEkgc3VnZ2VzdGVkIHlvdSBzaG91bGQgY2Fs
bCBvdXQgdGhlIG9wcG9ydHVuaXN0aWMgY2hhbmdlIGhlcmUgaW4gdGhlDQpsb2cuIERpZCB5b3Ug
ZGlzYWdyZWU/DQoNCj4gIAkgKi8NCj4gIAlsb2FkX3NlZ21lbnRzKCk7DQo+ICAJLyoNCj4gQEAg
LTQxMiw3ICs0MTAsNyBAQCB2b2lkIF9fbm9jZmkgbWFjaGluZV9rZXhlYyhzdHJ1Y3Qga2ltYWdl
ICppbWFnZSkNCj4gIAkJCQkJICAgdmlydF90b19waHlzKGNvbnRyb2xfcGFnZSksDQo+ICAJCQkJ
CSAgIGltYWdlLT5zdGFydCwNCj4gIAkJCQkJICAgaW1hZ2UtPnByZXNlcnZlX2NvbnRleHQsDQo+
IC0JCQkJCSAgIGhvc3RfbWVtX2VuY19hY3RpdmUpOw0KPiArCQkJCQkgICAhY3B1X2ZlYXR1cmVf
ZW5hYmxlZChYODZfRkVBVFVSRV9IWVBFUlZJU09SKSk7DQo+ICANCj4gICNpZmRlZiBDT05GSUdf
S0VYRUNfSlVNUA0KPiAgCWlmIChpbWFnZS0+cHJlc2VydmVfY29udGV4dCkNCj4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUyBiL2FyY2gveDg2L2tlcm5l
bC9yZWxvY2F0ZV9rZXJuZWxfNjQuUw0KPiBpbmRleCBiNDRkODg2M2U1N2YuLmRjMWE1OWNkODEz
OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+
ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUw0KPiBAQCAtNTAsNyAr
NTAsNyBAQCBTWU1fQ09ERV9TVEFSVF9OT0FMSUdOKHJlbG9jYXRlX2tlcm5lbCkNCj4gIAkgKiAl
cnNpIHBhX2NvbnRyb2xfcGFnZQ0KPiAgCSAqICVyZHggc3RhcnQgYWRkcmVzcw0KPiAgCSAqICVy
Y3ggcHJlc2VydmVfY29udGV4dA0KPiAtCSAqICVyOCAgaG9zdF9tZW1fZW5jX2FjdGl2ZQ0KPiAr
CSAqICVyOCAgYmFyZV9tZXRhbA0KPiAgCSAqLw0KPiAgDQo+ICAJLyogU2F2ZSB0aGUgQ1BVIGNv
bnRleHQsIHVzZWQgZm9yIGp1bXBpbmcgYmFjayAqLw0KPiBAQCAtMTA3LDcgKzEwNyw3IEBAIFNZ
TV9DT0RFX1NUQVJUX0xPQ0FMX05PQUxJR04oaWRlbnRpdHlfbWFwcGVkKQ0KPiAgCS8qDQo+ICAJ
ICogJXJkaQlpbmRpcmVjdGlvbiBwYWdlDQo+ICAJICogJXJkeCBzdGFydCBhZGRyZXNzDQo+IC0J
ICogJXI4IGhvc3RfbWVtX2VuY19hY3RpdmUNCj4gKwkgKiAlcjggYmFyZV9tZXRhbA0KPiAgCSAq
ICVyOSBwYWdlIHRhYmxlIHBhZ2UNCj4gIAkgKiAlcjExIHByZXNlcnZlX2NvbnRleHQNCj4gIAkg
KiAlcjEzIG9yaWdpbmFsIENSNCB3aGVuIHJlbG9jYXRlX2tlcm5lbCgpIHdhcyBpbnZva2VkDQo+
IEBAIC0xNTYsMTQgKzE1NiwxOSBAQCBTWU1fQ09ERV9TVEFSVF9MT0NBTF9OT0FMSUdOKGlkZW50
aXR5X21hcHBlZCkNCj4gIAltb3ZxCSVyOSwgJWNyMw0KPiAgDQo+ICAJLyoNCj4gLQkgKiBJZiBT
TUUgaXMgYWN0aXZlLCB0aGVyZSBjb3VsZCBiZSBvbGQgZW5jcnlwdGVkIGNhY2hlIGxpbmUNCj4g
KwkgKiBJZiBTTUUvVERYIGlzIGFjdGl2ZSwgdGhlcmUgY291bGQgYmUgb2xkIGVuY3J5cHRlZCBj
YWNoZSBsaW5lDQo+ICAJICogZW50cmllcyB0aGF0IHdpbGwgY29uZmxpY3Qgd2l0aCB0aGUgbm93
IHVuZW5jcnlwdGVkIG1lbW9yeQ0KPiAgCSAqIHVzZWQgYnkga2V4ZWMuIEZsdXNoIHRoZSBjYWNo
ZXMgYmVmb3JlIGNvcHlpbmcgdGhlIGtlcm5lbC4NCj4gKwkgKg0KPiArCSAqIERvIFdCSU5WRCBm
b3IgYmFyZS1tZXRhbCBvbmx5IHRvIGNvdmVyIGJvdGggU01FIGFuZCBURFguIERvaW5nDQo+ICsJ
ICogV0JJTlZEIGluIGd1ZXN0IHJlc3VsdHMgaW4gYW4gdW5leHBlY3RlZCBleGNlcHRpb24gKCNW
RSBvciAjVkMpDQo+ICsJICogZm9yIFREWCBhbmQgU0VWLUVTL1NOUCBndWVzdHMgd2hpY2ggdGhl
biBjcmFzaGVzIHRoZSBndWVzdCAodGhlDQo+ICsJICoga2VybmVsIGhhcyB0b3JuIGRvd24gdGhl
IElEVCkuDQo+ICAJICovDQo+ICAJdGVzdHEJJXI4LCAlcjgNCj4gLQlqeiAuTHNtZV9vZmYNCj4g
KwlqeiAuTG5vX3diaW52ZA0KPiAgCXdiaW52ZA0KPiAtLkxzbWVfb2ZmOg0KPiArLkxub193Ymlu
dmQ6DQo+ICANCj4gIAljYWxsCXN3YXBfcGFnZXMNCj4gIA0KDQo=

