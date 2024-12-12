Return-Path: <linux-kernel+bounces-443229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E09EE90F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EFD1886EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F6216E2B;
	Thu, 12 Dec 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGpzqkgP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CD21578C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014258; cv=fail; b=tiKIRJQe41soJYwiYZI7BrKSPgYD2alcqFB/PXvA1Gm2bj2SnCh1SVX0ssI4H1jvkEUOn/BsxGKz2pft/uoyDrlTpcgN7wR5DtpnW8TZiGceaAaCvDWLWdarC+QLboLOpnk9cL5X9qQiKDmmJjZHUlafp4mYIaW/CucNWw1uWfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014258; c=relaxed/simple;
	bh=YCkwyigGb/KG098K4zfH4379wjPnOns+z8ST/UWshnI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L5rQ12NVrguGPlvVM9Vc7d5VrwJ2aayUCD/UBDUVM9yE02yZqzhN0uLTPs/nASr6xctqYnQGP9hiboAvultNqtb+671ucdjPGrzRwAJTXp96ImfEUZfkYWeySvEIgMd9+alUFCAaq5ihZLNgVLmmabHmOm2EzAxiZVIvWxm9ydU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGpzqkgP; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734014256; x=1765550256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YCkwyigGb/KG098K4zfH4379wjPnOns+z8ST/UWshnI=;
  b=XGpzqkgPPRM//LQZFn2Y1EMGtxUfz2O6uFh/02ymXTAqR9XNJiI85OdW
   WUxesdiyMAcsx7ozGH1tiWyqwTDt34gQOBe0z8vGLCcMi2UB7+G9H0Fkx
   CwhseGcBDBRBujvVeMJFRWfURLhkiwbxaFiNtoSrMqybeTgPeQ/zKU51Y
   nFuocWL6cuR0E3GmxK/ErCXp1TfWTlJ2WjemaTjCscMvdsQFCLEbYTrzX
   gKpnUKWks0RUCSjM2rEOHEXcE3kt+gOkveJwfRxL/vSO4u63gOsqXZXbs
   qgh4+4JNC8ed98h6CSGm/lAqzg8ZaXZ69z3U2vVfo0HQ8FyFfeNYauITC
   w==;
X-CSE-ConnectionGUID: cSp2LoktQ4iNKldQdM/0uw==
X-CSE-MsgGUID: a2gqrqSRQGuO4ZGZ4cZ2Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="45114707"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="45114707"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:37:35 -0800
X-CSE-ConnectionGUID: foHsiYbnS86zEYN+yeok0w==
X-CSE-MsgGUID: A/x6bMzuRDGFRV5EXZFstA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96788069"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 06:37:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 06:37:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 06:37:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 06:37:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e21v8pZN7qWrVftgi/pJBPYIZP0dQVgOKLM4FeVnrP3xYrtilll0cS1bWUGy5nrenPTx0UiJF3XTypq3kpGNGIVxTI3da5YjgT1vgyatMDRkXLZU+BC2HLSkwwOi5ov6ST4wTBYr4+WBtOgv9AQ2QxmBn8NC0XStbpCVXWjfVvXUmuSmr4TnGNIafOn1mSQa5wUy3bL0I9Z64L7TkywjSUlNhSds2h10qsrzaRVaZMVdU4HjyMKnjIS1ptCWL010iKA4iQGoLUjj0lDVhA2cnTIDjnIGjtOZBTgKcdmROuGH8ZtTdWJqeq0AeEz48Sbd1wDWpLJv+iMgXtmPI67XVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ4lFtR3+cjNQtXjk2gnTXTX94CoV2ynXUQgY6AmJDM=;
 b=DanLgn0JHk6nDMk4PImjTmWtVXPYGbaS3wUoZHCRI6N9zuM5CuWt2eQtPptt7k7zM5XtbCciphNCvHl0/+CxnloyuJXPWBndYJNYNw+B9/Z1DnR4L6MuMS7TR4RnAHsvqqtnqfMkVCwkjKSPnTGCOH/9d1jipTWKclBxJWdaxls0wyHcRkrGPHVArs5PRHXmOCFE/JW/uECERR78Bh7jPxDFAF5b3u+zC+Oinvxjl3tR27KFWn81IZz2zLYPZaSgLDmNs/kBZnOvz5554f7eJkTV1bydH41pRZRvanE7b037WSDuZJmjpu6n3D0YntF2fYBFOsTmLHU1y2M9XI2yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6570.namprd11.prod.outlook.com (2603:10b6:303:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Thu, 12 Dec
 2024 14:37:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 14:37:05 +0000
Date: Thu, 12 Dec 2024 22:36:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
	<mcgrof@kernel.org>, kdevops <kdevops@lists.linux.dev>, Andreas Larsson
	<andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov
	<bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen
	<chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Johannes Berg
	<johannes@sipsolutions.net>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Rutland
	<mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Matt Turner
	<mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Oleg Nesterov
	<oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra
	<peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King
	<linux@armlinux.org.uk>, Song Liu <song@kernel.org>, Stafford Horne
	<shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan
	<surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Thomas
 Gleixner" <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, "Vineet
 Gupta" <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [x86/module]  5185e7f9f3:
 BUG:soft_lockup-CPU##stuck_for#s![perf:#]
Message-ID: <202412122201.67d21c2b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d6377c-afd0-4bf5-e12d-08dd1aba72fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R2J5jgNtikny/VEkNB15+BVS7RgpTEpcMcNZOPvBDkJhM3g0ah7YKsXh+TAO?=
 =?us-ascii?Q?ctUhp1ZuXqYGt+eSbiLy+L9s8bDOqM2g3Pl+JRn9l3QNLtsgEIICG74Nrnx9?=
 =?us-ascii?Q?I8T4J4hdhwdbTxMln/uzKN4yusFs01S2UTSlwmHgQUWaGiN+4qkiNWy9ALEj?=
 =?us-ascii?Q?r9JDZScemBU5CBt9jPdwlRMKD7i6BF1PUxskl80IiaZle5IGXUNiMOUXYjA4?=
 =?us-ascii?Q?3XuPHututllnxhFgqimlD2uFVqUoV9Omwot8ZZK/k8IwliST/ZTLpNe9Rd4o?=
 =?us-ascii?Q?x8GNd05FzsNpqGnPzRIqlCJdOLAnxhTwfOtLkhZHyMwmJpzEDS8dwvmAwsW9?=
 =?us-ascii?Q?TZ37AHGz5t3e8ir10RM8BCKvYCKgNk29H/ix2xKSUzBR2vfQVvHG/njwG6eI?=
 =?us-ascii?Q?7lIgA4YdENO2JVwqKwSCOTzVkSQZosAnv4+ZpGHbTRejxR6LmeuLeu/UpZic?=
 =?us-ascii?Q?cxvFMuLMoCNm+2PxpG0Pk7KO/atHCVzj7gmNYUmdRZuy/Tiodx3QAZR90+zM?=
 =?us-ascii?Q?RARDCD90+EV1keFqwvTbVO7ZbCQVl6Oin0628O9Nt8sTNRCEU7BGhyIQij2d?=
 =?us-ascii?Q?VlFdMMmF86c9gE58GuzNQf7znd98H2sB6/bBdJP1jnWco8w/dj7/eqTfVgQO?=
 =?us-ascii?Q?Cu87GCTgDS6X8QzeSKIzHFANjWn4kymszz0ZPr5AR/mM1JgPRscnp7dCIgw9?=
 =?us-ascii?Q?jZNPGFK3nzroYEPcsjFolBRO8NAXyIyOjpPKt+892XYfKBfd3amoCWSxdYnR?=
 =?us-ascii?Q?tFIM5ykv0oGopBfTbrFkpvT6BdPHMDMnG942mng8HhTgRbMxQ3j82DzUtnrL?=
 =?us-ascii?Q?BZ26rkUQ1VAGilmPi4YpMmXN3qt0DjbN2+u/L2xqRVrGi/0j03jrnwxdhUI7?=
 =?us-ascii?Q?shcH9F2972TXomJ9J/Zhxd+jI+JZtmpNpGdVMucZ9Gvq0ajkfQFcERE3P4z9?=
 =?us-ascii?Q?NBykWJ31pvwjQvNXYMmU6SPDBRXoIjuRNjgmiyI55Ai1sVgj7MmscWlSAI3i?=
 =?us-ascii?Q?ciZ4Wwn+pg6Mind9zn32A/3gP/rndV1/WmIAQAwnyN2v7VIqQMAKNiW6CTk9?=
 =?us-ascii?Q?EHNplnl5uhFgjqFu92yhV186YO1DQ2oj3WLQyUWFdejuYOgxwJ2wzKocHvpa?=
 =?us-ascii?Q?vSoMMW5I7zLM5XYBDlObE3izemompEorXop7alisfptiAo4iSC9EwGapsp6a?=
 =?us-ascii?Q?mhFdr4ysRHnUQ7xw2ZlW4uwldM23uPz5sKNlZPRQlH2lrDaKvCOeUREWWOay?=
 =?us-ascii?Q?zMUZHchjlBjWEE3PeV3hlgSJbZ4fpQowxkscXBSC5n1rIhqqC3CmlS7O29gg?=
 =?us-ascii?Q?8va5ZIYmEc2WEZFo3RqfteIY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wu7R+AfOczuyQDl/+9xbJ+FAVXvWmim03kn1JLSediuCO7QPBs6psxLSlPf1?=
 =?us-ascii?Q?YGvMhFhcQ5TP0L3frAjQRwWAi9tn2YONGVKyPGte8vKqAvmCb9GYPFMmonXr?=
 =?us-ascii?Q?qkMMiGH0XmqZDKoeeEQwpJRTIJSvXOalnPi7D7W65pzABdtVQL90ed7BTLiU?=
 =?us-ascii?Q?Osnahd8xmiw2sASAAjAA9yhA37Hrj+6mmkIrsOwa3O2eXvCY6apIlL4bRFbD?=
 =?us-ascii?Q?GhOch29It+LzEvFxtHFHXdSPjeHhBV4q+Zpt+fgG8g9poGemykGjlMiEGRlg?=
 =?us-ascii?Q?S6MF/Ekfi49nAbTuZ5VlGqSJ3wtvjk+qYzBrPz1F9rii09BObac1uwlIubPz?=
 =?us-ascii?Q?Hrn9nv0hwmhhwz5tfpaD8kYixP3A7XagAAVF6byqW2W471wIIMnj0ehkB+Vs?=
 =?us-ascii?Q?63mmy/jusXlrTz6SJMjs+yuQiVnXpgk3yFA/jjrnw06+9UmD4k+LC8x3szhL?=
 =?us-ascii?Q?MbmqQFIgs+MBMntNHiWRTIYW0G+LgnhFBvH+NPV+/IHdvS82DEzJh89t68sQ?=
 =?us-ascii?Q?pRrUnmaK7+lPIxruutZlhPzfYE8HR9fiKdNtAVuv+8VPGf5NWjfYDatwGLXn?=
 =?us-ascii?Q?l76cMIUqy60WLhimVOj7xnzjZSpyHhyRUhrwkYYA0flBtY72OUkmSK/lcPou?=
 =?us-ascii?Q?4N+uZUBLqc69IyTRWcryAWX1J7omPMs4YwWCHkTbgk1w4r4V5klTtrz8HDjE?=
 =?us-ascii?Q?eEx4rmB903Cz6o/EVzXzdHYpuMvdc9YB1d7yhKsX5lVw/TDvt+ttEH3yXxWC?=
 =?us-ascii?Q?q2akWKU+2ek6FsrvkoMp6xq721AeBC1GcAOyzJtyGAKbCROH607jvqOosxS+?=
 =?us-ascii?Q?msxF6j+2h856AM3jVjR6qPlikYbcr7DGs6bA3sTjBfRfO3YKCzNOILof+VRw?=
 =?us-ascii?Q?XXSOtGZGCHbluLtQRAQHgXlXvJK58L6752l3/MCl/DvB9+qUsICFCAXQzMI+?=
 =?us-ascii?Q?NQ+oQmaGq+u9hXceZQwcS+LMO2wOluRp5uopjuiNM8+9mVCvgv662eB3Fp0O?=
 =?us-ascii?Q?cpN3PIk6xvGMa244oyD21xPImcQ3zTXGefGY1YynHrVV/Mo6eDKHkcX/QVBJ?=
 =?us-ascii?Q?R4sdhKfLXBX2uHA/993S9q+1egQ9nxhLbG8aJ9O1u8qYI89zbHVpU9T1l7/l?=
 =?us-ascii?Q?8gRt4Yi1LmkheRAsfwcJmSz1ok6pyN15tV9lIe+tMjuJYsSbSV5JT5gUlQqq?=
 =?us-ascii?Q?emesIzN/hRuBAmEzdBWmkc6b8KR+VTTL30P/h4fl+LeXFsBXrmrgbM1dYdnk?=
 =?us-ascii?Q?7PHYiOCwaHYJtPIeOhl0WToMp8yOghNyRnZ/wDXs7SQ8qRU8aUYDfWeG5B9j?=
 =?us-ascii?Q?J3OW4zar85V2JCVcrPidJrJLn4LbDin0PPJ5S4RIsT7LVdDPfsy7rHtWceBJ?=
 =?us-ascii?Q?huDhsXR4TyNtKQrrCTdiPyhKewLozfhJ3kkIPAFRYFKumapGganhrqcf4Gko?=
 =?us-ascii?Q?/E+Kvdp0BWIA51a27U0Bfahi48mOSxSeeSsKqiihBzphJBAl2zKMcxwEyiEi?=
 =?us-ascii?Q?e+GanoUSFjg+1jA9pbOYhK4Y/KnJg0+UmmNP6ll5MZUpHnx4UzkYzVRvvPXj?=
 =?us-ascii?Q?qe/oke4bnCswKRLTIzH+xapl/B39tI0sSG5aDjr2tcb00hSQdmmVX3hVQJ5f?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d6377c-afd0-4bf5-e12d-08dd1aba72fa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:37:05.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bztDFPE+yxbVt34Ss/NVXiDYdcMslnMzGTsnYW+p02fiWpJeQ3yBWXfvdc3gjPfLgixgaomVAVte1g6PXFfCWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6570
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![perf:#]" on:

commit: 5185e7f9f3bd754ab60680814afd714e2673ef88 ("x86/module: enable ROX caches for module text on 64 bit")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      7503345ac5f5e82fd9a36d6e6b447c016376403a]
[test failed on linux-next/master ebe1b11614e079c5e366ce9bd3c8f44ca0fbcc1b]

in testcase: lkvs
version: lkvs-x86_64-2187c57-1_20241102
with following parameters:

	test: pt



config: x86_64-dcg_x86_64_defconfig-func
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412122201.67d21c2b-lkp@intel.com


[  737.450753][   C63] watchdog: BUG: soft lockup - CPU#63 stuck for 26s! [perf:95490]
[  737.460225][   C63] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp dax_hmem ofpart iTCO_wdt cxl_acpi qat_4xxx intel_pmc_bxt kvm_intel spi_nor cxl_port pmt_telemetry iTCO_vendor_support mtd ipmi_ssif kvm isst_if_mbox_pci intel_th_gth isst_if_mmio intel_sdsi pmt_class intel_qat i2c_i801 cxl_core mei_me spi_intel_pci pinctrl_emmitsburg ast crc32c_intel einj pinctrl_intel intel_th_pci dh_generic drm_shmem_helper cdc_ether isst_if_common idxd mei i2c_smbus crc8 intel_vsec intel_th i2c_ismt spi_intel ipmi_si joydev pwm_lpss acpi_power_meter btrfs binfmt_misc fuse ip_tables
[  737.536652][   C63] CPU: 63 UID: 0 PID: 95490 Comm: perf Tainted: G S                 6.12.0-rc6-00142-g5185e7f9f3bd #1
[  737.549630][   C63] Tainted: [S]=CPU_OUT_OF_SPEC
[  737.555668][   C63] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.8118.D04.2206151341 06/15/2022
[ 737.569144][ C63] RIP: 0010:find_vmap_area_exceed_addr_lock (mm/vmalloc.c:1034 mm/vmalloc.c:1066)
[ 737.577511][ C63] Code: 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85 62 02 00 00 48 8b 5b 10 48 85 db 74 3b 48 8d 7b f8 48 89 f8 48 c1 e8 03 42 80 3c 38 00 <0f> 85 f1 01 00 00 4c 3b 73 f8 72 a9 48 8d 7b 08 48 89 f8 48 c1 e8
All code
========
   0:	89 f8                	mov    %edi,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   b:	0f 85 62 02 00 00    	jne    0x273
  11:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
  15:	48 85 db             	test   %rbx,%rbx
  18:	74 3b                	je     0x55
  1a:	48 8d 7b f8          	lea    -0x8(%rbx),%rdi
  1e:	48 89 f8             	mov    %rdi,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  2a:*	0f 85 f1 01 00 00    	jne    0x221		<-- trapping instruction
  30:	4c 3b 73 f8          	cmp    -0x8(%rbx),%r14
  34:	72 a9                	jb     0xffffffffffffffdf
  36:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  3a:	48 89 f8             	mov    %rdi,%rax
  3d:	48                   	rex.W
  3e:	c1                   	.byte 0xc1
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 85 f1 01 00 00    	jne    0x1f7
   6:	4c 3b 73 f8          	cmp    -0x8(%rbx),%r14
   a:	72 a9                	jb     0xffffffffffffffb5
   c:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  10:	48 89 f8             	mov    %rdi,%rax
  13:	48                   	rex.W
  14:	c1                   	.byte 0xc1
  15:	e8                   	.byte 0xe8
[  737.600980][   C63] RSP: 0018:ffa0000035d3f7c0 EFLAGS: 00000246
[  737.608491][   C63] RAX: 1fe220043da2917a RBX: ff110021ed148bd8 RCX: ffffffff813cb361
[  737.618177][   C63] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ff110021ed148bd0
[  737.627846][   C63] RBP: 000000000000005e R08: 0000000000000001 R09: fff3fc0006ba7eea
[  737.637506][   C63] R10: 0000000000000003 R11: 00007fece9080fff R12: ffffffffc0801000
[  737.647177][   C63] R13: ff1100010c992bc8 R14: ffffffffc0600000 R15: dffffc0000000000
[  737.656846][   C63] FS:  00007fed2a754840(0000) GS:ff11003fcc180000(0000) knlGS:0000000000000000
[  737.667580][   C63] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  737.675680][   C63] CR2: ff1100013ca00000 CR3: 0000002169956003 CR4: 0000000000f73ef0
[  737.685338][   C63] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  737.694977][   C63] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  737.704624][   C63] PKRU: 55555554
[  737.709273][   C63] Call Trace:
[  737.713624][   C63]  <IRQ>
[ 737.717447][ C63] ? watchdog_timer_fn (kernel/watchdog.c:762)
[ 737.723792][ C63] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:677)
[ 737.730545][ C63] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1691 kernel/time/hrtimer.c:1755)
[ 737.737187][ C63] ? __pfx___hrtimer_run_queues (kernel/time/hrtimer.c:1725)
[ 737.744234][ C63] ? ktime_get_update_offsets_now (kernel/time/timekeeping.c:195 (discriminator 3) kernel/time/timekeeping.c:395 (discriminator 3) kernel/time/timekeeping.c:403 (discriminator 3) kernel/time/timekeeping.c:2449 (discriminator 3))
[ 737.751558][ C63] ? hrtimer_interrupt (kernel/time/hrtimer.c:1820)
[ 737.757924][ C63] ? __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1038 arch/x86/kernel/apic/apic.c:1055)
[ 737.765354][ C63] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049)
[  737.772485][   C63]  </IRQ>
[  737.776390][   C63]  <TASK>
[ 737.780307][ C63] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702)
[  737.787823][   C63]  ? 0xffffffffc0600000
[ 737.793079][ C63] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
[ 737.799294][ C63] ? find_vmap_area_exceed_addr_lock (mm/vmalloc.c:1034 mm/vmalloc.c:1066)
[  737.806842][   C63]  ? 0xffffffffc0600000
[  737.812040][   C63]  ? 0xffffffffc0600000
[ 737.817228][ C63] vread_iter (mm/vmalloc.c:4354)
[ 737.822483][ C63] ? __pfx_fault_in_safe_writeable (mm/gup.c:2185)
[ 737.829690][ C63] ? __pfx_vread_iter (mm/vmalloc.c:4337)
[  737.835622][   C63]  ? 0xffffffffc0600000
[  737.840761][   C63]  ? 0xffffffffc0600000
[ 737.845890][ C63] read_kcore_iter (fs/proc/kcore.c:534)
[  737.851801][   C63]  ? 0xffffffffc0600000
[ 737.856897][ C63] ? __pfx_read_kcore_iter (fs/proc/kcore.c:325)
[ 737.863261][ C63] ? __filemap_add_folio (mm/filemap.c:943)
[ 737.869597][ C63] ? __pfx___filemap_add_folio (mm/filemap.c:852)
[ 737.876300][ C63] ? __pfx_workingset_update_node (mm/workingset.c:617)
[ 737.883288][ C63] ? preempt_count_add (include/linux/ftrace.h:976 kernel/sched/core.c:5777 kernel/sched/core.c:5774 kernel/sched/core.c:5802)
[ 737.889298][ C63] ? __folio_batch_add_and_move (arch/x86/include/asm/preempt.h:103 mm/swap.c:246)
[ 737.896253][ C63] ? preempt_count_add (include/linux/ftrace.h:976 kernel/sched/core.c:5777 kernel/sched/core.c:5774 kernel/sched/core.c:5802)
[ 737.902233][ C63] ? copy_page_from_iter_atomic (include/linux/highmem-internal.h:234 lib/iov_iter.c:484)
[ 737.909273][ C63] ? __vfs_getxattr (fs/xattr.c:419)
[ 737.914937][ C63] ? __pfx_copy_page_from_iter_atomic (lib/iov_iter.c:462)
[ 737.922254][ C63] ? simple_write_end (arch/x86/include/asm/atomic.h:67 include/linux/atomic/atomic-arch-fallback.h:2278 include/linux/atomic/atomic-instrumented.h:1384 include/linux/page_ref.h:205 include/linux/mm.h:1141 include/linux/mm.h:1146 include/linux/mm.h:1477 fs/libfs.c:985)
[ 737.928198][ C63] ? generic_perform_write (mm/filemap.c:4077)
[ 737.934609][ C63] ? __pfx___fsnotify_parent (fs/notify/fsnotify.c:216)
[ 737.941037][ C63] ? file_update_time (fs/inode.c:2272)
[ 737.946882][ C63] ? preempt_count_add (include/linux/ftrace.h:976 kernel/sched/core.c:5777 kernel/sched/core.c:5774 kernel/sched/core.c:5802)
[ 737.952802][ C63] proc_reg_read_iter (fs/proc/inode.c:299)
[ 737.958732][ C63] vfs_read (fs/read_write.c:488 fs/read_write.c:569)
[ 737.963662][ C63] ? __pfx_vfs_read (fs/read_write.c:550)
[ 737.969169][ C63] ? __asan_memset (mm/kasan/shadow.c:84)
[ 737.974591][ C63] ? preempt_count_add (include/linux/ftrace.h:976 kernel/sched/core.c:5777 kernel/sched/core.c:5774 kernel/sched/core.c:5802)
[ 737.980499][ C63] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 fs/file.c:1150 fs/file.c:1158)
[ 737.985704][ C63] ksys_read (fs/read_write.c:713)
[ 737.990625][ C63] ? __pfx_ksys_read (fs/read_write.c:702)
[ 737.996234][ C63] ? fpregs_assert_state_consistent (arch/x86/kernel/fpu/context.h:38 arch/x86/kernel/fpu/core.c:822)
[ 738.003307][ C63] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 738.008632][ C63] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  738.015535][   C63] RIP: 0033:0x7fed2b67b19d
[ 738.020760][ C63] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d 66 54 0a 00 e8 49 ff 01 00 66 0f 1f 84 00 00 00 00 00 80 3d 41 24 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
All code
========
   0:	31 c0                	xor    %eax,%eax
   2:	e9 c6 fe ff ff       	jmp    0xfffffffffffffecd
   7:	50                   	push   %rax
   8:	48 8d 3d 66 54 0a 00 	lea    0xa5466(%rip),%rdi        # 0xa5475
   f:	e8 49 ff 01 00       	call   0x1ff5d
  14:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  1b:	00 00 
  1d:	80 3d 41 24 0e 00 00 	cmpb   $0x0,0xe2441(%rip)        # 0xe2465
  24:	74 17                	je     0x3d
  26:	31 c0                	xor    %eax,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 5b                	ja     0x8d
  32:	c3                   	ret
  33:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  3a:	00 00 00 
  3d:	48                   	rex.W
  3e:	83                   	.byte 0x83
  3f:	ec                   	in     (%dx),%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 5b                	ja     0x63
   8:	c3                   	ret
   9:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  10:	00 00 00 
  13:	48                   	rex.W
  14:	83                   	.byte 0x83
  15:	ec                   	in     (%dx),%al


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241212/202412122201.67d21c2b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


