Return-Path: <linux-kernel+bounces-522751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD7A3CE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47274189B78E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620A9288D6;
	Thu, 20 Feb 2025 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOc4Jwtf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADA23A0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011910; cv=fail; b=IgybXRe7QIw8GK7TuMmAZh6VXb8lZ9XcfdvDMU7Cb41r3FhJ/yjS5vkXU4gnb3HcU2NpiHQxGTMMYJZ7dnmuGvTMCNXH6TRLH7UBIyRbf7ojYb/FBEQO6af2xaS8Ss5+FM/zH/wH6Y6sFlERJcO9a44CrorNrDuCFiPnL5TlD9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011910; c=relaxed/simple;
	bh=HFBLabgpONcHInV0/TKrnZJRW5ndcabQzSndkdUvBEc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xq0UFK9C2vwa5/sPUoPRRhtb8nlyvHjx4mKZBWMaPD8T+tX5gTj1dobp7RrreED+qpiG8L7eVDF+qSEYIg5RTrL+fVZVPW5GAfS8Xm7S8kiwO9aBtonbnC+2r0cAt1klvZB8Ju0YW3k0a4QEq9OrO1VbBB7mzfhp7ngfztu39BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOc4Jwtf; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740011908; x=1771547908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFBLabgpONcHInV0/TKrnZJRW5ndcabQzSndkdUvBEc=;
  b=IOc4JwtflAleIfdjMEwDgjhbOgp8mDnUhS4RGj9tx5dl7xgC9khagW1B
   cGAXbz9W+WLYYHZGRREyAQHxi7hZoomv21d+Pua3fFnBaoZOuHgvQywoE
   2++q9DK4XRvo4jLhVeb3BTwWE0GYx0GjvxaORFDbhPPEDVTKO+WKgE4OD
   QeDpGAo7fq3aN6NMfSkEEOm5UKjN7xyCuLncbgmPxDowNs9lvLDGGzImZ
   vvh2/wSxwVSQXFZk/tv7UwFIXfRZm6WOwz9Cl8jOutjMgVOR1vsAJs4fj
   7tPgT7ngFytSH6pX5+dsLuhmERz50NNUKWxvRyF7XHC7ep2J5v96h8Imm
   w==;
X-CSE-ConnectionGUID: WVNBhnROToe0RxS1FymVZA==
X-CSE-MsgGUID: hQ4bES3yTgy/xs0RZi9Pag==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52208130"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52208130"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:38:27 -0800
X-CSE-ConnectionGUID: 0qE5Sn5cSA6/xePJGq1T/A==
X-CSE-MsgGUID: l6nsVogdRt6ehJQl5FLlBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115783822"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 16:38:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 16:38:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 16:38:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 16:38:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTpOKbuBrY2hVDZoThyXcxEZ/0ESOya48VvZ4ShsIy7F2SzaN+si//KNCWhXqYyjNvelpBhDyylV6F6nLa6wPZBJNyOeS9mkun/Y84dmh95cYb6P6OUwBLDrh937vgJ61g8gtaQcXpMRuRB61az3I7E6l0vjkoxas+EODWmtJJzZDFWHygNiYjHFsQzQikM1TxNgUU51++ZKEgX9byoDzZmm+5ROI7mkpgmffjEcmSwWJvg3L3NNnXS2x6+lheAeI5srzr+R5L8uj6hYLRdMJZLo5yQYBrb14S995LD57Y/9sLwgS3xzOY2yAFPsY6Oum4WDUfAre2lWM2OhJQ7V0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZvjNYa9dsuNNZ+n26bB9TS2xnlZ/vfKrkP32+UobvQ=;
 b=PSabkyN174sbdieJRVQqCpbHpID70xlyZHn6QrBbu3XM6nMq9PGTIMuFE0Xw9x0PmOzxEgP4svvh+C1IOq/xjHgE7e5xu+iuwBsOaU1wvQzT1aOgcyM6JawU38cJpiGiopV7ZymK3OqiBdSfNLDngSJKiF8GQohuUCiT+tLe5iFGqGPC2SaULmfQSYCUF5NzF6ouWae8v2Efj6StujlSAKpvOBQrmnQUe5/UXYCcWRszsD6M0SuOIbSg1SJ7uu+JEDmUxHYYOT2YkYue/0YyXCcdZcIkXXZw+nogyKkcH+5uE8ucN0iFnofZSwWf0NgdWZrRAhUODTqamI5YKAFsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8422.namprd11.prod.outlook.com (2603:10b6:a03:542::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 00:37:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 00:37:52 +0000
Message-ID: <48af17e9-7a64-43a5-850e-25f1596bca8c@intel.com>
Date: Wed, 19 Feb 2025 16:37:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/42] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-21-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-21-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:303:16d::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8fe8c1-f3a4-4a1b-eed5-08dd5146cf02
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU1DY3l6bjBLMTI0ZHBkQTg3Y0h4OU9vdGxZWTNpSHFzVHRrWlk4NHVFTUUz?=
 =?utf-8?B?dnplWlJqRGd1VEVDSnlYQ2g0VnhYVEUyclFnZWVNVFU0THNWZ2haOXRlTGVi?=
 =?utf-8?B?UlpIaHQzbHIwWFZYcEROcTJXbzlZcndXWFFNaUg3VTUwUUZ0SjJoNzlTdXNk?=
 =?utf-8?B?N1dqM1l1UzVheDN4VlQ4clZkempEdHAxSDRCMFNhZWlubER4dkxpZnhDaFQx?=
 =?utf-8?B?RXp1aHhqQnNjZ0k3THA1MXVRMzRVVEVwbGFxeEo2UVhjb3UwdjVYczZiK2Iw?=
 =?utf-8?B?V1R3b3VvWHlDSGFabC9LN2lNbzAxbjNNZXBmNk9pb2dOQ2hNQW5mU2N4alJB?=
 =?utf-8?B?RGQrd3Izb3c1V2tqQ2xSY0VHSGo4V2Y2ejF5K3UvSmNHTEZXMXB2TzVCUHB0?=
 =?utf-8?B?SkQ4Q0VXeWxGVm1SVnJ3NnNSa3pkYlJ3emoxbm9ORHVWWFNkUlpTTzZhOU1Z?=
 =?utf-8?B?M0FmMnA5UFRTQnA5d0FGdnIxdlJ2ZWVjMzdVVUk5cElJN1NPS3F5MFMvSGFM?=
 =?utf-8?B?NG43WW9HM2J3b1ZhM3EvNndyOERTMjV6dTBnOENYY3pZckdsREZRd0p3clFM?=
 =?utf-8?B?ckdoRU03VDN1MUpTSXZaSm9tTXNHbmdsdGhpYTJwUWRBK3o5SUp1WE9wR0J5?=
 =?utf-8?B?S0o4M05HQjRhd0dDbXllZEFpYXZDUnQyNzNNWmJ5NDFaMTM4TzVkT3ZlaE5a?=
 =?utf-8?B?SmVQR3cvNktrUDdzaklFQkZXVXI4OTFhWTE5blFZNHU1cWZmaGlHT3hMb1dN?=
 =?utf-8?B?R2dNZ1FmckhNL2t2eXFmYnIzRXBDaXNyNzNVMk1zSEJSTGJtSVVENk5iWDBl?=
 =?utf-8?B?Y3JnZkRCV3dXcnVaK2RySnZKVWU1bFpUU1NBVVpiMjVsdUhnQXo2VDdnMFVu?=
 =?utf-8?B?a2xyTHVpR2F6aXZJaG1aakE4Tk96eWpta0tJRHFyRGxqb1JldndUbWlkMjdV?=
 =?utf-8?B?dExJKzJpZGZ1NUhWUStUeGxON0NHWUoxYlZRMTFFV2lQZCt6dXh3bXZDcGtD?=
 =?utf-8?B?ZlROSFdVd0duei92dEdVU042MUlKcVN4QjA5MktTZkk5SURBUmxGVmtxMlBp?=
 =?utf-8?B?Ulc4WGZZUkdmWXp1QU8xRTFucm15RlVmNjVIcVUvTWcyZ0NrWHNjTHZyNmdK?=
 =?utf-8?B?bkNzVjJya3FWUmVNeHgraFpUZHhaMzdmR3ZxQkdjR1NIM2ZUYW91RnZUUkRq?=
 =?utf-8?B?Ung2Z1RoVnIrU3JaR2drMU5TOE9sRy94bVhYWGN2aDFqWnRmMDFOVVorb2lK?=
 =?utf-8?B?SW9aa3BtQ09SVkxLcVdtTkZlMjRSbFhXUEJjOGpkZ01tMVNUYytraG9Eb2Rv?=
 =?utf-8?B?Z2NEa2thMGdmUUNzZG1nSFRNdlJKak1QYkp4eGxPeWgxWGpjRmhINHArQWRy?=
 =?utf-8?B?cHZiaWptOEVVQWQvQXV2WWxpVTEwcFBEZlRhRVcwTmlMbDJMMTRYYUtydjN5?=
 =?utf-8?B?dElYVmJrWEJFZTZ5dzZkNUh3UnNMYnFyL3pka3NMVzVOQmROTFJtUTRsV1BZ?=
 =?utf-8?B?WHlmTG5SWmtSMWQ4dW5EWFlOYitLV2t3bWlKczJMdWZlUmpOTlBxa3dJblNv?=
 =?utf-8?B?V2xvN0pwNGxZNFdMMjJDbDBJQjZXa282a20zSXNpUHFQTk02c2tVR0U5TEdP?=
 =?utf-8?B?QmZLc2p2RWlpVEJrQXYzWUczNVB1WFhHZ0c4UDJRMTIxUmpFWDdKL2hHMUpq?=
 =?utf-8?B?YkZxOXkvcUdDSnJEUDFCamN0SGJmNjdCZjkxc2NWWGhTZXlrRmIrdGxvQU9H?=
 =?utf-8?B?RWhDWWFEQ0NmMWlGQkZsUlNZamc5Sm1iUTZMVTRybUNzUndjT0FtTnBMbCtp?=
 =?utf-8?B?VWZ2cXFPZEExS2swUm5HL0l6RlNVa0pQMWhMT3ZnVG52TXJ6d21qaXdiVVVp?=
 =?utf-8?Q?ZlrZED7XjOAfI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldFU3RIclllbHp2dDY4RHhPWDRabzdMRmJkNTUzT3VtbHdRYmVCMzFycHVQ?=
 =?utf-8?B?Znh2UlBTVGZQNFNPRmk5aktnblJwUktZN2J5cVNwMkc4cUZ0MUpGL2RncEFz?=
 =?utf-8?B?cmN6UDhUSHN0R0tZUWRXMkM1aUJOZHlVcVJCQWlMTDBCVmsvRktMVGo1SXZS?=
 =?utf-8?B?RXMxMnR5M3dEdXhHdWRlQnZXN3NqZGx2NGZ3SEdrcU1DTVJrcEVZNDVidVQx?=
 =?utf-8?B?M010Nnd2djNoKytVbWl1Zm5qakcrdWlTSURmZXZhL3J1NmpRTXN3UEcxSDdP?=
 =?utf-8?B?eDVxQ3lDV0J5ZlpHYXF2VkFCb05lY3E3cUhES2JYK0lLT2llQmZGUEhqNTNE?=
 =?utf-8?B?d0JxZlJ0eGRWaXlveUlSM1hWQlZwQ04vVy8wVlRCTmExODcvQVZNb1hseTl3?=
 =?utf-8?B?ZkxYRkplUm9VdGNPNlB1N1dzZ2lwL2R2b3R1OHk4c2V4d1NPMlFTSVUyQjIz?=
 =?utf-8?B?OWgwV0JWMEFEMk9yN1NTRmxYbWorTmZETXlOMkFVZFpRTy9sMVo4Uk5BVS9j?=
 =?utf-8?B?ZFZySTNQbjFic29CVlZUVVZIc3lHT1FORmllR3FTOGFUVmdLY0dtUjlqS21D?=
 =?utf-8?B?cXdIaXFoOVRPRlpCc3BiWGpVd1A5MGVRUS8wVTI0dFQ2RlZuZDM4WTJ5TmZZ?=
 =?utf-8?B?ME5SUDdjOUtiOWFqZjhWNG1KRVlQakpZRlNSTlpNUXg2NTh3OTQ5QTRYTHpI?=
 =?utf-8?B?MnlwNTF5VW4yaytQM1BVNitncWMyOWs2cE1jaC9ZNDlqQjRhWHRaZ3Z0UEhr?=
 =?utf-8?B?RENvWlpOajZldnF3NkVKZS9xM0MxcXhhdFJQVXE4WU0rYWVTRnVBT2RQWSsw?=
 =?utf-8?B?ajRZNndxTndTMi9qd3FvUGlTd3RvbytZM25hNFd3emk5bU9CYlpDa3Jtc3Fn?=
 =?utf-8?B?bkptdXRJRFEyQW5RN1JJSkhVR3NDUzlyTjRvL3ZHdGhEcGhFVmRGd2tMK0JH?=
 =?utf-8?B?VktyZG82OFhKNnhOMWlyWk5ESzgrazZKdUp3TVhzNUNvNG0zRmtITzlEd2ln?=
 =?utf-8?B?azRscGdTR1FUdURPZk9wUlVVaXVORTVEbnY3a2RHNldiVngvaTEzYldqeE1Q?=
 =?utf-8?B?S1RmNTVKa29uTTN3cytUZ3Bzck93ZG5Ga0ROOVZiSXQ1SDU2TkN6ZFdOUUVp?=
 =?utf-8?B?LythQVhXeUJjZFBvRmhNaWVOeExUODN6WXcrY1g3SXNsOFdJMGxMekVMOVZw?=
 =?utf-8?B?WjA0dmFGK0pqY3pJSFo5YVJZQnd4eVFlYnZFTzZkWXlNRzVqZkZTSWNRc1pz?=
 =?utf-8?B?Vkd1dHpiR2VpckZLdFZGTVBlQ25zbzFtU3huVFY2RXp3U3UxUVZ3RCtvWXNZ?=
 =?utf-8?B?U0x3dWYycmRXVTNHVm9xNUF2SCthRlNQa2ovamx5U2FwR3Y5bHpBWUo4NzV3?=
 =?utf-8?B?UVQxWDB0QUpDTlhWeFdQVE8vUjNORzNVMVVCMHNmSmVxdHZFZXByWFVZK2xR?=
 =?utf-8?B?aTNnTHRycU00RjVyOE5lVEJGQ3NiZFd0bzFIVFZMdWgrYm84aEtwa2xKc1Rk?=
 =?utf-8?B?RGJjYW9kUFdZamNrKzFrSmdnTGFXbnRMYlQxZ1lrN1VtNnpadEppblJRMzZw?=
 =?utf-8?B?VlJoU1YrN1RyT1B5Wkp3L1U2Vm9zWERCNm9pSTZaVndyL09ZMnFjcFAvWE9G?=
 =?utf-8?B?QzdmZzhZbzh3NHpjd0lFNll1aWI2YklHN3NnQW1rOUlUL05wNjZIRk5JQ0xL?=
 =?utf-8?B?N3ptSHQ4MC9PeWc3RXVwY0psN1V0TTJEaWlPOXVLR3ZTbzRCa2JMSTlWbis3?=
 =?utf-8?B?VjhEbURnUXprRUZ6S2MzYUl3M2tLSnFqZHNkMElOZ0tteDhES0owYUVsOVdE?=
 =?utf-8?B?Qzh2aWgzTUFUL1I2YXZsd05pVndXWHFrVG51Y0ZVdVhiaTlsUTI4YkVLamdx?=
 =?utf-8?B?Y21JQnp1Y2RLK0hjejJhTHdCM3RCbGdrNXRYMmRDa09jZzdMQ05mdWs0US9l?=
 =?utf-8?B?VFdTM3RiRlROSGZaZ3RNRk5KaFJaRjdWTURPMzBEbHl0cWFzeXBHYnBHbGVj?=
 =?utf-8?B?ZWZMZG9vcjBadElWODU3cjZwM29UYXYyR2lrZVgyVjdXcmNxSVpMa2I4UXA5?=
 =?utf-8?B?dlcvcXJPZ2V4UGx3L1hKSk9rVXpCME9SZ2pGYW9XNFRWYTE1SzdrZnROT3Nl?=
 =?utf-8?B?TUNMelVGaTFMVFhqVzA0M1dkNmtFSDJNbzdrc1p1R1lSdWRycVVYdXRvWkFC?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8fe8c1-f3a4-4a1b-eed5-08dd5146cf02
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:37:52.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTTlIwR4Bf+AKOwNBa+bIXrrzLWgNgzG27UH0aEzVlgC/QF4Bzx6ymwK/vdZAtirlXMixoYYkcfBJbLGaHkWm03h13nvpsrLwuln2lZkUt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8422
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> mon_event_config_{read,write}() are called via IPI and access model
> specific registers to do their work.
> 
> To support another architecture, this needs abstracting.
> 
> Rename mon_event_config_{read,write}() to have a "resctrl_arch_"
> prefix, and move their struct mon_config_info parameter into
> <linux/resctrl.h>.  This allows another architecture to supply an
> implementation of these.
> 
> As struct mon_config_info is now exposed globally, give it a 'resctrl_'
> prefix. MPAM systems need access to the domain to do this work, add
> the resource and domain to struct resctrl_mon_config_info.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

