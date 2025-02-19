Return-Path: <linux-kernel+bounces-521415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E5A3BCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021397A2BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1B1DC98A;
	Wed, 19 Feb 2025 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBkICewv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B61B85CC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964741; cv=fail; b=BGfJ5qOg69+j9RLOAWhTJ9Rfxwl9F/HurwS5UPheCiL4iS+9LzEwmPeZ0U45L8GR5ZG8gafupsCXPWesdr/rDYrnrWXcu2febfdwTxcqXMc7R5gzYAvou5i6e1ognUGQroPw5I/m+IlHbP32vgxuF8iLrRPT1LWjW2rn5D6glLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964741; c=relaxed/simple;
	bh=BbGdX+2tJfYpNvLroPMEq9qAkTeohRFge8UTZLYwxIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oroiFsBsGInXZtZvsdqE30bJtOjt0AOEmzaBSZt/T5xr1mJJhrON78Cgqs7VH4HTzuOO4W27qvhHjyq/SQfpDkoHldOeacZBHTPSkM6Afkxp/2oSAU0HRtl0rtx0NhtJfTzvc/xCNm8SQZA1izieSfSMdUVwcgq0sLYJYMJFBqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBkICewv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739964740; x=1771500740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BbGdX+2tJfYpNvLroPMEq9qAkTeohRFge8UTZLYwxIM=;
  b=TBkICewvYbyitAGU7kLLQURi0OpPO8CTOg4tT2XW3KSg+ot2+NKme2Q8
   xegm2IB9S4tAl61vkF3kIM02QMxROLA1GZEJ1u9B5/MvsOFd6Eq70PxSj
   DLTDQxSxHJw5LUegxI3Nq13mbwAEICvoKMo+WbDXGvxmXOtA6jJYuIzwW
   Sh9Q/EvTiyY8G4XB0m0Cp3sptd7MFD+bZlWWJGETrgPpSToOkX2nv+DAc
   8377Ev8G7UGYPfe7cqzE5S044RvmnW2e4MHBxkRyDVx0IFgtrEkh4oOFa
   qIutx7cOTY5IObEBOafWljT0N5jeCyvv186Qy55y3TVtAuBnHeWpOSpeO
   w==;
X-CSE-ConnectionGUID: kV3hMO5wQQq0yKzhyD495A==
X-CSE-MsgGUID: RyGIfm5/TTy1fnAtpxZjxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="52099393"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="52099393"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 03:32:19 -0800
X-CSE-ConnectionGUID: QHQxOfOFTImEaR+9UsgNyQ==
X-CSE-MsgGUID: ofPqIFgwSVeXSYICjTEd6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115171455"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 03:32:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 03:32:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 03:32:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 03:32:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct/wxwmcCQ+lMne63YP93EGv+R9eqY0QWlBS1n9gcbH5D3O7AayoLwk2H2jfST5xUGEbPeKgdHkGTkoypcXqVbV5PM3olqrj3S1/3sqQbzE379hzlWdYT/knhT91oe80wBeToje+DgaBZQiO/z2vzoSAFy1RYQO2mTj8tUdOScBjVc27qqXBOxI0hlPn98z+AcD2TL1yNbeGWOxxK3f5GXYBzAQYNFtcxd7SYlicQEOBm+CnGr69PTImYzpE5KFZ+CrgwB0JXnzm62QrVCSNlwBdsFgZ/jkzweqXzzdQlvz5U1PL3yebgPkOtlxYikS71xVvMS3Y2AbgqrilOY1wAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbGdX+2tJfYpNvLroPMEq9qAkTeohRFge8UTZLYwxIM=;
 b=UuPrQZ93ZAFO1Jvl78RCre35ChRgspM2DNC+89PEbR3LGVpdjxURe+h5TacAY5oS8RX96gzfTm4KKXsvkGQTpUlPfiPN6OBXb1F7xRGdd5I9KzSKAuBrTPEUA0b2endd1lWn/kjcfQozf5MznLJFHkchSTclB8BOyYYF0QNdQnvV6qcD+usR+LAyOUloDvfcTo6AdFcWNslZzLAzgatwiT7p8KhjvmIq6CMDAwAaLCWYtpAbdrx3y3ak8kEYDPGW9f0vLZCEGfAb1a332iOEroiOVUlIHIrN7hNoFeXakXLv2RECPNkTxA4ZDrW61218G8x1IiScvk2z6C3x8QxymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 11:31:48 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 11:31:48 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>, "Xing,
 Cedric" <cedric.xing@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
Thread-Topic: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
Thread-Index: AQHbfb5LIj5c8ylDhUKcofXpuejiKLNEqiwAgADA/wCAAApXAIAAUY2AgAdmAACAAN4ngIAAfQEA
Date: Wed, 19 Feb 2025 11:31:48 +0000
Message-ID: <3ac005e3b72f51199742e0202cb289726ac4c1da.camel@intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
	 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
	 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
	 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
	 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
	 <Z7Sd6FuDDMgExEna@himmelriiki>
	 <465d712c-b638-4884-88c8-1a88c506efdf@intel.com>
In-Reply-To: <465d712c-b638-4884-88c8-1a88c506efdf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8348:EE_
x-ms-office365-filtering-correlation-id: 02da9129-c926-45d6-5600-08dd50d8ff28
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MHN4WUlwVDlOS2xNYnFweVhPMWRSQWxua2VpdHQ2L1VteWFHbnhoVUFVdGhu?=
 =?utf-8?B?RHhOZTVDTkx4TDQ3M1llYTc5Zjdlc3NUQW9EV0tYRWdRTmNRZ0FkcGFVWnQ3?=
 =?utf-8?B?VVNnOFA0WWpBSWk2a3NUTXNnVHVlWVp5Y0IwR25lWldudWFwb01tRnN0OFIz?=
 =?utf-8?B?a0RnQVNFdzZ0b0RjdGVBY0c5dG91L014clBWMm9xMXd3aG94Mzk3dnlLR3Z0?=
 =?utf-8?B?TU81cVpMWm80ZTVOK0czbTY2dndXUldCYkJHeXl6aXZhRTZBOGFqU0VpVFlO?=
 =?utf-8?B?K1NhSHFjZDBJY3liKzRwZGpEVElPaDZTejFzM2doejRrWUdBbEt0M3VDdkJO?=
 =?utf-8?B?cVdkRUg2bVN1bTkwMWVVYkJqV0c4TWNRbk0vMWRXb0dKNGhnaGFOd0w5SXV6?=
 =?utf-8?B?UHFCOWNib2JGSDRCM1FXWldEMnlTRDB2ZnFQL3pMazQwRUVEV0hPaE0vamhQ?=
 =?utf-8?B?dnBMS1ZzNGh1aDhEeE5hVUplZ1lJZ0xha1ZSa3A3USsvZWVqTDdFWXZ0cXlt?=
 =?utf-8?B?OG1PbFFLTEovUGNUZnVkWTFNbTFacHpSMDl3M2dwMVd3NzFvMlIvdnhFSENz?=
 =?utf-8?B?YnFudTJLajJ5RkRMWllzcjFLcUxMcG9zbk9KWjFUNHZJT3oyeW5vSTZXVWRS?=
 =?utf-8?B?L0gzK0s5VmpIZFVJOHhONXQ0MjgzWXFucXFQbEJHTzhHWWttc29Hc0hxZ2cz?=
 =?utf-8?B?ZzRmQXdqWFlWcWZoVW84TVplQmZ5QVkrQjhhWFRYYUVSSWphYTVuMFB1UWw3?=
 =?utf-8?B?cjFjL1FhMVFHd3U0ajg1YmorNXpUMi80RFB3dllkejlHQnNLOU8wUC9RL2ty?=
 =?utf-8?B?NzhhOWhpOFZIWCtFbmNlQTNOV0pLZUtoRzJZZitBZkNZL1g3RWdoMUYzNTdu?=
 =?utf-8?B?cHFnbVFIRmtIMG01eEFKaHpHSTRYcGxLQ1FWZVYxRE1tL1pESjIxU0lkM0Vz?=
 =?utf-8?B?bHplMER1a2RPbUx5dWNwZ2xBbEwrZVRFRjNrUTBaQ3ZMcUNMRGtVdUhITzVp?=
 =?utf-8?B?eis2SFExRXp2NjhVd3ptaXA2VWtRR2htWGt6a2JEdmQ2Mys3Y1FyMGhtbENC?=
 =?utf-8?B?c254VDlpUExDWk5KZ3padFpIV1BaUXBpQ2pxRVgvR3kveEV0TkRGWUJOenJS?=
 =?utf-8?B?Q0p2Z1lTRFBYWGxZUFlMbjhGOVEyYkpxSi85bEZFRjhhZWtPRTJ0NE5Eem56?=
 =?utf-8?B?U1lmdEoxYm9YSDJlR2VMTnpGK1RqTFJwRXErbzhRUytNZmpBVVZ5N2lTbXVK?=
 =?utf-8?B?czZYWWV2S29PQXk0aTJid2x2bkZHRHBobXNrVG5aMlprUDMxNTNoZGd1WjdX?=
 =?utf-8?B?b05pNG9SbEEvYTMzbUF5dy80M2NPV0Jza2syWFo1MW8rV2p6M0pzWTBQTmhp?=
 =?utf-8?B?dlF4WFRvd2tBSnpuMndWbHZWMVN5K2ZrTzg4aUhrWnpVSjJHdjQ3MHdzUkc0?=
 =?utf-8?B?VXNIbTVlb2lKTHpscHZOYkM3ZElvdHVOMDBpMzBraGZPQ1ByaUJmZjhRazdQ?=
 =?utf-8?B?dVBNNlZlSGU0bGtWUWdPbUFwZm14ZDlQZ24xdDBTVkxTc09mTGtkT3BMSlBj?=
 =?utf-8?B?T0swTnpiMlZjSEF6enl5NmVJMS85aFlDN3o3dUZBWWNPclhrNkJxZHlyZFBy?=
 =?utf-8?B?SmV4NnlCNno2V0p5T0h1OTJRQkNKWjdxTmJXNlZTWDNTRzRrN3AvOW1va21M?=
 =?utf-8?B?Q3g1K2Z2d1F3WVI5SjF2QnVFaitkelIybkVIQlM1WXhJVWtmRUJ3SUxsWkky?=
 =?utf-8?B?MG9qV1pXOTZ0QlBzK3dnaVZiNFhubjVDRFBNQkRwSFlGWmtXTUJWSG1aSXRs?=
 =?utf-8?B?akxWK0M0NjNWYkhxNG5jTW82UktoY2hiT3M1U2NqUitaUUhmdTRIVzlCMWpV?=
 =?utf-8?B?VFJob3ROM0JxZnRhenlhK0pZWlVDRTJoTTFPYy92UXRnRUtBV2FPa21YUjBB?=
 =?utf-8?Q?I8RnM3JqrtP5LyP5bmKvSLe+yWrpIxaZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3JRYitCK3A1MTRwbFQvNlkrZHVMYTNDVW83UW1QRG95QUNNUHdzZW5ZaCtr?=
 =?utf-8?B?bFJGOTZtVldVQ3dwZ2FJRG9sRy96V3drdEZJVEprcm1JZTRHWGVVM1NtRzRG?=
 =?utf-8?B?ays2ZG9peDdRK25oNDZvdE94MFMxOTFJdzQvSkpxUW5BejhZZnQ2TlhrYW1r?=
 =?utf-8?B?bEN4Uk5sL2c3TjFVZE1UWnNBSHo3MUsxYXFQcTQ2MWE5ZCsvK053TWVoTzBG?=
 =?utf-8?B?MUZJT3Vjdk5GRkxwb3NZT3dSNGYvRi8rRFVnQTVMMmNyZVN4ZjlhV21ROGlC?=
 =?utf-8?B?R1NKU2Y1bFcyVnlnK0x6eVpwNWNKWm1lNEtidWtzL2ZRYTRkTTREdFF2eEN0?=
 =?utf-8?B?NUM4SHEyK1pXa3lQK2M0dVlxbWRoVFVJV2xFdVVkdTMrOVhvNmx4TzNadW9H?=
 =?utf-8?B?TWx1WHVzekhVaFNWVk5MNzVYZnU3Ry9hcU5WZzRhOGg2WUs1SU5tR0h3dEZn?=
 =?utf-8?B?N2hLbEozaFZvUXhpelRaaHhqa1dhTjF3SEJjY0lUSXhXekk3WVVST0EzejZh?=
 =?utf-8?B?WEY4ZmFxa1JIRVo4WlpFWWVNSEFzNWFqand0blJ0MlgybmlUSTJwb2FXWVBB?=
 =?utf-8?B?cWVndGVjbU15K3J0N1JJVk9ZZVRyUlFMZExINFg3TVZTc0ZHODBTYUs1ckdP?=
 =?utf-8?B?aUovb2NWMHNtNEg3dE1ucXhXQ2l1ZWpFd0pKZWR6Y1RUVUlFYTNGTjJvSTRr?=
 =?utf-8?B?Y3NvTjhpYzJ3SE81TDZFU2lRaHNLWkhiOUZIZUtyeWlZKzBBNXlZS2ZxN25D?=
 =?utf-8?B?VkpEaFd4VS80SWh2cllWeStaWFFyMy9MOEpOQ2Q5K2x4M2dwOHRWY2ZudnFh?=
 =?utf-8?B?dHZLa3V5TXJEV1dPeXNYYm44NHY5VFlSS2JsM2RqUy9rRVI4OVlOUkJ1TkJ1?=
 =?utf-8?B?alBMWlRzUkZpYTR5VFVoOFF1cGp5dzBmdVE1Q2Nrcm1ya3FydW1FVjFNa29u?=
 =?utf-8?B?SDNzK0Q2Y2RVL2c5dWo2dnZlWkJsNjYrTmFXQ2V6QnVHN0hsMTJYcjlIbmow?=
 =?utf-8?B?Qm5VenorbkNzZGZpRUQ5eWp1QXdoWHBYcUdCaXUyK3NYeXN4R3QvNmFvUXhj?=
 =?utf-8?B?dzB4YlFTSjA3My9yUGhSREk1ZXpHR0paLzQrUk1ZeS9TajE1MVRZczkxWUJ5?=
 =?utf-8?B?TEdVVDVuQmhsbjE5Q0loaXhjMEk4YlNBN0pBZitndmJCOTlnemdOWEhQd1lM?=
 =?utf-8?B?NmFrck4yR2FPMlFlbE5qMkRXaTlyQUVycG9IL2JwUFpjSnFoMmc0S1B2cktO?=
 =?utf-8?B?QUoySXhXTUV5dHlSd1J3T0FYQ3luUnhISDZia1o1cVVaTjJ2YkJYR1NYZWhW?=
 =?utf-8?B?YWMyckRjY1RJVmNPTWw0N3FrMWU0bEpXWWE3cUl3azVkeDJVUHg3NjRaYlh3?=
 =?utf-8?B?aEs5MDhjamxWeVJwYVR4WG9BMTFwcWh5TlMvM2pmMmVMNmx5OGEzendoS0M1?=
 =?utf-8?B?K25tdWoxYWtUdHNnV1BGZUY5QTdjSGxJZy9pazY2SFVzR3FWeDB4Z0J0T3dp?=
 =?utf-8?B?Nk5ObTNQZCt5K3ZnVVBGYytJVFhzUmlwaGh4QWpHZ1BEMGJET2NLVVFkT01o?=
 =?utf-8?B?VVMzQVlaZ2s0MDFEcXlwbkNFS1p1RS96QTdKazliN2FjUHNXeWkxUEljUGl2?=
 =?utf-8?B?WmtDVndrNnA0RDdwbldoMG5pWHRnRk5YZ1ZTNm1jMFlqUS9xUnQySDhEcjBZ?=
 =?utf-8?B?bDdrand0RUpvQTFyTGZkdkdLRWJCa3hQODNPMGRTbnQxS2lmc0tRT2QvSmdG?=
 =?utf-8?B?RzRYVS9mdFFyQzk2cTNPT1NkdzhPUEZhT3gzeFk3YmxHd1BJUnk2K0VMSDZL?=
 =?utf-8?B?d3ZqdlFuaXJMWWFwcGJmbEx3cWFaOXFWRFJwazhxZWQxdEtldGZHNCs0MHM5?=
 =?utf-8?B?SXIra1luVVRjZFoyWHFVMjh1V2hpcjcyU1c1R2N3NnA2L3JsK3BraEZYRzhC?=
 =?utf-8?B?Yyt0dTZOTTdFVDZldGNmeVgySzFOVTFyVlUzUzRNcWorakk0N1IwRkhOZHhu?=
 =?utf-8?B?YkVKcW9XcU9JTXduME12QXZmZVNiRStxY3VLeUFKbkhjbTljMkJOcHVMQWdP?=
 =?utf-8?B?eitxZkU5eTN3VGE5Z2M1dnhtamtUcmtMcDR0d0lFU0RqRk9YVG55eGF5YkR6?=
 =?utf-8?Q?4sCoG4kUpkTSe9coKskN4KLYz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <950493FAA79A734D891981D05E07A616@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02da9129-c926-45d6-5600-08dd50d8ff28
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 11:31:48.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7lezKbWKr0YBzApBVUKNQArZmqBJx/TKHTwXaHBL9kZoBAXr5ohuq+UDzqT9ls9hkinjcCwjyQB8n9fbIj78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAyLTE4IGF0IDIyOjA0IC0wNjAwLCBYaW5nLCBDZWRyaWMgd3JvdGU6DQo+
IE9uIDIvMTgvMjAyNSA4OjQ5IEFNLCBNaWtrbyBZbGluZW4gd3JvdGU6DQo+ID4gT24gVGh1LCBG
ZWIgMTMsIDIwMjUgYXQgMDM6NTA6MTlQTSAtMDYwMCwgWGluZywgQ2VkcmljIHdyb3RlOg0KPiA+
ID4gT24gMi8xMy8yMDI1IDEwOjU4IEFNLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4gPiA+ID4gT24g
Mi8xMy8yNSAwODoyMSwgWGluZywgQ2VkcmljIHdyb3RlOg0KPiA+ID4gPiA+IE9uIDIvMTIvMjAy
NSAxMDo1MCBQTSwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiAyLzEyLzI1IDE4
OjIzLCBDZWRyaWMgWGluZyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gTk9URTogVGhpcyBwYXRjaCBz
ZXJpZXMgaW50cm9kdWNlcyB0aGUgTWVhc3VyZW1lbnQgUmVnaXN0ZXIgKE1SKSBBQkksDQo+ID4g
PiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+ID4gPiBpcyBhIGNvbnRpbnVhdGlvbiBvZiB0aGUgUkZD
IHNlcmllcyBvbiB0aGUgc2FtZSB0b3BpYyBbMV0uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiBob3cgdGhlIGJlbmVmaXRzIG9mIHRoaXMgc2VyaWVz
IGFyZSBoZWxwZnVsIHRvDQo+ID4gPiA+ID4gPiBlbmQgdXNlcnM/DQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gVGhpcyBzZXJpZXMgZXhwb3NlcyBNUnMgYXMgc3lzZnMgYXR0cmlidXRlcywgYWxsb3dp
bmcgZW5kIHVzZXJzIHRvDQo+ID4gPiA+ID4gYWNjZXNzIHRoZW0gZWZmb3J0bGVzc2x5IHdpdGhv
dXQgbmVlZGluZyB0byB3cml0ZSBhbnkgY29kZS4gVGhpcw0KPiA+ID4gPiA+IHNpbXBsaWZpZXMg
dGhlIHByb2Nlc3Mgb2YgZGVidWdnaW5nIGFuZCBkaWFnbm9zaW5nIG1lYXN1cmVtZW50LXJlbGF0
ZWQNCj4gPiA+ID4gPiBpc3N1ZXMuIEFkZGl0aW9uYWxseSwgaXQgbWFrZXMgdGhlIENDIGFyY2hp
dGVjdHVyZSBtb3JlIGludHVpdGl2ZSBmb3INCj4gPiA+ID4gPiBuZXdjb21lcnMuDQo+ID4gPiA+
IA0KPiA+ID4gPiBXYWl0IGEgc2VjLCBzbyB0aGVyZSdzIGFscmVhZHkgQUJJIGZvciBtYW5pcHVs
YXRpbmcgdGhlc2U/IFRoaXMganVzdA0KPiA+ID4gPiBhZGRzIGEgcGFyYWxsZWwgc3lzZnMgaW50
ZXJmYWNlIHRvIHRoZSBleGlzdGluZyBBQkk/DQo+ID4gPiA+IA0KPiA+ID4gTm8sIHRoaXMgaXMg
bmV3LiBUaGVyZSdzIG5vIGV4aXN0aW5nIEFCSSBmb3IgYWNjZXNzaW5nIG1lYXN1cmVtZW50IHJl
Z2lzdGVycw0KPiA+ID4gZnJvbSB3aXRoaW4gYSBUVk0gKFRFRSBWTSkuIEN1cnJlbnRseSwgb24g
VERYIGZvciBleGFtcGxlLCByZWFkaW5nIFREWA0KPiA+ID4gbWVhc3VyZW1lbnQgcmVnaXN0ZXJz
IChNUnMpIG11c3QgYmUgZG9uZSBieSBnZXR0aW5nIGEgVEQgcXVvdGUuIEFuZCB0aGVyZSdzDQo+
ID4gPiBubyB3YXkgdG8gZXh0ZW5kIGFueSBSVE1Scy4gVGhlcmVmb3JlLCBpdCB3b3VsZCBiZSBt
dWNoIGVhc2llciBlbmQgdXNlcnMgdG8NCj4gPiANCj4gPiBURCByZXBvcnRzICphcmUqIGF2YWls
YWJsZSB0aHJvdWdoIHRoZSB0ZHhfZ3Vlc3QgaW9jdGwgc28gdGhlcmUncyBvdmVybGFwDQo+ID4g
d2l0aCB0aGUgc3VnZ2VzdGVkIHJlcG9ydGRhdGEvcmVwb3J0MCBlbnRyaWVzIGF0IGxlYXN0LiBT
aW5jZSBjb25maWdmcy10c20NCj4gPiBwcm92aWRlcyB0aGUgZ2VuZXJpYyB0cmFuc3BvcnQgZm9y
IFRWTSByZXBvcnRzLCB0aGUgYmVzdCBvcHRpb24gdG8gbWFrZSByZXBvcnQwDQo+ID4gYXZhaWxh
YmxlIGlzIHRocm91Z2ggY29uZmlnZnMtdHNtIHJlcG9ydHMuDQo+ID4gDQo+IEdpdmVuIHRoZSBw
dXJwb3NlIG9mIFRTTSwgSSBvbmNlIHRob3VnaHQgdGhpcyBURFhfQ01EX0dFVF9SRVBPUlQwIGlv
Y3RsIA0KPiBvZiAvZGV2L3RkeF9ndWVzdCBoYWQgYmVlbiBkZXByZWNhdGVkIGJ1dCBJIHdhcyB3
cm9uZy4NCj4gDQo+IEhvd2V2ZXIsIHVubG9ja2VkX2lvY3RsIGlzIHRoZSBvbmx5IGZvcHMgcmVt
YWluaW5nIG9uIC9kZXYvdGR4X2d1ZXN0IGFuZCANCj4gVERYX0NNRF9HRVRfUkVQT1JUMCBpcyB0
aGUgb25seSBjb21tYW5kIHN1cHBvcnRlZC4gSXQgbWlnaHQgc29vbiBiZSB0aW1lIA0KPiB0byBk
ZXByZWNhdGUgdGhpcyBpbnRlcmZhY2UuDQoNCkkgYWdyZWUuDQoNCj4gDQo+ID4gVGhlIHVzZSBj
YXNlIG9uIE1SQ09ORklHSUQgbWVudGlvbmVkIGxhdGVyIGluIHRoaXMgdGhyZWFkIGRvZXMgbm90
IGRlcGVuZA0KPiA+IG9uIHRoaXMgc2VyaWVzLiBJdCdzIGVhc3kgZm9yIHRoZSB1c2VyLXNwYWNl
IHRvIGludGVycHJldGUgdGhlIGZ1bGwgcmVwb3J0DQo+ID4gdG8gZmluZCBNUkNPTkZJR0lEIG9y
IGFueSBvdGhlciByZWdpc3RlciB2YWx1ZSAodGhlIHNhbWUgaXMgdHJ1ZSBmb3IgSE9TVERBVEEN
Cj4gPiBvbiBTTlApLg0KPiA+IA0KPiBZZXMsIHBhcnNpbmcgdGhlIGZ1bGwgcmVwb3J0IHdpbGwg
YWx3YXlzIGJlIGFuIG9wdGlvbi4gQnV0IHJlYWRpbmcgDQo+IHN0YXRpYyBNUnMgbGlrZSBNUkNP
TkRGSUdJRCBvciBIT1NUREFUQSBmcm9tIHN5c2ZzIGF0dHJpYnV0ZXMgd2lsbCBiZSANCj4gd2F5
IG1vcmUgY29udmVuaWVudC4NCg0KQnV0LCB0aGVvcmV0aWNhbGx5LCB5b3UgY2Fubm90IHJlYWxs
eSB0cnVzdCB3aGF0IHlvdXIgcmVhZCBmcm9tIHRoZSBrZXJuZWwgZm9yDQpzdWNoICpzaW5nbGUg
ZmllbGQqLCBiZWNhdXNlIHRvIHRydWx5IGdldCB2ZXJpZmllZCB5b3Ugd2lsbCBuZWVkIHRvIGdl
dCB0aGUgZnVsbA0KcmVwb3J0IGFueXdheS4NCg0KPiANCj4gQWRkaXRpb25hbGx5LCB0aGlzIHN5
c2ZzIGludGVyZmFjZSBpcyBtb3JlIGZyaWVuZGx5IHRvIG5ld2NvbWVycywgYXMgDQo+IGV2ZXJ5
b25lIGNhbiB0ZWxsIHdoYXQgTVJzIGFyZSBhdmFpbGFibGUgZnJvbSB0aGUgZGlyZWN0b3J5IHRy
ZWUgDQo+IHN0cnVjdHVyZSwgcmF0aGVyIHRoYW4gc3R1ZHlpbmcgcHJvY2Vzc29yIG1hbnVhbHMu
DQo+IA0KPiA+IFRoZSBxdWVzdGlvbiBoZXJlIGlzIHdoZXRoZXIgdGhlcmUncyBhbnkgcmVhbCBi
ZW5lZml0IGZvciB0aGUga2VybmVsIHRvDQo+ID4gZXhwb3NlIHRoZSBwcm92aWRlciBzcGVjaWZp
YyByZXBvcnQgZGV0YWlscyB0aHJvdWdoIHN5c2ZzIG9yIGNvdWxkIHdlIGZvY3VzIG9uDQo+ID4g
dGhlIFJUTVIgZXh0ZW5kIGNhcGFiaWxpdHkgb25seS4NCj4gPiANCj4gQWdhaW4sIHBhcnNpbmcg
dGhlIGZ1bGwgcmVwb3J0IGlzIGFsd2F5cyBhbiBhbHRlcm5hdGl2ZSBmb3IgcmVhZGluZyBhbnkg
DQo+IE1ScyBmcm9tIHRoZSB1bmRlcmx5aW5nIGFyY2guIEJ1dCBpdCdzIG11Y2ggbW9yZSBjb252
ZW5pZW50IHRvIHJlYWQgdGhlbSANCj4gZnJvbSBmaWxlcywgd2hpY2ggSSBiZWxpZXZlIGlzIGEg
UkVBTCBiZW5lZml0Lg0KPiANCj4gT3IgY2FuIHdlIGZsaXAgdGhlIHF1ZXN0aW9uIGFyb3VuZCBh
bmQgYXNrOiBpcyB0aGVyZSBhbnkgcmVhbCBiZW5lZml0IA0KPiBOT1QgdG8gYWxsb3cgcmVhZGlu
ZyBNUnMgYXMgZmlsZXMgYW5kIGZvcmNlIHVzZXJzIGFuZCBhcHBsaWNhdGlvbnMgdG8gZ28gDQo+
IHRocm91Z2ggYW4gYXJjaCBzcGVjaWZpYyBJT0NUTCBpbnRlcmZhY2U/DQo+IA0KDQpBcyBhYm92
ZSwgSSBhbSBub3QgY29udmluY2VkIHRoYXQgKnJlYWRpbmcqIE1ScyBhbG9uZSBpcyB0aGF0IHVz
ZWZ1bC4gIFdoYXQgeW91DQpuZWVkIGlzIGEgdW5pZmllZCB3YXkgdG8gKmV4dGVuZCogdGhvc2Ug
TVJzLg0KDQpBbmQgeWVhaCBJIGFncmVlIGV4dGVuZGluZyBhcmNoLXNwZWNpZmljIElPQ1RMIHRv
IHN1cHBvcnQgZXh0ZW5kaW5nIGFueSBydW50aW1lDQpNUiBpc24ndCBhIGdvb2QgaWRlYS4gDQoN
Cg==

