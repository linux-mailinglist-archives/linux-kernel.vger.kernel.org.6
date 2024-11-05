Return-Path: <linux-kernel+bounces-396075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900069BC7A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97ED81C20B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DCB1FEFBD;
	Tue,  5 Nov 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELr5ur9C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48733981
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730793564; cv=fail; b=tvprD44lpuVUddjQcpBJ0KVbNLt0GWTsu88FnfqTIX5YtZFaNDG2x3hcMuxyQ95/ctxSb3yXWGV8l5c6clX96iqnex5ccWtZbtlxaJtked3dP43gsM39xZWTksfCbvEZ6sh9yBVo52vMUkrInc/WWGCs7i/naRJ94ZQRzybAs9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730793564; c=relaxed/simple;
	bh=Bl2wn+ZzW8cAPBh7Df5gmUx+kZvI6B0FZ9bNQqzvS/c=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=UmyRarqQ/W7MoBdaraXVLIasa3RIzYg57pJioQo63NgcnFP7K0hN61RHpqzBtla7HyDkxKiMSEcIXp38K6G375yj/BiiSc7ncp/sz/BTyG+278hcpsQ8jX4Ra01OdaQg1BodNp3c1zFbn0aAtPHUnrsSLK4fWjYfVIh2zpl3ACs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELr5ur9C; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730793562; x=1762329562;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bl2wn+ZzW8cAPBh7Df5gmUx+kZvI6B0FZ9bNQqzvS/c=;
  b=ELr5ur9CGktmLKrMwUgRDRHWsDZTrHhJdU+wBvb9d8Rn/u6rllUEE3Xf
   m7zhIsR8roIT3FCS9oPysvM9rAfK5nGYABdgMOuoGgWkNbF7VIUJAcNP+
   Ffa8E4ZhGkvIOt1mheWeySOPukwq94ISeHEY8OmIP4kMw2S+37fgh1DMn
   GANzuUVW5MoQnCJxwi97pVRxU8iooRsHjfZsQcLc4HEA5LtBS46wPJcm6
   YDh7GoAzNyXKVsESjITqIY2qv0TzRjez1qP7C/w793d05IQ1pTufOZ5D2
   vakziMhvWrBfPgeTgBaTvCkSctGTXKr0SlvFiyBt4O/q5FjKp1mD7ghBN
   w==;
X-CSE-ConnectionGUID: QJ+grqavQkCD1mattXrhoQ==
X-CSE-MsgGUID: nii1XYjdSAyD6G9fnqwZYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="18143580"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="18143580"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 23:59:21 -0800
X-CSE-ConnectionGUID: 6IMKYpETSh6xAoFXcGlDig==
X-CSE-MsgGUID: 2g3onRIVTUufeuX9CK9lBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="84022308"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 23:59:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 23:59:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 23:59:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 23:59:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZ2FJWWARymICV4E69M6ZdnXUWGYNXK5QmtS7uSV3mFDplT+yb899CdqqBLcS33xjeFLkKd6xdLXMxci1jcfQhFScuNNSon0KEqcHZoBpMAaQr+JUDLQ8//4utzy1cUKokhkjG2o67c0AD8EKwKVNLILPwZh2ISSC/PVkPbYBOwKoB+3yCfz6NhiZ2fxytWIHXMo8Bp3rXvuMCLI/lorTaeVXRpB95Gi03Jf2qpkKXtPMC/gdkhCiRNAm2RtOPaFu07FUYH2O88+qZf4SVixQVbeSlANg/RECIEpBvlxmRwRHd+IgpeZgbcV74VlDn3E20PXW5tIIu77REFqn5omLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAY0+bmDH+KoZP968zXFaQ/7sW/iBBV/UCurzzQ2dFM=;
 b=RzKhUhgtNmBT+F0oV8Lu3C6aeFg2Ep6fd/oJknxi5VkOJ8ACkAq/rb8ZNKW0MkRZospGHxzKPjRZHkapNbQ1haCGZwIQ2XPntBGoRvZKkNhLRo133PVSF91acJGbkRJrXM2iuymrzy6uaUsH7SjXcKaNOiusC79T/ecC6Yb7dV+WUxjFL6wGTL4KarvUkBemwzv68vuWEzt+QV6MVAkva7kxxUtl6YhiNRf5xrNFt3dCwlc70ya9Jqikq+vONixzWw0GVlGM8SWl96zvn0ZNRLNWe7tOWybnP0MCaOj1a4ql5rUgFvAZyA+HjmDCI84Qz2Bp4HJs2jOBOPYhcq2tnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Tue, 5 Nov
 2024 07:59:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:59:11 +0000
Date: Tue, 5 Nov 2024 15:59:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [x86/uaccess]  0fc810ae3a:
 will-it-scale.per_process_ops 3.1% improvement
Message-ID: <202411051526.913796e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 918fcdf9-3320-4f5d-df81-08dcfd6fbb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aVHCwCideYnYLlh8MM6G0kCP4kcW+iB2FeDPbdv+jKgThPOOf5PSdfY+wCa9?=
 =?us-ascii?Q?DezlsiJmp3crTqgjanNcCxQBb8JD5ljHFePGPwkXFSF5rfUY7mnSJ9Uftq2o?=
 =?us-ascii?Q?O7HD+HkaZzhfPjqKvNIIsUAM2NppI24J8MZ5cuttuVeOGNjqJ/9S9TtKWIQ7?=
 =?us-ascii?Q?sZNbJ3p+SSYCuGGAjAE/wbDgUpLgjUBUvZM7GRII9QhYdR2zRrTeH333kGou?=
 =?us-ascii?Q?Nv+qsABsXFkif7jFKkS5yC1WioMdKdFkkvMoyOf7VJXJSfhkacK+vZ3PzeLO?=
 =?us-ascii?Q?VyKWJRcKN34SU2O87EycdOYnOgetFQoxN0d+StDUaS/jsjiXr3ea4BBPB9eu?=
 =?us-ascii?Q?DIWnG5Gf2WBprhRUU6fiH2bBmELPxtjXRgbkZwK4EtU+hCNoK+6I1Ot8+7sh?=
 =?us-ascii?Q?wuwUyvvx0ZPR1rpGaQ91KcvUp1jXzlmwct0OyysfgErQwQy/EN/P62/fnMSf?=
 =?us-ascii?Q?+Y/DCRgSycvJjVg7809wgfBqFxpdxg1T5O2FezrV9Z7ncVGZFZlBCYNrDEHX?=
 =?us-ascii?Q?a09MAEIpCxUUWmjqGWotORA0GsRuBt4+4w03jS3O+XuaJzufl2zUZ/YgXfog?=
 =?us-ascii?Q?ZzWuq6UBR3/pOkyyyIbVW8t/7ON+Koc92phc+N7xG7ka7hHgAzpWKw5Rxw/V?=
 =?us-ascii?Q?Nl+vDRn4F1xOz0Ffsj8wPkayU+u2mllmw1Q/Xqz9ntEgtqkwkd/5ZqKT4at8?=
 =?us-ascii?Q?X8kfZ55yaarHwRUm7w6ndxTKjGEy6BiJHpp8pNfyVZ6xixN6m4KlJJoF6DkB?=
 =?us-ascii?Q?jHZcfljBLS89LQqniBQdcZZwZT0nz08bhuoTofcUbPcM/xydazujXKLqvEWo?=
 =?us-ascii?Q?6Popp1uo9NFsHzIn7AoQ4LxL2RytdAIr4echZz1j3drBGebMugu336CyJlGk?=
 =?us-ascii?Q?WJIKmcjIcnrfvfwHlBidJ/fDxVh6aYflHkMbUtiD4c+StySejEd7irlJTkMu?=
 =?us-ascii?Q?wdteb1jCMf33vv32HCKiR128B3I3SYwKyLe4XHvJbYJC+OZh3obEzeMobmSG?=
 =?us-ascii?Q?SdiYMOansN1jBpun10sWgsBYoSWfNvRgxJ+YO37enBpPVDy2sviERauZDP93?=
 =?us-ascii?Q?C+S/G+unoIiuICQy+CHlyZPavroLgQG84ml2P5gmRJipA4Mm/Pd1pZaFHeHF?=
 =?us-ascii?Q?VmymSTq0pievETJJSunHMXi3RyyuRrS79SJ+HRYnQI8bC/ohWl3Fk+ZPV5HU?=
 =?us-ascii?Q?+zZFzyDT6ejbrBY7tXVkyUt07ZMDdnaCJaCpHqsL1I8VYdO7UeeQDL7JxkXB?=
 =?us-ascii?Q?uY0h2BfqDbLwOnk+m2oob50Et3ctf2gi3/egjIrDaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jgFn20KEGrKbUXGVTv253zFtNRFqNOJ4MAx+0FqhN+IofbEGS0cVgR9S6hdk?=
 =?us-ascii?Q?R/akUMIRHhacn/Kr7P8vviOsnTz3Oa6OliBG8It5IUWUbyJn6eDjVtnwuo1C?=
 =?us-ascii?Q?mmP5jlXeZ6ZD86Q6zLxBw9ejddZCxUw+yt1J1ZctLNOsd4ggoAFkF2xKSRaA?=
 =?us-ascii?Q?vCXa1a+2R7mKRrsPtE7s6lsIA4wwpaSuJHSRjtmE5zMJWatiQn8ebvkpTSvT?=
 =?us-ascii?Q?Tr9M9dLPFiP4dxcPgJBvl6sQoSEhrkVWV8qbV6/P5ppFp+6ZIWjNLzeMAc0O?=
 =?us-ascii?Q?sbZw7XDZizVb2nPhv+5m2Yz0fIWSG6y9J3KfszSfdXKfaflOp7are22PcsmM?=
 =?us-ascii?Q?GHmHFCgee5nkg3kptAZhJZi8L4y2C+WYS+KDA5ywKy5O19cAq6SPeQksZ3pX?=
 =?us-ascii?Q?H9l0uyvLQmNWxrfiHwoQSzPA4lnjjn1BSFzE0LpxJOndDlgoHoIR4Yr2kJtQ?=
 =?us-ascii?Q?StGBsUbl6np0KXiVg+Nz4IvoolpMjo8d5vS/+smrQHz9/ZWmnc2slMvR1y5P?=
 =?us-ascii?Q?OJvM5BWcC1tJSj0IhO5TbxEJXIUGbVUheMKBI86g+52oUurxhsjLIdVZ+QmP?=
 =?us-ascii?Q?fSQGtm/5xd8COZC2aKABFP31xsFaXPDBGjOt4vuZKdU7P16TP7oqFrdaLLEP?=
 =?us-ascii?Q?GFaNX5JsmrupQU4tS9QlAB8B3xmLWkpLfGpy8v+fZVwLUBqc+t3MhJhtJJyr?=
 =?us-ascii?Q?rhmkabtl7DFn8wCGu8E7+uubozwhYPFwx2MH+Ou3RSlkoGdArc4gurKei2KZ?=
 =?us-ascii?Q?lfEBhiRL4XlojnOj0XPodhpEQovK+0Xo+H5kswdKgpiEExXM7SJ+aNS5RAmC?=
 =?us-ascii?Q?r12Ob5K4SUrQyKdZGbR+cYZf28oH5X94ZdPoILFyRLkJXZn01TAJTMHKpvJZ?=
 =?us-ascii?Q?mjC+9zE5Kl5lDmJp2ro1xHyG1oqOFUSeu6o+UKA2YDYheU4jqHt9N5p5xKDU?=
 =?us-ascii?Q?PKcaG/SbBX78z50QSB1Zs9U5EFusoIBfxjjk+iGnMg9kBcoqWHa8Ias6QTLU?=
 =?us-ascii?Q?wp8rp9wLTlq+oVFbn4Yle4wrARhadd87FjHD83XSm5Bku/TsENLRlCFPoNAE?=
 =?us-ascii?Q?jyDbOy3RY3ASFbDzLWkwGJdk+RrSPyycN8qRGx2lE9NvHxUN+Mnpc2HTPYIX?=
 =?us-ascii?Q?0x4Scvh94hvP/9sM32mE6kEZbP2LXRg13M9DOxtr2/1brCdN92Dv3PUwJGiw?=
 =?us-ascii?Q?tpFoUhCswMF1qUL8eLgt4pGyFjxYjQ91hljow3C0c5hWby/uKWI1U7h+D87a?=
 =?us-ascii?Q?4Hah7lIqcwExRjXhe/ybEqkaIHVMEIqdU9B4Ylsko4n189Olt9E/jSJTEAC4?=
 =?us-ascii?Q?QdVs8i23tdjckkJ13K25g3uwWWlpygDGaIEFyJ6lhxaV/9C5ydodzs9uIcM8?=
 =?us-ascii?Q?CcXpjJjIsEepqiQSScX74AekFiRH+Qmvr9c7QyJulTsIfIUznJ/vIWINJDnI?=
 =?us-ascii?Q?C2yxQFy/8BOHR/3vhlNOMTCfy0DZKOLzFEUBFcbduu+J+JGgrTIr+zFnxOP2?=
 =?us-ascii?Q?sKIIp7JymXGg1D2M7nvKQMT3FnqVl134C4pq7tbrVF3eFTrIVRaKgdSNFku+?=
 =?us-ascii?Q?JocyqLoCG0qk+u9IGn5pFpj/3hwkFSTRNR0YSyVLQhSfQR4AU3qvc3u/yWBF?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 918fcdf9-3320-4f5d-df81-08dcfd6fbb9e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:59:11.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEYepGsf4+yngvEqEa2zKuMaXAAWY+hozC27Ddb9obhRhQE4/fHKraZtJ/yVTwgzLybxvFdQwlV7f+OWHr9gOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.1% improvement of will-it-scale.per_process_ops on:


commit: 0fc810ae3ae110f9e2fcccce80fc8c8d62f97907 ("x86/uaccess: Avoid barrier_nospec() in 64-bit copy_from_user()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: will-it-scale
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	nr_task: 100%
	mode: process
	test: eventfd1
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241105/202411051526.913796e-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/eventfd1/will-it-scale

commit: 
  14b7d43c5c ("Merge tag 'perf-tools-fixes-for-v6.12-2-2024-10-30' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools")
  0fc810ae3a ("x86/uaccess: Avoid barrier_nospec() in 64-bit copy_from_user()")

14b7d43c5c068cb9 0fc810ae3ae110f9e2fcccce80f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 6.721e+08            +3.1%  6.929e+08        will-it-scale.256.processes
   2625451            +3.1%    2706555        will-it-scale.per_process_ops
 6.721e+08            +3.1%  6.929e+08        will-it-scale.workload
 1.603e+11            +2.3%   1.64e+11        perf-stat.i.branch-instructions
      0.81            -2.6%       0.79        perf-stat.i.cpi
  8.18e+11            +2.6%  8.392e+11        perf-stat.i.instructions
      1.24            +2.6%       1.27        perf-stat.i.ipc
      0.81            -2.4%       0.79        perf-stat.overall.cpi
      1.24            +2.5%       1.27        perf-stat.overall.ipc
 1.597e+11            +2.3%  1.634e+11        perf-stat.ps.branch-instructions
 8.152e+11            +2.6%  8.364e+11        perf-stat.ps.instructions
 2.484e+14            +2.5%  2.545e+14        perf-stat.total.instructions
     10.11            -2.6        7.50        perf-profile.calltrace.cycles-pp._copy_from_user.eventfd_write.vfs_write.ksys_write.do_syscall_64
     13.86            -2.6       11.31        perf-profile.calltrace.cycles-pp.eventfd_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.80            -2.5       14.30        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     19.08            -2.4       16.64        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     21.97            -2.4       19.58        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     23.21            -2.4       20.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     52.90            -1.5       51.43        perf-profile.calltrace.cycles-pp.write
      0.82            +0.0        0.83        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.60            +0.0        0.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.read
      1.46            +0.0        1.49        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.08            +0.0        1.10        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      1.30            +0.0        1.32        perf-profile.calltrace.cycles-pp.testcase
      0.60            +0.0        0.63        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.write
      1.12            +0.0        1.16        perf-profile.calltrace.cycles-pp.read@plt
      1.62            +0.0        1.66        perf-profile.calltrace.cycles-pp.fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      2.18            +0.0        2.23        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.read
      1.06            +0.1        1.11        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.18            +0.1        2.24        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.write
      2.39            +0.1        2.44        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.eventfd_write.vfs_write.ksys_write.do_syscall_64
      1.61            +0.1        1.68        perf-profile.calltrace.cycles-pp.fdget_pos.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.72            +0.1        1.80        perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.22            +0.1        2.31        perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.eventfd_read.vfs_read.ksys_read.do_syscall_64
      9.44            +0.3        9.78        perf-profile.calltrace.cycles-pp._copy_to_iter.eventfd_read.vfs_read.ksys_read.do_syscall_64
     16.77            +0.4       17.18        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
     13.14            +0.5       13.62        perf-profile.calltrace.cycles-pp.eventfd_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.00            +0.6       17.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
     21.07            +0.8       21.87        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     23.41            +0.9       24.32        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     26.39            +1.0       27.40        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     27.66            +1.1       28.72        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     57.88            +1.7       59.63        perf-profile.calltrace.cycles-pp.read
     10.46            -2.6        7.86        perf-profile.children.cycles-pp._copy_from_user
     14.06            -2.5       11.52        perf-profile.children.cycles-pp.eventfd_write
     17.01            -2.5       14.50        perf-profile.children.cycles-pp.vfs_write
     19.30            -2.4       16.86        perf-profile.children.cycles-pp.ksys_write
     52.62            -1.5       51.12        perf-profile.children.cycles-pp.write
     48.64            -1.4       47.27        perf-profile.children.cycles-pp.do_syscall_64
     51.11            -1.3       49.81        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.60            +0.0        0.61        perf-profile.children.cycles-pp.read@plt
      2.39            +0.0        2.43        perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.05            +0.0        2.09        perf-profile.children.cycles-pp.testcase
      2.25            +0.0        2.30        perf-profile.children.cycles-pp.security_file_permission
      1.53            +0.1        1.58        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      2.19            +0.1        2.27        perf-profile.children.cycles-pp.x64_sys_call
      3.24            +0.1        3.34        perf-profile.children.cycles-pp.rw_verify_area
      3.24            +0.1        3.36        perf-profile.children.cycles-pp.fdget_pos
      4.66            +0.2        4.81        perf-profile.children.cycles-pp._raw_spin_lock_irq
      9.46            +0.3        9.80        perf-profile.children.cycles-pp._copy_to_iter
     17.59            +0.4       18.00        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
     13.24            +0.5       13.72        perf-profile.children.cycles-pp.eventfd_read
     22.10            +0.7       22.78        perf-profile.children.cycles-pp.entry_SYSCALL_64
     21.12            +0.8       21.93        perf-profile.children.cycles-pp.vfs_read
     23.44            +0.9       24.35        perf-profile.children.cycles-pp.ksys_read
     57.52            +1.8       59.32        perf-profile.children.cycles-pp.read
     10.38            -2.6        7.80        perf-profile.self.cycles-pp._copy_from_user
      0.66            +0.0        0.67        perf-profile.self.cycles-pp.ksys_write
      0.45            +0.0        0.47        perf-profile.self.cycles-pp.security_file_permission
      0.71            +0.0        0.73        perf-profile.self.cycles-pp.ksys_read
      1.08            +0.0        1.10        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.43            +0.0        1.46        perf-profile.self.cycles-pp.testcase
      2.39            +0.0        2.43        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.55            +0.0        1.59        perf-profile.self.cycles-pp.eventfd_read
      0.96            +0.1        1.01        perf-profile.self.cycles-pp.rw_verify_area
      1.48            +0.1        1.54        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      1.85            +0.1        1.91        perf-profile.self.cycles-pp.do_syscall_64
      2.16            +0.1        2.23        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.13            +0.1        2.20        perf-profile.self.cycles-pp.x64_sys_call
      3.22            +0.1        3.34        perf-profile.self.cycles-pp.fdget_pos
      4.48            +0.1        4.62        perf-profile.self.cycles-pp._raw_spin_lock_irq
      7.71            +0.2        7.90        perf-profile.self.cycles-pp.write
      7.94            +0.2        8.18        perf-profile.self.cycles-pp.read
      6.12            +0.3        6.38        perf-profile.self.cycles-pp.vfs_read
      9.38            +0.3        9.72        perf-profile.self.cycles-pp._copy_to_iter
     10.36            +0.4       10.72        perf-profile.self.cycles-pp.entry_SYSCALL_64
     17.54            +0.4       17.95        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


