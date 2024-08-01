Return-Path: <linux-kernel+bounces-271049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E39448DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3861F2278A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701E5170A20;
	Thu,  1 Aug 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApQrMlz3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23215252D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506128; cv=fail; b=TJAES42elSasoQmUY/fAkT9gt3/WjewlsxBNMSBYMFT37HRNr0HgBjUSCzSWtn712aN+ACxyzaTKx63qpGmH1CJQgP0TioNTdyFJKOtROCpg+lGfccE6lL4mzI/lK8XoULHDRdGFvj7fVpN5TG82SX7FqGc9GydS4N76N7ohy60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506128; c=relaxed/simple;
	bh=/tXvmb2LxTvPU1kpM+CRrZGDtffby2p9b3ejV3uyD4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fCHU52GS5XHJPDFmPDtqXK5kVsEwoyVbY7gzdaSrwWFYYte5+RXZrlTv/Ff2XFqHIGMDO6JZLYQIeBiIZ8NUADLIhDx/Phla81aohQNx0rIUnis+5PDCsumj/nJIYrJJDX1E8bvk5HSa6HleI9O7QQp/o0t0GsUL+fF9hcVyDzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApQrMlz3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722506127; x=1754042127;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/tXvmb2LxTvPU1kpM+CRrZGDtffby2p9b3ejV3uyD4c=;
  b=ApQrMlz3cfoRxsWFZ+fGMCB1EW0uhnZfVMkGBJ0xpmVRo2t9SQ7uzQE3
   arYsf6cRgmBtgt8LveAyV+yTrcYdTOqXSTIFaEBnAFfQEWT5mCfA/0AEo
   1UG1ZpdI9m9MO02Zym9eath3hzxTjyHjgmbmELMxxyu/vUf2eMSV/i4hN
   /cIksCf1B+7FwRmbpw7qRkPznFVtMYSLE3FvIYbuk7Xh3EZE5olsVpFUQ
   pYyPRgy0WuQ2PiS6QUAnM1jGR0Ykcz9TqAY0u29oZFmt+d0GYT7cMUCMc
   juAy1MZrjz73GkT7krjlq3ler42mgSydtxI+98gzPtjt+N+IyKwJFpUSn
   w==;
X-CSE-ConnectionGUID: ZXzZ8cthQPiUlku7yPUIfA==
X-CSE-MsgGUID: bxl5952nR+ilOU4uFwcm+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20583291"
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="20583291"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 02:55:26 -0700
X-CSE-ConnectionGUID: 3ANKU9iFRxiphQhcenID+g==
X-CSE-MsgGUID: xi1DKs9/Q3+GQOo+TCJf+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,254,1716274800"; 
   d="scan'208";a="54938749"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 02:55:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 02:55:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 02:55:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 02:55:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 02:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOxgMTzLlrJabwZeMdwv8xJipf8+PtN9eRxjaoow3B59Ba3EaE3o0hmTSqe4dWMnJjB7u7XzCTAgpzqzhNNGQgzmb95jNjg0ga3ZiFRMhaB/AfAztinQNxb3tNJtD3qbsCRlaI1LId5A62EfNjSevCwyUQx73B1WWTQLdYj6OO+y+lOEDuvcOa7G6VzokCK5W/ECp2xjjgtNo/+D2ZWlYhz1UWy84zFfTmPhr6O4NrJ8ifvMXQ8aBCcn37vHqJtXaksy/aFHqg79IIftnO/Ap6UqG9yek8r3wbO2ByNfPmTkRRnQAwreKjXZH98FI+WEM8DA2KpxClaA5ZQYeY57Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXd6bbMh6LeTw7QJlELr1qiC81ySJ/MvZs0kqy03xuo=;
 b=apYYrvqomxSJD//XcaTDyF9HibNoRkJ0+1oqHCrXrjseipcGCeEFfM3/JBUeu4v+8TYJnRnTuMR4xjjAEqBdbhVh/B1QjrP0fZ4QkWtmiPu61x6rCZbtJfN7MVcNtRAnnLfPqwCPXOPEJFpX2bct9c5Y5F8iiPn2IAhzYWYFvPPQTnQyNxlfzg9K6Tf+I8wH3SIKQmna5p6zRw04Ky2XO/9XOAmkY/a+3B2UB68Wm/7wh3xGgpvewe1jMaWlkynR0E2tTzfp4rLjfSHgs/6wQOVUeRZkq/v4QvncQE5GMZg0owSY0Pn+w+pbx6+CukcTaHzg7eelKxGAXvMC/CcAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7360.namprd11.prod.outlook.com (2603:10b6:8:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 09:55:22 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 09:55:22 +0000
Date: Thu, 1 Aug 2024 17:56:13 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Syzkaller & bisect] There is kernel BUG in __jump_label_patch
 in v6.11-rc1
Message-ID: <ZqtbvSsmnDKgaEH/@xpf.sh.intel.com>
References: <ZqrpoHTJZBA7TeGO@xpf.sh.intel.com>
 <877cd04oa5.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <877cd04oa5.ffs@tglx>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f529a3-3280-410a-dda1-08dcb2100f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nbNyty40Rl6BV2rQagwbRsCN5QTBbZPCWd5o7lVWhNBOF/Cyl0gg7y/kIZn+?=
 =?us-ascii?Q?sHLe2lsPBXiWtrINM1Ym8RNJnmrYqdCCoI/DGsGtbkCsih4vnB90zNE51Qvn?=
 =?us-ascii?Q?BP7tw+UiqPx1yUI9mJBvB2WtOXCGgZW13QFlpEwPGoYhTKogNICWR9aMTohp?=
 =?us-ascii?Q?6x8EZayaJRli0yNAzFmgFQ/SdSbZ8JArKqp4CQAc4cHYTyoQ+HS61glfnD+b?=
 =?us-ascii?Q?CfIx+BS0Z/qWLFhVihP6bgr8gbk/DV38M71beUOBq3sF09d1rFDfvtVCDOyN?=
 =?us-ascii?Q?c3cmDy+b4RKZ57Vt0hPv4jk6QSfCCIxiqc/6nVNXl1mMvj7xSr0xO7QZxGOd?=
 =?us-ascii?Q?uVgq+cR1ibmfkLlRQuSz97B9znn29w4vLTM9hwnfuy4b05c+YkBD9fpYF96r?=
 =?us-ascii?Q?qSh1gZE5GN9DFmLcIBTIGLrP68hMx9wLOb9RQbaesVoWVzdBUhWG38UHRAiE?=
 =?us-ascii?Q?yh131CCELM0/BnLW/FdpgDbh0ZMNPw1cmuCj2rrCUT0E5AblbmMMhxBwHbH/?=
 =?us-ascii?Q?7AU6gTqUPV0TnbtDcuaN4es5W2PFF5lDozWMwylKV+QCBdqM754Ma3xICnmU?=
 =?us-ascii?Q?4KuQSfsCWwxswH4BGm7qaO6zriF+pT8d5fJw1DoldqCuFJIg9y7AmFZ8Dz4p?=
 =?us-ascii?Q?F0s1NwscGrv5L3govkNH6SSpgugRQ5REjP5P7Kn2Ii1gfwWaSFAUW9mXPLp0?=
 =?us-ascii?Q?iFTbHYrucq6B4iIOcRjcF0hOtFsHAOUHEY5zEh4RJmBFq6pJU8Tl6yxzBztV?=
 =?us-ascii?Q?6dcIbrtyp5kF3hIX1+R/OV2e+EqZvdjbMHW3tpNnFGYazbzAdiXSk253/vJ3?=
 =?us-ascii?Q?hFvxvct6lrtAanIj8/Hz1oEKt0Ybf7g4R3OCIDEFU3/Dq6WSM4Ifj/yj/gSd?=
 =?us-ascii?Q?oA3zPEi0A+DhSWVuZ+SgF4TTobcVPA07ULHrT3x1JeYF0boW7DqkzNEF1qfD?=
 =?us-ascii?Q?Ke+ohYRnzGvI0bzpzLDIcsAXNO+BOjMjyQQ3dNvICg/psVfUVgJVzlr6Z5Ug?=
 =?us-ascii?Q?LPUUH42pRWcEuxUoVouruoixlHvkghg/h0lVT3lbqZVgD2y4/y3ffVMpBoPS?=
 =?us-ascii?Q?QSuv+j52zBUosjTDhv4o2TucqEZSzCg30Ii1ELLad6+TPdi+ZJ+5FKKVAgy0?=
 =?us-ascii?Q?X/c7jQHEB7MxwxwO7ZxREgJcGfCnXH1QLxGx2NeE83MryH84CHFoQk48MrpQ?=
 =?us-ascii?Q?4+7iDPb165fsLSz0aSa2HWyXcobOS+MvxuLSzCJ8duaCdCscMVIqCxsMIsNx?=
 =?us-ascii?Q?XKLRS61TU6Iya2RcPHXHlTw5/lSFBvnGKhGC5QD1sj+Izs+tMXr8sGUFMYnR?=
 =?us-ascii?Q?QQoIWdwoXc4Fs2Zk1liGg7SccERaErEP4AHN8Pg6wvwEIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdEqKV3YkKAQloXK6ZSsxl3hFx5Jr2s/Yj6TRe4dAYjMsE/rFKFr58Xj2+xs?=
 =?us-ascii?Q?kZleDZR6q1E+AhxoW+PIzhAjpu/t7HQ2Ids7QrgaIvoz+gi1OyV+XRM1SFlY?=
 =?us-ascii?Q?dDcs4AtCMzRnvJ6MIY84VcY3QmkcryOsB0kfmxADB4vpC4EnibXp3l/nyDdK?=
 =?us-ascii?Q?l2So7OTV+ZMS8pNlh0Mz2XbV5734ea/LhSfbSYyiAYz1lbp6TQeHGrPYq0Fb?=
 =?us-ascii?Q?bTj2JrcHmJBhL5/qXhjd6yhXqBEmP7LeMHI4K0CvVM8p5YcLcJ82Qh+ZxslS?=
 =?us-ascii?Q?PrKEUAmOKWyJIKLV2oAj9LwqoqL277HLJtKGbWO5In1VHWGQfB5x8OwCz2pY?=
 =?us-ascii?Q?vX4bCNa5Zu5DgnFcsIrDEdT81wLzMui2iVFOZF46xzPKVNchB9UGlP+hSRB5?=
 =?us-ascii?Q?l+dRijC/tg8y0PietLQrBt6aZEzErBmaKx1c2zV2IWXa5RvoLUJexJYI5Agq?=
 =?us-ascii?Q?V9tyG0SPhhWYQfz/eCGPIMG9jG+lkq/J/VqsC3pyniy3xz7h7J6C+cTV8gDv?=
 =?us-ascii?Q?/QGw/V/wfVP1GRWNIDqlWT3zMqJdXctcOjKDW3sRC86WEMQc9laZB8Go0JS/?=
 =?us-ascii?Q?50atukwQ9HTTKi2R3Bnn4se1yBJjWnI9im7uN4bMv11QLXouwA+9oV9zUez7?=
 =?us-ascii?Q?+KmuuNjFeJSfuFDxP1KYsOaivCR13MPP52t4u1SKjbM8OqrRmzwRk3fr+NyT?=
 =?us-ascii?Q?ZAwA45Bgwheia9ya9oZw9Z3KgIsotfCes55FQ8P0/TSOoqKie7vDiur58kbY?=
 =?us-ascii?Q?JtVFEvXRlUui2u1mjOwxKjIyBu9ifjNTkPDehOPtBrkpoVGqmApWyC1kTGML?=
 =?us-ascii?Q?K5A3IZjtkZUdYH6KOwHVhE7yWIWMrFYtyRKXL6IGhWc5mAJt1N5ot20OSbC/?=
 =?us-ascii?Q?W6zNtC6vHqDBZE01gjOkdzwBQRUl+wnyOOmAvfC5f/P90U4ggNobJq2+Ky8K?=
 =?us-ascii?Q?uFyUdTT7O7TcFciMZ6AcZEO3eloWRFaAWyf1jMmphZwEMDyyLRXjO/HHFwjC?=
 =?us-ascii?Q?bYLhTAVKSH/CGGPu8ZWiN0W/b0BxQLzfDTf7BVYPevuZHg31vTNKoYqUKHj+?=
 =?us-ascii?Q?28DoPitAFUDVf4XcjnBQRs/5KPr7LeWwQvF8xSKBDiSsdg6YEk1/BpgrZjqW?=
 =?us-ascii?Q?vHBk4zjGUoPGLw+SRKo7FY+scDH6MJeylGf7cIJZikfdRBS1698S8wOM6KuX?=
 =?us-ascii?Q?3aeB0F+uLNZbxdNJoLT+ZkUZt8JYpn1j2GmJY7yqyo+bX5iWoEgWucOOCPsh?=
 =?us-ascii?Q?aujEA69bnUTwig8xz8MaSaYgX7KfYPwNhslu19yNEALIu3Ya5LU9nyZmXAA2?=
 =?us-ascii?Q?2pqcOZBef4ArLHeAUgoDgsHBI6/wz0uhWCDsFOU/BV4ExyXpS5jytg/Nboo+?=
 =?us-ascii?Q?Y6hPqFXjXvADBo/CIlpuQU+tFJmNaPLzdmwQM2zcaB/JIS3BY4X2wsUqINK3?=
 =?us-ascii?Q?0Kx/qPiL7Hh0pDKewmfQS9fZ0+3mGvlFJJoOANninifmYIkjSPvnC74dx+Uj?=
 =?us-ascii?Q?biwm9aWYntioRTvQR+YuCgWw00bwDLd848DHBBbgZ/vnb1cr0N/yemT8XqHU?=
 =?us-ascii?Q?hzSlzS+H8QKD4Kn53kdkBcwSbWGMT6dLx9FNnmaa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f529a3-3280-410a-dda1-08dcb2100f5e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:55:22.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlrRUx0Ruc5uH6Iv26WCDje8JICfkAd1N1+CM/CBRWTPI5U2dUC3bnqmy42kwXZFhrGCeucQvJTMn01JFxXg8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7360
X-OriginatorOrg: intel.com

Hi Thomas,

On 2024-08-01 at 10:53:38 +0200, Thomas Gleixner wrote:
> On Thu, Aug 01 2024 at 09:49, Pengfei Xu wrote:
> > There is kernel BUG in __jump_label_patch in v6.11-rc1.
> > Found the first bad commit is:
> > 83ab38ef0a0b jump_label: Fix concurrency issues in static_key_slow_dec()
> 
> Known problem, but thanks for reporting.

Good to know there is a solution, awesome!

Best Regards,
Thank you!

