Return-Path: <linux-kernel+bounces-402249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A89C256E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414701F2405F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362EE1AA1DC;
	Fri,  8 Nov 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHY55HjR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17B1AA1D9;
	Fri,  8 Nov 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093129; cv=fail; b=NTtYK33Q4kNVTEKrCNO1srnIuqmWv4T25HrmB+8JWTi+uaIGtmPp5qNzumXsBlAXiP4o9quSzBkovptUIiXoHZADVN7d4pBwaMJdtwV5vN6fH77CpH6ygDaVlZJPkCxTkON9CrCmU6ddzGuOgBMcmgu7yDCWR47JtKXXaBnISnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093129; c=relaxed/simple;
	bh=P9qp+WX7LyfMzExF5TfuSFsKXIGgvQTLEmiPMm1w96I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WI5RzCMgLGiSNgzZ10npBGfGkC2MZnnJW2jZwSGkku0LhNBP36raBuTAs9SqjWMskAM3/ucdsPzhoozd/sGitCTwKFkSH98pPVHORVvuHli+uhK4kg+rJ49U9SpFpnnIH90abIn7Ys83yrzRYuPVsWB1bLOZInJcj1k0OpfhwvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHY55HjR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731093128; x=1762629128;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=P9qp+WX7LyfMzExF5TfuSFsKXIGgvQTLEmiPMm1w96I=;
  b=VHY55HjRkz0I+mfL7pVsiaBOlCc0XFYt1rTjb9DVGV4aWfLIqvSzlPh1
   qgBrmFEEsPKnXJnvaROaQfTYM+tarE2Frgjz3agrg5aqU6HVoLRA8SPvv
   3ac45Nyd/HKEgACjMVJezTp4vORaSQfh6XblE4AqRcInDHaFK9dibE/st
   HWu9NEVa0/HT0Ts4JZGpRpzFG2kgrpBLKQl+m6aKafsiUzgtfUsA6CQdt
   PEeRoaBMS5qF3tFsK11Fjz5/mlIdERec9+dHPe2qoE/nK0zuIGh1uxMt5
   dmxcCZiQGukgW90YgvGVSBD4ezB6TyUf78BsF2h/9EojfD/gepsGGSXBo
   Q==;
X-CSE-ConnectionGUID: omklnxOxTU6f1lVGGGEjyg==
X-CSE-MsgGUID: zLCjdgv9Tvy4axuYPpYcHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48443003"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48443003"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 11:12:07 -0800
X-CSE-ConnectionGUID: tvPu+qQGSS6h6zI5AujCOA==
X-CSE-MsgGUID: qQXZ4fA9QhCYhmW3krVVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="85840800"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2024 11:12:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 11:12:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 11:12:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 11:12:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsfS5NJajas9jqF4VXP2eRu44Mfs94xSr3DzzyBqtazXFv+AnIARgsh2PlI4qdHLDgq4OUoAI+G2+ldK4qIuQKmpSImKcwFWrRYYz2ueq13ZuIdAypD+jlO1y2fYrIm3ayz/1FTCt5VAU8swkLMCai33j+VaEduoNFMU+e36UucQHeZfXjROaOgRMvfp8irk39Q9FjyLwmwBzie/MID3SA9Ml3/YTUVEbc/I+LaqoxeN6N1ij5H4sO5dDM5A8pnyIhjZ7+tLJCe8gZStx3Dg//0AbdODwhOit5jUpxFNBJ756GcTC+C9NQzrfaMCO/o+SV81YFyuvz/ZkVG+/Lszng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9qp+WX7LyfMzExF5TfuSFsKXIGgvQTLEmiPMm1w96I=;
 b=oKlHYUGimiw8cv1Oz0d+hJEQmLKuWJCeNmE5v5ofNPCdCmsEdg/entC6lF9AY9a+KB19ZF6d+5P8XY1juf8UaKD36qzXk7Fc9nkOsKWk3Q6RwMdeJiRxCEy38jHMYtdlWZIZDlAIAMoAvgsxQ4jhFHUOTnQT+kg0c9JjJM4Iz1yR4fG+gbyYtol44tUOCsFsBMjiZ54R5rCTkTWUbNN/VCP0l/QCQXEZoG8uTlGyhVtKPBEktlHqzuiUJHu7BWwbW2S5P4ufkPXx46Xynwqnf8Eu8RaiN0OBrbs+98P4k66BN+/iP2+NP8zJA0vE/pdlWwVmyhFEa7Itr5Fng0URtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 19:12:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 19:12:03 +0000
Date: Fri, 8 Nov 2024 11:12:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dragan Simic <dsimic@manjaro.org>, Jonathan Corbet <corbet@lwn.net>
CC: <apw@canonical.com>, <joe@perches.com>, <dwaipayanray1@gmail.com>,
	<lukas.bulwahn@gmail.com>, <workflows@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, <wens@csie.org>
Subject: Re: [PATCH v2 0/3] Make Helped-by tag supported
Message-ID: <672e628111eb0_10bc629436@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1730874296.git.dsimic@manjaro.org>
 <87h68k4esb.fsf@trenco.lwn.net>
 <cabfa180845df30bfb7a541a701a57e9@manjaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cabfa180845df30bfb7a541a701a57e9@manjaro.org>
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9db7ea-ed8b-4990-0cdc-08dd00293a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gXDI+6rVvK6+nLfwOhtDaETDNouX7j0hzLaD33Vz2yzTpjXU8YodW1a4bPO6?=
 =?us-ascii?Q?pgl/dum/N+XXtDP8ChnN7P7oiCSjfslKVHPKAhWOg3YgkfC+XbGaPUNeRVM/?=
 =?us-ascii?Q?x3vX5piwT2rEK6QZUIIwgt9XPleYiSOrPtGC6pakS2N84CcdSK2+iqvSS+B6?=
 =?us-ascii?Q?78XdFWnR5aMHgFD+I618UaVQncBGoDZ2KhiqQJoopv66Ni6K3RKvcn5INb4+?=
 =?us-ascii?Q?lQWSyBvaAtMO9/82+mib4CXCR+xHPNDWw7P/LB9xJ9EDDwZGZsUPA6ykpfTH?=
 =?us-ascii?Q?N+G6AQ0W3HCfXaHV8mepvGgQYkYAEP/MY/9j2DznGSoQY3cnz9aMIv6ezds5?=
 =?us-ascii?Q?KTdAe93E2qeEA09vZ1H2i7Zp418nTU9gFdvFhea3uCOM3iyV9vhdSR8OHTsm?=
 =?us-ascii?Q?61RFfiikSRI5zoxORrYQTXpmCwv4SzWujgl+KBleOSsWJx+hvKYFR5jx2StD?=
 =?us-ascii?Q?Sgi8rZots5rbTyogPK/DFs0X1uVUgdZ2aDrb1mRPIXaU5moLRz3EiymW28Is?=
 =?us-ascii?Q?heTNrLxOWgHY/qGh4AGgyR18YXDZONHnaXHtA1okMm1FWcs0ytQYRf1kL9Ys?=
 =?us-ascii?Q?NcjsphcQnGQu0JS3Vi0qkpPxY9w5fcPcJaF686VzIKn4RBBK3c9SrDBrE6PH?=
 =?us-ascii?Q?ROG4i60yrKS1ugMJgVfhegFedM+a5jjRjijFsBvloajs67QP5pnRH8TfXYoh?=
 =?us-ascii?Q?/wf5ajZBYDYhC3wr+wGYc4yCo3WZv9InaEZMPa+cah05FhEf/3ay67pqM99X?=
 =?us-ascii?Q?vIVxG3DDkDnwQBq2smwJz6gyMqmQX++dqL11dYh9hN6/Zja5x1Ej7Ywiy2ta?=
 =?us-ascii?Q?MTFT1ZZUZnN9q7UngsXhdI1f4A6s/w8B9L7sc0wn9tbf4RRx4GZ5UFRrjOqH?=
 =?us-ascii?Q?PgC9qpOfSWzlUVrhhMQ/7Nunm3spi7bd4vl7fzjoRPBDn2sUcKTvKAS+MM3i?=
 =?us-ascii?Q?yjCMYdVTiiHzT6IZB9YGZaRBR9S/65BBp8CrUiOWzoK3Q3JoGuSWBcfQrD0Y?=
 =?us-ascii?Q?m9lD9BRL0NxWoZzelBq4ppcQBw5yBL/VM1ltelLuG+/pnVfwh9dfOFkwu7di?=
 =?us-ascii?Q?EKe+6RtmToJTEVdvoMH3HN+cDxbfYu/MhxZk2DCOBa/1RmCY11CxBjRkV3CJ?=
 =?us-ascii?Q?w1c5O1dC7GSq5WVWxcIaodYEs9jkgmw7oautFKk2k2uSzWddHmoTkkbNymbg?=
 =?us-ascii?Q?66kxTXnuTV2S2xx5dzFUO4RAmQ/B+fNhgCEO5cK6q6fMsNsDQBA6tOM831V4?=
 =?us-ascii?Q?QQ8S4fhDqD/Wew583+M9cCZ/IwMCTZ60BBKZpTawHobR48GRSXkCupGqYEKx?=
 =?us-ascii?Q?aKvK579VYdv+HahCMDyj46ef?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thxcSTpCkSOmCkIpzx9Bmv+6V8rmcz565s7DiT3bihBIeAikGXDBw9QxWMto?=
 =?us-ascii?Q?x9QGDk5DI3WVpElUwfUhF6cDVnYaN1chkthyZ9k4cF54NvYHoApZo3K/J4l4?=
 =?us-ascii?Q?kO77SbdLw/dfhPGzdQuoiyZyeEKY6uNLdiT9VHSO0KoMTVbN6ZfpmA6RU9wq?=
 =?us-ascii?Q?szWTZdKgsT+6aFbrZqmaWQs6zfaQcg/vOyD9cyn4iGWhw2IJXKpAj9J8MKM3?=
 =?us-ascii?Q?piBW4RymbhysOJah/9gLC0KBOrUg5X24ZPDYumRvxhrb4I5SugfV8ggY06lX?=
 =?us-ascii?Q?i0GP2GWFO7cxTeOd0W8PipIyOUCT0FEZFYjxDfhDS8RiHNERLFv8ruj4Jw2X?=
 =?us-ascii?Q?e3y7EzIga+BuQ0II7g9OPvEidTOUXtyXtMc2IDW6LEHr4r3s+6rCS1DKTTjo?=
 =?us-ascii?Q?DP9X8bXzWdR9z5P1l3lsJk7d44jfADYYrN4nWPkTJhTgZSONPt4sb9L1/YiC?=
 =?us-ascii?Q?7Mz7rarr/UfrVYIkGNskArTQCHH5iqY1Nfmu2+CqAHRWQOZzgwiIsJBXapNW?=
 =?us-ascii?Q?jxp3ZppM7Sf9/7nZkeC4+XRei/E2UArCfT2TRoDuKQHK4ZtcVcjxMkgCszsZ?=
 =?us-ascii?Q?VJzO7DxqDAD9WuyyXpZcXkNYrdN/76SxG8wGFSuYrGuUjJPdF4NCWTsVtksK?=
 =?us-ascii?Q?joWESAUFESDPOIK9jhtPn7kRp5ka++X0nGldehWy7iZNdWJw4b6eC2Me7vcL?=
 =?us-ascii?Q?AZuU9Thq1CC3nLdVE1TFKuyHVvpqoFe34j/elIf5HwhSXaMHAqKG262Qk7Zo?=
 =?us-ascii?Q?XlcjaNrE2VMfplm1E+NwuQrgShcX0EGyP+GQsaSpAtn4lSy4ObdSt8P4h8NW?=
 =?us-ascii?Q?p5GZclLYjVnwWi/x5sVuHSRYTln+pSR3cI23dc0eogWF6T04ET64lKhxkLhP?=
 =?us-ascii?Q?kDggAcMlCv1uwpBWjE4AhEamuoirlOY+lrh8cE2aNCdKlayZtP8dxzOaHgfz?=
 =?us-ascii?Q?6sBhFocr8JN2vK+CZPZ45Ifo1U7BRv3CXB8KtrklCeqqlafcqeeielgXeSTF?=
 =?us-ascii?Q?UNvVlVJWgqh0PhL+cmOXrJxv4ubfel1qyHxcTPmRwi+jYqAfsp67fkL++SCO?=
 =?us-ascii?Q?sHJ3aRYOKv24pGSMUWv9ENKIOuPd1Dg2LHfd/0SAK/rO9iV5YLcO0JPpkTDF?=
 =?us-ascii?Q?OuOYX24ODntHAVgMMGaxVvbRW3snj5/FeOBJcz++URDU8oOe0jF1SZU2SQA6?=
 =?us-ascii?Q?gb3TZWv5lyKG4VxURwTAg6diniHYEnUYySWC7OZaco9RBfTp2UkyvSBcK9gR?=
 =?us-ascii?Q?OLRa7Ph3rEB5WGp91pcIH9BbmuJiKU+RM+ZK+Nc+Vg6mzcHEdk5fhmobEgXs?=
 =?us-ascii?Q?pYbfxBFZlBIS7y2sYI4OtcUBAje0UMZeadVios+8QAMaGjloiZMvIOnZ7R8k?=
 =?us-ascii?Q?cKe+hsnXA4MborOhaiW/OTxcT0xkq+k2OqhgyDRbZ9H7Us1rsxR19n5DI5Lc?=
 =?us-ascii?Q?03QwIcACrByXtm8JArMAyUo6TXYVD4BCNNUkzfzJMCHLFWflCDDocRfKiklm?=
 =?us-ascii?Q?BUE615c5Anj0kQfkGzicSdKU62jaxt3uDNzS4dj8aZpDSd/6XoreZNQHHkpM?=
 =?us-ascii?Q?zXJIykEEzEToyAvPRnOGQlQDO5BNLXDYBl25xotTi3UoXZKh6h++A814D44E?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9db7ea-ed8b-4990-0cdc-08dd00293a8d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:12:03.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAR0lqAagO1D3Ga8eS3LFuvUkytjYbUJ3aj9IFOu/IyXVubfkRtRYjsGHkRqZ56S1/z5WjjvziXPoG0eyZa4RzGNHMMd0ZXznF3iTuMRFwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
X-OriginatorOrg: intel.com

Dragan Simic wrote:
[..]
> I'm fully aware that we may be reluctant to supporting additional tags,
> because we may then end up with a whole bunch of strange tags that might
> be a bit hard to understand and use properly, but I think that adding
> Helped-by to the supported tag list may actually be a good thing to do.
> As described above, Helped-by fits very well between the Suggested-by
> tag and the Co-developed-by + Signed-off-by pair of tags, and I think
> that providing the right level of attribution may be beneficial.

Patch attribution is separate from giving thanks. I would much rather
someone take the time to say "Thanks" in the changelog with some
supporting text rather than boil down all the myriad ways to be thankful
into a generic tag. "git log --grep=Thanks" often yields valuable
details, beyond just attribution, on how people have helped each other
develop this global project of ours. If the introduction of Helped-by
would replace even one authentic "Thank you" note with a generic tag
then it is a net loss for the community.

