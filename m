Return-Path: <linux-kernel+bounces-406782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC8B9C63E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B701F22B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD99219E36;
	Tue, 12 Nov 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ok4G4Fsm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E020ADED
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731448809; cv=fail; b=MBFMNZ64xfD+seQPrYvLCXoA2aPW2L0Z5tIe2Froqox2SJCiqnOa1kvP6kB4i+/j+XQgCm64Kz/MUrtfu1Wq600sU0MsgVScHxGffvHbDOkVdx6ZoybM7zWH/8/XMAQuFHHY9zqzW5EPkKr86ITZ0MBjLD95yWJ2M2lLgGXNUTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731448809; c=relaxed/simple;
	bh=9kFRCQmTAYcby7gHs4IAkiGlAt2eVxgaMwaBvlCEX7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RyL5SS46Vy+s+OmWWkF62CwwEDOs8NncwpaSp8ZDAyXQ3zChQ647mZOusppxlyMcVCXMCSGzFtQzDhMTQN0pad2kujeeCYAcjbN/TZv5tPI5wnUmY1vvMPfh5w6yJyv+roqAWNQHF6148ERH8A/K19+0LAM2s1XuS9CpaG9G7EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ok4G4Fsm; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731448808; x=1762984808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9kFRCQmTAYcby7gHs4IAkiGlAt2eVxgaMwaBvlCEX7c=;
  b=Ok4G4FsmInG9jchVvFNCW1bNUxu4bqJt10zleMSQbWPktuBVTOwPCac4
   2LmjPQ6rvyajwDMrVXgwCGQR8D2jD4XzZ6ESrTPu5WkEOO8lTzuiu7fwq
   jljP7LqFWkuvh6Ic06B4ZdHBGfnh+dJOxYFaMM0Yzp5DaBLFcXlVB62dl
   OdAP3S3iPfIuVTn/gpFRnK1ztEKQ/+vu4KhbBu8E7YkLNBRJbfJ1Y3JTw
   yqRQjlDsXUxz4YH/PwVajfQAGt/PdaUQhGzDlZlRgtQpBPiXnqNUeQdLc
   8W5ETvhkXvIhLcvQEgh+31trjTf2SKencEum8kBPvfQEOSUVJmUdOwklg
   Q==;
X-CSE-ConnectionGUID: G4XqsdrDSzuFI/8GafK7Fg==
X-CSE-MsgGUID: vNhOVicUTReC5pjJMLYMQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53864089"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53864089"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:00:07 -0800
X-CSE-ConnectionGUID: 5KfugHlqR1Wz0lFAnjKPxA==
X-CSE-MsgGUID: V3GAZylaT6uOSJ9McRpMrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="92116602"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 14:00:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 14:00:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 14:00:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 14:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdeRxkyMXQTmconqxVV8K1fYr7kcN/4dpXYokCNft3nmeEqy2gWevqzeeCY1NQIC/asHQzo9Zic9kt9IWLY8fEO2IJCdcBGIFERl31D+zjvp/VJP1D2b4s6+5y7/cF9SHziZtQIYfQuw0K+KJkqFWPJBQ84zwN4UU19Mb3SzOY1QcVSH5lErnjNT6t2M30SZUzCoDL1CN+5aEli0SinIvw9zSjcC/Z1/WAUHyB9qWdVJ+U5SYjamX3JIPHXbf48OwBVdKrf3jA5+ZmOWP95SYmxkjSvLjv9/mBxC4W2a1v5lOFd9YyEADb83beVXEKswyJni7d6C8oLB1+RK1njZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZReTHiQjtsd+BCtsDjyKaw6tIviZuAdD1bFsQOFfgvY=;
 b=qU6oyHEBJ3eNI1KpiT4X/EEeORD6Ysp7q0ZDzwcvKw+HfcsGYMxxfMXJqfyu1syVoHGlwaq46QguvI13/YJme/4iZOs+L6B2dx035PKH82yl0FwdRImMLDMYARq8ge/W8T2WiBPvhmvajpgh9WlSXGsR6cFXs5K0i4rJ+jeYJmdiMIK2+UFJGp9jIo0Tbsp51e2LbtmK0GmBvWdSFib+pWgZBLQdN09564EFe1MbZ7GH6cPaqSS2888b7OGcbgTf2exW8HJ8SR09ugePD8FUj2vyyO9XLBHcVzJ6gP9QS9rs81wYsrkO1A+uusf0rEcufhY5KxB2iL+YvXeLEbFc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 22:00:01 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 21:59:58 +0000
Message-ID: <efb11b1a-2f32-8a62-b7e3-bb89ead7a3eb@intel.com>
Date: Tue, 12 Nov 2024 14:00:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 02/21] x86/resctrl: Use kthread_run_on_cpu()
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
References: <20241112142248.20503-1-frederic@kernel.org>
 <20241112142248.20503-3-frederic@kernel.org>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20241112142248.20503-3-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BL1PR11MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 092cc8d0-c433-4353-8185-08dd03655965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW9NclArQmlhTmsxajlKV2M2bVUrYTArdXhMNnBhbXUvcnVsQUVUak9BUm80?=
 =?utf-8?B?QVNockhKTzVoOWV2M0ZGenhpNFcxWmZsUHJqMk5ZTWtrQ1pNbUZBQy9jdkJH?=
 =?utf-8?B?a0ZxMmh3N3VRUWZlam11Y0FyWldacXZOb0k4NEtHenl2ZFBnVmkxNmtMdzAv?=
 =?utf-8?B?eUIrWk0yVDZ0Qi96SlNqZnRNYmNXQjkrT2NON3AxNlIyaUk1cnFTa0lYc0o0?=
 =?utf-8?B?MDFYQjhBV3ova3JlelN5NmVkWDE3ZlBkQUlybUdPMDVuZzBqNGZkVm00NnJD?=
 =?utf-8?B?V1dPdERLZGxzc3IxV05JbG43aDltdE52dkg4RnkxU3ZKN3BEOWFueU9qZkNH?=
 =?utf-8?B?WDVKWmdzT1hiZDZWUmlON1BoZlVHNUl5a2tJTG1VbmhnVmxSTFlzVWJ5OHdn?=
 =?utf-8?B?ZnExMHBmeWliZFNiNDVGVzU2T0hndUhqRWRqYTNTdVFtR2pQTkxrRVY2YTB0?=
 =?utf-8?B?SWYzK1Y5RmhsSTB5M0pYWFZpWFFiNW5HU0kzSTdGSlVEcTdDdTRuTlkyYmh4?=
 =?utf-8?B?S2Izc201VDVZWVRwUjk2dy9NSXJKTWtXVTArdTNkNGhzYXhJTDQ0RGhSNHNx?=
 =?utf-8?B?LzZEbVlhcmtZQWhFVGM1NklNdy9aUW8vMVNQREJPWmpqcVBXdXE3V0hpMGJC?=
 =?utf-8?B?MnI2UUFFQjNXRmJUamFmN3ZzVmREWUd1WVQ1SFZtU2dZak5KcGRsaW5ncXZr?=
 =?utf-8?B?SW9zaGVpOXplWW5lcURYa1BCcXhQdzVkNU5wRDBTQ25vSDFlOW9JYS9wbjZs?=
 =?utf-8?B?bW5mdVBZTFpaY1ltbkEvRjZBR3VTeWp5Tk5oQkFEeWhIWjYxOGI3N0toOFQx?=
 =?utf-8?B?T09FRjVPTFovQWFtWVRjQ0dEdmVXZG5YZHVrWUMyQ1FPVit1cHZzczRmcHVs?=
 =?utf-8?B?ZUFQY0tLanRUOCtQcmFwR1c3RTdyOWpQcHoyUkRPQjdCVDNxY1NOcmhrS1lQ?=
 =?utf-8?B?RTA2WnMxTWxPd0VrZGRZbXU1c2RPUWs3NmJoQkZFOXY3bjhSSHhDMWpjYlkr?=
 =?utf-8?B?YVlKL09uWUZLa1dwSVMzZ29HYjQzU2V3SzV5dFFHcTQzOFZkUyt0M2Rmc2Ra?=
 =?utf-8?B?MUY5NkdybTcrdkpUYWU3RllGdmM2eG15VnVqS2ViVzFzU2VCRkRLOVhKWHd0?=
 =?utf-8?B?emFuTzFFUzgvVFBvWHA4RmFETTNoT3IzYzEvMjNqZnhBUVVPUWk3cUx6Y3pG?=
 =?utf-8?B?S2Vrd1pwVUc3WlpHODc4YXZ2MWZmS2t4YjdBdms2by92dURNd2FSemI2NGRF?=
 =?utf-8?B?OU9STVQ5NnFEQ2hlRm1Wc1h5WDBpSXZDWmZEOTVESW82azdjUEttOThEdytw?=
 =?utf-8?B?OFcvKzFXak1HMktKaGgwQ0w5TW84cjZLNXNXZDRsZXdpZjVRKy9WM2I0VWtV?=
 =?utf-8?B?ZjF4dkwxTllTZmt3TGFmczBtSWlNZWRWSEtDYmVpVnFYMWhxa2gvZFBRSlRT?=
 =?utf-8?B?eDd5RWdjeE5WMGpaL1ZWSGhXckQxeUh5ai9LZW5RRkZFUnd2U1FZQXNyOHFy?=
 =?utf-8?B?OVpFeFZGcHk1R0c2SWljRWl3RllvZXBMbjZCNEJlZDJSQ3V4VzQvVkpxbHVH?=
 =?utf-8?B?NG1YaStjb3J0dTNORzlpV3g3c0JlejdNWUgwVFZpSDlCMkJIaWl2SE5OcWR0?=
 =?utf-8?B?RW1KOXBhOUFUdEEyeGRpUjRyUDZxQVMxNHhpS2JLemxkb1pQWC8ybmc3cHFk?=
 =?utf-8?B?Q0tLclZpVUU2MHFlcWFtb1NTSVRrbi81b0xtTWZkaFV2QXNGeDNQVjhUUHJq?=
 =?utf-8?Q?dfk4rFvF0lZZoBgO+LdVQz1v8mktD23nIJ8hfFt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNoTmxuQm9tL2NKM3JWMGRsNGpISGZzNFFWZmU5YlBlSjhHRmlYTU5zb3hH?=
 =?utf-8?B?Y2hEOUFoWjFSd2F3TVhtZWxjdXZXOUJ5bEJTYUlIallVdUNYNzJxaVF3TUNr?=
 =?utf-8?B?K3h6cjI1Zzd1RDNHRUt0MEdmQWxHNk1MeWhQU016aCtoQXpmSmpQczJ6NGZi?=
 =?utf-8?B?S2I1WkZiU1dDRlFLQUZzcjFCdHNWOEllYmxXanV5QU5nVzVoRnFKNkFnMC9r?=
 =?utf-8?B?WTRGK2ZCSkh0V0RRNWRGOFc1ZTRjMFhxUFNJVkJVNGozQkFtazBuQ05kOUNj?=
 =?utf-8?B?RzBOaUZ6OEtUbjY5S1pxb2UrZXdGQmNCMHFLVHR1bHNQSFAxaXhIVXZLYlRB?=
 =?utf-8?B?bjZhK2pTbHpXWkNQOGZBR1lSQ2MvM2dQTm1JR0pLTVJWbDB4UFIzSnpGWDF0?=
 =?utf-8?B?N1FnUW5vbml3MFZ6am1OMGtyWFQwQ2QwQ1pJaklBcHhNNHhaZnppeFZQUlhu?=
 =?utf-8?B?TldvZEVxditTd1hiTmNmTmIzV2lKaTUxaTNkYzY1RkxzSk1MRWN4VWM0cEFw?=
 =?utf-8?B?cWJtd3YrS3RNMEk1ZWN5N0ZZZ3c0MzB2TVYvYS8rbExScGFOaEpYdWhsdjQw?=
 =?utf-8?B?cDJISDVYSGQ2dTZpU3lsTnMwZnB2SzNhSU9aVzVUZFBYNTA1RlJPS2toTzFK?=
 =?utf-8?B?M2NFdjljbFIrZW5QazJEY2RmRHJ3bGEvZkN1eUVGR0tzWVEwMDlSemxpNG9n?=
 =?utf-8?B?Q0pHUkRqc2lPL1JmcU5KZXg5ak9JejVqaW50NVYvRDNFaGoxSlhiakUwaG1U?=
 =?utf-8?B?WVg5UjFTYkJaSUFHTjAzZzRTT2h2VFpxZUg2TnBDekRLUHJoU1lvZ1ljQVdq?=
 =?utf-8?B?Z2NQZUsxWU1Rb09VRHpHOGdKdTJibytpUmpMbDVNTG50ZEdDYS8vWFM4S3ZR?=
 =?utf-8?B?Zjc5WlVBZXRuMjNoK0JBWkVmUFpBdzNjdGpBVzIzOFdEUDRsTENUVHpSYzFM?=
 =?utf-8?B?WFpSYTM4YnFQU2YzdWVrbEFwYXJJUzdNVzROakVRZG5nRWlQU0x3ZEloT1Fo?=
 =?utf-8?B?L3l3OG4ydzNaUGtZeHpMMHdiOXJkUFNDRFZPZlFBTyt2WlZ3Um1ySXZuYjY4?=
 =?utf-8?B?WUNlc3hsbUpQaWNhY3ZWLy9JdjFwdUZVbDRZb3M2SGhBanhzaWtXd1diNWlj?=
 =?utf-8?B?U21TZjlRMDgxWlM2bm9xYVFSWi9xSGx6bXZidHdpZUZzeWVuaStjazdCUnNY?=
 =?utf-8?B?Z0lZTE00TnMyWXNTMkdWVEtKUVozSDRXWEFvcXI5OUJpRktnbTFHYi9pUnZZ?=
 =?utf-8?B?WXlBVjFSOWZxa2VUWGp4d0xjZjM5M2NHNjRVR2l0SlVVY1FwaTYvU0dBeitO?=
 =?utf-8?B?bmpmdXFmU0hsL1lJVzBGN3NrVU5EL0NvWXdoMWZWeXpSWi9nVUhHSmo5cXdQ?=
 =?utf-8?B?ZXdVa0N4U096bTFlS0Nway9wQjMveXNOeW5aczJiRUtmaGdYQW1mM0tqZzJK?=
 =?utf-8?B?RUdvUWFqYm83c2daaFhmbXZQbi9KVWV1QmJoaEliZjdGL2JScXNLcTRKOWZT?=
 =?utf-8?B?SUhwRlZycnJtNVdrVHAzSlYvTEZKZnhwVVN5aHhFYThrYkN4TVJCeTF6MHVo?=
 =?utf-8?B?dXhsSlpDaWp0MzdDaktmVEJsYUwrR0dYaVl6Q0pRZFdnWGZIak1paU1UY3pX?=
 =?utf-8?B?cFc4dlVwdEMrY01nODB3eHhQeXl1aU96Mis3UDF4Y1dmQWo4d09VZ0JmcVRB?=
 =?utf-8?B?NjQyMTBPN05XMGRwekozVGNIRDkvSkxhSlBHWW9rSC9paUhYbUZmdWduaTVK?=
 =?utf-8?B?NW5BQUdjS1RCOHV2NDU5Nmg0MUNmUHZmTkYyMmJQSTFBa3JMWE54WGNuZW5O?=
 =?utf-8?B?S2lqSk1GdVI1YTg4NHhyTFBBRVFEVkVJK2RNVnR5V3VuR01VeHBtY0xBMndN?=
 =?utf-8?B?eEl5QUN5c0hJalNsSlZhTmJLYjJmMTFHQjV2c1dRcVlHcGVkcXlWSXVOb210?=
 =?utf-8?B?VHBBMUJFakFpZTJBSGZ0K092b0lyNGp5MFRWNGs5aVlGVDZBUEp5SjhnbXpI?=
 =?utf-8?B?V29sY2x2NlYwcG91MncxQmJ4V3ZIbXVKNnFIK2ZBZ0NJUE52ZXVVcmlJSGkz?=
 =?utf-8?B?QmtsWERhbWN2ZXBsWG9GSkhHWWZPZEJ1aWk2YXowZ0xHd2dMTFRCMHFvdTdw?=
 =?utf-8?Q?rKG5xV4Wb2FE6oblmMb8pRbXw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 092cc8d0-c433-4353-8185-08dd03655965
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:59:58.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKfvJz9eqD0SnjI8YUY1VH3Rnu8UVmqAbeOW0AQnZrY1KvHufHNnWddO063+z4feXFAQAdABKEMFefYaYpzW4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com



On 11/12/24 06:22, Frederic Weisbecker wrote:
> Use the proper API instead of open coding it.
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 28 +++++++----------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 972e6b6b0481..6c60c16a9dd0 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -1205,20 +1205,14 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
>   	plr->cpu = cpu;
>   
>   	if (sel == 1)
> -		thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
> -						cpu_to_node(cpu),
> -						"pseudo_lock_measure/%u",
> -						cpu);
> +		thread = kthread_run_on_cpu(measure_cycles_lat_fn, plr,
> +					    cpu, "pseudo_lock_measure/%u");
>   	else if (sel == 2)
> -		thread = kthread_create_on_node(measure_l2_residency, plr,
> -						cpu_to_node(cpu),
> -						"pseudo_lock_measure/%u",
> -						cpu);
> +		thread = kthread_run_on_cpu(measure_l2_residency, plr,
> +					    cpu, "pseudo_lock_measure/%u");
>   	else if (sel == 3)
> -		thread = kthread_create_on_node(measure_l3_residency, plr,
> -						cpu_to_node(cpu),
> -						"pseudo_lock_measure/%u",
> -						cpu);
> +		thread = kthread_run_on_cpu(measure_l3_residency, plr,
> +					    cpu, "pseudo_lock_measure/%u");
>   	else
>   		goto out;
>   
> @@ -1226,8 +1220,6 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
>   		ret = PTR_ERR(thread);
>   		goto out;
>   	}
> -	kthread_bind(thread, cpu);
> -	wake_up_process(thread);
>   
>   	ret = wait_event_interruptible(plr->lock_thread_wq,
>   				       plr->thread_done == 1);
> @@ -1315,18 +1307,14 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>   
>   	plr->thread_done = 0;
>   
> -	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
> -					cpu_to_node(plr->cpu),
> -					"pseudo_lock/%u", plr->cpu);
> +	thread = kthread_run_on_cpu(pseudo_lock_fn, rdtgrp,
> +				    plr->cpu, "pseudo_lock/%u");
>   	if (IS_ERR(thread)) {
>   		ret = PTR_ERR(thread);
>   		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
>   		goto out_cstates;
>   	}
>   
> -	kthread_bind(thread, plr->cpu);
> -	wake_up_process(thread);
> -
>   	ret = wait_event_interruptible(plr->lock_thread_wq,
>   				       plr->thread_done == 1);
>   	if (ret < 0) {

Thanks.

-Fenghua

