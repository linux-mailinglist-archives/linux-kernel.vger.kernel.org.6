Return-Path: <linux-kernel+bounces-441508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE199ECF62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EED1615C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35119F131;
	Wed, 11 Dec 2024 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFLWdIy6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41249139CFF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929772; cv=fail; b=Ou32tG24ugC1Stfa0Pbzai/jhxR7QuNsgHzqo1+h6hUNWwLE+HauqoqkxIEF2WgQfuOS2U4npMXMTDEi+BRPYt72A+sGwBqwaS0rHCVg8WeNiWS0E+Yg9bmBqgzKrGSxJeVCW19+yH5lVVwIWCE9XYfncsAH66vJ0O5/VH9c3NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929772; c=relaxed/simple;
	bh=4RA+nv+cajOlNS2VdfD6CYHyXdEtGOa++I4T+wwOCHw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iKCAx+mghwkdI9tB+YH7MhZ1G/JTM3pzRDtaiE5UhDdns6mdPMdxgdhCt3oweT+SE4XbBitzrnkIUGd6L4rxF+vJ0D1rjwZJmnKcoyu1z5RurnEUdIrTgMXE4vQZrOr3U1ieMNl+GionbB/p29r9UU3H9Li7SfehZSUNQxsVbvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFLWdIy6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733929769; x=1765465769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4RA+nv+cajOlNS2VdfD6CYHyXdEtGOa++I4T+wwOCHw=;
  b=JFLWdIy6PrbZBGDTBcJVPeIRsp0XXlNYd+vFyTNQlJY6/5cDJQUfXk+m
   yyAJAFVg1i3PjWe/18WWv5Qap00FBsro3JuxJSXzdgDCj6WEGJCtTK1mE
   cTfIe5jeF6RlMuVqVl+vynkoLWqGxRtbRwUOPBJZmn68sMyEFb9m2PIYy
   OJvbGx8DmS0Oxx5pi/tyFhcRul6gvev2M9h3K3yCy6/+usdopohcTwkwL
   gKrrAa/w8tiHvz0zkTXfXLq5yg8krVg4A7r5aa+xFYmEFVc69465SA8Q2
   80xwd4f7/fHrdRdwpOhxv7fh3oS89WKcreTo+uSbuvcN0FFeyInrxt1XN
   Q==;
X-CSE-ConnectionGUID: O2JP7bviTRSEcZve7ykYyw==
X-CSE-MsgGUID: /G1EG9F1Q++0i9uOSgfUeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44787317"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="44787317"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 07:09:29 -0800
X-CSE-ConnectionGUID: O3Ui6nAqREy8I+aiDfcy0g==
X-CSE-MsgGUID: I5x10IBdRDe7KfWW6LS1DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96642960"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 07:09:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 07:09:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 07:09:28 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 07:09:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDQyui9qf8XaAMGnG25JLy6CKC3g5M93b+zlJa42yqUnVQt+s8jBQIJGbQQ7DPhpYJAaZuYxNd1TIvsYZtO34oKf09Z7nGt6HGVe/55BxSbf5OxUsWtv/OrdySVSmiGi24+B6VMPmunosw7xA8ckAc4h0liMjgjXqw/YXdebDDp09m0NjWrnOZL2zOH0PxRV/yUfhWl9a7b74eOrCUsFesiuEAIdAyla9EiVeM883vp5MXJc2OsjJ0HGprSio/pNUJr6Bjsqz0AUb8uPihdbDEgaS1MX2JRqHKQVB42GJj+ILD/4cxaIH5AOMm2RMNM+HDa7yEoqRIWJ1Ki8zcxJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZBUS3/IIymqUMtFKOVuejD9CFlwmy28/qtDTYXj6ek=;
 b=l8C+uplXn8NVZNIrTZqS8dy456ys/EDhwNvvPq0LM3eFTBpHvcBF2m1jYZaQIGQp89QBTC57+lXh0PYuHgW4tH0zpSZGaJHidl+r59VAMDtTPgKeCyxYlbJrDG8mYENDr3grXq9ad9JfiH2+sfgyiDwxhKdteOgAnDpaQRy4b0PyNtO07aesd4aI7+QC9BdaRivKbUDGXtJTeMCZ/u89I4NDxvyzHYh48TwFSpaI4IQ1NVSVJUZGe2QWwez6qGrP+FJm4AkfzNOKhsu+1MRLYsfQARIXHh0ui96Mu6UPVYzIkJgnd9cuT2I1Ut5AdEattrq9+d79JJoqZ87MK3oWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 15:08:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 15:08:56 +0000
Date: Wed, 11 Dec 2024 23:08:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Wang <00107082@163.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan
	<surenb@google.com>, Yu Zhao <yuzhao@google.com>, Kent Overstreet
	<kent.overstreet@linux.dev>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm/codetag]  51f43d5d82:
 WARNING:at_include/linux/alloc_tag.h:#__alloc_tag_ref_set
Message-ID: <202412112227.df61ebb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: def19d75-3bd6-431c-4f25-08dd19f5bb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eodXhcl740AOOZQMKPzmv8usmvijd4mR5nsHwnHBnN+sQXHjs5lmzEGfakmn?=
 =?us-ascii?Q?HSENqJbQTnlzYSbej1FoZxZgFJ1pOhSgCXgETdbVr1QUT5NR1/H+g2w4/m/a?=
 =?us-ascii?Q?YKUF1K0xdkBX1tZDcaLWlGQuEJ/hgI7CMLNPn4Ul9pzsvjM0HKiWv0o0NR0v?=
 =?us-ascii?Q?3lVDcEOdNNKtVv90RZ297gAZ9eKlrKKcyQsEkZnh+7WAMEyHG7wceA5RdC3j?=
 =?us-ascii?Q?sH6raNjxmCtSAUaU2hQ1mjBg8RooHtQNMqiVCP3/W0pcOG0HKPv65nhBUYtU?=
 =?us-ascii?Q?l9SRMRr4XSRzQYZi7aG1mhM7QtIXgWyZHGXxwIacCBotjvQA7BvDIBSMCcLP?=
 =?us-ascii?Q?YQ3NrwSDf4O3fLHEnRZFnr9SKAQ2GoryFnt/MtfX0SC94UQpUAj0WkrBRAra?=
 =?us-ascii?Q?vLWXjQfiPQJsfIO2IqmitMOQdbZKKG5/nKb5lHXQdjUYVlN8xGVclrL0ttcZ?=
 =?us-ascii?Q?Rhpi6tj2RqcP4qbQczCyZMeGrNkcNPcs5eby3aj0IpCUXnBLZdaOcXtXIl1D?=
 =?us-ascii?Q?Tx3vbWwdIVgxeqcZ4U/Q2Yhwmn+tCtDtuWIYmGzrn7doRD934o62lJBYjX73?=
 =?us-ascii?Q?nWN8iIfrNpkQ24QVg/5zAs9Ca2WVmG1RFmfegBXW52PhJllcLokyj5uXDAfK?=
 =?us-ascii?Q?lTcxxjw1HBBR2NGG0bHgjr0AhMP8Q8h92RZahqGcJo/9fnpPnyqji6Uqo4kH?=
 =?us-ascii?Q?7oYkKY2emAoaMXuG8x8enLId8weaC6ZZ+DgoOlZfVRiwWHlBAsI6Dbs0IdRt?=
 =?us-ascii?Q?iRaH8GmaxgrWf+uheDrtgYMm9ZaPoLD1OEbyPUTesedKCUAJItzJIbtnh+zV?=
 =?us-ascii?Q?fTM3Q9ULpv4AnUvEI3ExS0PRqpaAtkdvKDlQeflWlvtyJ7Mt6luN4WX4yWSA?=
 =?us-ascii?Q?BpH66rSKSZKaTAX+AF/otMjbP3AhBm/UygD4lKZtlA63vO0Twg2Eazi8iWCu?=
 =?us-ascii?Q?a1BIg0JXnZZ7fkArd+Amjuy37R/q1bm70i677xzRe9MtNDQUR9tcZwH7Vofo?=
 =?us-ascii?Q?CqyY/ohSUBrkdJCFEuI6f1AQTacpP+VSqKjHv21KL2bVFdwrmRSbWp2alkbF?=
 =?us-ascii?Q?zjh4aCoir/pXl5SIFEww3o2fiJjx70feduvlIispT83kn/MO1kWYvpKlY0FD?=
 =?us-ascii?Q?WE4W4xQaB8gpDxc/LKVII/mNV8mVj4VQcPULiWqpcaFQ9FQXieappSc5EJHz?=
 =?us-ascii?Q?hCk9jA7GV+4PR6g+PkcxbkZOg6kd6Jx9aS1xJZ9Q9bMNgPAYuWkiO1i+Bsgc?=
 =?us-ascii?Q?0HXU+wwpj3lR6FUgRj5ijNI+8qu963jT5uJrdXUxlh4c0MdZLzPUbXu9rb+X?=
 =?us-ascii?Q?EdfdLpe3HNxcInNYz+ALedAAJNHLs5vGkeXnF5cqaJaVsU+pIldHNF9xf85e?=
 =?us-ascii?Q?6qpzbYY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KPtafG2s/t+F/ixd9GoLDlFG++hSQsrBYV7x5h1obqjKv3GdEAePhhzTQdUy?=
 =?us-ascii?Q?AsQtlvqK39ZF5ET4pbOOR/PX5uEGWiKU/r+gsX7mt6bQzJWzWdTmbOx8ClI8?=
 =?us-ascii?Q?2Ypj207EvEP2ZJNH3RFwjVBQydFIJ/uirE1mf9B/jpTfWRhnhvy5qLfND62s?=
 =?us-ascii?Q?lS792mPMkQPXc8ctRgP9OUS0QloZX9X9IJGMXwRjYkjQNCiKOIWwg6K8ghxH?=
 =?us-ascii?Q?aPbu+UpOiVCwoZZr7c+d+vPd2nLYvpdJHqB4m3c763rMKqR4GcsqPw0x1teg?=
 =?us-ascii?Q?/+++kOiz4N2OWJHdFlvgzq/huikZ8lS6rui8+VHPYlZ4gzfuKemx8x0KDOz/?=
 =?us-ascii?Q?KGBMTKXmYTB8oSVEd4O6vU70eNj1HJQOQlh3fcebqXY/ISdXAM/OKJopwRgG?=
 =?us-ascii?Q?uy85N1Mmj5wuZaQZwdviUOURVmm3Z6o2k1VN/md7rwgtb6sgkece0iHPEp5z?=
 =?us-ascii?Q?pfrHmHYo9aC/iMhKhwEI6v8g/Lc6C8+lvLSHeeqXCGAqkcKcCmYWlbUoB4B6?=
 =?us-ascii?Q?lt5WG/zo/IHjaVIFC1/Iecb6j4rx3s1wVhhZgOJW+e2LdYduVrPAd5Y7Dq1a?=
 =?us-ascii?Q?KxeTC8emyqBSGv3NDs6aITjCQzidIMR/ynaEsyZ4HSvZ936x611rSNreuzAT?=
 =?us-ascii?Q?Ylh9WMADRUkVAfxvasmPgHzxIVq/ydGf/6bCbZiFQqzgghMhwdVe3e7Iy/FV?=
 =?us-ascii?Q?3IZaeW1eaf/QIT55IXsjWsKfNL7tA1FEy4gJMinw+BRY9KYCEEBrDQ6WhlQu?=
 =?us-ascii?Q?3zn6SYdybsiKClztgTuUYvoU0wqAcTaO6X7s/2AL6B/G9/Eu3oKV0ZHGojMi?=
 =?us-ascii?Q?4c557rd61ts8ui4FaG46QdGApAN5qgMHaqrs+Ry2E8nIC/R4SdLcIRHmT8u0?=
 =?us-ascii?Q?WPNOHUvelJJUy7OVGjC3TWSk9eqQwSh5LNZWRHWWlQRuWHyY8zWdS7Sy9TEc?=
 =?us-ascii?Q?EN7vRy/54ArYyTdi+nkageFkntSoH4h8GZ3/n8Tq4OpGCd4VwUqaVLq9abyC?=
 =?us-ascii?Q?RDHGrpY2Ls7E0euI+/kixT7cqV4L4REqPAdi1TWvcJgyTN/MiCtnVV9XJJ9s?=
 =?us-ascii?Q?DjOq9M9NIBWbfHgtMQnDn97K9YtFfvtl5xuz33J48t4o1i7cee+YC3cb27Tz?=
 =?us-ascii?Q?HXqPk/10lsxLGRCRfaK5Lj2wdBAZ2qGAjUxJSF7CWSvRi+3p92Jpu1Uj0Lpg?=
 =?us-ascii?Q?/osrbdvLoBOuHEjCXxZCogQXCT1vznToFGz/HLS/tMi8AiM5Z4mjTGPfsgvs?=
 =?us-ascii?Q?Uq9GB//7DJpp3XRILYzUPaIslR6wrihWTEb2D1nq+yGSgZETv/oA5IC7n/d3?=
 =?us-ascii?Q?8lhfmie9HWJSX2nyrCnWZCQCbXxX7cZ3PmvYQ8cBubrIfCVQTeRUa6VMKFWW?=
 =?us-ascii?Q?0e2MzFqnD5FlgB06GN9WQDECJgPiINqsRDedoVfREfQJzeD0G2nhj0hkR6Yc?=
 =?us-ascii?Q?HLi+kaZoWI8P4NtP7oAfEUsCCAnRcK4nOUIFQIswONrOGLEmpqg2qIr8pj7F?=
 =?us-ascii?Q?1mOPT+YdaVPUfMDfs1oAxHDsUtplP0Z2vwkZ7XObW654kWLm2Hm5BP+scqy9?=
 =?us-ascii?Q?QyIYVja6ZgKR6l5DT7awXE7lFCTdGND98tak8qSPqLFdJ/HALivxmiMmuNAz?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: def19d75-3bd6-431c-4f25-08dd19f5bb80
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 15:08:56.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS3V//qAnW0woXN8GonmqVPI87bQXqIN1TEqZLeGLmgwdqu8Vlb0bsgngKDdzNfG3SRHy2pz9Zu/UjDNZa55Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/linux/alloc_tag.h:#__alloc_tag_ref_set" on:

commit: 51f43d5d82ed2ba3f9a3f9a2390c52f28e42af32 ("mm/codetag: swap tags when migrate pages")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]
[test failed on linux-next/master ebe1b11614e079c5e366ce9bd3c8f44ca0fbcc1b]

in testcase: trinity
version: 
with following parameters:

	runtime: 600s



config: i386-randconfig-015-20241208
compiler: gcc-11
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------+------------+------------+
|                                                           | 914eec5e98 | 51f43d5d82 |
+-----------------------------------------------------------+------------+------------+
| WARNING:at_include/linux/alloc_tag.h:#__alloc_tag_ref_set | 0          | 5          |
| EIP:__alloc_tag_ref_set                                   | 0          | 5          |
+-----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412112227.df61ebb-lkp@intel.com


[  626.127550][   T24] ------------[ cut here ]------------
[  626.128516][   T24] alloc_tag was not cleared (got tag for mm/shmem.c:1794)
[ 626.136360][ T24] WARNING: CPU: 0 PID: 24 at include/linux/alloc_tag.h:138 __alloc_tag_ref_set (include/linux/alloc_tag.h:138 include/linux/alloc_tag.h:157)
[  626.137957][   T24] Modules linked in: serio_raw rtc_cmos bochs drm_client_lib drm_shmem_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_kms_helper fb drm drm_panel_orientation_quirks backlight intel_agp intel_gtt
[  626.140833][   T24] CPU: 0 UID: 0 PID: 24 Comm: kcompactd0 Tainted: G                T  6.13.0-rc1-00015-g51f43d5d82ed #1
[  626.142284][   T24] Tainted: [T]=RANDSTRUCT
[  626.142870][   T24] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 626.144610][ T24] EIP: __alloc_tag_ref_set (include/linux/alloc_tag.h:138 include/linux/alloc_tag.h:157)
[ 626.145517][ T24] Code: 53 89 c3 51 8b 00 85 c0 74 25 80 3d a4 8a 35 c2 00 75 1c ff 70 04 c6 05 a4 8a 35 c2 01 ff 70 10 68 24 bc c0 c1 e8 7d bf cd ff <0f> 0b 83 c4 0c 85 f6 75 25 a0 a3 8a 35 c2 84 c0 75 22 68 6d bc c0
All code
========
   0:	53                   	push   %rbx
   1:	89 c3                	mov    %eax,%ebx
   3:	51                   	push   %rcx
   4:	8b 00                	mov    (%rax),%eax
   6:	85 c0                	test   %eax,%eax
   8:	74 25                	je     0x2f
   a:	80 3d a4 8a 35 c2 00 	cmpb   $0x0,-0x3dca755c(%rip)        # 0xffffffffc2358ab5
  11:	75 1c                	jne    0x2f
  13:	ff 70 04             	push   0x4(%rax)
  16:	c6 05 a4 8a 35 c2 01 	movb   $0x1,-0x3dca755c(%rip)        # 0xffffffffc2358ac1
  1d:	ff 70 10             	push   0x10(%rax)
  20:	68 24 bc c0 c1       	push   $0xffffffffc1c0bc24
  25:	e8 7d bf cd ff       	call   0xffffffffffcdbfa7
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	83 c4 0c             	add    $0xc,%esp
  2f:	85 f6                	test   %esi,%esi
  31:	75 25                	jne    0x58
  33:	a0 a3 8a 35 c2 84 c0 	movabs 0x2275c084c2358aa3,%al
  3a:	75 22 
  3c:	68                   	.byte 0x68
  3d:	6d                   	insl   (%dx),%es:(%rdi)
  3e:	bc                   	.byte 0xbc
  3f:	c0                   	.byte 0xc0

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	83 c4 0c             	add    $0xc,%esp
   5:	85 f6                	test   %esi,%esi
   7:	75 25                	jne    0x2e
   9:	a0 a3 8a 35 c2 84 c0 	movabs 0x2275c084c2358aa3,%al
  10:	75 22 
  12:	68                   	.byte 0x68
  13:	6d                   	insl   (%dx),%es:(%rdi)
  14:	bc                   	.byte 0xbc
  15:	c0                   	.byte 0xc0
[  626.148477][   T24] EAX: 00000037 EBX: c37e1cd0 ECX: 00000000 EDX: 00000002
[  626.149410][   T24] ESI: c2364ee0 EDI: e8359650 EBP: c37e1cbc ESP: c37e1ca4
[  626.150473][   T24] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
[  626.151777][   T24] CR0: 80050033 CR2: 08ad2b00 CR3: 2e405000 CR4: 000406d0
[  626.152802][   T24] Call Trace:
[ 626.153277][ T24] ? show_regs (arch/x86/kernel/dumpstack.c:478)
[ 626.153821][ T24] ? __alloc_tag_ref_set (include/linux/alloc_tag.h:138 include/linux/alloc_tag.h:157)
[ 626.154506][ T24] ? __warn (kernel/panic.c:748)
[ 626.155033][ T24] ? report_bug (lib/bug.c:201 lib/bug.c:219)
[ 626.155645][ T24] ? __alloc_tag_ref_set (include/linux/alloc_tag.h:138 include/linux/alloc_tag.h:157)
[ 626.156293][ T24] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 626.156881][ T24] ? handle_bug (arch/x86/kernel/traps.c:285)
[ 626.157503][ T24] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1))
[ 626.158156][ T24] ? handle_exception (arch/x86/entry/entry_32.S:1055)
[ 626.159050][ T24] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 626.159866][ T24] ? __alloc_tag_ref_set (include/linux/alloc_tag.h:138 include/linux/alloc_tag.h:157)
[ 626.160591][ T24] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 626.161157][ T24] ? __alloc_tag_ref_set (include/linux/alloc_tag.h:138 include/linux/alloc_tag.h:157)
[ 626.161831][ T24] ? pgalloc_tag_get (include/linux/pgalloc_tag.h:220)
[ 626.162455][ T24] pgalloc_tag_swap (lib/alloc_tag.c:214)
[ 626.163139][ T24] folio_migrate_flags (mm/migrate.c:750)
[ 626.163986][ T24] __migrate_folio+0x8c/0x96
[ 626.164956][ T24] ? __migrate_folio+0x96/0x96
[ 626.165986][ T24] migrate_folio (mm/migrate.c:800 (discriminator 2))
[ 626.166790][ T24] move_to_new_folio (mm/migrate.c:1060)
[ 626.167675][ T24] migrate_pages_batch (mm/migrate.c:1369 mm/migrate.c:1899)
[ 626.168566][ T24] ? list_add (arch/x86/kernel/cpu/resctrl/rdtgroup.c:2015 (discriminator 2))
[ 626.169303][ T24] migrate_pages (mm/migrate.c:1971 mm/migrate.c:2074)
[ 626.169948][ T24] ? list_add (arch/x86/kernel/cpu/resctrl/rdtgroup.c:2015 (discriminator 2))
[ 626.170574][ T24] ? fragmentation_score_node (mm/compaction.c:1879)
[ 626.171569][ T24] compact_zone (mm/compaction.c:2641)
[ 626.172363][ T24] compact_node (mm/compaction.c:2912)
[ 626.173081][ T24] kcompactd (mm/compaction.c:3209)
[ 626.173630][ T24] ? lockdep_assert_rq_held (kernel/sched/sched.h:1731)
[ 626.174318][ T24] kthread (kernel/kthread.c:391)
[ 626.174972][ T24] ? kcompactd_do_work (mm/compaction.c:3155)
[ 626.175708][ T24] ? list_del_init (kernel/signal.c:466)
[ 626.176296][ T24] ret_from_fork (arch/x86/kernel/process.c:153)
[ 626.176833][ T24] ? list_del_init (kernel/signal.c:466)
[ 626.177415][ T24] ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[ 626.177999][ T24] entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[  626.178652][   T24] irq event stamp: 18033
[ 626.179292][ T24] hardirqs last enabled at (18043): __up_console_sem (arch/x86/include/asm/irqflags.h:26 (discriminator 3) arch/x86/include/asm/irqflags.h:87 (discriminator 3) arch/x86/include/asm/irqflags.h:147 (discriminator 3) kernel/printk/printk.c:344 (discriminator 3))
[ 626.180568][ T24] hardirqs last disabled at (18052): __up_console_sem (kernel/printk/printk.c:342 (discriminator 3))
[ 626.181908][ T24] softirqs last enabled at (17870): handle_softirqs (kernel/softirq.c:401 kernel/softirq.c:582)
[ 626.183280][ T24] softirqs last disabled at (17865): __do_softirq (kernel/softirq.c:589)
[  626.184539][   T24] ---[ end trace 0000000000000000 ]---
[  626.460849][ T3069] trinity-c1 invoked oom-killer: gfp_mask=0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), order=0, oom_score_adj=500
[  626.462854][ T3069] CPU: 0 UID: 65534 PID: 3069 Comm: trinity-c1 Tainted: G        W       T  6.13.0-rc1-00015-g51f43d5d82ed #1
[  626.464654][ T3069] Tainted: [W]=WARN, [T]=RANDSTRUCT
[  626.465456][ T3069] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  626.467024][ T3069] Call Trace:
[ 626.467563][ T3069] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 4))
[ 626.468317][ T3069] dump_stack (lib/dump_stack.c:130)
[ 626.468989][ T3069] dump_header (mm/oom_kill.c:73 mm/oom_kill.c:462)
[ 626.469701][ T3069] oom_kill_process (mm/oom_kill.c:444 mm/oom_kill.c:1035)
[ 626.470501][ T3069] out_of_memory (mm/oom_kill.c:1174)
[ 626.471229][ T3069] __alloc_pages_slowpath+0x584/0x63d
[ 626.472253][ T3069] __alloc_pages_noprof (mm/page_alloc.c:4764)
[ 626.473076][ T3069] __folio_alloc_noprof (mm/internal.h:709 mm/page_alloc.c:4785)
[ 626.473927][ T3069] shmem_alloc_folio+0x21/0x48
[ 626.474891][ T3069] shmem_alloc_and_add_folio+0x22/0x138
[ 626.475933][ T3069] shmem_get_folio_gfp+0x164/0x358
[ 626.476877][ T3069] ? kunmap_local_indexed (mm/highmem.c:630 (discriminator 3))
[ 626.477692][ T3069] shmem_get_folio (mm/shmem.c:2463)
[ 626.478404][ T3069] shmem_write_begin (mm/shmem.c:3118)
[ 626.479168][ T3069] generic_perform_write (mm/filemap.c:4057)
[ 626.479993][ T3069] shmem_file_write_iter (mm/shmem.c:3293)
[ 626.480869][ T3069] iter_file_splice_write (fs/splice.c:744)
[ 626.481773][ T3069] ? splice_from_pipe_next (fs/splice.c:669)
[ 626.482677][ T3069] do_splice_from (fs/splice.c:941)
[ 626.483432][ T3069] direct_splice_actor (fs/splice.c:1164)
[ 626.484239][ T3069] splice_direct_to_actor (fs/splice.c:1109)
[ 626.485142][ T3069] ? file_end_write (fs/read_write.c:843)
[ 626.485925][ T3069] do_splice_direct_actor (fs/splice.c:1208)
[ 626.486772][ T3069] ? pipe_buf_confirm (fs/pipe.c:85)
[ 626.487522][ T3069] do_splice_direct (fs/splice.c:1235)
[ 626.488317][ T3069] ? file_end_write (fs/read_write.c:843)
[ 626.489088][ T3069] do_sendfile (fs/read_write.c:1363)
[ 626.489832][ T3069] __ia32_sys_sendfile (fs/read_write.c:1402 fs/read_write.c:1391 fs/read_write.c:1391)
[ 626.490659][ T3069] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-015-20241208/./arch/x86/include/generated/asm/syscalls_32.h:188)
[ 626.491455][ T3069] do_int80_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:339)
[ 626.492222][ T3069] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[ 626.493011][ T3069] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:269)
[ 626.493775][ T3069] ? local_clock_noinstr (kernel/sched/clock.c:301)
[ 626.494583][ T3069] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
[ 626.495431][ T3069] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4470)
[ 626.496269][ T3069] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[ 626.497098][ T3069] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:269)
[ 626.497903][ T3069] ? local_clock_noinstr (kernel/sched/clock.c:301)
[ 626.498733][ T3069] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[ 626.499603][ T3069] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[ 626.500462][ T3069] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:269)
[ 626.501217][ T3069] ? local_clock_noinstr (kernel/sched/clock.c:301)
[ 626.502080][ T3069] ? find_held_lock+0x22/0x5f
[ 626.503012][ T3069] ? __lock_release+0xb0/0x150
[ 626.503862][ T3069] ? rcu_read_unlock (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880)
[ 626.504608][ T3069] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
[ 626.505449][ T3069] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
[ 626.506281][ T3069] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
[ 626.507051][ T3069] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4470)
[ 626.507856][ T3069] ? syscall_exit_to_user_mode (kernel/entry/common.c:221)
[ 626.508762][ T3069] ? do_int80_syscall_32 (arch/x86/entry/common.c:343)
[ 626.509576][ T3069] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[ 626.510425][ T3069] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:269)
[ 626.511252][ T3069] ? local_clock_noinstr (kernel/sched/clock.c:301)
[ 626.512110][ T3069] ? find_held_lock+0x22/0x5f


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241211/202412112227.df61ebb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


