Return-Path: <linux-kernel+bounces-215755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8F9096A8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C64528477C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA3217BA5;
	Sat, 15 Jun 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOmy/uFa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B9BE65
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438455; cv=fail; b=j+pI9joRiHHEVgMcpsPmZH3ateYiyBx1lWBQXjCGRGSDCOt4dyMgxEQC6yhuEwq1ANz8WU0EFlDvfUB9rzZmT94Rb4Bu2HkDhXG2OMLy+SMQPYY5fGjmv5gNaEkY1JGzrtl7FJP2YJBiwi7eiNOgrL+RjdhkgmTs7OFKvs823PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438455; c=relaxed/simple;
	bh=jba9eoPVK7EL9qJ9ErXpBSLruCEXh7tlZ0SFxDqzYVQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=K7m7YWUYfXJ9fXFo9AqvAonWYrWaSojS+TiQNSr5rcO+ojAv1CGLxGam1r7IeUfa9clc1edlSMa+ua/85wAuWw2mVJgHnOUw5H2mZ9zlDXm8x/ewv0c5/tApet1BlJe735x4OKhVrcJyIl1YtkPxahlCyN9x1u62AuEzmNAYbIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOmy/uFa; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718438452; x=1749974452;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jba9eoPVK7EL9qJ9ErXpBSLruCEXh7tlZ0SFxDqzYVQ=;
  b=UOmy/uFat6lNn46Hfl4DlY6w9qgqhhWH9aymBvw453NtRzxaM7O70ADY
   adQ4WM07x7rYjz07ZCErlOXCjtxEL/jI5MdfA4I/5V0LLRIYs06oCAs+R
   RrXClnYnH6cDoga9VI1z99YGwZYiIefJYC+a5wVafBCsxOurdMyB822nW
   OZUsTiXQ/XtG6cJmQWQPZXUBnzWqQ8RoKYoe4vCHkKesMKIPrXfXSu3Iv
   4zutV3JIhegsndF/rsWC0auUvVhBdsVcNOPzLyar7kl87aR3AXzxvzeRA
   Evz4feUdEtgE/XzMn5rKWL+vH8bW9fXfmYsu8Hr2IafwpT6KHEXh8ozxU
   Q==;
X-CSE-ConnectionGUID: 4Y7loCh2QN2a8Q1wlsvobQ==
X-CSE-MsgGUID: I6VrEHvzRb+nSLIqp8K10A==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15210624"
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="15210624"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 01:00:52 -0700
X-CSE-ConnectionGUID: teAx2/AdQ7OVVcZrXjaWOA==
X-CSE-MsgGUID: 1DR95tjiStWHSN5QQiwpjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="40671265"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jun 2024 01:00:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Jun 2024 01:00:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Jun 2024 01:00:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 15 Jun 2024 01:00:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 15 Jun 2024 01:00:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9tdjkZ38TzfpNC9hiepP+VmlAMAY4DYUsL+jyJ0ie/RxYop6L+LeFS0/yBocOqCJNXT16O2aIiqVpK1qhM6TfSxFtqvfRGSPRA55H6MYwgF0woL7Z5VCbGpHGn8V+fgXPgJTfQ9tTLXyATHaKgJIO6fwc4p7KRMOm7KU6uaRtSwR4sSfEwxqL5badE1K/d7RcrOpmKfvLm+teDiiPsdPV2UEU2KGPGs8o2jb4hbTBxrPhvXfyDQP0FizpSSjPOoA5gQuoVDC46R3O1Hhne+QPKCE4MMYeyl0N0azQXWw5gA5Qm0/RNXJVeYw3sXPCdzwnaOw6XpuWaFVfb3ivtxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6T/o16KpfljTBDak8EiIKsly3XtRQnfJqh1QfOHbLM=;
 b=dVkdMdPuQ2wg9nxRa7FgHIevdORkVXXaysM6bmxTGtb2OfILMNCdvWKE7x1ow+j0c4wxsCbqvzTS8KBAtbJ4plkEtuBRdJdt8+nemHFtDizCgxTL4DXcrlHOkNSIW3j99c9C94yk/zTiFQZQmedU5Nv0M8yqWmcrmnyS8v1CoNuk8LHCFT/IrdOWa5VjhtrPYj0ZdPGkFgDSXLeeujD1kWBmCpsmYi0A1lHGZF3odXgr5K5WAywCagjfMhAftjv4qXstqvTioOTwVKEnQcOb+0r5j7WSm8NnnI7XIFHF817qE/WR5DByejkfp6Yw4sAw2UgQj2wHBOqU0gAUuO9XTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27; Sat, 15 Jun
 2024 08:00:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7677.026; Sat, 15 Jun 2024
 08:00:47 +0000
Date: Sat, 15 Jun 2024 16:00:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski
	<luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Fenghua Yu
	<fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
	<oliver.sang@intel.com>
Subject: [tip:WIP.x86/fpu] [x86/fpu]  81106b7e0b: kernel_BUG_at_mm/usercopy.c
Message-ID: <202406151528.626affe4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: b398330b-5edf-4dba-a2b5-08dc8d1143c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mgMoOlzwFF0Q09bgZPulowrluS+XUEEs4VRGnziks20c4tBAbFDtFsnLbHKj?=
 =?us-ascii?Q?gEI31GwDAog0dy5ZK72lBGETUTdDuKgl1R88BEuHyziCFVjDO/fj6qRVWJx8?=
 =?us-ascii?Q?TBdbcIqfty95KKpKJM6EUrE1l0Yx7y6tQ8WYuMLFihLa3aRayyAG01XsxWy6?=
 =?us-ascii?Q?op3fbr7Q3atkNDWo1MGY7lFsvsTY6lMItrTl2zJXdqB4yg6A+hWCiCHcg5oa?=
 =?us-ascii?Q?W4SaT4dWoOM9eMr7PwYK/TIMTvNig820TxDRFUnCAEUd6c7TAZuiESqClDkf?=
 =?us-ascii?Q?cXLk9RUUEW/QmPmIwqGw7uSmn3M+tAHyHRXUO5ofoaGC/ll72YUXtG9EU5VJ?=
 =?us-ascii?Q?5tXkVn7jM1i2PcImMo4vX2LnlSbAmuqwCxbF9zp9coT7Gffs6YOwqxrCIAM1?=
 =?us-ascii?Q?ujfmCsM1hfRA1pfdtsFPtTxe7Aq7UBqodLiqxYi5HyUsV7e4Rx6CHA/YqYVf?=
 =?us-ascii?Q?+GJzvN6lEw2KFy6ZEm26y6CdhtKEobDtdd7qU+D4kVhKtL9wCgRq3EG98yZg?=
 =?us-ascii?Q?yY9HyL1wcMre75Hs46NSu1J03JiRC/QDpSmeavLBlyW0+uQhktoVjEkR1bFG?=
 =?us-ascii?Q?ekxRSlV7h3yuYDkdNsP7clOmWZ36iCDYwivvNsMqtOiK+J6ODpqqauxDV9Ps?=
 =?us-ascii?Q?wXX8YaYLaFbm+ZGK53ymaPDhi85V8hvuaRczv+rXsZIm4eqiUAoVfo4Rl4aA?=
 =?us-ascii?Q?3QBZH8VVY9xgc80SQhLvQcQHJb7Kq/DX9RJluo6r2BMG8KMq/9gFFLoXGSHa?=
 =?us-ascii?Q?bt4J1+X8jME18oqaUJAlrsDmyfLv0NOhGGIi4DutRAnyvE1NynQCbEdpuT68?=
 =?us-ascii?Q?mj2Di3AePsRLqpZtS+v+gf5CzUOnaHavt4sqG1p8EM7n1XJFoK4Y05wzT76/?=
 =?us-ascii?Q?BM2IFEEyTRLOBCFQixMFggK02wHRxScf0fYXzgmp3G4nk4+si6sILuG7jW7S?=
 =?us-ascii?Q?Dv9NsyE4hxg/qP/hPbCz4xCs2bjISk+gDM8gsWji7bGpk7F6Zkq8NAmaTSQS?=
 =?us-ascii?Q?WtmX/UQiYQvi5I4yqMGItZlkFdjLt9upbGydqu0qybwoIDR2fGKrJLh9dq4u?=
 =?us-ascii?Q?8Oc//Cz3+emkP4lYjCUdL+Qw6VgLVIXdrT2YlIhmx+RuKHe4OvqPQbuxvmcY?=
 =?us-ascii?Q?Pt44rhwQMRh6eeofZ1V37VRmPcWTebb+hf8IT+p1qi+PZiSl+YJPzJYAkt6Z?=
 =?us-ascii?Q?+ywWy5qfqubuRDfHdvMStplEqZKIJJtBWCBbvsi52uI9b5P8s7b/VaeTTVkO?=
 =?us-ascii?Q?KizRfDKzhK0XlxKsEzUdvfvgD2BTzNz3M+aPMQDiNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJP5RtG47I+4E6g/89bgOy8DLJuZMTuJ+S/Bn/N+3d2UHGfse2p3KPFqoHvz?=
 =?us-ascii?Q?ht5GuMH2NoPht8ucG7gdOyU1vncZNJ9qq2T/Zw5tRYwEa8FCsuP/yMOvI801?=
 =?us-ascii?Q?Tl4VIEsM2X/l4cwL/IWUimnIqYEzfPB4BRa+opz5NLfEx9p4epIqb2H15qFt?=
 =?us-ascii?Q?aWEkLe9ohxn+vEnt1TK768n+cFQ+YqvVHpMmwQulhKciORz6Wak4bb+qHASD?=
 =?us-ascii?Q?MkpFu5/xKK0qHDHZTrwj/ybWbTVG7GU4HZPjUfPh0l2VvpW3Q5qEzvc8qmVj?=
 =?us-ascii?Q?RZVWuXQTYKCFNxKzpY6USUhX8O8MBHwbJJ9dlkGhLH4p80cs5xc3pFAOS0WC?=
 =?us-ascii?Q?4SbUWdHArxwVLEOZv2WHiPD5U5p+kLzz/VFKgwCWM44fJm7MGtJCWh6Y8rNI?=
 =?us-ascii?Q?cb1NO9xuhJZgcaLbA3yfoHlhIchhLLmGZgy7zTtZa5PfVRiS9PASLRWZyTKL?=
 =?us-ascii?Q?sUeH6vBoBHZ6fk7VwEse7vcfLvt5x0Q4HdJdF61C7tj8ENDc6ayxSNw1vAj/?=
 =?us-ascii?Q?IFY84H+id6FjDLVOio9aKVvJ0l5LZtdLPczP/lNDRu3G+21tpGCY5eXwTnBk?=
 =?us-ascii?Q?949yIrx3YRGEkCI/rXfiO7emwbT/9FepCGzWPO3vi8LPqiONzmxjT9Mul9wp?=
 =?us-ascii?Q?+5Bq5OGQ31Gt77k271PXnAFWmLnb2mkTjDK5u1KhbVN2UmBgfIlqNellEmGd?=
 =?us-ascii?Q?acoRlfBxGQ6dVJanjz1LY1KlGzV1HOIqNu5/5seV0FOeoJY0E2RSyVvX5ONB?=
 =?us-ascii?Q?3K1UuZiYJExCOcb2d1OMOrs5M3+D49rjTBc6DOnQ5Qoz6chksTVMeS1D15wz?=
 =?us-ascii?Q?iXiiuMWPZAFPMrAj/vqiicn5B9ezS+1xeq0UKR5qEbtKHps+y5bq2g+drmSl?=
 =?us-ascii?Q?xKkOI1e9+TTFf5ivZDJKqRRDiDegutdWmtymV0CxYZPB4Yym5LYSJiRCfiHQ?=
 =?us-ascii?Q?3nqB50O4CWmokbwCNGllKoDPGjvQUhTxjSGJd2SZQ0Hs1xKB1xoEEMvK4JWA?=
 =?us-ascii?Q?0dg1oMgLXgdDi2pVrCgWgAmDeNFWm++5Hj29YtRY/y0rUZ8yf2SV/5JaziRX?=
 =?us-ascii?Q?UZzkx6h8fTxQq5E6EZhU+69ukShnXTuaGpL1ZV4CuzS+3EIBO0VP/upwrVQb?=
 =?us-ascii?Q?PVbtVod8XzKz91dvkRttCdLSOCgT9N0R1ZWx1klqMTgVJ5sPckx8pbkimp4Z?=
 =?us-ascii?Q?+KEbETai+pxJV0hpnnqy6XLbUlaYB9BeRROCdTonT+m41GDwUgEfLCy/ICuJ?=
 =?us-ascii?Q?nNeKje1Uow3CCSMDhNawb+29mN85q4XCu0UQz314vYVaqs0OpRTh+qUsIhD/?=
 =?us-ascii?Q?d35BPvGlPHTwbnN87aKmMvOkBA7acPBj5+/KTjsOWuk+BcFoQpbM9Kf1DSZQ?=
 =?us-ascii?Q?4Us/mtJTdeQvFVL2D8BG+gdmJitoQBkWuy2BMuwB8NU7igIvnlO/rOZbHUh3?=
 =?us-ascii?Q?1l2O8kYvMWGbyoP0jWa9Wij8hdb134LVkDSHjR5xL5F9d2LTYvdVghF0m93D?=
 =?us-ascii?Q?RPrqhh5oPpxd5rE0NuJP/UksVYYUrtGfdtoFzINBEtfR+g0fjKGis7ChYFd6?=
 =?us-ascii?Q?yWPP6ueDjrmoyorWNnKWjRVo3FWfKqv4AlLz6nxxVjJP9edXJ1USGwcFG+RN?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b398330b-5edf-4dba-a2b5-08dc8d1143c3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 08:00:47.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsGGd9SG0tvZo1/IkyCV9qHF0YRKpoydONZaMd01oEJlyKs1OpF1B59ThnRh7duNZ1NJOn6MxkAnonqbgz3Jkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_mm/usercopy.c" on:

commit: 81106b7e0b136e96a4116efdd5fe3df2b6a478b9 ("x86/fpu: Make task_struct::thread constant size")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.x86/fpu

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | c822542ba0 | 81106b7e0b |
+------------------------------------------+------------+------------+
| boot_successes                           | 6          | 0          |
| boot_failures                            | 0          | 6          |
| kernel_BUG_at_mm/usercopy.c              | 0          | 6          |
| Oops:invalid_opcode:#[##]PREEMPT         | 0          | 6          |
| EIP:usercopy_abort                       | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 6          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406151528.626affe4-oliver.sang@intel.com


[   22.451041][  T128] ------------[ cut here ]------------
[   22.451886][  T128] kernel BUG at mm/usercopy.c:102!
[   22.452684][  T128] Oops: invalid opcode: 0000 [#1] PREEMPT
[   22.453567][  T128] CPU: 0 PID: 128 Comm: nfs-utils_env.s Not tainted 6.10.0-rc3-00003-g81106b7e0b13 #1
[   22.454983][  T128] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 22.456474][ T128] EIP: usercopy_abort (mm/usercopy.c:102) 
[ 22.457246][ T128] Code: c9 89 44 24 0c 0f 45 cb 8b 5d 0c 89 74 24 10 89 4c 24 04 c7 04 24 50 bc 5e c9 89 5c 24 20 8b 5d 08 89 5c 24 1c e8 87 03 df ff <0f> 0b b8 94 16 bd c9 e8 fb b8 7c 00 ba b2 dd 53 c9 89 55 f0 89 d6
All code
========
   0:	c9                   	leave
   1:	89 44 24 0c          	mov    %eax,0xc(%rsp)
   5:	0f 45 cb             	cmovne %ebx,%ecx
   8:	8b 5d 0c             	mov    0xc(%rbp),%ebx
   b:	89 74 24 10          	mov    %esi,0x10(%rsp)
   f:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
  13:	c7 04 24 50 bc 5e c9 	movl   $0xc95ebc50,(%rsp)
  1a:	89 5c 24 20          	mov    %ebx,0x20(%rsp)
  1e:	8b 5d 08             	mov    0x8(%rbp),%ebx
  21:	89 5c 24 1c          	mov    %ebx,0x1c(%rsp)
  25:	e8 87 03 df ff       	call   0xffffffffffdf03b1
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 94 16 bd c9       	mov    $0xc9bd1694,%eax
  31:	e8 fb b8 7c 00       	call   0x7cb931
  36:	ba b2 dd 53 c9       	mov    $0xc953ddb2,%edx
  3b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  3e:	89 d6                	mov    %edx,%esi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 94 16 bd c9       	mov    $0xc9bd1694,%eax
   7:	e8 fb b8 7c 00       	call   0x7cb907
   c:	ba b2 dd 53 c9       	mov    $0xc953ddb2,%edx
  11:	89 55 f0             	mov    %edx,-0x10(%rbp)
  14:	89 d6                	mov    %edx,%esi
[   22.459949][  T128] EAX: 00000068 EBX: 00001640 ECX: 00000000 EDX: 00000000
[   22.460949][  T128] ESI: c94cf3fb EDI: c94dc8a4 EBP: ec1f3c6c ESP: ec1f3c38
[   22.461961][  T128] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
[   22.463133][  T128] CR0: 80050033 CR2: 0062807c CR3: 2c016aa0 CR4: 000406f0
[   22.464147][  T128] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   22.465130][  T128] DR6: fffe0ff0 DR7: 00000400
[   22.465875][  T128] Call Trace:
[ 22.466464][ T128] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 22.467142][ T128] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 22.467764][ T128] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[ 22.468412][ T128] ? do_error_trap (arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:176) 
[ 22.469115][ T128] ? usercopy_abort (mm/usercopy.c:102) 
[ 22.469833][ T128] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 22.470522][ T128] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 22.471267][ T128] ? usercopy_abort (mm/usercopy.c:102) 
[ 22.484908][ T128] ? handle_exception (arch/x86/entry/entry_32.S:1047) 
[ 22.485714][ T128] ? cpu_latency_qos_update_request (kernel/power/qos.c:311) 
[ 22.486588][ T128] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 22.487277][ T128] ? usercopy_abort (mm/usercopy.c:102) 
[ 22.487991][ T128] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 22.488682][ T128] ? usercopy_abort (mm/usercopy.c:102) 
[ 22.489399][ T128] __check_heap_object (mm/slub.c:5509) 
[ 22.490145][ T128] check_heap_object (mm/usercopy.c:196) 
[ 22.490904][ T128] __check_object_size (mm/usercopy.c:113 mm/usercopy.c:127 mm/usercopy.c:254 mm/usercopy.c:213) 
[ 22.491681][ T128] copy_from_buffer (include/linux/uaccess.h:183 arch/x86/kernel/fpu/xstate.c:1202) 
[ 22.492401][ T128] copy_uabi_to_xstate (arch/x86/kernel/fpu/xstate.c:1282 (discriminator 1)) 
[ 22.493151][ T128] copy_sigframe_from_user_to_xstate (arch/x86/kernel/fpu/xstate.c:1333) 
[ 22.494036][ T128] __fpu_restore_sig (arch/x86/kernel/fpu/signal.c:396 (discriminator 1)) 
[ 22.494785][ T128] fpu__restore_sig (arch/x86/kernel/fpu/signal.c:497 (discriminator 1)) 
[ 22.495501][ T128] ia32_restore_sigcontext (arch/x86/kernel/signal_32.c:123) 
[ 22.496318][ T128] __do_sys_sigreturn (arch/x86/kernel/signal_32.c:139 (discriminator 1)) 
[ 22.497061][ T128] ia32_sys_call (arch/x86/entry/syscall_32.c:42) 
[ 22.497784][ T128] do_int80_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:339 (discriminator 1)) 
[ 22.498530][ T128] ? __do_sys_vfork (kernel/fork.c:2903) 
[ 22.499251][ T128] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4599) 
[ 22.500172][ T128] ? switch_fpu_return (arch/x86/include/asm/trace/fpu.h:57 (discriminator 2) arch/x86/kernel/fpu/context.h:50 (discriminator 2) arch/x86/kernel/fpu/context.h:76 (discriminator 2) arch/x86/kernel/fpu/core.c:788 (discriminator 2)) 
[ 22.500903][ T128] ? syscall_exit_to_user_mode (kernel/entry/common.c:221) 
[ 22.501733][ T128] ? do_int80_syscall_32 (arch/x86/entry/common.c:343) 
[ 22.502481][ T128] ? irqentry_exit (kernel/entry/common.c:367) 
[ 22.503186][ T128] ? do_fast_syscall_32 (arch/x86/entry/common.c:411 (discriminator 1)) 
[ 22.503932][ T128] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   22.504637][  T128] EIP: 0xb7fa4579
[ 22.505239][ T128] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:*	5d                   	pop    %rbp		<-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d 76 00             	lea    0x0(%rsi),%esi
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	8d                   	.byte 0x8d
  3f:	76                   	.byte 0x76

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d 76 00             	lea    0x0(%rsi),%esi
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	8d                   	.byte 0x8d
  15:	76                   	.byte 0x76


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240615/202406151528.626affe4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


