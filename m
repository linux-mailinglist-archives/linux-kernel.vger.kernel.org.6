Return-Path: <linux-kernel+bounces-536535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B8A480B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C8B7A7583
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FFE214222;
	Thu, 27 Feb 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INPsvcw2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1B17BA6;
	Thu, 27 Feb 2025 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665304; cv=fail; b=iq+icGGIN8DeOqG7Z1Jg8nqNVgtvbBLOXA3/1YEYa9BveG0/0cub/PW6ZXtN+jBPrEutqVnoyatLpIo1R/GXmbB9drGQO6SMwZPWWrnOeqqvDawOww+FUWtrf9sBu8wrIB/zd1Z81BOB+M6TNRS+XiazvaNIZ3BykI6tpKdFN9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665304; c=relaxed/simple;
	bh=Oq/XbbcANo5Yls9pXfyds2OBv8GkvYEHZHBsOQ8Hqek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMMdNlj5mtbCrM8mSZbWCnklGn9cNepB3SSjN5nxkHblecxUcwSmI8Txd1ITuUy+TQoKrhXs9swBjysilTrBs2R5cAgYsfk1kO5U0m4XEMxkJysbhL99WzhTiBbnoU8FvmhiOQrkojbg+ZcKm4WlacFVxS7b/i7uni/CjbaFHK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INPsvcw2; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665302; x=1772201302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oq/XbbcANo5Yls9pXfyds2OBv8GkvYEHZHBsOQ8Hqek=;
  b=INPsvcw26Q2NyuFmv1HvMqGpLQzk1D5OCdcwAGTOyDrS9pE1bAzmARzv
   9bpagrXsjSzoJCpdi5DF1dgR2zyhH1A5jAqibDUjsZ/wnFeuIFetyKg06
   6nwyQMXKNuq5kBw0HjuIgpcDFZfxp5nrpLMNul31UoZ9Kn/8jgmtfMMcv
   JJPZgC0nCZtZ3w0zjxM0uPj7PSAF0a4W6JTgizSHbOER1Yp4Fj6PiuUju
   2SfZIkTaD0cQStC0V6h+fQFcNCUyUHlboJDGkDYMLqZ4G2UY1PwkTE+j5
   i7z9Sx2RG4mwOdZDZwbQnMjj+m99kQWdqdvlp5ajpErqavScGgeXtyIhl
   w==;
X-CSE-ConnectionGUID: 7EQo6dMYTNeJ60XsqFAVsg==
X-CSE-MsgGUID: o29FXMqxSC+iVsgk82KtDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40794000"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40794000"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:08:22 -0800
X-CSE-ConnectionGUID: /BFSeIQ2TZ+X516bjxt8SQ==
X-CSE-MsgGUID: Fdb9hu35TtmS+qSBjjXxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121978406"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:08:22 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 06:08:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 06:08:21 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 06:08:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHH/O3yMj1togXqZJpnxeGETQdfQnk02DA8g9Y7SK/tnqjeYrsbnL0NlHQPQ+BMI1AxLfrDwxyyzCwI00JnI/MxPNLqG9426Gkn7MCbM7P9bOkoLtDXq5PfBL7iUw/erC9/6ZgbVokoWrUo8D9cS14Y55KAuyspDjBv8TmnN30jhGdQSqgjGjBhAjBE1sR4jlWANJDe1ifVPxmqYHR4B0FrHTm7nrGSHRo6o6RnJgDygxoijRENiC29MpUefK5M8IVNTnISVsmg5zZ9M8VwaULfhgw6hoWR6i1TlslDvIDMQehl3qO6gICIao0vMpXjHwh4nd9Ei6ey7grsqk5UJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq/XbbcANo5Yls9pXfyds2OBv8GkvYEHZHBsOQ8Hqek=;
 b=CyjHFWZedb7THes7xHtWxBznhu3LlZqTbKWu9fnCDkkyJi/I9bn+0f3ahv4HP7uBT8Jld5cfAYMH5j2sDDyPcYvG0JGYsQK8ySRXSJZiavgF1DujgiWBZTJoWccYJYewnGxXuYBOFYHIpEbp8Ntko96jiz8IJgAJ9LSPJSp7SBJlySB7BPs2VGhofZovmIt6eBn7EuB7P+EKYNyQI2bbHlXUU/aWXOby5kiRqtgwWTUHz+bLqbbpOtGoKiyecy/j13/pIks2MCOwOr7VvK22E2rGCUoHlw7vY/LUq8YpBruKvpekrggZls+BRV/ZmZZkNMixZA2857F/di/ZU/IZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 14:08:13 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 14:08:13 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"tiwai@suse.de" <tiwai@suse.de>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: "vinod.koul@linaro.org" <vinod.koul@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>
Subject: RE: [PATCH v3 01/16] Documentation: driver: add SoundWire BRA
 description
Thread-Topic: [PATCH v3 01/16] Documentation: driver: add SoundWire BRA
 description
Thread-Index: AQHbiQhnHeXZ0XTyF0yqkMRUy35Ec7NbGQUAgAAWtLA=
Date: Thu, 27 Feb 2025 14:08:13 +0000
Message-ID: <SJ2PR11MB84249FEDAD4207DBBCEF8844FFCD2@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20250227111130.272698-1-yung-chuan.liao@linux.intel.com>
 <20250227111130.272698-2-yung-chuan.liao@linux.intel.com>
 <Z8BehLc-D8-dKbe7@archie.me>
In-Reply-To: <Z8BehLc-D8-dKbe7@archie.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|SA2PR11MB5132:EE_
x-ms-office365-filtering-correlation-id: 1dad3447-5947-4992-28a2-08dd57382c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WGkyNTVNb3ZWT2xLRGRqcGdIemVVWnBra3dva3NGZDJZQmYwN2prZ1hEVG12?=
 =?utf-8?B?dW81Qy95NkR1Zi9HNDQ5TU9BZzFQc3YzeGlwdldkVVZIWE55aDR1ZDhEbjNR?=
 =?utf-8?B?UVd0RWtTUWlRaTNwQTZSc082QzUzZjlqMGVDY3Q5aTlQOVB1TVdZSHBYUkdp?=
 =?utf-8?B?MU1IUzNodGFXeERtcmhhclNhRWlGV1dtTzJoK2F6aThJbGhrYWFzM05BcDZ3?=
 =?utf-8?B?WU9RYVdrTWhLZU50TkpLRUZuY1ZnQzFvUGdqdFNUSEJFWndkU0lsWFQwaFE3?=
 =?utf-8?B?TElPeGpJTFpDazF5MU5hRG5oV2ozM3pDcExqNnZEYVkrS0g3c3pzV21FSFZG?=
 =?utf-8?B?K0N1MTRLRjFmNkhWa2d4R0JJQVkvRElPY3RVN2F6R214ZjN6NDV5Y1dxbDl5?=
 =?utf-8?B?MzNVcHphaEdwK3dCb3RCajFyM2tLUEVSckZNQlNVUWQwUlFvbzVvd1ZXMHZK?=
 =?utf-8?B?dFdKTVYyNkExSURrTU8yamd0M2tsNGtmbmZkSDR1QjB0UnVPSmorZFVuNksx?=
 =?utf-8?B?WmNUTGdjOE5vM1oxb2tsRUdYdUQxUWl6aEFPZkVhVkhVKy9meGkvUm43clBv?=
 =?utf-8?B?U2xMM2VIMUNtYU40dGFSUkdlMnhmL1VBS29JMGJRMGN2Q1QzNjVMZDh5UDg3?=
 =?utf-8?B?OWtWdjRqeXJPeVllYUtxcTE1WFpsT21OVVM1ckUzcEljNW10dTlmRzg2UXFG?=
 =?utf-8?B?STJ1N0dPRVQ1M0NmcWlLSUc4U1BWRDRTaDhaUnkyWU8vcytCNXJCTDJ3OU4v?=
 =?utf-8?B?Njdzalk3OCtrUFJzOGQxcElsSitqM1hqTFdpYVNnRitLUE1EVlptUUIreFNz?=
 =?utf-8?B?N21uS0EyeTB0OEFvVG5vM0YxQ1kvWk1na21idDJpbkw4TkNFODI2bFRDc0Zy?=
 =?utf-8?B?UmMrTzdDK0MwbTBvL2xlQXltNzdBRktlTnRnQmVDVkxCdnN6L1R4a3M4eWIz?=
 =?utf-8?B?TXN1b09DU0dTUXgycEM2ODl5RXdvNlBDcWVITEJPQm0yTXNqTTlFMGZIeFNM?=
 =?utf-8?B?blk1SFR4Z3cvaGFhWGRNUHNudmR1OWdHY2x2Szd2WUxNNlZZSm5TY2ExZW5I?=
 =?utf-8?B?UVU5b0MxaGMxSHV0bDNyRTQxeDZiZ1drTGJXUzE2TWRHQTFERE8rU3VSYkxR?=
 =?utf-8?B?czdwMm5iU3FmajRvVnRMS0IveHdzT3haRDFjbUtUOVlZSXUvWDYyOVR6RkNS?=
 =?utf-8?B?VXYwZzRJbkNXdXNNL1ZWQVRsUUIwUmx3WXVBc0NabXFVWUU5SlhVcU9qV2xQ?=
 =?utf-8?B?YjFDdHNrMUlVM3p1REcraFV1MUlYMTBjZ0RMUVVxRFp4eDVBR0dlZ2VIT1Zj?=
 =?utf-8?B?eGxqK0dtL3RsaU5DOHdRTlp0MXV5WDRrUEs4QWJrTkg3QlFldm1CYzVpc2ZM?=
 =?utf-8?B?RmhFcEtXa2J1V3YxSCs2MHZEdUoxUHEvMG5Tck9JNndzZTVzdkdVYnRwcmxH?=
 =?utf-8?B?RVRqRDh3b1hEYzJleDRSM0lwMklJaG1OVmVoYzZHZGxjVzd5SDFZK0xzOUEy?=
 =?utf-8?B?UFJkY3grOS8rNDREZ1ZoNEZ1M0ZSbEEvUmZDTHdFbk92a3BOT295M2pOSW8z?=
 =?utf-8?B?U1pib2JOSDg0WHExcFpoaHczY2ltRFVQOVpSTi82VDJWc3VaYWZnbWRNanh6?=
 =?utf-8?B?SDkzeG5JTEwyb1duRSthU3hOOVBRcDNmR0VWWGV4bHVyRkxoZ2h0UHNyZXFs?=
 =?utf-8?B?SmI2dkdVanRobDZnbHl3alJ1b0NXQVh6ZlFjdjFmSmNJL1JqVkVUZlRGYWFG?=
 =?utf-8?B?RzRUMHdZTVBjb0hEazhoWEl5NzNWR3FxaUtoYnRLZGhPYTYwejQ5bTBwWEVK?=
 =?utf-8?B?Z3MrUUNpYnM4cGtBVWx4UDVPUGR2SWNndHpFL3RhYWdGTUYySGtid2xsMUdR?=
 =?utf-8?B?WnNMOEx6aHFXVlA5NWpYN25RcWJHU0hHOTZHcDFyMjQ2TTF1MENyODNyaGRi?=
 =?utf-8?Q?Y7gWhxB22OOi/XIFE2lAodCMgr+F/VKy?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFFLTDY1bmpBRml0VUdSWStIdHhQbWowR1RNdHVKaWNRZ1NmalluQkMreHAr?=
 =?utf-8?B?T2dqSjE3L1N3aGpqSmZhb2pxeDlzUmhnUkNoWit2UmVtM1VDQlhWOFBJbzJE?=
 =?utf-8?B?R3JsV3VEUjR3UGg0eHJGbjcxK0RGcnJiOUFmc0tjK3h5RnVYajJ2ckxrTjgx?=
 =?utf-8?B?Qmpad1NBcFFyL1g1Y3F2WGVVNHB1REUxTklnLzRsWUtsckwrM084enVGV1lw?=
 =?utf-8?B?Tm9tRU9YZHMrWDZ1a2toWVIvMnFBY2hyM2tXU2hCalZsNlM3ZUxRbjZ5Nnh1?=
 =?utf-8?B?Qjl4WHJUa1BWOSs2YnpMTDY2d0NxeTZGM1VsdDhvQ2hQdGxJdWkrU0FZZWVE?=
 =?utf-8?B?eUxqOURhOU1lUi9temt0bU05MXJSb1R0WUYxZm9OYmR2cHdpcUIydWM2anVI?=
 =?utf-8?B?dHVBQlJ5MFhLRlJueTZiTjR4cUV6RkxrQTdkakJWenBhTnlzdERHb3ZUSGRF?=
 =?utf-8?B?SktueVVrY21zNEhvSjdTckQ1dXQ4bE9OWHdiNjBqMERlY241NGFoemZOcER5?=
 =?utf-8?B?TnpDUEd6OEc3Z0psUTlhN2VacThvNUVXWk5Nc3dUNEV3aW1jQ2NZcU9oQ0c2?=
 =?utf-8?B?S2FtQjF5WERZS2FQZDhzKzhJQUoyUWJObWRWVmc5L3hFZmYwbjc5UG9EZnlN?=
 =?utf-8?B?b1N2VE9ha0cwRTJ6cmNYRnRkMCtZYkhKNDJlNHpsMEYxSFMzeXdjbW5Pcitt?=
 =?utf-8?B?U0RUZkpEZmhvYnU4d20rV29CS2Y2d1dmd0pHeDdzMnlXbmJMeFkvNUp3Ymx2?=
 =?utf-8?B?RFV0MWVWa0NIUFNRWjlYREVyQUZ0aGY0b1RYOGd2Z3RoMXg0VThsMXE4akNI?=
 =?utf-8?B?RlR5SDVtelFrYzhLVXF2R0tEOTZsQXFQcFdPN05HMXpJMkM1NzZlVTJjU2JD?=
 =?utf-8?B?TVZLcmRNQlNhV1hKVXV2Uk9jbjh1N2hVak05NU5tSG1MR1MxZndSemUrKytm?=
 =?utf-8?B?c2pBT2tMV0ZHUytZOTB1KzN5RE9vY1JvUER2ZTdySEtLVE01WmNQVFhKSTlX?=
 =?utf-8?B?cWZsc2pzbk85T0tmeW9DelRSNFJOTGJoMnRmK0YzZWJpNmNVaUtZbU5qcTRn?=
 =?utf-8?B?aEd5dGdPcW5qb3RlaHoyTzh5aXBUbURmM2dpdTBidnk0R0tnR3NhS2dxSlNS?=
 =?utf-8?B?OSttOEw4dEswS1I5Vnh3SGgrZVNuU2txOURER05meHZPN1RqclJtTlRlQVM2?=
 =?utf-8?B?S21EMldiYW5GQS9YSk4xc0V6S25ld3NBUnYxQklYUVRSZHJDNmJhL2d1NndN?=
 =?utf-8?B?SG9MTk5jcytmcGNXQ2ZsMjhPZmkxdnVWLy95c2NFUUJvUmZxdTlXSjZEQTBK?=
 =?utf-8?B?cnp1NVVSWURZZHVmc0RRRHRCeDFaSGx3L0FhWnIvYUR1VGEvajhMd25OY2FE?=
 =?utf-8?B?NjZ2ODFGcjZMUDlzTTlrY05nUS92UENIREhQWmtBT0NHQitVQmNCZ0psVnVU?=
 =?utf-8?B?ZXZYRytCb0dmK0JSWlFGcVpFT2dhZVNpZzZzeVVYOGJ6REtXb3E3aTlPWHZI?=
 =?utf-8?B?Qk9UNmJZbVBwd0k2Wnk5MEVWQVgvK2l1eDBHcVZQaWJMbStvQUhPS3ZuZ0VI?=
 =?utf-8?B?ZDE4ZlNpQjBsWDBoS2ZQZDg3OU9vZnZkK2ZrMCtEd3pEUjNUN1NmeG1MVFpl?=
 =?utf-8?B?WURLRHBnVXYyb25KSURrclRYejVuYzN4NTA2MnhWQ3VLdm80ZS9razVZY1pz?=
 =?utf-8?B?TDZRWExyOHdsUTdocnRaMjZLaWcwaFpPV2c2U1Y3WWtWOWhLazFkSlRuaHdI?=
 =?utf-8?B?b21XK1BjZjI3NUloMGhtMEVFSkVxK0M5STNZeHhXSTZ5bDdWN2JRdmZCYWpa?=
 =?utf-8?B?VENuN2pJdno0YytFbkRGQXBaNEgzdVdTUlVLUXNIUTZ4OWVtaWNoRSt1cFg4?=
 =?utf-8?B?L09scUpuOHlvNmZMSmU2ZlhOd2lkMFpzdVVpMTJQUTlmR1B1d21pSVBhTmZu?=
 =?utf-8?B?b1hjdEMyK3VicEQyZkEwMnZPZGl0WDRlbDk1N0hSVnM4akJ3SjVDcGg0NnQ0?=
 =?utf-8?B?WVhnd09wMkQ2S21ZVE9ubG52OS9ldmZSM0tVeXliL0pPVTJKR2lETkZCKzU1?=
 =?utf-8?B?Y1k3TVMzQVh0Mk0vUGVIV0Qzb1dmOThIeVlIVWgvQTNDd1NNQWUvdkVIT0Q0?=
 =?utf-8?Q?oClY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dad3447-5947-4992-28a2-08dd57382c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 14:08:13.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnXSDP/nQauyvvwi0R7GJJwR84BP41AyGrt/+/bdoyo5X7rj3e/qb6W9KGd7cbiQbZyvm3vJJISECotyOndvRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFnYXMgU2FuamF5YSA8
YmFnYXNkb3RtZUBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyNywgMjAy
NSA4OjQ2IFBNDQo+IFRvOiBCYXJkIExpYW8gPHl1bmctY2h1YW4ubGlhb0BsaW51eC5pbnRlbC5j
b20+OyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJyb29uaWVAa2VybmVsLm9yZzsg
dGl3YWlAc3VzZS5kZTsgdmtvdWxAa2VybmVsLm9yZw0KPiBDYzogdmlub2Qua291bEBsaW5hcm8u
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBwaWVycmUtDQo+IGxvdWlzLmJvc3Nh
cnRAbGludXguZGV2OyBMaWFvLCBCYXJkIDxiYXJkLmxpYW9AaW50ZWwuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDAxLzE2XSBEb2N1bWVudGF0aW9uOiBkcml2ZXI6IGFkZCBTb3VuZFdp
cmUgQlJBDQo+IGRlc2NyaXB0aW9uDQo+IA0KPiBPbiBUaHUsIEZlYiAyNywgMjAyNSBhdCAwNzox
MToxNFBNICswODAwLCBCYXJkIExpYW8gd3JvdGU6DQo+ID4gKyAgKDIpIEEgQ1JDIG9uIHRoZSBk
YXRhIGJsb2NrIChoZWFkZXIgZXhjbHVkZWQpLiBUaGlzIENSQyBpcw0KPiA+ICsgICAgICB0cmFu
c21pdHRlZCBhcyB0aGUgbGFzdC1idXQtb25lIGJ5dGUgaW4gdGhlIHBhY2tldCwgcHJpb3IgdG8g
dGhlDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwZW51bHRpbWF0ZSBieXRlPw0KPiA+
ICsgICAgICBmb290ZXIgcmVzcG9uc2UuDQo+ID4gKw0KPiA+ICtUaGUgaGVhZGVyIHJlc3BvbnNl
IGNhbiBiZSBvbmUgb2YNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAib25lIG9mOiIN
Cj4gPiArICAoYSkgQWNrDQo+ID4gKyAgKGIpIE5haw0KPiA+ICsgIChjKSBOb3QgUmVhZHkNCj4g
PiArDQo+ID4gK1RoZSBmb290ZXIgcmVzcG9uc2UgY2FuIGJlIG9uZSBvZg0KPiBEaXR0by4NCj4g
PiArICAoMSkgQWNrDQo+ID4gKyAgKDIpIE5hayAgKENSQyBmYWlsdXJlKQ0KPiA+ICsgICgzKSBH
b29kIChvcGVyYXRpb24gY29tcGxldGVkKQ0KPiA+ICsgICg0KSBCYWQgIChvcGVyYXRpb24gZmFp
bGVkKQ0KPiA+ICsNCj4gPiA8c25pcHBlZD4uLi4NCj4gPiArICAgICAgOjoNCj4gPiArDQo+ID4g
KwkrLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+
ICsJKyAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
PiArCSsgICB8ICAgICAgICAgICAgIEJSQSBIRUFERVIgICAgICAgICAgICAgICAgICAgICB8DQo+
ID4gKyAgICAgICAgKyAgIHwJICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8DQo+IE5pdDogdGhpcyBsaW5lIGlzIGluZGVudGVkIHdpdGggc3BhY2VzIGluc3RlYWQgb2Yg
dGFicywgYnV0IHRoZSB0YWJsZSBzdGlsbA0KPiByZW5kZXJzIHBlcmZlY3RseSBpbiBodG1sZG9j
cyBvdXRwdXQgKG5vIHdhcm5pbmdzKS4NCj4gPiArCSsgICArLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKwkrIEMgfCAgICAgICAgICAgICBIRUFERVIg
Q1JDICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICsJKyBPICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiArCSsgTSB8IAkgICAgICAgICAgSEVBREVS
IFJFU1BPTlNFICAgICAgICAgICAgICAgIHwNCj4gPiArCSsgTSArLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKwkrIEEgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICsJKyBOIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiArCSsgRCB8ICAgICAgICAgICAgICAg
ICBEQVRBICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gKwkrICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICsJKyAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiArCSsgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gKwkrICAgKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICsJKyAgIHwgICAgICAgICAg
ICAgREFUQSBDUkMgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiArCSsgICArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKwkrICAgfCAJICAgICAg
ICAgIEZPT1RFUiBSRVNQT05TRSAgICAgICAgICAgICAgICB8DQo+ID4gKwkrLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICsNCj4gPiA8c25pcHBl
ZD4uLi4NCj4gPiArRWFjaCBwYWNrZXQgd2lsbCB0eXBpY2FsbHkgaGF2ZQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJoYXZlOiINCj4gPiArT25lIHBvc3NpYmxlIHN0cmF0ZWd5IHRv
IHNwZWVkLXVwIGFsbCBpbml0aWFsaXphdGlvbiB0YXNrcyB3b3VsZCBiZSB0bw0KPiA+ICtzdGFy
dCBhIEJSQSB0cmFuc2ZlciBmb3IgZmlybXdhcmUgZG93bmxvYWQsIHRoZW4gZGVhbCB3aXRoIGFs
bCB0aGUNCj4gPiArInJlZ3VsYXIiIHJlYWQvd3JpdGVzIGluIHBhcmFsbGVsIHdpdGggdGhlIGNv
bW1hbmQgY2hhbm5lbCwgYW5kIGxhc3QNCj4gPiArdG8gd2FpdCBmb3IgdGhlIEJSQSB0cmFuc2Zl
cnMgdG8gY29tcGxldGUuIFRoaXMgd291bGQgYWxsb3cgZm9yIGENCj4gPiArZGVncmVlIG9mIG92
ZXJsYXAgaW5zdGVhZCBvZiBhIHB1cmVseSBzZXF1ZW50aWFsIHNvbHV0aW9uLiBBcyBhDQo+ID4g
K3Jlc3VsdHMsIHRoZSBCUkEgQVBJIG11c3Qgc3VwcG9ydCBhc3luYyB0cmFuc2ZlcnMgYW5kIGV4
cG9zZSBhDQo+ICJBcyBzdWNoLCAuLi4iDQo+ID4gK3NlcGFyYXRlIHdhaXQgZnVuY3Rpb24uDQo+
ID4gPHNuaXBwZWQ+Li4uDQo+ID4gK1RoZSBidXMgaW50ZXJmYWNlIGZvciBCUFQvQlJBIGlzIG1h
ZGUgb2YgdHdvIGZ1bmN0aW9ucw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgInR3byBmdW5jdGlvbnM6Ig0KPiANCj4gVGhhbmtzLg0KDQpVcGRhdGVkIGluIHY0
LiBIb3BlIEkgZGlkbid0IG1pc3MgYW55dGhpbmcuDQoNCj4gDQo+IC0tDQo+IEFuIG9sZCBtYW4g
ZG9sbC4uLiBqdXN0IHdoYXQgSSBhbHdheXMgd2FudGVkISAtIENsYXJhDQo=

