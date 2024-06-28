Return-Path: <linux-kernel+bounces-234225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88391C3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CF81C224DE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029315886A;
	Fri, 28 Jun 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYi0MuIm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA81BE87E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593001; cv=fail; b=CArEUyTYb+j+81vBel7EVWpR6RGRL5wVUuRpqZke8PUqLhynZ3zizK9Y9Jb00U/z+MG0Yt3GNJ9NB/U6S91KAMEwnU6ElB9OnQmH172Z10IZqfkBCzxWlc6NCLbe+nNj/D/4P5O3muzwnpqTpVKqgo0KcmRT/F1EGWz63mw53g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593001; c=relaxed/simple;
	bh=xdKg4mMYbTaoAHzjOrzNOlNtdYP3fcwDWaDRv3na4rM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=da2GSxlsPf7TmGBUClmLu3nXhQxcQLks4/IBfR0BHWbk8TaKVnXEaAqU5fuKRsMY22iB4dnHs55AcwtzJ2iKqrRBvhRMFx41Mb5bRE1jHQq+WYdwdb9efuPi7iA34YpcyaqrLNPEF6BKhYYSfXmQRl0PwpqE9T/THUx849eGfuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYi0MuIm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593000; x=1751129000;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xdKg4mMYbTaoAHzjOrzNOlNtdYP3fcwDWaDRv3na4rM=;
  b=UYi0MuIm023soQ+akucZm7+f0XScJOuh5NvsQFGUzGMxuG+3170DL9vk
   /9AvDyMielJR1rViQAZ1vzOHFqzW73IzLDU6gXnGtNRU/1TlLkvwgALx5
   DG0qhE/yfxP1K9EQdeTv0B8pNhyH3B/UW+WhlBG4Rx7Z+JHcJ5WDDKDs5
   v2GJiJ7kRnDSn/rGAMIVKYm5QqoksID0bbk2VECq9WdWXKvcS9/Z264BE
   fXP6OB9X8ZP1qEx8Hu72XeqRqWYZ27mrI1wxKIQXo3L+kCwc7Zj5aI/mx
   DMEHjGKyLQLDsbcGmHl63kdiIQgtohqFP5KftTfCFUpXwj7wbeI9UUGA/
   g==;
X-CSE-ConnectionGUID: jWKhogiBTTmtMTGC+FouJQ==
X-CSE-MsgGUID: 7lUNO34sQg+IgHfhjyV4+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16520716"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16520716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:43:19 -0700
X-CSE-ConnectionGUID: qwW+ZX/PTxO5zvWRakXx/g==
X-CSE-MsgGUID: j8hQn1+bQIi3Y4QbGgbcAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44873525"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:43:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:43:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB/V0IOegqlwNR67T5uE3KTDS7k/1O4I+Nlh5xfDf4EBFgTyVpI5Vo04xhRE8UpdMa57NtX1Yt+Fts5poOR178GQni7bDyLoFYo6K4EvFf2OugTLUecghm0eWQSRlcOtNPxEj+l2vR0uGN8I7JGLUyrXz0mcs6iYC3XcfKl4izuKU0TRRbxInHckqna4aa/up8msSG/WD3pjoU/As3ykTFU3R+Xl7nBOyfm/SWUktrNyYhEg44ENBk2HWhMWVYTyVOiBm5UPv/O3B/+zVZNzIwhNNxUxp3g1kVNHkT7+dEnfrrWTNv6puEWwN4c/ELaxtTAfGLdzUK8Sgz769D+HFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEoCIA2e+3wMP2nw5P049JLIv2ECj3bZ2e3N76nCwV8=;
 b=TpEzxJcAbfjJTVnaFhQtC5US5FRW+M7bBw7+3NzdSlTIyQx6g+f62t3irkyC92oQhk+KRRdvEOKirJHiwvHzDf2XUhLisdD1DdtvO4ahS2iLhsuYaqVbcS+X0Ce5xJoDFds11bBW397lLLF2O1M6EkeKPzd4Zd0pvU3PabmVKAwYQ/+AbJXrgLTTcgwZVIEIZYvZ8GZPljvjyQEbc2bBAeBtlMU4j6mesMGE8CSIl5OCBiHHC71pFD1HBSTvN8ImbOpb9i6SbVS7/4v7W40Um5SfGwd2EfYWBz5DkBgRd/mnNCYVgPvWYQdsqhl1Bm8HZORvIrgQy76vxZn46SCx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:43:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:43:11 +0000
Message-ID: <62581526-2dfa-44a5-a0bb-8582932b9943@intel.com>
Date: Fri, 28 Jun 2024 09:43:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/38] x86/resctrl: Add a schema format enum and use
 this for fflags
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-4-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 18305fa2-a1d2-4389-1057-08dc97916583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFNmYWtScHdJZ3ZoYUpaVG5GTEtEVElLTlpDZEplVUJzMGkyOFNWWTJIZ2Ro?=
 =?utf-8?B?aUFoK0xyZndEdEZHbW1KL2gzb1hjc2d2dm4xVDRwRGNLZFVXTnJsSS9vWDRL?=
 =?utf-8?B?VHdsL0tZajhId1RERHhleHpPc1VBRlhEdDRuOWN6b0VPZ3dTeHVJK2dubVJQ?=
 =?utf-8?B?REh5bGtFaHN4c0VXd0hvZ1pUd3ZNUkN1SDZ1a1ROb0dqc21OdmJLNkxhK2l1?=
 =?utf-8?B?NkwwVmdycjNCRWtWa3Y3N2poZnB0UWU1S0lMOHJZT3JIK3hzS05UZ0hPcEtI?=
 =?utf-8?B?cmFMV096WW1VU2sxbDFvZzFibjZjMHdVSEFpVDF2cTBsT05lemdPcUZwTGtN?=
 =?utf-8?B?UzZ6RlFYVTh3eFhLQWZXcnR6UmlyT2RBcUVqdFNUNXBmR3dhdEJ4OHQ2T2Va?=
 =?utf-8?B?UUFiUk1QMGNDM0dVanpMeWFOamVhUlhBMHhJelBrY1I5QTFKRHlubEIwTTdz?=
 =?utf-8?B?bjRlaUNmOEF2aUQ0NHNJbU5PQ1F3MjhiNFFaQnA1S1BOYmtnZlBpazRLNk9x?=
 =?utf-8?B?VzdzcjlrWkRSNDNxYlhyN0NiRzlBeTIvWEtSWGVGMTdqbTlpTS9qUzFHZ0U5?=
 =?utf-8?B?OE1YaWE1emFWT2tRamlrelpET2ExK2d6QytEL3FyNFJKR3hONnpmT3lYKy9S?=
 =?utf-8?B?QmlXTW5oM0cwbjZ2VDAvUk03dDZjTWtWWGtPdXlsaHYrWkFzV3dWVXFNUmhN?=
 =?utf-8?B?Q0dNQWhhMDFTbWJ6UUIybWF6WVU4L3UrUjlKdHFQKzdnMWFQMGRGMGJXSUYz?=
 =?utf-8?B?OWpUMFBFbU9UaE9EWlBncGRmYnRLTE9PMFY0QkxGQm1MY1QybnQvTDFBaUtG?=
 =?utf-8?B?TmFFcTM3VXVJcXk0TDNEeWxjZXNxcGE5UkpJWkVORlpvTlJHbzJ2U2pUMmpC?=
 =?utf-8?B?eThHVHlzRVBhQm1sVnBjUmlDejR2SEpPYUsvd3UzWlRqR3g3K3hZT083azdW?=
 =?utf-8?B?amhnZDBtcUZRT21qMnlTd2NGRnZlOFpweStTd3IrR2NEQ0Y0d2d0aXlKd0NN?=
 =?utf-8?B?Ky9hTTUvb1VFekdBeEs4TWwzMWdrSm1pV3F6OFZtVWVhYjJuZnVMU21QdUgr?=
 =?utf-8?B?WU1UZnhWdDFMOEZ3RUZPSHpOZnJpU0pnRkg1SUxZa3Jha0FOVDJ4U204NjIw?=
 =?utf-8?B?dVZvb3ZYZWtGUGM4a3lzd0lsUURwNi9WVERvemZ2akgxdFEySE45V2lNTmZG?=
 =?utf-8?B?VHNnNWZUd3luNGdUU09lRG12dFdhOG9DRFhnZnpOWDZuc1QxWHgyU0lHWkZS?=
 =?utf-8?B?V3NUdmhxek5qWEVNVzdaZ0hDSjdyM0d5SzZ4SzVGU2VrdDlRaXhrVVhhdjlI?=
 =?utf-8?B?OUVFN01sdy9LQ2xFdVN4d2w1TWxHcFdUMkp1dmdyMkh0WEU2RTF4TS9oZ3FH?=
 =?utf-8?B?anZpbFUrMlV3czdjWWszU05Pc000blB0UWxSa0ZKMWpGcno3a0VBcEgveFBu?=
 =?utf-8?B?ZlNFVnd4U0ZqTlNHa1U0V3ZyTmd1emxBc3FFajhKRWNBMjlrZ0tOMk9CTndy?=
 =?utf-8?B?RXMzbWJPYWs4T2plOEtnMmcxczJITXdMOGo5eDF2MCtpTG5Ic3FyK1JJS2Yr?=
 =?utf-8?B?ZFh5YXNmVnd5WHN2ck1kWUFveDNEMHNwOTZZc0dXUGNOVm5scE9ZWGhYMDdv?=
 =?utf-8?B?NDNxSEMwZkFZMFJTOFNMeFBEL0Z1NFpXVjNoVUwzbDJzMURhdWNtRXdkMTF6?=
 =?utf-8?B?REJQbXl5UFcyWGVoZ1ZSNXphc1RYM1lLQ1hlSWVPWEtua0FHVlp6RUlobTVQ?=
 =?utf-8?B?VTVDWFdiQWtOWHR1L1poYy9QQU84OVg4aEI1QkI5WENpcG1xaEpJU0FUSEpk?=
 =?utf-8?B?dmtwQ09zbDhBRzY1cEpOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1UdktTQUxhWkdZRkFoVlBqck1FQTZGUExiak1ucCtyQTZoYlZ0a1d1UkVN?=
 =?utf-8?B?YldPTmtFU083eDJ4Tk9BbjAzcHhhdmJZc2RMNnlUeTNzUVhWZDdMSjNlWmhG?=
 =?utf-8?B?dmlRTEhKUWp3U3hwZktMR1RQZzlYVk82MnliRXU4WVVZVnlzT0VDbEYwcGdh?=
 =?utf-8?B?NUZCYVU5MDlDU3ZoMS8wWVBsVjJ6SzFRK0N5WFE5TmxJOW1waDJORDZMYytC?=
 =?utf-8?B?OGZmVGJQSEF6MFFvQkxzNGdub1NEbHh1aU1QZnFOK2huTnQwa0xsUDBaL3oz?=
 =?utf-8?B?OUJhK3lYSVJ6MlFaajh2WUNyZXF6TUlhUStQdjNBSWtSdWUzUFdXekRPQ0dh?=
 =?utf-8?B?aERnazB1ZmdTblhyd2lZUXVEa0lkclBzbkk2VXZmODlCb0dwZ3ZySGc0M3Qw?=
 =?utf-8?B?RXRnRDBPOVhNcnFraXZiNm1KdGIxTTdvU1lsS1pUVlRMVGYzdFlvNkhKTjc2?=
 =?utf-8?B?bnN5bmFiTnFIQm5LMDZQRVh2SXVqWVJzVGNjc0Rkakd6YUpDZ1UrQVhnRXp3?=
 =?utf-8?B?Y2FQcnBHb1kvTHNJd3ROZ1Q5TEYvQk1UMml0d214dHZoL21xYzlKQzFLcGpH?=
 =?utf-8?B?V2pDaGZmQzJGdk9EMGxPQm9RUzRTbUtCaXFiMUZXUlhoVXRTcVFwc1Qzcis5?=
 =?utf-8?B?d0x6NldmWUwyR3A0ZVFOOWRHUjZuZ1ZrcTNFMkVHK09UUGJDM3htekZWKzd6?=
 =?utf-8?B?SEw1NEZ5Q2REdWR3b21Pems1RnFUV3U3T21rRXZtcW4yRitGMThLeUFraVJu?=
 =?utf-8?B?R0hHYjNzZ2ZHb1ZLbytycVRjU2llRG9wOUpQMGpNbHFkblE2WlN2S3UybStl?=
 =?utf-8?B?MjNOekxzbXBtTnZkanI3ellwbWlsZmJvbWVBdTJ5aU9HSXg2V2dtVjZFblpn?=
 =?utf-8?B?ZEd6bVR1RUwwcjNWQmVyeStnUTNQZ281d1hOMzlFb09ib2ltby9BZStldUVo?=
 =?utf-8?B?SXVzTkZaSzlGQ0gzSG5rZjh3cFR1cDIwRmU5U1JlUTFQWlNCK0ZjcTZoelNT?=
 =?utf-8?B?d3F4R2g0cVVCTHZ6NllLYWdmS1Bqc1cxKzVkWXhVSnNHaEI4WmN4Wk1Yd2lG?=
 =?utf-8?B?MG9QNzhCdDZlU21HK21rKzJSMzV1TWJCR1g0TU9iOW1FN0YrSElXeDVtZXVD?=
 =?utf-8?B?SU1wOWlCUytQR09qWlFSUmJzWXU4Q2tCajFKdlE5dUowakZDUk5VOFhVWGht?=
 =?utf-8?B?emxxSko2aU1wSW82cS8xMjJadFR1azN4Q1hOWnFYU1B1NlZFMW1WcWY0Zi9D?=
 =?utf-8?B?Mk4vb1pWOU9MMjRFQmc4MjgzOUNLTTQ3dTV0MkcweXBzNUo1bEVlamNTc0dK?=
 =?utf-8?B?V25aMVlwTld5VXhUemd3bTVqY1JRSThFelh3Q2o3ajFlNWtZclVpSE1GSUVZ?=
 =?utf-8?B?M3IwQjlFYU9KNTNmTE1xWTdCVnRoZlEvSk5PVVpQUmZkUEM1MmN1cDE4U3RD?=
 =?utf-8?B?QWxOVnBZRllVaUxYS0Y5TWJEb3RmR1FUWlNnQW5TRUFldFN2MnZmUnN1aDJW?=
 =?utf-8?B?RmZMdXBha2hhbW9ZWHh2bDQray9PTTAxTkdSb2Jvb3NPZkthR0IvQ1BFNEtN?=
 =?utf-8?B?V0drN2FwRnozQVdXK2p5NTFZdlVVWmtrQXVYQnFRSW5KTnExakdOTzVyWlBX?=
 =?utf-8?B?UUVKc2VjMG1lYUxlTWZKREZSNWp0S05oR2NhcmpZR0NEeXI0ZmNjd2c0RkJL?=
 =?utf-8?B?S3pBc240NDBpcmJHY05oODQ1eWNZcWVDd1RCcTltK1Rnd01halZ1dVlENW1C?=
 =?utf-8?B?a3JBNjd1cFlmUGsrWEU1bE56UjRCb0xzWk9jYWZNWmFlamowV0FRekZBblFj?=
 =?utf-8?B?QmFTeVFpcEVyNnExemszQTVFUW9IcWRLbTgrSXdLQnNNeGZJLytlcE00d2V4?=
 =?utf-8?B?TjlhWHZVMHlVWGpNNnVrZ2tCWWlIOHI3d09zOTgrbExlQ0VLSm5odW1zNmFK?=
 =?utf-8?B?bnJIa21PTFB3aEwyZGY1L1ZuYitwQW1NYXpVWWZHSmRsNVEyT2dOQlpoR1g3?=
 =?utf-8?B?b1Vzd0RGWkNvUWZiVU54UnZjYnZIWlYzMlZBVkxqbG5DdWh4TUdxcTJROGRp?=
 =?utf-8?B?c2Vxa20yWG9KRDNTbStlR0xreHRZaU9XL2djdlpsNXBqdmxxZWFJUVBZTjdu?=
 =?utf-8?B?aVYyQ2E1WElKMitFVjBmYzMvb1duRGFocHl1UlBDRVdrNk93VVRWcXpPR3RQ?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18305fa2-a1d2-4389-1057-08dc97916583
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:43:10.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MjF2F58ZFPU/rXZSn8v49sIchDxHNfw/y4BhlMOMdNgiRk5vX5/71xvYm978Usynh3nngCnNEjlUYKN8CFDlH7hIWjQ+7oEVjKNPQ5no/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 7:59 AM, James Morse wrote:
> resctrl has three types of control, these emerge from the way the
> architecture initialises a number of properties in struct rdt_resource.
> 
> A group of these properties need to be set the same on all architectures,
> it would be better to specify the format the schema entry should use, and
> allow resctrl to generate all the other properties it needs. This avoids
> architectures having divergant behaviour here.

divergant -> divergent ?

> 
> Add a schema format enum, and as a first use, replace the fflags member
> of struct rdt_resource.
> 
> The MBA schema has a different format between AMD and Intel systems.
> The schema_fmt property is changed by __rdt_get_mem_config_amd() to
> enable the MBPS format.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e3edc41882dc..b12307d465bc 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2162,6 +2162,19 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>   	return ret;
>   }
>   
> +static u32 fflags_from_resource(struct rdt_resource *r)
> +{
> +	switch (r->schema_fmt) {
> +	case RESCTRL_SCHEMA_BITMAP:
> +		return RFTYPE_RES_CACHE;
> +	case RESCTRL_SCHEMA_PERCENTAGE:
> +	case RESCTRL_SCHEMA_MBPS:
> +		return RFTYPE_RES_MB;
> +	}
> +
> +	return WARN_ON_ONCE(1);
> +}
> +

The fflags returned specifies which files will be associated with the resource
in the "info" directory. Basing this on a property of the schema does not look
right to me. I understand that many of the info files relate to, for example,
information related to the bitmap used by the cache, but that is not the same for
info files related to the MBA resource (all info files related to MBA resource
are not about the schema property format).

I do not think the type of values of a schema should dictate which files
appear in the info directory. Doesn't MPAM support percentage for cache resources
and bitmaps for memory resources?

Can the fflags rather depend on the resource type itself, by using the rid?

>   static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>   {
>   	struct resctrl_schema *s;
> @@ -2182,14 +2195,14 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>   	/* loop over enabled controls, these are all alloc_capable */
>   	list_for_each_entry(s, &resctrl_schema_all, list) {
>   		r = s->res;
> -		fflags = r->fflags | RFTYPE_CTRL_INFO;
> +		fflags =  fflags_from_resource(r) | RFTYPE_CTRL_INFO;

(please watch for extra spaces)

>   		ret = rdtgroup_mkdir_info_resdir(s, s->name, fflags);
>   		if (ret)
>   			goto out_destroy;
>   	}
>   
>   	for_each_mon_capable_rdt_resource(r) {
> -		fflags = r->fflags | RFTYPE_MON_INFO;
> +		fflags =  fflags_from_resource(r) | RFTYPE_MON_INFO;

(please watch for extra spaces)

Reinette

