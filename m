Return-Path: <linux-kernel+bounces-228607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B191622D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D79CB2468D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4901494D1;
	Tue, 25 Jun 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J51jSg59"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273491487D4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307143; cv=fail; b=ksCqU/qvSh6+/XPML58aOXViN0kT2MEYbNH7nUoobZk6b5LcvF24TMdp5GSDWZwzlxzO9xsBVLafwpTG7zzEqxIu7LY3D17VNSOT7W8cX9rU9N0hmY0xGhPMp8q8e4vdeiRMVxD7sXcouY+CapeRRE8xnRxtMp2+A8Z4cGxONkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307143; c=relaxed/simple;
	bh=8u3ewOaph9AtI9VtAUwSGUQmLfUn2gL8yDSASiFkl54=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ig71+NHzpHP7tV4Q6h4236wbRhEaYoVXBr/LU+hWOiZcm5GyJQB6cH5LaPBOV4eyN1Ge23+SKOkmMtBWDAwdecC77FasXpaxYSBIZprgX2eQRAkHfiJmAL+hou3l7PgW9EoNfBksGfOlumuZTkIeiuJQKM0oVixseLZQTTGnK9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J51jSg59; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719307141; x=1750843141;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8u3ewOaph9AtI9VtAUwSGUQmLfUn2gL8yDSASiFkl54=;
  b=J51jSg598t/nCzhLfK4YKVj9mklvBPbPj2qxBYffHnjYRiIzg2W2AFJr
   eRvsQJ4IgB76NsmvC31QKTSfYzvLysdNsV00ZAYV078LyoJ/bK8EVlQXA
   iyTAsQidZmfPeqtnFwimgGEkEjAr1ZWdOmhlSDp6eGVNFZf+GnhEVfiM3
   igjYryPh0B3qSg6W6c1aY19u20v44tz5sLLsiNd2mCWnAbiKWIxh9MDLK
   MJbbqluAQl96GDQqsb1fUhd20pkPq+tE2GkLyDpicEPwttdIYuThwC3oU
   MqeWCWJyReaZGshoBx/43mXprjUvZ6RPg0roGhhDnUt8B7qRvF48zALcG
   Q==;
X-CSE-ConnectionGUID: 36YIo6GsTVWYgwy+H4gzdg==
X-CSE-MsgGUID: 6ReEohm3QyCnbWQ/kqCypA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33848876"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33848876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 02:19:00 -0700
X-CSE-ConnectionGUID: JUKOf384Qd6tWCwaPsuW9Q==
X-CSE-MsgGUID: Mb91s9F9TDi9x5Klnqd6hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47969767"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 02:18:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 02:18:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 02:18:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 02:18:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hphg47tN2DpVZfPd8rPeDrTfGj1hpTV9cMUxsPhXXAwCoqhlyLv4/7MakmHW25bndjkxkr0jLuxOEhogOWh1wuceDIrI2yTx97WP4Ia9/i3zNJFaYWp71CcGl2eX602Jts9K7stZmJHf4O8seRShtqXmrNHN9rTWv14Fcxz+BBH5mFMI82ZyzmCwfcGLDpJr2H7PLB29tV/5HKn0K5fj3t0KvdcuIU6oQlNRfWJAZ5ARJI7yoVEoorCKIXKhcin3bQGcDbCUEyA78orVmvRHz/Vc8zk+CS4dYX/Y+w1QbxoLLXHcz5HdJ8v/6iHj8wZQVtN01uIcY5g2uSnAJIVjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zwhpXRnOmj5DR164Ee1GTdELCm4kZqg9L0RpksGgBg=;
 b=LqYHz7l4P0VVOd0zXulAuphQ/ie0j/5eotB/3vO7TSJ7+0ISW/HsPY3+qujDjrZffhOltM6PRRfFjsQvPyzONo1GXwvdM6eezdZoTjRyVpn1YaJHOWWcW8Mnhlxsrf1+oDmysxpWUHzWtO3zKyH2ZwzL9GRmUGeUdhaJv/7ZiQfi/FxKE/70x6AF/KhE+3lJ+aXSdHRqCI78DTzZCjgDyy+casbkIRwH4KdO8y83VoLVrrDuwRDAHc1fsEtlzl3QKY71DZSA/cLg+6tZx8aLZKLFU1jwHvaCLVPpFBcGOt4o1vvkpQ3yf+16l2mzjteXMj2s1vSXYd4bEwA3x2/rKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6SPR01MB0112.namprd11.prod.outlook.com (2603:10b6:5:1ee::17)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Tue, 25 Jun
 2024 09:18:56 +0000
Received: from DM6SPR01MB0112.namprd11.prod.outlook.com
 ([fe80::eeb3:9971:7c9e:7523]) by DM6SPR01MB0112.namprd11.prod.outlook.com
 ([fe80::eeb3:9971:7c9e:7523%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 09:18:55 +0000
Date: Tue, 25 Jun 2024 17:19:27 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Marco Elver <elver@google.com>
CC: <andreyknvl@gmail.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is BUG: MAX_LOCKDEP_KEYS too low! in
 v6.10-rc5 kernel
Message-ID: <ZnqLnw1efH2k+7oD@xpf.sh.intel.com>
References: <ZnooRgso2Y6RKwp9@xpf.sh.intel.com>
 <CANpmjNPODYdQ0mdPCF5-K5wdWZdUdRhYKsxH7vtxokeQjiZHxw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANpmjNPODYdQ0mdPCF5-K5wdWZdUdRhYKsxH7vtxokeQjiZHxw@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To DM6SPR01MB0112.namprd11.prod.outlook.com
 (2603:10b6:5:1ee::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0112:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 54bad664-1fc2-4301-8fe0-08dc94f7d674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PeJvgzsxww3mkQdam/Ya5kHrg5/GTOaIMEienvtITM6hys1g5KcyzP7DBzsw?=
 =?us-ascii?Q?eXzIsML69iTVb3Z/eImDAXRooTiPo4v9FArErAFmI2tws9amEoY8eU372MjH?=
 =?us-ascii?Q?jNJlXv9FLvzuWykffhLNs5/XIo81d0g8tY7kLxUBkQfyZSg0kLo1aEOsbbhC?=
 =?us-ascii?Q?eNF/2S3ZacxV3LXVBto2ovwncO3jO+WvR9wfBfwsJpOpsNxKGPk5Ot3j+LCn?=
 =?us-ascii?Q?Wt6m0kOzJiNFAI5mcSwsvzdWO2zhvjNglJu4Zx42bUXKo4adtoUHH986gsuw?=
 =?us-ascii?Q?lmyfJaOiQz8w1rsvyXwxtiUv8fd5wel81OvkpCwBsqYjKySfBECJRp+ymzkT?=
 =?us-ascii?Q?62ADam/TPXBx3LFQli8b9Mq90tX+oC5NijbS9WKd5kiU50UAXJJeefytuzNW?=
 =?us-ascii?Q?W6Uibo58x2iFP+ncT0JKP0EnFANByB6qmvV21w0i2qqm1Mqa/TJybhDvdL8H?=
 =?us-ascii?Q?YScfS0XPPhyFi6HfX7A6d7LYHKBgPWsK5Zfcm7cSTGJjOQQPtW5AvizqW/TQ?=
 =?us-ascii?Q?hgCe3VhJ1qc0tQahe3rt2D3UZ5uyQZJe5hLHWzA9HLsmoizlCcHaiXVQbRh1?=
 =?us-ascii?Q?l+O3dSyi5AKgrdCZmsayzVbBOF3bGXWdS8u6wTgxuePOhGD8MFzzUlwbbFp1?=
 =?us-ascii?Q?1Oi/RHFX6zZ9azMAxPwTmiREiYq8FRE2r9qRqtZlfPAavex7xU1LafTSqGvD?=
 =?us-ascii?Q?yYsjC1S/4zQNzPCGLcCpGGXnS0+NVLDroTwGBmDRnjfZ9UAj+F7KwFYA39Cj?=
 =?us-ascii?Q?kvt+wBU6fa+pV9erlhTHg5EjyVcy7WKS/OIzYdqKhwLQtQI9M78+6K+60E58?=
 =?us-ascii?Q?X8OvaL5Mh4LZdvduZzMfV76ICvh2PgEEJVbMtJhbWs4tmaKz6ce0ybSV8QJn?=
 =?us-ascii?Q?QU93IVDnWnB8PumEU4tJGsvb6SOBLF48H4DiImIwjVW7J5D7HST3DKWby8yM?=
 =?us-ascii?Q?V/lucd2TOt4V92oqDTVuaMRiRo4vfj7XGeRALnWsdDOYME3j20TYNOCjMY/y?=
 =?us-ascii?Q?oUhAAbZxrtnxm5ivQz4jUbjAZypVpv5A9Y6gSHDsBkr9ejK+uzFjaqLN2IkV?=
 =?us-ascii?Q?KZh8BoO06ZtPGXuJkefcNsHm2xsUUKXUC39HedGvpnaMsZLT0j4yDBkqgcoH?=
 =?us-ascii?Q?iJI3x3dnY0vhOvdiXNa8FULx937784L6ZNcFJA3y6vi9HrY8GBZSAokg39MI?=
 =?us-ascii?Q?U58bvKPIDGWrif8VpMW9qoZlthwkn2lIQXkE5YoCh/g4sjOFF56dePWdF7sa?=
 =?us-ascii?Q?fqcfhgVbpRd9DkuiVu/m45Aa0A2nml30XY9WM0wvqf7srQj49DO+fjwmO3dQ?=
 =?us-ascii?Q?CdVLukA7EU4COMMKy7SGi+qo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6SPR01MB0112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Z8BojxvF0XSxSrKHdLIrGNXRH0zw7VUVXdmZ19ZsXWHuU5q3LcAJ1SJ33ZI?=
 =?us-ascii?Q?eg4pHJ3OWIsl2jUbdDifT1FS5We2xCiHNT/FDK/dUUgWNYhLqrRtORJN7Yia?=
 =?us-ascii?Q?SEOcHu1lIQmRWFGAhkMN+nGcuUPEzfx+fBlevF7Gx1o4yKWdkD6PImBk70jJ?=
 =?us-ascii?Q?TY4sA9Ka4q3Wzjab4r4H5FHBW04zUZAE3Gna+mcF49Y/g2e7xyVENZVHLdaW?=
 =?us-ascii?Q?1Pa/St4WMxpzV2PKAehUrXrq8QaWcw+Tv8UxFFtHv7lF7kfHrTRqBh/j9JQ2?=
 =?us-ascii?Q?k+IE+MKuO9xy2S7OeT4aEZCH4kqlXmkSvqEL2wdQllvU8fM1mZT288i/oGGW?=
 =?us-ascii?Q?Z3bP9XA+Pld0GuGmsd2dkg1l0skX1AZ2lW2CgKsoehooJ8dCpUizS4tYk/89?=
 =?us-ascii?Q?YsoiU/WtK0ae+mLDSyNWQVAwXAe0ttjf2gLFUK12yq/KJv4Jg3Nb8phP+ZjR?=
 =?us-ascii?Q?1QLeJk9PTDnuZePymrQk1THSi21kbcy7XNGL/KClLuKjV2ailN4DzbFfo+5F?=
 =?us-ascii?Q?a+CikDqt933jkpUUkgbkTSAia0OdmIynUe48D3vYOiICxthv0sIROKso6j5Z?=
 =?us-ascii?Q?+dqzyMWDpfLQ7MPuvjQLDvqA7DwK41JmSU4XzNFJjTS3m7OamSWr8BouURo+?=
 =?us-ascii?Q?Edc/oHYHo3ac3A5R+Ta8yGUbEK2W0i6hi29OFRbchvKMvUou8vEruZRWOS4T?=
 =?us-ascii?Q?PPNylTfWN45Mz23GYJ6M5YZUBtG9nDI68LOVDDsw8c/NXST9SdAL1pbArpcN?=
 =?us-ascii?Q?dy6Lhh0I3uP37Q7XNbQyVhzW3UEAA3UItBBVJS8kHvwhpEQnSZd0XkTqA1Wm?=
 =?us-ascii?Q?kyaQPYjJVi4UARI7TvPU6hucerPJzpfu0WqjXjm7j8xR/jtB/A6/dkfBX3a7?=
 =?us-ascii?Q?YCr0fAubSZo2QoLujTHCQhzb0gwKhnRtoh5EpaKiSgNwvhjOQFVsUUgAltCU?=
 =?us-ascii?Q?5zA2pZ5iO/Jq7snizY8clyHzRjMJNV2hx2OlwFgMvrtqidPP31khoyZho41e?=
 =?us-ascii?Q?jflp0OQnTPSl3Bqhypz5V/y8Hq0kRGnhAN5WElGm2Z1Nc0KljylsSBfbJwm0?=
 =?us-ascii?Q?uvTnR+waZQr+Bl5jQagu1jmK4Q/P23JSFeQGZ1O78PC+YOrcyxZcZdKOTv2S?=
 =?us-ascii?Q?FjO1RYQWRTs5+mlMhk+kIMtkDelYDUe3vWzLIYcprC9qHcmEFdS7dOoFnt05?=
 =?us-ascii?Q?sa/ypZ9YSTmxys7QB+yVnw6lgCNK0wZUPB4mwA/ZVwgQ6pRxv8+F8Nlkvi1V?=
 =?us-ascii?Q?akLGf36wsacpVFnemcrsCBWzMICVWz2+sVLWAhwwkGVc+gZ8hQHI5+4e7BFV?=
 =?us-ascii?Q?tnbdX2fd+LWpvvKHaBouAeYl0H2EIbfkqlyhqk60FbmaAvPtAEQ/68byY/2w?=
 =?us-ascii?Q?fcN0zV+Q2AcawYfPF4Mv6X3bsY4DeqayPnl3/6CBiI2KGD/savc6oW4opvTc?=
 =?us-ascii?Q?sywsDphByL1ppdivtikcgCDpJKOYuzlgROvA74jDZX7/j17+5wht9IPD9lx0?=
 =?us-ascii?Q?xOviG4SXTl3WdrrdwiwvOGih9eSdhleblfhrNh9RwpcBilxv8+vQ3DHhs+Ec?=
 =?us-ascii?Q?TYxXilWtnYNKtCT1csS0MteudSGEVlk7+o9PlUNl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bad664-1fc2-4301-8fe0-08dc94f7d674
X-MS-Exchange-CrossTenant-AuthSource: DM6SPR01MB0112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 09:18:55.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0c9Wkr6Yd1mUbWK0RJ01wexI5IvSycdc7NwyT8+E1w6hDcFkVU0ghDj+OQHEXRCJXyHdS8tmHnuanP8NhTRIVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
X-OriginatorOrg: intel.com

Hi Marco,

On 2024-06-25 at 10:21:57 +0200, Marco Elver wrote:
> On Tue, 25 Jun 2024 at 04:15, Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Andrey,
> >
> > Greeting!
> >
> > There is BUG: MAX_LOCKDEP_KEYS too low! in v6.10-rc5 kernel.
> >
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240624_120854__MAX_LOCKDEP_KEYS_too_low
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.c
> > Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.prog
> > Mount img: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/mount_0.gz
> > Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/repro.report
> > Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/bisect_info.log
> > v6.10-rc5 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240624_120854__MAX_LOCKDEP_KEYS_too_low/f2661062f16b2de5d7b6a5c42a9a5c96326b8454_dmesg.log
> >
> > Bisected and found related commit:
> > cc478e0b6bdf kasan: avoid resetting aux_lock
> 
> This is known to trigger on heavily instrumented kernels.
> 
> On syzbot we just increase CONFIG_LOCKDEP_BITS and friends [1]. See [2].
> 
> [1] https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/lockdep.yml
> [2] https://github.com/torvalds/linux/blob/55027e689933ba2e64f3d245fb1ff185b3e7fc81/lib/Kconfig.debug#L1505
> 
> I don't see it set in your config. You should probably enable it on
> heavily instrumented builds.

Thank you very much for your suggestion and link sharing for pointing me
towards the relevant configuration options.

I have updated the kernel configuration to set CONFIG_LOCKDEP_BITS=17 to
avoid such issues in the future. And I will take care some other kconfig
items like "CONFIG_LOCKDEP_CHAINS_BITS". I will try some other number for
CONFIG_LOCKDEP_BITS if it's necessary.
Thanks for your guidance and sorry for inconvenience.

Best Regards,
Thanks!

> 
> > "
> > [  157.974013] BUG: MAX_LOCKDEP_KEYS too low!
> > [  157.974233] turning off the locking correctness validator.
> > [  157.974459] CPU: 1 PID: 736 Comm: repro Tainted: G        W          6.10.0-rc5-f2661062f16b+ #1
> > [  157.974864] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [  157.975392] Call Trace:
> > [  157.975502]  <TASK>
> > [  157.975600]  dump_stack_lvl+0xea/0x150
> > [  157.975786]  dump_stack+0x19/0x20
> > [  157.975937]  register_lock_class+0xaee/0x10d0
> > [  157.976136]  ? __pfx_register_lock_class+0x10/0x10
> > [  157.976351]  ? __pfx_mark_lock.part.0+0x10/0x10
> > [  157.976553]  __lock_acquire+0xfe/0x5ca0
> > [  157.976727]  ? __pfx_mark_lock.part.0+0x10/0x10
> > [  157.976929]  ? __pfx_register_lock_class+0x10/0x10
> > [  157.977140]  ? __kasan_check_read+0x15/0x20
> > [  157.977325]  ? __pfx___lock_acquire+0x10/0x10
> > [  157.977517]  ? __kasan_check_read+0x15/0x20
> > [  157.977696]  ? mark_lock.part.0+0xf3/0x17a0
> > [  157.977878]  ? __kasan_check_read+0x15/0x20
> > [  157.978059]  lock_acquire+0x1ce/0x580
> > [  157.978221]  ? touch_wq_lockdep_map+0x75/0x130
> > [  157.978416]  ? register_lock_class+0xbf/0x10d0
> > [  157.978610]  ? __pfx_lock_acquire+0x10/0x10
> > [  157.978794]  ? __pfx_register_lock_class+0x10/0x10
> > [  157.979000]  ? lockdep_init_map_type+0x2df/0x810
> > [  157.979201]  ? lockdep_init_map_type+0x2df/0x810
> > [  157.979403]  ? touch_wq_lockdep_map+0x75/0x130
> > [  157.979598]  touch_wq_lockdep_map+0x8a/0x130
> > [  157.979786]  ? touch_wq_lockdep_map+0x75/0x130
> > [  157.979988]  __flush_workqueue+0xfd/0x1040
> > [  157.980164]  ? __this_cpu_preempt_check+0x21/0x30
> > [  157.980370]  ? lock_release+0x418/0x840
> > [  157.980542]  ? __pfx___flush_workqueue+0x10/0x10
> > [  157.980745]  ? __mutex_unlock_slowpath+0x16f/0x630
> > [  157.980979]  ? xfs_log_force+0x1db/0xa30
> > [  157.981191]  ? sync_filesystem+0x1e5/0x2a0
> > [  157.981386]  xlog_cil_push_now.isra.0+0x6c/0x210
> > [  157.981588]  xlog_cil_force_seq+0x1d4/0x790
> > [  157.981775]  ? __pfx_xlog_cil_force_seq+0x10/0x10
> > [  157.981982]  ? xfs_fs_sync_fs+0x1ed/0x3a0
> > [  157.982157]  ? debug_smp_processor_id+0x20/0x30
> > [  157.982358]  ? rcu_is_watching+0x19/0xc0
> > [  157.982532]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> > [  157.982767]  ? sync_filesystem+0x1e5/0x2a0
> > [  157.982944]  xfs_log_force+0x1db/0xa30
> > [  157.983109]  ? sync_filesystem+0x1e5/0x2a0
> > [  157.983287]  ? sync_filesystem+0x1e5/0x2a0
> > [  157.983464]  xfs_fs_sync_fs+0x1ed/0x3a0
> > [  157.983632]  ? __pfx_xfs_fs_sync_fs+0x10/0x10
> > [  157.983821]  sync_filesystem+0x1e5/0x2a0
> > [  157.983990]  generic_shutdown_super+0x8c/0x520
> > [  157.984183]  kill_block_super+0x45/0xa0
> > [  157.984349]  xfs_kill_sb+0x1e/0x60
> > [  157.984498]  deactivate_locked_super+0xcb/0x1c0
> > [  157.984694]  deactivate_super+0xc0/0xe0
> > [  157.984865]  cleanup_mnt+0x2fc/0x460
> > [  157.985023]  __cleanup_mnt+0x1f/0x30
> > [  157.985179]  task_work_run+0x19c/0x2b0
> > [  157.985343]  ? __pfx_task_work_run+0x10/0x10
> > [  157.985528]  ? __this_cpu_preempt_check+0x21/0x30
> > [  157.985734]  ? syscall_exit_to_user_mode+0x109/0x200
> > [  157.985951]  syscall_exit_to_user_mode+0x1ec/0x200
> > [  157.986160]  do_syscall_64+0x79/0x140
> > [  157.986322]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  157.986536] RIP: 0033:0x7fab3634e87b
> > [  157.986692] Code: 0f 1e fa 48 89 fe 31 ff e9 72 08 00 00 66 90 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 71 b5 0a 00 f7 d8
> > [  157.987430] RSP: 002b:00007ffc181e2598 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
> > [  157.987742] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fab3634e87b
> > [  157.988031] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffc181e2640
> > [  157.988321] RBP: 00007ffc181e3680 R08: 0000000000000000 R09: 00007ffc181e2430
> > [  157.988611] R10: 00007fab363b13e0 R11: 0000000000000202 R12: 00007ffc181e37f8
> > [  157.988761] XFS (loop7): Ending clean mount
> > [  157.988901] R13: 0000000000403138 R14: 000000000040fe08 R15: 00007fab36460000
> > [  157.989407]  </TASK>
> > "
> >
> > I hope it's helpful.
> >
> > Thanks!
> >

