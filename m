Return-Path: <linux-kernel+bounces-381856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61F9B0585
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527DA1C225ED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE9C200B9E;
	Fri, 25 Oct 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eujgYALj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902ED1FB894
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865784; cv=fail; b=uQXs1Q+o26Un33YHA7MpBARr4uFcduFgUkCaMr1bOpyaPA/26S+63BrNkPU0ZD+NpRQzqaDZj8QmyRLlUAG++f7VHmx2Cz9mnQuS3vUQ83x6K/qU4xCwHye+IRkGaF9hksDYfHqZcvfHtUeLxueOYmNOWkxocklrk8vGmRMtSuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865784; c=relaxed/simple;
	bh=dVI9uhybbFY52DuaH25iQcU7tXhc92KTMBy/JPcY3WU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ld6ADDqOJM4RsJvyE46hYH3vk0f10gzOc9a8RM5uyqzbc9ljVO74BB1e/v2KAriduggViY9NbhTjLw5SU39bR+7C/xWkwL068Lb294PEsWzATuusewEjaWVeqQjRjHoZ7w51ED5FzrsIQb+rrgmrYRs+9KMCRIfgKUfwKmayg+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eujgYALj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729865782; x=1761401782;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dVI9uhybbFY52DuaH25iQcU7tXhc92KTMBy/JPcY3WU=;
  b=eujgYALj23p1YpkQ8AZIGaxzW8WWncjPluFGInx/VpZ0xF4Y7X+BGP9+
   l+8LCyUco9HesEyD+RQFvLh/EKMuwOsvXa5OFP8wH+O5KtNcwK04U3Sw+
   j/q7wORKbF9MRUx546iiPtxSBUyFYZydX+BLfJLHp1ykcPoWLVrB+49SO
   br8sRo8H2VnrZFqbHoxnmPYb9n4uCmsibqRCKRVXaL7yykNfMfb/H+RD2
   p88QvDKig0Wy5VoQ6JDL7gLQLTk1vzX0ST0zGrNHDMdFaaAnD+UhYrUO1
   9ZU9a/SfcOMbrI0OeZ61C9lO1ONSHlPDmUeAq/lhxrc8RTyRKbkbV9rqF
   g==;
X-CSE-ConnectionGUID: eD7IQ1iPRAeSqw21FZMTZQ==
X-CSE-MsgGUID: tJSdz3/ATha6kXHFln2oiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29480731"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29480731"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:16:22 -0700
X-CSE-ConnectionGUID: INWWqqsSTI+DM0mtL1JqLA==
X-CSE-MsgGUID: +Cfj0lEGSfWT0qbFxog2KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80855959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 07:16:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 07:16:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 07:16:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 07:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQnexR7DOS4cwN6H5Lw0Xeas6hAV25geg3NJg7MyID4/Tz9Rs4P3yIekKUk6QsrG0tkuky8PE2wr4gk9PpZfrxhj5dtwbR88ylRBu+jHtyNeufgPMorz+j/u/MaGIEMsut7KFFa/Wk+FHCLRV7Ud8ow4V1/EmHnRTU9hwK9eyJCpOnZbul6j2LawcK8yTaXNmJbxUeED67vIoI3Kd1Dfx+Kkn+fqCOoiRMyhsdal4Sj12TBZId8EM99KmSE8PM1jAA4K5L5JSZESr5S0ZDu2MOqo6WBbh11VdC4asJSl0gffSOBmmO8NCltf21I2OJG/HA7VT1eQeRCr5yMm2epUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emaMel530RbsU9tmMPGI4QhpFxNMpy/pfkUGdqUYQNA=;
 b=OL/XksP2sbteEdx1icaIfU7Qrufodm9KgnztM3tj0PerVdkrg1fXWfTtOcVvLkkBkL/o1yyBhiASEySU6CL8L5WNCzXObUqAF8nf4qiR0llWSLvA/NINdq2/Nok64LtcyOKpcUULBI3dUDBiM7UeQaJt/+mhDuC7Jk0224yItekV5SklOosmYvSUKy7f0BvNaCUsoNId/c8V7nNWKxxEtLbSv0meHhfzS55q3tfKqGsblobwkPizshwOSOFfHl006oOi3OnhwofSZqM3U/4Xtu1mbYETwnEBSzwDhKuD9CcM0QA1+pPUlJGuXx8VZFQoAp7K3+VhaGzPXbi2RmM2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:16:15 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:16:15 +0000
Date: Fri, 25 Oct 2024 16:15:56 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
Message-ID: <dak3d3rnzx5o6faogq3awougwateiwkf7a7o6el3iiwlghjxgf@dn2dxxg4ttfb>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024013214.129639-1-torvalds@linux-foundation.org>
X-ClientProxiedBy: DB9PR06CA0004.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::9) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b66b45e-ea0c-4579-ce01-08dcf4ff95c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?arozVMQIehPk6fYvkRcECEYbnfuQkOlsyhxwZDo2WjZmkqKfcmlxVuVitH?=
 =?iso-8859-1?Q?UEyqPmJOKDgQZD/JgpiPug7nVEg0JiOqJQ55bwclC9soAhnKLfa0LmCtqn?=
 =?iso-8859-1?Q?Bf+e4D8najX5cgX+pozisuBoaIi/0BZjhOyFI1c7MaVfEnXZIiwGGsg85K?=
 =?iso-8859-1?Q?zV5y8JIZFj5gRFbB3RtKXe+/Na/2C93U5ZCKenZ8TkgxC/c4eVzgr/NQgW?=
 =?iso-8859-1?Q?TB6ansVXebTQjMyMnYXrWHQ1Mg9jspxvE7TkJdHMubQ7VHhgrVd2NASAWK?=
 =?iso-8859-1?Q?y7WDIJRam//O1h+8DrsqQNyFvFU2N3GjQIAckKTk+MRFuIUTNQcFxS5yvX?=
 =?iso-8859-1?Q?fPXy4QBl4NEwKtbYxFxBgDUq/S06HDUz1i6I93OAn7MR4dk9k0LAT1td95?=
 =?iso-8859-1?Q?2qRevR6BWvwoBRzp+jbvU8AY04xtRfG88ojlGUcdkzFXTVQwVnTLjedaNP?=
 =?iso-8859-1?Q?ZrtSoRlrpAWdHDy6IT21M7pRcQeUqHexOezQDlSYCZ2vP2ZB1FSiLdVPrj?=
 =?iso-8859-1?Q?Sn5hk9kKevTeSLZBlI8WNqsFFCJz51pKTq+CLx6Hlw99ONuZMsThul8Dp8?=
 =?iso-8859-1?Q?rdXPbcGXmZHQ9v44UDSJI9wsph9/uSFQ0fkUz4amB2uLFrz8fttuLp6/YR?=
 =?iso-8859-1?Q?paoOCp+qSi9mbW9Qly1G0mWreah6g9dtWgaS+0C5PVUXeIJYM/jIJ/U8Fy?=
 =?iso-8859-1?Q?f23WHcNhJ1XzXC+xePE5FsqoD+hxmFKzKwUyPSy5qlokILcTAVYu4xtV4y?=
 =?iso-8859-1?Q?6nYALpZW28lko0aCbk0fpKhPthvmZghGVp4FGPIAhqMd0tqVoveMnkNpjU?=
 =?iso-8859-1?Q?ytvF3ZqSlw3mLOXVM1tP3p4tS/a3cI36uyoHrzdOw3QWqs9vQdbFtImzkW?=
 =?iso-8859-1?Q?/dIIWNEsr0QtzR2rRD/YfbttLCVG+eR+PjpKdVL2cTL4PacBiqZVnlHQNW?=
 =?iso-8859-1?Q?kR8d7aOJEtdexCCIbiU9DJh2/7PgjrAEf7v3VrCjF3h9FPUPDEvrha2nGg?=
 =?iso-8859-1?Q?XhERobzKIygWoDgVwCLatHpqXXxw7W34Id2YNOSDKhGuy4YmqO7yfnK8Zk?=
 =?iso-8859-1?Q?ZRwhMAAoItx4zE2WrTj97Whj/tIaAPEMlRyN8EtiNGlqVHjO8FQ6KS1xG3?=
 =?iso-8859-1?Q?DIuhxR8eAxaoZC4y23NzeSJmz8yEidtJm5HuTbVk+p833j2pTFh0vjCaT7?=
 =?iso-8859-1?Q?22WAEnGfm+u9S6Oj6Uow2tGhRad9P6culslmCnN1mqETWlMNZdYF50ttiv?=
 =?iso-8859-1?Q?I6Ulx7ktY9B6SaAqGCOO3hzQnSlPxCmRpNBOsFNQmkqjhVFajLXKxd+2tE?=
 =?iso-8859-1?Q?BchFAMPJF1LvEZdINtn2Qc02O9i4e44fDNXQ9ApilInQgwoMWc7sBosqCE?=
 =?iso-8859-1?Q?37sSTY2msh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qPFwQQ3taJrTyxyxoMH49nLt/11laO26fqoF+4waJULaYfD/7nSCRPJDWc?=
 =?iso-8859-1?Q?4vUE68SgNUkdXoDseubYEAzGi53QYWbDfnu+I5/gzZrNgUluI+aY1rJkji?=
 =?iso-8859-1?Q?8xGpm2oni8bsr9JvOiIVw+g4tUBteqAnRrrdxttDQ0sMOfhN5Elmz/r9+J?=
 =?iso-8859-1?Q?vX4gJYEFGygrAbbOXT8/bTnqRbm1burXRt+cNPpHc/f9XihK5v0DsmXNIE?=
 =?iso-8859-1?Q?PDeHopYpKoyC+RxslzWXt4JgWRxcKppHTS68eQ6Q6BI0Gd8VWM/6qXjdtD?=
 =?iso-8859-1?Q?AJkhqU3ucvvxlLuCA+mtP57vaWLCPQR8CJ/tjYOlyGUO8R8NLSwSIrOEwz?=
 =?iso-8859-1?Q?kxdvydOT1UCrAwGCZ9YYE5Kd6ja77tcKQbNneuXsG5V3uPznC1+x/d7omz?=
 =?iso-8859-1?Q?4yYH4U5PoXJQnAJAQUVPhoYUY7EtKxue1ac8FZA6bfMa02GPhHoYEOBZoV?=
 =?iso-8859-1?Q?9h20c7LIi3Y+YZVxvKHYksEEyCbjfv2pKsIkIgDBLgyZDV7+JuJ3N19TYp?=
 =?iso-8859-1?Q?NpCLbguz/bQOvq7/mLQcp2U+yGIaI+BKkzCoQm45504HxBdd/GrX3iiHpn?=
 =?iso-8859-1?Q?mCc75rVfhBMhQln2OfhbTED4LhNCqOaRVbWALc4cRr9IQeucipAKcpp6c4?=
 =?iso-8859-1?Q?bycQJVbDQz0W7cAbYdllo2kxLscDueN+WlgGMuYtfA68DLkYzXlHNKpX7W?=
 =?iso-8859-1?Q?MWO9+Xk4mFuWD5lWNtn0vFX90ebciq3bbkQImbtVnK9MMNPx3c5KHEe895?=
 =?iso-8859-1?Q?CFRSl/GhHNkLRHpk3oj7hH9q3jB3ViRvTqBQMzE8uiqIcLKuZq769qpFOb?=
 =?iso-8859-1?Q?9Ll+FgxkX2IvBtt+2mWXvsleHKpc/m4KDUSzL5F1CE2FzomZ4gMmDUVE8j?=
 =?iso-8859-1?Q?/wifTPaPwl2TxDdQO5frK+oTaGeVb2lBweT65F9scD2xIchm3iLuxsCYhH?=
 =?iso-8859-1?Q?t8oir7gVbndcLkldJxPh1FyRdwSQDdWCfq5Czc1lujD0WIf3VmajLPWXaP?=
 =?iso-8859-1?Q?Y5onBP1JKExgRYFjNSSF/tZJ3SbJI4dATJqOaFvZjliBxlkScKQeVWnPCD?=
 =?iso-8859-1?Q?19BOAfuuDiLmZBomdLKDAJeMAUcv12ey/uHOxUOD9MifJ0Mp08qRzRWVf7?=
 =?iso-8859-1?Q?zavQkZHqaVv40odtG4704vwkuXSwAKXlaelXjfz/rjUMZxL6jPfVTM3Rr6?=
 =?iso-8859-1?Q?deGOZifbS4WLOdDs+94fNMubjsrlJYPIl3I2fXPRoDBpdmBvLOtIARCXPw?=
 =?iso-8859-1?Q?LUowuhrelwlBrDaLN9wdGCWacFzBXWOZ3c8gDWNSKrWcFlJw0sFw27C+68?=
 =?iso-8859-1?Q?DYWwmDxW6oLQg/YfcXLJpZP/DdtUSKju0/YozFKSG0W50HqUqNWsBtksNz?=
 =?iso-8859-1?Q?fAkgY6LTk75LnNqKCPRNZs/M82ZCUkN7FrP1OG/W2ryjGB6EaJke5OmTqu?=
 =?iso-8859-1?Q?blZ8vUW1Y9at7hWgqgsF+Xec3JIMx5avG9Ro7d2df099brEIjq1jY4XZW5?=
 =?iso-8859-1?Q?64Fq2qVDXpKnNuuRIUYQz/O6wn+SPYwkYYGhZkN4dwlI4qS9AV2VUc4wzU?=
 =?iso-8859-1?Q?nl3FV4obPTD+4ZGPtoDEqaoiilQvcpQdHGNtrOItXl8WmvE2c7HXFxeRhU?=
 =?iso-8859-1?Q?WHhBEIYJUecfDsDoroXkfaH45kU/OkF5C0Uu9SBTusqIXKdqklGokrSrzO?=
 =?iso-8859-1?Q?iZF70haf937xyV2/fN4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b66b45e-ea0c-4579-ce01-08dcf4ff95c5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:16:15.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc6FYGPPUBEvvokL4hwt4rejj+3ofLvzbd63eauUUnDm59jaaMTPkajC4q0Ti6gCF8whGcLDUzfhZnfT/zam4MsXgS8oCxAEAwFLsKByZ1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com

Hello!

On 2024-10-23 at 18:31:59 -0700, Linus Torvalds wrote:
> ...
> 	if (IS_ENABLED(CONFIG_X86_64)) {
>+		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
>+
>+		/*
>+		 * Enable this when LAM is gated on LASS support
>+		if (cpu_feature_enabled(X86_FEATURE_LAM))
>+			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
>+		 */
>+		runtime_const_init(ptr, USER_PTR_MAX);
> ...

I tested the patch on a Sierra Forest Xeon that is LAM capable and I didn't find
any issues.

To test the LAM related portion I uncommented the above if statement
and enabled LAM_SUP during the boot process as well as enabled LAM for the user
process with a syscall.

I did the tests by writing a ioctl that calls get_user() on demand and prints
whatever the user passes. Then before calling the ioctl I modified the pointer
to the variable in a few different ways:

- 5 level pointer on 4 level system
[root@srf1 ~]# ./test_get_user
[  603.531778] Running get_user on address : 0xff007ffdfce791bc
[  603.538225] Value received from user is : 0
Enabling LAM...
LAM enable syscall ret = 0, errno = 0
Int pointer before tagging : 0x7ffdfce791bc
Int pointer after tagging : 0xff007ffdfce791bc
IOCTL ret : -1, errno : 14

- Cleared top bit
[root@srf1 ~]# ./test_get_user
[  625.543365] Running get_user on address : 0x7fffffff4ddb3d4c
[  625.549828] Value received from user is : 0
Enabling LAM...
LAM enable syscall ret = 0, errno =  0
Int pointer before tagging : 0x7fff4ddb3d4c
Int pointer after tagging : 0x7fffffff4ddb3d4c
IOCTL ret : -1, errno : 14

- Cleared bit 48
[root@srf1 ~]# ./test_get_user
[  686.801259] Running get_user on address : 0xffff7ffcdc2691ac
[  686.807724] Value received from user is : 0
Enabling LAM...
LAM enable syscall ret = 0, errno =  0
Int pointer before tagging : 0x7ffcdc2691ac
Int pointer after tagging : 0xffff7ffcdc2691ac
IOCTL ret : -1, errno : 14

- Normal kernel address
[root@srf1 ~]# ./test_get_user
[ 1047.074342] Running get_user on address : 0xffffffff17bfed1c
[ 1047.080801] Value received from user is : 0
Enabling LAM...
LAM enable syscall ret = 0, errno =  0
Int pointer before tagging : 0x7fff17bfed1c
Int pointer after tagging : 0xffffffff17bfed1c
IOCTL ret : -1, errno : 14

- Control group with properly tagged pointer
[root@srf1 ~]# ./test_get_user
[  767.464666] Running get_user on address : 0x7a007ffe6c9dac3c
[  767.472644] Value received from user is : 12345
Enabling LAM...
LAM enable syscall ret = 0, errno =  0
Int pointer before tagging : 0x7ffe6c9dac3c
Int pointer after tagging : 0x7a007ffe6c9dac3c
IOCTL ret : 0, errno : 0

Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

-- 
Kind regards
Maciej Wieczór-Retman

