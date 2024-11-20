Return-Path: <linux-kernel+bounces-416321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C269D4340
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB5FB23427
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7E1B5827;
	Wed, 20 Nov 2024 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PN3vAco6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603F487A7;
	Wed, 20 Nov 2024 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732135758; cv=fail; b=pGKgnPoPPHZzlDrdiNgJNqlHFjgoVLtE3PHibw1r2M6OJhneheuOp0q/fWoupg6yqP/MPJWkgxMIXlXrQKrDBenBbkJ9GkVfM6HHPlUYQ0x7vbBe5RAnSpqkoCEq5UJelXT6X1kbYlq9FksCC+t7yXm5solSpQxidoziBF+5q+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732135758; c=relaxed/simple;
	bh=UszeNJgIz8lRSmevcxEDiq6jvPmemaWikNXw0W4DekM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dn2VvUI1vyEofZ1sHshlJrxyhEl29KE8lKn7soc2Kv+wLxilUyPQx+XYd4khiiUuaL+uOt+qNfLgQI+M4ETaF58iamrtEwSLkkfbS8mmOFEYGTbRWk2iL3xGQgpqJVfnIugg0Zeu0KvckONS8ecnsr8t37MhtDBM70Et7eSsX7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PN3vAco6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732135756; x=1763671756;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UszeNJgIz8lRSmevcxEDiq6jvPmemaWikNXw0W4DekM=;
  b=PN3vAco6e6fDCWqHHRUJkk/BcVnm+jCbkB8LW/THTyRCOEP0froVGU4j
   pJZhgEOxLuIbcmxtlRyi4ApEzUbKdhy97SfrKo/xhm1cXBRr7yjeXSdzQ
   LqIl9ROG9aStIawYH+mmIEwHXKsDmBjPkHsYn+MOvYmLTr1DfFFYRStRx
   Ypnn9htQ8M9qehkXStbhx0EjydPjGfyqUqXbTmiuXGBa2RqTNc3JdQAsn
   Uk/uO5jBSynSTsVFMUJkRPiBF2EBk+VCDY3XRZIqLilklfaXppjhzfGwH
   2CE63ky3ECE8/AfGaHdHSgdtTues+ca6lJ2yxER7sVYfwNxQIOfntRsYc
   g==;
X-CSE-ConnectionGUID: u+ihd5G7Twml2VzyUlKwaw==
X-CSE-MsgGUID: lAJGa3faQuCGebxkC2kCmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31585691"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31585691"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 12:49:15 -0800
X-CSE-ConnectionGUID: 6nZgJnUZQpa7cORGZNABAw==
X-CSE-MsgGUID: 1xUMcW41Rsu4PkIut4FrHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90152728"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2024 12:49:14 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Nov 2024 12:49:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 20 Nov 2024 12:49:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 12:49:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sjg93yl2TzDJCeJhfTtXw0CUT/mxKQ4woASs8Tbd0PAwanxfoHI0FMF1IwUj2BZf8xRnkZ62f8olQE1/JfybLsFKg2KHS2Xorb+dS+x5Zax7JFFPLaFlpLgR/9Faf11BhITIojvzeIzdVwwLAgoYxsykn/1ogE6B1nErMtMq9tp9OEAWPtHjN6Jj7xY205Fl4nwvpvJ527pjK1u3/tkPupvG/jriMJXxhSP3rtaW5kk/TZG0+DjtqQXPpqKa4a3L3THpbs6MdmquKSrLfLZRu0NZvSdJeDP/CEAgK4RgUFeKbsqQB4qGfWslEPmogCVnntW8rN56HaO6vC/RpKCGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUCIyUWMzT046iYWmQZIXzIKORY/2Fwb6uE2x/+6Mds=;
 b=Wg40O3OUdiu/dIJVScWJ/UK2wRaEFoRJnO2h6WV4/NUPSQfqPU8RydCM5FipiKHOmJs9zhNOv4UZ0Bf7DmMxGUOEmtn4C6af3tQzwwfUMXxKHrTphHZn/TMbAmfwmcwjtXJAzsebuCPJdnl8HG5nYhXg5uYABZEG2cClg/PqvUSL8nb7SJZIqQ3z3bfoy2RkfCqr7QcuX9hsy1t0ZVESgzRqi5OHLQnDmKdJVSEBgc1Xc1x6a6XZeNG7hVXzm09mS/Yi3VOlpxSm9ZkHuT0ZnT4if97cjLiGseOXJF9ud7pbh8InCDX230KTlrtNDbneNYX0KLb8XdlXGIWWEJMJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 20:49:11 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%6]) with mapi id 15.20.8158.017; Wed, 20 Nov 2024
 20:49:11 +0000
Message-ID: <0d4f2978-22f4-4e8d-a6b8-e6b90888dc25@intel.com>
Date: Wed, 20 Nov 2024 12:49:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: Merge x86-specific boot options doc
 into kernel-parameters.txt
To: Borislav Petkov <bp@kernel.org>, <linux-doc@vger.kernel.org>
CC: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>
References: <20241120163033.12829-1-bp@kernel.org>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241120163033.12829-1-bp@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 432222d0-eb85-41e2-1f58-08dd09a4c922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WEdiUnNyZEVGT1VROEdOUm9RM25Yc2Z1aU4vc2J3elR0b2RNWXFxcjZmSlZq?=
 =?utf-8?B?bzJvYVUvU29ycFVSQzJvM2JCUFM0OVpHNFN2ZURXdGU5NDgxOHlzMUVRWHJa?=
 =?utf-8?B?YWEvblBwRmFwZkpmWDFWb3htOXRYQ3lmc2w0SDhhY1VNZGc0bWllZnhUcllW?=
 =?utf-8?B?R1hEQ1dGSjJEcmFWYnh1a0hnV1hJMldRUi9mdHh1N21rRGlMdFJKUGFWVkQ3?=
 =?utf-8?B?WE01Rk9ubzk5Z0FaZ1NXb2JGUGl1Z01zNmpiMnZqZjZuRWJHL2ZhZFByS0pH?=
 =?utf-8?B?bXRtVS9oZWZQT2l5T3BsbmE4VmxOUmVDQ1pWRFd0Szl4dEJ1eXhYWkFmK1lL?=
 =?utf-8?B?Q0xMV0NUZjk4bFMvTzVUMU5DbnN1YUdyOXBoTHJITVpDQXZvekVaR29kYjF0?=
 =?utf-8?B?MnJpRjUwNDN2K0NSWUVya0ptSE9LbWNxQ0NvSHVkWWMvaVlYYjZSVTVJLzFV?=
 =?utf-8?B?SHlMRFRqdExoelpBaUErUldHNzQyOFU2R2huenVYMEdpd1NzMnpYUTJhbGF3?=
 =?utf-8?B?OHhvSUVBUVdDckpnSTBOZkJOdkNNMGNDT0tpckZsRWRlYjA4dm1LZmhMTWtr?=
 =?utf-8?B?RHBqT29NekhpZ3M0bGZ3RWV0SkZad1BJSHE1ZDlEY05DNVpJOHpvS2ppbkJH?=
 =?utf-8?B?REtCNmg2RzY0aUdocEhJNmo3MmVFQ281SFgrVUhxWkpRWnRrRFFNcWVDK2Jy?=
 =?utf-8?B?SzFFa0FxZ3VDRENyL1Z5SlRPNmw0b09XdkZYd2RtQk5icjZPQk11NnlaMy8z?=
 =?utf-8?B?SzVabVA5OHk3a3pCcnowYVp1S0o2cm9rSTZ1YVhzeGtqazlmWmQ5MkxKS0Jh?=
 =?utf-8?B?ME9jVVdwdXpWMThjRjRpdVhtSFZmZEFHd04rOUJDYUxLU3QwZEZyUUNhRU5W?=
 =?utf-8?B?RTdiLzNieThyWWUwRWlrU1F6d1pqWDFnNTM5OVRETENiYS9tQWd1NGZ4aldJ?=
 =?utf-8?B?dGxCbS9RMlV2ZmQxbklQc05QVlZ5cVRXaUEvWjJoa0p3aU1JcUpJaDh6MUVX?=
 =?utf-8?B?WWZYVC8yKzl1cW5kbVp2YzZzYUQxYjd0emw4ZjhqeFg1bllVMVFtWTNORWxt?=
 =?utf-8?B?bVJFT05Xc083YmM5V3NlMFBDODlIQm5tc1ZFcWVCRzZMMWVPQkJ4NHZ5WG9E?=
 =?utf-8?B?QTVYeFh4ang0cURnOERRbWtoaU83VGw4d1BNTVNmM2ZRcE1EeEFhTVlwTkpQ?=
 =?utf-8?B?UFpMK1M5V0JtKzRGNjI2UndBeDgzcVFGSXhFaGVwR28xaHc1Zk90T0ZGc1Q0?=
 =?utf-8?B?QXhDSjBPWmdYV3M0UERMWnpyQ2x1ZDNyYmswSmZPMGRPYTZkRG8vZ2JOaExR?=
 =?utf-8?B?OGgzazlXWDJkbTRIcUJzSUdnSFhpZ1lWYTJUNGx1cXY4ektJaXRINXRwMkty?=
 =?utf-8?B?blY1QWdsMSswN09nVmhncGJsbFVVVG9kQ0U4dE0xd29zakpBRWhQYmlieEcw?=
 =?utf-8?B?cWJqWEJRZ0hhT3ErdHdNLzRyY1FUbHBOM05VWTQwa0o4Q004bXpvRllDVGJk?=
 =?utf-8?B?ekp5VmtzNFptb3BsL0dhaHVJbDh3d3FwRTBQUlRLTjBabFBqVzNaOStEL0pX?=
 =?utf-8?B?OEtxUi9aNjUwcnV2eVVhWmdUSUFTOHVlN0JZN1A1cGgwYzkzekFBOHk1N2VI?=
 =?utf-8?B?NDMraTdGOTU2bDR3YW4wVHQyZGwzSlpiNzdnYnZaN0hpYSthQWxKOUhWdnRu?=
 =?utf-8?B?Mmk4NjBSSm9rZkJUTE9INVZFL2pEQ251VGZYMTBsS0lOQ3lrMk4wTXdvRG02?=
 =?utf-8?Q?2c2O5hn8+4tQ3EkRsB6RaB2Acr67ZW76/d5jTDa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdZRHljWUNuN0dBSXZlS0NDZmZGdDlQU1BNQWJtNWtNaHgvVWJHbVR5b1p0?=
 =?utf-8?B?c1R5SmErY29oWkxjcWViaWQ4QkRDZ21CVE4rTGt4aHhhVllyTVlabTJML0U2?=
 =?utf-8?B?dUl2UjBhcUh1dWMxL0pWUWFja0IrNFNPeFB6cWpOaWR2VlpJMDU0VVEyWHBu?=
 =?utf-8?B?NjZZeFZyZWRvWVpwbUVNZWJBVVJjdFo5YllCZmI0QllWczBkeE03UCtFNGlk?=
 =?utf-8?B?VzVqQWdweHZlQ1pnRzVOclhFMDU4ZkNYbGRqUEFWK1k3U2s5Tm9mQkF4MUh4?=
 =?utf-8?B?V3JPUCtZcGVlVEN6V2tVMzFTMTNDbFk3eTBjZlcwaFBYZXB1bDQ3dU1PWXZW?=
 =?utf-8?B?cVNtNWkvdGoyTHNJQ1ZxdVJoSTZycUovWU1YNDE3Y0JURjNuc0J1eFRYSUlY?=
 =?utf-8?B?K3BTTGZLTmFMMitvUTk2cmwrY2lWbWhkdGN5T0IzeU0yOFpoblAvQmw2TEtX?=
 =?utf-8?B?Mm9laUc2d055R1c5M1JNekljWDBhRHBjOFZwWk55Um5uU2FJSGlmbVpJTzNw?=
 =?utf-8?B?UUpKT1FEV1FLNGpMUkQ1aXNIUEVWVnFIanZNanBGTEYrR0s0ZEh6aktLQWEz?=
 =?utf-8?B?emRCaFhBMEkvZ05kb0NXN1Fsekg2dVFCcllldStIVzkrOGNxRWltOEYvaEVP?=
 =?utf-8?B?UEpCa1E2cXNJWWFYMmw2Z0tYcjJhdFUxbjZvcDkxdm9QZ2VxaXNsVXhNQ3hu?=
 =?utf-8?B?bDZOZzVkT2J1OVlMUmw2WWVaNWhubXVlOXZqdUdTTjlUTGVZRVdqVXMxUjNa?=
 =?utf-8?B?N3QvYkJ5Z3Z3QmlCQzg2NG1FK2Ixd1ZNd1Z5ZXptK2NJNWpOSllobDRhQmRW?=
 =?utf-8?B?WENVb1lLZGFYeEQvOXBJeUVEdVhad1lpZHd3Z0FxTGVvRWR4ZE8wdzF5bWVT?=
 =?utf-8?B?eER3ejlBYzJESDdJRlFBTWh6WGNUTlN0YjFJQ3ljcS9iZUtodEw2WjFtS0dI?=
 =?utf-8?B?cWVrYlZZRUZneGVoQnQ1TEsvMExnMkk2NkVoNmVENHYwV1FOaEdEd2ZqZk5p?=
 =?utf-8?B?d3YwTkRvb2paamdzbHZKMDNqdkZQOXhxMWw4c2hudVlodEVqVVVCUFp6a2RU?=
 =?utf-8?B?dUVBenRIajJoRStnNFpnb1JkK2lXaDZFR0hBb1pYL0g3Nm9OV3BtUithTUIw?=
 =?utf-8?B?UTczTnB5MUNpdWJmRXZ5NTg1QUc3U0tQTlZOc2dYaENIdGUxWXQrRWdFRXhs?=
 =?utf-8?B?UXNyU1ljLzN2aC9UZzlxb3NGWWFQenZVZFJkdkhSVTNVNHYvaDVNTWx5V1BC?=
 =?utf-8?B?TXEzeHQxVDhVRnFTMTJoeUpyTXBodEkreDZESkl1dW5nZUZTUWNUcmY2Snkv?=
 =?utf-8?B?VnhGSTFscW4yYWZtZ0FaeHdLZVVTUzVvakZCNGJIYi9WTkpPUGVjM2xHdS9I?=
 =?utf-8?B?Ymk1SERwcXFDeVJya0xUNC84bG9WTCtCNmhZbVRkcXQreGRjTGs4aDcvK0Zi?=
 =?utf-8?B?ZzVFbEhlNCsxUEIxQS83ZnNrajRVcXRTQW1VK2NKSDdRa0U1ZGNxS1Q3OXhV?=
 =?utf-8?B?NElZU2I5OXYzd1RjV3kzOUlhaVlySkVyZ0lWN1V4Uk5ORVFtS3NtcWg0Y3ZL?=
 =?utf-8?B?ejY0djNSUDEvNW9SQ1FDR2tVWnBMSkF3WEErM0xkbDJycUpNMHBzWHJYVUJ3?=
 =?utf-8?B?V2d3WVNwNTE5SjdENjYweEtQNzcrR1gvMmNRbXRsUU80TW40SXpFUVF6UzNG?=
 =?utf-8?B?VjJXYjBPM1RTZGJuY0RmNjRBL3J6TXhRbys3a24rdVBSeTNNS3pkTHVIWGtp?=
 =?utf-8?B?Ukx2Tm4xU1QrbDRBZ0JEcGVxSElESndtdytNekthUVBVT3VmNXBWek51bmtn?=
 =?utf-8?B?TnI4aXhzSmMzU241dWUycVBQYUphcXRBeFV2aHM0ME9VdGlWeDN1bDBPNHg2?=
 =?utf-8?B?Vys2bW9QRTNBQmFpc1plV0dyb0Z3S2h6aDBwcytwMHpOOWlFdHNaZlZDNHQ5?=
 =?utf-8?B?U3huNmZtSDJrMjJxdFJNOWRQeGM4Z3JsWElSdnBwSXhtaXRWQnJScEpOcSsy?=
 =?utf-8?B?VDdwcGVOVnROSU5saGx0KzVqOW82bTRBRnJZeE93ZkQyeFlhdXFmazc0bkhU?=
 =?utf-8?B?a21yVUE5aTJmdFdUczVHczk0V2FqN0ZBRWRoa2tUUU94YkVnSk1rdXpML2gx?=
 =?utf-8?Q?aS58zRLs1LcTWcFNrU6wFJvw2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 432222d0-eb85-41e2-1f58-08dd09a4c922
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:49:11.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm/omCnolSZFXLG4PuRfeJ5d3DA12+RnvFV9vxTcF96xasb7Dvz43/S6WwT4JdykHu+YNWqo8w9wwBc9WiLrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8019
X-OriginatorOrg: intel.com

On 11/20/2024 8:30 AM, Borislav Petkov wrote:

> @@ -3254,9 +3306,68 @@
>  			devices can be requested on-demand with the
>  			/dev/loop-control interface.
>  
> -	mce		[X86-32] Machine Check Exception
> +	mce=		[X86-{32,64}]
> +
> +			Please see Documentation/arch/x86/x86_64/machinecheck.rst for sysfs runtime tunables.
> +
> +			off: disable machine check
> +
> +			no_cmci: disable CMCI(Corrected Machine Check
> +			Interrupt) that Intel processor supports.  Usually
> +			this disablement is not recommended, but it might be
> +			handy if your hardware is misbehaving.
> +
> +			Note that you'll get more problems without CMCI than
> +			with due to the shared banks, i.e. you might get
> +			duplicated error logs.
> +
> +			dont_log_ce: don't make logs for corrected errors.
> +			All events reported as corrected are silently cleared
> +			by OS. This option will be useful if you have no
> +			interest in any of corrected errors.
> +
> +			ignore_ce: disable features for corrected errors, e.g.
> +			polling timer and CMCI.  All events reported as
> +			corrected are not cleared by OS and remained in its
> +			error banks.
> +
> +			Usually this disablement is not recommended, however
> +			if there is an agent checking/clearing corrected
> +			errors (e.g. BIOS or hardware monitoring
> +			applications), conflicting with OS's error handling,
> +			and you cannot deactivate the agent, then this option
> +			will be a help.
> +
> +			no_lmce: do not opt-in to Local MCE delivery. Use
> +			legacy method to broadcast MCEs.
> +
> +			bootlog: enable logging of machine checks left over
> +			from booting. Disabled by default on AMD Fam10h and
> +			older because some BIOS leave bogus ones.
> +
> +			If your BIOS doesn't do that it's a good idea to
> +			enable though to make sure you log even machine check
> +			events that result in a reboot. On Intel systems it is
> +			enabled by default.
> +
> +			nobootlog: disable boot machine check logging.
> +
> +			monarchtimeout (number): sets the time in us to wait
> +			for other CPUs on machine checks. 0 to disable.
> +
> +			bios_cmci_threshold: don't overwrite the bios-set CMCI
> +			threshold. This boot option prevents Linux from
> +			overwriting the CMCI threshold set by the bios.
> +			Without this option, Linux always sets the CMCI
> +			threshold to 1. Enabling this may make memory
> +			predictive failure analysis less effective if the bios
> +			sets thresholds for memory errors since we will not
> +			see details for all errors.
> +
> +			recovery: force-enable recoverable machine check code paths
> +
> +			Everything else is in sysfs now.
>  

Instead of double tabs and <option>: <description>, would this be more
readable if the options and their descriptions are separated? Something
like the below wouldn't increase over width either.

mce=		[X86-{32,64}]

		Please see Documentation/arch/x86/x86_64/machinecheck.rst for sysfs
runtime tunables.

	off	disable machine check

	no_cmci	
		disable CMCI(Corrected Machine Check
		Interrupt) that Intel processor supports.  Usually
		this disablement is not recommended, but it might be
		handy if your hardware is misbehaving.

		Note that you'll get more problems without CMCI than
		with due to the shared banks, i.e. you might get
		duplicated error logs.

	dont_log_ce
		don't make logs for corrected errors.
		All events reported as corrected are silently cleared
		by OS. This option will be useful if you have no
		interest in any of corrected errors.

	ignore_ce
		disable features for corrected errors, e.g.
		polling timer and CMCI.  All events reported as
		corrected are not cleared by OS and remained in its
		error banks.

		Usually this disablement is not recommended, however
		if there is an agent checking/clearing corrected
		errors (e.g. BIOS or hardware monitoring
		applications), conflicting with OS's error handling,
		and you cannot deactivate the agent, then this option
		will be a help.

	no_lmce	
		do not opt-in to Local MCE delivery. Use
		legacy method to broadcast MCEs.

		bootlog: enable logging of machine checks left over
		from booting. Disabled by default on AMD Fam10h and
		older because some BIOS leave bogus ones.

		If your BIOS doesn't do that it's a good idea to
		enable though to make sure you log even machine check
		events that result in a reboot. On Intel systems it is
		enabled by default.

	nobootlog
		disable boot machine check logging.

	monarchtimeout (number)
		sets the time in us to wait
		for other CPUs on machine checks. 0 to disable.

	bios_cmci_threshold
		don't overwrite the bios-set CMCI
		threshold. This boot option prevents Linux from
		overwriting the CMCI threshold set by the bios.
		Without this option, Linux always sets the CMCI
		threshold to 1. Enabling this may make memory
		predictive failure analysis less effective if the bios
		sets thresholds for memory errors since we will not
		see details for all errors.

	recovery
		force-enable recoverable machine check code paths

	Everything else is in sysfs now.



> -	mce=option	[X86-64] See Documentation/arch/x86/x86_64/boot-options.rst
>  

> @@ -5701,6 +5825,47 @@
>  			      reboot_cpu is s[mp]#### with #### being the processor
>  					to be used for rebooting.
>  
> +			acpi: Use the ACPI RESET_REG in the FADT. If ACPI is
> +			not configured or the ACPI reset does not work, the
> +			reboot path attempts the reset using the keyboard
> +			controller.
> +
> +			bios: Use the CPU reboot vector for warm reset
> +
> +			cold: Set the cold reboot flag
> +
> +			default: There are some built-in platform specific
> +			"quirks" - you may see: "reboot: <name> series board
> +			detected. Selecting <type> for reboots." In the case
> +			where you think the quirk is in error (e.g. you have
> +			newer BIOS, or newer board) using this option will
> +			ignore the built-in quirk table, and use the generic
> +			default reboot actions.
> +
> +			efi: Use efi reset_system runtime service. If EFI is
> +			not configured or the EFI reset does not work, the
> +			reboot path attempts the reset using the keyboard
> +			controller.
> +
> +			force: Don't stop other CPUs on reboot. This can make
> +			reboot more reliable in some cases.
> +
> +			kbd: Use the keyboard controller. cold reset (default)
> +
> +			pci: Use a write to the PCI config space register
> +			0xcf9 to trigger reboot.
> +
> +			triple: Force a triple fault (init)
> +
> +      			warm: Don't set the cold reboot flag
> +
> +			Using warm reset will be much faster especially on big
> +			memory systems because the BIOS will not go through
> +			the memory check.  Disadvantage is that not all
> +			hardware will be completely reinitialized on reboot so
> +			there may be boot problems on some systems.
> +
> +

Same suggestion here.



