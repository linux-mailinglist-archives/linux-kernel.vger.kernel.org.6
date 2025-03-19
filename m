Return-Path: <linux-kernel+bounces-567343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E9BA684C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D47A3AB153
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC224EAAC;
	Wed, 19 Mar 2025 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRw2uCH6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9422094
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364319; cv=fail; b=LBTV7mVLqEcTvO7GCGeVKJZqSV9cTV6JPNyKraAqXGQwYc3KbvDfz2jnlOgy112UkJQDiORQvEZ8gKEiQN8k6FHPgazttT7taYo/XT1gJ9T7EiFHnYJon83gW2aaX+r2yMGjZjj/yjb/sP3D8NPs1eyzu8ZbubuYsg2LAfMNw+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364319; c=relaxed/simple;
	bh=jVZzjo3KvNJf+l02YUp5E0dPJnlKYjTnF7V08gs/sT4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lfXCD0B4I501JKG2kGgZc694mAKoiJPt9mT4S4PVkmrLlsW5h4CGr4KJmtfOM9IV9wiaTS5Sn1D2UASKzjUsP8m5QAaEIH3OcMM1FLcR6Xgb5vqJLFr86AYk/yo7hjxsZjGTXk+jMg32bcYo2xsdanCSoYqcKRSbrusLKL4Is/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRw2uCH6; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742364319; x=1773900319;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jVZzjo3KvNJf+l02YUp5E0dPJnlKYjTnF7V08gs/sT4=;
  b=kRw2uCH6nhLS0cHn/60BkhsVErJrDrCjcYGe78cNC4n/tgZ8GAXyelib
   dpws5l4zKwC5FeGEXDO6bxBbH4aFasTRQQ3aiwVHAjpFXR+ckuR9wSiTP
   f9lvJ+MeZBFE5qKUJYnjJ0k1FtwhccGGEZ7bFoeVThmmFguJqZqEYyoEz
   keczoXJrOJcCyTd3gRNIKpZUGn/MOYVufVqHnHF7sUjIak5XC9Y0RqD9l
   VkDucUnj1zwBsHRiiKlLIb05CyNjkdg4tnD7NyituDTanfkrad404gc/f
   I2Hf5rfQaZajiijyXY6p6y6l+La1ZZK/mq+7x6Nz6gh1IlzrJuj7KFvp7
   A==;
X-CSE-ConnectionGUID: 857uaUm8QR6I25Ix4oNWSg==
X-CSE-MsgGUID: R9sWUyj7RdiW5rRkf8/V/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="65998608"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="65998608"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:05:15 -0700
X-CSE-ConnectionGUID: xl3auYjMRlSDe1tDOxTnwg==
X-CSE-MsgGUID: CuuI72l2Qe+zMzSczDWBrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123225847"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:05:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 23:05:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 23:05:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 23:05:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc51b/i8BHK884kkH/Nxm9eME69LB0XnY3tFK+OD88/pJrSrqGZQbCKOlJaKBZjIrHNAcVrJVPD0MPQlyM4vRQzFnDjXs2+kQ/ClcD5IyiESDu4LB3gJ23BObv1bfce3UaGRO1AMlMTcIih5J3OlawLdQCM1AHOXsxdyAHr6S3pPpVXaO7hpPW3I3+PerFiCCTNFCQXAFGL3uTqNH8f4VcryUBxy3QtxTiq5XCLUQxw6YXKrF9czgv1mOWTDujHcNbx6VXp0ui3SEO5GKaM3ni2+uCIc72uPm7XwWR8hD2QW3NWexutMBnTNd2wnV6kaADrx/0cQTM9UpucJl0t98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/5Ri0hOavQtKLW+WpdOrDgDNOBouzvOdhWtKAJdwXc=;
 b=Ui7KZ4PTOJHbFWF9XFDpJ72PjkeUUdhGnhGBsO46pjccsw7Oz6FbiFJxTrcgxTbK5oWwPZAn3OmEHJnXkjFqEKLPffaiQmSBRoSWcoq+W6O9laRWTRiAiiLZuRXIRCWXoMDRHhWewfyk8ZI3JjO05ab0rSiEwgxsEoNHQmVkYAFgSvVfxjYFe8OsfAOEJsgn1oKUXWuPCW0m7tV6pGrX4MzQfXeHm9bWTUZiGCCW28X96P/CbGOi+kuIbbP1dcaDk5+MCmhzhQInUP4eqGV3xXEGgVi+chfS4zZ3vMWa4XefKW66XqXC5P9tZsdmCSw5ynCCm+lakMjBF3+nUJQb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by LV2PR11MB6046.namprd11.prod.outlook.com (2603:10b6:408:17a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:04:31 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%3]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 06:04:31 +0000
Date: Wed, 19 Mar 2025 14:04:21 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Jisheng Zhang <jszhang@kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
	"Charlie Jenkins" <charlie@rivosinc.com>
Subject: Re: cc1: error: cannot load plugin
 ./scripts/gcc-plugins/stackleak_plugin.so:
 ./scripts/gcc-plugins/stackleak_plugin.so: undefined symbol:
 _ZN8opt_pass14set_pass_paramEjb
Message-ID: <Z9peZf/XKIkGxXGC@rli9-mobl>
References: <202503191250.ZHqkeLVs-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202503191250.ZHqkeLVs-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|LV2PR11MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c183c4-402d-4b83-1457-08dd66abe9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sL+bC52HQJLOQW7mhr3HyB4g5UTkgL59bxSoffJGYzT6TucC4NObnJTd4H2V?=
 =?us-ascii?Q?dBKZfJoUGYPwDtvWVid0YQdV7dtoyRUw9nhg6yf6ND/oSDvgRg/lngGmlVV5?=
 =?us-ascii?Q?ZOC2ag+7h4KBzLySX5gjG0J8stMlBOKHBAFMHw24yY9YF5mCmaBSaIkPYxYb?=
 =?us-ascii?Q?KgMFeZNoBdM8jhulwMXGbL3bZPst0ksFJkqRQSFj28jeIaOv5BTOCeq1DBqi?=
 =?us-ascii?Q?+E4qu/D18JvShhQlgW3jHnHgLVH1ZdyLI2nGkYfIke3NHCId3iQf101vrkVr?=
 =?us-ascii?Q?WnPLWaYIqPA2vj2g1+OTY91dAnPb8VgY7LlY5AcDdM9h/WL07P5/jsWKJLHo?=
 =?us-ascii?Q?AbsatsI97TX/43FfTN1yBHJLuT/jp8CEqKp3lIE7S3YhnoWKarENb1L/WfmP?=
 =?us-ascii?Q?MvTTRnkwMxElIzrIDT4In6YLzUQFg8lxXVTPJjzApszhr+JitdwXzXVOnIiy?=
 =?us-ascii?Q?oyb8sllxQ6yA2l/9qUK+rjIunlHuEb+FjPcMB8wTUwpl9qUTQi+DdeUw4LcH?=
 =?us-ascii?Q?z7zPjaCdR5zlnqYy/znHJP1AFKuw4SdgqV/ZSqMduD3IgAbQ1ZTwSLbs+dmO?=
 =?us-ascii?Q?KYA+DMfDsKaJu9nuuZavRzuUZmD5pNURlu+zlwcwYAj8KU0CTCu4vzQ7tAJa?=
 =?us-ascii?Q?7fJBcj1ArwnAZO4Vn52tSqy+5wNP7yFAgWBg8s2PFVqkNIRxmsZPV4IRIV9j?=
 =?us-ascii?Q?gkFzv1H/QmG5ylNUn6krYfzELF7dLXY9xkC7s5NZmsRF4uiIc4ZwYEp4iOLG?=
 =?us-ascii?Q?64hQn/GX7ForUV7eUMyg94qkOAOliAm89G3nJPbm+6CTp5la+WYXMWAaCKUr?=
 =?us-ascii?Q?Lt+QoW6oqqGAoxCJX8IIBFF4OdawQobjwsBUnlEBwWM0olb+8220U6qxsXdp?=
 =?us-ascii?Q?bp+9aiid2+7d/hbiX1DPsfwa6MEIXXVePK02qeRWfRCQO5dfnISuE5UrJu+k?=
 =?us-ascii?Q?uqYW+cOYvE5KBzGPS9sqqakundYF82fYLa/WnlkwRaValgR1cSYhXZml49su?=
 =?us-ascii?Q?/P6RGUkJXtA1ariDTAeCcfFRN3BtuidG3Oo6fZoLlWb6D0yNteW2HglkSerw?=
 =?us-ascii?Q?XZCtQjXYVEHauxkDHAx/DF8g1GPvUGHKljKhHLjF6F3wvsmu0zTyvOdj2KWp?=
 =?us-ascii?Q?Gcb3ZB5V7w/2qQXO2R6f602qgEuKK2o9tI5MlZakVxFp3dIUOF0ToIQgJW0i?=
 =?us-ascii?Q?LLzTky2vjS8G2CvAVlxqfAooBhzobfJe9wlNpZtJiz9mbHCAmV9Lq3tb+Ig9?=
 =?us-ascii?Q?d5vJda5nyPPAzVALam7GNr6/tOF0QqfFVhhEaugEl9Omvql0OFaNHlbI/2uT?=
 =?us-ascii?Q?fmRaK+zbajWFfVHMJgfqH4Vv0xAXtlhrl5uXaNl8c4hwnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdEu7yXb3iqPtMNWjTO0GxT/fzqQEjhhodh+K+lC3UGoF0EuehPdRuks2Tyn?=
 =?us-ascii?Q?Aa06hJPW4sOA/jfvOBwHNHL7hnxq6+WoKB2r7XiLuD+4xKVWm8uSyw3lkSYE?=
 =?us-ascii?Q?Q+8lbeZ8e4QudvybUnsxp4l2QiW7GN22L0BhZ82wcU9G+0wmUBzR9xnakOmF?=
 =?us-ascii?Q?GkAqv4hgnvQKbuk2tPTBmfce/lYY876T6OX4qlKev+TzUzLLTFJgT5FAljyZ?=
 =?us-ascii?Q?VauDULLkHhsULJ1pneS0qwCMjjoXlO1ao6Kt7Mm0tc924oUiw74WOrc1dIDg?=
 =?us-ascii?Q?kTsjLbasZgqtcI1B/ENyOTtE9Y904531wcSj8uCbihmrm+1EAzI4E5fhdQLP?=
 =?us-ascii?Q?mF6nNO/4jkuj1tZ8xWMIRAIO2nSb7R698sOg9o9zUNX460LqWtEO9K6iWJ75?=
 =?us-ascii?Q?XT67KN1Ltrc1YHoVhvg6VFRxPtmV0EPFxPF1SsiWzh7PytpDF1ojedOq6Vcg?=
 =?us-ascii?Q?TWi8JxKsY1fTrWLtmdVeOBD77qwaJv+WfkBXjvKj6dB90tsbN+zimKUkvbcg?=
 =?us-ascii?Q?EzX0JVK7XHhen1FYgFrzWeAxeh57jklLgcTPTEUbeXOhV+3dMepe9VDL8ACs?=
 =?us-ascii?Q?BUNJftJCgz75oBY6d8lBn9Qa0Z8YAWeDl5XvPV7EN200r6GOvrK8LTfg/ZJG?=
 =?us-ascii?Q?GYutM/0lmKw06+ZBb0q/wvu1Vctd3mAO1pZijO7ln0WP0MrFlfenxK+r9GQr?=
 =?us-ascii?Q?klGNzy4FnE5aophByaDMDIgL1kuUQMo8nMgGmuvBc9Ix1Bd44weT3fF1sppI?=
 =?us-ascii?Q?VIgBk33sVQv4dVVgqDlSyCx86+ntMfVZ2wNgR43M5EBnbbDjKHCkxJWJYdFY?=
 =?us-ascii?Q?0NmKxlPxnxS1LtnX9JuzaEE2W8pf/yUzD8GBreT3OXeuEJvPvXMpRUoQD0KY?=
 =?us-ascii?Q?LHmf+H/BSLqv81Hipr9IlPOkxABN/U/b/jyQkBaZnj3Clq0Q9b6gIyqIxk0Q?=
 =?us-ascii?Q?t4RCrOkrfbYeSzeIdHD/UKjnryT1PiGrz8XycKlBFneA/E2H7+9do17G8iCL?=
 =?us-ascii?Q?rZGntPaW1ReHWk1FUZqqHcz9EKJW+364rfTq7m+kANe5TTuoi8yMOmDe5Bhk?=
 =?us-ascii?Q?fWSNK3SmvmnfI+Suls3m0GWTkdsIOYqj2GxEqV0d99siav96SBJ1N7VXC8pz?=
 =?us-ascii?Q?gatT5PkQ8hbr+fLJkv3/moK7GReIcZ6KQ9+cmEgAeKYR51bznQhdoM0DqzUS?=
 =?us-ascii?Q?MrKS7ixLIebyCsjTmdHbGdktMGid9waxi83TVv4qV1JZXTDPsyPzVTCmTsZN?=
 =?us-ascii?Q?eBonMK8nP+94cSI1/YpCs5Lmf0x6tcr9cIeZw0v8RrMhS7/Qu+RnWTc/jxif?=
 =?us-ascii?Q?jKqRQwMskMn4QgDzKuBF3FYHH8VQ9QElkVSzcB35xdlK+fjHfSVVWUK64GO5?=
 =?us-ascii?Q?/DMfIbp21GHVcmtjm9KCWOu+eAoRm87FQw6BZRcgrls+zV0bo+a0Meg/Tliz?=
 =?us-ascii?Q?xBj+Daw4HgGaICwwxFyv9uz1ljCErHPpZBChDWSJPJ/9Pf/tyU+VdYV/R6Zy?=
 =?us-ascii?Q?1ssBiJhKMDoie6z65Y1ehk00UTXL3rcQShE7OJA7xytJ9VI7TFkSBZdtW7BG?=
 =?us-ascii?Q?AprMQtN2KEbLVv3nk1XCuyoYm8zCa/T1HNm+6kGY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c183c4-402d-4b83-1457-08dd66abe9d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 06:04:30.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzOf3YeeN5Ht6E/v41c5MmMimUQt/2G4ulMHxRPjdBZ7RElKImZ2U0oseFX13oMyF/KMKrr5zqhTfXaVREZnEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6046
X-OriginatorOrg: intel.com

On Wed, Mar 19, 2025 at 01:06:35PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   81e4f8d68c66da301bb881862735bd74c6241a19
> commit: b5db73fb18257cd5d9cb59bc4b779fffa629566a riscv: enable HAVE_ARCH_STACKLEAK
> date:   8 months ago
> config: riscv-randconfig-r064-20250319 (https://download.01.org/0day-ci/archive/20250319/202503191250.ZHqkeLVs-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191250.ZHqkeLVs-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503191250.ZHqkeLVs-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Sorry, kindly ignore this report, which should be the environment issue in the bot.

Thanks

> 
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>    scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>    cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so: ./scripts/gcc-plugins/structleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>    cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
> >> cc1: error: cannot load plugin ./scripts/gcc-plugins/stackleak_plugin.so: ./scripts/gcc-plugins/stackleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>    cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>    cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so: ./scripts/gcc-plugins/structleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>    make[3]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Error 1
>    cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
> >> cc1: error: cannot load plugin ./scripts/gcc-plugins/stackleak_plugin.so: ./scripts/gcc-plugins/stackleak_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>    cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so: ./scripts/gcc-plugins/latent_entropy_plugin.so: undefined symbol: _ZN8opt_pass14set_pass_paramEjb
>    make[3]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
>    make[3]: Target 'scripts/mod/' not remade because of errors.
>    make[2]: *** [Makefile:1207: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:240: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:240: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

