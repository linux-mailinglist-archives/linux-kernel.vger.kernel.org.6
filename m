Return-Path: <linux-kernel+bounces-422915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF689D9FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059FDB23DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BE1DFE29;
	Tue, 26 Nov 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwO4T39i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B808BD299;
	Tue, 26 Nov 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732665386; cv=fail; b=dqzmzwMmhoTDFXxLsCjUSLhyfUXjlohzj7qHCoeKtW8u+veO+i8nUlt4yH5cKZqo1Ln0/C06fc7Mmt4scFGJjPj6c+z2sEwQfZgOh1cQKCwbNzGvfO68TKUXkUhj+5GH+nm+Xq3N8IxXO5Mtikf2HBTDh7xHrYBbICCw1kZBL/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732665386; c=relaxed/simple;
	bh=rsHBHVtkFvNjYMp/HX5C3i3rwg1aFZaPl0pRyNiab38=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpoziqcssjmlKOG+Dz7tiGJjpPCNTjmpnLa2WXeMakiQuWO7litVxXsVheh9UIX2g3cRe7mqmIYeGl6GHKQbLfc6Q1nA6BiaiIUAdBL2zb9jm7c87IRXpADd8QyDvx2zfQDTwZqgO1gSYe2U092SIF9AYL3mYQlL4lbLZw3GLJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwO4T39i; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732665385; x=1764201385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rsHBHVtkFvNjYMp/HX5C3i3rwg1aFZaPl0pRyNiab38=;
  b=nwO4T39iWgrItEPfSW7JlXxriKB8vyG0V4zCeUzpUqs83MjR8UpXFFlQ
   uLn6RJifaPgLn1XN8bB1E8nWB/8xgoofh0GWsOGL+cuTd40/SdOpOKF6/
   hwJBPi4vvZxW927SpUVTu7gd/B/YCn7wFT+1GzufGNLZrQpwm5i5I7+zy
   MqB7hHaH57OwYNhFNu8Sg0ow81r5MluIKDdx4+pwTwdnkAgQWZcrRJ+wg
   NtqxMaLCpin9JIEPbMhMB/eEUC5E3k/4eNi+scmfl48ZDHKoc9qRHrDlh
   pVlkLgCXmqXUdDF9u+gN2IEAaX4hbqXIggp2lBQnHXuVfwmWdgtSPc3V4
   Q==;
X-CSE-ConnectionGUID: PRlEr5ezQzmAuxRKOdwWuw==
X-CSE-MsgGUID: iT5eDfHmQ6aRyLX+ecEQDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="50255594"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="50255594"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 15:56:24 -0800
X-CSE-ConnectionGUID: Xe8XdKzhQKiKIjlqpPI32A==
X-CSE-MsgGUID: rFcVxDcdRt6Gvy7UJwcQqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="122607424"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2024 15:56:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 15:56:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 26 Nov 2024 15:56:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 15:56:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj8/rU7oStrbzJOrg702MVT2HUNjM5WzpznRWn59a5953GrqUXAlD/eXe7c2Bg3TbEIxU6+st+YmLIEJjY+GbTnjFFy8HAO0Z5+jmZIu8FLiWAFpDcEm+Bk6w4yxW6gGTjs0a6lf69GmqmsNYrdZwcZgnErqaQWCgKSe0EmZ+rFdfpTXxza2RAs3JzPTIPWLRnR4uyzQROO4g3niCDOS/uLsQq5jl4QClaSQfHcW6qwz//X268jcuU/UViVqzU0VUVoLXOQtqFVVG99BBxt6fX98wCao6bMKrumWtavE8AqYtHS+iT6WjvrCNghJXRtEWLPc4hoZQCgBmrATcMKQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRBqHuI2nr1nt9mU0WgxcxBrqPK3zLbyIDvwdna5GAY=;
 b=GNt2lmEgJjWDUXhsS5+UGW9oLDz7A2q6JnyUFHhKM6N4lb/ImTFZSCy5CH+jSAUaT4QpUeTLxBXfUU9Tc3P3DIhYNpmACjKi4MshDl3fre/TSzDNAX4OTITBMV4OPRj92k7DgJR/ydeacvywzPRyGU5RbMjyPRQO3GMCVbJij3oBaqqjhME18RalRIsnr3GW66DPqx4ZPpTEudWltELGA9q6WtjGVa5FspGwlomSxqg/1MnixiNnvMBh6dDETcK6sxv8+T4oWDwfTvEjkAgaP9jmqtK8B/Ijjd4EXBWEalOejD8EfTezX/UxTi2DKIg/tlJXLTewDBpqGeqLkra6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6512.namprd11.prod.outlook.com (2603:10b6:930:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 23:56:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%6]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 23:56:18 +0000
Message-ID: <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
Date: Tue, 26 Nov 2024 15:56:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>, <jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <0dc08082-0f3f-4acc-9285-b925a4ce3b02@intel.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f28b19-e27f-47e6-d987-08dd0e75eb64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clpGZ25OSUx0MytuUVJGbU01elAvUkl3OTNUc1RrNHlMR2RWN3pySEVpWXJj?=
 =?utf-8?B?QTJqN1RhWWRrZGNEbzJBVDFmbHc2eE1sZjlyenhTT29SWUt2cXh4bEhhcVJ4?=
 =?utf-8?B?a1JIUDNmUERGeG55YlZRVHFKZlFORkpvbkM2VlAwbktmdWJ2Z1Vob21SbUdj?=
 =?utf-8?B?Tzg5djFCWm1kNGcxdlUvanpzaFFJTmI5cG52eHJHM0QxQTlzbTlIOGdOM203?=
 =?utf-8?B?TU5mVUdUSkE2YXFSMENCWkF3YXA5K3pIdGl0cUNDdnFwZ3dFK0VrL3FzTVBX?=
 =?utf-8?B?SGc5R2tkdzRoKzQ3bk5PMUljN1hya2JTRU9idFJnbjFOcDlKMFpjTHJOQW9Y?=
 =?utf-8?B?Rk1wdk9TUWQ1ZGJQaW5idmI2U0R2WnBiQXp5TTgrTHlCdmpKRFNRVkFGWjlp?=
 =?utf-8?B?UmRyaUNyR3hYQkFRVjVrMERUWUNYcTdBb3Q2TWdhaWREVFVIdnZPaFEwU3p6?=
 =?utf-8?B?d090cTh0eFhXczIwUG5leVdGalBMZ25MVnVCNnBFcklPYmFxSWxsa2xubHFV?=
 =?utf-8?B?Y2N1aXBOVENiWTBzdFRVUEtlcVdZdzBCdmRnazJmamVkYUZNL0ZYVFl4WnZj?=
 =?utf-8?B?cUw2WU9jUTlzOGE4Vm5kZXBicUNXRHp6a3VZY084aUFXUWo2azBFR1JoRlla?=
 =?utf-8?B?cmNEcEZ2UFY0cXJoK05KNzdJbGg5aG1SYURxNVdJQ2dOcTdaUEpHd0h6alh4?=
 =?utf-8?B?Z2dIbnpFMllKNEpJY0VYeDlTT0RFSzdQYnA0U0MxY3FwaERoQllJbTY3UmYx?=
 =?utf-8?B?M01vZExtd3ZIckp6Z2w0bWk3THVrUkV1N3ZLTlYzdGphaDZHK0hMVFVvSnJh?=
 =?utf-8?B?ak9GNmNvckwra2t5MHFYZ0NkRzBsL25GS0lGbTVPLzRsbGxvSkg4VUxsempG?=
 =?utf-8?B?Wk5Wd3hZTWE1VllqTVhNUDBqMEJnWFZKRmdNRldOcC92QU41WEx6eEdlUG9C?=
 =?utf-8?B?L1RycnZzeVdhRTA3UmJSVEJEcDBaZnpycXlBZWlMaE43TnQ3SHNxb2ovcUJr?=
 =?utf-8?B?UkdVd0NaUmozOW56eXBQOHdCcDQxVThQSGt5YXViQXVSd3U0a2Ntc1JLMTJK?=
 =?utf-8?B?MWZmQThqMUlCRGVpNkc3bjdISTgvQ3NGczlDQjZzajFQcXM0c0c4bnJTckdZ?=
 =?utf-8?B?RGVXOU4zTFZoUU1pSTh1RFNVTWg4dUxRSTZMcmZiZFQ0RXBNY2ZWdnFFKzlo?=
 =?utf-8?B?TlNTZy95WnVpMnZoS2FkNE5lcEE4ZGVmUGRHZ2F0UUdrbnQ4VWdlTFA2SkFS?=
 =?utf-8?B?Y29ZeXZEK0U3RC9tU1UwV2hoNEMvRnlKKytvQ281SlZBMWZ3VCthVERWbEVr?=
 =?utf-8?B?b08yaCtQUFlmQkEzRWpEaVFOcUtGZ3FHWlZRbFhMdXZPUnd2b0t6M3hwZXdF?=
 =?utf-8?B?cTgvYkthbHBtUGtQSkRkc2lLcVhFbWNwcDhsOHZnaVVEQnFYMHBKQnV1cHJu?=
 =?utf-8?B?c3I1WCs4TVRyV1BuWUI0cDFvZEJKWjNCMm5JMHlSdDYvMzBsSWdHbFN0L1pG?=
 =?utf-8?B?VmVjTU9MZnZiQWJWajJjUnNiYmNzTlFxZk9rY3FrbXRtSWoxVjAzOXhqbGI5?=
 =?utf-8?B?VGNHRnFOQkw1eFpUVUtvVm0zUURWOFNnK2ljbktITmlDR2Z6czNRanB4NG14?=
 =?utf-8?B?OHlIZUFBbGZMSG5yUlhLbVRIbGg5MVY3TUVaMW4rdm4yV1ZmZUVGSFhiS1Fi?=
 =?utf-8?B?M3pHSE9aQUZQRlJjK1pIbGlMSE0zOGZIVDNNTVZkNDZLS1NXR1h5Rk9WVDBI?=
 =?utf-8?Q?+Hc801Ee0pHbv33yt+mU2G9KEzy678K+R/FtSPJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG1ObllnOHlRVnlWUGpiQjZrTitFY2JGTlQ4cERYNjFJeUZaN09MaFBNMmdK?=
 =?utf-8?B?T25Wbk85NUdRU2RpeDZiVXFjNFdSUWlxYmhQamVSYUJjUVVSYm5NT05TRjhh?=
 =?utf-8?B?K3g1KzBPb245RFJ6V0RsRGkvdlA5U0xmRVlHM2FaMHBNOGhGdkV1TStZZDJU?=
 =?utf-8?B?ZndDU1dtY2F5ZEQ4ODAwazNNV2JVYkNVc2IvRjNROXU5YnA5UmZWbmVKaVJ3?=
 =?utf-8?B?OU40Vnk0U0FFNXhzbU1OZi9Ca09VSVZab2w4RDF4bmdTWU84U2tmc2RBTVdT?=
 =?utf-8?B?ODlnRmd4eGM1WDh0SlUxa2xhSG92aitYUHBwRUZhN0xRd0FRMmV5T21ET0RO?=
 =?utf-8?B?VTlxN0tlUk1JSzRFL08vWDJoR2ZUTU5QZjJvakhhU2Q0Sk5TeG9YMFhMLzhS?=
 =?utf-8?B?MVRURVd1RWxlaGhYUTZFN1hMZUh4VnEzUitzVm1SUUZEOWplOW1PckMwMllJ?=
 =?utf-8?B?OUNyclVZSUtYT2hjWnhta3FpZVRyelJONGFhSDR5RHRUTW5uL28vaXVIQ2VP?=
 =?utf-8?B?S0hjMnptYzR1dU5GeGRPbGJEOTNMNFozYU9OWFI2NHNjNDYrZjdiUmhIUThO?=
 =?utf-8?B?QWUzOHNOOHlwVnFGbkx6eGtISThQclBwb0tBQnd6d1p4NWNEYmdvbW93L1Rv?=
 =?utf-8?B?d3ZPY2hlU3JRU0FQYTdIYjR3T0M1SFFIQnQ3b1pKQWpGMDZnY0JHWk9Gd1VX?=
 =?utf-8?B?eTEzSGpkMXNrQmlZVkZ6d1dKV2xBdEhJSFRLRlRCaWsvRlJuRnVtZUgwT0kr?=
 =?utf-8?B?c2g3NzZnYTV4QSt4VHplVzRJb0gyTUlsUUtGaXp6RWM5MWRFY2JZYlduREpk?=
 =?utf-8?B?WnNObHl5TXk1OXQrRFRDM2Y3d0o2SHV1c2VpaGk0V1NWQTlCSE5HblhNNVg3?=
 =?utf-8?B?Vk1QK2hzb2lJVHZaVWlZU0NZRjl2VEtncDVFNnFPZlhrK1VTaHlpbzRvbCs3?=
 =?utf-8?B?RElqUEVQdWIxMWM2WldycmV0UE1QVUFURkFGclRSSllDSGZITXlQQUViVW5R?=
 =?utf-8?B?YVc2Q2FsdlphMTdNeVI2QWhyemNPSlJWRm9OQjUreXlqNGVTY2cvWmFEcGpK?=
 =?utf-8?B?SVFFMnoxdmkySENxNlB4dHRqYzdWVnZGSkV5WU44SkN1YkhSZXJ5MGVxc1oy?=
 =?utf-8?B?R1JuSnNMZE5ESVV6TmhEQzBLaVFteFlNcDA5b2I0S2JWeVVsUDFvMXNXeFNL?=
 =?utf-8?B?T3ZrRnlOMTdNamJyRmxvV0poUjIwQ1RPRG1Ga3k0UEpyS2UvcTA5TXRqeGJ4?=
 =?utf-8?B?RjRTTHhZVkJLVW1HaVYyM0NVVElHblpjYnNIVFlqT3NaOVVuSHdFWFV6U2ZF?=
 =?utf-8?B?MklxK2FiVWVoMmFQZ1NZV2NlTE90Vm9sMFJ6Q3NtR3ZVU3Frd2syUTkzc0ZT?=
 =?utf-8?B?Tm9ZOWtnS2p4dXJURVduUFA3RUcyTTJKSE5iSkVNSER1bHAwcE9EQU9pMGYr?=
 =?utf-8?B?Mk41TFJIQkhWTk9QZmpOUEgxaFpUMjV4ZmkvUXBQaHlIK2x3VTN0WDlwbFpl?=
 =?utf-8?B?Q1ZKVVI1cElsM1c0d3ZYd3RCUVZQbXJ0c2ZBbHdrMWs3MWduZmJGRUlLSk1C?=
 =?utf-8?B?cjhJQXhzcW90MFN5VXF0ZHlCUk1NMTFrYUZBYWpWRThERHVyR1lRSVlTNVRa?=
 =?utf-8?B?M3FKSzVYVUV5RmNCbG5ENURjZVBVSzMzRFFNclN3NlRtU2U2aGo3UXJqdTlt?=
 =?utf-8?B?UjVGL2dpaWZpR0VDSlJ1bFBBTVRHRFgxV21abGpVS2c0Zk16TnRMU1QxYklL?=
 =?utf-8?B?cUxjUWlpaWltOGZEbjd0bG9aa1MwYjVEVHNKRDJ4K1lmbVFFTGxDcy9NL3Vr?=
 =?utf-8?B?N0Y1VklZSEdpNjIxNDJ4aDM5dnh4UmNhZC9pRzU3MW9WK1BnOFhKMWVPNVZi?=
 =?utf-8?B?eG9HSXBOWlZNMnJkUFZUTkhGZHdFZ3ZROEo2WFJUR0ZsNDRkMStrUnl0Wk5S?=
 =?utf-8?B?T21WTU05eVE4Mk1RMFB0MVp2cW9TdGp4RHBJeDJTWXhTQmdBSFl0T1lTUVF0?=
 =?utf-8?B?bnEwRzl2YnZMN2tqK3hOOGkxRDhoNEthVWpCWlFyZ3NTZHkvem43VFluVDFh?=
 =?utf-8?B?cDR4azVGTnd0TFU0REZnT0RUUFVXYVphM0k2TXlDbXlsQ1BDelB5R1dGNEpE?=
 =?utf-8?B?WEF1bE1lRjVNbjJ0c1pEZE9JbGc2Um42aFlFQ2NuVVZLb09iY1NNNW8ybEFv?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f28b19-e27f-47e6-d987-08dd0e75eb64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 23:56:18.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjTScKZ0NbPH+eaQdejiVBL7ADlMzeIPniclAkNP4UxPAupY29ughtknqI8DlObd0DXg7Np8N5oUEuMNqwBBkqPQbRNyE6V0sr5KImrS/qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6512
X-OriginatorOrg: intel.com

Hi Babu,

On 11/26/24 3:31 PM, Moger, Babu wrote:
> On 11/25/2024 1:00 PM, Reinette Chatre wrote:
>> On 11/22/24 3:36 PM, Moger, Babu wrote:
>>> On 11/21/2024 3:12 PM, Reinette Chatre wrote:
>>>> On 11/19/24 11:20 AM, Moger, Babu wrote:
>>>>> On 11/15/24 18:31, Reinette Chatre wrote:
>>>>>> On 10/29/24 4:21 PM, Babu Moger wrote:
>>>>>>> Provide the interface to display the number of free monitoring counters
>>>>>>> available for assignment in each doamin when mbm_cntr_assign is supported.
>>>>>>>
>>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>>> ---
>>>>>>> v9: New patch.
>>>>>>> ---
>>>>>>>    Documentation/arch/x86/resctrl.rst     |  4 ++++
>>>>>>>    arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>>>>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>>>>>>>    3 files changed, 38 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>>>> index 2f3a86278e84..2bc58d974934 100644
>>>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>>>> @@ -302,6 +302,10 @@ with the following files:
>>>>>>>        memory bandwidth tracking to a single memory bandwidth event per
>>>>>>>        monitoring group.
>>>>>>>    +"available_mbm_cntrs":
>>>>>>> +    The number of free monitoring counters available assignment in each domain
>>>>>>
>>>>>> "The number of free monitoring counters available assignment" -> "The number of monitoring
>>>>>> counters available for assignment"?
>>>>>>
>>>>>> (not taking into account how text may change after addressing Peter's feedback)
>>>>>
>>>>> How about this?
>>>>>
>>>>> "The number of monitoring counters available for assignment in each domain
>>>>> when the architecture supports mbm_cntr_assign mode. There are a total of
>>>>> "num_mbm_cntrs" counters are available for assignment. Counters can be
>>>>> assigned or unassigned individually in each domain. A counter is available
>>>>> for new assignment if it is unassigned in all domains."
>>>>
>>>> Please consider the context of this paragraph. It follows right after the description
>>>> of "num_mbm_cntrs" that states "Up to two counters can be assigned per monitoring group".
>>>> I think it is confusing to follow that with a paragraph that states "Counters can be
>>>> assigned or unassigned individually in each domain." I wonder if it may be helpful to
>>>> use a different term ... for example a counter is *assigned* to an event of a monitoring
>>>> group but this assignment may be to specified (not yet supported) or all (this work) domains while
>>>> it is only *programmed*/*activated* to specified domains. Of course, all of this documentation
>>>> needs to remain coherent if future work decides to indeed support per-domain assignment.
>>>>
>>>
>>> Little bit lost here. Please help me.
>>
>> I think this highlights the uncertainty this interface brings. How do you expect users
>> to use this interface? At this time I think this interface can create a lot of confusion.
>> For example, consider a hypothetical system with three domains and four counters that
>> has the following state per mbm_assign_control:
>>
>> //0=tl;1=_;2=l #default group uses counters 0 and 1 to monitor total and local MBM
>> /m1/0=_;1=t;2=t #monitor group m1 uses counter 2, just for total MBM
>> /m2/0=l;1=_;2=l #monitor group m2 uses counter 3, just for local MBM
>> /m3/0=_;1=_;2=_
>>
>> Since, in this system there are only four counters available, and
>> they have all been assigned, then there are no new counters available for
>> assignment.
>>
>> If I understand correctly, available_mbm_cntrs will read:
>> 0=1;1=3;2=1
> 
> Yes. Exactly. This causes confusion to the user.
>>
>> How is a user to interpret the above numbers? It does not reflect
>> that no counter can be assigned to m3, instead it reflects which of the
>> already assigned counters still need to be activated on domains.
>> If, for example, a user is expected to use this file to know how
>> many counters can still be assigned, should it not reflect the actual
>> available counters. In the above scenario it will then be:
>> 0=0;1=0;2=0
> 
> We can also just print
> #cat available_mbm_cntrs
> 0
> 
> The domain specific information is not important here.
> That was my original idea. We can go back to that definition. That is more clear to the user.

Tony's response [1] still applies.

I believe Tony's suggestion [2] considered that the available counters will be the
same for every domain for this implementation. That is why my example noted:
"0=0;1=0;2=0"

The confusion surrounding the global allocator seems to be prevalent ([3], [4]) as folks
familiar with resctrl attempt to digest the work. The struggle to make this documentation clear
makes me more concerned how this feature will be perceived by users who are not as familiar with
resctrl internals. I think that it may be worth it to take a moment and investigate what it will take
to implement a per-domain counter allocator. The hardware supports it and I suspect that the upfront
work to do the enabling will make it easier for users to adopt and understand the feature.

What do you think?

Reinette

[1] https://lore.kernel.org/all/SJ1PR11MB6083DC9EA6D323356E957A87FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com/
[2] https://lore.kernel.org/all/SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com/
[3] https://lore.kernel.org/all/ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com/
[4] https://lore.kernel.org/all/CALPaoCh1BWdWww8Kztd13GBaY9mMeZX268fOQgECRytiKm-nPQ@mail.gmail.com/

