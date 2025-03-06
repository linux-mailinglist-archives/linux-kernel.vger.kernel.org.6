Return-Path: <linux-kernel+bounces-548249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EC0A54252
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BF8168D7F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745F819E99A;
	Thu,  6 Mar 2025 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nhv0Vhvi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C3B367
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239532; cv=fail; b=XZJGnbGJTdsfJKZk0zzhvnwgyfQxT9FeNRU/V/WCbdL5/a04GwV5HNcu9pWvlh8GxsJ+hrU42K0LuzAzSeGu7U3bwquQBJ45UlCkKBkpsjoZXjYYlxjwg6A6qpELTesvoB5GRSFvH2Ez4AxKQskqVFRkW9akGNO79DKatsg0FEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239532; c=relaxed/simple;
	bh=JZzkPN25MpQTnIMxG5RVsQPl3GxsZLJtqPPZD5DoHXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VnA+ScErVvCwCCID44sFa21jWFO1zLxDO1Mv6ETyD8QIEGT3qV1oNhHkp0cfujJtaYBNW6t6o+V4JMvAfcnh4otzfC0ZM9x2l2mjj0+egLu+V97nzVk3s26lh4fRTAccQT0GRwfZ981nN5pcfqDV8xHeHtt7m2a1iVL5eT3hx5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nhv0Vhvi; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741239531; x=1772775531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JZzkPN25MpQTnIMxG5RVsQPl3GxsZLJtqPPZD5DoHXk=;
  b=Nhv0VhviFCEZxAFP0Lx71kmekZqZ8692jWpyuIRZIKSU6TW45C3JQKA7
   q7fSnEdHX4IlHz2MjulIV6KYSe42HiQ2x22YUvlcA68QpUMcV9u/Wk4bj
   drBPa9JPhE8yTNcjntLNrP1YBFjaMNNKKKTkYnw1aOmEsAMkWh6hw1ic0
   kqyNeN3UhIc3DAHR92s/CMcnDZ8fUnYbkzqe2By6nLD5iHdbk0J6mL6D4
   FpxeCGtAJfKrofIeA6LPAFdO9W5H8BzbZvz0qjZ+EKpT9dB/Ip8NRMAqU
   mq8TSG6GKk0DSiF71h0QbEHDrih/hiHzPaWNo9D5Zbb8h9dFF7ZOf8CW2
   w==;
X-CSE-ConnectionGUID: 3h/d6vHIQEu9m33NJkmxZQ==
X-CSE-MsgGUID: 5NdE+zHtRUG8D/3FD+iAzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41942766"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41942766"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 21:38:50 -0800
X-CSE-ConnectionGUID: vK4M1/XMRxqwGR0iGOeB7w==
X-CSE-MsgGUID: gOaEYl77TVCHrEyJMWLYwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118921269"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 21:38:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 21:38:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 21:38:49 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 21:38:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwRciNFsftspriUe8oGJnxgdjH4v4Q3EMwesyTHwlSdHLcFfoa0wtjQ/tMVXSRusi3n4aCg2RR7yBn+80SZWAzI2QmDtpVLPkesAne/HKyG6tt99NNfcrelSCB+EA9coDMHgcfETz3YkLXxL2mXcN8spqnQKxJ5jpqzTVX4VyWoryabWFGDWe6zxdYOs7cLAsrIV51hkezcQgRX6hHX7FkmQz2wPP1BrjNcUG7XnrsKUUUMjR8/4otuM8Cs7piqm9Y6ksAhfqdag0LPstDJAPPaxCZI0qVLM3czVMt4BNWOn1ANOrGwdNLmdisuL8lRBqv4NOdLn4gKPwLn6KHYtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZzkPN25MpQTnIMxG5RVsQPl3GxsZLJtqPPZD5DoHXk=;
 b=zQFJccxt7NLiN/8fSg8gmlYgWRXjv1pG1W7b5mwj3pRS/3Y0dU69NMHP4T8TJwqj8iNci8abx4A3Wq988UL28n7YQRA2dz73+HV1GqECXWtvDNsX81ei4K/wTEy0kf9HvgYYKcuyn/aKr4flhPAn95Z3ElfFMMVguOiTVdBtqHKDvLztZANREURD0u+uMzT1ldfxKHugiXVUc++/Sq807iqlQppYFAfXKnwvYqZ2hofkFormdAZ7CyKZADsYU1L9DTsmdHqmYMJBTRMztNWBN8CIIU+WNXSbWJrtVg36C84s1x9pOF6vjWEzd79TgA80GMAZrFT9ATKF5+NKNLpslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 05:38:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 05:38:47 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>
CC: "arnd@kernel.org" <arnd@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "mingo@kernel.org" <mingo@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Thread-Topic: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Thread-Index: AQHbjROU+KTTv4p5SkKt4bGW4yTWkLNkXQMAgADBdwCAAAEUAIAABsuAgAABnYCAAHHsAA==
Date: Thu, 6 Mar 2025 05:38:47 +0000
Message-ID: <9a8eeb99abeb7a3f670f1701839ec5659dea33a5.camel@intel.com>
References: <20250304143340.928503-1-arnd@kernel.org>
	 <Z8grEnsAcMrm9sCc@gmail.com>
	 <20250305221700.GPZ8jNXPCFR1w1NyEQ@fat_crate.local>
	 <20250305222052.GAZ8jORCVmKQhEkrw6@fat_crate.local>
	 <a6145d2a-e1a9-41b4-8017-5bbf37ec2d65@app.fastmail.com>
	 <20250305225057.GBZ8jVUXJmIJBZwdgT@fat_crate.local>
In-Reply-To: <20250305225057.GBZ8jVUXJmIJBZwdgT@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS7PR11MB5966:EE_
x-ms-office365-filtering-correlation-id: 38d3c14e-6d6d-4175-f86f-08dd5c712ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTBQclcwTHJDQTZsck1xd0lZbklyQTVIVGszbDNOaTNmTmtVL1RXaVdtSzl2?=
 =?utf-8?B?UkU3MFRyWWw1bXFURUs5aVJQb2ZFMjlUbFZTcTdHdnFVWjhoU2c0Um1RVzVv?=
 =?utf-8?B?aGJyZTRvUVZNQXJrR1dxSWlvL3lQVGNieTNSMTA3Vzk3TXZlcEZUVDUxL3Rs?=
 =?utf-8?B?cmhqcHBQRWZBNjFOSFJKUTNuS21ZTG9DQ0ZVeS9uWHk2RC90RG5uTnRIWHNa?=
 =?utf-8?B?YjJ4SGJpeVFIakpESUVCUWVzZjVWRkdiQmoxOXo1OTJINGdvTWNVVU9KenRS?=
 =?utf-8?B?LytDWGlqc0NPRWg4Qy9ranpwNzZsTndkeVE2RVVkaDN4dzdvV3pGZEpSQnlz?=
 =?utf-8?B?MnJPQS9mWmtiMnBIVjcwbWdNQStiOFpXWW1qbjU5SlM4QjRjem1lVEVZTmpj?=
 =?utf-8?B?MjdNUzZaR3Q4bTNKWStVTEZ4WDFnWDh0Z0tKYUoveEYzcVJ1Vm92Ty93dVdB?=
 =?utf-8?B?SGJ2d1dSQ2dkaTlGTEVuekM5dTFTeGs0MXB6aE03dmlGZi90Umd1bklHdWIx?=
 =?utf-8?B?WmF6MXg2WmtVYUc1M0RJRXpFWi9TaHZIMU4zWlBMZk5FNHV4cGgvVnZzdGkz?=
 =?utf-8?B?YmZCbzNEQWpka25JelhreElERXQzVGQzRUNTaDdqbmEzMFpER3BYVXEyV2Jx?=
 =?utf-8?B?ZGJQVU4veXd6cmZpSFNOSjAwbjNlWFVKeHVTV3BtTjFHWjA5SGtkZE16bVNi?=
 =?utf-8?B?dytiKzRZY2M3QzNtNXRDZUhUSkRHL3BZcmZDZFYzQmhSSXBnOU8yYURPYkt3?=
 =?utf-8?B?dzVpVUF6eFFZSG50ZTBia3dCVTZSMW9GaExsK05xWExKUkN4YlNlaHVhQWNF?=
 =?utf-8?B?YXkyTEpZVXZYVEl0bFZoRWVjRXFrRUNKSDVpTTR2TWpFdUE0bkg1QXVMS3E3?=
 =?utf-8?B?V0JjQVN3SlpZTXkyd0tpOEh4Z1pzSXY2RnU2UGhSVWZkMzhQdE9laUhlcGwy?=
 =?utf-8?B?UzlzUndBeElnSkc2T3hXYUVNZkE0MjdBbkNNWkxsZ1lKZ3Z6dGd1NkRSbk1L?=
 =?utf-8?B?UW12cGI5V0k5eUJ4OXZLQ0doTW9GcXpTYUJ6SE9QZTgxSTNuWHdFYlRXK0Np?=
 =?utf-8?B?UitLTWV6QlBlQUhJRU5xQ0VGV2NQNVdIR2IyMzEySzR1SWJxSE1ONmRDcnZq?=
 =?utf-8?B?WnQ3Rll1aEdvUmp2dGdIeHVndmdEVUwreWV0U0R5UkhYQWY2RTBQSWl2UEtH?=
 =?utf-8?B?cVJ3VjJYdXlES1FpNzJNczRJOGp2L0RYSkZKOGdaRkdrL0ZJeFE4SVRnUFdk?=
 =?utf-8?B?WjRRWklaR1UxYVR5ZFNRNHVQKytvSmNKTUU1VzdlOEx1L25RZjJBY3J1NU1C?=
 =?utf-8?B?RjV3RGFGMFVHd2FDYlVhVVNEU0xOQ1ZZcStIWDdscDRtbTZtVkpPVExEdTR3?=
 =?utf-8?B?MzV5aFZRcjMyZ3pNKzNINTJDK1ZOczgwMFQxTldaRnVkWVN5RHlUSUgrTm9t?=
 =?utf-8?B?N3RRLzM3MXlyU1kyZGxZRC9EM2VnUThlNlpObk5HQjRvbzFrYlBqV2l1SmF6?=
 =?utf-8?B?STVrMlViNS9GTlBQajBxb20yWDNGWmNaNTZZTDR5Nm1xQy9xS0h5YWxWdGFQ?=
 =?utf-8?B?L2FoVzk4RWlROG9tZGVmNE9Wc2xjcnViRWU1MlVIMi9ZUHM4ci92bU5RL3Zo?=
 =?utf-8?B?OHZSSkRsSkdydm5veFMvY1VOVit0Sm00ZXpSM1ZUL3lIM0RUZzBRK0xVQ2RS?=
 =?utf-8?B?L2V3YXZJR3NucjVnUTlKc2JOVHhxRnI5aURjTEdxN0hyRC9xOUo0bUhCRExX?=
 =?utf-8?B?ZUNrL1doV2NsYXAxZ2VIeS9tTnhzdFBlbGtXRTVkQjdlU1JtQnNXU0NIYmhy?=
 =?utf-8?B?Wm5sbVZNS21RM044QVNLcWF3eGVxK3ZONnp6OThmeExYZU5lWFIwOFY4T0lw?=
 =?utf-8?B?TVRVYncwK1YrUm9Ic1B3VnZyOG9CL0lJQ1I0MXUvUGtBL09ZSEVERk51WXZB?=
 =?utf-8?Q?EXRb/tVTsZKs6EJlc3p0d6SAPVNuO3vb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGQ2YnMxa1R5bzZNZXZWb1NRZmRkbWdaeTQzVzNLb1lMcU9Kd0NENmp3NjM4?=
 =?utf-8?B?cm5seWdFTk52Snc2bzdMZTlSY2R6TkgyYkltQ3pSakRzdVdXZ2FleGNFSGNi?=
 =?utf-8?B?NHQ1VTVGaFMramUyR2lYRC9jSFRMd3gyTE1CaExVdFBYRFVVeTY3djdIV0k3?=
 =?utf-8?B?dnFGaHhOMVpiUkdjY21xVUNMS25iN2M4MmlhSnF2dlVZdmxSZEl3a2tYUUIy?=
 =?utf-8?B?RG5iTGlpWDFJMzhjNWR5WG9vTnVscTU3aVVNa0dwMnMxWHVzRDdVNlMvcXFO?=
 =?utf-8?B?N2t0R0t2Q2kwMHZHM2RMY1pEQ1Y1N3dWYUtvMEJ6YVp0WnJnajdnQlZlbFIr?=
 =?utf-8?B?Tk56UFI5QWFhY0ZBbUNXY0hxa3N4SkVvRFZGdy9tdDUrUDVPSWc3Ym02VEZ4?=
 =?utf-8?B?TG9aSjdUTVluUFBHTjhULzBKU08yRVRtS21BSFZ5cklmSDJndUxlMUhBdTU0?=
 =?utf-8?B?Y0MvY3NxMGNUK0NXNis0VElQNys1QzUvUFJ6T08yeCtRT0pZVEtKLytVR1BO?=
 =?utf-8?B?VHE4K05OODlmU3VrVlV0TEdqRUY5UzJrYmFTWDN2T3BjdWFCRXBPZENmOHZB?=
 =?utf-8?B?SSt2MjE1ZUxvNW9qVEt4NTU3UTFCeU1HZE0vQm45SURsSXZpdEY5TlZyZjN6?=
 =?utf-8?B?ekpRT1hXK01IK205TlIzbGF2UWtuVkliN1phdlNPOG1kNGVVSXhOUUttTUxE?=
 =?utf-8?B?N1NHbjhtNzdHczNpT0cwZXJlT0xVaEdhZHlRMmJydm9obUpEbUp2a1dXelYy?=
 =?utf-8?B?d3hFQngzZ044TVFyV1BqWkdHdWFtZkVSL1d0MlBRZFFpSUVCeCs1bmRPdW1w?=
 =?utf-8?B?UG8rRmJqZ01yeXdKKzNoUFZEUHNiV2VHQ0RicHVYbjhWOUJEWWpHbUNqb2c3?=
 =?utf-8?B?a0MvZ2NBZXg2cGFJOTBrLzBDRjZpckp3aGczU0doeG5GMlptbHNsc3VGdjVS?=
 =?utf-8?B?aGJ1MDZIbWdkM3lQSVFjM2h5eDFJbmVsZHl6djhzenZZUVAwenBJcnZKS2dF?=
 =?utf-8?B?Qm52cmxKaXladlNabVhmUjBsYVZqUUFPeUdLaUxFbGMvNng1bFF3QjNSWUx2?=
 =?utf-8?B?N1hqUVVMT0lINUk0VTlsZTY1dzM5b1RmV0xsbUlWcHA5TXJ1a3F3RFBXQUNR?=
 =?utf-8?B?NU9rUEhOTmNTWG5YcmJDSURHaUlaVlh4RUZkRjM2S21ENGZHdnphOEY4bnlr?=
 =?utf-8?B?d3lJRExpd085SW1NemcxZGUvcXprK3F1Q2tjekptcGpEZ2tHakRMOG41ekdO?=
 =?utf-8?B?aDgwMkY0TmxHVmJleDZFeWwrVDBPTkpxRTdLVmRmUVhWMVkraTVES2NCVzFX?=
 =?utf-8?B?Nzc5YlA5UURZSStzTE9hcnllWkxEOGZsOE5XZnh5ZFdkdVJpeVRBWlNSYS90?=
 =?utf-8?B?YWdCcnU3d3RyUXdDTWZhaWM1ZlV2UHBhYUV3V3hzQkt2aGZXVTA5bURKem9U?=
 =?utf-8?B?ZmxvbmVNdGhMQ3BTelFUbXNsLzdKVFg4dlJJRWRRZHZoRjRpTG8rNDNLblkw?=
 =?utf-8?B?Nlc4V3BSYkl3eUQ3ZW1yMyt3NWg3Q0hqSXA4QXhDQ0Rib042eXByL3FMT2hj?=
 =?utf-8?B?cUFkaUgxZkZCS2E2NkZvWTNOSDNvc1Y1a2YwTmtWOTBOaDZGTmtvdjY5bEMy?=
 =?utf-8?B?SlBUTlpUWU5DNllyNUt5czB4OTlRbXEvQXlHcFYvZytYVTdSYlQxajJQbktq?=
 =?utf-8?B?bUt5bVVlamg3djRDZEZGZDkyQ0xMUTd0Nyt4eWhaVER0YTIyZTF4THkzTXNC?=
 =?utf-8?B?LzV6ZlJVMzE1WlNUU1grUG5MT09jWDM4NUhuZHppaEQ1QmYyazVnWnRWT3dF?=
 =?utf-8?B?THFKbi9NU3doK2lNaWVnNkVqb09WdHhYbTNnbkpFRzFxWlc0MWsrbURrN2cv?=
 =?utf-8?B?VWR4T2hjdVVIU3NhUXN3YmVUaVRNRWJVeHpaRXY2WUU0WkNCZ2RWSFY1WDZM?=
 =?utf-8?B?TU9qcVo0WmdDTEl0emhpRFNJa0hRTUlObEsyTnZ3NytrNjN5K0lkaDM3NXZp?=
 =?utf-8?B?TE5vajZYaTFFNFc4QTdWaHp4Z3BhdUVvcTVZa2pNcW5jVVR6YlVKM2tVWXRC?=
 =?utf-8?B?ODFaMVVQQ0kwMjc4cWxuaHljWCtsbUQvcTdQNUFUdTdPNTVGQ2ZvMzVmUXJ0?=
 =?utf-8?Q?qVxjPWwgxn7UOIwH/tQzJUYRn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2F3B13A03030B41A20649BAA98B3000@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d3c14e-6d6d-4175-f86f-08dd5c712ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 05:38:47.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXp4kas3jZrGxfDhu6d0xAeWbapZsLzEbOG/bQcUqGSUMchMvAu5VKAwS395ZbgvT3/573dXffpHBwekHPwOzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5966
X-OriginatorOrg: intel.com

DQo+IA0KPiA+IHdhcm4gYWJvdXQgdGhlbSBhdCBhbGwgdW5sZXNzIGl0J3MgZXhwbGljdGx5IGVu
YWJsZWQsIGFuZCB0aGVuDQo+ID4gaXQgd2FybnMgYWJvdXQgYm90aCBvZiB0aGVtLiBOZXdlciBn
Y2MgdmVyc2lvbnMgaGF2ZSBhIGRpc3RpbmN0DQo+ID4gLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9
MSBmb3IgdGhlIGNsYW5nIGJlaGF2aW9yIGFuZA0KPiA+IC1XdW51c2VkLWNvbnN0LXZhcmlhYmxl
PTIgdGhhdCB3YXJucyBmb3IgYm90aCwgc28gd2UgY291bGQNCj4gPiByZWFzb25hYmx5IGRlY2lk
ZSB0byBlbmFibGUgdGhlID0xIHZlcnNpb24gYnkgZGVmYXVsdCBhbmQNCj4gPiBsZWF2ZSB0aGUg
PTIgdmVyc2lvbiBmb3IgVz0yLg0KPiA+IA0KPiA+IE9uIHRoZSBvdGhlciBoYW5kLCBtb3N0IG9m
IHRoZSB1c2VycyBvZiAnc3RhdGljIGNvbnN0JyB2YXJpYWJsZXMNCj4gPiBpbiBoZWFkZXJzIGFy
ZSByYXRoZXIgZHVtYiBhbmQgc2hvdWxkIGp1c3QgYmUgbW92ZWQgaW50byB0aGUNCj4gPiBmaWxl
IHRoYXQgdXNlcyB0aGVtLCBvciB0aGV5IGNhbiBiZSByZXBsYWNlZCB3aXRoIGEgI2RlZmluZQ0K
PiA+IG9yIGFuIGVudW0uDQo+ID4gDQo+ID4gSW4gdGhpcyBjYXNlLCB0aGUgb25seSB1c2VyIGlz
IGEgbWFjcm86DQo+ID4gI2RlZmluZSBfUEFHRV9DQyAgICAgICAgICAgICAgIChfQVQocHRldmFs
X3QsIGNjX21hc2spKQ0KPiA+IA0KPiA+IHNvIG1heWJlICcjZGVmaW5lIGNjX21hc2sgMCcgd291
bGQgYmUgYXBwcm9wcmlhdGUuDQo+IA0KPiBTb3VuZHMgYSBsb3QgYmV0dGVyIHRvIG1lLg0KPiAN
Cg0KSSBhY3R1YWxseSB0cmllZCB0aGlzIHdpdGggQ09ORklHX0FSQ0hfSEFTX0NDX1BMQVRGT1JN
IG9mZiB5ZXN0ZXJkYXkgYnV0IGdvdA0KYmVsb3cgZXJyb3I6DQoNCiQgbWFrZSAtaiQobnByb2Mp
DQpta2RpciAtcCAvd29yay9lbmFibGluZy9zcmMvbGludXgvdG9vbHMvb2JqdG9vbCAmJiBtYWtl
DQpPPS93b3JrL2VuYWJsaW5nL3NyYy9saW51eCBzdWJkaXI9dG9vbHMvb2JqdG9vbCAtLW5vLXBy
aW50LWRpcmVjdG9yeSAtQyBvYmp0b29sIA0KICBDQUxMICAgIHNjcmlwdHMvY2hlY2tzeXNjYWxs
cy5zaA0KICBJTlNUQUxMIGxpYnN1YmNtZF9oZWFkZXJzDQogIENDICAgICAgZHJpdmVycy9jaGFy
L3RwbS90cG0yLWNtZC5vDQogIENDICAgICAgZHJpdmVycy9jaGFyL3RwbS90cG1ybS1kZXYubw0K
ICBDQyAgICAgIGRyaXZlcnMvY2hhci90cG0vdHBtMi1zcGFjZS5vDQogIENDICAgICAgZHJpdmVy
cy9jaGFyL3RwbS90cG0tc3lzZnMubw0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vYXJjaC94ODYv
aW5jbHVkZS9hc20vcGd0YWJsZS5oOjIzLA0KICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC94
ODYvaW5jbHVkZS9hc20vdGxiZmx1c2guaDoxNiwNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaDoxNywNCiAgICAgICAgICAgICAgICAgZnJvbSAu
L2luY2x1ZGUvbGludXgvdWFjY2Vzcy5oOjEyLA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5j
bHVkZS9saW51eC9zY2hlZC90YXNrLmg6MTMsDQogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNs
dWRlL2xpbnV4L3NjaGVkL3NpZ25hbC5oOjksDQogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNs
dWRlL2xpbnV4L3JjdXdhaXQuaDo2LA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9s
aW51eC9wZXJjcHUtcndzZW0uaDo3LA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9s
aW51eC9mcy5oOjMzLA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC90cG0u
aDoyMywNCiAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2NoYXIvdHBtL3RwbS5oOjI3LA0K
ICAgICAgICAgICAgICAgICBmcm9tIGRyaXZlcnMvY2hhci90cG0vdHBtMi1jbWQuYzoxNDoNCmRy
aXZlcnMvY2hhci90cG0vdHBtMi1jbWQuYzogSW4gZnVuY3Rpb24g4oCYdHBtMl9maW5kX2Nj4oCZ
Og0KLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jb2NvLmg6Mjg6MTc6IGVycm9yOiBleHBlY3RlZCBp
ZGVudGlmaWVyIG9yIOKAmCjigJkgYmVmb3JlDQpudW1lcmljIGNvbnN0YW50DQogICAyOCB8ICNk
ZWZpbmUgY2NfbWFzayAwDQogICAgICB8ICAgICAgICAgICAgICAgICBeDQpkcml2ZXJzL2NoYXIv
dHBtL3RwbTItY21kLmM6ODEzOjEzOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYY2Nf
bWFza+KAmQ0KICA4MTMgfCAgICAgICAgIHUzMiBjY19tYXNrOw0KICAgICAgfCAgICAgICAgICAg
ICBefn5+fn5+DQpkcml2ZXJzL2NoYXIvdHBtL3RwbTItY21kLmM6ODE2OjE3OiBlcnJvcjogbHZh
bHVlIHJlcXVpcmVkIGFzIGxlZnQgb3BlcmFuZCBvZg0KYXNzaWdubWVudA0KICA4MTYgfCAgICAg
ICAgIGNjX21hc2sgPSAxIDw8IFRQTTJfQ0NfQVRUUl9WRU5ET1IgfCBHRU5NQVNLKDE1LCAwKTsN
CiAgICAgIHwgICAgICAgICAgICAgICAgIF4NCg0KDQpSZW5hbWUgdGhlIGxvY2FsIHZhcmlhYmxl
ICdjY19tYXNrJyBpbiBkcml2ZXJzL2NoYXIvdHBtL3RwbTItY21kLmMgZml4IHRoZQ0KYnVpbGQs
IGJ1dCBJIHRoaW5rIHRoZSByZWFsIGlzc3VlIGlzIHRoZSAnY2NfbWFzaycgaW4gYXNtL2NvY28u
aCBpcyB0b28gY29tbW9uDQp0byBiZSBhIGdsb2JhbCB2aXNpYmxlIHZhcmlhYmxlL21hY3JvLg0K
DQo=

