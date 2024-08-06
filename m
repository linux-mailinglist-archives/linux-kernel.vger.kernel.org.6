Return-Path: <linux-kernel+bounces-276935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C6D949A30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75C71F262A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD5175D23;
	Tue,  6 Aug 2024 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDie34T0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9C17165E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979740; cv=fail; b=q6OMneqZs41rU0jZKzJxxKlhsHIVLTioq7ghJxxNT+5/KtY9ooV2vOV4auneSYgjbToUz2trsZwj/EJE/KSK9dxVME8aTeq97ni4wXXv0PdvY3tlyCuZs53/ihAwFRBex/kKF3onY0J5Q/wOdDZBskeNHuPwo/jByo5ThZXSinc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979740; c=relaxed/simple;
	bh=IAl2nlZE2O1gh2DMloMcFXzOHObNFiD0zPmxMLr/VbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FFsjPPazjkJkba9m0CCwBV+G6veRONPjrC+UwvS2zyLM7o+MWtqo6Lx8a4GY6PdquTSqfJhvslwDzU0iAxXlMZnhTjdEUbdgNiPo+ZthmqWyWj7VmWS5yW6GMprpQHmgok1J6rwRx/J0L5mRFAeoYv6W+/QeLzxd2WtXvZkx8Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDie34T0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722979738; x=1754515738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IAl2nlZE2O1gh2DMloMcFXzOHObNFiD0zPmxMLr/VbY=;
  b=XDie34T0NB4VRb4RmEfW+G+2FPnxwewZUytLERnI74NrIMi/NJhxG2m1
   rNlffzZFN1Vr1DDx+aYic7tXZ+GKTITyt9HFeo4NPridqmriP4KfjKz7o
   L3UG2MC4kl0Tzipig1Dh1+qI3hXh06YmFqp2t4skUNeCTNeXU3OiC7Utp
   AU8EgwGD4NUi+7QzQacei15giAtMJN2bRmtllS5k7/rs0LlIhJyXnjssc
   Jyoi5fdgBAJA3bpUf6cSApIfuEFNbYTIaiS/OAp4FRZVkr2EFQZSMUhs1
   CwLZYwYRtHandsDb5k8Ys15HczTSwDJ43Zk8+ou7wAxfiuQR1ttOqVk4x
   A==;
X-CSE-ConnectionGUID: p8ZyU8oNRyaX8ISWtfUjfA==
X-CSE-MsgGUID: O1Nk5TpiQOaSOawZEVPHZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32429206"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32429206"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 14:28:57 -0700
X-CSE-ConnectionGUID: QLxEMZ7rT+OMOn8LkNjx/g==
X-CSE-MsgGUID: 55XtNC04TECT+Ko3zbzMWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="87306689"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 14:28:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 14:28:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 14:28:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 14:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foIalUR6mdKZFk9TwHFvFS99xKpUU8wvgZR9r8Ku4Ids4yKTvjEBr6k2op89PbdjMEC5T9sh4Ln3sA+OoyCRo56386DGAvrLUmFNMEEzIO0QyIqYAwviqvv74LIPuTqJ0eqg1sibA/7TF//v91nXPm7+Wev0qZ8uYki/uoH0TmtvHor+oPWGJog9iL/81OiA6byDwvFw1VzmbVYwobBNJpRMksGD/JZe7MOc93ZpMVXfTvuZCYEwT50T7wa4vTx7DgxKo7YFyOKIb1f5siRO73ayyKJ2rO9Sn3jn/a24KVmJd2EXdduC9+SD69SIrP/VDeq8veKs4JjRsQL7n02N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYS9ffU3wfX5TeUtKbtEDpaboxY8NmLn+TCszfgg1rI=;
 b=y7xGQ9um9m1vOAVZoEXvPeKHBvn3U1NbSh2sz6qFnwMDBqnaWaj36DC/BFdqV0Vi1cm3sbTOYVjTra/KNN6FfPgIk3x51tKY6nLOsz0eMASuZF4+ojl1YVG4SGjQT9pcQBCj5AwNpp8XzHNc2XVa+0U1A/RcM+bw6I/6DUq5zyAoaE54VOiFoXwP/sHtEXS/QHvSD1hCEUhN3eYhUo918NvgZ0eJsciJhXtEIUQBZUF4+VvDTAI7U2jvYr9U8KBKhvpAij+WLpOaM9bCmm1e/WbKVSzN8OThw+r/Tk6NHoZVdlK3D+mvkqIvSE9er6rG7U8Ox1UPh37MKbkhfteORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 21:28:54 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 21:28:54 +0000
From: "King, Colin" <colin.king@intel.com>
To: lkp <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Masahiro
 Yamada" <masahiroy@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, "Linux
 Memory Management List" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] md/raid6 algorithms: scale test duration for speedier
 boots
Thread-Topic: [PATCH] md/raid6 algorithms: scale test duration for speedier
 boots
Thread-Index: AQHa51oYbsloL5/3/kCDJAa7Abyd5bIZm80AgAEjgMA=
Date: Tue, 6 Aug 2024 21:28:54 +0000
Message-ID: <CY8PR11MB774743159DA70F6BF601FF0F8DBF2@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20240805170816.6025-1-colin.king@intel.com>
 <202408061134.O5o8RpVV-lkp@intel.com>
In-Reply-To: <202408061134.O5o8RpVV-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|CH3PR11MB8518:EE_
x-ms-office365-filtering-correlation-id: 40ec30f7-ae6c-437c-3655-08dcb65ec61d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Q3/CY62QLcQxRlqmI9nI/mSTwHJ8/H4gtQm4atRf6805fyTu3F+z6Tq93cQn?=
 =?us-ascii?Q?QJ9TbEXEnrkKdxFjaCLuDxRovRLtx6iQvcLFvQWoePzLh9AAauEKFQLKc4NA?=
 =?us-ascii?Q?WdwwYgfvAUI4QTSsyVWtIUOvwBUrJEImk3X+nvHl+Ty3Q3RjZg5D0b3KCY32?=
 =?us-ascii?Q?ACggNzJ+2cQEBB0qpZYWqx7fAWhQoivlU+8Y1ylDa8nfDNpce/6nBe2myqCL?=
 =?us-ascii?Q?W1XTsQXFlyoa6RNQ/Cl99Ei8q/0n2QHcb3QmW4nf+kAXGZYn8nPu9ni8R/lb?=
 =?us-ascii?Q?lfQ9LD9yHBYkW+1jgVRVjsJifrnyKdK2hPtpcdMSQCAp/wfPJMCn/ppidW3M?=
 =?us-ascii?Q?Oo+IoH1e3xr04kYczv2dUAY7FS3o1lz66P2OXwXBPsQjBr2w3sO0xA1HJBXt?=
 =?us-ascii?Q?5oHL+fJE+IODWa42WVsBSNmd4v9+H/cEG850tVHykjF2+fruKm1m1adRpWZI?=
 =?us-ascii?Q?gJuI6sh7sI3ahnRDKUmuqCSiUAWTJMIvDMe73aaeBJxDmOqyPZn30mM2wIFv?=
 =?us-ascii?Q?c6THGSP7FHgDP6EX6qb2XVmI6IVTQ65wa+EehnWawgZ8ShUsMkcA77qwFmM3?=
 =?us-ascii?Q?r+Rp7tpL0rxAbZcHnrnMWLJXmdgSmoQEl/G9xs1OQndw8HdjWevcbnAZyAN+?=
 =?us-ascii?Q?RlAXmzrqKfZ2mDpnJMLPRJTlpwVMPa9toDgXFmt4JjhodisXCi8YBOMjvV9A?=
 =?us-ascii?Q?7uCu84eLvs8L81UzpNmHKCCBKOlwo5bMgdwH7kdLVhvdj5zdvNkUKtB1bPYV?=
 =?us-ascii?Q?LJdBDo29uUybh8d4cc3/y5CwlAjnjweQppBQFdzo0KeuK9U6R6tKq9Zftk98?=
 =?us-ascii?Q?Vb3R3R0Ka4JytKuuJJaALOWwxUPgrywvLi3r7FyhCf9M8eF/kat8rMAN79Y3?=
 =?us-ascii?Q?AHW1nMuoDX9SvBkGXW2R7ttKaHPvhr9iqYyG89rULyP7jeC06t+xY/6yW+Ug?=
 =?us-ascii?Q?aOLD3wTJr8/C5KjQlT5Aj1CMVl+atgsZRRBkcE6jrjp5Tj9qs90XzmXMdPmC?=
 =?us-ascii?Q?ULhgd/SlB5QJXkxXvZViHcNTgbFA9usNC2vs0Iwk3g0OZzjKKSB1/okFwI5N?=
 =?us-ascii?Q?IsuHCKXRGIC+BBBEPWVL6v1NjXiSsRB3+rw7Mdk02wWbZL72dgQbtl5UIxSc?=
 =?us-ascii?Q?i5B2zpXSQQ3dId5zDj32L8Mcpr4Ztkoo6PzlvZbDGNNQYCVetg45sK8JLpUH?=
 =?us-ascii?Q?IwGmp7NFrMFMqsAiCHML0xzUrVZDt1vlsxZ5JW7JwD9l2l+rvVvUEUsbho8y?=
 =?us-ascii?Q?sBy+avDQntNNFrq2+9c3OiiNNtZCLk1i4pqpfggVRLqsZysanVfEJdwx6mr2?=
 =?us-ascii?Q?A6AQTgjK8BmP1kROmqWGLh5uYTFw3/bGUGRDbie7GLFXaq2mhpOfsRX9HRYa?=
 =?us-ascii?Q?qdNPyUI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S7avmn8NvmR6dBZ+3wE9kQS21q0KNmrM5S2mysbfEpahzDHQHfN3HHfTqu+0?=
 =?us-ascii?Q?2EZSsyiNd7M41CGYoAO7Mg6Gg68fof6FWeoBIAn1mr9NfOS+wr0MyiPHkC/5?=
 =?us-ascii?Q?XBID3gecUFHfybAK2VpAsXP70MrcfydLnRUPAwcAnrXJPqh6J3ywwC1PdcCp?=
 =?us-ascii?Q?+GbCLsovazT25fPoAf1dm2Upn+tvkxlbJSXzaV52tZvRnFbKdd5C92tOxwFO?=
 =?us-ascii?Q?LAKMV55S3hyZBFDXk26nJEJoC5MpBQi4vVyu3j0f9lF4KQA79r2HrWMR+zww?=
 =?us-ascii?Q?4AOtHZomBr+WepEWLxQQPuDPYD/9xw9gQj3H+ZzMO1y9eHBaGf8VYyR39kfJ?=
 =?us-ascii?Q?4eCEWjjAWiDeKbMcWS0yZ8KPfDFpp4uap374pRTwXklLKco6x5nTFMZgSfqh?=
 =?us-ascii?Q?l8n32iGq6tUSGudv0FMnOE/K+LyihhkSR8bMJVevMbawBSxHjHZBSV4CV25N?=
 =?us-ascii?Q?Q2OC3F2G9eXTxjSZo7B4fvjPzNroxoL/1GTYAokl0jb2IUcKI1z64YfObp6g?=
 =?us-ascii?Q?djqL/ukfGm5EdXZkgIGA7NWyDwXpE9dybMb1I4vRuPRTooWTCKavFBeNoQbH?=
 =?us-ascii?Q?djJl0eViQLfmepgw0bY/ZOQ6E9lvAcaKUS6mTsdN0jhB6SLdFxzvoWPM2HGW?=
 =?us-ascii?Q?P9bwzWwwCsp+Jdp9B2yUUCaq5BgIeESh4b8FgZYpjyDwEIXc8vCZzcWM/HzA?=
 =?us-ascii?Q?ovj1TuF5XaC/891+FxfnzkchtUmdDhvY0MwbQ4f7mnFd6mP/eIcDDkhrld31?=
 =?us-ascii?Q?Zvp/0O6NUGtosFhxHzR6ZRjhGleixtW7aME9ZxI2gNf9+dEOy7828zN/3PjD?=
 =?us-ascii?Q?OaZusmDgrSvu5FtuBG0OaLT5Sg4mdweguUNFHk6vKAaS5tKBTHMFnFx4Iy7q?=
 =?us-ascii?Q?3M1R/d8w2vtpgyd9qD8tszwnxl0wI4JdfNWXQvNMCEq8BsP5zF1WLuxF7oby?=
 =?us-ascii?Q?w36B3+W+l9hHc0OLfZ72XXjgpWURAGItT+uMfJUbT/1qOqIbg24hbqHi5b3K?=
 =?us-ascii?Q?r/2CrEY/wAOZZ7SRyiROt7jRh6QYhjLFQZg/eHjYE8Getvz886Z1c5Mb8mcv?=
 =?us-ascii?Q?X8BQT4i/2BJprdHjRt21vXM9f8p2jbwKVLv1GQlH19FexstoMkKAgZ9NEgn0?=
 =?us-ascii?Q?wTV6duV7MYpj6r+9sWa2YrIyQLa/pi1AWBinBBOjqBEy0VLypxkj7gObt1Ft?=
 =?us-ascii?Q?5uSgAJ2WRSbqpacBnr0EfvEFKaW3hYSw+LBaUIcF5zooTeHvlTpkLzJZmjvA?=
 =?us-ascii?Q?of1ZR567IUVC+pL3HrwNQq4o4ujBrxn3AJIG5XKys8y+0pX+Jgf5hbbTs1Th?=
 =?us-ascii?Q?JpxPJSDneVY3x3iwSvatumBHxpUmbVmBA8UB8jxZIbMaJJ3Q0o8d0XAuRu5o?=
 =?us-ascii?Q?imYOD/+62XjUaqmZCtLlqaFKABmYhsludsC3q2vFWjfJq3rh9nIdp8A+34ri?=
 =?us-ascii?Q?8Bzy5XBASWGUaDfF0vuF8H6k0p+xrJOqq2rpeMjTekL7fgW3RvgKV58ayS6q?=
 =?us-ascii?Q?AU8N7mzPGj9DHvgle8Z/xxxetoIfnSw9uvtGImVyhj16txRHG+vPyqjcnTr5?=
 =?us-ascii?Q?0UpvSwgFIQlaNbZydf3AyZPCekU2E4n4whmvWa2z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ec30f7-ae6c-437c-3655-08dcb65ec61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 21:28:54.6215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCb99DXOFjHvmrIWKPyQxs1WbxPzxtgsPVnMt0PMpFveiCxr1LZQtWVKnItJ+ilOixhCTsYE7jnFj31IXdUITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
X-OriginatorOrg: intel.com

Hi,

Two issues with the patch, firstly the 64 bit divisions should be using div=
64_u64() and also on i386 testing in a VM the selection of the raid6 avx2* =
algorithm is sometimes incorrect because of a difference in benchmark speed=
 rates on avx2x2 and avx2x1 - so I think this patch needs to be reverted/re=
moved for now until I can figure out why it's not fully stable.


Colin

-----Original Message-----
From: lkp <lkp@intel.com>=20
Sent: Tuesday, August 6, 2024 5:01 AM
To: King, Colin <colin.king@intel.com>; Andrew Morton <akpm@linux-foundatio=
n.org>; Masahiro Yamada <masahiroy@kernel.org>; rppt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev; Linux Memory Management List <linux-mm@k=
vack.org>; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md/raid6 algorithms: scale test duration for speedier =
boots

Hi Colin,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable] [also build test ERROR=
 on akpm-mm/mm-everything linus/master v6.11-rc2 next-20240805] [If your pa=
tch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in http=
s://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/md-ra=
id6-algorithms-scale-test-duration-for-speedier-boots/20240806-012444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonm=
m-unstable
patch link:    https://lore.kernel.org/r/20240805170816.6025-1-colin.king%4=
0intel.com
patch subject: [PATCH] md/raid6 algorithms: scale test duration for speedie=
r boots
config: i386-buildonly-randconfig-002-20240806 (https://download.01.org/0da=
y-ci/archive/20240806/202408061134.O5o8RpVV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0 reproduce (this is a W=3D1 build=
): (https://download.01.org/0day-ci/archive/20240806/202408061134.O5o8RpVV-=
lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes:=20
| https://lore.kernel.org/oe-kbuild-all/202408061134.O5o8RpVV-lkp@intel.
| com/

All errors (new ones prefixed by >>):

   ld: lib/raid6/algos.o: in function `raid6_choose_gen.constprop.0':
>> algos.c:(.text+0xe6): undefined reference to `__udivdi3'
>> ld: algos.c:(.text+0x163): undefined reference to `__udivdi3'
   ld: algos.c:(.text+0x1fd): undefined reference to `__udivdi3'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

