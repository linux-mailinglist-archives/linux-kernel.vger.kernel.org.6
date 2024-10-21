Return-Path: <linux-kernel+bounces-374624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9E9A6DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5766D282139
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693221E906E;
	Mon, 21 Oct 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtqV1R0A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1C881E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523203; cv=fail; b=W8o52+vJGzAJekwZh3W5+bdngz4+jDcOpOo2aNaKhDaswzNJkTaiNJl2zCvUxmm+LxUORP/qXl1Z1ccLJg3wwGlSd6co86tPJUWPyV7uR/IaWpg15oOFTtW4bls4FwoU1qiiiYLOffi8gXczBGLI0rpSSxas+fgweUnG7Zx21Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523203; c=relaxed/simple;
	bh=DtKjx49ZHc3Ddbw37d+erJpp6MWjC3NtQzDVx3dNP4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUSlqQo6RHNeqwaaMn2Cv9+McDGL1jAC9D8QfYELjl5zntOE5YyDV356KHwAfo5JANaygHZrUNik1GLA/aoM6/UYJ9GZ/jNv5pFtHxB1EXyEa/viDT1YwPZOCPvsqDWtgerYGvuqFtf3x1hP8lxmptcDxdtsDMrcKhj2BdLa/YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtqV1R0A; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729523201; x=1761059201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DtKjx49ZHc3Ddbw37d+erJpp6MWjC3NtQzDVx3dNP4w=;
  b=CtqV1R0A0WLt/myxT9KHaWu9VDq/KNFqzVqilKe0IpYuho1kk5suIuU0
   LsfB64wtLhP6hohkAk9Y+ceYfFP8vGvwgHFUuDnzSVhbQbVmyZuqV0NSA
   UmQKfJypr6jWu85dlMiiyEQyZ6YLriDhugu9t7IuBhdf8poRnmLjmXCvq
   yjdKGawl8+jSoncTBDMTT5sULqyA20oWNfxy61NwkVu4XrpPN1egp3Q8a
   PV/VN2jFzCwG70ZqFP6WxBUWiagde6nNRcZ8kKLEHfoS90Xra4I1PzKgR
   oguQ5VpjpsDEjTOb0yxtCDCh9bg5z7CVOTZa8YyWG3IPhycIWHydN6V/b
   w==;
X-CSE-ConnectionGUID: O0z/U4r2SLKBtyxgg/nKfA==
X-CSE-MsgGUID: sP2QetyrSOOWrXtdqT3cOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40381338"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="40381338"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 08:06:40 -0700
X-CSE-ConnectionGUID: Nq1miog+RMuK5BA1H6DuAQ==
X-CSE-MsgGUID: p3bbt/ylSV2U7HAmtODZ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79498518"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 08:06:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 08:06:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 08:06:39 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 08:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QowK6EwDQfY2xa8wXjuK4br2wkIVvDeV4CRCLHpQSHlIz8yjldo9fs46X2EPEKkNTvCihtC4JyLxv3U+N3gs5E19V2EwFJI8tu4V+RcTjgvsRF0mihYe2VtCcBxIi9mDZqt0xqiO/FEl3OiCRiUNPRzbCns5AogOhqjzVfl1xFD/SW/eGFWnl19qYXtemNXWjo4hDnlCBToaeTIctm9KAkDdQWdAg3DhR9VNqeNM7D6kUFpvsah9QWKtbdIRp1mBmMj/VYo/jrGct33twc6kqbC2k9XNvmm7ZqKXo808aBeqepSvkHYEzCD8XQ9ODmgx7hfyw9PV+kYqnDGtNb1Lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtKjx49ZHc3Ddbw37d+erJpp6MWjC3NtQzDVx3dNP4w=;
 b=VkpSM11wwcP0oHr5s2Zcn1efIdQgHeRrY7hkjUWwRRySaa2E3EpjSYRyB2sHa7MrrXMmyWBmyBfWj47owiFTgsMNydE3MlsfHOBfOS1ZDFfGL4190m1MvenNt/pNvGLvV2C+ELdVYLSChxwA7YYXo6Ds17oB1xsnKS7qTRIXqfUS06tnrwx9bxndOoTHyv8lBdBnp85ANp8ALmzI5rxCQoFNsUsxvRyMeW/PaN/TZ59ZnHtpJVUY8fwjLMzYNd4Gy7X/EagS5YVJ8xhm1V1G21b9qGfThZLaugeLw7v5iD0vfRcxS60syycGahevRHs8uphg+1NBK1xmZL+gIFcx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:06:31 +0000
Received: from PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac]) by PH7PR11MB7572.namprd11.prod.outlook.com
 ([fe80::16f9:b81c:54a0:76ac%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 15:06:31 +0000
From: "Constable, Scott D" <scott.d.constable@intel.com>
To: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Milburn,
 Alyssa" <alyssa.milburn@intel.com>, "joao@overdrivepizza.com"
	<joao@overdrivepizza.com>, "jose.marchesi@oracle.com"
	<jose.marchesi@oracle.com>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>
Subject: RE: [PATCH 13/14] x86: BHI stubs
Thread-Topic: [PATCH 13/14] x86: BHI stubs
Thread-Index: AQHbERapFNubaMHC4ke6cJuSW9kYg7Jw3cUAgAAO2ACAAAQ9AIAAz/kAgAAEtgCAAzTDgIAAHF6AgBGB80CAAExdgIAEZdeQ
Date: Mon, 21 Oct 2024 15:06:31 +0000
Message-ID: <PH7PR11MB7572107D7831693B9191B998BB432@PH7PR11MB7572.namprd11.prod.outlook.com>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble>
 <20241001110310.GM5594@noisy.programming.kicks-ass.net>
 <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com>
 <20241003121739.GB17263@noisy.programming.kicks-ass.net>
 <630467e0-6cd4-441d-a2cd-070a002c6f95@citrix.com>
 <PH7PR11MB757220761F23360280DF4A0DBB442@PH7PR11MB7572.namprd11.prod.outlook.com>
 <7e621780-3b19-4b60-b8a5-c0727c1eb5fd@citrix.com>
In-Reply-To: <7e621780-3b19-4b60-b8a5-c0727c1eb5fd@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7572:EE_|SA1PR11MB6823:EE_
x-ms-office365-filtering-correlation-id: 72c05e49-9077-4f2a-6e49-08dcf1e1f23a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmtGNUtzZVdLaVBxdjVxem0vSkgxWWd6NjFQVzFSdjdRZ3hZMjh6SFZ5VTVa?=
 =?utf-8?B?SXRFcFpPclVuamdCNmYzSVZLcEVEU0ovZjJxWmZHRW1mbW5EZnd6UmZIT2tS?=
 =?utf-8?B?bS9JOTRRV3pVY2VsbEpkeXRWYTkyYnpNL2hscFp2Z1NNZ040K0txdU1VSkZN?=
 =?utf-8?B?SVBhL2xUTmMyb2szd0J6ZlZSamQ4eXNKV3c4OVIxQkFsQ3V1VExpclNSakFO?=
 =?utf-8?B?NGlubEJjOVhIQ3dXL2hIYUJuUkh3dmRueXFYYWlvbUh6RW43VENzUElDWGFp?=
 =?utf-8?B?bkRScHpEQzEwZmFLaVFLV3YxQVNmNUJJYnE1cHE0UWNjWE4vUHhLLzFCWGtj?=
 =?utf-8?B?eDZIdC8wWlJFRVI0Z0U4UG5VK293K2UybGFxcGFWa3VIbHkyMm1YamU0ZDlP?=
 =?utf-8?B?WGgzWDJPT0NHUHRDaWd6d2tOR29UdmI0SmgvazRaM0VBSjZpTlM0S0doTkha?=
 =?utf-8?B?dzRSR1lDWTBSc3dRNWdRUElSTGU5Yi9WMEtkK0RFcUdlTFJubk9OYk5UL0tY?=
 =?utf-8?B?SUtJd0dHcjhycTFwK05yWGYvZk96aTlYcTRlMUhybDRCSEkyeGs4dHBON1pE?=
 =?utf-8?B?YTlreFdBaHZ0QzdMVGtCVkNFd0s2Ykw2N0ovc29VZmxxemlvUitTQWpBMU1q?=
 =?utf-8?B?bmFHVmRWY3BLTlZUT21MajVXODRVcmRXeUFTUExGR1d6cFdBcUwyeEJGV0s1?=
 =?utf-8?B?bm9QdWdaaURzeDdPV0pPcnBjckhsd1pNbWUzWmh3NnFuQlVWUmxFdVpCY3Jv?=
 =?utf-8?B?QXJqdFFkMnZ4RUtZQjJ5bm02YW45WTdEMnk0YVd1YmttOG93V3R1M2p5Rmcy?=
 =?utf-8?B?bzNaS3ZUdXVXU0RxL3ZLZ3NUZ2F6bEthNy9wb0lUVTgxL3JPZkdnbWUvVm1k?=
 =?utf-8?B?YlBaQjQyZ1F6b1A3RXZVT3RUY2RBVXlKLzNBWW5oWjBmVjdPRS9pVzM3MGRr?=
 =?utf-8?B?c0Q5S3pvenJjcmhONWNGTUs0dWRySCtXTVNJQ01GOWhBYWJhL2dRSWh2YSs2?=
 =?utf-8?B?T0NlNjNIZG5sYmh6citBazBxOVBMMmg5bEEvR0gyemg5U25Xa2lDYWxGeWFT?=
 =?utf-8?B?UEZaWWhLdFdjTTE1TmI1SnVlZUNRcmlsTDd3enowN2ttaFdZNzRORU03WUQ4?=
 =?utf-8?B?cEtXcE80Z2ZYOG5NNG54VzFXdTFuTWFXTEpCOHdXbnZFZlZDcktQdlRQQWs4?=
 =?utf-8?B?R3dlYjk1aEpkdjBGSEI3VWhQU2pLVzdYM0dkVGpKTXhXS0JZaUkvY3NYNkVS?=
 =?utf-8?B?aGt0ZWNxNUY5S1lURGFmbFNJSitxYWJTTzlmNlBvOWd3UUVYYUI0VXprcmNC?=
 =?utf-8?B?YmhLR3NRajRmcmxDZ2hsQzZuMzg1QXY3elJEcmFKT3hMWXgyRE9nVTNqdDhG?=
 =?utf-8?B?bGdRQUw4b3RmUm11b01XRFJROGNXdVFNb3QxZzVvWFJIOFpWYjFNcnNHSVRt?=
 =?utf-8?B?ZFdGQ0hBNjRQWklSUmREd2ZrbWY2aUI0anhTTms5YU9IS2I1VmRVbzZPdCtD?=
 =?utf-8?B?VDMzOElIVW5rOGVnZkVRMUZxR3lteDV3T21LZWU3L21paGo0ZGVRVmVML3Ez?=
 =?utf-8?B?SmEwbDl6SnlWa0FjVndpM0JrZVUyRUluVC9tMzQxb0o3WlI3bUh2aSt6L1V1?=
 =?utf-8?B?S1NpWTJJd2ZXU3BkdjhlNFVNc05hQVRDNHUzRFBodlZULy9ta1pOVTJ2TDdk?=
 =?utf-8?B?czd2OVFQT3owY0g0dzhNMnFFUUU3TG1kaUozYVhvMjZ5d21CYURIMkhUZFZX?=
 =?utf-8?B?SGtOZTRmc1luMGZ4RTJvWTRIRDN4SmZxMkRRSSthcTY3NDdLdFBoeFozcFZx?=
 =?utf-8?Q?9pzxWSZAl+ON4AX0VfMawaQ3AUf8mYwuCfIVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7572.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVZ3ZlhCODJ1NDhZbDgxNktlMTNDbXVia2dRK0dDMjlDNElaVUY0cHVXc3Jq?=
 =?utf-8?B?Mmt2ZHpCcWJEOC8raEppeC83WllqbVdkSytxQ1Y0eVlpc0pEUXZwY29iaGRw?=
 =?utf-8?B?TXdMU29PWndBMk0rRnJQN2EzOXJMUldTWXNWSXhUeE50djltbWg4MGVTNXA4?=
 =?utf-8?B?YjhIT2VuWno5aytHK1RzVGtSc29ISFQvb3BJcitwQkVWV3lnY3RtOXZmSEl4?=
 =?utf-8?B?dVlWTitzMDRkS3poR2lyb3lIZmR2clcwWmNGRVd0V24vdlE1eFh1UnZQcGJi?=
 =?utf-8?B?S0xOSE5rUGdLME1yUXdsUDNReDRyc3dobXdtOUY3NWNtWnJhL3VINlBhSFBI?=
 =?utf-8?B?Zld1d2hmU2U3SFA4K3U3ODBMZktQZDVsTGt6Vlk5U0ZKeUpqVnBPMFFDZTZw?=
 =?utf-8?B?Mm5JbmhmWHgrSjVaZjhtYjI2VVZESTgrbjg4YklPYm80TkgzNXlENFdIdlly?=
 =?utf-8?B?cndNQUtkS3BKUUZIeUU3Y20xR0ZVYVJOUFZHazhpNCtyRzVCdHU0TzlsRnNY?=
 =?utf-8?B?OWFPUnErMGs5L0FRa1NGWGlpSFJmTVJoN25vcFZQS0ZHMnJ3a2doVkxPd2lR?=
 =?utf-8?B?TFMvN1BnQWhZb3dtUDlMSkg1d1pkZkNjcXkwekVWbUFnR0ZiQ2tRd2FpOXd4?=
 =?utf-8?B?SGVERjlJZ3FFQk5vS3J0ZmIzc2p0a0hwYXp1UExIcGUzMEZtTHgyRkJQY2wx?=
 =?utf-8?B?YituS2dJWUUvZ1c1d1dtMGRRRk1ldmNXZW9icHVwRGErTU5DYzB4bmRtQStT?=
 =?utf-8?B?dWFxRFBNZlhIY2kvUXdYeDQrS043UWFiTkhnM2Rzc2JXRGtoMEVCWHE5ZGZP?=
 =?utf-8?B?V1JGQmJCSUl4Vzg1QmR0eUdNajBHUCs0NC81VFZQcGdhdldTWTkvU3RUMk9j?=
 =?utf-8?B?S3ZvUTFkMnMzdTVXN01heGRrK3Y2NVk5MlFGSy96dGREd1VQZHVaa2MvVUhV?=
 =?utf-8?B?NG5KOVMxM0hiSmYzR05Pb3hrdUV0dHYzNUE5UmhWZmVTcFpnUjRyTlZQMVVD?=
 =?utf-8?B?T0NZTy90NnVRTE9udkVCRTBwNjdPNlF2OCswMGNqMzcxU3lwWFNGSEZVSmZk?=
 =?utf-8?B?K0h6R1RiZUpTckJGcWtjRERaS0srOWM0ZVdySTZaRCtvY1h2NTA2WGJVb2s3?=
 =?utf-8?B?ODIya0t4cVlna1hnWEg4dmsxdGUwL2pvSXhFU05QWE5yMXdpQ2JHZFpEV21p?=
 =?utf-8?B?bkw2VDJRUlR3K2hBKzN6SE1CeWZkd2NORnJTR0c4VS9HSnlyQ3JUK3Jra1g0?=
 =?utf-8?B?QU82ZVQzNk5Jb2w3NDJCblVpaXQwU3FIYUptdEtycnUvRzhyNENGbStlc01m?=
 =?utf-8?B?cjF3bHNmd0UzdzFQZXVhYVJVKzkrMkgwMnI5clFpK1FFdUY4MjgwUXJtWVI0?=
 =?utf-8?B?eW4zTzdIUGQxZkU3RVFwdEFzM2NLODNlcGpUOWYvMjVpdXRoeVFyNzJsL3F5?=
 =?utf-8?B?aEp6K2grK2hYY004UG4xSmRmZ2lNdHBtQTFxc1VHZStkbjJ1VTRRSHlzcjhY?=
 =?utf-8?B?U3l5WGxPVGlJcWQzSERlZ0JxSVB1VkpYWG01T0doejFwdHRES1NoanE0dk9U?=
 =?utf-8?B?eTFZc2NWalByM2xYbDdBeHNJU0hqYndXeC9yaUtrcm14anVHVFNTZktiUFNu?=
 =?utf-8?B?N3J4RUxNUWdMS1ZGK1NrUGZIWmlQTHpPNFYvZ2xaU2FORmVsMWt3UHZYWTZG?=
 =?utf-8?B?T2VNUkxjUGJSbDU0ZVplbnlIMU5XaFNJdGJ6czBYL2pma0xzcnhTUUEreEZM?=
 =?utf-8?B?Y0liVStTZUNFM3VneFA2S0Q2cnZQMVIxTzlIYnFla0NEdFJwVmxVSDE5YlQ5?=
 =?utf-8?B?MEtKVmdZMmsrWmxnSzA5VjNzU3ZueVRmTkx5K1BkeDgwSmYyMjNDNEpyME5v?=
 =?utf-8?B?L2Uyc21FMUN5Mjd2SktWWnhJa01HNkhrVE5Ja08rTTJYNG1ISGZGMTVPQWFR?=
 =?utf-8?B?dTVsK0VoT1ZremlOSHd2STdGanZuZ0RxS05oNSt1M25jKzY4ZktIWmNYQ2Zk?=
 =?utf-8?B?NmQwcisvZWliQ2hTRjJYTUtLV04ycWdmcHFsa2JwT2FaR0dKWVpVOGhIa1RH?=
 =?utf-8?B?NlVlOTlydVZMYmNxS1haazB1VFE3OG91WUdxazZzcGtHSE5rWHI5V1hiTkNk?=
 =?utf-8?B?RUlvcTBYZUxOcmVVazBzN3NQS1lJNTZtQUxLV0JiUi95SmVEZzRhZ1FWZk9x?=
 =?utf-8?B?VEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c05e49-9077-4f2a-6e49-08dcf1e1f23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 15:06:31.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qAQwxzw8k2u8cM1kymQPiulWtmTMxWumjQm7MkEsBD21myhRDHaHQYVX+jSGTkk2OJPUoKglF9jVL92iCOpCPzptOahFzq68BWZs6F2+xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com

SGVsbG8gQW5kcmV3LA0KDQpNeSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBGaW5lSUJUIGFwcHJvYWNo
IGlzIHRoYXQgdGhlIGhhc2ggdmFsdWVzIGFyZSBub3QgaW50ZW5kZWQgdG8gYmUgc2VjcmV0LCBh
bmQgdGhlcmVmb3JlIGxlYWtpbmcgdGhlc2UgaGFzaCB2YWx1ZXMgd291bGQgbm90IGV4cG9zZSBh
IG5ldyByaXNrLiBKb2FvIGlzIGFsc28gb24gdGhpcyB0aHJlYWQgYW5kIGtub3dzIGEgbG90IG1v
cmUgYWJvdXQgRmluZUlCVCB0aGFuIEkgZG8sIHNvIGhlIGNhbiBjaGltZSBpbiBpZiBteSByZWFz
b25pbmcgaXMgdW5zb3VuZC4NCg0KT3VyIGludGVudCBpbiB1c2luZyB0aGUgaGFzaCBjaGVjayBy
ZXNpZHVhbCBhcyB0aGUgcG9pc29uIGlzIHRvIG92ZXJ3cml0ZSBhIHBvdGVudGlhbGx5IGF0dGFj
a2VyLWNvbnRyb2xsYWJsZSB2YWx1ZSB3aXRoIGEgZml4ZWQgdmFsdWUgdGhhdCB0aGUgYXR0YWNr
ZXIgY2Fubm90IGNvbnRyb2wuIEJ1dCB0aGUgcG9pbnRzIHlvdSByYWlzZSBoYXZlIG1hZGUgdXMg
cmV2aXNpdCB0aGlzIGFzc3VtcHRpb24uIFRoZSByZXNpZHVhbCBmcm9tIHRoZSBoYXNoIGNoZWNr
IGRvZXMgZ2l2ZSBhbiBhdHRhY2tlciBhIHNtYWxsIGRlZ3JlZSBvZiBjb250cm9sLCBiZWNhdXNl
IHRoZSBhdHRhY2tlciBtYXkgYmUgYWJsZSB0byB0cmlnZ2VyIGEgc3BlY3VsYXRpdmUgbWlzLXBy
ZWRpY3Rpb24gZnJvbSBzZXZlcmFsIGRpZmZlcmVudCBpbmRpcmVjdCBjYWxsIHNpdGVzIHRvIGEg
Z2l2ZW4gaW5kaXJlY3QgY2FsbCB0YXJnZXQuIElmIHRob3NlIGNhbGwgc2l0ZXMgaGF2ZSBkaWZm
ZXJlbnQgaGFzaCB2YWx1ZXMsIHRoZW4gdGhlIHJlc2lkdWFsIHdpbGwgZGlmZmVyIGFjY29yZGlu
Z2x5LiBCdXQgdGhpcyBkb2VzIG5vdCBhbW91bnQgdG8gYXJiaXRyYXJ5IGNvbnRyb2wgb3ZlciB0
aGUgcmVzaWR1YWwuIEZvciBleGFtcGxlLCBpZiB0aGUgYXR0YWNrZXIgd2FudHMgdG8gcG9pc29u
IHRoZSB0YXJnZXQncyByZWdpc3RlcnMgd2l0aCBhIHNwZWNpZmljIHZhbHVlIChlLmcuLCAweGRl
YWRiZWVmKSB0aGF0IHdpbGwgY2F1c2UgYW4gb3V0LW9mLWJvdW5kcyByZWFkIHRvIGEgZGVzaXJl
ZCBsb2NhdGlvbiBpbiBrZXJuZWwgbWVtb3J5IChlLmcuLCBmaXhlZF9hZGRyKzB4ZGVhZGJlZWYp
LCB0aGVuIHRoZSBhdHRhY2tlciB3aWxsIG5lZWQgdG8gaWRlbnRpZnkgYW4gaW5kaXJlY3QgY2Fs
bCBzaXRlIHdpdGggYSAzMi1iaXQgaGFzaCBIMSBzdWNoIHRoYXQgdGhlIHRhcmdldCdzIGhhc2gg
SDIgc2F0aXNmaWVzIEgxLUgyPTB4ZGVhZGJlZWYuIFRoaXMgc2NlbmFyaW8gZG9lcyBub3Qgc2Vl
bSB0byBiZSBtb3JlIGhhemFyZG91cyB0aGFuIG90aGVyIGV4aXN0aW5nIFNwZWN0cmUgdjEgZ2Fk
Z2V0cyB0aGF0IGxpa2VseSBleGlzdCB0aHJvdWdob3V0IHRoZSBrZXJuZWwsIHdoaWNoIG1heSBs
ZWFrIHNvbWUgZGF0YSBhdCBzb21lIHNwZWNpZmljIGFkZHJlc3NlcyBidXQgd2l0aG91dCBnaXZp
bmcgYW4gYXR0YWNrZXIgYXJiaXRyYXJ5IGNvbnRyb2wgdG8gbGVhayBnb2JzIG9mIGtlcm5lbCBt
ZW1vcnkuDQoNCldlIGRvIGFncmVlIHdpdGggeW91ciBzdWdnZXN0aW9uIHRoYXQgYWxsIG9mIHRo
ZSBhcmd1bWVudHMgc2hvdWxkIGJlIHBvaXNvbmVkLCBub3QganVzdCB0aGUgcG9pbnRlcnMuIEZv
ciBleGFtcGxlLCB0aGVyZSBtaWdodCBiZSBzb21lIGluZGlyZWN0IGNhbGwgdGFyZ2V0cyB0aGF0
IGxvb2sgbGlrZToNCg0Kdm9pZCBmb28odW5zaWduZWQgc2hvcnQgaSkgew0KICAgIHVuc2lnbmVk
IGxvbmcgeCA9IGZpeGVkX2FkZHJlc3NfdTY0X2FycmF5W2ldOw0KICAgIC8vIGNvZGUgdGhhdCBs
ZWFrcyB4DQp9DQoNCkluIGEgcHJldmlvdXMgZW1haWwgSSBoYWQgc3VnZ2VzdGVkIHRoYXQgaXQg
bWlnaHQgbm90IGJlIG5lY2Vzc2FyeSB0byBwb2lzb24gc29tZSBhcmd1bWVudHMsIGluY2x1ZGlu
ZyAxNi1iaXQgdmFsdWVzLiBUaGVuIGNvZGUgc3VjaCBhcyB0aGlzIChpZiBpdCBleGlzdHMpIGNv
dWxkIGV4cG9zZSB1cCB0byA1MTJLIG9mIGtlcm5lbCBtZW1vcnkgYWJvdmUgZml4ZWRfYWRkcmVz
c191NjRfYXJyYXkuIFNvIHlvdXIgY29uY2VybiBhYm91dCBwb2lzb25pbmcgYSBwcm9wZXIgc3Vi
c2V0IG9mIHRoZSBhcmd1bWVudHMgaXMgdmFsaWQsIGFuZCB3ZSBhcHByZWNpYXRlIHRoYXQgeW91
ciBzdWdnZXN0aW9uIHdvdWxkIGFsc28gc2ltcGxpZnkgdGhlIGltcGxlbWVudGF0aW9uIGJ5IHJl
cXVpcmluZyBmZXdlciBzdHVicy4NCg0KUmVnYXJkcywNCg0KU2NvdHQgQ29uc3RhYmxlDQoNCj4g
SGVsbG8sDQo+DQo+IFRoYW5reW91IGZvciB0aGUgYW5hbHlzaXMsIGFuZCBJJ20gZ2xhZCBJJ20g
bm90IGp1c3QgY2x1dGNoaW5nIGF0IHN0cmF3cy4NCj4NCj4gSG93ZXZlciwgSSdtIG5vdCBzdXJl
IGlmIGV4dGVuZGluZyB0aGlzIHRvIG90aGVyIGNhc2VzIHdvcmtzIHZlcnkgd2VsbC4gV2hpbGUg
dGhlIHNlY29uZCBwb2ludCBpcyBwcm9iYWJseSBlYXN5IGZvciB0aGUgY29tcGlsZXIgdG8gZmln
dXJlIG91dCwgdGhlIGZvcm1lciBpcyBsb29raW5nIGEgbGl0dGxlIGJpdCBtb3JlIGxpa2UgYSBo
YWx0aW5nIHByb2JsZW0uDQo+DQo+IE9uZSBrZXkgYXNwZWN0IGlzICJob3cgZmFyIGNhbiBzcGVj
dWxhdGlvbiBjb250aW51ZSBiZXlvbmQgYSBtaXNwcmVkaWN0ZWQgSmNjIiwgYnV0IGl0IG9jY3Vy
cyB0byBtZSBzaW5jZSB0aGUgbGFzdCBlbWFpbCB0aGF0IHRoZXJlIGlzIG5vIGFuc3dlciB0aGF0
IEludGVsIHdpbGwgZ2l2ZSBoZXJlLsKgIEl0IGlzIHVhcmNoIGRlcGVuZGVudCBhbmQgZXhwZWN0
ZWQgdG8gaW5jcmVhc2Ugb24gZnV0dXJlIHBhcnRzLCBzbyBzYWZldHkgd2lzZSB3ZSBtdXN0IGFz
c3VtZSBpbmZpbml0ZS4NCj4NCj4gQW5kIGluZmluaXRlIGlzIG5vIGdvb2QsIHNvIHdlIG11c3Qg
cmVhc29uIGFib3V0ICJnb29kIGVub3VnaCIuDQo+DQo+IE15IGd1dCBmZWVsaW5nIGlzIHRoYXQg
YmxpbmRseSB1c2luZyB0aGUgcmVzaWR1YWwgZnJvbSB0aGUgaGFzaCBjaGVjayBpc24ndCBnb29k
IGVub3VnaC7CoCA3IHllYXJzIG9mwqAgc3BlY3VsYXRpb24gZml4ZXMgaGF2ZSBzaG93biB0aGF0
IHRoZSByZXNlYXJjaGVycyBhcmUgY29uc3RhbnRseSBwcm92aW5nICJ0aGlzIHdpbGwgYmUgZ29v
ZCBlbm91Z2giIHdyb25nLg0KPg0KPiBTbywgaW5zdGVhZCBvZiBzaW1wbHkgdXNpbmcgdGhlIHJl
c2lkdWFsLCB3aHkgZG9uJ3Qgd2UgZXhwbGljaXRseSBzZXQNCj4gJXIxMCB0byBhIGtub3duIHZh
bHVlPw0KPg0KPiBCZWNhdXNlIHdlIG5lZWQgdG8gcHJlc2VydmUgZmxhZ3MgZnJvbSBvcmlnaW5h
bCBoYXNoIGNoZWNrLCB3ZSBjYW4ndCB1c2UgYW55IG9mIHRoZSBzaW1wbGUgemVyb2luZyBpZGlv
bXMsIGJ1dCB3ZSBjb3VsZCB1c2UgTU9WICQwLCAlcjEwIGJlZm9yZSB0aGUgQ01PVnMgdGFyZ2V0
dGluZyB0aGUgcG9pbnRlciBwYXJhbWV0ZXJzLg0KPg0KPiBCdXQsIGlmIHdlJ3JlIHVzaW5nIGEg
bG9uZy1pc2ggZW5jb2RpbmcgYW55d2F5LCB3aHkgbm90IE1PViAkR0IoMiktMSwgJXIxMCA/DQo+
DQo+IFRoaXMgd2F5LCBpbiB0aGUgYmFkIHNwZWN1bGF0aW9uIHBhdGggd2UnbGwgc2V0IGFsbCBw
b2ludGVycyB0byAyRywgd2hpY2ggcmVtb3ZlcyBtb3N0IG9mIHRoZSByaXNrIHdpdGggYmFja3dh
cmRzIHJlZmVyZW5jZXMsIGFuZCBtYWtlcyB0aGUgYmVoYXZpb3VyIGludmFyaWFudCBvZiB0aGUg
aGFzaCByZXNpZHVhbCAod2hpY2ggaXRzZWxmIHJlZHVjZXMgdGhlIG9wcG9ydHVuaXRpZXMgdG8g
bGVhayB0aGUgaGFzaCB2YWx1ZSkuDQo+DQo+IFNvIEkgc3VwcG9zZSB0aGUgcmVhbCBxdWVzdGlv
biBpcyB3aGV0aGVyIG9uZSBleHRyYSBNT1YgaXMgYWNjZXB0YWJsZSwgYW5kIGlzIGl0IGdvb2Qg
ZW5vdWdoP8KgIE15IGd1dCBmZWVsaW5nIGlzIHllcyB0byBib3RoLg0KPg0KPg0KPiBUbyB0aGUg
ZXh0cmEgY2FzZXMsIHRoZXkgY2FuIG9mIGNvdXJzZSBiZSBhZGRlZCBpZiB0aGUgY29tcGlsZXIg
c3VwcG9ydCBpc24ndCB0b28gaG9ycmlibGUsIGluZGVwZW5kZW50bHkgb2YgdGhlIGV4dHJhIE1P
Vi7CoCBCdXQsIGlmIDc3JSBvZiBwYXJhbWV0ZXJzIHRvIGluZGlyZWN0IGZ1bmN0aW9ucyBhcmUg
cG9pbnRlcnMgYW55d2F5LCBpc24ndCBpdCB3b3JrIGNvbnNpZGVyaW5nIENNT1YtaW5nIGFsbCBw
YXJhbWV0ZXIgcmVnaXN0ZXJzIGFuZCB0dXJuaW5nIHRoZSA1NyBzdHVicyBpbnRvIGp1c3QgNiwg
YW5kIGltcHJvdmUgSSQgbG9jYWxpdHk/DQo+DQo+IH5BbmRyZXcNCg==

