Return-Path: <linux-kernel+bounces-369180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A164A9A1A04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87961C236A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEAB669;
	Thu, 17 Oct 2024 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMFBk1Tr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E715EFA1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 04:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140494; cv=fail; b=kSEwYztJV6REJY+hp0dPgjU5N7QuCUe2+tPh0NXtf7T6M2jb6jonznml686+1B674+ewNxXW3azoKkBTkES3Gv1Jy3jp7hQdJSYleNi1I7oW4Zrm0Bv5KT28JLKkEeJj0yGFJ24BC6HzKARrSjqKRSdFfEWFO7b+W8ZrHkmBWls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140494; c=relaxed/simple;
	bh=M8pMwSr4eSKpxNotIO9xf+qBmZCYEMlgbpUX7c5jamE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NpiqKvkp2RggpjxY3RrX0MJkcFop23eBdKpJJ03GLpstfcfX7vFZOsi4uYnuIHbNZ27Sh07/5/f6kZcTS+9HR8vezB0S0fvTVKbrKHLmmEqAunep2XnBCsVf4FS3v3JMbZWXWMlvI49bpoGnHS90Mbg+XW/Yk/zUKBX2/x9U7go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMFBk1Tr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729140491; x=1760676491;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M8pMwSr4eSKpxNotIO9xf+qBmZCYEMlgbpUX7c5jamE=;
  b=mMFBk1Trvoe4nESfX5RVKbHublPNBrCOP6KiYA4uYnYdKJrd20cgPRWe
   Qm5wez/MyR1mpKkkU8/1Z37o7i9xA+5U5ierW2kE1D6b0sXVeCGpJbloE
   0fhlUwQnPwvzILo/oV1vZS6anP7uGiwL3gFgnShfrqiN7PVhZkOSIOuhW
   +HDs6yO7VpFt/qglB5vHwMxBVyvWU9Q0WHDBmovev1lMT4XDpM79IwQK8
   QTzQ8HkAtGl8D7N5SNxQs8jktkMZdVo3dBU8N1KRX9sG4k4saq2GzBrZr
   D2rkeCVhQ6/vJnVqg2gtLSstWdKRR1X6Ufh8KqBHZtpxbme+BrhWqLf0L
   w==;
X-CSE-ConnectionGUID: BFXEMtofSpeHuRaX/PeL+w==
X-CSE-MsgGUID: fqrFQkmuSGu+LlnN9DaauQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31478653"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="31478653"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 21:48:10 -0700
X-CSE-ConnectionGUID: ZkLYuK5zRGmRDh5Up2Yusw==
X-CSE-MsgGUID: BcM6V9CDRuKGW/e62/nTcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="82388654"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 21:48:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 21:48:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 21:48:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 21:48:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 21:48:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 21:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOlj0DWHTw18g1HVoZcla7ZEoR6dTNmn6pWx0QPOieuF7dP8+x9xwOSzQGU6ZOweD4RZ2/Vg2muJTMFoCDVqTBN0ue6rjt05+m8hCXz66vSJA4Mc1Uj+t0PP90pfF+H93SIhmrkPmn1XCxijywrHWwSx5KadrTw7ohDeI7vTVPtc6ayEXQpNmPTlY6AXLWZ2e6bQpzL/W6jUTTeqBI8INQO/BpuTBMYoSDkG3lC9aBfRbyUiSMbH7LNOi74wpuzFh/8ROmUDA5cOxqCG8240bE5HVNoxusQjJiemo7d7vWDID2Oy3gRtSy7VZzgjQhrm/HUGHab/ENZ00TDB4lKwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKmDh93IBWf/WZuqccOj8CLbkUpaZ+aVd8Tk2TZ7Xq4=;
 b=c96U3B2YO9xcd/n6yWDiIWDGS/lp2NJKFyBvj07L+tVwZijIlxWCemFuPbM6wW/KUlIQx+U74gbqb6qk0trfC8/Z8MJyAMk+IextnoVeBTrVfv7M6ukOd0k2rAUzHjprCpkdSIfppGLTiVGCLVR0Hkx0lJt0jcJW8yLQefpQzNeXqk4tWAS88WgtR8aViV4jKFG4MgiwTe5bCgF88qJTxRFeHT5FjmxLegPSUyPKcGkk8V/HZWRiQ1PSQisQnkL6GTKWek+MCKw7c+9ZyjBCfVlGqzEw7NDd1wpHXcFHYvTYbgw1sMWQbN/fmDEGDwyl4hrImYQ6PvFzz+fIU/ebJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 04:48:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 04:48:04 +0000
Date: Thu, 17 Oct 2024 12:47:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xavier <xavier_qy@163.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, Xavier <xavier_qy@163.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] sched/eevdf: Reduce the computation frequency of
 avg_vruntime
Message-ID: <202410171258.5873933a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011062449.998696-1-xavier_qy@163.com>
X-ClientProxiedBy: KU1PR03CA0041.apcprd03.prod.outlook.com
 (2603:1096:802:19::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 1636f0ab-bb0e-4225-c958-08dcee66e289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?M/0yDAHoSEhi3CCfIB2TbOrK4QT/ku4jBCv52kROpSj6fFgLQy+sCTcdH9?=
 =?iso-8859-1?Q?+lr+8T161ktxhx0/xSi0hIJ9Ce3YMwPcEtlTKXGTXZosLLRBbfWrTD1Tbq?=
 =?iso-8859-1?Q?TlU/nSgBg3YWPSomp7K+0bpnx8pyTc1T1p+VgpMVnNm3gIzQqeiUhPNo+s?=
 =?iso-8859-1?Q?ry5aSais9qdsHeyJw77DlrvPU+QQGkgPOesvw0+Pc9p9taQSvD7YfeYKYB?=
 =?iso-8859-1?Q?mymGi6PJ4aMeLb5RqKdoyzK2fIXbjUEPKvyEXclVz9CVrfCYbE+9lBRu+E?=
 =?iso-8859-1?Q?u/c4SYjZ0ntZiub1OdIUiPH8ePy9tzwWlspPZBpfYULRLtAYv/Hf8TQJ2d?=
 =?iso-8859-1?Q?eZ0el4Hru8MZLfV39zxzs9K9SfOrfLKmOgvsHON7ixlHABcBMIdXTJcioD?=
 =?iso-8859-1?Q?wRqxfQurmT6YDKV7THO1g9llTtcJMmzPIeyY4PSRwuIcBQjAKw7rfn+jVN?=
 =?iso-8859-1?Q?jMCR3NSu3jGfPu15pqzaRVLEN+mc6T6K1bnbojDnOVjwp7cszyXUbbpaRq?=
 =?iso-8859-1?Q?svW+kxA4iZQ7MjCJoJKIAIzjSFfbexkf/ilozqOnYdhux9QfmPhWy6+sD0?=
 =?iso-8859-1?Q?zVCj6K56P5KMJqLa90Dhph6Ie6G9joi35ZkWpzlNFTbAzFtaP9aMaFhIqW?=
 =?iso-8859-1?Q?B/1FrorSPUnDtAyrFpNn76PSeJombzEmd5yS9hXn89WF/ySjk4sYRB9nt9?=
 =?iso-8859-1?Q?AvAE9HJUrV0/pIaA8m0oMD1jsmaUut3sd0QY6ZPd43TaGoGPXonXeg41zr?=
 =?iso-8859-1?Q?kwCFZajz+R6b81PQHC2pQYh94L1GlZ2IOLO/4s/KCULFGTFxAE2b4t0tWd?=
 =?iso-8859-1?Q?a6SQYD55W19L7Y7IngOYjafhGA4Bcw7YUXxb0mO5krp7ZseXEW5CS1WoFh?=
 =?iso-8859-1?Q?ZoINOzJw/VmbJ08aysc/27Mqb5ywC8/1hutC0FaGp4rBM/8wI4Q3A+Cg0R?=
 =?iso-8859-1?Q?cLDqatBYZl5lhD8YX8IKcH61jyLVijq16vkukju7bSalVWgyiUkoEoa9Bt?=
 =?iso-8859-1?Q?0NmxpwOoBgHNT2H5dJkFTIowZuKrc4WrHQZgu+HRL7YpOegCuKbq5Uxpm5?=
 =?iso-8859-1?Q?7OonnribAglkYxBRjfr5G12Y+j0Lbeg1P+tCepa0Ow4PSxIwSgnQZhOgcO?=
 =?iso-8859-1?Q?bp8YfZcvzVXc9MbAhEtC0uU9a6ViKx3dZkxGWPAahYaaF47zHciSR1Q0n8?=
 =?iso-8859-1?Q?3CxvwV63VttVjv/UWDzmiP/kxx23j13WFnsnjfuL7/FX4Wiyeurf19PAeh?=
 =?iso-8859-1?Q?Bf/OQEXtB4KlpEFlwxr994R2sMmBZtN8DxjhtQnVzCHHOJ3HWuO3Ja/vmm?=
 =?iso-8859-1?Q?8cueIkC/4v78KUzjUuR8p849UA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?W1eSxeIuTVvWxFuxYYdSwBYIRopBDnnWkWM7jOo9VkL2Y+2yYpNhNybWRP?=
 =?iso-8859-1?Q?hPAfHGt/ppZ8QIpkYa8wTxUllit052GGWUMoZceEVjdimPGHRqTfSsMbRf?=
 =?iso-8859-1?Q?kh5m+OXuQU8B6Eo1YVUkZNeKs0JFUgrWePqvLrCUP6V+D3qxh15cCS9pLf?=
 =?iso-8859-1?Q?jlYBcqEGN898kFXjSbjPj/9EEodo4LeRZAsHoAD8LOoMOOtOSwUq3ErulJ?=
 =?iso-8859-1?Q?qOiflOBDC84dNMyttADsS+UynClHo3RsUcc6N2sUluyR1qJi4h22arrepT?=
 =?iso-8859-1?Q?KadDaIWjYW5/KYqIozaql1PKdwy9rX4tM1USkw7fQSzfs5BFf3d/D9/+8s?=
 =?iso-8859-1?Q?zYFvxmGvgm4ko8yQNUNILdBROpIXeQ78vp6SNm6skexo4aKPBvQqoxSCTj?=
 =?iso-8859-1?Q?cC7LzQ1vMrSFKNAr1maQ/eQxn14NizjhuaD8lN4ILd4GpTrr/IdwQnTv/S?=
 =?iso-8859-1?Q?eKof7IUEZZaBqyVvj08V9MsPGI+5MIfh5dJ0gzsEz6DLoTY6Lgn/z936/c?=
 =?iso-8859-1?Q?eeHGTB6zQd+bi5x5+rVmk3q/DSC0I6KfsGphQpsAbyZ31Ms5sHu5UNx1M2?=
 =?iso-8859-1?Q?Z7m2Nl3NH81sVN4CIzwpzcPh5vzy5GuS5Cav+uVu0Ln98twSTC0CDbqWe3?=
 =?iso-8859-1?Q?q1tY0YrriZ8bOCdeeAwGokPAEj9tkQYdes6JDnNy790I2pz335r7mI6bWQ?=
 =?iso-8859-1?Q?WWXM7IqmlnTiIlZdRurrimY+FPtJXYZuugIBd9l+9xx65dJ5N2/b8Rf0tj?=
 =?iso-8859-1?Q?piqsQz8aqtM4jbVApNlDp1AMbo1sEFE0Pv5ySpksYeAGmrSnFrFDTzw4+f?=
 =?iso-8859-1?Q?RoQ0SAFevAJjwkOEjlnFUq3Tzodxa8Nv/oD+/VjYnBOY5He6H377BJBN6O?=
 =?iso-8859-1?Q?CmQU0wrzwIp9cWJoSWo9GW3P8OvvptOeATOpZFYxVF+kPIrx2UjjZKwEyE?=
 =?iso-8859-1?Q?mSlXUUBnDu/FATiNSb1Atk4kSHckGb2HkoG9q1vbycPHBSX3QK3vXMGZ1Z?=
 =?iso-8859-1?Q?SqtGuEHfaPvp/EuKjkcDAYUC0yiLcqCh95E4MRNyvA7GZXvPQfvizTtP1h?=
 =?iso-8859-1?Q?4pblE5vMhsA1bkI3+XKBuaHLUwRDTjnN6CfVeUkQJlHPu+Y28ti4xPHLEf?=
 =?iso-8859-1?Q?DE+UhLDUyErQ+46/RlzjtJMk+VD4BYO60Br2V9fWD6B8DW5A53+PHd7ByD?=
 =?iso-8859-1?Q?empY/I7VL7GZoTf97KC9a7jhVOAkdCJ2tzZ2kQN+bq/5AM0lF2zjUtX9J9?=
 =?iso-8859-1?Q?eK1xJYW35YgNGuZgJb2b+VIf/0bPJ//6XLtIjM3MmB0SEPWgDNhTfDT6fe?=
 =?iso-8859-1?Q?tUIVjIXV+CMeOSBxPeatIh/wxo6QfIGzB3oDiYTWiNCKUL+B5mV2T7G8Wb?=
 =?iso-8859-1?Q?uGJbWCFMwrmQxpfuYu3nezJ+XEFFICvL6Co3HF8QuleVLvrRwT+/YkobzW?=
 =?iso-8859-1?Q?2kBfnDLh2DKK8+aPU5gZZMNaYOdivoZnErbdZIokM9a+TYQ9JIQQgGwJSy?=
 =?iso-8859-1?Q?OfDP9KGB5R2Mke7a5IezM8AwD9yw5mTqOqAVBRWjbi3n0p0fUS0yhVWNpo?=
 =?iso-8859-1?Q?Fy6RP0kaN4uRMDkUP5bkRHzAaEcTwRbtaVns7ezf6HPOY8deW/3sgLA0vB?=
 =?iso-8859-1?Q?B0ntyodZ8Q7vujV9eqtZ4Qb1AdgESHy8wCsiGPq18qCHA16d1wxeI1kg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1636f0ab-bb0e-4225-c958-08dcee66e289
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 04:48:04.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5Wesz8pjTI0aiQnuDbToCpJ7GClkI4To2BQPek4afCQG+e2YxGFxrNx4fQ0O4JIFysR5eF52bNzTHqSGKbCGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -13.0% regression of will-it-scale.per_thread_ops on:


commit: 538d813df3945cbc9d6a90ba224f36c78c8bb128 ("[PATCH v2] sched/eevdf: Reduce the computation frequency of avg_vruntime")
url: https://github.com/intel-lab-lkp/linux/commits/Xavier/sched-eevdf-Reduce-the-computation-frequency-of-avg_vruntime/20241011-142820
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 7266f0a6d3bb73f42ea06656d3cc48c7d0386f71
patch link: https://lore.kernel.org/all/20241011062449.998696-1-xavier_qy@163.com/
patch subject: [PATCH v2] sched/eevdf: Reduce the computation frequency of avg_vruntime

testcase: will-it-scale
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: sched_yield
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min -16.4% regression                                                  |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                               |
|                  | disk=1BRD_48G                                                                              |
|                  | fs=xfs                                                                                     |
|                  | load=3000                                                                                  |
|                  | test=disk_rr                                                                               |
+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops -4.1% regression                               |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                           |
| test parameters  | cpufreq_governor=performance                                                               |
|                  | mode=thread                                                                                |
|                  | nr_task=100%                                                                               |
|                  | test=sched_yield                                                                           |
+------------------+--------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410171258.5873933a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241017/202410171258.5873933a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/sched_yield/will-it-scale

commit: 
  7266f0a6d3 ("fs/bcachefs: Fix __wait_on_freeing_inode() definition of waitqueue entry")
  538d813df3 ("sched/eevdf: Reduce the computation frequency of avg_vruntime")

7266f0a6d3bb73f4 538d813df3945cbc9d6a90ba224 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10.51            -1.4        9.07        mpstat.cpu.all.usr%
     77573 ±  7%     +42.8%     110799 ± 31%  sched_debug.cpu.avg_idle.stddev
 5.853e+08           -13.0%  5.092e+08        will-it-scale.224.threads
   2612822           -13.0%    2273147        will-it-scale.per_thread_ops
 5.853e+08           -13.0%  5.092e+08        will-it-scale.workload
      0.02 ± 46%     -44.2%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.37 ±190%     -95.5%       0.11 ± 19%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.10 ± 47%    +107.4%       2.29 ± 45%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     25.62 ±203%    +590.0%     176.73 ± 90%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
 1.692e+11           -10.9%  1.509e+11        perf-stat.i.branch-instructions
 1.759e+08           -10.1%  1.582e+08        perf-stat.i.branch-misses
      1.13           +10.3%       1.24 ±  2%  perf-stat.i.cpi
 6.786e+11            -9.2%  6.164e+11        perf-stat.i.instructions
      0.90            -9.3%       0.82        perf-stat.i.ipc
      1.11           +10.4%       1.22        perf-stat.overall.cpi
      0.90            -9.4%       0.82        perf-stat.overall.ipc
    350712            +4.5%     366647        perf-stat.overall.path-length
 1.686e+11           -10.9%  1.502e+11        perf-stat.ps.branch-instructions
 1.754e+08           -10.0%  1.579e+08 ±  2%  perf-stat.ps.branch-misses
 6.761e+11            -9.2%   6.14e+11        perf-stat.ps.instructions
 2.053e+14            -9.1%  1.867e+14        perf-stat.total.instructions
      3.82            -2.2        1.60 ±  2%  perf-profile.calltrace.cycles-pp.pick_eevdf.pick_task_fair.pick_next_task_fair.__schedule.schedule
     13.75            -1.6       12.18        perf-profile.calltrace.cycles-pp.clear_bhb_loop.__sched_yield
     10.86            -1.3        9.52        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
      7.48            -1.0        6.45        perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.32 ± 22%      -0.7        0.60 ± 10%  perf-profile.calltrace.cycles-pp.testcase
      5.09            -0.5        4.54        perf-profile.calltrace.cycles-pp.update_rq_clock.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      2.22 ±  7%      -0.5        1.69 ± 14%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.pick_task_fair.pick_next_task_fair.__schedule
      3.74            -0.5        3.23        perf-profile.calltrace.cycles-pp.update_rq_clock_task.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      4.00            -0.4        3.56        perf-profile.calltrace.cycles-pp.sched_clock_cpu.update_rq_clock.__schedule.schedule.__x64_sys_sched_yield
      3.50            -0.4        3.13        perf-profile.calltrace.cycles-pp.sched_clock.sched_clock_cpu.update_rq_clock.__schedule.schedule
      3.31            -0.4        2.95        perf-profile.calltrace.cycles-pp.native_sched_clock.sched_clock.sched_clock_cpu.update_rq_clock.__schedule
      2.78            -0.4        2.43        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.12            -0.3        1.82        perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.14            -0.3        1.85        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__sched_yield
      1.85            -0.3        1.58        perf-profile.calltrace.cycles-pp.update_curr_se.update_curr.pick_task_fair.pick_next_task_fair.__schedule
      2.04            -0.3        1.78        perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      2.02            -0.3        1.76        perf-profile.calltrace.cycles-pp._raw_spin_lock.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      2.12            -0.3        1.86        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.13            -0.1        0.98        perf-profile.calltrace.cycles-pp.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95 ±  4%      -0.1        0.82 ±  6%  perf-profile.calltrace.cycles-pp.rcu_note_context_switch.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      1.07            -0.1        0.96        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.77            -0.1        0.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__sched_yield
      1.66            -0.1        1.57        perf-profile.calltrace.cycles-pp.__calc_delta.update_curr.pick_task_fair.pick_next_task_fair.__schedule
     98.53            +0.3       98.82        perf-profile.calltrace.cycles-pp.__sched_yield
     69.38            +3.8       73.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
     67.49            +4.0       71.53        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      2.87            +5.0        7.91        perf-profile.calltrace.cycles-pp.update_min_vruntime.update_curr.pick_task_fair.pick_next_task_fair.__schedule
     58.92            +5.1       64.03        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     51.95            +6.0       57.99        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     50.08            +6.3       56.34        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.18            +8.4       40.56        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     30.20            +8.5       38.74        perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
     22.44           +11.5       33.93        perf-profile.calltrace.cycles-pp.update_curr.pick_task_fair.pick_next_task_fair.__schedule.schedule
      4.00            -2.3        1.65 ±  2%  perf-profile.children.cycles-pp.pick_eevdf
     13.84            -1.6       12.26        perf-profile.children.cycles-pp.clear_bhb_loop
      6.99            -0.9        6.05        perf-profile.children.cycles-pp.do_sched_yield
      6.97            -0.9        6.10        perf-profile.children.cycles-pp.entry_SYSCALL_64
      5.18            -0.6        4.62        perf-profile.children.cycles-pp.update_rq_clock
      4.22            -0.5        3.68        perf-profile.children.cycles-pp._raw_spin_lock
      2.27 ±  6%      -0.5        1.76 ± 13%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      3.77            -0.5        3.26        perf-profile.children.cycles-pp.update_rq_clock_task
      4.04            -0.5        3.56        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.18            -0.5        3.72        perf-profile.children.cycles-pp.sched_clock_cpu
      3.77            -0.4        3.36        perf-profile.children.cycles-pp.sched_clock
      2.92            -0.4        2.55        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.36            -0.4        3.00        perf-profile.children.cycles-pp.native_sched_clock
      2.38            -0.3        2.08        perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      2.26            -0.3        1.96        perf-profile.children.cycles-pp.syscall_return_via_sysret
      2.03            -0.3        1.74        perf-profile.children.cycles-pp.update_curr_se
      2.29            -0.3        2.01        perf-profile.children.cycles-pp.x64_sys_call
      0.97 ±  8%      -0.3        0.70 ± 10%  perf-profile.children.cycles-pp.testcase
      1.15            -0.1        1.00        perf-profile.children.cycles-pp.yield_task_fair
      1.01 ±  4%      -0.1        0.87 ±  5%  perf-profile.children.cycles-pp.rcu_note_context_switch
      1.16            -0.1        1.03        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.80            -0.1        0.68        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      1.69            -0.1        1.60        perf-profile.children.cycles-pp.__calc_delta
      0.50 ±  2%      -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.raw_spin_rq_unlock
      0.47 ±  3%      -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.sched_update_worker
      0.31 ±  3%      -0.0        0.27 ±  5%  perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.sched_clock_noinstr
     99.24            +0.1       99.32        perf-profile.children.cycles-pp.__sched_yield
     69.66            +3.7       73.41        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     67.81            +4.0       71.82        perf-profile.children.cycles-pp.do_syscall_64
     59.71            +5.0       64.72        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      2.92            +5.0        7.94        perf-profile.children.cycles-pp.update_min_vruntime
     51.97            +6.0       58.01        perf-profile.children.cycles-pp.schedule
     50.53            +6.2       56.74        perf-profile.children.cycles-pp.__schedule
     32.38            +8.4       40.74        perf-profile.children.cycles-pp.pick_next_task_fair
     30.70            +8.4       39.14        perf-profile.children.cycles-pp.pick_task_fair
     23.52           +11.0       34.54        perf-profile.children.cycles-pp.update_curr
      3.60            -2.2        1.36 ±  3%  perf-profile.self.cycles-pp.pick_eevdf
     13.76            -1.6       12.18        perf-profile.self.cycles-pp.clear_bhb_loop
      5.71            -0.8        4.90        perf-profile.self.cycles-pp.__sched_yield
      6.12            -0.7        5.40        perf-profile.self.cycles-pp.__schedule
      3.95            -0.6        3.40        perf-profile.self.cycles-pp._raw_spin_lock
      2.20 ±  6%      -0.5        1.70 ± 14%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      3.56            -0.5        3.07        perf-profile.self.cycles-pp.update_rq_clock_task
      3.92            -0.5        3.44        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.07            -0.4        2.67        perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.96            -0.4        2.59        perf-profile.self.cycles-pp.do_syscall_64
      3.28            -0.4        2.92        perf-profile.self.cycles-pp.native_sched_clock
      2.41            -0.3        2.09        perf-profile.self.cycles-pp.do_sched_yield
      3.59            -0.3        3.28        perf-profile.self.cycles-pp.pick_task_fair
      2.25            -0.3        1.96        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.87            -0.3        1.61        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.18            -0.3        1.92        perf-profile.self.cycles-pp.x64_sys_call
      1.85            -0.3        1.59        perf-profile.self.cycles-pp.update_curr_se
      1.73            -0.2        1.48        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.44 ±  3%      -0.2        1.26        perf-profile.self.cycles-pp.schedule
      1.02            -0.2        0.86        perf-profile.self.cycles-pp.yield_task_fair
      0.92 ±  4%      -0.1        0.79 ±  5%  perf-profile.self.cycles-pp.rcu_note_context_switch
      0.79            -0.1        0.68        perf-profile.self.cycles-pp.__x64_sys_sched_yield
      0.79            -0.1        0.68        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      1.04            -0.1        0.94        perf-profile.self.cycles-pp.update_rq_clock
      1.04            -0.1        0.93        perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      1.65 ±  2%      -0.1        1.56 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      1.64            -0.1        1.56        perf-profile.self.cycles-pp.__calc_delta
      0.41 ±  5%      -0.1        0.33 ±  5%  perf-profile.self.cycles-pp.testcase
      0.43            -0.1        0.36        perf-profile.self.cycles-pp.raw_spin_rq_unlock
      0.46 ±  3%      -0.1        0.40 ±  2%  perf-profile.self.cycles-pp.sched_update_worker
      0.48            -0.0        0.43        perf-profile.self.cycles-pp.sched_clock_cpu
      0.29            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.arch_scale_cpu_capacity
      0.26            -0.0        0.23        perf-profile.self.cycles-pp.sched_clock
      2.58            +5.3        7.92        perf-profile.self.cycles-pp.update_min_vruntime
      8.36 ±  5%      +7.1       15.45 ±  2%  perf-profile.self.cycles-pp.update_curr


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/xfs/x86_64-rhel-8.3/3000/debian-12-x86_64-20240206.cgz/lkp-icl-2sp2/disk_rr/aim7

commit: 
  7266f0a6d3 ("fs/bcachefs: Fix __wait_on_freeing_inode() definition of waitqueue entry")
  538d813df3 ("sched/eevdf: Reduce the computation frequency of avg_vruntime")

7266f0a6d3bb73f4 538d813df3945cbc9d6a90ba224 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.288e+09 ±  2%     +21.9%  4.008e+09 ±  3%  cpuidle..time
   2225204           +34.7%    2996318        cpuidle..usage
     65110           -10.0%      58593 ±  3%  vmstat.system.cs
    164997           -12.3%     144664 ±  3%  vmstat.system.in
     78.57            +5.4%      82.82        iostat.cpu.idle
     19.74           -20.7%      15.66 ±  3%  iostat.cpu.system
      1.68 ±  2%      -9.3%       1.52        iostat.cpu.user
      0.10 ±  2%      +0.0        0.11 ±  3%  mpstat.cpu.all.soft%
     20.61            -4.5       16.11 ±  3%  mpstat.cpu.all.sys%
      1.75 ±  2%      -0.2        1.55        mpstat.cpu.all.usr%
     38.50           -24.7%      29.00        mpstat.max_utilization_pct
     20.45 ± 35%     -40.8%      12.10 ± 66%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     93.27 ± 14%     -32.3%      63.15 ± 50%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     20.45 ± 35%     -40.8%      12.10 ± 66%  sched_debug.cfs_rq:/.removed.util_avg.avg
     93.27 ± 14%     -32.3%      63.15 ± 50%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    626563           -16.4%     524042        aim7.jobs-per-min
     28.92           +19.5%      34.54        aim7.time.elapsed_time
     28.92           +19.5%      34.54        aim7.time.elapsed_time.max
    106217 ±  2%     -54.4%      48479 ±  4%  aim7.time.involuntary_context_switches
      2520           -20.9%       1994        aim7.time.percent_of_cpu_this_job_got
    693.43            -6.0%     652.11        aim7.time.system_time
    454176            +7.3%     487213        aim7.time.voluntary_context_switches
     24117 ± 12%     +58.8%      38288 ±  9%  meminfo.Active
     19543 ± 14%     +81.6%      35485 ± 10%  meminfo.Active(anon)
      4574 ±  6%     -38.7%       2803 ± 13%  meminfo.Active(file)
    864807           +11.5%     964505        meminfo.Dirty
    866352           +11.8%     968424        meminfo.Inactive(file)
     81362 ±  3%     +24.8%     101538 ± 10%  meminfo.Mapped
     55814 ±  4%     +52.6%      85147 ±  9%  meminfo.Shmem
      2248 ±  9%     -36.3%       1432 ±  8%  numa-meminfo.node0.Active(file)
    435013           +12.2%     488255        numa-meminfo.node0.Dirty
    435838           +12.5%     490301 ±  2%  numa-meminfo.node0.Inactive(file)
     18186 ± 13%     +77.5%      32275 ±  8%  numa-meminfo.node1.Active
     15931 ± 15%     +94.2%      30941 ±  9%  numa-meminfo.node1.Active(anon)
      2254 ± 14%     -40.9%       1333 ± 19%  numa-meminfo.node1.Active(file)
    429153 ±  2%     +10.9%     475856 ±  3%  numa-meminfo.node1.Dirty
    429881 ±  2%     +11.1%     477485 ±  3%  numa-meminfo.node1.Inactive(file)
     48401 ±  5%     +57.8%      76356 ±  8%  numa-meminfo.node1.Shmem
    570.46 ±  4%     -33.5%     379.55 ± 18%  numa-vmstat.node0.nr_active_file
    108480           +13.4%     123017 ±  3%  numa-vmstat.node0.nr_dirty
    108626           +13.7%     123557 ±  3%  numa-vmstat.node0.nr_inactive_file
    574.96 ±  4%     -33.5%     382.41 ± 20%  numa-vmstat.node0.nr_zone_active_file
    108616           +13.8%     123563 ±  3%  numa-vmstat.node0.nr_zone_inactive_file
    108480           +13.4%     123031 ±  3%  numa-vmstat.node0.nr_zone_write_pending
      3992 ± 15%     +88.0%       7505 ± 12%  numa-vmstat.node1.nr_active_anon
    535.60 ±  8%     -43.4%     303.23 ± 20%  numa-vmstat.node1.nr_active_file
    106987 ±  2%     +12.1%     119954 ±  3%  numa-vmstat.node1.nr_dirty
    107155 ±  2%     +12.3%     120335 ±  2%  numa-vmstat.node1.nr_inactive_file
     12109 ±  5%     +55.3%      18803 ± 11%  numa-vmstat.node1.nr_shmem
      3992 ± 15%     +88.0%       7505 ± 12%  numa-vmstat.node1.nr_zone_active_anon
    531.79 ±  7%     -44.0%     297.86 ± 22%  numa-vmstat.node1.nr_zone_active_file
    107160 ±  2%     +12.3%     120329 ±  2%  numa-vmstat.node1.nr_zone_inactive_file
    106991 ±  2%     +12.1%     119949 ±  3%  numa-vmstat.node1.nr_zone_write_pending
      4894 ± 14%     +78.8%       8753 ±  8%  proc-vmstat.nr_active_anon
      1177 ±  7%     -47.3%     620.85 ± 11%  proc-vmstat.nr_active_file
    215885           +12.0%     241890        proc-vmstat.nr_dirty
   1028576            +3.3%    1062036        proc-vmstat.nr_file_pages
    205186            +2.5%     210328        proc-vmstat.nr_inactive_anon
    216249           +12.3%     242846        proc-vmstat.nr_inactive_file
     65985            +2.3%      67471        proc-vmstat.nr_kernel_stack
     20669 ±  3%     +23.9%      25606 ±  7%  proc-vmstat.nr_mapped
     13964 ±  4%     +53.1%      21372 ±  7%  proc-vmstat.nr_shmem
     34179            +2.8%      35137        proc-vmstat.nr_slab_reclaimable
     91842            +1.6%      93353        proc-vmstat.nr_slab_unreclaimable
      4894 ± 14%     +78.8%       8753 ±  8%  proc-vmstat.nr_zone_active_anon
      1177 ±  7%     -47.2%     621.97 ± 11%  proc-vmstat.nr_zone_active_file
    205186            +2.5%     210328        proc-vmstat.nr_zone_inactive_anon
    216249           +12.3%     242846        proc-vmstat.nr_zone_inactive_file
    215886           +12.0%     241890        proc-vmstat.nr_zone_write_pending
      1544 ±206%    +815.2%      14133 ± 47%  proc-vmstat.numa_hint_faults
     93.17 ± 76%   +9039.0%       8514 ± 63%  proc-vmstat.numa_pages_migrated
     33520 ± 95%    +238.4%     113448 ± 18%  proc-vmstat.numa_pte_updates
    401728           +27.3%     511275        proc-vmstat.pgfault
     93.17 ± 76%   +9039.0%       8514 ± 63%  proc-vmstat.pgmigrate_success
    213998           +21.9%     260928 ±  3%  proc-vmstat.pgpgout
     16275 ±  6%     +14.0%      18549 ±  5%  proc-vmstat.pgreuse
      1.32 ±  2%     +10.9%       1.46 ±  2%  perf-stat.i.MPKI
  1.66e+10 ±  2%     -15.6%  1.401e+10        perf-stat.i.branch-instructions
      1.82 ±  2%      -0.2        1.58 ±  4%  perf-stat.i.branch-miss-rate%
  63877077 ±  3%     -15.6%   53893091 ±  2%  perf-stat.i.branch-misses
     20.49            +1.8       22.29        perf-stat.i.cache-miss-rate%
 1.364e+08 ±  2%     -12.8%  1.189e+08        perf-stat.i.cache-misses
 5.295e+08 ±  2%     -15.6%  4.469e+08        perf-stat.i.cache-references
     70732 ±  2%     -10.9%      63025 ±  2%  perf-stat.i.context-switches
 6.905e+10 ±  2%     -18.9%  5.602e+10        perf-stat.i.cpu-cycles
      2264 ±  2%     -31.3%       1556 ±  3%  perf-stat.i.cpu-migrations
 7.571e+10 ±  2%     -15.7%  6.382e+10        perf-stat.i.instructions
     36.23 ± 23%     -50.3%      18.01 ± 50%  perf-stat.i.major-faults
     11250 ±  4%      +7.1%      12053 ±  3%  perf-stat.i.minor-faults
     11286 ±  4%      +7.0%      12071 ±  3%  perf-stat.i.page-faults
      1.81            +3.2%       1.86        perf-stat.overall.MPKI
     25.78            +0.8       26.62        perf-stat.overall.cache-miss-rate%
      0.91            -3.8%       0.88        perf-stat.overall.cpi
    505.72            -6.8%     471.32        perf-stat.overall.cycles-between-cache-misses
      1.09            +3.9%       1.14        perf-stat.overall.ipc
 1.574e+10 ±  2%     -13.9%  1.355e+10 ±  2%  perf-stat.ps.branch-instructions
  59346827 ±  3%     -12.8%   51745536        perf-stat.ps.branch-misses
 1.296e+08 ±  3%     -11.2%  1.151e+08 ±  2%  perf-stat.ps.cache-misses
 5.028e+08 ±  3%     -14.0%  4.324e+08        perf-stat.ps.cache-references
     67073 ±  3%      -9.1%      60976 ±  2%  perf-stat.ps.context-switches
 6.555e+10 ±  2%     -17.2%  5.425e+10 ±  2%  perf-stat.ps.cpu-cycles
      2163 ±  2%     -29.4%       1527 ±  2%  perf-stat.ps.cpu-migrations
 7.176e+10 ±  2%     -14.0%  6.172e+10 ±  2%  perf-stat.ps.instructions
     10680 ±  4%     +11.3%      11882 ±  2%  perf-stat.ps.minor-faults
     10719 ±  4%     +11.1%      11907 ±  2%  perf-stat.ps.page-faults
      0.01 ± 30%    +511.8%       0.05 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%   +1575.0%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00 ±145%   +1020.0%       0.01 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00 ±223%   +1133.3%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.00 ± 17%     +69.6%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±145%   +1180.0%       0.01 ± 73%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.01 ± 33%     -70.8%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±  9%     -45.5%       0.00 ± 72%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ± 10%     +32.1%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 15%     +91.4%       0.01 ± 43%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±  8%    +100.0%       0.01 ± 37%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ± 11%     +38.5%       0.01        perf-sched.sch_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.00 ±142%    +369.2%       0.01 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.shrink_dentry_list.shrink_dcache_parent.d_invalidate
      0.73 ± 99%    +286.5%       2.84 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%   +2900.0%       0.02 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00 ±145%   +1640.0%       0.01 ± 40%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.00 ±143%    +350.0%       0.01 ±  7%  perf-sched.sch_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00 ±223%   +1750.0%       0.02 ±  5%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ± 88%    -100.0%       0.00        perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.__x64_sys_nanosleep.do_syscall_64
      0.01 ± 11%   +2974.3%       0.36 ± 40%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 11%    +100.0%       0.01 ± 14%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±145%   +1480.0%       0.01 ± 65%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      0.01 ± 18%   +5433.3%       0.58 ±133%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 10%    +516.3%       0.05 ± 88%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 16%    +708.9%       0.06 ±144%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ± 21%  +43222.4%       4.19 ±127%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.04 ±102%  +79610.1%      30.29 ±221%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±  8%    +378.5%       0.05 ± 13%  perf-sched.total_sch_delay.average.ms
      4.82 ± 31%   +3815.7%     188.77 ±  2%  perf-sched.total_sch_delay.max.ms
      2004 ± 24%  +11113.1%     224730        perf-sched.total_wait_and_delay.count.ms
      1367 ± 41%    +246.4%       4735 ±  3%  perf-sched.total_wait_and_delay.max.ms
      1367 ± 41%    +246.4%       4735 ±  3%  perf-sched.total_wait_time.max.ms
      3.25 ± 53%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    166.61 ±141%    +349.9%     749.60 ± 10%  perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    111.12 ±141%    +570.0%     744.49 ± 10%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.29 ±  4%    +457.1%       1.64 ± 14%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     77.78 ±106%    +198.6%     232.23 ±  3%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    130.49 ± 36%    +216.7%     413.24 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.47 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    252.00 ± 50%     +80.0%     453.54        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     19.90 ± 18%     -79.4%       4.10        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     48.98          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
    239.32 ± 81%     -97.8%       5.28 ±  9%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    586.67 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.33 ±141%    +650.0%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.00 ±141%    +416.7%       5.17 ±  7%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     31.17 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.__x64_sys_exit.x64_sys_call.do_syscall_64
     66.17 ± 14%   +4026.4%       2730 ± 19%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     51.67 ± 21%   +4399.7%       2324 ± 18%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3.00 ±107%    +522.2%      18.67 ±  5%  perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    169.50 ± 22%   +1190.6%       2187 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.83 ±102%   +3339.1%     131.83 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     31.50 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.67 ± 58%    +328.6%      20.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
     64.17 ± 37%   +1794.8%       1215        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     27.50 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.xfsaild.kthread.ret_from_fork
    647.50 ± 30%    +380.3%       3109 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.00 ±223%  +1.8e+05%       1760        perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    217.17 ± 32%  +26170.7%      57051        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1249 ± 51%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.30 ± 17%  +28306.6%     368.62 ± 31%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    283.33 ±104%    +246.8%     982.65 ±  3%  perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    336.68 ±140%    +957.4%       3559 ± 50%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    333.67 ±141%   +1049.9%       3837 ± 38%  perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.91          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    329.52 ± 29%     -82.1%      59.00 ±104%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     52.00          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
    975.69 ± 20%    +150.2%       2440 ±  3%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    154.83 ±223%    +458.4%     864.51 ± 35%  perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1312 ± 47%    +222.7%       4234 ±  8%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.44 ±223%  +25614.4%     112.42 ± 18%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00 ±223%  +1.7e+06%      54.23 ±119%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
    166.61 ±141%    +349.9%     749.60 ± 10%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    111.12 ±141%    +570.0%     744.48 ± 10%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.29 ±  4%    +467.6%       1.63 ± 14%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     94.46 ± 72%    +145.9%     232.23 ±  3%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ±144%  +2.2e+06%     127.86 ±  6%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.00 ±223%   +4333.3%       0.02 ± 27%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    130.47 ± 36%    +216.7%     413.23 ±  7%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.46 ±  5%     +53.4%       0.71        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    252.00 ± 50%     +80.0%     453.53        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     19.89 ± 18%     -79.5%       4.09        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    239.29 ± 81%     -97.8%       5.25 ±  9%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.44 ±223%  +39762.2%     174.26 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00 ±223%  +2.8e+06%      88.88 ± 99%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      1.29 ± 17%  +28522.9%     368.61 ± 31%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    349.88 ± 67%    +180.9%     982.64 ±  3%  perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±191%  +1.1e+06%     187.74        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.00 ±223%   +6166.7%       0.03 ± 47%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    336.67 ±140%    +957.4%       3559 ± 50%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.66 ± 10%     -42.8%       2.66 ± 70%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    333.67 ±141%   +1049.9%       3836 ± 38%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1.91           +40.7%       2.69 ±  2%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    329.51 ± 29%     -82.6%      57.33 ±109%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    975.68 ± 20%    +150.2%       2440 ±  3%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    154.84 ±223%    +458.3%     864.50 ± 35%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1312 ± 47%    +222.7%       4233 ±  8%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.94            -1.8        6.10 ±  3%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      7.94            -1.8        6.10 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
      9.08            -1.8        7.25 ±  3%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      9.20            -1.8        7.36 ±  3%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      9.16            -1.8        7.33 ±  3%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      9.16            -1.8        7.33 ±  3%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.20            -1.8        7.37 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      9.26            -1.8        7.44 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      9.26            -1.8        7.44 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      9.28            -1.8        7.46 ±  3%  perf-profile.calltrace.cycles-pp.creat64
      7.29            -1.8        5.51 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
      8.80            -1.6        7.17 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      8.80            -1.6        7.17 ±  3%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      8.86            -1.6        7.24 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      8.86            -1.6        7.24 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      8.89            -1.6        7.27 ±  3%  perf-profile.calltrace.cycles-pp.unlink
      7.94            -1.6        6.33 ±  3%  perf-profile.calltrace.cycles-pp.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.94            -1.6        6.32 ±  3%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      6.42            -1.6        4.85 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      7.28            -1.5        5.74 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink
      6.46            -1.4        5.09 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.85            -0.2        0.65        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.79            -0.2        0.63        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat
      1.75            -0.2        1.60 ±  4%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.78            -0.2        1.63 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.78            -0.1        1.64 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.78            -0.1        1.64 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      1.31            -0.1        1.23        perf-profile.calltrace.cycles-pp.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread.kthread
      1.33            -0.1        1.25        perf-profile.calltrace.cycles-pp.xfs_inodegc_worker.process_one_work.worker_thread.kthread.ret_from_fork
      0.96            -0.1        0.88        perf-profile.calltrace.cycles-pp.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work.worker_thread
      0.69            -0.1        0.63        perf-profile.calltrace.cycles-pp.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker.process_one_work
      0.65            -0.1        0.60        perf-profile.calltrace.cycles-pp.xfs_difree.xfs_inode_uninit.xfs_ifree.xfs_inactive_ifree.xfs_inactive
      0.68            -0.1        0.62        perf-profile.calltrace.cycles-pp.xfs_inode_uninit.xfs_ifree.xfs_inactive_ifree.xfs_inactive.xfs_inodegc_worker
      0.70            +0.0        0.72        perf-profile.calltrace.cycles-pp.xfs_ilock.xfs_file_buffered_read.xfs_file_read_iter.vfs_read.ksys_read
      0.51            +0.0        0.53        perf-profile.calltrace.cycles-pp.down_read.xfs_ilock.xfs_file_buffered_read.xfs_file_read_iter.vfs_read
      1.03            +0.0        1.06        perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio.iomap_write_begin
      0.51            +0.0        0.54 ±  2%  perf-profile.calltrace.cycles-pp.down_write.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin.iomap_iter.iomap_file_buffered_write
      0.54            +0.0        0.57        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_read_batch.filemap_get_pages.filemap_read.xfs_file_buffered_read
      0.61            +0.0        0.64        perf-profile.calltrace.cycles-pp.xfs_iunlock.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
      1.19            +0.0        1.22        perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.folio_alloc_noprof.__filemap_get_folio.iomap_write_begin.iomap_write_iter
      1.26            +0.0        1.29        perf-profile.calltrace.cycles-pp.folio_alloc_noprof.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      0.78            +0.0        0.82        perf-profile.calltrace.cycles-pp.xfs_ilock_for_iomap.xfs_buffered_write_iomap_begin.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write
      1.00            +0.0        1.04        perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      1.04            +0.0        1.07        perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      1.19            +0.0        1.23        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      1.53            +0.0        1.57        perf-profile.calltrace.cycles-pp.clear_bhb_loop.read
      1.11            +0.0        1.15        perf-profile.calltrace.cycles-pp.iomap_iter_advance.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      1.02            +0.0        1.06        perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.60            +0.0        1.64        perf-profile.calltrace.cycles-pp.clear_bhb_loop.write
      1.43            +0.0        1.48        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.llseek
      1.64            +0.1        1.70        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      1.54            +0.1        1.59        perf-profile.calltrace.cycles-pp.clear_bhb_loop.llseek
      0.86            +0.1        0.91        perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.__iomap_write_begin.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      1.89            +0.1        1.95        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      1.99            +0.1        2.04        perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      2.34            +0.1        2.40        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read
      2.14            +0.1        2.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      1.57            +0.1        1.64        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      1.62            +0.1        1.70 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      2.37            +0.1        2.51        perf-profile.calltrace.cycles-pp.iomap_set_range_uptodate.iomap_write_end.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      4.01            +0.2        4.16        perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      6.70            +0.2        6.85        perf-profile.calltrace.cycles-pp.__filemap_get_folio.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      2.68            +0.2        2.85        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.__iomap_write_begin.iomap_write_begin.iomap_write_iter
      2.78            +0.2        2.95        perf-profile.calltrace.cycles-pp.zero_user_segments.__iomap_write_begin.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write
      6.22            +0.2        6.41        perf-profile.calltrace.cycles-pp.llseek
      4.69            +0.2        4.89        perf-profile.calltrace.cycles-pp.iomap_write_end.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
      5.90            +0.2        6.11        perf-profile.calltrace.cycles-pp.iomap_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      4.23            +0.2        4.47        perf-profile.calltrace.cycles-pp.__iomap_write_begin.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write
      4.88            +0.3        5.15        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter
      5.10            +0.3        5.38        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read
     14.66            +0.4       15.06        perf-profile.calltrace.cycles-pp.filemap_read.xfs_file_buffered_read.xfs_file_read_iter.vfs_read.ksys_read
      1.01 ±  2%      +0.4        1.42 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.08 ±223%      +0.4        0.51        perf-profile.calltrace.cycles-pp.xfs_break_layouts.xfs_file_write_checks.xfs_file_buffered_write.vfs_write.ksys_write
     11.72            +0.4       12.16        perf-profile.calltrace.cycles-pp.iomap_write_begin.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write
     16.26            +0.4       16.70        perf-profile.calltrace.cycles-pp.xfs_file_buffered_read.xfs_file_read_iter.vfs_read.ksys_read.do_syscall_64
     16.66            +0.4       17.10        perf-profile.calltrace.cycles-pp.xfs_file_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.40            +0.5       18.89        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     19.10            +0.5       19.62        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.37            +0.5        1.90 ±  2%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.17 ±141%      +0.5        0.70 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     20.13            +0.6       20.68        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     20.38            +0.6       20.94        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     24.42            +0.7       25.08        perf-profile.calltrace.cycles-pp.read
      0.00            +0.7        0.68 ±  5%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
     22.42            +0.8       23.27        perf-profile.calltrace.cycles-pp.iomap_write_iter.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write
      2.11            +0.9        2.99        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.16            +0.9        3.08        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.17            +0.9        3.09        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.32            +1.0        3.29        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.52            +1.0        3.51        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      2.52            +1.0        3.51        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      2.51            +1.0        3.50        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.54            +1.0        3.54        perf-profile.calltrace.cycles-pp.common_startup_64
      2.06 ±  2%      +1.1        3.13        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     29.32            +1.1       30.42        perf-profile.calltrace.cycles-pp.iomap_file_buffered_write.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64
     33.36            +1.2       34.57        perf-profile.calltrace.cycles-pp.xfs_file_buffered_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.26            +1.3       37.56        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     37.09            +1.4       38.44        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     38.13            +1.4       39.53        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     38.38            +1.4       39.79        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     41.30            +2.0       43.33        perf-profile.calltrace.cycles-pp.write
     15.88            -3.5       12.42 ±  3%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     17.02            -3.4       13.59 ±  3%  perf-profile.children.cycles-pp.down_write
     14.58            -3.3       11.25 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     12.90            -3.0        9.94 ±  4%  perf-profile.children.cycles-pp.osq_lock
      9.09            -1.8        7.26 ±  3%  perf-profile.children.cycles-pp.open_last_lookups
      9.24            -1.8        7.41 ±  3%  perf-profile.children.cycles-pp.path_openat
      9.20            -1.8        7.37 ±  3%  perf-profile.children.cycles-pp.__x64_sys_creat
      9.30            -1.8        7.47 ±  3%  perf-profile.children.cycles-pp.do_sys_openat2
      9.24            -1.8        7.41 ±  3%  perf-profile.children.cycles-pp.do_filp_open
      9.29            -1.8        7.48 ±  3%  perf-profile.children.cycles-pp.creat64
      8.80            -1.6        7.17 ±  3%  perf-profile.children.cycles-pp.__x64_sys_unlink
      8.80            -1.6        7.17 ±  3%  perf-profile.children.cycles-pp.do_unlinkat
      8.90            -1.6        7.28 ±  3%  perf-profile.children.cycles-pp.unlink
     83.14            -1.3       81.79        perf-profile.children.cycles-pp.do_syscall_64
     83.86            -1.3       82.52        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.29            -0.4        1.86        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.06            -0.3        0.81        perf-profile.children.cycles-pp.pick_next_task_fair
      1.01            -0.2        0.77 ±  2%  perf-profile.children.cycles-pp.sched_balance_newidle
      1.28            -0.2        1.04        perf-profile.children.cycles-pp.schedule
      1.42            -0.2        1.19        perf-profile.children.cycles-pp.__schedule
      1.01            -0.2        0.80 ±  2%  perf-profile.children.cycles-pp.sched_balance_rq
      0.86            -0.2        0.68        perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.85            -0.2        0.67        perf-profile.children.cycles-pp.update_sd_lb_stats
      0.79            -0.2        0.62        perf-profile.children.cycles-pp.update_sg_lb_stats
      1.78            -0.2        1.63 ±  4%  perf-profile.children.cycles-pp.kthread
      1.75            -0.2        1.60 ±  4%  perf-profile.children.cycles-pp.worker_thread
      1.78            -0.1        1.64 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      1.78            -0.1        1.64 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.31            -0.1        1.23        perf-profile.children.cycles-pp.xfs_inactive
      1.33            -0.1        1.25        perf-profile.children.cycles-pp.xfs_inodegc_worker
      0.48            -0.1        0.41        perf-profile.children.cycles-pp.___down_common
      0.48            -0.1        0.41        perf-profile.children.cycles-pp.__down
      0.54            -0.1        0.47        perf-profile.children.cycles-pp.down
      0.48            -0.1        0.41        perf-profile.children.cycles-pp.schedule_timeout
      0.55            -0.1        0.48        perf-profile.children.cycles-pp.xfs_buf_lock
      0.96            -0.1        0.88        perf-profile.children.cycles-pp.xfs_inactive_ifree
      0.75            -0.1        0.68        perf-profile.children.cycles-pp.xfs_buf_get_map
      0.63            -0.1        0.56        perf-profile.children.cycles-pp.xfs_read_agi
      0.77            -0.1        0.70        perf-profile.children.cycles-pp.xfs_buf_read_map
      0.56            -0.1        0.50        perf-profile.children.cycles-pp.xfs_buf_find_lock
      0.67            -0.1        0.60        perf-profile.children.cycles-pp.xfs_buf_lookup
      0.91            -0.1        0.84        perf-profile.children.cycles-pp.xfs_trans_read_buf_map
      0.58            -0.1        0.52        perf-profile.children.cycles-pp.xfs_ialloc_read_agi
      0.69            -0.1        0.63        perf-profile.children.cycles-pp.xfs_ifree
      0.59            -0.1        0.53 ±  2%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.65            -0.1        0.60        perf-profile.children.cycles-pp.xfs_difree
      0.68            -0.1        0.62        perf-profile.children.cycles-pp.xfs_inode_uninit
      0.27 ±  4%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.idle_cpu
      0.29            -0.0        0.27        perf-profile.children.cycles-pp.xfs_buf_item_format_segment
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.cpu_util
      0.30 ±  2%      -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.xfs_buf_item_format
      0.12 ±  5%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp._find_next_and_bit
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.xlog_copy_iovec
      0.06            +0.0        0.07        perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.23            +0.0        0.24        perf-profile.children.cycles-pp.xfs_buffered_write_iomap_end
      0.29            +0.0        0.30        perf-profile.children.cycles-pp._raw_spin_lock
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.native_sched_clock
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.08 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.09            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.07            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.update_rq_clock
      0.44            +0.0        0.46        perf-profile.children.cycles-pp.generic_write_checks
      0.23            +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.try_to_wake_up
      0.48            +0.0        0.50        perf-profile.children.cycles-pp.xfs_iext_lookup_extent
      0.55            +0.0        0.57        perf-profile.children.cycles-pp.xfs_break_layouts
      0.10 ±  4%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.kick_pool
      0.12 ±  3%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.__queue_work
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.run_timer_softirq
      0.14            +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__run_timers
      0.12 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.06 ±  8%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.68            +0.0        0.71        perf-profile.children.cycles-pp.xas_store
      0.12 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.call_timer_fn
      1.05            +0.0        1.07        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.05            +0.0        0.08        perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.06 ±  8%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.dl_server_start
      1.02            +0.0        1.05        perf-profile.children.cycles-pp.up_write
      0.17            +0.0        0.20        perf-profile.children.cycles-pp.ttwu_do_activate
      0.10 ±  3%      +0.0        0.13 ±  7%  perf-profile.children.cycles-pp.menu_select
      0.16 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.enqueue_task_fair
      1.20            +0.0        1.24        perf-profile.children.cycles-pp.__cond_resched
      1.21            +0.0        1.24        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      1.27            +0.0        1.30        perf-profile.children.cycles-pp.folio_alloc_noprof
      1.10            +0.0        1.13        perf-profile.children.cycles-pp.fault_in_readable
      1.14            +0.0        1.18        perf-profile.children.cycles-pp.iomap_iter_advance
      0.10 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.sched_balance_domains
      1.06            +0.0        1.09        perf-profile.children.cycles-pp.filemap_get_entry
      1.22            +0.0        1.25        perf-profile.children.cycles-pp.xas_load
      0.82            +0.0        0.86        perf-profile.children.cycles-pp.xfs_ilock_for_iomap
      1.68            +0.0        1.72        perf-profile.children.cycles-pp.xfs_ilock
      1.24            +0.0        1.28        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.21 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.sysvec_call_function_single
      1.09            +0.0        1.14        perf-profile.children.cycles-pp.ksys_lseek
      0.88            +0.0        0.93        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      1.67            +0.1        1.72        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.47            +0.1        0.52        perf-profile.children.cycles-pp.task_work_run
      0.46            +0.1        0.51        perf-profile.children.cycles-pp.task_mm_cid_work
      0.73            +0.1        0.78        perf-profile.children.cycles-pp.update_process_times
      2.04            +0.1        2.10        perf-profile.children.cycles-pp.filemap_get_read_batch
      0.06 ± 19%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.tick_irq_enter
      2.22            +0.1        2.28        perf-profile.children.cycles-pp.xfs_file_write_checks
      1.86            +0.1        1.92        perf-profile.children.cycles-pp.xfs_iunlock
      0.07 ± 15%      +0.1        0.13 ± 12%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.01 ±223%      +0.1        0.07        perf-profile.children.cycles-pp.start_dl_timer
      2.38            +0.1        2.44        perf-profile.children.cycles-pp.filemap_get_pages
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      1.30            +0.1        1.37        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.44            +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.81            +0.1        0.88 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.20 ± 11%      +0.1        0.28 ± 10%  perf-profile.children.cycles-pp.clockevents_program_event
      0.85            +0.1        0.93 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.75            +0.1        1.85 ±  3%  perf-profile.children.cycles-pp.fdget_pos
      0.60            +0.1        0.71        perf-profile.children.cycles-pp.handle_softirqs
      0.62            +0.1        0.74        perf-profile.children.cycles-pp.__irq_exit_rcu
      2.76            +0.1        2.88        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.24 ±  6%      +0.1        0.38 ±  9%  perf-profile.children.cycles-pp.ktime_get
      4.73            +0.1        4.88        perf-profile.children.cycles-pp.clear_bhb_loop
      4.22            +0.2        4.37        perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      6.80            +0.2        6.95        perf-profile.children.cycles-pp.__filemap_get_folio
      2.70            +0.2        2.87        perf-profile.children.cycles-pp.memset_orig
      2.79            +0.2        2.96        perf-profile.children.cycles-pp.zero_user_segments
      1.10 ±  2%      +0.2        1.29 ±  4%  perf-profile.children.cycles-pp.hrtimer_interrupt
      1.13 ±  2%      +0.2        1.32 ±  4%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      3.25            +0.2        3.44        perf-profile.children.cycles-pp.iomap_set_range_uptodate
      6.25            +0.2        6.46        perf-profile.children.cycles-pp.llseek
      4.74            +0.2        4.95        perf-profile.children.cycles-pp.iomap_write_end
      6.04            +0.2        6.25        perf-profile.children.cycles-pp.iomap_iter
      4.30            +0.2        4.55        perf-profile.children.cycles-pp.__iomap_write_begin
      4.90            +0.3        5.17        perf-profile.children.cycles-pp._copy_to_iter
      5.14            +0.3        5.42        perf-profile.children.cycles-pp.copy_page_to_iter
      1.84            +0.4        2.20 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     14.77            +0.4       15.17        perf-profile.children.cycles-pp.filemap_read
     16.70            +0.4       17.13        perf-profile.children.cycles-pp.xfs_file_read_iter
     11.81            +0.4       12.25        perf-profile.children.cycles-pp.iomap_write_begin
     16.35            +0.4       16.79        perf-profile.children.cycles-pp.xfs_file_buffered_read
     18.46            +0.5       18.94        perf-profile.children.cycles-pp.vfs_read
     19.18            +0.5       19.70        perf-profile.children.cycles-pp.ksys_read
     24.52            +0.7       25.18        perf-profile.children.cycles-pp.read
      2.45            +0.7        3.16        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     22.61            +0.9       23.46        perf-profile.children.cycles-pp.iomap_write_iter
      2.12            +0.9        3.01        perf-profile.children.cycles-pp.acpi_safe_halt
      2.12            +0.9        3.02        perf-profile.children.cycles-pp.acpi_idle_enter
      2.18            +0.9        3.11        perf-profile.children.cycles-pp.cpuidle_enter_state
      2.19            +0.9        3.12        perf-profile.children.cycles-pp.cpuidle_enter
      2.34            +1.0        3.33        perf-profile.children.cycles-pp.cpuidle_idle_call
      2.52            +1.0        3.51        perf-profile.children.cycles-pp.start_secondary
      2.54            +1.0        3.54        perf-profile.children.cycles-pp.common_startup_64
      2.54            +1.0        3.54        perf-profile.children.cycles-pp.cpu_startup_entry
      2.54            +1.0        3.54        perf-profile.children.cycles-pp.do_idle
     29.39            +1.1       30.49        perf-profile.children.cycles-pp.iomap_file_buffered_write
     33.47            +1.2       34.68        perf-profile.children.cycles-pp.xfs_file_buffered_write
     36.35            +1.3       37.66        perf-profile.children.cycles-pp.vfs_write
     37.18            +1.4       38.54        perf-profile.children.cycles-pp.ksys_write
     41.97            +1.5       43.49        perf-profile.children.cycles-pp.write
     12.68            -2.9        9.78 ±  4%  perf-profile.self.cycles-pp.osq_lock
      2.26            -0.4        1.83        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.55            -0.1        0.44        perf-profile.self.cycles-pp.update_sg_lb_stats
      0.12 ±  4%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.idle_cpu
      0.12 ±  5%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
      0.10 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.update_load_avg
      0.22 ±  2%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.28            +0.0        0.30        perf-profile.self.cycles-pp.__folio_batch_add_and_move
      0.72            +0.0        0.74        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.42            +0.0        0.44        perf-profile.self.cycles-pp.folio_unlock
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.update_rq_clock
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.54            +0.0        0.56        perf-profile.self.cycles-pp.xfs_file_buffered_write
      0.46            +0.0        0.48        perf-profile.self.cycles-pp.xfs_iext_lookup_extent
      0.43 ±  2%      +0.0        0.45        perf-profile.self.cycles-pp.iomap_write_end
      1.00            +0.0        1.03        perf-profile.self.cycles-pp.do_syscall_64
      0.58            +0.0        0.61        perf-profile.self.cycles-pp.iomap_write_begin
      0.95            +0.0        0.98        perf-profile.self.cycles-pp.iomap_write_iter
      0.78            +0.0        0.81        perf-profile.self.cycles-pp.__filemap_get_folio
      0.81            +0.0        0.84        perf-profile.self.cycles-pp.up_write
      0.86            +0.0        0.88        perf-profile.self.cycles-pp.xas_load
      0.76            +0.0        0.79        perf-profile.self.cycles-pp.iomap_file_buffered_write
      0.99            +0.0        1.02        perf-profile.self.cycles-pp.vfs_read
      1.06            +0.0        1.09        perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.60            +0.0        0.64        perf-profile.self.cycles-pp.filemap_get_entry
      1.06            +0.0        1.10        perf-profile.self.cycles-pp.fault_in_readable
      0.65            +0.0        0.69        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.88 ±  2%      +0.0        0.92        perf-profile.self.cycles-pp.entry_SYSCALL_64
      1.20            +0.0        1.24        perf-profile.self.cycles-pp.vfs_write
      1.10            +0.0        1.14        perf-profile.self.cycles-pp.iomap_iter_advance
      0.74            +0.0        0.78 ±  2%  perf-profile.self.cycles-pp.llseek
      0.42 ±  2%      +0.0        0.46        perf-profile.self.cycles-pp.task_mm_cid_work
      1.64            +0.1        1.69        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.sched_balance_domains
      1.62 ±  2%      +0.1        1.69        perf-profile.self.cycles-pp.filemap_read
      1.66            +0.1        1.75 ±  3%  perf-profile.self.cycles-pp.fdget_pos
      0.22 ±  6%      +0.1        0.35 ± 11%  perf-profile.self.cycles-pp.ktime_get
      4.68            +0.1        4.82        perf-profile.self.cycles-pp.clear_bhb_loop
      2.68            +0.2        2.84        perf-profile.self.cycles-pp.memset_orig
      3.20            +0.2        3.39        perf-profile.self.cycles-pp.iomap_set_range_uptodate
      4.84            +0.3        5.11        perf-profile.self.cycles-pp._copy_to_iter
      0.83            +0.4        1.23        perf-profile.self.cycles-pp.acpi_safe_halt



***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/sched_yield/will-it-scale

commit: 
  7266f0a6d3 ("fs/bcachefs: Fix __wait_on_freeing_inode() definition of waitqueue entry")
  538d813df3 ("sched/eevdf: Reduce the computation frequency of avg_vruntime")

7266f0a6d3bb73f4 538d813df3945cbc9d6a90ba224 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.977e+08 ±  6%     +40.4%  2.776e+08 ± 15%  cpuidle..time
     44.46           -14.6%      37.96 ±  3%  vmstat.cpu.us
     54.34            +6.3       60.67 ±  2%  mpstat.cpu.all.sys%
     44.71            -6.5       38.16 ±  3%  mpstat.cpu.all.usr%
    309.97 ± 86%     -89.9%      31.19 ±211%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1343 ± 93%     -86.3%     183.97 ±215%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
  65774130            -4.1%   63075951        will-it-scale.104.threads
    632443            -4.1%     606499        will-it-scale.per_thread_ops
  65774130            -4.1%   63075951        will-it-scale.workload
 1.496e+10            -1.5%  1.474e+10        perf-stat.i.branch-instructions
      0.73            +0.1        0.87 ±  4%  perf-stat.i.branch-miss-rate%
 1.098e+08           +16.7%  1.281e+08 ±  4%  perf-stat.i.branch-misses
    178.36            -2.2%     174.43        perf-stat.i.cpu-migrations
      0.73            +0.1        0.87 ±  4%  perf-stat.overall.branch-miss-rate%
    340697            +4.5%     355878        perf-stat.overall.path-length
 1.492e+10            -1.5%  1.469e+10        perf-stat.ps.branch-instructions
 1.095e+08           +16.6%  1.277e+08 ±  4%  perf-stat.ps.branch-misses
    177.83            -2.2%     173.84        perf-stat.ps.cpu-migrations
     22.46            -1.7       20.74        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__sched_yield
     15.97            -1.6       14.32 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__sched_yield
      2.12 ± 19%      -0.9        1.21 ± 36%  perf-profile.calltrace.cycles-pp.testcase
      1.12 ± 11%      -0.5        0.57 ± 45%  perf-profile.calltrace.cycles-pp.perf_trace_sched_stat_runtime.update_curr.pick_task_fair.pick_next_task_fair.__schedule
      3.43            -0.4        3.06        perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      7.89            -0.2        7.65        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
      0.99 ±  2%      -0.2        0.79 ±  3%  perf-profile.calltrace.cycles-pp.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90 ±  2%      -0.2        0.71 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock.raw_spin_rq_lock_nested.do_sched_yield.__x64_sys_sched_yield.do_syscall_64
      1.11 ±  2%      -0.1        1.03 ±  2%  perf-profile.calltrace.cycles-pp.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ±  9%      -0.1        0.53        perf-profile.calltrace.cycles-pp.__calc_delta.update_curr.pick_task_fair.pick_next_task_fair.__schedule
      0.52 ±  2%      +0.2        0.71 ±  8%  perf-profile.calltrace.cycles-pp.update_curr_se.update_curr.pick_task_fair.pick_next_task_fair.__schedule
      0.90 ±  2%      +0.5        1.44 ± 13%  perf-profile.calltrace.cycles-pp.update_curr_dl_se.update_curr.pick_task_fair.pick_next_task_fair.__schedule
      0.00            +0.7        0.71 ± 16%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.08            +0.7        1.80 ± 10%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      5.86 ±  3%      +0.8        6.62 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__sched_yield
     97.15            +1.0       98.11        perf-profile.calltrace.cycles-pp.__sched_yield
      1.58            +2.1        3.68        perf-profile.calltrace.cycles-pp.update_min_vruntime.update_curr.pick_task_fair.pick_next_task_fair.__schedule
     26.96            +3.5       30.49 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     23.27            +4.0       27.22 ±  3%  perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     22.59            +4.0       26.62 ±  3%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.38 ±  2%      +4.8       20.13 ±  3%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
     45.87            +4.8       50.67        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
     33.18            +5.6       38.77 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     13.14            +5.7       18.82 ±  3%  perf-profile.calltrace.cycles-pp.pick_task_fair.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      9.46            +5.9       15.34 ±  3%  perf-profile.calltrace.cycles-pp.update_curr.pick_task_fair.pick_next_task_fair.__schedule.schedule
     22.62            -1.7       20.88        perf-profile.children.cycles-pp.syscall_return_via_sysret
     16.99            -1.7       15.30 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.12 ± 19%      -0.9        1.21 ± 36%  perf-profile.children.cycles-pp.testcase
      1.12 ± 11%      -0.5        0.61 ± 32%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      3.61            -0.4        3.21        perf-profile.children.cycles-pp.do_sched_yield
      1.59            -0.2        1.36 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      1.02 ±  2%      -0.2        0.82 ±  3%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.12 ±  2%      -0.1        1.03 ±  2%  perf-profile.children.cycles-pp.yield_task_fair
      0.60 ±  9%      -0.1        0.54        perf-profile.children.cycles-pp.__calc_delta
      0.19 ±  3%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.sched_update_worker
      0.07 ±  5%      +0.0        0.08        perf-profile.children.cycles-pp.task_tick_fair
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.24 ±  9%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.09 ±  4%      +0.0        0.13 ± 12%  perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.28 ±  8%      +0.0        0.32 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.34 ±  7%      +0.0        0.38 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.40 ±  6%      +0.0        0.44 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.46 ±  5%      +0.0        0.51 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.39 ±  7%      +0.0        0.44 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.05            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sched_yield@plt
      0.42 ±  6%      +0.0        0.47 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.11            +0.1        1.16 ±  3%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.50 ±  2%      +0.1        0.64 ±  9%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.57            +0.2        0.74 ±  8%  perf-profile.children.cycles-pp.update_curr_se
      9.44            +0.2        9.63        perf-profile.children.cycles-pp.entry_SYSCALL_64
      3.20 ±  3%      +0.4        3.57 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.38 ±  4%      +0.4        0.75 ± 16%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.97 ±  2%      +0.5        1.50 ± 12%  perf-profile.children.cycles-pp.update_curr_dl_se
      1.13            +0.7        1.85 ± 10%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     97.52            +0.9       98.46        perf-profile.children.cycles-pp.__sched_yield
      1.59            +2.1        3.70        perf-profile.children.cycles-pp.update_min_vruntime
     27.20            +3.5       30.72 ±  2%  perf-profile.children.cycles-pp.__x64_sys_sched_yield
     23.29            +3.9       27.24 ±  3%  perf-profile.children.cycles-pp.schedule
     22.77            +4.0       26.78 ±  3%  perf-profile.children.cycles-pp.__schedule
     15.44 ±  2%      +4.8       20.19 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
     46.20            +4.8       50.97        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     13.50            +5.6       19.09 ±  3%  perf-profile.children.cycles-pp.pick_task_fair
     33.34            +5.6       38.94 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
      9.89            +5.7       15.60 ±  3%  perf-profile.children.cycles-pp.update_curr
     22.55            -1.7       20.84        perf-profile.self.cycles-pp.syscall_return_via_sysret
     16.83            -1.7       15.15 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.84 ± 21%      -0.9        0.97 ± 44%  perf-profile.self.cycles-pp.testcase
     13.04            -0.8       12.20        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.88 ±  7%      -0.8        1.06 ±  8%  perf-profile.self.cycles-pp.pick_next_task_fair
      3.97 ±  2%      -0.8        3.20 ±  6%  perf-profile.self.cycles-pp.__schedule
      2.82 ±  8%      -0.6        2.18 ±  2%  perf-profile.self.cycles-pp.__sched_yield
      1.09 ± 11%      -0.5        0.59 ± 32%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      1.54            -0.2        1.30 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      1.20            -0.1        1.09 ±  2%  perf-profile.self.cycles-pp.do_sched_yield
      0.52 ±  2%      -0.1        0.45 ±  2%  perf-profile.self.cycles-pp.schedule
      1.00 ±  2%      -0.1        0.94 ±  2%  perf-profile.self.cycles-pp.yield_task_fair
      0.58 ±  8%      -0.1        0.53        perf-profile.self.cycles-pp.__calc_delta
      0.55            -0.0        0.52        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.17 ±  2%      -0.0        0.14 ±  4%  perf-profile.self.cycles-pp.sched_update_worker
      0.25 ±  2%      -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.__x64_sys_sched_yield
      0.08 ±  5%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.arch_scale_cpu_capacity
      0.05            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.sched_yield@plt
      0.44 ±  2%      +0.1        0.58 ±  9%  perf-profile.self.cycles-pp.dl_scaled_delta_exec
      0.50 ±  2%      +0.2        0.68 ±  8%  perf-profile.self.cycles-pp.update_curr_se
      8.34            +0.2        8.56        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.72            +0.4        1.08 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.34 ±  3%      +0.4        0.70 ± 16%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.49 ±  2%      +0.4        0.88 ± 15%  perf-profile.self.cycles-pp.update_curr_dl_se
      4.30 ±  3%      +1.4        5.66 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      1.47 ±  2%      +2.2        3.68        perf-profile.self.cycles-pp.update_min_vruntime
      4.05            +3.4        7.47 ±  4%  perf-profile.self.cycles-pp.update_curr





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


