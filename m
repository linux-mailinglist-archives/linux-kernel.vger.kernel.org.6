Return-Path: <linux-kernel+bounces-289360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC1954548
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF16B24870
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649F513D504;
	Fri, 16 Aug 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FznKrbxg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC657CB4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799740; cv=fail; b=k9l8TLlnQb1g5wUSBOM5+MoI3tGmGuBz7i8wltLNGbhEmwp1ZmeYP7h7xg0T9OBbWEP0G0X6sIAzRCf8V6PeCKyHF2UgZEw9zQHwAU7VmQXSxX5egl/nOxsDV271XI1zxTwAfBKGMsZ55sZejZFf1CB9PNyYtqf/28raPlpQYcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799740; c=relaxed/simple;
	bh=GfkJZu947UxADewb1zNhJJVTzmMnQ7qHfL45MApLMVw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=o1F06tPZ267+wwMfoAJGz1kEprLAP9R75o3R0b+GOt70C+1s8uIFvTSmreakD48WgkPSZVEIyV3pNPt9d7a/NtDHbPpYS2jGibjK59zqj0gTpxrWsetsrh32SNhYBy3iodd1ZNfXF+vpQ4ThPiEdvexWjwdklFMU3ur862lvr0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FznKrbxg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723799737; x=1755335737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GfkJZu947UxADewb1zNhJJVTzmMnQ7qHfL45MApLMVw=;
  b=FznKrbxgTYurRqJK6o4dyyDIPH7E1XVvNfcwl7nEVScNLLzxbFUu/iDM
   /Uh7T66DrJiC4VMXe7rC88K7cMzQxxQYwNqjiSyWqV16KSrDgl5BWSJzV
   /qBzTtB0XL1wHfib6J2jbtrFjSP+PWgiwKaamYLeETzV2wak+HCH++G4Q
   CIhuJqhfa55zRstb4INOdFMvq5hKtXbOuVhZSybYBcWyW6VBZVfCx1Tq+
   bWGrCxdAREX+9tVqXyGO5PBWrPN1y+3cIDmyTKYo00y8qM+ANdOp8/g/g
   xnr0ccz/R1hM3z33eMyAMiJuCCmYgscdhhONG1U9fTJ4RUifXHlhsdxj0
   w==;
X-CSE-ConnectionGUID: 0b3TXyISQh+QyochEWXvmg==
X-CSE-MsgGUID: Otxd6evXS+6b6MfobDPe3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22249285"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22249285"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 02:15:36 -0700
X-CSE-ConnectionGUID: 4vHkUXcRQvKsxU1TiSHfAA==
X-CSE-MsgGUID: Y1ovWHdyQKSraeQC3OPMQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59256356"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 02:15:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:15:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 02:15:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 02:15:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 02:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+J9EHZs5xb8Y+ivhy1nUNRoNaw/DE1MsF4H45mWtlDwZ15Cg/xUeyZzbpK4dS9+gn9BG6o7icF+mOMQLGRwVmMbR8vTG/yHDA7/Z6CeM3sW4lGgLhXbph7NNL8cKIphj5vx/GOIwC1raJenj9+LEn7VIGOcLq+5D8tjC+1j5kc/Ku54JB+XOhM5nnY2A/5JiBwKwPNnFT2KeXonTlmucgd37xHU5tbXk+hIxrZyjuAG/YedWYOjOL6xkQeJRsXjtOI6xmJhDHFHM3biNQFRIgh4JEwZfQugMKcsbtmkAr88n3pxAehlWnMHP2ENI+PkAvRYGLtzO/w1B6R/FkVq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Tg63FMxntI8lfY7/n/f9bP7M+nUJq+xWCPEwcSga6Y=;
 b=isjoFlDgY5TEJCsOELs62t1foLbXwpNL83pCYRtxGRf8aYeUQBluG87OqXEnae/S3nBioZye+TSLiSAXhyerhtAufQSo43+XtoKe6pSh3Jhy6qEJLp9K5Lx1mneMhdQPEvuF6TAont/4IJAVSc1/JqgOO+tWZWqESAD6E3xDwTQmYSN9ws1Lf4VYs3JNBDe8MX0+uhuyFHgl7kekySkb87bLyP9ZWtt1BOwthIIeLr9cSIvX/yLC+/PZZpt5cZyYqYO9HAuq5yf2zYlg4o0yo2ZCv9InUTv/IR0h3yaof2OdCO1rjXydd0JEwUVOxCEY3SNZPJXqt25IT6mOVd5wnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:15:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 09:15:22 +0000
Date: Fri, 16 Aug 2024 17:15:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [peterz-queue:sched/core] [sched/fair]  420356c350:
 WARNING:at_kernel/sched/core.c:#__might_sleep
Message-ID: <202408161619.9ed8b83e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: e45ae7c8-2504-4c8f-a606-08dcbdd3f495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/tHIER4Weg5sv5XYZA5WdXJn8QNqozljBX6W4h/ZhX5af4U4ml09khMpg9G?=
 =?us-ascii?Q?gAkNin27D0ct4bVMcFLYjweP2l67Ai/PckKZwTIRuDPk0vwqX0FtNTSWrzgx?=
 =?us-ascii?Q?HZlh/k6bWr0uJU1ZVbDmhGMSW3rE6/nXg3Un0k8GU2J9MkuiW91w3EtmH7eW?=
 =?us-ascii?Q?/gCIjgThcNKWHYJ+NUf5rWkx/ZdhJzqb45l1fK2Xzbse5Nx5jSX7g6aqIKjc?=
 =?us-ascii?Q?oYFH5aqVF4UWrFRDf2tE8+Nz++z++hdU+jR5prEYYWJB7Rt1xjuFZXgXhbPX?=
 =?us-ascii?Q?MRY5NszxZygpvYV0qgWvEeGfTgi5b3rKlYbrgKYpgWkgTgqWTeuRfUQ4pEBu?=
 =?us-ascii?Q?8z113eLQDsT+Vy0jdiKhMloFgbr1a8nBvNIJzltP+1sKpaD3eU937hMhBzPT?=
 =?us-ascii?Q?0R+jnH1jIFhaY28OrQIsTwtjCygOLuFelBkU13Y4o/ar3fQ3SeaSKCTNvZNq?=
 =?us-ascii?Q?OhT/7WPYiUaDDk0nMOjni72jaCIaEwyt+kLE/KSwLk8E5mpzTq8fd0fiZQIk?=
 =?us-ascii?Q?cAWkJ3cTTm0ygXkFfstn1SoEb9kbmDHrBpUREbm5gYsnYCuOn3RFSZv2L4c0?=
 =?us-ascii?Q?KtUKzynf2L55npC7HG/SKRuvZnt6HKX+4Uvk4GDYNdELAmYSkdIt7pNQmxgx?=
 =?us-ascii?Q?/+FyCdcRuowWIJnsEWZebAtn1ob3dlT3g5mtrv9tVDemARhCjenHeqw6VzWC?=
 =?us-ascii?Q?cdUhu2+GxFF9eN1efbhHLN6QlDlfRWgJIXpsDDluXj0XmF/nD5+eHyro4tTf?=
 =?us-ascii?Q?rf9ScLppg8fY3yvfvTxYbEvedpvjrGylluy2lBDbZibm5AZko8Bijd9eCuKA?=
 =?us-ascii?Q?Ax7oEHebeTFgOPv17sRHrlxIi8wXzNxrmy9SvCK8KIAAp+9xp2cit0ai4ymO?=
 =?us-ascii?Q?xzNkpZUcPqIXO6WcXY52rpWoggWDd0Y3r7Y+B3oWsLFcG8es0xgtT+opPgsn?=
 =?us-ascii?Q?aTEFqSajq/H02Fi/NtB7ZclkAlkdnm2X+vox9wWctGppBDPE/LPBmwPfbIDN?=
 =?us-ascii?Q?PXlkocwGU2VWxDCBctdvrA81yAiJ3O/Ds8tiryxmiTZLWz8fYu/8zNPYtL+f?=
 =?us-ascii?Q?aI+NJwElluaiPNFjt6x2BQrwgv92dlZ4bUQhLfIZIFxXKCeFB74gqIlpLRFC?=
 =?us-ascii?Q?ZUmC8LZWjwpUoeXWasH84lh95xM1FjJXbLhGMghixaTr5vAV3el5rf/t4Tqw?=
 =?us-ascii?Q?vZnvg8F1BlfeeAJmSnHg/Jc7pgFBd+ZKCT5DNha8ekgu5AYgwpBR6lujG56P?=
 =?us-ascii?Q?TKKkTuYWgDHpXmF/8b4pQawwzK8VAs3HAGsdS66HG8FRkA8Hcp8pf0WO/+S0?=
 =?us-ascii?Q?s5M/AnBm/z+sho5W+CBn1MM7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9ozZ6KKZtjjIa/furvkVAL0EXoG0/JoyNBD3gVYvAorpxws2GQBJMGjfYPZ?=
 =?us-ascii?Q?IEv/3plUTS6rgwRUOdWgoQl/cHRP3SziP8NZzfvQV2f1/Iku5x6McDrOn6BB?=
 =?us-ascii?Q?4xFt0Ce7OMcacNJVx2RvbaGNm6+3Gpv439rZ7bVOFUYZte/SgVuDcKFQ2dd6?=
 =?us-ascii?Q?RJbvQ57s6ED/OkV9WwEHLVwBvZc17U/gdZ4pRrt3S9Sj11BEIrQplGoKVGGj?=
 =?us-ascii?Q?wkzEYQTJ3y4BwjRjjk6Vpm/Vc+CoSzYCDv3ORXZ6tjeTc31rnU/9oxwTdbP3?=
 =?us-ascii?Q?NNiXKE9vdEjvdCzTS6irMH3bnHR0s36IiTH3NTbtCaxp1hzy5jEq56nW00G6?=
 =?us-ascii?Q?hjQ3461NYf8ijr8hrQNrD3C/Cd5llbxfSNcRTcipmD+0bnak+u1GanBSMgfh?=
 =?us-ascii?Q?leVB/UNiEIk8sDZskAfVtU8A93czIPHGWdOXCfA6umHKJKvfCK1gA/TlOKnm?=
 =?us-ascii?Q?PAIuG9ws9D8j+hzzlbv0r75KZ7z5Dx+Xvy3B5ZN50lvLRYZTulNwOfEwXTId?=
 =?us-ascii?Q?sviRQA6EOsl3HjIzzy/QGzCFYNoAMyPvHW+XsG5GXcHaBrH03vvocM2CnZRr?=
 =?us-ascii?Q?ZTI3K09ooffpsJeD2jc0934RQoyyxfEc1KIxPS89ECPZqz6fA/ejoiKX05qj?=
 =?us-ascii?Q?PBSVPWMsLq7F0xQHRSnGpgfEded0fluLz5tuX/7WfxPXKx67yXlhw+68ABzF?=
 =?us-ascii?Q?nAWI3F+uH4SG/Dns5XCinkF+twRnz1BHJ1RY1//3O4xfC385XZpkHl7xXKVN?=
 =?us-ascii?Q?i/UOpqDmcp/iedH3bdtg92eheYWJWGV0eWatiYk5HW7bTcbOF5jrg08GDiPr?=
 =?us-ascii?Q?0v7eteE7gqxzCM8Qpkq//3XaimRDU/xDhNAmKQ/ej5fH0vC3chw/KZAbXQ/i?=
 =?us-ascii?Q?teBSRP/QNO7rOXs5C1qUXcQZU0DxkPKqo73C7PP+A04pQzTcdnK8c+snKbup?=
 =?us-ascii?Q?fUinqF0uyR0F1l/vQDuJQbBba0F9SaYsAeddxDJj/uLIIiF6KquTZM4v1kto?=
 =?us-ascii?Q?wRNmCQ8Y2YXIU0rM7+2FbNbBcCw2fESA4Z/zQy+T5j+Mg0NOpjzPER4+5oqn?=
 =?us-ascii?Q?TbIMDWLwVHNgwgTc5rPewtM8mf0Mz8KiQmOkIMI5fbS+PFyXGmc2eiqq2+WX?=
 =?us-ascii?Q?uaz/agI2L0uJWB/R+KQy+1j5mIbE/B17ztABlumDLXRSzyRlyaMzfh+PCNk+?=
 =?us-ascii?Q?R7DUfVHW335YlZxxS+k6vZIWIdKux54e++zCrZr9ieSLICo5FZmKeeicQ2Jz?=
 =?us-ascii?Q?EXNjdWDl96lJ0/j3k4NyFmdvW3jqiWjKAMQdsdJjlYJrpNMTLjNmo0mnmTMU?=
 =?us-ascii?Q?sjTdcOtX93WypcT0ece/TbOj9Lbjc0ORJkDwNMZmYKpZBLjLw0EcWGyoqSw6?=
 =?us-ascii?Q?xL6m+Gm49fULS3LjyWsOrpVTJys4tKp+M9m9/WO38KfPN5ulujbgn/1ksTmN?=
 =?us-ascii?Q?Z7zplNHDV+vI8Qc2GSXuRJGa2PmmJRIsZDXLmDCNWM4DJJy+yt8yDmveCyJj?=
 =?us-ascii?Q?3+fbMXGLomv834X4fECCuT9sQbpyxXB6T/wZRXPq28/XY92QmYlQfx11PNW1?=
 =?us-ascii?Q?Z1g0TRYRp5lVQG5czIc4dQcAlWu7rCPUS/9nnwwqGByyLXmSj1kyxwYczpvx?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e45ae7c8-2504-4c8f-a606-08dcbdd3f495
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:15:22.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq6XiIwijnaXLm1SVCFnAd7nwYPzaVIOf2AFfcp8zg2JUTtHKvXJvnInK9LYSDISDOCL6yVFnkbF7FEEDpQ0kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/sched/core.c:#__might_sleep" on:

commit: 420356c3504091f0f6021974389df7c58f365dad ("sched/fair: Implement delayed dequeue")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/core

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks-rude



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------+------------+------------+
|                                                                         | 18fdefe603 | 420356c350 |
+-------------------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/sched/core.c:#__might_sleep                           | 0          | 18         |
| RIP:__might_sleep                                                       | 0          | 18         |
+-------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408161619.9ed8b83e-lkp@intel.com


[   86.252370][  T674] ------------[ cut here ]------------
[ 86.252945][ T674] do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?) 
[ 86.254001][ T674] WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep (kernel/sched/core.c:8465) 
[   86.255224][  T674] Modules linked in: rcutorture torture crct10dif_pclmul crc32c_intel polyval_clmulni polyval_generic tiny_power_button sha256_ssse3 rtc_cmos sha1_ssse3 button aesni_intel evdev ipmi_devintf ipmi_msghandler drm fuse loop efi_pstore drm_panel_orientation_quirks pstore qemu_fw_cfg ip_tables x_tables autofs4
[   86.260658][  T674] CPU: 1 UID: 0 PID: 674 Comm: erofs_worker/1 Tainted: G                T  6.11.0-rc1-00042-g420356c35040 #1 f37f1ad66c1ebf3b07abcf4fc3040d14b7156f8a
[   86.262530][  T674] Tainted: [T]=RANDSTRUCT
[   86.263000][  T674] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 86.264783][ T674] RIP: 0010:__might_sleep (kernel/sched/core.c:8465) 
[ 86.265305][ T674] Code: 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 e6 50 62 00 49 8b 0f 48 c7 c7 e0 b0 ee 84 44 89 e6 48 89 ca e8 c1 0e f5 ff <0f> 0b 48 c7 c7 b0 01 8c 86 be 01 00 00 00 31 d2 b9 01 00 00 00 eb
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	fc                   	cld
   5:	ff                   	(bad)
   6:	df 80 3c 08 00 74    	filds  0x7400083c(%rax)
   c:	08 4c 89 ff          	or     %cl,-0x1(%rcx,%rcx,4)
  10:	e8 e6 50 62 00       	call   0x6250fb
  15:	49 8b 0f             	mov    (%r15),%rcx
  18:	48 c7 c7 e0 b0 ee 84 	mov    $0xffffffff84eeb0e0,%rdi
  1f:	44 89 e6             	mov    %r12d,%esi
  22:	48 89 ca             	mov    %rcx,%rdx
  25:	e8 c1 0e f5 ff       	call   0xfffffffffff50eeb
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c7 b0 01 8c 86 	mov    $0xffffffff868c01b0,%rdi
  33:	be 01 00 00 00       	mov    $0x1,%esi
  38:	31 d2                	xor    %edx,%edx
  3a:	b9 01 00 00 00       	mov    $0x1,%ecx
  3f:	eb                   	.byte 0xeb

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 c7 c7 b0 01 8c 86 	mov    $0xffffffff868c01b0,%rdi
   9:	be 01 00 00 00       	mov    $0x1,%esi
   e:	31 d2                	xor    %edx,%edx
  10:	b9 01 00 00 00       	mov    $0x1,%ecx
  15:	eb                   	.byte 0xeb
[   86.266970][  T674] RSP: 0000:ffffc90000f1fdb8 EFLAGS: 00010246
[   86.267710][  T674] RAX: 93ef2e1fd3a87a00 RBX: 0000000000000001 RCX: 0000000000000000
[   86.268961][  T674] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffffffff868af248
[   86.269995][  T674] RBP: ffffc90000f1fdf0 R08: ffffc90000f1fbf7 R09: 1ffff920001e3f7e
[   86.270937][  T674] R10: dffffc0000000000 R11: fffff520001e3f7f R12: 0000000000000001
[   86.272231][  T674] R13: 0000000000000001 R14: 0000000000000001 R15: ffff88817b340080
[   86.273485][  T674] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000) knlGS:0000000000000000
[   86.274487][  T674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   86.275275][  T674] CR2: 0000000000000000 CR3: 0000000005815000 CR4: 00000000000406f0
[   86.276454][  T674] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   86.277565][  T674] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   86.278443][  T674] Call Trace:
[   86.279070][  T674]  <TASK>
[ 86.279553][ T674] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 86.279942][ T674] ? __warn (kernel/panic.c:735) 
[ 86.280703][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
[ 86.281360][ T674] ? report_bug (lib/bug.c:?) 
[ 86.282183][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
[   86.282816][  T674]  ? __wake_up_klogd
[ 86.283398][ T674] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 86.283995][ T674] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 86.284787][ T674] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 86.285682][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
[ 86.286380][ T674] ? __might_sleep (kernel/sched/core.c:8465) 
[ 86.287116][ T674] kthread_worker_fn (include/linux/kernel.h:73 include/linux/freezer.h:53 kernel/kthread.c:851) 
[ 86.287701][ T674] ? kthread_worker_fn (kernel/kthread.c:?) 
[ 86.288138][ T674] kthread (kernel/kthread.c:391) 
[ 86.288482][ T674] ? __cfi_kthread_worker_fn (kernel/kthread.c:803) 
[ 86.288951][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
[ 86.289560][ T674] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 86.290162][ T674] ? __cfi_kthread (kernel/kthread.c:342) 
[ 86.291465][ T674] ret_from_fork_asm (arch/x86/entry/entry_64.S:254) 
[   86.292080][  T674]  </TASK>
[   86.292468][  T674] irq event stamp: 579
[ 86.292872][ T674] hardirqs last enabled at (589): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 kernel/printk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 86.293852][ T674] hardirqs last disabled at (598): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 86.294901][ T674] softirqs last enabled at (0): copy_process (include/linux/rcupdate.h:326 include/linux/rcupdate.h:838 kernel/fork.c:2243) 
[ 86.296048][ T674] softirqs last disabled at (0): 0x0 
[   86.296931][  T674] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240816/202408161619.9ed8b83e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


