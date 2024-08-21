Return-Path: <linux-kernel+bounces-294890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C349593F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CFA1C21455
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A25165F12;
	Wed, 21 Aug 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyBUtcb4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C681537D1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217441; cv=fail; b=DVV/g+ojRPVRdokDmrQDmHsJjOkIcSvGwjPlFJ7aXYMqGJ3SXgSmmvDHXxiJ2AbHtrjjDjpS385p4In8BdEL4OChIFryrE9l9o04ZbzF/ocprITlvc55Q/3+tQf+wGHeMtJiWwYQRFBV9BqWTOFobvhzHl4LesM1+rCZV9Y8zyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217441; c=relaxed/simple;
	bh=9Df/H9VmARxG/o3FGIWkW56fM8InRcwpg5PSN7Dk1QE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W5Ey4bgAwR6Xw1QiSwzHhj7OmSQCOv7wb0h81p1KTndXsJ0GvzdDI+T+OzxhkrNZLQouCYWfCTUaZ3OffIw8uopbm4pMXXhNdnlWaWrQghkwqtGrk/S5nGKGjV5gpRDOaYiomS5gXlB32C/JSs/pEP4ra5dRkTLQRvogU28ugZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyBUtcb4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724217439; x=1755753439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Df/H9VmARxG/o3FGIWkW56fM8InRcwpg5PSN7Dk1QE=;
  b=XyBUtcb4Nl5Armh1lVBBoD1ErCLgeXPmZR/tDwBcWCyO1xq1pCC5lSRf
   yjX/zgToTyeAXwiP+fjD2sUvpt8y17T5WtsU2Y0mo26hoibiZoZ4u/Xk+
   9lRBvsIZcUYVrDO6QJjZNOoDcPlzfZ6+iUjCpHBrg3MO/hIlvPv5NgvNT
   nlaWjmzSJcN2LCOQw20SHcy1GA/ma90NB1qBdnXFSh44Pv9X9AYxR8Ppy
   TRtjnj4VkZ/ri1v5SZjlxGG9Y3MWY6ByUKLEA9a8NsWmh9ZWZ5MG+6pR9
   O8e6pNy0UNUROx0YdVcnFLbfJbbPl4I2u/GTOinc0mITpn1ukm7F6eay7
   Q==;
X-CSE-ConnectionGUID: BDJoAldsQtaVt5WqHUY3Bw==
X-CSE-MsgGUID: l0Y3ALHaR92o1MiRAihwfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="40066559"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="40066559"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 22:17:18 -0700
X-CSE-ConnectionGUID: fMkZKk7PTBSAs3ORbKvGgA==
X-CSE-MsgGUID: Gf5wVV9BRZe4jq0BArddrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61738554"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 22:17:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 22:17:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 22:17:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 22:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqUPAx/9YqzpXw+W+GKFxqv8F3JByWCzUhg7vXefwlFwo80MkRpROoXE4ltlpqQlwDNW+DKq/jhODAQXVKT+p7uSTkWbKIZZQzNvTebfBcbzSTXmDBiITFQUqrt8MId4aGjArZdxWSh4DPIKpWv42oiMfCaI4ReqGRBm3ZI69urgniDF/yOOS+mfYrLy11NuogJjrQNufxdWjqU3v87gG0M/5n7/k08g9j0Y1gxK4aQ0qWIUXccBgnRqGrQUTPiTNH/cLQxjirksevRvHhnRE/yQS+UKiJTyr4CX8z+Hp6LYNuVrn1lPRUy13V1AFC0Diay44NwrmwnUZPQHA1ppaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kru74DPeBE0S5pdqJqJ0ZnJMxT1ewehPogzLIGHT+Y4=;
 b=RwHm9eCy3+2oQ2oAcy4niO6NDvaWUHbrtaUDYwtd6Cc1Ss4ryJuaQCKl1BriHVTdc8tYO8GcQschbq8q8Yrq6U1CDzV9FXHvS8sErTj3id7muJ8PfmLG+Ficp5mbN30A6s6rgCoh555/h9gZHQRJX2U09Oh+fJZyTy6/0bZsCkjLkYsh6KXvGzY8Bf+3TpCiMAnRcHWZcCk+Zpys+2pArdoxmvNMn77b1P5zLxwde8F5tn95a5aQfnMHw1HFWJY77oy1pQyws88jgX+YsmOzI/COTuow+F4dG552qBxEed5AMEFtysH5Nao2+QP1IYf1ZlywqCX1tom1uICDhGXbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 05:17:15 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 05:17:15 +0000
Message-ID: <0425a81a-380c-424e-ad6c-7ca259986504@intel.com>
Date: Wed, 21 Aug 2024 13:17:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: always inline _compound_head() with
 CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, kernel test robot <oliver.sang@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>
References: <20240820122210.660140-1-david@redhat.com>
Content-Language: en-US
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20240820122210.660140-1-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 729be1b2-5d7e-4c1e-2d7e-08dcc1a08508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWVjVHJwc2xCaElIbm5ibjFtbXR0dGU1d3VPT2x3S1ptSlhLQldZaHZTT0ha?=
 =?utf-8?B?cnhlcWxSZVNoMFRnTXAzamJ6T0pFZHFsSTlPeEllWmEveXl2RFhpQktuOUpJ?=
 =?utf-8?B?ZkZsSkxiaVZJWTcyR2lxbkh6YXpmTUJ2Y2YrbS9DT3ZrVVpydlYvNkxoQ3Vr?=
 =?utf-8?B?VVU1VjRnaWYzZDczcGxiYUh4azFJejJzODltdEppcElRb00vR0I2VEs4b09z?=
 =?utf-8?B?dE14dzZFaEsvNFlRMlowYTdDa2kxSHV0d0NPSHlGQXFRVnA0ZitjMythblpv?=
 =?utf-8?B?MkR3c29Qd0lLV3dhaGhPT0tOcW9seEdpSmhYQmhuRURpb2xKVXN0bDQwQ29m?=
 =?utf-8?B?WEJ6cnpjRk02V1hMb1BKanVEMWVFSGRRNWl1OXZuVk5PeVNGZTZyakt2SGc0?=
 =?utf-8?B?eU5jNzZkVFlQcHJNSnk4K054Qytha0tyOEU1STU0U3h1SDFvMWtWbG0rTGtV?=
 =?utf-8?B?UkI2OVdjc1BKVjQyb1BFdmdqTHlPMnNxM1pFT29JMEc4VnplZEIzR0Q3c3ZC?=
 =?utf-8?B?Nmc0eDB2NTU2R1JJQW5HUXRlREJvR1owNzdhTDhtY2ZNOFZTZzJ0V240emVr?=
 =?utf-8?B?Q1FDczNPYkVjQnBWSWNrSUFLL0JlSFdEMDdSQjFSRDg4aStsbks0RlZ0MzA1?=
 =?utf-8?B?YTZTZXNra0dFa1JZckgwYng3S3RBR1NBODVhUitNbStqSDdkR3JIUHNrNU1Z?=
 =?utf-8?B?QWdVYStmNHBRTUNXZUtQYnp0QW5mNFZiRXhwZTBWb0NsWFBZWGV3TXVPN083?=
 =?utf-8?B?TU9TdkZpc050ZG5JWEhXVGNoTXZlcTFQb2xBWGROOTJRay80SDhUd1lVNHU3?=
 =?utf-8?B?UjRFbmhBQ3VMREdtL3d6RHY0S1h2MHFsbWNhVHNmaDNSd1FLemxJcUQrRytG?=
 =?utf-8?B?RVppTWNXd2FQc3gwRWRFeExoYVRIVmdGcFJIS0VOVDdWTWJENTFlbnkvRTFE?=
 =?utf-8?B?czlnY0crbklsOEFkZTdodk80dXhNN1ZwcGo2Z0hvN1lzbTBCYWQreEhiVmpk?=
 =?utf-8?B?K1dLTEM4TGRtVW5iTkxOZGVtd3JodmtTR1pHaGUzQWpJTXlvaHdKWEtvcWJO?=
 =?utf-8?B?WmROM092SENPMG1CNmNwWW5KcXZ0ZnZzOU5BVnp4OVhmNVRPbnJNanRpbENK?=
 =?utf-8?B?TWI2RW9IU054S0d5bkMvaU02T2M0MjBTMTFDa1V6c2Zja214VEFPdGE1ekNt?=
 =?utf-8?B?NkFoYUhEOThtdXJuKzBnWlJTTUV4M3dHQzlVOXMrdG1qRjdtUTNTYTAwRjBH?=
 =?utf-8?B?WEV2OG9rY3hzVG01RVVlRWRhRnByQ2ErZ1FFbzZkK1lwL1VEdGNqWDJWM21u?=
 =?utf-8?B?aWtKZWtDMkpFalQwMjdSbkdBaWJHM3kwcnJMVDFyWTFuUkRXZDh5Z2RBM3pm?=
 =?utf-8?B?VHN4UnpUWkRXa2kvWWwvNUhxVU1IT1Q2OHdWSEsvS2FLOHZZUDZsZEZwWXdi?=
 =?utf-8?B?bDdhQ09RanNPQXhIbkR5V3BDZDN1U3daaVJQc0VmckxMdDNuZk9tcUkrUWdi?=
 =?utf-8?B?ZnJwNFVadVU3YWtYVG1EbTYxUUFGWUc5RnpJVnJUcFhPWm54WnZhQVRqMkxj?=
 =?utf-8?B?TzErUVB4SzRETzJuQWQ3NkdNTXBUSVh2RmxDeExBWVAydFR1YUszWkduYVFR?=
 =?utf-8?B?ZkNoVElCRmdHMjcreXpHSlprVVEwYjQyZ3I1VTcvWmdDWU9ZeW9tOVUvZ1cz?=
 =?utf-8?B?clQ3VWE0VHovSWlRUVZFQkNQVThFWE44Unh0V1lpemo2ejc2c0JTOFBwOEEw?=
 =?utf-8?Q?9uS6rISwtHxWxJT6bODL1fYQjFOeA96Fw0/Tch/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRORk1FSElYQ3VROVpHSjF0alp1RmQ3VWdHaVpNTm1NaVJqTnhMdmlzOG5U?=
 =?utf-8?B?QkREdVh5bmtRdmhmeTdCSG53WkJ4WEx5WXNEd1VsZEx6NDZqZzdobHprMm9G?=
 =?utf-8?B?SFhMbUN2NC9oaDhXN25OVFF5VVdDa0RQVlltRE05ais5dTRlWS9NWWkvZGky?=
 =?utf-8?B?QlpETjc3OEtaNkFqSDNPd2NYZUpHektDV1V1dEpVYlZ3dHY2eDg1WFd1WTNY?=
 =?utf-8?B?dXFDT0V3ekhOTURIRlBnSHUvUkZHUjBRdTArbjRwM2VTSWhmR3VYSXJjN3ZK?=
 =?utf-8?B?ekRiVzU2VEZSVjU0VEZWL2FRMXVzKzJwVnozVGs5amoxNmE3RWphK01ObHdj?=
 =?utf-8?B?R2pIZVNhMDRCUXVKY0Fkc3FzUUF0R1RIWkx5MmpnY2NOSXFCTFI2elNKVjVM?=
 =?utf-8?B?bUtUdWp3L2dmN3JCanZSemFlczRFQlorZjV5Nkg4SnRHUDFuNXFHYS9BU2lx?=
 =?utf-8?B?NjNtWk0yRGFTYlU2SmZJcm0vUEdyd0dlL0t3aEhXSEVjVFlQNTZ5WVVaSzFG?=
 =?utf-8?B?M2xHVWFiZ2tqUGpObmNJQUNWT25WR0dBbnR1THBtWnA0bjFjNnh3N1FNeEFi?=
 =?utf-8?B?bHV0b2RKYkFEN0NUT2dBemFkSEQ5U2lxQStISWdRK25qWVRyL0l5NVpUSHVX?=
 =?utf-8?B?RTVad3NSTUFWNXcwQzhPL21lOTlncFN6TXJneTd2REpOcGNLMENGZWw0THdF?=
 =?utf-8?B?bUxKeTBhb05FMkc5ekZUNnRIL2dQQkJoRUZKc21kaHhYK0g4ampxRkJpV081?=
 =?utf-8?B?YVFlVDFtVXRZTFRWL1Q0QW5haWN1ZmJCRGVzaFYwM200V2hyd29ZRDJBTTk1?=
 =?utf-8?B?Tjd6aWZESzVOU3JvWmRFTzdnSzFPNEdwN0l0bDl6bzNwWUtGeWpLdi92bVl4?=
 =?utf-8?B?dmhSQjUvekIyR3g3eWtDTDhiaVVzWExObG9jRUltdXErRFp6R21Hdyt5QkZO?=
 =?utf-8?B?aG90SEZmVXF0Rm8wLzUxUkN5SFpPZGgrcjA5V1F3RjlvYXRObHdCODRTelR5?=
 =?utf-8?B?MVFNbWxWQ3h2Vk94Y3FNZWFNUmhab3BPbmNFbDZIM2xxblp0QjF1ZDlzZ2ts?=
 =?utf-8?B?cWZTUnRteC9uSkY3dGJvMDFVLy9jem8rMEx1ckI1ZGJtZmFGQ0RWTFBRVHlO?=
 =?utf-8?B?L3dXaDEvNFZjVTY4QmRQc1ljZmtrUzVvNnBEUWMxOTNIV3FVYWR0OElUU25Q?=
 =?utf-8?B?VW5ONFdIYUp3a0dqNEx0QUJkOVdjK25OT3Q1TUVlOVJ1VTdkWjVXbjVBQTVZ?=
 =?utf-8?B?SEhCcnd0alVPQktnb1JqcTdRZFNZdTBxOUduVnc5ZEViMFprYXpFbW9IYTNo?=
 =?utf-8?B?Z09pR1BjS1NqQUtCbzJLSkx0Z3lkYWNOZWxXTnFBVlN5Y0VGb3loSWpoTEhn?=
 =?utf-8?B?aXJqZmt5Zzd3N3IzWWRqbnhKczIvWUFpM2NVVzBsZ1BOaHJuSjY3VjZQeWk2?=
 =?utf-8?B?THVqOFQ1bTV2ZnM5cGFHdzRZdklIZm5oQnlQc0ZtTEN4aWxBR3ZnVDBxb0NK?=
 =?utf-8?B?elNEWEE0TSt5WlRQdURuMWgzK3ZJUUFsTklpN3dFaVRTVjdWYTRWeGlVMVN1?=
 =?utf-8?B?NVV3ZlJrSjZXaXNVdWFoT2UwRVlzTXFJZ2VqRXVGTUliWk9mcDJUTFlRanht?=
 =?utf-8?B?OFlJaDNYNmNIcGtlWGVycmUyNVUrOGoxdkVZdERHWlVzZHNzaVRDNG1Ed3BN?=
 =?utf-8?B?b1YzM2V2RkdMcFJKTVAvWis2ZGJLbEJ4aWFLRERRL2RNdWpzLzVmeHR2OGpr?=
 =?utf-8?B?VDk1Q3k5czNFRjlvR2FuaEU0V3d3QVdxUXBmcjhTMXhYR2tHbkRpMTEzZU1h?=
 =?utf-8?B?eVIwblg2U0NJOVJzNk5lYk02a2U2ZGVrMUVUVWRtRjJvTHRjd0hHVGcycXI4?=
 =?utf-8?B?MDloZWxqenRBVjdOYkEvMkNhZG5lNUNMeXh5TnQwbTFEL2RPVHc2L1dGVlBp?=
 =?utf-8?B?VjQ5K096U2pWZ0o3dTlUK0xLR0VBREE4WWpiN0JOUmdSTXBOWTJ4Y0JVSUFq?=
 =?utf-8?B?dzNWSit3bEZNbC96cnFrUjM5aTVNY2V0NTRpd1MvdlF0SHBVWlZxZlcya1d1?=
 =?utf-8?B?UHd1MzdrcGxBck1lNXo5cTBWT01RTS9yQUVrNDc3MExreWQrQTZJUXUwSll6?=
 =?utf-8?Q?czERaCNxuPN8WSYHUVOrLrbvY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 729be1b2-5d7e-4c1e-2d7e-08dcc1a08508
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:17:15.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/rJnVACNEWMYeeYMuWzycbsp3oFXLM7ZMq4DkkdyLwIi9Y24iIZCLSSQxB9aJ7q/VG4XHzMsVKcTEEkH2Ju9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-OriginatorOrg: intel.com

On 8/20/24 08:22, David Hildenbrand wrote:
> We already force-inline page_fixed_fake_head(), page_is_fake_head()
> and PageTail(), however the compiler might decide that _compound_head()
> is not worthy to be inlined, because of page_fixed_fake_head().
> 
> The result is that, for example, PageAnonExclusive() now might involve
> a function call when checking PageHuge(), which performs a
> page_folio()->_compound_head() call. This can lead to a slight regression
> of the stress-ng.clone benchmark.
> 
> This is not super-urgent to fix, but always inlining _compound_head()
> seems like the obvious thing to do for this primitive, similar to the
> other ones.
> 
> This change restores the slight regression and a compilation with
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y shows no relevant bloat [2]:
> 
> 	add/remove: 15/14 grow/shrink: 79/87 up/down: 12836/-13917 (-1081)
> 	...
> 	Total: Before=32786363, After=32785282, chg -0.00%
> 
> [1] https://lkml.kernel.org/r/817150f2-abf7-430f-9973-540bd6cdd26f@intel.com
> [2] https://lore.kernel.org/all/116e117c-2821-401d-8e62-b85cdec37f4a@redhat.com/
> 
> Fixes: c0bff412e67b ("mm: allow anon exclusive check over hugetlb tail pages")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202407301049.5051dc19-oliver.sang@intel.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/page-flags.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b753d158762fc..af58b2ad854c3 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -233,7 +233,7 @@ static __always_inline int page_is_fake_head(const struct page *page)
>   	return page_fixed_fake_head(page) != page;
>   }
>   
> -static inline unsigned long _compound_head(const struct page *page)
> +static __always_inline unsigned long _compound_head(const struct page *page)
>   {
>   	unsigned long head = READ_ONCE(page->compound_head);
>   
Tested-by: Yin Fengwei <fengwei.yin@intel.com>


Regards
Yin, Fengwei


