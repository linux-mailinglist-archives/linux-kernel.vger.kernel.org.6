Return-Path: <linux-kernel+bounces-368373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFFB9A0F17
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43431F21643
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE7C20F5B1;
	Wed, 16 Oct 2024 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfgYHQD0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377801384B3;
	Wed, 16 Oct 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094042; cv=fail; b=HukF3zUBgcz35Ru+eeXmWClZBB/LM0NiHeDDQNwjz8tEvEgoLJT9E5LFh9zQDII+R/LTuPyy4dvTgZR+l4+OUfiXob+1ugAcQKswp96c3VmLJVcIc0QdRgvXQ36z4w0I6Vpk/M8ZQKbzn6uNkWw6312hZIgtIyIWC3wucp/ZVMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094042; c=relaxed/simple;
	bh=GW/6LwKitN+8yWHeh4iyh0mk1bmuA95FXaAkrm1qbow=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k8l12inIcgQqdAPlorhGUeGH1Qmn7ZrrbJCZw6c+SG7c18CWMdxeTqCmSG1cKK+PftHDScnM2+ZsqR0wMFYgT0W2YSC0wRRF5r9Vvt5TpwofRo3u36AqFN75lef2f9SQwhb3VlUULff/lqVBY7QN0lLclrwpYhNK5MgduJJcZW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfgYHQD0; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729094041; x=1760630041;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GW/6LwKitN+8yWHeh4iyh0mk1bmuA95FXaAkrm1qbow=;
  b=mfgYHQD0xZ9oZiNF/7DM0g81wZ8LYWy0w5u4ehJ+9YAOOdAzxvCIxwX+
   oiPCYzSnl3cClX8hI5KS/V33ac4hxULs4eeCc72PmqsyzN27LxpT3/ZVj
   1wCuOEthXNErt/elbXa++3NdebN9Fjdlxxz1zJGOzSqdIJyXH8ixhiBU4
   qcT+q1CKO9mNfZRi+1mqf0IsxRdM0xhpvhtSh6kuaWeFlNl0yztgMPP0m
   B+TbIUKZ5f7HE0gBKX+y89u7dQHBnBTz8Lb0NCEc8GxPnpZv4G0/4nAzt
   yRa5twJaGSXJF9vJHfaNQ2FJtQROpXXoQQnWL9SvTKfmb56ZcJNGTw7nw
   Q==;
X-CSE-ConnectionGUID: EyPWf54CSaSyFIVX7CNYDA==
X-CSE-MsgGUID: 4al/cGYhRoqTjHrvyHh9qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39127388"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="39127388"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP; 16 Oct 2024 08:54:00 -0700
X-CSE-ConnectionGUID: td2tfMNuRcCsOn5x+jvCYQ==
X-CSE-MsgGUID: aeGbQN1pRfiBpjPKVHSIZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="115709315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 08:54:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 08:53:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 08:53:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 08:53:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 08:53:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qF1Cw3Gi1RrsrW/h/AnjRn9kh/AbCLofdQwIyVOjO++cCCLAkRbrjk19wBoFyAB8Hsh5XoHlUutcT6dF6ZtqPB0BSc8l86gOOLnZgG+gNiyohcAYMSrCL3w6FGoGRQxz/VUBdRIXyMXQiw660YpWqiBTa6FzNMbmrTHrHuej8IFsQXW6rZAGQ9mDvfnXqqR1jVwrw1MKQWCQrBB/NgM/5+QKqjTEtzsjGKr9O5GbV1jvSsaiNr7RQpL4anbZJVqQcEjmQyeSybxl7URDfYBGVIYqU0rTxjgFh7noogz8Hwmf3Ifim4OPusfO9QXKyiVBut8MZv0JBX2PdPOLJpEeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wq65SYcPLY9EFslMKMDZXOjXL5Pz7NFaXMtXDuRpzkY=;
 b=S//bUSduhErvkA0A8f8ECVgZ65C+fIroUpHmqITSmzWLob4+HqhHxxPqpbI1WxRRcRcjuTn7t3nvZMlXvlPI+JfyyPuYcVuKBkCsGJMvZIhM5sQsL81pTjhh2+XaFPylVJGnkytewHyqalSjUR9g3+eBHkpdsjQGfPExplbmWl7PldtU7tpwSe5UR5oD6w+7wpPFXxc1qcj4kU2qJ5fb916iVHCuEz9K39KT6RzUF6YrrTHlMWntJsi13xcsdWfo746o1OAS2ae2mmbFJw6E/v+1GcYYxab1R/AZlD36k9OASLSeuIU2/ht3iadz1EOb1J8ksI2ShDyD1k25jYSmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5243.namprd11.prod.outlook.com (2603:10b6:408:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 15:53:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 15:53:53 +0000
Message-ID: <9d52bac8-5e4c-4bd2-b01d-c78d4b7274d6@intel.com>
Date: Wed, 16 Oct 2024 08:53:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] x86/resctrl: Add interface to enable/disable SDCIAE
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
 <e43947374dd9124ef5a6c677d0ec3ab715b6a7e7.1723824984.git.babu.moger@amd.com>
 <cd0585f6-1d90-4ef1-9a10-7db50cb879ea@intel.com>
 <ecdffce0-796b-4ebe-8999-73f2be1e703b@amd.com>
 <ec170d40-7390-4cc7-9128-d200df7405ee@intel.com>
 <a6a1dde1-5b4c-4c3e-a9e7-b2f2b327894e@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a6a1dde1-5b4c-4c3e-a9e7-b2f2b327894e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:303:dc::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: b89edd33-2edd-44e9-93b7-08dcedfabc41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG5QUCtTTHBzei80VlQ4WWU4aG9vL21NVXVZVldSSlZuQUhZLzk4L2hDSEhq?=
 =?utf-8?B?OXUxaDlFRUtYNFVXQmFqRzVhV1lNWEw1dUNTNXppRXJkSXNEWHFzNmQ3bmFt?=
 =?utf-8?B?NWg0UDlNVTN3TmFYblRNbkVnMy9GVEZINE9zdVZYMmhaaTVpb1BwSUhRZUNx?=
 =?utf-8?B?TFpPTkFKdDEvMkVjb1lzd2p6a0pvNTFZdWdMT0RuTG9xQ25NbHBpeFYvZGNw?=
 =?utf-8?B?ZHYyMmhuQ2oyZTBFUzY2Z2ZaMW12VUYzWG9ISmNDM1dhWFhESTR6RG02eUd1?=
 =?utf-8?B?WTljcmpvNkZSS05xRWdJQzllbHQxQkNmTFlBY05IcDlCSmhCcW96R1FIclQv?=
 =?utf-8?B?QUhRVW1pTlhMR254YnN2SmVQVTloT0cxdHRFNk84YzBZM3pHWnRJYUhzZm8v?=
 =?utf-8?B?Rm1YdE80UG51REREL1BuclljNXZuWDBJb2NDM2wxaXUrZmRsb2JmaWhyU1BP?=
 =?utf-8?B?a2hzVFN4QU5ReUhuTEtzbEVsVVdLZlNhMTM2N3R2UUEzWnEydk9FYVBDSmZy?=
 =?utf-8?B?VHhtR09hRm9TRU15SVMrVFlyUTdKWlJzdXJyQ2lRTTUrZ1NHWThVZ0s3ZGR3?=
 =?utf-8?B?akp4L3lmRktvVisvMmtlaE9qQlpYVEpWdFZLU0g3cXM0NlJ6OEJxMDZQMk1O?=
 =?utf-8?B?NWZFRzUxRDk4M2xndW0yVmFTS0cwMHNTRnNwTE4zRTQrWGdTZnNNVklnUXlx?=
 =?utf-8?B?cENnNlZKUFZPRDR6dXpzdFNocGdrSkhPQnRiZXFwZ2ZLUTkvUW9ZN3RONERi?=
 =?utf-8?B?LytGaStGWUFGTFkwbGpkNnBzWUlwYnpPeEdhSVVNaXRZNllyejVXaG9kTSt0?=
 =?utf-8?B?cFVHc1g1SzRRa0NvQ0RFQXh3SGNNRkVDNWlSL0tCNGtoUzZ5ZWhZQWkrU2lD?=
 =?utf-8?B?OTl1S1RneDJrWVVXai81SWlFVWdvNjF1aXg3eEFVMXdiUmlQQ2JKYmM3dTFG?=
 =?utf-8?B?Sld1TW0xSVpEbDEvNWVMaXJONVNweEJ1VjIza3MrQlB2Wk5QOTBhSzZFWTFU?=
 =?utf-8?B?N3Q4L1R5SU5rSjNCOXFsRHpXU21BTTBPR1FJN0FYZExjYnFhOE9WdENyb2sz?=
 =?utf-8?B?UFQ4Um9VUTdQd3o3clJpa0JFWk1iOEJNMi84L0VPM2lYa2dBMEdoTzkwaFFF?=
 =?utf-8?B?THdxTVRVVyt5R2x6eXJhblorcTZJRmY2bnpXVTZFNEFKQ1Q5Z3JnQUpqdm53?=
 =?utf-8?B?aXZjSHNmNGJ2Yk1YWHM0VFkreTdGb3BhcmliODJqOHBaSExLdURlcnc2NUo0?=
 =?utf-8?B?Sk1EZ2NOSFlmaG8zaG1uREh5bWlHeUtBdmxCcjRUc202QWVwS3N4Y1gwYzFy?=
 =?utf-8?B?M3kwRjVKM3VsSU1CUGVxRUtURzFnS1RYQWMwTk51YzY5MDE4eTBzZlVNVHRl?=
 =?utf-8?B?aGl5RXRBYld5S04xWm8vOTB4OUM2N1p3T1hyUnQ0UzgwUEVjd2FZVU50Qlox?=
 =?utf-8?B?ajdUNlZNdnFtN0V3OUJ6YkNNOExnYWpPcXFGMWRIaUNlU2lNMHBhRVdNOE1h?=
 =?utf-8?B?MkdGb0pvVUpnSUZYdzNzRVM4bjVwVURJV0lzWUdacXRjelIzelJSaDlYaFNT?=
 =?utf-8?B?MW1tR0ZEbHgrejVJdHBDSWVRSnRMcjhmSWxpc0dGeTk1cWU0d0xGSEFPdVl0?=
 =?utf-8?B?eGJ5TGZSbHhnN3NyZXlkVDRmTkVMa3ovcTdjSXFheUxrRERWTmhTb01KSGRX?=
 =?utf-8?B?QVVCd2VoRy9ualZFN0srTWVyWEZnc3JFSE8wZjJwZWNPWGM5YXpmM3d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NoQ1kxbW9lVWtLdWpEWHVnZ0owWmZpTENoQkgySjlyMXJ3VkNPQWJqd3li?=
 =?utf-8?B?M29sTVJEQWdaQ2xIRDZudDBjc2FpQzJxZlB6YXh2Q1RNcFpPT2E4UkllL0FI?=
 =?utf-8?B?Uy8vTE9vYUtteTF3bnZQMFVLUUNuN0ZhYlkxUjNzWVVaK1NFUUdTaVpsMHhZ?=
 =?utf-8?B?NS96b2NMT0taWkFTMDFzaWQ4Smc2SEcvMFJFRlhUL0pmK3EvTndWdElsdmVu?=
 =?utf-8?B?SStMRHJMaWRlMXllZXo0dVR4UlRkRnNOdG9ML1FNU05FdERPc0lEUDRuTXZx?=
 =?utf-8?B?QkVjQ0VKNmY0Z1FEd2pFcnlYSHVNODdWekYwdDFRdVk0UWNYR1d6TDkvcHF4?=
 =?utf-8?B?cmQwSzlPRmJ4ejQ0enVISmpxdSsxdGNDODBYWmJ4U0prOFRwT2cwdjFEUzNa?=
 =?utf-8?B?a3QzUWNzYld5UE51SEVnZE1OL2RFa3RLN3hsNHRJRmJMSG8vVysxOC9VdjJP?=
 =?utf-8?B?SGJwWDZTMFpYNWcyZEowL3ZyWTkzODlvVHcrbWVNVkVESFdadzBvM3RmbFRu?=
 =?utf-8?B?R0hHQ2R0UHA4YTNwSzhNdE84TStHdHU4dnB3Z2ZnWDBvMnIxMTFJMHkxYThG?=
 =?utf-8?B?YWtBdEFLeTlQaEdVZ1UvdGhSaDRST1IzbFI2OXUvazZ5SmJLTE0wNGJQV25w?=
 =?utf-8?B?Ny9TM0NNVTBLbGJNa0t2cncrWmUwMG1tOHplSURra2FvemVtSXFESlRFMjBW?=
 =?utf-8?B?cXM2SjIza005OHlaMEd5U2RodlFkN0c3OE5nb054UGxIYlJnSkw2VUltajNH?=
 =?utf-8?B?MEhaU29KeFdCK2tuSXo3clNVRXFHbzRPcGx1RmI2TnltN0YxUEdaUERRTlUv?=
 =?utf-8?B?SUlXa091ZUFLQUdiR3pIMUxXNFZYOVViL2sxYk1OajhtWktLZ0g2L3pTdE13?=
 =?utf-8?B?eWJ5QVI0MC9ldUNYU2dzK3lSOFhTeHBBTW9QTUdMZ3BCL2pYK01PTEpmMDN6?=
 =?utf-8?B?U3F3TTJnVjJaa083N0tnakhmTUd2OXZJWkwrd1ROWmtwMFh6WUhkQUE2UDh5?=
 =?utf-8?B?K1UyMVErZXdyOU1KQ0lOR0pBMVorNStNSDdlUzBVNTE3TFZaMHN4UHZNZWw3?=
 =?utf-8?B?ZHdEM0pmVlFRbC9LWmlxaUs0OFhJL0ZDTWR6NDFUNWQxcHcrNjArWEY0RitV?=
 =?utf-8?B?MTBzbmVCYnF3R1EvbGFnOEx3SDd4cWM4Rm03S01pTVY0UDFScjQwQW5WMmhE?=
 =?utf-8?B?aUM3d0l6bFIrNmo4Mk1XN3hFY0hPdTJhUHdmTTRuUkdCZnlBajA2bnk3eUsw?=
 =?utf-8?B?Z015aXF5cm9ldlNodytOSFBsNTZjNmJ0Y3pFMXQ0QWFCWGpVc1Fua3hYT29F?=
 =?utf-8?B?Z0s5NEMrb296K3VLZjR0Y245UUpHMDczVG9rZkFhRTZRd3NTOXpJQlJKOXRo?=
 =?utf-8?B?bUNtSi9rdnl0NHZkUytHZmxzVmR3UjlCK3RvVEFnOFBVUi9NQ0VwMktCaklR?=
 =?utf-8?B?aDVid1dXaEpwYURFZlN3VnhWWHJueDNNVmhJYkptMEcrdHVVSnpXNHE3R1or?=
 =?utf-8?B?MjJFYUtIMWZIL2toY1duRjlIRzVndk5QNlQ4aUdiVXVJZ3I4L1d0aTkwZVVh?=
 =?utf-8?B?UnQ2VmRrUmtBM0xaUGpnQmFldkN3blJNeE9yZjRzMjdIc29mN3IvK1VLWHJB?=
 =?utf-8?B?YXkxY1FPM2E2U2ZUK1J4dFQ5MzRvU1NxWmV0UVZmK29tdWhtcWJRaEd3NXhV?=
 =?utf-8?B?Tnd1ZlROSHM4cHcxZFJvNUo4c0RES3dJRmZLR3pWQmlHRE04VWlOemc4MDVo?=
 =?utf-8?B?Z0xqWS85aXdNRXRyRTd4bFczcExNdEV3S3VDMnJqeG1ZdlBLdGFyTlB3ZWk2?=
 =?utf-8?B?TTZwU3lkT1Qxc0dMbkZaRUtzbGhOVVhUZ1ZHVnhjNVdOSXdZdElvZDJxeHJG?=
 =?utf-8?B?UUhjelBWVVN6K2xubjVqdXNCZkczbm5CV3Y2Um9RODJQa1ZyM0FFR0JwZTFo?=
 =?utf-8?B?bk55WVZ0WDY5UGZxSWlMRWlETFBqTnUyVTM1RlVJOWx3ek9JMHYyWmdlTmtU?=
 =?utf-8?B?V2pwRHdqemFjbnR3T1M4N3JRSytZSTQzd2Q2L29nTjRMajNwU01BN0VVNFpj?=
 =?utf-8?B?K1lGTk94TVc2RjU3cndBbDJHcE05U2VzYXVlb290TzNGNnRIM0dFOXYyRkpX?=
 =?utf-8?B?d1Rlc0FQc2Vtb2k3bVk0YVk4bS90cFVIaXV3L0xRRHVUb1BGRzQ5c3AyeWl4?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b89edd33-2edd-44e9-93b7-08dcedfabc41
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:53:53.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scQljXNx5uFoCGhQDcJxJow5rXKIU+gPYw+U9whc1jfYd9yLzGdhECQJ1Nh1HG6fkj8PrSWsZoY2JYkjU3XpqUpV/yhw1Wc4YdcJb9MmImo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5243
X-OriginatorOrg: intel.com

Hi Babu,

On 10/15/24 12:25 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> Noticed I didn't respond to this comment.
> 
> On 9/19/24 10:35, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/18/24 1:10 PM, Moger, Babu wrote:
>>> On 9/13/24 15:51, Reinette Chatre wrote:
>>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>
>> ...
>>
>>>>> +        if (enable) {
>>>>> +            ret = closid_alloc_sdciae(r);
>>>>> +            if (ret < 0) {
>>>>> +                rdt_last_cmd_puts("SDCIAE CLOSID is not available\n");
>>>>> +                goto out_sdciae;
>>>>> +            }
>>>>> +        } else {
>>>>> +            sdciae_closid = get_sdciae_closid(r);
>>>>> +            closid_free(sdciae_closid);
>>>>> +        }
>>>>
>>>>
>>>>> +
>>>>> +        ret = resctrl_arch_set_sdciae_enabled(RDT_RESOURCE_L3, enable);
>>>>
>>>> I assume that once SDCIAE is enabled the I/O traffic will start flowing to
>>>> whatever
>>>> was the last CBM of the max CLOSID? Is this intended or should there be
>>>> some default
>>>> CBM that this feature should start with?
>>>
>>> It will start with whatever the last CBM for max CLOSID.
>>
>> This seems arbitrary based on whatever allocation the previous resource group
>> using the CLOSID has. When a new resource group is created resctrl ensures
>> that it is created with all usable allocations, see rdtgroup_init_cat().
> 
> Checked again with with the team here. When SDCIAE is enabled, it uses the
> value in L3QosAllocMask15 (value in L3_MASK_15 MSR).  Enabling SDCIAE does
> not change the value of L3QosAllocMask15.

I see the issue as similar to how resource group allocations are managed.
Just like resctrl ensures that when a new resource group is created, it is done
with maximum allocations that the resource group may use ... not the allocations
left over from the previous resource group that used those MSRs.

I understand that the hardware uses L3QosAllocMask15 and does not change
L3QosAllocMask15 when SDCIAE is enabled, but resctrl is in a position to initialize
those registers at the time when SDCIAE is initialized to create a sane default
allocation, not an allocation of whatever happened to be in MSR at that time.

>> Letting cache injection start with whatever allocation remnant programmed
>> in a register does not seem ideal. What if, for example, after that resource
>> group was removed, a new exclusive resource group was created that overlaps
>> with that allocation? 
> 
> In that case. it will share the bit mask with the exclusive group. We may
> need to add a text about it.

No. This can be avoided entirely when resctrl initializes the MSR to a sane
default, no?

Reinette



