Return-Path: <linux-kernel+bounces-231756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23705919D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292EE1C22E23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25E1D53C;
	Thu, 27 Jun 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQo3oK8G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BAEAE9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719456118; cv=fail; b=XolaBvjdUZGuAOcczzw+3oQAxAWQYciHgEsv/agWoTgIzdMR4J4fW8NOah3cIHVM9wKQG4jYdXWCkSKwIUGLku7wwKqPKDseaSkj72SOuBMRY0Vt/20AZlM2h2kxSoN1v3/nddwA2R2bH+jmvv3gCzjhLR75WGAlhyKybphJ3Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719456118; c=relaxed/simple;
	bh=XvK31DN0IVUIDxpxCMQpX3h0Nyj3ClviWctWCk+wrFE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UAk/ldvo7V+ICsIAqozOe9Y9Jt2CeJiASzX+/F5lkgFH5/YiBNQDFqxtiwzNOY5DHAw2yDhqXY4cNcEsCeKV1PMxgEhlMQ+jozIKrAeK2AtbfAEzE92L/y/IGdryDb6vE7XazmHZj+aww/HOR1xoEwVqOy/zutM/QaEPBLmLMjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQo3oK8G; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719456111; x=1750992111;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=XvK31DN0IVUIDxpxCMQpX3h0Nyj3ClviWctWCk+wrFE=;
  b=MQo3oK8GHN5SsdhESaBocV6xf6XCA0R3zbEK3r+BIy3icet2Oyou2glm
   n5k0lpPIOkwwxH1Sk/uTqoSe/L3o71Aqf30C8e8mhl5QQzP1yALgI+3/L
   NrjUvpCDiRvlXl9NBYi44U/N0R03ZKrbDE4hpU+9p2ZVDfMV0l26Q9/Wx
   /ndVhS0Af2Ep4SDwXe2f1M4kCa5yjMOhugDtFm/v7LhMNp2Q++7zflt9J
   LfRttUPM3ayrV/vVEnTOJ6BVbXlPLfUG9FucIzbh/Xqk+fPgH7NDXtcuI
   h22m5TNv/RMZRfZU+0KZoVFnngTgfdy7CYkk7ycs6ezlRbogrIGSLK9x4
   A==;
X-CSE-ConnectionGUID: QJhq7Fk3QraUJ5W85TfQLw==
X-CSE-MsgGUID: 0Dx044NtRdqWP+86rvUHaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="20444910"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="20444910"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:41:50 -0700
X-CSE-ConnectionGUID: tBESzNgCTEWJnzXVEOzz1g==
X-CSE-MsgGUID: aeLCyhdrTGSWQpNTziuhHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="48682554"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 19:41:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 19:41:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 19:41:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 19:41:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 19:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzuP7dHddgmErCnmrBg6aDyZwhSl5ZANpjHXhYN8aY3ll9Sthmlgp7GJO80ht+fEOBv0RUswMWNB5oHjDsKcV3U9CDbsRMP5jxEUyaaRYc7zIc2wh3/4gmw+XLz1lNtrnlWeYdKmqPQATFonUOzn16eyEq7kxPfwB81AhOI1GLPoV5627/W31sUjNOBixOTj2sp8M+ETTElS4+3+y2d2RFJWg/gIo9uQfUP1WdgRO9aM/nRYlWNBy+GBKj7GS+SkFAQHGcdzDnHFMakDRQc8m211LrejzzBVfL/JJ1cM43qTzF3GssLq33hYNZn4a5jbVEemhBcvfhM+0/kXRlERVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wh6KkplzsSHc/YxW0FFx/oPOshnM75Dr+AhWBejGvuQ=;
 b=AszHjINKUimSHc/wQCMwazEiPUhKnGCtCXQsWHZIKs17ol+YO007Xfzpcz7g+35LHf0+wH0OUH215BWMqVGEeZ2zrPCOxjIv1RjSgY2DID+PeKqsCFfhLLhmhA3v+d9zLARJn8Aqu+If/TZnUPfDityx5wOqLu2YsgWkTz5Jip+dzW2cdSmJnrogXCU094cukjeg4FKzbvfXVcq2w257AvfnqJPhlYKxD9CrmCaT8IBkGRCi6LVoCnjNFLc+D6UxJG2cjWAXpo+nhVSBD5xGKp4jaLbEpuB38X3VcUxXX9RviKde6j8p+OsYHopWO/B3REWXTU0G3L0WGpOAToMC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 02:41:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:41:44 +0000
Date: Thu, 27 Jun 2024 10:41:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, Mateusz Guzik
	<mjguzik@gmail.com>, <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [lockref]  d042dae6ad:  unixbench.throughput
 -33.7% regression
Message-ID: <202406270912.633e6c61-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:408:e4::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 62369a7c-18ce-488e-9580-08dc9652ae04
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?EzENvP7YVcUAgxHo3/RtGL2HvsTRibTcKla4qPLKE84PpJ/DIJJniSLB8d?=
 =?iso-8859-1?Q?ubWZYF3AMGDiIPOLokw1S/YsmPobzLuPfE0vrzs+O/MUyIvcAgunSGTFRr?=
 =?iso-8859-1?Q?OIFWB7umpCaLCuc29wIp8XHRX3VztjMi+v0Z0LRICHRJE6I3cUCqJR+mW3?=
 =?iso-8859-1?Q?gPBsnAab7ZtvR5J6QUkdq/TLPen2UmU3FGBJfxEwu6C86heC7W7+1lNzO0?=
 =?iso-8859-1?Q?weDoFHdBNVWxrr+CsR1a6SjKBpFpHxYTKz6j0/X38/m6hR4nu6BxR7DgWp?=
 =?iso-8859-1?Q?+cUpdWZ1z7UvPC8Me1U19wT7N8m4ckq116fziiaUUJ0SKHH2TgN9MKyyu3?=
 =?iso-8859-1?Q?RSj6VJMiAgtKEKpbjwhiE+bxGR/BDqlPRijsbMmetxRzlxZGx1pRRrIbsg?=
 =?iso-8859-1?Q?swJQYzplfBo5zAC/lhJInPCvBWdZgqynL9yC1eDJDLiXQiwFAHFIDBYXuu?=
 =?iso-8859-1?Q?Wwhvi5P0Q7jePwHy+cCZfbr7BYanlEDwpgHHBegJfnY5iLh2jxL7cIpk5Q?=
 =?iso-8859-1?Q?e8+gbF1KMU9IH9fLl4ltMEp8KpFKEHCHPs1Sk6WpfMITXNbFTvxWQk4PRR?=
 =?iso-8859-1?Q?J9rhF+d9o4pSqLZZQ8TRVhkVvwBcLITbgpB7+OtQD3Pct9edejuP6YyKf8?=
 =?iso-8859-1?Q?d3k0OSqhBEr5+ictALrON7BDEimGYmHVO2QF+cEYQqogzoXXNItwhGL14w?=
 =?iso-8859-1?Q?ksV4zI1pB2RhGyTuGg26Qq+2Y5IBLef6H8ajKLNYtr5bePYKu2owlPJumY?=
 =?iso-8859-1?Q?uup3Hzgww6abVli2NtZIF5dIZbiWJodpsBuy5Ujzy2+Hy27HB/be2hve4s?=
 =?iso-8859-1?Q?EuwtoPLOa/+B7ybsSgk7EVY2s3zdYXZwhpLStXOxwG3KzU9moU8qepW2m5?=
 =?iso-8859-1?Q?53WOqrIO0lhCqQhvweuvhogYMWoaTAtodYZj2onSP2y9ckyJ3VIMugLTvh?=
 =?iso-8859-1?Q?h/Ks+T11aaWhRn29b4VeI0Gt8w73SYUGGnxN4jQ87ufvWGQ5SFnyn7EG8K?=
 =?iso-8859-1?Q?Y5K6NQVz+Kv9gENVw7HNs2sAEYs9X+c5ohG7HEMLrKQSG48fA3bSzR5Suy?=
 =?iso-8859-1?Q?S2xqTzAGnXsOxbkuAdhIrDsO4HlsMNaNJLooYOoSwSUwQq57eaTD3HFIJ2?=
 =?iso-8859-1?Q?hvXiJJixEzPO91f46uXZ/KxZO/4nTMrU0ulzx46KnLfMVkyt9GZcVYzhXF?=
 =?iso-8859-1?Q?c44NCZ4k8WRdSALZ/dj9VVgoKdJiX43vpuyxKFkPqnHKEom8knDbYj8SSX?=
 =?iso-8859-1?Q?Mt34ingfn69RaYJ9p+skGkTofFaGQQ2nLuAVWJ2qEG+JZZOtg3X8z145zZ?=
 =?iso-8859-1?Q?UvdKpikm7wsEVN4Eg2DGZg+5NA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0c2jh8E+ChqpC1khkDQpw87HwNEwIlqhsWybNFR1NXMy4E/H6nPBMz7DYQ?=
 =?iso-8859-1?Q?DINXCcW1jW1sYDxxqGIQKhpw4zfax+8ky4VgphRFHdRYsKk4XA0Zxei4sG?=
 =?iso-8859-1?Q?OkXd01T6Nvrla2n5t/WrXR6VqggdlByYnureviTLMrkilO0DitnjdoC/Dn?=
 =?iso-8859-1?Q?LksHAssFDf8M8DRop1797FjcNZnwxAAqXsGS2URrRmoA2otVh/CNA/hRGU?=
 =?iso-8859-1?Q?gSrXni7NfUIaFe4T8TMb+gd/8Ued/7NDmkRzUeqYgTfRt/UUkz/Wek+UD+?=
 =?iso-8859-1?Q?Uj3RK7dVDDC67u7vAkntNchm9Rf0WD0o5zaasK/UjdUrrKfxkh/4dWz6o9?=
 =?iso-8859-1?Q?NPoGTzpp3NEdkHEiEbr2z9ulnvzPj8sn9RUKFAncnb5Ej6VJZ9yKwOM6p5?=
 =?iso-8859-1?Q?BvZcWQ14L0LpCjKx9xy1ek1B6xgmn36pQ81WTv+/fg95dUsiyacsqF2jVC?=
 =?iso-8859-1?Q?Krs+Rb2P9utINexHgm00XhB6MPqSRiPRsWVK42bctRe7et7Aa5fzD9ukvW?=
 =?iso-8859-1?Q?4gITLDr6ZWJHwRdvpVRhdSdYriv8uQQvZbvVF2QQwtP0ppt44o+zCSvz3D?=
 =?iso-8859-1?Q?dD1BfsA0w0ijkRb/5XrHesnql2SFLBQHMYy9D+CqruChZO9KrLQMi1rkYU?=
 =?iso-8859-1?Q?Xf5zQZjlz12hN8EHmeC9jrrGAV1kdDGLh9veM/5wIApHcvxJsxe0ZweH00?=
 =?iso-8859-1?Q?96zKXUBJ6QH/KRL7pAZ9dELfWsbnxjQ0PdA53gsxSyR5Km90I+ldDb2RZm?=
 =?iso-8859-1?Q?h4CZ7oWF84JHgMY9VJaVfY3aMBrqDhuQWYN6vSXiHQL/2P3dPHhRDOK00q?=
 =?iso-8859-1?Q?cHhvfqW7SVNB4BdTsFylAujUhOBKXxtU70JcbB4GF/izwSgzZJxM5VP9B6?=
 =?iso-8859-1?Q?oBJhyLlJuXUAC5tC2PWXiTCwOhNvRhf/+5axyxkcZRzCd5I4MrCgnrHoqZ?=
 =?iso-8859-1?Q?BN7vEnsS7Pr2Lrgy7UPbO9PvEgkxlEvCfAvPYF0ZclNOhhBOoD9rXm8bzP?=
 =?iso-8859-1?Q?T7xgy6RukM+FR8Z3tzBm57b5z2rnNNhUcD/i6DLZuBxM2t7fP1Vt8ecQQP?=
 =?iso-8859-1?Q?IhxM5D12A0d+6527rBrg/ABPsPGHrkGqkIxQg+IhNeSNsu90Tlr2oPl7KJ?=
 =?iso-8859-1?Q?1aA366x0XgiW7vYJ+lu7kbU/pYGxR6gc2LnmdcsZEzx1xFQfY+0zIc7H0e?=
 =?iso-8859-1?Q?26zpNPz/gjexthnBlkPMw6bW8EhFvJMEtpbpr166GOTKynASZzeVzzCn0x?=
 =?iso-8859-1?Q?0EuI9miz7sXhp2yMw46a7npHNAO1qk2d3lRmlOIUXEu1gtIRqnGqHUTSqO?=
 =?iso-8859-1?Q?bOUCPs6RWJXKmmDDflukCLpCvHqfBDVIlSxIXgO0yhXvlSgQ0kUHAYczmP?=
 =?iso-8859-1?Q?uaFJHlTQ7pFakboEF0RiI33QNtIKolHafViY/mV4PKMZtXWOwwXok0NM3i?=
 =?iso-8859-1?Q?L9bqlD1raMG0HBd3ota0hAaVcRWN9K+q1A/SCzHYRDtcSW2yXzWlKHud/o?=
 =?iso-8859-1?Q?YKEzGW1obgWjCbJj16+0pCwT58bf7oith2UF9gak5Kbx06YWIvaSL+60MS?=
 =?iso-8859-1?Q?Dj0OJGGGLpJp+5YTzi/Fq64rEWagv8PQbYcynfbcWGeGNjm3jdsD5u6yhq?=
 =?iso-8859-1?Q?WsCyllss8WqufnPNGzWqP7LAfLd9IVrtx5g1jLq5FVwcQS6uTCAbb+Aw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62369a7c-18ce-488e-9580-08dc9652ae04
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 02:41:44.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyXhGo53rfXqrnpiAce1l7hHOxv6r1zcKM5tdF6BOV6TGdqf3Mnr71Q3XzViCYZmzWDeqBdlGM+zltOp3ChX3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -33.7% regression of unixbench.throughput on:


commit: d042dae6ad74df8a00ee8a3c6b77b53bc9e32f64 ("lockref: speculatively spin waiting for the lock to be released")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: unixbench
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: shell1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.getdent.ops_per_sec -56.5% regression                                |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | disk=1HDD                                                                                 |
|                  | fs=ext4                                                                                   |
|                  | nr_threads=100%                                                                           |
|                  | test=getdent                                                                              |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.getdent.ops_per_sec -54.6% regression                                |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | disk=1HDD                                                                                 |
|                  | fs=xfs                                                                                    |
|                  | nr_threads=100%                                                                           |
|                  | test=getdent                                                                              |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.handle.ops_per_sec -60.2% regression                                 |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                              |
|                  | disk=1HDD                                                                                 |
|                  | fs=btrfs                                                                                  |
|                  | nr_threads=100%                                                                           |
|                  | test=handle                                                                               |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406270912.633e6c61-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240627/202406270912.633e6c61-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp9/shell1/unixbench

commit: 
  267574dee6 ("bcachefs: remove now spurious i_state initialization")
  d042dae6ad ("lockref: speculatively spin waiting for the lock to be released")

267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     66668 ± 21%     -42.2%      38533 ± 38%  numa-meminfo.node1.Mapped
     18895           -16.6%      15755        uptime.idle
 1.694e+10           -19.3%  1.368e+10        cpuidle..time
  1.73e+08           -34.6%  1.131e+08        cpuidle..usage
   2519063           -10.4%    2257044        meminfo.Active
   2518692           -10.4%    2256964        meminfo.Active(anon)
     98218 ±  3%     -14.3%      84210        meminfo.Mapped
   2632805           -10.8%    2348382        meminfo.Shmem
 4.637e+08           -33.5%  3.083e+08        numa-numastat.node0.local_node
 4.638e+08           -33.5%  3.083e+08        numa-numastat.node0.numa_hit
 4.623e+08           -33.4%  3.078e+08        numa-numastat.node1.local_node
 4.624e+08           -33.4%  3.078e+08        numa-numastat.node1.numa_hit
     42.33           -19.7%      33.98        vmstat.cpu.id
     38.88 ±  2%     +19.5%      46.46 ±  2%  vmstat.procs.r
    598112           -31.3%     410958        vmstat.system.cs
    339581           -24.9%     255122        vmstat.system.in
 4.637e+08           -33.5%  3.083e+08        numa-vmstat.node0.numa_hit
 4.637e+08           -33.5%  3.083e+08        numa-vmstat.node0.numa_local
     16902 ± 22%     -41.4%       9904 ± 38%  numa-vmstat.node1.nr_mapped
 4.623e+08           -33.4%  3.078e+08        numa-vmstat.node1.numa_hit
 4.623e+08           -33.4%  3.078e+08        numa-vmstat.node1.numa_local
      3589 ±  2%     -21.5%       2817        perf-c2c.DRAM.local
     23348           -13.7%      20144        perf-c2c.DRAM.remote
     21000           -12.5%      18378        perf-c2c.HITM.local
     15566           -15.1%      13213        perf-c2c.HITM.remote
     36567           -13.6%      31591        perf-c2c.HITM.total
     42.20            -8.4       33.82        mpstat.cpu.all.idle%
      0.00 ± 40%      -0.0        0.00 ± 46%  mpstat.cpu.all.iowait%
      0.94            -0.2        0.72        mpstat.cpu.all.irq%
      0.58            -0.1        0.44        mpstat.cpu.all.soft%
     48.63           +11.3       59.91        mpstat.cpu.all.sys%
      7.66            -2.5        5.11        mpstat.cpu.all.usr%
     63.66           +12.8%      71.79        mpstat.max_utilization_pct
     32070           -33.7%      21253        unixbench.score
    135979           -33.7%      90114        unixbench.throughput
   8158942           -25.3%    6093181        unixbench.time.involuntary_context_switches
    290307 ±  3%     -45.0%     159813 ±  3%  unixbench.time.major_page_faults
 1.151e+09           -33.6%  7.644e+08        unixbench.time.minor_page_faults
      3513           +16.5%       4092        unixbench.time.percent_of_cpu_this_job_got
     17556           +34.0%      23525        unixbench.time.system_time
      4600           -50.2%       2290        unixbench.time.user_time
  1.87e+08           -26.4%  1.377e+08        unixbench.time.voluntary_context_switches
  85735355           -33.7%   56816908        unixbench.workload
    629615           -10.4%     564266        proc-vmstat.nr_active_anon
   1444170            -5.0%    1372570        proc-vmstat.nr_file_pages
    208895            -2.6%     203360        proc-vmstat.nr_inactive_anon
     24755 ±  3%     -14.4%      21183        proc-vmstat.nr_mapped
    658148           -10.8%     587129        proc-vmstat.nr_shmem
     26716            -1.3%      26369        proc-vmstat.nr_slab_reclaimable
     47823            -2.1%      46838        proc-vmstat.nr_slab_unreclaimable
    629615           -10.4%     564266        proc-vmstat.nr_zone_active_anon
    208896            -2.7%     203360        proc-vmstat.nr_zone_inactive_anon
 9.261e+08           -33.5%  6.161e+08        proc-vmstat.numa_hit
  9.26e+08           -33.5%  6.161e+08        proc-vmstat.numa_local
    637452            -8.6%     582748        proc-vmstat.pgactivate
 1.644e+09           -33.5%  1.093e+09        proc-vmstat.pgalloc_normal
 1.154e+09           -33.5%  7.669e+08        proc-vmstat.pgfault
 1.643e+09           -33.5%  1.092e+09        proc-vmstat.pgfree
  56834055           -33.4%   37832459        proc-vmstat.pgreuse
   1352648           -33.5%     898973        proc-vmstat.thp_fault_alloc
  18937408           -33.5%   12585970        proc-vmstat.unevictable_pgs_culled
      3.37            -3.3%       3.26        perf-stat.i.MPKI
 1.367e+10           -26.4%  1.006e+10        perf-stat.i.branch-instructions
      1.65            -0.1        1.54        perf-stat.i.branch-miss-rate%
 2.225e+08           -31.8%  1.517e+08        perf-stat.i.branch-misses
     22.57            +0.6       23.19        perf-stat.i.cache-miss-rate%
 2.309e+08           -30.4%  1.607e+08        perf-stat.i.cache-misses
  1.01e+09           -32.4%  6.832e+08        perf-stat.i.cache-references
    600019           -31.3%     412413        perf-stat.i.context-switches
      2.03           +54.9%       3.14        perf-stat.i.cpi
 1.388e+11           +12.2%  1.558e+11        perf-stat.i.cpu-cycles
    149359           -41.6%      87198        perf-stat.i.cpu-migrations
    607.93           +58.6%     964.42        perf-stat.i.cycles-between-cache-misses
 6.741e+10           -28.0%  4.856e+10        perf-stat.i.instructions
      0.50           -33.4%       0.33        perf-stat.i.ipc
    459.84 ±  3%     -45.0%     252.95 ±  3%  perf-stat.i.major-faults
     67.57           -33.6%      44.90        perf-stat.i.metric.K/sec
   1788636           -33.6%    1187710        perf-stat.i.minor-faults
   1789096           -33.6%    1187963        perf-stat.i.page-faults
      3.42           -19.4%       2.76 ± 44%  perf-stat.overall.MPKI
      1.63            -0.4        1.26 ± 44%  perf-stat.overall.branch-miss-rate%
      0.49           -46.3%       0.26 ± 44%  perf-stat.overall.ipc
 1.365e+10           -38.5%  8.401e+09 ± 44%  perf-stat.ps.branch-instructions
 2.221e+08           -42.9%  1.268e+08 ± 44%  perf-stat.ps.branch-misses
 2.305e+08           -41.7%  1.343e+08 ± 44%  perf-stat.ps.cache-misses
 1.009e+09           -43.3%  5.714e+08 ± 44%  perf-stat.ps.cache-references
    598981           -42.5%     344546 ± 44%  perf-stat.ps.context-switches
    149116           -51.1%      72968 ± 44%  perf-stat.ps.cpu-migrations
 6.731e+10           -39.8%  4.055e+10 ± 44%  perf-stat.ps.instructions
    459.54 ±  3%     -54.1%     211.13 ± 44%  perf-stat.ps.major-faults
   1785795           -44.4%     992658 ± 44%  perf-stat.ps.minor-faults
   1786254           -44.4%     992869 ± 44%  perf-stat.ps.page-faults
 4.252e+13           -39.7%  2.562e+13 ± 44%  perf-stat.total.instructions
  12248217           +18.2%   14471390        sched_debug.cfs_rq:/.avg_vruntime.avg
  13350177 ±  2%     +15.0%   15350925        sched_debug.cfs_rq:/.avg_vruntime.max
  11977215           +18.2%   14153258        sched_debug.cfs_rq:/.avg_vruntime.min
      0.60 ±  4%     +23.0%       0.74 ±  3%  sched_debug.cfs_rq:/.h_nr_running.avg
   1255909 ± 22%     -41.9%     730155 ± 49%  sched_debug.cfs_rq:/.left_deadline.stddev
   1255900 ± 22%     -41.9%     730149 ± 49%  sched_debug.cfs_rq:/.left_vruntime.stddev
     25775 ± 14%     -31.9%      17541 ± 24%  sched_debug.cfs_rq:/.load.avg
    111073 ± 20%     -48.6%      57125 ± 57%  sched_debug.cfs_rq:/.load.stddev
     72.86 ±  4%     -23.0%      56.07 ± 11%  sched_debug.cfs_rq:/.load_avg.avg
     13.98 ±  4%     -17.7%      11.52 ±  5%  sched_debug.cfs_rq:/.load_avg.min
    167.77 ±  7%     -20.9%     132.67 ± 19%  sched_debug.cfs_rq:/.load_avg.stddev
  12248217           +18.2%   14471390        sched_debug.cfs_rq:/.min_vruntime.avg
  13350177 ±  2%     +15.0%   15350925        sched_debug.cfs_rq:/.min_vruntime.max
  11977215           +18.2%   14153258        sched_debug.cfs_rq:/.min_vruntime.min
      0.56 ±  4%     +13.3%       0.63 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
     33.64 ±  9%     -31.9%      22.91 ± 25%  sched_debug.cfs_rq:/.removed.load_avg.avg
    152.13 ±  9%     -22.1%     118.47 ± 23%  sched_debug.cfs_rq:/.removed.load_avg.stddev
   1255900 ± 22%     -41.9%     730149 ± 49%  sched_debug.cfs_rq:/.right_vruntime.stddev
     95.73 ±  4%     +38.2%     132.32 ±  3%  sched_debug.cfs_rq:/.util_est.avg
    514.30 ±  4%     +21.0%     622.26 ±  9%  sched_debug.cfs_rq:/.util_est.max
    126.26 ±  3%     +14.4%     144.47 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
    157210 ±  2%     +19.3%     187543        sched_debug.cpu.avg_idle.avg
     38689 ± 11%     +45.3%      56231 ±  4%  sched_debug.cpu.avg_idle.min
   1131966 ±  3%     +13.6%    1285770        sched_debug.cpu.curr->pid.avg
      0.61 ±  4%     +23.0%       0.75 ±  3%  sched_debug.cpu.nr_running.avg
   2807835           -31.2%    1931685        sched_debug.cpu.nr_switches.avg
   2868532           -31.3%    1970626        sched_debug.cpu.nr_switches.max
   2711163           -31.1%    1866782        sched_debug.cpu.nr_switches.min
     31518 ± 11%     -36.8%      19934 ± 21%  sched_debug.cpu.nr_switches.stddev
      0.88 ± 14%     -29.6%       0.62 ± 14%  sched_debug.cpu.nr_uninterruptible.avg
     50293 ± 22%     -71.2%      14501 ± 18%  sched_debug.cpu.nr_uninterruptible.max
    -43562           -52.2%     -20815        sched_debug.cpu.nr_uninterruptible.min
     19392 ± 13%     -63.2%       7134 ±  9%  sched_debug.cpu.nr_uninterruptible.stddev
      7.02 ±  4%      -4.1        2.92 ±  7%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.00 ±  4%      -4.1        2.91 ±  7%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.96 ±  4%      -4.1        2.88 ±  7%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.89 ±  4%      -4.0        2.84 ±  7%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      7.34            -3.7        3.64 ±  6%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.86            -3.5        3.31        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      6.84            -3.5        3.30        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      7.94            -3.5        4.44        perf-profile.calltrace.cycles-pp.execve
      7.93            -3.5        4.44        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      7.93            -3.5        4.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      7.92            -3.5        4.44        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      7.92            -3.5        4.43        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      6.72            -3.5        3.26        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      4.60 ±  8%      -2.8        1.84 ±  7%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff
      6.78            -2.7        4.03        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      4.56 ±  4%      -2.7        1.86 ±  7%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      5.32            -2.7        2.63 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      5.32            -2.7        2.64 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.30            -2.7        2.62 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      6.54            -2.6        3.92        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.54            -2.6        3.92        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.54            -2.6        3.92        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.24            -2.5        3.71        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      6.21            -2.5        3.70        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.68            -2.3        3.38        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      5.47            -2.2        3.26        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.84            -2.0        2.80 ±  2%  perf-profile.calltrace.cycles-pp.common_startup_64
      4.77            -2.0        2.76 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      4.76            -2.0        2.75 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      4.76            -2.0        2.75 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      2.92 ±  4%      -1.7        1.20 ±  7%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      4.09            -1.7        2.38 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      3.80            -1.6        2.22 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      3.79            -1.6        2.21 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.76            -1.6        2.19 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      3.37 ±  6%      -1.6        1.80 ±  2%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.65            -1.5        2.12 ±  2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.49 ±  5%      -1.5        0.96 ±  8%  perf-profile.calltrace.cycles-pp.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      3.04            -1.4        1.60 ±  2%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      3.61            -1.4        2.19        perf-profile.calltrace.cycles-pp._Fork
      2.18 ±  5%      -1.4        0.78 ± 10%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      2.15 ±  5%      -1.4        0.77 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma.do_vmi_align_munmap
      2.88            -1.4        1.51        perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      2.13 ±  5%      -1.4        0.76 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare.__split_vma
      2.25            -1.4        0.88 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.21            -1.3        0.87 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      2.15 ±  4%      -1.3        0.84 ±  4%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
      1.91 ±  5%      -1.3        0.64 ± 11%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.vma_prepare
      2.62            -1.3        1.36 ±  2%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      3.22            -1.3        1.96        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      3.22            -1.3        1.96 ±  2%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      3.22            -1.3        1.96 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      3.22            -1.3        1.96 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      2.61            -1.3        1.35 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      1.60 ±  4%      -1.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      1.90            -1.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      2.25 ±  2%      -1.1        1.11 ±  3%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      1.40 ±  4%      -1.1        0.28 ±100%  perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region
      1.37 ±  4%      -1.1        0.27 ±100%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.35 ±  4%      -1.1        0.26 ±100%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.unmap_region.do_vmi_align_munmap
      1.99 ±  2%      -1.0        0.96 ±  3%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      3.48 ±  3%      -1.0        2.45 ±  2%  perf-profile.calltrace.cycles-pp.dput.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      2.44            -1.0        1.43 ±  2%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      3.45 ±  3%      -1.0        2.44 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.d_alloc_parallel.__lookup_slow.walk_component
      1.54 ±  4%      -1.0        0.59 ±  8%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.mmap_region.do_mmap
      3.19 ± 12%      -0.9        2.24 ± 11%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk.path_openat
      3.34 ±  3%      -0.9        2.42 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel.__lookup_slow
      3.33 ± 11%      -0.9        2.42 ± 10%  perf-profile.calltrace.cycles-pp.down_read.walk_component.link_path_walk.path_openat.do_filp_open
      2.14            -0.9        1.25        perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.02            -0.9        1.16 ±  2%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      3.22 ±  3%      -0.9        2.36 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.d_alloc_parallel
      2.04            -0.8        1.19 ±  2%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.00 ±  2%      -0.7        0.25 ±100%  perf-profile.calltrace.cycles-pp.__split_vma.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect
      1.66            -0.7        0.95 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.94            -0.7        0.26 ±100%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      1.02 ±  2%      -0.7        0.35 ± 70%  perf-profile.calltrace.cycles-pp.vma_modify.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64
      1.57            -0.7        0.90 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      2.68 ± 13%      -0.6        2.04 ± 12%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component.link_path_walk
      2.68 ± 13%      -0.6        2.03 ± 12%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      2.66 ± 13%      -0.6        2.02 ± 12%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      1.29            -0.6        0.67 ±  2%  perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.29            -0.6        0.67 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.06            -0.6        1.46 ±  3%  perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_lookupat.filename_lookup
      1.43            -0.6        0.87        perf-profile.calltrace.cycles-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.97            -0.6        1.41 ±  3%  perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_lookupat
      1.14            -0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.mprotect_fixup.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.40            -0.6        0.85        perf-profile.calltrace.cycles-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.11 ±  2%      -0.5        0.58 ±  2%  perf-profile.calltrace.cycles-pp.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.96            -0.5        0.43 ± 44%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.11 ±  2%      -0.5        0.58 ±  2%  perf-profile.calltrace.cycles-pp.elf_load.load_elf_interp.load_elf_binary.search_binary_handler.exec_binprm
      1.29            -0.5        0.78        perf-profile.calltrace.cycles-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      1.18 ±  2%      -0.5        0.69 ±  2%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.12            -0.5        0.62        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.11            -0.5        0.62 ±  2%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.07 ±  2%      -0.5        0.62 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.90 ±  2%      -0.4        0.52        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      1.16            -0.2        1.01        perf-profile.calltrace.cycles-pp.open64
      1.14            -0.1        0.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      1.12            -0.1        0.98        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.13            -0.1        0.99        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      1.12            -0.1        0.98        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.91            -0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.unlinkat
      0.90            -0.1        0.78        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.90            -0.1        0.78        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlinkat
      0.90            -0.1        0.78        perf-profile.calltrace.cycles-pp.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.89            -0.1        0.78 ±  2%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlinkat.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlinkat
      0.88            -0.1        0.79 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_lookupat
      3.18            +0.1        3.30 ±  3%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.53 ±  3%      +0.2        0.68 ±  3%  perf-profile.calltrace.cycles-pp.fstatat64
      0.70 ±  3%      +0.2        0.88        perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.54 ±  3%      +0.2        0.73        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups.path_openat
      0.68 ±  3%      +0.2        0.87        perf-profile.calltrace.cycles-pp.d_alloc_parallel.lookup_open.open_last_lookups.path_openat.do_filp_open
      0.44 ± 44%      +0.3        0.71        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open.open_last_lookups
      0.54 ±  3%      +0.3        0.87 ±  2%  perf-profile.calltrace.cycles-pp.dput.step_into.open_last_lookups.path_openat.do_filp_open
      0.54 ±  2%      +0.3        0.88 ±  2%  perf-profile.calltrace.cycles-pp.step_into.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.54 ±  2%      +0.3        0.87 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.open_last_lookups.path_openat
      0.35 ± 70%      +0.3        0.70 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.lookup_open
      0.44 ± 44%      +0.4        0.86 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.open_last_lookups
      0.77 ±  4%      +0.4        1.20 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.75 ±  4%      +0.4        1.18 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      0.75 ±  4%      +0.4        1.18 ±  2%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
      0.75 ±  4%      +0.4        1.18 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      3.69            +0.5        4.16 ±  3%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.17 ±141%      +0.5        0.66 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.17 ±141%      +0.5        0.66 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      0.08 ±223%      +0.6        0.65 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +0.6        0.62 ±  7%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.path_put.exit_fs
      0.00            +0.6        0.62 ±  7%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.path_put.exit_fs.do_exit
      0.00            +0.6        0.63 ±  3%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      1.06            +0.7        1.80 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_lookupat.filename_lookup
      3.28            +0.8        4.03        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +0.8        0.76 ±  6%  perf-profile.calltrace.cycles-pp.dput.path_put.exit_fs.do_exit.do_group_exit
      0.00            +0.8        0.76 ±  6%  perf-profile.calltrace.cycles-pp.path_put.exit_fs.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +0.8        0.77 ±  6%  perf-profile.calltrace.cycles-pp.exit_fs.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.04            +0.8        1.82 ±  4%  perf-profile.calltrace.cycles-pp.terminate_walk.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      1.04            +0.8        1.81 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_lookupat.filename_lookup.vfs_statx
      0.00            +0.8        0.79 ±  3%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_lookupat
      0.84            +0.8        1.65 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_lookupat
      0.00            +0.8        0.81 ±  4%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_lookupat.filename_lookup
      0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_lookupat.filename_lookup.vfs_statx
      0.00            +1.0        0.97 ±  3%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_lookupat.filename_lookup
      5.11            +1.2        6.29 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.07            +1.2        6.26 ±  3%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.94            +1.2        6.19 ±  3%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      4.92            +1.3        6.18 ±  3%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      4.95            +1.8        6.80 ±  2%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.82 ±  3%      +2.2       14.02        perf-profile.calltrace.cycles-pp.__lookup_slow.walk_component.link_path_walk.path_openat.do_filp_open
     11.60 ±  3%      +2.3       13.89        perf-profile.calltrace.cycles-pp.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.path_openat
      9.03 ±  3%      +2.8       11.86        perf-profile.calltrace.cycles-pp.d_alloc.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk
      8.52 ±  3%      +2.9       11.40        perf-profile.calltrace.cycles-pp._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow.walk_component
      8.19 ±  3%      +2.9       11.08        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.d_alloc.d_alloc_parallel.__lookup_slow
      0.00            +3.7        3.71        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      7.87 ±  3%      +3.9       11.77 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      8.00 ±  3%      +4.0       11.98        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      8.44 ±  3%      +4.8       13.24 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      5.43 ±  2%      +4.9       10.36        perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      8.48 ±  3%      +4.9       13.42 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      5.40 ±  2%      +4.9       10.34        perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      5.29 ±  2%      +5.0       10.31 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dput.step_into.link_path_walk.path_openat
      5.08 ±  2%      +5.8       10.88        perf-profile.calltrace.cycles-pp._raw_spin_lock.__dentry_kill.dput.step_into.link_path_walk
      5.34 ±  5%      +6.0       11.34        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__dentry_kill.dput.step_into
      7.11 ±  3%      +6.7       13.85        perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      6.81 ±  3%      +6.8       13.65        perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      7.64 ±  2%      +7.6       15.29        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      7.52 ±  2%      +7.7       15.17        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
     22.42            +8.0       30.41        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      8.72 ±  3%      +8.5       17.21        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      8.70 ±  3%      +8.5       17.19        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
     27.98           +12.9       40.85        perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     64.52           +13.7       78.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     64.49           +13.7       78.19        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.14           +21.4       62.52        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.12           +21.4       62.50        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.64           +21.5       63.13        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.58           +21.5       63.10        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      9.86 ±  4%      -6.4        3.51 ±  8%  perf-profile.children.cycles-pp.down_write
      9.25 ±  5%      -6.1        3.17 ±  9%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      8.92 ±  5%      -5.9        2.98 ±  9%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      7.58 ±  5%      -5.3        2.33 ± 11%  perf-profile.children.cycles-pp.osq_lock
      9.01 ±  3%      -5.1        3.95 ±  5%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      8.89 ±  3%      -5.0        3.89 ±  5%  perf-profile.children.cycles-pp.do_mmap
      8.73 ±  3%      -4.9        3.79 ±  6%  perf-profile.children.cycles-pp.mmap_region
      8.30            -4.1        4.16 ±  2%  perf-profile.children.cycles-pp.__mmput
      8.26            -4.1        4.14 ±  2%  perf-profile.children.cycles-pp.exit_mmap
      7.02 ±  4%      -4.1        2.92 ±  7%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      9.04            -4.0        5.06        perf-profile.children.cycles-pp.__x64_sys_execve
      9.77            -4.0        5.79        perf-profile.children.cycles-pp.asm_exc_page_fault
      9.03            -4.0        5.05        perf-profile.children.cycles-pp.do_execveat_common
      8.85            -3.6        5.24        perf-profile.children.cycles-pp.exc_page_fault
      8.81            -3.6        5.21        perf-profile.children.cycles-pp.do_user_addr_fault
      7.94            -3.5        4.44        perf-profile.children.cycles-pp.execve
      6.04 ±  3%      -3.4        2.62 ±  6%  perf-profile.children.cycles-pp.do_vmi_munmap
      5.92 ±  3%      -3.4        2.54 ±  6%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      8.29            -3.4        4.91        perf-profile.children.cycles-pp.handle_mm_fault
      7.40            -3.3        4.07        perf-profile.children.cycles-pp.bprm_execve
      7.96            -3.2        4.71        perf-profile.children.cycles-pp.__handle_mm_fault
      5.30 ±  3%      -3.2        2.08 ±  6%  perf-profile.children.cycles-pp.free_pgtables
      6.85            -3.1        3.76        perf-profile.children.cycles-pp.exec_binprm
      6.84            -3.1        3.75        perf-profile.children.cycles-pp.search_binary_handler
      6.72            -3.0        3.68        perf-profile.children.cycles-pp.load_elf_binary
      4.22 ±  4%      -2.8        1.45 ±  8%  perf-profile.children.cycles-pp.unlink_file_vma
      5.34            -2.7        2.65 ±  2%  perf-profile.children.cycles-pp.exit_mm
      6.67            -2.7        4.00        perf-profile.children.cycles-pp.__x64_sys_exit_group
      6.67            -2.7        4.00        perf-profile.children.cycles-pp.do_group_exit
      6.66            -2.7        3.99        perf-profile.children.cycles-pp.do_exit
      4.22 ±  3%      -2.3        1.87 ±  5%  perf-profile.children.cycles-pp.__split_vma
      3.63 ±  4%      -2.2        1.43 ±  7%  perf-profile.children.cycles-pp.vma_prepare
      4.84            -2.0        2.80 ±  2%  perf-profile.children.cycles-pp.do_idle
      4.84            -2.0        2.80 ±  2%  perf-profile.children.cycles-pp.common_startup_64
      4.84            -2.0        2.80 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      4.77            -2.0        2.76 ±  2%  perf-profile.children.cycles-pp.start_secondary
      4.16            -1.7        2.42 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      3.94            -1.6        2.30 ±  2%  perf-profile.children.cycles-pp.do_fault
      3.44            -1.6        1.80        perf-profile.children.cycles-pp.begin_new_exec
      3.86            -1.6        2.26 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      3.85            -1.6        2.24 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.28            -1.6        1.71        perf-profile.children.cycles-pp.exec_mmap
      4.14            -1.6        2.58        perf-profile.children.cycles-pp.kernel_clone
      3.71            -1.6        2.16 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      3.70            -1.5        2.15 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
      3.78            -1.5        2.30        perf-profile.children.cycles-pp.__do_sys_clone
      2.49 ±  3%      -1.5        1.04 ±  6%  perf-profile.children.cycles-pp.unmap_region
      3.64            -1.4        2.21        perf-profile.children.cycles-pp._Fork
      3.43            -1.4        2.00        perf-profile.children.cycles-pp.do_read_fault
      3.34            -1.4        1.95        perf-profile.children.cycles-pp.filemap_map_pages
      3.67            -1.4        2.30        perf-profile.children.cycles-pp.copy_process
      2.65 ±  2%      -1.4        1.29 ±  3%  perf-profile.children.cycles-pp.dup_mm
      4.43 ± 12%      -1.3        3.16 ± 11%  perf-profile.children.cycles-pp.__schedule
      2.34 ±  2%      -1.2        1.12 ±  3%  perf-profile.children.cycles-pp.dup_mmap
      2.74            -1.2        1.59        perf-profile.children.cycles-pp.unmap_vmas
      2.54            -1.1        1.47        perf-profile.children.cycles-pp.unmap_page_range
      2.48            -1.0        1.43        perf-profile.children.cycles-pp.zap_pmd_range
      3.46 ± 12%      -1.0        2.42 ± 11%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      2.43            -1.0        1.41        perf-profile.children.cycles-pp.zap_pte_range
      2.59            -1.0        1.57        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      3.64 ± 11%      -1.0        2.63 ± 10%  perf-profile.children.cycles-pp.down_read
      3.67 ± 13%      -1.0        2.71 ± 12%  perf-profile.children.cycles-pp.schedule
      2.29            -1.0        1.33        perf-profile.children.cycles-pp.kmem_cache_free
      2.15            -0.9        1.20 ±  2%  perf-profile.children.cycles-pp.elf_load
      2.10            -0.9        1.21 ±  2%  perf-profile.children.cycles-pp.zap_present_ptes
      1.95 ±  2%      -0.8        1.13        perf-profile.children.cycles-pp.next_uptodate_folio
      3.10 ± 13%      -0.8        2.31 ± 12%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      1.66            -0.7        0.91        perf-profile.children.cycles-pp.tlb_finish_mmu
      1.76            -0.7        1.08        perf-profile.children.cycles-pp.clear_page_erms
      1.48            -0.7        0.80        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      1.47            -0.7        0.80 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      1.54            -0.6        0.92 ±  2%  perf-profile.children.cycles-pp.up_write
      1.29            -0.6        0.67 ±  3%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      1.29            -0.6        0.67 ±  3%  perf-profile.children.cycles-pp.do_mprotect_pkey
      1.11 ±  3%      -0.6        0.52 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.50            -0.6        0.91        perf-profile.children.cycles-pp.handle_softirqs
      1.24 ±  2%      -0.6        0.66 ±  2%  perf-profile.children.cycles-pp.load_elf_interp
      1.43            -0.6        0.87        perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
      1.15            -0.6        0.58 ±  3%  perf-profile.children.cycles-pp.mprotect_fixup
      1.20 ±  3%      -0.6        0.65 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.41            -0.6        0.86        perf-profile.children.cycles-pp.clear_huge_page
      1.32            -0.6        0.77 ±  2%  perf-profile.children.cycles-pp.rcu_core
      1.28            -0.5        0.74 ±  2%  perf-profile.children.cycles-pp.rcu_do_batch
      1.18            -0.5        0.64        perf-profile.children.cycles-pp.folios_put_refs
      1.35            -0.5        0.81        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.02 ±  2%      -0.5        0.51 ±  3%  perf-profile.children.cycles-pp.vma_modify
      1.32            -0.5        0.80        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      1.08 ±  3%      -0.5        0.57 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      1.26            -0.5        0.77 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      1.80 ±  2%      -0.5        1.32 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.19            -0.4        0.74        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.88 ±  4%      -0.4        0.46 ±  4%  perf-profile.children.cycles-pp.kthread
      1.00 ±  2%      -0.4        0.58 ±  2%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.92            -0.4        0.51 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.96            -0.4        0.54 ±  2%  perf-profile.children.cycles-pp.__vm_munmap
      1.02            -0.4        0.61        perf-profile.children.cycles-pp.select_task_rq_fair
      1.61            -0.4        1.19 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.98            -0.4        0.59        perf-profile.children.cycles-pp.wp_page_copy
      0.73 ±  4%      -0.4        0.36 ±  5%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.01            -0.4        0.64        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.99            -0.4        0.62        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.92            -0.4        0.56 ±  2%  perf-profile.children.cycles-pp.do_anonymous_page
      0.98            -0.4        0.62 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.92            -0.4        0.56        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.82            -0.4        0.46        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.79            -0.4        0.43        perf-profile.children.cycles-pp.alloc_empty_file
      0.94            -0.3        0.59 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.90            -0.3        0.56        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.55 ±  4%      -0.3        0.22 ±  6%  perf-profile.children.cycles-pp.vma_expand
      0.82            -0.3        0.50 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      1.02            -0.3        0.71        perf-profile.children.cycles-pp.irq_exit_rcu
      0.82 ±  2%      -0.3        0.52        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.83            -0.3        0.52 ±  2%  perf-profile.children.cycles-pp.wake_up_q
      0.77            -0.3        0.47        perf-profile.children.cycles-pp.__d_lookup_rcu
      0.74            -0.3        0.44        perf-profile.children.cycles-pp.copy_strings
      0.69            -0.3        0.40 ±  2%  perf-profile.children.cycles-pp.vma_complete
      0.51 ±  2%      -0.3        0.22 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.79 ±  2%      -0.3        0.51 ±  2%  perf-profile.children.cycles-pp.activate_task
      0.61            -0.3        0.34 ±  3%  perf-profile.children.cycles-pp._compound_head
      0.76 ±  2%      -0.3        0.49        perf-profile.children.cycles-pp.ttwu_do_activate
      0.64            -0.3        0.37 ±  3%  perf-profile.children.cycles-pp.mm_init
      0.62            -0.3        0.36 ±  2%  perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.39 ± 17%      -0.3        0.14 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.52 ±  2%      -0.3        0.27 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.53 ±  2%      -0.2        0.28        perf-profile.children.cycles-pp.init_file
      0.54 ±  3%      -0.2        0.29 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.56            -0.2        0.31 ±  2%  perf-profile.children.cycles-pp.finish_task_switch
      0.55            -0.2        0.31 ±  2%  perf-profile.children.cycles-pp.__mmdrop
      0.57            -0.2        0.33 ±  2%  perf-profile.children.cycles-pp.copy_page_range
      0.70 ±  4%      -0.2        0.47 ±  3%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.68 ±  3%      -0.2        0.45        perf-profile.children.cycles-pp.enqueue_task_fair
      0.58            -0.2        0.34        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.55            -0.2        0.32 ±  2%  perf-profile.children.cycles-pp.copy_p4d_range
      0.56            -0.2        0.34        perf-profile.children.cycles-pp.mod_objcg_state
      0.54            -0.2        0.32 ±  2%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.66 ±  3%      -0.2        0.44 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.54            -0.2        0.32 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.51 ±  2%      -0.2        0.30        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.56 ±  4%      -0.2        0.34 ±  4%  perf-profile.children.cycles-pp.wait4
      0.52            -0.2        0.31 ±  3%  perf-profile.children.cycles-pp.alloc_bprm
      0.44 ±  2%      -0.2        0.23        perf-profile.children.cycles-pp.security_file_alloc
      0.56            -0.2        0.35 ±  2%  perf-profile.children.cycles-pp._IO_default_xsputn
      0.52            -0.2        0.31        perf-profile.children.cycles-pp.mas_store_prealloc
      0.54            -0.2        0.33 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap
      0.51            -0.2        0.30 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      0.52 ±  2%      -0.2        0.32 ±  3%  perf-profile.children.cycles-pp._IO_fwrite
      0.52            -0.2        0.32        perf-profile.children.cycles-pp.perf_event_mmap_event
      0.55 ±  3%      -0.2        0.34 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
      0.45            -0.2        0.25 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.54 ±  3%      -0.2        0.34 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.52            -0.2        0.32        perf-profile.children.cycles-pp.native_irq_return_iret
      0.52 ±  5%      -0.2        0.32 ±  4%  perf-profile.children.cycles-pp.vfs_read
      0.48            -0.2        0.29        perf-profile.children.cycles-pp.sync_regs
      0.51            -0.2        0.32 ±  3%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.38            -0.2        0.19        perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.46 ±  2%      -0.2        0.27 ±  3%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.49 ±  2%      -0.2        0.31 ±  2%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.50 ±  5%      -0.2        0.32 ±  4%  perf-profile.children.cycles-pp.read
      0.46            -0.2        0.28        perf-profile.children.cycles-pp.__cond_resched
      0.48 ±  6%      -0.2        0.30 ±  5%  perf-profile.children.cycles-pp.kernel_wait4
      0.48 ±  6%      -0.2        0.30 ±  4%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.49 ±  5%      -0.2        0.31 ±  4%  perf-profile.children.cycles-pp.ksys_read
      0.42            -0.2        0.25        perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.44            -0.2        0.27        perf-profile.children.cycles-pp.strnlen_user
      0.41            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.__libc_early_init
      0.46 ±  6%      -0.2        0.29 ±  5%  perf-profile.children.cycles-pp.do_wait
      0.40            -0.2        0.23 ±  2%  perf-profile.children.cycles-pp.wake_up_new_task
      0.42 ±  2%      -0.2        0.25        perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.41            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.__libc_fork
      0.41            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.39 ±  2%      -0.2        0.22 ±  3%  perf-profile.children.cycles-pp.getname_flags
      0.41 ±  2%      -0.2        0.25        perf-profile.children.cycles-pp.get_arg_page
      0.39 ±  2%      -0.2        0.22 ±  3%  perf-profile.children.cycles-pp.sched_exec
      0.40            -0.2        0.23 ±  2%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.40            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.vm_area_dup
      0.40            -0.2        0.24 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.41            -0.2        0.26        perf-profile.children.cycles-pp.select_task_rq
      0.37            -0.2        0.22        perf-profile.children.cycles-pp.pcpu_alloc_noprof
      1.16            -0.2        1.01        perf-profile.children.cycles-pp.open64
      0.36 ±  2%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.35            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.pte_alloc_one
      0.35 ±  2%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.setup_arg_pages
      0.35            -0.1        0.21        perf-profile.children.cycles-pp.get_user_pages_remote
      0.36            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.create_elf_tables
      0.32            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.copy_pte_range
      0.34            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.__d_alloc
      0.34 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.__get_user_pages
      0.31            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.31            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.lru_add_drain
      0.25 ±  4%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.security_file_free
      0.33            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.dup_task_struct
      0.31            -0.1        0.18        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.34            -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.31            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.30 ±  2%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.rmqueue
      0.29 ±  3%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__call_rcu_common
      0.33 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.31 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__vm_area_free
      0.91            -0.1        0.79 ±  2%  perf-profile.children.cycles-pp.unlinkat
      0.24 ±  3%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.31            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.29 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.28            -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.30            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.34 ±  2%      -0.1        0.22        perf-profile.children.cycles-pp.write
      0.30 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.shift_arg_pages
      0.31 ±  2%      -0.1        0.19 ±  5%  perf-profile.children.cycles-pp.mas_find
      0.28 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__pte_alloc
      0.90            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.__x64_sys_unlinkat
      0.89            -0.1        0.78 ±  2%  perf-profile.children.cycles-pp.do_unlinkat
      0.26            -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.__do_wait
      0.29            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.50 ±  2%      -0.1        0.38        perf-profile.children.cycles-pp.fput
      0.28 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.28 ±  2%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.__perf_sw_event
      0.27 ±  2%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.strncpy_from_user
      0.29 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.29 ±  2%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.29 ±  3%      -0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__d_add
      0.28            -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.32            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.ksys_write
      0.27            -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.memset_orig
      0.28 ±  2%      -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.vm_area_alloc
      0.27 ±  2%      -0.1        0.16        perf-profile.children.cycles-pp.copy_string_kernel
      0.27 ±  2%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.58 ±  3%      -0.1        0.48 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.30 ±  2%      -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.simple_lookup
      0.26            -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.anon_vma_fork
      0.30            -0.1        0.20        perf-profile.children.cycles-pp.vfs_write
      0.26            -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.26 ±  2%      -0.1        0.15 ±  2%  perf-profile.children.cycles-pp.__close
      0.24 ±  2%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.25 ±  3%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__fput
      0.57 ±  4%      -0.1        0.47 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.28            -0.1        0.18 ±  2%  perf-profile.children.cycles-pp._IO_padn
      0.41 ±  2%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__vfork
      0.22 ±  3%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.23 ±  3%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.24 ±  3%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.filemap_read
      0.24            -0.1        0.14        perf-profile.children.cycles-pp.vmf_anon_prepare
      0.20 ±  2%      -0.1        0.10        perf-profile.children.cycles-pp.__page_cache_release
      0.23            -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
      0.23 ±  2%      -0.1        0.14 ±  2%  perf-profile.children.cycles-pp.__pmd_alloc
      0.23 ±  2%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.__check_object_size
      0.23 ±  2%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.free_unref_folios
      0.26            -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.22 ±  2%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.mas_preallocate
      0.20 ±  3%      -0.1        0.11        perf-profile.children.cycles-pp.___slab_alloc
      0.22            -0.1        0.13        perf-profile.children.cycles-pp.__anon_vma_prepare
      0.21 ±  4%      -0.1        0.12        perf-profile.children.cycles-pp.task_work_run
      0.20 ±  3%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.25            -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.up_read
      0.20            -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.21 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.do_open_execat
      0.16 ±  3%      -0.1        0.07 ±  6%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.20 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.wait_task_zombie
      0.37 ±  2%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.19 ±  2%      -0.1        0.11 ±  5%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.20            -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.20 ±  3%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      0.20 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.19 ±  2%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.19 ±  2%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.schedule_tail
      0.22            -0.1        0.14 ±  2%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.18 ±  2%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.17 ± 15%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.exit_notify
      0.18 ±  2%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.free_unref_page
      0.19 ±  2%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.flush_tlb_func
      0.20 ±  3%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__memcpy
      0.21            -0.1        0.13 ±  3%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.20 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.45 ±  3%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.19            -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.anon_vma_clone
      0.18 ±  2%      -0.1        0.10        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.18 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.select_idle_cpu
      0.19            -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__put_user_8
      0.18            -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__pud_alloc
      0.18 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__x64_sys_close
      0.19 ±  2%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.16 ±  3%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__do_fault
      0.22 ± 10%      -0.1        0.15 ± 10%  perf-profile.children.cycles-pp.pipe_read
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.20 ±  4%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.23 ±  3%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.update_curr
      0.18 ±  2%      -0.1        0.11        perf-profile.children.cycles-pp.__munmap
      0.16 ±  2%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
      0.16 ±  2%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.do_open
      0.42 ±  3%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.17 ±  3%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp._IO_file_xsputn
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__get_user_8
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__getrlimit
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.release_task
      0.18 ±  2%      -0.1        0.11 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.16 ±  3%      -0.1        0.09        perf-profile.children.cycles-pp.free_pgd_range
      0.16 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.15 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.free_p4d_range
      0.17            -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_commit_charge
      0.19            -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.16 ±  3%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.16 ±  3%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.get_free_pages_noprof
      0.16 ±  2%      -0.1        0.10        perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.16 ±  2%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.38 ±  4%      -0.1        0.32 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.14 ±  4%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.__ctype_init
      0.14            -0.1        0.08        perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.15 ±  2%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.pgd_alloc
      0.16 ±  2%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.move_page_tables
      0.17 ±  4%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.prepare_task_switch
      0.14 ±  2%      -0.1        0.08        perf-profile.children.cycles-pp.free_pud_range
      0.13 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__rb_erase_color
      0.14 ±  3%      -0.1        0.08        perf-profile.children.cycles-pp._exit
      0.14 ±  4%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.check_heap_object
      0.14 ±  4%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.14 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      0.14 ± 10%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.inode_permission
      0.14 ±  4%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.mas_split
      0.15 ±  3%      -0.1        0.09 ±  6%  perf-profile.children.cycles-pp.mas_next_slot
      0.15 ±  3%      -0.1        0.09        perf-profile.children.cycles-pp.strnlen
      0.14 ±  3%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.17 ±  6%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.13            -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.13 ±  3%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.13 ±  4%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.__put_anon_vma
      0.14 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__put_user_4
      0.17 ±  5%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.12 ±  3%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.14 ±  2%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.wake_affine
      0.14 ±  3%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp._copy_from_user
      0.12 ±  4%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.14 ±  3%      -0.1        0.09        perf-profile.children.cycles-pp.getenv
      0.13 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.08 ±  4%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.remove_vma
      0.14 ±  2%      -0.1        0.09        perf-profile.children.cycles-pp.__get_unmapped_area
      0.13 ±  3%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.down_read_trylock
      0.14 ±  2%      -0.1        0.09        perf-profile.children.cycles-pp.rcu_all_qs
      0.09 ±  5%      -0.1        0.04 ± 44%  perf-profile.children.cycles-pp.select_idle_core
      0.13            -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.do_notify_parent
      0.16 ±  3%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.generic_perform_write
      0.13 ±  3%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.12            -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.do_wp_page
      0.13 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.map_vdso
      0.14 ±  3%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.__free_one_page
      0.12            -0.0        0.07        perf-profile.children.cycles-pp.copy_page_to_iter
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.mas_store_gfp
      0.11 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.free_percpu
      0.13 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
      0.11 ±  3%      -0.0        0.06        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.07 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.11 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sched_move_task
      0.11            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      0.11            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.setlocale
      0.12 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.lru_add_fn
      0.14 ± 10%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.worker_thread
      0.13 ±  8%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.xas_load
      0.11 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__tunable_get_val@plt
      0.11 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.copy_present_ptes
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.finish_fault
      0.13 ±  2%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.open_exec
      0.07 ±  5%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.prepend_path
      0.10 ±  3%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.llist_add_batch
      0.11 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__install_special_mapping
      0.10            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.do_dentry_open
      0.10 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.put_cred_rcu
      0.08 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.vm_normal_page
      0.10 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.cfree
      0.10 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.getopt_long
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__exit_signal
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.filemap_fault
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.uncharge_batch
      0.11 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.15 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.12 ±  6%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.x64_sys_call
      0.12 ±  6%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.path_init
      0.10 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.10 ±  3%      -0.0        0.06        perf-profile.children.cycles-pp.__kernel_read
      0.11 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.10 ±  3%      -0.0        0.06        perf-profile.children.cycles-pp.__vsnprintf_chk
      0.10 ±  3%      -0.0        0.06        perf-profile.children.cycles-pp.handle_signal
      0.11 ± 11%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.xas_find
      0.09 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.prepare_creds
      0.09 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.strchrnul@plt
      0.10            -0.0        0.06        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.10            -0.0        0.06        perf-profile.children.cycles-pp.d_path
      0.10            -0.0        0.06        perf-profile.children.cycles-pp.do_faccessat
      0.10 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__close_nocancel
      0.07 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.__sigsuspend
      0.11 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.wakeup_preempt
      0.09 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.vma_interval_tree_augment_rotate
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.native_sched_clock
      0.12 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.10            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.handle_pte_fault
      0.10 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.user_path_at_empty
      0.11 ± 13%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.process_one_work
      0.08            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.10 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.brk
      0.10 ±  3%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.pipe_write
      0.09 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.evict
      0.09 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.malloc
      0.10 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.alloc_fd
      0.09            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.count
      0.09            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.expand_downwards
      0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.09 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__p4d_alloc
      0.10 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.kfree
      0.10            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.task_h_load
      0.09            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__snprintf_chk
      0.08 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.__wake_up
      0.09            -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.irqentry_enter
      0.09 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.seq_read_iter
      0.09 ±  4%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.seq_read
      0.08 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp._IO_setb
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.sched_clock
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.__do_sys_brk
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.can_modify_mm
      0.08 ±  5%      -0.0        0.05        perf-profile.children.cycles-pp.refill_obj_stock
      0.08 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.08 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__wake_up_common
      0.08 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.do_brk_flags
      0.09            -0.0        0.06        perf-profile.children.cycles-pp.__d_rehash
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.mas_wr_walk
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.__send_signal_locked
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.arch_dup_task_struct
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.copy_page
      0.08            -0.0        0.05        perf-profile.children.cycles-pp.folio_mark_accessed
      0.08 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.llist_reverse_order
      0.11 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.10 ±  8%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.ktime_get
      0.08 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.__wake_up_sync_key
      0.08 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.update_min_vruntime
      0.20 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.sched_tick
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.update_cfs_group
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.sched_balance_domains
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.main
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.run_builtin
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.__cmd_record
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.cmd_record
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.08 ± 13%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.__filename_parentat
      0.08 ± 10%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.path_parentat
      0.78 ±  2%      +0.1        0.92        perf-profile.children.cycles-pp.lookup_open
      0.54 ±  3%      +0.2        0.69 ±  3%  perf-profile.children.cycles-pp.fstatat64
      0.23 ± 10%      +0.2        0.46 ±  7%  perf-profile.children.cycles-pp.complete_walk
      0.24 ±  6%      +0.3        0.55 ±  2%  perf-profile.children.cycles-pp.copy_fs_struct
      0.24 ±  6%      +0.3        0.55 ±  2%  perf-profile.children.cycles-pp.lockref_get
      0.39 ± 18%      +0.4        0.77 ±  6%  perf-profile.children.cycles-pp.exit_fs
      0.48 ± 16%      +0.5        0.98 ±  5%  perf-profile.children.cycles-pp.path_put
      3.33            +0.7        4.06        perf-profile.children.cycles-pp.open_last_lookups
      5.32            +1.3        6.61 ±  3%  perf-profile.children.cycles-pp.filename_lookup
      5.30            +1.3        6.60 ±  3%  perf-profile.children.cycles-pp.path_lookupat
      5.59            +1.3        6.94 ±  2%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      5.51            +1.4        6.89 ±  2%  perf-profile.children.cycles-pp.vfs_fstatat
      5.36            +1.4        6.80 ±  2%  perf-profile.children.cycles-pp.vfs_statx
     14.06 ±  2%      +1.5       15.61        perf-profile.children.cycles-pp.__lookup_slow
     14.44 ±  2%      +1.8       16.29        perf-profile.children.cycles-pp.d_alloc_parallel
      9.68 ±  3%      +3.0       12.68        perf-profile.children.cycles-pp.d_alloc
      0.46            +4.5        4.96        perf-profile.children.cycles-pp.lockref_put_return
      9.84 ±  2%      +5.0       14.85        perf-profile.children.cycles-pp.__dentry_kill
      6.51 ±  2%      +5.6       12.14        perf-profile.children.cycles-pp.step_into
     80.87            +7.9       88.76        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      9.08 ±  2%      +7.9       16.98        perf-profile.children.cycles-pp.lookup_fast
     80.82            +7.9       88.73        perf-profile.children.cycles-pp.do_syscall_64
     25.94            +8.0       33.97        perf-profile.children.cycles-pp.walk_component
      9.11 ±  3%      +8.2       17.31        perf-profile.children.cycles-pp.lockref_get_not_dead
      8.84 ±  3%      +8.5       17.29        perf-profile.children.cycles-pp.try_to_unlazy
      8.82 ±  3%      +8.5       17.28        perf-profile.children.cycles-pp.__legitimize_path
      9.80 ±  2%      +9.2       19.05        perf-profile.children.cycles-pp.terminate_walk
     31.80           +13.3       45.09        perf-profile.children.cycles-pp.link_path_walk
     20.49 ±  2%     +14.7       35.22        perf-profile.children.cycles-pp.dput
     36.99 ±  3%     +16.9       53.91        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     38.51 ±  3%     +17.1       55.62        perf-profile.children.cycles-pp._raw_spin_lock
     42.28           +21.2       63.51        perf-profile.children.cycles-pp.__x64_sys_openat
     42.26           +21.2       63.50        perf-profile.children.cycles-pp.do_sys_openat2
     41.86           +21.4       63.26        perf-profile.children.cycles-pp.do_filp_open
     41.79           +21.4       63.22        perf-profile.children.cycles-pp.path_openat
      7.51 ±  5%      -5.2        2.30 ± 11%  perf-profile.self.cycles-pp.osq_lock
      1.82 ±  2%      -0.8        1.05        perf-profile.self.cycles-pp.next_uptodate_folio
      1.82            -0.7        1.08 ±  2%  perf-profile.self.cycles-pp.acpi_safe_halt
      1.74            -0.7        1.07        perf-profile.self.cycles-pp.clear_page_erms
      1.08 ±  2%      -0.6        0.49 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.99 ±  2%      -0.4        0.58 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.90            -0.4        0.50 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.82            -0.3        0.48 ±  2%  perf-profile.self.cycles-pp.filemap_map_pages
      0.75 ±  2%      -0.3        0.42        perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.62            -0.3        0.32 ±  2%  perf-profile.self.cycles-pp.folios_put_refs
      0.75            -0.3        0.46 ±  2%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.62            -0.3        0.34 ±  3%  perf-profile.self.cycles-pp.up_write
      0.59 ±  2%      -0.3        0.33 ±  3%  perf-profile.self.cycles-pp._compound_head
      0.56 ±  2%      -0.3        0.31 ±  2%  perf-profile.self.cycles-pp.down_write
      0.58            -0.2        0.34 ±  2%  perf-profile.self.cycles-pp.zap_present_ptes
      0.52            -0.2        0.31        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.53            -0.2        0.33        perf-profile.self.cycles-pp._IO_default_xsputn
      0.50 ±  2%      -0.2        0.30        perf-profile.self.cycles-pp._IO_fwrite
      0.52            -0.2        0.32        perf-profile.self.cycles-pp.native_irq_return_iret
      0.48            -0.2        0.29        perf-profile.self.cycles-pp.sync_regs
      0.46 ±  2%      -0.2        0.26 ±  2%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.37 ±  2%      -0.2        0.18 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.44            -0.2        0.26        perf-profile.self.cycles-pp.strnlen_user
      0.42            -0.2        0.24        perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.40            -0.2        0.24 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.39            -0.2        0.23 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.42            -0.2        0.26 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.40            -0.2        0.24        perf-profile.self.cycles-pp.kmem_cache_free
      0.34            -0.1        0.20 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.32            -0.1        0.18 ±  3%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.36 ±  4%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.24 ±  3%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.28 ±  2%      -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.30            -0.1        0.18 ±  3%  perf-profile.self.cycles-pp.clear_bhb_loop
      1.96            -0.1        1.84        perf-profile.self.cycles-pp._raw_spin_lock
      0.28            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.mas_walk
      0.29            -0.1        0.18        perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.26            -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.memset_orig
      0.27 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.26 ±  4%      -0.1        0.16 ±  4%  perf-profile.self.cycles-pp.__schedule
      0.24 ±  2%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.24 ±  2%      -0.1        0.15        perf-profile.self.cycles-pp.__cond_resched
      0.25            -0.1        0.16 ±  3%  perf-profile.self.cycles-pp._IO_padn
      0.21 ±  2%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.24 ±  2%      -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
      0.20 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.22 ± 11%      -0.1        0.13 ±  8%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.24            -0.1        0.15 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.20 ±  4%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.21 ±  4%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.19            -0.1        0.11 ±  5%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.18 ±  2%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.21 ±  2%      -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.up_read
      0.19 ±  3%      -0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__memcpy
      0.18 ±  2%      -0.1        0.11 ±  3%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.13 ±  2%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.16 ±  2%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.try_charge_memcg
      0.17            -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.__get_user_8
      0.16 ±  3%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__switch_to_asm
      0.15 ±  4%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.___slab_alloc
      0.16            -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.available_idle_cpu
      0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.set_pte_range
      0.16 ±  2%      -0.1        0.10        perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.14 ±  2%      -0.1        0.08        perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.15 ±  4%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.enqueue_entity
      0.14 ±  3%      -0.1        0.09        perf-profile.self.cycles-pp._IO_file_xsputn
      0.12 ± 14%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.17 ±  5%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.12 ±  4%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.down_read_trylock
      0.13 ±  2%      -0.1        0.08        perf-profile.self.cycles-pp.mas_wr_node_store
      0.12 ±  3%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__switch_to
      0.13 ±  2%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp._copy_from_user
      0.13            -0.1        0.08        perf-profile.self.cycles-pp.__free_one_page
      0.12 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__rb_erase_color
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.mas_next_slot
      0.12 ±  3%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.12            -0.0        0.07        perf-profile.self.cycles-pp.mmap_region
      0.12            -0.0        0.07        perf-profile.self.cycles-pp.strncpy_from_user
      0.10            -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.12 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.11 ±  3%      -0.0        0.06        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.12 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.11            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp._find_next_bit
      0.12 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.llist_add_batch
      0.14 ±  2%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.12 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.link_path_walk
      0.11 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.10 ±  3%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.13 ±  8%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      0.11 ±  6%      -0.0        0.07        perf-profile.self.cycles-pp.rwsem_mark_wake
      0.11 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.x64_sys_call
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.rcu_all_qs
      0.09 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.10 ±  3%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.handle_mm_fault
      0.09 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.pcpu_alloc_noprof
      0.12            -0.0        0.08        perf-profile.self.cycles-pp.native_sched_clock
      0.08            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.prepare_task_switch
      0.11 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.getenv
      0.08 ±  4%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.refill_obj_stock
      0.09 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.vma_interval_tree_augment_rotate
      0.10            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.task_h_load
      0.10 ±  3%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.update_curr
      0.08 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.unmap_vmas
      0.08 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.vm_area_dup
      0.07 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp._IO_setb
      0.10 ±  3%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__call_rcu_common
      0.08 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.17 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.__dentry_kill
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.__alloc_pages_noprof
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.__put_user_8
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.__snprintf_chk
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.mas_wr_walk
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.07 ±  8%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.update_min_vruntime
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.08 ±  4%      -0.0        0.05        perf-profile.self.cycles-pp.llist_reverse_order
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.__d_rehash
      0.09 ± 14%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.08 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.copy_page
      0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.update_cfs_group
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.17 ±  4%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.down_read
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.dput
      0.20            +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.fput
      0.51 ±  2%      +0.1        0.56        perf-profile.self.cycles-pp.d_alloc_parallel
      0.25 ±  2%      +0.1        0.31 ±  2%  perf-profile.self.cycles-pp.d_alloc
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.lockref_get
      0.46 ±  2%      +4.2        4.69        perf-profile.self.cycles-pp.lockref_get_not_dead
      0.45            +4.5        4.91        perf-profile.self.cycles-pp.lockref_put_return
     36.60 ±  3%     +16.8       53.40        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/getdent/stress-ng/60s

commit: 
  267574dee6 ("bcachefs: remove now spurious i_state initialization")
  d042dae6ad ("lockref: speculatively spin waiting for the lock to be released")

267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    177309            -4.8%     168834        vmstat.system.in
      5.76 ±  8%     -10.4%       5.17 ±  2%  iostat.cpu.idle
     91.68            +2.0%      93.54        iostat.cpu.system
      2.54           -49.7%       1.28 ±  2%  iostat.cpu.user
      2.77 ± 18%      -0.6        2.13 ±  6%  mpstat.cpu.all.idle%
      1.14            -0.8        0.34 ±  5%  mpstat.cpu.all.soft%
      2.60            -1.3        1.30        mpstat.cpu.all.usr%
    131.58 ± 11%     -33.8%      87.05 ± 22%  sched_debug.cfs_rq:/.load_avg.avg
    358.52 ± 13%     -33.9%     237.11 ± 20%  sched_debug.cfs_rq:/.load_avg.stddev
      3732 ±  7%     -16.7%       3109 ± 11%  sched_debug.cpu.avg_idle.min
  54365179 ±  2%     -61.2%   21094696 ±  4%  numa-numastat.node0.local_node
  54402060 ±  2%     -61.2%   21116369 ±  4%  numa-numastat.node0.numa_hit
  40309428 ±  2%     -49.6%   20297594 ±  4%  numa-numastat.node1.local_node
  40351498 ±  2%     -49.6%   20336354 ±  4%  numa-numastat.node1.numa_hit
  54513582 ±  2%     -61.3%   21104676 ±  4%  numa-vmstat.node0.numa_hit
  54476717 ±  2%     -61.3%   21083003 ±  4%  numa-vmstat.node0.numa_local
  40446773 ±  2%     -49.7%   20327089 ±  4%  numa-vmstat.node1.numa_hit
  40404702 ±  2%     -49.8%   20288329 ±  4%  numa-vmstat.node1.numa_local
     13178 ± 17%     -47.2%       6951 ± 19%  perf-c2c.DRAM.local
     31311 ± 13%     -32.5%      21125 ± 18%  perf-c2c.DRAM.remote
     29199 ± 10%     -21.6%      22897 ± 13%  perf-c2c.HITM.local
     13565 ± 13%     -26.8%       9931 ± 19%  perf-c2c.HITM.remote
     42764 ± 11%     -23.2%      32828 ± 15%  perf-c2c.HITM.total
      9550           -59.0%       3911 ±  7%  stress-ng.getdent.nanosecs_per_getdents_call
 1.179e+08           -56.5%   51297497 ±  2%  stress-ng.getdent.ops
   1964229           -56.5%     854956 ±  2%  stress-ng.getdent.ops_per_sec
  86114063           -56.4%   37516313 ±  2%  stress-ng.time.minor_page_faults
      3636            +2.3%       3718        stress-ng.time.system_time
     84.67           -57.2%      36.24 ±  2%  stress-ng.time.user_time
     57605 ±  3%      -6.3%      53991 ±  3%  proc-vmstat.nr_active_anon
      1814            -4.3%       1736 ±  4%  proc-vmstat.nr_active_file
    199146            +2.3%     203812        proc-vmstat.nr_inactive_anon
     37599            +4.4%      39262 ±  2%  proc-vmstat.nr_mapped
     81422            -4.2%      78023        proc-vmstat.nr_slab_reclaimable
     49630            -1.9%      48672        proc-vmstat.nr_slab_unreclaimable
     57605 ±  3%      -6.3%      53991 ±  3%  proc-vmstat.nr_zone_active_anon
      1814            -4.3%       1736 ±  4%  proc-vmstat.nr_zone_active_file
    199146            +2.3%     203812        proc-vmstat.nr_zone_inactive_anon
     15605 ± 19%     -41.3%       9164 ± 22%  proc-vmstat.numa_hint_faults
      8927 ± 36%     -38.8%       5463 ± 11%  proc-vmstat.numa_hint_faults_local
  94830413 ±  2%     -56.3%   41449377 ±  3%  proc-vmstat.numa_hit
  94751461 ±  2%     -56.3%   41388944 ±  3%  proc-vmstat.numa_local
    119660 ±  8%     +26.4%     151293 ±  7%  proc-vmstat.pgactivate
  99784640 ±  2%     -57.0%   42943559 ±  3%  proc-vmstat.pgalloc_normal
  86284666           -56.2%   37781294 ±  2%  proc-vmstat.pgfault
  99496632 ±  2%     -57.1%   42682486 ±  3%  proc-vmstat.pgfree
      3.32 ±  3%     -28.6%       2.37        perf-stat.i.MPKI
 1.114e+10           -32.5%  7.517e+09        perf-stat.i.branch-instructions
      0.66            -0.1        0.53        perf-stat.i.branch-miss-rate%
  70296622           -44.4%   39108658        perf-stat.i.branch-misses
     45.76            -5.5       40.29        perf-stat.i.cache-miss-rate%
 1.696e+08 ±  2%     -54.1%   77750955        perf-stat.i.cache-misses
  3.68e+08 ±  2%     -47.8%  1.921e+08        perf-stat.i.cache-references
      4.43           +58.7%       7.03        perf-stat.i.cpi
    271.12 ±  3%     -24.9%     203.71 ±  7%  perf-stat.i.cpu-migrations
      1364 ±  2%    +120.5%       3008        perf-stat.i.cycles-between-cache-misses
 5.101e+10           -36.2%  3.255e+10        perf-stat.i.instructions
      0.23           -35.7%       0.15        perf-stat.i.ipc
     44.34           -56.2%      19.42        perf-stat.i.metric.K/sec
   1416143           -56.4%     617728 ±  2%  perf-stat.i.minor-faults
   1416143           -56.4%     617728 ±  2%  perf-stat.i.page-faults
      3.33 ±  2%     -28.1%       2.39        perf-stat.overall.MPKI
      0.63            -0.1        0.52        perf-stat.overall.branch-miss-rate%
     46.07            -5.6       40.47        perf-stat.overall.cache-miss-rate%
      4.39           +57.2%       6.91        perf-stat.overall.cpi
      1321 ±  2%    +118.5%       2887 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.23           -36.4%       0.14        perf-stat.overall.ipc
 1.096e+10           -32.5%  7.405e+09        perf-stat.ps.branch-instructions
  69044394           -44.4%   38415093        perf-stat.ps.branch-misses
 1.669e+08 ±  2%     -54.0%   76744131 ±  2%  perf-stat.ps.cache-misses
 3.623e+08 ±  2%     -47.6%  1.897e+08 ±  2%  perf-stat.ps.cache-references
    268.10 ±  3%     -24.8%     201.67 ±  7%  perf-stat.ps.cpu-migrations
 5.019e+10           -36.1%  3.207e+10        perf-stat.ps.instructions
   1393551           -56.3%     609646 ±  2%  perf-stat.ps.minor-faults
   1393551           -56.3%     609646 ±  2%  perf-stat.ps.page-faults
 3.071e+12           -36.3%  1.957e+12        perf-stat.total.instructions
     58.94           -52.6        6.32 ± 33%  perf-profile.calltrace.cycles-pp.syscall
     58.03           -52.0        5.99 ± 35%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     57.96           -52.0        5.96 ± 35%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     29.21           -26.2        2.99 ± 35%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     28.52           -25.6        2.90 ± 36%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     28.40           -25.5        2.88 ± 36%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     27.98           -25.2        2.82 ± 37%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      8.70 ±  4%      -8.3        0.36 ±102%  perf-profile.calltrace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.66 ±  4%      -8.3        0.35 ±102%  perf-profile.calltrace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.62 ±  4%      -8.3        0.35 ±102%  perf-profile.calltrace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      8.61 ±  4%      -8.3        0.35 ±102%  perf-profile.calltrace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      5.90 ±  5%      -5.2        0.69 ± 14%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      5.49 ± 18%      -5.1        0.37 ±223%  perf-profile.calltrace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.47 ± 18%      -5.1        0.36 ±223%  perf-profile.calltrace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.09 ±  4%      -5.1        0.00        perf-profile.calltrace.cycles-pp.proc_readdir_de.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.09 ±  4%      -5.1        0.00        perf-profile.calltrace.cycles-pp.proc_readdir_de.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.93 ±  3%      -5.0        0.90 ± 10%  perf-profile.calltrace.cycles-pp.__close
      5.64 ±  3%      -4.8        0.80 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      5.63 ±  3%      -4.8        0.80 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      5.55 ±  3%      -4.8        0.77 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      4.94 ± 20%      -4.6        0.35 ±223%  perf-profile.calltrace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents64.do_syscall_64
      4.92 ± 20%      -4.6        0.34 ±223%  perf-profile.calltrace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents.do_syscall_64
      4.34 ±  4%      -3.9        0.40 ± 71%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      4.28 ±  4%      -3.6        0.64 ± 18%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      3.28 ±  2%      -2.6        0.65 ±  7%  perf-profile.calltrace.cycles-pp.brk
      3.20 ±  2%      -2.6        0.62 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      3.20 ±  2%      -2.6        0.62 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.16 ±  2%      -2.6        0.61 ±  7%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      2.79 ±  2%      -2.1        0.66 ±  8%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.52 ±  3%      -2.0        0.48 ± 45%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.54 ±  2%      -2.0        0.57 ±  8%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.51            -1.9        0.60 ±  2%  perf-profile.calltrace.cycles-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.49            -1.9        0.59        perf-profile.calltrace.cycles-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.39            -1.8        0.57 ±  2%  perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      2.39            -1.8        0.58        perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      5.01 ±  3%      +1.8        6.76        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.2        2.20 ±  6%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      0.00            +2.2        2.20 ±  6%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      0.00            +2.2        2.20 ±  6%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      3.39 ±  4%      +3.2        6.54 ±  2%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +3.5        3.45 ± 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next
      0.00            +3.5        3.48 ± 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup_fast
      0.00            +3.9        3.91 ±  4%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy_next.lookup_fast.walk_component.link_path_walk
      0.00            +3.9        3.91 ±  4%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup_fast.walk_component
      0.00            +3.9        3.92 ±  4%  perf-profile.calltrace.cycles-pp.try_to_unlazy_next.lookup_fast.walk_component.link_path_walk.path_openat
      0.90 ±  4%      +5.7        6.62 ±  9%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      7.79 ±  4%      +9.7       17.50 ±  2%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.53 ±  4%     +15.1       16.61 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00           +15.3       15.34 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      0.18 ±141%     +15.7       15.91 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      0.18 ±141%     +15.7       15.92 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.00           +15.9       15.90 ±  3%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
     11.06 ±  2%     +17.1       28.20 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00           +17.4       17.40 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
      0.66 ±  9%     +19.9       20.56 ±  3%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.65 ± 10%     +19.9       20.55 ±  3%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      0.38 ± 71%     +20.2       20.54 ±  3%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      0.00           +32.4       32.45 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      0.00           +35.8       35.76 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00           +36.1       36.09 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      1.19 ± 10%     +41.6       42.82 ±  3%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.15 ± 10%     +41.6       42.80 ±  3%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
     26.89 ±  2%     +63.4       90.25 ±  2%  perf-profile.calltrace.cycles-pp.open64
     26.57 ±  2%     +63.6       90.13 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     26.55 ±  2%     +63.6       90.12 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     26.46 ±  2%     +63.6       90.09 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     26.43 ±  2%     +63.6       90.08 ±  2%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     25.37 ±  2%     +64.0       89.41 ±  2%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.30 ±  2%     +64.1       89.39 ±  2%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     59.11           -52.7        6.38 ± 33%  perf-profile.children.cycles-pp.syscall
     56.40           -50.7        5.70 ± 36%  perf-profile.children.cycles-pp.iterate_dir
     29.22           -26.2        2.99 ± 35%  perf-profile.children.cycles-pp.__x64_sys_getdents
     27.45 ±  4%     -25.7        1.71 ± 27%  perf-profile.children.cycles-pp.proc_readdir_de
     28.53           -25.6        2.90 ± 36%  perf-profile.children.cycles-pp.__x64_sys_getdents64
     17.36 ±  4%     -16.2        1.18 ± 24%  perf-profile.children.cycles-pp.proc_tgid_net_readdir
     14.38 ±  4%     -13.7        0.65 ± 38%  perf-profile.children.cycles-pp._raw_read_lock
     10.97 ± 18%     -10.1        0.85 ±186%  perf-profile.children.cycles-pp.eventfs_iterate
      9.85 ± 20%      -9.2        0.70 ±223%  perf-profile.children.cycles-pp.__mutex_lock
      9.14 ± 22%      -8.5        0.68 ±223%  perf-profile.children.cycles-pp.osq_lock
      6.78 ±  6%      -6.0        0.75 ± 21%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      6.54 ±  7%      -5.7        0.87 ± 19%  perf-profile.children.cycles-pp.down_read
      5.94 ±  6%      -5.5        0.40 ± 39%  perf-profile.children.cycles-pp.up_read
      5.90 ±  5%      -5.2        0.70 ± 14%  perf-profile.children.cycles-pp.lookup_open
      5.68 ±  6%      -5.1        0.55 ± 17%  perf-profile.children.cycles-pp.proc_lookup_de
      5.98 ±  3%      -5.1        0.92 ± 10%  perf-profile.children.cycles-pp.__close
      6.65            -5.0        1.63        perf-profile.children.cycles-pp.proc_fill_cache
      5.57 ±  6%      -5.0        0.55 ± 16%  perf-profile.children.cycles-pp.proc_tgid_net_lookup
      5.56 ±  3%      -4.8        0.78 ± 11%  perf-profile.children.cycles-pp.__x64_sys_close
      5.06 ±  4%      -4.3        0.73 ± 18%  perf-profile.children.cycles-pp.inode_permission
      5.01            -3.8        1.19        perf-profile.children.cycles-pp.proc_pident_readdir
      4.36 ±  4%      -3.8        0.56 ± 12%  perf-profile.children.cycles-pp.__fput
      4.70            -3.6        1.14 ±  4%  perf-profile.children.cycles-pp.__d_lookup
      3.85 ±  6%      -3.3        0.51 ± 20%  perf-profile.children.cycles-pp.kernfs_iop_permission
      3.54            -3.1        0.48 ±  9%  perf-profile.children.cycles-pp.do_open
      3.58            -2.6        0.93        perf-profile.children.cycles-pp.d_hash_and_lookup
      3.29 ±  2%      -2.6        0.65 ±  7%  perf-profile.children.cycles-pp.brk
      3.16 ±  2%      -2.6        0.61 ±  7%  perf-profile.children.cycles-pp.__do_sys_brk
      2.70 ±  7%      -2.5        0.20 ± 32%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      2.76 ±  6%      -2.4        0.35 ± 13%  perf-profile.children.cycles-pp.__dentry_kill
      2.67 ± 11%      -2.3        0.35 ± 14%  perf-profile.children.cycles-pp.proc_get_inode
      3.01 ±  2%      -2.3        0.72 ±  8%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.60 ± 11%      -2.3        0.33 ± 13%  perf-profile.children.cycles-pp.new_inode
      2.70 ±  2%      -2.1        0.60 ±  8%  perf-profile.children.cycles-pp.exc_page_fault
      2.69 ±  3%      -2.1        0.60 ±  8%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.48 ±  2%      -2.0        0.44 ±  9%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      2.32 ±  2%      -2.0        0.29 ±  9%  perf-profile.children.cycles-pp.do_dentry_open
      1.88 ±  8%      -1.7        0.16 ± 20%  perf-profile.children.cycles-pp.evict
      2.16 ±  3%      -1.7        0.50 ±  8%  perf-profile.children.cycles-pp.handle_mm_fault
      1.98 ±  2%      -1.7        0.31 ± 10%  perf-profile.children.cycles-pp.unmap_region
      2.01 ±  3%      -1.6        0.45 ±  9%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.86 ±  3%      -1.5        0.40 ±  9%  perf-profile.children.cycles-pp.do_anonymous_page
      1.53 ±  6%      -1.3        0.22 ±  8%  perf-profile.children.cycles-pp.__lookup_slow
      1.35 ±  4%      -1.2        0.14 ± 12%  perf-profile.children.cycles-pp.security_file_open
      1.35 ±  4%      -1.2        0.14 ± 15%  perf-profile.children.cycles-pp.apparmor_file_open
      1.42 ±  3%      -1.1        0.31 ±  8%  perf-profile.children.cycles-pp.alloc_empty_file
      1.37 ±  3%      -0.9        0.42 ±  5%  perf-profile.children.cycles-pp.handle_softirqs
      1.36 ±  3%      -0.9        0.41 ±  4%  perf-profile.children.cycles-pp.rcu_core
      1.35 ±  2%      -0.9        0.41 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
      1.08 ±  4%      -0.9        0.20 ±  9%  perf-profile.children.cycles-pp.init_file
      1.21 ±  3%      -0.8        0.36 ±  6%  perf-profile.children.cycles-pp.kmem_cache_free
      0.92 ±  2%      -0.8        0.07 ± 27%  perf-profile.children.cycles-pp.mutex_lock
      1.04 ±  2%      -0.8        0.23 ±  7%  perf-profile.children.cycles-pp.step_into
      0.87 ±  2%      -0.8        0.10 ± 15%  perf-profile.children.cycles-pp.pde_put
      0.92 ±  4%      -0.7        0.17 ± 10%  perf-profile.children.cycles-pp.security_file_alloc
      1.00            -0.7        0.27 ±  2%  perf-profile.children.cycles-pp.proc_map_files_readdir
      0.83 ±  4%      -0.7        0.11 ± 15%  perf-profile.children.cycles-pp.may_open
      0.82 ±  2%      -0.7        0.13 ± 10%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.96 ±  3%      -0.7        0.27 ±  8%  perf-profile.children.cycles-pp.alloc_anon_folio
      1.16 ±  2%      -0.7        0.47 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.82 ±  4%      -0.7        0.14 ± 12%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.80 ±  2%      -0.7        0.11 ± 12%  perf-profile.children.cycles-pp.folios_put_refs
      1.13 ±  3%      -0.7        0.45 ±  9%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.86 ±  5%      -0.7        0.18 ± 20%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.87 ±  2%      -0.7        0.20 ±  3%  perf-profile.children.cycles-pp.proc_readfd_common
      0.75 ±  2%      -0.6        0.11 ± 12%  perf-profile.children.cycles-pp.__fdget_pos
      0.84            -0.6        0.20 ±  2%  perf-profile.children.cycles-pp.proc_ns_dir_readdir
      0.74            -0.6        0.12 ± 10%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.69 ±  3%      -0.6        0.06 ± 19%  perf-profile.children.cycles-pp.d_splice_alias
      0.74 ±  2%      -0.6        0.12 ± 10%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.63 ±  2%      -0.6        0.08 ± 11%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.67 ±  5%      -0.5        0.13 ±  8%  perf-profile.children.cycles-pp.security_file_free
      0.61 ±  2%      -0.5        0.07 ±  9%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.66 ±  5%      -0.5        0.13 ± 10%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.61 ±  2%      -0.5        0.08 ±  8%  perf-profile.children.cycles-pp.down_read_killable
      0.60 ±  2%      -0.5        0.07 ± 12%  perf-profile.children.cycles-pp.lru_add_drain
      0.60 ±  2%      -0.5        0.07 ± 12%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.69 ±  4%      -0.5        0.17 ±  5%  perf-profile.children.cycles-pp.__slab_free
      0.58 ±  4%      -0.5        0.06 ± 11%  perf-profile.children.cycles-pp.kernfs_dir_pos
      0.78 ±  2%      -0.5        0.27 ±  5%  perf-profile.children.cycles-pp.filldir
      0.76            -0.5        0.26 ±  6%  perf-profile.children.cycles-pp.filldir64
      0.77 ±  3%      -0.5        0.28 ±  6%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.60 ±  2%      -0.5        0.11 ±  6%  perf-profile.children.cycles-pp.filp_flush
      0.75 ±  2%      -0.5        0.26 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.73 ±  2%      -0.5        0.25 ±  7%  perf-profile.children.cycles-pp.alloc_inode
      0.62 ±  6%      -0.5        0.14 ±  8%  perf-profile.children.cycles-pp.security_file_permission
      0.59 ±  6%      -0.5        0.13 ±  9%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.48 ±  3%      -0.5        0.03 ±100%  perf-profile.children.cycles-pp.__d_add
      0.52 ±  2%      -0.4        0.08 ±  6%  perf-profile.children.cycles-pp.dnotify_flush
      0.60 ±  3%      -0.4        0.16 ±  7%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.59 ±  4%      -0.4        0.16 ± 11%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.50 ±  2%      -0.4        0.07 ±  7%  perf-profile.children.cycles-pp.fsnotify_find_mark
      0.66 ±  2%      -0.4        0.24 ±  3%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.56 ±  3%      -0.4        0.15 ± 10%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.56 ±  4%      -0.4        0.17 ±  8%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.48 ±  2%      -0.4        0.10 ± 10%  perf-profile.children.cycles-pp.unmap_vmas
      0.48 ±  3%      -0.4        0.09 ±  7%  perf-profile.children.cycles-pp.unmap_page_range
      0.47 ±  2%      -0.4        0.09 ± 10%  perf-profile.children.cycles-pp.zap_pmd_range
      0.46 ±  3%      -0.4        0.09 ± 10%  perf-profile.children.cycles-pp.zap_pte_range
      0.49 ±  2%      -0.4        0.12 ±  6%  perf-profile.children.cycles-pp.do_brk_flags
      0.47 ±  3%      -0.4        0.12 ±  9%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.38            -0.3        0.06 ±  7%  perf-profile.children.cycles-pp.zap_present_ptes
      0.48 ±  2%      -0.3        0.18 ±  6%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.36 ±  3%      -0.3        0.06 ± 13%  perf-profile.children.cycles-pp.__call_rcu_common
      0.49 ±  3%      -0.3        0.19 ±  3%  perf-profile.children.cycles-pp.d_alloc
      0.32 ±  2%      -0.3        0.02 ± 99%  perf-profile.children.cycles-pp.alloc_fd
      0.36 ±  2%      -0.3        0.07 ± 12%  perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.53 ±  7%      -0.3        0.26 ± 13%  perf-profile.children.cycles-pp.kthread
      0.53 ±  7%      -0.3        0.26 ± 13%  perf-profile.children.cycles-pp.ret_from_fork
      0.53 ±  7%      -0.3        0.26 ± 13%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.51 ±  8%      -0.3        0.24 ± 16%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.51 ±  8%      -0.3        0.24 ± 15%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.37 ±  5%      -0.3        0.10 ± 10%  perf-profile.children.cycles-pp.proc_alloc_inode
      0.32 ±  6%      -0.3        0.07 ± 17%  perf-profile.children.cycles-pp.___slab_alloc
      0.38 ±  2%      -0.2        0.14 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.32 ±  2%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.__split_vma
      0.38 ±  2%      -0.2        0.14 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.28 ±  2%      -0.2        0.05        perf-profile.children.cycles-pp.lockref_get
      0.32 ±  2%      -0.2        0.09 ±  6%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.32 ±  3%      -0.2        0.09 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.42 ± 21%      -0.2        0.20 ±  6%  perf-profile.children.cycles-pp.rb_next
      0.34 ±  3%      -0.2        0.13 ±  5%  perf-profile.children.cycles-pp.getname_flags
      0.36 ±  2%      -0.2        0.15 ±  8%  perf-profile.children.cycles-pp.inode_init_always
      0.23 ±  2%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.task_lookup_next_fdget_rcu
      0.23 ±  5%      -0.2        0.04 ± 45%  perf-profile.children.cycles-pp.security_file_post_open
      0.30 ±  2%      -0.2        0.11 ±  6%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.22 ±  5%      -0.2        0.04 ± 45%  perf-profile.children.cycles-pp.ima_file_check
      0.27 ±  2%      -0.2        0.10 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.24 ±  2%      -0.2        0.07 ±  5%  perf-profile.children.cycles-pp.pid_delete_dentry
      0.22 ±  3%      -0.2        0.06 ± 19%  perf-profile.children.cycles-pp.path_init
      0.25 ±  3%      -0.2        0.09 ±  7%  perf-profile.children.cycles-pp.sync_regs
      0.21 ±  3%      -0.2        0.06 ±  9%  perf-profile.children.cycles-pp.proc_free_inode
      0.24 ±  3%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__d_alloc
      0.23 ±  4%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.strncpy_from_user
      0.22 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.19 ±  2%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.22 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.verify_dirent_name
      0.20 ±  2%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.stress_getdents_dir
      0.20 ±  5%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.pid_revalidate
      0.20 ±  3%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.mod_objcg_state
      0.19            -0.1        0.07 ±  8%  perf-profile.children.cycles-pp.stress_getdents64_dir
      0.18 ±  4%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.strlcat
      0.15 ±  3%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.nd_jump_root
      0.17 ±  4%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.perf_event_mmap
      0.18 ±  2%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.snprintf
      0.19 ±  2%      -0.1        0.07 ±  9%  perf-profile.children.cycles-pp.security_inode_alloc
      0.17 ±  4%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.16 ±  4%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.18 ±  2%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.vsnprintf
      0.18 ±  2%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.memchr
      0.17 ±  4%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.clear_page_erms
      0.18 ±  2%      -0.1        0.07 ± 12%  perf-profile.children.cycles-pp.generic_permission
      0.16 ±  3%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.16 ±  2%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.18 ±  2%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.15            -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__perf_sw_event
      0.16 ±  3%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.rcu_all_qs
      0.13            -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.___perf_sw_event
      0.13 ±  6%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.__check_object_size
      0.11            -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.errseq_sample
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.get_jiffies_update
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.vfs_fstatat
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.vfs_statx
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.path_lookupat
      0.24 ±  3%      +0.2        0.44 ±  4%  perf-profile.children.cycles-pp.putname
      5.03 ±  3%      +1.9        6.93        perf-profile.children.cycles-pp.walk_component
      2.70 ±  2%      +4.1        6.80 ±  9%  perf-profile.children.cycles-pp.lockref_put_return
      0.12 ± 12%      +4.3        4.38 ±  6%  perf-profile.children.cycles-pp.try_to_unlazy_next
     93.59            +4.4       97.98        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     93.49            +4.4       97.94        perf-profile.children.cycles-pp.do_syscall_64
      7.80 ±  4%      +9.7       17.52 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
     11.09 ±  2%     +17.3       28.42 ±  2%  perf-profile.children.cycles-pp.link_path_walk
      4.95 ±  4%     +18.3       23.29 ±  2%  perf-profile.children.cycles-pp.lookup_fast
      6.89 ±  4%     +36.7       43.64 ±  2%  perf-profile.children.cycles-pp.dput
      1.37 ±  9%     +37.4       38.81 ±  3%  perf-profile.children.cycles-pp.try_to_unlazy
      1.20 ± 10%     +41.7       42.95 ±  3%  perf-profile.children.cycles-pp.terminate_walk
      1.42 ± 10%     +41.8       43.18 ±  3%  perf-profile.children.cycles-pp.__legitimize_path
      1.11 ± 12%     +42.0       43.16 ±  3%  perf-profile.children.cycles-pp.lockref_get_not_dead
     26.94 ±  2%     +63.3       90.27 ±  2%  perf-profile.children.cycles-pp.open64
     26.49 ±  2%     +63.9       90.38 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
     26.46 ±  2%     +63.9       90.38 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      9.73 ±  7%     +64.0       73.74 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
     25.39 ±  2%     +64.3       89.71 ±  2%  perf-profile.children.cycles-pp.do_filp_open
     25.33 ±  2%     +64.4       89.69 ±  2%  perf-profile.children.cycles-pp.path_openat
      4.21 ± 14%     +68.2       72.38 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     14.22 ±  4%     -13.6        0.64 ± 37%  perf-profile.self.cycles-pp._raw_read_lock
     12.62 ±  4%     -11.9        0.73 ± 28%  perf-profile.self.cycles-pp.proc_readdir_de
      9.07 ± 22%      -8.4        0.68 ±223%  perf-profile.self.cycles-pp.osq_lock
      6.45 ±  7%      -5.6        0.84 ± 19%  perf-profile.self.cycles-pp.down_read
      5.89 ±  6%      -5.5        0.39 ± 39%  perf-profile.self.cycles-pp.up_read
      5.72 ±  2%      -4.4        1.36 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      2.20            -1.4        0.78 ±  3%  perf-profile.self.cycles-pp.__d_lookup
      1.50 ±  4%      -1.4        0.09 ± 30%  perf-profile.self.cycles-pp.proc_lookup_de
      1.33 ±  4%      -1.2        0.14 ± 15%  perf-profile.self.cycles-pp.apparmor_file_open
      0.86 ±  2%      -0.8        0.04 ± 77%  perf-profile.self.cycles-pp.mutex_lock
      0.86 ±  2%      -0.8        0.09 ± 16%  perf-profile.self.cycles-pp.pde_put
      0.80 ±  4%      -0.7        0.14 ± 10%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.60 ±  2%      -0.5        0.07 ± 11%  perf-profile.self.cycles-pp.do_dentry_open
      0.65 ±  5%      -0.5        0.13 ± 12%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.68 ±  4%      -0.5        0.16 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.58 ±  3%      -0.5        0.07 ±  9%  perf-profile.self.cycles-pp.down_read_killable
      0.76 ±  3%      -0.5        0.28 ±  5%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.50 ±  2%      -0.5        0.04 ± 71%  perf-profile.self.cycles-pp.__fput
      0.77 ±  3%      -0.5        0.31 ±  5%  perf-profile.self.cycles-pp.proc_fill_cache
      0.55 ±  6%      -0.4        0.12 ± 10%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.50 ±  2%      -0.4        0.11 ±  6%  perf-profile.self.cycles-pp.kernfs_fop_readdir
      0.56 ±  2%      -0.4        0.20 ±  5%  perf-profile.self.cycles-pp.filldir
      0.56 ±  2%      -0.4        0.20 ±  6%  perf-profile.self.cycles-pp.filldir64
      0.38 ±  3%      -0.3        0.12 ± 11%  perf-profile.self.cycles-pp.inode_permission
      0.31 ±  2%      -0.2        0.09 ±  7%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.40 ± 21%      -0.2        0.20 ±  7%  perf-profile.self.cycles-pp.rb_next
      0.31 ±  2%      -0.2        0.12 ±  9%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.26            -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.23 ±  2%      -0.2        0.07 ±  5%  perf-profile.self.cycles-pp.pid_delete_dentry
      0.24 ±  3%      -0.2        0.08 ±  8%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.24 ±  3%      -0.2        0.09 ±  7%  perf-profile.self.cycles-pp.sync_regs
      0.23 ±  2%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.syscall
      0.22 ±  2%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.21 ±  2%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.link_path_walk
      0.21 ±  2%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.16 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.d_alloc_parallel
      0.18 ±  4%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__fdget_pos
      0.18 ±  3%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.stress_getdents_dir
      0.18 ±  3%      -0.1        0.07 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      0.17 ±  2%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.stress_getdents64_dir
      0.17 ±  4%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.strlcat
      0.14 ±  5%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.step_into
      0.17 ±  4%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.clear_page_erms
      0.16 ±  2%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.memchr
      0.16 ±  3%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.mod_objcg_state
      0.15 ±  2%      -0.1        0.05 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      0.17 ±  2%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.12 ±  3%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.inode_init_always
      0.14 ±  3%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.generic_permission
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.get_jiffies_update
      0.24 ±  3%      +0.2        0.44 ±  4%  perf-profile.self.cycles-pp.putname
      2.66 ±  3%      +4.1        6.77 ±  9%  perf-profile.self.cycles-pp.lockref_put_return
      0.85 ±  5%      +5.7        6.58 ±  8%  perf-profile.self.cycles-pp.lockref_get_not_dead
      4.08 ± 14%     +68.0       72.04 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/xfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/getdent/stress-ng/60s

commit: 
  267574dee6 ("bcachefs: remove now spurious i_state initialization")
  d042dae6ad ("lockref: speculatively spin waiting for the lock to be released")

267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.64 ±  5%     -38.8%       1.61 ±  9%  iostat.cpu.user
    259963 ± 10%     -15.4%     219891 ±  9%  meminfo.Active
    259835 ± 10%     -15.4%     219763 ±  9%  meminfo.Active(anon)
      0.96 ±  4%      -0.6        0.38 ± 15%  mpstat.cpu.all.soft%
      2.70 ±  5%      -1.1        1.65 ±  9%  mpstat.cpu.all.usr%
    211.08 ±  9%     -41.0%     124.64 ± 31%  sched_debug.cfs_rq:/.load_avg.avg
      3860 ± 24%     -34.1%       2545 ±  4%  sched_debug.cpu.avg_idle.min
  49162966           -57.6%   20842987 ± 11%  numa-numastat.node0.local_node
  49203248           -57.6%   20885029 ± 11%  numa-numastat.node0.numa_hit
  39549538           -50.2%   19693291 ±  9%  numa-numastat.node1.local_node
  39591591           -50.2%   19718716 ±  8%  numa-numastat.node1.numa_hit
  49261289           -57.6%   20866465 ± 11%  numa-vmstat.node0.numa_hit
  49221006           -57.7%   20824423 ± 11%  numa-vmstat.node0.numa_local
  39661116           -50.3%   19702525 ±  9%  numa-vmstat.node1.numa_hit
  39619062           -50.3%   19677100 ±  9%  numa-vmstat.node1.numa_local
     12372 ±  3%     -45.1%       6789 ± 12%  perf-c2c.DRAM.local
     36077 ±  2%     -45.0%      19825 ±  9%  perf-c2c.DRAM.remote
     32989 ±  2%     -30.5%      22935 ± 11%  perf-c2c.HITM.local
     17205 ±  2%     -46.6%       9182 ± 10%  perf-c2c.HITM.remote
     50194 ±  2%     -36.0%      32118 ± 10%  perf-c2c.HITM.total
  88807242           -54.3%   40604534 ± 10%  proc-vmstat.numa_hit
  88724762           -54.3%   40537067 ± 10%  proc-vmstat.numa_local
    130416 ±  7%     +21.3%     158188 ±  3%  proc-vmstat.pgactivate
  92701259           -54.7%   41954988 ± 11%  proc-vmstat.pgalloc_normal
  80544858           -54.2%   36859393 ± 10%  proc-vmstat.pgfault
  92449287           -54.9%   41735344 ± 11%  proc-vmstat.pgfree
     11060           -58.7%       4569 ± 22%  stress-ng.getdent.nanosecs_per_getdents_call
 1.135e+08           -54.6%   51568726 ± 10%  stress-ng.getdent.ops
   1891648           -54.6%     859477 ± 10%  stress-ng.getdent.ops_per_sec
  80355832           -54.5%   36564567 ± 10%  stress-ng.time.minor_page_faults
      3626            +2.1%       3702        stress-ng.time.system_time
     80.35           -54.4%      36.65 ± 10%  stress-ng.time.user_time
      2.88 ±  2%     -21.6%       2.25 ±  3%  perf-stat.i.MPKI
 1.202e+10 ±  5%     -35.3%  7.773e+09 ±  7%  perf-stat.i.branch-instructions
  78049914 ±  4%     -33.0%   52278904 ±  9%  perf-stat.i.branch-misses
     44.35 ±  3%      -4.4       39.94 ±  4%  perf-stat.i.cache-miss-rate%
 1.629e+08 ±  5%     -52.0%   78236809 ± 11%  perf-stat.i.cache-misses
 3.527e+08 ±  5%     -45.8%   1.91e+08 ±  9%  perf-stat.i.cache-references
      3.78 ±  3%     +75.9%       6.64 ±  3%  perf-stat.i.cpi
    299.98 ±  8%     -28.2%     215.47 ± 15%  perf-stat.i.cpu-migrations
      1341 ±  2%    +122.2%       2981 ±  3%  perf-stat.i.cycles-between-cache-misses
 5.574e+10 ±  5%     -39.1%  3.397e+10 ±  8%  perf-stat.i.instructions
      0.29 ± 10%     -39.7%       0.18 ± 16%  perf-stat.i.ipc
     39.56 ±  5%     -52.9%      18.63 ± 12%  perf-stat.i.metric.K/sec
   1264058 ±  5%     -53.0%     593585 ± 13%  perf-stat.i.minor-faults
   1264058 ±  5%     -53.0%     593585 ± 13%  perf-stat.i.page-faults
      2.93           -21.4%       2.30 ±  2%  perf-stat.overall.MPKI
     46.18            -5.3       40.88        perf-stat.overall.cache-miss-rate%
      3.85           +69.7%       6.53 ±  5%  perf-stat.overall.cpi
      1313          +116.3%       2842 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.26           -40.9%       0.15 ±  5%  perf-stat.overall.ipc
 1.184e+10 ±  5%     -35.4%  7.645e+09 ±  7%  perf-stat.ps.branch-instructions
  76385602 ±  4%     -33.2%   51045849 ±  9%  perf-stat.ps.branch-misses
 1.606e+08 ±  5%     -52.0%   77029112 ± 10%  perf-stat.ps.cache-misses
 3.478e+08 ±  5%     -45.9%  1.882e+08 ±  9%  perf-stat.ps.cache-references
    294.68 ±  8%     -28.1%     211.78 ± 15%  perf-stat.ps.cpu-migrations
 5.487e+10 ±  5%     -39.1%   3.34e+10 ±  8%  perf-stat.ps.instructions
   1246246 ±  5%     -53.1%     584418 ± 12%  perf-stat.ps.minor-faults
   1246246 ±  5%     -53.1%     584418 ± 12%  perf-stat.ps.page-faults
 3.532e+12           -40.9%  2.088e+12 ±  5%  perf-stat.total.instructions
     65.80           -56.9        8.86 ± 55%  perf-profile.calltrace.cycles-pp.syscall
     64.94           -56.4        8.52 ± 56%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     64.88           -56.4        8.50 ± 56%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     32.57           -28.3        4.27 ± 57%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     32.08           -27.9        4.15 ± 57%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     31.94           -27.8        4.14 ± 57%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     31.65           -27.6        4.06 ± 57%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     14.11 ±  5%     -13.0        1.12 ±122%  perf-profile.calltrace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.06 ±  5%     -12.9        1.13 ±122%  perf-profile.calltrace.cycles-pp.eventfs_iterate.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.38 ±  5%     -12.3        1.04 ±124%  perf-profile.calltrace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents64.do_syscall_64
     13.34 ±  5%     -12.3        1.05 ±124%  perf-profile.calltrace.cycles-pp.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents.do_syscall_64
     12.89 ±  5%     -12.0        0.92 ±141%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents64
     12.84 ±  5%     -11.9        0.93 ±141%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.eventfs_iterate.iterate_dir.__x64_sys_getdents
      6.49 ±  2%      -5.9        0.57 ±117%  perf-profile.calltrace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.48 ±  2%      -5.9        0.57 ±117%  perf-profile.calltrace.cycles-pp.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.43 ±  2%      -5.9        0.56 ±117%  perf-profile.calltrace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      6.43 ±  2%      -5.9        0.56 ±117%  perf-profile.calltrace.cycles-pp.proc_readdir_de.proc_tgid_net_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      4.62 ±  3%      -3.8        0.82 ± 44%  perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      4.80 ±  2%      -3.8        1.03 ± 33%  perf-profile.calltrace.cycles-pp.__close
      4.54 ±  2%      -3.6        0.93 ± 36%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      4.52 ±  2%      -3.6        0.92 ± 36%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      4.45 ±  2%      -3.6        0.90 ± 36%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.47 ±  3%      -3.0        0.42 ±108%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.78 ±  8%      -2.9        0.84 ± 36%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      3.00 ±  4%      -2.6        0.40 ±108%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      3.00 ± 10%      -2.6        0.42 ±105%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      2.65 ±  2%      -2.0        0.70 ± 25%  perf-profile.calltrace.cycles-pp.brk
      2.57 ±  2%      -1.9        0.66 ± 26%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      2.58 ±  2%      -1.9        0.66 ± 26%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      2.54 ±  2%      -1.9        0.65 ± 26%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      2.04            -1.7        0.35 ±104%  perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64
      2.04            -1.7        0.35 ±104%  perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pident_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      2.05 ±  2%      -1.6        0.44 ± 75%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.04 ±  2%      -1.6        0.43 ± 75%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.13            -1.6        0.53 ± 52%  perf-profile.calltrace.cycles-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.28 ±  2%      -1.6        0.68 ± 23%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.14            -1.5        0.62 ± 24%  perf-profile.calltrace.cycles-pp.proc_pident_readdir.iterate_dir.__x64_sys_getdents.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.8        1.78 ±  6%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.walk_component
      0.00            +1.8        1.78 ±  6%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.walk_component.link_path_walk
      0.00            +1.8        1.78 ±  6%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.walk_component.link_path_walk.path_openat
      4.32 ±  3%      +2.0        6.30 ±  3%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      3.04 ±  5%      +3.0        6.06 ±  3%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00            +3.2        3.20 ± 13%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next
      0.00            +3.2        3.23 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup_fast
      0.00            +3.7        3.69 ±  9%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy_next.lookup_fast.walk_component.link_path_walk
      0.00            +3.7        3.69 ±  9%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy_next.lookup_fast.walk_component
      0.00            +3.7        3.70 ±  9%  perf-profile.calltrace.cycles-pp.try_to_unlazy_next.lookup_fast.walk_component.link_path_walk.path_openat
      0.69 ±  4%      +5.3        6.01 ±  8%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      6.20 ±  2%      +9.8       16.04 ±  4%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      1.29 ±  3%     +13.7       15.03 ±  6%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00           +13.8       13.76 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast
      0.00           +14.3       14.31 ±  6%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups
      0.00           +14.3       14.32 ±  6%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.lookup_fast.open_last_lookups.path_openat
      0.00           +14.3       14.32 ±  6%  perf-profile.calltrace.cycles-pp.try_to_unlazy.lookup_fast.open_last_lookups.path_openat.do_filp_open
      0.00           +18.0       18.04 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk
      9.60 ±  4%     +19.0       28.56 ±  6%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.28 ±100%     +20.8       21.12 ± 10%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      0.28 ±100%     +20.8       21.13 ± 10%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +21.1       21.11 ± 10%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      0.00           +31.5       31.52 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      0.00           +34.7       34.71 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      0.00           +35.0       35.01 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
      0.88 ±  9%     +40.2       41.12 ±  8%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.84 ±  9%     +40.3       41.10 ±  8%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
     22.55 ±  2%     +65.0       87.59 ±  6%  perf-profile.calltrace.cycles-pp.open64
     22.25 ±  2%     +65.2       87.48 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     22.23 ±  2%     +65.2       87.47 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     22.15 ±  2%     +65.3       87.43 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     22.12 ±  2%     +65.3       87.42 ±  6%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     21.24 ±  2%     +65.5       86.76 ±  6%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.18 ±  2%     +65.6       86.74 ±  6%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     65.96           -57.0        8.93 ± 54%  perf-profile.children.cycles-pp.syscall
     63.61           -55.4        8.21 ± 57%  perf-profile.children.cycles-pp.iterate_dir
     32.58           -28.3        4.27 ± 57%  perf-profile.children.cycles-pp.__x64_sys_getdents
     32.09           -27.9        4.15 ± 57%  perf-profile.children.cycles-pp.__x64_sys_getdents64
     28.19 ±  5%     -25.8        2.34 ±114%  perf-profile.children.cycles-pp.eventfs_iterate
     26.72 ±  5%     -24.6        2.08 ±124%  perf-profile.children.cycles-pp.__mutex_lock
     25.74 ±  5%     -23.7        2.00 ±125%  perf-profile.children.cycles-pp.osq_lock
     20.36 ±  2%     -18.0        2.37 ± 66%  perf-profile.children.cycles-pp.proc_readdir_de
     12.96 ±  2%     -11.4        1.60 ± 61%  perf-profile.children.cycles-pp.proc_tgid_net_readdir
     10.60 ±  3%      -9.6        1.02 ± 80%  perf-profile.children.cycles-pp._raw_read_lock
      5.88 ±  6%      -4.9        1.02 ± 48%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      5.85 ±  7%      -4.7        1.16 ± 42%  perf-profile.children.cycles-pp.down_read
      5.15 ±  5%      -4.5        0.68 ± 67%  perf-profile.children.cycles-pp.up_read
      5.68            -4.0        1.68 ± 24%  perf-profile.children.cycles-pp.proc_fill_cache
      4.62 ±  3%      -3.8        0.82 ± 44%  perf-profile.children.cycles-pp.lookup_open
      4.85 ±  2%      -3.8        1.05 ± 33%  perf-profile.children.cycles-pp.__close
      4.42 ±  4%      -3.7        0.68 ± 52%  perf-profile.children.cycles-pp.proc_lookup_de
      4.32 ±  3%      -3.6        0.68 ± 51%  perf-profile.children.cycles-pp.proc_tgid_net_lookup
      4.46 ±  2%      -3.6        0.90 ± 36%  perf-profile.children.cycles-pp.__x64_sys_close
      4.43 ±  8%      -3.5        0.96 ± 37%  perf-profile.children.cycles-pp.inode_permission
      4.28            -3.0        1.23 ± 25%  perf-profile.children.cycles-pp.proc_pident_readdir
      3.48 ±  3%      -2.8        0.66 ± 39%  perf-profile.children.cycles-pp.__fput
      3.98 ±  2%      -2.8        1.18 ± 24%  perf-profile.children.cycles-pp.__d_lookup
      3.44 ± 10%      -2.7        0.70 ± 41%  perf-profile.children.cycles-pp.kernfs_iop_permission
      3.01 ±  4%      -2.4        0.60 ± 40%  perf-profile.children.cycles-pp.do_open
      3.09            -2.1        0.95 ± 23%  perf-profile.children.cycles-pp.d_hash_and_lookup
      2.46 ±  7%      -2.1        0.33 ± 64%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      2.66 ±  2%      -2.0        0.70 ± 25%  perf-profile.children.cycles-pp.brk
      2.55 ±  2%      -1.9        0.65 ± 26%  perf-profile.children.cycles-pp.__do_sys_brk
      2.18 ±  4%      -1.8        0.40 ± 40%  perf-profile.children.cycles-pp.__dentry_kill
      2.18 ±  6%      -1.8        0.41 ± 45%  perf-profile.children.cycles-pp.proc_get_inode
      2.47 ±  2%      -1.7        0.74 ± 23%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.12 ±  6%      -1.7        0.40 ± 46%  perf-profile.children.cycles-pp.new_inode
      1.94 ±  4%      -1.6        0.37 ± 44%  perf-profile.children.cycles-pp.do_dentry_open
      2.19 ±  2%      -1.6        0.63 ± 24%  perf-profile.children.cycles-pp.exc_page_fault
      2.18 ±  2%      -1.6        0.62 ± 24%  perf-profile.children.cycles-pp.do_user_addr_fault
      1.98 ±  2%      -1.5        0.48 ± 27%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      1.49 ±  6%      -1.3        0.21 ± 58%  perf-profile.children.cycles-pp.evict
      1.76 ±  2%      -1.2        0.52 ± 24%  perf-profile.children.cycles-pp.handle_mm_fault
      1.56 ±  3%      -1.2        0.35 ± 31%  perf-profile.children.cycles-pp.unmap_region
      1.63 ±  2%      -1.2        0.47 ± 24%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.50 ±  2%      -1.1        0.42 ± 25%  perf-profile.children.cycles-pp.do_anonymous_page
      1.16 ±  7%      -1.0        0.20 ± 53%  perf-profile.children.cycles-pp.security_file_open
      1.16 ±  7%      -1.0        0.20 ± 57%  perf-profile.children.cycles-pp.apparmor_file_open
      1.21 ±  3%      -1.0        0.25 ± 35%  perf-profile.children.cycles-pp.__lookup_slow
      1.26 ±  3%      -0.9        0.35 ± 28%  perf-profile.children.cycles-pp.alloc_empty_file
      1.20            -0.8        0.42 ± 20%  perf-profile.children.cycles-pp.handle_softirqs
      1.20            -0.8        0.41 ± 21%  perf-profile.children.cycles-pp.rcu_core
      1.19            -0.8        0.41 ± 21%  perf-profile.children.cycles-pp.rcu_do_batch
      0.85 ±  2%      -0.8        0.07 ±112%  perf-profile.children.cycles-pp.mutex_unlock
      0.86 ±  2%      -0.7        0.12 ± 55%  perf-profile.children.cycles-pp.mutex_lock
      0.96 ±  5%      -0.7        0.23 ± 34%  perf-profile.children.cycles-pp.init_file
      1.07            -0.7        0.36 ± 20%  perf-profile.children.cycles-pp.kmem_cache_free
      0.90 ±  3%      -0.6        0.28 ± 24%  perf-profile.children.cycles-pp.step_into
      0.83 ±  6%      -0.6        0.21 ± 34%  perf-profile.children.cycles-pp.security_file_alloc
      0.75 ±  6%      -0.6        0.17 ± 38%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.85 ±  2%      -0.6        0.28 ± 21%  perf-profile.children.cycles-pp.proc_map_files_readdir
      1.12 ±  2%      -0.6        0.55 ±  9%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.10 ±  2%      -0.6        0.54 ± 10%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.68 ±  2%      -0.6        0.12 ± 51%  perf-profile.children.cycles-pp.pde_put
      0.83 ±  3%      -0.6        0.27 ± 20%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.70 ±  7%      -0.6        0.14 ± 41%  perf-profile.children.cycles-pp.may_open
      0.79 ±  3%      -0.5        0.26 ± 20%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.72 ±  2%      -0.5        0.21 ± 26%  perf-profile.children.cycles-pp.proc_ns_dir_readdir
      0.71 ±  2%      -0.5        0.21 ± 21%  perf-profile.children.cycles-pp.proc_readfd_common
      0.65 ±  2%      -0.5        0.15 ± 32%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.62 ±  3%      -0.5        0.13 ± 35%  perf-profile.children.cycles-pp.folios_put_refs
      0.65 ±  9%      -0.5        0.16 ± 33%  perf-profile.children.cycles-pp.security_file_permission
      0.63 ±  9%      -0.5        0.15 ± 33%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.60            -0.5        0.12 ± 36%  perf-profile.children.cycles-pp.__fdget_pos
      0.58 ±  2%      -0.5        0.13 ± 33%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.58 ±  3%      -0.5        0.13 ± 34%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.72            -0.4        0.28 ± 16%  perf-profile.children.cycles-pp.filldir
      0.52 ±  2%      -0.4        0.08 ± 49%  perf-profile.children.cycles-pp.d_splice_alias
      0.70 ±  2%      -0.4        0.27 ± 16%  perf-profile.children.cycles-pp.filldir64
      0.71 ±  2%      -0.4        0.29 ± 15%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.57 ±  5%      -0.4        0.15 ± 31%  perf-profile.children.cycles-pp.security_file_free
      0.59            -0.4        0.17 ± 26%  perf-profile.children.cycles-pp.__slab_free
      0.56 ±  5%      -0.4        0.15 ± 31%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.68            -0.4        0.27 ± 16%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.66 ±  2%      -0.4        0.25 ± 20%  perf-profile.children.cycles-pp.alloc_inode
      0.48 ±  2%      -0.4        0.09 ± 36%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.48            -0.4        0.10 ± 38%  perf-profile.children.cycles-pp.down_read_killable
      0.47 ±  3%      -0.4        0.09 ± 40%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.46 ±  3%      -0.4        0.08 ± 35%  perf-profile.children.cycles-pp.lru_add_drain
      0.46 ±  3%      -0.4        0.08 ± 35%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.48 ±  3%      -0.4        0.12 ± 27%  perf-profile.children.cycles-pp.filp_flush
      0.44 ±  2%      -0.4        0.08 ± 46%  perf-profile.children.cycles-pp.kernfs_dir_pos
      0.50 ±  2%      -0.3        0.16 ± 20%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.49 ±  3%      -0.3        0.16 ± 22%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.58            -0.3        0.25 ± 15%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.41 ±  3%      -0.3        0.09 ± 32%  perf-profile.children.cycles-pp.dnotify_flush
      0.46 ±  3%      -0.3        0.15 ± 20%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.48 ±  3%      -0.3        0.16 ± 23%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.39 ±  3%      -0.3        0.08 ± 36%  perf-profile.children.cycles-pp.fsnotify_find_mark
      0.39 ±  2%      -0.3        0.10 ± 25%  perf-profile.children.cycles-pp.unmap_vmas
      0.38 ±  2%      -0.3        0.10 ± 25%  perf-profile.children.cycles-pp.unmap_page_range
      0.38 ±  2%      -0.3        0.10 ± 25%  perf-profile.children.cycles-pp.zap_pmd_range
      0.40 ±  3%      -0.3        0.12 ± 20%  perf-profile.children.cycles-pp.do_brk_flags
      0.37 ±  2%      -0.3        0.10 ± 27%  perf-profile.children.cycles-pp.zap_pte_range
      0.38 ±  2%      -0.3        0.12 ± 22%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.43            -0.3        0.17 ± 15%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.41 ±  6%      -0.2        0.16 ± 25%  perf-profile.children.cycles-pp.kthread
      0.41 ±  6%      -0.2        0.16 ± 25%  perf-profile.children.cycles-pp.ret_from_fork
      0.41 ±  6%      -0.2        0.16 ± 25%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.38 ±  7%      -0.2        0.14 ± 27%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.42 ±  2%      -0.2        0.19 ± 15%  perf-profile.children.cycles-pp.d_alloc
      0.38 ±  7%      -0.2        0.15 ± 27%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.30 ±  2%      -0.2        0.07 ± 26%  perf-profile.children.cycles-pp.zap_present_ptes
      0.38 ±  2%      -0.2        0.15 ± 15%  perf-profile.children.cycles-pp.__cond_resched
      0.30 ±  3%      -0.2        0.08 ± 31%  perf-profile.children.cycles-pp.inode_wait_for_writeback
      0.37 ±  2%      -0.2        0.14 ± 16%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.28 ±  2%      -0.2        0.06 ± 27%  perf-profile.children.cycles-pp.__call_rcu_common
      0.30 ±  5%      -0.2        0.10 ± 26%  perf-profile.children.cycles-pp.proc_alloc_inode
      0.35 ±  4%      -0.2        0.15 ± 22%  perf-profile.children.cycles-pp.inode_init_always
      0.26 ±  8%      -0.2        0.05 ± 76%  perf-profile.children.cycles-pp.___slab_alloc
      0.28 ±  2%      -0.2        0.09 ± 21%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.27            -0.2        0.08 ± 20%  perf-profile.children.cycles-pp.__split_vma
      0.24 ±  2%      -0.2        0.06 ± 27%  perf-profile.children.cycles-pp.lockref_get
      0.31 ±  3%      -0.2        0.13 ± 15%  perf-profile.children.cycles-pp.getname_flags
      0.23 ±  7%      -0.2        0.06 ± 54%  perf-profile.children.cycles-pp.security_file_post_open
      0.26 ±  4%      -0.2        0.09 ± 20%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.37 ±  2%      -0.2        0.20 ± 15%  perf-profile.children.cycles-pp.rb_next
      0.22 ±  7%      -0.2        0.05 ± 51%  perf-profile.children.cycles-pp.ima_file_check
      0.28 ±  2%      -0.2        0.12 ± 14%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.26 ±  3%      -0.2        0.10 ± 15%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.22 ±  3%      -0.1        0.07 ± 26%  perf-profile.children.cycles-pp.pid_delete_dentry
      0.18 ±  2%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.proc_free_inode
      0.18 ±  2%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.task_lookup_next_fdget_rcu
      0.22 ±  3%      -0.1        0.09 ± 15%  perf-profile.children.cycles-pp.sync_regs
      0.17 ±  2%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.path_init
      0.21 ±  2%      -0.1        0.08 ± 19%  perf-profile.children.cycles-pp.__d_alloc
      0.22 ±  5%      -0.1        0.09 ± 15%  perf-profile.children.cycles-pp.strncpy_from_user
      0.20 ±  3%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.verify_dirent_name
      0.20 ±  2%      -0.1        0.09 ± 15%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.19 ±  3%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.mod_objcg_state
      0.19 ±  5%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.pid_revalidate
      0.18 ±  4%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.stress_getdents_dir
      0.18 ±  2%      -0.1        0.07 ± 16%  perf-profile.children.cycles-pp.stress_getdents64_dir
      0.17 ±  4%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.15 ±  3%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.perf_event_mmap
      0.17 ±  2%      -0.1        0.07 ± 17%  perf-profile.children.cycles-pp.strlcat
      0.18 ±  4%      -0.1        0.07 ± 24%  perf-profile.children.cycles-pp.security_inode_alloc
      0.16 ±  3%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.snprintf
      0.14 ±  3%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.16 ±  3%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.rcu_all_qs
      0.16 ±  3%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.vsnprintf
      0.17 ±  2%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.15 ±  3%      -0.1        0.06 ± 20%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.16 ±  3%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.memchr
      0.15 ±  4%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.15 ±  3%      -0.1        0.06 ± 14%  perf-profile.children.cycles-pp.clear_page_erms
      0.14 ±  3%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.__perf_sw_event
      0.14 ±  3%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.16 ±  5%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.generic_permission
      0.12 ±  4%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.filename_lookup
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.path_lookupat
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.vfs_fstatat
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.vfs_statx
      0.18 ±  3%      +0.2        0.42 ±  5%  perf-profile.children.cycles-pp.putname
      4.34 ±  2%      +2.1        6.47 ±  3%  perf-profile.children.cycles-pp.walk_component
     94.42            +3.6       98.01        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     94.33            +3.6       97.98        perf-profile.children.cycles-pp.do_syscall_64
      0.09 ± 11%      +4.1        4.16 ±  9%  perf-profile.children.cycles-pp.try_to_unlazy_next
      2.07 ±  2%      +4.2        6.25 ±  7%  perf-profile.children.cycles-pp.lockref_put_return
      6.21 ±  2%      +9.8       16.05 ±  4%  perf-profile.children.cycles-pp.open_last_lookups
      4.35 ±  4%     +16.9       21.22 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      9.63 ±  4%     +19.1       28.76 ±  6%  perf-profile.children.cycles-pp.link_path_walk
      1.03 ±  8%     +36.3       37.38 ±  8%  perf-profile.children.cycles-pp.try_to_unlazy
      5.34 ±  2%     +36.7       42.07 ±  7%  perf-profile.children.cycles-pp.dput
      0.89 ±  9%     +40.4       41.25 ±  8%  perf-profile.children.cycles-pp.terminate_walk
      1.06 ±  9%     +40.5       41.52 ±  8%  perf-profile.children.cycles-pp.__legitimize_path
      0.83 ± 12%     +40.7       41.48 ±  8%  perf-profile.children.cycles-pp.lockref_get_not_dead
      7.22 ±  2%     +64.5       71.72 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
     22.60 ±  2%     +65.0       87.62 ±  6%  perf-profile.children.cycles-pp.open64
     22.17 ±  2%     +65.5       87.72 ±  6%  perf-profile.children.cycles-pp.__x64_sys_openat
     22.15 ±  2%     +65.6       87.71 ±  6%  perf-profile.children.cycles-pp.do_sys_openat2
     21.26 ±  2%     +65.8       87.05 ±  6%  perf-profile.children.cycles-pp.do_filp_open
     21.20 ±  2%     +65.8       87.03 ±  6%  perf-profile.children.cycles-pp.path_openat
      2.92 ±  5%     +67.4       70.29 ±  8%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     25.58 ±  5%     -23.6        1.99 ±125%  perf-profile.self.cycles-pp.osq_lock
     10.46 ±  3%      -9.5        1.00 ± 80%  perf-profile.self.cycles-pp._raw_read_lock
      9.26 ±  2%      -8.2        1.03 ± 68%  perf-profile.self.cycles-pp.proc_readdir_de
      5.77 ±  7%      -4.6        1.13 ± 43%  perf-profile.self.cycles-pp.down_read
      5.11 ±  6%      -4.4        0.67 ± 68%  perf-profile.self.cycles-pp.up_read
      4.42            -3.0        1.43 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock
      2.05 ±  2%      -1.3        0.78 ± 20%  perf-profile.self.cycles-pp.__d_lookup
      1.11 ±  2%      -1.0        0.12 ± 65%  perf-profile.self.cycles-pp.proc_lookup_de
      1.14 ±  7%      -0.9        0.19 ± 56%  perf-profile.self.cycles-pp.apparmor_file_open
      0.84 ±  2%      -0.8        0.07 ±115%  perf-profile.self.cycles-pp.mutex_unlock
      0.80 ±  2%      -0.7        0.10 ± 60%  perf-profile.self.cycles-pp.mutex_lock
      0.73 ±  6%      -0.6        0.17 ± 38%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.66 ±  2%      -0.5        0.12 ± 48%  perf-profile.self.cycles-pp.pde_put
      0.76 ±  5%      -0.5        0.31 ± 19%  perf-profile.self.cycles-pp.proc_fill_cache
      0.59 ± 10%      -0.4        0.14 ± 35%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.70 ±  2%      -0.4        0.29 ± 15%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.58            -0.4        0.17 ± 25%  perf-profile.self.cycles-pp.__slab_free
      0.55 ±  5%      -0.4        0.15 ± 31%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.47            -0.4        0.08 ± 38%  perf-profile.self.cycles-pp.do_dentry_open
      0.45            -0.4        0.08 ± 41%  perf-profile.self.cycles-pp.down_read_killable
      0.39 ±  2%      -0.3        0.06 ± 60%  perf-profile.self.cycles-pp.__fput
      0.53            -0.3        0.21 ± 16%  perf-profile.self.cycles-pp.filldir
      0.52 ±  2%      -0.3        0.21 ± 16%  perf-profile.self.cycles-pp.filldir64
      0.38 ±  4%      -0.3        0.12 ± 22%  perf-profile.self.cycles-pp.kernfs_fop_readdir
      0.37 ±  3%      -0.2        0.14 ± 17%  perf-profile.self.cycles-pp.inode_permission
      0.27 ±  2%      -0.2        0.09 ± 20%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.29 ±  2%      -0.2        0.12 ± 16%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.35 ±  3%      -0.2        0.20 ± 15%  perf-profile.self.cycles-pp.rb_next
      0.25 ±  2%      -0.2        0.10 ± 16%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.21 ±  3%      -0.1        0.07 ± 24%  perf-profile.self.cycles-pp.pid_delete_dentry
      0.22 ±  2%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.syscall
      0.22 ±  3%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.sync_regs
      0.21 ±  3%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.20            -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__cond_resched
      0.20 ±  2%      -0.1        0.09 ± 15%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.19 ±  3%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.link_path_walk
      0.17 ±  2%      -0.1        0.07 ± 17%  perf-profile.self.cycles-pp.__fdget_pos
      0.14 ±  4%      -0.1        0.04 ± 72%  perf-profile.self.cycles-pp.do_syscall_64
      0.17 ±  5%      -0.1        0.07 ± 16%  perf-profile.self.cycles-pp.kmem_cache_free
      0.13 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.step_into
      0.16 ±  4%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.stress_getdents_dir
      0.16 ±  2%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.strlcat
      0.16 ±  2%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.stress_getdents64_dir
      0.16 ±  3%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.mod_objcg_state
      0.17 ±  4%      -0.1        0.08 ± 16%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.12 ±  4%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.rcu_all_qs
      0.15 ±  3%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.memchr
      0.12 ±  4%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.inode_init_always
      0.14 ±  3%      -0.1        0.06 ± 17%  perf-profile.self.cycles-pp.clear_page_erms
      0.09 ±  7%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.pid_revalidate
      0.13 ±  5%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.generic_permission
      0.11 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.dput
      0.18 ±  2%      +0.2        0.42 ±  5%  perf-profile.self.cycles-pp.putname
      2.04 ±  2%      +4.2        6.21 ±  7%  perf-profile.self.cycles-pp.lockref_put_return
      0.66 ±  4%      +5.4        6.01 ±  8%  perf-profile.self.cycles-pp.lockref_get_not_dead
      2.81 ±  5%     +67.1       69.92 ±  8%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-icl-2sp8: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/handle/stress-ng/60s

commit: 
  267574dee6 ("bcachefs: remove now spurious i_state initialization")
  d042dae6ad ("lockref: speculatively spin waiting for the lock to be released")

267574dee6ae0da6 d042dae6ad74df8a00ee8a3c6b7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1.08 ±  4%     -10.1%       0.97 ±  2%  iostat.cpu.user
      1.10 ±  4%      -0.1        0.99 ±  2%  mpstat.cpu.all.usr%
    286411 ±  7%     -12.1%     251734 ±  4%  numa-numastat.node1.local_node
    285093 ±  6%     -12.0%     250827 ±  4%  numa-vmstat.node1.numa_local
      2980 ±  7%     -19.8%       2391 ±  4%  vmstat.system.cs
    162616            -2.6%     158340        vmstat.system.in
     84179            -3.0%      81690        proc-vmstat.nr_shmem
    486339            -1.7%     478110        proc-vmstat.numa_hit
    420032            -2.0%     411796        proc-vmstat.numa_local
  10880229 ±  2%     -60.2%    4332475 ± 13%  stress-ng.handle.ops
    181335 ±  2%     -60.2%      72206 ± 13%  stress-ng.handle.ops_per_sec
     75993 ±  9%     -28.7%      54148 ±  9%  stress-ng.time.involuntary_context_switches
    455.17 ±  9%     +61.9%     737.00 ± 10%  perf-c2c.DRAM.local
     31509 ±  2%     -36.9%      19892 ±  2%  perf-c2c.DRAM.remote
     39333 ±  2%     -24.9%      29523 ±  2%  perf-c2c.HITM.local
     25890 ±  2%     -45.5%      14112 ±  3%  perf-c2c.HITM.remote
     65223 ±  2%     -33.1%      43635 ±  2%  perf-c2c.HITM.total
      5043 ± 31%     -57.9%       2123 ± 25%  sched_debug.cfs_rq:/.load_avg.max
      1423 ± 38%     -51.9%     683.87 ± 30%  sched_debug.cfs_rq:/.load_avg.stddev
     45.04 ± 17%     -47.5%      23.63 ± 41%  sched_debug.cfs_rq:/.removed.load_avg.avg
    141.61 ±  8%     -28.5%     101.19 ± 22%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      1399 ±  8%     -15.2%       1186 ±  4%  sched_debug.cfs_rq:/.runnable_avg.max
      1269 ±  4%     -12.2%       1114 ±  4%  sched_debug.cfs_rq:/.util_avg.max
      1.30           -23.4%       1.00 ±  2%  perf-stat.i.MPKI
 5.757e+09           -17.7%  4.736e+09        perf-stat.i.branch-instructions
      0.65 ±  3%      +0.1        0.70        perf-stat.i.branch-miss-rate%
  38695005 ±  3%      -7.7%   35708627        perf-stat.i.branch-misses
     38.60            -9.7       28.94        perf-stat.i.cache-miss-rate%
  31607382           -38.6%   19404517        perf-stat.i.cache-misses
  82723252           -17.5%   68236401        perf-stat.i.cache-references
      2935 ±  7%     -20.5%       2332 ±  5%  perf-stat.i.context-switches
      9.32           +25.5%      11.70        perf-stat.i.cpi
      7126           +64.0%      11684        perf-stat.i.cycles-between-cache-misses
 2.442e+10           -19.3%   1.97e+10        perf-stat.i.instructions
      0.12           -19.0%       0.10 ±  2%  perf-stat.i.ipc
      1.30           -23.8%       0.99 ±  2%  perf-stat.overall.MPKI
      0.66 ±  3%      +0.1        0.74        perf-stat.overall.branch-miss-rate%
     38.06            -9.8       28.29        perf-stat.overall.cache-miss-rate%
      9.27           +24.2%      11.51        perf-stat.overall.cpi
      7157           +63.0%      11670        perf-stat.overall.cycles-between-cache-misses
      0.11           -19.4%       0.09        perf-stat.overall.ipc
 5.645e+09           -17.7%  4.643e+09        perf-stat.ps.branch-instructions
  37338101 ±  3%      -7.7%   34453073        perf-stat.ps.branch-misses
  31016005           -38.6%   19050425        perf-stat.ps.cache-misses
  81505741           -17.4%   67356950        perf-stat.ps.cache-references
      2878 ±  8%     -20.9%       2275 ±  5%  perf-stat.ps.context-switches
 2.394e+10           -19.3%  1.931e+10        perf-stat.ps.instructions
 1.469e+12           -19.6%  1.182e+12        perf-stat.total.instructions
     70.47           -11.9       58.54        perf-profile.calltrace.cycles-pp.handle_to_path.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open_by_handle_at
     67.22           -11.7       55.47        perf-profile.calltrace.cycles-pp._raw_spin_lock.ilookup5_nowait.ilookup5.shmem_fh_to_dentry.exportfs_decode_fh_raw
     70.16           -11.7       58.44        perf-profile.calltrace.cycles-pp.exportfs_decode_fh_raw.exportfs_decode_fh.handle_to_path.do_handle_open.do_syscall_64
     70.16           -11.7       58.44        perf-profile.calltrace.cycles-pp.exportfs_decode_fh.handle_to_path.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
     68.66           -11.7       56.94        perf-profile.calltrace.cycles-pp.ilookup5.shmem_fh_to_dentry.exportfs_decode_fh_raw.exportfs_decode_fh.handle_to_path
     70.15           -11.7       58.44        perf-profile.calltrace.cycles-pp.shmem_fh_to_dentry.exportfs_decode_fh_raw.exportfs_decode_fh.handle_to_path.do_handle_open
     67.16           -11.7       55.44        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ilookup5_nowait.ilookup5.shmem_fh_to_dentry
     68.64           -11.7       56.94        perf-profile.calltrace.cycles-pp.ilookup5_nowait.ilookup5.shmem_fh_to_dentry.exportfs_decode_fh_raw.exportfs_decode_fh
     76.88            -8.8       68.10        perf-profile.calltrace.cycles-pp.open_by_handle_at
     76.73            -8.8       67.98        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open_by_handle_at
     76.69            -8.7       67.96        perf-profile.calltrace.cycles-pp.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open_by_handle_at
     76.79            -8.7       68.07        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open_by_handle_at
      9.29            -0.1        9.17        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
      1.42            +0.0        1.46        perf-profile.calltrace.cycles-pp.find_inode.ilookup5_nowait.ilookup5.shmem_fh_to_dentry.exportfs_decode_fh_raw
      1.39            +0.1        1.45        perf-profile.calltrace.cycles-pp._raw_spin_lock.find_inode.ilookup5_nowait.ilookup5.shmem_fh_to_dentry
      1.40            +0.1        1.46        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.do_dentry_open.do_open
      1.44            +0.1        1.52        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.__fput.__x64_sys_close
      1.45            +0.1        1.53        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.path_put.do_handle_open
      1.36            +0.1        1.44        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.find_inode.ilookup5_nowait.ilookup5
      1.42            +0.1        1.50        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
      1.41            +0.1        1.50        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.do_dentry_open.do_open.path_openat
      1.46            +0.1        1.56        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.__fput.__x64_sys_close.do_syscall_64
      1.46            +0.1        1.57        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.path_put.do_handle_open.do_syscall_64
      1.43            +0.1        1.55        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_file_open_root
      1.47            +0.7        2.19        perf-profile.calltrace.cycles-pp.path_init.path_openat.do_file_open_root.file_open_root.do_handle_open
      1.86            +0.7        2.59        perf-profile.calltrace.cycles-pp.__close
      1.79            +0.7        2.52        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.45            +0.7        2.18        perf-profile.calltrace.cycles-pp.lockref_get.path_init.path_openat.do_file_open_root.file_open_root
      1.78            +0.7        2.52        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.82            +0.8        2.57        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.8        0.77        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.path_put.do_handle_open.do_syscall_64
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_file_open_root
      1.64            +0.8        2.42        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_file_open_root.file_open_root.do_handle_open
      1.67            +0.8        2.48        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.8        0.81 ±  2%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.__fput.__x64_sys_close.do_syscall_64
      1.58            +0.8        2.38        perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_file_open_root.file_open_root
      1.44            +0.8        2.28        perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.do_open.path_openat.do_file_open_root
      1.48            +0.9        2.35        perf-profile.calltrace.cycles-pp.dput.path_put.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.48            +0.9        2.35        perf-profile.calltrace.cycles-pp.path_put.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open_by_handle_at
      1.47            +0.9        2.34        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_file_open_root.file_open_root
      1.47            +0.9        2.34        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_file_open_root.file_open_root.do_handle_open
      1.50            +0.9        2.38        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.73            +2.3        7.06        perf-profile.calltrace.cycles-pp.do_file_open_root.file_open_root.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.73            +2.3        7.06        perf-profile.calltrace.cycles-pp.file_open_root.do_handle_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.open_by_handle_at
      4.67            +2.3        7.00        perf-profile.calltrace.cycles-pp.path_openat.do_file_open_root.file_open_root.do_handle_open.do_syscall_64
     10.36            +4.2       14.50        perf-profile.calltrace.cycles-pp.user_path_at_empty.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL_64_after_hwframe.name_to_handle_at
      9.93            +4.2       14.14        perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.90            +4.2       14.12        perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.__x64_sys_name_to_handle_at.do_syscall_64
      9.63            +4.4       14.03        perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.__x64_sys_name_to_handle_at
      9.63            +4.4       14.02        perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
      9.62            +4.4       14.02        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
      9.59            +4.4       14.01        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      9.69            +4.4       14.14        perf-profile.calltrace.cycles-pp.path_put.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL_64_after_hwframe.name_to_handle_at
      9.69            +4.4       14.14        perf-profile.calltrace.cycles-pp.dput.path_put.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +4.6        4.55 ±  2%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.path_put.__x64_sys_name_to_handle_at.do_syscall_64
     20.70            +8.4       29.07        perf-profile.calltrace.cycles-pp.name_to_handle_at
     20.45            +8.4       28.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.name_to_handle_at
     20.42            +8.5       28.88        perf-profile.calltrace.cycles-pp.__x64_sys_name_to_handle_at.do_syscall_64.entry_SYSCALL_64_after_hwframe.name_to_handle_at
     20.52            +8.5       28.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.name_to_handle_at
     70.47           -11.9       58.54        perf-profile.children.cycles-pp.handle_to_path
     70.16           -11.7       58.44        perf-profile.children.cycles-pp.exportfs_decode_fh_raw
     70.16           -11.7       58.44        perf-profile.children.cycles-pp.exportfs_decode_fh
     68.66           -11.7       56.94        perf-profile.children.cycles-pp.ilookup5
     70.15           -11.7       58.44        perf-profile.children.cycles-pp.shmem_fh_to_dentry
     68.65           -11.7       56.94        perf-profile.children.cycles-pp.ilookup5_nowait
     95.73           -11.6       84.14        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     96.10           -11.2       84.88        perf-profile.children.cycles-pp._raw_spin_lock
     76.90            -8.8       68.11        perf-profile.children.cycles-pp.open_by_handle_at
     76.69            -8.7       67.96        perf-profile.children.cycles-pp.do_handle_open
      0.42 ±  2%      -0.3        0.14 ± 10%  perf-profile.children.cycles-pp.open64
      0.38 ±  2%      -0.3        0.11 ±  8%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.38 ±  3%      -0.3        0.11 ±  8%  perf-profile.children.cycles-pp.do_sys_openat2
      0.33 ±  3%      -0.2        0.09 ± 13%  perf-profile.children.cycles-pp.do_filp_open
      0.20 ±  3%      -0.1        0.07 ±  8%  perf-profile.children.cycles-pp.getname_flags
      0.35 ±  4%      -0.1        0.23 ± 11%  perf-profile.children.cycles-pp.do_sys_name_to_handle
      0.14 ±  3%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.alloc_empty_file
      0.16 ±  3%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.14 ±  3%      -0.1        0.05        perf-profile.children.cycles-pp.__check_object_size
      0.12 ±  4%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.strncpy_from_user
      0.14 ±  2%      -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      1.43            +0.0        1.46        perf-profile.children.cycles-pp.find_inode
      0.28 ±  2%      +0.1        0.35        perf-profile.children.cycles-pp.putname
     99.41            +0.1       99.56        perf-profile.children.cycles-pp.do_syscall_64
     99.57            +0.2       99.81        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.86            +0.6        2.50        perf-profile.children.cycles-pp.do_open
      1.57            +0.7        2.22        perf-profile.children.cycles-pp.path_init
      1.70            +0.7        2.41        perf-profile.children.cycles-pp.do_dentry_open
      1.87            +0.7        2.59        perf-profile.children.cycles-pp.__close
      1.78            +0.7        2.52        perf-profile.children.cycles-pp.__x64_sys_close
      1.67            +0.8        2.48        perf-profile.children.cycles-pp.__fput
      1.51            +0.8        2.34        perf-profile.children.cycles-pp.terminate_walk
      2.91            +1.6        4.46        perf-profile.children.cycles-pp.lockref_get
      5.00            +2.1        7.09        perf-profile.children.cycles-pp.path_openat
      4.73            +2.3        7.06        perf-profile.children.cycles-pp.do_file_open_root
      4.73            +2.3        7.06        perf-profile.children.cycles-pp.file_open_root
     10.36            +4.1       14.51        perf-profile.children.cycles-pp.user_path_at_empty
      9.93            +4.2       14.14        perf-profile.children.cycles-pp.filename_lookup
      9.90            +4.2       14.12        perf-profile.children.cycles-pp.path_lookupat
      9.69            +4.4       14.05        perf-profile.children.cycles-pp.complete_walk
      9.68            +4.4       14.04        perf-profile.children.cycles-pp.try_to_unlazy
      9.67            +4.4       14.04        perf-profile.children.cycles-pp.__legitimize_path
      9.63            +4.4       14.02        perf-profile.children.cycles-pp.lockref_get_not_dead
     11.18            +5.3       16.49        perf-profile.children.cycles-pp.path_put
      0.28            +6.6        6.91 ±  2%  perf-profile.children.cycles-pp.lockref_put_return
     14.16            +7.0       21.20        perf-profile.children.cycles-pp.dput
     20.73            +8.4       29.08        perf-profile.children.cycles-pp.name_to_handle_at
     20.42            +8.5       28.89        perf-profile.children.cycles-pp.__x64_sys_name_to_handle_at
     95.48           -11.5       83.94        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.16 ±  3%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.do_dentry_open
      0.11 ±  5%      +0.0        0.15 ± 13%  perf-profile.self.cycles-pp.do_sys_name_to_handle
      0.27            +0.1        0.35        perf-profile.self.cycles-pp.putname
      0.16 ±  4%      +0.1        0.25 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.10 ± 12%  perf-profile.self.cycles-pp.dput
      0.37 ±  2%      +0.4        0.74        perf-profile.self.cycles-pp._raw_spin_lock
      0.08            +1.4        1.53        perf-profile.self.cycles-pp.lockref_get
      0.27 ±  2%      +4.3        4.61 ±  2%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.28            +6.6        6.90 ±  2%  perf-profile.self.cycles-pp.lockref_put_return





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


