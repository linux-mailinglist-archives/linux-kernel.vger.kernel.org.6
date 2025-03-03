Return-Path: <linux-kernel+bounces-542653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37311A4CBFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3900F1894C76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FEA2288EE;
	Mon,  3 Mar 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb79G5T7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A351C8604;
	Mon,  3 Mar 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030286; cv=fail; b=ZDB+NBUa1Fxp8/XJQzpScUTMwnmpdmOQymL11jTLGcnrE0MEXApCW0+0VxIMeKKR6aTuMxx72zoYKCtJIL0737wumSawF7ts6a5Q0V8+F/ejIJF4DqNaAIXowQPxbZQwUFuWjkjfrS2Y3ryalG2ZziMSnzZEJ549e9c7jf0o/lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030286; c=relaxed/simple;
	bh=yxJtntzEwS7h1mvCxf5nTkIGHW3fLBo4G+WpMJ+6zkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYMSW16uFdpaA3lQjL34z3py9lGiFjeVCsZG8/fSZT5vRvgOVT/EzFKoIOkWrgnAbQIhwDrRvC6kvGfi+eG+BCqIxiiLaatkWjWdx+DhbjvzOD/ptXgyykxAp4veXSj+qzpllvoZ9U6XRBN9VFpKzgFLa11KnOFKR+nAs++mctU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb79G5T7; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741030285; x=1772566285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yxJtntzEwS7h1mvCxf5nTkIGHW3fLBo4G+WpMJ+6zkc=;
  b=Wb79G5T7WP+/LLYKvO7Dx7MAAEpZwqjphxKLrV0+x/AQjyDEKWAtfhl8
   XLUOXKux3gkskmILPRBdTloszcV7nwUX4kqUQWNz7ZSotvxFqQKtVEsNC
   Sd0jqsBMU/tvHMmAsJgzx+EfK01rrhT1Eq8rk/gUQjTKemydOgOb1efJB
   cVQan5bOlQ95slPapVevjW+6iTTU3Kjmi8MUwDNbQBsw0hn3I8XYTn57l
   hUtwhG3Hl9zg13JkCpvijQZQ8cwv13vjFReXiBJ9SaH2vZlCelt9Jbx5n
   OdzgRKGPfheHe+Va5cVWNntJTgzfdNanULDkiL7NP9EwEQ5wMaLYt4SbZ
   w==;
X-CSE-ConnectionGUID: ey49buqrS9W9kHSSX0aBQw==
X-CSE-MsgGUID: Zmmxwb6dTu2ee+a9GCDAHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53328185"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="53328185"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:31:24 -0800
X-CSE-ConnectionGUID: oiBB6zF+RYyhUsnu1AiGUA==
X-CSE-MsgGUID: 1sh9eXX4T2SQfv01KDydZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118130575"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 11:31:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 11:31:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 11:31:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 11:31:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BadWsjiHfkUcX/yUVyWFY3AiXAqFQIOFlU8hPhiHiLyeXCfumbm3ybLDojdgmhiurSz5Vqs+xKcghCoJZ2SiDjU0cxdJluSPj/FxGrWZqtO9X/KRqMdXIeayIxo9WL/eSmR58HDgon7ZQfctXWion1XBqoXuYjMEQy/MkFxEKSmT6hL0D/fGhilI8EtVG7vqKFoxvL7z4N4r12moGVIaXSUx6po0G/iYG6+mbxOkSrhogxd2c7axxqt5QoMVICRaX30SWnyzafYAj4yHV+BxcQWzjNs/shtWzY3V7piExNZA433yI7fvETVMBwgJ5V+g3Iwi1GuBt1oNZrJwOug5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqIY6q1bWeJyzW9kr0j0F6t/RywrfND5ptfpffQV8Ws=;
 b=nvTJKagGqYd7YDRGu/c4uIx1cLCcDCo8tBIp2p16LGmuYv1pSXKPI+z4CKHPq6c50QESCLT8fHyqLw9cB3XfpZQ0NkAht12WWbrJ/EEr8xAm9n4yh04jh+xr6lVQ/GTprlBU6hlAd9cJyqHYg1s9OUTVeN6rgLpACwhK2sWNYyof120HUxxI9d3NIWIStDdccLgdvXKM325im3zyFceBIqlxVLb3FboOn/LT0LnAe5KgZupWjyGCPrbHgHLFC13NYhai3G3vgbEQrhT4XP8eo7wQfZ+nvwVId7xT3t6EGHhCCBzzlcPPo8tVwnBn8oiQRdLKIHLgcksAqMTh7ohKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7813.namprd11.prod.outlook.com (2603:10b6:208:402::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 19:30:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 19:30:48 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, "Moger, Babu"
	<babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "thuth@redhat.com" <thuth@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "perry.yuan@amd.com" <perry.yuan@amd.com>,
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "Huang, Kai"
	<kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"ebiggers@google.com" <ebiggers@google.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Eranian,
 Stephane" <eranian@google.com>
Subject: RE: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Thread-Topic: [PATCH v11 22/23] x86/resctrl: Introduce interface to list
 assignment states of all the groups
Thread-Index: AQHbbQuX8YqJ+kbnJkKujoWHd7glMbNO0R2AgAB6BoCAATdnAIAAYFYAgAE2lYCAAEXTAIAEhrUAgAAAnXCABlIAb4AE0A1Q
Date: Mon, 3 Mar 2025 19:30:48 +0000
Message-ID: <SJ1PR11MB6083186EB2D63441E2D4BC04FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <52c66bf98480c0ab6bb0f0762497e328fcbdeaac.1737577229.git.babu.moger@amd.com>
 <Z7XiQ+u3Pc+uvJCK@e133380.arm.com>
 <45a0a88a-b31e-447e-9d62-bc0cdedf06f7@amd.com>
 <Z7dN2KpsQjVUb3KR@e133380.arm.com>
 <7802f9e9-9a63-463d-a51e-e9ad0e60f77f@amd.com>
 <Z7ijCphcSM58AqA6@e133380.arm.com>
 <09f2f512-0428-4649-b8ef-33e5a03d5dcb@intel.com>
 <Z7ydx6vfuw8OdJzL@e133380.arm.com>
 <SJ1PR11MB608377BD540169FF3B0FF82DFCC02@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Z8H3bKmTKQr7N2wG@e133380.arm.com>
In-Reply-To: <Z8H3bKmTKQr7N2wG@e133380.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7813:EE_
x-ms-office365-filtering-correlation-id: 55c594bb-63c8-4b81-a47f-08dd5a89e6fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oIYJyLusvzKoQGO3uZQmBXx/J/0cXboux5QbpD9ITcxmW2Nw7KEyxeug7sn4?=
 =?us-ascii?Q?mqKSYTEJdnyEvSZAiL8UD/9ev/DrQy/8hDakZPUxYm5Sf/+AI43PCSX3c+vG?=
 =?us-ascii?Q?8SzDLuHmK65nBNPuWwNpGtSK5xcXXKbbAtT9rtP2RjB0wrsfWVOjL+qFIVp0?=
 =?us-ascii?Q?yWOEUyoLezT8HCpgpHcnsTIUZiD0PLFCbHaiFQu4WRElSmYw5hEh6LqPlJnv?=
 =?us-ascii?Q?GoGQez7+d4kfX///v7YUj50OceyHvIKyIBxps+L3CHntg4JhcmpVH08k1uTk?=
 =?us-ascii?Q?EKVQFX4NSoymjs+HY9sSM+aTDxQw8TssWWfI1cg5cyFq9dEysYmELzSz1CfL?=
 =?us-ascii?Q?d5Z3zRIBzDm7o41h+cCl31BiuTrjxUf1UK0H9BfdpmY+JMLfmAtXulvDvIuT?=
 =?us-ascii?Q?IJ148vDaTxaIIfy4Is1T34BxlweBjXI4wjDX+yn/KkBJernnvIMbqDvBoH5M?=
 =?us-ascii?Q?R4g1DDsrWB4q08eRMUpc0eFMGvnr4RmOAzzPwtzLu2zPjKXunj3nT0mcSxYn?=
 =?us-ascii?Q?/ZmzQDJcrdB9eDbHrHhdCNGqJh5UaVg7h6ZiMe2VDK4Q9Mf6phkr1QVoLCbf?=
 =?us-ascii?Q?6q+6kNYbTnCuuEBpmNmKKjvt4+b1iNp5WIAtcPcREZukQTJWTxe2jPUEV+UQ?=
 =?us-ascii?Q?qG3Zj9oJvbQlygGBYA7cNjLFy0R04XTFXcsG6zoSoZRcHvNXdWM+JozpHTKx?=
 =?us-ascii?Q?rmxBdVi0Wute4iXoAmgw0oLwxuEfxJonz9cvGdABjlRk2jB8YiPlfCYLFtod?=
 =?us-ascii?Q?EQwpNBzlKHEFmDTBZK4iVb18VwUJAO1jScIpGIWpVSnsnBOcsoMszGZpigcF?=
 =?us-ascii?Q?dY3pX7nAs2oi5hxyPGvh52JTJK2Seqezm1PwIkfSC8GJ2PwD8uGv+calHAUj?=
 =?us-ascii?Q?db08C/8fyAaUtG6gCnahq3R8swU+A6u73Vc5PqJKFtQL1/5LXx6PKADEdZce?=
 =?us-ascii?Q?XVyjbykx7THgYdX/ZgYPZ6fXHAZpq5IC5Qa14UjHyxwgqLiJF/t1vYrRC+U9?=
 =?us-ascii?Q?jIQ8aYDP9l+6UHJ+uchXMrgzkqmgFOV2jwod17CI1QVKU24oM4F5/B6ugzcF?=
 =?us-ascii?Q?OyOHzcLIgz1kW+12H+7bhJXZsj1zTZZck2WjtulZFhMms61gEFt16NqtXQTY?=
 =?us-ascii?Q?nGhBQti4PGr2zhLZlKdnTA+X39FKEUJKEEdHje7aP90OMhXoxCZ0n0KRahPa?=
 =?us-ascii?Q?CU2vgik2J1l7hLkcZ7t1R9KQyBGRT9cNVhTtEQJRBkkcJmzG908u75JU50Rq?=
 =?us-ascii?Q?ll9u2h/beuKf15/btqs6ZHDLLwzRc+O29mrJlPjh5v3q98JZSgdyNGdPbkAA?=
 =?us-ascii?Q?qKurQ7i7rgbcjkBuuO2oH6LW2X+jhAGiMWBP8uc55I47YlIrb58mZVHJX/y5?=
 =?us-ascii?Q?qG/WRRHQbavqwArC3zbiF+zyktGKep4CCxtJESbrHxX4BSQnuD7eVmvt1Yqb?=
 =?us-ascii?Q?HrzKVT4tmQdB7AyvNoW2SY650lKkBuZH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G4o8Lqwc4/gT92Y+n7xKH1wI10m9ZwC5+lzhuHMqp+oe4HgtIEqd+vsIRpNz?=
 =?us-ascii?Q?vzBcLTMplyf30c0OfxsdN2B0W7TBwLe2bRpJs/hDIHDzkhL4JYtxHIsQtl8g?=
 =?us-ascii?Q?tD8WwCqOpOArvaWrOTnzHJs4nvq8jJKoDi502xHmu8ymq1dSjCnqk48L5/75?=
 =?us-ascii?Q?UBpoV11MHMgSvZtzAHvMJbKKIpCH6Hm7oiyDyyCYg8KBNSZh4iNANHbPE/HU?=
 =?us-ascii?Q?FJplPwZyn4FrT3YliUGsGkP8zHzOgfVW8f/WTkLGePpAI572BRRTVn9rE2vT?=
 =?us-ascii?Q?3JTBoJq48+8z1ftAUTxIh3+wyZuJiqgJsCgRtCzMU8t3hBLF1qkF0o3+XFz8?=
 =?us-ascii?Q?UseTke4E1Znjn/UeFoXxY3ZVUxtre/PjR2su4AjpO1Zw15TMoJsDJuuDM0VY?=
 =?us-ascii?Q?Mg4SF9ycxRBvysK8r+jlcldL5T91Bu1k8ms6ReDYDlVqAkqOGKGbTxUoZhuc?=
 =?us-ascii?Q?UBuNewlbhw6YTNPNm1zU+I2VMDgUGk1NdippLU5pF9Qv9sSnci/HCa9SzdX7?=
 =?us-ascii?Q?HbdIXiwIGOKNinvCPCS2yB5Wr5Yp2P4M6/KGez5aN3vCa2bzykuHJc2Xg9ED?=
 =?us-ascii?Q?8wfiY6N6PIwIuyx1czzvclMH3GAoj4g6hS6wC+GzA6oEhigx2qwB1Wi5C0c5?=
 =?us-ascii?Q?5hN2uqaXl3XrHAb6ZEqlAoOLpppyPKqMxOVd+6yMlnAKNOHDBKgI2MDmwakc?=
 =?us-ascii?Q?3KQqxObodkHMA185tjcGSxawc21uIrSL805jLzDSfQwCeRwASQtXNbytb5Ca?=
 =?us-ascii?Q?vKyLJYysruh1jk51iaL8Zh7fHb3YWboM01PJ57R6zDQYzl/S8g/FwmNAXCGP?=
 =?us-ascii?Q?n2wYl7vKIxlOgvQ52o++jBaGSN63g8aZud//OjORWWybq8MBkN4Z5N0kzixy?=
 =?us-ascii?Q?dO8GItcZyzDFc/T/j1I8Zh7nGnf0C529HRoK0fZHhp6vxs1c+V3OSIFa2NRW?=
 =?us-ascii?Q?Q0S228koPZcAtaLtElW8BsE/kaOJ93pgejAu7RVWiiRvuTA0q/wWjbq9cVgA?=
 =?us-ascii?Q?ZSHmZRm1n9FNvaYXkOA6bJqlkm6ZB0lS+KQqoXrZtsB1sqqnCR0jYANr4A9j?=
 =?us-ascii?Q?Ee8jVXvyrqlJ2p7Qau0YbiYwLxrktVDgK+iyhwx7SGr2VT0PFOIOLFlNH1Nf?=
 =?us-ascii?Q?OveOSsj9UOL/KGTMmxqR75cF/cw35M+Ps+oyL1gpitB4obnxhd2nVVYpPGF6?=
 =?us-ascii?Q?UaMvQp8lluk0GFkI7d/zFH8fYRmAmslAHc4VOwZlq86bMS5X8q4mwtWCDNQs?=
 =?us-ascii?Q?vPiSF/zRk9O7J/N0m81irFANMm3OkLicGSZlyidAH3yAyG40rPkT58bw4UcZ?=
 =?us-ascii?Q?eziOFgIs2CrgD/X5FbukRL5ZA3yvoDmZpNRgjqkdtQJ0G0Nh1oSR05p1LOYf?=
 =?us-ascii?Q?WiCJYCUGL0YJntRIdgpKXT9VYxnqzmGyNSeGL0HnJQ09m/CqBvk66RLqHred?=
 =?us-ascii?Q?kOFKJOmaZz5G3Z/ZR3bdaBARksXoAU7A7JzOWngXS7sC94R9p3anOahys20a?=
 =?us-ascii?Q?jvIGWMirwh7t0huaogmBed+JXTy40I5kJNF1M/Trhh7+wUsp2e0Lo4x/lth8?=
 =?us-ascii?Q?lXaHZV02zJ6XerPJrj9yqpXTJOk13EZvgCxAfgbk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c594bb-63c8-4b81-a47f-08dd5a89e6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 19:30:48.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqLGo1fV4lokKeTWFPq7JAthZn9v6YH4TvKz1vRCgTQfOM0e//MYtQZEWvlr8LegEtrcJRV/nN4Wn1tfwk+LJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7813
X-OriginatorOrg: intel.com

> After having spent a bit of time looking into this, I think we are probab=
ly
> OK, at least for reading these files.
>
> seq_file will loop over the file's show() callback, growing the seq_file
> buffer until show() can run without overrunning the buffer.
>
> This means that the show() callback receives a buffer that is magically b=
ig
> enough, but there may be some "speculative" calls whose output never goes
> to userspace.  Once seq_file has the data, it deals with the userspace-
> facing I/O buffering internally, so we shouldn't have to worry about that=
.

Doesn't this depend on the size of the user read(2) syscall request?

If the total size of the resctrl file is very large, we have a potential is=
sue:

1) User asks for 4KB, owns the resctrl mutex.

2) resctrl uses seq_file and fills with more than 4KB

3) User gets the first 4KB, releases the resctrl mutex

4) Some other pending resctrl operation now gets the mutex and makes change=
s that affect the contents of this file

5) User asks for next 4K (when it reaquires resctrl mutex)

6) resctrl uses seq_file() to construct new image of file incorporating cha=
nges because of step 4

7) User gets the second 4KB from the seq_file buffer (which doesn't fit cle=
anly next to data it got in step 3).

-Tony

