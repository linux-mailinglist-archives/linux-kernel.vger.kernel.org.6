Return-Path: <linux-kernel+bounces-280309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A83C94C870
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 04:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0531F25312
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 02:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1517555;
	Fri,  9 Aug 2024 02:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D93QNS6b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF97168B7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723170146; cv=fail; b=p95QAXnKACQQ+CHwMZei7tXt79TnovmGIaIY+IEFa5ECHLN+IvlHlJ6sgfbnHp1hj3qXHWgOfpOICLlmSCG17G0JAXFE5m+hVjIHlPGSgkKhIqluAjq0FpAFqmhHJT821xWRiozuCXkfpO7eGFWIt2NJtX3Ow5YyH3552m5VpOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723170146; c=relaxed/simple;
	bh=wOl2QC94ZvdVVn6FYWQLQntM+mmpQMo+8o/6xr9TUVE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=YP91hYblnURUcT05mFo1aMXr8Q+G1LLpGvuOeumXC5qe+uy5aLSJLb0CWYOWZc/a+Ah/DfoSzf1/AoIJdZOprfkhh8JYmLTs5BA72Jt50BwZWJ/ObhP0EE0VcZcIqjc2VKxP72b/0fX+6YDkBC7GuJ96hj3ktxt8m/vFZY0meqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D93QNS6b; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723170144; x=1754706144;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wOl2QC94ZvdVVn6FYWQLQntM+mmpQMo+8o/6xr9TUVE=;
  b=D93QNS6bESJ6HGA4OGp/fJ0FwVt7eBg3sgYcedHcxIp//kvGFM/No6Bu
   dZMS8k1i1vYBADtlLBY8nbZbo10dtA4kYM4PnvkHKhPjsB3w+Sq0DRxfn
   AtWqueW2FSAFOL4bGM1bHUVhz7Wduphe360BWg7h4ehKsK8vrr9dL3fcf
   bAlfhGVVoVXa2IbybdJ/fkSnpm8gCQKH7s6MoW/mBUTLQHU8IINho080j
   3krvlD22Kv5NVXftZ/1+jwsOdd6h5ilpkQ5vHW5J0yzKGRU/wLkXkM4BG
   yDQN4nHMdFdz7G9Fw1461JuZTLujjjln6i+yMpoM6uYBV8EXS3kx5+AsV
   A==;
X-CSE-ConnectionGUID: /WBkb0+4QDmzx8IU0s7KRg==
X-CSE-MsgGUID: 4OXuGREjQxyu9kxODK1f+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32735748"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="32735748"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 19:22:24 -0700
X-CSE-ConnectionGUID: AhJTZ4QgRRysPtBGyVGPNA==
X-CSE-MsgGUID: R2zEHP9wS3uNltIQAPeBWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="61813009"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 19:22:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 19:22:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 19:22:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 19:22:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 19:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjzB4dOwCVMT8k0+xrIBpG6496eQe5Kj3kDaetqnxU3/G4u1UsFagPaGkRbxa2XI4GyXUUphRSLIITUv/NiD5cSVUuztnxI9PWwr2UCENe2lTSda0VVPi/GCPcdPf0hw3Ve3rxUOAqk+cLLLQV5ZV2z7tBmD2dwkDacq0vQld65mBIlka4ApF6Rf4YqN8kp+agM4wR9oZbkAmIhWySh1fuZMiI5EVJW21Ld9XUlQyuEx396tKfQbIZCkqcRcxs7gfzPqJFni2vW8LhoMdqHKDeEBKuU7zL0HsReuMlWjvlkohBRGYNaVJ35G/AECBRwaP4eGjOOJ5Me+iqlyI/Kyfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pybPULXnTWYe5W5tDhoLsIKVbUMwzSbvQkhE5wMvno=;
 b=LADUZZOOrc832mhm5rDF28vPwgLzvOEWZ1NeM6o5aA/XqrXSIx/LD0YhoEwlx6TrrXl2vfZ8/rzoqdPHRdw9+pKrP6pyxlZ7sOYkL38nIGXxVcnZV3WVzL+EMfD8wpul1t4Prz8rf6xVGv73cmm5I6ecoGDKHtvfdmpFOUNpTgDNw4jpZ8sPULV7Fs55wpchsDmQv1n9qNSvv2+uVaZ7CmZ9auUlVxyurIBUgK/aEBjN23THvXMO8x98YuXaDOoOCxQcPUiddKAA+MbzyuGbTzPXXileIe2KwsX2R+C+wjf2oeD+645enGwDjGGFBNrhX/MA/6GWfyh5NqJwLqbRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Fri, 9 Aug
 2024 02:22:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 02:22:16 +0000
Date: Fri, 9 Aug 2024 10:22:08 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [paulmckrcu:dev.2024.08.05a] [rcuscale]  0b85a3ea0a:
 WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload
Message-ID: <202408091019.8ed98238-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 581c05e9-578f-4920-cd74-08dcb81a1672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NkmMU6D7x0r+Fq+noLR2dUPbvRe/jWsGOhiCUFv2TYH7N59smiP5HmbzNcYP?=
 =?us-ascii?Q?h9Xj+Eiz4AdHqdQ5cy7+DdSgMlm54D3pvrQzMWKbrJqqZoYAt6dqp9+ewEfT?=
 =?us-ascii?Q?4/nTnDuQ3fRG4XE5EyqSygwLqiNMhoMxcxJZfT05HEMGz7oHiO2qm8xM2+C0?=
 =?us-ascii?Q?xY3vBlIVMLStBdhWiBKNeNs4G6OtUNeyUBhF7rw5BBbGbn1/ImiTzifqC932?=
 =?us-ascii?Q?ecdwr4IOXlBMWWUJ4US71aFSi/L8QfdZCeY5Aw2c897xGUdgprVXJukRp7id?=
 =?us-ascii?Q?gwiUVCOzfNjnG1iQVpg9gOSyJhnqYoGTijQ2Pb+R4jUJ/RzgZRdKdU0f9M/X?=
 =?us-ascii?Q?N0H/Y4YtO36C9C0hGEostOa3K25zJTm88ytpjU2Gg5ctnmIjOvuN3DlHclE6?=
 =?us-ascii?Q?kPGmpsMszvE+SdvPFQHP60P2ph+gQug1eVj1xdW5WLwrgWrzhGOxoLl4jTuu?=
 =?us-ascii?Q?3mCd3JmxP8ZXaqhDSRk6ynTS+5ZstMQobwWdgA9yozSgRy26NgqIuaaxEU+N?=
 =?us-ascii?Q?lOyq3VtRIxtJf39lAoVaW+gRVsmjnhIakEpBQLA4Wuo6uTTRPoPVWfbf+wRe?=
 =?us-ascii?Q?5QLxAPxXPmSpknKfB85j6F3W2swqmbN09WoktqUHAsta0VAZrLPRL6vdoORr?=
 =?us-ascii?Q?ItHcL6WNSg2SYLo1+sHFAtNhXnQn2AZ1JIBGCv+e+RGiiCHUyLwAGVZ7kqS+?=
 =?us-ascii?Q?rC7lp8qDiumXJALCRZAbMVecE5EUixZS75WGU9lt0Pkm7aToat2+X27MavRS?=
 =?us-ascii?Q?qsOskhtVnKph9f+wMsp8mR3ca+BEGJkxD9ne6HkKv+ng1CCKdKVV1SKf1pQw?=
 =?us-ascii?Q?RkcfSGrR6xuYmvS0y+3ED2YZQGtt8SaPSghnAzfWwYFau+U4SOYx3aw9KnL5?=
 =?us-ascii?Q?810ZsCgzEAp+DhOd1F5J4v6+4rgSH68UqrlSiNjY7LGhZS1myKjoQpXYjn/f?=
 =?us-ascii?Q?IPXuRStoD8/EYtMg+9FrMbMaz/+eC8WxnOxkw/VMIexCfmWCO12oHzHlp6gM?=
 =?us-ascii?Q?ml+gF/CbQZuCGrzhm1qFKSeBZvWXN3/kFqijn2XS6NLPuJJpNc2gaxRY+nzj?=
 =?us-ascii?Q?+PpDa4lz1UHMaCfm+xIAVRDt1es3IJVPdxb/hoA0NXYDmdlOgIO/3BKD1m+j?=
 =?us-ascii?Q?vUCfRls6QugFAlzTJAIdAaul+lFAtT4cmhQuUAuMD/+1BDbREl/8M9gX7RFs?=
 =?us-ascii?Q?wqvHtgnjWOkDlj3qV1gMRe31rz70MmT4Y82wKoCe82qcks1QcPmBY4dRuHXz?=
 =?us-ascii?Q?WTpuNiUWeY89hDlMZK9PwWkQ9mplc9gz7/m1lpjYir2rXPEd6fx4nMn47evM?=
 =?us-ascii?Q?4M4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qfXU0PajcK3PYtxwaoei/5jATepncfs5gsQKcTlMtM6HS9b5hmPq+dReOciT?=
 =?us-ascii?Q?AiJTzYUl0xr3EvYzlts57Z1jIg/8HUe2+1JGZgruQBq1WiRtJ4e4EBZCquA5?=
 =?us-ascii?Q?uPMkx7IeNpoahDy47UuBUEb+j3gngxXkZy1XvnqngwJRd50dGYQSoLrJiloo?=
 =?us-ascii?Q?38rDby+Jl/pMTGf99a3RrD5EgQU64FBjq+vGRFBE+A5V88+pIHeDAOAAKv97?=
 =?us-ascii?Q?WVcolLm2OSXMUreaCMHcVNMdxKt2vkout06HQMARcKoA4z3DIUqhAMGAzaQ9?=
 =?us-ascii?Q?tGPO1BVBiOPyXi3UVy2hIhTCxwd05InBSm4aPNad48z6Fsur/401iKR/WoUZ?=
 =?us-ascii?Q?TXboBe0u9f7CnMz83atNLSGbpueuKhlNASYfdWNkutqI9gGTFLmT/OKcnkVE?=
 =?us-ascii?Q?s4g+9voZCqwPp0A3GD6iz0nng8VLnD1Efs+qkIifu5NwOj9NdY1a6R41sECr?=
 =?us-ascii?Q?SLuWqiu1kDJXezzGxMvx5la4jH4LuAMmPMA12vZDQ97wIdaHn02giLC0ApBH?=
 =?us-ascii?Q?yC7SMPSXgUyQqi3LZxE/se7ZoMvDNnSSk57ao0LWuIU0OFimOcTB0LurtrxB?=
 =?us-ascii?Q?Wo2O9+cgi/x5TrhFpIl6MWbGEZShxtL2qXk5g3VuYTijG0HH/FSGfTaI8Oqi?=
 =?us-ascii?Q?1w7RF2ggjOYn0hU7+Ap5tlrCn9xm9EUP3E9OftXaKQyVplncSF1ILOBVFqlF?=
 =?us-ascii?Q?WW8/e/iblt7G1xEPmLTUl2Jn9UjwLhET1r8YyIFOJLG3ZHpB8Q5YYcOSdV56?=
 =?us-ascii?Q?RnOpcW+9/Y2WHtz5smjFP1BO7ibUIvY/eW5GMbn/0b5Zk9QPvLGgsgF0OmTS?=
 =?us-ascii?Q?QxUNgJVnT6LFf4O9marFq8RYUYMbu5pWURCcpo7vY3rnGA2AuGgsM08/Cfj5?=
 =?us-ascii?Q?nqobE0HCBEU+pHUNgN5bio/HaKp7Og4ek8dHVFfdQahAX0AGTpd7lZ/kx3Ho?=
 =?us-ascii?Q?X/O5DbHw0G9P36jDvCTmtsxxo2VebcTCADlXtgcKXnaSIm8/jYWpCmjPHUrl?=
 =?us-ascii?Q?F71BOXHgDIg4cfjEi6mFPVleVxLOP1aV4VdIurl+oYffGZKCk65XvejuZNcz?=
 =?us-ascii?Q?2nmTOSj37rXVB2DphXVptfhy6Kv3vigY6uipDwlCRcXWGOA24Nuj6sOYX4K6?=
 =?us-ascii?Q?nVevdlwfRpaoLsGEtBwWkbrBxa+rpPazN/1gAUh/4RtXHyxi56tK+SqWH4Ey?=
 =?us-ascii?Q?n+rcEkzwaTbbbn+gJ+8DJvsFHPAVLH7flWTTuUtoUPVAYx2vSuFkBon+UBBV?=
 =?us-ascii?Q?6fk4TEa4mU4137KBYYFub7YFZznrkwi1NFPsV5caSh0UunciXhfBqTgBL/kA?=
 =?us-ascii?Q?I0SQCdCLjXv8ih7qbISMu6MnmhGB15D6aQeRgZKF0veb0w20Xj8QO4NYUrE4?=
 =?us-ascii?Q?jV6L8RPOydW2yE7ONxlY6Pc0Iz45Bw/zA4ciiZx9/Qq2Jano1p4fTMuJzydj?=
 =?us-ascii?Q?XMOnpaTzxT+lPDy2agcDBQmUpMkYU9JEPiyIDrTe5YFXxmU7hcAMfezZgCwJ?=
 =?us-ascii?Q?iFj+fgz5hzUV+xnidWTEPDFI4UyihOa2FxeitVND5zpXE8WyEwju+ak9zjFf?=
 =?us-ascii?Q?4vdgT9bbUgKg9dKhC6NHPAOqKNnh6kRRLOy1AaPZq1cn7UMoZjDZ0NIQp03e?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c05e9-578f-4920-cd74-08dcb81a1672
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 02:22:16.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLrQxj7v1HvPuMsZjp+i2kKEqip8oh8nb2APOwOyv96zdKZcBY3+Lxh/hyr49WN+2qRWKE+RZAOrk7/4nPXCvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5790
X-OriginatorOrg: intel.com


hi, Paul,

we noticed the issue for dev.2024.07.31a at first, but recently we cannot handle
the report fast enough so didn't report that to you.

we also noticed similar commit in dev.2024.08.06a, but didn't finish test so
far. in order to avoid further delay, just send out this FYI.

if it's a known issue and has already fixed in dev.2024.08.06a, please just
ignore. thanks


Hello,

kernel test robot noticed "WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload" on:

commit: 0b85a3ea0a8e4d8235e858a3aa1dadc3d0cec4e2 ("rcuscale: Dump stacks of stalled rcu_scale_writer() instances")
https://github.com/paulmckrcu/linux dev.2024.08.05a

in testcase: rcuscale
version: 
with following parameters:

	runtime: 300s
	scale_type: rcu



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------+------------+------------+
|                                                     | 532e4ab154 | 0b85a3ea0a |
+-----------------------------------------------------+------------+------------+
| WARNING:at_lib/alloc_tag.c:#alloc_tag_module_unload | 0          | 12         |
| RIP:alloc_tag_module_unload                         | 0          | 12         |
+-----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408091019.8ed98238-lkp@intel.com


[  465.251143][ T1160] ------------[ cut here ]------------
[  465.252395][ T1160] kernel/rcu/rcuscale.c:1037 module rcuscale func:rcu_scale_init has 32 allocated at module unload
[ 465.252492][ T1160] WARNING: CPU: 0 PID: 1160 at lib/alloc_tag.c:170 alloc_tag_module_unload (lib/alloc_tag.c:168) 
[  465.256072][ T1160] Modules linked in: rcuscale(-) torture ipmi_devintf ppdev crct10dif_pclmul crc32_pclmul parport_pc aesni_intel parport serio_raw loop fuse [last unloaded: rcuscale]
[  465.259112][ T1160] CPU: 0 UID: 0 PID: 1160 Comm: rmmod Not tainted 6.11.0-rc1-00092-g0b85a3ea0a8e #1 ec0c0d0dad6c67a7bbf1e37f55102072a1ba998f
[ 465.261458][ T1160] RIP: 0010:alloc_tag_module_unload (lib/alloc_tag.c:168) 
[ 465.262400][ T1160] Code: 28 00 74 08 4c 89 ff e8 49 cf 44 ff 4d 8b 07 48 c7 c7 20 1a ca 83 48 8b 74 24 08 8b 54 24 04 48 89 e9 4d 89 e1 e8 6b 69 fd fe <0f> 0b 31 ed e9 54 ff ff ff 89 f9 80 e1 07 80 c1 03 38 c1 7c 90 e8
All code
========
   0:	28 00                	sub    %al,(%rax)
   2:	74 08                	je     0xc
   4:	4c 89 ff             	mov    %r15,%rdi
   7:	e8 49 cf 44 ff       	call   0xffffffffff44cf55
   c:	4d 8b 07             	mov    (%r15),%r8
   f:	48 c7 c7 20 1a ca 83 	mov    $0xffffffff83ca1a20,%rdi
  16:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  1b:	8b 54 24 04          	mov    0x4(%rsp),%edx
  1f:	48 89 e9             	mov    %rbp,%rcx
  22:	4d 89 e1             	mov    %r12,%r9
  25:	e8 6b 69 fd fe       	call   0xfffffffffefd6995
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	31 ed                	xor    %ebp,%ebp
  2e:	e9 54 ff ff ff       	jmp    0xffffffffffffff87
  33:	89 f9                	mov    %edi,%ecx
  35:	80 e1 07             	and    $0x7,%cl
  38:	80 c1 03             	add    $0x3,%cl
  3b:	38 c1                	cmp    %al,%cl
  3d:	7c 90                	jl     0xffffffffffffffcf
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	31 ed                	xor    %ebp,%ebp
   4:	e9 54 ff ff ff       	jmp    0xffffffffffffff5d
   9:	89 f9                	mov    %edi,%ecx
   b:	80 e1 07             	and    $0x7,%cl
   e:	80 c1 03             	add    $0x3,%cl
  11:	38 c1                	cmp    %al,%cl
  13:	7c 90                	jl     0xffffffffffffffa5
  15:	e8                   	.byte 0xe8
[  465.265130][ T1160] RSP: 0018:ffffc900011afd68 EFLAGS: 00010246
[  465.266022][ T1160] RAX: 51a3a0ce4fdfd600 RBX: ffff888172cb5500 RCX: 0000000000000027
[  465.267255][ T1160] RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
[  465.268415][ T1160] RBP: ffffffffa00f0d40 R08: ffffffff844421b3 R09: 1ffffffff0888436
[  465.269691][ T1160] R10: dffffc0000000000 R11: fffffbfff0888437 R12: 0000000000000020
[  465.271189][ T1160] R13: dffffc0000000000 R14: ffffc900011afd78 R15: ffffffffa01020b0
[  465.272696][ T1160] FS:  00007f203113f040(0000) GS:ffffffff8443f000(0000) knlGS:0000000000000000
[  465.274153][ T1160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  465.275111][ T1160] CR2: 0000000000403034 CR3: 00000001363f4000 CR4: 00000000000406b0
[  465.276271][ T1160] Call Trace:
[  465.276756][ T1160]  <TASK>
[ 465.277245][ T1160] ? __warn (kernel/panic.c:735) 
[ 465.277839][ T1160] ? alloc_tag_module_unload (lib/alloc_tag.c:168) 
[ 465.278668][ T1160] ? alloc_tag_module_unload (lib/alloc_tag.c:168) 
[ 465.279498][ T1160] ? report_bug (lib/bug.c:?) 
[ 465.280184][ T1160] ? irq_work_queue (arch/x86/include/asm/atomic.h:23) 
[ 465.280940][ T1160] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 465.281831][ T1160] ? exc_invalid_op (arch/x86/kernel/traps.c:260) 
[ 465.282745][ T1160] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 465.283741][ T1160] ? alloc_tag_module_unload (lib/alloc_tag.c:168) 
[ 465.284759][ T1160] ? alloc_tag_module_unload (lib/alloc_tag.c:168) 
[ 465.285926][ T1160] codetag_unload_module (lib/codetag.c:?) 
[ 465.286979][ T1160] free_module (kernel/module/main.c:1265) 
[ 465.287832][ T1160] __se_sys_delete_module (kernel/module/main.c:?) 
[ 465.288898][ T1160] do_syscall_64 (arch/x86/entry/common.c:?) 
[ 465.289820][ T1160] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  465.290950][ T1160] RIP: 0033:0x7f2031249a67
[ 465.291843][ T1160] Code: 73 01 c3 48 8b 0d 99 83 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 83 0c 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	ret
   3:	48 8b 0d 99 83 0c 00 	mov    0xc8399(%rip),%rcx        # 0xc83a3
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	ret
  14:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 b0 00 00 00       	mov    $0xb0,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 69 83 0c 00 	mov    0xc8369(%rip),%rcx        # 0xc83a3
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 69 83 0c 00 	mov    0xc8369(%rip),%rcx        # 0xc8379
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  465.295546][ T1160] RSP: 002b:00007ffee44793a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  465.297112][ T1160] RAX: ffffffffffffffda RBX: 000055c7c8f1f9e0 RCX: 00007f2031249a67
[  465.298754][ T1160] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055c7c8f1fa48
[  465.300377][ T1160] RBP: 0000000000000000 R08: 1999999999999999 R09: 0000000000000000
[  465.302001][ T1160] R10: 00007f20312bcac0 R11: 0000000000000206 R12: 00007ffee44795f0
[  465.303607][ T1160] R13: 00007ffee4479cbb R14: 000055c7c8f1f2a0 R15: 00007ffee44795f8
[  465.305204][ T1160]  </TASK>
[  465.305829][ T1160] irq event stamp: 9149
[ 465.306676][ T1160] hardirqs last enabled at (9159): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 arch/x86/include/asm/irqflags.h:155 kernel/printk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 465.308517][ T1160] hardirqs last disabled at (9168): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 465.310377][ T1160] softirqs last enabled at (8828): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582) 
[ 465.312194][ T1160] softirqs last disabled at (8819): irq_exit_rcu (kernel/softirq.c:651) 
[  465.314128][ T1160] ---[ end trace 0000000000000000 ]---
[  465.315325][ T1160] rcuscale: memory allocation(s) from the module still alive, cannot unload cleanly



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240809/202408091019.8ed98238-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


