Return-Path: <linux-kernel+bounces-425284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A75C9DBFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1012818FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5F156886;
	Fri, 29 Nov 2024 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvdiS2s/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA9158531
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732866609; cv=fail; b=C/2gOc9JXAm5qLYqaDctbOS8ZBm5As0Yfln1YDXAEO6ucOnNrCL3CKsIpseclUZYB17cng2atejDyrDMQ6jSwAFmPYMbT5GWUB9jkovZkrc9J0lvSjYYH0npHd3UGNJs4YFhBg+v9nyIS7oSY/BObDq45jW0mxfkg4YcahfQMO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732866609; c=relaxed/simple;
	bh=COl1uzMqW8iuNZAUk1eoJ8mGsSWwBTMe0CgsxPNhCUc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PRWFnlg6uqB1+hA/SHkhNWRR4cm9l1/8B4jEzfDAZ0ltfmOsANDs3XTOTZaHimRB1+/sHnXZ7xA18nrrFws+Ll/ALlh30DTDNTJfye9bG74iiM0etIrogECOAR4vMcCr906WD8xJLWSsP187g4RvGVtVRCPHjihpDk8/I2kwbyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvdiS2s/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732866608; x=1764402608;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=COl1uzMqW8iuNZAUk1eoJ8mGsSWwBTMe0CgsxPNhCUc=;
  b=KvdiS2s/S2z/GPaCEeEAARszG5YU7tkPtTqPquz6uvVFuRkI53ht9BWa
   2zNBnGE7LMA3x9K39qOctAsUd/ldVQgg3Cjumj9qwWc23nD+Ct215XzDv
   KwCkOsplDkveIREqf+9yFucFl4OU5ziZ1PsWK+gDoP/TqF3JnXW22cmoa
   mj6z0E5mxqZyNn4dwqvHtQ2zC6R3WXD8wH5h5O3AXSp6g2/I9uOVMWj3h
   mss0lke0R76I8jaIApTsQ3xvMm+81msYY9SZPRS3TjGqMVW9bW+e0Y8Pz
   0Uc4eOOwB6xakONFS5dVN9JDBy6kIhF8h590z+0u7LR3xnaKvsrtL5SGY
   w==;
X-CSE-ConnectionGUID: OCAHWP0jQ0StbTkHJzjhHA==
X-CSE-MsgGUID: HmUKFBGzRr+WI+dcOz1Qxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33030492"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33030492"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 23:49:59 -0800
X-CSE-ConnectionGUID: gvXDv6IZQdqOJeUQ068WUQ==
X-CSE-MsgGUID: LaUj7rYGQzKrt0FnlMuRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="97392288"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2024 23:49:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 23:49:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 28 Nov 2024 23:49:58 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 23:49:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCEIG6+8D/d/5LcvKX1c4p8nQkGtXrZIRONpwznpg9W4UnMb/GB/mVWZ4y503IABFr22FTtzhUZFS8ZbeJv8DKG/Ljydiaq2w3DKdvJ5+LTp7y+gmwvrrLqtHZ+IGp5kR3ll2cot3Pi0v/SRzM4Jr497DuY98Z8hzEx+YezOqJ3du2MrbBTj7iFjw7YP79aQzosvpv7BwINQAN1DTIYjWSKilX3d26DSRIgYDdNrRp41KZEXC3I91BX8YjQ9V8kOi4uk79FzKXXAcsNL7AfPKjOEQXMSy4IvDH1WOaGLCyr9Fu4r9Nw9uvCCV9Be0uBeur2k6hYA+sSD3BvdqIE7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23tVV5WDozEW/GUPn8PGk9MRquaDyr9oweLY1sajhaM=;
 b=Ju0FOGVDj78ycLLBbInhP+Ffmywx/xmXOXJrU+qKgKQwrsj3HuQS1j6ZRH4u4SlyKoPbPOqljMz9ofxEJiHFo9j9p4sjbE67Hf3n7EVDG1gWyGQydjIHVOx2TVYsPYO9XV1RIgClcrH9JQSJz5wf65Jtc+0aoUNBoTnVC+Qh+P09GTETpgCG8fcQhjAkruJwcJ+MiLP/1Txq1+N8FdYftw3WQf1lXEstMmrhKfAOjEKbzGs+liuarJNQEpILsHsaDAEaJMR5yZsS9CIKHKlnbEKKsRDXxMYhYDIrufmbEV+oY98QwKr0T3tbq6Oq9oqndVoMkApxoACmWxjMvoDx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 07:49:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 07:49:55 +0000
Date: Fri, 29 Nov 2024 15:49:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yin Fengwei <fengwei.yin@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
	"Kefeng Wang" <wangkefeng.wang@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, Minchan Kim <minchan@kernel.org>, Vishal Moola
	<vishal.moola@gmail.com>, "Yang Shi" <shy828301@gmail.com>,
	<linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [madvise]  2f406263e3:  stress-ng.mremap.ops_per_sec
 6.7% regression
Message-ID: <202411291513.ad55672a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff3f98b-ff8a-4136-bdee-08dd104a6a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?HB2ob4dGvgYlqzizI+Ldb3nMSALdWR7ClJ8VBgnbMPyA5vyqaYfqdVKBWw?=
 =?iso-8859-1?Q?aaCUaHbzugGG35fsC+ERi+QC0J8wLjjgkyPvjxujso8qIyXe9D0FxNpHku?=
 =?iso-8859-1?Q?G99j9tH2zSX1t7o2oa7pn9CKuwHaOVq4DBZ0wxgiJVGkK1KXpd2TQr18Lg?=
 =?iso-8859-1?Q?cWBHNoHqF3I6VbPTYyhbjSt2zDtDpLzg0xlR1D/Nn/rf3fvi74F4qj7295?=
 =?iso-8859-1?Q?14ljTHEzdLIOOILxIkY6+6w9nwVnzm3fRIv2KGei+6Pzn4xODW1FXvYFzR?=
 =?iso-8859-1?Q?s8Htf6SqahSqcWXjL8D9BS5v7udD2U/OWUeHBk7OAAnHvyN8h7x0YTbhKQ?=
 =?iso-8859-1?Q?awb810bgB8384rHFIMMxYqDSYjQW5UJZsYGUzAc22aRKuuhXSpLaqaehAI?=
 =?iso-8859-1?Q?q7DQHaYNOp+t0ZgfaaFi0ljHllupgJK2tJTeCR6c8yx6TpG0YaJP6OE+4F?=
 =?iso-8859-1?Q?q+BfP+n+REsoA2RrREf3rXhMj/9ohTrSjSR8qkG/Qnp29RIdnXpA22vUhl?=
 =?iso-8859-1?Q?T3H/BWVFmw9/24kVEpDciCmG4WtKkNIW+IWghMlMxgo0zxjYgZyGxenL7J?=
 =?iso-8859-1?Q?mz78GLAa+9J/U2gGtUaZOJ3Kzq9tn0YLAxN+QhBv5FjnWll6Bn4HPYAfmK?=
 =?iso-8859-1?Q?bqPUtT5+LHAvq9U1mD/JzUPwtOyQiX2sRMyZDS5XFvQsecrV+2ECc97iBH?=
 =?iso-8859-1?Q?j3e4f0FdWZ1jxZj932DWhtIwR3LqVRPi9nv6Q/r/QzzBDd+LNpdEdhoxET?=
 =?iso-8859-1?Q?OppDL9zzyXvaPjo6oL/yqvb9jlLiySib+s0ixGaDJtxVlCS7bbZFnk59ts?=
 =?iso-8859-1?Q?jy5dydXXrPdDAEwkSybwfGnz07HQlFM4LViZXLx7v9XZQSQwjPVJ9NhBNt?=
 =?iso-8859-1?Q?akeg3awTxiJxGuQC0PK9jL8SjyhAggP9Y6Up1ifUlm0Wlw8z66UYtZWblQ?=
 =?iso-8859-1?Q?Ix5V6fGf0p/L45oijswkQlcsnOJk33XfZlsYAdi+30ulzL7YGhfz+xPdVx?=
 =?iso-8859-1?Q?1AZi2pU6dkFz5TD6CZ3WSR+qLiSaaxk/41w3OFfF25fKnkseUVYXiq5OVk?=
 =?iso-8859-1?Q?99uQDAWEjLaUzPxcmM4LUpK0dvjrssEEV2PSWcOIVKfqR6SXi5AdkhM3gm?=
 =?iso-8859-1?Q?Ei4305GJ9xyYcHnb5J5Vj7e6gkuJWEaygGHqXxWC/DGoHkedSZAQhbzBR+?=
 =?iso-8859-1?Q?6ybSuyePeK7qLrWrIA6se54yi2o4kuSC8YoF/6rGSMJQ5FvqGPU0Vqx+36?=
 =?iso-8859-1?Q?8yeLmH/X2EEkZmBkyu2mSKqD4YR1B9J9SznLF8HyEdusv+o/swzNJY7qv4?=
 =?iso-8859-1?Q?iPFXrP5Qyhh/W0J7t+2hh20+eFoIGbn2AsHyw849UKW2Bhz+g2UDkvqYzv?=
 =?iso-8859-1?Q?bWsdJTE93V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?D0pYhSv7cLOL7oqRrBJKTVtzKrWXJcHf2Hp+HwjbvJaz7BM04SotkuU+zS?=
 =?iso-8859-1?Q?Ua6viyOgL1EFw4K9u+ljpDQISoFUa9jaubmWaNGKpW99bEL+xUyaeSG8xQ?=
 =?iso-8859-1?Q?hghSeznJizCcBq13mMsD7snBMPQh/irJL/G6dR9hOz7c2TiV1585QNWngM?=
 =?iso-8859-1?Q?PSIAKQn4XO6Wev4rPeE3kkMwyjbXisSMf1w/naw7n5C5b06C48aDDfyqF9?=
 =?iso-8859-1?Q?ub+rgWRCjq0p9Mq5GdyX3yRFE3+JjN5+oV+JSBEk76ioXVk7fIJP9Uno+c?=
 =?iso-8859-1?Q?Se8aySAXb808QMU7dgPydx+I4p39UCkCBpDKsVMnFhI6ogi8RXXUH7iL/5?=
 =?iso-8859-1?Q?xD2a+FY9rPBkd0BAsxuwj5ZecnDb3oECINCryuWZHYTf7XegZO8uT6kzF+?=
 =?iso-8859-1?Q?3xWrj+GRjXGOPHX1Qqrn4hRfIvZVMBE9v6sOqSUlevlprCG0xfF53IO3SM?=
 =?iso-8859-1?Q?KrHRYDFy8OSFAjlDemc9ffzfMvuOKDy73GKkzik4qFp70WgWyu1kjAoMEv?=
 =?iso-8859-1?Q?a0ZGaiXe2QulQJwijr2gRrPmmCt9JpLfCVuMTYrc3duHG6TRSj9Jfx4efZ?=
 =?iso-8859-1?Q?zwxSm4Qb41oV9xfQbLhb+/WZ7MvFkw9McCXdPnrf5MosmPScqRpP4KtQeq?=
 =?iso-8859-1?Q?B7irUtmbmejEK5cEiAX989Udv6HdVuxpkwSYeQfE1e9zbD9zE4tpXAC18Q?=
 =?iso-8859-1?Q?h8VeRoz7lLA2BPYVOoJ4e6kHIdiHeY2+vUI0CBjcaH2LV6QDJhgOQJ5lc/?=
 =?iso-8859-1?Q?wdGq4dciA3Qn9FkpdDCT++PnQmRWY5OVIeHFVrDdGXTWnHfs/YXotBXIF0?=
 =?iso-8859-1?Q?ckVMhoLKabMIeefbRWEkVcK4PjTbNteE6ipq/SDSwSexE/pWhAyubCiyqU?=
 =?iso-8859-1?Q?uCZkoLh7eQHZptgcXuDjddNnouD4p1so9y/n+UDsJIm2jagCBaxN8ldcx7?=
 =?iso-8859-1?Q?EaDwBgq648uyuG6mPzSn+mxzr+A+OH16xlX8Vl7E03P2+PiM/cnsTaamV4?=
 =?iso-8859-1?Q?8ftAwLWNTgVE4/C49E1tKrc/Pl+fSs+ZVVYTC0tbgJ5tJ0Vk1FrIFIzh/M?=
 =?iso-8859-1?Q?FIRGuupqXxKidqWL4YSKONRE9QBLdmIAnRuD/dAs3zUZKWjMt7qBkUxP3K?=
 =?iso-8859-1?Q?Ode3oDBpwUJZwjwRzFm0dKSKrqNSQmmPsU3Kw08Na9i/jtl84g+Ma5wDgi?=
 =?iso-8859-1?Q?RkiwZykzbS3XMLWpFYd/sF5dn9JKCKOat6xGtQ/1QPrFWYaOXl50NyFI8D?=
 =?iso-8859-1?Q?qhjuW/jeWxLFZ62HmXCbQu2H3Qm/5U1FpfAxpyFljGewew5qWOFC3jc7RV?=
 =?iso-8859-1?Q?6KyUSct93XzuQn3owp0GYkDQnW3+zReyKDoKkpcfI3XcHfKeMY+cmadqC1?=
 =?iso-8859-1?Q?XBw0BbWKk4/wirjWPfln8FBxrXNvN2Wwqv5PvdR+53GXr2bryeFmEOYG40?=
 =?iso-8859-1?Q?8DbIQlC3pX3+eMBA7teS9qtdhylrb9uugzamPcbyIUG54LvWUg+lP6hXpj?=
 =?iso-8859-1?Q?nhT1KXIKKUAvm3OSKHzBMpHobVj5hHF/Nt9tXtAmahRgWt7qcQIqjZEYFX?=
 =?iso-8859-1?Q?4ZV+KGdn92b6NFiOQcHo6F/GsNaby0mFMLMdctiPTOuiPJfTfzo5LS4vCW?=
 =?iso-8859-1?Q?ObgBtvpUkq88hxcKz7C88oZTNQBJQYuNxRvWe1QFvM8CghdKi8BSm/Lw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff3f98b-ff8a-4136-bdee-08dd104a6a59
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 07:49:55.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMFtRG0krAFnlpCc2PSDLFHgunFPpfWOBPkDnzQ6vn8gQxmJq1JGRHij/OKcHW+fASvgOw+jUWBtEHWqTC3pAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.7% regression of stress-ng.mremap.ops_per_sec on:


commit: 2f406263e3e954aa24c1248edcfa9be0c1bb30fa ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on fix commit cc864ebba5f612ce2960e7e09322a193e8fda0d7]

testcase: stress-ng
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: mremap
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411291513.ad55672a-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241129/202411291513.ad55672a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/mremap/stress-ng/60s

commit: 
  6867c7a332 ("mm: multi-gen LRU: don't spin during memcg release")
  2f406263e3 ("madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check")

6867c7a3320669cb 2f406263e3e954aa24c1248edcf 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     36.80 ±  7%      +4.1       40.91        mpstat.cpu.all.sys%
    325.67 ± 44%    +119.1%     713.67 ± 13%  perf-c2c.HITM.local
     63.83 ± 67%    +175.7%     176.00 ± 20%  perf-c2c.HITM.remote
      9.59 ± 19%     -36.7%       6.07 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      0.02 ±  9%     +48.0%       0.03 ± 30%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±  3%     +73.9%       0.03 ± 20%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    936.50 ± 27%     +49.9%       1403 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.shrink_folio_list.reclaim_folio_list.reclaim_pages.madvise_cold_or_pageout_pte_range
    374720 ±  2%      -6.7%     349433        stress-ng.mremap.ops
      6245 ±  2%      -6.7%       5823        stress-ng.mremap.ops_per_sec
 2.353e+08 ±  2%      -6.8%  2.194e+08        stress-ng.time.minor_page_faults
      2213 ±  4%      -7.0%       2057        stress-ng.time.user_time
  2.22e+08 ±  2%      -6.8%  2.069e+08        proc-vmstat.numa_hit
 2.219e+08 ±  2%      -6.8%  2.067e+08        proc-vmstat.numa_local
 4.117e+08 ±  2%      -6.7%  3.842e+08        proc-vmstat.pgalloc_normal
 2.357e+08 ±  2%      -6.7%  2.198e+08        proc-vmstat.pgfault
 4.115e+08 ±  2%      -6.7%   3.84e+08        proc-vmstat.pgfree
    350460 ±  2%      -6.8%     326755        proc-vmstat.thp_deferred_split_page
    374783 ±  2%      -6.7%     349496        proc-vmstat.thp_fault_alloc
     24286 ±  2%    +278.1%      91836 ± 39%  proc-vmstat.thp_split_page
    374810 ±  2%      -6.7%     349527        proc-vmstat.thp_split_pmd
     24286 ±  2%      -6.5%      22708        proc-vmstat.thp_swpout_fallback
  1.69e+09 ±  2%      -6.1%  1.587e+09        perf-stat.i.cache-references
      4.37            +1.7%       4.44        perf-stat.i.cpi
    203.06 ±  3%     -12.2%     178.34 ±  4%  perf-stat.i.cpu-migrations
 4.438e+10            -1.5%  4.372e+10        perf-stat.i.instructions
      0.23            -1.6%       0.23        perf-stat.i.ipc
      4.38            +1.7%       4.46        perf-stat.overall.cpi
    171.29 ±  4%      +5.7%     180.97        perf-stat.overall.cycles-between-cache-misses
      0.23            -1.7%       0.22        perf-stat.overall.ipc
 1.664e+09 ±  2%      -6.2%  1.562e+09        perf-stat.ps.cache-references
    199.46 ±  3%     -12.3%     174.85 ±  5%  perf-stat.ps.cpu-migrations
 4.368e+10            -1.5%    4.3e+10        perf-stat.ps.instructions
 2.688e+12            -1.9%  2.637e+12        perf-stat.total.instructions
      7.77 ±  2%      -0.3        7.46 ±  3%  perf-profile.calltrace.cycles-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.__get_user_pages.populate_vma_page_range
      7.63 ±  2%      -0.3        7.32 ±  3%  perf-profile.calltrace.cycles-pp.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.__get_user_pages
      7.26 ±  2%      -0.3        6.98 ±  3%  perf-profile.calltrace.cycles-pp.clear_page_erms.clear_huge_page.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.26 ±100%      +0.7        0.92 ± 20%  perf-profile.calltrace.cycles-pp.folio_isolate_lru.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range.walk_p4d_range
      0.00            +0.8        0.78 ± 22%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.folio_lruvec_lock_irq.folio_isolate_lru.madvise_cold_or_pageout_pte_range
      0.00            +0.8        0.81 ± 22%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.folio_lruvec_lock_irq.folio_isolate_lru.madvise_cold_or_pageout_pte_range.walk_pmd_range
      0.00            +0.8        0.82 ± 21%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irq.folio_isolate_lru.madvise_cold_or_pageout_pte_range.walk_pmd_range.walk_pud_range
      7.70 ±  2%      -0.3        7.38 ±  3%  perf-profile.children.cycles-pp.clear_huge_page
      7.77 ±  2%      -0.3        7.46 ±  3%  perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.__call_rcu_common
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.vm_normal_page
      0.24 ±  9%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.folio_add_lru
      0.16 ±  3%      +0.1        0.22 ± 13%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.06 ± 17%      +0.1        0.18 ± 35%  perf-profile.children.cycles-pp.__free_one_page
      0.07 ± 10%      +0.1        0.19 ± 33%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.77 ±  6%      +0.1        0.89 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.26 ±  5%      +0.1        0.40 ± 13%  perf-profile.children.cycles-pp.free_unref_page_list
      0.08 ±  8%      +0.1        0.23 ± 30%  perf-profile.children.cycles-pp.uncharge_batch
      0.34 ± 20%      +0.1        0.49 ± 19%  perf-profile.children.cycles-pp.get_swap_pages
      0.08 ± 11%      +0.2        0.24 ± 40%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.00            +0.2        0.16 ± 50%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge
      0.43 ±  7%      +0.4        0.82 ± 21%  perf-profile.children.cycles-pp.folio_lruvec_lock_irq
      0.42 ±  7%      +0.4        0.82 ± 22%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.49 ±  6%      +0.4        0.92 ± 20%  perf-profile.children.cycles-pp.folio_isolate_lru
      0.11 ±  7%      +0.6        0.73 ± 52%  perf-profile.children.cycles-pp.madvise_cold
      0.00            +0.8        0.76 ± 56%  perf-profile.children.cycles-pp.__page_cache_release
      0.00            +0.9        0.89 ± 57%  perf-profile.children.cycles-pp.__folio_put
      1.23 ± 10%      +1.0        2.22 ± 26%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.11 ± 12%      +1.1        1.17 ± 53%  perf-profile.children.cycles-pp.__split_huge_page
      0.12 ± 11%      +1.2        1.31 ± 56%  perf-profile.children.cycles-pp.split_huge_page_to_list
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.12 ±  3%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.madvise_cold_or_pageout_pte_range
      0.15 ±  5%      +0.1        0.21 ± 12%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.39 ± 15%      +0.1        0.49 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ± 13%      +0.1        0.18 ± 34%  perf-profile.self.cycles-pp.__free_one_page
      0.06 ± 11%      +0.1        0.18 ± 33%  perf-profile.self.cycles-pp.page_counter_uncharge




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


