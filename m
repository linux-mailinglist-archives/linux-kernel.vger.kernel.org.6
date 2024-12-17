Return-Path: <linux-kernel+bounces-448393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6E9F3F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE9188B3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE2582488;
	Tue, 17 Dec 2024 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGKH2+Ip"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A65B1FB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396600; cv=fail; b=uIM/D71vuY7/FpUSTQRa4kWgKhHat3RQSZLI6SCD5ym4DZ4oJTrDc33gMRzdVR0WPlpKtN6qPKSRwfPWtDGB1Zpaoxci4Chmpwv9ci2c4uZPTq9aB3UXYaZsj30jS5Chc9lu9pw3V7p95sT/JbIl8H2vdk6u268H9/yRH3lAG/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396600; c=relaxed/simple;
	bh=jTVxj3J/82K62G4RnKvye4x8G7gveo5mEecnJ76t4SM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ltIfHdhcM81RNEY1WF/ij48Gm4SuUX68sSaTcsrL7QlH+lub3LKlBL5+3P5VbWRo7KX2NmQ0vyLvHubos7maslOUaYZzhjGQ0XnWBG1sZ+Ak41F5JXVbTBDrQnBIO33NecM9PNJInBncoZ84AtsaCIwhhcAK0L2lXLU9zvrAEZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGKH2+Ip; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734396598; x=1765932598;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jTVxj3J/82K62G4RnKvye4x8G7gveo5mEecnJ76t4SM=;
  b=kGKH2+IpMlGW+3XHjuxzjBpQwqQ3awgEftkG+buLxumkah79k5MN+Bhy
   ZHH1YsD1v7kevCngscEAR5Z7mE0y4oNBYi4nReMTRxCacua2iIojYAudQ
   ft0OyOjLMof+do1PfJt9zga/rriUPMJpIC0SkPiNC/ZSJNyKuC7Cqmwf2
   erDOAU7PTxibXDO2i7JY4oHu18KFRFKvXkhJnbUJWA+4oPSMXdfEjjQY6
   G9w0LlqUq5Dykzxfnj7iH24Xio3IE4JaqSmcpnIiGqmYWEOsiBQh+xvO/
   zEfleGX61H+7Jv7/aMWzjqjyhVLdzoGvabTrP09ehyh/O8fh/osl7Sxuw
   A==;
X-CSE-ConnectionGUID: XR4ASgcdT+WCebZWxCvaxw==
X-CSE-MsgGUID: MlqoTlxVSem9i7SroRO30w==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34684114"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="34684114"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 16:49:56 -0800
X-CSE-ConnectionGUID: ogLFUybeSo2w/aX1KX5SSQ==
X-CSE-MsgGUID: FkC2o96SSSq47Nm+cNXjGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101517353"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 16:33:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 16:33:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 16:33:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 16:33:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVl1ovYWUqqpTp3iXBRChXRgB1OT5JK8mrpg38kXQyP4UQPkqK+AIW3admFaw11Gf+UntWiJ1sNc96FoFm6sUgCxw5J+1/Lza39VhUOjRRfn6/xPbGF6re1LZ0m0nI6IOB0AJu70ItSU9mYXuKjxasmpSiaarBUS1QVFtL4R4MRWQRGYitDT9mMkntynCmiXudILANvaEhTnINhOWjJnzsHOMmVSBkjSX8io9RK8as3IStTJ1qfgjegH2QAwW7vGp9kt7wVdT6Kpnac33DFcLqeMPCqYSCDUoEP3HnI77YWdLf7NYYwSWs7Fxx9YpIJDpxwbthVNfL3FGs4F+w+nPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1XnCZI/gzpDa8/gqfdmxSWltjFIdccInZamd/cul5E=;
 b=gFQtFwjmaU04lGShAmElGfoGaBOjkHLtGVtYCu+McV141nW9pnGwbvjeE9CNKDMEt2OfLVayuxy3yXw31/zznbu4mKiu/L5Cr/ll7m9R4XAvQwpYFHlK2OjL872V1YTioMiRDoK8f6EEG0J8N5qw7eqa+wZZYuauXXczi7Mw+ITTFgensAFy1W6VxovKDbvEzaqNAB/pBHIKIHeRgZy1LH8Z+8/mYXHRGyXsiwppbjWUgtndRFtfaM4Jlv/4OTjl7uejEvvniV3DVUqjOAyX2Sl2TXYvW2O49deApb9tbvfKrcDyykWnn+Y3q1RqI7EfWjrlskQZNHKzHz2XMQL7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB6893.namprd11.prod.outlook.com (2603:10b6:806:2b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Tue, 17 Dec
 2024 00:33:17 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 00:33:17 +0000
Date: Mon, 16 Dec 2024 16:34:00 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: Chris Rankin <rankincj@gmail.com>, Christian Koenig
	<christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	"Tejun Heo" <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>
Subject: Re: [WARNING][AMDGPU] WQ_MEM_RECLAIM with Radeon RX 6600
Message-ID: <Z2DG+OcTIDPBGmdK@lstrano-desk.jf.intel.com>
References: <CAK2bqVJXY2CkR4Od2bj8wnYYfzZCpFYhaiPAcwpw0Uk7zXUVkg@mail.gmail.com>
 <CADnq5_OYjnFhVnQmVLQ7ucSYLm4NZ_wmRnLSOfJQzY33VQZ+EA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OYjnFhVnQmVLQ7ucSYLm4NZ_wmRnLSOfJQzY33VQZ+EA@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:303:dc::27) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb100c9-4735-4495-f6aa-08dd1e3266a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3JKenBtY2NRYjdDRXR4emZGMitBL2dvcHlleEY1VDNjQ0FnaEVjdDNHY1pS?=
 =?utf-8?B?d084Y3B3WGRLcnBZL2lOWVc3ZXloUHlDbUw0bnJOOEJNS29OWHhXNzBwRkFk?=
 =?utf-8?B?OVRmNG9uVW1VRXlxeGlDdWVBU3dxdFJUWEZkOG43bEU2Y2lsdzZtemVnUEMw?=
 =?utf-8?B?ZFFpYmpCTUFNckdKT0x5VXlaMk8xWUFEOWorZmc2LzkwUXVYRDFoQStGQUda?=
 =?utf-8?B?WkNQdm9FWHdlcE9qUU9pL21md2IxNUxEUllPbkM3eFMxdkoyM255anhQeGEr?=
 =?utf-8?B?V0RQdlcvYTNkcGpzcmNsSzg5L081aVlhKzRwQ29RSGV6ZmMzWjN4THNRWFRr?=
 =?utf-8?B?cWM1RDJzbjNHNmV0U2JCd3hmQWNocm9aMXBZMUw2ZFBRYkxaS2RZb2NLcWMx?=
 =?utf-8?B?ekxwZ2hGNGt6bEdDbFg3UjhQamVJYkV0MFJzaHN5UmtsdjN4U0NqVlgyRHFH?=
 =?utf-8?B?cm82bnlqTHpTM0RGNG5JTXZGUWpKNjQ0SW5VOS8vRHBGOUk3NVpWakRLY3NX?=
 =?utf-8?B?ZHlKR0lSRzBZR0pKUFY0NkFzdTM2aS85YkJBMkI5NXdJcFpqQnV2bzI0a2po?=
 =?utf-8?B?b0N5WjlEWU5jbmI2OGFjYmlibUcrb0FZTXZ5Q2lJR1hJcUp0OFdscFNxd3Zw?=
 =?utf-8?B?RUV2dXhYN3gyTktRY0NZNUhFdVdTbG0rQkZEYml0VjNvTWR4UmNFaEY0eHJV?=
 =?utf-8?B?Q0lKVk5RU1JuWDB0T1NNZDN1UFM2SVIyLzNXVzhBRkd3SHlCZUVxTnJ5U3F0?=
 =?utf-8?B?SnA0aHR1eFNkTVBXLzJkRDYydmY4OTdlN1lwdHY4RlE1cVp0SlFhY0xuUFlY?=
 =?utf-8?B?WWkzQzdJVEthUFZ6OVFleWVvRWZQcDA0RGdyNjJTeWxvQWI2b1VYdUI0WHZC?=
 =?utf-8?B?VHZRdzM3MU0yZm1EL3IxVkY4cHVkdE1ZOGdtY3ArTldjQlhVdXp0Ymc1VFQ3?=
 =?utf-8?B?VkVQa25INE9wUjl6dnVMZnM0WkIzbndENW9YSHUyUDJ0OVNJdlFEYmZHRTgz?=
 =?utf-8?B?bkc2dkMrRlE2MThqcGlvQnY3MW42clpGQ0RxeXI1UkV6L1ZwK24vOWlER01O?=
 =?utf-8?B?VWp1cWlwTStZeVd1NXdvSm02clVyRFFQQUN5eHhCSGthd0p4RE1HVDdCZFE2?=
 =?utf-8?B?T2h3RXkxQUFlQURXSE9JVkZzZytHMVN2cFdyZ3k3TzZOSkJTTzZpczBpN0xC?=
 =?utf-8?B?VDNKUFZoL1VYWlZsa2FVUmtIeFpHNzlpL1dWblJvM0pkaUppNXhYWHZVeVNh?=
 =?utf-8?B?YnhPTjQ4bkRsbEZvNG9RRWVRdm1yZlM0UENnWCtWWXpZTmswZFRtNFZuTnow?=
 =?utf-8?B?VzNPM2d6ekp6bEY0N1hCNFJ3aitmZmtWK1NWcXVnNmlMRVZiamxNNlJoYzly?=
 =?utf-8?B?SDZCekQzWWFzUWxlUDVNWHJ3LzVoSDZ5SnR4ektmUFR0V0RRb0tPNi85bjFR?=
 =?utf-8?B?ejR3MnE5WldjWU84djJpNmw5cklyTWNaVXBJd0FBL3FBUEt0T2IwdHVKZ3R1?=
 =?utf-8?B?cGpzQWhqSFF0Yzk1VEFLY3g0MjRJMlRaYVpMSUR6TGVEc3RZN0E1L2syLzQ0?=
 =?utf-8?B?UlZETFBWNk0raXh5NU1ITjk0YXNXZHpwSlEvN1hOM3I2UTZ3d1BQSHBpak4x?=
 =?utf-8?B?dWFnOUtzbUxaNnNBS1RmNFMySzNzckpuK3FYUFBTdnd1S0s5UUw2Ny9tVzE0?=
 =?utf-8?B?QXZ5VDM0MzJuTVQ5eGNnWEJ1VVg5dEFMT1hJTEQ1YmVRVE15YlQ5UU8yVmJo?=
 =?utf-8?B?MVlON2NqbFRPYzZBZkhPbjZQY3MvVHd0RE90SWRtNGNFR1BwZlIzejc2S2hP?=
 =?utf-8?B?SHpQY3Q0MmM2MWdjYXpBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3lMNjR0cDluSGNtTmxlYXNiQ2NiUjhvTm1tN016SlA5WkdVamF6YzhoSzkw?=
 =?utf-8?B?SmkrL2pKOE1XUW1wbDd5ZzBNK3JyV3luTFJTbk9NSnFHT1lQSzM1R1BxQjVT?=
 =?utf-8?B?a3FjbEUyamcrbE92WjFiUElsaG0xQUFEb1NlYVlVVXBTUzhEcnp3N01OaEJS?=
 =?utf-8?B?R0IzS0lIdUpNTHBIa2ZoVHNKYWxGQnRZVTVBekFCN3RaL1U5eUpMUjl2SzNq?=
 =?utf-8?B?eVA2dy9nS1pTT0RKZWZQOG9hZk9yd0Vreng2OTFGUlBPQWFVcGVmSlhLLzNy?=
 =?utf-8?B?SXErL2JKMUFWQnpwYm1tQmVWMC96UFlWa2c4UXp5WGo1YXZ4dnEyRi9BZTZT?=
 =?utf-8?B?NW9ib1VBaWlqdHJxNyswUGJ6ME5QYnZHc1R5RGg3N2xCbEFveFVJcFVyYWR2?=
 =?utf-8?B?VFFiS2VEUGNrenFFN3lIcXBEeU8vay9sN0dRVGZyRno0cFRUUDEwTXNJS0dB?=
 =?utf-8?B?UWw2QXNNVS92RmdQUXJrV2RtbmRacDRTaXU5dGxGS3lCcm83SDhGUkRoVXp6?=
 =?utf-8?B?YmhyRE9iT0pkMVRlWVFNelhUWWVURGl0SVNnRFNwTjN0QWxoUTdZTzBwSmxu?=
 =?utf-8?B?UDNHNzN2RFV4ZjBqN2lvWkVGc2ZFWVV6RnI5MUNUVmRoNDRRQ3Q4SGl6UFVU?=
 =?utf-8?B?TDJUSHAvV2ZKRUFGdW9HNXpScUdJVWlxd2g1dTQyOXIreUthV0VjV082TVJT?=
 =?utf-8?B?UzJjY0JwaUR2NHpYOWk4NFNuMW9HWE04U1BlWTBBR0Z5MUNRWUd2cm5hbmJ0?=
 =?utf-8?B?dkwrR2xad0tpTzV2K1RlTVNYZEVHR1pGNTV4YmQ2RnY1VEsrOTRDYnNOTVl1?=
 =?utf-8?B?YVpXVEc4OFM4enpZazdwSEs4MHBrWHNUd1poY29aUWFMeTh0TEp1Rk83N1Fp?=
 =?utf-8?B?OThENDJVRU5jOWRoT0FFZm54a3VlcHNoZmhwT0NwWm5xWDcxQjVGMXVqOXdP?=
 =?utf-8?B?SE15cTdsOFRhVnk0cllEWS8rQ1N2ZTFnQVVyUGpmbnkrb2NwQlhYM3BqVzVL?=
 =?utf-8?B?S2FVVVdtK3cwYWloczlrMm50cHAyaVd2eVRSSFBQNWF1OUo0ZElnOW9kaDA2?=
 =?utf-8?B?eXRQMDdaME9FN0IzMnZNTHY5dU9iN2FKQmhmdUlreWFPK0FUY1E3bzNSdXFm?=
 =?utf-8?B?eVZwSXJqWjhySkhHelY4U1FoRjUrVDZlU2NNaGg0RHZEMU44S3N3bG5JTlcr?=
 =?utf-8?B?T3dHc3FYNmpzNTdGbEtMejVxcmZCVUx3K2JvUVFrOU95WWxqeXorek9hSUhz?=
 =?utf-8?B?bXZ1NEQyZnhCandGcDNYdFFKTS9oYmIwaWVtZXlpVWQ3eGlPejNremNQenRa?=
 =?utf-8?B?eDN2dU5GUnJlbWFpM3FGQXl6L2ViRVdpVUEwWnRqWmQwZFNHbW5xTkFFeVhV?=
 =?utf-8?B?V1dwSDBmeWZYUHN1NXZRVmZhbGNUV0htRTZ1Q216VHV1MGNFZWUrKzRFM2d0?=
 =?utf-8?B?UTJJanNxL1FpTmFxWm91aHVETUNuSWRqYnRQTC9adXkzeWoyc0w5VzNkei9Q?=
 =?utf-8?B?aTJ2TFJlNEQ3ZzZxUFhxQ0RQY2xSNXpwZ3F6dFhvLzV6eG5HaU9xMzgzK1c0?=
 =?utf-8?B?OE9sKy9LdmZmTGlYb3gxZVpPRmdlQnora0NyVFVFTlN1MEZZM0VNQjhkcHp3?=
 =?utf-8?B?Q0xtUkJpMjl0UFdOKzZzMmZvbTZxQWQ4TExZNUFsSmF3REk4K0pHNUdjS2t0?=
 =?utf-8?B?WnZIQTRJa1dsYW45QTJOSGVsSTJTYndublZWQWN6QktYSEZZd2hWUVdRZFpE?=
 =?utf-8?B?RHpqSzIzc2JVVVJiUzI4TFJzTUh3dk94aEJCN3Ercm9QdE1SWERUQjJWeU16?=
 =?utf-8?B?RU1JNVFxMXJiNGdEZnhvY2llNWVMRlF0N1UweWcyMTVXTm9OWDVsMmF0NDIv?=
 =?utf-8?B?ZkJXYmZ2Mm1vVkcxaTZyc3JyYlJiWWlpb2EzeThqeE5kc0szdnlJU1AvaFo3?=
 =?utf-8?B?TzFtSUI0RzFVVFBDSmZiNStwaEJyaWlINm5sWVN1aTFRcitwZkxLeXR2MUFt?=
 =?utf-8?B?NEVjQUNaNWI0MWNmVVRPYTNjbzZSeXRVY0FYREtZaXc4dzFlLzJKNjNqZjMy?=
 =?utf-8?B?YVlPYnUrVjFNMUdYMjkyclJGa2JGV0dhTkU1bENmY01RZFdGVHVqUmNRS1Ni?=
 =?utf-8?B?QjB2c3FWRnB5TmtQUGYrSFAvbnovTHZtRzJkZG5NUnZwVm9Md2FzRldpWUxU?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb100c9-4735-4495-f6aa-08dd1e3266a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 00:33:17.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VccTNOnt9sGk1Tz5deExeLgymmXiNIJyynDUZCCrsKS6kje13UFbLQpJ7FCPtzeGRo0rE2ccOWvsH+4Mod88yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6893
X-OriginatorOrg: intel.com

On Mon, Dec 16, 2024 at 01:36:29PM -0500, Alex Deucher wrote:
> On Fri, Dec 13, 2024 at 7:53 AM Chris Rankin <rankincj@gmail.com> wrote:
> >
> > Hi,
> >
> > I've just noticed this warning in my dmesg log. This is a vanilla
> > 6.12.4 kernel, with a Radeon RX6600 graphics card.
> 
> That was caused by this commit:
> 
> commit 746ae46c11137ba21f0c0c68f082a9d8c1222c78
> Author: Matthew Brost <matthew.brost@intel.com>
> Date:   Wed Oct 23 16:59:17 2024 -0700
> 
>     drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM
> 
>     drm_gpu_scheduler.submit_wq is used to submit jobs, jobs are in the path
>     of dma-fences, and dma-fences are in the path of reclaim. Mark scheduler
>     work queue with WQ_MEM_RECLAIM to ensure forward progress during
>     reclaim; without WQ_MEM_RECLAIM, work queues cannot make forward
>     progress during reclaim.
> 
> However, after further discussion, I think the warning is actually a
> false positive.  See this discussion:
> https://lists.freedesktop.org/archives/amd-gfx/2024-November/117349.html
> 
> From the thread:
> "Question is - does check_flush_dependency() need to skip the
> !WQ_MEM_RECLAIM flushing WQ_MEM_RECLAIM warning *if* the work is already
> running *and* it was called from cancel_delayed_work_sync()?"
> 

See my reply just now [1] — I’m going to have to disagree with AMD's
assessment, but I’m not certain.

Again, I believe Tejun is the authority here.

Matt

[1] https://lore.kernel.org/all/154641d9-be2a-4018-af5e-a57dbffb45d5@igalia.com/T/#ma1ed4a99d9ad1a05f8d4648dd979d7c9d93591ff

> Thanks,
> 
> Alex
> 
> 
> >
> > Cheers,
> > Chris
> >
> > [ 4624.741148] ------------[ cut here ]------------
> > [ 4624.744474] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work
> > [gpu_sched] is flushing !WQ_MEM_RECLAIM
> > events:amdgpu_device_delay_enable_gfx_off [amdgpu]
> > [ 4624.744942] WARNING: CPU: 2 PID: 9069 at kernel/workqueue.c:3704
> > check_flush_dependency+0xbe/0xd0
> > [ 4624.765285] Modules linked in: snd_seq_dummy rpcrdma rdma_cm iw_cm
> > ib_cm ib_core af_packet nf_conntrack_netbios_ns nf_conntrack_broadcast
> > nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> > nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
> > ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
> > ip6table_security iptable_nat iptable_mangle iptable_raw
> > iptable_security nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c ebtable_filter
> > ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables
> > bnep it87 hwmon_vid binfmt_misc snd_hda_codec_realtek
> > snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_scodec_component
> > snd_hda_intel uvcvideo btusb uvc videobuf2_vmalloc btintel
> > videobuf2_memops videobuf2_v4l2 videodev btbcm snd_usb_audio bluetooth
> > snd_intel_dspcfg intel_powerclamp snd_hda_codec videobuf2_common
> > coretemp snd_virtuoso snd_usbmidi_lib snd_oxygen_lib snd_ctl_led
> > kvm_intel input_leds mc snd_hwdep led_class snd_mpu401_uart
> > [ 4624.765400]  snd_hda_core joydev snd_rawmidi rfkill kvm snd_seq
> > snd_seq_device gpio_ich snd_pcm pktcdvd iTCO_wdt snd_hrtimer r8169
> > snd_timer intel_cstate realtek snd mdio_devres intel_uncore libphy
> > i2c_i801 soundcore lpc_ich tiny_power_button mxm_wmi i7core_edac
> > acpi_cpufreq i2c_smbus pcspkr button nfsd auth_rpcgss nfs_acl lockd
> > grace dm_mod fuse sunrpc loop configfs dax nfnetlink zram zsmalloc
> > ext4 crc32c_generic mbcache jbd2 amdgpu video amdxcp i2c_algo_bit
> > mfd_core drm_ttm_helper ttm drm_exec gpu_sched hid_microsoft
> > drm_suballoc_helper drm_buddy drm_display_helper drm_kms_helper usbhid
> > sr_mod sd_mod cdrom drm pata_jmicron ahci libahci uhci_hcd xhci_pci
> > libata ehci_pci ehci_hcd xhci_hcd scsi_mod firewire_ohci psmouse
> > firewire_core usbcore crc32c_intel sha512_ssse3 sha256_ssse3 bsg
> > serio_raw sha1_ssse3 drm_panel_orientation_quirks scsi_common crc16
> > usb_common crc_itu_t wmi msr gf128mul crypto_simd cryptd
> > [ 4624.932496] CPU: 2 UID: 0 PID: 9069 Comm: kworker/u32:3 Tainted: G
> >         I        6.12.4 #1
> > [ 4624.939803] Tainted: [I]=FIRMWARE_WORKAROUND
> > [ 4624.942773] Hardware name: Gigabyte Technology Co., Ltd.
> > EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
> > [ 4624.950340] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> > [ 4624.954967] RIP: 0010:check_flush_dependency+0xbe/0xd0
> > [ 4624.958806] Code: 75 2a 48 8b 55 18 48 8d 8b c8 00 00 00 4d 89 e0
> > 48 81 c6 c8 00 00 00 48 c7 c7 1b d6 e9 81 c6 05 a3 5f 56 01 01 e8 32
> > 30 fe ff <0f> 0b 5b 5d 41 5c c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90
> > 90 90
> > [ 4624.976253] RSP: 0018:ffffc9000bec7c88 EFLAGS: 00010086
> > [ 4624.980177] RAX: 0000000000000000 RBX: ffff888100118000 RCX: 0000000000000027
> > [ 4624.986003] RDX: 0000000000000003 RSI: ffffffff81eab2b9 RDI: 00000000ffffffff
> > [ 4624.991835] RBP: ffff888155daa900 R08: 0000000000000000 R09: 7067646d61006600
> > [ 4624.997668] R10: 0000000000000091 R11: fefefefefefefeff R12: ffffffffa05ec880
> > [ 4625.003501] R13: 0000000000000001 R14: ffff88810011c600 R15: ffff888163600000
> > [ 4625.009334] FS:  0000000000000000(0000) GS:ffff888343c80000(0000)
> > knlGS:0000000000000000
> > [ 4625.016118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4625.020555] CR2: 0000000099837000 CR3: 0000000144e4c000 CR4: 00000000000026f0
> > [ 4625.026381] Call Trace:
> > [ 4625.027525]  <TASK>
> > [ 4625.028323]  ? __warn+0x90/0x120
> > [ 4625.030255]  ? report_bug+0xe2/0x160
> > [ 4625.032532]  ? check_flush_dependency+0xbe/0xd0
> > [ 4625.035768]  ? handle_bug+0x53/0x80
> > [ 4625.037959]  ? exc_invalid_op+0x13/0x60
> > [ 4625.040499]  ? asm_exc_invalid_op+0x16/0x20
> > [ 4625.043384]  ? __pfx_amdgpu_device_delay_enable_gfx_off+0x10/0x10 [amdgpu]
> > [ 4625.049366]  ? check_flush_dependency+0xbe/0xd0
> > [ 4625.052598]  ? check_flush_dependency+0xbe/0xd0
> > [ 4625.055830]  __flush_work+0xb2/0x1f0
> > [ 4625.058109]  ? work_grab_pending+0x3f/0x120
> > [ 4625.060996]  ? set_work_pool_and_clear_pending+0x14/0x20
> > [ 4625.065008]  ? __cancel_work+0x89/0xc0
> > [ 4625.067460]  __cancel_work_sync+0x4a/0x70
> > [ 4625.070173]  amdgpu_gfx_off_ctrl+0xa6/0x100 [amdgpu]
> > [ 4625.074231]  amdgpu_ring_alloc+0x52/0x60 [amdgpu]
> > [ 4625.077974]  amdgpu_ib_schedule+0x155/0x640 [amdgpu]
> > [ 4625.081988]  amdgpu_job_run+0xda/0x140 [amdgpu]
> > [ 4625.085663]  drm_sched_run_job_work+0x246/0x310 [gpu_sched]
> > [ 4625.089935]  process_scheduled_works+0x19c/0x2c0
> > [ 4625.093252]  worker_thread+0x13b/0x1c0
> > [ 4625.095706]  ? __pfx_worker_thread+0x10/0x10
> > [ 4625.098678]  kthread+0xef/0x100
> > [ 4625.100523]  ? __pfx_kthread+0x10/0x10
> > [ 4625.102976]  ret_from_fork+0x24/0x40
> > [ 4625.105256]  ? __pfx_kthread+0x10/0x10
> > [ 4625.107709]  ret_from_fork_asm+0x1a/0x30
> > [ 4625.110338]  </TASK>
> > [ 4625.111228] ---[ end trace 0000000000000000 ]---

