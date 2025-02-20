Return-Path: <linux-kernel+bounces-522943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166BCA3D061
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D535F3BB13E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEB1DFD91;
	Thu, 20 Feb 2025 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ej15EvPv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F81DF98B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740025354; cv=fail; b=gw6phBEihzD3/OI17JY7NHm+X277R6OoPGx+tHO+96TPG7p4p6HdU3i5jK8YssWwmG9ZpgeSTQzlYlMcQLgbuZKK18nlOVOp0JjF0r/P9Rk6Azb/ZrPMiODyk54UTN8xWAyfAVTI835Q5bdvEVifQ4mEqajr1uIjUbLAnHg9o+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740025354; c=relaxed/simple;
	bh=jD5ST+yr6KHFSsTSlOVx3BiPQWnpauufY3CW6hIXFO4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/8UTFKsefEQpSepfbMo6Od3j4OmQMcXOUs2uENdDDz72wXdhglxSqSQBFcRetFRYVU4Kjxr6fmBghVWJ0LqpYfYkeVDCL2xK/3GmDQANOy4HlroVSjRMY4LQ5AY2fTEjAfpSYQxQcU/1V5RkV/c2D0SJXAOqvR1FN4I6vJcA9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ej15EvPv; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740025352; x=1771561352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jD5ST+yr6KHFSsTSlOVx3BiPQWnpauufY3CW6hIXFO4=;
  b=Ej15EvPvvlz0Bu7GcsBlHRLlrdG3fhgM4ZkMDBFCov9quIXiYNUuYLyA
   GpQUtTXieLwrwn5oF2EpemvGF1H891zye062ZfEM7LSCh6UL9DHWD9AlQ
   WpnZiC5RVY4n/bBwo1xOnhXcbG6gT7SuRUD3lMkEiANUWB4Pg18eDHV4w
   FJwHGub2hMGzJ3CEijVzwNEzIWUXcAJyRC61//RBPBQOCSGn7N9TKN5cI
   bxUGgb7M0SIxRkSxesATLzv+GSgKaNZ5rUZIcfvXvj/iCyi7szEhUTs7v
   VX+9wWHu1OIPtVu6pLeEpD5lOOR/q69MogH4JTFPx/Tz30YBsffz05WhG
   A==;
X-CSE-ConnectionGUID: Bc4DCUqSSCGYJ0W3lKOwTQ==
X-CSE-MsgGUID: CBSX01wKTuqWbBCfeuDTVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43619429"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="43619429"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:22:31 -0800
X-CSE-ConnectionGUID: XWJ7krMiR3qseug8cid/SQ==
X-CSE-MsgGUID: pFbjfDrySGO7AoozZ5DjyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="138121223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 20:22:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 20:22:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:22:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:22:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOvP4qvEVsFUHU+jPKpDJYk67m03enzOqND7wRIK9AUkmG72Pz70PecUPDpUPjc/k4XnOjKri8JOKqW2ShRJCEbTDu5IgoCWTatTC4aqFtJXqj5rX1KjFtlhx4wQkORq4fi/uy2iOKaGMY0eln9VW7ViCWF24hPBO1XILq5HnriSFyBegXAvKAYCGRS2Kda3fd0RhOtnaMiLzzG7b+lxXk69q9dyl3qK7gXVZswkhJAA+n3xhshcSnp6yw2ltZFhuWHbJiJUr6xO8TEz8uyjoV5smHpECDSwTT/1APAxhih8m5umpaTpOs1fE/Yl50KoI86JfV3GnaKOemXZ7+Txrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zie/i82ZXuZgiGYCRfNp2ZSxJI/N63wgbDSn7zDxaSg=;
 b=k6W1/kppE4ijp2EeokXRq0g0YiuZ/2mbvr+ILiW46N9Gfaxt3oG70dKOFlUQmOTMfNxjr6UTAxaO0ePAm62K+uVwzEbuGmQ6vHDJPZlHk4CX5ItNExRU5r6oCKipApkuxPk+Vse0tT1yiATMbgihgHyDxqx/XZzFkd2Vc/VtM2P34lC8GI+BbhIUbluLeeYtZhCAwsUQ4iC6dCJ78P6kHwqeXifY6YSYh5XNAeZJDxaK/YwqB6950q3gnlqdhxMgjcfgJlSxG4tdvqZIJZhH8R+F95ywbNE+FlkyxC6BRREdEtP1ANW0Z4XTHlvWbG2pgkuwgRoOgg2Lqdnp7v+jGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 04:21:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:21:55 +0000
Message-ID: <6c1e02c6-085a-4866-99a3-59b954b687ee@intel.com>
Date: Wed, 19 Feb 2025 20:21:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 31/42] x86/resctrl: Remove the limit on the number of
 CLOSID
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
 Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-32-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-32-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:303:6b::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: f29dcf8e-becd-4e6b-7544-08dd51661c33
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDlWdms1RERkbWVwVjRPelFjR3p5R3ZNQk1ORkFOVTB3QU1XYlg4VU1saW9u?=
 =?utf-8?B?a21ocnAxM1V5eXRRaGh6Z0ZrSVg1ZzZDdFUzeStsaEFrZkFIY0wvdzBaek1P?=
 =?utf-8?B?YTk1N2x1QWpHczRoc1ZaQWpaSnZnNHZDVTdldTdCbzQ5dkx4QnorUUF5a3Zw?=
 =?utf-8?B?QXFSdEFxbjVTVkFQZTIwQUZMMW9XMjhyNWI2Nm5udkZsRVlXZSs0aHpFekRY?=
 =?utf-8?B?dFk3VXRUS0Ntckkzb3FIakFvWk5iNnQ3c2tFbTdKMlhMM2NvMnl2THNtbG5I?=
 =?utf-8?B?czVWMWhKQWRDNTM4VktOaUFoQStKZ2NjMTFIWS8ySnhIYjBBeXREQk9JQVRm?=
 =?utf-8?B?c01UYjA0QzJ6eHJjeXFoR1RJZlVEZDd3OENZMlNWNEJEY2NUYWYwaDlFTS9s?=
 =?utf-8?B?aFQ4b2JXNHFFVWZadXk3d2VBQUhJSFBUbVhLc1IrY2FoVkZZekZKUUpHU3ZI?=
 =?utf-8?B?MUVHd2JsdlJaUy9rczNsOXJIKzVtb3piaks1UVlGd09IYWhIUGd0cytVbmFu?=
 =?utf-8?B?elAwby9xU0o1QjgyWS85bTV6WnY4WHdrVWgrKzBVUGZKWTRPMi8rRjZrMm1Z?=
 =?utf-8?B?Um1oWEx5b3kySGtjbllMbE52eGFLRW9VU3dFY3p5YTE4Nnp3aHpYY1FLcnBJ?=
 =?utf-8?B?SmNaV0w0c2hCcnNMZC9iWm5Oemd5ejNrVHFsVG9yTVpTNk82RlgySFFQN0Nk?=
 =?utf-8?B?YlFLck52cFY2dnRKeDhtdmJjdGFTMVZsRzNXVnlEc0hJcEdTM0g2QzNXUEor?=
 =?utf-8?B?RFg1VUlmWUIzUGFsL1o2NmFaeWYxTEZSUWRhMXhVSnE5b29YdHlOVUZUc2lT?=
 =?utf-8?B?WVBCZGZhbVk0MVZiRU9XR2xWMVBpZTNrNkRNSERYakNvd3lkblZNa0h5c1M0?=
 =?utf-8?B?ay9JTTV2b2tCUk8rcDJDR25McmJlbDNRNmRCY0Z4U3FSanpwSlRKcElxaUZP?=
 =?utf-8?B?M2JxSU1jdUM0QnhFcHo4UHpRdjNWbFBsb3dHMm1BNmZkK21rS3hmMThtUDNy?=
 =?utf-8?B?TXpnS2tFcDFXYk50L3NHVVhaMFlVRzFhamFNQzhkandBV1NxY3hGVitCaXFJ?=
 =?utf-8?B?UEtTbEwrcS9QZTRoRVQyR011VmVINmZhaEorbTFEVFhsQjhvM25IZ1VncUNY?=
 =?utf-8?B?QWZnMkExU0RPdVhPWVFvT2pma1BTSzh0TE1hbm56V0RzTUlvbVF6a1pjSTRT?=
 =?utf-8?B?aW1lbjFhcUlkTnRIU2hUV3NOK2ZOREU3dUlMT1orT05XQkxybGNjMHphS21S?=
 =?utf-8?B?a3luUGpXTGU1Lzg5K0JpclhWTm1FcDF3VjdlbXhzVklLbmtFZFJ0cXd4eEx3?=
 =?utf-8?B?SklxL0ZqNVV5SDU4RWdaYkFNZnNYbmlRUXJPL2UxMy90R0VOaUYvbE5DOG1P?=
 =?utf-8?B?a3FCZHNERlY1NXhRMllySVVIQ2d6Sk5VbXRDTkdhajJkVHdQNmIrTmRlZHhN?=
 =?utf-8?B?UFY0QXNyak1COFU3c01qNDl1U1Z5MFF6WC9relI1Nkc0eDB4TWg3ZStEdTdx?=
 =?utf-8?B?Y01BbXN1UklDMmJkdEhnNjhFK2NqcVRhMUhLMzJHSjlFTnIzdmhGZ1FrSjZw?=
 =?utf-8?B?YS95TmVhaXNWbXg1VFh2UlMvVmVnOTh5VTQ3cFlkVExNMUtENHlvRHYwLzNn?=
 =?utf-8?B?aThsZzU2MHJyUnZzTVBRbnFHN1FXMVZoeDAyemYwWnFBK1pOaW1TNXlhMUEv?=
 =?utf-8?B?dGttMVBKQWVjenRTL09YRXZTOUdsK1V3bjdCaWdLQ1RWclZydkh3dDhwcDBa?=
 =?utf-8?B?V2FEcUxNMmhrQ0JySzJjdWF1WDF5ZHZ3bHpXQjlONWxMWHJqUDdZNmxMUFdY?=
 =?utf-8?B?UDFWelE5SmhhVm43TFlQbjEzQml4eElBU2RzU2U4aU1JL2JEVloyZm9hSlVQ?=
 =?utf-8?Q?FnNcI1d4dfy+k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cklrY2o5b251TXh4dVFBN1hPWjFRWCtZM0Y1Z3h0OE5YTU1mM2RxSHhFZ0ht?=
 =?utf-8?B?MnRIS0tqaWFaN3UzaXBPV2prVHFDZTRtQWIwQWdrVnhYVW9jTEFNaERKRkRQ?=
 =?utf-8?B?bjE5T1JHdmRTdkYxMk8vM2w5ZmxnQXArSTBGMzBNYzZVRHZNYWFJMCtGeGpO?=
 =?utf-8?B?V3BJRndtYXdJOXc3VXErQ0txWkREUG80N1FWSGpGSjZhZm1uRzZTTVpOK2NM?=
 =?utf-8?B?RXlFYnlPR0VCYm1meFVQQ1pKdktSK01XMlo0OWNEQkpjSkw0ZFpiR2xUcFp2?=
 =?utf-8?B?MVZ4TkYyOGQ3UUtvWGlyQ2NZTnEvWDU1UklVbmFtUkdrcXNxcnVPQWNpYUVE?=
 =?utf-8?B?aVNmU0N4YittU2hZMUVzVUVkU1Bnb3Mrc2gvcVROL0lpbkN4Y2hkWXF1WGla?=
 =?utf-8?B?dVJqTEtLQktITmNJL0ExNkV5bEVMcnNNY1JkeDFYWEhaaVowUjlLQndpSFl2?=
 =?utf-8?B?VXlnUG1VcG14NkU0S2xabm5Qckc4VVhySDhnbkVCOXRjTDBnWkZSaisvMnJJ?=
 =?utf-8?B?T0xYb3JpU3RIbzU2L3ZqWXVTZHZkTmVvaWxOQ3RHK1hTbmhGRUFHYk1YSUc4?=
 =?utf-8?B?WisvcWlPcU5JSHlpMnc4NDZkRnVsdTlFQmZPcUY4TTFySEFFQjlUKzdQVXJk?=
 =?utf-8?B?N2tweFFBMS95Y3Y4TndGOHgwVHBuRFRsb3Z5VTBzNVIrWmJMK0xvd0x3b1do?=
 =?utf-8?B?WDRYekdIVW5FL1c1d2lCZE1HeHZCUmVGQm5EQ1gvZE15SVBBQTBsWU9EQ1Bk?=
 =?utf-8?B?T3B1SUFYTlVsY1gremdQYklwamxQQmczN2p6ZHMwS3h6cTlibkMrWDArQXJ3?=
 =?utf-8?B?QVhmSDBvN1ZWU3RobGpwWlpkcys0UWY3R2JjRHVKUjZ0bFJrTndVdUNnNjUw?=
 =?utf-8?B?OGQ2eE10RVcvTjNaVngxYUNhb01QdyttLzlkdEN5cXphTDFnWnNIem1Za2p3?=
 =?utf-8?B?ZGRQOWpzQ1RucUNQd0Y2dW5xVmRaaWJoREtIRXY3aktYUGplRExNTVB0c1U2?=
 =?utf-8?B?b084emdEMWNxSG05WFV2Ty93ZEE3N2F5T3hwRDBWMDVvMHlpQjlTS25xdU1I?=
 =?utf-8?B?OGhyMmRVUm9ZcVhWOUptRkhMNnpyeTF1dkc4OWlsR2xsSkNwVmd1ZGlIdVNh?=
 =?utf-8?B?RnRzR2pWS0lOYnJDc0k0L29EVkNiTW1zVEtnVXAwU2wvWUtTaW03anF0dHFN?=
 =?utf-8?B?M2pxVDVtR1J5cmV6YkIrM3hia1NLb1hRcTh4YUhBV3BzUXZ2WUdibnVTSmpm?=
 =?utf-8?B?d1p3WHhGN0VjMzB2SUdOK1AyV1gyTzJNM1I5Zms4Q1Q1QU8vRUtPUndiLzlP?=
 =?utf-8?B?b00rVUM4b0JlTW5IaFpRYU8weWhlSTlOcXlBdDFrdUJTYkh6T3E5T04rbkRZ?=
 =?utf-8?B?bCs2OVlYeWZUVUd6dHNYa1JpYThCSlBqTHBVb3NqR1FYOTZOL1VwUXVWMlFl?=
 =?utf-8?B?S0U4bWdzSm9jcHB2N25qYlRPZTZHcmQrbDVETjl6WGV4ZXdUQzFEcnkrTi80?=
 =?utf-8?B?UG1EV2NaQUIvUTdiRHFUNGdhYXVzZ1BXWU95NFRSSGJSd1pjcXBJSm5td3dN?=
 =?utf-8?B?WElleW03bkpNTUFzUzhtSUY1QlRYei90anRacXdIUXlKYUZzT2g2ZGZTaS9E?=
 =?utf-8?B?NEhXdTViOW9zSERlV2VjK01tVmJ5S1NLS2xHZk9HelFMVG56ZFUySDlLaEZY?=
 =?utf-8?B?dysrSzBFVkViRWNIb1hJRGlVdTMvcTQ4YkphMGlVL3JHL2ZsYUxySFNha0E1?=
 =?utf-8?B?bnFSUUlKN1pxZVdGZm5CTWdyTDR4SkxxcmNtZ1ROSmxHbzJvdlk3bTA0OUMr?=
 =?utf-8?B?NUdpb20vQjkzMFR5bzJSQi9XR3ZPQytpeWZwYnUxdWJsbUJLTVBvTllhOFJV?=
 =?utf-8?B?Q01iNW9HOFRKc3dRZll6NkpidU9SM3puOXN0S056SU1HelRuSHhTejZvZEhG?=
 =?utf-8?B?cFBFcm9SeU5OS3NFOVdDQkpzUHVPKzduZW5OenFYUTZ5OEdnRy8reTJBZ24x?=
 =?utf-8?B?dnZlODNkN0N4S01CR092aHRiTm9JV3A5d0ZCNGdOeXZyMGljN2VZZ2RicERr?=
 =?utf-8?B?WExmVDBMZ3cwbU9uYkgyTldPWUdpMmM3am9YNXRoY0EzbEtmR0pWTEJLQVZq?=
 =?utf-8?B?bExQeVhmdGxDYUtDdWcwYkcwRTFMTjV0S25oNTNQeFhvempEcWxpS1VNaWFC?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f29dcf8e-becd-4e6b-7544-08dd51661c33
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 04:21:55.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KU7PqqVB5DmAxCdjzqzmshuUHqpRFCJesknER9T6KAWGgZZ7oAgc66FioieTvgi+P6NFF/ykYyEc3axYXZfOWYA+e7p+BNWiXxiDGzSQoho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> From: Amit Singh Tomar <amitsinght@marvell.com>
> 
> Resctrl allocates and finds free CLOSID values using the bits of a u32.
> This restricts the number of control groups that can be created by
> user-space.
> 
> MPAM has an architectural limit of 2^16 CLOSID values, Intel x86 could
> be extended beyond 32 values. There is at least one MPAM platform which
> supports more than 32 CLOSID values.
> 
> Replace the fixed size bitmap with calls to the bitmap API to allocate
> an array of a sufficient size.
> 
> ffs() returns '1' for bit 0, hence the existing code subtracts 1 from
> the index to get the CLOSID value. find_first_bit() returns the bit
> number which does not need adjusting.
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> [ morse: fixed the off-by-one in the allocator and the wrong
>  not-found value. Removed the limit. Rephrase the commit message. ]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v5:
>  * This patch got pulled into this series.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 +++++++++++++++++---------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 08fec23a38bf..de79da30d500 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -130,8 +130,8 @@ static bool resctrl_is_mbm_event(int e)
>  }
>  
>  /*
> - * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
> - * we can keep a bitmap of free CLOSIDs in a single integer.
> + * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
> + * of free CLOSIDs.
>   *
>   * Using a global CLOSID across all resources has some advantages and
>   * some drawbacks:
> @@ -144,7 +144,7 @@ static bool resctrl_is_mbm_event(int e)
>   * - Our choices on how to configure each resource become progressively more
>   *   limited as the number of resources grows.
>   */
> -static unsigned long closid_free_map;
> +static unsigned long *closid_free_map;
>  static int closid_free_map_len;
>  
>  int closids_supported(void)
> @@ -152,20 +152,30 @@ int closids_supported(void)
>  	return closid_free_map_len;
>  }
>  
> -static void closid_init(void)
> +static int closid_init(void)
>  {
>  	struct resctrl_schema *s;
> -	u32 rdt_min_closid = 32;
> +	u32 rdt_min_closid = ~0;
>  
>  	/* Compute rdt_min_closid across all resources */
>  	list_for_each_entry(s, &resctrl_schema_all, list)
>  		rdt_min_closid = min(rdt_min_closid, s->num_closid);
>  
> -	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
> +	closid_free_map = bitmap_alloc(rdt_min_closid, GFP_KERNEL);
> +	if (!closid_free_map)
> +		return -ENOMEM;
> +	bitmap_fill(closid_free_map, rdt_min_closid);
>  
>  	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
> -	__clear_bit(RESCTRL_RESERVED_CLOSID, &closid_free_map);
> +	__clear_bit(RESCTRL_RESERVED_CLOSID, closid_free_map);
>  	closid_free_map_len = rdt_min_closid;
> +
> +	return 0;
> +}
> +
> +static void closid_exit(void)
> +{
> +	bitmap_free(closid_free_map);

With closid_free_map being a global, could this also set
closid_free_map to NULL?

>  }
>  
>  static int closid_alloc(void)
> @@ -182,12 +192,11 @@ static int closid_alloc(void)
>  			return cleanest_closid;
>  		closid = cleanest_closid;
>  	} else {
> -		closid = ffs(closid_free_map);
> -		if (closid == 0)
> +		closid = find_first_bit(closid_free_map, closid_free_map_len);
> +		if (closid == closid_free_map_len)
>  			return -ENOSPC;
> -		closid--;
>  	}
> -	__clear_bit(closid, &closid_free_map);
> +	__clear_bit(closid, closid_free_map);
>  
>  	return closid;
>  }
> @@ -196,7 +205,7 @@ void closid_free(int closid)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	__set_bit(closid, &closid_free_map);
> +	__set_bit(closid, closid_free_map);
>  }
>  
>  /**
> @@ -210,7 +219,7 @@ bool closid_allocated(unsigned int closid)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	return !test_bit(closid, &closid_free_map);
> +	return !test_bit(closid, closid_free_map);
>  }
>  
>  /**
> @@ -2754,20 +2763,22 @@ static int rdt_get_tree(struct fs_context *fc)
>  		goto out_ctx;
>  	}
>  
> -	closid_init();
> +	ret = closid_init();
> +	if (ret)
> +		goto out_schemata_free;
>  
>  	if (resctrl_arch_mon_capable())
>  		flags |= RFTYPE_MON;
>  
>  	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
>  	if (ret)
> -		goto out_schemata_free;
> +		goto out_closid_exit;
>  
>  	kernfs_activate(rdtgroup_default.kn);
>  
>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>  	if (ret < 0)
> -		goto out_schemata_free;
> +		goto out_closid_exit;
>  
>  	if (resctrl_arch_mon_capable()) {
>  		ret = mongroup_create_dir(rdtgroup_default.kn,
> @@ -2818,6 +2829,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  		kernfs_remove(kn_mongrp);
>  out_info:
>  	kernfs_remove(kn_info);
> +out_closid_exit:
> +	closid_exit();
>  out_schemata_free:
>  	schemata_list_destroy();
>  out_ctx:


With closid_init() called from rdt_get_tree() during mount I expected
closid_exit() to be called from rdt_kill_sb() during unmount ?

Reinette

