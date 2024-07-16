Return-Path: <linux-kernel+bounces-253528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BBB932287
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CDB21BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132419538C;
	Tue, 16 Jul 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcI96TcR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B62B9C7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121311; cv=fail; b=FA3V5a/iyGI817JPQppDI3gzWc+WsGRgMQH1th6WUTm+T5DT8OM1Jvc/sdizsXFoRXvBwDCqxS9jgt3ckLlj7S1ZwjgWXm28iIDvzIrE5bnB47WrjqxphXJrKU2OHCFa113JkjiuYlvo+NrJSr1nMEhSTt1NQThpbEaQYaHh8SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121311; c=relaxed/simple;
	bh=n8osMh3IIfp+XHtTsm5mLmjjgzD1rZQPckjMj6UPCPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vm308uYebyVlhcYZ5e1pa9ykmqipUHodVoc79T6qeCFr2V8g5112Jjl6qzwl/8SXBoOPJXSlZcmokiTQxA4OB6k3B7aQSjoc8k+hVdRNaQF7R43TRHKpgqXTIipP/+jNWBOmy7B6q0GHTes3kPPyFcGNx3E9SJ7RdTfuIkOtArg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcI96TcR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721121309; x=1752657309;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=n8osMh3IIfp+XHtTsm5mLmjjgzD1rZQPckjMj6UPCPg=;
  b=ZcI96TcRLblIvmi5nEjJnkGjfvml0UqrrbsF1rYqSHRJ0Enh5IjESKl/
   FFA2oPODDZblIFR4txOXyGUquR48eyK6XSDWPy2SzCh2CrMqfKTA+iHwP
   NdBwD0YOP781Gh2dTKtkn8zMAOLJNH5GyJVwyCAcchDWLNP42t/fv/MTa
   IrNMddIT+1Pt5fS5U8PSRhWxdwv6aDAhT+UKiiYCXA27PTiCx+4kKYYL3
   i7m+E6SVRut/eGtSB3Z3+o2D0SjdHHyui/oBf55KBOfso9F1KdV9/QqOF
   yRI/vZYqvOA4n5AzPNGNS5NCGAnF0ytxzt0HB2WOjXU0lYGrOptZxbFT8
   w==;
X-CSE-ConnectionGUID: ENpMox0fRgmhvT5U8Z769g==
X-CSE-MsgGUID: 7dF2Gv/7RWa6j3SfUyHuGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18496674"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18496674"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 02:15:09 -0700
X-CSE-ConnectionGUID: EfSco42RToCxbT4hAfkmgg==
X-CSE-MsgGUID: eI4lZgdsSKqt5f11l3AyvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49866298"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 02:15:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 02:15:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 02:15:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 02:15:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 02:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qx8ADCkdJnhP/J2am7Q9noAppqoo6fr+ACNkjgDoLHZrzjQGG2CDPMe6C0SFRvI4CenXEV2h3HM2QoRfcCF6+xDL62WQCKbg/54cab0cLok9FMoQBPBzvkNn4qgU2H0oR+xK5OtI8ZBTzf9sR28D3rMT1mM4i8kEOTsN3Za77QAdojLZYLOJG3Anp2t3KJAtBEb2i23MuqregAwJgTvLu5OTVIkxXHVATZjVrcZw6UXppN/LY/zdDhCW7Z9adXNs8nBHD/e2WeaBukuxBmw4cGttcP2cla8Nsbu8NkGT1YPdmm06oGQJRDVvgnLX2s2bP3uhiT49TEYetgIE9QtSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvquI719xYEVdJf1s8lP5aUJGgJ6V3VsNv+n4q58wl8=;
 b=sWLN9aXuQccQA6+cLFoVVLEmipcWwxsv2od8y+A587wPMfWYs7IkXg8DmIW4Kt3nPESSZrK7js13wM6yqmU2lDL+l9XMkG2+vqIHvMFf67K4hEGqSzhAcj7v2aIMMNphwGFGbLP0/4A7ImuYCbVWCxag+nFCS2is3e2uxTCn/zXRdiOthzAWyfhP1khvcHU9zZw87mj5KHuai7wVi9ECejMFsIkbedHzP3naj19YuSm16Js4qO3yucQtcLoJL4SuEm+Ioa2alviNkc5/FcZIVTe3gUaXCHwGJlRoPnYKamDvhw2TE0OFuu0A1n56W2v+592GyZWAlf7atzfS/9Pv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 09:14:58 +0000
Received: from MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::7a0e:21e8:dce9:dbee]) by MN0PR11MB5964.namprd11.prod.outlook.com
 ([fe80::7a0e:21e8:dce9:dbee%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 09:14:58 +0000
Date: Tue, 16 Jul 2024 17:13:29 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Kirill A .
 Shutemov" <kirill@shutemov.name>, "x86@kernel.org" <x86@kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Pei Li <peili.dev@gmail.com>, "David
 Hildenbrand" <david@redhat.com>, David Wang <00107082@163.com>, "Bert
 Karwatzki" <spasswolf@web.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <ZpY5uU2NyOoMVu5A@yzhao56-desk>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <ZpTLCscCFGtsrEjC@yzhao56-desk>
 <ZpUyZ9bH1-f5y5XG@x1n>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZpUyZ9bH1-f5y5XG@x1n>
X-ClientProxiedBy: KU1PR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:802:19::21) To MN0PR11MB5964.namprd11.prod.outlook.com
 (2603:10b6:208:373::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB5964:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b9a317-bf33-4bec-b357-08dca577c370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J+6naUoQBC0PcOSd7uhJ05vVq2c8oQLwRSpEXUqoqdA4K64SzWwvWWmRM24j?=
 =?us-ascii?Q?qGmsiLgDSnQExSL9VpnO/AXT8use2YxvJxIKApW4UPcyrte+h1VBu7OK7UCk?=
 =?us-ascii?Q?7rUqPwALOkQrq1iPgF6MsCByWxlGkQ5MnJexsQHeRqAvHPn7zMaPHuuadMc1?=
 =?us-ascii?Q?jZHP13YXJlEwhFNr99Zefwy4g1cmxQ+Zuye+jCXCs9N7gP+RUQv3Xv0bkaPg?=
 =?us-ascii?Q?zcXcc8P4FsTbSc5FlPh2bp/YAta6T4Tpue16ULcNVpr9mbSydd5uuwXupizN?=
 =?us-ascii?Q?TwYbH3XeV5pXsWbQQ3rPOCDO0EXXaRG7RWafaOuKCwIEPox3kC85RxwqU9hk?=
 =?us-ascii?Q?nTJZ+dRCROKTGYeFeotff8SX92f3CizKf827ffH0FEd0l2mKw2i6D5GRZk+E?=
 =?us-ascii?Q?VokSjVmKV6ZvERhTojm/zIzQFdmycd5Np/5A4Mqmwz9cBj80KCxDvaLl1+3/?=
 =?us-ascii?Q?yHg1wDLIsJgbaSqPW/ibUhWKWvbdvK+HjkxET6n5JffvxafC5hbNAb3ryHKF?=
 =?us-ascii?Q?0BNSATWzl1ImfCfqAxw70CQ/zG88rri5Aj1xiWdkBzfS9oJPRsaOpVdFUG7W?=
 =?us-ascii?Q?P02BobKix4HanzyPjWPajtXmWjIPhMV3x+L6Fy+OEiKU9jNC/ZBUeducIoSu?=
 =?us-ascii?Q?E/NoplDPS+Ia6pT8Wm+BpSb1CX8yxY2Xi0Vo7h7ufEyy9wd56l1Add0S1lCt?=
 =?us-ascii?Q?4g4B/r/2BWu3JmUNiWAtOaq4AFvkV+bCKuv0RBgJ/7C7xXUo92ONjLBtLrnT?=
 =?us-ascii?Q?Hf8HacQwThu7M1pXAcoXyZf3yzp3ll9Puj8sIMvo59ft/IcxRJZjGy7n83ZZ?=
 =?us-ascii?Q?H087rhL7URyHCMZk5ehdKC+Wi28RgRlC8MWc4JnaXL8W9rAbhxxBJ8fTr+bE?=
 =?us-ascii?Q?dh1At++53koUQstIJ6LF9g1LmHDhKSA833E7MVjlLjSEyWIYUG1mmPdwOqAB?=
 =?us-ascii?Q?Jr4vp2QWwHgBgzcZBNodQHDE9hzpbmh1xthPNwu5qGD6EiF0iAoZ5YkIrVCr?=
 =?us-ascii?Q?4vZnXBP/z+lIkAr/qxuGm3krARnHOcuKqtgZMbXJqu5swT8+ebDaXL9HCuxY?=
 =?us-ascii?Q?D4R4MgULC1zN58ZfvVoe66LBh5y758db52ukSZaBz32bVvdB1B+SvFLcc4F6?=
 =?us-ascii?Q?cyQmQOaL7u+gbpreFJJdwSN8Zi8BwMIyNLCbNnIYoGkyjZSCCvxxFOcARcDX?=
 =?us-ascii?Q?V5psrYLLv3OOBFn8Dq5Mvn+Zt1BCtDViL3tN97HH4dGimutmLGg0zrrSAbM7?=
 =?us-ascii?Q?amS+j3jEbMgTNaK9PIi0n26thRA7DRS3qiijQBjiJbcBrJAoZMbMl3NUd0U0?=
 =?us-ascii?Q?PVE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5964.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L613EJe2ZfX8RreJFJNsEUlwwl3KwZJijFKZhQKFkuDvYQTjz5RaZGhIt+0S?=
 =?us-ascii?Q?I3Sqq+5ESRS3gYFMVVLcMv+Dg3P0mGIMxELDcpXMRPBThwYwhTbAhFmneOqO?=
 =?us-ascii?Q?T2XWbynZFac/SJ5jDGcMd5yU9WjoLaSWDMsDjIZlsP3oyFFFQQgHtKZxPEoJ?=
 =?us-ascii?Q?sAqW/pwretbDrsSpw6ok86Y9wc34yMJsptFxrALxVo1V3cNtrplhsnAhDcHm?=
 =?us-ascii?Q?ZiQvkNSjYTpVDtZQMw6nrVaLG0dEI5vRzVJVMnZ1oasYnqAzWiwGGe7lrmfT?=
 =?us-ascii?Q?uQzlDW6eoXbXljWe42J0xZHJt0cyFsBl/OncymvY4GBnngtOyFiCdKoBPzW8?=
 =?us-ascii?Q?8conU/7oCsJs4UIizddLmyTgD3dKOQZZrIpS9Z5s7xRQDSp3V1xwwNgC9s7l?=
 =?us-ascii?Q?P5IV+YiXZct7+/rE3s+dj0p2hVNYbgk0iCjzsLBc3xzleshOANOhv/WYiPXR?=
 =?us-ascii?Q?IVzBQVNlaZnAP3LeiflT9RfTn0MXy2T12iJulvfkL9M0oZlOL0/kezJ1Q5ue?=
 =?us-ascii?Q?RMKcZ6SzzhnuMNfcSN124wb+dUpCSiKliq2CjlVHUoVBaXlTapQJ3X0pLA5e?=
 =?us-ascii?Q?YR0P/vYnvgh0ySPvqks5pXv3O9OVpBGQHCLUfl56hh9yblsmAZJxDaUgUuYW?=
 =?us-ascii?Q?d0cysFyEDHuV9uPQF3uDrH8Y40rYkjHKL3OPyo094Slf0oVAr2wqrdog1UKO?=
 =?us-ascii?Q?3M41dMP+VFAtYkR8xlfQc8GK2LZCd9HNqLqpVNsQMvGvnC2m4QcMS6NAmgBw?=
 =?us-ascii?Q?gcj/ONesbiBks10BWsdoGqDzx1HEQZpvE/VnMu5kcY3yxgydRbWIPoQO880s?=
 =?us-ascii?Q?Ux5Fm0dwiQYQPDSx02VZPG4QGWrvQdjO82nQLTNbn0QKdZff9Aqb3i3EX/mA?=
 =?us-ascii?Q?pJQI8BjdyJ5NR1P8eG7EmfbKfIUnDeF8b5IlnlI5tonaP2XRK1hCIxXNGwpd?=
 =?us-ascii?Q?7XX1SttWGJC9zM7YfhqXA9tzULU4TTlEqqjUKwuDuqr5UZeQbZ5Bx1FzsAF5?=
 =?us-ascii?Q?FG21l57sNk1k9NBjl4NJyFq3hDdy/c99nMJQpDegnnnP/BXRpalEx5SBrREk?=
 =?us-ascii?Q?j6j5AIy/3+NVpTCp552FiB8jRMzRTqkgkfZLbxjP0VezEXl/rGcNzfDplsxD?=
 =?us-ascii?Q?YvTiBb4OBFmvjSWUI9NcoidWhdV3VetSAh8+lo2Tg1raNsnAWXBo6R+6FNH8?=
 =?us-ascii?Q?r0UqEt1dZSyuUU9Y+x50mv/eFam25CROBZuDUvH3+Taqji8pJCJ91gT0lT2r?=
 =?us-ascii?Q?RtCXI+4x0X6QPEPtimHgV8ga1y5lGojNrufTslIT/BSnakW3tnAxZ3p569vi?=
 =?us-ascii?Q?j1Mvl4xOBwg/fTHfwxL4Zk/IPi9ff82X1sUkELowWpuLlYp9AINP+fdpkCrX?=
 =?us-ascii?Q?LnOv8wu0B47OHoGt/GmGYaBQIpgwfy+BilHnQXu/7ExXLNTF0CWVVUbVC7Ps?=
 =?us-ascii?Q?7I8HXCPOopLRWr5HSEapFfd2lY+Ju88gL2UlftyLqXjbSC5rIRkcUlfbKOn/?=
 =?us-ascii?Q?QtfX3nHdFzX09wr9BnTwal2h4nOO4sVToc0xMwkQdXFTu/DElqcdSEg+yBHm?=
 =?us-ascii?Q?hKhOJohW5Gg6CgOe3wqdwH12zPo77tjMv52a/VsC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b9a317-bf33-4bec-b357-08dca577c370
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5964.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:14:58.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UU9o5zrMX9yViZWrhszot4W0Io1GBsS+VcjItNbw9hctK5nJDK+vKdpZM95IjukkXyNjFW99Y8b/pU8iM7LPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com

On Mon, Jul 15, 2024 at 10:29:59PM +0800, Peter Xu wrote:
> On Mon, Jul 15, 2024 at 03:08:58PM +0800, Yan Zhao wrote:
> > On Fri, Jul 12, 2024 at 10:42:44AM -0400, Peter Xu wrote:
> > > This patch is one patch of an old series [1] that got reposted standalone
> > > here, with the hope to fix some reported untrack_pfn() issues reported
> > > recently [2,3], where there used to be other fix [4] but unfortunately
> > > which looks like to cause other issues.  The hope is this patch can fix it
> > > the right way.
> > > 
> > > X86 uses pfn tracking to do pfnmaps.  AFAICT, the tracking should normally
> > > start at mmap() of device drivers, then untracked when munmap().  However
> > > in the current code the untrack is done in unmap_single_vma().  This might
> > > be problematic.
> > > 
> > > For example, unmap_single_vma() can be used nowadays even for zapping a
> > > single page rather than the whole vmas.  It's very confusing to do whole
> > > vma untracking in this function even if a caller would like to zap one
> > > page.  It could simply be wrong.
> > > 
> > > Such issue won't be exposed by things like MADV_DONTNEED won't ever work
> > > for pfnmaps and it'll fail the madvise() already before reaching here.
> > > However looks like it can be triggered like what was reported where invoked
> > > from an unmap request from a file vma.
> > > 
> > > There's also work [5] on VFIO (merged now) to allow tearing down MMIO
> > > pgtables before an munmap(), in which case we may not want to untrack the
> > > pfns if we're only tearing down the pgtables.  IOW, we may want to keep the
> > > pfn tracking information as those pfn mappings can be restored later with
> > > the same vma object.  Currently it's not an immediate problem for VFIO, as
> > > VFIO uses UC- by default, but it looks like there's plan to extend that in
> > > the near future.
> > > 
> > > IIUC, this was overlooked when zap_page_range_single() was introduced,
> > > while in the past it was only used in the munmap() path which wants to
> > > always unmap the region completely.  E.g., commit f5cc4eef9987 ("VM: make
> > > zap_page_range() callers that act on a single VMA use separate helper") is
> > > the initial commit that introduced unmap_single_vma(), in which the chunk
> > > of untrack_pfn() was moved over from unmap_vmas().
> > > 
> > > Recover that behavior to untrack pfnmap only when unmap regions.
> > > 
> > > [1] https://lore.kernel.org/r/20240523223745.395337-1-peterx@redhat.com
> > > [2] https://groups.google.com/g/syzkaller-bugs/c/FeQZvSbqWbQ/m/tHFmoZthAAAJ
> > > [3] https://lore.kernel.org/r/20240712131931.20207-1-00107082@163.com
> > > [4] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/
> > > [5] https://lore.kernel.org/r/20240523195629.218043-1-alex.williamson@redhat.com
> > > 
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Kirill A. Shutemov <kirill@shutemov.name>
> > > Cc: x86@kernel.org
> > > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Pei Li <peili.dev@gmail.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: David Wang <00107082@163.com>
> > > Cc: Bert Karwatzki <spasswolf@web.de>
> > > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > 
> > > NOTE: I massaged the commit message comparing to the rfc post [1], the
> > > patch itself is untouched.  Also removed rfc tag, and added more people
> > > into the loop. Please kindly help test this patch if you have a reproducer,
> > > as I can't reproduce it myself even with the syzbot reproducer on top of
> > > mm-unstable.  Instead of further check on the reproducer, I decided to send
> > > this out first as we have a bunch of reproducers on the list now..
> > > ---
> > >  mm/memory.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 4bcd79619574..f57cc304b318 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1827,9 +1827,6 @@ static void unmap_single_vma(struct mmu_gather *tlb,
> > >  	if (vma->vm_file)
> > >  		uprobe_munmap(vma, start, end);
> > >  
> > > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > > -		untrack_pfn(vma, 0, 0, mm_wr_locked);
> > > -
> > Specifically to VFIO's case, looks it doesn't matter if untrack_pfn() is
> > called here, since remap_pfn_range() is not called in mmap() and fault
> > handler, and therefore (vma->vm_flags & VM_PAT) is always 0.
> 
> Right when with current repo, but I'm thinking maybe we should have VM_PAT
> there..
Yes, I agree.

But, currently for VFIO, it cannot call io_remap_pfn_range() in the fault
handler since vm_flags_set() requires mmap lock held for write while
the fault handler can only hold mmap lock for read.
So, it relies on ioremap()/iounmap() to reserve/de-reserve memtypes,
without VM_PAT being set in vma.

> 
> See what reserve_pfn_range() does right now: it'll make sure only one owner
> reserve this area, e.g. memtype_reserve() will fail if it has already been
> reserved.  Then when succeeded as the first one to reserve the region,
> it'll make sure this mem type to also be synchronized to the kernel map
> (memtype_kernel_map_sync).
> 
> So I feel like when MMIO disabled for a VFIO card, we may need to call
> reserve_pfn_range(), telling the kernel the mem type VFIO uses, even if the
> pgtable will be empty, and even if currently it's always UC- for now:
> 
> vfio_pci_core_mmap():
> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> Then the memtype will be reserved even if it cannot be used.  Otherwise I
> don't know whether there's side effects of kernel identity mapping where it
> mismatch later with what's mapped in the userspace via the vma, when MMIO
> got enabled again: pgtable started to be injected with a different memtype
> that specified only in the vma's pgprot.
Current VFIO relies on pci_iomap() to reserve MMIO pfns as UC-, thus
no VM_PAT in vmas.
 
Calling remap_pfn_range() in the mmap() will cause problem to support
dynamic faulting. Looks there's still a window even with an immediate
unmap after mmap().

Also, calling remap_pfn_range() in mmap() may not meet the requirement of
drivers to dynamic switch backend resources, e.g. as what's in
cxl_mmap_fault(), since one remap_pfn_range() cannot reserve memtypes for
all backend resources at once.

So, is there any way for the driver to reserve memtypes and set VM_PAT in
fault handler?


