Return-Path: <linux-kernel+bounces-522159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631CA3C6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD4189C4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78B214A70;
	Wed, 19 Feb 2025 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcfQMOTu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794F214A68;
	Wed, 19 Feb 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987728; cv=fail; b=G0DFvvGaaq+Q/0CsG1dbLgqMNyY+V+JomDXRiW0bHkeKVMsXQbd7ziHnbcTObopiaA7xvsBvhYTqWPqg7kOEYumwyVz5GvBU8m7SWXBlVP6D5OZvCGprgcXeo32klE6tumPwH43816Nrm78N1N+EW2DJYeicQr3t/u/gw8tTpzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987728; c=relaxed/simple;
	bh=lnz6PVxgjqbIXlAbqt/EhErnz5HLfFAhpXsZ/mBT3jM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bjOy0IGq1+iy9Efo1b6muhvrdbxj8fHykCSjeaGK7if26LDZLpbNgwmAjug9kLQQyZmEfh/Z5KEQ2u7AxtgeZEMdxRGZwUZhgm8V5mHFDT5JFMlxeElYc19nKcNwD3++K6EzLrO6ljFs3Do67SlW0NErQSdwpOgmDfoZ0uyU/qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcfQMOTu; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987726; x=1771523726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lnz6PVxgjqbIXlAbqt/EhErnz5HLfFAhpXsZ/mBT3jM=;
  b=RcfQMOTuLLu5IhHW0OB9d/I/6JKjsFNIjQgyU2B9wV7CPExQ89kKeyqv
   fL6jJKKct5u78E/10c0vaHEfrv3s227Urkg0SaEvjZVgmnOUmzYkubnKs
   I5RQtPjU6sfLN8NTX/U0JeufgItZ/nh6oDP/moWM6NLKp3ebR+/qH0mHP
   GhdZlgjiHLgrugYYpdLN6fCqJq16YW855gLegY+i4eS9RMNmDBdGUubeh
   YGx3JfYdZvQKA08M4j7HjcVllv83/BWFIpjISYZPs1EYTc8ewAPonmcRB
   +uEAykSQfDKn3K2cZyOfd55cdbVDDknBGdLBNSfFzG73R58aOb/+lVq1e
   w==;
X-CSE-ConnectionGUID: iE7moqMOTEOb7uOpGtzrDA==
X-CSE-MsgGUID: 15+c8PLZR/KGDmnPnzAbCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="39970814"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="39970814"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:55:26 -0800
X-CSE-ConnectionGUID: Ipj2s0SoSZaQmcyVPsYVrw==
X-CSE-MsgGUID: x88jBllmQiyAtZ/s6OJvcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114762367"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 09:55:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 09:55:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 09:55:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 09:55:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jW9kR9qzFV7V5ZLUjrcaInGSU4x4tuzFucysQjGLUinLPeI/dOuH/L0x3e8VZs2R8BS+L1g0Ue86ky16YU73wSDbCRO4t+IiH/k9cBgQq60oLSlWALr0EDMnoKH/qkndw/NUE6HgPbRTf/zOxnZMb8+fQgkNsREX7aXcSckeamrOj9FGQBB8xAyaR1Khv+kWqX3t4dN/SX7Ih2VSzPaySMg0oFUlXal2zlNo/ZUI/cgyqhv7Cj+6sc8SzfDWPu1gvMKo7gBtWlKPqeVv3tqUIv6HCavtLBbwSlVvbC/eiNVxY+xh1gACYTIMS1vvUQ1MtpGzy76K43cZ6toE2zWckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JktTtcnYbwQ5FYTk2MWqE9WmQMLUowsiIRt/tTcUm0A=;
 b=Tim9t32mNkgKhrakc0H+ba0uA1SEVIYLtsXL57zicqSoawtFSFADmZ0/CsKz/XgwH08gRqhufk5GTIQdocHCHChzDDNVKSbaVcBklRDszVzSp5yIk7FZtAypXkXe3oLAGetkZQAaGDUOQ1Dv/EjQo7lS/uroWHaGvdpUabBKKl5cNKUWG0H4IZxTB7OX3f+pOC1FpLx0VVOxyYZaW2Ekcu4AeR/JI+5LjuO4sQ8Pzvc/b7GYbN+DinjuOVZpvSjjH5JzJKceBcySrOeT39D8IrUvmfKYz9P0nRbUx5kf2hCTzuPCS+xy4kizYH7c6y+HRaGW0O5FAIANY51aAzdK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 17:55:19 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:55:19 +0000
Message-ID: <ac6860d4-92b4-424e-af4f-d6e3d5722232@intel.com>
Date: Wed, 19 Feb 2025 09:55:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Peter Newman <peternewman@google.com>, Dave Martin <Dave.Martin@arm.com>
CC: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <fenghua.yu@intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <akpm@linux-foundation.org>,
	<thuth@redhat.com>, <rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
 <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DM4PR11MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ea64fa-86c9-41d2-2334-08dd510e931b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWtqTlpJL3BKWUtydy92bGk2TkRTcGlOQldBV2E3NzJkc3ZmRXlpblErSUVM?=
 =?utf-8?B?elkwcUxjL0FZcUVBUUx2M2NXL0VFb0Z2TGFUUEgzTFptYVkyOWtKYWw5LzEr?=
 =?utf-8?B?dFhLU1dPb243aGlqSG5McExEblFiQmtzanUzSHpIM2crbE9McEJjd3hEUlgx?=
 =?utf-8?B?NFc1c0c5cGJtSTN4MDlDeldpR1RPOWNJa3k1Y3Q0RFl0VTBMRUFlaC9DUis3?=
 =?utf-8?B?VlVPaW1ZM3NUZzNqcFZXeG5VZlRxalRSNFlYL0c2SWx0eDhZSXJOWVp0VkJy?=
 =?utf-8?B?ZmplQXZDSWx4bGMvVkpJeHpsZkNMNDl4R0xEbm9FWWV1ZjdLZy9ZS3QzYXJX?=
 =?utf-8?B?SS95cWgzM01ZNU1vekR4QVkvN2ttSTE1TnpndE9aMTFpbGJ1OVVnNVAvZEcr?=
 =?utf-8?B?QUtxRVhyT1dCWlVSbmpQdUhwaXhsdDlIQ0pXS210NmJLZzBDYkZTT1Q5QUNI?=
 =?utf-8?B?RWJLWnh3N3FFR1pmQkNtZy9QalovcTdHb1ZXTlBsVXdjbUJXY0paUlVtKyts?=
 =?utf-8?B?QWtaRW96TjVzOW9teEZGTEtmMGV3ZzNmWmZnYmxqRjRtS25Vc0FFUmx4Wm9D?=
 =?utf-8?B?K3o4ZEkxbE9UWDcrSy9jVUhEdHlMdUNsaEwzSlZGUXpTbDR5UGFYY3dzWDhC?=
 =?utf-8?B?NTZvYlRYZEhNS05zOHE3K2tyWDhaRWdJdVIxMGNNanhGQ0svM0dsVEw5L29t?=
 =?utf-8?B?OUEwWmcxR09kby9kaHNUOThpQjRPQVBpbklTUlljV0tvY01OZ1d2MjY2bTJO?=
 =?utf-8?B?UzJkSjJuUGhKcWY4MFl1d2lvZUkwdjJiUDJKQ1BxK1AwWFJXWFhXUHF3bmsx?=
 =?utf-8?B?YzFEb0hNb2ZxUmoyUEZWRFF0TXAySVBpTm5BUFkrQXpCVTBnKzJXVURoY1d4?=
 =?utf-8?B?Z2R5Y2k5ZGZacTNjbTdVdkpUa3dGTVhZZGJmK1BBMTUrUnh2enRudVpqQmh6?=
 =?utf-8?B?RjFSSUZHaDlaUmZxRTVZT2tMcCtETEZJWkxWS3F5ekdOUlpxR3duSzFLdlg2?=
 =?utf-8?B?L2NMYmwrazJaSzYrdzZDVEJFSE50ZlVYMEJiRGhaMi9zb29iK1ExR0Zvcm4z?=
 =?utf-8?B?SDBTaHIwd1p3S2twM0NySHZKN1g3RGtqQnFIeFhaR21nV09jSVJLUm4xbXIv?=
 =?utf-8?B?VDhscnMvVzZXS0QxeXA2QXBORk5CV2xzZTlrb3kraVZ6MmVYTFlqbjc5OVhy?=
 =?utf-8?B?MFBTdlJ2cVZkZDhFbmFtb21GZTJkdjBYKytjVXd6bm9DZWg0eXpDaXJVU0Iw?=
 =?utf-8?B?VWx3cVlkRWhicjFnTDVzSFkvN2pNNHdqZ1NsZ3R1WmppT0ZnQUdKMGxDK3Iy?=
 =?utf-8?B?TGw0UU9wYVo3R24rM0VzMml6Vkpna1loSXpCMC9DWnUzb1ZuZ0RRaFc2RUNn?=
 =?utf-8?B?djdwQUlYMjhOZmU5R3cwSXBMOGdVWE1rbmJmcURYelFCSEFieTZ1SkVHODZ2?=
 =?utf-8?B?dDFRV2F2NWE3WGZPWXJMZGtKVWI0bmdaa2Y3WklhWERRTlFPcHd3T3hXNWgv?=
 =?utf-8?B?YUpjKzRxcHpESzdtNnpYbGxLQnU4dUxBLytoaFg1cFl0eGhldHNsVXdJcity?=
 =?utf-8?B?YWsvcTd4NXF5bDYyc3ZpbG1pZjR3ejZsbzNVMWJpaUZ0N2hScWl3alRHSmZq?=
 =?utf-8?B?OWsybUkvYnRMN1VKT2RPbTBsVW4yYUkrVHBENEZBUkx5VlV0R1BuSXl6TTk2?=
 =?utf-8?B?aFhwYURNZkVjTStMVFQ5dFJZZDc0RTJxbHNHTEpiZXAxWmc1amVhRzB4RlRs?=
 =?utf-8?B?SWkyK3ZPWVpodXA5VnFvZXlFQ1JBSzNyY0NVMjBwY09wVTFBTU5qbEVrZWF6?=
 =?utf-8?B?RTkzU0hIQS9KRExma2VrM0UrL2hzbFhkVCtUemc1RXNjRTNWNGJCZkJjK1lu?=
 =?utf-8?Q?Bvz3ZtBAapIpc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3FpYitVejV2dEdOeG91TzZFREx5M3JNVXFLZGJLYmkxRUp6OTN3QllPczc3?=
 =?utf-8?B?M0xHZzRPWThvVDJ3MGJPL2ZmOHYyeDAzL2xyQndSM3ZPMjRkb2J2cDFDYkNG?=
 =?utf-8?B?WVhiWHlXelFHK2wrK2ZVOFU4bzBlNDh1NTFBNUhHeXY4QUdQcTlXT00zeGho?=
 =?utf-8?B?ZTY5KzZuQllRcnZIQ0wrTkU5OVlWVEtsMndqQ0RVRnRKQldrMjRaS2M1NGpF?=
 =?utf-8?B?QnBNWUl3T2wxc2lzSjhGRVBxb0s4cENMWktqc3I4T2l2aXBRV0tROFZzZzkv?=
 =?utf-8?B?K25Rakxvd3hGaVFySXR6cG5YV0paSFhwUlQ5elVHTWRYeXEzYmZiYWJtZFc0?=
 =?utf-8?B?VVZtc3YyUVhwcGhNWEdGOGVXVDM1TDlkRjJDMTdKV1dRWmE2TTM0bWtTRStV?=
 =?utf-8?B?cThSRXZPdmFjcmswRXY5aWNjR0c3ODBsZUlQUXFCeFYzTVNudEpuMjJZNjh6?=
 =?utf-8?B?dUd2NTJVMUJ1MzlrcWVKSjM3a1owZS9ubVlUTXB3a0pKQmRQTjk4U2ovRXNa?=
 =?utf-8?B?a1NzNThsSzJaYis0d2VOZ092SUVlUHVtb2daYXBRc3NZakFUUG9LVmdyUUl1?=
 =?utf-8?B?NWxEalFFSnU0WEpaVGQwcXc1NnNMZi9namNiZVJJSGxKMVozSFlNTXQ0L1l3?=
 =?utf-8?B?L21sWlNUL3o4ckNwWVdvVU1PbTJjNkk3M3hpdFdCUE11Sk5sZXhEMUVFVkc0?=
 =?utf-8?B?S0dTbCt0aHZ2M3NYU2RUYUNDN1NwY1VVUmNocWh2YWFwWTB6TlV2QlZBeFQr?=
 =?utf-8?B?dGx5dTArWnZNNjFGbFh6OVZxMmtOeGY3eUFUSnVBNS9tdWd2VUs5cXhVeUQv?=
 =?utf-8?B?ZDR5VUZ0eXpxS1NJSWs4K3hRcEtJOU5CeXhmVzRpem9jd21KR2hNejQ2RDhC?=
 =?utf-8?B?K3pTVjRjZGZmRitqdnI5SEpZODdEMEFVaE45aEFQMHJCT0FyUU5QMFN1Skcw?=
 =?utf-8?B?M1NkTFQ1OU1OYldRcUsvNjZhbU1wU1greVBmeWFydlhLbi8zY1ZHSlFHTWQr?=
 =?utf-8?B?Q3psRXV1c3Z3SSt2ZE5Gd245cVNWNGxGNHZkb1JJVGVyR3l1U1dMM2UxeFl5?=
 =?utf-8?B?dGo5ai9KUFowQ24zcTFCTkV1SUNBM0p6YTRMV1JKWFRSMG9scmF6SmQzU3M2?=
 =?utf-8?B?bHVJV2FtN0NtcEV3UmhhaFBNa0IvaHl3Q2h1MzRtOFdSajZLb0wweHd3aW9E?=
 =?utf-8?B?RG5jaUZ0R20xb2wwNGpIMWdCOVFvcE1JRmFmN1BHQVpQWTFKekxJaW94ejhL?=
 =?utf-8?B?aG1aVlRGVHljdU5aclJLRUNJRHhmRHh1eFlCeDBSVXhZdXpSQ0R0MUF3d2tn?=
 =?utf-8?B?aTMrYlQ1WFVPeld1eGJwVjRJNHQzUUR4RU5PNis4Q05kZkNnNkpxeElHdWRN?=
 =?utf-8?B?RWRlcm5SeFF1R1k4L0VtZUozNUNJV2gzQkNzUWIrSVBSV3hnZjRsYmROSEZq?=
 =?utf-8?B?WGF3STExSFBvOUFsTjZHb0Fmemk3OUM5QUN5bzFPckwyb1FEeERtVHpCWHZn?=
 =?utf-8?B?QU43cnRrWG03K2YzUlh0Ym5pUXdXWW9HeXIwdGl6NkJrSmI4a1Y3ZzNtUDhB?=
 =?utf-8?B?RndkeE1UOEdyYkFKNk9ZZHZTSWZOeS9HV0UyNTl4V3lMTlowbCtPR0pEWjg1?=
 =?utf-8?B?RkpHT1Znbkp2RlFQR1plSXYvaVpCSHlSd3kzQ3VZdG9GL0hhODNkVFFySW9a?=
 =?utf-8?B?UzR6Uyt1VVNxLzJFRUh3Sy9hNERROUFOKzlWZTRPUjRoSVdSTXl0eG1UTXA3?=
 =?utf-8?B?RC9LTHRMa2UzSVg2MlloWmtWZ2pSUDFVOW4yWWdLb051N3FQMUlVUFBkaEU3?=
 =?utf-8?B?M3J6L1pRY0pOdkdpVUlzTzFXaUdvZ3BOM3hRSG9vOWNLcFJOZDN4REJkaExt?=
 =?utf-8?B?TGErQkEwWEpWWitRUEc1eDQyc3NQK0RhMlc0Qmx3eDgxemZhbnJLNXRTZkJx?=
 =?utf-8?B?NW5LQk96SzRwNmhTKzhXRzRNT0VCZzZ2aWNURGkvalp1V3l6YU1WTmRQUWVl?=
 =?utf-8?B?OHNOTmRJbnhLMmFzY1VVMzByek4zaXBNK1c3ZHZnVngvWWhHbVcwZ0xWMFhZ?=
 =?utf-8?B?bC92ak1xQml5WFY0RUtPeWhCV0JWck84NndwZUtaUW40cFFFa08zQVMwOVZU?=
 =?utf-8?B?UFNsdjJsYUx5QXZiL0RtZUlCb2plZWYxSmxhUHRQaEpMTnpVVmV5bDNZY0pt?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ea64fa-86c9-41d2-2334-08dd510e931b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:55:19.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCCy9rH7MD8DXvaHgATv/87NU2bHSfUDJwBi0NAbHnVUyMxFhsT7w58vknTJFUgFk4C3kdGNdjj50Hbk2Mbs6EucGusx1RPT57DADWLCHXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6310
X-OriginatorOrg: intel.com

Hi Dave and Peter,

On 2/19/25 6:09 AM, Peter Newman wrote:
> Hi Dave,
> 
> On Wed, Feb 19, 2025 at 2:41 PM Dave Martin <Dave.Martin@arm.com> wrote:
>>
>> Hi,
>>
>> On Wed, Jan 22, 2025 at 02:20:25PM -0600, Babu Moger wrote:
>>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>>> are required per group, one for MBM total event and one for MBM local
>>> event.
>>>
>>> There are a limited number of counters available for assignment. If these
>>> counters are exhausted, the kernel will display the error message: "Out of
>>> MBM assignable counters". However, it is not necessary to fail the
>>> creation of a group due to assignment failures. Users have the flexibility
>>> to modify the assignments at a later time.
>>
>> If we are doing this, should turning mbm_cntr_assign mode on also
>> trigger auto-assingment for all extant monitoring groups?
>>
>> Either way though, this auto-assignment feels like a potential nuisance
>> for userspace.

hmmm ... this auto-assignment was created with the goal to help userspace.
In mbm_cntr_assign mode the user will only see data when a counter is assigned
to an event. mbm_cntr_assign mode is selected as default on a system that
supports ABMC. Without auto assignment a user will thus see different
behavior when reading the monitoring events when the user switches to a kernel with
assignable counter support: Before assignable counter support events will have
data, with assignable counter support the events will not have data. 

I understood that interfaces should not behave differently when user space
switches kernels and that is what the auto assignment aims to solve.

>>
>> If the userspace use-case requires too many monitoring groups for the
>> available counters, then the kernel will auto-assign counters to a
>> random subset of groups which may or may not be the ones that userspace
>> wanted to monitor; then userspace must manually look for the assigned
>> counters and unassign some of them before they can be assigned where
>> userspace actually wanted them.
>>
>> This is not impossible for userspace to cope with, but it feels
>> awkward.
>>
>> Is there a way to inhibit auto-assignment?
>>
>> Or could automatic assignments be considered somehow "weak", so that
>> new explicit assignments can steal automatically assigned counters
>> without the need to unassign them explicitly?
> 
> We had an incomplete discussion about this early on[1]. I guess I
> didn't revisit it because I found it was trivial to add a flag that
> inhibits the assignment behavior during mkdir and had moved on to
> bigger issues.

Could you please remind me how a user will set this flag?

> 
> If an agent creating directories isn't coordinated with the agent
> managing counters, a series of creating and destroying a group could
> prevent a monitor assignment from ever succeeding because it's not
> possible to atomically discover the name of the new directory that
> stole the previously-available counter and reassign it.
> 
> However, if the counter-manager can get all the counters assigned once
> and only move them with atomic reassignments, it will become
> impossible to snatch them with a mkdir.
> 

You have many points that makes auto-assignment not be ideal but I
remain concerned that not doing something like this will break
existing users who are not as familiar with resctrl internals.

Reinette


