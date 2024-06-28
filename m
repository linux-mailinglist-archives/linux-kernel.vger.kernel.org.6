Return-Path: <linux-kernel+bounces-234227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F75C91C3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822161F23DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88B1CB33D;
	Fri, 28 Jun 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6aWonBe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CF1C2329
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593027; cv=fail; b=TZAlo6I5lN2ow17jTwQB9+winnf4le/S6BOlfRY+U/4i8iTheFwdIQ/MDnCLo2s+oH8Hj9zX547eQ1iUL+GywDO3D18zg9nGnu6cYbdvR96tu1f2I2gH2Csx35uC9Ufggn6XUGP4d3b7T+Y8cds89bE34WiRDSvE1GBugwkrYbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593027; c=relaxed/simple;
	bh=s6y3W2Yb/LQH5SlWeQ4fU4EgQzJ5BPAjyAuWOfM0Kn0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PSaiFdZ2NKHSb1nrH6BU39fe4LyFW6EPFJti8bL+7h1+nhPBUIdq0gLVRdX9vM7+smF98108Yh5APhVzNZnlRYG81sKMTt/6tUQbFLUzpwphUQtNjIJ/0RVNWHqEPu8qiM3AwNW8IQYe6IPSlFWblmWrwPXK+Vz4KTc/b6/UGoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6aWonBe; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593026; x=1751129026;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s6y3W2Yb/LQH5SlWeQ4fU4EgQzJ5BPAjyAuWOfM0Kn0=;
  b=E6aWonBemwi9VwWkUeeYDzadJz4mOfSXWMUqEkoI4siYNZ90BpCvfvFE
   xwZ5kRzHRv+XjuNyPKysSxJPP7+NXW3XuCdSAVHvV5KJ9wmGwzyvnixaL
   dc34Lj8g+AXjKxIq7z/0VR214fiqCv8TymqZmK/1vXM6fB9PpSnNzUKg4
   kmcaH+eVjo0/LTScgHqqq6CRfmPfPwtd19/8T8epq6aXCA37XQlUdBcI6
   Zu32OjNhYywMiRzHukM2TX3EDwOjka8lqGJ8jodUdESbhoMf920R4nVsD
   PWCWeiDTVO2TJ35Es8pjuTI/oZMFGFd90tNXwiuSpDkfqhG6qPzC05pnd
   Q==;
X-CSE-ConnectionGUID: FWo9nkLnReSXhqU1JZQRYQ==
X-CSE-MsgGUID: cCCXaUISQpugEfl4YHsMsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16520829"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="16520829"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:43:45 -0700
X-CSE-ConnectionGUID: vK256TxgRuafFjsEbvzNzg==
X-CSE-MsgGUID: cmCPJ9nLRmOwPJgG5QsFcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44873559"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:43:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:43:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:43:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFmdxExCqEgWKwTpt6jNOxkvH7Vtqp8skz/aMIJ9quCXVwpVkGvpVF+txde9MW4a19lPdk1BtMwKqxeqnNDlqoq3BAgRTf8hyh5K6eEr2w176WDgc4qIv4W/2lxYYeO3870xlHZGpfrBwsbXZozbCWV2XrvxBEALnpOYagXlWJiHcM6JZqjeTmGwYxprO43JBI+FL5Bzbkz7TepIjs7NezsusQHQWal46ZS4CIQ4bmx4Xg+XDg8H5T9RxW0UsE6z35ZPkHlHKii0fxvH59ClcOB20WCazPCz1plMHNMULeimghlY8naWVJAI1ORvyZlbMDzaH0maJJ8MkOHtIKhrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/laDDWKPgqX4pZFQmhwlMg+sfCXK87wOdWUliOICbE8=;
 b=E6f2aT6SwE7pynuRKquEKOjdAisF6UO2AptI3TgjIT0itW75O70AqHuHxxOeVXm/BkPR9/RO8qjhjJ5ykgpCJeEj3JYjiUnL/3YxSN4rEo/3omVJpqA4MoTGsNk+lfoSOCWOpZqfPb+SeQgJh6nE1vfSdBy4EKsntjoD9cGs6sYIpPQlH4URzoZkb1ZxIktbziWAkPPcg0ZitL346daz2LIwNG5OeH2nLEfiHUCZ/S3mzIKfHmdxs0HhVxXZoG/WZDBLfAvuo3zWJgDcYXQTglGt63idvMmV4ZHv/sIJhjrzrzX43w7UQCpYqIVIXXlxCL87BD6G3N9UuCBILGAFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:43:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:43:41 +0000
Message-ID: <95048b7d-5f84-43ad-8391-2e2ed8c38be5@intel.com>
Date: Fri, 28 Jun 2024 09:43:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/38] x86/resctrl: Use schema type to determine the
 schema format string
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
 <20240614150033.10454-6-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: e7896208-e9c0-4085-9b0e-08dc979177c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emFTUXVEaDlaU0FJMjcrclBGYmNwaTVmSjQ5Q29xYSttbE5ZUDV5TlRPSU1i?=
 =?utf-8?B?YWdPS3lCc01CYTYvUmU1UDB4RElHY1pvV055Z2x0eVhNVUhKWkp5QkJJeUN2?=
 =?utf-8?B?amRTMTlLUVgvRU1UTW81bFlVREowbHc0TGRBNHZ4bjBFRGdqQlp4Nk80cFlo?=
 =?utf-8?B?Tk85MU1XWEZxNjM1N0pXQ09qQTl0dVRsRjRidEJySlRDZjloc0Z4MWFwWEdy?=
 =?utf-8?B?aEtGclhSb2hOOW45ZC9qbnp3UGdpQzFWTFBDaGx2T0dEcW1zYXdyWkhVaXdl?=
 =?utf-8?B?c0ZlN3N1K2N0QUNYOW1XenFGeCtXdk9OVlI0R1J1Sy95aExWaXhyakxCejcw?=
 =?utf-8?B?YkJTMXFxbnB6NStkREZiVjZCQk9xYVBBMS9hbXR6WmtwMzZETDJOVDdOSHgw?=
 =?utf-8?B?MTYyN29TK0RLTWhHL200WXdvb2g3elAxSTlENnlLQ1k5bk1Bd3E2ZnBFTnoy?=
 =?utf-8?B?LzlIdmRCMmlST3k3cENsdkduNGF4SGhjaCtaZm1HUUY4OEk3d3NwVEFyVmtK?=
 =?utf-8?B?V2ViN3A0WG5heDhHQUovL0FQcTFEdjN0ME5tMFdGRWkyRzhxb1hOenAybUZw?=
 =?utf-8?B?Z1hiTzFJcFY4UzRRbndCRWFRUmc4cEJpUmh1ajM2OXpRRWZnYlZmTnBKMDZ6?=
 =?utf-8?B?RXo1SjUzTlR1UDVvdU9uZlQraDh6Qk5rc1FxanR0aE1jMUhmSTV0QnByR3JN?=
 =?utf-8?B?SGtRbm9vVDVmRHo2VUQrT05Jck9PU09ta3g3VTRkK3FNcDdYRGZrQzdrZHVK?=
 =?utf-8?B?UWlBOHR6Z2pjZ1hjMkVJbFAvYWhFeE9aaHE1ZkNhWThLNU5uSE1hSXBwUU91?=
 =?utf-8?B?KzBSOTdlOU9iSTRYQ2lZZnViYkdIOHozaUpBZFhBWW1BR2I3NTdjVndaMisz?=
 =?utf-8?B?OVNIL1NmUDd0M0Voenc1TFNHbGRhdW42cEhmL3JKS1p2MzNnd1lhQWJJOFJN?=
 =?utf-8?B?aXJOQnR5Qkgzc1l5bXBNOU5tblhkRDdaY05WK3dTWS91dmFaYjVSVDRtMnBH?=
 =?utf-8?B?bk55M0Rxcm9kMzdjWDRwVkQ4c0F2SHJlUHR1UCtWY24vZ053L2xyMml3NVRj?=
 =?utf-8?B?VTNscU5uRDM2Vi9ZU0k4c2h6M0tjVVdEUUZockt1WE9rY25qNUFuUGZ4Slhs?=
 =?utf-8?B?SXcrWnFGazRwT0g3U0lGUjMzVGNlSDZUUFg5V2ZLQ1l0Um5QcldzZVBZSUtX?=
 =?utf-8?B?dU9hbExLM0Jld3drUFZEeEVBZFFiM0Fza0RZZmw2UnVKeHZmUUJpREJRWE1j?=
 =?utf-8?B?aGhJMXJuNkRNZkdRaFVjekFydnp6Ukp5ME9ZbXFFNytFZUtDdWRSeGgrWUNn?=
 =?utf-8?B?S0lBTmd3WDJuYit2VXo5R1lhaVM1cUc0bXU3MEJObCtMelFTb1AwWkNFVUUr?=
 =?utf-8?B?V1JxcXQ0eDN2Wi8ySnhpcGJNMlgrSDFRTDQ4YkRMT2Q5OXhSVWV0Nm52azJh?=
 =?utf-8?B?R1ZEWWNLOFdQbWF5N3E3bnl4a0loOXVMQlRWVXoxWi9mOTJDeFQ4dE03eXBh?=
 =?utf-8?B?aldvb3NWOUlqb2xxYTM4UWUzYnp1UHExMTVrTU13Y2RQaVladTQvaGFBSUNE?=
 =?utf-8?B?YzVmaGcxVUZoU2NreXlDamlYV2Y1di84Vk12R05kcjIzRlNkS3ZQZ2xoU0RM?=
 =?utf-8?B?ajBPWkNNRU00UGU0ZHlVYVRNWUd6T294VlN1b0UyZjBFK0xTNWNJTUZwTmxl?=
 =?utf-8?B?Q25kYnBDLzM2OW8zVFVLcHdaZlRvOVVmRnVPazRHaHl2WUR3a2x6cjZmZ3JW?=
 =?utf-8?B?ZDUyVmcyMzZvM1JUcGJMVDN6SUZxdGJ3c3EwSTNRSkh5aUdTL2tJQzdCUkwr?=
 =?utf-8?B?SlpPSUZiOUhUdlpqL0FxZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2N6cndZcmtLbkpPWFZMZnpweFE5RmdCT1hzeUwyU2FMTU5PdVBLdGh6OXE0?=
 =?utf-8?B?blJKdGNLckxPSHI3OVQ1SFB6dVNXRmd2YmkyaGNwcmQ0ZTl4VzdFeU4xeUhz?=
 =?utf-8?B?YmkvSWUvOWxFTktpRnBidWhMd0VONWV3KzdiUXVMa0pnN2RSYURXZk9OTDJB?=
 =?utf-8?B?T3doOVZpUHFVQ21LTlhNdUo2ZnNveEV3cUl2U2hlc1lhTmZnZ3ZkVTZJS2J0?=
 =?utf-8?B?YlRLSktPcW9IVFlHRGdTSnlYcjUxdG5jWS95bjBmb1NSbGVGcWFQaFBob0lt?=
 =?utf-8?B?aTk4UFQxT1ZwaGtkMjlPRVQ5eW5Cb1lhR0pZeVBrNFpnZW5LVTFpMWNacTYz?=
 =?utf-8?B?VUhULzBRaUFZQjBoKzVmaUIxWW5FQlNzbVRNM0Jwb1hYYVVPNVhnVlNLSTM2?=
 =?utf-8?B?SnZXcVB0THZiL3JNYUdkNENFYXNhR09pTHNJeWZieDBEWW1aTm9QNWhtR1dR?=
 =?utf-8?B?LzNkVjlwT3UwMXQ4TW5Zdm9YNmQ3TE16YmtXdTRONFprRmVyNkUxemhMS1Nu?=
 =?utf-8?B?KzNHdnhoTm10RjRYK1RhNVhpZ0NKd2xGcnhKbE16cWd5V1R4L1FtTnBRb2xO?=
 =?utf-8?B?NEd1ZTFubW00RHZiYUtIaWVzc1dEQjZZMHVwc2lZNWw1K1hKeGdRMUplZjNU?=
 =?utf-8?B?MG9LWWRVY3BldGp3SnpJeXh3aE93UE9ZSnZuWDlHelpyKy9ZQkFUbkJob3pQ?=
 =?utf-8?B?Ym5ybHFLa0dQalQ2NTJWeE54elBTYU5ZVy9WZlZ4NVpZS3ZoQWpPWW1VaFBs?=
 =?utf-8?B?b1ZhbFYrRjF4cGFoRUk0a3N1ZU1mMStyMmo2L0M1VXhZMHhWNTc3cjJma2Qw?=
 =?utf-8?B?RUtUK3U4cS9GcDdJMURLcVVPcUEzanBDMWE3Z2xzZ0ZmQ2tVVm5IZnRlcmZN?=
 =?utf-8?B?SXdzSUFkYWlOQTdxb21xc2FjNkJIM0tVL0I1NmRuWC9NTVIrVCtBa2hFZVJx?=
 =?utf-8?B?blNxdTVaOVAyaGM1SS9nQi9HY1JoMCt2d2tZSmRpZlB3bVVmVENSQ1d5UHNL?=
 =?utf-8?B?aVpkYWtxZXJnL2hUVmQ2UWRNWU9qRk1vK1FHdjFVaDJWRk5CUi9sN0MyeDI3?=
 =?utf-8?B?MmxOZXlKL3VMMjdBVUhsQktRankxWks1NDFDVG05bWl0eEJOdjFWS0NJUDBk?=
 =?utf-8?B?MzN6MGxVSzlLTnBBOHpHSjJObXNidWhJaW0wZTArMi9YVWtyWXZ0VFJPa0hG?=
 =?utf-8?B?RHBPTEFBRm9WT3VHVHZjd29jb1IvbmVoQXlVdVBQVW8xb2pVMjdCQ3VxWVYz?=
 =?utf-8?B?YzM5Vnp6aUJvVE5zOTMwajZHbTEzdGN4Yk5HcTJiaHk3L2dSVkhqaUZvSWZ0?=
 =?utf-8?B?Y3NwN1ZEQ2N3bWtwb1NLUFhCNE1XeW9sUXh1eVBNY0F3N2ZqNWErelA1dFl0?=
 =?utf-8?B?R1hCbW84OUVZRi8xMERGeWxkS3A5aHV4U3h2SHNqcVN4dTJuVXBrb2k1cnJG?=
 =?utf-8?B?MWVBUFc2NDViRmwvYmxPQ3VrVmZuMUp3TFI3c1pYQ3R3Tmx3Q0dod3FvcUlm?=
 =?utf-8?B?K0dpdTEycW5NWmIrSlh2ZXQveUF4MzlHYzFmUlVTTXFOdHZiNXZocmI2Vndn?=
 =?utf-8?B?TU4xSC9ZOTcxZFdVbTdaSTNHVmY4SldNQUtoTnU4cUhoV3hoaWdiWjBxS1R5?=
 =?utf-8?B?K0pQRy84OUdPbTBJMzVGbHVudFdxNENxS21GeGJBQWx1M255ZzhiVVRrMmtJ?=
 =?utf-8?B?aXNMU2VDaHZhMlFKQTF1SVlTRElodHJxUDVHTHpVVWpwVlNSZi9RVG52eEND?=
 =?utf-8?B?WEZxL1cyaHdXQUxPd1hVMlpEWUJEVlhMSVUxSlU4ellpUDYvWEtrbUd3YkVp?=
 =?utf-8?B?YXpENFdOK3JHTVR2Ylp5TkYyZE1kZ1BiQTR6YVBDaFRNejFXa0R0OVZFT04x?=
 =?utf-8?B?dGlSNjIveW5rUG45by9BbVQyOEc5b2NrWUJ0L3dlSVJQdXB4YzRpUFJnVWt6?=
 =?utf-8?B?QWdNUkEvam92dGh0SDdnTitIeWVycnNaWVN4OXBMSVdnSTkyVU9rOGhLMXZ2?=
 =?utf-8?B?REhRenZNaGpZdjBHaEpaeFpJSzdHZkg3TWNkdEs2V0ZwRFZEeXRpYXBVSWly?=
 =?utf-8?B?RDdROTVzZ2dTeVZsbUpQMzdRanlLaHZVMWtPN2pCWlRjNDV6WmYvU0hENDF0?=
 =?utf-8?B?bmltSEMyUmZsaHZ6alM1NWg4U25YOC9nODlkTGFOVlUzN3paektZR21LdTlM?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7896208-e9c0-4085-9b0e-08dc979177c3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:43:41.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGWH6kCGoP907GuFA1ZCKaR83mnpOhABQVU3tXHRF7p4BHyr1SMTE+Yn1wunrivbse1e7TZYjWlR8wGXbE0+NGZGA0YfWBOcmW09Ausk8+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> Resctrl's architecture code gets to specify a format string that is
> used when printing schema entries. This is expected to be one of two
> values that the filesystem code supports.
> 
> Setting this format string allows the architecture code to change
> the ABI resctrl presents to user-space.
> 
> Instead, use the schema format enum to choose which format string to
> use.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

