Return-Path: <linux-kernel+bounces-348158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990C098E37A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38FEB221FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A1176FB0;
	Wed,  2 Oct 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Adc6x2IQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C51FDA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897465; cv=fail; b=bOFPBXhY0D9U97q9DddgpsrBaxPrrCAjflP8aodLz3cwFug5/4eG/BPtynOqYie00+I856B5uYGKm1RfaUXRxKlt5hM6fvedJf7QKp12TF9mOkeCSLRf8NHZK6laD9meHhEn+hSlqmIhSKL57+hZXRD5F+f2OZ977GZtASrs4x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897465; c=relaxed/simple;
	bh=rNOrXyrpIRvxbt6wneUjSH68G6W8aUp0PtX4DLPHUKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dF9+kYOYwLdWcVAELmABTpJ/jNJ9HCVezIoiRBtH6jkRdU5ObJkGLXmfli2de6WCz53JPwvHhipfnfzT8WN/OW4b0+acpatzfHoChXHhX9hJ8y2wIOlkP9eKi3UxZFZQGOnY9DeRKQ2gnCp9swxiJ+WsozMYHaMN/gJuaFc8Ans=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Adc6x2IQ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727897461; x=1759433461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rNOrXyrpIRvxbt6wneUjSH68G6W8aUp0PtX4DLPHUKA=;
  b=Adc6x2IQL1zPZ+SrJRfiZx82afLaMu1oY43opz1vUfw2isAUU9unsas4
   Ej9XNuLn7sryP7AhuSgZMzAJ6mOKj6XK0kHBZ6jNRlbjhQYxgHT9nm9iv
   vMvRTDVPbfnEGFRaDT52f0f1GqdIWvNIU9ei0PCOGFg59IYUGlRd2Rhnp
   3xueH6mSJAral3P4SHdxHjXpEmgu5eP65bOezce83kXdIQ9OuiXKOFlqW
   T0ebnoetHRdzdTYmAFZA6QWPGgR+HM3V94ive+ySkF1Ke9sIiCGaZQ3VH
   V7aNPltH8S9qBjujUl3z3O5XYQ5nEikOJsSS2UiJyRoF1uhZgIXYncSO+
   Q==;
X-CSE-ConnectionGUID: 22h4mUnxScKaNj8AULaN1A==
X-CSE-MsgGUID: fMszhdE3RFGy+qKNZZoU1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="44602609"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="44602609"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 12:31:00 -0700
X-CSE-ConnectionGUID: hG+ungyJTcCK8P/L4kSBIA==
X-CSE-MsgGUID: J5PXFeXAQ3Om2ycXQguo9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78948331"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 12:31:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 12:30:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 12:30:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 12:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYres5Wi2DBO3EFNLcg0JS1qU/5aFhfELhwItmEqXygkkRISjNubaE2aE0WRlWMwoZwpUDdbdY2tcSduuCA5wEmPulnRhq54S0fZ+8aNTprC4edkKbB5MO9vYSWL1+X/qt8cCUMUbZxkekY6j7uypVB3qH+o6XNDtH1vcLYTchCxO/KQC0ssAuHPgTeud0aPh6wSM+jZD/ulAp74xg9Ftx6krvVbPc0cAwcWQLJSLWMNtZlo8hjaER0XbOhP+pPNMb9eeTX2Ddy1opOVrMWvuccgemzxGcR/2SV6nEBnMGvHY9x6hVI/SmAUGYl+6ZcaijTyi/Ruz3MWnvCUEmMgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNOrXyrpIRvxbt6wneUjSH68G6W8aUp0PtX4DLPHUKA=;
 b=m7CgbhHLRhqzvWLMkyWENdrJxRxW+bUB8KWygwf3VxmyqBer/nmNjAX5tHaWoMak/59CTguvJOfV4Bjv7WEeUZ/0wFuN15dzHHSPhuvsCVo2iTltISbD8VNECPi1ZDSyco4IpOi2RxdGOY5AzGdaMnjgtYBPzzhB2+yVV4UfM2ph2/oYtRtGfNgbCf8urUgCkZGFflMOdCsuD2tZc3VHsx86yz4U3ARS97zPJD+mjpEJ6960/Lx6KiIWQ+75uYscdF9CZNniuFPSNYwkoiwetLO2ecSIMoU7kl0AU4L1aTjiY6aaX3soMpUEwrN7sA1KzX4KmPIe125K0y8E7o38uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA0PR11MB7816.namprd11.prod.outlook.com (2603:10b6:208:407::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 19:30:57 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 19:30:57 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: swap: Call count_mthp_stat() outside ifdef
 CONFIG_TRANSPARENT_HUGEPAGE.
Thread-Topic: [PATCH v1] mm: swap: Call count_mthp_stat() outside ifdef
 CONFIG_TRANSPARENT_HUGEPAGE.
Thread-Index: AQHbFPDsqYs1cZP4n0qn6UDjXtxW4LJz0TGAgAAHxkA=
Date: Wed, 2 Oct 2024 19:30:57 +0000
Message-ID: <SJ0PR11MB5678738DBE2B5B3B1F6CC760C9702@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241002173030.213536-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkYLD9815CLS+6FCkokeOvPt4Pa6XTnpUAGdaDJF9kdNmA@mail.gmail.com>
In-Reply-To: <CAJD7tkYLD9815CLS+6FCkokeOvPt4Pa6XTnpUAGdaDJF9kdNmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA0PR11MB7816:EE_
x-ms-office365-filtering-correlation-id: 5ae4b557-c359-4b45-fcd0-08dce318bd3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T2JpV1NNQVBNMWhHMHdHajVrMFRQY3FLRHFYcTZicDFNQ1grdk5rbTVhZkdZ?=
 =?utf-8?B?NUtrU1NZUU8vN2d6T1ozTnJGdU1YZzN5N1MwQllsUGthN3dQcGlGV1hDdzJr?=
 =?utf-8?B?a1ZBaHZrYlRveVd4TXVPVWhoZkthUit4OG9HZ3FHK0x1WkRlVjFmRjBVNkhE?=
 =?utf-8?B?bDFpRkRKbGNnbkFRaTRyUDhITE9tVTBXd2dnNnhHZG4yeXhHblpnZXNMM0hD?=
 =?utf-8?B?SjFtUE9BZXJ3bFQ4OU1mclBUR25LTTRNcUdDaG55RVRUblF5QlpoTmNscTV4?=
 =?utf-8?B?aVFqclRiYWd5azBmdXlmeGVrdDNLb0dqbkl0eGhCWEF6NVA0Z052emM3Y2hs?=
 =?utf-8?B?NjBvUlhIeFFXM0s3NVVqMnhPZGkzYlRENTVJb0d2UnlCNGJPRk1ZOFJsMVlR?=
 =?utf-8?B?MzIrQW5mWjZwdy8xa2ZCMlptRmJjYWc4dUpPNWpSRjFOanpzdExKRzgvZDJN?=
 =?utf-8?B?a2FtVGhkVlEzZ2VtTHlmQit1eDRjM1NEc2owakJBdXlnTENZSmdVdXlad3ZJ?=
 =?utf-8?B?U080aE14MDhsV1BYek9GaE54c05jd2cxYW1DWFI0WElVdEp3cDlweE9SY0FM?=
 =?utf-8?B?dFFmQlBZNXlreG9oSUJmZ2tPRmhhNDAvR0t3Q3NyU3piTUpZS1g0TWVGbHhs?=
 =?utf-8?B?NEtZZksvM3RHN25oUjZ6bFFxQllnY2dGVDBCMTR1K0p2ZEFGZDMrYWN5ZVdY?=
 =?utf-8?B?U2x4eG92R3BwYTl6WFRSR1RLOVNuWDA3VGtLWnBGZzk0V2NIb3JvVFQ3Mk5a?=
 =?utf-8?B?cEh6czlvQlYrUVBQLzdmY2tiVURPVVhtemRqNjZhYmoxbTRpYVNNblE5cnFO?=
 =?utf-8?B?TVZDZjZTNEdwMFNKdjJJeCtWSkVra0RmeC94RlQ2SGNDQ0VQL3gwRnR5ZFJ4?=
 =?utf-8?B?eXFNNFk2MEE5S1Q0cmdMV0JWSVBYNDBFYTJuNkFJek9CcGZvMFYyYm45UE5j?=
 =?utf-8?B?ajVObHdTN3dibmlrVnhLMW1QUCt1bStkZVZycXlRRWFiSTgxN2xOQmErM2Fp?=
 =?utf-8?B?bXYvR2ZWeTRIbzVMUGVKWmRhbXJBY01YaVQ1NjBORlYzN0ZIcWVZdWFYeWRN?=
 =?utf-8?B?Wkw3NHI5NERHNWpmTG9EUkNuQVFjL2t4WlpvclNucjlNdFhNb3BGWWRHVnFN?=
 =?utf-8?B?dlRxYmp0K0RyZFY3SG5PeU9YNkhtcnZ6ZXZ6ZFd0T0JzcFNCakxIb1lkeUMw?=
 =?utf-8?B?L1l0WUdwc3RKNFZIczdVVUR0ZzJOQk85R3k2amZneHJGSG50eXVGMXpRbUtE?=
 =?utf-8?B?bXJaNHV6YmE1R1NzaE1ZT09SU2xNaFpZeFNzbjA1K1FMTGRybEl5cUtkOVpF?=
 =?utf-8?B?Y0VEdnZqVVpvTFRIYlhUWG9rYVJCN01wQWF6RmVjTGFPWTJWV1VCVzB5NHZt?=
 =?utf-8?B?YzdJeFYrK2Vxekw2T1lrUm9tbzJZSzUyNkZORkd1RmRmUE0waFJ4TUJrMkpV?=
 =?utf-8?B?bS8vYzFjZ2VIMmF1NG1PNHhONzRqeS9iRlE3ZkxUQWUrbmM3Zkh1eFZKbXpj?=
 =?utf-8?B?cHVQMThhWHBGckhicDNnMHpsL1YrRVp5ZjUzSmFFSCtXTTJmbkZrbktNV3VP?=
 =?utf-8?B?RDFnVE9GZnVHUy96QUFMNmtxNXVvMkt1UVpUQjQyUXRnTXhuR29WamVKRHgv?=
 =?utf-8?B?Y0xwbU9jOUVETFNUNXZDVDhaYzFKZ2hPTmJra1RpTC9LZ2RVeGJrOTF0Q2py?=
 =?utf-8?B?Q3FSUmZiTXZ4ZGJqS2t2a0czQk9ZQ1RMU1oyVHFpUUJFaGdIMFNxaW9kMkc5?=
 =?utf-8?B?b3BIY3VGMzFRemxtTGpjRzcraEdWNkVrVUdIWGdEQmVWY1A3aU4za0FIU1Ns?=
 =?utf-8?B?OUVZSzlLRit6SzV0WWswdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rml1aDJBdEFJb3pybXkza3hJbkN4RXdMMk9zcDlKTUtxeWRNWnRzdDRGcG05?=
 =?utf-8?B?dFBaNk5iNzlSQlp5VDhyQ2pIN05PaWwzdytrRnRnSXR0RFI0V0tSbnQyS1pX?=
 =?utf-8?B?Y2d1RStQbW1ieVBYTTdJYjJFaSt4RER3UE9TNUdPMnhDWURYMXEyM2RFVUFz?=
 =?utf-8?B?dGtwWkhBSkhBbXpwRmZVcG1xcDZQU3lSVDBIcjN5VUpTdEt0dGRuMUpVSGxR?=
 =?utf-8?B?VnFrb1RLNFFLMThKUW5ST1JBT1ZCL3Ruc0RKeFdDYXljUVZVcGdSNnZMUWQ0?=
 =?utf-8?B?NUdoWEpZYXNpUXhCa09JTUtwUUdvTUpjTUhzLzFEMWJtYmZseHNLNkkyaDda?=
 =?utf-8?B?TzVQbnl6RzJCRXlhdmRvaDJ2V2ROc1I0M1VWR2QvcjV2WTVaUExrYUw2R3hL?=
 =?utf-8?B?NFlwQlBjcWlkSGpwcysxUGl5MDRRZDUweFNTTXAyeTFGclJKUkx2V3BFeFRy?=
 =?utf-8?B?YkZLYldTU3RCMzZVMzQvdlZuWUwwNjdNZXUxbEtpR3lWQkFIMCs4TzVvUURH?=
 =?utf-8?B?YjU5eFRrVHFhdWlmZzRSQkVVMlUxMnhSVFdmRDJSVXIvOW9mZEliTHMwZHdl?=
 =?utf-8?B?eS9zMFl3cGtKSnpNZnc0REpNaGNRMnc1emJOeGZuUzZCTDZpZStBWGhsT1lo?=
 =?utf-8?B?RkxXRjhMNzhVVktjcFVicnNpa0tObUtHOHFDbHZhVXY2dnhMUVo2TzVhYWFN?=
 =?utf-8?B?eGxHNE1kYlpmWFhwRnkrSXRld21adFp1V0JQTzErSEVoVE81QjRCd1lzbldQ?=
 =?utf-8?B?SlN0T0YybVU1eWFIQ1BJdXo0R1hrVDdjTWhkTFE2bFN4OEhwYWdzVW50T00x?=
 =?utf-8?B?M1FyM0Z4MFlkcG9GSHdWVmVoN3NqTEIvL0VON0M3UzJBZlJGeENyV0IwM1lY?=
 =?utf-8?B?Ujh0NStiaWkwVDg2V0hoRTBMekd6OUt2bCtpRnhkYUlzUjZxTjcxTnFGYWlC?=
 =?utf-8?B?ZHNiRXJiOWNGTEQ2TEtPZU0wSy96ZVhQdWRRdzNoOTFJOThWRGN5MG9sREVV?=
 =?utf-8?B?Zms2emdsY2l4ZXNjMFFaSFpvdktCdkhzTHAxdTlsOXplRmFCNVBYTDd3MmVI?=
 =?utf-8?B?VzJFeFBlQUlzd3dmUmZiVlFRU0YvS2ZYY2JYM0s5STQyR1RsazNxdmhnTk5a?=
 =?utf-8?B?QlMxbXNjUVNGUXd3UzlVb2RMblZseGdjazRMSmdxc0N0NkRJTE04RzUyOUxl?=
 =?utf-8?B?Ymwrb1hpM1lPL05tbnFIakVVeTJmOWJyZ0EzRk9EeTNtM3Q2Ui85VTJnVm94?=
 =?utf-8?B?MTRycEVzSHhvelJua0ZBckplSkUvdXdQc082UTdrREdKVVpvL2ZMT3lSazl5?=
 =?utf-8?B?SkRsYng2dFB6aVpuVHdxcUZmWE1ZRThwN3IvVEowMEMyYXJzcjZ4YWpudE5w?=
 =?utf-8?B?RHNsVFhabzgrOUhxcVVoL1gxNUw1anpQTGJQRUVqR1paNllFYXV0cWVGNS9X?=
 =?utf-8?B?UkVNMExQWWRrUm0zZnY0NnRQZmN6TFRxcEkyNFJuUEdtVEgxR0JIdUN0dkpI?=
 =?utf-8?B?SVNPN2dnUTFDSzFyNDd6czB0OTJ2NFBHbS9NVjZPSmw4RmxJdGx1bDIzT1Ew?=
 =?utf-8?B?bTA0U1doNzFtSnZ2VGo1Mm9RQ0xnTGhqUWZiL2JmY1prc2srS2NhWTQzWmsw?=
 =?utf-8?B?YkNDZ2NqRHV1bFcvT3p1MzhEU0d3VXRGc1htcVpYQVdYZ2xWRGFVTVRpbmlE?=
 =?utf-8?B?b2xZZjNMQ0RZMXkvS3MrYnRmeVV3K3VYNy9iYkxaVXJYL1lTK2sxelJHTDBi?=
 =?utf-8?B?cVg0SHNieVhobXRrc250dFFkK2ZQbXQ5OHpjSG9QRlRwVWo4bGNGL3E3ck9D?=
 =?utf-8?B?S2IwMW9nYyt2T2tFUVZSNy9XVUtDTUwraGZRVVlrcDlpQkNEYU1QZ2Yrd3ow?=
 =?utf-8?B?YkVvUnd5TnlHbkVhYy9WcHhnNDRidmhxaFA0UWxGOEtoODRxYkE2b1RkbzJ2?=
 =?utf-8?B?Wm9KeVdGUUJoclZYVjJEY1dUK1U3QjB4TXU2eEg5YTVhSkhZVHVKcGwvYVZw?=
 =?utf-8?B?UVc1YndkTHZKb1hhVjEvNkxxalZibzlMeGIwQ0hRUlE4d0xOQ05MVEhwV014?=
 =?utf-8?B?TTY1MDJIV2lzcEZFMlJ3ZnNqRkV5WlhYbU5aTi9nV2tuYTQyQkMzcHlHNDZ0?=
 =?utf-8?B?MUUreXNaeWtXTTNaaFFLd1VYU3I2WkhCdm5qZ2owcnA3T2NEMTZua2h2WS9p?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae4b557-c359-4b45-fcd0-08dce318bd3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 19:30:57.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPj4+dJPcBAP0KEkRNwzWQWKAWpulkc4DiIYj/0M4XF9H4HzXi+k2DwtEHDz1KhRzLnJBgYBcYC37jOk1YkKLwR9N5nsAN4z3NDNjQ5komQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7816
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMiwgMjAyNCAxMjow
MiBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVs
LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNr
Lm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2Ow0KPiByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcgPHlp
bmcuaHVhbmdAaW50ZWwuY29tPjsNCj4gMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc7IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5j
b20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxXSBtbTogc3dhcDogQ2FsbCBjb3VudF9tdGhwX3N0YXQoKSBvdXRzaWRlIGlm
ZGVmDQo+IENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRS4NCj4gDQo+IE9uIFdlZCwgT2N0IDIs
IDIwMjQgYXQgMTA6MzDigK9BTSBLYW5jaGFuYSBQIFNyaWRoYXINCj4gPGthbmNoYW5hLnAuc3Jp
ZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBtb3ZlcyB0aGUgY2Fs
bCB0byBjb3VudF9tdGhwX3N0YXQoKSBpbg0KPiBjb3VudF9zd3BvdXRfdm1fZXZlbnQoKQ0KPiA+
IHRvIGJlIG91dHNpZGUgdGhlICJpZmRlZiBDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UiIGJh
c2VkIG9uDQo+IGNoYW5nZXMNCj4gPiBtYWRlIGluIGNvbW1pdCAyNDZkM2FhM2U1MzE1MWZhMTUw
ZjEwMjU3ZGRkOGE0ZmFjZDMxYTZhICgibW06DQo+IGNsZWFudXANCj4gPiAgY291bnRfbXRocF9z
dGF0KCkgZGVmaW5pdGlvbiIpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBT
cmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiANCj4gDQo+IEkgZG9uJ3Qg
dGhpbmsgdGhpcyByZWFsbHkgbWFrZXMgYSBkaWZmZXJlbmNlLCBidXQgSSB3aWxsIGxlYXZlIGl0
IHRvDQo+IHRoZSBUSFAgZm9sa3MgdG8gZGVjaWRlLg0KDQpTdXJlLCB0aGlzIG1ha2VzIHNlbnNl
Lg0KDQo+IA0KPiBIb3dldmVyLCBpZiB5b3UgZ28gdGhyb3VnaCB3aXRoIHRoaXMsIHBsZWFzZSBh
bHNvIGRvIHRoZSBzYW1lIGZvciB0aGUNCj4gY2FsbCBpbiBzaHJpbmtfZm9saW9fbGlzdCgpIGZv
ciBjb25zaXN0ZW5jeS4NCg0KWWVzLCB3aWxsIHN1Ym1pdCB2MiB3aXRoIHRoZSBzYW1lIG1vZGlm
aWNhdGlvbiBpbiBzaHJpbmtfZm9saW9fbGlzdCgpLg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0KDQo+
IA0KPiA+DQo+ID4gLS0tDQo+ID4gIG1tL3BhZ2VfaW8uYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvbW0vcGFnZV9pby5jIGIvbW0vcGFnZV9pby5jDQo+ID4gaW5kZXggNGFhMzQ4NjI2NzZmLi5h
MjhkMjhiNmIzY2UgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vcGFnZV9pby5jDQo+ID4gKysrIGIvbW0v
cGFnZV9pby5jDQo+ID4gQEAgLTI4OSw4ICsyODksOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY291
bnRfc3dwb3V0X3ZtX2V2ZW50KHN0cnVjdA0KPiBmb2xpbyAqZm9saW8pDQo+ID4gICAgICAgICAg
ICAgICAgIGNvdW50X21lbWNnX2ZvbGlvX2V2ZW50cyhmb2xpbywgVEhQX1NXUE9VVCwgMSk7DQo+
ID4gICAgICAgICAgICAgICAgIGNvdW50X3ZtX2V2ZW50KFRIUF9TV1BPVVQpOw0KPiA+ICAgICAg
ICAgfQ0KPiA+IC0gICAgICAgY291bnRfbXRocF9zdGF0KGZvbGlvX29yZGVyKGZvbGlvKSwgTVRI
UF9TVEFUX1NXUE9VVCk7DQo+ID4gICNlbmRpZg0KPiA+ICsgICAgICAgY291bnRfbXRocF9zdGF0
KGZvbGlvX29yZGVyKGZvbGlvKSwgTVRIUF9TVEFUX1NXUE9VVCk7DQo+ID4gICAgICAgICBjb3Vu
dF9tZW1jZ19mb2xpb19ldmVudHMoZm9saW8sIFBTV1BPVVQsIGZvbGlvX25yX3BhZ2VzKGZvbGlv
KSk7DQo+ID4gICAgICAgICBjb3VudF92bV9ldmVudHMoUFNXUE9VVCwgZm9saW9fbnJfcGFnZXMo
Zm9saW8pKTsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4yNy4wDQo+ID4NCg==

