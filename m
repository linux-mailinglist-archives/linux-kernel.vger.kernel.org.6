Return-Path: <linux-kernel+bounces-323208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555CA973961
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111FD28869E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7D193418;
	Tue, 10 Sep 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7opdhc0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5818FDA5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977317; cv=fail; b=rOJ6yrksI2lGHOeF/L1B7iveQc9dx7814InmgoLs0q+HX8WbUZCQmmeXbC/SQc7AKwZGaIYuFrqdBPdPEpIt01DmjE6QvAsArAANphmAPW+/zi8Bmwy99oqS6XhiEyXTzIo0VQuFtHEpbv3bmzpICap+FlRLwnSCqmMRBzhanPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977317; c=relaxed/simple;
	bh=/cz2y3j3y2lHJp/v9n5rhh40d52+6mX3TXwDKTRhukE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bf/N/+524P15pJeZjFwpYu/CMazf8tRtmGtw1q6OjV8DB0BywBHO1yWUL4oR+rStVOEgH9cUV+E28sYd6MFLWcbLmZm3XTpB3AfIoCdSOMwRzrc2efavWZjItqg9EXT1ScbIyb6gkeruvFW7yJj2vigO+sD/A1ixGcGHX/L/ZmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7opdhc0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725977316; x=1757513316;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/cz2y3j3y2lHJp/v9n5rhh40d52+6mX3TXwDKTRhukE=;
  b=I7opdhc0tpy63M0Nm7M+sEu/Ph88AItB7W0kaFlhYzhps9+akwRw7wkk
   n2cb95QKoKvKL/EGplDekzx37GkNsaQPjn8PKZeJk5iEahpE9sYu963Mq
   WZC8DsUsyHPtxhNhABm6pV5UtfXmaYOe74s7JYfHNmW+maIBC4IY0twl0
   kH4VHn2TQ3N60qRX7gq80KFNUHGIU981gbRDDDowfZyym2yLmHWMuT7+j
   FlJA2lKh6lMbQp/vQJu8CDdEmTtGo7gjewQU8ECpUR/lTdFf+67KsfqRD
   mVY38w23+oczu8hvNp9VLjGST1dYbK6tf9pNuUd/B3mPCMYfdxYPiEyiO
   A==;
X-CSE-ConnectionGUID: g4jv1v0mQTCtnJDfO0B1Pg==
X-CSE-MsgGUID: Q/v+tDGfRS2J3ciokMD3Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="42243774"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="42243774"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 07:08:35 -0700
X-CSE-ConnectionGUID: dPXQLu6vSGi7y3cLeibpVA==
X-CSE-MsgGUID: UsZ6fRTRQSycA6Pu8HwYrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="97741136"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 07:08:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 07:08:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 07:08:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 07:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrNquwJRAtC3bwwxBJ/rdiQqdgcgeEQKL5XGYAbnnEKCIQPDadPipMlG6xqS4ymlicdVQ0Z/VuH2yepiuRmdTTdMywVQx44+8uRQFE9bFtC7oVZmkbhLDOev/AvDkb3K92EVlvPNZn60z3kH77Q5kidD4zE1E2UUMWHK2kzt977HrdJXtRsJyjpm3sDDs7IdWCBG/x52vEAZsToqnQyYG5OMk6mDetarv9J0gd6NuDiiN1VRx5nIDyHIgz3Mgef1OVdvjpkA4N90lDbz0NPV+p6slkUqv7YMUblIK6FM/Z5CfYtkc/Wr0prxT2NEPqKYKOouJdQ/pspZs46jOXLV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d/HLBvXIMPhNEWcOY+aBQT0T7u29Hpamtm8wbF5xa8=;
 b=QYVjYj8wyxK/yn0n0BDiq36nlNUHOfGowsUxChVHK5TZKTxjKIV89JgqbqSJx+jv68T/rHIZ+vbOrUV7cAnD7ktwJRSt4RAwTsjf6VgAVf3QqTLce1IXnHdvINpVGfpe+2xPfblcDKUjxqZDk3RMaNKMQy807fRG+wbfkw07KfDf58Nvzy1QcUZVDyRUmPWgEJPAaE4xa9DQTrOvV0nOBxmxU6JI/a7kJdWCKgD/NbGB9lMYIkKE4CK7M4FDdxg6+d+p/axRgN2pQ4HFIoqRfgriMNxSptdzjHe8JMkPmre22wslzZ1REACkkAKi9+pn2LBM2EDc8sIorK9nmXQs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 14:08:26 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%5]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 14:08:26 +0000
Date: Tue, 10 Sep 2024 22:08:13 +0800
From: Feng Tang <feng.tang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
	<cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin
	<roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Andrey
 Konovalov" <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, Shuah Khan
	<skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, "Danilo
 Krummrich" <dakr@kernel.org>, <linux-mm@kvack.org>,
	<kasan-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] mm/slub, kunit: Add testcase for krealloc redzone
 and zeroing
Message-ID: <ZuBSzcMx/K8Dcsyv@feng-clx.sh.intel.com>
References: <20240909012958.913438-1-feng.tang@intel.com>
 <20240909012958.913438-6-feng.tang@intel.com>
 <a4805d44-9595-429c-86c1-6003b9faa59f@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a4805d44-9595-429c-86c1-6003b9faa59f@suse.cz>
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA1PR11MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5ae8e9-0fea-400f-2b6a-08dcd1a209cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2d5ixSMb/Fha6R2YOPNd+hfAzqbaOrakuyiXsSAT/u6HqTt4RYjxfo4dFyaJ?=
 =?us-ascii?Q?XBKEJorplJFkNCc8xrzzNxgLCZvb3JKKPa650oa2/kIPGLDEG57FWQ/gefbB?=
 =?us-ascii?Q?aZNTUoXm+sG7P2tFFGEQFHI2nRPJXaCn7RaKAvwhfbq8hcqIpvha2/L79Vfj?=
 =?us-ascii?Q?1F43+Ye+0hyWslDphZRpGV77wYOc8N7mSL8DzpEgZtO96ayN5tz8t7RhT8qZ?=
 =?us-ascii?Q?XdCXNUtHsghrd7gwfO8ZvrE0QWttwX9aOt4nIFzbohOJGvaDsw8/x0sgqHwD?=
 =?us-ascii?Q?xcXyLzKObHpwEodQL8EMjKkbnW3winx8I2DvZQY2TdwRDC+qj7IA4cjuXK5O?=
 =?us-ascii?Q?t8bDPsMoipizi0YeGGnjSeNmYw1D+xeqoTxSf/qbYG5WrPmYTkQiArs0V44i?=
 =?us-ascii?Q?VFxtTemWx8iMy88EGKlBPICH7cyCwLulGOTJXaJI8/V8TDYQyDvoYUpQxrCt?=
 =?us-ascii?Q?7Dnu3nMaWv6VzMtOJG6/cIxICGTjs/4tJG2TQE3LI4eTFm2a1WudvNxpLBQj?=
 =?us-ascii?Q?WnQrfMuHQ/DxQrZyiHkQmu5YpOlor9OUGc8sya/aFuIolYrou5v1WTA4J1qW?=
 =?us-ascii?Q?1waKgd2l2CF4udQRejX82/pR+5rq4UxatzsJVTh+MjuAlAHtu9S9f2JqIJSe?=
 =?us-ascii?Q?YxFfF550JV6m0CtfdUaDPx+ocOXvgEbnCrY1xgMP3F55dzOYdXTl3bLPmC1B?=
 =?us-ascii?Q?Pn8S3BUcnDjRoJmGeNDrAF14P8cFOQ86Q5ybJEXNFg2ifj6Q1aqN650o9EDp?=
 =?us-ascii?Q?iXwviB3nY17laNpro1yhinW3rZ15RZk5LcpGirGnZAa/8znY66kY23c53SDE?=
 =?us-ascii?Q?MYbJbVCuyetzJfhWqG9Nw/BojML3h12PRqsxvOm/7bq/YjCsFkvV+LEYqK0B?=
 =?us-ascii?Q?zm9MGqmIuK6v5pzA0blqDq1IX6g1f5fRHBZQdjJcLnRZrwXDVA6bddG1eEXX?=
 =?us-ascii?Q?elvdiCHy2xWedzPqQQYXNYh3IJ2xioOTsAgcU6pXfrSQPWN/fO/MV9Z/3zX6?=
 =?us-ascii?Q?LYfI3mOEQNh3KXdd3bCVl6xx1Ty+Yg5GpUe2qGEZPFz5YdfBCIG3UQwgYB/l?=
 =?us-ascii?Q?DFQuRY/+YGTcTJwse3WAFaR3/eqbquyIM7qlEsO+Rtrn82BCSPKw6tzmmeeT?=
 =?us-ascii?Q?6ubFn1pRtEfNJxPhCtlo6V+2IiQ3Vusjx2tzG7WGwBy02IrS8p5MHmiQ3suX?=
 =?us-ascii?Q?gAJwSArQbdlkUmgvy7/WR8FXdTFb3Hfv9XgRY58HZtZNtv0wQQNaOSAQZibf?=
 =?us-ascii?Q?kkxZxux5YtfCIhSLWKAKfiCLMF4RGRUMEcnX0OSWyEcVaaFr8V8KuC/uEreZ?=
 =?us-ascii?Q?c8s7jYH7Fm+asExqyLf//GUELypEgncgOk0q6Hp8I7c9Vw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Y9IxX7s9KEpQFAXs1/S+C17OsdbGNdPCT2qCyGv7rkVdoHyE9vjnCkXj2O7?=
 =?us-ascii?Q?7q3Mo00B46ZX2tnjApNryL83NDZhMDThFPgf7V2+3ZBu4Aj1aiX2If7vO7ww?=
 =?us-ascii?Q?OPk6WYpOvKE5EgD+/lvI6BqiDgZ0Ite0pBgJ7cfiUR0dkyEmXr8lfwL8KwcH?=
 =?us-ascii?Q?DKysgOfOw4R2B1fRE1SRLEX/6nYAvM7qOsi60rx/ZdWtMaQ/jZOeHyfUIVpa?=
 =?us-ascii?Q?GTAKJ6AH+9TetbXqZDO0chkjpn//XsZ4eZCelPP4iEDl6vRCn7Aphqo01Kwo?=
 =?us-ascii?Q?ZjV+QsomPLekG7A4d5uXd712CIJoXHNuYhFRWoSFObjistvIaxjw0pWzfpBT?=
 =?us-ascii?Q?RlKkjj7oJ3ReeGersAHHNijUuw+UvcenxlKXFS4vytG0okI/XSdgKbcxGOAr?=
 =?us-ascii?Q?/Jmt3vLSs9jRf1pEMBm0jaslq5fOTQdAUtgb8YTpEyiiIuSjB9tqmXDXAuto?=
 =?us-ascii?Q?QeyuXCN5viw6xUtL/fxlLYBC3/hMO9Hd3fCchX2cQWvOpI/fGI38JCx0tRTP?=
 =?us-ascii?Q?UpFggXHbGW8IKomI5HDuzBsnjptJqs6hKtt5p8xwq9x04CE4Pioo9oOE2NMJ?=
 =?us-ascii?Q?eW0advJbAEODnw9P7qyjAEM1Xf4hmOpBOKG99N8hRPrUbya15UmSqOXzh+Ot?=
 =?us-ascii?Q?quy/zyCG88QROwO31MYi2DouV77yL55qJySXkxFuyS3EwVbWepgBeX35CI0B?=
 =?us-ascii?Q?gJL8nKoGijR/UBmAEg2L/jOy8tRXeXTkPtx5G2MPqtU06e/9V+S/Ca+BV8G6?=
 =?us-ascii?Q?mu1BcYw1TXiUQT6WkzQOw4kU+/Ni3fGKVHaE+0HCywDQB0wxeieuhh9SreXB?=
 =?us-ascii?Q?X+QaBDrP0pT+V1Eu/rwfxjgRW5BXpuevjPp7A8Suz53kSKy3cFYPHcMXteBk?=
 =?us-ascii?Q?N7P56OBzh5tWY+cKM29a+hp8IDeDXDpjNE16Nm95brhhaxZpqoYm2aUtStcB?=
 =?us-ascii?Q?ef8MU9k7se5tt06dgLvxXSscUFz6GYcKfOjG7TBjn/GTKCXJazV6n+O9LPQv?=
 =?us-ascii?Q?hLnHMh9dMi9JGtZpFdaYBsPvdTHoYFaF99upupSG6rN8TmSMyPAJfATm3iRZ?=
 =?us-ascii?Q?uXx4LAJw45r9veo/43Rhr5NZgeAXJSBF4H+UFKAfzMOoPVGdYQgHnCNXW71P?=
 =?us-ascii?Q?B2/2njAyPLEgeHgVTjZawiEzQkMIv3YwO1HZH+tRVL/tgYcqCNg4+N7cVdXk?=
 =?us-ascii?Q?Xun/YXciyt20DTxGpxlNSgf0tBtApf2EvMTsUUHc+HBzZ6xVelAKcLYfr6h1?=
 =?us-ascii?Q?U0n4VzMWyJr17ogakB6N2Qx3IwdyS8NypAXteB8NKPsDhZcvWDxr1PI5udnm?=
 =?us-ascii?Q?6DOoEbf0+e/eIHaSPLG891syTzCuLxef7Vhgxa1QLPScRC+Dn+tB3zfD9jk+?=
 =?us-ascii?Q?9I4Sq5/w3U5WjjqAQJPY9Ho7AFn3J4Im0EWCleozcM0FdPnxp6DbbqERqZzi?=
 =?us-ascii?Q?Ex1SZj8eBm+YW7NgUlm7ME6Wz431JfbmhSy+DAwDkQIEF3nKYpmG4+ILMFk1?=
 =?us-ascii?Q?cl7AI0HdzLWLtV07uNdYa4LFl1S7SLJcNjobc5Xz19G20ra3va25ronmPdMi?=
 =?us-ascii?Q?aNgayMnuWr+qe1XIHYhDZZZcpNEBLZC5epky/VKj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5ae8e9-0fea-400f-2b6a-08dcd1a209cb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:08:26.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xZ35DOUlXZCoge96gxFNIOM7Ne2dHb7XbYV7a9oZvjv0aYqCcaRNjhuGp2PtAOvbCFqbJrpJoXlmGF4RGPs9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-OriginatorOrg: intel.com

On Tue, Sep 10, 2024 at 03:29:21PM +0200, Vlastimil Babka wrote:
> On 9/9/24 03:29, Feng Tang wrote:
> > Danilo Krummrich raised issue about krealloc+GFP_ZERO [1], and Vlastimil
> > suggested to add some test case which can sanity test the kmalloc-redzone
> > and zeroing by utilizing the kmalloc's 'orig_size' debug feature.
> > 
> > It covers the grow and shrink case of krealloc() re-using current kmalloc
> > object, and the case of re-allocating a new bigger object.
> > 
> > User can add "slub_debug" kernel cmdline parameter to test it.
> > 
> > [1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/
> > 
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  lib/slub_kunit.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> > 
> > diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> > index 6e3a1e5a7142..03e0089149ad 100644
> > --- a/lib/slub_kunit.c
> > +++ b/lib/slub_kunit.c
> > @@ -186,6 +186,51 @@ static void test_leak_destroy(struct kunit *test)
> >  	KUNIT_EXPECT_EQ(test, 1, slab_errors);
> >  }
> >  
> > +static void test_krealloc_redzone_zeroing(struct kunit *test)
> > +{
> > +	char *p;
> > +	int i;
> > +
> > +	KUNIT_TEST_REQUIRES(test, __slub_debug_enabled());
> 
> AFAICS this is insufficient, because the static key may be enabled due to
> debugging enabled for different caches than kmalloc, or it might not include
> both red zone and object tracking.

You are right, that concerned me too. In first version, I make it depend
on CONFIG_SLUB_DEBUG_ON==y, but most user' and distribution's kernel
won't enable it, and user have to rebuild kernel to test. So I changed
to this check finally.

If there is a way to judge whether 'slub_debug' is enabled, that would
solve this issue.

> 
> But it should be possible to instead create a fake kmalloc cache of size 64
> and use __kmalloc_cache_noprof() like test_kmalloc_redzone_access()?

Yep, I thought about that, and the problem was the krealloc a new 128B
object.

> > +
> > +	/* Allocate a 64B kmalloc object */
> > +	p = kzalloc(48, GFP_KERNEL);
> > +	if (unlikely(is_kfence_address(p))) {
> > +		kfree(p);
> > +		return;
> > +	}
> > +	memset(p, 0xff, 48);
> > +
> > +	kasan_disable_current();
> > +	OPTIMIZER_HIDE_VAR(p);
> > +
> > +	/* Test shrink */
> > +	p = krealloc(p, 40, GFP_KERNEL | __GFP_ZERO);
> > +	for (i = 40; i < 64; i++)
> > +		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
> > +
> > +	/* Test grow within the same 64B kmalloc object */
> > +	p = krealloc(p, 56, GFP_KERNEL | __GFP_ZERO);
> > +	for (i = 40; i < 56; i++)
> > +		KUNIT_EXPECT_EQ(test, p[i], 0);
> > +	for (i = 56; i < 64; i++)
> > +		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
> > +
> > +	/* Test grow with allocating a bigger 128B object */
> > +	p = krealloc(p, 112, GFP_KERNEL | __GFP_ZERO);
> 
> The only downside is that krealloc() here might use kmalloc-128 cache that's
> not doing red zoning and object tracking....

Yes.

> > +	if (unlikely(is_kfence_address(p)))
> > +		goto exit;
> > +
> > +	for (i = 56; i < 112; i++)
> > +		KUNIT_EXPECT_EQ(test, p[i], 0);
> 
> ... but this test is still valid and necessary
> 
> > +	for (i = 112; i < 128; i++)
> > +		KUNIT_EXPECT_EQ(test, p[i], SLUB_RED_ACTIVE);
> 
> ... we might skip this test as the red zoning is not done by __do_krealloc()
> anyway in the alloc_new case.
> 
> > +
> > +exit:
> > +	kfree(p);
> 
> Ideally we'd also validate the fake kmalloc cache we created and expect zero
> slab_errors.
> 
> Hopefully this approach works and I'm not missing something...

Yep, this should work. As redzone was tested in earlier check, and
not necessary to be checked again here. Will do some test on this.

Thanks,
Feng



