Return-Path: <linux-kernel+bounces-368577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F719A1196
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2406C281AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3220F5C9;
	Wed, 16 Oct 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0zMMukq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FE1494CC;
	Wed, 16 Oct 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103494; cv=fail; b=Zp2dydxCbI+Tsmi9M4cT+CgobLyqXt7mb9uUgzvLkjA83jy9bF0XFM3Zw4TntXTQyvduq9G/8cnuOJkVVIPYvrEcHilKex74Hmz3qgHupwmGE6chFkTc2bOSo9E5gBTVmuwIz59sZd2647V5tkY4uP5r/SRHbSdmMFQ7XQF8HsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103494; c=relaxed/simple;
	bh=yFdJmW++vRCi/8Kbmgg/FOIckW/0gC6TEMd2VwI12Uw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HNYLEgDaTZ7nGSOXkdFusn9ROREXPoJd/WHH4w/5u7JA34RJ3aWQntbAG0e4wCZ3kC2ubhShsoFDWwMLyOJ+ssF3HIgtDJK8COvLpKlwCH1YLR5JZB6sCNSvgAR/gOXA4oPxEAyxBShKBU/bQRqKKmsIOK1KgsRpPhJLoyIperA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0zMMukq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729103492; x=1760639492;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFdJmW++vRCi/8Kbmgg/FOIckW/0gC6TEMd2VwI12Uw=;
  b=f0zMMukqTe+H7btF6Q5P8+hF/6u+Ewe7ZT6JqjOTyBYkmQWJFbn6AIRT
   ShNRGEmL1y5ZFEuqXuf2xmYXL4O6IFRTWiydXdWQBSoFyL49z1enQROuF
   WcalYJLcSL5Kop7nogHZwWpWQu/aZRgffHND/9KH5d6GnlPlELSgp4Udi
   pCWYZXEYzlkCMV/DAQua0qffYNIz4gQz+ddiYXGqV6TNIQdtypnrTGIDj
   Cgkrcdi2hsNYrP3LWl9fMLVNPAjfVJOsAWXEml68GKtuHZiZ28z3mq7da
   GTnuTXBa8g+ZO68DyGe+F/1S7X1xr3+QvuBehCHsPN3TjvvwlXmQ4dqHf
   Q==;
X-CSE-ConnectionGUID: 2owj6A/3QcaoMxPuGGY9Sg==
X-CSE-MsgGUID: at7/0fuPTx6iOjuJS2PTCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28768899"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28768899"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:31:31 -0700
X-CSE-ConnectionGUID: T4mZlQ4XS8uLpP3eoc0rMQ==
X-CSE-MsgGUID: 1jfIQNZFQDOZ4zgxxecMTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83138489"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 11:31:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 11:31:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 11:31:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 11:31:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrZfK17Y8LGLn/sq4ZLR3H0rq6bpw6YezntVujqMq6nEyCjHVIid+bD6OLjaZYCyNvtv3gY+pgxVYku5/RT82f7bwNx6vWSkSK12/aK0eHSbSktBWxyEtarFNcXiTr3XOctUeElQomDM8rYj0v5c6BijDD07GHhmZ1s0hphtw4kJacQvdY2kqRRBYiXVE3VsO9dCSyDeYpYV26zsB2oAIv5xkba19q8qF28eRl1y7SRTJu0NBsNqf3P3YN2HSPXAFAXesGnzLzkqbzOv5RDa3KSdFp4kUyH+rM6WWGv/SXmAHcacUCQWlXPGmUai0L3/iKvAomZEYTGVNfr9Mkwt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vy+9oNoHaA0JZUi7QmB3/0EcTLcOo6iJyYrTkUK/iE=;
 b=UfApqudjd/Ja5PZAJZ67xfwPbA+vGxxzGGBp2sUb1B3ydtrThdDz8aQVIu8roKMjxRM3wfZ6Z1IqC8Chex7z7t5TgCjxWGIHw/S686sJmhzEurmqYutMhs+qfABSEAnHTTMDPb7+1zNsxWMwX8bOoDHKpCDrEyiNQbTRuPftabiW3OK58aIrzwxFHktMLyHq2TxEymt+2aeAW9RCx2d8Jgu0HVGDwBF3AvO8Usikakur3EZRhy8HTQMtRWlmZknDR2oGXyxWLkOSxI421P7vsTw0m2I/0Q1ZAf3TmVgKHUP23IaMsd0mLKjUdZT1WtyFZ6EjBx/+56leRPt7We/1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 18:31:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 18:31:26 +0000
Message-ID: <52990a2f-aedc-4d36-b02f-45d4de496997@intel.com>
Date: Wed, 16 Oct 2024 11:31:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <alexandre.chartre@oracle.com>, <perry.yuan@amd.com>,
	<tan.shaopeng@fujitsu.com>, <james.morse@arm.com>, <tony.luck@intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>
References: <cover.1723824984.git.babu.moger@amd.com>
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
 <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
 <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
 <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
 <bf67bc4e-9cf8-4cac-9ffb-2d4f81ab7e30@amd.com>
 <ca29046a-29db-4bb0-815a-c482385194c7@intel.com>
 <08dbb3e1-ab5c-41e1-978c-9c8885ffbe20@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <08dbb3e1-ab5c-41e1-978c-9c8885ffbe20@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:303:87::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH8PR11MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0add8faf-69ec-4691-4d24-08dcee10be70
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ditzVHR2SmJHS1dvNGhEbFBjL2tFMTkrVnlpN0ZFcXNhbHR5SlNQUm16dTM0?=
 =?utf-8?B?cEl6SXFzd2tYOThhdHZSRTdPeGFmeFZlZHhoR1NObklUWHBUQzY4cGRLcmZ2?=
 =?utf-8?B?UVZOWHZGMjZLTDhmNjNKZ0pDZHJNUGhMdUp3QkdSTlF6TU9tdGxCUjJMOEdK?=
 =?utf-8?B?ajBBN05zWXB2OHYwOG1UWHZ1UUlMbmVDamxNTGV0ZXZMVWt5MGVxWndyTmdJ?=
 =?utf-8?B?NGkybll3clNCK0pLT3FFUFJJM2hpVnlhZm9JTHZUdnVCM2xFSUZLQTdLQjFQ?=
 =?utf-8?B?NmdBNE1XMklISUVqcnh4TnlPdUZMeUtUWnA0RkxqWlQzYUVDNXpwNHFtOS8w?=
 =?utf-8?B?OEt4TUoweHh2aitxZ0dsS3dXRmY2bks2NWtmZU1SYUlwVWNyTGNTdWt1VDlL?=
 =?utf-8?B?c1pZc25sdHREVEtja0lhcUovTnYxbytVc1o0a280bzVLQlpQWnRoVm1COCs2?=
 =?utf-8?B?dFYrdGRqNFVUMzg0TDBBQUFBeEdvYU9GS0R1eFVEMHVBUXl0bTh4Y2xMUytS?=
 =?utf-8?B?eEJJdTNUVnVSY0drakYrMVJqRVd5aG9idnBXYWNnWnZIbDVSQzhQRSt4R3dx?=
 =?utf-8?B?enpTN0N4Tnp2RXZjVU1PYUVYajJwSWxHais1THhYU0VXSEkxcDZ5N1ZUYWNZ?=
 =?utf-8?B?cEp3LzU4cDhOVVN0cnRFa1hUU29PRjQ5YzU1cm5GVzVwTG9UMm1kS093UlFJ?=
 =?utf-8?B?V3dua1RoQTh4cTZrQlhEWDZzeW50MUkyWUtXeldrK1ovdDhrMjhQQjNHc1hn?=
 =?utf-8?B?OGpJSEhkT1ZjbkZlWHlxNUNSTkNkYTlSUFlJK0owUEJjbktFZWRNYTJOUXcw?=
 =?utf-8?B?MXZ1ME1ERnpaVE1hNDhuaWFiczNlMTl5SWxwZmRsZm5sMnhQdkxNU1JOUnRL?=
 =?utf-8?B?ZzBkLzArR094bzFkM05rdE1IZzBYZi84SnpCTTFDcktGUlpWdWtOZzk3K0Nj?=
 =?utf-8?B?cnlZMnIxMmpkTURUN2xCSWVRelp0aFJtZlhFT3hRQldUV0JZMXV2SHlpVk8z?=
 =?utf-8?B?YjFNampJR2tBdHVTalVoaDhLSzhWdFNkLy94NDNoMnNzSHY2L0JYYkZ6Vkkv?=
 =?utf-8?B?QWRpd01aTzRjNGNvNG5BU1dKY2dpQjJMSGwrRnVtUjlSVTVIbTJEU1hNVWEv?=
 =?utf-8?B?SmgzUk5LMjJLSEVpRjcvR25xK3NLclQzaXZESnBndUxCS0VDcEpRZ1F5NGdp?=
 =?utf-8?B?VE0zYjBFbnZFbDFTUWR3TVVQczNjOTE4aFFnYzhjRHY4WU8rOGFwOVNxVStX?=
 =?utf-8?B?RUllcVhRRWxHZkp6RzQ2U3dnSTBJN1dYekJVVWpMcVgvdllNbVR2eGxnMkVi?=
 =?utf-8?B?RTdzMy8vOTdoVDFWM3lzNzBnOWxFakJYTytMQnY5MUU4R3NvbkZiN2NDWXdy?=
 =?utf-8?B?VmJMU1FjOXRRVE5ERkxyeUc3TDBJNmZ1aldHUkJ1cStPYjZkNlIxWUQzSmZ2?=
 =?utf-8?B?ZFRFbXpNczIySlZ0UkhVSjlwa0haNmNqbXM5RFVNRTBaclZtRUYzVG11SUw4?=
 =?utf-8?B?R3p2dVgyT25JWDFpeXR1amFBakxPLzg5T0k2RWQ4L1RGUzBKdDNGVWllN21M?=
 =?utf-8?B?cGtMbnFjdHZYeXZEbTZuVHlhTng4SnNJWno3UUg5cEM1VXVaanpSdmZZbXJD?=
 =?utf-8?B?RzI4UnJkRThnZm1vbWpFR1FoZHgzK2cxNXdjRlBwUS9QT3NKYnRuWjdnb3Bw?=
 =?utf-8?B?Y2NCL05FZFgxUlRWbEEveGdHZWQxbkRHbVBTb2pWNlB5cEZXOEtUWE13PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJKSUVQTUxtSDFpa0ozR3o4UHJ0OGpETk4wNVBWU1JHT0dTU25hdVZXdW9o?=
 =?utf-8?B?cFNHNlJpajd4K3RBUHd2cHU2Y1Rxc0hLaHFVei8wVUNvcnY1K25VaXNvTFVh?=
 =?utf-8?B?Yld1R2Y4V0I4K0VOdHViK09kQ2RmcGdHOXoveVQrNkc4a3IzMmdJUTkrL0xS?=
 =?utf-8?B?V0tMUlRFNjg0RjU1ZzBqOHF1QXVjYlJMTUJnYU9BZDdDR1NqN2luZDJITk01?=
 =?utf-8?B?T0NtdVMzdWtMdEZuMTMzZ0lrdU9NU0RyRWhwb0FzOStsN244bG5vd2NTeHA4?=
 =?utf-8?B?bkJEWklvb1JGREEyZitzYWdsVjZLTkFvd0gwMERkWXp4c2dtQVFFNEEyNW5G?=
 =?utf-8?B?UTJwbGU3OXplWjlYUnEzRWdUMlBCQ1RxVkhFc0FabWdJNEFEOGZYMitzK1FD?=
 =?utf-8?B?RHZNclRSZEx4aE5WTkFwYU1yY0Q5cTduYklzZE5XZjBiUDB5b1hhZDlqYXV4?=
 =?utf-8?B?dU90ellqbXltZ05mMXN2My9mNk5DTTFsTTVOd3R1OU12OFRVeTUzUTNrYUxH?=
 =?utf-8?B?Q2diK3NSWHFuK2FRb080aTJETHo4cWZyRktwWVo5cFF0L0grVXZndGNzeW9j?=
 =?utf-8?B?VTNnZnF6b1ljSXFzMmdnbTVYbmdVLzJ2cmlvSTBPcWFUMG9nSEhyMllTZHVZ?=
 =?utf-8?B?ZDEreTBDTENzTFRobnJiU041b3l4RWMyTE42SWp4eFR1b2ZrS3k2N1ZsYzBW?=
 =?utf-8?B?aURIWGVvOEZvY3JGbjI0V2thVVdwMjlOTXNWaHFjZndrYllscm9iOUxlR3dG?=
 =?utf-8?B?enRxZnFnNUdKWEhtekx1ZXdTZ2VZZ0lCTGo1d0RjaHY5WC9rZFdaQ2VMNmI1?=
 =?utf-8?B?T0FaRElOZElaYUlGUGpMbjlSOXl2SGhvbUV4TTZtOHJpNFJvRXE1dklRV3lv?=
 =?utf-8?B?MTVsZUtTc1BhbUJRNzBPcEtOdE1qcFRkZGxTT09hM2h1eWhKZXVDVXBpU1pz?=
 =?utf-8?B?SlBjQWFvUUR1VnU5eDBrbUFOWlFWdkE5K1FKQXNHMkNmZE1uWG5PQmoyNFAr?=
 =?utf-8?B?d0g0QVg0N09wV0xsTGlnQnZkNHRNYnFucHZoUTZiVVBpRVVIakc4OHhuZ0Q5?=
 =?utf-8?B?YU9lUEtDaTJRODlQTlJvWVM0T3JxUStJTjBGL1J6UEhYUERnVVV5aWF6RVIy?=
 =?utf-8?B?b2ZHcUFWWUs0WmluNHBGQnl5WlZxM2RQZXFpbVpIYWcvTEV1cm41RlYrckdz?=
 =?utf-8?B?eWpIODI2NDRkRVpMV2ovRFR0aGRHaHhUcm9KOVVHTW1wb0tkd0t3bUZiRGFu?=
 =?utf-8?B?Q2RGeHFKajR0cHM3cStEVnc5M01UeUkwalEzbWVRVWFqVEIyQjUyT0xDeXpi?=
 =?utf-8?B?N2dkUGZkSTh1dHdiU2pBUEdyUkFTMFA5MXZsb2FWMGV3bGFiUmEzUFV3SE1K?=
 =?utf-8?B?cmExQTBHTzBxZDZpbkMza09PVW5oMjBjMEpVRWN0b1BvZ2s5bGlsQ0dmcXZB?=
 =?utf-8?B?MTBPNUpQN3VXV3FHYjBtSUtRTyt6MmZMblRxU0laUDN6QzVHSFJ4NU5xRXJZ?=
 =?utf-8?B?R3FPait4THZGMUlNc0FmVWF1SDFvSTBaaDA0WlR2SEdTR1RuSDFkY2toUEdo?=
 =?utf-8?B?M0FEaWs0ZkdWK2hId2ZjVnpQQnkzOXZrSEtQR3RMeFBPMXVFb2ZrM1RmWU1V?=
 =?utf-8?B?Q0RZWkdjSEpVcnBVSVFFbXhyTkVaeWVOQVFGVnJDci9HQjJjeTRoTVlwRExm?=
 =?utf-8?B?UVJ2bjhmeklRMldQalMrbmhiS0FBVjZZMStFZUxmVDJQOUxDMnBEcC9WZk1i?=
 =?utf-8?B?TEFSdDVQZ2hlby85QWhNNFFURjhZck1kbERSRTNVd0VyZXhrRXVxWUdZQ0o5?=
 =?utf-8?B?OU9tZGZ1SkVLMkhXUmJYalVYMVBPK1o0TTAveGN1cG1LNHVack1tTDFmbzN2?=
 =?utf-8?B?YjlMaDNhVGY3WkVzYXpBRXhac093UEZNTEljN0xsdWFvc3JzbmozTVpxL29Q?=
 =?utf-8?B?Y0VVR3RHUWRoVENCY0pzS1d3UWdtM0dFUHRvSnpKODdxWm9ONVFkTVhCYmFI?=
 =?utf-8?B?eENibkI4SFhndkw5SDhaLzAvTWhoLzRzdzZ4bEVUenc1U2pLSjQ5eVRvU1NX?=
 =?utf-8?B?c0xrZWZycVM1TGtaSGVVbFkxTmkvMGd5aWZETFYxSzJ5VVpyaGdjSXFLRFo3?=
 =?utf-8?B?M1BKaUhSRDFpWjI1ZWtIb3Y5K0Zqd0ZlSERlL0gyMGd5QUhobTFwZXJka3lW?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add8faf-69ec-4691-4d24-08dcee10be70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 18:31:26.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFHx1MLMFJIISgf37mAirtBUsP1Gkij6MgwIyaAQJqTEIe2hopsPdhqGd5ps2ofzBodAC1Hn60HNT77VSLlGSX2iSvfvjFXjD4JmEdWPb+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7141
X-OriginatorOrg: intel.com

Hi Babu,

On 10/16/24 9:46 AM, Moger, Babu wrote:
> On 10/16/24 10:54, Reinette Chatre wrote:
>> On 10/15/24 1:40 PM, Moger, Babu wrote:
>>> On 9/19/24 10:33, Reinette Chatre wrote:
>>>> On 9/18/24 11:22 AM, Moger, Babu wrote:
>>>>> On 9/18/24 10:27, Moger, Babu wrote:
>>>>>> On 9/13/24 15:45, Reinette Chatre wrote:
>>>>>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>>>>>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
>>>>>>>
>>>>>>> (stray ` char)
>>>>>>
>>>>>> Sure.
>>>>>>
>>>>>>>
>>>>>>>> feature and initialize sdciae_capable.
>>>>>>>
>>>>>>> (This is a repeat of the discussion we had surrounding the ABMC feature.)
>>>>>>>
>>>>>>> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
>>>>>>> becomes a resctrl fs feature. Any other architecture that has a "similar
>>>>>>> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
>>>>>>> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
>>>>>>> needs something generic that could later be built on (if needed) by other
>>>>>>> architectures.
>>>>>>
>>>>>> How about "cache_inject_capable" ?
>>>>>>
>>>>>> This seems generic. I will change the description also.
>>>>>>
>>>>>
>>>>> Basically, this feature reserves specific CLOS for SDCI cache.
>>>>>
>>>>> We can also name "clos_reserve_capable".
>>>>
>>>> Naming is always complicated. I think we should try to stay away from
>>>> "clos" in a generic name since that creates problem when trying to
>>>> apply it to Arm and is very specific to how AMD implements this
>>>> feature. "cache_inject_capable" does sound much better to me ...
>>>> it also looks like this may be more appropriate as a property
>>>> of struct resctrl_cache?
>>>
>>> Coming back to this again, I feel 'cache_inject_capable' is kind of very
>>> generic. Cache injection term is used very generically everywhere.
>>>
>>> Does  'cache_reserve_capable" sound good ?  This is inside the resctrl
>>> subsystem. We know what it is referring to.
>>>
>>
>> Since this is inside resctrl "cache_reserve_capable" sounds like existing
>> CAT to me. Could it help if the term "io" appears in the name? Something like
>> "io_reserve_capable"? When this is a member of struct resctrl_cache it should
>> be implicit that it refers to the cache.
> 
> Yea. Naming is difficult.
> 
> How about "io_alloc_capable"?
> 

Sounds good to me, thank you.

Reinette

