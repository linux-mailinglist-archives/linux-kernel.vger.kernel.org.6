Return-Path: <linux-kernel+bounces-434501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A5B9E678D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55E0188596B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975D01DB956;
	Fri,  6 Dec 2024 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNdLdwq/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C31DD894
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468417; cv=fail; b=Qi0LKowMuTyHX4lIPzn3QKxE+rf21MIdmP6ZOLwI9Wg+OTnhKLKe8uKmFI7l1tt+mN3IE4kQrvrKk91yKEL2qVL1UMMw5uPQXSYKh635rcJZu+Ae01t2Nm4ZTxkacqjZhKC6xiA7pjK5A7BCx0t7NJlSzsrFiOD0uqW0YKAiiw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468417; c=relaxed/simple;
	bh=+JpM5Qe6EZFSrzTLz4y0Mn9UatCFi/3kyKFM2NGnMl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c8OyZ4xERIInMPZ/3FZ1syTvEG2PgWlTxmsg3Owt5+2CmzqggMQb77b8Fo2AQSa8RU4vcKzG0Y9e85NrZ1092zUpTu4nbrbERZzO5tzGEDHp81APsXlvtEnysfrsWhquhtE7DOfy/bpj35o9BohZZqGunLXCkB/on2QS0ALHZ3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNdLdwq/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733468414; x=1765004414;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+JpM5Qe6EZFSrzTLz4y0Mn9UatCFi/3kyKFM2NGnMl8=;
  b=aNdLdwq/ijfnX1XdBoQVnSb5vKWSiP29HaTmZyU+VnYzf1yPIJYHnLHC
   5JprR+B8GzZPqY19Y7pMFEOzpECdeODXOsRF6SpIqpN0rL+M8KKTi/eIK
   pDQ7m3d/3iDz+IOVQnth6CQjvjpmNXddNG9UzXgG30t5xlm5bCSuNXKRU
   2VY2biK1JPm/DXYYIV/NwvZCTBj1mAPKjvWT0CQbFwCgKnngL6p7WIWIz
   +3b8SDsEBBQCFxn1wgIoRcZeq5B2PFnHW9uGPfTZpYD6r7xDxpjZqjujE
   H6nU36uo7teI+R8rD2PuWtrfcb8FeXIwk3cySSqtHYtXzGiJHpv48/FV8
   w==;
X-CSE-ConnectionGUID: P9zZFtrhQlqghxS3qbIUww==
X-CSE-MsgGUID: hIxF6LFHTMCDopXlT8foew==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44281970"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="44281970"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 23:00:14 -0800
X-CSE-ConnectionGUID: 2EoPZvV5Sv+3RrKqTMkz4w==
X-CSE-MsgGUID: AxZDBxISTuCxo72n2CrRYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="94186462"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 23:00:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 23:00:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 23:00:12 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 23:00:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+WPqHhvO9HKonbd72dYk/PMaK3/FFihbRJDbPpk23A62DmpjY447yBGCa3vEZWcBDijDaeRXPu2wfpGfPrs629arJL/tWMPL7jQwz81H+zUQQQdCnGhRakpFS8NIlRXGYOjD/G/sKeKR9W7kwCCOugip6wWLirX3fwKQIaEY3uwtK265H7RYVLgeujO20oo1GJslT4uo3SuUniVo9YWRQQpRMIXgkPs7xga+klpWMpzV3BREjruuIFM+HFSlXI1BrEOdGchubSfXOX6r7Tki4XcY73BAHiPzlIr7pR1oAKgEdYxg1xUHRyauKdGaTB0QfeoC6jyKaWlpQaP7ZlZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWW2zQO/x2WYEP+S3tYfojsZWlpAJSkZOrCx0FFcADs=;
 b=LRTFXBK3l+yS5jGHFwJ/1Nxn4ciVytZiu0dXFvnOsDmGVYNaD75+L6S0jWFHCIQcAo4Aw3X0o+VpJUEYbM/3V8CCeooA8HWaAFQY5gZiAgg7vl3lwEItvALCxZvoxU5olSkV5OWhICckDV0ogfwRRag+MDc9Rw96omFHB83BLfzkq/6YOC2CA0BlxsLP0mNABnSHYNMIZL4CMYcg6SFph2FFZYxhIDwDBeIn87Tm+v8JgxzxTMPnpUFKeECXGV9AFvvoPlWgsbL9h08WcDLK+eZK9ZbaZVu1wOB5roggLQo31FcSG9sp44vFgeodHBkXBeWabbIg9udmWqxlzjdVzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 07:00:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 07:00:04 +0000
Date: Fri, 6 Dec 2024 14:59:55 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Rik van Riel <riel@surriel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
	<dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] x86,mm: also remove local CPU from mm_cpumask if stale
Message-ID: <Z1Kg6yIQlJYAB6sq@xsang-OptiPlex-9020>
References: <202412051551.690e9656-lkp@intel.com>
 <20241205104630.755706ca@fangorn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241205104630.755706ca@fangorn>
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0655c2-d26f-42c6-9d8c-08dd15c39c98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gXBHP3p9ETExVVDVIeUWMeek2luFcscKIqstZEBjpHg5rIxYm01pMypCeQmF?=
 =?us-ascii?Q?Zs6lclNCA37lXC9CnDQ/Uw2qc7MwfkmDBng08Uh8QeuSwgqajN77LNEhdjF/?=
 =?us-ascii?Q?z3UHKAXty6ffsRE06Ki9AiQhXMh0jl5ZmTnQdhuFNK6PdH57Qd/ZNYoBYGas?=
 =?us-ascii?Q?b7B9iWwvReD/fMp+AjTaeElTwQsSVnqLUmZaw8MdhqrCEXgqTWg+4VGZrKal?=
 =?us-ascii?Q?g4uNaigsDBE1RcDeeWUK1Vaz+8o1ouMeC+mr4JA4BZ5NClui2TNrqj3fNZFZ?=
 =?us-ascii?Q?SlSm188HDTw/ee2r6TVtRf5EEoHeuz+UiytG4+J+6hmaFcgZ+EXM1wlRuJdf?=
 =?us-ascii?Q?1O70/lcpAXpzXk2JaMqX5jDG8CYJhPmnb5P4sxNEqLnnrnlcCbA/9pZEtla5?=
 =?us-ascii?Q?tM2r/Vz3xdpx5ca4ilj0zFzSfxYl3+8DXqu63zXIzhAUFGZQJ7Da6zHsa+RO?=
 =?us-ascii?Q?/Aa/eUPge50w+AB9sLqWQtTKPUhlefnKD6m2L2r6iUDl+OJD4ZG+ZcMD1M66?=
 =?us-ascii?Q?L2IkaZ5XPXQDsmgoGMUzc8PglbiZyl6NWd+rEsdci6ebhJgTgxc0qOzHMmkc?=
 =?us-ascii?Q?fqbl4jLsgGvWG7IxBinE21gKU2Tz2VPWGKbncAqUT1hSR37PRBGPIIqQBTNr?=
 =?us-ascii?Q?EblCufCmVzmAlRuWNjXt9zZ+SKT/DsPeXtA7CW2pw6rdEqwP+msXREP15pGn?=
 =?us-ascii?Q?kzXkRYYPVINmJWZtL8qs8P1pPWDn44kN4jvtb9g7730C2C7iT+0yMQ1mpWIW?=
 =?us-ascii?Q?RK+mi4yOrHv4rywpi6fh9sZbzwFXd93rH+0LExsvAFbXsRkZoO2DrNzE/Wuj?=
 =?us-ascii?Q?PrYU1lfoT2DncKHc+0WR39/KdN+/OVoj42mH475Af3mzY/06J+jDIpcmE+pF?=
 =?us-ascii?Q?UKA9MuQQ7J4OVoNuWdKzg3h3Pidl1hlMBdMyg3kk/6AlMjDJ4vksqOcGHNfl?=
 =?us-ascii?Q?521TUM819mDqsWy9XuD49Qfx268EWPH/eXLXxQt5B2Opw1DnZ0SfSU+nxNp/?=
 =?us-ascii?Q?1coqkHqJUlr+T2nnEwqzJFS0oi92abcc0f7ewpg+xU4qtgrYdY3J9baSYOAN?=
 =?us-ascii?Q?zqxhqmQlrjF3Dg2/R6dfZO0eSeQqUq6T8GnxYqUXNEBS/oqQvhyC05UHgRkE?=
 =?us-ascii?Q?7X1UgYO44X+SEJAmNluqPegmHmmxtaSpYsXUYl3t2goRsNA44QhMS2tdYMXU?=
 =?us-ascii?Q?yQy9yxxLHpSDCUJdRRS4ZFEidUdx8y3cluXWy5QOrS8dF4PyQppb77SA+ror?=
 =?us-ascii?Q?SV6cXYkvSQTcBE40oSZW8ZRH9iaxYs0ejaC9sGMFe2MS0v2Rf+kAd82pjZbh?=
 =?us-ascii?Q?bPfRsaHp3SlGes7Wl1XbVVrYrYmT0U2ACJmfiGezXOUauPFtBkfGSDq3lIWi?=
 =?us-ascii?Q?LF/Up1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5LcthKZVhSjmxyU4/JrYZOSlYQM/BbtE67hmPH4C5n2W5blo+QM2Q4+AUttY?=
 =?us-ascii?Q?Ytv02Bx5mJFbZMYHsLapQMFLq6iwFKm8KFmHrXb116TR8m1i6tfoOuGxoXDi?=
 =?us-ascii?Q?zOKfqyMOL/6fguTZQDAbVeAT1uiu3M1wvnwY9y17pCOA7FZ1P1nwumZKjqxV?=
 =?us-ascii?Q?x4owm7+s5jfLerGWzTnuY7LdlNAItx5REluA1cy0nYxL1pgX+VqjKw8ZJ+yz?=
 =?us-ascii?Q?0z/8IWC4bvuxX02h2QZrllOOmWaamfwuBnw87reOjOCE18kg/EoOUTlyuNlO?=
 =?us-ascii?Q?S0bx7qNysO0hsRqHsUbZtGVmOTBx/EOtaRpmuYLLi4G4uD4iQJrZ73H1RQkE?=
 =?us-ascii?Q?HqsMraEog0bVJmdq2ttsZfwpr3Feo0VHBT+/fdQgf3/63SGFDGMR2MEKkJZ9?=
 =?us-ascii?Q?cFs+1NzvbkILQhQ8oPqzjHcPyoY41If4HpTk3q7xuvk9Z55qDgisMofeIBlT?=
 =?us-ascii?Q?PR9aHslFIcMVF15KLxxbzEwvUDO3jxiXoes8y4XhRnZgtkqkubT5wzwU3KJG?=
 =?us-ascii?Q?TO5sFAgAZpqSPCuyTjVG6VqnYQM1uIVe3Qt46PC0Z1jiuAycq7ld2Aw2JQNu?=
 =?us-ascii?Q?M1f3TZa103/AsSWQZi0zxp6nJ35okkxttWqxmzmyWOa/szv/BG+TuPnKtwTy?=
 =?us-ascii?Q?Vw8e8iDVm0SIHQSOCFoqby/U6S6MJmya5sESnC3fBB3E7u/BhBAhlA2SGIt5?=
 =?us-ascii?Q?8iVe+gJwpoe+b84p3nsceHz6SqYlSuTCFOI1lIAnfT+cn/Jzb7J8gWBRHUkq?=
 =?us-ascii?Q?soIbaYsGFF9nAeJ1B3fQSt7v0mguQQ9HLR68k0HkglJtYEFAjib7BGfRODKi?=
 =?us-ascii?Q?ZXCBngxSlQPOio9MUK+OZHYzy1ahP+M2GNgLfcK6YicMN071zWfVVx3qeoRC?=
 =?us-ascii?Q?Yw/MuX5B1i/kkVB2h6DHDA8rGlXPs3VtE9f1bFYos18XeV2yZGvJtv7pFfRw?=
 =?us-ascii?Q?1+9eTqaO3kTGXibX3wXK8G3Avtf8Yl3jprRx1AxLFfbrxOnEHZahvS7QKP8K?=
 =?us-ascii?Q?cjWEnGtDG9Fi6gLuG9fjYsrukOz1rC9x9m+Caim7Z53eifpUuxvJFmHLJSSl?=
 =?us-ascii?Q?crEwcxQLYLhfEuP4PI0PJynLbckZo2zbz51IgPZCyqzgeMvLsHXndrHUSs9b?=
 =?us-ascii?Q?r86MXJxrrsTMGwiiOlZ3I8Us88GoZBDkrFCm89hKrZCzQiBqiCRETD9mUjHQ?=
 =?us-ascii?Q?stdzaa2M79BTtajygxZYymflTSrh5j+1mL3HGwbkNRlFuc/I7BH0Yq8FVeN6?=
 =?us-ascii?Q?1Nn4/JV9Za6m/0RR3z+pYj7o6zefQvdMfBx/50t1PCychz6ZVuIwtnERf+AC?=
 =?us-ascii?Q?oDN1H2HHIfgloP69daacVzilRq2IGE8GWgAfsjn/Z5bk1eGhuXxWDZyq24op?=
 =?us-ascii?Q?kOq5Ac522HxYckF9mYkqTefv48AgfPYtSyipW8rf+ymJLkEsIGWIYGEW+/8y?=
 =?us-ascii?Q?dWsWzKPdw4HYHtQrpuatMU57PY+bcXXZAAovwmT5uyxQbzX6a70jzn6oUCxh?=
 =?us-ascii?Q?9j+gnRjxFSMRVlIUMultZHMJ+5BeqzOfyacsvzEPGepcuFYsQ0EkgJ+H/zaN?=
 =?us-ascii?Q?D4ImI84ByaxZ2kZyC/2phQqrdH/6/T4qCF866Ib7gExhM0TwxCoNPhPCv6wq?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0655c2-d26f-42c6-9d8c-08dd15c39c98
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 07:00:04.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rABe4w8fWn0WdPOnHiYBdBrS1pl/s/1Qpbo/xKJumykBGwL1YgkpFgdHiPHgHc5TLzCoxsCc786oUJoD8I2h3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com

hi, Rik van Riel,

On Thu, Dec 05, 2024 at 10:46:30AM -0500, Rik van Riel wrote:
> On Thu, 5 Dec 2024 16:43:24 +0800
> kernel test robot <oliver.sang@intel.com> wrote:
> 
> > besides the performance report
> > "[tip:x86/mm] [x86/mm/tlb]  209954cbc7:  will-it-scale.per_thread_ops 13.2% regression"
> > in
> > https://lore.kernel.org/all/202411282207.6bd28eae-lkp@intel.com/
> >
> Anxiously awaiting the bot to get around to v3 or v4 of that patch,
> on the extra-large 2 socket system ;)
>  
> > we now also observed a WARNING from another test. the issue doesn't always
> > happen, so we run it more to make sure the parent keep clean.
> 
> Thank you for spotting this corner case, too!
> 
> The warning appears to be fairly harmless, and luckily also easy
> to fix.

below patch fixes the WARNING in our tests.

Tested-by: kernel test robot <oliver.sang@intel.com>

our bot applied the patch as below:

fbf932edb3630 x86,mm: also remove local CPU from mm_cpumask if stale   <-----
2815a56e4b725 (tip/x86/mm) x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU
209954cbc7d0c x86/mm/tlb: Update mm_cpumask lazily
7e33001b8b9a7 x86/mm/tlb: Put cpumask_test_cpu() check in switch_mm_irqs_off() under CONFIG_DEBUG_VM

now issue is clean on fbf932edb3630

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_ssd/nr_task/priority/rootfs/runtime/tbox_group/test/testcase/thp_defrag/thp_enabled:
  gcc-12/performance/x86_64-rhel-9.4/1/32/1/debian-12-x86_64-20240206.cgz/300/lkp-icl-2sp4/swap-w-seq/vm-scalability/always/always

7e33001b8b9a7806 209954cbc7d0ce1a190fc725d20 fbf932edb3630024b60b22df596
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :50          58%          29:50           0%            :50    dmesg.RIP:flush_tlb_func
           :50          58%          29:50           0%            :50    dmesg.WARNING:at_arch/x86/mm/tlb.c:#flush_tlb_func


> 
> ---8<---
> 
> From 5b5d1d548fbe07b415ba9e80a2f60deed5aead62 Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@surriel.com>
> Date: Thu, 5 Dec 2024 10:20:28 -0500
> Subject: [PATCH 2/2] x86,mm: also remove local CPU from mm_cpumask if stale
> 
> The code in flush_tlb_func that removes a remote CPU from the
> cpumask if it is no longer running the target mm is also needed
> on the originating CPU of a TLB flush, now that CPUs are no
> longer cleared from the mm_cpumask at context switch time.
> 
> Flushing the TLB when we are not running the target mm is
> harmless, because the CPU's tlb_gen only gets updated to
> match the mm_tlb_gen, but it does hit this warning:
> 
>         WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);
> 
> [ 210.343902][ T4668] WARNING: CPU: 38 PID: 4668 at arch/x86/mm/tlb.c:815 flush_tlb_func (arch/x86/mm/tlb.c:815)
> 
> Removing both local and remote CPUs from the mm_cpumask
> when doing a flush for a not currently loaded mm avoids
> that warning.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412051551.690e9656-lkp@intel.com
> ---
>  arch/x86/mm/tlb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 0507a6773a37..458a5d5be594 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -756,13 +756,13 @@ static void flush_tlb_func(void *info)
>  	if (!local) {
>  		inc_irq_stat(irq_tlb_count);
>  		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
> +	}
>  
> -		/* Can only happen on remote CPUs */
> -		if (f->mm && f->mm != loaded_mm) {
> -			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
> -			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
> -			return;
> -		}
> +	/* The CPU was left in the mm_cpumask of the target mm. Clear it. */
> +	if (f->mm && f->mm != loaded_mm) {
> +		cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
> +		trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
> +		return;
>  	}
>  
>  	if (unlikely(loaded_mm == &init_mm))
> -- 
> 2.47.0
> 
> 

