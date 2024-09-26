Return-Path: <linux-kernel+bounces-340783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636B89877C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5731C23522
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F5158853;
	Thu, 26 Sep 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsaRbmTv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8214A85947;
	Thu, 26 Sep 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369232; cv=fail; b=BIAcVrDiNktYSVcJVPQhU4BGxBN0adyoMi9bNyz/FheBs+Z+ze1efZOWXfkN4TnvE5HsdhrKxD0he6IeAbmO6CyJKxfNiuqFrwKG87ie3adba2Q1tww/Md5NSRZD3sQX4o0vf+5V0FBr3o7HastjdfZHySUrDflZkXATFBtGcnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369232; c=relaxed/simple;
	bh=n7BhAWPOoE6iZrtQRPmlrxXDQKU1OkfLadN3PoOu6oc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mLCKfvGGBdpEsWVAKlLsGCzr+8GMM/6jV8ryXS6wCYEosrZ4Q0n251FFsPximZwvRJGVvG55rh603lEC/158Vh780PpGdWlraczj8V1kz27UVlzXME01FuzTMhZVz1DZOIuVL3/cZj7UmaxouVHQw45AOU4Av7LmISBXgcOiR/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsaRbmTv; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727369230; x=1758905230;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n7BhAWPOoE6iZrtQRPmlrxXDQKU1OkfLadN3PoOu6oc=;
  b=OsaRbmTvJ94hq8UjrQIDOpAiwTp0/yOiIzfiXn8xh+i+ZcbkFoaJyrHp
   BCq+dtYKo9yvaAmgVhOG8zzI590pEcDu/dUO7sOfkmzHL2Ybb2IZ8aRw7
   NctQKASrKfR0uSHOvENXap2ghd4Wq90KhE3QZYsNv90aCv2MAAACEvKxH
   A+1V+M8DTH3sakoTjSP9n4kPJG9vNuadcT0Qiq28sYKDV8KWXXlTU/JfO
   +MOY9zhDpJbL5cp0Yov9BYX5CgZWAW3x9SnS3xhCTpkPB4/bwv4sG3e6n
   4wAUDgvNNAuNE6qxibtqDizgt5BZfU+MosIv47eexCzd+X8u3ShsA3RSl
   w==;
X-CSE-ConnectionGUID: p03HBB8xQUWxcomcMKq/rg==
X-CSE-MsgGUID: JhGIPW5/Q16sKEpHcLaG3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="49013200"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="49013200"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:47:08 -0700
X-CSE-ConnectionGUID: tTdEOS3uSWaGkqQf0MLECg==
X-CSE-MsgGUID: Wz/53KB1RzqBbjsjoDpaPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="76739205"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 09:47:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:47:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:46:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 09:46:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFFNOuD9iUbmN80aPtmxIyRSqT3oRqa/BQbqkry85FgUOvLasj4mw78yiBB8a6tEUK+3+hHc5VBvZVlaf5XVTK2/jsNTTbZeQtW6TPUcHVZLtEc4OtAlFMd0f0rrAqRctT1HIc81ChDYT4LS+rTexMQckzd7iBYIpsV8qqHiVQk46nkPfbSTA1nUBbBlA+pgrjBL5I5fKgaLYLcPqBpzi3RP4SQOkayvtlbWCjJlqBuebj1LFmeiZgku+4WeE7TeQOCmg2tFP2r+pkOnQu4CY4vDd7OGlTovOYdTy/jkrDWizr1MAd3nytJeAJa3beTiHHDLIxNUUF67vNmFXzijDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rTMYTVfGIttUTyTNeumHE34RL4gBi7PxdI1tPqt8yM=;
 b=m03D/tyk9G/F6CtbIkoWTlpwOo7/M9Wcl0/Le7V8uxUWQfPu+oyHTekiYU+GTxiwQIY1Sl57hlBh92H6SvzLny6xXfFCj8CyF45CQDOVJD/EkWl+WHAtNmb/VOy4lKSPnapZMIp5JJjWdEeM3B4mAI16DqttRk3FVxZRTh1OnKcSZFXK6sM6zOFs+CLfr7cvKHeggDItdR2JNQ92U08yEso021K8k5m3TrIoDGT18YKg4rKBrt9JidxMMjt7VfYLgioEBsYjGETaK3ioe1hk/weugQSNBKxv0dJN7sj43zSDXelEMFM9u57FlCmjRlh2yvMcnYbDyih04RfBfGmQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB7808.namprd11.prod.outlook.com (2603:10b6:8:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Thu, 26 Sep 2024 16:46:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:46:34 +0000
Message-ID: <faf2b24e-4329-4b73-a012-10e85844fa74@intel.com>
Date: Thu, 26 Sep 2024 09:46:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/24] x86/resctrl: Add the interface to assign/update
 counter assignment
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <39a621b5281753c9f13ad50808d478575cdb52e6.1725488488.git.babu.moger@amd.com>
 <9109e7fd-34e3-485e-bd20-dfd4c68edd01@intel.com>
 <791e12c1-ddb4-4d65-877c-a7d887d3ef6c@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <791e12c1-ddb4-4d65-877c-a7d887d3ef6c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: f6aeb759-d6bc-49ae-b845-08dcde4ac7ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUo3d1RweDFoTVA0TGhESWlQd2hHMVBESk0rVjdTR1VqMWptR0liL0FTOVBG?=
 =?utf-8?B?L29nWlg2RjM4TVljSXB4dllqMUhtZWZ3SDdYSFdLRmk2MTVMcjZMcFR2OXV2?=
 =?utf-8?B?N0pTM093YlpUUzMrWnFrRGE0OGRxaitVcVN6UVNDVmJMMlh2R01XM0F3ZVJH?=
 =?utf-8?B?aVR1Y3RvR25XSnlSSHRrcExZOUU0dnFsaSs1S1Nwc1RMWkxDZ0pwNGE5SjRE?=
 =?utf-8?B?L21nKzFkUThwQkowMlVXdnhldFlXVmprSkFubTVrVE8wOUNFQjRQNWhUeWZD?=
 =?utf-8?B?QnNoQTF0cTNtQ09UeEUxZWIvMlVTYzltNjZaSU1sUEJQamZxTERQSDdoNVVV?=
 =?utf-8?B?ZGZQNFp4Ylp3ZmJxdEcyVGVSOUZjSks2aE8vYWpDcHN1dngzSzRsWEg3VVJH?=
 =?utf-8?B?Qk1RYzc4WkREUmRJNW1jTlB1bDlVanZMdjczZ0hRamNod1ozTkRadjlqZnlu?=
 =?utf-8?B?VjRkL3h2dkhoWkpxb2JLYnJEUWNZZ2FURm8rMmhSNGowRXNIdHVYc2hXNnZW?=
 =?utf-8?B?N05uNHNzeHNVV0U4V2lKOUc5MUxVN2piTjZKSmI1ZnMxUVM1WjQyRTZUeUdH?=
 =?utf-8?B?Q3Q5R1ZqVmZ5K0dzS2dRcjhMNUtaZlNRYWcrbFY4c2g2aGJaTEtnZFFodmI2?=
 =?utf-8?B?dTlVYkw1eHQrRGJycFRLM3pYTjBkd2kvUHNuemFjRGFIdHZJZCtxc21KMExr?=
 =?utf-8?B?ZDQ5OHRlTVhKaEk0TkJwUk02K3FyUDVLZEJyTWRYZFJuTFJBdUpyYkxVN0J2?=
 =?utf-8?B?NUtTeWpUVk84dHFQajZzMWhBeWFLT1NhOUdMR1V1UzEzaUhta1FNRnRzTU8v?=
 =?utf-8?B?cGVYMzYzNjZDdWRZZ0cxdTZ5emNnZVhQQ0k5RGVuaHNIM01KSjVQM0pFWUNS?=
 =?utf-8?B?KzVUeVBNRHhDeFJLMTBFNHFsa3c4a0VxOWhNZVFYcTRrNmZ5d0thTURyMEVY?=
 =?utf-8?B?clNiV2NVNlc1SGNzQURuTTVDL0ZVWVpaeTloaFFrR3pBTGtXaEtSdVZTUmEx?=
 =?utf-8?B?SnM3ZHRld0pjcjF3RHBSZFA5aWZQRDN6b24vbWo1NGFiV2hNK1IrdEJJWVM0?=
 =?utf-8?B?MEF4MTA4eXp6SHBqMU12NG9DOFRMQ3ppclRnTFJWK3ZFK3M1V01wcUswcXpk?=
 =?utf-8?B?S0dSSmd4cFp4TEVGdHoxL0lDclFnRytJcVQyc1F2TkR6d1VvUXBmM1hDOFVp?=
 =?utf-8?B?Q2FrU25ISzU1Qnd4TG1scHVCT2pLbTBpTlNsYXAraWhVSllvdG9lcG4ra2lV?=
 =?utf-8?B?WGp4Vi90MXYzZ0ZWTXE4c1ZkRDM5Q25CbmRaVnMzSm0zSXo1aUcrZXlXVEha?=
 =?utf-8?B?MHgzaGFmWFJobHlZTnNKdDFlNGViRnI2QzliZXF3M01kbHZpM09wTTJDbFQ1?=
 =?utf-8?B?TFJJMFh5RDBwWEN5QjIvQjRVWUNBWGpCUXlmWmlvVEJNcWNzZ1h0TW01V3ky?=
 =?utf-8?B?M2M3eW5FU3pKWWlKa3AvWnpWTUZFVlo4VUhtOUJmSVNQbmtOZmdlNGxUNDdn?=
 =?utf-8?B?TXRxNHh2NXVaMmZxNWNFSUp6TU1NSDVrZzZIU0t3ME1uUGcwU1lXSk8wWFE0?=
 =?utf-8?B?cmdpT3FFYXNGYnFoWml5K1kyZXNrdWtKQUdGMGE0c205bCswSU5lUHNYN014?=
 =?utf-8?B?ZEJnVTJGOWNNeUNnaEh2YjNzVTFhKzFrV0sydHZUUm5RZjZnWFVZMDdoODNh?=
 =?utf-8?B?SVhmQW4xblNTVU5sK1N6b0xmanpicDlBZ0F1Wjd3NzMxN3NLVkdhSW5JdVBF?=
 =?utf-8?B?OXNYclQrbVE2VUpXNzJxcnlCZW5HUVVpK2NNNmE3a0NoNjY5RncyK2hIZ3py?=
 =?utf-8?B?LzhXVXc5VTU0Q3dGcVhudz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N08wTDEzZ2FkRE93VXl0UDRwRmVHMVk5RjEyUkxWa0RHNUJhemx3V3hxbWI2?=
 =?utf-8?B?K3Urd3lsYjl1ZFRnTTlRYnNCaFlLUWJBYzU2ek5LaEdhQTFSMDBLRVlIeHBH?=
 =?utf-8?B?SjdhV1F4NGlMSG1mTWpvOVg3dHZZS2dIYjMxU05FdEdPd2xrTVUxUTRNRmNJ?=
 =?utf-8?B?aGt6dWNJNGl2V1IxQkRkbVFSUmROSENTZU9Qa2JUV3ZlK1ZORldiazhKa3hE?=
 =?utf-8?B?V1BhTno4cmFKUzBtVXJ6bEdUelBONGYrWlRjaE5NNklUeGxuUlY1Mi9DSGxQ?=
 =?utf-8?B?T3FuRXZTd09TMEVETjBLMDM1c3NKZ3IvYThFcmozRDF1T3lFMGE0bzBFV08r?=
 =?utf-8?B?R2VSeXIzb3NOcGxvYk15bDhJZmJiWXlTeVVVYk43bUQ3S1NFendNc2tMVENj?=
 =?utf-8?B?VzBJOEJTK0twdUZGSjFkOUhhZzhpMGVFd3YrTGVKV1RKbHkxUzg3dzF6YkZP?=
 =?utf-8?B?cWxwYlhZK0I1alJlWFltYTZLbS9INlViTTRUZHJyRE9QSS9ld0QrM1RXcVRU?=
 =?utf-8?B?QW1iZEJpOWUzUzBqb1BaWlUwRlpiZUhXTU5PM0J6MHNiekZ6WEpWRHJSeW9O?=
 =?utf-8?B?NzJJTmlXYWRjVlRESG0wNDBic1UweVJhQlpoKzFPTUgzS2tMdHBuQjc3eTAx?=
 =?utf-8?B?SG1QTmJDREpTRGxtQ0VqUEdyeG5TM2t6Wm5mSlgxSlNUZXpTRVlNUWhzKzg4?=
 =?utf-8?B?NnRGRTBGMGFUUWxFby9meVVQbXJMUm5mc0FoV1pJZzBCQ09HbUF3ZnhRR0pm?=
 =?utf-8?B?b3pRenVDaHdOVGlNUkNrRFZzZlIrcGw1Z1FGcFovWUpGSVdPdTNOc0RsbG9J?=
 =?utf-8?B?WlRuNHhhKzZqMnIxYTB6cjBuM2pvY2RjMDlhSFhZS3VrS09uMHUrNkxvckpX?=
 =?utf-8?B?VHR3RHFZT0s5b1daUVNpT1pXTUlJN0taTW15cHNKUHdqNXhTU3pkM0x6RnR3?=
 =?utf-8?B?bGRESy9SVEpXanA1Tmh2VEVnWXFJMkovRTk4RllSWUNwZE1OOEJYQ3dZamlM?=
 =?utf-8?B?ellPMFNZN2Zpbi9ldUgvbU9vekNtazFVZWhqSVp3TUNNbEg1SVB6WXFwTnND?=
 =?utf-8?B?MjI0b2psNnAwOUhOSkVyTExjWUY5ZFFhcmx5cVdNS1lMSThJTitSTjNwclc5?=
 =?utf-8?B?Umh2eTBJTUI4bk15MmdDMXBvYUtwaXJmZnE1aHE2VitvWUhWWjFOanExQUdt?=
 =?utf-8?B?MXI0d3dlSXpFMld4QUxBYS9OOXhPTkFBb3Q1dGpNLzM4MUxmMm04MWxzWnBK?=
 =?utf-8?B?TEtTNkx3TEFDYnJ2eUhxeWJQVlVManlqbUdJdE52WUxVbzJ6Tm1ta3NhSTZS?=
 =?utf-8?B?c3lTSU5KYytuRUV3dkJVaGR4Wi9MTjVBaFRNU3F6QmlCc2NGeHN6b1J3T2JS?=
 =?utf-8?B?eWJqZ2NSd085NlV3N0pEMGNvRFdpZG9LRFp6L2FzcGhqUGlybXcrMGZjYk44?=
 =?utf-8?B?UG5VVGp2WW44cWdVMUFzWlNpRjUrZ3JSYWZhQ09mcnlnS2hmb21PZk9wc3k2?=
 =?utf-8?B?NktxeVZPZ0RCSjRNT2ZXWFBuMkNJUEJXSnRjVkNnREpQcjVHalhmUFN5VEpv?=
 =?utf-8?B?SksyNTJERldKbmc4M0tIZXI4Y2xNVklaNlRrdHZEZmZpSUtqZ2dSNjF4bHNw?=
 =?utf-8?B?VGpKMHJFVW1pTWdRTzR4d042WWdqTTdibGJ0K0FaQkUwZk1IQUU3bWdWZmVP?=
 =?utf-8?B?TDRBY2RlL3kzTUpGSEtJdENLV1d5ZmVWdFViWVM3Ly9ISlF4bG50MzN4ZVhM?=
 =?utf-8?B?aEVxR3BRVjhlWFQ5QmFIM2NOUFZGb080QVNQUExNQVhRSVZsSThsWGVJa1JX?=
 =?utf-8?B?LzJYUzk3a0dFclJaM3dncmtyM1F6U0I0R3VsWG4yV3pzSkJENWRRazk3NUpv?=
 =?utf-8?B?ZHgzOVI0cTNnYXE4YzVyaU03TGd0M1ZBMG8xYVhxcFl5aDBMYXZZZnBtZ1Rl?=
 =?utf-8?B?RVdQY2liTzdRc25qZWhCZGdmMDZqRWwveE5uTzhyeHY0WWlGTnRsOHRUaGEy?=
 =?utf-8?B?ZFZtenhLeUFacXc0d3pscE4yeWk0QzZyZ0ZsSEtjeml6UTRtdkRIaFZkQ0Ja?=
 =?utf-8?B?OUZVU3R5K0ZvNXBMNU05ZFY5YjI3dmlvMU81Z2R6TEhzMENlMDI3UXE4bXpj?=
 =?utf-8?B?M3VCOHRISVpMUkRDV3ZVN0oydXpXN1Qzbk5RSmUzdXkzZUVzK1lqVEprRjJl?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aeb759-d6bc-49ae-b845-08dcde4ac7ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:46:34.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sBB3aTVse/23otAQdLEXmEbVy1es5SEcSgqP9+Qt6L8mOURUfq93X31gGEuhDGwT2PdD6scqImH9+urwQFlGHO+b1Voit4CjLmSK7EOyLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7808
X-OriginatorOrg: intel.com

Hi Babu,

On 9/26/24 9:28 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> 
> On 9/19/24 12:20, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/4/24 3:21 PM, Babu Moger wrote:
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 7ad653b4e768..1d45120ff2b5 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -864,6 +864,13 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>>  	return ret;
>>>  }
>>>  
>>> +/*
>>> + * Get the counter index for the assignable counter
>>> + * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>>> + * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>>> + */
>>> +#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>>> +
>>>  static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>>  					 struct seq_file *s, void *v)
>>>  {
>>> @@ -1898,6 +1905,45 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>  	return 0;
>>>  }
>>>  
>>> +/*
>>> + * Assign a hardware counter to the group.
>>> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
>>> + * else the counter will be allocated to specific domain.
>>> + */
>>> +int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>> +			 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
>>
>> Could we please review the naming of function as this series progresses? Using such a generic
>> name for this specific function seems to result in its callers later in series having even more
>> generic names that are hard to decipher. For example, later (very generic) "rdtgroup_assign_grp()"
>> calls this function and I find rdtgroup_assign_grp() to be very vague making the code more difficult
>> to follow. For example, rdtgroup_assign_cntr() could be rdtgroup_assign_cntr_event() and
>> rdtgroup_assign_grp() could instead be rdtgroup_assign_cntr()?  Please feel free to improve.
> 
> Sure.
> 
> How about rdtgroup_assign_cntr_event() and rdtgroup_assign_cntr_grp() ?
> 
> Added grp extension for the second one.

Is the "grp" extension needed? The function already has "rdtgroup_" as prefix so
the "grp" extension does not seem necessary to me since I think "rdtgroup_" and "grp"
intend to refer to the same?

Reinette


