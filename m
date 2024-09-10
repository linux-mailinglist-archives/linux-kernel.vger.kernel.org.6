Return-Path: <linux-kernel+bounces-323876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF41974490
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8390DB23807
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D881A76DA;
	Tue, 10 Sep 2024 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGmfoTlv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CB1F951
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002558; cv=fail; b=httCecuCElZ6Kn3p2MTqZ+QIOzJ5dbwTjEdLRV2ZPJs4LhGWY8Qw0eylLBXdjScTV8WLv4SjtBGd/hISBv9IYO1Z3d6z+pu0JxgxE5EK8+PratzXaTxQf5VUrvgpd6xDFgDt7s+6kIrVMGT/d1eGfXXdHPfWxc8KVCyF59hzj5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002558; c=relaxed/simple;
	bh=CXFuw5AoybP16icTHkxgh7JhNik9/3VTGoL48DloIuA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BakfhnFCzrjEwsqNCWSPHIyP8DgCXZFQWzIlsOj35URRDbQL2AC99kXBB+6f4kN8/MexdwcZDiO9Ie7q7U9HtULnUli7tUQo3pFn8KafNgzDxIetgGOoZpLBk3Shx+ur5GJtJehPbzVdWmlkIc+DdTOXvPOqiQjaLJGF8ftgFE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGmfoTlv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726002557; x=1757538557;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=CXFuw5AoybP16icTHkxgh7JhNik9/3VTGoL48DloIuA=;
  b=CGmfoTlvnPoGmejWri0wz3ErEQBMRjRvzaCL5Ps4EPzr97IfCmET1nqF
   KztAAPZFL7FrlIRyfjLr9eCRmcWUUp3i2Z9KaD+wrCzkk9qUiA7fvAZ9F
   BFck033+7SZ2X0TlGIeep81cxCZ1yI3a5V0nxrmKCG6ugKEKEVcpIKQge
   1znB80heGX/8eEwocgFw4sQfjuOs4Itvnv1UN8GOPp1ND/vLxbglyMU9P
   Q52svOQjJPABrSsBXjJdnpE7GhJ5SN/ERN+G6gG0Gycc8Fws+znhnaN5R
   ARaOoG/ch1R3Yx63FVV4z/4LlFEu4M+Xy7H0+zPGUvHvHqwILs2N5MEn3
   g==;
X-CSE-ConnectionGUID: rY1cfbxCTv6MMDasumyz6Q==
X-CSE-MsgGUID: GJa772SeTX+SdSVRZ//UnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42295351"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="42295351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 14:09:16 -0700
X-CSE-ConnectionGUID: nVqdnCQKT4OMf5QtRpmk2A==
X-CSE-MsgGUID: nyHM0hTDSqmG2KiuhQWEzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67106378"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 14:09:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 14:09:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 14:09:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 14:09:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 14:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4scWmDjfzthY45vqg+oT16mGaMmh+jNCW2ChoUubU/zPWrFf84Qn6ASthMC8O9cD8ZhkDqVPmhfZl1hJ3irVdwe4bwxw8Yc1e1+RNMHflUQFwG0NuYoMmQPdCpTvP2izkd7c2Qhrmnv/VEUQNUvoHsALuCsFKW+knU+k4+VIVn4nD/aY1YDJodNOdHaAhSQeaUUjnsl+UjT3hoYpKLobklGScvoA+di9xcJQ1JtEAuog974VDn2S927jMrcZk3qT4f3ufQpHTsv7SPbZgk8JuwoTckD75TionGPQk9kUgr4p7oogqiG7v9Sef7tlkv9JSiKvrIs1Fx63zbTZdoZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkIfzI0edLNEr4A/XwFa/1DsAe3Yuoztf4JbyTp+Qbg=;
 b=XRMB6VPOiezja8hnciUbNlZdT6VrEJZb+UE0T/L0WZVxpEAxg4Ro8ue2WkL+pXT+pUL38jKuRSbpDNflqnRFWQuIhlvFxw8K1fxbJKyXmrR38e/bkBxB1JTIt1BxK8m9MDqrMvcTOPUJeT6jZwnQhsDjSxQszZzI5tGU2BrR0sloQ7hZBPIYx5nQHE4z/ygDtHTSsr4CGIeKVzMSFJNift11lLbOJgH1oyZevfl4M8KvETU9hUvwzY0EBjL+ITdkyyiDDfFUP9d5/4QYsTQGdhDTDPXLVcwLz/qkWfMpe+l01pkiq5DTz3OfL7hAFEF4jGqyFKYQSSyd3pwNY77pGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 21:09:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 21:09:10 +0000
Message-ID: <16a795e7-5cc3-483e-8c29-f8d1acc0057a@intel.com>
Date: Tue, 10 Sep 2024 14:09:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: PLDM supports parsing the `DeviceUpdateOptionFlags`
 parameter
To: Shawn.Shao <shawn.shao@jaguarmicro.com>, <linux-kernel@vger.kernel.org>
References: <20240910030330.1880-1-shawn.shao@jaguarmicro.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240910030330.1880-1-shawn.shao@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 78728994-b9d8-4d86-c667-08dcd1dcd0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2pORzFGRUthQkJkOWhBRDEyb3ZjZmZMK0RlNG5ZSnE2SkxycXZ5UXAzSk8r?=
 =?utf-8?B?Mlpad3QvRDZSUS9icG9BMXhOZTkybG85Zld2M2FoN1AreW5FUCt0eVNWb0hN?=
 =?utf-8?B?djJJd25uZldLenNaS3hWNU9wdXdHTVdqVlk4OWR0dG5EWEZyTmxwM3ZUdUtD?=
 =?utf-8?B?ZWFmZEFIcVFSRC9NbitKT1kvVDh0Q1k3TmJHUmc5bnRBR2hxZXNqTnB6Zkds?=
 =?utf-8?B?Smg5eU9pbXBUNzAzbnRsSFRteW9RdytJbEFudDNEQk0waFBNZSt4VG9XZ3Nl?=
 =?utf-8?B?cC9YbTNzWWZQeXZ6cDJXb3h3cUJWM3hoV0FHdnNUbm1qTXFQZkdOTXNrWUpQ?=
 =?utf-8?B?M0d5a0xQdG5EbHh3YjZOZDVGV0oxZFVXQkowUFI1Lzh3ejJIZXdmc055QzVq?=
 =?utf-8?B?bStncXVFbmVRTEJTRUhtQVpralNYdEo5T2RBblgwNHVNYmhmMkhHQTZOeE5F?=
 =?utf-8?B?WStwdnhwcmNLcy91cVk0MCtyUUtibjJJQy84UFByeTNVZFRRcUlZVHRGYTZM?=
 =?utf-8?B?MW1pVHZBM3l0ZVZTUGxZOCs2dHJISTZPKzlBbDRWWEo1ckhlaW9HN3paOUtB?=
 =?utf-8?B?Y01ONHhQRUpwTmdJV0F5OFlnckpQbE9kK2lBSGpKcXVINmRVdlJqRklMU2tq?=
 =?utf-8?B?ZmVMSzNmdlpJSnYvaUZsNmJrdG5WN0JPd2FzM3QwcExtWkNoUGZqMmNuV3NR?=
 =?utf-8?B?SXI2MWsweXBkUUxlRE9EdG43bmlwb1ZvMmFHQXhCdDYwbjJHU0VhSlQ1dEdP?=
 =?utf-8?B?N0NYbjJvTDluUnM3UVMrTEl1SG5LSUo2OUZlVGtWWWhlSm12cWgzTUdKSW83?=
 =?utf-8?B?QmJXeGRQUzdVM3NFeVVsSlNCZUpRRjI1NkVtUmEyN0c4Q2hiN1hHbWpwRzBk?=
 =?utf-8?B?b0RHeVRoeWJ1WHhnMGZMWlVmUk5ZTUhLVDVaVkhmMnZ1REp5bmdmazdlaVI1?=
 =?utf-8?B?MzFjenZyK0tZVXpSTXJVbktqWFQ5Z2VCbWY2SG5JbVlBNWluVEJHQXExS0oz?=
 =?utf-8?B?YUN2SWdVQ0NVYW9vUDkvTGxPOXVGeFg2VzArbHVydXFKam5nb0xMTFBBWnJE?=
 =?utf-8?B?SUJnU1FiVTFSN01zeHRZUHdVbms4bmRQa3hXZVAza0ZSSGQwRGpGb05WbFRM?=
 =?utf-8?B?K2IwMGNHVHNBc3IrKzloWnpneE5rbWJ5QnlYS1I3UTBYeUZLMlRtM1BkNXRj?=
 =?utf-8?B?OEpmdVVQU08raHhQZDRYcWtVb1ZZcERzcDFTZG53bHgxN252bUxsbFVKeTJp?=
 =?utf-8?B?ak9RdEFPbTU5dkZJQWo2SjJYdWhBUmZiMm9MbmxEQWdNdG9ZMkVKTTIvSkp1?=
 =?utf-8?B?a3dEMGpnWDRoWXZpUWwzaW5lTk1HSzF3MlM0a2ZuVlNUZkVzYVZZbzFsaUpH?=
 =?utf-8?B?OVN5aTZSYWwwN2w3MFpmTldYM1V5UmdaTmxuMHV5ZXNZZi9zNFlsU1Z5ZXJB?=
 =?utf-8?B?RW9laC90SUcvRzZ3VmVhbFdyTVVISjM5YU40QThFTWxybUtoU0taeVpvNXVp?=
 =?utf-8?B?cHFHQ1RCOHdMNFhIRWFhVmdtZ0M2ZHFtMGhaVFZpZXdjeGxBMGxRa21FbkpZ?=
 =?utf-8?B?UFF1cXk3MW5rdTBHN3NFaTZrZTRqdmJtODFnWlVCSjB1S1NYMVBnSVRrWG92?=
 =?utf-8?B?aVRXVm5yUnBtZEdoL2p2QWdkTDZ1d1dJY1haZ1BPVUlUbVFQbWQ0WDE1QmZ5?=
 =?utf-8?B?ZE9aYkd6UVpjTUF5M2w0Mi9kK0Y2NldodFhiNnlZcHhYQUc1ZXVGWkdLSWFw?=
 =?utf-8?B?aWhwYUdBc2VScVNxaVByWXRzdkhkYWhSTVNYcG9pUGdrOE95TjBrVURGNnpk?=
 =?utf-8?Q?JIK5d6c4m/ZTx9F5xVz2vg6LtSUX5H0njvoIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdPTmNBVWNmTmlJaDFoMXZ0b2d1T1BBb0NHd0tXK3FCdXFzYkd2TGhYRG9E?=
 =?utf-8?B?UE82Z2JtNmNGRWhON0IvMG50YmVyNnh6ZWNhUEdZN2FhRitkdll3OFRlQkxY?=
 =?utf-8?B?MHkyTk9VUm1aMkljblFjcjJ0OUx0eStENWljVEdSUnJTZytLZ2M1cTZQTSs2?=
 =?utf-8?B?VUp1QkhFM1hZbjFmUFFqYnpsKytzTThCSGxpalRlOCtaZ0N2alZHd3hkN2VV?=
 =?utf-8?B?M0NhdWhHeWphZWV1UTNxejdibnZ3L2ZHM1ZyTkJnOUs3RityZGQxcUVDWndr?=
 =?utf-8?B?WW9ONWZDNERDOW9qQjd0ckFjN3hoM0FSSU9OY1ZTNjRmNW9iYXpXSkdBUG1X?=
 =?utf-8?B?V01BUFlvODJ3MWxHQnJ4R2JJaFdMYktGdGZsenZnSkMzTnMyTEptQ0lObjdz?=
 =?utf-8?B?a1J4NUxneW0wTW1MSTJxNGpzRzVZRUNid2dUYWJpOUs3K1lrRWxCZExhNE1Y?=
 =?utf-8?B?TU10VUJwZGJSQThqVVEvdHM2Y2xsNUs5RHZNQm1mLy9wWUtaT1ZuOGFLZ3JM?=
 =?utf-8?B?RnhTckJqc0dCV2JIV2oxL0dzVmdwZHQ3aU54dVlGdVBMQklUbjRXRStWSTNr?=
 =?utf-8?B?YlFST1VTaDNLamxZcDhlNWRNbmZtY3hENmVBUVV1RlFycXJaK0c0M2xObTFt?=
 =?utf-8?B?eEtVWHN5cmlIdkdOWTBBV3pEbm9IbUJ2SEI3S1RvNnJpK25vbmQrS05PZWlJ?=
 =?utf-8?B?TGpvQUs1bU5Lckh1eElPVkRibWh5VDFYOFJUSEQvcGtVb2ZzeDVBbk95UWlV?=
 =?utf-8?B?dWVURnkxVThCSkxqU2xQVXErZXhMcyt4Njc3YUtVYk5WcmMvMy93TFRQWURn?=
 =?utf-8?B?TFpjeFljWUtmNjVVeDBobUExVmV3V1FQYVkySjRSSjhSTWgrckp3VXFnbjQy?=
 =?utf-8?B?aDNNWEhwL0hIMWJRVWNqQldId3JESFk0bGloMW8wb1lWcW9XZm16dUt3UFpT?=
 =?utf-8?B?bFU3bmUyNXRUczNRRU9zUVFSQmxQb1hwemZlZEgzcUZRa2JTTStJN3RvbmlD?=
 =?utf-8?B?S2VpUml1Tjh4M0hrOG5JMzkzOGVHUnpKU1NjdjhSNWZTaEY0ZTd2V0VPQkZ2?=
 =?utf-8?B?YlJ5OUd5LzEyM0JKNGF6aXQwUGthVXk0VnNrNjBuM0JUem1GL3hwajhvWWNq?=
 =?utf-8?B?OS9YRHk0OTBUVzBHRTcrWlFLY3ZiSWtScUVTWW1UaGJnSzdVWUJGSWxnbGNP?=
 =?utf-8?B?M2J3NWF1c2QzdGFUZ0hobG9BMUtHMEdKMXJBMkNZS3l1NVNaYTJiYm9SNGx0?=
 =?utf-8?B?NVFZSUVVY1hoTXdwTEhxMHRUb0I4czNneE5kVldHdEd4MHJsWFdMTzgzNVJK?=
 =?utf-8?B?U2FYWVgxQTZEUS9ibEhqREVwb2d0dDVVSmlIbzJmWTdUV1EyNWM4Ym82Y2hK?=
 =?utf-8?B?NXRZYnpRaVM2UjYrSmVDR25SWGo4SjFEODUxTVFoWGJ3MnduWjFzSVVBN2pH?=
 =?utf-8?B?am5WTzhFbHg0Rk5hVm10RnlselJBYXA0N0NTSC95bzFNSlNNbFpsWlEvbVlY?=
 =?utf-8?B?RVIveHR0MVRMeWo5d0kvTXl5TGZtNnVIL3dEZ1dsN0hyYWpnQkM2QW02c085?=
 =?utf-8?B?byt3eFQxemMzZ2g1WmlYbjBvbmxLODc2aXV6MUMxR0V6T05UbGlMak9PbFZI?=
 =?utf-8?B?Rks5TVo5akJ1YmJmZGR0VDQzRjhJSFBpWnoxNml2WlZvdGFKUkRybGZ6bzdL?=
 =?utf-8?B?VEZDQzJIU3AxaDVDRWdiMnc5djFrcExNYWJHazUwV1p4bDRoL0ZtSWJIMmc5?=
 =?utf-8?B?TUluM2xyTEZ1V2ZFYVY3SFFWUWxQQ2JZRE9USUVXRmZ6UG1rWHoxQ2FjKzdN?=
 =?utf-8?B?WUpKd09hL0o0VDA1OE9yQXArMWxVNWxuREh1VU9jekoxZGNYV3NKc2NISDZ6?=
 =?utf-8?B?aUs3bnBzUEh1azVvczZibDRmZlVjNHg1NW9rc0Iwd2twejdkWklVaHFCOGdL?=
 =?utf-8?B?N2MyV1dHVldzd2NxMmNKaHVZVFlVaXlMbklhclVpRkdGWDZ4emdHenJHcC9s?=
 =?utf-8?B?dXVMZEZidnF2clNkZVRpUEVqSW9jWlJYc2p2VHdDTUVPS0J0QXJjZjFvamZ2?=
 =?utf-8?B?cCttMklPb3Uva1V1OHdNQWhONm5MaCtxMFBzUCtvdzlYTUhKOGlvditrMmE0?=
 =?utf-8?B?NFFsNDlRVGRLS1hTWXQ1V1QyZ1U3REdZYUpvdUtRRUdsT3hVVUo1VE5sZnNr?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78728994-b9d8-4d86-c667-08dcd1dcd0ac
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 21:09:10.5633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjpAvSdOXtw6aSmU64YOiYhSIvkZUepTCzPAmZn35vx1lnwaIJJujVRehw8HJO9+iFeObnjQ9ONt/iUnon3pP65T34DUkXvIVWPHygzXSYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com



On 9/9/2024 8:03 PM, Shawn.Shao wrote:
> From: Shawn Shao <shawn.shao@jaguarmicro.com>
> 
> The current PLDM library does not support parsing the
> DeviceUpdateOptionFlags parameter, which is defined in
> the PLDM specification to facilitate the transfer of
> control information between the UA (Update Agent) and
> the firmware.Please refer to:
> https://www.dmtf.org/sites/default/files/standards/
> documents/DSP0267_1.3.0.pdf P37.

Just to confirm this is also spelled out in the 1.0.0 standard on page
26, available at:

https://www.dmtf.org/sites/default/files/standards/documents/DSP0267_1.0.0.pdf


That's important since we currently only support the initial 1.0.0
standard format.

Thanks for fixing this oversight.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

