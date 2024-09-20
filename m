Return-Path: <linux-kernel+bounces-333921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22C97CFE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EC61F22B76
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDEE555;
	Fri, 20 Sep 2024 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PvFjwgVb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC3DC13B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726799228; cv=fail; b=QvfPAPwXQoGTZieMR2/bBES0M3PLa/Mz6GQGdI5p18wprLQFwQ7XTRUtZNA0xtFUJGcJssIXBKe4aHIb/BZioaxdiw74MgZ7M4PBnOd5eYjgUlx9TZJn+pCbB4dtHqu+VqpxT49PYXr+OabH4ti8gCLap+2x4DiL27hm5esF22M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726799228; c=relaxed/simple;
	bh=jvwFSmuuf523rCXEv6bkK6/NcngJMC9B1F+ArBo4ogM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rztew0JOZIAvBOQlompT1KkidCNq0KG+2DCdXEjvm/WCYccAlUpYx0tQs+pExSfL3bJuLmbdTdLSRpNRhRbDarpNbGGIbiotvgZOqg09VCWEWxqSOmKel49DVlKjMaGioswSmE9kPBkg8chqG+rV+ocxUgrzTLKutuHG9rMCZuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PvFjwgVb; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726799226; x=1758335226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jvwFSmuuf523rCXEv6bkK6/NcngJMC9B1F+ArBo4ogM=;
  b=PvFjwgVb04sJbGeS7dks3h/wuV3kmkqVoiTPsYech7SlKvH13RNJftRr
   uaQpIA6gvAQhhnpfqPocy6eOI9ELRq64TKlddHhkL1/ZM2h6q5B7KhkR4
   89X+ZKx38mBcMQul1hr2mWbaFm+aUxy+biPNP4pVbQIC//JbUvWU8F59P
   dSRmjPLyhtdcY8snVpV7zD8ANT7ReqQpQlysb98Kb/Z/xkhXpF4fHgTeA
   O1Oy4RUUxqD+MYP4k7UsgH0ULZKOAqYWRlE5a+fzIbKCgCwGhdtzjqytj
   GZkbNh64W6K3bQorTkLMShBIxgbzlIT3ky9h5HWbTr5JBQ952wx4Nx3FW
   g==;
X-CSE-ConnectionGUID: hFmZgeK1SiWnn+gb/jv0yQ==
X-CSE-MsgGUID: 5YWSupakT26NznmxPYoFjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25313867"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25313867"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 19:27:06 -0700
X-CSE-ConnectionGUID: RA/qbg8bR0elW4QT1zExyA==
X-CSE-MsgGUID: ucjOg7tGQh2kRNBAyLp+hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="69997522"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 19:27:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:27:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:27:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 19:27:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 19:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifTzRXFaN+MDzz1P/fe0bqSn1514TI4TUo4Mte2D+Wwwh3MWQ2xIUMhVSjkKkC6w3NHkUUayA78gJurf6iWfBmgOosBV9i+nWNqrgStuvDSYrGWkavqu0oUCnWHLEBTPE7vK6Rym9xoUawiLu0nkWATHV9qhw3tBjat4miSH5lyjCcjoNxf8Ua6rpZG/qRH4SmsJSRQ6rC8KmX46Dj8tO2S9xgAhTLA+PbyeTyisXTGBWGNDP1vY01GPPUDbzxCqbo5jc8In71Hj3CqxxyRgdWSo0vaWIjcORwxGDO2xCanLLuzSd+hR7+aaLTiedM28+ljB7UY9MUvXO7m8bMuNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvwFSmuuf523rCXEv6bkK6/NcngJMC9B1F+ArBo4ogM=;
 b=oSyeEMQgYaCOwJuFWW0F+/fjZQpdUBIzaX02eCc2cT4zdMLXiynOTm01BFM8Jt9dLFzXeLJGXM6+RpJO16CJHHT2U4gvbRexnl/U3ioDS8N3+FWYr5sSw5vb5mgNQP9xZyrp4cf8vAbvzf2H1m91C7OtSas9vNwUdi/MMvhID3EXqEIlnHKZFTrtxONR4SuTFr7tbXK5tCpwmN9ASCE4aMCICCm909obAl+/t5gj4a3fzYdM5nTF4EdvWgW138sDjYgaXcpuCELBSv3oFC2cTtBloj5w3IxbODaiNjyrSaxVrWd4eAxHJ72n6FQg6USqW7OW5ltc0KUqCnbKWwoArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Fri, 20 Sep
 2024 02:26:57 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:26:56 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+lo8ysIDIejPvUy4b6yFKhIRqLI+1o8AgAAPzYCAAAKegIAAA06AgCEncDA=
Date: Fri, 20 Sep 2024 02:26:56 +0000
Message-ID: <SJ0PR11MB567808506EEBB2CF5ECC6931C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
 <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
 <CAJD7tkbYufUeWWLh=WU1xgeVLMaoafPz+SHgtf+JtYWN+6PbHg@mail.gmail.com>
 <CAKEwX=Mz_tmU1Qjm8ExfnmCVvkNcd2cYpcLQLZBBx0QCXJvOpA@mail.gmail.com>
In-Reply-To: <CAKEwX=Mz_tmU1Qjm8ExfnmCVvkNcd2cYpcLQLZBBx0QCXJvOpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CH3PR11MB8592:EE_
x-ms-office365-filtering-correlation-id: c1843899-77a8-4faf-9e96-08dcd91bb2e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dWRTWWsyN1ljd3BRVnlqUExJTFFRMGQ4ZjJub2V5aE9UdEx2aWZMNkkzY3RF?=
 =?utf-8?B?T0docGIrTGM2K3FWNkQ4VkFFRkRWcnowU2VUd2NoMXlJMHoxcFhCMXJXNkFu?=
 =?utf-8?B?dUxDSXRxR3l5dHczREcyemdXd2NFTlptYm1LbzBWMVZySVFTYThYcEd6b0J3?=
 =?utf-8?B?Qml5bUlWN0J0L2IzWDNaWlo2S2VrVW95ZXczZ2RUTjNLR1dPeUNGUlRaZEVL?=
 =?utf-8?B?dXR0dUdPcFo1WGc1dHFxUklYQ3c4aC9nSjVTNnZsM0ZwSVdsUk83VS9QcmRC?=
 =?utf-8?B?aWYxN1p6TEpmTmxkQThySGl5M0kvTmNMUk1GVEplQjA3SFVpM1lIZlJ4THVi?=
 =?utf-8?B?d0VqZE5sSTVDcnVjeEIwNlhyTmFRckt0QXZ0R1hIZEZyek9pNEdjZnM4UjVX?=
 =?utf-8?B?RjFkeHV2WWtES1AvbG9uTTdVNS9idjdKeW50M0NrbVVyTGJzZkpZQkk3aExC?=
 =?utf-8?B?WDJVMEFORG94aTg5WFlCR0c1NmgydVE1WlZibUpYVHFZQTd4NmxlaUZuQnZa?=
 =?utf-8?B?UnJ0WHZNSHlPMzVDS2d0RWNQbkpGd1JuU3NadDJySmZkRUFzUVdIb09MNGpv?=
 =?utf-8?B?WjFWUTEwb3V3ZFEzeFNRRnJ1RHFYMmtaN2VrK2hSMDF0b1k0aGRwUzAxcStv?=
 =?utf-8?B?cEFQTFBVdllhdXFsSy9JQ2xXOTB2VDdDWVZWbU5rUjU2U2c0YnJhUm03Q2xN?=
 =?utf-8?B?VGRLcFBlTEx0NTk3b3FvbTJwMzU3NW5xN0FYeWp5SUdpdjAyWlp3WUF4TDVE?=
 =?utf-8?B?SUx5eFlIS3lQMGluWThKajlnNktrVG90VWVRM0xKRmxrblhXUWF5U0Q3RTY0?=
 =?utf-8?B?UTFpS1MwQWpZMFovcWRyZ2hwUFFwa1VWMmRFcTdMOTIwWm5GdUtqQW9ucTlL?=
 =?utf-8?B?c3FIcmJpOEJ3SHVPc1BiNlJsalFSRzlwSG0rajk5M0Vjb3ZuZUZWcGdNd0Zh?=
 =?utf-8?B?TDNDOFE2eVJaaWlDQkZMTDhxTDZ5alNNb1lneFVqWkZHZ0lNUGlzR1BXendM?=
 =?utf-8?B?VlZnZ3RzMUErUVBySG9EdnFtY1RwRU4va1dPZlpqS1lXc09EQWFtRUxBaVlp?=
 =?utf-8?B?TWV4bGFiQk5sNEdCMUdFTEVwV1h4Yk5LeXZOSzNjNU1kRVNFNmptMEt4VWZR?=
 =?utf-8?B?MnBaNW5iZkF2U2ZoQnhtQVhnTytGeDhuODFhclhVVFgwL1ZTekoxWkZLTVZ4?=
 =?utf-8?B?VUpJUFRJTmRFb1NFcFVqWThrL29WZVp6YW50Q3ZMRWJZT2pvMmMyUDcwN005?=
 =?utf-8?B?U05wUnpaL2tEa0wrdlQybW1ETUhNYzRSMHhFbFJKUkg5amFjNFN2MEJ2eUl1?=
 =?utf-8?B?cFBKbU0vUGtYQmlENld4ekpGd1d4ZjNZVllOYk1GRlhjRWpnQmZLc2N1Tmd6?=
 =?utf-8?B?WERzQnJMb0ExbXhkbGNmVHVkU1FSMGU5bkNOcVYzSHJ0QndNTm03U3JYd01F?=
 =?utf-8?B?bXUvdWc4TERqYi9lTUdIMkpRYlovSG5oa2hpTjIzS1Y3UDVjMm5hMXgvWTdi?=
 =?utf-8?B?VnIrZDVIWTNFK1JLNVNseWl0L1NPUVdFQjVhaVdVeWtwV0szN3hndDVGUXll?=
 =?utf-8?B?VWJWZ2hsQk1WQWUyRExVSzBrTStyVFBzZ1RDVmtuckoxRW1QMldKQWxMNk9L?=
 =?utf-8?B?bnlHNitFUkxtOVBsMjJMRDZZNVlKZHpEVW1DQS9CSTA1dmk2NVh1NUlyTTU3?=
 =?utf-8?B?cEFncXRSTUh2R2FCU2xUNFhQa0RabFc5L2FnT2FSRlYvM1BaS01Ocks5UEdw?=
 =?utf-8?B?cHNIMWdDSTZrdUdITkhiWUlmZ0lBTFdIUlNaSlVQL2lqT1U1KzNoWVR0NEtF?=
 =?utf-8?B?TGZ0cHB2ZnhxM1ZUQTRHZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE5wd2xHVm5UNTdnS29wWCtJeTBtTFFGVWZweFJCYWxUdlhWdTlob0JCQ0gv?=
 =?utf-8?B?dHZXR0NwNmFEYkc2SXdITzhid3d5RWM5eXlGeXl5c2tqUWtUSXR1dDhrcHkr?=
 =?utf-8?B?Nlp4YkhpMDNWdjVoQWNPTHF0bzRoRzM0REZVWWczRFdkNS94ZExab1U3QTRG?=
 =?utf-8?B?RVpOenhBY0NWMGM4ZUwvSkl0ZnlIbmEramtDUC9jaDlTWFlCME5hQXlORi9h?=
 =?utf-8?B?THVlb0tlMnF6QUJFakxmdEFESUl4cXNSZ2dDcjNJQU40Y3dxdHFlR0RiZlda?=
 =?utf-8?B?NEFnWW1NV1M5Q2FNZHcwZnpnM1lGdFRISDlOQzljQmIrUHVhOTI5WWQ4SGRZ?=
 =?utf-8?B?MGV3NVVIWkhEdnUrM3RHY3c3TWRGNVlHMjVHOEdVN0I3bGxDWVB0OVExalQ2?=
 =?utf-8?B?R3NQVnJRM1Jrbm13ZTV3d2lidnV5bkVQV0lQSXh1NXZoektWY2Y4K0hXTnA2?=
 =?utf-8?B?aEM2WENmS21OMXhoK241cUFvVmxleHJVQ1pnL3B1bFlqVWlHWVhqWjQreVVj?=
 =?utf-8?B?UGgyTHlhWkVUUmRWcFc1ZjBxNnExR0NXbVRJcDZTcGt1WmNYVnRvVVFqWVdz?=
 =?utf-8?B?NnFCc2tIMjUyWXRRaXBxa0doVWxWTVduNmtKRVo1b0J1c1hhSEtKVTQ4UGVX?=
 =?utf-8?B?bXdCTE45UVhuVmxCVmVhTlc3Y1BtczNseHh4NDFPUEp4UDBjbWRnUFIwbVM4?=
 =?utf-8?B?NHV0SVVuS2FTUWxodHMxMUdHaFFqVjlLQUxtUGgxVSt0MDAycXgzV1FBcmhi?=
 =?utf-8?B?N284TytjNHNNOVVQd1RjM1M2ZkJIZTBaeEU1aDhLd0JnY2IwTXJmUFBCYWZF?=
 =?utf-8?B?bGd4OW5VZzJ3RWNDYWt6V0VaLzR6TWVkcU1wNEdlU3dSenpuYno5dWlsdDhF?=
 =?utf-8?B?RVBOc01ia1RqVVR1NzFyVzBjQWdYY3JUdzZ5a281RVBWNXhiNVE1NVVYWUl0?=
 =?utf-8?B?MHNEREFCTzUzSVU5MTRJOTh4aGNKaWtFbCt4VmdmcVFkVlFXZWF5eEltY0RF?=
 =?utf-8?B?RlMvUkZZNzM5UEpPQkFZYjg5MFVEU0pjWFZzMk5kRWlQUndmVTViRW9SMUhn?=
 =?utf-8?B?WHo0R3Z1bmYyN2FYT1lxS3VaZFV4RmhJemdHaW9KZ1BFQVNQenNDWVJZMXUv?=
 =?utf-8?B?NDFDM1RvelUxVUVsdkI1YWFmc0lGZ25yK1RnVXRqL0U0SktNUXBaUWdMQ0lD?=
 =?utf-8?B?eVEzMXA0Z0NCdng5Mk50YmZXWWE4V1JycEpjcnh5OWJTMnlNN0JQNGYyODJS?=
 =?utf-8?B?SHAxL0FjVUhEVFpZSWtHYWR2RW1YTldhN3RjRWxiU1Ywak9teTB4L2ZwME5R?=
 =?utf-8?B?UXVsRXFBZHhXdDFVT0JVL2hVRzdiNG5TYnZub29YRE9McklVT2J2VHZwNWhv?=
 =?utf-8?B?MHVRWWJRNUZ0VEtaRXBaaHhYYmV5QlB2d3phbUJPQkRYcUFMQk9lQ1Y1d2hY?=
 =?utf-8?B?RkZZNDhLeUc2UnBIOW5Kak1DQ1U0OGJFQzhBa3lEc2kwL0dldExVdWRqYVhM?=
 =?utf-8?B?R0VqYjBlM3FjZWRnWjBDWnh1TFYzOFAwNGt6NTNjdU1INDhsTFlKZGxhcXdy?=
 =?utf-8?B?NW1TWFB6NjIzbHJJUWZZa09hRzNBdUNBeW1weHFiSjJwK0tyUi9VUlBSMXNv?=
 =?utf-8?B?TEIrWXZVcGJXeTdpZ1BGSzJCU1orZDVEV21Mdkc2Tk1SYWs2VW1MbUZJUjdQ?=
 =?utf-8?B?Mm1vVW5aZlN3Ti9ycFBaZzVTZVVsalovbjd1VGhJMW1rWlJNVjdEVUo1Y25v?=
 =?utf-8?B?NUJqZmVVd0tadkEwZlZPYU8xeHU1dUpTbjhRdnAzV1U0TWhhOCtWb0FpTDBR?=
 =?utf-8?B?QVpkVGxxL0NYS0FNM1RhRTJLc002YThuTm8rSEcycUpScHRVeGxKWDBVUDNT?=
 =?utf-8?B?bmNkZ0gweW9TU1dXOVhYbCtYQ1plaDZLNERLMWh0Nmd3U2ZyZDcxZG1lTVZt?=
 =?utf-8?B?MVlxZGdHZk5nNEM2U0xwMGwyZjZCNlkzL1hGM2hENG1kQkV4ZmxseTNjTFdR?=
 =?utf-8?B?a1YwN2lrMlp5bzMzZkR0cHVsOGdrcmVBUURibFNDNER6UnJRWHlzdmtaTFhk?=
 =?utf-8?B?dnVZZFA1NDhhbnducklPZVJvY2JoWnlXeTNSR0VZaFdsZXpXRFljYzZaUGk5?=
 =?utf-8?B?Ukh5K2UrSGpwS2ZZZWxKMGtiY1dlWjZSUFJKS1MwdzNzNjcrU2lHK2I1eGpH?=
 =?utf-8?B?Smc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1843899-77a8-4faf-9e96-08dcd91bb2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 02:26:56.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiDiYs5TrNG6LJsZOF16eBzyvG0jFMml4EKth73enk9YI45C8h5dhYK8PTqeT1vMkJzHetoEPzcjrCRRMk+GX+wr0ORucEty9nTbtKsSTh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8592
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjksIDIwMjQgNTowNyBQTQ0K
PiBUbzogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gQ2M6IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBoYW5uZXNAY21weGNoZy5v
cmc7DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNv
bT47DQo+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBab3Us
IE5hbmhhaQ0KPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLIDx3YWpk
aS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsNCj4gR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwLzNdIG1tOiBaU1dBUCBzd2FwLW91
dCBvZiBtVEhQIGZvbGlvcw0KPiANCj4gT24gVGh1LCBBdWcgMjksIDIwMjQgYXQgNDo1NeKAr1BN
IFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
T24gVGh1LCBBdWcgMjksIDIwMjQgYXQgNDo0NeKAr1BNIE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFp
bC5jb20+DQo+IHdyb3RlOg0KPiA+IEkgdGhpbmsgaXQncyBhbHNvIHRoZSBmYWN0IHRoYXQgdGhl
IHByb2Nlc3NlcyBleGl0IHJpZ2h0IGFmdGVyIHRoZXkNCj4gPiBhcmUgZG9uZSBhbGxvY2F0aW5n
IHRoZSBtZW1vcnkuIFNvIEkgdGhpbmsgaW4gdGhlIGNhc2Ugb2YgU1NELCB3aGVuIHdlDQo+ID4g
c3RhbGwgd2FpdGluZyBmb3IgSU8gc29tZSBwcm9jZXNzZXMgZ2V0IHRvIGV4aXQgYW5kIGZyZWUg
dXAgbWVtb3J5LCBzbw0KPiA+IHdlIG5lZWQgdG8gZG8gbGVzcyBzd2FwcGluZyBvdXQgaW4gZ2Vu
ZXJhbCBiZWNhdXNlIHRoZSBwcm9jZXNzZXMgYXJlDQo+ID4gbW9yZSBzZXJpYWxpemVkLiBXaXRo
IHpzd2FwLCBhbGwgcHJvY2Vzc2VzIHRyeSB0byBhY2Nlc3MgbWVtb3J5IGF0IHRoZQ0KPiA+IHNh
bWUgdGltZSBzbyB0aGUgcmVxdWlyZWQgYW1vdW50IG9mIG1lbW9yeSBhdCBhbnkgZ2l2ZW4gcG9p
bnQgaXMNCj4gPiBoaWdoZXIsIGxlYWRpbmcgdG8gbW9yZSB0aHJhc2hpbmcuDQo+ID4NCj4gPiBJ
IHN1Z2dlc3RlZCBrZWVwaW5nIHRoZSBtZW1vcnkgYWxsb2NhdGVkIGZvciBhIGxvbmcgdGltZSB0
byBldmVuIHRoZQ0KPiA+IHBsYXlpbmcgZmllbGQsIG9yIHdlIGNhbiBtYWtlIHRoZSBwcm9jZXNz
ZXMga2VlcCBsb29waW5nIGFuZCBhY2Nlc3NpbmcNCj4gPiB0aGUgbWVtb3J5IChvciBwYXJ0IG9m
IGl0KSBmb3IgYSB3aGlsZS4NCj4gPg0KPiA+IFRoYXQgYmVpbmcgc2FpZCwgSSB0aGluayB0aGlz
IG1heSBiZSBhIHNpZ25hbCB0aGF0IHRoZSBtZW1vcnkuaGlnaA0KPiA+IHRocm90dGxpbmcgaXMg
bm90IHBlcmZvcm1pbmcgYXMgZXhwZWN0ZWQgaW4gdGhlIHpzd2FwIGNhc2UuIE5vdCBzdXJlDQo+
ID4gdGJoLCBidXQgSSBkb24ndCB0aGluayBTU0Qgc3dhcCBzaG91bGQgcGVyZm9ybSBiZXR0ZXIg
dGhhbiB6c3dhcCBpbg0KPiA+IHRoYXQgY2FzZS4NCj4gDQo+IFllYWggc29tZXRoaW5nIGlzIGZp
c2h5IHRoZXJlLiBUaGF0IHNhaWQsIHRoZSBiZW5jaG1hcmtpbmcgaW4gdjQgaXMgd2FjazoNCj4g
DQo+IDEuIFdlIHVzZSBsejQsIHdoaWNoIGhhcyBhIHJlYWxseSBwb29yIGNvbXByZXNzaW9uIGZh
Y3Rvci4NCj4gDQo+IDIuIFRoZSBzd2FwZmlsZSBpcyByZWFsbHkgc21hbGwsIHNvIHdlIG9jY2Fz
aW9uYWxseSBzZWUgcHJvYmxlbXMgd2l0aA0KPiBzd2FwIGFsbG9jYXRpb24gZmFpbHVyZS4NCj4g
DQo+IEJvdGggb2YgdGhlc2UgZmFjdG9ycyBhZmZlY3QgYmVuY2htYXJraW5nIHZhbGlkaXR5IGFu
ZCBzdGFiaWxpdHkgYQ0KPiBsb3QuIEkgdGhpbmsgaW4gdGhpcyB2ZXJzaW9uJ3MgYmVuY2htYXJr
cywgd2l0aCB6c3RkIGFzIHRoZSBzb2Z0d2FyZQ0KPiBjb21wcmVzc29yICsgYSBtdWNoIGxhcmdl
ciBzd2FwZmlsZSAoYWxiZWl0IG9uIHRvcCBvZiBhIFpSQU0gYmxvY2sNCj4gZGV2aWNlKSwgd2Ug
bm8gbG9uZ2VyIHNlZSBtZW1vcnkuaGlnaCB2aW9sYXRpb24sIGV2ZW4gYXQgYSBsb3dlcg0KPiBt
ZW1vcnkuaGlnaCB2YWx1ZS4uLj8gVGhlIHBlcmZvcm1hbmNlIG51bWJlciBpcyB3YWNrIGluZGVl
ZCAtIG5vdCBhDQo+IGxvdCBvZiB2YWx1ZXMgaW4gdGhlIGNhc2UgMiBzZWN0aW9uLg0KDQpIb3Bl
ZnVsbHkgdGhlIGxhdGVzdCBkYXRhIGZyb20gdGhlIHR3byBzZXRzIG9mIGV4cGVyaW1lbnRzICg0
RyBTU0Qgd2l0aA0KdXNlbWVtIC0tc2xlZXAgMTAsIGFuZCAxNzlHIFNTRCkgc2hvdWxkIG1ha2Ug
YmV0dGVyIHNlbnNlPw0KDQpUaGFua3MsDQpLYW5jaGFuYQ0K

