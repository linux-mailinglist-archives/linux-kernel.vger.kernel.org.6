Return-Path: <linux-kernel+bounces-546161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F60A4F71E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1058E16CF7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852211DD0D4;
	Wed,  5 Mar 2025 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAZI89cX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCE1C6FE2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156186; cv=fail; b=nNgSjCdHcElmbtaTZyaq/5rOnAezGCcGTqArU/6XfPPShB14srMMdUqSfSPlR63zXATC0+Fm7z0m5/AAdaBUJGjMl/sBY/5OGDwRO65Gc/Aaw+723rXeQQ0mbCjZE4I12DzcU7DtC2UBSNI4xtxSPdKT/py0awHEkwZDox7kcvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156186; c=relaxed/simple;
	bh=APbgvIScvlSml+vUjB4cl4MCJ5FxNE/RO5y115xn1ug=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FcHsjTJf57qiBbntN313Ue4pL45b5E0RgOowQAA5RJBTUOxzHGYGLC0kqayx2nCYNZ4BnnmoHm1qNzhpw46SaFYVO16Lhrge2v7dKHapsC1Qu1zEDsoiFkz4zjjbwsdY+shokf1jp49hWP+8YTzyHgTLoP0c5V3AVuuAW9f+Hzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAZI89cX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741156185; x=1772692185;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=APbgvIScvlSml+vUjB4cl4MCJ5FxNE/RO5y115xn1ug=;
  b=iAZI89cXN8To7n5KfqoRO0gxj2IRwz/EQmlS2pxzJjGgWESLi21YHBT8
   i3uGUBz2u8gTqk7GcHlIAGS54FtzlG+97q12CWQWxHLBdVkRn/RjF1hx/
   9lR2uvpiJ7V4UkZ1P0jD4JiNuZ5x+JFCjn18DW0vEq0XtB9m0cGfxLXan
   JIbGwhqqqD3fGgcWMmkZeoFhUPqiVItKO4yOjOUT+Fyz7S5jJVttEPzko
   0tgn0hpPQKhz3qMaB8/TG3M3RM2Ww/xr8MFJWQ6HQaVUjrtIOn/34IDsS
   tgVCuCYs0zh1lDjPKmL6akKBvsO3EzgUG6rTRuioiaC18m9oy3I0PBTpE
   g==;
X-CSE-ConnectionGUID: s/NarNCgScO/RLNsHBOuiw==
X-CSE-MsgGUID: FH52FH3RS9e4ZJhKAEZrkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52307461"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="52307461"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 22:29:44 -0800
X-CSE-ConnectionGUID: 08FhdSOfSCm3f+ss2e7yJg==
X-CSE-MsgGUID: SjI8DPPpSOuYPWm/RgROfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="118599814"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 22:29:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 22:29:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 22:29:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 22:29:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBGN+b+XMt79oDxqJGWXonSxcpuKZMH9IBx2+WT9yepCbyzKoN/fIcNHsi3WQvE2pusC+ruKgjwFztNEiI0Yas0mtSpgvBfueeTQBCpte7hWgd91YbYcU8kKEql0Kg7o+pL2UTiCiWgCg2NmxaoFMWVZ3C1TBHeLq+6iBSmA1Z9tnyuLjx1eE0qi4PgQpIFfkezR9DT4uhSYGcla2ZZVvoq+xzdXoPDYzowH0Jkx664XUuhOUm4riimDxs/ghFX1iFQ2Os0n66V9A/AT1hztyLxgGOXrcHDRhnwYSAci/lkw64OcAwDDApjx9DPDqQVTRM8tfSwWntahjdY42HfDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InwrTR9s4YRss6LbAWE+IAGfJGjd6WH/jjTPp7nseBc=;
 b=Yhd5HyqSWyU37W3Ec2hDPJvejS0vaxyhNTOZ0c2WBnnA31LLOQFvHk+IdmlL2HzpPpaStV4e1UIY0wx/NcY2Kt0Z6BV4YxS09+/GkBsia0aFtHQmk0RRHpqEzndbGMypDOaavCCVfI1NISvJ147SDenYV16EdBveMhIXQGm/gmtOSrlEgXyjbHCzby9vZAI5XbSb1tV7kgNlAsgSuufHD9khj2XT0BjH2a84W9HFREaWwMzCJpZ4VIzNTsubm4VhbGvAidbfEvd/KeJLDeHRBsYvM1w/lI63ER3rRlc+IFA4/r/1jV08kGZDTNBsO6jJspUDDq+uMIll8QDa0KoJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 06:28:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 06:28:53 +0000
Date: Wed, 5 Mar 2025 14:28:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Frank van der Linden <fvdl@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <muchun.song@linux.dev>, <yuzhao@google.com>,
	<usamaarif642@gmail.com>, <joao.m.martins@oracle.com>,
	<roman.gushchin@linux.dev>, <ziy@nvidia.com>, <david@redhat.com>, "Frank van
 der Linden" <fvdl@google.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5 02/27] mm, cma: support multiple contiguous ranges, if
 requested
Message-ID: <202503051327.e87dce82-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228182928.2645936-3-fvdl@google.com>
X-ClientProxiedBy: KL1PR01CA0082.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 948895b6-d50f-4ab8-3abf-08dd5baeffaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9N5U7c0lcgLQ6QlzEmSh9Sz/5WdTfZTX+7cCeCpTTfsef7Tocnm7w2ZQJ4?=
 =?iso-8859-1?Q?w1DyhOCewedMjCAqmYbt6FMr/MycrI4KowFcSqEQO8qhO8qDi8RRC72qCz?=
 =?iso-8859-1?Q?cS3/WYLosfgqO65gVe7Ea2+bs3CBp3q5/TDGtLHdH3/ABHnQ8f8QkWti/u?=
 =?iso-8859-1?Q?t8l+uM34qamYTEMn1XqdUYdPVZXEneyg8s0esbuNbDt/tx2LpLRTqt6N4z?=
 =?iso-8859-1?Q?2V+5q08jdb87W6TBAKauiRXER69vexJ4z4MeX+ijPxLqBL+c2UvnJ4lhjo?=
 =?iso-8859-1?Q?5yeB9x3ivR/H5EGLH1Cj1cB/BMPtHnXMeons+EZsi3ERQdsv9naHn/SnIf?=
 =?iso-8859-1?Q?xWGcjPgcKp3sudFr0Hj2+MsuF7y8fE+gVl1s4bXHo9XxEgkxjUXh2BTzEX?=
 =?iso-8859-1?Q?ssXTFKaSFPEq1q+ITVmQ1choXxV72X9BvMWgBbVMmCQ30pXlGzLarUggjn?=
 =?iso-8859-1?Q?U6wQC5zoa9KV+BHaxv1+l2b1n7Xfh/7cByDI2dzvQ14AxCD2434MY++n4l?=
 =?iso-8859-1?Q?2+s1SFL9dfE45MG6TNKllpqbgKy3ivfi5uAtKnBlQsM2vP7Xy2yYcE8COc?=
 =?iso-8859-1?Q?GzoG7HTBo/RDKfQNFy1/WXQ9ECCuCvRPEtpw8ktZDWvVRROVyYZHTHtajv?=
 =?iso-8859-1?Q?ys9OkPcGo2yDxWw0IdsiAUfw1Eb4jZ5DUK5qws0qq87AjRw6jihAoB6g49?=
 =?iso-8859-1?Q?8e+33LQv0biWA1QwWuyGQqEiry/DjP1/STPKtfSNJhViSxfqPnQbxfJmeu?=
 =?iso-8859-1?Q?I+tP82igc1VEagzbqNChOKMYwwH7Nz3RUBJDsGuVT8b19GPVT5grew9Ckl?=
 =?iso-8859-1?Q?vOEHCE9TORAE6kJS5ucpwrWKDqKHG5+BEUifo78z7nMQ4VnDbjG1tvmVeL?=
 =?iso-8859-1?Q?EHbIQBMXOYlWXn6nUa4s/smAQiMFH4vMk7/MpP6naJ0wsSTmgYZuMTQY6y?=
 =?iso-8859-1?Q?4OzDUdf+cCE89Im+zLS8t5QQOpJVwcrV6BxVwiBry0wfQQOFrDUOhw5Li2?=
 =?iso-8859-1?Q?Ox8VWrr13wXasZcAKOR9sWfZJ5+AS6G0Lx2kt3760TCbRbNrSoMlpY3ZHj?=
 =?iso-8859-1?Q?QGb4j/rkU3cO7/M2N4dBr/6cMedNYJ1+Vhi3qqPh5Fti14J5cejRqt/a6C?=
 =?iso-8859-1?Q?iopiV6W14LrTlcszLCTjYtFHcIr3FJ1Hu9dT52OSS384D+Bxlxb36Pd8oV?=
 =?iso-8859-1?Q?XG1IFq+MuZKAshl+Vc3ZrN3xoECYIzaHgk3JGJmUTuydPOAZHVy+NobbUc?=
 =?iso-8859-1?Q?iG7jtjF+fLzuGRMWzoXzaO0H54ikj4KNvqhSpAZiBlRS0d0lcglRyLmche?=
 =?iso-8859-1?Q?YSOGLK7btkOHPLdKUavG1n8swodGERD9SdWtrUgNU8JhcYJltOE7a8XNx9?=
 =?iso-8859-1?Q?dSz6jMZ6M0i2cBfh3G/XQJL6yeo1iXlA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Dii2gzfqf9sopMzRx/ZKDTQgMjPTeZ8oa5KocPx8xKXt4olyIu+PjzJsUO?=
 =?iso-8859-1?Q?eO2fankezTw8C/h7yUMok3rRDrhkusi/Nx+RydxXA9GE4GOX70188nv4s3?=
 =?iso-8859-1?Q?SlBH0ChD0V2iVCxBEt8jycDbWWcSukzws7Tz4NGZl3mEs2Wd2njV9QU9hC?=
 =?iso-8859-1?Q?aJDAHshfN3Z09Nf7XYaM6jDLlfdyy8v6T5emT0kP1Q0CtrRixcbCt+VWhb?=
 =?iso-8859-1?Q?Qgpa6fwSJVS24VCMjk5f0IFaBOu2TeIFfLxBBy62ta2wHH9eTO2i6mM+Wi?=
 =?iso-8859-1?Q?OkghVZAOjGpI2/zZglgp1iTCyTo6GykAY9XEM+qA3CLvMk2VgYkhaxqGji?=
 =?iso-8859-1?Q?4z7JVk+OAtji1niKmKkqdI6xIwDFgTqXC5Q7/mHpYl1bs/WC5U/v48tCSM?=
 =?iso-8859-1?Q?KjgwvSpSbT/4qcck2VlPksMFdQA616fO/oGmDtJPcSBf6iCcgi3Di98JMn?=
 =?iso-8859-1?Q?YpZxxSDkksMk4lcVH9d2YluS77eNCZbRtNZu11KdujenrhkUnwrhKXiiUn?=
 =?iso-8859-1?Q?AJGeTYuk1Z+KS4AFqXPiODjsRBnNcHnxtFaDIbaOvDvE1WcIWVXyQXAbsc?=
 =?iso-8859-1?Q?E+sh2CWsgSZFanV+VblC/NO0oBP7cXKaq2bPHlu9iQwYTErwDfegPi1NOx?=
 =?iso-8859-1?Q?QvzwmWTXE04f8ZdxosPOCyUGQg3nD3/6sfQttqM3YgitgHU8vutcYs7fly?=
 =?iso-8859-1?Q?vFThRyj7djLwtHk8wsSWJXW2g4uERpMjXTZbNFgkhIwxMFEO88vq/10Jaf?=
 =?iso-8859-1?Q?eXSGAartg7dV6x4bafE6Ju6aPQU6r5Nsa7r8tUGAn0SnVYNXprliP/scVQ?=
 =?iso-8859-1?Q?3HXuBPDwZ1zQwKXTTzUX1pwtoV5o4KqN4zJsAH5sGd5zprmKU8586T7fWn?=
 =?iso-8859-1?Q?LVFPheMfQ9QMlSdWfRiYJJCg87llCR2Oy4bosKE/KuTXgIDnU+KaQHjI9e?=
 =?iso-8859-1?Q?HeqzedCogp3Sx0MkHhKz7IJ43UjOoNZFskhRv7Bo47ll5CBLSjP09eui43?=
 =?iso-8859-1?Q?4qduZhAKRLdsVfLCG8BfHBNbAHQtt6t4njP6cZwS3vxVAThI1CdtjczquO?=
 =?iso-8859-1?Q?5zDM44mJmVl9K2i0Xh8sW4BUMiDJk4XikgAby7fhAOUrL2sujrrmbam6xA?=
 =?iso-8859-1?Q?loOmZV5rOmoYEyuXPCKAmPyE95O2CQFdl2yyEppvQjGoVwwA+Vq+RWfpjf?=
 =?iso-8859-1?Q?BaFzUNTdOnvEa/5EwY/btj8EhoiWSpdUCjYIoBo5chI8dlA6f1hIGr1vw4?=
 =?iso-8859-1?Q?vKr9fH7s5boQ2sl+TXrzmNDffk7Gk1QQNObOqk/CaGzB+fbZd9LK3QL3O1?=
 =?iso-8859-1?Q?f5BYrOR3whkIr77VCFgdpVPpIO5IizzMh8JOKVk6V6a0X75iIFOJ7ZYc4s?=
 =?iso-8859-1?Q?tb/UOiCexpiuX+b6avMvEPCGDidcdxnPRUjrFEizIh88YnKVENrASRuTvn?=
 =?iso-8859-1?Q?RXVxo1Vpmybft4Ftuhg4WJXW8ZNGPutk6iPV4zVws7tkPujtw8ws0ozBGD?=
 =?iso-8859-1?Q?LBZtiHL8z4WBXLjd5A7fDmDvy/MuxnbdNdgvxvpEhLPiDu+KI34XT7EEJE?=
 =?iso-8859-1?Q?89Fw0EFQtC3P2XwIUZkk5LVV8umuAQRxE18F1zZ4036fIaPG8vO5loBYaH?=
 =?iso-8859-1?Q?uC0xGsAElmu7M8zRuF/L7izYsDr1CVlcdSFebBAMeuuYxHpnWHjnyTUQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 948895b6-d50f-4ab8-3abf-08dd5baeffaa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 06:28:52.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nncpmBqWwL7Gf1pMi08GiVI5Uk962NQ5iFkqJk4U6VwhnKPal5VbJUADvuMB7YebIQJLMwTT9eeON34tF0+lsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 15.1% improvement of netperf.Throughput_tps on:


commit: a957f140831b0d42e4fdbe83cf93997ef1b51bda ("[PATCH v5 02/27] mm, cma: support multiple contiguous ranges, if requested")
url: https://github.com/intel-lab-lkp/linux/commits/Frank-van-der-Linden/mm-cma-export-total-and-free-number-of-pages-for-CMA-areas/20250301-023339
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 276f98efb64a2c31c099465ace78d3054c662a0f
patch link: https://lore.kernel.org/all/20250228182928.2645936-3-fvdl@google.com/
patch subject: [PATCH v5 02/27] mm, cma: support multiple contiguous ranges, if requested

testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: TCP_CRR
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250305/202503051327.e87dce82-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/TCP_CRR/netperf

commit: 
  cdc31e6532 ("mm/cma: export total and free number of pages for CMA areas")
  a957f14083 ("mm, cma: support multiple contiguous ranges, if requested")

cdc31e65328522c6 a957f140831b0d42e4fdbe83cf9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.43            +0.5        2.90 ±  4%  mpstat.cpu.all.usr%
   4718850           +15.4%    5446771        vmstat.system.cs
     62006 ± 43%     -59.6%      25067 ±137%  numa-meminfo.node0.Mapped
   2884295 ± 41%     -59.4%    1171696 ±135%  numa-meminfo.node0.Unevictable
     28159 ±  2%     -17.7%      23164 ±  2%  perf-c2c.HITM.local
      5426 ±  3%     +28.5%       6973 ±  8%  perf-c2c.HITM.remote
     33586 ±  2%     -10.3%      30137 ±  3%  perf-c2c.HITM.total
   5642375 ±  2%     +15.5%    6519596        sched_debug.cpu.nr_switches.avg
   7473763 ±  4%     +18.0%    8815709 ±  2%  sched_debug.cpu.nr_switches.max
   4352931 ±  3%     +12.7%    4906391 ±  2%  sched_debug.cpu.nr_switches.min
   2485115 ±  6%     +31.9%    3277456 ± 11%  numa-numastat.node0.local_node
   2526446 ±  6%     +32.8%    3356120 ± 11%  numa-numastat.node0.numa_hit
   3522582 ± 10%     +28.7%    4535065 ± 23%  numa-numastat.node1.local_node
   3613797 ± 10%     +27.0%    4588978 ± 22%  numa-numastat.node1.numa_hit
     40617            +5.4%      42811 ±  5%  proc-vmstat.nr_slab_reclaimable
   6144430 ±  4%     +29.4%    7948120 ± 16%  proc-vmstat.numa_hit
   6011884 ±  4%     +30.0%    7815542 ± 16%  proc-vmstat.numa_local
  26402145 ±  2%     +40.6%   37129548 ± 14%  proc-vmstat.pgalloc_normal
  25226079           +42.1%   35834032 ± 13%  proc-vmstat.pgfree
     15712 ± 43%     -59.6%       6348 ±137%  numa-vmstat.node0.nr_mapped
    721073 ± 41%     -59.4%     292924 ±135%  numa-vmstat.node0.nr_unevictable
    721073 ± 41%     -59.4%     292924 ±135%  numa-vmstat.node0.nr_zone_unevictable
   2526848 ±  6%     +32.8%    3355902 ± 11%  numa-vmstat.node0.numa_hit
   2485517 ±  6%     +31.9%    3277238 ± 11%  numa-vmstat.node0.numa_local
   3614259 ± 10%     +27.0%    4589442 ± 22%  numa-vmstat.node1.numa_hit
   3523043 ± 10%     +28.7%    4535533 ± 23%  numa-vmstat.node1.numa_local
   1711802           +15.1%    1969470        netperf.ThroughputBoth_total_tps
      6686           +15.1%       7693        netperf.ThroughputBoth_tps
   1711802           +15.1%    1969470        netperf.Throughput_total_tps
      6686           +15.1%       7693        netperf.Throughput_tps
 4.052e+08 ±  5%     +16.7%  4.728e+08 ±  4%  netperf.time.involuntary_context_switches
    535.88           +18.1%     633.12        netperf.time.user_time
 3.175e+08 ±  3%     +13.9%  3.615e+08 ±  3%  netperf.time.voluntary_context_switches
 5.135e+08           +15.1%  5.908e+08        netperf.workload
      0.07 ±  8%     -31.3%       0.05 ± 23%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      0.46 ±114%     -71.4%       0.13 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.__inet_stream_connect.inet_stream_connect.__sys_connect
      5.70 ± 90%   +2752.3%     162.72 ±202%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     33.94 ± 19%     +50.3%      50.99 ± 18%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     30764 ± 22%     -32.1%      20881 ± 22%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      7.03 ± 60%  +11736.2%     832.16 ±150%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.14 ±  8%     -33.5%       0.09 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      0.11 ±  8%     -14.3%       0.10 ± 11%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.inet_stream_connect.__sys_connect.__x64_sys_connect
     33.61 ± 19%     +50.4%      50.57 ± 18%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.69 ±109%     -59.0%       0.28 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      0.76           -39.9%       0.46 ± 12%  perf-stat.i.MPKI
 3.959e+10           +14.9%   4.55e+10        perf-stat.i.branch-instructions
      0.92            -0.0        0.90        perf-stat.i.branch-miss-rate%
 3.564e+08           +12.7%  4.017e+08        perf-stat.i.branch-misses
 1.561e+08           -32.2%  1.058e+08 ± 12%  perf-stat.i.cache-misses
  6.91e+08           -33.8%  4.574e+08 ±  6%  perf-stat.i.cache-references
   4760614           +15.5%    5496803        perf-stat.i.context-switches
      1.54           -13.5%       1.33        perf-stat.i.cpi
      2048           +49.1%       3054 ±  9%  perf-stat.i.cycles-between-cache-misses
 2.084e+11           +14.9%  2.394e+11        perf-stat.i.instructions
      0.65           +15.3%       0.75        perf-stat.i.ipc
     37.20           +15.5%      42.97        perf-stat.i.metric.K/sec
      0.75           -41.0%       0.44 ± 12%  perf-stat.overall.MPKI
      0.90            -0.0        0.88        perf-stat.overall.branch-miss-rate%
      1.54           -13.6%       1.33        perf-stat.overall.cpi
      2060           +48.5%       3060 ± 10%  perf-stat.overall.cycles-between-cache-misses
      0.65           +15.7%       0.75        perf-stat.overall.ipc
 3.947e+10           +14.9%  4.536e+10        perf-stat.ps.branch-instructions
 3.553e+08           +12.7%  4.005e+08        perf-stat.ps.branch-misses
 1.557e+08           -32.2%  1.055e+08 ± 12%  perf-stat.ps.cache-misses
 6.889e+08           -33.8%   4.56e+08 ±  6%  perf-stat.ps.cache-references
   4746041           +15.5%    5479885        perf-stat.ps.context-switches
 2.078e+11           +14.9%  2.387e+11        perf-stat.ps.instructions
 6.363e+13           +14.9%  7.312e+13        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


