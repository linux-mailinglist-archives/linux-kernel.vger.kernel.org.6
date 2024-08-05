Return-Path: <linux-kernel+bounces-274550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFE79479E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD5D1C2112E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A2B152E02;
	Mon,  5 Aug 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6BTGS1H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101918040
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854050; cv=fail; b=P3cQZE9u9GTjvY4Ak7/NESXEqg0evJqUvth3TZw2ZxBowgT2IYeFrTo8KeMPRhzS/xIXMDIxsy2JqFNeTwalxlDQcbGg86NoJMlCTblR5k4CCAuCJQjaOKHb/HrGEYIQD0S/+vKSGEdQh2yw7n6+23mmh0EAPEHi9Tn49h/d5qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854050; c=relaxed/simple;
	bh=qCd79yTQ71yapsUK/aZf6OBYduzH3fE32Xw3SkJxZUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYpiqPu/ZFQFvT8QPyqsiiHOL0n7oIPVAHF/wJZ1Bx8lBXCP4DGHPLx7KE0x+moqhs4DkaFqO9cvxbWoJgGP5UZNGfYSTC8PvihcDPZCDz8VZs+RxWMFh54qiCknSdqyrJvkuGLCi3cnrRT3bAC0mSfwsCNitnI83HjDB5+fV54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6BTGS1H; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722854048; x=1754390048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qCd79yTQ71yapsUK/aZf6OBYduzH3fE32Xw3SkJxZUY=;
  b=n6BTGS1HgF1ZeCcebBsuQasw9N4mneUKLQS7HPmH0IrOKejJY3yYVlF2
   aMsmJPMrTP+VaSrzrzsPRHDLl0oNaxQVPJMpHEtndXO/4UNTK+V5XaMzX
   Y1nW+yjlMcbYHhc9Pylnd47VLZUftBe04GnZac1AhZfxXy6XwO2niuBgp
   f3wHkIC9fnNTSxq+W3Nb8E2x5Qs5DdbVMBfsHryicyk4D1PMlAYIJWS7k
   osqGv4bHNlXyJNNg1HmugacWADJDIgomd/gAbMt5NZozsywnKLx1sMIGq
   Yez2+ym9OknIDf4OE4KYJhs9++wqZxTr7Y0wQ3LEjz5mjc0RdePylloQT
   Q==;
X-CSE-ConnectionGUID: pzxJEo+wR5q7HR4106E7zw==
X-CSE-MsgGUID: 7MdPSZSgSXWdNBQNh1SP0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="23721449"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="23721449"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 03:34:07 -0700
X-CSE-ConnectionGUID: LKnS01JHSNyJl8gsoCE7gQ==
X-CSE-MsgGUID: ZfF/nZsxTbautceX3DCczg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56044738"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 03:34:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 03:34:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 03:34:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 03:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ2kFw5Ni6UaYhlrjlEI6wbQ2H17sx/enlgiqh2NB8s93JxAhDx+IqKpXnlyd7zPU/tMgHI9VWV4r2VFLil8Ip9tbDkMbHax65jNS9q9mNRY3B4U4rraO1ScaelYSmqKFNxhT9nworYHeLSYDqhO/Co+qQpiO0SWFm40lq+QXzFOhCIRi6WIum0jX+3rKtODQjpVO+OF2fn9ZWNmo8Pfvi09ILtt75Akbg4GvpArlMvwwZqa10yqwe/HvnrvVI0os8myT0LEFJiRakKO6UsSqSc2njUMTT2xpHdjs+noqcy2LXRM8OTbN+9r74Isl9kGoFZnolL1Yg1AnnH5P06rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCd79yTQ71yapsUK/aZf6OBYduzH3fE32Xw3SkJxZUY=;
 b=Bf7gRWvlsx4Wldf3XNvxDRqef3qSsff3QHrsGO6m9wLRenGfP2kojpLIYFMj+YKdwr8XZGiDWDsx7CW6X3lMCvg3XqoGMOJwxwMQq3o7m9vqcpGABF3KH2UDZuZMIt458MGWsUKMVkVt0iRTJXLSjESUN68OhjqfMudsY+Prln307bASV3SvK92xy/Y/cogMIiDvwYkQMBfedfPjIq6O3RhFBunuHy8b6nmND96plh7Nf97Pp7sQxfhf7pmGnYouWt0VidWF1cYLkQM+mPI1JzJHb01+IRkOTG1zDbMPklBbvh5ixLEWnWnC7x3lwo6yZR9hYXHqn+ezouL1LJWWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 10:34:03 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 10:34:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>, "Wang, Yudong" <yudong.wang@intel.com>
Subject: RE: [PATCH v2 1/1] drm/fb-helper: Don't schedule_work() to flush
 frame buffer during panic()
Thread-Topic: [PATCH v2 1/1] drm/fb-helper: Don't schedule_work() to flush
 frame buffer during panic()
Thread-Index: AQHazVTP6n5sjozqBE6ytEPu6FZDZrIYc2aAgAAExgCAAAHGoIAADdEAgAAiTmA=
Date: Mon, 5 Aug 2024 10:34:03 +0000
Message-ID: <CY8PR11MB713494B76B50264CD16FAC8B89BE2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240703141737.75378-1-qiuxu.zhuo@intel.com>
 <20240805071355.42636-1-qiuxu.zhuo@intel.com>
 <c349e2c6-027e-4e65-800e-f30ac0a0a785@suse.de>
 <CY8PR11MB7134F297DE1D5F61A9FEA41689BE2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <da27771e-fa16-4356-bb0f-69245cc98098@suse.de>
In-Reply-To: <da27771e-fa16-4356-bb0f-69245cc98098@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MN0PR11MB6280:EE_
x-ms-office365-filtering-correlation-id: 374fa811-9a0c-4464-78b1-08dcb53a2059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZWxqc3QvQmQxME13ZzJEYTdOWk0zRU51R2ttVDNKMDVkUGZlYit0WDlZTTY2?=
 =?utf-8?B?L0JzbEY0dVlIUEg4TjNYRExka2FYYWZ6dDcrR3RNMDdBSEtGdVBCeUNSY0ha?=
 =?utf-8?B?VmdKbnExL0x5VHd6L2dnbVQwN0RkUjBuUXhTbWhFTHRaRzk5dll4QWxQeFZi?=
 =?utf-8?B?ZUxhdkVHM0lZOWtWclJyVi9xcVFzUlNPdG9EUityM0FhZHJCRXovZ3I2TGJH?=
 =?utf-8?B?OXc0Q3RmVG56TnhkeEtWQ1pyei81Y1JnS2EzN1IrRXBCOFZSQm81RUhCNnc2?=
 =?utf-8?B?RnloY2tQMDRKUGh5UXJXV3BBVlVKYVZPa0QwWDQ2MDY4c3ZPZnhFM0VKZVZK?=
 =?utf-8?B?MGwyQ0cxM2I2NWhOakliR2htRjZrbTBkVFJhTzhFREVIdkFUY0N1RjJodWFm?=
 =?utf-8?B?T1hzVFdIZ1c3a1lwMU1RNFFXeE1rRUhUTHVVNXpwRGdYM0Z2enRNMW1XT3lB?=
 =?utf-8?B?dVBWVlovTWpYUExXQTNwZUJESFVPR0I1dWVTMFpJZCt5ZURuWkZjZWVLYktX?=
 =?utf-8?B?eFBrUHdCTHR0TnkxQVlFSlhYbjR1Rk04aXlwYWcza0h0Y1RWTzY2eXNXdHQr?=
 =?utf-8?B?eGpSTUs2Mkw1eWU3UGxUVWJma1l2T0w5VHhYNm9SRFp5UXR5TXE3OW1MV1do?=
 =?utf-8?B?eWtSYVcxS3FLQk5JY2JnMFhEOXFOcXF4M2N6a2VndjhIVDRMK3R0UXp0ZWJ6?=
 =?utf-8?B?ZmtqZUF0UlowdytSbWM2RVN1OWFqck5Sam5WZklDRFR0Tk1hdWJ1M0wwQnVh?=
 =?utf-8?B?MWE0TC93TStnTXFrU2dCQmxsZEErbm52VlJwNEpOVHhYUlN0aHl3Qy84bGcz?=
 =?utf-8?B?aWw0aFpHKzEwZXIrUUNVcHJtaFFHNnJoRm1NK2tmNSt0dkEzQ2VOcmZJV1RL?=
 =?utf-8?B?UzJnVHFqU0FmS0xrRlJIUU95WjdIV2FhWUNkNHMycmFMNjBQMDZBOWkyOE5a?=
 =?utf-8?B?NFpqbXVVOXZWNzNncTNISVU0NUJGRlJtTHNaSk0xd1N0b1p0ekdxYjRQV2tY?=
 =?utf-8?B?N2s3aVRYaFNCMFdkcmJnV1VEM1NYZTRvVURLVS85U3ZvRkJZNFZiL2VWTlZN?=
 =?utf-8?B?SGxvbTdldTNCTEN4Y2VHTXF6dkx6bFR2NnpIWStvMjFuMlkvbFMwNW9hdjZr?=
 =?utf-8?B?OHA1djhhdXMxR3FwMHNkaHUraXVJR2hMUjZSeUtMcXNxTWxrb29saXpaN25t?=
 =?utf-8?B?clJER1pWczhCWGpyNGVQQVgxeVlhU3lNV0NYTGdaUjhvbEVCSS9LRVN2T3ZZ?=
 =?utf-8?B?RUF4ZSs1SFV4VWlFek5kYzBKSjAxcTdYdyt3akRWc1YxTytaUlJJVld2d1pE?=
 =?utf-8?B?bjFJT1N4Y3RGY3pkNmxWTlRScklNTUlVVHE3L0ROeHR1ZEFhckQ3a1JyTEIx?=
 =?utf-8?B?bG9HVjNKdVFWWEZrQmY3QmNMNTBIcVp0SVh1dWNyemFSaFNWME1jek1uVlBU?=
 =?utf-8?B?YitmY25FSlJha0ozTy9IaDZpemloU25UVEZDSHFUeDlpMnVpQllYN1k4TXQ4?=
 =?utf-8?B?OUZ4MXR2diswMFQvRVlJdXRWdnVvT2VpOGplMTBhVWN6QjgxWlRQYm1KRVZF?=
 =?utf-8?B?RWFiWXNsMnhOUFRSSWJzazdXb0lOVjFBTWFHZnU1eTE4YTdKYVFCM1JGVGE3?=
 =?utf-8?B?QW5WWXlVc3hyZHFBanhHc3BZMVV2dE1VTEV5dGt3T2dqaVkrdjRhT3JrODhm?=
 =?utf-8?B?ZnN2bG91RG5sWTNEYnd5aXJDRHgzR1hoTlBVM2daVzJkblRpQ2U3UGEwcGFW?=
 =?utf-8?B?U1dPWnRVb3NRU1FqSVpFbVlaeEF2bzZJRXk1TkRnYVlTdC8rS2JOT2hJb3N2?=
 =?utf-8?B?cmcxRFdZOTZZdlpaelFPaHoyK2xacDJoeWs3MitxSGkzSk1nWnRqQ1dGVFZy?=
 =?utf-8?B?UjdZMWxJS3puQnd3ODFZNTBRYlRjeXo1WW9xdXhJYU54RkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTM2Z2d2WXJDS3FCUHk4MWJJNmQxN3JBYzV6SnMyNEVGM3JxQWRoWldNbHNH?=
 =?utf-8?B?VEdQbUhNR0ZKTW9PN0ExRndvejZ1RG1JWFg2WVN2N0IzU2Z2U2o2NVRDSEpM?=
 =?utf-8?B?QnVZWXVDZGtoOEdxZ2k1UVJScStEeWZlUlBWb0MrOFBSRkJQcVFscUxqd1NC?=
 =?utf-8?B?NEtabjArR2pjaStFZjhEZ3JBTDBnTnZTZmFCRjc2bUd2TUVGSURtSnlTTXY5?=
 =?utf-8?B?ZTg2bytUMUIzOEUwMVdSS1F1aWl0OHJQRVdOTC9YNXBEZWZESjQ3NVVUNXh4?=
 =?utf-8?B?ekRsZS9naGxmWWtWeTRVMnVIR3V3SVJMeGpIbkxIRVRRNE90aDBOeEs3d3dJ?=
 =?utf-8?B?VVp4WktENHJrcTB1Mm5rVjRIZDh2TXJiZW1GMHFneXdObGJZN2R3dTVpWnRX?=
 =?utf-8?B?Nkx4a0FlUWg5NVBvVzNwQVdTQTlJNlQyelZiZGpRTFlmb1VhMStabXdKVjl2?=
 =?utf-8?B?a040OTRCamp0RS9XSHUvSSs0bml0SFRHcCt2ZUxxcDRKRkY3eW55Y3lVY1R5?=
 =?utf-8?B?aGVCS3U0R2VRQlZHVXM3VVpWeGZLckUwb0o3dTcyVXlUa2JxaFgvNWxKem9B?=
 =?utf-8?B?SVE1TEExRFNDMzN3bnNRc3hSMVdUcjdRMFNvdkZhMnE1Tms3Y0ZsekVrZVNa?=
 =?utf-8?B?eVZLd3pJSmliaUdQUVhjVmFucEZDMHV1RGprZkMyUHlGQ2Zmejc5Q1BRTmtO?=
 =?utf-8?B?Z2JyUktOU1B6N0drbWlSWDl6TmNIaWtKcS85OWl4Q3FKTjRVemljNmpoYVdB?=
 =?utf-8?B?eXNjNllMUmhkMmJudXNJcmhWSmRUUElYTGl4aS9sVC9oem45VDFVa2dFcjNV?=
 =?utf-8?B?ZWtmNkNpem5TOWgxQ1ZYTFRXZjRZSHN1NWppRHRtNW5mOEIrQVordjBMYWw2?=
 =?utf-8?B?K1hIUk16TitCak40UmtYZFVOS3d4MHZSNjVNamRxRG9uMmhjSE80K0RhbTl6?=
 =?utf-8?B?NFJkRFVhdXoyOVRQVWlicm5SZEtydDlEQXFXK3VjdStNaVkrNzNwMldhYjdt?=
 =?utf-8?B?TFFQWU1Reld6VXU3S1lCQWVucEhETGpBUUlXYWFsMDk3S0JUSWd3Ym1zeTd1?=
 =?utf-8?B?MGpEZlpLWVpsU2pteGlzOWdVdVBIMzhaWE8yVEJaQ2pqMFgvMnNkMyt5blMz?=
 =?utf-8?B?ckl0N2FlOCtabTBQaEVhRkQ5Q1dhenltWjV5elNtR3UwTXlnSUkremZCeE9D?=
 =?utf-8?B?MjJMT3lxTFg5dGdacDYybjI0Wk5Razd1bXNRay9hRkNZbEE3TEk0UVlDTm5i?=
 =?utf-8?B?YmlZbG5lR1BLUnZYeUg2bzVhMU9xMXM3NGVuZjIzWHg0OTRMOTFmUnJZZmdX?=
 =?utf-8?B?WS9FUXlyS2s2RGpCZkNlZ01mUWRvdXhqajRTc0dXK1hSSnBsbkJBcC9OZnVH?=
 =?utf-8?B?bHBJR0JSTWRJZFUvdnpCTEFvMk96cHJTcERRTlhTQUJYZHFiZmRYeWRPajBS?=
 =?utf-8?B?dDhIMTRid2pxM2t1ME4wa00rZmc3VnZSb0N1ajV2K2Z3VkQ3WTljdjVQM3Zs?=
 =?utf-8?B?QkNTVjhtbnJxb1I2UWxxbUQwVUxOYzgzNjh3NUJTQzRyaGtCTUxYb2hINFVp?=
 =?utf-8?B?ckk3dEpSZWdxZ2tGSjdua05jZytPT01HaFk3ZlBKaldvMVNQeXhJOElwYndi?=
 =?utf-8?B?VWFyQ2dhRE05SGFuTzk0SkczNUQrNVFMa2U5VXhYbnk0QlU1QWpBWmFkajAy?=
 =?utf-8?B?ODVadXhBQkUyTU1rMHF6NG16YVpHZTFNUE9CamtiNm9CYnJZcFdMTjVGdkxl?=
 =?utf-8?B?ck5TTU1VeFdQM1dLeVdlbVphR3c4MndOVDB3MW5BajA5eE9KSWc1NnpBWk1u?=
 =?utf-8?B?SWp2VzhaVDJta1ZMZ1pwTHBvRXFwQ1FRZlZrV2pyUUFFNFdZdXZZalliVWV6?=
 =?utf-8?B?QUYyRW9jcXVETk1TWm5QZ2puQkp6aklIVVpIUUlnbVNMUjk1WEdhRnNWN2Ri?=
 =?utf-8?B?U3N1L2drMSt1NFRBZjVLaHpRVXI0S2QvQzNzVmJvK0ZaK1BzZyswOU9ES1Zh?=
 =?utf-8?B?U2ZyOCs5VVhTTTdhLy9Ua1R0S20yMzBCdEJ0RjdJd2VHMVFMd3pNTU9ucmY1?=
 =?utf-8?B?LzNEZEE4R3JxN3BybHltNnNja0o2VklVU1lBQTZNM2N2VHMxN1RZM01lVWd2?=
 =?utf-8?Q?Z4FYfNIqYFUNxlmoQZ7wYcFTt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374fa811-9a0c-4464-78b1-08dcb53a2059
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 10:34:03.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcQSVElWpkFe8TtF6S52C59PnDv9A8I5ipU6D9jLEzv7UfO+2OQ8SKZ4h55BXuL9OoGgyU0bARSyEP0V3q/7Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6280
X-OriginatorOrg: intel.com

SGkgVGhvbWFzLA0KDQo+IEZyb206IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPg0KPiBbLi4uXQ0KPiANCj4gVGhhbmtzIGZvciB0aGUgZGV0YWlsZWQgcmVwbHkuDQo+IA0K
PiBJJ3ZlIGZvdW5kIHRoYXQgeW91ciBwYXRjaCBoYXMgYWxyZWFkeSBiZWVuIG1lcmdlZCBhbmQg
c2hvdWxkIG5vdyBiZSBpbg0KPiB2Ni4xMS1yYzIuIEl0J2xsIHByb2JhYmx5IGJlIGJhY2twb3J0
ZWQgdG8gb2xkZXIga2VybmVscyBhcyB3ZWxsLg0KPiANCj4gID4gZGltIGNpdGUgODMzY2QzZTlh
ZDgzNjA3ODViNmMyM2M4MmRkMzg1NmRmMDA3MzJkOQ0KPiA4MzNjZDNlOWFkODMgKCJkcm0vZmIt
aGVscGVyOiBEb24ndCBzY2hlZHVsZV93b3JrKCkgdG8gZmx1c2ggZnJhbWUgYnVmZmVyDQo+IGR1
cmluZyBwYW5pYygpIikgID4gZ2l0IHRhZyAtLWNvbnRhaW5zDQo+IDgzM2NkM2U5YWQ4MzYwNzg1
YjZjMjNjODJkZDM4NTZkZjAwNzMyZDkNCj4gZHJtLWZpeGVzLTIwMjQtMDgtMDINCj4gZHJtLW1p
c2MtZml4ZXMtMjAyNC0wOC0wMQ0KPiB2Ni4xMS1yYzINCg0KVGhhbmsgeW91IHNvIG11Y2ggZm9y
IHlvdXIgcmV2aWV3IGFuZCBzdXBwb3J0IG9uIHRoaXMg8J+Yii4NCg0KLVFpdXh1DQo=

