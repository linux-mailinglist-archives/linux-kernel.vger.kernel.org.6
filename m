Return-Path: <linux-kernel+bounces-326639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0F976B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB96D1C23A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA801AD24D;
	Thu, 12 Sep 2024 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKIpMhL/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F014F6C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149042; cv=fail; b=ejtx7fTb9uvG8bDKZw1yhTHTnTE0276Kxvckf9st7ij5VeTFPgxlAQFR+CWxvDzvcksz2rUj2sL553gh5/NBTJdrY0iJJJG2Ujhwse5RHRDrzlpLMqUfGqU6BzioUGmQr2LaZ47c1OWFbSSpWir6Wbu3NSldWCHZ2y3OIk2Z0DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149042; c=relaxed/simple;
	bh=K6w+GpA0+Ik6stG3vjJ+8HD8EDJID1/2FOXUXJyf6Fk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JHuwU8pz9QmNtYzrbq9/b/4f2+T3g56BfSr8/HIKLVJ2lxV+b6w1247ejlrN2Zlzmi9XsLnjkaeMrXImGwhAluvS8Glfedj09kmuAgVMkhvscK5ZJKltEGjgMJ36am+H2O/0xDQpItONPhOurCZAM41jgCyGMR+hveFgxuK5K5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKIpMhL/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726149041; x=1757685041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K6w+GpA0+Ik6stG3vjJ+8HD8EDJID1/2FOXUXJyf6Fk=;
  b=OKIpMhL//9dcnG5aOggQTfKOWozQRDaIJCg7YRkD+NGq86b/Q4EFeJqM
   e5+LtXkvtpJtPkVHchgVvvLMonZP1SHb2qsmd/dSQm+pmKyw/sgwg1vae
   SY9AcRPkXL9TvrGfzDUDLew9eR+XXFWg7wQ261cLKX9NYj/zUBIVbTWt/
   IWEeYxOybbSgT+HRxa7KZHCIP8f1ai2R2DE3XUB1vUobyJofntjExzRqM
   61b+80wiNwn0Nk6kbYt7fWuKgdCEly223f35qKbICfJtKaLyogKUejN4l
   jnLtYNLBZ+pVWiHcoEpdGe7aAGxkK1G24w1w+TRspOsqgPbVYk0SA92vV
   w==;
X-CSE-ConnectionGUID: 2BGi7xTPStuyfIl6gxbF1g==
X-CSE-MsgGUID: zymx63uuRb6k1btsNR2uUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="50418230"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="50418230"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:50:40 -0700
X-CSE-ConnectionGUID: 3Z/W/rG7Qda+PPz6eXfr9w==
X-CSE-MsgGUID: tPHZ35RCRiOtRD2xnw4u8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67947239"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 06:50:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 06:50:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 06:50:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 06:50:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 06:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtkZsmx+c6N48ks8Cv0ewQgW2wEoxLLiqNun4DRYggAll39Cep9l3Bf0t82Zk8gLViUAkugvn64z/CMsmRE+5hdx9I3Ps8KwlMPMiCxITXQ9frgZRdftzGA55Afo3MaVu9wRYOoVkaZo1UlCq4CwgoSXYIUdotWqybZ1PAHyow3dxRNq8pX+K4cP7QCdSHgAIV/ICAdV1QG+yn0SlBUetdKxy+IGuSP6xPlN9Y6EbxVAtXIbmd0iycpOx/7WfjaORGQeUMvIzNvv4tNFoQ9QDFEo4s9I8U26W01zG+Ee2LrVhXpgaeaL/K53cOi3dETkyHVYs4nZR9AUHfgGco0qVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdiWKXHaiRAJBgJUJXf0+Xmp3F1qi8WjplIXxmhEFTE=;
 b=aIx2gmTJmwNFtvcWPpcSqnLTIfOAlOQetyqG4yqpYG1vdhHosIHo0nLuW14nLqBGaFvHi8iIBheZW5j8GlWCsGfA+Fr7yKoe2sBBhKt9MHVYLV+JFP9P4XIh7us+Ha1JIUj6WTxTo6d5g3pqV+7ZwcxihCYFO0XGTNfqpdWdGWbQhjda0rW/kC03aKCaqDlb6k1XpzLpEbsMXDGSxwO4ikTzZIbJvUTWCDflPLHpYQAz0FVHUcsQ6z35EnYr9y2A0CWwCepr3vum7jqhZGnFtlm1RpyoBf2oqUSRj5ZpJYLZJCqIQPDGvSHI4EVjHGX5hXD1NM/SetjVlcPQrtYe8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8512.namprd11.prod.outlook.com (2603:10b6:408:1e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 13:50:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 13:50:20 +0000
Date: Thu, 12 Sep 2024 21:50:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Chao Yu <chao@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	<linux-f2fs-devel@lists.sourceforge.net>, <oliver.sang@intel.com>
Subject: [linus:master] [f2fs]  5c8764f867: xfstests.generic.091.fail
Message-ID: <202409122131.d6e2f8c1-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3f8a6b-757f-40a0-4de2-08dcd331d744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MH9jeTAmvf2jPWiEfetjED0+xHjc5XCSQFyTDJ0KiyHtdeJFYZd8Lx2eNQt1?=
 =?us-ascii?Q?Sn8sJ8Ro807vsu39Ezrrt+Tiv+2LMq8iKTOR5Lps9r3fkAFO+GWATHuTNkny?=
 =?us-ascii?Q?rPOhvZF/oOwXkSPGA9fQKEH0uGz+mV6W2bQ2JjXNcjs/CG/zpFjey86SkdSh?=
 =?us-ascii?Q?sIfsG+khHB7I1UXe48xMvBv/cNtfPtjGI8F1TQHRxrRJi/OlAn4gOvzbbxWr?=
 =?us-ascii?Q?guu6Ec3DCQdI1sewhHD0wWTFYTnXo7Yv3/HCSGKaZ7dinu2lPD65OrQY023x?=
 =?us-ascii?Q?xuzxMHfYj6QDoG5nfVdxzRq/7keJ2gGIh88/XuAg+GU2yH+JeBxd/SfSnWeV?=
 =?us-ascii?Q?3y/5eftl4NlRd+hu0GTHHYFGPPyXpaUXu6Db4qssDCWYwLMG+hADIXjmV5yx?=
 =?us-ascii?Q?USXPxkIqhZBafDrO0rZ1Qg5Zw40h3z7Ni9XetdnRZJR+QoeCILp7odPSffIW?=
 =?us-ascii?Q?QXqGyihLY97C5a/WpLKPVyZhxNEVfTwxvFgy2RD/GHht4eZbip7ZzMNb6Xea?=
 =?us-ascii?Q?32PngkrO2Im3TYn6rgx7HYMhIbwOQ3hJZbAzWZkrCK2Qmr9Lk3pkA05Em7Ws?=
 =?us-ascii?Q?tGvD9PhQuflKs3yf+QuuT2QP1xVaUQSPeH5kVFbBf50sx9oGIZnoBs/GPnxw?=
 =?us-ascii?Q?I+KkkMli8cBa/SivX97SujudUCltc2fpaGL/PtQjudPJkVhq336rUkL4X5GL?=
 =?us-ascii?Q?RZpqMeD/SBqwwALSz5sBlZwGNcTxKYei+npPq+dxyUmfBdi+ScSPbhNCDf2F?=
 =?us-ascii?Q?Z3dBElE81xsH4yKhsMKWngKjn42CYqzJQ9WRcgZcTd2ugAsqPNSNVPwk91TA?=
 =?us-ascii?Q?/KzvMp7V8TLhGfxQlSXc4jgCBVxAtaJfal+8q/k0bzFsZ/x7h20JuedW3l2i?=
 =?us-ascii?Q?mV3uMpSIobvE8St0oT0+spZZLOaqKI/1Ov8QJORpkcd+eUEuqdg9ukW4VOsH?=
 =?us-ascii?Q?/EJplCwV4bNwJgrPty0DKO7ky9Db2hJj5TIpvlLotP82KU/Iy77h5JRQHlQl?=
 =?us-ascii?Q?sf6KsEWBHk6TUdRPQ6DKwTOcc56YDaVgOsXKlnmL+Bf+c09kRBh6eo6DHEv3?=
 =?us-ascii?Q?oliOlm4hdgp9C5C2NTz7CKV4bFTIqihKymZBkQmHcuIRlUx8FmJ+FDGv9S80?=
 =?us-ascii?Q?q/LGKf1Zyffg9VzWKIyAJZjYzZsBEj6xJc8bzHuTv8DjGuf4/DoUP1UQpZE+?=
 =?us-ascii?Q?945EjvsFnEI9GxBm6acT78Ez+YPtzZGxqgJLKEXK3n4laoMrrsybkoUafkRz?=
 =?us-ascii?Q?yMd5orHDaJO6cnshfkHubY3vkByA7oUWkmG1WzvH+8zSuQnfkd78hgHvL7Ub?=
 =?us-ascii?Q?4rVzWkjqWp/xuLT79NtJvuZ/GWkv3Uj+wn0nbEab0ndOqzj/9TD+/o5YCYrA?=
 =?us-ascii?Q?7M7fKFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LeKwaBKOpxgFIj0LpiQXMXtI37rCEk5RDsSO7tPhyGC8e4KnZE46d/g/QyYI?=
 =?us-ascii?Q?+H1ilWlzjcdOKsO5YWUCVBjy4PLBjul+ZcQZ6pSveopkgivOkrcaYIKzmUAN?=
 =?us-ascii?Q?JRziZMUzykOpy1fbSgxV0ZInsURRG+mKpxIJDYyuvRv4v0YxUK/Qcv/mSD/7?=
 =?us-ascii?Q?xKLgzGkhpEMERNrkggV8Rp0IBRl5YHaIVlb96rh2SGVYStESv4+MKjXrWd9E?=
 =?us-ascii?Q?sZc3N6GNhaPuvEQ8dxAH5OYan4BAyXU2gts+c3I7lmhcmKuPYpIuyyyKqf92?=
 =?us-ascii?Q?EfZ55TKR0vIApWpJpnj42iSHTZj9y7ZFSHsGxq0BkeCWhSPDvkiK8eL85GYn?=
 =?us-ascii?Q?7dyQf6ccfbWyG8T2fAb5WUcd2MnYtEgvvOBUQLnWH6Yy+NBSGNjXKyUGcm6U?=
 =?us-ascii?Q?2RHGc0wdPLZBrffy0PN6mWulkj32pnNrj2p8LzHkFpw1HhfuyYloSJsxBg2q?=
 =?us-ascii?Q?aZcyK9w3LpHCjfVN+WYBRd++sgr8pTsdpjEosvN/KlmepFdw0rgN2c4OXL0V?=
 =?us-ascii?Q?iIU/dP7EzrzwnaYFC6kt9eg1ElETSIa2Xv4c7AEr8qeC7b9StK3T7s1jwhjp?=
 =?us-ascii?Q?COK45alJXxFCf96UBIZrnGPbtdgqG8J3hILuT7NMtxBvC33SIdvTFwz84gPK?=
 =?us-ascii?Q?72YQhM9Jpf/yQwWNeD4EvNB0vPh/DKlXkggG2P0ujUWvOA5a8FV956OOXNet?=
 =?us-ascii?Q?ttD4hCP2vqe6sIFB4mZ8gcXdiNPjwipZ8zikVK9mzvh4J9JUbdIEJoEz1loa?=
 =?us-ascii?Q?lT6kxLJl0R2p+qYLa9Z2YqjlIuFVxx6Np9A3fvKUb6uAbwPGBt/jQlPcGfSd?=
 =?us-ascii?Q?Pya1G8u86ogESkkhf9hY8jhoBbGkpVzNuIM4lbVIiY/tfLU0JDwrEwgJH6FF?=
 =?us-ascii?Q?+72KtkoZEp3NwQRW8P0qhvoajrWcRRR8UG3tnA75QTmtOmtQX/xd67Fl/i82?=
 =?us-ascii?Q?EYHOYXOks9wMg5cwn8/LYhdFQ6JnRNdrrMZt96Rr5PCMqwEsokj0JPgL82YS?=
 =?us-ascii?Q?pbPuEJWUJj8jZra5y3NxI7mtRS2Nah6m22CdOqN1OpXezUQuLZkws7KdgA7j?=
 =?us-ascii?Q?n7E0rQhQacvuTV6v5ZIklJtny1vO0J307J0gfq51j9bIxdRSES6zaJkTm1RN?=
 =?us-ascii?Q?Iv4PRDPPht4/9naYNtNfBSJeqGGlT49hr21rZdf0hslUS5CJx1C4QBI95fMq?=
 =?us-ascii?Q?5qpws5n/kiJXOQ+GCybzLGHkfAy6k9O2G8xv5jpAn+KC9ZqNAfYjFh05qBus?=
 =?us-ascii?Q?ENIonLoHSHdmDjKc9eysjtk6Pa3Q8Wp0pbgnsWP7756/AhuMeswXe6ALThBN?=
 =?us-ascii?Q?X5EacW9Qdh6fEaS/nvBoz+92kT7DyLUkCz+DIZFzL26vAfHFAfPcmKLBsJWg?=
 =?us-ascii?Q?tujve+ZySvqVMGOw1zGzHpdqfyKYG698Gh/nXD79swYhZ8SNdySf6I9dR5qG?=
 =?us-ascii?Q?TeEqA1C86s4DyxWbceaMTOlJFVN4/WAxB6/JwHWdD8aoSuSvVPPWe2v1U4e8?=
 =?us-ascii?Q?CYU+bxLNF9tGmoqVNNuRB242KOqpnvfkgWD9aISUcIxCiUiJ8u5700PW+Vye?=
 =?us-ascii?Q?DCmOnRvnVuPPEZ0Um7oUZrktWgcx4ls6lXj81bM9o5f6tFkY5Ep4tZAwazDh?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3f8a6b-757f-40a0-4de2-08dcd331d744
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:50:19.9464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PJQO65wDo9guGXv9ELSiUbi15Y9dhzSkkuRDuy47h2OhoFHzheFVEzZg0HKVXzU4vW6KBfdPioPEHyZApV3kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8512
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.091.fail" on:

commit: 5c8764f8679e659c5cb295af7d32279002d13735 ("f2fs: fix to force buffered IO on inline_data inode")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: xfstests
version: xfstests-x86_64-b1465280-1_20240909
with following parameters:

	disk: 4HDD
	fs: f2fs
	test: generic-091



compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409122131.d6e2f8c1-oliver.sang@intel.com

2024-09-11 03:13:26 export TEST_DIR=/fs/sda1
2024-09-11 03:13:26 export TEST_DEV=/dev/sda1
2024-09-11 03:13:26 export FSTYP=f2fs
2024-09-11 03:13:26 export SCRATCH_MNT=/fs/scratch
2024-09-11 03:13:26 mkdir /fs/scratch -p
2024-09-11 03:13:26 export SCRATCH_DEV=/dev/sda4
2024-09-11 03:13:26 export MKFS_OPTIONS="-f"
2024-09-11 03:13:27 echo generic/091
2024-09-11 03:13:27 ./check generic/091
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 lkp-skl-d01 6.10.0-rc3-00027-g5c8764f8679e #1 SMP PREEMPT_DYNAMIC Wed Sep 11 10:37:47 CST 2024
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/091       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/091.out.bad)
    --- tests/generic/091.out	2024-09-09 16:31:23.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/091.out.bad	2024-09-11 03:14:07.468026185 +0000
    @@ -1,7 +1,55 @@
     QA output created by 091
     fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
    -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/091.out /lkp/benchmarks/xfstests/results//generic/091.out.bad'  to see the entire diff)
Ran: generic/091
Failures: generic/091
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240912/202409122131.d6e2f8c1-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


