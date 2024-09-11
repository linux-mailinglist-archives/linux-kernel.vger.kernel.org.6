Return-Path: <linux-kernel+bounces-325752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EE6975DBB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864DFB23526
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8BC1A3047;
	Wed, 11 Sep 2024 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0hn1o+I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501A13CFA1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726097814; cv=fail; b=DAcjrs7uU+s7rsH3XWAUIMFfUfbFc4C2YSlOd4Rvyx03rfwcVK5w0mt/68QinrylC97rNt7HyJAYw87QMnCbJq0ZYUxNx2e9FKBC4q37iukbeEzdOggBm6XyLp7P/bgJvhZOchDK2q5kBFvkfYL9KklESY7foT5gKRv1pEfzckw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726097814; c=relaxed/simple;
	bh=EyH3gf64tk2id2RO5Tz5mRfhFLTTSJ63htrIIKawLy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZaQdl5QnpAtNE7fW/FlrE2YP/5O9pF+vDVsp1EiWber9pmyoUvZqDT09XQo3hhpuzGL3FZeC+UCXC1xT76UVZ0sKYvY1pKJUQC/h36LpMhjbwLsTbKwbkcm7WHewr+oZ1ZehGAnmO1BwI575FTfSTqbpFl2lvSQnS8fLWM9j7uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0hn1o+I; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726097814; x=1757633814;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EyH3gf64tk2id2RO5Tz5mRfhFLTTSJ63htrIIKawLy4=;
  b=b0hn1o+IwDk8OCE0wKm6/UF/m17MxZspajV0GRoj5ntnnTvUGTskUYCQ
   D1VpRrVJ4uvdtPTz1+rLH6038D/aIk7cNSCqHwBTmsctAf9gKriGI8hN1
   LeAcYQc0QK6EuLRw2OCqcEQzJTgDDZZzVDcAlWAOe2Isowp7HdicPSsO6
   Y22pZNomsyf4eKGkva99owrUVnNTtbi06S4yoYSklmpBRvLunRIUaNT7w
   WYNHaWBnTxH4X2jFXubeVoZy2NZR773WWp9Pl3AXKFP3471Pp0J1pGIpS
   ythwXMN7gxbvvTPMwvNmnoGfnR9jZ9nW4e4oMTJL5EipFRCNg6KFo9T7r
   w==;
X-CSE-ConnectionGUID: jJ3AkJxuQtqQMIjHvKqz1Q==
X-CSE-MsgGUID: kEpICXPDSpGiENcfi41E7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36066027"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="36066027"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 16:36:53 -0700
X-CSE-ConnectionGUID: 0POZBVSJSTikoeWIB2iEpQ==
X-CSE-MsgGUID: b1DoDQDxQ3upbH6eYrTB3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="104980627"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2024 16:36:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 16:36:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 16:36:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Sep 2024 16:36:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Sep 2024 16:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+OSwJr8vWaAZN3UYbc/v6leO+Lsnevm1qDkcznyx8r/nKn4p5+8Mnxh+AOQci32AZyEEF+CgMF2WBbePpIEpcnlKMxzeLtwoTvQ3Li8/5oJK8wua9QzWqcH09ZgqIqagkUmK4xcuHk2+uZS0U0S05Vt5u0mJX6bKHGK4F7YsUep71Ts6Y+1wk8UfQ38XwrHgp1277qoXgSa+J/p9ZbcLBPZhG5FwUnZEwjRjH2qQZ4yaijd2QL6BJYq3EooB1Qf0FUeDGVJOPVDxZxhdxnv0DkkZGAGPyocgZmZ1FO9e85yyAkC9umO6+2Kg8aEXeFNqx1iAyU0OynBHIrtjdvRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+TPCX9ixBTSW1JO6HwFq55+CsDrjF/0lruNW4BZx/0=;
 b=L3o5FY9qAdyXGFSOd5NZQfJTCQJEc+XadEpapK/wHuDL6bw+BNKA0vsEQAHELQ8Xs4Et7XG7T5x1sWj5VvoJK+aHLi2uB+QsXDWmnqczfNqKppLJWwzsitFc8cicNJPqwhv3ed08X8OjO3SMaOw/uq1dpcIw8NxPGKJLRbsdE7XbJHfucD3trezERfU0phain6aTQssqiDNiVxAvRpVspD4KwfSqCPEv9QJwLZzxKrEAgL82cBozBRGwye6EhRvlaf7Bk27ZEHYWzEH2l9wv7L7k2U60V1Y3FfEIRRRF991yZVIG8B1iuaZBlogEow8dEp+ogMcZ4gGdlqcMC2fzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Wed, 11 Sep
 2024 23:36:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 23:36:49 +0000
Date: Wed, 11 Sep 2024 16:36:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>
CC: Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
	<sameo@rivosinc.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Lukas Wunner <lukas@wunner.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>,
	Mikko Ylinen <mikko.ylinen@linux.intel.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <suzuki.poulose@arm.com>,
	<sami.mujawar@arm.com>
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
Message-ID: <66e2298eb64ec_3263b2945@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
 <20240910170959.GA213064@myrica>
 <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f6b0a1d2-c730-4b20-a8f3-afd9a7cf822a@intel.com>
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3ef519-52ac-4b6d-bf58-08dcd2ba9b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LPbXl/JnMLtIs1lqZ/GxPQn+2bNdGFTlP5S7/Iu7OHU1vO8Uy2ieLhDtG9da?=
 =?us-ascii?Q?1g2yjZg4EMwXaTVsk4gU+Uq3+el5cGp8Ab3FNOVFupIRIMcIYfYtab3tHShL?=
 =?us-ascii?Q?YEplzJsZRx54fqRDvl9Z6ujymJ1iVabTkBlmbeQ9PhNWuyhBXIVqv365EYnM?=
 =?us-ascii?Q?eLw4A3idz+2q9X/GRZIeXIUUo4RaALGWH+Q97ctQGYVv3F9AysLhHLjpDmQ8?=
 =?us-ascii?Q?cAZfPzgdw3TLmTVa5ldQ19pMnpKqnO1wqdJALrlC69EfKzSM8nMM2iR1xrrP?=
 =?us-ascii?Q?Il6S0o7EHyiUl8zVFy4dfR2Mu09nbuoExzkE/yXMuLyBz3ef2mbmarBVUGQL?=
 =?us-ascii?Q?AmWmZ856Nv+c8j8QogNZNhu4hdysvS5o/tYALcdQnAFagnmRZK/hu1Q2R2RC?=
 =?us-ascii?Q?TMqqLUlEQHP9jsdR1mEbWmcdtgef+REd/gYi0Z/ns8gwINOrN5wY9As/1w4Z?=
 =?us-ascii?Q?L23PIKW6L84MfY8AX3udSI4+Dn3YFHv88k1bSGKOU7Q/6sEaSUotd8oQMRxG?=
 =?us-ascii?Q?9XqvRPiyWvwUgt0OFoaswRAl/IRaZJf6XIg0l/BLW910x72MWM07eU2EPaoB?=
 =?us-ascii?Q?pH1i0itcOnr269lA1ER7LpzHIV698EjAgAZy5WH+8NqVhbRIhCmXjozdVFa+?=
 =?us-ascii?Q?qy1YOsKhUgQsVAcBeHjv49XKTPmeVaMXwOGXPGCudEzUurAm1B7GEHs8MfQ/?=
 =?us-ascii?Q?YKC241vfPFyRuoeFmxg/8MpefaB/OxwrzLU9WdoB1DezqXlHkrIaZI7MFrB2?=
 =?us-ascii?Q?wAUxbPGgz180eSeQn9AYI6VNEgzBMjj/z8aeugVcIrRvQmqWfPZMYzRBnrGx?=
 =?us-ascii?Q?tlUsZeKvRlWMZqx4dXdQ2SuINlQcqwfmPc2zixcyaZCecsHXu3/OLzDWO+A2?=
 =?us-ascii?Q?k5fArhc0T0NsEjKpxOffyxxdebkTT+s8vQHP+eSG8DeuRz97ZkOb6d7zfv0j?=
 =?us-ascii?Q?4NvbH8ue0PgAAnjVpjwqxc+rJhReJyppxNAUhMBgeRCVB7m/dBEVnzaJfPo+?=
 =?us-ascii?Q?oRWVSENRfb2BQz97dwfSCu6V8xTfJQ/5QjnluwO3KO2MOTW0FhFby4muTt/y?=
 =?us-ascii?Q?JHw4U2QWGDd0jB0kcLqkyn+W32dsUXODgFvfWt9ygUSbocDHj2WxCHDdlKXJ?=
 =?us-ascii?Q?ZKAxzyQARjulCX8L9FP0L10jrqQQ3hptVJZtftSE4bkJwri4GfRGokV18rfm?=
 =?us-ascii?Q?cBgNNDsZ4NYHlp6Xw6V6xfbiYipCJc07Ujubq9TmdH0OUGMiz5ZNqX8LHIyD?=
 =?us-ascii?Q?oDNeqdR1i3KewTA+g3Diq0rsycbNAzFneGuYxCX16IAx2wIWCnBxsH/prcqU?=
 =?us-ascii?Q?PZ4+ASYnjCjigSSmBEyCcmnqfG8uaBpnHskrJVufw7kOoQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mk/4PJzfCabP2VVZxdMZgywzOAT3h8lZ5qjsheAjSGUD2eZ2pV8FMNc5058R?=
 =?us-ascii?Q?x+iP1u8xVxc1UH68iCOoVKo/SQBY7Plo1Jjrmu0K8Ac5bMts7ca04R6ofWfF?=
 =?us-ascii?Q?nUXJUYhKzEn3E+RyndBhqsva1G5XfVIopOlzvg96VEvqVqlwhITk/p0lg5iv?=
 =?us-ascii?Q?t0uC5AYZH0dFYh8lNSo2EXuW8B5iUJ/lgIQ/qa4hZYjoVxNy7VI26jSl++iQ?=
 =?us-ascii?Q?wlpA0O1NcIieZ11rDC7rKiBroiGI6dhXHIxs5+oXUscetNQcVbMhaHMY+A6U?=
 =?us-ascii?Q?LPbot3rV+9W/oZmTw2Bdd9xzWFBZ0P6FRX763cx/Rq/ApzTSGCM1gMMHVNQC?=
 =?us-ascii?Q?r88aQf7wvAWI3V+Cwx7AjlRcEGrFRxly2wGUuYV/C/zAVYIGw9iBoqsoGcjC?=
 =?us-ascii?Q?66+YsbbYC2Nt6aCu9lkwZwd+BqDy2d3/xOGvdWKfh6GME7qbsOt10sVD15MK?=
 =?us-ascii?Q?KdcuCwbr0aeC2/qbcBAWmLdkP0EaPEJLigXLUBD4Kycr+rb2C2AIWKQIPg+i?=
 =?us-ascii?Q?7tt/g78m1iGB1ojdJ+0ZJcoEYEzGiurwjaAzp+l1nmy5hndVgSTzUZMdzrGM?=
 =?us-ascii?Q?HT//5zXksnGkCjf4NeLqTJBCZ89CjYEnd9Loa306pY87LrWje2Q9AKegX9bo?=
 =?us-ascii?Q?8P4KL7ECP8//rg+HJNzlUTlcJMeBrW+UHe7xVhTxNEQ4eTEvkJYDOXy0CYPU?=
 =?us-ascii?Q?F2sxpXD7ZDTDm2G1G9rOHYVhvhkipMlzP8Xt8s6n0/KJ/IPGs6c73pLiVOxm?=
 =?us-ascii?Q?x119pkHvA8itAi+L1Uq0fOwhxRAT3ygsAmBfg3xDxIyuxvZVxMgo1PIxkzU1?=
 =?us-ascii?Q?r4AWT9oIUq7M9iPBjWfpB+F/zkAutOxVD+Tj6SlhmMr4swvbLfei6c7sngl9?=
 =?us-ascii?Q?NupHG7vo5HqxTt9y/rDAfPtbgyk+8qdYGumeqSO/DC/zNl2jJsu/tr1sQxiS?=
 =?us-ascii?Q?fWcXbiIMNG+Vu5gW+S+Dg6+HpbrZXRDzlOW8g5PXw93HZegURQPrsSRtqLXU?=
 =?us-ascii?Q?YgzLyIHlxlIf1ZVKtnxwbOku9qJ0VEKIN7K+7bF/35Jx24Xr/851AZGZXWuW?=
 =?us-ascii?Q?ryhj5COrLdtlmCMDcx8zu1zCaC2nwHjUOQuBvf9rqtN79Ck5FbQe0lD5RzZs?=
 =?us-ascii?Q?6yQnktJhiLSU0rmYAd7nRJ1PFyNn8H5CfA2lm+zVYmrRm6G8YO9qiV+xwGPP?=
 =?us-ascii?Q?uOYpvyphT4HsrBb8yLv18YIgX+YJHNNcYDcb/p9yGJODO5c+RLA49QpOGQ0u?=
 =?us-ascii?Q?sHupBEdebUK6N4q7k1SppaYp0xQw5H32Z/TFl1SnzqVOEwFMZvFKc/da9o+y?=
 =?us-ascii?Q?/lO0cmcCfWRKeJvR6d+TCq22XsYRqRH5/VcihGnhEwztaHCtBRKIsTjHxZfy?=
 =?us-ascii?Q?ojYBBrt2C9TUTIPRLGlhcJKT+NfJWSLGZ6lB5jtAG7qtxWLFQjl8WmxglXQ/?=
 =?us-ascii?Q?ceMnrRGL3hzZgQc8cmgk0OhCrC//gmRQ4XQq6GzH82yn5y6uPeWWE5PVMyVy?=
 =?us-ascii?Q?79xdGqu2Heom29nHpjm7rQFS3tghU/fn1qSkj13nxbNmJcDCR17GKrFetVKW?=
 =?us-ascii?Q?KB2LTbT0GqLP2xmEsVdX58l9QRuW9/DClW+36eno1XycBG1ml8lxvcngAtdb?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3ef519-52ac-4b6d-bf58-08dcd2ba9b97
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 23:36:49.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4Ab3hV9I9X6pYSNy1cBDzKcy1gtDulMqOqhiwgpnmnjGebP3dV6RVATXZZNn/PTnRzXtCPdeCiRYxJd7udpO4QeCUWMvp80N9yaMcziAIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com

Xing, Cedric wrote:
[..]
> With regard to the location of the MR tree, we picked sysfs because the 
> MRs (and associated logs) are global and fit more into the semantics of 
> sysfs than configfs. Dan W. and I are also considering moving both 
> report/ and measurement/ trees into securityfs. It'll be highly 
> appreciated if you (and Alex, and everyone) can share your insights.

I would only expect this new measurement interface is suitable for
considering securityfs. The tsm_report uAPI is already baked and has a
need for the multi-instance support of configfs.

The rationale for RTMR measurements in securityfs is because the IMA
measurement uAPI already lives there. So it is more about following
precedent for co-locating a new ASCII RTMR measurement log in the same
filesystem that provides ima/ascii_runtime_measurements.

A multi-instance interface for virtual RTMRs might be suitable to live
in configfs alongside reports/, and use this native singleton log as a
backend.

