Return-Path: <linux-kernel+bounces-209303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA44903241
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6995B2707C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B82171662;
	Tue, 11 Jun 2024 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fI7sLtkg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1D171656
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086188; cv=fail; b=Rc2gvOp1z1J80ezAbZAOMpRqPHeMcnwD7ZtKWaOZWUrd82oJACOHvZt18yw5ebyoBgsDmWhqi5+MlpKslrDU2rn0efIk7/Ygn7gs9EMEqH3WmUwL8JkC0nfuK+9VJiDCC0ibF4Gjc8n1lCv8eWs1J/keHt83wItQ0Z22+SJq0vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086188; c=relaxed/simple;
	bh=GEk6Cm+S2xfaO2fkMpXwDLhLbivD98iBHmjcf4riKqA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lShcPv9HOb9HeDCnTE87jbYnlFSjioaVoKV93qaSP4LM1YGG1gsmt9W9ZKdY7IOQpSNX8+f8KHpqqkNaMt2BbHt+Dh/m3hSknVvFZKM8zCMPGaYSAFTN4kTfGn/lHNlxFCxO9oP/b4SiYRHnfAeDdDxAtthuXDji/bR1KEY8vpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fI7sLtkg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718086186; x=1749622186;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GEk6Cm+S2xfaO2fkMpXwDLhLbivD98iBHmjcf4riKqA=;
  b=fI7sLtkgWIL51HCSSyfYiyAqqe1Z3jsFWLuxzB0D0GKT8vp6YTtxoWc1
   /ApVa+qh8oZv3AXpnpXqRhS4ld2sYBaLwcCc7r5JRpJnL/5K3OdPeZfpQ
   mNQKEEyd+EyV+1lWt9GOAt70Yn7x1av2F8DAkASNRWH1WjZJrAtMGPPgJ
   zakIz1hN8GRALFmy0yp2WhorQcb7utlmXXQN1LPtkZEIhpvOiIJKJ+lRC
   lAVIRgF+3L4+DPMK/av5mtXDIRGhVzWeVqc1s3XV/OZXvOtXD+hxjrkIa
   rkjL9r05TXffhL0jYySQCyARuBapfnhr9T9+JhHjEgGeSyr9dJzEecCbY
   A==;
X-CSE-ConnectionGUID: pYoL4916Q1mbtGx6mXYfVw==
X-CSE-MsgGUID: vD3IAHtKQPuDomRxmbcN4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25354866"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="25354866"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:09:45 -0700
X-CSE-ConnectionGUID: aYmfK1EqQC27SweLcwCVQA==
X-CSE-MsgGUID: 3NyuLsi5Q8eX5uTxf29NHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39887155"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 23:09:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 23:09:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 23:09:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 23:09:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 23:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhQEr8bvHl+WjV5cFYJgm1wwbDbyk7tTEhPXthM+9GexfJo79XtCbTHZM3lI11T70DYa93SGLC16mUvq/ZMbyaG5UqsvGX2En92pgt+ikTxUGCUbgNBnl1ZGMcZ96VK6J1dfTSRUg1aPdY1P05lC/sdUBut3rVYkxmHxhPWa0yM4ThAATK9borJroOaXq+jYyuB7GK6n2az6jsBj91lrpevBXHO0kwDZ7bG7f5NciUy86PyLT2EVKde+KcTQ1QNiZL6TAaHwjInZf5nVEhE1DQAKMb4oyDBb+oAFPCbQVexGyhJA9G4txxPpH36K2Hus5zWboFPyRmFbkywDJjDfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uf5EPLBK34TJG7qFAjUkiJCkD8i9I0oeoYW3s0ATc+Y=;
 b=ms2wGgGfojQdxE2MIesCyVP97Iz8u4snf5krRatajaj1UDtnigXKsRFHThV6Fx5KfFVwjmyEeLixbZxR3Wrf3ZkVPxGHNyajFB9/akcqvGlRuOQolAacURWSVh30UKnxQ77aCt+rmVsylfYceJ7DjZ2cGXIP1TDLIVuvbg/Q643WjyEz+kARXNKWEAN8RbjOof4uQRw1vLjo3hV0ogeySrLgdvL3uOsfIZWJR0BIsY/v/ruwaGotHSbvp97Px/iyGZxVFI0LFYJmk03Jl/z2+PNhI31jH3YZHr1GEtOBv+9igXJ/kgZoo1y2ZIoudd1tDOBUIZcXlOlmPkUPSOdWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:09:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 06:09:36 +0000
Date: Tue, 11 Jun 2024 14:09:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski
	<luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Fenghua Yu
	<fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
	<oliver.sang@intel.com>
Subject: [tip:WIP.x86/fpu] [x86/fpu]  052ffa1364:
 WARNING:at_arch/x86/mm/extable.c:#fixup_exception
Message-ID: <202406111352.84c1bcbe-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: cb73974d-713f-4d13-ff17-08dc89dd11b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9rojuO0VRedanhRHuM1CZ2kcn3Xd+UKjPzY4Lm5NUr7Brc/va4QEvC1SsAzK?=
 =?us-ascii?Q?jUAz0HQ3F6Zr/WQi8raLmPA72I+q5YffZ/pczuI7VTOIQ6CpwhgllNypZQ0z?=
 =?us-ascii?Q?LNHRmUyI8o/pW7U64yvOUpVl5/h4BHUBRi5iWn2bGDGUAzfabTOc7JtN4pTp?=
 =?us-ascii?Q?9lUkwC4ZJIASqAs7hanvMQWXWFa+GRMzKgCxPILP1ricNg361oveb4AkBB5z?=
 =?us-ascii?Q?1Jumx9gWfexnTeFipKLBRSF7lrHlvz91jLXonU6tV+9PeyyIyMiCAByhd8el?=
 =?us-ascii?Q?j3B7kDZzAynp90pz9a8Y+hEvAkQd0YMq2XTjGjNvDCu7KxXrb6fpjFkaZcRt?=
 =?us-ascii?Q?n1fY+XIFio2P+jhf2Nr9072NgZ3ZdaGZW156WZ2bNNjnb93I4bcMAp9Ta7In?=
 =?us-ascii?Q?m0CkqkfGJoWZON4qag2c+mOYJK+8CvhVJ+PByPASPIOqkAhF8CmwqUgSAgKi?=
 =?us-ascii?Q?ApQJDvueVANAlwPl9ra19xUEY/tcYTgMbUL/Ruhbt9ygb8XwY2Gocm4Aut1o?=
 =?us-ascii?Q?NdPGh5MKagWiC6NKX9WJQqKjX7zjbaDOKzfDfx7c+VfC7GIc9a+ey6+tEyhv?=
 =?us-ascii?Q?mTNOhE3Drz11rN6pGLDc8JW5C0Wia7De4MWDau8E/QxtzvCXrvjlbLzXFTN+?=
 =?us-ascii?Q?AI5P0Oly4atWLoI5LXj7tVF/CDDbNzJTc/SrncGMvpkOE0P8+0Fujdm5sh/J?=
 =?us-ascii?Q?uMfBF+sYpBlsfQcwsnfy0fEH3gKuQP6lJZ2FFmsErj/mxlluKrPF5rIKNCdJ?=
 =?us-ascii?Q?etRsvgo2WKomAYAFi8ebUHuvan0h2SlCEHAS3WtEKReUnXMAwdeKOu2vc26I?=
 =?us-ascii?Q?yNAqzg3tCo9xcFWeGEiPtpezcDkYDb4EPA6dpuvfgUq1ZG6mzpXKONo4aHZ4?=
 =?us-ascii?Q?bO29iXMKzWUtqEiY5BIX/3Q5HFi46gxrfVDpg7oMQgSPHkKxVWbPkNryYeeM?=
 =?us-ascii?Q?PXZ4rooqdcuIL49V7nl9InTMgw8nk20fm8RezK2wmEhjTpZY1EkVf0BrXyUr?=
 =?us-ascii?Q?RrAT7/nDr+chhIhgHUWAi6A8bNYzS8Oimr0EyxNtRKXssRqK78MpysmUH1G5?=
 =?us-ascii?Q?9bs8W4TmAP1Tlsr2XscArk1RCy5/jWkdmWhxDZ6bUpfvvQzaVdw1rVwl8KIe?=
 =?us-ascii?Q?4A8xN4YTrm6ogRkLVTmX7jyjjplcw0SdPip22YB6pBEfg8PxdrvruP6mlDrJ?=
 =?us-ascii?Q?aTCcZlpShxFvP5uAM31RLBk6xgUuiWYRFlgWAiSdY3RPIQQE0VhTIbhEhVb8?=
 =?us-ascii?Q?XdvFQEEQd8aOYZFEbSbtUt8i4kqHOIYagS/TkTxadg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6dFZU7eZOMrvkJ1ZWYlGiVNA9Hzop7K/CtaICPrK2mifs5muyKzzIp0EsEpJ?=
 =?us-ascii?Q?ogn5BG9tSrlLhtIpwsVbXggT4CvxuOiauAKJgGD4vSEpKyX5ic5F+2N5KgvI?=
 =?us-ascii?Q?klPWCYqKedZUQoDigrWE25XXNeFmuouRVLDVocYg/Mq7a2MqdWEyjciVhOfE?=
 =?us-ascii?Q?AIUrt4fgjTH0M6DWcelhSBQrttgNKK1yYcEGT5difSAQz6pInEpcVNF0Gbk1?=
 =?us-ascii?Q?FFLUV/4AJV6YCEAmX3/e7fU4je+IWn5BqJvaAcOUgo3B7bU5R0fg+oRR/KKm?=
 =?us-ascii?Q?GSG3Q7Q1fr2qUzEei4pFt9Litb2ICUwu0EdDsd6aA77Y1SxLusAWue3lUys2?=
 =?us-ascii?Q?oKnt7Ub2WAH7BvJ/FAuh8CiV/0e7MxlnYnK5tP6/4Ra4lKdKiPTWUytaXf9B?=
 =?us-ascii?Q?ZqDWx2inGOM1sNwpnAVbF7KnF9o1bYX2uTu7PzY1xBTvwgzY0fp5iEFYyqT8?=
 =?us-ascii?Q?wBUYMzWjYFmnowQsjgiGCyrSfxtQ/xOuSB564vCQIAQSXCyNRyOLcjhlFtKC?=
 =?us-ascii?Q?Yf0neL7EhKgNSeX7ADFMd8bi1F4j7wjugmYTQwRZTp8h8ZTf+aZtH9KOwrQV?=
 =?us-ascii?Q?zeMb5P5EoTLrPjeEk1UlvyenCKG8lnSu3YAAsYlbOTUkrV77XHvguAjQJvbW?=
 =?us-ascii?Q?9PAzlSzeNbk0WBU8e58tBhG1GtaEWkLhBF0FezB8nwl8C9H48bvlW+PxX4Nx?=
 =?us-ascii?Q?dPD/wbC+fqKrjrV3A8K8PsxVMxc3RkuCS/o/8EPZ2aMUjkJA50aGsBGAFmah?=
 =?us-ascii?Q?5SE6XM0piMeVJ+2d3d42YKRDC7COoSJUPVVEP4ZTx0zJYoDYsdLkyE2erwiE?=
 =?us-ascii?Q?UgOqdIK39xBl/HhauDN1es4ou4nnzjsWU9kusMFJNM2peYamgLksRQdnHs58?=
 =?us-ascii?Q?kXikSdS5eI63YikMivLPh5Ps1Z3iDmDH8YKsgbhmOFju0TkajmplKLsmhWiM?=
 =?us-ascii?Q?09m/VcpYbrk0VmUbtaL/2Zj+aYDfNO7uZm00wnuKyY6yxAkmRhS9XFGufrYt?=
 =?us-ascii?Q?+o0z94G275smh8yVJz4vIT8fY+H6p+RKUfQ22zLR296Soza3E20H83mxCZ98?=
 =?us-ascii?Q?5y4Wb/Zbzcj6U7DOf6cB41w2DrmsH/5AqbdRIiG1D/0b+dANjbjqv6iVR2lV?=
 =?us-ascii?Q?XwjDhs9m2GPRX+uMa4Bu3WWrg4uEtgVpIwJIOdPFX/dfcpLQXVdgTImfkshN?=
 =?us-ascii?Q?7y4tky1wMTSXq5ZY0sKFZHV9+rOROJlGN/UvdgJIHrqY3no1l/m/t+yrFxU0?=
 =?us-ascii?Q?QpPAQ0Aet0Pk2OUBPbJefx7SsgZWo6GX56hTW7NKFDWDreHNpS4SX93Ticpq?=
 =?us-ascii?Q?RoLkmhjSg+FAMo9NZnBtDTTDtfpSNEWiY+J+PgLn2AoRzDX33vyg3dqe+0r/?=
 =?us-ascii?Q?VfgnPekY1rX04PseJi9sAb2zAidVlZsYF9dfxTrD9jzsxOacTYdD0U/Qrmns?=
 =?us-ascii?Q?SFCBDAsKKjCunEydLJyN7JSiqhYM4ULQ3qmJEa32PznSdn4PTW/zBe7BARog?=
 =?us-ascii?Q?lUb7BHqjo3wrBZD0/k+rYfs9+yQZIH7mWsHrOVvNw9ze1Awrkr0fdbhnqASY?=
 =?us-ascii?Q?+Emo++AN/hnHI6Ej7U6oZkS2WoloKJqh3HPDZnrUR3963qXxOKBfbN8MUhn/?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb73974d-713f-4d13-ff17-08dc89dd11b9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 06:09:36.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeKrx6Uqoj2j/8o5hWotQIIUxOOmb5wIggstmYR8weIGtZa8qECBhGi2NXdMutwXKRzA0yyd+mrAlLLGWQNjmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_arch/x86/mm/extable.c:#fixup_exception" on:

commit: 052ffa1364f57555fad862dc2094091b7cec9b93 ("x86/fpu: Remove the thread::fpu pointer")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.x86/fpu

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


as below table, both 052ffa1364 and its parent have same issue such like
kernel_BUG_at_mm/usercopy.c
Oops:invalid_opcode:#[##]PREEMPT_SMP
EIP:usercopy_abort
Kernel_panic-not_syncing:Fatal_exception

but this commit introduces WARNING:at_arch/x86/mm/extable.c:#fixup_exception

+---------------------------------------------------+------------+------------+
|                                                   | 4f4a9b3993 | 052ffa1364 |
+---------------------------------------------------+------------+------------+
| boot_failures                                     | 6          | 6          |
| kernel_BUG_at_mm/usercopy.c                       | 6          | 6          |
| Oops:invalid_opcode:#[##]PREEMPT_SMP              | 6          | 6          |
| EIP:usercopy_abort                                | 6          | 6          |
| Kernel_panic-not_syncing:Fatal_exception          | 6          | 6          |
| WARNING:at_arch/x86/mm/extable.c:#fixup_exception | 0          | 6          |
| EIP:fixup_exception                               | 0          | 6          |
| EIP:restore_fpregs_from_fpstate                   | 0          | 6          |
+---------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406111352.84c1bcbe-oliver.sang@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240611/202406111352.84c1bcbe-oliver.sang@intel.com


[    3.372028][   T64] ------------[ cut here ]------------
[    3.372802][   T64] Bad FPU state detected at restore_fpregs_from_fpstate+0x38/0x70, reinitializing FPU registers.
[    3.372818][   T64] WARNING: CPU: 0 PID: 64 at arch/x86/mm/extable.c:127 fixup_exception+0x405/0x41c
[    3.375482][   T64] Modules linked in:
[    3.376062][   T64] CPU: 0 PID: 64 Comm: modprobe Not tainted 6.10.0-rc2-00004-g052ffa1364f5 #1
[    3.377299][   T64] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    3.378863][   T64] EIP: fixup_exception+0x405/0x41c
[    3.379541][   T64] Code: c2 e9 a2 fd ff ff 0f 0b ba 48 c9 fa c2 e9 e7 fd ff ff 89 44 24 04 b2 01 c7 04 24 98 a3 77 c2 88 15 f8 7c e2 c2 e8 0f 2d 01 00 <0f> 0b eb 9a 0f 0b b8 94 e4 97 c2 e8 17 97 6e 00 cc cc cc cc cc cc
[    3.382186][   T64] EAX: 0000005e EBX: c28cd540 ECX: 00000234 EDX: c2cad1a4
[    3.383617][   T64] ESI: ed6cdee4 EDI: 0000000d EBP: ed6cde50 ESP: ed6cddd4
[    3.384683][   T64] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010086
[    3.385916][   T64] CR0: 80050033 CR2: bf9717ab CR3: 2d6ad000 CR4: 00040690
[    3.387245][   T64] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    3.388306][   T64] DR6: fffe0ff0 DR7: 00000400
[    3.389074][   T64] Call Trace:
[    3.389688][   T64]  ? show_regs+0x72/0x7c
[    3.390293][   T64]  ? fixup_exception+0x405/0x41c
[    3.390961][   T64]  ? __warn+0x88/0x1a0
[    3.391576][   T64]  ? fixup_exception+0x405/0x41c
[    3.392323][   T64]  ? fixup_exception+0x405/0x41c
[    3.393045][   T64]  ? report_bug+0x182/0x1ac
[    3.393759][   T64]  ? exc_overflow+0x50/0x50
[    3.394377][   T64]  ? handle_bug+0x2d/0x50
[    3.394969][   T64]  ? exc_invalid_op+0x28/0x7c
[    3.395643][   T64]  ? console_unlock+0x64/0x110
[    3.396286][   T64]  ? handle_exception+0x150/0x150
[    3.396987][   T64]  ? print_lock_class_header+0x157/0x180
[    3.397979][   T64]  ? follow_phys+0x140/0x140
[    3.398745][   T64]  ? exc_overflow+0x50/0x50
[    3.399484][   T64]  ? fixup_exception+0x405/0x41c
[    3.400220][   T64]  ? follow_phys+0x140/0x140
[    3.400898][   T64]  ? exc_overflow+0x50/0x50
[    3.401667][   T64]  ? fixup_exception+0x405/0x41c
[    3.402424][   T64]  ? restore_fpregs_from_fpstate+0x38/0x70
[    3.403336][   T64]  ? 0xc1000000
[    3.403946][   T64]  ? lock_acquire+0x241/0x284
[    3.404711][   T64]  ? should_fail+0xa/0xc
[    3.405464][   T64]  ? _copy_to_user+0x4b/0x68
[    3.406171][   T64]  ? create_elf_tables+0x667/0x6b8
[    3.406961][   T64]  ? lock_release+0xe1/0x124
[    3.407656][   T64]  ? exc_bounds+0xd4/0xd4
[    3.408280][   T64]  exc_general_protection+0x13d/0x2f0
[    3.409135][   T64]  ? finalize_exec+0x50/0x60
[    3.409929][   T64]  ? exc_bounds+0xd4/0xd4
[    3.410629][   T64]  handle_exception+0x150/0x150
[    3.411416][   T64] EIP: restore_fpregs_from_fpstate+0x38/0x70
[    3.412303][   T64] Code: 7d fc 89 ca eb 09 cc cc cc db e2 0f 77 db 03 3e 8d 74 26 00 8b 3d ec a1 84 c2 8b 0d e8 a1 84 c2 21 fa 8d 7b 40 21 c8 0f ae 2f <8b> 5d f8 8b 7d fc 89 ec 5d c3 8d b6 00 00 00 00 3e 8d 74 26 00 0f
[    3.414918][   T64] EAX: 00000007 EBX: c4a7b0e0 ECX: 00000007 EDX: 00000000
[    3.415869][   T64] ESI: c4a7b0a0 EDI: c4a7b120 EBP: ed6cdf48 ESP: ed6cdf40
[    3.416754][   T64] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
[    3.417835][   T64]  ? exc_bounds+0xd4/0xd4
[    3.418450][   T64]  ? exc_bounds+0xd4/0xd4
[    3.419077][   T64]  ? restore_fpregs_from_fpstate+0x35/0x70
[    3.419844][   T64]  switch_fpu_return+0x50/0x124
[    3.420548][   T64]  syscall_exit_to_user_mode+0x1a1/0x218
[    3.421473][   T64]  ? call_usermodehelper_exec_async+0xbe/0x1a8
[    3.422433][   T64]  ? call_usermodehelper+0x58/0x58
[    3.423186][   T64]  ret_from_fork+0x23/0x44
[    3.423881][   T64]  ? call_usermodehelper+0x58/0x58
[    3.424616][   T64]  ret_from_fork_asm+0x12/0x18
[    3.425367][   T64]  entry_INT80_32+0x10d/0x10d
[    3.426064][   T64] EIP: 0xb7f6ba14
[    3.426610][   T64] Code: Unable to access opcode bytes at 0xb7f6b9ea.
[    3.427586][   T64] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[    3.428674][   T64] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bf9716b0
[    3.429755][   T64] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
[    3.430823][   T64] irq event stamp: 0
[    3.431340][   T64] hardirqs last  enabled at (0): [<00000000>] 0x0
[    3.432112][   T64] hardirqs last disabled at (0): [<c107c35b>] copy_process+0x913/0x1930
[    3.433269][   T64] softirqs last  enabled at (0): [<c107c35b>] copy_process+0x913/0x1930
[    3.434387][   T64] softirqs last disabled at (0): [<00000000>] 0x0
[    3.435251][   T64] ---[ end trace 0000000000000000 ]---
[    3.451580][   T64] modprobe (64) used greatest stack depth: 5860 bytes left


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


