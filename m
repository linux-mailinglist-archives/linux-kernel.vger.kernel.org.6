Return-Path: <linux-kernel+bounces-253812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F3932759
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FE91F21B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810F19AD58;
	Tue, 16 Jul 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5FrBOep"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B7199E9F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136195; cv=fail; b=OOKWXxH8D8QDQ190TX7A62FEMrtzKxt+ds4BilTbZ6gJfBAoLV+BFPyWDKNToIhMzxF9M+3cDQ+b38gYz4GCVd4p/B2Q4D1KWWUVjAi/WcmWK7UwFTFPmotW3gGIFvnz2xsBYBPS9hC/5ePrAys/ZDtQCGSFww+183ce92F6C8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136195; c=relaxed/simple;
	bh=Dj6g7UhqqhSC9tBY+h+MUdynzqXxFbW4tQipRVmOc3g=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dmVbAibFOlzxDTHCyGb9Zw5Fer+w4NgvhZvGQqMP88vc209BHIv3MU24aCNuwoigAtAzPHFE8ksGZcxeuZfy1potImTGFaFTRxLi9qWea9VAsnFbwshqRT31EBt2WRhEf0ETUlzSEkuNG9W+pfjvTm03G8of2cQUgm1rc5O9dvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5FrBOep; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721136194; x=1752672194;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dj6g7UhqqhSC9tBY+h+MUdynzqXxFbW4tQipRVmOc3g=;
  b=J5FrBOepNfCH6QAG59DEkwrvHZXnsqAhx1uUeM6kwvq/TwSJe0C/bau3
   l0k3ityF1or5eCgko82yPLsw9gLHpfVbBjgR5FLOUB3mfNE5RItZclxXF
   CtjxZJAuKFxI9gih/XGpI1Fy0pHSnOKRqxY1W4BrPGWDJWV7tk5qZE/Bc
   eyBMQHf58IvY9UNyB3rpra/hEBjgdBs25QuHqPuIN+RAqWjalXbqBP+q4
   mfni3D1j3KIsEw2L+JgCCqmH9NYUaroQuRe93yU+uUG/N/o1Ty7qdUBlz
   WsX0EcnjKBornmeE6WZS/CB2BZ6kXxi5uoSnc5yB2nd+lLTGrZBCbl4MQ
   A==;
X-CSE-ConnectionGUID: 5ErcL92lQSuXKzfoj1yZwQ==
X-CSE-MsgGUID: ASOfBNnDQXa8Eux6rMfkag==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29179053"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="29179053"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 06:23:14 -0700
X-CSE-ConnectionGUID: ddNOd6iGRA2FlIkVvcPqOA==
X-CSE-MsgGUID: +AbU9L1SQsa6V+H8QeU/LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54859371"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 06:23:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 06:23:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 06:23:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 06:23:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 06:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwXSK83OD1B+8KwxX+32oQCOZJYuJ+NU97ZH6fRsTPqP3SHq2jvEWz+C1zWxa1y7y2MDnepI2HOvKMosgIFB0qmPr29X8T3FNcL8xUewG70BWeflx2M5p7YzlnJL0EGvhhZY9kKFRHFINuTiwXsdRsAx5LnoR8Z0TalnLCr0xcZLRfy/dowiTKX/WGiTGHK6XrT6Q8A3eipDVohkxw9EfD/i5kr7TtvzqZ7LKi9ztC+OYQGjYx0VlTIrsRkTCjwVOK2f7rRWF0kPY3Gx/CtMRc7QeDTo2eUuhge6NNdEx6CBMszPFYQP9uIFplkOt+EZhmMABENuZ3Xe/fOXYDWuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdbnV6kZoJtuXzAlKMAt/yPG7WC5749+S8teHbcWSvk=;
 b=mnD4pTDpaLhzOCGrQ2kRqi4wDgVtZXXckxyXOXbXs1nxNa1rBYTolqYg8vrDF9jBmagv9wIc5v5sDrhSmCU/L1vTA2ZVChYvFH1UjOUI2r7lrY8vegdbYvSRG9U7Qn2fJB4H6qPeX+moHRQ5qo9pFESpF+oAbv3jtFeKg/UMqtNPYFVA4+T1ymvfKQPnyU7I5/tVUIcDcjGz503DewsiKrJpABLbB/fROOvHL3/Mw0EDV+9sKgmj33jKPy+mXd3Xn7q50IvASNWGR+k97ov0fr3i7ad/zZDsR+QKZyGJ7Y1gnCh+Isqzz0ghMeJkP5lUM20LWpWKJrpB7g3PsK2uJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 13:23:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 13:23:10 +0000
Date: Tue, 16 Jul 2024 21:22:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, <linux-mm@kvack.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linus:master] [fs]  2a010c4128: ltp.execve04.fail
Message-ID: <202407162117.7730986d-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ef066b-b3b9-4d2c-1521-08dca59a6fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?55ZyPHsP6Hh0uiC1AJSswPVB8fnsXNSt2N+RSYlFilVB+giwATeKRCfWr25v?=
 =?us-ascii?Q?kPkGj0S/fi/ZIvEHhxYr2gF5GoCXV1QTL+OsCJQbQiTf82OBH8VfD0xwHkHx?=
 =?us-ascii?Q?2r/CyL/zALbhORLVAEK2Zrv4En6O08u0INFoWq9IS8Ttl6PXdn2mRgP/ckls?=
 =?us-ascii?Q?V9S31CFyJSqmy4Derae2ERAckoZg69GMSvUXXG8A4aq5LMo+xB4ueVXQvqy3?=
 =?us-ascii?Q?1SAneaP/7XOWmHEd6Ao7OTbpKRdH1s82FJsn870tGhBwpbkkD7PFG0GOyX5Y?=
 =?us-ascii?Q?miayPZoQkzVsdIxPp5jC0nR5mHkA9hMCdKLiSzJBdKS62z2Nupj/kypVyPrN?=
 =?us-ascii?Q?7emRBA9ipwOVzPLe0766VjaNQJqpY6mYECzNnc2MckhaO4OWs/cEm/rAxcET?=
 =?us-ascii?Q?oR6OKsKRF/hPkbGUGZlChdGZqLdKop4CSv7VOUGXfdJoK6br1f+Dl8EepDrG?=
 =?us-ascii?Q?5Ooql4bc99/3zSrvkLtxI9K+OXGHlMjm0crSIN8uGKi0AxDCsMi1tTqYsRuh?=
 =?us-ascii?Q?A1sVJZtRfPjgFwZHrWw0Cgq3jN5Q8jkKcvhWpeGDHrMmGYJUDITUNxK+rGFw?=
 =?us-ascii?Q?Ac8qfTxnAd+4PyyTU7TUhVv6wrzk7m9qc7tJjGy+xvx0IWSdLJz9w6PTqo5x?=
 =?us-ascii?Q?UkCFtXpPFpNT4DzGfUGlpz714ps9sw6IW5pgBK0rJEqIXDyO64uZ1akEWRtV?=
 =?us-ascii?Q?MTaFS2CGr+QuXjCiLTG064yszJ6kROpnJ2hf581fCCb4iNV9OrZFdJeFoCnh?=
 =?us-ascii?Q?h+xyc+vBSCdfH8lHSYgJJwRfmQa/cVKy8cpFdyhRibUfhK4tlWufVv51YndE?=
 =?us-ascii?Q?JpDcU//TCs4pRt9OddkKqQ16t046X177JW6D8leP6xTDTw+6o91GZos4MtE+?=
 =?us-ascii?Q?lJ8LHL8x2IYj/U11N2c2dDhSI43c6reNgGcx6cxk9Dyi/3VnwsLovJwO8Xxg?=
 =?us-ascii?Q?8dcJ4dswvfB99oL6aIaXmS80LNbcDn+Ppcyb7IrWzC7zKPe0CLVg8TLgQ9TY?=
 =?us-ascii?Q?Pjp7xJ521fmmtwGMc0NegDrcGqKIYiBNx4Cfc5VN2jIGxYXSR9B1DbcUeq3o?=
 =?us-ascii?Q?WfvxYQKSUjEjJhzoxQtyAFbVLaXyRsQR3W6+nAgTO2JfR6NMwTvNm6sNA87W?=
 =?us-ascii?Q?9j0ASwJrSQB95+q7wRH5qakXc7hXlnIU6R3fIngeAmw8hp421BBywVfRqh/p?=
 =?us-ascii?Q?BJF/LS2X3Kce8cSuuG/V1p3jSo0PWeXq7YIZcCqEFC10Ts0UHlTciPMfNdSt?=
 =?us-ascii?Q?35xfvLZDJ5NqH61hGb0SJktvPpTGqLNWS32GhtD8KFDetVEF6s6FS9RwjzCR?=
 =?us-ascii?Q?4gE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pxSslu4Zhhc3HKeEc0CqISyuskqzrshZ0c/HJycBAIbodz5F7NnLrKAmNLVb?=
 =?us-ascii?Q?fv2tdJPe4PcQM+WL0YsFv68IQEZ1AhaHNgudDBpEeVFHyoJE7AEfYcnFq800?=
 =?us-ascii?Q?vd+LE549GrkS4SdJCc1XIefi9ybDu22ZLYS2E8XvMwVbgZTHM3KQSyz4Jfdk?=
 =?us-ascii?Q?t77qpYCdolQxD9hgqd3UphomrOz9Se2iOrVG2vk0UM8gUEKtuDij/xi4yH2C?=
 =?us-ascii?Q?51RGNkDP40h94QDj6zXGo81emWYdRHic8KxqL+f0X/0ViZrQtZAfdw9xiJOE?=
 =?us-ascii?Q?yBpsob9kLZPKr5aQZPerApacThG4uF80k+dt+U/L0qlUB6eHlPl6IAQQP5lP?=
 =?us-ascii?Q?7rWBs6aWJ5v1U5RDqk7ufEclWqrLWTtckpbZLHQZXtF0rVg862VHWPbrTZur?=
 =?us-ascii?Q?l6ovi0c80LpNywTXB66d//2r9lOuCXPDlmh7zR5Fb9Z+qMGM8PqwkTelYC7o?=
 =?us-ascii?Q?XNpE45Uvih8aOwM1EjVLCr83/P5cLMV7xUX1E3iO55yE8nT1kcPtbjNdolF0?=
 =?us-ascii?Q?g1Ler979XfqSJCf38YpXS4IHVy5xJZ+oBCB56PpnmP5LyhCS017pYhKHiaaw?=
 =?us-ascii?Q?xicBpI8rUybpK4Zb5rl13WtbcXCtBZxaCHMIhLU0VNmqRUQIVoALMQn6Z0Xg?=
 =?us-ascii?Q?tC4AaLQ+tNwiAqf5cGkNs8Kv2bYweft/1hIVx0eqmJSppX+zLRut+Svx1RbT?=
 =?us-ascii?Q?azkuGOr3FhUGCfLwjQG/J2KwTqOD0cEl6dIRMHJWkbs7nC676rVKah8sC9br?=
 =?us-ascii?Q?4uoALIi4W8GiFX/E8YhtOJf9ZUpP1XH01DNpLrrvoaGhm8fOKpnM5xRXAh9d?=
 =?us-ascii?Q?cqZV+DeFkaQQxMcT6jXJbgOe2SpCEOOmZbbGo5zluptj2pV4oXFVCibMh+zH?=
 =?us-ascii?Q?qwNLIAkuh20UelBShylWXYMaGK70X/8G3j9oJs3JsroVh8xSN/c3sjzUVII8?=
 =?us-ascii?Q?ZcUd74QnkSxIGAZ8FAc5cxSf9s9+3lXXGw90bk0cqsFTk8j9I/5MtbnBtR1z?=
 =?us-ascii?Q?J4LpOvGuHF1BXwk2BTmBCslXwo75aHSATAV/46xJTOrK/Z0FSUSjT9P3PGzw?=
 =?us-ascii?Q?7XrDQKaj6pRFJjWtSmcZWVHJVF6tQut7aSXFyLNMlbqQE8onvQwqVG0xK7vG?=
 =?us-ascii?Q?BdZkIi7hkm66BSlJgI5rDUvgpurxMVjgy8UiEn9n45fSLe5Avf7aMMslrIKV?=
 =?us-ascii?Q?R4XoyVlJuqHcu9C12eOUmKOq9FuPmrRMEc2qF9zsQeYirC6SDGiF2OVARcgK?=
 =?us-ascii?Q?jBjHp+UgWhCutfKuN1EI+9dKd5X4vr4sWxx+5X7ahPMI70JTpVBe6Cbp4GMC?=
 =?us-ascii?Q?y0qsJ8Tbvbwoa1/Gw6Zc1e8dt1Z7ZxK6DRX983ZBKKOukG7ebrVVUBujux+e?=
 =?us-ascii?Q?Twzp5ZJSSYMPUfUjFm/1isdKqhXDlWf27OPk2KOkxG5T8gax9WPyBh90nmPj?=
 =?us-ascii?Q?nHH/bot/bODVjFvXN8fV0dqtck7T6OX83MYnr18B7/JLXT4J6OIcSPWtgrmS?=
 =?us-ascii?Q?HzPsRV0GDHwKNQAPoO7PhN5PMyec03ON3/1sjdbiyIFKDUilCnG0+ugbxDPT?=
 =?us-ascii?Q?5f1YXbZLQ1UA31ig/f4UEOU5F4ywE8bhqpY635uswqfrnycIwvwDWjLkLG1C?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ef066b-b3b9-4d2c-1521-08dca59a6fe5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:23:10.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFznl/ebzdRJlwAzGfEYaxXZgByNRaxlZVlAq8I5KNFt6bLuBqy/Kpunx0IBuTNJHL/9zXm9QPljPLZ8OmQ89w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.execve04.fail" on:

commit: 2a010c41285345da60cece35575b4e0af7e7bf44 ("fs: don't block i_writecount during exec")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      d67978318827d06f1c0fa4c31343a279e9df6fde]
[test failed on linux-next/master 4f40be61af99a67d5580c1448acd9b74c0376389]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240706
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-05/execve04



compiler: gcc-13
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407162117.7730986d-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=execve04 stime=1721093644
cmdline="execve04"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1803: TINFO: LTP version: 20240524-71-g361f6ad13
tst_test.c:1647: TINFO: Timeout per run is 0h 02m 30s
execve_child.c:27: TFAIL: execve_child shouldn't be executed
tst_test.c:1695: TINFO: Killed the leftover descendant processes

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=6
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-71-g361f6ad13

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-71-g361f6ad13
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240716/202407162117.7730986d-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


