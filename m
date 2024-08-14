Return-Path: <linux-kernel+bounces-287007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFAE952180
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F00DB21DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8FA1BCA18;
	Wed, 14 Aug 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUiuTGfS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA082566A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657683; cv=fail; b=cuwr25PG41xEFzH2quAUSMuD/RLFAsVBexdjz5EgCGiixG8FBReGM44Tl4ae7tEqjzCr1jgEEm0FIchOc/00G9RE98V+eRyLyZAqmyUJ6pQFVcXzWGGw8P5ADS5npJGEUe2CaWi0poJs7k4Hc3f259g7L8DeK3vQVtu9FKYyv5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657683; c=relaxed/simple;
	bh=1ozOAzwDGEuzaS6L0gKXgBwax682t/15zdAjYKjMD/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V0uys5i1+2ieXJLXaVG9asPoUrFRKS9MVCsWiAMHkP+iehnW6nwFgDkW4Sn8XredKBF0DNUOZuvW9sZiLpxy8cz9mNVK4PwXe/84zn/qqJ9LN3uMKSx3BeMm0pUg8Ici2HSCPisOzkn23QAiNjBYnFQIyIJOYXHfJbQNZzKSgSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUiuTGfS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723657681; x=1755193681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ozOAzwDGEuzaS6L0gKXgBwax682t/15zdAjYKjMD/s=;
  b=bUiuTGfSvduyeA0MriLPu6iVuWmacH++e3oQygnKyd1zaZrF/X2r01De
   OdT+PgzNJRU0w4SG5e7j3CpkvC+SqTdY1OCanebisk23yO9fdzqSsfGpX
   /pmaoljW/phNsje6d12e2p7K/QuKQtDVtX1qHPRZeSnDxdn5DBPISPmnC
   F3si3yTe3evMsylW/4RpwReYqXHZoj0UQsiMTJxYzBZCUFidxGEWMqRLh
   8D/OSV1zTuLX+YqPLPm+YdTGcI5BzIPOhuPEcSgXaXUZxCKg+9YA+5ZZ2
   vRnw7Pj4KtaJGw9wBDuYB7O+yRlNwz+kSLL27OY/tWVpEJwpkeJnySR6u
   w==;
X-CSE-ConnectionGUID: 9Nv2czO1RmCPrMXGAJi5/w==
X-CSE-MsgGUID: 7ObqFI+yRu27obaDLsKFXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="24797037"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="24797037"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:47:58 -0700
X-CSE-ConnectionGUID: ABzBN1v9Q2uHR41M+cavkg==
X-CSE-MsgGUID: s4XSTpUAQEKbuNjkpUwuRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59056177"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 10:47:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 10:47:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 10:47:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 10:47:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN7Eg8eL4RYB9HAS5o2KcMPHWp8h1Az7zXauzJP6v7K3GboAF7grhhX82sIMNsVEE5L+l5+IabwK+MR8s5S9PWFI4oQei18EvKP7IdKZg8EqcGX6DXvyjnqnxTydD1lHEc8rkVtFq6TApQjwxGzE2Lx1S89bCGM6NNGBOek4NwFO1YAfI6sW/4n3eCe8dtga6KJiaLTZsM2AstUNt4Qyok6rYRl218qHhgwkqCdDjnT+C/pI7mmIqUI3We6y3OfVGwMLfFAIqmVVwuUbcwrT7qOE5X9IAXdwU69KrNv0VIYHYnybz05mUVsxEDAQmX684F7eybTI1nMdIOUI5Dulxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ozOAzwDGEuzaS6L0gKXgBwax682t/15zdAjYKjMD/s=;
 b=sCVi/u4HxEJJMWWZVOW9zlUnX6DQ4HEwVddAnaEHM4lGMYRWmzBStJELQRUKcdFdJRv7/gkoGurq3oaFVAetNhYk3z6JgOzvLZiaugJWq50XidJqkcAI6jpBbcYodSj77Tmwmtunuip+yxk8ZnjCOZZNNzKfZh1G3Y0jjV4v71BkR03bZ6YTEzaszLTiXi7rnVVKGd5wZOobWuM0nFtSozi7rX/cmm5qLYQBofPWsBXhjX1wabI3BRH3irIupFYGXwlrd+9uxg9UGk+qF0t73K+AsEacUtmMHUjncIWD+HrS/fKkHb7q5Q2Fl38ibu8+3xBB92qfrom29WcPsm8kaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 17:47:53 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 17:47:53 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Barry Song <21cnbao@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 4/4] mm: page_io: Count successful mTHP zswap
 stores in vmstat.
Thread-Topic: [RFC PATCH v1 4/4] mm: page_io: Count successful mTHP zswap
 stores in vmstat.
Thread-Index: AQHa7hMzSQDX/bd970uPZZOlGMObSLImYeeAgAClOcA=
Date: Wed, 14 Aug 2024 17:47:53 +0000
Message-ID: <SJ0PR11MB5678D231DF60ED05FFA85C18C9872@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
 <20240814062830.26833-5-kanchana.p.sridhar@intel.com>
 <CAGsJ_4yng2ES6C8OSA2qoW5AwQ+zNdEAYWcNpoXmOP+m84qprg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yng2ES6C8OSA2qoW5AwQ+zNdEAYWcNpoXmOP+m84qprg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH0PR11MB4773:EE_
x-ms-office365-filtering-correlation-id: 85b4c05f-78cd-4243-6a3a-08dcbc893905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L0twZktKRnZNQ1BMWUxvNU1lR292TWpXM0w1alI0MkpxSWwzTEVTY2lwdjJ3?=
 =?utf-8?B?RFNIRjJHclZMTnNDN1BYc0NFRXFDSWpEZkpuWkNXdXorOGxGZjZna2YvTktl?=
 =?utf-8?B?emxvM3BJY1pvd080NTNmeTFaVFdFbVZwUndIbGF2aU5ON1IvZ1ZRQ29mVlcv?=
 =?utf-8?B?dGJKT3I4aDFOK1dCOSt4a3F0NVo3TDBram5vdW9kYUV2S0VLZTRoQ09TTWRC?=
 =?utf-8?B?VnA5cDNQSEFySXJpbi9wN2VpYXdjYkpIQUxoTXRLblNZNGpnN0VBQTBuWThD?=
 =?utf-8?B?YjBDT2R1cGNJTnlMdEFBT25LZzZ6TmdYQjhwUmxZL3EvczdVTjJQVFdzeCtp?=
 =?utf-8?B?SzFPQ2Y2bHVOVXU1NkxDdWNUZzZvZFZNREJ1TWtoRVVXRjMrY2xSSm9iR1Zw?=
 =?utf-8?B?OW1tVWFZcVRtWkwrVnZIcEZlZk40UnRIWFBzckhSRnlpaVRpaHFOdVRzTC9S?=
 =?utf-8?B?M09Wa1BnY20xUW5XMnYvQjB5U0M1SnA5UFdBbERwTWE1TmZTWWhJYUlrNElC?=
 =?utf-8?B?blUzOWVBUVNxV3ZFUm9wS1RueWNVcFk2VGR2eHFhQm03bE5IM2dSbmZiVEll?=
 =?utf-8?B?aUI5emdETEpNaXZHMlFxS2N5VUZnKzdqTUluQVgxZkhyN2EvMVZUcVJNdHVM?=
 =?utf-8?B?UGtvaHNiUzQ5d1I1cElKclJTRmw4eXVhWUVOdkdobHBibEF6U0s0cjVoWjN5?=
 =?utf-8?B?ak9yOHQyZ3J6SnN2VlBPdm9oandBdEIwc0gwMlp1YXpzQSt2UGYzVGdRajBE?=
 =?utf-8?B?VnVDR0tIU29ya1Z2VjBlTm1ZWWwrUmpJa3hUWlZvQWNtWFJCdkN3R1dEbFlp?=
 =?utf-8?B?eTgzSjFlS2pGOXBtYzgyWkJiRWRNQ1czdmZRNGlyTHdYdCtQWlEzY2FSSSti?=
 =?utf-8?B?STRCdE4vNklXMmM4WllBalhKM1BhY3B4WldTTlVwa01BcGZhWWV5VEVmM2Yv?=
 =?utf-8?B?eDlBWGo4aWtXbmFhSTAyenZBazJ3cHhyakhaZEl2Rmw1Yk8vRzdBWDFMenA2?=
 =?utf-8?B?RmpaUUdmYVJmbjJSK0V6OVJ6TzYyWERMaFBIUGo3RmFlTEJVejBPaDZRbklT?=
 =?utf-8?B?dkVFTWhIa2xFTXZPYUM1VUdTd25Odk41UThPUlJSOVlRYXdIem5HWlJHS3dW?=
 =?utf-8?B?M3JwSDdONllIOXMrZ0ozQWloUzNiN05VbU5yQ2Q0aGw4dEdVVEJVSC9kZ0o3?=
 =?utf-8?B?TlBCbzZtT21waHVoVEZ2QXVNSzVsTzNCdXl3RlZpTkxLM2hFQkxjcDJqNXp0?=
 =?utf-8?B?LzVjOWJsZ1dCRUpqWnArRmNMNytzUWNrSHptaGNXNGRZaEVBdDFLOFJRYnRq?=
 =?utf-8?B?Z1V6QmRwcWlMcVNXcEE3WGJQSmJhTTNkdThIUlFnZUV5QmY2R1hZMkJURisw?=
 =?utf-8?B?bmFpcHZkdm54ZkIrQ204elZ2NDJvMW0ybVRQY0djRmVJYjV6SkRUdjNEZ1dW?=
 =?utf-8?B?L3lhbzBBa2FidjhGUjRHbkpadjVQN1A4b2ZSUENZNlJ3eUZ6NDNjUHlzbFpk?=
 =?utf-8?B?U1VhL2oyRWJSNU1iRVpQd1BjeEF0VzlNcm9PajJVNWlFK1RrZGxFNHl1RG1I?=
 =?utf-8?B?MjlublM1R3FKdG8zTjhoSUs3VEx1U0ZYeXVBYXhPSEtvaXZVbU9lWXJCYk01?=
 =?utf-8?B?ZkEvT3R5Z3ZEYmU5VGRYOW8vb2pReitoanMzTzN3a0pKcytlNjJwRFdtQkE0?=
 =?utf-8?B?Z2I2WXNiZWpKMVNnV0FDbmxVWXRRRGg5V3dBR1dsZFhncVlYejlTSFpKTXNH?=
 =?utf-8?B?eDlFZW9ZWkRKTnNjVVFSMVVRYmdhdWZEM2o4ZWtSTytRbUxIcm4yM0RKNk9B?=
 =?utf-8?B?VWlOWjhISGFTbnVzcFRVR2VXWXk2cjU2S3FvMmc1RmlsRDNzMlBUVkxrMXN2?=
 =?utf-8?B?TDM4Z1dPN1d2bGZXMDdreGFsMUpyS05PMlVsLytQUVVoTUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anQvUGFwT3lBaURQdFpaSTE2ajZUN1VUTzFXUzI1bHQxaitFVDk1MDFXMnIv?=
 =?utf-8?B?NHFCL3ViMW5Ma3FhQU56SlFBdmxoYzdpUlpKUVQ2R1RJSWZwdHV5L2V0VWtG?=
 =?utf-8?B?OGFGOWJPRzhBaDJRYy9tNy9tMjVoYjBwZ1dQMXlxbUtuMHNiYTZNSUdjZ3Bx?=
 =?utf-8?B?b1ZTMGZVc3NHays2VzlQaVFMN3d2enFYUlZhK25tOGFGQlpKR1E2cjh3a0Z3?=
 =?utf-8?B?cnZBeXluRjY3Y29Ca2E0UmROd2VNL2NIK3lMU3RZUGRJb2hGNGRaYW5oRGpo?=
 =?utf-8?B?eFRWVHFWNHFZQkEzbk1vcUYvVmtoMmdlVVdubVRsNEx2R3A0Q2U1WVJIVmNK?=
 =?utf-8?B?TkVLSUlJOWJLVDlHcndxeXNDaWRxbFkxWjhKR211TXNpOEw0T2F6SDBMY1BL?=
 =?utf-8?B?YmF5YjlIa0N3SGo5bUNkaXJwWUFWaDA5SFBPVC9KMzN4SGpuaytGMGNJSUtR?=
 =?utf-8?B?cFpLWm02MnlRQzhiL0psT25US3phd0ZPQkxSbnhvWTFObEJmMkpjRmFBQWlr?=
 =?utf-8?B?d1crK2JmWTUrUUNaN1psMnpBeS8zNExmTFVTbHVmR2FwT2t2dm9EeXNRaU95?=
 =?utf-8?B?RFRVNEp2QTU4L3Rrci94dlRUKzJzWUl5cXRaMko5dmE0Q1lEYitHMUhQenBh?=
 =?utf-8?B?S0dXdmxJWXdvT09hd2t3MUQ1L0RzL2gyUHd5d3Zkc1cwaGh6aUhzU0trSFdo?=
 =?utf-8?B?UEZZVnVOK1lLc1lpSkhJN2U5UDZGUXdPak9NUmNlaldqc29mU0F1c0FmM3Qr?=
 =?utf-8?B?am80L08wK3FndTdpYityaUlWdlh5d2ZLV0EyUFdsdTJXTEFZUlZiOXppRTZG?=
 =?utf-8?B?M1I4Y1dQYXZMTnVxOUtLSG5ETmdSVmN4ekFkcjlXOUVRQ1pKMjAzU005RlJK?=
 =?utf-8?B?RjhSQ1VXT2NDYkl4cVUrejJHMHhyK3JQbXlSN0JNVzNGNnB1dGZQK2FqNHBQ?=
 =?utf-8?B?NjRIUEMzRjFRb0ZHWEp4cDFmeExMNURuTDY4V21YMVRrY05oRkJxRE9nZk1U?=
 =?utf-8?B?cU5UK1BoYW9XaDRYMGVJbjFKajJ1SzFPUVY0QjJvMW5JcjdtL2xteTJkM0c0?=
 =?utf-8?B?Y0JNMFU5cTJyQUUyZzBJWTRjRnZ4N2RCYW85OXA1aE05S0lKMW9FbW56b1VX?=
 =?utf-8?B?eGNFdHBsQTkyNFlmSlZUd3hIRFFEelVtTTdJL215cW5WNDJ0WUlmYzVJWHdn?=
 =?utf-8?B?NTM4OU9aVzkxN0cyNVdaQ3pDQzhjTlhaOTI0MktJeXE3djJBOWZhUVRBU0Vl?=
 =?utf-8?B?Tkl5aUhKWjVzdTB0NDVVcy9oaGtTTFhDWEk3NThIenRFaU9ZQXBFWC9rbklv?=
 =?utf-8?B?SnZ5ajhiZ05XTG4rY1puT0dLQ1dEa05tb1J0QlZuWTl5SnBYdUZsMmltRWpE?=
 =?utf-8?B?emc5R0cvTkpwdHExQ282a01JNDRyL0JzaUlEb2pHVDNyYnh5RE1yZVBUSmNV?=
 =?utf-8?B?ZWdDTXM0U2dROExNSFNCZEJwalNMYjN6NXBpTVNOcWRNT3Q4SmpxK0x2SC9h?=
 =?utf-8?B?TTYzYzRrc04zQURNaDlLNEtaQ1RLNW5vMWxybjY3b1JzUWtCd3RSenNaTXZy?=
 =?utf-8?B?SXg1d2pZNlZrc1dkSVpqd3RjekxqS1oxdURnMGZNUFowLzEzRFJlY0MyRllG?=
 =?utf-8?B?WmNkTXF6NTl1RXl2WW1OQjBvZGVUcWFGRHNYM2JVMW1HVU53SmNSL1Ixa253?=
 =?utf-8?B?ZHZxdU4zTnlCQnFobUNEcE5jU3h3VCtvWHpYdkN3Z1BFZHF5SVo0RzJVWnkw?=
 =?utf-8?B?dGtURmk3dEF1SE8wTFdlKzZQMklHeWdqQzdHTWdkNmg4NDcyTHZGQjRmWm1n?=
 =?utf-8?B?ZS9POTFCczRxY1U1SVA5ZDVSYkFyVmZJRnJVM25oaXZkMjZsT3haNkhCLy9a?=
 =?utf-8?B?ZU16L3FCc1h0MTVsZncxcjdzV290NnJNdm9XWDJhTzRZZDNyeDA4YTJ2bk14?=
 =?utf-8?B?WHFEOFB4RnVzT3hNKzIyU0c2bFBIU2NLS0E2WTBYbWltYXRZTk5iR0NMUzRo?=
 =?utf-8?B?T05zZm8waGtTY0lnM1dZTE1aRzB3ZEFZeHIzcXJLaEQrT2ZJazE5VkVFd1Uw?=
 =?utf-8?B?M21iUU0rWVpLODdReU8xZUVNQ2F3RXEwZWZmRmwxV3dXWEZNWXpxcDRBdVZy?=
 =?utf-8?B?V2NvVnZIaFc0eGZDcTlNNVBsSGJiNm43SHRjWUIzazEzbkVSZmZwdVc1VUNJ?=
 =?utf-8?B?NHJnSU9kbzAzMVVVNm5vRXJFRFpaNFA1OWJWWldXalNqdjVDWjl1MjlBazE0?=
 =?utf-8?B?UkM5bXBSdDB6V0NmRWYrM2NTeitnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4c05f-78cd-4243-6a3a-08dcbc893905
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 17:47:53.2680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rcc9aEdIUjmuc6x7pgim0s/5yeRJtXvnLemVuU0XXNssyjH1scoe9V1ufi/scTZBWaravbVborBw+RUYbIkP2iBlNJM+lDCaNmHVXzm2FXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4773
X-OriginatorOrg: intel.com

SGkgQmFycnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFycnkg
U29uZyA8MjFjbmJhb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE0LCAy
MDI0IDEyOjUzIEFNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRo
YXJAaW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
bW1Aa3ZhY2sub3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNv
bTsgbnBoYW1jc0BnbWFpbC5jb207DQo+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWlu
ZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsg
Wm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8
d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBp
bnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxIDQvNF0gbW06IHBhZ2VfaW86
IENvdW50IHN1Y2Nlc3NmdWwgbVRIUCB6c3dhcA0KPiBzdG9yZXMgaW4gdm1zdGF0Lg0KPiANCj4g
T24gV2VkLCBBdWcgMTQsIDIwMjQgYXQgNjoyOOKAr1BNIEthbmNoYW5hIFAgU3JpZGhhcg0KPiA8
a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGRlZCBjb3Vu
dF96c3dhcF90aHBfc3dwb3V0X3ZtX2V2ZW50KCkgdGhhdCB3aWxsIGluY3JlbWVudCB0aGUNCj4g
PiBhcHByb3ByaWF0ZSBtVEhQL1BNRCB2bXN0YXQgZXZlbnQgY291bnRlcnMgaWYgenN3YXBfc3Rv
cmUgc3VjY2VlZHMgZm9yDQo+ID4gYSBsYXJnZSBmb2xpbzoNCj4gPg0KPiA+IHpzd2FwX3N0b3Jl
IG1USFAgb3JkZXIgWzAsIEhQQUdFX1BNRF9PUkRFUi0xXSB3aWxsIGluY3JlbWVudCB0aGVzZQ0K
PiA+IHZtc3RhdCBldmVudCBjb3VudGVyczoNCj4gPg0KPiA+ICAgWlNXUE9VVF80S0JfRk9MSU8N
Cj4gPiAgIG1USFBfWlNXUE9VVF84a0INCj4gPiAgIG1USFBfWlNXUE9VVF8xNmtCDQo+ID4gICBt
VEhQX1pTV1BPVVRfMzJrQg0KPiA+ICAgbVRIUF9aU1dQT1VUXzY0a0INCj4gPiAgIG1USFBfWlNX
UE9VVF8xMjhrQg0KPiA+ICAgbVRIUF9aU1dQT1VUXzI1NmtCDQo+ID4gICBtVEhQX1pTV1BPVVRf
NTEya0INCj4gPiAgIG1USFBfWlNXUE9VVF8xMDI0a0INCj4gPg0KPiA+IHpzd2FwX3N0b3JlIG9m
IGEgUE1ELXNpemUgVEhQLCBpLmUuLCBtVEhQIG9yZGVyIEhQQUdFX1BNRF9PUkRFUiwgd2lsbA0K
PiA+IGluY3JlbWVudCBib3RoIHRoZXNlIHZtc3RhdCBldmVudCBjb3VudGVyczoNCj4gPg0KPiA+
ICAgWlNXUE9VVF9QTURfVEhQX0ZPTElPDQo+ID4gICBtVEhQX1pTV1BPVVRfMjA0OGtCDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5hLnAuc3JpZGhh
ckBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIG1tL3BhZ2VfaW8uYyB8IDQ0ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0
NCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbW0vcGFnZV9pby5jIGIvbW0v
cGFnZV9pby5jDQo+ID4gaW5kZXggMGExNTBjMjQwYmY0Li5hYjU0ZDIwNjBjYzQgMTAwNjQ0DQo+
ID4gLS0tIGEvbW0vcGFnZV9pby5jDQo+ID4gKysrIGIvbW0vcGFnZV9pby5jDQo+ID4gQEAgLTE3
Miw2ICsxNzIsNDkgQEAgaW50IGdlbmVyaWNfc3dhcGZpbGVfYWN0aXZhdGUoc3RydWN0DQo+IHN3
YXBfaW5mb19zdHJ1Y3QgKnNpcywNCj4gPiAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICB9DQo+ID4N
Cj4gPiArLyoNCj4gPiArICogQ291bnQgdm1zdGF0cyBmb3IgWlNXQVAgc3RvcmUgb2YgbGFyZ2Ug
Zm9saW9zIChtVEhQIGFuZCBQTUQtc2l6ZSBUSFApLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGlu
bGluZSB2b2lkIGNvdW50X3pzd2FwX3RocF9zd3BvdXRfdm1fZXZlbnQoc3RydWN0IGZvbGlvICpm
b2xpbykNCj4gPiArew0KPiA+ICsgICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX1RSQU5TUEFS
RU5UX0hVR0VQQUdFKSAmJg0KPiBmb2xpb190ZXN0X3BtZF9tYXBwYWJsZShmb2xpbykpIHsNCj4g
PiArICAgICAgICAgICAgICAgY291bnRfdm1fZXZlbnQoWlNXUE9VVF9QTURfVEhQX0ZPTElPKTsN
Cj4gPiArICAgICAgICAgICAgICAgY291bnRfdm1fZXZlbnQobVRIUF9aU1dQT1VUXzIwNDhrQik7
DQo+ID4gKyAgICAgICB9IGVsc2UgaWYgKGZvbGlvX29yZGVyKGZvbGlvKSA9PSAwKSB7DQo+ID4g
KyAgICAgICAgICAgICAgIGNvdW50X3ZtX2V2ZW50KFpTV1BPVVRfNEtCX0ZPTElPKTsNCj4gPiAr
ICAgICAgIH0gZWxzZSBpZiAoSVNfRU5BQkxFRChDT05GSUdfVEhQX1NXQVApKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgIHN3aXRjaCAoZm9saW9fb3JkZXIoZm9saW8pKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIGNhc2UgMToNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBjb3VudF92bV9ldmVu
dChtVEhQX1pTV1BPVVRfOGtCKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gPiArICAgICAgICAgICAgICAgY2FzZSAyOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGNvdW50X3ZtX2V2ZW50KG1USFBfWlNXUE9VVF8xNmtCKTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgY2FzZSAzOg0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNvdW50X3ZtX2V2ZW50KG1USFBfWlNXUE9VVF8zMmtCKTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgY2FzZSA0
Og0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvdW50X3ZtX2V2ZW50KG1USFBfWlNXUE9V
VF82NGtCKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAg
ICAgICAgICAgY2FzZSA1Og0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvdW50X3ZtX2V2
ZW50KG1USFBfWlNXUE9VVF8xMjhrQik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gKyAgICAgICAgICAgICAgIGNhc2UgNjoNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBjb3VudF92bV9ldmVudChtVEhQX1pTV1BPVVRfMjU2a0IpOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICBjYXNlIDc6DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgY291bnRfdm1fZXZlbnQobVRIUF9aU1dQT1VUXzUxMmtCKTsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAg
Y2FzZSA4Og0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvdW50X3ZtX2V2ZW50KG1USFBf
WlNXUE9VVF8xMDI0a0IpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+
ICsgICAgICAgICAgICAgICBjYXNlIDk6DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY291
bnRfdm1fZXZlbnQobVRIUF9aU1dQT1VUXzIwNDhrQik7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gDQo+IFRoZSBudW1iZXIgb2Yg
b3JkZXJzIGlzIFBNRF9PUkRFUiwgYWxzbyBpbG9nMihNQVhfUFRSU19QRVJfUFRFKSAuDQo+IFBN
RF9PUkRFUiBpc24ndCBuZWNlc3NhcmlseSA5LiBJdCBzZWVtcyB3ZSBuZWVkIHNvbWUgZ2VuZXJh
bCB3YXkNCj4gdG8gaGFuZGxlIHRoaXMgYW5kIGF2b2lkIHNvIG1hbnkgZHVwbGljYXRlZCBjYXNl
IDEsIGNhc2UgMi4uLi4gY2FzZSA5Lg0KDQpUaGFua3MgZm9yIHRoaXMgc3VnZ2VzdGlvbi4gVGhl
IGdlbmVyYWwgd2F5IHRvIGRvIHRoaXMgYXBwZWFycyB0byBiZQ0Kc2ltcGx5IGNhbGxpbmcgY291
bnRfbXRocF9zdGF0KGZvbGlvX29yZGVyKGZvbGlvKSwgTVRIUF9TVEFUX1taXVNXUE9VVCkNCnBv
dGVudGlhbGx5IHdpdGggdGhlIGFkZGl0aW9uIG9mIGEgbmV3ICJNVEhQX1NUQVRfWlNXUE9VVCIg
dG8NCiJlbnVtIG10aHBfc3RhdF9pdGVtIi4NCg0KSSB3aWxsIG1ha2UgdGhpcyBjaGFuZ2UgaW4g
djIgYWNjb3JkaW5nbHkuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+ID4gKyAgICAgICB9
DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIFdlIG1heSBoYXZlIHN0YWxlIHN3YXAg
Y2FjaGUgcGFnZXMgaW4gbWVtb3J5OiBub3RpY2UNCj4gPiAgICogdGhlbSBoZXJlIGFuZCBnZXQg
cmlkIG9mIHRoZSB1bm5lY2Vzc2FyeSBmaW5hbCB3cml0ZS4NCj4gPiBAQCAtMTk2LDYgKzIzOSw3
IEBAIGludCBzd2FwX3dyaXRlcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0DQo+IHdyaXRl
YmFja19jb250cm9sICp3YmMpDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4g
ICAgICAgICB9DQo+ID4gICAgICAgICBpZiAoenN3YXBfc3RvcmUoZm9saW8pKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgIGNvdW50X3pzd2FwX3RocF9zd3BvdXRfdm1fZXZlbnQoZm9saW8pOw0KPiA+
ICAgICAgICAgICAgICAgICBmb2xpb19zdGFydF93cml0ZWJhY2soZm9saW8pOw0KPiA+ICAgICAg
ICAgICAgICAgICBmb2xpb191bmxvY2soZm9saW8pOw0KPiA+ICAgICAgICAgICAgICAgICBmb2xp
b19lbmRfd3JpdGViYWNrKGZvbGlvKTsNCj4gPiAtLQ0KPiA+IDIuMjcuMA0KPiA+DQo+IA0KPiBU
aGFua3MNCj4gQmFycnkNCg==

