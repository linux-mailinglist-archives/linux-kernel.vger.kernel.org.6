Return-Path: <linux-kernel+bounces-570542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B4A6B1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3667D7B5002
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1878D224251;
	Thu, 20 Mar 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2Agn2qO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB75A1E5205
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514430; cv=fail; b=Njax8b6bwsZk4q3wn3adoeHojCzONzho2SNqhqancdHs8/zj755Xhi6jlXfz1CYu5pieCRRihOq5XxSpZMV8nD3Fdlkzr5Wm/YHBxk5GCPzPSXLPzPQ4WFO63giUTnlvkhRj1p/GDeU1ni1lzkt3b9ZgMW0BRndDs+0hG+1yBU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514430; c=relaxed/simple;
	bh=qc59l0w21LMXe7/VnSRODiVdVn1Vi0HNNTlezkJPV3E=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g/8rW9gHdk6NklQ8179wmAH0WJWRJDSRBsRcvuGYH3u88TPX3yDncPcaP9ozat+jNqsepxF4Qi251/cWCjD63OM7//IagjXiK/AGFiHo9B2r1T28rKog8HZnGemlWGlLJu08MbvCEu+dJBwKzD/lgBiGmlcbSev8C3lYIf8EBuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2Agn2qO; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514429; x=1774050429;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qc59l0w21LMXe7/VnSRODiVdVn1Vi0HNNTlezkJPV3E=;
  b=Y2Agn2qOfVX37nci7By8qv2in0IR9MzEIHoYz7FlAgn+yIVR2ZssyngX
   nd1SHN8K4kUrVkmQiVn/yabArJTV8Xf0qAEta4/azl0N8d/0LQ05Laxi8
   8Q4OEVhGwo6AnMmAw6Z6OV0SFfburHHbI9LuzxLFMxeM4BXLzPnPM+sFZ
   s1OdcVrrOvdRPjgx4B27oH3/rnnXqYXrPUUG56VpOghMnsZKZaXdnCyov
   u24NpQxAKx2nK29hh+VcNzoOErNrugmLLXMkU4+G7Y4hzgJvpJ1W0tiAt
   0GUrHDsntMl/Ze/ZEcnoPcDbomTs8gG9z58bkuWlJ4Tnh0xVy9pF0Swhy
   A==;
X-CSE-ConnectionGUID: HOhOsc9GTqazaPtz/H4ZOw==
X-CSE-MsgGUID: ZdoRNS2nT2uAVGVBENcUWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439738"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439738"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:47:08 -0700
X-CSE-ConnectionGUID: 5ghgj7rJR1ul0UY1xxkOcg==
X-CSE-MsgGUID: 4E3AH0jkQm28M5bYuOdfeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="154253924"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 16:47:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 16:47:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 16:47:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 16:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8aTccwId1+YiQRUFFsVMqTCtC51kT6GZGsGPDDbC/FhAAt8nVRIp5g+keQ9aklu66JeewPLnu0+K3CHmSWXl/c4Ve6Zyf87ABGSIHBa2dnmAUkjcy+osScdxpCn3n5d4UsT62PZPffoR4KCgUCazOsVO5heKh2vNnK17Jymemq5Pl1Gju7RUVBU9JGmeuBxPRowZJglLYOOXZk5k57xXr6SzBLRWS51yLq+PBBq9D9jpbIWl02F3TiqBvPsL3pixqWbZK1e/JpNq/Q6uiX6z+M7P4hk17KT+3rfEHXg3EjDGzhuWkieBVTDKPYGfppp2GenNXzdeSiHdtkhCCEOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK2103l4rH1pFDZ9DaCW1oJSN8UJb1uHSa7ikj2ZSIU=;
 b=DH6cBINsX0MlzIGRAge/OQdAr9uiPiWkcNaDwxOAhuxCMqp4MK/Pf/y4iABd6SS7wNmZcj2zLvw5kfE7vu0AXe3MTxC9GigGhre9mbqEhwC0laVgBjmDEfdygCo8rThvDTlyYXqUzL9zeo048PAXh0zCMYxYlTxCyVqPTagPZB8MswopjYuRv7xSZ1qBcRK0P/Ple3JrDX2XUv9f/+Nl6TQ3tWDEujVFHdIUaPEmMTzVGvUhVey1neESCe2hhXy3jbneu7qUhlHGPvu0EkclWO3rPuTfn03iUEFndltMVrIHxdvLI4hVWmcx/kmo4GKV2D1sBfwqc0BYnREkGIsFhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:47:03 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 23:47:03 +0000
Message-ID: <9985fe50-3ea5-411c-846a-dba3fe1fa451@intel.com>
Date: Thu, 20 Mar 2025 16:47:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 06/11] x86/fpu/mpx: Remove MPX xstate component
 support
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-7-chang.seok.bae@intel.com>
 <Z8C5B9PJUqkEDGH9@gmail.com> <1d269a00-39a1-4c64-ac00-d90abe420f0c@intel.com>
Content-Language: en-US
In-Reply-To: <1d269a00-39a1-4c64-ac00-d90abe420f0c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f30d973-2c26-4c5d-f496-08dd680983f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2M0UjYwS29qRThvTTJ4YzdldkJUbjhla0xzRzFWQjFYN1FnNzFGZkUrSi8x?=
 =?utf-8?B?c01SUzdMMTB5eWFiaEtiRXMwUW12cGZHSEVNbS9abHA1L0Q1M3Y1VmQ3eDBM?=
 =?utf-8?B?SFZHVnVuTmUyQjVCa1FzeGw3R1FKWEtlOXlRT0RuTklOUG91QlBPMjRKTW5O?=
 =?utf-8?B?bEJoN2hZRGpjMis0THRaKytXcnpxZTdRdHlqd2htTWE4NVp5UHRaZEh4alFN?=
 =?utf-8?B?cGNDYnNncGtxdjVpZFVOUjNHVzhKMVM4ejU2S1FUckVKR25rak1IS2FmTCtx?=
 =?utf-8?B?SEllODc0NWsxZlQ4R25sQzV2WGVWTWVXRjJOL1NyVUc3TWxsTjlZa2sxMVUv?=
 =?utf-8?B?REpoMXk0WEdQUUI2bFVwSzVYb2EwaC9pWEQ2TXRqNG1kc3JHb0tPRFRxL3Uv?=
 =?utf-8?B?QXF1YlBOM2szMC92RDNRL3A0M2dQV0tpOCtqTW5BRytMbENCeEM5MHhzd1JV?=
 =?utf-8?B?cHJ3aERManNzaWpaS3E5T3lQOSt5QllUWE1oVC9KT3I4eHAxNkdsZnJVOHpp?=
 =?utf-8?B?Z3ZRK3d5K0hDd0hsYVA3UVIwQWJhSWY1dFJTbXIwc1FRc1lpN1Rwam5oTll4?=
 =?utf-8?B?anpNNHpNSm5JN0dnaHFqY284blMzMFJIR21zbjZJSzFMWjdQV2x2VUdKMk1S?=
 =?utf-8?B?TEdyNXY1S0VxTHBXaEF2N1c0ZUJiNS82dmdTY2s4RFFMWHM2NExZcGN1YkJ1?=
 =?utf-8?B?YXpvWEpxTy9zS3pDL3d4bnFHWUlzQlNVcDZiRVYzaVlRRzBIaEs1VTlQWDJl?=
 =?utf-8?B?T2FDT3gxcmd3Tk5qbHpnQW1GQWE3UTRqcGRweHFaQS9nTllSZkJlM1Y1QzVr?=
 =?utf-8?B?cTdmNFBiOUoyTWJwbi9Kb2JkcHZMR0VzbVVwbXYwZ0JOT09RUjRPRjcxUnk4?=
 =?utf-8?B?ZWE0UzcveDAzL1RWdmRzakdpdm5pMy9FNGk2MlJCTWE5M0xwd3hwb01lc1VY?=
 =?utf-8?B?U1ZnVUUzaWQrSUhxUzBnUTNrWGJaYWhZWi9ObmViRGpPU2dsL0FMMXZVdzNR?=
 =?utf-8?B?K3hGNGZyeXY5TnRmZjV6VUZRT0VKN0NNcVFiOVRVTHY3djh5NUhzOEF6S3B4?=
 =?utf-8?B?WGM1S28wUDQyMnl3N2lDcDhWMFVQNkZDZWRqdWhXbU1QMlRiYWhzekNPZjZM?=
 =?utf-8?B?aS9kellqT1FrQ01aallHQ3VXTkNSbmJra3Fid2UveDlPakZNVVIrOTA4R0ll?=
 =?utf-8?B?byt2bHRZd2RMNWIzZ3gwQ1kzL2tzaXdjMTV3M2dGdWtVM1pnYmhSU0FZR0ZS?=
 =?utf-8?B?eHVzcUNSOTJ2a3ZWUjFTVzhSZVIwRThjcnU3NXI0SDJIUDNNOUF2U2dmQ0s2?=
 =?utf-8?B?MHAza05CTkcrektXSFZYMUJhdnVNZGZRRXNuYVpSa1hkWU8yQmFTanVwUUdI?=
 =?utf-8?B?aDFoTEMvT0pEelhBM0x1SWovb1hQVjF5Q29vSVF4TnNhRDVyYjBLV3hUOWZY?=
 =?utf-8?B?SGhWVGhVNjVHelpSbDNTbzRPdG05dy9RbEZWOWw3dE9jZXIyQ1pGWVNySFh6?=
 =?utf-8?B?aFdvME5zNGludjR3UXVaMHVZNCtmcjlJVGtzQjV4VVh3RWJOQTN3aFNrZWZD?=
 =?utf-8?B?Zkt1QWtadWRSQXpJWEs5NFN5SXpUMXFSS0gzenBJbjcxQ29rTHpxOUN1Mnh6?=
 =?utf-8?B?bkV1M05PVjBDdnFNVDZvWjZ6TW44cHFTemRZMGZ3WXNuUDFXQlk4dDQyWFFY?=
 =?utf-8?B?ZUhLZ3pDSExNQnZXMkJienBQM2xRc0o0cktsdEF1NWRId0pKKzhJZ2FPeWRN?=
 =?utf-8?B?TTQzSmRrYk5CVURJNTFvdEV0SXZmQ1R6TlBJMWxINjRSbFU1NFVGWUFTOG5k?=
 =?utf-8?B?SGJwb2ZVKzB3VTNTRGlPOXQ4WE5sTnVqTi9nZTkxS1BJcnVVbWtpZEh4Ukg3?=
 =?utf-8?B?ZHd1bElTWEJibHFPWk5VMmg1cTgxY3czVG5RVXpuQW5Xamc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dER0Y2JYbkR3TW52TC9HT01nN1p0MVYrQ2VST2FxZFZ0M0taRUhUQ0hFR3Fx?=
 =?utf-8?B?WGJBa2VLeEwyM1ZtbW1LS2luWU1pYS8vQWNxbGFZVHFlTlZwcllIK2FwT2NE?=
 =?utf-8?B?a1pSS0JrS0Q0SVNOM1QyanRNUXNqNTlmbGlVbmsrMDViVURhMDcwTFFCZXVz?=
 =?utf-8?B?OVJ6MzNOY1dlc0RINFRJYlFXKzRKN2xmaUx2NVo1cGJhcElobUJwc3pHQUY5?=
 =?utf-8?B?N0ZSZHo4MjlZTTlSalF6WWFiVGZDa3RXNEpobEdyL1V1MnNTaW16UDFNV3lY?=
 =?utf-8?B?bkdXeEg0a2l3VG9Ucnh5YlYrN2RJM2svc3NOVlVlcDg4MVF1YVR2NEhqa3du?=
 =?utf-8?B?eDRMQ2ZLUWYxV2VGOG4xSFQrWXVKb0F6R28yU29xS2ZLd24ybmJZTHlOQnE5?=
 =?utf-8?B?ZDhnbVlWQUhoUk92ekZDczdRbHRQQkdWOG5pMjV6ZkJiQXNMTjhDOHdiZ1Bm?=
 =?utf-8?B?ejlCN0ZCcUthQXFlMVIxaUpFT3d3VFVaclA5RHJJazVvRk1zOXVJMERCbktj?=
 =?utf-8?B?cm5ZejZXUm1tWDRFQ2wzcks3RnhjVnV6akovK3VpemJhdmtrMzREQXQ1MHU4?=
 =?utf-8?B?azk4cXROaGpZS2MrR0lEKzZEOTNXZkdCR2JhR3NBQ1Z1bjdldXhMaHVFNjVD?=
 =?utf-8?B?cktDY24xQ0R4cDZiamZCK08zSXhIbVhUeGxqZzl6TmNmREJySlZVQlRKUEcy?=
 =?utf-8?B?NzVWTFhhbEhqK2QxM1NLdXAzZU5JNytMYVlJbzFkUHNXRGFlbVhWb2lRMUZR?=
 =?utf-8?B?Q1cyYWk4aFBUWWdmQWNJbGFTcWY1eW9vQ0hJZE13U04wQ0FOT1gzQ2pSMmVI?=
 =?utf-8?B?bWtMV3NUd3VENGE4aEZ2U3dCTGorbnF0OWw1ZlBtdnNMR1FMeGdlb1dZZG5t?=
 =?utf-8?B?OEZDTTU5R2ltMTFjRStoaldMYmNwb3NYQmFRNE10YW83VGpGRE9DeXhlK0dz?=
 =?utf-8?B?Y0lNT2Y3U2Z6c01STzJEclJja1RJdXhVNDVBOGIrd2R5MnpVZkI0QytWWDZ1?=
 =?utf-8?B?Zkh3TVhLZ0M0V0lWYkhhUDNsUDlsYVV5MFIzVlRseEVacXpZQkx4NG5BaUln?=
 =?utf-8?B?NE44YnFzWDdtK3hSeDhzZXoyYTEwdXlSUjA4dFdPWENwSmdHTDlMN0ZQajlY?=
 =?utf-8?B?RUZYZXJyK0xUN1lMWGpNbWxVT2VHbUtETE15R1FPYXZCUmNnV0FrZ3pjTmVI?=
 =?utf-8?B?NXh0VmNrSGwremhIWVdTRFFNQ3BOL3JNZ1J3SDRnN0NEVU8xS1h4SUZ1S2Fs?=
 =?utf-8?B?YmpmWFZ4ZTZLbElPNk1kNDFuTjR3YlJwa1BSSUZEdktvOG04OWF0dFpSNlRk?=
 =?utf-8?B?Zk9mZERRaUQ1dFhEZnp4NHY0UjVUa21TNE1VRU1wQ1VHYkQ1TTFXYnd2SVdU?=
 =?utf-8?B?dGdWcWFZK2pwMEhOL2xRWW1TOURtMnNRWkloSTJvSW5JTVh2Skt0L09oUkxy?=
 =?utf-8?B?c3RZNlRqdGxFYSttV01hdTVwSzZOZFNEeWwvUngyZk1Pa3BnS1Ywa09VT0lI?=
 =?utf-8?B?Ym9lbUlqRXJYREJVUVBJb1oxUm11RlhUL04vY0tMWmhSNGIvRzRDZHFHNWNO?=
 =?utf-8?B?ZkpLbWtPdjFBUFpGMnBKNWV6c3RxdzdsaUZSOEFkZG9YbUgxMTFOdVVTNzFS?=
 =?utf-8?B?VngrZG5OK2JHNHRWNEJPMVhsYUtiQy9vYkxLeTAyY21Vb0dIRHMrMHlSeGp4?=
 =?utf-8?B?cXU3c2FBVUU1LzFTakFqbG1SSStRZGxSNWFvLzhseHU1K0F0TTVyRzlXN08w?=
 =?utf-8?B?TFNDTjEwbEt0U1hjUVhNOGlHVVg5OWdoNFFHMGluR05DRHloTkYxajhmc2ti?=
 =?utf-8?B?NDlrb3prallxSmZHTGw4QW9TcWVMdGFxWG8rYWhhZnFoRzBiVEhRRXEyc2lV?=
 =?utf-8?B?VDhkVk9lOGJUSlU0bHlaRVgvYlhOVGNsWGdtWGRDSU0xM21wcnltODlUbDNG?=
 =?utf-8?B?ZnlGMTRWK0RvVHEwQmtBTXhBaUhad2E4S3RsK0JqOXYrM1hlOE5tek01NjJn?=
 =?utf-8?B?Z2piTGt0MjlCSzg0WUZIdUZtUTJGSGlTbzIwTklEcnN5WGhCR0gzQnpOZkhS?=
 =?utf-8?B?QnlnaXlsc0VsZ2YyM09DZnJ4VndVYmhwTkN0TlFiVjF5MStRRGRHYXE3Y1Zp?=
 =?utf-8?B?UjI2OGsvSmRMUWo3T1pEd1BXTHZZNGZDa0IzV0NGTy9ZbWt1ZTRXazFwcmtX?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f30d973-2c26-4c5d-f496-08dd680983f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:47:03.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdzeerTs221jpjyIJ+ODc//cVPe79VpLxdeS8+5/5Ht7XQaWTbrw8P+DGcgfiH10EZnptrHmvgX/Ja23KgM654ysi5c48zr3rpyYMrgBryQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com

On 2/27/2025 7:12 PM, Chang S. Bae wrote:
> On 2/27/2025 11:12 AM, Ingo Molnar wrote:
>>
>> So can this patch be moved further up in the series (without breaking
>> anything), to make it easier to review the impact of the APX changes?
> 
> Will do it.

If the xfeature_noncompact_order[] table is dynamically populated at 
boot time, the kernel should be able to maintain the order list flexibly 
enough without dropping MPX bits.

So, I posted V2 [1] with this patch removed -- after observing MPX being 
exposed to a KVM guest when running this version on an Skylake machine 
and confirming that APX support passed self-tests on an APX-emulated system.

I also considered handling MPX removal up to the KVM code in a separate 
series, which would eliminate about 220 lines. However, given previous 
discussions like [2], posting that cleanup now might appear to disregard 
those concerns. Perhaps it’s something to revisit in five years or more.

In the meantime, kernel memory usage could be improved by treating MPX 
as VCPU-only, aligning with the ongoing supervisor CET state handling 
work [3].

Thanks,
Chang

[1] 
https://lore.kernel.org/lkml/20250320234301.8342-1-chang.seok.bae@intel.com/
[2] 
https://lore.kernel.org/lkml/CALMp9eTD+GeiKK9E5_JUOy7YXPTq9z2f2LcyXZL5ypQ6vBHrHg@mail.gmail.com/
[3] 
https://lore.kernel.org/lkml/20250318153316.1970147-1-chao.gao@intel.com/

