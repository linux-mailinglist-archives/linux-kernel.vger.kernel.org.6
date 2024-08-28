Return-Path: <linux-kernel+bounces-305597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086499630F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAABF1C231D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E201AB53F;
	Wed, 28 Aug 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzorh3Vg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1120B22
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873421; cv=fail; b=a1hGSouPgJh7rMHtVVMaR3NJ+IFJ1GfY8FW4xaduPN4HOYFT41I85Wrl35+L2sDf2k2O7Do2rIuX136XhdBZnl991KF3JWhVBS2wHQUPdK6VZPOFT1BXcnMUfpKx/zytJhUKBvNN9725qpswn4Y9yF4ifxuarr0s1GZPJShgNfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873421; c=relaxed/simple;
	bh=pctKMof9Kcoc2pelhyopin2+tgnh/w0rO/CwtdIJeak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tUZRju4gnQVmFCjXzj+O9qyJG6kjih0gzetj8+jrPggXyfPT0hcOBkLBweBh5cZF3So0Qxunjy7RWK8rhBoYAqjNxjM+MlMGy0yD+m9J5/Bck4BBwQsPJHO6hPhFf/WjjNCjPiz4wSqWn6VLMu1uKukVeFHcx5lhQS3APxxiZLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzorh3Vg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724873420; x=1756409420;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pctKMof9Kcoc2pelhyopin2+tgnh/w0rO/CwtdIJeak=;
  b=fzorh3VglcfrVlS8cEIGA6nt7WOCOWhFIVtQilzDPZAGCVkpa1cZwljm
   d2Uqv1V8XLqwXDbAZYDUzXtpXqgCG/6QOkfqfPTOfmL+xh9h6pE+EQ2Eo
   zAvjJaePoFgU6/TiF+G7l3HKiU7zFVQjE2uIV9EmvJkGrMKqXXSID0eP6
   GNiVisLuFfhfXMTGO93yHUOnwCSFj4a+eKqE6frxpHM2dy8Xs8q6c4Dhy
   JnNMhc3XjIVuexlV8PstDyfWsI3SSp/M6JNdFCvzp5Isqpes0gqpeme2L
   l77aSlORbYzKEx2tijr3XppFu2tYRagU7InaTQD3tIeAmb7IGkJUXgO8G
   g==;
X-CSE-ConnectionGUID: 3fr3Brx5R5ms9jafELL9gQ==
X-CSE-MsgGUID: GF5moTL+S/2PK7KcXMS3hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="13266318"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="13266318"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 12:30:19 -0700
X-CSE-ConnectionGUID: eloP97EWQGOayqIEnZnfnw==
X-CSE-MsgGUID: uEZT7yDuQoOGd3dQWyw8CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="100834653"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 12:30:19 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 12:30:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 12:30:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 12:30:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmxLEi9VjZy7oLDEsO8S9u1V8m+7BL8RfE1C/nPLrA3ShhZKb5dPYp5FOYnqUq0MOpdZTyQtd1C8SfmiUR7J+iYNegMrZ3sv/I8K1PDuGfYOh07aW4cTz5QzvDfX604eaGtDrSq2HejwDb1VOwa7xiJW9xmZ5tMwImfEhk9wFXXfAHJDbtLYxwJzuYUEIS39cq+6UtVJ/XG8NhuBCX9023o34R9khbKGmLVDwUcWJccW5GVsCQXKJ6rL28J8fTXU/qW/cmHuS6Ujlf4jZ0bDlaXN662x3OEB5e0RSH98FWo/5qAk+AqRKWSTiSTDUAJq2A3d5QQ0O1eDqRKMohC3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pctKMof9Kcoc2pelhyopin2+tgnh/w0rO/CwtdIJeak=;
 b=uAgE4Gno/WmFz9+bVyo+x+323oo39wkDWuWuZVbXmwPTrXjRs16/qplYsCL2g9TPvZC0v/m9T5H5dwvhtKuOcnCXI0Y4s25up+ZlhWzYLa4Wh8Lf+c7C1cffKjxxClCp0o6yFolWuk+GCMoIq3Zm7MqRsHzeG51BP+7lz5zuuHJOIgnyJEG7iilqqnpULHwVc/CwFf2OQJ3eauwVVlNiTPip6PZAl9oSHfYSMgYcgBaHo2NU8YHyqectCoIbGieLJhPKMRdSn61PRSbQvVD2cOVCUxDWoKwnKifwvIdgP+S67pLFF+aFoSiGhRnh7vrwuJE799uJTX6QDtjtc7o0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MW3PR11MB4745.namprd11.prod.outlook.com (2603:10b6:303:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 19:30:16 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 19:30:16 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+S2hY1M67nGQo0+E71Bgb79m17I80u8AgAAYyQCAACH4IA==
Date: Wed, 28 Aug 2024 19:30:16 +0000
Message-ID: <SJ0PR11MB5678BC6573E33933910C32B3C9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=POQzRoiqPSqkwDnVGH=KwyEd_vrW7XNx16cXBaLWbVUQ@mail.gmail.com>
 <CAKEwX=OvmMHANg0xub+SHj3ycgvRRqp=UDGOG4oJs7fnsQ6rGA@mail.gmail.com>
In-Reply-To: <CAKEwX=OvmMHANg0xub+SHj3ycgvRRqp=UDGOG4oJs7fnsQ6rGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MW3PR11MB4745:EE_
x-ms-office365-filtering-correlation-id: 819d22da-1f65-4796-7c98-08dcc797d831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eTduYUxwRCs0WWwxc0JpTTRlWDBFUUtEdnUwd0pINEpoSVE0NTFKS05pcEhp?=
 =?utf-8?B?L21JTTVmNzVZQitHSG16WEJLdGFTbDNiK1lEa2NzejJsdVN4TTRqb2J6Z3lr?=
 =?utf-8?B?bkhqUkIwOFBDWHZlemlDc0JrdDBpM2JmYXBBWWN0ZWhTYnZ4andQdGpvMHhE?=
 =?utf-8?B?dmF0a3R3cU11ZFd5TEhNK0Q0WmRlemZBTGJhQ1kxeTE0by9kd1BjbEsxSWZs?=
 =?utf-8?B?SHpGZFpzSXVQaDJmdUlxMjZMeWd4ZGFReC8vVGd3WXdqd2x5aHQzTndYb3ph?=
 =?utf-8?B?ME1BTUxiNy9hZWZlLzlsWWtmZmUzYktqQnora1kzT3I3N1habmlPcFFzN2ZO?=
 =?utf-8?B?am5XaXVIWVBWWmZJUjlhaGQ0UWF4cGJGMWtDVk5oR1pDbHp4QWJGb1pGbkhp?=
 =?utf-8?B?UWo2UkMyOGVWbU00UEQyQmtmSkZBUjVWRnB1YjlRY0NsbmlLNE1JaFA1Q3Bu?=
 =?utf-8?B?U0hVU1ovTG1MQlpEUWlyU2l4YkdpK3VVQ3VZRjcwVHFaUWdEaytkZHFjTkxS?=
 =?utf-8?B?YlJGZ05mdXdXOWFGQ1dDOXhaVHprZ2E2aVhQaDJ6QzVjZ25SRWJqOEpWLzl3?=
 =?utf-8?B?NGhFeU1ibUh2a1g2Y3dKTjRMZHJQV0FVRHppMnZoZy9JaC9TT3AwZEtFWGxR?=
 =?utf-8?B?RzAyb3F6eDhwTFFzREN5N1dKL0lwQkpKeXJ3SWRSbnJwSVlUTUZkc29RK28r?=
 =?utf-8?B?NXVFMWVVRUZFek54eDQwZkMraEtYWExYWElKSEdvdHZYUC92OVZ6WWlpVUZy?=
 =?utf-8?B?S3UyeFJzN1hweEt6TkJTTW16eXdOYVBTeWhwc0h3Q3cvK1dsZVVzL3N4STV4?=
 =?utf-8?B?bGRiUWt4V3A3NDJsb0VvR2hQWVJ3MlZZUTUycXJLdG81M3grNWs1MG1HWHFC?=
 =?utf-8?B?SXVPZkV3dGhPcDAzdGhSR1JkaGVsVGltNjY1S05Zbnl0a0xxU0ozdVNnYnp5?=
 =?utf-8?B?NFlqR3AxUTRsSGxITkhGM2tkSWQxRzU3N0h3Zzk2Zm42OHVYY3lYM1kxRE9C?=
 =?utf-8?B?eFF2RU1RcUcyK1lmNTVmOTFSL3VWcXJSMUxGTkttNEJVMWxBUCswQ1Brdnhk?=
 =?utf-8?B?MDFkSDBDUnlDSndNUXNQOE9udEFoTUpmVXRmRm9YQkNBM2tCN3lpUURZQmIr?=
 =?utf-8?B?Vm90dUFJVnZpdGNvVko5Nnh3SWIzQ2lzeitoSTlqQmpkbmtEcTUwdEtDUDRk?=
 =?utf-8?B?cVNCelNyZWpWenZGWVk1bTV0blV1ekpqblgyZG12VEdWQnVqUjAzRVA0NUFI?=
 =?utf-8?B?TnJ6TU5QU251b05mUkQ3UWk1b1RmN0VOREhEY01PZTRCR2d6dkthYkZtUllK?=
 =?utf-8?B?VzJvUVNrS0NkNkN1U2N3QnVLeUtHYUdrWE1mMTFuVHFIQitSZWxrRk9jSGxp?=
 =?utf-8?B?VU1hZk02aFYxTnVaK1FLM2VsZk9wUjlkOVhqUXNsZkdFMjliQ3VhQUczeExY?=
 =?utf-8?B?TjB3SC9iZlJkTXJOZXRrcDhybjVJdzRyd2E2N3UzclZsUklGbko5cTdacFoy?=
 =?utf-8?B?WHJrejhFeldBeGZBZzdmRWV4YWJPZzFQdjZYalFueUhZalNqckkzR0o0Wk5H?=
 =?utf-8?B?a3ViNWtwLzhCTzYvT1lsY0pLeTdVY1ZrVkV5YnllTFZFTHhQRlZIQmNDb2N6?=
 =?utf-8?B?YWplRUJQY3BTYVBQay9CbU5XckZXT2Q0UUdKTzkzcFlBUFZ2QlNaZi9nam51?=
 =?utf-8?B?b0hMR2M1eWVjeWljVHluQnNsaWlqRlQyb1UxRk9vV2lvVmo5ckI4aVUyWDhx?=
 =?utf-8?B?ckswaSsvNXNQR1FTWUQ4MU9NRVYxaCszdEJkQ1Y2emc3a2Rzcll0Q2F6bnJ3?=
 =?utf-8?B?cHFxWnpqcTRLeGNpM2M2ekUxQmZIeHBJRmpucnl1aEJza0JzSUh0T0JYR21M?=
 =?utf-8?B?QXBHVVRVQnZ2R0R5Y1phK1BUZUJDTWphS0VxaTlvUHpybFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnNlMlo2c1JNaU96SzJSeVFnN1AwTExheXRId1Yrd0U2T2c1a0JLdGdRRjU2?=
 =?utf-8?B?MThvZ2h3TnN4K3hnb1FMWHZXRVBISHF4eTJHMnM5dWpTZ21EeHVwVnlWdEsy?=
 =?utf-8?B?R05tQ3NXM05PK1B2eEFWTnB2UzE1NW11bUlJWW5NWUVaQ2paOW03SEVUeStl?=
 =?utf-8?B?TEJkaTBqdE1qNmw1elJDcUhVdkFoMXFnUzBXZkZsazRBY0g2OC83enRWZEx1?=
 =?utf-8?B?K052R0dRKzYvVWZYRWQ0cnVQOFFENGEyVnpBZmZiV3d1c1UxcUlNY1luZ0xL?=
 =?utf-8?B?UTJBZGdteE5SeFYwSTJZR1RYcXhjNEFHRmFPRjhrcWZ4d1d0NFJwUWF0eUdI?=
 =?utf-8?B?aTh3SURqUTZGVVRnc09tSTlSeTFORlcrUHdGRzJNbkQ2S2R0WW12V2NBN1VI?=
 =?utf-8?B?dHUrcDh4SFlNSzFkM1g2MGQyM1g2NVdjRGZGWnVwaStXVjVyKzQxQlVUcFcw?=
 =?utf-8?B?SEh0Y2laUU9EclduY0F3aFJ2dWtDRlllZ1pFekxJWjdUNHMwa0drbFhrNExh?=
 =?utf-8?B?MXRYNzNxUW1SUkZ2RHdyenpEMFphTklPUG9xc3M4SGs0bXBqRVZ3S050VXZv?=
 =?utf-8?B?MGIxeWZYZStmT2t3RDlidXpZRklDNVNXWHQwQktoZEhvaHN6WWF0aEF0TXB0?=
 =?utf-8?B?am9iUnZhZjNpTDhjUGdtNW1XaDR3RkdWVlpFelpXMml4ZEQrbHZRY3A0RVZ2?=
 =?utf-8?B?TkNzdmVaUXFVbEh4eWIwSGlLQjJRQ2lvT2lGSDkyY2xsaXY5MThMRFJ4ZGtw?=
 =?utf-8?B?cXNXb1MxNEhzQUx2WlBqUDZ1bVVwdGhuYWNxc3pDZDlDSUNMdDV5MklJcllM?=
 =?utf-8?B?NDFhMjBDVi81SHJDVmpIKyt4NGxMVHoyT3ZQYTYzUlpCUTZISlJYQ050eUFU?=
 =?utf-8?B?UnQ1dFJiREZXemR1U1BFSmZnVzlPYkZoWktHUWdDMWdxK2Rkdjlyc0ZIVktG?=
 =?utf-8?B?YUdrMzJ1VEJFZnZpcnV2QjQrclNjNVVvU3JpSnR5VzA2SnJpY2tWYkw1WFha?=
 =?utf-8?B?SnNqWVRRbE1ycG5IUEdYcnlDQ25wa0dOUkRlYzlEU3VycWMwaDZsUzRsQnVj?=
 =?utf-8?B?YW53QTg2Y3Fjdmt4UVNBeHc4RG5xWVBPY0MrMSs1cVBseXBUdmUzUE5OT0Fh?=
 =?utf-8?B?S0RRSVRZb0hCd2lza0dqNzR0dDZDZ01WWEwrejBLRnJVUzRVb2t5SnNSdG5T?=
 =?utf-8?B?dXRKN003dHRrMVVGTFJackQxYmZtQnVzV0hLeUFOVVpPQ1l0YVp4L2daSFZt?=
 =?utf-8?B?UlB5d2ZPTnhaMTZWUmtNNUo2VUJwdnJqK1hhVzdEQ2gyd3lqMDZhNDkzY1R3?=
 =?utf-8?B?ZkZHVThiM1NHZnFHVTllQWZQMzJLSHYySTFzdjJMdG9YTFJLSmtOWlJGMG5W?=
 =?utf-8?B?VGFpd0pBWFM5cEpRdnNNbis1YnlTRG5nc0F2WllWRWdJYVZUeENvUXFOQ3lx?=
 =?utf-8?B?Q3g0OVhrbzdwdy9CNUxVTmI1UnU0bVhNQi9Ock1hVm9GOUZEU3lJTVNod0Rt?=
 =?utf-8?B?NE5UUURvTTdNYTBZaFhGYlh1VG1qK2hGYVJmL3Y5QmQ5Ulc1NTdFMFdacEdj?=
 =?utf-8?B?NmdQb0lnSU5XZXpKK1Q5TEZEK2tiZWRXNU9QK0RqQjFmTXJyZEIzeFFRNjhO?=
 =?utf-8?B?YndaVTZBTXhmWTJJMHBhTkI1MFRpRHFnN3V1WGZmVUtmYVVRU1R3TmIyU1c0?=
 =?utf-8?B?bUF0WU16bVpYMzRYOWRRT25DNHIxd0srY3VZb0x4QUVvUFgxVU5lbFJSekND?=
 =?utf-8?B?bFMzNFFEekdOSlI2Qzh0Y0h0UUxWMGxXUVZ5N0NRek5vRHhCVGluNmU0YmMx?=
 =?utf-8?B?V0ZLdGlIamNOS2w2UklEYUJ1REdHNWNuUTBBaS9SYlRPb3lqRlpMbitwZnlR?=
 =?utf-8?B?TERHVEFlVldWNFk0UHdkRHZKMDZqTnlwa3JwYW5xN0NwcWJZQ21lVTU0bmVS?=
 =?utf-8?B?S1lLNDFRWkRMSlAzaHgxK09UWGpIRGZXT1hDUC90bDZGMzZ6dURIUklGUUYx?=
 =?utf-8?B?UG9JaFA1VHEwNmgvL1c2a0pSL0FiejhDOHYxUm9mL01id2ZydmhqL0lxemVS?=
 =?utf-8?B?cDRFRk1qU1dPNFlzRis4eGtsYUErSk00dVdNWGpGZkIwQ29GSGg5c3ROaTV3?=
 =?utf-8?B?eHRib2Vwc2hla0pBeWttenJkSGk2T0t1VnBLUUR5RFI3Z0FnKzVEVVhYS0Nt?=
 =?utf-8?B?L1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 819d22da-1f65-4796-7c98-08dcc797d831
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 19:30:16.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QBlTtc+e4oPBlhceefXwXmOyG3bs39k3oDGAmhKePGPvFbTaPPXaNLe392Uvk1F5R5evrhQIftaNVKkWXv+F0FqgHGhgnTse/tBOaHrSdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4745
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI4LCAyMDI0IDEwOjI0IEFN
DQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29t
Pg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3Jn
Ow0KPiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbTsgcnlhbi5yb2Jl
cnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25i
YW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgWm91LCBOYW5oYWkg
PG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2FqZGkuay5mZWdo
YWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMC8zXSBtbTogWlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBm
b2xpb3MNCj4gDQo+IE9uIFdlZCwgQXVnIDI4LCAyMDI0IGF0IDg6NTXigK9BTSBOaGF0IFBoYW0g
PG5waGFtY3NAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IGJldHRlciBieSBkZWZpbml0aW9u
Li4uIEkgd29uZGVyIGlmIGxvd2VyaW5nIHRoZSBtZW1vcnkgbGltaXQgZXZlbg0KPiA+IGZ1cnRo
ZXIgd291bGQgc2hvdyBwb3NpdGl2ZSBudW1iZXJzPyBPcg0KPiANCj4gLi4uIHBlcmhhcHMgd2l0
aCBhIHdvcmtsb2FkIHRoYXQgaGFzIGxlc3MgY29sZCBkYXRhPyBvciB1c2luZyB0aGUNCj4genN3
YXAgc2hyaW5rZXIgdG8gb2ZmIGxvYWQgc29tZSBvZiB0aGVzZSBjb2xkIG9iamVjdHMgdG8gc3dh
cD8NCj4gDQo+IEZvb2QgZm9yIHRob3VnaHQgOikNCg0KVGhpcyBtYWtlcyBzZW5zZS4gR2l2ZW4g
dGhlIG5hdHVyZSBvZiB0aGlzIHdvcmtsb2FkIHdoZXJlaW4gaXQgbWFrZXMNCmEgb25lLXRpbWUg
cmVhZC93cml0ZSBhY2Nlc3MgdG8gZWFjaCA4LWJ5dGVzIGNodW5rIGluIHRoZSBtbWFwLWVkDQpy
ZWdpb24sIHRoaXMgd291bGQgYmUgYSBnb29kIHVzZS1jYXNlIHRvIHRyeSB3aXRoIHRoZSB6c3dh
cCBzaHJpbmtlciBlbmFibGVkLg0KSSBjYW4gcnVuIHNvbWUgZXhwZXJpbWVudHMgYW5kIHNoYXJl
IHRoZSByZXN1bHRzLg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0KDQo=

