Return-Path: <linux-kernel+bounces-203083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D28448FD632
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C290B21F65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09713AA40;
	Wed,  5 Jun 2024 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbEcYJga"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E27C133
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614323; cv=fail; b=FxRf25807yRNZ6TJwX0NBDmVhpOf33BIENawtFS8Db7MF4/GrRiUQYJ5OqqTAYDSRkVHVmcAiX4MR+hNbaH4hqv438B9BxpJ4otXh1on1Ucf5ylRz7E9S0/xOGsrhscYd15SEL7AejZ+LzHLbxi8FhnN+fVidecK2czPD+/f1e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614323; c=relaxed/simple;
	bh=uPq2CEGzPbxBf0Ga8D7AgwRyOzUbcY9niDlUjMnSKaw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a85/4PvktmZ4qxSNx7N9iCP81sRqPrZ8yNG85ZqwgAyg+Q1VSVCaalHC6hPYCHa/kcpa+GQ2mo8VxMC9lkq/zcbc5IutewpFaoPUxuABjCfxZxFs2AglQiaiuBLu3pLAvKlb6kn/kkVRNzFc9poEcKh/C72gQGgwRcZ48l/kH7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbEcYJga; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717614322; x=1749150322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uPq2CEGzPbxBf0Ga8D7AgwRyOzUbcY9niDlUjMnSKaw=;
  b=TbEcYJgaFkMcyyAocij/YhMnI9BVsw+JLLnEj7ngWCUUzolZW1+YByh4
   XmM2ELrk1e6yfwxnOr7vDmvYnShJeDo9CYzBDE2ipxUmwgHhH0obJsZjc
   JgPRDYrQIC8Uh57Km4ZpxkJVxrgA9wziZmbGJZyMhZA8ZsQESR3sxjh+d
   9HekXIkAdeeBmd0tBBdqx05YbAgeEZ2I16VKsH7x02PLKvBvpqVe2oGhM
   ayjAslfnL552fdQHtRY9vKE7Vj1hhDfPFg7KKRKRh0U9H+vl5rJz8heum
   Jcm1YhuRp6TcMOhoZ+GSlUYyFZ7tGw3jrazMHCfvbcxKdjdbFFCxeqmOQ
   w==;
X-CSE-ConnectionGUID: hwDuq0SURfCm5xBruWR7LQ==
X-CSE-MsgGUID: W88shzJRS4eYULnOIjfxSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="11926919"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="11926919"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 12:04:49 -0700
X-CSE-ConnectionGUID: TfJuUoGLTQKyedm5NDCXLA==
X-CSE-MsgGUID: 6axwXWxqSNeN2Q4TgzQ4fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37673972"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 12:04:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 12:04:48 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 12:04:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 12:04:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 12:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY1YF3dJU3G49rceYLv+qS0PyF6vjkrIPfranVsCNoW4SPVtl3gh960eMK4Be46XObGCmmjohGPbHX3vvCyHGVEPGH/yjHmwPmnuS/8DdW5uRvRXgIxeVKuab1FX4BphniRchAzzlLDTqme4Pn7zoiLsKLlbB6czLsZLen25nVTKTmSiMseC4wSIK0VgKqMce+RFhqf9bPs3VC2fJY2ixKu+wtwXIb2hAPvci4TlmFPUw9wz59U5U7+MccVYnNf64X2fAtBKqt0DC594+5yS9bu2DTRIrpHXPUeNX5/iaIqs+GxV84Td+ufJsjJeLCWwumSQxkorZ2K/jOZdZ6AP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLKvi4gNZH5I27B0I4R0wnu4wMG/6Gn3cqFQNdM7yjU=;
 b=UU4LxIMgwHzF+Aar4zpnER3iqO1Prol4f0OWCQeNjgY+EfQSKV2cBIdW8FTTsyVPQ/IhHVGg0zgs3hfu8w3TqJi2Mc8jzGcCnqqZ8jgZw0hdcE9kfKYv/T7/QDOdWkaSmkO/uH35XxGPdkKhFEZwYIJwPf3/21yviSoAdZ42+WrUgJlR9l1Ar8OH1B5wmjTC3TBJsrg4ZLSuqcXzVBU8rcPaU1853sqoxXf86h8y5XJup1BfdkK4U166F0CULRfCnInHzScmpU/2ndX8b1hH8F/ItdfGmw0NNQll0aGqc+NV4xzBkqL7fJIUWAvFWH1z1I0EDOVAWlTHs9bvFP711w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 19:04:39 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 19:04:39 +0000
Message-ID: <204e541d-ff48-487c-8f70-619f90f65635@intel.com>
Date: Wed, 5 Jun 2024 12:04:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] x86/fpu: Make task_struct::thread constant size
To: Ingo Molnar <mingo@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andy Lutomirski <luto@amacapital.net>, Andrew Morton
	<akpm@linux-foundation.org>, Dave Hansen <dave@sr71.net>, Peter Zijlstra
	<peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin"
	<hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Oleg
 Nesterov" <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Uros
 Bizjak" <ubizjak@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-2-mingo@kernel.org>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240605083557.2051480-2-mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::6) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6f2e15-b5bc-4483-8898-08dc85925929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a24wSG45NXA0Q3hXYzgvZVdFWlR0cktIZGQ5Q2dNRDBKcUFoVmlobUdBY252?=
 =?utf-8?B?VThzQXBwVUthMy9mRFFEaE5qWUZOcUN4RWE1ck5LUVQ2cUVLZytEb2VEeElP?=
 =?utf-8?B?cE4xTWtYM3praVFhSC9vWWNjTEx0cjg1cU9hUUIwVC8xQmc2bDJWR29wMzVU?=
 =?utf-8?B?Nnlab1V4Y0liVWtOdjJTKy9IN3kwOTFjM1BBZ1czVjhMQnI0Rkpjc29QVk5M?=
 =?utf-8?B?UVRER1NsS0hoVHJidmZOblIrU1J1ZTkwUWpRUC91UUZoUFlEUlVzbW5RT3BS?=
 =?utf-8?B?VU1kRTl6d05Va1BoT2NTU1RYV2N4b0lEMmJhMUpPNlZhQjlaUzBQNDJsU0Q5?=
 =?utf-8?B?dlRqTGdQbkQ3ZTJXWXgzNE56RlgzUFdLTUptcVo4WHNEM0lGa05wRHJ4eERY?=
 =?utf-8?B?NUp0RmF3Q2JMdTR1ck5KZFYwYkRpaUpRWHdJd0VEWFZ6QVhrb1VYcjBkMTda?=
 =?utf-8?B?TUFBZnp5Sno5ZkF1amQ3QU9ySGVsYndkcDZjRkQ5ZnhMWVErZlFua3pPWVJn?=
 =?utf-8?B?VS9hS2U4UTJTaWIvNXMwVDhrM2dTeEJ3U3owUDFMb1RSZit2eERnQnJpT2Vp?=
 =?utf-8?B?WUFQeGFRSkh4SmQ3OG5TWUdrOW9Gd1o0eEZpYnZCYUk5MnlDdHZBQ3V2bi9L?=
 =?utf-8?B?d2lxTXB3STRwWDZSeFFvSmdkeVdaMlNMV3hVclF0YUZOUlNjN1llZXVrNTM1?=
 =?utf-8?B?Z2hWMkdsd0pqcTZYMHMrQmtXS3Z2R0lpWG1BQmZIY05zSFVFbXJtNFFpa1pU?=
 =?utf-8?B?dDJYZ3lvUlk5T0I2QlJaVTMrS1hsSHZEOWlucnY4ejcwaFFSVTJhNm4rdndN?=
 =?utf-8?B?cDZaSGpxRXV5UlVRdk16anI2U3EyVy9mUWtoUjRuamR1S3BXV05zc1h2b09m?=
 =?utf-8?B?YXA2Wmt6UGRIOWtNSDdzdmdmTHBKUUxZWWhWTXgzSUlZVWhzQXV6NDZkQkJT?=
 =?utf-8?B?amR1aFdTUVo3R0NhUjFoUTAxV0hWYWJSRGJCRFNBMmZsNkJUVE1saERDb3ly?=
 =?utf-8?B?RjlMQVg0ZnBwZzZlcStTNXhqdkVBLzVpeEsrN3JxbDFjQzdSbTc2V1hWWUtr?=
 =?utf-8?B?dVFRUEE4Y04zV3hxMVFobU44eGhEaWkweExuOVpCS2ZyTmR3ZGZoMDcvVisz?=
 =?utf-8?B?V2FpMjVPVVVKdE0raWRqWU9JRHRQZDdMd1FXWDNseHpidUtBSUdTK2RpL2Yz?=
 =?utf-8?B?bWw4bUVpaE5GTDlVVGZ3dXlRdExyZVMxVnNKM0VTQ2hqNnJndGZwMU02NzZE?=
 =?utf-8?B?WllmN2FjaGthZWREWGRQRmxITTE1QjZpVXlwVWhrcEtCdVYyb0gzK3pWUjE3?=
 =?utf-8?B?VXZ3QW9rWWgvRldlS3RHN3RTTGlvOEFoOG9GZlpkUWFjQXpCTGZCSWRpano2?=
 =?utf-8?B?V3ZodGNMWisvMkpiV2wvdnlSamtFcytHU1BNMXFvSkt0MzFzYllkaGNjNWlz?=
 =?utf-8?B?WnhPU20vVFluakhyU3MxMUdWK3pScXF2V2xvZXJFSmc0dlV4cTlrWXg4QlZJ?=
 =?utf-8?B?YkxKa0lualdlNFlxZDFzMnpxb3FOVmV0YmdjcjVnQWpaSktlek55OURaTHZ5?=
 =?utf-8?B?U0IrNVJyMThwdkpSMTd5Y3QraEw5Y0JJZ0FyNUpBak5FTnI1WksrMHF5NkxB?=
 =?utf-8?B?RnQ5OEFsR3MyZHM4cWZ2OGZUQ2l4WnRzOXhWZDlwdFAzeUpQRVZ4M2xZR2VZ?=
 =?utf-8?B?TUNhMU1Mc1RpcHJuSE45Uy9TUGF0R3F2aElaNVBDS0l6b092dWN5b2FGMjcw?=
 =?utf-8?Q?scusP4xYK3mQdguzNeOhJ+07kJvfoXu1oGPhtoK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0kra0V1TnM5TTArMTVpd1NFUitBbUNUeEtyTE1SOWc0TFh2RFV3a1lzYkkv?=
 =?utf-8?B?TVRadjhMQlBGb212K3JOUEIyMTNkSE5udGhKNjgrK1Q2VnR2MUhFM0tGYWd0?=
 =?utf-8?B?dDVEWUdibU5aK3Joby9TNmhtZnpZR1gyM2FGN3NTbHpERUw5V01ic1BKYzdR?=
 =?utf-8?B?N0lvQnhsSmlHbFNuY3RsUGI3by8rUjFTUlMrRHd5c2s5U2NzQndKenlKRkwy?=
 =?utf-8?B?WFF0a2xqWG5rT2NJMHNDZHVsMHBqOEduY0ZVZlVESm5wekowM2UrL0Y4cjBM?=
 =?utf-8?B?N3Y1MU84REZzZDE2OCtOMmFEN3ZLL1Q1aWtwY0hHVWt0MENLQnlPTG9Ub3RM?=
 =?utf-8?B?MzNZK3hJR09oaEVuS05TakdrRHN4OTEza2x5dlAwamxaVklIZ2U3dDZWSW4z?=
 =?utf-8?B?QlVWS3VPNTl2cVN2ckttQTFUYmU4T3NFMGhqTTFwZlNPRDBkOVovQ3kyVjJG?=
 =?utf-8?B?OGY2VDlndVFnS1hYYTFOa1o4aTAvZDc1UGM5K2ZUT2c4TkNUY0FJNk5NcVF5?=
 =?utf-8?B?SzFHaG1RSGllbEU1VVFWWUNMczRNQzVBWUxDV1MyclovcXBiR1IzOUFwaGhs?=
 =?utf-8?B?eWdvUnZUSUxkcWJZMlR0U3Y3dXFiTEsxbmdRcWswVnVzdGIxdmVSbWlDTjY1?=
 =?utf-8?B?YmgrRlRsUU9zdjQrK2ZFb2tPcFE5akJsNDVnMGtxZVAvM3ZUOVV3VFhKaStQ?=
 =?utf-8?B?dVlVVXBmZ2ZDVHIzejc0eWMvQ0tJR1hhS3Y2Tm9pOXduM2t0WDA2RExPN3d1?=
 =?utf-8?B?OERnWS9UQWpvMTBZaEtCVEdmZXh1ditCdzU1cWFpdURvSmMvdEF0b1dCVG4v?=
 =?utf-8?B?Ky9kbm82NUJVSnpIT3ROOWpQdUdUbUNZVXJ5RHNqbm9IZnNwYndYV0E4K2Fx?=
 =?utf-8?B?cWlFMVZNSjdJMUdybUFzNENnSWlaYnprU2k0WWpRTC9FWTViczZScE5MNy9H?=
 =?utf-8?B?VUtHd2RXZFZYRDhpaTRYSWhYS3ZZdVlnWlpLRnoyb3NuN0dHUEpJNndsOG1t?=
 =?utf-8?B?aVlJZzRBQlRydkgwWGpaSCthUnR2emwybnB2Vm8vaUZ1cWRDNmhsUjRjbUZB?=
 =?utf-8?B?KzNBNG8rYTNvWDNyNWt3OVdxVFlWK1J0OGtLeHFlVndRMUNnU2lhSVlYL3Fq?=
 =?utf-8?B?SVpZTGdxZURjUmhzSUFpbmlaMmhVMzkrcUVJNVdIT0dzRUlxeTZiejFPcDV1?=
 =?utf-8?B?Ui92cnJ4ZUJ1cHBnS25JdysrNG16UVBLZDFYK3VXSkZGbWZ0dFBCODZwcXBE?=
 =?utf-8?B?cUdWMEZlWS9wbVhuUVpUdWFWVWxpWSs1Y0ZrSDMrd0pRczFxZWlqeUZYMW1F?=
 =?utf-8?B?RUk3TVVBYUk4L3F3eDNnN0R4cDlsVEkzdkJaeGxMdkNRRkd3QUtYcFY1Ym1n?=
 =?utf-8?B?NkMrTWtxSXZOdEFGRTB0SjN4enhlSVMzL0NWcG92UkJYeGZPS2JZUXYrNzk2?=
 =?utf-8?B?bTM5SlppMVlUZHhqVkdYdllZVFVPSkJ6WjlTR0hra0VldzMxOVlOWnF1Q0oy?=
 =?utf-8?B?dG5BcWRoV0V5MDlkYVBnVEtaK25mMXFPTGZJcXA0akovMldSUU10Q2lucTVj?=
 =?utf-8?B?ZmdnZFhXWG9ya0xaNmwzbTYrN3ViUUFWTUFnSkxRN0k4WFAwa3duYkxUZVlx?=
 =?utf-8?B?OGpZQTEveG9ESkVvck8wcG1xOGcvd2xyUTQvaGdFaWk1eURlNzNIN3VzeURQ?=
 =?utf-8?B?bnZjUU1MaXgxVlBGOXJDMkxVT0pnRTFZcVR0Q0Z2SnFXMStkSG85b2RPZ1Vm?=
 =?utf-8?B?Vmk4bnhTM1VTR3FkUVQ2TVBiNEdQSUJSMUpVUTVsNHhtQ1pDa3MzSjlxSk9o?=
 =?utf-8?B?UytTTTh2QjRjb2NlSjZtenJTR3Irelk5Tjc4WjFkZmhEQVN3UHUxa1NuMjBa?=
 =?utf-8?B?azhpNFEwa2JXZkw4bmxJWFgzRXBndlFXczdNYmRTRGtYSjVlcGkxMVlwMHVv?=
 =?utf-8?B?bHBnN2ZBTy81QWd4MzV6aU9HN045T1h2TVhlMnlVdkdQeCt2NWJoUE52Lzcw?=
 =?utf-8?B?NzA1cTFiWXRQTDZndi93bTZ5Wm9XTmF4bHBsYU9HdUVsYmZRL0dOd1JzSXlJ?=
 =?utf-8?B?cXhvZE8vamFveGFnUFV2MTIvbGpaSnhmS0Qva09JRlIwRnVKejF2TnFrKzh4?=
 =?utf-8?B?VC81Vm4rSSt4SjhxTjRMaHNtYllqUmNNdENhQ0lGY3dzOUNRUm9tekhXb0xB?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6f2e15-b5bc-4483-8898-08dc85925929
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:04:38.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6E18JmLPXrkj06VRKWIIh3c09lda3lrzqvyhnd+AsQGxV3WsydR6LpF3wl1egU60e5d8x5ZMYt/Vq+PgfWwuCJuTui+OPyMW3oz9n1Sc8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
X-OriginatorOrg: intel.com

On 6/5/2024 1:35 AM, Ingo Molnar wrote:
>   
>   /*
>    * Handler for when we fail to restore a task's FPU state.  We should never get
> - * here because the FPU state of a task using the FPU (task->thread.fpu.state)
> + * here because the FPU state of a task using the FPU (task->thread.fpu->state)

Just a nitpick:
	fpu::fpstate now points to the active FPU in-memory storage.

Thanks,
Chang

