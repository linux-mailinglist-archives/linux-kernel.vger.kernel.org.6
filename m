Return-Path: <linux-kernel+bounces-333913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B4F97CFCF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91666283F13
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE8BB669;
	Fri, 20 Sep 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMAGSwTN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9AAD5E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726797467; cv=fail; b=IoKjdHDsXMI2n2NWRBMChpm0ZXr69PGqA4Alqxp9CPdTEBJIaZtShXOTXcYgCI4I5HI7mbZZg5krCxugsaJDg4Xe8CUmzqblaiveypAJ/g3Rlh1YIwrEtT1cQQRtlh9RckNuvd+fNHjrcilJcktvOnzOYJqRAyLZwuFyWWm37+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726797467; c=relaxed/simple;
	bh=1rrYCifsarT0/7syHeGy/QEM0zRmwvR5FVm6UqHhiIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RGLYLna4PnkA4wgoERLZGZt3N5JMC9XxZ/5fFngDwavIJcGYyAyZg8bNXK3NPwULCInrWp0WdmvcWqE5xUp2HRthdaBnXp7urs6nbTsjtkIEqGL9zjCyNSRnAEgnyiYgikh7NJUJQO/UFcKzGatwt2viH/Rn6xBCucnQu3vnO5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMAGSwTN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726797465; x=1758333465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1rrYCifsarT0/7syHeGy/QEM0zRmwvR5FVm6UqHhiIY=;
  b=nMAGSwTN1gI1/OtWY2wUodZhwcfCINKHlZ+zWiSY+HNcBAKsfOCGHkrn
   B2zP6/meeN1Up2RqZgwPT9oKZxav2dSJVkj/6ICWkOeZtyTRJ0BiPIU9N
   iLeEEpKXom5d0p1iW1yjN9uz+umoL7hO+VlOOvRjD1uYZxRJMgeV/02T8
   Lage6NW/1WuO6oKBg+s872a4ULnl2eTZU9AyyZohBGvQJ+RSJstoMC2SR
   S3KM85LxJEhDOpHc0NdJ2hgjINo1cZxzjjacb4hiAE8UCkt6yiykYQruu
   tBPCVxSPyf6uvR+xay2Dx5FqTrfEMa3sVqZKHLZcQrUjd0Z4UTOVQTxL6
   g==;
X-CSE-ConnectionGUID: ctVBVBn4SGKb3pAXGJTvZQ==
X-CSE-MsgGUID: ao1v37viTFqEaFvxK0Cw1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="48324049"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="48324049"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 18:57:45 -0700
X-CSE-ConnectionGUID: jn010nWuRU+MozTZIDmdkw==
X-CSE-MsgGUID: 4lvc5iRcTxmiFcf5Hv9dqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="70440253"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 18:57:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 18:57:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 18:57:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 18:57:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 18:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSn5gAPohlnMGNQE9Iaz1XgaMM+BQJFhaQtG3N8WhVyji0+W+21/mDQG7/4iGzMd+w9yO8DfKmY/zHOfrv+UI10a8LsL+xwoEoZERd+e/rrPo41m6zH9MqUTGl017jW36FzVh7rytqoaVvfM/H8Fn2ruSkiQ8ve9PxsgPcyxgKq4rJQq2A285oDKxJvG+j7RUK/Gt2a53TRsEy/F2+3Ys4pHh47/qyh2eU5vWf/gbCFA41DpWLFNpnr//HTvDij9180D2ShWg1N6fJf8HiAz2w7FQzaFnCCZ31vM6P9xIIqA0uap0DBzZhRcADIJD6+DOOzWPeatmhEjDcvQLpKCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rrYCifsarT0/7syHeGy/QEM0zRmwvR5FVm6UqHhiIY=;
 b=rv0iMYiaC1XKoicGuxl8N5mO/RrH5t/Rrnu/zFlm22yaWxJUWlMWYGHYylgYxMMnSVzlhCNHrbBRp0g0Bt8Rul9Ca3j05dpjSuwgsGTwKGNPArEinC5fBNfee6xkVqrzWoH3EM+blRVIJU6f72DcE+6hGPbqMaQSQJBEChoJlt1YDbvb1BrKoCOQskzggTpKFt9ECmLMQ93AnZoOvYcA9/cKUmZ7FPNecjzXS/hMfvL4ubyVda7zWb9U8JQ6Bm9xzM5fhTpNzsNoyW3z29vH5aeOx2VHnP7QAmj0V0JdUvBoQE1W4/5htBixhQdpnjmvrEBhXfjgyLfPna6jke9Q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM6PR11MB4532.namprd11.prod.outlook.com (2603:10b6:5:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 01:57:40 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 01:57:40 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 2/3] mm: zswap: zswap_store() extended to handle mTHP
 folios.
Thread-Topic: [PATCH v6 2/3] mm: zswap: zswap_store() extended to handle mTHP
 folios.
Thread-Index: AQHa+lo9Qlgs2c514UiQAzp2na76F7I+23MAgCEseMA=
Date: Fri, 20 Sep 2024 01:57:39 +0000
Message-ID: <SJ0PR11MB56780D9A3812BC08E3B7A461C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
 <CAJD7tkZih11jpzAGM=hVdRtBtjmdynpfSXv6fP8B8gnzoj3G=Q@mail.gmail.com>
In-Reply-To: <CAJD7tkZih11jpzAGM=hVdRtBtjmdynpfSXv6fP8B8gnzoj3G=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM6PR11MB4532:EE_
x-ms-office365-filtering-correlation-id: 16ae375d-753d-4c0e-91be-08dcd9179bc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bG44ME9nWFI0MFU3aHVVZXdjVEMraUJrY1MwMkNCU2htOU10alY2OHpoNVo2?=
 =?utf-8?B?bE81V1ppUS80bzRlMTVnTlVlSE1VZU9DYnZCaHVXeWZ5NjVQSDdSSEwrcmFD?=
 =?utf-8?B?eUk3ZU0yMTZBQXdhNlJoSkRWSDY0Z011Wi9yUENneGo3d2ovMnRXN1g3cHNB?=
 =?utf-8?B?ZTZvWnNCTHRYamtuNWpiVG5aejFobFZuUHBSNnRLemZSMFNPUTF3cTUwNkZB?=
 =?utf-8?B?bUZjWHZXQVlmNWNSbUVIdFlRSVVMZjk1S0JIY0lPcGE0bmdlSTFqb0N4WTM1?=
 =?utf-8?B?NHdHdDVTVmNpbnlyOEF1cGxWUHVpL1ZweURIWTlBR0lybHFOOFNMNEtVVjk2?=
 =?utf-8?B?aWlSbzV2K0FobitobkNJV0liVmwwcW9RNXg2c3E0d2x3cmZYM2FYVzk4SCta?=
 =?utf-8?B?OVpsbis3MjhpN0VybC81ZFhmTnR0V2V1amJlUnk4ejB4dEJkM091b2RrZ2d1?=
 =?utf-8?B?emhUMFJQL2dhazUxcWgrZTR4dUEvb0lJdnc0NmluNnNVb1hpZDhyQlZUaUls?=
 =?utf-8?B?YkUrZWttMnpHUG0rYytEcnJ6SFVWWkpobzJyQ2k1Q2ozYjFReWc0dzBvSHd0?=
 =?utf-8?B?YXk2SlZzZk16WldmWWwvRXMwazB2LzVVbmN5VWtNa1VUQnhuMGtzQTJYRlZX?=
 =?utf-8?B?MjZDZ2pOOXVXU21wZHZpbU8vdmR3M1JmQlN6Wkc2YzV1VFRKTEVPd2VXZ0ow?=
 =?utf-8?B?MXA1UGhJckpCRVUvdlg1NWQ3dE9LR0hvYXRvSWg1bWRlUlJTMWh0Y3VOSGth?=
 =?utf-8?B?dE1BdFpWQzVEeUZseTdBb25RK1JONlptQ0xHazQwT3haRUhKL1VsK1Q3bFQ3?=
 =?utf-8?B?U2xOYWh1THc0L3hSSUhjWVFsRW1pMmtydk5ETzNTdWZ0d1NUTHF4SFduTzVm?=
 =?utf-8?B?UFRYWGdidnNSejVXLzlPcXhxc3dWVkJ3QjE5UUtUMVViMWdZdWhMSGtJNUpw?=
 =?utf-8?B?ejE3MEtnSU5Wc3Y3T2hSN0lQalEzTTluSzlLdkRseFloTVVqYm45T013TTU0?=
 =?utf-8?B?M3I1S1RJMEM3NktjODh6V0pjd1BaS2w0VXNId24xd0VNL2RQa2Q4S0hReElC?=
 =?utf-8?B?S2hOUHo4QWpTY0plTjFEc0pQSys1OVVveXJ5dE9YK0REbHlPSncrd1FLOXVk?=
 =?utf-8?B?R1lPYXRETmNLMnNpbUtpTlh0YndzdXFiWGFVM3RBYmhiTzl0aVB5UlF4OXd5?=
 =?utf-8?B?YXJIKzgvOGdKeVJMWVlzeFphQkoxSi93MWovRjlqNGg0Z2hua3J4c1lWTnpq?=
 =?utf-8?B?SGs2ZkRia1BGQWNWcTdtTW1rVWVBZCtxSzYrdDNOdHR1ZFU3dmgzaU1pTW1x?=
 =?utf-8?B?SzRXNGR5b2lHNHFEcHN3T0lwU1cwYlJZN29BTUJjeGlxYTN3eGF3eFpjWmtm?=
 =?utf-8?B?SVNWcXRsamorVGZoT2N1cGhlSzFNbTJiZlpwZTNKNnV0UGtDYkNXbjZwM240?=
 =?utf-8?B?ay82UkFlcjhkc3lHc0VSdG40bTNkcjViei9xL1pXYmNIZFJBQWhydFBHZmU2?=
 =?utf-8?B?UGxnNVlFbzNrK2VERGVJaDhlT05tZTB0b0Q4cmlMazk4STJNbHBNZkkrOXZq?=
 =?utf-8?B?Ujdud0lVZjNsTHVEdTNjVE5MZ1ZNRmxtRmF2dEpsYW4rajBVNVZEWWx3Mndq?=
 =?utf-8?B?OFNiaGc0dkY0dUJPeFNwZ0VhK0RSTGZKMjBXMU9TYVgwMFdralgydnpjeS9m?=
 =?utf-8?B?R3VkWHZvSzNYc05kWkM4Ui83REpaUWJIYjJLRHNldDZnbVdHdnM3bXcvMUl3?=
 =?utf-8?B?SG8zdFB3Y3hnNHQvZkFDMWJ1V25FOGhuMXFGSWlnM2VhZEtYZ2h3QnZFNEZw?=
 =?utf-8?Q?LbpfA63x5brS1kqhrZkZE5nc9hM+/vpRX1RNg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REtrZ25ZbEFSUjRuNTAvaFIvUzF4NUhQa0RqWkdnYmowWThZT0dMd1VrQXdr?=
 =?utf-8?B?d0xxWG5YSnE2bXc5dlVUWmhLNE1kS2RDcXpqKzZhUjZ5VndyUVRlMmVkUkg2?=
 =?utf-8?B?b3U5VzlqWjNuQlgxOVhRNnhuVHZSMll2Z1RBU1lHMVhFVTR4Z1QvbHNRNUxY?=
 =?utf-8?B?RzVNdkFaMUxPMlZ4MEoxSXpqZEk4VXRCRkJZYnp3RTlHZS8xYXMzOWQrZXVs?=
 =?utf-8?B?ejJFZ1Y2NkNGNnVZZk50UzkxYWZyeHlJMTJBWk9OZlM2aVpITTkrUHR6SkNT?=
 =?utf-8?B?cjdZSXNUbXJJbkpFbHRQVWczYTNlNWIwQ2VJMVBvZnlta1RoU0lQQ3JXa05Y?=
 =?utf-8?B?SmNyOXhEa1JqU1JLcWVtd21BQkFwY3FRbzIreVRjME9wUEZvMHRrQWtIby81?=
 =?utf-8?B?Zld4RlpESkU0REhpQ1FaUVNXZTYvTVVHSnNoL3JENG5DS0Y3Unkvbk1XZ1V0?=
 =?utf-8?B?VzNoYzk2bGxjRkYrM2xtMXBxYy83SmQva2ZweDZ5TEhDOTdFWG93ZzJVZGgv?=
 =?utf-8?B?RkFGZmFiQkUvamFiTlV1eHRqOGp5WDRHUnIyMU9aSTNEd3p6QVZpVVpoeWpE?=
 =?utf-8?B?bk0rajQyWEo2YktNcXZTK3lBVk85cmlsTjFlSW15UFBGZ0VNbEROUWlTZGps?=
 =?utf-8?B?MExvdUkxRXV3WlVSdG9IQjNIRE51N0lBb1hYekJiSEFERloyYzZrQkVFdXVL?=
 =?utf-8?B?UDlmUGlEODlOeWZXNUJnNlpib1BsK3IzVjR3RGw4Y3N3czMrYkpiVThRVFpW?=
 =?utf-8?B?dmNDRTR1Rm5HTEZNVVo2dEM1c2NpcnZZUW5JSmtPTkRIZWxtQVRpdW4xaDEz?=
 =?utf-8?B?eW1SQnJPY1ZlWE9qTHdMOGZadzFZNUZSVTJCQVcvNkFtU3FER213QlFidjIx?=
 =?utf-8?B?NysvWHdYb3o3MVBGOGlFRnFucWRkcVkxNzFpS1JUeWtVVlgvSWdrcmEra1Vw?=
 =?utf-8?B?cjZ0OEVXWW83MS9BK2JxclFTWnRSN1dtczVPT01hNStnNUdQKzZiZXUwSHJX?=
 =?utf-8?B?eXhWQ29ibUNkdW1hS281VVMrd0k2cTVKTEVQUlNHZkJjYzdYUkIrdCtBNmo5?=
 =?utf-8?B?cDVUN0xEalU3WFRNWDZ2ZGV2WVFtSWFObW4vUVQ1enZoUXFwTW9pVzJNRGt2?=
 =?utf-8?B?a0JGODIvcnZuSEFNdVhwTTIvRzFsV0JsMlVHT3FBVm82bW5acDhPVktKdE9h?=
 =?utf-8?B?OFFDd0M4Wml5YVdWR1lhYVI3ZklPRm9RdDRjRnB1aU0rTGxGais1aWt1OU1K?=
 =?utf-8?B?dmtnVG1aSm1kMlA5ZFk3ZGFMY3B6VC9sVlBNcUtMVU90Y0FqMWxUVllCT1JD?=
 =?utf-8?B?bDFJd29vV2VSVkNpbWIwQWx2OERzQy84ZnpObForY0FOWUNycE5aVDJzYi8r?=
 =?utf-8?B?YmFFN1NxdmhkSTZkdGtOb2xuaE9aYUt5dE9mSG1QUGdaejFHL0JlNkZqUEJV?=
 =?utf-8?B?NlZMSE80RnByRmgyVE1rb1RPeituZjNCa0NFSFpDK0o2Z0haS2Y5RHBiSFlX?=
 =?utf-8?B?T1piVGUxY1E4SCtSM2VObmtDTzl6R2tvOFBLQ1Vaa2JDWWFlbm1FYm5PNXBR?=
 =?utf-8?B?SUxyQWxTamNQR1ltbHlyQTNhb2N3Q3VFZk8rcFU2RzBmalRZUXI3d2xtZ0VF?=
 =?utf-8?B?TngrZWQwRGVHT212ZDJYcno2UmIzZ2xCRnpyaUY2VVV3R2JURDFyT2RkSGJW?=
 =?utf-8?B?WlYrQzNvUzl2SGpJVWNaQS8raGZ1Q1FpZUZRVWE0dG1oRmFlYnhxNGhNL3pR?=
 =?utf-8?B?bVUwSXplbzFyVDNQUThtZ0JFZnVwRVBrUUkra2RaU1BvMW5VQklwaEFkamI3?=
 =?utf-8?B?TFlUQy9HUTBuc21KenVFRnNTU2Q0YnYvVVJYUy85MlN3bU5RdThkcXc4Y3dN?=
 =?utf-8?B?N2RrcnpJNFJVUkd6bVNPM3JOcnZVM3ErWGtzT0lhdzhET3JmNzE0ZGdKdGVK?=
 =?utf-8?B?Uk5MVnR0d0NhM1RnL2pkQ2swYTNnTFpZZ3l3aXVsZFN5ZjArL1cyQTlRbWdS?=
 =?utf-8?B?VnNZVUc5dWFDaGdUdWx6U1VhQjY2S005TS95NkJyUzR3TVZBckNWbjkzSTA3?=
 =?utf-8?B?YVJtaWdJdzMzcTVYQTRsamRqT1hxeXplcWMyZ3c1SVpsNUpPZUZmRHo1R3lj?=
 =?utf-8?B?dDFrMG5YVXJpK0UzVE9BUWVldHQwM1V0RVZIQUF1YzdiNVFVakUrZHd4aUQv?=
 =?utf-8?B?blE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ae375d-753d-4c0e-91be-08dcd9179bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 01:57:39.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6fHzZyNhIIt/emGh4oPUdVi/kz8ScblR7ks/35/EFP1jti2KV5L+SDm1i92JgmWz0CmRke3nyvz8s5Hswvp2QONm2ZCUTApgRlGREnZf+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4532
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI5LCAyMDI0IDQ6MDYg
UE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5j
b20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5v
cmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWluZy56
aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRzQGFy
bS5jb207IEh1YW5nLCBZaW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21h
aWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBab3UsIE5hbmhhaSA8bmFuaGFp
LnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50
ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NiAyLzNdIG1tOiB6c3dhcDogenN3YXBfc3RvcmUoKSBleHRlbmRlZCB0
byBoYW5kbGUNCj4gbVRIUCBmb2xpb3MuDQo+IA0KPiBPbiBUaHUsIEF1ZyAyOSwgMjAyNCBhdCAy
OjI34oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFyDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPiB3cm90ZToNCj4gPg0KPiANCj4gSSB0aGluayAibW06IHpzd2FwOiBzdXBwb3J0IG1USFAg
c3dhcG91dCBpbiB6c3dhcF9zdG9yZSgpIiBpcyBhIGJldHRlcg0KPiBzdWJqZWN0LiBXZSB1c3Vh
bGx5IHVzZSBpbXBlcmF0aXZlIHRvbmUgZm9yIGNvbW1pdCBsb2dzIGFzIG11Y2ggYXMNCj4gcG9z
c2libGUuDQoNClN1cmUsIHRoaXMgaXMgYSBtdWNoIGJldHRlciBzdWJqZWN0LCB0aGFua3MhIEkg
d2lsbCBtYWtlIHRoaXMgY2hhbmdlIGluIHY3Lg0KDQo+IA0KPiA+IHpzd2FwX3N0b3JlKCkgd2ls
bCBub3cgcHJvY2VzcyBhbmQgc3RvcmUgbVRIUCBhbmQgUE1ELXNpemUgVEhQIGZvbGlvcy4NCj4g
Pg0KPiA+IEEgbmV3IGNvbmZpZyB2YXJpYWJsZSBDT05GSUdfWlNXQVBfU1RPUkVfVEhQX0RFRkFV
TFRfT04gKG9mZiBieQ0KPiBkZWZhdWx0KQ0KPiA+IHdpbGwgZW5hYmxlL2Rpc2FibGUgenN3YXAg
c3RvcmluZyBvZiAobSlUSFAuDQo+ID4NCj4gPiBUaGlzIGNoYW5nZSByZXVzZXMgYW5kIGFkYXB0
cyB0aGUgZnVuY3Rpb25hbGl0eSBpbiBSeWFuIFJvYmVydHMnIFJGQw0KPiA+IHBhdGNoIFsxXToN
Cj4gPg0KPiA+ICAgIltSRkMsdjFdIG1tOiB6c3dhcDogU3RvcmUgbGFyZ2UgZm9saW9zIHdpdGhv
dXQgc3BsaXR0aW5nIg0KPiA+DQo+ID4gICBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtbW0vMjAyMzEwMTkxMTA1NDMuMzI4NDY1NC0xLQ0KPiByeWFuLnJvYmVydHNAYXJtLmNvbS9U
LyN1DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHByb3ZpZGVzIGEgc2VxdWVudGlhbCBpbXBsZW1lbnRh
dGlvbiBvZiBzdG9yaW5nIGFuIG1USFAgaW4NCj4gPiB6c3dhcF9zdG9yZSgpIGJ5IGl0ZXJhdGlu
ZyB0aHJvdWdoIGVhY2ggcGFnZSBpbiB0aGUgZm9saW8gdG8gY29tcHJlc3MNCj4gPiBhbmQgc3Rv
cmUgaXQgaW4gdGhlIHpzd2FwIHpwb29sLg0KPiA+DQo+ID4gVG93YXJkcyB0aGlzIGdvYWwsIHpz
d2FwX2NvbXByZXNzKCkgaXMgbW9kaWZpZWQgdG8gdGFrZSBhIHBhZ2UgaW5zdGVhZA0KPiA+IG9m
IGEgZm9saW8gYXMgaW5wdXQuDQo+ID4NCj4gPiBFYWNoIHBhZ2UncyBzd2FwIG9mZnNldCBpcyBz
dG9yZWQgYXMgYSBzZXBhcmF0ZSB6c3dhcCBlbnRyeS4NCj4gPg0KPiA+IElmIGFuIGVycm9yIGlz
IGVuY291bnRlcmVkIGR1cmluZyB0aGUgc3RvcmUgb2YgYW55IHBhZ2UgaW4gdGhlIG1USFAsDQo+
ID4gYWxsIHByZXZpb3VzIHBhZ2VzL2VudHJpZXMgc3RvcmVkIHdpbGwgYmUgaW52YWxpZGF0ZWQu
IFRodXMsIGFuIG1USFANCj4gPiBpcyBlaXRoZXIgZW50aXJlbHkgc3RvcmVkIGluIFpTV0FQLCBv
ciBlbnRpcmVseSBub3Qgc3RvcmVkIGluIFpTV0FQLg0KPiA+DQo+ID4gVGhpcyBmb3JtcyB0aGUg
YmFzaXMgZm9yIGJ1aWxkaW5nIGJhdGNoaW5nIG9mIHBhZ2VzIGR1cmluZyB6c3dhcCBzdG9yZQ0K
PiA+IG9mIGxhcmdlIGZvbGlvcywgYnkgY29tcHJlc3NpbmcgYmF0Y2hlcyBvZiB1cCB0byBzYXks
IDggcGFnZXMgaW4gYW4NCj4gPiBtVEhQIGluIHBhcmFsbGVsIGluIGhhcmR3YXJlLCB3aXRoIHRo
ZSBJbnRlbCBJbi1NZW1vcnkgQW5hbHl0aWNzDQo+ID4gQWNjZWxlcmF0b3IgKEludGVsIElBQSku
DQo+ID4NCj4gPiBBbHNvLCBhZGRyZXNzZWQgc29tZSBvZiB0aGUgUkZDIGNvbW1lbnRzIGZyb20g
dGhlIGRpc2N1c3Npb24gaW4gWzFdLg0KPiA+DQo+ID4gTWFkZSBhIG1pbm9yIGVkaXQgaW4gdGhl
IGNvbW1lbnRzIGZvciAic3RydWN0IHpzd2FwX2VudHJ5IiB0byBkZWxldGUNCj4gPiB0aGUgY29t
bWVudHMgcmVsYXRlZCB0byAidmFsdWUiIHNpbmNlIHNhbWUtZmlsbGVkIHBhZ2UgaGFuZGxpbmcg
aGFzDQo+ID4gYmVlbiByZW1vdmVkIGZyb20genN3YXAuDQo+IA0KPiBUaGlzIGNvbW1pdCBsb2cg
aXMgbm90IG9yZGVyZWQgY2xlYXJseS4gUGxlYXNlIHN0YXJ0IGJ5IGRlc2NyaWJpbmcNCj4gd2hh
dCB3ZSBhcmUgZG9pbmcsIHdoaWNoIGlzIGJhc2ljYWxseSBtYWtpbmcgenN3YXBfc3RvcmUoKSBz
dXBwb3J0DQo+IGxhcmdlIGZvbGlvcyBieSBjb21wcmVzc2luZyB0aGVtIHBhZ2UgYnkgcGFnZS4g
VGhlbiBtZW50aW9uIGltcG9ydGFudA0KPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIGFuZCB0aGUg
dHVuYWJlbCBhbmQgY29uZmlnIG9wdGlvbnMgYWRkZWQgYXQgdGhlDQo+IGVuZC4gQWZ0ZXIgdGhh
dCwgcmVmZXIgdG8gdGhlIFJGQyB0aGF0IHRoaXMgaXMgYmFzZWQgb24uDQoNClRoYW5rcyBmb3Ig
dGhlc2UgY29tbWVudHMuIFN1cmUsIEkgd2lsbCBpbmNvcnBvcmF0ZSBpbiB2Ny4NCg0KPiANCj4g
Pg0KPiA+IENvLWRldmVsb3BlZC1ieTogUnlhbiBSb2JlcnRzDQo+ID4gU2lnbmVkLW9mZi1ieToN
Cj4gDQo+IFRoaXMgaXMgcHJvYmFibHkgc3VwcG9zZWQgdG8gYmUgIlNpZ25lZC1vZmYtYnk6IFJ5
YW4gUm9iZXJ0cyIuIEkgYW0NCj4gbm90IHN1cmUgd2hhdCB0aGUgcG9saWN5IGlzIGZvciByZXVz
aW5nIHBhdGNoZXMgc2VudCBlYXJsaWVyIG9uIHRoZQ0KPiBtYWlsaW5nIGxpc3QuIERpZCB5b3Ug
dGFsayB0byBSeWFuIGFib3V0IHRoaXM/DQoNCllvdSdyZSByaWdodCwgdGhpcyBpcyBpbnRlbmRl
ZCB0byBiZSAiU2lnbmVkLW9mZi1ieTogUnlhbiBSb2JlcnRzIiBvbmNlDQpSeWFuIGhhcyBoYWQg
YSBjaGFuY2UgdG8gcmV2aWV3IGFuZCBpbmRpY2F0ZSBhcHByb3ZhbCBvZiBhdHRyaWJ1dGlvbg0K
YXMgY28tYXV0aG9yLg0KDQpJIGhhdmUgYmVlbiBmb2xsb3dpbmcgdGhlIGRvY3VtZW50YXRpb24g
Z3VpZGVsaW5lcyBmb3Igc3VibWl0dGluZw0KcGF0Y2hlcywgYXMgcGVydGFpbmluZyB0byBjby1k
ZXZlbG9wbWVudC4gUnlhbiBpcyBpbiB0aGUgcmVjaXBpZW50cyBsaXN0DQphbmQgSSBhbSBob3Bp
bmcgaGUgY2FuIGluZGljYXRlIGhpcyBhcHByb3ZhbCBmb3IgdGhlIHJldXNlIG9mIGhpcyBvcmln
aW5hbA0KUkZDLg0KDQpSeWFuLCBJIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSB5b3VyIGlucHV0
cyBvbiB0aGUgcmV1c2Ugb2YgeW91ciBSRkMsDQphbmQgYWxzbyBhbnkgY29kZSByZXZpZXcgY29t
bWVudHMgZm9yIGltcHJvdmluZyB0aGUgcGF0Y2hzZXQhDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiAN
Cj4gVGhlIGRpZmYgaXMgaGFyZCB0byBmb2xsb3cgYmVjYXVzZSB0aGVyZSBpcyBhIGxvdCBvZiBy
ZWZhY3RvcmluZyBtaXhlZA0KPiBpbiB3aXRoIHRoZSBmdW5jdGlvbmFsIGNoYW5nZXMuIENvdWxk
IHlvdSBwbGVhc2UgYnJlYWsgdGhpcyBkb3duIGludG8NCj4gcHVyZWx5IHJlZmFjdG9yaW5nIHBh
dGNoZXMgZG9pbmcgdGhlIGdyb3VuZHdvcmssIGFuZCB0aGVuIHRoZSBhY3R1YWwNCj4gZnVuY3Rp
b25hbCBjaGFuZ2UgcGF0Y2goZXMpIG9uIHRvcCBvZiB0aGVtPw0KDQpTdXJlLCBJIHdpbGwgZG8g
dGhpcyBhbmQgc3VibWl0IGEgdjcuIEFwcHJlY2lhdGUgeW91ciBjb21tZW50cyENCg0KVGhhbmtz
LA0KS2FuY2hhbmENCg0KPiANCj4gVGhhbmtzIQ0K

