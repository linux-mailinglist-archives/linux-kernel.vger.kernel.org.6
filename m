Return-Path: <linux-kernel+bounces-183326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF928C97B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FFAB216E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3523679DC;
	Mon, 20 May 2024 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDMsPaKz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA61847
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716169661; cv=fail; b=iYlFUsY9iemrVQ/0Q3xHMOVXHJnTf/V1pOfMjuDCQo/LwMG9HBS3C5SBWHZV8T83dnSICEJZBsVe3+zqrfPQkKCItP1ImVDoqKWNe1AEr6k//3jOrHMRyut3IVKF59jLlgOkQWuGCoZXKRzf5FqevePs4tsfUim+LvuZshrKBUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716169661; c=relaxed/simple;
	bh=IeKYKAlY+y4equ6Xuyz8jXtQBAbjsbGj6l9IMVxAs/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3KzNySEWPOpXFyemUBVcmaApn+85RDIof1szlhvqzx5HhyXBn9NGBiEuTF/+0Y5DP3JQv124KU9c5qP3qSbZlEhQGya/aO9zWEmXXarAvvkcwekncf2SL0+gPXe4lk/fIhNutQXbmawxdYHxHKyy2C4M62W+OyBnM+mjEWVpNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDMsPaKz; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716169661; x=1747705661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IeKYKAlY+y4equ6Xuyz8jXtQBAbjsbGj6l9IMVxAs/0=;
  b=nDMsPaKzjYT8XkaTl6L3EmPvsfCcQSs35XD3dnJTg5a/AO0MbKF2Eqdn
   Wtwyq86RX0BH3d396UuFODOEvHhuHiVCgiuYSDRNMqqWBF03/syp66nP4
   MLqXaYfSyjG/DsRAjpp2NZsijDDYGuDmuKsLambl/ZsanTf3pOFLWr+Az
   T2W8azo2GaoNM8L2I74EG4Odz+OsKdPpluY5v+LOjUUieb2R2jJbi4TBU
   1r+dChUTvCcDXTLNJ1hOSUYMcPwstMnM1KPF9790ejjzFQ4L/wMmjiKOs
   Jg4PsQkVmdrzzg21L++KuCP9Tvrrr8giW1JF0iqfX8cVSeYfvkL+zLOGg
   Q==;
X-CSE-ConnectionGUID: xvuwbPsBQWuMOq/ouF6t/A==
X-CSE-MsgGUID: 3i1SthocQoy0wum0Yy+OYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="15222733"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="15222733"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:47:39 -0700
X-CSE-ConnectionGUID: A3SZECk2TNqBHg44yaMrkg==
X-CSE-MsgGUID: v7gsYqy7QXCexCgPpU5iBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32280057"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 May 2024 18:47:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 18:47:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 18:47:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 19 May 2024 18:47:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 19 May 2024 18:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ens+IqQuWBW13GBMcSlO+fgGG/pX1p9TCXiO+nLVLKGizzVleNVVdnCIJF+9gNXfem2+0bYCrCj3a97r3y2x2qvGN48iSA6+bp4XIFGSBtbU15vtSFCLBLGvEo3ou6vKKDJR2kAb4ZTgwbegPWGA9v54wPy4q/cr/CPnsWS+8WR2Gup04oZkjIHQx+bROFdWMcooX8MZ2ABw6GIyNenQEoRT9vkvpPMt/tC5Q2FiDx0f7AxMHScN4kXv7oNwjqBGcTA4B6z9VLUwsXuuSnioVd1BDQH2pOzowzV7457KLWTjeqHqR8VJkMbhDjH9I3+XVnaHR4awDaQD+FevOJWKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeKYKAlY+y4equ6Xuyz8jXtQBAbjsbGj6l9IMVxAs/0=;
 b=ZxvzIsMLtYmCJgxF0i5SXcrl0dtTUp9cdqZpY3D4EGVQ8kIqWrWuOmdBrY+PpXmYOknyLa4I52cqr7L0uDYYNnTb6tE1K9cePNQQ0dMxyVSoIWfYgYKTuY7MhI769RaKudVG+Bd86B5MQIIEihdusbwUN2eCKSUkotlWvuFOHq/JHA2a4f9EkAZAx46mECB0EkFYqcrYoK+eT+ubOgyNyJBBU5WHcrpLiHD5Ntrw6tSWXrc70LKGPvXHLJgP+G29i1XXyL34wxsYOWz/pCdabahzCld/uM66lFhiuANnkjRBT/rmNxT3zT93XfgdHoG3Y0xSDVXQSuPdl+NFpsvPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ1PR11MB6300.namprd11.prod.outlook.com (2603:10b6:a03:455::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 01:47:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e620:6fe3:711c:a6bb%5]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 01:47:34 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "Sang, Oliver"
	<oliver.sang@intel.com>
CC: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Chen, Yu C"
	<yu.c.chen@intel.com>, "hui.wang@canonical.com" <hui.wang@canonical.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lifshits,
 Vitaly" <vitaly.lifshits@intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "naamax.meir@linux.intel.com"
	<naamax.meir@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "oe-lkp@lists.linux.dev"
	<oe-lkp@lists.linux.dev>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: Re: [Intel-wired-lan] [linus:master] [e1000e] 861e808602:
 suspend-stress.fail (e1000e: move force SMBUS from enable ulp function to
 avoid PHY loss issue)
Thread-Topic: [Intel-wired-lan] [linus:master] [e1000e] 861e808602:
 suspend-stress.fail (e1000e: move force SMBUS from enable ulp function to
 avoid PHY loss issue)
Thread-Index: AQHapoR2OSRFCOAff0OLHxP+/4MxWbGYB8yAgALnbQCABHMaAA==
Date: Mon, 20 May 2024 01:47:34 +0000
Message-ID: <a4adabd2cdfa0d5fa45cb00147ff16ce367539a1.camel@intel.com>
References: <202405150942.f9b873b1-oliver.sang@intel.com>
	 <23f86436-cd8a-45b0-9378-1ec3adecfc82@molgen.mpg.de>
	 <7ef3669807799a83aa40e94e2bdd21a11dbe393b.camel@intel.com>
	 <51c51cb7-db66-4187-a7e4-6dd3044579b7@molgen.mpg.de>
In-Reply-To: <51c51cb7-db66-4187-a7e4-6dd3044579b7@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ1PR11MB6300:EE_
x-ms-office365-filtering-correlation-id: 0d331e9b-142a-4eb3-10ce-08dc786ed1dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Q2ZZcU1CRmZXSnVGYlFHelVVTzJUZEpCSHBzVWdWTHJLM2FXT0hraUszZkNu?=
 =?utf-8?B?T2hvOC9NeFhHdWVIM0wxTE1URmdCZ2NQNzZxdlNJQXRPeWY1MGhJMDh5UVlz?=
 =?utf-8?B?SnNzQTFHTisxSThBMm5idjJlbjV4WTQxOHlSZWJKWE12RWI1WkROYkRDYjdo?=
 =?utf-8?B?cWN3Y3B4dElXWDVUUmNJdE9zRHM5azFVSUVNV2M0b2JQckpibG5sWVNmMTJE?=
 =?utf-8?B?QjBqcy9GZmJjd1VGRGFYNjNPUkNsUzdrRmhLb0NzOUUrZHRFaVdKR1hHSFdq?=
 =?utf-8?B?Y0xuZmJFWisybUtmSTJQOW9ab1A5QVhKbTNSWEQwRERERFJzRktEWmgvTmhy?=
 =?utf-8?B?cm5kd2N4NW9PRExhNmp3TEl1emNpUnBqQzN6VE05L0svMlR5ZlhuUlNubFhN?=
 =?utf-8?B?L0N2TC9mVEh4WVhEQk1zcEhQa1BjSDgzWjM4UUdLRlFZQ0lncFlOc2pnRGkw?=
 =?utf-8?B?ZHZrT3BJWjYwWDQ3Q1dBNjY1Q3kxc2wzalVZOEUyRW5wUGk0Y0cybUIvWW5H?=
 =?utf-8?B?Z2lkNUFmaXBCSkE4dHBmRDJKb29rSVJKUE9iTUdFVEhhQW1tTzJkd00wSER6?=
 =?utf-8?B?Q2ZrSy9UcXRnMFovTGdEc2tSbHV1T0g1bm40aHc1blhhVlBtMWlNOE9qK1BN?=
 =?utf-8?B?WHdTd3NyeWZsc056RFVDY1BaOUpxMnNzYXIvck9DU0krYm5xYUJOOWVCUUI0?=
 =?utf-8?B?Ui9jQmN4UVQ4SGZFYnU3SnFjN3hGYzgwMEJaOHpSNWUzSVNvZ1RBVXFlalQz?=
 =?utf-8?B?QXh6eFlWNHZuUjRuOHJ6OGpiODVFY2FNaFB4WTJJRC9LdWh5VFJxV0xGcU1N?=
 =?utf-8?B?am9INkNvRldHdElDdmRid0h6NDJCbk83dzJjaHhsYUtIMlNneVh1WTdRSUtk?=
 =?utf-8?B?c29VMnpVNnZPazRFVnJFeDNCM0o0UU52Z3pvNm1sYUVPTUxTRERZWXRlNkJj?=
 =?utf-8?B?K3l0S0NkNmYxc0FvbERGMTBEQno2VlZ2dmErcHA0MTcrNWJBbUZaTXF2NWN5?=
 =?utf-8?B?NmM3WnNvT1Z0VmU4NUtub0NlazhJV2QrcDJRdEtIZEY3SFMvWEZTakZ0NnU1?=
 =?utf-8?B?MHU1cG9SVmdtRmF3UUNNTXliYUpRUVAxYittZmZSbVZvR1lxUDBJV056U1Rp?=
 =?utf-8?B?TThIRzl6ZVpJcWc2M2xXb2VYdkdzNklmZUw5MWRTdk1odGhVRnVHZ1B0UjB3?=
 =?utf-8?B?Z1RKN2VkQW4yeE13ZExjODA3Vkg5ZVVFcmlhQnI1Y29BSWExSnl1U3JJb05B?=
 =?utf-8?B?ZTNXUHZUZEpoOHAvUVJ6ajRjK0loVzJXdW5HcWIvdlgrVkhEODh0VEdWRUxN?=
 =?utf-8?B?UFpBa3I4MzZ2SDM4Qkxmejh5QmQ5d2dhSStnNjdVdkpFbzVSTWtyOEFEcU1s?=
 =?utf-8?B?eFV5Y2tIU2c4UlRKbG1ZVHhCeWE0cWxvK2NWdkVudUc3N2E4MDlQUFpwQy9k?=
 =?utf-8?B?L3VPTEdhM000eTZvWExYc2NnNGFkcnltbGs3RXZpbFlCNlZVNiswdGlVN2VJ?=
 =?utf-8?B?aWJ4YkZoM3hpYVlQc1loWjlOd0owV0NvYk1lNzRPcEIzZlA4RlZNV0F3cVNJ?=
 =?utf-8?B?UGJrRm83SzVKTWszTDVjNHJPQk1uYjV3OW1QNUI0UlpLSlA1QWtoelFoeGZ4?=
 =?utf-8?B?TEpMS29SUWZvOW1HMElYWVhpQ3pza1Fva3F1TktJakkrbzVPejh1emN6djlX?=
 =?utf-8?B?bHNBUFpwTWU1K3VwZWl2SDl0Y3FwenB6djRVazBNOGtHMFJrdDFoSTRnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk5jNkpjeGx0TS9SNXpsSDZUOVdydDQrTUhrQVFWT1lqeU52a2FnM3o4QXRv?=
 =?utf-8?B?bzVXZmVmaC9hc0ZWZXlFT1hxcndZcVVlTTd5VEdHc0JwaHNvQVpvV3Z0UnZS?=
 =?utf-8?B?UE9BaWVtZWEwZUNoeC9ic0FqUSt6TVptTHdBbUROVEJrWTZPNEk4MzI1UlFj?=
 =?utf-8?B?cEtNc04rZjh0d25qVFdSbkJYcjhxb3paVWlCM0kxTCt0SEtpcUs1L281YmNv?=
 =?utf-8?B?UlhPbnVMMUU0blVtbEJpZldNQ0ducnFNZWVXdzg1V0dPeVVVVUUzM2JPZi9q?=
 =?utf-8?B?cTNzeE5CeVMva0pjVW9ZRjhLOVFHdzNHdi8wblN6eURIbXlyWjB0M3I4ZHBy?=
 =?utf-8?B?UUpQU3lMOGxkaHV6eHRET042WlBOc1BKYlBhZFZDRGc4WElZT3pzb0Y3YXJa?=
 =?utf-8?B?bExIdzBsTEZiTFYrVFRCZFlFVmJvNTNwNkpmdFpGOVpPS014M3kvZ3hRZUJN?=
 =?utf-8?B?MUNjQVBLTmZMQ2R4UUF5MEtzNUh5ZEZ1UjMxVWoyT0xaSVlVQWp5aWxIaVRh?=
 =?utf-8?B?aWozNGMxeDg2bFp2VmFBUlpTQlJhdFRhTWFKUnkramhxQlNQanJNN3RDcjVX?=
 =?utf-8?B?Risxd1ZKNURGalVsRnI4djZ6TXZob0FBV2lVQ2lpVmFCSm9EU2FxSC96TUp2?=
 =?utf-8?B?MmRrbmJvVjZMVm5nckdPRDN4K1pCSFlGVlRtSEFDbTR4MVNMcmsvSjhMdUZZ?=
 =?utf-8?B?Z3RES1puaUdOeWl0OXR1TGxFMEJKYU90bUdnWnF1L1hWSmZRQTNSaW5xOEhJ?=
 =?utf-8?B?U3VPRExSWm1LWjIvUVVvampnSFNLSnprT3M0QkJhTlBQZ0xaVys2aHNEL0Vo?=
 =?utf-8?B?WllzSndZeGZ4ZWFGMTJ2OVVib1hsZFYxR2VOaFhpMS9VU0RBaTdvYU10aGJO?=
 =?utf-8?B?N3NHVVR4TUxXYlpnY3FPMi9hczJCMHZPaFhPT09XSkFtZWRHQUlsN3cvYitS?=
 =?utf-8?B?dllvQWVoYjdlUHpBMVd5KzdYMnFEamxMTU1tV1A0dnBuQ0VhNUhrMXRlNXVr?=
 =?utf-8?B?Yzl4bXRwZkdOR1lKT1hXYWtWbU9jZXdjSS9ldzY4SDhlV2NQblRxNnFlci9R?=
 =?utf-8?B?SE9lU011dDJaNTFUdHArTXJNRHhRWU0vMjBTM2h5TmdyckNqZnVxbHdBTEhl?=
 =?utf-8?B?cDZFdmtVM3o0dlN1RXNMTDNOeDNubjhWekNUSGRLNVJaQXUrRHprWVJtUEJp?=
 =?utf-8?B?dVhxTDBCSk83L3ZWYWNlcDdWMmNKSS9VMFlTQSsvdDNSNERWTUgvQXNGMlBi?=
 =?utf-8?B?MWhoeDNuQ1YwdFhBNlZnSlJUNVpGZEZaR2E0MlRGN01oQ3JpMmZxTUVIbGhB?=
 =?utf-8?B?cStyTnVvemZVenhENSt1dzg5R0twZU9VbjJ4OW5TMytxNHZtKzEweGk5NmhJ?=
 =?utf-8?B?YkhMRmNmekVwMmxNU2FzU1dRc29aQmZuQWZRVFhrbjh2a3AzMnA5MEZqREFr?=
 =?utf-8?B?WXJkTWZQNUQrQTJiaEUzUk8zMWFhRDR4M2VyUExYTGNTcEV4cENZcUhCVWt2?=
 =?utf-8?B?RldiL0JXSUhKY3hxUHRVQnpscWdOdTFwQkZWaEMyYUsxYXJLS2dGSFpnUCt5?=
 =?utf-8?B?R092dEQ5UElKVkp3ZHJhSFVGY3E2L2g0bGtmREZBMWJOZjBtNUxlVTZZOCtM?=
 =?utf-8?B?QnNqdi8yRkZYcWNDZVJhSDcrR3RESVBlSndPMTNLK2dyeEdVRTBYWXVhNlhv?=
 =?utf-8?B?cENnQXdSM0kvTElqTjB1T0VRRW8rdk12MmZpZFUxcjNDc3lsOFpRQ09jQnFL?=
 =?utf-8?B?S2RjN2FWbUpBUGJiV2dxM0FwMmhsR21NakI1TFFNWk0zNWdDMy93YkZ6c0tl?=
 =?utf-8?B?d2dIdEdNZHBGQk5JYUdBbC84WjdqeitIRFo4VHB4Y3djL0xBT1lVcXQrTVJy?=
 =?utf-8?B?Y3pOS2ppL2xjeDlhdGpkVUIyc2tUNXdRNm4yS2ZTUHZZZ29vVk8veU05eVhn?=
 =?utf-8?B?SWF1WXdTc1dHQUF5SEphT2xSQXZVN0hLQmpjL2ZjT1krUFdyeEVrY3FLcklS?=
 =?utf-8?B?Q3g1QmZQT2xEdkNUaEdPTnNGQjM1SnZuRWlXbDFpcGgwZlMvQnlDcEQzTWhn?=
 =?utf-8?B?dzhwbTVsc0RaOU56Rk1ZTFc5bXVIMFYwMFBDdncvalhWRTlTVE1WblRkeEZi?=
 =?utf-8?B?WHB6MUo2b2IyZTFzT1VpSlpYRHpFVVUrdjJxbmZjZGcyK1RlR21YbU9ERG5Q?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3282E51E8F1EA44BBDCD856AD4455C31@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d331e9b-142a-4eb3-10ce-08dc786ed1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 01:47:34.1956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJQchbd0KmaX/7N35ViP40Q/ti07BNyGxs6NvfBotF6bVKWMiZl4EEKdqM0l99AAfCydZtBNM7xwpQTa9ZI5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6300
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA1LTE3IGF0IDA3OjUwICswMjAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4g
RGVhciBSdWksDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIHJlcGx5Lg0KPiAN
Cj4gDQo+IEFtIDE1LjA1LjI0IHVtIDExOjI5IHNjaHJpZWIgWmhhbmcsIFJ1aToNCj4gDQo+ID4g
T24gV2VkLCAyMDI0LTA1LTE1IGF0IDA2OjU3ICswMjAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4g
PiA+IA0KPiA+ID4gQ2FuIHlvdSBwbGVhc2Ugc2hhcmUgb24gd2hhdCB0ZXN0IHN5c3RlbSB0aGlz
IGZhaWxzLCBhbmQgcHJvdmlkZQ0KPiA+ID4gdGhlDQo+ID4gPiBoYXJkd2FyZSBpbmZvcm1hdGlv
bj8NCj4gPiANCj4gPiBUaGlzIGlzIGFuIEludGVsIEJyb2FkV2VsbCBOVUMuDQo+ID4gVGhlIHBy
b2JsZW0gaXMgcmVwcm9kdWNlZCBvbiB0aGlzIHBsYXRmb3JtIG9ubHksIHdlIGhhdmUgMjArIG90
aGVyDQo+ID4gcGxhdGZvcm1zIGJ1dCBkb2Vzbid0IHNlZSB0aGlzIGlzc3VlLg0KPiA+IA0KPiA+
IGxzcGNpIG91dHB1dCBhdHRhY2hlZCwgYW55IG90aGVyIGluZm8gbmVlZGVkPw0KPiANCj4gVGhl
IGAtbm5gIHRvIHNob3cgUENJIHZlbmRvciBhbmQgZGV2aWNlIGNvZGVzIGFsc28gYXMgbnVtYmVy
cyB3b3VsZA0KPiBiZSBuaWNlLg0KPiANCj4gPiA+IEFsc28sIGRvIHlvdSBoYXZlIExpbnV4IGxv
Z3MgdW50aWwgc3RhcnRpbmcgdGhlIHRlc3RzPw0KPiA+IA0KPiA+IGRtZXNnIGFmdGVyIGJvb3Qg
YXR0YWNoZWQuDQo+ID4gQWZ0ZXIgdGhhdCBJIHJ1biAicnRjd2FrZSAtbSBmcmVlemUgLXMgMzAi
IGFuZCBzeXN0ZW0gZnJlZXplcy4NCj4gDQo+IEp1c3QgYXMgYSBoZWFkcy11cCwgdGhhdCB0aGUg
cmVmZXJlbmNlZCBjb21taXQgYWxzbyBjYXVzZWQgcmVncmVzc2lvbg0KPiBvbiANCj4gYW5vdGhl
ciBzeXN0ZW0gWzFdLiBXb3VsZCB5b3UgYmUgYWJsZSB0byB0ZXN0IHRoYXQgcGF0Y2g/DQoNCg0K
SGksIFBhdWwsDQoNCnRoYW5rcyBmb3IgdGhlIHBvaW50ZXIsIHRoZSBwYXRjaCBpbmRlZWQgZml4
ZXMgdGhlIHByb2JsZW0gZm9yIG1lLg0KDQp0aGFua3MsDQpydWkNCg0KDQo+IA0KPiANCj4gS2lu
ZCByZWdhcmRzLA0KPiANCj4gUGF1bA0KPiANCj4gDQo+IFsxXTogDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2ludGVsLXdpcmVkLWxhbi8yMDI0MDQxMzA5Mjc0My4xNTQ4MzEwLTEtaHVpLndh
bmdAY2Fub25pY2FsLmNvbS8NCg0K

