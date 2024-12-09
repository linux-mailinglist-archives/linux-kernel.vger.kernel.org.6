Return-Path: <linux-kernel+bounces-438509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B713A9EA20E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06F01884B33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BA19DFA5;
	Mon,  9 Dec 2024 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt+Y2Tqk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224019F104;
	Mon,  9 Dec 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783714; cv=fail; b=M6T4RWhzy76rvOnhVE2QpWB2dbZ3mJwBqRts8MBWh34OqscKgndMg3R+9lUr9sazfHA92K15GNMYYB4SF9AXG21A5FMrSYfUyWW7GhFPA8nVaULrFhQ1KJ4D6vgQrDAWbgC8GB9yG2OZ1HGMwfj8Toi6mo5M7LY0Cuxl0TyJzUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783714; c=relaxed/simple;
	bh=PADud7jUPiE0ZiUV/Ey2vlhX+QXlaPLpT4kx3dE5PVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N/5MLJtIIau3NX8K2EuKtLFv3x5yn2XWB5MNepC7VGynYLIJj43hgxIg2mi8NGC/3qrzgX1Sm1X0WBIK6oxLLcf9lXuwkhH/QA/KDZ7I41JyS92XVWNRda51jMm6mjzdd4dakIWhwo4ltalSkZPkLqfzDo5/HnrxkjWGaLMvq00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt+Y2Tqk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733783713; x=1765319713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PADud7jUPiE0ZiUV/Ey2vlhX+QXlaPLpT4kx3dE5PVs=;
  b=Zt+Y2Tqkf/VpiF+WSnhFAUPfh9WAOr79c+WPXzc/S/qGUj1pCeK8JxfD
   GKJ+psNypyte/6XJRpZXbm/IHUbKL3r4mBvcJuuuruEIhWGf/vb1eFm5G
   mTzxgFv0X4X60cD1aKRob0EyhOGyQmhA7dyQBbFSPL4HY2HO7BkIbzQ0S
   4Wn8COtqJ4jH6XJjGc1amFTi59vR98hVqfY7TOOmtOXDXD2+LjnzjU16b
   neOlhU7L4kYv2gv2CZlsw467x8Ekz8GIEF75YRJ+PODBkz/2J9M6zVQE/
   Y0CeXrc9UoBCmUe+TKWTNlZAKJP0yo1u4mqSGclxyUbCjiq1Iu83mpSdj
   A==;
X-CSE-ConnectionGUID: K50rkc2GS7i9c6a36DgwfA==
X-CSE-MsgGUID: yh3yOoTGQoiQpNQxX6DWyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33441957"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="33441957"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 14:35:12 -0800
X-CSE-ConnectionGUID: e6gHWxtbSbinHgFrvrLNWg==
X-CSE-MsgGUID: TdRon7VgQN6kC0+yc4MIzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="100023726"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 14:35:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 14:35:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 14:35:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 14:35:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIVIit81BNNianxXkGUYOynKCU9BTcOWcSO1QfVk5IONLl+hoE77/b0s5znGJXGTP4xcGjUBL2PZUFiL09+GlEEnihl5RjjPx9p+n46PXvOsiySXYp0l8OHor3GxMcn3QYJkoh90tcRePSRjHsDTUclIuMZQAz/D4fQMnbp2Xk08LGzv6p9Y2U+rUdKyr+GRzEtCgIm5rMdR/xuaC3lqa36GgVngS3bH85isUOqqIUUJ7+fJe8nH3nAx9aQBdoftloVsmNVfGJCiK+0dUE05qUK5ug6Jy0tRWxEDlehPyAH/4ur4ZlisO8fLoMtXvCfefS7T5n7e15Ypcs30A2UYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PADud7jUPiE0ZiUV/Ey2vlhX+QXlaPLpT4kx3dE5PVs=;
 b=ngVIgHFYQEn1zyAL0SBxWqM3dok/KoxlfMJ0sPCJS3lSfUhfGkZACdWLJ2nqarBqKhG4RRZadKTYEfhtYIF5GSPrmU9IWFVsnpnQXn/0GXMCbcXdph3J+QiQc1HtvKOcxWDQRysLqNm7R6QSLOqvc2n4/ItPbIyqidUCjuBAVTtNmqWuJrYHEUWsb7n6pnRlctTRUfN4CjNrVkTy+QpkxPYgzmPkefu9zttbmRYbRxgdp/X4HBUPdNX3qIPdQscnsdPPeaJXGQCJp3KOwmBzHxJbB8uzZ2OtbzwwSuK9s2erLmcbtjTksv7XOjej/LTRMs6zqo7RkgbTw328oG/zWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 22:35:01 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8207.017; Mon, 9 Dec 2024
 22:35:01 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, "Shaopeng Tan
 (Fujitsu)" <tan.shaopeng@fujitsu.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v11 2/8] x86/resctrl: Prepare for per-CTRL_MON group
 mba_MBps control
Thread-Topic: [PATCH v11 2/8] x86/resctrl: Prepare for per-CTRL_MON group
 mba_MBps control
Thread-Index: AQHbR/xl4acp4pgYNE+Ib74ICcEb47LeZouAgAAVKBCAAAWEgIAAA2XQ
Date: Mon, 9 Dec 2024 22:35:01 +0000
Message-ID: <SJ1PR11MB60830B8ED36CCA7E304D9E97FC3C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241206163148.83828-1-tony.luck@intel.com>
 <20241206163148.83828-3-tony.luck@intel.com>
 <20241209204519.GAZ1dW3-NjcL4Sewaf@fat_crate.local>
 <SJ1PR11MB6083BA367F2CDFC92D87FDA1FC3C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20241209222047.GKZ1dtPxIu5_Hxs1fp@fat_crate.local>
In-Reply-To: <20241209222047.GKZ1dtPxIu5_Hxs1fp@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8445:EE_
x-ms-office365-filtering-correlation-id: 25005817-6027-4017-c6dc-08dd18a1b7e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MmdySmpjS2thOWR5eXQ2cTZrU1MvRjhCbG1kNDdjQTVmdlU5L2oyeStZSXRI?=
 =?utf-8?B?V1NhS3hRODB6TUdHUFpWRUFSUTM3TFQzdXVBVllRUEJ2WTJvL3ExUXlpcEd6?=
 =?utf-8?B?QVF6L3V4dmVaL0xZNCtJSTdxTlBvTnNsK2Fjb2tqb096Z0V5bEY3elh0YmZD?=
 =?utf-8?B?SEM0dHBKUFgyOEdRcG9nRTkyVXE0NWozNnBnWW90eEpBSWpkTnVzSkNHQlFh?=
 =?utf-8?B?aERZWHdtdU5CeUxPZmxUbk9ZdDRkMmkvWUx0RVlZVTdUdEhzUzFTbW1ZcWZ2?=
 =?utf-8?B?cjdPa2UxSUJ2bThVUGRNcXNwK3k4aEcwczdrWW9kcU5JMThyOVVpOXRrS3Za?=
 =?utf-8?B?WFgxcC9XWTZ2b0xtemVHWG9jS0VGcUR2UmNIaWdxVEFGM09TVGpONFBNNnBk?=
 =?utf-8?B?d1MySlNRZXlTMDg3NEczRGVVMS9WaWR5REo0QTlBSHpucjBFY0hQaEpieTg4?=
 =?utf-8?B?SGl3Rkx6QXhodzN3cmFVUVlsNkpSZHV1VlZkdW1ldlVmZEFFQWwvaG5TMW44?=
 =?utf-8?B?eGdZRGhPcWdtSVJLV2FBUE5qZDFKS3JPREg5c0ZEbVRQdjlQR2pkOWVZdGpK?=
 =?utf-8?B?dmxNTi9zYkFyWitPc1NUeFFYTEJ6aUduYW4zMWtmcnlQdWpPZmZDY0E3enMv?=
 =?utf-8?B?bmFoNTBvZDcyWEk5QU5IaTV4amFNZjIreW5JY2tvdnJTVGJsbUlUREJLM3lH?=
 =?utf-8?B?SEVyTERxcHRGakZWbFZ5Q1VwZDFQVGpweFlnbUdWdU5heTlaYUE5TTB5N29Q?=
 =?utf-8?B?QmVpMlVVTjIzZnlRSmxRZkFWN3c1U0d6bWZPZzY4d2s1SFJCeVJlbDNtRk9M?=
 =?utf-8?B?eWpIYUJjQzluK3lrMjlWMkZVOFFzOWJpM0RpOGU5Y2Y5KzhlRkR4QUkveUJ4?=
 =?utf-8?B?QXNRZEsyZjhySlRaNW5NdmsxR1JNMVJtK1hyWnFHdktnNWZSUFN1TjZmSDhQ?=
 =?utf-8?B?WStDSnh4RDV3Q2haeVpoMGlnSGxsWEttSGFCWDBYOWhQaXFZUldJUVlTSXpz?=
 =?utf-8?B?OUIrTWhLSms0TFJEVE1WR3BOV0N4SFhRT0djczI1ekk0cTUzTDZBYzNXQjB1?=
 =?utf-8?B?dERHN2lIdEpNWVBrWTA2RUpJWkNnQ2hMdEZSODJMMUtZcC9YTVIvT2VCaW9B?=
 =?utf-8?B?ZTNsL3U1SlliN081S1JlRG8wMDNsZm9OKy9RY211c1d2UDJmTnA2dlJYVzJS?=
 =?utf-8?B?bEU0M1lzU3MvYk5jRkVUdUUxdzJRN0xNMWV3NEhTQkFZaU9YSlMvWTlsWmZI?=
 =?utf-8?B?NnhHbEsyVHB2OFlrenFYa0FjcWpnTW56ODFCRkd1cWNxaWhaZ1dNalRnVEZI?=
 =?utf-8?B?OGhFTW9RdzUrM0lEdHh3MHlPSlpzYWt5cno5VFZMd0dOL2NjNmRIL3FHWFJx?=
 =?utf-8?B?VzYwM1JWWXpYV0dqeTg4Nk9hdVdxeVA1QjBFS3ZUajN4d2FWS25CcW1aVHVY?=
 =?utf-8?B?WlRXVWk0MmVjSjhoQ0NpYmVUNVpKSlczM1U3K1dqSjFkS3ZuL3VKQkRPdnls?=
 =?utf-8?B?UjBlTUR0WE5xYWxyc0RNU1VKaWdza0dCd2ROZTEzT0RaQUcyZkdvZE4rYkJS?=
 =?utf-8?B?d2k1RzBGQ1dLNG5HcnRUQVU1Z2VEM0Z4dEZDbFJ1SHVNbG82Y3Nyenltemhk?=
 =?utf-8?B?UE1RejhDT09CK2tKTU9YbkxFZFFEenh6aFlhUWVQMVlzUHR4L1hIekJFUzdz?=
 =?utf-8?B?UnJlQXdUOXpxaGpGaFN3M21rNVZaRWh6dkEreGFJL21XNlAyVVZFcDNGQy80?=
 =?utf-8?B?QzRtamZFNHNhdlFrNGg2MFdNek5meG02WXBMWUc2NkNSSnA3Z25UWHIxSis0?=
 =?utf-8?B?RmsrZTNTdFBBUjBQUVlTcEd1Q3NjUitXdHZ6VjhoWnpaVklCUytvT0VCQ0dR?=
 =?utf-8?B?ZXNOMldKTlBwQlcxOWJTSUI1UWx1c2IzazVlSDgxZkxkTXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi9MTktXTkJaT2RtbEF1V05HOHBWTWFlTEtPaUQ1UjhiZlNWTHNZeU5OcTBk?=
 =?utf-8?B?UmRjR1NwOGY5U3g4cVpXNEQzWFl3UHFPL3VMOW1ERjBRR2hGRjRINi8yVEYz?=
 =?utf-8?B?bmpVQlNIREN2MzlYMEJxLy8yODNpd0RzenZtdHFodmtLd2lBQnNGblg4UHFx?=
 =?utf-8?B?QjRINlJCby8xSk5rZnhVVG1SbTVOekJMcDVOZU1FR1g0RGgxNnd5YWkxcC9l?=
 =?utf-8?B?aDIzblhFZmpoa215aVcyMTNtYys1WjUrdnhXTzRVcS9jQU1jOWZHS0R2YlZ1?=
 =?utf-8?B?Tk1MTGkvbFd4SHY4K0YwbjRiam9XTStaWHErd0VHTEZHdnoxbWhQbHhmTzdu?=
 =?utf-8?B?SkdjTU5TZ3BRWkYwQmppU3hmcGk1bWF3OU93aEZmYUNsMHA0b3NKNlFLTm5G?=
 =?utf-8?B?ZC84WUxpbWVSZ0xjRTR5UHhQaDBhK3NMZnAwQTlOWUNEUWRIVzNCTDNJQnhp?=
 =?utf-8?B?MEo5YWZWcGVubzRjZUVtSWlhTWk4aGJnNUlobDJwMzQwSHRaMnBISlBubnph?=
 =?utf-8?B?RnZOZ1Z2UjIvcUFKcnZuMzV2MVlveE9nUEl6STNHSG9FTFJQUDBwaW95ZUlY?=
 =?utf-8?B?emY3eUhzWEVuN3BKd3Eza1RKN2wyWjkvNkM2ZWIrWTFSWWpvZUFCTFFyTksx?=
 =?utf-8?B?alhzaTNUSDhXeHRrVmxWZUg0aUZINWdyOXRETnhPZk51Uno5bW8yK0t2N2lU?=
 =?utf-8?B?S1JCbTMyVCt0T3V0SmR2T0FoWGVjZUU0UC96MkhvMWpQV3dna1dIN2pIM2Rh?=
 =?utf-8?B?VTNubVZmRnZkcDI5S21wd3V5Q3ZtVElzT2oyY3F1eG51eHNzUHYwTVZDNW90?=
 =?utf-8?B?YW8vNThvaDVKZVVabzBYZHJxWVFwNitodG4xcVdKTnRhQ1RmK1RhZUdFaVZj?=
 =?utf-8?B?SDVKcUcxN3VwS25IM1hudTd3K2pPQVJab0pheXY1M3FhalJNSFNIUnBiMnlw?=
 =?utf-8?B?ZU45dVJscEx2OEpvZkpuZlR3dkJnSHVZNmRXZ1F6WlNCNW4ybXhYdW4rKys2?=
 =?utf-8?B?WXkvd2x0bEdLb29acW9Jc010dXBudGliN0hhUlBxeUJFWlRTRXFKZmFKejcv?=
 =?utf-8?B?V3dWVXBYZkJvTGJFOGY0ZmtVd0U0T1hEbUxCYklGQ2tSbUx6cTZSdFBaQjVN?=
 =?utf-8?B?dDVsY3o2S0xUVHdSb1VoTlNvUDdHSFYzS01vSzIrSEU4cUpQNTRMYVMrejZn?=
 =?utf-8?B?Z0ZGV0R2dHMwQXBGZEJrZmR4OURVcEZicy9VbUpWQTFsUmVHOEJrY2pDaDhO?=
 =?utf-8?B?YTYvWitYQU1Zcm5PenpiOURKZU5pN1MrbjZZbzAzcWxRdWVKcThkL2dLNW81?=
 =?utf-8?B?OXBGSWNNRGxxYlgwditxa2NwTDBxSnRMazVHTm5Tdi9Rc1dGVlp1NjFTdVdI?=
 =?utf-8?B?bm81VVVaRGFmdUJyUElQbDZIYzJ6TjM4OXRNZEd4L0NKTDVzWUgyQkhJQXBk?=
 =?utf-8?B?RVJNVHNSOG43U1NtamdTcXUxZFF6ZVk0bWFNRitCZktkaE5mR2d6ekZBL2hV?=
 =?utf-8?B?RFdIdmduM3lyTUpzUEZ6ektVeGJvSnk4VjcvdmJ3Mzl5ZXZkaDJ6eWJxUThE?=
 =?utf-8?B?R2tpOE1IQjFkaWZkYTZ2djRKVW9DMFRDVmlrM2VmT1d2cjRrNFpoY1EyVkEr?=
 =?utf-8?B?QldoZFZoYlhlb01zd3dGaTR0bGFFejJWWHhNZzdYWVJEb3JReTdpMmRLcWpQ?=
 =?utf-8?B?aFpXeU8vNzNkZXFKbFhmdk40WldlV3Yza0Zsd0tZRDc4N1V6YzFhREY5L3Zs?=
 =?utf-8?B?Rmc2SnUvOVBHcTdFUHJNNGFnMnhNTWdSZzQzRnc4UkdtcWRXcVhmZFlQbnVN?=
 =?utf-8?B?dmxoRGhxcml0c2kxWmtkRFFrNjE1Rm12RHlOL1Fqb3NBRjA5eE9MOU5JVUpC?=
 =?utf-8?B?Szg5Q3dxUlJ1UHNabElLOUM4YnlaK2hOVG5WTDFHMGF6Q09WaGhwK2tHdzlu?=
 =?utf-8?B?VDRjYlZ0VENmT21sejNnSnlFNHhlRGhYMGE1VnI0UzhJMjJRZHZRM2RJODh1?=
 =?utf-8?B?SDBrSDc1Qzl0VlM4S0lVM1FDL1l3RGZLUC9KVzM3ZlRUeGdUbWRYU04xaHZq?=
 =?utf-8?B?cEpPQkJHNm1XdzZOei9weGdyMG52VnFVOVFmSG1iU0N0cENia3F1cnZydnVz?=
 =?utf-8?Q?Xu8qIwPbuWCMEHrzs4mQ0CZ9f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25005817-6027-4017-c6dc-08dd18a1b7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 22:35:01.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qGFlvT/oC+SY9DSFXtyxb2dnOyrjrI5BKq5QmsT9Vt5c7TeEtYN8lzWbRg9qbiBdv+ZQh3Qp57eikG2g8K6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-OriginatorOrg: intel.com

PiA+IG1iYV9tYnBzX2RlZmF1bHRfZXZlbnQgaXNuJ3QgYXJjaGl0ZWN0dXJlIHNwZWNpZmljLiBU
aGUgbWJhX01CcHMNCj4gPiBmZWVkYmFjayBjb2RlIGNvdWxkIGJlIGltcGxlbWVudGVkIG9uIGFu
eSBhcmNoaXRlY3R1cmUgdGhhdCBzdXBwb3J0cw0KPiA+IGJvdGggbWVhc3VyZW1lbnQgYW5kIGNv
bnRyb2wgb2YgbWVtb3J5IGJhbmR3aWR0aC4NCj4NCj4gWWVzLCBhbmQgaXQgc2hvdWxkIGJlIG1v
dmVkIHRvIHRoYXQgaGVhZGVyIHRoZW4sIHJpZ2h0Pw0KPg0KPiBCdXQgbm90IGVhcmxpZXIuDQoN
CklmIHlvdSBmZWVsIHN0cm9uZ2x5IGFib3V0IGl0IHRoZW4gZ28gYWhlYWQgYW5kIGN1dCB0aGUg
bGluZSBmcm9tIDxsaW51eC9yZWN0cmwuaD4NCmFuZCBwYXN0ZSBpdCBpbnRvIDxhc20vcmVzY3Ry
bC5oPg0KDQotVG9ueQ0K

