Return-Path: <linux-kernel+bounces-274336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AE09476EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234FA1C210D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5A14A634;
	Mon,  5 Aug 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clFJkpbw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366313C906
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845449; cv=fail; b=Em2VBUuLD2RM0tjhDSLVQw6ioxY+0UVlNgfGXanXinGRS3z5WmyB+ZWxVUXOnR3WreSRr3/1QCglJ2nR3gQgfb8rQK/bSF1ZXg8N3mGV3wIXLjK3eKBS+GQKGg0pe2MN/F8w6C65LKtQ/5dTCUhT25DdgJQCKAG5bK1XNaOhN+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845449; c=relaxed/simple;
	bh=ec98UzrQDhI57bLqahEKWko/vqDBgHQrpF4LGY+QjWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MNwu3YfQr4VJiXZCQEdifTFD94OFgQOxRBv3mOB86T2DpQHvJ2s8ev1dz6519+5/TQpNUmrWaL3OMsjNU0VhzSJEHhVKDWYur+1y4/bamLCKVUCTwXN8MDwS/uIfmpwx+PxzGI+AVlW1gCGUd1zHd8asspY9IiRYFKy6yqnwBpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clFJkpbw; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722845448; x=1754381448;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ec98UzrQDhI57bLqahEKWko/vqDBgHQrpF4LGY+QjWE=;
  b=clFJkpbw9Y5FWPHxov2gU1c6iKX2zraiIcnRVj2rdJp3DpG4ttfBQ1C8
   wBl6dKhWDXX6VehErzjxNUN/u6CA0pIfqYDY3blp33wRtBrqgRzGK+Hh4
   dJYsgFqjuzvmyLYrrMHTNPtyZv9yWdep+khf2eaZJoNBwjdaqV1b4WLDg
   tiMDq0fYMrg1/mTtbFN9MlnIGGwpxMlPEXUqNHuL0z1ohBbw/GUXSMovB
   yK2vLyPQi7pe0ImMCT7V+KSza4EhdRdKru+uGNFBScW70izWiPWp22tJ5
   f0vDrDCNVB3dXvSGjAWTTgltK4iYLgXuVAH/UVxETWtaw5pZJLexBXSlB
   w==;
X-CSE-ConnectionGUID: 5Ohf6V8GRva5GA2mGKVVnw==
X-CSE-MsgGUID: X0TUCRdoS7exPI34CVTeQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20933734"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20933734"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 01:10:48 -0700
X-CSE-ConnectionGUID: b2qG0j6nSBa4IqcjMVtdXg==
X-CSE-MsgGUID: Z2xBNDA4TwynFFZ63ejo+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="87040465"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 01:10:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 01:10:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 01:10:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 01:10:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 01:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0JFqjdIERULYLGvsvuk2GgwNQDfuc63Uc7ZpaohLtQ0VudoZW8DhIGQY4qJJpF/FxrFYi3qm/nCZm7f+vehF2MR/gpAwhUwQWYv/We9tnISyF1bh31Gjw3Bpb8rCrGUZNwmnclI6T0bHJn3WfL0XbGs81/wN9xdkMv6i/ctFmg1XDP6Qiz0wW3rxl/87SGQCquQ51CrlZR434cG+Okm12FQETQN/2FKKbtpAVr6++mLxO+VwNCBliuK0NUZygKsgsO4YdGJydrLV57qFVpLhR66BZIvDj30UBb7OZqfgDZeNTH9gJ+QVvA+Fd4p8kAUDJs/zUqm4WQyDX+VBA8XhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec98UzrQDhI57bLqahEKWko/vqDBgHQrpF4LGY+QjWE=;
 b=TfR4ihTi+xo1lFT5LUWqLu4zAgv5gKyNF3NTP7M5bRqJqcManLM3s7bHwGInaiydTeL7r4pfBFD6zWPRIAyxXtn7C/3E4T05J3rcw3XQ99yhYJ0g8zMms0xfgIOMV+lvEMZC8QrbaIBstFEnh8TSTkaRHe8Vf3wHtqbSKNr4wo9UXoWrsWcYlVI3Q9mgUuvcXAhgCol8H9nNOaxHLnFlBXcHYAvz5QwQrYneSMKGhgaH74u7OBJj6M4cmDz9m8CrSTvzF3ju4nlyR71Uaxuy560wA6VQJ6pCuqzh6UNifj+BZ2g69f0a7Qv6EGMa+wXZAm4Gcj3hZZLKmzBlT42JkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 08:10:43 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%5]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 08:10:42 +0000
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
Thread-Index: AQHazVTP6n5sjozqBE6ytEPu6FZDZrIYc2aAgAAExgCAAAHGoA==
Date: Mon, 5 Aug 2024 08:10:42 +0000
Message-ID: <CY8PR11MB7134F297DE1D5F61A9FEA41689BE2@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240703141737.75378-1-qiuxu.zhuo@intel.com>
 <20240805071355.42636-1-qiuxu.zhuo@intel.com>
 <c349e2c6-027e-4e65-800e-f30ac0a0a785@suse.de>
In-Reply-To: <c349e2c6-027e-4e65-800e-f30ac0a0a785@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB5066:EE_
x-ms-office365-filtering-correlation-id: 5b777cdc-2dae-4bd0-8dd3-08dcb52619f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bzJmdGNIell3Z0FuaHRJWWw0Y1FzbDZKbHdNWlRpRDNBNEFVREpUcU95Y1VR?=
 =?utf-8?B?MkF3RXpFTTZNdzJWcE5uLzJzNGlkYnh3QTkycTNoWnlPcVVST24xRTBwZ1Z0?=
 =?utf-8?B?R2F5MWpaVWRqM0czNEFabTFCTytyblY5bFNqSjZrdVQ4bHhpOEFFNFZkaStY?=
 =?utf-8?B?STdQZDVFbDNIUE9oSVB4S2xXTkltQ1AyRnZRRTRYQTdlTXhFbHNGQmVSSVZo?=
 =?utf-8?B?SmVkZnBpSXU0TkZ4TTFMUVRKV2t2eFZUNWFSVlhvSHA1UW1YOHpwT0V0d3RY?=
 =?utf-8?B?Ky80VU9QVnFMM0RndUpqeHNTT3hXLzVsUFFhYitTelZmSnNlWmZEb2lSR2RE?=
 =?utf-8?B?clpwUkVQcTFLQStuYXhqaXQvRlNtaGw4S1BpcEdzd0RUVzg1MENiaTEzaUl4?=
 =?utf-8?B?Vy9rcWM4Ky9Dd0xzMEZxbzJHRVFaTGdpbkFFMUlJeTA1Ym1nZVJaZ0NERFpz?=
 =?utf-8?B?R1EvQlpNeXA1NlNWVTRGa0lFYkZOdUN5bldpdkZSL0RXazk1Lzg3LzdFZExK?=
 =?utf-8?B?NVA0dFNIWXdJa3VtOGErSHBRNHBOYWZIY3ZsQjNMd1RaWmRxMFhCWE5NL2Nt?=
 =?utf-8?B?b1NaakYyckNFTmdoYjBzUjEvN0RsaGNrczV4S0IrcXBvcmwxaEFTQ1ZqK0kv?=
 =?utf-8?B?S0hhTFcxQnNPOFF6UHMrbmx3eWU1MXNCSEpQWGZYUEhHRTF6MzVvL3kwdGN4?=
 =?utf-8?B?WEhhYzNsOWJNck5ORUVLUytBRU9ZWjFKL1pDK0ZFaXVVbTZubFVKWWQ3bHVi?=
 =?utf-8?B?MHR5NkhZeXljN0t0MWw1QnpndnFBL2dVaGlldmdZYVp2MXZkMk56VGdjTGdl?=
 =?utf-8?B?WUoybGtmYWpUeWErMkl5aUhnQjVRcFFQZzFKU1BEQUg4NVVwaWk1b2UwVXFu?=
 =?utf-8?B?amJQUjZIQTRTK010Njk0czZlNWF2VlJGV1EveXN1d0w2TUdvZWNjMDNvTlVF?=
 =?utf-8?B?aWdUTE1WWHZuNldvODNOSEVxM3FaWVFDbk4zVHBRbTV3VVM5NnRsWUQ1WEQv?=
 =?utf-8?B?YnIzdkxaMGpSaXlFVGlFV0ZlUm04akp5dmpTVmpPcklUeHNTbk5jbyt3WVJB?=
 =?utf-8?B?VDZSVStVdTNxY1lsWndUc0xDM1luNGQ2NFFWKzQyaU04Q2tEbzRFdzlNaFRr?=
 =?utf-8?B?S3JuS01qU2dpdkw2d3hPTVMwVEFiNHRBM1NYTFp6OXI1dlROU01xL1BUdUF3?=
 =?utf-8?B?cHlEalNHYmNnZ3FYREhhSTFxdnp0NGJuYXFjSkpQN1RYSWIxMEtLb3V2dUJ4?=
 =?utf-8?B?QlcreEZzeHVuV1IrK3dKR2s3UDMwd1d1Lzc3N1pkdVVPV25vcjJCcVhQcmdq?=
 =?utf-8?B?eUhCbXN3MWZFQ0RJRG84U3JqWVBWQlBTTVZzMGM0M3NBeTU3WjN0WXNyRTBY?=
 =?utf-8?B?bUdXK0xrU3ZVYmRKNWxSTWwrcHk3MkVWQktZUXBGY3FEQm9IQXdrL1JmRFh0?=
 =?utf-8?B?cTlGMkZ0N0s1TXpMVUxTaGlhdnM1bmpjeCtCQ3hBckcya2t5NVBkOGZOWE54?=
 =?utf-8?B?SXVzVHd0Qm9reStFdXdXbGVUQU01SGEzRU1EYjl4UFBKdDlnOVdIWTMyUjRU?=
 =?utf-8?B?bldTTGZVVjdtZGNheW41dUt2RkdRT2FRNTh6UkNueWhuWnlvcUF5dmcyeWFY?=
 =?utf-8?B?M3ZRYnUwL0sxVW9QWGh4NTNTd3hxRHdieE1kYzEyeCtSVWxmbzQwMW1IZ0sw?=
 =?utf-8?B?SkdDSDFGVDZuUmd0UE5zNjYzbEVFbGtrNktnb2d4ZDZmbmp2RzlId2VkVWU3?=
 =?utf-8?B?b0I4NitVcHEya3JOajFnN2NJT1JSSjhydlhmcEI1cllqZXhsUTRQTmsvSHB2?=
 =?utf-8?B?QmVvMk5nc1dZanB0aC9lWGhVT05wUGZOVE1vQmpIenNucy96RDUyOENvaXdT?=
 =?utf-8?B?SjNtcm9zSExHaUZLZEpCVStsRGJTWWxCa1BDa3Y5NHFub1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2RwT0ZSM0xkakZ4Nm55VFpxVVpXRzRubWNpYmxNUkpCdHJhZk9LaDN0RGhy?=
 =?utf-8?B?V09oWHVMYTE2Wm1Dbmtrd0hyZGVTTnJjRWtISklnNlV1SUpsemVyR3JSR0Z4?=
 =?utf-8?B?VHpjQk1oNzYyS1pXeTIzdlRtdFFNMWFaNXhtcDJadGJvV1piTzBqNytqWS82?=
 =?utf-8?B?dTB6SkFhZjJ6WU5YUXVNZlJORTBnZDZ1MUE1UE1kVjZiQklBVStSQWRSL3BI?=
 =?utf-8?B?NDIxeWtTaURTc2syY1JDQmhNRG8vYUM5QTdoYzdkRFNEbXdkbGdYWXBNS3JC?=
 =?utf-8?B?aCs3ajRlT1lTamoxeWQwd0FtRFQ0QWptc1hOMFlQWVdUVUxPOXRocXJjMFIz?=
 =?utf-8?B?TUNpU1lVQk10M2E1dVVGTVpKeGdrOW1vSkQwQ1NVU3orNlpDSjFpdFltQlEy?=
 =?utf-8?B?eGtWKytNMUpLTTVLOEhmUjRNSFl4MG8vV2lEUmZJaFNJa1dXczcyejZEdE1h?=
 =?utf-8?B?SXgrbExCVXFLOHFFclVSQjF0WU9lSDcvSzYyK2xGblBYQXBXVVp0d3VVK0Yr?=
 =?utf-8?B?QXF6bllCaFJ6RUJPWHJaZ2Qxc3FMTThGZXZwVFRob2tHZDNuem1EbVdCbmpF?=
 =?utf-8?B?cmpwRjVwbWcrOWZiaWgwaHF4RVVBdStaNjc5UUJUeDdJQ3JrdmRPRXI5MG52?=
 =?utf-8?B?QytZcDdZYzNWNUFXQnRwcUpwanM0em5rWmJTaUhHMlF5MGt1SnZGYlVTK3RO?=
 =?utf-8?B?WWk2YzBEVURLTytPU0U2ZEtkTDlTdVdYY253aHJSVS9IdUg3MFlHZXY5b1pO?=
 =?utf-8?B?M0VLTjhyWW5BTU8vdTEyVkVBYzdwcXVWSDFXeU80QkdQUTlJdTZxVzlLd3or?=
 =?utf-8?B?VHZRT09sbjNoTlVRam43bEwwVFhzSjVBc1A0S3A0a3hyaTRrZklGNFlGNTAy?=
 =?utf-8?B?bEcxMkpYb3lKNjFqSElmUUZNeFMrQ0RBRHlydDFGMCtHR3Q5ejhIQnhmWjNk?=
 =?utf-8?B?MFdzbWZVN2tER3o0NEVLNC8wR1pkV0FTQ2V1ckJ6dHllQTBUTVJiSS9Sa21V?=
 =?utf-8?B?T1R4V0w3NVkybzdHVm1FWXhTWTBUc1lpTTVRNTJCNXd0Y0ZMbm9VdGV5NmRo?=
 =?utf-8?B?eUpmMHdacWxGVVZXektzR2VnNHRmTmpReFNaSzU2OWRKV0dOc3FFUG1rM05J?=
 =?utf-8?B?U2dpQzVEZ0Y3MXFZVTZVN2M0RFZ1azN0Nkd4V2MyTEkvenVicFBuRERtQTM0?=
 =?utf-8?B?dUx3Vks0U2VMbXNLRE1DcHlySExxcDNmN0l1VngvOS8wRnUyeEtZWFFwd0I2?=
 =?utf-8?B?Z3k2VFZ3L2lwTEZveHAwWmFJcmhXcDhrYmdVUXVURFczanJabjB3bkpUcENE?=
 =?utf-8?B?dkcxaS9RTWRyWGN4QlkyajBXVWo0TWJncjNQZTNhbmNaWG5BWjZ2YVZsN1Ar?=
 =?utf-8?B?RVdSUGkvdzhpTEFzaS9IMU8yWExCeEM2NnNLSWFrUElWZkgzSWVKUlZoWkt5?=
 =?utf-8?B?bGlmOER2YS9JZGdybkdWeE9STnAxdEdxbSsxNStyS2ZDa1pmRkdQRzF5VUp4?=
 =?utf-8?B?YTRScUkrRkY2eTVYeGdWWTZhZzNGNFUvOXBuckxUalJaTnlqZ3VWUDQzTDBs?=
 =?utf-8?B?QzNBQm1TdmNnTlBTTFd4eGRrVmdHOW4yWXhXQ3NkWDU4V1Y3RkVuaTRkZmZQ?=
 =?utf-8?B?c21BazRXVHhEN3U4WUxtOERQaVNhWUFHUVFYMVpSRGNHUG1mbXEvMTZ5MGty?=
 =?utf-8?B?QjRyK1lmY2piTTI3cEpHdmtCZm9Lajl6Z0hyVUhBVmVZK1pSNHVrSDY1V3ZP?=
 =?utf-8?B?N0ZuN1RPSkZIMXRvem54L2d1eVVuVWhjOWp6RDZxSm16L3BhZGRnK2xCQVRa?=
 =?utf-8?B?ZGE4aUFVbWFXOHJSTStmZ2ZUMUNwUE5Pako4cWI1N0haVHNDNi9YZlZjRE1D?=
 =?utf-8?B?Yk9WM1UzNy9QcFJaTWIvc3NGTklkU3pDQWs3SkdiZFFMdERWanBvMFB1YmNx?=
 =?utf-8?B?WUdod3pmT1pYc0tTUE5lRktOMk55R0NnaXdZNzNIWVdYLzlkT3B6T2lDNm9h?=
 =?utf-8?B?cnJ1WExlQWxDY0VjWVV2NW91ZEJnMmY3R0NKcGR6VGpxbzZyQWJkWjRnaXVB?=
 =?utf-8?B?cGxkRmd3MFc5Z3lXR3VkV01wRG93YTY1OXFsQ0xBektOSlNKNE5ST2VWZU5r?=
 =?utf-8?Q?IrJgyVdrBKrYzbQ23LQRjTphh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b777cdc-2dae-4bd0-8dd3-08dcb52619f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 08:10:42.8111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGo20VU4ZvtEjsvuaIJI1luoZ8Wzg3VFISDYZGja28KgtvKOV9+3iM0H1szDzUz57EIV8yVJUabg5vcHDIfxdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-OriginatorOrg: intel.com

SGkgVGhvbWFzLA0KDQo+IEZyb206IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCA1LCAyMDI0IDM6MzEgUE0NCj4gWy4uLl0NCj4g
PiBIaSBNYWFydGVuIGFuZCBtYWludGFpbmVycywNCj4gPg0KPiA+IEEgZ2VudGxlIHBpbmcgOi0p
Lg0KPiA+DQo+ID4gQ291bGQgeW91IHBsZWFzZSBoZWxwIHB1c2ggdGhpcyB2MiBmaXggdXBzdHJl
YW0/DQo+ID4gSWYgeW91IGhhdmUgYW55IGNvbmNlcm5zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQo+
IA0KPiBJIGFscmVhZHkgYWNrZWQgdGhpcyBwYXRjaCwgYnV0IEkgc3RpbGwgaGF2ZSBhIHF1ZXN0
aW9uOiBkdXJpbmcgYSBwYW5pYywgd2lsbCBmYmNvbg0KDQpUaGFua3MgZm9yIHlvdXIga2luZCBy
ZXZpZXcgb2YgdGhpcyBwYXRjaCBhbmQgQUNLLg0KDQo+IHN0aWxsIHByaW50IGEgcGFuaWMgbWVz
c2FnZT8gSSB0aGluayB0aGF0IHdvdWxkIGxpa2VseSByZXF1aXJlIHNjaGVkdWxpbmcgdGhhdA0K
PiB3b3JrZXIuDQoNCkR1cmluZyB0aGUgZXJyb3IgaW5qZWN0aW9uIHRlc3Rpbmc6DQoNCjEpIFdp
dGhvdXQgdGhpcyB2MiBmaXg6DQoNCiAgIDEuMSkgSWYgcGFuaWMoKSBpcyBub3QgYmxvY2tlZCBv
biBbMV0gKH45OSB0aW1lcyBpbiAxMDAgY3ljbGVzKSwNCiAgICAgICAgdGhlbiB0aGUgY29uc29s
ZS9mYmNvbiBjYW4gcHJpbnQgbm9ybWFsIHBhbmljLXJlbGF0ZWQgbWVzc2FnZXMgbGlrZSBbMl0s
DQogICAgICAgIGFuZCB0aGUgc3lzdGVtIGNhbiByZWJvb3Qgc3VjY2Vzc2Z1bGx5Lg0KDQogICAx
LjIpIElmIHBhbmljKCkgaXMgYmxvY2tlZCBvbiBbMV0gKH4xIHRpbWUgaW4gMTAwIGN5Y2xlcyks
DQogICAgICAgIHRoZW4gdGhlIGNvbnNvbGUvZmJjb24gaXMgc2lsZW50IGFuZCB0aGUgc3lzdGVt
IGdldHMgaHVuZyB3aXRob3V0IHJlYm9vdC4NCiAgICAgICAgIFRoaXMgaXMgbm90IHRoZSBleHBl
Y3RlZCBiZWhhdmlvci4gVGhlIHN5c3RlbSBpcyBleHBlY3RlZCB0byByZWJvb3QuDQoNCjIpIFdp
dGggdGhpcyB2MiBmaXg6DQoNCiAgIDIuMSkgVGhlIGNvbnNvbGUvZmJjb24gY2FuIGFsd2F5cyBw
cmludCBub3JtYWwgcGFuaWMgcmVsYXRlZCBtZXNzYWdlcyBsaWtlWzJdLA0KICAgICAgICBhbmQg
dGhlIHN5c3RlbSBjYW4gcmVib290IHN1Y2Nlc3NmdWxseS4gU2FtZSBiZWhhdmlvciB0byAxLjEp
Lg0KICAgICAgICBbIHdlIHRlc3RlZCBpdCB+MTUwMCBjeWNsZXMuIF0NCg0KWzFdIHBhbmljKCkg
LT4gLi4uIGRybV9mYl9oZWxwZXJfZGFtYWdlKCkgLT4gc2NoZWR1bGVfd29yaygpLg0KICAgIEZv
ciBkZXRhaWxzLCBwbHMgc2VlIHRoZSB2MiBjb21taXQgbWVzc2FnZS4NCg0KWzJdIFBhbmljIG1l
c3NhZ2VzOg0KICAgIFsgIDEzMy45MDAwNDJdIG1jZTogW0hhcmR3YXJlIEVycm9yXTogQ1BVIDA6
IE1hY2hpbmUgQ2hlY2sgRXhjZXB0aW9uOiA1IEJhbmsgNDogYmEwMDAwMDAwMDAwMGUwYg0KICAg
IFsgIDEzMy45MDAwNDZdIG1jZTogW0hhcmR3YXJlIEVycm9yXTogUklQICFJTkVYQUNUISAxMDo8
ZmZmZmZmZmY4MjI5ZWJlYz4ge2ludGVsX2lkbGVfeHN0YXRlKzB4NmMvMHhjMH0NCiAgICBbICAx
MzMuOTAwMDU1XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IFRTQyA5NzAxZGQyODliIE1JU0MgMjkx
MDAwMDAgUFBJTiA5MDAwZDc1NjFiYjBlMzQwDQogICAgWyAgMTMzLjkwMDA1N10gbWNlOiBbSGFy
ZHdhcmUgRXJyb3JdOiBQUk9DRVNTT1IgMDphMDZkMSBUSU1FIDE3MTU4Mjc3MTMgU09DS0VUIDAg
QVBJQyAwIG1pY3JvY29kZSA4MTAwMDFkMA0KICAgIFsgIDEzMy45MDAwNjBdIG1jZTogW0hhcmR3
YXJlIEVycm9yXTogUnVuIHRoZSBhYm92ZSB0aHJvdWdoICdtY2Vsb2cgLS1hc2NpaScNCiAgICBb
ICAxMzQuMDUzODU4XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hlY2s6IFByb2Nl
c3NvciBjb250ZXh0IGNvcnJ1cHQNCiAgICBbICAxMzQuMDUzODY2XSBLZXJuZWwgcGFuaWMgLSBu
b3Qgc3luY2luZzogRmF0YWwgbWFjaGluZSBjaGVjaw0KICAgIFsgIDEzNC4wNzUxODNdIEtlcm5l
bCBPZmZzZXQ6IGRpc2FibGVkDQogICAgWyAgMTM0LjExMTM3Ml0gcHN0b3JlOiBiYWNrZW5kIChl
cnN0KSB3cml0aW5nIGVycm9yICgtMjgpDQoNClRoYW5rcyENCi1RaXV4dQ0KIA0KDQoNCg==

