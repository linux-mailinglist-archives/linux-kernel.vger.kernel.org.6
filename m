Return-Path: <linux-kernel+bounces-384172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4D9B2537
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD141C21005
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F718DF83;
	Mon, 28 Oct 2024 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQP52MWf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B742142E86
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096683; cv=fail; b=k3hXUZ/UovGMGQFeWdd4J9RkeovemqZqBX7H0F6loc9HO31rN8/9SoUUdhNaJ5K7bNf3nLrG6++ZfiyRi4aYf2hhh882ADzdMVJY/44RF+JIxjQnDjHLmpbHpJwz05PlqrCatftOpSMZ3WBVYwGSROOYXCqwX0ccJlz39N8zz0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096683; c=relaxed/simple;
	bh=83JvrKBdeMTb489+4tX05jAMUmJcSYnfGgp3zx1bCnQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SRAkgzdKsYBfE5fSgdnODkvdmfCDaeNGccs6D8BfwqJmYbLcN8tiELeuS52jqBt3kE7gSYm8C82mtX0riUNrk2k2xtR9Sj+sK1+PbiJMwrjzLScIrNYMRR47eECC7/03K0JJu3pGNfOZmIdCY/DDn9ehF/Fa06L1UimB6mmAf+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQP52MWf; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730096681; x=1761632681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=83JvrKBdeMTb489+4tX05jAMUmJcSYnfGgp3zx1bCnQ=;
  b=dQP52MWfAl8mnuILi2wbqsTQWPLFon5hKnH8o5jhVNg6CF7oobbgneUP
   cDSSABys05/UL3RQ+Hk7Y4GPm0wcfeiB7S56yWbdg3CJLj0eYVUPgCWJh
   AEvUqCIdHTpkbaUXmA+ck8dNPGf29/I+M4N6g35cJXSWvUj78olv92rN1
   VueTn/ojdt8ZZZPXqcijzhbzxb0/zXrqL9tqftMr2Tn4pokCRGaSi4J+8
   3ulkfBkJAUhteuzFFSK6SyzhLkB8Qu0g1k52SuHwooWo8SH5JyAVED5t+
   z1F1iQdKIOQwvsIR84CF1g/p9UdsqKHg2V/9rW71kCHWJIMLK/YbdGDtN
   A==;
X-CSE-ConnectionGUID: o3ar6eTQQQGgUlwJJCjrPw==
X-CSE-MsgGUID: 26uDHUZFRG6rffj/hzY0EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29819382"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29819382"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 23:24:40 -0700
X-CSE-ConnectionGUID: qsDNCMVYQMKczrOcGdT6Rw==
X-CSE-MsgGUID: nTeYlrRLRuexPj4hoB7mmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="112355234"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2024 23:24:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 23:24:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 23:24:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 23:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHoflxIBzn7wOo8QmXr39UUczq/eHBY0JuTnWNiMhf40qIezfvRonZWgHUZ9HH8BiY61xrDSapiQGKZk/clo9cBkIeOn7STkcNFA9YyVg/eZi8/xy+P4waVfIT1rJZpCsl4FqUfgihkVgkowCTo6I4z9M5NS0cOi0eJZK/WYLx+0+DomF+3nNr7eD0Kr+rXa8ezJ6nBlO9Idx58Ms5Vo3Drx6sXx3mIDcLzAnEZFmmsZgVSUVXTRJ1YFH3EFdFjXp1B1x+svE6iAnpSaW0QTgqsBKvz7EdIs4mRjddCFfg5e8Fc6+pwL9sKQmlEaw0MWE0vnJipSmIfHXyrDdkbo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fm76JnotfEoIYOzHLGKxH/3g9KGrcNM+Dw4Z40TnVI=;
 b=YZn5RCBFh0a1k4T5xCT6VgR3swMypuxzKdF8te0b942ups5OgiffWvfl5TKyYZZH9vndZtpF6fRq67XXm4nOApluJJffGZeNd1fXgKGLgKUzvqk9xeQfuLPy0oHt46MATYk3bRMrbO5vqIN5cTWZc0hvyP01lz1uQhcYtCyPYO+XV8zeT6d3ecF91cB3Jf0OVuIxTglFUixtMvvcGcC+F6NMQZZyS6rwyvxThepgA6bLZhpVX9jSOpISMyUNA6j9P1CNtHpGTZrJCTR4h8nYmtPSCCKNw0qaiW25m8a4PCPfRBUnCnC6q4MnIQvL42MzaYyZ4aQBgV7oJQvnOQ5lKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 06:24:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 06:24:37 +0000
Date: Mon, 28 Oct 2024 14:24:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alice Ryhl <aliceryhl@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [cfi]  8b8ca9c25f: CFI_failure_at_do_basic_setup
Message-ID: <202410281414.c351044e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c16d5c-a68a-4ead-569c-08dcf719325a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/h7EEZ+UtMn0vQRj+u/rvKwXdcN4+/88SofXIJd3+d0fhA3fnyZ34z7bUPFU?=
 =?us-ascii?Q?iGsc9rF05Gt4I+nvUWLcpyebTKnq4iqUIHAbyanmfaOvquE2pJb0ymXZKwqQ?=
 =?us-ascii?Q?sQsz9kRJ2NCxd2D0ucsJ/uqweE1MhJGpKCfQx+vong3Tjj/VMa04uQMGtyOM?=
 =?us-ascii?Q?s1ppIElBLPBat/gMTHeMGn1t93X9/huJEllTwBTqSbOR6Y50csHPr27o9ga2?=
 =?us-ascii?Q?PcWjyj54Sgi53HgB0hsENmX7y7zr6721PeziO+0KmsIG3yAtzRA98Cn0QMGk?=
 =?us-ascii?Q?/gl2+m9W1aGGw3sNAyLJH9TnO5vYS/cyk4jHhM1mbqkgRaIXxa+QLpRyVy0g?=
 =?us-ascii?Q?NXbT8GxbXzXcjdkpJt1+JUpoH9lKeQvTIWjhVJJkzPT1Oo2+7wUOQAVD2qHy?=
 =?us-ascii?Q?qwEmEaWgA1SxZYHqwEFVCrFMKz/xBFYmaIp6PjjY74rKQAW5oC0doxDF+ppd?=
 =?us-ascii?Q?hkwFc9gtIXCLBMSrYw4I0bRjjz488yH93zzkmuTwlf6teFe6SN++yrdvlbq/?=
 =?us-ascii?Q?p78YxLuGFyRKX7brbm4VPF4xHtLNNOOjtuK1Oj5ZeTyHAPD6x6VlKoBY87Tp?=
 =?us-ascii?Q?et56E7tHIFRhtdTa5ycedApIGiQvP/BMwUp0GWFpco1C0jWW19EC0lH4g1am?=
 =?us-ascii?Q?jgUnns3AEqqLcw01sxNvUi/1Q4akMBgGVE21gz1uOKUAKi9M5IH12Qbw9Ygh?=
 =?us-ascii?Q?DR0UsqZQsjAR8MAvA5dEps439EMrJXFn1aP0uauR95c/TOmidcniQDYy+8lV?=
 =?us-ascii?Q?iN7i0n9bDpVQvh3bjYXjdT65ayJl/NY9f5izIy+0JLrd+lKV9+bDk/sJstVu?=
 =?us-ascii?Q?uAPw1hbRgPnCf5SSCGs8H7FEbWqD7SJM75CwFDAbadgrihj5M1EI8upJ55MJ?=
 =?us-ascii?Q?v9ZiC7oZlcme4nOhLVOqoQvSj7rl7CX/cUv7d2/MPogRmk/nZERXRgCUIXfZ?=
 =?us-ascii?Q?uQWg24rApH8/vlf23I18VmWuOX46LHSUU83f04KES6JSwQa+XuCf2TWKOon2?=
 =?us-ascii?Q?VXHcvYfQNFixD+bteZo6cBHzLD2IKLRu4nGor1jtHO4L/rj7RY2pxvgosgla?=
 =?us-ascii?Q?98iFkP0SrrTrICo9pJOr96+vYU5BRpV/+rV2AD4omnOlMFcMnrHvfuiBsjjG?=
 =?us-ascii?Q?/w17A2ogeSUJb5eYHMW3bxSD21iQyDu+J66xnEwz5Pkna0PKSPHpaVfEUkti?=
 =?us-ascii?Q?/sFaoIXqATZMFEFgB4f68oiopCuTJrDNdF2PnHAAPji4fQAixq1sP4OT8o4K?=
 =?us-ascii?Q?t0eDLWrN2rb0GcXCvBMxefU3cZzGcls+a1E4k14wxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BPU7g0BPittcPwQ9y8MdAo6/zLGRBbmMeNOkjTd9QW152zBw5dmV0dvWKUM2?=
 =?us-ascii?Q?I8/QFPiPWFYRNtYfTyLYwQ6FMmsvx8aCm0z65hTC3D+iDmEv8juvIvTwB5ZA?=
 =?us-ascii?Q?OnMGcSqjuDGRr/MiT8l9Q9HgTLmt5UVdsyEUbq4y/9v/Qdx0ls1i5wfyUaPf?=
 =?us-ascii?Q?XYBTFdLIwep19x+ekJKePzmUnKbBM1gtBrco8G7oM9jHolla0xwhz0upMiFW?=
 =?us-ascii?Q?b1/zJGCbRmmVgfddqEediP/5sBvAz2mNqbWoM0HkDGG4YwbDye6hZQkghB7K?=
 =?us-ascii?Q?ukNTBfyttMrm79aO2RJMHK95YZ9xTYXTWCiN2U9njwszmwR2jIMi3kwo0nLG?=
 =?us-ascii?Q?3QnBccomabQwnzAzytF5zSeyGs146T/zQNF/wPgfGlvTrpKYgvWF4anS/NAh?=
 =?us-ascii?Q?O+8orWM5Qb5Q5v288aOwx9J0lvFK6AoYy2AvGEltJywWxAEkQtYZoUmvxkgC?=
 =?us-ascii?Q?auSqUaX/yT9JpatKdo4PZaV8D1agiVKGMHXC/wzc4ZlCullyFfHEeoD1qDOY?=
 =?us-ascii?Q?dEB9ZZ9WIc1o2/CXYu8uoNt9D6WwOXWvjxfE+vIcLXlBjDzRSP3hAVMWZL9A?=
 =?us-ascii?Q?ELfMM+Ix0L+5o3YtHXbwdYSBO96j2E85Xn6Zrs9q6EUvDoIp61mlqDdHEYWS?=
 =?us-ascii?Q?oc44VdPZTlViLcmNz9d+BDU+hLohg+U1MA3jJ0yJTmNV/9xHR+EUZiSVu40g?=
 =?us-ascii?Q?MWjYNnufqbdCPav6QsLqvs6ypJ1IoI6TlvhCAMgrI/U1gSwzao2/41IaCA+K?=
 =?us-ascii?Q?E8xW4xLRxbNpM1zVnnpSrs+l3q/68hlfjbeqTpSan1Tq074WBwQCW1z5wx+f?=
 =?us-ascii?Q?62bRfPOCIYa7+iYx/JI44HyHpEIO51OlMfSTlkm4WMCYCh5zL43iaCauZBJs?=
 =?us-ascii?Q?I4EZqpCWHjDQiE6O4nO4AVowJ0SNDCeUExbW0FOOHA07Lz5ZRJZe8pyCgAAn?=
 =?us-ascii?Q?qM/YqyHaeciXkoym2N2VKBIYEpq0UaZpjoRFg98T8DI5WEtULk1cEhehBgAU?=
 =?us-ascii?Q?i8Q6c8rbcvhmBxo0L1AjtIW2I7iPHcA0UxrdqUbL/B1sWAyxemG/B9EsS8pL?=
 =?us-ascii?Q?1CU0vZJcWZnW/Xxl5jLL0SDNrX9u/MUvY33U40435KLQPYuL89nWUNQFS87V?=
 =?us-ascii?Q?oIsGXVFYsvJaF+58KPFsqfh7Pt8nNU3vRf9ABfDn9U3NtfrNkucbW9EYGjMM?=
 =?us-ascii?Q?RK9BGcYXv51h4HU+ik/sGIPPskCDq24JglLNZaZdNbCBY6LSGgW5weEIC5cz?=
 =?us-ascii?Q?krmFXTdNlcvJuA7c0HbJiH1rYz+zBuixi6CS2fC+g7zI3QlrdvoWCK4n+/7g?=
 =?us-ascii?Q?cvUh3qapUL9PXDcv5Uy7QqtZmQHE709P6MzKkdx0iazdtznEonxkQgH635a6?=
 =?us-ascii?Q?npgOiHY7wA3lQfqR85ObfsVEHAnR7wMhDXF0bLGGSufAx49myiDrvVXXJFtL?=
 =?us-ascii?Q?JJESm/rs+l/jewf2oXWPGyCNaAr8GcnyVUOVFvY02Ru18Et9rZ88W6g8Hvju?=
 =?us-ascii?Q?NOCuiYXcQrmLdp6L+CUN1m/j4S59xjRUz4UJDpn3LCo6MUms0WXMEvajbIfy?=
 =?us-ascii?Q?lrPFzIzhGW5EsGshTaPNNWYz1TGS+z3RhBURkvYFXVAyfF89ijIN93OyeH6H?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c16d5c-a68a-4ead-569c-08dcf719325a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:24:37.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+z58/D989cTUuaSZTpvgLNk+Zlx/hCscS070k8lqbv+/7sz43eRCl6wKfBDMsIR2xGQ3FYIwRNyi0QhHEveow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com



Hello,


by this change, the config has below difference with parent after building.

--- /pkg/linux/x86_64-randconfig-003-20241025/clang-19/af0121c2d303111d363c62e40413ffb39d5dc0f1/.config 2024-10-26 03:31:02.494416152 +0800
+++ /pkg/linux/x86_64-randconfig-003-20241025/clang-19/8b8ca9c25fe69c2162e3235c7d6c341127abeed6/.config 2024-10-25 23:52:03.899366299 +0800
@@ -661,6 +661,8 @@ CONFIG_LTO_NONE=y
 CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
 CONFIG_ARCH_USES_CFI_TRAPS=y
 CONFIG_CFI_CLANG=y
+CONFIG_CFI_ICALL_NORMALIZE_INTEGERS=y
+CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG=y
 # CONFIG_CFI_PERMISSIVE is not set
 CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
 CONFIG_HAVE_CONTEXT_TRACKING_USER=y

then we noticed the boot jobs which can pass on parent, failed now.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/sleep:
  vm-snb/boot/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-003-20241025/clang-19/1

af0121c2d303111d 8b8ca9c25fe69c2162e3235c7d6
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.CFI_failure_at_do_basic_setup
           :6          100%           6:6     dmesg.Kernel_panic-not_syncing:Fatal_exception
           :6          100%           6:6     dmesg.Oops:invalid_opcode:#[##]PREEMPT_KASAN
           :6          100%           6:6     dmesg.RIP:do_basic_setup
           :6          100%           6:6     dmesg.boot_failures


below report just FYI what we observed in our tests. thanks


kernel test robot noticed "CFI_failure_at_do_basic_setup" on:

commit: 8b8ca9c25fe69c2162e3235c7d6c341127abeed6 ("cfi: fix conditions for HAVE_CFI_ICALL_NORMALIZE_INTEGERS")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      c71f8fb4dc911022748a378b16aad1cc9b43aad8]
[test failed on linux-next/master a39230ecf6b3057f5897bc4744a790070cfbe7a8]

in testcase: boot

config: x86_64-randconfig-003-20241025
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410281414.c351044e-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241028/202410281414.c351044e-oliver.sang@intel.com



[    7.616732][    T1] CFI failure at do_basic_setup+0x5b/0x90 (target: asan.module_ctor+0x0/0x20; expected type: 0xe5c47d60)
[    7.617229][    T1] Oops: invalid opcode: 0000 [#1] PREEMPT KASAN
[    7.617952][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.12.0-rc2-00005-g8b8ca9c25fe6 #1 c804d49ce32901c4caca8ebfe1766898b63e48de
[    7.619334][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    7.620488][    T1] RIP: 0010:do_basic_setup+0x5b/0x90
[    7.620842][    T1] Code: 00 fc ff df 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 6d 85 50 fb 4d 8b 5e f8 41 ba a0 82 3b 1a 45 03 53 fc 74 02 <0f> 0b 41 ff d3 49 81 fe 68 10 7e be 73 0f e8 8a eb 12 fb 48 83 c3
[    7.620842][    T1] RSP: 0000:ffffc9000001fed0 EFLAGS: 00010286
[    7.620842][    T1] RAX: 1ffffffff7cfb6de RBX: ffffffffbe7db6f0 RCX: 0000000000000000
[    7.620842][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    7.620842][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    7.620842][    T1] R10: 00000000bf7be9ac R11: ffffffffbbdc9360 R12: ffffffffbd039fc0
[    7.620842][    T1] R13: 0000000000000000 R14: ffffffffbe7db6f8 R15: dffffc0000000000
[    7.620842][    T1] FS:  0000000000000000(0000) GS:ffffffffbd0dc000(0000) knlGS:0000000000000000
[    7.620842][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.620842][    T1] CR2: ffff88843ffff000 CR3: 000000042529e000 CR4: 00000000000406f0
[    7.620842][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.620842][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.620842][    T1] Call Trace:
[    7.620842][    T1]  <TASK>
[    7.620842][    T1]  ? __die_body+0x16/0x68
[    7.620842][    T1]  ? die+0x34/0x58
[    7.620842][    T1]  ? do_trap+0x111/0x1e8
[    7.620842][    T1]  ? do_basic_setup+0x5b/0x90
[    7.620842][    T1]  ? do_error_trap+0x11a/0x190
[    7.620842][    T1]  ? do_basic_setup+0x5b/0x90
[    7.620842][    T1]  ? handle_invalid_op+0x34/0x50
[    7.620842][    T1]  ? do_basic_setup+0x5b/0x90
[    7.620842][    T1]  ? exc_invalid_op+0x32/0x48
[    7.620842][    T1]  ? asm_exc_invalid_op+0x16/0x20
[    7.620842][    T1]  ? __cfi_asan.module_ctor+0x10/0x10
[    7.620842][    T1]  ? do_basic_setup+0x5b/0x90
[    7.620842][    T1]  kernel_init_freeable+0xf0/0x190
[    7.620842][    T1]  ? __cfi_kernel_init+0x8/0x8
[    7.620842][    T1]  kernel_init+0x19/0x198
[    7.620842][    T1]  ? __cfi_kernel_init+0x8/0x8
[    7.620842][    T1]  ret_from_fork+0x5a/0x88
[    7.620842][    T1]  ? __cfi_kernel_init+0x8/0x8
[    7.620842][    T1]  ret_from_fork_asm+0x11/0x20
[    7.620842][    T1]  </TASK>
[    7.620842][    T1] Modules linked in:
[    7.620846][    T1] ---[ end trace 0000000000000000 ]---
[    7.621487][    T1] RIP: 0010:do_basic_setup+0x5b/0x90
[    7.622107][    T1] Code: 00 fc ff df 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 6d 85 50 fb 4d 8b 5e f8 41 ba a0 82 3b 1a 45 03 53 fc 74 02 <0f> 0b 41 ff d3 49 81 fe 68 10 7e be 73 0f e8 8a eb 12 fb 48 83 c3
[    7.624206][    T1] RSP: 0000:ffffc9000001fed0 EFLAGS: 00010286
[    7.624847][    T1] RAX: 1ffffffff7cfb6de RBX: ffffffffbe7db6f0 RCX: 0000000000000000
[    7.625768][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    7.626696][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    7.627602][    T1] R10: 00000000bf7be9ac R11: ffffffffbbdc9360 R12: ffffffffbd039fc0
[    7.628513][    T1] R13: 0000000000000000 R14: ffffffffbe7db6f8 R15: dffffc0000000000
[    7.629316][    T1] FS:  0000000000000000(0000) GS:ffffffffbd0dc000(0000) knlGS:0000000000000000
[    7.630979][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.632216][    T1] CR2: ffff88843ffff000 CR3: 000000042529e000 CR4: 00000000000406f0
[    7.633336][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    7.634842][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    7.636376][    T1] Kernel panic - not syncing: Fatal exception


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


