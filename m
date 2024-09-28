Return-Path: <linux-kernel+bounces-342364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2042988E02
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4DF282BC2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1619AA57;
	Sat, 28 Sep 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4OvN5HJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D3381C7
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727504941; cv=fail; b=qiXiG3gzXQ2nMv3IK7zWA1oPIbbPGToMrZA85AsjHbGAVFZPsVapJPKlIwlQBp4ckWQ5S/sSlcNt4me6wbr4uPtCEKnPppyhb+ssKWAWZX0enubua3gOvZU4miFFQmV3T7p0rJXdMwCIvXyttZDqPepRIk55oegHN1jt7Ualwao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727504941; c=relaxed/simple;
	bh=zyDhpCn+s2Wy67lJv77Fn24MjVPqS8BH91MawiJXcKI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mpODY73238vQTRo7+dvK2GWdjPEknqxL9gbvvwtFEV1R3/7bLBnHnsXWW2JZ90jypuLIzycE5HsUZlSzG3W9B5TiqXrqtzvuV8zeMsqmkwIaqylaUrmTaH9xSRWpMHQTy7hgKeiYApVwwzkHDbhACS2SD9AGKLZMxJrEWVgSHw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4OvN5HJ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727504940; x=1759040940;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zyDhpCn+s2Wy67lJv77Fn24MjVPqS8BH91MawiJXcKI=;
  b=e4OvN5HJeE2X5VsrmmM4t/P00B8crRHU2U90Hebf2bhQoOHn8NHLAeqb
   xLxbNxTB98rd2D9GmA0ZfbsimN5gF9mSUmw5Q2vx4KrkEWyvktRXaXrD3
   bbyeJ64USam9xXRzzgTLrJYsNf/XTlOB/tNoqsYuq/pGtepmG+9zneSnI
   Rou84qpKURk8WWpgJLr6JcuqcNI/anpUlDQwdbwU4jF0031h3bbQDqtfE
   PI8xM8xodNqWj4aOVmc90wDzghnonHUZN4XtQN4aBwCtmeGGsz1sl6FP4
   ko7aRltbdCGgXW422zUn2LElK43csC25tnAO4gKqbyI6Vr6l5+fRxV2B4
   g==;
X-CSE-ConnectionGUID: jURWcUycQyqjLQ5WDxnTJw==
X-CSE-MsgGUID: 3+Ddt9HZTbKjY1Eznzg2vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="44121078"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="44121078"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 23:28:59 -0700
X-CSE-ConnectionGUID: 1KcQtzoqTlaQyrrjmYxfww==
X-CSE-MsgGUID: 4wOL1ZbNQzOeUnnsoDrFKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="103561849"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2024 23:28:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Sep 2024 23:28:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 27 Sep 2024 23:28:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 23:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSHjJGR/itKY228kY10omDG+vbxS1f6cWPh4mBwDLQSo7KNNWpvwdjoBmJ9qNegYRGMqBP0C9PvdLGsT7koHltqnVYKcHhSeQliV+YqUvR4Ym2uHWI1b7SwMN4LspqEb3W3X4DbS2YbAP0MRwcvcvJtO2IwXn0ekEZeJCKyCodDtq66oMXbsnBil4WWyhjHdi4d0sG7jTo3AmlPpG/fNPWB4gYbfxOTfGpA1irRPfwQxQKwJsieSeSnswlkutdd2dhOtpxQXNPMX4y8pOtjnW7o8h4mTbB5WE7SL1ptTMiB15gDNSxkXS46033jC1Zszbpebf7JC6slNeLZkT9HAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxyfLhhBA6BUwsar894ydPissxdOhTU2c9gy1C8LWOg=;
 b=u1EABo+GOzF5TmokYrm18RncGyriFR0NHBTvou6CjvtS2gwY8LcBbKOYtMzJaiXkSLXYBlIWg61TCS4yBLjwd1+jdP+y9fMfnjqjHVo2IN0V3Wfzjyixs62I/yOlSnTqZtQcR4v7rYMu5ecqgxkPn9oVn6w/RA6L9BaPFq7svB8EK+7KT/5/VyxUXZydkjpdc0zzLGUGTbnzF1gN29b3hg23eR3kczhVA7FSO/H3VdIij01wnIzk9OXldMRK+Ynlm4H++YU9jbmT2YwaRh4123jbpvv9KEmAtfljaSq4Y/0R0TtTA5GvgVGJUUu05fw0qCv0bHWVtGRZY7xhCNYong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB7147.namprd11.prod.outlook.com (2603:10b6:510:1ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Sat, 28 Sep
 2024 06:28:55 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7982.022; Sat, 28 Sep 2024
 06:28:53 +0000
Date: Sat, 28 Sep 2024 14:28:30 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Honglei Wang <jameshongleiwang@126.com>, Oliver Sang
	<oliver.sang@intel.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>, Chunxin Zang
	<zangchunxin@lixiang.com>, <linux-kernel@vger.kernel.org>, Chen Yu
	<yu.chen.surf@gmail.com>, kernel test robot <oliver.sang@intel.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
Message-ID: <ZveiDh2/ztZTP/fH@chenyu5-mobl2>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
 <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
 <ZvZXEqNLcJxq+8Aw@chenyu5-mobl2>
 <c15e2f07-5a0d-4e48-b7f4-83e4689f9299@126.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c15e2f07-5a0d-4e48-b7f4-83e4689f9299@126.com>
X-ClientProxiedBy: MA0PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: b48cfd1d-eaee-4366-f6eb-08dcdf86d294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFd6R2RtRmc5WDJXYWpHNjJ5K1NxVVRxelRCaUNNR3RMTS9Cam1lWVZjYU9V?=
 =?utf-8?B?YnRqOHFxQkhuNThQVlFlcDRWT2lvQmNUMGd0dnhJT24vTFBxMUZRQWY1WTMv?=
 =?utf-8?B?b3BlZEFtd1RjYWVTYkdWNjk0OGlUOFlCaWprcHZGbTIrZ0Q2Y3dCZFZXd0NS?=
 =?utf-8?B?V082empTSGRCVnZuVEVnc1VWSFVBWFg0NzNsYWhEZlB6WlZIZ0hKSnpIcll5?=
 =?utf-8?B?MmVCL2M5VzRyQ0xMUFhMZjFqTUEyUkhXVS9rbEpMMEdsWUdobndnbXcvbjdB?=
 =?utf-8?B?Sm8xN1I5YW84SXMxWmRqWS9VY2FhMmlOcnhub2pQMWpnK1c3OWpSWGNPbC8y?=
 =?utf-8?B?ekNtSm9IbWFmcU8xd1hiRjhXMUs0NXhhUlFqOTg4VmQzY1lISzdlZEFQaGVr?=
 =?utf-8?B?VytIcmQrU1pmSWM2M0tCcGR5S1ZKZWMyanFJL2dFZkJ5ajVMYk1BSHZMSkZ3?=
 =?utf-8?B?OUt0OTRNTytldGZpZElKMFJOaTNtQkc2WjM1R2R3ZnIvRjVjbHNDaVhZMnR3?=
 =?utf-8?B?a2cvbk5RNjJ2OVRSQ2FHbXFUMFE3VnFOVHF6SmdxZ0l5WkJ0WGY4ek5DV2t0?=
 =?utf-8?B?K1VYd2xtR205WFBwcVpsNHhIaXFlYUlxay9oUjZuWjlyZ05BYjdraXFaZFBh?=
 =?utf-8?B?Sm43eXc2bDB0LzF4TGxscm9uR0F6dDZNSnAyaUg3ZUl1V29QdmdEQmZmWHl5?=
 =?utf-8?B?dWs1YzNXTTZOS1VXenViZlJsdm1ucDV6SW5vUDh0NWYyamFlR0RxSFhaVXYz?=
 =?utf-8?B?bHhXTXVodTJZRzNsWk1FRHd4VUU3c3QySzZjWXppMW5BZTRWdk1vYjc4Ykht?=
 =?utf-8?B?NzVBMXlCQkl0dlByU2MzVlpKTzMrV29hM1hjRlY0V0lQMkV3UzBnWjF0VVI3?=
 =?utf-8?B?RzdNQjVwTU51eEU0Y1hMelRtUnh1azR1Z0RQSVJLTkRNdzRGWUNQb1VobFQy?=
 =?utf-8?B?S05FaWlpUytBSzZTN3BjR1FoSTF2R2tIK0ErckFEbWpaS1diUFlzcXZqQXJX?=
 =?utf-8?B?VDFvNFVhekxKMHQxUWlDUG1MUGhIQnhMK1VXUm95dkprMWEzQUFNRk1Jb0dV?=
 =?utf-8?B?bjVwS3ZyZUFDTWNHbUZ5bjN6SjVEWmp6SlE4aEZtRk1OejA4ZFVhRVVsYThp?=
 =?utf-8?B?bUtsREVwcHFLYmtBeFRISjZ5K2ZWVEtuLzJMUjVyVnVwL3Q0SEFtRm4xcnZj?=
 =?utf-8?B?MnRmS25OWVFBOGxZa0FhTjExRUFUNFdnZFNDUXM3NE5WWlpmeHFPQ0QzeUE5?=
 =?utf-8?B?dzNWengxVnlIdy91b0t2NVV2elNtT3BKUEF4eEJaaEo4M2pINEV3MlZzNHZZ?=
 =?utf-8?B?dWJIN1RTV205Zlhtc0tpaWUyMEJkWm1xc214anB3Tk85ZW40c0M5b29QeStC?=
 =?utf-8?B?bzVtN0FmRUhhUDR4d29hNC9na1pRZXRtdGt2Qjg0OWx6OVBMLzF6cmJiWjNn?=
 =?utf-8?B?eXBLcEZhZFZSd1hnRHJYR0NMb2FJLzdJM2FpZTh1R05pWDFzMEZSOVRtK2lM?=
 =?utf-8?B?SVFCZU9xSXcxQU5XT1JKeVZxaWJXNnp2d2dqZGtTQ1FzZUhWSFNRUG9qSkpJ?=
 =?utf-8?B?NTByU2JuTDErdStLajZWbmdqSUtyNXdYZy93alZBY25GbENBOWxtZitFK0Mr?=
 =?utf-8?B?UjF0aXBOdUVLK2NscWFwd2FnSmhRR3RDaWlzSmpyVVlFMkd0eEU3TlEwaFZM?=
 =?utf-8?B?Q1RDeHVaRHBHYmxqdzZ0bE9sTXJ1UE9LaTRCbDhsVzkvdXdiQ3NRQVhtbVE0?=
 =?utf-8?B?OGtwdHNyMFk2L1lFT2FINXU4KytCRW9qWDJnNEc5VklEQXVpTW55SytLem1G?=
 =?utf-8?Q?n/YQTrSSi9FwAACagfXr+oUeh0vZuaZhL6sGI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czU2Yi9HRG0xLy8vb1cxTldRL1R4UFNKQ2pwTE5CS2cyUElPVStibnhBUWhk?=
 =?utf-8?B?SEYzbHBvQjB3RGRkbHVlYkpoRUhPN2ZETU5hMy9iM3Y5cjc0N0VHODhRU1VG?=
 =?utf-8?B?K254QW9vSDdxRVVXbG9VbkdwSE94NTc2ZTlLalc1dHZJdnExVVd6S0NjVFBI?=
 =?utf-8?B?NStpZEJDWndBRWpIR3dwNklxY3JURzBYMTI4cG9kR05kR000VC9NYUMzUUk3?=
 =?utf-8?B?QU1XYWZZcEZxa0hLRnUrL2lOelp5REd0c1FLd21WQ1lUbFlIK1NqNVNaa1ZM?=
 =?utf-8?B?VFRDdDg3OFVHS1kxQ0tjSmd2SHU0MHpYL2hucVdlUnh6SWE2aUJ4ZCtJUnBx?=
 =?utf-8?B?SGsyV3M3QXIvd09CWEx3YTRMY1FBYlpMRGRidk9GUTBxVS9La0VmRUFuSndh?=
 =?utf-8?B?Y3MyQ0lTNEd4Y0xKZHhvN2FZVXpDcGg4SmtlUmJZVG8wODV3WDZZeVpvY2VS?=
 =?utf-8?B?QlhTb2tLOS9pdkpJM3NpRTUza0c3V1I1SEVCOHh3dkhkcVBTWWszSWE3WVFF?=
 =?utf-8?B?S2dHMnV1elRhM3M2Y0hodVZsS3MwZXZ4OUNsY2hld2Nqa05rbVFxQ2NLdE00?=
 =?utf-8?B?dXg4TStuVFZOTzZSSWRkaXFZV0o5UURMcExNNytoRXN3eklZWkJxODQ5U0lE?=
 =?utf-8?B?RzV5eE9hblYrenZJSFlIa1Nka0E0c2ttK2NBQ005NDZyNFVDdXZHcVZYSDd1?=
 =?utf-8?B?UGlYTWtMcW82c0YwUFNOcnZYOVVIam1PcUhmSVdYazdtTzlTY1h6dWFiaTlB?=
 =?utf-8?B?K2hzZmRLaDFWMjMzZnE1aVhKZFNybjFseEluUjIvdE1IRTM4MnVBNUZuNWVo?=
 =?utf-8?B?ejZMbmxmQXRjVW4zampZVW5sTXNuekUwMTlkclA5QVhhbnFHMzdUTWY4bDZQ?=
 =?utf-8?B?Z1pTL05PWWZ4ZGYwVXNBak9KVUd0WU0weWtJbXpZWkcxYStDWDlsakJuajBR?=
 =?utf-8?B?eVVmUy8reXVpUjB1NXRORFE1VVRvWDlWakVxR2loZmJUOEdrVG80WVJnbWtv?=
 =?utf-8?B?UW4rNkorNFQ1TWdrMitxa3ZKdnZGbmRRZGJMZ1N5NHVzeWRJRjhrQm9waUFE?=
 =?utf-8?B?VXdQK084K0ZQdExFK3B1dGRaZDFJVXlIU0IvanR2Tmp4WUdoSFo5aUUySHgr?=
 =?utf-8?B?dDZPb0gzdE1WRkRMaUl4cHplcHlWbEtFb01oNzJmcEhIdFJkT0JEaDVoQjZH?=
 =?utf-8?B?TmhSc0JFRjhCcGR1Ny9DcFpPQWlXbm1QZk51c0pJai8yc3hIWjlWalhjL01q?=
 =?utf-8?B?UjlGQnAycFY5cUR1RVdOZGZ1YVNiYnF1d0pabXpvelkyOHkzQVhFcXRvcmp2?=
 =?utf-8?B?L3ZEaHhsU2tvZTZuaTZtVUxKY3ArUEcrMnRITk1WN01oQ1JGWVZXVjZpZGFa?=
 =?utf-8?B?dHJMbG9yTE50aWFQY0tiUnBuZXZYS05pSXJvUE9UV0ZSSkVhV2I5Q1hWd0ZY?=
 =?utf-8?B?TnV1RU9uWmdka1VNeloreDhoZ2xVaU9jdHZoNTdhSDZrK2RHcFRMRGowaFc0?=
 =?utf-8?B?ajBXRlBFcm1XRDVGZXc3L3hoQWpTUWQ0THUyQ0EyRHRlNHJ1djlEYnM5QThL?=
 =?utf-8?B?bG1Kak9jWTcvcmJQS2ZDdkVWWFRTdjUrcU90UGMrOUI4MmplWE1iMXYzc01H?=
 =?utf-8?B?NGRPakZxbXE3VkROeUlENU9MV2RuRThnMGU3ajVrcldNc0NPTHVmU0dDcG5m?=
 =?utf-8?B?NjdTdmxOSGhXb096UmZFN1RDRHlGUE1MRXJNbXMvR01uUUxVSjVCQ2Q4QktG?=
 =?utf-8?B?QTlXdEhGK1RDNG1WVjQ1QlM4WmxtU2RZRFBMU3I2dXQ2WFlIUVpUK21WY3lU?=
 =?utf-8?B?TkJLWmhTdHVrUDdHWEY1OUpHdHJzTkEzMHpDZERzTTVITjIxVktpY1dpemRr?=
 =?utf-8?B?RFdhY0dwMDR0MUVWREwzMm1PcG9rUjJPZ2ZYTUlTekFzU3ozQy9HWkorT3NQ?=
 =?utf-8?B?cXdwWUN1VDRyUk5nMUZEUWIzckpVcFRVZFVyb2JTS0xka0tTZzJsVHg1K3N1?=
 =?utf-8?B?b05BSlFGazI4WUthU2x1bHdaVnZOU2lpWStLN1I2eE5qUlZOVEJpMmQwa3BI?=
 =?utf-8?B?RU12azNNb3RhendPdjl0RWtCTmJXSTFuaTl6Rml1UWgrbXBBTzZVenYxWUR6?=
 =?utf-8?Q?MmkeehMXlt1NfUp5PoAMt41Dw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b48cfd1d-eaee-4366-f6eb-08dcdf86d294
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 06:28:53.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYrRoy/7fFEamQVcSi+d2kadyEtP23+6yRNxjAoJXRT7ympy6xoutGEAuMKmpgWFXWvWMVI1huzF0Mf+62r91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7147
X-OriginatorOrg: intel.com

Hi Honglei,

On 2024-09-27 at 21:38:53 +0800, Honglei Wang wrote:
> 
> 
> On 2024/9/27 14:56, Chen Yu wrote:
> > Hello Honglei,
> > 
> > On 2024-09-27 at 09:54:28 +0800, Honglei Wang wrote:
> > > 
> > > 
> > > On 2024/9/25 16:54, Chen Yu wrote:
> > > > Commit 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> > > > introduced a mechanism that a wakee with shorter slice could preempt
> > > > the current running task. It also lower the bar for the current task
> > > > to be preempted, by checking the rq->nr_running instead of cfs_rq->nr_running
> > > > when the current task has ran out of time slice. But there is a scenario
> > > > that is problematic. Say, if there is 1 cfs task and 1 rt task, before
> > > > 85e511df3cec, update_deadline() will not trigger a reschedule, and after
> > > > 85e511df3cec, since rq->nr_running is 2 and resched is true, a resched_curr()
> > > > would happen.
> > > > 
> > > > Some workloads (like the hackbench reported by lkp) do not like
> > > > over-scheduling. We can see that the preemption rate has been
> > > > increased by 2.2%:
> > > > 
> > > > 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches
> > > > 
> > > > Restore its previous check criterion.
> > > > 
> > > > Fixes: 85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com
> > > > Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > > > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > ---
> > > > v1->v2:
> > > >       Check cfs_rq->nr_running instead of rq->nr_running(K Prateek Nayak)
> > > > ---
> > > >    kernel/sched/fair.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 225b31aaee55..53a351b18740 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
> > > >    	account_cfs_rq_runtime(cfs_rq, delta_exec);
> > > > -	if (rq->nr_running == 1)
> > > > +	if (cfs_rq->nr_running == 1)
> > > >    		return;
> > > Hi Yu,
> > > 
> > > I'm wondering if commit 85e511df3cec wants to give more chances to do
> > > resched just in case there are 'short slices' tasks ready in the other cfs
> > > hierarchy.
> > > Does something like rq->cfs->nr_running == 1 make more sense? But
> > > maybe it helps less than 'cfs_rq->nr_running == 1' in this hackbench case.
> > > 
> > 
> > Thanks for taking a look.
> > 
> > It could be possible that Peter wanted the short tasks to preempt other quickly.
> > If I understand correctly, when we say preemption, we usually consider two
> > tasks which are in the same cfs_rq(level). For example, check_preempt_wakeup_fair()
> > iterates the hierarchy from down-up until the current task and the wakee are in the
> > same level via find_matching_se(&se, &pse), then check if the wakee can preempt the
> > current. This should be consistent with the tick preemption in update_curr(). And
> > whether the short task should preempt the current is checked by
> > update_curr() -> did_preempt_short(), rather than checking the cfs_rq->nr_running/nr_h_running
> > I suppose.
> > 
> Hi Yu,
> 
> Yep, I understand the preemption should happen in the same cfs level. Just
> not sure the purpose of the 'nr_running check' stuff. Perhaps its role is
> just to judge whether it’s necessary to do the preemption check. If there is
> at least one more ready (cfs) task in the rq and current is not eligible, we
> take care of the waiting tasks. Thoughts?

I got your point and it makes sense. Whether the preemption check should be triggered
seems to be a heuristic trade-off to me. I'm ok with using more aggressive preemption
strategy as it depends on whether that workload prefers latency or throughput, and as
long as it did not introduce regression :-)

Oliver, may I know if you happen to have time for a test if the following change
suggested by Honglei would make the regression go away? Thanks.

thanks,
Chenyu

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fd2f3831c74e..290e5fdfc267 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1247,7 +1247,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 
-	if (rq->nr_running == 1)
+	if (rq->cfs.nr_running == 1)
 		return;
 
 	if (resched || did_preempt_short(cfs_rq, curr)) {
-- 
2.25.1

