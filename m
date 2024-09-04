Return-Path: <linux-kernel+bounces-316112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6F296CB6F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405491C20324
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B2181CE1;
	Wed,  4 Sep 2024 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZ4vX940"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183E13A869
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494153; cv=fail; b=as9suoqZyyig8bSsQ46bW9GftBTVmk1l6gAwiRN3z434qGjN4ZSrLBSJ69tRdMMmFje1EHcw2NifTBG3D9VJrca6u4ohUIEQzdTK30+ujvWMwvUlspcg6CYFUvAMaMlEHLdbYUihNey/G/V2T7IzMoRuY+gEMAVvFPP1rsWF2ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494153; c=relaxed/simple;
	bh=ZY0mqwSg/jkC4FfEAg58iniH6xCK8+hIp8FNWoQTRtQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAmh3FrvnSGaDHydZuRsrvkaaS6+548vJRGgpfRB8FPW+glvn1mBUCAwwy1DGiqbKVFS14thV3QkwTUANOBui+d6YUPTxdRlZqv6Li3FPMFbNXjp9u99/WNtZL9JkOUZaBW2zIzUDbD/7jfpVy+wEEhZF0xyCC0FMK+omY+/CTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZ4vX940; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725494152; x=1757030152;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZY0mqwSg/jkC4FfEAg58iniH6xCK8+hIp8FNWoQTRtQ=;
  b=nZ4vX940Q3P2j6NE6DyfvEBEjZau+wN6cxnpgH8gAI7xbnUIKyouV5UM
   MoJOx5GmTmvuBNMT6FKUUVABYzKX7mzYJD8dy7Mz4g3OrHlna45eRVJON
   7p8AlH4r/5TIdBL2GUy36YKEhEwU6q3lIyLkJJdKzvlCjfWcAtAuVoMX1
   BLiG4RPvnE5SasL5SlnAuHizgM8EDvAYFgFpBxSuSTLW+Gkm5B/dUbWRf
   f0/1Kwc7zMu71a8WNOCPsh+4LXbO3Jc0AjOLDNfPdsjFhGbWBVktYhhGL
   tCoiNch3zZ+YNirZejg4N+kDtMFO3C6YnKG6hcyDmaxsAl1ZqnT/InuDO
   A==;
X-CSE-ConnectionGUID: +MNgSYxrRUusxd0JhpURaw==
X-CSE-MsgGUID: 4wl8vjHkSTOgAqkMVVoL/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34848654"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34848654"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 16:55:51 -0700
X-CSE-ConnectionGUID: Eiy8qUqkQuiYSya7wO31nA==
X-CSE-MsgGUID: VxlOzmUhTjeZJxA3t2zD4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="65447946"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 16:55:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 16:55:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 16:55:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 16:55:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INfDVresyUwzrLKUbRhoWJl6Rv3xUvqH5zaiWQuLH6vAQ2M27dWy8QuajuuMWUeJ6LR1W1hNreivpOnYxDZOlhtOKTJhUA6967ElDTsAk9W3fe4iQsbb1QJTqyQF5pM6s5LqiaLrtxAFQtS9DE0n2BVwP1GazJeJbhztleuRmP3kPvj3ELk1Quz/frm/9WpzMkS31xIqjpYe48sFcf44TClGTQSUQexpFIryCDE2HKSo9dRszlcKT+JD3oszahM3NgkzfG17m8w6icqBuQexgRozqUlN1Q5599vp5T0UR8anR5mPxOYcHq3Q7F9GQGpWUGK4UsScNeD0FmgEsVZXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2Qx7jsNVcXrYLd7Yw3H9oBKWojn6aDAUpr4UH0kE4M=;
 b=dc+4KgR3Pf4An5M4L9aI/6hRWUvTgahuHgH5BKXVdMzPhW8nPdQTYdLhVFOp2stR0nIQnpKl0yPpSzAseKO2DmjuH9ishZN3rsjIcIM92rqx0YatzonQPW4QLMvgJNu84ISOOXSfZkutd5jymA63dWLtuNLgT26SXrFqoHE2nMWGZS9roNQWsZCkRHrbaMonMgsNWBRFmQ62YQ9FzFwzRqcoo5ZEQLl79d0lgkr4DGnq/F/TFcUxf6oK2NZSjKgVLKyMI9Jqiy3WO0roh/P/0Sc9F/m94eDpl7RTkWnI63D3PXnZ8hpa8S7dDcuuaDQOZi7EgiXFcqgDu+Y4QVoEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 23:55:48 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 23:55:48 +0000
Message-ID: <bc122388-05f7-4c62-a608-9b34df03199b@intel.com>
Date: Thu, 5 Sep 2024 11:55:41 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] x86/kexec: do unconditional WBINVD for bare-metal
 in relocate_kernel()
To: Borislav Petkov <bp@alien8.de>
CC: <dave.hansen@intel.com>, <kirill.shutemov@linux.intel.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mingo@redhat.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <luto@kernel.org>,
	<linux-kernel@vger.kernel.org>, <thomas.lendacky@amd.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>
References: <cover.1723723470.git.kai.huang@intel.com>
 <47d9f1150a6852c9a403b9e25858f5658c50a51d.1723723470.git.kai.huang@intel.com>
 <20240904153004.GAZth8_Jz_aJh_C_ur@fat_crate.local>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240904153004.GAZth8_Jz_aJh_C_ur@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce0eed7-03a7-44c8-05b4-08dccd3d1923
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vld6Rjdmdkw2Zy9xZEVHZHhLSFBSeGpYV2JBRCtZckdMV0NrdXZ3NnpGbzVh?=
 =?utf-8?B?cHZQM05rZEV4cm9memNSOWZ6c3ZwaXRKR1FZcExCSUZkaFM3WHRjczg4ZjZR?=
 =?utf-8?B?WHJyYTQvV0tvSFhlQWhJVjdtd0tIYUpha0ViRVRhekhsb2ovRkExNzdmK0V6?=
 =?utf-8?B?WlpNUkg5UEgrWTJnL1o4cVJpY2FtaFBhNzBRQjhVbTI3VlVFV2xLaVJjem5x?=
 =?utf-8?B?dVFHemUxRHY4YkRIVERneDNveTMyZnByNmtMR2U4UTkrR3ZLRDdwTEx1a1Bl?=
 =?utf-8?B?Z1pPclYzOFRLWWg4blFQcXBvOFhlcXpZYzc3eVpKakpkVU4vK1BYNEppZFJ3?=
 =?utf-8?B?TkZ3TTRVMmp3cWhUWUYveFhXOVY5TWZyeFFTNHNFd2gwK1AwRVR4TldpdmVO?=
 =?utf-8?B?cTdNUnlyaHRxdVlMLzZBMmVWUnRVS2tKSkMrbUE4dkdUZ2Z1MEY1b0x2SGxj?=
 =?utf-8?B?ZkZWRVZVbmRORmE0QUNPeHdQT2lHZ0VHckx4akdJUDNzM0wyVDhsQjUzMmxY?=
 =?utf-8?B?YUtxTmhtcjlBS0NMT3hjY2V3YWVvT0Q0S1NMNXdnRGtlWmQwZ0N3cXl5all1?=
 =?utf-8?B?M0FvRW1JNkI5VDRxcnEwNGovSHJJMEVjMU8wVG5Zd2Y5cHIzY0Y4em5XMjNi?=
 =?utf-8?B?TWlucE9JeTFQUWdsMURpMDBpMTJBVXhOZjY5MWJXVlBjem1TcTh3LzdPaHdo?=
 =?utf-8?B?MVlKb2hhOHM1T0NWakZKMDZZSUxWZHB4SCtBQ0kzSXo2OGJEa1J2OTRCMEJE?=
 =?utf-8?B?OXVFT3FOQWk4MWJsM1pYdjlKME5vVXcydFQ0ZCtZdDhydlhpd01JM2VUWHFU?=
 =?utf-8?B?RTNmN2pkUFZjajZFbDZNN1hiLy9ocGRUbVlxTDh5SU14MnFYRG5ubFYzNVd5?=
 =?utf-8?B?YU5jL1ZpUDBMeG1ZeXFCaFVabnVzaXcwbEZNbWIyTGlNTklRK0dWNlJ1MDFj?=
 =?utf-8?B?VmxqYjJtZVd3VUtXbEwrRzhBMlRpU1p5WUwxMkNtZlZuU0xhLzJCVE1HSnU5?=
 =?utf-8?B?QVkzL0dIWjdVbWR5bkVvazVRTkMvckZtdnpMZnNwNWRqN0FweUtnSE96aTVp?=
 =?utf-8?B?T25sZDV0cEZQVUVlUEZyRDRKVWJBSHMvQ0lkZllJMkdUbjA0SDM3RDN1Nko3?=
 =?utf-8?B?UXVwNjJYSVNJREM0b3ZyWHdTZE5LWmpUcExtU3RZcWh1V1hNaURraHZxY2NL?=
 =?utf-8?B?ZVBVYkovNXdUcE5RZnJwdmh5bUFDRjNRVUdmQVVpQ2crdU5pT1RNK1hjQkpY?=
 =?utf-8?B?Smw4cE13d1FSUnRLdXJqaXh2MTNDYUlIL096NXRJQUlJZnkrMnFFc0RDWDZJ?=
 =?utf-8?B?VG10M2hHWUk5amZPVkdmeGZVQUhUVDFMVE9WY0h5OS82YVRjcjF0Lzd4bWQz?=
 =?utf-8?B?NThlNFhycFp5VTBjV28vTjhXSGJpbEJjOStOQWpaUVM2Uks4ai9WUU1BZEh0?=
 =?utf-8?B?b0gvR1ZjZXpSUXZwRDNITnc3OGp5eERkRlkxeXl6VnVSODFjd3hNMTlxOGQw?=
 =?utf-8?B?TDM2ZitxL3dhc25RNjZEMGNOUE5wL0VKS01IdS81akZ2MFlnZEN5czdwOUF6?=
 =?utf-8?B?WjA4S2UxSTBaZFJxMXg3M2RuQjBnU3lYSlZDQUZ0K0p0TW45WHZ2WThCOVpQ?=
 =?utf-8?B?RkFlemUwMDhVNnEyeUEwbFVvY2pLN3c1NExVSHRwa0kxYUlFSEZFR1F6ZUNO?=
 =?utf-8?B?YXVleGdXYmdXL052NWxuVkdIRzFrMWVBWE1xUzR6dXg1MmVUc1FxQ0tRQ3l4?=
 =?utf-8?B?THVielhOckx3MHZ0ZXJBOU5NR3RvMlVCaDcyUlZud3JWdHpOMmlreFB4S1FR?=
 =?utf-8?B?SjVrTnJPNjBXWnJ6WXBzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjBwaWxrR01RZStSZTIybjdJOUNGdlcxN0xTU0JWTS9qUlZkeFhiM0ZLSnlI?=
 =?utf-8?B?ZmtZTFBqL3BMZVh6aDRFaVM0NnlpaDRoVCtLbklhRDJHSHdaL0VzTXhPMDln?=
 =?utf-8?B?bFFwSURkazNEL2oxSThmM0dubFhVdml3K3VxeG9EaksyNHdGQjBoKzI4UVJv?=
 =?utf-8?B?NXRLcEhQQXkvek5hZ2JER2lBR1VuSnRvNGIzWFl1cGpjZHdlRkw2S0x6TDF5?=
 =?utf-8?B?UjVTR0EwR20xZ0RuKzR6YjI3dEJqNFV2cTlkQWMyazJyTmhwbFZNYkVNdEEv?=
 =?utf-8?B?T3RRcWlIb0JBanZueTIrNU1vbEgxS3B2b2FHTTB0Y3pyMXBvZ2RmZjB2UFJk?=
 =?utf-8?B?UUIxK0c2ZWNTZEJkbkJqREFqVWJVRWo3ZTQ2WXM4U1FHTXY2SUtTRS9vbmJy?=
 =?utf-8?B?bkVLcEdvakhPRHQzN0gxaHhUTElqOGNYSldGYmZNeTJvQThsaUVlNC9lM1ky?=
 =?utf-8?B?V1hIcElXU2g3UVpXT0FoRGEvSU42U2xGVGdmajh6bFZ3bnZBZ0ZNL2xCdGVy?=
 =?utf-8?B?cjZsNFNxZkI1eXEvMUZzWWF0U1RSREo0ZTFmYXo1alJNVkZjNnVZeG5WanB5?=
 =?utf-8?B?N1VmaUdkV0FRUzJra253SEltbEl4Q2Vud3owK1lyclhsU2QxS3hZRTVIemY1?=
 =?utf-8?B?d2FDZ0lQUEhyU3JMQTBham0remxRMG1wdmdkRnU5N09VVndNOGRSV1BERHI0?=
 =?utf-8?B?REtveElJS0E0Z0JVTnhtblRqRVllTVIvNW9nQjEza3BLUUd1YkMzOVZ0OXZw?=
 =?utf-8?B?ekNidmRScGVmdUJLQktiRFVaaHhhcmVzZ2h1SmZYallURjNOUExUbSs5eDJL?=
 =?utf-8?B?TVJEWGVFUU03U2NoVDhZK08rYzAveXdKSm5sZisxdFBJbXk3VTJpMFlyYmdN?=
 =?utf-8?B?Q2NreGdrVVJscUtJSWJEOERMR1FDWHFtN0NOS1gxUjUxbXN3MlRCcjcyYmo4?=
 =?utf-8?B?SGpVeFBkV1VCdXlJQmdYY2VjemNYWG43Q294MnF6OWVYMCsyMWFvb1I5bzdY?=
 =?utf-8?B?RVFvY1JUTkdDTDZFK29rL2Y4RlBPQ3B6K1d2ejR5dk1lYlY1SnFEeGUzRFAw?=
 =?utf-8?B?ZW5MdHBWbnZ6a2tuZHBVMmFwUk5LRVZSS0ZTdFR0ajJOVVJ4R053MFBNdkRT?=
 =?utf-8?B?V3NYM2ljZUUwRFMxL0o1R1JDZ1FaZWg4YzZndWluV3ByL1V1OGlGQTNOcXlW?=
 =?utf-8?B?Z3N3cHdGajJFSksrUGY0eS9WL3EzNXdjNENPLzFrNnRTdUpnN0tuOFdsSjUv?=
 =?utf-8?B?SG0zZlBlNy9mM09QVzhiK00vSWVYM3NoZkg5NjRMN21QWmpnR2szNUFRSXc0?=
 =?utf-8?B?bFZnWjdMRVF5blFqbGI1Q3VGUGE0T2Juc0ZZNVp1K2w4TGZ4VGNIckhNR0JD?=
 =?utf-8?B?dG9qaG9KNzY0ZHpTWDc1Q25iTlRGSS9qK2krRzJTWUlDUi9vNDJMREJSNEZU?=
 =?utf-8?B?elJJZi9OaUFHUmFyK3hHQTN6UDhtUkd4aHpkUGZxY0wxbTVBK3FvYllZSW9X?=
 =?utf-8?B?aG53N0NCYXJLem0rSmQ3U1EyYmlNamprQnU3U1A4UWQzQ2tmcmF2WUlWWW4v?=
 =?utf-8?B?MG8yOERLdG1tZFduTjFZeUI3QTh2WWt0bi9rRVBnekdyU0dta0FmazFpWFBJ?=
 =?utf-8?B?YkFUUGhYNTVPK1Z4MzJoVWdlWDkrd1NTSDh3alE2MktWODZMK1dwNjZKQjVO?=
 =?utf-8?B?TVBlOU9rbVJxcjVlaWVEMy9XVm56bGJuTlViam1BT0JQditMWXNJcWpid0I1?=
 =?utf-8?B?L08rVzE4OXlvM3o4TEdFOTdLVWlMeGhCL25POGhWbWpHWWJxWC9Fd1YvTjUy?=
 =?utf-8?B?SHRia251dFFqb3VaSUxxVHdhNGtFUFVFNE00SlkvQzRhWnpPYk5SQUtxYXVN?=
 =?utf-8?B?MjlibzNZTE9vRWY4aWplR0ZIYTlrRnFMdklqeFBwMkNUT0NCVStJY09MTUNH?=
 =?utf-8?B?VGNRWnNFLyttemdJclNxQzg0VC9VSkJXaFdXWEg0TGhpSFM0UkF4R3hzWnNU?=
 =?utf-8?B?NUk3aUZ3azVxbEZ0WldRbDVhNm1jZkcwMHg4UFhOM2x3emlzKzh0czlCVk5U?=
 =?utf-8?B?Ump4UFg1aVpSN3pjQ0dFVkVrcmFpWGY3cDVUNkE2bEFFcENjWjFKK2RSSE5i?=
 =?utf-8?Q?hBnM3YZtKHOEAozuOBRkoc8cc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce0eed7-03a7-44c8-05b4-08dccd3d1923
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 23:55:47.9916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqZH6TzLNv5quiPPf0BWqmDdIvQthr32BrDecqQdsNV8LoJNSWi2G4X9Uo4yHTjYLWqrz85FWSFX60jLaXb1cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
X-OriginatorOrg: intel.com



On 5/09/2024 3:30 am, Borislav Petkov wrote:
> On Fri, Aug 16, 2024 at 12:29:18AM +1200, Kai Huang wrote:
>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 9c9ac606893e..07ca9d3361a3 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -392,7 +392,7 @@ void machine_kexec(struct kimage *image)
>>   				       (unsigned long)page_list,
>>   				       image->start,
>>   				       image->preserve_context,
>> -				       host_mem_enc_active);
>> +				       !boot_cpu_has(X86_FEATURE_HYPERVISOR));
> 
> Everytime you feel the need to check a X86_FEATURE_ flag, make sure you use
> cpu_feature_enabled().
> 

Thanks for review.  Yeah will do.

