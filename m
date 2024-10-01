Return-Path: <linux-kernel+bounces-345063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C2B98B18E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928C11C21882
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8863B9;
	Tue,  1 Oct 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmU1C6wX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AE36C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743651; cv=fail; b=sPmechHtpggPn9Z7H9B35zcn0FzNmk3cugY5PatO00ZvDBQo/fxbCuaRTAYAofoeeH8gjoy2TnKHTrL7uzccoYo4TMzBm4UqPI8E8En9LnLWfZlHhuOVnOluD0KmiQRJG+WirJyvDc1ap3hjgdS4pp6NCoRhJEvtmy9HDA02rR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743651; c=relaxed/simple;
	bh=uZH4oIcmIPNzebBtsrOU/Uor+l10wFlw3og7j7fPaPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtoBAiOVYXoC3+RE6EePB9qhKOwlF3T7rXIzHipQ8sZFTcNGXXdNzu7Kn1nVTHVEuYo7pc7eTxwF+SUGXMLhzESwjkQS285nlAkEADrW1HMQly6F+Y2igrvkzPo6HaBDm3SQxPloN1/7rU7lsy3MveBMxTwdFtER57EaRaDRxlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmU1C6wX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727743649; x=1759279649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uZH4oIcmIPNzebBtsrOU/Uor+l10wFlw3og7j7fPaPU=;
  b=SmU1C6wXu5jLeJJHsyVRPSzezDzEvUJLgsTwoes+nIv+wcvig2XCMfqn
   ltL80xLSSvPug7lrbK7wPwWaLMktdYera29d2QJepfoaIVYzHDglwaT03
   DYvjNSby5Vh1mN/9mgq5cKaXx5WldbGGLaROd+5w7QuJaJwd5brDPHHp/
   YHuJg48WAPG2TEXQ77RfGypqavHOWrIuYn9PuNMLB6MI2bSRqLNFL9g9F
   GhG5bIj8zacTkIkX1oAvSFyXL6Hp4jabqtAuoQMfTMA/FFgQNiCYWgD8Q
   tXyBAENoIX3KJQCc4sSjeXpOi9wkXMkzCPqeGvstzoiWOIXOUtSxF3LsH
   g==;
X-CSE-ConnectionGUID: IyvH1nnmRX2YfRqgKS5Eqw==
X-CSE-MsgGUID: o7FFV09qQnatyjTQItdynw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44380553"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="44380553"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 17:47:19 -0700
X-CSE-ConnectionGUID: mI4Zai4ZQMmWS+ZRuPppMQ==
X-CSE-MsgGUID: KGBwl88NSoyLT+G2ZYk0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73605062"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 17:47:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 17:47:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 17:47:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 17:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgAEt1aAqWPZjCtP6GX1XuxR/EjNSm7kD8vnNip/EEFvW1wV8jspKDcMqpRn9D0PUOsiUrJswURYCh2L8Z1GDIIRwjn6n77WSmBO1O2GV/Nlu3yWD8cVDihER+0ZriR7fRADIPoyhSayj/mIRzKEaLZoEOPQhUF1Cc4E8mKl9wQqiwa7ElAA4axuQOpEuJu55apierREKIbvkuSmuAMd4d6Cuq3ASEJgQOE1UolStieN+mADJWGwcOi/qrkt/4GFtKHeR9Dux0Vcqyl/1rZHNPz0a6FZPZoaQXDviYiEvxfYdMms7u7RB+tVOqDoqKP/VpkLd2g98G+eGuKM9ChJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZH4oIcmIPNzebBtsrOU/Uor+l10wFlw3og7j7fPaPU=;
 b=PMlwlI1Hlb/KPYhCWuRFN1DfEmjFyNWLiQH20xBFCx8YjnMyYajdZdofb+nm86vox0UORD/lU7guIQBSgWwom4wDf26wcT6Og+zvDKCj+aV9Umcs7OFBacZdk66CxOMrr0eomlFU+vfMdzxnUZNa4RREZhx2yo2E3z51YnAJal3P3Ed0YaVod1542fX29yrS641SFqLOQQDJYdYlDAvG9CVhur2c94faCCqd6Yw86cxn1iqXed1VSZMTYi/RosNsmDUV1VeipSXpy2m/RsIM6OxJngJVnmjndIXNh6lrvdY0mb0UPuvjI5dclfI2Sf/Uy3ZKhTr1jAiqhTKqn2tRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 00:47:08 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 00:47:07 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
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
Thread-Index: AQHbE4XaXdnmYogniUi9EO2aNKPUnLJw9RUAgAACZoCAAAKxgIAAAReAgAACxICAAA6uYA==
Date: Tue, 1 Oct 2024 00:47:07 +0000
Message-ID: <SJ0PR11MB56789EBE66C4171241ECB831C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
 <CAKEwX=Podz0XkX4=sutZk_nRTPy_aQ3JSVUZ9GNxPbX=t7R2kg@mail.gmail.com>
 <CAJD7tkadrmzUHMXRbeScq+ekY1AJhjrSZ_mZtt4H7x1Z=Ad=UQ@mail.gmail.com>
 <CAKEwX=PBaioXK2iBjzjUHVeCReqCCNG3+qyhLcb6SDixbYbaLw@mail.gmail.com>
 <CAJD7tkaRrMp2APU=hzEos=oGkW6dW+M8GCzc8D=F1sboXZ_BAw@mail.gmail.com>
 <CAKEwX=Mt-UEt8jXcLQUq=U1h9uswcteSxgipAv2RYFM4wCar5w@mail.gmail.com>
In-Reply-To: <CAKEwX=Mt-UEt8jXcLQUq=U1h9uswcteSxgipAv2RYFM4wCar5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB6703:EE_
x-ms-office365-filtering-correlation-id: 857b95c3-c7ca-4157-bd30-08dce1b29379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ejkyRTJwWWdiYjNvTnk1dmpLVmFmajBDYVFGV0w2dlRxYlg4OW5BbHVOVUR5?=
 =?utf-8?B?azMxSGFGbzRaK1pwNkgxUEExVjBNUHJ2Q3BOdERtVWp1MHFBalU2eWRuczIz?=
 =?utf-8?B?R0h0VW9PYlFraS9yMCtGZzlZWnNrWU9EK0UyUHFLYlZsZG1ITG82VHQ5YW5W?=
 =?utf-8?B?VUQxSldiV25GY3dPVUtmdU5CL0N3MUJGOENUNXhjWHRsODhINW1LQlRFV1Bl?=
 =?utf-8?B?M1FST2lrRGsvWGorOG03TTY5NzdlUTZLVUVUZ1hNWmtQekZHTktIeXZYSE1J?=
 =?utf-8?B?dDNtUnFSaWt0M2hSN3VzeFVMVHZzRU1aZkRvS1g5NDAzZTdJaytFNmc4NTNn?=
 =?utf-8?B?RnJTQ0x1K09jakRaaXUwMitSbXhidVVvdmFRUmlERjNzZERsTWIwZjg0TS82?=
 =?utf-8?B?bG5VNVFhTmlhNGhDSEE3dmg4a3lyYWdPZDgxWnJQeFAvS2c5MEJLUDJvbjNS?=
 =?utf-8?B?WittTU9PNEtCeXM4T05MK1NFZ2JUMlJyTEF0ZFFnaUN2RUswcHhlWlFEaE9Q?=
 =?utf-8?B?anE2dTBqVHdSL2xIaXg4cENvQjZKd3d6ZTF2dEFhYTJRUDlBOTVtZjVCN0lV?=
 =?utf-8?B?eUFGVmZBV052cE44VjJBOFZJZ05qTXBNMythUlVNMk94Y1V1OWxseFEvNWw3?=
 =?utf-8?B?SXoyMDNBN2o1WlJPeThlMTFyMmN0VUdHZnVyRXdudHFnZlFKaHc5eHN2L2NS?=
 =?utf-8?B?RDRkdVdFSWF0eTg2Vlh2YU5hSlhRYk5oS2JaZ1N4dHZYV1g1SnIwUzdYV0Qz?=
 =?utf-8?B?OVpDNmdCcFV2TU1Od0VrRVMzQWpkM2hxVi9ZUUVRUFlaZ1hxeWZHUDJ1dXpj?=
 =?utf-8?B?ZU9xVUgxY1I0Z2NXdnpyM2thZldQYklFeTNWc1V3RnpnaVZUODV1R250M2JP?=
 =?utf-8?B?R1FDUWdYOVZHdnlCaGJGdXl1a0Mvam5UYzdzZ2k3TmJ3MnVQL0diTlEzQkI0?=
 =?utf-8?B?Zlp1QnNFOU1uU1JKalFBbkRqa0ZTQWhHVVhMR29hU0dkeFd5a1BPL0o2MmxB?=
 =?utf-8?B?UUNjN1ljTEZrS0plTnhyb3lxLzZWTDJoR3NZVGR5VEV2VzFodUlwY1YrYXZx?=
 =?utf-8?B?MStBelZYdjdHUVNHajVjTlVrS2xsQ3g2MjlyVUxpK2Y0MzMyUUdHRGpGYTVH?=
 =?utf-8?B?NFJCNUlVOXB6emJxNyt6UExrdUYxYU5xQzdBMFNnZ2d0enRwbVVobXNLaE5k?=
 =?utf-8?B?UEpYeU51TEkySHVnUVAydzB5a0FKVm9oNyt5dGtoUmZWU0RVWkhSMUhEUjZZ?=
 =?utf-8?B?ODN4aXllNnVDMDh6akRUTkZiRkt3S3NBUHlKNHdxYXZ4YXVPbkE0MGVad29u?=
 =?utf-8?B?aUdVNWRvRVJQNDZmTGpNMHl2aVZoV1RVWjNEdTF4WHJyU3FOd1d0ejFCRlU5?=
 =?utf-8?B?amxFU0lTNzc2VUNxL3p2UTk0cnRtVlVkREdzV2RvWmdMV3BSMWdrZ2Rudzcr?=
 =?utf-8?B?cm5ES1hoRWxrTlNCZUFNbkU0Tm1RK1libjJEejl2VHlxNm5mdVo4TEprWjZT?=
 =?utf-8?B?UGVpR1l6K0dScjNnRUUwR3drak1PNi9DRG5lTFljVXhzTHRsN3UvTnE1YU82?=
 =?utf-8?B?QVlzRFhmUk9zNnc4Q3ZxZHVML2R3eXlzNHBXbFJBZ1hHSGpOdVdMeGduZGJm?=
 =?utf-8?B?OXBaeE5OL3ROUk5wSU9pbUJidUNERysyUitwanpuclBrdkZQR2FUd3VjVjdK?=
 =?utf-8?B?Njd2UnVJQnY1cXcrRHMxSVlRT1g0dU1HeG9Uekl4eEUzOGdrT1E0VjAxMXp6?=
 =?utf-8?B?RGtpUWRoY1B2RnNwQ0ZGZDh1VnFUT1F3S1dlSlpZZjdGRTA1WnlYNlc2dzFS?=
 =?utf-8?B?c0NkalJTZW0xT2FPSlJkUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cis5V2Nza04ySFJlV3ZTYWdnMi9Rekp2b0pDUVNldzBaQ1VqL25Ec3hYQ3lQ?=
 =?utf-8?B?WVdWWUFVMWlCdkVyc3I0YUlKK24yQVl2ZytFVGtrWWk4RFJBRkpJMzd0L29l?=
 =?utf-8?B?eWVtSWNieXVGUGZqOVZRS2xxNnVoT0t5UWJaZUtFNTcrVVVyQXVYQ2FWVkFS?=
 =?utf-8?B?NldLc2FPUklpN0xXd2Z6VDhiMnVNNytFSk1jWWNvRWU4ZHd1Sm9xd3N1elhZ?=
 =?utf-8?B?Z2ZXQm4zVUJxcGxXbUhHRHFTRnJ0eHJLcjRqMFB6dk9NUjFmY1pFUmVicGhj?=
 =?utf-8?B?R2M3UzJPZkIrSEFGd1RzSmxaR2plLzByNlQ1YktSaElidC92YWNxaC9WL3FN?=
 =?utf-8?B?a0Z5SHlpWUxRQnh6S0J2WkZhRHd6Q1U2ZVloSzVPcFlGcE5tdXppemZwc0s3?=
 =?utf-8?B?d0tZb1dlL0NpNHpFSW5YTzF2b3RVbVp6QkI2T1JWZEJBMlZXRzA0RDNyeEZp?=
 =?utf-8?B?cURSR1A3eWsvUVFSNzV2WUtCM3VYUUF6emRGSjZuYjE5UXM1U1JHcTFVTjJD?=
 =?utf-8?B?QWxVQW5yckVZQkJibTJzMmJXV2xaNUNmVEZHMUJJNERST2ZsenpKR05nYnZq?=
 =?utf-8?B?eEQ1aEFtbjk2ZldNZEdjSDVaQVowL3Z2U1dtV25XL0gyalk1U2NIeUxBV0Rj?=
 =?utf-8?B?UHkxU0U0RlhCcFQ1dUNXNGF0TWNBMFlMK1hNR1VwQkhraHFwcERVUm9iVWVY?=
 =?utf-8?B?aGtYMzNHZXZTUm52SmZDUDdmcGo4ZU5GMXZ5V3N6NXRJRkhRU1FZc3lXNGVk?=
 =?utf-8?B?RGw5MHhnQy8vaEFBdXp5UjRQMXVicXc5cWcvdWgrT09KYjVmTTBaN21nMFE4?=
 =?utf-8?B?Si82YmN4UllwMTkxQlVPaVpCaEd0UWYyZ1dGMTZiSG5udUdNSWpsdDRZUlll?=
 =?utf-8?B?aHkvVFFFYWdIVzhIYVdjcVdKdFp4TzFFM3h3YWFBRGlzWXZ2Sms4MHNUL1pJ?=
 =?utf-8?B?d1lkMTJSOU5NdENsYUM1Z0FKVll5aS9PVU5JMEVGTDdhU25lSVpvcXlJSURK?=
 =?utf-8?B?ZFQ0R0NKTmk4cTdhRTNWSGRuVFIvem1DNy9Pa2wxS3hwcHU1WWh1RXVWYVlE?=
 =?utf-8?B?UEZjVWdEN3F1YW1hVW1ydnovb1RPcFYvQzN3T2dvRkxsVFI2Sk04RUFzRVYz?=
 =?utf-8?B?ZlpzU2llZ3lGVXV4YXhIWWFkcTNzalFQVW5wMFpSeXc4T3MvREE1WjIvY2dL?=
 =?utf-8?B?RlJTQkNKaS9ZTXROd0JNTkdYVFhPU01RRDMwWFJ0dUFNRXplODFlSElPcjFP?=
 =?utf-8?B?Mmw1K0N0YnB4Y3V2aEU5ZjM1OHdyVXI4c25DME5ySDN3NWZ5ejhDSGJ3TmV1?=
 =?utf-8?B?TzJIektvRWFvRGZMRjRtdlliZVdZVEdOU0MvQlUzVjJoSVBkblRBanl1anhJ?=
 =?utf-8?B?Z3RiQitBaytvK0MzbkRxZjFvTkMwWHNJN1U1N2NmdWpRbXZXM2FTckdudmRN?=
 =?utf-8?B?eDdGTjNQaXVtSXpsU1BvS0x0QUlJT0ZEYlBZV2I2OG9HcUtqRHluSTRtTmNI?=
 =?utf-8?B?OWduMUMyR0xMclh0WktnajZxRTZaTmczcjd6MFNEbTNkUTZRMExCVXNidXhY?=
 =?utf-8?B?VzJhY0s1QUtxaXlXenhaM1kzVm8rSy9lZHlEQUJuS1ZySmtXSHdrWCtkdUdh?=
 =?utf-8?B?cmNKeXNOS3pmL3h6b0xBSFc3cDZhMlFoZVVWUnR5MEFwZVR0Vjl2bkttSHVC?=
 =?utf-8?B?RmFKZzVpMmRqaHl1U2lnZXMrdDNsOUlFSjQ4OXJ1UFVGMzlaRmI5NFprTU9t?=
 =?utf-8?B?aTFNUm5uOUI5dmUvZWVLdnJNNys4dElla2c0M2tQeUJRZTZ6MGtJeUZVdmhB?=
 =?utf-8?B?VHJ4TU1jTFAxd3VTOC9mNzZlM3JsdjIrZTNHcVJQRWFYeEtvWlQyTHhmaHVO?=
 =?utf-8?B?YTNJYkZ0aGU4WHB5MTBjU3kyOHBsWFRFNlZ4VG1hT3ozdk8zL1NtazA4V0V3?=
 =?utf-8?B?L3ZKT0FuOGdTUHBTRnFGRzVHTStQZ253bWlGUXVsZ3RCYnRXaDFkcy9qUHkv?=
 =?utf-8?B?Q0E0aW9Fdm93QmNZT012NnNXVlJvVExBMnd4WTRjdUg1cjJEd2FuVXowK09t?=
 =?utf-8?B?QlJRczNqQnliRjkrby9wZmI4VWh0aXR5My9qcGtDK3ZYeVNSWFlMSllVeUk2?=
 =?utf-8?B?KzYwd1FTQnVlQ014R1BIN3ZKd0dUUU1UZHNmUWcvdmtOZjZxUkh0OGNRV0pV?=
 =?utf-8?B?M3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 857b95c3-c7ca-4157-bd30-08dce1b29379
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 00:47:07.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfX3AoAp7mLwWB0iLkNHDA0BbwPyTOLAO14ZI841KADn0Ff8+tsRYYUo/qytMji1kN9tiy4YFr4X0XPZtjqebR5dYFKTfUNbtArmjABzRF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAzMCwgMjAyNCA0OjQzIFBNDQo+
IFRvOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiBDYzogU3JpZGhhciwg
S2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT47IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9y
ZzsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2OyB1c2FtYWFyaWY2NDJAZ21haWwuY29tOw0K
PiBzaGFrZWVsLmJ1dHRAbGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlp
bmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc7DQo+IHdpbGx5QGluZnJhZGVhZC5vcmc7IFpvdSwgTmFuaGFpIDxu
YW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFs
aUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY5IDYvN10gbW06IHpzd2FwOiBTdXBwb3J0IGxhcmdlIGZvbGlv
cyBpbiB6c3dhcF9zdG9yZSgpLg0KPiANCj4gT24gTW9uLCBTZXAgMzAsIDIwMjQgYXQgNDozNOKA
r1BNIFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+
ID4gT24gTW9uLCBTZXAgMzAsIDIwMjQgYXQgNDoyOeKAr1BNIE5oYXQgUGhhbSA8bnBoYW1jc0Bn
bWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgU2VwIDMwLCAyMDI0IGF0
IDQ6MjDigK9QTSBZb3NyeSBBaG1lZA0KPiA8eW9zcnlhaG1lZEBnb29nbGUuY29tPiB3cm90ZToN
Cj4gPiA+ID4NCj4gPiA+ID4gT24gTW9uLCBTZXAgMzAsIDIwMjQgYXQgNDoxMeKAr1BNIE5oYXQg
UGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBJIHN1
Z2dlc3RlZCB0aGlzIGluIGEgcHJldmlvdXMgdmVyc2lvbiwgYW5kIEthbmNoYW5hIGZhY2VkIHNv
bWUNCj4gPiA+ID4gY29tcGxleGl0aWVzIGltcGxlbWVudGluZyBpdDoNCj4gPiA+ID4NCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9TSjBQUjExTUI1Njc4NTAyN0VENkZDRjY3M0E4NENF
RTZDOTZBMg0KPiBAU0owUFIxMU1CNTY3OC5uYW1wcmQxMS5wcm9kLm91dGxvb2suY29tLw0KPiA+
ID4NCj4gPiA+IFNvcnJ5LCBJIG1pc3NlZCB0aGF0IGNvbnZlcnNhdGlvbi4NCj4gPiA+DQo+ID4g
PiA+DQo+ID4gPiA+IEJhc2ljYWxseSwgaWYgd2UgYmF0Y2ggZ2V0IHRoZSByZWZzIGFmdGVyIHRo
ZSBzdG9yZSBJIHRoaW5rIGl0J3Mgbm90DQo+ID4gPiA+IHNhZmUsIGJlY2F1c2Ugb25jZSBhbiBl
bnRyeSBpcyBwdWJsaXNoZWQgdG8gd3JpdGViYWNrIGl0IGNhbiBiZQ0KPiA+ID4gPiB3cml0dGVu
IGJhY2sgYW5kIGZyZWVkLCBhbmQgYSByZWYgdGhhdCB3ZSBuZXZlciBhY3F1aXJlZCB3b3VsZCBi
ZQ0KPiA+ID4gPiBkcm9wcGVkLg0KPiA+ID4NCj4gPiA+IEhtbW0uIEkgZG9uJ3QgdGhpbmsgd3Jp
dGViYWNrIGNvdWxkIHRvdWNoIGFueSBpbmRpdmlkdWFsIHN1YnBhZ2UganVzdA0KPiB5ZXQsIG5v
Pw0KPiA+ID4NCj4gPiA+IEJlZm9yZSBkb2luZyBhbnkgd29yaywgenN3YXAgd3JpdGViYWNrIHdv
dWxkIGF0dGVtcHQgdG8gYWRkIHRoZQ0KPiA+ID4gc3VicGFnZSB0byB0aGUgc3dhcCBjYWNoZSAo
dmlhIF9fcmVhZF9zd2FwX2NhY2hlX2FzeW5jKCkpLiBIb3dldmVyLA0KPiA+ID4gYWxsIHN1YnBh
Z2Ugd2lsbCBoYXZlIGFscmVhZHkgYmVlbiBhZGRlZCB0byBzd2FwIGNhY2hlLCBhbmQgcG9pbnQg
dG8NCj4gPiA+IHRoZSAobGFyZ2UpIGZvbGlvLiBTbyB6c3dhcF93cml0ZWJhY2tfZW50cnkoKSBz
aG91bGQgc2hvcnQgY2lyY3VpdA0KPiA+ID4gaGVyZSAodGhlIGlmICghcGFnZV9hbGxvY2F0ZWQp
IGNhc2UpLg0KPiA+DQo+ID4gSWYgaXQncyBzYWZlIHRvIHRha2UgdGhlIHJlZnMgYWZ0ZXIgYWxs
IGNhbGxzIHRvIHpzd2FwX3N0b3JlX3BhZ2UoKQ0KPiA+IGFyZSBzdWNjZXNzZnVsLCB0aGVuIHll
YWggdGhhdCBzaG91bGQgYmUgcG9zc2libGUsIGZvciBib3RoIHRoZSBwb29sDQo+ID4gYW5kIG9i
amNnLiBJIGRpZG4ndCBsb29rIGNsb3NlbHkgdGhvdWdoLg0KPiA+DQo+ID4gSnVzdCB0byBjbGFy
aWZ5LCB5b3UgbWVhbiBncmFiIG9uZSByZWYgZmlyc3QsIHRoZW4gZG8gdGhlDQo+ID4gY29tcHJl
c3Npb25zLCB0aGVuIGdyYWIgdGhlIHJlbWFpbmluZyByZWZzLCByaWdodD8NCj4gDQo+IEFoIHll
YWgsIHRoYXQncyB3aGF0IEkgbWVhbnQuIFdlIGNhbiBlaXRoZXIgcGVyZm9ybSBvbmUgb2YgdGhl
DQo+IGZvbGxvd2luZyBzZXF1ZW5jZXM6IGdyYWIgMSAtPiBncmFiIG5yIC0+IGRyb3AgMSwgb3Ig
Z3JhYiAxIC0+IGdyYWIgbnINCj4gLSAxIGlmIHN1Y2Nlc3NmdWwsIGRyb3AgMSBpZiBmYWlsZWQu
DQo+IA0KPiBTZWVtcyBzdHJhaWdodGZvcndhcmQgdG8gbWUsIGJ1dCB5ZWFoIGl0IHNlZW1zIGEg
Yml0IGhhaXItc3BsaXR0aW5nIG9mDQo+IG1lIHRvIGRpZSBvbiB0aGlzIGhpbGwgOikgSnVzdCB0
aG91Z2h0IGl0IHdhcyB3ZWlyZCBzZWVpbmcgdGhlIG90aGVyDQo+IHBhcnRzIGJhdGNoaWZpZWQs
IGFuZCBvbmUgcGFydCB3YXNuJ3QuDQo+IA0KPiBUaGUgcmVzdCBMR1RNIC0gSSdsbCBkZWZlciB0
byB5b3UgYW5kIEpvaGFubmVzIGZvciBmdXJ0aGVyIHJldmlldy4NCj4gDQo+IFJldmlld2VkLWJ5
OiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPg0KDQpUaGFua3MgTmhhdCEgU3VyZSwgdGhp
cyBzb3VuZHMgZ29vZC4gSSB0aG91Z2h0IEkgd2lsbCBjbGFyaWZ5IG15IGN1cnJlbnQNCnRoaW5r
aW5nIG9uIHRoaXMuIEFzIFlvc3J5IHdhcyBhbHNvIG1lbnRpb25pbmcsIGJhdGNoaW5nIG9mIHRo
ZSBwb29sIHJlZnMNCnJlcXVpcmVzIHNvbWUgbW9yZSB0aG91Z2h0LiBUaGlzIGlzIHRpZWQgaW4g
dG8gdGhlIGRlc2lnbiBhcHByb2FjaCBvZg0Kb2J0YWluaW5nIHRoZSBvYmpjZy9wb29sIHJlZnMg
cGVyIHBhZ2UgYmVmb3JlIGFkZGluZyB0aGVtIHRvIHRoZSBlbnRyeSwNCndoaWNoIGluIHR1cm4g
bmVlZHMgdG8gaGFwcGVuIGJlZm9yZSBhZGRpbmcgdGhlIGVudHJ5IHRvIHRoZSB4YXJyYXkuDQpJ
IHRoaW5rIHRoZXJlIGlzIHNvbWUgdmFsdWUgaW4gZG9pbmcgdGhpcyBpbmNyZW1lbnRhbGx5IGJl
Y2F1c2UgYXQgYW55DQpwb2ludCwgaWYgc3RvcmluZyB0aGUgcGFnZSBmYWlsczoNCg0KMSkgQWxs
IGV4aXN0aW5nIGZvbGlvIGVudHJpZXMgaW4gdGhlIHhhcnJheSB3aWxsIGhhdmUgdmFsaWQgcG9v
bC9vYmpjZyB0aGF0DQogICAgY2FuIGdldCByZWZzIGRyb3BwZWQgd2hlbiB3ZSB1bndpbmQgc3Rh
dGUuDQoyKSBUaGVyZSBhcmUgbm8gZXhjZXNzIHJlZnMgdGhhdCB3ZXJlIHBvdGVudGlhbGx5IG9i
dGFpbmVkIGJ5IGJhdGNoaW5nDQogICAgdGhhdCBuZWVkIHRvIGJlIGRyb3BwZWQgKHRoaXMgbWln
aHQgbWFrZSB0aGUgY29kZSBhIGxpdHRsZSBiaXQgbWVzc3ksDQogICAgaW1obykuDQoNClRoYW5r
cywNCkthbmNoYW5hDQo=

