Return-Path: <linux-kernel+bounces-248496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2C92DE13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273F6B21BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA718F66;
	Thu, 11 Jul 2024 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYkFOHiv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B323CE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661953; cv=fail; b=SHJBx4hPTnwIZGbJHnKqo9S1WkAAF+B7UkUK6Jj+RGjhgR1h+rvuw4V61kR3X5OnCwXMTTicWZrm4HA99cPHPs9zxJFS+A7TM3APviQ2FPQzBrHn4ZcqunR8LIrhx7Hj94bjUIEtfNh090zrXgeg5S5JEzQXrsvrw81D2eyxRiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661953; c=relaxed/simple;
	bh=VeijzQTScSr5uMcCCJH5ugVWkO6IIZKPmgpsHpxPVOs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G5IruCYzMAAaA5as9h/0WF84WcaYzUueRikSpHNUkwh1wQj6xu73pj1kV6AkLOcamBZpLvUH0R1azQFyGe25N9UnljDq5Hg08VG316P5c8Frp8dz6ppaLYHKTcNDCam8BCCRkwUagUrsT6nzjYv2+mbL5PQgyMvosqGSTGmBMX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYkFOHiv; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720661952; x=1752197952;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VeijzQTScSr5uMcCCJH5ugVWkO6IIZKPmgpsHpxPVOs=;
  b=RYkFOHivY8ycL9eIA8/3ZNTriN6JvOv9CrXHRvy6+EHHPkTAHwZZvpdk
   rvE453Gcz5ffeglf4R8fscJuErLBoh+CoWpw9fTWmrGCXok9KC2FgcPPe
   K7eZeX2vk4jYoOiKOa6E7JFg4LtVUZU73NTAeZJsXGXABxvAgq07seFFl
   Pg+2qwhSFRzs+Jy/E+tqG0b1UzW9KA9lNqDrKk+3Jsg02rlTvkE65ehUw
   PeQMFVpJD+ywRUoF7lys9AwN01gk519PsMf0nbgwrvMB4VXopzSI7d2wT
   XwitxqEyO9xgBnlL/vU0DtjGJxhbuY7AE6SxwNGdk5wJE+lv/kz5+Z6tT
   w==;
X-CSE-ConnectionGUID: Hmln5PNDTXiwRVX1bfKSdQ==
X-CSE-MsgGUID: qZW0oY4URBeejeWrb8uyVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29423541"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29423541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 18:39:11 -0700
X-CSE-ConnectionGUID: m3w08/nkT4WinOJWtmrV0A==
X-CSE-MsgGUID: U11d/8AQT1a3mOKfPXg5/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="79535533"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 18:39:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 18:39:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 18:39:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 18:39:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g14TeiS4GnQDwBdSDnZdU4zMspeaEDZT2J2Y6WW2q4DbKo3uod+rAS24hF1EwkK2ZZ+Z+eDaFdXzFlgDCT5+Cf9pCJc0j4Qhkq69+mMKULrPtibntXv9EDKCmXw3cM/DPYr67+wvQGS4nevas41+wjm9yK3JtRDkqmS2tm8yS01i6ynpPcsqbzJG8WtWeI+GRj/Dk62cswzTXC/aM6wEXrNPrwDcZ4gpuksfVH1dToCLnFCFw3E/euZNU3C3TwBsIwIdFDZ5925WiaWvX22ERclaP9iR/vGTkQmFC5bYYW8sXOfY8zhOJ/67oT/SVuiQq86r1tuD2vdYh5qsJBsI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4ip7xnsvijsP4ofRbWAr8G+zurlo9/CNQwTnYEnqqM=;
 b=hYBO0efPBYD5URsDYTBA1pn7Ylql7RHGhzPHG3rPW4K9YlCtKRoehnHv5lYl5GYdwe0fyAXUK9BCX1/VqpfK1s9g8OfHVNfrXzRKYAiWxlIqiIF9RcQF297SVLgnzzYqcvM3KbnJVoOTn1Wewced1nguxzUq4D8bYF9o3+aENEgQSsXjV0GnsYo9DZMR+onoRvREnNmPd8Es/tM+HXZKc7D9wIG3+9Q6fVOkFmhf1/dcXwi8x5H5/z7Izg02KtE6/s3/owXwsLgACtbJcU0nI7MCvDDRMtlkxsLtu/x9JBAfZpEk+CrZWY/c7dckYyw127hRvIffEvzD8Z/+Z669nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 01:39:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 01:39:05 +0000
Date: Thu, 11 Jul 2024 09:38:55 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Nikunj A Dadhania <nikunj@amd.com>, Ashish Kalra
	<ashish.kalra@amd.com>, <oliver.sang@intel.com>
Subject: Re: [tip:x86/sev] [x86/sev]  06685975c2:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <Zo83r9vQYpthWd4n@xsang-OptiPlex-9020>
References: <202407091342.46d7dbb-oliver.sang@intel.com>
 <20240709090323.GAZoz822G64Mr9M9lV@fat_crate.local>
 <Zo3oOK6RH2OJO3rC@xsang-OptiPlex-9020>
 <20240710082838.GBZo5GNvuxJbTjG1TZ@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710082838.GBZo5GNvuxJbTjG1TZ@fat_crate.local>
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aaef17b-33d9-4928-2d6c-08dca14a3fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xJ/hprySKHj9R5HxbuTG0/npXfnZP1XwBwsYAAscnYviUw87ybXZ7sttW3VC?=
 =?us-ascii?Q?dGPu6xc5tEo+41gJbAg3O+rbPCribtTJzl3sZ6bpWO7AZ8aJuOHfHkz+kvHq?=
 =?us-ascii?Q?qoqOMZHoawaQJQpjOL/pAYSxuxgp9qjTQkATR0D+Yq2VQPq3ef6gV7r1LKmj?=
 =?us-ascii?Q?UJntnINqd2i2HMjP1Bca1YdOcsOl/CyXSpuhnsYr31mByBRlm7J8ceAC2vfh?=
 =?us-ascii?Q?4uRXQGc3EcyzsMJUv1m7xZXdYrgW7d9gjgysX176iy7SQbjIvAI2ZkUfNT5C?=
 =?us-ascii?Q?2LALHhtaHRKLz9cysJhJBmachDVMfCdA1r3qPQeQg4vg7GrxwjLnx5powEj6?=
 =?us-ascii?Q?UmnBGh6Z26PBe47vMtuwKPaesKNwg7c1OtqCm1+fz80VImhMnpSbd+pW2Kw4?=
 =?us-ascii?Q?dl1VjKSb6+NtNk/vwuz7Jg7tO6rL43zsmeUnuyZX90zBFROSQytVv4AAcsr3?=
 =?us-ascii?Q?zAi2l6RfnUnf/rsVXcf/DqqjXAIwTYofA5EOV3pusTskZVrXYEZUZLYiVUMA?=
 =?us-ascii?Q?+l9a9Wdp1iw3lhdcnqJAejKNaC0BoxL90xZRCmsnSnMja8MZQqSy5E+qwPUD?=
 =?us-ascii?Q?2TCbFR7KSBE2Rv4paje0/hP6eJtw/nA36b1W2erl4uG7WFkbJCtGdupbsOI3?=
 =?us-ascii?Q?OsfkWx7ytZPag6gTY9QviNocExM7eW/ffNbXEHZppM+MUTfmIXV8VkzvaxYl?=
 =?us-ascii?Q?TTsFoRT7x4EJgXT7y6BMp7+/naenJD/VllfWbffPIXN8VG+oDGN2IpteJI8B?=
 =?us-ascii?Q?IkAOuAdQ0rYHrgi8kqXhRpXuGPGYDDyGmQqYwkaDDCZIdwbIepvuB0Iw8OuJ?=
 =?us-ascii?Q?CttajNWnSjDbQsqimMzdi0DUY0Ur/olngMjTO7sbKZc/0uVatx8HaNoxYHFz?=
 =?us-ascii?Q?NrvGXCvvL7LI2WuI3013ejX63lv9nBALxjMSocMdrQN1mofHW0GTBkYoe1ou?=
 =?us-ascii?Q?439u885pae20tRUP/V22GthREdj+9qVUM82CkNJAfGLTo7Pz0u0T28fpitsM?=
 =?us-ascii?Q?UozJwcFpVX/9qgqvODDK2EmKqiwWMkDm/i/e61g/ZNkOh9TODuIzUYPE4y9h?=
 =?us-ascii?Q?fWeinjfSUFtYNIb4gAA/veUiW0Zx2IvKui/OZIXX8/J4JZE0qRC/YxEREAmO?=
 =?us-ascii?Q?geMOHWkqcitqvIRTHMBEr6tpGF09Apzq/ySK1iIxZGjWqYeLYa/Unhs8YurM?=
 =?us-ascii?Q?036U6lPmZyp5yW+JMJgbzOWEKP4Y/spVdtZZeIwCYKvNcMv08vgnXuRq3ZNp?=
 =?us-ascii?Q?/DiaszaODaY3yHq0xXB/+ztIYZXtO/noUDkfXxnZeLaYC7WGImfYFJNAppZF?=
 =?us-ascii?Q?sRE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?faIgNMBSMME4QEJHJt0R5B//8pgjteK1JXO2tWV3nPOLqDya2vDDsRlK+sFQ?=
 =?us-ascii?Q?eAcbUyNkIV4Zx6N4KIe4muDZAS8QdoYBhE6b5jqxl2osJ8f0lpaRcdwfqKFb?=
 =?us-ascii?Q?LJcCjrGG6PjiWJcxL/6D+e2Khq1aC0/lN2W3PS2I4bP5tApUS1SQwSS5Erh4?=
 =?us-ascii?Q?0V8PKhjpJa70X02m6slp0ui3F0yAib5lTtn2bEhuUVryXRJL83Df5lWwZ/s7?=
 =?us-ascii?Q?gYDe34bhLMAhsrvwWqFku9Y79z30Pe55PcmO4lxnWlvEs5vZLwkm+wZ8a5EE?=
 =?us-ascii?Q?pNXnU80XppJdT3goT/Cah4IdK2Eq29cxgDACVmJMkIpn4e3G/o7MLfzWtTGF?=
 =?us-ascii?Q?01i0Nv0oM2tD17ovb+L2HgdMkPawtVUX9ZLh6uUvMhm/KL4OEkKAZqiEvYnC?=
 =?us-ascii?Q?pniCLyWKfDep6HKFYr6kU+1+By/XzrQkOazKz/LqpnfPVsXvk9RXf2eZNd5V?=
 =?us-ascii?Q?kv8R44ytVCTS5PovCSyj/iRumqXuV/FohEX3mQn0SBfxWKYMUV54k15LnRqQ?=
 =?us-ascii?Q?sJUjZdLV1yH4RZepaYMOFJsPAf3Q4ZQGkInrqRmThl7rXzNET/IyWUY8IiJI?=
 =?us-ascii?Q?EFiHBlHu4ZDlI9n08HKGQ3iHvsVr+o2gPo1M6Zd/7aso+cjchS7V7rlBZVUC?=
 =?us-ascii?Q?FD7em07JsboRQtahd+5pEBqJ3Wzk/rTXTr3dAfbxtQ+Bwv2z2KKMOuC3CopT?=
 =?us-ascii?Q?7qT6/Pzy9Kx1QvSNiU4NP7sDkEg+BRfSlPHdezJOEK8bPlvaRTsUaR0laYa5?=
 =?us-ascii?Q?CTvntIYe+W00p2vfHotxlmTZ0NxyHXyCJDhcudCDRHcf8HaUl+gUOv1AQ/3n?=
 =?us-ascii?Q?NL0rRoSCvfA266hQFNHpZDOvbRrvjinqSGMDztRCF2EUNPya1orUl/K7A6vx?=
 =?us-ascii?Q?KOQNXO6z4nMcvZJQBo676f/yJ13sJSgF4wlDHU1BQqOc/7mCtup5PZj+hnF4?=
 =?us-ascii?Q?TGevfHutL1sLSTphS8rHlhCzd7IGdmkTeZdk3Tw2YuwZEGdUw8Sm0OqWQU8v?=
 =?us-ascii?Q?ygdNpauufCyCreFz9YY4r4b8oX6LZvMr4ZS7MO7AEZzwcWDh4A6NYnLvvHlf?=
 =?us-ascii?Q?j66732Cz0azvNK4BK8hALTeZCh55crhCbzTMm91bRF0hDJvKcxBUg3o60Kup?=
 =?us-ascii?Q?yz6SlIzyy8KwlEQuUGKcTPX+5oDdI1YgUlUxcx3FAUtfSDSd1RzQG9NqX1ds?=
 =?us-ascii?Q?42LKZSbgpqUjthuMejjGBnW7+7IE9iMC/xjxnqhx6ITGTPQ+HqlcIip3Crb5?=
 =?us-ascii?Q?MEjqE45pgywC9ZbTf7e+QJSRGbCcUTKmvOauXJXZH2qrQdqOoB//UyplXcSs?=
 =?us-ascii?Q?+66FoTPKSpKR2OXZsNi+uM0cqTPygyz8YX8jgYGLGwVxh4oYxgGTM3UuYPRX?=
 =?us-ascii?Q?xpppF7y9sAucvtDdgQEzVgCKu+1yGvWqkHR45FIa5gAF8j+7sTb4xTArpl/L?=
 =?us-ascii?Q?5Xg/MAgXYtW5SRUo6HdjLQsZwlAE87XFc2k7lapfAdA7jNCwjSFobE5O83d6?=
 =?us-ascii?Q?CPNBIL4eoySFXksWP1r4JMksY/wedJENsYeC/DK0nU+dEE6Y6OsT9Zge6zx4?=
 =?us-ascii?Q?fX+5WtxXgi81ONfAn00B2ZHwSBsONDPdTMNSkR+5Z63+sOAvgPpbVN/XNOSN?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaef17b-33d9-4928-2d6c-08dca14a3fe2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 01:39:05.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cmNsKbONNtW/bNutvXDokCS5gst/ppZZqrfvyJ1I+QJ4YYWTawVNgQHRj9SUspPjhRMIPZtkSGmdXI85URhYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com

hi, Boris,

On Wed, Jul 10, 2024 at 10:28:38AM +0200, Borislav Petkov wrote:
> On Wed, Jul 10, 2024 at 09:47:36AM +0800, Oliver Sang wrote:
> > no. when this bisect done, we tested the branch tip 8434cf006ceae,
> > the issue is still persistent.
> 
> Ok, I think that should fix it:

yes, your patch fixed the issue.

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Wed, 10 Jul 2024 10:16:18 +0200
> Subject: [PATCH] x86/coco/sev: Disable KCSAN too
> 
> The SEV guest code was moved to x86/coco/ along with the instrumentation
> exclusion bits. However, there is a blanket KCSAN disable in
> arch/x86/kernel/Makefile due to boot hangs.
> 
> Copy that disable to the coco's sev Makefile too.
> 
> Fixes:  Fixes: 06685975c209 ("x86/sev: Move SEV compilation units")
> Closes: https://lore.kernel.org/oe-lkp/202407091342.46d7dbb-oliver.sang@intel.com
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/coco/sev/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
> index 5f72e92b37ff..4e375e7305ac 100644
> --- a/arch/x86/coco/sev/Makefile
> +++ b/arch/x86/coco/sev/Makefile
> @@ -9,3 +9,7 @@ endif
>  KASAN_SANITIZE_core.o	:= n
>  KMSAN_SANITIZE_core.o	:= n
>  KCOV_INSTRUMENT_core.o	:= n
> +
> +# With some compiler versions the generated code results in boot hangs, caused
> +# by several compilation units. To be safe, disable all instrumentation.
> +KCSAN_SANITIZE		:= n
> -- 
> 2.43.0
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

