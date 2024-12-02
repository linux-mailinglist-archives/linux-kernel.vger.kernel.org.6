Return-Path: <linux-kernel+bounces-428310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D920A9E0CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B12827E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E641DED5C;
	Mon,  2 Dec 2024 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A20ihgtB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3C1DF27F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169598; cv=fail; b=ilF6PuRY7/YHxEA5KOqs8vWQCuIPAAVXQAdMuvl4aEdDiK26Rw7hV0CExxZyWFMZ7qkkPShmm4VfY9FqX84YDfBEWktaJ/E55aVs/rFJ4MvcJTotITlxepaV1/wVOTKsc4AJxTaXCtq66nJLZOrwckOMk3bGxPxYlEqCNLieOSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169598; c=relaxed/simple;
	bh=V0E299MVZ2vV+qyBTEVyA9cHVJMQf3Ok4NclFviHDfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hO08FdQRo3QCxvQPdqeiMnctT5MfD1T1gXEIn5b9HJHWCIt9YhRPcLVYoulxF34nRq+8b6tfMo57DQmknZaa7MOjSvgdwt0hKf0fxKb8MjQMyNPTXsNDqxFchwkk4u3eShGHFxAcf5DFXlfOCJPiDk25PEd7gcLNUYE9j1cWHEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A20ihgtB; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733169597; x=1764705597;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V0E299MVZ2vV+qyBTEVyA9cHVJMQf3Ok4NclFviHDfE=;
  b=A20ihgtBO8aJYJCNVM12fRrwxnDLjkdB1lCyQXDdcDc2khJeCG/rWt21
   SBeAtzypzWtK4zXpIxN/BGNsV/1i8N1gAncghOtvA2zFzOxc+/UyJqagF
   epV41lLSkvWOkT8Alu0dxx8wNXyIsm6ppTJXq3JlmCnVi+pnzeFgYZfaF
   qEmVSVA92klMgdyr0JX+s7V/W+rq1m3IqnVJwlMJcOO6uhR3loQk8PX6L
   m2W8Rc5gSg9SczBO4DgJBRba6OgX8u5dXp3MiAwzzvMmBUoU//SjgVy2i
   OPrDt9nOTAkdtzTJ2xifuY1WvBtKra44r0j/fbSNIu+qyKhteJYpN3VI9
   Q==;
X-CSE-ConnectionGUID: 8w8GrtwjTiCGfoGvUBTYQg==
X-CSE-MsgGUID: L6FxqBd/S0mHs/BAuaF9yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50879799"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="50879799"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:59:56 -0800
X-CSE-ConnectionGUID: jy4QR/hDS2ui+tDSlfbdLg==
X-CSE-MsgGUID: as7P1DZET9qfjCb755p5Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93302728"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 11:59:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 11:59:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:59:55 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 11:59:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh/Ri0e2MmaQXB5j/9AgWm/N88C8l8EIGeCf4bWpviEWFDiGJIEx8meriGVn8DgTV8vdR3lnIqPq9m9j/PDQdo1tgXh9F8uBUC0hE2rVRXrrYt5/2QvSk6R2seigLv3NYCuVheVKuali+jnDrQp3qHsjFjlQbhZef70yw7olqSyjb/wYEdYxuFheUzMVqMX645R5Rbt+ZoVCPDVR/W0Md0VYa2qClpe3rMu6ADmoQatRR/UnQefXKLY6+rGs5JiFQbsvyiM/a4augoRO0GP6oJhqvPJGtN0wAVgBhjjQox0xlIW08sdHXBC3JmDxrWv+OXLYtLpYYjbspXp8VSo6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DApxYorwVH4m3r6b1q1ZlBnunLvS33nnlWbPN+tx0qk=;
 b=sX6BcMgJGgOW+wBw5lpxBFihYYq2nTH+lMYKEu/cds+PoS4/bPqLhXgcdciF8wX4GIsmxXJta3QTI3mU/Yg9ocnrrd4w5Xe1IxU6xjrzDMPuUP5I+Wf6M9bzt3Phi4taK4b/A6vAuCqhiHsz0zk6X+R6yHUf+gBsDDOjX1F396YpfR4fq+j2woxQvAXOLX5Kzf8GjhEv5bqbtbV0H+TVLNzapY0XTIKqY7Q364ESrlZDuiKakBI6nzU1sJU/N9rBinkoMEvnP9pi7Zhp/AbUDrjqBQXp19ozR262QZl9kYNfuNKCUjIMXDRNNHGITZLdsyxcbn1o79+5tRyfbFlOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH3PR11MB7724.namprd11.prod.outlook.com (2603:10b6:610:123::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 2 Dec
 2024 19:59:52 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8158.017; Mon, 2 Dec 2024
 19:59:51 +0000
Message-ID: <96ed8262-2b4f-437b-bb10-77dc9c23718f@intel.com>
Date: Mon, 2 Dec 2024 11:59:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/apic: Remove "disablelapic" cmdline option
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)"
	<bp@alien8.de>
References: <20241202190011.11979-1-bp@kernel.org>
 <20241202190011.11979-2-bp@kernel.org>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241202190011.11979-2-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH3PR11MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: 654805f8-fcf7-439c-c2f5-08dd130be1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THVNUlB1NjBLcHVFM0tod3VQckFDK1REVGZXZTl0clRIejRjMEVrZjBmQi9C?=
 =?utf-8?B?amxibWVuQ0gwV24vNkZTbHh3ejJJeTEzV21kUzRmb0NYdVl5d2dRRzRRbTVo?=
 =?utf-8?B?WlJKRWg1Q3RTRC9EWFNTWFBmbStHWEU5L2JMWTBBYTlPTldMVUVTLy9PdFcy?=
 =?utf-8?B?MlZ4NXhHMG44anFWM3d3VFQ0R3BHQU5VU0o5V1UzSzFqYkgvWFBweXpyWC9E?=
 =?utf-8?B?UTV1QWdqRFVxZEo4RksxSGpGT1YrYkpDVVc1MkJiTkFPVWp1VEpLUGw5Y1hG?=
 =?utf-8?B?UUo5bHhIVENTL1JMc3dBdnB4US9GdDEwTlYzVkFBbmdDdVkzbzI4QklJRlA1?=
 =?utf-8?B?Y0hHazZuUUp0SUhXeC8wYjVvVWhXSzVvYkZVTTdueUxlMVFCSTFGSXVKRDky?=
 =?utf-8?B?VlJCNkU0VG1NaEtNMDMwaDM3U09TellxNERsKzJvb1krYmxhQlJzZUNFY05v?=
 =?utf-8?B?T0t5K0hjL0R5cjNhbEZSbXRPclpxb0tFeFgvZDBGVXNOckV0aWJkbHdGNUxI?=
 =?utf-8?B?NVdERGsrRVNWbTRrVFVVdjgrbHNHbTc0cm5wZ3ZCYllENVhtaGZZdFZOWDNX?=
 =?utf-8?B?SGpuZVdxYlNpNFRHaStabEpQSEF2SHpEaXozZ2pWU1Nmd0xhbzJDbFRuZXZj?=
 =?utf-8?B?cHNCUzA4aHZjdDRWMzBkaHI0MW80YTlvbmsvSVBVamlGdHJTL0FFZkU0ZUQy?=
 =?utf-8?B?TzQwTVRlUVF3TDA5V0lmb0NNQUJXWFRVMUw2N09vc1pPOUVISUFpWjZKUFBF?=
 =?utf-8?B?K2dEaFRWaXh3U1FMTG56cytxMXpBSnBtWmxlSVVzKzZZN0FSWWROenJ5QUdh?=
 =?utf-8?B?eC9YVHlDVjRGUVlSSy9NQWZXYUV6ZGNreW1qK1p1OXlWQjBXT2dORVFnOWx5?=
 =?utf-8?B?MU1SQVQ2ZzREcWpUS1RxaURqbHdydGF4UHJpU3p1eUh1Tk5CSnBCa3hVNFlK?=
 =?utf-8?B?a2E2eUdaeGlabTlpL1p5Uk1CMngrc0F3eEdlbVJCNVJqaFFkM2h5Z1NuVE4z?=
 =?utf-8?B?WE9DQ0prRmt2Wmh4M0NjZExDeGEwclY5NXY4V0lNbjlrdVZsMDE5VzZyT1lC?=
 =?utf-8?B?QzVlQ1NVOW5lWTNCV0Y0MUhGQUgxckFaWnhEV1RqeXV3Qm9FbjIyMGQvVHZo?=
 =?utf-8?B?d2VPYlZ3NzUyOEh0N3F1VVlkekwySEdIOEQrYzBhblFjSmYzbnl6UTluWlV6?=
 =?utf-8?B?NEFRdjdVempRby9pVDRoU2JFNXNCOEl6Rm9OcGJDREh0UHIxV0xYTW5ONGVI?=
 =?utf-8?B?UDc4VURFbGRpYnVDVnpPMHlYMUdNdFhNa1JUTTZ2SWwwU0psYkpwbThkaWJE?=
 =?utf-8?B?eVFCQ2NsVTV2UXVsRVhza21oWVFVcHZvZVpOeTMvYzRZZitDYmk5ZkJxYVEx?=
 =?utf-8?B?bzFrcitJQU1PNU1YK2J4akcxbkVsWFpOUFhtV2hCaTZjaVNoR0MrdndLaGJE?=
 =?utf-8?B?U1NPS0ZaRHh5aUFKVUNVYXNhbG9neGpjYktYL2Y2Q1dyZ281cEpvSFE5anpH?=
 =?utf-8?B?RjdsVjhMTkZIUGc3SnlNVkVYQkNjUWM4SUMyeWR2Qmw3L3lmNmZjdmlrRlNO?=
 =?utf-8?B?M1ZkNGRyQ2RZeHpYS0hBV3dHUnduVEpsd3hGdjZaTitTUkFhaXQzV0tnb2hS?=
 =?utf-8?B?Vys0eVJvdlFHWHhMUlFGeVpsdmJ6RG8wemxBWjhkNzczdTNmczhydzVyT0dN?=
 =?utf-8?B?V1ZwSlFzelpXTXY1MzNlc2tnK1V4ak9DRmhzMGc4aU4zUWZQQ3QyaEw3VllC?=
 =?utf-8?B?WitnUElKeHRQdkRhZHRPR1dOQWpjZ3BXbU03ellJYVJoQVZ4RVE0WDQ5WTVM?=
 =?utf-8?B?NzB6OGhiOWViVTl3bEV1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9LNnBFcndDQ1hQZGlIR0VIWXNBQkJtL1RUVGJ0Ym0vaGRhRHJmVlhnMWdm?=
 =?utf-8?B?enZXa0hFS3EvdUJuRXgwb1hqeG5wUU1zU3VoNUp1U2FWS0hTYXRxZ1hsS2Vm?=
 =?utf-8?B?S0JFeTRzYWVjWUxQd3ZLbk9maDlIeER4Rnd6WEhIQXAzWG9NZjQ0S0NUK3FO?=
 =?utf-8?B?cFlGSWgyb2FSamozVm1Sb09IRkdFRUdjVG5zSzR0WVhhSklSY1EwRzFWb293?=
 =?utf-8?B?SzdRNkw2M1VwWTZsSlQwdVhzdmp5OFpqWkVCWDE0V2Q3eXE3QVpoMnMzL1Jv?=
 =?utf-8?B?YVFVdlpLUUYrbFB2dVlJUHh4TkQ5MW16UTZoMHBzT2lOaTF1RjFvN1lSdC8y?=
 =?utf-8?B?bUlTYXlZYmh0U2tJM2dUaXY1UDdsYUJyMHc3ZjhZUk1kY21vS1p4SFBERDIy?=
 =?utf-8?B?dXFIZjN4emIrV1JDVWl2WmwzemhRdWdQUU5MTUd0anJqZFcwNUV0dVZPZ3hO?=
 =?utf-8?B?WmF2bUlGdmlieWtMaUJJbE14cnFkU0VOSXNuYjk3S21WRTZ6c3ZJNzlZUDFD?=
 =?utf-8?B?bitBMjJHU3pDWm5VU3h1TXBTSTZ4SXc1ZHNoSTRwYk1MeWFvK0dLem85NUhL?=
 =?utf-8?B?S09ZL1QrTjUzc0xMOXhRMFBzYWNOMHVNcDFXSXcrK1FjbVo5U0JIT0orMjU0?=
 =?utf-8?B?dmowZEV3RHg1WHo4VUNtZS9zZktPT2lQNFNKYk9hYTFCT1BIMHVuUktxTnoz?=
 =?utf-8?B?QTFTNy9VWXpXUnEvQVR1bWErWWNhTHM1ZXhZRWNLeUxSWGZLcFZsa1FPYm0w?=
 =?utf-8?B?NjFLZm9FUWc0cGQ0Q094NzFtWEl1T3RqTDVkMFhtWWh3ZGoxYkk3N3F0TlhZ?=
 =?utf-8?B?dXlsNXoxNTdWQmJhUVZLbFZDZmp0Q25mMDFCNXFVMHpucVI4UVdxL0dTMG5t?=
 =?utf-8?B?dUhqWHJPSU9TMWJoUEtGVmoyVmNzNlk0Nm9LMmR4RVZyVlNnS0FpY2Zuci9r?=
 =?utf-8?B?ZUh4S21GTmt1NjVSN1o3K3VWSERUczd3RkxmaldUam5sVUNVY3Q3UkJLNU9o?=
 =?utf-8?B?NlNhMWZIWTQyeldBTXUya25qRmdONFNsOFl1bmxtMmI0eHkxa0k3UmRWUTkx?=
 =?utf-8?B?bmxMUTAyV1RXaFZ0VUxmUlZoZlBWM01QbnRwV1R6bDRqUnErMkY0cVd5MG4v?=
 =?utf-8?B?UUNjRU9Kd1hUUGpXUkErNWZHTURwakQ5SzhpQ01VNUVRcGhVdWVtNmZIdjRW?=
 =?utf-8?B?NDRndEgrR0JQTFFOMTFVaU9QVDJwVUMyNVVpdXVSMlRIQTNpNThjeXhYbFY1?=
 =?utf-8?B?eHdENXZFSnRJSDFVS0FTWVJMUFB6eDFFUC8xSEVpMjlsZjNHZEVvS0JvY1FZ?=
 =?utf-8?B?TVBDOTRuZm5mcllJZkJEOHZsODhSd3lWaFpsZlBZN0hJanN1T1JNQmlzMWZh?=
 =?utf-8?B?T0p4U1N0VGJVVmhjdXVNeGFKbWR4SUY2QlVSa2RlaHlpMkpudXVrd25rQXl3?=
 =?utf-8?B?NlpVcnk3SUdzRENWNDJkUGltWHY0NmluV3hrNllXaXZ1Q2wxanpLVHpsVUhj?=
 =?utf-8?B?OEIrb3FyWE0xeklLck5LSERyV2pHaisxWCtrZ3pjMUdmTEo1KzNzUy9mdWc0?=
 =?utf-8?B?Q2NEcHNra1JBK3dsTEZEL0l1VDZIdjl3eG9RTVpFWGFwWDkrMXNnamJBeEVa?=
 =?utf-8?B?TmptYVpxU1BjMDQrRkl5TmFucFNjYk96aGQ5ZDkzTnpoR1pDdlBZMGNvc1Rq?=
 =?utf-8?B?N2RCNldLTElGMUNmUVlxZjZheG5FWkI4eVc2THRUUXZ5TzZJQWpLZGtCaVB1?=
 =?utf-8?B?OVRrSmw5N1pSMDdDcDAvSnhHTmdEWVNhYzYvN2h5STlFUGp1eHRlWE5uaGx4?=
 =?utf-8?B?bGQ4cTF1MzM2S3diZ2Y0VlpXUlJiVUZic1hmOWtpS3VOdTlweGpHam9wZkR2?=
 =?utf-8?B?NkF1RUZPaDA1UVVqc3cwKytnM3FDbVA0cXpLNlkydVZDY0RnY0lpYk90dHFo?=
 =?utf-8?B?cXNVNW90bnErSzhUOFJkalJYZ0o0MFdORzF0RVpDclZkSDdJV2hoanBnN3lX?=
 =?utf-8?B?UkR5MFVjc1pPL3dBTmVzMUhOYjFSWmFSdkF0blVkL2NSN0UxSjBRWG9pbHIv?=
 =?utf-8?B?OWxFU25CZU9jaklRblQyOVZhcmg4Zmo2K3doaEU2bUwrV2g2enYxTTV4bFRS?=
 =?utf-8?Q?oXZ687SUbBr2oWHOx9HYxxWvH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 654805f8-fcf7-439c-c2f5-08dd130be1c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 19:59:51.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtZkSghhkWeGd56Sw/yUTl5GHQfTyeKgrnPsOTfAfbRuAN+aMtdLnW0KQ1h0y5Rtvjq6kSTEM8qrrd2eNRelTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7724
X-OriginatorOrg: intel.com

On 12/2/2024 11:00 AM, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> The convention is "no<something>" and there already is "nolapic". Drop
> the disable one.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/kernel/apic/apic.c    | 9 +--------
>  arch/x86/kernel/cpu/topology.c | 2 +-
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

