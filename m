Return-Path: <linux-kernel+bounces-264990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F993EAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AEF1C2156F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB012C861;
	Mon, 29 Jul 2024 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQEblvzH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85F2770E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218869; cv=fail; b=pGlvVVzdWdDBX71IbHHTu2DHoxPqes5m2B4fKa/BwO05pRGeXvDkxr58zf2Xad6GGTs5UeRxq0tN9c4Lw1/gBJkj1mX7edoiPxcW5t5eXX7NVnBrHmT3qlaSL3HfGXGtPOtkTm+zxdpQfLWz60QjGCnp4qyKw2wDBHJ7dUyWGKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218869; c=relaxed/simple;
	bh=E8cD76WEh/7RaKTCXFWu39Y1mQEctqN3f0brq40NkOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cgxp2tYS7ADGg8eJ6ONF1aQ8GFRxOwBwhJxtM5jJA7Ayg6er1mHQ7xVoQEgDelz4pGAImv84ig9xJJQ4bVTrfr9amyH9e95xI41mtv6SYZbWLS2bcgLwUr9Vhh5wj5HmeB+MmLTZ5z7TUoZC3pVpYzhtNAmSYiv5S0pUW8hRvmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQEblvzH; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722218868; x=1753754868;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E8cD76WEh/7RaKTCXFWu39Y1mQEctqN3f0brq40NkOA=;
  b=lQEblvzH0+SBDDPNKfXDx81Vk8YBI+6o+sLFGNCS2S1FSWb+/IbVAJt3
   G6ojO1dvm5b2NRMtSjxgtak39wOEp3JIU2hMO4l339iynmYDzrlui24WA
   aS65O06CvGOniBoVVo+2tZ8OUuTEhIrhJQTvp1d5BBKlBAMgBLFsJwp9U
   /qzjofHZ8Ia9RlJuegZ1nxPKUp78u0KabD0NbyMvigtZ0YUEDN1T1xr7k
   H7WTRqONNFGY7Iyt+8CL8r7DCQN9/+O+1x3EG+EdSK72H4gtG+vSp0/A/
   OuagWUT888Ze/74v59rqVcfTaDMEocfqzONLoAsu7U3AYAcGHM9ifG320
   g==;
X-CSE-ConnectionGUID: EfuteaNhRJubIh7MaHnQ+A==
X-CSE-MsgGUID: l+nleqXwSNm/l6LsrjBBJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19743497"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="19743497"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 19:07:47 -0700
X-CSE-ConnectionGUID: 2G/uZw3fQuGmVYrAqe+YiA==
X-CSE-MsgGUID: Bmk9bTCLT6qnxqp/DNxtrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="77058219"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 19:07:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 19:07:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 19:07:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 19:07:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 19:07:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMcTqH0NhefPceBfTaYBTzWyy3hmSEwfLaiYvz3P/BXFKoQXMp7U8HAfiXX6x3QfifOvRCVmy1T+A057+ugvahQNzPv0GD/PUWdkqaSj2VqvBIqUc+/DCnVSy5WqXiH/cmChO3BS7s+ixHz7cKUfKPJnPfKGrjo13mu6Q8UEbIVcj/WjUDgQfDJCWlLOmbiPtQeDnJY6kjkGlXUIuAbDT2C1PSNpJ67zstn9crOXlhhdcWVhYzQcWSmnPXI5SE/WnNdumiGzGuoxMtvEaOXqmDDV1bNHo5dIiOTfPhqF4hydtcBIvdCd4vNaSDUr5RnDDjEtmOFMiaARbSCKE7ahSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIkcOnsrYpYxto2PE2d+O7/Ki9CbM+Uv/2TITOrQIhc=;
 b=l89lRWStWMtEazo4sd2qCrfZWq1vRdPI4jii4z4PEcwTwuUWbBdftFdBv1gkLoCxXhAg8wzN2M+PMOn3pCD+RxUiLAfWhS/WatkGKCrzwkYUOsA58dqn4I5sCGZcVznBN8ZLqFdY8Mo+tOmFVCEeoebytZedBHIcyMRX0VoQ9nQWjsTtZKmsh8JUqnY7RYj1epm3M6cBNIYtbxrdeH6EpzWfOz3jfF+Da2EUR4w8xWQDRUBZibfwc3BpXK8Yq7Df+P7S5oYLwFOuUq6/7GNqJOhDcRwivArredB1t4Eo4l3pA5YYFJD1PQI0s9izFJDLKiRVcukHkwN9D1Mpeil5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 02:07:38 +0000
Received: from PH7PR11MB6029.namprd11.prod.outlook.com
 ([fe80::8ad2:f4da:864:424d]) by PH7PR11MB6029.namprd11.prod.outlook.com
 ([fe80::8ad2:f4da:864:424d%7]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:07:38 +0000
Date: Mon, 29 Jul 2024 10:07:16 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: Vivek Kasireddy <vivek.kasireddy@intel.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Linux Memory Management List
	<linux-mm@kvack.org>
Subject: Re: drivers/dma-buf/udmabuf.o: warning: objtool:
 get_sg_table.isra.0+0x94: unreachable instruction
Message-ID: <Zqb5VPMCSeadJmi4@rli9-mobl>
References: <202407282344.RDPzYUGa-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202407282344.RDPzYUGa-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6029:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaac33e-d675-4ae0-404c-08dcaf7331b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2QTxJDcWvabOxuiNed1C8ztPNaEkjstbGiqQKaZ+L9HtSR4fZKliaL25B6yG?=
 =?us-ascii?Q?39r3WkH7pDdrF72+bCL45NWK1zVfwGM31LppJxBSkiq+9ZQk1dZSUI90gR+F?=
 =?us-ascii?Q?OBCaInD+6mpRfzJIX7uNY/3mUgYbc0YoquwE4KxF0P1oZpoVTF6+INOYpP19?=
 =?us-ascii?Q?Rd1kDzOvSgHA8UiL5tWIrwrK1jTkwAHseL1ykEmD0yOmlpmjLLl6C9OXeYsG?=
 =?us-ascii?Q?LAO0QrKF0CNyWvzZEs0eLuQKeASdFMFF2LpRlzSUkbg5eKU8JB7D/bfR9uVP?=
 =?us-ascii?Q?uXG7VARmOM79JodgSwa/nzA9KhJKCI0PMAXZGOoKfZEVYRfb5r2qsEYxMY1s?=
 =?us-ascii?Q?qyPOXsipQUxl6QdvEBO5YWhk7GvAiKZaFZpUsaU9KXymygxHftGiI7X7EgmP?=
 =?us-ascii?Q?pDxpkLyZrOaNdGHqchYAaLlSJMoDur/JIexDgqZ9f7pCBjpz/xcg1mvj141L?=
 =?us-ascii?Q?MWYmP/I0saQw7A/wxNIwVTBoo/v72QyXjvDUlebNRnpzWfQdZ5qbd9fURZFt?=
 =?us-ascii?Q?8re7xTrB0Zk9mLJlCjLKHYMmwuAWPR61N91JdQu/QAh119S1ailkJdX39H5V?=
 =?us-ascii?Q?2Pf2fNkPK0BfzJI8lNREaBoiQE06gSol9agBxTnClP+fpAu5/PLqaDbWeP/f?=
 =?us-ascii?Q?bUuYSY3MtR7GOfA7C3/0dVwcycRvyXnzKw3c40yhMLXxTfvU53Lr/4QWuci1?=
 =?us-ascii?Q?MZ4bYCwjO/xEcrqHPstCQ2cT7LRzID9PEpgDkbIXTR7fn2YmrrRR8eF4PK/N?=
 =?us-ascii?Q?oqQEPra/biBsuixZZ7rfRBEGWp37aIKluLhdg+pgqrU2aD1KRmklk0VHC1Iz?=
 =?us-ascii?Q?3DvJAyOYoKLCt3nluF0GMicU/yyFLduZSZ+tz4l/3Wd3KdUDHQbRcpQkr+NI?=
 =?us-ascii?Q?YzPI2yOXxy/XtgPsnQMJCElCyjS6HLxhfK4quqO+vI5Brg0sPZ5iIYenVA8s?=
 =?us-ascii?Q?vgPHSv/vmus59MfgTeSCMdeN6kO6WooDpuecvfC1xCeNwBFbYTeqUN3tYroT?=
 =?us-ascii?Q?LQgHWGdXUgDyROdFhlUd9eAcPHTFLmlniSroIhdlZtIl0SHeLa46CtX8sA5T?=
 =?us-ascii?Q?i775JO5TlSCO7rt5jrxQ6MuQoPBCRDosY2ZxksLHir4Tonb7rxEZfYel8k2g?=
 =?us-ascii?Q?LT+ApOlvyH6EidLOeEWv/Lc+rslxSOifcpYGfgUH+keNk1J6D5FulW2TxuFq?=
 =?us-ascii?Q?dMCJ9kW1Nu/sN9UcEGR/BMW4CynIfdz7OFi6IyVdsPnaD/91ITtLPZzE35nQ?=
 =?us-ascii?Q?Ua7CHRBmldV5jXlZtdHkYUuGrfxvD9Z4ym/FZnkA9rERcq4mZRRHZC1v8LHY?=
 =?us-ascii?Q?ILvkZYb+eCaS8RwT6vlav/Tk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltvjnQo9TCf911TXuZ8oVP5SF+WwLou7FS7yVwrNp6WZwz/3ipz2404KG6j/?=
 =?us-ascii?Q?/KHDvdgustv/Z4XtgBOsvxhloe4B1iAsun/hrFHlojrrJFZKm8h283fxgj+9?=
 =?us-ascii?Q?hrFEwKa0e+3Plm1hWS3WwIX3evfSIkkC46R0+5BbptN/Vgwx2njncXt1frae?=
 =?us-ascii?Q?ybLP2ksGN72l52/oM7amF73Od+XPcf6WHX+kPERdLzcd0r8DJM9zro13cVnB?=
 =?us-ascii?Q?lcpkEBBlVYJm1YWCHBas56ax37BFuZPjT/u/46qVcPD/JpIkeaTfdnTfWEjw?=
 =?us-ascii?Q?ZcjFnVBFSDEwl2LdRo1nlFxMbwTg/TOOUt2v3YYASJuQMVedB7VxYi0Yd8Ux?=
 =?us-ascii?Q?A/M2VQhj96eSVDtmhVlL2yBZPjxNdFhqKoeu5mziBiCSt+gj1IZ33jYjnVoA?=
 =?us-ascii?Q?k39yALc8YTr2dAWceeQd5HuCB0PnZTACAIvbSxD8aqrLzCoF5f/lFkrRs5km?=
 =?us-ascii?Q?oXzpd5iNn8b5BZIgO2sd2Ogj8U6WMcKMwwidvThAMcZMqqJVvWui6rKKw4m3?=
 =?us-ascii?Q?PoVvC9wW+MsIOyEtTfjUpweJ6HiJ4Bn3rAZz2461cnM60+mvxXL7o3Wi4ACq?=
 =?us-ascii?Q?LLNhVpfFCO+L2slS2Zn8ZtX4vfTqNJJwTN31c6VN0u+kluxGovYav3fw+SEO?=
 =?us-ascii?Q?dkzJTC6KbwDAl4HAw6cbsEnx5QTaK0vqc6fjZSpsvivWfYe4wqxadgfTWUcL?=
 =?us-ascii?Q?DvzooMlQQxXqALFCYXogdzYYfcwXoxsrTDvscDSdv27E5FUvfHpW3ZDijsyI?=
 =?us-ascii?Q?KRsMRRQ69DueiLOEBBRFWVNSv7JonyC1mn42ONmzLa33UkktIfYwfUkOVbtF?=
 =?us-ascii?Q?SE7vh8P4IQqW1zUGUBMg/yh0YHO2wAynLqdnJfNcPVMdc+hUpO+iN7UhufMb?=
 =?us-ascii?Q?92NqYg2cttW9A0nBKQYGonyGC0eYCBF8RUYaIs8wwNBXw+IPk41RL8pbiqLD?=
 =?us-ascii?Q?JjmvvLKFzPHTXt4355KKxs/83gYRkI+ZmfXDRoMQ5xEocxjhVIbj76EBy6Fp?=
 =?us-ascii?Q?bS8XfjZ1Py145w9/snaU13Btwa7t0xqiuPOWcA/m4scjOFgvZoN/5p8VlsAC?=
 =?us-ascii?Q?iaO39LxbBZhZoc0aAqCyyPVYlPts+2stnrdcvJsmJlK6ef/QXiCakjypaYVW?=
 =?us-ascii?Q?JuPeAAOo1/v623dx7aL6Tftp36U+Tfyn1KrW4MmM4c9T9nX5O2iY0pioePX6?=
 =?us-ascii?Q?vbuocMCMetKN97g4oRGNHuHig4gcAWUUEvIG/o6wj0sEZ3J4iEHaWjbNuV6Q?=
 =?us-ascii?Q?mO3Ld968QnRW4dylzxWY4XtpbkYdJpOtMvLnzg8xJB0UA9SAQunya2JHmLxC?=
 =?us-ascii?Q?5A/u/Cw/K1oRCBZpDX81go3x3/8jhrPC4RsxsRxWB6T9i3LzfP6maN6Pp3AA?=
 =?us-ascii?Q?Teij4M/KeHL8sGYRlerIlodggJFSDHbY7J0t6h4cJGpVN6rEKhpiW0H6zXLZ?=
 =?us-ascii?Q?Lrv2JxcH+13/tcCNkf5+fQ8kCWUeIOejo5eoRDaj+XnyoRT5qNijDgDRoTDx?=
 =?us-ascii?Q?phjZFq+6tcK+aHZ2+n8AJgbA4+vqAWm7BdTudkXyWSaQxHdLiOtIq8McnMhq?=
 =?us-ascii?Q?Etajid6WRKYrXniM5PVcNPzLCMBXOgJ4MndzO7tU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaac33e-d675-4ae0-404c-08dcaf7331b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:07:37.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyaQujityfZaX0QY3+X50/vMiJCG8cFbx5BQtHDYP6wf8Szfr1TrgS6+yudtOiQSHm7KsVIHl3cpibDyvV9Y+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

On Sun, Jul 28, 2024 at 11:46:27PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5437f30d3458ad36e83ab96088d490ebfee844d8
> commit: 0c8b91ef5100eaed3d64123ac91ac4739fccf15c udmabuf: add back support for mapping hugetlb pages
> date:   2 weeks ago
> config: loongarch-randconfig-r121-20240728 (https://download.01.org/0day-ci/archive/20240728/202407282344.RDPzYUGa-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
> reproduce: (https://download.01.org/0day-ci/archive/20240728/202407282344.RDPzYUGa-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407282344.RDPzYUGa-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry, kindly ignore this report, it's possibly related to the loongarch toolchain
as cerain "unreachable instruction" issues can't be reproduced on 13.2.

> 
> >> drivers/dma-buf/udmabuf.o: warning: objtool: get_sg_table.isra.0+0x94: unreachable instruction
> 
> 
> objdump-func vmlinux.o get_sg_table.isra.0:
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

