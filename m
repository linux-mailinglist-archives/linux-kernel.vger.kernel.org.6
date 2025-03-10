Return-Path: <linux-kernel+bounces-554381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8AA5970C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D0616520D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E053922A80A;
	Mon, 10 Mar 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZ17mHF6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988011CBA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615606; cv=fail; b=W22t77zfws1HmNF8qIxsmwQOUj/GPfh6VMVaD0Vvus7X96EnSCx1igTMh+ysWCBCGNWiomKMRPSoTSQfxsw4dM/yuqyDb1xo7C8GgFjxdhJzodjiYO9IIfpeDhn9FBx9SflwodsmQBSyc3r/NHMX+jtZYxqFey/H+1r2pYret/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615606; c=relaxed/simple;
	bh=Bq5YuiwMk6Z3y2bGjIrLeGNThW1Uktzx9Y3YkeGVVN0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BTTYvmBDucZB91dhyjUxQyxWEs0zx3/7iT9tb2LLpu6I3EsAjkWAXj7i5buVloQ7eCsVh1EMAY53iGMonxgLZRXyaMJzdPgbl52PlSTi/HP57022GadEJjkLsEDIvV3FySf1E3j4wE4InlmkRkB6MHio8Sf1QspaGzKfZxFgVNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZ17mHF6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741615605; x=1773151605;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Bq5YuiwMk6Z3y2bGjIrLeGNThW1Uktzx9Y3YkeGVVN0=;
  b=iZ17mHF6gexFu5dLfIcU7c4lNBYhiRBFWBmT+VGEkiVgjFRJPf+IIHaO
   i/BTfaJjyQTDTx+Qx695ylhNqAlVJ20RaF45JPqYYoAOPR+q3X3WcI85D
   bYaRUir2DnhrHRDAcrQmS5l4GPIlOda2iAmHzgmipask895dq+EEk4ODZ
   3D8QwTKboiigxyzOsG5hinpqqF0zaAP6S8IvPAWYuevCt6YRnKvoTVdfi
   QxqtPnou7xHdduvM4+2dekrL2ys0xwKC2MD+v65AXvSfNcqnqb8KA9keY
   p4k5mwMY/B/KhwjhI6azJA/SfPZ7zgfTppklJvWqwdhkzlsrveAGAfWH6
   w==;
X-CSE-ConnectionGUID: GXMv8bV6TCqzIl7xZuzMZQ==
X-CSE-MsgGUID: mKdFSCGiTpayqy/XGjIuoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53254423"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="53254423"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 07:06:44 -0700
X-CSE-ConnectionGUID: GsllUgndQIOo9uzQTmVAPQ==
X-CSE-MsgGUID: lDqudO9/SJOjd4AxErZK/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120495619"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 07:06:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 07:06:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 07:06:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 07:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljo5dfKXzD9FcEi2M1jPAiWEI96yMN2ixPBButuGHs96z6onehoDBqT5tMrF35X+0kmZGSVz/ASD7KkAll0/BxxHAqdls+Xx6pgg7HU/NxGC6/HlC7AgaIL64KDPx9vg/JPZdO6oZ8w2eVa12VIcqUpy8rwFE9Psmm99i6DXcXZsF1RrfM2Iy7fM36A0mdYhC8gMRyD3X+0oBjZLZKCylzjTFZrcuwx5wvp6QSTinhE3l7N6UVClwUKLBZXPdJ3PXmrcuapcGGrv+oKnfQcRbip8C48PdY73urdMP0rXZP+Bwvq25/ZN7ic5VRXrERt7aj3SLn8RyMAI/chmgCmblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmWee3JaddLHmfBENJ+A8GgCH6SICXDAamzc1UNeBHg=;
 b=piITSk/dtTP+KfTMT5ipkgnx75BFQ0r/pVmq2zKgWg0pPhY9Cry4EBrXv8STcRN+ywlffKdWefVDoXo0JkERvmE1l9gr/jripdJYxaH1v8hB34l74TTDX2qtkIvVJk68ICVc749yu1XtiN1ia08QMfdLdx+7zMCnzH95niL1FbaZZrIOEzon3BLovJsDV4/LDRM52ArcDCcCvzBFvwI6BXi2FuF5UNFOznPuOFiNtMYkCiRPwf19N7Mq8WtQnSoqyVDc9GHWqpdrEEWpExOjZdDSZFL5TRlhanCTxlWmn9Zn8nZkKDcCGLxb41CyXmTcQuLi36zRA66As0NGEeex8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM3PR11MB8669.namprd11.prod.outlook.com (2603:10b6:0:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Mon, 10 Mar 2025 14:06:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 14:06:11 +0000
Date: Mon, 10 Mar 2025 22:06:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: James Morse <james.morse@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [morse:mpam/move_to_fs/v7_bare] [x86/resctrl]  0021800a46:
 will-it-scale.per_process_ops 18.4% improvement
Message-ID: <202503102156.d70c4800-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM3PR11MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c93263-72e0-4cd6-23d4-08dd5fdcb608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?furYtppu6WgPpXSimPtG9t19ROGuNP1CJTh2Zn6UAyW+MvmGg4r1F/lHfW?=
 =?iso-8859-1?Q?w/73GbE5xEFsUbmDd4uBcChOfWPOCwtUnbZbrjuuUgc59cCaKCiASfJOU7?=
 =?iso-8859-1?Q?SfTVTYR22BXZmuAGnPJPt2ABzrtfKreHMprUkn1Rg9huDI4vWjJeAV0eEq?=
 =?iso-8859-1?Q?TtjN+TlZDqSWzs7v1/H9hy4aOIH9K2z2Nxx3pK71src2zBMV3Iubm8jDEn?=
 =?iso-8859-1?Q?hqv4r8tFxWOqNHWdYRMssbv+nqQlNtHx3yU+RbIYjDzRcS9swfFbnJiO44?=
 =?iso-8859-1?Q?4IsfmYxgE14jPnWIdUMVCVnICeUPZmmwH7ii/W3vwxZ/XzYHzDObtwOjs5?=
 =?iso-8859-1?Q?3BCP34sMdtW7wFb94lHR0kbOKAJyxM2bK5RqUnLEx9KXUgcGq7NCEjwJDH?=
 =?iso-8859-1?Q?jC9Ma/FU9PX+bT6UWfJdm4v2z0Fq4FKZjBi//akxIDIqznVJXtXYM9qEAp?=
 =?iso-8859-1?Q?ZSPn7PGS1JEnSPRHFKX4FD4vUKscpIa0DNF9P9F/4+3QQs+J0gIh5AGHp0?=
 =?iso-8859-1?Q?WFyCc7DiMIhQLhYJkiodJLCZvWG5Pch0PUjZFaxHfMfChlQ4eA3bw7HW7f?=
 =?iso-8859-1?Q?1wSKm4M4o2O3ds7uwN6WUn+52Hg9dPkf+vMXVIGDl6OOkKSaP+jwD4F4Eu?=
 =?iso-8859-1?Q?2NMXdI0vHbg0HETV6zbq/DDVRqC+/lcFBHgdejrT+LvWEGK1vafnpU4euz?=
 =?iso-8859-1?Q?0hZDYIiWg+QU39IQsv8JHkKeeYytnpPZYWj/8Fo8jATR+tpsHcj5SanSOV?=
 =?iso-8859-1?Q?MPtD8IF8uOFGduWI7eTYXW7qfSU/cBlsw0fWlo6HKnirgfMsxleIuAWxcN?=
 =?iso-8859-1?Q?aaeOaTc9Iij+fqnb0KkWYRSrmwIufSy78uaLhC0GYXksrLZbCkap6l5gYh?=
 =?iso-8859-1?Q?LNPXmpbe2hTMSx8THbEl+874b4M6Vcpt9GGlZO+CT2SmlsnMmYiI8lNU5Z?=
 =?iso-8859-1?Q?RB0ofWllf5smEwA6K+bCSK2MNlcsNGB58bzud4DF3m2SFUQIGYUyc4Fzt1?=
 =?iso-8859-1?Q?KtynwSc8gxWt9W7JZ+OQLpU0HDtfo/Br2zlyGkDKyBYyGRug+kSfT5+19C?=
 =?iso-8859-1?Q?MuuPR34ci6CCHRudQz41dPyEQ4sZXjmLpaRmUJTUMvLHiOG7X5qIBIqtox?=
 =?iso-8859-1?Q?by+EyJLa0MyQ03JdxT22/851YCkYQU+mZRueq09YEhZ5PB5hxqYyCxKTRA?=
 =?iso-8859-1?Q?XkDayYkpy2jEmT9eBedQW5QZe3ayMWDwQhTYgbx+R4a9xjns98fgfNRnRL?=
 =?iso-8859-1?Q?z6za0lgObEOhj1Mcsr0lFrLcCt+S2ShT52PbOJ+2/wOGdTH9YCsFRoTYBb?=
 =?iso-8859-1?Q?K5V2X3TQBfaqp7dxcsBXn1xFcCfzZqfF8jp4c009RY6aBCAikZO+NZztUV?=
 =?iso-8859-1?Q?y2EZMWPxszwPf0gkepsdS6FOrTG5xZTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ozzxjV2ucI+pwFzC6YZdQlL1DEOhX0uAVcK/XNgG2ZkepQBENIfcaikxXT?=
 =?iso-8859-1?Q?Wb2Bex6PX13sJaC/Lxosxb4eAX7Rl+PdDOV5JnCw/M59DSnqGGk64pwH/v?=
 =?iso-8859-1?Q?feb6AZ7gonZ63e6DS7oyve1zwhwxc1LRdhsXII6U2oUeSVxxb5AEZtu15g?=
 =?iso-8859-1?Q?k22ogoVQeyrdGn54zcPB2VdH10Q2LM3c9aexTygt7S8XNV43glLBddjzEP?=
 =?iso-8859-1?Q?p1M0qeUCUzt2axndkvt8cOX9gOlmvlUVBoyMChWu4JFHneypDTF0QZ5ivp?=
 =?iso-8859-1?Q?Hb8mq9D56rMNGn5+bwil1/hwL4ORnLCvF07ng/50oTizpk8uQJTSlS/5gt?=
 =?iso-8859-1?Q?H8jWUcqHHIrA+pSUVwneGOlfZ01/H/qAqSsOjopfqUOQFS/Lg+ftykZSgp?=
 =?iso-8859-1?Q?f3YTvFVWqrrkDLiPXroTrya3mgf034P4pTIS1a13wASih2l2JY8zJ16sAI?=
 =?iso-8859-1?Q?rO0Y7kgyz2A0ZvSwCRVV8kK7YTeCuVGfGoA7g5bJ7rTadVsju4DPxq9d5p?=
 =?iso-8859-1?Q?D38al3XoeBk1Jrxbf40y9FE2sZ4L8+dhAwCk7Ka5Q+piNcR/ihzL6K7dPo?=
 =?iso-8859-1?Q?dojOGRAG71sVQcOMjg0l/s1UIeHFmu6rn9DhxKeNcqigTWiPQhQok5YOgj?=
 =?iso-8859-1?Q?dlnUDF0s++LuhlcXjTefUoBjsE6SNJYK03n+L2IXyK6CX6WEcTvk/veS1/?=
 =?iso-8859-1?Q?BUcfU9rixiPsHmxChsR6W+O7I43MhjAHaBe/yAJ0+Wg4YU+9jK5cCDa2U7?=
 =?iso-8859-1?Q?KYGDjgdB1GIKo3MNswybIgysJgQqrA3zZ7ln3TIeKNBbUoS7anXS0UZIgN?=
 =?iso-8859-1?Q?FLP0168zZaMy407vBo1zkHvXyml3HhOlDarrd/m7Ny3Q7N3rnZIKlZwUGW?=
 =?iso-8859-1?Q?vAmq5i2vhoNXNgkc5XVCJs00Ju0GohMHgMFBoBiZ8nMrdG9Sj3pU1G41mU?=
 =?iso-8859-1?Q?iEezxFgO7sjWZN4JmIkAfHv+bbfQVrwSwD+Q0bopE9+htEPxwfRVdyK9eE?=
 =?iso-8859-1?Q?U6BjBydmok0ySM1X1iGXsnsIwleHs5phZznjvvi3w30Mv4OkHTpqie5m+b?=
 =?iso-8859-1?Q?E0kY8PAn3cB63yX/5Bo9qZMJcdgzUoVLCE6FWj9WyvD9jXKZn1sPdgJFZX?=
 =?iso-8859-1?Q?oGD+R9yEAv9/V3eNh3f5ue71xPOU0a2UaEa+fMP3fpnEalyHjLvwXQOI0i?=
 =?iso-8859-1?Q?uiOSWeSW/l4YgjF5qDQY5j4lGZFu/ivN4jp1wR9YWtuAFU8VY9v+afo37Z?=
 =?iso-8859-1?Q?BUTFltdy/40Wti97zfcPfH7C6KIUe+9df9u97P4Mc4dx+oxD0ulw1Fpoyu?=
 =?iso-8859-1?Q?iuygc+RTf11s+p8o26hnqP+BmiROmVZ9zB+uT39ySf2ANHKeLXNlZMp4SE?=
 =?iso-8859-1?Q?kxJyp/mLiz3Z94EQJZQukSJ2UJ5wNU1mDhrR1qkLckDti9SHe0accCYRUU?=
 =?iso-8859-1?Q?Ty8yk+/0yu0EfzdmDgHSG2vqRpUt7haXoZhLDT2ATDDWtu+qFwDmyzmnsa?=
 =?iso-8859-1?Q?oMhqmns268+gd/5kO59j+2GNHN/4fU/rwhMlCxWxjsBAxwEeOGNwPq2rL/?=
 =?iso-8859-1?Q?qaW2LjAJJQ2zHVdFeM+A3W533OTiYG4ERqHGK641EH4HtvEsxAmw7LDd7r?=
 =?iso-8859-1?Q?vnWqtNXRuDuxeLJMB05hxn2iXDhOVmdMg0nCq4oz06psJL8H7gO9EhoA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c93263-72e0-4cd6-23d4-08dd5fdcb608
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:06:11.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YqHCsWK6u3m+YE5BWWlKEmP4Kn0AAapOxNFdTZOp5W8JWuRsYN/zOtW1ASzE+q4JIVem2LDbF/Ipw0k6oPPgkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8669
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 18.4% improvement of will-it-scale.per_process_ops on:


commit: 0021800a465d495a536265c52f8a031da43948ed ("x86/resctrl: Use schema type to determine the schema format string")
https://git.kernel.org/cgit/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	nr_task: 100%
	mode: process
	test: signal1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.usersyscall.ops_per_sec 18.0% improvement                              |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=usersyscall                                                                            |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503102156.d70c4800-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/signal1/will-it-scale

commit: 
  a13ae432a6 ("x86/resctrl: Use schema type to determine how to parse schema values")
  0021800a46 ("x86/resctrl: Use schema type to determine the schema format string")

a13ae432a665d1d0 0021800a465d495a536265c52f8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    371124 ± 13%     +23.2%     457121 ±  5%  meminfo.Mapped
      0.02 ±  5%      -0.0        0.02 ±  2%  mpstat.cpu.all.soft%
     93276 ± 13%     +22.9%     114661 ±  5%  proc-vmstat.nr_mapped
    290918 ± 16%     +38.9%     404183 ±  7%  numa-meminfo.node1.Mapped
    388.17 ±119%  +3.2e+05%    1237125 ±124%  numa-meminfo.node1.Unevictable
     72842 ± 16%     +38.7%     101060 ±  7%  numa-vmstat.node1.nr_mapped
     97.04 ±119%  +3.2e+05%     309281 ±124%  numa-vmstat.node1.nr_unevictable
     97.04 ±119%  +3.2e+05%     309281 ±124%  numa-vmstat.node1.nr_zone_unevictable
   6588847           +18.4%    7802117        will-it-scale.224.processes
     29414           +18.4%      34830        will-it-scale.per_process_ops
   6588847           +18.4%    7802117        will-it-scale.workload
      5736 ± 18%     -30.2%       4005 ± 16%  perf-c2c.DRAM.remote
     12227 ± 16%     +55.7%      19033 ± 17%  perf-c2c.HITM.local
      5053 ± 18%     -34.5%       3308 ± 16%  perf-c2c.HITM.remote
     17281 ± 16%     +29.3%      22341 ± 17%  perf-c2c.HITM.total
      1.14 ± 33%     -97.7%       0.03 ±108%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      3.13 ±  4%     -10.6%       2.80 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.38 ±  7%     -18.5%       0.31 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.02 ± 22%     -44.0%       0.01 ± 18%  perf-sched.sch_delay.avg.ms.schedule_timeout.msleep.ast_astdp_connector_helper_detect_ctx.drm_helper_probe_detect_ctx
      0.04 ± 17%     -18.5%       0.03 ±  9%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.77 ± 28%     -97.4%       0.05 ±117%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      3.07 ± 24%     -47.7%       1.60 ± 50%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.04 ± 48%     -60.4%       0.02 ± 35%  perf-sched.sch_delay.max.ms.schedule_timeout.msleep.ast_astdp_connector_helper_detect_ctx.drm_helper_probe_detect_ctx
      4698 ± 96%     -78.5%       1007        perf-sched.wait_and_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.97 ± 35%     -98.6%       0.01 ±169%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      1.90 ± 43%     -59.9%       0.76 ± 82%  perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      2.31 ± 15%     -42.7%       1.32 ± 56%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      1.74 ± 25%     -98.5%       0.03 ±170%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      3.07 ± 24%     -47.7%       1.60 ± 50%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      4436 ±104%     -77.3%       1007        perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.16           -42.0%       0.09        perf-stat.i.MPKI
 5.316e+09           +17.2%  6.231e+09        perf-stat.i.branch-instructions
      0.40            -0.0        0.38        perf-stat.i.branch-miss-rate%
  21246147           +11.4%   23662917        perf-stat.i.branch-misses
     22.12 ±  2%      -9.2       12.91        perf-stat.i.cache-miss-rate%
   4407081           -33.2%    2945886        perf-stat.i.cache-misses
  19702928 ±  2%     +12.0%   22067992        perf-stat.i.cache-references
     22.77           -14.7%      19.42        perf-stat.i.cpi
    153602           +54.7%     237617        perf-stat.i.cycles-between-cache-misses
 2.842e+10           +17.3%  3.332e+10        perf-stat.i.instructions
      0.05           +15.3%       0.06        perf-stat.i.ipc
      0.15           -43.1%       0.09        perf-stat.overall.MPKI
      0.40            -0.0        0.38        perf-stat.overall.branch-miss-rate%
     22.36 ±  2%      -9.0       13.32        perf-stat.overall.cache-miss-rate%
     22.77           -14.7%      19.43        perf-stat.overall.cpi
    147278           +49.8%     220671        perf-stat.overall.cycles-between-cache-misses
      0.04           +17.2%       0.05        perf-stat.overall.ipc
   1302291            -1.0%    1289647        perf-stat.overall.path-length
 5.297e+09           +17.2%  6.205e+09        perf-stat.ps.branch-instructions
  21150909           +11.4%   23557858        perf-stat.ps.branch-misses
   4378997           -33.3%    2922005        perf-stat.ps.cache-misses
  19589543 ±  2%     +12.0%   21940439        perf-stat.ps.cache-references
 2.831e+10           +17.2%  3.318e+10        perf-stat.ps.instructions
 8.581e+12           +17.3%  1.006e+13        perf-stat.total.instructions
     39.12            -1.2       37.93        perf-profile.calltrace.cycles-pp.inc_rlimit_get_ucounts.sig_get_ucounts.__send_signal_locked.do_send_sig_info.do_send_specific
     39.14            -1.2       37.95        perf-profile.calltrace.cycles-pp.sig_get_ucounts.__send_signal_locked.do_send_sig_info.do_send_specific.__x64_sys_tgkill
     39.54            -0.8       38.74        perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.__sigqueue_free.dequeue_signal.get_signal.arch_do_signal_or_restart
     39.55            -0.8       38.75        perf-profile.calltrace.cycles-pp.__sigqueue_free.dequeue_signal.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      0.54            +0.1        0.62        perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      0.60            +0.1        0.68        perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.72            +0.1        0.82        perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86            +0.1        0.99        perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      1.10            +0.1        1.23        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99            +0.1        1.13        perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.19 ± 22%      +0.2        1.43 ±  6%  perf-profile.calltrace.cycles-pp.idr_find.find_task_by_vpid.do_send_specific.__x64_sys_tgkill.do_syscall_64
      1.48 ±  4%      +0.3        1.75        perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.__send_signal_locked.do_send_sig_info
      1.75 ± 13%      +0.3        2.03 ±  2%  perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.57 ±  4%      +0.3        1.85        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.__send_signal_locked.do_send_sig_info.do_send_specific
      1.46 ±  5%      +0.3        1.75        perf-profile.calltrace.cycles-pp.refill_obj_stock.__memcg_slab_free_hook.kmem_cache_free.dequeue_signal.get_signal
      1.63 ±  4%      +0.3        1.93        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.__send_signal_locked.do_send_sig_info.do_send_specific.__x64_sys_tgkill
      1.55 ±  5%      +0.3        1.85        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.dequeue_signal.get_signal.arch_do_signal_or_restart
      1.62 ±  5%      +0.3        1.93        perf-profile.calltrace.cycles-pp.kmem_cache_free.dequeue_signal.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      4.87 ±  6%      +0.4        5.28 ±  3%  perf-profile.calltrace.cycles-pp.handler
      2.09            +0.5        2.60        perf-profile.calltrace.cycles-pp.recalc_sigpending.dequeue_signal.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      2.48            +0.7        3.13        perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.do_send_sig_info.do_send_specific.__x64_sys_tgkill
     39.12            -1.2       37.93        perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
     39.14            -1.2       37.95        perf-profile.children.cycles-pp.sig_get_ucounts
     39.55            -0.8       38.74        perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
     39.56            -0.8       38.76        perf-profile.children.cycles-pp.__sigqueue_free
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__get_user_8
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__put_user_8
      0.07 ±  5%      +0.0        0.08        perf-profile.children.cycles-pp.mod_objcg_state
      0.13 ±  3%      +0.0        0.14        perf-profile.children.cycles-pp.restore_altstack
      0.13 ±  2%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.15            +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.check_xstate_in_sigframe
      0.11            +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.14 ±  2%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.14            +0.0        0.16        perf-profile.children.cycles-pp.rseq_ip_fixup
      0.12            +0.0        0.14        perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.17            +0.0        0.19        perf-profile.children.cycles-pp._copy_from_user
      0.16            +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.__fpu_restore_sig
      0.16 ±  2%      +0.0        0.19        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.23 ±  2%      +0.0        0.26        perf-profile.children.cycles-pp.save_xstate_epilog
      0.23            +0.0        0.27        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.shmem_write_end
      0.35            +0.1        0.40        perf-profile.children.cycles-pp.__restore_fpregs_from_user
      0.44 ±  3%      +0.1        0.49 ±  2%  perf-profile.children.cycles-pp.__getpid
      0.43            +0.1        0.49        perf-profile.children.cycles-pp.restore_fpregs_from_user
      0.60            +0.1        0.68        perf-profile.children.cycles-pp.fpu__restore_sig
      0.55            +0.1        0.63        perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.91 ±  7%      +0.1        1.01 ±  5%  perf-profile.children.cycles-pp.find_task_by_vpid
      0.72            +0.1        0.82        perf-profile.children.cycles-pp.restore_sigcontext
      0.88            +0.1        1.00        perf-profile.children.cycles-pp.get_sigframe
      1.12            +0.1        1.25        perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      1.00            +0.1        1.14        perf-profile.children.cycles-pp.x64_setup_rt_frame
      1.84 ±  2%      +0.2        2.04 ±  2%  perf-profile.children.cycles-pp.handle_signal
      1.48 ±  4%      +0.3        1.75        perf-profile.children.cycles-pp.obj_cgroup_charge
      1.58 ±  4%      +0.3        1.86        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      1.46 ±  5%      +0.3        1.75        perf-profile.children.cycles-pp.refill_obj_stock
      1.64 ±  4%      +0.3        1.93        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.56 ±  5%      +0.3        1.86        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      1.62 ±  4%      +0.3        1.94        perf-profile.children.cycles-pp.kmem_cache_free
      2.17            +0.5        2.68        perf-profile.children.cycles-pp.recalc_sigpending
      2.48            +0.6        3.13        perf-profile.children.cycles-pp.complete_signal
     39.12            -1.2       37.93        perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
     39.55            -0.8       38.74        perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      0.35 ± 17%      -0.2        0.13 ± 10%  perf-profile.self.cycles-pp.handler
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__put_user_8
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.x64_sys_call
      0.07            +0.0        0.08        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.09            +0.0        0.10        perf-profile.self.cycles-pp.check_xstate_in_sigframe
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.mod_objcg_state
      0.08            +0.0        0.09        perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.11 ±  3%      +0.0        0.12        perf-profile.self.cycles-pp.__get_user_nocheck_4
      0.12 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.08 ±  4%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.get_sigframe
      0.09 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.save_xstate_epilog
      0.11 ±  3%      +0.0        0.13        perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.04 ± 44%      +0.0        0.06        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.12 ±  4%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      0.13            +0.0        0.15        perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.13            +0.0        0.15        perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.17            +0.0        0.19        perf-profile.self.cycles-pp._copy_from_user
      0.15            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.27            +0.0        0.30        perf-profile.self.cycles-pp.fpu__clear_user_states
      0.25 ±  2%      +0.0        0.29        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.35            +0.0        0.40        perf-profile.self.cycles-pp.__restore_fpregs_from_user
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.shmem_write_end
      0.42            +0.1        0.49        perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.62 ±  7%      +0.1        0.72 ±  5%  perf-profile.self.cycles-pp.find_task_by_vpid
      1.48 ±  4%      +0.3        1.75        perf-profile.self.cycles-pp.obj_cgroup_charge
      1.46 ±  5%      +0.3        1.75        perf-profile.self.cycles-pp.refill_obj_stock
      2.16            +0.5        2.67        perf-profile.self.cycles-pp.recalc_sigpending
      2.42            +0.6        3.06        perf-profile.self.cycles-pp.complete_signal


***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/usersyscall/stress-ng/60s

commit: 
  a13ae432a6 ("x86/resctrl: Use schema type to determine how to parse schema values")
  0021800a46 ("x86/resctrl: Use schema type to determine the schema format string")

a13ae432a665d1d0 0021800a465d495a536265c52f8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.02 ±  5%      -0.0        0.02 ±  3%  mpstat.cpu.all.soft%
    695763 ± 21%     -28.4%     498121 ± 16%  numa-numastat.node1.local_node
      7622 ± 17%     -51.6%       3685 ± 20%  perf-c2c.DRAM.remote
      6750 ± 17%     -55.3%       3017 ± 20%  perf-c2c.HITM.remote
     32475           -15.5%      27453        stress-ng.usersyscall.nanosecs_per_syscall
 1.974e+08           +18.0%  2.329e+08        stress-ng.usersyscall.ops
   3290068           +18.0%    3881749        stress-ng.usersyscall.ops_per_sec
      0.17 ±  5%     -35.2%       0.11 ±  4%  perf-stat.i.MPKI
 6.367e+09           +16.5%  7.419e+09        perf-stat.i.branch-instructions
  53883753 ±  3%     +14.1%   61459248 ±  3%  perf-stat.i.branch-misses
     23.59 ±  4%      -8.8       14.78 ±  3%  perf-stat.i.cache-miss-rate%
   5618447 ±  5%     -27.6%    4069538 ±  5%  perf-stat.i.cache-misses
  22477865 ±  2%      +8.1%   24292780        perf-stat.i.cache-references
     19.10           -14.2%      16.40        perf-stat.i.cpi
    136147 ±  4%     +51.5%     206276 ±  4%  perf-stat.i.cycles-between-cache-misses
 3.331e+10           +16.7%  3.886e+10        perf-stat.i.instructions
      0.06           +15.8%       0.06        perf-stat.i.ipc
      0.17 ±  5%     -38.0%       0.10 ±  4%  perf-stat.overall.MPKI
     24.72 ±  4%      -8.2       16.49 ±  3%  perf-stat.overall.cache-miss-rate%
     19.15           -14.0%      16.47        perf-stat.overall.cpi
    116330 ±  5%     +38.6%     161261 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.05           +16.3%       0.06        perf-stat.overall.ipc
 6.243e+09           +16.3%   7.26e+09        perf-stat.ps.branch-instructions
  52388076 ±  3%     +14.0%   59726018 ±  3%  perf-stat.ps.branch-misses
   5393246 ±  5%     -27.8%    3891345 ±  4%  perf-stat.ps.cache-misses
  21817868 ±  2%      +8.2%   23596167        perf-stat.ps.cache-references
 3.267e+10           +16.4%  3.804e+10        perf-stat.ps.instructions
 2.007e+12           +16.5%  2.339e+12        perf-stat.total.instructions
      1.23 ± 35%     -67.7%       0.40 ±101%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      1.78 ± 14%     -70.7%       0.52 ±138%  perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_pte_missing.__handle_mm_fault
      0.33 ± 80%     -69.4%       0.10 ±131%  perf-sched.sch_delay.avg.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      2.56 ± 24%     -69.6%       0.78 ± 80%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
      0.57 ± 58%     -56.2%       0.25 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.53 ± 12%     -51.6%       1.23 ± 51%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      1.67 ± 21%     +53.0%       2.56 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.67 ±167%     -99.2%       0.01 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      0.29 ± 38%     -85.7%       0.04 ± 92%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.02 ± 16%     +45.6%       0.03 ± 26%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 36%     -48.0%       0.02 ± 16%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.04 ±  4%     -19.5%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.83           -31.6%       1.94 ± 33%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      2.43 ± 29%     -54.1%       1.12 ± 76%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pmd_alloc
      1.87 ±  9%     -63.2%       0.69 ±112%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      5.07 ± 12%     -62.3%       1.91 ± 85%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
    367.03 ±138%     -98.5%       5.38 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      4.00 ±  9%     -44.5%       2.22 ± 55%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      3.99           -21.6%       3.13 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      7.04 ±199%     -99.8%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
      1.19 ± 40%     -84.8%       0.18 ±174%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      4.01           -74.9%       1.01 ±150%  perf-sched.sch_delay.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     21.67 ±141%     -96.6%       0.73 ± 54%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    757.83 ± 60%     -51.4%     368.37 ±127%  perf-sched.total_sch_delay.max.ms
      4.53 ± 12%     -23.3%       3.47 ± 12%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      7.40 ± 16%     -28.8%       5.27 ± 28%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.96 ±  9%     -18.6%       3.22 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2.51 ± 12%     -57.6%       1.06 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      1.67 ± 21%     +53.0%       2.56 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.67 ±167%     -99.2%       0.01 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
     59.25 ±208%     -98.3%       1.00 ±152%  perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      6.89 ± 17%     -30.8%       4.76 ± 31%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    447.08 ±  4%      -7.0%     415.80 ±  5%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.45 ±  9%     -18.8%       2.80 ±  9%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.78 ±  2%     -33.6%       1.84 ± 34%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1.87 ±  9%     -63.2%       0.69 ±112%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.__pud_alloc
      4.00 ±  9%     -45.6%       2.18 ± 57%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      3.99           -21.6%       3.13 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      7.04 ±199%     -99.8%       0.01 ±223%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
    170.02 ±218%     -99.4%       1.00 ±152%  perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
     37.94            -1.1       36.80        perf-profile.calltrace.cycles-pp.__sigqueue_free.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     37.92            -1.1       36.79        perf-profile.calltrace.cycles-pp.do_dec_rlimit_put_ucounts.__sigqueue_free.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
     40.38            -0.8       39.53        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.48 ±  3%      +0.2        1.66        perf-profile.calltrace.cycles-pp.refill_obj_stock.__memcg_slab_free_hook.kmem_cache_free.get_signal.arch_do_signal_or_restart
      1.41 ±  4%      +0.2        1.60 ±  3%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.__send_signal_locked.force_sig_info_to_task
      1.55 ±  3%      +0.2        1.75 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.__send_signal_locked.force_sig_info_to_task.syscall_user_dispatch
      1.58 ±  3%      +0.2        1.78        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      1.47 ±  3%      +0.2        1.67 ±  4%  perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.66 ±  3%      +0.2        1.87        perf-profile.calltrace.cycles-pp.kmem_cache_free.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      1.62 ±  3%      +0.2        1.84        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.__send_signal_locked.force_sig_info_to_task.syscall_user_dispatch.syscall_trace_enter
      1.66 ±  4%      +0.4        2.09 ±  6%  perf-profile.calltrace.cycles-pp.fpregs_mark_activate.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      2.39 ±  3%      +0.5        2.84 ±  3%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigsys_handler
      2.42 ±  4%      +0.5        2.87 ±  2%  perf-profile.calltrace.cycles-pp.complete_signal.__send_signal_locked.force_sig_info_to_task.syscall_user_dispatch.syscall_trace_enter
      1.96 ±  4%      +0.5        2.42 ±  5%  perf-profile.calltrace.cycles-pp.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      2.39 ±  3%      +0.5        2.85 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigsys_handler
      2.39 ±  3%      +0.5        2.85 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_sigsys_handler
      2.20 ±  3%      +0.5        2.67 ±  3%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_sigsys_handler
      6.00 ±  5%      +0.6        6.62        perf-profile.calltrace.cycles-pp.stress_sigsys_handler
      3.82 ±  3%      +0.7        4.53        perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.93            -1.1       36.78        perf-profile.children.cycles-pp.do_dec_rlimit_put_ucounts
     37.94            -1.1       36.81        perf-profile.children.cycles-pp.__sigqueue_free
     40.40            -0.8       39.56        perf-profile.children.cycles-pp.get_signal
      0.29 ±  6%      -0.0        0.24 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.28 ±  6%      -0.0        0.23 ±  7%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.41 ±  5%      -0.0        0.38 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.13 ±  3%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      0.18 ±  4%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp._copy_from_user
      0.18 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.check_xstate_in_sigframe
      0.16 ±  3%      +0.0        0.19        perf-profile.children.cycles-pp.__put_user_nocheck_4
      0.18 ±  2%      +0.0        0.21 ±  4%  perf-profile.children.cycles-pp.copy_siginfo_to_user
      0.31 ±  3%      +0.0        0.36 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.37 ±  2%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.__restore_fpregs_from_user
      0.44 ±  2%      +0.1        0.50        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.47 ±  3%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp.restore_fpregs_from_user
      0.70 ±  3%      +0.1        0.79 ±  4%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.69 ±  4%      +0.1        0.78 ±  4%  perf-profile.children.cycles-pp.fpu__restore_sig
      0.85 ±  5%      +0.1        0.95 ±  4%  perf-profile.children.cycles-pp.restore_sigcontext
      1.48 ±  3%      +0.2        1.66        perf-profile.children.cycles-pp.refill_obj_stock
      1.41 ±  4%      +0.2        1.60 ±  3%  perf-profile.children.cycles-pp.obj_cgroup_charge
      1.58 ±  3%      +0.2        1.78        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      1.55 ±  3%      +0.2        1.76 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      1.48 ±  3%      +0.2        1.69 ±  4%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      1.67 ±  3%      +0.2        1.88        perf-profile.children.cycles-pp.kmem_cache_free
      1.63 ±  3%      +0.2        1.84        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.73 ±  4%      +0.4        2.16 ±  6%  perf-profile.children.cycles-pp.fpregs_mark_activate
      2.42 ±  4%      +0.5        2.88 ±  2%  perf-profile.children.cycles-pp.complete_signal
      1.98 ±  4%      +0.5        2.44 ±  5%  perf-profile.children.cycles-pp.fpu__clear_user_states
      4.44 ±  4%      +0.5        4.93        perf-profile.children.cycles-pp.stress_sigsys_handler
      3.82 ±  3%      +0.7        4.54        perf-profile.children.cycles-pp.handle_signal
     37.92            -1.1       36.78        perf-profile.self.cycles-pp.do_dec_rlimit_put_ucounts
      0.26 ±  7%      -0.0        0.23 ±  8%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.13 ±  3%      +0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      0.09 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.copy_siginfo_to_user
      0.17 ±  5%      +0.0        0.19 ±  5%  perf-profile.self.cycles-pp.__get_user_nocheck_1
      0.18 ±  4%      +0.0        0.20 ±  5%  perf-profile.self.cycles-pp._copy_from_user
      0.15 ±  6%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      0.16 ±  3%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      0.22 ±  4%      +0.0        0.25 ±  2%  perf-profile.self.cycles-pp.prctl
      0.16 ±  2%      +0.0        0.19 ±  4%  perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.29 ±  3%      +0.0        0.32 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.30 ±  3%      +0.0        0.35        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.36 ±  2%      +0.1        0.42 ±  2%  perf-profile.self.cycles-pp.__restore_fpregs_from_user
      0.53 ±  2%      +0.1        0.60 ±  4%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      1.40 ±  4%      +0.2        1.59 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
      1.48 ±  3%      +0.2        1.66        perf-profile.self.cycles-pp.refill_obj_stock
      1.70 ±  4%      +0.4        2.13 ±  6%  perf-profile.self.cycles-pp.fpregs_mark_activate
      2.34 ±  4%      +0.5        2.79 ±  3%  perf-profile.self.cycles-pp.complete_signal





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


