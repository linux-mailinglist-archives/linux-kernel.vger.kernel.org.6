Return-Path: <linux-kernel+bounces-400074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ABA9C088C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F032DB214E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B121218E;
	Thu,  7 Nov 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnF0J9Gr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA18212D39
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988656; cv=fail; b=SkydZbnFnPhK6/qAaFXM6rI9DjPbd5aomkvaSpJVF5O6s9Xecox5Hlr+YDH+YGM2XVNgUB9mLFmxpi8jkkdZWLK1K8DBvLYpaLrkV2Q/mcBO5l2r5eygIEY1aCXG9Ax/HVcDdXVccmJapRqzYsacERrWEq2jOe35QtOv8NMavqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988656; c=relaxed/simple;
	bh=kGLyYuUo7mNn4neQ7JcZZcGvBgAkNBF2uG6pbWEqPRI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=drJeXuwhFb+22WaqCInWjgI1jxxHZPuF0ebmqDgZYyUiibAmPKIeUeU438fGF986azB045Nw4dlyBaAFmZxmpmIlkMfQMITwm6Z7FabbC/UE80BiNMPe9diF1XXQKtqVXSQ8xAnuxHGAtfPuk93nYY65I2SW1x/CU/T3K1o8tTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnF0J9Gr; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730988652; x=1762524652;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=kGLyYuUo7mNn4neQ7JcZZcGvBgAkNBF2uG6pbWEqPRI=;
  b=NnF0J9Gr78wndeJ0rVx+TfqGwy7xuh/tfrZA1hiJBxvY3BDJcl8GyelM
   w74UAnRK1wnSQ/TVdrtSVH4z+jsxjHkTp/3V42Jf8BHBRrXA4g+Tv7/OL
   oIm6yNhoMGUVNPrOGQLWGSNna67QIeR6Vc3JBUNkrgjQthyK/NhoZPUvZ
   XPOQ3Tt1uA+usf0b7/dURFODAayUQ2K5WBSwj3Yk3tqNdK/J1j6nnE2Ux
   jHyb2pTpcPVIOcx9MCXgYUuazy65MViB3pjYG/9unwNmIpf9lxpTD8mPs
   yN8c1xX/nIWH4wp5kCJIXFN2CX+jLmaMxM0QK6viyZw1gt4FWOMA7gtuS
   w==;
X-CSE-ConnectionGUID: cLcjFrUVSBqwkXFtSpxJ3Q==
X-CSE-MsgGUID: vnCMhPWARd+bKqC/3Hfijg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41450551"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="41450551"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 06:10:50 -0800
X-CSE-ConnectionGUID: PZB73xWdSYumCy6tvej/Zg==
X-CSE-MsgGUID: japwJDonTZu7VgaO0BwtOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="85021869"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 06:10:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 06:10:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 06:10:49 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 06:10:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHBVCy6eCrVE9ERWV+dWmdL/L43V9XBREoTalJkSuJbhfq94X9gOZaJ23229aVWC68Tz+rT1CLAUT/GvYViHpVwTznmkI2Qu+GdIsPyOK1ypTw2yS1T7dJszMYuAxtJhTYZxWGTofnzvU+l5ovwBnVtElDpH8ey0ZTOZkdGbguf1xgwD4L1sQFhuhECpWEQxp0aDM+ZUQnsRXDjBlRDakqGXfqsJzJAg/v3lFxIfwgz2ywA6U27olXXtCxpV4FW7C3njlPXbs2YH1arB+BfnILPkuHnAhVhUUth44ExLOyCqEC9kyzXP2fLlgTVBl85PU90nDcjNVhQHxk0lruQoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL1cQp3Wklevsa/9yL8EjnwdRMLAiL1dzjPJEOJg6dw=;
 b=Kp8lKVMmUxWztOrfYcEvcQXs1zqB7yBDPkqSWdAMJIec+/1OQmI6nrwGVEqR4muzvPQwmTFcdSCRnqZVo+fd7jf3gN7H2YC2vKJcuG//UuBbPk9a5nsk76JZ8Q09TfIxZt7xeXDr2YrZYjZgzTXcKKmw0aDUFwaHGFhTEMccsYR9jXQTBVdIlQ6yH21SlUw52zWf9x7sYe9CO/23FrHd8ALbFV/dJAE5AlEVmKmvpQ9F74tPW6fqc05HbjoBEdn417PexH2rjU8FGYDnPHs9Hn18pZ51W6QjSluQHQE857dwMZjbpvy/hCXxLzcJZzGXYs86BqgoPxsAvBWl7THHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 14:10:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:10:39 +0000
Date: Thu, 7 Nov 2024 22:10:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Michael Matz <matz@suse.de>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>, Matthias Bodenbinder
	<matthias@bodenbinder.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Yang Shi" <yang@os.amperecomputing.com>, Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Petr Tesarik <ptesarik@suse.com>, Thorsten Leemhuis
	<regressions@leemhuis.info>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [mm, mmap]  d4148aeab4: will-it-scale.per_process_ops
 3888.9% improvement
Message-ID: <202411072132.a8d2cf0f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: afd6d32a-cc4e-4240-afb3-08dcff35f4f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?fk/9nf6VKROARr8zXNnwG3/PrNCetPIsNLyYmgnHDXBGX3hKEmkDc/PNhl?=
 =?iso-8859-1?Q?Bc60DwC9aHWFMNtsB68rCsj5rS+2ACh5RxB+02GIGJY0w4FIqWt+cybZt9?=
 =?iso-8859-1?Q?tAWGum+NoRnc5YvvyOU086zdnlH04YCG7CGKVvbJnZZGVd8D1Ax1/oWwg9?=
 =?iso-8859-1?Q?cfWy8xeYfJ78i/OQrqBDdugj3OaUPtPMNhE59+q8TRbj3sLQg3hKqocgyF?=
 =?iso-8859-1?Q?dYBydnd9urIMwnqevgshdgfmhCYkkcmUDgrlOv4qzNap7GSqJBRu/TQapr?=
 =?iso-8859-1?Q?lmfXVocWepmJRR+tU5n6espeX0FDXlpnIMX5S+J7UiJxmhZbh11DvSrZRy?=
 =?iso-8859-1?Q?bXU+1C4PZb9GTiljNgyLR7J+SjUBczj0rM6PCG5AytW5uNRwOTNbIeWKbQ?=
 =?iso-8859-1?Q?hBpyBxjUc2F8ZXMaGr5btvU5Za8nAsP5o41sYoSXXDH73buITsEF8YUxZK?=
 =?iso-8859-1?Q?OmmpPa3EJmwbwOes5glYZaZEJ9RaTPq2fqfTf2zdCDM613v9BEFpZh6Xgz?=
 =?iso-8859-1?Q?kJiqF5DR+x8DLPezrE7B7+qPwPsNeuAz7NbYA78lLwCbE+csa7oBOpOKQa?=
 =?iso-8859-1?Q?QV/1NMKGCeZ32qKtiKKjRY7YFip0ZfJS6b2K1+rOHBm8lnO2Y3/rgWD3iN?=
 =?iso-8859-1?Q?8UG4QpfKu/EeRfAPExsdbOE2a8G1jjrGMPFXk24WyJWVfFX7PM9Yi9L1sE?=
 =?iso-8859-1?Q?Pr3Ny3Nlgn44mXGJxmHQ1UezkifMgwS6uF97bvIuNtQR3vKeKNJZXmKLCm?=
 =?iso-8859-1?Q?4dxvMo6Zh286/Pe1fNMuOCB5ev0IyGW+T7+y5h1wppPo9WTtI8MHo9j53t?=
 =?iso-8859-1?Q?0K9fLlW7HPxlKI1YyCC896UZ/uVhk/yqfABgp206/6Rf3pvxHi7U1yPyIq?=
 =?iso-8859-1?Q?MdfQvBz5roi8+rE42uisIB9yG4fu7yuQpOiFBlV6kAYBacwERiSjt2XgC+?=
 =?iso-8859-1?Q?oFBVkV76prAa/p41nXnJniUST5ZJ/XTaM89jBUHqmnIc7YW2ihFZRXhsaC?=
 =?iso-8859-1?Q?Y7ort0UOToOq8eU5wVS5d+07F5H7o1JljNAxHBVkHwvVnets+LWtZhwIup?=
 =?iso-8859-1?Q?fsvBkFFxRfMyg2vkAo1O4vqpmzpNaF39JWXTVDhm/MAxPyDjdmbB3+AqcO?=
 =?iso-8859-1?Q?Djg8nfIpKoXbvMV8GTtAhBWgUb0CAQ6dCkX6bcD7C/gkZ+wDv3AHGaKcko?=
 =?iso-8859-1?Q?tKIJMfZQeYGIpHM1SsUire0CZBz4WP3Ej43n6H6g6I9wnYwSCbTVNFQtjh?=
 =?iso-8859-1?Q?Jhf/YTQ3msAVtYmhlkYNujZH9Hym4Kb/qvvvTyd48hT1Zc5t1MDug7UgQH?=
 =?iso-8859-1?Q?l9ggfevpNDVBUR5b/9hRbwIHaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?U8jFzgtEWZ7PcZoVjlhzpOeikMRsaodUkmH97NWCQyrVZ7kFQuFLS1JfgT?=
 =?iso-8859-1?Q?jU/srBxPJohKxE0wAUwFGKoNTxRM7P15NWmxyhVunF3vBwKg27hY/y0rxX?=
 =?iso-8859-1?Q?cU+uUerIq8DSSkSpaPRJWlox7srWkOAW+2mRF+dJqzGB5c5RflBcnd/JX0?=
 =?iso-8859-1?Q?0KIWgz6PHxw2f5DLerOhZ6GaoHpWh1t3aYYkNu7guP12ZNlkFDI5IiChlJ?=
 =?iso-8859-1?Q?vJUIiKL0VPmoMn9yWS3AxvCbvsA5+x7unpoZxJLiDud7cT+kX8Te/0WEhn?=
 =?iso-8859-1?Q?R8NK9L8LpJx6uUqWKhuAmYzxik7cjyvHs78PTZ7CTZMAkRHuqfCraBee8V?=
 =?iso-8859-1?Q?zoc+yvPzcpcXAewJZi5X9vpRv/djzqspt7V+JkOHBK9K4Z/ygD/pv8G2XW?=
 =?iso-8859-1?Q?YK5H9FdUwvJ/ORViPn1TXDx/o4WqiiFbhSjUIpA9mxzAjXkzbNh7KJUKUs?=
 =?iso-8859-1?Q?oZb96X5MIKWs+HT5hU6dNIoe4I4w61JQZyYYDxTcJ5L/i9iBJlRVDJNKWv?=
 =?iso-8859-1?Q?QISVUWHMoMbjTKQN1BcEkF2UZQ89jzloOL/vV6+wPVNU7spAjJgJb40KnJ?=
 =?iso-8859-1?Q?q9iiarZZMiAELtVl8XePfAgQqMlgDv8HoM4QVmAJDn/Zj60g6nH5ApjX+7?=
 =?iso-8859-1?Q?yNs40qVK16QDs2Rsr4OT3yS4QuCu7B5HigIRyzL/TUO9kFgxuL7ceHzu0U?=
 =?iso-8859-1?Q?yd6lacoz0eaiQr+6tUjLoaKQVwyJY1ascwS8iJ7j5O2T+9jZ4VcjPYMC4K?=
 =?iso-8859-1?Q?xEbSpAIjafjHZFEeHtTWQY/yQ5sNb5fTGtgtuDALeymRDLJvp0H4Vi73Nu?=
 =?iso-8859-1?Q?JVzSaR2BO7LTcJjJV3bZi1OCnZK23KxrjcBE5EyHYgET3PjmWempBTY1rK?=
 =?iso-8859-1?Q?qynyEjSwhie+Ag6yGuvIX577giYULChSS1Jfss1bsbunPc+fvCUNLvpX+P?=
 =?iso-8859-1?Q?cjQPcqEkKE+40ReGWsWY9VfnA5Mo1KkKXlgpptsXKIH8hMYe+ByejnHVpq?=
 =?iso-8859-1?Q?90lkZi4f55UFPpmZjNQDQAHI9fR3CkFKvt/DQuesZJAanmJjRehYFNCxVV?=
 =?iso-8859-1?Q?ksHw3cbSHfKLUDTtZZyUEdl8HN6zDaeDvh8MuKVKk/wlSP87PZlsNxmy8X?=
 =?iso-8859-1?Q?ZtzDwdTc9Pd52lvTLHc0hIn51ySeuNEdo5bgOFYNtRkIbuULaKlqk1p/BX?=
 =?iso-8859-1?Q?ILwUtYlvRtc/4fLKiZoeYXqwE+JpYu1C5q5bgeL0HBYJREk/fUTKbPMa/O?=
 =?iso-8859-1?Q?gdw3AJJwaDgYXce1OvwsRZUHZHQqTiJMUOhvHBhlDZp2/4FmTyHmO3QK+z?=
 =?iso-8859-1?Q?kW6uCxA1WiccwtW7eXGB7h4KDbyvIiJNni0Uw4DyT4W+jkl4ylodGCsY8b?=
 =?iso-8859-1?Q?R7czSMNyYcQr9MxlBHaIRT0wx9LlfHmaYTBv+N8yEj7jf0T0epGAqgl62e?=
 =?iso-8859-1?Q?no88vLK1Tz9UWzZwEU1h5Hr/dnfKI4h3nXdKG9sFpOGxgYaWphdL5VFSyf?=
 =?iso-8859-1?Q?vfBA9Rp1Cc1Om+pXOAuxuOrJKRkWAtODR690VSYPVhOyoepko7yqrg0YR/?=
 =?iso-8859-1?Q?CGyy7X5kZ/rFm4TwFZ6xT6xLQhc84BQCvbjWmz4arl57hlo4gIS25YHYna?=
 =?iso-8859-1?Q?9YIh4q11P3t1WVMrQCOmcl3Z08xS6A70iP7LV/pEPYW8TPz1XlGDKVDQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afd6d32a-cc4e-4240-afb3-08dcff35f4f4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 14:10:39.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+lDS6NVZSYnbhL6/Wtj6SMzx+LjNnMRtIUQphhr4v1NVT2/OykRdQKx4nJcRhz/2581WUAxsJ6t6t5Osc4SyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3888.9% improvement of will-it-scale.per_process_ops on:


commit: d4148aeab412432bf928f311eca8a2ba52bb05df ("mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned sizes")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 5b913f5d7d7fe0f567dea8605f21da6eaa1735fb]

testcase: will-it-scale
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: malloc1
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.radixsort.ops_per_sec 9.2% regression                                  |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=radixsort                                                                              |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241107/202411072132.a8d2cf0f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-cpl-4sp2/malloc1/will-it-scale

commit: 
  15e8156713 ("mm: shrinker: avoid memleak in alloc_shrinker_info")
  d4148aeab4 ("mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned sizes")

15e8156713cc3803 d4148aeab412432bf928f311eca 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    255351            +4.5%     266817        vmstat.system.in
      1.00            -0.8        0.20 ±  7%  mpstat.cpu.all.irq%
      0.13            +1.1        1.28 ± 32%  mpstat.cpu.all.soft%
      0.49 ± 15%      +1.3        1.77 ± 27%  mpstat.cpu.all.usr%
      4143 ±  5%    +181.3%      11654 ±  7%  perf-c2c.DRAM.remote
      2500 ±  3%   +2209.9%      57748 ± 15%  perf-c2c.HITM.local
      3810 ±  2%   +1461.0%      59473 ± 15%  perf-c2c.HITM.total
     78888         +3883.3%    3142322 ± 22%  will-it-scale.224.processes
    351.67         +3888.9%      14027 ± 22%  will-it-scale.per_process_ops
     78888         +3883.3%    3142322 ± 22%  will-it-scale.workload
    702940 ± 15%    +123.4%    1570646 ± 11%  meminfo.Active
    702881 ± 15%    +123.5%    1570598 ± 11%  meminfo.Active(anon)
   3953778           +28.4%    5075703 ±  4%  meminfo.Cached
    382618          +117.7%     832966 ± 10%  meminfo.SUnreclaim
    913559 ±  5%    +122.8%    2035523 ± 11%  meminfo.Shmem
    528864           +85.5%     980938 ±  8%  meminfo.Slab
  12139918         +3685.1%  4.595e+08 ± 22%  numa-numastat.node0.local_node
  12236476         +3655.6%  4.595e+08 ± 22%  numa-numastat.node0.numa_hit
  12182775         +3990.8%  4.984e+08 ± 23%  numa-numastat.node1.local_node
  12264802         +3963.8%  4.984e+08 ± 23%  numa-numastat.node1.numa_hit
  12222359         +3921.0%  4.915e+08 ± 23%  numa-numastat.node2.local_node
  12320084         +3889.7%  4.915e+08 ± 23%  numa-numastat.node2.numa_hit
  12317018         +3904.7%  4.933e+08 ± 22%  numa-numastat.node3.local_node
  12388608         +3881.9%  4.933e+08 ± 22%  numa-numastat.node3.numa_hit
  27453504 ± 11%     +20.0%   32957345 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
      1.78 ±  2%     +12.5%       2.00 ±  4%  sched_debug.cfs_rq:/.h_nr_running.max
  27453504 ± 11%     +20.0%   32957377 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
    384.34 ±  6%     +28.2%     492.57 ±  4%  sched_debug.cfs_rq:/.util_est.avg
    113.34 ±  7%     +87.5%     212.55 ± 11%  sched_debug.cfs_rq:/.util_est.stddev
    395.67 ±  6%     -91.8%      32.63 ±  7%  sched_debug.cpu.clock.stddev
      0.00 ±  5%     -85.8%       0.00 ± 26%  sched_debug.cpu.next_balance.stddev
      1.78 ±  2%     +12.5%       2.00 ±  8%  sched_debug.cpu.nr_running.max
      5.99 ±  9%     -16.9%       4.98 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
    369561 ±  5%     -48.5%     190196 ± 65%  numa-meminfo.node0.AnonPages.max
    108019 ±  4%    +102.2%     218399 ± 12%  numa-meminfo.node0.SUnreclaim
    148129 ± 16%     +86.2%     275784 ± 14%  numa-meminfo.node0.Slab
     73527 ± 61%     -53.5%      34174 ± 80%  numa-meminfo.node1.Mapped
     94870 ±  4%    +122.7%     211285 ±  9%  numa-meminfo.node1.SUnreclaim
    136858 ± 15%     +83.3%     250864 ± 11%  numa-meminfo.node1.Slab
     89356 ±  2%    +124.1%     200203 ± 10%  numa-meminfo.node2.SUnreclaim
    118047 ± 16%     +89.0%     223166 ± 15%  numa-meminfo.node2.Slab
    698747 ± 15%    +117.2%    1517832 ± 12%  numa-meminfo.node3.Active
    698731 ± 15%    +117.2%    1517816 ± 12%  numa-meminfo.node3.Active(anon)
     90353 ±  7%    +122.1%     200636 ± 10%  numa-meminfo.node3.SUnreclaim
    902916 ±  5%    +118.4%    1972406 ± 12%  numa-meminfo.node3.Shmem
    125802 ± 17%     +81.8%     228694 ±  8%  numa-meminfo.node3.Slab
    175727 ± 15%    +123.5%     392704 ± 11%  proc-vmstat.nr_active_anon
    988408           +28.4%    1268872 ±  4%  proc-vmstat.nr_file_pages
    228353 ±  5%    +122.8%     508826 ± 11%  proc-vmstat.nr_shmem
     36558            +1.2%      36996        proc-vmstat.nr_slab_reclaimable
     95650          +117.2%     207775 ± 10%  proc-vmstat.nr_slab_unreclaimable
    175727 ± 15%    +123.5%     392704 ± 11%  proc-vmstat.nr_zone_active_anon
     61863 ± 20%     +50.4%      93011 ± 17%  proc-vmstat.numa_hint_faults
     27849 ± 47%    +108.0%      57912 ± 22%  proc-vmstat.numa_hint_faults_local
  49211744         +3847.8%  1.943e+09 ± 22%  proc-vmstat.numa_hit
  48863846         +3875.5%  1.943e+09 ± 22%  proc-vmstat.numa_local
    102439 ± 38%    +399.0%     511155 ±  5%  proc-vmstat.pgactivate
 1.218e+10           -83.3%  2.036e+09 ± 23%  proc-vmstat.pgalloc_normal
  25163379         +3665.3%  9.475e+08 ± 22%  proc-vmstat.pgfault
 1.218e+10           -83.3%  2.035e+09 ± 23%  proc-vmstat.pgfree
  23741008          -100.0%       0.00        proc-vmstat.thp_fault_alloc
     27004 ±  4%    +102.3%      54625 ± 12%  numa-vmstat.node0.nr_slab_unreclaimable
  12236166         +3655.7%  4.595e+08 ± 22%  numa-vmstat.node0.numa_hit
  12139608         +3685.2%  4.595e+08 ± 22%  numa-vmstat.node0.numa_local
     18419 ± 61%     -53.5%       8573 ± 80%  numa-vmstat.node1.nr_mapped
     23716 ±  4%    +122.9%      52871 ±  9%  numa-vmstat.node1.nr_slab_unreclaimable
  12263982         +3964.1%  4.984e+08 ± 23%  numa-vmstat.node1.numa_hit
  12181955         +3991.1%  4.984e+08 ± 23%  numa-vmstat.node1.numa_local
     22339 ±  2%    +124.8%      50226 ± 10%  numa-vmstat.node2.nr_slab_unreclaimable
  12319433         +3889.9%  4.915e+08 ± 23%  numa-vmstat.node2.numa_hit
  12221708         +3921.2%  4.915e+08 ± 23%  numa-vmstat.node2.numa_local
    174568 ± 15%    +117.3%     379260 ± 12%  numa-vmstat.node3.nr_active_anon
    225581 ±  5%    +118.6%     493053 ± 12%  numa-vmstat.node3.nr_shmem
     22588 ±  7%    +122.8%      50325 ± 11%  numa-vmstat.node3.nr_slab_unreclaimable
    174566 ± 15%    +117.3%     379259 ± 12%  numa-vmstat.node3.nr_zone_active_anon
  12386775         +3882.4%  4.933e+08 ± 22%  numa-vmstat.node3.numa_hit
  12315185         +3905.2%  4.933e+08 ± 22%  numa-vmstat.node3.numa_local
     20.80           -88.0%       2.51 ±  4%  perf-stat.i.MPKI
 1.314e+09         +1555.3%  2.175e+10 ± 18%  perf-stat.i.branch-instructions
      0.79 ±  3%      -0.4        0.35        perf-stat.i.branch-miss-rate%
  12157447 ±  2%    +510.1%   74172493 ± 18%  perf-stat.i.branch-misses
     61.19           -29.2       31.97 ±  2%  perf-stat.i.cache-miss-rate%
 1.255e+08          +104.5%  2.567e+08 ± 19%  perf-stat.i.cache-misses
 2.043e+08          +292.8%  8.024e+08 ± 18%  perf-stat.i.cache-references
    139.74           -93.8%       8.69 ± 27%  perf-stat.i.cpi
    264.51            +8.5%     286.93        perf-stat.i.cpu-migrations
      6664           -47.9%       3471 ± 28%  perf-stat.i.cycles-between-cache-misses
 6.183e+09         +1555.5%  1.024e+11 ± 18%  perf-stat.i.instructions
      0.01 ± 23%    +808.8%       0.12 ± 18%  perf-stat.i.ipc
     82374         +3701.0%    3131041 ± 22%  perf-stat.i.minor-faults
     82375         +3701.0%    3131042 ± 22%  perf-stat.i.page-faults
     20.32           -91.8%       1.67 ± 70%  perf-stat.overall.MPKI
      0.92 ±  2%      -0.7        0.23 ± 70%  perf-stat.overall.branch-miss-rate%
     61.44           -39.9       21.51 ± 70%  perf-stat.overall.cache-miss-rate%
    136.21           -95.6%       6.05 ± 80%  perf-stat.overall.cpi
      6703           -63.8%       2428 ± 80%  perf-stat.overall.cycles-between-cache-misses
  23815471           -71.7%    6746184 ± 71%  perf-stat.overall.path-length
      2.41 ±  6%     -93.2%       0.16 ± 78%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.60 ± 21%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_huge_pmd_anonymous_page
      0.74 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page.__handle_mm_fault
      2.00 ± 27%     -76.6%       0.47 ±149%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.35 ±  4%     -78.5%       0.07 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.99 ± 20%     -77.4%       0.45 ± 93%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      2.15 ± 14%     -98.2%       0.04 ±196%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.57 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.84 ± 96%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page
      1.41 ± 39%     -93.0%       0.10 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      1.52 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      1.31 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.fifo_open.do_dentry_open.vfs_open
      0.05 ±  4%     -76.9%       0.01 ± 27%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.13 ± 33%     -99.6%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      2.20 ± 19%     -93.4%       0.14 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.65 ± 30%     -70.6%       0.48 ± 65%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.50 ± 10%     -89.7%       0.05 ± 50%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.03 ± 21%     -63.7%       0.01 ± 53%  perf-sched.sch_delay.avg.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.93 ± 11%     -54.4%       0.42 ± 35%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      2.62 ± 33%     -51.4%       1.27 ± 32%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.81 ±133%     -94.4%       0.05 ± 13%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1.11 ± 12%     -51.4%       0.54 ± 20%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.49 ± 37%     -77.7%       0.11 ± 52%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.08 ±  3%     -71.3%       0.02 ±107%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.05 ± 33%     -80.9%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.05 ±  8%     -81.4%       0.01 ± 41%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.15 ± 13%     -77.3%       0.49 ± 28%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4.04           -57.7%       1.71 ± 97%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      4.09 ±  2%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_huge_pmd_anonymous_page
      1.19 ± 74%    +593.4%       8.27 ± 62%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.84 ±173%    +695.6%       6.69 ± 78%  perf-sched.sch_delay.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      4.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page.__handle_mm_fault
      2.71 ± 21%     -82.7%       0.47 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      7.66 ± 93%     -91.2%       0.67 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
      0.01 ±223%   +9242.3%       0.81 ±179%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      8.12 ±103%    +186.4%      23.26 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
      2.34 ± 11%     -75.7%       0.57 ± 75%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      2.77 ± 21%     -96.7%       0.09 ±212%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     36.48 ± 69%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.37 ±223%    +998.1%       4.04 ± 35%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
      2.26 ± 78%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page
      1.83 ± 40%     -94.6%       0.10 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      1.75 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      1.51 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.fifo_open.do_dentry_open.vfs_open
      0.13 ± 50%     -86.1%       0.02 ± 46%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.17 ±  5%     -99.8%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      4.02          +510.8%      24.57 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      3.99           -92.2%       0.31 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.11 ±  5%     +33.0%       5.47 ± 27%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      4.54 ± 12%     -54.1%       2.08 ± 65%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      4.00 ± 25%     -70.1%       1.20 ± 30%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.03 ± 17%     -60.8%       0.01 ± 64%  perf-sched.sch_delay.max.ms.ipmi_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.08 ±  2%     -61.1%       1.59 ±108%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    389.98 ±121%     -96.7%      13.00 ± 33%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      9.71 ±119%     -78.8%       2.06 ± 58%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      8.60 ±210%     -99.1%       0.08 ± 36%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4.05 ±  2%     -34.0%       2.67 ± 42%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      8.02 ±  5%     -55.7%       3.55 ± 11%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.47 ±  5%     -13.9%       0.40 ± 13%  perf-sched.total_sch_delay.average.ms
    396.80 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
      0.17 ±223%    +596.6%       1.17 ± 14%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
      1.15 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
    417.15 ±  5%     +75.4%     731.48 ± 12%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     11.50 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
     26.17 ±223%  +15367.5%       4047 ± 49%  perf-sched.wait_and_delay.count.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
     15379 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     30.33 ±223%    +836.8%     284.17 ± 53%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
      1.34 ±223%   +3359.9%      46.51 ± 73%  perf-sched.wait_and_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
     72.95 ± 69%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
     13.11 ±122%     -61.3%       5.08        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.41 ±  6%     -93.5%       0.16 ± 76%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.60 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_huge_pmd_anonymous_page
      0.74 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page.__handle_mm_fault
      2.00 ± 27%     -76.6%       0.47 ±149%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
    394.43 ± 10%     -99.8%       0.67 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
      1.99 ± 20%     -77.8%       0.44 ± 95%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      2.15 ± 14%     -98.4%       0.03 ±193%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      0.57 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.84 ± 96%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page
      1.41 ± 40%     -93.0%       0.10 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
     84.95 ±219%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      1.31 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.fifo_open.do_dentry_open.vfs_open
      1.13 ± 33%     -99.6%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      2.11 ± 23%     -93.1%       0.14 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
    415.50 ±  5%     +75.9%     731.00 ± 13%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      5.81 ± 41%     -74.2%       1.50 ±  9%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.93 ± 12%     -54.5%       0.42 ± 35%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      9.89 ±101%     -87.1%       1.27 ± 32%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
     13.22 ±  5%     -77.3%       3.01 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.13 ± 15%     -77.6%       0.48 ± 28%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4.04           -57.7%       1.71 ± 97%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      4.09 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__do_huge_pmd_anonymous_page
      1.19 ± 74%    +593.4%       8.27 ± 62%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.84 ±173%    +695.6%       6.69 ± 78%  perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      4.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page.__handle_mm_fault
      2.71 ± 21%     -82.7%       0.47 ±149%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      1000           -99.9%       0.67 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.vmstat_start.seq_read_iter.proc_reg_read_iter
      8.12 ±103%    +186.4%      23.26 ± 73%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
      2.34 ± 11%     -75.7%       0.57 ± 75%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      2.77 ± 21%     -96.7%       0.09 ±212%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     36.48 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.37 ±223%    +998.1%       4.04 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
      2.26 ± 78%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_huge_pmd_anonymous_page
      1.83 ± 40%     -94.6%       0.10 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
    168.46 ±221%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_file_alloc.init_file.alloc_empty_file
      1.51 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.fifo_open.do_dentry_open.vfs_open
      4.17 ±  5%     -99.8%       0.01 ±223%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      4.02          +510.8%      24.57 ± 38%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      3.99           -92.2%       0.31 ±223%  perf-sched.wait_time.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.11 ±  5%     +33.0%       5.47 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
    250.47 ±134%     -89.0%      27.62 ± 59%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      4.08 ±  2%     -61.1%       1.59 ±108%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
    499.41          +278.7%       1891 ± 64%  perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     54.24 ± 46%     -59.6%      21.93 ± 68%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      4.05 ±  2%     -34.0%       2.67 ± 42%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     96.58           -96.6        0.00        perf-profile.calltrace.cycles-pp.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     96.37           -96.4        0.00        perf-profile.calltrace.cycles-pp.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
     96.69           -90.4        6.27 ± 11%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     96.73           -90.3        6.45 ± 11%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     97.00           -90.2        6.79 ± 10%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     96.77           -90.1        6.68 ± 10%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     96.77           -90.1        6.69 ± 10%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     87.45           -87.4        0.00        perf-profile.calltrace.cycles-pp.clear_page_erms.folio_zero_user.__do_huge_pmd_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.6        0.61 ± 11%  perf-profile.calltrace.cycles-pp.lru_add.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.vms_clear_ptes
      0.00            +0.6        0.62 ± 12%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
      0.00            +0.7        0.67 ± 10%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.00            +0.7        0.69 ± 27%  perf-profile.calltrace.cycles-pp.get_mem_cgroup_from_mm.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault
      0.00            +0.8        0.82 ± 10%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range
      0.00            +0.8        0.84 ± 13%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.pte_alloc_one.__pte_alloc.do_anonymous_page.__handle_mm_fault
      0.00            +0.8        0.84 ± 10%  perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      0.00            +0.8        0.85 ±  8%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.___pte_free_tlb.free_pud_range.free_p4d_range.free_pgd_range
      0.00            +0.9        0.86 ±  9%  perf-profile.calltrace.cycles-pp.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.9        0.87 ±  8%  perf-profile.calltrace.cycles-pp.___pte_free_tlb.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables
      0.00            +0.9        0.88 ±  9%  perf-profile.calltrace.cycles-pp.__lruvec_stat_mod_folio.__folio_mod_stat.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault
      0.00            +0.9        0.88 ± 10%  perf-profile.calltrace.cycles-pp.__folio_mod_stat.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +0.9        0.90 ±  9%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.9        0.90 ±  9%  perf-profile.calltrace.cycles-pp.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +0.9        0.91 ± 10%  perf-profile.calltrace.cycles-pp.folio_add_new_anon_rmap.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +1.0        1.03 ±  9%  perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes
      0.00            +1.0        1.05 ±  9%  perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas
      0.00            +1.1        1.07 ±  9%  perf-profile.calltrace.cycles-pp.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.00            +1.1        1.11 ± 75%  perf-profile.calltrace.cycles-pp.uncharge_folio.__mem_cgroup_uncharge_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +1.3        1.29 ± 46%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +1.4        1.38 ±  9%  perf-profile.calltrace.cycles-pp.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.00            +1.5        1.52 ± 28%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.00            +1.5        1.54 ± 34%  perf-profile.calltrace.cycles-pp.alloc_anon_folio.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +1.7        1.73 ± 22%  perf-profile.calltrace.cycles-pp.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc.do_anonymous_page
      0.00            +1.7        1.74 ± 18%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.8        1.75 ± 21%  perf-profile.calltrace.cycles-pp.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc.do_anonymous_page.__handle_mm_fault
      0.00            +2.0        2.02 ± 14%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      0.00            +2.1        2.10 ± 19%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +2.2        2.22 ± 19%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +2.3        2.28 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +2.3        2.29 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +2.5        2.46 ± 19%  perf-profile.calltrace.cycles-pp.__mmap
      0.00            +2.5        2.47 ± 16%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      0.00            +2.5        2.54 ± 16%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.00            +2.6        2.58 ± 16%  perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.00            +2.6        2.63 ± 12%  perf-profile.calltrace.cycles-pp.pte_alloc_one.__pte_alloc.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      0.00            +2.7        2.69 ± 12%  perf-profile.calltrace.cycles-pp.__pte_alloc.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.00            +3.2        3.21 ± 38%  perf-profile.calltrace.cycles-pp.page_counter_cancel.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs
      0.00            +4.0        4.02 ± 37%  perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs.free_pages_and_swap_cache
      0.00            +5.0        5.04 ± 23%  perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00            +6.2        6.16 ±  7%  perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge_folios.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00            +6.2        6.16 ± 12%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00           +36.4       36.44 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      0.00           +36.6       36.57 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain
      0.00           +36.8       36.80 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs
      0.00           +36.9       36.93 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache
      0.00           +37.0       37.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.vms_clear_ptes
      0.00           +37.3       37.33 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      0.00           +37.9       37.87 ±  3%  perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu
      0.00           +38.4       38.42        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.lru_add_drain.vms_clear_ptes.vms_complete_munmap_vmas
      0.00           +38.4       38.45        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.lru_add_drain.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.00           +38.5       38.45        perf-profile.calltrace.cycles-pp.lru_add_drain.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.78 ±  2%     +44.1       44.87        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes
      0.79 ±  2%     +44.2       44.99        perf-profile.calltrace.cycles-pp.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
      0.79 ±  2%     +44.2       45.00        perf-profile.calltrace.cycles-pp.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.86 ±  2%     +44.4       45.24        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      1.23 ±  2%     +86.5       87.70        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      1.25           +86.6       87.86        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      1.44           +87.1       88.55        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      1.48           +87.1       88.60        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.49           +87.2       88.66        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.50           +87.2       88.66        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.52           +87.2       88.72        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      1.52           +87.2       88.73        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      1.53           +87.4       88.90        perf-profile.calltrace.cycles-pp.__munmap
     96.37           -96.4        0.00        perf-profile.children.cycles-pp.__do_huge_pmd_anonymous_page
     95.62           -95.6        0.00        perf-profile.children.cycles-pp.folio_zero_user
     96.71           -90.4        6.28 ± 11%  perf-profile.children.cycles-pp.__handle_mm_fault
     96.75           -90.3        6.46 ± 11%  perf-profile.children.cycles-pp.handle_mm_fault
     97.02           -90.2        6.83 ± 10%  perf-profile.children.cycles-pp.asm_exc_page_fault
     96.79           -90.1        6.68 ± 10%  perf-profile.children.cycles-pp.do_user_addr_fault
     96.80           -90.1        6.70 ± 10%  perf-profile.children.cycles-pp.exc_page_fault
     89.46           -89.3        0.20 ± 22%  perf-profile.children.cycles-pp.clear_page_erms
      4.15            -3.8        0.35 ± 23%  perf-profile.children.cycles-pp.__cond_resched
      0.81 ±  3%      -0.6        0.23 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.80 ±  3%      -0.6        0.22 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.73 ±  3%      -0.5        0.18 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.60 ±  4%      -0.5        0.14 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.83 ± 16%      -0.4        0.39 ±  3%  perf-profile.children.cycles-pp.__cmd_record
      0.53 ±  3%      -0.4        0.12 ±  6%  perf-profile.children.cycles-pp.update_process_times
      0.52            -0.4        0.12 ± 28%  perf-profile.children.cycles-pp.free_unref_folios
      0.44 ±  3%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.cmd_record
      0.44 ±  3%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.44 ±  3%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.handle_internal_command
      0.44 ±  3%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.main
      0.44 ±  3%      -0.3        0.12 ±  6%  perf-profile.children.cycles-pp.run_builtin
      0.43 ±  3%      -0.3        0.11 ±  6%  perf-profile.children.cycles-pp.perf_mmap__push
      0.34 ±  3%      -0.3        0.07 ± 17%  perf-profile.children.cycles-pp.record__pushfn
      0.34 ±  4%      -0.3        0.07 ± 17%  perf-profile.children.cycles-pp.write
      0.34 ±  4%      -0.3        0.07 ± 17%  perf-profile.children.cycles-pp.writen
      0.32 ±  3%      -0.3        0.07 ± 15%  perf-profile.children.cycles-pp.ksys_write
      0.32 ±  3%      -0.2        0.07 ± 16%  perf-profile.children.cycles-pp.vfs_write
      0.30 ±  3%      -0.2        0.07 ± 16%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.30 ±  3%      -0.2        0.06 ± 19%  perf-profile.children.cycles-pp.generic_perform_write
      0.29 ±  4%      -0.2        0.09 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.38 ± 33%      -0.1        0.24 ±  8%  perf-profile.children.cycles-pp.process_simple
      0.20 ±  5%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
      0.38 ± 33%      -0.1        0.24 ±  8%  perf-profile.children.cycles-pp.ordered_events__queue
      0.38 ± 33%      -0.1        0.24 ±  8%  perf-profile.children.cycles-pp.queue_event
      0.00            +0.1        0.10 ± 22%  perf-profile.children.cycles-pp.sync_regs
      0.00            +0.1        0.10 ± 59%  perf-profile.children.cycles-pp.__count_memcg_events
      0.00            +0.1        0.10 ± 24%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.1        0.10 ± 26%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.00            +0.1        0.11 ± 24%  perf-profile.children.cycles-pp.native_flush_tlb_local
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__put_anon_vma
      0.00            +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.find_mergeable_anon_vma
      0.00            +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.flush_tlb_func
      0.00            +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.1        0.13 ± 24%  perf-profile.children.cycles-pp.__perf_sw_event
      0.00            +0.1        0.13 ± 38%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.05            +0.1        0.18 ± 23%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.mas_preallocate
      0.00            +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.00            +0.2        0.16 ± 22%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.02 ±141%      +0.2        0.17 ± 25%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.00            +0.2        0.16 ± 26%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.07 ±  5%      +0.2        0.24 ± 25%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.00            +0.2        0.17 ± 20%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.2        0.18 ± 25%  perf-profile.children.cycles-pp.mas_walk
      0.05            +0.2        0.24 ± 24%  perf-profile.children.cycles-pp.mas_find
      0.06 ±  6%      +0.2        0.27 ± 11%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.05 ±  7%      +0.2        0.26 ±  7%  perf-profile.children.cycles-pp.free_unref_page
      0.07 ± 11%      +0.2        0.28 ± 21%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.07 ±  9%      +0.2        0.31 ± 22%  perf-profile.children.cycles-pp.perf_event_mmap
      0.00            +0.2        0.24 ± 20%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.02 ± 99%      +0.2        0.27 ± 20%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.06 ±  6%      +0.2        0.31 ± 20%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.00            +0.3        0.26 ± 29%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.00            +0.3        0.26 ±  6%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.00            +0.3        0.26 ± 23%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.00            +0.3        0.27 ±  7%  perf-profile.children.cycles-pp.__put_partials
      0.00            +0.3        0.28 ±  7%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.00            +0.3        0.28 ± 19%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.14 ±  2%      +0.3        0.48 ± 25%  perf-profile.children.cycles-pp.mas_store_gfp
      0.05 ±  7%      +0.3        0.40 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.10            +0.4        0.47 ± 24%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.00            +0.5        0.46 ± 27%  perf-profile.children.cycles-pp.__slab_free
      0.07            +0.5        0.55 ± 10%  perf-profile.children.cycles-pp.vm_area_alloc
      0.06            +0.5        0.61 ± 12%  perf-profile.children.cycles-pp.lru_add
      0.00            +0.7        0.70 ± 26%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.7        0.72 ± 24%  perf-profile.children.cycles-pp.__mod_memcg_state
      0.12 ±  6%      +0.8        0.88 ± 10%  perf-profile.children.cycles-pp.__folio_mod_stat
      0.13 ±  5%      +0.8        0.91 ± 10%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.04 ± 71%      +0.8        0.83 ± 13%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.8        0.83 ± 35%  perf-profile.children.cycles-pp.propagate_protected_usage
      0.00            +0.8        0.84 ± 10%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.00            +0.9        0.86 ±  9%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.00            +0.9        0.88 ±  8%  perf-profile.children.cycles-pp.___pte_free_tlb
      0.01 ±223%      +0.9        0.90 ±  9%  perf-profile.children.cycles-pp.__vmf_anon_prepare
      0.00            +0.9        0.90 ±  9%  perf-profile.children.cycles-pp.zap_present_ptes
      0.06            +1.0        1.02 ± 10%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.05 ±  7%      +1.0        1.02 ± 33%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +1.0        1.04 ±  9%  perf-profile.children.cycles-pp.free_pud_range
      0.00            +1.1        1.05 ±  9%  perf-profile.children.cycles-pp.free_p4d_range
      0.00            +1.1        1.07 ±  9%  perf-profile.children.cycles-pp.free_pgd_range
      0.00            +1.1        1.11 ± 75%  perf-profile.children.cycles-pp.uncharge_folio
      0.12 ±  4%      +1.1        1.24 ± 11%  perf-profile.children.cycles-pp.kmem_cache_free
      0.10 ±  4%      +1.2        1.30 ± 46%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.11 ±  4%      +1.2        1.34 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.16 ±  3%      +1.3        1.41 ± 16%  perf-profile.children.cycles-pp.handle_softirqs
      0.13            +1.3        1.41 ± 16%  perf-profile.children.cycles-pp.rcu_core
      0.12 ±  4%      +1.3        1.41 ± 16%  perf-profile.children.cycles-pp.rcu_do_batch
      0.10 ±  3%      +1.3        1.39 ±  9%  perf-profile.children.cycles-pp.free_pgtables
      0.06            +1.5        1.53 ± 28%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.28 ±  4%      +1.5        1.75 ± 18%  perf-profile.children.cycles-pp.mmap_region
      0.00            +1.5        1.54 ± 34%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.38 ±  2%      +1.6        1.96 ± 17%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.39 ±  2%      +1.6        2.00 ± 16%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.34 ±  2%      +1.8        2.11 ± 19%  perf-profile.children.cycles-pp.do_mmap
      0.36 ±  2%      +1.9        2.24 ± 19%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.00            +2.0        2.02 ± 14%  perf-profile.children.cycles-pp.zap_pte_range
      0.37 ±  3%      +2.1        2.48 ± 19%  perf-profile.children.cycles-pp.__mmap
      0.22 ±  2%      +2.3        2.50 ± 16%  perf-profile.children.cycles-pp.zap_pmd_range
      0.23 ±  3%      +2.3        2.55 ± 16%  perf-profile.children.cycles-pp.unmap_page_range
      0.24 ±  3%      +2.3        2.58 ± 16%  perf-profile.children.cycles-pp.unmap_vmas
      0.16            +2.5        2.63 ± 12%  perf-profile.children.cycles-pp.pte_alloc_one
      0.08 ± 12%      +2.6        2.71 ± 32%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +2.7        2.69 ± 12%  perf-profile.children.cycles-pp.__pte_alloc
      0.05            +3.2        3.22 ± 38%  perf-profile.children.cycles-pp.page_counter_cancel
      0.22 ±  5%      +3.2        3.40 ± 10%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.05            +4.0        4.03 ± 37%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.06            +5.0        5.04 ± 23%  perf-profile.children.cycles-pp.uncharge_batch
      0.06 ±  7%      +6.1        6.16 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_folios
      0.00            +6.2        6.16 ± 12%  perf-profile.children.cycles-pp.do_anonymous_page
      0.10 ±  5%     +37.8       37.88 ±  3%  perf-profile.children.cycles-pp.__page_cache_release
      0.12 ±  3%     +38.3       38.46        perf-profile.children.cycles-pp.folio_batch_move_lru
      0.00           +38.5       38.46        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00           +38.5       38.47        perf-profile.children.cycles-pp.lru_add_drain
      0.79 ±  2%     +44.2       44.99        perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.79 ±  2%     +44.2       45.01        perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.78 ±  2%     +44.2       45.01        perf-profile.children.cycles-pp.folios_put_refs
      0.86 ±  2%     +44.4       45.24        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.12 ±  6%     +73.4       73.50 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.21 ±  4%     +73.6       73.77 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.08           +74.3       74.35 ±  2%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      1.23 ±  2%     +86.5       87.71        perf-profile.children.cycles-pp.vms_clear_ptes
      1.26           +86.6       87.87        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      1.44           +87.1       88.55        perf-profile.children.cycles-pp.do_vmi_align_munmap
      1.48           +87.1       88.60        perf-profile.children.cycles-pp.do_vmi_munmap
      1.50           +87.2       88.66        perf-profile.children.cycles-pp.__x64_sys_munmap
      1.49           +87.2       88.66        perf-profile.children.cycles-pp.__vm_munmap
      1.53           +87.4       88.93        perf-profile.children.cycles-pp.__munmap
      2.30           +88.8       91.10        perf-profile.children.cycles-pp.do_syscall_64
      2.30           +88.8       91.12        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     88.52           -88.3        0.20 ± 22%  perf-profile.self.cycles-pp.clear_page_erms
      3.36            -3.2        0.20 ± 23%  perf-profile.self.cycles-pp.__cond_resched
      0.49            -0.5        0.03 ± 70%  perf-profile.self.cycles-pp.free_unref_folios
      0.37 ± 33%      -0.1        0.24 ±  8%  perf-profile.self.cycles-pp.queue_event
      0.00            +0.1        0.09 ± 22%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.1        0.10 ± 64%  perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.1        0.10 ± 22%  perf-profile.self.cycles-pp.sync_regs
      0.00            +0.1        0.10 ± 23%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.00            +0.1        0.10 ± 47%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.00            +0.1        0.11 ± 24%  perf-profile.self.cycles-pp.native_flush_tlb_local
      0.00            +0.1        0.11 ± 21%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.11 ± 25%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.12 ± 22%  perf-profile.self.cycles-pp.__page_cache_release
      0.00            +0.1        0.13 ± 24%  perf-profile.self.cycles-pp.mmap_region
      0.00            +0.1        0.13 ± 26%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.2        0.15 ± 22%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00            +0.2        0.16 ± 22%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.00            +0.2        0.16 ± 25%  perf-profile.self.cycles-pp.free_pud_range
      0.00            +0.2        0.17 ± 24%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.00            +0.2        0.17 ± 23%  perf-profile.self.cycles-pp.lru_add
      0.00            +0.2        0.17 ± 24%  perf-profile.self.cycles-pp.mas_walk
      0.00            +0.2        0.18 ± 22%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.09            +0.2        0.28 ± 29%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.06 ±  9%      +0.2        0.26 ± 25%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.00            +0.2        0.23 ± 21%  perf-profile.self.cycles-pp.zap_pmd_range
      0.00            +0.3        0.25 ± 28%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.00            +0.3        0.28 ± 21%  perf-profile.self.cycles-pp.folios_put_refs
      0.00            +0.4        0.44 ± 26%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.5        0.46 ± 33%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.5        0.48 ± 96%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.00            +0.6        0.59 ± 32%  perf-profile.self.cycles-pp.uncharge_batch
      0.00            +0.7        0.69 ± 24%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.00            +0.7        0.69 ± 27%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.8        0.81 ± 35%  perf-profile.self.cycles-pp.propagate_protected_usage
      0.00            +0.8        0.82 ± 36%  perf-profile.self.cycles-pp.folio_lruvec_lock_irqsave
      0.05 ±  7%      +1.0        1.02 ± 33%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.00            +1.0        1.02 ± 22%  perf-profile.self.cycles-pp.zap_pte_range
      0.00            +1.1        1.10 ± 76%  perf-profile.self.cycles-pp.uncharge_folio
      0.00            +1.1        1.14 ± 37%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.08 ±  4%      +1.7        1.78 ± 35%  perf-profile.self.cycles-pp.__lruvec_stat_mod_folio
      0.07 ± 16%      +2.6        2.62 ± 33%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.05            +3.1        3.16 ± 38%  perf-profile.self.cycles-pp.page_counter_cancel
      0.12 ±  7%     +73.4       73.50 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/radixsort/stress-ng/60s

commit: 
  15e8156713 ("mm: shrinker: avoid memleak in alloc_shrinker_info")
  d4148aeab4 ("mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned sizes")

15e8156713cc3803 d4148aeab412432bf928f311eca 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     18.98 ±  5%     +30.5%      24.78 ± 14%  sched_debug.cpu.clock.stddev
      0.05 ±  7%    +886.3%       0.50 ± 86%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.14 ± 74%     -55.5%       0.51 ± 37%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    265008 ± 13%     -37.2%     166403 ± 22%  meminfo.Active
    264976 ± 13%     -37.2%     166371 ± 22%  meminfo.Active(anon)
   1315990           -63.8%     475807 ±  3%  meminfo.AnonHugePages
    164713            -9.2%     149574        stress-ng.radixsort.ops
      2745            -9.2%       2492        stress-ng.radixsort.ops_per_sec
     78925          +289.9%     307739        stress-ng.time.minor_page_faults
    327.88 ±  3%     -67.1%     107.89 ±  3%  numa-vmstat.node0.nr_anon_transparent_hugepages
     63711 ± 11%     -40.7%      37791 ± 25%  numa-vmstat.node1.nr_active_anon
    317.83 ±  3%     -60.5%     125.70 ±  8%  numa-vmstat.node1.nr_anon_transparent_hugepages
    293623 ± 18%     +35.1%     396637 ± 14%  numa-vmstat.node1.nr_inactive_anon
     63710 ± 11%     -40.7%      37791 ± 25%  numa-vmstat.node1.nr_zone_active_anon
    293622 ± 18%     +35.1%     396635 ± 14%  numa-vmstat.node1.nr_zone_inactive_anon
    668445 ±  3%     -67.1%     220222 ±  3%  numa-meminfo.node0.AnonHugePages
   1317034 ± 13%     -23.2%    1010970 ± 16%  numa-meminfo.node0.AnonPages.max
    254241 ± 11%     -40.5%     151233 ± 26%  numa-meminfo.node1.Active
    254219 ± 11%     -40.5%     151227 ± 26%  numa-meminfo.node1.Active(anon)
    647491 ±  3%     -60.4%     256719 ±  8%  numa-meminfo.node1.AnonHugePages
   1170941 ± 18%     +35.3%    1583801 ± 14%  numa-meminfo.node1.Inactive
   1170783 ± 18%     +35.3%    1583760 ± 14%  numa-meminfo.node1.Inactive(anon)
     66923 ± 13%     -36.6%      42442 ± 22%  proc-vmstat.nr_active_anon
    642.60           -63.8%     232.40 ±  3%  proc-vmstat.nr_anon_transparent_hugepages
    597472 ±  2%      +5.6%     630776        proc-vmstat.nr_inactive_anon
     66923 ± 13%     -36.6%      42442 ± 22%  proc-vmstat.nr_zone_active_anon
    597472 ±  2%      +5.6%     630776        proc-vmstat.nr_zone_inactive_anon
   1188533           +19.2%    1416356        proc-vmstat.numa_hit
      2502           -63.5%     913.67        proc-vmstat.numa_huge_pte_updates
    956729           +23.2%    1178316        proc-vmstat.numa_local
   1495630 ±  2%     -54.0%     687360 ±  6%  proc-vmstat.numa_pte_updates
    820025           +26.8%    1040066        proc-vmstat.pgfault
      6.20            +9.6%       6.79        perf-stat.i.MPKI
 4.203e+10            -6.8%  3.916e+10        perf-stat.i.branch-instructions
      6.15            +0.2        6.30        perf-stat.i.branch-miss-rate%
 2.636e+09            -6.2%  2.474e+09        perf-stat.i.branch-misses
      2.56 ±  2%      +8.5%       2.77        perf-stat.i.cpi
 2.444e+11            -6.9%  2.276e+11        perf-stat.i.instructions
      0.40            -9.1%       0.36        perf-stat.i.ipc
      2.20 ±  2%     +90.0%       4.18 ±  2%  perf-stat.i.metric.K/sec
     10808           +45.4%      15713 ±  2%  perf-stat.i.minor-faults
     10809           +45.4%      15713 ±  2%  perf-stat.i.page-faults
      6.34            +7.9%       6.84        perf-stat.overall.MPKI
     37.76            -0.6       37.12        perf-stat.overall.cache-miss-rate%
      2.54            +9.9%       2.80        perf-stat.overall.cpi
    401.20            +1.8%     408.57        perf-stat.overall.cycles-between-cache-misses
      0.39            -9.0%       0.36        perf-stat.overall.ipc
 4.134e+10 ±  2%      -7.4%  3.829e+10        perf-stat.ps.branch-instructions
 2.592e+09            -6.7%  2.419e+09        perf-stat.ps.branch-misses
 2.404e+11 ±  2%      -7.4%  2.226e+11        perf-stat.ps.instructions
     10358           +36.2%      14109 ±  2%  perf-stat.ps.minor-faults
     10358           +36.2%      14109 ±  2%  perf-stat.ps.page-faults
 1.525e+13            -9.9%  1.374e+13        perf-stat.total.instructions
      0.60 ± 10%      -0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.__perf_mmap__read_init.perf_mmap__read_init.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.71 ±  4%      +0.1        0.77 ±  3%  perf-profile.calltrace.cycles-pp.update_load_avg.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler
      1.25 ±  9%      +0.3        1.54 ±  4%  perf-profile.calltrace.cycles-pp.update_curr.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler
      0.26 ±100%      +0.3        0.57 ±  3%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.64 ±  6%      +0.4        3.09 ±  3%  perf-profile.calltrace.cycles-pp.task_tick_fair.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues
      0.08 ±223%      +0.5        0.55 ±  4%  perf-profile.calltrace.cycles-pp.account_user_time.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      5.00 ±  6%      +0.7        5.75 ±  3%  perf-profile.calltrace.cycles-pp.sched_tick.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt
      7.66 ±  5%      +1.1        8.72 ±  3%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      8.10 ±  5%      +1.1        9.18 ±  3%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      8.38 ±  5%      +1.1        9.51 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     10.78 ±  5%      +1.3       12.08 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     11.04 ±  5%      +1.3       12.36 ±  3%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     11.77 ±  5%      +1.4       13.19 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
     12.68 ±  5%      +1.6       14.23 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
     12.84            -0.4       12.47 ±  2%  perf-profile.children.cycles-pp.strcmp@plt
      0.65 ± 10%      -0.2        0.50 ± 30%  perf-profile.children.cycles-pp.__perf_mmap__read_init
      0.12 ±  3%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.sched_clock
      0.05 ±  8%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.rb_next
      0.09 ±  7%      +0.0        0.13 ± 10%  perf-profile.children.cycles-pp.timerqueue_del
      0.20 ±  4%      +0.0        0.23 ±  4%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.40 ±  7%      +0.0        0.44 ±  5%  perf-profile.children.cycles-pp.handle_softirqs
      0.42 ±  4%      +0.0        0.47 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.20 ±  9%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.__cgroup_account_cputime_field
      0.12 ±  4%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock
      0.75 ±  4%      +0.1        0.82 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      0.40 ±  4%      +0.1        0.47 ±  2%  perf-profile.children.cycles-pp.hrtimer_active
      0.34 ±  9%      +0.1        0.41 ±  5%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.52 ±  5%      +0.1        0.60 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.12 ±  9%      +0.1        0.20 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.36 ±  2%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.50 ±  6%      +0.1        0.58 ±  4%  perf-profile.children.cycles-pp.account_user_time
      0.38 ±  2%      +0.1        0.48 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.46 ±  2%      +0.1        0.56 ±  3%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      1.32 ±  9%      +0.3        1.64 ±  4%  perf-profile.children.cycles-pp.update_curr
      2.76 ±  6%      +0.5        3.25 ±  3%  perf-profile.children.cycles-pp.task_tick_fair
      5.24 ±  6%      +0.8        6.04 ±  3%  perf-profile.children.cycles-pp.sched_tick
      7.99 ±  5%      +1.2        9.14 ±  3%  perf-profile.children.cycles-pp.update_process_times
      8.45 ±  5%      +1.2        9.63 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      8.75 ±  5%      +1.2        9.99 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
     11.23 ±  5%      +1.4       12.66 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
     11.50 ±  5%      +1.4       12.94 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     12.26 ±  5%      +1.6       13.82 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     13.22 ±  5%      +1.7       14.92 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      6.12            -0.2        5.92 ±  2%  perf-profile.self.cycles-pp.strcmp@plt
      0.09 ± 11%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.10 ±  9%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.task_tick_fair
      0.05 ±  8%      +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.rb_next
      0.20 ±  4%      +0.0        0.23 ±  3%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.42 ±  4%      +0.0        0.47 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.16 ± 14%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.__cgroup_account_cputime_field
      0.12 ±  4%      +0.1        0.18 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      0.24 ±  9%      +0.1        0.30 ±  7%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.40 ±  4%      +0.1        0.46 ±  3%  perf-profile.self.cycles-pp.hrtimer_active
      0.10 ±  3%      +0.1        0.18 ±  8%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.11 ± 11%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.33 ±  3%      +0.1        0.42 ±  4%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.88 ± 11%      +0.2        1.05 ±  5%  perf-profile.self.cycles-pp.update_curr





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


