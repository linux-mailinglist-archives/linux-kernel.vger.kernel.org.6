Return-Path: <linux-kernel+bounces-261548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D621F93B8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601ED1F218DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EDC13C9B8;
	Wed, 24 Jul 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7KGeQ6s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9F13C807;
	Wed, 24 Jul 2024 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857161; cv=fail; b=cWNg9V3nPLWzA6HiWad+hUDNNJ9oumCUHzp0fcR0N1UGsHIKJMzoVKtpzw+Alki+s/IixrL7oXsbnLDJ2A28tvAA/tDPs0QfV7liRH8Qig/sR2p1foRT+FB2xhIwllCzvM16zBrmGTBU14rlqBjJO08LBI6WSfHLicP95W0teYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857161; c=relaxed/simple;
	bh=XFomBCsIgPWooWcYSPnCIg35AV/cWpEK59KLQjfCO1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmDKrxwh0xq5Mv0y1SVszIK+SXAzKL6iRM7vNBIuGJhWQ/6xVWLRntbgMPhPtPN9WO1sFK0a0QIjLrO+OZwH/0kA1VfLpKN+9mXvAUJLO9Wd997r9Xl1Ju7/y7zLKRxM09ODKv11TF4cg9Qq35ObL4+Njgj510EVo/C2aDz9aJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7KGeQ6s; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721857160; x=1753393160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XFomBCsIgPWooWcYSPnCIg35AV/cWpEK59KLQjfCO1k=;
  b=H7KGeQ6si8BMWMmMBsfnrXvmocjXEPYZbSM2JNUc0WG2LXCPgT7WRlMj
   CkD6lpaZ5llSVeVcjSqL55A5jISPqEpQF9pJccyUvdYWX9ukuAYsyq3n3
   Z8Dq3ocjZKpCgKkKSobsdtKN3zi8lKE8iv00Nb2c4HTOcyrsg8mn61jVW
   ENuM7H4LfhtAtjCfs/6LSkQHWI9c+0YHL6vc4uBbBR0l8cZdg6ZBdsrZj
   M6IGY80+Su0aAKmyWlG4yT5CVY6xV1jvqXweVN/nTN5GCgMuPJ4/ZDc0U
   jWmC6nBrOENth5DRKFoq4uEjF67Jon247csHc55A3n1ntLbe846kxcCUW
   Q==;
X-CSE-ConnectionGUID: sPvBktYaQ1O0obDXyknmjA==
X-CSE-MsgGUID: fVmzFq4/QpyvNMLz1KYs0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19417997"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19417997"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:39:19 -0700
X-CSE-ConnectionGUID: kBncVU8zRiWVEozPktICBA==
X-CSE-MsgGUID: q6HfMlQ3Toa/bya6GYzSEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="75944070"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 14:39:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 14:39:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 14:39:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 14:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LphYewDZxqXzar2UIRBCdrUcw9aGtW8eBrFwM9L3DQ7mOXXa9cmcbaT68tAiO6iuCZ1jcWg4S42E+iz1Z3rnsNGQITXQuGmaeX3ADS+mmVREC1PUlDogtLOTz/m/JZuCTYimnROLWnrHOc7GYrzT/zUT7U6CFfGV5+nMFw1thDL/hsgetQJFRnzLDemtGHS6Z/piryKx5V7Z7Smt/Y/fGjJdUtY5JeQBYT7xW+itbKJw+1Y/HeVNp3iIsv9YQ/cMIHItchxlOpmcWpDKWvLgS/5hLJ9+BcZxs0i39SwDiJiglB1hqgp390tjz0xId3FMjNeUtbg4WvhqvEg5W8H8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFomBCsIgPWooWcYSPnCIg35AV/cWpEK59KLQjfCO1k=;
 b=JvDy67nZh2Isv4bp8ZT9WCfIDdagVnrKekYCu2QmIqaBauExchGBnNUepBZ8N4QohTmh9FFHIGtbyZtnik6InM4MwdTB+Q7m0dWhr5oCl0GSc8zoT2R2xBxiWIkqK6Uj6jks9AAhhk+6ODeJEbNJGh0DZkgt8soukDt2wMKCnjisd2HgYxNydzpy5eV8G9DncuzWscMfW3FMFX/cNxDBaF5GBm+9FyIGc3eAr6fEJlDhNGyI320ZvPXNI0/HEIe0WH3RRWhdY9wzZ6HMlm3yzXdXSxld7+ZTI6avCbhO0RPmoQcQMR6eCVt+uPOKMedx9OK48GbBDuWnSbyNSKbf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12)
 by CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Wed, 24 Jul
 2024 21:39:14 +0000
Received: from PH7PR11MB6978.namprd11.prod.outlook.com
 ([fe80::3f47:ba18:44ff:4e42]) by PH7PR11MB6978.namprd11.prod.outlook.com
 ([fe80::3f47:ba18:44ff:4e42%7]) with mapi id 15.20.7762.020; Wed, 24 Jul 2024
 21:39:14 +0000
From: "Hall, Christopher S" <christopher.s.hall@intel.com>
To: Rodolfo Giometti <giometti@enneenne.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, "Dong, Eddie" <eddie.dong@intel.com>,
	"N, Pandith" <pandith.n@intel.com>, "Mohan, Subramanian"
	<subramanian.mohan@intel.com>, "T R, Thejesh Reddy"
	<thejesh.reddy.t.r@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "D,
 Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "Zage, David" <david.zage@intel.com>
Subject: RE: [PATCH v10 0/3] Add support for Intel PPS Generator
Thread-Topic: [PATCH v10 0/3] Add support for Intel PPS Generator
Thread-Index: AQHavHw3ShXaqfBwHUWB/KUD73y9PLHlNwOAgAFgxICAEQsmAIAAGRSAgA7siGA=
Date: Wed, 24 Jul 2024 21:39:14 +0000
Message-ID: <PH7PR11MB6978F12032F4F3EBA83BFE10C2AA2@PH7PR11MB6978.namprd11.prod.outlook.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
 <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com> <87r0bvqdsz.ffs@tglx>
 <5198a2c2-49b2-4a8c-8d94-d6c9811b645b@enneenne.com>
In-Reply-To: <5198a2c2-49b2-4a8c-8d94-d6c9811b645b@enneenne.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6978:EE_|CY5PR11MB6116:EE_
x-ms-office365-filtering-correlation-id: 0e078fdc-2bed-4628-f856-08dcac291036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEI1aXFBUDFEWnN2UDQ0WmlJK2RuSkh5WGgxVWtnK2xWZkdQMlIrUmJYcGlt?=
 =?utf-8?B?NE1HdTI0WU9PRzZRTERiUHVhR1k5TkVlVkVLVUJuREZoZG9rSjcrVmhuV084?=
 =?utf-8?B?ZzgrOTQrUk9FbXhQU3JDSmc0UUkza0dxczRPMFlhdHgxWFlEUFZDWjhGY0hj?=
 =?utf-8?B?SVcrTDRJZDlyUW0yRjVJRDVrenp4K29NdmRrUVhzeVc3NUVCNGtSR3dVTFN2?=
 =?utf-8?B?T1d5L1NKS1MyUHNOZnMzMFd1OUI4TXFPazIraUE5V3NDK296Qlo2NllxenU4?=
 =?utf-8?B?TnFkMmV6eEdVTXJFdlhyai95V0VzcWVNNko3bUhuV0pOUEl1YTdLSjA1OUlF?=
 =?utf-8?B?RzhiVmlINHhjRU56emhycXc5cG9SUTZnKzJUT05YWWlqeVkwb2w4d0M3VW9m?=
 =?utf-8?B?cFZ1SEJuYzBXZXR5STR2Q0EveTJkV0p0TkhOYlIxUmdwbTFRUVRQMGN5bkNG?=
 =?utf-8?B?ZG45VWYvWU05emF3d21VcXRMaERXZVVUQWU1SjFJMmNrN1ROejVwSXdXdVFk?=
 =?utf-8?B?dnBpY05OclB0cVJMTTdqZkRUNjFMSktQazcrRmtWdHlqdURKWDVOZ2hON3Y1?=
 =?utf-8?B?U3BzMUNlQ0pKWDJZSk5raFR4K2ZRRS9vUXpiTWtXMW9NRlNzOHhkb3l0aTY0?=
 =?utf-8?B?NUxXRjgxNFk0WHl2VC9iN3o4YmZUMk9WclhmQTNtSUpXYzgrN2ZwWGdidHF2?=
 =?utf-8?B?S2VmUTErSk5TL0FUSFgyUU1qQjhhTWpCSXhhenpkYzRCM25zV3FSdGZrQTRw?=
 =?utf-8?B?MTJVUmdPbVY5SmdNWEJNNytFcXBoS05aVVI1M2o4cW9KRU41R2UxZzNtUDQz?=
 =?utf-8?B?eVdJdTFpVlRtSGtkQVBObEZxcUpyL1hGT01aQ28xSTJBL0cyTDM4eDQ1Y0Jp?=
 =?utf-8?B?Q1ZoTnFMQjRyUWJFa3VlbFlTTEd0QW9wTXc4VnNyZ3IzUUhoYTVKNm13dVdW?=
 =?utf-8?B?akJDZ0RYUmU3MW1VSDBzSGdXV091ZWdIcitGUldnY2ZjRGdiQ3pXQkdiWXNh?=
 =?utf-8?B?dGpMQkgzV1FGSDVZZ1hEUTU2cWppb0dvclRMMFpHRTM3R2QxYjh2ektTcEti?=
 =?utf-8?B?VVZMOTZNL2tWVmVVNEdrdzM4d0twMk5zU3l6VGFnUnVjN3FTdjhobW5uZnVU?=
 =?utf-8?B?Sk55VHJBSGNPaVlZMzNDVS9aOUZWU2t5OVg4ZGEyU1I5dDAzZkxZV1Y2bDNO?=
 =?utf-8?B?TmxLMldVMVlUSFM1UUpmTWhPWmxpWlFwaTlOaEV5VWptS3ZqeHpsTGcxaHRm?=
 =?utf-8?B?RGpndGVzdGlzbG1BSXloOHhVVmcvOHpDNzR4czl6VkRsRVJ2Z09vbWlWMS80?=
 =?utf-8?B?aVVyalZCVDR6WExmN0M0S3lOaEpCcWw1S3JPdUdqKzR0b0NpYVB2aGhTM01o?=
 =?utf-8?B?Q0FHNDZub2xHODZ5TTZOb1ltWGU0cGxzT3pKV2pWQmJOK3lUa3orZm40VHE2?=
 =?utf-8?B?eVh3Z3dOZnQ1NzZtaXBtMklzYXlPTHFVYjFnemRrYlI4aXR5WG5iR2tCN3RP?=
 =?utf-8?B?L0RHYStHZE5lTldFeTg1Q3ZTNDhabXJJZzdZZk1vVXJJSGFkV3F5L0QvU1pl?=
 =?utf-8?B?WFNWOHh2VjY0SXpRVXMvVUptbHZJR1pVUUhkcU1yeDZ5WkpsU2lyTTJSY3RY?=
 =?utf-8?B?QnhoOENyVmNOUlhWNklxeEZsc3VSSVRiczlOYkl2cE5XRjh3M3NRdGZRbERT?=
 =?utf-8?B?ckpnV1hLTWZwYkZsc2lLSUVidUJBWDVFbG40QVFQV2xkNmZpT3RyUHdNN3V5?=
 =?utf-8?B?RjhxejgxczUvWUpJZWFTN1N6Q0ZpR01JR09RZTlydHEra3NNbENxdU1XdHo5?=
 =?utf-8?B?QWh1TkQzWGVzREx3djN2QmhnMW5DdjNxMC9LOEVHOWVBTEs4clZlZmFXOUpa?=
 =?utf-8?B?TVhnOXAzZUlGeEpSVnpIVyt6emNJK3VHRWdtdVJNZUY3VGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi9EZ3U1Rm9mcXhjdU91OUliZVdRcFRCb2dFU2o0bmM4Mm1aZE1YUGpodDBZ?=
 =?utf-8?B?THFQS1REeW9PS1BEbEVUbWJaV3dJWk4rZG9ma3Z6cjJIbkg4MTc2eFNVUFdD?=
 =?utf-8?B?bGpVTTRQQ25McGhROWtqS2N3ZFFTVkc0VHlLWEwwem9iSjNwL3cwcEJTVG5E?=
 =?utf-8?B?WGhaRUR3ZzNpU2xBRzFUYkozOG9jT1B4R1RLTU5sbDZmWis0YytRMkMwaGk5?=
 =?utf-8?B?Rk1BS3pGYXRrNTFpZnRnaE9TT0R0S3AzWUFjNG8vdUt0NW5neFRjcEg5YnlU?=
 =?utf-8?B?ZHZtYytEQzcvZ1lrTHFsUWZ6RzJIOXhRU01HN3dlalJoUkhrdGpZR3dhVSsx?=
 =?utf-8?B?d1pRdWZXVzNlRnU1eGhDYktrUHZPSWs3SlJWaWNLRkdXMXlyNi9zMkRzc1A4?=
 =?utf-8?B?TytaemlvcitNRlo3TWgxdmZSNFYwczBNVHZxY2VacWR2YVdyTWQyaW81RE9V?=
 =?utf-8?B?anR1ZE5VL1IzNTJYenNEOTlMMkRGREVkQlF5azVnaTFSQ29COHREOURDQUEv?=
 =?utf-8?B?SDU5TTkvNHNmcFZCaVkwNDJhNWs3MVF0UDg0WXF0NHZ4TEVZYVNyMDJzckZR?=
 =?utf-8?B?c1VrcGNRaTVRQUdaMEdjOVpwZW5xeE9BbUNQL1FvNUxZcndjNHZpU1pOYjJ2?=
 =?utf-8?B?MDYycFV2TUNaMzFPa1FWcWlBUUlFTWVVWjdMNkh4eTdHWnFDVE9jTlByOHhN?=
 =?utf-8?B?eDhyWEo4MjBJMGVROSsrTHFkOVR5Wm00UUhGL1Q2WnNCZmp1MUlDTUQvU0JP?=
 =?utf-8?B?Q002THo0cnVDVlRNR2F5dm1SaExkVFdsNnBnS1VoS3JXRUtHeE1CSjZFZThE?=
 =?utf-8?B?NEMzOVpXM3FMbjlQUldKbmFjTTNCZ3o5cnQ1QjR5YmZ1VUlvbC81OWFiWTVi?=
 =?utf-8?B?SW13dFpieDdiZUhwaFovZ0dCZGI4bkljdmJuS2g4akJoSFVzRnUvaGVsK3Z5?=
 =?utf-8?B?ek5mT0pYNldocFFFTnlzV3NwOXl1WUlKVkhxeWJWWHRkekNGNVQ5MFRZK3N0?=
 =?utf-8?B?UVY5QjZXODNlV2oxZFhpNFFBaks2MVBHVmgxNUpHemRudGJ0OVZ0Z29WeFRH?=
 =?utf-8?B?QnFlclkrckxrQTAzL3VVQUVMOFhrRWJiOXFWZHdFUjVRQTZlV3JIMkZWbDlX?=
 =?utf-8?B?UXlCT3RNVmZKQXA1ZGdlczdUL3FWOEtTTVE2Z1ZKNzBYekFrVU1LNGp6Z2d0?=
 =?utf-8?B?d0tnUmp1WWlZSk1FMDN3SzdhMHdXbHpNSnlaV2VtR3ovR1hFZGlkK0dQR0ly?=
 =?utf-8?B?dUxXYjFRcnhsdC9xRXRrR3YzaDNsTGhZR0xnekY4Z29mcDlvcHpqaGtMV2h0?=
 =?utf-8?B?ZHloa0tjRlBSVTN2ajlUVk4wWGhrVkFYSXEwei9CdTU2amVUQUp6MXM3K2Jp?=
 =?utf-8?B?Tllic2FrazZ1dU5XR1YzRVFMT1A2VUNualZXRVR5K1hZRWQwalBSVkx5MmJE?=
 =?utf-8?B?RmRwUmRRSDdhUTY4Z3hDM1BKNGJOU0tnalV5a29ibUpjbDBEWEpSWGRGejN5?=
 =?utf-8?B?SjRzQzVwZXE4RzZZTk5zM1VoWGtPL1U1M0wwSU1MT3NsNnUrdUNxeVJWWDhC?=
 =?utf-8?B?Z0w4QmJvQzNEcVF2bzVKVTE5MTQ4dHAwVDZpRGh3djA2SWpHb3owNXJXc0ZI?=
 =?utf-8?B?VVRnS1ZodGFsTXM2VGdsY3VNZC9lT2dwTVZyTkIrRGEvWnVUSUp1OGdwUHEy?=
 =?utf-8?B?TDhYWDZQVTY4dGI5MTFDR09QTVE4UFErcWVaNk4rSGZtL2N0aXYwbVFjMGFu?=
 =?utf-8?B?R3QxSjJEYkhCSVNUWHJ0a0RESDAvYU8rR005VEV5d1VDVnJTZ3RTYnJBMjZz?=
 =?utf-8?B?U2crY3lCSjF5L2NkajlUSzQ1YVAyWFVnZDNyS1JURGJjUTBRdUd1WGlvWG9W?=
 =?utf-8?B?YnhtV29ZWlNTSmVJMklZeURrNzZ4RGRYSXRSK1VQbFRmOHpvZmNhNkVycUpt?=
 =?utf-8?B?bW10bENTRVJMUDdmMWFINnZaakQxWXI0VjBiS3hxSEsvTnlYSmtWMjJ5Ujdk?=
 =?utf-8?B?em5IMTNwT0RTSHlZd3pZVDV4S0liMDZTdDVzaUNlNzI3UXpXUWlLSUluYUl2?=
 =?utf-8?B?WTZEWVRUS2VqYnhzQ2hyWm5WOCttdDh4OXE0OHBWR2FHS3BTWXdKTzY1TStP?=
 =?utf-8?B?bjFiYndNenJzNjl6d3NuNFNoWjU3bnJJQVBMRVdJVWlsY2VIdU1XNldzOXU0?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e078fdc-2bed-4628-f856-08dcac291036
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 21:39:14.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLB7HltZfxefY8cB8wZN5/6RkK2Bj8uVEoQOpytSB8mJfrUjbq0RyJK+OpDC0sULZcdNSGTxHP58lzwzDel01oRQhqm3A6auVO0dvyTdfw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6116
X-OriginatorOrg: intel.com

SGVsbG8gUm9kb2xmbywNCg0KPiBGcm9tOiBSb2RvbGZvIEdpb21ldHRpIDxnaW9tZXR0aUBlbm5l
ZW5uZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVseSAxNSwgMjAyNCAyOjM3IEFNDQoNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MTAgMC8zXSBBZGQgc3VwcG9ydCBmb3IgSW50ZWwgUFBTIEdlbmVy
YXRvcg0KPiANCj4gT24gMTUvMDcvMjQgMTA6MDYsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4g
PiBPbiBUaHUsIEp1bCAwNCAyMDI0IGF0IDEzOjUwLCBSb2RvbGZvIEdpb21ldHRpIHdyb3RlOg0K
PiA+PiBPbiAwMy8wNy8yNCAxNjo0NywgRCwgTGFrc2htaSBTb3dqYW55YSB3cm90ZToNCj4gPj4+
DQo+ID4+PiBBIGdlbnRsZSByZW1pbmRlciBmb3IgdGhlIHJldmlldyBvZiB0aGUgcHBzIHBhdGNo
c2V0Lg0KPiA+Pg0KPiA+PiBJIGFscmVhZHkgYWNrZWQgdGhlc2UgcGF0Y2hzZXQsIGRpZG4ndCBJ
PyA9OC1vDQo+ID4+DQo+ID4+IFBsZWFzZSBsZXQgbWUga25vdyBpZiBJIG1pc3NlZCBzb21ldGhp
bmcuDQo+ID4NCj4gPiBTb3JyeSwgSSBtaXNzZWQgdGhhdCBWMTAgcG9zdGluZy4gSXQncyB0b28g
bGF0ZSBub3cuDQo+ID4NCj4gPiBSb2RvbGZvLCBjYW4geW91IHBpY2sgaXQgdXAgYWZ0ZXIgcmMx
IGZvciB0aGUgbmV4dCBtZXJnZSB3aW5kb3cuIEFsbA0KPiA+IHByZXJlcXVpc2l0ZXMgc2hvdWxk
IGJlIGluIExpbnVzIHRyZWUgdGhlbi4NCj4gDQo+IExpbnV4UFBTIGhhcyBubyBkZWRpY2F0ZWQg
dHJlZSBhcyBvdGhlciBMaW51eCBzdWJzeXN0ZW1zLiBVc3VhbGx5IEkgc2VuZCBteQ0KPiAiQWNr
ZWQiIHRvIEdyZWcgS3JvYWgtSGFydG1hbiBhbmQgQW5kcmV3IE1vcnRvbiwgYW5kIHRoZXkgcHVz
aCBwYXRjaGVzDQo+IGJ5DQo+IHRoZW1zZWx2ZXMuDQoNCklzIHRoZSBQUFMgZHJpdmVyIG9uIHRy
YWNrIHRvIGJlIGluY2x1ZGVkIGluIHRoZSA2LjExIHJlbGVhc2UgY2FuZGlkYXRlPw0KDQpUaGFu
a3MsDQpDaHJpcw0K

