Return-Path: <linux-kernel+bounces-411356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5F9CF6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD47B227EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0B31E1A33;
	Fri, 15 Nov 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3cs0LgA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0F157A5C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731705247; cv=fail; b=XNBLAn2f9HAmMKP23AV70JNc6AhSxk++vKIcZ5TQcP813mXJzumKVqtS80an1eFrlCxMjHyEAM+CaSIAE9Hch0VURVGgUTz2CuEQLPjzcCmFbeB1WDWXFHugGhBO3rN9GXq8xXAO2X8K0ENDA5vySNexjzbV3dRHIadfgvalFR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731705247; c=relaxed/simple;
	bh=mHjut5lgvDD/XRtP9jd+i8fuiHvQ0epVSytJAtSzkWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mn7OL9nseozM2Uuu2wQzomTG3aU0nu4SkYGnD8H19hkxvay5lus4v0lWnhTqlVsRLMRrYSwhYXDYWBCwIvOOk9EiC2fblkhWuNWKeDNnJLJsB5+tLF4Z5AL+/L0ZT/jKTs/tHTXfSgz2Sik8ZK2gVSl3rDiPA/F3/ulmzGvcuBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3cs0LgA; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731705246; x=1763241246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mHjut5lgvDD/XRtP9jd+i8fuiHvQ0epVSytJAtSzkWc=;
  b=F3cs0LgAi9DGTebmdDwEYNiVMsjFpA7hWVl9jN5jmbY9XNDk1qsJu1wV
   JeYKf1fsgON36ziTACsvDDvu4xLUIOEVHoJE78bxgc29+5Al5lc0/Gw1i
   EgOaCTuN6wUFdE5C52vIrwLv78xY6DlCs4WbJTLPZeUB/Jsvfi7Opz8rc
   222oj1Uu3OTPmNhMwZH7qC6LYyxRqZgqbEAO0XR/Aep4DL1IZrbZJxFVC
   DHJjPX6kOlkqdTFvsFO0ky+hsfH0dnPCaDw4RSL3VF0nGvx9gqSOo6AGH
   tLeW1AFdB/klVx88/N3EQuxyToNv6SFpWOfCDWTL3cgxqZt02K4fVZZiO
   w==;
X-CSE-ConnectionGUID: r1JyxTkLQwu8WkoE9wTKHg==
X-CSE-MsgGUID: DFmpElNDQ3ikvM/fDGpjug==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31115908"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31115908"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 13:13:25 -0800
X-CSE-ConnectionGUID: I3FzNAp+Quuv4yRgyojTag==
X-CSE-MsgGUID: LP3/6OziSRSCPUwv9+gudw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93686599"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 13:13:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 13:13:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 13:13:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 13:12:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us8aouMk/0BSEIJpAyRTTqCWJXW7d/bizgHUEdw5pvJgXJrHyPC2jxSmtl5kx9teyd8miO2qTl5xlmRxytZCEZrSmRQDtS6KuaGJ1wCAgXcd8Ypt/ga5fJ1cpl4HxON3GFRqByaYskpk9/acivjpYe0KvhP6/1iiGflInugC7b0vTEGf2qgSxiC3IHjZcYNuheWxAMQHWe0CnkcZsOgUZT5R/QXnTQt/Izx3GzjK4ecLh94CMHA3cG6Wv5+NJ9BAv3AM8auDLHAdQq4UzgxI/NAkyvx5TdfnLTwOKZeBBdyDq9EHTZJAD5AKz1yDZX7l2ujvmK8HzzNz5aCqb9+LxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHjut5lgvDD/XRtP9jd+i8fuiHvQ0epVSytJAtSzkWc=;
 b=pHI/W8lfVePMuIMLp7hRTMmCNMay58ROmJ4Cuse6vsuYu3asy/pWKsjc+MRqkBL/hNjNjy97AhSreHSZDSX9t5GdMu9oLdjo2LgshGgnyGjjYUAWr31FInimK64A0u5az8UZTU25WdR+bKafVlVnJZUFmnWyNAT+Lyunu8D6b2jy1RTBrFuIHi33OpUfbRjtdSz2cy0TjAHJauSJocnNQrBxDPSim0Lz94FWE0zz1a4/k05Vw6JiU2+3/hIqdjveqbCK0aIuGPRwIxcAGSyPhKvks5EE20uGe36KHgVoo4D4giw7FQEMo4XfjbvAyB9MDDblXrJ02ZKtEsXxxs4A6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 21:12:40 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 21:12:40 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>
CC: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwIAALQAAgAAWEyCAADkJgIAAFDJAgAAQz4CAAnAwsA==
Date: Fri, 15 Nov 2024 21:12:40 +0000
Message-ID: <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org>
 <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
In-Reply-To: <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SJ1PR11MB6132:EE_
x-ms-office365-filtering-correlation-id: fbf4d3b0-5c75-4a32-a247-08dd05ba3d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TVYzbGd4L0p0Ykg5azZjZXloSjNKbXZJdkJHbW9OQ0VRRCtFUVlEL3RRaUdJ?=
 =?utf-8?B?RENaTVFpM0FmN0EyU1BJUGEwMUxmdGsveUl3NW0yWkordkMvOW1rU2tQTlRp?=
 =?utf-8?B?eHlOcUViTWgxald4U0liZCtUSldoUGRCVy90OVJ5TkFMMlhIdyt5MndBQVhu?=
 =?utf-8?B?T1M4UEJEMGdTY0NDSHJkdVZIanVFT3JZcis3dUt0RjRpL0xvbngyN2QxdFly?=
 =?utf-8?B?dWg0Rm5TZG1Eb0lLdmZnMTByejVjalJCbVkwT2VDRmhwS0lEc2J3SXdabzBs?=
 =?utf-8?B?S0JONmJhdW5LbGRSbU9RWFlHTHBhUUFBZm5CUjYzekNmNEdPMWVrcDlaR0dX?=
 =?utf-8?B?NEs3M3NxMEhKYlFlNElEQy9QR3ExUXo5dmgzWG5xOGVjTEVwMU1mVG1tK0Fo?=
 =?utf-8?B?UjE3UXY1SFRCc29CQnAxY0Q0UTlmdjIwbFRrYUNxb3RJNFk4TUtqMk5FVUo3?=
 =?utf-8?B?Q0ExbW5KQmRMakprbHN3UjZNbFRwbnJ2akhkOHY4VThMakF3SjF3cCtnRVpp?=
 =?utf-8?B?VFVDL2VQemxoTHB6QWhVMmx3SC9MaXF5MjZraGJlSEVmc2RnYlhUQWd4SmVD?=
 =?utf-8?B?ZmgxN2xTNmJJR1AzcVlmc05vWDZFcWNqdzROMDFZbDlmbjdRQ2VhRVNnUmo3?=
 =?utf-8?B?ZVNrN1hGNmpGUmRMcm1TR2FJUm5pTWJBNU05T2xrMjB0bHZZMm54d08wWGcx?=
 =?utf-8?B?VXdUOHB4RVlYNTIzMFFheE5zZHIzNXlXM1V1VkFNY20rd2QzMTFwSlNsZHpn?=
 =?utf-8?B?VjhTcFpONExQdWxlU09OZ3lEMHNjNUVOc20wdnRNbU43VGE0M2t4L2VxeUV0?=
 =?utf-8?B?ZXk3eFdQbDJwWUxJM01EdmVsdnZxYVZVcmYyMnRqMVN6ZGptMDVUeHppL2Js?=
 =?utf-8?B?STJxQzNRRnRYTXFBTGNucmxid05jWC9YZzA0aStXSURsZ2Rqamp4UllTTllL?=
 =?utf-8?B?SVRmMzUwUytSQmFVQTk0VUpMU0JoVWQ4eWlSTTdEbnJrTDVsVnN5d3FVQm1L?=
 =?utf-8?B?bWZ4STJjN2tvWlpEaXU5cmU2UmVqc0VIRXNoZGkvbm9rU3cxMVNsZDJjMzVr?=
 =?utf-8?B?SnNJU3NHQTRVUkppSStCZXZWTnhQSDhQcVJWMkRrVU5sSUR4Q1RzcGJvZUoz?=
 =?utf-8?B?M2NxbWhnMVUxU1BBcmpJM20ydDRqbU45TllQZmlRVDdPUFMzazMxeWRIK3V5?=
 =?utf-8?B?eExiODhyK2hhd2tWSmZuV3VmYWNCZ0tweXEwaTR1UU1IZ2xKbFVtazNYTEJB?=
 =?utf-8?B?eENESUh4RG1FZEZZRDJzbHIxVW9IR1hmSERiVmN4T0djK3BCK3g0R2loNEhl?=
 =?utf-8?B?VDQ4a2JJTHNISXp6MmhSTEN6eTkrM0o0YzVtK09iWUZwUlVBZSt0b21xZ3Bk?=
 =?utf-8?B?NEk1K1RLNnExSVdvL3JhUXRjY0Nhb3JZd0tQbzhmejdhalJpWG9PcUNCaWxC?=
 =?utf-8?B?dk03bXZxOGJOYk9hdTlnWm9mZDlQd2w1SmYraDRWbmE1RDFCYk1rTHJUdlFE?=
 =?utf-8?B?ZG9WKy9IMjZmZjc2dTVzT2JYYjQ5REZsRjRXVFZ6cmt2dFU2UUltcklKWCth?=
 =?utf-8?B?enZueTlFajF1c2RTY3VJVzEzNkRyMUhrSktOZHJ2SEJQQUowYmZucFVQVEFI?=
 =?utf-8?B?cDlTNDk4VnNzS3pVTUFvbGYwV3RpblhIUDJvMERNWW1yZHpFS2hZQTJKWnRK?=
 =?utf-8?B?MzdUS3l5Y2J0Sk5aTWZIeXBCUmV3TitLNElEMGdoeDM0V1RnY2dBZUhHQ05Z?=
 =?utf-8?B?Y0J3NW9nVzdMdEw5RCtqSFFTUEFoTzdjV2dpSFNXOTZRcE9XZkMrc2RBcXAx?=
 =?utf-8?Q?KpnVaiULWKjTEHRhKb4Ce400KiG1Km8ghOG9c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHZkQWY0WHZzSVJkRVNEZDB0K01lVGQvZ2twODJOVkJTakpUU3E1d0crMC83?=
 =?utf-8?B?ZjJkZ0JoZU9UcEpPeko1UlN4N2JsMmtMNWdKckIzN2kwSHJCWkZ2eVRCYVY0?=
 =?utf-8?B?cE41VXQ0VUVMTUZJWldMTStnQTdtVjg0UEhpZW5hcUdhQkZhRGFGcURra2Rq?=
 =?utf-8?B?bkFRMDlxUzQ4YVAxbGRpbVBsK0VOTHZOd0E1MXpCbnZ0Sjg1MWJLRnpoWm9w?=
 =?utf-8?B?SGpsU3BBdndjdGk3SGlwVVUvdFJFeGRtd2JJZ1I5S21VYm5vYktxMjdySlQ5?=
 =?utf-8?B?dWFzdElUOHVwNmlhOUNkRWRSd2Nhait4ZWZOYmovZWZ3NE9uZllOUjJrbmRu?=
 =?utf-8?B?OGxGc0FHZmh2bzhmYTFqRmF0TEU2SlJxd3FFM291WUc2OUhXdmJCSEluWUgx?=
 =?utf-8?B?bTZBOEluSVZvc0JiVlFnRUo5T1pyWHYzaml5dFVTbUhKUkdwdkNOUTQzSUkw?=
 =?utf-8?B?OFgxc1h3aUo0QnduSE9YM3QxV2xiemZxZms2dmRBOU4xY3k0bzZzbWNldmw5?=
 =?utf-8?B?Z3RtaTFoN1Fya0Z4K3lYcjljZ0REWVRGblA3akhpMVF0M09YL1MzbXFTaGxZ?=
 =?utf-8?B?L1Zyc05EUHF4M0RIRVFWSWc1Z0d3clQ3cWM1N1FYeWtwYzhLeGVYWlJLSHda?=
 =?utf-8?B?WUh5eXR3K0FpVTZMUGVLVzhEbDlHNXNIWGhYcHc4WS9Zczd3a3VzalkwZjEv?=
 =?utf-8?B?NmVqMEpjUHZ2VmFzZnl5UWxjT1I0YXhMQXJvK2p6d3lUMDlLU3VBUzc0L3Yy?=
 =?utf-8?B?bTZueHdIUzdORW02ZnNHTm9tOW54ZlZQdWg2aEVoVGM5dHZYTlpMdW9BN0VR?=
 =?utf-8?B?SWhObTVOZ0RZcitPa2xxbGRrUURsOVdwMHI5eWhWNnFqZkt2RW92R3RqNTY2?=
 =?utf-8?B?czlHakpaTHNvNnhQSmlDYkxtZWNJZlJPRG16dUg0b3VvY1BZZ1k5RXY1M1dM?=
 =?utf-8?B?VFNKejZhVWFTd3lLbThTVklSbWJuenhZWTdoSTVyODcyYmE3MHRTSkNid2RX?=
 =?utf-8?B?OVJJUHBtbWk2c3BjRUxFeS9tS1VIMFRBYU9IYmpGaTBHVi9yalllYUFVNVR1?=
 =?utf-8?B?MVZoSjBnN1ZMcDIrcVJ5eU8zYjhPWHN2VjJsTmpFc1RMektXVlRnUVpOSzlS?=
 =?utf-8?B?cC90dzk3R1BLWWtFTnZBYyswN2FOK3hjUFFFRDRiL05wZUg1WEZGVVdURkM5?=
 =?utf-8?B?YkpEbE8rN2VGSjZvSVBhcVdRTVBNMEgwc01yN3lNaXlIcURHc1hzOFRmMFdT?=
 =?utf-8?B?dDh2dVYwWjVuOUxUSmYrL1pFeU5SYkVOK0FjdFZxaWdXR0ZwbDIxeFZ5elJy?=
 =?utf-8?B?TTdxSVBpTDhCc0hsMWtBdVJKSTI2QXA0eXdWU1U1Q0NoT3p6SEovODB4N1dF?=
 =?utf-8?B?VVBnNTMwcnlxUDhEeWpFQlBWR3ZjLzJoRkZsejVpRVUrL1h5blN6MXJPTmZK?=
 =?utf-8?B?RjBuMml4UTVlNlFFWEY4WkdJcGdBT1pTYndsSzc5ak8yb1RDd0Q3UTVLYU1H?=
 =?utf-8?B?TFVrbk1mckk4ZTRlaXk0ZnQ3eFBsRVFWL1EyUEQzbzFTZmpGRVppZmNpR08x?=
 =?utf-8?B?ZEJkaXFyWkxiVUU3cmRCQ1VxdzlJT01JeTdiK0c2MVE1ZzFUS1pYa0l6b1Z3?=
 =?utf-8?B?SVFzQWV5Y2VreDRxRk9UOVloRCtvRTFYeG1LTk1VZmhlVno2clRjVTdVbnFm?=
 =?utf-8?B?M2o4SUdMODUrRG1CSmtONkhHWkU4QndueTNEeHJocXdDWVp5MHZ5bkZKT3Fa?=
 =?utf-8?B?ZGhSM2Q3dzlTaGp6MUMxOHJaa3RMbkI2dUxkT1dSa081VjdOT3Z5YlBuVFgv?=
 =?utf-8?B?NUlDYUpjZDhONlZLUUVDQVZOYUIweGpUQjZ2NG1sSXlsanFuZGJTQ2FndkJT?=
 =?utf-8?B?ak9JdUxUcWpHU1c1WkEvb2pKNjhoTXh5SFZWMjhJRVAxZkVndHhabk9PZ2Zq?=
 =?utf-8?B?Q2tRZE1OOTBHQXQxSDBJZHpYTkRVamhLMVNoL1Q1dG1CTmthNGRocG16ZFlL?=
 =?utf-8?B?VmhmbmV5cU5OdGFWOVNwUyswNFpTNHlpeGNKamd2eW5ydXBOb0xPb0Rzd0Er?=
 =?utf-8?B?eHRrQ2dxSnV0WGVybE9aODZVWkRScnVXbUhOV2FXRUpRdWNGYzQ4UUwvUXF5?=
 =?utf-8?B?ZFUyMGYrTEUySDE3cDlTYU1iM1hBQkcyTEtIM1pHdWJZaFJJdWVOTy9GR0hZ?=
 =?utf-8?B?b0g3U21XbnBTbzU1SzRDREZuWVV4U0NaMkNiTmlnWGg0UytyUzkzZjY0cXpu?=
 =?utf-8?B?OTJyd1BZTjFQTEhHOGk4ZjByYlRnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf4d3b0-5c75-4a32-a247-08dd05ba3d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 21:12:40.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0wcQyjHG44yb18gsAFFcxr75FGg3zZroPmr6AwBUxm4Ip2UaUNQh3MLHLxwEpeOPveJ3Ba8ZSEEGAOryN76NifE4XhqnDTZfoANOo4GFVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com

SGkgQ2hlbmdtaW5nLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENo
ZW5nbWluZyBaaG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgTm92ZW1iZXIgMTMsIDIwMjQgMTE6MjQgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAg
PGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBKb2hhbm5lcyBXZWluZXINCj4gPGhhbm5l
c0BjbXB4Y2hnLm9yZz4NCj4gQ2M6IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBZb3Ny
eSBBaG1lZA0KPiA8eW9zcnlhaG1lZEBnb29nbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IG1tQGt2YWNrLm9yZzsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsg
cnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLA0KPiBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNv
bT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgRmVn
aGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGgN
Cj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1t
OiB6c3dhcDogRml4IGEgcG90ZW50aWFsIG1lbW9yeSBsZWFrIGluDQo+IHpzd2FwX2RlY29tcHJl
c3MoKS4NCj4gDQo+IEhlbGxvLA0KPiANCj4gT24gMjAyNC8xMS8xNCAxNDozNywgU3JpZGhhciwg
S2FuY2hhbmEgUCB3cm90ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+PiBGcm9tOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gPj4gU2Vu
dDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAyNCA5OjEyIFBNDQo+ID4+IFRvOiBTcmlkaGFy
LCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+PiBDYzogTmhh
dCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT47IFlvc3J5IEFobWVkDQo+ID4+IDx5b3NyeWFobWVk
QGdvb2dsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPj4g
bW1Aa3ZhY2sub3JnOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0MkBnbWFp
bC5jb207DQo+ID4+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+Ow0KPiA+PiAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0
aW9uLm9yZzsgRmVnaGFsaSwgV2FqZGkgSw0KPiA+PiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNv
bT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjFdIG1tOiB6c3dhcDogRml4IGEgcG90ZW50aWFsIG1lbW9yeSBsZWFrIGlu
DQo+ID4+IHpzd2FwX2RlY29tcHJlc3MoKS4NCj4gPj4NCj4gPj4gT24gVGh1LCBOb3YgMTQsIDIw
MjQgYXQgMDE6NTY6MTZBTSArMDAwMCwgU3JpZGhhciwgS2FuY2hhbmEgUCB3cm90ZToNCj4gPj4+
IFNvIG15IHF1ZXN0aW9uIHdhcywgY2FuIHdlIHByZXZlbnQgdGhlIG1pZ3JhdGlvbiB0byBhIGRp
ZmZlcmVudCBjcHUNCj4gPj4+IGJ5IHJlbGlucXVpc2hpbmcgdGhlIG11dGV4IGxvY2sgYWZ0ZXIg
dGhpcyBjb25kaXRpb25hbA0KPiA+Pg0KPiA+PiBIb2xkaW5nIHRoZSBtdXRleCBkb2Vzbid0IHBy
ZXZlbnQgcHJlZW1wdGlvbi9taWdyYXRpb24uDQo+ID4NCj4gPiBTdXJlLCBob3dldmVyLCBpcyB0
aGlzIGFsc28gYXBwbGljYWJsZSB0byBob2xkaW5nIHRoZSBtdXRleCBvZiBhIHBlci1jcHUNCj4g
PiBzdHJ1Y3R1cmUgb2J0YWluZWQgdmlhIHJhd19jcHVfcHRyKCk/DQo+IA0KPiBZZXMsIHVubGVz
cyB5b3UgdXNlIG1pZ3JhdGlvbl9kaXNhYmxlKCkgb3IgY3B1c19yZWFkX2xvY2soKSB0byBwcm90
ZWN0DQo+IHRoaXMgc2VjdGlvbi4NCg0KT2suDQoNCj4gDQo+ID4NCj4gPiBXb3VsZCBob2xkaW5n
IHRoZSBtdXRleCBwcmV2ZW50IHRoZSBhY29tcF9jdHggb2YgdGhlIGNwdSBwcmlvciB0bw0KPiA+
IHRoZSBtaWdyYXRpb24gKGluIHRoZSBVQUYgc2NlbmFyaW8geW91IGRlc2NyaWJlZCkgZnJvbSBi
ZWluZyBkZWxldGVkPw0KPiANCj4gTm8sIGNwdSBvZmZsaW5lIGNhbiBraWNrIGluIGFueXRpbWUg
dG8gZnJlZSB0aGUgYWNvbXBfY3R4LT5idWZmZXIuDQo+IA0KPiA+DQo+ID4gSWYgaG9sZGluZyB0
aGUgcGVyLWNwdSBhY29tcF9jdHgncyBtdXRleCBpc24ndCBzdWZmaWNpZW50IHRvIHByZXZlbnQg
dGhlDQo+ID4gVUFGLCBJIGFncmVlLCB3ZSBtaWdodCBuZWVkIGEgd2F5IHRvIHByZXZlbnQgdGhl
IGFjb21wX2N0eCBmcm9tIGJlaW5nDQo+ID4gZGVsZXRlZCwgZS5nLiB3aXRoIHJlZmNvdW50cyBh
cyB5b3UndmUgc3VnZ2VzdGVkLCBvciB0byBub3QgdXNlIHRoZQ0KPiANCj4gUmlnaHQsIHJlZmNv
dW50IHNvbHV0aW9uIGZyb20gSm9oYW5uZXMgaXMgdmVyeSBnb29kIElNSE8uDQo+IA0KPiA+IGFj
b21wX2N0eCBhdCBhbGwgZm9yIHRoZSBjaGVjaywgaW5zdGVhZCB1c2UgYSBib29sZWFuLg0KPiAN
Cj4gQnV0IHRoaXMgaXMgbm90IGVub3VnaCB0byBqdXN0IGF2b2lkIHVzaW5nIGFjb21wX2N0eCBm
b3IgdGhlIGNoZWNrLA0KPiB0aGUgdXNhZ2Ugb2YgYWNvbXBfY3R4IGluc2lkZSB0aGUgbXV0ZXgg
aXMgYWxzbyBVQUYsIHNpbmNlIGNwdSBvZmZsaW5lDQo+IGNhbiBraWNrIGluIGFueXRpbWUgdG8g
ZnJlZSB0aGUgYWNvbXBfY3R4LT5idWZmZXIuDQoNCkkgc2VlLiBIb3cgd291bGQgdGhlIHJlZmNv
dW50cyB3b3JrPyBXb3VsZCB0aGlzIGFkZCBsYXRlbmN5IHRvIHpzd2FwDQpvcHM/IEluIGxvdyBt
ZW1vcnkgc2l0dWF0aW9ucywgY291bGQgdGhlIGNwdSBvZmZsaW5pbmcgY29kZSBvdmVyLXJpZGUN
CnRoZSByZWZjb3VudHM/DQoNCkJhc2VkIG9uIEpvaGFubmVzJyBlYXJsaWVyIGNvbW1lbnRzLCBJ
IGRvbid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlIGZvcg0KbWUgdG8gc3VibWl0IGEgdjIuDQoNClRo
YW5rcywNCkthbmNoYW5hDQoNCj4gDQo+IFRoYW5rcy4NCg==

