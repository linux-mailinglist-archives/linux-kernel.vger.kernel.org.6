Return-Path: <linux-kernel+bounces-224671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71C912590
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE001C23C89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C4153569;
	Fri, 21 Jun 2024 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcSMG9XY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F10152790
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973359; cv=fail; b=UPL5wMqeubQ4Au1KQi36Pd2lAFO4ScyjNNZ/3Ny5WtTA0pWLoUqwN+SkoGQZ1e+Sbi06YCNXYoBoK0HOqyxFqvu7xyqLrHEDBwe2h5UDUiMdoU5QRigCuWE4F+e8u3lvB0nFHBJun9ZF2za8yQ2fg0t0hzHaTTAo0rDZurHdhjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973359; c=relaxed/simple;
	bh=Ntu48T84vKjj7OkqBhWk/abbG0NCJdSJxKzu2P8Hmo8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LKjxeSiNywT4crtiBTaVUEdjO4MDto2gpI78U9XU5MEnIrAgX/zhS2g1gCeo74W34wYqGUjqb4Al8PyW2Y+HpOISoYZr7lzjvHMDo6o7rmcb+QVJGdTEqUBqrunPSXf6tetdzQP0/x67amki5OkCV+RB6eIqC2nDuh2GsYZko9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcSMG9XY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718973357; x=1750509357;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ntu48T84vKjj7OkqBhWk/abbG0NCJdSJxKzu2P8Hmo8=;
  b=OcSMG9XY/P+87Wm2hlyuuDWmW2o0x7Tz12dZKhIL7e3l3zM+15IVeK/n
   RjnMkdkV7MMoD1YWM0AMXWVchTcSBtmp/mzAlRvYOMexE7myhUP8JEOiu
   Cej82xNvmf18MoUNGUNYAwoefZbUrdWt6VVXiwOx/WO9oChtaKccIHBHQ
   neatLBQngUt0h4ewQ3CctY39r4+cdg8hCznuv4/rxGYJM3r5P/Hdsvk/3
   BX50qxNHkUq7HZv6uZFKThszIw1XTA27QLMe/JoYEsXTRb2Lbi1nF+1qw
   TUw96gFodSSKKfXw0wgcFC8Gnis1MRPUknh5ymlUEkFoChDWjoxLFZIIS
   g==;
X-CSE-ConnectionGUID: bXE5UaUMSbyTwt5Aynbvkg==
X-CSE-MsgGUID: fMpD6oQmSda5SX5wnyyhfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15837549"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="15837549"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 05:35:57 -0700
X-CSE-ConnectionGUID: DIyLBkfjSwi9AtglTUNJoA==
X-CSE-MsgGUID: 1SzWJGX8TWSwY//EHDm/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="42550628"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 05:35:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 05:35:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 05:35:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 05:35:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 05:35:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMGjCMO9f95HP3dnBtKBcvlYAoGJcbEJVrV6HWXcFm/Ue0Fzu8+225aBPXMLx594ni2HcFLRsukJ/kOe7XKRKbRxxo2Fs5p1pcW/9UhstTObOImlxBqkFXWwpYCcs23d7VR0bonQ6KwQk+zv/FdFtk2zCFPriDeU+9PeRwGIR9lMBNXYzRuewHPO1h7a9zS8Ls/U1C3xMy+jF6Vi4mB47zl20H7ucAv9wB92gtl+QI+nYqu6VH7u04J8sVbuKjUFTGoKgtjuTVV3gjig8Uwgn3LQALG+El6BducwkJiNqBSuSF4fe5zmLcbboLzUAy0Fmvbr0NiunMUPfjQxaY/UnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLlNZvP7kGE0ZI7YUP5qcdPyfh5XfRCmljIzHbPjBEM=;
 b=mEiBszu5uRvCSgBfHipS2e7Rz0k4Y/3Hq5lQvVYNgeUEOeKEDKUM5H5tUwKkjEMbZzpjgIvqkoEGsQHNfO4mPJv/Fow8k8y60TGJZXgeKMMaaWIN5hlhtmeKlU0aRaLoTVMv2lgLwvpphzToSnFhNqeZshec5gm1Z6xTGeZQPi4MtcrNrX//8QRyzKMIRwMXpJpiqAcmztRXalt5MiWQe1OlyF41XWIb92UT+CRteXmxaz/8BgbtCPRibkgI9qNwaPugqL3TFzUi7aAFmVw0FSQv+kBam5XsNEu2NsL+ue00g4/IsmE1zb15DoeJv54534pAi/GuRYSGTWp0NmR+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 CO1PR11MB4868.namprd11.prod.outlook.com (2603:10b6:303:90::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Fri, 21 Jun 2024 12:35:53 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7698.019; Fri, 21 Jun 2024
 12:35:53 +0000
Date: Fri, 21 Jun 2024 20:35:43 +0800
From: Philip Li <philip.li@intel.com>
To: Aleksandr Nogikh <nogikh@google.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Dmitry Vyukov
	<dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: kernel/kcov.c:635:32: error: 'KCOV_MODE_REMOTE' undeclared
Message-ID: <ZnVzn3YtNi5+mkLe@rli9-mobl>
References: <202406201538.SMBucNWT-lkp@intel.com>
 <CANp29Y5Nz_nf1HPfr_dY4Nrg=S6w0gJgWe0uS1d90GLDZsd0ZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y5Nz_nf1HPfr_dY4Nrg=S6w0gJgWe0uS1d90GLDZsd0ZA@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|CO1PR11MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f56e81-18cb-4bad-4045-08dc91eeb08f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWVtREhlbmdjUGl0VWozdUtHMmd2ZGhLc0hCbUQ4TlJPbzVicEdJTk5mV2cw?=
 =?utf-8?B?NlZBZHNTN2l1MVhGaHNqSWlDUW1leC9qRXJLa1RTSVlrMzlrcW5YcXJjUFN1?=
 =?utf-8?B?T2drMFpTa1M3UFBaSlZjK0xCZWdFN2xOSzgrb1FBbVFtcjgvOVNuSGtUUmRk?=
 =?utf-8?B?K0czajk5L0JESElqQnVpc3BCVVRLUWp3N0JSMXBJV1FCUElhSHlTdk9KYUZX?=
 =?utf-8?B?N3M0eG5NWWRId0lRK2RROWQwVVloWE5VRk52eTQ4cUcvY3VqN3AvVHdxNnYz?=
 =?utf-8?B?ZVZKY1JNZzlhSkFaMGY5YUIrN2t3cUdYdW9xMWVkZk5oa0JoR1dydjlJMDdz?=
 =?utf-8?B?YUJLa0hiWVFjVExPMGUvRmxIZlpwdjdIQmEzQUNjQVBGNldFZFEwM1IyY0lV?=
 =?utf-8?B?ajd0bFlPRnlFdi9mUFJKOTltLzAzcTh6TlBBNkJqZ25KSjBrcDJQL1dvSkxj?=
 =?utf-8?B?aHcvUVhBYW1BYTJWWWdNZmlSd2hZUnl6N2VDOUV2WVdUUTU4TU81UmNLN0VY?=
 =?utf-8?B?NWNrb0VJRWtKQlE5UXhoTDZ0UzBMNEpvUytJVXdwWFhBTk12dEV0c2RpQW1h?=
 =?utf-8?B?Z0NmYm9qODNOcFpsWTJIMXR5Y2RNUzhIRHVUK0RaNTBiZEE1RGlOdVJaQlU5?=
 =?utf-8?B?NUxzc1U2aGhGL0ZEV1plTmk2UFRRSjdnK00yZ2Eyb2RJbVZadGdwWWw5RmE3?=
 =?utf-8?B?d1MwZUV3SUFVMVZ6ZnpqRU8zZVUyaDZ4eldBTUVjRDYzUldUT2o3cE5qbHRt?=
 =?utf-8?B?TXkxT2pUQzN2OFBFWU4zajM5cHRScm1HYWYrS0pIZXNtK2UrS0FnZ3NWdmJ5?=
 =?utf-8?B?WHdXbDFHa3hpOVdzSUpibGgzYmtMQlF6SlNoU0JZWStDVFdjaE1BbkdQQXN6?=
 =?utf-8?B?cWRPNS9GbDhERFZIZnFVMTZGTk1DL0p4dVR2RW1VM29ZaWpNZlhmcXhqVk5R?=
 =?utf-8?B?ZVBWOVovZUpNTHBnNHdaaFJQSVQ3T0ZGcndWdHhqWXZqL3dSQXdoeUt4Zldy?=
 =?utf-8?B?SW5YU1FUYU1PdWt1U0xTaEYxVjhVbUJ2ODZwZHBJQUVDeFZ5RUFVdEVTOFNp?=
 =?utf-8?B?MFdNcGtoMmxUQUZCVzdaVkJhQ3ZvZVlZU0ZxUU43UVA3ejZveFMzcUUvWlcz?=
 =?utf-8?B?T3RmRlhEeVljOENBajRGZE14VGt5OSttNmQwOWdWSjE1S1F6YUw0WFJiTDZw?=
 =?utf-8?B?RUp5QXZid1YyNi9pYUlsMXBUTmdKTlRPRkVWRU4rK2NCWFJNaWJTL2dFdVhn?=
 =?utf-8?B?dHVyZjd4d0IranVJU0xyMlJWYzRlbFlBU1hianRURGhVYVFhT1M4UWphVit5?=
 =?utf-8?B?Qk5LWDhpMWd4WnZHWnJSK2pmNUhwZzJXTlVvR3BRK1psak53eVFXbmVCTnEz?=
 =?utf-8?B?TXQwekgxVG01RXpCcEJESXo3WWIzdmh6ZTYxVDV2dVpBNDNuRGdzSlB4WkpI?=
 =?utf-8?B?K2Izd1lJcjhwY0xsRU56UTlnL3J0Wlh6UjhLR1FGMXY0MEdCQjhpaEFsay8w?=
 =?utf-8?B?dWJGMG13aXQ4Ui9pcWUvZytjcnhpMmgyREMwMngxaFZFaHFSY3R4b09PeXlZ?=
 =?utf-8?B?TlRtTkd1UDd3TW5yaWlOc1VpRVZsalViRHNOVjhvd25DT21qanp0RWdRMXFx?=
 =?utf-8?B?aXcrWGUvTkZ4aGo1WjBPMFhPOHBFQ3VpWitpbzVtU054em5JZVBzelVVSEM0?=
 =?utf-8?Q?j7eFqElxER4a2dyCZ/6L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2RBWUp3UENXTlNsNmhYOERqODhFWGNkQzdlNG1oaVM1TUErSC9Gc3piOHNB?=
 =?utf-8?B?Y0lwV3IzVWtSN2I4V3pjNk9yZzA1dlVEeHEwZmVUOVlwZXhaUWxJYnA2NG1t?=
 =?utf-8?B?bDdoamlFTzZpOXFma04vS3hxbGNuMHZkSER2R1NtTmFYN3EzbVdndUtIcVBX?=
 =?utf-8?B?YzdISGpkb0s0dDk1bE9VKzN2V1I1SHdpSmVLTWhXYWdaa3lBQU9nbXJ5ck5H?=
 =?utf-8?B?cjROQXBTUVN6WFIxOWtna29Cbm54aytsT1RhUmgybVZpcGMzK0lRZVRjWk5C?=
 =?utf-8?B?SVB5SzgrVmFhTVdBRllEMzBmZE9pVTZFOTc5UmU4SUdNMjJETmRSZlYza3V6?=
 =?utf-8?B?MnJwbG1GR2ZCcWhKajNFekozS2prcUVSUDFPODdyRElkNUdoejdmMkhVeC9z?=
 =?utf-8?B?enI2eGt6dGxhdTJ3TWdjUVpOQWQ0OG9Xd3hLUEt2WDIyR295a1d2N3lwQzBo?=
 =?utf-8?B?cDZqYTRrbFJ4TldCWlVjeExxQ2RWMGFqbWdpSXltTUp0WFR1RVk2SVBYZDlu?=
 =?utf-8?B?MDdLb3FlK3lQdmpRKzNmVFFUblpFQ2JJYXVYZnM0YnpGR2NOVGFHTE9yRjVW?=
 =?utf-8?B?N3ZWWWxCTkZMVTN2bmRKWG94NFlrQnRvd3I2MGVhdDNUaWljUDRYOEk2ck00?=
 =?utf-8?B?TjBGWWxkU1NwOTZ5eUU4WlMzbWE0V0RWMEYvSE16Mm55bmFYWktQMi9LOWNh?=
 =?utf-8?B?U3pjTGh4UHdrQU55cmUxWW9BZThVSHZRaFFHb2ZXb1dPSTJUS1ZDS25OVlJQ?=
 =?utf-8?B?aHlnVU1LWVVFRVBxS3owSFI1WGVyaVhiWk5CNys5WTNFKzVsTGNIVC9vd0sz?=
 =?utf-8?B?ay9yaVc1WFZlRHJsUlRYVy8wRHBUQmpKaGtkOTNUL2ptdDJJTDF2R2duN1Vi?=
 =?utf-8?B?T0lLdFB6b0IxdlhGL3NFcDJDUVkvWEtWZXU2amxWNXBraW9qajNPRUFubGN6?=
 =?utf-8?B?Q2Z6cnVBb1ZkMXEwN25DM0M5U0dDMlp4emx4TGxCdlJIcElLZWJEenRMUVk5?=
 =?utf-8?B?RC9XT0JDdm9wUDFabEJZdk12WDBaR01QRmh1N0tMNE93RG51SUp1cjczLzBx?=
 =?utf-8?B?TnIwWU40QWVYTGFIS1VOMzFoNkxKbkpvZE1EOGlObllaRE5XaXJYUkU1MGhX?=
 =?utf-8?B?S3FOcGhNNTZ4NjkyYTN2WHhZaWFXYUhCNnBZM3h6WFdyc1pjZUhyK29jS0xn?=
 =?utf-8?B?MXYzS2EwTzlXNkFxNlRraEhBcTRKNndzUEhJTEYxM1hZSUdjeHdPR3JQbjdK?=
 =?utf-8?B?TDVSbXVaTDVXRUJXSzNKUXNzSWJodVZmb0pXbGp4aUlxRFRzdU0wVWFjK2FS?=
 =?utf-8?B?VnIxcTZqNDlwT3FENWs0OUZRcmd4Y0plQ1FPcWN3em80cFQrTUp5Tms4MlNW?=
 =?utf-8?B?QjZpZm1mK0JIOW5Bek1uanlJOEVoK3pycHIrYWV4SytNK1VaRFBscytyL2hK?=
 =?utf-8?B?R3ZYTHg3RitnZHMzRXAreGtCOHdiQTBVK3UxVGtCT3JlRGw3Zjk4VzRFZTcr?=
 =?utf-8?B?MG1oK2c4akRGYnpjNlJPN0pEaiswT0pKblFEeHlDQlN3TkZKZ25wUko3MGtK?=
 =?utf-8?B?T1JuQjQ3WEpTRUVkdmpBUnVpazdBQUp4U2RpNkFrN1llUVZiTldMb1graTBL?=
 =?utf-8?B?OHJkbmx6SXAvMEdmcUx4R2dFRjdBR2dNcXgzNXgwQkJNNThVVnk2QmQzTW1s?=
 =?utf-8?B?Rmd6Wm1sTFUvTEF1c01TbUVSbGMwS3RYVStpdW9QL3VtbGdrVFV4YmhWTEpD?=
 =?utf-8?B?NlNHN3F0RzB4V1pObEYvYTZyL3U5UTJEVng2UWNyT2d3bGY0MkdMUm03Nkk2?=
 =?utf-8?B?cGhHblhldGcyRXNIVEhWOXpqZmNkU1hxT0ZmQ2dKdXFnYXNLNkdPdW5zRDVh?=
 =?utf-8?B?Zy81Z2xXTVQ2blJCWTdkNVNvRW03UVVoMDRVRit5Sy9oTWJhTkpsWk9IRGVD?=
 =?utf-8?B?V3NXSUdUTC9ERkxFVEJaKytxTkVVeGNBT1RlLzlQNU82aytwa01DY2tKZGJM?=
 =?utf-8?B?Tmc1eXVWZFBFWVdITjFKYzVKellmcGhZelp4NnU4Uzg1VjBwUmVvODJjcU8v?=
 =?utf-8?B?TEd0dW9mVkRRZDRMRXJGKzA5K2YzWTRNelFPU1lWaTBrMjBIb3ZFN3Q3Q1FG?=
 =?utf-8?Q?SvGLtUWazLD0Fnfc40EtZwv1u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f56e81-18cb-4bad-4045-08dc91eeb08f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:35:53.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XStsKSw8iGvLYJVoEAinm7Ot4wBCao5XEQR0eoyr9Lz1vZu5mF2J+64auH6SEdjWS2vjy3U2u+XvrKHhbZlg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4868
X-OriginatorOrg: intel.com

On Fri, Jun 21, 2024 at 12:18:44PM +0200, Aleksandr Nogikh wrote:
> On Thu, Jun 20, 2024 at 9:53 AM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
> > commit: 01c8f9806bde438ca1c8cbbc439f0a14a6694f6c kcov: don't lose track of remote references during softirqs
> > date:   5 days ago
> > config: x86_64-randconfig-014-20240202 (https://download.01.org/0day-ci/archive/20240620/202406201538.SMBucNWT-lkp@intel.com/config)
> > compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201538.SMBucNWT-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406201538.SMBucNWT-lkp@intel.com/
> >
> 
> I was unable to reproduce the problem with the attached config/script.

Sorry, this should be a wrong report. We will fix the bot asap to avoid false positive.

> 
> > All errors (new ones prefixed by >>):
> >
> >          |                     ^~
> >    include/asm-generic/rwonce.h:55:27: note: in definition of macro '__WRITE_ONCE'
> >       55 |         *(volatile typeof(x) *)&(x) = (val);                            \
> >          |                           ^
> >    kernel/kcov.c:363:9: note: in expansion of macro 'WRITE_ONCE'
> >      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
> >          |         ^~~~~~~~~~
> >    kernel/kcov.c:363:21: error: 'struct task_struct' has no member named 'kcov_mode'
> >      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
> 
> It looks as if CONFIG_KCOV is not enabled, but
> 1) It is enabled in the attached config file.
> 2) If it's not enabled, the kernel/kcov.c file should not have been
> compiled in the first place.
> 
> >          |                     ^~
> >    include/asm-generic/rwonce.h:55:34: note: in definition of macro '__WRITE_ONCE'
> >       55 |         *(volatile typeof(x) *)&(x) = (val);                            \
> >          |                                  ^
> >    kernel/kcov.c:363:9: note: in expansion of macro 'WRITE_ONCE'
> >      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
> >          |         ^~~~~~~~~~
> >    kernel/kcov.c:363:34: error: 'KCOV_MODE_DISABLED' undeclared (first use in this function); did you mean 'KCOV_DISABLE'?
> >      363 |         WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
> 
> This looks again as if CONFIG_KCOV is not set (and there follow the
> same two conclusions).
> 
> -- 
> Aleksandr
> 

