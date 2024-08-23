Return-Path: <linux-kernel+bounces-298166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F363C95C34E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A924C2849E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465761EF1D;
	Fri, 23 Aug 2024 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3N1DPLR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79C37171
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380406; cv=fail; b=EayGuIDTTaQwlqZAaPNIyfncwkYbaK2orI9DTjN6UeLLBMX0T7aMQKeJ2ZLxiHs7Y076wZrUGXYXsf74P7BJnlEXXiEA0+HFmdiQo5PsGlXst/YYoKnwhtMH/SWqifs3ejaCizaDSxuP6iyzAICN1I9Nb6LDP72C/iGepuRIHdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380406; c=relaxed/simple;
	bh=hI4sIHA7upAaEvqf+mHwA+glxaBi1w3oh6nzeuIADGc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9HqAth2On3NkbMXlRVXkTWc40rZw88b18bPc8FWYkB6pL2AaWiLapyxYjSc1TC8W9w/BeLaGlbfHiuFAaTZdeWmwahFffHi4lJjKlih6lw/I8jEZIsTNPY55Ak30byRwJrNu25EAzcoyk+YzRgATBCTIPc4An06IBCJp+wfdjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3N1DPLR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724380404; x=1755916404;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=hI4sIHA7upAaEvqf+mHwA+glxaBi1w3oh6nzeuIADGc=;
  b=D3N1DPLRpPLmQ68LGgwj05MkzVTxXrVCgBmtZBmpnE04ks+hPK+IQWQN
   08B/Ie2fRbpX5yOQMKdRt1dip88+YcAPVJ3ETkeUpWjW3drCPeqnRPAHU
   4SlvYZYtEVztGPDwHu3JJfzoyoQqJ37zv/0Tkg6OT4nCdiGkJmST7sYKY
   h/mErLNnbihQF/oqWIwp1aDKNb+4/MpIfPYz+6te5Irvm/7jUFEokcEtg
   aC+VihpuT6S7EdazQ8R7oSPR4yJFM/eIXZ/OifdrFX70kVXyacUDwVVwI
   Acduq0E/r/xB4nDoyOTbdu/26lhFxNobkTyCHAzMpjS4biIeOFmy5oX3K
   A==;
X-CSE-ConnectionGUID: JusF9DeLRJmkNdDLDt++uw==
X-CSE-MsgGUID: FcOQORYHTQinJ98AIdAR9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="48227204"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="48227204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:33:24 -0700
X-CSE-ConnectionGUID: VaM9SG6YSSCUx3lZ+E5P8w==
X-CSE-MsgGUID: amuDXAZATDejHPk6tKxJpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61678857"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 19:33:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 19:33:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 19:33:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 19:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxkbRoi6A91PNzOD0Rt2NY1ktPYA16HlZuM5KUDCUcj6gqsdl1BbK5I5To5M/6tauQYkY/LqHewFU6WMz6LhrXtbkvwa1a+p7aR0b998KjznANL6VwBLVLy0BLSefB1L8zJEPmXWhu5uJm7RDhEJOto5HzP9OPSkzoaM9pze3ZL9xMnorhyufjNF07oILkTo2LXoYl1Sb3BQvtw3BlhOFz+L29plVlYoGsnNg1+4+Wj6dkXtkiigKyseul/Wbpv94lwLEFqtN2N1rXv1nKXgPX5i1cVK6xfD1eWLUAn2xbcPVy0u3wlg8cq0+AVhzWrs1ck8MFZzm9cfHNp7vluvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibOZ6Fyw+C8kOflTIXgHQPozEtwuhNATMM6VKZ+3bKw=;
 b=PR90XnQyiojpPkH6xxoiV0U0275oNNo5pUjSOZYTSKyTAEc9Npxvy+wEWSOUsKrPUdGkANLMt4eZOV0aDfV3leQxVIRxsOFBuzEt1ZLLZKlj0nMri5HPOMG+DNuTxraZIYYO5ErDWa3ks9O3/beoqeqcrjwSOcxSt+IFjHwktTpjPnO7Zgz8ovwVV5oBrLra4zlYwF9JT0XSxsJDQ47D+o2lhoOcOHwImCB5ycoNbmHvQSpsLHJnsWfKuOG0OCj/N5IFqFC3XCV8BeGR7dpxrMJYi+OZi2JgamX6c3OfFe5q+Beu27h4CSSCaj6loIoEdsGIOlUzKOZh32GH9OxdhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5307.namprd11.prod.outlook.com (2603:10b6:408:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 02:33:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 02:33:20 +0000
Date: Fri, 23 Aug 2024 10:33:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhiguo Jiang <justinjiang@vivo.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<opensource.kernel@vivo.com>, Zhiguo Jiang <justinjiang@vivo.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] mm: vma remove the redundant avc binded with old folio
Message-ID: <202408230938.43f55b4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240820143359.199-1-justinjiang@vivo.com>
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 1913e411-c171-434d-9477-08dcc31bf3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Xtr0+/YAwizv9jC2NtdCDgsGOTEFSIuFCL38PsHNUygXKjdwbNEMOjY5y1l?=
 =?us-ascii?Q?CEPooz4TVtOljjetK5XgrlO56YPT7oj46+EOewxYleHBY1nSnDCI0IJ7lReY?=
 =?us-ascii?Q?g6i1TmJE4PqlZ4Vvj8PD6e7rYLQDYHTuc71WGDZaR//IuoEZuwFrcQGOSdZm?=
 =?us-ascii?Q?8+P797EHZgnaOhazeiMDWR1vdHj/7ic1ZGLmgQtwvTWTYFvgDrfPq69bKN3u?=
 =?us-ascii?Q?wNpC2m7ENrKlzflZBcC5U0gEqtn5Xnx2NBVRi8TaDdrrkkYsRGn3XK6F6dnz?=
 =?us-ascii?Q?EVII8SR2lUxzWLs16cBGBc78D3Bjx/5UAgIUVUQhndl+j3Dto0q7Okkt2Z9o?=
 =?us-ascii?Q?6I0tD61p4jChBUjAyoC7QgMw1d1rewTbZOu9Bit1DCvDqoVE2FogeN7vES3L?=
 =?us-ascii?Q?9nGqfOPgEMMso26f6lsQ7MESpSg2Jmf+8gUNmfFA/OABR5EU3EHSiWfWU55q?=
 =?us-ascii?Q?yD8zoy5omajP2NxmMPU2LgUzHPYsD54d5PfJPYtA2R7mmSWPlLdasKrb1MEh?=
 =?us-ascii?Q?JNllnZxgGFGtf/fgxm8Wwqz2ZNbCMyfeyRdMKMSiTDz1b9wvxIOr1nGM47un?=
 =?us-ascii?Q?Z9k4JVLrvs1XYuLNvchG7XH4ikDdEEBYOHe/q8YSb2OrYZtRAAwy8GvkvzOz?=
 =?us-ascii?Q?V3Vulp8hiy+xZKUN4Xks2rjIEinkgV/9MjyIS8JcEoXZmTx50DO/b+qSwyuL?=
 =?us-ascii?Q?8jxla0+HQAbkQF9aZUdns97c+49T5Qr9NeNdWsHwh7WHclW18H4XpJQfuFNU?=
 =?us-ascii?Q?NJCwIf4+s5ynWr2S91yB7txfTEE1MirxyJ+JHj33W8HoLAObw5PEWl7C5/Mu?=
 =?us-ascii?Q?DD5o3/6a+t3ulEHY8B+1VMlpgQX3Hbioj/ztXF/BgvfUuWjYq2z0HoHUaZVQ?=
 =?us-ascii?Q?nJUNMn6/laPnR8qPYI1CcbwP3FYUlnTrTB3phIDUIL90cJ1AirKxw+BTo3tF?=
 =?us-ascii?Q?ZULcQqwE9KenkSfecHX3rhXZqVqUF5iL7KxMNlQ/pfpCtJpFROzTQez5FUaZ?=
 =?us-ascii?Q?OdwOUnYQgk2jP8hYmPxtiI4rD7stLV8ZYtNaUfA7TyUD3HlHIfluNC7az+r2?=
 =?us-ascii?Q?fYG2HMUPuImocaYiDXXanX+N6UPidti+xmFTVfooQF/d+h7TSa4F6OJ6wb7w?=
 =?us-ascii?Q?84LrrtgNy/CsxqJKFkfYpoLuecjyurVcGQC2zvxgqSJq4AtydEQ8cZVI05rD?=
 =?us-ascii?Q?NCJNpHgoZNxHFbfYmv4u0MZqIQkhARAVzXYuKXjcbj1ByJBXPhburEktuymQ?=
 =?us-ascii?Q?RyPlELxKV11UQPtcohxBU/CvQij9RUXwdgfXok3kXAcVy811UnkjPl8s6Czr?=
 =?us-ascii?Q?6zw/amw9ZzS9fbMahifvYIgl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PaBhT1ovlNsgp90WxV0qak7Kgbv8wny8mmokhNcxuMho+f753u+WnsF63w1V?=
 =?us-ascii?Q?aO8YPvDKW9ZDk7ta1vCqpSui3DC1GeIAempyXW4URbv9lSebEowiFF2hs3pM?=
 =?us-ascii?Q?rakM1HNMueoDowcxerSb7FNurz+X9ZNLPwCAnsTNC7RO7uNKC5zk9yHvFYV1?=
 =?us-ascii?Q?mU6oG+xD2H6qxKQ6d70zgWZCASmHVYAZPpIpwfEtWDMZV/ZDtKU1smAsMtES?=
 =?us-ascii?Q?zR39krEqmbm74BhuOHmJPebw8MB3vIrG3T9p4oKzEfh6vIUgwZIHHFVINpty?=
 =?us-ascii?Q?KTeBBGfRT49KIM9GGfRo4qatX9r8T6/gyO8lObj2xnDTyN0LK54tJRsfrfRc?=
 =?us-ascii?Q?/q5QK1F8iu2h7qj4OIZcRiWGq5iOHFbbbXuLPQFeNVcNQFGhxoDnX83Gs69u?=
 =?us-ascii?Q?mZJMXv+3czrCz43teV3k0mm6RjNqrh42RwCeVXuHVto8voZMZyMItTKaxp5m?=
 =?us-ascii?Q?UWPFlqpOuCECdOW3JLl2d1vNpWu5A5AplRjrWQng60cxltOPwlhfyIdldVR9?=
 =?us-ascii?Q?3n6BFoQ3uox9u2AeWaNpZcHOwdakvtiMX5mlpql3NB/cqwFWwl8D4FAOGPcH?=
 =?us-ascii?Q?AE6cEmdxGl1QVYB9zt3rY2z0SBZqdPrvlYYOAQJl63TcWDWXRkxSKKuTpjKB?=
 =?us-ascii?Q?r+8z/qbRCRMtXfQcfiuLCaH/lxaXsuP5+T1t/Kh2muJihVwDAyJh3FE43WbP?=
 =?us-ascii?Q?Qb8bPciNvjAU1o8WCJZQbTmRhIwYT0wpPcpzg5PVK5UK5gjH2rH87YeRjv26?=
 =?us-ascii?Q?0XCiU/m5HVMkDUHkft8/o9HplCYEtt9fL5x/U74DmINOtG2pD/zZJgP3Roaq?=
 =?us-ascii?Q?eBLfftiSK45/J53aMutFYIcv7fay7otkExCH41TZd6zvNZxC9B42h3m1bOLr?=
 =?us-ascii?Q?v6LxhHEkoizy2u5oLjab7Q3nml6BNu12P61HHh/0khCeaflckHaQrFr0NkaO?=
 =?us-ascii?Q?mPjHz3RH+zPxvGcln116uKjS6MrJLSYj1JJiVut8V1U0W1a58XdzhvlbdBUJ?=
 =?us-ascii?Q?xmQg/o2+ud8dJVubkzX8Z76UUrlpVgxUnnDDVqiqxRpQj4mdsXIotATaNHiA?=
 =?us-ascii?Q?wYNf/Lcuxa6/xzQJTHvFjXgSWNouGBxQvQ4HqFB77j4Ovv9adDKGYMhvklgr?=
 =?us-ascii?Q?Db57VYaNzNf53JfaMUWZ0J6WmdnDkbvryIc27G/jYcBVia9Ihoauv7kARP6/?=
 =?us-ascii?Q?VNP28drgN84qJ1RjSgowY+zIP/3w7+bZQvDmY/oM/m1Sx47A2x1Qxpd6ELeO?=
 =?us-ascii?Q?bJW2cgSsb736TSv9SeF8aqnrNlg6NkOUk0/H3utm1BxRrWGUrcwUVOejXBIN?=
 =?us-ascii?Q?GcGqTug5AyG1SgmVLInQozcHySTDKcBLn2NDe4xhnvBd4j8c2Xlli/K0ZWXa?=
 =?us-ascii?Q?JHiTYBKw34ubIDyTIOir0IMT244jSgUl2Dg9o8rH+Wrd0IuL0z+FuNxPATMW?=
 =?us-ascii?Q?XTzGDOowxporsnglZZoEu8Bo2YzKznZbGPMkmvU3Jhlc6WsfUInR3JkJZeUg?=
 =?us-ascii?Q?g7F4qz990E7Ux0OUlKh1ncd5X44rNYXErqEyGBTUR1CRldm+PaCpVd3hhcT3?=
 =?us-ascii?Q?ejFFsbbTrk7jO7a8h/Oey9XIQHr00a5XUXd0tPy3ePmOtEZr5ieyu9/wgLik?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1913e411-c171-434d-9477-08dcc31bf3fa
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 02:33:20.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHyp/NXAoY+H68HtG/rypznfH39lGO+gMiHK4mCdGsXfAK6Ix2kMWvDXxl3ctz3MsVw6L7LJ/LeHDqbo6s1N+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5307
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/rmap.c:#unlink_anon_vmas" on:

commit: ae307233d6efc18c3d6015b127b099450ca8588e ("[PATCH] mm: vma remove the redundant avc binded with old folio")
url: https://github.com/intel-lab-lkp/linux/commits/Zhiguo-Jiang/mm-vma-remove-the-redundant-avc-binded-with-old-folio/20240820-223531
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20240820143359.199-1-justinjiang@vivo.com/
patch subject: [PATCH] mm: vma remove the redundant avc binded with old folio

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------+------------+------------+
|                                        | 75bee94793 | ae307233d6 |
+----------------------------------------+------------+------------+
| WARNING:at_mm/rmap.c:#unlink_anon_vmas | 0          | 6          |
| RIP:unlink_anon_vmas                   | 0          | 6          |
+----------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com


[   36.655884][  T197] ------------[ cut here ]------------
[ 36.656843][ T197] WARNING: CPU: 1 PID: 197 at mm/rmap.c:443 unlink_anon_vmas (mm/rmap.c:443 (discriminator 1)) 
[   36.658183][  T197] Modules linked in: sg ata_piix libata crc32_pclmul crc32c_intel scsi_mod polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 aesni_intel scsi_common cmdlinepart
[   36.660508][  T197] CPU: 1 UID: 0 PID: 197 Comm: lkp-bootstrap Tainted: G                T  6.11.0-rc3-00378-gae307233d6ef #1 5ff8330b382acbcd2719e520175822ac6c64d0eb
[   36.662685][  T197] Tainted: [T]=RANDSTRUCT
[ 36.663288][ T197] RIP: 0010:unlink_anon_vmas (mm/rmap.c:443 (discriminator 1)) 
[ 36.668434][ T197] Code: 7f fe ff ff 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 90 0f 0b 90 eb ad 90 <0f> 0b 90 eb 82 90 0f 0b 90 48 8d 7e 08 e8 2d a2 bf ff e9 ca fc ff
All code
========
   0:	7f fe                	jg     0x0
   2:	ff                   	(bad)
   3:	ff 48 83             	decl   -0x7d(%rax)
   6:	c4                   	(bad)
   7:	28 5b 5d             	sub    %bl,0x5d(%rbx)
   a:	41 5c                	pop    %r12
   c:	41 5d                	pop    %r13
   e:	41 5e                	pop    %r14
  10:	41 5f                	pop    %r15
  12:	31 c0                	xor    %eax,%eax
  14:	31 d2                	xor    %edx,%edx
  16:	31 c9                	xor    %ecx,%ecx
  18:	31 f6                	xor    %esi,%esi
  1a:	31 ff                	xor    %edi,%edi
  1c:	45 31 c0             	xor    %r8d,%r8d
  1f:	45 31 c9             	xor    %r9d,%r9d
  22:	c3                   	ret
  23:	90                   	nop
  24:	0f 0b                	ud2
  26:	90                   	nop
  27:	eb ad                	jmp    0xffffffffffffffd6
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	eb 82                	jmp    0xffffffffffffffb1
  2f:	90                   	nop
  30:	0f 0b                	ud2
  32:	90                   	nop
  33:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
  37:	e8 2d a2 bf ff       	call   0xffffffffffbfa269
  3c:	e9                   	.byte 0xe9
  3d:	ca fc ff             	lret   $0xfffc

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	eb 82                	jmp    0xffffffffffffff87
   5:	90                   	nop
   6:	0f 0b                	ud2
   8:	90                   	nop
   9:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
   d:	e8 2d a2 bf ff       	call   0xffffffffffbfa23f
  12:	e9                   	.byte 0xe9
  13:	ca fc ff             	lret   $0xfffc
[   36.671148][  T197] RSP: 0000:ffffc900019ffad8 EFLAGS: 00010202
[   36.671931][  T197] RAX: 1ffff1102e73f0bf RBX: ffff888173c55ab0 RCX: 0000000000000000
[   36.672880][  T197] RDX: 1ffff110241d68e2 RSI: 0000000000000000 RDI: ffff8881739f85f8
[   36.673933][  T197] RBP: ffff888120eb4700 R08: 0000000000000000 R09: 0000000000000000
[   36.675002][  T197] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881739f8550
[   36.676082][  T197] R13: ffff888173c55aa0 R14: dffffc0000000000 R15: ffff888120eb4710
[   36.677134][  T197] FS:  0000000000000000(0000) GS:ffff8883af300000(0000) knlGS:0000000000000000
[   36.678328][  T197] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[   36.679207][  T197] CR2: 000000005663e33c CR3: 000000012021c000 CR4: 00000000000406b0
[   36.680251][  T197] Call Trace:
[   36.680681][  T197]  <TASK>
[ 36.681079][ T197] ? __warn (kernel/panic.c:735) 
[ 36.681682][ T197] ? unlink_anon_vmas (mm/rmap.c:443 (discriminator 1)) 
[ 36.682312][ T197] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 36.682920][ T197] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 36.683494][ T197] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 36.684125][ T197] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 36.684804][ T197] ? unlink_anon_vmas (mm/rmap.c:443 (discriminator 1)) 
[ 36.685501][ T197] ? unlink_anon_vmas (mm/rmap.c:400) 
[ 36.686185][ T197] free_pgtables (mm/memory.c:410) 
[ 36.686819][ T197] ? free_pgd_range (mm/memory.c:367) 
[ 36.687466][ T197] ? preempt_count_add (include/linux/ftrace.h:976 kernel/sched/core.c:5634 kernel/sched/core.c:5659) 
[ 36.688179][ T197] exit_mmap (mm/mmap.c:1934) 
[ 36.688758][ T197] ? trace_contention_end (include/trace/events/lock.h:122 (discriminator 52)) 
[ 36.689496][ T197] ? do_vma_munmap (mm/mmap.c:1895) 
[ 36.690125][ T197] ? __mutex_lock (arch/x86/include/asm/preempt.h:103 kernel/locking/mutex.c:618 kernel/locking/mutex.c:752) 
[ 36.690779][ T197] ? __mutex_unlock_slowpath (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4329 include/linux/atomic/atomic-long.h:1506 include/linux/atomic/atomic-instrumented.h:4481 kernel/locking/mutex.c:929) 
[ 36.691585][ T197] __mmput (kernel/fork.c:1346) 
[ 36.692143][ T197] exit_mm (kernel/exit.c:572) 
[ 36.692699][ T197] do_exit (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/sched.h:333 kernel/exit.c:930) 
[ 36.693256][ T197] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116) 
[ 36.693947][ T197] ? stack_not_used (kernel/exit.c:878) 
[ 36.694605][ T197] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 36.695304][ T197] do_group_exit (kernel/exit.c:1069) 
[ 36.695908][ T197] __ia32_sys_exit_group (kernel/exit.c:1097) 
[ 36.696561][ T197] ia32_sys_call (??:?) 
[ 36.697142][ T197] do_int80_emulation (arch/x86/entry/common.c:165 arch/x86/entry/common.c:253) 
[ 36.697852][ T197] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[   36.698504][  T197] RIP: 0023:0xf7f03092
[ 36.699039][ T197] Code: Unable to access opcode bytes at 0xf7f03068.

Code starting with the faulting instruction
===========================================
[   36.699967][  T197] RSP: 002b:00000000ffcfddd8 EFLAGS: 00000296 ORIG_RAX: 00000000000000fc
[   36.701055][  T197] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000003323d2f
[   36.702120][  T197] RDX: 00000000ffcfde00 RSI: 0000000056633734 RDI: 00000000f7ef8000
[   36.703147][  T197] RBP: 00000000ffcfdef8 R08: 0000000000000000 R09: 0000000000000000
[   36.704165][  T197] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   36.705185][  T197] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   36.706281][  T197]  </TASK>
[   36.706698][  T197] irq event stamp: 10051
[ 36.707257][ T197] hardirqs last enabled at (10059): console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 kernel/printk/printk.c:341 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 36.708455][ T197] hardirqs last disabled at (10066): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2801 kernel/printk/printk.c:3120) 
[ 36.709660][ T197] softirqs last enabled at (10006): handle_softirqs (arch/x86/include/asm/preempt.h:26 kernel/softirq.c:401 kernel/softirq.c:582) 
[ 36.710805][ T197] softirqs last disabled at (9997): irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:649) 
[   36.711941][  T197] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240823/202408230938.43f55b4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


