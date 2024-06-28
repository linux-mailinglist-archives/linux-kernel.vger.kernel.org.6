Return-Path: <linux-kernel+bounces-233239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA05591B4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DCB6283EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4161111AA;
	Fri, 28 Jun 2024 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCcJ0B3Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156311711
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538737; cv=fail; b=lNmHJ3icIADbGJb6pZXOloPfRV93uNrECGHKnCxOwIFoC+imPWFYnqgZtwon+GZIamr+FF8BBS1R5pjtReTG0Cuv3WM0P/1Ff/3Z+ZdToUnew8NicGQtN/5z+jxGt1Uzdk4edQMpZojjpuUP9gd2mho6xDY1/upn5FW7HZCZojQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538737; c=relaxed/simple;
	bh=V0f3+K6k225WnEqpL4AJygcLaa7wADYLlCMPvuBIyzc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XtCG/MtS0RnzVv24Ow447B2ggwrfujeKtbd9c8ekdoo+Mchu8qWkZCH1Uxr1l2O8fcww4QVVAqck6f4ZfZapEGPHWiKsPd4jWmRzbbYcLZBKwy0EiU3PJMq6GULWjfz1BtHzh/zRuFDJoh8MELkVnnnLF6uQ1aMpNBIFxYasUDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCcJ0B3Q; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719538732; x=1751074732;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V0f3+K6k225WnEqpL4AJygcLaa7wADYLlCMPvuBIyzc=;
  b=MCcJ0B3QC9cF3zDwe+t/1uIrEN87TiICRKGcft4ZZTfd+JVrzdPQ3jxP
   Pduse/ZVhK6BjztQWg3KwAEnlr/A+XmCAhRf20ETmMb4jLrCWHy6ydYcP
   6EAm7JJmQwnUxNSryiorYy+LZU5pNayQatDYM5JbJXH6fcQ6uh7+71ySK
   EIN7icxCJtnohIdnxFe5GKTPY3qlxIZ9VmeZsimY2n3omZZEiy5brH5fW
   I5FEUPlk0U6USYp71DXu6gi5rPXjRIu7eemg1F8tlgcQVYVSdrImaSZEb
   f/cGJjr2KPUNrsNSjYnVtxIF40rDY4W8pYqmz19ISZsID/GTKDb2lAlWU
   w==;
X-CSE-ConnectionGUID: +b7RmI48TqymSU4fqy+GFQ==
X-CSE-MsgGUID: psR+vgGWT/Wo69D5H3wVuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20469692"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="20469692"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 18:38:51 -0700
X-CSE-ConnectionGUID: kGlZtI6lRwSFim+7N2YkmQ==
X-CSE-MsgGUID: NmRIpPzXRsqWhKyIsnj74Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="45328580"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 18:38:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 18:38:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 18:38:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 18:38:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 18:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1vxBZqCKi4avYWE5424LcA3ztgAh/5g1cvLpNox/A6/GkMmAaDUIxdTt5pZ5qLXAGd5K7gOmEBsVgHMztPmRyrLuzBPgwQPiBIG8qr2oLjwECQosrDIanBt+qpybc56ISLm0ARoiaeiDtsxPaAPoks12sy6AbvjHv0k8RLl7ae6s08Ifef0f2zwcUG9i6XhFsGSFiT9N/KtFDP6rQggpXlwaYcLjhAmIKfZJkUgrbHXl8oGytYn6m6L17yCeRE9ffo3IXSwsGGcKL3/RfRFrNlBy66QatSpvEQea2iVE4q9UZNTJB+ijXv0XEl7joh8pNj+gjPCq2i+GdYRKAKPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sQIw8/4zxjKYQU8m3lSNjZU3h26yDt1T+mXvSFo/gY=;
 b=diU36R57IrnjrZupDgwqrWvU+68Jy9Qzi0AEg5Djn6W6uavs3+PpyGIZAbdyo9liGtXjJGiVQ8ZrnHyo1bW2ME3/PTbB6GGZPLDww8pSM1PBj/L/lxkrMji2QD6SoFr1D2WVLxNwvcLIPjo3XMmepPL6sNJxKybdEtaiv1+gzgjtkHZpek+aAdAzacmo4gEJNiQVk4gyhlMNOtawTGDJLgngWmkLmH8aUg/1q0e2vPWne/0xNRRs2pBe7HPt54hEznVjdBtZBaUgfbhH3p+DKbRYmgNTKMwk5oGzWedxyVD9l3VSMFjAXsE130y64wT9lNBTy3P44Qu8O+i5DwV4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 01:38:47 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 01:38:47 +0000
Date: Fri, 28 Jun 2024 09:38:38 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>
Subject: arch/arm64/boot/dts/mediatek/mt6795-evb.dtb: timer@10008000:
 compatible: 'oneOf' conditional failed, one must be fixed:
Message-ID: <Zn4UHtJXNAlTOEN6@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
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
X-MS-Office365-Filtering-Correlation-Id: 2dc6a1d7-5341-4ad8-b0ff-08dc97130d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kcp1bfHU4BKACmU27withYizYHotZi/LNonszuTyDE/gmIUUO1CroifDgyYf?=
 =?us-ascii?Q?RBvm1ekGZfTQb/n8wW//yCY0e0DYheuAQq98pMAhhTXmlJE5RfSBU1C5yVO/?=
 =?us-ascii?Q?di9tBC+Q4vMhWx3ATjjBDKgmyVDdkqp6lEBZmZY5BnA+UW115PdLoS0bQAK9?=
 =?us-ascii?Q?VmVcC7/AKNLNp6wNpzlEjAcFCOiA7qcQNMy2mKiQW0uc+1bA8Cpk1w/1jEyI?=
 =?us-ascii?Q?WnsCASztBc4F+7IP7Xiy/7tlAXrCEVEET5qhtzMBL6rNlDvnioNLuei42gRS?=
 =?us-ascii?Q?7ILZaQ/QYMoFdfvHNvQ3deApeCdL/+faVm5ltYOSiO9Ez7266bHyuXdCOzYh?=
 =?us-ascii?Q?SacdsZDI9kIz8Ars1YkXCYuJBD5+ttfQkFg+AgW+OcsnSURbssl+uw5Av08B?=
 =?us-ascii?Q?WOBaOL/xRNUXeF/wXCrc+BWp/V09av03Ts7yrUnRm4BfgqMovfjQR/t5xL3a?=
 =?us-ascii?Q?Jkn6cRyqWY8wiQMgssKQxdVxxBHqEPdyxRtPZtSIFKGN2ZyQupjWsj82w8gB?=
 =?us-ascii?Q?P6PhEza51xOEviRR536cG997URsPfKJqIOaWjpY4/+Xm3h/XEfigN1j7mZq3?=
 =?us-ascii?Q?2u3VmUIeA7LBmH9+j8hgUGOZFqsF+gzn6eSJ18xtyCfDwNNCcqQ1mQ/OEUF3?=
 =?us-ascii?Q?wItLT16OfLq177GOzLzlI7s1ABmhrbeB4vsQMeIWkedMUJWf5bV2e5rzCMzN?=
 =?us-ascii?Q?tFMXMe3PZElen4dmZ/gxjRpnnC9i/33NfMW5/9MqLaGr3uxGUy+BBnKNWN0I?=
 =?us-ascii?Q?+PBTo4LkPA6yKMLJ1iybZnxRfo8DtFQMo4e4cu2hi9wbRR74xpOhdw54kwLT?=
 =?us-ascii?Q?hpjmC9g8UG+gf9G0YJPCfK2mabRp/AsLsKgLLMO2tHmLp9PQt7uzpmQ3neca?=
 =?us-ascii?Q?nndcve7Tkd0hK6hiS7ViBP+DpW8ZOefd82179MiZVmRP6ZBsp/RtrOOPL5Qs?=
 =?us-ascii?Q?TWniUiRENRWyUEyJYlazgkIyrpGPPdE6w6KdnfjKtTardcsg1mf6/3Oj5tJY?=
 =?us-ascii?Q?KlZ0jiD4ZS6QK1JFylPNoiTPydt3lDZY8SMTFnfcLjzBSUMHzeINB5+aHYb2?=
 =?us-ascii?Q?flxIWNJTmu3Evl138n2CdrkzDrmdKcra+/lg1LYs0KlUq/HjXHkJpVRYaNfP?=
 =?us-ascii?Q?cwxCAm5sjvU8E6Au5lLiVX87QbnNh3Rc3tiySGfFnB/J28zdn1FUHZbRCmRr?=
 =?us-ascii?Q?nJZg6FBPvvFhBMD7/OrNDauRJRf+fo6xS0t6jR/P1pazUjeoVMLB5ckGNVlj?=
 =?us-ascii?Q?ki78eBOCpeaCqrRAk55kiOzWANCjluTO26iwQ8tSByL6MBm13vZN6lHnppPG?=
 =?us-ascii?Q?FDv6oKKE/Dcgjx3tLbDqTCqnxhcy+0X/AnkAiqpQ1An/x2+9fBNkA+M27MqJ?=
 =?us-ascii?Q?vcU3nnc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7WmOsGvoj50Cr1WYvUmIsAibOVfBU2eoVVQveu9U/IEVGjYym4w6Bd+BY/TP?=
 =?us-ascii?Q?Sc7x3WiazBG6vd7wPsnOuHT7NJWzeCe4eiPnL5H/+YNOQOYz62lUF3DQrPs8?=
 =?us-ascii?Q?4UtIzFuPNCj+RL/duVVOjTNxmz4klbgTC4RxmoadAYzcq96p5lAHeneBhvmW?=
 =?us-ascii?Q?jZRV8Jk/F72EvxPaJ9UfFfJeKfnkiMQOB8u8pmh+lzzGqcnxKLkzmCFuYWgr?=
 =?us-ascii?Q?1aKWwPjkInmQSR6U8oRZmG8pWj+uBGXd0L12lsIrZM6HptbVI4EF2aHxTAc2?=
 =?us-ascii?Q?ToSDymqMtb05NMYKj5ZJX645NJ0PGN8cwEIjBdNRFa//1HbZd8BnRUEqHLb3?=
 =?us-ascii?Q?gX76KUWb8x7jGncFvi4rgfpjuWYHU2mYsidHoKPpnwRT5zrz4i7TxN2Fh0vu?=
 =?us-ascii?Q?hp4yUacTWIgrtzJeoRKJOxbmFzjg2cCI1oIssBOciXsRFd67E62MVuX9XLvw?=
 =?us-ascii?Q?bMCKsTMuPyFLSvkZD8KLS9XjI1n0rua3FvHXNU56BrLpjzNFo/ckcyHOarxd?=
 =?us-ascii?Q?nWQ84Itls0rq5tueIAT4y/U7pfkMoajTvsUd4nT5hCCHj84caoy2dvUhSGJG?=
 =?us-ascii?Q?rLvKNRy3Z1O0h/t2FEk16mXiCsDYNXjDHTy8KdX75Dyn0TVNKrweF/guTCmy?=
 =?us-ascii?Q?GEbBGOklj40wnSjSbSVKX8i3reUQIhpqv/lhl33XuVGjZqNOE7SG8yeCVYyc?=
 =?us-ascii?Q?JrMTyBMiVW0ET7E1kEXaMJRHypkAoDkhqd+Km5Iku7+kZS2ZhDzR9TU8ozg8?=
 =?us-ascii?Q?PSPW+VuKVVG6cskUgolF+WDzjwn1T40faIyKnwNgg7OoseQTCmS0+D5hrWyX?=
 =?us-ascii?Q?DwDGat9c+aFYWrqISVZlcu0wH8AYIO+SpTX7OX309YFqJy5PiBHjMapOocf8?=
 =?us-ascii?Q?ai8lP5B4tQrVb1WPN3OURdBGQ87MB6JWduwuAMkHa+WIMFWA4PBzYfjZd9rf?=
 =?us-ascii?Q?6lp80W+Xuqox8xCK3IlLwAfqioQrVF7fgXWDTv7RKaO6yaYxHiKgZpDBiKyj?=
 =?us-ascii?Q?ssH7KJ9K0JswaqLvphWC9SjiCyhblJFDWwFXyS3LZcYCoFRUm1r0xAe5eOms?=
 =?us-ascii?Q?K14/Ps9yHqyTNXT0aP7oiszTxU+kU9XgWPInQXx4MlLuvEIgtjEGB116jNPy?=
 =?us-ascii?Q?qQRTGQNTCOzLi1bauL6+eCY/vWWEIwDM3SNq5ohZTNygZJeSTPhvHNNxJdb+?=
 =?us-ascii?Q?2NT48uYS8/x3aaUCVSELRcqOrn18CKwEMRCz25/e7MSkwNqVeIJaBbFoK/jg?=
 =?us-ascii?Q?p3eMS3hhkYxHlnpGA1y4AsCSte0FNupFJQLnD1i8cLGeigrcf0T1q7gCvmVo?=
 =?us-ascii?Q?Ikv37wAJXQq8ORNtkxtthg05uYkiUhDUZs8uHZldpHShAOj89b3yXgfSNHaA?=
 =?us-ascii?Q?b6AzAe1a3XsswRhewEJJNIPQ4uVm5bpdomH1js8sSXdRQflga44Fjw0xrcrD?=
 =?us-ascii?Q?YN6L45evekejCPw6Q206qjyLtO2ZBw/gTDqOSrKwBRG+2wyOKTzlNFueZx9x?=
 =?us-ascii?Q?qScux8aXPTxOUT1ZCjqtNwYaE3zSdkigmm2VYg11bSgjDV73SLmS6CgYeOft?=
 =?us-ascii?Q?1oApMvmCGM8nk6SvEwkXJV3U5a7BYQIVqawC3KSM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc6a1d7-5341-4ad8-b0ff-08dc97130d68
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 01:38:47.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8DvziDDb1Ucf5gYZJUumwiDUdN+FPn0TcJwSSFGwwlU9+DK65hDE5v6jwgz3RY0hho8+pKNQ83Y0jxokKGL7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d6444ba82053c716fb5ac83346202659023044e
commit: 5d3d723470996d3b9050a89427d9fc72cd0241e9 dt-bindings: timer: mediatek: Convert to json-schema
date:   4 months ago
:::::: branch date: 5 hours ago
:::::: commit date: 4 months ago
config: arm64-randconfig-051-20240627 (https://download.01.org/0day-ci/archive/20240628/202406280621.ek0cRhbq-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
dtschema version: 2024.6.dev2+g3b69bad
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280621.ek0cRhbq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406280621.ek0cRhbq-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/mediatek/mt6795-evb.dtb: syscon@10006000: compatible: ['syscon', 'simple-mfd'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
>> arch/arm64/boot/dts/mediatek/mt6795-evb.dtb: timer@10008000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['mediatek,mt6795-timer', 'mediatek,mt6577-timer'] is too long
   	'mediatek,mt6795-timer' is not one of ['mediatek,mt6577-timer', 'mediatek,mt6765-timer', 'mediatek,mt6795-systimer']
   	'mediatek,mt6795-timer' is not one of ['mediatek,mt2701-timer', 'mediatek,mt6580-timer', 'mediatek,mt6582-timer', 'mediatek,mt6589-timer', 'mediatek,mt7623-timer', 'mediatek,mt8127-timer', 'mediatek,mt8135-timer', 'mediatek,mt8173-timer', 'mediatek,mt8516-timer']
   	'mediatek,mt6795-timer' is not one of ['mediatek,mt7629-timer', 'mediatek,mt8183-timer', 'mediatek,mt8186-timer', 'mediatek,mt8188-timer', 'mediatek,mt8192-timer', 'mediatek,mt8195-timer', 'mediatek,mt8365-systimer']
   	'mediatek,mt6765-timer' was expected
   	from schema $id: http://devicetree.org/schemas/timer/mediatek,timer.yaml#
   arch/arm64/boot/dts/mediatek/mt6795-evb.dtb: /soc/timer@10008000: failed to match any schema with compatible: ['mediatek,mt6795-timer', 'mediatek,mt6577-timer']
   arch/arm64/boot/dts/mediatek/mt6795-evb.dtb: intpol-controller@10200620: $nodename:0: 'intpol-controller@10200620' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
   	from schema $id: http://devicetree.org/schemas/interrupt-controller/mediatek,mt6577-sysirq.yaml#
   arch/arm64/boot/dts/mediatek/mt6795-evb.dtb: iommu@10205000: 'mediatek,infracfg' is a required property
--
   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dtb: syscon@10006000: compatible: ['syscon', 'simple-mfd'] is too short
   	from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
>> arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dtb: timer@10008000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['mediatek,mt6795-timer', 'mediatek,mt6577-timer'] is too long
   	'mediatek,mt6795-timer' is not one of ['mediatek,mt6577-timer', 'mediatek,mt6765-timer', 'mediatek,mt6795-systimer']
   	'mediatek,mt6795-timer' is not one of ['mediatek,mt2701-timer', 'mediatek,mt6580-timer', 'mediatek,mt6582-timer', 'mediatek,mt6589-timer', 'mediatek,mt7623-timer', 'mediatek,mt8127-timer', 'mediatek,mt8135-timer', 'mediatek,mt8173-timer', 'mediatek,mt8516-timer']
   	'mediatek,mt6795-timer' is not one of ['mediatek,mt7629-timer', 'mediatek,mt8183-timer', 'mediatek,mt8186-timer', 'mediatek,mt8188-timer', 'mediatek,mt8192-timer', 'mediatek,mt8195-timer', 'mediatek,mt8365-systimer']
   	'mediatek,mt6765-timer' was expected
   	from schema $id: http://devicetree.org/schemas/timer/mediatek,timer.yaml#
   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dtb: /soc/timer@10008000: failed to match any schema with compatible: ['mediatek,mt6795-timer', 'mediatek,mt6577-timer']
   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dtb: pwrap@1000d000: 'mt6331' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/soc/mediatek/mediatek,pwrap.yaml#
   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dtb: /soc/pwrap@1000d000/mt6331: failed to match any schema with compatible: ['mediatek,mt6331']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


