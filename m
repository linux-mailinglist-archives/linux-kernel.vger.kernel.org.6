Return-Path: <linux-kernel+bounces-229044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38AD916A22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE8283295
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D715A16A382;
	Tue, 25 Jun 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n52YOWiz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815EBE71
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325244; cv=fail; b=swsjqe0hDGGozdDsbiA7ZUrRrRXxJl/gUyah/Vt9Iro1xKhGcdZUY1e2P7kH/xyDcXnOq9QvlGNq4JIX4pDmxjFcvesrMsH964Wt3Vzgdj6WNaZJuQ4b7o57WFfIDqhFQeDWpC44VdCCQmdYDuyBqjJifGYfGJZQaTeeA+M/pVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325244; c=relaxed/simple;
	bh=QKa6irkBrhVIrEXvtOK1qYjijc0K5e9HY3Wrz3sTye0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gJuwpt3LsTSMpSyK9H+WrUc81G9cMK7AOWidwl/bA0X7f34XqWUsEPB4pciW6MqZG/vrUJF6VWQa0cHe985DZq5IQBcF7sfggm28p2fq408Bj8PmS2VU5iLYCoIAM7TyPutQADNA5+XK10UVU0Xu/FAlhvJwVYCMYE+1NWdOikY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n52YOWiz; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719325243; x=1750861243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QKa6irkBrhVIrEXvtOK1qYjijc0K5e9HY3Wrz3sTye0=;
  b=n52YOWizhrefB3x/rQjlpJUPnJi0BSIvicf6CUXt+PR3edX8yDnAdHSw
   0+X7eGdpNWNDJI1Gp71tjpGayuTjBkYhjQcDM1vU52JMedfLC26vmn/08
   EI4emSvyazTSYC8Q+pyZB9aMcywyy/2Rrx5slQvjrC25PZPat6KmMgzdl
   FWdSuxhCQfpWVg1WNjV4aBQ75hvbcGI0m4tLLKZt/P2iR5sacO6wFnehI
   Xs28nLfJ5K2TBaEvlpKaEVt76CKwmkNh4HxRV9TsDgRhux0QRk6KTWYvd
   X92tH3pzHPrz1qCADpHfa7RVEOKhbZ47mxJuNzUwg40QDqg9Gj7Y4n+lb
   Q==;
X-CSE-ConnectionGUID: 2+EdJH5hQGSTnshzDI8RrQ==
X-CSE-MsgGUID: L8uF38Y3RX6gis6vGJRkDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16101040"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16101040"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 07:20:41 -0700
X-CSE-ConnectionGUID: E4TvKVeLTBSx9dIgAElG5A==
X-CSE-MsgGUID: g2odW2Q0QJORJ1mKD+rsrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48652037"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 07:20:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:20:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:20:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 07:20:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 07:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWOws8EQ1RTvNedF9zBepK144QrRfNR2mWUAGdMIcgt1MwVPZl4ikwk4ym1CBP+HoemunN1x5fVX1oXCv0FkJvHMFGILiB3UZ3Y9kqSOcZ/fhbthMLbmj43mcIGpTCl2d8FUBwFyfTk3aVfNyrA+bUBM2u+6Ca+AlTKfKAAqG1ddB3jH/z6K1TWocWiCIx+jSGhQnogeff6od1VTpU/8q93+pErRrBAKKVHZsV6Gq6mM8FE/qrHRPsuRg0npMH8AJ/tNPcH2K6zfVsxAeF+fAQuPk0sCEaqsV+21ZaKQe7VpnNgHvwSblNUYut33Rz2nGoR6oPlwVkSzf+7bDCdqVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWejZNFnhgMGX+AYU7/RbqwP/LVKmOo3qDgZlAY9JvU=;
 b=FTGwB6JXt6+INEbutKUkAxUahl8OR4nay/Fyd1ESGvCN5gsI3OBkUu5uhNcI7ezGEdMIl0sE0wIV+hIlrgo1F3bk7XRJQifV2t5bOI25yYMccgVQknsbYe85WRpSGZ4tbkfeYzDAXgKOtLkhDCjLTbWPsZXSwAqi48wMLMYkKIT+fS+TQkcxUBgVxFJL6vf2cHGG5VWvtKdOd4DmI5i5wbK8x+VZBKC4FsOb1yk/BejCPsqP2mILSmbBDFWLoQ5GjzzkfDE8mQXcHszifVbyGzTxUu1cDrbNTo4ck4w2dhRnKj6iH0i0pIAmgO4qtlw6NMrGNxe62DLFe1/DP2vIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA3PR11MB7582.namprd11.prod.outlook.com (2603:10b6:806:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 14:20:36 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:20:36 +0000
Date: Tue, 25 Jun 2024 22:20:16 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Mel Gorman
	<mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, <rppt@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Bharata B Rao <bharata@amd.com>, Johannes Weiner <jweiner@fb.com>, "kernel
 test robot" <oliver.sang@intel.com>, Yujie Liu <yujie.liu@intel.com>
Subject: Re: [RFC PATCH 1 1/1] sched/numa: Hot VMA and shared VMA optimization
Message-ID: <ZnrSIGKBpyeTmSJt@chenyu5-mobl2>
References: <cover.1710829750.git.raghavendra.kt@amd.com>
 <88d16815ef4cc2b6c08b4bb713b25421b5589bc7.1710829750.git.raghavendra.kt@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88d16815ef4cc2b6c08b4bb713b25421b5589bc7.1710829750.git.raghavendra.kt@amd.com>
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA3PR11MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaaa4dd-661d-4e3f-c90b-08dc9521fb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a4kODne5EYC+2AqzTbZ/GE8qVNJQuuW987h0fROs+F8/KvAsUcA6JoIQSJBj?=
 =?us-ascii?Q?exTLMlAe4KmIG8NQXiewAovg+8L3B72WmBYuWEFt8tpxDIfBTO9VDbyLyJet?=
 =?us-ascii?Q?cr+6zyGg8p95cFlGdGFPE7i9Gu2x2KrWZ89kOBffx2C2Q+WHDq9+5GasKA/M?=
 =?us-ascii?Q?XYB5/gSs/2JRM6aOMGMwX22C/HMW97t4oyeB7/ZsW8Hm1iOiprL3v12KPChv?=
 =?us-ascii?Q?jWVP4nMBkyhfO8wBZpTXznXDDX/GqIOhb+D2FBcCsPVAyXIcvJcuWOJBT0qZ?=
 =?us-ascii?Q?ZTy1JmlgjM3BMRWVh5QgHLKwY/Oe6O5W7eidf5XlPITHcicdt6S6OeHbaOfP?=
 =?us-ascii?Q?yG565Z8UNb1cB4YbvvPEn+i6juaYsJ1HT8eJEoXsVzmJizN0ONaOVZJfEqJa?=
 =?us-ascii?Q?0Dj06Pf9T1S8zvhY4GaeX4A5QUzqZwAFBKA1i5Auy9F7aKz5U4lHChv8ivyc?=
 =?us-ascii?Q?LXGA+Ev5zv39cUt9ouc/FkHSAkFAwp095NL6ZHzYSH1nqpKUUGKpqiHzrIce?=
 =?us-ascii?Q?LprFHJp9JWGJo81mQGb36NFJlMgKWUxMOmN+ItAwTjDmJT65HnpORG9Buhwn?=
 =?us-ascii?Q?mLj1dOVI3AkroxsbakeC2kdBF6oct8mHisghEFOwnW6YO7EUWQtzkJdmTF4Y?=
 =?us-ascii?Q?oq51vpL8M3fP7pz+SEFXHFVBztjgauHXNmOkn+r9zjrQFeEgMFQZ4yZzD3hF?=
 =?us-ascii?Q?D+EJ+XK+PFnIgU89XQ9/dFfX6IZuDgACCVcrEK+cq16xJ6882+EqmtrKWR3+?=
 =?us-ascii?Q?WNQDKzViAp3POdPC1qdhpdxFClW6yRO+vLlmmL823RbKqVb63FnufgB+Br3n?=
 =?us-ascii?Q?F8LeHK3UUqBzrpEebFteMqIDTvUmRQmX5yRZyg+YWoD8lmFFFf6ryMk/BUa+?=
 =?us-ascii?Q?lU3MnkrWnpa1ioxNYRw90c1sPAVsx3tANeswrVzqa/FKQGC+sTjIYVZo+KPV?=
 =?us-ascii?Q?PG0m17XGhiX4ADKkd1B/mxscZzNN+cIZ63z5JQLyF1ZrubV0rx2cwotvmJNC?=
 =?us-ascii?Q?d5XBPzsgcN1U6iAGQt14GEhsH5iUfRVDJyGiTA60J77tDU07YNMzpBgpuo31?=
 =?us-ascii?Q?feHLrW8gHP+Btqwn8hw7LzzZQNAmCLdzWJvWLdaQM3B38Va8+5iN4v2oUYT+?=
 =?us-ascii?Q?jKuLzfJFt9e8x3UiS0rfDMYGCN+8FQucYJEF54Eu4a4NnaTIE2hlb18ERpVJ?=
 =?us-ascii?Q?zFPDJhZsMy5+nwlm/0IV3twCreu/I1GUJS05VvDsjN0WETdMmaDUbirCMwm/?=
 =?us-ascii?Q?GUD5GCSvj9+qVqrJ6vky8eXtwuAMVrM0x0mp9S6JXU78Hj1ffNwXFl6s0tXA?=
 =?us-ascii?Q?lz5J7RgLzTmLg7Aw05MRefMk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DRXIT9aM90ulPTMs7LtxyYzfEJY/1tI1aV9JDMjtUpl8BCd7pOBwuZbJ1s6j?=
 =?us-ascii?Q?qIdKJbyrk1wMj8dTaBj0UrP3f2/hJkLA9SDp6YwjhJpYOPaosJU50D2uGwTX?=
 =?us-ascii?Q?mvh9Z3wN+KcA7cqRw/VCTUQB2DEz3yE7Gzn2oB0rS+wgYLpm8ZAyad7vVy11?=
 =?us-ascii?Q?VjmPnTnKLDI2cpAWzkL5tPqcE1fPeNYq9fYs7Dyr14rE1d0A35a48v9yl9nO?=
 =?us-ascii?Q?r6mKah5p4AJkQyC2Zpyk9iV3QGjvSL63Pxqy0fn9bfD+r5KyQkEC5Fl1I2jJ?=
 =?us-ascii?Q?kP0MSwdJSyjRUK9CXfvUKV5bdEMki3dgd56+nLyeijQjieAhwfAprhRjqcaU?=
 =?us-ascii?Q?FKHMtZTjCiR6ZUREeX7FIs7EX+HvDzLIH/jRHVdcFwuPyg1TlESirPqgnU/F?=
 =?us-ascii?Q?wBNdyTCLpOlLna/e/L4n+PeVRkLKWyjcx8ppanTxioyetufp2QHILHEShKst?=
 =?us-ascii?Q?wV0rW05xbfURDfyS+V6qWlG8Bt7v0OEJ2kJceJKBmP2meCryYTqYxs1R7hO9?=
 =?us-ascii?Q?YugpBxuV0d6uvnVSa+/bcrhokOBL08DcatVoecbeThXBuWIsakQ4WUNLJTcn?=
 =?us-ascii?Q?cVzcPkTqhVMnI69k2IjI7hm512gWPcYsoBmoFQpzUAm9ks2enMvZmPj+NI7P?=
 =?us-ascii?Q?pBktGJX/MYIaXiBueIr25CXSySgcDISE+Kt6tJliKORW9kRxv5JZgRz0ocPc?=
 =?us-ascii?Q?OI0ejJr2+EZhmdaOIvwDNvErPRWoRoA9KuBFPhYHsKjb2WiYqZNoGn2etNFA?=
 =?us-ascii?Q?BZh2pN81E/eDP/lVxcN/E8EBL9erPZkmK5hPYaTJ9EmdrFQ9vzzAHdxlqqhY?=
 =?us-ascii?Q?VumfcNfxIOIbwAUwcovk7xe5XhaiRVJ95q6HagyopUVYP/h+SsCNKhFRNeav?=
 =?us-ascii?Q?IzxHsQFdWJWbUP4tAq0mTN7y5CmBj79bowzMzpfwrtxPV9YieIMsLL54OH2E?=
 =?us-ascii?Q?CUnP4ilawEarzuZ/aSkP1WqaZ7RLixSMtdgdGmE9/yno9R9AFPwZhPJMdyMX?=
 =?us-ascii?Q?ejUuxzqOr3yY4QL8YwBxI98UVDFSbcRp+EL7fe/Yux/lnZtrbwuK89bz9yEQ?=
 =?us-ascii?Q?VWUOo4kBcUEX+XZiS/sm1JY/DilNMsB9xzhK3fSrQUpguvgH2SVNm/uFrww6?=
 =?us-ascii?Q?VsHzGp2FxmeUsOqcFAoqYSfcGN7yk63ra4AqgvY4lXDYqLBHds6vqkbOXQyF?=
 =?us-ascii?Q?w/YTN5gJlY0VG0Yz/sDpN1WhWFIMf0791ClVWKfSVKAegDU0D1PHJlpn/XuS?=
 =?us-ascii?Q?rDRxofpbIePTiy65j46f/brmIoWWKtHY737v1q4+zdRRK+rcmUdHMpqNTEQA?=
 =?us-ascii?Q?1b1NXjktgr9GngzqzDf2vKXu+8RmM/0hDdRVMqVjE6ghhMFe1Ts52bzV9uTg?=
 =?us-ascii?Q?UmoFfxGVs/IQEwdzJ8dXnYZNFTUDp3EpiZ9bxqaBSa3+/gKqgGC5ukWMAJbS?=
 =?us-ascii?Q?1UKEhP0OVuK/ZwXI9iAQ3PoKctgSRJUUoi6DjTzXvqb9IwE9pqnhtm4lLbtQ?=
 =?us-ascii?Q?KtiNtuFbhZO7WqAiljVYOyabDuIJ2DV5AMnA5A0o8/OWr03qD8Q2REn9sZix?=
 =?us-ascii?Q?WoLQtkNSeYMD92FxAhn6z78AOulUlmuPaISIUJPm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaaa4dd-661d-4e3f-c90b-08dc9521fb7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:20:36.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pR+L8L9MZU/58YzRK9JkpaIpS11gDwoFVqXGKr+vc2U39D9Jj3GkgKvYeZ5aiDy9MFcFPaiO8Szbb33RFEk2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7582
X-OriginatorOrg: intel.com

Hi Raghavendra,

On 2024-03-22 at 19:11:12 +0530, Raghavendra K T wrote:
> Optimizations are based on history of PIDs accessing VMA.
> 
> - Increase tasks' access history windows (PeterZ) from 2 to 4.
> ( This patch is from Peter Zijlstra <peterz@infradead.org>)
> 
> Idea: A task is allowed to scan a VMA if:
> - VMA was very recently accessed as indicated by the latest
>   access PIDs information (hot VMA).
> - VMA is shared by more than 2 tasks. Here whole history of VMA's
> access PIDs is considered using bitmap_weight().
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
> I will split the patset and post if we find this pathset useful
> going further. First patch is from PeterZ.
> 

This is a good direction I think. We did an initial test using autonumabench
THREADLOCAL on a 240 CPUs 2 nodes system. It seems that this patch does not
show obvious difference, but it shows a more stable result(less run-to-run
variance). We'll enable the Sub-Numa-Cluster to see if there is any difference.
My understanding is that, if we can extend the NR_ACCESS_PID_HIST further,
the THREADLOCAL could see more benefits, as each thread has its own VMA. Or maybe
make the length of VMA access history adaptive(rather than a fixed 4) could be
more flexible.
                                          numa_scan_orig    numa_scan_4_history
Min       syst-NUMA01_THREADLOCAL      388.47 (   0.00%)      397.43 (  -2.31%)
Min       elsp-NUMA01_THREADLOCAL       40.27 (   0.00%)       38.94 (   3.30%)
Amean     syst-NUMA01_THREADLOCAL      467.62 (   0.00%)      459.10 (   1.82%)
Amean     elsp-NUMA01_THREADLOCAL       42.20 (   0.00%)       44.84 (  -6.26%)
Stddev    syst-NUMA01_THREADLOCAL       74.11 (   0.00%)       60.90 (  17.81%)
CoeffVar  syst-NUMA01_THREADLOCAL       15.85 (   0.00%)       13.27 (  16.29%)
Max       syst-NUMA01_THREADLOCAL      535.36 (   0.00%)      519.21 (   3.02%)
Max       elsp-NUMA01_THREADLOCAL       43.96 (   0.00%)       56.33 ( -28.14%)
BAmean-50 syst-NUMA01_THREADLOCAL      388.47 (   0.00%)      397.43 (  -2.31%)
BAmean-50 elsp-NUMA01_THREADLOCAL       40.27 (   0.00%)       38.94 (   3.30%)
BAmean-95 syst-NUMA01_THREADLOCAL      433.75 (   0.00%)      429.05 (   1.08%)
BAmean-95 elsp-NUMA01_THREADLOCAL       41.31 (   0.00%)       39.09 (   5.39%)
BAmean-99 syst-NUMA01_THREADLOCAL      433.75 (   0.00%)      429.05 (   1.08%)
BAmean-99 elsp-NUMA01_THREADLOCAL       41.31 (   0.00%)       39.09 (   5.39%)

thanks,
Chenyu

