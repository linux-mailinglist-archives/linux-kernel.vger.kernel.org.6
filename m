Return-Path: <linux-kernel+bounces-292972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C895774A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C32E282A12
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95B1CF83;
	Mon, 19 Aug 2024 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU6bWgRA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6E175D46
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724105785; cv=fail; b=N3gFZOulRAVV0ZBN0sV8g1ALpczwS+KkGvdvv6EMXePL4vN75A2IoQtGsRdk+ACKs4GKIwGwX8kbwg6ZuygzE5av0MP2kHaeJG6+FssiOytqtLPOaQCKrbM7g0iS4oOwrW/4KfLau+3WMrFi60oaf3Mtv+uPJ3EnjoM0rBRfD6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724105785; c=relaxed/simple;
	bh=KMWn9yO0WXb2IGs6gLkxWlNJxf/Mv7TuMCOOdWE6kDw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SYGis7jiR924q7xWs3aEjsq4vrRufXZjeqfCJiL0HGOiHoT/VVtnDn0JboJ3oAyOIel/cOgHB7zEVcKLhU3OoMDNiYdKc5ObXOPxHQ3xg0WA7Iy0h++zrpuKHd338us/X2xqHZjEcXlK857lwpXmX6NlF/WEUhGvALVF7H7gIZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU6bWgRA; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724105784; x=1755641784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KMWn9yO0WXb2IGs6gLkxWlNJxf/Mv7TuMCOOdWE6kDw=;
  b=nU6bWgRA9JCcxV/IxM0sFvew+LjI8YrmUThgXN4IDkHX5w+TWTPSk+3F
   kQLDE2C2NzGFrX4hVDSBMbTSC0ahO13eXd0e9ibYrOukRsW2sHAaK/UNn
   snu3l6e3YWIqnZDztUNhbaGeRcoEbfLDWdaUER2f6R8OPG8sWkhhx/fdG
   tHEmZHAwLcjwsH5CQWa7joxzXmhyhaZCRiIt7WMytTx95J4b3++LweJYj
   0IZdZ1Lclx0mGfxo82643pHJQ152oxnugTq/xlg0FsD0v81HzQ7SdG/O5
   pKIC5dw1L5ItMm4f0Oa1fqGyb6IPWd6LzmDyJGWtsiUcsRar1wBIi69Dt
   w==;
X-CSE-ConnectionGUID: wdBD5IOnSY2KX8du+jIaHg==
X-CSE-MsgGUID: 8PSn31y9Rj6B90eh24s+Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22539732"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22539732"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:16:23 -0700
X-CSE-ConnectionGUID: 1BUU6GxZR+m9Kw7wNcvh/A==
X-CSE-MsgGUID: CDtjz8rkScmoejique6afA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="64901698"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 15:16:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 15:16:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 15:16:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 15:16:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 15:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz8rzE2dcckyMg488qGRGEwdcXuJZxD62aUUIdzoUfbUGhk6IYQh/XRQhcJE+vNvUbTyrdT/O7oeXR2y1ugoHfp1hgW6r3MI0uGRdaQ+x3HrTuLITdXK+/yySzE1aCStxTtx5KwRfzBdL5+jcVkkmzzXsf+GaIG0Vk4qhz8wj2SERL4AAhiAIzavjJ51Khx1NHoNCkMD5MKdqWbPexMruIsPhkk/1UKhtIFrmcYJf1l18L+wVBFKfHjCwbFnzDwZfopXkBU+O+j71rSF7CBuSeC3UUixvAySbdBNajkClT3pXYtpCR8bm7rRtUx2DtLEtAEAmOjdx2vvZrVbytMK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP2FuSiIiNvce0aaC4mfaZNxkAp2rbWECE3uLNkmbOw=;
 b=wxkAa1pT4oJdbfGuWhtIJNKxermF+6XATAlGPHvmSD1+/SkdTW7nQiu5MC3plQAJ20BvMleo6O6mL5mi2H0UoDax+A5IXNMITikZhdpGP7c6rBjetOxqTttY2/XsW6Q+SVjc4f0jMMHBVPDseZ3pmdNABonuTEsmwmhJhZpvQKvhKqL+0Gnr7kJ7ArHFmI5P0Q44p8cDvHE4Vf14iFkpkIbPgsSm3cnNvJvJYbg4PS5Rs+ZiBr5JFVu8dbEomYfdsDTvSMtpF0QqkhqmD0kKmv/20qRDyGgmCWTbZc94To30As2QSEns0qS0dlebRRwRchjcbMb0iiEPKE1zGRlYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 22:16:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 22:16:19 +0000
Message-ID: <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com>
Date: Tue, 20 Aug 2024 10:16:10 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] TDX host: kexec() support
To: Sagi Shahar <sagis@google.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <hpa@zytor.com>,
	<kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <pbonzini@redhat.com>,
	<peterz@infradead.org>, <seanjc@google.com>, <tglx@linutronix.de>,
	<thomas.lendacky@amd.com>, <x86@kernel.org>
References: <cover.1723723470.git.kai.huang@intel.com>
 <20240819212156.166703-1-sagis@google.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240819212156.166703-1-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0193.namprd05.prod.outlook.com
 (2603:10b6:a03:330::18) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f36b9c-71a2-42db-a49f-08dcc09c8cde
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDIxU3ZYcUFaQkY2YXNQV0xlcnVadzFnODlYNFFvNXRGbmY1a0o1dTY4RlM2?=
 =?utf-8?B?dk8vbkdmRVNJc3YwRStvZk5QejFMVUluN1JHWkVaUE9wWFQ0TGVTYitqOThp?=
 =?utf-8?B?bHJLc3NTRGNXYnh5YkRHdHp1N0NGWTZoZjF0RVdPaVk1RFJ5NWlnOC92Y256?=
 =?utf-8?B?VytDRkNZeHhTSDM3QmVsZVJsb1VJbm5EcnlKNVRGV2liRDBhRTNmb2kwdUh0?=
 =?utf-8?B?dnFWS2k3c1dSUkdqLy9PS09OeG45VTBGd3d3L3BIOWlsNmJVR3hiRzZ3VEdU?=
 =?utf-8?B?Yk5qc09JcFFJMU51enJXVjI3anBYMEwvaDY1M2hDNWkvS2tCTjEwSTdVN2xs?=
 =?utf-8?B?cGdVYVVKYkRBNFVpME41bmhwN1ZCZTA5RUtjVE5nQ1FkWWNNNm96YVFEazVH?=
 =?utf-8?B?NjVzdUgxL2J2UmlheW1pZUpsdUlHTWJqSEhnRk9HZEQvOEcxSkhGSWg1TWtF?=
 =?utf-8?B?RUJUTlE1d1BBS2FtSngvdGZLaWZmVjhwV2hjZzRWWkVJSk9GN1dNSm9jUDZt?=
 =?utf-8?B?QktTZjVPVThlb1Q2Mlg5M1k0b0k5dFF6K2lrbWYrWi80WGxnQWdkcmdYZEM0?=
 =?utf-8?B?aUt0VCttbUlONHpxb2c5TTN6dEQzZUprblY4aTBmaHdROExwZFpKVERHbXNk?=
 =?utf-8?B?QURIWkNNdmJXZmcxSmFTY1hFNkw5V0pJVUJFM0xFR29ub0ZMR0Z5Q3pLanlo?=
 =?utf-8?B?UFArMUw2d2hPaFlpUThwa1NRSzlUamFvUUhScDNubmtiNWx4RGVlVHpoY20v?=
 =?utf-8?B?cGdNOFRRRkdYQzRZUS9ZRlkrUUNXL2toeWhxREJQeTVjaEgrSmxpckIwNWZs?=
 =?utf-8?B?dVNOWEVUWjdGMEJaOUtpbzdxclhzeFh2NnZ1Nm9SanlER3VSNi83aUV4ZGY5?=
 =?utf-8?B?cndDRGxuVGFOMUwrbGFwM2FKZzcyL3ZweGZBWmlSdnJrcVlCU2h4dCtETVk2?=
 =?utf-8?B?YjBwaUFDTmRrVDI3NHpxQjUxSDQyYnVNREFUam1LRUdJL0pINy82V1ArT2FR?=
 =?utf-8?B?TlY3Rit2SGFNUnoxS1NwUi9ibUNLaUxiVlljVWhJbXpTZldQQ0dBRXpXc3Fu?=
 =?utf-8?B?NjJoYnJTZ1ZSZGF5djJtaFdQZ1oydFc5c0w4M21hK1VVRDlGZ3BWZ250M1Ev?=
 =?utf-8?B?bkVkTlo4NXJGTTlZODdudi9mK1lmQXk3RStobVhpcGpraWRuVysvRFV3blJ3?=
 =?utf-8?B?L2pWTmNmOE9mSmMrZHB2ViswMkE5RVZHTDlDS2JrUEVRNk9GTkhwTUxkeXdF?=
 =?utf-8?B?d1BCSjhBd2NpY0RkZzZXcnhtMUg3U0pmUmNpN05nRE9XTGsyemJ3dTVaSS96?=
 =?utf-8?B?RS90QnAzUkd4c0xpQ3lCTFdEbUQxUkd4VDhIYmxoUGVCMzVBUjRwYW91YTd0?=
 =?utf-8?B?UU5USEd0UEJFT1FlbWoyazhBbkxKclM1bDNXOXlYZzVmQU1DYTJpcTVCQTVw?=
 =?utf-8?B?K1FBekJqMmhhNEh4QlNKaXFGODdsSjBUL3phcnV2cjhmd1JaY1o5RmJoTndk?=
 =?utf-8?B?R1RkSGpXUGNuczNrdnR1bTJPeHRCTW5DdDliYnA5Um5Vck4zMEJkTXMwYy8r?=
 =?utf-8?B?SnlXSElHVy9pWjJaOFZzZ2I2ZlUwVUN2UXc2d1hyOGRDVlROK01Jdzl0RjAy?=
 =?utf-8?B?STNkRXJaUjAwVmdYZjJzNWNkaE1UQ1hhNlVrb0EzdEpqQUl0L2R1MUpGOUVQ?=
 =?utf-8?B?NG5pZExudDZML25MYWZIeDVMUzEwY0JpZGJ0TTNkNHUzTCtBZFQ1QWJXLzA1?=
 =?utf-8?B?UUdGaDkvbWJnK2Z5SGFtS0xGQ2hwRUI2NjJuOUlkQVUrQ2FaeDhKdmM5THZ6?=
 =?utf-8?B?UWh4d0MyUzdjbGNld3FIQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxmNEo0bzJWdHJwSG5TNkdDZHFJY2tjOGw1eEZGY0hQT2g3MXZOSjlIVVJT?=
 =?utf-8?B?TkNCbUl2bTd6WTRQQ3F4R2YxWU5BSno3YmpBMFJCc1Y1Y2hjSWpZT3ltZFNK?=
 =?utf-8?B?R2xqV2d3MlBNRmhURTlmZ2ExMTgyZitJNko1OEo3b1hHNkxuTWxGckdBSU5F?=
 =?utf-8?B?b2tDRkJzVkljbTJVampObTVkWCtBcmhsVDVWQzdWbWNKclgzZ3RiUEV0Sk9C?=
 =?utf-8?B?ajl4bWs4N3cvTWNtdTZrcGRKM0hQYkFMU2toOWM1ckV1NXVtdDNmR1V5VHBJ?=
 =?utf-8?B?UjQ5Qkg5THVuSm14ZFQ4c01hTXZwTFQ3YnBiRUFYRkJDdHpHRDhLWjhTOTlT?=
 =?utf-8?B?cXJCdUR4QktaZWx0bE1WSFUrWmkycFFTOW4yMzliZmpoaUVCWnhiYU9IUlNp?=
 =?utf-8?B?bGtKclVMNkY5dnFoUnc4clloM0lRSWwxYXlSdnBTWmFSN2o4UW93TTFMWHhH?=
 =?utf-8?B?c2pIbnVYZVhGWjBSY1l4OUNUSmhHUFliNTdSbGFrMmhMK3Q1NUQzWFgwVjFY?=
 =?utf-8?B?bitYdllFcHMrRU1sbUJxS0tqWE5CRnJkK2xOME5ZbytoODJaR0prYzhYZ0RT?=
 =?utf-8?B?YitMWUlmVENaTUljNHhrRmRwY3gxd1pvYTZCanVXTXVGWEw5R3ZSc0FuWFVU?=
 =?utf-8?B?S2d2aTFva3B6K2dzRTBHNzVmeVJhN2JkMGpVWFJJR0tvU1F6SDcvZnNFZ0RM?=
 =?utf-8?B?K2R6b2ExRHhJRm9ldXZZS21NbVZYS2M5SFVqc1F5Ly9nK0NTNU5reGdIZThy?=
 =?utf-8?B?bmp4R2s3ZjFCYmt4Ui8xU2RIZ082N000SnNFVnYzNWtrZ2Y5aDdldm0wUTdO?=
 =?utf-8?B?UkgwMnJhQ21XUUNGL1lYeC9UeDJ5UEg3b0ttd25aaStWNGZLZUtMdzArcTAr?=
 =?utf-8?B?M1RWZlVBWGV6RG1Td3hvWGwvUlE5VkFOMWdtWmk5cjJwU1RRczRTbWloeGFY?=
 =?utf-8?B?TG5ybkJpMHJaeVJpTERCeFRKK1FpUmFIdGx3V3FwQ0tsZjh2WmRuZkFzUWFw?=
 =?utf-8?B?TFQxdTJRZm1SeDN3cWtaNFIwM2tNeElLbFR4ME42cW01WnMyUzNTSCtnUjBL?=
 =?utf-8?B?d0Y1UWlBRThrdGxMdVdkNHdCWExKV1pweTFHbHhqTFZ6UVNiWDdvcDgxQ1BZ?=
 =?utf-8?B?d3JCUEg5bWlJM0FVeWdxV0N3M1c3Ynd3TVBIRHAwK2t6b3R1eWIrVWN3aG1y?=
 =?utf-8?B?ekE4eS8weVhCRmpSbHU5RThFN1IyYnZ5SGg2VXM0Vno1aWNyb1YySmRFMlh2?=
 =?utf-8?B?RTRkU1d5Ti9sMVZsVkVyQ1ArelFnNmVQVjhrZ0NSeGpGVDVReWY5SEl5MWRt?=
 =?utf-8?B?ZlMzZTUrb01xVnhMNkpaSzluV0xCWHI5WlY0SmJETE16c3VUbDRDL1ZSTDBz?=
 =?utf-8?B?QkpwSldwQXpUUjNleHBtR3ZJOVFqdDNLVGZCNE96bmgvMWNJUGR2TGxHYlht?=
 =?utf-8?B?V01wWFo2V2JyRW9saGwzQkZGcWtrSmd3elNQQW9ZTW9SYXA3ZVNabG41aktU?=
 =?utf-8?B?cjlWRTdaTmliUnZxOFhxczVQaVBLM1BVMllmQVFjVWFIamVaYkhxb1lqNWpC?=
 =?utf-8?B?My9Gb0dNdENWVFE0VTg1NDIrN0dPWldSU2R6am5QUTY2RklJNG00U2x0N2Jy?=
 =?utf-8?B?VnJ0OVN6Y3pZazBUajcrSytFM0pvWDUzeFRzMldXRVZiOUg3UWhrTEdmQU5T?=
 =?utf-8?B?WGZ0UjhNZVVCazF6cmJac0tIaFhSYks4UmVMNXNLMGZFaWE5amxMNTk1dENz?=
 =?utf-8?B?Y3dqY3BtMVV4Q2J3SUhoQi9LRXIvYWtKR2tZZ2EzckJWZTdIT0hJaE1yUFIy?=
 =?utf-8?B?VTB4YVhlcFhQb2g2MmtWNTA0N3NCMHQ1R3hldVdEYVJkVVF1YnBPOFFLdWJo?=
 =?utf-8?B?K25TYzc3Rnh1bVZuUnB6T0dnR2FTQlEzZlQ5OFd4d1IxVDBhbDhTc2JuaGg3?=
 =?utf-8?B?TEpxaWZqZlJUL0cxWHVudFljMXFObUx2bWlaTzRnN3FLNWZ0THJVZlFCZ2pG?=
 =?utf-8?B?VWZFV1R1Y0VRTGtrVlVlUFBDQnJLTXpQOWdLS2R1VU96MFR0NWlzRkNwbEV2?=
 =?utf-8?B?WEVhYTR0czV5K25TaU5JSjVYUUJmeGRnMnVGVnlwZVdGTDlNRm9KSzhIUjhS?=
 =?utf-8?Q?XduUfS2UFQtB6ZGYEge1UMnKM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f36b9c-71a2-42db-a49f-08dcc09c8cde
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 22:16:19.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/SW7ecPzQN1s4xCwJRkq/cdEp/8sP7EkbmjV/cuYOXKFdM0iWFv6qAxre34T+vTGsYIvjM831NZVU2AJp+UDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com



On 20/08/2024 9:21 am, Sagi Shahar wrote:
>> Currently kexec() support and TDX host are muturally exclusive in the
>> Kconfig.  This series adds the TDX host kexec support so that they can
>> work together and can be enabled at the same time in the Kconfig.
> 
> I tried testing the kexec functionality and noticed that the TDX module
> fails initialization on the second kernel so you can't actually kexec
> between 2 kernels that enable TDX. Is that the expected behavior? Are
> there future patches to enable that functionality?
> 

Thanks for testing!

Yes this is the expected behaviour.  If the first kernel has enabled 
TDX, then the second kernel will fail to init TDX.  The reason the first 
SEAMCALL to initialize TDX module in the second kernel will fail due to 
module having been initialized.

However if the first kernel has not enabled TDX, the second kernel is 
able to enable it.

