Return-Path: <linux-kernel+bounces-275871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E6F948B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75EE1C22787
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25891BD013;
	Tue,  6 Aug 2024 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOxfDvh8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAA1BCA06
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932889; cv=fail; b=AOn9q0Nl2hDzUWcmfi0UlJrfqaZAlKTbyrH9kT1w7c7OeHR/Smbn6hsSCWfwsmgZhRAOla0cfKuOnB8Ivx0YyrcMnphz5m3eMGwPKUKU/xPXXNPVSIxWwVG55Huz25ShAIhbGzCw5SMNmSE+3/1b8mFGjtURm+w8pCh96eZ8bYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932889; c=relaxed/simple;
	bh=S/m2RpfrSUgwk6zT8kuhCHI+aVaDVK2EQz566E8GYhM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PzdSuWF1TzWXqLwu7A7A5L4DF1oJHluWrpOgg4c9qDpi0uZGonCOO5D/6lbX6j2IWSAYOXXw/02OkQsD9g+K2DKGfYoQ6xuz/YZSbLCmfZ92VVRIPPri65tjZKo4oiS7oRDm5rQRrCAAVwHUT2YRq54p9m3e4/6m2LdEbgvowYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOxfDvh8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722932886; x=1754468886;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=S/m2RpfrSUgwk6zT8kuhCHI+aVaDVK2EQz566E8GYhM=;
  b=BOxfDvh8nNfiwmZ6q7zh5chBeyuU+oYY5UXTcGgX0BbGqF09oZwGs2NA
   zMk/kQ/BSfftRPz+07Z3aR8NrVR2KNPilTZYXSrOh6rftibkaKuHvqBQw
   P9WQ9zvd53UTHxNJrMdaJ3vACg8VvK/Rue+PSvhZmw/Gvb2t9bjevuUxn
   W0gRfc39Ac3L44nFkz38B0ffyjvWpBPwjb+GFLiaC7llaFlPlQf4RIYRB
   8rRdNI20VbeSbt83uDT/DKGsg8ZTROtNVs56X+e7EpEZER5+amRO616WA
   TdK0BP+bMuo5KKTLHhpwWpwaRZayF8883LQ7vA7C3Joow5esCcGiAxGKQ
   g==;
X-CSE-ConnectionGUID: vy4dyqMbTASUDDJB/JWOHg==
X-CSE-MsgGUID: cWPw7YqTSaCp/4FyDuFhSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="21075428"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="21075428"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:28:05 -0700
X-CSE-ConnectionGUID: 3XsYJgjJQaSS66DAHEBIRw==
X-CSE-MsgGUID: zCYXUhbATRCx1GZdfRsDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="60569401"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 01:28:05 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 01:28:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 01:28:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 01:28:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUXmFaq9Uh0tpsKW+Bx6HaSkIp/e4uYCaDkn3Xt9ll7QwuzJX2kr0jypXsuyqA8OEibVSRty39YS+ChhDkYPuhgF0vYFvfe9dTgx+KNv6TziAtCuvYdZey+Jie3S9ab7I8L3/ILq24Ev9zjzIyzPxM760b9tKlLsWhX9YbecLsLrB22kMRoF6UNYG90Ma81MCt+7HoKsKp/ghEHV7H9ZxqOFF7lvjHk3zM1YSY82eKZjstLAM0wW4iPEH5wmoM1+GJj42ZiFnmPo7w3tIKpfW4SvBVzDs6xgMzh1458V+WKp3NxqfmurIq2he4cHbLkfHDhtc7iy2Sz3dapCr4MQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/sQq4PyyZiBQ/j3nAX3DyR6C4Snv74zxkbKOWub3ck=;
 b=IGHdEMPAjeKvrLodLgvp94ezzIQ6pkrbAHSno5CjoDqbfaxYpwQo8h8k4Xr6STSUdcp5Z8qBliMUuXdTP2CYIXmgPjebCUUX8+pEoFVNsvbPBxOVlhKT+/yU4GeQMajtVaGL8EPz+XsqafiZ+AJX9NE/CEda3dEBIYLRVPWyaifgaDC2uq6oz2g0cSQK1n+VyX2kJ+znrAA+jJHHUs84zoisM5BTLsggFoBS7xv9hOwiVTrAFXufrj8Vzzk3DVCtq3OzzRz0YiUfuod06BdE9zwDmhj+SW3t6h7YEhT2PEVG9hehrz7gFK/xBcplknbYkPcHeLWzpEZ1kwwvVkcOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4728.namprd11.prod.outlook.com (2603:10b6:208:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 08:27:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:27:57 +0000
Date: Tue, 6 Aug 2024 16:27:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	John Johansen <john.johansen@canonical.com>, <apparmor@lists.ubuntu.com>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [apparmor]  f4fee216df: will-it-scale.per_process_ops
 86.8% improvement
Message-ID: <202408061645.8512e812-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b1f1e4-b545-4726-63d4-08dcb5f1acc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JA7cu2Ffq4B0/Zw+lyehMq83sNxcozYzM86J0Bn3WQWS+UXY7RZEEOsACA?=
 =?iso-8859-1?Q?G0jmBa6jMlQcUgtahQajt/x2v3m+jNv3scZq2IRfv+PzmIcqHBtXMKN5pv?=
 =?iso-8859-1?Q?cdOZlfyqm9tDW1PGEmmSeSVNZfFmLMcNqyUy8s92hSX96grdx/UV0Rd3eZ?=
 =?iso-8859-1?Q?+G5eEoZXWdRBI2unO2ax0BLxAtgcz2QSVVCdPPIDGw23Bbuenrr3cnJ5cL?=
 =?iso-8859-1?Q?cjMz92sEjH+KTmNNl/dxytvSWftFVyTnALX8PrBD9LQKtLQRMomSySA3vM?=
 =?iso-8859-1?Q?jir0XuWg+BkuSi+XKgnZc5txuqFjsIuWLZU6GReTj9ZbeJAJnIRJuBL5nr?=
 =?iso-8859-1?Q?IVPlBvqgESB9j/e/SU9BxZ86nw1vdLiHR2fEoqGR6rWB6qyenk6IYy8VOY?=
 =?iso-8859-1?Q?CklHzytKJn7RYOeMrlzVK6bZVsXthBqWDy1cbZRHGECnm/n0Cu00+zYAmv?=
 =?iso-8859-1?Q?uM7m64TK3yMlK9RldPTToZl1TFTQ1JRClJIy8yXrljDa9ADrC9FUOEDP9o?=
 =?iso-8859-1?Q?3vVsEBIq0yV/cs6pZIXdMi1PgAmaBHZEPtDRD0owPM/4RSi+9LDeIKkkBV?=
 =?iso-8859-1?Q?IIUURPwoyV182eyOTlMo3hZZkU+CDm3g/i01P6K5umKbXMDyCuPlGFTAuv?=
 =?iso-8859-1?Q?y8huRFGdw/GeQh6QbMTeSG76KkVkjChQwPBkRd7G3i5St4nFa6mK8bPCY3?=
 =?iso-8859-1?Q?fAodGM10/FIvWweXFJTJ3ieYDapc/trOnY9zBra/gaA5JDMW5DUcaK+Bw8?=
 =?iso-8859-1?Q?oiRQEihFGIZbw9h6EAnAwMZmpO8PBACgKUVwVMkMgIjzP3ResynCOvA4q/?=
 =?iso-8859-1?Q?zMQ4l13Hu6ueSHHPqJs1YmQ9ugY/MA3oDcvwPnjZWesn8Gu+eo49t4+Q2E?=
 =?iso-8859-1?Q?xEQNtEmQlRzyNjG635hun7caYn5Ffvy/SyNHCyH5br9xkhQ7j/cu0ug3jX?=
 =?iso-8859-1?Q?13tnqL2mEVMLPrStQzaOFnziiLeQAD7pt2i4d0pX2jXy0TdPwyTyz+rEFk?=
 =?iso-8859-1?Q?i7jYl+fagnISEEmKYSyP9jY+tFlargLLAHP9Q6j1tafvQ7CksMQd46m8A2?=
 =?iso-8859-1?Q?m0I8n4lmgqcZtdAr1gyEs4p7PBAYeqZwiNSNbWW9grArS4df5PBqonq7TM?=
 =?iso-8859-1?Q?PtXPijsKUqsiEjVB4zvu2Oikcfh55yax6PQAKwQjki0lz1wtCVLhqeY+zr?=
 =?iso-8859-1?Q?n7z1phhEZATubZZgPDmWQpI2Hl0OpYpeVxzYXrXC3+uKM80eovpMvuKfTJ?=
 =?iso-8859-1?Q?g5jbSksgntykkYAsGc+9SLoEeHgvW9if1ZBiy7eyMYuZF8HQOBISrkjsgW?=
 =?iso-8859-1?Q?Gxqo8JGYuHdfY57TMl8uj+HfuZbwYPcIN24bUQn/rGdSRCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1ivNbkY2E/IgjdJgm/xNgnWCkJKj7YDBpG5Oo9dnQSwM/q13lPvRmnwcOf?=
 =?iso-8859-1?Q?AQ07WbiaRJoLM7UkW64aasgB/lxkwxx84DkfC6VP71/cHMPYEQD9OSqRdL?=
 =?iso-8859-1?Q?xOZFuZx7PcIhBCbtd2TfM3SIeSy6O05w5X1gVcDkxksg//fpCsFhfakQkS?=
 =?iso-8859-1?Q?bOXf91+9Hh4K/K3MAgqZLYJ+MsCiLMF3A3jOWXH6+J18atNKE2ooqoABiq?=
 =?iso-8859-1?Q?HPEYuo4e+kMQty9JOSgUPBI9kqtGjhn9g3EZDWRbta0EGuIUEFxV/yL0rZ?=
 =?iso-8859-1?Q?V/82mLqxrmlyFQQlY3aiRIoMCr/P37+66+pq+4CSwWiWhwQOzWL0NnqCAL?=
 =?iso-8859-1?Q?eSSbNRbTMcA5ev/qs4/bEp3IfGl8mcbf/6S4bXaL58nQGclNWw5v006hPT?=
 =?iso-8859-1?Q?z8/egJcGwKgHE70ukBtk5zdXncHtydTUfYVyX4Y1q8BXhjR7V+h5xrmrXG?=
 =?iso-8859-1?Q?ZglbCTe7f/R+ZGEUkxjjtWT+Ci1KcjhRggN3DxDPgDalFTi5zG3j7FxnRa?=
 =?iso-8859-1?Q?WjGjhbrmuWeLGGEkoVlmmuqmpOxR15TBatwzUKs6yZrdiNolCvFLbd56r2?=
 =?iso-8859-1?Q?tMdXVeuNzITfDEkWQqOkTklG7X2w7UIbh45E2nDHBYDK6AkYtS6bl8ioBt?=
 =?iso-8859-1?Q?xxnpuh6ry46Z4jPODkQkfPL9AnGI/4Jc5n+dg1qAMGlQHeuvatj9AtHOuR?=
 =?iso-8859-1?Q?MSgwDqw0Jn6zhKdJAHKHd7UEBkGJFu77vpIINMXWt9kjCYAmGi5+KTi9rG?=
 =?iso-8859-1?Q?A06m/qCL4CURBPYx4oW++Jt9WGBZIn2QbmZO/UhMQP8jSxP2QhSV9U1saQ?=
 =?iso-8859-1?Q?pLcSVFSKl1TWI6m2sjYds0GueW5Zk3LfuUDAwn7Kg9XfBPiDXm3TlFoxVc?=
 =?iso-8859-1?Q?6qm2L9mEDA3V2C5fxpgeYSZ36GdzpnqmOoYs2HxsTr4TX0Up77A9yjzyN/?=
 =?iso-8859-1?Q?JqT0i/RUlTLxCrBIh64f3hjG8Qq+78a7X4GZRt8zyjLpjpxuDBNzy9Sxuv?=
 =?iso-8859-1?Q?xF0s5Vyc8iFRdowcM+CE38LFzgZx97FCIUhkF/ZHj6Zg5btW7AymSXWWCr?=
 =?iso-8859-1?Q?+Dr6LxZLp2ZVgOivdG1hibu6rPrYCCmrbn6o0YvKhC8zvGC7B19WFR74zv?=
 =?iso-8859-1?Q?p/Wj/KQoc91w5skKIzPRGMKwWgYJe4HQ0ZPDZD1eBme1r6JDYUQ5nvgvjT?=
 =?iso-8859-1?Q?zIc2GyRz9VvVL1raDRVQca8F+pKD0fUdK3pdOO0gqdCYZhB8UW//6GKGm/?=
 =?iso-8859-1?Q?culJDlFueSxEKJIJu7E8Zp9baUr6B/0VrfMp7zstkgR5u9ROIdrXAXcvZU?=
 =?iso-8859-1?Q?EdiClDIm8hTcZYZSVfkLm8Gw5rjP29oXe3OfG5VNoFzLWjJua5ZcJIaont?=
 =?iso-8859-1?Q?0CCf20xYn7UBTZxaITi4k9RuitpSGvCrjx1+QDmmZvr0RFZ+tFOX8KTiPo?=
 =?iso-8859-1?Q?mXI/kEoTF1IRnpxGYEaX+SpjxCvPhSOYgF+OxQcaDXzP3yChdT7bvsqe2+?=
 =?iso-8859-1?Q?XNeH2aH7D9KMX4KfwyegjbBuqOm2AzEQEagwKQVgeu4w/E4qYhWhxnpD/6?=
 =?iso-8859-1?Q?ZJszOfGrdgfjGO+q8uBc43Yqre8u+TZJoWB/4kh4+ntpYTE+wziA7GzUts?=
 =?iso-8859-1?Q?rIZ+a9w8dq/2/T4P/DLO3kwikzOSAbAJxB5QJY5l+pxxcGre02U1+eAA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b1f1e4-b545-4726-63d4-08dcb5f1acc2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 08:27:57.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //t0sIk6j9oTCHVj0WqleDGbEdmlwUyssTJHou1ZT0SiMbgxbq3+q5dqSQSX5ogYu4VOc3RRp/KVszt29ly1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 86.8% improvement of will-it-scale.per_process_ops on:


commit: f4fee216df7d28b87d1c9cc60bcebfecb51c1a05 ("apparmor: try to avoid refing the label in apparmor_file_open")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: will-it-scale
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: open1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 89.9% improvement |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory               |
| test parameters  | cpufreq_governor=performance                                   |
|                  | mode=process                                                   |
|                  | nr_task=100%                                                   |
|                  | test=open2                                                     |
+------------------+----------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240806/202408061645.8512e812-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/open1/will-it-scale

commit: 
  4b954a0255 ("apparmor: test: add MODULE_DESCRIPTION()")
  f4fee216df ("apparmor: try to avoid refing the label in apparmor_file_open")

4b954a025591a1c7 f4fee216df7d28b87d1c9cc60bc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     49428 ±  2%      -9.4%      44773 ±  2%  meminfo.Mapped
      2267 ± 12%     +30.8%       2964 ± 13%  perf-c2c.DRAM.remote
      1799            -3.4%       1738        vmstat.system.cs
      0.01 ±  2%      -0.0        0.01 ±  4%  mpstat.cpu.all.soft%
     19.91 ±  2%      +3.6       23.53        mpstat.cpu.all.usr%
     12598 ±  2%      -8.3%      11556 ±  2%  proc-vmstat.nr_mapped
    942044            +2.1%     961357        proc-vmstat.pgfault
     44166 ±  4%      +5.9%      46785 ±  2%  proc-vmstat.pgreuse
   4223977           +86.8%    7890649 ±  2%  will-it-scale.104.processes
     40614           +86.8%      75871 ±  2%  will-it-scale.per_process_ops
   4223977           +86.8%    7890649 ±  2%  will-it-scale.workload
    664.33 ±  8%     +15.3%     765.83 ±  4%  sched_debug.cfs_rq:/.util_avg.min
     26.25 ± 13%     -54.7%      11.90 ±  9%  sched_debug.cpu.clock.stddev
      6473 ± 13%     +15.7%       7491        sched_debug.cpu.curr->pid.max
      2733 ±  3%      -9.9%       2464 ±  6%  sched_debug.cpu.curr->pid.min
     15464 ±  6%     +21.8%      18838 ± 15%  sched_debug.cpu.nr_switches.max
      1.15 ± 15%     -53.2%       0.54 ± 25%  perf-stat.i.MPKI
 4.422e+09           +81.8%   8.04e+09 ±  2%  perf-stat.i.branch-instructions
      1.37            -0.2        1.21        perf-stat.i.branch-miss-rate%
  60833526           +59.7%   97142743        perf-stat.i.branch-misses
      1735            -2.5%       1692        perf-stat.i.context-switches
     12.32           -45.3%       6.74 ±  2%  perf-stat.i.cpi
    147.73            +9.5%     161.82        perf-stat.i.cpu-migrations
 2.352e+10           +82.6%  4.294e+10 ±  2%  perf-stat.i.instructions
      0.08           +81.1%       0.15 ±  2%  perf-stat.i.ipc
      2911            +2.4%       2980        perf-stat.i.minor-faults
      2911            +2.4%       2980        perf-stat.i.page-faults
      1.15 ± 15%     -53.3%       0.54 ± 25%  perf-stat.overall.MPKI
      1.37            -0.2        1.21        perf-stat.overall.branch-miss-rate%
     12.31           -45.2%       6.75 ±  2%  perf-stat.overall.cpi
      0.08           +82.5%       0.15 ±  2%  perf-stat.overall.ipc
   1678007            -2.3%    1640017        perf-stat.overall.path-length
 4.406e+09           +81.8%  8.011e+09 ±  2%  perf-stat.ps.branch-instructions
  60541777           +59.8%   96742204 ±  2%  perf-stat.ps.branch-misses
      1728            -2.5%       1684        perf-stat.ps.context-switches
    146.56            +9.9%     161.12        perf-stat.ps.cpu-migrations
 2.344e+10           +82.5%  4.278e+10 ±  2%  perf-stat.ps.instructions
      2908            +2.1%       2968        perf-stat.ps.minor-faults
      2908            +2.1%       2968        perf-stat.ps.page-faults
 7.088e+12           +82.6%  1.294e+13 ±  2%  perf-stat.total.instructions
     27.50           -22.0        5.50 ±  8%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
     27.44           -22.0        5.45 ±  8%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
     29.31           -21.9        7.44 ±  5%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
     34.77           -19.0       15.76 ±  4%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     57.64           -10.0       47.68        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     57.75            -9.9       47.86        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     58.02            -9.7       48.28        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     59.64            -9.6       50.01        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     53.06            -8.6       44.46        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     73.77            -8.6       65.21        perf-profile.calltrace.cycles-pp.open64
     53.26            -8.5       44.81        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±  2%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.61            +0.3        0.95 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.44 ± 45%      +0.3        0.79 ± 19%  perf-profile.calltrace.cycles-pp.__legitimize_mnt.__legitimize_path.try_to_unlazy.complete_walk.do_open
      0.54            +0.4        0.90 ±  2%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.00            +0.5        0.55 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.76            +0.6        1.33 ±  3%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      0.92            +0.6        1.55 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.36 ± 70%      +0.8        1.13 ± 12%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.open64
      0.00            +0.8        0.84 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__close
      8.20            +0.9        9.10 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.open64
      0.09 ±223%      +1.0        1.09 ± 13%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.__fput.__x64_sys_close.do_syscall_64
      2.10 ±  3%      +1.9        4.03 ±  4%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__close
      3.34 ±  6%      +2.6        5.95 ±  6%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
      3.36 ±  6%      +2.6        5.98 ±  6%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
      3.68 ±  5%      +2.7        6.35 ±  6%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      3.72 ±  5%      +2.7        6.44 ±  6%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
     12.08            +4.1       16.20 ±  3%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.04            +4.1       16.16 ±  3%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
     15.12 ±  2%      +5.5       20.61 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     18.55            +5.8       24.32        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     16.03            +6.0       22.03 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     16.49            +6.1       22.56 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.42            +8.4       33.82        perf-profile.calltrace.cycles-pp.__close
     15.22            +9.3       24.54        perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
     14.20            +9.7       23.86        perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
     16.01            +9.8       25.77        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     14.48            +9.8       24.32        perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
     27.46           -22.0        5.45 ±  8%  perf-profile.children.cycles-pp.apparmor_file_open
     27.50           -22.0        5.51 ±  8%  perf-profile.children.cycles-pp.security_file_open
     29.32           -21.9        7.46 ±  5%  perf-profile.children.cycles-pp.do_dentry_open
     34.79           -19.0       15.79 ±  4%  perf-profile.children.cycles-pp.do_open
     57.70           -10.0       47.75        perf-profile.children.cycles-pp.do_sys_openat2
     57.78            -9.9       47.89        perf-profile.children.cycles-pp.__x64_sys_openat
     53.11            -8.6       44.52        perf-profile.children.cycles-pp.path_openat
     53.29            -8.5       44.83        perf-profile.children.cycles-pp.do_filp_open
     73.40            -8.1       65.34        perf-profile.children.cycles-pp.open64
     78.94            -4.1       74.80        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     75.12            -3.9       71.21        perf-profile.children.cycles-pp.do_syscall_64
      2.63 ± 11%      -2.2        0.44 ± 18%  perf-profile.children.cycles-pp.putname
      0.56 ± 11%      -0.4        0.14 ±  8%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.48 ± 17%      -0.4        0.12 ±  5%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.80 ±  2%      -0.3        0.53 ±  5%  perf-profile.children.cycles-pp.terminate_walk
      0.35 ±  5%      -0.2        0.17 ± 60%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.30 ±  6%      -0.2        0.14 ± 70%  perf-profile.children.cycles-pp.generic_perform_write
      0.15 ±  8%      -0.1        0.06 ±102%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.15 ±  8%      -0.1        0.06 ±102%  perf-profile.children.cycles-pp.shmem_write_begin
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.lockref_get
      0.29 ±  2%      +0.0        0.30        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24 ±  2%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.ima_file_free
      0.09 ±  7%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.09 ±  7%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.set_root
      0.03 ± 70%      +0.0        0.07 ± 12%  perf-profile.children.cycles-pp.make_vfsuid
      0.04 ± 44%      +0.0        0.08        perf-profile.children.cycles-pp.rcu_all_qs
      0.12 ±  4%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.nd_jump_root
      0.05 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.security_inode_permission
      0.03 ± 70%      +0.0        0.08        perf-profile.children.cycles-pp.file_ra_state_init
      0.10 ±  6%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__lookup_mnt
      0.14 ±  6%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.fd_install
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._find_next_zero_bit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.expand_files
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.path_get
      0.06 ±  7%      +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.current_obj_cgroup
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.get_unused_fd_flags
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.locks_remove_file
      0.18 ±  3%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.file_close_fd
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.getname
      0.10 ±  5%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.08 ±  4%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.refill_obj_stock
      0.16 ±  2%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.path_init
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.dnotify_flush
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.file_close_fd_locked
      0.17 ±  3%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.80 ±  4%      +0.1        0.88 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.10 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.memset_orig
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.should_failslab
      0.16 ±  2%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.walk_component
      0.10 ±  3%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.locks_remove_posix
      0.26            +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.alloc_fd
      0.25 ±  5%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.08 ±  4%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.build_open_flags
      0.24 ±  3%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      0.29 ±  4%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      0.17            +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.18 ±  5%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.30 ±  4%      +0.1        0.44        perf-profile.children.cycles-pp.open_last_lookups
      0.24 ±  5%      +0.2        0.39 ±  6%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.22 ±  4%      +0.2        0.37 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.25            +0.2        0.41 ±  2%  perf-profile.children.cycles-pp.step_into
      0.18 ± 17%      +0.2        0.34 ± 14%  perf-profile.children.cycles-pp.testcase
      0.21 ±  2%      +0.2        0.38 ±  4%  perf-profile.children.cycles-pp.generic_permission
      0.17 ±  2%      +0.2        0.33 ±  3%  perf-profile.children.cycles-pp.filp_flush
      0.33 ±  2%      +0.2        0.53 ±  3%  perf-profile.children.cycles-pp.may_open
      0.39            +0.2        0.62 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      0.53 ±  5%      +0.3        0.79 ± 19%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.44 ±  2%      +0.3        0.71 ±  4%  perf-profile.children.cycles-pp.inode_permission
      1.06 ±  9%      +0.3        1.36 ±  9%  perf-profile.children.cycles-pp.lockref_put_return
      1.18 ±  8%      +0.3        1.53 ±  8%  perf-profile.children.cycles-pp.dput
      0.54            +0.4        0.91 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      0.76            +0.6        1.34 ±  3%  perf-profile.children.cycles-pp.getname_flags
      0.93            +0.6        1.56 ±  3%  perf-profile.children.cycles-pp.link_path_walk
      1.01            +0.7        1.68        perf-profile.children.cycles-pp.kmem_cache_alloc
      1.36 ±  2%      +0.7        2.03 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      5.83 ±  4%      +2.1        7.96 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      3.35 ±  6%      +2.6        5.96 ±  6%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      3.37 ±  6%      +2.6        5.98 ±  6%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      3.69 ±  5%      +2.7        6.36 ±  6%  perf-profile.children.cycles-pp.ima_file_check
      3.73 ±  5%      +2.7        6.45 ±  6%  perf-profile.children.cycles-pp.security_file_post_open
     12.09            +4.1       16.21 ±  3%  perf-profile.children.cycles-pp.security_file_free
     12.06            +4.1       16.18 ±  3%  perf-profile.children.cycles-pp.apparmor_file_free_security
     15.16 ±  2%      +5.5       20.67 ±  2%  perf-profile.children.cycles-pp.__fput
     16.04            +6.0       22.04 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
     25.52            +8.5       34.00        perf-profile.children.cycles-pp.__close
     15.24            +9.3       24.58        perf-profile.children.cycles-pp.init_file
     14.22            +9.7       23.88        perf-profile.children.cycles-pp.apparmor_file_alloc_security
     16.03            +9.8       25.80        perf-profile.children.cycles-pp.alloc_empty_file
     14.48            +9.8       24.33        perf-profile.children.cycles-pp.security_file_alloc
     27.37           -21.9        5.43 ±  8%  perf-profile.self.cycles-pp.apparmor_file_open
      2.62 ± 11%      -2.2        0.44 ± 18%  perf-profile.self.cycles-pp.putname
      0.74 ± 20%      -0.5        0.22 ± 34%  perf-profile.self.cycles-pp.init_file
      0.56 ± 11%      -0.4        0.13 ±  8%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.48 ± 17%      -0.4        0.12 ±  5%  perf-profile.self.cycles-pp.mnt_get_write_access
      3.89 ±  2%      -0.2        3.64        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.56 ±  5%      -0.1        0.49 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.25            -0.0        0.23 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.lockref_get
      0.06 ± 13%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.dput
      0.05            +0.0        0.07 ±  8%  perf-profile.self.cycles-pp.path_init
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ima_file_free
      0.13 ±  8%      +0.0        0.15        perf-profile.self.cycles-pp.do_sys_openat2
      0.07 ±  5%      +0.0        0.09 ±  7%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.08 ±  8%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.set_root
      0.09 ±  6%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.security_file_release
      0.06 ±  7%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.check_heap_object
      0.06 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.security_file_alloc
      0.05            +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.security_inode_permission
      0.13 ±  6%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.fd_install
      0.10 ±  6%      +0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__lookup_mnt
      0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.open_last_lookups
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.current_obj_cgroup
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.locks_remove_file
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.security_file_open
      0.08 ±  6%      +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.ima_file_check
      0.06            +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.lookup_fast
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.try_to_unlazy
      0.08 ±  4%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.06 ±  8%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.getname_flags
      0.08 ±  4%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.__x64_sys_openat
      0.19 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.do_open
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.terminate_walk
      0.08 ±  4%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.__x64_sys_close
      0.02 ± 99%      +0.1        0.09 ±  6%  perf-profile.self.cycles-pp.__check_object_size
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.make_vfsuid
      0.10 ±  5%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.alloc_empty_file
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.dnotify_flush
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.refill_obj_stock
      0.16 ±  3%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.08            +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__check_heap_object
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.file_close_fd_locked
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.filp_flush
      0.45 ±  7%      +0.1        0.52 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.11 ± 11%      +0.1        0.18 ±  7%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.10 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.memset_orig
      0.09 ±  5%      +0.1        0.16 ±  4%  perf-profile.self.cycles-pp.may_open
      0.12 ±  4%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.path_openat
      0.09 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.alloc_fd
      0.00            +0.1        0.08 ± 13%  perf-profile.self.cycles-pp.security_file_post_open
      0.20 ±  3%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.inode_permission
      0.10            +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.locks_remove_posix
      0.12 ±  7%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.24 ±  5%      +0.1        0.34 ±  4%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.13 ±  2%      +0.1        0.23        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.08 ±  4%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.build_open_flags
      0.12 ±  5%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.15            +0.1        0.26        perf-profile.self.cycles-pp.step_into
      0.14 ± 18%      +0.1        0.28 ± 15%  perf-profile.self.cycles-pp.testcase
      0.17 ±  2%      +0.1        0.31 ±  3%  perf-profile.self.cycles-pp.do_filp_open
      0.16 ±  3%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
      0.18 ±  2%      +0.1        0.32 ±  4%  perf-profile.self.cycles-pp.generic_permission
      0.32 ±  2%      +0.2        0.55 ±  2%  perf-profile.self.cycles-pp.link_path_walk
      0.53 ±  5%      +0.2        0.78 ± 19%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.83 ±  3%      +0.3        1.12 ±  6%  perf-profile.self.cycles-pp.do_dentry_open
      1.04 ±  9%      +0.3        1.33 ±  9%  perf-profile.self.cycles-pp.lockref_put_return
      0.31 ±  4%      +0.3        0.62 ±  6%  perf-profile.self.cycles-pp.__close
      0.55 ±  3%      +0.3        0.88 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      1.26 ± 13%      +0.5        1.79 ±  8%  perf-profile.self.cycles-pp.__fput
      1.22 ±  2%      +0.6        1.79 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.54 ±  2%      +0.6        1.14 ±  3%  perf-profile.self.cycles-pp.open64
      5.82 ±  4%      +2.1        7.95 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      3.34 ±  6%      +2.6        5.93 ±  6%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
     12.02            +4.1       16.12 ±  3%  perf-profile.self.cycles-pp.apparmor_file_free_security
     14.16            +9.6       23.77        perf-profile.self.cycles-pp.apparmor_file_alloc_security


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-13/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/open2/will-it-scale

commit: 
  4b954a0255 ("apparmor: test: add MODULE_DESCRIPTION()")
  f4fee216df ("apparmor: try to avoid refing the label in apparmor_file_open")

4b954a025591a1c7 f4fee216df7d28b87d1c9cc60bc 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    249.33 ±  6%     -17.6%     205.50 ±  5%  perf-c2c.DRAM.local
      0.01 ±  3%      -0.0        0.01 ±  2%  mpstat.cpu.all.soft%
     20.98            +2.5       23.51        mpstat.cpu.all.usr%
     12601            -7.4%      11670 ±  2%  proc-vmstat.nr_mapped
    942394            +1.1%     952552        proc-vmstat.pgfault
   4247367 ±  2%     +89.9%    8065531 ±  2%  will-it-scale.104.processes
     40839 ±  2%     +89.9%      77552 ±  2%  will-it-scale.per_process_ops
   4247367 ±  2%     +89.9%    8065531 ±  2%  will-it-scale.workload
      0.17 ±  7%     +14.1%       0.19 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
    661.83 ±  6%     +17.8%     779.44 ±  5%  sched_debug.cfs_rq:/.util_avg.min
     83.36 ±  9%     -20.2%      66.48 ±  6%  sched_debug.cfs_rq:/.util_avg.stddev
     28.08 ± 21%     -56.2%      12.28 ± 10%  sched_debug.cpu.clock.stddev
      6766 ±  7%     +10.1%       7453        sched_debug.cpu.curr->pid.max
    479.21 ±  8%     +18.6%     568.35 ±  4%  sched_debug.cpu.curr->pid.stddev
      0.16 ±  6%     +19.2%       0.19 ±  4%  sched_debug.cpu.nr_running.stddev
 4.727e+09           +85.0%  8.745e+09 ±  2%  perf-stat.i.branch-instructions
      1.30            -0.1        1.16        perf-stat.i.branch-miss-rate%
  61798172           +63.6%  1.011e+08        perf-stat.i.branch-misses
  51989930 ±  3%     +36.8%   71137035 ± 16%  perf-stat.i.cache-references
      1736            -2.5%       1693        perf-stat.i.context-switches
     11.45           -46.3%       6.15 ±  2%  perf-stat.i.cpi
    147.02           +10.4%     162.36        perf-stat.i.cpu-migrations
 2.531e+10           +85.8%  4.701e+10 ±  2%  perf-stat.i.instructions
      0.09           +83.2%       0.17 ±  2%  perf-stat.i.ipc
      2914            +1.6%       2961        perf-stat.i.minor-faults
      2914            +1.6%       2961        perf-stat.i.page-faults
      1.31            -0.2        1.16        perf-stat.overall.branch-miss-rate%
     11.45           -46.2%       6.16 ±  2%  perf-stat.overall.cpi
      0.09           +85.8%       0.16 ±  2%  perf-stat.overall.ipc
   1793538            -2.0%    1757241        perf-stat.overall.path-length
 4.708e+09           +85.1%  8.715e+09 ±  2%  perf-stat.ps.branch-instructions
  61472201           +63.8%  1.007e+08        perf-stat.ps.branch-misses
  51839476 ±  3%     +36.8%   70941593 ± 16%  perf-stat.ps.cache-references
      1727            -2.3%       1687        perf-stat.ps.context-switches
    146.09           +10.7%     161.70        perf-stat.ps.cpu-migrations
 2.521e+10           +85.8%  4.684e+10 ±  2%  perf-stat.ps.instructions
      2904            +1.5%       2949        perf-stat.ps.minor-faults
      2905            +1.5%       2950        perf-stat.ps.page-faults
 7.618e+12           +86.1%  1.417e+13 ±  2%  perf-stat.total.instructions
     27.03           -21.5        5.50 ±  8%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
     26.97           -21.5        5.45 ±  8%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
     28.84           -21.5        7.36 ±  5%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
     34.03           -18.5       15.56 ±  4%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     56.98            -8.7       48.26        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     57.10            -8.6       48.46        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     57.38            -8.5       48.87        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     58.68            -8.1       50.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     52.91            -7.8       45.09        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     53.11            -7.7       45.46        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     73.53            -7.5       66.00        perf-profile.calltrace.cycles-pp.open64
      4.26 ±  2%      -0.6        3.69        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.open64
      1.41 ±  3%      -0.5        0.88 ±  9%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.do_open.path_openat
      1.46 ±  3%      -0.5        0.96 ±  8%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.do_open.path_openat.do_filp_open
      1.48 ±  3%      -0.5        1.00 ±  8%  perf-profile.calltrace.cycles-pp.complete_walk.do_open.path_openat.do_filp_open.do_sys_openat2
      3.87            -0.3        3.53 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__close
      0.64            +0.3        0.97 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.57 ±  3%      +0.4        0.93 ±  2%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.18 ±141%      +0.5        0.68 ±  7%  perf-profile.calltrace.cycles-pp.security_file_release.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.5        0.54 ±  3%  perf-profile.calltrace.cycles-pp.may_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.6        0.55 ±  3%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.6        0.55 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.81 ±  3%      +0.6        1.38 ±  2%  perf-profile.calltrace.cycles-pp.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      1.57            +0.8        2.37 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +0.8        0.82 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.open64
      0.00            +0.9        0.86 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__close
      0.08 ±223%      +0.9        1.00 ± 10%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.94 ± 11%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.__fput.__x64_sys_close.do_syscall_64
      8.24            +1.1        9.34 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.open64
      2.09            +1.8        3.88        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__close
      2.83 ±  4%      +3.1        5.89 ±  7%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
      2.85 ±  4%      +3.1        5.92 ±  7%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
      3.16 ±  3%      +3.1        6.30 ±  6%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      3.21 ±  3%      +3.2        6.38 ±  6%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
     12.29            +3.9       16.23 ±  2%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
     12.33            +3.9       16.28        perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.97            +5.1       20.09 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     18.63            +5.2       23.85 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     15.87            +5.7       21.59 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     16.37            +5.7       22.09 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     25.79            +7.4       33.19        perf-profile.calltrace.cycles-pp.__close
     15.19            +9.4       24.56        perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
     14.22            +9.7       23.89        perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
     16.02            +9.8       25.81        perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     14.51            +9.9       24.36        perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
     26.99           -21.5        5.45 ±  8%  perf-profile.children.cycles-pp.apparmor_file_open
     27.04           -21.5        5.50 ±  8%  perf-profile.children.cycles-pp.security_file_open
     28.86           -21.5        7.38 ±  5%  perf-profile.children.cycles-pp.do_dentry_open
     34.05           -18.5       15.60 ±  4%  perf-profile.children.cycles-pp.do_open
     57.04            -8.7       48.33        perf-profile.children.cycles-pp.do_sys_openat2
     57.12            -8.6       48.48        perf-profile.children.cycles-pp.__x64_sys_openat
     52.96            -7.8       45.15        perf-profile.children.cycles-pp.path_openat
     53.13            -7.7       45.48        perf-profile.children.cycles-pp.do_filp_open
     73.15            -7.0       66.14        perf-profile.children.cycles-pp.open64
     78.00            -3.3       74.75        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     74.31            -3.1       71.23        perf-profile.children.cycles-pp.do_syscall_64
      2.09 ±  4%      -1.8        0.28 ± 13%  perf-profile.children.cycles-pp.putname
      0.76 ± 11%      -0.6        0.12 ±  6%  perf-profile.children.cycles-pp.lockref_get_not_dead
      1.42 ±  3%      -0.5        0.88 ±  9%  perf-profile.children.cycles-pp.__legitimize_path
      1.46 ±  3%      -0.5        0.97 ±  8%  perf-profile.children.cycles-pp.try_to_unlazy
      1.48 ±  3%      -0.5        1.01 ±  8%  perf-profile.children.cycles-pp.complete_walk
      0.40 ± 14%      -0.3        0.11 ±  3%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.77 ±  3%      -0.3        0.50 ±  5%  perf-profile.children.cycles-pp.terminate_walk
      0.33 ±  8%      -0.2        0.11 ± 67%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.29 ±  6%      -0.2        0.10 ± 63%  perf-profile.children.cycles-pp.generic_perform_write
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.lockref_get
      0.05            +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.path_get
      0.24            +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.10 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.security_inode_permission
      0.22 ±  7%      +0.0        0.25 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.09 ±  4%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.08 ±  8%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.ima_file_free
      0.15 ±  5%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.fd_install
      0.06 ±  6%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.make_vfsuid
      0.05            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.60 ±  2%      +0.0        0.64        perf-profile.children.cycles-pp.__fsnotify_parent
      0.08 ±  5%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.set_root
      0.07            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ± 10%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.__lookup_mnt
      0.08 ±  5%      +0.1        0.14 ±  9%  perf-profile.children.cycles-pp.mntput_no_expire
      0.12 ±  6%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.nd_jump_root
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.current_obj_cgroup
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.get_unused_fd_flags
      0.00            +0.1        0.06        perf-profile.children.cycles-pp._find_next_zero_bit
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.expand_files
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.locks_remove_file
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.dnotify_flush
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.refill_obj_stock
      0.02 ±141%      +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.should_failslab
      0.10 ±  5%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.mod_objcg_state
      0.08 ±  4%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.__check_heap_object
      0.02 ±141%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.file_ra_state_init
      0.18 ±  9%      +0.1        0.25 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.getname
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.file_close_fd_locked
      0.17 ±  9%      +0.1        0.25 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.11 ±  4%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.memset_orig
      0.17 ±  2%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.path_init
      0.10 ±  3%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.locks_remove_posix
      0.26 ±  5%      +0.1        0.37 ±  3%  perf-profile.children.cycles-pp.check_heap_object
      0.27 ±  3%      +0.1        0.38        perf-profile.children.cycles-pp.alloc_fd
      0.16 ±  5%      +0.1        0.28 ±  4%  perf-profile.children.cycles-pp.file_close_fd
      0.09 ±  5%      +0.1        0.20 ±  5%  perf-profile.children.cycles-pp.build_open_flags
      0.31 ± 12%      +0.1        0.43 ± 10%  perf-profile.children.cycles-pp.evm_file_release
      0.77 ±  3%      +0.1        0.90 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.23 ±  2%      +0.1        0.36 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.17 ±  4%      +0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.18 ±  2%      +0.2        0.34 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.34 ±  5%      +0.2        0.50 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.32 ±  3%      +0.2        0.49 ±  2%  perf-profile.children.cycles-pp.generic_permission
      0.24 ±  2%      +0.2        0.40 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.24 ±  4%      +0.2        0.42 ±  2%  perf-profile.children.cycles-pp.open_last_lookups
      0.17 ±  4%      +0.2        0.34 ±  3%  perf-profile.children.cycles-pp.filp_flush
      0.49 ±  8%      +0.2        0.69 ±  6%  perf-profile.children.cycles-pp.security_file_release
      0.34 ±  4%      +0.2        0.54 ±  2%  perf-profile.children.cycles-pp.walk_component
      0.40 ±  5%      +0.2        0.61 ±  3%  perf-profile.children.cycles-pp.lookup_fast
      0.35 ±  2%      +0.2        0.56 ±  3%  perf-profile.children.cycles-pp.may_open
      0.32 ±  2%      +0.2        0.53 ±  3%  perf-profile.children.cycles-pp.step_into
      0.41 ±  3%      +0.2        0.63 ±  2%  perf-profile.children.cycles-pp.__check_object_size
      0.66 ±  2%      +0.3        0.92 ±  2%  perf-profile.children.cycles-pp.inode_permission
      0.58 ±  3%      +0.4        0.94 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      0.81 ±  2%      +0.6        1.39 ±  2%  perf-profile.children.cycles-pp.getname_flags
      1.39            +0.7        2.06        perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.06            +0.7        1.72 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.58            +0.8        2.39 ±  2%  perf-profile.children.cycles-pp.link_path_walk
      6.45            +1.3        7.71        perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.83 ±  4%      +3.1        5.90 ±  7%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      2.85 ±  4%      +3.1        5.92 ±  7%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      3.17 ±  3%      +3.1        6.31 ±  6%  perf-profile.children.cycles-pp.ima_file_check
      3.21 ±  3%      +3.2        6.38 ±  6%  perf-profile.children.cycles-pp.security_file_post_open
     12.30            +3.9       16.24 ±  2%  perf-profile.children.cycles-pp.apparmor_file_free_security
     12.34            +3.9       16.29        perf-profile.children.cycles-pp.security_file_free
     15.01            +5.2       20.16 ±  2%  perf-profile.children.cycles-pp.__fput
     15.88            +5.7       21.60 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
     25.88            +7.5       33.38        perf-profile.children.cycles-pp.__close
     15.20            +9.4       24.57        perf-profile.children.cycles-pp.init_file
     14.24            +9.7       23.91        perf-profile.children.cycles-pp.apparmor_file_alloc_security
     16.04            +9.8       25.84        perf-profile.children.cycles-pp.alloc_empty_file
     14.52            +9.9       24.37        perf-profile.children.cycles-pp.security_file_alloc
     26.90           -21.5        5.43 ±  8%  perf-profile.self.cycles-pp.apparmor_file_open
      2.08 ±  4%      -1.8        0.28 ± 13%  perf-profile.self.cycles-pp.putname
      0.75 ± 12%      -0.6        0.12 ±  6%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.68 ± 10%      -0.5        0.18 ±  4%  perf-profile.self.cycles-pp.init_file
      0.40 ± 14%      -0.3        0.11 ±  3%  perf-profile.self.cycles-pp.mnt_get_write_access
      3.75            -0.2        3.58 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.53 ±  4%      -0.0        0.49 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.lockref_get
      0.08 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.ima_file_free
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.dput
      0.14 ±  4%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.fd_install
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.security_inode_permission
      0.06 ±  9%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.make_vfsuid
      0.07            +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.check_heap_object
      0.12 ±  8%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.do_sys_openat2
      0.06            +0.0        0.10        perf-profile.self.cycles-pp.security_file_alloc
      0.60 ±  3%      +0.0        0.64        perf-profile.self.cycles-pp.__fsnotify_parent
      0.09 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.security_file_release
      0.03 ± 70%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.path_init
      0.10 ±  7%      +0.0        0.15 ±  7%  perf-profile.self.cycles-pp.__lookup_mnt
      0.08 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.set_root
      0.06 ±  7%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06            +0.1        0.11        perf-profile.self.cycles-pp.lookup_fast
      0.00            +0.1        0.05        perf-profile.self.cycles-pp._find_next_zero_bit
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.expand_files
      0.07 ±  6%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.open_last_lookups
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.current_obj_cgroup
      0.08 ±  4%      +0.1        0.13 ± 10%  perf-profile.self.cycles-pp.mntput_no_expire
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.nd_jump_root
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.security_file_open
      0.08 ±  6%      +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.ima_file_check
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.get_unused_fd_flags
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.locks_remove_file
      0.06            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.getname_flags
      0.05 ±  7%      +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.walk_component
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.try_to_unlazy
      0.03 ± 70%      +0.1        0.09 ±  6%  perf-profile.self.cycles-pp.__check_object_size
      0.17 ±  9%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.dnotify_flush
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.alloc_empty_file
      0.08            +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__x64_sys_openat
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.refill_obj_stock
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__x64_sys_close
      0.08 ±  4%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__check_heap_object
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.rcu_all_qs
      0.09 ±  5%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.mod_objcg_state
      0.12 ±  4%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.path_openat
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.security_file_post_open
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.filp_flush
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.file_close_fd_locked
      0.31 ±  3%      +0.1        0.39 ±  4%  perf-profile.self.cycles-pp.inode_permission
      0.17 ± 11%      +0.1        0.25 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.13 ±  5%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  3%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.memset_orig
      0.09 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.08 ±  5%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.may_open
      0.10 ±  7%      +0.1        0.19 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.09 ±  4%      +0.1        0.18 ±  4%  perf-profile.self.cycles-pp.alloc_fd
      0.10 ±  3%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.locks_remove_posix
      0.13 ±  2%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.12 ±  6%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.do_open
      0.09 ±  5%      +0.1        0.20 ±  5%  perf-profile.self.cycles-pp.build_open_flags
      0.31 ± 13%      +0.1        0.43 ± 10%  perf-profile.self.cycles-pp.evm_file_release
      0.13 ±  2%      +0.1        0.25 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  2%      +0.1        0.42 ±  3%  perf-profile.self.cycles-pp.generic_permission
      0.17 ±  4%      +0.1        0.30        perf-profile.self.cycles-pp.strncpy_from_user
      0.90 ±  4%      +0.1        1.03 ±  6%  perf-profile.self.cycles-pp.do_dentry_open
      0.17            +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.do_filp_open
      0.34 ±  6%      +0.2        0.48 ±  3%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.21 ±  3%      +0.2        0.37 ±  4%  perf-profile.self.cycles-pp.step_into
      0.48 ±  3%      +0.3        0.78 ±  3%  perf-profile.self.cycles-pp.link_path_walk
      0.58 ±  2%      +0.3        0.90 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.35 ±  7%      +0.3        0.69 ± 12%  perf-profile.self.cycles-pp.__close
      1.12 ±  5%      +0.4        1.55 ±  9%  perf-profile.self.cycles-pp.__fput
      1.25            +0.6        1.80        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.53 ±  3%      +0.6        1.16 ±  3%  perf-profile.self.cycles-pp.open64
      6.44            +1.3        7.70        perf-profile.self.cycles-pp.syscall_return_via_sysret
      2.82 ±  4%      +3.1        5.87 ±  7%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
     12.26            +3.9       16.18 ±  2%  perf-profile.self.cycles-pp.apparmor_file_free_security
     14.17            +9.6       23.80        perf-profile.self.cycles-pp.apparmor_file_alloc_security





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


