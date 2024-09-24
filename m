Return-Path: <linux-kernel+bounces-337204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F399846E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694A5B223DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8DC1A7AD2;
	Tue, 24 Sep 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7Py9vMa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271D71A725B;
	Tue, 24 Sep 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185121; cv=fail; b=u0QkaqBiYUxpRHc8VBaUnV3VWrzWoV69ZYI0oz6pvlVVYhQO2TcJ66EiE2vyvOeXutZwk8bTYMVUkBtsPnE/gPnTu305KVRqGZJMTcc7JMOoEbpslNj05eDH2g5k10v9oequ2HfHEpiFH1qvW5zvHbSN4SpuXAZf7vDb14mJIeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185121; c=relaxed/simple;
	bh=swQbfY8HgM+2eK7WyTAEgCNDEnLxztjXwRCcqL+jTJ4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oji0/XJplSaBOnrVkJQQBGaW5Qb9J1UbYSu6wbg9Nqs35ycW+AWYqvY1E0juVuugS0bqS0dwzMsW4E0TTjbmPutUc+j/ao9VhqlSBgyWP30YW90tIcdE8Y7CTmAapSLN7R5pZyz2jMjVcjo8B+ZNVvqKXj39VRzqxSYURZnN4ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7Py9vMa; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727185119; x=1758721119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=swQbfY8HgM+2eK7WyTAEgCNDEnLxztjXwRCcqL+jTJ4=;
  b=X7Py9vMa2dEXWB1tuUD2cj1yjjNlmkpeZN0z0kfz4b+P2PTHcp/xESx1
   RVgM552dI3GRErJs5uCGwOzxNzV3fiGmFWqUiu90SWnk7PfLEkfxERKHy
   X9BWr5Itqj6Qiy3JqRBCvtMcQVNizxKtrmSXVDjw8UEu8agy6l7KY2bP1
   FqbR/MIDAlZh9SwHvuSpbrGPcbHhQT9YHE74NBYzv7o98RBJkLTV7DCth
   7OHhxjla2vNvD4aAJ4s7f4QW0wgNvdkN+ttPBxFIcBNIaHIQJn7frz1dG
   mmJ3bPby4UXwSWHhkjoC9hJv3aE46WHv/9WQljA1c+ESxdfAxTzJ1OEt0
   w==;
X-CSE-ConnectionGUID: WeNozG8RRpq8xMDRYzZZjQ==
X-CSE-MsgGUID: gwEj0zOqTAWcEGvHIpwHRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="48707333"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="48707333"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 06:38:38 -0700
X-CSE-ConnectionGUID: T+PRnsSJT1a6OFXyvVL9Zw==
X-CSE-MsgGUID: xHA8dgQzTZ6JPVYkWVA+Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71022835"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 06:38:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 06:38:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 06:38:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 06:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFTHu2kKh1zd+xx3FUSdQS7UTqHmRIDTH88TA0IxhH1vTzBY/SSY5Du7G71878y0E5Yd2MAE3AGCjlHwcmTE5rB1BiFDzmEISwBmRZmYMXXJ5ftBLMyN6DJQKxPh82G8caclg/ND4G/WDzKr4IjUbZp4jkfBJEMtjANGqFfbo4B+raBsYafgtNYVE4eaHGNIt/8pR91yRaceDdrK8mMQEajaHCT6HKIA1QajXZg09EFk+TZX5srPPRSPO51DRcxEEVhiHuTg7cAL2D7L3gWkzKJ+LFW1TvSVScBb4roe8dN+Ws/PsYd2IElD/8JRHAhMf42NPiaJI5X4C+uGOkFc8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRZlz3lWlezi4q2UjnIH9v0E1du7I3jHEDmphai6Qb8=;
 b=Ma0nhorTMkQFsZ6enKO/3r4R2zoSkukXnSupAxuCud8gYxOS10PqCZqQZ3ubvliiiJaAZgGTXJTXOKuUFO+vFzd97ukdHfQK5rnoHSkKbC5Gwkp999LbiL11OHBXwi5hUp4HDwbG1CzcV/662hfFnQaDDuX+pBL5y0eIgA3RdQK3Qd2wkaSbs6ZeVAG1nmSDMVXjUChQYZnG7wmR/uKuo5TC0SZHVIoyR5QP8ELifVEPHCIb7RWq6QWMIFIWvQWhzUTlG9XZIEN/IQE5nUL6KT8xxh7MARGHTf5dJ3mST5gRKUY5TilCBxCEbBIbEzh7G2av2RwXcpDI90BxsT2/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 13:38:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 13:38:34 +0000
Date: Tue, 24 Sep 2024 21:38:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Perr Zhang <perr@usb7.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [usb]  b8fb6db6cb:
 BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors
Message-ID: <202409242143.d9949646-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYWPR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9618c7-1bae-4831-0a32-08dcdc9e2ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wl4a+FldFL+V/C88rZBT9QDhqXXge3O7wG96xgTS6XtWPIWm89Xx4hj1p1aE?=
 =?us-ascii?Q?Du/a7aiGuLREf9OOdG6QnFFLlK7t7j7t85uuJWTXJ2eo9WKGfb927HfEfKGS?=
 =?us-ascii?Q?bolW9fBYnDQ87+ik3BcVUENrV9m51Gx1kBH9Q6VlvNPII8+lUShJlETQNkyw?=
 =?us-ascii?Q?4qWqmSbEpbHAnBMSgAiAmAURLNZOoHY1+TGMA52FKWAGENIm5SbkQ5gB3tlR?=
 =?us-ascii?Q?jxMKKedqcHvfO/wtAQLYJA3/uqXupys+7/Se/q2wiVpdl7RrjxL6WKvjqEpR?=
 =?us-ascii?Q?br8TYMJ+Fp56qlbWpW71KY0OjN1LwkA0uxdV8k+oEorGZ31zrMzr3YjyoEJX?=
 =?us-ascii?Q?WPQz0gbAQsY6kfOllGOXCh31DqddM043ny/9hLXX9XVbBSJZG+cOlKjLHBPR?=
 =?us-ascii?Q?8fg56Yv2wCjzjYbIijdMSXW3FRT6ZB/dJiyw4hV1kkiEKpw85mcM/Kutz7nh?=
 =?us-ascii?Q?IOnCFdWExAdJAuoyHngorHDE/P52eSxW/aZ/36tcJqdQ6Udf7jW5Y+T7jRJr?=
 =?us-ascii?Q?gzmtGqAChqELS1WWzFM6HktiIjl8kvEF7lHCQg2rSA4VAjhgX+dt0MObJcp+?=
 =?us-ascii?Q?xAYOSPa2svNzG+rJPNLaMuH1P/HoaLUN2UEAuPhfQGGKhOpg3g3VHeK4Ci9g?=
 =?us-ascii?Q?NTiyd6MyDEzTPOYrnGhpsOWx+0EqxHusP8ox4am8D76l9AleWcxz65b7Feah?=
 =?us-ascii?Q?2rqpe+yCZuG50DjJkCf4Ed6yB2vVoSp+NHJfFqH34C4ThGbgJGyDfyYAN+wH?=
 =?us-ascii?Q?3iFDg4Jz5hK+ilQVkV66BLN62eUp1eq62L/M0bslMWuN2in2OMpCuHLFZpWA?=
 =?us-ascii?Q?2WfaOtrmz+6WBe6lwHv1gnPb+Mf8PtCwjrgkwXEmZl9UxQP0XJDC53OvLfng?=
 =?us-ascii?Q?nbe1k08v+gJ4HtAiikrfs14Ho5XFSOLi4jB9Hpky0Dax74xtFWIURSug438f?=
 =?us-ascii?Q?dsZwB+mF/eBhrXim3GHnksU8qYETI4bFtEdVrErzThEufk0LHQD1XHp1e3Fu?=
 =?us-ascii?Q?6Vx4vSYdbkDH2tNmY0dz4MCpZgRHIW9uiK9dAWkMjE569WFPDjdJi4NHQpiX?=
 =?us-ascii?Q?ASfDz005cxNTuE5LyPavQluEtUeGU6Yo5a+ZZcJWyWnOxxiw0haaluNBoN7n?=
 =?us-ascii?Q?+qzbToWWxfFPikx4QEiM1x67PvfxafLXkelBqmQyATDaw873bwCg5vctTzyQ?=
 =?us-ascii?Q?ZLXcG8jU6XZ6iAYZiE5lC4kMYAvj01uVvTV6GNYNOC/XUJta9nQoJGRHPsJp?=
 =?us-ascii?Q?tZvg01uINf68qPbZnnOqT66ZyZ+yPvUXbMieGTlgTBMPAiqb/jeOCSHnu2Vh?=
 =?us-ascii?Q?r7Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kirYAmqdBhIBOCRhUkmi6I9Zbr+K5vrMFwMS6vozBC1obfmNMz/ZA2ZulT1Q?=
 =?us-ascii?Q?n9NT2Gn/Rj9fXQVNhCUbjrK5/nlUR6PidW5DkTTP+ih+aRHMzC4AF2kRptyz?=
 =?us-ascii?Q?4E1az/0iKxb02PxuswPb/GxiuNKHznN6zH5WOgPVkLWTmsoOAyG8U38QUV64?=
 =?us-ascii?Q?1kdmxsFME5WzfJ5Bs+UadgSSAeoXXe6qd2yZgGmnyXeZSEGEnKlGU9eCFTtG?=
 =?us-ascii?Q?fCDYlGGR8uuwf3TNOS0lqUXa7m8XDZ38rwrN81Z9oacIAu/paOLgmACVPH33?=
 =?us-ascii?Q?F1kcJ19kqTPXFDGwLUQW5E1ED+1rwt491I6DvgK9eaY5t6eO0PWFrtRXRjL3?=
 =?us-ascii?Q?r9eGhiMBwxQiG1d4RR4aizlV8dmCRJfKkaGuRj9HJRTmpcmPWJB/BG+c6czZ?=
 =?us-ascii?Q?gsEgdjjjvsKeHQG4y1YXo5X0gyg0lVTI74PK9xIW4j7YQi6lbBRLdONLI1M9?=
 =?us-ascii?Q?GEnf8Pkfm0+aAiXDBjNTHmm80JVLehuiiPTq4Q8BIUNjwHbWNflctQHqpzMJ?=
 =?us-ascii?Q?hpyNRPjm1xhmy4+JjQTBYHGl4t8uYE8ltd9nSiezHs9lA5iLU6QmP2mZ4JFu?=
 =?us-ascii?Q?YaKXz94GE7gUjYtwfyQmX7vWBPJ4lqlDPyXJc7SJKswCIfAXJoMQwV5b6AP/?=
 =?us-ascii?Q?ZJQCqUCrN3TgY+l298iZe6iSpVdedtp66EkpBfKgvLuZa40mdeJF8wq6Z9BR?=
 =?us-ascii?Q?4oElKUzMV2QIj5LwtfBQujxbG20Vc5bh/9ecDZ6/ov+dyQbQtOmZHK6i919j?=
 =?us-ascii?Q?8USeAMQx8bsweDA+GD3daA2sD+0pYsRfX0E08oZmKialnZ7VfQVefN/dZIQ+?=
 =?us-ascii?Q?7W2ZxzgKPYZUGFvkJ631JlMDLhy78HhHPM527PZ+8541eUrJLcLOpij4BUdn?=
 =?us-ascii?Q?RWwl37F60c68JH2XNm8hXU3YZRmXPOiQph/Ruxq8t7OqaDJ8d9IxfxufFyst?=
 =?us-ascii?Q?9sW2A+I9EpCS7WumlmEfnw+xNH71oULLqgIVrZHFRhtorTZBIh4+mXUHfjnb?=
 =?us-ascii?Q?Ycjr/Egtl+xwdisOLIk8yvyMun3HM60Hi3tkWZDlCgSsQr77IMNdKZl0Wsh7?=
 =?us-ascii?Q?thB+knSsY+dBcf7xz1qh7iI5a4qj8K2TzKlWHKAurS7BslrDcQReDevhrXfO?=
 =?us-ascii?Q?dV4GNVcFQUWFdDLw2/g4TJoJ28/bDko6am/FdTKEAqrBhuwFo/6L7ayX80Cj?=
 =?us-ascii?Q?DUIBaURJPWWEznJsm9d4ZGaGsyYpY1sANRPTwSQbF3zg+izYqTJKD/cCwafD?=
 =?us-ascii?Q?IHWReyR/iNl2Mc75+6/JhpkI7WmOMem8QWQB32uZgJ+qGn/JN8Z4d1D7Gsrf?=
 =?us-ascii?Q?WeUHRcijxjS3v7y4ytb7q18h7zieo+umritWPm3SS/Cu4C0epPU3PdfNHMN2?=
 =?us-ascii?Q?BBjsxRbHOwJxTkCvS8/uEoU7sB0nGSusVQR+aixINaWcVeG92VyVw1h7yFNP?=
 =?us-ascii?Q?J4hWVFIr8yr72Ec4A/MmgjWjeNfEy3zBspzFZo70Mwg9b1aOMcsBV6y0EtGK?=
 =?us-ascii?Q?/ObsWT5CDnpwDa652zSgLxII5hIY+IqAUNDIL/fIHxBjJ3llX/bs5p+MAqRO?=
 =?us-ascii?Q?HH8Ou0MVT0WHznNKxVV2vyCc/Ks0dzwVhByKypKBhugFq7F13/7lDaeSnKK7?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9618c7-1bae-4831-0a32-08dcdc9e2ffa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 13:38:34.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgcgNOuqsqnC5ZW204GtRxQVB2IGLkhRpiMFvPSM1xZMhuGao/kXfRQxPZXSzyoYtBJcyq7ZfahfhxwVbz4F+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors" on:

commit: b8fb6db6cb04e3c35d661d0f6cf6f8dc7444ce0c ("usb: f_uac1: adds support for SS and SSP")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      abf2050f51fdca0fd146388f83cddd95a57a008d]
[test failed on linux-next/master ef545bc03a65438cabe87beb1b9a15b0ffcb6ace]

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------+------------+------------+
|                                                        | 36d586c057 | b8fb6db6cb |
+--------------------------------------------------------+------------+------------+
| BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors | 0          | 6          |
+--------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409242143.d9949646-lkp@intel.com


[ 112.946534][ T1] BUG: KASAN: global-out-of-bounds in usb_copy_descriptors (ld-temp.o:?) 
[  112.947205][    T1] Read of size 160 at addr ffffffff87d27da0 by task swapper/1
[  112.947348][    T1]
[  112.947348][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                T  6.7.0-rc5-00081-gb8fb6db6cb04 #1 0b74b627eecd14071872650b3288b2fae55c3c90
[  112.947348][    T1] Call Trace:
[  112.947348][    T1]  <TASK>
[ 112.947348][ T1] dump_stack_lvl (ld-temp.o:?) 
[ 112.947348][ T1] print_report (ld-temp.o:?) 
[ 112.947348][ T1] ? start_report (ld-temp.o:?) 
[ 112.947348][ T1] ? usb_copy_descriptors (ld-temp.o:?) 
[ 112.947348][ T1] kasan_report (ld-temp.o:?) 
[ 112.947348][ T1] ? usb_copy_descriptors (ld-temp.o:?) 
[ 112.947348][ T1] kasan_check_range (ld-temp.o:?) 
[ 112.947348][ T1] ? usb_copy_descriptors (ld-temp.o:?) 
[ 112.947348][ T1] __asan_memcpy (ld-temp.o:?) 
[ 112.947348][ T1] usb_copy_descriptors (ld-temp.o:?) 
[ 112.947348][ T1] usb_assign_descriptors (ld-temp.o:?) 
[ 112.947348][ T1] f_audio_bind (ld-temp.o:?) 
[ 112.947348][ T1] usb_add_function (ld-temp.o:?) 
[ 112.947348][ T1] ? f_audio_alloc (ld-temp.o:?) 
[ 112.947348][ T1] ? __cfi_audio_do_config (ld-temp.o:?) 
[ 112.947348][ T1] audio_do_config (ld-temp.o:?) 
[ 112.947348][ T1] usb_add_config (ld-temp.o:?) 
[ 112.947348][ T1] ? try_get_usb_function_instance (ld-temp.o:?) 
[ 112.947348][ T1] ? usb_get_function_instance (ld-temp.o:?) 
[ 112.947348][ T1] audio_bind (ld-temp.o:?) 
[ 112.947348][ T1] composite_bind (ld-temp.o:?) 
[ 112.947348][ T1] ? really_probe (ld-temp.o:?) 
[ 112.947348][ T1] ? __cfi_composite_bind (ld-temp.o:?) 
[ 112.947348][ T1] gadget_bind_driver (ld-temp.o:?) 
[ 112.947348][ T1] ? really_probe (ld-temp.o:?) 
[ 112.947348][ T1] really_probe (ld-temp.o:?) 
[ 112.947348][ T1] __driver_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] driver_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] __device_attach_driver (ld-temp.o:?) 
[ 112.947348][ T1] ? __cfi___device_attach_driver (ld-temp.o:?) 
[ 112.947348][ T1] bus_for_each_drv (ld-temp.o:?) 
[ 112.947348][ T1] __device_attach (ld-temp.o:?) 
[ 112.947348][ T1] ? bus_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] bus_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] device_add (ld-temp.o:?) 
[ 112.947348][ T1] usb_add_gadget (ld-temp.o:?) 
[ 112.947348][ T1] ? usb_add_gadget_udc_release (ld-temp.o:?) 
[ 112.947348][ T1] ? __cfi_usb_udc_nop_release (ld-temp.o:?) 
[ 112.947348][ T1] usb_add_gadget_udc_release (ld-temp.o:?) 
[ 112.947348][ T1] vudc_probe (ld-temp.o:?) 
[ 112.947348][ T1] platform_probe (ld-temp.o:?) 
[ 112.947348][ T1] really_probe (ld-temp.o:?) 
[ 112.947348][ T1] __driver_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] driver_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] __device_attach_driver (ld-temp.o:?) 
[ 112.947348][ T1] ? __cfi___device_attach_driver (ld-temp.o:?) 
[ 112.947348][ T1] bus_for_each_drv (ld-temp.o:?) 
[ 112.947348][ T1] __device_attach (ld-temp.o:?) 
[ 112.947348][ T1] ? bus_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] bus_probe_device (ld-temp.o:?) 
[ 112.947348][ T1] device_add (ld-temp.o:?) 
[ 112.947348][ T1] platform_device_add (ld-temp.o:?) 
[ 112.947348][ T1] ? platform_device_alloc (ld-temp.o:?) 
[ 112.947348][ T1] vudc_init (ld-temp.o:?) 
[ 112.947348][ T1] do_one_initcall (init/main.c:1236) 
[ 112.947348][ T1] ? __cfi___initstub__kmod_usbip_vudc__683_89_vudc_init6 (ld-temp.o:?) 
[ 112.947348][ T1] ? lockdep_hardirqs_on_prepare (ld-temp.o:?) 
[ 112.947348][ T1] ? __schedule (ld-temp.o:?) 
[ 112.947348][ T1] ? lockdep_hardirqs_on_prepare (ld-temp.o:?) 
[ 112.947348][ T1] ? irqentry_exit (ld-temp.o:?) 
[ 112.947348][ T1] ? parameq (ld-temp.o:?) 
[ 112.947348][ T1] ? __cfi_ignore_unknown_bootoption (init/main.c:1283) 
[ 112.947348][ T1] ? parse_args (ld-temp.o:?) 
[ 112.947348][ T1] ? __kasan_slab_alloc (ld-temp.o:?) 
[ 112.947348][ T1] do_initcall_level (init/main.c:1297) 
[ 112.947348][ T1] do_initcalls (init/main.c:1311) 
[ 112.947348][ T1] kernel_init_freeable (init/main.c:1555) 
[ 112.947348][ T1] ? __cfi_kernel_init (init/main.c:1439) 
[ 112.947348][ T1] kernel_init (kernel/async.c:254 kernel/async.c:241 init/main.c:1443) 
[ 112.947348][ T1] ret_from_fork (ld-temp.o:?) 
[ 112.947348][ T1] ? __cfi_kernel_init (init/main.c:1439) 
[ 112.947348][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[  112.947348][    T1]  </TASK>
[  112.947348][    T1]
[  112.947348][    T1] The buggy address belongs to the variable:
[ 112.947348][ T1] ac_header_desc+0x0/0x20 
[  112.947348][    T1]
[  112.947348][    T1] The buggy address belongs to the physical page:
[  112.947348][    T1] page:ffffea00001f49c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d27
[  112.947348][    T1] flags: 0x4000(reserved|zone=0)
[  112.947348][    T1] page_type: 0xffffffff()
[  112.947348][    T1] raw: 0000000000004000 ffffea00001f49c8 ffffea00001f49c8 0000000000000000
[  112.947348][    T1] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[  112.947348][    T1] page dumped because: kasan: bad access detected
[  112.947348][    T1] page_owner info is not present (never set?)
[  112.947348][    T1]
[  112.947348][    T1] Memory state around the buggy address:
[  112.947348][    T1]  ffffffff87d27c80: 00 00 f9 f9 00 00 f9 f9 00 00 f9 f9 00 00 f9 f9
[  112.947348][    T1]  ffffffff87d27d00: 00 00 f9 f9 00 00 f9 f9 00 00 f9 f9 00 00 f9 f9
[  112.947348][    T1] >ffffffff87d27d80: 00 00 f9 f9 00 f9 f9 f9 00 f9 f9 f9 00 f9 f9 f9
[  112.947348][    T1]                                   ^
[  112.947348][    T1]  ffffffff87d27e00: 00 00 f9 f9 00 00 f9 f9 00 00 f9 f9 00 00 f9 f9
[  112.947348][    T1]  ffffffff87d27e80: 00 f9 f9 f9 00 f9 f9 f9 00 00 f9 f9 00 00 f9 f9
[  112.947348][    T1] ==================================================================
[  113.005042][    T1] Disabling lock debugging due to kernel taint



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240924/202409242143.d9949646-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


