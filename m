Return-Path: <linux-kernel+bounces-364083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E5E99CAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E0B280DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119481A7AF7;
	Mon, 14 Oct 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3zxw9zC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD216190B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911113; cv=fail; b=Nsl6yKbr37ZbWn52JFDN9AUf58OaQK11ZJ419wV2DXTxRHNiphzO9JaHgulMNR2brYrx8GGoPSB0IHA6eKzm8Jo590xpe1B/SFKTfLIE9TmV+z8KtMltTazPqcApc64Mklr2z3cxt7VLUe/y/cpZxddWXKoBImpbfzZp0097mLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911113; c=relaxed/simple;
	bh=nxHABzq5WW+MU+fMEmJS6eD8itbd9s1P3Jl9ZefAYGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMf9Iiof8JmHpcl56NJi1fXb4nW/E3LGwN4vALPGQ7RdJRNO2nM/UVgIwQ6nPkD85TwguVk5/HaMxpxUIrFvEFTatCSWnZNo/oUa8dPq4p12e3V4BWfYquqYjG32to0cQJ76hbluuLMIbKvDxipXJjuRiw0lswVEvNCMTbTHFaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3zxw9zC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728911112; x=1760447112;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nxHABzq5WW+MU+fMEmJS6eD8itbd9s1P3Jl9ZefAYGI=;
  b=h3zxw9zCMDAfjdTHFY4g9UPhNm+fRWFjPMwCqZf6UfTMdoaP9BULFGgN
   8zFmV17ptCbHuR9P4+/b8atsYGL79anIr3t5ZJ1sKdTlwa/VCPF0zyfQ7
   hWEt4wIGBllsZk5WF852zE4kED3BqrqjtDjV74t2YKssy9r/3qMWc3NMI
   ph1AvF1CtjS6yj7lHpL+d5SB0/vu/NIh2XFQJjB8dwz6EmiYR+OS7t2FF
   nibAPtr62E0jgyE2kBJaWzHfs0BFr8SY7WGy28siZCm/jvWd1e/F+jvnb
   Rs+ugzRtIQMtRrafnv5WvsoLnv3E68eyoaB7vIgIp30tXwXszf66HEvHO
   A==;
X-CSE-ConnectionGUID: 7SB7hn8MQIqgvDWlY1aC0Q==
X-CSE-MsgGUID: FwypUKDRTjGmAM/PkEemNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28350689"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28350689"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 06:05:11 -0700
X-CSE-ConnectionGUID: oEUBZXJ5QAueBtQzdyyAiA==
X-CSE-MsgGUID: GlqUubPNTla5Nz6G3TxLUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="77912203"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 06:05:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 06:05:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 06:05:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 06:05:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jj9s52ly8sq32M3jEmHRdNI7QeYqeICXXLlCZKcYuC8ZKgG0C6R430IqWNYFxmTXID+M/ugTfLM5JNo8lsnIi6tskaJMeFJhOGhmjN4yd9QhCri78VRIo6/SdY+Gs92gTvOBOhmcRkle7emdNc08VwAekeEEiplQ2DZNI9SLqr/q2YkGBrqWOCpyTY+jTMFqAHnLfeX4SsWmV2dQsG4a0JdFiyeVSehdP/ARwzWwn7z8wMpQ11PwUG3On1j0cSaHARR7JpMiNGlCPNRZeLNRfJEthPaZ53zyDSEZmZ8oJcxfAwT2MrViOi0kyMeV6o7Gf0bcTweYkggjeMzJhR8V1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxHABzq5WW+MU+fMEmJS6eD8itbd9s1P3Jl9ZefAYGI=;
 b=POIbsldiaa7HkTogEVSsqr8DKxySORO9Ai70ZafFdbX5y+uAIYoPvQQYD0NFY0PZ0/+VkmjvJSAT+ti2zrr8kh7W49PIlOfTFQ02+nR64ewpElDqdIJ90L+dg2I3EIeOXXuhTRmjXexDNzlHgld6+beQktp3DrQrtPTxQAhb2ILrGuyzJfg6blbXCCaFO6s0FseCdRfMY1mP9VwkBQkYXEzHQKuuFUrcJGhhNe8JllB3yR9wgUIS5EWrfIwNW1mMlS/j5qlhQYjORoVh1YBhbYJ1IqwqjJf/jNa5fX+iaD0DmDCqQhaHkjuzP79SMdqQ72FGJbIBGzsW16faYp9BYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by DM4PR11MB6312.namprd11.prod.outlook.com (2603:10b6:8:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 13:05:07 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 13:05:07 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "will@kernel.org" <will@kernel.org>
CC: "longman@redhat.com" <longman@redhat.com>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] locking/pvqspinlock: Convert fields of 'enum
 vcpu_state' to uppercase
Thread-Topic: [PATCH v2 1/1] locking/pvqspinlock: Convert fields of 'enum
 vcpu_state' to uppercase
Thread-Index: AQHa6gABo3p6UgrMyUar0JRUKAQsirKGnoZQ
Date: Mon, 14 Oct 2024 13:05:07 +0000
Message-ID: <CY8PR11MB71348DD03E5B112FAC1FDC9289442@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20240805023816.28003-1-qiuxu.zhuo@intel.com>
 <20240809014802.15320-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20240809014802.15320-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|DM4PR11MB6312:EE_
x-ms-office365-filtering-correlation-id: 1915f3ea-1678-4307-aaad-08dcec50d3ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RnhQSWNWRU5IQ041R3RrcjBnY0dvWGdOaHJsV2ZYNytORVp0aUIyWUpVYzE0?=
 =?utf-8?B?djAra0FZRFYvWVFKRkJEa0ROc1hnTjlwMXZ2TEVpWlNqbmF6YmdsZjV4bWFq?=
 =?utf-8?B?WCtoVnJ5ZmNCTnE1MlZoaW42NTJqYUtkdDlFYmhMc0YwelJuTXJOOERUeFd3?=
 =?utf-8?B?NWFwcG9iUlB1Unc1aFlWcFJocXp0L1RRUHpRY0tQY3BISUMrUENPRnVVcW5G?=
 =?utf-8?B?NnJBN0FZYlNzTlpibjF3Zmd1S21CZkQ1MS9MeENjdE9nRHV3Rm1QYTJSdzQw?=
 =?utf-8?B?VEh3ajRFTHE0NllCUlMvYjI5R2NrWEQ3NnZYVVZ5c2l4WWF4NmYxVlNwT2xQ?=
 =?utf-8?B?bjgreElzVk1FQ1JpYWsxc2V3NWlWQytsS1FwR1JhcFN2aFdTNWJjbjlLN0cv?=
 =?utf-8?B?VXdSUkNnNFVPM2xFQU9xSkltK09Qa1czVm1JWXEwZHVmWkJxVENEWktHSnFr?=
 =?utf-8?B?T0xiTmV5M21TaElmUFdFQU5tUGplQ2k5Um4wL3ZLWDZpank0ZmQ2Y3lvQUxW?=
 =?utf-8?B?QWs4cllOY2p2RStmMi8rVERTYlFPclZFMytkYk1IeTZjY2pwSU1KNGNsWmNN?=
 =?utf-8?B?Z3BXZ0o2YmQwRFgzWlNrREU3SU5UTElCUE9QT1NYTG9RSjdVK01TclVYNmw5?=
 =?utf-8?B?WnZyZHZTemNZcVRIQVJyWU5nSVFaQWdnZndDaXJCdmdFanNiTVlQN3FyRzFB?=
 =?utf-8?B?SXFvT2RRV1ZZeDUzUWFXRnZFQXBaclNuNDhlTkNtblRhdUt5dXFUWkk4bXp6?=
 =?utf-8?B?cGtOWVdOcWhURm1QQ3MyZUdQaU9yRWxZRVJmUnR4T2FacFA5RTQrd2NTNEMw?=
 =?utf-8?B?NXNqVmhtZWxudnc4MDVZejBJNWE3WFNYMVdPODBld0xHUGhZYTRKd0VoT3Er?=
 =?utf-8?B?dU1BNTZVMGswL2p5REJxVmFSeUEvVlQvZWYxYys4ejB5UUs0dkpxQzlzeXdV?=
 =?utf-8?B?L1o4K0JVS0svMkhoekVzb1lPWTNmSVd2Y0tmVWROc1J3WjdtZmlwSXI0R3c1?=
 =?utf-8?B?eU1rcFhzaGlTSVh1NkFmZUU3ZE1nWDBiTHNiaVRDWXhkeGJienZnV2R0OXQ0?=
 =?utf-8?B?R3hHTzAvYXBYYTNCVWpFcVhLMDk3Kzlzb3hQSGJWR3N5bm1mYkdrQTZrZTV6?=
 =?utf-8?B?SnJaYVp0SDFVU1lKQ1lhSGZUS1lzT1dpWFVnQ2JtYU9Wd0I2OEllOXB5YTVW?=
 =?utf-8?B?ZlhBTnZLUEpiekt6b1A3dFFMVys2MVVwYmxTTHplUlZ4VTdDRHRaa2dZTWJC?=
 =?utf-8?B?K2g4QkdpczRTcG5zMDd4VWRVNXNXekxMbEprR1I2ZCt1N0cwckNzczJlTU5x?=
 =?utf-8?B?RFFGd0FKNmQ4dTJ1YytNaHRKd2c2RUt5Z2ozOWxlSFgyYmpMcC9tM25JSzln?=
 =?utf-8?B?MHZSQjdTVEFjaVRQRkJBT0ZyNkcrZEhadlYrOGJJVGpVQ081UkpLcnAyM0Ev?=
 =?utf-8?B?dVh4enZRQWdXZkVYYmUzMHBlbDAwMXpUOStwYlVOUU45Mzg4Tm9zaVA0bE1Q?=
 =?utf-8?B?Mks1Yy9KSWdvZGcwTFYyQ3BRVWlsRXFFVy9IL2VMR3VnYjhYSU1sNkw2V1Fa?=
 =?utf-8?B?N0F5UXpjdGNldXBJTmthQ1NCblA1clkxZ0t4Z2oyUEQzdE9ubHVjUEVyUVpw?=
 =?utf-8?B?cU1wV25KcUZzTVVEQjUyd1A4cXNIcEl1MjExUjZDUUFmREJSWnhQSXpIc0VN?=
 =?utf-8?B?UldJaVpxYUhCVTl3ank2eFMrVEhlQ0V1UFh0OVIwNWVkZVduWm10bTlKWnNX?=
 =?utf-8?B?WnB5a0llMFIxSGg2c1BNWURpbmtaTytjOUNieUJpOXBCL3ZsenNSbnd0WFpC?=
 =?utf-8?B?clNIVzFjQ1lETWx5RFNxQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1k0cWFhV3hmWkd6enJRbHdzck1Ka2JFM3ZueDJPMmF1bzNCcHQ4TThhVnpj?=
 =?utf-8?B?ZGxHM2UwSjNuN05POEpIL3FRT2h5TnNTdEFPSWlKNE85bVhDRnppUUVqeGZV?=
 =?utf-8?B?SUZEWkdUdXhINzNyMlZHQjNtcDNIMVBlM1JDNldDZE1iQUJ5UEZNZ25ZMUVN?=
 =?utf-8?B?WGNDYkdqVGh0N0tsN2RXbWtHUjByQTBmeE1LamNjVGtMdnZtSUxNMDBxdW83?=
 =?utf-8?B?TmRGN01qWE4ybEFvMmMycTl5R3BDOHpqUUY2VmtWbGZvUmd1YzNNdXVvUlNC?=
 =?utf-8?B?MnlqZjFrMlhFdXM1OTR4N01BMWZvd2F4TVZkMzFUODJSUGV3VjVzUk5uQ3R1?=
 =?utf-8?B?amN4RWJobVNTM2h0QVBwV3ltZitWZS9aYTNlWWI4V3V3UGRsT1YxY2RaNFdR?=
 =?utf-8?B?UHZLalNDSTNOaWJYeUE3cnhPUjkvYjE4VFFiYkRUenVEbGxaMi9JVUVidGs4?=
 =?utf-8?B?RlBKNnl1djN3SmZzblg2djFzcnNhc0xndzNXeWdEQ1VxRm1Ka1VRRkV5VHll?=
 =?utf-8?B?ZWZ2cVBWVnNudHdVNEJINnFVdGZocHRtbjRXSHhldGdGRlBEVGZVSStBQTMx?=
 =?utf-8?B?UUhyaUhCTjlzTndpUkF3Q08yejc1WnFXQTVhRVQweVlyUjV0dWVXcklWbTNt?=
 =?utf-8?B?cXpLUkVlbWJkVXVlZkhJL2w4TGs1ak9Eb1pzaENWSmxWTUp1L1pPSUw2UUUy?=
 =?utf-8?B?T3hBRlVHVEpvU24vRDc3Qko3V3BIN1hvT04vaXlwclVPZUVPTURZdHJKckRK?=
 =?utf-8?B?cXFMSytNeVlLWkJQVnFEWHU3c1lraWZBR2xHNUVLWjI2U1ZTbjVGc0V1R3lX?=
 =?utf-8?B?YmpiM2xlN3lkN2ZrQTFObHZyK3FsMXUvV3V3TExWTEczVVRCQTdRSDVnbVlh?=
 =?utf-8?B?ZVM3dTl5L2ZjbG5QbTg3SmpsWmdmRHFmSUR3M2ExOHBsdmJxMm44eS81YjVo?=
 =?utf-8?B?c25vUzNPL1FSdHVMck5HWWNWVzBTa1psYnp5K0ZVbXkrZDZ1aDFKNHZUWVY2?=
 =?utf-8?B?VndycWhLQVhDVUlCanZEY0hhUTJzaTlNTHBlTkJnM0RkWWUwNG5iSlI1QjBU?=
 =?utf-8?B?cHM0NllqNzRCVlhXQU1BS1RVSTYzTTlEcklKRFBISWRsNGxKOVVlSkNUU1JL?=
 =?utf-8?B?TytUUnJ4RW1aeUxyL0tqaHFqSnNKNFdtdUdtSU52MS9uSXBQeUlBbXM3eWIw?=
 =?utf-8?B?UTdEUGNhY2pEN3JOSUlXcDJQa2hoMVowTFlucG55aHhiTUUzVEVrSDVIMUFD?=
 =?utf-8?B?VE5xaTQ2RCtNdHNIbVFESVBMVy9BRXNkUnMvckxacWdZaWFIRG55Vzc0STVF?=
 =?utf-8?B?eGQxSGR5WVM2YWxzQTJrelNPUWxvM2ZsVU1pTGtxSk9lRnBFUlRBbEp2c1dW?=
 =?utf-8?B?K2JHWmZRTXlxcW40eHV4OWxaRWZTUEgzK3k1UmpGd3RXbFIwT0tGSmI5VTdl?=
 =?utf-8?B?SXEyRC9PbUVSR2tQV0FiT1FJOGxWYXR5OFBYMVI5N3BqSFlLTmpaaXRUWGFu?=
 =?utf-8?B?UUVxZkNNb1N5dXUyQmtZY0l0MmhTSWFXTy8rM0FFelVSSTIrWUE5djB2bWY5?=
 =?utf-8?B?L0NOUVQycytxRHRqYU1CY0VlL044QVRJY0E5YkI1dXJGRjNLUDcwekhFSnc4?=
 =?utf-8?B?MkZhZ2tRUGFqNUZRaFg1RlBCS1dyUTNTTGlUOSt2M2pTUkl1bXlENExXNkhM?=
 =?utf-8?B?TXJIaE5zczAzc2xZUzhpT29qR3RzRUNHMG93aUxjaXROVFI4d3gycFNVRFZN?=
 =?utf-8?B?amQ3VkVJcnl4TEhZUDVkSlF0WEozcEJydVVVL3kvR3RHdWtFNVhPRnlvWkFu?=
 =?utf-8?B?dHZYdHFiSUhGbnhZY2kzSVRNRDVBN0hwdzY0NksySTZ1enQ3SFg0UllIYWRP?=
 =?utf-8?B?aEJEbE9QODdneHBqUzFXeElYNXhYT25NMzgxUXBEKzk1RWluck0wdHlmSHpt?=
 =?utf-8?B?Mk12OXFWZWtlaDVMOXNyWFVnQTZhMFVyUDN1MVFZSmpQanpaUHVud2NPRXFs?=
 =?utf-8?B?YVVNeVlKMmZUaWtIbHVWaFpFaHJOeUVhaEFWdlp6dTZWVmc1NHlYVUtYaWJY?=
 =?utf-8?B?VWMxK0cxdGtMQ1huWnFpVFVXbGxxeTVndXZSNFdoWkRXRDhmRStwUWtYM2xI?=
 =?utf-8?Q?RS0Md8WkgU0yzBVW32AekHSzo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1915f3ea-1678-4307-aaad-08dcec50d3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 13:05:07.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zTBqqUVpA1dxqoL52FlyzUIZBIp8Ts4COXI+QCNVzdUbA+muvEYXPqvZn17S81VVeB6980jme/Su6FShom1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6312
X-OriginatorOrg: intel.com

SGkgbWFpbnRhaW5lcnMsIA0KDQo+IEZyb206IFpodW8sIFFpdXh1IDxxaXV4dS56aHVvQGludGVs
LmNvbT4NCj4gWy4uLl0NCj4gU3ViamVjdDogW1BBVENIIHYyIDEvMV0gbG9ja2luZy9wdnFzcGlu
bG9jazogQ29udmVydCBmaWVsZHMgb2YgJ2VudW0NCj4gdmNwdV9zdGF0ZScgdG8gdXBwZXJjYXNl
DQo+IA0KPiBDb252ZXJ0IHRoZSBmaWVsZHMgb2YgJ2VudW0gdmNwdV9zdGF0ZScgdG8gdXBwZXJj
YXNlIGZvciBiZXR0ZXIgcmVhZGFiaWxpdHkuIE5vDQo+IGZ1bmN0aW9uYWwgY2hhbmdlcyBpbnRl
bmRlZC4NCj4gDQo+IEFja2VkLWJ5OiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCj4gLS0t
DQo+IHYxLT52MjoNCj4gIC0gQ29sbGVjdCBhbiBBQ0sgZnJvbSBXYWltYW4gKHRoYW5rcyBmb3Ig
dGhlIHJldmlldykuDQo+ICAtIFJlYmFzZSBvbiB0b3Agb2YgdjYuMTEtcmMyLg0KDQpKdXN0IGEg
Z2VudGxlIHJlbWluZGVyIPCfmIouIA0KVGhhbmtzIQ0KDQpbLi4uXQ0K

