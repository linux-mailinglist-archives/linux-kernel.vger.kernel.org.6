Return-Path: <linux-kernel+bounces-416408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D52249D4458
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EB7282BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939331C232B;
	Wed, 20 Nov 2024 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zei7Qffj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F81C3F14;
	Wed, 20 Nov 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144527; cv=fail; b=gAoJqLSv+uuEb/s7PNy6qjmOj99AY43MU3l+ZOro55dRV8P2DUb6WDnUDgpgEI0vEIH9Hice4UtRqIcvXHqQOJJ6qm3p6VPNA7H43M130m3HTCfs3+ulxFN8PlogFqItgHUGd80Dp0HRvqrcCPZucZyB+NrIHMfam8TdyFnB0RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144527; c=relaxed/simple;
	bh=vQg69RYKkKXhAWcTFd9aKbCrAbhYVShIpTfJHS0+7M8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZ/MiyUEjrnRJ8iYMz8U0E0U8Lz9r6xQ6yhMpJuMI3a0f6F5APoPhNBI9GeMFi0Xsi/hM5ttu3i7GAn7AOXXW5SF348VzuYRKzw6BZVYgLhRIV0Et2OLgz0h7Fhft41hMLSllGIgrKgTw/RprEmnO0y1bjBMZR0yJUr3TyrnZ7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zei7Qffj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732144526; x=1763680526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vQg69RYKkKXhAWcTFd9aKbCrAbhYVShIpTfJHS0+7M8=;
  b=Zei7Qffj83CzpN/EkF84/kZQYBoUym1JhGWA8XWjOS5bRebvrGzdztLq
   CP/xkEI0AxD/RTfa74f5NNPVy6BJZzS3ME57iALzzAgeeVqrKc523RdWA
   Ikly/eSZUnC1NTwGmvSY8oTYMJ7NyDjFCuST3aV4RS2J7ZBxkKxWeHt6y
   mGdZXKhb5M6xGPf6FJd7CvINIpdXbkN/ZVlCckLChRAu3vCWXeO3q/YrF
   1VUqPwM7Qao9fz8cXrxTc6+oqM+LxFqHA4LMAaLATWWQZL0KwpstjA955
   +/v6+6p37P6tyWMBr435nJ4WaVRPwmG4i+GrVdut2TLL+S4rl3gtg049O
   Q==;
X-CSE-ConnectionGUID: 5O8SCtiuQkORBcWUWoAI3w==
X-CSE-MsgGUID: kF3awYtCTjOsRHABlbvqWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42871361"
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="42871361"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 15:15:23 -0800
X-CSE-ConnectionGUID: x0vQNZcCQhmg6pyR3UJaeA==
X-CSE-MsgGUID: i03vRZr1RNmZhExtBApIyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="95013174"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 15:15:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 15:15:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 15:15:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 15:15:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgMoRLtp0nRREq+lr19eTH4d5HfU5wT9GdzNmYG8iJezwPD89JczYOlpEy4EZ+nAIxO0zSsyY8qTHUHYTLuIn2e5K3gdRQXEfduo5OPhq9LWJu3rIeUpY+z76QlpJmy9JcFC0O9U3akGRz76Bld2p/zRUHXuOcKLNOKGuzzChMRpuxxwxFJRDYusP+Awx1Hn6TuKqRv7DUtJ0PMNx/kgSttUE5vKw3ctd9olfcpBwqFzQ3tSqnX6LLItbPr8n/SYCGgbUB2phtDyYY5CsGYfpi9zk9Up73uih+Rr2fghz6VhwB9/lc23QyLPj+kPV1Ce+P2qvpVXa0t3uqfN+UkbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hrL/YlR/zgnwe1VO0cIlUSHo/G7qmpVkZ+xG9FR8sM=;
 b=fM6h6+6wBhZTnzusMCSy6CwWKzUnVqMXisQc/NG4Dtp2Y2R7iU8S0Bg4wkD77s8hQ0bge+heFRsXUkoBX9+eRBLxqtA6iP1unIqSK9wYOqQWJbV49fO29rx4NeZuqYXcFRJk/3HL4jpGlpfUw9BDU+TaCAbIjXXgobwZAUlVqeSBsR/bQyd1cQkJIN4Tzxos75UAU1f5Wyy207VxnrGvR2WWZFFOWm+cNvD7b9fi1tCDR6O1zUq1JKoIb/hC3GywYA/7qGPaClXW9F1CvUQKBNAsgmYkrl+8sP+6s4QtT1A+MG1VhWPd/T+j+PqBvoDncx7j0qjPvcXm7+1vCgg0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 23:15:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8158.017; Wed, 20 Nov 2024
 23:15:13 +0000
Message-ID: <ad1ceef4-b98d-4fca-90b9-b9b09e311001@intel.com>
Date: Wed, 20 Nov 2024 15:15:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: Merge x86-specific boot options doc
 into kernel-parameters.txt
To: Borislav Petkov <bp@alien8.de>
CC: Borislav Petkov <bp@kernel.org>, <linux-doc@vger.kernel.org>, X86 ML
	<x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20241120163033.12829-1-bp@kernel.org>
 <0d4f2978-22f4-4e8d-a6b8-e6b90888dc25@intel.com>
 <20241120211122.GDZz5QeheUP5thy_Zi@fat_crate.local>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241120211122.GDZz5QeheUP5thy_Zi@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:217::11) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: f025cecf-3b48-4a07-63a3-08dd09b92fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHoxWisvVmc1L1NCWmVHc3NZRHBic044MVhGaDRGTG8vRmVVR2NqTk9BMnRv?=
 =?utf-8?B?RndySEw4MzN3cFZ6V1hYcStyWWE3cHZMNC9iZi9OVWJqODJmdFhKUmJSUnNu?=
 =?utf-8?B?bkZBcWRHc01mcnRzYzJyOGQzSDZXNmdYRkNrY2NHZEdwUHJuVjNEc1VIR3F1?=
 =?utf-8?B?ZlI0UUFFeldKcUFwOEhkN2NKT0JMOGJlanlueGtUa1ZtTlVQdE1JZHRSNjc4?=
 =?utf-8?B?bXpIZXloaW1iNm5lNkFKdGtwU0QvWS9sK1JwMk92YStIZ1VMakw5Ri9ZYkhr?=
 =?utf-8?B?dGFQc3hRaGdKbEhBMFNJbW4xbjkzWlJMT1FZRVJUS3N4Zjgxa2dLelkrbzNl?=
 =?utf-8?B?Skp0U1JPK05lOEYwSzJRaURETUx6dFkycEFzTVNkeHhpb2VkaEQrZHN3cmRk?=
 =?utf-8?B?Vk9jZlBDK3ZoWGtVdXFlamFVaTgvc0h1a09Db0kvYnZXQlppMjFNbnptNm5s?=
 =?utf-8?B?VHZ6dnZWS1JML05iMkI2Y3kwcTFudEFoMUVpcVU5RFg0aHo3T2crbnZmalBJ?=
 =?utf-8?B?MmVxNmkxVzRlRkltT05xQmZhYncrenQ1YkwyL0ptSkQ1aENibDFxUTdJMngr?=
 =?utf-8?B?NVlKZm9vN0o1ZUJ6clZGR1JGU0JjN2NQWXdtVVB1Z0RqME5vQmpIV2FybUt5?=
 =?utf-8?B?dFFvRzBOQnV5RUlTZk1TMnBaR3dqSFdIZ1NFWGlqNjhBUTNPT2hwYkJ5WTZP?=
 =?utf-8?B?SllrcVpJdjE4M0kxQzdNaThVRkExLzMwb1VKa1dpMVJEc2o3VkJuQUxxcE44?=
 =?utf-8?B?TTJTbUxQSXlKUXA1M2ZwbXkwVEtMS2dIRDNjK0oyTWI2RW4reFcxa0owaDZz?=
 =?utf-8?B?TVNLVnQzZ1BRKzFsN0JaUHUzN1RGcjV0QUlkM1R5U0FTZHFRbzlTYlQ0eHN2?=
 =?utf-8?B?b1FnczdVRDNVM0hmR2dVNnlOdG9wcHc4RkxMOHovQndkZmFmTU1uSWxmbmFn?=
 =?utf-8?B?Z2NTQjZNajgrTzN6SXc2WHJ6Y0prZU9MTDRxeGxsZkwrYk5lVUU2R2hpcHZC?=
 =?utf-8?B?Lzl5RUo2Q3FlUDlQVWw1UnpPa1ZhNVM1azBKOFZyWWUxNWJ2U3BBQU9ReXdn?=
 =?utf-8?B?ejlwOUxtUDBtdWQ1SXpEWDlSTUJ2QlhnZG9yWXc0bTNzWCszMHh6Z1Y2TUJt?=
 =?utf-8?B?QnFkWXc3Si9xUEhVZUNKeHM0dmV6SVdzL2FmYTFrdEQrenNpUEU5UUJEVkFr?=
 =?utf-8?B?NjJpRGtFWm9meTZpRGR0K2lRb2NMVk82Z1JqN2lhSldFQzRPWFZjd2N4UmhI?=
 =?utf-8?B?dzJaeHp0WHVFR3FiQ1d0TGZsa0piUlgrSUMvWWVXb1NSWFB1ejdRV3NzKzA0?=
 =?utf-8?B?eEJ2WW8ydWtQSm4yMzdVZlhYckltcENHa0JReEFxOC9ORWs5UFMvbkhQTjRQ?=
 =?utf-8?B?WFZ3a05HNk4yK04vU21PMHA1QS9PQ0xzVVAxOFZPdFNmMlhrOGgva050WUd3?=
 =?utf-8?B?ekpabzhBcWhhdWRyU0ZrWjJnL1FUU3ZRT3ZMSTdWdGxhSks4STRpbXdVRHB3?=
 =?utf-8?B?WVhsWHcrQmViYUYzOWtZUUpwM3BjOUlJN0xnQkxNVXRBUW9MdkVmdXYrZWF0?=
 =?utf-8?B?U2hVRlB1cGtNYWRsNHBCZEZVWm1STmNKSDRCM2k5ZFg3NThuS3lJSURCRFh2?=
 =?utf-8?B?ZFBSVmNGbm12dm51YVhqQ2N6VUx2SEkzSTJmUytkeGZ5WXYxblhoZGU2RlBT?=
 =?utf-8?B?OG5jUkIzY2E2SUpNdVRzS3ExN0JTQW9DN1BCc3hkNmo3bVRjSXV6U1llUnEr?=
 =?utf-8?Q?0s0AcutNmNtUsZAE8M5kn/Cmg2gSYZ/0EFprkuS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9QK3dkRTlhMG13QzdUMWhuMlpYYzd4T3k2TThVT2FhaytIa295b0s4OGda?=
 =?utf-8?B?SjBjbzhlaEhVNE5ONUYwQWhVTWM2bjRmbjdib28wa1RXR25VV29kOVRZRWlQ?=
 =?utf-8?B?dHJJdVk5Q0JEc1JML2lNSnJWRFBjSDg1WFFOWFl1TkZGZ3BoajNCelNhSkNL?=
 =?utf-8?B?L1NIUzJTdzdhaHd3YnpQRmRDYnlHaFJVQlJKWGFwVkNGNHdwOU1IVFFFNXlu?=
 =?utf-8?B?Q3pqUVdlcnVBZE16eHF3MElTbnhaNHVWZ0xubUxka25YYjVDRTQ0Vno5d0pu?=
 =?utf-8?B?R2ZFWVNsbGRHZnVoTFAxZkJQQi9YZWlDYlg3a0dBZEFBdnBVOVpMSjhTbEZW?=
 =?utf-8?B?L0NuL082TjNvQyt1Q3ZKOVYyTHA1d29SVTlPREY5V3RQdkd6UjJHK1NoMFdV?=
 =?utf-8?B?YlR2RzdNaXZCUWtiZGlmOEVPaFQvL011RklxVEJBSUFWVWhTa2xnSmpDRjNQ?=
 =?utf-8?B?Nk5WUktMUGpWQkJJMWFLbTRmSjN2elZjY01jeTFQSnBJdnFTNWVtY2oyOU40?=
 =?utf-8?B?OGhuMG0rUFZJNGlJOVRtWEI0YUVxY3V1WHR4ZHF1UFA4RlFDUm5RR25QT0lF?=
 =?utf-8?B?eHJ1Z1FEcU1lSk9xdXRKanVTUHdWOE5ITjhSMnVkUy9zeHFYN285RDhySEpk?=
 =?utf-8?B?Mkk4Q29vUUxtSHc4Uk4xKzdFNGdFNlB3ajJadkZJWjRzL3pZZ3J5RjE4SEk1?=
 =?utf-8?B?d2tnZ2FtUGdVOUpOS2wzV2U1STlDZ0ZwODkrUkl5SlBybUgreUE1VmNpbnNZ?=
 =?utf-8?B?OHAzcVk3Vk1NZTdJYTRBWlF1OFlJeFZIdnFSV0RGOEViLzNGTHIwbmR0ZkRX?=
 =?utf-8?B?NXJRWS84VWtMb3hkbWFVQ2NWOVJlQWJsYmx6L0RNc1dGOUtMenhwYldNdkMr?=
 =?utf-8?B?OEdnR2EraGJzbFBSYm5GYVZwUVRzYnRHc1ZVaTV0UlBIenZyaVBHdVF5T2xw?=
 =?utf-8?B?RnJVQmJZOGdJd2lnWU1PMmp0Q1g1dVJwVGRmM2JsUjE2b3dVa3gvdFdpczRI?=
 =?utf-8?B?Ym1SUEZ2ei9ldmRWMTNSZ3F6ZUd6bzlleHgyTG4yNUVEQ2lldVBjYWpFWmp4?=
 =?utf-8?B?aHEyZ2J1aUpsUlU2dVBtOUUvTFNwYUpnYXNPUjBTVG1rcGV0cThkdUFGTWFF?=
 =?utf-8?B?Y1V6bW5EejJreTUxdUl3UkVWaFJiVG0xeE9EZkRGbUJzblZBYkxIZ2lZWmJG?=
 =?utf-8?B?RTJ1RGUvb1ZwaWsyNDdab2VWNEx6Q3RQYS93dlQ2NDBhd25xeTZiclJCVjU4?=
 =?utf-8?B?Z2dsWUxETUJYeURmemhSTFJNdUUrU2cyVGJWTDdGZTFJZkQzbUIxUnI5L3Vt?=
 =?utf-8?B?ZDdVV2tJQm9rTjQzWU5PckZOSkRpTHJ4N3loc1hrclFlaStJVGx5bXpYMjA3?=
 =?utf-8?B?YSszVU14MjJ2Qys4VDFSa0dTcUUxVHVvcnBwZ1FqZnFWYmx4U1dGeWw4VXNG?=
 =?utf-8?B?ME1jZFVoYnhlWjF2MlNTU3FoVVIrRWR2bi8xYkVpcnRjaDlxMG5CbEdMTU42?=
 =?utf-8?B?bjNZeTE4Qy9aVE1YK3JCUHhFVXJzQUE4VFlEbTZ5K3NrR25SZDVYWjBBc3Zu?=
 =?utf-8?B?bHdjN2Z1T0pXM1Y4bVg1Y0JSNWhGN0k2RW55d2xmS2dUcEQ2ZjRYYm0xZWw2?=
 =?utf-8?B?bGswTnRXR2hpM21GOWxrOGd5T2JWejFjRllHdysvRjFvZGErR3BBZ1RDMnlK?=
 =?utf-8?B?ZVpZYkF4SnJscGM3bXpvYXFZNStJZ0R2bkdTcGFjMVdMRWRBOFdsOUxlWTc5?=
 =?utf-8?B?dVhycFdTMzNoekloUTBENFBFNDBxSTJ0UUYxZDhtVC9WS1JLZkJ6dldqZW1k?=
 =?utf-8?B?UFF3S2J2OUwwVTZWcnRteUpBckNDSHhBaC9DdHFRcHFHNWN5N3l0eGVmUFdn?=
 =?utf-8?B?ekRXOUdaTW01SmMxWnhOUmxlVjg0b0R5VlJDN3pJVzljcmc1b2greU9JeVB6?=
 =?utf-8?B?QkF0aWh3cmFjTDNmS09mU3ZCamhoRjZsaDYwQ0JvenRJN2NjeG5TdGxNa0JD?=
 =?utf-8?B?Y3dXdlV5K0MzNUxBaWZoZWFSbWw5MU43a1BZRXlNbW9MU1QxRE45N0RPaFUx?=
 =?utf-8?B?TjRneG9EUVBEamgzek0xaWpEa0VwNEo5NUo0ZVhqM04yaHlzZHhmRFJuaWh0?=
 =?utf-8?Q?9/PuPp/n+M9hEbSuzXYUIfgeI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f025cecf-3b48-4a07-63a3-08dd09b92fe4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 23:15:13.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsG55EplQaei+4pGzTMUkGZUrH2Cb+FWjoEvR+8uEy8AO4AiXlvHBwIQ3JdgZwVN5RxKZQFIS2+wj+dB8pLX2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On 11/20/2024 1:11 PM, Borislav Petkov wrote:
> On Wed, Nov 20, 2024 at 12:49:10PM -0800, Sohil Mehta wrote:
>> Instead of double tabs and <option>: <description>, would this be more
>> readable if the options and their descriptions are separated?
> 
> Have you seen the rest of this file?
> 

To clarify, I am not suggesting to have the description at less than 2
tab distance from the main command line option. It's just the
sub-option. It would still keep everything aligned with the rest of the
file.

	mce=
		<sub-option-1>
			[Description - ...]

		<sub-option-2>
			[Description - ...]


I see quite a few places that do exactly as the above:
 console=
 console_msg_format=
 earlycon=
 hibernate=
 intel_iommu=
 io_delay=
 pcie_*=


In some other cases such as pci=, mitigations=, spectre_v2_user= and
vsyscall= the sub-option is at a 1-2 tab distance and the description is
another 1-2 tabs from that.

Either way, in most places, I see the sub-option and description being
separated which is all I am requesting. (Pretty please?)

efi= and idle= has it similar to the way you have proposed for mce= but
I find it harder to read. (Maybe it's just me.)

