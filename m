Return-Path: <linux-kernel+bounces-353567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5793992F87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE161F239B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C01D4353;
	Mon,  7 Oct 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQj9suk9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0714F50F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311859; cv=fail; b=MUMzj0Lw3AtNckd0BUnc4K80IrnZohC80UBdEaqyc8KEHQYyqQA9w+vnbAK/lWndp0+44MtWKaEdOlkvdQoU8pIUGsOJ7SGqvZs/EECwBVv8bu0/NR6iO9M9G+m+o43e6hpUT0IngC111OLWU8UtU45zWwn2L2lOKOpkxL6uyy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311859; c=relaxed/simple;
	bh=FHG+ANShWmoD7eBrRFjHemZfLiP5i4+6y/dUmIRydqs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cf9lEhR5CilMI9xhGzWz9KzIep6ytOLdeOtnIuvbILWXT37DAeEa6bx2rnajR+vLnbJVdfSQEFcEpe3uc5nBAdpUw46Ju5s3b2zQmK/torBQ4nwKj2A/qiKe1DdpiOfuSmWD3B04o5kOa7yh6FK9sbtBeAn6SPAayKxT4TjmVTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQj9suk9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728311857; x=1759847857;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=FHG+ANShWmoD7eBrRFjHemZfLiP5i4+6y/dUmIRydqs=;
  b=CQj9suk9VVY5n1falUu6CqMSDq1hb8Pb7MVgTo8N4IMf9P5yrFQzZ16u
   EzrN+NFXpr7xtm1p3kPabbayTDiv+Z11xbOrTB/YaTrl3/jhVahX3rNrj
   jCY4B5T9dMDKuUfrZG1b3JoSTaxjPTD9luB69faupGEKDY0RwtYm3DvnS
   1h3iRUtX81iKF65D+8qk+BoP2+7QT+kNKv3fdTgZ0GpGgc9PDUZtxi6IT
   h7dtef6dMGDcNh4MBhXRFAJOW4it6mlhT4Uv50as61GlconMQcGkf7NuL
   h/1hINqqXv8pZY2jVJQsTPPCghl5uwNZvA5TFA/CNILvM0ELBrWlNC2xX
   Q==;
X-CSE-ConnectionGUID: uk/XVElSQaOtxZfS6PfypA==
X-CSE-MsgGUID: jBF6TZuoT123D+KrhMH68w==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="44934898"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="44934898"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:36:11 -0700
X-CSE-ConnectionGUID: a/vb2JPURZCgJeIX+5V22Q==
X-CSE-MsgGUID: Ot4uWowaQQWiTI0L7ssbhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="112954708"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 07:36:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 07:36:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 07:36:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 07:36:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 07:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPLaa8tbajdegy6VU7WZUZlugI2rDx1iwPKndYNL6MITWGBXYZKeoQ1eRqqzLL0R5h8jBX/hX2k3WAeJV8cLFzXWhZuv5fW4IKfED8xUB232qRkdv3nsxokTVEQ1ntc1Fzje5E8Fg8CA8uEfiYa8meiioSneQ2l4sYgf0vHAew8FFq39baJ535CuokiktflGlRgNI4G4syx8+lJB7U1cNiyexCS/njpwkvwM1dXH/UlLxVtn01a/1WYFGKJZ6jCm+RVgJeic7NLVkXocXVkeEUIoh2ElYzR1dbyjLVpNaAKQU+ePC3UqKDoK23fFcwpL+4xSK1bpA1KwoScyFhdYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVirLxc/OOdgJobw02nI2mjwkgV9yvzh9RH+yhpTv8g=;
 b=OwuVHUfKACRw3mVRjuHif4JKg9BOBotkITNLcnx6B6W6dghGL+MtQoHOZ49P2BmhQalSdtau4hcm5UNRr+jy92tJZKVzlP3tmxKh9TJqhRshBZ4e8cU9F4WZLWQeZxHowN0Q6ClgpO0hl1l18ZSP5IF52d8WmCsSPeewWZg/CRpdMsmiPZMN3JZ1kkp5s3k3de5d4Boig9Q3gl74e+hgEZRZUwwjCd3kiZsYFxIJ1Z3oanTDzqGNSitV3gSypQ87AeufraR6qt1kvKfwJWnOHSwGpn4QH24JQAtK37PzlLbTnLpGzME+ZnCiDP5W0j9IybpoSCyqO+YD3uGfzFUwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6987.namprd11.prod.outlook.com (2603:10b6:930:55::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 14:36:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:36:06 +0000
Date: Mon, 7 Oct 2024 22:35:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chen Yu <yu.c.chen@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, kernel test robot
	<oliver.sang@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Honglei
 Wang" <jameshongleiwang@126.com>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>
Subject: [tip:sched/urgent] [sched/eevdf]  d4ac164bde:  hackbench.throughput
 35.8% improvement
Message-ID: <202410072222.a26a91d1-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 39331f37-cef9-4247-dd76-08dce6dd602c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kuwVqh07I7cQDnV8LDY4sVKc6UMJ7q2W1ee3IuhFVk+LIApYEaM8QrUB3+?=
 =?iso-8859-1?Q?6TY/+VGflj0RakXEuPBlVvez++XwEscgzdlY3Hx5gmxDpEMzPf4h6jhiQg?=
 =?iso-8859-1?Q?ZlWuOP4cSuTMpWGtos+RB0QIgUqhWpfrlBN8quPoeSQkQbmFX3O+BTasz+?=
 =?iso-8859-1?Q?Dguu2BDOw3V08dfxR9c6H4Lh4yOWicY+D+A/cnk+USmPUVEzEL/wKOkYOx?=
 =?iso-8859-1?Q?o8bnpAqsyQksuRIV+BVKpoakwcDgvuQCqTSiVqUVSQVUIeMzDf7mKNUOaV?=
 =?iso-8859-1?Q?1B8ivqgtEE1sybu+3htCPTXGXIUrJkoO4JfGBVa05NPfPC4kYEaZxyWNRd?=
 =?iso-8859-1?Q?DrFHwGNmygUU/aE/jMD2KqNlPYdHHWKDd6bNeQsJT7oZce4id2F6x8gsOt?=
 =?iso-8859-1?Q?/yl2uojbFfVHnTt1nshWZ3/zpzWDLSA7fzGadhtyVsCOyVAsxAFZeIFHhL?=
 =?iso-8859-1?Q?5usJFmbBUVaO2i4I/Zuv/ng5tTJQEGvmCxgLhgpTG1dc16n7c6t1FX5LVH?=
 =?iso-8859-1?Q?PU7J5swVTSTngQaDMwSbrBpo6oA6Ct5yM5GvoPY84y1C4M+4dELCahogYI?=
 =?iso-8859-1?Q?ULJlEQuL5c0+npVMXkxAnaavZu7YIEHVDYQry6W2We496qzd/XXHml3l98?=
 =?iso-8859-1?Q?KgEmbxOlRox7WQb0DyXHIYLhq3g2a1FipoYbcXS81N1ka+jTRuGXoytSAH?=
 =?iso-8859-1?Q?xyVx6KZ7kX5tZkTHxmkRmGiI3J6dlRIQoH9Cwcc38aVhE+UTiiPG9EV9Ar?=
 =?iso-8859-1?Q?NEZDLUKfgvt6fXB42Tln124CGPb/Dw+Vtf2q1xT6fzdq75vBU2BRA+vD/z?=
 =?iso-8859-1?Q?+OHSu+9dEfilEJEtuJj1WH83giYVozD+wPxWmXMiXh2ae+Yq130UXXf3Kx?=
 =?iso-8859-1?Q?WuWIQAJIWtBrqyyECQCIRCWHOA7ZnEJ07xre7vAS13JQVGY9jQUOkEmwgT?=
 =?iso-8859-1?Q?hMxqavYX+noNSWNYy7vroFgHg+T0DxRTb8YKE/QEf/6Os/ULBuApX4RuVr?=
 =?iso-8859-1?Q?ANDYWfxUrKNdRv9JwCBq/3gT4aacVlBNaeVewv1RYOEzDmK52fWTCyvC6e?=
 =?iso-8859-1?Q?eNC1sgBUHjxA1hhPOCiAbbXf2VBzl3k8NCklvBsPvyJYjZKYq2kfYnijaF?=
 =?iso-8859-1?Q?QhJEjnXsf6j9nQ+hjBBIE/ClIdi8jVV9yW2tt99INEmYg0tyRtuRSz4cWh?=
 =?iso-8859-1?Q?VUkvuKRF14A1TQhCP+TIDM+6YEDCPuF8vNikkvCLa++fv+ZCzj7bKNdB7t?=
 =?iso-8859-1?Q?vdJQLm878fGbmuGnXhsfffIDiDcGhpq5yOcJI7rXiUqA3b1rdqgRnJTIEH?=
 =?iso-8859-1?Q?wcjUpHghmeuqM7xGBZ7sXLer5KSYbJ01+gxJ9UOXhxL8UFA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LeIX4ldTPxKzwK+ywYDC9B4ZYEeyaVg6GCIEkoinqWlOyVc22tYPRSgpxS?=
 =?iso-8859-1?Q?JUIjySck7GIYTAj3zU1WvLEXc9xTiFz1AOk5ubDjm2AysqeuRYfMx6YfhO?=
 =?iso-8859-1?Q?aOaw235HvAIH9SfcNNnjBNI3hx4s9ScRsIVAC42NPYIJchls2cv0hyWqnT?=
 =?iso-8859-1?Q?dxStk1GAAr67qFHqSc8y3XvkD9EvxAh8vJ6vYMRC736tHlq4ylR2m2QgvX?=
 =?iso-8859-1?Q?EEx4zqqWWRBrLe913xCMvAaBXdx6fqI+l+tVVqrpubN50u/jBvDSL0CM1Z?=
 =?iso-8859-1?Q?t/Ye5UA9hiKHztdWlm5f92l5UmZYEvXe62tY2qZ+C1eGRmxiKnCpxrmhk+?=
 =?iso-8859-1?Q?rUqYpKjIK0N6XOGtE9HBM1EeUrQhjRRyw4MsolZW+qJ2h1P17JsaZXDd1h?=
 =?iso-8859-1?Q?nKN45P0Zuxy8FKv5Azh2MRsgV4RBEAAH5xXTGVASwGLLODX4TD+qakOtvO?=
 =?iso-8859-1?Q?affZVEiRv3yar2+B1a8EhMWbSPfyQxEoB+aDfw2rkDBB/+RkwUJqUxjKwK?=
 =?iso-8859-1?Q?X71YLl/N1N643or/4G2P+bK/5PnLeBAaYs0Z0HAGalYVE1/7ta2IdX+vjk?=
 =?iso-8859-1?Q?BtJ4FOZfXrB5j3TWWRhAFeQsOU8Iz2oR+GzbFcfD/3lebr5gLgryPx152o?=
 =?iso-8859-1?Q?JtftVqKw7q32Nd1wXRy9L7zaFL+r1aILlSYWT1v/LBD22VFjPuX3XGRYYB?=
 =?iso-8859-1?Q?ADpkOFj3CtxTkdTevOBlk/Do+61WKODdRVVkdmilvOdeX3opr3HGYeuXOD?=
 =?iso-8859-1?Q?QxA0vcvxobYoEXuTrhGab/tFQZI2AXkqb6rBSi7Ji2BN694m7y00lcQbR0?=
 =?iso-8859-1?Q?dmNr8GmwqCpzz0fo13bjiTJ0l3Ma3N772Pg04KOME3Ref+XLjAKORAC2Di?=
 =?iso-8859-1?Q?kUjwX9dhev2dSEmz1BwNXPlmuI8WbtbvbvxXvuvzof/lK9+6i3vOPBRrmU?=
 =?iso-8859-1?Q?xn06vEBZULg5BWl+yklWYE3wRe1mGCmgdK8ysc1fzCCcWJZOLSNU8Jz5h3?=
 =?iso-8859-1?Q?5ZCIFuhNE89sZCTfCRpoTletMKTgFbWM5wlS/qiR2aVd8CI1geRr24gq3b?=
 =?iso-8859-1?Q?z5bnUMIr/BTLm2AUecjxhMRzcTiDARbES8aPQe3YYcFjjLEhAGYBWuiKHh?=
 =?iso-8859-1?Q?mE80qxOIcGxGceEE0PUyn/omDC/iwNsmUVNm7M9hwT+FaBcD3dOQFdGntu?=
 =?iso-8859-1?Q?0b+qfz8yyEHKEZhidh5DGbGOx7UA1mCvuxq7VwrV27KGUkr52FUg6KSkG7?=
 =?iso-8859-1?Q?ldLOYAhA4zGVzIjJE1D+JGrI0xoYGppLUSLBAAnDiYaw4/T/FlZGrLiFcI?=
 =?iso-8859-1?Q?LUqEsleHTkjfz/D+vJ1/SQh4Di1WlLn1BWozuLqhY+wPPDdzAunVR9Wia/?=
 =?iso-8859-1?Q?TAPe7fKwk8AnAQ6KAnaXBSQJVVKSD7q0sVAweuyfj0JlBZAtyLsKRKQO9B?=
 =?iso-8859-1?Q?5ylYUUW9P3n3lITTwaNKGYz0GFL99MxViI52fllElFm/BnWbXlP+HNV6dA?=
 =?iso-8859-1?Q?dBJLUHXNh4j0u5S/Y1hwYbHvYBClG7SVOmiWxc7dT/RXVLShlNsNLNhB+d?=
 =?iso-8859-1?Q?O71uRmjCCOf6Mjy3EErMpB3UD0+GpkkJ44EjNAyy/jvtdTVnumQyCgHx7q?=
 =?iso-8859-1?Q?zxEGroSeMI2Qx6qxtj8MP0wfZ5IpMPo53UAL6ue7T1J0pUkcWUiTlnog?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39331f37-cef9-4247-dd76-08dce6dd602c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:36:05.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IfAcWdREwjLzVonvJCBcdYGSNPTuUm8Va7kwAipEfRv7xLehtf696+yzdazCx4h0qKCJFNMS4Eq11py+lXidg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987
X-OriginatorOrg: intel.com


hi, Chenyu,

this report is FYI that we observed expected performance improvement when your
commit is in tip:sched/urgent branch.


Hello,

kernel test robot noticed a 35.8% improvement of hackbench.throughput on:


commit: d4ac164bde7a12ec0a238a7ead5aa26819bbb1c1 ("sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/urgent

testcase: hackbench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	iterations: 4
	mode: threads
	ipc: socket
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241007/202410072222.a26a91d1-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/socket/4/x86_64-rhel-8.3/threads/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/hackbench

commit: 
  9b5ce1a37e ("sched: Fix sched_delayed vs cfs_bandwidth")
  d4ac164bde ("sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running")

9b5ce1a37e904fac d4ac164bde7a12ec0a238a7ead5 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    173970 ±  7%     -16.5%     145345 ±  2%  meminfo.AnonHugePages
    270.59           -19.8%     217.13        uptime.boot
   3927890           -45.4%    2144463        vmstat.system.cs
    281673 ±  2%     +13.1%     318576 ±  4%  vmstat.system.in
      1.72 ±  8%      +1.1        2.84 ± 29%  mpstat.cpu.all.idle%
      0.33 ±  3%      +0.0        0.38 ±  3%  mpstat.cpu.all.irq%
      0.02            +0.0        0.02 ±  5%  mpstat.cpu.all.soft%
      3.97            +0.9        4.90        mpstat.cpu.all.usr%
   2035039 ±  7%     -67.3%     664712 ±  8%  numa-numastat.node0.local_node
   2107864 ±  6%     -66.8%     699124 ±  9%  numa-numastat.node0.numa_hit
   2665764 ± 14%     -64.5%     946747 ±  9%  numa-numastat.node1.local_node
   2725494 ± 13%     -61.7%    1044876 ±  9%  numa-numastat.node1.numa_hit
   2107029 ±  6%     -66.9%     698461 ±  9%  numa-vmstat.node0.numa_hit
   2034197 ±  7%     -67.4%     664048 ±  8%  numa-vmstat.node0.numa_local
   2724149 ± 13%     -61.7%    1043379 ±  9%  numa-vmstat.node1.numa_hit
   2664418 ± 14%     -64.5%     945250 ±  9%  numa-vmstat.node1.numa_local
    133.75 ± 36%     +63.2%     218.35 ± 21%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    355.40 ± 71%     -81.4%      66.00 ±142%  perf-sched.wait_and_delay.count.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
    796.60 ± 69%     -51.6%     385.33 ± 16%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      6.67 ± 59%     -72.2%       1.86 ±136%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    135372            -1.6%     133167        proc-vmstat.nr_slab_unreclaimable
   4835491 ±  6%     -63.9%    1746152 ±  4%  proc-vmstat.numa_hit
   4702935 ±  7%     -65.7%    1613610 ±  4%  proc-vmstat.numa_local
  21337960 ±  3%     -81.4%    3960339 ±  4%  proc-vmstat.pgalloc_normal
   1142153 ±  7%     -14.1%     981593 ±  5%  proc-vmstat.pgfault
  20616559 ±  3%     -83.5%    3406503 ±  4%  proc-vmstat.pgfree
    283113           +35.8%     384333        hackbench.throughput
    278272           +33.1%     370485        hackbench.throughput_avg
    283113           +35.8%     384333        hackbench.throughput_best
    273435           +27.6%     348996        hackbench.throughput_worst
    216.79           -24.8%     163.08        hackbench.time.elapsed_time
    216.79           -24.8%     163.08        hackbench.time.elapsed_time.max
 2.693e+08           -71.1%   77937028        hackbench.time.involuntary_context_switches
     26338           -25.8%      19538        hackbench.time.system_time
      1040            -6.7%     970.71        hackbench.time.user_time
 5.762e+08           -52.7%  2.727e+08        hackbench.time.voluntary_context_switches
      1.36            -2.6%       1.32        perf-stat.i.MPKI
 3.581e+10           +18.6%  4.247e+10        perf-stat.i.branch-instructions
 1.779e+08            -3.0%  1.726e+08        perf-stat.i.branch-misses
     25.84            -2.6       23.20 ±  2%  perf-stat.i.cache-miss-rate%
 2.364e+08           +16.6%  2.756e+08        perf-stat.i.cache-misses
 9.242e+08           +29.6%  1.198e+09        perf-stat.i.cache-references
   3895623           -45.0%    2140870 ±  2%  perf-stat.i.context-switches
      1.88           -17.5%       1.55        perf-stat.i.cpi
      1403           -14.4%       1200 ±  2%  perf-stat.i.cycles-between-cache-misses
 1.741e+11           +19.3%  2.076e+11        perf-stat.i.instructions
      0.54           +21.3%       0.66        perf-stat.i.ipc
     30.64           -44.6%      16.98 ±  2%  perf-stat.i.metric.K/sec
      5031 ±  7%     +12.8%       5674 ±  5%  perf-stat.i.minor-faults
      5031 ±  7%     +12.8%       5674 ±  5%  perf-stat.i.page-faults
      1.36           -18.4%       1.11 ± 44%  perf-stat.overall.MPKI
      0.50            -0.2        0.34 ± 44%  perf-stat.overall.branch-miss-rate%
     25.62            -6.4       19.27 ± 44%  perf-stat.overall.cache-miss-rate%
      1.87           -31.0%       1.29 ± 44%  perf-stat.overall.cpi
      1380           -29.5%     972.59 ± 44%  perf-stat.overall.cycles-between-cache-misses
 1.767e+08           -19.3%  1.426e+08 ± 44%  perf-stat.ps.branch-misses
   3865418           -54.3%    1768086 ± 44%  perf-stat.ps.context-switches
 3.789e+13           -24.7%  2.855e+13 ± 44%  perf-stat.total.instructions
  12234823           -34.6%    8005505 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
  18853120 ±  8%     -34.2%   12408426 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
  11106898           -35.1%    7204412 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
     24.81           -29.7%      17.43 ± 19%  sched_debug.cfs_rq:/.h_nr_running.avg
     40.85 ±  6%     -29.7%      28.72 ± 16%  sched_debug.cfs_rq:/.h_nr_running.max
      7.07 ±  4%     -14.5%       6.05 ± 12%  sched_debug.cfs_rq:/.h_nr_running.stddev
    121697 ±105%    +104.7%     249089 ± 65%  sched_debug.cfs_rq:/.load.max
     11470 ± 95%     +99.8%      22920 ± 60%  sched_debug.cfs_rq:/.load.stddev
     20.44 ± 10%     +53.4%      31.36 ± 14%  sched_debug.cfs_rq:/.load_avg.avg
      2.60 ± 11%     -33.8%       1.72 ± 28%  sched_debug.cfs_rq:/.load_avg.min
     58.74 ± 14%     +76.0%     103.38 ± 30%  sched_debug.cfs_rq:/.load_avg.stddev
  12234823           -34.6%    8005505 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
  18853120 ±  8%     -34.2%   12408426 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
  11106898           -35.1%    7204412 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
      0.77           -11.3%       0.69 ±  2%  sched_debug.cfs_rq:/.nr_running.avg
      0.09 ± 11%     +68.7%       0.15 ± 33%  sched_debug.cfs_rq:/.nr_running.stddev
      8.31 ± 22%     +81.9%      15.11 ± 23%  sched_debug.cfs_rq:/.removed.load_avg.avg
    256.00           +47.3%     377.06 ± 21%  sched_debug.cfs_rq:/.removed.load_avg.max
     44.85 ± 10%     +59.4%      71.48 ± 14%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      3.61 ± 36%     +75.6%       6.33 ± 30%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    132.75 ±  3%     +58.8%     210.83 ± 37%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     20.04 ± 20%     +60.0%      32.06 ± 27%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      3.61 ± 36%     +68.0%       6.06 ± 31%  sched_debug.cfs_rq:/.removed.util_avg.avg
    132.75 ±  3%     +32.6%     176.00 ±  4%  sched_debug.cfs_rq:/.removed.util_avg.max
     20.04 ± 20%     +44.7%      29.00 ± 19%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     25483           -29.2%      18053 ± 19%  sched_debug.cfs_rq:/.runnable_avg.avg
     38850 ±  5%     -25.5%      28936 ± 18%  sched_debug.cfs_rq:/.runnable_avg.max
    139.06 ± 10%     +36.4%     189.71 ± 16%  sched_debug.cfs_rq:/.util_avg.stddev
      2210           -27.5%       1602 ± 18%  sched_debug.cfs_rq:/.util_est.avg
      9114 ± 11%     -26.5%       6701 ± 18%  sched_debug.cfs_rq:/.util_est.max
      1092 ±  6%     -21.0%     862.68 ± 12%  sched_debug.cfs_rq:/.util_est.stddev
     46072 ± 12%     -27.7%      33320 ± 23%  sched_debug.cpu.avg_idle.min
    145862           -22.6%     112867        sched_debug.cpu.clock.avg
    146903           -22.9%     113291 ±  2%  sched_debug.cpu.clock.max
    144579           -22.4%     112238        sched_debug.cpu.clock.min
    145380           -22.6%     112472        sched_debug.cpu.clock_task.avg
    146542           -22.9%     113018 ±  2%  sched_debug.cpu.clock_task.max
    135466           -23.7%     103310 ±  2%  sched_debug.cpu.clock_task.min
     14500           -29.6%      10208 ±  4%  sched_debug.cpu.curr->pid.avg
     17389           -22.0%      13571        sched_debug.cpu.curr->pid.max
     24.82           -29.8%      17.43 ± 19%  sched_debug.cpu.nr_running.avg
     40.85 ±  6%     -29.7%      28.72 ± 16%  sched_debug.cpu.nr_running.max
      7.05 ±  4%     -14.3%       6.04 ± 12%  sched_debug.cpu.nr_running.stddev
   2682545 ±  2%     -63.2%     988149 ±  2%  sched_debug.cpu.nr_switches.avg
   3053758           -60.6%    1204556 ±  4%  sched_debug.cpu.nr_switches.max
   2238718 ±  4%     -63.3%     821299 ±  3%  sched_debug.cpu.nr_switches.min
    152485 ±  4%     -53.3%      71237 ± 14%  sched_debug.cpu.nr_switches.stddev
    144530           -22.4%     112212        sched_debug.cpu_clk
    143361           -22.5%     111055        sched_debug.ktime
    145386           -22.2%     113077        sched_debug.sched_clk
     14.74 ± 15%      -3.6       11.12 ±  6%  perf-profile.calltrace.cycles-pp.__put_partials.kfree.skb_release_data.consume_skb.unix_stream_read_generic
     14.51 ± 15%      -3.6       10.88 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kfree.skb_release_data.consume_skb
     14.34 ± 15%      -3.6       10.72 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kfree.skb_release_data
     10.45 ± 14%      -2.8        7.68 ± 15%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
     10.67 ± 14%      -2.8        7.90 ± 15%  perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     10.29 ± 14%      -2.8        7.52 ± 16%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__put_partials.kmem_cache_free.unix_stream_read_generic
     18.08 ± 11%      -2.7       15.40 ±  4%  perf-profile.calltrace.cycles-pp.kfree.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
     18.76 ± 10%      -2.4       16.37 ±  4%  perf-profile.calltrace.cycles-pp.skb_release_data.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
     10.58 ± 14%      -2.3        8.27 ±  5%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
     24.87 ±  6%      -2.3       22.59        perf-profile.calltrace.cycles-pp.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter
     25.07 ±  6%      -2.2       22.85        perf-profile.calltrace.cycles-pp.alloc_skb_with_frags.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
      9.09 ± 15%      -2.1        7.01 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve
      9.05 ± 15%      -2.1        6.98 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof
      9.52 ± 15%      -2.1        7.47 ±  5%  perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb
     26.72 ±  5%      -2.0       24.68        perf-profile.calltrace.cycles-pp.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
     34.57            -1.9       32.68        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
     36.03            -1.5       34.50        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.43            -1.2       36.21        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     40.29            -1.2       39.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     40.47            -1.1       39.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     38.90            -1.0       37.93        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.45 ± 28%      -0.9        1.60 ± 20%  perf-profile.calltrace.cycles-pp.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      2.04 ± 29%      -0.8        1.22 ± 24%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter.vfs_write
      2.41 ± 18%      -0.7        1.67 ± 19%  perf-profile.calltrace.cycles-pp.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
      1.89 ± 27%      -0.7        1.16 ± 22%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg.sock_write_iter
      1.85 ± 27%      -0.7        1.13 ± 22%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable.unix_stream_sendmsg
      1.82 ± 27%      -0.7        1.11 ± 22%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable
      2.07 ± 17%      -0.6        1.44 ± 18%  perf-profile.calltrace.cycles-pp.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.98 ± 18%      -0.6        1.38 ± 18%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic.unix_stream_recvmsg
      1.94 ± 18%      -0.6        1.34 ± 19%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.unix_stream_data_wait.unix_stream_read_generic
      1.00 ± 17%      -0.3        0.68 ± 20%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      0.94 ± 11%      -0.3        0.65 ± 17%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.60 ±  6%      +0.1        0.73 ±  6%  perf-profile.calltrace.cycles-pp.security_socket_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
      0.55 ±  6%      +0.1        0.69 ±  5%  perf-profile.calltrace.cycles-pp.security_socket_recvmsg.sock_recvmsg.sock_read_iter.vfs_read.ksys_read
      0.79 ±  6%      +0.2        0.98 ±  4%  perf-profile.calltrace.cycles-pp.__check_object_size.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      1.11 ±  9%      +0.2        1.30 ±  4%  perf-profile.calltrace.cycles-pp.skb_set_owner_w.sock_alloc_send_pskb.unix_stream_sendmsg.sock_write_iter.vfs_write
      0.75 ± 13%      +0.2        0.96 ±  7%  perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.87 ±  5%      +0.2        1.10 ±  4%  perf-profile.calltrace.cycles-pp._copy_from_iter.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write
      0.99 ±  7%      +0.3        1.27 ±  4%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      0.32 ± 81%      +0.3        0.63 ±  4%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb
      0.32 ± 81%      +0.3        0.64 ±  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg
      0.31 ± 81%      +0.3        0.64 ±  6%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ± 81%      +0.3        0.67 ±  5%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_free_hook.kfree.skb_release_data.consume_skb
      1.18 ±  7%      +0.3        1.52 ±  5%  perf-profile.calltrace.cycles-pp.__slab_free.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      1.32 ±  6%      +0.4        1.67 ±  5%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      1.35 ±  6%      +0.4        1.72 ±  5%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.56 ±  6%      +0.4        1.95 ±  4%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.68 ±  7%      +0.4        2.09 ±  4%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc_node_track_caller_noprof.kmalloc_reserve.__alloc_skb.alloc_skb_with_frags
      2.05 ±  6%      +0.5        2.52 ±  5%  perf-profile.calltrace.cycles-pp.sock_wfree.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic
      1.90 ±  6%      +0.5        2.37 ±  4%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_from_iter.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write
      1.75 ±  9%      +0.5        2.24 ±  4%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.skb_release_data.consume_skb.unix_stream_read_generic
      2.18 ±  6%      +0.5        2.69 ±  5%  perf-profile.calltrace.cycles-pp.unix_destruct_scm.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg
      2.29 ±  6%      +0.5        2.82 ±  5%  perf-profile.calltrace.cycles-pp.skb_release_head_state.consume_skb.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      0.00            +0.6        0.56 ±  5%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.33 ±  9%      +0.6        1.93 ±  6%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      0.77 ± 30%      +0.7        1.42 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      0.77 ± 30%      +0.7        1.42 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      1.95 ±  9%      +0.7        2.62 ±  6%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      1.83 ±  8%      +0.7        2.56 ±  6%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor
      1.96 ±  8%      +0.8        2.72 ±  6%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
      2.64 ±  4%      +0.9        3.55 ±  6%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic
     55.45            +1.0       56.45        perf-profile.calltrace.cycles-pp.read
      5.06 ±  6%      +1.8        6.88 ±  6%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg
      5.16 ±  6%      +1.8        7.01 ±  6%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg
      5.22 ±  6%      +1.9        7.08 ±  6%  perf-profile.calltrace.cycles-pp.unix_stream_read_actor.unix_stream_read_generic.unix_stream_recvmsg.sock_recvmsg.sock_read_iter
     41.40 ± 11%     -10.8       30.61 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     42.63 ± 10%     -10.6       31.99 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     25.42 ± 11%      -6.4       19.03 ±  5%  perf-profile.children.cycles-pp.__put_partials
     17.27 ± 11%      -4.1       13.18 ±  5%  perf-profile.children.cycles-pp.get_partial_node
     18.39 ± 11%      -4.0       14.36 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
     18.12 ± 11%      -2.7       15.44 ±  4%  perf-profile.children.cycles-pp.kfree
     18.79 ± 10%      -2.4       16.40 ±  4%  perf-profile.children.cycles-pp.skb_release_data
     24.94 ±  6%      -2.3       22.68        perf-profile.children.cycles-pp.__alloc_skb
     25.11 ±  6%      -2.2       22.90        perf-profile.children.cycles-pp.alloc_skb_with_frags
     26.76 ±  5%      -2.0       24.72        perf-profile.children.cycles-pp.sock_alloc_send_pskb
     34.75            -1.8       32.91        perf-profile.children.cycles-pp.unix_stream_sendmsg
     36.09            -1.5       34.57        perf-profile.children.cycles-pp.sock_write_iter
     93.05            -1.3       91.73        perf-profile.children.cycles-pp.do_syscall_64
     93.42            -1.2       92.18        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     37.50            -1.2       36.30        perf-profile.children.cycles-pp.vfs_write
     38.98            -1.0       38.03        perf-profile.children.cycles-pp.ksys_write
      2.71 ± 17%      -0.9        1.82 ± 19%  perf-profile.children.cycles-pp.__schedule
      2.71 ± 16%      -0.9        1.83 ± 19%  perf-profile.children.cycles-pp.schedule
      2.47 ± 28%      -0.9        1.62 ± 20%  perf-profile.children.cycles-pp.sock_def_readable
      2.16 ± 28%      -0.8        1.32 ± 22%  perf-profile.children.cycles-pp.__wake_up_sync_key
      2.02 ± 26%      -0.8        1.26 ± 20%  perf-profile.children.cycles-pp.__wake_up_common
      2.43 ± 18%      -0.7        1.68 ± 19%  perf-profile.children.cycles-pp.unix_stream_data_wait
      1.96 ± 26%      -0.7        1.22 ± 20%  perf-profile.children.cycles-pp.autoremove_wake_function
      1.95 ± 26%      -0.7        1.21 ± 20%  perf-profile.children.cycles-pp.try_to_wake_up
      2.24 ± 17%      -0.6        1.60 ± 16%  perf-profile.children.cycles-pp.schedule_timeout
      0.83 ± 15%      -0.5        0.34 ± 33%  perf-profile.children.cycles-pp.get_any_partial
      1.05 ± 13%      -0.4        0.68 ± 20%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.10 ± 17%      -0.4        0.74 ± 19%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.87 ± 18%      -0.3        0.59 ± 19%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.72 ± 18%      -0.2        0.51 ± 18%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.71 ± 18%      -0.2        0.50 ± 18%  perf-profile.children.cycles-pp.dequeue_entities
      0.54 ± 21%      -0.2        0.34 ± 18%  perf-profile.children.cycles-pp.update_curr
      0.59 ± 15%      -0.2        0.41 ± 20%  perf-profile.children.cycles-pp.update_load_avg
      0.60 ± 16%      -0.2        0.43 ± 15%  perf-profile.children.cycles-pp.enqueue_entity
      0.38 ± 15%      -0.2        0.22 ± 23%  perf-profile.children.cycles-pp.pick_task_fair
      0.42 ± 18%      -0.1        0.30 ± 16%  perf-profile.children.cycles-pp.dequeue_entity
      0.41 ± 10%      -0.1        0.30 ± 13%  perf-profile.children.cycles-pp.set_next_entity
      0.28 ± 11%      -0.1        0.17 ± 22%  perf-profile.children.cycles-pp.pick_eevdf
      0.25 ± 10%      -0.1        0.17 ± 15%  perf-profile.children.cycles-pp.__enqueue_entity
      0.40 ± 11%      -0.1        0.32 ± 11%  perf-profile.children.cycles-pp.switch_fpu_return
      0.20 ± 15%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.wakeup_preempt
      0.27 ±  9%      -0.1        0.20 ± 12%  perf-profile.children.cycles-pp.__dequeue_entity
      0.24 ± 16%      -0.1        0.17 ± 17%  perf-profile.children.cycles-pp.prepare_task_switch
      0.14 ± 13%      -0.1        0.08 ± 27%  perf-profile.children.cycles-pp.put_prev_entity
      0.22 ± 13%      -0.1        0.16 ± 16%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.20 ± 12%      -0.1        0.14 ± 19%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.31 ±  9%      -0.1        0.25 ± 10%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.12 ± 10%      -0.1        0.06 ± 23%  perf-profile.children.cycles-pp.vruntime_eligible
      0.15 ± 12%      -0.1        0.10 ± 19%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.16 ± 11%      -0.0        0.12 ± 21%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.20 ± 12%      -0.0        0.15 ± 12%  perf-profile.children.cycles-pp.__switch_to_asm
      0.13 ± 19%      -0.0        0.09 ± 22%  perf-profile.children.cycles-pp.update_cfs_group
      0.12 ± 20%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.update_rq_clock
      0.08 ± 23%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.11 ± 11%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.os_xsave
      0.05 ±  9%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__x64_sys_write
      0.05 ±  9%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.kfree_skbmem
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__x64_sys_read
      0.07 ±  9%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.wait_for_unix_gc
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.skb_free_head
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.skb_put
      0.13 ±  6%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.check_stack_object
      0.10 ±  7%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.try_charge_memcg
      0.10 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.manage_oob
      0.12 ±  6%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.maybe_add_creds
      0.19 ±  3%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.put_cpu_partial
      0.12 ±  4%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.12 ±  7%      +0.0        0.15 ±  5%  perf-profile.children.cycles-pp.put_pid
      0.14 ±  8%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.13 ±  8%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.unix_scm_to_skb
      0.14 ±  5%      +0.0        0.18 ±  6%  perf-profile.children.cycles-pp.kmalloc_size_roundup
      0.14 ±  7%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.security_socket_getpeersec_dgram
      0.23 ±  5%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.apparmor_socket_sendmsg
      0.19 ±  6%      +0.1        0.24 ±  6%  perf-profile.children.cycles-pp.__scm_recv_common
      0.24 ±  8%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.28 ±  6%      +0.1        0.34 ±  3%  perf-profile.children.cycles-pp.mutex_unlock
      0.24 ±  6%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.24 ±  7%      +0.1        0.31 ±  5%  perf-profile.children.cycles-pp.aa_file_perm
      0.44 ± 10%      +0.1        0.50 ±  5%  perf-profile.children.cycles-pp.unix_write_space
      0.29 ±  7%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.29 ±  6%      +0.1        0.36 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.30 ±  7%      +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      0.37 ±  5%      +0.1        0.45 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.47 ±  7%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.mutex_lock
      0.41 ±  5%      +0.1        0.50 ±  4%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.47 ±  8%      +0.1        0.57 ±  3%  perf-profile.children.cycles-pp.fput
      0.44 ±  6%      +0.1        0.56 ±  5%  perf-profile.children.cycles-pp.skb_unlink
      0.47 ±  5%      +0.1        0.60 ±  4%  perf-profile.children.cycles-pp.refill_obj_stock
      0.51 ±  6%      +0.1        0.64 ±  5%  perf-profile.children.cycles-pp.__check_heap_object
      0.58 ±  5%      +0.1        0.72 ±  6%  perf-profile.children.cycles-pp.security_socket_recvmsg
      0.62 ±  6%      +0.1        0.76 ±  5%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.41 ±  6%      +0.1        0.56 ±  6%  perf-profile.children.cycles-pp.__build_skb_around
      0.62 ±  4%      +0.2        0.78 ±  6%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.69 ±  7%      +0.2        0.85 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      1.12 ±  9%      +0.2        1.32 ±  3%  perf-profile.children.cycles-pp.skb_set_owner_w
      0.91 ±  6%      +0.2        1.12 ±  6%  perf-profile.children.cycles-pp.aa_sk_perm
      0.81 ±  4%      +0.2        1.02 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      0.89 ±  6%      +0.2        1.12 ±  4%  perf-profile.children.cycles-pp._copy_from_iter
      0.94 ±  6%      +0.2        1.18 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
      1.01 ±  3%      +0.3        1.26 ±  5%  perf-profile.children.cycles-pp.rw_verify_area
      0.96 ±  5%      +0.3        1.21 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.33 ±  6%      +0.3        1.68 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.82 ± 17%      +0.4        2.18 ±  6%  perf-profile.children.cycles-pp.fdget_pos
      1.82 ±  6%      +0.5        2.28 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
      2.07 ±  6%      +0.5        2.55 ±  5%  perf-profile.children.cycles-pp.sock_wfree
      1.95 ±  6%      +0.5        2.44 ±  4%  perf-profile.children.cycles-pp.skb_copy_datagram_from_iter
      2.23 ±  6%      +0.5        2.74 ±  5%  perf-profile.children.cycles-pp.unix_destruct_scm
      2.31 ±  6%      +0.5        2.85 ±  5%  perf-profile.children.cycles-pp.skb_release_head_state
      2.20 ±  7%      +0.6        2.82 ±  5%  perf-profile.children.cycles-pp.__slab_free
      2.70 ±  6%      +0.7        3.41 ±  5%  perf-profile.children.cycles-pp.clear_bhb_loop
      1.82 ±  8%      +0.7        2.54 ±  6%  perf-profile.children.cycles-pp.check_heap_object
      1.99 ±  8%      +0.8        2.75 ±  6%  perf-profile.children.cycles-pp.simple_copy_to_iter
      3.32 ±  7%      +0.8        4.15 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      2.65 ±  4%      +0.9        3.57 ±  6%  perf-profile.children.cycles-pp._copy_to_iter
      2.82 ±  7%      +1.0        3.78 ±  5%  perf-profile.children.cycles-pp.__check_object_size
      3.78 ±  9%      +1.2        4.97 ±  5%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      5.10 ±  6%      +1.8        6.92 ±  6%  perf-profile.children.cycles-pp.__skb_datagram_iter
      5.19 ±  6%      +1.9        7.05 ±  6%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      5.25 ±  6%      +1.9        7.12 ±  6%  perf-profile.children.cycles-pp.unix_stream_read_actor
     41.40 ± 11%     -10.8       30.61 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.31 ± 18%      -0.1        0.22 ± 15%  perf-profile.self.cycles-pp.__schedule
      0.20 ± 14%      -0.1        0.12 ± 20%  perf-profile.self.cycles-pp.pick_eevdf
      0.25 ± 10%      -0.1        0.17 ± 15%  perf-profile.self.cycles-pp.__enqueue_entity
      0.10 ±  9%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.vruntime_eligible
      0.21 ± 21%      -0.1        0.14 ± 26%  perf-profile.self.cycles-pp.update_load_avg
      0.18 ± 21%      -0.1        0.11 ± 18%  perf-profile.self.cycles-pp.update_curr
      0.22 ±  9%      -0.1        0.16 ± 12%  perf-profile.self.cycles-pp.__dequeue_entity
      0.31 ±  9%      -0.1        0.25 ± 11%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.20 ± 12%      -0.1        0.15 ± 16%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.20 ± 11%      -0.1        0.14 ± 15%  perf-profile.self.cycles-pp.__switch_to
      0.20 ± 11%      -0.0        0.15 ± 13%  perf-profile.self.cycles-pp.__switch_to_asm
      0.15 ± 12%      -0.0        0.11 ± 20%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.13 ± 21%      -0.0        0.09 ± 20%  perf-profile.self.cycles-pp.update_cfs_group
      0.09 ± 15%      -0.0        0.06 ± 21%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.10 ± 13%      -0.0        0.08 ± 14%  perf-profile.self.cycles-pp.os_xsave
      0.09 ± 17%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.switch_fpu_return
      0.10 ±  8%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.check_stack_object
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.skb_put
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.simple_copy_to_iter
      0.05 ±  9%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.unix_stream_read_actor
      0.08 ±  5%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.manage_oob
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.try_charge_memcg
      0.09 ±  8%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.09 ±  8%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.maybe_add_creds
      0.07 ±  6%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.skb_release_head_state
      0.10 ±  3%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.skb_unlink
      0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.skb_queue_tail
      0.08 ±  9%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.put_pid
      0.19 ±  2%      +0.0        0.21 ±  3%  perf-profile.self.cycles-pp.put_cpu_partial
      0.10 ±  5%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.skb_copy_datagram_iter
      0.09 ±  7%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.consume_skb
      0.12 ±  9%      +0.0        0.14 ±  7%  perf-profile.self.cycles-pp.kmalloc_size_roundup
      0.12 ±  6%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.11 ±  6%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.20 ±  5%      +0.0        0.23        perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.11 ±  8%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.unix_scm_to_skb
      0.11 ±  6%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.security_socket_recvmsg
      0.16 ±  7%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.unix_stream_recvmsg
      0.13 ±  3%      +0.0        0.16 ±  6%  perf-profile.self.cycles-pp.unix_destruct_scm
      0.14 ±  8%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.11 ±  6%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.security_socket_getpeersec_dgram
      0.15 ±  5%      +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.__scm_recv_common
      0.21 ±  7%      +0.0        0.25 ±  3%  perf-profile.self.cycles-pp.sock_recvmsg
      0.21 ±  9%      +0.0        0.25 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.17 ±  6%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.19 ±  7%      +0.0        0.23 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.18 ±  6%      +0.0        0.23 ±  5%  perf-profile.self.cycles-pp.alloc_skb_with_frags
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__x64_sys_read
      0.20 ±  6%      +0.1        0.25 ±  5%  perf-profile.self.cycles-pp.rw_verify_area
      0.23 ±  7%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.27 ±  6%      +0.1        0.32 ±  3%  perf-profile.self.cycles-pp.mutex_unlock
      0.20 ±  5%      +0.1        0.25 ±  6%  perf-profile.self.cycles-pp.aa_file_perm
      0.19 ±  5%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.security_file_permission
      0.25 ±  7%      +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.sock_alloc_send_pskb
      0.29 ±  7%      +0.1        0.35 ±  3%  perf-profile.self.cycles-pp.mutex_lock
      0.22 ±  7%      +0.1        0.27 ±  5%  perf-profile.self.cycles-pp.ksys_write
      0.21 ±  6%      +0.1        0.26 ±  4%  perf-profile.self.cycles-pp.skb_copy_datagram_from_iter
      0.22 ±  6%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.ksys_read
      0.27 ±  6%      +0.1        0.33 ±  4%  perf-profile.self.cycles-pp.x64_sys_call
      1.08 ±  3%      +0.1        1.15        perf-profile.self.cycles-pp.___slab_alloc
      0.31 ±  6%      +0.1        0.38 ±  4%  perf-profile.self.cycles-pp.unix_write_space
      0.37 ±  6%      +0.1        0.45 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.38 ±  5%      +0.1        0.46 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.33 ±  6%      +0.1        0.42 ±  5%  perf-profile.self.cycles-pp.kfree
      0.34 ±  5%      +0.1        0.42 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.40 ±  6%      +0.1        0.49 ±  8%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.37 ±  6%      +0.1        0.46 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.43 ±  9%      +0.1        0.53 ±  3%  perf-profile.self.cycles-pp.fput
      0.41 ±  7%      +0.1        0.51 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.41 ±  5%      +0.1        0.52 ±  5%  perf-profile.self.cycles-pp.__check_object_size
      0.45 ±  5%      +0.1        0.56 ±  4%  perf-profile.self.cycles-pp.refill_obj_stock
      0.48 ±  7%      +0.1        0.60 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.48 ±  5%      +0.1        0.60 ±  5%  perf-profile.self.cycles-pp.__check_heap_object
      0.58 ±  5%      +0.1        0.71 ±  4%  perf-profile.self.cycles-pp.sock_read_iter
      0.38 ±  6%      +0.1        0.52 ±  5%  perf-profile.self.cycles-pp.__build_skb_around
      0.65 ±  5%      +0.1        0.80 ±  7%  perf-profile.self.cycles-pp.aa_sk_perm
      0.47 ±  5%      +0.2        0.63 ±  5%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.63 ±  6%      +0.2        0.80 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.66 ±  5%      +0.2        0.83 ±  4%  perf-profile.self.cycles-pp.write
      0.65 ±  6%      +0.2        0.82 ±  5%  perf-profile.self.cycles-pp.read
      0.90 ±  5%      +0.2        1.08 ±  3%  perf-profile.self.cycles-pp.vfs_read
      0.69 ±  5%      +0.2        0.88 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.73 ±  6%      +0.2        0.92 ±  5%  perf-profile.self.cycles-pp.sock_write_iter
      1.10 ±  9%      +0.2        1.30 ±  3%  perf-profile.self.cycles-pp.skb_set_owner_w
      0.92 ±  6%      +0.2        1.11 ±  4%  perf-profile.self.cycles-pp.vfs_write
      0.77 ±  5%      +0.2        0.98 ±  4%  perf-profile.self.cycles-pp.__alloc_skb
      0.86 ±  6%      +0.2        1.08 ±  4%  perf-profile.self.cycles-pp._copy_from_iter
      0.93 ±  5%      +0.3        1.18 ±  5%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.61 ±  3%      +0.3        0.88 ±  7%  perf-profile.self.cycles-pp.skb_release_data
      1.88 ± 11%      +0.3        2.15 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.87 ±  7%      +0.3        1.14 ±  6%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      1.79 ± 17%      +0.4        2.14 ±  6%  perf-profile.self.cycles-pp.fdget_pos
      1.52 ±  6%      +0.4        1.92 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      1.65 ±  7%      +0.4        2.05 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      1.63 ±  5%      +0.4        2.04 ±  5%  perf-profile.self.cycles-pp.sock_wfree
      1.78 ±  6%      +0.5        2.24 ±  4%  perf-profile.self.cycles-pp.unix_stream_read_generic
      1.13 ±  9%      +0.5        1.66 ±  7%  perf-profile.self.cycles-pp.kmem_cache_free
      1.29 ±  9%      +0.6        1.88 ±  7%  perf-profile.self.cycles-pp.check_heap_object
      2.16 ±  7%      +0.6        2.78 ±  5%  perf-profile.self.cycles-pp.__slab_free
      2.67 ±  6%      +0.7        3.38 ±  5%  perf-profile.self.cycles-pp.clear_bhb_loop
      2.02 ± 11%      +0.7        2.77 ±  6%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      2.63 ±  4%      +0.9        3.54 ±  6%  perf-profile.self.cycles-pp._copy_to_iter




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


