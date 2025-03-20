Return-Path: <linux-kernel+bounces-570478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB01A6B103
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E46C4610CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAB21E0B7;
	Thu, 20 Mar 2025 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzBK1qKe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC42AE6A;
	Thu, 20 Mar 2025 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510192; cv=fail; b=KaR4czKh+43lI0+R48N2hc4UWV6ZMG8OtPxjBAjOyuOl9WK7bGZRqGU7PMlfapa9BqFG/r9QoqoSnzcDI8tFTSrLaNmI2reC4dUSNJKU7fM5IleaU0YzIC5xmzSrMKFOMut8Rw0iQrtn05EO3kOJ6KOHkkOm6ySha0W7AWEGcfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510192; c=relaxed/simple;
	bh=9R8/AM4N6N5xtPBNzlQ9Zh2NYtmwGu+jNFupJjg+a8I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GMWaTrFXbA63rZE7CogIyi0+bK6zojuRNSbNZyJW7HkrB6OXnZNWBjkUPztVdQtskafL4iuphy1owxnLdWljfr0te6mnEm0qSwOGH7t/PKsnZVIfnM668aeB6aRQusn57bj2d3cQJxtTtDV+SWyUDthWSaelmV+ChJb3L2bv7bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzBK1qKe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742510191; x=1774046191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9R8/AM4N6N5xtPBNzlQ9Zh2NYtmwGu+jNFupJjg+a8I=;
  b=KzBK1qKeT8u5IrEaF89OIYuVIfBAlqBObcTBQZXQzgB+1GW64KHYn5AP
   zQ2Oed1nckBv4u1pFQxDBDBlnYSp9eUf51bFEF18/X00JV6+z9jXF+1VY
   fP4iVa3XxW9XxDwo7ip0CdHH6qQblUQZKEtKfHABCH6lilmypw3F0GJqi
   1kVSMQqnh+RWS7utwPypkOANTuaRGDZP7jwKLmiBANCHlOvmr/emwGT06
   zfwrfCLpDsWWX7W8aaKEaWuowO2pvolIVIE+ikdw+y8WISdwjKl1xyWmw
   poo9yANwP8SwApRnSKPmGJtl1bnvMf8jj8W9neIgvujxQkiWi0S7s7nTw
   Q==;
X-CSE-ConnectionGUID: T5MwPTxhQtuSjUt9ayzsYA==
X-CSE-MsgGUID: YckZ9QTCT3ykx47FfilKBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47543176"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="47543176"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:36:30 -0700
X-CSE-ConnectionGUID: fyznWn/eQK+BQhu72k/3DA==
X-CSE-MsgGUID: H2eLJh1+Q/OdMH7bJ3AIrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123195807"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:36:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 15:36:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 15:36:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 15:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAfG8aq3hUsMk1lSO8lm6qtYhxiWObIARO5vUNzIJtGHElktVBnaqv8A1HTSQKlpfrbf86KOjTquvY+jl7dVQyf0B8d9jX+yoqn+0MgHSfW/15o2Zl35Jj5gjzwHLauQG++iwhpalfUtgGNCA+bkAO09TIOeTIElDmbGIG99TNGduerOyX6yPCk99lNs2hJds6aH88V31vu+2TMP90k/V7Rgyi0lsoMjNPTQKsPz/OU5TlVGY8b7crlOlAJR/Zfk7k98dyCpPbIqpMPa8Mt1nJwhRmEHoBRpNdOsQF8ee3H9SRw3V33z2KfWHQd3TxSTj0YkqC89W7ujJSrF8DTlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu98rRpC0gqOiy445Q0FFwlZIWAjM6JDOvwcU/Pddzg=;
 b=OKpLtyNYgVwUUCdu/Ti7a31GZXig8MOS9O8cfu9Kc4yfncNNdIazQvznvpHxWDtw06AwAr4ChhariFIkOQgb3DY+GmiyaBzQOQSwJE7KQBja9sn9bdLEyPW6ZlcTbrvAAjHlsQLlX0pKJUQBriNGwDYuLZIhqSyFCM/q8HoiDP2xLmnZ5y72579/l2Peb/NnCY3HI2dWhwx/1FGDPGby8E6MbaQFb1nhbh9qFoSyuPrrbP96WIN8eSvwQC8qDqdlA+slJ2+64MI2AUR+poEBJZB/27vA6tTkp02P3xhgyA462YTn2nq/VHkW5yXkA/NlsvVKUuFF8CqAIEKaO9hYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Thu, 20 Mar
 2025 22:35:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 22:35:32 +0000
Message-ID: <c378cc5c-c589-43be-a101-e2c625f23688@intel.com>
Date: Thu, 20 Mar 2025 15:35:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, "Moger, Babu" <bmoger@amd.com>, "Luck, Tony"
	<tony.luck@intel.com>
CC: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
 <c840cb69-41fe-49a8-a7a8-d75f68e1d84c@amd.com>
 <0cecd52d-253c-4b2d-9841-a86870d5945e@intel.com>
 <1244c9d3-233a-4da7-97d7-2c4097b3741b@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1244c9d3-233a-4da7-97d7-2c4097b3741b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: a66c9a1a-4a42-4824-7f49-08dd67ff8633
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blpTZ055SXdVL3dQeUh5bGFPN09ZbVFjb2pwT3JaYzkySUJFL0NCY3NFZlZB?=
 =?utf-8?B?UzZ1aG5RdlV0RVBUUGxxVHk5SkVNRzF4bmVnM0M1a0haRHNySFNDcHBVREUx?=
 =?utf-8?B?QndiVk94MVlvRjZ0NmsxaXRWam5talJhTGJ4SDYwbmUxMlUrNzZzNHJhYnQ0?=
 =?utf-8?B?WjFHd2U3aTRGN0hmQ044Y3hBSXFjZ0xkZzdzTjErOFFEaUNNTFBleVJLdGFK?=
 =?utf-8?B?WlFnTVlXbUhFWTZ6UGhzVHhsM24vUHp1Q1pZb2pEUS90Qjc1RG1jNWZtYUtQ?=
 =?utf-8?B?WWlqQ2Y1WkE5Ylk5YW5hK1NFdWt1V2JBdVRqVHNFMDVXRzZHL05tbzVKakFi?=
 =?utf-8?B?ZWwxQ3Vsc1BYUUNiTlU5NW5iNzk0TVkyb053dGRzdUU4dmRpQWd1NEhiOEs1?=
 =?utf-8?B?Wld5REJhWG4vZ2puUWpHa1lWODJ3T3BKdWpCc0dtNkJMcUR2TktCUEVhMUlr?=
 =?utf-8?B?RUtmV1NOVGIycWpvVEFQWi93alVaZU9DZTdUVTFYL014czhQRmppNmpheWFI?=
 =?utf-8?B?WlVhbmNCUFJvcjNGdER2eVp3dHNHTThkUVpmUC81ODhmb3F6b0YwQzdCN0xq?=
 =?utf-8?B?Z0JKaXVNanlmblNySGQ1MnhUVlNvOHhGbWNxbmozc2dlemNPUElTOWxLVjZW?=
 =?utf-8?B?dUVXbWoveFloemg3VWZ4VnVmSW5KTjJ3M0xhRTNGVTEvMDRNQzhNZkM1RnhP?=
 =?utf-8?B?SlVRL0RFbk9RVm41cDQraXVNOHV4TW5xQlhmV0ZMV2s2RVRLelZsSWRZN0Y4?=
 =?utf-8?B?a29renZvUkFMcXU3UldIUHhQeit4R2d2QWc2TCtuZ1lNNGRvYkt1TnlnSkgx?=
 =?utf-8?B?UHpmekIzTHBnWENYaEQ3UmMxODhLMDdISkZtdEJoUWxEMVlNZ0lOU3JXaTV3?=
 =?utf-8?B?dml1RjBNdEtuWXArVER4NGNoSFVRTmlsTEJHZGxGWkw3TVhZU1pIdEptSkMw?=
 =?utf-8?B?WlBWWnRjeC9ScjBRS21rcnNJS3BSSlNkVk0vRjZvdm5EWFBjNGZjc1FCMnE2?=
 =?utf-8?B?THlROXhnaVlLSFhjS21TUU16SVZ5ZDNzUkwwc2NwQ2wrTnhJcDJBaStyODJN?=
 =?utf-8?B?NE1PRHAzSUpYdHFjbStmbVNtbnJFMFhsVUNTOGU5Q0VSVlFublBpMjBXK0NK?=
 =?utf-8?B?T2wwaFVLRWV1bktRK0lhQWVxaDVYazErWHk1aGw3VEFhR3Zqc1VjWFI3SHJU?=
 =?utf-8?B?UG03c2hvaEs2N3gzSUtFU3ViTTlPUGxkdGdGcWVRMjcrVGRLeDRIb0l2Zzg5?=
 =?utf-8?B?dS9mOUZEQllrSFJQaE51YTEra09yK2pyUGhNTjlycWExVjB2RVV5bktsR3du?=
 =?utf-8?B?S09pQVdPNmMvSEtDNUl2YXlFeVlpcGdxelBpem9JdCtMY2pkYUdNdVFsQkZr?=
 =?utf-8?B?SE90dzVDaVZvbWQ3ampWK1pzSGJjYUV3ZFpjcExlRU1PMFBTUkdrREprbUJ1?=
 =?utf-8?B?OVI0V041NWh1Qmk5ZmFFMk8vMUliWWVyWHNaV1hkOGNBUndLWFVUaHlvdWp4?=
 =?utf-8?B?WHBmbHJDR21sOUg1a0ZmRG9aaTRBU0Z2RnBwL0pGaFljR0ZscEh4cGtqZnJY?=
 =?utf-8?B?WUd4eGNoQzNRU2ZvN08vRDYwcXA1Q0RNUkpEb1NsaGVDeFRxWURZZmxHOEFr?=
 =?utf-8?B?bWI5ZW1XV1lzRzNXdjZlUjMyaGRRbGpJcndGNVQxNjcrU3lUMUdmUHdxMzVv?=
 =?utf-8?B?L2dQSGQ2dFU4UGVhRFQyckFIWnZQZTBvaVN4R3FtdUp1WTRJL0l0L3lVZHF4?=
 =?utf-8?B?MWw3djl6Tm10aERxeFlOMm5XWHNHdU9PczlJeXc4RnlFSHlqc25odnNCd1J0?=
 =?utf-8?B?ZmJYaFJYbjFBaHZIZG1RZ21hZ0U3U0hsYXVQUkd2QzVwZFpYWFNIVzAvazlh?=
 =?utf-8?B?Ym5XUEF3QXJEeU90bWVKRy9nKzFuMXJ6bzZrMlJiSTJHOWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhOWitvbm9kRXlEZEtWQWgrYkVGSGU5Tng2TlZYaXpHSlNabHVQVTVmdzRS?=
 =?utf-8?B?MVlsNlVQdnJxUm1BVnVlVmNnVHZtM2NWYm9zVHVObTh1YnFvRmtlYUFxdUl1?=
 =?utf-8?B?RklyVERYcWhSa2IweFRMTmRlSzBzM1FjcWppQ1JYbjRYVUZ0VlFiWVJjckhs?=
 =?utf-8?B?NEJPL3lZYVFjWlF2U2Ewc0d2bGZFQVA0N1c3b1J4OFFBL1AwcnNZQVpqNjJR?=
 =?utf-8?B?L0VDMW5OaU9uNUhNOTh1N3lpeGZ5eC9kbFMvRFVZcG1RVDAwY0pxMC9Yb0xp?=
 =?utf-8?B?OTBneFIramNHWERCMmRCLzIrQktMUGY2M1I2TU1ZcFRjUGpzSEN6TFlobE9w?=
 =?utf-8?B?NDBKeklteWw5U0hRMWZES3QwWUx0S1R6U1ZIU0RydlhlVHlQZGRQMUwyVDdS?=
 =?utf-8?B?bE5VL2twOG8wM3FIMFo2SUhsVFg2S0JWKzAzNTVoYWZHa2QrTlRYRk1NL2RY?=
 =?utf-8?B?ajN6a1pjWFFBYmhvL2hNeG1rMFJscHVjQmcwVFBEcm5ycEFiWUliT2pKU1p6?=
 =?utf-8?B?dGU2YldaeXNYWnpIQkRqZUVPc3VuOGF6OW9tVHh3MlpodDN4enFOZ3NpQUZv?=
 =?utf-8?B?R2hqTTZjbVVxQWdVVDRwelZudURuQXlSTTA5ZTRGWDJKMXcvckFIQ3FHem5r?=
 =?utf-8?B?eWwyUTN1MGV1REVmME5iWi9KT2F3TDR2WXlRQWRQRGR6UllVOXpQeGZtTGlQ?=
 =?utf-8?B?Yy83M2FWMS96Q1FJQzVONHEvcWZCZ0pFWTllUGpYMVZoU1Z2TldKdmVZbzJx?=
 =?utf-8?B?b1BNa0daMGtqVXM0NmxrUTcydy82UityTjNCMkJtVGJJYlBIQjNGYUdmcVJl?=
 =?utf-8?B?RFl5Q3Y4dGdQVkphSmRyaUdXSEJENUxuVHdMOFVIbEtKOUJkNGtTMHJEVXJz?=
 =?utf-8?B?eFZFSEIxSzlmdXNYdUdZZzAxOTROcXcrU0tkeU5ZcGQrTUFlWnhNU21GSFYw?=
 =?utf-8?B?WXdrbUhCdGt5YlBDMFk4L2JNWFU4bWtBSkVwd0hoN0RPZlB1WlJjZTB4V2Z2?=
 =?utf-8?B?dzB0VUtOU2poUEt1VnZlb3BXcVdtVEZMaHRmbnJXZ3NIbStUTkVWaVpmSDUr?=
 =?utf-8?B?cVBhRDZHa3FHMUZ4QWRyVlBJMmhBOGxPUU9BN1IreHFUS29IclpNcWpvN1Ry?=
 =?utf-8?B?ajJXTk1ZdFBuMDRySzF3dWxhenhTWVg2cWFwTnB2dHQyTGJzWlpQNFNObk4x?=
 =?utf-8?B?eUdDMzg4NUxub2JHdE9GTjVLWDd6dFNXbkJBNjc2RXkvOW5pQUlPSW1SY24w?=
 =?utf-8?B?dlJEeGd6WnkweXN0YkVuK1RXOXdmWFl6VnRWRGxvZURMVnJlQWJPRGhIeWFq?=
 =?utf-8?B?dk5EMDRHVENMVlFmbFpKVk40bUI2MjBKY3R4Q1RUdkF0Qm1FR0hLcDh6VzFk?=
 =?utf-8?B?VXZXS1RGSUJuVEllc3VDM2RjN1NvOUYvS2FDUFJ4QTVnWE9qQXhON0RZMnJK?=
 =?utf-8?B?ZjhvYlZkQ082RTd0L1N0WXBWdzd3cnNXZURWM3ZhY2QvcldBbUFUR2dzdDZ4?=
 =?utf-8?B?QlNOc3dLU1IxbGVIVWp0T1pFb3FxTmlKa0pTcVZvd2ZGUEFWUEJKQVM3YnpE?=
 =?utf-8?B?VjQxclRlbEhNTFZDWDhrUzNWRHV2OTdJVGFTOVAva0I0L3hFVXdLNmE0VTRC?=
 =?utf-8?B?RUVrbHJwY21DM1d0VEx1V2hmR3JpRHI1OGdWUzJNWnJtS3lJaE5haTJiVGVB?=
 =?utf-8?B?YS9iakU0cDd4b1M3c3pCMzl4U2ROZXdORGJ0cWI3WUJ3QlU3S1U5V1dDYmpW?=
 =?utf-8?B?Y2RaYlBVeEJnOS90Wk1SYmNrcTRlL3VvRVpFOHYwZUU2YThlakxIeWN1Uyt2?=
 =?utf-8?B?b2NhOThMSXRKMHJTZXBYbC95aHhHSUJHRE1nbS82L3psZld5RUF5WTFtNzJv?=
 =?utf-8?B?TlB1YkNRZ3FmTnd5b1grVHZZODV6anNVRDNRckluMVZPdEdEOVdJZ2R1ZUg3?=
 =?utf-8?B?R1IwMGhZS014anNGTG84SEFzdGo3TmNyUVJDN0R1OCtac2hoMXF4aHVhNGVJ?=
 =?utf-8?B?RW16MUZscWVIbWR2djdGVCtmSC8yOHFRWDF4MnZVQ3Q4dUMyckMzWWZhR0xk?=
 =?utf-8?B?Q0hZeENuT3JGSDV2UjJaOG1HWkp6UGpIQUdYT01BeXErdGY5Yk1SSExBcTZG?=
 =?utf-8?B?Rm96WlhSSjBENkxRaU5xZ0hWdER0L0x5UTFhZGkxeEZ5RDBJdGJXVndyR1ZL?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a66c9a1a-4a42-4824-7f49-08dd67ff8633
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 22:35:32.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8MaZXk7loS3do66p/64IYkuOEC9FlSM2lia0hdD+SikvfOylvnnZaJ/8XTOvBWd0Yc294sQUiPUpQfxRQ0yLU1bTLcslSPdrG1ONjoNUfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com

Hi Babu,

On 3/20/25 11:12 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 3/19/25 13:36, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 3/14/25 9:18 AM, Moger, Babu wrote:
>>> On 3/13/2025 4:21 PM, Reinette Chatre wrote:
>>>> On 3/13/25 1:13 PM, Moger, Babu wrote:
>>>>> On 3/13/25 11:08, Reinette Chatre wrote:
>>>>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>>>
>>>>
>>>>> Here are the steps. Just copying steps from Peters proposal.
>>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>>
>>>> Thank you very much for detailing the steps. It is starting the fall into place
>>>> for me.
>>>>
>>>>>
>>>>>
>>>>> 1. Mount the resctrl
>>>>>     mount -t resctrl resctrl /sys/fs/resctrl
>>>>
>>>> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
>>>> will continue to depend on BMEC.
>>>
>>> Yes. ABMC will be enabled by default. ABMC will use the configurations from info/L3_MON/counter_configs. ABMC will not depend on BMEC.
>>
>> I see. The previous dependency was thus just something enforced by OS to support the
>> chosen implementation? 
> 
> Yes. That is correct. We went that route mainly not to change the
> rmid_read operation.
> 
> With ABMC, we need to set Extended EVTID and ABMC bit in QM_EVTSEL
> register while reading the cntr_id events. Will add those patches in next
> version to make it clear.

Thank you.

> 
>> Looks like the two features share some registers.
>>
>>>
>>>> How would the existing BMEC implementation be impacted in this case?
>>>
>>> BMEC will only work with pre-ABMC(or default) mode.
>>
>> ok. Does this mean that if a user boots kernel with "rdt=!bmec" then ABMC will keep working?
> 
> Yes. That is correct.

Just to confirm and bring the two email threads together ... it sounds like the
expectation is that existing users of BMEC are expected to use mon_features to
know if mbm_{total,local}_bytes_config are supported. If system supports ABMC
then BMEC will not be available and thus mon_features will not contain
mbm_{total,local}_bytes_config. Existing users that rely on
mbm_{total,local}_bytes_config will experience failures and are expected
to switch to ABMC?


> 
>>
>>
>>>> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
>>>> files will remain and user space may continue to use them to change the event
>>>> configurations with confusing expecations/results on an ABMC system.
>>>>
>>>> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
>>>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>>>> llc_occupancy
>>>> mbm_total_bytes
>>>> mbm_local_bytes
>>>>
>>>> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
>>>> and mbm_local_bytes_config, which may be the simplest to do.
>>>
>>> yes.


...

>>>>
>>>> I do think, and Peter also mentioned [1] this, that it may be useful,
>>>> to "put a group/resource-scoped assign_* file higher in the hierarchy
>>>> to make it easier for users who want to configure all domains the
>>>> same for a group."
>>>>
>>>> Placing *additional* files higher in hierarchy (used to manage counters in all
>>>> domains) may be more useful that trying to provide the shared/exclusive/unassign
>>>> in one file per domain.
>>>
>>> Yea. To make it better we can add "mon_l3_assignments" in groups main directory. We can do all the operation in just one file.
>>>
>>> https://lore.kernel.org/lkml/efb5293f-b0ef-4c94-bf10-9ca7ebb3b53f@amd.com/
>>
>> I am hesitant to respond to that message considering the corporate preamble that
>> sneaked in so I'll just add some thoughts here:
> 
> Yea. I noticed it later. Will take care next time.
> 
>>
>> Having the file higher in hierarchy does seem more useful. It may be useful to reduce
>> amount of parsing to get to needed information. Compare with below two examples that can
>> be used to convey the same information:
>>
>> # cat /sys/fs/resctrl/test/mon_L3_assignments
>> mbm_total_bytes: 0=unassigned; 1=unassigned
>> mbm_local_bytes: 0=unassigned; 1=unassigned
>>
>> #cat /sys/fs/resctrl/test/mon_L3_assignments
>> 0=_; 1=_
>>
>> We need to take care that it is always clear what "0" or "1" means ...
>> Tony has been mentioning a lot of interesting things about scope
>> changes. I assume the "L3" in mon_L3_assignments will dictate the scope?
> 
> I didnt think about the scope here. I was thinking of changing it to
> "mbm_assignments".

ah, I see, not a general "monitoring" file but specific to MBM. This still
may encounter difficulty if AMD does something like SNC where MBM could
be done per numa node. Perhaps we could constrain this even more with a
"mbm_L3_assignments". If anything ever shows up that need to do MBM
counter assignment at some other scope then at least we have the option
to create another file "mbm_?_assignments".

> 
>>
>> With a syntax like above the needed information can be presented in one line.
>> For example,
>>
>> #cat /sys/fs/resctrl/test/mon_L3_assignments
>> 0=mbm_total_bytes; 1=mbm_local_bytes
>>
>> The caveat is that is only for assigned counters, not shared, so this needs
>> to change.
>>
>> To support shared assignment ...  I wonder if it will be useful to users to
>> get the information on which other monitor groups the counter is shared _with_?
>>
>> Some examples:
>>
>> a) Just indicate whether a counter is shared or dedicated. (Introduce flags).
>> #cat /sys/fs/resctrl/test/mon_L3_assignments
>> 0=mbm_total_bytes:s; 1=mbm_local_bytes:d
>>
>> b) Indicate which groups a counter is shared with:
>> #cat /sys/fs/resctrl/testA/mon_L3_assignments
>> 0=mbm_total_bytes:s(testB); 1=mbm_local_bytes:d(not needed but perhaps empty for consistent interface?)
>> #cat /sys/fs/resctrl/testB/mon_L3_assignments
>> 0=mbm_total_bytes:s(testA); 1=mbm_local_bytes:d(?)
> 
> This format does not tell what is going on with all other domains. We need
> to display all the domains. I think that is important because users need
> to know what to expect reading the events on specific domains.
> 
> I think we need to convey all the following information to the user.
> 
> 1. Event Configuation: What is event configuration applied here?
> 
> 2. Domains: To which all the domains the configaration is applied?
>    This is useful in multi-domain configuration.
>    We also need to know if which domains are assigned or unassigned.
> 
> 3. Type of assignment: Exclusive(e or d) or Shared(s) or Unassigned(_)
> 
> 4. Finally: Where to read the events?
>  This is important when we add "mkdir" support in the future,
> mon_data/mon_l3_*/config_name will be created.
> 
> 
> With that in mind this might be helpful.
> 
> # cat /sys/fs/resctrl/test/mon_L3_assignments
> mbm_total_bytes: 0=e; 1=_
> mbm_local_bytes: 0=_; 1=s
> 
> This format tells the user all the information.
> mbm_total_bytes and mbm_local_bytes configurations are applied and
> configuration are coming from counter_configs.
> 
> User can read the events in
> mon_data/mon_L3_*/mbm_total_bytes
> mon_data/mon_L3_*/mbm_local_bytes
> 
> mbm_total_bytes is assigned on domain 0 and not on domain 1.
> Reading the mbm_total_bytes on domain 1 will report "unassigned".
> 
> mbm_local_bytes is not assigned on domain 0 and assigned on domain 1.
> Reading the mbm_local_bytes on domain 0 will report "unassigned".

Thank you very much for spelling it out. Much appreciated. This looks good to me.
Please include your list of requirements for interface in the cover-letter and/or
patch that introduces the interface.

> 
> I dont have much information on shared assignment at this point. Dont know
> if we can display shared group.

The proposed interface accommodates shared counters. The expectation is that
users can keep track themselves and if not, then the information can be
obtained with a read of every group's counter assignment. The issue here is
that this may worst case need a large number of file operations if expectation
is that it will still be possible to create num RMID monitoring groups.

Using files inside monitor group for this information may actually not be ideal.
If this information is needed then we could perhaps add a new file. For
example:
/sys/fs/resctrl/info/L3_MON/counter_configs/mbm_total_bytes/<file reporting which monitor groups share this counter configuration in different domains>
Of course, I do not know if this will be required and this seems manageable as
a later enhancement if needed.

> 
>>
>> ... (b) may just be overkill and we should instead follow Tony's
>> guideline (see https://lore.kernel.org/lkml/Z9CiwLrhuTODruCj@agluck-desk3/ )
>> that users should be able to keep track themselves.
>>
>> Reinette
>>
> 

Reinette

