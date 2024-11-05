Return-Path: <linux-kernel+bounces-395706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA35A9BC1E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4DC1F226E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8E3C38;
	Tue,  5 Nov 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIcKM/OZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292B163
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765562; cv=fail; b=XmrOoPThN8ZbVihRiQCb3Fy1xWFAnPXW5qSBGpFR/XyiWGWLiywR/Q0c9Gsk0C4LhYQQ/01AcvKXhKrt2lt2MeaccWSPbFY2R/X0ctjwX19STbRT0VwVXDvj6EARY6hNPgVaUXghaaYpsp3tRtntJOGqZYtddOpcJ1N6aJ8PLEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765562; c=relaxed/simple;
	bh=VAFtdJLazhBvf8UevBjp6oUGr1v6EhuJ1Ntricid5xI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kREdW+tEnAebzHt7DCyhf3pVaUKBrVKyUcJCf/c/ovlI0Pg98Mo9s/WYtmwhwdzAAVrusvvB7jH5kqbPpTv3ODxR2ARaj4ljPM+IIS61pr/XF1PGlFS2LQf1zg0XACxeY5Zy5mJNa3GL+pPXAPeb1QmDZUdJH4mAzw36m0MV5rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIcKM/OZ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730765560; x=1762301560;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VAFtdJLazhBvf8UevBjp6oUGr1v6EhuJ1Ntricid5xI=;
  b=mIcKM/OZoGWwHK7GqO8wnzqXe624KszbrYu0DfwOrTb0r/g4v473h+7+
   FwwqrFMuHWTHmPy4dkG/FlwSdDfWzyYGdyDR1s1OgB1xYEWQLtvRuz/H1
   ayMLZQ3HC7BJkCluupQ/Etl7qjwLFGYSE6KNj/EXafFxahGwRkKEsNljb
   xeGEmNUZXLNnyPTSV8oIOLulSHfErrTToKg05xO/QB9PFAbyn1RfCgJWL
   Nae9T2LCQv6d0qYgUw2eYX7lPuIjsSa90GuB9KVslEF8QQqMOztV9R9xj
   sn9YRhbXBa3PxNJkwe1rPz27XsIjXJnX+NeBga91yKiYAZUXTMTOrzp7I
   Q==;
X-CSE-ConnectionGUID: F0FS6YHsTQ6VtMCdIkv4DA==
X-CSE-MsgGUID: hD0OB2UmRmKvVwMA7MHwrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41593452"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41593452"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 16:12:40 -0800
X-CSE-ConnectionGUID: 63eZeGL3TFWt8AXG6ucoZw==
X-CSE-MsgGUID: LahuidZbTaOWpcqGsaXN4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="107153968"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 16:12:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 16:12:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 16:12:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 16:12:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIlNPzf9pEbfOv019U+LsTeIP+PLwg0KuNqwO6eAz4gJdxQHpBfwG4M1ARTvwdfXvyg0hLg7f2ogYqbVm9pzEkya+1brn3xiZw7PpQqi5s2IV13Z3AI3k5GsqZDrZw/FSdZRhOiIrgvvjMkhabwJJDmBD0lZqXcDhVQ5QeQFQhtMU46nEQ+35ZE2M5SAo/RAgke5MaFAP5ex0NIWqLmW0HRY4tQWFCkfShlerY8pWSzsaLScZedHFdbaT6qdSVHAh1chAjNKjtA7F9mXcOW0bHyGHZr8HSHPI9U3AL0XeK+EhpdnXqpNoQryEeHmPlyEK7XXH31T0wtvA7duOG6xOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAFtdJLazhBvf8UevBjp6oUGr1v6EhuJ1Ntricid5xI=;
 b=otNSZd9gSWA64XyrunRlYy6FQPjqnW+tEcUMwmQvRG0JBHo1sLdYkyCadpfz7rGAYMcyjZYb7sXmPqPUUwZLyusxqMQKhoGpqZdHTijR+pq0xb15kleMTQI8uGTu4Jh3xYa+u5d1c41EgjAkX9QTjKN8wpJB0yPvXfpPPU1ogOX8ITyODxBeAP5PZ1cDGINp/9ViJkEGClQolFb3aVfvNJaQpnITLgJTvKi+48LzoGXHcGbNVkPJWWZYPfaGIq/clfXuIrifC22iGZ7TN1xXbfwXnlmn20PD1+wQ3imRQe3kgYFz8NpnQY4yl8HU/4ZiRi/XniklU+sZIP19pt4j8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 00:12:35 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%3]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 00:12:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, "Chatre, Reinette" <reinette.chatre@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Babu
 Moger" <babu.moger@amd.com>, James Morse <james.morse@arm.com>, "Martin
 Kletzander" <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Topic: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
Thread-Index: AQHbK6DbACO0R1VGa0C5nUIcf/5WR7KnvKiAgAAEErCAABMQgIAAAohA
Date: Tue, 5 Nov 2024 00:12:34 +0000
Message-ID: <SJ1PR11MB6083901BDDB4B6F8733977B9FC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <SJ1PR11MB608357ED39FA4FA1C85C6DB2FC512@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8a76c5df-3982-c53a-9643-4b6b1de290e2@intel.com>
In-Reply-To: <8a76c5df-3982-c53a-9643-4b6b1de290e2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7420:EE_
x-ms-office365-filtering-correlation-id: 3d528a78-1533-4294-bbd8-08dcfd2e8c87
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UUVjN2c0enVJWFZzT2VjT1cvMnJRTXVmdnoyVzNMRjJ0a3d2blM4V2pCck5s?=
 =?utf-8?B?MUFBQUgrNVFycjhBeG8xR09yelVXVWNRQUJTTmd1aXhNaE43OXhmTkJ3bXlu?=
 =?utf-8?B?ZVZ0NDlISGRKeDhNdHBHaVYvci9wanZ1NThvclByZTlldW9tZHhDdHVQbWxW?=
 =?utf-8?B?T0F3TjY1YzdZRFZiekd5dWhITU5hcHhJclZKTzhHSktzeXg5QUI1UVNMSk5y?=
 =?utf-8?B?QVlZbmhpcXdSVGcwQUdxWkNkaUY4Tnh1NEcvd3VCUDBaeUxuTDQxQW5hOUtp?=
 =?utf-8?B?a2hnOG9vbWlISGVrVnRRQ2lJQ3VrZ3k0TGQwRU1Sc2hVRlY1ZFNZUnRiRlBG?=
 =?utf-8?B?RVUyL25VWjNYQjBFMC84SjlpZWVrclBvRGxFTHIvdFFVeXhNZ1VZY2MwODhY?=
 =?utf-8?B?YStVSzR3L0Fqbm93WS9naTQzNUxiaUREVlhsSkZFbGROcDV0Qm5SbUZsU2Ny?=
 =?utf-8?B?RkdMczBGRmorWmlhYk9yNGhTQ2EwV2ZhN3U5ZEFMQmZISzQrQ1UyUHpXckJj?=
 =?utf-8?B?eko5Tkk0MTVmYXUxVUI5aXRQdGJ6Qlh1T0dnYk1qRDVjTjNEcXBtUkJ5M3hW?=
 =?utf-8?B?MFlKMDg2K2RScXJWdVZ6MWZsRGV4TWREc0hVZTE3alk4ZEJaZFpma1VGTzdB?=
 =?utf-8?B?SHY4Q2tEWEdQeFkybWFPTmtncjlxTEZmSkJqdWFKZlRnNFA4R0kwUDhnMGRu?=
 =?utf-8?B?TFVKYVMvSHlTMmhrMHhUSHZpOXV0bEFUYllRQWtTY0NoK1JQbDFjL2l1cFEx?=
 =?utf-8?B?ZGtvVFowTDFnaEVjTFRUWTVkbHE2SDFPQzdOb2ZzdzlRTXFlTzM5OHBYSDUx?=
 =?utf-8?B?UlhEaUUwQXNkRWxXVnpmcmthL016bGU5VERxbmVKS09udUxpbVhXTVljSzh5?=
 =?utf-8?B?WWM5T21OYkJoeU1sVkJucTVQdDZhU0dwVmIvN1MrRmR3OHJyVHNhMFBmVk44?=
 =?utf-8?B?Z1M3aStzTERuelZva1h1VmlkNEtZQW43N0YwTlhEUTZBUFh0SWROWkl1cU1i?=
 =?utf-8?B?aUtDV09VM29HN3lVTzQ4aWhOTlBlMjdaNC9mZTBZcFM4N1ZDYU5aSnNaNGxG?=
 =?utf-8?B?RktRdC80MHlVTTI2NUdtc09mS3FMVHlGREFMbE1Rb0o5aGxORkV6ZjlOWTQ0?=
 =?utf-8?B?c3gwYWNWbmtucGQ1Yi9abzh2ZktPaHNFOEprYXA3OVdzK3Y1Z2hwa240aFZ4?=
 =?utf-8?B?azZJeDZ3MldKWHBtRW03NG1sUnE0dDgzanlDejcvMW9ITXZmeFlXemJqM1Fa?=
 =?utf-8?B?d0xJN0F2bHdzUWQxNCtKWGx5WUNvNnc1THdraDhnQTV2MVhBeldoOW1idHpW?=
 =?utf-8?B?YlFsb3dMWmp0RHQwYjdDQzF3dmg4YXUvMmF1bU9aK3c1emcvcXJWWU5vcEJj?=
 =?utf-8?B?UDYzZHd6S0NibWlQNXVnbkpLa3RLM1RrRzZ4YmVZTXJqb2lyV21qQWJKTTF5?=
 =?utf-8?B?bHRMbC8xcFFEVSsyK2pzVGxKRE82ZnN6cEJESWl3Z2dSWWdsSjgrZDh2U0xt?=
 =?utf-8?B?SUJHSHpja0drRVVVTUc1Nm42R0pyTkowYitlUWg0dGtNdGJTRlE5Y0t5dWsw?=
 =?utf-8?B?MGtNTUNiMWhkb1EzeHdTRysvbVFGYkZaeU1ndExjWWp0ZzVDcm52K1NLMGdl?=
 =?utf-8?B?RUx5ZlBWUTN6dTNoaHZRViszL2c0dXFidm5ZajRyMUxNQW1TSkMxdXU2VFNI?=
 =?utf-8?B?VFZZbmdLM0NQanpkTmpYTEtMNnd4ZW95eVpHYnJzUmFTZU4xc3dJZE9nZjFI?=
 =?utf-8?B?YVZzVllJZkdhYjdtWGZYS2F0Zjd6R0h4LzBHaGRScS9jMjlFNk5SaVdIS3NP?=
 =?utf-8?Q?zQFcyEOvGGUBxyBvPw0jJ1tOwZxVXJwjU3KPc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NXeE9LN2RCSlNXYlBsakdqVUFuc0JDdGdRVVRNWUczQUc5VS9qdk1HWkg0?=
 =?utf-8?B?Q3o0cFloYWRGQnBRM0hXVVp1WjNLaEdIR2lRNDBQcTFxOHJRNXJGeWdRMUhq?=
 =?utf-8?B?d01uNVFnWFpZMDFmalM0dzEzZTZrczIya0FzTjhCKzBOTDkvVGplSFRsY1Ri?=
 =?utf-8?B?SGFvcVBnOTBYN1lybElLTVNCQmdkMlV4QTlsVnMrQWxLS1BTb2ZPckgzRmRK?=
 =?utf-8?B?WVB4VGFzUWhYekMxSEU3Zld5SHd3dy85TENnODRjMmZGV1ZUc2Z2ODN4MjFo?=
 =?utf-8?B?ZVRUbXBnSkFxWmJGUGREU0ZEU2w0NWUyZEROdUZUMUhMUHh6TThHRzJrZXBQ?=
 =?utf-8?B?enhlNy81TE1VeFBOMDhETUVTUEdxNHVaTHdQeXl1NTQ4T3ZFRUNzMERQK3NM?=
 =?utf-8?B?WHZaTFFNK1ZTQTJLc0owY1cyVWQyejE1NnU0Tlo2cGtnWXpIOVhFaW9GNnRp?=
 =?utf-8?B?cWNaZnAvUUNrMERNMFlYUDgrZUNjbkhMbnZZckZDeEROUG9EVjNDMCtoYTFz?=
 =?utf-8?B?dkduUHRYQ2trMExDQWJZbm1kcG54VVkvVzVyMVpQUnBPOG5jLyt2U2I5Nk1Y?=
 =?utf-8?B?Zms0THRhRE03YndmU05UUTRIdWRmbkJuZGNxUUhUbEVIMnZRYTJqNlJiNFl5?=
 =?utf-8?B?aFhON0oxMzJCZTE5dnlaOHhRT2tDNTRId1loRGxaQTZ4NEh2NXNOUEhDWkFH?=
 =?utf-8?B?bVZPdUE4NFlLYmIxM0E1RTZnQXk4K0pLZndieWkzSnBnbHo5QUhSK3dZK2lB?=
 =?utf-8?B?UGtmK0ZFV3Zwd3hxZzlBcGJCdXovOXdubWNKaHVldkVHMFFqTk5LRlNwY2Vr?=
 =?utf-8?B?Z1RrOWdLTXg4UFVRbnpmS3ZYRDUzZVY4YklDOEtLNmZ1NDhvWmhhUkZLMjhN?=
 =?utf-8?B?cmdQRVBubVhHMnJXRFlZY3ROZXdiNnZmV0JPWm5BaFJXRTFMQVpFWVJ2RC9I?=
 =?utf-8?B?UDl1bUk3YWFkczQ0UXY3VDQwR09EVVUzTjNtRllvYjN4T0Z5Q2QveTZwTVFO?=
 =?utf-8?B?VFhpOS8xZVJzK21EK0Q2cExndzIwTDNHbHhub0lvd1BETktRSWpIWkxVNzFS?=
 =?utf-8?B?enAxMEtoK3FQaFlyUUlmU3REcllWRE1RbGo4Y3BxQ1RQR2ZDT0I3SnJkeXZI?=
 =?utf-8?B?emxNMVFuM0JXc3ltOFQwWWdKRlB5SE1kWjRLVTRSaDFoaktWTm11RGE5b0tx?=
 =?utf-8?B?RklxdWZwVHpHeGo4Q3IvYnRCYXFqYjVtU1JCKzN6YkdmVkl1WDJncXlocnIy?=
 =?utf-8?B?anJlQnhkQk56T2thR3Qya0E4QTFzTE5yZ1NibWp5NWZUNGYycCtLendWYS9F?=
 =?utf-8?B?SFdabEhGdWt2WWlBOUtzVjVOZlhUUHZHc3Z2TTlUSFZHZ3R2elpFM1BQT2xi?=
 =?utf-8?B?RXQ1M0NGWHBoZlpkKzRRVkJTVVJ0Z1JoRXRyVHAvajNaa29STXk0YzFRelEz?=
 =?utf-8?B?Rm1FcTVUaUY4bDdTUlRielBYU1NxeWdwUXI5dmFibm1iM1F3YXRvbUIyLzNC?=
 =?utf-8?B?dDdoVDVacnl5TndVNThyWE1EREw2M2ttR2Z4WndRc0UzczRZTkNINlFEVWpW?=
 =?utf-8?B?UnZmSzJmdWgzSkJGVklWU3RZeEp4RmlSNTNob01heER5OGs3eFJSME1tcGRQ?=
 =?utf-8?B?YlZ4M2YzZG05bGZmb2hNS1pvclFMOU5qYjFJTHBiN2dBTzIxOThqYTYvODdx?=
 =?utf-8?B?elBxdWRUTktHQmZVd2hzNi9IOTRXWE5oNlJjc0VFcE5ZSFZHTnZaajFlTkp4?=
 =?utf-8?B?WVU3RnRQK3RRNGdiVitBNGtIS1BGVEJ1ODBaMzNmS0Y2NTNXR0ErZzdGaFBR?=
 =?utf-8?B?SEtFbmNhY0hBdkRCODdRTGhHVDU2NndPWi9mbzJOVXZMMFlpQk1XbGQ4OC92?=
 =?utf-8?B?NkZlS2E1OGNjQ2h0RUc0ejFNWStCZ1RZYlg1U0tPb2VsVVI0QXp6NWh0YzM0?=
 =?utf-8?B?cEt2dExEanlkeEdObU5kTStFdkwweHo0L3lSYlJDS1RLS3ZiODJlaXFKWDIy?=
 =?utf-8?B?U3JtU0FaRmp3aExTcmgxa0IzaHBGNUJjYXp2YldZUk9FOUFjTVd1ckppMUd3?=
 =?utf-8?B?QXpvN0ZJTFNxNDNselJoY0RWRUxaUDRWTGpGZ28zQkE4cVBXOWJKWGp5Z1BV?=
 =?utf-8?Q?YIvARPNOui0EjN2GHvBTZkBto?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d528a78-1533-4294-bbd8-08dcfd2e8c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 00:12:34.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUXtPmZd7gFtvYX/v2EBGdZ7MMu2wlxzWVF+P+F37JcLf7n0RZYIQgqzPbolroXNRPN+cpCy3hKfprw8gtAW/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com

PiBXaGVuZXZlciB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCwgdGhlIHBlcmZvcm1hbmNlIGlzIGRl
Z3JhZGVkIHJhdGhlciANCj4gdGhhbiBpbXByb3ZlZCBiZWNhdXNlIGV4dHJhIGdldF9jcHUoKS9w
dXRfY3B1KCkgYXJlIGNhbGxlZCBpbiB0aGUgZmFzdCANCj4gcGF0aCBpbiB0aGUgY3VycmVudCBw
YXRjaC4NCg0KQnV0IGdldF9jcHUoKS9wdXRfY3B1KCkgYXJlbid0IGhpZ2ggb3ZlcmhlYWQuIE1h
eWJlIGNvc3RzIGxlc3MgdGhhdCB0aGUNCmNwdW1hc2tfYW55X2hvdXNla2VlcGluZygpIGNhbGwg
dGhhdCBpcyBhdm9pZGVkIGJ5IFBldGVyJ3MgcGF0Y2guDQoNCk5vdGUgdGhhdCBpZiBQZXRlcidz
IHBhdGNoIGRvZXNuJ3QgdGFrZSBpdHMgZmFzdCBwYXRoIGJlY2F1c2UgdGhlIGNhbGxpbmcNCkNQ
VSB3YXMgb24gdGhlIHdyb25nIGRvbWFpbiwgdGhlbiB0aGUgc3Vic2VxdWVudCBjb2RlIGlzIGdv
aW5nIHRvDQpkbyBhbiBJUEkgd2hpY2hldmVyIG9mIHRoZSBpZi9lbHNlIHBhdGggaXMgdGFrZW4u
DQoNCi1Ub255DQo=

