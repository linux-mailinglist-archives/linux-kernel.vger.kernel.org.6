Return-Path: <linux-kernel+bounces-325452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30EE9759DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E401C2365A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B75193073;
	Wed, 11 Sep 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt67zNsv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6141B815
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077673; cv=fail; b=WYbr33i2l3MW/jrkBIevEyB9369kyUB0+bFU2JyAlrBj2ey+bmhtuwOz7oU1gm35H3m7vj4bX56TJzYh2UZSgjJTmnsw5LL4PNQn4yazDjSUqPnyxvdu8NXTLcnjsK6qAZZecjOWtzgIqCDobA1ILM5vpUWYUrnCOTC8GTNMni0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077673; c=relaxed/simple;
	bh=AOXxQbOUVsw8ldH0rFCovXjSbhKUW+Q4rqE5SOrSM6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NoHwwaglKDM4woIdBzPPRlYSjUNL1XVqEfN2tFpKSmTHFRGBilqRgu7IrZg4mTiqX80xTrPDNqX0S17fg5Hqf86yKgySoWQhnS1mdf0XEPksuDO/4Z0GUlJKtH6fYeAfpb3MxPPbrC3+B5LHye52Nx+AzioY6StrwNUmV1zn2FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt67zNsv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726077672; x=1757613672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AOXxQbOUVsw8ldH0rFCovXjSbhKUW+Q4rqE5SOrSM6g=;
  b=Yt67zNsv31/LQs5HCcoMS97RQAKpn4lpIkFEdBG/suReDk/B5IxWmk1V
   AXOInzzsyCHn5viy+sPv0GZKg02VfDVGVSpLCdHxTMb77DqLRIQ548oZN
   IV2Wl2pjPiBErb9JHtGN3OvAP3DCp3Pi4o5dnl+jrHx8McHICiZgkUJKg
   BHXq37uoVdHIrhU1PykpRylDO+cC7vtIwEeYOlvRiFgp6ZH2HqIVJ1Cr9
   PXfH+DV4lppW8ZZsokOUlxOwk5B7vI++zAWfLBNBg4xsIFdpCUNwa5Mc/
   zWyxXZz5j8x50d152jseMSd1B9lwGuIjDKkv4OVYnOg983o4dxzf5UKc/
   Q==;
X-CSE-ConnectionGUID: bnznf5FKRoKGNimGqnfQcg==
X-CSE-MsgGUID: bU5dw7P5SZSdu03qE9ishQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="42415854"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="42415854"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 11:01:10 -0700
X-CSE-ConnectionGUID: COYiIwUUT8WqRHfJoTu0Dw==
X-CSE-MsgGUID: bGPb6xrmQY2jIBIPqsmbQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67071515"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 11:01:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 11:01:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 11:01:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 11:01:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 11:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcUJaA0v4atixBa5d2ltpE4NZOywYTAvplKeCL2ql8coDDiQYm/MTYOnGHlNcwKf5fnCodLQtMFTPns+Y3LmyKjwJt4wsAWA79nRtSbP9Y9KAK2v1m5BWSUC/KHD3hAVXCqFGUJbQMkXVSPsb7cA9ka9GutL72GD6Kw9dYlzNGaX20yAERSIcGbk+htVi2Jar4kpTmIHCqmr6Tq0t5QHdgLO2wJr3GUIthtvKpbQJfqXITGAAK0cCZMEvsFRe1DnN6+T8my558Y+EIiuLGdCo2JWN1y2ZY5NuUQKyKu2Xhyj5xhkmNEiopuNKageYH8E0jMsujMC+FW5gRHoayeAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOXxQbOUVsw8ldH0rFCovXjSbhKUW+Q4rqE5SOrSM6g=;
 b=KZFHKjPs6a3Yyqu9Mv6BIB/67ow5/kuZVfYHuJZDBGkdgzclRrr5l7ai/42LgwUbgxgWY5YAjvZoizh9SEfTAMeDpHqk/CcKoS6dyZDCvBQKa8EwetZ7QPr0YKHrc7sxHhz954GNK7YIKw+HY6AtV7BrGrADbq4g5M9kGDh2Hf3DCmV6UT0ifC/8pYxSb6bBa5W0FO3fLNbsG8AdMhJXovGaWAe8aKuOr6igVEXaPvlPpLRLV6XXlIEPFnTz9+1Kg29vgJe5iRKYqtgfujo/5+lvDnB1ROQqqRKp77xiFyXvFAEfT9p6V8al5ZIGWor0srgiNSxycRal3XMzC5+zTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 18:01:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 18:01:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "Yang, Weijiang"
	<weijiang.yang@intel.com>, "kees@kernel.org" <kees@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"rppt@kernel.org" <rppt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "debug@rivosinc.com"
	<debug@rivosinc.com>
Subject: Re: [PATCH] x86/shstk: Free the thread shadow stack before
 disassociating from the mm
Thread-Topic: [PATCH] x86/shstk: Free the thread shadow stack before
 disassociating from the mm
Thread-Index: AQHbA9VXJjAUX7KHkEq8AjUwhS/vR7JS4XKA
Date: Wed, 11 Sep 2024 18:01:00 +0000
Message-ID: <d4c68681d9e72a5b841bbbb1af1606b382079ad6.camel@intel.com>
References: <20240910-x86-fix-shstk-leak-v1-1-43cef0c56b75@kernel.org>
In-Reply-To: <20240910-x86-fix-shstk-leak-v1-1-43cef0c56b75@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DM4PR11MB6066:EE_
x-ms-office365-filtering-correlation-id: 5cf8b790-a4b0-439b-4930-08dcd28bb1ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0NnUmh1eExhR2xvRlo5T1NHNlpGeWFFWllacWJnR0NDc1R5RERQcWhLM2I4?=
 =?utf-8?B?c2E5eTZ4RXZNRldvQ1YyWTJncjhGZUdYZ1dpRmxQdTNqMVFZR3I0Z1BxRkUw?=
 =?utf-8?B?SWx6ZC9TWDVlVlpsNmY1Yitna1VQMHlrK3ExYjlxWEdpYm0xNTVtQWNST0RW?=
 =?utf-8?B?MVdyYjEzV3dRcUNra0p1b2orV3JyNSsrTHJjS0JaQzcra3hJMTM3UnhXMXJu?=
 =?utf-8?B?czlmRWxBTkRIWVQ0RXVWS2NhaDlwRjhEU3h4NjBQL2MxSWVFWDcrOVVsQUp6?=
 =?utf-8?B?RTE2NWpaRkFuZEc2c3V2MkY1aWF3akNKZ0tCNUIraVdWREdKaVdQelFidEEz?=
 =?utf-8?B?akN1cDZiempCdUxGVzdCRUd2NHF4Ky9SYnN4aVBvejA3dzQvbEh3bDFNWVVL?=
 =?utf-8?B?d2Y0UVFLZE1xcVUzQzg3d0txdEVnRmhMUDlUZ0JsNCs1ZjBnSVdBZlMyRmgr?=
 =?utf-8?B?SWN5OWVJWWUzNUdnalNuTmFnRElIb21hbHFTamgyNjloS2lHT2p6M1lGRjU3?=
 =?utf-8?B?UmFGTENTVVNBL0RQM0t2L2VSWFNUS3FLeTJmbFFJa1hVSnNzSTJ6WVNSYitH?=
 =?utf-8?B?N3h5VlhyYlhydE9nZC9Oc3RERUQ0YlNYVDZjYWJsRmVqQkR3NkZIWU9tNVFr?=
 =?utf-8?B?VkphODNkVDdwckVqVTh4czk3MkNEZVhIa1A1MHRSWG9nYWVLWjNCZ3pvdG9R?=
 =?utf-8?B?QkRnQjYzOWIwWkV2bjN2ZjVmcldFcFRQMFdXaWEvalpodDJZcHBOS3EzTk91?=
 =?utf-8?B?aHphL0E1SkwwWFUzdnA4MzNGcjZIeUpoVWdseEd1WFl3QVczQVh5YTA1UXVC?=
 =?utf-8?B?THNWT1VQKzlrZWlhb1F0ejBxbkwzTVlHeE5mYW9xWm9MY0RFN2hQNWFLS3RH?=
 =?utf-8?B?T0JrV2l0bkVDOW4xdGZjeEo0cHdCay9qVnFESlR0dTFlRVh6aDJjT2JzVlJ6?=
 =?utf-8?B?WndYM2JZVEZjaEZFcnhJVlU5QkVDMmZZZ2RjZnRaZkJEQnZrRlh3ZWhSRGxv?=
 =?utf-8?B?WXFUOTJtQVBESW9uT29GbHNpOGI1YzgwcXBQaWNKNHA0dG53WjNyOUQwNk0r?=
 =?utf-8?B?c0pVMmRMZjlXQ0sxTDI3NGxIWnNZazgzQnlTS1BDTHp3K0lQR3k1ZVJkS3Uy?=
 =?utf-8?B?QTRQQVdwdkNXQ0l3QjBqM2VOazR5R2JrY01KZFozRFlSSnN2aWI0dVFYSFQx?=
 =?utf-8?B?cDdWRFEyb2lQN0Z1eG1CZkFRemNaVUJCWmViWlluYzNwSGZqRlpFR0hablZR?=
 =?utf-8?B?QnlhK05uQ1o2TlJPWjNGRERXaGdTKzQybTVMcFdDSWg0WFltOThqR2RsYjU3?=
 =?utf-8?B?Nm1adG1zeEJZQzU4TFR3R2QxU1FEY3pWWE9kU2F4VHRVU2FTSFRCaWZlTkEr?=
 =?utf-8?B?Zzd4YWNCYWdLczd0ZU9WZGZFVDBBRDNZTzJyRkljbTR1MXlTMHhsSHNPc3hO?=
 =?utf-8?B?WDIySFFYV0JnczkyR2daNnpvdlVrVWhRYVJxUGIzSzJja1Z1VzJZUmJpdUxl?=
 =?utf-8?B?T05DUXJWNGZoc0pRVC9XU0pKZ1VSSXRwbGg5ckV0WC9DVUgxcVR3Yzl1RzVw?=
 =?utf-8?B?TWJNdHZqVjhFNjlwSEZvSm00OFNkaGdwK05tMTBxYWZTQzRER3lnSTF6MGdD?=
 =?utf-8?B?a3pUODhBREVURmxJaE1jWkh2dzdtSytKR0dCNDd6L1BXVjREQ0w3ZkRvQytE?=
 =?utf-8?B?eWt5NmVvdTl5bWx4d2pNUVMvdXVzTkRjdm0zU3AzQXo5VG1IY29yWHRGWFZC?=
 =?utf-8?B?Nmp6M3hZZWlMakJPSllWZUJJNm9xeThsY0FFc25NZzVLMFFMMVBReEFneFZj?=
 =?utf-8?B?NlVWTTRWelNmK0dkNHJFbzZoMnBMMnNHVlZkdDFOYXl5VTBleU9OVGkzVmpm?=
 =?utf-8?B?Rm1KTUdRdjZYVkZGK1NhazU2b2VYUjBlUysxMEhlK1ovRTdPVjZkalZoNkp6?=
 =?utf-8?Q?UrxxmmBHUbQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG5EVVJpeWRYaERrZTl5bHU0U1BaQWQxbnlvYVk3QVFUanJCZVJCMUU5QW5w?=
 =?utf-8?B?bTVLUFN1bGVxTHpYVW8xUWJlWlV0anRPT0ZQaGlPb3VCSnlEWjlXLzZTOVJS?=
 =?utf-8?B?S0I5STRYOXd4T1NHZVhZYit3ZU9JWHB0RmxPeFkrOG04dkpEcS9QM0F1Szgw?=
 =?utf-8?B?aFpwbVFYSHVLRThyV0h6ZGNmdm5udXdrM20wN28waWoyUFd5OHpzYVllbGhV?=
 =?utf-8?B?WERUNE1rc0FwbGxPMVBiYWVGbUFwNk1TZlBpMm85TmJHQUhrK0V0dmRZdm84?=
 =?utf-8?B?VVd6M2N4Y0gxdU1pTERmWXU3Slp6djFmM2M4RUFOTFdmSEVOWFJSTFRPYi9q?=
 =?utf-8?B?WXcrU0ZKby9ZNS9Fa0N6NWNHWnJLVWt6WFE1bzE5d2o5RVRkUDZNa3hQZTV4?=
 =?utf-8?B?RDVkQmdGUld1T3VPdTB0UklUaWVFVzVxTXR2aExUaDhGQXpUNFk3WWtieEtD?=
 =?utf-8?B?eGFzT2drQzE4Ymd0aWVWREtSNUxIdjZkakRiR0QvVFFnSUwvUnY4eDJFOGhh?=
 =?utf-8?B?amRqRTlOUzdyL1JROVBBWm1CTGFkM3dieW1ISHB2OFVvTEZteHJpaGIrbW5V?=
 =?utf-8?B?Z0hUbmlGdEhMeVJUdlBRandQR1FJZnZMTmtwUWFxVFphU2E0bVJsWkpOcnFB?=
 =?utf-8?B?WHpvdWNUSXNkWk5PV3AxVDFYdFY0QjdKMS9mMHJya2ErTitJWmJ4STZ5Z203?=
 =?utf-8?B?RzNyU1hsSXFTeFBVVVJTNmVaQTVMQjg2cWNuaFpiTU1OaGFnWFQwWXZ1ZzI2?=
 =?utf-8?B?aFVoN1NJK1owclhyang1MEh5aWFldmVKbUozUVRXNXA2bVNiYWlHanNydEQx?=
 =?utf-8?B?N3hFYlhnM0VpV050VWNGaDNtckNlSnc4L241ekJET2hFdldyRmlnSFVsRUtI?=
 =?utf-8?B?QzdDbXVQaG5kdHZqM21wTXBadjB6bGN1V0VFc0lOZjFMU0krWFZIalBjYVhD?=
 =?utf-8?B?UnVxV3NPUjVTVHZmUTZ4WEllWjhkZGh3TncvcW5UNysraVlVVFF0cm1kNktt?=
 =?utf-8?B?eVpaczNjcTJ2a1UrZEpqVE4wdW53Q1p4UnBxczdhb1Y0ZjVDdU5uNDFNQkEz?=
 =?utf-8?B?K1pIQ25JbTB1enpkSVFtQXNhN1BEdnJ0dEIvVUFvNHhEbGJCc1lld29NbnI5?=
 =?utf-8?B?M2RpcnphZEpjSFp5cTkveXVlTFVEM3I0OWJoTHo1bE1lcmhuVWVxZFlRaU5s?=
 =?utf-8?B?MmRxeldFVHRIT25tSzlEbW5GNk9sd3ltLzVKdHVtWSswYW9ES2Q5TWNFNzNy?=
 =?utf-8?B?NGdOSmZSQkgyRSsxbTg1M2dZZGVDb1RCcVNYbWhqQVpHMTBOZjVaYnFORUtQ?=
 =?utf-8?B?cFVaaGVwNDAvSVZEaSs5WkY2RG1nOTl5SHpmaGF2ZlNDdVZQbW5uRHpNTWJL?=
 =?utf-8?B?cGE2T3JpZG9DQkZlQVA0S0VvQXdvVWRKdENxeXE2OTdLU0xzendLSlhjZ3hO?=
 =?utf-8?B?WWh4UVZRSUlmVWkzQzFySDBxckRUTEhTNFN1NFF6MFRCSGR1UzZBNVNoL20y?=
 =?utf-8?B?RDNaTjhKZDhqOUZiVmNHaEhZaWFhMHpJN3NHUk9YcHA4S1c2TWhnNFkrbk5Z?=
 =?utf-8?B?eUJUZmJOLzN5NzlCRnFlRk1lQ0YwNms5dmYvbkFiZUJvK0xnemhhYkVlSlc3?=
 =?utf-8?B?Qm43QmtUbVh5YXpCTFRlaUNCdEJybWp0SGJ2eTcvVjNxSjJpSFZPQ0lZL1BQ?=
 =?utf-8?B?bGU0SGJMRDJ4d3dJbStqQ3o5eHJSNmVjVzg5UXBlRzRXcVNmSDg3MENTTDJo?=
 =?utf-8?B?a252TGt6QW1QMWtUL25rUmJCL25iWG9jOXRuZUJhZEFDcFphNXc0cXIwNnE3?=
 =?utf-8?B?KzVDNjNLNTJJQXJwS1BQSXJmQm92d2lvMUdnRDlidytiRk1JWHhFR1NOVEdu?=
 =?utf-8?B?VmswYjZBRmVvdmgwNUtQWE5jMGpBaVpKSUQvV1BQbHdPcG5tTVVTY2JVUHJl?=
 =?utf-8?B?QmR1aUoxTFc4cG40SDdIRncxUHBhZmZGRko0NDJYeWUxS0xnL0VTRm9MWlNj?=
 =?utf-8?B?dTVmWVVNZUpTVXFWMGpjbEVlREN0ZGt6RzN4USsxMm9WbVp5NkZqcDhGYzRI?=
 =?utf-8?B?TFJyN2hCcEEyUWRoVkxPc1h6RUpBclBRUndrS0lBakxzMWpWSmJ3ZnZidHFn?=
 =?utf-8?B?aEdpOG5HcUtwelBSRGhnZElRZkN6MHBhSlNhV3NYMEViWFFJWWdJZkVIQTRF?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F47B89162050D24CAD0BF8D4B845CFC6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf8b790-a4b0-439b-4930-08dcd28bb1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 18:01:00.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WN6cnn4Z7eZGeF2J8f9XAKLT+7MwJfFRidpUfsaX1mQ7yR3sK7L2qhL3bGbs75/Ko4OcjdROFpR2c3c4wzUxYsNecBEgqj9drnZMJfpjMKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTEwIGF0IDIzOjU2ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBX
aGVuIHVzaW5nIHNoYWRvdyBzdGFja3MgdGhlIGtlcm5lbCB3aWxsIHRyYW5zcGFyZW50bHkgYWxs
b2NhdGUgYSBzaGFkb3cNCj4gc3RhY2sgZm9yIGVhY2ggdGhyZWFkLiBUaGUgaW50ZW50aW9uIGlz
IHRoYXQgdGhpcyB3aWxsIGJlIGZyZWVkIHdoZW4gdGhlDQo+IHRocmVhZCBleGl0cyBidXQgY3Vy
cmVudGx5IHRoaXMgZG9lc24ndCBhY3R1YWxseSBoYXBwZW4uIFRoZSBkZWFsbG9jYXRpb24NCj4g
aXMgZG9uZSBieSBzaHN0a19mcmVlKCkgd2hpY2ggaXMgY2FsbGVkIGZyb20gZXhpdF90aHJlYWQo
KSBhbmQgaGFzIGEgZ3VhcmQNCj4gdG8gY2hlY2sgZm9yICF0c2stPm1tIGR1ZSB0byB0aGUgdXNl
IG9mIHZtX3VubWFwKCkuIFRoaXMgZG9lc24ndCBhY3R1YWxseQ0KPiBkbyBhbnl0aGluZyBzaW5j
ZSBpbiBkb19leGl0KCkgd2UgY2FsbCBleGl0X21tKCkgcHJpb3IgdG8gdGhyZWFkX2V4aXQoKSBh
bmQNCj4gZXhpdF9tbSgpIGRpc2Fzc29jaWF0ZXMgdGhlIHRhc2sgZnJvbSB0aGUgbW0gYW5kIGNs
ZWFycyB0c2stPm1tLiBUaGUgcmVzdWx0DQo+IGlzIHRoYXQgbm8gc2hhZG93IHN0YWNrcyB3aWxs
IGJlIGZyZWVkIHVudGlsIHRoZSBwcm9jZXNzIGV4aXRzLCBsZWFraW5nDQo+IG1lbW9yeSBmb3Ig
YW55IHByb2Nlc3Mgd2hpY2ggY3JlYXRlcyBhbmQgZGVzdHJveXMgdGhyZWFkcy4NCj4gDQo+IEZp
eCB0aGlzIGJ5IG1vdmluZyB0aGUgc2hzdGtfZnJlZSgpIHRvIGEgbmV3IGV4aXRfdGhyZWFkX2Vh
cmx5KCkgY2FsbCB3aGljaA0KPiBydW5zIGltbWVkaWF0ZWx5IHByaW9yIHRvIGV4aXRfbW0oKS4g
V2UgZG9uJ3QgZG8gdGhpcyByaWdodCBhdCB0aGUgc3RhcnQgb2YNCj4gZG9fZXhpdCgpIGR1ZSB0
byB0aGUgaGFuZGxpbmcgZm9yIGtsbGluZyBpbml0LiBUaGlzIGNvdWxkIHRyaWdnZXIgc29tZQ0K
PiBpbmNvbXBhdGliaWxpdHkgaWYgdGhlcmUgaXMgY29kZSB0aGF0IGxvb2tzIGF0IHRoZSBzaGFk
b3cgc3RhY2sgb2YgYSB0aHJlYWQNCj4gd2hpY2ggaGFzIGV4aXRlZCBidXQgdGhpcyBzZWVtcyBt
dWNoIGxlc3MgbGlrZWx5IHRoYW4gdGhlIGxlYWtpbmcgb2Ygc2hhZG93DQo+IHN0YWNrcyBkdWUg
dG8gdGhyZWFkIGRlbGV0aW9uLg0KPiANCj4gRml4ZXM6IDE4ZTY2YjY5NWU3OCAoIng4Ni9zaHN0
azogQWRkIEtjb25maWcgb3B0aW9uIGZvciBzaGFkb3cgc3RhY2siKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiBJdCBpcyBlbnRpcmVs
eSBwb3NzaWJsZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUsIEkgZG9uJ3QgaGF2ZSBhDQo+
IHN5c3RlbSB0aGF0IGFsbG93cyBtZSB0byB0ZXN0IHNoYWRvdyBzdGFjayBzdXBwb3J0IGRpcmVj
dGx5IGFuZCBoYXZlDQo+IG9ubHkgY2hlY2tlZCB0aGlzIGJ5IGluc3BlY3Rpb24gYW5kIHRlc3Rl
ZCB3aXRoIG15IGFybTY0IEdDUyBzZXJpZXMuDQo+IElmIHRoaXMgbWFrZXMgc2Vuc2UgaXQnbGwg
bmVlZCB0byBiZWNvbWUgYSBkZXBlbmRlbmN5IGZvciBHQ1MuDQoNClRoZSBjb21tb24gY2xlYW51
cCBjYXNlIGlzIHZpYSBkZWFjdGl2YXRlX21tKCktPnNoc3RrX2ZyZWUoKSwgd2hpY2ggaGFwcGVu
cyB3aGVuDQp0aGUgTU0gaXMgc3RpbGwgYXR0YWNoZWQuIEJ1dCB0aGVyZSBpcyBhbHNvIGFuIGV4
aXRfdGhyZWFkKCkgY2FsbGVyIGluIHRoZSBmb3JrDQpmYWlsdXJlIHBhdGNoIChzZWUgY29weV9w
cm9jZXNzKCkpLg0KDQpTbyBieSBteSBpbnNwZWN0aW9uLCB0aGUgZXhpdF90aHJlYWRfZWFybHko
KSBpcyBub3QgbmVlZGVkIGJlY2F1c2Ugb2YgdGhlDQpkZWFjdGl2YXRlX21tKCkgcGF0aCB0aGF0
IGhhcHBlbnMgZWFybGllciBpbiBkb19leGl0KCkgdmlhIGV4aXRfbW0oKS4gQnV0IHNpbmNlDQp0
aGlzIHBhdGNoIGFsc28gcmVtb3ZlcyB0aGUgc2hzdGtfZnJlZSgpIGZyb20gdGhlIGNvcHlfcHJv
Y2VzcygpIGVycm9yIHBhdGgsIEkNCnRoaW5rIHdlIHdvdWxkIG5lZWQgY2xhcml0eSB0aGF0IGl0
IGlzIHVubmVlZGVkIHRoZXJlLg0KDQpBIHF1aWNrIHNlYXJjaCB0aHJvdWdoIHRoZSBhcm0gc2Vy
aWVzIGFuZCBJIGRvbid0IHNlZSBkZWFjdGl2YXRlX21tKCkNCmltcGxlbWVudGF0aW9uLCBhbmQg
aW5zdGVhZCBhIHNlcGFyYXRlIGNsZWFudXAgc29sdXRpb24uIENvdWxkIHRoYXQgYmUgdGhlDQpy
ZWFzb24gd2h5IHlvdSBzYXcgdGhlIGxlYWsgb24gYXJtPyBDb25zaWRlcmluZyB0aGUgdHJpY2tp
bmVzcyBvZiB0aGUgYXV0bw0KYWxsb2NhdGVkIHNoYWRvdyBzdGFja3MgbGlmZWN5Y2xlLCBJIHRo
aW5rIGl0IHdvdWxkIGJlIGdyZWF0IGlmIGFsbCB0aGUNCmltcGxlbWVudGF0aW9ucyBoYWQgY29t
bW9uIGxvZ2ljLiBJZiBwb3NzaWJsZSBhdCBsZWFzdC4NCg0KQlRXLCB0d28gbW9yZSBub3RlcyBv
biB0aGlzIHdob2xlIGFyZWE6DQoxLiA5OSUgc3VyZSBnbGliYyBoYXMgc29tZSB0ZXN0cyB0aGF0
IGNhdGNoIGxlYWtzIGxpa2UgaHlwb3RoZXNpemVkIGhlcmUsIGJ5DQp3YXRjaGluZyBmb3IgbWVt
b3J5IGdyb3duIGFmdGVyIHJlcGVhdGVkIHRocmVhZCBleGl0cy4gSUlSQyBJIGludHJvZHVjZWQg
YQ0Kc2hhZG93IHN0YWNrIGxlYWsgYXQgc29tZSBwb2ludCBkdXJpbmcgZGV2ZWxvcG1lbnQgdGhh
dCBmYWlsZWQgdGhlIHRlc3QuDQoyLiBXZWlqaWFuZyAoQ0NlZCkgaXMgd29ya2luZyBvbiBhIGZp
eCBmb3IgY2FzZSBpbiB0aGUgb3Bwb3NpdGUgZGlyZWN0aW9uLiBBbg0KZXJyb3IgcGF0aCB0aGF0
IGF0dGVtcHRzIHRvIGZyZWUgdGhlIHNoYWRvdyBzdGFjayB0d2ljZSBhbmQgdHJpZ2dlcnMgYSB3
YXJuaW5nLg0K

