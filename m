Return-Path: <linux-kernel+bounces-178929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EDF8C5985
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A23D1F25058
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62D17F37F;
	Tue, 14 May 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtMRhD4Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5968D17F367
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703345; cv=fail; b=doOCKQERbSMjVDocMTU4xQWCkyWDdupSkalrD08EVybkjxnYwt+8zsIZ/worEx1UxanIdMNKmcjxHvR56jqKMiwAqcBrI4RHAt4OZ3LBPVOxKp/R3Rnq5BVNUNC8icoxS/qCDzC3CaLbv1Yhk8w6RzkHB3RDMrcOiFCHXpAktsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703345; c=relaxed/simple;
	bh=//2fFGdd/CWcNHI27Terbn5Yf4QmUpk/IeoeuVRbtP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LE9UWW+h2pTvNEJFfDUPsXvjCqXSTj8gQtaNrqPDCLHFp/8xzfM10sqNMU6YbXkDVfFt+tADoPqE7GzJG/BRTggo+SoYVpQiKMdl8TdB6pPKckkZ42nwO1TOsf+J/nQNBLFccJODzQf7Y/8mUPU9HXUq1NtPfdVMTtlK3oo+tTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtMRhD4Y; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715703343; x=1747239343;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=//2fFGdd/CWcNHI27Terbn5Yf4QmUpk/IeoeuVRbtP8=;
  b=jtMRhD4Yy/vxesSrt5FXtVyt+fXwSKkh5gJS+ATkqSooCY+q06XBkI6G
   akqsN0WGNtXo+8NpT/KVy03AkRSZJMfBfu6polCXHjteCJdYiuiLUhS5D
   ccW7YMxvKGyyYQQLH7qZDiOOn/FdBVK3CZS4EDjr47XxyuOtDyD+OZZ0a
   8kira0euNikB39jDex6bFzSW+y8b4iC4pFKuydSf9mqTE/Dc3ZGGWM4IM
   XdZY2b/Eybo4MZ8Rl6NYolieDloUICZQLK5c651TDMLpZOhtNX6YbZd+E
   l2UslHhgZ+bRrU+2A0xRYwWv5p9tukbkjFWxC0aYRz4XSP7LLRbpdRljQ
   g==;
X-CSE-ConnectionGUID: WhI/94ukQdOc8GpfGfaBig==
X-CSE-MsgGUID: dMzP8IaFSyilb2tIikVH5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22844264"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="22844264"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 09:15:30 -0700
X-CSE-ConnectionGUID: bjwRTAOvRqK+dEQCl82l/A==
X-CSE-MsgGUID: 87FQZPwBSwyvlZEzQbImkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35195812"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 09:15:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 09:15:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 09:15:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 09:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke8fLrx6zZc17ArbJzTVugEQD+XFN4A18oVxTjVKL4hEDYma0GMuK2LN1UDg6z55I9dgPGu+++OiQrGO3aokMAcM4SvH4LSjN2iiPfnvizyTxnHiCADyi7pfmgN1zLra7V+dwafKcLsa+KZetOjvkyDDZmDwbOS426BJ4TnfVcXfTRV2k9tFR0dDz9guYyt4a8BpKhYjuSsNvvkXDO16NM/CuWCtUdYy6PVAhemJHuJklpmRPoYu3Ct2gvX8kU6XYPq1M6QjQc4x4bjdNjv36nPmG35DuoROh2CnzCDeegU60nnOAQN5NR1HKJcT1blB53m3+hFFWuq3dfRlbhvkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DISHBA7brqAlV7U1ma1Wgx4dm94zI+qMEMgrOHPLRXo=;
 b=hJCk4uYooUxuJUQkH/BF7zp/GmyrkWRWt3nIie9iNS382ytgZEwSoy5lD6RESqNAisNTc5BRvbOfJ6OPKO0rp47Vi8xwWTbYkhJO8LZcFrA2eQcWPHUhhRsl6nkeJFGe7xFFyRzOnHxZMaEa7QhMXF2EmoLMMZh9iEnLR0z8VKKRnmFHzDZ53FQzs9MM6t4+dvW5GT5jiEwjdZuzItIESIfEvbj0nepUy/G20cqi3JVPxBt0gqxG4ysgxJrc1hD8MBfeGvRWpjwdf4HZtX6TeWSyfpAPHrzTperyp+76VQ82kFQiFfiaVWmudqsNCERaKZ0BlYJm5oBKZUMmCsLuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 16:15:25 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 16:15:25 +0000
Date: Wed, 15 May 2024 00:15:08 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <wuyun.abel@bytedance.com>,
	<tglx@linutronix.de>, <efault@gmx.de>, <tim.c.chen@intel.com>,
	<yu.c.chen.y@gmail.com>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Message-ID: <ZkOODAALS9HQ3B9A@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org>
 <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
 <422fc38c-6096-8804-17ce-1420661743e8@amd.com>
 <ZkMsf4Fz7/AFoQfC@chenyu5-mobl2>
 <f2eafde3-b9e8-afc9-8934-ca8e597c33e6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2eafde3-b9e8-afc9-8934-ca8e597c33e6@amd.com>
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW3PR11MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: af0533fe-f587-41ad-620d-08dc74311067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CpMI1EsBdY0sUaBStO8B8i32EYnH/iG2Lr4V2z10r4jO+MLSQtTOr1L0Qazh?=
 =?us-ascii?Q?iZ13FeL40Dq1PyLWV7JbqwJlCQ+fE1fue65md92Vm63ZCK2DJEJiHWuVxNK4?=
 =?us-ascii?Q?lIpQj/ppIu2A5rNIXoEhw/R+XWyr1ik8hs78C6NC8HfcAXT9IIFxtb+LBIms?=
 =?us-ascii?Q?DrEngwDTDI8VoTBES/SN+ptdeTn/sBd0RH9lPw0ewGJneIHNnLX4m3NXJSUx?=
 =?us-ascii?Q?RIGptGsqtOkYIJykvJZ3kUIMQtY/tReuzGFx1XNvMzfWXEISeDkleMlvP3T2?=
 =?us-ascii?Q?xwauud327h4D08s7vp0YlpaHxL3xil/Vovxz+fkWTiGmus+FNjyWnnKYtDMu?=
 =?us-ascii?Q?vO5sS+jtCmlHWNMoaGv5T+daJx23XTLHz/gu3u3AKv0tgM/fVzS6SYG4DRFn?=
 =?us-ascii?Q?sc57rl3iqdhaELYt4JN1NOZZx6w4Zx/4rHzM4sslqee8yip9/IX4MZZzQRBr?=
 =?us-ascii?Q?MKdnbtOl4urDNlmMlc7AuYXDYmSlmcmbSrYHG5LhbZ/aJrYSbJLVyFuUCtmO?=
 =?us-ascii?Q?P/BcoXWEZvnDinMiHHpBomO8pfKgH5eUAJjV5e862K6Jv3QUvFFKx9rpLZKG?=
 =?us-ascii?Q?rAeM5QoCNfpCO2rUsk0TboJAdYjgCYpQRHy5+Niv0QEWgxvEUDxD+tIIbggT?=
 =?us-ascii?Q?ZUvAd2S+lpKq+HFXT6gh5o3d2ayOxK54C3s6GBn9MNQAMVOLBzQ44GM4PvVH?=
 =?us-ascii?Q?YtVTk0zuz3Fk4VKYaGGW/g6O/O13M+XqDlWXZecKzEu93bnqUI50R0ylspar?=
 =?us-ascii?Q?ui8DOZ9ImbIkNzLrDZkAse9MKCsQeK4I84gmL1E/Ntk+s83+ZFErzA7A8GIM?=
 =?us-ascii?Q?rCqhcJ5dxRBnsfdk45LEZoXzMMaX45XwyGasSocpMpO7VcJI5LTbWZKcsrmq?=
 =?us-ascii?Q?GXK7ePxEa7Nfdwlz/6S2yxdSYgYFc8LD8JdetTO9R9SJHyeH6okmDhrVGw+T?=
 =?us-ascii?Q?gg5FiBqqOrO4/3cipo7CYizf5181DfQV8+b9KsvmpPMfE+XYgCj32sG6CIp1?=
 =?us-ascii?Q?6ZG4FkH4ua2fVRToreIIx88tNQOUeTCPSYswfUb2DNfsGT3fq5YOdWIeD8O1?=
 =?us-ascii?Q?3YhC8F3kWJBzJfvUy6LUpBAFqaNzcHuZN8SFEZNwy98a2vg4Bz4uLQUweeR1?=
 =?us-ascii?Q?2E3APjsv0cSGJCY7RelaAqQXYWNbPyJeCWLDT+DvMzbSKoADshaa3tAgZY9+?=
 =?us-ascii?Q?JtOV3vhKR5gqmSIdmbgaGJIG8tdca8r9iSif3IzOUZf7l4fkrkRxqWk2tw8u?=
 =?us-ascii?Q?4+XrR23HI/8gL0yXXds62RpQwoMIZApnY2uQfWTLSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f2FoBZoRgYh3OqPjVoZ0Co5tFylWGkrwg04X2ZEfRrcwSm318wS7jaTYesJ5?=
 =?us-ascii?Q?Kt8yM4xwLXgdqWgKBl4dOXNjxkoASswDF3RiKydJ/07Xax1np3EOQLj5vYil?=
 =?us-ascii?Q?HxPEPKP9trpjI3ZwR7mVdyeJUSlxhpfPc/MGKiFrtiQag1GqXawUNZdf0V35?=
 =?us-ascii?Q?oGSCvtWWiA2H2GJ/MFT+HZS/uwvdntfoTtYPA6UD+oeNeFkKMWzN0OdvDznJ?=
 =?us-ascii?Q?Pazy6zRYbvXFlGuLez8j8HpH9FfV/XN37dJ7dxmUCsVLT2CI4wzkB9Vi/i6L?=
 =?us-ascii?Q?bQKSvhKoRnSewy3LYB+bU8ywUVWVegikXSAqUjrSPyWLToozi4XMBREDOdnE?=
 =?us-ascii?Q?d+jtf8Ifj6ctxXR63DJPybQ4zUtfTZoWeA0RiAnhxCF18Q7YzdutEXdau+MB?=
 =?us-ascii?Q?zguWf9Re6jP0w7aIUGJCPk41qdTpCetzMFkU1XScgmxRb/AMptc1iwuXU4//?=
 =?us-ascii?Q?SFrgAXrVmq+x8UqikkNkeNH+zdBGx6viCYL+Zx+14aIUm/JEQtD/I1W2IhTv?=
 =?us-ascii?Q?2XLywcw3kr8TBMqrSLYb8HZR2UfcFJ4S8BhAn+lext++gfnxni4DO5qx8d4G?=
 =?us-ascii?Q?QKLb0LFncA2LYdwxY+1jJxOCUjJy1EBMZIC3LLfqGYuSC3CeD0K8YhmDsMG7?=
 =?us-ascii?Q?gRaIc9tPfNQaS1+UEA6jNap28ovWpYHJQNRhh9glhX3OOc8625CZHNZiHzzD?=
 =?us-ascii?Q?+95waWX8YzCxkPA9cD1wR06JohW4EoF3gF6MLIKgrJ1ertMkRxP5aGvIIV+z?=
 =?us-ascii?Q?LOl+06LneZsYAb7hBQ2YfK3ClaQw/pkBNgD9/BYGJ/JXsrGItVZ1UBhoHW8P?=
 =?us-ascii?Q?IP0tM60NCWMgw2vpuAeSSHfUouRjPvAtMm1DCLidaJCttRlA1mAcuOGbzmmj?=
 =?us-ascii?Q?hcOfnnX7kuKkrtjLI0UHwdNkXIncRPVmkKl1TN5oR/Alau5lDUG5T62UQAWa?=
 =?us-ascii?Q?AFkOzv6zz/3Ubg6fQNbCRde+PO1iYKiqCH3be+mPhX3P0OuVeu5cmlyTR078?=
 =?us-ascii?Q?JWaLjbYrHc7kQOMSh+is2k1500uMkIzkUVG6wNZ30VUMwjtjUEZrnHUzPopx?=
 =?us-ascii?Q?uGks8K1RgACtJUN30S/059h0Puiax1G7WqXfDIQ9fHJrBzhmMeghuAd6dDtT?=
 =?us-ascii?Q?JCIQyqolDcRoJGe2p9jxadyFufcLkV6iYV9BffMMXSwcVq49snVFXmTgXDGN?=
 =?us-ascii?Q?87SiL69hKOjf1Oo+gQb3OqY5SSSSjzXhQ+mp4EFBLz4aFmj94ctR+EpitoJt?=
 =?us-ascii?Q?h2ESKz5Kb8XapFmSrxeTpMrhb/3OvvdXc+NYo/itzZST8zLXCg+9VXRdMLX0?=
 =?us-ascii?Q?WOuYR2Gu7Ppae6GkmwyUa+jaEPeHTtUEjQWYJnqJU9rh+GOD2dyTCxduok1J?=
 =?us-ascii?Q?CmuVEL/OXL9kqSxQf/yyCvcEJ5sJ6j3ndeJJm4P3oUra7/e/W3ldBJzze5Y2?=
 =?us-ascii?Q?0qqFTHzh5LGATs/4/Ui32fr5hYP70KJgDLwStdfN6FRHo/AY/iC1ql3LK/nr?=
 =?us-ascii?Q?ohHBdAe4zXjPziyxXfBbcJxAlkWmfSj8UqFHEcIJc0zSPKdaviSndgGt3NCn?=
 =?us-ascii?Q?EDRs3CtIiShTPpUpPBR+ULwjvplFpxPUatNJD70X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af0533fe-f587-41ad-620d-08dc74311067
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 16:15:25.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5Y348Zhd+exRLuiJM2DXA/zrDThgaVjrvAMzRyfRAxvZIbaStH+Y8JGQfcG0O22t5ddSvtEq08hR8BSNpfm8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
X-OriginatorOrg: intel.com

On 2024-05-14 at 20:53:16 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 5/14/2024 2:48 PM, Chen Yu wrote:
> >>> [..snip..]
> >>>  /*
> >>>   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
> >>>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> >>> @@ -7384,10 +7402,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>  	if (sched_feat(SIS_UTIL)) {
> >>>  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> >>>  		if (sd_share) {
> >>> -			/* because !--nr is the condition to stop scan */> -			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> >>> +			nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan));
> >>>  			/* overloaded LLC is unlikely to have idle cpu/core */
> >>> -			if (nr == 1)
> >>> +			if (nr <= 0)
> >>
> >> I was wondering if this would preserve the current behavior with
> >> SIS_FAST toggled off? Since the implementation below still does a
> >> "--nr <= 0" , wouldn't it effectively visit one CPU less overall now?
> >>
> >> Have you tried something similar to the below hunk?
> >>
> >> 	/* because !--nr is the condition to stop scan */
> >> 	nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan)) + 1;
> >> 	if (nr == 1)
> >> 		return -1;
> >>
> > 
> > Yeah, right, to keep the scan depth consistent, the "+1" should be kept.
> >  
> >> I agree with Mike that looking at slice to limit scan-depth seems odd.
> >> My experience with netperf is that the workload cares more about the
> >> server-client being co-located on the closest cache domain and by
> >> limiting scan-depth using slice, this is indirectly achieved since all
> >> the wakeups carry the WF_SYNc flag.
> >>
> > 
> > Exactly. This is the original motivation.
> >  
> >> P.S. have you tried using the slice in __select_idle_cpu()? Similar to
> >> sched_idle_cpu() check, perhaps an additional sched_preempt_short_cpu()
> >> which compares rq->curr->se.slice with the waking task's slice and
> >> returs that cpu if SIS_SHORT can help run the workload quicker?
> > 
> > This is a good idea, it seems to be benefit PREEMPT_SHORT. If the customized
> > task slice is introduced, we can leverage this hint for latency related
> > optimization. Task wakeup is one thing, I can also think of other aspects,
> > like idle load balance, etc. I'm not sure what is the proper usage of the
> > task slice though, this is why I sent this RFC.
> > 
> >> Note:
> >> This will not work if the SIS scan itself is the largest overhead in the
> >> wakeup cycle and not the task placement itself. Previously during
> >> SIS_UTIL testing, to measure the overheads of scan vs placement, we
> >> would do a full scan but return the result that SIS_UTIL would have
> >> returned to determine the overhead of the search itself.
> >>
> > 
> > Regarding the task placement, do you mean the time between a task is enqueued
> > and picked up? Do you have any recommendation which workload can expose the
> > scan overhead most?
> 
> Sorry for not being clear here. From what I've observed in the past,
> there are two dimensions to slect_idle_sibling():
> 
> i)  Placement: Final CPU select_idle_sibling() returns
> ii) Search: Do we find an idle core/CPU in select_idle_sibling()
>

I see.
 
> In case of netperf, I've observed that i) is more important than ii)
> wherin a placement of client on same core/thread as that of the server
> results in better performance vs finding an idle CPU on a remote LLC.

How about placement of client on same core/thread vs finding an idle CPU
on a local LLC?

> For hackbench/tbench, when runqueues are under high utilization (~75%),
> reduction in search time ii) seems to be more beneficial.
>

I can understand that hackbench is idle-cpu sensitive because it is
MxN wakeup relationship and could result in task stacking easily. While
for tbench, it should be similar to netperf, not sure why it does not
fall into i) > ii) case. Is it because you were testing netperf TCP_RR(full-duplex)
and tbench is half-duplex(the former has stronger cache locality requirement)?

> There was also a wakeup from IPI / without IPI angle that I never quite
> got to the bottom of that Mathieu has highlighted last year. I'll go
> get some more data on that front and give your patch a try. Expect
> results in a couple of days. 

Sure, I'd be glad to try your patch.

thanks,
Chenyu

