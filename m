Return-Path: <linux-kernel+bounces-288867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F70953FCD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B52AB22C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8F54F87;
	Fri, 16 Aug 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjVPO0Cx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952F5473E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723776015; cv=fail; b=nAptcHp+Tgn1DKZ6cHBR4uMC7CzqkjAxlUJzd/07GTbuMb8ojJqfeX0tcXjfsB7HWCyp5bXlCjBGVuhtWplRsZ5FouAWMV6+XvhIpfekhN7X5mftQ6zgiLKhhRpK9fJc+jRvMtJNV6aJHe4QiRRC1CJtN2gTcwd5r/CAmXELOv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723776015; c=relaxed/simple;
	bh=Kuix5Rjpc13Ljdqnc7hv0HkM8t0rLlRQ97/JWHwqVAU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z5DsJNmQxPkTN3qppnPy4LvPD8Cd9mqoZWgF2TMvSeQPOviMB6C3yRolxjEsNrn7CLJag9lb0pLBQHe2HgR95szkGMI5VnaOa0rIFtj5z0vYgvjwarJvdHIAogVV6NXpVo1m6zAkuJZJct1j+TqtO00Uv7oonpiwKctOOxBZCUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjVPO0Cx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723776012; x=1755312012;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Kuix5Rjpc13Ljdqnc7hv0HkM8t0rLlRQ97/JWHwqVAU=;
  b=bjVPO0CxPhkZeMQtgOL1Hk2uQQQVh/olO+Zr2mrnAUsMiNE5qOBjjfLy
   yAInrsysllWi5p+MjkzkIcPdHl05EtHjgBG2HSZheBEcLk4Kp9tvwwdXM
   5L/l7nhTZacMzx7bOH/W3b2V/yg6m2vbUlmdUvZzg4pUPbvN4Ro8jsZ8H
   h35fYYWIwKRMlMSPVkDaSqSuKYsYnrXXC6zkHEx9HCmTshxGqoEVP6e+4
   GejtIcKVdghHoLkShrY9HpgR5Z1YlE0Jo/hGe1kMn+TRfd1DJnvLuaHWq
   T73OBqTNORH4cZJqY5UpGOAw/rdrJXGVHNfIokSfuxX46pd02eWuQsmTB
   w==;
X-CSE-ConnectionGUID: CJCYpFZgSsOdIKaE4xksEQ==
X-CSE-MsgGUID: VTCnL/XyQLm8CDOgerhbiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21919809"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21919809"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:40:12 -0700
X-CSE-ConnectionGUID: roLCsoL/RkaS0PnOqbTBuA==
X-CSE-MsgGUID: W39C2o2iT7Clpf9N5UZCaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60106878"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 19:40:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:40:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:40:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 19:40:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 19:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4Ym5w6x6AauJgHNpeKelHUGnvnWkqu1Jocf4AGEhbtoxY7fmKSJEPejSn3Pz9HVcgzS1TQnbIyxKrZvYyFC/vV84zjzUVuyhAGRjHKBfM1rON3CQkS74aK8Z5SoBeDzrA97ZW0+x1lQT/ld1rfDWGdTyTULVefKc4ICo4tkrAo3dOuae4uGBohz1OsQ5dhoPlJdyMK1C8+HGGYqgn0+NOWMAEBdZhpw2t0OsImAR30+9YCmAsH555MZZI8vTRrMpP5y4j8doCk0pg+UDUh+/U7WgIlzIFTJw/cCTyGwJ1KaZfdUZG7onsIzNzxWhhPr5PLUYTWrOD+BFFlM1ZB6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imO+WEzUnPa+6f0CiEBafpiAh+ABb3jn0l1MM1ggUlE=;
 b=gVA4RjUH1ERVdfIh9R1GrHIeRt00vkqIIqZch5w/8iQVu3nsA8pxY2NDeJpM8pZHVdVhgUL97+F0JKbfNAhJATZ32/to6SYSMBd21+X3zlT7sy9WsNvKW5vU0wpjMp0QaDCNj6kbR1FsE1xHuoQ7cusORJedh6+57A9V/w2HzPzKuDzSX/R+ZpseoFceCjBQ90Wj76x5Wr+adWvViGVp+H8Sg8QpVwtknVsoxN5vTkUjISzyXqJlac6a3bJzyoROgE1iuA0SgtX+1cxjzkafa3TGqAm0RWdrgaejxteY4sxlBrZur+YZEB0tI95VLd0xPQgSNoOEK4It1MrDqsZOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 02:40:09 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7828.031; Fri, 16 Aug 2024
 02:40:08 +0000
Date: Fri, 16 Aug 2024 10:40:00 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Peter Foley <pefoley2@pefoley.com>, <llvm@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Richard
 Weinberger" <richard@nod.at>
Subject: Re: /usr/bin/ld: ../lib/LLVMgold.so: cannot open shared object file:
 No such file or directory
Message-ID: <Zr68AOqR2A3hKv2k@rli9-mobl>
References: <202408160932.BvHwO6Qo-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202408160932.BvHwO6Qo-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|IA1PR11MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9b42fd-fe53-4197-33a5-08dcbd9cbe34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L9gF+k4SCinC7umV8BU/Kf7ueM4Gf2PlS0l+HszIa4z1/WtOoB7pG36LXQ92?=
 =?us-ascii?Q?Wgqkcf1KffzO/8/WK009AOc0Kxi1dkGQHzk9w2aefhjQzeDJuDB79icLAkaN?=
 =?us-ascii?Q?lyuLyxgRM/6y/+d3QHq6FSP8v+hJ31YyAlBtbq9kcoM9Fn5ZQR8ajN/Sxq8I?=
 =?us-ascii?Q?gf37lt1G9tLV1fko/Q9TjR3j0hf8ZLIsv2ClyxGF4m9eAaedyWfF2Vvfe1x1?=
 =?us-ascii?Q?rnK/h53mrbz1FSeCvjNlCGlLV83koU1QWZQZzT3JpqwF3OWCcQ6/l0tCeYM+?=
 =?us-ascii?Q?4RxwnfJHElB4laNF0YCBXvapICQ0CadowzOYGhzyZr3M9mTy/BqV7JXbIPoN?=
 =?us-ascii?Q?sIz4qBD3ttfEUpAET4kEGZ8WyJeYEKXxymKE+i1qta+AMkmlVxf2bQ9tCYF/?=
 =?us-ascii?Q?AJxYI1QVKiCmLpPoH3Gy4lwuPcXdGco7tMjH8locCLzzoT2lHRmTo4LXYrWh?=
 =?us-ascii?Q?M/jw73gWjj9WZup7zlXVJI4RL9idXxOIWDu4Zdf/tOqC4uyQX/gEwvddMSbc?=
 =?us-ascii?Q?dPZddB5jQDWZP6QdwJoDSqmufFpsUKk+txD0HCGawdKYfMVRnVzp1jiMU7D+?=
 =?us-ascii?Q?vhIppCbOj2TK+TtHLzDfdbcKQr3xS9joX7vWRXaHy5OkoZaFlll+sTzAh4sz?=
 =?us-ascii?Q?W+2k5gdZdVLYBemrJM1xTphDlrD8zFQ/lZA7tKtJAAd17CQWMSVzd4FPW/bh?=
 =?us-ascii?Q?X0LLFingjraljJJlCS/TKof+yHNLUTDC2b8HvaWYETrP/JYhsj3rBuoI8X4X?=
 =?us-ascii?Q?q0WecS35VDtZc9zV0PFWRboMpNYFPCd3iiIubFYrHr4qSrfd9+oo+fWKs6vF?=
 =?us-ascii?Q?dkyVNQUbNO4AF4I+YDlWmlpyIpgT88UhMWjY+lL+Tt8pTajQsPMXy0+zXuTY?=
 =?us-ascii?Q?zURwGr5ydsYz9GKSs4+tlGet3xHAfg5I5EWwt2RAG7jOPCuGbbcr2/b9IsvY?=
 =?us-ascii?Q?TeqsSFXV0Bs+7sRLKvy0o0i8gDlg+0zPZBRdowIfgnRxe3RDpHmJ6Klnq6H0?=
 =?us-ascii?Q?nVO5XSbN4QbVqwlfV1W1ZnugbDApgjdRBLHYRRGWcMs3LX8fQ+eDjF+zvuLK?=
 =?us-ascii?Q?vdx76mAr0zciowLzZ03Kd+BNmhKsm4XZV99fEsy8/cA0jNhimzpCnRq13TNd?=
 =?us-ascii?Q?egmrO4SmQya9KotcEUWz6G3g5+v9/JvZJFtlfT74lemE8Kux/DUXdVGWKlYB?=
 =?us-ascii?Q?sP0ZInV/Z8iVP3uRMPa3uxeJx5B8m7jLnGYTR5H1QxmEMPVKUNL7ged/bQpm?=
 =?us-ascii?Q?MAaJqCLFN83PUndfRPcn7UBvs+4M7C+r2o6+DOjZJRztZzDN2B3rgjkBB2/b?=
 =?us-ascii?Q?U1S1fWxLeiacsjzhYvhbqvs5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jIbv2TF/VDfqUrwG+ZCQRS+0Dntzojmv7mmoSfyYmTaTedNTgVXzFwURhu2?=
 =?us-ascii?Q?8f4hzS8P7iPp16kD2RrEQwfGZ+Sj7FCA5CQHyvt5/XdoF5q4JOx9XshNL4VZ?=
 =?us-ascii?Q?gKBhOxYvmxIO55NWzqutDP1rRSII+npavVP7/UmuV7KkJS+YUVQD+W9jXtyi?=
 =?us-ascii?Q?+UJSuJ/ecwyD78SFo86JNt3Sf44/aFDcLPAjsMOerDntbf9kmYqKb9j6B0m9?=
 =?us-ascii?Q?vXSODsT1GnwrzR/cZ/rBFW1qNKpCdgPLUbh/15WTiFCGdfyyD/V/Qj008VgE?=
 =?us-ascii?Q?WMHcRmt8uRb3P1cNK09IdAqhbP47mhOrg9drHOjQD+ag2eEjQ/uObZnC4ONW?=
 =?us-ascii?Q?K/BzLF45cSsEtubUVo5GBX/YV8n1erLXnH1aHhoLMS+t25DKWplJUaP6/rqV?=
 =?us-ascii?Q?CxSq8h1Bb4tw5gYDv5Oz8vkVdRyoDBsThmstk+2CzWvbO3hW3I603msddZH+?=
 =?us-ascii?Q?Xyy8q67aMqEvSTN93zWYbcPmY1INVid6XHvQKwO8vrWyt29vCLFL9cH1wkq4?=
 =?us-ascii?Q?BvjkNz2IO3NVWcfOkz6ELhoKrcBLIk9faF6js6edDOvfIINvGBPK09QPeIU9?=
 =?us-ascii?Q?gAbzddd9kQg3lskDqngheZygxQm+u5gzMdVwCmossdFoAp6v0TB9rZZz3cMt?=
 =?us-ascii?Q?Jnvw9TcMsuGI9k5tmMd9pXf2j2EpjaraEI5pAaX38oUmQydq5kwqitDeTmxn?=
 =?us-ascii?Q?rrnkI54S1M5FJYcVwbaMCvJwkQIh86CawVouGbVMwuJ8voYT2LPqbnDUvYb/?=
 =?us-ascii?Q?VsHuUN6BtJtR6RxRIr+pii2B6NBXMZ+AzTTDRipxtV1bgS3VgPOuDzZIxAIv?=
 =?us-ascii?Q?9EoMZ+ujrasFcUnUmrNx/tTFUexaGd9o0OhqKqRlgDPkt3bLkwFHyJYG+bys?=
 =?us-ascii?Q?r2O93myomjZXCpNXJxFK7EPSHH5EVU0V+hlmbYZQFqa4/cFuZe9e2UlGLBwm?=
 =?us-ascii?Q?Qlk41hAAS1GxPz52iNz7IwvIN0E5nDxAx9J6+2yZpmtKzWpiYzj5xTf0L7PY?=
 =?us-ascii?Q?oWJ/l/Q2+WxE4jH9AMkYaLIU5ppoT6SNeMbfE/10umopBx3atDrOE8q+wWAW?=
 =?us-ascii?Q?LqYg/I/GjgkHfBBBeXECZNAPNki+Mm5sUQze14JDsnznSCTmfIoHqZidgV0f?=
 =?us-ascii?Q?RzltUcRGOEj/IQBgEiGjkzT0tJvrRwMC/vuTuX7Fm3Jd9LFaqhOtJJb5A/6V?=
 =?us-ascii?Q?GF9I5MKgzT38j6KMws/wChDCUZB+3M3iQ5GWTUAN0grxzvtNwjLga38vL6/y?=
 =?us-ascii?Q?K+Sdhhz3GN5lu0tY0gJKumgzTEp5pk7zv4EJvZGCL7cNd4rlKHEIIIfYccbU?=
 =?us-ascii?Q?pw6FbG3sohuEkOcC3d3UgmVtahXe+TgA0A+nJNqVaF54n/3sXLGc1eEPofa2?=
 =?us-ascii?Q?0uJd0bBg9E94LGSmAS2DaX4R/6EsHjkZ+BXnIyOjpT35MXGLxksGoaetmsEd?=
 =?us-ascii?Q?J86QQRXXBRiqZAnkUtN2pfp1zuHkgpmHQ/LXPhJ/Dr26hJ6r/4t83GJ09YJN?=
 =?us-ascii?Q?htsoiD3HHqwxdym9zr1gxR5+dnjbJSCFHINsFw9RtXC8dFu5KCvrakkJiuTe?=
 =?us-ascii?Q?ZPfhnrK+P4fls1lrju6lvVKN3k+43lCVb6JslaG1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9b42fd-fe53-4197-33a5-08dcbd9cbe34
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:40:08.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn7j7L1kzpchpim9RiDIx3TCieAtq6hVWS2igKHfWZ+r2iS9tO6H6E6vEjhhOvoKQ9USFSurkTqwciNGSY6oJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com

On Fri, Aug 16, 2024 at 09:08:02AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d7a5aa4b3c007fae50405ca75c40258d90300e96
> commit: 83e913f52aba69149261742aa9ea4ceea7bf182d um: Support LTO
> date:   1 year, 6 months ago
> config: um-randconfig-001-20240815 (https://download.01.org/0day-ci/archive/20240816/202408160932.BvHwO6Qo-lkp@intel.com/config)
> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160932.BvHwO6Qo-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408160932.BvHwO6Qo-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

kindly ignore this false report, which should be test environment issue. We will
follow up to fix this.

> 
> >> /usr/bin/ld: ../lib/LLVMgold.so: cannot open shared object file: No such file or directory
>    clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
> --
> >> llvm-objcopy: error: 'arch/x86/um/vdso/vdso.so.dbg': No such file or directory
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

