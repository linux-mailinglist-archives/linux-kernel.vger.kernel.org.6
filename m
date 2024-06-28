Return-Path: <linux-kernel+bounces-233241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16691B4B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1041283F21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918D12B72;
	Fri, 28 Jun 2024 01:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIhNTBTL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525817C66
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538779; cv=fail; b=OvJfkZC+krQM49TqcyQu1h5clxRFnDt6kHOiCsXUT6MmWOlmnPHuoM5McnvIaOOhZNNou0hLXPQgJP4ugNoWd3hORYOASFgtOTeh79gqJ8mqHKeE1B5UjIBZlPExD+FQlU3zPqBek+M80afYOVYH7rmadfMKReMThKPfFZdzAW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538779; c=relaxed/simple;
	bh=vIJh6w4REwNaF2qAwldW71AS0Ozqdqh2mOcm5jYDvfw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BrVWsJU8RrxIfNj0CNQRPPpUGtXt880LNHTIHVgvwTfsn5GdhUOQHyGY64Ak3mzuKKFrIceZC1ORqu+dK5AVdn3gDT/pIG6a5iN60tAj6HQMKR72HF9FEjLcS7LZD0cL7MgAnFDhPp2cyJ1xDAGPxUgIMj3q8BxxJoH8LH9pExo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIhNTBTL; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719538776; x=1751074776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vIJh6w4REwNaF2qAwldW71AS0Ozqdqh2mOcm5jYDvfw=;
  b=QIhNTBTLPL3nSZEcmDJgFKduNZBczP/06oWek7TspCw/sPPW5vNMl0yF
   5plj/LJJXHS/QAjW28GQ/upaSXEB76bggAB4hpWDBs9aLV0waX6B6x2E8
   en8ZR3lP9EcLAsonJZxQQ8O0c5TKNm6pLE9+Q0B/VTeyBtsnNrgrXTVeP
   1RJLH49lH56dDJUeR4wMqe2twYReoDCmAZHEH26+CKTvF8YkrhREcw54e
   IsI6LYvQnKV/qwJsZi7EsHkH9w4BbXACbagTZfZ/2Wz5AodcCk0/jUdNh
   mH9aZ1jhbIQEZD4q5WAwLhuJZ1d20/Rpa2Pe9IVp8sTyCOZYVZ7Cibv0R
   A==;
X-CSE-ConnectionGUID: 6Rrodae9TtaU1LxcPPaoxg==
X-CSE-MsgGUID: aDcemzr6S6CVG654w3fPPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27327439"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="27327439"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 18:39:36 -0700
X-CSE-ConnectionGUID: ttU21s+6SlGd72+RFnIt+g==
X-CSE-MsgGUID: 4PkdllDUSMm2t2m0Qkw6Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44673732"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 18:39:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 18:39:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 18:39:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 18:39:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 18:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K094vZlYrJJ2yzsz1c2s/7m9ijHz+n0epyjrOP91OA99dL1IYFP9os4Xqp5RRg5pbmCrW87rFtrESitzpWbxrGXYu1QuUNBvxo3BL9OP4zsGa9XKVds8jv4hTqx/GFBVqfduiGgWAP+KYoFylYldPPY32rZZr4RebPXybPxkk/O59lbz0O2WiRmyXbY0FP/TwQEdFoLXNDFsCNCMkIBSmli8SPbTiLLrhK1Lq1Xg6l7KEeKdFx9a/IOklaIZ6FhTMYpuZqtVxC3tiGJJKODviesSfJxOqC1ftlagw5M5rs9IJpIVdDri0nyFXsN3Ojc+0AAQP/nRCKq4B4Je1psIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diOLp1mMyetHsGDTKZFsqQPeC/QW/0D5Ac/aszboPoc=;
 b=jSmEcLxwTnKOtCyV0pddwX407Uso+xCPcTynzixU22oCze4PFl+NsNb8OQRjtWe65vhXrHcM6sQwao1xWB4o6PRD0nI6Bq1sudN9Vmwfj4WWRLGGQBEDY9dfa2P7TldQPwfVQEsgWawyKed5OuqEiQmmNKUSmVlhh/wRm+MibKlAD0k2dP0Li7DjADZOBrjNskZXVhZ/REoMqpFrpWzKMUDY8RaBvQGiGlk/8UMfh4Ld5RoLa23ftQ0ExzkgjiZ7klxneQZ4PfSy2viCvAxSvlun2ncigXvG91++wCJfS/mKHH/3jSpGYwFoxZ+Abfx9uxgVQfwxDS9RMqBN/SukXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 01:39:32 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 01:39:32 +0000
Date: Fri, 28 Jun 2024 09:39:23 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Nachman <enachman@marvell.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: trng@760000:
 compatible:0: 'marvell,armada-8k-rng' is not one of ['ti,omap2-rng',
 'ti,omap4-rng', 'inside-secure,safexcel-eip76']
Message-ID: <Zn4US7pgj6/yuPux@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: b063e4c0-0e58-42d6-d408-08dc97132873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZoN9B+Pv+uqIrOkKGCrdRVTP16+2WIzNHYjgojYBVQ3T/yNOa7s84BV3LgZ3?=
 =?us-ascii?Q?BYI15nISE0saN1r2GqT8K0oMAovJSlkS5jkIFv7nbACaiDhF3k8tX1ynaMqN?=
 =?us-ascii?Q?8D5gLUgJVqDZG4cW/S9qoHOmwKm47HgGTtN3I8r1+t11TB4PeKEyo034NxNl?=
 =?us-ascii?Q?DWbDayzuE/3OrFUlBpiG9I0d28eMw735EUSDC9kGmljMfS5VekAdriC8XaA+?=
 =?us-ascii?Q?1YTUDxsSOiExUaM1QbD35ok2rC3yLJ8j2bk5YpkQY7LHe5Dd4MDbTR9uPxMd?=
 =?us-ascii?Q?P0lQE0PLc656TtuWxTKZn+7Pvmopn4msQZ4O82saKnLgekOdzVEsH4Vt9Sd+?=
 =?us-ascii?Q?mvGka+M/LuAA3v25F/PA/YfX9AOyK7nYTvR9PUUd27k/IViqnWZFphDxLbi9?=
 =?us-ascii?Q?rR00vkOLgEKCMRqZoTXUM8ZQvarCi8dAsE7BTo5w6RHp4MXXUih0o74TgFHu?=
 =?us-ascii?Q?DE/KIXTj7wpbazojUmR7NR7Q0TmFLlbXX8q4a6upWSxW12TbWT/25dMo+h9F?=
 =?us-ascii?Q?Hmyvdl1rgfNOPB5NxW4cZWL3BcTdUvztxZOFRkr/54kPQ0TCmKxoEWmMt1B3?=
 =?us-ascii?Q?F/mtVx1LhjqKRczC7LCgTX8cpqMtmYWJidj6/akBx47lblIn1SZK9wwwLI8i?=
 =?us-ascii?Q?8uLKffs/7r6K9goI0QVm8ZYd+NMwstn4f5WwfwCyDROXQX0tC49tY/dK4LsZ?=
 =?us-ascii?Q?55n7zmSFJlyLLVolt/OUQ/MA6hAJRd4QbAUwsSnZaG+ndqytADusIxRoUW55?=
 =?us-ascii?Q?q5hLjlplW+gnlyKG5fdBkOVvDN0JwbasHNdccQre24ulAwu4dUXWCIk4zQH+?=
 =?us-ascii?Q?s47DNPe33wYKYt2h6oJM45plA9EEFcIMcrulftCJBt04k4YswhltR0C5tAAT?=
 =?us-ascii?Q?MddYLcCS6tQRQP0rhLGmy2alYgb3JZhnu2MARHQdq6QfxclO/uXhWKni5QSM?=
 =?us-ascii?Q?gQp7Lq/+uOa6r0rZOuKnAEF3LY++m7qb1GZlBJETxX1nDHqof61Ml6eB82DK?=
 =?us-ascii?Q?GojpQA74+Kv32Eg4n7knXiobQ6o5Ce6xCRMWKPlHTGEYedjRCt4tkyrpglKg?=
 =?us-ascii?Q?WOOOIRZ3zy7Q1cE3L9ha6yPiBNZ4i9oQe0A2MhcCrHoXd1a6Z0n7TvAoA5uT?=
 =?us-ascii?Q?gxO5YC5ird0NFOz5ml7ftazPN7zZ4QEFj+51R65ALwr9+46qwuy4eWm1sFbb?=
 =?us-ascii?Q?Sr8kEnb1GQaSFa8bjX9aGMqCOKoA4ZuvFxIsTxCk/ZfZTk2/4N7a/GBTLmpN?=
 =?us-ascii?Q?J/JIgwHGHz/godDfIkb5q5NIwv+lwubR0WXBgTMrxFQ5TrfSUfAqmBZpMxt7?=
 =?us-ascii?Q?4hiFKbqQkCMERUKf0FySacvtdfwRrD+2+3DuOpRNVNISWp5v/ufCPaO9tESx?=
 =?us-ascii?Q?fESvuKg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+p2Bni/nP/BXV1OV8AE1RUe21JaneDs+7L/FZDLsJbVZak3IqsdUWaZklwku?=
 =?us-ascii?Q?g+eMYgGhGv1WJDgQHgelybTIZ+kWNA7IMAPlL9KjdKIZpTAcjnuaSwm1bQ19?=
 =?us-ascii?Q?oViW/cUYo2nPZVl+5cO+nmrwPRhTk+qGHet0w/Dn6ttNIvfnAVfnU3OLouT1?=
 =?us-ascii?Q?+IYIIgVXK4HlLPwPrw3+hEO+Wfkhpop9a6M/midnooqpD1d9yxZ0sMSYF6z0?=
 =?us-ascii?Q?nf2FAly1/DH45yyZp3ZWpUlBJuLuSCLDxkCE35kxp/zsWFoVn50wCQBCuHI4?=
 =?us-ascii?Q?RAzuPZEIgER3RyXuiJVQ76enfBveuOhyx6Of8xol31+4yCAc3YLLBeZfFcEU?=
 =?us-ascii?Q?9XHpS3s+exrrvHirXXr2rhwpAalXAbSOW8CIlmDi9u+0qtko11ivBHCo7hHE?=
 =?us-ascii?Q?5IFiEsnfU2rEQZhKJKlYyI/qCohU+vf1HpVWevwFaVT78XYFdLMl+twrV5oc?=
 =?us-ascii?Q?WQb1vbttL/yLXQoKXtkVgUwX1SzEVNxUEKLrmRYP5kRSGCO8wLy38/SOMrJA?=
 =?us-ascii?Q?Ec0Td144kP12LoJWZcv/gS0DLxWOBFMjkDOJRWHDSspPbErlTrwhwqpeHLHI?=
 =?us-ascii?Q?YujY/opII/sCAjd5zF/w6prtEwfK/96lo+p98/eoD7VraFhy+SN4v7RsAiMr?=
 =?us-ascii?Q?Oo9UdtRYJ2oIANCJ951W/RQzXj7/DBbQgQbWGDT70xfZsB4jimcU2eNEOXsl?=
 =?us-ascii?Q?1qcDSVjCc2lStMSSNNKbKglPT9nFAYGKa8DPHdEyfAJNaKIheeFwYxvx3a9/?=
 =?us-ascii?Q?k91ueKaszmRm2YE/seVgSHdgETWOWjhTAkp16EfsED0CpBGkJN4btP83xamc?=
 =?us-ascii?Q?aP0PaJq73HsO1fPLhyAXvFJ998sspOxNamelLoZA/pVty01JTFZmABBfZRTJ?=
 =?us-ascii?Q?O6Ml4538uNvjmoiXPIN1t71tohByDND5ptRF3rS4Dx93O6Dbugv/+aJM0hy2?=
 =?us-ascii?Q?8dqqOtJ6xrXw8sEcBYKl55yO5VT6CB299X3aGUkvEWaWdr5e4BeTj0Isyqmh?=
 =?us-ascii?Q?1LG79JhW4/pBNzlnIPBDv6zTbZ2Vfhaf8DWOhtsxLl1F4OBlPcM2jg8D/ZE4?=
 =?us-ascii?Q?Rk8a/isP2CrH+2GlboIObwUrh5OfekW2GnXjIYhVHXfJ7Lcdd7uavAKOpd/r?=
 =?us-ascii?Q?SqDocaAGAt5ijhyfpCg1mfwdTt/EeJ/aKpxERAEOi0cnz/xZHlEKwSJLcTgF?=
 =?us-ascii?Q?Atx19cbzZzUa7pYGxB/UwIqZKSvaxpUUsPBowOMZVcaPtGOQ9K3LZar1XXCv?=
 =?us-ascii?Q?AqK+606vyaSqfWtMjGq6LHuqNizt9GrmRpo9y1lqu7FRirB5F9K4ZC1JApf7?=
 =?us-ascii?Q?60iM004cyyEwfcjXmvwQhXZWTJgi6jCbNA+1N8L3X6Aaii5gGSDx5rtefGkU?=
 =?us-ascii?Q?Cla8Pd7M16n9P5mnTx7EKfxxAF4XyHn72zyWX/dPOSoB4wj7SFZPQ59hKY/X?=
 =?us-ascii?Q?GE1t848JQePWJTXeVLeJ9oQhFKnQ1u7duYEwjOuClbiM17mOdWyL959nQDPD?=
 =?us-ascii?Q?JdOUIq5RDiboQuDEJKVGAAy8AMYeh4+Zd6bcYyxn3sAmi3WiLu2g4sKZs9Ea?=
 =?us-ascii?Q?MhywmsBuG+wzI0NLYPUEMRJ5gYmAc/ljaaIEJvAu/8gHxHGMYRkf1H8yBC38?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b063e4c0-0e58-42d6-d408-08dc97132873
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 01:39:32.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epcUT7gNrtyzFZ2RclVDjlFPUFhkm+f8CRpLsy6BRWX+u27aPumH1vOApKDKMVwXrm7KwiopL2FdJU1oBTxKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   afcd48134c58d6af45fb3fdb648f1260b20f2326
commit: c11e7732a90c21155de8db40dbba84f043520821 arm64: dts: cn913x: add device trees for COM Express boards
date:   7 months ago
:::::: branch date: 16 hours ago
:::::: commit date: 7 months ago
config: arm64-randconfig-051-20240627 (https://download.01.org/0day-ci/archive/20240628/202406280113.H5R4jgxV-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
dtschema version: 2024.6.dev2+g3b69bad
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280113.H5R4jgxV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406280113.H5R4jgxV-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/spi@700600: failed to match any schema with compatible: ['marvell,armada-380-spi']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/spi@700680: failed to match any schema with compatible: ['marvell,armada-380-spi']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: pca953x@21: 'pinctrl-0' is a dependency of 'pinctrl-names'
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: pca9555@21: 'pinctrl-0' is a dependency of 'pinctrl-names'
   	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
>> arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: trng@760000: compatible:0: 'marvell,armada-8k-rng' is not one of ['ti,omap2-rng', 'ti,omap4-rng', 'inside-secure,safexcel-eip76']
   	from schema $id: http://devicetree.org/schemas/rng/omap_rng.yaml#
>> arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: trng@760000: compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76'] is too long
   	from schema $id: http://devicetree.org/schemas/rng/omap_rng.yaml#
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/trng@760000: failed to match any schema with compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/config-space@f2000000/crypto@800000: failed to match any schema with compatible: ['inside-secure,safexcel-eip197b']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/pcie@f2600000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/pcie@f2620000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp0/pcie@f2640000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: ap0_sd_vccq@0: 'gpios' is a required property
   	from schema $id: http://devicetree.org/schemas/regulator/gpio-regulator.yaml#
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: cp0_usb3_phy@0: '#phy-cells' is a required property
   	from schema $id: http://devicetree.org/schemas/usb/usb-nop-xceiv.yaml#
--
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: sata@540000: sata-port@0: 'anyOf' conditional failed, one must be fixed:
   	'phys' is a required property
   	'target-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/xor@6a0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/xor@6c0000: failed to match any schema with compatible: ['marvell,armada-7k-xor', 'marvell,xor-v2']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/spi@700600: failed to match any schema with compatible: ['marvell,armada-380-spi']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/spi@700680: failed to match any schema with compatible: ['marvell,armada-380-spi']
>> arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: trng@760000: compatible:0: 'marvell,armada-8k-rng' is not one of ['ti,omap2-rng', 'ti,omap4-rng', 'inside-secure,safexcel-eip76']
   	from schema $id: http://devicetree.org/schemas/rng/omap_rng.yaml#
>> arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: trng@760000: compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76'] is too long
   	from schema $id: http://devicetree.org/schemas/rng/omap_rng.yaml#
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/trng@760000: failed to match any schema with compatible: ['marvell,armada-8k-rng', 'inside-secure,safexcel-eip76']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/config-space@f4000000/crypto@800000: failed to match any schema with compatible: ['inside-secure,safexcel-eip197b']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/pcie@f4600000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/pcie@f4620000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']
   arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dtb: /cp1/pcie@f4640000: failed to match any schema with compatible: ['marvell,armada8k-pcie', 'snps,dw-pcie']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


