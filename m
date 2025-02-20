Return-Path: <linux-kernel+bounces-522759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D7AA3CE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77EC178C20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4535976;
	Thu, 20 Feb 2025 00:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8qEPsf+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC4D2FB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012367; cv=fail; b=eSk10XxXe/FeXOCsbnDRfhCg9rq1OTJ3QaK+0sLhnioHuzCBePUujKJaBYRhOK40eldsdxIpblPV8cOujFlArxKmlj2SQKYmxAs8uVsJfErR9BCzOAyRtOgiPtiZgWzfyB6VciZWVuFpyfb1xJ6LEZ50LT/iMQNL/kqqMue4JsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012367; c=relaxed/simple;
	bh=C4MKfyHEe8DH1ieVUK7k075HD4HCuUv5+8W2XzYvTRE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=paYQl5+ZhhyCLJIvBDhsFieOfK2/gixU+OcBW1o+6XbYLVm8VrA9mnlDs0iGLl1g/cpJIFLfCOKrx4FX7uz9iD3zxAwsaHYupvxO/bhrRtCkIgFdUgAQdAVQjgR+F97jxti7dk9vooR0SJKUDHlwltRdWWjmVhuc7DiVprXSde0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8qEPsf+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740012366; x=1771548366;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C4MKfyHEe8DH1ieVUK7k075HD4HCuUv5+8W2XzYvTRE=;
  b=k8qEPsf+8p0gqGJAVXn03XYa/2KWOL2VUd3LNWypNuBBme9LlV7zc6Is
   X6dc8schs5eykVBmFGFmvYJF7/PzHsAmciF8s36BzxqrJnMAQa5olH4+J
   l0tkOqhzH/1rldKXrBD5y7XJgY/nV8LlxALUGsa/SEMbQhx+2j1s3aQYR
   rVeBXp4THmlOZTk5tcJ2q2NEolZUv7LJIWn/UkpWklR1OFfHcF9+SQFrn
   PXLBGeaMFoNLJwRkaEEuLdQ0BR2oMCNlfeczNfDo9H78LkshqGNvq6U0Q
   UiInObE/+bebdCdTz7HXEcyA2x+zWNLTZDUmCmQUNCzgtygmOHyBKGGX1
   w==;
X-CSE-ConnectionGUID: ZzudB1UNQNCrcGn7GEmH5Q==
X-CSE-MsgGUID: +Gan0RWXTEyQenzsh/H+Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40896140"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40896140"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:46:05 -0800
X-CSE-ConnectionGUID: BhGNHxnVQPyoQ3+i357ncg==
X-CSE-MsgGUID: TShvbe5jTiaNXYkL/f+0DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114727027"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 16:46:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 16:46:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 16:46:04 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 16:46:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrSXPsrk3xYeVFPAFd7xHgHKaiY2mrEdcOAX+QKkpzzMBbv5SUHdUD4cUkF3Yp+pHTLhMnMfy5XDo6KMqN/MJKCjmnct1aHiH/mqy/sYAxWRZntYp0Ctf3jNgPUXfkbDBpxbD7VrclkouprBeGjpuu8d/4bn2MziyYFq0hUGx8h+HIJVzA6HQac7z0E+nmtkO+CxpQbQLGXos754lzY2eO9mtHdYVECuIeFxsi5eGUVmViWIoRWqi9bYBjgK90l2DxktsFutNoeXvCW3gzk3f8H/D9+HtWgtdWCa5bvoyyYpkxvHpEM0xWiU9p75iKjEHfy5rDA7smovW9nBpZq/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5aENOVHXjVPaHF7nTuN1iOg4MlRwyRslU4S8X78NeA=;
 b=OL50ZOoWa1jM577wGkYwf01UzI+xPdOV8/fa/vVScE1D4iklLZA1OJi641fD7w665w0c2NN4yvGVMwShSiQp+00ZeYy7hzwhPHx3YcD1GrIDhC3qbojP1fW+QQaho2agSzacXUJIuWafoWqJUnh/94bGOf30ekynb1x16nk+vKdJqKL+cM0AoS9YFikh1C3YRclPVmRVP6lLt4ojiDzxCsLc1xgsWrn9wcRCGaGwFecK0tyC30e6JVK1omvsKFxkIGyxtycUnGEIu3hOKR0ijkcwHI9d8eeKWDWwj5hHq26oNHcBrdkgT3hqDda2/x95ONOBBd+pfRm0OS/eOyxchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 00:45:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:45:59 +0000
Message-ID: <7694124a-b75b-4472-a88e-98be909895d8@intel.com>
Date: Wed, 19 Feb 2025 16:45:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/42] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
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
 <20250207181823.6378-23-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-23-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: ae58d43c-693a-459e-148f-08dd5147f17d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0xLRHpWT0h0dFIvaXBjcmdDUENCaTJqUXlkYXJTZHJuODA4TklObWZrd2VS?=
 =?utf-8?B?TlFsckxFdHVrWU5PQkFBMDE2cXRDcFVsTXBDWGVsZ081WG5rL3NHMnJNVEZk?=
 =?utf-8?B?bDRJZEZWQU9hOVhOYVN0N3d2RnRkODRsa1BiWDhyTXBObW5nRnJkVmM3THJi?=
 =?utf-8?B?bHFpU1RZQWZVR2VMQmdQN3BMc21keTl6N3E5b3hpeVBkbTluVkl1N0xpTlZF?=
 =?utf-8?B?dWVWNzBmSUg3MTcyeC9BUlpabnRRZVB1dkRIVmZLUTR5L3J5aWVvNlJvcDFF?=
 =?utf-8?B?ck8yd0Rhc0NWcDU3Rkw2TEdjeDZCZTZxRTVjSmJlSGd1U3ZXSkpHVUFpTklG?=
 =?utf-8?B?b0tPWjlsVmhYTEFpdG5OTkNNQ3AxWkFIeStTMmRicElsZS9vNUViTzJpSWsr?=
 =?utf-8?B?cVdyNi9Jbjd4Z3hueG15UTFSYXhJa2IxSXdwdFpqckZ6bDIzVk5EL1dST0d0?=
 =?utf-8?B?TzY4WmdmQXJiUExET3NyVUw4MVRBcVl4MTA2a0xaT2lrWEhLRW9TUk5qTldC?=
 =?utf-8?B?WVZmSk1EKzhUcnBCTjBzS2VFLzhtSGV3ald4SFpBMzkyYmdKVWw0WnpHYVND?=
 =?utf-8?B?Mzc2Yno5MmhRTXRkdXNlYjV3ZXR2Mm9JUlgyMFdqUHJPWEV0VUp5QU1rRW5C?=
 =?utf-8?B?R3U3VUdIOXFnVUp5NEpSMThoTlhLdHVsUTY4b3dLNDgrd0gweVNxSTFjMGda?=
 =?utf-8?B?bE81YVhkbEJFNWlvcWx5c0NQQWV2d3JsRHZ4NUdrY0FSME93NG5jNzgvVUhW?=
 =?utf-8?B?ck5uNEZ3NjRPd3pyRndJVmJDTVRUMWFqamtsWHFhcEFDZ3FqbXVKUWxPcDZz?=
 =?utf-8?B?WFB2T04yelUwWTZNN3Zqb05xK1NDZFBSWlRUWXhEbWJMUEZaTUtMZ1F5OStv?=
 =?utf-8?B?TTErY0NzZml6Q1V5VUhya2VGaEFFWEUyRUF1elBITmIxakRwRFZUKzZVUDQ5?=
 =?utf-8?B?MXU2S0M3QUNrMG9yZGpkMy9tSnRqNUJ6bGMyVVhxVHZ5QjY5elVCT3BDZlcr?=
 =?utf-8?B?VXluNU9sU2xOd0pVQ2tXZmRVZHBySTJCd1VXVS9GQTdYWnkxU0xuMjZucDNP?=
 =?utf-8?B?WnhVdC9Ta3FRN0VxZGtYWUk0UnpxelhwTHdEVTJIcGU3SzdPN0lkTzYyazZa?=
 =?utf-8?B?dG5ueXBBZ2pGVnJubCs0dDJtQlpjMkswV1BkZ3dFeEdmVVpIZmRZZVdEbmht?=
 =?utf-8?B?NXRNMmUrZmZPNmxSVWZZTGV1VFJoNnJsM3lTL0VDeXVMMlBodVpLVUZ5NXgv?=
 =?utf-8?B?YzJMc3VkRHJBSnpiSlpuVWZpamZiR0hJUFQ0SWI3RUJLMXFwT2I5VXhyK0Uw?=
 =?utf-8?B?ckl3RzY4NkQ1WldYQ0tKZldxNlBYRW41eGhudUZ2dXREaHgrRXBrZ2kxTlJr?=
 =?utf-8?B?a1JYejUrUDFXcVBMd25NaWdpTGxpTlEweW5DVkY3SGE3cnFyRkdWN3RnSTlG?=
 =?utf-8?B?UHVmV1NHMlFYWFRCZEZyYXhZdWxmS3ZaZkNTTHh4ZWZXYmRBd1FlYlZ0eTV2?=
 =?utf-8?B?bmhTSW5TL1ErK0Y2WTBJTDFZOXFjRU1iVHJTK0JKWGcwUDdzOFpscFZaRVVO?=
 =?utf-8?B?VDlLc082aDI4YmlET3VaMDJaTmRFazgyVkNIbnk2MjRuK2M1MDM1ejhmWGJi?=
 =?utf-8?B?aDFxM2ViRjMzbzBSWHBGWVc2dVpSZHFYY2xwNDFSWjhmQUFhNkY4QWluWVM3?=
 =?utf-8?B?OURwK282Nm5RN3o3T2dxU3lhaWdUMFRBV1Rhb3RCbVhpWWQ5c3JhTWVrMGRw?=
 =?utf-8?B?SGdwRlI5K2pSTG5ZTGtQMXROb0JiSHVla0lZK0d1MTRmRTRhYUF6WHZuZytr?=
 =?utf-8?B?N0dYVW5oWTcyaFdNQ2Z0aEZTUFdseHgxY0VyODNmb3VJRk5ReFY5dHUzRnNq?=
 =?utf-8?Q?5PwwDrDSXanY2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5weHgrc0xIZllNcWtxeGxjSndLRnZnd3p2eTV6Uk5QWlYxZ00vMXMydmlr?=
 =?utf-8?B?aytZMDhqUDI5UzBhT2pIVDdIL2YxMFpHVjUrVGNUY3RqRmVsQjJPZkxEa2M3?=
 =?utf-8?B?THVNNDNqZmVDd0JCVS81QnRDbWJxYzFYdjdMU21YdXY3WThEWTBnV282TjhZ?=
 =?utf-8?B?WERneXMrWHNwUXR5QXlyZWdWalYxN0djVDJ2ZForVTIrSEt5UnZ5TnVQSHI3?=
 =?utf-8?B?V1dKR29iWnp0bjNJSWg2WHJTNUp2cWZOYXdxUG9tajhWbk95cnd6UWtCdnJO?=
 =?utf-8?B?SXFpNHVaVWlER2VMdmxNbjRlYTJyT1BPcjZHUncySFJqOEM4eEdYa29ta2pK?=
 =?utf-8?B?ekdITU8zcml5cmQxNzlBZ09FaGtNV0FNOEM4cVRzSjZkKzM2K0M0WTZJQVFo?=
 =?utf-8?B?MkxsMEZNcU1TbUxjL1pPeWtaQk9LZVgvQXlycUt0ZURSY2xyMTNiM2NsNDNm?=
 =?utf-8?B?YXdTMFgyc0FzNUdsYllhdjQ3dTMyZXJpRGt5OUVxTnFEY2tYTlZOUmZvZXFw?=
 =?utf-8?B?eUNSWldyK0FmNHI1d0JCSm1yM29kczdSM0RLZ1UvT0lFcVZKUHBHZ3pOOVlv?=
 =?utf-8?B?WGgxRmNSOHJKQzJZalVsZkZxM05kbVZuTU45VFNxRHRUYlVvMkROUy9PcFI4?=
 =?utf-8?B?dm8vNU5IWG5RRzlNSnRwMHBVQWhUaHhFSUpORy9PcHA1MkpWRXUwYWFjb25n?=
 =?utf-8?B?N1RzTHZlam1XZGwrOUM0eXpHM1RWNnBSWHQ4STVnVUUzenRRdG0xN2hPTDlE?=
 =?utf-8?B?bG9ORUY2NkJnWFR4K1N1MkFYU3pZNmp6Y0Z3akw4aUI2Nm1WRVhFUTVJSVlS?=
 =?utf-8?B?aFlTbkE5a2R0bm5oOHpqbU8xQ3RzY0xMMnV1TElreEFGQXpuMWJXcXVWUGdn?=
 =?utf-8?B?d3pRYmdybHVYaUQyRUIzR2o0cjB4QjlVRWhyMXF2Q0VRTG5SczRtdFkxU0Z4?=
 =?utf-8?B?THVYdGpBdFI4c2FsSkZKY3lnMU4zbVFHZFB1SGZSMmJqN3BpdGZpOUdPbkJC?=
 =?utf-8?B?d2hIUnZLSUUxRHphWHRwd2Y2QWJlaGFjbmZHOHovVlkvSUZUMkYwK2FoYjdX?=
 =?utf-8?B?Z3hIaFQveHBGK2RkMkJKcU15VW9ZaURlS2k4UmZIalBXSDB1WldRQjR2RkxX?=
 =?utf-8?B?S3AzcmpZaTdkTVpScVdTRVJnNlV2QmtIeWY1V2l2aGJHeVZISHkwR043L0JM?=
 =?utf-8?B?SWVDUVkvcnlndlErRXpRekQ5REZkdTlrWWFSckEvS2dYbFZFWGF3YzZhRjBi?=
 =?utf-8?B?Y01ZaTJobFQvZGxuWkluaXdpT2UyRDVjU1RyQWg3YmZYTTdTbUptNmdLRmJU?=
 =?utf-8?B?Qk93U2tKQ2RwVjNOd05YSkhTOWtxRGYrTkZvSFUzd0lVbDhlbXVDWksvSzlm?=
 =?utf-8?B?em9wWU1qTzYzVXc0UW5Pbkoyc3YxbExkTWFabjBRR2JhT01GMEFKWVB6eFNH?=
 =?utf-8?B?bmJSa2ZaSVhjMWhnUUdSc0YrWGhxekVvMUw2ZHFXK2ZsRm1DU05vejV2azgv?=
 =?utf-8?B?elR1U1NOTml6eVRrcldqWlRCR0YzNGdkL1pBZWRrbUJkcU0zYlRjZWlwQW9S?=
 =?utf-8?B?OVVVd3ZiNU45b0IwYnJWbWg1MDBwQ3B4a0FwaGRYUDFBaCtGd0hTZm5aYXBr?=
 =?utf-8?B?TTNMR243K3VVU0lYZTlybGxFRVlQYlppVkJSSXBhZDlXdU1PWGZUdkE4U0M4?=
 =?utf-8?B?Qzk2Q3dXcGphdnRyL0xKYXAyZGgvL0JGQ29uVjRpS3ZNdktVcjdBSWFmUG1H?=
 =?utf-8?B?R29xaWZPejRrUHd6cDNsSHRtZ3k4WUxYY1ZIRUhSWFRVYm9iT3dUdzVndFNx?=
 =?utf-8?B?ellJc3RrUFh3cnRHV1puYnBnUmJWbzZ5eHZXLzNxWEp6V0tTUkJ1L0x5UWZz?=
 =?utf-8?B?RXE3eHQrOFJaRHZhS1dhMldFVHIra1Urei9BM1l0Um9LdUpNbjYzWVhMNmMy?=
 =?utf-8?B?elNzWk5LdjEzWFdsa1ZJaitqTmxGdzVIWkswelkrekQ4REc0RXNxcXQ4MEw1?=
 =?utf-8?B?UzVYMk5LUWFkTEZ4NUkzOXlScjdHZEc2RTJTZEVRUUM3V2FxbWpSUDJ0eHNG?=
 =?utf-8?B?c3Z5SWUrVEZtNVdRZUZMalVWeklMM2lRTlVWdTB2aWpodUlTcW45N1lvSFJi?=
 =?utf-8?B?ODhSR3pZcGJNa3hDRThqUWdITTdyUVF6RzZWcnMzUDdwQ2RkaXppZ25CQ3pR?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae58d43c-693a-459e-148f-08dd5147f17d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:45:59.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vor03CYfZILJDGMSyxqHdLSx10V7rIn+LmT+HqSuzVM9oZ5bryiTiIegPW02P2S7dDqQSLPUk92M9tf2Wfm23u9V1piIE9YdaK1L2E8ALRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> The mbm_cfg_mask field lists the bits that user-space can set when
> configuring an event. This value is output via the last_cmd_status
> file.
> 
> Once the filesystem parts of resctrl are moved to live in /fs/, the
> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> this value is output to user-space, it has to be accessible to the
> filesystem code.
> 
> Move it to struct rdt_resource.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

