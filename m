Return-Path: <linux-kernel+bounces-249394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A0D92EB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409AC284C48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB4516C858;
	Thu, 11 Jul 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe1Mligw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10431684A8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709937; cv=fail; b=ZuXG+y/X25fVkS5lAROaI6y7Os5cdcjC46GDpOe0pGeakbzeQhC8K4oZ/qcyp+6ywqohZg/9110frJ/HI5hd0y/GDhoY9aWFrcjV6GPNO6SCjI/mpQRSEPLMNd8icVInq1Nou07woRERa6of9fan1H2qrtEvPpde4S9t2Q0pjTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709937; c=relaxed/simple;
	bh=jhqrBR6qZhr4qOYkw0R488uymhYibKY2QCmrAf3YIYM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PqyKwdpcU4nVVlacIHkgtoyNCKpKG4lvHvcCE3YgKwhQHpxS8NP6dkKacrtntCiSZp5E0f+30OCQJUFIscBC9P0IoD0XvH510VGRK6XhBE0GPPOLFpwXI8MKbxX98glhn+2nOS3vkY9r9DS0na3dSfsPftyzsFFbl4RSAMCSdEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe1Mligw; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720709932; x=1752245932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jhqrBR6qZhr4qOYkw0R488uymhYibKY2QCmrAf3YIYM=;
  b=fe1MligwX5bE4G3eYYlWc0twQFZImZlmy3l1tqjLumsOI9M+1gTADmdg
   kNmjuddZ356K2/gcCFlHeMnTNFzpsOA0nBabKg8PlGb5OgP2WO2/TB7QT
   s76ZKoc3SvU0Kl+cKmbyPl96dxdBOBShu1JsJcoaxMTHc+7WJsHPU0Vry
   10UvDMY0pGagV0XfcEW+auT6YW1PkXPToVjoTvrK4j8SPx/G0Da9F0pwf
   AovleyckfNiyHPBJ1CicAQ92/KPqtBLdFWAue5NR7owZYgoRXpOw0kKdL
   y+nhRSai4XFEMCnfFmDMhapec2knnd1bhaBHwx5L4HQwxd3lEsUQ5LdMH
   Q==;
X-CSE-ConnectionGUID: bK/1bt5AQJiicVL88+H6Gg==
X-CSE-MsgGUID: d247aFIpSN+neBfYZfRacQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="21004752"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="21004752"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 07:58:49 -0700
X-CSE-ConnectionGUID: RuW51F1fS22d+pHA1w3cEw==
X-CSE-MsgGUID: 6gY+E+QYQy+xb6oJFV+YGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48468596"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 07:58:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 07:58:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 07:58:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 07:58:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 07:58:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJDkpZ1uXpvVOZX8BeJCHoqeaeJxVOlBH2VsS4h3vnYnZz21gfVuX2E/XppngyQjhZT2Qb/qyxqXTlY2e8+BAGwcEBFV66wnLFac39z/+isnxLvmBpK01CF/x2xyVEG0wDG9W5+2/3mtvbBGQjuaXRw4Sni/u1o9GlHYgoC2Aqi0UPmwQo/fVSzUXzm4dQujOgFiQq1L4WQ/VgdgCzi5t7lAnjFwMoStuKYHjT2tpZo6srWLDGxpWHj+EgRoPhx9Ka92E5KnzAgpbag7eHuLa8SN9Kcxk0tr/cHyD53X9azq6NPyeK+ngZky40KmnldMe5E36QUkdRyrGKkV0EoLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBhkN75KnI0JGFgfuuqSE2NZavXSq+S4NynlBiPREuA=;
 b=m1SxCk+yxQ2Sbrng3PMN9V7E00d7Q/ArE41zQzyuafRjzghwO3R2pT5nhEAAKdQFKDgw71hh+nMmcguR5xExYi1hfwbDl8RESMSMthNPl8zhEg9wMd4fKYfDvYdFJIMZRqTFUEBOqIcvnBI82OSumCzF9J+VoUC4mQniu9j/mI7hTkFrawv5a3CyA0238WBAr2ecKqdB3xATfFjff9fHBWIWn6wwpfWHfGwcSdURkxfdy/rgKLC1Y8UbPqSXMVg5xjIT2xk2OagkQDPx5kDsq/VetpuTLS2HEWRCmFbPaKG3H+Cw+qqvI6PWnPCcjNtpPzabOQgTnFv6CMn1x201Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DS0PR11MB8113.namprd11.prod.outlook.com (2603:10b6:8:127::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Thu, 11 Jul 2024 14:58:38 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 14:58:38 +0000
Date: Thu, 11 Jul 2024 22:58:28 +0800
From: kernel test robot <lkp@intel.com>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Joel
 Stanley" <joel@jms.id.au>
Subject: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb:
 i2c-mux@70: idle-state: [0] is not of type 'integer'
Message-ID: <Zo/zFIXN1DFoAsuC@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DS0PR11MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e1373b-502b-4587-89dc-08dca1b9f18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H/bhPeJjk3YRev3BWwopKUDNJ/N2GjjyXjeQ5EjCJk9dW1xVk8dZWB06AeId?=
 =?us-ascii?Q?i+0HUM6YG+a4bu5e+ByGjsha22cm5UGuk4JKPKNkpIljZytfsutti5128YIr?=
 =?us-ascii?Q?OnQgaEtK9ZbkXTcBbUmBBw0aukscxeuPvwtsQs0s/7aDWr4YhNgWKoajuF3p?=
 =?us-ascii?Q?iRYtMJhmqHwNKm4Bk2sOUwqBr9PERPmsKbPIyEAfd6o1S+0oc/nMpNGQKsl/?=
 =?us-ascii?Q?VXPPhQKhFn2PdxsDzLHqCVUo15IeuGav6HRZF2eS1vKlcjNoVg1zFvtMBN7/?=
 =?us-ascii?Q?CjFbDTqTphgvI2Q10OIY9BMHIPW5e+ya77Dqa1I4lIYjZAVzakmo5kjFl6lc?=
 =?us-ascii?Q?jlF/sGucxqr6Mu+XM0tMwm29qBmgMygfJJIUmaHBBjHqIIqpVSkQkqT427vB?=
 =?us-ascii?Q?FSZobFHxZIppaLIxRtJtGSjXovvqNSHLMOLdP7dIGgE4DHD5VkzDZDKF0dmZ?=
 =?us-ascii?Q?0GfyZ4sS9Vq4YeIWwoLcaWL6gbz1qL7DDtVfGlu3YcltsI8qffSMjF+Gydh4?=
 =?us-ascii?Q?WD7M0T0mJRGTwJJJGlC4EI1R9Z8zjeQTEcQcGi3z3DvUzJ0a4fssbNlmwN47?=
 =?us-ascii?Q?CMsB+TrWFjpCKXPriGvAWjA2hbna63lupirB8OWof8+6WDYYzRUDvQO5Oego?=
 =?us-ascii?Q?/NhF1uvwq2upp1a1cGEvmPPgbkaISsoEAIELndwBh1/bNXEQqy00xaSBSHQF?=
 =?us-ascii?Q?4tFncR8ssU8VH/3iiRek7Rva98O1xVMkKhnx3HFqq0joJtYMepm3/yIvC/gy?=
 =?us-ascii?Q?j/uEEUX8A8AAZydSBRoKQHuQcGTlrB543Wd4w6xu3ya5stWetFUN9Op0xMJk?=
 =?us-ascii?Q?Elu+gElMJ6/J6U1RhDyhPAlloZac3H4hkhcRB/bZAIdT4BYzgDOyfa6SxNlx?=
 =?us-ascii?Q?fBtVF4pyPlS2sKGYgelxTKakNaAtipNULF2tTEaBKEpp72d4cRUcSGVNtzcU?=
 =?us-ascii?Q?KTsABLm9Y2jQe77LRVj2LDET8vRXyosc7Kvv1cx7/w95E9UfbvTDBaKrDXho?=
 =?us-ascii?Q?kHz36j2wevbXmaejQeDeDveSzULFzC9au9gHAZBny1pAYCYABSqldCho9DjL?=
 =?us-ascii?Q?Hp0g2pU1Ps5KDBg0OfWSImxdjaNQsrdrs0jNv8BL4CEufsUglqH2aOHNwAT1?=
 =?us-ascii?Q?gCLpo5pJf7Z5fnP6NputFDXtC/P1rO4uyAdr836Tjffx2ZqAmJ9inzjo59dw?=
 =?us-ascii?Q?UL7loYOm4wJP3kIPSEilqxb+3TfWhtzSoOsPk52h3gstJROMcfYsS/gWGzNj?=
 =?us-ascii?Q?M2Y+3Di6iJCtv9LTpgHiBaZT4eeZDb3XJCRnxcDT0wzz4fWV2G/zT8UZhiTY?=
 =?us-ascii?Q?PBLXZaB4/8E8ndhI2rnqPDx5M5D11cMQFnxBB+N3l5kadUJFY2o4HZUbdyvj?=
 =?us-ascii?Q?tY7yu2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n31IdtuyGUad3uDharv1+KAl9za8Zq++kGj8FaXJwkIFg5nfhzfZYVixcFXR?=
 =?us-ascii?Q?W1nG/m6zGCVugjGM57kjRPq8OsWYp+WTbVXwZUdAIPq6egc6lVIy6gXrqD0L?=
 =?us-ascii?Q?rucuAv6/RC1sxdClrT5TXiai8IodExatkxr/iWGXCD3ErP7qQBbhBIe+tPwo?=
 =?us-ascii?Q?xuKzUWQolcxeKwEZUGWgpcYX0Egay7ug+W3yY1YeH0iWlsMNJJw+RXooy9WM?=
 =?us-ascii?Q?ycG/NQUXfHtJ36NdW+3emzGUWzwCH4UcSq2LppOvpOpM5QTWXFC9ayZ1E41F?=
 =?us-ascii?Q?zD2bQwMdfq9JHt4+wk4lU8RrM+F1j2rWY+gsV7tWza8ATfNFkEGyOahwigMo?=
 =?us-ascii?Q?5L+czq1r2ERHf3il9VDYiTHzFK27hKVYXi1L6DmyeTaNVELeknp6OE6FaLQs?=
 =?us-ascii?Q?3H6L6C7GcjACbwTcC7SmaDaxybs8VVuBnJUUkucY8O7nrhy7X5b+Tr/Kvy7t?=
 =?us-ascii?Q?NjfxHgrgSvA5aMnYYny8L5av4z5FEGWAF9cNCxFiu3zhJP+paB/jIXFsUal4?=
 =?us-ascii?Q?NnFmoN9MWfYHn/yBFw+cmf43qbuzy2aQ0QHFJYDcYAb85/w7GCNxsty1DZpq?=
 =?us-ascii?Q?PGyVzKlnbKiAqbdTodaEHQLepmPQhpo7Oj7wJ/B4cE+Z+kyBoLC06z1lZ7MS?=
 =?us-ascii?Q?tu+Ps9WseFlvvMFGwKthlUHvHwBtyhDbJIxUZIKGD/oN8VP65oJ1ao4wfRnM?=
 =?us-ascii?Q?rrMKI9NpeGaUK3QsX8xdSBTy1P34L82fVyZ6A6YCh34rpEtPYQ44SNwugXbh?=
 =?us-ascii?Q?S9dHZKMb6dZyKQjCdHpAHqSowT2kNLlo8SfkgnZEKbQl+qz8x7ASx5HM0Dlw?=
 =?us-ascii?Q?fBImozYlkrKec8+E7DslvQx4xG1pSDcK2rybsAHVx2jIDwhV8nxvPUyEudbZ?=
 =?us-ascii?Q?NQ0sUDb2M1pKzRlQuYm4tSkFqSfmwUzaG/45AUb2z2QzK+zhww1Q7fPEalYr?=
 =?us-ascii?Q?8gIBkvm6b3Rr/Ry3smdtZ4UPhalm5LuLhDPdkYgFCUgZvaCBKvFx1dUXx+u4?=
 =?us-ascii?Q?hsIQFGynNCt44HEZdSx4wWeoCkHirKR8tAmbopi2/fnmiPlvfMsUaffs556K?=
 =?us-ascii?Q?dmpKlEYRZ1Eh5BS+T2rg3bDpKVlBpbI1kdpeUS1SkCl8COniDwqVVl6o5DeW?=
 =?us-ascii?Q?E6fUGQoe2Yd//TOI60kabiGkET2xUUMzb4J/cWSkgXRQcR81uc9QB4g8qDkt?=
 =?us-ascii?Q?Hrq1eU+2oK9HGSsXnT/183QUUESq3ueFbPMv8fuPjsI3lHLeO/puUrpHLOEn?=
 =?us-ascii?Q?xwZQB9B9c9r6ZduIIdU9VTPjcygm58RNYuF628cR4DCfi/IUWTAxKKPVBy4I?=
 =?us-ascii?Q?RfgyjTepeKLl0KvftG+DBRmTJO7XZpzy7MtaWVjMstLlZLLlnnSyAIc8cMHt?=
 =?us-ascii?Q?AcBRFGPfmx/FIsrNpVM2EaiBkeuefcF/QQklta9TZ//o298kv/oH0PSpSzuf?=
 =?us-ascii?Q?G35BWjSXLU0mDjyj5oOkMNuMjVK33tqYjBF/Nii2O0YWOLNxE2VJgNKV4bZw?=
 =?us-ascii?Q?dTlWPtJb6loXqX7uXUIdL47xwVTrsMiZiGB6anV5Q9aFaljqNiltg5bjQz/H?=
 =?us-ascii?Q?pzvNNQ0Ny1b5oEfn2EjMV2mUETAJRDepAjU4V2EKI0OGSJUDl6kMnlvQQvXq?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e1373b-502b-4587-89dc-08dca1b9f18e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:58:38.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhKz0xjrOCSW8iN1dAsoJBvaD1fCE4FFUFUx0OYRd/ZuVCKSgIksJu7dcPYW4u/RZvm1vpg6MMk66w27IiBfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8113
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d9a2f29aefdadc86e450308ff056017a209c755
commit: 2b8d94f4b4a4765dcbe4a48cb0d58b266c158a10 ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC
date:   11 months ago
:::::: branch date: 3 hours ago
:::::: commit date: 11 months ago
config: arm-randconfig-051-20240711 (https://download.01.org/0day-ci/archive/20240711/202407110931.S4axppJr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
dtschema version: 2024.6.dev4+g23441a4
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407110931.S4axppJr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202407110931.S4axppJr-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@280: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@300: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@380: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@400: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@480: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-mux@70: idle-state: [0] is not of type 'integer'
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
>> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-mux@70: Unevaluated properties are not allowed ('idle-state' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@500: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-mux@71: idle-state: [0] is not of type 'integer'
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-mux@71: Unevaluated properties are not allowed ('idle-state' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@580: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)
   	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: i2c-bus@600: Unevaluated properties are not allowed ('#interrupt-cells' was unexpected)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


