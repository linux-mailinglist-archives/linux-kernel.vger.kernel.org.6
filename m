Return-Path: <linux-kernel+bounces-413419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2E9D18CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D301F229EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693491E2838;
	Mon, 18 Nov 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpmWzCdG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E41DED7D;
	Mon, 18 Nov 2024 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957810; cv=fail; b=CC9rpmEARfwNgifGUjVvWU5rFe/7Jt4ymFzIqW1QhqbkJ0i3UkqpSrpkgNbjB/btE0FXAObQgKxqc4ZiZHgtO8o+wGmON5TurywUsioKvRWZ/9MQjU19kuncfXZBgP3HKMnkQyZu8S3NaCMafZ6Tpl+U1nVDt1opdrLYSyRN3lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957810; c=relaxed/simple;
	bh=PhQuZ6uFN+1oeChrDdG5vhdo8AUSWVaojRZH8AfzwbM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hG5EiB18nnzzvAEZFTUAcsdMA+5nQ17+ao3glEXAx9Ydqvvi69ltHuqNDLO/iCoH4NmiMVy4Kb44/9CRdr5A+SouMRHua2muzTh55FZUoapk/BRNjaH+3kyi0N3TFgah+YrzVVLycRUiD4ERixOSAIpWRqVHuCQJnzvbIm3uqMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpmWzCdG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731957808; x=1763493808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PhQuZ6uFN+1oeChrDdG5vhdo8AUSWVaojRZH8AfzwbM=;
  b=LpmWzCdGYNe2xLdUkGD43nBjGgEK0gKcwDwDWpG9gQ7kjCQlhx+PFKj9
   BvY+z0treVL/jkfZavzYLX3pyhnJb9xp1T5jgI1YHGCfWWscg5i+PVZYI
   k2ESl9SenWrYp5H9hq62Y9A5+nCumudoi8CuEbIRfBsKOX0PBbbpPoWVz
   Rl027NC6h+0BEALualKG+xOhmkXtmAykPMTCH2xXtZNB0KzU8vA/NuRKa
   qH5c8J8ra2inKZX022m8PtScEUbaEHOoMAiihYIALjJeTEnStZm4cQSl8
   E/ixu/iytbvoR27kdG9Rpcg9KLrHV4pQU26pXIjkYjj6mGJNQWKHb2f5d
   g==;
X-CSE-ConnectionGUID: NvH2TsqnSCOX5PLSV4JM8Q==
X-CSE-MsgGUID: PHvRvVYnQ06wxMX7m1zU9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31869843"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31869843"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 11:23:27 -0800
X-CSE-ConnectionGUID: 51xsrVBRQma8EZ6suVkfrg==
X-CSE-MsgGUID: 0WiOhb0tQoiFrsZnLn36Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="90113267"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Nov 2024 11:23:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 18 Nov 2024 11:23:26 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 11:23:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 11:23:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgHKt+rZOR8s8XrcqQa7kUOKiU4KUB4dHeC27WprV2xpjmUcpKUMF4v6hqnIbV30quMlXYq0d15zve3wWZGZGDq3jXxmhCOwL2pvL1OYuoH6bRkNdj2TNpzyDBW5posHY+P4nCb6ALKGYJojb8StWqrc+o4BYW7ESEaARg1AlzLiLQGC6OMSoDDUAvlrJ7UIO5QZIMjFxTNQY/vUE7HepNHM2H0f2B9hLCfJzyyJBniYvCzjrnGYs8xXmdeLaP9BxdAWmWljVEG81nQHU7G2VB9eOElqaxYGxL+6E0JFStZ9qFFFbOM08lTNDayta8rZUG9L433mCUPtjdRPQOeuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRfHkrFF6cFGD8sbOKDaA+chBBPHt9fQim3vMhzWnn4=;
 b=LmEUERNVKzfk7zqZhnR3FqFeTZi8boR0JYU15gCsNgtZXtiTeKE2yBld7iv4VIcKNoBUUOCUMb2opUTPk09Qda7pPUCcgKunsvrqMxzwJUHJBzU0GZw1kTNiqoIjRAsw02iVDztMgnmNtPuuFMna4PZQRcKQDeXMWCvdwiLR7oiH4ax+B6g85edB34kbqz2xVeoUNrtwM8cMc2sjPc/PWElAgFrBKrua/dzuMwd/IR7kTTJKEnaO6fR1l/8C8Dg7OZffc97QEubjsggGOf+d2h0bYs93hsKEHomny5ZaWqZLsb74giy2vagsJPoPh7ctPCQXxY79KLNockwGS/gfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 19:23:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 19:23:21 +0000
Message-ID: <af70578b-e682-4e7d-8373-61f61fafdc0c@intel.com>
Date: Mon, 18 Nov 2024 11:23:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/26] x86/resctrl: Configure mbm_cntr_assign mode if
 supported
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
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
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <2964648aa19f9d961c76c83a25f10fe3993abf59.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <2964648aa19f9d961c76c83a25f10fe3993abf59.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f491e3-0ad8-4d3d-db0a-08dd080676fa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW8wUkxaYVJpaHB5czRJbStIMlJ5aHFENHJLczZRR1hJaDg4eEFWeXo1UUxB?=
 =?utf-8?B?RHVYSUxaODlXUUFGdTV0cGQ4eWptRG14Z0Y1ZWVJMXl3VVMrMmdMZ0ozSTNG?=
 =?utf-8?B?RUlHTUhhOUptUmNESHNwMTU3cHRWaWY2ZVVaTHJWaDl3bmhRelhLZEkvUXpi?=
 =?utf-8?B?VHpaa0twN2o2WFhoOE42U2tOZWlaZlhkNjlOd0N3R0lPV2RzZTZQbWJ4bDlG?=
 =?utf-8?B?WmRBUCtLRHBoZmVkeENwbTN6TElneEdVbm5VQzI2KzQzZTlqZmEyS2VkLzVt?=
 =?utf-8?B?MU93a3QrVG1aQTdINm1YTWtxdVluYlIxMFRGQVhDRUM3V2tVenUxZ2J1cVBi?=
 =?utf-8?B?Qk02aHBkUXNId2V4SjRuQitmMFNlR2syQWtXWHVsdjNUZkxaUmlWQTFYQURU?=
 =?utf-8?B?NFRJNGxIVU5Lc0hFOUU5eEVSanVBZkJOcW1rbmtTQ2xCQWFKRmZPZlduZytm?=
 =?utf-8?B?MWtIUDNzd1hBR3dMd3IxWWk2ZUhiN2FWVUxaVzB6WnFSR0YrakxqL2dCdzZH?=
 =?utf-8?B?Nyt0aURsbEVaMXVuL3RkR2MvNm01dUE1eEEyLy9xa0trUzBhNFhhVTNxKzVC?=
 =?utf-8?B?QUZhQkZGbzB4bkhvUS9HRG9qYnJkWjhQRmtwOVB3bGlieEN4OFcrTnhtUG04?=
 =?utf-8?B?cGFpUlZLWjNtM3c2QVBodDljR0FLa2ZnVmtoanFaNEVtRXZLZHZ3L0hwUHd5?=
 =?utf-8?B?TEtqanJ4QkNpdS80ei85SWxYOUVVdGtDbXpWRUtEeFZubUJkakxOblVRK0FZ?=
 =?utf-8?B?WmR2cldnSlErS1RESmVDUXhUdUVNbENFbXpxNDhkcXpiR0Z1azdIbmowQmx4?=
 =?utf-8?B?M0E4RmpBN0FSeUhhQmptdDY0UXMzQ1pSTVQ2YTllS2kzamUzeENpTzVxMG1Z?=
 =?utf-8?B?YlNjbmZYUEdmL0VKNGJWcGZIZ3Z1UUM2UytMeTFmaUp5VDR5c01jSnNLaGlL?=
 =?utf-8?B?U3pJZ3NYdUIzSnpFNWtJQzVNbXdmYzlZaCs5TFVmSUFaYTlyQUlsY0pveTJP?=
 =?utf-8?B?MG1XOU1VWEt2cEFyYnFxbnBRREMzc29lWVdYM1QwV3lXQllJR2d4NVNIWE1j?=
 =?utf-8?B?TXBaRkgvR1pLWTFzRVlyb0NzUFR4VzBYTmVrU2FzYndvZWxmUU80MDNtanJy?=
 =?utf-8?B?SnE2VkFORWhwKzhRLzdQMjQxbTRxTjBOU3EwaVhVZjFReG0vZG1QaGprL0tR?=
 =?utf-8?B?THpPM3F6ODF2ZlF3bmxQdnhZNlRvNFh6UGd4djFkcCtJSDlOc0RzOURSbTlV?=
 =?utf-8?B?a1g0S2NXMUhxOVgzWkdiN0YzSG5KeTBPWklTZFhLeHlPS0VVaDVNQmExY3FQ?=
 =?utf-8?B?blNkVnk5djd0Q1FwaVRIeG5xWXM3cjY4ckxFUkFxb2RnM1lqSHBQNHBQTWdt?=
 =?utf-8?B?V1drTEQ5b2ttNHBYWTd1V25McEE5UzRoU2UzQm5RSlAwNEdNMVF4VFVJRWND?=
 =?utf-8?B?WmNLWkoySDdKN1o5NGx0dHN5Uko2L3NDODd3OHR4TmxTdG1Ec3R3NGtmZ3FW?=
 =?utf-8?B?VWFBdmc1bkk1anQxSnh3WnpBYi9JOXAra0M5ckpVTEN0WEtNcUN0UDhtT1p5?=
 =?utf-8?B?Ukw5bisvbTBUSWpQKzMzYXFqc016ZFF2eTFUam9DVmdsQWhOVUYwMEJNWWZ5?=
 =?utf-8?B?b0IzOWZ6N3NxZE9INjUrYVdJQ1cybFJyQWJkT0lTRkVidE5HSW1KMjVUenhp?=
 =?utf-8?B?c0xBMmRrUWl3WFVlbXIyMy9aMmJzbk5RZ3NjMG8vbHUzWVJHb2FwUGp1T1lM?=
 =?utf-8?Q?o39TQAhnY6OenYLh4Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3lKMVdBVUJoYUVvbWs3MXpVYWpvNm9MWUpRenB5eG41TWVvMFpRdEF1T1Y4?=
 =?utf-8?B?WUJuTWdvY3RpVkVxRlVYNmU4eTJiOVBhdThlSnVzdCtYYkRFNlVOc1kvSDA0?=
 =?utf-8?B?ZGZjTUlISklCTFBXM1Bva21tSDdqa3RrWU9OdjRDWURWMlNsMWMwMGN5L0x5?=
 =?utf-8?B?bjZrSXdMcWFLUGR6ODE5QVNXTHZpZkU3ZTZmRTNKM1Z0RDZQSDcwNHl1UFp6?=
 =?utf-8?B?VjlIVXM0djdwbHlnNXg5cDVQSUVMV2hIcElTRjhlQWJCRzBHUC90WUxuU3FB?=
 =?utf-8?B?eTArSHgyemsrb29qVzFFMUdEODcxSkpQUWZ6Y1dEMUhmb2ovejlFczduUnZ4?=
 =?utf-8?B?dFpodE1VWC9sa3gra0Z0TFZjeFFaTGlFaUkvNGdjeWNmQVp6MXZQMm01YTBG?=
 =?utf-8?B?WHIxWTR0SFQvb1ljcjUwWHhPSjgrWjZ0eWtjVkJVc21sSW50dkZMTi81TytK?=
 =?utf-8?B?d2NGRFN4RUJFQjVBQmpxZWR6d20rU3RvQmpiWms2cWlaOVIwdUxSM1RBK3pa?=
 =?utf-8?B?Ylg0dUhsNENhTWJiYU51aG1HSUlSMzYzUWRLc21oMnM4QmVWaFNUeTBOcDFZ?=
 =?utf-8?B?cXE1VGZZTGZTb1VDbFFvaENxcHgxdUw4bWluYWEyYm5GQ2FjczJvRU9VNms3?=
 =?utf-8?B?UGowNEpqQVZyZUU4U1Nua3RkWWdkY0IxUkoxYXM3cURpa2h4ZmN4QlloWi9k?=
 =?utf-8?B?Q0l1Uk5VWXM5bllGT0lZV2Vub0Z6cWtvcVhpNGk1ajFCNTlMblpEZUJVdmE5?=
 =?utf-8?B?WGpaUk9GSWN2N1dPc0VDMGVGSmh0NVBmaldMekJ6YnNLb09lVUxTYjlOWk1D?=
 =?utf-8?B?TjFnZzU4M3RJRTVVc2hvbmF6NUpyWHYranNPNkxUcmhwRGJid2lXK1RpYm52?=
 =?utf-8?B?Um9YTXlmZFN1ZC9KVFMza2E5VzBXUzh4R3ZYcjhKRTk4RHN2T1hvTnNJRUZL?=
 =?utf-8?B?RkhNTnFpZkpNTUlRSUpLR3pxZzNhZ3RKM0c3UENhTnpRVWh2SlRIYU9mVEhX?=
 =?utf-8?B?d1ZqZVhmNmhtMUJiTjJ1dHdXVUF2cUIyNURsdEpqQ2tzZVprSkg4dFYwdzEz?=
 =?utf-8?B?bDErRi92Ni9Td2RGNVoyTG9DS1hHYWJwY2xxZGFtL2J3NngwOVloelA3UStS?=
 =?utf-8?B?Rk1DSk54N2RZeGhuQVF0ODdOQ1R1Z3VoY2s1MmttM004UE1hVHlpcEdRd0tJ?=
 =?utf-8?B?NEtkeEg0dm4xUmpiWHUydUpzYjZaUmorUXN4YlRaOFNudWYrd01qSUJVV1o2?=
 =?utf-8?B?V241eWJlZ0lKRERlMHUzTXlmRnRNV3ZtWStHUHdVYzl2SUExRHNqa0Jpdnlp?=
 =?utf-8?B?SEphK1h6aGFoUmlLQys0Z0ovQS9CUFhXc3hwaFlzQVNBODRTN1cwc0oraWll?=
 =?utf-8?B?a1JZM2d3dlRYQnBab2RQRmxCYlNTSHdPdDRkTk12cGhiZ3VSVHNHeXNzTjVp?=
 =?utf-8?B?MmVvVnE4Q1BkM2hvOEhSMkxGNEJqWGg3RmhYZm1Yb2hZTHI2ZlhmczBWNEtu?=
 =?utf-8?B?WXhNUVhSREtvRVFaRG9TTHpYRTdHOW1IemcxSEE2aGZRUEhvdFJWMFdlMHlD?=
 =?utf-8?B?UXo5eXRQVDN5a0lIdDNVdWR3ZS9sUWJUd0R4bk5PbzFKV1Bqdi81cW1neC9R?=
 =?utf-8?B?T3dQOFJDTU5SbmFYYXZibE9lMWdYSFJvUGtCbkJKNGpxZ3Z3b29MOGxmMUUv?=
 =?utf-8?B?bmZ2TDZZTEQxMkpjUFBnOUhHdk94U0JaOEVDWEpmdUVlcHYzeHRkR2hyRThy?=
 =?utf-8?B?TSs2ZmM0eE5QTFpMWWY0a0NXNWxuVEY1dG9zSExOSWZ1VEVlM2J1Rkdqb1BH?=
 =?utf-8?B?SlBGOStBQlN5b0xKREFDMU9UckZMOTVpSHJZeW83MTN0R2FhWU8wNGhHVEEy?=
 =?utf-8?B?Z0lLeU9oQzNiZGROVWFGYytUYzdjOHpsaVU2TnE4WG1PUFo1ZC9FVFdhdG55?=
 =?utf-8?B?enNsK1N3WGJQMVBRWDNzQ2xBcjVkOEVqSGZtcWpSdXdGTWFZKzZrNXRvdFhU?=
 =?utf-8?B?clJKT1ViWHhnZENYcWM1VnNodHJ2bllwNEY0ZlRqSmF3MGMxUmlUeTZYbkdP?=
 =?utf-8?B?ZnQ2MXIvWU1YMVBZbEdIMUJsT3U5SW5uT3Q1cmRCcDlveXNpUnZnUWw3YWtH?=
 =?utf-8?B?VGUrNkdMUTZxQ1hKamVCd2ZnMkk4NitTOVA5eVk4c296eVpYWVlHdjF0Vm9w?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f491e3-0ad8-4d3d-db0a-08dd080676fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:23:21.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rZrBfZd1ECEa/ckN3XLRt0EXGhmMPD1RZ1fCQhJukMf69RZhRWMHjeRQRrSrAc9GH/KnNpkrnayy0a/bllRG4ZBkj9wySZlCCzmHP/TkbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> Configure mbm_cntr_assign on AMD. 'mbm_cntr_assign' mode in AMD is ABMC
> (Assignable Bandwidth Monitoring Counters). It is enabled by default when
> supported on the system.
> 
> When the ABMC is updated, it must be updated on all the logical processors
> in the resctrl domain.

This needs imperative tone.

Reinette

