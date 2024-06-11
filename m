Return-Path: <linux-kernel+bounces-209293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A6890317C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B217B28E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7617085D;
	Tue, 11 Jun 2024 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I51bj0EH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183E170857
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084634; cv=fail; b=DTE/vdJX/iGzaVPXU9smizRTkyoLiVAAZHKMAGTpUXnbi1wbjqf4xn0l/Sd6VAiG0H3iwsqhM8+8A/hId4xzCbs5Mg2kUOaWDTMudAreK6fGbhnLgvjKVRzCo+7Cv7fc/9OnH+2DthWzaXqtsfD9XXvlxFH02qrY/uUU5Z4fVZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084634; c=relaxed/simple;
	bh=2fG9Nt8B/MxKiefvg3vd8+qA7Eh7anCFp2byeKsKu9w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WI7p71+WCorsNia5QMhvzghvJBwZhg0pR69bJua/G6ApCUlb9gTLx2cYlVp3br1h4KZMOPZhSiMQHGD6orVhVcHNzQ1hn9K7y1QmZDS2GQ1eUAm2LJIvB1Igr58sKPqcWsxguqTLSq025mZjQHX85DrMYxaBug70taO1FHG/vfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I51bj0EH; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718084632; x=1749620632;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2fG9Nt8B/MxKiefvg3vd8+qA7Eh7anCFp2byeKsKu9w=;
  b=I51bj0EHP3lrLfrGz9fHILXbDGxrtoOv3vvK0FoRhTmgYMtdfJSU+ubn
   UO04fesnLqV8v4freo/i2zyMRf9oi1xKClztHK0VqFn3pqeWtBPa1GWyq
   gQrbU6OdVQ8LetFbbRFC6j8cHAr7cORNL3Hx2fBMPW0EgjM4MU1ZcZAfw
   60RHuzt22IlpfDQCTHaC/g4drH1RjVSi7oXL/F0AYdn3ZV1+Sz9A8v/3q
   TV9Bfc0ii9F+nYJW3Jk7MmsvI+F1dccdhxS4A9+zZCkEIriS0ZFbs/vMv
   UbLkneh7yKbo7hAraYtifDvfNgDRKotKZ62n+SsAgB9bXQqKQ2Ouxw0r+
   Q==;
X-CSE-ConnectionGUID: Du+TcxZJQZS7Nmu5TQxldw==
X-CSE-MsgGUID: a+2ZP2NMTrqmNzInmrB+Yw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="40175246"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="40175246"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:43:52 -0700
X-CSE-ConnectionGUID: W5hez8DGRUKMOcI8178CfA==
X-CSE-MsgGUID: DrQ3W212TOiGN/xL4GGtrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39390667"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jun 2024 22:43:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 22:43:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 22:43:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 22:43:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/oFP90bwXVtTaBKJ9EvjvHqJRKYJQX+kEOfZdoQtVn66v9aJNFlPmjsqf8C6cNScKyhAVCUhjOO6dsFZuOzcve8EDL+1jr2B8es6sOMFhunzeAI6xpcrGsZ1HHQXYPWBefl/nLnOV4cF3Fk0NdKuIiwahuSr7ewU9iB5yiToe5WrW0p72ZdVwAk4e4yPVGziHjqy2hBx7H8/1dCDYmwQowLv/qbzkxlCc8jpSjo6pJth3KFGntHv1chM64v9hIm3ct2bu830MBUOPbqBccdYNIsJrTl6Q4pVfnMEDcy3btBMvyKz2IX0Rads/AXTvfNCLM1rVtMxw+k9yUC7L0HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K7JjmL/TW+O2NBMGhbdUQ5aunXErX/6pYUu67nkBW8=;
 b=A8KqsKj/ITKZS7L6JPaXim7mbIHQTiFC8vYh8u1xKwia+mvlc18XLYb8TPXVUXbrfgM3VA9n+AvChzp19Fxsr1OgF94uVqD99muJMGlMjQTdup6UuE36VrerCkN7TKBUmIovXlk4YI52qcjPmi/36KnPUaq0se36xdSOc9Lbw+t0ZaoFPHRpQ1x98smr3Gwf4uv7SWdsVJDekFJQZ9u5+tNCVwKNpIPhRY9vEkpcFTTFwYH244noGgghsoTKDeZ+hs8HPgK439Aun/UcMLG+IFcro+gMED4U4DpyGgTR9ZLKXZo7cHjQjoNAbdilI1jQaE56OwvURRBAAYqHIXonnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7148.namprd11.prod.outlook.com (2603:10b6:510:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 11 Jun
 2024 05:43:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 05:43:42 +0000
Date: Tue, 11 Jun 2024 13:43:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Oleg
 Nesterov" <oleg@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Thomas Gleixner" <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
	<oliver.sang@intel.com>
Subject: [tip:WIP.x86/fpu] [x86/fpu]  4f4a9b3993: kernel_BUG_at_mm/usercopy.c
Message-ID: <202406111349.cf61e641-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: b749b246-3b4b-493a-c891-08dc89d973de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yf+N8Sh8cc4c32V7+yEHrnsFz5sWhUX8vaxcvtEFgfF2FeL/VTA76uMr4Eht?=
 =?us-ascii?Q?iyA8slZDnjsIe/JX40gJfi144z67dBm3J037HrCvmz6XV7BHGn1d1LHdacZB?=
 =?us-ascii?Q?AiqYCq8W430nJ1u3hWv/+nbhCDPoHseWDMb7mpMX4BzxCLLnuaf8Hbhmtlxn?=
 =?us-ascii?Q?1n4VkitWkUQ3YxAwhyQhRlmjKcJpg1XEtZ4GZcjztnxTCCMo8/8cWJOqJIYy?=
 =?us-ascii?Q?QRicams+QDU11UBrmxlXiYbWkIL1dsoHssTwZz5yf32Nd5ciL62p/wWV73qp?=
 =?us-ascii?Q?V/WK97gILjz1KFX0BgATQlP2vyq6RwisoBrC8EaBSIpM05RXpBciUt7jNXmO?=
 =?us-ascii?Q?s2//F4QX22COQXNCXYfi4Z/cSUXn95yJhTnlIt3HPXj5p4J7OeXQnSXodtzN?=
 =?us-ascii?Q?wdLRgBIZT4CZ6MZVQKPSwMvOTFxrHWntaAUShLLYJC0hRzt7LzODN8FqeNoT?=
 =?us-ascii?Q?Cq2ZcO0EGqIpii+0/yQoqk7yX4B11+Iu6v+2IDRp9f48qomSSGqQuMbokh6P?=
 =?us-ascii?Q?sZ8VxoNnnkEHmAUzrWX0xk8BCN1fQfgT/iw2XAOjxffTKAhLcVtvl1vFS8uC?=
 =?us-ascii?Q?XuA9qEOJG37+k/w8RLC/enq4Xhz2/UYyi9QNsCLyszXvYlpnpyD7gjEY7uwH?=
 =?us-ascii?Q?XZOpR1PkRL2OKI2VmJ6nPdXpYCzYBuFUEyGM89P0znHoW/LpWDQfffNBHR1r?=
 =?us-ascii?Q?GsBoZx71t8F1aNCEwHFbC8btGlrV3lPx58AmrZDdF/LUQtmVmKtHpitnWPDC?=
 =?us-ascii?Q?BlwQjVzV5bOXhaUn+FN5Tf5H+2g9c4vQg8uYiHsMQPu4CxkkNqgsLVsa62X3?=
 =?us-ascii?Q?aJEITYQPqe6YO+C0phAOYdSMVtLuFINr5B3nQjyglOaHjkGQa0QcV+6oP3vX?=
 =?us-ascii?Q?Ej6ZYJCBVGYK3qp+JBSFYsoIRgkFVqZ5HgggznIianp1WF92CFH2i/I5Wn1O?=
 =?us-ascii?Q?lzqjLWRHmMUxCnQzaolUs7i1aHjsTT9953j4c83Qvz2/xxfcMaHg7Z1Re0tZ?=
 =?us-ascii?Q?CKQkDxpl0M3r3T5C1MnIl9sLA7OeznKQv4LvLM0vvMYD2LNqUHjt0ZsH5CZp?=
 =?us-ascii?Q?iyxoJNMBzG1mCTCElaGZqJAkUKj8bzWwH7lsDSz3H728rJ7MmPWG2AAp7FmR?=
 =?us-ascii?Q?wQI1x1SDF/B7Yw4aUbTMkjEMWFdwfJ2nL4G/CDmnVAbH2lN59RMzbdrr0l5u?=
 =?us-ascii?Q?3jmNubVeUtM5CDzMLAbcsBnaHJrmlvc5yYM3dBH9OmYQnpxpvW/G/igUWSo2?=
 =?us-ascii?Q?MYuhJTlwtSJs2FKRrUm9YVyMSJQnCx2yphv6hnO6kQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lihtFYEfzIk25cqONPDV5gauhChUzEXRrvqqXnkTX0+fcuZCfbCgCu28L97b?=
 =?us-ascii?Q?/FQgxqK7ogHMWQEaoUElGMh2LnHrX+Rsqt/QEFkN/kgbfU5oKcZmKbvH/0YH?=
 =?us-ascii?Q?RF2tjqjhnWJnivDexYmEDN2Fl0460Hn1c2kV1XONwIuLoVAALrWWvFRgltT1?=
 =?us-ascii?Q?7QV5M91WGTvCTOmx73Z39gB6glUK6vndLjXhTT5kspBu5ET1Btr5oyEg+6u6?=
 =?us-ascii?Q?qQTqyloIHxLsOMyNfYkuwJg+mihgXJlDTuGIIqjyuYx2zvIWmxhufcqwmaXs?=
 =?us-ascii?Q?kd65WldcWUbauonLC32jFRscvBwsov+7qracn19M0M59w/AsnhFzBku9RQbR?=
 =?us-ascii?Q?P9BSjvC8jijEC3AZpFoFG5URCvGOLW0y4jQvsj+keRbpscqOlzahmzXG/jiR?=
 =?us-ascii?Q?mQlUrWu0JmCr00j4Ay/ykuPj5A0YtorlpVZwAbZpoYhS78dykT83VeNbouvO?=
 =?us-ascii?Q?83qYz60nIgrMi00aANcu6TOpKHtL3XAE04H7JIN4U5q/Uthu01z30FjF0ecU?=
 =?us-ascii?Q?F8MqUWM6cd3WpHNTG4BZ8V3aIQjhg9EWm1KmpS51/nK9b7j2qnQJVEp0Y0Gk?=
 =?us-ascii?Q?uBUfjDeIsQPapfZe31cz71uC2dHBTj/9qLbp+uyF7SqWuooP2EWFwrLG/ZOX?=
 =?us-ascii?Q?JOdwGaQd81k5B/SBR3o+Z8BZMFRD2VWmMoP5vhG92O7DNCBDKW9wvjJD2oHf?=
 =?us-ascii?Q?mKT2n6fC6M+QHmHFKCDsK4jzOjSQ2y1ZylT6eLsdv92wAr9HXcPtKdmf9JY+?=
 =?us-ascii?Q?Pupnpb8O0wMNLp2SOfc99awRYoGF69RJbkEwXo8WkNnWYsG0JG+uFHsxKSS0?=
 =?us-ascii?Q?DYJQSSLSq1r8i++iOxVyFCHQZ/g00XXY1otVnHcKxaav2NMB25rtfUeAh0Er?=
 =?us-ascii?Q?LtRkZO00gRCaAvAVxfyw4azCvvekwlsiS+9u1lKdSYANvXffp038Rz5eKfZQ?=
 =?us-ascii?Q?ANP69JSIGguxN8G2YnU6eZ6wlT3QAdcTwdDbLCDRQNN7hpZb777r4x4zCh6i?=
 =?us-ascii?Q?cyQSjlGPyW1hmLRSF0yM9BdTU+wTxQxfBUAPEF8NqRwTBvPVcJtbD4t2youO?=
 =?us-ascii?Q?U0AIlN6n2UzSUHMK3hTZwxT7NPrFw5sREsBpeOmWE+Uhe8gbg90ganKIJNKX?=
 =?us-ascii?Q?ZwAByjwJNu9UxDFs2t4tloWKesNjqQIDUrE3kMgfd9buB2p9qrni3GSHgZvj?=
 =?us-ascii?Q?6eUfKxwe+7+NI17LKdbMWzyp4C6rijctGwTHYn2sa5pfGay6Y0cQV1Q+n+ix?=
 =?us-ascii?Q?NU2xEZ63grL2eC5bRrINVE0nmDQYF7k//t0JdiqUqHPjlZgfrxLtuFswumtZ?=
 =?us-ascii?Q?FXBrrc2xXHHakGIrV+4Hy/Jpqk7aV8Ra4sf8ealgWX4qw4gfPZ3RBuZWf/Lh?=
 =?us-ascii?Q?ACuAtAM/pz+4tGwfnbzIFLcTgW0VQKM+Byovr4DLRrsuLjQlmONGzQNPjUTs?=
 =?us-ascii?Q?ArqSV6O9M9U4sQef24l3HLoM0yxSw7Jk0mIDRV8CFveoXKiTzqnWLnKHz/nP?=
 =?us-ascii?Q?XhsySBdaNDtv4a28Wc9W7v5tM+OCzIPl/k+pWjNXJSfUKe8v5x9H23epf1Da?=
 =?us-ascii?Q?gQXRXn6fIL/4pUX8rUgRJJVF7S2BTAIKkRSektaD4EKnU2T0Bk+hzRacPi33?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b749b246-3b4b-493a-c891-08dc89d973de
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 05:43:42.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bbkfgoRG8g7EW3BrX8aldBQu0ApZslkTCOYJsaK9YPmc0D+qt1TBe4bVKAhm/oKlPJDiGH0TqCK8QmxnWWRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7148
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/usercopy.c" on:

commit: 4f4a9b399357c82910d99125892ee204e6332080 ("x86/fpu: Make task_struct::thread constant size")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.x86/fpu

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | 36c95eb4b2 | 4f4a9b3993 |
+--------------------------------------------+------------+------------+
| boot_successes                             | 6          | 0          |
| boot_failures                              | 0          | 5          |
| kernel_BUG_at_mm/usercopy.c                | 0          | 5          |
| Oops:invalid_opcode:#[##]PREEMPT_KASAN_PTI | 0          | 5          |
| RIP:usercopy_abort                         | 0          | 5          |
| Kernel_panic-not_syncing:Fatal_exception   | 0          | 5          |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406111349.cf61e641-lkp@intel.com


[   25.894524][  T111] ------------[ cut here ]------------
[   25.895008][  T111] kernel BUG at mm/usercopy.c:102!
[   25.895471][  T111] Oops: invalid opcode: 0000 [#1] PREEMPT KASAN PTI
[   25.896030][  T111] CPU: 0 PID: 111 Comm: nfs-utils_env.s Not tainted 6.10.0-rc2-00003-g4f4a9b399357 #1
[   25.896825][  T111] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 25.897672][ T111] RIP: 0010:usercopy_abort (mm/usercopy.c:102) 
[ 25.898146][ T111] Code: 89 cb 49 c7 c6 60 b5 f1 83 4c 0f 44 f6 48 c7 c7 00 b4 f1 83 4c 89 de 4c 89 c9 4d 89 d1 50 53 41 56 e8 da a6 eb 01 48 83 c4 18 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	89 cb                	mov    %ecx,%ebx
   2:	49 c7 c6 60 b5 f1 83 	mov    $0xffffffff83f1b560,%r14
   9:	4c 0f 44 f6          	cmove  %rsi,%r14
   d:	48 c7 c7 00 b4 f1 83 	mov    $0xffffffff83f1b400,%rdi
  14:	4c 89 de             	mov    %r11,%rsi
  17:	4c 89 c9             	mov    %r9,%rcx
  1a:	4d 89 d1             	mov    %r10,%r9
  1d:	50                   	push   %rax
  1e:	53                   	push   %rbx
  1f:	41 56                	push   %r14
  21:	e8 da a6 eb 01       	call   0x1eba700
  26:	48 83 c4 18          	add    $0x18,%rsp
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	0f 1f 40 00          	nopl   0x0(%rax)
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	0f 1f 40 00          	nopl   0x0(%rax)
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[   25.899665][  T111] RSP: 0000:ffffc90000e2fc08 EFLAGS: 00010282
[   25.900185][  T111] RAX: 0000000000000068 RBX: 0000000000002480 RCX: ffffffff820b5d43
[   25.900862][  T111] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc90000e2fa98
[   25.901546][  T111] RBP: 0000000000000000 R08: ffffc90000e2fa9f R09: 1ffff920001c5f53
[   25.902224][  T111] R10: dffffc0000000000 R11: fffff520001c5f54 R12: ffffea0005bee830
[   25.902908][  T111] R13: ffffea0000000000 R14: ffffffff83f1b560 R15: ffffea0005bee800
[   25.903585][  T111] FS:  0000000000000000(0003) GS:ffffffff84ada000(0063) knlGS:00000000f7f9b040
[   25.904337][  T111] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   25.904885][  T111] CR2: 00000000567a10e0 CR3: 000000016fbdc000 CR4: 00000000000406b0
[   25.905570][  T111] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   25.906246][  T111] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   25.906932][  T111] Call Trace:
[   25.907254][  T111]  <TASK>
[ 25.907553][ T111] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 25.907953][ T111] ? die (arch/x86/kernel/dumpstack.c:? arch/x86/kernel/dumpstack.c:447) 
[ 25.908311][ T111] ? do_trap (arch/x86/kernel/traps.c:129) 
[ 25.908691][ T111] ? do_error_trap (arch/x86/include/asm/traps.h:? arch/x86/kernel/traps.c:174) 
[ 25.909111][ T111] ? usercopy_abort (mm/usercopy.c:102) 
[ 25.909531][ T111] ? do_error_trap (arch/x86/kernel/traps.c:175) 
[ 25.909947][ T111] ? usercopy_abort (mm/usercopy.c:102) 
[ 25.910364][ T111] ? handle_invalid_op (arch/x86/kernel/traps.c:212) 
[ 25.910801][ T111] ? usercopy_abort (mm/usercopy.c:102) 
[ 25.911221][ T111] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 25.914101][ T111] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 25.914547][ T111] ? llist_add_batch (lib/llist.c:33) 
[ 25.914975][ T111] ? usercopy_abort (mm/usercopy.c:102) 
[ 25.915392][ T111] __check_heap_object (mm/slub.c:5508) 
[ 25.915826][ T111] __check_object_size (mm/usercopy.c:?) 
[ 25.916278][ T111] copy_uabi_to_xstate (include/linux/uaccess.h:183) 
[ 25.916728][ T111] ? fpu__restore_sig (include/linux/bottom_half.h:20 arch/x86/include/asm/fpu/api.h:72 arch/x86/kernel/fpu/signal.c:376 arch/x86/kernel/fpu/signal.c:493) 
[ 25.917173][ T111] fpu__restore_sig (arch/x86/kernel/fpu/signal.c:396) 
[ 25.917603][ T111] ? __might_fault (mm/memory.c:6233) 
[ 25.918023][ T111] ia32_restore_sigcontext (arch/x86/kernel/signal_32.c:123) 
[ 25.918496][ T111] __ia32_compat_sys_sigreturn (arch/x86/kernel/signal_32.c:?) 
[ 25.918986][ T111] do_int80_emulation (arch/x86/entry/common.c:?) 
[ 25.919423][ T111] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 25.919847][ T111] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[   25.920286][  T111] RIP: 0023:0xf7fa1092
[ 25.920664][ T111] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240611/202406111349.cf61e641-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


