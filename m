Return-Path: <linux-kernel+bounces-296406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A3F95AAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA53282026
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111D11CA1;
	Thu, 22 Aug 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRTxT6Ge"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BE18C31
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291334; cv=fail; b=qZ0N3j8ZGXOj6h8pv8pJUoxe8p1CywYFK8zwg7/yGMbtu7ARUj/zgOBq3yKKEM5txRRzxOIAvdjxPTWDTD1+w9ynRdF7ESZAp5DkMw64ImZ8T00VNNRk4A2PQKMaSghpN2R6sXmqefRJD9G/A7wHyWrxgnSUNyv6Ro5hI7VPSBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291334; c=relaxed/simple;
	bh=l1fVx6fClfsGdZUGX+Q6mLQbaKjrZ2uOcuzDeNZaQN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rKCIIvyt3P5VW4hO+/HuRex0FQ6Em37d3+dnOvnQ5lqsgVQNTG8zy11YSR1d8Q+kx9P9XhleS73yIlc8BVNT87FIJIn2n826P2NXuPdYCNu9rF1Bn3W8r0O6yKKobyhbV8yuPYUP33/vcMzr08rHHtUJW5EUztaAoLTwFhRkNSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRTxT6Ge; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724291332; x=1755827332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l1fVx6fClfsGdZUGX+Q6mLQbaKjrZ2uOcuzDeNZaQN4=;
  b=DRTxT6GeSALIWyKJ+rtnCzAfg68PjBP32+sFXDMOo3RUotCwY10zo8Of
   ekoJM1HqLvdP1zVWHIcTaHW9AYups144mf0jQnZ3J/oTfVbKf1hqmKrrh
   Z3kfM88ypB1R1dE27Ji7vwFW9a+GQ4i7i4cq5utzAo0cwBvuRVEgAZzNI
   TRLoPRlY3gDR7DCaZ1D9PQFyPmo1No08sNXIagSZHiHY8ct6sOMZG3Gx+
   L5uKsFenwl6KMeEHei5xxGAqmu3tDu9KikgSo6mpeMhpUdHM1Dp4I/4O4
   FNQs4275C9MO8KJQobUMeIWszXK4ap/szJmfcHzh06e3zAKJLhlSmhQ4P
   Q==;
X-CSE-ConnectionGUID: Q2pj/LN+RJukAlN75M6Nqg==
X-CSE-MsgGUID: 1sFREKiKRVKbkKuB/m+MIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22565458"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22565458"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 18:48:52 -0700
X-CSE-ConnectionGUID: tbLRllngSsuQ+cvT5uBzmw==
X-CSE-MsgGUID: mDacX/PyQUSoW/4Kpa27sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="66100874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 18:48:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 18:48:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 18:48:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 18:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebtbJ2AJCaj5030oCtd5AJlZDtBEJBCDJ82QPp/cT9RPJvd6uKkJgmrueb0t7juNWnBeZsnoxn4CEwzqGW61d1iohmR+6L8aWne01zLUDAUyC0+JeBlJstNLlRssC8Ih1HkBnvEqCkuoek9yOkeeGoW2N7US5wKkDk9WN4r9rj7FUxe8Ec71IESwGFEmiB8k5YY51RefWLBNJcY+BiKwBkEPoPMUDKvB2NDQjNzQ62nbiONp8Wbzgcc7iSDztw6d65KoGS64O9+bEy/IYc9mN+uHupXhKV0vW2TL0j26egPy7L5TVl32oL/3KcGGEXe3jnWhB9gzk93IQjUK2tM31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1fVx6fClfsGdZUGX+Q6mLQbaKjrZ2uOcuzDeNZaQN4=;
 b=PZ86UTpGE7DFAPZFZ+AinP9WouCDCwXGUuh2oti+hWSuzVtiHGgRAak1OgF5vSSzyZN7acSukAhQLIxD+6eEh8BxvvH32K9EjI8BTcMZs5nruPS7/tLdqIHtBdzh3QDbEtqiihILBWY8d30+RU20Mb5OAH/6tGTrNS+oL0iXEAb8YhGHb+BOFCi2nxwbQiSBwa2/AeGj9ApJ9JMYwfJvWOT+GExEGw+jKXL6xcbyxHLnBxifCJbqA0Px2X6EQzyMgal6tl+4wt+VURNtXur4EC3m1V+x4L6c7iEq1eI47DAYckCgzf8CkEgI2tO+3OeKYgdfsf6IYnPERNuqQC6Ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by MW6PR11MB8409.namprd11.prod.outlook.com (2603:10b6:303:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 01:48:42 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 01:48:42 +0000
From: "Liu, Yujie" <yujie.liu@intel.com>
To: "mgorman@techsingularity.net" <mgorman@techsingularity.net>
CC: "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>, "Chen, Yu C"
	<yu.c.chen@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "Chen,
 Tim C" <tim.c.chen@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"yu.chen.surf@gmail.com" <yu.chen.surf@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhou,
 Xiaoping" <xiaoping.zhou@intel.com>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>
Subject: Re: [PATCH v2] sched/numa: Fix the vma scan starving issue
Thread-Topic: [PATCH v2] sched/numa: Fix the vma scan starving issue
Thread-Index: AQHa5xHdkMN/7krDREiZAhdkg+olKLIxlM8AgAEFLwA=
Date: Thu, 22 Aug 2024 01:48:41 +0000
Message-ID: <235394aee595eaefd4bd442d00201ab44cd47de1.camel@intel.com>
References: <20240805082228.4082656-1-yujie.liu@intel.com>
	 <5s55bgrmpomlpefmvt4bz7t2myvjnbw6lnvtsnbkdphwfb7zdo@tnm7flx5jidu>
In-Reply-To: <5s55bgrmpomlpefmvt4bz7t2myvjnbw6lnvtsnbkdphwfb7zdo@tnm7flx5jidu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8393:EE_|MW6PR11MB8409:EE_
x-ms-office365-filtering-correlation-id: fd479aed-8c58-40ac-a67a-08dcc24c8d12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REtLd1pyL1B3ZmJZT1B2bXY3NTNCTVFOeUZOUVpianZ5VVdRc2FWUHBMQkx4?=
 =?utf-8?B?bUZHcm8yNElwRE1ZN3dHWXFBbUlOYnBGRlI3SHRqN2hKKzJTbnF5Nm90WStS?=
 =?utf-8?B?dmpQOFpQVGRjb1FFcHJranhLbzJrWEROclJRK1RnUDUyMDAzYjlNbWhTS2p0?=
 =?utf-8?B?U1pQQTZidURsazBLNVlNMWI3RXlaaHNrNUNqWEFHYVRIQjl3YWNrWnhEaWRv?=
 =?utf-8?B?VWk3bW1XWlVndzk1ZTROekhuN3J1M3ZkZ2YyanF3UXJLbjFXU3pNYXgxYU9z?=
 =?utf-8?B?TTgyV3lESHdWd2wwemIxZHdGbi9PMWNpeWM1MnMxcHEyaDA3c3JwMHNoUS9J?=
 =?utf-8?B?OS9LTFBERU1uNHl4cmVPYjhqbUhQS1hjMzRWNDhyNkVyNk0vQjZyQ28vS2lQ?=
 =?utf-8?B?UDFrcDRaMTZXRGQ1NjNocm9aZEQySlppblJOK0UxeG9GODVyQmRtelFqMXhu?=
 =?utf-8?B?SE01MFp0MXR1SE9JQkkzZzFGZGdCbFBDN3JWdjNmS2ZKTU5ySzV4aTZYek1P?=
 =?utf-8?B?WGV4K0dGSFZvZWE0dTU4cWVSUjlUU3ZhdFlHbUF2SHk3enQyekpEZVM4Q2ls?=
 =?utf-8?B?UUU0RENtNUZNbkVzZTF4NmQzZUtSUWE2ZVFNNE40bEdOYmdlaHdtUHVHY3dU?=
 =?utf-8?B?NTZraXVMbVVCdFpBTUEzYVh6dG9Wd3ZhSkl4YzQ5dEs4dEFQTkUvbzFoU2RG?=
 =?utf-8?B?OENPandJUEtkN2NrejY1L3V0NnYzR3NsMnR2c1FzUjcyYlJpZVM2ZHBIRE9m?=
 =?utf-8?B?N2FkTVAwWnp2aVRiM3Q2akYrSENUV3p4Nkh2VEgvZEcvMnljV3ZyK0N3eklZ?=
 =?utf-8?B?QmRodCtmMEtCN1FnVFBmenNGVlQ0eE9KZ3NYRkNFMVZCN0NiKzBBZG0zRGI3?=
 =?utf-8?B?cW5JRC9oMUpMczNzMXNFaDJwZzNITU9mU1RKZEhKT3JETUFBYmdkMVBFcDBk?=
 =?utf-8?B?QzVyQ2VoVVl6eklvNkRsRlFjSmtydHhyYlV4U3hXWnB2Nmp4S0pDMGFHNHpp?=
 =?utf-8?B?cnVrNktJQkFJbmkvc2ZhcmdZdjNCa2JBTnNkSHlKeFlPeUE3QzI5YTQ4ZWV2?=
 =?utf-8?B?cVZVc2pURFg2dzZhZUpxRzlTdUNmUWlSNnZCcDloeTlYd1VkZmlEUm1IaHBk?=
 =?utf-8?B?RnI2Ri9NS1FDdGhKdjIvWGpwRlNub0s0R1dnV2p6WFhRVmFwd1RmNG8xaHg4?=
 =?utf-8?B?VlUyZFIreVZXaVNzM0lsOHN2ckVzYmxtU0w1YU4rSitMazlkZXJGMmFMZ3U2?=
 =?utf-8?B?K0JuTUFiQmk0WFlNQ0wyME1yem1GWi9FTVZCWGJOUG1ITGwrdzZyc1FLVlAx?=
 =?utf-8?B?SXpzU2JWU0wzY0taMVNsWVlNdk9ldC9hTXdRcjhJaDJ3YkVPMEhUWGkrdFh1?=
 =?utf-8?B?cll0Y1RPZFp1RmN0Yk5PUlJHdzNKUUQwOG5hU3Y5WUcyaTMvaFJpKzJmUW5v?=
 =?utf-8?B?eENRNFRCeTZ1RUEvMkZGeFJEZURJQVVWS2FGYmFPZjNtaHJRektFYUUwSVBJ?=
 =?utf-8?B?QXU0Wmplc3B3cU9JNURNVFZiNnZLdDFKM3prait4NXU3UlBBYytBcm5kVk5x?=
 =?utf-8?B?WE0yQ1Bsd2k5dlRzVnUvVlN4eGFkN1BtdDJiQTdIZUs3OENUd3VHeHlZaWQ2?=
 =?utf-8?B?YVNlZWxic0xpV0tYa210RFZjc0VZQlVtcEFUMTlwSkVFTmpnSmlpOHhVT0Z5?=
 =?utf-8?B?cGtDSlg4Y0p4R0NwTlM5T1VJZE9TbW03UEFzcDZ1amxWckQ4MTZWQUhNTytM?=
 =?utf-8?B?clpWRzFRS3lBRGhBZ0JwRTJkRk5XWXhRK0dDbjk0QURuZHV0THVuNzlteTN0?=
 =?utf-8?B?eGs3TlAyMUZvb1RGVmdBNmJ2WnQwcUxHbkR2eEhuaEVyMzk3TkVwZmlOUHZt?=
 =?utf-8?B?RG5ON3lvSDRyeFpUbjRjS3FmVElRRVMxLzBjNTgvc3g1bVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXpmODBzSFI2Qm43R1NhYll6R2d3MklWK25DTUcwcUVVT1AvRXNvMGlsNHpF?=
 =?utf-8?B?d004dzU4bFhqTDRMbG1pdjByM0xTczhQK2lZZzJkU1pmRzhlUnd6VzNLZExm?=
 =?utf-8?B?UXkyVTJlL0JMQndCclhKVnNEOHh1L055Nk1hT3FzWk9YeUpHUFNTOXVpT1Ey?=
 =?utf-8?B?UytzcnFabmpudlk2eWRKZCsrbzZKWmN1dzVraWJZMFNob001SElNbnpMOVFU?=
 =?utf-8?B?Ti9aSnBPQ2o5Umw1TGRPMnBNZm9RWUl1akFxNGpPVW9BZ3ZnSGRWM0c5RHow?=
 =?utf-8?B?cHhsb3B5QXpBcVZ2R1B3NnFyV3lEV1lQWXgzTndxMEk1VS9RWEtoUXh4UXJo?=
 =?utf-8?B?akc0Vm5Ma0g0WFkwMU1ZUU1NYjZydm8yVVFwNEJzVURscjBvWUFtdUtTMnJO?=
 =?utf-8?B?QUp3ZXZkS1dIVU8rNDZ3OGtMVWppMThlZ0RLYk1IeEtrVzZXUUpJRzhnMjh4?=
 =?utf-8?B?YVIzVkY1ZHptMURobjNNM3V2bTQ3OWlHSGFRcExreVZQOVVOUjc0QjZDbDR5?=
 =?utf-8?B?Q0NUS1F1bzBNWDFXL0RrZy9HZFBlb2s5Vml2TEFzeGdMUnNnUEd0WmFONXp2?=
 =?utf-8?B?ZmM0QTF6dWpzTUV2dVFxbkI5Q1h1ZlZIa1orUjE4eVdQcU11TDJvNUN5OUdW?=
 =?utf-8?B?VkZtTisrRFFzTXE2STYwSStBOENaSVBEOVZQUGZiRWIwRGpzbjRIWjVUcTk1?=
 =?utf-8?B?S1JHbmRRdW9QMzRQME8xU3RTNWE4STlXSzJaZnB4T1pPckJ0QkJaMU41R25P?=
 =?utf-8?B?VmxiSThUajZtQ0tsZ0t3YVlLUGpTYXo5NDZTUGdXbmRPWTB6ZiszZm9LbHRM?=
 =?utf-8?B?NDJWY2Jkcy9Tckx6WXFBYmpFSE4waUk1eFBCYURKZUdHNGp5T0hhQnlaSU9h?=
 =?utf-8?B?OW5lQjJBUW5pc0trTklFQzB0UXBNZW9kNVNjdUIvZVdUVW0ydkk5TmVVUVBn?=
 =?utf-8?B?b1ZlVUNkdm44K0pZWEVWMC9lSElsc0JDYkJWWkpPemdTMEFXRDQ1b2tpYWZH?=
 =?utf-8?B?Szl4a29LYzB6aENxVDloSklyUEt6Qm9QNHg1Q1E5M3NLSUlXdUR2Ums1QjNq?=
 =?utf-8?B?MG93alRweEJaL3F1UXdJU1hpRG1qRVE0SnJmMis2WGZROW9idEpqR0NnaTNW?=
 =?utf-8?B?UUU3MFhzYzBQUHRncEgxc2w4K1BwSW5IT0Z5b0o3UVcvb0NHUVVlbTdVVmxF?=
 =?utf-8?B?emFtM0ZlQ240VVN2Tm9VWHJTLzRpUVlOOXppQkJUMGlOWHlkbjlWOVVKWEVv?=
 =?utf-8?B?dGtEQXJZR2RQUTB5NG5KaFZNTTcxR25VTGFBSGQ1ajlsVy9lNUdpNEFwZzdx?=
 =?utf-8?B?a2JvZlRQTkVsSmFSN0tsSmNyRDNNR3VDS0lkMXE1emwxMTBYdHlVb2RDSWZ6?=
 =?utf-8?B?dkxRcGh4VHVnUTYxQ2Q0OWdBelIydFZGVE5BVUpGZmxKRmVVZlAzTE9hQ0Uw?=
 =?utf-8?B?OUdFbi9YZlI0YzlTcmlBZGRGN3RvNUsySWdiTC90VDg2R0lldE1lOXAzV2hW?=
 =?utf-8?B?cXlibE5MaG8xSE53dW5QUkQwenFmWjRxUzVOS2V2dDZBZ0c2cHZDNFNqc2xX?=
 =?utf-8?B?RjYxYlAxVlpWVWNiL3F5U0R4eElvNi9TUmRmZjNoaFFheWY4K21ZSEZjMERp?=
 =?utf-8?B?Nzlad1ZLWUcxcmZ0bGhTb0NtV1h3dHdrNlpUUTd3b2NOQ21EeVUyeGlhMjlP?=
 =?utf-8?B?YTM1N2hsSk5vbWh5K2Eydzh3NURhTlVWVmp6NzBuV2NFSVIyZlBDV1hvQ1BK?=
 =?utf-8?B?TjFoc05UOWNPSjIrc3hiS3RreFRoQnRRb1BkTkRubkxKL1hJMUIrM2RlOWtV?=
 =?utf-8?B?RkR3UWxzcnFEcEFEYmtGL1VqZGN5ZHpIdWY1b3RGejdac29JQU44QkZPZ0sr?=
 =?utf-8?B?bkRBa0tYVGVyTVJsayt3TkVlR0Y0YmUrR3Izb1JzcE1oSFE5OUZBakR6THpl?=
 =?utf-8?B?V09GeGF3TDVFbzNQTWoxckxUMXBCdmtka3ZFNEZzWUZ5QjJmUTI0N0pIOG00?=
 =?utf-8?B?NFB5WjYzOTZuWEcrZGlmVHdLd3NvbGlVN2ZXZFVvc2ZDL0pFT2MyY0RGbkN0?=
 =?utf-8?B?Z2RjUXFjNUl1Y3JSZ3NYTVByWC9pRlNyaEE0eExUM01sL3ZlbGg2blBnTEo0?=
 =?utf-8?Q?OmVgBo8osc6XDvbVq9Y6foXZH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCE1043071A3AE44A25720EF206F1E61@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd479aed-8c58-40ac-a67a-08dcc24c8d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 01:48:41.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9t3/1cZotNyt0GqALkp3VLWuv4Z+eOxnwugxV1rW39Ayh6SNsxp6PXW5Cg9l46gjG3j7zTSfZO3dTt645QiQ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8409
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDExOjA0ICswMTAwLCBNZWwgR29ybWFuIHdyb3RlOg0KPiBP
biBNb24sIEF1ZyAwNSwgMjAyNCBhdCAwNDoyMjoyOFBNICswODAwLCBZdWppZSBMaXUgd3JvdGU6
DQo+ID4gUHJvYmxlbSBzdGF0ZW1lbnQ6DQo+ID4gU2luY2UgY29tbWl0IGZjMTM3YzBkZGFiMiAo
InNjaGVkL251bWE6IGVuaGFuY2Ugdm1hIHNjYW5uaW5nIGxvZ2ljIiksIHRoZQ0KPiA+IE51bWEg
dm1hIHNjYW4gb3ZlcmhlYWQgaGFzIGJlZW4gcmVkdWNlZCBhIGxvdC4gTWVhbndoaWxlLCB0aGUg
cmVkdWNpbmcgb2YNCj4gPiB0aGUgdm1hIHNjYW4gbWlnaHQgY3JlYXRlIGxlc3MgTnVtYSBwYWdl
IGZhdWx0IGluZm9ybWF0aW9uLiBUaGUNCj4gPiBpbnN1ZmZpY2llbnQgaW5mb3JtYXRpb24gbWFr
ZXMgaXQgaGFyZGVyIGZvciB0aGUgTnVtYSBiYWxhbmNlciB0byBtYWtlDQo+ID4gZGVjaXNpb24u
IExhdGVyLCBjb21taXQgYjdhNWI1MzdjNTVjMDggKCJzY2hlZC9udW1hOiBDb21wbGV0ZSBzY2Fu
bmluZyBvZg0KPiA+IHBhcnRpYWwgVk1BcyByZWdhcmRsZXNzIG9mIFBJRCBhY3Rpdml0eSIpIGFu
ZCBjb21taXQgODRkYjQ3Y2E3MTQ2ZDcNCj4gPiAoInNjaGVkL251bWE6IEZpeCBtbSBudW1hX3Nj
YW5fc2VxIGJhc2VkIHVuY29uZGl0aW9uYWwgc2NhbiIpIGFyZSBmb3VuZA0KPiA+IHRvIGJyaW5n
IGJhY2sgcGFydCBvZiB0aGUgcGVyZm9ybWFuY2UuDQo+ID4gDQo+ID4gUmVjZW50bHkgd2hlbiBy
dW5uaW5nIFNQRUNjcHUgb21uZXRwcF9yIG9uIGEgMzIwIENQVXMvMiBTb2NrZXRzIHN5c3RlbSwN
Cj4gPiBhIGxvbmcgZHVyYXRpb24gb2YgcmVtb3RlIE51bWEgbm9kZSByZWFkIHdhcyBvYnNlcnZl
ZCBieSBQTVUgZXZlbnRzOg0KPiA+IEEgZmV3IGNvcmVzIGhhdmluZyB+NTAwTUIvcyByZW1vdGUg
bWVtb3J5IGFjY2VzcyBmb3IgfjIwIHNlY29uZHMuDQo+ID4gSXQgY2F1c2VzIGhpZ2ggY29yZS10
by1jb3JlIHZhcmlhbmNlIGFuZCBwZXJmb3JtYW5jZSBwZW5hbHR5LiBBZnRlciB0aGUNCj4gPiBp
bnZlc3RpZ2F0aW9uLCBpdCBpcyBmb3VuZCB0aGF0IG1hbnkgdm1hcyBhcmUgc2tpcHBlZCBkdWUg
dG8gdGhlIGFjdGl2ZQ0KPiA+IFBJRCBjaGVjay4gQWNjb3JkaW5nIHRvIHRoZSB0cmFjZSBldmVu
dHMsIGluIG1vc3QgY2FzZXMsIHZtYV9pc19hY2Nlc3NlZCgpDQo+ID4gcmV0dXJucyBmYWxzZSBi
ZWNhdXNlIHRoZSBoaXN0b3J5IGFjY2VzcyBpbmZvIHN0b3JlZCBpbiBwaWRzX2FjdGl2ZQ0KPiA+
IGFycmF5IGhhcyBiZWVuIGNsZWFyZWQuDQo+ID4gDQo+ID4gUHJvcG9zYWw6DQo+ID4gVGhlIG1h
aW4gaWRlYSBpcyB0byBhZGp1c3Qgdm1hX2lzX2FjY2Vzc2VkKCkgdG8gbGV0IGl0IHJldHVybiB0
cnVlIGVhc2llci4NCj4gPiBUaHVzIGNvbXBhcmUgdGhlIGRpZmYgYmV0d2VlbiBtbS0+bnVtYV9z
Y2FuX3NlcSBhbmQNCj4gPiB2bWEtPm51bWFiX3N0YXRlLT5wcmV2X3NjYW5fc2VxLiBJZiB0aGUg
ZGlmZiBoYXMgZXhjZWVkZWQgdGhlIHRocmVzaG9sZCwNCj4gPiBzY2FuIHRoZSB2bWEuDQo+ID4g
DQo+ID4gVGhpcyBwYXRjaCBlc3BlY2lhbGx5IGhlbHBzIHRoZSBjYXNlcyB3aGVyZSB0aGVyZSBh
cmUgc21hbGwgbnVtYmVyIG9mDQo+ID4gdGhyZWFkcywgbGlrZSB0aGUgcHJvY2Vzcy1iYXNlZCBT
UEVDY3B1LiBXaXRob3V0IHRoaXMgcGF0Y2gsIGlmIHRoZQ0KPiA+IFNQRUNjcHUgcHJvY2VzcyBh
Y2Nlc3MgdGhlIHZtYSBhdCB0aGUgYmVnaW5uaW5nLCB0aGVuIHNsZWVwcyBmb3IgYSBsb25nDQo+
ID4gdGltZSwgdGhlIHBpZF9hY3RpdmUgYXJyYXkgd2lsbCBiZSBjbGVhcmVkLiBBIGEgcmVzdWx0
LCBpZiB0aGlzIHByb2Nlc3MNCj4gPiBpcyB3b2tlbiB1cCBhZ2FpbiwgaXQgbmV2ZXIgaGFzIGEg
Y2hhbmNlIHRvIHNldCBwcm90X25vbmUgYW55bW9yZS4NCj4gPiBCZWNhdXNlIG9ubHkgdGhlIGZp
cnN0IDIgdGltZXMgb2YgYWNjZXNzIGlzIGdyYW50ZWQgZm9yIHZtYSBzY2FuOg0KPiA+IChjdXJy
ZW50LT5tbS0+bnVtYV9zY2FuX3NlcSkgLSB2bWEtPm51bWFiX3N0YXRlLT5zdGFydF9zY2FuX3Nl
cSkgPCAyDQo+ID4gdG8gYmUgd29yc2UsIG5vIG90aGVyIHRocmVhZHMgd2l0aGluIHRoZSB0YXNr
IGNhbiBoZWxwIHNldCB0aGUgcHJvdF9ub25lLg0KPiA+IFRoaXMgY2F1c2VzIGluZm9ybWF0aW9u
IGxvc3QuDQo+ID4gDQo+ID4gUmFnaGF2ZW5kcmEgaGVscGVkIHRlc3QgY3VycmVudCBwYXRjaCBh
bmQgZ290IHRoZSBwb3NpdGl2ZSByZXN1bHQNCj4gPiBvbiB0aGUgQU1EIHBsYXRmb3JtOg0KPiA+
IA0KPiA+IGF1dG9udW1hYmVuY2ggTlVNQTAxDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJhc2UgICAgICAgICAgICAgICAgICBwYXRjaGVkDQo+ID4gQW1lYW4gICAgIHN5c3QtTlVN
QTAxICAgICAgMTk0LjA1ICggICAwLjAwJSkgICAgICAxNjUuMTEgKiAgMTQuOTIlKg0KPiA+IEFt
ZWFuICAgICBlbHNwLU5VTUEwMSAgICAgIDMyNC44NiAoICAgMC4wMCUpICAgICAgMzE1LjU4ICog
ICAyLjg2JSoNCj4gPiANCj4gPiBEdXJhdGlvbiBVc2VyICAgICAgMzgwMzQ1LjM2ICAgMzY4MjUy
LjA0DQo+ID4gRHVyYXRpb24gU3lzdGVtICAgICAgMTM1OC44OSAgICAgMTE1Ni4yMw0KPiA+IER1
cmF0aW9uIEVsYXBzZWQgICAgIDIyNzcuNDUgICAgIDIyMTMuMjUNCj4gPiANCj4gPiBhdXRvbnVt
YWJlbmNoIE5VTUEwMg0KPiA+IA0KPiA+IEFtZWFuICAgICBzeXN0LU5VTUEwMiAgICAgICAgMS4x
MiAoICAgMC4wMCUpICAgICAgICAxLjA5ICogICAyLjkzJSoNCj4gPiBBbWVhbiAgICAgZWxzcC1O
VU1BMDIgICAgICAgIDMuNTAgKCAgIDAuMDAlKSAgICAgICAgMy41NiAqICAtMS44NCUqDQo+ID4g
DQo+ID4gRHVyYXRpb24gVXNlciAgICAgICAgMTUxMy4yMyAgICAgMTU3NS40OA0KPiA+IER1cmF0
aW9uIFN5c3RlbSAgICAgICAgIDguMzMgICAgICAgIDguMTMNCj4gPiBEdXJhdGlvbiBFbGFwc2Vk
ICAgICAgIDI4LjU5ICAgICAgIDI5LjcxDQo+ID4gDQo+ID4ga2VybmJlbmNoDQo+ID4gDQo+ID4g
QW1lYW4gICAgIHVzZXItMjU2ICAgIDIyOTM1LjQyICggICAwLjAwJSkgICAgMjI1MzUuMTkgKiAg
IDEuNzUlKg0KPiA+IEFtZWFuICAgICBzeXN0LTI1NiAgICAgNzI4NC4xNiAoICAgMC4wMCUpICAg
ICA3NjA4LjcyICogIC00LjQ2JSoNCj4gPiBBbWVhbiAgICAgZWxzcC0yNTYgICAgICAxNTkuMDEg
KCAgIDAuMDAlKSAgICAgIDE1OC4xNyAqICAgMC41MyUqDQo+ID4gDQo+ID4gRHVyYXRpb24gVXNl
ciAgICAgICA2ODgxNi40MSAgICA2NzYxNS43NA0KPiA+IER1cmF0aW9uIFN5c3RlbSAgICAgMjE4
NzMuOTQgICAgMjI4NDguMDgNCj4gPiBEdXJhdGlvbiBFbGFwc2VkICAgICAgNTA2LjY2ICAgICAg
NTA0LjU1DQo+ID4gDQo+ID4gSW50ZWwgMjU2IENQVXMvMiBTb2NrZXRzOg0KPiA+IGF1dG9udW1h
IGJlbmNobWFyayBhbHNvIHNob3dzIGltcHJvdmVtZW50czoNCj4gPiANCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHY2LjEwLXJjNSAgICAgICAgICAg
ICAgdjYuMTAtcmM1DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICtwYXRjaA0KPiA+IEFtZWFuICAgICBz
eXN0LU5VTUEwMSAgICAgICAgICAgICAgICAgIDI0NS44NSAoICAgMC4wMCUpICAgICAgMjMwLjg0
ICogICA2LjExJSoNCj4gPiBBbWVhbiAgICAgc3lzdC1OVU1BMDFfVEhSRUFETE9DQUwgICAgICAy
MDUuMjcgKCAgIDAuMDAlKSAgICAgIDE5MS44NiAqICAgNi41MyUqDQo+ID4gQW1lYW4gICAgIHN5
c3QtTlVNQTAyICAgICAgICAgICAgICAgICAgIDE4LjU3ICggICAwLjAwJSkgICAgICAgMTguMDkg
KiAgIDIuNTglKg0KPiA+IEFtZWFuICAgICBzeXN0LU5VTUEwMl9TTVQgICAgICAgICAgICAgICAg
Mi42MyAoICAgMC4wMCUpICAgICAgICAyLjU0ICogICAzLjQ3JSoNCj4gPiBBbWVhbiAgICAgZWxz
cC1OVU1BMDEgICAgICAgICAgICAgICAgICA1MTcuMTcgKCAgIDAuMDAlKSAgICAgIDUyNi4zNCAq
ICAtMS43NyUqDQo+ID4gQW1lYW4gICAgIGVsc3AtTlVNQTAxX1RIUkVBRExPQ0FMICAgICAgIDk5
LjkyICggICAwLjAwJSkgICAgICAxMDAuNTkgKiAgLTAuNjclKg0KPiA+IEFtZWFuICAgICBlbHNw
LU5VTUEwMiAgICAgICAgICAgICAgICAgICAxNS44MSAoICAgMC4wMCUpICAgICAgIDE1LjcyICog
ICAwLjU5JSoNCj4gPiBBbWVhbiAgICAgZWxzcC1OVU1BMDJfU01UICAgICAgICAgICAgICAgMTMu
MjMgKCAgIDAuMDAlKSAgICAgICAxMi44OSAqICAgMi41MyUqDQo+ID4gDQo+ID4gICAgICAgICAg
ICAgICAgICAgIHY2LjEwLXJjNSAgIHY2LjEwLXJjNQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArcGF0Y2gNCj4gPiBEdXJhdGlvbiBVc2VyICAgICAxMDY0MDEwLjE2ICAx
MDc1NDE2LjIzDQo+ID4gRHVyYXRpb24gU3lzdGVtICAgICAgMzMwNy42NCAgICAgMzEwNC42Ng0K
PiA+IER1cmF0aW9uIEVsYXBzZWQgICAgIDQ1MzcuNTQgICAgIDQ2MDQuNzMNCj4gPiANCj4gPiBU
aGUgU1BFQ2NwdSByZW1vdGUgbm9kZSBhY2Nlc3MgaXNzdWUgZGlzYXBwZWFycyB3aXRoIHRoZSBw
YXRjaCBhcHBsaWVkLg0KPiA+IA0KPiA+IEZpeGVzOiBmYzEzN2MwZGRhYjIgKCJzY2hlZC9udW1h
OiBlbmhhbmNlIHZtYSBzY2FubmluZyBsb2dpYyIpDQo+ID4gUmVwb3J0ZWQtYnk6IFhpYW9waW5n
IFpob3UgPHhpYW9waW5nLnpob3VAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWFuZC10ZXN0ZWQt
Ynk6IFJhZ2hhdmVuZHJhIEsgVCA8cmFnaGF2ZW5kcmEua3RAYW1kLmNvbT4NCj4gPiBDby1kZXZl
bG9wZWQtYnk6IENoZW4gWXUgPHl1LmMuY2hlbkBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2hlbiBZdSA8eXUuYy5jaGVuQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdWpp
ZSBMaXUgPHl1amllLmxpdUBpbnRlbC5jb20+DQo+IA0KPiBPaywgSSBkaWRuJ3QgZXhhY3RseSBy
ZXBsaWNhdGUgdGhlIGF1dG9udW1hIHRlc3QgcmVzdWx0cyBidXQgdGhlbiBhZ2FpbiwNCj4gSSdk
IGJlIGEgbGl0dGxlIHN1cnByaXNlZCBpdCB3YXMgYWZmZWN0ZWQgYnkgdGhpcyBpc3N1ZS4gVGhl
IHJlc2Nhbg0KPiBkZWNpc2lvbiBpcyBhIGJpdCBhcmJpdHJhcnkgYnV0IEkgc2VlIG5vIG9idmlv
dXNseSBiZXR0ZXIgYWx0ZXJuYXRpdmUNCj4gYW5kIHRoZSBwYXRjaCBpcyBmaXhpbmcgYW4gaW1w
b3J0YW50IGNvcm5lciBjYXNlIHNvDQo+IA0KPiBBY2tlZC1ieTogTWVsIEdvcm1hbiA8bWdvcm1h
bkB0ZWNoc2luZ3VsYXJpdHkubmV0Pg0KPiANCj4gU29ycnkgZm9yIHRoZSBsb25nIGRlbGF5IGlu
IHJldmlld2luZywgbXkgYmFja2xvZyBmb3IgdXBzdHJlYW0gd29yayBpcw0KPiBpbnNhbmUgOigN
Cg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHRpbWUgdG8gcmV2aWV3IHRoaXMgcGF0Y2guDQoNCkJl
c3QgUmVnYXJkcywNCll1amllDQo=

