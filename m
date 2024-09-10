Return-Path: <linux-kernel+bounces-322247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E191E972645
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C1A285546
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4640BE3;
	Tue, 10 Sep 2024 00:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xpjfl7th"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1E2F3B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928930; cv=fail; b=AAjNJaB5qD/Ka84ElUBiuvh21xV/L38s4jHC6j4myknyLwC9G8p8WXdrEWzpUFCtn6l9VWlO+gbYdJYT7SwYx3AYGN+C2Br4gWalx5/ds3BLjC/aHnHNUZW0nvpKXg8bYGMid/dSqaJL/7iBOvPTttw6JEESZ9YukTU2etqjJQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928930; c=relaxed/simple;
	bh=jYhJi/7yqzb7GDHswR1Ty9xa4mBz1kH7zHDQOa9sIdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H5Rxs6ZZSzw2UGNk8rJpb0iWlb19G9ETwyPzcwWNdGdbzAJ+q9tLrZ8SfItZTMkCi1AxaEyGXKPSVNvOQGo/4zTPFrcnQEEo3ta8MBgcvIv2IiAn57c39abA3n4HvHbXXX8VWMrQYtGPx+iMnh7j7WxTfsexHMsnL5vuZaxUiHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xpjfl7th; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725928929; x=1757464929;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jYhJi/7yqzb7GDHswR1Ty9xa4mBz1kH7zHDQOa9sIdc=;
  b=Xpjfl7thX8yXJHF5IQzjgkVzuTb4XlZNy878OXcEKGvZfMimvive+yFE
   zisMqKJod3ZnJ/FLomeDiZWD7Lfa4vyu6dSMRA4iUTU1/8sfyOXjgXhpb
   MyiS7Htwno702eo57SCNoZXVWkYI8FPBgNcKirvazHah7P7l0e3Jg+t6D
   IH3Pe0KO0YfBCzuVtUSEqQi+tbmTQOPhHoOJfUt3pKT/C58PdA+Ba+0k2
   wXVtOq6bhxIym5zi24IX0qL6h7oXFDo2it6Dnyx5L5pZOggoIBKyRK01j
   WFYcUEVZyKd5RzPHTupu/RcsbTolNWM5gcdyvq89Zx6rfOn7Y3LoRNqnR
   Q==;
X-CSE-ConnectionGUID: +n4cp4b/Qlmbfhg/WI3zRw==
X-CSE-MsgGUID: 57atoXLaTcqc4xwoq+E/Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24200117"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24200117"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:42:08 -0700
X-CSE-ConnectionGUID: kJJPf/fyRz+/ykbqiV5ZjQ==
X-CSE-MsgGUID: Kf2nZg3pTyyjhkyZt3o1mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="66645621"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 17:42:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 17:42:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 17:42:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 17:42:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 17:42:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgBywu7Z5qgUWiepZPQQSA6Xu/IwGBfhKm6ScJM7BSTw8/kmPIk+rJHbwNaECLji7/klkv55WSndaPVqOZv6r2cWXV/LGUx1E5mdTtbT/lI2G0UsKVD40fbGZm9HWK9HpQstXoHWOQnpSsHrNlYmhzPdEMTKGxcpmmDvGO42Kn9ErgWSdG2nMRz+RijG7+/Me2fBbb8dZlUgoPKzLNhxORYzHYVA8l8RV5PV8x35JFTidcvSz7/sPureKuxbFzCbqXK1XRA3d/YAOqLBo5z7qJ8OXiwNMB1zBV7HE0uNfiMT8cjIdR8oDV0Om9o3x0moxRN1zr2W+rNaSedmOlwxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6PbU4uGDMzcSbvC6RZQJdt8BFg037llylV58TBw0gU=;
 b=L7V16nX1Sreo8P8QAK1VVFKVBfuaRcaN6B3vjY4C7i9+EHrcSqcjNS4GqwSVZgBe3XEWSv0eGZ9dyxUfNMVwOT2UV17y3cYrE4Uk0Z/ytyCaaqpGypMJo2io+hSmKo72iHfLpnHIIppMjOC/v1DTrXbUgrb+1qfWk3Oehv319wfzhtr+bBwSrHVthZZlshu5nkVtyocD/7XmwRN3YMz0ffLPXloPXDWkuzQY6k4EaEbinAHu9f4CBLksPy1QGfsLkcTgpPWXA6uRuozE9T3YhpzrNibaaT+AErAbvdhOHa9/EQ354/pt15qo/sJOCiX6tJ+YRlUz62JYrF+Oj+0+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 00:42:05 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 00:42:05 +0000
Date: Tue, 10 Sep 2024 08:41:57 +0800
From: Philip Li <philip.li@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: ERROR: start_text address is c000000000000700, should be
 c000000000000200
Message-ID: <Zt+V1fRCG+rspXub@rli9-mobl>
References: <202409100106.A8692079-lkp@intel.com>
 <20240909141319.0cd59cef@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909141319.0cd59cef@gandalf.local.home>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|MW3PR11MB4619:EE_
X-MS-Office365-Filtering-Correlation-Id: 967f3e19-ace8-4f8c-e72a-08dcd13164a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nox66qFI4dvAV8j0me7eNcndYPrdJ8xCqqTgS/3bw3o0Rkc2kHtni/CUovc4?=
 =?us-ascii?Q?swtPCiPEF85VDqS+/wRT1PzKpNTLhox7qMvpK7aIkrMVjNOhVaY8/OCKVAjc?=
 =?us-ascii?Q?wO3YXvBOlBzfuyCXJIhEvoE80d5qk/GzwoPjv6LuEQjvoLoZrtCP6nQd4Cjn?=
 =?us-ascii?Q?GWQpOnjn/0+N8z7MsyQeL+6EH0BPfc/6ppeww5Se0qyeItANRgywqF+wGMh1?=
 =?us-ascii?Q?VMlTGRvSZoBLAn85IgsxBOokObBa5BQvH1XvqWW8nV49EOGRZk+0SBcGn5Gr?=
 =?us-ascii?Q?RsMIKknc3EPN8vf9qcjKic1/1Ks/IKr4+uMfZfq4iYz9NPSBZ+XAFX1XklHM?=
 =?us-ascii?Q?9QdVnTEIgh+SMbqo+VTapq3qh5qKkcIIWNU0x1MwcTCxiZyeLA1sINwCkI0e?=
 =?us-ascii?Q?Lk0XQqvpTRXMy1ctn/x1Vh94E0/x0zFxzKv/Mh8mPDBr2s6cZVDwx2VIkm1w?=
 =?us-ascii?Q?2HmvYJB+8DZyk5oA8JPhyhmPW487I06qR7YrM+ro/YIY7eHIoHP96GN67sbl?=
 =?us-ascii?Q?5nkt3hyVo3MR8YtEIkqmRl/3m+tQtjDISwrXJ3ksHNdZXXABIToo2nlcyKbr?=
 =?us-ascii?Q?maGJSCNOMARwui/8mGuHoj1veqW/5C6Troc9NfqrAAaGkr9+iJJdLt9w81Gt?=
 =?us-ascii?Q?QmC88S3fbjdY7mS2igoYULnHa1oXtrK7iUve3OF2oSl0se9r87xJ8xM/SD/t?=
 =?us-ascii?Q?XcV+uISlmvN8xGik2Gn8+sbrJJsM9jlsEkJQn2V6WvoABkWYbATA1iZaliRR?=
 =?us-ascii?Q?phNUP0ypmNj85pWnxM0aptqB+CieYbC+4KtPiUnPsAY+u/w+614gDxbp+OAE?=
 =?us-ascii?Q?d864PZJCZ6hhtWlFvOzJZjOsC0Erz45dHSo1nnBnqEkP0EmgwMkWcRdHlBZj?=
 =?us-ascii?Q?PuE8oCWb6hCmM9jyU9Q7vjc6CqgKearYtT1LHzUgB2tyytTbwmUekP1F6gVo?=
 =?us-ascii?Q?alf8fCiaydxbDzQ2XYKjsi0B/SXdgyw/Bi46FFuvqdsUzZfzKZBvHQ5JQp3b?=
 =?us-ascii?Q?mUjmwSJAI0iydyQau5VntsJt6DTNCEd12YGWeWgEs7tw8v2eAv3NPqRfLfDS?=
 =?us-ascii?Q?/imGepajeJgoBNo4ctOM8SNTpDlFuUz3q2SuAgNnfBO9wSRkMANbUnmm5p23?=
 =?us-ascii?Q?VwRtSZbZrVAxe9k7A+rBg2JHzJR3LmD7vvfgbUldyyAoFT2v7hFFQNEBLHVO?=
 =?us-ascii?Q?PmPtlfEk75Nc7EiljP6dn26wrOrytD9Rpj2xARWE7HB8bGBJnMQBfUtd79XP?=
 =?us-ascii?Q?LTxKZ7XcKyZQmrxdUC5Rf2KuloMB8rvadK9/qMAFumSu7gO1FkSufrIEFSrz?=
 =?us-ascii?Q?a+788HRw/XZPlx6lHsuKt9Fb49/HivcLrhY0rNfMEvwjSQQ+vyt2Q8qvNLQ9?=
 =?us-ascii?Q?MEWlRbQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQ3Ab+JZCCMf9ONIx2VuG9gdcDjZ3AVjwytq8d6PwejIkaxAW2T/N4S4dhII?=
 =?us-ascii?Q?ZxeFhFQWreNlnkHLa9kx+tc71LjDRIHsWlhaW2ncPUCx3lXOs2Kwnnu5BVgS?=
 =?us-ascii?Q?ofcpsthw54yBHORD3SUoYoA3BgrsAB9R86n8uD6JkTB+sTXHinOxYhXoePWR?=
 =?us-ascii?Q?T3HR+w1WnT9iZCX6y3ZEDG1ewl6zEA0kI46mrpgOvGhauJ61SMFO/I/usnNi?=
 =?us-ascii?Q?ri1svOlX/3Emo3s0iynYgM9W5GyGL+IgTLqjd/IeMCdbK4DhZ7WGHJX8elOB?=
 =?us-ascii?Q?UCCwb4IeE7Ue0o3e/de4rXiRQ7vN+3qKx2i1R9QePVtgimsc2ACt++gqXs+7?=
 =?us-ascii?Q?UVZQjGnn4XwlW6Iv197qxMYm3DBMz51STyXFvmoU+Wz2Pt/oagnbDNIZTlb3?=
 =?us-ascii?Q?hs1jvwKfpOPuMlen9r4p8OJPzK5P6OpS0J+5OYl7/l8rBQNWReV4Cfzwxe3a?=
 =?us-ascii?Q?2ZEF6uvCBx2P0U0QoxWLaeJLzCeo0jE0p1QeKMy8tAEv+Qn4z5hwZUkWV91n?=
 =?us-ascii?Q?fldi/uN91LEnzPxVAaz3d9e773OZXz+xnby6jxOXWuFiELe1zbRNJwUgne5G?=
 =?us-ascii?Q?6RGNXFnT1eWnjSkpiw8etR26kzXJXbi/lrPhGGbZs7dimCYWne8pB89wvH6h?=
 =?us-ascii?Q?Vz6/XZr7QRyZsq2tYkwRALQBwF2ct2Ub6GpmH/b4FBLNnEuFo5Eqza9Phv0/?=
 =?us-ascii?Q?PNLPKA4ilBGJr8yg3kFU5/NkGjfSlFQOxX4l16a87kEId8szdCvWnS3nm+ZQ?=
 =?us-ascii?Q?74AsNkISgFTfiPC1jTldQvseFCv1wRySri2Nu5Zq0ou2TI0XgSK1a+BNc55Q?=
 =?us-ascii?Q?cOv88QotZHfO7GEiTDmrJKYajhLTZN+fLUQymO1YS+ZlbxSP5Qv+T39kdV5O?=
 =?us-ascii?Q?gAHjFO2Cs9xVA7NpeLGKGlPZu1sCUN9NFN4A+SSLEfLsXwXE4a5xPAwqWmoi?=
 =?us-ascii?Q?Zcu+VpKyZEKqLOnRYejSuHOWR+58rhFcWAn00QeHWEiKIHZ3Ajf6wIbSjwcU?=
 =?us-ascii?Q?y9mQYwxtwC7Vaes+TpbBQ2zyj/7UVWkB/lbQT8XPoULDdZAzoteugJ8wMWeN?=
 =?us-ascii?Q?6ydzXrtjB/TceABzt8nv4WIU2QDN7w7OpzS7esQMa+AIBwqXI3YtkBklrMX3?=
 =?us-ascii?Q?lIyieurHLhmTpMnbwfhvnkai9Nf1mGMM+ZJj3mogLlQfh0AqHjuQYIzRJUJt?=
 =?us-ascii?Q?5TXYx89rNsHIwzjVykQT3xsZe8us89KZVQnXkNBUqcNocV0whOPXgg8STjoW?=
 =?us-ascii?Q?M+dULfQTwP/l8yVpiG2bQy6rudMChS4dZGHnMK29KgtNeUvQUWy9atoZbK7z?=
 =?us-ascii?Q?8uB6w6oqvDh0jl9UMrfeGCZuJ95r1BdG4sYsAewZjIcnC5RnP5Hl87z9Yla3?=
 =?us-ascii?Q?yi66EWizC+ROUASzxcfx9Yrwzcs5YOe9AG7M4C7TjHMKwwHkQ7Jnk2wfRprw?=
 =?us-ascii?Q?5RqheyBECvXQvTkSW9xf9hCENACoJzg53QniquvB47cw3JnhygF0bl/fB7DB?=
 =?us-ascii?Q?taEEkaq2miXvAETA7udUUOqzessYsUxVAWw/RpIUcOQwE1KyFMduTK4TjKYw?=
 =?us-ascii?Q?6xacjUI4aJiKjVgvT94ZC5jYNnC5qCW2gMkX9R70?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 967f3e19-ace8-4f8c-e72a-08dcd13164a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 00:42:05.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2N8iODhs+vM9eJyUgiYZGywOyu7HhHd3bvbMBAGlXb7ica91Jucn6peMFK+3XPxLnyv3Tm2BKjKgmFtyL3n+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com

On Mon, Sep 09, 2024 at 02:13:19PM -0400, Steven Rostedt wrote:
> On Tue, 10 Sep 2024 02:05:29 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   da3ea35007d0af457a0afc87e84fddaebc4e0b63
> > commit: 6e2fdceffdc6bd7b8ba314a1d1b976721533c8f9 tracing: Use refcount for trace_event_file reference counter
> > date:   5 weeks ago
> > config: powerpc64-randconfig-003-20240908 (https://download.01.org/0day-ci/archive/20240910/202409100106.A8692079-lkp@intel.com/config)
> > compiler: powerpc64-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100106.A8692079-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409100106.A8692079-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> ERROR: start_text address is c000000000000700, should be c000000000000200  
> >    ERROR: try to enable LD_HEAD_STUB_CATCH config option
> >    ERROR: see comments in arch/powerpc/tools/head_check.sh
> > 
> 
> How is the associated commit anywhere close to being the cause of this bug?

Sorry about the false report, kindly ignore this. Seems it can't bisect to the actual
bad commit, another similar false report is at [1] with a different bad commit.

We will avoid sending reports on this issue.

[1] https://lore.kernel.org/oe-kbuild-all/202409090839.Gz712lD2-lkp@intel.com/

> 
> -- Steve
> 

