Return-Path: <linux-kernel+bounces-285839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9B0951356
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516871C20F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9C48CE0;
	Wed, 14 Aug 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3+lHEvD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0741C73
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608085; cv=fail; b=CpIKHJXQqm7gNxZHqpy8PQvs9Nm5p5EKY4YKfRPHIf5azma/hpJfzrmAJK0M//6vX7UN4CWhvl65PauddvbbkM6X4srd37gJzyhQxFG2gF+BpoXWRSRM4z/rqfp3Qx+Aw0QiPY++0Jpl8DUz7omAphUI/H+7507+VhjQyp+cJ5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608085; c=relaxed/simple;
	bh=BhRbHHLh5HLAu8a9SArNazTdXPKlBEzCjN3qZtJE4Kw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pRrXQSUAm68hVwPQjs2qmJM8PQhsNtENb5t8VpMvW3Lld9xcuiJ8k/6vVbTeFPcVTlSrTc//Rqvew/tdx2ELNsTrE1vfxpAtT82MGoFXfFqaCrHYCGUPi6t2kS6qOJEZck/8ZDw6votjRWf5wLTGkIbfYxqsNg9IUnO+DTsV6Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3+lHEvD; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608084; x=1755144084;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BhRbHHLh5HLAu8a9SArNazTdXPKlBEzCjN3qZtJE4Kw=;
  b=V3+lHEvDvjbM7rcNAq06wOrtRy66n7GgBnEj+4bDP+6jX0mzegaQVqo8
   TzwGDwMGniotc+c4v8Esyu7jeu1DdvcaucNZKnLmJx4eCabAAJ7cp++O9
   nQkLZNZLGRj3QqkyON7UX8jEzkeFDmK2V5t9Rq4AR6TC0dJMOkPB7xXcO
   opzdYL9N0WF+9tDgyJyPuuc1elLQ6sGRPWrg/VUyM6sPHMKjLpb0P/F/5
   OWezhy0/PcS+QanvnSepQvBySVhp+YJ6Q3H2AP0rcPC8hfuVlVQf+wr4x
   JbjOKaenhI0xF0SE9qxH5IxEGyc3X+qCbuasV/5VmNA7NDfhpIr5bQGma
   w==;
X-CSE-ConnectionGUID: 4p5NjCPTQf25yYjm1OEKGw==
X-CSE-MsgGUID: ZSoURpkgQCGJmceknu9fkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21445368"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21445368"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:01:23 -0700
X-CSE-ConnectionGUID: DEBLfa04RrGlwyvLCyX99w==
X-CSE-MsgGUID: Ci4FYsgsT3yOD5fu361MWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63806221"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:01:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:01:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:01:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3kfdh5IwRpeCrtG8brLa1+a4zVHYG04y2/7kcdBgwj8evERO83l9vUcsS0k3aN3sdr44V3PVc8U110Pl3BQR7irlCZ+0Z59hFEfweKCLthfuoN2HZsaImq3j3Yfqm5wZ4oWaHCxWFOKT1xKHP7/CIHtwCEKoM7c1YlpguKiSSde9PS9cECbzQIVQLee7j6dRHkapIWH4sIcJPmCAKFlWy3SMCV0WyvYJVmfoPL9ClNDKTBYm9huTIaDqI+opybIVkHUGbKxpl+PeMk5JFwxkPxgA/NJRAuhPBJIo480wMfNLZ+LCZcNpdtHmAPmxWf8lO0elCNCKIb2aVFm/PzFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmXH4nnriqe9SS9xsZC1RKBrydcUfRoRMHyyrBtW4KE=;
 b=Nn++TSUO4XXK68N0r6+jahUtE74zf5WS4TsiLjkS9X1sER2B6f64IOAHuYWiQc/2/QD84G+2W9+qPS6eJDeAlofUNn1n3Zq8dZMUPLJJ1yU9qx3EDhjpL4BXW+21HsUifMyZpoqVWMpbvacfd4N67HZWz5/vXSBsf3OTJ2eYMfgqXVv0513Fc/2Tw3VURgI3iejVUv7LlypS2eAzTkb3SC6weCPv7/H8X5gOJbFybUC/DtjoaLuEZwCdQ9T2fzNVuER6z1zzfe1mmjy1Can9hrlsw4NXB683PvgnkWMYMG/S7vOow4MKJp1O3VbIcJC5jRHK9p8MrNJzNz+sJAFgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:01:17 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:01:17 +0000
Message-ID: <a133e3a7-d53a-4c6b-8923-b07774e81563@intel.com>
Date: Tue, 13 Aug 2024 21:01:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/39] x86/resctrl: Export resctrl fs's init function
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-12-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240802172853.22529-12-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2f4ca4-b4fe-4df2-6326-08dcbc15bf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnJTUDlQNFZwdkRQVlB5R255Q0l5clBReGhTRmFXOHg4cGdJMFgzeUNLQnQx?=
 =?utf-8?B?SFQweEFMWC9aTmlxQVZXYlpDb2JZcGtDZmI1eVMyRlhvR0RBOWtwVkcwQWMz?=
 =?utf-8?B?MU5wUWEvZm55QTJXSnFOOVNDMHVtNVNQeUxHSVVueHAwSEdJZUx6UTI5bDJ1?=
 =?utf-8?B?aEl2Z290MjZZYTJncmJOSUdNL2svczZNY2tyWkk2Nmlac0dIMllINjlxaDNV?=
 =?utf-8?B?cmxWRit0UnIzdlJhQTMxd1ZoNTlaQnhZRDJ1SVJzTlNGNDdxdTZxeGhXbkNy?=
 =?utf-8?B?cFdnWEEvdUtyc2lrbm5xMUlqRnc0amZoSmdpMjI1aU9JcmZCeGl4dUgrOFd4?=
 =?utf-8?B?b3RjWmYzWmlSWEt1TnYyNEhnZENydElXeWdKNGo2Sm1KaGw4NmxkUS9FT2VC?=
 =?utf-8?B?VUJJcFZLUVFXVkpMSXJTVFMydHBXRXY2cGdjYktyS1dzdmkyenRYbHhacmtl?=
 =?utf-8?B?MTRROE9LbXZyNWUrTk50Uk00UVNCckRNZmdHUlpNQTVhTHNlR05nNGpPKzRP?=
 =?utf-8?B?aEtKT2N1VlBWWHF4TXFKdXRoUkZWdnlGVVBLcjdmcHRYcldud1RoaU9GZFhW?=
 =?utf-8?B?cDhvazVORk5XaGRzY1A1YXdvN0dOWVd3NnB0OW1ySG93cHVrNDR1RmFBaTFG?=
 =?utf-8?B?L3hSVHppMTljdWZxUEkvdW1HNUIwNWRyUVJJSnc4dFZGMjVFd1BFdkhCQkZN?=
 =?utf-8?B?M0pLcnV2Q1RvZkp2aXVUSm1TY1JCUWl1WWM2ZlVuZWpLM3lEbVlXWlBLMDk5?=
 =?utf-8?B?ZTNKNGFVaU13dU1oYlRYZzlrcVZCUzdhRG4vV3JyR1J3QThEL2ZTVzJaSjFp?=
 =?utf-8?B?M3ZpNkltQlpJdWQzV3Foek1LNXFtQXp1NDFmS24yR0tZOUkwWUZ4M25reFpO?=
 =?utf-8?B?WXJLWngvMXNDQjJRdTc1R0pkNEM1bnNCREgySTJvblcvdVFlb0h2VHlQVGlt?=
 =?utf-8?B?dG1mek9tY1lZcUNzSjdkZk8xVUVndGVLR2d3aXNxd1BjSm03RURDN04xSjBv?=
 =?utf-8?B?Y2Z2cHV4eGRHbWRRNXUwWEdSdjBTSmJ6c3U4dWZ5UldzdE9hc1J4Wm91anhW?=
 =?utf-8?B?dVA2M3ZtV1RKVkxDdmRWL05Oejc0QWJEZGlpUmdFVWtwbmVTLzRZeHF6ZGFJ?=
 =?utf-8?B?TFZGVk8zTkNvb205RTJSWUlqbTBlck9GeFhTNXJmTCtKRGFFTE1ObWk2S3VE?=
 =?utf-8?B?NlRFOWhBNUNWRHBJMjhLNlI3cE0rNzRhMHRrMHRUTGRHaHFqcXBPSStXVFBj?=
 =?utf-8?B?WHdiU2RTUWN0eml3elFwS0RqdFl5MHZSTzhwdkUxL093VElkYU81RnZsMml4?=
 =?utf-8?B?NVBOQTFuRzBPaCtxNHZiRVJESk1ENXhvWXFyemxVTmY0dkxBMmNtQkdsWWtq?=
 =?utf-8?B?OXlQbCtYU1lrS3FuR0szR3RMb0tJbWdkS0FqKzduV1FoWFI0cWhhVHU5YllC?=
 =?utf-8?B?WGpPaUI3NlNxU0tYZ3pIa3VNYU50YWxmRjV5U3F3ckNHZE5GL2pKQTFMamxq?=
 =?utf-8?B?QVpwVGoyb21BN0cySEtaT3pyNStOUldRN1lwR2sxUGR5MG9MYlh0T1E1Vmd1?=
 =?utf-8?B?THR1QnpSYjE5TUkyNDg0eVJYL0RxbHpSKytsYVpVWFlNYU50WTJlWjEyUXRl?=
 =?utf-8?B?WkFhVjRya0hGRFJ1NHRLZWxUVDlleFpUOENGRlRUZ1NqRmxxMDJqajM5cUF2?=
 =?utf-8?B?TGJENzlCWnlIc2hkL3U2TU1CeG82L2JZUFFMZW0zcnNXaVdodndBYUdjcHVp?=
 =?utf-8?B?MWlEa015MGZ0amcrRUllemxGT2pxTmI2MVorUVNVcllGN3lpNWQyS1pJS1VG?=
 =?utf-8?B?TEhOaEcxLytVcDdaVjgzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkhnU1IrZHFIY3B1ckdMQnlPNzU0akROL2hoUFB5RnNyRFEyU3RXNlg1STJM?=
 =?utf-8?B?bjgwbXNpdll2RURxS0UzZUlpV3lkNzVKZ1F6M29Za1g4UTkzNUhtbEdVRW1u?=
 =?utf-8?B?R0hLejdUclZES1FwMkUzdHI5K1pPcllqMENDb1ZwVnNPc3NTcXhBVkpTQTRI?=
 =?utf-8?B?WXdvNUFoKzVwc0pUc3pIVEdXbkNzQkNFZDV0Wi9iQXNGSmNZdFg0dWNSUzQ1?=
 =?utf-8?B?VnNUdHhEZDBVYTF0VnJjc2hGVjMrc0krTUVlYVlzMFpBSGZDWVV5YkN5UDda?=
 =?utf-8?B?K0JrR1pqUGtBNG4yaXJKamk5OHpYQXJoWSt4dmM4UEdpLzJjeUlCTDNRY0E3?=
 =?utf-8?B?OERYMmR5cTRnRWRIaXVMQ080TnpMek8yTlltazZyNlhNY2ZKMkF2WGJJQkVX?=
 =?utf-8?B?QjFhcXF1b1lPd2tQNVFMaUdEaHJlV3UvSllja1U1LzhlMHd3MlNFTGRTTVdk?=
 =?utf-8?B?RWpSMDE1alBodE9YRXR3bUxtNkZGeHlFeCtGOHRHT2hJcm5FMlBEbTVrdEpi?=
 =?utf-8?B?SEdQSHRKWGEvbVk4UGtpcmI4dDNZVGJvS2l6Nnd4eU5qS3ZhWWRPY1BsSFpu?=
 =?utf-8?B?OGlRZ3RGTUlVb1JTTEJ5SGRENTV0N24wMDVqaEZMajVMRS8rR1JpOTNFUjIx?=
 =?utf-8?B?cldNaE9nWlkvb1BJeEI1Y2g3eGx2dXA2UFJSS3ZRdHJqMU8vYUNiMDVKRkNU?=
 =?utf-8?B?WlZZZzFSVXhVNTBGQk1NTW1YSG15cy9aM3dwMmZkYlJhOWlPT3VJQU9OZjll?=
 =?utf-8?B?L1RBaUhIYWtHS0Y2cGNYWG5WNSs1ZjEwdWZuZW1XZjNKQTdVbkJzaGZFbGto?=
 =?utf-8?B?SFBoV2JUL3dsbHlQRFNIbFU4cGR4Sk93SjdzOFBkd1JxbHJWNThqSDg4eEhm?=
 =?utf-8?B?Z29QRitkYi9GQWxrNDE3SjliQUlnU0pFVVc1UXY3OHNyMk84YnNkS05ockdM?=
 =?utf-8?B?YjFzV2xtczB5L09wR0paRERXbFVUeVdueFJRcmFEWS8zYnYrOElseGZNNUN5?=
 =?utf-8?B?WldEL3B0L0Q3M0Zsbk1ONmg4MEo2bE1CaHVlVDJXZEJOYTh0d0JBYmFmQ1F1?=
 =?utf-8?B?czM5TWJYVU1JVGd3aDQ0R2R3QS8zemdVayt6Z2MyendQTVk5TXMzTWxJZmd2?=
 =?utf-8?B?UFVDZGlUUlo1ZVlid3R3Tk50YUkxWFBPOTZtVjRabXhHdzRjRHJianNMQUlh?=
 =?utf-8?B?ZWg4U3hxTGJOZjR2UmJVRzRIQkhiSzhvWCt5bDlrbVVUNmVrQW1zbkJGTldS?=
 =?utf-8?B?SlptODRMODQzbVNjQm8rOXhTY1pvclMzVjl1NUpTY0xUYlI3czUzMTYwWCs4?=
 =?utf-8?B?NndSTGpsRFp5eDVLMlFBSHAvV0RqUldrTGZJa205L3lIRUNxejNTSUM2Ylk3?=
 =?utf-8?B?VkEwNnZ2aGZ3WGg0c0VURHd0QzlueFNDeTI1ZWp4eW9oVEhWRkQ3TWJqOVFt?=
 =?utf-8?B?RkVSam90UnpBYlIrQklIWU5YNDQ5L0daTHN1Rk8yVmdCUE5ja09LNFBaRkp5?=
 =?utf-8?B?UytSVSt2Q0pnaXROb1cxbjlvNFhoOWQwd3huL1oxSDJ1dWREcHFoQ3lrbU1s?=
 =?utf-8?B?bDdob2xkS00wUi8xUndOV0h1U3NuTFJ2eXd0cldDVGdiTnJIN1NlTkU3ODdh?=
 =?utf-8?B?Vjg4cnd5eEhnOVJZSk9DSkxQTEEvQS8wZ25CcTFNb28xM3RxcnUxbHIzR2tC?=
 =?utf-8?B?b1Q2d1F0am9TelI4Sk9UNXhqVDRpZ05XVXFhUUlYZGFoRDM4ZGl3Yk9MaUlY?=
 =?utf-8?B?U3NXcmd2b3h6MjVTMWZFVVM1WXBuVEVaZzYzUWlVUU80cFZrcWhtUmdMYjUw?=
 =?utf-8?B?QSs0WDRVelRvZXQvdGlRclZJcGhib1o2ZzVOaE9mY0Y0ZWpybTl0VWJ1QTJj?=
 =?utf-8?B?NTZLRmNqWHJxZkxtUHg4WS9Xek9CSnJna1RaMUVnck1Rb2ZkYXMwbzV6Zm9V?=
 =?utf-8?B?b0ptU2ZkKzFsUFV0M0lsNnNSVWNicnFrVTlkVTE5OHRmbi9wNmUvclBaNGZ0?=
 =?utf-8?B?cHlkd1BxY28xNG90QjUxYlkrOGxTcDZSQzNiWUlFakFoUFdpZWo2TlNZMFBL?=
 =?utf-8?B?SmpPTm5NbTJOY3k5YWo5anRtR0VOd25RK1dpNlFHUG5pSlRRV3A1R0lDejNt?=
 =?utf-8?B?NDFsVHNrMmkrTHhXcE13VjhjamRCVmt5Wko5cnVYYWR1bk9tajBEck9PU0Rj?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2f4ca4-b4fe-4df2-6326-08dcbc15bf67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:01:17.2255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjSXZVXPXEV0O/+yl0l4u1pJuBsVlrgj7wCcngVJTkmTQml/fRirvtCAXbV5Ilgcy+CBdILRVAAoLJueQ9fWgzNXfNNvp+pW930lg+fHgg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> rdtgroup_init() needs exporting so that arch code can call it once
> it lives in core code. As this is one of the few functions exported,
> rename it to have "resctrl" in the name. The same goes for the exit
> call.
> 
> x86's arch code init functions for RDT are renamed to have an arch
> prefix to make it clear these are part of the architecture code.

Please use imperative tone ... for example:
"Rename x86's arch code init functions ..."

Reinette

