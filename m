Return-Path: <linux-kernel+bounces-558744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D73A5EA6E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D56172C26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE513B29B;
	Thu, 13 Mar 2025 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBMgz27e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C386338
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839069; cv=fail; b=OvtHSIgWX19c5D3yQndJZ7Rc4TsJiaOTVe++mlpdrN3Ypsv+/oGEmvb5G0rKd6iFsN+x22L4aoO7TlaJ6uMwgyCI9WVepgOqAi5Gibrw5pKefRUCSfJp0ZIZS5rlxmXBvCecAi62quu6D2VsM6ouKhTGd3q3chQyA4kErNNXDpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839069; c=relaxed/simple;
	bh=Dli5cN8HLpdH4GOpN44C2BdgOp44qkeWmFWO1y3hCgE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pb0rISqerLJ/wPtbQCDP2Wcw8MJLrgiJVs9Uj1cIA+LZwPThX89OcUDxeafWR9JLZSnkPHieBnKJk78ZQXcLqMN+QYaQm0CNb40rBLHRVBTHLKeN+/l3UHlc2nHtByq6YiL8I6PK9hKF1GOomxMrYIkJTWvYm5vg8pLpnyx7EAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBMgz27e; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741839068; x=1773375068;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Dli5cN8HLpdH4GOpN44C2BdgOp44qkeWmFWO1y3hCgE=;
  b=CBMgz27e6NU5unub+LTDLiYqwn6YsktelzP04k/AZSA0siVluWC6Kol2
   C2P8jKCVwXKQSauVkiY+vBgy7lrQiiW62EOBpaheM05C4AdjnNA/rJlpt
   IxTl5IADhr8o/gXQzcqUEasdhfZGCjE2v2s2C6XJ1VbCmjF8kbsQowfGZ
   KDyeA9ruYbO+zWw1ytfQTEQC6CtoqVpL+zWm0JP3r39tT64LD8Slv7JG7
   R0z3NlNiXt5rItbeZADzwkcUWtPLSlZDjjS4DrAR9HAv9vwEzUyQlu34d
   akeJa+EjbRC20V7UFCNIP077WOXFyQM+nyEq0Z7RT4ulZZcG9+6ZVjKwe
   A==;
X-CSE-ConnectionGUID: Z/a7CeY4TyasX9mu1C622A==
X-CSE-MsgGUID: In+AyIOlT8W/Xq1wWv9i5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43073750"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="43073750"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 21:11:07 -0700
X-CSE-ConnectionGUID: 0QDilnA0SH63kevqCH9+sQ==
X-CSE-MsgGUID: 1w18sqY/Qua0X6MwL7rVZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="121326328"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 21:11:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 21:11:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 21:11:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 21:11:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8YLeSTF17oujcN3Sk+hebRnvHXBlTeGwS0WplX/Eami3nHwJsAVKufwn5DoyXgmBpZSVpUiHRPFi3irvMOP7Fh+vNTMrTizNzo4xqjY6LALru3qWcrf1insuhxGLGbJPDQkMPsXeV/+bKLfIt4IbbrwxfxaSvBhMRnd8Rne8vyJekg2qRi5qsU2Hq1AV6bOmsKvYVi97TPHoKYA6tbaaBCqf4Fp786Z9+v+/SWqhjDNnV5ypzCZHJsnMtsEzEfKyL0H0zqO+DJeT45i0SAXuCkBcPvTeRnFbv1bejyOtoEJ9jTPUHaXJGmwA/dts6x5+j+TDISfqA11q6Tigb0uZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dli5cN8HLpdH4GOpN44C2BdgOp44qkeWmFWO1y3hCgE=;
 b=EpRafmn1/WO6sMCCzhmJwQh2fn7oNiH0Lp9xaXZe9rRxDPq3weMcDkJF5by7PRu8OkbEl/jfkEhzhZqD3ycxQwQGU8yUXRu3TcczkUCDEHoIWnN+RXVpD6S/sU11Eaajesba9BXorfD25RtGC4oi1T3jP+X/4SmYGBWulNOkJwdJJYUDJbJ4tTBfEswcOmr+eO7fKaFs8dnQIc9fKjML5aKrFJ1msaT23W7qJbF3PPbJs1dLfXaExeVbHCzpRfLREhiXC8IQA7M61dQgWbTSGtKOSOdJPRpQ2Ar3XlNkq1G/OgqlwzIoGhaNBeilq5UeHpagn+xQvGsYfS/Zkc42UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9)
 by DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 04:10:50 +0000
Received: from MN0PR11MB6135.namprd11.prod.outlook.com
 ([fe80::3225:d4ad:74a:6d7a]) by MN0PR11MB6135.namprd11.prod.outlook.com
 ([fe80::3225:d4ad:74a:6d7a%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 04:10:50 +0000
Date: Wed, 12 Mar 2025 23:10:44 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <mailhol.vincent@wanadoo.fr>
CC: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Jani Nikula <jani.nikula@linux.intel.com>,
	"Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Andi
 Shyti" <andi.shyti@linux.intel.com>, David Laight <David.Laight@aculab.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 7/7] test_bits: add tests for BIT_U*()
Message-ID: <xtbwpcwd37n62zbqifnpxa2xcwylkzvebyegrebuquvbgfztes@oy5k4op5lhn3>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
X-ClientProxiedBy: MW4PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:303:83::23) To MN0PR11MB6135.namprd11.prod.outlook.com
 (2603:10b6:208:3c9::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6135:EE_|DS0PR11MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: cc67e5af-b448-473f-fd35-08dd61e50a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hpdGyDJC8VfzTB8/0eq9jp+vWw2ztg+mQM8mrseZZ49b4y0N7z/nIMfQRPLj?=
 =?us-ascii?Q?vrZ0mplYxsN0750Y2+psRBNlFV0cS9nqXBUAJycee7U150tIc4ab9Tm4yuHK?=
 =?us-ascii?Q?3Q1O2clgorcE/AMz19aknTMTnzj22x3ALAUYouEu0AH9p8iNM4CF4dC9YYIO?=
 =?us-ascii?Q?ljKl6CfHKwbVhleegkoceV+rvxUWtY+/kNUtLSNIRCvgZ5vo+jy8R4P7FCZP?=
 =?us-ascii?Q?4XhWAl+MaPgsS2qKGMH2/HULRaS6czpjnH7sC80Fv2uPQb0PQM9G5G0a5PIj?=
 =?us-ascii?Q?7j4xdESqXmklLBB9DJoRrhV9DBTQKospvEXkxqz+ue6GGNQ0GL74o/GcOIbr?=
 =?us-ascii?Q?iw3ZU8Ai3mxh+sDfSrneRZ45w2MdHHSIEvft4inNmV5puSQF6wG/nK7N3BU5?=
 =?us-ascii?Q?kFSabadKixzq7EZXLfHbKUkiOW0CDQ8z6kxVsWi9bNu3tgH5ucdmFN+kJwj5?=
 =?us-ascii?Q?pTKQQtJXmi1iVOBi/tTOeRIlhzUKiLwUWCmY8UR9sJfIrpxP2Hxi9x0H0ILE?=
 =?us-ascii?Q?1MWdibJ1oQKFj6X2NMKseVxDV0P4MvgZ1l5dw+K2F8CWEvVA2xhZ1DjZULkM?=
 =?us-ascii?Q?OtdyDP6zx7Cj3DWFuOwap8S8L7IxUx/4Utdb3DRYU8P+OJSPBpJOITju2HbC?=
 =?us-ascii?Q?2DuR2ZJUvA5MO3jYUspjxvwSsjKfX6ob8A6v9N7MrMCSij2w0ZM2KNbwZn2n?=
 =?us-ascii?Q?Nq5HGjFmfrGtyxt5ZKAU8vAzozf8Hsm9JTNE3w1uDgAUFFmZd+TucHI67r5v?=
 =?us-ascii?Q?7GtDcfOVNtno5zZzb07tE7E9+l7Sz2L0ybwsuD3ucWt9tXUu9rQWsFY3AnFp?=
 =?us-ascii?Q?rByJodMM9s1r9YjfWUxjwW1Gzf6LKt+76uzt5Zt+fQXGZ2MAu7znvpIQXCQU?=
 =?us-ascii?Q?Hr7bIkPINzrqZrJImJ+p/HOfSiOOvLhXPInv5tnFv68WovNgMnHbS8OF0JnP?=
 =?us-ascii?Q?FolNvJdzsRgHICFdmNtBWuZP7CxMGV2mQ1eh8sNexptYJFBH0xIp1PHrZRqe?=
 =?us-ascii?Q?/isHL3M/ti11KsYSyEHsL36rZkEFPkCDSFnOvWUVbRTJ3vd0BAzo3jUbhsky?=
 =?us-ascii?Q?6Wv7cgXK2sFUIu8/ZAlPGU+nAipjlj4BHKH/tFxq1cyfrHcwx7QmiyPZ5Vj8?=
 =?us-ascii?Q?dxAPm+prn43MlsyLNGWjgQKE7qrbZnDmL32hqzC4uBMb478QgWvvHhdUoMa3?=
 =?us-ascii?Q?voDUcU0fkFWP6mt9XWtqO6TdNTjhzppPfOjA19NtYjPZ08PbC1iojMlDPqbJ?=
 =?us-ascii?Q?Q7XRZx3ratoi2bqiUiCs9n8CLB+eaouN3dBQsQHvpqwR2Qa7q1VnSirgnPXu?=
 =?us-ascii?Q?DmiqXSjalufpzMU/H0GsxCtiZRhBT/VPR3VIl7mh5Uw8IFb9AmEYaSNtoPc6?=
 =?us-ascii?Q?zb49CD23vu3ucWW8fjYuegBt8NCf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6135.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yniwqfT8cGqLc3zYZUS9xMfJB4/6GBVLiEkYmGLeMZtDCEKfOhVyFZqcHnZ?=
 =?us-ascii?Q?WLCOJ2cv+uZSyxp759yCTjn8NknHGE0xdkqeQLODvokpQMaT5kcZ14KoNExt?=
 =?us-ascii?Q?jVdtU8qZAJfItXLtmzQc3WK6jSGpayitanLpbfTyEh7khVnr4Ys+hEa1a7c2?=
 =?us-ascii?Q?fCC2k9vVFRJvI2ed8QrnuT3EJbCHJL5K/EHvfAX/9Voq4pvXWHRPlk952VTr?=
 =?us-ascii?Q?sitJzh/XntahiGbvtZbbsjdU+lseczeO9CvlpvQx3UyQddPB7MvjjmHcOzHP?=
 =?us-ascii?Q?SzM05yelZeiEFpQiHcC8ZPMADCWAqNtSgz0g9/GIMiPMkda8Zy2IUrF3obTw?=
 =?us-ascii?Q?VFMCH+rZBlH/kKhX47QpVEE4VLsnngph6DRM+DVKwou7lz2nK0ian2D1BLgn?=
 =?us-ascii?Q?LScBdqjEC5AxkdzfS2WW8EkmQ2inbbxK9zstAATsESOCLBR/XBhTgZgzTbcF?=
 =?us-ascii?Q?zvH6bW+IH43KIiqpUcQ3+Qw+tw4e+iElz33uLgKBlOmLpXMgXPdG1ICJF9W8?=
 =?us-ascii?Q?OJy7Y/zjbFRj2BfJaFuX+Oaxhwpn7+BHADM7NdS3BZwm3u0B9Jxj/RPhSXhv?=
 =?us-ascii?Q?hiIlOxUwqHG385NWdfzQrEi0np8QYaNRN+jg//PtUYyzSGTqHb08FJZvk51o?=
 =?us-ascii?Q?uUWUMBMHm6YzXcyCMktZt3+5w6VeIYcuOPhOwsIVtRrNM+m+Ca+oC4h9+9xI?=
 =?us-ascii?Q?aQ+cccdqJ8SWdwyczN7s5R6aMD1TWlu99K08OJHoMntLV9YZQK1/zvx/QFPD?=
 =?us-ascii?Q?r51asH5DFZp2C0/QSGClyAbbjsNVBTBxAlVlh4GtTOZxdBi5YMIvyvOzSqP6?=
 =?us-ascii?Q?1Kp1PCubP0uRglRxKVE/usuojiJ5WcLNZtk/+gMcKJNTL+ecaRrq2BlwbkTY?=
 =?us-ascii?Q?GdkCpQ+iKnNS09TK4iPOBGZErcuoKYrdMiKd/EVTELAi2u++PR2q36B1JnpN?=
 =?us-ascii?Q?0BoHw/v3vO2mETC0a2NNDi6oX9v15dpu1cUd5Pf10+1/d626hQeNGQi+rxQG?=
 =?us-ascii?Q?nxG+NKVw8d6W5MUNPFOo2lexxffZtNUd1y7ep+gf5WylbVg/eV8r5VzDLlAl?=
 =?us-ascii?Q?fmUS7eLYGdRvyR9oqoiDYP0wzShiojeVmNGwkCHDHjY/hsebGlIn2V43bINm?=
 =?us-ascii?Q?ClrILT2SS7+diw0qpR654v7Y/MP5Ui5lVdoRPABpbdpDCCjgkqyueSuLIuFC?=
 =?us-ascii?Q?1OLUV7t86FYUNc/mhdO4owIdXJOUDdoaLxTZ7I28ixn35+YB3DliHxz0wN1B?=
 =?us-ascii?Q?obisABAlvBsAkqbNOmqwV1GMAE+0rOBI40zTuI4koJGiiEnqegpXCYN6jtcu?=
 =?us-ascii?Q?uSy2jbokYW07f+/hMIWgFUtCIGj+6SkDBmMzasfHFCcnf2W4sV8eTVaZnmjS?=
 =?us-ascii?Q?cG+J66oQzlL7rooZ9vVrHehgFmT8OF1PHMaw0ztT8XwTirG/iwVcMvGXX8GL?=
 =?us-ascii?Q?jPVHr4DsuyYoV/EBtMbENb5s6DzK5vzmSCyULIvmBysne9ecYxU5PX+O7w3r?=
 =?us-ascii?Q?mCPDstD2x61Wyxt6NiOmu0bBrOedkZZyPhn55JxNf2ExjzzPD/FfWdJpNczJ?=
 =?us-ascii?Q?n/tRGwejC9Oe05tmz2+mQbtR6o4Y6CdQvHh+t4nQPFPAB/ptwfUgZnWxCsOk?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc67e5af-b448-473f-fd35-08dd61e50a76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6135.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 04:10:50.8843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL9GTn+kHAewtoyFv0bcA1CniIXrKstSe8u9b7SUE0W7NutKQ84m6qvjK1UXsFrtBYCnB+hOHI1b/WfqemkzoHe1+aQ4RrseWHP196hlqVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7925
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 08:29:58PM +0900, Vincent Mailhol via B4 Relay wrote:
>From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>
>Add some additional tests in lib/test_bits.c to cover the expected
>results of the fixed type BIT_U*() macros.
>
>Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

