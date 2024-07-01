Return-Path: <linux-kernel+bounces-237021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A991E9FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8EEB217EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A4F171671;
	Mon,  1 Jul 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DcT/7yzZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3E381C4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868202; cv=fail; b=pGBdMLvnoCPVVajRk9haBF5yNAvPTWcb/CjtaJ7r/I6OybAVbt+X2yibJ8mDHFc1qeT7IPwVzLe85rCETftD6+aPuB410khGjnxhsWRjIMEqjpsC8zM1AU6EPBeyFg8RHLhI4sRLYsTrMYjrnHcwXlBuqZirLwYYfgxiVmMiaz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868202; c=relaxed/simple;
	bh=WSBsc+aRKCzHKpg+52bKr4uhSgP/s05aa9AKC94IjXA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAqLCn6ipBAct762qMGojMobMq6aX9E4dkG5ZAmWcSk0Po2ptLD4uJf4ocRux62QDRygYFfC4vi0NMvxaDvSj8zbwHcTYjrOC6vDm6eNB7pLEqBeHSNS6SaxE2gvyvp4At0xRtijhL+6gvWPmye2siEbC2f8wFbBaYYv1sgdO9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DcT/7yzZ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719868201; x=1751404201;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WSBsc+aRKCzHKpg+52bKr4uhSgP/s05aa9AKC94IjXA=;
  b=DcT/7yzZ9iK3JiSVaa5yUosWSLXvLjultSYtIbE1h7TOXO2O8RUqQ314
   ss9UhkcSSklJI3eQNWjPDRRXI7YAna8+NnfiFEGc8dzXsRD0qdzpVwVCF
   Kfy73rqkI/g4tSbU3kZ8UTOvczHP9QzL+D6DXmmYk6aF+Fndt6MWBVxSY
   RCI8kLiGQXxchKdV+cj2FelQOLvHy0U2A9tfYKnKPOwB2rWouio8LXbL2
   07zMgcdcl2OtMAq0BV4KqwcgcIIIJFJs/TxzSicREUmdvUmCzkBdoDT46
   WR4aOZa+FtRFG7KBVdrlKxyiXkTjq+Kh2+nIJbZPNoBK/2dkZxM7pLhHU
   A==;
X-CSE-ConnectionGUID: 8DOJb/lXR2mcbWwj1khl0g==
X-CSE-MsgGUID: jJFaSaqpRAaRQx+Npgbdrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="19916391"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="19916391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 14:10:00 -0700
X-CSE-ConnectionGUID: V6g2ul2HQSKu65APUf3NpA==
X-CSE-MsgGUID: LJSO75uRQU2Sb3FgpSLR/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="46089759"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 14:10:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 14:09:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 14:09:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 14:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRZmbBjTbhTZDaJWijIQOP3qwBqH/koTCa0rZeQB4kxG4nBQHJWHDoSAEF7L98fF6ipNp/GkV7ldHH941z/HbmPC893pijZ30e13ydzzY6vNKnyceY04wQrDpWdDSO3ejlZ9V/pbMcgS+RuEme7bjALUo9cBWKjBBOqP5dv3pKLe5RVf2TQZk7kGnxnulCLBYsatgMhESLiD7ILaLDDzEwPqKJPsOWuqsWBV0oYFkHQ6bTNl8qqMwTdPuXnEXiq5PT6MmwfoXwW5K5TPMtTMlFt/xoJ4THyih15eP5U+PwOEDNjy2DkPesKrk+tfrA/sEpumpUJlxayvIQ94/dA78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y81jJ5jWqojpHIYc3YduYSDLe2iEE6tTEGGFoUfllgk=;
 b=EFb9KebyYidM0+Xp/EXjJ5Xl0uMHobCioM3LvP6irGgMYc8vrHw+5OEZfUeprYstASmUp7t39vIXiSVpR5DfN+sSl7q5+raTXXxXNZEnTj4Ia+zkQwg3X/tz0vUr+ziBassTfuJ/nLlGVx39Yq3MGvkvARaMDcfLTSaMIwY3QFla5Rx9QpoXhE6MVyoaXyBJsYfgBdocwWnW/Ziwi2F6jwRpv/XMUHkOcEpTottb0ZDVtP+HFH5kiKx5FK7GdxKZNH/ss58aq5ihrWSt8dnuQd4wFQ3EvAHMW1m4ZQbpzYEkqSTU1bLmuyH/asVCEcEoRF4z/U2QSDvYzoGSSlqUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8457.namprd11.prod.outlook.com (2603:10b6:408:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 21:09:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 21:09:55 +0000
Message-ID: <c79a1aae-6ab7-48d2-93fb-7b78198b5954@intel.com>
Date: Mon, 1 Jul 2024 14:09:52 -0700
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-4-james.morse@arm.com>
 <62581526-2dfa-44a5-a0bb-8582932b9943@intel.com>
 <d8e30c4f-04ef-4ed0-9d06-7f735c1c5e90@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d8e30c4f-04ef-4ed0-9d06-7f735c1c5e90@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:303:2a::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d7be8f-6494-46eb-2e43-08dc9a1227f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXN2L3lXTmRrbGZyS3JDSFd3NE9ZKzJRMlpSVmlaWXVneDYzVUh3S0psem5X?=
 =?utf-8?B?K2ZWR2FlTWwrVkYvb1pXN3dBUGtUVXIvZGxSclJsbEx3Q2RpbDZHcm50N2l0?=
 =?utf-8?B?Q04xeDNZc1lxT2lOR01Ja1hlT1FGdzhmaU1aQU1tZHNWd0hGaXBFaEd5TUpy?=
 =?utf-8?B?R09nUmRjR29FZ1ZmSHVYMWZDUVNmcU10VzY5Y0RsYnF6VFEvMEpKZzlubTFs?=
 =?utf-8?B?YVp1b3RRLzBMWjNWVExwTFc1SkFaSjd5dmo1Yk02MlF6dW1HOHNxUU9kUms0?=
 =?utf-8?B?WW95SXQzdmk2RFlBQUxlVDk1TnRoZTYzYVh1ZTB5NFg2NDlNa21WdFl2U1dV?=
 =?utf-8?B?QkkrTTRZdC9pRThWSjZ1ekVzWlhOUW1PeksrektuZXdOekpWYTJQQ05xQk9W?=
 =?utf-8?B?NTYxMU5JWndLQzdFeGUyeW1Wc1h3R3h2QzJreGZZL2ZkTXV1Rmg0aWVMV28v?=
 =?utf-8?B?enNrc0JkeEtKVjVUdXBSMXZIMmZqMTRSeEx3TFBrWDV5TVl2dkZXRzVQNzFz?=
 =?utf-8?B?MWlmS3Foa2dDVjRnTnNYa2VNQ0NVWmsxZ2ZNV1JKd3hra3NnU0U3RS92RUs4?=
 =?utf-8?B?bDdHeExuMjBaNGwvOE5JanlWeGNWZ1VYNEorZHFvOEVGVER6Q2RwRHA4TTRz?=
 =?utf-8?B?SzBTelIrcHJhbklzdnVuV29OK1B0WjRQY1A1ODVERVN3T0xLNG1SVkVmTWdh?=
 =?utf-8?B?UEJQS0JJSnR4cjdoekJ6YTVPNlpzV3U1YXhCU3gzQ2JuNFFYWHkycy9GcFpu?=
 =?utf-8?B?QkV4Vkg4Sy9mZTMwb20xYWhNZzBwazdNQmtTa0JhZXUxY0tpUjFLNGhrZ3hP?=
 =?utf-8?B?N255YlI4Mml2MFdsdTI5d1hmT09SNzlEV0VVbW16Um9SSHk4eFJ6UVVCYk5U?=
 =?utf-8?B?TDJsbXZwWnIyQTJXOUd2M2svelVQeDRUSGE1VUtPS2xWZm5HWVBlUnRTbHR2?=
 =?utf-8?B?THdZM2lTQ1U1MEphS3RlcmhEN1F3N05nYXpENWpDd25veHlUdUNiQmVENmlI?=
 =?utf-8?B?WDdqOFVLQmRLVUdDbEN1UWNPWlRQOVNDU2ZYZkZZUmwveDBEc2QzRlRVSzF0?=
 =?utf-8?B?RTRJNkJVdGRPV2RGV2hqNWZ3Z0lZQkJUa0VrMUNZNGFKWFBpZUZWWjV6VjVV?=
 =?utf-8?B?K3Y5SUVzQ0ZuS25yRGJEanhSL2MySTVLKzhyZnJLaHNSNEFrbmJ2Tkpkdndn?=
 =?utf-8?B?K1d2ek5HVDdOazNJc3YwRWtWeEJJZUQyamhGNUNkS3lFeURsSHRocThVNEgx?=
 =?utf-8?B?SHJ5OTFxVk1UcWFZZFJEK1IvenhzVXV3bWlpTS9IbzZWNHByZ0Rkb25YZ0dv?=
 =?utf-8?B?UytoS3h0cllXV1BFYUNkNHdUOVpIeHpveTBHT1I5WFN2N0pKbjk1Mmd1MGtu?=
 =?utf-8?B?VTZrbWUxZWttOTBaQzFhdU5aZHZMOERkMmpSWU5lOFBvR2lHamt1Z2E4ekJV?=
 =?utf-8?B?OUxPUC8vd1B5R296Wm5XVjlpOEpEU1p4d29EamQrdHdVTXhKK0VuM1M4ZjRS?=
 =?utf-8?B?Q2lFcjk2WGZSRE1PUzFYbkNmZ2oxMmVnU2x2T1IyWHJRWGNmWFpLWDhkZ1BP?=
 =?utf-8?B?OSsxREdwQXNHY01WekxtbGZKSGVBS3RBc0dyWkFXd2RtcU41OC9kWUNoTU1Y?=
 =?utf-8?B?aGUyWTdZZVRHYlRMS0p3dXdkOW9vTkNiSDhBc0phNU5SN0NiWERTS3dDbC9j?=
 =?utf-8?B?Qlh6b2lSaC9XWE84ZmJvRUcxVTdzeHZVOUxPRmd0dFdmR2R3OXZ4WmRIVjhh?=
 =?utf-8?B?UlhhcUFzSGp4RUc1d2lHQ2F5djVPQUpGTmxFMDdHMzVxZDRSUEYwbjJTb28w?=
 =?utf-8?B?cHpPa08xOTc4eW5BUlM2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3RCVEQ1VituUlJIR093VzZhR20yM2JCQThvVWFROWszbkMxbHFkUk85MlJC?=
 =?utf-8?B?MzRhYmczQVhQK09OQ2psWDJBMTFuVlBXYnMvTk5aTTkxclR5Z003ZFA0ZEFT?=
 =?utf-8?B?K1dwNWZGSU5lWDFZbHROMmIrYmYyallITkQwdXJ6c0tTclh5aHpJK0dTMU1U?=
 =?utf-8?B?TUVXK0Evdzg2MUhoY0J4ZGp6Z2Y4MlJweXJ0OGtXWHVvMmVaa0Y2eEZvY2Fa?=
 =?utf-8?B?YlFZclBIWXpZa2x2UVQ1TkhkMko2Z1NPSUIyazNXeXhJcFhYRzFzVFp5QjM0?=
 =?utf-8?B?QWpUMnZiVFVVQnhnZUExVnVOWHlxU1dwUk1NTXlaWTRUL0orb0RFK2QzRnZi?=
 =?utf-8?B?SElsUDNvRmFCa1VzUkRwN3lIMmI0UUNRaGhjSTI3eVV2K0QyekkwZVVlY1Fo?=
 =?utf-8?B?bXV3Tkh1QkV5YUFtQkMxcW9Pc1pRUUM2SzJUSGdYaXJybVRhQW53NFBOSlVL?=
 =?utf-8?B?cDhFR0lPeHovOVY3RWgzazhBN3RQbnF4NElOQjFlczVGaXh5bnF4NGtDcDRl?=
 =?utf-8?B?d1dsOTVCVk9MY25zOFdIUG5Hdm8rckRMT25ZZEpnMXhRVXlQY3ZkTDJtU3pz?=
 =?utf-8?B?czZ3MFdPRDM1b1ZZRXR4L2dIdlZYaUt5eDg0a3dEUk45eTRxVjhKcDJKTFRG?=
 =?utf-8?B?QlZHOHhkYUE1Y0w1K2MwMmIwRHpxZzZqZlhCaHhvQm1RMkxPWkd1Rk1Bc2NN?=
 =?utf-8?B?Z01ndEZUSmZkZ2g5VzJic05icXQ1Qjd5bmQrQzNvUDA1ODlCL0EwRGV3cnlG?=
 =?utf-8?B?UDZtNGY0WnN1VStSSU82UlJ2QlpuWi94bUN1dnBPWmtLLzZNYkc4YkF4RlY2?=
 =?utf-8?B?S1FLYmxnL0hnNWNDTkg1M1ZRVzc4SVBRMjd2QVZacS8yTnBVR1NhcDluZE54?=
 =?utf-8?B?cFR1Y1ZvZE10VE91Zkk4STdpUnc4eXFXQnZUWW5ZeHlTVXNadStiNlRFMGR6?=
 =?utf-8?B?OTRZRlhwNm1xazQzYnAzYzZDd1dBL0R0UWhhSjVPQ1dZNlh3eUVZNVRCWHJm?=
 =?utf-8?B?NUlmUEUyWE9ET3IrazFhY3BET21pdWludmdqWEpFczBMTWJPRmdiYzFNSXhi?=
 =?utf-8?B?NHdad29UUzRiTStuckZlbTlJN2I5amt4Tm1Mam5lT09RMk1GOEJxKzBSbDE0?=
 =?utf-8?B?UkR1NTF1NWNEVHJ6N1NQR09RZCtmK3JrN1RJMUtpV3hyTVkxY1VUdnlFZDBs?=
 =?utf-8?B?NkNZQWkwZ2Qydm5HWHo1NUduVndvRUpUcGFmQjMwUGkxNmJaOHRqWjRvbnFY?=
 =?utf-8?B?aEk0bHJtZ3QwRzNITEVJcjhhenZhTVByUjdKaUdIV3RQV0pnU2g1ZFBpU0NN?=
 =?utf-8?B?Mnd1aEF6dnVsWThLQ2RMV0pKUk81YmMxR05qbmpRc0ExZFVnNUN4b0xVbVBj?=
 =?utf-8?B?anAxY29LQjEzTitQOWVDUDJxNDBQd3Y1dHFnWkM2OVpSWDFRRngwOHQ0eDU2?=
 =?utf-8?B?VEsvRktaWXhTZ2t6d0VhVGhGV1JwaHpsUlY4M25HZklwOEpLSEJyeEN3QzJE?=
 =?utf-8?B?R2o3akp1VlZKaTZvN1ZGb0F0SHAvY1hTNmM5TWkxNHYyeUJMTzZ1YjBEZHRs?=
 =?utf-8?B?L09Za25hcUFhVzdsTDAyQ2lYT2NWcnpndmNkTk1tVG9DM0p2S0g0bXRYeUox?=
 =?utf-8?B?RFpaVmEva1B0TVFPYWIyd1FwZzBjcUtOTFRpK3RZKzBxMkhKMmFLM1FHWnpt?=
 =?utf-8?B?d0dsL2RGdURBTmJ5NUtGMGhrZTViSGdUN3VaT05jcmFJQUM4ckh2c1dGQVhp?=
 =?utf-8?B?Z01sbHVUTit2dTlqR3l3Y0hDQm5odWxZdmNhSGM0VkZGNmhpYkd1V0RRZ0ho?=
 =?utf-8?B?SlllRTVlUXJ5dnllaHFwTjlZdWtWdmxoUlY2ZUJrcmVJMDEvazNnSStKWmZE?=
 =?utf-8?B?d2lqOWFublRWZlRPSHVFM2FlU0dQV2d6bGwyaFczS0hNY2hkME1CVTBDcldu?=
 =?utf-8?B?N2NzYmplVDVNbS9NMUx2Q3FwaEtaaENtVEljSWt1TW04K2JGUDY2bDlNQm5w?=
 =?utf-8?B?SnFvUmV0MytRUWZPYXRvTjhNakExR0F5SWYycWFiZ0xZelVBOCtBQkVZTWFB?=
 =?utf-8?B?MUFvdlJvSWFEMkpCNUlVd29oK3d3SG8rSnRhcmg4Q2FUQnBOYU43RW1HZmJp?=
 =?utf-8?B?Z082Qi9SaHdCdGx2Q0ZvdysydFBMaVNZMHR3blVUWUFPV01qWGZOaEJXOFNJ?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d7be8f-6494-46eb-2e43-08dc9a1227f7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 21:09:55.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byEyXXR6W/fsTa4rf3pq87tPI9cKhJmjqZotTcl0T9tpl2akWmLbMBnY0P7rEUixUgSDHHecaJ6A7nzf/bxv+YwZN7VpWK6QUkhpOC/ryeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8457
X-OriginatorOrg: intel.com

Hi James,

On 7/1/24 11:17 AM, James Morse wrote:
> Hi Reinette,
> 
> On 28/06/2024 17:43, Reinette Chatre wrote:
>> On 6/14/24 7:59 AM, James Morse wrote:
>>> resctrl has three types of control, these emerge from the way the
>>> architecture initialises a number of properties in struct rdt_resource.
>>>
>>> A group of these properties need to be set the same on all architectures,
>>> it would be better to specify the format the schema entry should use, and
>>> allow resctrl to generate all the other properties it needs. This avoids
>>> architectures having divergant behaviour here.
>>
>> divergant -> divergent ?
>>
>>>
>>> Add a schema format enum, and as a first use, replace the fflags member
>>> of struct rdt_resource.
>>>
>>> The MBA schema has a different format between AMD and Intel systems.
>>> The schema_fmt property is changed by __rdt_get_mem_config_amd() to
>>> enable the MBPS format.
> 
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index e3edc41882dc..b12307d465bc 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -2162,6 +2162,19 @@ static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
>>>        return ret;
>>>    }
>>>    +static u32 fflags_from_resource(struct rdt_resource *r)
>>> +{
>>> +    switch (r->schema_fmt) {
>>> +    case RESCTRL_SCHEMA_BITMAP:
>>> +        return RFTYPE_RES_CACHE;
>>> +    case RESCTRL_SCHEMA_PERCENTAGE:
>>> +    case RESCTRL_SCHEMA_MBPS:
>>> +        return RFTYPE_RES_MB;
>>> +    }
>>> +
>>> +    return WARN_ON_ONCE(1);
>>> +}
>>> +
>>
>> The fflags returned specifies which files will be associated with the resource
>> in the "info" directory. Basing this on a property of the schema does not look
>> right to me. I understand that many of the info files relate to, for example,
>> information related to the bitmap used by the cache,
> 
> Do we agree that some of them are?
> 
> One reason for doing this is it decouples the parsing and management of bitmaps from "this
> is the L3 cache", which will make it much easier to support bitmaps on some other kind of
> resource.

The way I see it is that it changes the meaning of the RFTYPE_RES_CACHE flag from "this is a
file related to the cache resource" to "this is a file containing a bitmap property".
It prevents us from easily adding a file related to the cache resource, which
the info directory is intended to contain.

> 
> Ultimately I'd like to expose these to user-space, so that user-space can work out how to
> configure resources it doesn't recognise. Today '100' could be a percentage, a bitmap, or
> a value in MB/s. Today some knowledge of the control type is needed to work this out.
> 
> 
>> but that is not the same for
>> info files related to the MBA resource (all info files related to MBA resource
>> are not about the schema property format).
> 
> Hmmm, because the files min_bandwidth and bandwidth_gran both have bandwidth in their name?
> 
> I agree 'delay_linear' and 'thread_throttle_mode' are a bit strange.

Right. This is not a clean association.

> 
> 
>> I do not think the type of values of a schema should dictate which files
>> appear in the info directory.
> 
> Longer term I think this will be a problem. We probably only have 3 types of control:
> percentage, bitmap and MB/s... but if each resource on each architecture adds files here
> the list will quickly grow. User-space won't be able to work out how to configure a
> resource type it hadn't seen before.

That is fair. This makes the type of control a property of the resource as is done in this
series. Perhaps this can be exposed to user space via the info directory?

Possibly the files related to control can have new flags that that reflect the control type
instead of the resource. For example, "bit_usage" currently has
"RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE" and that could be (for lack of better
term) "RFTYPE_CTRL_INFO | RFTYPE_CTRL_BITMAP" to disconnect the control type from the
resource. Doing so may then map nicely to the fflags_from_resource() in this patch that
connects the schema format to the _control_ type flag. As we have found there is not
a clear mapping between the control type and the resource type so I expect RFTYPE_RES_CACHE
and RFTYPE_RES_MB to remain and be associated with files that contain information
specific to that resource. This enables future additions of files containing cache specific
(non-bitmap) properties to still be added (with RFTYPE_RES_CACHE flag) without impacting
everything that uses a bitmap.

What do you think?

> 
> This may not be the time - but I think eventually resctrl shouldn't have to care about
> what resources the architecture is presenting.
> For these files, we may need to duplicate 'min_bandwidth' as 'min_percentage'. MBA would
> have both, but any new controls using percentage wouldn't expose them.
> 
> 
>> Doesn't MPAM support percentage for cache resources
>> and bitmaps for memory resources?
> 
> It can have fixed-point-fractions and bitmaps for both caches and memory. Unfortunately
> everything in MPAM is optional - the driver converts whatever it finds for memory
> bandwidth to a percentage as that is what resctrl and user-space expect.
> I can't do the same for cache controls as bitmaps implicitly isolate portions, something
> that can't be done with the fractional control. So far everyone has built the bitmaps
> because its the easiest implementation - but I have had requests to support the cache
> fixed-point-fraction. Doing it as a percentage is least invasive to resctrl...
> 
> 
>> Can the fflags rather depend on the resource type itself, by using the rid?
> 
> Sure.
> 

Reinette



