Return-Path: <linux-kernel+bounces-394748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F859BB370
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C72B1C20B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43E41C2DDE;
	Mon,  4 Nov 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHHtygCe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3371C2DC8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719758; cv=fail; b=GmvqM0OMRaKysn3V5z1aAJgfp2OokoqaG1HViz1hOv7xrC3vtuz5GOYd/TnJQTvYijInKzieD+boLaOoiaWk2qYRR1Q24Gkjuzs73Uhzc2eDWahLpUi1V9DniPyZNMJdW+1/47x5pABd1qJi+PgyJXbuzYkNhrLdd2+4dF6XkBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719758; c=relaxed/simple;
	bh=IOkIdWwxLANt3+7qfPbMmBVEXVtDUVdOz7HcNahbIv0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N+/PimflsdfXMYCpRopbcrHmGTiKqO/XbGCgiMLqfJ8AtbVSJ8CXdIfctXigi+OQZS768JpJZie25kngUJ8bY3bn6b2On5qzvhLHwAJVa732NRIInDDY15bnPYhXO0qArBUXqRLhK/Jmra1yUK5q7giQJRB5P1eSMnhzjCi8LpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHHtygCe; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730719756; x=1762255756;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IOkIdWwxLANt3+7qfPbMmBVEXVtDUVdOz7HcNahbIv0=;
  b=gHHtygCea2QK8GNzmNsc+ZM2k/3oCVEQMslqepuY5Awb0PvyD68LF2O+
   C2zT/3OhR2Yh7rjZZSz9DGrznKOO28leCT5QRmASdUVtGsaZuFYddTW/T
   xdE7GSOV8BhVEaQEL9tTnka+jFt6w1hso3vBmcaLqw9yzHlKd9kz2BKIg
   VOIIxpPVlk1DCzAQXkmCuA+qo5RU+GTtA3mmUbvtbmSx/ybIDi9r2Rxi2
   dehrurXqj10IFu6tAKaWqVMZ3G6yT/G/Igrt0uzmnZRQW4glJBg0pMgye
   uIzyaz6yMcAV9KW1v/SZq4rGDbrXCz21uo2Zf2tSv2GYong5PcY3ef/MQ
   A==;
X-CSE-ConnectionGUID: 3ZQBBh7JSvq1FbG3Abnr/g==
X-CSE-MsgGUID: o8rPoDc1RJaPeH67lH0AEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30265503"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30265503"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 03:29:16 -0800
X-CSE-ConnectionGUID: J/mqJphiRcyw9UkKnxxT1w==
X-CSE-MsgGUID: +v1VzFC6S2GsJOdfrOzRDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88201074"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 03:29:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 03:29:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 03:29:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 03:29:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/vdHUZH5obThB208feolQ3ofd2HCN7LSV7ldO0ANi6avNWtkxfSd0C0tjmKdq6JfmnSiyeguETzAtlwPE0sTotIpgrVsIKBRfIwP+h4VTwfxwVVjqCaenHN6AN2f6d5KWp9QNAUiS5S1FOBugQ3P23IFQGODQRuLON83hUR64Adebk9U21JPc7qNxCbBiawDVZDtfIhnI6sAMRptwY+OGmqq5w3pd53/U/pqRG2AdmL3wRkpc6JCc9rspx2PolA9q7ndGoN0TyElxIOwHkTbtFQUE4wBOkXHsx+7Ev8PdvaKfe+MVUN7D89IVV3babXkNyUaNd3mzkeCg09okAxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vx5YQEJFfpTNyoZxNOMsEIDNKkGNRGnIZYVkVRRs9U=;
 b=RHEcXkzJCTqIyAHaxGdEoQlK0zLrCahQ8tlToVOxG2Glc1oOTRfvejRXJgqblxr1qv1tY7GyVqNb5AImt89PwrP9U2uPS5iMFqYEC7vKZWQAjRe+8V5MLxCy/xaB+2FoW6llahF0RnxoVFnpwLRM0OFFPRasqBF95obBFZ0+EnVAVx/0u81LEqLaJ+/VY89pU8ZwvbNzDRziD1XGlVtboWRZtWZOZNQ3sI0fdHNl4NHbtO1/xsn5++g8Ypy5s2HsL4GC1REWsg4SfsM0d00k8u4BZbkWRSy6SDXRTJsmLzRbfE0AGKl0tmlwBtrheMH0WCiQ+1KApPUzAwML0K+Zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 11:29:12 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 11:29:12 +0000
Date: Mon, 4 Nov 2024 19:28:35 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>, Kees Cook <keescook@chromium.org>
CC: Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, "Pekka
 Enberg" <penberg@kernel.org>, David Rientjes <rientjes@google.com>, "Joonsoo
 Kim" <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
	Danilo Krummrich <dakr@kernel.org>, Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Message-ID: <Zyiv40cZcaCKlGtM@feng-clx.sh.intel.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
 <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
 <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
 <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
 <0e8d49d2-e89b-44df-9dff-29e8f24de105@suse.cz>
 <Zw0otGNgqPUeTdWJ@feng-clx.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zw0otGNgqPUeTdWJ@feng-clx.sh.intel.com>
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA2PR11MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 684acdce-930b-44d0-5651-08dcfcc3e7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OE8I9A9jw3gnY+ElxX95ZHfVGtYDunlcowIluOyrIfxe3XAKcWKJgS0acwbm?=
 =?us-ascii?Q?dRtanzzZWiDnJBk8RuLPi4YY1NNP2GPXD6pXcLLT0xyZm08gdQnOAe/CVTvV?=
 =?us-ascii?Q?L5y/M+VdKOrcddYN/0AYktoQm1QjkHKt21QOPDrtuWjNP/p8bgG800SD4Y3G?=
 =?us-ascii?Q?/JfUCGPlH1SJkFOB3yO9qUU530bUJ5nRSaCtDRgmY2iO61fQukmDY4G1mOey?=
 =?us-ascii?Q?ls3MfHmB3KgIMONcXGhGkmoyu9E1K8zuPsadONAiwtVpdRa/FjKeDrCD+cuj?=
 =?us-ascii?Q?7bG2gLkuzAD+RAgmLWo7dGAZtgz5Eb7wrNgNEEKPG0gFKTpsoKqqz6ajdYr1?=
 =?us-ascii?Q?ns0D4eWf34vEFipPe7Hn4rZTEPtcywVow3GOKuYShRYJEIc1aJvpdEUwh/Ok?=
 =?us-ascii?Q?0OoYtN5Z4RmXZzOA9VIS0QRU4G93DundP6Xc4mlxNV2qfXwTCG73KqwKWjCb?=
 =?us-ascii?Q?W01JafonTFpbwmLNvKsb1SU+v9IF2VSNJ93brOidt8vZ5x14iRnNsN9rWpf5?=
 =?us-ascii?Q?Ujo5fMpCfSboSHr7QyJ0jxzVgJKEi/Br4zhDYqux+hJSLk1tfo8AkM6wb77V?=
 =?us-ascii?Q?YeCOQ2/V9LPNu+kUsJuHKYH5Y6or7nzeu8vZw1qJDEYsBibXSUAxgTOsjhaE?=
 =?us-ascii?Q?15QFRW5zDHn3DQIeEOv/EIkBVzncFHfG+jhbQDGxNOBTIMiIlyQJ0lJ4DPEp?=
 =?us-ascii?Q?xz0U9sh0VpCH6PMETCs4keWHpxBs+ZfKitlw1HxQf0/hBQNzK3/ABpxnNEA0?=
 =?us-ascii?Q?gy0o6yc/RYjl6az3WTOz/ENnHzGxewdTqqXK5jO1yV/qm6UpFWztdV42PEH9?=
 =?us-ascii?Q?IOqu+5Hns4K4vkBs4qJww5AhcWXEqlwhJe620+boJMc0GI+bKODZ8EOCxiNJ?=
 =?us-ascii?Q?SabCVtlJuBWkp5TQwFsln1M0q3KrhM1rrXIR40AWE4ee0ExtE6TeQmEaFAZA?=
 =?us-ascii?Q?wcoxw/Gx0VcD1W4TgI4a+yr/6AEkHpUs+y8lBKyzC7nJRvss9nhVS9qvydoq?=
 =?us-ascii?Q?3ua7jlV5m8joCJlr0WPZKkCVaAaKGMb201UtmRKB/laQ3uX6WhE2dOAnTz8g?=
 =?us-ascii?Q?COZFf3eVwkywRcp9nW7/wrzv0uTIUHpTNx7YxiQFaLEYSvrLlquaa8HeOjvn?=
 =?us-ascii?Q?AmCu/l/oUOy34v6bFe4QcwptEpIxjsMHd1QYdND/w2lxFLAANdS3NmFqNOCz?=
 =?us-ascii?Q?X4eMEYWDWoNSAsZmm//yjuJE6ttKk+JepekG9+4aETw/prmcdSd5cL9fp1J4?=
 =?us-ascii?Q?EvwdGZi3f9noL7e+C+SRaKwCgfPXbR3KXDlJAxqmYQXsALFaz4vfBxZ2EN1Y?=
 =?us-ascii?Q?gko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBFyHgmGjDGKa5Li4mnKbNsriK0T8V8rvV7bQiarAqMx0n3Htno4P9jTMkNM?=
 =?us-ascii?Q?7ulUmE2kFW/a9u+PD55Yloq+1eahzWw6b1rlC1Ikp0tyEtAa/kQB2mqdk65l?=
 =?us-ascii?Q?JC93z3IqVgvS8szOee8YceYGQvjv7EAw7DbVBg8zQGR0R5Mku/UCRh3FawVK?=
 =?us-ascii?Q?Bjx9AbJacRLLm82u3phpHqUbMl3zmrdXQKXiqwn3BswOkV2rAIwB/y9msWUE?=
 =?us-ascii?Q?15Czsng56iWY8wxDSArbGEpbh1Ch0aw8O9EH2CM99yNO39pd5tOMvV2NOQmW?=
 =?us-ascii?Q?B3YfMHczkmehwZOqXHfTZRF9A2F4kYKcCAU0Di3F9sa7BABZRqoAcnC1iBhP?=
 =?us-ascii?Q?DH8cdNHoZsM5Rl/IEq4zFrhjEKOUfjZv0YysJkKMFPzt85kU2lXgVeAoYyIJ?=
 =?us-ascii?Q?ZcSppXsZteNyzfsq4B/BpjQJDGRxyr30zYKTdOOnHUgE9WhWvBN6/YlF9YQ6?=
 =?us-ascii?Q?5P9yhxFP5KFOOU2utE0L5G7eLCAOJV3BTlyENWbsXDnp77BIwbBJ5P+BqvN8?=
 =?us-ascii?Q?jr6+m29sIog7Dqm9sYBZ6aCkxZBm/vvGi4rsOMhziebSEYo5ozhOLUzBblW8?=
 =?us-ascii?Q?BtXmKqIaI1k+/HAZgq8xCAF95igqVkaPvKBGeyCQH+NpjT5leJ74Cl1w3w4I?=
 =?us-ascii?Q?k6euFyEuNRUtyiN+MkZghH3F+0xCPN2FraWeyo6F715m/5TGiHtdb7BfpOVF?=
 =?us-ascii?Q?c8lkIuD4GGFAl+u3sJoSQ5SgcJb31Br/NjDT3X24la8UQ81g954dC5Hp+XbO?=
 =?us-ascii?Q?nFsofSWNR2F7ZsOaAS2BlHqaq/Cgsk/7AVWJEBVGuLDxIhtpW6KDcGki943N?=
 =?us-ascii?Q?Lj2iebbAGtyCSWCLsBgMFtk1p/aWpHkjnDplvB1UsXGrC4G3OfhC3QGxxFC2?=
 =?us-ascii?Q?3YCp6Ea1ZeF+Mj1wSGpfMsSJcWYINv64kJk7z8w3GchwCPjSVdJ8mIy18k7H?=
 =?us-ascii?Q?w2WabedEkMGHQ5xjN2mSQgJefCM3E2Lxb5M4UZI3oa2kg0RgaqvV9/5ecBmF?=
 =?us-ascii?Q?Ui2xVyvcmh9s9vjRlQ2r4X2ss84g+f6WdFiBLzf2QpIQGiyP+HOcJmW8zTDu?=
 =?us-ascii?Q?2fDzVZawJwDdDE54K22iNp13rjLqMqaYlj7009cVNSWl6JLxJ4X/WSziXRCE?=
 =?us-ascii?Q?XeJwcSg8oB7i5d/ZYjjKc5trgYBJ9/d5V1y5M/FTQVwlew4fvb95kYh8X6W/?=
 =?us-ascii?Q?vMFFN1Ybj/cbzc42X0DwnNJrLC0dYdib3VV76QmVmiL10TYjz2w1b12dqtOS?=
 =?us-ascii?Q?vfdtwOulEUUNVIMJYikUY21LEHE53lAGRhJW7d7u0TASIusFXHoJf0NGS283?=
 =?us-ascii?Q?+8b3SR0sIW/X5tJBOXwbXUjSnG9/Dxo1jAJ366MeQzYzXuupXTzd6fZpZaqS?=
 =?us-ascii?Q?TY+faRZenF0C6WlH2WTTPxPU2LVozObV9H/7xLUZupnBXVRL/2oOcL0I8zzj?=
 =?us-ascii?Q?7SsfXzrZ+42jy3DdT3I4643No6dLweIQgjh+iEEnPxs/jX6MRGR3GAl1ZAR3?=
 =?us-ascii?Q?tyCMg5HGwz7s27hGE52lkti9VqL67J8Un4UY4H8srY4gPQ8aqHqE9G33ui6L?=
 =?us-ascii?Q?xGFrK6r21gsxQMhDmeDKa8lcMeERxBbC2r6QTbp8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 684acdce-930b-44d0-5651-08dcfcc3e7eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 11:29:12.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i35MCwkjtzZCW0GGw2lc2N8QrA+2IQ9E2HTNhfgI4k8Wj50GD0MBhtpUyUtY0ekqCAIi6wv1GFKsHPyGke3d3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-OriginatorOrg: intel.com

On Mon, Oct 14, 2024 at 10:20:36PM +0800, Tang, Feng wrote:
> On Mon, Oct 14, 2024 at 03:12:09PM +0200, Vlastimil Babka wrote:
> > > 
> > >> So I think in __do_krealloc() we should do things manually to determine ks
> > >> and not call ksize(). Just not break any of the cases ksize() handles
> > >> (kfence, large kmalloc).
> > > 
> > > OK, originally I tried not to expose internals of __ksize(). Let me
> > > try this way.
> > 
> > ksize() makes assumptions that a user outside of slab itself is calling it.
> > 
> > But we (well mostly Kees) also introduced kmalloc_size_roundup() to avoid
> > querying ksize() for the purposes of writing beyond the original
> > kmalloc(size) up to the bucket size. So maybe we can also investigate if the
> > skip_orig_size_check() mechanism can be removed now?
> 
> I did a quick grep, and fortunately it seems that the ksize() user are
> much less than before. We used to see some trouble in network code, which
> is now very clean without the need to skip orig_size check. Will check
> other call site later.
 

I did more further check about ksize() usage, and there are still some
places to be handled. The thing stands out is kfree_sensitive(), and
another potential one is sound/soc/codecs/cs-amp-lib-test.c

Some details:

* Thanks to Kees Cook, who has cured many cases of ksize() as below:
  
  drivers/base/devres.c:        total_old_size = ksize(container_of(ptr, struct devres, data));
  drivers/net/ethernet/intel/igb/igb_main.c:        } else if (size > ksize(q_vector)) {   
  net/core/skbuff.c:        *size = ksize(data);
  net/openvswitch/flow_netlink.c:        new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
  kernel/bpf/verifier.c:        alloc_bytes = max(ksize(orig), kmalloc_size_roundup(bytes));

* Some callers use ksize() mostly for calculation or sanity check,
  and not for accessing those extra space, which are fine:

  drivers/gpu/drm/drm_managed.c:        WARN_ON(dev + 1 > (struct drm_device *) (container + ksize(container)));
  lib/kunit/string-stream-test.c:        actual_bytes_used = ksize(stream);
  lib/kunit/string-stream-test.c:                actual_bytes_used += ksize(frag_container);
  lib/kunit/string-stream-test.c:                actual_bytes_used += ksize(frag_container->fragment);
  mm/nommu.c:                return ksize(objp);
  mm/util.c:                        memcpy(n, kasan_reset_tag(p), ksize(p));
  security/tomoyo/gc.c:        tomoyo_memory_used[TOMOYO_MEMORY_POLICY] -= ksize(ptr);
  security/tomoyo/memory.c:                const size_t s = ksize(ptr);
  drivers/md/dm-vdo/memory-alloc.c:                        add_kmalloc_block(ksize(p));
  drivers/md/dm-vdo/memory-alloc.c:                add_kmalloc_block(ksize(p));
  drivers/md/dm-vdo/memory-alloc.c:                        remove_kmalloc_block(ksize(ptr));
	
* One usage may need to be handled 
 
  sound/soc/codecs/cs-amp-lib-test.c:        KUNIT_ASSERT_GE_MSG(test, ksize(buf), priv->cal_blob->size, "Buffer to small");

* bigger problem is the kfree_sensitive(), which will use ksize() to
  get the total size and then zero all of them.
  
  One solution for this could be get the kmem_cache first, and
  do the skip_orig_size_check() 

Thanks,
Feng

