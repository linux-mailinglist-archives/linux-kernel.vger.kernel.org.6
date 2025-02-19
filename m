Return-Path: <linux-kernel+bounces-520868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EFA3B03C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DD67A5BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7E1A2622;
	Wed, 19 Feb 2025 04:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co3myn24"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CCCEEA6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739937869; cv=fail; b=ge6c+SjVSo5FM22uDf5YZQpUX9L4RY/MI5NCE1oiY+TM5bvEc5Yb0vxsCZoMuMDVCeCDsdAbXhkLwDmiVZ8KHTOQU5CQHH/Gq/wbnmOWxOrQcdG2mUsQGxSeAbGez/1CqwFlRB+IFF3z15sbzBv51sSh8Jme5kvHpoGIEr6/1jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739937869; c=relaxed/simple;
	bh=BOx38kvW8oi6/8LMxt+6j05GKnq179EKNOVF6yGO7zc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R8SQ280kCvDk4yiGho3uY7S3nhkvzT1/az4SzcXO7hWnsBC232JQaXw1BnHA55WyT6eXlFBPB3EdhI42YxsuS+BkMses0cgu7pqnfp09IbPOhLwaLgkfv6A4JlooeIJSCbBD0lYa8L01VGtt5cy6Sw4TrSse1XCYGag11yvh5pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co3myn24; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739937868; x=1771473868;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BOx38kvW8oi6/8LMxt+6j05GKnq179EKNOVF6yGO7zc=;
  b=co3myn24VQcnwztZfci4rOydyK2XdjDL7vTJncc0iI9Y2pphk4QKQNXL
   A9o4el46glgtmZYtAGmKoEFK2WOZL/6VM65Q2gWa5BRfYPBJqmzr9y29b
   aJ1fAe6/Zjuwbvg14phclljkVaMWtDmfJGNM3W76w9afXnUZT7KyAVL6F
   dimvbOEEOXZiAeoL0f+EB1jag5vwPQ+GBRmCT6ZwH+mMgnL3yFCevzl2y
   XSqpWHNe5O9eBmjTeYaC/dfcpvG33pjguF3cDvGWhnDmaptGoMoL1WmxY
   dHRkWPxOR/AhX2sOZQwXpJrMM96VQB8kzy1v7Mz0uQIiY5b3Y7UYAfPwi
   Q==;
X-CSE-ConnectionGUID: yuPFxqYFQBCISCIGPmFrPg==
X-CSE-MsgGUID: IaGie5t0QhiGs7YgNFpcug==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40786589"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="40786589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:04:28 -0800
X-CSE-ConnectionGUID: QZBDXzWORZqkmvrY7vr+Jg==
X-CSE-MsgGUID: 0+MSE/QUQ4Wl2VrS8aN+Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119528435"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:04:27 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 20:04:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 20:04:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 20:04:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIYcEwNyBrfHiJvP3r7LOJkdkSDyuazDMsuDcGpHkkxYfEVpNKZFP4jX1pxYxiqlA8+qOKirvMCKvDrHqjeJkD3mmbx/gOn46hrjWeiNrH7vqJiEGjZ88iKTubgfdZeqCARShUpUSaEsbQOngd3q3MxDKir5ZoLIflmyfxa0Ux8tc18j1RnGSWZWQ4sQY0lkrC7/i4yxdXrdGe9Lmhmvic1MPcfPDVq71GVbiEE54c5gQxFuElIf7kf4TwUCmy4sqWViGEglB3YIVWvvgGD41wbAtIBkZr5a7u/a9Y7Ds08zcIpnAKq78mNUiOiz6zHC2TBx/4YY5fnwuhaAesACaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baXoFjI+VZKQD7HVVeQWUi5KlfoN5rxlVaiqiR3SbAI=;
 b=qF+/Abo28jFkWI2wV/gaPoEVp6iFEhy7TSXAsJkdIulN1i+gupCgHBkmjEUVX+WZSvIAYLAad5WBeS61oOygs/DFSz5VQFfgofRC6Uu2clr7MFG2W+imSABbBd++QQlXqxzS4N/ibYRj5fBPrf19VmXqjpcvssYQYQDjVQPOYQYCQ1X03RoCuBzH7D1BjET0YCrjnHPGqj6KAcsHNgJpyQTjLyYo3sy+q/WUFZilqn+msfS8dw9/4s/kgrjxqf6c7uV/N1VzliUjJNtKHKJKRTLiOoxYDU0wA1L9Ag5+1c+LzUCjJahoXQYPcnLwaB//DjFFzObV4YG9Q0cQ5ksIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Wed, 19 Feb 2025 04:04:23 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 04:04:23 +0000
Message-ID: <465d712c-b638-4884-88c8-1a88c506efdf@intel.com>
Date: Tue, 18 Feb 2025 22:04:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Mikko Ylinen <mikko.ylinen@linux.intel.com>
CC: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
 <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
 <Z7Sd6FuDDMgExEna@himmelriiki>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <Z7Sd6FuDDMgExEna@himmelriiki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DS0PR11MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef27af6-bb24-4fcb-b514-08dd509a7e64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEZDTWZuL010czU5ckg5Slh6V01aVytra0xzOW1GeGY3SW9oM2h1TjNvTWUr?=
 =?utf-8?B?ZFhQaXY1b0czWTg5TFFUdmUzcHMrU3ZWa2pzYVkreXIrZ0hBMS9sVWNBeUx1?=
 =?utf-8?B?SGNFZGw5ZEhUTHgwanRndDVKTVZpdEo2Y3VMYVV3RiswM05LcVVlL1hqN3ZR?=
 =?utf-8?B?STgyTGN2Q2Y1RVh2cmdSYS9QN1M4bGV1dE9sU0x3a3drSDBwZkxrZGVZRW1r?=
 =?utf-8?B?OTIyZ0pMUU1OcDI3ZWw4eWpHS01IUnpXYTd4T01kUnhYUE5rSXlzQ1IwRm03?=
 =?utf-8?B?MzRnZGk4dkZIOVBzZEFoOVZiWjJGSjNONGk3dTRmRWtDK3kxSWRYaUxEaVdW?=
 =?utf-8?B?Z2M5alcwWmo2YWNwbkJWd1BsV2FUU1N3WE9HSy9xZWxGcnJyZFdmOFBhS0JC?=
 =?utf-8?B?bjNTSEZDQXIwWTRVNGhQVk80QWExKytLV3NiZXJVSUphdUxxR3dIazFBckVU?=
 =?utf-8?B?cGtMNDhaRkVFYmlNb0N5cWFYVzM0SldJVkhIL2d6ckx0enpINEk2RGRZUkgv?=
 =?utf-8?B?aUpBay9nN2FjOExmekVFS2oyR1ZkUlRWNXkxVUN6SXZoS2pod1JmMDRTem1B?=
 =?utf-8?B?MEpqVnJrUmlEWVpTM2Jqc2lYSVlMUkt0RDRUdlFoMURVK0grUXNzbzY5M2cy?=
 =?utf-8?B?emprVTRzRW1VTHVUNnQ4SEc3Z0Rhc0F2Y0xHMHZ0cFpJWTBtakxlajZtK0t1?=
 =?utf-8?B?bU5DaWpDaEViQ0FjTWFFUUV5MUFEcDlRdGdIUDI3bUtuRWZPbEtPM2ltbXdj?=
 =?utf-8?B?SE1haW9zWUpNL09YOUorL1RKOTJDb1c3cHUrRUxVZDJlQTI3TStCZ3JienZT?=
 =?utf-8?B?VFdBb3loQWtqQ2NwczZaSmJDYmFVZk5aWEY1QjM3ZWw0MCtveFlZMUxmZyts?=
 =?utf-8?B?L3VIVE1XR3BuekZtdThqeEp6UHNpWkJobUs4TitHQ016Qjc2dGhWQjd6UUIy?=
 =?utf-8?B?amhCMVFVNWNmc0lmV2IyRm0yK0ZlWGFjTGMySUJOeWRLR3ZKbjhHQjJOcGt3?=
 =?utf-8?B?Q3lPK0RGZWJxemhSNHE0YXlic1BjQnNqM1hjaUcwK2dSN3pCS2l0TC9ZTHdk?=
 =?utf-8?B?UVVJQUJubFhINFc0a21PeWxnWlBkYzNJVWNuUGdEOTdjUGZSaWc4dHBKTU1n?=
 =?utf-8?B?Y0R3azNJZFZlSFNlWU1NM211ZC9MRzVCaUFpS0U3ZVNoOHVyT1ZMVlpxVEp3?=
 =?utf-8?B?YlpqTFJ0L1h1RDh5K0pUdTIrMHRobzJaOExxeGdxbUFqQU83REdiVWZVL2Nk?=
 =?utf-8?B?cWVHWUhPa1JadzlZVGxOT0k3bXpJL0hDSlBwRjlESTVYMU9IdjJnVUpWWlhQ?=
 =?utf-8?B?eGlNV1NsUXJpYk5IWXNsYXZhUjNMd0g5S29zMVZXQkZaVUtjQ3Z2S21GeGRr?=
 =?utf-8?B?OW5DcnpBaDFmcjZyNjJyalJETWdUQXkwTGN1VmZkSkg3SmNqTUMzT3FYWHNJ?=
 =?utf-8?B?N1JPSkZLTlpxMzA0T3daS3BzL3VmVnFoeUFQczBJSzhOZWlKRjkwUjFPa3JZ?=
 =?utf-8?B?STlhYkZkMlBNUHZteS9kdWFkNEZ0TUNBeDJCTFZ6TjJsZy9mWmdpMldYREJJ?=
 =?utf-8?B?K2w4SHBmdzZjZm50OWd0Tmo4aWNZeDN2TTdvQlNJY0N4R1NLY2lFWGpkRDFZ?=
 =?utf-8?B?dkFKSHFiVHA1TFV0NlhYU29pNWx0S3FXYUdHZlBaRlRkNElkelRmTGd0cXNt?=
 =?utf-8?B?UTBaZkF5MDJ2TWhydjBWSmtHL2VUYUlCRUMyOExobnRjSVVSNnM3VDBmVFZH?=
 =?utf-8?B?UGxiOWRKbEZGTzk5N2NRNHhtOVlsd3daalJOUWpWOUo0dmpsUk1XMHozNUM1?=
 =?utf-8?B?S3lYNXAxM2s3cUNFdE1ReGJWTGNwRE5RR1JUdnFybjhjYXA4ZnY1d2E2Q2I4?=
 =?utf-8?Q?ZpNAEU4BsYQEP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRnaktvSFJYOVBRdXREVy82QlNsYllOV1RHWG9KbGY3M3NEdHhwQXdrQVFP?=
 =?utf-8?B?VnBWTnIvZnVWK01jYXkzREEyRWRzNE9QTG91dUI5cEdqVC9samR5eVRQd0tp?=
 =?utf-8?B?bjV5blp4eXJRc2s1OGxLbnhUKzFoelVRelkvMkIwRUE0K3dKb3AzYXdVY2hs?=
 =?utf-8?B?NmVrdmtDK3luM3R0cWhZalZwLzZSWVNMRm9rdWNHR1RkcmZxWGR2dkpiL0hv?=
 =?utf-8?B?M21MU01XNW01WHVSczl6NEQ2V1RQSkhCQVNtL2VKaTk2OVZjZldzUHZJdVFZ?=
 =?utf-8?B?NE9QZnFEM2RhNVFvOEZDUXJRZmI4RDFvc040b2JRcnI5NkdiVEQ2SmhvS1dK?=
 =?utf-8?B?NVBpQ0IxbnRaYjlUb3JUSUhFQmFFY2NUTFY1MXZtT21laEpYUEZMUFpkSDZj?=
 =?utf-8?B?bytvSklDaHB5bFVDQmttZjNVRXAycDJIYnRYZlVXY3B6YXMvY2JjN0Jsb2x5?=
 =?utf-8?B?RUNXcTVXK2dtRHpDNThpMkU1blFkQ0xtVnR4d1duYVRNVElkTHlKR2hZQkY2?=
 =?utf-8?B?bU9TelZwTHNaNW5STWxOYVpQVDRSMnlWWXpWSGNTRE5lWW1ZbmNhRVRVcWtD?=
 =?utf-8?B?N1Ewb0MxU1ZoMm1PR3JYMEVmZmZsbVRFMkxNSnQ1U29sYk5FQW1WWEtML3Mw?=
 =?utf-8?B?TGJ2bXIvSkhoK1FqaXFYZE5aNnkwVjlXaTJoQ3d4Q2JTZjNOZXpJNjZEcDJE?=
 =?utf-8?B?N0p5amE3ZVh6dm96NEF6S0NUdEFCOTlTTkh4MDhLc1Z0MjZNeTgzOFRXcDRj?=
 =?utf-8?B?N3JCQ2gxRHBzZG13eFhXU2RoUDRreWRXRTNNNGNIaDNTeVpRbnZwY3kvWWZz?=
 =?utf-8?B?R1Q4dkFHSHBYQjlIRUVmR1lnR2J6NnhqWHZaQXFUdmR4ZXVoSXVtREJ3bFR5?=
 =?utf-8?B?ZUo4Y01MZ1duakR6VkN3ajZ3MlRxUFlqMVpBNm9mN3lrcTNtQlJ6VnNzejNG?=
 =?utf-8?B?MXlKMXcvNDZPeUNBckcrZ1o5dElXVXI0ZUUzWWxuekJjblFWS0VBOFZCV2xD?=
 =?utf-8?B?MWV1NGk2TEZ5aXhsZ3lKVnJYaWlTejhiazBiQjlMSnErT2lUa3krYitQbjlO?=
 =?utf-8?B?NWdsaS9nUXgrMUVNQ0ltZitJamlaSXhJeFNaMjJidFljWHczajdRSC9xMlA5?=
 =?utf-8?B?UVZuUXVjRVNVS1l2M0pzMGpldTVuKzY2STZJQUhRekFwY0IxQjRWYzc2QUh4?=
 =?utf-8?B?Vm1tUnpCQ0VCeFZqdFR0TVU1MEF4QjU4Y05YUWN4WE5HdFo3dWkwU2Uxb0d2?=
 =?utf-8?B?bURMUWVtSzRZYTBzakMxSThwT1hjRDlWa2lwNnRiNTBOR2dQOUo1RXRKeEVU?=
 =?utf-8?B?Q21nVy9JdzZPMGJpc3NEZ0hMdG1hV1N4TjJjZG1ONnpXbWhpZ0UwL3NBMHVx?=
 =?utf-8?B?VHlPdjJuR3RZY0JmNEU3U1JRNjdsSzNhVEhFVzlDaDYvUW9HTVNINGFaM1Yx?=
 =?utf-8?B?NnNoZWRCYXFVWHk2SUgxaVJ2MXhVd041TXZjL0FJTlJYVVBNNFFvWFRYd2xN?=
 =?utf-8?B?ekpSaGVtQTYxYWVZZi9Nc1MxNEdia3lodjFvMWtkOUcxaEVYN0YrVHdDRnRD?=
 =?utf-8?B?cmlOdnAycmJtdXBsN2taQ2F3NXRDMVQ1ZTdaSkU5Q3A1a1dqb2R3S0VjUUcz?=
 =?utf-8?B?RWJKMXZtWkU0Qy9yOTQ0eEt1azgzdVRkczQyMzJYSE1tcHJZem1saks3cldM?=
 =?utf-8?B?NDFuUW9PR3BnSUwrQVYwZklLbitIeTRlbTFITXVVRGNUL0llSHZTOUd5K0cx?=
 =?utf-8?B?d0hDRGx4MFF3ZmZGLzZwYWJna1RFWjlKT3pQRHVjeldvUFNUaHZwemxzN2lE?=
 =?utf-8?B?dzJvNUhVTjNXR0poeHRtZVE5bTEwK00zb3VFQUNUcGNZOTJQTzZ5Qy9DcW9w?=
 =?utf-8?B?MmJJZGRYNWlnTVg4eWFXYnpBaHAwL3hUUk9wSkhQbVhaWGZQNGMya2UzRk5Y?=
 =?utf-8?B?ODhxemljR2RzSUw5RExnQWhZcnZISXo4TEp1TUs0WnIvdHNvTmZnVnRaNUYw?=
 =?utf-8?B?WHRnK0F6ZzR6K2t0U05kUXFIM3F0cS90UEM5RWl0eGNzd3lvSDNCdGMxRFBt?=
 =?utf-8?B?QStCRC8wdUVqaXVmTHNla0dzb3dKaUlsZ3EyQVVWanZNbGorQXV1K3Yva0lh?=
 =?utf-8?Q?KFGK5tQjKIUgFxdRFK9ZOb94c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef27af6-bb24-4fcb-b514-08dd509a7e64
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 04:04:23.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVHc8X5JzZw0ME37SNlCevuBK8KVpihxtmFSUBARbYJQ3R5yg6h9FWZ3PVL6uqMkSn+q5//HyDbg6aLSX1kPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7621
X-OriginatorOrg: intel.com

On 2/18/2025 8:49 AM, Mikko Ylinen wrote:
> On Thu, Feb 13, 2025 at 03:50:19PM -0600, Xing, Cedric wrote:
>> On 2/13/2025 10:58 AM, Dave Hansen wrote:
>>> On 2/13/25 08:21, Xing, Cedric wrote:
>>>> On 2/12/2025 10:50 PM, Dave Hansen wrote:
>>>>> On 2/12/25 18:23, Cedric Xing wrote:
>>>>>> NOTE: This patch series introduces the Measurement Register (MR) ABI,
>>>>>> and
>>>>>> is a continuation of the RFC series on the same topic [1].
>>>>>
>>>>> Could you please explain how the benefits of this series are helpful to
>>>>> end users?
>>>>
>>>> This series exposes MRs as sysfs attributes, allowing end users to
>>>> access them effortlessly without needing to write any code. This
>>>> simplifies the process of debugging and diagnosing measurement-related
>>>> issues. Additionally, it makes the CC architecture more intuitive for
>>>> newcomers.
>>>
>>> Wait a sec, so there's already ABI for manipulating these? This just
>>> adds a parallel sysfs interface to the existing ABI?
>>>
>> No, this is new. There's no existing ABI for accessing measurement registers
>> from within a TVM (TEE VM). Currently, on TDX for example, reading TDX
>> measurement registers (MRs) must be done by getting a TD quote. And there's
>> no way to extend any RTMRs. Therefore, it would be much easier end users to
> 
> TD reports *are* available through the tdx_guest ioctl so there's overlap
> with the suggested reportdata/report0 entries at least. Since configfs-tsm
> provides the generic transport for TVM reports, the best option to make report0
> available is through configfs-tsm reports.
> 
Given the purpose of TSM, I once thought this TDX_CMD_GET_REPORT0 ioctl 
of /dev/tdx_guest had been deprecated but I was wrong.

However, unlocked_ioctl is the only fops remaining on /dev/tdx_guest and 
TDX_CMD_GET_REPORT0 is the only command supported. It might soon be time 
to deprecate this interface.

> The use case on MRCONFIGID mentioned later in this thread does not depend
> on this series. It's easy for the user-space to interprete the full report
> to find MRCONFIGID or any other register value (the same is true for HOSTDATA
> on SNP).
> 
Yes, parsing the full report will always be an option. But reading 
static MRs like MRCONDFIGID or HOSTDATA from sysfs attributes will be 
way more convenient.

Additionally, this sysfs interface is more friendly to newcomers, as 
everyone can tell what MRs are available from the directory tree 
structure, rather than studying processor manuals.

> The question here is whether there's any real benefit for the kernel to
> expose the provider specific report details through sysfs or could we focus on
> the RTMR extend capability only.
> 
Again, parsing the full report is always an alternative for reading any 
MRs from the underlying arch. But it's much more convenient to read them 
from files, which I believe is a REAL benefit.

Or can we flip the question around and ask: is there any real benefit 
NOT to allow reading MRs as files and force users and applications to go 
through an arch specific IOCTL interface?

