Return-Path: <linux-kernel+bounces-210775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A8904886
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F774B21238
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1602E5244;
	Wed, 12 Jun 2024 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb3r7BQB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78F4A20
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156906; cv=fail; b=gQzwV8HMO6AxkNdCWJil18FrNa3v4sCS/1sWAAzLSJRLM3Ug7wglt1hrRg52P9BbiiAKvhQWlwL6Vb+bnjWYuKYOnX5ouJ7OtL/xq8nwGAGZ91Wo2kZdu/DQog5FmnPlUKJHyxfppdwQj2vwd79+goQRZkEAuPSah80E/hGtE1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156906; c=relaxed/simple;
	bh=24XCwqP4S819WmK1kX87akTeNMID4k7TMG+lQ2WBiI0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=euo9MhjDUeMwrCmtUONjEUjXVNG4h/TtkLple1ZnMy6P5ly4DYUEpvQUCMmPxN7ZFT65dvk3PLZmJbUj6s92OfCAr1G2d33sjGgYMJ2uRZxdqwvSS6lqnjTGsYFWtTpP2+2ekw3HmvprgRiuQCfsqE1HjWZwR88TeTgQE8aQOJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb3r7BQB; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718156904; x=1749692904;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=24XCwqP4S819WmK1kX87akTeNMID4k7TMG+lQ2WBiI0=;
  b=fb3r7BQBIp+YYvyBlEQjiz2rFcaUMXuATRTOrhf5x5I5F6r07BEg4VWO
   qh588VHhB+3RvoIWblyxpuA7S7SQqE5rP/DnMcIvdc3KIIHTvjGqtPKjc
   Ui9geHvonEYNT0inTEgd0Y2ew48FjO/WlvTKAQWpv9niKt/qgxi6cLtNZ
   ioSqhyeMjUA/oSKX5h908/13NZnDA1svGXyr1RFRTZrYaWcdT1CmQSJcN
   3VyCfZ2MD8XVBhpnJaMPChRfJkAStZq55d8aXG/NN3PQIxV5GFsm6YIQ7
   Un0o28HMUNvj/pwVtQ9MBFNy6BovOoDvICcgpsbHBuiePK+kSnhOupR/y
   w==;
X-CSE-ConnectionGUID: pezS6XrHTiOPgkT5ynO/tA==
X-CSE-MsgGUID: GljKeNJeTzuQrWcUpFVu6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40305232"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="40305232"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 18:48:23 -0700
X-CSE-ConnectionGUID: zYxLC7QzQzyqgZgoqudSnA==
X-CSE-MsgGUID: NVU2ShGaTYStjdyg4cfFig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="44028626"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 18:48:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 18:48:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 18:48:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 18:48:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 18:48:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvAD6W0oK6QyJ+k6XEjYRkBXC7tblj6zCcGHuzxkSbL9B0bwFE0R3MqECFGI2X0HPJtqvnqrIoCnryUizcaZwC0UMfi36j1hjZa4oTLw37SMTbgTPkrXiYmaiLMGDIOtnp+b2ZKNSfT4H5L3dIODvQ4IpWaRFub4V42k4sVryYOCg8kiXkn3lz1gFk0KFA4MtAn8RrEYX4D6Kh+QIgAmiUZ8LHP/SML9b5bUFTc0vlkyvyjEfKAm9vbAOQh1irAZemygcyjzTWiuW/DIXnjH8qWacRYXB+ObRGigHbWsP7W/e6qK5hGqBexi91u4GmG4AJ1tqAlg35I0pTHjslQ96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOJn0oT3Vdf9ybSJ6y+qKKI863obYmDsmT+HVrawA3w=;
 b=laPSGMNPgGwkqqJGY1cXegwimSMKsYSzuUWlQc5BBZmcgG43DzcIEgWi/u2tcLgPY5riO9qfzZoWUafZPQewhqsLy3WkrTEUZveaClA8Iu4h+r8lO0l6FCg8aT5AfAvYhVlo1KGpmAKrZvUE1f2NOhbhOGdCDN+njGErYA+PrTyc0dQQzGI/vKRv2DvE/3wEUAEqtUawDsnoxSmQxKViIprrZAmB1tf+LpB+3AQ7WruZHly7xMXZl1U5mxfTupOFzd3HugcywNuMueQE4Mg7iDZeRbkvO+AR14g07rfq3WhdZBWllOKVbk8JtkVEifvxl3LkdfwRPFvguvnyROrfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Wed, 12 Jun 2024 01:48:15 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 01:48:15 +0000
Date: Wed, 12 Jun 2024 09:47:15 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>,
	Xiangfei Ma <xiangfeix.ma@intel.com>
Subject: Re: [PATCH 0/2] nVMX: Ensure host's PAT stays sane
Message-ID: <Zmj+I2jtZLkFGgpd@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240605224527.2907272-1-seanjc@google.com>
 <171803644297.3355626.18364027225741935056.b4-ty@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <171803644297.3355626.18364027225741935056.b4-ty@google.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DM4PR11MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6074c88a-7fc4-4de5-0c06-08dc8a81b99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fNDnQTVkp5q5T3XreKpzorfGhHEvnp1QAWEK5upUgXeDR7eZ/hYAzga8rlir?=
 =?us-ascii?Q?2zmyzoK6rdDTKmhYPxcmFaBjZ6X/4uD6qtSTO6flthzOT7RZ9NR0LLgdwwVg?=
 =?us-ascii?Q?cORP0UoIoOOenNjNH9oHk5v3SKiU/45w3eJuP7nH8fNxrZJjLCx0peClIKSm?=
 =?us-ascii?Q?8UOK1Rar9lIvISY301EKXqh6x0x64/77qS59cbV4DVz6H6u10YCtSz/FpI3W?=
 =?us-ascii?Q?EBPy+Ka2yt19nMTZCZodVV1O5aSVBhUVwS7KBtD18Up58tHC+3QddC58Y/R1?=
 =?us-ascii?Q?JHBoXMuRzu4Ct61D7UV/Bz8mJ8RvslkYmjSLnKKi8tCO5U44WkQzUCcX7AON?=
 =?us-ascii?Q?aOetR0UEVwEfuoGxGMg45cumDYegJPWYtCFicnKnul7tjmksKT31HzeVx+y6?=
 =?us-ascii?Q?t3FfPP0fwDNsvojwHbAiseOGHzWZrrfL9L8zHSNbqCvcxQJb1km5yUBJEGvQ?=
 =?us-ascii?Q?I3A4eZ4HgixvPDC10xwLz5YJKvmzktmz8ZLSIZE3KCkxuGklhYsjPkTkigV6?=
 =?us-ascii?Q?hLEJfMq9B0xrjV5jFX20U2OkE/zdscSqngYjghFoIApig/df9H2sW93LqFsB?=
 =?us-ascii?Q?iTigzZVcZCTu8Lu70KWvoJcQMbeuceaTpzMaE33VJ5/SmocTWf8mSVXQZouI?=
 =?us-ascii?Q?ORA4kkqrRFqlbvaYXVcNe6VomMJyKlOagAmdFVgF/VkVGL17xPjmCnjhhFJU?=
 =?us-ascii?Q?XrOvJHKZwtnn0aE/RZIjCT8pNfF/GTuSKN1d+WMs79DlKDr2MaEh6SN+0c4d?=
 =?us-ascii?Q?xUeHX5oReioqd6jc8zyF/vTFhKiNwQOO9zWUDtz7x919PLesCpQSy63g8X8g?=
 =?us-ascii?Q?9Vkg1Bk7LVzUWCimre23XaoU1KVfC8XzUj1wz/XtTBVHdtoMrMSFATNhIxwi?=
 =?us-ascii?Q?HwvQeyVi4m9Bt7M31596MXybvItrX4mOqJcM666uJ29GLpteSThnN0r1f884?=
 =?us-ascii?Q?eQh/v4umfkMGFPBsE25qK1c9MeON/AD5k3yQrxj06BrhBMVsD/cJ9Zv2CAe0?=
 =?us-ascii?Q?HNKxQgmkPRczRHRiTEiRs/bsxVRL2NsdS2g4RULhR/rGuhr8pKYAj4I4Cfcl?=
 =?us-ascii?Q?lkYni1V9DNlCGct6fdGJ7g/G/PWbX44gKyeB+KbtsBoa12EwD3kejbVV/5Of?=
 =?us-ascii?Q?/+Z0HTmuzYd4KWL6HZN6yGwC5gK4Kdpk3bwdoOSfVj/sMyfnW6ej3iapBI++?=
 =?us-ascii?Q?dDffJeUY9cgW9/LXzavWwybbSQLXgUj7WAHbufgsgDKHLYF+jjtAT3k7SA/p?=
 =?us-ascii?Q?PZzK6iQ+FyghORe0sg9NVuLOO6X2STjQ4B79MqIKORerlsY0N03KC2LIeBJ3?=
 =?us-ascii?Q?pH82nhq6QB0jB13ffv2mdHUE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nLlX9DQPK46XkwvHcbuLRREbW35BH+Fr1L7jKytO6ThX/iG0323CGoUZ7XKf?=
 =?us-ascii?Q?2LlST6j2n/E0qZIlR/lzX9A7sY6W27jTvqOMfaGzLXDYxSf5ZijZJEEk5czM?=
 =?us-ascii?Q?f3ppsFCQtBymq+2QPMWQzZs0In7BSC7+KBC2C+tKaDG0JuaN0VP82WbskEmv?=
 =?us-ascii?Q?S4gn86taJf4Gw5tNE8rIBs5Aar2QoufQW8FMLmS6fTWvzNtXUsEjlM2Th9Hc?=
 =?us-ascii?Q?ox7iomsn5Q0Uy0geUYgtnwOf/3H8cYjiexu1z5GirlnlOPUSxRt4W1+nXvtI?=
 =?us-ascii?Q?HvAzEgfFCFYmH27XztiMzWRtaT04AME+VzqSW52IJq275Y/jUjnx3IhdIW7m?=
 =?us-ascii?Q?U+DSEbKvu+e+AD6p3zcMzrSisa7JoKnKfR7d61b7Se5PjBqzGGjivgTPj+0J?=
 =?us-ascii?Q?9SgOaBnMoDVQ8JkRC2wQTnTqPLDL7DLZNnE3H1r7mC3PzrW2/JXwUt5YjVf4?=
 =?us-ascii?Q?dppkpCqgPlCxESCuAtC+IfM2B9gCq1a+cl1JYQdmhOOue+T/xKOw6HPA27wS?=
 =?us-ascii?Q?GyQ9LOVXThvJBe74HxDQkPjKlJEj7IIfPQ1P6I/j+NzUrPSbti2kH+3yA2Iz?=
 =?us-ascii?Q?xJjq4PuOZCbfFHsQO0sqoFC20lA+Xur6FchO92mjRTTzws6+lle9Kb4IjKFX?=
 =?us-ascii?Q?Q0Baquwv4vUiE0GbNk1SyztpNRvV9ra7/317PntYKPuiNnTfoqT04XViNmOc?=
 =?us-ascii?Q?U/N6w0pUqA2N2ulFiFnbVNIlyfyMxaeTGiu3rfkFcXX29XKaSJFMMcRXeVpP?=
 =?us-ascii?Q?clq/TY2W1AaN5rb9JW2IBfbhbA82/+cf/argymOb0VQmKKB3ZNgH0IZxE0/N?=
 =?us-ascii?Q?MwfLrxXSrPB4ujAetT7m55WD6zXUHGTSGdIhMR+JUeHOsUbzKabGf5WlvL1a?=
 =?us-ascii?Q?W4ubKWBEj4ZZQ8r4+lMFkO+8HTIBBBzeoOXGHNXIA5KtsAmuw9OXVcsepC6d?=
 =?us-ascii?Q?HBUISciO65l62Oa3rhjWnyAgRPEUDHjbv5IZtXhiBQasljwyJthPYSpxUmGn?=
 =?us-ascii?Q?HsGbpIZm0WqDWJ1vV8DhjD0q+97QSFA/YTMPqGtTVnaZY8Va2U2l3R5llYK5?=
 =?us-ascii?Q?LVI8NZ5iZjwjYBJRcXwGaK98y8IVb8e+7y2bTjHa5vpLrrA6/TcZyn8p/den?=
 =?us-ascii?Q?efMLJHOtlTTZ4lnvJ/b1ln1lfP5h+pZBQMQbHyeLYvuEZpwcIVS4ztEhr9o4?=
 =?us-ascii?Q?cdOjx8BqQF0mQYomQPjQ0TvauCFujfb0zC2cKnbot9Gg7LF0pIQLMfalkSUR?=
 =?us-ascii?Q?mPkgk5s3kBdRsCvEMtmuokwCpvCKgdV4qBIjNiNKUBIwj8lL18DvaYvQyrjU?=
 =?us-ascii?Q?vNbvzZ7FD2xgSgqKCSb7ixRNJTh81QAU9TuhlI296MoTHogvax3NxL8gHByh?=
 =?us-ascii?Q?RvV8PsRKesR1XoWiEC1ZULf0UM1r/iT8Ndet3Q9OIPMK5uYjc8R6dTIkuXTF?=
 =?us-ascii?Q?z6rUa2Ju1y9fF8/ooYDNdOqvDmWJg8YudwQTxwovfjOX+p44MqWO+K5SK50K?=
 =?us-ascii?Q?I8YqtIXkIOP+kGc0MzcjKNp5MsrWO/TBvUgCBiMs1N9v2bHIGFffOiPYTLXy?=
 =?us-ascii?Q?QeBc25AQ+CIsYaDeDhFHeRqpmkR1szV0z7qifU1q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6074c88a-7fc4-4de5-0c06-08dc8a81b99d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 01:48:15.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qPwJzEN8ms/n273VYENUIwHemrk1pR4MA10L5WbkhVAXpJ1nfY2oGVFMMgoUOVE3HBPw+fP9U8dp3s8XO231A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
X-OriginatorOrg: intel.com

On Tue, Jun 11, 2024 at 06:18:40PM -0700, Sean Christopherson wrote:
> On Wed, 05 Jun 2024 15:45:25 -0700, Sean Christopherson wrote:
> > Fix a bug(s) where test_load_host_pat clobbers PAT and causes all
> > subsequent tests to effectively run with all memory mapped as UC.  Xiangfei
> > first noticed that this caused rdtsc_vmexit_diff_test to fail, but it can
> > also lead to timeouts if more tests are added, i.e. if more stuff runs after
> > test_load_host_pat.
> > 
> > Sean Christopherson (2):
> >   nVMX: Ensure host's PAT is loaded at the end of all VMX tests
> >   nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR
> > 
> > [...]
> 
> Applied to kvm-x86 next, thanks!
> 
> [1/2] nVMX: Ensure host's PAT is loaded at the end of all VMX tests
>       https://github.com/kvm-x86/kvm-unit-tests/commit/8cbb8d3cbca9
This is also good, though I thought you would fix the theoretical one as
https://lore.kernel.org/all/ZmesywdpFG3qDIkZ@google.com/ :)

> [2/2] nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR
>       https://github.com/kvm-x86/kvm-unit-tests/commit/d31433807f2b
> 
> --
> https://github.com/kvm-x86/kvm-unit-tests/tree/next

