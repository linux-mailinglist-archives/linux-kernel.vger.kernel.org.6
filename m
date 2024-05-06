Return-Path: <linux-kernel+bounces-169214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628D98BC4F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561CF1C20DD6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45706BA46;
	Mon,  6 May 2024 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAhCfbCi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B68F77;
	Mon,  6 May 2024 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956510; cv=fail; b=Q9ViuwQh9166az6z3oKW3OD2nVF9zwI4I8R+pg9fKnGVICWgNJlvyw7xsQGK8/pNTVJsMpQ+lERXEXOLw+M9XnVy8K4yR2WXVLKYp6Ven5P3yIr78NmQg/9/8ksUOMzvuUe3RKgEL6onTk/tZTHr0wNqVdrB84DHVUJXQLhc9Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956510; c=relaxed/simple;
	bh=sZBMAqujJNTvAWp0c4pUeNu7/7XxC8qHZRZ7SZ7D1Pg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LFMro1CKj6xDlgEzVhx/Wb1NvAUNQ44WLtJmRgz7Xu/PZ8vDQPnWgp+cvGMzEdjlx0p1Sby9dgoy6c9ePyhWd9kdNczqT9yDf4kxtjabRVlABbw94ZmISnRqx+OzooLlJUzRY9df5jO8NnxG8iaV0DUoY6YuvXj/1dNFlY57x5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAhCfbCi; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714956508; x=1746492508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sZBMAqujJNTvAWp0c4pUeNu7/7XxC8qHZRZ7SZ7D1Pg=;
  b=iAhCfbCi9Wot45gK4+sb+CaKmwEpvvQzoJTs2vaR1sMtvn31GwN5lyou
   0JHwJeisJz5HtukyXUBLrhdu0v2JeKCgAFsKCXKvIHYXaEdIFWar9P3sM
   jhCNISbE0lEIZY3TZvd5Cdnx/qOdpAWbNj19BgZQxEN0k/+jdp2J/8VEj
   CmonB+lYIsK+CmEWwMViPsrocEYNv//MTUGduKZF6Wwr2lmdgza4zbbe5
   Idqfx825ovjnDBcz5HNymqY4tRS6suogRtAB/ZoA50Aqt1YPKAW9ri6Uw
   sGMOMWXL37Z9rMUWRgyvyzq1NiaifoJWh1ajcAXJyF3IDo6mW0Y1pbX4R
   w==;
X-CSE-ConnectionGUID: GrEbAn5cShy+ve9ZGO7DMw==
X-CSE-MsgGUID: Ua7nrYpwSGWLw7ZMH7Qg2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10612689"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10612689"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 17:48:28 -0700
X-CSE-ConnectionGUID: 2iy8jMnuRlGXBrnLawE9wQ==
X-CSE-MsgGUID: /6WWU5CsR7+MoNRcAOg8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28403201"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 May 2024 17:48:28 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 17:48:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 17:48:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 17:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4AHy6Z8s3IOBf+WBazmm9flM6MgQbh61J8rRSOevJNXw5yx7NF7s1CCbrmr2hiZhYcOvPRQq7xa8p9TkjgF1pV3g1wPUoUuQle3JZOpAmzIpIWOwt1V8aAkMrb7jzFtFBkj+xvLoBEEOviztN34pwgetqqqOnDLZpgbh0OghFTeTVB1G3lgnVbJkIuHMO6IYkr4O5Y4fJRPLufAQvu+VmyVSnEEqS8QdE7DJd6V+ceK/v0pfsgPR8gjxycDFBCY3bv7Sv6u4cMTGkgRFfpR1J19jGP/KX+RbmJ2WkSkNG76q8YS6G3oDVc3MRBWoSNFU+3oZrU2PQJoBYUBgf/LhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZBMAqujJNTvAWp0c4pUeNu7/7XxC8qHZRZ7SZ7D1Pg=;
 b=ZCeLUaXMFCbGROuGb03jILEIOQpGArzvzW3YqN0It9VjRgPaLJ6Whx6YhS/f6QvaeuTPR5Tqy7B4/MIjcvB6+EIUIY6FERtGm5aPov9prmNf0HClD0x4Epip/FPHQWZ/4+ju+vwczD4H4raIliPzODwsiZy+4G67GNe5MV7sHPXBa5Ur75upjbnggP0NulEWepdmrzYK+246UN/aoLzHniSl54GNenM/zp0uwCvRgNqHd7m/p59f+AecXR1khNfsJh4Mbep62MW1dvHTRe53vSJsE3o5vo+DnWi8JCPwSGVc++ePI1tQB50eUCdax5QIDhs8+1ZCq7QombhJUbVRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 00:48:25 +0000
Received: from CH3PR11MB8436.namprd11.prod.outlook.com
 ([fe80::c305:d8ab:d593:2580]) by CH3PR11MB8436.namprd11.prod.outlook.com
 ([fe80::c305:d8ab:d593:2580%3]) with mapi id 15.20.7519.031; Mon, 6 May 2024
 00:48:24 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH] soundwire: fix usages of device_get_named_child_node()
Thread-Topic: [PATCH] soundwire: fix usages of device_get_named_child_node()
Thread-Index: AQHamc8pPPDiMFXFXkqJ+A8o6mDxIbGHEUwAgAJWAYA=
Date: Mon, 6 May 2024 00:48:24 +0000
Message-ID: <CH3PR11MB8436BE8232EAB36C35361A00FF1C2@CH3PR11MB8436.namprd11.prod.outlook.com>
References: <20240429004935.2400191-1-yung-chuan.liao@linux.intel.com>
 <ZjYwdHKKNrQDxpKd@matsya>
In-Reply-To: <ZjYwdHKKNrQDxpKd@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8436:EE_|LV3PR11MB8767:EE_
x-ms-office365-filtering-correlation-id: f60428ee-6fdf-4f34-2fbf-08dc6d663c7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?VW5izeYted5jI4H9kNdqUMYK0RGkID7AbSTMaSDRjWDnbIzUJsN1uZ2MZphm?=
 =?us-ascii?Q?cMlUxiBOA2Fi5O+yYQ1s41m668oHHW1BKkht2VcyuJHTEG0XvsJwm4NQ1VeV?=
 =?us-ascii?Q?qPngW6GrBooiS1nQyXR+bW8NI/TjclltwM4IsnkHx87K+s/LQa6KhzpO57T3?=
 =?us-ascii?Q?VjrBQs7nSQHYr6iY1jVPNikxWlWOhu4VFgqSX2yGtbjPiyTnM9MpDeIDOsRm?=
 =?us-ascii?Q?3g8Ehqrjf6x8oiwmjaFDswyhdAalAewkCstZpDW0CmSWOLB7BKYNY76BHHrU?=
 =?us-ascii?Q?tLEOeh90OFk7Bmiw53kuQlvFhgXZYNuUbYM92XUcsaTEPVyH0aqqI4zBarrM?=
 =?us-ascii?Q?yKuHRfrzRUAgyRlQtLr75lTKlCTkVKxMHVZYFv8/X7ayIrQDmF9jC9cjMtJf?=
 =?us-ascii?Q?17FeUrG9tghvgwWQs1jZyovMt//ZJneEh+b02XmXGKE3Xu8h1tRUQJRBgcTM?=
 =?us-ascii?Q?KP4jj1t82KLcHwrC1HWHhSIslR5+yc5IGJXhSHiol+KUBwcP92TvYue8wcdB?=
 =?us-ascii?Q?3r9m44Jn/udesrlzaWXAq10qbCI32igamLVx8NPN6ddPA9tmUbVo8anxMscR?=
 =?us-ascii?Q?dU0IsRbSS8IgDkx6OUt0PLpFCQX2LdMQx5/sV0tGeJwSprd5PqoMTfX7n+Ec?=
 =?us-ascii?Q?yHtLO0bMwafW7I/BLCcD1casR8zNeoRNvClYuWQBqwn1I/8E0qxp8CMN73Mz?=
 =?us-ascii?Q?KUoNfsjNNfeUUgHyUOgNxYt+LQT6oBFYUv3i6CT3t/Ff/N7YkVIKKRjCfESN?=
 =?us-ascii?Q?9Q374DJOEGWb568/o0XYqjCJOCtZVxTAtvnjGIM6JA/a6SuAGfIrGZYSutr4?=
 =?us-ascii?Q?SBl/Glk5m/1H7cjztu8y1rfGC+IrIiQNYlRSvTDR2myYqLWSa+qTPBWZN+/b?=
 =?us-ascii?Q?ArHe8s0vaekNkBgPaaKcjCX1ykAmzyX58+t75tauz6pATIrH5447PJGrO+tX?=
 =?us-ascii?Q?bITdjetcd4NePk7kKd3WgVidwv7WqWXGea2yq0tccn/RL8N8ceD133lFKZgS?=
 =?us-ascii?Q?zdkOyH2wDzZ+4Mo9cUaiFlMbBJ8AfnQF90jjD14UqDc4nhs1FcL3K0ECW3Un?=
 =?us-ascii?Q?K+5aOb8CGMMMx1+Bte2EOYlYtVvmpDw8aroSFpvUbbRG+56IpInVlA4yJpII?=
 =?us-ascii?Q?WvTWGphzKhxW2USaleTN8oIbX7jxcy7YohfaIJ0xoL1VqL767UcCi1uXfk2Q?=
 =?us-ascii?Q?3x6INuJDW2ihkfwxIgew6MR43wmk7YOQ0CCLiNVhOt76pci/Ur29y3QqiUxJ?=
 =?us-ascii?Q?GBT4JXGx6CZlsHZ1bz52CwUDVuSLWcLR+rJHQn69NN8YfxJM+QxLAOKkctJ7?=
 =?us-ascii?Q?ThiI/wPpyLpsOBB2HgynkL6H?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8436.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PI+pr/v3sfIdn/i4c9u5N+FQbWG9tZpHD6crHwMX9yn/iftF1wQOErI+ujsP?=
 =?us-ascii?Q?9LNuL783Wnw8dpiN03p8qSIwgtvxhSzY8tv0Yvip47Jp8rJ+gLVMKPd2+tN9?=
 =?us-ascii?Q?TOIAjsR8uBNwVsJx7FRfIPosslZ3kEkNbP7NRQa4brKPuR03oObkNu0UN25q?=
 =?us-ascii?Q?l8LCM+qx2kwfK/W/fVzZdCTTWAp5gCRR9hZoK99ZxqzJQmZtnwdSggmHz0GS?=
 =?us-ascii?Q?A7+tPk4+mN5BX1IntJCswxziyaI0MVzsoLu/ME+fu9jGcPXChlDTUMgHZ76R?=
 =?us-ascii?Q?xXYU1xLHHBTcMBMORyqhxkMRfp2UIrGHpsnHTw46tjMpTvHZRux+1FcYGgeY?=
 =?us-ascii?Q?BO3DQweHR0H34am4egCDJ8W8lqtvl8slocH3YQ1otKTYm53g8pohW7y3MreY?=
 =?us-ascii?Q?h7RtWyMhJq7EgWiclzEsX6n/W6FnNrBh8zsiQdE1e/NlnktYLfeCh5JoHSrT?=
 =?us-ascii?Q?ION9Q0CEID8mHBg6HBAZ8YUYaRXNnSH4OqICYjzhAXTWah+oy5qSaB+/ptP2?=
 =?us-ascii?Q?ihBt4HguqyZ+aSdEFrgmWxRcztTCXA7ojxlp1LLmI7ThTg7U2JLt9xr/XAyY?=
 =?us-ascii?Q?EuqiCGin20bUd6P3Tficwf9YUMuRbPwRG0gVildOr81eiRs5ZHWbqB4kYgVa?=
 =?us-ascii?Q?1bQjNsEHF5rzIzbb7kSw3PTcgwou+6Bk8fGTD0l3lmAE9BF85BCXNR/DC1T5?=
 =?us-ascii?Q?h9UgENjOWcd65mPC/6NiEdsa4BuKvr//1wiyCdJEbtftoRprDpXun0KUsY3k?=
 =?us-ascii?Q?He18irNDe1pBbHU6T1xEV5sFTvI2SsvZptuRFcTlUrLbePno/MFvH75OfcoE?=
 =?us-ascii?Q?Ly65YMcsJIu4TcNV54IxFzNafbt0IHymud5GgSsYBzrlEKwxU6NDgVt7rXos?=
 =?us-ascii?Q?NMR5l805wpnRIYQ2YJsObehDcXeduI14UixOkGCmVyYwYhXW3QpXKf69tCSQ?=
 =?us-ascii?Q?DdOfAYWLQN5hb6Txi/Aa0Lv6dliFoH9krMO6lxqvB0vRFhxWTXksQmtJWwzh?=
 =?us-ascii?Q?rSIXFiKDEfBswVRhFfhKP/ZiY+wwb3LvARnR/IPxToUWD94vTXyVAOenckuA?=
 =?us-ascii?Q?vreIXHLidxcTXRtQ4f2kvl6DvCArfv6ov1p3aBC5g/E6MTd6TyHhMgAxjHWE?=
 =?us-ascii?Q?IFUvqDauMqw86Bl7K2kkmv5BXRhtiZouBREy4HWJF0wne2R0lH3ubN3z0Mvi?=
 =?us-ascii?Q?bSbY+7eP0oZrqvXkaGCxXfpolJG9Oml5czkvZgiWu7u7fq1Zr8G9TY2OIju5?=
 =?us-ascii?Q?4L0BZUeg0/E+Vnj2ve60jXQYgYhFacuewh1qaqaPEy7BmCsbpWqviFZT17Hi?=
 =?us-ascii?Q?kQo5IlaYIdy563HdoiGHFYyU+Z8yvJlWnTRBV7qJyyjYzIABqvyEk4wEQp3B?=
 =?us-ascii?Q?APJ/v9diOCV8nIPvnN1JBrP/GTrxEAC2Lup3s3nKrOHjyDJGFCwW8OdIrvRY?=
 =?us-ascii?Q?Xs9Ci0jam8Ethlda5Lxnp/Ql437jf0yvp92/+gE2Iynv1IkXm5Omrb6/gpAo?=
 =?us-ascii?Q?sG+k2I5uMaSjeRjgL+i8pPoDNys4PbSUf9BNZg6ZljjK1G+1n93kNR1iqyr1?=
 =?us-ascii?Q?8rVfqwus6WCMab43r8A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8436.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60428ee-6fdf-4f34-2fbf-08dc6d663c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 00:48:24.8188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AM6txku4+zOLmwbNxc0XghsWPojrSL15Xk7dAOuAczlXLWQ79ucl+m+EiEjLoB0SfqiLvkfBasBYC0KvILWEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Saturday, May 4, 2024 8:56 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org; pierre-
> louis.bossart@linux.intel.com; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH] soundwire: fix usages of device_get_named_child_node=
()
>=20
> On 29-04-24, 00:49, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> >
> > The documentation for device_get_named_child_node() mentions this
> > important point:
> >
> > "
> > The caller is responsible for calling fwnode_handle_put() on the
> > returned fwnode pointer.
> > "
> >
> > Add fwnode_handle_put() to avoid leaked references.
>=20
> This fails on sdw/next for me

Sorry I didn't realize this patch depends on" SoundWire: intel_ace2x:
read DOAIS and DODS from _DSD properties."
Could you please try again now?
Sorry about that.

>=20
> --
> ~Vinod

