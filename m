Return-Path: <linux-kernel+bounces-378981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22C9AD819
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EABCB21625
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB051A7271;
	Wed, 23 Oct 2024 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJ4wHdpp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27C15573D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724048; cv=fail; b=JwzkIPLTpLmdZLvLp4gJ7Qrfn5XFA5/Ih9/xhUqgCZczMxKvd3NlfoA892lLwfPaDph/Fne0hWcihz2wu7s1l7BgiqmhWv++47vw6TJb863E4c7PUaB8uTUxBTsPiDrZM+FgczxVIvxrq8QdMLYM+JadBSoHNFxQqn2ndAGw5J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724048; c=relaxed/simple;
	bh=mAWeP2eRO4TYVU2DDGhgxdOYQplrtwUwLtQFhBC1HfY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NyTUML1JruSH87N2aVqqJyNk73MkmMmfVbw5fHV4HthZ4KEIkonq8rDkAcqeLQO/FKJqTIsXyh5+G2Gg1GKIqBL+bn/0fXvAylUlchVKQ2TW6c/2ACHLpiaN5UgHVqJLt7nVjSFGFpFvSOtZlUtAk9Ckkr4wGU7dY1HZbfycqTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJ4wHdpp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729724046; x=1761260046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mAWeP2eRO4TYVU2DDGhgxdOYQplrtwUwLtQFhBC1HfY=;
  b=PJ4wHdppl9P5twIZm8YX6kL1RzGff6EHhxoQE05xnrYhmujbDZwuxvgm
   VekrsOV4vzwHMxjqbFz3adHjul6jE+xm7Z4tTFP7KX74G3zuJAutFRz2Q
   69d21GcElPo0gP/ZtnwgzM1KTYZvWXEh/lLp010NrVOU4hyRSX0f+JYDg
   B8YnpkHDY1yfA8DQyrSn5DmBeblXKIQCz3+UpX5DC1uZagg+8ul9a54Z5
   QD0lsxg1vBbYU5NFwCAS4HvRpWShrR6u3HkPl0OmTDA7BNZhvMSxDfdl+
   bOxNy6oZD9j4Q6xATqJpCAMDYoBWZ13ZtXPFWvlZngOB4TcqW0FpBIfWo
   w==;
X-CSE-ConnectionGUID: 5Z38zIlLRn+J2R78LD1wmw==
X-CSE-MsgGUID: 8ulruCmhQ5WyqHM/nm4FWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29497476"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29497476"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:54:05 -0700
X-CSE-ConnectionGUID: 0gD4oiKMQemZwo5N8kkqZQ==
X-CSE-MsgGUID: GCUlaqZbRJ6CwdSLd7I71Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80820365"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 15:54:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 15:54:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 15:54:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 15:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndsRBxNClduSEzKJRIPOqSMK9eOPCOPwdwnS2FnXbmy05o1u/J7N+ZuRm6ujNPLGDre9v1bPdmmYmHDFr7Ptq1+XL5nFrlwR9Tjufkr1zNIlt4uCo+nfj5/9xGQXS7IuHZwnpSk696cin7lKvfou/pHExBUR3HqbjCVCRNs8MVe94vP1tEaCfEKU2DtqfzUUqCv1n1o9N13lJ3aSkh0UZxQ32cLtjdghvov0mAIriqmxMEWu9Cr4PgDcxUtkTUJMJj4heWxqskM9VNbEgMN/16f8r8lOXgfnk6Etvc67D2guUV8Bg/3FCtFCgUAJ0AEFfhjjgpp9oFP9H6GZ1+kdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNXbkuRbpAhpu0eF5J4I6WbvKrXndINT1qKRT2oRR/E=;
 b=auMMyaBYOUQ+KgdaQcgliqGpWtc1dv95GQH32NB/tPsMsegq75nUFggXX3gxd9F48/TY0CmvMi+YZlrlJrf6bOdtaAZPKbTbuZiifr4jgx7ssh47CW/Rdp3bphXVbH/IIh0a8ry1pBRSaCgfcIPbHkOd+tGlw/ZzfpYDM5QfduqyBw8ZqhYbO3PHlEJiEeSdRx7IDIDvTPccY5l5AbMMWipRqa7zkOl/WUXeRT9iXpsiINJlRa7IQEE6ySQtJkg9ylIsU++P4SdwGziI8r5/jfnMp1VDJkkF9NhLGE1wnWpqUCJWBxIjo+SuDtgo6C9qspDzvRXRdmRSMbqEhxTpOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 22:54:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:54:00 +0000
Message-ID: <d174c794-6b7c-4a34-8c1d-b992f6eb7095@intel.com>
Date: Wed, 23 Oct 2024 15:53:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/40] x86/resctrl: Make prefetch_disable_bits belong
 to the arch code
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
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-26-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-26-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: 910dca1d-008d-4f7e-b1c4-08dcf3b59550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGlRaXQrUnFJQ1k0bFNZUGdlSW9SOEI2QVkybW15UlZIeXVOVUxZbG4vVWpQ?=
 =?utf-8?B?K2dHUWpvQmdNMTVvSWlZMHFZdUNsRWRkOFlYeWtKaXdxTVZucVluZkdSc0ZF?=
 =?utf-8?B?eXFlSERHVytsaHRRTkJWMThOb2VHd251TnY3ckptMEpQNlBTOXRFdEE5dVVr?=
 =?utf-8?B?azZmQkhia1lET0tKTXMwNzFEMU45RlJ0NGRudHVQSW1VaVlaOHo5dzdlcy93?=
 =?utf-8?B?VVR2ZjdZZ1REczNkSEM0N3lLRE4ySHliK1I3bk1iZUVJbG4vanVacmJ4V1lk?=
 =?utf-8?B?aFI0ZDZoK1l0OEtINlJZL1h5Q3A1Q3lGbUlsWGtUbGI0Y3ZXNmpOQWE2S2R2?=
 =?utf-8?B?czBjTEhvVXhaUmRyZnZoUVVqWDFndERJUnVQMUlGcW5lSWhCdnFsTUNFTkVC?=
 =?utf-8?B?QnpoZGFlMXJ1dGtPRmU5bFNGa3hnUHFIL2huM25jTy9IZjZOcGNmcHczbGM4?=
 =?utf-8?B?SmIzZkRHbnlDcWtKQW9kaUpURzUza3A4NSt0Rnp2c0M5WTl0ZGNSZEhBbDV1?=
 =?utf-8?B?V01oK1FuYzFtSEE0RW8vMk03R2RaZTlDaWpnOFU2YlFCd2phdTBEVEFQNy9Q?=
 =?utf-8?B?THlLcXhkVUZmZEF0WkJZSjduTjhWS2RlNEhVRDBNVzI2YkxmSmhRdUF6Nk9a?=
 =?utf-8?B?cG5rMUtWbEd4TjBMamtQNE00SlR3eldtbGo2aHZIK1J5bHEwcFFFNWI4ZkpE?=
 =?utf-8?B?UEtPblhIV2RHWDBxa05Fa0JYd2VadVA1ellua1lOaWtYYW1nVUh4R1p2dVg1?=
 =?utf-8?B?bFdIUkJmTFIvVEJFbVB4Y2hRU2huUCthelNKUWlPMzQvU0QzNTMrMjNLWC9h?=
 =?utf-8?B?aVA4UkQwMGpDVmRoWDZ5WmY4T0JvaDVDd1QvejRvSGRtSzlMNnkvZXVSTEdG?=
 =?utf-8?B?T0hQN3BseEYzYjZWM0N0YnE3MVpsbWdLeUhsUjl5WWk3QUhybGxIZW9tYnBy?=
 =?utf-8?B?NlV4ZGx5SlRzZU8vRGtuOXNrZHBWY2sxZG5ua1VhUXRXN1ZsZWVVRWJrU0FC?=
 =?utf-8?B?OXk2cHM1VE44ZlJjemQvTEd1Z2ZHTjc3VVNFYzVmcXVJYjZFOWlRWHNHeG16?=
 =?utf-8?B?amdIak94UHN4cXVvYWxHcXNsSGR2bkp0M3pBZFlYb1M3dUkzZ0t5d2ZqUUtu?=
 =?utf-8?B?cGFUeXdUVzM1dGtGNlZlMTRiYk1JTytPTC8wTlNXWWNQbVRDTmFjMnAxRDFM?=
 =?utf-8?B?SjFlQmFoelZheTVGd2RYdmFmdUI2Y01aZ3A2bGJYTnAvVlZxcHQ0RVZ2QTZP?=
 =?utf-8?B?S050RkNWWWdIWVNFR0xFdkkzWUVsNGNFTC9JblNRdmd0OWJ2RFV1aERWalZs?=
 =?utf-8?B?Zmw1NzNLWTFaUzlTeEhibFovSUFCWjBhbXBLS2s1YmZVYXBsQjl1RWJDSnVl?=
 =?utf-8?B?Ym1RMS9oM3A5cEk1NDBNeUlkMmd1VFh5RmdzekJSODNoa1JkMXhoZlZiOUt4?=
 =?utf-8?B?WHRHV0JkTWFLL0lBaVQ2UHQ1c2p4c2lwNElEUE05OFovRXpRRFBYY1hnSE5M?=
 =?utf-8?B?dlhiQytSd1h1SGl0bDBGMmloSSsxNGpTZXpUVUxseTc4ay9pR09iQmZDNHZT?=
 =?utf-8?B?bHNzQWpMMDc3NlMzMFpvVVpDa0xwMFFrQjg5dFV6R0FZT0Z0YnF0V0c3dWcv?=
 =?utf-8?B?UndGR1hyZDllV0c3Nnh3dStKUHA4UFdsQUZ4dFR3VHpHbVhHQnp0YlNXSCt1?=
 =?utf-8?B?My9SWGJWOE02TS9MakFVOFNjSnNJOHFBSWhJbmQ5RERTT2g1MTNDYVl4RHBz?=
 =?utf-8?Q?QqUX8k5bu99aHgC6BQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlY1NDF6ZHQrWDVTRTBudDc1UStqSENiditQTzJnK1ZKK2p6RVJXR2hyYXE3?=
 =?utf-8?B?aGc2aW1pbmRyMjJid2ErcnFPbFRGK3NqRmVQbU1uYlFZTXFDUEYyMm1ObWdN?=
 =?utf-8?B?MkpxSTdxQ28wT1dCMHBxdVc2ZHRhV3EveVZuYmdaZWpGT2RHWFZMV2lmUk1j?=
 =?utf-8?B?NXVEcS9ubXVCb3lnRXBVSCtwQTlBdlJwQnNQNHA2Q2hxdnBlNHN1VllGSFlm?=
 =?utf-8?B?YjZwdFN1WURwbFprMGVlcW5HcEVSZ2gwM21KdmFuc3ZoZ1hnTTlOT09Hdm1P?=
 =?utf-8?B?WUJEd21VV012UEpKZ25tUktOYjJ1Q2FuclY4N1huNnNWbzROZWprdXRUU0kx?=
 =?utf-8?B?TWhad0VLM0lTTjhQWnRZYUYvUVNPRXY1a3lXMTBhaDRzYzJIT2JFNDJTb2Zq?=
 =?utf-8?B?UTB2bGtIS0RTTFRFSmdxL0dYSkRCeDF3dDI4SzdnTS93ODgvRExBUmIvZEZ0?=
 =?utf-8?B?N2JjSXNkeXFmdGx6NS9ERXBTcjB2Y3hvdmI4dU81b3hRQUwweldwWFZOa0x0?=
 =?utf-8?B?STFEdCtPUXhIbElPV01sYk1UZnRMNk5ZcWVOdUIzaDN2YTlySHZSQWFDUTh4?=
 =?utf-8?B?anpPbTFtZC9ZQ255K2IzZmdsUFZnSitYNDlobjJiREZaOEIyTlVPNCs0TXF0?=
 =?utf-8?B?YmhOQzJSU3g4Z0VUWEFjc3JHLzVBbzlwMDhrZ0Z4N2k5N2xvL0ZVWEZ5ZWhl?=
 =?utf-8?B?QlBSUWhzU3owTzhwcGpGS2pLaUlzZWNJQ2wvMUxYVHRqRkFxKzhUb04vSGpr?=
 =?utf-8?B?QTY5dlN4QlpkVmhnTWVyemJSM2Raamp0Y29Td1RaVEtWbTREUzVKMFdCZ2Z6?=
 =?utf-8?B?WSttZVVMWVRQMU9ISlV5dDNXSXRURW5mVk1TTXJJc3FDRjJxN3NRT0I3V2Rl?=
 =?utf-8?B?TVZDSSs4WWQ5VFRveDRQWDRzaGl4bEhLYkRKcVlLRk5CZHhXYk9lcHY3U3Y2?=
 =?utf-8?B?cnd5U3ZwV2VqdmwzYUlEZ0VMY2RSWFdaZkpzMGNMS3NtdFBCUkVaWGthU0xS?=
 =?utf-8?B?VmVFTDlySVVITG9HdjM2akY2NDFhczNtYmNIUHFrZ1V1Uk01TVQ0TnhnVHdr?=
 =?utf-8?B?WTlObmNDS1VkYTZYYWtzaGZrRlNoVnlHeTBjSE15S3hkMHNOREtTRUUxb3Vm?=
 =?utf-8?B?U0pjOVdLY0tBU3l2TFJoZms3WHBpdUJYZGZFWlZBWnFMTE45bnA0K1VnYmkx?=
 =?utf-8?B?ckFWbFFsMTdIcGdjMHZIUXRvREZtQnpuRE9VZEdjaXRINmttckJuWGx1RGcv?=
 =?utf-8?B?MDdZb0xCWDJsR3huekpzc2JGRVZtL0YzRCtLNlpsd3YrOGh4UG9rd3MzUlZr?=
 =?utf-8?B?NFAvaXJFRWo5eHU1T00vOWpKQ3hteFh4NzExOTNyaERjZkE4bVQ3a214WTZH?=
 =?utf-8?B?UGxkV1J1TXRGbTNQc1RvYkR2dkUvaFlmSHNQTnlaNFN2cmRmWHBoVUFvMmdO?=
 =?utf-8?B?S1M5ZGZaQ2ZxbzRMTkpCdDRjYUptMFNHVXdjQkNXNU92SVluZ1IySUtsVVdV?=
 =?utf-8?B?M281eTlDZjBibVN5Mnh4dGxpSGQwcE5vZjVqQVNqdkk5MStTSUhLWjlDZkRw?=
 =?utf-8?B?QXBmNlZobkFwdU9xa3ZCeU13SDREWW55K1NBS0NpUUp3eE95RDg2Z3ZreVhj?=
 =?utf-8?B?emxXa3FEWW01NlYzNnBSczdXMDB4SEpnYnhiUHZQZ3M3OXkxQmZ4Vk8rVGhl?=
 =?utf-8?B?Y0xrQWY4SktXaEVFR1o0M0V3MEZiNTZ0SFJMVXlubTNWQ0VjdEl6TVVRV1lO?=
 =?utf-8?B?RWNhb0JlKzhJZWFUMVVUUndiK3hSQm15c3JqSWR5eTdZaSs4K04zVTlPR3Y2?=
 =?utf-8?B?Y2Qva21FK3RGWmR1R3ppMjJ1TFhWc2VjdkZXbCtNN09vMDVUMmYxRVd2TGwr?=
 =?utf-8?B?SW5zZk8wM0JUUkhHbjdtaHpsdnRIVjFYS1FOS0F6anlSaWdWUHdGRFRpTkJP?=
 =?utf-8?B?UVgxOFl3bWs0TGZZUjlWeVRRNDkwR0tjMjJIVjNwY1FaeXFMVE1PYVlVL0pX?=
 =?utf-8?B?WUliajVLendmdUtBRVc2L1N2YlJmMVhheTNQK2sxQmIxWFN6M051OVZkZDhP?=
 =?utf-8?B?Qy9KdWNOME1DK21LV1piazE1RVZ3amRaVUlhTWdZZVpLMzB4dXhTTFlyVHhX?=
 =?utf-8?B?QUNUdE9SZHNZUWdCUUJNT2I4Q044OUIrUVF3VGRadEVCYmFuc2dzKzJHTWtN?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 910dca1d-008d-4f7e-b1c4-08dcf3b59550
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:54:00.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyW7KGDyGV6sgSvTgMLDAulTlblanY19ZnuXwb9WxWJAuMb4WQ4USpl5VHRrurGC8ohzW+lVR4Gg0ULnOoYUbckx35S60fZ5AJ7VxkZeZBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> prefetch_disable_bits is set by rdtgroup_locksetup_enter() from a
> value provided by the architecture, but is largely read by other
> architecture helpers.
> 
> Instead of exporting this value, make
> resctrl_arch_get_prefetch_disable_bits() set it so that the other
> arch-code helpers can use the cached-value.

The "exporting" term has already caused some confusion. How about:

Make resctrl_arch_get_prefetch_disable_bits() set prefetch_disable_bits
so that it can be isolated to arch-code from where the other arch-code
helpers can use its cached-value.

(Please feel free to improve.)

Reinette

