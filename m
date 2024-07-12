Return-Path: <linux-kernel+bounces-250346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E434C92F6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB42F1C225FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F9914265C;
	Fri, 12 Jul 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou2aBgnb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54316282E1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720772257; cv=fail; b=S94q7wDL0lkOGqlFaIGc+czGmO8VYk84zxnwyASDSsvTYciERTmO8ZEyENvgEleDQuDiESl3njbB9Bx9DuyrdutvuuOk79a8TPQRcqPiBMbzPJQIpUizU2QAos/zj6ZCszg/YxSEN0Ihz0XOtD1r+SCf4pFNRWp5XstvNJbvjx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720772257; c=relaxed/simple;
	bh=KtsLo0ONRuKELPwkdF2shP5AGoKMWco+Or7TEE7T1Gc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QAGxUXKDHK6pUKSgepaGSmgf9VeCbsqczysUCzA5RjJwQ0eOVRwaYSfaRurlRbRUJ0pt/k+Rkbn1ZorE1IfZLDStAwF8M5zMqTXJIOwg57MsHcDMgO6yIhyKsrWYSdx9XAXm4JIP4uk+JINbnCvAdDtYsuUZrBbyohg6EhU0PS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou2aBgnb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720772255; x=1752308255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KtsLo0ONRuKELPwkdF2shP5AGoKMWco+Or7TEE7T1Gc=;
  b=Ou2aBgnbRslWttxgaz/l6lIt9A3QtAgUrFRAkjlie1Rw8tfiISFD8w33
   Bnz969WyM59pcMHVMY8oIAVrQQ0J0AQuv+dNNP3yibZEYAVzdXvxMoiDl
   Mqnj8Nab8hNEXcpZ4e8n6LbR6iWit8rJBx6vq0nATYtka8a/0Pm/BBd1W
   2QH8ixhxoxbDIuGZcBkkZQuWCae6CjtkHgpd5MdO6TUDNgyTfCdmAGMtz
   yOcWqdRCtkOMoHms+hHX1YRXHHWBCbgE131MLli/rn+t4oHMK5tksCzMO
   5chHbrlY2u/PzzU+4B9NRTyP3iVRiUBh8UvOTW1pKAtxPhVhJlAs7zd/n
   w==;
X-CSE-ConnectionGUID: vOk9ihrjT5C044dEWqUtzw==
X-CSE-MsgGUID: f8NJydKJQUq/FKCYHuMGIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29608898"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29608898"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 01:17:35 -0700
X-CSE-ConnectionGUID: FwH6FGTrTN+uGBH96efV3Q==
X-CSE-MsgGUID: AzKZxltdQdKox8+Ne0CnTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53771333"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 01:17:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 01:17:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 01:17:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 01:17:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 01:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNtO1/1GIV02DfVEb9aFKUVPnVR4BkYEMLbA52LiWSClIwwF6ql5F5vEdpko8Fo6jtWXYJDJ0oIe124LUrZhT2oC6aX8cSlY1qqEEs/IQedYCkjn8zgeTHK7nJUjmUeF6xS3jKtRIqNcZ8RhWmP/Q9PP8zknRVwJZ7zH2yC1+ZYOT8lkq3CqvwiSu6wGOs53iYQNhD/1eUUtm6C/YHADjV30Z6HnoQ2ducajej8TNJEkIzhS9puEb1i/gcmQh1QY9v0M2U1yE2KO4hRa+bzREScOdGa45n/OZda4nCkkIFr73pLNTBhFBx5HI9wobvihMAG4WS6Ry9c3kuTmClcgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXldtQJKdP8T7DI8797+o7UWkzEZeBKQnjhzWs9MJb0=;
 b=WuadU31IOHonTVKVax+sHJISmDcmwBy4FNw3oIAwHX0Hp+WBdy0EXaEhkU5sVQa0SqcAYjWxFozLchkXxKWaLlMVvA9Z9ZkhK9TDse0D1FV2o5oItb+KaaimZ8fdu3bWh4lD9rBPb8T9SPKNWoTlu/qIX7Og661lzSC1fGCoWqvsGycNwRy2kCgsZUtxaaoXpUOiAmz0hj0RT848whCnztHRz8kIDULUiELq0UvICe13/RJpPI1XC3zlqzN5hxRmVa1gPyxV5WyePJPhaj6ekhsSUfW9/x8VhEWh4G/wrvBE5VQFcJgSdWYPf7q6odTwG9aF8hogH07CI4m32VGqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Fri, 12 Jul
 2024 08:17:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:17:30 +0000
Date: Fri, 12 Jul 2024 16:17:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Nicolas Pitre <npitre@baylibre.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Uwe
 =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Biju Das
	<biju.das.jz@bp.renesas.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [mul_u64_u64_div_u64] 1266b1896f:
 UBSAN:shift-out-of-bounds_in_lib/math/div64.c
Message-ID: <202407121652.69e657c5-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: f04b8d1d-2df0-4a2c-ba7e-08dca24b1297
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9nK/68V4i8190oGbdU7nUxu7SU2+vYuksFHhomEDEYDDkpN68oodyo+nKFd/?=
 =?us-ascii?Q?iFgC42SzzbKa4kKpHKUCxghnH2P89ztBkej+AyVgcVc7vij1U+OtuAIpzt0v?=
 =?us-ascii?Q?hWnxGdqiv9WahNEK4EI0dbNSyjs9VWSENUMrFKhefyi99R5087tj3C/rk76a?=
 =?us-ascii?Q?FAGJQsPNMQgz9aRjqVjkepf8eVgCmXJzWJYJFVgbBTDyN8LRmyg8W4+mq8sf?=
 =?us-ascii?Q?dQq8u21hOnOsoj4Q71in4D9WTAnkKWczuNw5Afr64SdIacwYj1dm6Dz1oRLT?=
 =?us-ascii?Q?Ifo62sZvcme5l3edKu+v4ja/itrLpgIp6LTu6mXkCh/8wltk5wOkmLh73ogu?=
 =?us-ascii?Q?o3tCmHORNvgLQVIKibD+DV5WDzBXJBUt6rVz+vmnpetzJVqwcalXtLcF1FWE?=
 =?us-ascii?Q?0CFRFZVAYUMlLdiW8H4C2x42G5OedItxd2kPaHm/ZDPxHUjYk8aRUfaGQVG/?=
 =?us-ascii?Q?mWYqxLqddc096qlLYaU6KDYLY55gnAppiMD5kQtExdp2pK4ZjcGcsUIxRdnN?=
 =?us-ascii?Q?Mz7nr7X4Ivsfwxz5uTV1IT62sPIQ122iSHsqPNhsR7rCQdYfYSQ9Mcg2ZXZ+?=
 =?us-ascii?Q?D+yaccdLQVOGtHuHbeRZq/xduj9YMm0EpgjUS7NHAXeUUlwMbDK4OaOz7/SH?=
 =?us-ascii?Q?t5RFPhyT8CJoUBBx81PtBGCTwiM4kRxpJAuJ2V9qXm0etCVxMFusq5oHgvjp?=
 =?us-ascii?Q?SmjCjt4t4GJRUShIT0jpcLirjhEc0laIvFn9jCoL7nqV5s9CV0/TJhKJq307?=
 =?us-ascii?Q?KQJiddOgDgqLD4wX/5qIUdXa42HzzW3HQAYNfUd4DBWSKBQYF+SHkBv/kygZ?=
 =?us-ascii?Q?eyMuHQFLkS04WmFqWzU0uvDq0lJYkwF13rBL80I02/jDgzdCdJgRU+spvX54?=
 =?us-ascii?Q?du1iTByUEl1oDjQvvtLcAcyZQdBdkfTQyoQtcI1/6iORS7zcJfABneT3AfbK?=
 =?us-ascii?Q?PBH4b99wXQEnzewHJWkOx0KlqWeSSNXwXwHYMTg6lTsWYDtpX2ugf9fwLbpT?=
 =?us-ascii?Q?jc0M+ksm//YBP3NmjjYlDhFF64zRMkatdlZP+sHgVqOSQ68pY9x9YGCQ055w?=
 =?us-ascii?Q?KPvEMPMrKAag6vbHR9gMTzKGV6dQ5to0eZruzI5ACkf9eNMd4nMDNRKEg9CD?=
 =?us-ascii?Q?WqExYORczD1Qo7i2lAsPuOKp1s77Bpj1ZCTfjaN7YskMqOjAauf+tcXt8BeO?=
 =?us-ascii?Q?/A/HYDPMPVTk3qQc4xM8AUMZ8bm6vbJjOeVn3L6MASCb7UxRE8ewo+1CNwtX?=
 =?us-ascii?Q?Y1zn5zlTKCnw1jVEu0cYURpuBEjyzEPdjcBbd8sPe9UvDCbdHD7o5d70vIW5?=
 =?us-ascii?Q?faz79vDovIUNJN8D+ZxreF8u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3eptL6sJ9vEE0LucSPaKB0UHtW1vUQbprO0BDhYVH4mNelDpsL+1+Qpue7qB?=
 =?us-ascii?Q?M4pxcXjHmtk12o+gVfoCLnLTyLWvbt5f9w1U9qfqWGafCAuiIxtkqtqShRzu?=
 =?us-ascii?Q?Cdd1N0Esjsp+jNQhskGqr0trxAfoeBfUotWixTL61bffkAaeIQhjtSJAl7m+?=
 =?us-ascii?Q?cMiMR3QGQkyLIZt5OBxkhkC14oOQ2kzNJyqDRmZ1GXwQTMGUxSQdRXD6TOga?=
 =?us-ascii?Q?iv/NHsVcxPETV6RUpoakonMgdaBMFqbn3R6P0QyZutuWLuwJJWCjAbdSyc0N?=
 =?us-ascii?Q?LG+W1kyVIlWHr5ONp/X0w3fQd8FkaSX7YhxpD5S2fmM9UigZOX1Ng/GfxjFu?=
 =?us-ascii?Q?EYmiemd5uBq+DLhpvITQO8bYPVzZye/wXhnJLJfwuCqyHN6dJerEdRHwygh8?=
 =?us-ascii?Q?zahOziL5nJcfXhyo+Gqo3ogY1I5xFqr+QfcZN1Yzeug/UJFDSdQxTWGhP8EM?=
 =?us-ascii?Q?I9xijj2/00nwRHasl0fJc2+kMMq4j3jBGQE2jGbDrzC/6hImAwX/mAghIBwF?=
 =?us-ascii?Q?yiRMUyYdJHvKlVt7RhaH6an7cjp3FPB4uhmFunUS/mV6mlpiAy29rWl7+gnZ?=
 =?us-ascii?Q?NkE05DuqsgiPiqRHlGEkZOzmCRI6vxtmcUoWMI0E10iZ5VE1TArwiAM2L88I?=
 =?us-ascii?Q?M0RIJ+XPuW08ah/RVIYIQYxviem9Z0xU7lRCAuV+gT6hu0iyuYpLBcM0lU20?=
 =?us-ascii?Q?TsbUnXaGktfsEIgnCiHGJaAFKMsgsWB0X204TPG0W+MY6CFdjgF2TOwUSz6B?=
 =?us-ascii?Q?ClyL5f0NJoC4pPYDcBovvQnRr+OvY6tz/iguvuuhWKTORNQlSIBmpMtPu51X?=
 =?us-ascii?Q?3H4wdHlFSNfPS1a1bD36Krn1EsYiLglnQKzBHIuxZmPoTIC3O52DtgmigzlR?=
 =?us-ascii?Q?eqZlvMsNfmewxzpbrSX0ghCeWpoK87noLaxqnwTz5gx0yIcLvuAOee77Za4w?=
 =?us-ascii?Q?v4jkLoBXLzO1RJW3msirMLqxNwXIq68h+i5V/ZvMFPBC2YL8EelTeGNbZP+H?=
 =?us-ascii?Q?YW53nHtGbeBZsOBMRyLun/DH6qv/x9XuvFZrfUhMDcvdJb4XEa0jbijBPWV9?=
 =?us-ascii?Q?aE+k9fm2JW8+mdH7VzhO3owWw0WtZMxgz9juJ4RKv/aZk5PbimFMK8vD6Tlq?=
 =?us-ascii?Q?54wgoj2+uKpFBGEw/QPCfwBkFBkLCJOtZQLwqQM6EPalfhBDrEj4WnLFvf7j?=
 =?us-ascii?Q?1GddDyAsOOshEO1RsnGj8wZkZq5KEn1ODupmt+laIgmuUeh/oc8txZdd+nQE?=
 =?us-ascii?Q?zEyU9VFeDPTN+0h+1iZPIf0kebb8Z2BtxJA7hIa3STNaSIbZD9ml+aAhRDBG?=
 =?us-ascii?Q?Zo1BTFkNFZp3jmRLp79oG9ZQEzJyrSBoxn6qXwoqewyqPntwLkacIdtxHt2c?=
 =?us-ascii?Q?f++yQFpVZHpRgdWrTGcl9ZOQn0xG87bMLKpVDLE3H+olljbejXhx0QPrYNk3?=
 =?us-ascii?Q?j2L47i2HGI3IkX1ghJYMWoOIdhPF5F4GEPaQcLCFZ++dtbagtwPzsiDd5Ojy?=
 =?us-ascii?Q?RJOJN/EcmEvf3FOPUAs97xHVvNMdlAA9YRycFIkwGbBb6RlnTEqD+zkhYO2f?=
 =?us-ascii?Q?H+Qc/4DBaz0qUllTSM40nubYopToD0VrRAIqsO2RC/Ce6AZHw5LJTrorcGAC?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f04b8d1d-2df0-4a2c-ba7e-08dca24b1297
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 08:17:29.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0t216le0rmVon1apagrsumWWI3c3mgeBDyUBHFSiZk/q2u22BGRIxRK9VMRx3caBJMLE0B1Q8f/VHh75jmrxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:shift-out-of-bounds_in_lib/math/div64.c" on:

commit: 1266b1896f98fbe5733b16858cc042b729b52ece ("mul_u64_u64_div_u64: make it precise always")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f477dd6eede3ecedc8963478571d99ec3bf3f762]

in testcase: trinity
version: trinity-static-i386-x86_64-f93256fb_2019-08-28
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407121652.69e657c5-oliver.sang@intel.com


[  181.992621][ T3569] ------------[ cut here ]------------
[  181.993267][ T3569] UBSAN: shift-out-of-bounds in lib/math/div64.c:219:35
[  181.994037][ T3569] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[  181.994783][ T3569] CPU: 0 UID: 65534 PID: 3569 Comm: trinity-main Tainted: G S      W          6.10.0-rc6-00123-g1266b1896f98 #1
[  181.995795][ T3569] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[  181.996338][ T3569] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  181.997262][ T3569] Call Trace:
[ 181.997559][ T3569] dump_stack_lvl (lib/dump_stack.c:122) 
[ 181.998005][ T3569] dump_stack (lib/dump_stack.c:129) 
[ 181.998376][ T3569] __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:232 lib/ubsan.c:468) 
[ 181.998960][ T3569] ? __lock_acquire (kernel/locking/lockdep.c:5137 (discriminator 1)) 
[ 181.999435][ T3569] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4) kernel/locking/lockdep.c:5719 (discriminator 4)) 
[ 181.999878][ T3569] mul_u64_u64_div_u64.cold (lib/math/div64.c:219 (discriminator 4)) 
[ 182.000403][ T3569] cputime_adjust (kernel/sched/cputime.c:604) 
[ 182.000854][ T3569] ? cputime_adjust (kernel/sched/cputime.c:604) 
[ 182.001298][ T3569] thread_group_cputime_adjusted (kernel/sched/cputime.c:635) 
[ 182.001753][ T3569] do_task_stat (fs/proc/array.c:582) 
[ 182.002166][ T3569] ? get_pid_task (include/linux/rcupdate.h:338 include/linux/rcupdate.h:811 kernel/pid.c:468) 
[ 182.002587][ T3569] ? proc_tid_stat (fs/proc/array.c:679) 
[ 182.003001][ T3569] proc_tgid_stat (fs/proc/array.c:681) 
[ 182.003401][ T3569] proc_single_show (include/linux/sched/task.h:127 fs/proc/base.c:780) 
[ 182.003827][ T3569] seq_read_iter (fs/seq_file.c:230) 
[ 182.004259][ T3569] seq_read (fs/seq_file.c:163) 
[ 182.004629][ T3569] ? seq_read_iter (fs/seq_file.c:152) 
[ 182.005057][ T3569] vfs_read (fs/read_write.c:474) 
[ 182.005419][ T3569] ? __task_pid_nr_ns (include/linux/rcupdate.h:338 include/linux/rcupdate.h:811 kernel/pid.c:514) 
[ 182.005862][ T3569] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 182.006285][ T3569] ? mutex_lock_nested (kernel/locking/mutex.c:805) 
[ 182.006741][ T3569] ksys_read (fs/read_write.c:620) 
[ 182.007147][ T3569] __ia32_sys_read (fs/read_write.c:627) 
[ 182.007590][ T3569] ia32_sys_call (arch/x86/entry/syscall_32.c:42) 
[ 182.008041][ T3569] do_int80_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:339 (discriminator 1)) 
[ 182.008510][ T3569] ? syscall_exit_to_user_mode_prepare (kernel/entry/common.c:199 (discriminator 1)) 
[ 182.009087][ T3569] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 182.009588][ T3569] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 182.010049][ T3569] ? mutex_unlock (kernel/locking/mutex.c:549) 
[ 182.010449][ T3569] ? __f_unlock_pos (fs/file.c:1199) 
[ 182.010861][ T3569] ? ksys_read (include/linux/file.h:47 include/linux/file.h:83 fs/read_write.c:622) 
[ 182.011238][ T3569] ? syscall_exit_to_user_mode_prepare (kernel/entry/common.c:199 (discriminator 1)) 
[ 182.011844][ T3569] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 182.016479][ T3569] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 182.016985][ T3569] ? __lock_acquire (kernel/locking/lockdep.c:5137 (discriminator 1)) 
[ 182.017435][ T3569] ? __lock_acquire (kernel/locking/lockdep.c:5137 (discriminator 1)) 
[ 182.017885][ T3569] ? __lock_acquire (kernel/locking/lockdep.c:5137 (discriminator 1)) 
[ 182.018322][ T3569] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4) kernel/locking/lockdep.c:5719 (discriminator 4)) 
[ 182.018725][ T3569] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1)) 
[ 182.019160][ T3569] ? __lock_release+0x43/0x130 
[ 182.019647][ T3569] ? do_perf_sw_event+0xe3/0x1e0 
[ 182.020221][ T3569] ? do_perf_sw_event+0xe3/0x1e0 
[ 182.020740][ T3569] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 182.021151][ T3569] ? do_perf_sw_event+0xf2/0x1e0 
[ 182.021666][ T3569] ? ___perf_sw_event (kernel/events/core.c:9986) 
[ 182.022090][ T3569] ? look_up_lock_class (kernel/locking/lockdep.c:926 (discriminator 28)) 
[ 182.022552][ T3569] ? register_lock_class (kernel/locking/lockdep.c:1284) 
[ 182.023023][ T3569] ? __lock_acquire (kernel/locking/lockdep.c:5137 (discriminator 1)) 
[ 182.023470][ T3569] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5756 (discriminator 4) kernel/locking/lockdep.c:5719 (discriminator 4)) 
[ 182.023891][ T3569] ? __lock_acquire (kernel/locking/lockdep.c:5137 (discriminator 1)) 
[ 182.024353][ T3569] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1)) 
[ 182.024766][ T3569] ? __lock_release+0x43/0x130 
[ 182.025263][ T3569] ? __f_unlock_pos (fs/file.c:1199) 
[ 182.025688][ T3569] ? __f_unlock_pos (fs/file.c:1199) 
[ 182.026126][ T3569] ? lock_release (kernel/locking/lockdep.c:467 (discriminator 4) kernel/locking/lockdep.c:5776 (discriminator 4)) 
[ 182.026538][ T3569] ? __mutex_unlock_slowpath (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-long.h:40 include/linux/atomic/atomic-instrumented.h:3189 kernel/locking/mutex.c:921) 
[ 182.027023][ T3569] ? seq_list_next_rcu (fs/seq_file.c:309) 
[ 182.027477][ T3569] ? mutex_unlock (kernel/locking/mutex.c:549) 
[ 182.027901][ T3569] ? __f_unlock_pos (fs/file.c:1199) 
[ 182.028416][ T3569] ? __ia32_sys_llseek (include/linux/file.h:47 include/linux/file.h:83 fs/read_write.c:350 fs/read_write.c:325 fs/read_write.c:325) 
[ 182.028892][ T3569] ? syscall_exit_to_user_mode_prepare (kernel/entry/common.c:199 (discriminator 1)) 
[ 182.029473][ T3569] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 182.029984][ T3569] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 182.030447][ T3569] ? up_read (kernel/locking/rwsem.c:1623) 
[ 182.030816][ T3569] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234) 
[ 182.031338][ T3569] ? irqentry_exit (kernel/entry/common.c:367) 
[ 182.031743][ T3569] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 182.032174][ T3569] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[  182.032569][ T3569] EIP: 0x8097522
[ 182.032881][ T3569] Code: 89 c8 c3 90 8d 74 26 00 85 c0 c7 01 01 00 00 00 75 d8 a1 cc 3c ad 08 eb d1 66 90 66 90 66 90 66 90 66 90 66 90 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 10 a3 f4 3c ad 08 85
All code
========
   0:	89 c8                	mov    %ecx,%eax
   2:	c3                   	ret
   3:	90                   	nop
   4:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   8:	85 c0                	test   %eax,%eax
   a:	c7 01 01 00 00 00    	movl   $0x1,(%rcx)
  10:	75 d8                	jne    0xffffffffffffffea
  12:	a1 cc 3c ad 08 eb d1 	movabs 0x9066d1eb08ad3ccc,%eax
  19:	66 90 
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	66 90                	xchg   %ax,%ax
  21:	66 90                	xchg   %ax,%ax
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 10                	mov    (%rax),%edx
  3a:	a3                   	.byte 0xa3
  3b:	f4                   	hlt
  3c:	3c ad                	cmp    $0xad,%al
  3e:	08                   	.byte 0x8
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 10                	mov    (%rax),%edx
  10:	a3                   	.byte 0xa3
  11:	f4                   	hlt
  12:	3c ad                	cmp    $0xad,%al
  14:	08                   	.byte 0x8
  15:	85                   	.byte 0x85


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240712/202407121652.69e657c5-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


