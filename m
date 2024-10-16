Return-Path: <linux-kernel+bounces-367057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE4399FE26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022E2284E58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AAA81727;
	Wed, 16 Oct 2024 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cblTljXD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EE28EA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041726; cv=fail; b=Ca2m6gnHxuYt7j6LiUItddI75oVW3WCjK2ScTvyoqP5zxPh2KxjSTEcjNE9Cklt/JF0PEOmbt+F3uzI2MsRRd8PeOB4WUH0kmrYvA3I3NFgaYw38qg3XQNIhMX/XQAkhg6eUIIvQTbJQrZJ0nuwmHoZlU89ibAntxjIp/ZbAnOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041726; c=relaxed/simple;
	bh=sWH1lqpF7oz7ArUgXeiHEA1WTTDIjtqcbwgN7rLqPJY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WzQsNjNp+al/+1Yqaq4ogbiJ0RXb1e12M0OG0RR68VWON1a2hSHB+WBE//WrIcesIbYdLNUhqtauJL3GSaNIilFjcz5y3+o1AJWK3LE4DFd418OeR8rQiPUlY7Y7NQd4KuJsow6xoUOkBLp4vLTEWrFBkaXLj7v8h6deM/ENNbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cblTljXD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729041724; x=1760577724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sWH1lqpF7oz7ArUgXeiHEA1WTTDIjtqcbwgN7rLqPJY=;
  b=cblTljXDNIVR4YZEZQXhEaUn8FmBbD0+r7WlO6H8EHrWkCkIChE0f9/v
   wRL/pFxDiGAlHUtmNmfkFfs8nMyP11sfwFGlyT2HfGEKTowbOhuEHMziY
   cDpCmkDP9JdZ8qGlMeDZTSc83xqqNy2tlNSUoCL2OieA+AJ9/26gKeKRb
   6hNdphm2dSq1dWVrdie0y7DOR+kKJZKbc1TrLC/al7bkNYdUTMl1bzmpO
   cn5CcTO94+kRQ4EcUnMM/EApo5b+9/se8xBkHyZwcPMuj7zZ3BH2GMWP2
   wq8uOV8Ma2hmsj7rtQvOvdESbjLho6W725aazPMI/TRQ/WH80WAxvAS3H
   w==;
X-CSE-ConnectionGUID: fCtwfWmQR0uwPL+z9k5evQ==
X-CSE-MsgGUID: O/ANcOSSSFSBCYRfdTa3Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31341589"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="31341589"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 18:22:03 -0700
X-CSE-ConnectionGUID: 6oOoxkAORTKMY73kXGyLNw==
X-CSE-MsgGUID: WKc7hpkkS1efs904lOoeOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="82722840"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 18:22:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 18:22:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 18:22:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 18:22:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGJlmYBOmu25O9MaEcAWn+vZfrDVV7w0qvRl1kZ2RZ3X+pxs7tcOS0rqQpmWMgIrxzRWhvS969BimPpWWcvyvzAop+Ce75RvZQQFZPTktjwRQNSVkyATNP+SeXOP6F4rKyMibuVNEPm9+ZRgfJP7zi26ETUrWVtEqRxRBmB9XB8XRs2LjVeJwSp9K9phSxcLCr6Qp+oP22uJbhgG7/qkI4KM2e8qDOIAu5nSJmg5IDkIHvK3gLpFU9DSvgqSIYkRLzRMBoEc1/2+EBNs7nZT+bl6PPmFhKJwvdWVWHIuyMMjl/OVmZBMKqFWyoxqiQgBaOOPFhjLbdzSJYhHntrjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWH1lqpF7oz7ArUgXeiHEA1WTTDIjtqcbwgN7rLqPJY=;
 b=twyGIqAv1Ardtq51i+ckKuIZzQCCsGNb7xF6HoXYDQBKR9Dov8TVzMGgesqY8FWAB0a3yZ7V3tzVhCCwmaklvrSz7tryisTYB1zlQrA9lQmVn0huoVPOaXlrpkJ7H85TYArCpkrItotogErzIAOkpgbQObChLDUGNaHcnHlNAAGF363b6Lm+FtkTAIJk6sCaf8kuKchtSsiTYORmbIMV0KAJ2OqgGeOmmUAsX2iadd5oHcbDD9QKodQR1X+WIDGxLNKYqUyHqYOnqwXPySNOfEEYdlwl2NwhX4dHYwPFil0AgOimdx9k5sVe5O0Carn+RjvJQlAzfzGwP/XK/9zeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 01:21:55 +0000
Received: from SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::928e:8882:8562:2dd5]) by SA1PR11MB7130.namprd11.prod.outlook.com
 ([fe80::928e:8882:8562:2dd5%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:21:54 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Boqun Feng <boqun.feng@gmail.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "will@kernel.org" <will@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] locking/pvqspinlock: Convert fields of 'enum
 vcpu_state' to uppercase
Thread-Topic: [PATCH v2 1/1] locking/pvqspinlock: Convert fields of 'enum
 vcpu_state' to uppercase
Thread-Index: AQHa6gABo3p6UgrMyUar0JRUKAQsirKGnoZQgAJYqICAAAf08A==
Date: Wed, 16 Oct 2024 01:21:54 +0000
Message-ID: <SA1PR11MB713078FBB3654722B4832E6489462@SA1PR11MB7130.namprd11.prod.outlook.com>
References: <20240805023816.28003-1-qiuxu.zhuo@intel.com>
 <20240809014802.15320-1-qiuxu.zhuo@intel.com>
 <CY8PR11MB71348DD03E5B112FAC1FDC9289442@CY8PR11MB7134.namprd11.prod.outlook.com>
 <Zw8OKZOme7Pk4W_2@Boquns-Mac-mini.local>
In-Reply-To: <Zw8OKZOme7Pk4W_2@Boquns-Mac-mini.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7130:EE_|PH0PR11MB4903:EE_
x-ms-office365-filtering-correlation-id: b1303482-0b7a-4356-af83-08dced80ebe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZlJ4TW15eGFJNGVSS3JhVU1OU3Qwa0NHdnUxd0pvLytYd3V2ZkpsWGMrZmJI?=
 =?utf-8?B?UTQvYUZUVWZVZmhPbjFFdzFlUy94UTh4U1NCUDRqQUkxN3V6YW9oL1RSalc5?=
 =?utf-8?B?UmdSckwvd0RTUE9jUGVBRDU0aGg1TmdQNTJVN1RWa2l3dDlZeHU4bTF3L3hH?=
 =?utf-8?B?RXRPUHdMUzRMMmhkeU9LNkkzMFNpSms0SkZYY0RteDNOeE15elRBaFZVMFNh?=
 =?utf-8?B?a0pTd0s5UWJpMHpmMWR4a3ltZGk4NEpVR2dqVnZHOGhWcTM2b0FuRWtrczJn?=
 =?utf-8?B?bXR6S0RlTnJIM2dDL3BaSE9CeU9aN0dyU0dpZTIvNjRsekprQ2liNjVCS0c4?=
 =?utf-8?B?eSs0ZktTN1JPUEowTDlqSjh4YmFYdkg1L3liNDJ3R2hmcXJZeXZiMzNKVmdi?=
 =?utf-8?B?Tk1IME9Qa1ZiOVYyTHpMc2hzcGthU2xMRXl2VmpoZElVSGJNS2x5RWtmSDZh?=
 =?utf-8?B?QkpZOHhxL0pYSStacG1ySkQ4R0J6WUtJdDh0blU3VlNCM3lSeSsvVk9xT3Yx?=
 =?utf-8?B?Yy9JUkZ0VmdvTyt2VjJVdVp1T2dNRE44UndtNEhBN2dmRlFPNjY0UWE0MU83?=
 =?utf-8?B?VUZoVXVkdmE4Mnh6VUJQbDZvMEFCQ3JGWmd6LzlBYTNhaTZQc3lRdDZxMXl2?=
 =?utf-8?B?SUw4NW1OWVVHc2xKb3hrYWp0NTNrcGJNQjBsMzRIWmsvTXNDcldJWmVwN3hQ?=
 =?utf-8?B?TmpPcFhzVm1HU0tneXlFb1lycElrajNLYkF5dVpydlRIZ3phNGk1NnA1QlhW?=
 =?utf-8?B?alptM2t5anUvSXpIdGlSUXVCQWx2WktsMktDRERCYUpqdHZLamVaZkE4UHpH?=
 =?utf-8?B?VDZlellqYkdGaytuUzJKNVpNMWJkVm00WkZ2VFpIdkExaVNzbm12eWF2bWxV?=
 =?utf-8?B?VVN3L2UyQzZ4eWMzdC9TRzJxMmVqWmcvY3E4TmQ4VVIvcWVPL1Mrc2tpZnov?=
 =?utf-8?B?cGYvVTBWN0JYYkk2RDBOK1R5dzdqSDNCYmc4Rll0VkpxdndkczBRWkFNMmlx?=
 =?utf-8?B?Q2pqQWpzMXJ1amVLNG1ueXRCY1IvVzZwNnk1OU9RVUhTekNBK3A4L2dRNit1?=
 =?utf-8?B?WkdhZ0tBeUw3VlFET1MyYkVKWldudWNWVGVqakxKSGxaUGRZSk1DQUdXNUFs?=
 =?utf-8?B?SjVUNTI3ZExJZDhNNm1hVXdJeENGbzUvSzNSREdsdjJHazN1OHZtTzdpSlZx?=
 =?utf-8?B?cFNMZDFQRkZrYjVYRDVvYnl2V01uenhMQUFscTlLeGI5aWxwbGlXVW5jQ1Ju?=
 =?utf-8?B?ak8rMTZRcFM3bFZkd21zNFdwZjMwcVI5MDdkVjM3TU9MNDRBM1ZpZGxaRW5E?=
 =?utf-8?B?anJSdG5jekgwbGN4OXFLUkdXVERSb3BKSVhQZnRsdzhmRGk0eHdCR0JKWmV6?=
 =?utf-8?B?WDVFU0d2aFJRSmkrQ2Q5QVdMa2xUV2podXZyUm8xd2FJd2h4U1hNQ2pBajBI?=
 =?utf-8?B?dHp3aFBqNzQ2T3YxL3RtbU5TVFJnOHRldlhYaW1WSmlEWXliQjlPbVA1dlls?=
 =?utf-8?B?TC91MGd2eXZvNzVSbTBzZDRnQW1YRHAzcndlb01mTFBoN0ZRMUg1QWdRclpH?=
 =?utf-8?B?MVY1SHRBU0dwUWcxdStreTRTVGU2eTljZzRzbjlxNHIwT2xjczFNZDdxaENl?=
 =?utf-8?B?RUpFdzBxSnVsVmc1TGJzdW0wT2RIallLTEFieUtPR3VRQXM4cVJXYjVBSDJk?=
 =?utf-8?B?ZGR6QjBvaXAvb0xnVURVL0Y3cXZURmxMeDNQTGE3Yk9lU3k2UUJHQXdUb0Rj?=
 =?utf-8?B?TktkUFhPTzlLeEZLWmlKbm50U3JGNk9qdncwQi82cHlORkFDL3hYQW5UejhH?=
 =?utf-8?B?UHRtWGYvNDlmbTdBUjBZQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7130.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3dqYkxmVWZDVGhCZnFYQVIyOUlZanQxVUlZWXNDaTYwNFYvUGZHTS9TK2tk?=
 =?utf-8?B?R3JRU1FzQ0RhS3VIamFQRmFqUkZBdEdDV3lOcTlMYkdwUXRMVmgwR1NDeGlw?=
 =?utf-8?B?aklQSUdOT0V5VGt2TmgvcEhSMTZpMWwydzI1dEladFExdHNKUTQxUDE4eDRY?=
 =?utf-8?B?bkNIeTJXM29tSW1NdWlGaDlrSmEwNTEvelBGUWpOZld5dG84RlRydFJWdFRk?=
 =?utf-8?B?cCs3NXdjaHROaVRzaFI2dnB6Sk5XRldBaW90ZklYaWl5dEJsVDBlTmtMbHV2?=
 =?utf-8?B?OTdpZi9qL1dNUVAyRHN1SlpkVTAxREdSdU1hdm5yYU5CVEl6cllEWTdFWXN3?=
 =?utf-8?B?MDZrMFVVSnllOVhicjlITWdBQkdwMEJVamUydnlpdHRpMzRaN0JRYXNWVmpE?=
 =?utf-8?B?S0dvbEZUNE9CYVAxT1RCL3VDWDkrNkVGc3ZxUXJjWlBOWU1oZElndGEya2Ey?=
 =?utf-8?B?YVE0eENRanhLQml4aGZJY0JsMVVUTDVkRnZwdmJGOURYa2ZLUlN3clVldlZH?=
 =?utf-8?B?Ni8xRlp1Q3MzWU0zMTFSWHVOT29XQlBiUW1OSEl2WHRLbjRGSlY0N2FyY0dY?=
 =?utf-8?B?ODB1WWE0TktPeGR5eEpMbjF4K1o3anFhbWRqY2lWU2UvWjIreWZ1WXZJK0tM?=
 =?utf-8?B?MFllb1lMaWF2R1IrN3R0ZlFuTVFSRitJbGZ4TXpiOWNKbWN5N1RtcXo3RDl6?=
 =?utf-8?B?OVhNYjFDc29TcFg1NzJJLzg4QmU0amlzcitoR0N4OFo0bzZqZ2RmSDZ5ZWM5?=
 =?utf-8?B?cEhxYlNvWEZBMVM4a2RlcVY3U2dHQXlDUmtHeE9NMk1IMlVDWndFdWNwQWtV?=
 =?utf-8?B?V3ZyZ3lzSk5BZFFUM05hcmJuWlhKdU4vekxTZjFqUkZqWmpqNGJWSFZVTExt?=
 =?utf-8?B?V1FTREd2UWZqTm1makxTdk9EbGFTd2krcUVCa1QrUGJ1Q295VzdrRDhjUnlK?=
 =?utf-8?B?MG5KWU9yRVk2WWUxU1pab0tIclVraFlrQUF6QStyUitEOHFGSFN0dnZNQWRT?=
 =?utf-8?B?NHFucktSY0orL0grVm54SExZUlRNZUM1QktLUndzcVFaRzFhQ01saW1oakIw?=
 =?utf-8?B?UzRTSlg3N01QcjFMQjV4bnZnOHVVYXhwT0wrRGx5TjQxMnZSSVRObXQzRHB6?=
 =?utf-8?B?V084S1pOWGhKZXVWczd3QTZteTlSaTRHVkN0Q0UrODJsSWtYcURLVldXZEFj?=
 =?utf-8?B?YSs2enRnOVk4Z2pwZkNtWHRvMzFjb1ZYWjFseU96TEVDN2NlSnYwaVY5RmMx?=
 =?utf-8?B?cTRGZE9UMHVWVTNnN1U3czJMYXNEekhqTFlKeUIxUmN2UW5RcTJEL091bHQ3?=
 =?utf-8?B?c2dlZm9GNWVNaXEvdFdkT2RNREtCMS9aOWxyNkovT0JkRy9vR3BWZTJUeWtH?=
 =?utf-8?B?bXp6ZU1LT1hEMVNiRHQ5R3Rld1NsRDhsbGZxZTFJLzAxUXo4cSt1MUdHS1ho?=
 =?utf-8?B?YkJSMGVwbWpmM0JPUnk4T2pCR2RYSEw2UGdFVGFSNUF1Qy91aG5ldnphS2ZT?=
 =?utf-8?B?aXdOVlAwSWRRTk9Ib1VQMW04L25QR3RBNzRpUTkxTkE5dzQ2YzNSYm5nMnh6?=
 =?utf-8?B?UXp3RUhwSDBhL2xjWk11RUh4dkJOYjY4ZXhnMTlBNEJhb1d6ZEswOUJWYzJo?=
 =?utf-8?B?T2JURVNYUlAyMk8yWjBONXorSEpnZmhiaHlZbDZmNFNoQ2YwR0NMdWMwZVo3?=
 =?utf-8?B?cVRBMEJOOWJ5NFY1MU9vY1hnQzV4RERqSjZoM3BzTnFBdThOR3pCS0ZlQ2k3?=
 =?utf-8?B?cjNTeHdpV2p6RFhrN0QrVXhkaW5Kakxnbkp3dVBsYWhNYjZ3ZWdrN25QTnZG?=
 =?utf-8?B?OFBCVkNpYW1VMG4wU3ppQTd5ZTJMQ2RiYURzcG9peXpkUi9wZFVDTnIybW9N?=
 =?utf-8?B?bzhSVlhQN0c1L1JkT1BVbFIra3BCeWVaTm0zdzRBTGJHYTZMdHdzZ2hEYjlN?=
 =?utf-8?B?RnlwSnM3Ty84Q3pQMklONnVha2J2Z2NielpHeVVQT0Ruakw3bEpmbXEzUE5P?=
 =?utf-8?B?RVkwTHJ1bnRBR1o1cVkxYjhlSVhkemk2WG1LVXJRUzVrM2szbytza2V1bWh2?=
 =?utf-8?B?c0pmMDlHTlVLMjdzWW04K0x4Nko2VHlQb1hEaytjNy9kSkZLdGM5ckdJMEJv?=
 =?utf-8?Q?y27rFOhDPIGl/mIrVcUs670qN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7130.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1303482-0b7a-4356-af83-08dced80ebe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:21:54.8844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkie8xkTK3YuzzAuAj5iwrmGBfkMxo/4og9h7Dux/4+NHDMZFsBhr8zL6FQl3/UCKbNRTvsKEaNIdU4jrJ9FQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-OriginatorOrg: intel.com

PiBGcm9tOiBCb3F1biBGZW5nIDxib3F1bi5mZW5nQGdtYWlsLmNvbT4NCj4gWy4uLl0NCj4gSSd2
ZSBxdWV1ZWQgdGhpcyBpbiBteSBsb2NrZGVwLWZvci10aXAgYnJhbmNoOg0KPiANCj4gCWh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2JvcXVuL2xpbnV4Lmdp
dC9sb2cvP2gNCj4gPWxvY2tkZXAtZm9yLXRpcA0KPiANCj4gLCBhbmQgd2lsbCBzZW5kIGEgUFIg
dG8gdGlwIHRoaXMgd2Vlay4NCj4gDQo+IChZZXMsIHRoaXMgaXMgbm90IGEgbG9ja2RlcCBwYXRj
aCwgYnV0IGl0J3MgdHJpdmlhbCBlbm91Z2ggZm9yIG1lIHRvIHJldmlldyBteXNlbGYNCj4gYW5k
IHdlIGhhdmUgV2FpbWFuJ3MgQWNrZWQtYnkpDQoNClRoYW5rcywgQm9xdW4uDQoNCi1RaXV4dQ0K

