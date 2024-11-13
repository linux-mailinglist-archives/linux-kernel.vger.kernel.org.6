Return-Path: <linux-kernel+bounces-407111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B39C6901
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F85B264CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D94176AAE;
	Wed, 13 Nov 2024 05:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHqvIjiM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4F47081F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477596; cv=fail; b=bLS6xWdKiDvvNBi98yNW4qzjSQS/CflPbMOF9ozXTqUlWVCW+V/Gc/tdWpvs3/M1yMMkI1ZRY/9qeeDPp6azK9/4DF5unSIp8W+3OiQAAcO2DMJMgQUc5lD4OSCKpOWYq0Nt54/ebCbXCwBZz2H3l1ejZEueLM9pkrQNLwBqf40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477596; c=relaxed/simple;
	bh=+6uBf7vBRNpDJqSq1TyuW9glzKbpdYHo0egm89Fv+kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nBTAwuyox+dQRmuVMWbCdo5IOpj6/mShvtAzJjp9wTjkLgzIcmxKt966YNfBVDYSAVzPIfZoO85YZkvhyfoPqpIx7RLoVM9HYZOAxKy6SXyKxxa2xPVi7nIwwQf6+yc1EKz7CIHO4iMwQ3ExHww4zu4viq/Y7Q+f6lvzaTb1xWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHqvIjiM; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731477594; x=1763013594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+6uBf7vBRNpDJqSq1TyuW9glzKbpdYHo0egm89Fv+kA=;
  b=LHqvIjiMJfdNNislUXlxqnJAseeHSkmoftFt8wOoMGsMFP1T2aI/5vL7
   oV2dxceUqeiThtbxWu97igxgY+Uh0sokgJxuWn4L6eMQuOYQK30mai7sL
   eHdQv0DHqYHhxGEsgxCKN3n9oZZKpRhhFzx/bPxoZFYEL0MMsCJcbSNJr
   jyxeB0qsbDF0/cA+15P3qPWysckSFw7OB2IR8dINUaEIRtbcKzbPH/vFR
   032ZauvvPo1N1Gdi8agngDvbuObGUfBUGGbhWtEWIN7qq4hKw/C3nZvb2
   BYGyDDxD4ZTQlfFMXUCXTwafuuAxUd0LJnTluqAdv/g/ZoXth2guLj27/
   A==;
X-CSE-ConnectionGUID: HPYdNBP0T0yrdIrKQzDCqg==
X-CSE-MsgGUID: brD1PP48TIKV2MyaKpogYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31209714"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31209714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 21:59:53 -0800
X-CSE-ConnectionGUID: w92GlByLTK+WexJALm+gkg==
X-CSE-MsgGUID: HxvoNVweT8W3dkts3dGTiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="88177881"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 21:59:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 21:59:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 21:59:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 21:58:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMheMtGNS1moDZuXvLvuSzB/XLQVLYPISwhxoBld2Bsn8Tg/gi1dNxFy9Blf4lvF5YVXbyhVnN+ueALCgk/W6Bq1CL9Xe076Ds81sf4uyQYOn9NgmZ3U+Ca+j6TiAIebhtclxQtVPG3XohK/2cgyj9nCmtGRQXUcLKwLxGLQvPui63ZHJR/+hHSmdzjMkdlpd/77YTVAIeeCROnwZkLFtLoFe+g20WXeh63do55SBbM2vRvirGfCGQzjN4itotMkxy0aGdZ4TKZOitKv+ppp9OmJ4EUEQlsXhYd5tNy0TdhFvP1ql1kA2Ck0960oOj85sXbaE+v18ALlskY8gq0/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6uBf7vBRNpDJqSq1TyuW9glzKbpdYHo0egm89Fv+kA=;
 b=DYZFsOlK2JXPN+Dgpv1bQwP/KGzWan+4DQ1o0I8vb+3EFrgX5kZhqaGAZfzxaTzlKcxaltqb/kyCfCb8VzaJCFCUYxGAwvbK83cm9vKATiHfBRYYMARfhmAT6ttudkBT/5D+BFzUTCotxX+ppETGZx0CUWxTFsavPDwUZG2r8hAVq01fjd3mMIWJp+ODe7x41blsjFG0f20M9UyX4yEb7HKyocyZV4rmpeRNVOoh8wLFSSd7lgqvl39EqYFsgC4G60Jh0dI6t27MrNipyWl9fgrD7RrpHMz4R+hAEyrr8w/B18aeZn4hcCveC8pY0+I7uuqKc545VUuSnb/zdyjHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5671.namprd11.prod.outlook.com (2603:10b6:8:3c::24) by
 LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Wed, 13 Nov 2024 05:58:46 +0000
Received: from DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641]) by DM8PR11MB5671.namprd11.prod.outlook.com
 ([fe80::8271:3a1e:8c5c:5641%5]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:58:46 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UA=
Date: Wed, 13 Nov 2024 05:58:46 +0000
Message-ID: <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
In-Reply-To: <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5671:EE_|LV8PR11MB8747:EE_
x-ms-office365-filtering-correlation-id: c1d3b73a-d944-4f00-91dc-08dd03a83c90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDF6d2tKcXFsNFVWZ3ZZV2dLMExVLzlLaTd5R0pqZ3lDMzAxWUYzNEZmNDIw?=
 =?utf-8?B?T1BXRGlxUXU0NGc5T2daQndvckdWa0FOVVUxZU1QaXM1WEZIZWk1ekJkTE5V?=
 =?utf-8?B?RTFSdFhDVW1zbE1FQ1licG5uNTFTWTg1SVlDOVowcXBESVRHaDh0bU9IMVds?=
 =?utf-8?B?NWJWR2Rpb3dtR01lNWFaU2JOL3JHanEwL3BhL1BvOFZCMHNtRE85b21hdTNi?=
 =?utf-8?B?ZFBMTkdSWHFFT2pxVEhONWZkYU16WDBwRmZHUmc4cXBua3lHWm5tdFV5Rlhk?=
 =?utf-8?B?OTNEczg3TkxSZU90VG5Qa1FLU2VPeUppaGdCWHNmUXNFTTV5QndmMjJ3WFNM?=
 =?utf-8?B?Y1hYWGFpeWg5T1paZWdRTUZjSTdOS2NVVFJiejkyVEFYeGx2U3VNVXA3Qkw2?=
 =?utf-8?B?Ym1zM0M1d1Y4Y2Y1N1pnRERUcTNwSzFncmhyaEY5cmtKTktnaVBxMFU3c1Q4?=
 =?utf-8?B?MDRHK0w4QlpPeThZK0E0RUFMWnRWVDRMQXRSR3VlaCs5bzR3WCtIUDRUNGRs?=
 =?utf-8?B?MXlBNTVicXVxcCtzcE53R0RkeXB4Z21tZ3R3RHplRnR5SmN0THlqYmVjS0dt?=
 =?utf-8?B?c2Noa1cxMkZFV0pweUt5Vy91cXZJN2VyYjF3cDEwQ2tXVWE2QjBGTmhnNTJT?=
 =?utf-8?B?N3h1enRSbkkybmZERmxTRmpZZHVwU1BMN0RaUDk4RlI4VUE3WExLUzkzQnE1?=
 =?utf-8?B?K0luZXhpZUIzdm5YSTNSSktWTXZXTFJiQ3VRQmE5TFdqR2RicWNwM21hYjNX?=
 =?utf-8?B?L21YaGk2RHVJSE85WUtoZHFYdnFnM3NYUDJTMk9TZ21oNmpyR0ZyVzlqMEF4?=
 =?utf-8?B?a2FzNmQ2UXByTXl4SFphaDhDVEU4RDJUVU9GS3l4MFU0TkNETEgxZFQ0cGRm?=
 =?utf-8?B?Wk9pZ2tLN2x0U1c5MmUvU2hLQklVeU9wUm5CS1JabDYrOVp6MEZyaFV6aTRH?=
 =?utf-8?B?TnJMM1dLVnBRbUdhNUNsOHBrY0hLWTJwTGFBaVZWbU9ZZWc3UDZuck8xdGdY?=
 =?utf-8?B?L2pWSFZUbHRCcGxPa0NGaHFHbDFvb0dLdFRiM211Q0xSTzNwOXd2YnJzN08r?=
 =?utf-8?B?d3hOR0EzdXFyTWRMZUNqTGFFTFM3Z3I4Rkt4NzhhRVVidmhRcnhFM1F5dWxp?=
 =?utf-8?B?Wnd0ZUFUanFhd3BIQ3VHcGRRY1V2YnQyY2hKRTU1ejJOYy9tbEVTcmJPcG9Y?=
 =?utf-8?B?azZDaUQ0eXBZazFwTHZiUE9rYW1JSWRqNmpUNnZhTHp5UGpiVS95WmR2c0V1?=
 =?utf-8?B?OHUyOGVmZmhwano1Mno3UlorbU5yWVY1RHNaZjBxV2pIOGVOU21MZnR3d05I?=
 =?utf-8?B?Vk1vdWhqdjlaWCsxNSttWlFZRlFzcU9wc1NBRFp0YUpQMzJvTjlNS0JUcUcr?=
 =?utf-8?B?MmxqVmdJRXFUR01HN2o3OXJJWGZkYmxUWlZBbUNOMFFyc1RHK3VWdytwRWR6?=
 =?utf-8?B?cnZpSUMxbGdKYjR6UnJjVFdPaGN0OFBEVG5Lait2L3RtOC9PanNPLzhTZU82?=
 =?utf-8?B?eUplOEREZjZxRHB2UmsxSWdBMmd0cExGM0ZndWxSbXBUYVBJZStCdVN3akR4?=
 =?utf-8?B?ejFyTldGdWpiQnJBbE4wcm9mOGlkR1JPaUhoSlZuUi9TLzhxbU05ZktNUjNN?=
 =?utf-8?B?Yk9pZFZ6ODUwK0hSNmw4cVdsSkkwSDBCNnpZOXJGY3pNSXllZ0krVC9mTUFE?=
 =?utf-8?B?ODJJMDExR29jcm5zT1FWQVFsQjRRVWlMQnllcUlxOFBHU3dHcHN4WnhiYlJJ?=
 =?utf-8?B?RjNzNitDOTZwVkRVallrZW5hbzRIRmVSL3VYMUdMaTdNWnl5NmhmNm5jYUp3?=
 =?utf-8?Q?iLCNmesY920z7rJ1YIGLOERUb6ogb0hWNoia8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1d0SWdjeG1kSkoyYzNtL2JqVUtSbVgwdnpBVWMrTFl1RGxsZjgyaGxRN2R0?=
 =?utf-8?B?bU84d2tvb3k5M1ZmQVhmM2U2WCtiVitNQmFicHZaSFl1d2FjMDN3ZHpRbDVW?=
 =?utf-8?B?ZUs2VFBvMHFvOXY0cVFleUsrK1BNNG9qMFVjSGp5bE1SeXR1bnloc3RXKzU3?=
 =?utf-8?B?YlNzZTNhVDZIbkNRMzYyUGRXU25YQmkyTXJMTm0xRVp6Vk01N1RqWGZLVEFE?=
 =?utf-8?B?S3owdzBuVHNnRU5MeVRlMEZSQU5TQjZHT1FHSmpHYkVuMDdVY3MyMnR2MUdZ?=
 =?utf-8?B?d2NMaHJCMlE3bEFSWGRXLzNhbUYvVEZpZmtxaGVsdnJzQVBuZFQ5UkU1VmFT?=
 =?utf-8?B?OGFmWFQyVUN0RUZJR0p4UGNYd3NyTk93Q1QrRXc3UmRKZEdxdWpYVFNyd3pR?=
 =?utf-8?B?Z0JzYmF1a0pjMS9xb2hRUjB3VHNGaGtTdjJ4VEJKRGF2QmpiS2VpZzJrb0Rn?=
 =?utf-8?B?NWxuVHpFNzZmSHlpdWZVMFQwNGl1NmNBLzZEQkZ6R1NtUHY1M1h2cXVLYVJO?=
 =?utf-8?B?cmVyZERCVUU1YWtBb0pOMGdlM09FYmVnRXBRVi9Pdkt4TFhNeFZoU2sxRkF5?=
 =?utf-8?B?M3ZzL095V2J1YmpISEhLV0pEdFI5cG82WWhBTXJjd0lLUUF6M2RoWk1sSjRW?=
 =?utf-8?B?bkhtRXpOQjlVTXlXbk1qcGpQcUFLYm9GZEw1dHB4T2xFQy85ZGRaSkxkQm85?=
 =?utf-8?B?R2pHSHhuVGhldWRCSUlRZEZ2aVpwN0IxaFRsc1FGWGpMMnVNajcyU2hJbUdZ?=
 =?utf-8?B?M0R0ZFYwOXc1Qm9qSm1BL1VsaEpYYUNOaW0xM0QxMmRqZldad2JxSGViQy9n?=
 =?utf-8?B?d1QzN1Z5ZmIyNWRaZm10ZzgxYnJWa2hZUElraUxYWGpwTlNaSjJyZDJFSHJx?=
 =?utf-8?B?TjZLRi96Sjh1STBFWjljMkZXSEV1clZqak1Tamd5SHpycEkvb09FLytnR0M5?=
 =?utf-8?B?V1lMN1ZRK2ZVV2RyQUM0d2Y3eDB6NzBWK0N1Ly9EZVFHVjdzOWpYOFQ1bUxO?=
 =?utf-8?B?R3RybktzbWs0emEya2pPTWFMaWZxZmZWZHV0RnlmWHliMDJSNzFTU1VYQit0?=
 =?utf-8?B?ZkdXcDhiWWt1b3J3YVpQVkYwSUtxWGVoMVR2KzN1dUIzOWlBQTZFc1RZSW5a?=
 =?utf-8?B?OW1kUDJ4L1lYandyRTVEYjNYU0FSL1E2VDc4bE15UjNkeExLZkFvREgvaE5k?=
 =?utf-8?B?NkNqSXQzV0htNWlJZTg2YzgwVmo1d01nNWl6NUpqN2ZMVkJ6Vk1mSVQ0MWlr?=
 =?utf-8?B?SEp2OWl6K29rMnZZTTZxb2NJcTMzbFdlYjZQU3hhVmxrT3EzZHJjYnoxQjlD?=
 =?utf-8?B?U3M1UUtQM3J1bUI1NHNGeXNhTkRjQXhXRzhBTFRXMU11RHdhM2NRZVR6WXY1?=
 =?utf-8?B?b2NpM3RsdlVlSkhMMm8xNU52OTgyT1lDSno5TVZlSnB3UnRXa3VXWlVMUUlZ?=
 =?utf-8?B?aEIvTXN2aUNQU0hiZytzUjRUYWR4cjJGY1hpMXlXMjRGNlFSNzR6ckV5SXo1?=
 =?utf-8?B?Z1pqZE5QamI3WXY0VjBMVUdFemh1MmdFWktoL1pWZHptY25PcVIrNnZINldj?=
 =?utf-8?B?Z01NZndpTFh2SVJKT1ppeWRCdlU1Ukd1cU1aaGhoWUJJdDRoZ2p6LzlwSC9q?=
 =?utf-8?B?RDY3Z09ZSFdvUllHeWw2QVIzVDQ5T3dQdkFRWmZpVjdPUkNQWEFZaGoxTEVs?=
 =?utf-8?B?ajdCZ3pvMmI0U1RReXJoYk9ielY0WWNsMzh3TlJpQjVHY1RPcFdNTWllVE55?=
 =?utf-8?B?TzRwY1dJQW1RVmhiRWxjSElreDljcTVCZHRNbHJFTHYzeE10MS9WRE1ZaS90?=
 =?utf-8?B?RS9qVE1jZ1BBUWRvd1doNGhRQXhJWTFMa1ZyL3lJL0x5TmZERFoyMEFGdU52?=
 =?utf-8?B?WnpIUXpXKzJvaHpEQTVka2JGZUcrbitDK2JjcnIxRllhQkR3cFBxaEV6ZzBt?=
 =?utf-8?B?Tnc2VElZNm5yMU5JaHM5Q0JGTUFrTjZ1MVNldkNMY2xHZVNFQllIb09IZnJz?=
 =?utf-8?B?MDE4SFpyeXdtcG8zRitTL045eTNvSG1uL2FMR2RmZ3NXcjZhdFErMG9sRklF?=
 =?utf-8?B?MVkySUszUnY1Si83SjliS1pvRlhLdnczNEJSc2gzcC9SQ2ZyS3JGQm4yTEhm?=
 =?utf-8?B?Wi9BbzA3UXJaUzlYNXU2YVphMzliZGM1Vy9hWkF3TlB4bkxkWDA0UjlGN2do?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d3b73a-d944-4f00-91dc-08dd03a83c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 05:58:46.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idpkTbtH5isF7yyvrQmCDy8CdLMURhy6RmoalIjV7ETsJFS+N8I1auy5MNifkccwJ4IBbeL2+2ZpxduGoUNx27udCX2wmz1Wr56bknK85oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDI0IDk6
MzUgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWlu
Zy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRz
QGFybS5jb207IEh1YW5nLCBZaW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9A
Z21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBGZWdoYWxpLCBXYWpkaSBL
IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaA0KPiA8dmlub2RoLmdv
cGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBGaXgg
YSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4genN3YXBfZGVjb21wcmVzcygpLg0KPiANCj4g
T24gVHVlLCBOb3YgMTIsIDIwMjQgYXQgOToyNOKAr1BNIEthbmNoYW5hIFAgU3JpZGhhcg0KPiA8
a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIGlzIGEg
aG90Zml4IGZvciBhIHBvdGVudGlhbCB6cG9vbCBtZW1vcnkgbGVhayB0aGF0IGNvdWxkIHJlc3Vs
dCBpbg0KPiA+IHRoZSBleGlzdGluZyB6c3dhcF9kZWNvbXByZXNzKCk6DQo+ID4NCj4gPiAgICAg
ICAgIG11dGV4X3VubG9jaygmYWNvbXBfY3R4LT5tdXRleCk7DQo+ID4NCj4gPiAgICAgICAgIGlm
IChzcmMgIT0gYWNvbXBfY3R4LT5idWZmZXIpDQo+ID4gICAgICAgICAgICAgICAgIHpwb29sX3Vu
bWFwX2hhbmRsZSh6cG9vbCwgZW50cnktPmhhbmRsZSk7DQo+ID4NCj4gPiBSZWxlYXNpbmcgdGhl
IGxvY2sgYmVmb3JlIHRoZSBjb25kaXRpb25hbCBkb2VzIG5vdCBwcm90ZWN0IHRoZSBpbnRlZ3Jp
dHkgb2YNCj4gPiAic3JjIiwgd2hpY2ggaXMgc2V0IGVhcmxpZXIgdW5kZXIgdGhlIGFjb21wX2N0
eCBtdXRleCBsb2NrLiBUaGlzIHBvc2VzIGENCj4gPiByaXNrIGZvciB0aGUgY29uZGl0aW9uYWwg
YmVoYXZpbmcgYXMgaW50ZW5kZWQsIGFuZCBjb25zZXF1ZW50bHkgbm90DQo+ID4gdW5tYXBwaW5n
IHRoZSB6cG9vbCBoYW5kbGUsIHdoaWNoIGNvdWxkIGNhdXNlIGEgenN3YXAgenBvb2wgbWVtb3J5
DQo+IGxlYWsuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIG1vdmVzIHRoZSBtdXRleF91bmxvY2soKSB0
byBvY2N1ciBhZnRlciB0aGUgY29uZGl0aW9uYWwgYW5kDQo+ID4gc3Vic2VxdWVudCB6cG9vbF91
bm1hcF9oYW5kbGUoKS4gVGhpcyBlbnN1cmVzIHRoYXQgdGhlIHZhbHVlIG9mICJzcmMiDQo+ID4g
b2J0YWluZWQgZWFybGllciwgd2l0aCB0aGUgbXV0ZXggbG9ja2VkLCBkb2VzIG5vdCBjaGFuZ2Uu
DQo+IA0KPiBUaGUgY29tbWl0IGxvZyBpcyB0b28gY29tcGxpY2F0ZWQgYW5kIGluY29ycmVjdC4g
SXQgaXMgdGFsa2luZyBhYm91dA0KPiB0aGUgc3RhYmlsaXR5IG9mICdzcmMnLCBidXQgdGhhdCdz
IGEgbG9jYWwgdmFyaWFibGUgb24gdGhlIHN0YWNrDQo+IGFueXdheS4gSXQgZG9lc24ndCBuZWVk
IHByb3RlY3Rpb24uDQo+IA0KPiBUaGUgcHJvYmxlbSBpcyAnYWNvbXBfY3R4LT5idWZmZXInIGJl
aW5nIHJldXNlZCBhbmQgY2hhbmdlZCBhZnRlciB0aGUNCj4gbXV0ZXggaXMgcmVsZWFzZWQuIExl
YWRpbmcgdG8gdGhlIGNoZWNrIG5vdCBiZWluZyByZWxpYWJsZS4gUGxlYXNlDQo+IHNpbXBsaWZ5
IHRoaXMuDQoNClRoYW5rcyBZb3NyeS4gVGhhdCdzIGV4YWN0bHkgd2hhdCBJIG1lYW50LCBidXQg
SSB0aGluayB0aGUgd29yZGluZyBnb3QNCmNvbmZ1c2luZy4gVGhlIHByb2JsZW0gSSB3YXMgdHJ5
aW5nIHRvIGZpeCBpcyB0aGUgYWNvbXBfY3R4LT5idWZmZXINCnZhbHVlIGNoYW5naW5nIGFmdGVy
IHRoZSBsb2NrIGlzIHJlbGVhc2VkLiBUaGlzIGNvdWxkIGhhcHBlbiBhcyBhIHJlc3VsdCBvZiBh
bnkNCm90aGVyIGNvbXByZXNzIG9yIGRlY29tcHJlc3MgdGhhdCBhY3F1aXJlcyB0aGUgbG9jay4g
SSB3aWxsIHNpbXBsaWZ5IGFuZA0KY2xhcmlmeSBhY2NvcmRpbmdseS4NCg0KPiANCj4gPg0KPiA+
IEV2ZW4gdGhvdWdoIGFuIGFjdHVhbCBtZW1vcnkgbGVhayB3YXMgbm90IG9ic2VydmVkLCB0aGlz
IGZpeCBzZWVtcyBsaWtlIGENCj4gPiBjbGVhbmVyIGltcGxlbWVudGF0aW9uLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPg0KPiA+IEZpeGVzOiA5YzUwMDgzNWYyNzkgKCJtbTogenN3YXA6IGZpeCBrZXJuZWwg
QlVHIGluIHNnX2luaXRfb25lIikNCj4gPiAtLS0NCj4gPiAgbW0venN3YXAuYyB8IDMgKystDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9tbS96c3dhcC5jIGIvbW0venN3YXAuYw0KPiA+IGluZGV4IGY2MzE2
YjY2ZmIyMy4uNTg4MTBmYThmZjIzIDEwMDY0NA0KPiA+IC0tLSBhL21tL3pzd2FwLmMNCj4gPiAr
KysgYi9tbS96c3dhcC5jDQo+ID4gQEAgLTk4NiwxMCArOTg2LDExIEBAIHN0YXRpYyB2b2lkIHpz
d2FwX2RlY29tcHJlc3Moc3RydWN0DQo+IHpzd2FwX2VudHJ5ICplbnRyeSwgc3RydWN0IGZvbGlv
ICpmb2xpbykNCj4gPiAgICAgICAgIGFjb21wX3JlcXVlc3Rfc2V0X3BhcmFtcyhhY29tcF9jdHgt
PnJlcSwgJmlucHV0LCAmb3V0cHV0LCBlbnRyeS0NCj4gPmxlbmd0aCwgUEFHRV9TSVpFKTsNCj4g
PiAgICAgICAgIEJVR19PTihjcnlwdG9fd2FpdF9yZXEoY3J5cHRvX2Fjb21wX2RlY29tcHJlc3Mo
YWNvbXBfY3R4LQ0KPiA+cmVxKSwgJmFjb21wX2N0eC0+d2FpdCkpOw0KPiA+ICAgICAgICAgQlVH
X09OKGFjb21wX2N0eC0+cmVxLT5kbGVuICE9IFBBR0VfU0laRSk7DQo+ID4gLSAgICAgICBtdXRl
eF91bmxvY2soJmFjb21wX2N0eC0+bXV0ZXgpOw0KPiA+DQo+ID4gICAgICAgICBpZiAoc3JjICE9
IGFjb21wX2N0eC0+YnVmZmVyKQ0KPiA+ICAgICAgICAgICAgICAgICB6cG9vbF91bm1hcF9oYW5k
bGUoenBvb2wsIGVudHJ5LT5oYW5kbGUpOw0KPiANCj4gQWN0dWFsbHkgbm93IHRoYXQgSSB0aGlu
ayBtb3JlIGFib3V0IGl0LCBJIHRoaW5rIHRoaXMgY2hlY2sgaXNuJ3QNCj4gZW50aXJlbHkgc2Fm
ZSwgZXZlbiB1bmRlciB0aGUgbG9jay4gSXMgaXQgcG9zc2libGUgdGhhdA0KPiAnYWNvbXBfY3R4
LT5idWZmZXInIGp1c3QgaGFwcGVucyB0byBiZSBlcXVhbCB0byAnc3JjJyBmcm9tIGEgcHJldmlv
dXMNCj4gZGVjb21wcmVzc2lvbiBhdCB0aGUgc2FtZSBoYW5kbGU/IEluIHRoaXMgY2FzZSwgd2Ug
d2lsbCBhbHNvDQo+IG1pc3Rha2VubHkgc2tpcCB0aGUgdW5tYXAuDQoNCklmIHdlIG1vdmUgdGhl
IG11dGV4X3VubG9jayB0byBoYXBwZW4gYWZ0ZXIgdGhlIGNvbmRpdGlvbmFsIGFuZCB1bm1hcCwN
CnNob3VsZG4ndCB0aGF0IGJlIHN1ZmZpY2llbnQgdW5kZXIgYWxsIGNvbmRpdGlvbnM/IFdpdGgg
dGhlIGZpeCwgInNyYyIgY2FuDQp0YWtlIG9uIG9ubHkgMiB2YWx1ZXMgaW4gdGhpcyBwcm9jZWR1
cmU6IHRoZSBtYXBwZWQgaGFuZGxlIG9yDQphY29tcF9jdHgtPmJ1ZmZlci4gVGhlIG9ubHkgYW1i
aWd1aXR5IHdvdWxkIGJlIGluIHRoZSAodW5saWtlbHk/KSBjYXNlDQppZiB0aGUgbWFwcGVkIHpw
b29sIGhhbmRsZSBoYXBwZW5zIHRvIGJlIGVxdWFsIHRvIGFjb21wX2N0eC0+YnVmZmVyLg0KDQpQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgSSBhbSBtaXNzaW5nIGFueXRoaW5nLg0KDQo+IA0KPiBJdCB3
b3VsZCBiZSBtb3JlIHJlbGlhYmxlIHRvIHNldCBhIGJvb2xlYW4gdmFyaWFibGUgaWYgd2UgY29w
eSB0bw0KPiBhY29tcF9jdHgtPmJ1ZmZlciBhbmQgZG8gdGhlIHVubWFwLCBhbmQgY2hlY2sgdGhh
dCBmbGFnIGhlcmUgdG8gY2hlY2sNCj4gaWYgdGhlIHVubWFwIHdhcyBkb25lIG9yIG5vdC4NCg0K
U3VyZSwgdGhpcyBjb3VsZCBiZSBkb25lLCBidXQgbm90IHN1cmUgaWYgaXQgaXMgcmVxdWlyZWQu
IFBsZWFzZSBsZXQgbWUga25vdw0KaWYgd2Ugc3RpbGwgbmVlZCB0aGUgYm9vbGVhbiB2YXJpYWJs
ZSBpbiBhZGRpdGlvbiB0byBtb3ZpbmcgdGhlIG11dGV4X3VubG9jaygpLg0KDQpUaGFua3MsDQpL
YW5jaGFuYQ0KDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIG11dGV4X3VubG9jaygmYWNvbXBfY3R4
LT5tdXRleCk7DQo+ID4gIH0NCj4gPg0KPiA+ICAvKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqDQo+ID4NCj4gPiBiYXNlLWNvbW1pdDogMGU1YmRlZGIzOWRlZDc2N2JmZjRjNjE4NDIy
NTU3ODU5NWNlZTk4Yw0KPiA+IC0tDQo+ID4gMi4yNy4wDQo+ID4NCg==

