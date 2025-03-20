Return-Path: <linux-kernel+bounces-569836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF203A6A850
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33C9188ACD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0575223311;
	Thu, 20 Mar 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYqvKH2U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985A223706
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479983; cv=fail; b=l5SnuxUmKPkFIULjr97BwEslcuuiyCvzYSU+SvQOuFXp6NLt+/DrEElYezlTrgv3JdVhQfdoka1/iqsfe0cuhObrjagVj87+2xzCxrEABwrjPq4rmVdhQOnamhrWoz6SSsgY6fb3NcSyPj/kAvKBChQgl9G+lmXOl52iZw2faw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479983; c=relaxed/simple;
	bh=UqEiqS+XrE3mEyXBWIC9BDFLZMqB1U//494dQG/PjNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dUikHj3mVrDBuXEs6Feg/or467N6a4FazmIraJkQwJDp0CzKnpyU53kOD/EJ7JT2gUkiGjKxnRJFEoLYu6+O3xFoZGfUBjsIpT9DALxbuQEA6sRJWuqLPAbfTPucfaZqwux1TAocwYPG/D1PTO2GPlIRzAjQns7A32oV92IsHps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYqvKH2U; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742479981; x=1774015981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UqEiqS+XrE3mEyXBWIC9BDFLZMqB1U//494dQG/PjNo=;
  b=EYqvKH2UBi+VOGM8jS/3vDUfkVQw7+uR2WMarqavxs1RkwryR7JDr8Ec
   xg1S4j084ASJZzWbQjxldyS/OquVcNoYMZQhCQb2RbKeMioKhPHjtDn5/
   5jbUjb1RSUkWeqyy4kh9UokGvLXN6eMyWICRDb2msTTnn5Ab7s4HaxgJy
   UKmbAhUTWNkZJuOSA3ocuOFgNsDTbTAeZ8aHZSRt4INIPq4/0nNZGNR+y
   IPTcvG1ZFyvazE7H3/dzxCUN3qcxc93V/75V1CET0/DELEAskJ15EwOAW
   YJtoOlJx5glEuH4bJbg/xsktXTdldY9n+3kdo6yTs0XFiuWIi6SWVKvf/
   A==;
X-CSE-ConnectionGUID: AKS5VG+jTOi7S2JS+48QBA==
X-CSE-MsgGUID: HO/bna7hRIq3OUAyetBieA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54376116"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="54376116"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:13:01 -0700
X-CSE-ConnectionGUID: Aebn/EPhTLqe80WHvO293w==
X-CSE-MsgGUID: jSQEzHzESF+Qveb3p7mliQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="123563788"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 07:13:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 07:12:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 07:12:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 07:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBQEPQV2x8I9DknbWfAXEEgJP4hN14QLVEe9kinGdwxoJrHDJmOndqfY96geDjXZZno+bFy0LvWEgh7oBF7ez3M6Iw+giJbMRh8QLqyvVIzChRrrymvObNG1IzyNMD9J+Wi/kxp0JnIE4KmXpPC/vKY4X7K+ek7CBy4ZM5akUfvXLF0T2hNT3atPsJUk2pmFacUlLSqSoeI0Vg6iAGEoujck2HzbdevSZGD74qeoEoQgOhv0fHlIKVumXwDWJccfbibJnqX0VoIiD/i3MpMV26l6ZWvxJsr9HO6Op1PYB6BSfHGkU3ADMqbE35+ZhcGmy5N+KX66LZIQNwKgoiKhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqEiqS+XrE3mEyXBWIC9BDFLZMqB1U//494dQG/PjNo=;
 b=iojuUXXn7mT27hjDOdpNf24XBM2ZmF6m2WEYUo/5JGjHTggFXyTQveR52Ya0TxxnN8Hx+nh7lcnOXxk1pcyRGQzkqm9FVuSLZX4uGRaunLsOto1K02cLghpS7dt1rsiVzw6voPWPYhhVYh7wz4FxY7/P3rAwOtwta3y/WQBk1I2QE+rCWJ8daEV+tL0Lo3JSS4OSWSPDx+kKi8PuyWkiaRrzcS+iHNSpAxbYdTG+hNTaIYVFy7XbUAsykNyHA8wTbPtlwUQWyz7rBSsZD9cANgjr2HuON6n8SWqQfqJSmbu17HOwu7blLTpPItk5258lzkIyFzo1tdpoZTZWqZX+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DS0PR11MB8763.namprd11.prod.outlook.com (2603:10b6:8:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:12:57 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:12:56 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Hans de Goede <hdegoede@redhat.com>, Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH 1/2] mei: vsc: Fix fortify-panic caused by invalid
 counted_by() use
Thread-Topic: [PATCH 1/2] mei: vsc: Fix fortify-panic caused by invalid
 counted_by() use
Thread-Index: AQHbmA/N76/OlLE7oUa3lNJxTd/fxLN8E6Aw
Date: Thu, 20 Mar 2025 14:12:56 +0000
Message-ID: <CY5PR11MB6366399C3451FDAB0A8A5A40EDD82@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20250318141203.94342-1-hdegoede@redhat.com>
 <20250318141203.94342-2-hdegoede@redhat.com>
In-Reply-To: <20250318141203.94342-2-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|DS0PR11MB8763:EE_
x-ms-office365-filtering-correlation-id: 8c04e07d-4cb4-4305-9b07-08dd67b9503d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWJjVTlBaDZWL2k0QjZYNEc1MHNNZnVxaHBwQUE5MDVjaWtERmJhU1lNY3Zj?=
 =?utf-8?B?ejhnUUM1dWZRK05mMW9kSXE4dnJvZ09BUDZpMUpmeGtTN2FxV09COXljM2Fl?=
 =?utf-8?B?UWtIUUZ4YXlhUXQ4VGZ0aXRsUm9uQ1VYMFJ1UlN3WE1GY3g4ZTlUeDZ3S2kv?=
 =?utf-8?B?anZmbkEwODd6dVlmdkNlMUJrbWpYNmdTbk8yWWlpb2UxckxCWWZaRW03dENW?=
 =?utf-8?B?SExMelRsL3VYRytnYXNMYVFmZFAwTDhkUjV1ZjludHduTVNSS2gzOTU5d0Jx?=
 =?utf-8?B?UjlvMWxUaThxWEJDcEpDZWVNeHZleFNEN2M4MC9SNUN2bEJReTZjUUtTK2hK?=
 =?utf-8?B?NElXaWsrS3VuM0VlSmNkRUR3ajQ2Wnp3M05VY016SU9neHl5L3hKcjNMR0dl?=
 =?utf-8?B?WWRFS0g4azhxNHphYTNFWVJJbDY1dVduYXJXeHJOcW1ibGRVU3pCS1p6eTNp?=
 =?utf-8?B?Y3VGZmZtTnRFbWdQME15eUp6OGZXNksyZk9tbjY4Y3NGVmZEcUNzNXVYRHRn?=
 =?utf-8?B?K0ZseEtqbW1nZ2lGUWdiVlZWVm1tQitkR2JTekpWY2MvWGlhMnFqZjQyZFZO?=
 =?utf-8?B?aGd2bnZ3OFQwZjA3NVpxbmhxUVRqeHRTNkR0eDc1MElqZjd2dDJza1ZaSkhH?=
 =?utf-8?B?ck96TThtQ09jalNsbldhQlBzMnY1bDB5TGNNOGJQZkwvMVBodU5Ta2MwOHNv?=
 =?utf-8?B?VDBlT1c3UVFPYkRESzkvTkpwNXVDNU4wdjV6RGhrZmRIUTNoNzhrRkZIWHcx?=
 =?utf-8?B?dDJrRVJQU3dRVCt2L25rY1FRSHRrM040OGdkY2taV094M0p6NWFtanBoRzZh?=
 =?utf-8?B?a3YrNHVwaVl0d3hsbHB4QUMzczk5YVd2Z0RDRWVVbFRpa1BYbFlZNXdmTzAv?=
 =?utf-8?B?UUl6T2NXOGdaQVdaWUdwVEpyVHFjZVIwaDdFUUNITisxNXQwQWxFd0M0Y2Vi?=
 =?utf-8?B?L0E0WDR0eFF1cWdiSG1CZlp6V1U3WGkvaDI4YncvUnhmY1lRMFk2RDNHaGdx?=
 =?utf-8?B?dExaV0t1eGRRdzQ3ZEhvRURXU3BkUEhyYzRaT01xOURKTjh0V3h5bmJGM3pE?=
 =?utf-8?B?dkQ3L1ArV3E0WXFvS3VZQjdYVVpKVVJueWJuOEtUTG1mdGlaRjdrNXpCOHBD?=
 =?utf-8?B?emF4TXordzZaUXhRdVdDRHpNdXJlcVlYQTFVQms3ZU0zSCsxWFB5UXVZOGlv?=
 =?utf-8?B?RW5VT0xTM25yWTlIeHdjcy9HT2I2THRlaWI0dWFYVUc0cUNTQ09Fc1pWVnFT?=
 =?utf-8?B?U0NkSFZUUHlqWVN1OWFyMW9jc1ZpWFgwUjFPNkxXM29pMDBZY2E3SVVKWDMv?=
 =?utf-8?B?SzFuY3p4Y3pGZUhXOWlTTDl2cW53N3ppUXpoeUlORmU3YzREWThXZkk1all2?=
 =?utf-8?B?UmdYMkRkaUR6UUxQcFc1KzgzKzBHWkc3V29BZ2ZDMUNMbzYwUmNlYldWdlRM?=
 =?utf-8?B?c2t4YjBWdDVhZGJEdkNLelZueDBKT3NFdjc5UU5TQ1ZRbUlVcXN2UmFFVEdM?=
 =?utf-8?B?NGdaQ3pPcFdNd1pSM1FodjBTcnRrNzBsb0JGVDdmbHV5NGF0ZUVUTkJTbzBt?=
 =?utf-8?B?RVFzd3dud3h6Vnl6WlhvUDR2WURCd0U4VTNNTjhqbGIwWVo0ZEtKOGZ4eEdI?=
 =?utf-8?B?OGdUMmxXSHpyVVB1N2phZWZGQmtJM1R1N3E3OXRrdkZMc0lCL0FzVHp1US81?=
 =?utf-8?B?RU43cVVXMW5waGdRS2hxR3BJSHNiNGF3RHp5VW1qN2dHaG96VmM5UmkvSjZM?=
 =?utf-8?B?UlN3OTBhUFJjTFRkeUhuMHhnR1Zvc1ZNSS9lc1FqSy9IR0RnS01TQWFjNFQ2?=
 =?utf-8?B?eXVJemZBeTRvM29pN04xL0FZWUF1RUptbTFXZFo4eXhjYWJVM2pNbkJZbHhM?=
 =?utf-8?B?YnBGRXpEVCtodHErbWZNY05XL3Z2TjU1TWxzdWdmWVdnN2tIbTdZMWhlMHdL?=
 =?utf-8?Q?Pl3czwJSW4rNoHWUzHMKniKDw/JEsKf9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUswYThqYWdjN29vTVErZVhWbEFzVnVhTFk3bUFMOWpoVnlDcmk4elNXT3FN?=
 =?utf-8?B?VXFPc2Zhb0xEUlRWVWVVQjhVTjRNZmFsQmNWVXJvL2NqRzJQK0NpMnRPUUUx?=
 =?utf-8?B?cmk5N0txWDMzQWJRVW5YSEhSZjRmQ2ZXNzNwSGZINmlDamEyQVJleUt2YjNY?=
 =?utf-8?B?b1dHZW1SRnhZdDhLQXp2VlNxYXlkaktyWnJ2R1dQbFloS0JpRUZ4b21vR1Bj?=
 =?utf-8?B?dWdmSVQ0Tm9hcjNhWXhHSUFQd2VQZXBSRnRDenFBYlFZUFRwRExyWmdNN1dr?=
 =?utf-8?B?UDdna0lVTjJYZG9BcWFHQ2VlTEFuY2xoV1REdFNpN3FWeHpIWEpCR3hZRDk0?=
 =?utf-8?B?cDhhdWZWbkFQMUZWeTd3aWN0OUhWTkpNY1NNRU9OVXNlM0g3bmE0bnhVRk9m?=
 =?utf-8?B?aEdsUUNEcGxEcTljeDVZMkxlT1BVcnB0N3RWc2orV09IUkoyTWx1M0w3UXNT?=
 =?utf-8?B?djRnTlF5Vm9VTEVDUG5Jc2FBbXVZNFo1QVg0cEMwNjZ3aDRDaWFCd3NFbEtO?=
 =?utf-8?B?aC9kRHRMUUcxcTJGM3NGQ2lqSHhod3V5Wnd6cDIzK2N3SE9OVHNjZGlMVnVR?=
 =?utf-8?B?MTRQZ1BTNU1PaWgwdi8wbmthT0dVSEZaa0t5amZVZjZPckJyL0lPWmI5QUY4?=
 =?utf-8?B?SUtSUVE5bXpMMUhDUGp6WFdQSE4xZzM5S3ZSNDhPOFkwWW53azB5ak5ESkNQ?=
 =?utf-8?B?c0haTmYrVWNwaUh2R0YzcmxaeUJzNkhBQ0hYRVM1WEwrbjljYlZrdnhsMjBk?=
 =?utf-8?B?dmNjenJjUUZ6dWlJQTRveWx6YU1QZnJ1S0ZuMXNDYWwrd0lCQjBZUzA0MFZM?=
 =?utf-8?B?L251eVdvM1htdFRTTXlmdnVZakJWSWJCdzI0L2JQU1hYcHJsdHdXc09BRk9C?=
 =?utf-8?B?RnQwcDh3TWRTNkd6MkhRWDJuY2E0aE1HNXVEN1R0WVAxVTZ0d0M5aEVZUUtF?=
 =?utf-8?B?RzRHYmxFdGVvbXpYRjg4OVFyN3dyQzdIL0phcGZQelFHK3pld1YrdnVlWUJ1?=
 =?utf-8?B?WkNSRlRBMURSYXRTdTBERmxaa0hmWjc2Nm1Kd0RhNVZTVU5nVWNmeFM0YnJZ?=
 =?utf-8?B?dzhTUmsrbTdPNjErQnp3TzU0VzBvdGc3VURxeHMzS3BsV1ZrMjhZeXJaRHRE?=
 =?utf-8?B?OTUzTGpnazVsL0xUeitmUXQ1UG00ckwrZkxsU1B0cEFKek5weW5NcWdRZHpT?=
 =?utf-8?B?L29iUnFid0NFQVR3ZmJaL2pBbWI3SHVjei9TTmRHVWgzY3NOR01hb09FR2ln?=
 =?utf-8?B?aG1kN25tNGZXMmNma21DRmJTdXUzeTA0cE1RajZQMjZuVlNNM3lObmRDdi9k?=
 =?utf-8?B?WlR2WDJzRUlFbmVMYXZhWE1TbHhLMER3TmtJSDZZWEQzNUc0aU5FOGFjbzNh?=
 =?utf-8?B?M1oxN1huN1lqeEZPaUYwNURKZFdSZlpDV1BxRUV0STF4a3YxdmdhNE5PT1da?=
 =?utf-8?B?Uk1za2NTQ3hlSUpSL1JpMjRVeGVIWjc2allFbUIyZ1VzTWN6THFYNlF3ekRR?=
 =?utf-8?B?ckZoUzNteUkvaE5NQUp0SGpuYk93RHJ4elRNaDU4eE5vbGRpOXlTRFNpRUc2?=
 =?utf-8?B?NTFnblo1VURhZ1VHMHhqaEVqMmMvc0gvQmp6bEI5RmgxZWVOdWR2amJjbk9x?=
 =?utf-8?B?ZGcyNXdYUDU0L2NSdmRZbitYT0c5TWxzSGxDb0IzMEJjVEVSNzJxNGt4aGhh?=
 =?utf-8?B?eEd1YndIRlZrQmVtRCtnVjd3WUZjY0EycUVaV3hncXB0Z2lsOE42dWdUcENS?=
 =?utf-8?B?WkJ3MThEUWxkRW9ZM0lFeW9lZkE4Qlh1Vld3dEtycmR0c2R6QXVLNnNEV2ts?=
 =?utf-8?B?M1ZSZysvcDNHQkN1RlhCdlBDc1BFdmpoMWhHSi9DL3R5NXU3THJLb01sYTl0?=
 =?utf-8?B?NFhTUndiZkFiZUVWVHJ2Q3VjeFdZeHZIT2ZhemJVVWN5TXRXOFFuMTlFQzdv?=
 =?utf-8?B?eTByMHpFQ1phYUtJU2dQRGRXemtVbkhLQlY5YUQrWkVyVmQ0SWp5cGgxZmVw?=
 =?utf-8?B?NS9mSmtpVlFaTnZnMUo0MW8xMXpKbEI2Sm9SRXEvd0hxVFlJNCtCMjFuc2JN?=
 =?utf-8?B?WXlFMVJkdDIwODdqby9RUTY3OWpVdXY3TTg1cDNLa2had2R2MGFRbVN6NHh5?=
 =?utf-8?Q?r1gMj2KdrvBQy23xnzSgc6C18?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c04e07d-4cb4-4305-9b07-08dd67b9503d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 14:12:56.8871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWp+hI02hQ5yFONsDCHcVRK21FoX9utR2w1MXSplXwPW9nRmRbrU5WvSCrGeMTV9bOnavI7w6v8i3PsdojtwbD7XTOyPj/6z7u5uGbFUvAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8763
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBtZWk6IHZzYzogRml4IGZvcnRpZnktcGFuaWMgY2F1c2Vk
IGJ5IGludmFsaWQgY291bnRlZF9ieSgpDQo+IHVzZQ0KPiANCj4gZ2NjIDE1IGhvbm9ycyB0aGUg
X19jb3VudGVkX2J5KGxlbikgYXR0cmlidXRlIG9uIHZzY190cF9wYWNrZXQuYnVmW10NCj4gYW5k
IHRoZSB2c2MtdHAuYyBjb2RlIGlzIHVzaW5nIHRoaXMgaW4gYSB3cm9uZyB3YXkuIGxlbiBkb2Vz
IG5vdCBjb250YWluDQo+IHRoZSBhdmFpbGFibGUgc2l6ZSBpbiB0aGUgYnVmZmVyLCBpdCBjb250
YWlucyB0aGUgYWN0dWFsIHBhY2tldCBsZW5ndGgNCj4gKndpdGhvdXQqIHRoZSBjcmMuIFNvIGFz
IHNvb24gYXMgdnNjX3RwX3hmZXIoKSB0cmllcyB0byBhZGQgdGhlIGNyYyB0bw0KPiBidWZbXSB0
aGUgZm9ydGlmeS1wYW5pYyBoYW5kbGVyIGdldHMgdHJpZ2dlcmVkOg0KPiANCj4gWyAgIDgwLjg0
MjE5M10gbWVtY3B5OiBkZXRlY3RlZCBidWZmZXIgb3ZlcmZsb3c6IDQgYnl0ZSB3cml0ZSBvZiBi
dWZmZXIgc2l6ZSAwDQo+IFsgICA4MC44NDIyNDNdIFdBUk5JTkc6IENQVTogNCBQSUQ6IDI3MiBh
dCBsaWIvc3RyaW5nX2hlbHBlcnMuYzoxMDMyDQo+IF9fZm9ydGlmeV9yZXBvcnQrMHg0NS8weDUw
DQo+IC4uLg0KPiBbICAgODAuODQzMTc1XSAgX19mb3J0aWZ5X3BhbmljKzB4OS8weGINCj4gWyAg
IDgwLjg0MzE4Nl0gIHZzY190cF94ZmVyLmNvbGQrMHg2Ny8weDY3IFttZWlfdnNjX2h3XQ0KPiBb
ICAgODAuODQzMjEwXSAgPyBzZXFjb3VudF9sb2NrZGVwX3JlYWRlcl9hY2Nlc3MuY29uc3Rwcm9w
LjArMHg4Mi8weDkwDQo+IFsgICA4MC44NDMyMjldICA/IGxvY2tkZXBfaGFyZGlycXNfb24rMHg3
Yy8weDExMA0KPiBbICAgODAuODQzMjUwXSAgbWVpX3ZzY19od19zdGFydCsweDk4LzB4MTIwIFtt
ZWlfdnNjXQ0KPiBbICAgODAuODQzMjcwXSAgbWVpX3Jlc2V0KzB4MTFkLzB4NDIwIFttZWldDQo+
IA0KPiBUaGUgZWFzaWVzdCBmaXggd291bGQgYmUgdG8ganVzdCBkcm9wIHRoZSBjb3VudGVkLWJ5
IGJ1dCB3aXRoIHRoZSBleGNlcHRpb24NCj4gb2YgdGhlIGFjayBidWZmZXIgaW4gdnNjX3RwX3hm
ZXJfaGVscGVyKCkgd2hpY2ggb25seSBjb250YWlucyBlbm91Z2ggcm9vbQ0KPiBmb3IgdGhlIHBh
Y2tldC1oZWFkZXIsIGFsbCBvdGhlciB1c2VzIG9mIHZzY190cF9wYWNrZXQgYWx3YXlzIHVzZSBh
IGJ1ZmZlcg0KPiBvZiBWU0NfVFBfTUFYX1hGRVJfU0laRSBieXRlcyBmb3IgdGhlIHBhY2tldC4N
Cj4gDQo+IEluc3RlYWQgb2YganVzdCBkcm9wcGluZyB0aGUgY291bnRlZC1ieSwgc3BsaXQgdGhl
IHZzY190cF9wYWNrZXQgc3RydWN0DQo+IGRlZmluaXRpb24gaW50byBhIGhlYWRlciBhbmQgYSBm
dWxsLXBhY2tldCBkZWZpbml0aW9uIGFuZCB1c2UgYSBmaXhlZA0KPiBzaXplIGJ1ZltdIGluIHRo
ZSBwYWNrZXQgZGVmaW5pdGlvbiwgdGhpcyB3YXkgZm9ydGlmeS1zb3VyY2UgYnVmZmVyDQo+IG92
ZXJydW4gY2hlY2tpbmcgc3RpbGwgd29ya3Mgd2hlbiBlbmFibGVkLg0KPiANCj4gRml4ZXM6IDU2
NmY1Y2E5NzY4MCAoIm1laTogQWRkIHRyYW5zcG9ydCBkcml2ZXIgZm9yIElWU0MgZGV2aWNlIikN
Cj4gQ2M6IHN0YWJsZUBrZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUg
PGhkZWdvZWRlQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgVXN5c2tpbiA8
YWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9taXNjL21l
aS92c2MtdHAuYyB8IDI2ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9taXNjL21laS92c2MtdHAuYyBiL2RyaXZlcnMvbWlzYy9tZWkvdnNjLXRwLmMN
Cj4gaW5kZXggN2JlMTY0OWIxOTcyLi5mYTU1M2Q0OTE0YjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbWlzYy9tZWkvdnNjLXRwLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL21laS92c2MtdHAuYw0K
PiBAQCAtMzYsMjAgKzM2LDI0IEBADQo+ICAjZGVmaW5lIFZTQ19UUF9YRkVSX1RJTUVPVVRfQllU
RVMJCTcwMA0KPiAgI2RlZmluZSBWU0NfVFBfUEFDS0VUX1BBRERJTkdfU0laRQkJMQ0KPiAgI2Rl
ZmluZSBWU0NfVFBfUEFDS0VUX1NJWkUocGt0KSBcDQo+IC0JKHNpemVvZihzdHJ1Y3QgdnNjX3Rw
X3BhY2tldCkgKyBsZTE2X3RvX2NwdSgocGt0KS0+bGVuKSArDQo+IFZTQ19UUF9DUkNfU0laRSkN
Cj4gKwkoc2l6ZW9mKHN0cnVjdCB2c2NfdHBfcGFja2V0X2hkcikgKyBsZTE2X3RvX2NwdSgocGt0
KS0+aGRyLmxlbikgKw0KPiBWU0NfVFBfQ1JDX1NJWkUpDQo+ICAjZGVmaW5lIFZTQ19UUF9NQVhf
UEFDS0VUX1NJWkUgXA0KPiAtCShzaXplb2Yoc3RydWN0IHZzY190cF9wYWNrZXQpICsgVlNDX1RQ
X01BWF9NU0dfU0laRSArDQo+IFZTQ19UUF9DUkNfU0laRSkNCj4gKwkoc2l6ZW9mKHN0cnVjdCB2
c2NfdHBfcGFja2V0X2hkcikgKyBWU0NfVFBfTUFYX01TR19TSVpFICsNCj4gVlNDX1RQX0NSQ19T
SVpFKQ0KPiAgI2RlZmluZSBWU0NfVFBfTUFYX1hGRVJfU0laRSBcDQo+ICAJKFZTQ19UUF9NQVhf
UEFDS0VUX1NJWkUgKyBWU0NfVFBfWEZFUl9USU1FT1VUX0JZVEVTKQ0KPiAgI2RlZmluZSBWU0Nf
VFBfTkVYVF9YRkVSX0xFTihsZW4sIG9mZnNldCkgXA0KPiAtCShsZW4gKyBzaXplb2Yoc3RydWN0
IHZzY190cF9wYWNrZXQpICsgVlNDX1RQX0NSQ19TSVpFIC0gb2Zmc2V0ICsNCj4gVlNDX1RQX1BB
Q0tFVF9QQURESU5HX1NJWkUpDQo+ICsJKGxlbiArIHNpemVvZihzdHJ1Y3QgdnNjX3RwX3BhY2tl
dF9oZHIpICsgVlNDX1RQX0NSQ19TSVpFIC0gb2Zmc2V0ICsNCj4gVlNDX1RQX1BBQ0tFVF9QQURE
SU5HX1NJWkUpDQo+IA0KPiAtc3RydWN0IHZzY190cF9wYWNrZXQgew0KPiArc3RydWN0IHZzY190
cF9wYWNrZXRfaGRyIHsNCj4gIAlfX3U4IHN5bmM7DQo+ICAJX191OCBjbWQ7DQo+ICAJX19sZTE2
IGxlbjsNCj4gIAlfX2xlMzIgc2VxOw0KPiAtCV9fdTggYnVmW10gX19jb3VudGVkX2J5KGxlbik7
DQo+ICt9Ow0KPiArDQo+ICtzdHJ1Y3QgdnNjX3RwX3BhY2tldCB7DQo+ICsJc3RydWN0IHZzY190
cF9wYWNrZXRfaGRyIGhkcjsNCj4gKwlfX3U4IGJ1ZltWU0NfVFBfTUFYX1hGRVJfU0laRSAtIHNp
emVvZihzdHJ1Y3QNCj4gdnNjX3RwX3BhY2tldF9oZHIpXTsNCj4gIH07DQo+IA0KPiAgc3RydWN0
IHZzY190cCB7DQo+IEBAIC0xNTgsMTIgKzE2MiwxMiBAQCBzdGF0aWMgaW50IHZzY190cF9kZXZf
eGZlcihzdHJ1Y3QgdnNjX3RwICp0cCwgdm9pZA0KPiAqb2J1Ziwgdm9pZCAqaWJ1Ziwgc2l6ZV90
IGxlbg0KPiAgc3RhdGljIGludCB2c2NfdHBfeGZlcl9oZWxwZXIoc3RydWN0IHZzY190cCAqdHAs
IHN0cnVjdCB2c2NfdHBfcGFja2V0ICpwa3QsDQo+ICAJCQkgICAgICB2b2lkICppYnVmLCB1MTYg
aWxlbikNCj4gIHsNCj4gLQlpbnQgcmV0LCBvZmZzZXQgPSAwLCBjcHlfbGVuLCBzcmNfbGVuLCBk
c3RfbGVuID0gc2l6ZW9mKHN0cnVjdA0KPiB2c2NfdHBfcGFja2V0KTsNCj4gKwlpbnQgcmV0LCBv
ZmZzZXQgPSAwLCBjcHlfbGVuLCBzcmNfbGVuLCBkc3RfbGVuID0gc2l6ZW9mKHN0cnVjdA0KPiB2
c2NfdHBfcGFja2V0X2hkcik7DQo+ICAJaW50IG5leHRfeGZlcl9sZW4gPSBWU0NfVFBfUEFDS0VU
X1NJWkUocGt0KSArDQo+IFZTQ19UUF9YRkVSX1RJTUVPVVRfQllURVM7DQo+ICAJdTggKnNyYywg
KmNyY19zcmMsICpyeF9idWYgPSB0cC0+cnhfYnVmOw0KPiAgCWludCBjb3VudF9kb3duID0gVlND
X1RQX01BWF9YRkVSX0NPVU5UOw0KPiAgCXUzMiByZWN2X2NyYyA9IDAsIGNyYyA9IH4wOw0KPiAt
CXN0cnVjdCB2c2NfdHBfcGFja2V0IGFjazsNCj4gKwlzdHJ1Y3QgdnNjX3RwX3BhY2tldF9oZHIg
YWNrOw0KPiAgCXU4ICpkc3QgPSAodTggKikmYWNrOw0KPiAgCWJvb2wgc3luY2VkID0gZmFsc2U7
DQo+IA0KPiBAQCAtMjgwLDEwICsyODQsMTAgQEAgaW50IHZzY190cF94ZmVyKHN0cnVjdCB2c2Nf
dHAgKnRwLCB1OCBjbWQsIGNvbnN0DQo+IHZvaWQgKm9idWYsIHNpemVfdCBvbGVuLA0KPiANCj4g
IAlndWFyZChtdXRleCkoJnRwLT5tdXRleCk7DQo+IA0KPiAtCXBrdC0+c3luYyA9IFZTQ19UUF9Q
QUNLRVRfU1lOQzsNCj4gLQlwa3QtPmNtZCA9IGNtZDsNCj4gLQlwa3QtPmxlbiA9IGNwdV90b19s
ZTE2KG9sZW4pOw0KPiAtCXBrdC0+c2VxID0gY3B1X3RvX2xlMzIoKyt0cC0+c2VxKTsNCj4gKwlw
a3QtPmhkci5zeW5jID0gVlNDX1RQX1BBQ0tFVF9TWU5DOw0KPiArCXBrdC0+aGRyLmNtZCA9IGNt
ZDsNCj4gKwlwa3QtPmhkci5sZW4gPSBjcHVfdG9fbGUxNihvbGVuKTsNCj4gKwlwa3QtPmhkci5z
ZXEgPSBjcHVfdG9fbGUzMigrK3RwLT5zZXEpOw0KPiAgCW1lbWNweShwa3QtPmJ1Ziwgb2J1Ziwg
b2xlbik7DQo+IA0KPiAgCWNyYyA9IH5jcmMzMih+MCwgKHU4ICopcGt0LCBzaXplb2YocGt0KSAr
IG9sZW4pOw0KPiAtLQ0KPiAyLjQ4LjENCg0K

