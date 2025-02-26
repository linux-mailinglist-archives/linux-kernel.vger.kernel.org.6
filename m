Return-Path: <linux-kernel+bounces-534383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA609A46615
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA83F3A71B1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D221D3EF;
	Wed, 26 Feb 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6UZVWez"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37021CC68
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585695; cv=fail; b=W/IiQXqsuAUEoNYOoU5iYnq7rpbCv2tCoC+y7kKAqMd8ycNHrq8Uoz3PDHqR5BUoo9bVkmjyZaqdrU7k9sfEMzC5YtkQV2bDDWfthipaDIk4m+YG0YWcv6Erk4Dgo3jLyhSPZiEcDfPTD5ngSu+nmfsdqFKLid5wITzXiOMLS/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585695; c=relaxed/simple;
	bh=ZK4/XVNvgmOyIp9/z+UBjfPxNuxuJqfqGOdpNMiBF1M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SCs+W/mO+KjsSJg4pDTjOHQp09e0qddV/mEJ5HnOnl+sHF/3P+cleGbmJIIgMwCZBvmiQBpqLqTge3o+JQg2TadC9uFj78FT/AV2BmKrhsjv6E9yQ0iBAx54CpRNPlglkbuc+wx6s4PlBD1tjksFIYBw/WPaRfRNNMmWsFMNzn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6UZVWez; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740585694; x=1772121694;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ZK4/XVNvgmOyIp9/z+UBjfPxNuxuJqfqGOdpNMiBF1M=;
  b=G6UZVWezSUqTy1kVJvuEMcN3qB+p0N+OfNfe8p70pD0uEbBIZ4pzlJyg
   83gBAtc/CCg/wMLL9GAD4hv+mQ+XWUAnO5ScH6qAfMAs+u+ZPhFhYP1Qu
   AT0bDOT6RKgh02goh8SmfuFz2M8kUnaUVxa8QXv0t+1bwfFeR32BPHWCk
   LAXsHxKtFXJYJnMjYOfGp4nJL/xcXwCEpAe1W64HgCx9VdEWgbQ1KARJQ
   MOJDj9YaJxCVYq370nfQVDuKRM2KpWrWTcadmVR9ykkNPKlb3126LX3ip
   pB+Ks4otJ5Oyd7WKfV2jIIpzfGuppX/BzNDUYD0qmrLuf6ns6V80wEPY4
   A==;
X-CSE-ConnectionGUID: m4vjoHd6QGSZryDc6wJG+Q==
X-CSE-MsgGUID: ccxQbS5gSS+5uzM/ZTioeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41569735"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="41569735"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:01:33 -0800
X-CSE-ConnectionGUID: JIQjJ1UkRamyINgp+c0OYw==
X-CSE-MsgGUID: sRU1zkvoSyCgE+UU3yP50w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="121683347"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:01:33 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 08:01:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 08:01:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 08:01:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQVzmPjTiSY59+jAfZjXg/oWUKr4RLciQ5GJ0cNmCITMsui9q7P69YfWXgo1w8m8BfzQaoq8IX60W/fufd/ixf7kLBy/Sk8YOVefU5FRQSidVk92VsycG7N1bKbGPOKG/ewy/mswgqiqv3n/tJMNhfoYWNAM5QExCO5bWYLy8t602isLTQSyc9uBjJRwX8t5UbBx2DziuMvwJHb/hhid2ud5i18g4JShD5MSlWXWEYNSyD714Xh9KMTwr0K+x1cmotT67QTNqQdecjjqicwVZLr0smi0nqEFDXlbt/km95UlPadtockt+TV6uVwJ3cncrQ5075jMjernTtMEbktKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suBkNubPrHDOBcwN+1PFq3gY0n2lC1B/IG9pXtPwvDU=;
 b=S33dl5ABzOLxGCbid5LEkfer6CIQQL08az9pVsjnrgGEhbT33Zvc8d5PTke0qcG9wtvXSOyB5mF5Wnau3An/hBccPIBtEnEECmJ4DA1upU1sO4U/jqsDLCKp3QkYtK0dRuTDQkIbsUmaWYNdGynDaW2UfVXPEu0oBdCWtoxeElmtow5bt4z0tSL+/+6wprBrEj1w/Og+1dKG+pKVTkq5Tk+P8VDDU7ZGs3z5yxMnpV9qgWf23dppwfcZJVkHkccgmdsiaSGnkm6mJBDTeBYymSel8RPaEAApu8KjD6KjsMoIx2PHjp+VJFhkLNO5vQhjdHY/V0jGu5z17ou5D3KbWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 16:01:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 16:01:28 +0000
Date: Wed, 26 Feb 2025 10:01:29 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Ira Weiny <ira.weiny@intel.com>
CC: syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, Barry Song
	<21cnbao@gmail.com>, <akpm@linux-foundation.org>, <chengming.zhou@linux.dev>,
	<hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<nphamcs@gmail.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
Message-ID: <67bf3ad9ac2df_41ae42942@iweiny-mobl.notmuch>
References: <20240318204212.36505-1-21cnbao@gmail.com>
 <0000000000009221d60613f58726@google.com>
 <CAGsJ_4xdKbH8v0WaBFo_kDOHPXQnX7zrc43D=+irfzM-=2RxGw@mail.gmail.com>
 <CAJD7tkYA0ZjdjXAx3ZcFtFzAAbZ2+57QLh99o3JVBVSWNtZM7A@mail.gmail.com>
 <Z7ke871WFkYuwYl1@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7ke871WFkYuwYl1@google.com>
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 29747e70-ec39-462a-d437-08dd567ed439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUlpQXl2NXdTZiszdnIzbmtlR2JQQkd1c3NRRldEaTdFVk5kUFBWM2xCOEZu?=
 =?utf-8?B?N2t5dzFCd0Y1a3BsQ1BueFBKdG45SjBLTGpDYjV0SzRXd2tteTRpWm0wajho?=
 =?utf-8?B?bXNvblhuWDQxbFhjZlBpcHBobS83SkNreGFoUTBYWWhKYU1Hd0ZiRnAwUHV4?=
 =?utf-8?B?WENlaVRmWkNhK0dzVTJONnR3OHEwalBQZk1HNjhJZjNUL20wRGx2dkx6YU9z?=
 =?utf-8?B?SFFNMlpvMVVEeDlrNXFYYUplQ1hHZWpLbGlLWmhTUURvRndCK0dNUk1RQTh3?=
 =?utf-8?B?TXJaNjhxb0x5eFc4cEhlSVZtQUt5a0pwREVWdGZSL3NBL2NnbWJlUlRLUjdx?=
 =?utf-8?B?cWU2SGhuTVVFSm9SR28vVk9CbEZ4OE5NbTNLTVVra2NVSkhaUEFaSHJxa1d2?=
 =?utf-8?B?NnE5b2V0NzVHdUdqU1Y3bURhcnAvRDJ0N2tRUXBCZHZvMTI5QzNzR2o0TFFB?=
 =?utf-8?B?bUxjV21KL3NuQjQvcVZkcEFQVWNIakV3NXdzNjNLZy8rYVBESTNkV3huUllr?=
 =?utf-8?B?TG1UZ2FQVFBscWRCN3F3cndLRHcwaUhjdVJpSHdZQkNUQit3YnZ1WnROblVN?=
 =?utf-8?B?ZE5OK0Vac2NabkN6QjQ5THRKSHE3RyswdFRSa1RqUGpyV21yQ2ttMEIyL2xl?=
 =?utf-8?B?NHZvSUg3WnFrWXBQVDNMaWlpa01PdE5FWUdLSExQZ2RxUTJ1UnIwcjRPRXha?=
 =?utf-8?B?ZGI3YXZJNER2c0toYThwTUZpU2VuK3BVVWV5YlcwK3JZUXpOWVNrME1CTWFm?=
 =?utf-8?B?UHBacGw2dmtsWlBseTNDVEdpaWpNMjlNWFFnNDdUZUIxZTVybzcwcmhLS3NY?=
 =?utf-8?B?QzBtNkNYLy8xRHFCR0EwZDRQN2xJTFFEb1JHVGowN3VrMVBzb0hkcXNsaVFr?=
 =?utf-8?B?aUZUQjJsWXNCdmdlblROZGw3SFlGYktSbmxxU1ZDdFRsM0FSQmo3YjM2bFox?=
 =?utf-8?B?cmR3ZlV0dm1XK1VBaEszNkZDQjVlaldad2ZOQ0d6MTVCSC9Gd0twWTVsYnhB?=
 =?utf-8?B?MmRiR3lZUWMxZ1RvMWE3dlR2cXJSVEY0dG8zWk8rbW9MYjV4MEQveXA0azFt?=
 =?utf-8?B?N1dSTlljSVYwVXVXbXVnamV3elROWFBLK0toNGwvRHZVemZMUGNCNUdKZFhi?=
 =?utf-8?B?aWg4NzcyUlZwK2VPY1Bsci9nQ0Vyd3dlQU14eURKL0ljVy9xTFlwNVU1Njdh?=
 =?utf-8?B?NFpOaEd4Yk9rS0ZaY2FISG9JQ1c3Q0tnN0JuMUUyZ3BKUkFnOVU2WVhoNGZz?=
 =?utf-8?B?SW5sTHVIWm1VN2R6OFpyRTErdGNNT2hMRDNXR3hQRjMvSVp5cFVPOUFnbm82?=
 =?utf-8?B?VVo1T2NDUDFqbzVsTmszTUt1RU1rWFZCVThWQ3JMK0NZYnluK1pKNmc5N3Rs?=
 =?utf-8?B?ZkNhNVBva3VjQUtXWFhjUnFrOWpoQVFhN0ZIMzZvTkdsSXNqTDNCQm9CdE5W?=
 =?utf-8?B?M2w2OWtnbEZReTJlTHVFU09BMWhMRmdYZTRjaC9JTWNzRG00YUJXVnFDNW9G?=
 =?utf-8?B?Q0Y3emNSM010Z2NYZUdpOFU1cDY1ZU9VU09waUt6SmxQVEdTdU56WWhwdXNt?=
 =?utf-8?B?QUpMSkJpYWZIbGdwOXQrRThqSjhEUytOcXdTME1jaHhsMVNTcVdCMGpWQmpR?=
 =?utf-8?B?S2JsanNTTGYzemErYnU0U0Y3S0RNNXg0QVhyemkxY2xiUTRSdnhQbDFRK01I?=
 =?utf-8?B?d3ZDVVhFTXlWSVlSVW1qQzNTcVhZZyt6dXUzR040MFZwUmxaYURRYjVwcDlR?=
 =?utf-8?B?NXBZUXVEbEVzZWZqS0Z4T0Ura1h3MTg3bmV0dnRWbmRNMzBtbUhEUElxYXJ2?=
 =?utf-8?B?bUpvRHRLMGVkK2duNCtQMVdNTUMzcDluQkZMTDFHeHFwTkhLRXNLWnF3Q0ZL?=
 =?utf-8?Q?1yZrrKdYLYY0V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRTZkwxa0dPMVU5R2V3bFl2TFNGenhWMTd5RFZmMVBWTE1QWWpRZ0ZkeXBX?=
 =?utf-8?B?STRUemE3NHdic0dJUUpJUmtSbHRHa3JMekVaVHJBaU9mYmhvVkdJNEFKKytH?=
 =?utf-8?B?dXBVTFVJNUhTQnpERllpS2thNXhIdWZ6M1lnczRGRUlvSXRoVzlWQVpNM3pL?=
 =?utf-8?B?OVN1OTU0UThPL1RhUlJqTjhqaU5NSnVNMlZzemI4OHdYaHZFcDhqTkQvSlYy?=
 =?utf-8?B?Z1l4SnJWZk5TaTlmTEhXb1FlMU1jVlRBUjIweXRTSXpMNCtRK3RybjdqamxC?=
 =?utf-8?B?WURpMjd5Tm9PYnoyVHJsK3FXd0tKOHIxRmhaWGtEdWpvekRLTkV0STIreE5v?=
 =?utf-8?B?bFQ4RmNaWG1Fd3FydTVMVE1uZk4yNVpSUmVFTERUMUk0WEovMkRLV0txYkpR?=
 =?utf-8?B?ZllzTGtDK0k2ZUpoTVNDaGVzb3FPQ0o1bUxtaG9SbVJ3R2RreU9iZG5aUUI2?=
 =?utf-8?B?VzM1NHo0TFRYSnh2NG1zRCtpMVBJTEFYRGJPMFFBWkoxdjJaS05tVHBMM3N2?=
 =?utf-8?B?SU9sZmJ6cDJCQS9CdlJOOFd6OXZMR1hIRUNYN2dWaGp0RzNuQXBRbEsyV0JM?=
 =?utf-8?B?N2gxazFrRFRnWUUrdUl2RzZ6dGVZUkRmcUpHYmp5SGhNMVhBeEV0YUU3dk1Y?=
 =?utf-8?B?UUpaZTJFUGorU3RkUldnV0x1TkdXQUZkaEhjQjVYbGhRbmYxbUg5czZJMUhI?=
 =?utf-8?B?YVY4bHNXcU5NU2pJOEt3WFowUEZjNS9oYWloQnRHRGp4aEdIcHo3OVRKQkhh?=
 =?utf-8?B?c01aZDJtNmNLaHB6SUgxczNBcTRnVFZWYlA2TUVmYUl4UDVYbndSUkhiemJw?=
 =?utf-8?B?TDYvYVVCeGpocm54SXdpTWxwVnpWK1QxWVlybk5CdWJqeVdlM291VG5BTXpt?=
 =?utf-8?B?dUVtRURuUTJyTjA1TE4rSWNiV2FrMXJhSWVWNHFDN2FjU2dseEhWUUpDZGI3?=
 =?utf-8?B?RFFFdlZsd3RBVERiQkZiaTN1YzMxSXdCVFlKM3MrblNURTZ6NzFCUDVxT1Ux?=
 =?utf-8?B?dVFlMTVUWTZGS2RyV2pJTjhuNEJCNFhwUmdYbUt6WHhKckh6N3I4MXhGalg0?=
 =?utf-8?B?a2pEc05jWWg5Wnk0RkQ0cGE2R1ZieTlZc3hsK1l2a1VkVk1WZkNhUkhGbjNu?=
 =?utf-8?B?NVlpTUJxVFhtbHREVm1Bd1lwRFhCVnA0QkFCTmR5dy9ZWU5kM2MxZWtXYjIw?=
 =?utf-8?B?dk1XTXRXVUdQYWRlS3ZESUJ2ZnNPeC9wWUJqcytrdUVqamJLeHJiQXc4UkVw?=
 =?utf-8?B?YlVIZVhuOVUxZ0xWWWRpQlQvek9jdVBjUVdrS1VTZGtSaFFNZ3hkd2FxM2Va?=
 =?utf-8?B?MnE0a01NcS9KdVdQZlRtTlA3RmNjMkNndks1U3llWHQxREFZZ09rYjZycDR2?=
 =?utf-8?B?YzdCcTRQRURaMGV2blVKRm42K0VUZUZsM2xwMlBRbGk0NnFaRUdjUDk4V0Uv?=
 =?utf-8?B?Z2lPd1BqRXdsTE16SlV1SUgveDNKZytZTDE2Wi9Kdmc1Qk5VcE12UkYvREI0?=
 =?utf-8?B?YkxsUk82NXVSYm5WNzBhOWIwN051eGlYQkw5aHJMQTZhY2VBLzdyRTN4VkZB?=
 =?utf-8?B?UkFKbm9xUkwrU09SeFZDODE0VkNUM3pwWVFLR2NRUmdYZkMzSkJIdW9FcFA5?=
 =?utf-8?B?T01kZklwMStOdTNqYVV5Y0ZYZUpETG51ZSswTUdwMENFUHFSc05icUxIOW9F?=
 =?utf-8?B?ODJPMXVyMEZCYVc4bGViZzlYakZhdDhrT2YzZFQrRlMvWkd4RXBOaUpKVERi?=
 =?utf-8?B?VHNGZUFUeTErSXVvQ0NKb1NqYkFtTWQzVFRYUWZDck9vMnE0Rm1EMGhMalZF?=
 =?utf-8?B?Wi9pcE10ajJ1a251eUdZYVA2TUN2YVBqWnJWZkpRa3p2WlhNcS9STXBETU5P?=
 =?utf-8?B?ckxrUitBYy9PLzBMZkQxWno2SUpCaUlFVG93VzBRcXZDODUvb0hDZHBkTmhE?=
 =?utf-8?B?RzVJK0pDWUxwRlVYTnRBMW8za3dTMUszbWNSUGV3YnphUXd6M0R1N0NmOXFC?=
 =?utf-8?B?M2pHWVoxRTJ1R3cwR2M5cnppbGw2aEtKYldlYUdCNUsrT3BjdkdFY0diWmRr?=
 =?utf-8?B?d0R4Sm0zK2JZQ1BBUlgxbjBrWXRJdkdFdTg1WFBXS2J0N0RUcGNGOG9pRlhF?=
 =?utf-8?Q?z3zSniIIH2hv7fc5jv7cwij8/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29747e70-ec39-462a-d437-08dd567ed439
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:01:28.5929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuI2XPw6gsmZAzjCF/vtA+fRh9LTarCv7vk5H7EK1Vbo4+LLgN/L8QgiyNFyPF6S10EnPgZBCMVCAnET08Z8/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com

Yosry Ahmed wrote:
> On Wed, Feb 12, 2025 at 09:20:24AM -0800, Yosry Ahmed wrote:
> > On Mon, Mar 18, 2024 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Tue, Mar 19, 2024 at 9:52 AM syzbot
> > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > WARNING in __kmap_to_page
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 3529 at mm/highmem.c:167 __kmap_to_page+0x100/0x194 mm/highmem.c:167
> > > > Modules linked in:
> > >
> > > + Ira
> > >
> > > Hi Ira,
> > >
> > > I noticed this warning is coming from commit ef6e06b2ef87077.
> > >
> > > you have a commit message like
> > > "    Because it is intended to remove kmap_to_page() add a warn on once to
> > >     the kmap checks to flag potential issues early.
> > > "
> > >
> > > Do we have a replacement for kmap_to_page()? The background is that we
> > > want to pass a highmem buffer to sg_set_page() but we only know its virt
> > > address.
> > 
> > I am reviving this thread because new zsmalloc changes will make
> > mappings sleepable, which will allow zswap to drop the memcpy() in
> > zswap_decompress() -- except for the !virt_addr_valid() case. We can
> > get rid of that too if we can use kmap_tp_page() in the scatterlist
> > code.
> > 
> > Ira, could you please answer Barry's question above about
> > kmap_to_page()? It has been a year and kmap_to_page() is still around.
> 
> (Trying again with Ira as the main recepient just in case)
> 
> Ira, could you please help us out here? :)

Apologies,

No there is no alternative to kmap_to_page().  The work I was doing has
stalled out and I really don't know if it will resume.

There are a few folks, like me, who would like to remove highmem but every
time the subject comes up someone speaks up about a rare (mostly embedded)
platform which really needs it.  So I don't see it going away soon.

Removing the warning could be justified by saying that highmem removal can
be done completely within the kmap calls and only when that has been
completed can these calls go away.  But generally kmap_to_page() is not a
popular call and it might be seen as a step backwards by some.

For example:
	https://lore.kernel.org/linux-mm/20221216070621.GA24832@lst.de/

The patch with the warnings was a stop gap to ensure current users did not
break.

Do you have evidence that the extra memcpy is bad enough performance that
you could justify using kmap_to_page?

Ira

> 
> > 
> > Thanks.
> 



