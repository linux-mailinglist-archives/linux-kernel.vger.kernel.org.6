Return-Path: <linux-kernel+bounces-194597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169308D3EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C98B23CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7D1C68A0;
	Wed, 29 May 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBLxueZJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3D1C2326
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009172; cv=fail; b=HxAWnxP07m1qVBbJMMOoPsTT5DWdw7SjZJqB+MouXW/8nI61FxtFgP3M/A6Icp/RDN1H2YPd0i2Mm0R/oHprbBTRMZhcROiQv3xW2RHGVZGk6g7n81BGKK0FutHCuS5QJxICz43NhpyVEByapVYr2g9Y5hFNmfk0BaZhHi9U8SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009172; c=relaxed/simple;
	bh=Ni0xeV1FcMFj/sQWsv67Pr1M8y3Hra4dJ1Fq8oE7V4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=os0vR5PFT2JPFnttcelHqihP83+39Br8+KZchxwOlXVsWfbQjQ77qgkQguWSyKgfH7R5JWUDTEohfTin0CQ+NVdM0wUQpbhHc8VdFeGyq6hIuPZSuOLjjvaexEMHDxwnW9URhR3maDhWCMrpAbppxHK2jlhlZ4nFZr61Yb5qg8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBLxueZJ; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717009171; x=1748545171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ni0xeV1FcMFj/sQWsv67Pr1M8y3Hra4dJ1Fq8oE7V4k=;
  b=SBLxueZJUZIFqOjALyiIdJ5xvc4kO0rDywKb7aqoKi2QRKz3jZyKD6F6
   uoDI9/FzQ6EhkgqUVwMld+26yL+VH61rh8MVXbzeAGhvWDJUFmezytKlm
   R70RJHqNad6ILjpbN/whY1p77tdecLtqN50fhjxsbicXj9ty7aVkwb2wp
   LLytOu+k2b+vOmEQFlIar0ma+I/5NsUofM8zZe+c4ONlQ5kwRkbwzACbm
   SP7XUZWHa4wmwUTPH3T234jKjh98bwNaf0AjxlHhVVJgLHBg9wl9BJirw
   XoDrgqhRrPCKzn9Dv2W0/FhU2u1N3ALooaNDERSu2iA9BgqiUGRQryF0t
   Q==;
X-CSE-ConnectionGUID: B16OcrKuTyS1NSN1A8a+Sg==
X-CSE-MsgGUID: fxPJxNEaQDO7bytxPqN+Tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13667697"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13667697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 11:59:30 -0700
X-CSE-ConnectionGUID: Ls0Oy2B/TKuZDbFHzK3W6g==
X-CSE-MsgGUID: I5fVFwFxQSCb9sfhisrH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="39948824"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 11:59:30 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 11:59:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 11:59:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 11:59:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/mv7VGl3Rau5a+QMd0jt6JsegQQ4O/LQt4r6NZShOeEOaJJxy3b9jfZYsUuZPeD/qT6IUGuLCvIFyrEUHRxiLGfC0khRP4V1r0/PwPb2LSP8f7BOBO/xp088oS6WeJEe8K0pnxwmdhYG5Y/FTZvs/4oTYJaxhuRKy+CST9OMb6onj893yAPgimJMgPjUw23RCKro5WHtYUGJyPvy7f3gp1mbC2ySCXIpRjEgnepcxHeHTcdWij+afGBXN5I1WWs0y71b7BqDcmyiqYWXW24sJoWYuTCzVDlLQiNdrv+zqCf1qsvogyEDSEoldNI+qzHQv/U+pYGLYozfj87oiDGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni0xeV1FcMFj/sQWsv67Pr1M8y3Hra4dJ1Fq8oE7V4k=;
 b=VcSsdNdlJ4ChAbIXhY1daR9Yzra/C22qOIRAziEiEBPnUACflnWgUXN2lASJEW5datHV2naleK1azUO4TyfxzgAa6/ctkYVymyjwdhWL9HlOoNrb1hNf557O7kaXbeIpcc9ZiC1LLM50kvbJx4gqa0GMXFmobCVBO8ArXWzVY9vGAOr1vAhz1TZohbH59wOHZC92Ce0c69b5YoUHXtScbL7tgv2uyi0NCP8wzsncWx2quZIybax7JDx+vu9iLrA+GMoTlH2SW65M7xlqmRDzQwwFm/0Jmu9o85ayNtz4WW74URqY+V6XeedLd7nEJ1Va0FY3ocKx+xKXT9+XERNFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MW4PR11MB6811.namprd11.prod.outlook.com (2603:10b6:303:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 29 May
 2024 18:59:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 18:59:27 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, LKML <linux-kernel@vger.kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Raj, Ashok" <ashok.raj@intel.com>, "Schofield, Alison"
	<alison.schofield@intel.com>
Subject: RE: [PATCH] x86/cpu/intel: Drop stray FAM6 check with new Intel CPU
 model defines
Thread-Topic: [PATCH] x86/cpu/intel: Drop stray FAM6 check with new Intel CPU
 model defines
Thread-Index: AQHasfcfmFp/K3S7oEGEFw0SzFZmnbGuiy0AgAAFP9A=
Date: Wed, 29 May 2024 18:59:27 +0000
Message-ID: <SJ1PR11MB608327E76C4C90EAA3452D76FCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240529183605.17520-1-andrew.cooper3@citrix.com>
 <8ef9d8ad-9236-4254-b819-50832cd05cd9@intel.com>
In-Reply-To: <8ef9d8ad-9236-4254-b819-50832cd05cd9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MW4PR11MB6811:EE_
x-ms-office365-filtering-correlation-id: d5257527-a0e5-41e0-f086-08dc801176dc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OFZpeEtCRndTcGs1ZVJHMmVLYzk0TFFMU29xUWlrMkdtZk4xVndPRElsazBT?=
 =?utf-8?B?aUFQUFFiNkRQb1VZRVZ5UDZFM3d6eXlER0U3WFIyV1JqQ3c5bDF6Y0RQU0JG?=
 =?utf-8?B?eEczSVl4dm9xSHZrZHYzYVVDMjZBUTVQSUdZelJHeHA3aHdzSmFhVVV1dVJl?=
 =?utf-8?B?Ri9YTjB4aDFrT05FOFRPMDNaZlVxTldORnZkQ3RlWUVBaDN0UmZVMktndDcr?=
 =?utf-8?B?MGJQMCs1eWhzeThEV0JPemlxYUNsNHpKWm50ZWNvejFKOEFxNnM2cDJpSlZU?=
 =?utf-8?B?RFFQVnB6M1NYZG82bmdvc2lWV0lGZkt6b1dRcEN3ZzdhZnNFcnhpWHROT1lm?=
 =?utf-8?B?REI1RS9qUDQycFZPWitBN2Y4R1FBTzlmWHZaQ0RpWHhVZ2FXaGNJMGpnaVhY?=
 =?utf-8?B?bkxQbzZBR3VHMjlpOUprWkJkOWpJL2xONVdsTXZXaDE1cFVvK1hsQ2NtMm5H?=
 =?utf-8?B?YWpNd0R3VWFqWTJEQkJoRUxXVUIxSVluVjdMQzhGeHVHTlJJNlllaDg3K1E3?=
 =?utf-8?B?WUxpQWw1cFJDZXhyaWhGdkdIQXMzTDhNVk1RNVh6RGJhUUZhYlZURTNScndk?=
 =?utf-8?B?MHlnTURZWDhNazJmSUZGN01FNHQ3ekdLalU2MVFkMHhCUzNHZFpTS1BhUUVz?=
 =?utf-8?B?WDhOeEV2MUhQWVFUMTFDT2N1cGw4akNkUCsrd1g3dXNNOHdkdTlIOGYvR2d1?=
 =?utf-8?B?a2F1bFprN1RPR1NNRkcwenlhNzZ6U3RicnhPdFR4TkxhcERPS3Q4ZWxBM0t2?=
 =?utf-8?B?eXlZZUZKNm9RTUErTFBjYTl0cHYzZ2g1S1ZsajN4ZTh1MWFBd3NHSG1OT2tD?=
 =?utf-8?B?WEZzNUkzWUtWZ1hDS21oem9mZVBKSmw0YUkyaFJBVDY3SG82R0JobEpDQVov?=
 =?utf-8?B?RHRqN2FNREwzSVQvMjAvZ1BjazhjMElXaHlodElXMGNIWXNoM1F6SU85U3NH?=
 =?utf-8?B?aExLdStHd2t1ZjBSMm9YRWNZVFVDRHBiOTlIaVdtaUhGWWV5SkJjZjlnVEFH?=
 =?utf-8?B?NSt4WXpHTFRGdThiZFp5T3A3cjAyaDhIWTNyYnlKbVRMaEhvNXZGVDc3S2JH?=
 =?utf-8?B?TUl1UUowazNFZE1GSkZyZnNTM0hTTmZyamdXKzQ5cHlvQlo4WHFpNVNyeGZK?=
 =?utf-8?B?a3pGQUdvNGN3SkxIeXlXT3B4aE9aeEUyL2U1TlU0MlRqVEhDcUZRTU1hZFZM?=
 =?utf-8?B?LzFRbGE3TEwwQ250Q1NTUGZFWERqdmxzdzl1N1dvMC9HZlR3U09tR0paV0Ur?=
 =?utf-8?B?b3hkQ0x6NVVkckNaTEs2OHlibTY5TTRUSkFEVVZUSC80Z1JsbitZQzFmOFA3?=
 =?utf-8?B?aHJCa2Z3eWRZeVM3clNONlAwMGRaNzRPc0lXdDJqZHlQcGNMOFpEck92Y2hr?=
 =?utf-8?B?TlAwZUJJbzdlM29ZS3gvcFhHaGJQVFJoV2RwQjkvUnpKWDMxNlJ3cnJkODNn?=
 =?utf-8?B?emtlUUV1OWJaZWJENEJLV1BtTEhXZHBjcU1zUmJRQXJtV01HMTBrUlhmVXd6?=
 =?utf-8?B?T014MlIzRHBuN2tnc2tqL0VlN3BhK2haRkdWbXBEbWVpZ1ZqRHJDSDJWNWtw?=
 =?utf-8?B?UmM3bEJiMWZIcktpcG56Smh1MTFWQlpNMDdxTVVlVFM4bTg5eG5CdHhQbnlt?=
 =?utf-8?B?WkdvcTFTMk82QjdrbG9rbUF6R0R2ckN1alMzSjV6MEZJV3RudUxBQnA0ZDdR?=
 =?utf-8?B?SmFpZ3RuaXNTQ2ZqaW9Wdks1cDFKK3pleXJQKy9mR0p2enovMWRXYmU3cE5H?=
 =?utf-8?B?bmpxWVFBb1VwZFkwMFQrSTNIa1hsVG1CNnpJQ2t1eW94ZE1NQWNXWTdqMXVu?=
 =?utf-8?B?aHJCcS9JSGFKZDVPWU5XQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmxWRSszL09KTTY1WEg1WUFTVkpWUE5nam96cURPWnA0NjdsOCtnVjQvMExT?=
 =?utf-8?B?L0c2YXJaSVMxeDlNNzFNUHNOOU4wcVFBTmlKNEZldWJVQWQ3dFVuTVdFZ3Zh?=
 =?utf-8?B?M0VIdE9tRjJRdDVkdmFyOXY4T29SbHZpaTFpS3VIV2pVbGhmWVhidWQ3SmxH?=
 =?utf-8?B?WG1mSFR5dUwvY1lqU0tkQS8yNUZoMFV3M3VTRlBVUi9xU2NEN0hCUDF5ZExy?=
 =?utf-8?B?OFUvdHVBWWx4RkJkOVE3T3lpd2FVYmY1T3NMOHgvMDZzaXQ4dW9lMm1PcThM?=
 =?utf-8?B?aVNPNzNDMEs3enpnSnZwdjExMUlNV2pMQkxSYUxBdHkySHFPczBZeGZFd0xy?=
 =?utf-8?B?T21Zc1RMWlIvUm5LUHkwVERjRDBDRlN6aVZzVUVFcmFLMkt5MlpwTHpQcTNB?=
 =?utf-8?B?a0pxLzBOSFJCSUIwQ1d6Y05zdTVIZEtyUTQyTFRKNUtGRzlVMmRvLy9SVnRm?=
 =?utf-8?B?U2p5eS9EaDZEOXpDVC81UEtkWExrcXRsN1ZzR0pVUGM1SlpMa2FHdWJkSGNw?=
 =?utf-8?B?NWR0SEV2T1haZy9DM09wc2hwamNqTldkVXZoQ0NWOWRocVh5ZXpMUVMwc1lV?=
 =?utf-8?B?ZWdYMi9kVHpZS3ZJaUp0UE1JQVo4MkpDdlppZGpEWGpKVENqTGplWlVrSDVE?=
 =?utf-8?B?d2t6WkVScG1tZkhsT0xLMmJsWDA2Q2tEMlcvSlVYbGdVMXNzZVBRUXR0VUpj?=
 =?utf-8?B?U2VFbklXSkdNQ01CQnk0UmVta0lSMTVjMlFJaCt4VTJxMFBFVGVHNk8wN1JX?=
 =?utf-8?B?cm1qN0VNRE1RRk5HcWR0SjN1ZEZIR2ZVMEUrbjFpS1gyVURmVGZuVzR4WlFV?=
 =?utf-8?B?Tnk3YitkRFlaNldweFl2NWlxQnVlbWJrRE5LUjFIU1BGNytWRGM5OHBDT3Rp?=
 =?utf-8?B?OVJqSENpU2pNVk1KRThtcEM4OXN0Z1NLYzl3Tno3ZktOU0xSMmg0QUZUQXgv?=
 =?utf-8?B?ZGlKZTA4SWE2eUtmaE5BWEJWdW5qTmoxa3o1eHZsbjVEd2RlSHcvVzZ1WTV3?=
 =?utf-8?B?VFdWZzNXbWE2TnVObzlTMjJnZjdpa0l3c0VjUEpjdVN1L0hNUkorK0RINWU1?=
 =?utf-8?B?TitQeWM1SExvZWJlcnpmQ2NVbVhuODFFdmJwcUtwQTZFcjZsWE5PdHRnZXBF?=
 =?utf-8?B?NDROVTkvRXUxbitaVWFQdnJuY3Yzc3BxUHllWVB4cDFaUmkyNDBmQ09BeUZ4?=
 =?utf-8?B?elBIWjVPcU1MS0o4cXhoM2JjOVNtQUVFdm45bEg0NEtSakdaVzc2bVhBZU1s?=
 =?utf-8?B?bk01WmFNVGxRdnpiVDdPRGRicXpNUklxa3E4RnFwclpSb2g0YThyUTJxeFVV?=
 =?utf-8?B?aGJmUG5mY094QUhIb2ZiV3IwR1BWcmtFWGh0MWdpdlRWVWJXV2NEV3RsSWIr?=
 =?utf-8?B?djZ1QlhKOWZ1cy9aQzFqTFpjcG1rZDRicVhvL241UEdFRlBENmJEVnk4bjl2?=
 =?utf-8?B?ZDI1YWtUb1hEZ3MwVDJBbFlXMWthdUlpamMwamVBTDJWQitIcFJQT3FSbGdq?=
 =?utf-8?B?eHJsMjBua09YTlVQR1BtaDRBMkZhK3h0VUdZK1BLRnVqd1VWVk5vaTRMcUpI?=
 =?utf-8?B?bnRqR1JxYU81cHY0bU02TlEwK1oxUUMxUldGTWd2UjJpT2JIeVVuQndVU1dH?=
 =?utf-8?B?TTBLa3IybFdHZVBrWHBUYzZyZjF3cGs3WjFBMmdrYWNyaVpvL08zcVBRcmpJ?=
 =?utf-8?B?Qi9WUEpjc0hpa3o1a09LTHc1NUxuZ3prbVEwejBtQ3NsNmNrNkIyKzF5WHRt?=
 =?utf-8?B?VGc1a0xHV0xMY0ZRQUl2Tk82cU5xd0dMM3NPS2prY0NWYVo1VzhsWmJsbDkv?=
 =?utf-8?B?Qnl1ZWEvSHdVckFWS255U2tPMjRGeUl6NHJicTVyNEFSSU9VckU1cHFKck5r?=
 =?utf-8?B?bzJzUEVrSlk4Mm9SN040cnFwVDEvRGM1Vi8zNFhwKzlaaGgrVUVQMlVwUFp6?=
 =?utf-8?B?eFp1cDVKY3V2cEJyTzhVb1FZeDFqWTVhMm5KUFdGVmJtTmVNWklMaXZSby90?=
 =?utf-8?B?N3dnL2FpNHl0RklaWThaSlUvWjc1Y2lraDFpSjRxSXY4YWUyano4L0o5YTU1?=
 =?utf-8?B?WmlMMFpER3ZaT2tsdjZvMVZsK0hGeEI1V29uWlZMS1VOazFGWVBvM3hBc3h4?=
 =?utf-8?Q?1U/ZzjlhkwZnjIpsGCErAku4S?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5257527-a0e5-41e0-f086-08dc801176dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 18:59:27.6659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Z8wqrgeziy1dOZGpyOkpdQ9KqTReXK4TbLl4T2AkdZ7GmwzS+xlKBjQXB1zI8ikiKGku1/eUmyQz+OK59z2tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6811
X-OriginatorOrg: intel.com

Pj4gVGhlIG91dGVyIGlmICgpIHNob3VsZCBoYXZlIGJlZW4gZHJvcHBlZCB3aGVuIHN3aXRjaGlu
ZyB0byBjLT54ODZfdmZtLg0KPg0KPiBGV0lXLCB3ZSBhcmUgZ29pbmcgdG8gbmVlZCB0byBkbyBh
IHBhc3Mgb3ZlciBhbGwgb2YgYXJjaC94ODYgbG9va2luZyBmb3INCj4gdGhlc2UuICBJIHN1c3Bl
Y3QgbWFueSBvZiB0aGUgJ2lmIChjLT54ODYgPT0gLi4uKSAnIGNoZWNrcyBjYW4gZ28gYXdheQ0K
PiBsaWtlIHRoaXMgb25lLg0KPg0KPiBUaGFua3MgZm9yIGZpbmRpbmcgdGhpcyBvbmUsIHRob3Vn
aCENCg0KWXVwLg0KDQpBY2tlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50ZWwuY29tPg0K
DQo=

