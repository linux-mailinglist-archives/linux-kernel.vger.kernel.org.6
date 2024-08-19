Return-Path: <linux-kernel+bounces-291471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAB795630D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7358F1C21557
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905D114A0B9;
	Mon, 19 Aug 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrIPUN3B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0B13C81B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044380; cv=fail; b=hM4vbbeZTs4J5w5ubxbwi3eJrfl79mV8lXrUR1w1PVgUzyxYZd9ou0ERuYaRhoSrAhJSFE6u8oRNyl/UGnXQ7xZUDZK+2TRFa0FZ3UJlVgboFVJxqV4ZglLi41vGDwc13+AwmzUWQhCT/0g07G/PBKN5k8F5QMdj/PonDzDMA1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044380; c=relaxed/simple;
	bh=sa7v3adrnjYe4x9L24rCqOJwz4xcrZ3Kdw7ryOE3mUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/QMpq0zLYC8SeStft7VUpAr6nYDgPiEn6LnwHKdMhpbTkQe8LE3nTsYEtpWS4gmlsc/Qx2tzQj3MUOHRlg/zx51sLw2ATKbiAa/t64YhX0CsgldmUQoGDFyAtCzU+7B7bL6VEVU5hesFwBBsdLqfr4ZE0HJMTfK9lXkiY49C6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrIPUN3B; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724044378; x=1755580378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sa7v3adrnjYe4x9L24rCqOJwz4xcrZ3Kdw7ryOE3mUY=;
  b=RrIPUN3BvUn9lHmDFcq+FIvkk+DVuQRQ8z9DgQyVAjVcP6E9W4s2pdLk
   Nb5aVJcn0GI9vgu9tOrpZx7JdHTwGiVxVLIO35JyQMf8D+VIUxMk6wCdD
   WYzbZaNEMIsnO36dbunME3wEvl0UVvNiUgtri4LEn1AV8Q3UHfj8TcMvz
   F1qceo1qEmrqlxnXYqUQLobNUeh2LAbSVkIDZqn1q4bTjrO5jzoIy60ii
   k1adXwgvkwvdBuHKyDvly2eAWhzehGh33Bv4SIZeXHLzgK8DtOaO+nwAb
   oB3dBjDuVIBgKDvPS6S4yJeUasfxk4vJak5mygYxTv9tmjyrEu5Pd6dqJ
   Q==;
X-CSE-ConnectionGUID: RUlsUxUfTCmYMtIeSjV9vw==
X-CSE-MsgGUID: Xkdvb4b4RfGzG6v6VBdK3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21890062"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="21890062"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 22:12:57 -0700
X-CSE-ConnectionGUID: KA0rRzAMRH2sGG8UZ2kJVg==
X-CSE-MsgGUID: XhK9ir6+Q2KZWnrnK5Cr0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="61023002"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 22:12:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 22:12:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 22:12:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 22:12:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdD20DQJvKMVgJuTM9pWsFzdh/j/ekoVEbYPMelZP6be3inlhO1I6VKoblvCc2apW0/hQFwF+X8liLLan3jmU991HHfQHJ4AFWrqyxQ2dY1QWfqYrcavBAozJeWo5KKUxA0k/qtE+ITYgvZreG9QwTeW+p5yT7HzripLflxwY3MZrWLcRr114VisctVIf/Pa+CxOBDnPMkW0U+C7Nc17/ZBEaGzwpZn4UiCyIlBCOFdgKgZ6VFOA+sVEk5TQjexMmqmWnN1RVg6d2CZWifdsOoff3R95muWoGvxMIaoeT4i/cLAIVZUccI2a08rJ6Q7+DXFI3MkEGvt23Wv/3CM/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1vWe8y2eDdNFgWhLrh6VDyWNs+Nu/2cKohuMglpZ10=;
 b=nsc2oSuVe/MnHXqTo/QF+mAxGEvqpW7k1cRzjY45ReSpWd8es3f4tDePmW6i4FmFBF97V1N09b4fZ2PwkmfJUHdiwNwC7XcZRG7hg4dHnWJrP/uEAmtJdi0ddvKA81s4iCk+3GTcG2fnZ+4RFALlXGtisCASnX5jSYRi3xeNFtqTvHswgCpIXwqrGu/ZK1Js+i2sUO3xrQHmpbfkP4caSyXqaAgpYTKH+PV+jBT7BgZkK4wLbBjvrXrC6v6tn4ksceRR7yo6/uLkDGMHeV3YNdVa9fbyPtbplL/VICfXo7hViiOeRM4XjLUGo9FZDNIPyNt5wCH3DmzVXtTflXZSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 19 Aug
 2024 05:12:53 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 05:12:53 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrIt6fDUgAAVm5A=
Date: Mon, 19 Aug 2024 05:12:53 +0000
Message-ID: <SJ0PR11MB5678BFAA984BEEBBFC2FC351C98C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <87msl9i4lw.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msl9i4lw.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA2PR11MB5051:EE_
x-ms-office365-filtering-correlation-id: 61ae37e8-891e-49b7-d9a9-08dcc00d9441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VxLx85bO+6B8SognIMy7C7+NuMKk/Y2MDDRBPR53VFGsU/Wqhf3di5/7zPSZ?=
 =?us-ascii?Q?995feV+SGi4Fvod0oHheRG+BvpG3WAYR+7tp5y0LBgSPyLPzMdDolEcpyCWs?=
 =?us-ascii?Q?FCN1Q+1xHduB8/1ZpBFtZzegZzS37kGsaST3Co1l9SyKPkrozEFqMwEj4WrI?=
 =?us-ascii?Q?K9DG54vW0RTYvDeFMh0qYLbsKsVjHWi+MQmyuOb3wVI5/Y+oPXIlwY2JAq6E?=
 =?us-ascii?Q?xDb09O7ctu1VFalgw1KA6Lxs9u4TR4F3ePVh8lI+54CawZ2/c7dctGdFJccJ?=
 =?us-ascii?Q?lrUoBoCgUUs/vSI80CRmtkXi9nrAPR7Ix/GGSNjPjT4MwRN6X9W2EBt5h7Hl?=
 =?us-ascii?Q?oF6a6zcsCJJJD7ajV2IU9InyJ7BtMdLP0yhCEk68bbJ4aQkkxekxVbBjLO0D?=
 =?us-ascii?Q?61fDmEnlQ+FnfUALGgBuZJeLBEWHG+Nm+BcmWpnTThE+qwi+YIhC1veuyZ9Z?=
 =?us-ascii?Q?sEJtGXMwxC3E5+uWNybYi/kpiGzPR3tNZsw9PVo1n5QTyxmjOSL4K46aUmXt?=
 =?us-ascii?Q?6W8/qRKHtYS6Pdjm9HimF+nRFeUPfHJgIRLTqCIwW6l99TetkOg9/PaYMDnP?=
 =?us-ascii?Q?zTMnfQDQe+m+7Xsw5o+1pV4OgVu4iZxjJIxx39Hw0afEZUVDSVOjnM2mdjs3?=
 =?us-ascii?Q?mRaokZNUkGIki5AE/lJTCcicRzfI1+/DTdzw+tQiQnnvTLhd1BkQBPwAzUtn?=
 =?us-ascii?Q?f7biIkods0+oJ1TXQgAI/eIBpDyaCGfEpoWLDBg6WVVG5kf7lqVQkwiiyH8j?=
 =?us-ascii?Q?jsnaHkLdc7wxizSlUaqiVc45DUUveH3VkvpSKvVHvKgbk6pBKEbOSXsZ30fh?=
 =?us-ascii?Q?qX+0r8jCsoIs1xLzE+vpxFvDPCsA8rALqo6g5sMZthHOnbRCPPIxAtAf0OhO?=
 =?us-ascii?Q?0/PDmnqE3Hrz8gBD2yNnCgEM/i0MrfZxRPG7wYML4hqykYl1n3iuw8i5J+iw?=
 =?us-ascii?Q?YSHkcaZgrwSxHFiyji9LBqqtL2rx/3Lrja6k8aLjFIZEx6WXv2p9fIW3P5la?=
 =?us-ascii?Q?ovaWIPuqXk408inIiRfbg/nrskckbFHm4TqCKeAlzqc821tnqk/LMlWeubcC?=
 =?us-ascii?Q?CKtnVqpgUlo7rMXICNZeBaIDLVWBVvEupvmegv7za0/TIGnx+GG1hljbbS1X?=
 =?us-ascii?Q?Po+BIZNDuwsLLeB45IyZEV82OjTyss6ZdIaFZBtA1IX8rhqU+eIG/3HLW51k?=
 =?us-ascii?Q?lPmo1XfDVVxo3VD/beoLGo4pN/TzP7g6WcZuNPwEfwJxEKHDUsgICuqxRReV?=
 =?us-ascii?Q?xb1twV8Zyw8pZ7XvT0JXXu22ecILpx3zOJuME/dTeqOSNPPuEj3lsfLeFjON?=
 =?us-ascii?Q?PI642P5NxThjUWoLYhrh7EmXWYIhQRz5XPyMjKLqw97+/k5cyDo15Ua8rTj1?=
 =?us-ascii?Q?PDqJasp59JFDKliP912vSS/WArX4eqfVtn9nD0zNmrac0T7daA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7PntMjlozXanM5bM97C+bNT1yjf9VEDWI36rbPJlBIok6c/PsML+QqL7xTkg?=
 =?us-ascii?Q?9xriyQlYh8PNBWtSqlIHBDAV2gduDNqtO07zmwWUqhsrkXJiaHXf5MG5Pc1H?=
 =?us-ascii?Q?BJW5gMa/8/9V3n2ItJJeYcNkZ2OBxYimMIb/ivWrfdab6ybWn/ssLovOJcb6?=
 =?us-ascii?Q?b+PqzSqeozbbaS6BZQ5U6c0RrwI9bQEDBa5c5RCXJBPQ7Fty44RoUm/BzhgX?=
 =?us-ascii?Q?gSQDLBz725QziSpNlMLaayHTmvn4U6iSOTl3kd+u8rNOKjHYlpg9qvLV+YfE?=
 =?us-ascii?Q?YouoLvgMnyc9bNMmHTyKfLjzeL7KaprfRZVnWa5GLTXl5BstnZc6ZMoKjmtw?=
 =?us-ascii?Q?NPsfSjaoYiWm5hql8SzEB+MXZMtEqhcAd3jbniuv/G3pQNb6DOI+CMqqArnO?=
 =?us-ascii?Q?DTyOtrktIvDLf5AW9sJXTF5cP4/BBc/+BG70ONMpAZlR70glyXTHr6OEhfmZ?=
 =?us-ascii?Q?gRBawP01R8KS5oBpphHRq+RTR2DtrX7Kit/9wkIxEVWUAHV0YIW+kL7jCwxR?=
 =?us-ascii?Q?Z2tvknFBZZFrUOxjQxjNQaLWjmWi76UYOkqvQ4gTL+FsXURUdq5u+0TWh/ON?=
 =?us-ascii?Q?Y097LrNniaVoxa1wLl+YIsUX3SMtqtI/0fVSBF3Ts5HuKzjGbY77oTqtOccv?=
 =?us-ascii?Q?DFQ/xEbz3BjkvoemvvC9rIxoRtfNo/sOVgQtmUnEMlXR3xfIQDwWlpeiAKhU?=
 =?us-ascii?Q?UVB5YzXXS0mXoHT7h2WyaLK9xM+0zfXds8aCr8xi9Qn/6ZlFk2cIt5mC08pj?=
 =?us-ascii?Q?rijaKWCQfKqPobxwTsw8kaF6o9FEHaRnLymnAcEUY+TcK+Yfz6CSnxxLb84F?=
 =?us-ascii?Q?5jjv2aDsvbtKa3YM6ZDtp/CwOqgJipFLA0zVFtUYIwWeqJfJATmN2g/6zNuB?=
 =?us-ascii?Q?xlOP8oQ8RzWnqwi3h4rWd9XFtkaVoU9kntgUgo1fKxLwnHM6dXtK6Pnx4fxq?=
 =?us-ascii?Q?6K5f/PQM5xCuz1GP8dAuOxNkkW+HA++qOPuNr302bqh4cIJ6k886wTdsdGaN?=
 =?us-ascii?Q?VTs++E86SzwNRkUdsYB5oN5M4NaKdEXFAhFe8GOuci9ksP1OD37oIVmYXIQT?=
 =?us-ascii?Q?cJSNCFxIpzfjMbfi9ait6BBsBnr2ghjM1fl56wmFQH2pKRhzryiDzMyPq1ZF?=
 =?us-ascii?Q?Y99+8YmJJj8F3aqX1cq41b9LWJs1B/S+lo9450UL2pwrG9OlRCxaMeW0jWzg?=
 =?us-ascii?Q?SwWM5rbWlAcprydTxDxARYRdrx68NrpcYIArDrLIPV04rItc3qrtgSnBIllj?=
 =?us-ascii?Q?rYNXu3q9lfcNfxpZt+iapXnscpH0ihLXyUJO7Ddl03j/pmIpKhoilla9Zhwa?=
 =?us-ascii?Q?qEbSDFQS6J1sQutvGligw67xKPF7OKcyY/+5K6KH/gWiMrPgzI4RdXJHWND4?=
 =?us-ascii?Q?NXTU9I7mPoVrG+yQmS0F0odLZomp2+PEWA8oXE7QvASGj8n9O4XlCYbZMMu4?=
 =?us-ascii?Q?4EggZt5Lnd7XNfTi8bbWsKhHx6FqVf5YuHKmo4ILDmoQX2L3brKS+L23pDtX?=
 =?us-ascii?Q?WARxWbskOoL7F5Vn38m2QEs8ZTL4c5Ij7Muiiwn8SWphWqm7DMxL7TnVPUut?=
 =?us-ascii?Q?n1UWbxN835PBY4oQ9HjM521eOna6/GGtUn9N7Xb9CNBhHsbK//MM58p8CK31?=
 =?us-ascii?Q?2Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ae37e8-891e-49b7-d9a9-08dcc00d9441
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 05:12:53.4194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oCgK72/S43v4g558ptaNTYtpMjt+++cK05laeEFEnLbg1HHn/rD6MQ0FZKh2CGuzavwDAj3Gu7/qzLmCiFvqWPRCdgpazzkUWmLecjZ8M7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com

Hi Ying,

> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Sunday, August 18, 2024 8:17 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> ryan.roberts@arm.com; 21cnbao@gmail.com; akpm@linux-foundation.org;
> Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
>=20
> Kanchana P Sridhar <kanchana.p.sridhar@intel.com> writes:
>=20
> [snip]
>=20
> >
> > Performance Testing:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Testing of this patch-series was done with the v6.11-rc3 mainline, with=
out
> > and with this patch-series, on an Intel Sapphire Rapids server,
> > dual-socket 56 cores per socket, 4 IAA devices per socket.
> >
> > The system has 503 GiB RAM, with a 4G SSD as the backing swap device fo=
r
> > ZSWAP. Core frequency was fixed at 2500MHz.
> >
> > The vm-scalability "usemem" test was run in a cgroup whose memory.high
> > was fixed. Following a similar methodology as in Ryan Roberts'
> > "Swap-out mTHP without splitting" series [2], 70 usemem processes were
> > run, each allocating and writing 1G of memory:
> >
> >     usemem --init-time -w -O -n 70 1g
> >
> > Since I was constrained to get the 70 usemem processes to generate
> > swapout activity with the 4G SSD, I ended up using different cgroup
> > memory.high fixed limits for the experiments with 64K mTHP and 2M THP:
> >
> > 64K mTHP experiments: cgroup memory fixed at 60G
> > 2M THP experiments  : cgroup memory fixed at 55G
> >
> > The vm/sysfs stats included after the performance data provide details
> > on the swapout activity to SSD/ZSWAP.
> >
> > Other kernel configuration parameters:
> >
> >     ZSWAP Compressor  : LZ4, DEFLATE-IAA
> >     ZSWAP Allocator   : ZSMALLOC
> >     SWAP page-cluster : 2
> >
> > In the experiments where "deflate-iaa" is used as the ZSWAP compressor,
> > IAA "compression verification" is enabled. Hence each IAA compression
> > will be decompressed internally by the "iaa_crypto" driver, the crc-s
> > returned by the hardware will be compared and errors reported in case o=
f
> > mismatches. Thus "deflate-iaa" helps ensure better data integrity as
> > compared to the software compressors.
> >
> > Throughput reported by usemem and perf sys time for running the test
> > are as follows, averaged across 3 runs:
> >
> >  64KB mTHP (cgroup memory.high set to 60G):
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   ------------------------------------------------------------------
> >  |                    |                   |            |            |
> >  |Kernel              | mTHP SWAP-OUT     | Throughput | Improvement|
> >  |                    |                   |       KB/s |            |
> >  |--------------------|-------------------|------------|------------|
> >  |v6.11-rc3 mainline  | SSD               |    335,346 |   Baseline |
> >  |zswap-mTHP-Store    | ZSWAP lz4         |    271,558 |       -19% |
>=20
> zswap throughput is worse than ssd swap?  This doesn't look right.

I realize it might look that way, however, this is not an apples-to-apples =
comparison,
as explained in the latter part of my analysis (after the 2M THP data table=
s).
The primary reason for this is because of running the test under a fixed
cgroup memory limit.

In the "Before" scenario, mTHP get swapped out to SSD. However, the disk sw=
ap
usage is not accounted towards checking if the cgroup's memory limit has be=
en
exceeded. Hence there are relatively fewer swap-outs, resulting mainly from=
 the
1G allocations from each of the 70 usemem processes working with a 60G memo=
ry
limit on the parent cgroup.

However, the picture changes in the "After" scenario. mTHPs will now get st=
ored in
zswap, which is accounted for in the cgroup's memory.current and counts
towards the fixed memory limit in effect for the parent cgroup. As a result=
, when
mTHP get stored in zswap, the mTHP compressed data in the zswap zpool now
count towards the cgroup's active memory and memory limit. This is in addit=
ion
to the 1G allocations from each of the 70 processes.

As you can see, this creates more memory pressure on the cgroup, resulting =
in
more swap-outs. With lz4 as the zswap compressor, this results in lesser th=
roughput
wrt "Before".

However, with IAA as the zswap compressor, the throughout with zswap mTHP i=
s
better than "Before" because of better hardware compress latencies, which h=
andle
the higher swap-out activity without compromising on throughput.

>=20
> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |    388,154 |        16% |
> >  |------------------------------------------------------------------|
> >  |                    |                   |            |            |
> >  |Kernel              | mTHP SWAP-OUT     |   Sys time | Improvement|
> >  |                    |                   |        sec |            |
> >  |--------------------|-------------------|------------|------------|
> >  |v6.11-rc3 mainline  | SSD               |      91.37 |   Baseline |
> >  |zswap-mTHP=3DStore    | ZSWAP lz4         |     265.43 |      -191% |
> >  |zswap-mTHP-Store    | ZSWAP deflate-iaa |     235.60 |      -158% |
> >   ------------------------------------------------------------------
> >
> >   ---------------------------------------------------------------------=
--
> >  | VMSTATS, mTHP ZSWAP/SSD stats|  v6.11-rc3 |  zswap-mTHP |  zswap-
> mTHP |
> >  |                              |   mainline |       Store |       Stor=
e |
> >  |                              |            |         lz4 | deflate-ia=
a |
> >  |---------------------------------------------------------------------=
--|
> >  | pswpin                       |          0 |           0 |           =
0 |
> >  | pswpout                      |    174,432 |           0 |           =
0 |
> >  | zswpin                       |        703 |         534 |         72=
1 |
> >  | zswpout                      |      1,501 |   1,491,654 |   1,398,80=
5 |
>=20
> It appears that the number of swapped pages for zswap is much larger
> than that of SSD swap.  Why?  I guess this is why zswap throughput is
> worse.

Your observation is correct. I hope the above explanation helps as to the
reasoning behind this.

Thanks,
Kanchana

>=20
> >  |---------------------------------------------------------------------=
--|
> >  | thp_swpout                   |          0 |           0 |           =
0 |
> >  | thp_swpout_fallback          |          0 |           0 |           =
0 |
> >  | pgmajfault                   |      3,364 |       3,650 |       3,43=
1 |
> >  |---------------------------------------------------------------------=
--|
> >  | hugepages-64kB/stats/zswpout |            |      63,200 |      63,24=
4 |
> >  |---------------------------------------------------------------------=
--|
> >  | hugepages-64kB/stats/swpout  |     10,902 |           0 |           =
0 |
> >   ---------------------------------------------------------------------=
--
> >
>=20
> [snip]
>=20
> --
> Best Regards,
> Huang, Ying

