Return-Path: <linux-kernel+bounces-522682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8398A3CD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164B07A6676
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C631DE4D0;
	Wed, 19 Feb 2025 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmK6kSr6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5341BCA0F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006998; cv=fail; b=q6Uqt0CN00AiaoiTNuPCyDjKgicVmwb8gcgoOaEOf1aZxOd8GjiobcM6Y52ISZWbqBU08jwg4cZxUAmPBQPXPcAo07pnODhteY9ynTqaeIdtN5y33z2b200VNOvc2YYUvhM3ck0LoiSqtcnrW682i8JU4I3E57npnS10byEoKhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006998; c=relaxed/simple;
	bh=nEzOwD2jXkVl+W5KbzKzuStQ/Fl31ohJcJMYRf0rEe4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ERX8KyweP6EJOxU8lAWPhNIkg8IPg33pNheWyOe4e4J6CslZV+ZegyK9TYwq9J2oLWqQGfMEkN1mC86DnAeuhLavAsDD6o9zkxnkZ/Nccra8L/lTBr5X6Q9aTxPkEB5ZPEwyXZRq3bvgJ/oNEtD7G2h6q9mK+g8tA1895Jho+9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmK6kSr6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740006997; x=1771542997;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nEzOwD2jXkVl+W5KbzKzuStQ/Fl31ohJcJMYRf0rEe4=;
  b=KmK6kSr6GlnAzI1VH2bK3RXcNPNc7PUEQJjTyXJuHzPPUMO8PDJNtJVl
   rVyDPiRSxA/7hwr1ExfYmvyqKJUKVg3UqksLnDxNslSh0IAESzIrs/8zl
   c8l8HVxIwalvNapXLkc/Ipeb+ZilDaCUySXeuxTUK+e01oAjayH50QkkG
   Qx4uHdJHO1Yk+BZHmqC3DIlxmwlOdbv9NdAxCdzpzPBWd2UEa5zD2zNVw
   wsUW09xvgJABSuIDkYN0gHj+cZ8v9FBvjy3qvGXg9BFdVND0+15k6iLNr
   XODBaO09/jvwyBiJJlBCYnPGJpzZOr463efLj6hyTww3RCQRuHkO5XO7D
   g==;
X-CSE-ConnectionGUID: AJlpBzNRT2OHrMe1T1z1Ng==
X-CSE-MsgGUID: ZMGana+sSdyCoBTF30b5Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40689190"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40689190"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:16:17 -0800
X-CSE-ConnectionGUID: P6mA2xXhRGWeL3+q/9tbzw==
X-CSE-MsgGUID: 57iyOhJsReSC+TA3CcimZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114809787"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:13:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 15:13:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:13:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:13:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwLPw9RStCFyA+mGiKdqaIG3BV68aX/jEm5ETPqL8aOQlaV47SavNt10HLcdr3vb8DMDtVQSR5Ol3vc68PqFvfE++NLpR758MYNLn0YqTdWu8NX5+ziFo5NSIu8Z0pkEbi9axOJL3lVvzmwURVupna/tSEjSPWzvltAR9o1v+j7TxeuLsvRenaA8icl0oZjKdv6GhI5soIlgEQ/zoDa2IpKnDqJK5qU2R28etGPkq1GVWJEzNnGseTqnKn6bjuRokxP5v7K/g6NevP42HUFSeGFq1iRxw0dAr9run2g3LFsxcd9NPaH1whD1g2U7JzSQB0MDive8GMCwi8gxM8K3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uua5gVbvqR90qjYH1C48+EMQZ5ZZzg599X2pePS7DQ8=;
 b=RZVqVG4fgNNBG2TlP36iU0VxwphUH08QXk3szajyrxl9tP0kJIV7d54SKljGaT6DppLp6L/FFzuA4BPPxYxvyncYuI8LP1Bn7VASeim90JoP3LLOGvFPktGQyur+8iF6WFEecQC53dDEcGz5FqjJBKCChtTYH5CwBbKqIsh5/hR2C6LHhNeDiBqmciuuSTWhQet8S7uAyoe8Yke6rp1VT2f+dpCu0I7k0H9oU1Q8oLCVLqr1vZUkGWbrFbAawNmpvkTGClXDColD7BRXrsfK5422nU0uzb+ANm6qOvoxXeT9v/lFPy/PUCU9qm3K0Y4iPZT4GUpZm0p9uIjaVtFe/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6674.namprd11.prod.outlook.com (2603:10b6:510:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 23:13:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:13:11 +0000
Message-ID: <3d28f232-2da7-47ca-bbdb-d76fc951349d@intel.com>
Date: Wed, 19 Feb 2025 15:13:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/42] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-11-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-11-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e72e74-9cd4-4a73-ea21-08dd513afa89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmlHdzdPdkxiOVVvbFhrTXZYT2JlQmpnUStkekxOQWN4dDJnbUM0ckR2RzBM?=
 =?utf-8?B?T1QrNExKU0w5Sy9HMTBhM0x1ZXZJVDVBWmlNMWI0ZkFiK2pDeFhCR0wxOHc0?=
 =?utf-8?B?ZkNOS3ZZQSs3SkFoK0NEVGk0a0VzSzJ3cEtLMUg3QUFobXpCMjNjTHcweU5Z?=
 =?utf-8?B?Nkl0QU0vcEprRjI0OVhWNDd6MG43U1pSMWZjbkdielNyV2Npak5kWEdhZU1y?=
 =?utf-8?B?YUlMMTV3QzA0eUE5VlBybnBlc3FBMnpiSjFKUkp1VHcyMld6SzErNFFHa3RB?=
 =?utf-8?B?bU1rMTVvTFBKZFpPZlozQWM0Z3FUK0Y1NVF0WW43TUIwQjM1S2EwOGVIR25U?=
 =?utf-8?B?Sllhb09kZzBmaUpGeEZJM1A3Ti8rT1JjU1NjQXVuTkxKelVwNHlZUGRCeDdq?=
 =?utf-8?B?SHJhVSthd0djMTBoblRENE5vZk5zVGFYajlybGU5eFFqaG5oZVJ2UlhYWHhv?=
 =?utf-8?B?cmt3U042NXZvYlJzQ0oyNDNVSTdlWHg4c1hUa3Q3dENwazJxeUYxZnM3TnN6?=
 =?utf-8?B?Y1hTbzZmVFlKSEhJbWJmR2VWYU01Ym1tTVFrcFpiSWM1Skd1MlJpUG5BeGk0?=
 =?utf-8?B?TTB1YlFuaFBCSHFjSStycGpaMXZGTXoyM2J2bGFPUDVyNXE2VHcvVmFpaEJy?=
 =?utf-8?B?RGdZWnlkWDlDQWE0UGwyeDg3VTVLOUhDME5pUmJPN3dzMWR5S0RhbnFZeEFY?=
 =?utf-8?B?ZjFldU1hUzhnd3ZObGpWVjljL0hlMUdWYUJFalB4Y1B1RlVjbFJrUjVSV1JI?=
 =?utf-8?B?ZWlCZGIwYnMxbUtrRkhxYjViVzlTcDdMWkVzVUNHeFZNMU1rMlorc2k1b3ow?=
 =?utf-8?B?NVRkc3BaQkpaWENhZWVMZHkvYUswQWM1Yk12TEQ3VVJUb2UvcFhXL2tvUUdJ?=
 =?utf-8?B?RUZRQ0ZxZEJwRGRVa3JTUCtDN09tYUhWdXMzU3dqTmFJYTNiY0M4Y016WVFv?=
 =?utf-8?B?RUpzekYzVVRVZE4yb3ZGQnRFZUx0bWhBK1RvQ2lxcUJhWFFIK1FtYzY0OEZV?=
 =?utf-8?B?citVK2p4SmZJa2xhSUxlYmdkVGpndVlsVFpDUVJ6K1lUSlZWS1dDZ1RNb01X?=
 =?utf-8?B?cXYvVy9zN2pDT3Z6alJHZk5SZXFPNDk3VTFhbnZXMTV0WU1ZaEJhSmZMSDk5?=
 =?utf-8?B?RVlLODI2dzhuUjNWQTZxVU84ZGFoQWJhMDVzOExQOEg2c0hCSVh4eVVIRWRl?=
 =?utf-8?B?Ni9EUC9EekkrVDNBSENxZk9ZaHpnNFRCZmZyR01iWEp4STZlNWtoSG41RTlG?=
 =?utf-8?B?ajFkTkx2S3NSMGtUSCtZR21rbGx2QWxzYXFoWmtzSElQREtvWmR4Ujd6QXVr?=
 =?utf-8?B?SXk3M0wzVVFKSFpNdldXQVl1Rlc2b01Fa0cySHVYYnNlSTRoMjZIL1FLblJQ?=
 =?utf-8?B?UjNWYXQ4OFFNbytxWE4yUDlhMVRlTUJIeGlVSmdZUGRHUnNrTWh1NzN0WFRO?=
 =?utf-8?B?Wm04eUdqRmtWalF2a2dCTDFORmQ5WVBQcFJ1YlVrVW5IQmRpOW51L2ttYVcy?=
 =?utf-8?B?Z1ptdHIwVk05clROY045TTlNUmhZUVJtSzhXMmxUY2JnWmlYenJlbmRMYzh5?=
 =?utf-8?B?bXdaaDdKRnFhUXk3NXA4THFsNmYxdk5FZC8yK29XTWd2dk9FKzUyMFBkYTlx?=
 =?utf-8?B?VEpKOU0rWGlrRnlmOHVYdCtMZ0cycVowWUpYQURVM3hCcFFrenMxOG1zVmhK?=
 =?utf-8?B?SVFOek9wRHdHd01Wcnd2czVIeTJpejZxNGJudlk4MnBDVHNtbE1IMFVDNkdV?=
 =?utf-8?B?Q0NGTFNORXJ1MjZMTUtCYS9mZkxmZzF1ZURTL1NEb0k2TnVESjN3MnBJbm52?=
 =?utf-8?B?bHZGYkpjb3VFUEk0QkZ4Q05JZHZsZFVYdWtyb084dTNhU1RrbjI4algvQlh6?=
 =?utf-8?Q?qzACULeiXLca0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhPaXJKMHkrSXJWSnliZjRFZ3pVMnd4N09VZ1lrcHd2dW9CbVZSNUZBWXZD?=
 =?utf-8?B?cjNrWGlCWHQ1cmpWYmdTRmhKbDNBQXVSenB6cFZsTjIvaUswTmxMVUEzUkRV?=
 =?utf-8?B?WnZWbkxBMnNnVXBTNlFzS21iM0x3T3pZZk9VdlJaVXg4T0dWU3hBajZwMHh6?=
 =?utf-8?B?ZVpZTkF4THNTL1M4U0ZHeHVBR0NqT1dVK216L1hkTFM1NEtnU2ozUy9iVlhk?=
 =?utf-8?B?dU9jeVczVkIwblJhSVFKZ2JpSFFCQ2JjbVBSVUdSbkp1dWRuUzlWUkJpL3hI?=
 =?utf-8?B?cGlSUnZ1VjVzRTJDSnlJalE1amliaGcxaHRjZFFNREJXb09iQzdOd2c3Q2pn?=
 =?utf-8?B?akwxQkxQUllzQjlIZFF6ZXBWdnFqV0JsaDZZUUM0MzhRWDJuak5ta0pvRUpU?=
 =?utf-8?B?OGtJL2hRV0NOamhaOTVCZGlIaWU5M0oxWklHckcxZGdJUjZyNjZMVWlLdnhm?=
 =?utf-8?B?aXh2RHhsN3FhaG5ONlZDWnY1MSt1UXZNY2FsQUtLNlRVSlcrV0Y3SnJKaWwx?=
 =?utf-8?B?R2ViS0VidXlMdU9DUGlDMEhwL0N0N2tzSnlQUXM0eDA2WFh4a0NhVVdFL09O?=
 =?utf-8?B?aXpCQVhoMU4wWXNLTm13RXVlUDUrSmdtaTNiWHh0RG84Q3ZlRHhiY3hDajkv?=
 =?utf-8?B?RHFrSlVBcjNTRlByZWlHTFhUVmllekRsOGdYWmpPb1dhNTJtS2trZWQ1QXVO?=
 =?utf-8?B?V2VLYmNlYllFSjI0YTY4YlJ3RzFnRDRJQTI4NGlUcWpJeWo0VTJZYlpucEJ4?=
 =?utf-8?B?Q2prZ1BCbks0N3U2RjVSR05oRmlyODVRWmtuVHlYN014OWh1c3huaytxRlpv?=
 =?utf-8?B?N1IzZWpzV1RFbjh3RWF4N05DOVlCak5pTWpBN2owclh1M2YrVXIwSFVGcHlL?=
 =?utf-8?B?MnRIWXFKWGVNUng5bmhWbnQrNmIzUmZLR1k2KzZ0V0paV015NUV2RzM5aHZs?=
 =?utf-8?B?dGtoSkxmN1ppRU85ejMrZUhHY1l1R0ZvTlRCQlp6emVDclVNYzBlaWl5L2NQ?=
 =?utf-8?B?b1kwQ1pNSmN0aTVPT0xQT09FS3RhTWNxY1RsOU81NkJ0UXBQVTE0QXJoMEZY?=
 =?utf-8?B?WUhRSkFnVUhYaEVCcFR5NmpyVnJmSEZ5R1lpMGhhRlc4N21uMFUxaEdydVlr?=
 =?utf-8?B?K0tMdGxvU0J0WlBzSTZ3eHRQb25SajlXZDlQWUlsR0R3RTBER0NWT0VONGtu?=
 =?utf-8?B?OEh5aXRnSE5rQ2NiSkkrZWZSTWkxKzY4UkRydXoyM3hyK2puN1ZDS3hJTkti?=
 =?utf-8?B?dGhWWmtIYjM2NlRUN1B3R1ZzWGJuTXE4SGhqR0R4SDBNN293aHFCcTJNTVl4?=
 =?utf-8?B?VEZZNVZBaTIvamlQcUkzVmRmYnlHbFJrOTBXZHFrUTdUZWNFSWNpWmJMRko5?=
 =?utf-8?B?aTZBWm5WU2NwRGo5a2ZsMGlMU1lpeWtJOWVpQm1HVHJwWTZPbUpwbFIwNUJq?=
 =?utf-8?B?Z2VnL09wRVlrOG9VdURFZUw5VE12aC81UzNyZzRsOVlWU1M4QzJhZWh0cXVB?=
 =?utf-8?B?OWU0VXlVL0tJSFI2TTVQTzlJQkZmRkd0UUEvbHc3bmlUZnd3SVFXNWdaYmtB?=
 =?utf-8?B?cWd2bDd4dE5YMDk1RVNYQ0tRanI4Rkp3VDlmWlBOZEZoRUtteVNJeHFPemZD?=
 =?utf-8?B?ejBiN0FIcVB4VDJHUjNRd0pPTU03T05QVXhTZVhBQ0FURGlUWXR5VGdtdlNh?=
 =?utf-8?B?Rm1BQjlLeVowVDVhZHkrUG5Wc2R6MTZKc3pCUEFPTkVTTFJMS2VVTk94cnc3?=
 =?utf-8?B?Wk9tUEljRU1KUkN3TUg4WklRWEhtcHZrOEo1bWM5SGdvNVZLeXhteFVIenhx?=
 =?utf-8?B?N3RVRUZoZ1BkV21yRC82VitxRjY3SXhROHo2OGxDZFdaQU8yYm1lTThIVk11?=
 =?utf-8?B?YW9mdHJ2YTVVWkh3eW5OSHhaUlJSU2VVNWk3RmVJWmphbWhmcmJURFVON3ZD?=
 =?utf-8?B?Z1c2YkJnZ0JUMkFkeGZTRWtSMVYvNE41WkcwbElEYXp1SWtiZ05QWDlxdXcv?=
 =?utf-8?B?V000OGNSbG9LcXlsVEVqdWZDRzU1SW52SlUvNEdnZVlnLzB4R3dxaUVOVVJh?=
 =?utf-8?B?RzkySVRhUWtqb2pISDFEOUZwQ2hNeFExeUtRbGlNcVkvemM4N3FSeVNzYUxw?=
 =?utf-8?B?dWhYK3hMRVNBbkNERFNJcVNkT2dyRE84MWZmU1d5eFovS2tLVHU0b1lFRUFC?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e72e74-9cd4-4a73-ea21-08dd513afa89
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:13:11.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLceOQ1UNSRZjmrSrz6Jows0S1ac4X29vTtoirmXAlDQnKtOmLq/ekKwScF44lWfMeuXya1wvKOxJBUpe50fdSvm+IkBrwxWgQf/ffUgQto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6674
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> it uses to update the local CPUs default pqr values. This is a problem
> once the resctrl parts move out to /fs/, as the arch code cannot
> poke around inside struct rdtgroup.
> 
> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> to be used as the target of an IPI, and pass the effective CLOSID
> and RMID in a new struct.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

