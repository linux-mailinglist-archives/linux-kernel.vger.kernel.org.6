Return-Path: <linux-kernel+bounces-522937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD39A3D04C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC1189B9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F11B1D516F;
	Thu, 20 Feb 2025 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k777lzRM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94D23A0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740024560; cv=fail; b=rNgwqLU//S30DT8U6AAAHx0l/X/r9an47teUIUC4ge/RMu/M3n7luBLJ4OnHHIZ4tfV97vPmd8dOlcCtEKJfk7FNajvWgF6NrPTiUThRK8c5I1oOHPiq8+u2pLrSGaF8zU1RhMyrfStC4ShPySgkryVzwHi1B7+oGI/bhlk1uKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740024560; c=relaxed/simple;
	bh=NpK64Ik5dFvhrsenSQa2V+C+wC3KXzbaHlBiCl/FxCU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ayeoAupPJwf3Rgp4Wv5GrC/iBkJ2jetL83xVPnfRy5UXBfHFZsCj2aC3x3qplDtp8ilFp4e2k2rDwb/NYJZEzqIcUcykqIn6Y1NLjutuvEVjrCTqp5cr1sZYgpQMVQwbSPU52m+3VrHelfUW5H2KHyFAl9grhGSwEOVmTvoZ95I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k777lzRM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740024558; x=1771560558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NpK64Ik5dFvhrsenSQa2V+C+wC3KXzbaHlBiCl/FxCU=;
  b=k777lzRMpsb44+E6RbEQTJGjQzzCc1UVXGwkr5G6Iv0KzSOLLXD1u4hm
   yMgJTR/eIvO3gqAm862wHIFc5mcbj0QCRsZ0WlRkXqwdA7w6ip6ZCLVpv
   bm7VfB0Xwko3SfJQ4LJetJvkT2XQmYarcrRXDdpdPyBEK9VgKSARpkyfH
   fRTPUfu4mReXwSZwdLaIJNLPjhdU7XV5Wp3ggTHDgOww2sps98rUE8BOi
   QOcmIpIJArr9B+QdjZRp3fApo4dgzp81BD6491BCQuU24dSFbp76n6T8X
   TtqGO2TZD9zgj5hmMuICsO9dBHySxxONmM+tEwrMPqfw9/vBa/MHGs4q9
   A==;
X-CSE-ConnectionGUID: qby8IFk0Sv+3qJg+tV+AAg==
X-CSE-MsgGUID: PHd2s23QTJ+hu6oHcPG/VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="41045942"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="41045942"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:09:17 -0800
X-CSE-ConnectionGUID: iRYLUnoJQ72fg2yq013nCg==
X-CSE-MsgGUID: J69XcO0cSXWRGvgmOy8kxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="115590194"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:09:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 20:09:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 20:09:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:09:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPe5gzduGC8uPBoFaD6AgmuUlbYCGS42A9/rVaFvIWzMu5A4ICy4o43pLYooBh7zs/CJGQlirHrm55IS8GY/0WL23JqhcIUFuuhyCYH2lA0/Y0K2cD0eSLjeN6BwL2HnLCJRs2BpnCYuva+/mEwJ1VaAvPHxh3cAuAHDNqULrsSjiDusN4cMyQAggXjdiUjocg73WkqnzW+LoXLiDT9rzWZ7Uaxrm0/EtxB88C+fZ/jxfYQz4HNIGTtBrQtc6yZ92+zNgNv0je+ygk/+uTAQFzrKXvE0NUFwTqrid1hyB5063tLvI9yOTQsZOa2g8urlJrGJj+qtSPq4GmfCZjzing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vajBTnB9OCRK4I9M54VaLMnXfg7JikAPj8Q2cb0ZLNM=;
 b=virSDCXm7+w8CbFXAUS9TX9XlK+eUnFUhO8HbCpeyUsMiY4gjV+un/1FvMLSf7XdmY7sa1Ru39Ltdmd2dx7RvS8JVXHa0k2i9Z4gGab8PJtGacv14xyBwoM5So8s5rWWrniHbN8Nh3u/lA7VQfI6hseRz7T7si4kpxUHmVOWXIT5veNFS0NUSMuxJD7LJLxrE09SSnOaShntxgewumGd1Q0gdGgrkeLlYAkUsKkZnhXbCVE+/OI5VBGiIqZLJeF5+GaLHOv+2MkOoWpq0Kcdp0ooMdSmGTZ/4cwKsG+tHgxZ9RGbgB4lnoBZKrIHvY+eGnOF1DS9JaWON8Gjdz4Gmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7973.namprd11.prod.outlook.com (2603:10b6:806:2e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 04:08:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:08:44 +0000
Message-ID: <c735cf97-dc26-42be-82c9-cb37f96e896b@intel.com>
Date: Wed, 19 Feb 2025 20:08:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/42] x86/resctrl: Claim
 get_{mon,ctrl}_domain_from_cpu() helpers for resctrl
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
 <20250207181823.6378-31-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-31-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0f4d72-783a-4f02-cb05-08dd51644470
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d29KTDI5Zm1maGVjZ043dVdhME00UmxlaWxYRkhNQnArOU1WSGZmUUN6SVlv?=
 =?utf-8?B?ZFVjVFR4RW8wK2M2Tm1LREMxUXNTOS9KVndYc2lHUGtuVExZcTBvdnAybXk1?=
 =?utf-8?B?eWRHZjhnRy9EMEgzTXNtR3UxN1UwZmVyY2EyWm1QanRHcFNjbldab2VQejVr?=
 =?utf-8?B?SEo2TXZnaXFVcS9SUHNFQkFzU2hrK3E1QXdxaXBxTzhzeUJxb0M5WURSR3Fh?=
 =?utf-8?B?dDFHRmRXMW8yNkNqQnZYYjQ2S21jVys4S0ZMYnVDMXNqR2FNVFJjRCtzSTZE?=
 =?utf-8?B?Wk00SGJNS2dpNmdkQW5aTVhia25ic3BRcFA2bmswblZXbjRNK0g2Z0R1WHAy?=
 =?utf-8?B?b0xJSWZKcHIrMG5Nc0VpQzZBTEVkcktsTVNHVGJnNmtLNk52cDRTT3ROaEJK?=
 =?utf-8?B?VDJ1bDNDaDdqOGdYclNVZEpUcW92WUZBbEtiVEVPZCtXVDZtd2d3REg4L0FX?=
 =?utf-8?B?QkdKK3lIU0EwaklFTTBLMTRvTk82djhzRDZSZUV3MlNDbEd2QzRaM1dPeW1x?=
 =?utf-8?B?WlJORE80YzJhRnU5OXpaSkI4dEF4djNVMW5teGVWRkd2U1VLeUQ2OHlwU01w?=
 =?utf-8?B?NHpXc1MxMW9nOWlMRXFHQ1JCUXVENWVBZ0VIWmRDcHJSVW5WLzN6ZlJyRHpw?=
 =?utf-8?B?bWNObjM1eS94SlJYWEg0WXBKdzFHckVNZUdpL25leEtiNEhlNzM2NkVYWEJv?=
 =?utf-8?B?Wi8vVmdlQy9vVEgzVEFTcm5GZ0F1ZXlLNHFoSmlzeDNITUFpZ0RWVC9MbEE1?=
 =?utf-8?B?N1V2ckJZLzJnN2w3c1NGTWNER2V3bmpNZHk1R1AyNkRZL3owdGJ2ZFRtdzRa?=
 =?utf-8?B?NTl6NWlwbklxZGNDNVZDa0xEdnN3NkMxWUl3anJkOXc3TFlQWkdGdFpRWlZ3?=
 =?utf-8?B?cElhZFA4RXJ1T0pzT2dLTXM5UnQ4eDloV0ZtUy8zL2I0RDVyOHNnNFN0Zjc2?=
 =?utf-8?B?UXVtUk5ER3ZBd0VxajJnK3MzTkxYNExPODVzUTR5aUFvazZCMFJtc1EydnlB?=
 =?utf-8?B?Z3ZrcS80bVdQUzZKVTNIKy90OHVGZDd3eXp3cTJhSXRPUHdIS3lxTUtlaDFN?=
 =?utf-8?B?eUYxTVBXUGc5NUxrQVFSZnZmaXZKV3M2NDgvaTk1N2czaURBNDcrTnlXc3lP?=
 =?utf-8?B?a1FKbG1oL2lwV0NUcklMRTBOemw1K21qaHNwN3dDSFJxY3JYdzVtSTNQTk1v?=
 =?utf-8?B?bWRkQmhsK3E2T3R6RFdwWjVyemlyY0ZOQ2dENFIxZ21nYW5pTmRmYXZPNjdm?=
 =?utf-8?B?YjVnMWMyYkxqVEprUlpqVlF2aWRvQzYxd1RETlhOcWFMS2NZSURJYVBzVnNl?=
 =?utf-8?B?ajRpQUkwRVZFQjBPVk9ocFphNER3NEhMQ2E1K0h6ZVgxUHEyZWNWNzhqT2tS?=
 =?utf-8?B?cFBWbURwMC9hLzk5cm1jSitkRGxyeUorb25qdHVjcXVWZk1WN0pwTUhZUlpm?=
 =?utf-8?B?M3ArWGV0Z2lsUWtVS2tSMDV2cDl0RG9XOHZIZXR0Z3B4MWxDK2NQdmRWMXRQ?=
 =?utf-8?B?ZFhFL25pRjZDZjkvL0FXYlM4M0trT3V3bTQwdmc3R1dDN2xmUjl3THZuK2N1?=
 =?utf-8?B?QXVQb2R5Z3Azcm5TcVBrenBhOXlSOW9tOUFzUXhtc29PblRkR3cwVHEyZE5o?=
 =?utf-8?B?YkEvajFybjFXTGM1SS9iTFVaMk5INURLSUxMTkd6NTNlbEhsYXNUQnRvUkFj?=
 =?utf-8?B?Z04wSFFRUDRzTUlqUi9VdnhXS3p5bFR0ZkRUNSswaTM2dWFSd2JoSGlQWFo3?=
 =?utf-8?B?MnA2OWdlNWVFQ3IvTVhqNVIzZkRIMHdMdlZYNlZsbmVMa2J5UHFBQ0xzOWwv?=
 =?utf-8?B?S25xNFh1bDFvRkQ0QXl4WjRrbERJTnRDc2JINTVraWRJN0tvOXhicXBqaXVN?=
 =?utf-8?Q?1nkzMMVKf1EsS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJtSDhNblgwaHdHYVBmeVhhNjR5Z1NFME81REgvN1hQeXViRCtWaEx0MDEz?=
 =?utf-8?B?R045NEN5KzE1c0hVTWZhR2F1N1RjRlRVdU1KU1JWYXk1MXJZUXpwY0drVWlR?=
 =?utf-8?B?RVRldXIrSVBObEliMFBnczNOQ1RseDIyV21BVmpBTXdYZzZzOTFERENIbmNL?=
 =?utf-8?B?dHdrTXNxenBpcUhrN2s3Z0ZaWVdad2YwNG9wVTBQSStqYTVmcW5MSGQ2bFBE?=
 =?utf-8?B?dUxiL09kaTg1QlNFOG9EZ2V1cW1IbGpVeld1UXU2VEZlVUF1aHVOaWJEYjBH?=
 =?utf-8?B?eUxVRy85aDA5KzdjcHZwZkhxM08vQ2JBbFpjWHdWY0ZjaFZrMGZVN1lqRDk5?=
 =?utf-8?B?Y0JwUGxaQ210NWpxYmhkaE1LeXJqSkYra29KeldDS2YwNXB4ZG1KY0NZOGFL?=
 =?utf-8?B?UERONnBXQU5JYlRGSW5YWUMwS1BTYTNXSThTU1ljU3pCN3ZEQjk4TnM4Yno3?=
 =?utf-8?B?eVU3NGJSNnhqbVdVVnp6V2oyV2RLWXh3RFBUZFYyTW92OXlnSlpxQWxKSG9s?=
 =?utf-8?B?KzExT0c1cko4WEdyNDBXSjlEVjU5cmc1Y2p5SEg4M2dFM3RGa1RZY2JxcDdI?=
 =?utf-8?B?elMxTEVRQ1pDUldDbm9wNmNpS3V5UEJqeUFrbGhEUGx1bGNyVC9wcy9uQmpD?=
 =?utf-8?B?MElzSHUzUmRFQ3ZiTXZ2NC9MczVOS1o3akZYUW9taUJSbHJ3N1YycHZlRGdK?=
 =?utf-8?B?SzJCVFhDM2FHNURvZ2tPaDAyNzVDMUhPdHUvRitSV3RIV3ZHbllMUjkyeTVt?=
 =?utf-8?B?eTUyU0tJdDB3cmN4RktnSmZWbHpZcDV0L1h4bVNwN0dnMlRRcFNMQ0EzYnI1?=
 =?utf-8?B?VnJnWUE4L0Q3Q0dqUWlUM3ZzSjhBV2FJVXZkdXgrMWlTU3d2eHlLelphSHRr?=
 =?utf-8?B?YmduNXlNSzZPTnZ4blhyYjNUMlFiUGE0S1lJV1lMTlIycndlTDNDVmJWV2F4?=
 =?utf-8?B?Zndyejg1TDRITkQ3NCtrYldndmNWcDR3dUJIZE42N05oTlpySFg1KzFTUG9x?=
 =?utf-8?B?bTN1TkxlN1FVQUNIeWR3YTcxT1dpN1V3Ykt5VVIyY0JXWVhRNUhXdUkzMzQ3?=
 =?utf-8?B?cW1NWm5FdTBUNDBuN091WDhsQnE5MVdrUzluNENWZHE2QzU3NTdneFRvc28v?=
 =?utf-8?B?ei9LWjQ5emU0a3N5UXNuMlBmZm5EelROUUhPMCtFTkhkTEc4d2JocjV0VGVx?=
 =?utf-8?B?eEZFL1BTMG9idjNRSlR6eVY0eXlWUmhZSVhaa296OUJhR0wvU1FZYzFRMG4v?=
 =?utf-8?B?SmhGak8wM3pPL2pJTnBoQ2RLUmdSakIyUklqcldBWHZSRzhpTTBCTnAvWFIz?=
 =?utf-8?B?cUpnaGtjQkI0UEs3ejdDNktiWlJvWHkrZVRJb3BDbHFKU1NkSVEyTURCWVd6?=
 =?utf-8?B?cWV5Y0JiVjRUWWQzNnRkS2RiSFZSWVdqT2Vvak12eXlEZjNlK0IzVDR0eTB1?=
 =?utf-8?B?Zjg5UVpWK3hOS01YeXBuRjBPenhPRXIzSjhueTRiU2hybjR2ODZKYmUrZ2NZ?=
 =?utf-8?B?OFlTbm5CU3B2R1BIV284VTFYQ3luS0EwUEhlTGV1S2xTdmFWM2tvM29HdkFY?=
 =?utf-8?B?ZlRyZlNjV05lZHVORGo3ekRoazJhbnM3Y25CK0lKTUhETXNxOXFEL1BDMzdw?=
 =?utf-8?B?b3czdTF3V3RCMHNQbHNUcVJvR1BBNUk5c0RLT2tjRHc5MFkxbVdRcXBLV2Nz?=
 =?utf-8?B?ZithZzRxQ2Q1Nmkrc1liMC9ZU253clRscEhPL09Hb1hRNnZwaEtrYXQxUnNJ?=
 =?utf-8?B?MVFWYVZPV01xM0RwSk45cGdva1RROXZkZjh3YkJpN3BHcHZYeWMxMU5ZT2dk?=
 =?utf-8?B?aHdwZWtCQzVDdlVVaVRhcTFLN3F6Umw2UnQzdlBCYlJWZGp3aUt5SVg1R1N1?=
 =?utf-8?B?UWlNeUtqdlNGS0tTbFFaOGhKb25zanFxSUdYVE9oRTdxM2lNbUNTQ3RtajJr?=
 =?utf-8?B?Umx4MHBqTEpkN1lrR2J3UU9ybTBmUHpYQnIrL0VJSzJWbmRtV3FudFN2WXNO?=
 =?utf-8?B?SEI0OElHNjRNVHI5alJlcFFKZ3NpR2xLNW1RUTdIbjFWTiszR0g5THlzajZR?=
 =?utf-8?B?UUFJRWxQaGNUYjFkTUFyMy9vOUtPWWV6WHZhYnZlSGIyVEtZVVkrZFFPV2JQ?=
 =?utf-8?B?b29oYXB4VEFDQ0RUQUZoSWdzNEc3MXgwUEwrZWdMWGtUNzRIckN0c1k2WUh4?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0f4d72-783a-4f02-cb05-08dd51644470
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:08:44.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPcg2+8tkAwj6p94ASzsC0spfonAcX/tfQ/Hc7oyb7m6uUWb5ZSrFGUm5by8tjiFquHMqXRmducl7jGJhtewA9iDko2dXv9i/PIIZp8B2K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7973
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> get_{mon,ctrl}_domain_from_cpu() are handy helpers that both the arch
> code and resctrl need to use. Rename them to have a resctrl_ prefix
> and move them to a header file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes from v5:
>  * Added the word from to a comment.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 30 ---------------------
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 --
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>  include/linux/resctrl.h                | 37 ++++++++++++++++++++++++++
>  5 files changed, 39 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e4b676879227..921c351d57ae 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -348,36 +348,6 @@ static void cat_wrmsr(struct msr_param *m)
>  		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
>  }
>  
> -struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
> -{
> -	struct rdt_ctrl_domain *d;
> -
> -	lockdep_assert_cpus_held();
> -
> -	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> -		/* Find the domain that contains this CPU */
> -		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
> -			return d;
> -	}
> -
> -	return NULL;
> -}
> -
> -struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
> -{
> -	struct rdt_mon_domain *d;
> -
> -	lockdep_assert_cpus_held();
> -
> -	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> -		/* Find the domain that contains this CPU */
> -		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
> -			return d;
> -	}
> -
> -	return NULL;
> -}
> -
>  u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
>  {
>  	return resctrl_to_arch_res(r)->num_closid;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 0d13006e920b..c44c5b496355 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -475,8 +475,6 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain
>  				  unsigned long cbm);
>  enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
>  int rdtgroup_tasks_assigned(struct rdtgroup *r);
> -struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
> -struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
>  int closids_supported(void);
>  void closid_free(int closid);
>  int alloc_rmid(u32 closid);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index d99a05fc1b44..470cf16f506e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -773,7 +773,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
>  	if (WARN_ON_ONCE(!pmbm_data))
>  		return;
>  
> -	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
> +	dom_mba = resctrl_get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
>  	if (!dom_mba) {
>  		pr_warn_once("Failure to get domain for MBA update\n");
>  		return;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5fc60c9ce28f..08fec23a38bf 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4274,7 +4274,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>  	if (!l3->mon_capable)
>  		goto out_unlock;
>  
> -	d = get_mon_domain_from_cpu(cpu, l3);
> +	d = resctrl_get_mon_domain_from_cpu(cpu, l3);
>  	if (d) {
>  		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>  			cancel_delayed_work(&d->mbm_over);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 29415d023aab..511dab4ffcdc 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -3,6 +3,7 @@
>  #define _RESCTRL_H
>  
>  #include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/pid.h>
> @@ -399,6 +400,42 @@ static inline u32 resctrl_get_config_index(u32 closid,
>  	}
>  }
>  
> +/*
> + * Caller must hold the cpuhp read lock to prevent the struct rdt_domain from

struct rdt_domain has since been split into struct rdt_ctrl_domain and struct rdt_mon_domain.
I assume this comment covers both helpers so perhaps this can be "to prevent the domain
from ..."?

> + * being freed.
> + */
> +static inline struct rdt_ctrl_domain *
> +resctrl_get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
> +{
> +	struct rdt_ctrl_domain *d;
> +
> +	lockdep_assert_cpus_held();
> +
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> +		/* Find the domain that contains this CPU */
> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
> +			return d;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline struct rdt_mon_domain *
> +resctrl_get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
> +{
> +	struct rdt_mon_domain *d;
> +
> +	lockdep_assert_cpus_held();
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		/* Find the domain that contains this CPU */
> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
> +			return d;
> +	}
> +
> +	return NULL;
> +}
> +

Similar to previous requests, could you please provide a motivation for
the switch to inline?

>  /*
>   * Update the ctrl_val and apply this config right now.
>   * Must be called on one of the domain's CPUs.

Reinette

