Return-Path: <linux-kernel+bounces-569837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7FA6A852
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B19188B1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCB22259C;
	Thu, 20 Mar 2025 14:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESZvqQar"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2705D2744D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480005; cv=fail; b=k7S/6H21xfjePMbslZkRRmpxx8ihVkWbDk/TfivuQnQuzenJmH5kHYVTaGrUOA2anuw6GlycIVsfCbx6kt0dfD+KC3u2Ngikw4j/5Yhcbb9BwjFNujIpnPC8tHqIJ0naucpB9ej6Fx/eGJ1hO0xRc24FwI7TgZDXhqjqq/BV4AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480005; c=relaxed/simple;
	bh=SD/kUKYFYQCguKXzXdyGb/wV2KMvwOBxwHcfRIrmC7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cJclk6IR0qgHIWzzW864B0s0368Lh+rdvpKt2CRNX4wQkoGwrfW+38SPghqw/ng7FoxAstgEd1LbW4rECIwGUD5SJOCLu3FW07DyYShUNVywcTai3vXf7kw1kqU9L0fp54ad82q6LFP8AbHXCWHeEoI/YLywvrwFoIXg9Yp4K9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESZvqQar; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742480003; x=1774016003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SD/kUKYFYQCguKXzXdyGb/wV2KMvwOBxwHcfRIrmC7M=;
  b=ESZvqQarP0vn+FAy7cU9RhYt8XFYs5xeW7mT8T5EuN9tJ8K2lrVeEHEq
   zb8iQ1L0w1Le1PZ2OnwBe5MJEyi6f0HWWjSIjySUjVrOsz5mp5eLr4wVx
   KDQdczwtr6wFDMTtLfGMD+zx/nqst3tGFWsOMkrQcIFeByQ5T1GlKBuJ3
   CFlLQ9t1oUJ+q8HZGbR4KhNwms+K0kO4eMA36YHUyQ77R9eUYCmAKn3r9
   VNoCN2MtewMbbmOZmJfLYj++AFnOPTKGRl+GsnZfkSI7w3M9QwG8w69wV
   VYFiP/PM7ipj5ChdelrpL3+5ZNBruq53jB9wIAz23xWVYfbjw0S8Owqhr
   Q==;
X-CSE-ConnectionGUID: kwK71cEqSPC0suidGXCqtQ==
X-CSE-MsgGUID: zZf+wS48TKealPOonp2dFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61104052"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="61104052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:13:22 -0700
X-CSE-ConnectionGUID: ApPKgrdpRjK5UqiORHGRhQ==
X-CSE-MsgGUID: nOhNkypIQ6+kcORj9GWDZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123115257"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:13:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 07:13:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 07:13:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 07:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvDyy77d7PQs4HzLdvdp44uycXJQ7OEUC9QKBFEB76E50+V60bXhqK6eE4QVko8R/bwDtBY2gEQB76QDXjXeHaE4CbVExceTuW+IlUsaNGiR4x6X+0wV1BqnHyghebEZXjFu8hOuCcEusAod/4m6pW+q95K96TIrPWPgkbrQDYZ0rnz7oH2WoAV9W/77MFlYjftioBTvZl8Xq3h0E1l4i3Z1BQkBPAZnyBvM4+C1BhOPeT+1ZekkEPnObC//xziVtkAvD9Yp1hDnx3U0xlJsmmWlNzUX7Ll86FaoH84aEgb0ZRP2yXGdXYPhz2vSiGNKdmsXuwRjH6aRBMXGpdlDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD/kUKYFYQCguKXzXdyGb/wV2KMvwOBxwHcfRIrmC7M=;
 b=i9Xo6lWPLQAdtFoiDiZDQNvmL3uiGNj2oqE5k+9ur5dfJG4bQG7+0QW4jOuil/e3abX6GinUTNcwznbJB5AyOgOaiPXAxwK8mUDowZN7F93+54fEINKwhBNIfv9Vt7bFbsST5yxp7HBJQ2+U38zV4lGKXwXQVzrVhe7GrVUqWPE9sL7BG12zw99sWUX/Z1OkWSa96dIQ5peRiJ469Uz/bULjsCSu5nBAfK8n04/O2TNsoZdAMbn7e12DnKdGW5U2hfo7fc/e1r0ck1boPRwexpZBUU5H8E137TmbMZka5K5piOomcAEz7BIwnxoLB36dOBJ3/4VU6yUhl0qIBLHU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS0PR11MB8763.namprd11.prod.outlook.com (2603:10b6:8:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:13:17 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:13:17 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mei: vsc: Use struct vsc_tp_packet as vsc-tp tx_buf
 and rx_buf type
Thread-Topic: [PATCH 2/2] mei: vsc: Use struct vsc_tp_packet as vsc-tp tx_buf
 and rx_buf type
Thread-Index: AQHbmA/TVrDgahiUvkisQd9TwLJ6YLN8FEbw
Date: Thu, 20 Mar 2025 14:13:17 +0000
Message-ID: <CY5PR11MB6366588F2A7806BAC785520CEDD82@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20250318141203.94342-1-hdegoede@redhat.com>
 <20250318141203.94342-3-hdegoede@redhat.com>
In-Reply-To: <20250318141203.94342-3-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DS0PR11MB8763:EE_
x-ms-office365-filtering-correlation-id: bb3fdaac-f0df-4a8d-2ac1-08dd67b95c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MGlhZWtENVNLb2EzYzR2Y0p6b0ROZlhUTGRiUlg2bU9sSjdYYUx0RzRQaFNm?=
 =?utf-8?B?Mnl4ZENrbjdFZGN3R3BIanp1c2JaSE1Xb0JSYXNLSy9CRzRubWpoL1lKMkZD?=
 =?utf-8?B?SnZZZ0l5N1pGZWtkeDhFc1FGelJoR1R0a25wOUcwc08yN0I3SHRhSWpEYW0z?=
 =?utf-8?B?NFBRekhWMHY2Z0YycFRWZ2p0dFVkWk1OZnBpSE5OZEVaYlpSV3pDTDI1RzRR?=
 =?utf-8?B?Y1dmQUVWL2lSODQ3dlNoY0RUYWxPZjhvSHBnMStGSDdYZnhEek55TUhsRWNh?=
 =?utf-8?B?VGlGTGc0ampRVDlXVEFTK1lRT3dKOVp4QXdVSm9obFhIMlFJdm1ncHFCdVlX?=
 =?utf-8?B?ZlFOcGt0bkZHSzlYRkJ5VDZVbmVJRHBKVEIxMVUzR1loMW5GR3Y0WnkwaitQ?=
 =?utf-8?B?WW95T2RTNWxuenlWZDA5UC83Q3pKYkJJaVRTZkpYazhwSTl1L0E4RDZKNTZl?=
 =?utf-8?B?dlJOVUNka0U1ZkZ1YzdvOEkweTk1dm5ISnNUQUk1UWtyaHJtQVJhV1JacEVa?=
 =?utf-8?B?Qld1djZGN2YvQkdlei85U3JYMmk1amZpYXdPaUpOSWhDTUs4YzZrbDNFd3BO?=
 =?utf-8?B?L0EwbUpMYjdCQjZ5QkZhQ1YvQWFVdXJSZDVpNlRIc1dKbGRacTBVNWtPcU1j?=
 =?utf-8?B?WmVWd0dlSlo3VjFJcmJDWVV4eFBuZHJPRWd6KzVQVjB6R3BhclF3R2JjTlFW?=
 =?utf-8?B?TmFMYldIRXhkTmFiMjJpMUd2SzZnSXduNWJrVkwra0RoWHV1eFZocGI2VnJj?=
 =?utf-8?B?T0RRdUo1WGFFRFRpTVg2LzhBeUJENXV3RitqTlQ3dndMSVVINlpWa25BbjRt?=
 =?utf-8?B?dG83YXlrY0d2eFloODVCcUlIOGJFL2h2Mnh4REMxeEhKNFk3QUQvZWU3UENU?=
 =?utf-8?B?bDRHMzlCRG04NHU0RDB2NzFzQVlTQlJtVVpmdVgzWitmSVNKVmh1Y3lCTTRp?=
 =?utf-8?B?bGtRdXRtTFB5NzAyRWVtdkYrQm5hZHdLaHd3WkJKL2JZWGFMeWhSUTZ1a01V?=
 =?utf-8?B?RXdDUjlqNURib2orRHhsMUJJMzN5ZXRURlMxRmtzT1JXZ3Jray9BZk5ObG5j?=
 =?utf-8?B?K1hVa254bHArU1ZTeWtGRzRFWWVTVi9EWmVWRlpWSjF4cEZodHh6bDFFSE1E?=
 =?utf-8?B?Y3crTVNVbXl6Z1h5azFjS1RLUTZwRzJLTXkrN2wvcHJiTVB6QlgreTFUeUdx?=
 =?utf-8?B?cHBIbEhPVHl3b2xzQUV5THJZd2REdWNCRzZBdzQ2elFORnVuMC80S3U2bDVh?=
 =?utf-8?B?NkZiVHg4b0JNMFJTUlQ0MVp0TytFZDlkeVQ4QnZYQWc2RlVpTHd0NUVVTm83?=
 =?utf-8?B?SVh6U3FXZlpEcUdad0xsNmZnaHpkM1M3Tm9KMHFpbHBMUUpwRmtPNXVENUdQ?=
 =?utf-8?B?QXUyUmtNV0g2NXNwdDdWYUFxbTdpQTRVa0V4TENhWTZ6UkJMRFZTT0lSdWNR?=
 =?utf-8?B?TUorWURveWZBTGtjdXFDUS9kek1Qb2JObjlFNkxzR2Y4d2ZjZFpNbU5iQXhY?=
 =?utf-8?B?ZnRNMlNHODZFSjFSb2hOaEYrTk5jUG5ncExjN0RpSzFqL08yVUpXVGN3QWc5?=
 =?utf-8?B?TmZSS29TWExqVWZuUU82Mkx1bkNoWlNVaDVEVzVva2dtYjc4cmhUNkpoZTZD?=
 =?utf-8?B?YzRTZFN4ZnFrMFBaY0NrWTlFZTdOd0RlLzdVdi9EZFdFTktFajBYTkllYUwx?=
 =?utf-8?B?YmNKb0NlUjJqZnpWZ0NiV1UvYVh6R3RmR3YyMUtqRXRCUnVuVXovcktxTUFz?=
 =?utf-8?B?ZzVtbjY4d3VmYnphNkROTld1S0dSR1V2OVJ6WVora2ltbWRHUCsvRFEvZ1dr?=
 =?utf-8?B?RVU1YXJTNVl2SEdNa2xkenpTWFo2SXJUK3dCbkF5L0dZWU00ZUxvKzhBTUxt?=
 =?utf-8?B?cldDeFpnN21LY3ptUExVTDR6dEpSY2hrOE9NTE5VRHV3Uk8yaGRCZVYyQkpw?=
 =?utf-8?Q?eG6Doe3eG/2c+usfTxkaATU9r2++m3SS?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFNUTlJUS215UjNuTjZYMDg4Nm1ORHFsZnExUUFjaW1MQTR2ZWYzMkREU0JF?=
 =?utf-8?B?UkZVbkxuU0o5d3kwZCs4MnNqaUQvVVhTME9URUN4TDdkVVd4VkROYWV0U1R0?=
 =?utf-8?B?WFFSVWd6RXR4L0Q1TlBvSk9jUElmOEc2blQ1cE1oWTFuVWt5bnZzeXNUZFFi?=
 =?utf-8?B?cE94TkpVT0R2bEhqUHJzRnBvaFV2bjFlU2VUcjJEdzhMZGY5V1hDN0pLMGV0?=
 =?utf-8?B?L1ArY2pmVWdwN0VvU28xRFJIZ09Gdk1wS295TDMycXQwMGtmbmJTYUtTY2RN?=
 =?utf-8?B?R2hoV1ViTnBJL2VlWTJYMzYxeHNMOGt5d2VQaTIvUFFwc3MreHpuWVZzVm0r?=
 =?utf-8?B?S2ZxUXBZakl6K21sa2VwTkdlUVl4c3JJQXI4VlNZVFkvWnZWVXd1dzZoTWRv?=
 =?utf-8?B?OVkrbjdwcWRyekU4RXZpcGZjK3FYQkFPbTNtLzc1ZjZGV2Uxd2dvN3BQQTEy?=
 =?utf-8?B?RzhaaE9YSWhBZDVKVlRNbmMyY29FZVVjRkJkZksxekI0NU9QK2RETE5peG0x?=
 =?utf-8?B?NXdmQ28zU1VDcEJUc0V5aVZObVhVYnM2endkR05zU2lwNWpBUHRFcmxST2Nk?=
 =?utf-8?B?N1BheHZlcTVHL3lGMk0xYTRXNVZKOXQ1NWMycjk3SXprU0M3NFdoSDVOT3Nh?=
 =?utf-8?B?eTFzRHAvRGJYbDZjQjRRYktQQkhVTTB1V0lRVGx0K1cxMUZnemlGMU9HbS95?=
 =?utf-8?B?alBXNlRIK3N4cERZNFhVdjZlVFN3N2psVmFnditYczdLOGFVamdKYk9iWHJQ?=
 =?utf-8?B?a3d5dnY5bG5xRW1RS1BiNEpTcWtOWHQ4bzc0cTdReXhWaWdRdnlNeGNraEsw?=
 =?utf-8?B?NnFVVU9rbWZNYmtKUE16Ukt4dlMzVWpkdjlwUlJjQ2RWcW56aHB0b3JsZngr?=
 =?utf-8?B?Yzh6WnNpMHJvK0FvaHVKQStPZ3ZubHRFRGM2RkpSYWxuUnRzWnk5Z2R2cUVp?=
 =?utf-8?B?V3BLSkE3RE9FV3d0cExlOThOUHYrUkZRcTVxNS9TY2F6RlJVSHZzemNoWmNM?=
 =?utf-8?B?bDRRWWVYZWJsUW5DRm9GaVdaaUxSZUlIbnVKZHJ4OHZIRkhmeTVKOSthcDM4?=
 =?utf-8?B?R3dwNWJaRlRQNm5sMG1Kem9ESjhHVkRBYUNVUFVkT2VnaXZoMnJYaHlMWU14?=
 =?utf-8?B?QmprV2hLdVh6LytXWEh0bjZpSy9Sd0FkY3hSL1YvZTdFdzZJdTVDcjdYWHZI?=
 =?utf-8?B?b3lxUGZ6S0NaWkk1MjlGTzRsTzhNdXV6ZWswdmZpNjJlZFR1TjNvN0dZb2N2?=
 =?utf-8?B?d0Noa05uU3pxSUNBcEhJVlJKMlJWYlM5bldsdlloZ05GVXZ3WHoyQTgvKzRL?=
 =?utf-8?B?M3ZXKzFHZ3RIRkJEa3VOMkpuSHV6OFlWNmtPLzU4VVFheGhkK015eVhvVmhT?=
 =?utf-8?B?N3hPNnNONDZSZnVEVisvVy9hOVlUdmpmOUFSRmlyY09zdElvN0RCWkhyVmxE?=
 =?utf-8?B?c3pWcklNSlJ3a2ZLbGdhQWowWlFLdFlycE9BSjFueXRMcDJLUFdXTm9qNzl6?=
 =?utf-8?B?cGgxaEVtZE1YdWN0T21aSld3czBLZEhnSVRlM2FSZncxNFdWeFBBV3R0U3Nh?=
 =?utf-8?B?R3JMOEJiS0VtSUo1UTVxQjdFS0tyTjFkVmk1N3U1Wittc0FTK1h4Qlg2YitN?=
 =?utf-8?B?bVNLa2lqTWJvbjJWRTRiZWsraERRNHdlZDgwMmRIdXdZMEVpWkc0N0VwVEpB?=
 =?utf-8?B?SWQydWo0Qi9ja3VPbUFyckEreHp3SlJzZkVkMnJSb1pNTlgxMWlKT1NpN3dZ?=
 =?utf-8?B?UlR4YWJVZzhlTUdHMmUyVVFxZmVRNkxzQzF6Uit3VFVTNUNEUDAxQnVHRlNi?=
 =?utf-8?B?WTJXdWswUzNjSUlxQlBQWHhGNXU5Z2VQQ2FZbkRscTZ5RTVwWUtkakZxbTNQ?=
 =?utf-8?B?WlZmRXdSSjdoK2ZkOHI2YlJGd1UrYUJra0x3VEc4REFIOFRIYjgrOEZ3cU45?=
 =?utf-8?B?bjlaZlozc20rS2hHQ2pLY3kyWWw0bFpKMS9NWnFzT1hBb0M5UVg1cEJ5WVVm?=
 =?utf-8?B?MmswYlRrZUR3R2pncVc3TzgrVlhGcS8xUGpzZWdrcWNrQmN1VllTSUxiK0xm?=
 =?utf-8?B?Qnh1elB0WjRqbmNYODAvcnBkQTRkRjc2Zi9nMjNiOGE0Vkw0NVd6MDRFV05K?=
 =?utf-8?Q?Kwzb1AWsMZfiPYdFVLE7EgD4N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3fdaac-f0df-4a8d-2ac1-08dd67b95c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 14:13:17.1023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sl1hjQxowECmuao6Sd+Eh72jCIINh6ymWyHrpbj/fKy5s+PXkyFwhijFlPg+itGNuLSgvJeeZmNHFGHBgh0thJAylO2uSznb6J9ms2+NlXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8763
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVn
b2VkZUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxOCwgMjAyNSA0OjEyIFBN
DQo+IFRvOiBXZW50b25nIFd1IDx3ZW50b25nLnd1QGludGVsLmNvbT47IFVzeXNraW4sIEFsZXhh
bmRlcg0KPiA8YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPjsgQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT47IEdyZWcNCj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+DQo+IENjOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsgU2FrYXJp
IEFpbHVzDQo+IDxzYWthcmkuYWlsdXNAbGludXguaW50ZWwuY29tPjsgU3RhbmlzbGF3IEdydXN6
a2ENCj4gPHN0YW5pc2xhdy5ncnVzemthQGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDIvMl0gbWVpOiB2c2M6IFVzZSBzdHJ1
Y3QgdnNjX3RwX3BhY2tldCBhcyB2c2MtdHAgdHhfYnVmIGFuZA0KPiByeF9idWYgdHlwZQ0KPiAN
Cj4gdnNjX3RwLnR4X2J1ZiBhbmQgdnNjX3RwLnJ4X2J1ZiBwb2ludCB0byBhIHN0cnVjdCB2c2Nf
dHBfcGFja2V0LCB1c2UNCj4gdGhlIGNvcnJlY3QgdHlwZSBpbnN0ZWFkIG9mICJ2b2lkICoiIGFu
ZCB1c2Ugc2l6ZW9mKCpwdHIpIHdoZW4gYWxsb2NhdGluZw0KPiBtZW1vcnkgZm9yIHRoZXNlIGJ1
ZmZlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRo
YXQuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFVzeXNraW4gPGFsZXhhbmRlci51c3lz
a2luQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbWlzYy9tZWkvdnNjLXRwLmMgfCAx
NCArKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL3ZzYy10cC5j
IGIvZHJpdmVycy9taXNjL21laS92c2MtdHAuYw0KPiBpbmRleCBmYTU1M2Q0OTE0YjYuLmRhMjZh
MDgwOTE2YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL21laS92c2MtdHAuYw0KPiArKysg
Yi9kcml2ZXJzL21pc2MvbWVpL3ZzYy10cC5jDQo+IEBAIC03MSw4ICs3MSw4IEBAIHN0cnVjdCB2
c2NfdHAgew0KPiAgCXUzMiBzZXE7DQo+IA0KPiAgCS8qIGNvbW1hbmQgYnVmZmVyICovDQo+IC0J
dm9pZCAqdHhfYnVmOw0KPiAtCXZvaWQgKnJ4X2J1ZjsNCj4gKwlzdHJ1Y3QgdnNjX3RwX3BhY2tl
dCAqdHhfYnVmOw0KPiArCXN0cnVjdCB2c2NfdHBfcGFja2V0ICpyeF9idWY7DQo+IA0KPiAgCWF0
b21pY190IGFzc2VydF9jbnQ7DQo+ICAJd2FpdF9xdWV1ZV9oZWFkX3QgeGZlcl93YWl0Ow0KPiBA
QCAtMTY0LDcgKzE2NCw3IEBAIHN0YXRpYyBpbnQgdnNjX3RwX3hmZXJfaGVscGVyKHN0cnVjdCB2
c2NfdHAgKnRwLCBzdHJ1Y3QNCj4gdnNjX3RwX3BhY2tldCAqcGt0LA0KPiAgew0KPiAgCWludCBy
ZXQsIG9mZnNldCA9IDAsIGNweV9sZW4sIHNyY19sZW4sIGRzdF9sZW4gPSBzaXplb2Yoc3RydWN0
DQo+IHZzY190cF9wYWNrZXRfaGRyKTsNCj4gIAlpbnQgbmV4dF94ZmVyX2xlbiA9IFZTQ19UUF9Q
QUNLRVRfU0laRShwa3QpICsNCj4gVlNDX1RQX1hGRVJfVElNRU9VVF9CWVRFUzsNCj4gLQl1OCAq
c3JjLCAqY3JjX3NyYywgKnJ4X2J1ZiA9IHRwLT5yeF9idWY7DQo+ICsJdTggKnNyYywgKmNyY19z
cmMsICpyeF9idWYgPSAodTggKil0cC0+cnhfYnVmOw0KPiAgCWludCBjb3VudF9kb3duID0gVlND
X1RQX01BWF9YRkVSX0NPVU5UOw0KPiAgCXUzMiByZWN2X2NyYyA9IDAsIGNyYyA9IH4wOw0KPiAg
CXN0cnVjdCB2c2NfdHBfcGFja2V0X2hkciBhY2s7DQo+IEBAIC0zMjQsNyArMzI0LDcgQEAgaW50
IHZzY190cF9yb21feGZlcihzdHJ1Y3QgdnNjX3RwICp0cCwgY29uc3Qgdm9pZA0KPiAqb2J1Ziwg
dm9pZCAqaWJ1Ziwgc2l6ZV90IGxlbikNCj4gIAlndWFyZChtdXRleCkoJnRwLT5tdXRleCk7DQo+
IA0KPiAgCS8qIHJvbSB4ZmVyIGlzIGJpZyBlbmRpYW4gKi8NCj4gLQljcHVfdG9fYmUzMl9hcnJh
eSh0cC0+dHhfYnVmLCBvYnVmLCB3b3Jkcyk7DQo+ICsJY3B1X3RvX2JlMzJfYXJyYXkoKHUzMiAq
KXRwLT50eF9idWYsIG9idWYsIHdvcmRzKTsNCj4gDQo+ICAJcmV0ID0gcmVhZF9wb2xsX3RpbWVv
dXQoZ3Bpb2RfZ2V0X3ZhbHVlX2NhbnNsZWVwLCByZXQsDQo+ICAJCQkJIXJldCwgVlNDX1RQX1JP
TV9YRkVSX1BPTExfREVMQVlfVVMsDQo+IEBAIC0zNDAsNyArMzQwLDcgQEAgaW50IHZzY190cF9y
b21feGZlcihzdHJ1Y3QgdnNjX3RwICp0cCwgY29uc3Qgdm9pZA0KPiAqb2J1Ziwgdm9pZCAqaWJ1
Ziwgc2l6ZV90IGxlbikNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+ICAJaWYgKGlidWYpDQo+IC0J
CWJlMzJfdG9fY3B1X2FycmF5KGlidWYsIHRwLT5yeF9idWYsIHdvcmRzKTsNCj4gKwkJYmUzMl90
b19jcHVfYXJyYXkoaWJ1ZiwgKHUzMiAqKXRwLT5yeF9idWYsIHdvcmRzKTsNCj4gDQo+ICAJcmV0
dXJuIHJldDsNCj4gIH0NCj4gQEAgLTQ5NCwxMSArNDk0LDExIEBAIHN0YXRpYyBpbnQgdnNjX3Rw
X3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAJaWYgKCF0cCkNCj4gIAkJcmV0dXJu
IC1FTk9NRU07DQo+IA0KPiAtCXRwLT50eF9idWYgPSBkZXZtX2t6YWxsb2MoZGV2LCBWU0NfVFBf
TUFYX1hGRVJfU0laRSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICsJdHAtPnR4X2J1ZiA9IGRldm1fa3ph
bGxvYyhkZXYsIHNpemVvZigqdHAtPnR4X2J1ZiksIEdGUF9LRVJORUwpOw0KPiAgCWlmICghdHAt
PnR4X2J1ZikNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+IA0KPiAtCXRwLT5yeF9idWYgPSBkZXZt
X2t6YWxsb2MoZGV2LCBWU0NfVFBfTUFYX1hGRVJfU0laRSwNCj4gR0ZQX0tFUk5FTCk7DQo+ICsJ
dHAtPnJ4X2J1ZiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqdHAtPnJ4X2J1ZiksIEdGUF9L
RVJORUwpOw0KPiAgCWlmICghdHAtPnJ4X2J1ZikNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+IA0K
PiAtLQ0KPiAyLjQ4LjENCg0K

