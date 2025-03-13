Return-Path: <linux-kernel+bounces-559783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9338A5F9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E43BDF16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145B268C6C;
	Thu, 13 Mar 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcxvGIHn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F3282FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879519; cv=fail; b=Xlv0en7bgFaMRUQOG9JXx1GWsosWEzTvnHUMYEU1le7CtiwedF66IQVZdMybG5otWMUcfm8uPIvfl83D7j6wX5wbwWP9QfaqD/kVBzEtoG9lafxV7eLxY1Fd412PTe9xz07v3Lx2uMISNcFzx0UBF/blhGd0bpDo1hJ2JqGeIW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879519; c=relaxed/simple;
	bh=pl+2Hnr6b3yvSaCL81I8Tf4qVQKwZ8qornBn9hMxOkM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3Yr617Cs1KkO7NzyR0H17Ux2fuOdPk3KHV+VDOgQPTQ0z+RhGMkrrZqFWoXDefjECGgcGXHVHeyNQXH7fgNxe9chpALqoHIK2RE4B93oFFq+A7spW2bDHBKA0vstu9HD19xfj7XRTIUCSf3mj3/DTzzgU5zNweWeliWL8e4lEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcxvGIHn; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741879518; x=1773415518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pl+2Hnr6b3yvSaCL81I8Tf4qVQKwZ8qornBn9hMxOkM=;
  b=lcxvGIHn/3bTGAbW/kl260T5gQMdcmeq5A0pUxiPhqggC8gj9BV3YN3/
   0BFrPT/yvJ7c4WbYd7SXkuFrhj20i5CkhntYoLZhOVVCI2FUAw0H7dcmb
   7aIEWYmPmeWmcfNUtONH/zVOMoH5+KO5gi0uxjj+PNP10I52B7J8h6Z8t
   Ehpzje15y8IgeCc4fOw5/eGdwv2s9T4MmdLzvaYnQMcEOZNJV4pw5LMa6
   KkL3tUzXqnMUbINTjhu0sFWIFJy++tD76Ew7U0Y5N8Ha5EUfCVOb/cqab
   vNjGJyFpna+AOe4cb20w4KdGsHn+6E5mA/iDaQDc7nnLvne5UVGXwqhWf
   A==;
X-CSE-ConnectionGUID: 6Uq8m255TX6xo/jZnFGkbA==
X-CSE-MsgGUID: 9UU9StbaT6mauMGVcF++FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43035629"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43035629"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:25:15 -0700
X-CSE-ConnectionGUID: K4F+1ZSdTHeNi369olarTQ==
X-CSE-MsgGUID: IdQFT1DaRnu0AmRz47RxjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="126041496"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:25:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 08:25:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 08:25:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 08:25:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIv+USAL68Z7qYoDbeJkqS3YHO4E3ml8zOfdFR6/RagIIMgZgofRP235bfvSDV1yfWbXIlSTOrgnNOyj8Z656IiK/3f+lUvWKGXIHTY29sxMrLVn7vgU/tJvEzqu1QtuPptnvnpRaeMpiRDPmuUO1XFMN8GzLg2lCmq4cQIycb/dzj+4Y9Y0vGx6ZdCJLdnKVI/7QLk6VTRvXYxlYA+O6UhpG7YFCOLMqwwLmQHbCqrwSjxNut+3iIjVPxkgA7IUihQsaGGNGsYr+UqXfFfrQ1hF/tfOrDk4tTH9ZR+qV2a2zlTlP9mHzPbQt3Lq1m6StXyXGRnltOZ2FSP2ZUEqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iupdsBSxi7/qsZxMqasF2DGaU3ARJ3w2Hq5Z7mwq2eI=;
 b=QMgVW5VCdyEt5mNmaa+8AceMYDUB+itUhjs+Vh+QYiH/pi8apzS1mXsv+CGBQGYfFZab+EGjWvGa0izo07xM1NQ34W6L4oVGaYMJkutWToLtGtWAlKXIrKq2Z40qT8o7CrUJGvF9r8XWbsMouF5fOJS/0nsOgUkaMxR6ZcHeA+5dq/oAqPhsrsDEfal2t9jybqZekfMle3tTLgr5e4m56vWSZn9Fwo4KV7eUJ7L7WdMW1VQVG4ceTyRNOOcDM3eivH6bU7QznYPa8TjmSjrS+MpHIVqe8e9jDlAdxQ4zJ5a46/eHgXQwXEGrDne3Mw4S2PQR3WJi92aMQAHn1akG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 15:25:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 15:25:11 +0000
Message-ID: <9e47d037-a47c-4869-8ac1-2ab151608b08@intel.com>
Date: Thu, 13 Mar 2025 08:25:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 37/49] x86/resctrl: Expand the width of dom_id by
 replacing mon_data_bits
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
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-38-james.morse@arm.com>
 <e1816cbf-e2a7-44cf-92f9-bbd24d9e264b@intel.com>
 <a54fe3e7-19cb-4f84-9189-f0e3853e98fe@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a54fe3e7-19cb-4f84-9189-f0e3853e98fe@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 57904cd6-78ad-408f-c91b-08dd62433ebe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG1BTkFnWnN6RjI5a3lHaUY5N3dpWTlFR1BJTk1SMnpHVi96M2JqZlY5Wlla?=
 =?utf-8?B?Qzh6dE91enM5QlNiaCt5Zm5ZUWtYdkUrNUl5YUgwYnpNNlBmRmY2SThHUFVk?=
 =?utf-8?B?emh5RWRVVGhNT1JCbWRBN1c2cCtCRnoxYWc2YXRNV2ZqQmxWZ1EzVHpDSlky?=
 =?utf-8?B?bmkwb3pMRWhTeW81dEZOUnN3ZndRYml3cEpjK3k2c1UvQTNjd2hTY2JsVFBq?=
 =?utf-8?B?aXg3UGk4UHBqVHVxaG13c2VNSlFEUEN0NUNqd2pPOGI1ZE9FS1lVYXk3K2dZ?=
 =?utf-8?B?NmlZSUU3WUF1RlMxaVQ1Z09TcDFmbzVCODlnalZCM3VSaHVTMzVuUWY4YlJa?=
 =?utf-8?B?cDdxKzRXRTVnS0RGdUhjcEZRS1FrUmhXa0RKemFNZ3BLRi9SN0thV3dtNkwy?=
 =?utf-8?B?NjBVdndFSUNhZWtOTU44dDFZR2lkdDlmZ3hQMCtpL2RaUGlzYW4wSWFZN1pq?=
 =?utf-8?B?dStCVzkxdWFDZE8zYTJpWWNZMTNqTmZ0dTg3ZXhIY3RkNlQyR21teU9HZXJp?=
 =?utf-8?B?WWhCOERCY2dtQ2R1UzJ1ZVl3LzNYTUI2VlAwTGpFUEVyaXpyRkw5cGUrb25k?=
 =?utf-8?B?MVAwWVpFUmpDWFM2d00xaTFWTFFpYVk2TFF3b2ZOZEkwNzVCaExQMTdqR244?=
 =?utf-8?B?a2lmdi93UjZyVllPSWxpRG9DNkNUQkg5T2txL0VrT2hDR0ZkS3VDQmVLK25v?=
 =?utf-8?B?cmpTZ2lwUklraTVLRkMvb2MzRGRza2pycTlsMTladFEyYVdrZ1FUN2dqYkZJ?=
 =?utf-8?B?cGI2bVBsSHpCNmtJenBxVitSM0l5U0RCN0Z0QmYzeEFQa2c5VTFXb09DdTk4?=
 =?utf-8?B?RzBzV1hKajlxRnFuQ1FNcGpYeE5pV2xkdEVRNmJ3WC9ya2lZTWVDYjlHS1RW?=
 =?utf-8?B?RG9NN3c1ZFhRclZUY0JPNzdhRldNZHM1WkpyZ3QwZ3NDNnpsQmpqZDJ1dHdx?=
 =?utf-8?B?c3AvK0krRkpHZGtFRVdmZUhOa3RlTkRmdXJYYTZGeG1pSVhYbzJWTHdEQmhp?=
 =?utf-8?B?d3VKYW04YW5KRkY4c25JQzllSkVudmtmam9HNk1Tb1hYVnFqLzNYTHJJYzM2?=
 =?utf-8?B?Y285aDNVN09xQXNyeElVLzNEMlNVT2NjWEp4NnBuRGxIWHAwNVhnUStxclhn?=
 =?utf-8?B?cmRFQ0lDSUZQNlU3bW5UVUc5eHRjZHR5RUpwcWQ0KytzeWlURC9qbDJ4S1g2?=
 =?utf-8?B?T3dPNlhyVmh1WjR5SUwyL1Z4NVhNZ2hZRjFYdGdvUzltdnpNMFBzSURMRUIz?=
 =?utf-8?B?TGNEUE1zaWxRVEJDeVYrNDNLZUs2Z2dCMm5NR0I4aEtrbXhkVUR5S0lxbEp5?=
 =?utf-8?B?cnc3TlZWdHFWOUtJdWtPU3ZpM3dRR25udGZPTG9YVTdvNk14dWp0UVVXd2tm?=
 =?utf-8?B?K3B4VVBJM2d3enA2UzkzZWhXTk81MFc3ZE5aRy9PT0dqRjV5aGNVRzIvR1N5?=
 =?utf-8?B?SkZNemNsdkFOVmtTZUJLTUh4dUgyWDdUWlIxTVBhMkNKbkNTNHY2aHNvNzRP?=
 =?utf-8?B?VVZLNmhtS1ZRUjFET2k3NjJtL3BXWGRqM3g5WDdjeWhyY2tjZWdHb0lJY3Fa?=
 =?utf-8?B?Ny9UbzQrbFZlU1RDakxoa0hiVm5laXZIbVNCRzQ3TWZseXJkaXdnWVNhbTRm?=
 =?utf-8?B?eFNqajJubzZjb25ER1lzWDdWcXRhWjNMc3l6OG5qN0xZWWliT3A5U0lCRllj?=
 =?utf-8?B?M0diT0tUYWxXSGxkbmU4SEZ5RHpGR1dRVlpraE1zam1hWVpSOTltenI0clZI?=
 =?utf-8?B?MDk5NkFtSFJsUEhJVVc0djdlR0p0U1NCVHY2SlBFZFRMa3ppWlF0dHBudi9V?=
 =?utf-8?B?N095bjMvT0lvVjhjRWZOWWxCSGJvUWdJOXZXOUVqdDlkMFVkVWxqbG9Fdlh3?=
 =?utf-8?Q?pgUXb/U3/ty+f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHdwQ01sQnQ5ZE1lZVRXSHFqSkRIdnFEZ2U1VFFqREJUYWZwQjg0Y3FUM0V4?=
 =?utf-8?B?ckI0VCtPekJROUJCNnZLUmFBSklhUHdDS0lJTVpsbkg4bDNFaGtEdXBGR0xx?=
 =?utf-8?B?ZjVkUFFKTk5KNDZyelpFMWw3R0QzRFdGYmtpTXljUW1KU0xSSzV6b0xIem5m?=
 =?utf-8?B?TGNxL1krSXErTnEyZmdqdmhUTmFRUWNoajlPcytRbldtOXVWTHRqNm1XcFZI?=
 =?utf-8?B?eU9hZjE5UFFNQ3BXQm5ZUCsrdURXZlpSaXBQTSswWmJWUzlxNkR5UXJoeGNw?=
 =?utf-8?B?U3kyRHRwdTRZZWlNa0hSbHBUSnBySjZNQnR0aEp1Mis0VGh0SWlXOU1STVRU?=
 =?utf-8?B?aDliRkRQQ0RnVG5YdUFjZXNHSWM1R2N6S3VucTJianF6Z0IzcjBNN1FVUDVZ?=
 =?utf-8?B?OFRMUEdoaUpXdXRBbnhMMkZpUFhrUGJ1YzljTHJEK00wUWFqSHRMc0VVY3dX?=
 =?utf-8?B?ZjZETFpZMTkwMGJDbjhaMk05MVV1ZXRaL0RVNnM5RzZCQ2ZwL2ZPL3hvYlpY?=
 =?utf-8?B?MStTeVR3NkFEODFSYm00WTRWa0t1MjZFWTVNZENETnBiajc5Q1JUNVREVVVk?=
 =?utf-8?B?MGhiVTRRUnpnWTJQazd0U0N4K3Z4MWhuNjNhc2dOSE84cnRhRTdVMk5WMVJZ?=
 =?utf-8?B?UkI2Zms4eWRZOGlITzhhMWwvdlJscUw0amd0YmxBMC9LVlJrTmYzVHNVSjdC?=
 =?utf-8?B?Z0x3L0s0YkphSWFGeEhoTm92bTkyclhlYVBTcS9qaGl3cDdhb2NPYzk3ZUpK?=
 =?utf-8?B?bk15SmdXbFc2alcyaEJxZkl4Vm55M21GcHlIdmp4RjJOYmFFYm1nbWYxNUdP?=
 =?utf-8?B?S01iNGNqMHBOendzNGVMaVN0YmU4OVdGV1RTaVM5NVJydlNYMU02ZE1tS1du?=
 =?utf-8?B?S1IvcTV0bkgxOUJjV1U2ais1M2dGVGo0amVuQk85b3BKMHFWaVpqa0VhU0Ry?=
 =?utf-8?B?WkI5M1QzRkIrU0xuemZyRndydzlJVWZObUNCcVFrR0hNWEYzdFpqRmtYWTRU?=
 =?utf-8?B?cUxyLzZsdjc2TklHaUU1bS9NbytZU0hMa21acnlRaS9mZ3d5NXRoNUVmdlVK?=
 =?utf-8?B?aFhEdUFFOXhIVjM4YVB3Ly9icTdrZEM0ZENydnNlUU1Odk12Rlk1L0ZTVGtP?=
 =?utf-8?B?SkEwSjkyQ1ZEMmNnWTRBVmFqbEZCb0FEWno0NGtYcXBNODFaMUZBZ0hvaFov?=
 =?utf-8?B?Tnh6ZTVFSFo5RzcySVlCellWSC9VQ1UxbmM0N0V0WUltVjFDZmxGOC9mcFB5?=
 =?utf-8?B?RW9hbG84V0xhZlhCaDIwM2FKVktEY2RReXR5NkUyZDNXWkx6VGthcUhxMmJO?=
 =?utf-8?B?Nm9ET1Jsb3Y4NHVPdEh6QjgzNy8rVkNacUsyeC9YdmxXU3RRekRzN2hRK2RB?=
 =?utf-8?B?MG9YajlYcTErb2hTa2pvQnhmcUhSNmtJMFRVNTVqcHBrUk15OVhnc0dWVjJo?=
 =?utf-8?B?K25ncWUxdTJZdjhpZnRoZlRBbFM5YytMWjY4WUVOYU83SXJCaFFnR2poSWdB?=
 =?utf-8?B?cXlQbkRCSTJ0MC9MTkx4TFlpTi9LWk1QQnhvalJQa3ExQU1qZUFLZ3poV1Vm?=
 =?utf-8?B?NFJtN0dXeDkzVXB6TERkTUtVS2JRTlFaZ2dpdUJHLzdFV2ptcEtkKzdXY0FF?=
 =?utf-8?B?STF0VUpNaE5SSCt3S2F0S2NmVXJrd3ZRNDVlTVcraURNSnd3Sm03SEJQU0xv?=
 =?utf-8?B?QVlEa1FtOFhHTjJPYXZQUlR5TThTUjZlTDI4RDRENDVWdTUzSFlVbFYrT3Qv?=
 =?utf-8?B?YVI5Zm9CYmlJLzlLTFhKRm5TWG9kdGR3RkZpeTRSbE4rTzNhZUZXVVNBQ3Vv?=
 =?utf-8?B?elVlKzlJRkFSWlpKT1BJOXIwSC93YU8rRjg2YklNQXMwRFBQaFFBUDltb3pq?=
 =?utf-8?B?UFlyNXZhcm5wVWxwQ0RTeXlyZzFYS2JqMEwxZ0Zaa2lpZkh3V1c3ZHFzenV2?=
 =?utf-8?B?VmpFZGl0WEdlMFNneDMrSTFLMXJFVDBPYldocWtEMFFudlNFZklreHYvdzJj?=
 =?utf-8?B?c1l2RG52cTJvMkpSTjRaYmxhemU5OVpWVzZ5ZmJWUGhhUjVhd2R2aGFXZDJh?=
 =?utf-8?B?d0VNQ29QU2JQQ3FwRHNZc0J3dnFDNFVaZU5hcDVkLzJzTXZPT0RpcytFcDBQ?=
 =?utf-8?B?QUFXelVpTnUzL3ZsTGFYN2djcTRiRHBiOEt0Si81eXE5UVdMZS93ZGp6VGxR?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57904cd6-78ad-408f-c91b-08dd62433ebe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:25:11.3077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4zMJmd0pjR6A4xEFQyT6/J1HhhW3MpQXEc0xi1/L8mdIweegejBi2jdwf0cIPIpLBNMAYBL6n81EYawnbaEySarjlU1K2tLCflsfpQJFR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com

Hi James,

On 3/12/25 11:04 AM, James Morse wrote:
> On 07/03/2025 05:03, Reinette Chatre wrote:
>> On 2/28/25 11:59 AM, James Morse wrote:

...

>> With all of the above I do not think this will work on an SNC enabled
>> system ... to confirm this I tried it out and it is not possible to mount
>> resctrl on an SNC enabled system and the WARN_ON_ONCE() this patch adds to
>> mon_add_all_files() is hit.
> 
> I hadn't realised the mon_sub directories for SNC weren't all directly under mon_data.
> Searching from mon_data will need the parent name too. What I've come up with is:
> -------%<-------
> 	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
> 	if (!snc_mode) {
> 		sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
> 		kn_target_dir = kernfs_find_and_get(kn_mondata, name);
> 	} else {
> 		sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
> 		kn_target_dir = kernfs_find_and_get(kn_mondata, name);
> 
> 		if (snc_mode && !do_sum) {

snc_mode should always be true here?

> 			sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
> 			kernfs_put(kn_target_dir);

I think this needs some extra guardrails. If kn_target_dir is NULL here
it looks like that the kernfs_put() above will be fine, but from what I can tell
the kernfs_find_and_get() below will not be.

> 			kn_target_dir = kernfs_find_and_get(kn_target_dir, name);
> 		}
> 	}
> 	kernfs_put(kn_target_dir);
> 	if (!kn_target_dir)
> 		return NULL;
> -------%<-------
> 

This looks good to me. In original patch a NULL kn within mon_get_default_kn_priv()
was used as prompt to create the private data. It is thus not obvious to me from this
snippet what is being returned "to", but I do not think that was your point of sharing
this snippet. 

Reinette


