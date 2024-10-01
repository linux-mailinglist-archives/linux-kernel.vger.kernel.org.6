Return-Path: <linux-kernel+bounces-345097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998C98B1F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3631C20F71
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6DA38F9C;
	Tue,  1 Oct 2024 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GdGA9Gqv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E72339AB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747898; cv=fail; b=Ue4S9FiPWUfkiOF3vFUd74fa6gNtPyoAS1RmqIWYOYOYFYTXH370/PbaTXS3UpLoqKqPuXIfI6jh9KBQnTlS5W/mcuC0DQKSko+ADqFy+NCXztwVjKli2cHBVmAlv6ro77G44xW1zuPAkSQeBMxRnuj9TYPZCwDSltglN1HKE+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747898; c=relaxed/simple;
	bh=Ysxj/71zQUwCm7BplsZxx9yMC5R1nivB4zY2ZFbNygY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgIN4pjeQTO8qLxdjEXrf2/mQxFv5Cxtk4zvBgd7lXAZ6RO7n+6AuO6t2GjcpaysjY+AvNMdxeVC5YjDUY2/C4I5b3C9JgB1kn5prius5wEVBljQ6op4n1AjJ5GrZoVN9xbxOGEaD9DeNLXfES4wq+6uygQ7GFq72HF3X/38XDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GdGA9Gqv; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727747897; x=1759283897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ysxj/71zQUwCm7BplsZxx9yMC5R1nivB4zY2ZFbNygY=;
  b=GdGA9Gqv2ADjx+ha5kkZ3NZRXWlfW6iyPLZ7jg0lFRxXgcJeAMsGaujY
   BIr4tbAUEBpt2BJhiGgulREXvTgGYZz9QGTrlbsGIKxIOUCkyjJNZ1RsT
   nfmen8B1lQJZe/R2XsKK+Mn1vsSL+Kr/E7Vls5sXlj6lNzvfNKEwRe4Nu
   KISYXU6BgUzPxltxptiAkrYNj0WXZGmBFgETD79Zz6SNuDYiUVuYiIWsg
   OeK6qcCE9ZifuFgWwXn2S9FLvAbotMieeUTex2shBQIV2yscvlZW8ZuQI
   3q8gsWOuB+9gQll/UWWacLHIsYH5qxFX6s19EYBppKInxbtpTjHmUL/+K
   Q==;
X-CSE-ConnectionGUID: QXlkpX8pS16U2o/zS+ymRg==
X-CSE-MsgGUID: ivwCpUAlSJqi7KEcbqtBOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26320228"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26320228"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 18:58:15 -0700
X-CSE-ConnectionGUID: sIqiDh1GRtKy59SK5LHAAA==
X-CSE-MsgGUID: l07y9EMmSoq/aOSD+wlXqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104277029"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 18:53:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 18:53:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 18:53:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 18:53:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 18:53:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJCouoI8HRcv4SptHy0oiy6f9Fq6uBI4v3REGazcZgaXix2rA33TFWGmAQKNaUl2lH143S4G4Fn0HOjugQuCLiXN11EzGr3PUwViY6EJRXYHTBMKzax3QEPJ8IYq1YOng8BXLFkT80wMbF80hfStzwJKBtcX0JQZgn482vsQoBwuKKVWLNEnbCBWKb2Jgj8lBolmOFYVkQfQxKNFXXunXAxacQWk2tUCfpSbEbgyMMXETM++TavExdwqSEPlM/5CRtT9M5//cae/Qh0cqQQcyIeGQtgJU0+05yGLW0BWxPlnsrIp4wtjJnOufTKfTSu1o8mXh40GVDhZ/xwrt8zdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku2iym3d6N+WBPkPlyCge9IB0+4udpfVCmw0slngJY4=;
 b=ANjhvJERdnepXi/tGJHY7yrWYpRCtpTJEwhfie+z04TGJC64VI+zSdvTHOkMa/xOUS1BX4bu5O4TJqKKbjFsJnxeTh9H46q6GZ+/XV7pYCjbpdUnZTBx9hNrfIyM89AYFdZdORurgE0VFPcqiLPKSG8t8/vmpxM7YyBGKYb54/yCPpfU8t/RF/JVDDGK6NMTt/ObcW8sEfga0QRvJbk/3z3YSfO/iFne9dUd1GaAY4S35StIRq4fo5GlKCTNNIP4i4L8hRnsNBxQCKjO7RgHKQ3xDw3w3URjpwkagCAzu1vkPfjGWSDFoDuMoCtZh4FDT1gocA2ZNmTPZNcxvDlWoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 01:53:35 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 01:53:35 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Index: AQHbE4XaXdnmYogniUi9EO2aNKPUnLJxF3UAgAAKl2A=
Date: Tue, 1 Oct 2024 01:53:35 +0000
Message-ID: <SJ0PR11MB5678B5A1F4BC1EEC7A172862C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
 <20241001011424.GB1349@cmpxchg.org>
In-Reply-To: <20241001011424.GB1349@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH8PR11MB6854:EE_
x-ms-office365-filtering-correlation-id: e07dd18b-e236-4e05-3f7e-08dce1bbdc54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6nHugz7mPt3ZkO52aCLatyUhy1730KTQ1uxBnfq0HYRJ31f0m16qAx87sN9z?=
 =?us-ascii?Q?dROavKWZiUOrH90aOivOCiAkwaiVp31tY08pjwPvYQuVUUvBzRpKf+OWxOCp?=
 =?us-ascii?Q?jvAJVdoGh90Qyo78r0VgdvmJ8a2OPV43hY76p7Soe9zAO6FhX+TEdqRLJ+26?=
 =?us-ascii?Q?MTSv5e18x1NJdymvVfHyX+LLVV2Y1n5PpU6v3SvVmCCODbY0Ve/Rq5jcp2AP?=
 =?us-ascii?Q?Fetx6tbcwlALJH9myslhYwwQjRJVGBIk9Xvgd9K5l9pXhaa0/rYYC3wlgL/u?=
 =?us-ascii?Q?ZDim2F0iMlbtJaTWA/VOpIalEYZlROdRrVqIjpp90LmtDbUqpRCwrESdvyMV?=
 =?us-ascii?Q?/BpdO+Zu+HMyYs4ox74/OSGbgzdkX5sO5oHRV0wUCAHsYijvIHsRB27PAxZ/?=
 =?us-ascii?Q?Rdf9r4qWNypRTPsBVW8xxHFjzw+CL25yDNgYUcU7vOj6whS1lO29PFz6d0X2?=
 =?us-ascii?Q?gabgl5X8zWOpUs+TiqQeOdvOE2oAuoFHRhjSHBeTl67P+8gBeYPZzAISCj87?=
 =?us-ascii?Q?Gr4gJ7h2/M4T+UGlJa8u49TqiKY2LnTzGy6RZggwq3n/VFZwKbJ1u/jbF3PA?=
 =?us-ascii?Q?bjXJDU2W05bSgK6oJy+D1HhAowPCpHF1TlXSb7+M5WpFHYXnrLROSl97xrBz?=
 =?us-ascii?Q?GlZGI5MayNDPcyGTCcxSNW+yJlLlRgcjTw/QT2SQt+rmov8U07SGU990LYCX?=
 =?us-ascii?Q?2hcEcl5grjc/A2qR6xGp18GYVnLNfYDLODLpqu82nhAsakN61DEAltsF6m7f?=
 =?us-ascii?Q?pTLPFWK8GJOZUfjmr3F1H/quRm5kakATNQWv3WcJc6iPfZ43gp2fSZ+WpxhP?=
 =?us-ascii?Q?5QPe0f1pp8A83wy7FYbcAck7YZxEqdl/nmk+xmClkpwVNdzytFkyWGvZ0KA4?=
 =?us-ascii?Q?QhPUWLdyyXPX2FdUkffawk9m9FBIQ4l9jlouUf++7QzfniESn4fVfY+O+PbZ?=
 =?us-ascii?Q?FNzKSJmCKvd2G5ioP1J4CyJNFWbEht38HWLkVz3YE14XGNlwMAqFImoQs1Cb?=
 =?us-ascii?Q?3wUvUbiY2rXsO9mgiDkGRmNTzZd7hUYuasmm0D8H8iZ/fJudEJuAad1W/d33?=
 =?us-ascii?Q?i7cy2z0Pa+J+gx7z2/HcBXDKyp4uQjibi28aMD8Ou3DjKUy5NIprrNnwyjR2?=
 =?us-ascii?Q?iFekFa6vboiGAs1WgDbMddYW9ENS/bdRSCjj5DZVwF1yxFmtVIgMWW99JTcW?=
 =?us-ascii?Q?GkAyh8dd0W2tLOZ3iAAKA9IvKFaBsl1lkD7wwlTvii6pANz664z3tu+wjHPu?=
 =?us-ascii?Q?cb2+XWTsS+5WYDGRlgtWfR3ROg+fqL3PmU0tgyeCNhQSIykzDy/YcuOk/urK?=
 =?us-ascii?Q?aE5AsBZqljpPNiyk0vaouIdmVhZIfWuHkx9AOWzRMVjp6w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zz7uno2XlepmalNo1qqM0N8j/l2ReB6hSseXUyq35c/XTm7krMYQ4mFpygNb?=
 =?us-ascii?Q?B2L4ao1ealpivXhuMdfYdrbnGfCst6MeU0M3Zq5mq+PgyTK03nTryvoHB+uf?=
 =?us-ascii?Q?8A8CPrgKXWuOUevJDYfdGP2totPo5Pds0NzB3ir81j1MiruU+mxV85oRpio+?=
 =?us-ascii?Q?vWxqBQaKzddWfCsmlZFsYuchjGxz9z0r6kBjY1lZe04mM9C6BFjLDPVYaQKE?=
 =?us-ascii?Q?u9NZYbLvF1Ldp2xkiP17xZ4Z3kYJ70fWtnoOaAhzSqrQ5NfOxfoEgQbVrOiQ?=
 =?us-ascii?Q?sFCd++ZKzb2qgQoepyvM05eMtqKnTgaqH4OArmkdJnKKez4uG+IzFcO8Qc65?=
 =?us-ascii?Q?j6ZHXoi0L03AaBLBC42+goo7OPA4tWPTcvjECCERxX9EHpkCt1mXkF7jyAWL?=
 =?us-ascii?Q?WeX+Q++/Ix/cjPYPrRHMh48BDr5jrN31w8l3WqDcrrFarqfc6Oirk6WcyloB?=
 =?us-ascii?Q?y8oOVLn7Km8wtEfVe9qdMG30NV0Y9N1GJ6scfFHAQ7rguVTb07H9Qbb2dIkM?=
 =?us-ascii?Q?6BZei1zCx/3fh3przY5do2qnIoAdIFNffYQd5sZZyjwk1FE8zCtu1kVzZF7W?=
 =?us-ascii?Q?kaxCVWJP2fpnwc73DItwWi1onLm4T3KSJWvzPWhhzVHZFp5llYbkZDBTufSX?=
 =?us-ascii?Q?o9AWpBFmw3PsrpUYW5PspB7ePMBt+TFnU0QTw6onGec0PnKD1u+4FRyRL49o?=
 =?us-ascii?Q?afwP9+ngpto5bsMyIoO73Gw+nTuOfFObqMF/yqmbWEQYNaSjqRWhjoEV2x00?=
 =?us-ascii?Q?Scpk/4j2iaDK3UMOR/xnp5Ll7gGHvM/tnmff9uhMs9XpB6unJspW0J/TqO26?=
 =?us-ascii?Q?YnQNGbtE8a2Gqdx/HgU47c69t9HWOwFBI+uNZUbxqY+anXj21ROxuMMdFkem?=
 =?us-ascii?Q?9XZ1vVLWzoH10lfTgHDgXzV5lxxLSQtv3l7pzlkwRi6rProK9GuKxxyTOlZ3?=
 =?us-ascii?Q?EBTPmYpuYtf+FNC5HSk5BS+6ArnG23EJUdn7ODAK5TTQfgwPjfBoSxKYPW6F?=
 =?us-ascii?Q?b/ASWMyGlmLoVJirvG1QfR6VywKzsJFJk5TTC/LFLApuv6X7oL7+KqGAc/wx?=
 =?us-ascii?Q?nVADr1vcEJuFEPAjzJhIsFall9BYGj8T8UAcGmKvKE/7px8CsFO+PhKv9HAJ?=
 =?us-ascii?Q?Yqyf6jlzRPb11MaaxgHPHce2J1sQ5sBJ6oOhAgSKmF/8duob7Qgh1AsmLkpv?=
 =?us-ascii?Q?39IeqDemUPp2P5gl2FB7TQNQHj77t8GbM5ZEhWMIOkG4I4dUxRShJumGa2EK?=
 =?us-ascii?Q?2Y7T+FTA+Ehp9jP80Ip+UGg+o2ygZA94bV9A6xBa8nlP65ChbljgI4TnadXp?=
 =?us-ascii?Q?7P3dFOPTreeg9hWzOziuHUJEKCcqKZy44/MJ8P/z9oWKi6pNJiwEeOblwVIt?=
 =?us-ascii?Q?JFzmOXNUPOV3pHRbBC44viLBu74g4AMom7gpRG6/SKyvJ6GkxpwBUrGFUYCI?=
 =?us-ascii?Q?ew0bl569bZv0bd8cznMibAYoNbym5L2a0YK8WkrAqH/9P9k05V4VESHHgCUV?=
 =?us-ascii?Q?uFl4IkUtZN/lMD8S3T8MWOBMmK7dCF6+WmUPRdkBP4g55qvNUvDbV8Fk+6Wl?=
 =?us-ascii?Q?OnPEtXWivkWrmflaGor6ViP3+SgpC1dAxunUnGwZ7r+T6faae719WQJeY2X1?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07dd18b-e236-4e05-3f7e-08dce1bbdc54
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 01:53:35.1171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+wg3El9cl7kBXcVGXSDWreAw6c3lAh/o4rielFNG5NIlnls46oZoIdI2gyA9dFbVntmlWURqeVn1t+Kcsnr3veeYbI/BVnVUYgkEBh+plE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Monday, September 30, 2024 6:14 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> willy@infradead.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_stor=
e().
>=20
> On Mon, Sep 30, 2024 at 03:12:20PM -0700, Kanchana P Sridhar wrote:
> >  /*********************************
> >  * main API
> >  **********************************/
> > -bool zswap_store(struct folio *folio)
> > +
> > +/*
> > + * Stores the page at specified "index" in a folio.
>=20
> There is no more index and no folio in this function.
>=20
> > + *
> > + * @page:  The page to store in zswap.
> > + * @objcg: The folio's objcg. Caller has a reference.
> > + * @pool:  The zswap_pool to store the compressed data for the page.
> > + *         The caller should have obtained a reference to a valid
> > + *         zswap_pool by calling zswap_pool_tryget(), to pass as this
> > + *         argument.
> > + * @tree:  The xarray for the @page's folio's swap.
>=20
> This doesn't look safe.
>=20
> If the entries were to span a SWAP_ADDRESS_SPACE_SHIFT boundary, the
> subpage entries would need to be spread out to different trees also.
> Otherwise, it would break loading and writeback down the line.
>=20
> I *think* it works right now, but at best it's not very future proof.
> Please look up the tree inside the function for the specific
> swp_entry_t that is being stored.
>=20
> Same for the unwind/check_old: section.
>=20
> > + * @compressed_bytes: The compressed entry->length value is added
> > + *                    to this, so that the caller can get the total
> > + *                    compressed lengths of all sub-pages in a folio.
> > + */
>=20
> With just one caller, IMO the function comment can be dropped...
>=20
> >  	/* allocate entry */
> > -	entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> > +	entry =3D zswap_entry_cache_alloc(GFP_KERNEL,
> folio_nid(page_folio(page)));
>=20
> page_to_nid() is safe to use here.
>=20
> > +bool zswap_store(struct folio *folio)
> > +{
> > +	long nr_pages =3D folio_nr_pages(folio);
> > +	swp_entry_t swp =3D folio->swap;
> > +	struct xarray *tree =3D swap_zswap_tree(swp);
> > +	struct obj_cgroup *objcg =3D NULL;
> > +	struct mem_cgroup *memcg =3D NULL;
> > +	struct zswap_pool *pool;
> > +	size_t compressed_bytes =3D 0;
> > +	bool ret =3D false;
> > +	long index;
> > +
> > +	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > +	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > +
> > +	if (!zswap_enabled)
> > +		goto check_old;
> > +
> > +	/*
> > +	 * Check cgroup zswap limits:
> > +	 *
> > +	 * The cgroup zswap limit check is done once at the beginning of
> > +	 * zswap_store(). The cgroup charging is done once, at the end
> > +	 * of a successful folio store. What this means is, if the cgroup
> > +	 * was within the zswap_max limit at the beginning of a large folio
> > +	 * store, it could go over the limit by at most (HPAGE_PMD_NR - 1)
> > +	 * pages due to this store.
> > +	 */
> > +	objcg =3D get_obj_cgroup_from_folio(folio);
> > +	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > +		memcg =3D get_mem_cgroup_from_objcg(objcg);
> > +		if (shrink_memcg(memcg)) {
> > +			mem_cgroup_put(memcg);
> > +			goto put_objcg;
> > +		}
> > +		mem_cgroup_put(memcg);
> > +	}
> > +
> > +	/*
> > +	 * Check zpool utilization against zswap limits:
> > +	 *
> > +	 * The zswap zpool utilization is also checked against the limits
> > +	 * just once, at the start of zswap_store(). If the check passes,
> > +	 * any breaches of the limits set by zswap_max_pages() or
> > +	 * zswap_accept_thr_pages() that may happen while storing this
> > +	 * folio, will only be detected during the next call to
> > +	 * zswap_store() by any process.
> > +	 */
> > +	if (zswap_check_limits())
> > +		goto put_objcg;
>=20
> There has been some back and forth on those comments. Both checks are
> non-atomic and subject to races, so mentioning the HPAGE_PMD_NR - 1
> overrun is somewhat misleading - it's much higher in the worst case.
>=20
> Honestly, I would just get rid of the comments. You're not changing
> anything fundamental in this regard, so I don't think there is a
> burden to add new comments either.
>=20
> > +
> > +	pool =3D zswap_pool_current_get();
> > +	if (!pool)
> > +		goto put_objcg;
> > +
> > +	if (objcg) {
> > +		memcg =3D get_mem_cgroup_from_objcg(objcg);
> > +		if (memcg_list_lru_alloc(memcg, &zswap_list_lru,
> GFP_KERNEL)) {
> > +			mem_cgroup_put(memcg);
> > +			goto put_pool;
> > +		}
> > +		mem_cgroup_put(memcg);
> > +	}
> > +
> > +	/*
> > +	 * Store each page of the folio as a separate entry. If we fail to
> > +	 * store a page, unwind by deleting all the pages for this folio
> > +	 * currently in zswap.
> > +	 */
>=20
> The first sentence explains something that is internal to
> zswap_store_page(). The second sentence IMO is obvious from the code
> itself. I think you can delete this comment.
>=20
> > +	for (index =3D 0; index < nr_pages; ++index) {
> > +		if (!zswap_store_page(folio_page(folio, index), objcg, pool,
> tree, &compressed_bytes))
> > +			goto put_pool;
>=20
> Hah, I'm not a stickler for the 80 column line limit, but this is
> pushing it ;)
>=20
> Please grab the page up front.
>=20
> Yosry had also suggested replacing the compressed_bytes return
> parameter with an actual return value. Basically, return compressed
> bytes on success, -errno on error. I think this comment was missed
> among the page_swap_entry() discussion.
>=20
> 	for (index =3D 0; index < nr_pages; index++) {
> 		struct page *page =3D folio_page(folio, index);
> 		int bytes;
>=20
> 		bytes =3D zswap_store_page(page, object, pool, tree);
> 		if (bytes < 0)
> 			goto put_pool;
> 		total_bytes +=3D bytes;
> 	}

Thanks Johannes! Appreciate your detailed code review comments.
I will incorporate all the comments and submit v10.

Thanks,
Kanchana

