Return-Path: <linux-kernel+bounces-312080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D588A9691A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37139B21807
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7D1CDA10;
	Tue,  3 Sep 2024 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6u3g8hg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85E2AD02
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725332805; cv=fail; b=DHk1HKy8ZrrG6P9uhD2TE6a7FzWO8wxzBp2QzH6A+zSsZjSZLej0RCjBiAILf2H+wgUIsKjBT5zYpll1clXIay4hlBeiPAaHZivoPtcLuOkGzUsCH3tAxIy5NHwHYBrBEpmnpLnVcRyaOyfG3smCDJKXcJfWGmVBLej9R4HqdPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725332805; c=relaxed/simple;
	bh=44m84EsnJ8PjfyLKvvyYfvlWJCBnvw0sMBtsiKyqtgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kIftyfHv6k6rqfWbUa7oc/uMJDQMrwqZxyTCVDMJZKy6OWe82rGNqy7G/eTF2arae8HY1RDTXCuuKry41mKuv6T2dWmeOQLyO7s1GpX2D6uH8YEDXT7ziLJ8WmAAMejjnTXaCaVoctltW4kvy9OG6RkFxhrAPGmU+ytgXKijQiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6u3g8hg; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725332802; x=1756868802;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=44m84EsnJ8PjfyLKvvyYfvlWJCBnvw0sMBtsiKyqtgo=;
  b=h6u3g8hgTN2vHXvWhnRCv19NRsprts2b1FI5Cg13mYr9dvYht53pJUYc
   rWUyBwMvV5ndO55i/nJVsir7n8Q+Ak0TRKdGa/mCpHX4XTOnEje3AOOMM
   yqYgkWnpeWNT726hEd2F07Fv9M3pVJtNlrH1phvV5Z42zKhdzKpjhQmeT
   fXY+PSDerd5N3jEuAxLATF3aKzh9t07fknLlxvZYCA8Y/jEgBXork8Y7K
   5cb/XUfUC1xBCjFKfP2+GWhBvAleFL2vpP/sml7YqVbzOfICeRJriFoG/
   HdLHjdKSXUvl7R9cg29gyEq4ZUMmg2C3yKceTQIh3wKNxIA2Z9hVBArUl
   w==;
X-CSE-ConnectionGUID: UZY97j6gQTW9vci8xwglTA==
X-CSE-MsgGUID: /uhhfKTSSACMKvJdPys19A==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35277319"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="35277319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 20:06:41 -0700
X-CSE-ConnectionGUID: Y2hfy7A9SeCyrZsjfrsWDw==
X-CSE-MsgGUID: Kk5K/i1+QP6JANy0RFhpHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="69555698"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 20:06:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 20:06:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 20:06:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 20:06:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 20:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbyoBS6WYjF2j++T5OO9JUTL+gqURgbEQL9PdxkGIbu7IcvjSkc8mFobyilQUqQBNr2sqsjFMh3guD2NHvAX0KOb7F3tu8fCyzTMw2aveYFDH655quBG1y53nr8pEBe9bL3Xr2urLkotItmIsaCgorfKdC9tc34m/6v543BPNnnFSVsiybDzIZAWqGy0Nx5fVIao850CEFsdorfUKHay7OlxPHTZHlmGt6P/9FDIXjRwj16NLnZQKSUBdn35dj8AJKw+yCkji4hqdTbUe3IogpEIiyR9aFrcl/YOjHab0CpuPjAI06IpuxiPb7FGhkvgLpe05q6ZRntxrX13gyYH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sogfVOI8YXuQNAWE0dX20zu0OlZ6alfi+b9Yoq3BoCU=;
 b=mpp7AlaLaivIypxizVdMWWEhAS5cD9qFgGPlMvhlaDz73XIzzWqkMUPhnzkTwFa+QYXcjm5uEGWUwhfIl3Ix1Yqp7tF81HLUl9sPetjusjyC2ok3pl2obkHfX8X3BcBKvzy7OEYDrAiI1vTc91BqS7h8jMUbsZfGmDDZmFENLjSNSQDykSIpRt+UZzMBU30vJIyQ1w3zyIJZLD31UqQs8HZ3BQsLzSZC66rkmQ4c6wc/h16B0I9msJoc7V0iWyCcCEG1m7eSGoMrJPRpOqClEsyN9cgk9/MOV4suwuX6WX03ayS6p8fHmk1DgU4zHHn3vMwwiq/4HbUB8N4RYaxv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by LV8PR11MB8769.namprd11.prod.outlook.com (2603:10b6:408:204::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Tue, 3 Sep
 2024 03:06:38 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 03:06:37 +0000
Date: Tue, 3 Sep 2024 11:07:38 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox
	<willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
	<sidhartha.kumar@oracle.com>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa
	<olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, "Paul E . McKenney"
	<paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH v8 15/21] mm: Change failure of MAP_FIXED to restoring
 the gap on failure
Message-ID: <ZtZ9euGTU9T0PWDA@xpf.sh.intel.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-16-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830040101.822209-16-Liam.Howlett@oracle.com>
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|LV8PR11MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c20adb-c4e3-4e46-bce3-08dccbc56c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OrO1YGKoM0vj6LZFZ1jOUVR0PH6LODLOliK1bpOQyXj6fZjLyL5GkvhKDt/A?=
 =?us-ascii?Q?j2yceKOy1vOHiDCemzqhh6j27IpcVZxuEklABpM2kNnL/LTV6uRXp5Q+6+Wh?=
 =?us-ascii?Q?xeKD8k2SnaKes5XI7Ef0Bee+e2Kvmxl5qPaFhpDCFU2Hbs1XCly47mPNgMAV?=
 =?us-ascii?Q?7tASZorpXzrHy3i5xxg06ueV/HG4KUJgN4dP4I2J/q8x+ISnj60mRLSPLQpX?=
 =?us-ascii?Q?loZJLCnLT2NnhyrkYIDpC5JySgtJ243zzNmGjmB5nAVNSP2cxzZ6XB3/lznO?=
 =?us-ascii?Q?LHLag+ahQXehuHPmwn2SrqVERieiWX7VHMkIfmsQEd76AzywlHHtMbzCtKNI?=
 =?us-ascii?Q?e2Tb4oRkF/KyWgRmf3PxZKQpTP2Iydgv7aFTUbTjRVzyqN2+SbY4mejIU0fK?=
 =?us-ascii?Q?1pZauA5iBtoyLEWcWZUlRLpupsJR1sFSFtUd30BDgCaraPzGIf++MMVriKS9?=
 =?us-ascii?Q?/4bF889stcAVNOtdZYHcCOITh6rSsB0lpbeBZ3PfDYxmeDFs4dc11RAmpfN4?=
 =?us-ascii?Q?uevUsQuj2Lpmmd6rCMQMPS6MgX5xqybWt9ulna9ESKEkCwvLruickP3QH7hF?=
 =?us-ascii?Q?fFyvUhvbUitahfA8nkCkQQLcH2OF+Z27V0V5zy17ehTseEAxhdE884Y4aAbV?=
 =?us-ascii?Q?3WSi9yvVmfkX9lORdrtbsc/cb0AcUPBIHtukfIM+8PBOvPrDG1lCwN9joZeI?=
 =?us-ascii?Q?o9/Vd1/9+AutuZEWf3f/KooXNFUNnx80Rd7bgXd95dyf/3Na088RZ/cEaBvY?=
 =?us-ascii?Q?aFOiehf0wWFsI5IqRAnKawAMEDPe+9czN+UYxka7PgOXGrcVetSIGGZTgW/+?=
 =?us-ascii?Q?2I6z3D5E//5ktWMTC2wO4Gbx31yTBN9ULr9ynrrjomjGIp5uIo9El3vl3GTE?=
 =?us-ascii?Q?pSKR1cqy/MMrLASAFCLIxr5e4imt3mf7w8Pkl8OaIDXCm4pxWgZZ69ci1F0P?=
 =?us-ascii?Q?EQcZiHKkNImfiesiNkthzHErkj4VF5SoyZnBR3s8lB38W8Bn1V1lzG5l6RzA?=
 =?us-ascii?Q?ETduAM5jjVgbFBcWOe9QRmWSDK+SlCSaET59U+RjiLbCrZjhNsTqscmI0o17?=
 =?us-ascii?Q?lp4e1aan9ZilEKY81FtDAU8SBpzXkw1bRHI4ykH98SdzKqaROWQ8oM7bFRAW?=
 =?us-ascii?Q?1UehMETLGl1A3nNOr0KWmnvo29QkCXi3Uo5WuGxhl3QQnJiAcF6SMwrbjIHQ?=
 =?us-ascii?Q?AZDVKbQkv3EEqvjQYUBA74ELXX0+fkHvWtADtaEkh4HzYlWNo3Xb2GyHYAG/?=
 =?us-ascii?Q?WzSbsfC60Ijov1lBMvGS1JNf3bT5lbX9TX0/W2UfFTi7N8rD7e7q6GYKGqUB?=
 =?us-ascii?Q?4Ww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yq/WV2SRQkxeWr2U0CSfFhvIX80RBhLGbyVlcuALlyD0I5ZOGf+x4mz/vAv6?=
 =?us-ascii?Q?5NKdLf4KfEOEdk4e87ESgJu3kBemodkIHy/4rSEEmJlyLxfBKHk7nGLj4jgV?=
 =?us-ascii?Q?pHKTbkivK/DwSt95A9jY9WsNlgdJSEJ8p1EDu7g+SNiP9Z5u1bCdwFdJE7A6?=
 =?us-ascii?Q?9cEXInebbeitU9scwBl5o5f22WpqPuKTjM4PiWuNl00RuouMHAsgEWxU5iIq?=
 =?us-ascii?Q?Zyg9JNWseDA0KDcLVEjzcvLhEzhAOBgVY1ORSgQOVxY8i3LruJIcka5Su1qI?=
 =?us-ascii?Q?1GAvXg41n4tTigCNrsYOkTkVU1hMiC6QkB5rxSFyEO8OW+tVYIivCqEO6nz3?=
 =?us-ascii?Q?jpnX1NVAdFlqAsmvqU1bjlPgUTse238iiG/T7hQlQgh2brF/EE6+YiWW5by4?=
 =?us-ascii?Q?lHRJO0luwhRRcZYatIMJtWFG9jsnFd/c4F94WL4+5Fv9jvw1Lq7RADOOJH4L?=
 =?us-ascii?Q?7lTvOu189ovWDMJwMLKQ9pPWE4rOJuqIEhzVsVwim0DBN2Kv1DBW5oPczj1n?=
 =?us-ascii?Q?Kde6aRWsfgNCKfU3l01bR/kIwcZBRXPXVUutpLpCA2fzuKPGRGOCMVTTCnFj?=
 =?us-ascii?Q?bX4I2vBa7Qewg1bDRPFAMKWvSkEFyLQndFBNgZFV97jdNmjvb9cthQfhNylS?=
 =?us-ascii?Q?KVZ2vpc74prvDYu1UGh6pzHK7ga7zsUp8yAxoJpTJcOWJSCzZMs5aAV7SRdW?=
 =?us-ascii?Q?EXunsqo+cIL1nZO830E4d3EX4dwCQ6GZeJj8sPLpKuvYQj7ELRVci7NAS9iE?=
 =?us-ascii?Q?uiXH8JPnFwvqApAM0v58Tb5pOaKfxC1Ixd2qgrTiY8SG2IK9lfGB8FP5snzr?=
 =?us-ascii?Q?sK9O2Wd/fxXcwjstkgUviwIXWpKQmn9V+Z/Va7z0unEvPaA/fKASBo2TpUNd?=
 =?us-ascii?Q?VX+KntehRWowMrgzsC33clUM+UG8hbRLk8JIS+/6ZKmXhKakZ1OIgvV3c+29?=
 =?us-ascii?Q?e5iB8M6qpViPm6yy7YzzsadxbdteFgzJOZQylnoaurdqvNunHst5aa4o0Ani?=
 =?us-ascii?Q?s1rCH1AGpLyOnNncV9u54cwXsghHIAaNV2dpb8PGGFBmWYHE2Glr5Q4An+ee?=
 =?us-ascii?Q?yWfh+KqG55DdyMmydAzqGVQWTcUsqg/eMYGhmZ0Buy+ecuIXeTuOwdd9SJYI?=
 =?us-ascii?Q?FWk/PY0oJtzKnJl8BucV3YbD4354QnJmBAuQfx5wwx8QYulj/w2fs5/hsqXR?=
 =?us-ascii?Q?CUMbJmACDBQ/dbDdsxhU7TA0rVqqQMMUOtJOEtKd+5hrkE6lhzKqLosuiODc?=
 =?us-ascii?Q?9YOUOjJkP6iBS6xdYyrphBsNWuq284Nun2IUtUEieAuWiv+dL+A0HvYSsu7t?=
 =?us-ascii?Q?zvVXZx4QjLNUjTGe77oUQxEpL4WHdq71I03N11KrRJUV+a0TRLKIJ9E+FBfS?=
 =?us-ascii?Q?dxSWcOIIts+PHq2G5i6FzG3XTB2/pl+FDinKfvRHyZIqMhEk+ZEhJyTOtphI?=
 =?us-ascii?Q?iKPeSdzBDPNMHWzzKgWzbxNCT1++0dN8+VdKXtZKGOPcr9gWAI8NnzqHp+Gb?=
 =?us-ascii?Q?Ljhovr5bTfJvbA7MM/pjfFb0jNbW3YJ2iBzgq9Z2BrWvGy6bodAN4f20GvAC?=
 =?us-ascii?Q?Lh1bFFhZDzrfVsQouQ44HV6r12olxVo2MoXOBW3W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c20adb-c4e3-4e46-bce3-08dccbc56c9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 03:06:37.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HInke/u9hgZFwLhCRik5PRwF6kb+5ZSqOhyOkz02UWVoBf3HaVAqAhjpaFh/+DiSOs/+7Z0Sy13AxrNJnyBFQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8769
X-OriginatorOrg: intel.com

Hi Liam R. Howlett,

Greetings!

There is WARNING in __split_vma in next-20240902 in syzkaller fuzzing test.
Bisected and found first bad commit:
"
3483c95414f9 mm: change failure of MAP_FIXED to restoring the gap on failure
"
It's same as below patch.
After reverted the above commit on top of next-20240902, this issue was gone.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240903_092137___split_vma
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/bisect_info.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240903_092137___split_vma/bzImage_ecc768a84f0b8e631986f9ade3118fa37852fef0.tar.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240903_092137___split_vma/ecc768a84f0b8e631986f9ade3118fa37852fef0_dmesg.log

And "KASAN: slab-use-after-free Read in acct_collect" also pointed to the
same commit, all detailed info:
https://github.com/xupengfe/syzkaller_logs/tree/main/240903_090000_acct_collect

"
[   19.953726] cgroup: Unknown subsys name 'net'
[   20.045121] cgroup: Unknown subsys name 'rlimit'
[   20.138332] ------------[ cut here ]------------
[   20.138634] WARNING: CPU: 1 PID: 732 at include/linux/maple_tree.h:733 __split_vma+0x4d7/0x1020
[   20.139075] Modules linked in:
[   20.139245] CPU: 1 UID: 0 PID: 732 Comm: repro Not tainted 6.11.0-rc6-next-20240902-ecc768a84f0b #1
[   20.139779] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   20.140337] RIP: 0010:__split_vma+0x4d7/0x1020
[   20.140572] Code: 89 ee 48 8b 40 10 48 89 c7 48 89 85 00 ff ff ff e8 8e 61 a7 ff 48 8b 85 00 ff ff ff 4c 39 e8 0f 83 ea fd ff ff e8 b9 5e a7 ff <0f> 0b e9 de fd ff ff 48 8b 85 30 ff ff ff 48 83 c0 10 48 89 85 18
[   20.141476] RSP: 0018:ffff8880217379a0 EFLAGS: 00010293
[   20.141749] RAX: 0000000000000000 RBX: ffff8880132351e0 RCX: ffffffff81bf6117
[   20.142106] RDX: ffff888012c30000 RSI: ffffffff81bf6187 RDI: 0000000000000006
[   20.142457] RBP: ffff888021737aa0 R08: 0000000000000001 R09: ffffed100263d3cd
[   20.142814] R10: 0000000020ff9000 R11: 0000000000000001 R12: ffff888021737e40
[   20.143173] R13: 0000000020ff9000 R14: 0000000020ffc000 R15: ffff888013235d20
[   20.143529] FS:  00007eff937f9740(0000) GS:ffff88806c500000(0000) knlGS:0000000000000000
[   20.144308] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.144600] CR2: 0000000020000040 CR3: 000000001f464003 CR4: 0000000000770ef0
[   20.144958] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.145313] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   20.145665] PKRU: 55555554
[   20.145809] Call Trace:
[   20.145940]  <TASK>
[   20.146056]  ? show_regs+0x6d/0x80
[   20.146247]  ? __warn+0xf3/0x380
[   20.146431]  ? report_bug+0x25e/0x4b0
[   20.146650]  ? __split_vma+0x4d7/0x1020
[   20.146864]  ? report_bug+0x2cb/0x4b0
[   20.147070]  ? __split_vma+0x4d7/0x1020
[   20.147281]  ? __split_vma+0x4d8/0x1020
[   20.147492]  ? handle_bug+0xf1/0x190
[   20.147756]  ? exc_invalid_op+0x3c/0x80
[   20.147971]  ? asm_exc_invalid_op+0x1f/0x30
[   20.148208]  ? __split_vma+0x467/0x1020
[   20.148417]  ? __split_vma+0x4d7/0x1020
[   20.148628]  ? __split_vma+0x4d7/0x1020
[   20.148845]  ? __pfx___split_vma+0x10/0x10
[   20.149068]  ? __kasan_check_read+0x15/0x20
[   20.149300]  ? mark_lock.part.0+0xf3/0x17b0
[   20.149535]  ? __kasan_check_read+0x15/0x20
[   20.149769]  vms_gather_munmap_vmas+0x178/0xf70
[   20.150024]  do_vmi_align_munmap+0x26e/0x640
[   20.150257]  ? __pfx___lock_acquire+0x10/0x10
[   20.150500]  ? __pfx_do_vmi_align_munmap+0x10/0x10
[   20.150758]  ? __this_cpu_preempt_check+0x21/0x30
[   20.151018]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   20.151308]  ? mtree_range_walk+0x728/0xb70
[   20.151602]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   20.151891]  ? mas_walk+0x6a7/0x8b0
[   20.152096]  do_vmi_munmap+0x202/0x400
[   20.152307]  __vm_munmap+0x182/0x380
[   20.152509]  ? __pfx___vm_munmap+0x10/0x10
[   20.152729]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   20.153061]  ? lockdep_hardirqs_on+0x89/0x110
[   20.153299]  ? trace_hardirqs_on+0x51/0x60
[   20.153533]  ? __audit_syscall_entry+0x39c/0x500
[   20.153790]  __x64_sys_munmap+0x62/0x90
[   20.154001]  x64_sys_call+0x198f/0x2140
[   20.154212]  do_syscall_64+0x6d/0x140
[   20.154414]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   20.154683] RIP: 0033:0x7eff9343ee5d
[   20.154885] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
[   20.155872] RSP: 002b:00007ffe28711628 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
[   20.156267] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007eff9343ee5d
[   20.156635] RDX: ffffffffffffff80 RSI: 0000000000001000 RDI: 0000000020ffc000
[   20.157002] RBP: 00007ffe28711640 R08: 0000000000000000 R09: 00007ffe28711640
[   20.157369] R10: 0000000000000003 R11: 0000000000000206 R12: 00007ffe287117d8
[   20.157737] R13: 00000000004027cc R14: 0000000000404e08 R15: 00007eff93844000
[   20.158122]  </TASK>
[   20.158245] irq event stamp: 2019
[   20.158426] hardirqs last  enabled at (2027): [<ffffffff814629e4>] console_unlock+0x224/0x240
[   20.158869] hardirqs last disabled at (2034): [<ffffffff814629c9>] console_unlock+0x209/0x240
[   20.159306] softirqs last  enabled at (1954): [<ffffffff81289969>] __irq_exit_rcu+0xa9/0x120
[   20.159797] softirqs last disabled at (2051): [<ffffffff81289969>] __irq_exit_rcu+0xa9/0x120
[   20.160233] ---[ end trace 0000000000000000 ]---
"

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.

Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!


On 2024-08-30 at 00:00:55 -0400, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Prior to call_mmap(), the vmas that will be replaced need to clear the
> way for what may happen in the call_mmap().  This clean up work includes
> clearing the ptes and calling the close() vm_ops.  Some users do more
> setup than can be restored by calling the vm_ops open() function.  It is
> safer to store the gap in the vma tree in these cases.
> 
> That is to say that the failure scenario that existed before the
> MAP_FIXED gap exposure is restored as it is safer than trying to undo a
> partial mapping.
> 
> Since abort_munmap_vmas() is only reattaching vmas with this change, the
> function is renamed to reattach_vmas().
> 
> There is also a secondary failure that may occur if there is not enough
> memory to store the gap.  In this case, the vmas are reattached and
> resources freed.  If the system cannot complete the call_mmap() and
> fails to allocate with GFP_KERNEL, then the system will print a warning
> about the failure.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c |  3 +--
>  mm/vma.c  |  4 +--
>  mm/vma.h  | 80 ++++++++++++++++++++++++++++++++++++++++---------------
>  3 files changed, 61 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 405e0432c78e..e1e5c78b6c3c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1623,8 +1623,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_unacct_memory(charged);
>  
>  abort_munmap:
> -	if (vms.nr_pages)
> -		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
> +	vms_abort_munmap_vmas(&vms, &mas_detach);
>  gather_failed:
>  	validate_mm(mm);
>  	return error;
> diff --git a/mm/vma.c b/mm/vma.c
> index 648c58da8ad4..d2d71d659d1e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -878,7 +878,7 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  munmap_gather_failed:
>  end_split_failed:
>  modify_vma_failed:
> -	abort_munmap_vmas(mas_detach, /* closed = */ false);
> +	reattach_vmas(mas_detach);
>  start_split_failed:
>  map_count_exceeded:
>  	return error;
> @@ -923,7 +923,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>  
>  clear_tree_failed:
> -	abort_munmap_vmas(&mas_detach, /* closed = */ false);
> +	reattach_vmas(&mas_detach);
>  gather_failed:
>  	validate_mm(mm);
>  	return error;
> diff --git a/mm/vma.h b/mm/vma.h
> index 64b44f5a0a11..b2306d13d456 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -82,6 +82,22 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	       unsigned long start, unsigned long end, pgoff_t pgoff);
>  
> +static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> +			struct vm_area_struct *vma, gfp_t gfp)
> +
> +{
> +	if (vmi->mas.status != ma_start &&
> +	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> +		vma_iter_invalidate(vmi);
> +
> +	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> +	mas_store_gfp(&vmi->mas, vma, gfp);
> +	if (unlikely(mas_is_err(&vmi->mas)))
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_MMU
>  /*
>   * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> @@ -129,24 +145,60 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach, bool mm_wr_locked);
>  
>  /*
> - * abort_munmap_vmas - Undo any munmap work and free resources
> + * reattach_vmas() - Undo any munmap work and free resources
> + * @mas_detach: The maple state with the detached maple tree
>   *
>   * Reattach any detached vmas and free up the maple tree used to track the vmas.
>   */
> -static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
> +static inline void reattach_vmas(struct ma_state *mas_detach)
>  {
>  	struct vm_area_struct *vma;
>  
>  	mas_set(mas_detach, 0);
> -	mas_for_each(mas_detach, vma, ULONG_MAX) {
> +	mas_for_each(mas_detach, vma, ULONG_MAX)
>  		vma_mark_detached(vma, false);
> -		if (closed && vma->vm_ops && vma->vm_ops->open)
> -			vma->vm_ops->open(vma);
> -	}
>  
>  	__mt_destroy(mas_detach->tree);
>  }
>  
> +/*
> + * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
> + * operation.
> + * @vms: The vma unmap structure
> + * @mas_detach: The maple state with the detached maple tree
> + *
> + * Reattach any detached vmas, free up the maple tree used to track the vmas.
> + * If that's not possible because the ptes are cleared (and vm_ops->closed() may
> + * have been called), then a NULL is written over the vmas and the vmas are
> + * removed (munmap() completed).
> + */
> +static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach)
> +{
> +	struct ma_state *mas = &vms->vmi->mas;
> +	if (!vms->nr_pages)
> +		return;
> +
> +	if (vms->clear_ptes)
> +		return reattach_vmas(mas_detach);
> +
> +	/*
> +	 * Aborting cannot just call the vm_ops open() because they are often
> +	 * not symmetrical and state data has been lost.  Resort to the old
> +	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
> +	 */
> +	mas_set_range(mas, vms->start, vms->end);
> +	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
> +		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
> +			     current->comm, current->pid);
> +		/* Leaving vmas detached and in-tree may hamper recovery */
> +		reattach_vmas(mas_detach);
> +	} else {
> +		/* Clean up the insertion of the unfortunate gap */
> +		vms_complete_munmap_vmas(vms, mas_detach);
> +	}
> +}
> +
>  int
>  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		    struct mm_struct *mm, unsigned long start,
> @@ -299,22 +351,6 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
>  	return mas_prev(&vmi->mas, min);
>  }
>  
> -static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> -			struct vm_area_struct *vma, gfp_t gfp)
> -{
> -	if (vmi->mas.status != ma_start &&
> -	    ((vmi->mas.index > vma->vm_start) || (vmi->mas.last < vma->vm_start)))
> -		vma_iter_invalidate(vmi);
> -
> -	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> -	mas_store_gfp(&vmi->mas, vma, gfp);
> -	if (unlikely(mas_is_err(&vmi->mas)))
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -
>  /*
>   * These three helpers classifies VMAs for virtual memory accounting.
>   */
> -- 
> 2.43.0
> 

