Return-Path: <linux-kernel+bounces-424830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9859DB9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B4A2814B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BB1B21A0;
	Thu, 28 Nov 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djtWgBNu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59F11A0BC0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805877; cv=fail; b=WGN4ovW+9UebPwSp5BD972xkR1y2bq/qQZjv+l7Qv7l1yVkw+cnXrZLEE9/dUVCn5HnBK6NKNUvvh8uheIRVcNOFdaefLritd4uMpxYqB3xcFiOqzkm00z48DWHzjRzVRGYJqB4vL9adKZZ4fKE/TMl1EJxpiPtYfkT+VzX9HlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805877; c=relaxed/simple;
	bh=xH07bITfU7D/6qmi/9EoRCpckli22YUEhydcFGmekZs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=OcUvpcuyDHEceqcaMtqe2n6imzvCbKlHq1SdvEbbAyjFL5r8kHyZ2Xoz2TJQbL3t4iBV/ykaVamJG1hGfOM2B+20PhFI4RvjekFHB5U/myKHN7B6CllTqOxkVwFDhcd7Sc4mE82pkKxX5/ldeowsMS0I5LCfhG/vhOm3DvDTXzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djtWgBNu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732805871; x=1764341871;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=xH07bITfU7D/6qmi/9EoRCpckli22YUEhydcFGmekZs=;
  b=djtWgBNuSwN7CTbn2EDa1Qp5lu1MNpNmgDbt+oIC9s6CdOKFHZrVS8fq
   WqX9KqO0cmEmY+bdGr2dGnyJncwMj/WSF6Ge6PxVQwhzLlThexcXfhAZV
   1nI/yKn4n1H185rsrVPHJWJdcPZ7KnmJmPgaKlsCW1lPExSQtUfUlWfKy
   lf1nwUzsdmPBymJ5zcLgexd5kEO63El1Olrm+p/aa6Zuw5Q5mN7cNAI0B
   AZYc06nO/2q0MU6gtCVMNYuVTM5z13JAHthNnRh3e0GgDnheAD+1DY1Uy
   u3llvoCVlm+614N+fPyo6ErrlV7aJ812fZanHSw86i8RwIpEoigv3cTCX
   Q==;
X-CSE-ConnectionGUID: a754xvSFT3qBLKOY2WfLOw==
X-CSE-MsgGUID: KdHFzFx6TGqNdiYvL4f0Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="50563579"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="50563579"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 06:57:50 -0800
X-CSE-ConnectionGUID: jEiKQkVXQZSkjhdGSFgvOQ==
X-CSE-MsgGUID: 7LyWN02KQ2K2kxuPdxibkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="97350663"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 06:57:50 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 06:57:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 06:57:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 06:57:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgV3nCoWUKBIFA9l3rzqJRySNxACbcnOZotjXDz1T9Sm2Mw1+DNEZvzRrNfCPx+KgIQiIPCSJkYlXiX8Y877+LA2F3G44CQN9QOAi/2UoTdjs3PjJEybxo7pmtHLAHC3xd37ye9Q9IxC+MGIBFGuT8n53LofTxo3oV/7aEvwL0M8Yl6QOIOr89890+965yAsFd2GsOprpDf/YPCusAXFhhOUE3bHkc39MjgJ6HNxvYZmobif86TeJlKi9jMc6+PUsB+3BkiaKtGDcAqWLC3sNcrKvwbZLbbj7Uohi+hy4QlIvIB0CJb+DorODpDJ672vUR3hKGq45xZvLe97KCMENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9yyzghoK4M32lBUA2ZXGWEtcFctoa2GhJedzdYQidA=;
 b=LR+LNgSnf4OTYyVn2zyD5iVt4jAw2ENbqmjRKq4IXyhVbZMaeRYeIZNmuc1C+rJuMyHO0klLLZ9fp16+g8/EdhiEwAGIOXwIhQEg9MDfu6+ci8jAxl5X5UIPxcp/4SHXKbOYCMbngd6R3uI9hQ8AeV/qVMhmszK+i6/NuwYfGXs4Whsefi2kRkiLO13c/PqUTpbXjCWj5B3VOHb2ZToO04ShJLHb9wZzzfkdlQhMc2KMr/4tKBlIeNgqhxUpwvydllkGnEKpHU2QvGCxRf0O2/xG/fE0ReSrdsbEvS0PTfbiX1TA2q2ZE6fnwguLr564D9D/GSG65sfzzqhBQ7u3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 14:57:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 14:57:45 +0000
Date: Thu, 28 Nov 2024 22:57:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rik van Riel <riel@surriel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
	<dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
	<oliver.sang@intel.com>
Subject: [tip:x86/mm] [x86/mm/tlb]  209954cbc7:  will-it-scale.per_thread_ops
 13.2% regression
Message-ID: <202411282207.6bd28eae-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d07f387-315b-4ea4-7b06-08dd0fbd0456
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0/fg1FHu3843Z0drTBgD9wpLYZjhSNKfO+wDTyHR9mTIEQws4A/IO/+EHe?=
 =?iso-8859-1?Q?4vzTfa/C0Tu5Br5q+tTruVQcCmYBTX3ZhD+1Gjo0pLzoSeNCy/DchqaT2B?=
 =?iso-8859-1?Q?+x/i3eoxHLuWggciVCYwcHlUL4grNAAQKrSO8B40UUFroM+qb1tkN6IMU7?=
 =?iso-8859-1?Q?4/TeMjS+cHuUiE6Ox0L74wk6iGBRYSC8qLDoLFsU2XyMu/a2/LOVxT/ez1?=
 =?iso-8859-1?Q?wbf3oYJDA5ax+2rcwXVuRSYyBGS0hyUt9Ixonf/aAqr1Y0Ln5xFLkG5Ev9?=
 =?iso-8859-1?Q?wZPzhZSygjLa/WKw3aG8EBiPtb22qVJ0bkw06cu3Hfq1P8vYzdSJ4cS4JG?=
 =?iso-8859-1?Q?dn9SVba7Y86DSlII0qdvyb6d+hrF/HFM0zI8kOAyWCePguwhI63gPGZ0Ng?=
 =?iso-8859-1?Q?fz1Atv8wK8j6nw+RY6U02ZCcn88CGwmvRbjV/9ytE2m9SqQRp6Su8N6os0?=
 =?iso-8859-1?Q?5t7YzO6y1QWFEcPMPuxAVJf6fa8s0EGn0FO+0ljzYls5k3P2gvq5Cr3eCY?=
 =?iso-8859-1?Q?4aTNhoWHgEAEjc40eFRm69PwhdU/7Rrsi9SB840Ax8Yb0Enaagz816ApsY?=
 =?iso-8859-1?Q?dZT8tmMyxhHz3Tt22bwNp5PV0/ScoU9575J4IT/6RPRdpsSUO73Q2Ptwbm?=
 =?iso-8859-1?Q?r/wDLsonSAFSiu8TiMDWYSfJ1V5AD2dq1tskCL3BSTYrsBah2wUDEgzG9i?=
 =?iso-8859-1?Q?zRHgWO6GATiQ9uZzzpXQEL5Da4fdv6xNIj1+EwxsDJ9Mk7YLjnOk62k85Y?=
 =?iso-8859-1?Q?43g5c6A4uPFzKkQ676mMInewU2lv2H274d3p1ywWnJxe3hOYeX6QD+U8Wc?=
 =?iso-8859-1?Q?4JHUElNLpbxNT/g3nDk9eZeZo4vZzPDn3Cp6WAc6EYGwzDVp71s44zBEHX?=
 =?iso-8859-1?Q?2rZcLNDQLsIlUaXIN0Dvfrj+L4z7tCICgqfvgylJ4T7Lp01K6x2kj3VtXO?=
 =?iso-8859-1?Q?R7XLVK++IM2Bf6WnIsGcvKxNgrttj9iMVIKe4AjNDfootGE0yV+OAP+qPt?=
 =?iso-8859-1?Q?9ZahDlJG6ookAFXE03OHIJTTXcGjvLlvJ7QpZ9oDgd0we0vIvvYeYSNJ/I?=
 =?iso-8859-1?Q?Z5IaJDC/l7JFHtOh6L1qvS4u9E0eHjoWvmLNzUTFlWUgPTpg7x9hVeT5s7?=
 =?iso-8859-1?Q?+tuOZB3zrJLGiQdx7qnj52jIxwlHc7vGkDqa3Xsfu9HiXvBM8jilS92xtu?=
 =?iso-8859-1?Q?IjNvzq+Xb4bZEdT6HCeYdRX+17uxXEiQ3In9AhokZpF0qYc3EzAI93yfyI?=
 =?iso-8859-1?Q?eG80ga3GBsDAF83ZSdsbCP2zr8bPrA/TiH58sRCiQ/K1NYi9G7r6GUhpGX?=
 =?iso-8859-1?Q?kxjL/XFepONIamgepjogVn4c3vmMmjd/OjQG2JURG5Cfyu81IVnzIHsfff?=
 =?iso-8859-1?Q?wWIRVUe1cw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wJxhB2h/NpJW5kgRJ+3xVnic5x7fXw5/8MLA6s1gxDTbcu5DE8gE7PmuRn?=
 =?iso-8859-1?Q?MR6vs/Nsh8s7tTgI0lsRzgiUhCWNgRhcdrYhHuUnQKEqhoFyIKSQvcJ788?=
 =?iso-8859-1?Q?FSBLavpS3tFF276OKerBQMwfohQkySmLah7ky52R022FQ7SefB48GNGaIM?=
 =?iso-8859-1?Q?AT7a2ZNQSwQKghVFArEgwcXmrqpkx3HRRHCSgZ6ujA7Go6chnZciMxPQda?=
 =?iso-8859-1?Q?FciQwJt0SQ9kmuI68zzc7nv1WeeaKZ37nGPdJGE9elieU7DLOTJyY38Zil?=
 =?iso-8859-1?Q?Zwe4MPP5dqSNlSn8Ljfvw5jj6JunlKveKb5H07uvyQ8pU6Wk2Uug3K+bf9?=
 =?iso-8859-1?Q?M0OZIGLt220k/BwZnd5pOXLRgf1da9KluaKQqFDVoPQLzdRm0PejKwSRI9?=
 =?iso-8859-1?Q?lBMFznJT9qLTRtrnc03EOlVex7te9HYNZQKefNc+Idgj75YiLymE6/VmSb?=
 =?iso-8859-1?Q?yOiTFdMSLgScv0YeCq3Fab4YbyCPSZkBcZbpSBuMZWdOlVRoe6mNobBqLd?=
 =?iso-8859-1?Q?skf3aYhVmkJWiaL1AsHjwJRg6Qe70GPvedvUZ0vrc/of7FrViiBwm83e2H?=
 =?iso-8859-1?Q?C49dWUIitHdP1BZpjlfO7YWHAqYE6bR1nughkDWXUUzPklHzN4MYrQzUVO?=
 =?iso-8859-1?Q?C7pA6Qr3oEc9CJhQAWk4hhSnqk5BkmyMFy/wOWMCcGkzN+B1gt512NNz8d?=
 =?iso-8859-1?Q?kJq9+ekSvQpcr1zuj2sk5sQJ37h3S+efiAND1CSlsA5HrHP/wjFtpqgX4r?=
 =?iso-8859-1?Q?ENpTwhVFyODPWGwqJt/2ThVI2naQvwn39PB5iLxt/d3rFjsylp08pvg8Vn?=
 =?iso-8859-1?Q?eJEERf6BI9POSdTMITpeoCWQxJ9HkDcHjxBlLJJ5djPRvo1YK2tRja+iOE?=
 =?iso-8859-1?Q?EsnMtvo7FDDpeEXDLGr+vMWpQ69Qxq9qB7c1f0f+d7fAIKVKgbUMRuxYEM?=
 =?iso-8859-1?Q?Cem3VTEnOg/btV8BSe4HDt7fl1oy26L4pjlXjfKNpt7ZzkJr/+vvd10G/h?=
 =?iso-8859-1?Q?F+s97SvBsLpXWykXxnYmRLVj9Dsbq9+kQ/z+fpcUGczHHlcpFRvGpkX2xI?=
 =?iso-8859-1?Q?jafQreZ7BWdHBgdP015naACzYZiotqnT6azHvhUQDQlkaRkeW4OW9XlUyD?=
 =?iso-8859-1?Q?t/WLxOj8CQv0oAercFzMIupF20pWjVlQMFnz/0nGPvm78E8JTk68+c+gXz?=
 =?iso-8859-1?Q?hWxP/sMKpSvdFVVIsIbrVjhm2NstIVG4OwJrQTtPmup6WdeiA7TSXBTmLV?=
 =?iso-8859-1?Q?vk4CIiuN+fcgBkz/dLVHXStyEZCQLtrxZmOr30rIdsIGnyTYe0eeHxMD0s?=
 =?iso-8859-1?Q?qoRrFK2o4bdC8DLomfuk1+IHlY3KetmviblyhMcmFKobSX9dyub+G8JGGN?=
 =?iso-8859-1?Q?81bAePRvT5/a+khPw25cv0aIBXYjOoEAdhdD3L+WosEBbT8vm0qeLohnaM?=
 =?iso-8859-1?Q?BGyGsxYL96szhtOXhNSuS64GAloO7oBTGYpx9fBoLwG3fKd/7Y4f/DZvoB?=
 =?iso-8859-1?Q?T3ya8OLLBqSXFeGn5FS4swHkTOQPTWicKpdAhEHsuK+AcDQxHFE8Z/rC3A?=
 =?iso-8859-1?Q?ALzTTVsaxLiMxPF9APNJ8s9stOiXE7GmaT/ez/3xYW+WaV4BVmBElg+967?=
 =?iso-8859-1?Q?xCDPBOa8LIkivry3ct5afqqau5fSLoWAh0hd9umLSvO9FdLgttY975cg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d07f387-315b-4ea4-7b06-08dd0fbd0456
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:57:45.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EC05MldgAdXK25gJ881a7jRiJd8qk5Tsfy3DCcPbWKrgF0YGVrDjYYohDFNvXj1lCHsldk3XS7IizLWxGnHyEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 13.2% regression of will-it-scale.per_thread_ops on:


commit: 209954cbc7d0ce1a190fc725d20ce303d74d2680 ("x86/mm/tlb: Update mm_cpumask lazily")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm

[test failed on linux-next/master 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0]

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: tlb_flush2
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+------------------------------------------------------------------------------------------------+
| testcase: change | vm-scalability: vm-scalability.throughput 40.7% regression                                     |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory |
| test parameters  | cpufreq_governor=performance                                                                   |
|                  | nr_ssd=1                                                                                       |
|                  | nr_task=32                                                                                     |
|                  | priority=1                                                                                     |
|                  | runtime=300                                                                                    |
|                  | test=swap-w-seq-mt                                                                             |
|                  | thp_defrag=always                                                                              |
|                  | thp_enabled=never                                                                              |
+------------------+------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241128/202411282207.6bd28eae-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/tlb_flush2/will-it-scale

commit: 
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
  209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")

7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      3743 ±  6%      -9.6%       3383 ± 10%  numa-meminfo.node1.PageTables
     18158 ±  2%      -9.9%      16367 ±  2%  uptime.idle
     36.77            -1.2%      36.34        boot-time.boot
      3503            -1.3%       3458        boot-time.idle
 1.421e+10            -9.6%  1.284e+10 ±  2%  cpuidle..time
 2.595e+08           -12.9%   2.26e+08        cpuidle..usage
      3.14 ±  4%     +27.4%       4.00 ±  6%  sched_debug.cfs_rq:/.load_avg.min
      1598 ±  3%     +53.8%       2458 ± 16%  sched_debug.cpu.clock_task.stddev
    695438            -8.1%     638790        vmstat.system.cs
   4553480            -3.5%    4393928        vmstat.system.in
     20954 ± 17%     -17.0%      17391 ±  2%  perf-c2c.DRAM.remote
     18165 ± 17%     -17.7%      14957 ±  2%  perf-c2c.HITM.remote
     44864 ± 17%     -15.4%      37953        perf-c2c.HITM.total
     44.57            -4.3       40.31        mpstat.cpu.all.idle%
      9.85            +6.1       15.94        mpstat.cpu.all.irq%
      0.10            +0.0        0.12        mpstat.cpu.all.soft%
      2.34 ±  2%      -0.3        2.02        mpstat.cpu.all.usr%
 1.139e+08 ±  2%     -14.5%   97376097 ±  3%  numa-numastat.node0.local_node
 1.139e+08 ±  2%     -14.5%   97404595 ±  3%  numa-numastat.node0.numa_hit
 1.146e+08           -11.6%  1.013e+08 ±  2%  numa-numastat.node1.local_node
 1.146e+08           -11.6%  1.013e+08 ±  2%  numa-numastat.node1.numa_hit
    756738           -13.2%     656838        will-it-scale.104.threads
     43.82            -9.5%      39.67        will-it-scale.104.threads_idle
      7276           -13.2%       6315        will-it-scale.per_thread_ops
    756738           -13.2%     656838        will-it-scale.workload
 1.139e+08 ±  2%     -14.5%   97404162 ±  3%  numa-vmstat.node0.numa_hit
 1.139e+08 ±  2%     -14.5%   97375664 ±  3%  numa-vmstat.node0.numa_local
    936.25 ±  6%      -9.7%     845.81 ± 10%  numa-vmstat.node1.nr_page_table_pages
 1.146e+08           -11.6%  1.013e+08 ±  2%  numa-vmstat.node1.numa_hit
 1.146e+08           -11.6%  1.012e+08 ±  2%  numa-vmstat.node1.numa_local
      0.17 ±  5%     -14.8%       0.14 ± 11%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      0.13 ±  5%     -17.0%       0.11 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
     41283 ±  5%     +22.8%      50696 ± 13%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      8372 ± 13%     +22.1%      10221 ±  9%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
      0.16 ±  5%     -15.3%       0.14 ± 12%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.__vm_munmap
      0.12 ±  6%     -17.5%       0.10 ±  8%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.vm_mmap_pgoff
    432388 ±  2%      -2.1%     423334        proc-vmstat.nr_active_anon
    261209 ±  3%      -3.7%     251458        proc-vmstat.nr_shmem
    432388 ±  2%      -2.1%     423334        proc-vmstat.nr_zone_active_anon
 2.286e+08           -13.1%  1.987e+08        proc-vmstat.numa_hit
 2.285e+08           -13.1%  1.986e+08        proc-vmstat.numa_local
 2.287e+08           -13.0%  1.988e+08        proc-vmstat.pgalloc_normal
 4.559e+08           -13.1%  3.962e+08        proc-vmstat.pgfault
 2.283e+08           -13.1%  1.985e+08        proc-vmstat.pgfree
      5.74            -5.3%       5.43        perf-stat.i.MPKI
 5.392e+09            -6.9%  5.019e+09        perf-stat.i.branch-instructions
 1.509e+08            -5.8%  1.421e+08        perf-stat.i.branch-misses
     24.36            -1.4       22.92        perf-stat.i.cache-miss-rate%
 1.538e+08           -12.1%  1.351e+08        perf-stat.i.cache-misses
 6.321e+08            -6.4%  5.915e+08        perf-stat.i.cache-references
    702183            -8.3%     644080        perf-stat.i.context-switches
      6.24           +19.0%       7.42        perf-stat.i.cpi
 1.672e+11           +10.1%  1.841e+11        perf-stat.i.cpu-cycles
    550.50            +2.6%     565.02        perf-stat.i.cpu-migrations
      1085           +25.0%       1356        perf-stat.i.cycles-between-cache-misses
 2.683e+10            -7.0%  2.494e+10        perf-stat.i.instructions
      0.17           -14.7%       0.14 ±  2%  perf-stat.i.ipc
      0.00 ±141%    +265.0%       0.00 ± 33%  perf-stat.i.major-faults
     35.60           -12.2%      31.27        perf-stat.i.metric.K/sec
   1500379           -13.1%    1304071        perf-stat.i.minor-faults
   1500379           -13.1%    1304071        perf-stat.i.page-faults
      5.19 ± 44%     +42.2%       7.37        perf-stat.overall.cpi
    905.91 ± 44%     +50.4%       1362        perf-stat.overall.cycles-between-cache-misses
   8967486 ± 44%     +28.7%   11541403        perf-stat.overall.path-length
 1.387e+11 ± 44%     +32.2%  1.835e+11        perf-stat.ps.cpu-cycles
    457.08 ± 44%     +23.1%     562.85        perf-stat.ps.cpu-migrations
     70.53            -6.7       63.83        perf-profile.calltrace.cycles-pp.__madvise
     68.82            -6.4       62.40        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
     68.63            -6.4       62.23        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     68.38            -6.4       62.02        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     68.36            -6.4       62.01        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     54.54            -3.9       50.68        perf-profile.calltrace.cycles-pp.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.49            -3.8       50.64        perf-profile.calltrace.cycles-pp.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise.do_syscall_64
     20.77            -3.8       16.93 ±  2%  perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
     48.74            -3.8       44.99        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
     42.51            -3.4       39.15        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single
     42.90            -3.4       39.54        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
     43.33            -3.3       40.07        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
     12.96            -2.3       10.63 ±  3%  perf-profile.calltrace.cycles-pp.down_read.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe
     12.32            -2.2       10.12 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise.do_syscall_64
      9.65 ±  2%      -1.9        7.75 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise
      9.46 ±  2%      -1.9        7.57 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.do_madvise
      6.54 ±  2%      -1.5        5.08 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      6.29            -1.1        5.16        perf-profile.calltrace.cycles-pp.testcase
      4.34            -0.9        3.41 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      3.94            -0.9        3.07 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask
      3.79            -0.8        2.95 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch.smp_call_function_many_cond
      3.74            -0.8        2.91 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.llist_add_batch
      4.88 ±  2%      -0.8        4.11 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.28 ±  2%      -0.8        0.52        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      4.63            -0.7        3.92        perf-profile.calltrace.cycles-pp.llist_reverse_order.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
      3.82            -0.7        3.13        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
      3.34 ±  2%      -0.6        2.72 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
      3.23 ±  2%      -0.6        2.63 ±  2%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      5.07            -0.4        4.67 ±  2%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior.do_madvise
      5.05            -0.4        4.65 ±  2%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.zap_page_range_single.madvise_vma_behavior
      3.31            -0.4        2.92        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond
      3.48            -0.4        3.09        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range
      3.35            -0.4        2.96        perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask
      3.82            -0.4        3.44        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
      4.88            -0.4        4.51 ±  2%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.zap_page_range_single
      2.13            -0.3        1.84        perf-profile.calltrace.cycles-pp.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.tlb_finish_mmu
      1.64            -0.3        1.38 ±  2%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      1.38            -0.2        1.16        perf-profile.calltrace.cycles-pp.__irqentry_text_end.testcase
      1.40            -0.2        1.18        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.89 ±  6%      -0.2        0.69 ±  9%  perf-profile.calltrace.cycles-pp.lock_vma_under_rcu.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
      3.23 ±  2%      -0.2        3.06        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      1.13            -0.2        0.97 ±  3%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      2.92 ±  2%      -0.1        2.79        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      2.85 ±  2%      -0.1        2.74        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
      2.74 ±  2%      -0.1        2.64        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
      0.69            -0.1        0.60        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      0.69            -0.1        0.60        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.70            -0.1        0.60        perf-profile.calltrace.cycles-pp.__munmap
      0.69            -0.1        0.60        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.68            -0.1        0.60        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.62 ±  3%      -0.1        0.54        perf-profile.calltrace.cycles-pp.unmap_page_range.zap_page_range_single.madvise_vma_behavior.do_madvise.__x64_sys_madvise
      0.88 ±  2%      -0.1        0.82 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.81 ±  2%      -0.1        0.75 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      1.48            -0.1        1.43        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      0.77 ±  2%      -0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.folios_put_refs
      0.78 ±  2%      -0.1        0.73 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.folios_put_refs.free_pages_and_swap_cache
      1.48            -0.0        1.43        perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise
      1.48            -0.0        1.43        perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.do_madvise.__x64_sys_madvise
      0.51            +0.0        0.56        perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.54            +0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary
      0.60 ±  2%      +0.1        0.72 ±  3%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.98            +0.2        3.21 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.zap_page_range_single
      2.90 ±  2%      +0.2        3.15 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
      2.81 ±  2%      +0.2        3.06 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      0.72 ±  2%      +0.6        1.29 ±  2%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.70 ±  2%      +0.6        1.28 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.6        0.63 ±  2%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule_idle.do_idle.cpu_startup_entry
      9.12            +1.0       10.12        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.70 ±  2%      +1.4        2.06 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.intel_idle_irq.cpuidle_enter_state.cpuidle_enter
      0.61 ±  2%      +1.4        2.00 ±  4%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.intel_idle_irq.cpuidle_enter_state
      0.60 ±  2%      +1.4        1.99 ±  4%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.intel_idle_irq
     19.23            +7.0       26.22        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     19.34            +7.0       26.36        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.03            +7.2       27.19        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     21.50            +7.9       29.39        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     21.51            +7.9       29.40        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     21.51            +7.9       29.40        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     21.72            +8.0       29.70        perf-profile.calltrace.cycles-pp.common_startup_64
      1.04            +8.2        9.20 ±  2%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state
      1.05            +8.2        9.23 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter
      1.17            +8.2        9.38 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.28            +8.2        9.51 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.91            +9.3       11.17        perf-profile.calltrace.cycles-pp.flush_tlb_func.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function
     70.58            -6.7       63.87        perf-profile.children.cycles-pp.__madvise
     69.89            -6.5       63.37        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     69.68            -6.5       63.20        perf-profile.children.cycles-pp.do_syscall_64
     68.38            -6.4       62.02        perf-profile.children.cycles-pp.__x64_sys_madvise
     68.37            -6.4       62.01        perf-profile.children.cycles-pp.do_madvise
     21.28            -3.9       17.39 ±  2%  perf-profile.children.cycles-pp.llist_add_batch
     54.54            -3.9       50.68        perf-profile.children.cycles-pp.madvise_vma_behavior
     54.50            -3.8       50.65        perf-profile.children.cycles-pp.zap_page_range_single
     48.89            -3.8       45.11        perf-profile.children.cycles-pp.tlb_finish_mmu
     43.03            -3.4       39.65        perf-profile.children.cycles-pp.smp_call_function_many_cond
     43.03            -3.4       39.65        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
     43.48            -3.3       40.19        perf-profile.children.cycles-pp.flush_tlb_mm_range
      8.38 ±  2%      -2.4        5.97 ±  2%  perf-profile.children.cycles-pp.intel_idle_irq
     12.98            -2.3       10.64 ±  3%  perf-profile.children.cycles-pp.down_read
     12.41            -2.2       10.19 ±  3%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      9.72 ±  2%      -1.9        7.81 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     15.12            -1.7       13.38 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      8.04            -1.4        6.63        perf-profile.children.cycles-pp.llist_reverse_order
      6.87            -1.2        5.64        perf-profile.children.cycles-pp.testcase
      4.16            -0.7        3.41        perf-profile.children.cycles-pp.asm_exc_page_fault
      3.34 ±  2%      -0.6        2.73 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
      3.30 ±  2%      -0.6        2.69 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
      5.07            -0.4        4.67 ±  2%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      5.05            -0.4        4.66 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      5.06            -0.4        4.67 ±  2%  perf-profile.children.cycles-pp.folios_put_refs
      2.22            -0.3        1.92        perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      1.65            -0.3        1.39 ±  2%  perf-profile.children.cycles-pp.handle_mm_fault
      1.44            -0.2        1.20        perf-profile.children.cycles-pp.__irqentry_text_end
      1.41            -0.2        1.19 ±  2%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.90 ±  6%      -0.2        0.70 ±  9%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      1.23            -0.2        1.05        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      3.24            -0.2        3.06        perf-profile.children.cycles-pp.__page_cache_release
      1.14            -0.2        0.98 ±  3%  perf-profile.children.cycles-pp.do_anonymous_page
      0.26 ±  5%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.poll_idle
      0.79            -0.1        0.66        perf-profile.children.cycles-pp.error_entry
      0.62 ±  3%      -0.1        0.49 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.45 ±  8%      -0.1        0.33 ± 16%  perf-profile.children.cycles-pp.mas_walk
      0.88            -0.1        0.76        perf-profile.children.cycles-pp.native_irq_return_iret
      0.54 ±  3%      -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.50 ±  3%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.page_counter_cancel
      0.54 ±  3%      -0.1        0.43 ±  6%  perf-profile.children.cycles-pp.uncharge_batch
      0.55 ±  2%      -0.1        0.45 ±  3%  perf-profile.children.cycles-pp.up_read
      0.70            -0.1        0.60        perf-profile.children.cycles-pp.__munmap
      0.69            -0.1        0.60        perf-profile.children.cycles-pp.__vm_munmap
      0.69            -0.1        0.60        perf-profile.children.cycles-pp.__x64_sys_munmap
      0.67 ±  3%      -0.1        0.58        perf-profile.children.cycles-pp.unmap_page_range
      0.52 ±  2%      -0.1        0.44 ±  4%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.57            -0.1        0.50 ±  4%  perf-profile.children.cycles-pp.zap_pmd_range
      0.54            -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.54            -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.38 ±  2%      -0.1        0.32        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.53 ±  3%      -0.1        0.47 ±  4%  perf-profile.children.cycles-pp.zap_pte_range
      1.51            -0.1        1.45        perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.52 ±  2%      -0.1        0.47 ±  2%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.48            -0.1        0.42        perf-profile.children.cycles-pp.native_flush_tlb_local
      0.31 ±  2%      -0.1        0.26        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.27 ±  5%      -0.1        0.22 ±  8%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.31 ±  2%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      1.51            -0.1        1.46        perf-profile.children.cycles-pp.schedule
      0.34            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.32            -0.0        0.27        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.50            -0.0        0.45        perf-profile.children.cycles-pp.dequeue_task_fair
      0.40            -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.48            -0.0        0.43        perf-profile.children.cycles-pp.dequeue_entities
      0.28 ±  2%      -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.28            -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.lru_gen_del_folio
      0.24 ±  5%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.find_vma_prev
      0.22 ±  3%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__perf_sw_event
      0.32            -0.0        0.28        perf-profile.children.cycles-pp.irqtime_account_irq
      0.24 ±  4%      -0.0        0.20 ±  7%  perf-profile.children.cycles-pp.down_read_trylock
      0.19 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.14 ±  9%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.22            -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.24            -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.sync_regs
      0.21 ±  2%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.23 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.down_write_killable
      0.29            -0.0        0.26        perf-profile.children.cycles-pp.dequeue_entity
      0.22 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.06            -0.0        0.03 ± 81%  perf-profile.children.cycles-pp.__cond_resched
      0.29 ±  2%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.27            -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.lru_gen_add_folio
      0.09 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
      0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.native_sched_clock
      0.15 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.33 ±  2%      -0.0        0.31        perf-profile.children.cycles-pp.downgrade_write
      0.14 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.34            -0.0        0.32 ±  3%  perf-profile.children.cycles-pp.lru_add
      0.42 ±  2%      -0.0        0.40 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.25            -0.0        0.23        perf-profile.children.cycles-pp.update_process_times
      0.12 ±  6%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.37            -0.0        0.35        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.13 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.11            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.15            -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.14 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.ktime_get
      0.43            -0.0        0.41        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.22 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.enqueue_entity
      0.14 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.free_unref_folios
      0.19 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rmqueue
      0.07 ±  7%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.09            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.read_tsc
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.idle_cpu
      0.08 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.prepare_task_switch
      0.06 ±  7%      -0.0        0.05 ±  9%  perf-profile.children.cycles-pp.mm_cid_get
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.native_apic_mem_eoi
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.16 ±  2%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__switch_to
      0.10 ±  3%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.66            +0.0        0.68        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.11 ±  3%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.start_dl_timer
      0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.task_contending
      0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.52            +0.0        0.56        perf-profile.children.cycles-pp.menu_select
      0.19 ±  5%      +0.0        0.23        perf-profile.children.cycles-pp.handle_softirqs
      0.18 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.18 ±  3%      +0.1        0.23        perf-profile.children.cycles-pp.dl_server_start
      0.11 ±  3%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.46            +0.1        0.52        perf-profile.children.cycles-pp.enqueue_task_fair
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.call_cpuidle
      0.47            +0.1        0.53        perf-profile.children.cycles-pp.enqueue_task
      0.48            +0.1        0.55        perf-profile.children.cycles-pp.ttwu_do_activate
      0.62            +0.1        0.70 ±  4%  perf-profile.children.cycles-pp._find_next_bit
      0.18 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.20            +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.64            +0.1        0.72        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.22            +0.1        0.30        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.21 ±  2%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.rest_init
      0.21 ±  2%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.start_kernel
      0.21 ±  2%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.21 ±  2%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.10 ±  3%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.__bitmap_and
      0.06 ±  6%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.48            +0.1        0.58 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.16 ±  3%      +0.1        0.28        perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.61            +0.1        0.73 ±  3%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.28 ±  2%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.00            +0.2        0.15 ±  3%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.ct_idle_exit
      0.02 ± 99%      +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.37 ±  4%      +0.4        0.73 ±  2%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.22            +0.5        2.76        perf-profile.children.cycles-pp.__schedule
      0.73 ±  2%      +0.6        1.31 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      9.24            +1.0       10.25        perf-profile.children.cycles-pp.intel_idle
     18.85            +6.3       25.12        perf-profile.children.cycles-pp.asm_sysvec_call_function
     19.52            +7.1       26.62        perf-profile.children.cycles-pp.cpuidle_enter_state
     19.53            +7.1       26.63        perf-profile.children.cycles-pp.cpuidle_enter
     20.22            +7.2       27.47        perf-profile.children.cycles-pp.cpuidle_idle_call
     14.43            +7.8       22.23        perf-profile.children.cycles-pp.sysvec_call_function
     13.73            +7.9       21.59        perf-profile.children.cycles-pp.__sysvec_call_function
     21.51            +7.9       29.40        perf-profile.children.cycles-pp.start_secondary
     21.72            +8.0       29.69        perf-profile.children.cycles-pp.do_idle
     21.72            +8.0       29.70        perf-profile.children.cycles-pp.common_startup_64
     21.72            +8.0       29.70        perf-profile.children.cycles-pp.cpu_startup_entry
     14.36            +8.1       22.42        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      3.58            +9.4       12.97        perf-profile.children.cycles-pp.flush_tlb_func
      7.43 ±  2%      -3.8        3.66        perf-profile.self.cycles-pp.intel_idle_irq
     16.93            -2.9       13.99 ±  2%  perf-profile.self.cycles-pp.llist_add_batch
     15.11            -1.7       13.38 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      8.01            -1.4        6.57        perf-profile.self.cycles-pp.llist_reverse_order
      1.44            -0.2        1.19        perf-profile.self.cycles-pp.__irqentry_text_end
      1.69            -0.2        1.50        perf-profile.self.cycles-pp.default_send_IPI_mask_sequence_phys
      0.24 ±  6%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.poll_idle
      0.78            -0.1        0.66        perf-profile.self.cycles-pp.error_entry
      0.87            -0.1        0.76        perf-profile.self.cycles-pp.native_irq_return_iret
      0.65 ±  2%      -0.1        0.54 ±  2%  perf-profile.self.cycles-pp.testcase
      0.46 ±  2%      -0.1        0.37 ±  5%  perf-profile.self.cycles-pp.down_read
      0.38 ±  8%      -0.1        0.29 ± 16%  perf-profile.self.cycles-pp.mas_walk
      0.41 ±  3%      -0.1        0.32 ±  4%  perf-profile.self.cycles-pp.page_counter_cancel
      0.32 ± 12%      -0.1        0.24 ±  4%  perf-profile.self.cycles-pp.zap_page_range_single
      0.46 ±  2%      -0.1        0.38 ±  3%  perf-profile.self.cycles-pp.up_read
      0.28 ±  5%      -0.1        0.21 ±  5%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.56            -0.1        0.49 ±  2%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.32 ± 11%      -0.1        0.25 ± 16%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.30 ±  2%      -0.1        0.24        perf-profile.self.cycles-pp.menu_select
      0.33 ±  6%      -0.1        0.27 ±  7%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.46            -0.1        0.41        perf-profile.self.cycles-pp.native_flush_tlb_local
      0.34            -0.1        0.29 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.32            -0.0        0.27        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  9%      -0.0        0.13 ± 12%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.22 ±  5%      -0.0        0.18 ±  7%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.12 ±  9%      -0.0        0.08 ±  9%  perf-profile.self.cycles-pp.flush_tlb_batched_pending
      0.24            -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.sync_regs
      0.14 ±  4%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.do_madvise
      0.22 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.lru_gen_del_folio
      0.21 ±  2%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ±  7%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.19 ±  4%      -0.0        0.17 ±  6%  perf-profile.self.cycles-pp.down_read_trylock
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.call_function_single_prep_ipi
      0.20 ±  3%      -0.0        0.17        perf-profile.self.cycles-pp.native_sched_clock
      0.13 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.15 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.22 ±  2%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.lru_gen_add_folio
      0.19 ±  3%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.22            -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.folios_put_refs
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.09 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.__madvise
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.rwsem_mark_wake
      0.20 ±  4%      -0.0        0.19 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.read_tsc
      0.09            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.clear_page_erms
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.native_apic_mem_eoi
      0.06 ±  7%      -0.0        0.05 ±  9%  perf-profile.self.cycles-pp.mm_cid_get
      0.10            -0.0        0.09        perf-profile.self.cycles-pp.asm_sysvec_call_function
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.handle_mm_fault
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__switch_to
      0.17 ±  3%      +0.0        0.19 ±  2%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.06            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.do_idle
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.call_cpuidle
      0.48            +0.1        0.56 ±  4%  perf-profile.self.cycles-pp._find_next_bit
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__bitmap_and
      0.38 ±  3%      +0.1        0.49 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.28            +0.1        0.39 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.01 ±223%      +0.2        0.24 ±  3%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.36 ±  4%      +0.4        0.73 ±  2%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      9.24            +1.0       10.25        perf-profile.self.cycles-pp.intel_idle
     15.13            +1.2       16.34        perf-profile.self.cycles-pp.smp_call_function_many_cond
      3.07            +9.5       12.52        perf-profile.self.cycles-pp.flush_tlb_func


***************************************************************************************************
lkp-icl-2sp4: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_ssd/nr_task/priority/rootfs/runtime/tbox_group/test/testcase/thp_defrag/thp_enabled:
  gcc-12/performance/x86_64-rhel-9.4/1/32/1/debian-12-x86_64-20240206.cgz/300/lkp-icl-2sp4/swap-w-seq-mt/vm-scalability/always/never

commit: 
  7e33001b8b ("x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM")
  209954cbc7 ("x86/mm/tlb: Update mm_cpumask lazily")

7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.016e+10 ±  5%     +23.7%  3.732e+10        cpuidle..time
   2394210 ±  5%   +1598.8%   40671711        cpuidle..usage
    280.01 ±  3%     +24.8%     349.50        uptime.boot
     27411 ±  3%     +21.2%      33234        uptime.idle
     73.97            -2.3%      72.29        iostat.cpu.idle
     23.61            -7.6%      21.82        iostat.cpu.iowait
      2.11 ±  2%    +169.7%       5.68 ±  4%  iostat.cpu.system
      0.26 ±  3%      -0.0        0.23 ±  2%  mpstat.cpu.all.irq%
      0.08            -0.0        0.04 ±  4%  mpstat.cpu.all.soft%
      1.78 ±  2%      +3.7        5.45 ±  4%  mpstat.cpu.all.sys%
      0.31 ±  7%      -0.1        0.21 ±  5%  mpstat.cpu.all.usr%
  16661751 ± 42%     -59.8%    6694161 ± 70%  numa-numastat.node0.numa_miss
  16734663 ± 41%     -59.5%    6770170 ± 69%  numa-numastat.node0.other_node
  26857269 ± 23%     -60.2%   10694204 ± 50%  numa-numastat.node1.local_node
  16665351 ± 42%     -59.8%    6694094 ± 70%  numa-numastat.node1.numa_foreign
  26918278 ± 23%     -60.1%   10751098 ± 49%  numa-numastat.node1.numa_hit
    368.92 ± 36%     -55.2%     165.39 ± 74%  vmstat.io.bi
    409795           -51.0%     200717 ±  3%  vmstat.io.bo
      4.14 ±  7%    +100.0%       8.28 ±  6%  vmstat.procs.r
    359.98 ± 37%     -56.0%     158.48 ± 77%  vmstat.swap.si
    409786           -51.0%     200710 ±  3%  vmstat.swap.so
      5382           -28.9%       3825 ±  2%  vmstat.system.cs
    339018 ±  2%     -33.0%     227081 ±  3%  vmstat.system.in
  54162177 ± 11%     -32.5%   36537092 ± 17%  meminfo.Active
  54162037 ± 11%     -32.5%   36536947 ± 17%  meminfo.Active(anon)
  66576747 ±  9%     +24.3%   82748036 ±  9%  meminfo.Inactive
  66575517 ±  9%     +24.3%   82746881 ±  9%  meminfo.Inactive(anon)
    333831           -11.8%     294280        meminfo.PageTables
     33487 ±  3%    +199.2%     100210 ± 26%  meminfo.Shmem
 1.627e+08           +11.4%  1.812e+08        meminfo.SwapFree
      1644 ± 11%     -41.9%     955.75 ± 10%  meminfo.Writeback
     12758 ±  8%    +171.6%      34650 ± 68%  numa-meminfo.node0.Shmem
  31281633 ±  6%     -37.6%   19515816 ± 25%  numa-meminfo.node1.Active
  31281573 ±  6%     -37.6%   19515752 ± 25%  numa-meminfo.node1.Active(anon)
  28059820 ±  5%     +40.6%   39461616 ± 15%  numa-meminfo.node1.Inactive
  28059215 ±  5%     +40.6%   39461201 ± 15%  numa-meminfo.node1.Inactive(anon)
    178279           -16.5%     148899 ±  2%  numa-meminfo.node1.PageTables
     20873 ±  7%    +215.2%      65784 ± 13%  numa-meminfo.node1.Shmem
      1296 ±  6%     -49.8%     650.40 ±  9%  numa-meminfo.node1.Writeback
     38311 ±  5%     -40.8%      22667        vm-scalability.median
   1234132 ±  4%     -40.7%     732265        vm-scalability.throughput
    239.68 ±  5%     +28.4%     307.63        vm-scalability.time.elapsed_time
    239.68 ±  5%     +28.4%     307.63        vm-scalability.time.elapsed_time.max
      6297 ±  5%     +60.9%      10134        vm-scalability.time.involuntary_context_switches
  62687446           -24.8%   47163918 ±  2%  vm-scalability.time.minor_page_faults
    224.00 ±  3%    +166.7%     597.33 ±  3%  vm-scalability.time.percent_of_cpu_this_job_got
    474.22 ±  3%    +276.7%       1786 ±  3%  vm-scalability.time.system_time
     63.58           -17.2%      52.64 ±  3%  vm-scalability.time.user_time
    347556 ±  6%     -26.4%     255772 ±  5%  vm-scalability.time.voluntary_context_switches
 2.821e+08           -22.0%    2.2e+08        vm-scalability.workload
    427.78 ± 20%     +93.8%     828.91 ± 64%  sched_debug.cfs_rq:/.load_avg.max
     13.46 ± 23%     -63.0%       4.98 ± 47%  sched_debug.cfs_rq:/.removed.load_avg.avg
     59.42 ± 17%     -48.6%      30.57 ± 34%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    114.05 ± 16%     +23.9%     141.35 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
    113.70 ± 16%     +23.9%     140.92 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
     10.59 ± 25%    +131.9%      24.56 ± 10%  sched_debug.cfs_rq:/.util_est.avg
     49.96 ± 28%     +71.7%      85.76 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
    130266 ± 19%     +38.9%     180973 ±  8%  sched_debug.cpu.clock.avg
    130457 ± 19%     +38.9%     181208 ±  8%  sched_debug.cpu.clock.max
    130028 ± 19%     +38.9%     180638 ±  8%  sched_debug.cpu.clock.min
    129816 ± 19%     +39.0%     180459 ±  8%  sched_debug.cpu.clock_task.avg
    130389 ± 19%     +38.9%     181122 ±  8%  sched_debug.cpu.clock_task.max
    121562 ± 20%     +40.5%     170799 ±  8%  sched_debug.cpu.clock_task.min
    573.18 ± 25%     +47.9%     847.53 ±  8%  sched_debug.cpu.nr_switches.min
      4.07 ± 14%     +43.8%       5.86 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
    130026 ± 19%     +38.9%     180621 ±  8%  sched_debug.cpu_clk
    129318 ± 19%     +39.1%     179912 ±  8%  sched_debug.ktime
    130797 ± 19%     +38.7%     181392 ±  8%  sched_debug.sched_clk
      3197 ±  8%    +172.3%       8706 ± 67%  numa-vmstat.node0.nr_shmem
   4670410 ±  6%     -22.0%    3641951 ±  8%  numa-vmstat.node0.nr_vmscan_write
   9127776 ±  5%     -21.5%    7169554 ±  5%  numa-vmstat.node0.nr_written
  16661751 ± 42%     -59.8%    6694161 ± 70%  numa-vmstat.node0.numa_miss
  16734663 ± 41%     -59.5%    6770170 ± 69%  numa-vmstat.node0.numa_other
   7829198 ±  6%     -36.9%    4941489 ± 24%  numa-vmstat.node1.nr_active_anon
    718935 ± 14%     +53.9%    1106567 ± 31%  numa-vmstat.node1.nr_free_pages
   6977014 ±  5%     +39.1%    9704494 ± 15%  numa-vmstat.node1.nr_inactive_anon
     44508 ±  2%     -16.6%      37117 ±  2%  numa-vmstat.node1.nr_page_table_pages
      5222 ±  8%    +218.1%      16612 ± 13%  numa-vmstat.node1.nr_shmem
   8007802 ±  6%     -47.6%    4196794 ±  7%  numa-vmstat.node1.nr_vmscan_write
    352.06 ±  7%     -50.7%     173.73 ± 16%  numa-vmstat.node1.nr_writeback
  15775556 ±  6%     -45.5%    8590752 ±  5%  numa-vmstat.node1.nr_written
   7829176 ±  6%     -36.9%    4941484 ± 24%  numa-vmstat.node1.nr_zone_active_anon
   6977031 ±  5%     +39.1%    9704497 ± 15%  numa-vmstat.node1.nr_zone_inactive_anon
    346.80 ±  7%     -49.9%     173.73 ± 16%  numa-vmstat.node1.nr_zone_write_pending
  16665351 ± 42%     -59.8%    6694094 ± 70%  numa-vmstat.node1.numa_foreign
  26917054 ± 23%     -60.1%   10749940 ± 49%  numa-vmstat.node1.numa_hit
  26856045 ± 23%     -60.2%   10693045 ± 50%  numa-vmstat.node1.numa_local
    191035 ±  7%     -29.3%     135009 ±  4%  proc-vmstat.allocstall_movable
      3850 ± 11%     +78.5%       6872 ± 12%  proc-vmstat.allocstall_normal
  13525554 ± 10%     -32.5%    9125751 ± 17%  proc-vmstat.nr_active_anon
  16631565 ±  8%     +23.8%   20588362 ±  9%  proc-vmstat.nr_inactive_anon
     83457           -12.1%      73319        proc-vmstat.nr_page_table_pages
      8392 ±  3%    +198.4%      25047 ± 26%  proc-vmstat.nr_shmem
  12629057 ±  5%     -39.1%    7691618 ±  5%  proc-vmstat.nr_vmscan_write
    440.92 ± 10%     -42.0%     255.71 ± 15%  proc-vmstat.nr_writeback
  24903332 ±  5%     -36.7%   15760306 ±  4%  proc-vmstat.nr_written
  13525564 ± 10%     -32.5%    9125755 ± 17%  proc-vmstat.nr_zone_active_anon
  16631569 ±  8%     +23.8%   20588365 ±  9%  proc-vmstat.nr_zone_inactive_anon
    443.01 ± 10%     -42.0%     257.00 ± 16%  proc-vmstat.nr_zone_write_pending
  24485570 ±  3%     -15.4%   20714438 ±  3%  proc-vmstat.numa_foreign
  39260606 ±  2%     -30.1%   27457969 ±  4%  proc-vmstat.numa_hit
  39098081 ±  2%     -30.1%   27325222 ±  4%  proc-vmstat.numa_local
  24482446 ±  3%     -15.5%   20696329 ±  3%  proc-vmstat.numa_miss
  24643161 ±  3%     -15.5%   20828939 ±  3%  proc-vmstat.numa_other
   7478080 ± 19%    +140.2%   17959948 ±  8%  proc-vmstat.numa_pte_updates
  63140512           -24.7%   47553512        proc-vmstat.pgalloc_normal
  63461017           -24.5%   47896127 ±  2%  proc-vmstat.pgfault
  64134373           -24.6%   48331932 ±  2%  proc-vmstat.pgfree
      2796 ± 78%     -70.9%     815.00 ± 50%  proc-vmstat.pgmigrate_fail
  99615377 ±  5%     -36.7%   63043276 ±  4%  proc-vmstat.pgpgout
     34932 ±  3%      -7.8%      32198 ±  2%  proc-vmstat.pgreuse
  21507042 ±  5%     -36.0%   13775181 ±  4%  proc-vmstat.pgrotated
  58427243 ± 10%     -43.5%   32993860 ± 12%  proc-vmstat.pgscan_anon
  44324880 ± 10%     -37.2%   27839440 ± 10%  proc-vmstat.pgscan_direct
  14102763 ± 23%     -63.4%    5154838 ± 27%  proc-vmstat.pgscan_kswapd
      2666 ± 88%     -90.7%     248.33 ±137%  proc-vmstat.pgskip_normal
  24911061 ±  5%     -36.7%   15767491 ±  4%  proc-vmstat.pgsteal_anon
  17074863 ±  8%     -25.3%   12754191 ±  5%  proc-vmstat.pgsteal_direct
   7836517 ±  8%     -61.5%    3013661 ±  7%  proc-vmstat.pgsteal_kswapd
  24903332 ±  5%     -36.7%   15760306 ±  4%  proc-vmstat.pswpout
     78185 ± 27%     -82.8%      13463 ± 52%  proc-vmstat.workingset_nodereclaim
      1.85 ±  4%     -31.7%       1.26        perf-stat.i.MPKI
 1.992e+09 ±  3%     -18.9%  1.615e+09 ±  2%  perf-stat.i.branch-instructions
      0.93 ±  6%      +0.6        1.55 ±  3%  perf-stat.i.branch-miss-rate%
  14377927 ± 11%     +29.7%   18645141 ±  5%  perf-stat.i.branch-misses
     13.97 ±  3%      -9.0        4.95        perf-stat.i.cache-miss-rate%
  15782867 ±  3%     -34.3%   10364434 ±  2%  perf-stat.i.cache-misses
  79049148           +92.6%  1.522e+08 ±  2%  perf-stat.i.cache-references
      5344           -29.2%       3783 ±  2%  perf-stat.i.context-switches
      1.31 ±  2%    +316.3%       5.46 ±  3%  perf-stat.i.cpi
 8.392e+09 ±  3%    +197.0%  2.492e+10 ±  3%  perf-stat.i.cpu-cycles
    150.26           +14.1%     171.44 ±  3%  perf-stat.i.cpu-migrations
    737.89 ±  5%    +500.7%       4432 ±  4%  perf-stat.i.cycles-between-cache-misses
 7.732e+09 ±  3%     -17.2%  6.405e+09 ±  2%  perf-stat.i.instructions
      0.80           -69.8%       0.24 ±  5%  perf-stat.i.ipc
     23.75 ± 27%     -52.9%      11.19 ± 69%  perf-stat.i.major-faults
      2.55 ±  8%     -38.4%       1.57 ±  4%  perf-stat.i.metric.K/sec
    265295 ±  5%     -42.5%     152670 ±  2%  perf-stat.i.minor-faults
    265319 ±  5%     -42.5%     152681 ±  2%  perf-stat.i.page-faults
      2.04 ±  2%     -20.6%       1.62 ±  2%  perf-stat.overall.MPKI
      0.72 ± 12%      +0.4        1.15 ±  4%  perf-stat.overall.branch-miss-rate%
     19.95 ±  2%     -13.1        6.84        perf-stat.overall.cache-miss-rate%
      1.09 ±  2%    +257.6%       3.88 ±  3%  perf-stat.overall.cpi
    532.42 ±  2%    +350.1%       2396 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.92           -72.0%       0.26 ±  4%  perf-stat.overall.ipc
      6551 ±  2%     +38.5%       9072        perf-stat.overall.path-length
 1.982e+09 ±  3%     -18.5%  1.616e+09        perf-stat.ps.branch-instructions
  14325844 ± 11%     +29.7%   18584702 ±  5%  perf-stat.ps.branch-misses
  15697779 ±  3%     -33.9%   10379452 ±  2%  perf-stat.ps.cache-misses
  78678984           +93.0%  1.518e+08 ±  2%  perf-stat.ps.cache-references
      5321           -29.1%       3771 ±  2%  perf-stat.ps.context-switches
 8.355e+09 ±  3%    +197.6%  2.487e+10 ±  3%  perf-stat.ps.cpu-cycles
    149.59           +14.2%     170.85 ±  3%  perf-stat.ps.cpu-migrations
 7.693e+09 ±  3%     -16.8%  6.404e+09        perf-stat.ps.instructions
     23.73 ± 27%     -52.9%      11.18 ± 69%  perf-stat.ps.major-faults
    263785 ±  5%     -41.9%     153177        perf-stat.ps.minor-faults
    263809 ±  5%     -41.9%     153188        perf-stat.ps.page-faults
 1.848e+12 ±  2%      +8.0%  1.995e+12        perf-stat.total.instructions
      0.09 ±  3%    +316.6%       0.37 ±135%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.04 ± 15%     -34.4%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.05 ± 17%    +600.7%       0.34 ±172%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 26%   +2198.6%       0.27 ±152%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.06 ±  8%     +41.6%       0.09 ± 17%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.07 ±  8%     +36.7%       0.10 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      1.18 ± 45%  +14663.2%     173.84 ±219%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.16 ±  7%     +81.8%       0.29 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
      0.13 ± 13%     -55.3%       0.06 ± 83%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.folio_alloc_swap.add_to_swap.shrink_folio_list
      0.18 ± 11%   +8754.6%      15.60 ±219%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.35 ±107%   +2644.1%     256.70 ±154%  perf-sched.sch_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.15 ± 25%    +100.0%       0.31 ± 52%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.17 ± 10%     +74.6%       0.30 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.16 ± 12%    +391.4%       0.80 ±148%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
      0.11 ± 94%   +1386.1%       1.62 ± 66%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.15 ± 18%     +45.5%       0.22 ± 13%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     87.69 ±  2%     +57.5%     138.09 ±  4%  perf-sched.total_wait_and_delay.average.ms
     87.52 ±  2%     +57.6%     137.91 ±  4%  perf-sched.total_wait_time.average.ms
      7.23 ±142%    +493.8%      42.93 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
     89.03 ± 56%     -97.9%       1.83 ±152%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.__folio_lock_or_retry.do_swap_page
     21.44 ±  3%     +88.0%      40.32 ±  7%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    383.35 ±  3%      +8.2%     414.60 ±  3%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     40.29 ± 34%    +602.5%     283.08 ± 58%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.06          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    338.75 ± 23%     -65.9%     115.54 ± 72%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     20.91 ±  4%     +64.7%      34.43 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
      5.97 ±  8%     -27.5%       4.33        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    527.31 ±  2%     +20.9%     637.26 ± 10%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    159.81 ±  2%     +78.2%     284.75 ±  9%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    640.33 ± 11%     +33.5%     854.67 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     26.83 ±141%    +777.6%     235.50 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
      5.00           +43.3%       7.17 ± 12%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      7206 ±  4%     -28.5%       5149 ± 12%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      8.67 ± 10%     +38.5%      12.00 ± 16%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    160.17 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    112.17 ± 33%    +279.8%     426.00 ± 13%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
    639.00 ± 11%    +120.6%       1409 ± 18%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     15.52 ±141%   +4400.0%     698.48 ± 63%  perf-sched.wait_and_delay.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
      3425 ± 44%     -99.4%      22.13 ±141%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.__folio_lock_or_retry.do_swap_page
      1212 ±  4%     +81.2%       2197 ± 12%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      6.49 ± 46%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     81.27 ± 26%     -60.3%      32.25 ± 60%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3448 ± 12%     +48.4%       5119 ± 23%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     21.71 ±  7%     +97.3%      42.83 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
      6.41 ± 96%    +426.5%      33.77 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      9.59 ± 52%    +792.6%      85.58 ± 27%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
     88.96 ± 56%     -90.5%       8.44 ± 53%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.__folio_lock_or_retry.do_swap_page
     21.33 ±  3%     +88.1%      40.12 ±  6%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    383.33 ±  3%      +8.2%     414.58 ±  3%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     40.28 ± 34%    +602.1%     282.81 ± 59%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.97           -16.8%       3.30 ±  3%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    338.69 ± 23%     -54.8%     153.25 ± 23%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     22.02 ± 23%    +462.9%     123.94 ± 26%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     20.81 ±  4%     +65.0%      34.33 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.mempool_alloc_noprof.bio_alloc_bioset
      5.87 ±  8%     -28.1%       4.22        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    527.30 ±  2%     +20.9%     637.25 ± 10%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    159.22 ±  2%     +78.8%     284.72 ±  9%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     42.83 ±  9%   +1530.6%     698.38 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.__swap_writepage.swap_writepage
     12.83 ± 82%    +344.6%      57.05 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    124.59 ± 77%    +333.7%     540.35 ± 31%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1212 ±  4%     +81.2%       2197 ± 12%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    220.10 ± 74%    +283.8%     844.67 ± 11%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     81.17 ± 26%     -60.4%      32.15 ± 60%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3385 ± 10%     +51.2%       5119 ± 23%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     79.77           -10.1       69.65        perf-profile.calltrace.cycles-pp.do_access
     77.33            -7.8       69.51        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      7.43 ±  2%      -6.8        0.66 ± 13%  perf-profile.calltrace.cycles-pp.add_to_swap.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
      6.76 ±  5%      -5.8        0.95 ±  5%  perf-profile.calltrace.cycles-pp.llist_add_batch.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty
      6.24 ±  2%      -5.7        0.58 ± 12%  perf-profile.calltrace.cycles-pp.folio_alloc_swap.add_to_swap.shrink_folio_list.evict_folios.try_to_shrink_lruvec
      5.73 ±  4%      -5.6        0.17 ±141%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty
     74.64            -5.4       69.25        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     74.54            -5.3       69.25        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      5.79 ±  3%      -5.2        0.55 ± 11%  perf-profile.calltrace.cycles-pp.__mem_cgroup_try_charge_swap.folio_alloc_swap.add_to_swap.shrink_folio_list.evict_folios
      5.51 ±  4%      -5.1        0.37 ± 72%  perf-profile.calltrace.cycles-pp.do_rw_once
     73.45            -4.3       69.17        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      3.92 ±  2%      -3.5        0.44 ± 44%  perf-profile.calltrace.cycles-pp.default_send_IPI_mask_sequence_phys.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty
     72.77            -2.9       69.91        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     74.31            -1.9       72.37        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.6        0.59 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.7        0.66 ±  5%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state
      0.00            +0.7        0.69 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_call_function.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter
      0.00            +0.8        0.81 ± 26%  perf-profile.calltrace.cycles-pp.__get_user_pages.get_user_pages_remote.get_arg_page.copy_string_kernel.do_execveat_common
      0.00            +0.8        0.81 ± 26%  perf-profile.calltrace.cycles-pp.copy_string_kernel.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.81 ± 26%  perf-profile.calltrace.cycles-pp.get_arg_page.copy_string_kernel.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.8        0.81 ± 26%  perf-profile.calltrace.cycles-pp.get_user_pages_remote.get_arg_page.copy_string_kernel.do_execveat_common.__x64_sys_execve
      0.00            +0.8        0.81 ± 26%  perf-profile.calltrace.cycles-pp.handle_mm_fault.__get_user_pages.get_user_pages_remote.get_arg_page.copy_string_kernel
      0.00            +0.8        0.81 ± 12%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.00            +0.8        0.81 ± 12%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      0.00            +0.8        0.81 ± 12%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.00            +0.8        0.81 ± 12%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.9        0.95 ± 19%  perf-profile.calltrace.cycles-pp._Fork
      0.08 ±223%      +1.0        1.06 ± 12%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy
      0.08 ±223%      +1.0        1.06 ± 12%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault
      0.08 ±223%      +1.0        1.06 ± 12%  perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault.handle_mm_fault
      0.08 ±223%      +1.0        1.06 ± 12%  perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.09 ±223%      +1.0        1.06 ± 12%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +1.3        1.26 ±  7%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +1.4        1.36 ± 30%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.__get_user_pages.get_user_pages_remote.get_arg_page
      0.00            +1.6        1.64 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.21 ± 46%      +2.0        3.22 ± 29%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.20 ± 46%      +2.0        3.22 ± 29%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.20 ± 46%      +2.0        3.22 ± 29%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.18 ± 47%      +2.0        3.22 ± 29%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +2.1        2.09 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.30 ±100%      +2.2        2.48 ± 11%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.30 ±100%      +2.2        2.48 ± 11%  perf-profile.calltrace.cycles-pp.execve
     67.34            +2.3       69.67        perf-profile.calltrace.cycles-pp.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     67.27            +2.4       69.67        perf-profile.calltrace.cycles-pp.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
     67.22            +2.4       69.66        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio.do_anonymous_page
     67.12            +2.5       69.64        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof.alloc_anon_folio
      5.78            +3.1        8.85 ±  6%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      5.78            +3.1        8.85 ±  6%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      5.78            +3.1        8.85 ±  6%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      2.21 ±  6%      +3.2        5.36 ± 11%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      4.87            +3.7        8.62 ±  6%  perf-profile.calltrace.cycles-pp.balance_pgdat.kswapd.kthread.ret_from_fork.ret_from_fork_asm
      4.87            +3.7        8.62 ±  6%  perf-profile.calltrace.cycles-pp.kswapd.kthread.ret_from_fork.ret_from_fork_asm
      4.87            +3.7        8.62 ±  6%  perf-profile.calltrace.cycles-pp.shrink_many.shrink_node.balance_pgdat.kswapd.kthread
      4.87            +3.7        8.62 ±  6%  perf-profile.calltrace.cycles-pp.shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork
      4.87            +3.7        8.62 ±  6%  perf-profile.calltrace.cycles-pp.shrink_one.shrink_many.shrink_node.balance_pgdat.kswapd
      4.87            +3.8        8.62 ±  6%  perf-profile.calltrace.cycles-pp.try_to_shrink_lruvec.shrink_one.shrink_many.shrink_node.balance_pgdat
     66.53            +4.1       70.63        perf-profile.calltrace.cycles-pp.__alloc_pages_slowpath.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      6.72 ±  2%      +4.5       11.21 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      6.72 ±  2%      +4.5       11.21 ±  9%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      6.72 ±  2%      +4.5       11.20 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      6.94 ±  2%      +4.6       11.50 ±  9%  perf-profile.calltrace.cycles-pp.common_startup_64
      3.57 ±  2%      +5.1        8.64 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.65 ±  2%      +5.5        9.14 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      4.52 ±  2%      +6.3       10.82 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     64.31            +6.9       71.18        perf-profile.calltrace.cycles-pp.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof
     64.17            +7.4       71.56        perf-profile.calltrace.cycles-pp.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_noprof.alloc_pages_mpol_noprof
     64.15            +7.4       71.56        perf-profile.calltrace.cycles-pp.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath.__alloc_pages_noprof
     62.53            +9.0       71.48        perf-profile.calltrace.cycles-pp.shrink_many.shrink_node.do_try_to_free_pages.try_to_free_pages.__alloc_pages_slowpath
     62.50            +9.0       71.48        perf-profile.calltrace.cycles-pp.shrink_one.shrink_many.shrink_node.do_try_to_free_pages.try_to_free_pages
     62.03            +9.4       71.45        perf-profile.calltrace.cycles-pp.try_to_shrink_lruvec.shrink_one.shrink_many.shrink_node.do_try_to_free_pages
     66.79           +13.3       80.06        perf-profile.calltrace.cycles-pp.evict_folios.try_to_shrink_lruvec.shrink_one.shrink_many.shrink_node
     63.11           +16.6       79.70        perf-profile.calltrace.cycles-pp.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one.shrink_many
     42.45 ±  2%     +35.3       77.74 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unmap_flush_dirty.shrink_folio_list.evict_folios.try_to_shrink_lruvec.shrink_one
     42.43 ±  2%     +35.3       77.74 ±  2%  perf-profile.calltrace.cycles-pp.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_folio_list.evict_folios.try_to_shrink_lruvec
     42.34 ±  2%     +35.4       77.73 ±  2%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_folio_list.evict_folios
     41.73 ±  2%     +35.9       77.58 ±  2%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.arch_tlbbatch_flush.try_to_unmap_flush_dirty.shrink_folio_list
     15.56 ±  2%     -12.5        3.03 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function
     80.28           -10.4       69.87        perf-profile.children.cycles-pp.do_access
     11.47 ±  4%     -10.1        1.37 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
     10.79 ±  4%      -9.5        1.32 ±  4%  perf-profile.children.cycles-pp.__sysvec_call_function
     11.76 ±  3%      -9.4        2.34 ±  3%  perf-profile.children.cycles-pp.sysvec_call_function
      8.04 ±  2%      -7.2        0.79 ± 11%  perf-profile.children.cycles-pp.add_to_swap
      7.85 ±  4%      -6.7        1.19 ±  7%  perf-profile.children.cycles-pp.llist_add_batch
      6.84 ±  2%      -6.2        0.69 ±  9%  perf-profile.children.cycles-pp.folio_alloc_swap
      6.38 ±  2%      -5.7        0.65 ±  8%  perf-profile.children.cycles-pp.__mem_cgroup_try_charge_swap
      5.83 ±  7%      -5.3        0.57 ± 50%  perf-profile.children.cycles-pp.rmap_walk_anon
      5.72 ±  4%      -5.1        0.62 ± 15%  perf-profile.children.cycles-pp.do_rw_once
      5.03 ±  6%      -4.6        0.47 ±  4%  perf-profile.children.cycles-pp.flush_tlb_func
      4.76 ±  4%      -4.3        0.41 ±143%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.83 ±  2%      -4.1        0.73 ±  3%  perf-profile.children.cycles-pp.default_send_IPI_mask_sequence_phys
      4.27 ±  7%      -3.9        0.34 ±  9%  perf-profile.children.cycles-pp.try_to_unmap
      4.31 ±  3%      -3.9        0.40 ± 17%  perf-profile.children.cycles-pp.pageout
      4.46 ±  2%      -3.8        0.64 ±  4%  perf-profile.children.cycles-pp.llist_reverse_order
     78.01            -3.6       74.42        perf-profile.children.cycles-pp.asm_exc_page_fault
      3.88 ±  8%      -3.6        0.30 ±  6%  perf-profile.children.cycles-pp.try_to_unmap_one
      3.94 ±  3%      -3.6        0.37 ± 17%  perf-profile.children.cycles-pp.swap_writepage
      3.10 ±  4%      -2.7        0.36 ± 77%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     73.30            -2.3       70.98        perf-profile.children.cycles-pp.do_anonymous_page
      2.48 ±  6%      -2.3        0.19 ± 10%  perf-profile.children.cycles-pp.get_page_from_freelist
      2.36 ±  7%      -2.1        0.25 ± 20%  perf-profile.children.cycles-pp.swap_cgroup_record
      2.31 ±  3%      -2.1        0.25 ±  5%  perf-profile.children.cycles-pp.page_counter_try_charge
      2.39            -2.1        0.34 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      2.26 ±  5%      -2.0        0.25 ±115%  perf-profile.children.cycles-pp.folio_batch_move_lru
     76.12            -2.0       74.16        perf-profile.children.cycles-pp.exc_page_fault
     76.08            -1.9       74.15        perf-profile.children.cycles-pp.do_user_addr_fault
      2.20 ±  4%      -1.9        0.34 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock
      1.85 ±  3%      -1.8        0.09 ± 10%  perf-profile.children.cycles-pp.native_flush_tlb_local
      2.09 ±  2%      -1.7        0.36 ± 23%  perf-profile.children.cycles-pp.handle_softirqs
      1.76 ±  6%      -1.5        0.22 ±  8%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      1.78 ±  8%      -1.5        0.25 ±103%  perf-profile.children.cycles-pp.folio_referenced
      1.68 ±  3%      -1.5        0.19 ± 36%  perf-profile.children.cycles-pp.blk_complete_reqs
      1.57 ±  6%      -1.5        0.12 ± 31%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.54 ± 15%      -1.4        0.11 ±  8%  perf-profile.children.cycles-pp.set_tlb_ubc_flush_pending
      1.61 ±  3%      -1.4        0.18 ± 34%  perf-profile.children.cycles-pp.scsi_end_request
      1.61 ±  3%      -1.4        0.18 ± 34%  perf-profile.children.cycles-pp.scsi_io_completion
      1.57 ±  4%      -1.4        0.16 ± 11%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.48 ±  4%      -1.3        0.16 ± 35%  perf-profile.children.cycles-pp.blk_update_request
      1.44 ±  8%      -1.3        0.13 ± 12%  perf-profile.children.cycles-pp.__swap_writepage
      1.38 ±  7%      -1.3        0.08 ± 40%  perf-profile.children.cycles-pp.__remove_mapping
      1.33 ±  6%      -1.3        0.07 ± 40%  perf-profile.children.cycles-pp.do_softirq
      1.32 ± 11%      -1.2        0.08 ±  6%  perf-profile.children.cycles-pp.rmqueue
      1.34 ± 11%      -1.2        0.12 ± 15%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      1.43 ±  7%      -1.2        0.23 ±106%  perf-profile.children.cycles-pp.__folio_batch_add_and_move
      1.18 ± 12%      -1.1        0.06 ±  7%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      1.25 ±  4%      -1.1        0.14 ± 50%  perf-profile.children.cycles-pp.isolate_folios
      1.24 ±  4%      -1.1        0.14 ± 48%  perf-profile.children.cycles-pp.scan_folios
      1.19 ±  6%      -1.1        0.12 ± 10%  perf-profile.children.cycles-pp.try_charge_memcg
      1.12 ± 13%      -1.1        0.06 ±  9%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.18 ±  4%      -1.1        0.12 ± 25%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      1.25 ±  9%      -1.0        0.20 ±122%  perf-profile.children.cycles-pp.folio_referenced_one
      1.14 ±  7%      -1.0        0.11 ±  6%  perf-profile.children.cycles-pp.mem_cgroup_id_get_online
      1.13 ±  3%      -1.0        0.12 ± 42%  perf-profile.children.cycles-pp.end_swap_bio_write
      1.08 ±  5%      -1.0        0.09 ± 22%  perf-profile.children.cycles-pp.add_to_swap_cache
      1.09 ±  4%      -1.0        0.11 ± 26%  perf-profile.children.cycles-pp.__submit_bio
      1.10 ±  3%      -1.0        0.12 ± 43%  perf-profile.children.cycles-pp.folio_end_writeback
      1.06 ±  4%      -1.0        0.11 ± 24%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      1.04 ±  6%      -0.9        0.12 ±  6%  perf-profile.children.cycles-pp._find_next_bit
      1.00 ±  2%      -0.9        0.11 ± 47%  perf-profile.children.cycles-pp.isolate_folio
      0.96 ± 12%      -0.9        0.08 ± 34%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.94 ±  3%      -0.9        0.08 ± 38%  perf-profile.children.cycles-pp.page_vma_mapped_walk
      1.28 ±  9%      -0.8        0.46 ± 15%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.95 ±  4%      -0.8        0.15 ± 17%  perf-profile.children.cycles-pp.__schedule
      0.85 ±  3%      -0.7        0.13 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.75 ±  4%      -0.7        0.08 ± 17%  perf-profile.children.cycles-pp.sync_regs
      1.16 ±  4%      -0.6        0.52 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.70 ±  4%      -0.6        0.08 ± 61%  perf-profile.children.cycles-pp.lru_gen_del_folio
      0.70 ±  5%      -0.6        0.08 ± 52%  perf-profile.children.cycles-pp.lru_gen_add_folio
      0.66 ±  8%      -0.6        0.05 ± 48%  perf-profile.children.cycles-pp.__folio_start_writeback
      1.08 ±  4%      -0.6        0.47 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.69 ±  7%      -0.6        0.11 ± 18%  perf-profile.children.cycles-pp.schedule
      0.75 ±  6%      -0.6        0.18 ± 19%  perf-profile.children.cycles-pp.worker_thread
      0.65 ± 11%      -0.5        0.10 ± 20%  perf-profile.children.cycles-pp.__drain_all_pages
      0.64 ±  4%      -0.5        0.11 ±  6%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.64 ± 16%      -0.5        0.12 ± 25%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.64 ± 16%      -0.5        0.12 ± 25%  perf-profile.children.cycles-pp.common_interrupt
      0.54 ±  6%      -0.5        0.04 ± 75%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.54 ±  6%      -0.5        0.04 ± 75%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.53 ±  6%      -0.5        0.04 ± 73%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      0.56 ± 12%      -0.5        0.07 ± 23%  perf-profile.children.cycles-pp.drain_pages_zone
      0.54 ±  4%      -0.5        0.06 ± 19%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.52 ±  7%      -0.5        0.03 ± 70%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.54 ±  4%      -0.5        0.06 ± 19%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.54 ±  3%      -0.5        0.06 ± 19%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.51 ± 10%      -0.4        0.08 ± 24%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.49 ±  7%      -0.4        0.08 ± 17%  perf-profile.children.cycles-pp.__pick_next_task
      0.45 ±  5%      -0.4        0.04 ± 75%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.62 ±  4%      -0.4        0.22 ±  8%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.44 ±  5%      -0.4        0.04 ± 75%  perf-profile.children.cycles-pp.wbt_wait
      0.42 ±  6%      -0.4        0.04 ± 75%  perf-profile.children.cycles-pp.rq_qos_wait
      0.42 ±  5%      -0.4        0.04 ± 45%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.66 ±  3%      -0.3        0.31 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.65 ±  3%      -0.3        0.31 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.48 ±  3%      -0.3        0.15 ±  8%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.40 ± 10%      -0.3        0.06 ± 17%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.46 ±  6%      -0.3        0.14 ± 23%  perf-profile.children.cycles-pp.process_one_work
      0.38 ± 10%      -0.3        0.06 ± 19%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.44 ±  6%      -0.3        0.12 ± 15%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.56 ±  3%      -0.3        0.24 ±  4%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.42 ± 10%      -0.3        0.11 ± 13%  perf-profile.children.cycles-pp.sched_balance_rq
      0.42 ±  4%      -0.3        0.12 ±  7%  perf-profile.children.cycles-pp.sched_clock
      0.45 ±  6%      -0.3        0.16 ± 13%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.37 ±  9%      -0.3        0.09 ± 12%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.50 ±  3%      -0.3        0.23 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.36 ±  8%      -0.3        0.09 ± 13%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.31 ±  8%      -0.3        0.04 ± 71%  perf-profile.children.cycles-pp.tlb_is_not_lazy
      0.33 ± 11%      -0.3        0.08 ± 15%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.44 ±  4%      -0.2        0.20 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.30 ±  7%      -0.2        0.07 ± 10%  perf-profile.children.cycles-pp.error_entry
      0.29 ±  4%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.irq_work_run_list
      0.39 ±  6%      -0.2        0.19 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.28 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.28 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp._printk
      0.28 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.28 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.irq_work_run
      0.28 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.irq_work_single
      0.28 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.28 ±  5%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.console_flush_all
      0.28 ±  5%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.console_unlock
      0.28 ±  5%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.vprintk_emit
      0.28 ±  4%      -0.2        0.09 ±  7%  perf-profile.children.cycles-pp.serial8250_console_write
      0.28 ±  5%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.wait_for_lsr
      0.23 ± 15%      -0.2        0.06 ± 65%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.24 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.24 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.24 ±  7%      -0.2        0.08 ± 13%  perf-profile.children.cycles-pp.drm_fbdev_shmem_helper_fb_dirty
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.commit_tail
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail
      0.24 ±  7%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.23 ±  8%      -0.2        0.08 ± 11%  perf-profile.children.cycles-pp.memcpy_toio
      0.19 ± 11%      -0.1        0.06 ± 13%  perf-profile.children.cycles-pp.io_serial_in
      0.19 ±  7%      -0.1        0.06 ± 98%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.20 ± 10%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.sched_tick
      0.11 ± 13%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.sched_balance_domains
      0.10 ±  4%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.sched_core_idle_cpu
      0.14 ±  5%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.irqentry_enter
      0.09 ± 14%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.clockevents_program_event
      0.09 ± 11%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.task_tick_fair
      0.03 ± 70%      +0.0        0.08 ± 11%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.tmigr_cpu_new_timer
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.get_cpu_device
      0.21 ±  9%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.rest_init
      0.21 ±  9%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.start_kernel
      0.21 ±  9%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.21 ±  9%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.intel_idle_irq
      0.01 ±223%      +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.load_elf_interp
      0.00            +0.1        0.10 ± 12%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.12 ±  9%      +0.1        0.22 ±  8%  perf-profile.children.cycles-pp.ktime_get
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.01 ±223%      +0.1        0.14 ± 47%  perf-profile.children.cycles-pp._IO_setvbuf
      0.00            +0.1        0.13 ±  9%  perf-profile.children.cycles-pp.ct_idle_exit
      0.01 ±223%      +0.1        0.14 ± 83%  perf-profile.children.cycles-pp._copy_to_iter
      0.02 ±142%      +0.1        0.16 ±  8%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.01 ±223%      +0.1        0.15 ±  8%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.01 ±223%      +0.2        0.16 ± 40%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.01 ±223%      +0.2        0.16 ± 40%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.08 ± 41%      +0.2        0.23 ± 24%  perf-profile.children.cycles-pp.write
      0.01 ±223%      +0.2        0.16 ± 39%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.07 ± 63%      +0.2        0.23 ± 24%  perf-profile.children.cycles-pp.ksys_write
      0.06 ± 60%      +0.2        0.23 ± 24%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.2        0.17 ± 33%  perf-profile.children.cycles-pp.copy_p4d_range
      0.00            +0.2        0.17 ± 33%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.2        0.18 ± 32%  perf-profile.children.cycles-pp.dup_mmap
      0.12 ± 15%      +0.2        0.30 ±  6%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.00            +0.2        0.18 ± 38%  perf-profile.children.cycles-pp.__do_fault
      0.00            +0.2        0.18 ± 14%  perf-profile.children.cycles-pp.__pmd_alloc
      0.01 ±223%      +0.2        0.20 ± 36%  perf-profile.children.cycles-pp.__libc_fork
      0.02 ±141%      +0.2        0.21 ±130%  perf-profile.children.cycles-pp.__cmd_record
      0.04 ± 72%      +0.2        0.27 ± 30%  perf-profile.children.cycles-pp.dup_mm
      0.07 ± 16%      +0.2        0.30 ± 13%  perf-profile.children.cycles-pp.elf_load
      0.05 ± 82%      +0.3        0.31 ± 44%  perf-profile.children.cycles-pp.schedule_tail
      0.15 ± 16%      +0.3        0.41 ± 17%  perf-profile.children.cycles-pp.__vfork
      0.14 ± 17%      +0.3        0.41 ± 17%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.03 ±101%      +0.3        0.30 ± 13%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.04 ± 71%      +0.3        0.32 ± 19%  perf-profile.children.cycles-pp.poll_idle
      0.01 ±223%      +0.3        0.29 ± 30%  perf-profile.children.cycles-pp.___kmalloc_large_node
      0.01 ±223%      +0.3        0.29 ± 30%  perf-profile.children.cycles-pp.__kmalloc_large_node_noprof
      0.01 ±223%      +0.3        0.29 ± 30%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.04 ±112%      +0.3        0.32 ± 41%  perf-profile.children.cycles-pp.__put_user_4
      0.12 ± 26%      +0.3        0.42 ± 17%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.09 ± 28%      +0.3        0.40 ± 37%  perf-profile.children.cycles-pp.__p4d_alloc
      0.09 ± 28%      +0.3        0.40 ± 37%  perf-profile.children.cycles-pp.get_zeroed_page_noprof
      0.10 ± 21%      +0.3        0.43 ± 39%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.10 ± 19%      +0.3        0.43 ± 39%  perf-profile.children.cycles-pp.do_sys_openat2
      0.01 ±223%      +0.3        0.34 ± 26%  perf-profile.children.cycles-pp.__kvmalloc_node_noprof
      0.01 ±223%      +0.3        0.34 ± 26%  perf-profile.children.cycles-pp.single_open_size
      0.09 ± 22%      +0.3        0.43 ± 39%  perf-profile.children.cycles-pp.do_filp_open
      0.09 ± 22%      +0.3        0.43 ± 39%  perf-profile.children.cycles-pp.path_openat
      0.12 ±  6%      +0.3        0.47 ±  8%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.04 ± 45%      +0.3        0.39 ± 34%  perf-profile.children.cycles-pp.perf_evlist__poll
      0.04 ± 45%      +0.3        0.39 ± 34%  perf-profile.children.cycles-pp.perf_evlist__poll_thread
      0.04 ± 44%      +0.4        0.39 ± 34%  perf-profile.children.cycles-pp.perf_poll
      0.04 ± 45%      +0.4        0.40 ± 33%  perf-profile.children.cycles-pp.do_poll
      0.04 ± 45%      +0.4        0.40 ± 33%  perf-profile.children.cycles-pp.__poll
      0.04 ± 45%      +0.4        0.40 ± 33%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.04 ± 45%      +0.4        0.40 ± 33%  perf-profile.children.cycles-pp.do_sys_poll
      0.02 ±141%      +0.4        0.38 ± 32%  perf-profile.children.cycles-pp.do_open
      0.02 ±141%      +0.4        0.38 ± 32%  perf-profile.children.cycles-pp.vfs_open
      0.07 ± 14%      +0.4        0.44 ±  9%  perf-profile.children.cycles-pp.tick_irq_enter
      0.02 ±141%      +0.4        0.39 ± 34%  perf-profile.children.cycles-pp.__pollwait
      0.01 ±223%      +0.4        0.38 ± 32%  perf-profile.children.cycles-pp.do_dentry_open
      0.10 ± 11%      +0.4        0.47 ±  7%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.04 ± 72%      +0.4        0.43 ± 10%  perf-profile.children.cycles-pp.alloc_new_pud
      0.22 ± 21%      +0.4        0.62 ±  7%  perf-profile.children.cycles-pp.do_pte_missing
      0.06 ± 51%      +0.4        0.47 ± 15%  perf-profile.children.cycles-pp.setup_arg_pages
      0.01 ±223%      +0.4        0.42 ± 40%  perf-profile.children.cycles-pp.open64
      0.06 ± 50%      +0.4        0.47 ± 15%  perf-profile.children.cycles-pp.relocate_vma_down
      0.05 ± 73%      +0.4        0.47 ± 15%  perf-profile.children.cycles-pp.move_page_tables
      0.14 ± 10%      +0.5        0.61 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.10 ± 13%      +0.5        0.56 ± 23%  perf-profile.children.cycles-pp.__do_sys_clone
      0.21 ± 26%      +0.5        0.74 ± 29%  perf-profile.children.cycles-pp.get_free_pages_noprof
      0.16 ± 17%      +0.5        0.69 ± 13%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.16 ± 18%      +0.5        0.70 ± 15%  perf-profile.children.cycles-pp.dup_task_struct
      0.08 ± 41%      +0.5        0.62 ± 19%  perf-profile.children.cycles-pp.copy_strings
      0.15 ± 20%      +0.6        0.73 ± 16%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.16 ± 17%      +0.6        0.74 ± 15%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.19 ± 19%      +0.6        0.81 ± 12%  perf-profile.children.cycles-pp.bprm_execve
      0.18 ± 20%      +0.6        0.81 ± 12%  perf-profile.children.cycles-pp.exec_binprm
      0.18 ± 20%      +0.6        0.81 ± 12%  perf-profile.children.cycles-pp.search_binary_handler
      0.18 ± 21%      +0.6        0.81 ± 12%  perf-profile.children.cycles-pp.load_elf_binary
      0.10 ± 54%      +0.7        0.81 ± 26%  perf-profile.children.cycles-pp.copy_string_kernel
      0.24 ± 10%      +0.7        0.98 ± 15%  perf-profile.children.cycles-pp.kernel_clone
      0.23 ± 12%      +0.7        0.98 ± 15%  perf-profile.children.cycles-pp.copy_process
      0.16 ± 22%      +0.8        0.95 ± 19%  perf-profile.children.cycles-pp._Fork
      0.09 ± 28%      +0.9        0.96 ± 16%  perf-profile.children.cycles-pp.__pud_alloc
      0.32 ±  8%      +0.9        1.27 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.18 ± 38%      +1.3        1.43 ± 20%  perf-profile.children.cycles-pp.get_arg_page
      0.18 ± 37%      +1.3        1.43 ± 20%  perf-profile.children.cycles-pp.__get_user_pages
      0.18 ± 37%      +1.3        1.43 ± 20%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.39 ± 43%      +1.4        1.82 ±  8%  perf-profile.children.cycles-pp.wp_page_copy
      0.53 ± 15%      +1.9        2.48 ± 11%  perf-profile.children.cycles-pp.do_execveat_common
      0.53 ± 14%      +1.9        2.48 ± 11%  perf-profile.children.cycles-pp.execve
      0.53 ± 15%      +1.9        2.48 ± 11%  perf-profile.children.cycles-pp.__x64_sys_execve
      5.78            +3.1        8.85 ±  6%  perf-profile.children.cycles-pp.kthread
      2.28 ±  5%      +3.2        5.48 ± 11%  perf-profile.children.cycles-pp.intel_idle
      5.84            +3.3        9.16 ±  7%  perf-profile.children.cycles-pp.ret_from_fork
      5.84            +3.4        9.20 ±  6%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.46 ±  7%      +3.5        4.97 ±  8%  perf-profile.children.cycles-pp.do_syscall_64
      1.46 ±  7%      +3.5        4.97 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.87            +3.7        8.62 ±  6%  perf-profile.children.cycles-pp.balance_pgdat
      4.87            +3.7        8.62 ±  6%  perf-profile.children.cycles-pp.kswapd
     68.16            +4.2       72.34        perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      6.72 ±  2%      +4.5       11.21 ±  9%  perf-profile.children.cycles-pp.start_secondary
      6.94 ±  2%      +4.6       11.50 ±  9%  perf-profile.children.cycles-pp.common_startup_64
      6.94 ±  2%      +4.6       11.50 ±  9%  perf-profile.children.cycles-pp.cpu_startup_entry
      6.93 ±  2%      +4.6       11.50 ±  9%  perf-profile.children.cycles-pp.do_idle
     68.51            +5.0       73.50        perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      3.78            +5.5        9.32 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter_state
      3.80            +5.6        9.39 ±  9%  perf-profile.children.cycles-pp.cpuidle_enter
      4.70            +6.4       11.09 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
     69.40            +7.4       76.85        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
     69.44            +8.1       77.55        perf-profile.children.cycles-pp.__alloc_pages_noprof
     68.72            +8.7       77.46        perf-profile.children.cycles-pp.__alloc_pages_slowpath
     65.97           +11.3       77.23        perf-profile.children.cycles-pp.try_to_free_pages
     65.66           +11.5       77.18        perf-profile.children.cycles-pp.do_try_to_free_pages
     70.51           +15.3       85.80        perf-profile.children.cycles-pp.shrink_node
     68.95           +16.8       85.72        perf-profile.children.cycles-pp.shrink_many
     68.92           +16.8       85.71        perf-profile.children.cycles-pp.shrink_one
     68.42           +17.3       85.68        perf-profile.children.cycles-pp.try_to_shrink_lruvec
     68.37           +17.3       85.67        perf-profile.children.cycles-pp.evict_folios
     64.64           +20.7       85.30 ±  2%  perf-profile.children.cycles-pp.shrink_folio_list
     43.46           +39.8       83.30 ±  2%  perf-profile.children.cycles-pp.try_to_unmap_flush_dirty
     43.44           +39.9       83.30 ±  2%  perf-profile.children.cycles-pp.arch_tlbbatch_flush
     43.35           +40.0       83.33 ±  2%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
     43.34           +40.0       83.33 ±  2%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      5.95 ±  4%      -4.9        1.04 ±  7%  perf-profile.self.cycles-pp.llist_add_batch
      4.70 ±  4%      -4.3        0.41 ±142%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.45 ±  2%      -3.8        0.64 ±  4%  perf-profile.self.cycles-pp.llist_reverse_order
      4.31 ±  5%      -3.8        0.53 ± 14%  perf-profile.self.cycles-pp.do_rw_once
      3.65 ±  2%      -3.0        0.66 ±  4%  perf-profile.self.cycles-pp.default_send_IPI_mask_sequence_phys
      3.14 ±  9%      -2.8        0.36 ±  4%  perf-profile.self.cycles-pp.flush_tlb_func
      2.56 ±  5%      -2.3        0.30 ± 16%  perf-profile.self.cycles-pp.do_access
      2.35 ±  4%      -2.1        0.27 ±  6%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      2.39            -2.1        0.34 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      1.83 ±  3%      -1.7        0.09 ± 10%  perf-profile.self.cycles-pp.native_flush_tlb_local
      1.92 ±  3%      -1.7        0.24 ±  4%  perf-profile.self.cycles-pp.page_counter_try_charge
      1.69 ±  4%      -1.4        0.31 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock
      1.12 ± 14%      -1.0        0.10 ±  6%  perf-profile.self.cycles-pp.set_tlb_ubc_flush_pending
      0.99 ±  6%      -0.9        0.10 ± 10%  perf-profile.self.cycles-pp.try_to_unmap_one
      0.98 ±  7%      -0.9        0.12 ± 11%  perf-profile.self.cycles-pp.try_charge_memcg
      0.94 ±  5%      -0.8        0.10 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_id_get_online
      0.75 ± 13%      -0.7        0.07 ± 34%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.75 ±  5%      -0.7        0.09 ± 27%  perf-profile.self.cycles-pp.shrink_folio_list
      0.74 ±  4%      -0.7        0.08 ± 17%  perf-profile.self.cycles-pp.sync_regs
      0.76 ±  9%      -0.7        0.10 ±  9%  perf-profile.self.cycles-pp._find_next_bit
      0.63 ±  3%      -0.6        0.07 ± 16%  perf-profile.self.cycles-pp.swap_writepage
      0.57 ±  9%      -0.5        0.04 ± 72%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.47 ±  7%      -0.4        0.02 ± 99%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.56 ±  4%      -0.4        0.13 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.48 ±  6%      -0.4        0.05 ±  7%  perf-profile.self.cycles-pp.swap_cgroup_record
      0.45 ±  6%      -0.4        0.04 ±115%  perf-profile.self.cycles-pp.lru_gen_add_folio
      0.46 ±  2%      -0.4        0.05 ± 90%  perf-profile.self.cycles-pp.lru_gen_del_folio
      0.40 ±  6%      -0.4        0.04 ± 71%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.38 ±  3%      -0.3        0.04 ± 45%  perf-profile.self.cycles-pp.do_anonymous_page
      0.28 ±  8%      -0.2        0.07 ± 12%  perf-profile.self.cycles-pp.error_entry
      0.38 ±  6%      -0.2        0.19 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.25 ± 10%      -0.2        0.06 ± 13%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.23 ±  7%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.memcpy_toio
      0.19 ± 11%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.io_serial_in
      0.16 ±  8%      -0.1        0.06 ± 17%  perf-profile.self.cycles-pp.asm_sysvec_call_function
      0.11 ± 11%      -0.1        0.04 ± 44%  perf-profile.self.cycles-pp.irqentry_enter
      0.17 ±  8%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.09 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.sched_core_idle_cpu
      0.03 ± 70%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.tick_nohz_stop_tick
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.cpuidle_enter
      0.07 ± 12%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.1        0.07 ± 13%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.get_cpu_device
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.tick_irq_enter
      0.01 ±223%      +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.__get_next_timer_interrupt
      0.00            +0.1        0.10 ± 11%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.02 ± 99%      +0.3        0.30 ± 19%  perf-profile.self.cycles-pp.poll_idle
      0.13 ±  8%      +0.4        0.50 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.11 ± 13%      +0.6        0.69 ±  9%  perf-profile.self.cycles-pp.cpuidle_enter_state
      2.28 ±  5%      +3.2        5.48 ± 11%  perf-profile.self.cycles-pp.intel_idle
     24.40           +56.1       80.53 ±  2%  perf-profile.self.cycles-pp.smp_call_function_many_cond



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


