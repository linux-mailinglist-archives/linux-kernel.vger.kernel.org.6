Return-Path: <linux-kernel+bounces-245268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B956892B075
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE121C21756
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DBA13C819;
	Tue,  9 Jul 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiIVHrLo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D052BD05
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507442; cv=fail; b=W0Rx3ZYTh1FpSjlUaCbATsF9jRnp+WtoNRprip3QnkHAWECSAs+K9f22K6+RRrBm+P90tB58X2fYEobfBo7PfhGKePzZtw/OzJSVwMdnofKjWXoRZlMFDCwhy97+2I/pO5PwDPwu4S7JsMAu8AKhINXmmdOGM9AU4sDgQcw6vDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507442; c=relaxed/simple;
	bh=1udNZYW3q7S2DMgpcerxavhDNcLjNOfmZFNwKdnD8rs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hgB0VY4P5LwSAP7/NlpdWOd7HrjN5zuL2CHUhfpirH1HCs/lYwg7fpZJXZ463ZY8TtMMSAQyzAy/e0hTuV0CstwPHu8pVwAWJMluUp1fZZVGYnBiMAdhCkF2FgSGVpgMuioY6rpNmiQQu+igXGpwDZRwtUCwcA2HEzr9xTPiM8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiIVHrLo; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720507440; x=1752043440;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=1udNZYW3q7S2DMgpcerxavhDNcLjNOfmZFNwKdnD8rs=;
  b=eiIVHrLowydT8zeix3kNxdZ705TEUsJh0z3DVASmASgxVDm0zZnMpeUp
   L2fqfO3Oomc0WXSBwOlf+M4R28hwPo/iKtT8Sm/JOKJaK7GlFFwgEdGAN
   Mona+JjLeeLWy96RSHAi5pcKkBDbVe9MtTx+Pwo7U8j93hw+M72c5EyAW
   2aw1LSp94zbNwD1H2IgKbTar9Vhn/BjHEIig0igbBaVpL10IBx8V/eQxI
   diElgDRNYpdKm9zPA7gChJT02RuqPjS89iM2j52gZaciKQ4J0o/vu/Ja/
   VFATWA/QOub5pRa7ETp70SpVVa1LPJMhsPm+IQcThbfI2Ec7TmRr+fyt6
   w==;
X-CSE-ConnectionGUID: gTmN+RWtReCTESr3xRja8Q==
X-CSE-MsgGUID: m83m4yPbRSW4+Gx3hKNgMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17577818"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17577818"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 23:44:00 -0700
X-CSE-ConnectionGUID: tf88h/EEQX2V2KJNdanI6Q==
X-CSE-MsgGUID: pMbOqPRjS3irHq16NkHNPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="52153558"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 23:43:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:43:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:43:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHh0pe8mw9K9LAPvaqbyhR/m77Mol8C7ZvfHUan0x1ND5GjMMBKJFDyXWBxmm3nAgYvy9riAh/OdnaRgbSprH+pz7Dg2aCC2Myykoq7e+GNwclQ2WiOpUONKwLJ1vOIOBRntDEP+3nlIysAIq0iiswtWDVfnPNF/zZFfXf5s02oq71yIoot+bkd8/6hYXGlfxFqrYlm5Kh5ase1eicE0RvJvZJKvpjRbGYviL10lZjHL4DBbbYjQE11DPn3mbUsgPU9uOlLGwfyKPq3TVyYO21yUnjd2f4xWTt020pTIj8LK8Y+xSX9U8dLAQPMO/ugUpQraRmr9OxsdddwE/jIpOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkUuqasQXsNaRNW2ExF9A1OKnQ3du27suxANPpESw2s=;
 b=PpLSi25trWfaF8DGSChtV5o3b28zq5tfXgLkWgKz7UndwS7o+30V5NRibrJNXUvMChpLvUQOqzrf4N+EblTVcYnep9YASPfmtGeGzbcQo68XtpOBKsT2aWY9i2VmCwiDeGDxqfPJT49XQtJFu6jBdxeNZ4QcvOXpPfJBK56uFmG2429X0MloxL33p2YVP5wnsdwIHD7zvAuM5FWKY23fv/qW2ESVSd4p1/KMXxRmT6F2F5sgV6LPeMAq6YIUFQil+ftTrHI8G1Xaqid6UR4nFETRVwfuhxKqmoYYpCi4o0+Z5esneE4WruMUhbU5tNqG0AZVfRY85mlMkUMB7layKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Tue, 9 Jul
 2024 06:43:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:43:39 +0000
Date: Tue, 9 Jul 2024 14:43:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Nikunj A Dadhania <nikunj@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, <oliver.sang@intel.com>
Subject: [tip:x86/sev] [x86/sev]  06685975c2:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <202407091342.46d7dbb-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e58cf91-561a-4834-0ef3-08dc9fe27743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9VHrviahX7W9FUmPCFLn/D/OUk5RP04QlesWrTcJniSO3JFd3cvx+aFxiM9T?=
 =?us-ascii?Q?/HY2GJFcmh/k3zHVjQTqb53lhvaMKH25sxvdTzmkM4vapy+Yei1A2aCZpS9p?=
 =?us-ascii?Q?m+wAf70q/Jjw8xqoFxjEePsw44kPgeWg+PHmDr09p/lvEqGvYEqOLbAfuv7w?=
 =?us-ascii?Q?i2RS3MOfY3No13JtrHsINxtvguoYLG1mEO+RrpXoCeykL8KGeiEh5Snb37W6?=
 =?us-ascii?Q?sxQGN2dtlidwBRvZdxZF7qhl7FAnfYwyEOsRMpifAOez6nfpTwQDPj1jWMe9?=
 =?us-ascii?Q?HQJVCBagmW1wPnvBVyEQxmChGiDKjvxeXw/+UrUktimNNBJRb57ROuKTLkrt?=
 =?us-ascii?Q?YLjRWnOdk/P3+jBeZ5Fh+fUflYoyXDeE8mDoqP+4LEWxmxWHjlMqy1UeHroT?=
 =?us-ascii?Q?xHcwsX3gscbpSzcfQDkCRWyPd3hE3IioiN/qpb1njX5Qepin+FyE86yyGnUt?=
 =?us-ascii?Q?p78LuKrXru3EoasL7qxYhCc7n+SnF3GAVYh4/4I+60wHOnNVnbfkNgkCo1f3?=
 =?us-ascii?Q?GCfPXk5NDKGnEO0NRgadPzpqhtnXCVckaUcuXdmqBxZkpXTUpfVuMM5w04q3?=
 =?us-ascii?Q?mc3BhqA059qH6THJMKRoW7ex97S1M8CKR8nanysb8ZrLBDUXJQWWaenOuSFy?=
 =?us-ascii?Q?GaBE6rmvAh7YhyfvI9RFrItPkLQhlaPMQoF3BPDbUAMLlvTOpADAXZKzOVAx?=
 =?us-ascii?Q?MCw2MWu6WpmDAHzz5MFfrFt5Qu9HpVmJsufGH54tyqd2YtSUTBJwyEoQPQcr?=
 =?us-ascii?Q?7hxwS/x7inJvb8ZK/qzdsTBUTRfel/tX1RlET5k1IYHvB/fGay0rseIUn/Gv?=
 =?us-ascii?Q?2f97JnGsXvTUSnbbwDkIlgkC5Yd8ugoS+ZvZOI+2O79HyzVf5ZZQWc422brj?=
 =?us-ascii?Q?ehxVc4hTpJR4Q/m8gWg0F0L/xHtZEWVgmdF52jdeRCefPU4jt4+618xkoU3e?=
 =?us-ascii?Q?LYTtPSHM+KpYzn1BaUOr7TL8nlj+UX/yZhOHcKmFFKnwxEACDHU1tHwJTTy6?=
 =?us-ascii?Q?8DIhyI0x+VQKOEvWyRn5bH8LTQpef9KRhfC+L529nDPOrgWBXjukfCrNA/le?=
 =?us-ascii?Q?2GC0Tby/JmftsyEfz6w1KRIUjoo3Oxy0iLn42HKk4lxDiTM7uurkFRE0lXkQ?=
 =?us-ascii?Q?i+B2rEf49ZZpg2KIUDKF9z8R8sg54DPA0+Vy7uQhedjxkalpntDKjtQLnrlj?=
 =?us-ascii?Q?YMLOiX2xw6fqqg+ecsDapJS1zZUpmNiyNysT4tI7doFbRl7vFVCFkEuyxrip?=
 =?us-ascii?Q?yF5acrXktKDlv+wtcVGZXEwGJvH+9I6XmIHxSr/T3/IMer/Qp8pxgwMakWYG?=
 =?us-ascii?Q?O2URACYfgBpha9Befl9Lx+ET?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UTRSaejHbtLl0BWxX9TBCQ5jcet77RNFcWdwDuLHIj7yMkDTI9keTJaru0xH?=
 =?us-ascii?Q?aczcaxW1biE2E3IkZShuAgyRUYL3LQmAP80VFjqfzHLOtNLbVu6f/xaiRQDc?=
 =?us-ascii?Q?1PjOiaSWVmeHwiEh1s5/kIyLIG+ybSLxyGv7qASPmEAXOFX0N+FKkXnsxrJP?=
 =?us-ascii?Q?Ih+CcYqDrC+rkaWyLxxGoZg/sxm4d0cypajUKkoItFPLbH5KdB7U7GoIX9Vy?=
 =?us-ascii?Q?4ad3yghqX9sImJ0PhmXF7/jxuzcNAHHcDKadrSM/D/nfttOIr/i0ZTiO29f2?=
 =?us-ascii?Q?OG3oXG7UUVGMYRy/66Ypq6M7KVIbt68/a7XAFC1BtoZKXU+JV3yZii4xBXm+?=
 =?us-ascii?Q?EQhtemnP1AZBjA+3lWnMMc+m9UmrF7LiHHCA8wb/OF7LOpb0MJrvy0NEYO5P?=
 =?us-ascii?Q?mKoHrJc7plmUahCDOjt6ck5a8/t8RRr8VnlRzbxSAAtI7MUDMI4+UtWwRpkW?=
 =?us-ascii?Q?UV5ICzypzKW+bMZosK86VwG+eIYpY/J6e9ooBirDyKEz3VsoABgjJK8Qa804?=
 =?us-ascii?Q?AlLDNVUGBo5/h9HWitNRtQY4Q3ou/E54/ql9Z2/fUbtUljhgqWaVtFjbJtoC?=
 =?us-ascii?Q?5FkDbxBxfswqO25O67+8thh6LAHa4GxVVmSFyhtxspY8XBDAKjLBuIB4IIG+?=
 =?us-ascii?Q?HhNEa+RWPP79UNjCe96+WLHCOJdLrrCqu2z0STQ8zWy+hTqVCTMVX+Vi6G/q?=
 =?us-ascii?Q?rn9vAWtV5U30jDvkc9UKENH2Quaa6rU7c7aezEKhAmnb8rXdBCZQ/qP/zeGz?=
 =?us-ascii?Q?ufuxc7NOF0eqrcfYn8vcT+SNi/fM7QpKboRMnGzzQPw11wVb3VNsAyI87pXK?=
 =?us-ascii?Q?sPJe8Svedk9k5hQ9UbEUUWLBcJHCmFkOrDu0gQWWDtEk0eKD5XcAOBPEGtAa?=
 =?us-ascii?Q?LFWn8ozSYRfGsTYBZmgLUY8g4ks+w204sGjxKmlAyLRDM4Bp8eZkzB/VIfp6?=
 =?us-ascii?Q?FZniXYpiEnBOCOlkOSfrKWfS8vejE6R3dvUyut3v3Stv8jp5tEkaS8PLldFz?=
 =?us-ascii?Q?09b2CAJKC5yIr7FR1L3z1YoJOorlwBkS7FY2eX1v4nVSpAPvP8oO5pZ9ErAV?=
 =?us-ascii?Q?DHFyTibQKfh3bM5ZVxD/ckFE7CAbwIPDlZwbh37OnOVVmqwJ6iymh1+faEh2?=
 =?us-ascii?Q?+ZsT7WxbNbUBEfhgNJZfyOgFYFX2Deq9/YAtPGoVBsc3UbyZl5FfDxqEoEed?=
 =?us-ascii?Q?nNOXixKXoICeI3o3zhwKzeH2561VOod5ZyuBytIU26OdPj/DEAJHdulvf8ty?=
 =?us-ascii?Q?yfbcQu0yD7r6IAkCJWvFwT916mDqShV5xYZX7upzo+WXDKnKPb7RT/Poa1+l?=
 =?us-ascii?Q?g6PhhlxX1l4Zcq2ITh41xTE68IjAFle5PSL1USM8mtV2E1e0wHl0xA1zK0mX?=
 =?us-ascii?Q?7Y9Y+B1TasItnDLdaplsHIduQA+Vd4lyhFdOV9w9GBIGnSyHrF00rkZo0XLL?=
 =?us-ascii?Q?jXikod/mgzECi8rG6Mt2FK9i4npssQ68YeO/4WkZv7fUQ5gtDaV7GzTHQA3L?=
 =?us-ascii?Q?JnnE+jYu0fxeaOd3r5ebJj2/pg1OyUs7gum/+cufa70c4UrsXWvPtJ+t7MSw?=
 =?us-ascii?Q?RxotO7sPnaXPn3bE2VUJKzh4u/6HBJ78yWADddzPT5KKdC/JS9E+NHMlZTdE?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e58cf91-561a-4834-0ef3-08dc9fe27743
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:43:39.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbCUQ2YWtMaC7IJKOJ2tYaYDdPT3cJEl6HA3mVyFXH2OkDkNBNO0iG/WDZSBSUPydNHRo3JLzUCxacR/QGF0VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_print=
k:Booting_the_kernel(entry_offset:#)" on:

commit: 06685975c2090e180851a0ff175c140188b6b54a ("x86/sev: Move SEV compil=
ation units")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/sev

[test failed on linux-next/master 0b58e108042b0ed28a71cd7edf5175999955b233]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we don't have idea how this commit could cause early boot issue, so we rebu=
ild
kernel for both this commit and its parent with the config in [1], then rer=
un
the tests, the issue is still persistent while keeping clean on parent.

3991b04d4870fd33 06685975c2090e180851a0ff175
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         25%          50:50    dmesg.BUG:kernel_failed_in_ea=
rly-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)

since the config in [1] is a random config, we also try another x86_64 conf=
ig
which we use for various functional tests, still can reproduce the issue.

we also try two i386 configs, but not reproduce the issue. FYI


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407091342.46d7dbb-oliver.sang@i=
ntel.com



Decompressing Linux... No EFI environment detected.
Parsing ELF... done.
Booting the kernel (entry_offset: 0x0000000000000ffa).
convert early boot stage from reboot-without-warning to failed
BUG: kernel failed in early-boot stage, last printk: Booting the kernel (en=
try_offset: 0x0000000000000ffa).
Linux version 6.10.0-rc2-00015-g06685975c209 #1
Command line: ip=3D::::vm-meta-70::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/res=
ult/boot/1/vm-snb/debian-12-x86_64-20240206.cgz/x86_64-randconfig-r016-2023=
0701/gcc-13/06685975c2090e180851a0ff175c140188b6b54a/21 BOOT_IMAGE=3D/pkg/l=
inux/x86_64-randconfig-r016-20230701/gcc-13/06685975c2090e180851a0ff175c140=
188b6b54a/vmlinuz-6.10.0-rc2-00015-g06685975c209 branch=3Dtip/x86/sev job=
=3D/lkp/jobs/scheduled/vm-meta-70/boot-1-debian-12-x86_64-20240206.cgz-x86_=
64-randconfig-r016-20230701-06685975c209-20240708-45480-br2l55-20.yaml user=
=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-randconfig-r016-20230701 commit=3D066=
85975c2090e180851a0ff175c140188b6b54a nmi_watchdog=3D0 intremap=3Dposted_ms=
i vmalloc=3D256M initramfs_async=3D0 page_owner=3Don carrier_timeout=3D60 m=
ax_uptime=3D600 LKP_SERVER=3Dinternal-lkp-server selinux=3D0 debug apic=3Dd=
ebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=
=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpan=
ic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 sy=
stemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,11=
5200 console=3DttyS0,115200 vga=3Dnormal rw rcuperf.shutdown=3D0 rcuscale.s=
hutdown=3D0 refscale.shutdown=3D0 watchdog_thresh=3D240 audit=3D0 kunit.ena=
ble=3D0 ia32_emulation=3Don riscv_isa_fallback=3D1

Kboot worker: lkp-worker32
Elapsed time: 60


[1]
The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240709/202407091342.46d7dbb-olive=
r.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


