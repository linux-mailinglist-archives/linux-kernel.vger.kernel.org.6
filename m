Return-Path: <linux-kernel+bounces-343184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D164B98978C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D52810F6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469AA55E53;
	Sun, 29 Sep 2024 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQpykQ4p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6F8F6D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643868; cv=fail; b=EtugROjrrbM6Yn+4bBjv+kup8fXPUfsmieZ6yrZLRuHFCgE7Ka6kcaEY65AcxfPS5E3eFjMIFwp5fEHrPjyx1JeF/507B9fcFIFDbeRJ1Gee2UPUVmbHsRAKxcWkJWAnMqZdJRSWZ2WgoecyUSSQMkURqY3fxsnVAR59cqPCh+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643868; c=relaxed/simple;
	bh=ccPCnznOouvaoyBd3WYx5wMpjeH7SlJrYJkHgz2QeUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EQ5ZIt5qofULqm6EF2oHr38Z+019M3NHXEX7zszITFHUpMGls2jANppfBxWjmCuWE196Ib5vE9klGTYoTcw/N3WZFQ0tt47SfFqGkurzZVRC51InOzsJXvbidOrGN7/Da4wr3xtnCsAbzNcpal33cQbMAbXEIyu8bZbrXEk94hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQpykQ4p; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727643866; x=1759179866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ccPCnznOouvaoyBd3WYx5wMpjeH7SlJrYJkHgz2QeUM=;
  b=lQpykQ4pmuHoZs+BeUdazFV/NVwFwLH7eQ9xPeFpiF3Tlgk8/UmD+m8o
   c2B9Yv5fdrF+RH4MoupCV76XKPO9U4JFaHEwVWeVZkYOsyN8gJeMFYkOw
   mzeV6N1EJgxB/5ODj445olcnNga9Ud/DiBGCfz3K3BZ9Jp71nws2DjRAL
   /WMZ6mZo5+5rQR4kzmyS9x//ujA5vd+I9szpa/pI4DTWzn0ZPLrKQhPNR
   X2u1f9FSl0U7ZTcEdHdgxIEjmNSD/QnMZ3JMpVfyoBsDwN3HADiNmpb92
   85NuEXygxmIduwHjvynaj0PmTJEmZMnhFw2Pk7ftMAAStEPpK5L7JWhgt
   w==;
X-CSE-ConnectionGUID: cW6YnambRpmxS4CVqUOwCA==
X-CSE-MsgGUID: TOB+5yJxRyOvHi/xKszymQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30515856"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="30515856"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 14:04:24 -0700
X-CSE-ConnectionGUID: ivPEDwksSyCZeN04L7xsJg==
X-CSE-MsgGUID: qgI/hI7eS7e/5GuMWsF1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="73239673"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 14:04:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:04:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:04:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 14:04:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 14:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4wnQpVE4EQeU0KeK43Qa4ydETnymYZs1Skr9n5yskhK/Pc2ou5Va1PpV9scJ3niadxDYCz42p8SCcYRM5srL5tdvga744rfNZ5PzHrIAQjCRszsPi3c3yNpBXnkI5APrhrIgWRVVlu0NjgRozFbYHaovp3MJh+w8NCmo/Zt9VkQKQKr065GeCH5BD+BfeEF+YUbb1N9K4KDrCN69d4F1eTDyVJ50ZruqxuxVQKYbVDStmN70tm6nWwqkDdMjXKrhY4rm70WQi/nazT0lLyPVmsOX/i6qgVd9c1MD7pwmJ+x7Z5+jMVY3cHhD4NzoruO+Lwa3USuyWiLDkVG7b5dQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccPCnznOouvaoyBd3WYx5wMpjeH7SlJrYJkHgz2QeUM=;
 b=Rc+wV6S0A6FmTYSh00w1mYrzLXQSCEG6nA7RU5l2e66IU03jta4nNXSeae7Kw5vLEqPP9cIDPxhPpjFQd+eCACqoK3OXxrZr15N/JcVFZENfbjfm+wYyyrvsjbfH2Ea3jo+nd85S6ZzXO1CG6x7FUYQwCYAczxLCL1tNUHUAb6nL5xjbHU7HxXZP1P6aoYSCJLhH7XjtwQ7gqwkuaYTKzDd9ekEKvAHSshbTLPXQZIlxTB5ripUn7mjUN5MES1l1a1UMX0DVQ6Y1BD4KqGnUnqsp3oU4PR21f/Xptw8xUdqoy3FjAt5W0DJz0cerFwIK77AqDLiTE+nm32Q4qg3rPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 21:04:20 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 21:04:20 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be
 atomic_long_t.
Thread-Topic: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be
 atomic_long_t.
Thread-Index: AQHbEUxtX8wJ6hQufk+pvmzXqUB7f7Js2fSAgAJpnAA=
Date: Sun, 29 Sep 2024 21:04:20 +0000
Message-ID: <SJ0PR11MB5678B90399CA24DA213B2F0EC9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
 <CAJD7tkbCrrpPBnm1vE2_pBZCjc1i3w37Pf-5hb1Bt7Xd552=FQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbCrrpPBnm1vE2_pBZCjc1i3w37Pf-5hb1Bt7Xd552=FQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB6967:EE_
x-ms-office365-filtering-correlation-id: 256bb93c-7236-4eb2-41cc-08dce0ca49f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTdMaFducWV1MHFIUVo4aUU0S2JWcFZYRXA4MEQwcmJkWERxbm96SllYMkhq?=
 =?utf-8?B?RnZWMnpJWEl5NCt5RTVxeXhrWjhPbWpZcElDNTM1eWNhbldKVXlrNjMxNU5J?=
 =?utf-8?B?YmNqZjBkRm9jaU1WY256QUUrT3JmVlFEMXlkRTNwYUZCZDRxWlV5cXo3eWcr?=
 =?utf-8?B?bG1CcmplV09EUFFESm5udVJTanJYRjVOV01qS2phMitQZUhNbC9qbDlyN0dM?=
 =?utf-8?B?TENud001SVpIMTZ6d3hPbDhNc0czcFV0QUU4T2xDd2g5alhGa3NjZTN0ZjNB?=
 =?utf-8?B?OGdpUG1pVEd4RmdwQlMrNzA2NkhqcGxNNWtxbkw2UW1nWkF4V2JaYThEZitx?=
 =?utf-8?B?a1hkL1A0TE4yRWQ1SURERVNZZ0h2b1ZnREEwVmlLMVB5MTFoU3piL3JDWlpv?=
 =?utf-8?B?dDhaU3hWdHk4cXFaOU1XZmNobkwzNllDYWhvbFY4cXZSNDFVc1lGaHNCamJk?=
 =?utf-8?B?Nm5wWFpwMGFpQ25uYVZWMWhpTktwK3JxVk4yNWk3WFJaUk5EbGxraWN3MEdT?=
 =?utf-8?B?N2RhSXBCSURKemFFZ0J5d1U1Ym9PQ0RibWNrRWxYRnhlNU80NUFtZTAvOTll?=
 =?utf-8?B?bTU2R2k5WmtxM055SzFoSnRzK1FpcFhmVkdPS2VsL3BPNzVDZ0crbE9TalJu?=
 =?utf-8?B?Y2hYemdDcVlRbE9SK25JZnZYWVl0Qjk2TU42NnhORTBwelZYbnpnK281SzZV?=
 =?utf-8?B?UVRpL0J2V0FpMDdCVzdDNnduL3ZLS3BTZ1VyV3BtZFd1UDNYVEtjUmZXMDlw?=
 =?utf-8?B?OVBYRzNuby9mQy83UUpza0tVdjdBVUpqYUtDQ0dZZ1RJWmFYak0zVEFZekVU?=
 =?utf-8?B?RnlyVGdzL2tuT3FDa3BtR2JUYy9JSDJqY2NCSTk4TFY3VHhGbUtXT1E3M2tN?=
 =?utf-8?B?ZTE4ZVhYNkFyMDkrazlZbVF5cDdDMWFSdjlTVVpHeDNBSG85bHpqdlBqWkEy?=
 =?utf-8?B?M0pYVDA4K2dwMHlGSGFVc0VGZnJOWURBUHBuRVZaTnFsc05zOXNpZi9ydUty?=
 =?utf-8?B?L285ZmhoWFlnWGJ6dTRVRUlIbkM5cmxmMGVmSzRxelgvNnZLNU9mRFhEMG9G?=
 =?utf-8?B?cVpEWEpCSzF0YjZORnNmamZlVEtZbDc1RnJ5ZGdPNFVNa0NYT2N5V0FUdXZZ?=
 =?utf-8?B?M2pONjZQK0tSTFM4UDV4NlJ4a0FvTnIyK0dQblV1dFZlUGk5Q25CTFNyaG96?=
 =?utf-8?B?OURyK296QVVFRE1FcWIySFY3VXVWMG1XYUVXdFhXM0puS0xDZDZpN1doY0FG?=
 =?utf-8?B?TWxQZzZ2ZEx0R2ZMajNTVHE5bzhtd2NtWVQ2UVpMaFBWTkhYUFZYNEJxbERa?=
 =?utf-8?B?U3h3bXJzN1MvMGNjVU11aEVvNmxqSlJrZURmdTJYYVFlRVlPbnd2Z2JJTlRa?=
 =?utf-8?B?ZHRjMGNNcTdJTVh0T0hzSGJqcEcvK2RXLy83ejk1NENQRWZnZnZWN0RUMGNt?=
 =?utf-8?B?N0s2N2NRUXJDdjhPMWU4UDB4MWM2T2gyWGhZWk53aStESDJmaHB3RytpUzM2?=
 =?utf-8?B?Z04zNENtZEhmTzdJenIzNkhrTGxtaEg1cDBtYTF2YWJlT1pWVFFkem1tZk9h?=
 =?utf-8?B?Wjl0MWlhTHN5b1Q2SFk5K1NCMU0zU0FXWTRpZlhRc3Ixd1lZa1pKcXNGZ3pT?=
 =?utf-8?B?bUptcGMzRnpsNC9vYy9iTUFoMWw3ZjVpYnVEbGFNWmFQUEFwV3Q4bkNISzdL?=
 =?utf-8?B?aXYvOFlxNUlVOGszWmpzRjZpNE05VURGR3Y1M0g1aTltUDd2bXBLK2xsK1Fh?=
 =?utf-8?B?UzBjdHNmTUlWTlZ6cHJ1TW9Ldk5hR3BoL005a1dsZGdIRlUyWlVyWk16SXhy?=
 =?utf-8?B?WFRhbUdCMjRrR0hwZGN5UT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0hMcC8xNHFXZDBFV3ZlM1ZWV3pJYXhRUGtsQkRkY1dobWZJejduOGhNa2hQ?=
 =?utf-8?B?eU84YVFMbG1TN2N6OFBXQXBIZ2F0Zit4ZzI0UEYrVTR2ZXpCMlJxRVhwV2hz?=
 =?utf-8?B?YTU5RHRaYjBEdEJFTThTbElzeUp4ODc2TmJoRHIxbjcyeEM4eFJ1elJKY3hS?=
 =?utf-8?B?SFlkZ3lTeUJMcFRqRktHZnFRZHRSbWY2UkozZGRiRTBLZGpjN3ZERThPdTha?=
 =?utf-8?B?M3FEZHFoRm9aTFZpRlNOeXE2SW1ySlFWdUxLVTczM3M5eWZ6bENYVlN5aXJp?=
 =?utf-8?B?ZUNDdWVFWk81NmQ2ZlhsYmRyb0N3M0w1eWdFK2xRN3ZUczMyaGhxUmUxYmFY?=
 =?utf-8?B?azJpb0xSSEVQNHdLZXEyRmpRWlRKV3kyWFM2Z245eEF6aFFGaUREZXBmcHRS?=
 =?utf-8?B?S2NkRElsOTBvc3QrYkZHNUt5WC9QVVRmdHZHa3gyQ0dla1VkNHJBZTNhK1FK?=
 =?utf-8?B?YUxSd2x1NEQvR0FiM3pyRnl6NERpamhQTStJR00rMnkzMlVVdnBCMVBJV2Fp?=
 =?utf-8?B?cjFlbVJtbU45Q25QTTFKTHU2YjZTMG5IOVZib2FHeEo4VmgzWmRYN3Q0YmVF?=
 =?utf-8?B?Zkt3MUoyanlkTHN1bTNPYTJReDRlMnJwUHJTaHhsL0ZBbXo3Q2lmNWhvcXAw?=
 =?utf-8?B?eUUyWCtVZUFvazdQdzZoS0RyV1M2TkJqRVo3aVJMKytvZlRMZTdKQ0JQYmtO?=
 =?utf-8?B?QWF2UWt1OUhVZ2RBVm4zQzQ1WCtiUE9ydExIVGx2KzFlUzJ4SE02eVN6MWsv?=
 =?utf-8?B?azZXWStDTnMxQTgzUVlZeWgvTGE0YWdZeUkyMzFBSFNYTGZCWnFqc0JYejN4?=
 =?utf-8?B?cGpjWm44VXRiR1Rab1ZYc25QeDNFdFk4UExDdHhhcHNjNXZMLzI2WHpkeU5o?=
 =?utf-8?B?cTU1aG5zMXdaZzR6UHdrQVZCWFQ5Z0tBL2FzbHIxSWNwT2d1N2haamxpcDZn?=
 =?utf-8?B?U2FVWFZCNEVMVlJPRnNTZW5vNS9rRkNBSnZoNko0R1crdHlHcUFMTThRYlFV?=
 =?utf-8?B?U0MxKzVYelhCWkI5VHUrMWxHOXpDOVVZZTNXUkpudC9XYlhOTkZXRkpnUURq?=
 =?utf-8?B?VVplQjh3bUU4U0dOSHlDamtSdTJXNGx5cWNtb3BjTnF4eGdUc25VMThUWFA5?=
 =?utf-8?B?MkViWXFxcXkxS1FMTUJUVURWYVE2cUNEeWlGOE1iQ0RRbDVOa3gyVHNyb3l2?=
 =?utf-8?B?bnk3R3hiaDBrK1dQL1dneWZjV2ttcUdrNXFkdDFBdnJ1QlVJSDYxVUswamZK?=
 =?utf-8?B?NHNUZmVUcmlxNGJMRDE2UTRPSEc2VHdEVHhjV1pkNjFFeVhpb3BHelBBZzRk?=
 =?utf-8?B?a1ZRdS94Rit6R2VFRWZVZkx6clZhZG52TWVHb1N3eTJwelY3MlpqOVlmSVlY?=
 =?utf-8?B?MlZoUlRJNStua1FxaEpLL3BLU2tDSDZiYkhYaFpLamRUaFo5WE05L2tmdmRp?=
 =?utf-8?B?cjJpRmplZWxFdkVkM29rN2pjQVh2RXcwR01iRkJ0SXBuL3FHQkpKQVNDZG1h?=
 =?utf-8?B?MjNjMkZpZ2dMdEJJTkc2YVpCREVWNEdlTE1YdmFGYU1weWtmSSt1c2F2TU9W?=
 =?utf-8?B?R2Z1R2gxVndIaFlJRUtXK0JyWVdhelgrY1gvbWUzcmhyb2dGdmRJZHA5bEYz?=
 =?utf-8?B?cjFGekJtOCttdlFrckNXZDFJWlFqUGJPcDBpNUtmcGJvVGxveE15VzYrUmhF?=
 =?utf-8?B?dGZXb1hhRTFoWmovYWQwUDJYZmJ1YUtHM1g0OENYZW1ENHl6WWhwRys4dnY3?=
 =?utf-8?B?NVdNYk44eDMwYzFja2RvNTh6Y3NXTlk2T21YeUlrc1hQY3ZuTFpDQVRDMFBW?=
 =?utf-8?B?ZmJMRC96L3VuRXpuU2hFWlo4dkVSWXhOVjRxQTBHVkJlUkFmNy9ILzVDbTNZ?=
 =?utf-8?B?NXdOREQvU1E5cFRCUDBKTWV2U2gzYnIzZTNsY3RGbHRPTHg4aFpzU2tTSXBN?=
 =?utf-8?B?a0lWRDVkTmlQeVpJOHRid3dteVFtUHgyRm9FTW9Pa0hWYUxmejZpMGQzUGQr?=
 =?utf-8?B?cHRTa0NRZkhNcy8xM1RQZ0hXN0htZ1hNUzhSV2tMTE00Mm9JYXdPVm1XVFFz?=
 =?utf-8?B?UkZYR0hGNlMxcUJHSGFVVHVjdzdJVGVFVkdTQmtNVHFyTEhlSVRtOHlDTjVJ?=
 =?utf-8?B?VXpCK3dvUU5pOWR2T3lIcnhESG1VcmVGYmJ2R0FHZHVtYzNLUEs0MzNyYktk?=
 =?utf-8?B?MkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 256bb93c-7236-4eb2-41cc-08dce0ca49f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 21:04:20.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhwFDSqqEOQNSpmzDGuF4ecNeTAk4g6HQEdX3p1w3kUEet3zmbe6VTxWq/bShJtctD1ArXIcMgzB1Pbq3Ht78VDpjCa7FQ6t9k9oTsSr/o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDI4LCAyMDI0IDE6
MTMgQU0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWlu
Zy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0
QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1
YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0
aW9uLm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNS84XSBtbTogenN3
YXA6IE1vZGlmeSB6c3dhcF9zdG9yZWRfcGFnZXMgdG8gYmUNCj4gYXRvbWljX2xvbmdfdC4NCj4g
DQo+IE9uIEZyaSwgU2VwIDI3LCAyMDI0IGF0IDc6MTbigK9QTSBLYW5jaGFuYSBQIFNyaWRoYXIN
Cj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRm9yIHpz
d2FwX3N0b3JlKCkgdG8gc3VwcG9ydCBsYXJnZSBmb2xpb3MsIHdlIG5lZWQgdG8gYmUgYWJsZSB0
byBkbw0KPiA+IGEgYmF0Y2ggdXBkYXRlIG9mIHpzd2FwX3N0b3JlZF9wYWdlcyB1cG9uIHN1Y2Nl
c3NmdWwgc3RvcmUgb2YgYWxsIHBhZ2VzDQo+ID4gaW4gdGhlIGZvbGlvLiBGb3IgdGhpcywgd2Ug
bmVlZCB0byBhZGQgZm9saW9fbnJfcGFnZXMoKSwgd2hpY2ggcmV0dXJucw0KPiA+IGEgbG9uZywg
dG8genN3YXBfc3RvcmVkX3BhZ2VzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEg
UCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBm
cy9wcm9jL21lbWluZm8uYyAgICAgfCAgMiArLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L3pzd2FwLmgg
fCAgMiArLQ0KPiA+ICBtbS96c3dhcC5jICAgICAgICAgICAgfCAxOSArKysrKysrKysrKysrLS0t
LS0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9wcm9jL21lbWluZm8uYyBiL2ZzL3Byb2MvbWVt
aW5mby5jDQo+ID4gaW5kZXggMjQ1MTcxZDkxNjRiLi44YmE5YjE0NzIzOTAgMTAwNjQ0DQo+ID4g
LS0tIGEvZnMvcHJvYy9tZW1pbmZvLmMNCj4gPiArKysgYi9mcy9wcm9jL21lbWluZm8uYw0KPiA+
IEBAIC05MSw3ICs5MSw3IEBAIHN0YXRpYyBpbnQgbWVtaW5mb19wcm9jX3Nob3coc3RydWN0IHNl
cV9maWxlICptLA0KPiB2b2lkICp2KQ0KPiA+ICAjaWZkZWYgQ09ORklHX1pTV0FQDQo+ID4gICAg
ICAgICBzaG93X3ZhbF9rYihtLCAiWnN3YXA6ICAgICAgICAgICIsIHpzd2FwX3RvdGFsX3BhZ2Vz
KCkpOw0KPiA+ICAgICAgICAgc2VxX3ByaW50ZihtLCAgIlpzd2FwcGVkOiAgICAgICAlOGx1IGtC
XG4iLA0KPiA+IC0gICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZylhdG9taWNfcmVhZCgm
enN3YXBfc3RvcmVkX3BhZ2VzKSA8PA0KPiA+ICsgICAgICAgICAgICAgICAgICAodW5zaWduZWQg
bG9uZylhdG9taWNfbG9uZ19yZWFkKCZ6c3dhcF9zdG9yZWRfcGFnZXMpIDw8DQo+IA0KPiBEbyB3
ZSBzdGlsbCBuZWVkIHRoaXMgY2FzdD8gIkhhcmR3YXJlQ29ycnVwdGVkIiBzZWVtcyB0byBiZSB1
c2luZw0KPiBhdG9taWNfbG9uZ19yZWFkKCkgd2l0aG91dCBhIGNhc3QuDQo+IA0KPiBPdGhlcndp
c2UgdGhpcyBMR1RNOg0KPiBBY2tlZC1ieTogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xl
LmNvbT4NCg0KVGhhbmtzIFlvc3J5IGZvciB0aGUgQWNrZWQtYnkncyENCg0KVGhhbmtzLA0KS2Fu
Y2hhbmENCg0KPiANCj4gPiAgICAgICAgICAgICAgICAgICAgKFBBR0VfU0hJRlQgLSAxMCkpOw0K
PiA+ICAjZW5kaWYNCj4gPiAgICAgICAgIHNob3dfdmFsX2tiKG0sICJEaXJ0eTogICAgICAgICAg
IiwNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC96c3dhcC5oIGIvaW5jbHVkZS9saW51
eC96c3dhcC5oDQo+ID4gaW5kZXggOWNkMWJlZWYwNjU0Li5kOTYxZWFkOTFiZjEgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC96c3dhcC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC96
c3dhcC5oDQo+ID4gQEAgLTcsNyArNyw3IEBADQo+ID4NCj4gPiAgc3RydWN0IGxydXZlYzsNCj4g
Pg0KPiA+IC1leHRlcm4gYXRvbWljX3QgenN3YXBfc3RvcmVkX3BhZ2VzOw0KPiA+ICtleHRlcm4g
YXRvbWljX2xvbmdfdCB6c3dhcF9zdG9yZWRfcGFnZXM7DQo+ID4NCj4gPiAgI2lmZGVmIENPTkZJ
R19aU1dBUA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9tbS96c3dhcC5jDQo+
ID4gaW5kZXggMGYyODFlNTBhMDM0Li40M2U0ZTIxNmRiNDEgMTAwNjQ0DQo+ID4gLS0tIGEvbW0v
enN3YXAuYw0KPiA+ICsrKyBiL21tL3pzd2FwLmMNCj4gPiBAQCAtNDMsNyArNDMsNyBAQA0KPiA+
ICAqIHN0YXRpc3RpY3MNCj4gPiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8N
Cj4gPiAgLyogVGhlIG51bWJlciBvZiBjb21wcmVzc2VkIHBhZ2VzIGN1cnJlbnRseSBzdG9yZWQg
aW4genN3YXAgKi8NCj4gPiAtYXRvbWljX3QgenN3YXBfc3RvcmVkX3BhZ2VzID0gQVRPTUlDX0lO
SVQoMCk7DQo+ID4gK2F0b21pY19sb25nX3QgenN3YXBfc3RvcmVkX3BhZ2VzID0gQVRPTUlDX0lO
SVQoMCk7DQo+ID4NCj4gPiAgLyoNCj4gPiAgICogVGhlIHN0YXRpc3RpY3MgYmVsb3cgYXJlIG5v
dCBwcm90ZWN0ZWQgZnJvbSBjb25jdXJyZW50IGFjY2VzcyBmb3INCj4gPiBAQCAtODAyLDcgKzgw
Miw3IEBAIHN0YXRpYyB2b2lkIHpzd2FwX2VudHJ5X2ZyZWUoc3RydWN0IHpzd2FwX2VudHJ5DQo+
ICplbnRyeSkNCj4gPiAgICAgICAgICAgICAgICAgb2JqX2Nncm91cF9wdXQoZW50cnktPm9iamNn
KTsNCj4gPiAgICAgICAgIH0NCj4gPiAgICAgICAgIHpzd2FwX2VudHJ5X2NhY2hlX2ZyZWUoZW50
cnkpOw0KPiA+IC0gICAgICAgYXRvbWljX2RlYygmenN3YXBfc3RvcmVkX3BhZ2VzKTsNCj4gPiAr
ICAgICAgIGF0b21pY19sb25nX2RlYygmenN3YXBfc3RvcmVkX3BhZ2VzKTsNCj4gPiAgfQ0KPiA+
DQo+ID4gIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gPiBAQCAtMTIzMiw3
ICsxMjMyLDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgenN3YXBfc2hyaW5rZXJfY291bnQoc3Ry
dWN0DQo+IHNocmlua2VyICpzaHJpbmtlciwNCj4gPiAgICAgICAgICAgICAgICAgbnJfc3RvcmVk
ID0gbWVtY2dfcGFnZV9zdGF0ZShtZW1jZywgTUVNQ0dfWlNXQVBQRUQpOw0KPiA+ICAgICAgICAg
fSBlbHNlIHsNCj4gPiAgICAgICAgICAgICAgICAgbnJfYmFja2luZyA9IHpzd2FwX3RvdGFsX3Bh
Z2VzKCk7DQo+ID4gLSAgICAgICAgICAgICAgIG5yX3N0b3JlZCA9IGF0b21pY19yZWFkKCZ6c3dh
cF9zdG9yZWRfcGFnZXMpOw0KPiA+ICsgICAgICAgICAgICAgICBucl9zdG9yZWQgPSBhdG9taWNf
bG9uZ19yZWFkKCZ6c3dhcF9zdG9yZWRfcGFnZXMpOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgICBpZiAoIW5yX3N0b3JlZCkNCj4gPiBAQCAtMTUwMSw3ICsxNTAxLDcgQEAgYm9vbCB6
c3dhcF9zdG9yZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgICAvKiB1cGRhdGUgc3RhdHMgKi8NCj4gPiAtICAgICAgIGF0b21pY19pbmMoJnpzd2Fw
X3N0b3JlZF9wYWdlcyk7DQo+ID4gKyAgICAgICBhdG9taWNfbG9uZ19pbmMoJnpzd2FwX3N0b3Jl
ZF9wYWdlcyk7DQo+ID4gICAgICAgICBjb3VudF92bV9ldmVudChaU1dQT1VUKTsNCj4gPg0KPiA+
ICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gQEAgLTE2NTAsNiArMTY1MCwxMyBAQCBzdGF0aWMg
aW50IGRlYnVnZnNfZ2V0X3RvdGFsX3NpemUodm9pZCAqZGF0YSwNCj4gdTY0ICp2YWwpDQo+ID4g
IH0NCj4gPiAgREVGSU5FX0RFQlVHRlNfQVRUUklCVVRFKHRvdGFsX3NpemVfZm9wcywgZGVidWdm
c19nZXRfdG90YWxfc2l6ZSwNCj4gTlVMTCwgIiVsbHVcbiIpOw0KPiA+DQo+ID4gK3N0YXRpYyBp
bnQgZGVidWdmc19nZXRfc3RvcmVkX3BhZ2VzKHZvaWQgKmRhdGEsIHU2NCAqdmFsKQ0KPiA+ICt7
DQo+ID4gKyAgICAgICAqdmFsID0gYXRvbWljX2xvbmdfcmVhZCgmenN3YXBfc3RvcmVkX3BhZ2Vz
KTsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gK0RFRklORV9ERUJVR0ZTX0FU
VFJJQlVURShzdG9yZWRfcGFnZXNfZm9wcywNCj4gZGVidWdmc19nZXRfc3RvcmVkX3BhZ2VzLCBO
VUxMLCAiJWxsdVxuIik7DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IHpzd2FwX2RlYnVnZnNfaW5p
dCh2b2lkKQ0KPiA+ICB7DQo+ID4gICAgICAgICBpZiAoIWRlYnVnZnNfaW5pdGlhbGl6ZWQoKSkN
Cj4gPiBAQCAtMTY3Myw4ICsxNjgwLDggQEAgc3RhdGljIGludCB6c3dhcF9kZWJ1Z2ZzX2luaXQo
dm9pZCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB6c3dhcF9kZWJ1Z2ZzX3Jvb3Qs
ICZ6c3dhcF93cml0dGVuX2JhY2tfcGFnZXMpOw0KPiA+ICAgICAgICAgZGVidWdmc19jcmVhdGVf
ZmlsZSgicG9vbF90b3RhbF9zaXplIiwgMDQ0NCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgenN3YXBfZGVidWdmc19yb290LCBOVUxMLCAmdG90YWxfc2l6ZV9mb3BzKTsNCj4gPiAt
ICAgICAgIGRlYnVnZnNfY3JlYXRlX2F0b21pY190KCJzdG9yZWRfcGFnZXMiLCAwNDQ0LA0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgenN3YXBfZGVidWdmc19yb290LCAmenN3
YXBfc3RvcmVkX3BhZ2VzKTsNCj4gPiArICAgICAgIGRlYnVnZnNfY3JlYXRlX2ZpbGUoInN0b3Jl
ZF9wYWdlcyIsIDA0NDQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHpzd2FwX2Rl
YnVnZnNfcm9vdCwgTlVMTCwgJnN0b3JlZF9wYWdlc19mb3BzKTsNCj4gPg0KPiA+ICAgICAgICAg
cmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAtLQ0KPiA+IDIuMjcuMA0KPiA+DQo=

