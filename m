Return-Path: <linux-kernel+bounces-333696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8B97CC82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505821F22AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0441A00D4;
	Thu, 19 Sep 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP8zNxBa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141617555;
	Thu, 19 Sep 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726763299; cv=fail; b=ALrOOwSsiQHwaEcmaTRyPFpGCHZDiNjpTwqb96Lgf7tQEU3AffimZZGNy8jgrL0/lreM9y2jVwW3yfu2XYg8aqXX+3LPBsfBGGm1IWj9cz2qsytuzhcol5wI8OJbiybSJGRIgxrAtZ9jBh3zT+JFMBOMy0AH+G3oKnWQJLXHzhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726763299; c=relaxed/simple;
	bh=jda+Xcaczl3qYYmv+21ILolP6eF7K6XMLj9u/m2sKEM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KzYQ6hxKTsDORWttqiMOyv/o0umhIni/ZaqCUqvpNd3ZZxWxfH03mb75m857Ki8rZS9H5NT4PIGk8vJVhCDUOnvhVz7TW9h9lh8jwrYWMiHP6aMADJuwP1WV42LcaVRfcb4vT61c52EWq8W/0b5GgEuHuoK7ZRfYauzRqGcHV+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP8zNxBa; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726763298; x=1758299298;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jda+Xcaczl3qYYmv+21ILolP6eF7K6XMLj9u/m2sKEM=;
  b=KP8zNxBa24BB8ladlDPbfPEY3gx9WTXvGMEQTpWe5WrIWg3n6lG3j5Ok
   My0SzhN570feD3OhrGaBK5HJO8KoH6FIdQ8euwmrJ5GuTI0qFaiYXIujL
   dgq5UAUPUI1dyDROVEoWuZi9LuF0hG07xH4UVIM0AoRUEy0RoSpWkwWcG
   H7LpGV1JPkKh8HRYoJzRB9nsYfboKqKtPTzOTyPx99+MLst/obe+3btR4
   YoLveXLjsDYMSKpIACiokVZ4YS87/A9yt4GFAtJxo0iVmUDWGP+ykiASh
   2/fh7AL3fNej7qKYSyeLMecd6qrif8wSDjJPptKU/rlw0g7EWm8BnVHDI
   Q==;
X-CSE-ConnectionGUID: V8Jglc0oRy6oJx6XLWh6Ug==
X-CSE-MsgGUID: 9kX46Dq0QCmYSK55RzXNzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="37120731"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="37120731"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 09:28:11 -0700
X-CSE-ConnectionGUID: P1pOj3puTuaKerhxT8bIJw==
X-CSE-MsgGUID: ckNN5nFiTpSv2ebd9afovg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74530724"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 09:28:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:28:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 09:28:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 09:28:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 09:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHd7DsvzBDEssbAlH29FlBfDyG875Fu2gAAIZMPeYeIiBFs+Kz2wEnlTzb9IFf3H4dA1nAzfITSRTZugCPWugyqg8764M9ur+gl1bA0Q1EedALxFOvXkawrSORQv8657zq7BvaXBwKdDakI1zaCBGe2lSk/ODpXFwyKT6BqiY91zUDhePIw4mB6y1CsmBUsGMhfa/5m/DnlD8CYUeFe+gpmL78Mh4v4SHFRVF4nJ18lbL7lnE/tjfliGTrSyg3Ngj9hOUnBzA31fdZ6N6PYgmVxN/N86vXnT8YQVk/rQdRly7dpVgmbUqUsBZvOWNxWDqxxKOtzVYYSyLRgG4qWJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLJl7GAclaYDXiit0VTH3JwAab/DZ4BF+EcnO+p8S4c=;
 b=Xukbqjsljv79EU/qlRuvf0WgBktaOFR9mi3bnaEDqLKfBMaqThoGgqDfu/bkOEjA/VsWt3RARf6ZLcX2uytvloFbadh843++9gXqE3zqOMX93JXGtTGz/V7SLKqfySUil+x1MaTL5joT31RHCfLI01AwRt3O08x2poRlshQTKuf0ifv7keXfx5+OaWvtxnCL92swWoVKwT00Pv2z4vx3Qz0nJIzz+T0VBUg3jlhvZbYlBo7v6qeh9ACVfHlm8n4FpSuWo/4Ig8RPTcUaQaOHhgf5IB5wxc9xN1o7UEA/Fv/o/JUx3JTtQtjKksHcnBq96tH6zw848jQdZdr/u+5UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 16:28:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 16:28:03 +0000
Message-ID: <e848662b-23ee-4c3c-a848-976f944e8927@intel.com>
Date: Thu, 19 Sep 2024 09:28:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/24] x86/resctrl: Introduce the interface to display
 monitor mode
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <e3ff30d647ab9bc452c882ce1dfb366eabb0cc25.1725488488.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e3ff30d647ab9bc452c882ce1dfb366eabb0cc25.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 003971af-baca-4310-8dbb-08dcd8c808fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWVQL1BIUU5aOFptbmJlQXpaelRtbUZ5Y0lKQTlNUml2dmJoNWhSMFlqTVVa?=
 =?utf-8?B?a05IUzBFb05zbDFJOEh1a1Y3bnRLbWF1dHcvMXJWeU5RdHhRYUR2S2s1RU5Z?=
 =?utf-8?B?c2hQbllHSWhzT1l4TExRWjloSktPL0M4Y2h2Vy83UVhEL2cvaHF5cy9ZUDNO?=
 =?utf-8?B?K2ZTcWpwdGhxVktSZGVWSG5ES0dHVzFJTmx6ZktZajh4NnIzdWxDbndUNy9j?=
 =?utf-8?B?cjNIaHlnTWFFMjgrUWNma1JpMGxFN1VrTS9aZml4YnRMalkwWHh1N1psdEdD?=
 =?utf-8?B?ZzlHTUVrZnlIelJ0aW9VclVYbHhFdVRuQWU2WHFCTWtadWM5OFNTcCtyOFkr?=
 =?utf-8?B?dUpOdS8xaU5qdVdORlJIV25VSWpZN2ZBK0dOMFQ4aTdlWkR3R1V4Q21nSlJi?=
 =?utf-8?B?Y0QrV2RUS3RIc3JveFVjd0pxY0lBTUxsRlZNTndkcmI3ZlNWYUtmS0FhVitO?=
 =?utf-8?B?Tk1NOXZpRFB6V3YyS2RrVEV2WDcxYkVBUDlHS3d0TDhaOWpWN2ExTWl3SkR2?=
 =?utf-8?B?VTBEV2R4dXllMzNDM3NNcU9FWTFvT2d6R1YxcExwTU8wVmlqRVBGSEFTY2dt?=
 =?utf-8?B?Y1FlTTZ6QmhlRnZYUG9KclVCN0IwZXp0ZmtIK2FqN0lhY0RRWjlKZG8vVUNm?=
 =?utf-8?B?QUhUM1ZTcXB1VFZNVFozRS9MYmdDQ0R6WkcyaXorL04wdmVjVWFzSTlXUU56?=
 =?utf-8?B?aWIwUHRoZTM3VmgrZG1YalZUQ0E3eDJjTE1nR0NXUzhieGxJNG9rNmhkNnUw?=
 =?utf-8?B?Z2lIUkhRWGJWaGREWnBycjcvMkZQQUJXN2dNd3cyWllRVG5kUlg3cjc5WFVE?=
 =?utf-8?B?cEtCZ29NcXV0SkNnSDUyMS9QYlRHY2p4OXcrZDZBTHMxQ1F2c21lVVpGM09U?=
 =?utf-8?B?dnh0R3h4UWo0Skk0T24wYWFnQUJsWElHZ3R4TXA1eVgrb0xDK3UzV25NV1ZI?=
 =?utf-8?B?dFgzREw5VDB6d3FhZll1QVRtejh1SmNydTlOd0FtdVB4NnFwVDJlOVVYQ3Nl?=
 =?utf-8?B?UXlXTTJCbWcrditvaFlUK2JXUFBuSlJXWEdnWC9rRllDV3hZeFMvVDFyb1Rn?=
 =?utf-8?B?SHJFRXROekR4d0FvaFB6SHM1NzdzSEJnNzVSMjl0NktKMXNaT2N0UlZFK2JC?=
 =?utf-8?B?a3NRZDdEcDEzbG9mMDBaSkwzR3B4cUZCN055TElCM2hqUDhSNC9GOS9sTmxw?=
 =?utf-8?B?b1lLL2w2dlh5NGtEMXNOU2phNlVKSjlQQ3gyNit5NHk5bjVNY1d1YVVTU0R1?=
 =?utf-8?B?dEFzdE9rVnVkdFI0THcvVEw0SzFyajBBTlI0V3hTdldFbUNibHpybFBLdW9o?=
 =?utf-8?B?dDhyTE9JQlBTcytCVVl6TEM0NzdQaFR2dVRyKzNBWldlalIxWUtTbEVjRHBT?=
 =?utf-8?B?YkRHRUFvb1o3QkcvbUxYSDZNSWFqSlpFTjhyZUZqcVoyUXpyZEVyV1RuL2pR?=
 =?utf-8?B?R0w0VGtPdllrcmNCT1pFTm9CRkVrVWR3TzAwUHo2Rm13OGt4dUJZMkdrd2dJ?=
 =?utf-8?B?WGk3VUtPOEFiWUkrOWxnMmw1UGZCSU5DdU1kdlZsVzBsRkdmZGpUbkZmSDFy?=
 =?utf-8?B?dEd6dWlSdWhubXhyMFV5T3h5aUhQRmVYeWpBYWlCeDF2NUpJNzNzMk8yM0ZP?=
 =?utf-8?B?NHhBOEw2clpYZGN6MXdtN0F3ajVPeUY1U25lV042czduSVhQWTBITjBqb2VO?=
 =?utf-8?B?Z243NGZSdFBGcXdzTS9rcGd6SU9MNTlyK1ZPWmgzRjBtTlhWbjlDWXB5OGo2?=
 =?utf-8?B?VllDcUU0NXFURlhZTWFzOUJ1MG16UGNYTjNyb0lGRkJqQjFtWXB6SkxSRXVY?=
 =?utf-8?B?UzN3cG55MDRwQnNMckNMZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnIrdmxZSUVNUTEzM0ZOa2ZmdnlOWmZwbkEvcnlUelYzQUhobVRPNExtdWNy?=
 =?utf-8?B?TXRqdTBtazhDcHhNVW1qYnpvSDVleWpuUWlkckZzSDVQc01Ga1YyVUdvR3J3?=
 =?utf-8?B?MzB3L1EwNDI5clRUU1hEM05DQVRGdnYyZkV2VHZ4OG9QWG56RkZiNlYvS2oz?=
 =?utf-8?B?Y2M1TW1KcHNSTTgxOXI5S1dWVzR2dDJyeEtqZFQ4TDRZSWFRZ3E3bkc0UzJq?=
 =?utf-8?B?bzVkbFJVUFZPV1YxT3I4bXY2NUxYTXNuUXljVjhTL1ByTGJydHdMUkcwWE1X?=
 =?utf-8?B?eVVnT00vYUhMeWpVUFhINmZScmxyUTRTeWM0TmhHVHRtMXFmZ1ZIWHIvdmNs?=
 =?utf-8?B?SjI2T2taT0FLdm9pOHZVSVVEaWZKckN6L2ZhMWVNYWdHWDNRMDBUZ1JmcHBm?=
 =?utf-8?B?dTJXSG85MUFxZmxOaDcxUU8rYkhEcEZEc2tNNW1xU1lDR0lJRXBCRm5kN3B2?=
 =?utf-8?B?RDJVOEVzeXhQM2Jla0I1Ry82YS9jWFJzM25VVlZtRDFseGRud0w2YW9vTFU5?=
 =?utf-8?B?N2lSVDczYjlrYm5jYzdRZ3I2T05UenRLc2I5cjhQMjFwaElDTk4vU2srMWll?=
 =?utf-8?B?THZUMUpxaFJvZGFnd3FMRm10LzRoSy8zUWpWL2JXUDBLL1EwVW84WURHaHgx?=
 =?utf-8?B?OE5IVjViQVlSclVJZlVrQzVvOVBJWUdGbXZOWGtZaGJTSGR0ZUpyOGJIM09S?=
 =?utf-8?B?QlBIWmdtcnlVbDhubzV0TmVsNUN2N2VjZWVxMkNtVGl2S2ZCU0J0dVE3dlkr?=
 =?utf-8?B?MjZSU3lmVlk3Yjkwdmw1T0I1akhaeDlPLzZNK08xeDlyUC9BTDl4NGVGRG1u?=
 =?utf-8?B?WURRcFVERCtJWVlwTUlsMEt2cTFhdm5iOUZkYkV5ZDl5dE40UGpiTlRrN2hC?=
 =?utf-8?B?dnErY0l1d3lnclBQUTZhbTA3REIweHR0RExEVjJYTDBoOUIzNEp3Z1AzTWtT?=
 =?utf-8?B?c3h1MGpFTVB5L3BmSWFlQkZSYllURWF2TFpWekFGZ0hScjIrRlU4SGdmNzQ1?=
 =?utf-8?B?dGN3TnJIOHNTTFdqei84T2Z6a3MyNDI1RXBJVnpCZzFjc1A2Wm9nRElWcG94?=
 =?utf-8?B?L0FBT2U3dTJ1ZHpWZnZiSVgzVU5CYU5heXc2QTI2OUk4Q1hIcUFyelJhTUli?=
 =?utf-8?B?S2lpTXhWRG81WkdhemFUdHBpL3dkVGhQVGxGaEgyMjB5R2pWVlU1NHdsbllU?=
 =?utf-8?B?ejA2Q3FlRjJVdWRmWU9LdUhQU1JXWmoyVVhwRmpLVU9mT0NQelVZelBtUnF6?=
 =?utf-8?B?N1EvRGs4SWcvSndpbk1LR3hya3lja3dnVGpPdHZ2aHQyTFJDN2dhY2tVL1No?=
 =?utf-8?B?N2dhckt4Wmw0bzJPRzFmenV3cG1STDlIazFadzYvL1o5c3hPVmlRMFYzUzg3?=
 =?utf-8?B?MkcyRFFFOFVLc2I4Y3dJODhWUU9IVUJLVjg5d3MvdElYdVdodHRrOU9YUjY1?=
 =?utf-8?B?VlFPQXpPS1E0dzd0ZXZ4M3M3aEdlSmI2OS9FdXR2eHkwRGRpTWtBeW9sd1Zs?=
 =?utf-8?B?Y292Y1JrR1NJeTJadTA1MVVuTDlrL2F6WjhsZUtKOGJFR3oyL3JROGlWenR0?=
 =?utf-8?B?SEJtVEdOU0tScFVJZFNRVG1YY1U0b054NlJUU2h0cUxCM3R6WGVYeHB3S2Zl?=
 =?utf-8?B?WjNHVm9uMmZBOHB2OXdCMG1oMTRZbXJkWkpzcFNUNVpGemErcVhla0ZqaVVD?=
 =?utf-8?B?QkFqS3FTSXNzTlFrUkRlYUxUK2JnNkFBbFpidTdUMWFWMnE4dTRVVXNJUFhC?=
 =?utf-8?B?cWU5SlI3akg2dkVzSndkR2RYeGE1Uy95azBFNnRYWko5cXhGQWp4RGRMVE40?=
 =?utf-8?B?aGlLMWp5VkxGdUNDaDJ5YlR2MFBRaE0yZkRxdFRkT3M3Q0dpVEs3a0NXUlRT?=
 =?utf-8?B?Z1U0Z05weFplQWNBRG04dnVRRGRXM1BHRlpYQU9QeFVhdW95aE1EOGRxM0FE?=
 =?utf-8?B?SWducCtURmRXYlh0YjhKaCtDV2V2TDhSV0hyT0lWaHZxd09QZVhJQTFKODBY?=
 =?utf-8?B?bWxuS29VU3N3ZlAvMUpXd0lHd3FmRHo4T1M4dUE5RWwrN2dxWW5nU0tmdEdV?=
 =?utf-8?B?SUY3QitIeHNSV1BLcTFvS1V6SmF3RWp3ci9oc3Y5bE5ETkliNVpWMFJKNkhQ?=
 =?utf-8?B?YUpXUklQN0hmV0krMmNycFFqS0xLYXRzNnJIQUxGM0pNb2FlZW5BcFRmL2Q5?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 003971af-baca-4310-8dbb-08dcd8c808fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 16:28:03.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPzRCcWlaWdD1ytBR5M1ipDMXSD4a/I2Fj7rCnrlBW3lfygW/nw1D+qCEgpv5IFDsgLh+ELsbnLUnkQygkFBft5KZ1TP8wZuI2ZbHrPjLBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> Introduce the interface file "mbm_assign_mode" to list monitor modes
> supported.
> 
> The "mbm_cntr_assign" mode provides the option to assign a hardware
> counter to an RMID and monitor the bandwidth as long as it is assigned.
> 
> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
> Bandwidth Monitoring Counters) hardware feature. "mbm_cntr_assign" mode
> is enabled by default when supported.

As I understand this series changed this behavior to let the architecture
dictate whether "mbm_cntr_assign" is enabled by default.

> 
> The "default" mode is the existing monitoring mode that works without the
> explicit counter assignment, instead relying on dynamic counter assignment
> by hardware that may result in hardware not dedicating a counter resulting
> in monitoring data reads returning "Unavailable".
> 
> Provide an interface to display the monitor mode on the system.
> $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_cntr_assign]
> default
> 
> Switching the mbm_assign_mode will reset all the MBM counters of all
> resctrl groups.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Updated the descriptions/commit log in resctrl.rst to generic text.
>     Thanks to James and Reinette.
>     Rename mbm_mode to mbm_assign_mode.
>     Introduced mutex lock in rdtgroup_mbm_mode_show().
> 
> v6: Added documentation for mbm_cntr_assign and legacy mode.
>     Moved mbm_mode fflags initialization to static initialization.
> 
> v5: Changed interface name to mbm_mode.
>     It will be always available even if ABMC feature is not supported.
>     Added description in resctrl.rst about ABMC mode.
>     Fixed display abmc and legacy consistantly.
> 
> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
> 
> v3: New patch to display ABMC capability.
> ---
>  Documentation/arch/x86/resctrl.rst     | 33 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 31 ++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 30586728a4cd..a7b17ad8acb9 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,39 @@ with the following files:
>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>  	    0=0x30;1=0x30;3=0x15;4=0x15
>  
> +"mbm_assign_mode":
> +	Reports the list of monitoring modes supported. The enclosed brackets
> +	indicate which feature is enabled.

"which feature is enabled" -> "which mode is enabled"?

> +	::
> +
> +	  cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +	  [mbm_cntr_assign]
> +	  default
> +
> +	"mbm_cntr_assign":
> +
> +	In mbm_cntr_assign mode user-space is able to specify which control
> +	or monitor groups in resctrl should have a hardware counter assigned

This documentation should ideally also be appropriate for when the "soft-ABMC"
support lands. Considering that, should all the "hardware counter" instances perhaps be
changed to just be "counter"?

> +	using the 'mbm_control' file. The number of hardware counters available
> +	is described in the 'num_mbm_cntrs' file. Changing to this mode will
> +	cause all counters on a resource to reset.

Should resctrl commit to this? Resetting of the counters as implemented here
does seem to be an architecture specific action so this text could be
made more generic by stating "may cause all counters on a resource to reset".

> +
> +	The feature is needed on platforms which support more control and monitor

"The feature" -> "The mode"?

> +	groups than hardware counters, meaning 'unassigned' control or monitor
> +	groups will report 'Unavailable' or not count all the traffic in an
> +	unpredictable way.

"or not count all the traffic in an unpredictable way" is a bit hard to parse ... how
about "or count traffic in an unpredictable way"?


> +
> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
> +	enable this mode by default so that counters remain assigned even when the
> +	corresponding RMID is not in use by any processor.
> +
> +	"default":
> +
> +	By default resctrl assumes each control and monitor group has a hardware counter.
> +	Hardware without this property will still allow more control or monitor groups
> +	than 'num_mbm_cntrs' to be created. Reading the mbm files may report 'Unavailable'
Please be specific what is meant with "the mbm files"

> +	if there is no hardware resource assigned.

"no hardware resource" -> "no counter"?

> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0178555bf3f6..dbc8c5e63213 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -845,6 +845,30 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  

Reinette

