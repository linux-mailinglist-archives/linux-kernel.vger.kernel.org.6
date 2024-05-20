Return-Path: <linux-kernel+bounces-183696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F043E8C9CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E0C2812BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AB446D1;
	Mon, 20 May 2024 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilsVJoDB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6602744A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206049; cv=fail; b=eza4TsF7AsW37dMvunbqsH5UaKCx3pMYdACqRkwtoNVL8nJx6d2aAgqwWGQwXXoZe610Ew7yBjUZK50mb1b7ELdV2rGJSDkbQ1q+bMTzutC06ntps3N3b63WC9MYwnmDkPNR4KATejLnkkppNAEak9tOR0S/WxdX+o/Msc/QgdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206049; c=relaxed/simple;
	bh=JplG0IfU3JgyxIe2RtOx9Z7AVXtK9gJNKCbOW5ShX4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tmAAQhZX+HMiD2SLhzh6Vrow3e+8RmiNI60mDyGmzxIGRmh5S0vNqMsCcecFyipA6YY0ku5EWcMYcQoPn/6ynICFeVYVb9em4xalt/3ngA73v2iugltz2g1wrFsTF4IVPsFT66VEg3QJ4YGjybXcQczMJTfnPrBwdfe0oLJo1EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilsVJoDB; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716206047; x=1747742047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=JplG0IfU3JgyxIe2RtOx9Z7AVXtK9gJNKCbOW5ShX4I=;
  b=ilsVJoDBddbpt0BFOUn+QnkouhJAQ/DNNwvHH5hTNqDDPhdY66WzSmI4
   BHngJQA3tXvefSTG4l2jMVAE0ZFeS798sGJZdGUoSoN4qjQ3cf5obRaX7
   q3oiTzdNmtJR+IBQXOCQy0RS2j46irSmeUvGYXMM3uZL/GDd6DiuLMEOj
   uH2x+rqp7tLY+f0m0NvNtKVUBrYJcrIeKpMnEwQWltOWny0PrBOaPNG7+
   iO1Tt9y5VnOIpbwgW+zkLVV1xudMrrWNt8PD2OV8GLpunDXY+ys5QwPbR
   gSuvKwS1hFMTmg2jnhNUfA81DCjrl7ORSwF3+smJZyH+/Ek9oLiNVgaiz
   A==;
X-CSE-ConnectionGUID: Vg1pRoS6QjSb3r+xBGprbg==
X-CSE-MsgGUID: 2CKw9P/3TH2XAMj6ut72cQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="29839929"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="diff'?scan'208";a="29839929"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 04:54:07 -0700
X-CSE-ConnectionGUID: esfrYtfxSqOQahGltG786A==
X-CSE-MsgGUID: sCndLNE+RrGhf1iKlf2L9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="diff'?scan'208";a="32535194"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 04:54:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 04:54:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 04:54:05 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 04:54:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpDIDZ6j0srn3R54gPpIr3LQURIEnaqmk4Uhxrmb8WkkrJ+3mJ41yNg+EqGjRXHJjc8JnCMBWlbD40XfMvWRRZ6UDvjuWYA07i2Yv9mL/NsCtTvKKd6mZPGyPm0vewVdWx6kqwrP0vFsaCDm/ar5JlKKjzPU0wXn3VaVHJaAsAUdnTYWDYMQMkakJgLJ9VNrLSRrkNtkv1fGUCSL9RSFV5SP31wVRJehbHvliLmWB9/QDsXH9BbWQe2WvhR+09K6Piw6Rh42Dd9UoV/K8Mo4n4EW+LhQ6MVJX5/jxM2MKumzH6ZdA02KWb6JqOjSRGas6MQ9+mHAX+ZspzALMXt5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGiCBWOYtpDIZkR4fLcG3jgUgzxWtTLhM5tabiABrAs=;
 b=aN2J70u9M14HtVgstF5NdgGt0sAkGptDtjI4THKPB93Rsm9yIqeyrCKUmiRsq58CQjFt2xT4Zmi+1E8e9LXqoe4BIKy+eAZKBeQtbLCiIfvWyHa862og2jrdJCy7TP0+/86HcNNbGE3CaLBMovGmlI1HU6qLWWoE4gw2A34OwlX8B0Q2CK2tA8WBarebNo9MHdmMvOmiWAgveJxQ7UYgxSXGT9byedCqzEtr7Le+LnHaJO1BaaEnmy3F2A4TuVSF2sdm6qGyqCqlIwMw+jw7LTbEXZDJlZjAuTPj0vninTSPLgWAAAZUZBsrEPbFLDcC4DYqPSn36hnfLxscPoiEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN2PR11MB4581.namprd11.prod.outlook.com (2603:10b6:208:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 11:54:03 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 11:54:03 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"jgross@suse.com" <jgross@suse.com>, "Hansen, Dave" <dave.hansen@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Thread-Topic: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
Thread-Index: AQHaqFPdLMzPjSCDnUWFW5WKWhmq5rGbczCAgAADa4CAAAjjgIAAAV6AgAAI3oCAAAMfgIAABI8AgAABLYCAAAEwAIAAAZCAgAAOJYCABGSsAA==
Date: Mon, 20 May 2024 11:54:03 +0000
Message-ID: <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
References: <20240517121450.20420-1-jgross@suse.com>
	 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
	 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
	 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
	 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
	 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
	 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
	 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
	 <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
	 <f7edef9c-5eb5-4664-a193-3bb063674742@intel.com>
	 <f02d9ebb-a2b3-4cb3-871b-34324d374d01@suse.com>
	 <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
In-Reply-To: <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN2PR11MB4581:EE_
x-ms-office365-filtering-correlation-id: 44190b31-730b-4b79-af4a-08dc78c38b65
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UG1YN2lSQVFMR2grSnF3eDkxYXFTREM5MjdxekswczZIT05RSUZvdXc4NzRo?=
 =?utf-8?B?NzFaQVhUM0ZYa3NaalI5V3FnUDFvKzlxOEdqS21HSndsZGU5V3hxZkdVbk9S?=
 =?utf-8?B?LzlyQlhtVzRUVUdMSHNyeFNPVGhOU0tSU2ZjVHZwRXRFWGdzamRxZmNQRFVi?=
 =?utf-8?B?OEQxM0tjdXFmaWRidDExL3RQZnAvWVVTMDhoTmN2VC83S0hPbnpoeWg2UHpy?=
 =?utf-8?B?eGNHdzFpMFEvemxKZU1lS0VPNUhVQjNPWXh2UHBJZndDUXhHLzZFU29Sb1Jp?=
 =?utf-8?B?N0pEbkxiSFd2QWlWNzZ2OUtrRGFqYXd4aS9EZ3h3ZENqVGl3RlhxdGFPUDZY?=
 =?utf-8?B?UjdITDIxWDc0K2RNVHY0ajJnTTNFcVZXbitpQXZoeUk4RU1HZW9laVRNL2Vq?=
 =?utf-8?B?WTVyRzlNaDhtdkkzbXQ1SDd0K2JGckVLRnZHQzRQdW00T0txRDJPbHFaQmp0?=
 =?utf-8?B?VjVWczFCU04ycWpHY0ZvdU00SUNhMmFuSmpadTlMUi84M3NTcFNBRHdUVVpC?=
 =?utf-8?B?UE1WcHFFSTM5WXV1NVJwSjdReW1PaU1kZEpPV2xsNlAxRjZvQWdKRjRibEdp?=
 =?utf-8?B?a2pkblNDbWJwZzRWRHh5aFZFQkI3MjEza2I1OEtJQlV3eVBYVHp4YUZUeWdj?=
 =?utf-8?B?Sk55TVBUV2p6NnpUSDNsWlBNbXFwaUxPRUozMDcvRUZnb3dKSnFURzZ2eTJr?=
 =?utf-8?B?Tnk5QWs0dmtUa1NwSktHN2hXUC9rVTNsNkZnOHhLTjRBSmVVU2N0QU1Ncmx5?=
 =?utf-8?B?Y2ZoZTJUdFU0K01yWmpkQ3ExeU9kZGozV1ZNVUlOZC9ySUhlb2MxSXJOQXc1?=
 =?utf-8?B?UUszcWI1ZjZSUHVIdUEyT3UyeldsZVNsVWJYVjVuUkFWOTRWRU1LaGx0ejRu?=
 =?utf-8?B?YmVTc2JKSGhjbzhKTVdPNHBGL043RWkvTERKZWNOaU53NDRzNG5pTHNvd0ov?=
 =?utf-8?B?dlZYb3hCWnNlZ3hyOXQ0RUFkMVVkaGlvWlVPSks2bmpOMXFKeXRsaVhxd3FG?=
 =?utf-8?B?a3EyVlMxV0ZCSEpmTHJQZFNITHhZV2E3YnVvY0JzVFFlYitOalFXeTd3TmdH?=
 =?utf-8?B?S2tkdmVYMW9hYmxDeHV5OXhiY25NR1RvNlphZ2ZxTVBLdlN2ck9VRS9IOVB3?=
 =?utf-8?B?dURZRWduNnZKK3BjRnRNUENaaVgzK2lZcFYxL0F3RllZSVpseitJUmx4MUhJ?=
 =?utf-8?B?bUYwNDFGWERzQ0s3WkVwZGttOEVBNEFVeWUwa2JWS2c1amhPdUU0ZG9SM3Fs?=
 =?utf-8?B?cTdaajl1b3JwTUxPMHNETWNRVHgwNFUwbnR0QlUvQW9iVjdzMHg0amUyd3Nv?=
 =?utf-8?B?VGlFVStvRFYvNmE4V1dYZHlzNC92blRpQzJGWDJwQXZqNUZ4YjFZUFFjdjlP?=
 =?utf-8?B?VjBQSXBPNi9Qc1lHdUg3MEI1RW5tV2tpdUxvbjJUOTc2aytPQkQ3QlFGRzZz?=
 =?utf-8?B?WmZtaDJqNFU2S3NaSUEzQzVaTmRucFVsdEwxQ0FGUTV6S2x6WXhYRWdmN05H?=
 =?utf-8?B?YTlPaWNvOUEvV2x1UXR0NStWdFJNb0dCZUxIR2p4M3hyZ2RkdXg3SXFLRU5n?=
 =?utf-8?B?YUdXbExzL0dGUDZDWFV1UFpwS2xtTXYvZlJyU0I5WXo5dXk4Unh0cGZVUVZy?=
 =?utf-8?B?SEpQRFBiZ3ZleE5aa3RZeVVWUE5QdkI5RjFFdVlGbVNEdTEwd0orY1lHZE5O?=
 =?utf-8?B?QW5Bajk4bmVwVmJQM2ZlbGs1eHBrR1Y1OW0yVHFzY2FtaUVXNzdwUkRUWHUw?=
 =?utf-8?Q?erhi1UA6+co7a2qux4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXV3aHREUGI2eitTTFNMVzBDVFIzTUlMbHdHc0dTUFUyMXczWEZCbkFhWHJT?=
 =?utf-8?B?dTJScTNvMXBvS0ZiQTgxM092NEtTdzFyWXYrb1YwSmU1eFVtbmx0eHVpdXVa?=
 =?utf-8?B?cFZlbTd0VzM1SFlWbjEzeG1GNUJDaHByR3pBTFc5aEhUcjdhVG51MzFUazNT?=
 =?utf-8?B?WmM3aDE4eVNySFY5VEJjQ0RQY3YwWTFWRXR1K0srNlNvZlA0RlE3dXZGSUNE?=
 =?utf-8?B?WU4zR2E2azRrYUkvRFhtaVgwSHRWUHJVTVRlNWhRbTBseDlnRkEvejlOTExI?=
 =?utf-8?B?enVYWnhQQy9Tck9yNW1LRWhMdkl0Wk1MMHZ4aGJkRndVSjRvc1ZNZm9qU3JW?=
 =?utf-8?B?bGFPOW9PUjBrQTc0ZlozV0hwT3A1TE5rL2cxM2VqdnlRRk5ZTnBOc2U1RzBV?=
 =?utf-8?B?U0NJSU9rYjZjbEtaVWdZbkIzenZSOEtNSXhzcmFUemQ0ZVZnQmNlRDc1Y3hO?=
 =?utf-8?B?MnI4dzNkR1ZKVGpOT1dQSGtsYmMrclU0Vmp2WW1NZyszOUVSK2hYUTIyaXln?=
 =?utf-8?B?UEdBN0pEbEU5dE52VkI1U1RYd1ZUOVIzK2N1TysxY2VCY2pUbDVqa01TVHdC?=
 =?utf-8?B?K05GbEUyZXdhWG5YcjJGeHB5cGxjTG8yWENYKzVRKy9wRllpaWxWVXZQdHJ6?=
 =?utf-8?B?a3hBKzhkaVdpQXh2ZEhKb29aMXBWL1oraHVsRENyRy9vZGY0WnlsMStDenBj?=
 =?utf-8?B?MmQ5STJqNUg0NHNQVmJXY2ZuQTZqQ1VXSHJmM3B5RmQ0TW42czc4am55WnJs?=
 =?utf-8?B?Uml6a25Pa0ZGOWxBSDdMdE5idXBrYUplU0hZN0U4eGZpN0tZTmNncnZXakk2?=
 =?utf-8?B?U0NNdnh1emk2NnBvbWNoaWs5TDRycDg0TG5KclNkSVJqOHdsT1ZxU2syVXpz?=
 =?utf-8?B?OW8wSE9FRjRXM01WZGVOT0pLV2EvTFZiQ05Xd1dUWDJKaWZUdlM0ZnRJQXda?=
 =?utf-8?B?L1VNYWJGU1dCT0toU3dTVi9oRHNIRFI5NFA3UEdwRVdVVms2aGZUM003SGNF?=
 =?utf-8?B?dS8yeHpmTzlMRFB3VkN6WEU4Z2k1VkxkMkNBT0J5dWlwNSs2WEdIWngzTmN2?=
 =?utf-8?B?YjBtV1liSE1yVEtzUnlIMmVKUmFwTWdxMlE1N2JJYmtLSVNqczFzNVVGam9i?=
 =?utf-8?B?OGx2R1Zocit2cHJFaUZZTjU4S1lkblJMRWZpOE1EU0E5SHlXTTg5OGp2L2ls?=
 =?utf-8?B?d3FlRXcrR0dWbFNPZmcwQ2pNalRpdFgzbnZrRUttSW9yUy9xbFFlc1A1YUJP?=
 =?utf-8?B?OWcvOUd3aXFXNzRtdG1NMFh2L09KZ2tYZ1JwQmVjaTB1YS9GNFBpeC9maFZ5?=
 =?utf-8?B?ckNDdnhrWGJMcFpMWmxLMUtJa1pDWGw4ZGdSQzhmZUYybzhiQW0rN0ZhQ3Ez?=
 =?utf-8?B?S2N2ZTlZYU5SYXRESnF1VjM1L2hKR0M1RkMrWmllUmhvcFlDNzJGaHBwbnZn?=
 =?utf-8?B?Z09tRCtYc2hJbjBSeEZXVnJ3Qzk2SkVEK05XOHM1VXVRZ3g2c09iZkhzZ2Qw?=
 =?utf-8?B?TlJTWS90SUZNdytmbFBxZkxQaTVXdWpGd2M5ODBSTWZTVEhObWNXR3VsRjFK?=
 =?utf-8?B?SGZJZVdOVzJMYk9ubDFJTmsrRGpsamZtc3VBSFpEb1U3Q3dyKzc0RDZ2eEhn?=
 =?utf-8?B?TjRCdTJqMS92VmRaYTQ5TTFFWlJMa0NwMXhDZDdhdDVucWdVanNCWXdycnVn?=
 =?utf-8?B?MGwzK3ZiYXlrNXoxaytnSUJqMUNQYjV3R3JSeC9sdDVWQXAzMXAyck5zRE5X?=
 =?utf-8?B?ZngvckhrcW5qVlBjaXRZOHFoclNyWjdoT0JISDF4MTJubXQwVkU4N3ZrMzZz?=
 =?utf-8?B?RmsyR0NkdUpONnFFRDJDTk5RRWpscTdBWFlTajRBWGxkWDlhdm9jWHB2cER3?=
 =?utf-8?B?S3BWa1NoTU9SVUl2QThkbHp1OEM3TkRsaEtTYVpRdll2cnZSTk5jRTV4UjEv?=
 =?utf-8?B?QmNwSzZzUVgzKzUxdCtDN1huTkZySjgrZzUxNVROcWhxU0oxc2hvUzdUbHd5?=
 =?utf-8?B?blp0RXQ3U1l2Yi9WVjBVK0E0bVBvZmEzTmxBTStYL2VuVnVxRFY0ckFBZEIv?=
 =?utf-8?B?SWtId1pLUmZQdTA0bmdhcG1ScnhrejVtZlJjOVZ2RHlOMFhtY1U4clF4RXdW?=
 =?utf-8?Q?nY5lCOEzk1eykKsSpXQLz2aau?=
Content-Type: multipart/mixed;
	boundary="_002_c7319c0614c9a644fa1f9b349bf654834b615543camelintelcom_"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44190b31-730b-4b79-af4a-08dc78c38b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 11:54:03.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YjnWgrGZfm1b42AELsP3mDWeRtAuLzlckiiCJ/wM15V87oWXmimbKGpvXGYd1l9UVyBp/uSEyiwwL5NriNFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4581
X-OriginatorOrg: intel.com

--_002_c7319c0614c9a644fa1f9b349bf654834b615543camelintelcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9E8DC0A1784D44F9C3F69C626ACAF21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDI0LTA1LTE3IGF0IDA5OjQ4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNS8xNy8yNCAwODo1OCwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4gPiBPbiAxNy4wNS4yNCAx
Nzo1MiwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+IC4uDQo+ID4gPiBPbmNlIHdlIGhhdmUgdGhlIHNw
ZWNpZmljIFREWCBtb2R1bGUgdmVyc2lvbiwgd2UgY2FuIGdvIGFzayB0aGUgZm9sa3MNCj4gPiA+
IHdobyB3cml0ZSBpdCBpZiB0aGVyZSB3ZXJlIGFueSBSQlAgY2xvYmJlcmluZyBidWdzLg0KPiA+
IA0KPiA+IE9rYXksIGhvdyB0byBnZXQgdGhlIFREWCBtb2R1bGUgdmVyc2lvbj8NCj4gDQo+IFlv
dSBuZWVkIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIzMTAxMjEzNDEzNi4xMzEwNjUwLTEteWkuc3VuQGludGVsLmNvbS8NCg0KVGhp
cyBvbmUgcHJpbnRzIFREWCB2ZXJzaW9uIGluZm8gaW4gdGhlIFREWCBndWVzdCwgYnV0IG5vdCBo
b3N0Lg0KDQpUaGUgYXR0YWNoZWQgZGlmZiBwcmludHMgdGhlIFREWCB2ZXJzaW9uIChzb21ldGhp
bmcgbGlrZSBiZWxvdykgZHVyaW5nDQptb2R1bGUgaW5pdGlhbGl6YXRpb24sIGFuZCBzaG91bGQg
bWVldCBKdWVyZ2VuJ3MgbmVlZHMgZm9yIHRlbXBvcmFyeSB1c2U6DQoNClsgIDExMy41NDM1Mzhd
IHZpcnQvdGR4OiBtb2R1bGUgdmVyc29uOiBtYWpvciAxLCBtaW5vciA1LCBpbnRlcm5hbCAwDQoN
Cj4gDQo+IC4uIGFuZCB5ZWFoLCB0aGlzIG5lZWRzIHRvIGJlIHVwc3RyZWFtLg0KPiANCg0KRnJv
bSB0aGlzIHRocmVhZCBJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGFkZCBjb2RlIHRvIHRoZSBU
RFggaG9zdCBjb2RlDQp0byBwcmludCB0aGUgVERYIHZlcnNpb24gZHVyaW5nIG1vZHVsZSBpbml0
aWFsaXphdGlvbi4gIEknbGwgc3RhcnQgdG8gd29yaw0Kb24gdGhpcy4NCg0KT25lIHRoaW5nIGlz
IGZyb20gdGhlIHNwZWMgVERYIGhhcyAiNCB2ZXJzaW9ucyI6IG1ham9yLCBtaW5vciwgdXBkYXRl
LA0KaW50ZXJuYWwuICBUaGV5IGFyZSBhbGwgMTYtYml0LCBhbmQgdGhlIG92ZXJhbGwgdmVyc2lv
biBjYW4gYmUgd3JpdHRlbiBpbjoNCg0KCTxNYWpvcj4uPE1pbm9yPi48VXBkYXRlPi48SW50ZXJu
YWw+LCBlLmcuLCAxLjUuMDUuMDENCg0KKHNlZSBURFggbW9kdWxlIDEuNSBBUEkgc3BlYywgc2Vj
dGlvbiAzLjMuMiAiVERYIE1vZHVsZSBWZXJzaW9uIi4pDQoNClRoZSBhdHRhY2hlZCBkaWZmIG9u
bHkgcHJpbnRzIG1ham9yLCBtaW5vciBhbmQgaW50ZXJuYWwsIGJ1dCBsZWF2ZXMgdGhlDQp1cGRh
dGUgb3V0IGJlY2F1c2UgSSBiZWxpZXZlIGl0IGlzIGZvciBtb2R1bGUgcnVudGltZSB1cGRhdGUg
KHlldCB0bw0KY29uZmlybSkuDQoNCkdpdmVuIHRoZXJlIGFyZSA0IHZlcnNpb25zLCBJIHRoaW5r
IGl0IG1ha2VzIHNlbnNlIHRvIGltcGxlbWVudCByZWFkaW5nDQp0aGVtIGJhc2VkIG9uIHRoaXMg
cGF0Y2hzZXQgLi4uDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS82OTQwYzMyNi1iZmNh
LTRjNjctYmFkZi1hYjVjMDg2YmY0OTJAaW50ZWwuY29tL1QvDQoNCi4uLiB3aGljaCBleHRlbmRz
IHRoZSBnbG9iYWwgbWV0YWRhdGEgcmVhZGluZyBjb2RlIHRvIHN1cHBvcnQgYW55DQphcmJpdHJh
cnkgc3RydWN0IGFuZCBhbGwgZWxlbWVudCBzaXplcyAoYWx0aG91Z2ggYWxsIDQgdmVyc2lvbnMg
YXJlIDE2LQ0KYml0KT8NCg0KDQoNCg0K

--_002_c7319c0614c9a644fa1f9b349bf654834b615543camelintelcom_
Content-Type: text/x-patch; name="print_tdx_version.diff"
Content-Description: print_tdx_version.diff
Content-Disposition: attachment; filename="print_tdx_version.diff"; size=1584;
	creation-date="Mon, 20 May 2024 11:54:03 GMT";
	modification-date="Mon, 20 May 2024 11:54:03 GMT"
Content-ID: <EEF42CDD72611546B0405D24C9A4624A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3ZpcnQv
dm14L3RkeC90ZHguYwppbmRleCA0ZDY4MjZhNzZmNzguLmYxMDUyMTRlMzZhMyAxMDA2NDQKLS0t
IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jCisrKyBiL2FyY2gveDg2L3ZpcnQvdm14L3Rk
eC90ZHguYwpAQCAtMTA5Nyw2ICsxMDk3LDI3IEBAIHN0YXRpYyBpbnQgaW5pdF90ZG1ycyhzdHJ1
Y3QgdGRtcl9pbmZvX2xpc3QgKnRkbXJfbGlzdCkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIHZv
aWQgcHJpbnRfdGR4X3ZlcnNpb24odm9pZCkKK3sKKwl1NjQgbWFqb3IsIG1pbm9yLCBpbnRlcm5h
bDsKKwlpbnQgcmV0OworCisJcmV0ID0gcmVhZF9zeXNfbWV0YWRhdGFfZmllbGQoTURfRklFTERf
SURfTUFKT1JfVkVSU0lPTiwgJm1ham9yKTsKKwlpZiAocmV0KQorCQlyZXR1cm47CisKKwlyZXQg
PSByZWFkX3N5c19tZXRhZGF0YV9maWVsZChNRF9GSUVMRF9JRF9NSU5PUl9WRVJTSU9OLCAmbWlu
b3IpOworCWlmIChyZXQpCisJCXJldHVybjsKKworCXJldCA9IHJlYWRfc3lzX21ldGFkYXRhX2Zp
ZWxkKE1EX0ZJRUxEX0lEX0lOVEVSTkFMX1ZFUlNJT04sICZpbnRlcm5hbCk7CisJaWYgKHJldCkK
KwkJcmV0dXJuOworCisJcHJfaW5mbygibW9kdWxlIHZlcnNvbjogbWFqb3IgJXUsIG1pbm9yICV1
LCBpbnRlcm5hbCAldVxuIiwKKwkJCSh1MTYpbWFqb3IsICh1MTYpbWlub3IsICh1MTYpaW50ZXJu
YWwpOworfQorCiBzdGF0aWMgaW50IGluaXRfdGR4X21vZHVsZSh2b2lkKQogewogCXN0cnVjdCB0
ZHhfdGRtcl9zeXNpbmZvIHRkbXJfc3lzaW5mbzsKQEAgLTExNTUsNiArMTE3Niw5IEBAIHN0YXRp
YyBpbnQgaW5pdF90ZHhfbW9kdWxlKHZvaWQpCiAJICogTG9jayBvdXQgbWVtb3J5IGhvdHBsdWcg
Y29kZSB3aGlsZSBidWlsZGluZyBpdC4KIAkgKi8KIAlwdXRfb25saW5lX21lbXMoKTsKKworCXBy
aW50X3RkeF92ZXJzaW9uKCk7CisKIAlyZXR1cm4gcmV0OwogCiBlcnJfcmVzZXRfcGFtdHM6CmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgvdGR4LmggYi9hcmNoL3g4Ni92aXJ0L3Zt
eC90ZHgvdGR4LmgKaW5kZXggYjcwMWY2OTQ4NWQzLi5hZThhOTZlMGY1M2MgMTAwNjQ0Ci0tLSBh
L2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguaAorKysgYi9hcmNoL3g4Ni92aXJ0L3ZteC90ZHgv
dGR4LmgKQEAgLTM3LDYgKzM3LDEwIEBACiAjZGVmaW5lIE1EX0ZJRUxEX0lEX1BBTVRfMk1fRU5U
UllfU0laRQkJMHg5MTAwMDAwMTAwMDAwMDExVUxMCiAjZGVmaW5lIE1EX0ZJRUxEX0lEX1BBTVRf
MUdfRU5UUllfU0laRQkJMHg5MTAwMDAwMTAwMDAwMDEyVUxMCiAKKyNkZWZpbmUgTURfRklFTERf
SURfTUlOT1JfVkVSU0lPTgkJMHgwODAwMDAwMTAwMDAwMDAzVUxMCisjZGVmaW5lIE1EX0ZJRUxE
X0lEX01BSk9SX1ZFUlNJT04JCTB4MDgwMDAwMDEwMDAwMDAwNFVMTAorI2RlZmluZSBNRF9GSUVM
RF9JRF9JTlRFUk5BTF9WRVJTSU9OCQkweDA4MDAwMDAxMDAwMDAwMDZVTEwKKwogLyoKICAqIFN1
Yi1maWVsZCBkZWZpbml0aW9uIG9mIG1ldGFkYXRhIGZpZWxkIElELgogICoK

--_002_c7319c0614c9a644fa1f9b349bf654834b615543camelintelcom_--

