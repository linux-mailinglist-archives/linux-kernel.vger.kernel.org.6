Return-Path: <linux-kernel+bounces-234220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6191C3EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6553D280ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86391CB32D;
	Fri, 28 Jun 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ11OSwK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160BB1CB329
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592932; cv=fail; b=ttu5ub7ilb9XZZFB8BEx2hOi05qtB/ZlLwS9LzAfGAzRqJLNumAVzPQEsU6Yj9e/gP0TWTabDPfYU6HLSRG5n3lqdRzoN4zHz6pE5jj39aIy4CYOQKiB5WFRsVaf5WUWT7LVi374zLi7WXeb08k0qQQXIOYy8dwv6z+Xh/lP/aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592932; c=relaxed/simple;
	bh=ytHbRwLpOz5X4LM46v3tBLErKmfqRxWdHaGn/cXATlE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmLAR4XJYf5LnyYIG0QKS5nhfbhDVnWZwF/aeDqC1XcQhgaBSPtIDAr/KfoPPCV8aMF8Hru7qBKn72BPbceF1UF04qFrsFC8+H23QAP/Ui/frLVug8XfEg8l7VVihhYeD4Qs5eXivdL7qBPPsv2kr+9mff+qY6thJFJ0JgMZ2oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZ11OSwK; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719592929; x=1751128929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ytHbRwLpOz5X4LM46v3tBLErKmfqRxWdHaGn/cXATlE=;
  b=KZ11OSwKeOiXGKWjKeFtE85JdqfjUgnn6QZYzV2I0WlIZrWXNwzV1hXJ
   tc7wSQdbnWsXXWr9JTQrMyo0oCRxx0keelfkItfIgyd6+T4DRXdF44Qpf
   VcGOMziHR+iESMpR4L4C7WEupR28ziXC1CYGxW3lb4JIGm6OyQw7MJAtU
   jwqp/PBrPw/L/g2h0s2Lgktpyr47Ouo1nldGidvrBeZDU5mcuB46HykSx
   /5tWhQ4Wz4GBrXY5Sa60r5tewmXFoFO7DccZd/TMCLSQhT+IyKXtXYzc7
   KjTILPh0zKMuMLcTp3ZVKYEp5A9Hz7WxmX/DazMo1tWxBjwivQ3NmiJA0
   Q==;
X-CSE-ConnectionGUID: InP4PWdeRm+pLRzMncWIJQ==
X-CSE-MsgGUID: zmyxDt77SRmk+gzziqx58g==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="39300350"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="39300350"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:42:07 -0700
X-CSE-ConnectionGUID: K2PD50P1TPOSf10NqSIXLA==
X-CSE-MsgGUID: ioqLrY7jQyePw887KoRODg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="45210983"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:42:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:42:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:42:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:42:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTZEoSglQj5PCGs+fJfEedfGq8y8FZsx9ENvdEyv3Eo+hUGSlZd1atw7fA4cyXaj+NhVn6kFo8/o3ixobrIU5+3WS7ZXsEC1JY0lZ4moEvJYHFgimLsZwX47EZKtBLX9X0ATvo2iCdKZiSlQLooYZVaINi9g31hyjPxUzeoAjVkKzEkHgLJ0wLFeIL32mOONCkp88uFxnTjjFiUgbYODwf06u9EuL8aFlBj9d3JhBI5BrMS715Zk/yajwyqVj1u5Py1ErQelMkJnP25K9vB9j5jLMnee+mM+BHPMqZWJHscqa5YXYvIh5wED6+ecramA0gUkRBkJRdQH0XFGwrz8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zfAVi1H5F7MNtSChmwQLRJC654FkItPWzYnl8HFBmc=;
 b=ETlpfjF/V6VIvl3XzeC7U/0nkhAvzTA0q2m2fBDcITVar94yq9jSLKFzcaOjEu4PihOIQecweA67Hq5F8zdwtqyiK4kg0c7mBPbVjIH6Y3L6Fr1ge8wxsDrMHulCdDUVlJ2fxTKMCaRFMR5s56fDO4ZAMq6Acz+QWhY3CvgBNsA57B5a9FKJQkLcZO655i8zQYEQAoS/CAx9cj+52OXbrTEp+yYmbzfRk4gxnWmo++Ymwq2yjLUYJ5TE2MdBeHGM5L2utWTUvgyN8vb7MMQtwydypHIFy/x5BmWzhpRgC3D2OzKcwAtH5KU1rvp2Ez+M4ZQL1d/HtKq7dSKZ/qy3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:42:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:42:05 +0000
Message-ID: <2ffdecb7-2cdc-4914-9917-f30aae12eca9@intel.com>
Date: Fri, 28 Jun 2024 09:42:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/38] x86/resctrl: Add a helper to avoid reaching into
 the arch code resource list
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-3-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4732a8f6-63b1-4ff3-5da3-08dc97913ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU42ZVBXS2wzcXJsOEVBNDJ0WHZOaDduMUxuamhqbFJkNHBnRXlhcDZEc1ZB?=
 =?utf-8?B?TXRDV1RiSHRzWXIzUEhrOWJsYnorbmt6WUxQcitXYzUwbHIzNnNOdWNNQWp0?=
 =?utf-8?B?SFRtVjYxUDJid3JNU1YvRE9xOHZkQ3EzeUNKWjFZNHAyQjlBSlVDenRZWFMy?=
 =?utf-8?B?dUphZTN5ZHV3NWhLNGZveGpHVTE3d3RDZTlHMUo1VFl1T0g1V0FKZXM3WHVm?=
 =?utf-8?B?dW5LbXNzL2g2ZjNiYlZzcFRwN0FIWStJUjZLbGVYRnFRcCtETkdWVnhKNVBG?=
 =?utf-8?B?WEdOOUZlQ0RXa1FTRDNIRjNxM2FSeldPOGdzQncyUDdVNVNreEErc29WWHhW?=
 =?utf-8?B?QThSQWJCVjMwam1UUEtEYlk1bVgxWmhGUmdUR0dPTzVpZFFXeXI5RlI4VzZ0?=
 =?utf-8?B?NndWZjE3Q2NUY0FabDl3QzE1WmNuN1dCUnEzeTFhcFkyTU9kRDRNOHhxWXIy?=
 =?utf-8?B?L0hMdllXWU5HMVdCa1hyUytUNERpTXVKN3kwdVArZlN5N0NWUnJnc3ozOEkx?=
 =?utf-8?B?SW93c1dSNzM2K2IyYURFMFJKckgxQUMxbWhYZGZPeTZOZmdiQldhWURWcDRJ?=
 =?utf-8?B?K3lzQW5PWHE3MVFiQ1hoSG5hbjVvQUppRW9FMStEQ1lSZ3ZRaWt3TUlWb0tD?=
 =?utf-8?B?Qno5WnNTeGEzdHVPMjJIcFNTdTZ4a2tvL0hvYUpjNFpaM0hBYWpnSFc0OUti?=
 =?utf-8?B?eEEvNHlucGRXNFRSblMwdVJkOGN6aEZ2RThjNU5TMlBBMGREVWFvNXBMNXZI?=
 =?utf-8?B?YlJQMkNHcllBMnpuMHZVTTE0dTVvZE1vMHlOUk5ZMTR2TXp6SDE0aStUK3ha?=
 =?utf-8?B?VnE4ZVRYZHI4S1grTVJRNFhRSnR6bDJtT2RWZGtaRitPVTBsWG5HUy84a1ZC?=
 =?utf-8?B?TUE2dzNVMXlYN3dGWGowRW0wQjVKa3lqczhOdmJTRG9WYzRCSTA3TEJ5ZWNa?=
 =?utf-8?B?TzJIVzBCOXZBMTBmcm1JdU53ZjNMWXR4dVNvMFZGNlMyb0tYa1hIb296eVpW?=
 =?utf-8?B?c1NNQitNanlYWnRYYS8rcG9DVEw1V0xMY3J6aVpCWXVwdUFab04zTGdsTllO?=
 =?utf-8?B?ZUZXNEtGTnk4VTFHT1ZuRW5oUkFac0YrOE9EMGR2Q01NWGhUUUFJUFp4S1Zh?=
 =?utf-8?B?VkErWHVscEUrNWoxM2JZL1FTb1k3K2Uwcm1ibUtiYm0rUFFCRFNnNDA4eWhH?=
 =?utf-8?B?S2o2SnFkMGFNVEpNRUtpNk9oZWp0Qlo5R0dvRlVUTXJOZG9xcjRaSUFBa0lw?=
 =?utf-8?B?d1E1RGJFb210M3p1RnEvZkZjVU1OaG05WUlZWEJiSVBoRHhBUGVWOTliV3FW?=
 =?utf-8?B?SkR1SHJLTUJ0c3ZKb25xK0swWS80Smw5ci9nbFlLdDFQcFFoSGlhOTBxOVAw?=
 =?utf-8?B?QXFCc2Q2dlNUV0tXdFUxanZlOFF4d281d21PRTgzSzZBazRyQnRmc2kwdnN3?=
 =?utf-8?B?WnkvQzNLT085SGtsN3BRSUJCclRxT0Z0ZmEvd1ZraEpqdHFzWDZkVUJPNmlo?=
 =?utf-8?B?U1NDQXRTcHptNU9VZDZlcjlMS3RhZ2NxZEZ5WG4wM0ZyWWllS3dKNkxCOERB?=
 =?utf-8?B?ZXhvTkpqa1RXU0dHUFVyMUVLVjhBREMvVXhNbUhGV25iMFgzSjFPWE8yUHQz?=
 =?utf-8?B?SlkxR3hnVnF6ckgzWDVaOXBQenVjQjVURmJoYzlKZVpsVllrVTJMMVAzUTFr?=
 =?utf-8?B?N0w5ejNueWJscmZHZDg1bTRIZW55bU96SmlIUlBkUFYvL0JkTkNPL2F4M2xp?=
 =?utf-8?B?K2IvTjQvdTlxbzM4b1hjQWpJTGxpeHp1NGJmeE4yMWR6a0t0VXcxQnNwNDNJ?=
 =?utf-8?B?YVVTTkU5S00wT1ZBQ3Jtdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhMOXFZM1JiQTFvTHJKOEg0Ykl4YkkwWnp2Y29LYjcyNHNmT0pFOWx4RUN0?=
 =?utf-8?B?U0NSQXRva2lvbHdYTlBPMW91YUsyMlRBQkFUMlJrdzVGZFFqdWJibThrbUZz?=
 =?utf-8?B?cU1SNFpkR3NJR25XQ0wzcy9la2htVHJQZytMYXZnamxCdUEvTm1iRmVYRVlG?=
 =?utf-8?B?V2RDZDBwWXJQSlV0Y1c5dkxwQyt6bGNkdUxwV1RlbDlvTnZMNmZYd3huY000?=
 =?utf-8?B?VGFBR0dFYWtqVkR5bWlzN00wVzkwdE5DbkttSVlucmpTVWZDU25ZcVU2MWha?=
 =?utf-8?B?Y3Yxc0VsQjY1TDB5SlFnamhnQW9mZklZUzNTc21sRWZFcE5HaklGNllQVW8r?=
 =?utf-8?B?S1hJcCt6a3dkczMySGFoLzRaOGNqMGlEMUNWK0xVcTFuQUptVHBrTk9jamlB?=
 =?utf-8?B?MjFPdkovbDdpVGFUVDBpNHZQdUx4Q2dhZ1RwMUdFTGRSZ0s2Q1pjK2RwK0N5?=
 =?utf-8?B?MXN3VExFSGVEU3VETmVDZ0xZY1Ava3M2eUl6bFQ4c2dtZGNqcUY3ZGFjd3VX?=
 =?utf-8?B?K3lJQ3c4QW8rQWJ4ZUtWUm1mMFNYS1hlRWZFbW5wQVZZQ25mdlV5a1F5dkt6?=
 =?utf-8?B?ZUwvU0tLVFpPcE81RFo5QzlDMVB1emVPQ0R6cTR0a2dydzZZbjRITzJHT04w?=
 =?utf-8?B?Zi9QVVU3YVNOQzJScjV2SnVsQTFTVVVtYXlDckIyV2VBUE1lV3hDQlNSZVlV?=
 =?utf-8?B?VFg3RlJWWkhXOHkzaElQdk1qbk1aNnVIY1VISC9peExxL29JRWVocEpwd3kv?=
 =?utf-8?B?Y1MveldKYWRZQzM4dE84V1hJV2lNTE04MXYxSWZzdUprV1hjUmFObzNrc1hr?=
 =?utf-8?B?ZThJUUpjeERlcHdPQXl3U1pUMlZNUFY4bzVpMU16SU1CaVNEVnNNcVMwNVUz?=
 =?utf-8?B?ci9sa2liK0lvOUtEK0UvN1Q1QVluV2lnRUg3bnBrTXNRaldodWMwQTAzMWRm?=
 =?utf-8?B?WmIzWk5kYnZ0V0xXbWpmd28xTXhtdFEyTFVCUytiWEJSalhyZUkrL05IT0tv?=
 =?utf-8?B?NGFGOGdFZW0vNUVQeGlPQ2pycjdia25KOVN5bG5VWjN0ODN3c1ZzeUtSNG5P?=
 =?utf-8?B?Q1FaOTl3dTNHZDhsV3RVeWw3QjFPbWFWRzFlQmM1TFBDeUpnMTU0eTJlbXNJ?=
 =?utf-8?B?VnREZXI5bUY1ZzliZHltcUVEczZLZlpuQ3dTV0UvTStyUlJGOGZxSzVFdWwr?=
 =?utf-8?B?alkvS2c4MmhJSHRQWG4ya2RUdHhybGVQYklwL05mU2wzbUlyblRwcHBRNVMw?=
 =?utf-8?B?WmNVSHlYYVZhK2FaQ0dYOVhDM1hIbnU3RUpNcHZUY2pEVjRrNWhyb05qWnNk?=
 =?utf-8?B?U2JRVXlIdGMvWFN2enM5WHpRRjNHZ2JnNGYvNFA4U2dCZjU4a240UGFGMm1I?=
 =?utf-8?B?aDVpQ2Zad2d6VWwrNHFnQng2UGJ2cFZXNFJuc0tIMHdVK0dKZHQzdWJzK2kw?=
 =?utf-8?B?L1R1bkxKQ3B3ZHFxMFJJazN5ekU4cGpCcmJ0cE4zcTBsRktxSTQyaFF0QnRR?=
 =?utf-8?B?d0RhMnFUbHFqQnBBSlVIMkF5RnpkaXc0bW5vT1JjR1ZFbmpzRWtISURLREd2?=
 =?utf-8?B?cFYvUC9mZzQ5b1V4eHRWOVVuZitOWklxdG41clF6VzZnY2tzaTM4VXFHSDlG?=
 =?utf-8?B?UEJ6MmdZbExTOWpTcjJJUFcyK3dWNnVFQmhCOTVlRUZENkZVbWZSclZ6OXo3?=
 =?utf-8?B?Q3VvbmU1VENIZ1R5S1dIVEZsRWZ1SDBzTUxaWXhjZktKbkpmS0xsTzBNK1Ir?=
 =?utf-8?B?eEtsZEJOTTh4TWNrUGhjRGF0VVU3NitXTWpzUVBzWnNLdVcxeHNoWGROa1hS?=
 =?utf-8?B?RGFDd1dybzNIVWEwQXRQVEF2eW1aMXlVT2VlVERtT2IxVXFQb3JhMm1FNW1y?=
 =?utf-8?B?ZDAzSE9QeUF6ZHdxanFScUoyaXc0Y0ttWGNaaEE1dmN6dUVTbWJ2RzhvNEw3?=
 =?utf-8?B?YUNFalYvQWNqYkFHWGZtZmJ4WFpIbndFOVdNQXppREZKOVplYmhwak1RbGFX?=
 =?utf-8?B?c3ZCTjFOUk1sVnc2SndIMEJzUjRWbXdSZzFXL0Z6UlQwZTZySGdnL3RPSWtV?=
 =?utf-8?B?OGQ4eVA3T2Y4M3JDYVFubzh1cmQwd25ZSDBxRk9Pb3J4S1BWOVBUZmYzMktv?=
 =?utf-8?B?RlJZN3plNEF0WkJ6cW5NWjZaVGl3T0FNMHJEVmlqMm1PT1BzM0NUUGpVSFFX?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4732a8f6-63b1-4ff3-5da3-08dc97913ea8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:42:05.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3TXkgiHxsHeq3zqoYsgH5Pu9leKHqUbVlgdU5Rn9KBRMpFtSEBxx4oPcM+nQY/t6eVxfS1Ho224Wji7kObN6DeRr1DbagqQAtU+cfAaI3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 7:59 AM, James Morse wrote:
> Resctrl occasionally wants to know something about a specific resource,
> in these cases it reaches into the arch code's rdt_resources_all[]
> array.
> 
> Once the filesystem parts of resctrl are moved to /fs/, this means it
> will need visibility of the architecture specific struct
> rdt_hw_resource definition, and the array of all resources.  All
> architectures would also need a r_resctrl member in this struct.
> 
> Instead, abstract this via a helper to allow architectures to do
> different things here. Move the level enum to the resctrl header and
> add a helper to retrieve the struct rdt_resource by 'rid'.
> 
> resctrl_arch_get_resource() should not return NULL for any value in
> the enum, it may instead return a dummy resource that is
> !alloc_enabled && !mon_enabled.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

