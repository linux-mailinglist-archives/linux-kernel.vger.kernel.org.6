Return-Path: <linux-kernel+bounces-341211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F9987CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1021F23F16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F841667F1;
	Fri, 27 Sep 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQ8YV6r4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858714A4CC;
	Fri, 27 Sep 2024 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401713; cv=fail; b=EW0a5TpVKuXQhQ+7kwpIvPLW9yG9n7277gxK8PHv5z8LRXTyziIUjHt8Xg9FbQNh5caggWmVT105BUwBQG2GJX0Wd02ajXTjuChLtiTMfMrBOtq5aZ/9JyQF92o4r4CCLxZ/0yGcHDBrcz4tJOynv8x54aJ7KENaU/GhJRsVHbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401713; c=relaxed/simple;
	bh=+gCFAHWK3Nafp0O93un5+IXWsbT8PkIRN2oSw9tUgIc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=amSWoMp2ruQbZecsYSl8RYhhNURFnzoajsxch3Luch6c6hUB3Y36hMIsnNxUhsAU1OdlvtCp7s/W31kwjhXh//nx7MlHBrRVPaTWjvTIqNl7l2BG122n4CTyFpbVZLupw+jTHvZy9tpi05o3sEyp4cvREcR3t7fCOmNpKYOSay0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQ8YV6r4; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727401711; x=1758937711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+gCFAHWK3Nafp0O93un5+IXWsbT8PkIRN2oSw9tUgIc=;
  b=VQ8YV6r4MPJtPVvAp2r+yBA+1tCLREbwrUJpxqGBCdLmX2KNOMTZJ6WS
   HQQGlyk5ArBbAdz9OwBpOI2/BYIX29japfXDrVFalpMQNI6HmCHWJJWkt
   pj7zOd0l0qS8QDMpK4alRbjoJpDNR+LmIOhHl+fgP2B6JwQVkk7qIfrpn
   Hm/zwLlxdrVdV5E+AlIibhZiKvyDzUBHDPGEHfh0dFsyX3UlaYvoGv+YL
   GrMpoDrfFGXl0vxvBX+mGsGPoUPe7VZu87ysMNFSg4yN1npeicKajUe2M
   m82bhoJMNlhx+ftOIxObKVACgUZ5HUOXXwZTcWtv/GCnnqDsfWQpvJK6q
   g==;
X-CSE-ConnectionGUID: LAcH0N3sTJCFOft4+ZCSrw==
X-CSE-MsgGUID: F5CxEcW4RTKnSgiRS2h1ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26710771"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="26710771"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 18:48:27 -0700
X-CSE-ConnectionGUID: GdBTBfzQRgaukEV30FBmhA==
X-CSE-MsgGUID: cNBA4B8SRS21DgsAXpmHJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="77191331"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 18:48:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 18:48:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 18:48:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 18:48:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 18:48:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dY4TeSVUWBz5MEp+O0Mb1dAKhz7H2AVS6POfs3T+ekV8sNWmVYGc9rOtHmdsPWXT5uJRrJDhnTLAyhb2qpdBTPm0nkJ6wcqJtgZjYz3b+9DjfLV96sDuxT71eHIld/2hq5gVU4q/brnK8kcMXlKji6+3RzTu69WUph03OT64CQnkY4xkDbclYiOimV5AuG8VV5vzZpOdU596ZKGQVs5Q3ZerZa3Nzrwh9miJkJLa7G1zHsPgMcyUVw4SNLoXnUsGXwXaT/Vyhej7h3pICYGzEH0pXxjMpUNlLdym9788tu+NZubRVw3NiAoAj7Zd/AkLtLHAB6uu422zcObXoXl6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jeviID9JYr+1EvZepo+hGMWML0soduIbuQnVFs8MnE=;
 b=cLvX5xR0RVbWL+uhwwZR7MX3iRPQa/kairaJ8zPkXqFp4DTEMpXWOC0ExzbiJNuyCwRDRIUkdYWmJ76i64m2l/+Hq+8oMGtBschk5cXmg//iYn8LVD9oFuxBoq0GAXJxuQVWBiQtt97Odf2POgOT3ybL9jHS7rXYiY8UgJcJU4gYfCH+mONu7gS++FgeZVf3ZpXePDuTuLUbMnfGeBHe0t2yG1Tes7a5qBG/b0/9sUKnmN7rIKDmfoVhQNIRzWUJeJTWBAvWNkTqgEEnceDA4Gv9XYySr1PWG9KhMEq7RBTMYN6m0ajN3gQpEyZWMljfnNqN8oEFKNpB8fWR/uEmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 01:48:18 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 01:48:18 +0000
Message-ID: <f3edc43a-886f-47a2-bde4-1acc0c0dcc88@intel.com>
Date: Thu, 26 Sep 2024 18:48:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/24] x86/resctrl: Add the interface to assign/update
 counter assignment
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1725488488.git.babu.moger@amd.com>
 <39a621b5281753c9f13ad50808d478575cdb52e6.1725488488.git.babu.moger@amd.com>
 <9109e7fd-34e3-485e-bd20-dfd4c68edd01@intel.com>
 <791e12c1-ddb4-4d65-877c-a7d887d3ef6c@amd.com>
 <faf2b24e-4329-4b73-a012-10e85844fa74@intel.com>
 <9573dd90-a028-493f-9957-83ef787badda@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <9573dd90-a028-493f-9957-83ef787badda@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:303:8d::15) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 65258433-227f-45c3-d0e9-08dcde9675e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wk1NeWJJdWRnVHBpWHoyR2o0WThjdzUyY0xScUxsRFlnM1Rmb1FPUGtLVjZG?=
 =?utf-8?B?WERTMTgwNWpvcDE4Mkg4UU9sUnlGeVArSGpXczB6SWZVdVJLazg2U1VyK2JK?=
 =?utf-8?B?VnVyYzFRNDhXNDExMzR4NldQcGhNMERGU0g4Q0FMUmZ3am8rczVNb2dya3ZQ?=
 =?utf-8?B?aUFXRzR3aEdSRmpaSThYck5qZE5hS0ZTTTJqTnd0MjIyR1JGZU40VG9YaXpC?=
 =?utf-8?B?dmxRS21peXBqdnVHVTBvTndCbFRSWE1mbkcrL2VFZmMrTTdxeHNRZ0xSMlN4?=
 =?utf-8?B?QTJPczVYN29zTU9lLzhMeDVKQjBmOXNOcFdraUFCUDc4WkJxelZtbjRWK042?=
 =?utf-8?B?M0R5b1B1YWFmSkZKVktWcTVHcm5maUZ6MUhvQjlPRi9YeGZYbURydE12ZlFv?=
 =?utf-8?B?Sm5tZHpwdHRaOGY3dTdldDNOVFMxOWtUcU0xbTd3VUh1Umh1aEt4d1NJRitQ?=
 =?utf-8?B?cS90Q3pkbk1hOXdtelloTnRQdWlxU3poR2xrZC82dWJTNnNVOEJ0U2ZjSm4v?=
 =?utf-8?B?L0xndFRXZERpd05ZaVA4VFVweXZiZXE2V245dERPZkhZMnd4N3VlRkl4dHdX?=
 =?utf-8?B?b3BNZ052UTMvbitIQU1GaDZTQTZMLzdXMFdVSXdPVm9YZC82dVAxSXl0Um9q?=
 =?utf-8?B?cGkvdmk4Z1g3MlZwMEsvUXZlUlFlNXJBWlgxeGk5ckErNmJxMyszRmpUUFpw?=
 =?utf-8?B?OSsrU253SUZNTS9VaG5JK25zZ0xOYXo0UC9ELy92aWVEWkd3SmZaYmdqMG1Q?=
 =?utf-8?B?cThDLzdzM0NMVjhlc01mY0p2azZEeUE2Q2pGOHkzanhLbStGTlhCU2RTcU0w?=
 =?utf-8?B?OWZqV0FZTjBkQW5vNXQ4cy9zRlNmcXdoQWpmTVNqY3JWOElHcWM0RXZudlNE?=
 =?utf-8?B?b09aSWx0Z1h4RnhaeER4b0ZBMzhMNGRHRVRmYzh5N09rVU05RWFuaDdPSXcw?=
 =?utf-8?B?UWk4b1BBRGRUREJOZVB6U1JjL25FWlRkanplOW9UN3NnbmppYlRkRTdHaVly?=
 =?utf-8?B?elIxNFJyVjRURzd4VXhFaFFrT1BQQWU1RjNzMXFXTVVoT0JyV0tRb3F0UGs1?=
 =?utf-8?B?V21MSFlzR0pRV2hFZVdlUkhOSzBzN0NLL21VV1YrSUEwVG9oOG9raVIvQjA1?=
 =?utf-8?B?dHRVQ1J4WG81TlNOWHE1UCt0b2QzYXdaVmtLcWFoQWg0V2FHZDhzWWpEVTJw?=
 =?utf-8?B?VFVONUd6NUNtQmFpLzZ1MFJjWVBuNHVpL09tY2k1bU9kbEFhS21ZOWFoUldl?=
 =?utf-8?B?Lzh4aVh2MGJJbXRoMUJ4UUNCa291UXpKViszSDJmUFZjQi9JQWlwNTdoaTdU?=
 =?utf-8?B?b2NSMXFtdThnbktYV1RpanlqOUtMeHVmbnJQS1Z3Nk1UMUZDVFBCVFhIQVc1?=
 =?utf-8?B?NHpHbnFES2ExcEgvU0o5aEVkSmhia3Rycm9XU1BiUFhPdnFGZkx0NXQxTFpP?=
 =?utf-8?B?UmVMK1Q1dUZwV1FVZkwzY08rU3ZlREpmd1Jic1lpb1pDMGhuMDRva1lEMzcx?=
 =?utf-8?B?dHc0RG0xZGNqVGFBM2tNVkpaSWlINzBBL0E5U0VuOVczV3dzeG91NEY2bFFE?=
 =?utf-8?B?SHNFN3MwYm5VTWdQb1A0aFVnK2JrWE8waVhPN2MzWlBiT0NEMXNTM2NLL09N?=
 =?utf-8?B?VTByWlNaRlBYZDRPemJ0b0tXRXlHc0hwS0tjclFxZWpZVnN0VjdOWUh3K25X?=
 =?utf-8?B?dkQ0ZkthTE5ib3M2aXZMcHBtKyswVHh6TDF0ajZsdUZObVZLVGo4dEN2WWU1?=
 =?utf-8?B?aStwZEVPZ0dWa25PQkhRREJxVEFvUjJKV2VwVUhnM0kzTUI1MjVxZTRCeVFa?=
 =?utf-8?B?bnlPdHc4REVZSjlhcnd5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2pIZ2xXTUxMZWRhd0UzOGVMeG1lQWhkYldKVFlCdnpBSUxuS3kzdkNLZFc0?=
 =?utf-8?B?K0RnNkZta1o1UnlpZ2pIVE1LNkhDN0w4K1hqc24xZHhQWUpmMktyWjZsSDl2?=
 =?utf-8?B?RkJ4WXQvZ2d1cHlBblIxR0c3YkZRUWlGM3h4Mll0cjAvRGhjZTMrcG1XdVk1?=
 =?utf-8?B?c1pPeFhxY1JsMThDUkU1Sk5yeTAwR2NSVnNGMFpHQ3ZlNkxSWlphM2l6WkhQ?=
 =?utf-8?B?SUVkN1p2clBoNUZ3c082aWV3MWsvbmpLZzVpM3I4YjdYRldpZEFZcFdmSWFB?=
 =?utf-8?B?TlBsaklUVUxIZXBpVkxvUVFrUjVVNjlaYVpBVGZya04zOUo0TFVRYncrMXFQ?=
 =?utf-8?B?WEVRellGYjlvTC9MYklJRmNWRGFjS1AwUXpSZEFIODFuSVN3amlrS1huRXlQ?=
 =?utf-8?B?YU1sOVlrSnYyYllIVDdjZ3ZreG9vSE9wUGdOOVZRc1JFdWlIV1BGYWkyK2pK?=
 =?utf-8?B?ZkpHb0h2VXVFNXlpRjh4QUNNSWhVY2RydzFlNlBxOGx0NTlZMWJXWkRzMXlt?=
 =?utf-8?B?S0ZWbjQ4OE84UzkwSzN1WEtMYUh3clFobVRwTGRBdHh6MjVOandnVEtpKzZT?=
 =?utf-8?B?TWwvUkt6QWNpRzJTeWVoL3JGdWNjVnVrcVJYNFNnbWoydjNJaWluQjRiS0pn?=
 =?utf-8?B?U05UVmVnLzA5aGdldUxrWWtSNXc4TmpEMEhFNUFpbzZGNTJzSytvNVBwV295?=
 =?utf-8?B?QjVDeGh0U3pneW9TcUJqSVYyL05QaGlrKzRqVW9qakxQL3ZqZHYycFNWVzNS?=
 =?utf-8?B?cnpjeW9yU2JMN3BmS0JTanlMUFVGckxuY3RPeDhZb0tTRFJNcDVBMDM5SnJC?=
 =?utf-8?B?VzhsZHhwNUgvQ21VbE5tRHpDUkpmZW56ek1nbDVMQ20xUXQrYitGV1djYkdy?=
 =?utf-8?B?WWREMzBza0w4OTRRVWxESEM1R3hSVENoSFdVV1VheVVkTFpYMEhpM2pldno5?=
 =?utf-8?B?VGtRTnIveUpGZ0kvMVJSZXEyd3NtZkRPeGNIWUhrRG5DL1BhOCt6VjBjY2sv?=
 =?utf-8?B?dkhnaCtFUkE2S01McVhld0xsTzZRcU5VMDBDZkozSXNvV0xYNjM2QUw4QThn?=
 =?utf-8?B?NGxTQ2xKMEczK3lSY21QUzRrNHN6K2hBK2NZTi9TUGMyek1hQStCbnRydUJh?=
 =?utf-8?B?U29YYW9IYXVXRCtMSkF0U1BQeU5vUnZQbEhRbklnWEVocERCa3p4TWx3Ym1q?=
 =?utf-8?B?bm50VmZJNEluMitHZEZXMTdOZGV1TklKbUZNWDl2QXpmQllYZ1lEcFZZdmxE?=
 =?utf-8?B?d3YxTXNpNzFXMnFpZVo1RVdnbDdMWkNzOUFEZHUwT0c2ZUJaZHpZOXVkZ0Jw?=
 =?utf-8?B?bXJuSHc5eSsvbnJvVU0yRHBGUmdCYUR1bjdIakF0Z21haVlaNXNzNkl6U2tq?=
 =?utf-8?B?Q1RCQW1qSlRiOXdWbVVMYW9rdWxVUGtZQ3hMVWZsRVRtaWZybnZwdFNPa3ZX?=
 =?utf-8?B?Tm9CUEs0OUtEZlkwNnVZQ2JiLzIzd203RXUwcG40TlZNdElJVlNodHBJdkRn?=
 =?utf-8?B?R29jR1hUbllJYUFLZ2p3anJ1YVlUeUdzbEVmMmlwMTNaQ3VtakhsQkRLMURq?=
 =?utf-8?B?L1JNK0FjeXNSaW9Zak5kb0Z5MUhJdnFmcVh1cjF5ODFWSmdHenZkNEx0QktK?=
 =?utf-8?B?VHNaUngrc1lWc2ttK1FTYVFzQ0pZNmZ5QmN1Qll2VjVVM2I5Umd0N0RjMEFQ?=
 =?utf-8?B?aG9iT0JDRWRBSDJWUlZSdXVWbmxLWVowcjJ3bVdWdzJyQWhCQnozNGdROWdT?=
 =?utf-8?B?c09hYzlmcVE1cHI5S1FsTmVqNkdWUTU0T2l5ZUQySW5kRHA1ZFNPa01UdWlL?=
 =?utf-8?B?L1dSckJBak90OE1jbFE4WncxZ3N4UlNKUmliNnhSQ1VGZXlQVjIzSVVROWh2?=
 =?utf-8?B?VlR1QitOM3QzcXdydnNMVUZpdDhyOFo1T1pUNXRqLzlhQXU3eDNSL0hKK1Zv?=
 =?utf-8?B?V0cwY1VseXhsUzFZTm5yS2pWYlBKOUdMQXNEZUN4YTJ5MWNtS3daS0FwUzJ0?=
 =?utf-8?B?NmlkTVVZTkVVOEVWamhVUmZzQVp0SVlzZUswWWswU25xcHM2dEd6bjJsSU9m?=
 =?utf-8?B?QzlPNlo3ME5lWlZXSXY1TWV1TVZ6RmhCN1cxVnZVdzMyK0d1UXNRY2FXNUsw?=
 =?utf-8?B?eUt5U3lnbTZXRi9HVEYxK3J4MEFoZnJVUXN0V3htUXFBd3hwb095aU5wVWVB?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65258433-227f-45c3-d0e9-08dcde9675e4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 01:48:18.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqhtLHPWkjRm7KIil49wfhyIzWYvn4KAfh5/SeRH/X5oTe9h00EUBv8Js78uEZwacvZ2XQIsYs0m5PEBGVn1V5uPfY3Gd3VVKVy+9B1+KyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-OriginatorOrg: intel.com

Hi Babu,

On 9/26/24 9:59 AM, Moger, Babu wrote:
> On 9/26/24 11:46, Reinette Chatre wrote:
>> On 9/26/24 9:28 AM, Moger, Babu wrote:
>>> On 9/19/24 12:20, Reinette Chatre wrote:
>>>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> index 7ad653b4e768..1d45120ff2b5 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>> @@ -864,6 +864,13 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>>>>  	return ret;
>>>>>  }
>>>>>  
>>>>> +/*
>>>>> + * Get the counter index for the assignable counter
>>>>> + * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>>>>> + * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>>>>> + */
>>>>> +#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>>>>> +
>>>>>  static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>>>>  					 struct seq_file *s, void *v)
>>>>>  {
>>>>> @@ -1898,6 +1905,45 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> +/*
>>>>> + * Assign a hardware counter to the group.
>>>>> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
>>>>> + * else the counter will be allocated to specific domain.
>>>>> + */
>>>>> +int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>>>> +			 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>>>>
>>>> Could we please review the naming of function as this series progresses? Using such a generic
>>>> name for this specific function seems to result in its callers later in series having even more
>>>> generic names that are hard to decipher. For example, later (very generic) "rdtgroup_assign_grp()"
>>>> calls this function and I find rdtgroup_assign_grp() to be very vague making the code more difficult
>>>> to follow. For example, rdtgroup_assign_cntr() could be rdtgroup_assign_cntr_event() and
>>>> rdtgroup_assign_grp() could instead be rdtgroup_assign_cntr()?  Please feel free to improve.
>>>
>>> Sure.
>>>
>>> How about rdtgroup_assign_cntr_event() and rdtgroup_assign_cntr_grp() ?
>>>
>>> Added grp extension for the second one.
>>
>> Is the "grp" extension needed? The function already has "rdtgroup_" as prefix so
>> the "grp" extension does not seem necessary to me since I think "rdtgroup_" and "grp"
>> intend to refer to the same?
> 
> How about rdtgroup_assign_cntrs() ?  Added 's' in the end.
> 
> We are assigning multiple counters here.
> 

rdtgroup_assign_cntrs() sounds good to me.

Thank you

Reinette


