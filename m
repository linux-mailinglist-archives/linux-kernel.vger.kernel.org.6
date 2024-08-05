Return-Path: <linux-kernel+bounces-274271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15CC9475EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD461F21A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E18149000;
	Mon,  5 Aug 2024 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFONTW3I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7A4D8B6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842554; cv=fail; b=IS4DaXovIYDPp7oGkhLhXqbkJAOGXLGuQ+SLwIsotmkZEhAMVShX04qLW7PNGJC5K16DPdIRD9/qVGCmZoWPFv029RQE2n3jO/Jdnt0p8TRfA2RPfgZeTMiao2vG8/74WkN3l9mKDVFYCBamtOAtAHBavRTJfg5kTwBBIhzNAog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842554; c=relaxed/simple;
	bh=G8qYcpeD+aNpfQFBwA2m5dgoexT1MEHTVKUYTMTehx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tUIdNnVdX8eHvc40FdQyy9BFfshhsAxicOAnO1EeaLmNRzOTjwjpjfcm81AqlCj7dMhsS8Hw8FLF78QfKHFjzyh/k26znr5kWTfU+TwXqXj4i3VGE5fuBpuG8OrVZANJPAALc3ndigsvCOqLknTDCXEdCZrucxsH82Y37PKIQKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFONTW3I; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722842552; x=1754378552;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=G8qYcpeD+aNpfQFBwA2m5dgoexT1MEHTVKUYTMTehx8=;
  b=kFONTW3IyKGODDdatKOTlMz32tyvOJ1huk568nQ22YNUgsJpCAVyU1Ik
   3saG64OI65NU9MS9f7KIIeylHu+klCq7uBxBVKHV8ZEn1XHx9YulULplB
   fb87QPMdMRQBGGT0zXQMvV06DXYqUJIuJrs9s0yaO5pKCilCR6No4wnfF
   HeKE+gLOcWTomgpoINANxPJIr3FZUuz7Ll27D/VEFXaor3rX1wpJJwO7f
   fCto6usMQZojD5eqClfp/Mm3EqMuuarcoJZiAYYkn0+XEZzt5oRpKUWCj
   boakDEwIB6IlOYshMWqULeGGUrax+E7R/aLCgFOZ5VyAASo/7XptDdmgr
   w==;
X-CSE-ConnectionGUID: NDN5Vr4nTfmyRJ+ADplCRQ==
X-CSE-MsgGUID: 2zfG70uxSjCO8yUJg7R0Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20929167"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20929167"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 00:22:31 -0700
X-CSE-ConnectionGUID: 9aBC5Pp2Qa+JI3/bdSAb5w==
X-CSE-MsgGUID: zDoZqwXoSAaCQOPVBTwW5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="55739878"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 00:22:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 00:22:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 00:22:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 00:22:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFUYKN/hznNlHsrhUMXJpympjXnmeihT0NayO1IvjqQBbIyBlBY8By+R1D3sZuekbuEBbTEwoYgfsZAJ8+G2qAh1a22p7TFh4Sl7UI8BEtk0Vyml+caIupABOzUUd38yrnJKvNMwSqnmYMEc2i/npRqJnq70+agGS3byvV7LsCdDlvqWNAVV73y3wu6LiTV0b7wwiLWod5Tyn0/Npur4VxkuRvhF3CLfQQZsGxTGvJU7C8L8J31SN+LC6Yr8y08xxmewNtLzCC/5OAyejYeYY/sYImQLmdul6ZrMagBHg3YtVKx1+6LFKMrtCMRDvzdVWyM88+cwssq6dvSegRwC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHSJXy5yWTtA5mY/fbncfUG7g3PLDruqlVbpdQW74e4=;
 b=RRf/RXJWGZlHYIU7DXNecWWKhLam+QQ+L0Q50AzMEjcuXzFBsoS4/S1Fx12xxxWGqgERmBhFXzqCigtj99tLcas9RF+nR+Ga8Fix+kimUfWnphFPQouRqKvfds0NlslCwSzg155LBEMRylmn1kKs+Y/NgfdPRe0TT6cUX5JDmeknhEI8MkEUb5rEgYA+g2jLpvIhbQRGuwFK6XNlZVYJZ03WHGd+N0/2xac0i5iVv+UJI8D/vhaLeARU/XcvaYrkaFdVOvGjYDRFxco4wzSnQvWgmTSZQZ9s6qaXGmKxARuvPoDGl8L55jY5r21/mqWgAOdKY6FMclDi89ON4lUd/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH3PR11MB8362.namprd11.prod.outlook.com (2603:10b6:610:175::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.23; Mon, 5 Aug 2024 07:22:28 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7828.024; Mon, 5 Aug 2024
 07:22:28 +0000
Date: Mon, 5 Aug 2024 15:22:16 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
	<yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>, Mike Galbraith <efault@gmx.de>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
Message-ID: <ZrB9qHrMKtVEF4Hs@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
 <37d33316-8605-4076-a08c-02bce6ecef4a@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37d33316-8605-4076-a08c-02bce6ecef4a@linux.ibm.com>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH3PR11MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 191e4b74-f52a-4985-187e-08dcb51f5c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?R19CKlFgNtgUvhSUkZxNoqDid271UB9y91va7YbuFvro0jzXwXBJiHRTw8?=
 =?iso-8859-1?Q?flw5sNPgzrjd+hrkFIBs7Q7G523VnbF08p9jN7I3pRULfzJ8nBRupCDcT1?=
 =?iso-8859-1?Q?w6OAeQhVvRKzKoF7kvCm+Qai6J+j3Q+sv2uQU+fo/l7YglvpRaOpuQHP5+?=
 =?iso-8859-1?Q?aufnDZt1F7xV8Ru041war4xABsxtSFPSzh4faTojziLsGwx1jljR1PKdRt?=
 =?iso-8859-1?Q?/Zyj80gFacGOPqWhA8E1PzuG+/d4AlSwAhrq+dJE87xZzalHgE1ckZ2bHs?=
 =?iso-8859-1?Q?5AFx0Lbt0s6T5YFbtyhKkh3xgxcMgm3D8puSJ7cNEfiQsrZS1UiUUhGI1F?=
 =?iso-8859-1?Q?0850MeeM1OpnQdlM+PcIIu/qCjAgcdukVAQxo5POs5Qm5wa18Tfa+cgccW?=
 =?iso-8859-1?Q?+R8sbvjHveU1mQwQn7QoFgQh9wvK81ZcdNRaRE5mNECy+Bh7/a2XH1OhNQ?=
 =?iso-8859-1?Q?v8BvRkhoO4MlQrIL4wmY23Ntapn42xzhhdiSAd7ZxmnJ9r4svYShb5L0is?=
 =?iso-8859-1?Q?u/wJjer1mqxwMr5qw3hW7znixl+PGOLsZ383XkdHmEE3OLn9egIdI6pdAm?=
 =?iso-8859-1?Q?l+5ukvC3ptVAkj55SPFyFdecMRD98Og8VnHNjvesSBiGWspnKHui9dG9f3?=
 =?iso-8859-1?Q?+RbBQSznnMNfott/0TctevDsumxZWlgyjpZCm5fAxElDo8jhQNOUtwpQBA?=
 =?iso-8859-1?Q?arXhcJK/+ffAWN6xZosR5nealJSxJHgjhmJ4KTiXQexasFSg1oX+egH9g4?=
 =?iso-8859-1?Q?zWZkmfdExt+mM61Jg3IXWamsk/XbT/SfURIuZsyqk+NDA7tDMRdLKkSSK0?=
 =?iso-8859-1?Q?dP+KTOKD1CigSWhdu8x9yvsnLj1Vq6JPIQ3WIBBbiOb28FVNKR6p071MBj?=
 =?iso-8859-1?Q?DQuJU7ucTl6dspl9ys4lwKGlaNK+WkVCdmMB6ksq0qvumuj+QVJdQO0zg4?=
 =?iso-8859-1?Q?sSLzislfpEDSm4Fw/jvMAk1zOtlJa+B5Mfuq558PvlTkLJLrRa6A6QYHnz?=
 =?iso-8859-1?Q?Fui6FQ7zmitRYlbtkc+XIEmIIZpiM14R5FSOkPW+vaT1hQFXNulPmwubhH?=
 =?iso-8859-1?Q?EWcHe/ZkEGu5xn3bulzsAmGPWqR42AH3Px804Np3Y+Ha13PHJRy0u+bFyE?=
 =?iso-8859-1?Q?RcLLuh8fD1avgMb5rnkuAqXHUVp+XryhPvqHCDRFTpDH5KryGonpOOj+Kn?=
 =?iso-8859-1?Q?dC/iZVtgTzDYZSQreBwKo66qBFho5polDbmGZwTSn8Y27cjZ3y13iDBV7G?=
 =?iso-8859-1?Q?TNbQ2bAFYBSzKHfCvDz2Fqnjy9E8Rl2cl9XamB8NQspkrETwOvJ3V3k9jQ?=
 =?iso-8859-1?Q?yzr+N5WM7mE/iU1IyP7MZkWezyLrJ1tlUMPprGZ1i/pfAnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?G0js4lpcgGKZ5zDWFBx1n3+VPdV+IC2ikKvutySID3y9C6Be9Ewd/gF14+?=
 =?iso-8859-1?Q?zhv4SE6a5EZQ3EgzK7njo5r+rAe+Uq23MBqgaMWFQ4+LTj0qoa4Mik5Ijo?=
 =?iso-8859-1?Q?Q4TU1GJjzQUrBx9vjbqR6rQe2DpVgojAqMSiRo+WNMAY26zTscEHcuMAJO?=
 =?iso-8859-1?Q?ZUQzPBqlnplJQ2hF0+kKI4jCm9BqHJLt+/WBALANCpeqPnpAt8P0UmUIgf?=
 =?iso-8859-1?Q?73s6esNv5tr5wHzFbtwYQYBmQXOJqmUMbTdPpj4fjuzqikRV/h2ihAUbRD?=
 =?iso-8859-1?Q?uAiPrtdYGTvzdfluITLpiLjk9mZGa6pcazJKvYBv9QaaCrphCOJzE0oyhU?=
 =?iso-8859-1?Q?z952OwRT/cuOCdHiuBke9rswDWlNjuS0fityppmnvl0Z2jSYHLq5i6pwEB?=
 =?iso-8859-1?Q?Oi+o1mrmDGczHu80y0OpTlO3yaqzObKM6ngAPk6cilYd+asCtl+ba3gA2f?=
 =?iso-8859-1?Q?9g9VW+o80JpRYSYLoLpI86TbPlOFCUwsljnRRi69r7Z1HpukobFbtwvbtB?=
 =?iso-8859-1?Q?ADPyx0Jpx1uzcJ1HpjkV2sOmzt1VpD3o02eHwHRqnSWL2NeVekV/fZrQar?=
 =?iso-8859-1?Q?0W4J0PxMv30wyNJKWhyPQKvrPDgkts29cfFQZ1oFoArJx9ROE4jB/g1x+p?=
 =?iso-8859-1?Q?3I1eVLw1aYIbFxmrU3bY2kbWvoac/8Xu0zpwX3Y5fgQYqUXU7Skgs3hOMN?=
 =?iso-8859-1?Q?Hc3hf+eji20PKC/pwhus7e2NSFor3oNDTsYblaxnU6aRMRCqaKoifrEcjo?=
 =?iso-8859-1?Q?AjS3qJhz/RZK80ET/DoS87y6Gh9RfHqhI4Mp2dr9iJ5UuhVYYCq8OqN3EZ?=
 =?iso-8859-1?Q?WkPRXq7PM/uv5hDw8ExFCi2Fox6tI0ePHYd+mOZYUpRLU43P/mXcDJJEec?=
 =?iso-8859-1?Q?ObZ81WCHvZCKltDPzC7L5arI8rKJ1LCHfsASxfQVygbE5YsizEWlZDk6Ud?=
 =?iso-8859-1?Q?qs8WTW99wrARwoIodGSuAR7ix5pFbzP/aPzFbgRx6FkxznDUuM7s1qkbX+?=
 =?iso-8859-1?Q?rP//Z7cvet209VKqE/sCToUnWJthXECUaDYhXNsRDOeaku3wsxBIgGZcb2?=
 =?iso-8859-1?Q?50YLjyU/lQ1F5RmGK1JIyUW7nEoI72UCKK8YBnd33LECiQRqofHcamA1Eq?=
 =?iso-8859-1?Q?mVh6qTxtWys3GrJoiMwGNS3smExjekHo56SluKRCd3O7MO422SACHa3oiE?=
 =?iso-8859-1?Q?fzHRv7AiIaWeySHOM+u7E8AZzh5js0kzQGN6BPm/Vj51UoDhCnCpuCu/KF?=
 =?iso-8859-1?Q?zxWUs+LpPeR8/Ismu8myEuQrUSJqWd1vytak//9Ymiu5rvO06/R8RZMQs9?=
 =?iso-8859-1?Q?qzTDU2MwqOKtGGepyQyPUaTXTsismc7d7i4fnlZt4Ia0w2IhpH7jlKvrG/?=
 =?iso-8859-1?Q?zBFsG9AW4VwbGKCdutbln+0KXsCNDGLXR9YQNCvxKV4J9n4Hefj1bJa69+?=
 =?iso-8859-1?Q?Jodsh/xgSABUinuEssNH3EZkC+jQgvqGJ4lNQCmRGISK9WF3R3ULwXCoLu?=
 =?iso-8859-1?Q?wQP9HcD2m91Qm8ddoArlBbR7yNQNGlelz9umiA1J7oQcaqCD/1tpjs3ZRE?=
 =?iso-8859-1?Q?FDyy/niO8d77kiuIA3nRHK6FKTzxrnkZaK2kiaCW4SM1CrvCDaB0wFP+Zh?=
 =?iso-8859-1?Q?rpJ9Dyn2pPLyEwgC4yo2D/uFwIDYBZunne?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 191e4b74-f52a-4985-187e-08dcb51f5c88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 07:22:28.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsYcgCChMrxul81jK8A0n4FRJGSE2Rs2KN5UtYnHBjszPnEIzwAdAKsW+gFFJuRp+6YylEAWzu5qwxRy3M+7tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8362
X-OriginatorOrg: intel.com

On 2024-08-05 at 10:08:35 +0530, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> 
> On 30/06/24 18:39, Chen Yu wrote:
> > Hi Mike,
> > 
> > Thanks for your time and giving the insights.
> > 
> > On 2024-06-26 at 06:21:43 +0200, Mike Galbraith wrote:
> >> On Tue, 2024-06-25 at 15:22 +0800, Chen Yu wrote:
> >>>
> >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>> index 0935f9d4bb7b..7399c4143528 100644
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >>>         p->migration_pending = NULL;
> >>>  #endif
> >>>         init_sched_mm_cid(p);
> >>> +       p->prev_sleep_sum_runtime = 0;
> >>> +       p->duration_avg = 0;
> >>>  }
> >>
> >> Beginning life biased toward stacking?
> >>
> > 
> > OK, so I should change the short_task() to skip the 0 duration_avg, to avoid
> > task stacking in the beginning.
> >    
> >>>  DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 41b58387023d..445877069fbf 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>>
> >>> @@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>>  
> >>>  dequeue_throttle:
> >>>         util_est_update(&rq->cfs, p, task_sleep);
> >>> +       if (task_sleep)
> >>> +               dur_avg_update(p);
> >>> +
> >>>         hrtick_update(rq);
> >>>  }
> >>>
> >>
> >> That qualifier looks a bit dangerous.  Microbench components tend to
> >> have only one behavior, but the real world goes through all kinds of
> >> nutty gyrations, intentional and otherwise.
> >>
> > 
> > Understand. Unfortunately I don't have access to production environment
> > so I have to rely on microbenchmarks and a OLTP to check the result. I
> > get feedback from Abel that the former version of this patch brought
> > benefit to some short tasks like Redis in the production environment[1].
> > https://lore.kernel.org/lkml/36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com/
> 
> Since the discussion was about real-life workload performance, I ran the DayTrader
> workload with three users and three instances. The results show no performance
> regression, and a 1% performance gain was observed, which is within the standard
> deviation.
>

Thank you Madadi for your test, let me respin this version and send it out with the
fixes after talked with Mike.

thanks,
Chenyu 

