Return-Path: <linux-kernel+bounces-198720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 918418D7C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BD81C21E67
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9587A4AEEA;
	Mon,  3 Jun 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gy4BFV83"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D44437D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400231; cv=fail; b=OZNTCZOukFFkzyVEVDt+akt8VGMBHIroz4IHt+W9wjX6TJ4+e2H3JaGNeesPHXTsd0v93V3Kh59LU2VDoGp3Py2jtNYQ1n0mHiCkkkpKyLA1lSQwwLn9jqkaHKO49g10o/wQ2MEob1Lo3pp2GV2/iylTWN3zUq6qKgmzfGRFeUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400231; c=relaxed/simple;
	bh=jlFuK7KJPcFAfup8Ae5NKs5BM0orCgizFRT56aYJKBg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=by7w2q8NE9mrABvmxJ5wGGSxOwF/cjIHCrTgrtUcsjoQRHsEEZSQGiJX5rvzEcaeCLomVNak24dVvizQ5NQtqecCy+C6s9wC1tEr2NldPTj7WKVZuzyWUaYDqUyzqd/14na1/GDBFruaeMpT1Dz50rF2hFE39xqLX5RIq8yLJNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gy4BFV83; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717400229; x=1748936229;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jlFuK7KJPcFAfup8Ae5NKs5BM0orCgizFRT56aYJKBg=;
  b=gy4BFV83MLsIn8bueIX0HwUOrYR1APIE1/PjFVmJHgbAoI8x4b+pOc6M
   UtVj//NyxJSWEmC0xY+pzR8CtFoUpJxcZy8y4VhGfDSREAdIVc913z6PW
   jN5+9GSHxvQSpMj4dkXRXBcXra8eBWZwhaS8oEgeADaXLVJc6VzEeoTQZ
   RvOQRKkGqjbWjkavdOFXiJyZrJQG47oUZGVKJHJVYDa1WkS3NaEEzaFLO
   95XAZI5URlRe/cvnoofhOgrNPfEpglBT0FWm+w1ZIfqpGjD7OopE/IMYb
   cyXXYAq26jFGp0cWRCM50/rSbXb3nLlyJfvvAGsgT8czScLbm0pDdiJjE
   A==;
X-CSE-ConnectionGUID: EsXRL+5/QSmJe8zkte1nfQ==
X-CSE-MsgGUID: 0lErqKm2TsOhLiVNJLzUqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14001927"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="14001927"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:37:08 -0700
X-CSE-ConnectionGUID: ehCc/iugQRONs3GPdNt2AQ==
X-CSE-MsgGUID: Ppc8adfqQe2gTiD9mWEJBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="37393490"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 00:37:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 00:37:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 00:37:07 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 00:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIX+ODCdQAJ+bdYSCwihVys7oX7tl1aJIUjnonrgByQQQ4ODZbQk4qCdm5IvXqtyn3UBKSl0v3djNY3xvt2X/ElZtJ8xLDe3JhXNspqMUtUYAb9ml8/rE6fvJHU/4rJ01hyjSm+Y0xyTOPvtIBOhXcy4JJrFOF4HmQcA+nFMfDvIGfS4EGTrnJY33z2Df+AU8qnxhpR9VWcqW1odP3k4LWuifUCPfQo3HNAkh3MYQoWAbz6TWO6rI8SL9sJebSSliVovKq9OPccZ2NHrO81LqoBVKVpQtDC5fMTbbiJ0l2qtaC7Pi9gxamz3Hn2HZyLlGHrZI6f0IDeMyZdzr1vsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGjQ4f61LNwvsrsNPNN1qWMbyKlROgBMdWbnsOcFW6I=;
 b=W2aU9z0efNd3GEDPU91UzwqUgTDkKxeCVb0FiKezey8udS56aQz7tRzx0nt65E5hqzhgElfS3WBTF87mcU5wsEP6TtBTN9234fakUSlrOPL0hYkRW6idGmcN24Y82n2BIFU7F+TEFzNJCTT3nQ87p6nhGGqSW3MZF4h5M02iVSUB4AEt5AhEdZHoUV+YnSNoYWh+dlQyLUu8mYtE6SPT9YXRLjqTgEV2RnGwEysLbCxssDqCMkprQjBVj9j+/SVMPaxjgqjktxI7sr7pMkOwBgEdP2h6g6L1dTpmkwU1CsVMDDPl99omelXolugTNKJL64754nd4G+Ge/bByVAn0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 07:37:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 07:37:04 +0000
Date: Mon, 3 Jun 2024 15:36:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Corinna Vinschen <vinschen@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Hariprasad Kelam
	<hkelam@marvell.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, "Naama
 Meir" <naamax.meir@linux.intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [igc]  86167183a1: BUG:spinlock_bad_magic_on_CPU
Message-ID: <202406031428.22e2b70a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0095.apcprd02.prod.outlook.com
 (2603:1096:4:90::35) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: dbeef9a6-902a-44c3-92c2-08dc839ff685
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A2Q139FURgvO4vRsIrP3pr7ohz/9DQ5M8E6xoYJuSXXhwdvXWr/gopmfilFI?=
 =?us-ascii?Q?D1dbuktUx9sq9xba00Uey/0LKF5UseKC2tr0lLx9d+tyYJyO/M5Z+zgi+dj0?=
 =?us-ascii?Q?UK6uuMqFxUlFwIZmdpNJfKJ5p4xflwkX10MuvoppdA9Kd8yI015ccrjSTQTk?=
 =?us-ascii?Q?qJXTIvNLqzqONi+BfPE7GdmBi5agas5sk6R5e+uwdQ2ljxYvS9wrB8VSVY+3?=
 =?us-ascii?Q?3tDjtDftFcdDel4IyR4OrAAlIklUbT9wHpyZvrol172uXPl2bKBnY5d2v1rV?=
 =?us-ascii?Q?dzZuqEgWdcLxRgSsh9eUeTufEWss70fMmaSmy/ICIqEHgAYOKxqk8qSXjOw6?=
 =?us-ascii?Q?oTFnm5xNAtLNXKJtrBzvA+pYIVKFIl4xCrdD/X4fLe1MX11hhPEJvt05A/7Q?=
 =?us-ascii?Q?hjGpE3zPXoB9LfnOU+vlokig1cB6ZsmIRBdc1SXf7wiBg0KXhUpdZ8y5YOXa?=
 =?us-ascii?Q?CdbU3J1iK9N09fBUDETtaMNW6zBgRF6PyoGXrpVmy5t5tQzhFYNvNXb0w50d?=
 =?us-ascii?Q?7c7d4j6K3jl+n7wohYksACrf7/6P36hBfOlbuX2j/dSkLIbue9n8Huy925KD?=
 =?us-ascii?Q?fkqZntwgtyUxsLcUmIuendITflePADrMN8TVlwZs3qWBtnftHjCIuJw5joEt?=
 =?us-ascii?Q?KKvGgIM68pQWYrOWlbbEVD/TkGvlSnrQHsCEpcJc6rqYn5v9IN5U4ABreKP5?=
 =?us-ascii?Q?+wSMZgB/AYPm0vuvQnm6dMak+w+5B//5HCblsT4xKgnoExoOILd3kdHvGAqP?=
 =?us-ascii?Q?+5TgAsqxjoIXE+1mMKz9mXZjTXoaxYMIDZoEkWVYSDiPMpVd/Fr2vpcqKyoy?=
 =?us-ascii?Q?IxYlaxp/Q7dYmmnS6PZioCH9PG8+HKY340UCU7NXjD/22JzB+6/kSwi82x31?=
 =?us-ascii?Q?NWUTNP7GTZuiT313pqGmRg+JWqGzMzhYaZdmLBwd3J4bAEp03o2UpE1T2o8m?=
 =?us-ascii?Q?j5KAtN4UbvaNWcn7McbZVZY51SoVZp8QtOVRURoeh0lVN7YJq89U5AqQr4rK?=
 =?us-ascii?Q?sA+FEdyO5Sjr6KvPrv38SlitLEsZrsosQSugU4E6iwZzQkh22aaOtYoJ0vn2?=
 =?us-ascii?Q?Kab4Kxj3pYD6sZH9Bj2eQHyFBcznmd/6fp1DASmVuX5InTJMELTZJlFCzQpO?=
 =?us-ascii?Q?LHQvnejzcX9WevdYtkAPLeQK5kltTnNSoe8xibV15xhKgtPbidZJTLO6w5fF?=
 =?us-ascii?Q?plbJdOCqC+hV/Ccl+M0O3ltxPf8DbtVK3O9zKe8F8098ovtiJujq0YGXIYQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/JFR5GMiIpFpbFA3ocHsnrguK3SXzY+1ldkXZdGoEiVShGhsXTw4K1YUa7E?=
 =?us-ascii?Q?ftj5tb6DAsCehtwrDJ1RU57UZeQXFD6PJix7qK64Vg/7qpwQT1Rujlub7IUU?=
 =?us-ascii?Q?v3cbt3SDts+5eOGcUtTHscg5RM4hAHObIl8ot9HExIO+jgXz5Xkb/r4Sa+tf?=
 =?us-ascii?Q?kJXA35L6rxmDwih1/+z71Zs4+X6aiSTaPgOV1sbWdMqcvbOCdKUyIqKefzoi?=
 =?us-ascii?Q?p6viz1TJoin+fiPslU41vxLtDJPjCGwSfqUf92xJaWmvrRaDidHDVryhOmfM?=
 =?us-ascii?Q?FDWrboIT16K5wUTNe+dIssSi05yAF8t7f42IBF8dHt7QpIFtiBW2jMGXSf9s?=
 =?us-ascii?Q?5Imfg1ObKW9uWO1fTjAIMtNaI/ZVQG5OewhMldhlK/j7YVxBpa8R3keImFzI?=
 =?us-ascii?Q?MZXaWnI28w10A1B3QP0hY609og0quLwk+JeVxLpjrxanNMr5C7W5jfEspfYG?=
 =?us-ascii?Q?YjfsvCwW0+uRKQirU/Tcg/eekJLYp9+JX/1xN4uQKt0VWYycn3zgHZHItkfU?=
 =?us-ascii?Q?GTRsrNq2DEv/UegBpK90GRC+zaIXO51PUUJdI/HZKlzUwycOZP7H2b+SN+E7?=
 =?us-ascii?Q?wpZ8Sf3c5kOr64VTY1k3QIJ4g8epkOl2v0t3irjiKiIKUaVcgJlQ3BBc7FEV?=
 =?us-ascii?Q?YSlgPPBhwZ33afPhNVfc/CyMEOnFpVlULsfQqVxa/vQxaUeS4uGE/HzOtovN?=
 =?us-ascii?Q?69Fq3TaOHbj8Q37AQ8dtjY9HVpDTqULeUj/chWTg1+iqgFrHAHIYmuaZILyc?=
 =?us-ascii?Q?o2xwdPO2dU5/1kJhxYIiDy/zVfl31YLG8Vk8IfsiYTAYzLOGbLvIQsxfNVik?=
 =?us-ascii?Q?V8wlcv8ARlDDAGC93GZ47pxdG9E3JJuoHHfnIrkEg+9t1ly+Oh8NG1yd05uw?=
 =?us-ascii?Q?nBi0UbFAMuunZgVyvPmGZYRE3qwkIkbv749snaDWFIy0WulvnLhWqd1H9tui?=
 =?us-ascii?Q?jm28KlccZONxhJUt5bhaK+3MdBx14kA3yttYKvjK9vO1a/38kKv3cDsWYSPE?=
 =?us-ascii?Q?Gt1p2mDha9qrqzRuqcLXZiyiNXpEuCiz6eqcWrNNyn5atyYuVy9aOu4hWVmm?=
 =?us-ascii?Q?0QSTk3a+54OUtSp23+3UBO6RwerM/JF7JAQ6bIPxRI4KPpjf6TyDIODMajO3?=
 =?us-ascii?Q?Lzu7rLLku4F6YgDmdaTSaFtPA3KBeiI8gvAUlciaQCO4GIITYmSfejHkzkoS?=
 =?us-ascii?Q?J+akIAMq1Iw3NSHzbud92XQolMuW+Dd6uD+vgIg0Uj6VNh6IjQ+TUz6xa+D+?=
 =?us-ascii?Q?+Z9A82WqoNkkqBvc9/WWJfVL2DC1Z/T/HluHokCMH+7Lv6Q+pbmVB7/pqgs3?=
 =?us-ascii?Q?c/6l0ro6iQdzZWpxckafQ+H/Jx44M7hFeYalvvWdJpH1pdPD8gBq49osvPVy?=
 =?us-ascii?Q?J8Y6vzy5qzqds+SdQlAjk7ngcEI/33ICfBAfSiiNSDEUzTVWnGR6gj1Nkzjx?=
 =?us-ascii?Q?C++J7WXWs369DkIuILYMmP5LOyekB+QoDQSscovKj7A6msLo6AIQHXfvp+id?=
 =?us-ascii?Q?G9l5RyVtxySKW78wVM2iEWtbxI+dPe0oCtvOLpcXotbbx72jhOsF4XZP7iRd?=
 =?us-ascii?Q?DX9KJfeoBnWa1JJtRBcpYkwXYqjLl5pcF34OC6ZVpXgDKE2VFXDECwEKQkbs?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbeef9a6-902a-44c3-92c2-08dc839ff685
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 07:37:04.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJxPnt+dygmQjbDE/2LKh5Kpp7qO6wzoVh1lzdcP918plqlAenQNeVcqlLVYd+DrYjpJNpdgwCQWKkiMQVb0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7290
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:spinlock_bad_magic_on_CPU" on:

commit: 86167183a17e03ec77198897975e9fdfbd53cb0b ("igc: fix a log entry using uninitialized netdev")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      4a4be1ad3a6efea16c56615f31117590fd881358]
[test failed on linux-next/master 9d99040b1bc8dbf385a8aa535e9efcdf94466e19]

in testcase: boot

compiler: gcc-13
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed this issue happens on a low rate (10%), but keeps clean on parent.

8e3a90f2e3aa642d 86167183a17e03ec77198897975
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :100         10%          10:100   dmesg.BUG:spinlock_bad_magic_on_CPU


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406031428.22e2b70a-lkp@intel.com


[    7.177394][    T1] BUG: spinlock bad magic on CPU#10, swapper/0/1
[    7.178391][    T1]  lock: 0xffff888133bc3510, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    7.178391][    T1] CPU: 10 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc6-01560-g86167183a17e #1
[    7.178391][    T1] Call Trace:
[    7.178391][    T1]  <TASK>
[ 7.178391][ T1] dump_stack_lvl (lib/dump_stack.c:117) 
[ 7.178391][ T1] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 (discriminator 2) kernel/locking/spinlock_debug.c:115 (discriminator 2)) 
[ 7.178391][ T1] _raw_spin_lock_irqsave (kernel/locking/spinlock.c:163) 
[ 7.178391][ T1] igc_ptp_clear_tx_tstamp (drivers/net/ethernet/intel/igc/igc_ptp.c:578 (discriminator 1)) 
[ 7.178391][ T1] igc_ptp_set_timestamp_mode (drivers/net/ethernet/intel/igc/igc_ptp.c:607 (discriminator 2) drivers/net/ethernet/intel/igc/igc_ptp.c:644 (discriminator 2)) 
[ 7.178391][ T1] igc_ptp_reset (include/linux/spinlock.h:326 drivers/net/ethernet/intel/igc/igc_ptp.c:1261) 
[ 7.178391][ T1] igc_reset (drivers/net/ethernet/intel/igc/igc_main.c:123) 
[ 7.178391][ T1] igc_probe (drivers/net/ethernet/intel/igc/igc_main.c:6728 (discriminator 2) drivers/net/ethernet/intel/igc/igc_main.c:177 (discriminator 2) drivers/net/ethernet/intel/igc/igc_main.c:7039 (discriminator 2)) 
[ 7.178391][ T1] local_pci_probe (drivers/pci/pci-driver.c:324) 
[ 7.178391][ T1] pci_call_probe (drivers/pci/pci-driver.c:392 (discriminator 1)) 
[ 7.178391][ T1] pci_device_probe (drivers/pci/pci-driver.c:452) 
[ 7.178391][ T1] ? driver_sysfs_add (drivers/base/dd.c:447) 
[ 7.178391][ T1] really_probe (drivers/base/dd.c:578 drivers/base/dd.c:656) 
[ 7.178391][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1155) 
[ 7.178391][ T1] __driver_probe_device (drivers/base/dd.c:798) 
[ 7.178391][ T1] driver_probe_device (drivers/base/dd.c:829) 
[ 7.178391][ T1] __driver_attach (drivers/base/dd.c:1215) 
[ 7.178391][ T1] bus_for_each_dev (drivers/base/bus.c:368) 
[ 7.178391][ T1] bus_add_driver (drivers/base/bus.c:674) 
[ 7.178391][ T1] driver_register (drivers/base/driver.c:247) 
[ 7.178391][ T1] ? __pfx_igc_init_module (drivers/net/ethernet/intel/igc/igc_main.c:7534) 
[ 7.178391][ T1] do_one_initcall (init/main.c:1245) 
[ 7.178391][ T1] do_initcalls (init/main.c:1306 (discriminator 1) init/main.c:1323 (discriminator 1)) 
[ 7.178391][ T1] kernel_init_freeable (init/main.c:1559) 
[ 7.178391][ T1] ? __pfx_kernel_init (init/main.c:1436) 
[ 7.178391][ T1] kernel_init (init/main.c:1446) 
[ 7.178391][ T1] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 7.178391][ T1] ? __pfx_kernel_init (init/main.c:1436) 
[ 7.178391][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[    7.178391][    T1]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240603/202406031428.22e2b70a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


