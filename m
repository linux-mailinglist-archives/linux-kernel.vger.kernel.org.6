Return-Path: <linux-kernel+bounces-346714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA7C98C7CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B4E1F23DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A21CDFD3;
	Tue,  1 Oct 2024 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMCk8jlJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25956199FCE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727819610; cv=fail; b=L94eHhBLJMJ++/fSkxRgbe6S802aSGetLwTFZy24S50uaXZsF10pi0EYfNXYy967++bQALL8e9JqoCl+GTltM00OXlv1JXGxIg6/Te+ep0q1WnsyhiSCllQU2Zs2T2M/aC47kr85GLnb8Bky9prvFtQ7FiTBmDOO0qXeMuCEvDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727819610; c=relaxed/simple;
	bh=9g6Cm315XZ0/82ZPsiIFriGZQ/i+0wo71vLJ2xjhxCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/NWGpbk2539Zbfs0eAjs9cJzRHtD4czTl+NfCc6lZRGZOsdJ0sluO4kXfheOGrGwG6ZT8KsFGCe1xwErrqvIJAMQmMGyF6jQ6S/hsMP/NmQ4WiwF+bXnw1Jl+YZEhjiA+0dhUMmTFX6ROObzaCSDDnW59WZINREIiTTxQwl6ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMCk8jlJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727819609; x=1759355609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9g6Cm315XZ0/82ZPsiIFriGZQ/i+0wo71vLJ2xjhxCA=;
  b=JMCk8jlJ21qEMYFP0eadB1GaINUbuxTn8dlgFMCM9x2ZaVaE9svkYIQC
   a4Z9z/YIujZBOKa7c+mnVSLm4A3OEyLmyDb+W482p0E/3/8EgnbW9hStD
   Nfod09fw4md7dEXsHH4MQUCD1gJawmK3j5+ck+33VSFq5h83nvnAtI6CP
   fv8ArE0j+R9JqMVcOuCPsnJ6mmz9piQTpfstyTpMO8qTlLabtmcn806cK
   Y1m8U1BeqGN5bgggc279gvDPQph+1KvHsy8mrbNBJY6HUkussQFEnSA54
   tXP2/wnIZi2Q7G+yy1SBS6sf9YdjAKm+6gpX+l9sgwh5tDQqpVh1PI0wL
   Q==;
X-CSE-ConnectionGUID: YPv0CeVKQwKJuFvdxUuKMw==
X-CSE-MsgGUID: QnvcRsE5TtCRtg7ymZQA/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38108059"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="38108059"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 14:53:28 -0700
X-CSE-ConnectionGUID: kMcQRcmZS72OQq9h4SsILA==
X-CSE-MsgGUID: JjKqM2VtS5mboEJmx+MJ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78563161"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 14:53:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:53:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 14:53:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 14:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFQoc7fyMOe88yRnJSSEUlCLdmj4QHGTpwqzTWuyDBBJPDx3/CGlF6/qPIXreQc7et4x0fcrEBNiO4p3XACKyvVHB6+bDoXN1HBMMlEcWN3Ce9ewrgt/HhdJC76zORyNst1NGtfi7oIcIugdLV3TIWtBqoNBr1NYkji/tpSZHjaUi1P3ggx2KfzYA7C1EHiFkusX+k12RRZqixOlirA3J30LBdYcBuIoXZWtE8b402rifC+PScfY5vz90r3Emi6NApadhecZcoMQwXAAQ3SDFAvpvLGdosCVL3e73KY6SRqHSrcf02OedpFxdgz2jactZfu/dVt9odtIQGpiES32MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9g6Cm315XZ0/82ZPsiIFriGZQ/i+0wo71vLJ2xjhxCA=;
 b=hxYSQ7m7q+9WxIqXxy6u/cIUK9Sk0BvZwA6tzon5+ECFBVRM1P5wp7wyT4iscG/Wi6a7bTTjNAJezGw/7XzQur5EpxtlfagNGFs/OIPHNWsKN/Y1t6+VRCc5iz8YDTSPGeJBwOx7BwrCZnoMxnfoE23DG2oH6BgbLhPJ2YFFNTcNtM/ZxMzY3LjDHmtzODiLJdQ33VWQIAChrQ6j61xgb+krJ2zsYU7mnODIENeg7ii7P6whDknvLnvWoQgTz0RnG56/Gy+VifMcegw/vgFKs6zx6TjuZUk6O36I9oKhFzBZRNe+LvBeri4KrfGEfpc2Bsrl2fEn1QAU2UH8dcB5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 21:53:23 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 21:53:22 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Index: AQHbE4XaXdnmYogniUi9EO2aNKPUnLJw9HoAgAAUeVCAAF5igIAAt03ggAABbACAAAF8AIAAR1yA
Date: Tue, 1 Oct 2024 21:53:22 +0000
Message-ID: <SJ0PR11MB5678A1858237FBC0DF7A0098C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
 <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com>
 <SJ0PR11MB567885FD8899DA83FB95DE61C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZk=9Su3vtdFcghD0R+GqSchn5b1L91SgTvxcX79rmdOA@mail.gmail.com>
 <SJ0PR11MB56786A297C3D8DCADC2EF310C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56786A297C3D8DCADC2EF310C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB6468:EE_
x-ms-office365-filtering-correlation-id: 7222f21b-5b74-4871-853e-08dce2637854
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OENXNEtBYWJIamVuNTlTWkNGczM1UjJMY3NvNFJacjZEZCszWGdKcWdPWTI5?=
 =?utf-8?B?SFJobjZSM25OUGk5WUFTRjgxemI2bWRKbDJpeStkZGE3d3F2VDU2MDc0ZFNS?=
 =?utf-8?B?aHROVHpwU1pEQUtXNC9YaG1Td1Nja2ZSaEpRYTkrc2JlVUNEQi8zeTROcXFD?=
 =?utf-8?B?S3RlWUVpaHFuZU50TkY3ZFdzUVR2UkYweU1ONnN4VTRCaVVFK2ZCQzAvVnpl?=
 =?utf-8?B?NmQ2WXJWdTdFd1A4V1h0bUZRNUJLckhZU3NBcjNqaGtKOFkvUVpsNDIweExG?=
 =?utf-8?B?TmtMTERMcEFwaTh5SWtZODZ2SHBMTFNNZDFYSmlqbGlGQVRFMTBmeEJzVDJS?=
 =?utf-8?B?bXZQK3d3YWJ2emtFY0dyVFB6Q0JxaWdUbCt1elc3WkxkU1BrakgxbUZud2Fz?=
 =?utf-8?B?V3hwVGhsNEhxblBYUmZNTG5ORmkwNnVxajVWbXBIbEV5Y05seHJDTW93QWd3?=
 =?utf-8?B?MHFiWXEyRi9uUjZ3emxodGIraFRCNU5QNmloZXhhY2VFQnVWMWx3Yk5rVEpH?=
 =?utf-8?B?RURuV3o5V3VWVHFBamc5YnEwaWlFeE4xcEk4emEzNGxtdkdMQ3RKbnBmUFFB?=
 =?utf-8?B?dUQxMW84bEhsSFJRZzhJbzNMY29MS1oxb2pzY3I2KzlPWXZFNXNjcGt6Q3No?=
 =?utf-8?B?VHlRK0JFaW02SUQ3SE41eGpnRkFHWFJPZng0WEIyNUhscTZYTjdWZmlhMEVQ?=
 =?utf-8?B?bWVzODVXSHNqbGU0N1hTVWFhcy9FTjFtUzlYcW9sTUZ1VG5Ebkpzd0lpUW1K?=
 =?utf-8?B?LzdVYjZQeW9rTThaM0paRG9qemx5REFWQWFXWFhVZmRCSGxheDZzeE5RKzdO?=
 =?utf-8?B?MjVHN21IcTBpWjlGU3ZOMFNSSHlDZ1hJUlRlVVhzZHk3QVdJUkRDNVZ6eUt2?=
 =?utf-8?B?TWpLMTJWcGVBZWhNVE9uVFpQSktlUElZQW4vSnFTeUFUTDgrNU1mNjRiL2pX?=
 =?utf-8?B?dEdlbU1wUDJxMU5XSStYQ2Z6NmdzZG9Bck9ONEVsdXE4bEswK2QxS1lwbFR6?=
 =?utf-8?B?UkhXakx3YUdDTllzR3lueW5iYTJpeEVCTlBRekdGTFZtTlcwMk85SkZSb1Vi?=
 =?utf-8?B?RFZJNU0vWjhXYktJZHl4VGs2SFFLYks1ZlVuTTRGT25FcytkQ0hXdUdwVExy?=
 =?utf-8?B?Umg2STA0MnhFOWV5RXAyUVk4WmxPbzB0V2pLNGs1UnVEMWVwaXBPYjdwOXF0?=
 =?utf-8?B?ZTcxbTNhRXE1cVEvZjdBS1MvSmpPVmhKOGo5NDVGMWorUE45SFlLbHBUc2dV?=
 =?utf-8?B?RDdEc2pIaFNwaW1GcSt1R3RndFVIQ05BR1JEbzFzTUVkWXM0Y2xVeGRqTnVp?=
 =?utf-8?B?S0xPQkJYR0VidnoyNU52U0hYUk16UWxqbVI3QS9GYkw0UWNqWC8rRUFKOWRJ?=
 =?utf-8?B?eUd6TUV5dGNoSWhNTEJyN2l3TTU2aDZUckpkRndDRGdKdDlKemJndTVFeWtV?=
 =?utf-8?B?bWwrOHNtY0VJR1kyNmJoSEpJaUNQZnhoY0tibzhZUmkxZDRndXp1Rmx6ZW53?=
 =?utf-8?B?TlY1Q0hwWjlkd0tGNGUrN0pHcTQvTTg3YjJ6UVFMSDk4K3hrazR5eW1CNmFx?=
 =?utf-8?B?dHpud0phMDl5Q2dFczEwVGorUVRPVldQalNvVFl4U092TTBUQ21GNHZqa0tS?=
 =?utf-8?B?b0F0TGd0eDdpcmkxYk91VFlxVURNQWU0MnBna0thN0hQbUt0TWJBY2FLYlNF?=
 =?utf-8?B?Y3RabWcwODBoazFOR0tyMGp6Sk50MHI4RU9YZXQ2QXQwWDE4NnhxTllmU2gy?=
 =?utf-8?B?MEY5VTc4TDBYOVB5Q25OL2czbEc1c2VZNHdLRCtiZkFBTUdYc01HYkszT1Qw?=
 =?utf-8?B?bjBHbjR3c04vaW15TjVUKzBlbGd0aWFZTVkxb01GOWVJNWI3Y0Ryd0phemoz?=
 =?utf-8?B?L2xWK0tHSVEyZjZoNU1GSkNGZCtJajdWS2pOZGtSTU9LQlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y01kMW1vMnh3RzNEaEp0VG5sbnZDd0VIWnlnNWF2VlZTaXpqMWliYmRHQitW?=
 =?utf-8?B?eHVBTnJ6YndtVFlPdC9UWjgzZ3NWMzBhdWJLM1BCSzRZR0hkQ0xuS2JESXF6?=
 =?utf-8?B?U1BFbUhpUUVEdGpRUVhVS2hoSFlZaGh4RThWaWliakxaTFR2TmJxTTNpNExY?=
 =?utf-8?B?d0xiSnBtSEgvZEJBS3EzL0Y3UDNaTmRRZnYyb3BPVlpBUTJqOUg3TmprRzMz?=
 =?utf-8?B?VmUzN2NyRFp6YTM3S2lFZnB0cWFhTG0vSVVsRkZpTUd3ZmZBN0FmU1h2bk4x?=
 =?utf-8?B?QnI4QUQ0STRMT1hLR09rc1VhTHlaNHR0NURBYVVFSEpWZjFzWHRmRXNER0Ir?=
 =?utf-8?B?eTB5dkJVNngrcmtBNlNvV0NuOEZoYUlmK2JNbnAwNGdKb2JrVFpVNk9hWWRa?=
 =?utf-8?B?VHRGcTJ3bmZ3bEp6S0lzQUpmbWZnNTNRNlZlRnVyNjlRd1RON3lKOWIxODVx?=
 =?utf-8?B?YldFcnUrZ0ltN3NDR3ZLK1A5THRwOURFbk91S1VXS0krV0h4OTNROC9tc2ZV?=
 =?utf-8?B?SzlVNm8yM05UU0dJMEYzV1lNRFdraEI1d2oxd2xzQVdMVGNTcW9adUdLMmk1?=
 =?utf-8?B?SzZ2bGg5SXM5bG11MEdPQjlYYm5DRTBaditHeUhhdm5FWkdKVm5WWWp0STRZ?=
 =?utf-8?B?dWNwS1crdlN4emIrRytObzRBa0JXTDVJc2JuU1k5d0ExSk5jbXQwNHUrY3hs?=
 =?utf-8?B?dFJ3enB5THJPVis1S2k5bDJBVERnWm1YNnM0ODFIeXRqemV4dHloWkltVktW?=
 =?utf-8?B?dEd1LzY5b3ZoSUF3aCtJYWlRMlZLclBLZDFMeVVoMDFQZkRuYW9hMmFmeGJR?=
 =?utf-8?B?WGtnVElyU3RNWSt3cURUVnJGN1ZNT0FFRUdqUVNmdGsyaW85OXNuVWx1NTRa?=
 =?utf-8?B?U2dkSTczbnc1UFBRR1MweUJtaHJ4bEFXalpTVmZaQW5oMEVxSWgxL2NLYlc1?=
 =?utf-8?B?RjJMZ0dldVpFNXBOQzlnNlFjMkxkMU54YXRVZURnWllHWXZJUEROYko5K0Z1?=
 =?utf-8?B?RFoyK2VGU1EzeVVDbWszUi85aC96VnY1S1dyOWs1cVlISFY0d2hmcCt4RjJ6?=
 =?utf-8?B?YU5heTFZeTlUaHF6WmVpMDlaUVVvVnVLTmljbDBHeGVqSXJIdXF6WnFLUUpS?=
 =?utf-8?B?dXlWeVBQNy9YNWZjdGZQYUc4OXRFellMZ0Z5emVWV3ZUQ2JaY0NrcVhycnlD?=
 =?utf-8?B?Nkp4YTcrck5JVGJHZ3dkV1VGUkRCL0dmQU11S1BTSm4wbTFUOVJwdkFxYUhp?=
 =?utf-8?B?b29zQ2R0ZFFtZmQzWmxPTE9LTlNnZ0o1M2FqcE00cGFmbHNadnVjRW1HZFVv?=
 =?utf-8?B?S3dzaFVXd0ZiLzErTUVMZVIrMjNCVzRGTVljS2pjbUtmQUlnWE5aYWkzTjhk?=
 =?utf-8?B?My9RSWR1V1JYRTkyeDR6aUxLQXJsbmkxOFVHc2RHdU85eVFTUWpGWmkvbmNZ?=
 =?utf-8?B?OTF2R3Y4aCtPYXg0ak5GNFVmcklGU1FGMGNZM0dNQ2RMMjgzL1l2UUJsR3E4?=
 =?utf-8?B?Rm5Ib013OW0vdWV5Lyt2cWdOaFpmakJJV0thbGFaTjFNUkc2bUI1S1huUGNC?=
 =?utf-8?B?Y2UyZEJTQWxMdzhHTWtnUTQ0VnIwOE1jMXBzS205MnhWRURLQkZTcnh3WjZz?=
 =?utf-8?B?WVg5amlyc0loS1d1QnRpV0huZ3VyMENjMFN1UlJHdVE4TUR2UVZSbmhGYytM?=
 =?utf-8?B?Q0kzSUhzWjg3alFZUG9uY0pCM3dsQllsell5cXZhazA3TGIvSUE2MzJZL2NN?=
 =?utf-8?B?SnpnOVR2WWRFdlI1eWV3WjkrZ3o0OE92RmdJaXhld0hNL1RSdjg1ekMvUlRi?=
 =?utf-8?B?Qmp6NGh2Z2l2RDJKbnRnMFBJY05PNnNkNW4yRW82aHBIWkkxa0JhbmozQ3Uy?=
 =?utf-8?B?eER4K3BadnJ4cEs1SHNZNjQzdk01Q2VBMTJoblJ6MjFlTkJzRnlvbTgvRThR?=
 =?utf-8?B?R3BjV0ovT1NMd1RJUFpLRW5aYjlFaFI0Qm1JU29CSThUUEI4QnRYNGU5bVFB?=
 =?utf-8?B?Tk90SzU5aDVEakFrZCtiQU5PRWo4UkcrRm5BZ005UGNuMThzRVgxYnA1eDJ1?=
 =?utf-8?B?Y0gwNHFjWUU5NWNmNENSTkZ3dW9CVndPQmd5UHhQeWpuZ2ZJNnBNbjNYVUNk?=
 =?utf-8?B?SjJlN3B5MmdDekdjY2FRMHhQUVQ4a2ovZHRleDNsT3lONHVCNWFhL3NRN1kx?=
 =?utf-8?B?WkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7222f21b-5b74-4871-853e-08dce2637854
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 21:53:22.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSnFz03erLq0TJGJmWTgoT8Mic1WSzHWdqFUPv55LqSi4NCAWaKBOsKUu47ZlxVGTcUX7b4Y5PSRw++5bG8MCCSAq11HE++35IbjKOQ8RsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTcmlkaGFyLCBLYW5jaGFuYSBQ
IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVy
IDEsIDIwMjQgMTA6MDkgQU0NCj4gVG86IFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5j
b20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5v
cmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWluZy56
aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0QGxp
bnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5n
QGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9u
Lm9yZzsgd2lsbHlAaW5mcmFkZWFkLm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwu
Y29tPjsNCj4gRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdv
cGFsLCBWaW5vZGgNCj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+OyBTcmlkaGFyLCBLYW5jaGFu
YSBQDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIHY5IDYvN10gbW06IHpzd2FwOiBTdXBwb3J0IGxhcmdlIGZvbGlvcyBpbiB6c3dhcF9zdG9y
ZSgpLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFlvc3J5
IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgT2N0b2Jl
ciAxLCAyMDI0IDEwOjAxIEFNDQo+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5h
LnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsNCj4gPiBoYW5uZXNAY21weGNoZy5vcmc7IG5waGFtY3NA
Z21haWwuY29tOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+ID4gdXNhbWFhcmlmNjQyQGdt
YWlsLmNvbTsgc2hha2VlbC5idXR0QGxpbnV4LmRldjsNCj4gcnlhbi5yb2JlcnRzQGFybS5jb207
DQo+ID4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5j
b207IGFrcG1AbGludXgtDQo+ID4gZm91bmRhdGlvbi5vcmc7IHdpbGx5QGluZnJhZGVhZC5vcmc7
IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47DQo+ID4gRmVnaGFsaSwgV2FqZGkg
SyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGgNCj4gPiA8dmlub2Ro
LmdvcGFsQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDYvN10gbW06IHpz
d2FwOiBTdXBwb3J0IGxhcmdlIGZvbGlvcyBpbg0KPiB6c3dhcF9zdG9yZSgpLg0KPiA+DQo+ID4g
T24gVHVlLCBPY3QgMSwgMjAyNCBhdCA5OjU44oCvQU0gU3JpZGhhciwgS2FuY2hhbmEgUA0KPiA+
IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+ID4gPiA+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDMwLCAy
MDI0IDExOjAwIFBNDQo+ID4gPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5w
LnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gPiBoYW5uZXNAY21weGNoZy5vcmc7IG5w
aGFtY3NAZ21haWwuY29tOw0KPiA+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsNCj4gPiA+ID4g
dXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0QGxpbnV4LmRldjsNCj4gPiByeWFu
LnJvYmVydHNAYXJtLmNvbTsNCj4gPiA+ID4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwu
Y29tPjsgMjFjbmJhb0BnbWFpbC5jb207DQo+IGFrcG1AbGludXgtDQo+ID4gPiA+IGZvdW5kYXRp
b24ub3JnOyB3aWxseUBpbmZyYWRlYWQub3JnOyBab3UsIE5hbmhhaQ0KPiA+IDxuYW5oYWkuem91
QGludGVsLmNvbT47DQo+ID4gPiA+IEZlZ2hhbGksIFdhamRpIEsgPHdhamRpLmsuZmVnaGFsaUBp
bnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+ID4gPiA+IDx2aW5vZGguZ29wYWxAaW50ZWwuY29t
Pg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDYvN10gbW06IHpzd2FwOiBTdXBwb3J0
IGxhcmdlIGZvbGlvcyBpbg0KPiA+IHpzd2FwX3N0b3JlKCkuDQo+ID4gPiA+DQo+ID4gPiA+IFsu
Ll0NCj4gPiA+ID4gPiA+ID4gIHN0b3JlX2ZhaWxlZDoNCj4gPiA+ID4gPiA+ID4gICAgICAgICB6
cG9vbF9mcmVlKGVudHJ5LT5wb29sLT56cG9vbCwgZW50cnktPmhhbmRsZSk7DQo+ID4gPiA+ID4g
PiA+IC1wdXRfcG9vbDoNCj4gPiA+ID4gPiA+ID4gLSAgICAgICB6c3dhcF9wb29sX3B1dChlbnRy
eS0+cG9vbCk7DQo+ID4gPiA+ID4gPiA+IC1mcmVlcGFnZToNCj4gPiA+ID4gPiA+ID4gK3B1dF9w
b29sX29iamNnOg0KPiA+ID4gPiA+ID4gPiArICAgICAgIHpzd2FwX3Bvb2xfcHV0KHBvb2wpOw0K
PiA+ID4gPiA+ID4gPiArICAgICAgIG9ial9jZ3JvdXBfcHV0KG9iamNnKTsNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBJIHRoaW5rIGlmIHdlIHJlb3JkZXIgdGhlIGZ1bmN0aW9uIHdlIGNhbiBk
cm9wIHRoZXNlIGNhbGxzLCBtYWtlIHRoZQ0KPiA+ID4gPiA+ID4gY29tbWVudHMgcG9zaXRpb25l
ZCBhIGJpdCBiZXR0ZXIsIGFuZCBjZW50cmFsaXplIHRoZSBlbnRyeQ0KPiA+ID4gPiA+ID4gaW5p
dGlhbGl6YXRpb25zLiBJIGFtIGFsc28gbm90IGEgZmFuIG9mIHBhc3NpbmcgYSBzZW1pLWluaXRp
YWxpemVkDQo+ID4gPiA+ID4gPiBlbnRyeSB0byB6c3dhcF9jb21wcmVzcygpIHRvIGdldCB0aGUg
cG9vbCBwb2ludGVyLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IERvZXMgdGhlIGZvbGxvd2lu
ZyBkaWZmIGltcHJvdmUgdGhpbmdzIG9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nPw0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gV2Ugc2hvdWxkbuKAmXQgYmUgYWRkaW5nIHRoZSBlbnRyeSB0byB0aGUgeGFy
cmF5IGJlZm9yZSBpbml0aWFsaXppbmcgaXRzDQo+IHBvb2wNCj4gPiA+ID4gPiBhbmQgb2JqY2cs
IHJpZ2h0PyBQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBhbSBtaXN1bmRlcnN0YW5kaW5nIHdoYXQN
Cj4gPiB5b3UncmUNCj4gPiA+ID4gPiBwcm9wb3NpbmcgaW4gdGhlIGRpZmYuDQo+ID4gPiA+DQo+
ID4gPiA+IEl0IHNob3VsZCBiZSBzYWZlLiBXZSBhbHJlYWR5IGluaXRpYWxpemUgZW50cnktPmxy
dSBhZnRlciB3ZSBpbnNlcnQNCj4gPiA+ID4gdGhlIGVudHJ5IGluIHRoZSB0cmVlLiBTZWUgdGhl
IGNvbW1lbnQgYWJvdmUgdGhlIGNhbGwgdG8NCj4gPiA+ID4genN3YXBfbHJ1X2FkZCgpLiBCYXNp
Y2FsbHkgd2UgYXJlIHByb3RlY3RlZCBhZ2FpbnN0IGNvbmN1cnJlbnQNCj4gPiA+ID4gc3RvcmVz
L2xvYWRzIHRocm91Z2ggdGhlIGZvbGlvIGxvY2ssIGFuZCBhcmUgcHJvdGVjdGVkIGFnYWluc3QN
Cj4gPiA+ID4gd3JpdGViYWNrIGJlY2F1c2UgdGhlIGVudHJ5IGlzIG5vdCBvbiB0aGUgTFJVIHll
dC4NCj4gPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLCBZb3NyeS4gU2lu
Y2UgdGhpcyBpcyBhIGNoYW5nZSBpbiB0aGUgZW50cnkNCj4gPiA+IGluaXRpYWxpemF0aW9uIHdy
dCB0aGUgbWFpbmxpbmUsIGlzIGl0IE9rIGlmIHRoaXMgaXMgZG9uZSBpbiBhIGZvbGxvdy11cCBw
YXRjaD8NCj4gPg0KPiA+IFN1cmUuIFdlIGNhbiBkaXNjdXNzIGl0IHNlcGFyYXRlbHkuIERvIHlv
dSB3YW50IG1lIHRvIHNlbmQgYSBwYXRjaCBvcg0KPiA+IGRvIHlvdSBpbnRlbmQgdG8/DQo+IA0K
PiBUaGFua3MgWW9zcnkhIEkgd2lsbCBzZW5kIHRoZSBwYXRjaCBzZXBhcmF0ZWx5Lg0KDQpIaSBZ
b3NyeSwNCg0KSSBhbSBwcmVwYXJpbmcgdGhlIGZvbGxvdy11cCBwYXRjaCBzbyBJIGNhbiBzdWJt
aXQgaXQgb25jZSB0aGlzIHBhdGNoLXNlcmllcyBpcw0KbWVyZ2VkIHRvIG1tLXVuc3RhYmxlIChz
aW5jZSB0aGVzZSBjaGFuZ2VzIGhhdmUgZGVwZW5kZW5jaWVzIG9uIG15DQpleGlzdGluZyBwYXRj
aCkuDQoNCklzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdCB0aGF0IHRoZSBmb2xpbyBsb2NrIGFs
c28gcHJvdGVjdHMgYWdhaW5zdCBzd2Fwb2ZmDQpoYXBwZW5pbmcgaW4gYmV0d2VlbiBhZGRpdGlv
biBvZiB0aGUgZW50cnkgdG8gdGhlIHhhcnJheSBhbmQgaW5pdGlhbGl6aW5nIGl0cw0KbWVtYmVy
cywgd2hpY2ggd2lsbCBuZWVkIHRvIGJlIHZhbGlkIGZvcg0Kc3dhcG9mZiAtLT4gLi4uIC0+IGZy
ZWVfc3dhcF9zbG90KCkgLS0+IHpzd2FwX2ludmFsaWRhdGUoKSA/IFdvdWxkIGFwcHJlY2lhdGUN
Cml0IGlmIHlvdSBjYW4gY29uZmlybS4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0K

