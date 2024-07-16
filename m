Return-Path: <linux-kernel+bounces-253461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E64E93219F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AFE1F22AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380AB48CE0;
	Tue, 16 Jul 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0kktFRp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309621A04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116978; cv=fail; b=PTaJNPD87JhBmqAEyaM3IUOrGoQ01lCNkbySBK/C9xAKHBDjduwU+zFfViTZNcbZEp83WDfeGRpALrslDAnVjmLpmZdX7Lo4p/oK6EdrQeJ5oakjbA+mep5zSpFPYITuYWMdy1dxJKAzaZsESPlrIu3+57nU8HwFS0BQRE0L+ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116978; c=relaxed/simple;
	bh=Qnho82r8HQF7PmgIqfV0da3ZW42U6Qh2CY2k8JL4KM0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jv6mT6RO2slYCuD6FOyYvi7yw734gOOqWGq5dIs3sunKbYK5missvGnEql6VvX/Zez4en5LGtgI8Hpt9w95mOcaYOglQ3wi9v4swLUmj15PYKb58XISsanegotfDWU8YHJnks5i2vT5gpEr5NnpDOWQi43I6ZmDGHvmXAqbdbIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0kktFRp; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721116974; x=1752652974;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=Qnho82r8HQF7PmgIqfV0da3ZW42U6Qh2CY2k8JL4KM0=;
  b=j0kktFRpOP7MOvo2qQyTGQILJt0j/ebr/dzCk5aK+e73SmL3mbPh60uX
   KdHkYNodWqiXOc6LrkevJyJ/oViYC4GgTQvPoR51xFV7lLEH+aYxVn5OH
   pT3aTv0bK53UtAlqnggCeRyQ/0b9VIOTbvtCp8S222r1EI56Qa1yZrEUB
   kASskSWh5jmPyiXiACTlehDdLLAArDY6vFKAevUdCR8U2KhZK47+Bgfw+
   NXjoKXGuSGtW4XHzImqqZO8cwc/uv6HXzl7G0GbCWFX1rSJTasY1hyWXX
   SInZrSUgBKbCO92fu4Gjya4hC8QdpFz4awEARXPDQsVrbq1ZMO0TgRK3y
   Q==;
X-CSE-ConnectionGUID: imd2Y8arSSOGiFFYuAvN9A==
X-CSE-MsgGUID: D6jmHjVGRqmxcYyjDmuifw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18149269"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18149269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 01:02:49 -0700
X-CSE-ConnectionGUID: MpvrzupAT/qKlONZMW313A==
X-CSE-MsgGUID: 6bkhXFx6QjKaUrJ5qwUavA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49801740"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 01:02:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 01:02:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 01:02:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 01:02:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 01:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5wgS/hJFedE7X+4jtiY2DkA92ASOi4+ealFbB1ET4+Oi0Bu9ro2KJ0OnimQkP1Zq75dpkL1zEk3KtQs1Ho6ZKjJH/wsA6nDB4+bM8BffvzCsf1a35arS/73r4xoP+dlWmWiUy1Hc3Pl0CmzbF9lKskqruY2cMD/HA2h9m6kP0+/xjcyrcTlg69Jk+70qWr8rkQsjK8g+NUEpRIdsPk0thtGXhkY2T3EZbCyxQFLfCf3o+dMHEgbZuLpIq4VdWgkVWL4Iu8y9TlTglXmWh4uR6C6Ti/dssmIQ70Hx/ISMsOvzWM58aIgBeAKvHcjddtyEK8s5rcp+QfLVTk0wKwp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43Tn9hrPFkChy3Z003ADgmXEnFv6w5cHFra5fPt8Wi8=;
 b=aQJIzcPOdFa74GJtQmli5cvxabm/YIEd+SNN1oUPZQ7A/Y/Q7ats/VA1NyRZ+x7wRMDmLTcsdkxOxyDPWh1ArBy9jjq8Gu7uSVS5OtD1o8aXmT9CUjvqcwfryH73mSrqqa3k2yUCHeqnAae4cht5wUD+gP3u8p1VhL+uQyXVwFpN6Yoi2cvTDzurKO44O8vumYFqrioQu4NtWXeHqe36LQ0FgfPi0GNXTM4DjqeGyEJUj+hzvhaVF34fThoB3WpjBMm5kr91tp/kb86EXYSzQC9RjMzkPZ4zxjJ61EWCJb7p4mJGJhH9CYeFpAGiWuO10ovNzFo0OfKSq6cS4RUc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 08:02:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:02:43 +0000
Date: Tue, 16 Jul 2024 16:02:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [vfs]  18a5daf0e4:  stress-ng.acl.ops_per_sec 33.0%
 improvement
Message-ID: <202407161508.f2a2409d-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e5ad68-51da-4ef6-1a45-08dca56dabf5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?pEsoMfU6St6sc6pY/aP0SkFIItLkx3TSxjlaq4wOTx2ZAxf7RQMDQdIZqD?=
 =?iso-8859-1?Q?HLiQhwUb8EOS3FtTzapi1sOuU2lje4pVCASQX+6j2m4lO8J0CrE2IStlh6?=
 =?iso-8859-1?Q?qLdugfO90mjVFWTrbqnMxvYrfi29gl2kpfJqutQXNnfpstMzrBQBE6xIin?=
 =?iso-8859-1?Q?pjAQqMPE9cEabj+buAQcLOAVIEOteCQ1eBDjpjRAMuB/evxfLea3rStPq9?=
 =?iso-8859-1?Q?SLIFExI76G3ONDWQqiaA9dDxBFrB8rNakitUReeLBNNS9djmz6iPAUgXJw?=
 =?iso-8859-1?Q?bv1krHrRDN1j2QQACUM/xkKyLe/DImftbglYQfT5wcVinCi0MadcugCpmq?=
 =?iso-8859-1?Q?JSsiXuItaWnsH6d/mCQ5b6Lpsxe2yQG2f7A702f4EmUSQ74qNY/KAdBJqR?=
 =?iso-8859-1?Q?T6yS6HgPka+3EZJRh+02OD+tPZUhARhBkY7mD9pVmn7a0wB6suiXhFRVFE?=
 =?iso-8859-1?Q?JIs4fli7vqpnpmegQGKJB/EAsPdpwDEuryC3uaQPGa0FGA0O8o7KX70k6k?=
 =?iso-8859-1?Q?ZawYZhr1vdpWpqqCbQtcSZ9z7q5PdQ3dhSW/YIOE8lrQOPxi7CN50Vj9+G?=
 =?iso-8859-1?Q?r1hNmxYLRPwIrHXOIasZzARGZ0b8ZPhz470IInZITyoTp4NjMRsxe1WhHE?=
 =?iso-8859-1?Q?6Bv267bNWtrKhdCTXFQqKSIhDoNQqlkJknmLW6LTdJrOg6u5Q42k3DMKKy?=
 =?iso-8859-1?Q?LfRxH1BYaInKFRsvkF4uC3I9kvtHiMJvSyRnmIvjQDG34sDc5wHUhfATMZ?=
 =?iso-8859-1?Q?ZdLQEPPGR3seA3UNbSTkyr2ZVDvDWWA+SEPznRngsUi0R7vOEksGsC0+Br?=
 =?iso-8859-1?Q?G2a6YsP8EpL0jvpJNq7K2aP13JXUMe26lz+4zfeBL0cghsK1VfotE5uFCd?=
 =?iso-8859-1?Q?hx6mD3UzZTd9O6NxS+JOT4vQf0cJqKjvAhWu7in68I/3oJvwQL9uczy1RJ?=
 =?iso-8859-1?Q?owdWHZ7DdpxUxbtbdkOILJ7wn9Sm+BdthezZ6cy36/jrCOcW1+3FRHpTUh?=
 =?iso-8859-1?Q?LnJMqbvjp9r9H3ypnZSTsfJFTbhxbFynamI7SzYBuUP9gCdcdlarHM/fRs?=
 =?iso-8859-1?Q?GsutclDQIVRkWtN/ufnGa6knHUpAofLOCclludvMjL/txUfzGEA0f25uG+?=
 =?iso-8859-1?Q?/kMPmY6MiihHW9JpR4BZNMbx9RoHz3oDvPIessYgQPA9tOyqK6depfwRMG?=
 =?iso-8859-1?Q?PJWiSAfIeEFjAQXyOtfELsJRJ++gx0tLkJsaRKgq4aV31hkPJL2kZzhjf5?=
 =?iso-8859-1?Q?MIw6nvgfz/7sg3xDzCP2frtQ1dYMLBFcu1gAonpkJIofBtrWOS4POnoH3J?=
 =?iso-8859-1?Q?5pMlfDiy/nQrVXcF5EnLHAZOAr+lYgKJj81lH6Bz0yrvFJ92n3009iLu5A?=
 =?iso-8859-1?Q?+faP5YSNZB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fOwuh//Q2Rx7I04V4bKao+zHBrnEO4pbGCJ/SIDF86wlqJW9y7c5U+i1yS?=
 =?iso-8859-1?Q?8m1Tha6XJSZO7/xwMmcsCv63gmB4njXpg4eYddR2TMlcO3xpimoEONeqt5?=
 =?iso-8859-1?Q?zsZrakXi7kMg0oL+sDLeO58gNKLs4NtBxQWl0rgXYQzZM3ogv1UnFzDHhQ?=
 =?iso-8859-1?Q?/9a3OnCgsyu7PJPwYOp7mAhvvpk9gaVU3vTlvYNlY/oO0AdNjMK9SPJZMn?=
 =?iso-8859-1?Q?bXsKNrUtpTCayfU0FWtAgRaY4w+TDsG/sLsTGd9+9j3tqXOXdfP9jpGeMD?=
 =?iso-8859-1?Q?+zOL7WTmWd/rC8TjbQfNcAXthTVOOodgESyYQxp/POcKZ+k1h4AOzmTDGv?=
 =?iso-8859-1?Q?+P8MYH7Cr8y74lfRF9AFi9N06iAQm5ukGpfTWoEQ5Sbdjw3mxW+AJLXGrW?=
 =?iso-8859-1?Q?a+0pcIg9qU1ltIw3iR9xO5VbRIX18psusAvVwoQg0/2TNRA+ktPj69IN5v?=
 =?iso-8859-1?Q?/p8aU1ZgBkSELD7F2W1jLjmPKdiFmUyr3BnA/Vd5SOjYE+p4Bp2NgJwV1Q?=
 =?iso-8859-1?Q?OvlzwucS0Bvi710pDPKl/upZlUGF5Ih0dADT+kPrh7+eH6mfZbIDGNIdsr?=
 =?iso-8859-1?Q?CF5JaMtacKwOp6WUA42kzsDJL2gWfGuuc/RDu9HtBliUQozmE453etTZ04?=
 =?iso-8859-1?Q?FLCGr2jd+O2RST/UN1rCRwzU2YBzPsYUw/JJMnbpPWl0tOSGjd/l89HZ9/?=
 =?iso-8859-1?Q?yOg13b6FiRaIM4mOptscMLXSAxHNE8gpLRf/pgg97TQArhpaZJfHKe9co8?=
 =?iso-8859-1?Q?IwlepZmbwerhVdozyNU/VuE3WHbXEaGXnh0YnAHtZrZ/SSe2XAjJYhId5A?=
 =?iso-8859-1?Q?WA++s4/K1GpOxyWkbJ3X4bt1SBkNIE6FQhR8PE2vkfSQX14ijYOJyEyVnM?=
 =?iso-8859-1?Q?wHsZn2GXDABxLOGUQvLfEfu2VD55zKW3u3LxhGAcsqpBc46oLKPoFpQwtK?=
 =?iso-8859-1?Q?wRoNVFmg65sAGosjz9IwZC76CRymOvw5pMgslQasXFcP1TeLTKq/i5fD6P?=
 =?iso-8859-1?Q?8l1Z7IaHDFvIyrL1vC+mSi3CMtv0LxnanPjWZR2HhsrRnkX44L13uWyO4R?=
 =?iso-8859-1?Q?OLDrCFB5IkS8efwtdJrFU0ukrxvLBGsKTeyyoXScu4UCPqhfNUiF5zc2FO?=
 =?iso-8859-1?Q?0Jj83gLaf6k0MITpYzY8w5EWPKWTu1DYcM8MAybj8ByD3RDAOEfL+8amaI?=
 =?iso-8859-1?Q?x5uPxWugRg9iin7TGofwu5kVLZcNBQ6PaLNmHToSrtJAt6N32PRSah+TkD?=
 =?iso-8859-1?Q?NESrh28WLXwTLM+EHl9ECVjzyVI9vRwpHfylxwTBTrgY9mOco9TOf0Bnm5?=
 =?iso-8859-1?Q?r1TM3dKy5/fjSIXQXhB9kc0zcKpTs93zMKu6S6HtAwGxaOcu7yiyk702jq?=
 =?iso-8859-1?Q?CXOawKQviLubn2MuvXBNXOifeW3CIcNW5dRmJMPh4FxFXPhN8waetly4UG?=
 =?iso-8859-1?Q?SgxJAYma7+1MR7seQca2zPgP+x59hYz9aRi9ae3FMACDaKKEbdsGolUAVl?=
 =?iso-8859-1?Q?+qlvbBPGqoryaP7Y48lhuQ0dsmI+d2/ZX6RjhmTY9uVWq23OdO2rt2DXtU?=
 =?iso-8859-1?Q?8W3B8TnrMVai4OKVvtS4RROa0LUsNcTQlznOnPsf1xB8PTVh7A8y1rOHXN?=
 =?iso-8859-1?Q?ZMyjc16vEEgJMPXdMq+zHrOesV7gqF7teCYGC4khjf6beuQEkFlCNy2Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e5ad68-51da-4ef6-1a45-08dca56dabf5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:02:43.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP2xlGvzWFUezm2bVLgaNXXBQEtZPodGSSlsVooD3icJpaU2k2f+sarc90Ys4n7P4tT49PqQW/kTOgguCfXXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 33.0% improvement of stress-ng.acl.ops_per_sec on:


commit: 18a5daf0e4974ded74b2ed8a6aed1da49bde356d ("vfs: move d_lockref out of the area used by RCU lookup")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: xfs
	test: acl
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240716/202407161508.f2a2409d-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/xfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/acl/stress-ng/60s

commit: 
  267574dee6 ("bcachefs: remove now spurious i_state initialization")
  18a5daf0e4 ("vfs: move d_lockref out of the area used by RCU lookup")

267574dee6ae0da6 18a5daf0e4974ded74b2ed8a6ae 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      6.82 ±  2%      +2.0        8.86 ±  3%  mpstat.cpu.all.usr%
     11108 ±  3%     +17.9%      13093 ±  7%  vmstat.system.cs
     87.97            -1.7%      86.49        iostat.cpu.system
      6.62 ±  2%     +29.8%       8.60 ±  3%  iostat.cpu.user
    421932 ±  6%     +14.0%     481083 ±  6%  numa-numastat.node0.local_node
    524395 ±  3%     +18.8%     622782 ±  5%  numa-numastat.node1.local_node
    561053 ±  4%     +16.9%     655949 ±  4%  numa-numastat.node1.numa_hit
    451619 ±  5%     +14.0%     514751 ±  4%  numa-vmstat.node0.numa_hit
    561164 ±  4%     +16.9%     656221 ±  4%  numa-vmstat.node1.numa_hit
    524506 ±  3%     +18.8%     623052 ±  5%  numa-vmstat.node1.numa_local
      3452 ±  9%     -19.4%       2781 ±  3%  perf-c2c.DRAM.local
     28229 ±  5%     +10.7%      31245 ±  8%  perf-c2c.DRAM.remote
     19325 ±  5%     +18.6%      22913 ±  8%  perf-c2c.HITM.remote
   1015006 ±  2%     +15.4%    1171144 ±  2%  proc-vmstat.numa_hit
    948728 ±  2%     +16.5%    1104829 ±  2%  proc-vmstat.numa_local
   1055616           +14.8%    1211424 ±  2%  proc-vmstat.pgalloc_normal
    884742 ±  2%     +15.7%    1023261 ±  2%  proc-vmstat.pgfree
    514321 ±  3%     -21.7%     402542 ±  4%  sched_debug.cpu.avg_idle.avg
     31409 ± 24%     -72.8%       8554 ± 15%  sched_debug.cpu.avg_idle.min
    225376 ±  2%     -12.4%     197473 ±  9%  sched_debug.cpu.avg_idle.stddev
      7213           +13.3%       8172 ±  5%  sched_debug.cpu.nr_switches.avg
      3707 ±  3%     +29.3%       4793 ±  5%  sched_debug.cpu.nr_switches.min
      1535 ±  2%      -9.0%       1397        stress-ng.acl.nanoseconds_to_get_an_ACL
      3824           +13.2%       4330        stress-ng.acl.nanoseconds_to_set_an_ACL
  36962822 ±  3%     +33.0%   49156495 ±  2%  stress-ng.acl.ops
    616042 ±  3%     +33.0%     819268 ±  2%  stress-ng.acl.ops_per_sec
    299681 ±  3%     +15.7%     346805 ±  7%  stress-ng.time.involuntary_context_switches
      3549            -2.2%       3469        stress-ng.time.system_time
    237.10           +32.1%     313.29 ±  3%  stress-ng.time.user_time
    964.50 ±  5%    +104.5%       1972 ±  5%  stress-ng.time.voluntary_context_switches
      1.23 ±  4%     -19.3%       0.99 ±  6%  perf-stat.i.MPKI
 1.112e+10 ±  3%     +31.3%   1.46e+10 ±  2%  perf-stat.i.branch-instructions
      0.65 ±  2%      -0.1        0.55        perf-stat.i.branch-miss-rate%
  70021257 ±  4%      +7.5%   75272311 ±  2%  perf-stat.i.branch-misses
     11390 ±  3%     +17.9%      13427 ±  7%  perf-stat.i.context-switches
      4.30 ±  3%     -23.9%       3.27 ±  2%  perf-stat.i.cpi
    140.75            +5.0%     147.77        perf-stat.i.cpu-migrations
 5.228e+10 ±  3%     +31.3%  6.864e+10 ±  2%  perf-stat.i.instructions
      0.24 ±  2%     +29.7%       0.31 ±  2%  perf-stat.i.ipc
      1.23 ±  4%     -19.3%       0.99 ±  6%  perf-stat.overall.MPKI
      0.62 ±  2%      -0.1        0.51        perf-stat.overall.branch-miss-rate%
      4.33 ±  3%     -23.8%       3.30 ±  2%  perf-stat.overall.cpi
      0.23 ±  3%     +31.2%       0.30 ±  2%  perf-stat.overall.ipc
 1.092e+10 ±  3%     +31.2%  1.433e+10 ±  2%  perf-stat.ps.branch-instructions
  68270508 ±  4%      +7.1%   73124552 ±  2%  perf-stat.ps.branch-misses
     11204 ±  2%     +17.5%      13169 ±  7%  perf-stat.ps.context-switches
    138.43            +4.8%     145.08        perf-stat.ps.cpu-migrations
 5.135e+10 ±  3%     +31.2%  6.737e+10 ±  2%  perf-stat.ps.instructions
 3.158e+12 ±  3%     +30.7%  4.127e+12 ±  2%  perf-stat.total.instructions
     44.89 ±  2%      -5.5       39.34        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     44.99 ±  2%      -5.5       39.45        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     46.34 ±  2%      -5.4       40.99        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
     46.29 ±  2%      -5.4       40.94        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
     46.42 ±  2%      -5.3       41.09        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
     46.45 ±  2%      -5.3       41.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
     46.81 ±  2%      -5.2       41.60        perf-profile.calltrace.cycles-pp.__open64_nocancel
     31.84 ±  2%      -5.1       26.77        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      6.14 ±  7%      -3.9        2.27 ±  9%  perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.do_open.path_openat.do_filp_open
      6.45 ±  6%      -3.5        2.95 ±  8%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.do_open.path_openat
      6.48 ±  6%      -3.5        2.99 ±  8%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.do_open.path_openat.do_filp_open
      6.49 ±  6%      -3.5        3.01 ±  8%  perf-profile.calltrace.cycles-pp.complete_walk.do_open.path_openat.do_filp_open.do_sys_openat2
      6.12 ±  6%      -3.4        2.68 ±  9%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.do_open
      6.48 ±  6%      -3.3        3.13 ±  7%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.terminate_walk.path_openat.do_filp_open
      6.50 ±  6%      -3.3        3.15 ±  7%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      6.54 ±  6%      -3.3        3.20 ±  7%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      6.04 ±  7%      -3.1        2.89 ± 12%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.__fput.__x64_sys_close.do_syscall_64
      6.08 ±  7%      -3.1        2.94 ± 12%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.80 ±  2%      -2.6       20.16        perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      4.75 ±  5%      -1.6        3.18 ± 12%  perf-profile.calltrace.cycles-pp.common_perm_cond.security_inode_getattr.vfs_fstat.__do_sys_newfstatat.do_syscall_64
      4.78 ±  5%      -1.6        3.23 ± 12%  perf-profile.calltrace.cycles-pp.security_inode_getattr.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.85 ±  5%      -1.4        3.44 ± 12%  perf-profile.calltrace.cycles-pp.rw_verify_area.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.98 ±  5%      -1.4        3.63 ± 10%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      4.71 ± 14%      -1.0        3.71 ±  6%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      4.80 ± 14%      -1.0        3.83 ±  6%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      0.63            +0.1        0.74 ±  4%  perf-profile.calltrace.cycles-pp.user_path_at_empty.path_setxattr.__x64_sys_setxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.54 ±  2%      +0.1        0.67 ±  3%  perf-profile.calltrace.cycles-pp.user_path_at_empty.path_getxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr
      1.00            +0.2        1.25 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr.stress_acl
      0.97            +0.2        1.22 ±  2%  perf-profile.calltrace.cycles-pp.path_getxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe.getxattr.stress_acl
      1.01            +0.2        1.26 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getxattr.stress_acl
      1.13            +0.3        1.38 ±  2%  perf-profile.calltrace.cycles-pp.getxattr.stress_acl
      1.20            +0.3        1.48 ±  2%  perf-profile.calltrace.cycles-pp.stress_acl
      0.75 ± 13%      +0.4        1.17 ± 17%  perf-profile.calltrace.cycles-pp.locks_remove_posix.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82 ± 12%      +0.4        1.25 ± 15%  perf-profile.calltrace.cycles-pp.filp_flush.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.67 ± 15%      +0.4        1.11 ± 19%  perf-profile.calltrace.cycles-pp.generic_file_llseek.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.77 ± 13%      +0.5        1.25 ± 17%  perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.18 ±141%      +0.5        0.67 ±  5%  perf-profile.calltrace.cycles-pp.getname_flags.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.86 ± 12%      +0.5        1.39 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.89 ± 12%      +0.5        1.42 ± 14%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      0.79 ±  5%      +0.6        1.37 ±  2%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_attr_set.__xfs_set_acl.xfs_set_acl
      0.00            +0.6        0.58 ±  4%  perf-profile.calltrace.cycles-pp.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.68 ±  4%      +0.6        1.27 ±  2%  perf-profile.calltrace.cycles-pp.xfs_trans_reserve.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_attr_set.__xfs_set_acl
      0.60 ±  5%      +0.6        1.20 ±  3%  perf-profile.calltrace.cycles-pp.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_attr_set
      0.91 ±  4%      +0.6        1.52 ±  2%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc_inode.xfs_attr_set.__xfs_set_acl.xfs_set_acl.vfs_set_acl
      1.20 ±  9%      +0.6        1.84 ± 11%  perf-profile.calltrace.cycles-pp.llseek
      0.58 ±  4%      +0.6        1.22 ±  3%  perf-profile.calltrace.cycles-pp.xfs_trans_alloc.xfs_set_acl.vfs_set_acl.do_set_acl.setxattr
      0.00            +0.8        0.79 ±  3%  perf-profile.calltrace.cycles-pp.xlog_grant_add_space.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_set_acl
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.xlog_grant_add_space.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_trans_alloc_inode
      1.19            +0.9        2.06 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_attr_set.__xfs_set_acl.xfs_set_acl
      1.02 ±  3%      +0.9        1.90 ±  3%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_set_acl.vfs_set_acl.do_set_acl
      2.44 ± 13%      +0.9        3.36 ± 12%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.rw_verify_area.vfs_read.ksys_read
      1.14 ±  2%      +0.9        2.07 ±  3%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_set_acl.vfs_set_acl.do_set_acl.setxattr
      2.47 ± 13%      +0.9        3.40 ± 12%  perf-profile.calltrace.cycles-pp.security_file_permission.rw_verify_area.vfs_read.ksys_read.do_syscall_64
      0.18 ±141%      +0.9        1.13 ±  3%  perf-profile.calltrace.cycles-pp.xfs_log_reserve.xfs_trans_reserve.xfs_trans_alloc.xfs_set_acl.vfs_set_acl
      2.30 ± 13%      +1.0        3.26 ± 14%  perf-profile.calltrace.cycles-pp.apparmor_current_getsecid_subj.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open
      2.31 ± 13%      +1.0        3.27 ± 14%  perf-profile.calltrace.cycles-pp.security_current_getsecid_subj.ima_file_check.security_file_post_open.do_open.path_openat
      0.18 ±141%      +1.0        1.15 ±  3%  perf-profile.calltrace.cycles-pp.xfs_trans_reserve.xfs_trans_alloc.xfs_set_acl.vfs_set_acl.do_set_acl
      2.41 ± 13%      +1.0        3.42 ± 13%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      2.42 ± 13%      +1.0        3.44 ± 13%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.0        1.03 ±  4%  perf-profile.calltrace.cycles-pp.xfs_log_ticket_ungrant.xlog_cil_commit.__xfs_trans_commit.xfs_set_acl.vfs_set_acl
      0.00            +1.1        1.07 ±  4%  perf-profile.calltrace.cycles-pp.xfs_log_ticket_ungrant.xlog_cil_commit.__xfs_trans_commit.xfs_attr_set.__xfs_set_acl
      1.78 ±  2%      +1.1        2.86 ±  3%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_attr_set.__xfs_set_acl.xfs_set_acl.vfs_set_acl
      8.65 ±  3%      +1.1        9.80 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__read_nocancel
      8.74 ±  3%      +1.2        9.91 ±  2%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__read_nocancel
      8.82 ±  3%      +1.2       10.02 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__read_nocancel
      8.84 ±  3%      +1.2       10.05 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__read_nocancel
      1.78 ±  8%      +1.3        3.08 ±  8%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      9.18 ±  3%      +1.3       10.50 ±  2%  perf-profile.calltrace.cycles-pp.__read_nocancel
      1.84 ±  8%      +1.3        3.17 ±  8%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      2.39 ±  6%      +1.7        4.10 ±  5%  perf-profile.calltrace.cycles-pp.apparmor_file_free_security.security_file_free.__fput.__x64_sys_close.do_syscall_64
      2.40 ±  7%      +1.7        4.11 ±  5%  perf-profile.calltrace.cycles-pp.security_file_free.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.10 ±  2%      +1.8        4.90 ±  2%  perf-profile.calltrace.cycles-pp.xfs_attr_set.__xfs_set_acl.xfs_set_acl.vfs_set_acl.do_set_acl
      3.53 ±  2%      +1.9        5.40 ±  2%  perf-profile.calltrace.cycles-pp.__xfs_set_acl.xfs_set_acl.vfs_set_acl.do_set_acl.setxattr
      3.58 ±  9%      +2.5        6.06 ± 10%  perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.84 ±  6%      +2.7        8.57 ±  4%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      4.53 ±  7%      +2.8        7.33 ±  4%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      4.65 ±  7%      +2.8        7.48 ±  4%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      4.79 ±  6%      +2.9        7.64 ±  4%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
     11.04 ±  4%      +3.1       14.18 ±  3%  perf-profile.calltrace.cycles-pp.apparmor_file_open.security_file_open.do_dentry_open.do_open.path_openat
     11.05 ±  4%      +3.1       14.20 ±  3%  perf-profile.calltrace.cycles-pp.security_file_open.do_dentry_open.do_open.path_openat.do_filp_open
      5.47 ±  2%      +3.5        8.97 ±  2%  perf-profile.calltrace.cycles-pp.xfs_set_acl.vfs_set_acl.do_set_acl.setxattr.path_setxattr
      5.75 ±  2%      +3.6        9.39 ±  2%  perf-profile.calltrace.cycles-pp.vfs_set_acl.do_set_acl.setxattr.path_setxattr.__x64_sys_setxattr
      5.88 ±  2%      +3.7        9.58 ±  2%  perf-profile.calltrace.cycles-pp.do_set_acl.setxattr.path_setxattr.__x64_sys_setxattr.do_syscall_64
      6.11 ±  2%      +3.8        9.87 ±  2%  perf-profile.calltrace.cycles-pp.setxattr.path_setxattr.__x64_sys_setxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.00 ±  2%      +3.9       10.87 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.setxattr
      7.01 ±  2%      +3.9       10.88 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.setxattr
      6.94 ±  2%      +3.9       10.81 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_setxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe.setxattr
      6.90 ±  2%      +3.9       10.78 ±  2%  perf-profile.calltrace.cycles-pp.path_setxattr.__x64_sys_setxattr.do_syscall_64.entry_SYSCALL_64_after_hwframe.setxattr
      7.14 ±  2%      +3.9       11.05 ±  2%  perf-profile.calltrace.cycles-pp.setxattr
     15.74 ±  4%      -7.1        8.59 ±  6%  perf-profile.children.cycles-pp.lockref_put_return
     15.86 ±  4%      -7.1        8.76 ±  5%  perf-profile.children.cycles-pp.dput
     44.92 ±  2%      -5.5       39.37        perf-profile.children.cycles-pp.path_openat
     45.00 ±  2%      -5.5       39.46        perf-profile.children.cycles-pp.do_filp_open
     46.36 ±  2%      -5.4       41.00        perf-profile.children.cycles-pp.__x64_sys_openat
     46.32 ±  2%      -5.3       40.97        perf-profile.children.cycles-pp.do_sys_openat2
     46.87 ±  2%      -5.2       41.68        perf-profile.children.cycles-pp.__open64_nocancel
     31.86 ±  2%      -5.1       26.79        perf-profile.children.cycles-pp.do_open
      6.15 ±  7%      -3.9        2.28 ±  9%  perf-profile.children.cycles-pp.lockref_get
      9.04 ±  4%      -3.4        5.66 ±  4%  perf-profile.children.cycles-pp.__legitimize_path
      8.44 ±  5%      -3.4        5.07 ±  4%  perf-profile.children.cycles-pp.lockref_get_not_dead
      9.13 ±  4%      -3.3        5.79 ±  4%  perf-profile.children.cycles-pp.try_to_unlazy
      6.59 ±  6%      -3.3        3.28 ±  7%  perf-profile.children.cycles-pp.terminate_walk
      9.16 ±  4%      -3.3        5.85 ±  3%  perf-profile.children.cycles-pp.complete_walk
     22.81 ±  2%      -2.6       20.18        perf-profile.children.cycles-pp.do_dentry_open
     94.55            -1.7       92.86        perf-profile.children.cycles-pp.do_syscall_64
     94.71            -1.6       93.08        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.86 ±  6%      -1.5        6.40 ± 12%  perf-profile.children.cycles-pp.common_perm_cond
      7.92 ±  6%      -1.4        6.48 ± 12%  perf-profile.children.cycles-pp.security_inode_getattr
      4.86 ±  5%      -1.4        3.45 ± 12%  perf-profile.children.cycles-pp.rw_verify_area
      4.99 ±  4%      -1.4        3.64 ± 10%  perf-profile.children.cycles-pp.vfs_fstat
      1.72 ± 13%      -1.2        0.48 ±  6%  perf-profile.children.cycles-pp.lookup_fast
      1.64 ± 13%      -1.2        0.40 ±  7%  perf-profile.children.cycles-pp.__d_lookup_rcu
      1.74 ± 13%      -1.2        0.50 ±  5%  perf-profile.children.cycles-pp.walk_component
      0.31 ±  4%      -0.0        0.28 ±  4%  perf-profile.children.cycles-pp.nd_jump_root
      0.06 ±  7%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.set_cached_acl
      0.07 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.kfree
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp._IO_setb
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__file_change_detection_for_path
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.mnt_want_write
      0.06 ±  9%      +0.0        0.07        perf-profile.children.cycles-pp.unix_create1
      0.15 ±  5%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.07 ±  9%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp._IO_file_close_it
      0.08 ±  5%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.kern_path
      0.11 ±  3%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.kvfree_call_rcu
      0.07 ±  5%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.xfs_attr_sf_findname
      0.08 ± 10%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.xfs_inode_item_precommit
      0.07 ±  8%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp._IO_file_doallocate
      0.07 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.current_time
      0.08 ±  6%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.may_open
      0.07 ±  6%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.getgrgid_r
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.unix_find_other
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__get_user_1
      0.06            +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.inode_maybe_inc_iversion
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.xfs_idata_realloc
      0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.legitimize_links
      0.16 ±  6%      +0.0        0.18 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.07 ±  5%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.build_open_flags
      0.06 ±  9%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.08 ±  6%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.atime_needs_update
      0.17 ±  4%      +0.0        0.19 ±  5%  perf-profile.children.cycles-pp.memset_orig
      0.09 ±  9%      +0.0        0.11 ±  6%  perf-profile.children.cycles-pp.xfs_attr_defer_add
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.strcmp
      0.12 ±  4%      +0.0        0.14 ±  5%  perf-profile.children.cycles-pp.vmemdup_user
      0.09 ±  5%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.generic_fillattr
      0.06 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.xfs_trans_ijoin
      0.05 ± 47%      +0.0        0.07 ± 16%  perf-profile.children.cycles-pp.__uflow
      0.05 ±  7%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.__nss_readline
      0.07 ±  8%      +0.0        0.10 ± 10%  perf-profile.children.cycles-pp.posix_acl_alloc
      0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.xlog_prepare_iovec
      0.06 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__kmalloc_noprof
      0.08 ±  5%      +0.0        0.11 ±  7%  perf-profile.children.cycles-pp.touch_atime
      0.12 ±  6%      +0.0        0.14 ±  7%  perf-profile.children.cycles-pp.set_root
      0.05 ±  8%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.xfs_log_ticket_put
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.get_random_u32
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.alloc_file_pseudo
      0.06 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.sock_alloc_file
      0.08 ±  5%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.xfs_attr_shortform_add
      0.06 ±  9%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.set_posix_acl
      0.06 ±  9%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.unix_release_sock
      0.08 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.process_measurement
      0.16 ±  2%      +0.0        0.19 ±  2%  perf-profile.children.cycles-pp.do_get_acl
      0.16 ±  6%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.13 ±  6%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.map_id_up
      0.17 ±  4%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.xfs_inode_to_log_dinode
      0.07 ±  9%      +0.0        0.11 ±  8%  perf-profile.children.cycles-pp.getpwuid_r
      0.06            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.xfs_iunlock
      0.09 ±  4%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.make_vfsuid
      0.11 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.02 ±141%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.xfs_assert_ilocked
      0.16 ±  3%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.setxattr_copy
      0.23 ±  5%      +0.0        0.28 ±  8%  perf-profile.children.cycles-pp.x64_sys_call
      0.13 ±  5%      +0.0        0.17 ±  4%  perf-profile.children.cycles-pp.down_write
      0.14 ±  3%      +0.0        0.19 ±  3%  perf-profile.children.cycles-pp.unix_stream_connect
      0.10 ± 10%      +0.0        0.14 ±  8%  perf-profile.children.cycles-pp.posix_acl_from_xattr
      0.16 ±  3%      +0.0        0.20 ±  7%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.06 ±  9%      +0.0        0.10 ± 16%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.14 ±  9%      +0.0        0.18 ± 10%  perf-profile.children.cycles-pp._IO_file_seekoff
      0.07 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.apparmor_socket_post_create
      0.07 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.security_socket_post_create
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.from_kuid_munged
      0.07 ±  6%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.up_write
      0.14 ±  6%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.__fdget_pos
      0.16 ±  3%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._find_next_zero_bit
      0.00            +0.1        0.05        perf-profile.children.cycles-pp._get_random_bytes
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.amd_clear_divider
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mnt_get_write_access
      0.11 ± 10%      +0.1        0.16 ±  6%  perf-profile.children.cycles-pp.up_read
      0.01 ±223%      +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.__lookup_mnt
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.xfs_attr_match
      0.12 ±  5%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.17 ±  2%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.__x64_sys_connect
      0.11 ±  4%      +0.1        0.16 ± 10%  perf-profile.children.cycles-pp.open_last_lookups
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp._IO_default_uflow
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.posix_acl_update_mode
      0.17 ±  4%      +0.1        0.22 ±  4%  perf-profile.children.cycles-pp.__sys_connect
      0.13 ±  8%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.xfs_attr_sf_removename
      0.09 ± 11%      +0.1        0.14 ± 14%  perf-profile.children.cycles-pp._IO_getline_info
      0.16 ±  8%      +0.1        0.22 ± 10%  perf-profile.children.cycles-pp._copy_to_iter
      0.33 ±  4%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.xfs_inode_item_format
      0.18 ±  4%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.getpwuid
      0.18 ±  2%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.connect
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.unix_release
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.posix_acl_valid
      0.15 ±  5%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.xlog_ticket_alloc
      0.19 ±  4%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.18 ±  7%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__sk_destruct
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.xfs_trans_del_item
      0.18 ±  4%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__sock_release
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.security_file_release
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.sock_close
      0.20 ±  4%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.generic_permission
      0.36 ±  4%      +0.1        0.42 ±  3%  perf-profile.children.cycles-pp.xlog_cil_insert_format_items
      0.16 ± 10%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.malloc
      0.18 ±  4%      +0.1        0.25 ±  4%  perf-profile.children.cycles-pp.getgrgid
      0.14 ±  4%      +0.1        0.21 ±  5%  perf-profile.children.cycles-pp.__sock_create
      0.32 ±  5%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.alloc_fd
      0.00            +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.expand_files
      0.21 ±  5%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp.file_close_fd
      0.25 ±  4%      +0.1        0.33 ±  5%  perf-profile.children.cycles-pp.xfs_trans_log_inode
      0.22 ±  8%      +0.1        0.29 ±  5%  perf-profile.children.cycles-pp._copy_to_user
      0.31            +0.1        0.39 ±  3%  perf-profile.children.cycles-pp.do_getxattr
      0.22 ±  3%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.26 ±  2%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.32 ±  3%      +0.1        0.41 ±  2%  perf-profile.children.cycles-pp.inode_permission
      0.24 ±  5%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.xfs_attr_shortform_addname
      0.26 ±  3%      +0.1        0.36 ±  5%  perf-profile.children.cycles-pp.xfs_attr_try_sf_addname
      0.21 ±  3%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.__sys_socket
      0.21 ±  3%      +0.1        0.31 ±  3%  perf-profile.children.cycles-pp.__x64_sys_socket
      0.25 ±  7%      +0.1        0.36 ±  6%  perf-profile.children.cycles-pp.step_into
      0.27 ±  5%      +0.1        0.38 ±  5%  perf-profile.children.cycles-pp.xfs_attr_set_iter
      0.30 ±  3%      +0.1        0.40 ±  5%  perf-profile.children.cycles-pp.xfs_attr_finish_item
      0.30 ±  4%      +0.1        0.40 ±  3%  perf-profile.children.cycles-pp.check_heap_object
      0.22 ±  4%      +0.1        0.32 ±  3%  perf-profile.children.cycles-pp.__socket
      0.34 ±  2%      +0.1        0.44 ±  5%  perf-profile.children.cycles-pp.xfs_defer_finish_one
      0.37 ±  3%      +0.1        0.49 ±  4%  perf-profile.children.cycles-pp._IO_link_in
      0.28 ±  3%      +0.1        0.41 ±  6%  perf-profile.children.cycles-pp.down_read
      0.36 ±  3%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.40 ±  4%      +0.1        0.53 ±  3%  perf-profile.children.cycles-pp.xfs_defer_finish_noroll
      0.45 ±  5%      +0.1        0.60 ±  4%  perf-profile.children.cycles-pp.cp_new_stat
      0.51 ±  3%      +0.2        0.66 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.55 ±  3%      +0.2        0.72 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.64 ±  2%      +0.2        0.82 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      0.16 ± 49%      +0.2        0.34 ± 52%  perf-profile.children.cycles-pp.simple_getattr
      0.54 ±  3%      +0.2        0.73 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.69 ±  2%      +0.2        0.88 ±  2%  perf-profile.children.cycles-pp.xlog_cil_insert_items
      0.21 ±  5%      +0.2        0.41 ±  5%  perf-profile.children.cycles-pp.xlog_grant_push_threshold
      1.33            +0.2        1.53 ±  3%  perf-profile.children.cycles-pp.link_path_walk
      0.21 ±  6%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.xlog_grant_push_ail
      0.21 ±  4%      +0.2        0.42 ±  5%  perf-profile.children.cycles-pp.xlog_space_left
      0.12 ±  6%      +0.2        0.35 ±  6%  perf-profile.children.cycles-pp.xfs_log_space_wake
      1.17            +0.2        1.41 ±  3%  perf-profile.children.cycles-pp.user_path_at_empty
      0.97            +0.2        1.22 ±  2%  perf-profile.children.cycles-pp.path_getxattr
      0.92            +0.3        1.17 ±  3%  perf-profile.children.cycles-pp.strncpy_from_user
      1.21            +0.3        1.49 ±  2%  perf-profile.children.cycles-pp.stress_acl
      1.31 ±  3%      +0.3        1.62 ±  4%  perf-profile.children.cycles-pp.getname_flags
      1.06 ±  4%      +0.3        1.38 ±  3%  perf-profile.children.cycles-pp.clear_bhb_loop
      1.54            +0.4        1.91 ±  2%  perf-profile.children.cycles-pp.getxattr
      0.75 ± 13%      +0.4        1.18 ± 17%  perf-profile.children.cycles-pp.locks_remove_posix
      0.82 ± 12%      +0.4        1.26 ± 15%  perf-profile.children.cycles-pp.filp_flush
      0.67 ± 15%      +0.4        1.11 ± 19%  perf-profile.children.cycles-pp.generic_file_llseek
      0.78 ± 13%      +0.5        1.26 ± 17%  perf-profile.children.cycles-pp.ksys_lseek
      0.91 ±  4%      +0.6        1.52 ±  2%  perf-profile.children.cycles-pp.xfs_trans_alloc_inode
      1.25 ±  8%      +0.7        1.92 ± 10%  perf-profile.children.cycles-pp.llseek
      2.45 ± 13%      +0.9        3.37 ± 12%  perf-profile.children.cycles-pp.apparmor_file_permission
      2.48 ± 13%      +0.9        3.41 ± 12%  perf-profile.children.cycles-pp.security_file_permission
      0.69 ±  7%      +0.9        1.62 ±  3%  perf-profile.children.cycles-pp.xlog_grant_add_space
      2.30 ± 13%      +1.0        3.26 ± 14%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      2.31 ± 13%      +1.0        3.28 ± 14%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      2.41 ± 13%      +1.0        3.42 ± 13%  perf-profile.children.cycles-pp.ima_file_check
      2.43 ± 13%      +1.0        3.44 ± 13%  perf-profile.children.cycles-pp.security_file_post_open
      8.66 ±  3%      +1.2        9.81 ±  2%  perf-profile.children.cycles-pp.vfs_read
      8.75 ±  3%      +1.2        9.93 ±  2%  perf-profile.children.cycles-pp.ksys_read
      1.38 ±  4%      +1.2        2.59 ±  3%  perf-profile.children.cycles-pp.xfs_trans_alloc
      1.19 ±  4%      +1.2        2.42 ±  2%  perf-profile.children.cycles-pp.xfs_trans_reserve
      1.10 ±  5%      +1.2        2.33 ±  3%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.84 ±  6%      +1.3        2.11 ±  4%  perf-profile.children.cycles-pp.xfs_log_ticket_ungrant
      1.79 ±  8%      +1.3        3.09 ±  8%  perf-profile.children.cycles-pp.filemap_get_read_batch
      1.84 ±  7%      +1.3        3.17 ±  8%  perf-profile.children.cycles-pp.filemap_get_pages
      9.24 ±  3%      +1.3       10.57 ±  2%  perf-profile.children.cycles-pp.__read_nocancel
      2.41 ±  7%      +1.7        4.12 ±  5%  perf-profile.children.cycles-pp.security_file_free
      2.40 ±  7%      +1.7        4.10 ±  5%  perf-profile.children.cycles-pp.apparmor_file_free_security
      2.21 ±  2%      +1.8        3.98 ±  3%  perf-profile.children.cycles-pp.xlog_cil_commit
      3.11 ±  2%      +1.8        4.91 ±  2%  perf-profile.children.cycles-pp.xfs_attr_set
      3.53 ±  2%      +1.9        5.40 ±  2%  perf-profile.children.cycles-pp.__xfs_set_acl
      2.94 ±  2%      +2.0        4.94 ±  3%  perf-profile.children.cycles-pp.__xfs_trans_commit
      3.59 ±  9%      +2.5        6.07 ± 10%  perf-profile.children.cycles-pp.filemap_read
      5.90 ±  6%      +2.8        8.66 ±  4%  perf-profile.children.cycles-pp.alloc_empty_file
      4.58 ±  7%      +2.8        7.41 ±  4%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      4.70 ±  7%      +2.9        7.56 ±  4%  perf-profile.children.cycles-pp.security_file_alloc
      4.84 ±  6%      +2.9        7.73 ±  4%  perf-profile.children.cycles-pp.init_file
     11.05 ±  4%      +3.1       14.19 ±  3%  perf-profile.children.cycles-pp.apparmor_file_open
     11.06 ±  4%      +3.1       14.20 ±  3%  perf-profile.children.cycles-pp.security_file_open
      5.47 ±  2%      +3.5        8.98 ±  2%  perf-profile.children.cycles-pp.xfs_set_acl
      5.75 ±  2%      +3.6        9.40 ±  2%  perf-profile.children.cycles-pp.vfs_set_acl
      5.88 ±  2%      +3.7        9.58 ±  2%  perf-profile.children.cycles-pp.do_set_acl
      6.91 ±  2%      +3.9       10.78 ±  2%  perf-profile.children.cycles-pp.path_setxattr
      6.94 ±  2%      +3.9       10.81 ±  2%  perf-profile.children.cycles-pp.__x64_sys_setxattr
     13.28 ±  2%      +7.7       20.95 ±  2%  perf-profile.children.cycles-pp.setxattr
     15.69 ±  4%      -7.1        8.56 ±  6%  perf-profile.self.cycles-pp.lockref_put_return
      6.13 ±  7%      -3.9        2.27 ±  9%  perf-profile.self.cycles-pp.lockref_get
      8.41 ±  5%      -3.4        5.05 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
      7.82 ±  6%      -1.5        6.36 ± 12%  perf-profile.self.cycles-pp.common_perm_cond
      1.62 ± 14%      -1.2        0.38 ±  7%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.19 ±  7%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.nd_jump_root
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.kfree
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.generic_fillattr
      0.06 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.do_get_acl
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.set_cached_acl
      0.07 ±  5%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.getgrgid_r
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.__file_change_detection_for_path
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__get_user_1
      0.04 ± 44%      +0.0        0.06        perf-profile.self.cycles-pp.try_to_unlazy
      0.06            +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.inode_maybe_inc_iversion
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.04 ± 44%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.security_inode_getattr
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.06 ±  6%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp._IO_file_doallocate
      0.05 ±  8%      +0.0        0.08 ± 12%  perf-profile.self.cycles-pp.__kmalloc_noprof
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__read_nocancel
      0.07            +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.build_open_flags
      0.15 ±  4%      +0.0        0.17 ±  5%  perf-profile.self.cycles-pp.__check_heap_object
      0.11 ±  4%      +0.0        0.13 ±  6%  perf-profile.self.cycles-pp.__kmalloc_node_noprof
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.llseek
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.xfs_log_ticket_put
      0.08 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.strcmp
      0.10 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.check_heap_object
      0.05 ±  7%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.walk_component
      0.09 ±  6%      +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.xfs_trans_log_inode
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.filemap_get_pages
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.vfs_statx
      0.11 ±  5%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.set_root
      0.12 ±  4%      +0.0        0.14 ±  4%  perf-profile.self.cycles-pp.inode_permission
      0.09            +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.__open64_nocancel
      0.07 ± 10%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.getpwuid_r
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.07 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.process_measurement
      0.04 ± 71%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.setxattr
      0.04 ± 44%      +0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__nss_readline
      0.07 ±  7%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.make_vfsuid
      0.11 ±  4%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.map_id_up
      0.06 ±  7%      +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.__close_nocancel
      0.04 ± 44%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.legitimize_links
      0.10 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.15 ±  8%      +0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.08 ±  7%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.vfs_set_acl
      0.12 ±  4%      +0.0        0.15 ±  4%  perf-profile.self.cycles-pp.down_write
      0.22 ±  5%      +0.0        0.26 ±  9%  perf-profile.self.cycles-pp.x64_sys_call
      0.14 ±  8%      +0.0        0.18 ± 10%  perf-profile.self.cycles-pp._IO_file_seekoff
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp._IO_file_fopen
      0.07            +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.path_lookupat
      0.11 ±  3%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.__do_sys_newfstatat
      0.07 ±  6%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.up_write
      0.11 ±  6%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.__check_object_size
      0.12 ±  3%      +0.0        0.17 ±  4%  perf-profile.self.cycles-pp.fstatat64
      0.16 ±  4%      +0.0        0.21 ±  5%  perf-profile.self.cycles-pp.generic_permission
      0.07 ±  5%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.apparmor_socket_post_create
      0.13 ±  5%      +0.0        0.18 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.14 ±  2%      +0.0        0.19 ±  7%  perf-profile.self.cycles-pp.filename_lookup
      0.11 ±  4%      +0.0        0.16 ±  5%  perf-profile.self.cycles-pp.vfs_getattr_nosec
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.xlog_prepare_iovec
      0.09 ± 11%      +0.0        0.14 ± 13%  perf-profile.self.cycles-pp._IO_getline_info
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.mnt_get_write_access
      0.12 ±  8%      +0.1        0.17 ±  6%  perf-profile.self.cycles-pp.vfs_read
      0.11 ± 10%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.up_read
      0.14 ±  7%      +0.1        0.19 ±  7%  perf-profile.self.cycles-pp.__fdget_pos
      0.16 ±  4%      +0.1        0.21 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.18 ±  3%      +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.getpwuid
      0.18 ±  4%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.getgrgid
      0.03 ± 70%      +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.16 ± 10%      +0.1        0.22 ± 11%  perf-profile.self.cycles-pp._copy_to_iter
      0.14 ± 13%      +0.1        0.20 ±  7%  perf-profile.self.cycles-pp.malloc
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.xfs_trans_del_item
      0.17 ±  4%      +0.1        0.22 ±  4%  perf-profile.self.cycles-pp.cp_new_stat
      0.17 ±  6%      +0.1        0.23 ±  4%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.20 ±  3%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.terminate_walk
      0.19 ±  5%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.complete_walk
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.expand_files
      0.19 ±  6%      +0.1        0.26 ±  6%  perf-profile.self.cycles-pp.step_into
      0.21 ±  8%      +0.1        0.28 ±  5%  perf-profile.self.cycles-pp._copy_to_user
      0.22 ±  3%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.34 ±  2%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
      0.33 ±  5%      +0.1        0.43 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.56            +0.1        0.67 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.15 ±  4%      +0.1        0.26 ±  7%  perf-profile.self.cycles-pp.xlog_cil_commit
      0.37 ±  4%      +0.1        0.48 ±  4%  perf-profile.self.cycles-pp._IO_link_in
      0.27 ±  4%      +0.1        0.39 ±  6%  perf-profile.self.cycles-pp.down_read
      0.33            +0.1        0.45 ±  2%  perf-profile.self.cycles-pp.xlog_cil_insert_items
      0.37 ±  3%      +0.1        0.49 ±  3%  perf-profile.self.cycles-pp.link_path_walk
      0.35 ±  3%      +0.1        0.48 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.54 ±  2%      +0.2        0.70 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock
      0.20 ±  6%      +0.2        0.41 ±  5%  perf-profile.self.cycles-pp.xlog_space_left
      0.12 ±  6%      +0.2        0.35 ±  6%  perf-profile.self.cycles-pp.xfs_log_space_wake
      1.06 ±  3%      +0.3        1.37 ±  3%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.75 ± 13%      +0.4        1.17 ± 17%  perf-profile.self.cycles-pp.locks_remove_posix
      0.66 ± 15%      +0.4        1.10 ± 19%  perf-profile.self.cycles-pp.generic_file_llseek
      2.24 ± 12%      +0.9        3.14 ± 12%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.69 ±  7%      +0.9        1.61 ±  3%  perf-profile.self.cycles-pp.xlog_grant_add_space
      2.29 ± 13%      +1.0        3.25 ± 14%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      0.72 ±  6%      +1.0        1.75 ±  3%  perf-profile.self.cycles-pp.xfs_log_ticket_ungrant
      1.45 ± 12%      +1.0        2.49 ± 16%  perf-profile.self.cycles-pp.filemap_read
      1.60 ±  8%      +1.1        2.72 ±  6%  perf-profile.self.cycles-pp.filemap_get_read_batch
      2.39 ±  7%      +1.7        4.09 ±  5%  perf-profile.self.cycles-pp.apparmor_file_free_security
      4.56 ±  7%      +2.8        7.37 ±  4%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
     11.02 ±  4%      +3.1       14.14 ±  3%  perf-profile.self.cycles-pp.apparmor_file_open




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


