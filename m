Return-Path: <linux-kernel+bounces-271869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFDA945426
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CFF1C22E89
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0178314AD3B;
	Thu,  1 Aug 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iisspcun"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397517579;
	Thu,  1 Aug 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722548247; cv=fail; b=YUL6rx6cqJJnGoUAARm4rjgq3QvGeXcLvWl5wpralS1GnP0Ta9MplZlqbYQJxsJz8ufRtDqQtJ1wjDyiVkvF6ReD/817Y4vL9nkBPT92KHDtHqk0KdiINyF9SiPUlEDSs729jxoUQGk5vPGqBiS9lNrblmqtjC2vM/bQwnp3u9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722548247; c=relaxed/simple;
	bh=72JhWyl//qAkVGYNZImYCCi1S3zZYaN0ImiMhMSNsgU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P05XPTZQ7F5SQDCKWsXx44mRQPGprDJAr3iIG/vRbp8/IFbqDoDODf237C/Fi7ipli4VUWWzQSI04xGZn2RlcGfF4vDLpGY7ZrGYR7Yh1SDHsj9NCLKAgFXt3cfOhjEA1eWqKn8cQ3E7uSYjY7q4+1B8+YDdfX8Xs8Wtv6yDF2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iisspcun; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722548246; x=1754084246;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=72JhWyl//qAkVGYNZImYCCi1S3zZYaN0ImiMhMSNsgU=;
  b=iisspcunx+VXEszAQak1pSrJ52CwcBUeVerg6IV956wOFySsy2Mh8JS2
   6V/SKcasx0Qxz6ivBsaheG0/Ao6wRiJ5yTVeW6VnJFfbm8orNpTSqmtNV
   qxgno+vLCOIfQBzJfAwdwwsx3aZjTUD/ItyRW3aq8/qWZ/YYoAr65eAIr
   IW/KcKx/Kj+/fnR+LYSxVxHqvEPmj6hLe4GDGAFlb6cmqdKFTEE93bCSg
   5uJ+oLypFuWDbTWc6ip8tGqpSUI5VOeKYjuWspISTd/ER0/zXDv6g40t9
   xTQNWBYNMI3vs32PJO8Gv0aO1j5mla7xtESzOhHO8o0r7mzQKnR5nFspM
   Q==;
X-CSE-ConnectionGUID: v6KF5gy8SVyZB8e/56QDTA==
X-CSE-MsgGUID: 89R/4hw6S3isymUfjSpaqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="23456726"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="23456726"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:37:25 -0700
X-CSE-ConnectionGUID: s+lgvKuNQ8qYs5CdbeJMVw==
X-CSE-MsgGUID: A8x1AbpMT322gRIvZKmKUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="86118109"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 14:37:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 14:37:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 14:37:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 14:37:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFSGDR3fWhi9VKyvFGrl+EdwtMpFlpMesbKHd5nVow9ggZuo27z9Afy+ACIYXqqnfD5q0t4QBGGID4uAGv5W/OFFUEykStScD1Ytf2GG1D9dU3XNUJrQr+DzIata/pGeqPjIW+CqplM6m5YBT1xad5aM9GVpe7q47Gg8OIbbUc+0L4SNwPOo1FdpbxTkOL8hbCuZWCj2+LjrSbls8LI1SFZNVAaXOE4TftHEiLMm9KkQcY9WwMtxIP20iXsFlB04a7LSM60x6yXiu+qoRYoOcpH00iZmqn4msPessbFy8kcSCpTAfy6vdXxgQS0YjVTltCggUuL60ze5KSAwAOkumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0efanOrozQN9kZ9w/LOj2Ygo3J0lq8dZrIegvQkgxA=;
 b=cIN0x7CS0iyOqY2j0afuaMdkNYQKgc6VGMg+Om8pqHFhcFdHueuxf/h2cGYLndUQDKWkrx8Nkv+p696Fak+bK3rxBy3/D/XMGvKz3jAM3snO8FAozjaHx0fdYOJC/JMK0M/XRkB/TD9yGh+eKFQ7Jgugom98Tb/onKlTdATPF1+Cu0LeomdXWx21tBq0QPSbSjNPBWahUzQ9NPFaGIfcvXwbXJvqD1HARIKnQzxQ+Pax0Zo+wZycRGwyfZhtuWwekD2s0BHvM3EsDInU7QX6vNojxmETfnCbaLPjsbZthzMgEGrTk4A1tArtEVC7FENo5NG/ogxSaaWDqH7egVdjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 21:37:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 21:37:13 +0000
Message-ID: <b4d33443-e7b8-4394-9ac5-dc16115c32f7@intel.com>
Date: Thu, 1 Aug 2024 14:37:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/20] x86/resctrl: Introduce interface to list monitor
 states of all the groups
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <3be66db2dbbe2d231fd5afbe6c7f092278b5a903.1720043311.git.babu.moger@amd.com>
 <710a83af-ed88-412f-8f7e-33678a8ed197@intel.com>
 <d7dd2585-9f39-4e66-b218-4815bf888a77@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d7dd2585-9f39-4e66-b218-4815bf888a77@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:303:8e::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 573dd913-7381-420a-dc52-08dcb2721b1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDI4cVhBdFFVdUIyZk02VlJMWms1OHNwNm1taHpjS0hYZENway81NGJ3aHRK?=
 =?utf-8?B?QlhMdjBUbDdsWkNuamQ1bHRWekxpUTAvMHdRbFY5WjVWYkRsbnNXRmI5ZEho?=
 =?utf-8?B?ekJGM0w1UWxja2tqOTAxNmswUnRMRTFMdTFIdnRMOG1DRkdYcmhBRjZlUE50?=
 =?utf-8?B?WXhLU0h6TE02RVorNlIyckt6aEo3MGx1RHBNdTYrQ3g3a0JFbnNMbHBUR3o2?=
 =?utf-8?B?UVczSFZSZVdmVXlwb3JYVUliZW11b294SHM3NTQza2wrR3NRQjdHQXFIYnhk?=
 =?utf-8?B?N2s3QjVKNERuRlFwQTZMengvYmN0WDdxZFJVNjFjazJJU3VaYmUvVmQ3SzlG?=
 =?utf-8?B?NmFKQ0dpRlNoTXkzK2FhVk1aeFRTQjAvb01UU0dzTXIzSU9qa3pJcklGa3BW?=
 =?utf-8?B?VjYzbDBpZ2I5RTRqWmI3RlB6bnhEaTNCMVBwSGIvQnI1dXBwNU9hbjl3ZzNP?=
 =?utf-8?B?ZEdiWllRcmZRQTJrTlRxTG1nZThJUEVHQmQ1czZxQmRac0hxcEJCYjdMSjND?=
 =?utf-8?B?SzNGS1RWUzNNSmppdVY0N2F4aEhZTS9rSHUyUE1lNVAxZFl5QU9oTUVqdEho?=
 =?utf-8?B?OGxBNHZVSEZXKzBUdTVVMUY5dGpvTWFTdlFrT0hOZUh1MDF3eTNJRFI5OXEw?=
 =?utf-8?B?cktHQit1T3dGREI3V0EyVnVINW1jNzJDZVNwNWxPRXRSU1pFRVVXbW1kOElU?=
 =?utf-8?B?QmhSUGZqbjg1cGhrQ0xpWVVucHZtWG9XS0d5MDQxWmFnVDhXMTNDMWhNb0xC?=
 =?utf-8?B?YU9iV0J5OGRXL1U1dk1rUEIzdEIybHVJZjdzaFpRQ2E1NktKNSt2ZmJmRzR6?=
 =?utf-8?B?cklyYy91L0pJYUk0cjlIN3hvM0ZvZFA5d2haOTIwSEovSGhzRFVtRVVZa21n?=
 =?utf-8?B?M0poNkVYTGtVc0lZaFVOMmFXQ04vMnFOUEh5SlRDdFpLZSsrTkZTVGlYalIy?=
 =?utf-8?B?aDNtZlZzdGdnMXFoVUplL1RMdGdUeWF1T0pCYzQ3amdTam5NQ00rcjFIU3V2?=
 =?utf-8?B?dkJhOEdYWmdZUVd5bzl0eVB3WEZsa1BkVWNnTkRERUEyNHBwT3hQQ2dJVm1n?=
 =?utf-8?B?S2pGd1hHWjQ0UkxJNG1rL1JmbGo3cXRBc0w4ZldUQXl5YmZBMy9yMXVDSGNB?=
 =?utf-8?B?QnNYMzJTMTFOMFp2QWpTbUNGaldlcTEvTGQrZEJKTWdIaGVwVWJKVnAwbEwv?=
 =?utf-8?B?NWNaTE54SlliQXJoNUZyODVBWitaTjQ2WlJoem0rQml0R0lyeFVMQVFzY0Y0?=
 =?utf-8?B?bVpkUmJnUU5kN3ZESXEyMkQrcGZFN2lBUmJocnVLSnFLR0MvWUljbmY1SHN2?=
 =?utf-8?B?b295UTJoUzhqdk9WOVpXQ2V1amFJSU83SGMrNFNHTGxMbDhBUVRCY3BhWjU3?=
 =?utf-8?B?VGc1a3kwRUpnVDBPK3JsZEsvK2J6T3VxTG9LQU9uQlQwNWxjMllHQ1BURXNH?=
 =?utf-8?B?VUlydWNIeHRzR1NqREdUaFlSWktXS0Q1dDJqZExqK2E0amVmaVNFc2V4YU9D?=
 =?utf-8?B?emZzZWpiKzRjWlhiNm0yK0o2czZaWkc0ZWJFUXZWeTQzbnhlZlRYa0RMZEdY?=
 =?utf-8?B?cUpkV2F1T0ptYm9WZzZSOTZza0luS25NUUZzUzdlNU1zZWVndUZOT2gwN1Nm?=
 =?utf-8?B?MlNSODFXWUVlUlJSYmhQNHV5T0loUW9kbGJ4RXBreWg5eGtEcGpMQ2hqZmZQ?=
 =?utf-8?B?cmJxR25Ob3FOTWJNNjdTSzNjZlNhMWd5OStKWDQ3V2xiL3FUSys3bEt1bnBS?=
 =?utf-8?B?cjF1ckdRNVpBUGpSdnFMeDd6T2tVTW0xNkYwLzRTKzVHYzFlbllkeTdPbDVj?=
 =?utf-8?B?MVVhODU2djFDeDB4YkZrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNIYk9ISkVNaEs0STlYTHplRnlieC91MWtUQ01NYjJpd3YxZ1NqY1had09U?=
 =?utf-8?B?aXVRRWdZa0JrbnRoUVViVnh0VzY1Z1NOMVJTanZBMk8xaUpYS1gxRUE1VkRi?=
 =?utf-8?B?U2thN1ZnMVBuZ3dTR1I0VXNTUGVSVFoyWU1aQjZFK2RiYTlNa2pJS2VNcklG?=
 =?utf-8?B?UXp1cUdxRWRMdHp0Y1VoeFdtbHFMNnlqem1YK29DcklHdXdIaEQ5WVZGOGk1?=
 =?utf-8?B?OHpqVmVJeGJKQlltV1JGby9XM2RlN3VRbktRbDJTQnNQRTQvTVZNMWx2NHdX?=
 =?utf-8?B?ejlWeWY1L3creWVnZ0V3Vzl3eUxtbXl5cUQ4Nkw3ZStzOFlTUVhDZUhOVHgr?=
 =?utf-8?B?cVJuZzZWVkpPT2h6RjBjMklvNUZGMjhCRDRLTTdhb3ZlZjFZMnZBS0x0ZE0z?=
 =?utf-8?B?WVptaURlOE5vb1ZDTi9vNGF5Y0dxUHV6NXM3a1J5aWxhWURPRU9ac0M5UXlN?=
 =?utf-8?B?WVZiS3ozT3BZWHlPV3kyRHlva2pXc25iczVqR2ZTc0NKWlczc3FycGR1bHhY?=
 =?utf-8?B?YklXMndGUm5tT3NhaU0vR2JKaFFObS9nQ0xnU0JzMkc2UlVESk1Ia1FBelhP?=
 =?utf-8?B?TStXTWZuUFo4bDAyeFc3eFlLbmpxaWFTU05yVUptdmhjQnVWM2tjUTNuaE9Z?=
 =?utf-8?B?cU9uK2NYMkJUY2ZWRU8zb3drUWVZOHU4dVhhWFIrSXdLVFI4b1UxcFJRaXAz?=
 =?utf-8?B?ZDE4V2ovY3F5MktIQkhmSzJ1NzlWMlZNVEg3Z3MvVGJ3OTVXem9wdVFzN3Rh?=
 =?utf-8?B?VkxrbjlVdkZnRmFCNzRTRVFLemFuVUhqUVVvSlZld2ZlQzlrZ3M5UVQyTk1V?=
 =?utf-8?B?TEQ0d2l2ME5TV0hvZ1pHWGtyS25zNkUvY0I4dEFhdDhSZlhSSDlMaUpqaSsv?=
 =?utf-8?B?TThWSEdhbWlOZDZ1YzJkb3dhdmN6UHFiU0pOQjhzYXJpM1ZQaWJ0VlpFNURp?=
 =?utf-8?B?Ykp3eHBVSG9rZyt5Ynh4NVZNQkpoYXpmQVNFZCtabFM3VEM3RG5zZERQeWZC?=
 =?utf-8?B?allSaHZsMUVzWEtFeFF0Qk0wK1R3M3h0SkM2amE3dnpsbE9OdDVvaGZvZWk3?=
 =?utf-8?B?SjQySWFzNXE2NDI1SW1zQStWQVg4ZUdSZXNVWnFRWlBMdXFhL0dYR3hPVHJW?=
 =?utf-8?B?NVlPR0wvV2RyS1lQQVlUNWQrY2pRMWhUMHQ5bUgzLzZod0M1LzhONDhYL1Q2?=
 =?utf-8?B?eDdKdmE0SVFOaEVyV1VHUVdqSWs1VnpaU1VwUkJUWGc4T3NVTHAyajM2SDZC?=
 =?utf-8?B?REpiT1c1UWF1a2prUDhHM1paRHZWSmNKQVQxcTJuOVlPNk53M3NqR2pkUEFZ?=
 =?utf-8?B?WmZqTXp0MVRWU2NLMGduVUp3TDF5YThGOE0vcXU2ckh1WTlWbEhOazFiVVZ1?=
 =?utf-8?B?MEovZFM2VE85bjhtZ2syS0p5VTB0TzFNeGs1Qm44bERLb0E0NURSczd2clpi?=
 =?utf-8?B?eGR4azcvUlQvb0pyTXBia1ZwdzF4SzZpaDhSR0w5SDBUTnphcXdRQU0zd1A2?=
 =?utf-8?B?blQrdXBpckhBVENvZkRqWmFJbnNXcFBuVlViakw0d3FnMkxFd011ZU5TWGdT?=
 =?utf-8?B?OW4wYi8vbWdlRis1bHlvTm5MVmpOc1NEcUFHQTBmVEowOUdidGVvcXhGczF0?=
 =?utf-8?B?QndBUWVLUjdQMDdZWFJrdVZjSXAyMVdNS2VWcWg4N0RUQkJLU3lhVFFsZ1pT?=
 =?utf-8?B?S3BpV0dNTmNiMXZsNjdhcWZnb3RkMnUyY1RUUm9NRnFSbWk0d2F4ZnVyeER4?=
 =?utf-8?B?eXpiMVBLeHlqclUvS0FQcGlsMW1acGpqbllhZXljTTY4WTNzQVVtVnNXNjdY?=
 =?utf-8?B?TmZwaEhoSVU5RWxBdm9ZZFhPeE5mUGpWZ1laNXNlWTRZaDcwK3F4aVVCemFQ?=
 =?utf-8?B?T3Fnc3pjaVMzOXhsS0NKUmtwNG4xZjM4Ri8xS0Z2K2NoUUl1US9VcHROcHVN?=
 =?utf-8?B?enhGeFQ3VFRoMDY1SExuQzBkZjMzY3BrWjdycWhHVDZaNHBjcGJHalErdTg3?=
 =?utf-8?B?OW1VSnkzYTNCdzBWajZQbGdzeitGQWZWdjF1aCtQTlNrdXNhdmhHTFd4VXhi?=
 =?utf-8?B?d1lsRC9uVm55b2FSdjY5WnpzMVNCaTl6c3pQMHpSNStxK0dMbU9CcGtpRW45?=
 =?utf-8?B?bHM4Zk1ZZFdhQzBoV2w0Z0oyU2NCdC9WeWU1VnlVN3dmdjJrZEVOV1pQZ3c2?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 573dd913-7381-420a-dc52-08dcb2721b1c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:37:13.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EU2uI1chMYZYcS7A9Qx+dAVdTJ8hD8XBdZvsX+u2LdHlFsLey73yXl6XJkMYa0lWdfr50lw5YmPWyOhgJp4WuP3cvRu/98EOZR3SO47NG5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com

Hi Babu,

On 7/17/24 8:22 AM, Moger, Babu wrote:
> On 7/12/24 17:16, Reinette Chatre wrote:
>> On 7/3/24 2:48 PM, Babu Moger wrote:

>>> +     */
>>> +    if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
>>> +        if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0],
>>> rdtgrp->mon.rmid))
>>> +            dom_state |= ASSIGN_TOTAL;
>>> +
>>> +    if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
>>> +        if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1],
>>> rdtgrp->mon.rmid))
>>> +            dom_state |= ASSIGN_LOCAL;
>>> +
>>> +    switch (dom_state) {
>>> +    case ASSIGN_NONE:
>>> +        *tmp++ = '_';
>>> +        break;
>>> +    case (ASSIGN_TOTAL | ASSIGN_LOCAL):
>>> +        *tmp++ = 't';
>>> +        *tmp++ = 'l';
>>> +        break;
>>> +    case ASSIGN_TOTAL:
>>> +        *tmp++ = 't';
>>> +        break;
>>> +    case ASSIGN_LOCAL:
>>> +        *tmp++ = 'l';
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>
>> This switch statement does not scale. Adding new flags will be painful.
>> Can flags not
>> just incrementally be printed as learned from hardware with "_" printed as
>> last resort?
>> This would elimininate need for these "ASSIGN" flags.
> 
> Let me try to understand this.
> 
> You want to remove switch statement.
> 
> if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
>     if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0], rdtgrp->mon.rmid))
>      *tmp++ = 't';
> 
> if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
>     if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1], rdtgrp->mon.rmid))
>     *tmp++ = 'l';
> 
> If none of these flags are available, then
>     *tmp++ = '_';
> 
> Is that the idea?

Indeed. Thank you. Can this be done without hard coding the counter index?

Reinette




