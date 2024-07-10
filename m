Return-Path: <linux-kernel+bounces-247022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9232292CA05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A262A1C223B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0061C42ABE;
	Wed, 10 Jul 2024 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AS72PQ5p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97029AB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720587126; cv=fail; b=uMlyUHVXH5LGIVtMjWZQRoHQ4PN97zfqthJo3w6SyII9UNGjgH4Hg/Uk1evWKYBfC+IwH0R6WufSBHOIwpztDK13IYMG54rD8PZgId3ENmRXR5At27C/xZ59l3Rn61f5cAeW6tBrnEpo72mFDqlwn25z1BkV72cGEkZKDQ/dM0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720587126; c=relaxed/simple;
	bh=nbSAOlhOhVdZzw1BT9fr9inFqVeIFEC/wqgDv2WLbQo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eByhJFsu1S9tPZFqzr2kjRoIjUbpwedlx1THzhz1SiEP8nYOQ06shUixA1kPJgF5BJT3t+DwbMOYPYNb1Wk2Olu3tfNrPPzs2PmeHr5ZYzT39l5p7yr5urotFImVffp6D6d9OR4YuphGgr9G1ZCtPGUeUFVQQ4/XQrb2B3iSWwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AS72PQ5p; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720587121; x=1752123121;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=nbSAOlhOhVdZzw1BT9fr9inFqVeIFEC/wqgDv2WLbQo=;
  b=AS72PQ5pT7QH1rGuq/vNBTU7Pqk0z2rR4mKRj4olWx4xqHlH0sdQWjVD
   HNu+OAmIrZj/f2DvxmI3fYEJ+VGlG1UCTvPmnavFIr4UdZrBFkcR9kqN6
   bfJ7GWpYu6pLAcDWJ9XU1xWFGjUAzt7LdNHu2zhINppS+FTqGOAaBLNOk
   Cgcny27OaEK8Ze0E9qtGNeiMNtARhQhlwdX7/Evzl3c5/4PyBIkLYNH0A
   OlWQyqxPipamCCqYqhGC4qxK0xg0FIofBBRbUDaYcMlPPzuD+Q2z7xfs6
   RMe1gPaJ9Ks0I0EZUKxgJ5F49JaIukbm6SBoAWs2QKhzRlIyhSXOXDJa9
   w==;
X-CSE-ConnectionGUID: L31N8yPfR7qNxtcRfE2c9Q==
X-CSE-MsgGUID: W2FSUKSrRY+F9v+IaX7Nkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17749351"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17749351"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 21:52:01 -0700
X-CSE-ConnectionGUID: IuzyncL8RQ2akkWt/5wQIA==
X-CSE-MsgGUID: kZGp7/JWRXuTTtPAxhphug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="52479706"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 21:52:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:52:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 21:51:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 21:51:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 21:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlJLZuoZxIr+G8VgLJ5wP3ao1jb3Q0PqUl8Ylbj9InNJme/Fk136401DUh51sZwOkHFbQlnVICzjMJ2NTf9rHu7BRVRjFZRuY9ThUbrJ5w+t/NfoN/e68mFtavdnt8eFZC2IuvEDfwa6VO8xiJciwpZwa3aCL8g2SgQULHLYizcy33DACJyF9pDoTc1w0Tj6/92xyjKsbT0/oGLM3NSztP0vlxB2g+ZaOhHgXoKKvDDTulHdxgjt5QM29iJ3quLIcWyk14heGFJyAI/vuOMwzdVwJ77ox9pZjpH2InsYLv90cORmiqOF52nWULRBll5yG6wp42qyhpO9otbTfy+P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvY32jNzVplQ8LzyZ00iwqhql+srMXvDZos0TGLcDFU=;
 b=CuVreld27EPXAkozYo56Gnrx2vZqc2sZmTtNTk+CsUecyvW/NTwvz2Agm2KW9txR8mL+zN0Rg5vlf+BkxLN+HakNRsS2slsfQWjQyvTDi7UEwA9D8knOQyXE0U6Ec4d/nOf4hFgq7cHWqprdugPz8n4HM0UPaUcpHFWU0gMPEh0oxRRvKYy3hKjLmIsoAlANsj58MoBwy9fo+NYlpPKbuka9B/rAFIj53MAoF4wAAN5Pe6zanCzt+FPuKtRG1GkQI4QBV0rfQF5ahZeotIa9iNDpC6+NcWjDhRGyEj2tBWP8LNfAI39y+xhFXFQ5YBORYHW3bauOo/5sWWHvghbK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY5PR11MB6283.namprd11.prod.outlook.com (2603:10b6:930:21::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 04:51:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:51:56 +0000
Date: Wed, 10 Jul 2024 12:51:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/fair]  d329605287:
 stress-ng.resched.ops_per_sec -24.0% regression
Message-ID: <202407101139.6e513af5-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY5PR11MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 559d4e5a-2b13-498c-b093-08dca09c05ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?C9h7rb+V7yL8lAIrrllwzK6HEKAhKalPi0z5YvkeQwUl+z/8AXjOddpkVK?=
 =?iso-8859-1?Q?ZcSCbJbxh9dzR1fauD6FmyFWo44fcQuqJQMzwCOROuIuHIt1cgnS8bFOyd?=
 =?iso-8859-1?Q?9Bm88l5j46gYuxM++sgc7wG18lzUA9V5foeVvJSCgL9/3GoZiYsJXfwjiV?=
 =?iso-8859-1?Q?0BaoCFrLEY7uMuhSP4h+5UgaPMAj/XgebfwDAHT+n+osj3Xn6PbCByi+EV?=
 =?iso-8859-1?Q?IdfVGKptHa2empQtQcKwZOAIXQXRI0s3tcBxOkjdF0nNZW9WqwjesK2KRg?=
 =?iso-8859-1?Q?3qxmI4NIVApsc6fd1cU1Zoc1esMhVLHnDMOJ6snf2Bi/3L8ULcLLaxeezu?=
 =?iso-8859-1?Q?dVjqkkvKpNep77Vi+zxQjHDbDtQV813616D2xXp141odq/gJz+mX/HXWA0?=
 =?iso-8859-1?Q?NwpeiNRKVln32myQYYLowlKzeQOBHaProOiUcZGl6ffW+WLDV9p9mC8NQN?=
 =?iso-8859-1?Q?IKc/19+aP8ITIcs7qm/ImLXKg30dou34wVEwnsOw0oI8HlXBzH130P6wR2?=
 =?iso-8859-1?Q?DL/suQYmSJesee3o344KTOoEkA939BCUkDC/b1hBgKp+rUdxjK+mtlpw6v?=
 =?iso-8859-1?Q?6v0QSOenG+sNsyNhQIF+ZxGyCNVjPaWhQBL/MDzKs0YWpEG+8HhEKOU2wh?=
 =?iso-8859-1?Q?lz0WTkRlS0UxdOJ/dqGOKAe8kOG4aaYTIX7g1zZ1c9aqKmR2XR5Qzh+rnz?=
 =?iso-8859-1?Q?Ke4EAbnD2eSe90z0tg4CyS+VZxE0xkrUqJ40bCrQkHvbEc9qgOIOcy/YO+?=
 =?iso-8859-1?Q?dHCUS5oTC/xqQm5leskTMVyihfRNQp2AY662YgIBu5yyWfWrIZlQaMHOQM?=
 =?iso-8859-1?Q?0KedT/kaAqIyLpAImmd7SMCqzXWu2WAJmw1YGysJ8XDx3nTeSZ/H+F9Vi1?=
 =?iso-8859-1?Q?l5koDn0l/qVEG5GuCa4R1O+1pZjNyXn/cisV4EDpW6E9B82mLNVoeRQD3R?=
 =?iso-8859-1?Q?L0MqTJl0gDqgLAhCAlLyM6dPbLms/lyEnmlhDwhy0FA9ejo3U3Z6NjnerI?=
 =?iso-8859-1?Q?G1w8Al/dUPwIe0TabK5Sjo9OukOybQDBt8r01SOABicuLMfEtlsyc/QSNE?=
 =?iso-8859-1?Q?OLDPh50SD7xA/xUoB21aSCLW0qQBrNtIrTg5udEjjsrqzr5sV/Ayssm7RY?=
 =?iso-8859-1?Q?Mwf+gkRAgMwFtmjoilFrpFWSUVvPYkhjAR2pOdSk35cvrBjTyuhYI9JixF?=
 =?iso-8859-1?Q?IQL8UyT0V0RaDYpfALuIjdhwSB/e2DgrTht7WHklfXGIokJPVRQulAcJ5c?=
 =?iso-8859-1?Q?fMsy5AajcIU4ARPz8vFdpRUgNSsy7hYZS1N5moaMjopdTQjHU+AvYfcRVI?=
 =?iso-8859-1?Q?67rwZwXiyWMPL21Jqw0nTRVF0M1r5Mq5iqi4hbrPEChcULw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DIabu+S/H4cuxWtjScBlqz1kb+VB9uhmDUK9lTb8fs1yAVxqL3lJsf9azw?=
 =?iso-8859-1?Q?swWtSgkvzZ+nit1WHotq8+pJWNu+Za87muhoSHU968P22o1slkygUsfsC6?=
 =?iso-8859-1?Q?csd8QWN5afgqvhzGwibf4Qr+s7I6ztPgmNwr2B6uXs5vwl37kEtzf4XuXi?=
 =?iso-8859-1?Q?Iu4jobga/YnKzrcXZwL6646+px/TUyN7GmO0jfadKMDD34yiq8nQfCEwzI?=
 =?iso-8859-1?Q?cIj1Z9ZXa148t9V1vF7uNYoxEsvmN3T4ynWrx26gwpIJgEWlhyAP/TN/Gn?=
 =?iso-8859-1?Q?h5eP6bd42mVKw9NBkPS4A0jwjikVgo2qeIfelfhOVT+K93pOVqOGCeuVYJ?=
 =?iso-8859-1?Q?PUQl4QNE/B4hc63kSAvTmhrvvtLb9qfgJL/T9hPtLunseDhHUxANFUQoNr?=
 =?iso-8859-1?Q?wdMLxhUz+p/TCLHVTGWbcdp/Jb9TsamfSlE95oTGKzOMoJTpRvX8FIWfz1?=
 =?iso-8859-1?Q?Hw6yoXy1ncwdAv9WfiN/SBIxNIKJIZjgvO36UhW/eX5B7sYqeLGWyuAKl/?=
 =?iso-8859-1?Q?Unr6NoXTUtFoZbBsWnv+mkQTR9SSn/R+SjDyey9+1YDzEHykEzlTpUw7jn?=
 =?iso-8859-1?Q?GiXjetZhshN9g/X9z8R5dnS7WWLQXfBH1HyCCK9+McZi5sVOFudtuB5QmT?=
 =?iso-8859-1?Q?8VdTO81mWrxoLCe4CTI8RMD9E1B/ZR+LW74u1v5cIhm7mUHoyqtPc2pRjy?=
 =?iso-8859-1?Q?dwN5kDc50kkRpxe3K8EPcffP+YdqjQRhOK/YFbQR7SsPco6fJrTyk/H1a5?=
 =?iso-8859-1?Q?4iUx9QMuaF31D0MnxhLNCV9EDcnfqD0hpKdClYcg/ctiij8eKi4jwZbtba?=
 =?iso-8859-1?Q?GyFcXMqcfrdb2wMcf1D2Qf8/WzxQyn7nfDpp6oBIeC5oQxQS5kQIqURuDa?=
 =?iso-8859-1?Q?EQxCjSrWRT6Fl6501NSzxo/Y5Efs1tGeVaznH08+cFynKpnDlNOZHezHhi?=
 =?iso-8859-1?Q?u62zUgoGTnQUOXwfUFhMkMKyF7HfjE1CagM8NWY98DnF+k3IRY2jxg1jFg?=
 =?iso-8859-1?Q?hwGe7Y06/+YR50ubYTyIq/+tPqLVqEmaVKO0pJw4WvOYD4AGA8gFye4s+J?=
 =?iso-8859-1?Q?jG1hB0kml7khbgcX7xteD3RECiHMcA68VvFX/O/WxVFlREUkfqJKM3Oyjw?=
 =?iso-8859-1?Q?p9bG+4sIvvglJjteR2xt9H2o5xvngysImEyXBD1C5zSfP2TdZBLvOIjO/r?=
 =?iso-8859-1?Q?8NRy96zA8p55EwCShVtv8fG7R8jYGD7AVxaSSSum3XmgouVViXG8FOGPZ8?=
 =?iso-8859-1?Q?iHmIaVlxAFqHIS4HsswW6u93pTrcONc3kHEqxiOzVbQlwm5gegdJHWIARI?=
 =?iso-8859-1?Q?kENNGjknu7mhldTuRJDeXVbbhy024CnUrsLuoBmHyCiqZBDpE4D6RvNZ9p?=
 =?iso-8859-1?Q?oip+X9gbuGSLb3Rnzswz78sxgDluva0e6Sgwyw4HXGYFfxeUdW9yUMqbge?=
 =?iso-8859-1?Q?ZaeoND0QLR59xIDu1K3lq4KjPuPn3WDIIQkdIe/dLiPE/5LZjBcnlwGNjs?=
 =?iso-8859-1?Q?CM7Xr+RepdRq9UAPnpM4aVRvg5bsLDZNQWZ1TOgHFvB1jP0rzUj11+qNe5?=
 =?iso-8859-1?Q?IzFPNmC1BOFNAuyNDrIRbjDofJzGUynDVxhM4s33S/lUxKPpjIQhAECW80?=
 =?iso-8859-1?Q?0lsHJZQZ2gAxMAfOTjzXP8ppknP4wc/jVlMMjp0ydePNvJs7ir5vL28w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 559d4e5a-2b13-498c-b093-08dca09c05ea
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:51:55.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR4QpEErM4A7hkZlp3bEj3eFDTaOBXMWkOTp3bYh/xor9rUPjy9mVV+84i+2wQLYhr/trIE+Vhba6cJsK9OO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6283
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -24.0% regression of stress-ng.resched.ops_per_sec on:


commit: d329605287020c3d1c3b0dadc63d8208e7251382 ("sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: resched
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407101139.6e513af5-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240710/202407101139.6e513af5-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/resched/stress-ng/60s

commit: 
  0ec208ce98 ("sched/psi: Optimise psi_group_change a bit")
  d329605287 ("sched/fair: set_load_weight() must also call reweight_task() for SCHED_IDLE tasks")

0ec208ce98349297 d329605287020c3d1c3b0dadc63 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   8336590           -52.6%    3951818 ±  2%  vmstat.system.cs
    178295            +3.0%     183593        vmstat.system.in
      0.52 ±  5%      +0.1        0.59 ±  3%  mpstat.cpu.all.irq%
      5.99            -2.5        3.50 ±  2%  mpstat.cpu.all.nice%
      0.33            +0.1        0.40        mpstat.cpu.all.soft%
  16848066 ±  8%     +28.0%   21567991 ±  2%  numa-numastat.node0.local_node
  16876736 ±  8%     +27.9%   21592452 ±  2%  numa-numastat.node0.numa_hit
  18630612 ±  4%     +23.3%   22975647 ±  3%  numa-numastat.node1.local_node
  18671925 ±  4%     +23.3%   23019799 ±  3%  numa-numastat.node1.numa_hit
     62615 ±  3%     -24.0%      47612 ± 16%  numa-meminfo.node1.Active
     62599 ±  3%     -24.0%      47591 ± 16%  numa-meminfo.node1.Active(anon)
   3987568 ±  7%     -21.1%    3145371 ±  4%  numa-meminfo.node1.Inactive
   3987470 ±  7%     -21.1%    3145235 ±  4%  numa-meminfo.node1.Inactive(anon)
    657043 ±  6%     -25.1%     491831 ±  9%  numa-meminfo.node1.Mapped
   3579732 ±  6%     -20.4%    2849082 ±  3%  numa-meminfo.node1.Shmem
     80007 ±  6%     -19.9%      64050 ±  8%  meminfo.Active
     79975 ±  6%     -20.0%      64018 ±  8%  meminfo.Active(anon)
   6744130 ±  3%     -10.9%    6008490        meminfo.Cached
   4289247 ±  5%     -17.0%    3558200 ±  2%  meminfo.Inactive
   4289034 ±  5%     -17.0%    3557986 ±  2%  meminfo.Inactive(anon)
    841761 ±  7%     -20.4%     669712 ±  3%  meminfo.Mapped
   3660730 ±  6%     -20.1%    2925086 ±  2%  meminfo.Shmem
 7.298e+08           -24.0%  5.547e+08        stress-ng.resched.ops
  12138227           -24.0%    9226692        stress-ng.resched.ops_per_sec
 5.232e+08           -52.6%   2.48e+08        stress-ng.time.involuntary_context_switches
  40641697           +32.7%   53950252 ±  2%  stress-ng.time.minor_page_faults
      3208            +3.7%       3327        stress-ng.time.system_time
    460.75           -24.9%     346.22        stress-ng.time.user_time
   1734221           +43.1%    2480859        stress-ng.time.voluntary_context_switches
  16850778 ±  8%     +28.0%   21573049 ±  2%  numa-vmstat.node0.numa_hit
  16822108 ±  8%     +28.1%   21548588 ±  2%  numa-vmstat.node0.numa_local
     15641 ±  3%     -24.4%      11829 ± 15%  numa-vmstat.node1.nr_active_anon
    995369 ±  7%     -21.1%     785041 ±  4%  numa-vmstat.node1.nr_inactive_anon
    163326 ±  6%     -25.0%     122520 ±  9%  numa-vmstat.node1.nr_mapped
    893612 ±  6%     -20.4%     710994 ±  3%  numa-vmstat.node1.nr_shmem
     15641 ±  3%     -24.4%      11829 ± 15%  numa-vmstat.node1.nr_zone_active_anon
    995369 ±  7%     -21.1%     785041 ±  4%  numa-vmstat.node1.nr_zone_inactive_anon
  18643395 ±  4%     +23.4%   22998770 ±  3%  numa-vmstat.node1.numa_hit
  18602082 ±  4%     +23.4%   22954618 ±  3%  numa-vmstat.node1.numa_local
     20312 ±  6%     -21.2%      15996 ±  7%  proc-vmstat.nr_active_anon
   1689468 ±  3%     -11.1%    1501770        proc-vmstat.nr_file_pages
   1075835 ±  5%     -17.3%     889317 ±  2%  proc-vmstat.nr_inactive_anon
     36682            -1.5%      36122        proc-vmstat.nr_kernel_stack
    213413 ±  7%     -21.5%     167443 ±  2%  proc-vmstat.nr_mapped
    918616 ±  6%     -20.4%     730918 ±  2%  proc-vmstat.nr_shmem
     25826            -1.6%      25404        proc-vmstat.nr_slab_reclaimable
     20312 ±  6%     -21.2%      15996 ±  7%  proc-vmstat.nr_zone_active_anon
   1075835 ±  5%     -17.3%     889317 ±  2%  proc-vmstat.nr_zone_inactive_anon
  35550427 ±  3%     +25.4%   44585721 ±  3%  proc-vmstat.numa_hit
  35480445 ±  3%     +25.5%   44517108 ±  3%  proc-vmstat.numa_local
     20419           -16.9%      16969 ± 39%  proc-vmstat.pgactivate
  36894329 ±  3%     +25.8%   46413037 ±  3%  proc-vmstat.pgalloc_normal
  41331111           +32.0%   54574611 ±  2%  proc-vmstat.pgfault
  35265617 ±  3%     +27.7%   45030638 ±  3%  proc-vmstat.pgfree
      0.93           +29.0%       1.20        perf-stat.i.MPKI
 2.547e+10           -13.0%  2.214e+10        perf-stat.i.branch-instructions
 1.909e+08 ±  2%     -15.0%  1.622e+08        perf-stat.i.branch-misses
     25.52            -1.4       24.11        perf-stat.i.cache-miss-rate%
 1.074e+08           +15.4%  1.239e+08        perf-stat.i.cache-misses
 4.293e+08           +22.7%  5.266e+08        perf-stat.i.cache-references
   8481137           -51.9%    4077796        perf-stat.i.context-switches
      1.64           +12.2%       1.84        perf-stat.i.cpi
      9401          +114.7%      20184        perf-stat.i.cpu-migrations
      1826           -14.2%       1568        perf-stat.i.cycles-between-cache-misses
 1.192e+11           -11.3%  1.057e+11        perf-stat.i.instructions
      0.62           -10.9%       0.55        perf-stat.i.ipc
      0.89 ± 17%     +43.7%       1.27 ± 10%  perf-stat.i.major-faults
    153.13           -40.4%      91.31        perf-stat.i.metric.K/sec
    675258 ±  2%     +31.8%     889940 ±  2%  perf-stat.i.minor-faults
    675259 ±  2%     +31.8%     889941 ±  2%  perf-stat.i.page-faults
      0.90 ±  2%     +30.2%       1.17        perf-stat.overall.MPKI
     24.68            -1.4       23.26        perf-stat.overall.cache-miss-rate%
      1.64           +12.5%       1.85        perf-stat.overall.cpi
      1834 ±  2%     -13.6%       1585        perf-stat.overall.cycles-between-cache-misses
      0.61           -11.1%       0.54        perf-stat.overall.ipc
 4.063e+08 ±  6%     +19.5%  4.855e+08 ±  7%  perf-stat.ps.cache-references
   8096825 ±  6%     -53.5%    3763797 ±  8%  perf-stat.ps.context-switches
      8836 ±  6%    +109.9%      18544 ±  7%  perf-stat.ps.cpu-migrations
      0.83 ± 21%     +37.0%       1.14 ±  6%  perf-stat.ps.major-faults
    639377 ±  5%     +28.4%     821215 ±  7%  perf-stat.ps.minor-faults
    639378 ±  5%     +28.4%     821216 ±  7%  perf-stat.ps.page-faults
  14062376           -81.9%    2541530        sched_debug.cfs_rq:/.avg_vruntime.avg
  16401321 ±  2%     -83.0%    2782766 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
   9994597 ±  3%     -81.9%    1808326 ±  5%  sched_debug.cfs_rq:/.avg_vruntime.min
    771192 ±  7%     -82.7%     133680 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     62.92 ± 27%     -29.0%      44.67 ±  5%  sched_debug.cfs_rq:/.h_nr_running.max
     13.64 ±  8%     -24.3%      10.33 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
     59.25 ± 29%     -30.0%      41.50 ±  4%  sched_debug.cfs_rq:/.idle_h_nr_running.max
     12.88 ±  9%     -23.7%       9.83 ±  6%  sched_debug.cfs_rq:/.idle_h_nr_running.stddev
    228669 ± 69%     -78.9%      48255 ± 39%  sched_debug.cfs_rq:/.left_deadline.avg
  10760636 ± 14%     -79.5%    2208314 ± 16%  sched_debug.cfs_rq:/.left_deadline.max
   1485958 ± 36%     -79.4%     306412 ± 25%  sched_debug.cfs_rq:/.left_deadline.stddev
    228668 ± 69%     -78.9%      48255 ± 39%  sched_debug.cfs_rq:/.left_vruntime.avg
  10760550 ± 14%     -79.5%    2208306 ± 16%  sched_debug.cfs_rq:/.left_vruntime.max
   1485951 ± 36%     -79.4%     306409 ± 25%  sched_debug.cfs_rq:/.left_vruntime.stddev
      0.67 ± 35%    +287.5%       2.58 ± 37%  sched_debug.cfs_rq:/.load_avg.min
  14062379           -81.9%    2541530        sched_debug.cfs_rq:/.min_vruntime.avg
  16401320 ±  2%     -83.0%    2782766 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
   9994859 ±  3%     -81.9%    1808327 ±  5%  sched_debug.cfs_rq:/.min_vruntime.min
    771174 ±  7%     -82.7%     133680 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
    228671 ± 69%     -78.9%      48255 ± 39%  sched_debug.cfs_rq:/.right_vruntime.avg
  10760559 ± 14%     -79.5%    2208307 ± 16%  sched_debug.cfs_rq:/.right_vruntime.max
   1485968 ± 36%     -79.4%     306410 ± 25%  sched_debug.cfs_rq:/.right_vruntime.stddev
     54904 ± 22%     -28.5%      39277 ± 12%  sched_debug.cfs_rq:/.runnable_avg.max
     12434 ±  7%     -20.6%       9870 ±  9%  sched_debug.cfs_rq:/.runnable_avg.stddev
    107.59 ± 15%     +78.3%     191.80 ± 10%  sched_debug.cfs_rq:/.util_est.avg
    209.16 ± 12%     +22.1%     255.37 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
    850096           -22.1%     662380        sched_debug.cpu.avg_idle.avg
      7.40 ± 13%     +44.2%      10.67 ± 14%  sched_debug.cpu.clock.stddev
    476028           +30.7%     622160        sched_debug.cpu.curr->pid.max
    206133 ±  7%     +41.3%     291290 ±  4%  sched_debug.cpu.curr->pid.stddev
     63.00 ± 27%     -29.2%      44.58 ±  5%  sched_debug.cpu.nr_running.max
     13.63 ±  8%     -24.3%      10.31 ±  6%  sched_debug.cpu.nr_running.stddev
   4021509           -52.3%    1919719        sched_debug.cpu.nr_switches.avg
   4839722 ±  2%     -54.4%    2206359 ±  2%  sched_debug.cpu.nr_switches.max
   2378111 ±  9%     -47.1%    1258173 ±  7%  sched_debug.cpu.nr_switches.min
    437605 ± 12%     -65.0%     153196 ±  4%  sched_debug.cpu.nr_switches.stddev
     17.27 ±  5%     -24.1%      13.11 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
     22.56 ±  2%     -10.2       12.31 ±  5%  perf-profile.calltrace.cycles-pp.__sched_yield
     17.87 ±  2%      -8.1        9.79 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
     17.74 ±  2%      -8.0        9.70 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     23.76            -7.0       16.72 ±  5%  perf-profile.calltrace.cycles-pp.__sched_setscheduler
     21.68            -6.3       15.36 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     21.58            -6.3       15.28 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     20.98            -6.1       14.89 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     20.94            -6.1       14.85 ±  5%  perf-profile.calltrace.cycles-pp.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_setscheduler
     13.06 ±  2%      -5.6        7.48 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     10.65 ±  2%      -4.8        5.85 ±  5%  perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     10.73 ±  2%      -3.7        7.03 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.81            -3.4       15.41 ±  5%  perf-profile.calltrace.cycles-pp._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.19            -3.2       14.96 ±  5%  perf-profile.calltrace.cycles-pp.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64
      4.18 ±  2%      -2.2        1.94 ±  6%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      3.73            -2.0        1.78 ±  5%  perf-profile.calltrace.cycles-pp.stress_resched_child
      3.89 ±  2%      -1.2        2.66 ±  4%  perf-profile.calltrace.cycles-pp.__sched_getscheduler
      4.40 ±  2%      -1.2        3.17 ±  5%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      2.19            -1.2        0.98 ±  5%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      3.03 ±  2%      -1.2        1.88 ± 10%  perf-profile.calltrace.cycles-pp.capable.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      3.00 ±  2%      -1.1        1.86 ± 10%  perf-profile.calltrace.cycles-pp.security_capable.capable.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      2.92 ±  2%      -1.1        1.80 ± 10%  perf-profile.calltrace.cycles-pp.apparmor_capable.security_capable.capable.__sched_setscheduler._sched_setscheduler
      3.05 ±  2%      -1.0        2.02 ±  5%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.78 ±  2%      -1.0        0.82 ±  6%  perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.27            -0.8        1.49 ±  5%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.38 ±  2%      -0.7        0.66 ±  7%  perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      2.19            -0.7        1.54 ±  5%  perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.19 ±  3%      -0.6        0.55 ±  6%  perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      4.83 ±  2%      -0.6        4.24 ±  4%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      1.15 ±  2%      -0.6        0.58 ±  6%  perf-profile.calltrace.cycles-pp.set_next_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      1.09 ±  2%      -0.5        0.54 ±  5%  perf-profile.calltrace.cycles-pp.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.74 ±  2%      -0.5        1.19 ±  5%  perf-profile.calltrace.cycles-pp.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.56 ±  2%      -0.5        1.05 ±  5%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_task_fair.__sched_setscheduler._sched_setscheduler
      0.76 ±  2%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.update_load_avg.set_next_entity.set_next_task_fair.__sched_setscheduler._sched_setscheduler
      1.79 ±  2%      -0.5        1.30 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      1.69 ±  2%      -0.5        1.20 ±  4%  perf-profile.calltrace.cycles-pp.set_next_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      1.66 ±  2%      -0.5        1.21 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      1.19 ±  2%      -0.5        0.73 ±  4%  perf-profile.calltrace.cycles-pp.put_prev_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler.__x64_sys_sched_setscheduler
      1.56 ±  2%      -0.5        1.11 ±  3%  perf-profile.calltrace.cycles-pp.find_task_by_vpid.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.50 ±  2%      -0.4        1.06 ±  4%  perf-profile.calltrace.cycles-pp.set_next_entity.set_next_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      1.09 ±  2%      -0.4        0.66 ±  4%  perf-profile.calltrace.cycles-pp.put_prev_entity.put_prev_task_fair.__sched_setscheduler._sched_setscheduler.do_sched_setscheduler
      0.99 ±  2%      -0.4        0.64 ±  5%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.__sched_setscheduler
      0.75 ±  4%      -0.3        0.43 ± 44%  perf-profile.calltrace.cycles-pp.__radix_tree_lookup.find_task_by_vpid.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64
      0.93 ±  3%      -0.3        0.61 ±  5%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.__sched_yield
      0.95 ±  2%      -0.3        0.64 ±  4%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.__sched_getscheduler
      1.24 ±  2%      -0.3        0.93 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_getscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      1.00 ±  2%      -0.3        0.69 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      1.12 ±  2%      -0.3        0.84 ±  4%  perf-profile.calltrace.cycles-pp.find_task_by_vpid.__x64_sys_sched_getscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_getscheduler
      0.72 ±  2%      -0.2        0.55 ±  4%  perf-profile.calltrace.cycles-pp.pick_eevdf.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      0.54 ±  2%      +0.1        0.68 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm.copy_process
      0.67 ±  2%      +0.2        0.87 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.57 ±  2%      +0.2        0.76 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.__vm_area_free.exit_mmap.__mmput.exit_mm
      0.62            +0.2        0.82 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_free.exit_mmap.__mmput.exit_mm.do_exit
      1.05            +0.2        1.25 ±  3%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert_after.dup_mmap.dup_mm.copy_process.kernel_clone
      0.82 ±  2%      +0.2        1.04 ±  3%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      0.65 ±  2%      +0.2        0.88 ±  3%  perf-profile.calltrace.cycles-pp.__vm_area_free.exit_mmap.__mmput.exit_mm.do_exit
      0.57 ±  2%      +0.3        0.83 ±  6%  perf-profile.calltrace.cycles-pp.up_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.74            +0.3        1.01 ±  3%  perf-profile.calltrace.cycles-pp.unlink_file_vma.free_pgtables.exit_mmap.__mmput.exit_mm
      0.82 ±  2%      +0.3        1.10 ±  3%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.94            +0.3        1.28 ±  4%  perf-profile.calltrace.cycles-pp.down_write.dup_mmap.dup_mm.copy_process.kernel_clone
      0.96            +0.4        1.33 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap
      0.96            +0.4        1.33 ±  2%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.35 ± 70%      +0.4        0.76 ±  3%  perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap
      1.53            +0.4        1.95 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm.copy_process
      0.42 ± 44%      +0.4        0.85 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      0.78            +0.4        1.21 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1.16 ±  2%      +0.5        1.62 ±  2%  perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput
      1.18 ±  2%      +0.5        1.65 ±  2%  perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.__mmput.exit_mm
      1.19 ±  2%      +0.5        1.67 ±  2%  perf-profile.calltrace.cycles-pp.tlb_finish_mmu.exit_mmap.__mmput.exit_mm.do_exit
      1.35            +0.5        1.83 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      0.90            +0.5        1.40 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      1.47 ±  2%      +0.5        1.98 ±  3%  perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      1.38            +0.5        1.88 ±  2%  perf-profile.calltrace.cycles-pp._compound_head.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range
      0.08 ±223%      +0.5        0.61 ±  6%  perf-profile.calltrace.cycles-pp.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54 ±  7%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc.copy_pte_range
      0.00            +0.6        0.56 ±  6%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range
      0.00            +0.6        0.56 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.57 ±  3%  perf-profile.calltrace.cycles-pp.remove_vma.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +0.6        0.58 ±  3%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.kernel_wait4.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.6        0.59 ±  4%  perf-profile.calltrace.cycles-pp.up_write.free_pgtables.exit_mmap.__mmput.exit_mm
      0.00            +0.6        0.60 ±  6%  perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.copy_pte_range.copy_p4d_range.copy_page_range
      2.06            +0.6        2.66 ±  4%  perf-profile.calltrace.cycles-pp.vm_area_dup.dup_mmap.dup_mm.copy_process.kernel_clone
      0.83 ±  3%      +0.6        1.45 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork
      0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp.wait4
      0.00            +0.7        0.67 ±  5%  perf-profile.calltrace.cycles-pp.down_write.unlink_file_vma.free_pgtables.exit_mmap.__mmput
      2.01 ±  3%      +0.7        2.69 ±  3%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      2.09 ±  3%      +0.7        2.78 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      2.09 ±  3%      +0.7        2.79 ±  3%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.7        0.74 ±  3%  perf-profile.calltrace.cycles-pp.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      2.00            +0.7        2.75 ±  2%  perf-profile.calltrace.cycles-pp.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      2.22 ±  3%      +0.8        2.98 ±  3%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.29 ±  3%      +0.8        3.07 ±  3%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.00            +0.8        0.80 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone
      1.02 ±  3%      +0.8        1.82 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables
      1.06 ±  3%      +0.8        1.88 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      1.30 ±  2%      +0.8        2.14 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork
      0.00            +0.8        0.85 ±  5%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.unlink_anon_vmas
      1.33 ±  2%      +0.9        2.19 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      2.64            +0.9        3.53 ±  3%  perf-profile.calltrace.cycles-pp._compound_head.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      1.30 ±  3%      +0.9        2.21 ±  4%  perf-profile.calltrace.cycles-pp.down_write.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput
      2.52 ±  3%      +0.9        3.43 ±  3%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.52 ±  3%      +0.9        3.44 ±  2%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      1.53 ±  2%      +0.9        2.47 ±  5%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      2.63 ±  3%      +0.9        3.57 ±  3%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.38 ±103%      +1.0        1.36 ±  5%  perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.76 ±  2%      +1.0        3.78 ±  3%  perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      3.08 ±  3%      +1.1        4.20 ±  3%  perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      3.14 ±  2%      +1.1        4.28 ±  3%  perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.84 ±  2%      +1.2        3.03 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap
      1.88 ±  2%      +1.2        3.09 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.44 ±103%      +1.2        1.68 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.97 ±  2%      +1.2        3.22 ±  4%  perf-profile.calltrace.cycles-pp.down_write.anon_vma_fork.dup_mmap.dup_mm.copy_process
      3.92            +1.3        5.19 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      4.05            +1.4        5.46 ±  3%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      5.03            +1.8        6.80 ±  3%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      5.12            +1.8        6.93 ±  3%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      5.24            +1.8        7.08 ±  3%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.93 ± 37%      +2.0        2.92 ±  4%  perf-profile.calltrace.cycles-pp.do_sched_setscheduler.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.94 ± 38%      +2.0        2.92 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setscheduler.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.68            +2.0        7.73 ±  3%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      4.84            +2.4        7.28 ±  3%  perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.__mmput.exit_mm
      7.10            +2.8        9.91 ±  3%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      6.51            +3.1        9.58 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.__mmput.exit_mm.do_exit
     10.05            +4.4       14.47 ±  4%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
     15.29            +6.2       21.54 ±  3%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
     15.32            +6.3       21.58 ±  3%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     15.36            +6.3       21.62 ±  3%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     15.79            +6.5       22.27 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.79            +6.5       22.27 ±  3%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.79            +6.8       22.61 ±  3%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.16            +7.5       26.64 ±  3%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
     19.54            +7.6       27.16 ±  3%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
     20.33            +7.9       28.24 ±  3%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.78            +8.1       28.84 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     20.78            +8.1       28.84 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
     20.75            +8.1       28.82 ±  3%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     20.75            +8.1       28.82 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
     21.20            +8.2       29.38 ±  3%  perf-profile.calltrace.cycles-pp._Fork
     17.75 ±  4%     +10.0       27.76        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.76 ±  4%     +10.0       27.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     42.64           -10.6       32.08 ±  5%  perf-profile.children.cycles-pp.__sched_setscheduler
     23.20 ±  2%     -10.5       12.72 ±  5%  perf-profile.children.cycles-pp.__sched_yield
     13.79            -4.6        9.20 ±  5%  perf-profile.children.cycles-pp.__x64_sys_sched_yield
     21.95            -4.1       17.83 ±  5%  perf-profile.children.cycles-pp.__x64_sys_sched_setscheduler
     21.92            -4.1       17.80 ±  5%  perf-profile.children.cycles-pp.do_sched_setscheduler
     11.34            -3.9        7.41 ±  5%  perf-profile.children.cycles-pp.schedule
     11.22            -3.8        7.40 ±  4%  perf-profile.children.cycles-pp.__schedule
     18.91            -3.5       15.43 ±  5%  perf-profile.children.cycles-pp._sched_setscheduler
      4.96            -2.0        2.94 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.85            -2.0        1.87 ±  5%  perf-profile.children.cycles-pp.stress_resched_child
      4.77            -1.5        3.30 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.23 ±  2%      -1.3        2.88 ±  4%  perf-profile.children.cycles-pp.__sched_getscheduler
      4.59            -1.2        3.39 ±  4%  perf-profile.children.cycles-pp.update_load_avg
      2.35            -1.1        1.26 ±  5%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      2.74            -1.0        1.72 ±  5%  perf-profile.children.cycles-pp.put_prev_entity
      3.17 ±  2%      -0.9        2.26 ± 11%  perf-profile.children.cycles-pp.capable
      3.15 ±  3%      -0.9        2.24 ± 11%  perf-profile.children.cycles-pp.security_capable
      3.06 ±  3%      -0.9        2.16 ± 11%  perf-profile.children.cycles-pp.apparmor_capable
      1.97            -0.8        1.13 ±  5%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      2.94            -0.8        2.10 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      4.13            -0.8        3.29 ±  4%  perf-profile.children.cycles-pp.update_curr
      3.31            -0.8        2.54 ±  4%  perf-profile.children.cycles-pp.dequeue_entity
      3.04            -0.8        2.28 ±  4%  perf-profile.children.cycles-pp.clear_bhb_loop
      5.14            -0.7        4.40 ±  4%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.53            -0.6        1.93 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
      1.29            -0.5        0.74 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      1.08            -0.5        0.58 ±  6%  perf-profile.children.cycles-pp.prepare_task_switch
      1.24            -0.5        0.77 ±  3%  perf-profile.children.cycles-pp.rseq_ip_fixup
      2.84            -0.5        2.38 ±  3%  perf-profile.children.cycles-pp.find_task_by_vpid
      2.32            -0.4        1.87 ±  4%  perf-profile.children.cycles-pp.do_sched_yield
      0.94 ± 12%      -0.4        0.50 ± 19%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.94 ± 12%      -0.4        0.50 ± 19%  perf-profile.children.cycles-pp.perf_session__process_user_event
      1.45            -0.4        1.01 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.01            -0.4        0.58 ±  4%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.91 ± 11%      -0.4        0.49 ± 19%  perf-profile.children.cycles-pp.perf_session__deliver_event
      1.46            -0.4        1.05 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
      1.86            -0.4        1.46 ±  4%  perf-profile.children.cycles-pp.yield_task_fair
      1.54            -0.4        1.15 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.28            -0.4        0.91 ±  4%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.79            -0.4        0.42 ±  5%  perf-profile.children.cycles-pp.__switch_to
      1.81            -0.3        1.46 ±  3%  perf-profile.children.cycles-pp.set_next_task_fair
      1.52 ±  3%      -0.3        1.18 ±  4%  perf-profile.children.cycles-pp.__enqueue_entity
      0.72            -0.3        0.41 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
      0.79 ±  2%      -0.3        0.50 ±  2%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.73            -0.3        0.45 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.37 ±  2%      -0.3        1.11 ±  3%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.52 ±  2%      -0.3        0.26 ±  7%  perf-profile.children.cycles-pp.os_xsave
      1.06            -0.2        0.81 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.72 ±  2%      -0.2        0.47        perf-profile.children.cycles-pp.__get_user_8
      1.17 ±  5%      -0.2        0.92 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
      1.31 ±  2%      -0.2        1.08 ±  5%  perf-profile.children.cycles-pp.__dequeue_entity
      0.61 ±  2%      -0.2        0.40 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.42            -0.2        0.21 ±  7%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      1.34            -0.2        1.13 ±  3%  perf-profile.children.cycles-pp.__x64_sys_sched_getscheduler
      0.74 ±  7%      -0.2        0.54 ±  4%  perf-profile.children.cycles-pp._copy_from_user
      0.40 ±  2%      -0.2        0.22 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_handle_over_high
      0.85            -0.2        0.68 ±  3%  perf-profile.children.cycles-pp.update_rq_clock
      0.32 ±  2%      -0.2        0.15 ±  8%  perf-profile.children.cycles-pp.blkcg_maybe_throttle_current
      0.81            -0.2        0.65 ±  5%  perf-profile.children.cycles-pp.task_rq_lock
      0.58            -0.1        0.43 ±  4%  perf-profile.children.cycles-pp.place_entity
      0.82            -0.1        0.68 ±  3%  perf-profile.children.cycles-pp.__calc_delta
      0.62            -0.1        0.49 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.25 ±  2%      -0.1        0.12 ±  9%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.27 ± 12%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.sched_getscheduler@plt
      0.30            -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.__put_user_8
      0.27 ±  8%      -0.1        0.14 ± 10%  perf-profile.children.cycles-pp.sched_yield@plt
      0.54            -0.1        0.42 ±  4%  perf-profile.children.cycles-pp.sched_clock
      0.51 ±  6%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.56 ±  3%      -0.1        0.45 ±  6%  perf-profile.children.cycles-pp.update_min_vruntime
      0.82 ±  2%      -0.1        0.71 ±  3%  perf-profile.children.cycles-pp.pick_eevdf
      0.36 ±  8%      -0.1        0.26 ±  5%  perf-profile.children.cycles-pp.cpuacct_charge
      0.48            -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.41 ±  3%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.32 ±  2%      -0.1        0.23 ±  7%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.14 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.18 ± 16%      -0.1        0.11 ± 19%  perf-profile.children.cycles-pp.machine__process_exit_event
      0.36 ±  2%      -0.1        0.28 ±  4%  perf-profile.children.cycles-pp.rt_mutex_adjust_pi
      0.37            -0.1        0.30 ±  4%  perf-profile.children.cycles-pp.update_curr_se
      0.17 ± 17%      -0.1        0.10 ± 21%  perf-profile.children.cycles-pp.thread__delete
      0.31 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.x64_sys_call
      0.95 ±  3%      -0.1        0.88 ±  3%  perf-profile.children.cycles-pp.idr_find
      0.12            -0.1        0.05 ±  7%  perf-profile.children.cycles-pp.sched_update_worker
      0.13 ±  5%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.shim_sched_yield
      0.15 ± 13%      -0.1        0.09 ± 20%  perf-profile.children.cycles-pp.maps__put
      0.10 ±  3%      -0.1        0.04 ± 45%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.58 ±  2%      -0.0        0.54        perf-profile.children.cycles-pp.finish_task_switch
      0.12 ± 15%      -0.0        0.07 ± 23%  perf-profile.children.cycles-pp.map__put
      0.18 ±  2%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.22 ±  8%      -0.0        0.17 ± 11%  perf-profile.children.cycles-pp.rb_next
      0.16 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.62            -0.0        0.59        perf-profile.children.cycles-pp.__rb_insert_augmented
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.10 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.mm_cid_get
      0.11            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.amd_clear_divider
      0.11            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.check_cfs_rq_runtime
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.sched_setscheduler@plt
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.security_task_setscheduler
      0.10 ±  7%      -0.0        0.08 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.08 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.min_vruntime_cb_rotate
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.enqueue_task
      0.28            -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.vruntime_eligible
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.raw_spin_rq_unlock
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.dequeue_task
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.check_class_changed
      0.05            +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.perf_event_task_output
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__put_task_struct
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__tlb_remove_folio_pages_size
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.free_pud_range
      0.06 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.09 ±  5%      +0.0        0.10 ±  7%  perf-profile.children.cycles-pp.sched_balance_domains
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.05            +0.0        0.07 ±  5%  perf-profile.children.cycles-pp._find_next_bit
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.free_percpu
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.06            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.do_task_dead
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.free_p4d_range
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.mas_wr_walk
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.__pte_offset_map
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.lru_add_drain
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.mas_ascend
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.perf_iterate_sb
      0.06            +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.xas_find
      0.09 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.__exit_signal
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.free_pgd_range
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.xas_load
      0.19 ±  2%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.schedule_tail
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.vfree
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.06 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.alloc_pid
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.free_unref_folios
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.mas_copy_node
      0.08 ±  4%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.vm_normal_page
      0.05            +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.10 ±  3%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.__memcpy
      0.06 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
      0.06 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.mas_dup_alloc
      0.10 ±  3%      +0.0        0.13 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.09 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.wait_consider_task
      0.11 ±  3%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.09            +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.get_free_pages_noprof
      0.09 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.09 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.mas_next_node
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.08            +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.sched_move_task
      0.08 ±  8%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.alloc_pages_bulk_noprof
      0.09            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.pgd_alloc
      0.03 ± 70%      +0.0        0.07 ±  8%  perf-profile.children.cycles-pp.__page_cache_release
      0.11 ±  6%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.10 ±  6%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.process_one_work
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.12 ±  4%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.__perf_sw_event
      0.13 ±  5%      +0.0        0.17 ±  3%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.16 ±  9%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.kthread
      0.10 ±  6%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__vmalloc_area_node
      0.14 ±  3%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.sync_regs
      0.13 ±  7%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.try_charge_memcg
      0.11 ±  9%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.worker_thread
      0.13 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.15 ±  5%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.14 ±  4%      +0.0        0.19        perf-profile.children.cycles-pp.memset_orig
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__getpid
      0.06 ±  7%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.down_read_trylock
      0.23            +0.0        0.28        perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.copy_signal
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.get_zeroed_page_noprof
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mt_destroy_walk
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.prepare_creds
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.put_files_struct
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.remove_vm_area
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.stress_get_setting
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.uncharge_batch
      0.20 ±  3%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.23 ±  5%      +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.__mmdrop
      0.10 ±  3%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.__p4d_alloc
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.copy_creds
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.free_swap_cache
      0.21 ±  2%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.14 ±  4%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.__mt_dup
      0.24 ±  2%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.11            +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.__put_user_4
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__mt_destroy
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.do_wp_page
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.put_cred_rcu
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.wake_q_add
      0.10 ±  3%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__wake_up_sync_key
      0.16 ±  7%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.16 ±  7%      +0.1        0.21 ± 10%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.14 ±  3%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.mas_dup_build
      0.18 ±  4%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.mas_store
      0.16 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.stress_parent_died_alarm
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.dup_fd
      0.14 ±  3%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.release_task
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__get_vm_area_node
      0.11 ±  3%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.11 ±  3%      +0.1        0.17 ±  3%  perf-profile.children.cycles-pp.do_notify_parent
      0.19 ±  5%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.19 ±  2%      +0.1        0.25 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
      0.20 ±  3%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.16 ±  3%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.wait_task_zombie
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.46            +0.1        0.52        perf-profile.children.cycles-pp.__rb_erase_color
      0.14 ±  4%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.40            +0.1        0.47 ±  4%  perf-profile.children.cycles-pp.avg_vruntime
      0.23 ±  3%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.19 ±  3%      +0.1        0.26        perf-profile.children.cycles-pp.prctl
      0.36 ±  2%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.ret_from_fork
      0.19 ±  3%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.getpid@plt
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      0.37 ±  2%      +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      0.34 ±  2%      +0.1        0.41        perf-profile.children.cycles-pp.irq_exit_rcu
      0.17            +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.00            +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.sched_balance_rq
      0.13 ± 44%      +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.sched_settings_apply
      0.50 ±  5%      +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.07 ±  5%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.19 ±  3%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.30            +0.1        0.37        perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.51 ±  4%      +0.1        0.58 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.31            +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.20            +0.1        0.28 ±  3%  perf-profile.children.cycles-pp.unmap_single_vma
      0.34 ±  3%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.24 ±  3%      +0.1        0.33 ±  4%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.32 ±  2%      +0.1        0.40        perf-profile.children.cycles-pp.sched_balance_find_dst_cpu
      0.37 ±  3%      +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.11 ±  4%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.try_to_wake_up
      0.38 ±  5%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.40 ±  5%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.22 ±  3%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.32            +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
      0.35            +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.15 ±  2%      +0.1        0.25 ±  2%  perf-profile.children.cycles-pp.exit_notify
      0.38 ±  2%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.33 ± 12%      +0.1        0.44 ± 14%  perf-profile.children.cycles-pp.stress_resched
      0.39            +0.1        0.50        perf-profile.children.cycles-pp.mas_find
      0.33 ±  6%      +0.1        0.45 ±  8%  perf-profile.children.cycles-pp.wp_page_copy
      0.33 ±  2%      +0.1        0.46 ±  3%  perf-profile.children.cycles-pp.dup_task_struct
      0.33 ±  2%      +0.1        0.46 ±  2%  perf-profile.children.cycles-pp.mm_init
      0.42 ±  7%      +0.1        0.55 ±  4%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.19 ±  5%      +0.1        0.32 ±  5%  perf-profile.children.cycles-pp.osq_unlock
      0.41 ±  6%      +0.1        0.55 ±  4%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.34            +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.fput
      0.37 ±  5%      +0.1        0.51 ±  4%  perf-profile.children.cycles-pp.clear_page_erms
      0.30 ±  2%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.__do_wait
      0.48            +0.1        0.62 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.40            +0.1        0.54 ±  2%  perf-profile.children.cycles-pp.wake_up_new_task
      0.86 ±  3%      +0.1        1.00        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.2        0.15 ±  7%  perf-profile.children.cycles-pp.rwsem_wake
      0.91 ±  2%      +0.2        1.07        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.24 ±  2%      +0.2        0.39 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.30            +0.2        0.45 ±  2%  perf-profile.children.cycles-pp.acct_collect
      0.45 ±  7%      +0.2        0.61 ±  6%  perf-profile.children.cycles-pp.__pte_alloc
      0.41            +0.2        0.58 ±  3%  perf-profile.children.cycles-pp.remove_vma
      0.53 ±  5%      +0.2        0.70 ±  5%  perf-profile.children.cycles-pp.pte_alloc_one
      0.34            +0.2        0.52 ±  2%  perf-profile.children.cycles-pp._exit
      0.40 ±  2%      +0.2        0.60 ± 13%  perf-profile.children.cycles-pp.__libc_fork
      1.05            +0.2        1.25 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_insert_after
      0.38 ±  2%      +0.2        0.58 ±  3%  perf-profile.children.cycles-pp.do_wait
      0.39 ±  2%      +0.2        0.59 ±  3%  perf-profile.children.cycles-pp.kernel_wait4
      0.16 ±  4%      +0.2        0.36 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.39 ±  2%      +0.2        0.59 ±  3%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.45 ±  2%      +0.2        0.67 ±  3%  perf-profile.children.cycles-pp.wait4
      0.77            +0.2        1.00 ±  2%  perf-profile.children.cycles-pp.__slab_free
      0.65 ±  2%      +0.2        0.89 ±  3%  perf-profile.children.cycles-pp.__vm_area_free
      0.55 ±  2%      +0.2        0.79 ±  3%  perf-profile.children.cycles-pp.folios_put_refs
      0.19 ± 54%      +0.3        0.45 ± 17%  perf-profile.children.cycles-pp.ordered_events__queue
      0.19 ± 53%      +0.3        0.44 ± 17%  perf-profile.children.cycles-pp.queue_event
      0.75            +0.3        1.02 ±  3%  perf-profile.children.cycles-pp.unlink_file_vma
      0.20 ± 54%      +0.3        0.48 ± 17%  perf-profile.children.cycles-pp.process_simple
      1.02            +0.3        1.29 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      0.84 ±  6%      +0.3        1.12 ±  4%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.86 ±  6%      +0.3        1.14 ±  4%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.83 ±  2%      +0.3        1.12 ±  3%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.44            +0.3        0.74 ±  4%  perf-profile.children.cycles-pp.__put_anon_vma
      0.10 ± 27%      +0.3        0.45 ±  5%  perf-profile.children.cycles-pp.set_load_weight
      0.96            +0.4        1.34 ±  2%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      1.23 ±  2%      +0.5        1.70 ±  2%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      1.23 ±  2%      +0.5        1.70 ±  2%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      1.19 ±  2%      +0.5        1.67 ±  2%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.68            +0.5        2.16 ±  3%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      2.07            +0.6        2.68 ±  4%  perf-profile.children.cycles-pp.vm_area_dup
      1.72            +0.6        2.34 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      2.11            +0.7        2.86 ±  3%  perf-profile.children.cycles-pp.next_uptodate_folio
      2.02            +0.8        2.78 ±  2%  perf-profile.children.cycles-pp.copy_present_ptes
      1.46            +0.8        2.23 ±  4%  perf-profile.children.cycles-pp.up_write
      2.85            +0.8        3.63 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.30            +0.9        1.22 ±  4%  perf-profile.children.cycles-pp.reweight_entity
      2.92            +1.0        3.90 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      2.84 ±  2%      +1.0        3.84 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      2.77 ±  2%      +1.0        3.79 ±  3%  perf-profile.children.cycles-pp.copy_pte_range
      2.97 ±  2%      +1.0        4.00 ±  3%  perf-profile.children.cycles-pp.do_fault
      2.96 ±  2%      +1.0        3.99 ±  3%  perf-profile.children.cycles-pp.do_read_fault
      3.08 ±  2%      +1.1        4.20 ±  3%  perf-profile.children.cycles-pp.copy_p4d_range
      3.15 ±  2%      +1.1        4.29 ±  3%  perf-profile.children.cycles-pp.copy_page_range
      3.47            +1.2        4.69 ±  3%  perf-profile.children.cycles-pp.__handle_mm_fault
      3.59            +1.3        4.86 ±  3%  perf-profile.children.cycles-pp.handle_mm_fault
      3.94            +1.3        5.22 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      2.38            +1.4        3.76 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      4.04            +1.4        5.45 ±  2%  perf-profile.children.cycles-pp._compound_head
      4.10            +1.4        5.53 ±  2%  perf-profile.children.cycles-pp.zap_present_ptes
      3.94            +1.5        5.40 ±  3%  perf-profile.children.cycles-pp.do_user_addr_fault
      3.95            +1.5        5.42 ±  3%  perf-profile.children.cycles-pp.exc_page_fault
      1.88 ±  3%      +1.5        3.43 ±  5%  perf-profile.children.cycles-pp.osq_lock
      4.23            +1.6        5.80 ±  3%  perf-profile.children.cycles-pp.asm_exc_page_fault
      5.05            +1.8        6.83 ±  3%  perf-profile.children.cycles-pp.zap_pte_range
      5.13            +1.8        6.94 ±  3%  perf-profile.children.cycles-pp.zap_pmd_range
      5.25            +1.8        7.09 ±  3%  perf-profile.children.cycles-pp.unmap_page_range
      5.69            +2.0        7.73 ±  3%  perf-profile.children.cycles-pp.unmap_vmas
      4.85            +2.4        7.28 ±  3%  perf-profile.children.cycles-pp.unlink_anon_vmas
      7.11            +2.8        9.92 ±  3%  perf-profile.children.cycles-pp.anon_vma_clone
      6.52            +3.1        9.59 ±  3%  perf-profile.children.cycles-pp.free_pgtables
      4.58 ±  2%      +3.1        7.72 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      4.73 ±  2%      +3.2        7.95 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     81.32            +3.4       84.68        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     80.69            +3.6       84.27        perf-profile.children.cycles-pp.do_syscall_64
      6.61 ±  2%      +3.9       10.52 ±  4%  perf-profile.children.cycles-pp.down_write
     10.06            +4.4       14.48 ±  4%  perf-profile.children.cycles-pp.anon_vma_fork
     15.30            +6.2       21.55 ±  3%  perf-profile.children.cycles-pp.exit_mmap
     15.32            +6.3       21.58 ±  3%  perf-profile.children.cycles-pp.__mmput
     15.37            +6.3       21.64 ±  3%  perf-profile.children.cycles-pp.exit_mm
     16.13            +6.6       22.77 ±  3%  perf-profile.children.cycles-pp.do_exit
     16.13            +6.6       22.78 ±  3%  perf-profile.children.cycles-pp.__x64_sys_exit_group
     16.13            +6.6       22.78 ±  3%  perf-profile.children.cycles-pp.do_group_exit
     19.19            +7.5       26.68 ±  3%  perf-profile.children.cycles-pp.dup_mmap
     19.54            +7.6       27.16 ±  3%  perf-profile.children.cycles-pp.dup_mm
     20.33            +7.9       28.25 ±  3%  perf-profile.children.cycles-pp.copy_process
     20.75            +8.1       28.82 ±  3%  perf-profile.children.cycles-pp.__do_sys_clone
     20.75            +8.1       28.82 ±  3%  perf-profile.children.cycles-pp.kernel_clone
     21.22            +8.2       29.42 ±  3%  perf-profile.children.cycles-pp._Fork
      3.45            -1.8        1.62 ±  5%  perf-profile.self.cycles-pp.stress_resched_child
      2.32            -1.1        1.24 ±  5%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      3.02 ±  3%      -0.9        2.13 ± 11%  perf-profile.self.cycles-pp.apparmor_capable
      3.02            -0.8        2.26 ±  4%  perf-profile.self.cycles-pp.clear_bhb_loop
      1.50            -0.5        1.04 ±  4%  perf-profile.self.cycles-pp.__schedule
      1.00            -0.4        0.57 ±  5%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      1.68            -0.4        1.26 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      1.30            -0.4        0.93 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      1.34 ±  2%      -0.4        0.97 ±  4%  perf-profile.self.cycles-pp.__sched_setscheduler
      1.45            -0.4        1.09 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.76            -0.3        0.41 ±  5%  perf-profile.self.cycles-pp.__switch_to
      1.49 ±  3%      -0.3        1.15 ±  4%  perf-profile.self.cycles-pp.__enqueue_entity
      0.85 ±  5%      -0.3        0.52 ±  7%  perf-profile.self.cycles-pp.__sched_yield
      0.71            -0.3        0.41 ±  4%  perf-profile.self.cycles-pp.__switch_to_asm
      1.63            -0.3        1.35 ±  4%  perf-profile.self.cycles-pp.update_curr
      1.34 ±  2%      -0.3        1.08 ±  4%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.51 ±  2%      -0.3        0.26 ±  6%  perf-profile.self.cycles-pp.os_xsave
      0.76            -0.2        0.52 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.65            -0.2        0.40 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.70 ±  2%      -0.2        0.46        perf-profile.self.cycles-pp.__get_user_8
      0.56            -0.2        0.32 ±  5%  perf-profile.self.cycles-pp.prepare_task_switch
      1.03            -0.2        0.79 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.66            -0.2        0.43 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.12 ±  5%      -0.2        0.89 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.40 ±  2%      -0.2        0.20 ±  9%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.72 ±  7%      -0.2        0.53 ±  5%  perf-profile.self.cycles-pp._copy_from_user
      0.39 ±  2%      -0.2        0.21 ±  6%  perf-profile.self.cycles-pp.mem_cgroup_handle_over_high
      0.52 ±  2%      -0.2        0.34 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.32            -0.2        0.16 ±  8%  perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.31 ±  2%      -0.2        0.15 ±  9%  perf-profile.self.cycles-pp.blkcg_maybe_throttle_current
      0.48            -0.2        0.33 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.00 ±  2%      -0.2        0.85 ±  4%  perf-profile.self.cycles-pp.__dequeue_entity
      0.45 ±  2%      -0.1        0.30 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.62            -0.1        0.47 ±  4%  perf-profile.self.cycles-pp.do_sched_setscheduler
      0.54 ±  2%      -0.1        0.40 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
      0.24 ±  3%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.52 ±  2%      -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.find_task_by_vpid
      0.25            -0.1        0.13 ±  8%  perf-profile.self.cycles-pp.__put_user_8
      0.36 ±  2%      -0.1        0.24 ±  5%  perf-profile.self.cycles-pp.__sched_getscheduler
      0.75            -0.1        0.63 ±  3%  perf-profile.self.cycles-pp.__calc_delta
      0.38            -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.set_next_entity
      0.52 ±  3%      -0.1        0.41 ±  6%  perf-profile.self.cycles-pp.update_min_vruntime
      0.28 ±  2%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.switch_fpu_return
      0.20 ± 17%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.sched_getscheduler@plt
      0.45            -0.1        0.35 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.54            -0.1        0.44 ±  4%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.46            -0.1        0.37 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.34 ±  8%      -0.1        0.25 ±  6%  perf-profile.self.cycles-pp.cpuacct_charge
      0.39 ±  2%      -0.1        0.30 ±  4%  perf-profile.self.cycles-pp._sched_setscheduler
      0.26 ± 13%      -0.1        0.18 ± 12%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      1.10            -0.1        1.02 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.38 ±  3%      -0.1        0.29 ±  5%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.56            -0.1        0.48 ±  3%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.56 ±  2%      -0.1        0.48 ±  4%  perf-profile.self.cycles-pp.pick_eevdf
      0.19 ±  3%      -0.1        0.11 ±  5%  perf-profile.self.cycles-pp.schedule
      0.30 ±  3%      -0.1        0.22 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.16 ±  3%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.__x64_sys_sched_yield
      0.18 ± 13%      -0.1        0.10 ± 10%  perf-profile.self.cycles-pp.sched_yield@plt
      0.13 ±  3%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.29            -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.place_entity
      0.26 ±  2%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.finish_task_switch
      0.16 ±  4%      -0.1        0.09 ±  7%  perf-profile.self.cycles-pp.rseq_ip_fixup
      0.23 ±  3%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.put_prev_entity
      0.31            -0.1        0.25 ±  4%  perf-profile.self.cycles-pp.update_curr_se
      0.27            -0.1        0.21 ±  4%  perf-profile.self.cycles-pp.x64_sys_call
      0.32 ±  2%      -0.1        0.26 ±  5%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.78            -0.1        0.73        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ±  5%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.sched_setscheduler@plt
      0.09 ± 17%      -0.0        0.05 ± 49%  perf-profile.self.cycles-pp.map__put
      0.15 ±  3%      -0.0        0.11 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.21 ±  2%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.update_rq_clock
      0.06            -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.security_task_setscheduler
      0.58            -0.0        0.55        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.13 ±  5%      -0.0        0.10 ±  7%  perf-profile.self.cycles-pp.do_sched_yield
      0.13 ±  2%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.task_rq_lock
      0.13            -0.0        0.10        perf-profile.self.cycles-pp.yield_task_fair
      0.10 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.mm_cid_get
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__x64_sys_sched_getscheduler
      0.25            -0.0        0.22 ±  4%  perf-profile.self.cycles-pp.vruntime_eligible
      0.12            -0.0        0.10 ±  5%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ±  6%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.min_vruntime_cb_rotate
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.enqueue_task
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.dequeue_task
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.put_prev_task_fair
      0.14 ±  3%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp.set_next_task_fair
      0.06 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.raw_spin_rq_unlock
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.rt_mutex_adjust_pi
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.__pte_offset_map
      0.07 ±  7%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.mas_store
      0.05 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.copy_page_range
      0.06 ±  8%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.zap_pmd_range
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.memcg_account_kmem
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.copy_p4d_range
      0.07            +0.0        0.09        perf-profile.self.cycles-pp.mas_find
      0.06            +0.0        0.08        perf-profile.self.cycles-pp.mas_next_node
      0.06            +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.remove_vma
      0.06            +0.0        0.08        perf-profile.self.cycles-pp.set_pte_range
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.mas_wr_walk
      0.07 ±  5%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.11 ±  4%      +0.0        0.13 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.07            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.vm_normal_page
      0.09 ±  7%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.09 ±  6%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.06 ±  6%      +0.0        0.09 ±  8%  perf-profile.self.cycles-pp.__libc_fork
      0.10 ±  3%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__memcpy
      0.03 ± 70%      +0.0        0.06        perf-profile.self.cycles-pp.mas_copy_node
      0.38 ±  2%      +0.0        0.40        perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.08 ±  4%      +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.wait_consider_task
      0.10            +0.0        0.13        perf-profile.self.cycles-pp.unmap_page_range
      0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.07            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.free_pgtables
      0.06            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__vm_area_free
      0.08            +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.11 ±  9%      +0.0        0.15 ±  6%  perf-profile.self.cycles-pp.try_charge_memcg
      0.14 ±  3%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.sync_regs
      0.13 ±  5%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.13 ±  3%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.06 ±  7%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.down_read_trylock
      0.14 ±  4%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.memset_orig
      0.07 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.pcpu_alloc_noprof
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.stress_get_setting
      0.16 ±  2%      +0.1        0.21 ±  3%  perf-profile.self.cycles-pp.refill_obj_stock
      0.22 ±  2%      +0.1        0.28        perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp._Fork
      0.16 ±  7%      +0.1        0.21 ± 10%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.05 ±  7%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.queued_write_lock_slowpath
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__tlb_remove_folio_pages_size
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.wake_q_add
      0.10 ±  4%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.__put_anon_vma
      0.20            +0.1        0.26        perf-profile.self.cycles-pp.mas_next_slot
      0.40            +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.__rb_erase_color
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.11            +0.1        0.17 ±  3%  perf-profile.self.cycles-pp.mas_walk
      0.21 ±  4%      +0.1        0.28 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.37 ±  2%      +0.1        0.44 ±  3%  perf-profile.self.cycles-pp.avg_vruntime
      0.17 ±  2%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_augment_rotate
      0.28            +0.1        0.35 ±  2%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.06 ± 17%      +0.1        0.13 ±  5%  perf-profile.self.cycles-pp.set_load_weight
      0.19 ±  2%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.unmap_single_vma
      0.15 ±  5%      +0.1        0.22 ±  9%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.16 ± 20%      +0.1        0.24 ± 14%  perf-profile.self.cycles-pp.copy_pte_range
      0.14 ±  6%      +0.1        0.22 ± 12%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.30            +0.1        0.40 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.37 ±  3%      +0.1        0.46 ±  8%  perf-profile.self.cycles-pp.___slab_alloc
      0.28 ±  2%      +0.1        0.38 ±  5%  perf-profile.self.cycles-pp.anon_vma_fork
      0.16 ±  3%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp.unmap_vmas
      0.47 ±  2%      +0.1        0.59 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.21 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.acct_collect
      0.43            +0.1        0.56 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.19 ±  5%      +0.1        0.32 ±  5%  perf-profile.self.cycles-pp.osq_unlock
      0.34            +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.fput
      0.34            +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.37 ±  4%      +0.1        0.51 ±  3%  perf-profile.self.cycles-pp.clear_page_erms
      0.50 ±  3%      +0.2        0.67 ±  3%  perf-profile.self.cycles-pp.filemap_map_pages
      0.51 ±  2%      +0.2        0.69 ±  5%  perf-profile.self.cycles-pp.vm_area_dup
      0.56 ±  3%      +0.2        0.74 ±  2%  perf-profile.self.cycles-pp.anon_vma_clone
      0.40 ±  4%      +0.2        0.60 ±  3%  perf-profile.self.cycles-pp.folios_put_refs
      1.04            +0.2        1.23 ±  3%  perf-profile.self.cycles-pp.vma_interval_tree_insert_after
      0.16 ±  4%      +0.2        0.36 ±  5%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.50 ±  2%      +0.2        0.70 ±  2%  perf-profile.self.cycles-pp.zap_present_ptes
      0.66            +0.2        0.87 ±  2%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.76            +0.2        0.97 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.71            +0.2        0.93 ±  2%  perf-profile.self.cycles-pp.mod_objcg_state
      0.61            +0.2        0.85 ±  2%  perf-profile.self.cycles-pp.copy_present_ptes
      0.18 ± 54%      +0.3        0.44 ± 18%  perf-profile.self.cycles-pp.queue_event
      0.86            +0.3        1.12 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.81 ±  2%      +0.3        1.08 ±  3%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.72 ±  5%      +0.3        1.04 ±  7%  perf-profile.self.cycles-pp.zap_pte_range
      0.81            +0.3        1.15 ±  3%  perf-profile.self.cycles-pp.dup_mmap
      0.94            +0.4        1.32 ±  2%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      1.02            +0.4        1.44 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.27            +0.4        0.71 ±  4%  perf-profile.self.cycles-pp.reweight_entity
      1.41            +0.6        2.04 ±  4%  perf-profile.self.cycles-pp.up_write
      1.70            +0.6        2.34 ±  2%  perf-profile.self.cycles-pp.down_write
      2.02 ±  2%      +0.7        2.74 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      3.90            +1.3        5.17 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      2.35            +1.4        3.71 ±  4%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      3.98            +1.4        5.37 ±  2%  perf-profile.self.cycles-pp._compound_head
      1.86 ±  3%      +1.5        3.40 ±  5%  perf-profile.self.cycles-pp.osq_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


