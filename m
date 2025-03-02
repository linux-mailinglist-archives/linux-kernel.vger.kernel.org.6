Return-Path: <linux-kernel+bounces-540534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CECA4B1E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7955116A5EF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CB21E260A;
	Sun,  2 Mar 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgPTkkkd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6671DDC11
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740922663; cv=fail; b=ZiSr7mPRnos24p9Q8CmPAD7LsiTBRX6bAk/yTl9Yv3YG3xvWsG99lTnHbaDyYEwXGx2/AEF1jEaXz/4UP15DgUX8SsKcS8NUBPN3dg+Bcmt8iIbQLUGjqKxodN2yQSk1dsm7oxFdjRuBvFl+Ypm+Z+bYqB7xp4YsOSSPXcZzRKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740922663; c=relaxed/simple;
	bh=002zZiqsZJ4kYqjQrmxRjnZdF5EZAS0MpTdhFC4168o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hrYlevjpCwmpDb9vSO57TM2rxhP7wLkbfF18hpOKTMt4OataDAYMyDyy5TCBQyK4d52xehzk1q9ytnFRF+K11Z/S349mKaQhZF52qEeS/sqJYXOAPfDliJgDIxt1f9ZCPnMUMx8herx+CFE6f+qdq7VzuZ+pgFp5c2o7tRpIYH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgPTkkkd; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740922657; x=1772458657;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=002zZiqsZJ4kYqjQrmxRjnZdF5EZAS0MpTdhFC4168o=;
  b=IgPTkkkdhoXESDgIylkc6evYNzHGuivyMa9h6LXbzqYGFfzCcFR+FvLs
   zi6UW0OApFltQVixdoNx3eLg8SUJQIHkA/FVILp+u0wAFGW0FQjj/6QT0
   pItADCS+bg8E4mhyS/kAntONUbGA6uFYB0FfnhBj0azVqvTRJLc8Z5ldt
   PkC0/puWiu2VLP/pAAvn+qOAKmEm95R3JfuGap38xT8bABJB9HjttlSV+
   LxSniX42x25/KslDplPIqYhl6rr60wXJTpLy1jWyw5tFruj636zA4oITK
   iEx453MRdoMwwpv4BRB7iBkNFFLfd5NFiBb527eoa6koGAwH99Fs8U5/j
   w==;
X-CSE-ConnectionGUID: gbJQyIiCTIS5ll2VIK+xHw==
X-CSE-MsgGUID: 9gY+s5sDRI+1bv81H6wLkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="41690429"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="41690429"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 05:37:36 -0800
X-CSE-ConnectionGUID: wzMIl1lqSxeFO6ynfEJ+dg==
X-CSE-MsgGUID: 4K5AvlqhTQOXk5ASOWhc/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="117567768"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 05:37:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 2 Mar 2025 05:37:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 2 Mar 2025 05:37:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 2 Mar 2025 05:37:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYFvQnsvzkdpuywPq0Id9ePE2KFBOrJZj+910Cyu7GtHzUJ41z+osVApsSmtTXBlMzIWAhBEx8KRe2GJX+wLqoyMXA6M/IN5Kwa3zhR+CLPnE8eV8ViwQSMRfuLZE1QXCnZvT/jB3JscQsmR2hqS3m6RkJY1zREjsBzf/wPs2vg3DIspKsJwcH5MtyBDtVujbXvboIYHaH3OAXBrG3+UNRoUiAJq03gj3HwTPeYpuY0fiJHOwWLyFZs69SxahIR6kmoiERdIPjlJXNmnPLdnpNQqFWYsZUVP455cEaeu1FzmAnU11hxOfu5JZxRzJTVejjqPrjdrdeQ+E+oxv7dfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f8slBbsglqExocqZBhSWul+PiT+nlj5SNwfswYSzNg=;
 b=Vlsl/3x8/7rlBgI7wkEUIfahDL6GEEcjrs5nq+tR0WJC9VkiWBU73lWAfaMfkskKfephQAEghzYzuhaIf9dhIiBVPXrys2/dGklfZgMBiittYLHg3bnYr9wCfDtgF06gvZ44ix/3+WTtOYlR4aUkAqJbqnoEbsQIMpXs3bV5tiSahr9ZWi7iLA4bZkZWqZR56hOExjAJixtf4C1mF2U/Nb07fM34/XScDuvdQuPYKF8L8LD4n9+xiEI5s+rsOVxuNKAOO1iIV2YbJxxZVvxpmox18kdHkJJBTAgyeAAb3w/lXhiU2oANkpFJ0Gi9UiCFyX6sZHjbss2xzE3NWKRTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 13:37:30 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 13:37:30 +0000
Date: Sun, 2 Mar 2025 21:37:20 +0800
From: kernel test robot <lkp@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6:
 Warning (unit_address_vs_reg): /soc/bus@ff800000/pinctrl@14: node has a unit
 name, but no reg or ranges property
Message-ID: <Z8RfEH1bnhbliyWC@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 15250f25-362b-428d-5058-08dd598f5fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m7goMSxcMsXwoiZBVppysVtJ6DeDJG7xUHRVKuIQfUmXVEap9r2YoZKO9loa?=
 =?us-ascii?Q?uhazh4QnEcaxjVGrntSvHa8JiPB6nqP0z11sm/x9N+kwPgzMS8azCcSDvP+s?=
 =?us-ascii?Q?s+n/jiu1VIB3hSo1UH/Qh6yREdiXdMz07UrBxM/RkB3RPcSpNddm/kPq0tae?=
 =?us-ascii?Q?2EooKdOWcOUu8zs7E2cLqsehKgdy2N86JOTtP/4e7frXHWSRy4CH7+uD9YXN?=
 =?us-ascii?Q?iZ6mwEWjt28XLehgDS458iHOxrlg/Lujww8S/xxhPH2HwWz0G1tPGtutLbxk?=
 =?us-ascii?Q?7D9S4YLZJ/mYnVT/NpXdR0UMk9VGG96j3hzKKtUrPesZVNYWFRiMyWl/dgXW?=
 =?us-ascii?Q?eepPuZBl1wdA6aPo7AJEAejvTE4WrXOYneHKcwmhkc8Be68cu/PN/QazICGK?=
 =?us-ascii?Q?snA52X6OSdSZIb5VKRvzkxHDeVhB0c3mnHAh0c8atXGoX7NBBF3SpyTOrD5C?=
 =?us-ascii?Q?uIcSE8votCsiXGmKktV6NKs2jiKGXVauRdjHFy0zLTUIfe/p8QDsRlHETPSD?=
 =?us-ascii?Q?BLuus/nHm1NZzWhksj2eOHBoHlag5uldpGEmF0/r6ow/eP668pqQ1rEvUj5G?=
 =?us-ascii?Q?qWHpZrlkSiQgQ44FRc2SAN2P1Wte/mmaX3Opjqr6uk+2ovBG/U2K2NgLTf2H?=
 =?us-ascii?Q?kOAoDDuCDt61UdU7hPpSSlF0PGUJUa9qL5gMEK+e/1cwvLyflOCzj+kvH/3G?=
 =?us-ascii?Q?X6tzQr06ZM1YTbHn9Jv3eiHPSsoQ5ZhZJPsc9rBx6P7uap4E0lvqF4koVtM3?=
 =?us-ascii?Q?1GUAkLOIO/jO0E73vKEVujVj7TE1GtHwnYTe+ueGsJS9tyzU26OFVZbnCHIO?=
 =?us-ascii?Q?zt84y3VpGUPzrQKFkJ905IvpT3LIsUM2p6S2wGDgjKaYp/eNbObzA4obaujf?=
 =?us-ascii?Q?IhjY1cL64dritQvBbDzlO5KzRwm9LJUVIy3pQ6cRA+wGvY6DIQJfKkbBhZ12?=
 =?us-ascii?Q?fciYFYmgUb387yGkmYl896s3DohWp8e9F5OQjfL3W1aRCXMQvgzxBG0H8a3x?=
 =?us-ascii?Q?L9Hi6nfWJzmaJqDDgALWh2AWVZPvfzP6m9Zy3x90pxS5lzOzFjGx/SdJsELp?=
 =?us-ascii?Q?NmNc8EAx9GCojVpCS6mkeIEQMKhS4oneANIFgBnzaatS/BJ5ko3DfMBUOios?=
 =?us-ascii?Q?BkGICL00qiw/imtmrUA7cS9LlQfL43m/QXfVLUN7P3yBQiAE27JbvP4327om?=
 =?us-ascii?Q?rwV0fnsISnygAJJkguMhrQsKigzV4An0EbBKK5pzUh9EtjrLP29TLIFfYCc6?=
 =?us-ascii?Q?/HMOCL93D7mWYGHuc3l2L9dlAJbcYS2ifGEpaHlgMAWFOenLrOsXr1pN7ngE?=
 =?us-ascii?Q?VXT/2qhiji0Nbf4bqqirQUX8cjJrjx33jVaF69YVmRB9wcPDPfiqT4VE+B9K?=
 =?us-ascii?Q?ONKHKRfkBMmhXIpRFTQhhNRIFpHBwq2YHfRxi5yThQwuofF08w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wf/zLGuPuKq+W+jdokRnArWQczqerBOqzJE/gDvXKvO3WhSnXavgsWrdsUU8?=
 =?us-ascii?Q?AZJN5WFJx9LePnqBrB1jhcNoHbaR9btkhSaR/7Urk+Or/Yz8JODwrjfhOluJ?=
 =?us-ascii?Q?VvrH00aHFyY/atf5MS/VbyzrHOo7HHgXJZ67fe6jebXnTjeFNE0tPFvQJQvL?=
 =?us-ascii?Q?qs8TKvvjNJyUHLuozO4RYQsJbFX34Ht9XKwLSxZly6dTvwyLF5pH2TOBXQ6n?=
 =?us-ascii?Q?vK5KZ3mnyIS2YoKev5YC5j4Ax4Vz5Fygsp//YhqrY6TcK3dk2+gEfznz0PJd?=
 =?us-ascii?Q?+1Ou4R25YIkEB52NxhrvGFxEGSaGNQQsJoHmA2i95AFv6d/2XnR1SOvoy2EA?=
 =?us-ascii?Q?bNqOwP7BMq3gnr/pnIkM9D2pcdHdDfe0N7iFHzBHpYdeV3lLhCt4a8aaMikM?=
 =?us-ascii?Q?WJKRof+mB0vPJAeHwY0BFsxBQvLzr9Bgo1WJG2LrtaClxz/HY57hzggoWjnL?=
 =?us-ascii?Q?njF84RxB5F0mTiUGeKjOsNpCb7Sbm0zNjyWUIgz3f7WU5pLnEOm8j5376b0g?=
 =?us-ascii?Q?SF9/BoKO275769a7JTlTGZf7uPeTLeLA5ZSK2cyCU1tnaK8TMpgML1F6zLpT?=
 =?us-ascii?Q?jrh8POZHwjLj8MPvnyDdOdf9JtS6IDzttpPZnIv2vOOTpPDeEOviLmzdn16c?=
 =?us-ascii?Q?xjnrb6Ab1kFMRvXsuDn+B+liU0hfnYhRnTbQ9ZUoumzuFEsC8dKRVegeBRCz?=
 =?us-ascii?Q?1ho9Y2uNU8UFPJU+G7cD0wHJQdubCmpypg/lXLq4eLy8XoxqOFmUT5DUyEc/?=
 =?us-ascii?Q?rxKv7zQPtzCqiS3f/3gHBBKOOACkGz1I6ITjFgrgy6Xq75ZvhPfk0hhw58MG?=
 =?us-ascii?Q?7GKmT2fcwWuoczNGh+LdVKEnbqys0FBPQ/+6rq4OBMruj6jIYrsYN118mISx?=
 =?us-ascii?Q?+Qf7AyiHfmr7wfIqZtt7UuHhYMLyjCoDr1JhaWdvaJQrRqbo11B+CW0Hc/GZ?=
 =?us-ascii?Q?+NVHhT02pu/bA9J5+1Z8+MMxpVMMPVowjN7u6UovTj0AV85gI0q6M/IEm+8g?=
 =?us-ascii?Q?y1IbRgF7C8jCqUmdu6Og4SzwSBpNOC+Gsoi/JdVIUAbOfPwmJHVytpXHKHwx?=
 =?us-ascii?Q?dItpoxNEUsLkeVNQmW9ifiBnktQofHfBK+8yUzvp9YUQFFoYwt9QhjJ1FdMA?=
 =?us-ascii?Q?KlNGgduY1F+OwCKBynQ+VNzRTysTseebx/ffqdYYhgwbvH+bnUPfH2TRVnnt?=
 =?us-ascii?Q?1FOu37nPpJBFCTQsIc3gjHpTMJHYnupwSRfl/C5MDnGIqm3HR81wj7k6buxJ?=
 =?us-ascii?Q?Wy510IlnlIdhoJ2JPh3fg750JxEJu4S56K19+Tl3/HPfAsX8J0N24yY+TJgj?=
 =?us-ascii?Q?eyDSx62jgMBxQBNRr3cijpM5tlfV/BQeCKnypcnM8Rb0/UHkVDGxz1dp04+x?=
 =?us-ascii?Q?KAUB6ncuhS2sUd+uoIncbMWG+HSJuUez0APi6OWbyy6/OyeovDlO3bH9IZhK?=
 =?us-ascii?Q?Xjkrh3gkovpCHftGFJte+a24TfSZtzexMkMjOslZpueHdB09CLsbuQixtLsJ?=
 =?us-ascii?Q?ZYlNErUFa//Fbvp0CGsMSvhC0sonc6BEMAiZNOIre96+yJiiddNU+C9SAjJ2?=
 =?us-ascii?Q?cS/rpwuki+OaSg25pzKsGdc/hSKVr7I19wf2XwgBEya9Klv/2bOhPpZfCgCV?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15250f25-362b-428d-5058-08dd598f5fc0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 13:37:30.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFFG0/4YAFCEKbBsCCIW2KZy5VtmAttNUp1HXg1GpNHOzJhk4vGxozEHlpCN5Ug6Vp2gv95gMUvo82eJRJVAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ece144f151ac7bf8bb5b98f7d4aeeda7a2eed02a
commit: cf42ea27fd7f087b43da27b709267211e7e0e8c4 arm64: dts: amlogic: move ao_pinctrl into aobus
date:   9 months ago
:::::: branch date: 13 hours ago
:::::: commit date: 9 months ago
config: arm64-randconfig-001-20241212 (https://download.01.org/0day-ci/archive/20250302/202503022101.KbCNKl3R-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503022101.KbCNKl3R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202503022101.KbCNKl3R-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (unit_address_vs_reg): /soc/bus@ff800000/pinctrl@14: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (simple_bus_reg): /soc/bus@ff800000/pinctrl@14: missing or empty reg/ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2217.23-2257.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
--
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (unit_address_vs_reg): /soc/bus@ff800000/pinctrl@14: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (simple_bus_reg): /soc/bus@ff800000/pinctrl@14: missing or empty reg/ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2217.23-2257.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
--
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (unit_address_vs_reg): /soc/bus@ff800000/pinctrl@14: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (simple_bus_reg): /soc/bus@ff800000/pinctrl@14: missing or empty reg/ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2217.23-2257.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
--
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (unit_address_vs_reg): /soc/bus@ff800000/pinctrl@14: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (simple_bus_reg): /soc/bus@ff800000/pinctrl@14: missing or empty reg/ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2217.23-2257.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
--
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (unit_address_vs_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: node has a unit name, but no reg or ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (unit_address_vs_reg): /soc/bus@ff800000/pinctrl@14: node has a unit name, but no reg or ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:266.33-1540.7: Warning (simple_bus_reg): /soc/bus@ff600000/bus@34400/pinctrl@40: missing or empty reg/ranges property
>> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:1754.27-2026.6: Warning (simple_bus_reg): /soc/bus@ff800000/pinctrl@14: missing or empty reg/ranges property
   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:2217.23-2257.6: Warning (avoid_unnecessary_addr_size): /soc/bus@ffd00000/dsi@7000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

vim +1754 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi

1499218c80c99a Neil Armstrong      2019-07-29    15  
1499218c80c99a Neil Armstrong      2019-07-29    16  / {
1499218c80c99a Neil Armstrong      2019-07-29    17  	interrupt-parent = <&gic>;
1499218c80c99a Neil Armstrong      2019-07-29    18  	#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29    19  	#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29    20  
ab547c4fb39fe1 Alexander Stein     2021-02-03    21  	aliases {
ab547c4fb39fe1 Alexander Stein     2021-02-03    22  		mmc0 = &sd_emmc_b; /* SD card */
ab547c4fb39fe1 Alexander Stein     2021-02-03    23  		mmc1 = &sd_emmc_c; /* eMMC */
ab547c4fb39fe1 Alexander Stein     2021-02-03    24  		mmc2 = &sd_emmc_a; /* SDIO */
ab547c4fb39fe1 Alexander Stein     2021-02-03    25  	};
ab547c4fb39fe1 Alexander Stein     2021-02-03    26  
15767cfd81eb9f Neil Armstrong      2019-10-03    27  	chosen {
15767cfd81eb9f Neil Armstrong      2019-10-03    28  		#address-cells = <2>;
15767cfd81eb9f Neil Armstrong      2019-10-03    29  		#size-cells = <2>;
15767cfd81eb9f Neil Armstrong      2019-10-03    30  		ranges;
15767cfd81eb9f Neil Armstrong      2019-10-03    31  
15767cfd81eb9f Neil Armstrong      2019-10-03    32  		simplefb_cvbs: framebuffer-cvbs {
15767cfd81eb9f Neil Armstrong      2019-10-03    33  			compatible = "amlogic,simple-framebuffer",
15767cfd81eb9f Neil Armstrong      2019-10-03    34  				     "simple-framebuffer";
15767cfd81eb9f Neil Armstrong      2019-10-03    35  			amlogic,pipeline = "vpu-cvbs";
15767cfd81eb9f Neil Armstrong      2019-10-03    36  			clocks = <&clkc CLKID_HDMI>,
15767cfd81eb9f Neil Armstrong      2019-10-03    37  				 <&clkc CLKID_HTX_PCLK>,
15767cfd81eb9f Neil Armstrong      2019-10-03    38  				 <&clkc CLKID_VPU_INTR>;
15767cfd81eb9f Neil Armstrong      2019-10-03    39  			status = "disabled";
15767cfd81eb9f Neil Armstrong      2019-10-03    40  		};
15767cfd81eb9f Neil Armstrong      2019-10-03    41  
15767cfd81eb9f Neil Armstrong      2019-10-03    42  		simplefb_hdmi: framebuffer-hdmi {
15767cfd81eb9f Neil Armstrong      2019-10-03    43  			compatible = "amlogic,simple-framebuffer",
15767cfd81eb9f Neil Armstrong      2019-10-03    44  				    "simple-framebuffer";
15767cfd81eb9f Neil Armstrong      2019-10-03    45  			amlogic,pipeline = "vpu-hdmi";
15767cfd81eb9f Neil Armstrong      2019-10-03    46  			clocks = <&clkc CLKID_HDMI>,
15767cfd81eb9f Neil Armstrong      2019-10-03    47  				 <&clkc CLKID_HTX_PCLK>,
15767cfd81eb9f Neil Armstrong      2019-10-03    48  				 <&clkc CLKID_VPU_INTR>;
15767cfd81eb9f Neil Armstrong      2019-10-03    49  			status = "disabled";
15767cfd81eb9f Neil Armstrong      2019-10-03    50  		};
15767cfd81eb9f Neil Armstrong      2019-10-03    51  	};
15767cfd81eb9f Neil Armstrong      2019-10-03    52  
1499218c80c99a Neil Armstrong      2019-07-29    53  	efuse: efuse {
1499218c80c99a Neil Armstrong      2019-07-29    54  		compatible = "amlogic,meson-gxbb-efuse";
1499218c80c99a Neil Armstrong      2019-07-29    55  		clocks = <&clkc CLKID_EFUSE>;
1499218c80c99a Neil Armstrong      2019-07-29    56  		#address-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29    57  		#size-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29    58  		read-only;
de82e74a9f2631 Carlo Caione        2019-07-31    59  		secure-monitor = <&sm>;
1499218c80c99a Neil Armstrong      2019-07-29    60  	};
1499218c80c99a Neil Armstrong      2019-07-29    61  
bb98a6fd0b0e22 Alexander Stein     2021-10-26    62  	gpu_opp_table: opp-table-gpu {
916a0edc43f03f Martin Blumenstingl 2020-07-19    63  		compatible = "operating-points-v2";
916a0edc43f03f Martin Blumenstingl 2020-07-19    64  
916a0edc43f03f Martin Blumenstingl 2020-07-19    65  		opp-124999998 {
916a0edc43f03f Martin Blumenstingl 2020-07-19    66  			opp-hz = /bits/ 64 <124999998>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    67  			opp-microvolt = <800000>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    68  		};
916a0edc43f03f Martin Blumenstingl 2020-07-19    69  		opp-249999996 {
916a0edc43f03f Martin Blumenstingl 2020-07-19    70  			opp-hz = /bits/ 64 <249999996>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    71  			opp-microvolt = <800000>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    72  		};
916a0edc43f03f Martin Blumenstingl 2020-07-19    73  		opp-285714281 {
916a0edc43f03f Martin Blumenstingl 2020-07-19    74  			opp-hz = /bits/ 64 <285714281>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    75  			opp-microvolt = <800000>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    76  		};
916a0edc43f03f Martin Blumenstingl 2020-07-19    77  		opp-399999994 {
916a0edc43f03f Martin Blumenstingl 2020-07-19    78  			opp-hz = /bits/ 64 <399999994>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    79  			opp-microvolt = <800000>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    80  		};
916a0edc43f03f Martin Blumenstingl 2020-07-19    81  		opp-499999992 {
916a0edc43f03f Martin Blumenstingl 2020-07-19    82  			opp-hz = /bits/ 64 <499999992>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    83  			opp-microvolt = <800000>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    84  		};
916a0edc43f03f Martin Blumenstingl 2020-07-19    85  		opp-666666656 {
916a0edc43f03f Martin Blumenstingl 2020-07-19    86  			opp-hz = /bits/ 64 <666666656>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    87  			opp-microvolt = <800000>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    88  		};
916a0edc43f03f Martin Blumenstingl 2020-07-19    89  		opp-799999987 {
916a0edc43f03f Martin Blumenstingl 2020-07-19    90  			opp-hz = /bits/ 64 <799999987>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    91  			opp-microvolt = <800000>;
916a0edc43f03f Martin Blumenstingl 2020-07-19    92  		};
916a0edc43f03f Martin Blumenstingl 2020-07-19    93  	};
916a0edc43f03f Martin Blumenstingl 2020-07-19    94  
1499218c80c99a Neil Armstrong      2019-07-29    95  	psci {
1499218c80c99a Neil Armstrong      2019-07-29    96  		compatible = "arm,psci-1.0";
1499218c80c99a Neil Armstrong      2019-07-29    97  		method = "smc";
1499218c80c99a Neil Armstrong      2019-07-29    98  	};
1499218c80c99a Neil Armstrong      2019-07-29    99  
1499218c80c99a Neil Armstrong      2019-07-29   100  	reserved-memory {
1499218c80c99a Neil Armstrong      2019-07-29   101  		#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   102  		#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   103  		ranges;
1499218c80c99a Neil Armstrong      2019-07-29   104  
1499218c80c99a Neil Armstrong      2019-07-29   105  		/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
1499218c80c99a Neil Armstrong      2019-07-29   106  		secmon_reserved: secmon@5000000 {
1499218c80c99a Neil Armstrong      2019-07-29   107  			reg = <0x0 0x05000000 0x0 0x300000>;
1499218c80c99a Neil Armstrong      2019-07-29   108  			no-map;
1499218c80c99a Neil Armstrong      2019-07-29   109  		};
1499218c80c99a Neil Armstrong      2019-07-29   110  
08982a1b3aa261 Christian Hewitt    2022-01-26   111  		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
08982a1b3aa261 Christian Hewitt    2022-01-26   112  		secmon_reserved_bl32: secmon@5300000 {
08982a1b3aa261 Christian Hewitt    2022-01-26   113  			reg = <0x0 0x05300000 0x0 0x2000000>;
08982a1b3aa261 Christian Hewitt    2022-01-26   114  			no-map;
08982a1b3aa261 Christian Hewitt    2022-01-26   115  		};
08982a1b3aa261 Christian Hewitt    2022-01-26   116  
1499218c80c99a Neil Armstrong      2019-07-29   117  		linux,cma {
1499218c80c99a Neil Armstrong      2019-07-29   118  			compatible = "shared-dma-pool";
1499218c80c99a Neil Armstrong      2019-07-29   119  			reusable;
1499218c80c99a Neil Armstrong      2019-07-29   120  			size = <0x0 0x10000000>;
1499218c80c99a Neil Armstrong      2019-07-29   121  			alignment = <0x0 0x400000>;
1499218c80c99a Neil Armstrong      2019-07-29   122  			linux,cma-default;
1499218c80c99a Neil Armstrong      2019-07-29   123  		};
1499218c80c99a Neil Armstrong      2019-07-29   124  	};
1499218c80c99a Neil Armstrong      2019-07-29   125  
1499218c80c99a Neil Armstrong      2019-07-29   126  	sm: secure-monitor {
1499218c80c99a Neil Armstrong      2019-07-29   127  		compatible = "amlogic,meson-gxbb-sm";
1499218c80c99a Neil Armstrong      2019-07-29   128  	};
1499218c80c99a Neil Armstrong      2019-07-29   129  
1499218c80c99a Neil Armstrong      2019-07-29   130  	soc {
1499218c80c99a Neil Armstrong      2019-07-29   131  		compatible = "simple-bus";
1499218c80c99a Neil Armstrong      2019-07-29   132  		#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   133  		#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   134  		ranges;
1499218c80c99a Neil Armstrong      2019-07-29   135  
1f8607d597635c Neil Armstrong      2019-09-16   136  		pcie: pcie@fc000000 {
1f8607d597635c Neil Armstrong      2019-09-16   137  			compatible = "amlogic,g12a-pcie", "snps,dw-pcie";
d9421d6c52942b Kevin Hilman        2021-04-21   138  			reg = <0x0 0xfc000000 0x0 0x400000>,
d9421d6c52942b Kevin Hilman        2021-04-21   139  			      <0x0 0xff648000 0x0 0x2000>,
d9421d6c52942b Kevin Hilman        2021-04-21   140  			      <0x0 0xfc400000 0x0 0x200000>;
1f8607d597635c Neil Armstrong      2019-09-16   141  			reg-names = "elbi", "cfg", "config";
1f8607d597635c Neil Armstrong      2019-09-16   142  			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
1f8607d597635c Neil Armstrong      2019-09-16   143  			#interrupt-cells = <1>;
1f8607d597635c Neil Armstrong      2019-09-16   144  			interrupt-map-mask = <0 0 0 0>;
1f8607d597635c Neil Armstrong      2019-09-16   145  			interrupt-map = <0 0 0 0 &gic GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
1f8607d597635c Neil Armstrong      2019-09-16   146  			bus-range = <0x0 0xff>;
1f8607d597635c Neil Armstrong      2019-09-16   147  			#address-cells = <3>;
1f8607d597635c Neil Armstrong      2019-09-16   148  			#size-cells = <2>;
1f8607d597635c Neil Armstrong      2019-09-16   149  			device_type = "pci";
d9421d6c52942b Kevin Hilman        2021-04-21   150  			ranges = <0x81000000 0 0 0x0 0xfc600000 0 0x00100000>,
d9421d6c52942b Kevin Hilman        2021-04-21   151  				 <0x82000000 0 0xfc700000 0x0 0xfc700000 0 0x1900000>;
1f8607d597635c Neil Armstrong      2019-09-16   152  
1f8607d597635c Neil Armstrong      2019-09-16   153  			clocks = <&clkc CLKID_PCIE_PHY
1f8607d597635c Neil Armstrong      2019-09-16   154  				  &clkc CLKID_PCIE_COMB
1f8607d597635c Neil Armstrong      2019-09-16   155  				  &clkc CLKID_PCIE_PLL>;
1f8607d597635c Neil Armstrong      2019-09-16   156  			clock-names = "general",
1f8607d597635c Neil Armstrong      2019-09-16   157  				      "pclk",
1f8607d597635c Neil Armstrong      2019-09-16   158  				      "port";
1f8607d597635c Neil Armstrong      2019-09-16   159  			resets = <&reset RESET_PCIE_CTRL_A>,
1f8607d597635c Neil Armstrong      2019-09-16   160  				 <&reset RESET_PCIE_APB>;
1f8607d597635c Neil Armstrong      2019-09-16   161  			reset-names = "port",
1f8607d597635c Neil Armstrong      2019-09-16   162  				      "apb";
1f8607d597635c Neil Armstrong      2019-09-16   163  			num-lanes = <1>;
1f8607d597635c Neil Armstrong      2019-09-16   164  			phys = <&usb3_pcie_phy PHY_TYPE_PCIE>;
1f8607d597635c Neil Armstrong      2019-09-16   165  			phy-names = "pcie";
1f8607d597635c Neil Armstrong      2019-09-16   166  			status = "disabled";
1f8607d597635c Neil Armstrong      2019-09-16   167  		};
1f8607d597635c Neil Armstrong      2019-09-16   168  
1499218c80c99a Neil Armstrong      2019-07-29   169  		ethmac: ethernet@ff3f0000 {
1fdc97ae450ede Martin Blumenstingl 2020-09-25   170  			compatible = "amlogic,meson-g12a-dwmac",
1499218c80c99a Neil Armstrong      2019-07-29   171  				     "snps,dwmac-3.70a",
1499218c80c99a Neil Armstrong      2019-07-29   172  				     "snps,dwmac";
3ad6c9e3575611 Neil Armstrong      2019-08-23   173  			reg = <0x0 0xff3f0000 0x0 0x10000>,
3ad6c9e3575611 Neil Armstrong      2019-08-23   174  			      <0x0 0xff634540 0x0 0x8>;
1499218c80c99a Neil Armstrong      2019-07-29   175  			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
1499218c80c99a Neil Armstrong      2019-07-29   176  			interrupt-names = "macirq";
1499218c80c99a Neil Armstrong      2019-07-29   177  			clocks = <&clkc CLKID_ETH>,
1499218c80c99a Neil Armstrong      2019-07-29   178  				 <&clkc CLKID_FCLK_DIV2>,
32b5f4b63487a2 Martin Blumenstingl 2020-06-20   179  				 <&clkc CLKID_MPLL2>,
32b5f4b63487a2 Martin Blumenstingl 2020-06-20   180  				 <&clkc CLKID_FCLK_DIV2>;
32b5f4b63487a2 Martin Blumenstingl 2020-06-20   181  			clock-names = "stmmaceth", "clkin0", "clkin1",
32b5f4b63487a2 Martin Blumenstingl 2020-06-20   182  				      "timing-adjustment";
ef68984eab6bbe Jerome Brunet       2019-07-18   183  			rx-fifo-depth = <4096>;
ef68984eab6bbe Jerome Brunet       2019-07-18   184  			tx-fifo-depth = <2048>;
1499218c80c99a Neil Armstrong      2019-07-29   185  			status = "disabled";
1499218c80c99a Neil Armstrong      2019-07-29   186  
1499218c80c99a Neil Armstrong      2019-07-29   187  			mdio0: mdio {
1499218c80c99a Neil Armstrong      2019-07-29   188  				#address-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29   189  				#size-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29   190  				compatible = "snps,dwmac-mdio";
1499218c80c99a Neil Armstrong      2019-07-29   191  			};
1499218c80c99a Neil Armstrong      2019-07-29   192  		};
1499218c80c99a Neil Armstrong      2019-07-29   193  
1499218c80c99a Neil Armstrong      2019-07-29   194  		apb: bus@ff600000 {
1499218c80c99a Neil Armstrong      2019-07-29   195  			compatible = "simple-bus";
1499218c80c99a Neil Armstrong      2019-07-29   196  			reg = <0x0 0xff600000 0x0 0x200000>;
1499218c80c99a Neil Armstrong      2019-07-29   197  			#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   198  			#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   199  			ranges = <0x0 0x0 0x0 0xff600000 0x0 0x200000>;
1499218c80c99a Neil Armstrong      2019-07-29   200  
1499218c80c99a Neil Armstrong      2019-07-29   201  			hdmi_tx: hdmi-tx@0 {
1499218c80c99a Neil Armstrong      2019-07-29   202  				compatible = "amlogic,meson-g12a-dw-hdmi";
1499218c80c99a Neil Armstrong      2019-07-29   203  				reg = <0x0 0x0 0x0 0x10000>;
1499218c80c99a Neil Armstrong      2019-07-29   204  				interrupts = <GIC_SPI 57 IRQ_TYPE_EDGE_RISING>;
1499218c80c99a Neil Armstrong      2019-07-29   205  				resets = <&reset RESET_HDMITX_CAPB3>,
1499218c80c99a Neil Armstrong      2019-07-29   206  					 <&reset RESET_HDMITX_PHY>,
1499218c80c99a Neil Armstrong      2019-07-29   207  					 <&reset RESET_HDMITX>;
1499218c80c99a Neil Armstrong      2019-07-29   208  				reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
1499218c80c99a Neil Armstrong      2019-07-29   209  				clocks = <&clkc CLKID_HDMI>,
1499218c80c99a Neil Armstrong      2019-07-29   210  					 <&clkc CLKID_HTX_PCLK>,
1499218c80c99a Neil Armstrong      2019-07-29   211  					 <&clkc CLKID_VPU_INTR>;
1499218c80c99a Neil Armstrong      2019-07-29   212  				clock-names = "isfr", "iahb", "venci";
1499218c80c99a Neil Armstrong      2019-07-29   213  				#address-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29   214  				#size-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29   215  				#sound-dai-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29   216  				status = "disabled";
1499218c80c99a Neil Armstrong      2019-07-29   217  
1499218c80c99a Neil Armstrong      2019-07-29   218  				/* VPU VENC Input */
1499218c80c99a Neil Armstrong      2019-07-29   219  				hdmi_tx_venc_port: port@0 {
1499218c80c99a Neil Armstrong      2019-07-29   220  					reg = <0>;
1499218c80c99a Neil Armstrong      2019-07-29   221  
1499218c80c99a Neil Armstrong      2019-07-29   222  					hdmi_tx_in: endpoint {
1499218c80c99a Neil Armstrong      2019-07-29   223  						remote-endpoint = <&hdmi_tx_out>;
1499218c80c99a Neil Armstrong      2019-07-29   224  					};
1499218c80c99a Neil Armstrong      2019-07-29   225  				};
1499218c80c99a Neil Armstrong      2019-07-29   226  
1499218c80c99a Neil Armstrong      2019-07-29   227  				/* TMDS Output */
1499218c80c99a Neil Armstrong      2019-07-29   228  				hdmi_tx_tmds_port: port@1 {
1499218c80c99a Neil Armstrong      2019-07-29   229  					reg = <1>;
1499218c80c99a Neil Armstrong      2019-07-29   230  				};
1499218c80c99a Neil Armstrong      2019-07-29   231  			};
1499218c80c99a Neil Armstrong      2019-07-29   232  
1499218c80c99a Neil Armstrong      2019-07-29   233  			apb_efuse: bus@30000 {
1499218c80c99a Neil Armstrong      2019-07-29   234  				compatible = "simple-bus";
1499218c80c99a Neil Armstrong      2019-07-29   235  				reg = <0x0 0x30000 0x0 0x2000>;
1499218c80c99a Neil Armstrong      2019-07-29   236  				#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   237  				#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   238  				ranges = <0x0 0x0 0x0 0x30000 0x0 0x2000>;
1499218c80c99a Neil Armstrong      2019-07-29   239  
1499218c80c99a Neil Armstrong      2019-07-29   240  				hwrng: rng@218 {
1499218c80c99a Neil Armstrong      2019-07-29   241  					compatible = "amlogic,meson-rng";
1499218c80c99a Neil Armstrong      2019-07-29   242  					reg = <0x0 0x218 0x0 0x4>;
a1afbbb0285797 Scott K Logan       2020-09-25   243  					clocks = <&clkc CLKID_RNG0>;
a1afbbb0285797 Scott K Logan       2020-09-25   244  					clock-names = "core";
1499218c80c99a Neil Armstrong      2019-07-29   245  				};
1499218c80c99a Neil Armstrong      2019-07-29   246  			};
1499218c80c99a Neil Armstrong      2019-07-29   247  
457fa78771a23e Jerome Brunet       2020-05-07   248  			acodec: audio-controller@32000 {
457fa78771a23e Jerome Brunet       2020-05-07   249  				compatible = "amlogic,t9015";
457fa78771a23e Jerome Brunet       2020-05-07   250  				reg = <0x0 0x32000 0x0 0x14>;
457fa78771a23e Jerome Brunet       2020-05-07   251  				#sound-dai-cells = <0>;
457fa78771a23e Jerome Brunet       2020-05-07   252  				sound-name-prefix = "ACODEC";
457fa78771a23e Jerome Brunet       2020-05-07   253  				clocks = <&clkc CLKID_AUDIO_CODEC>;
457fa78771a23e Jerome Brunet       2020-05-07   254  				clock-names = "pclk";
457fa78771a23e Jerome Brunet       2020-05-07   255  				resets = <&reset RESET_AUDIO_CODEC>;
457fa78771a23e Jerome Brunet       2020-05-07   256  				status = "disabled";
457fa78771a23e Jerome Brunet       2020-05-07   257  			};
457fa78771a23e Jerome Brunet       2020-05-07   258  
1499218c80c99a Neil Armstrong      2019-07-29   259  			periphs: bus@34400 {
1499218c80c99a Neil Armstrong      2019-07-29   260  				compatible = "simple-bus";
1499218c80c99a Neil Armstrong      2019-07-29   261  				reg = <0x0 0x34400 0x0 0x400>;
1499218c80c99a Neil Armstrong      2019-07-29   262  				#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   263  				#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   264  				ranges = <0x0 0x0 0x0 0x34400 0x0 0x400>;
1499218c80c99a Neil Armstrong      2019-07-29   265  
1499218c80c99a Neil Armstrong      2019-07-29   266  				periphs_pinctrl: pinctrl@40 {
1499218c80c99a Neil Armstrong      2019-07-29   267  					compatible = "amlogic,meson-g12a-periphs-pinctrl";
1499218c80c99a Neil Armstrong      2019-07-29   268  					#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   269  					#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   270  					ranges;
1499218c80c99a Neil Armstrong      2019-07-29   271  
1499218c80c99a Neil Armstrong      2019-07-29   272  					gpio: bank@40 {
1499218c80c99a Neil Armstrong      2019-07-29   273  						reg = <0x0 0x40  0x0 0x4c>,
1499218c80c99a Neil Armstrong      2019-07-29   274  						      <0x0 0xe8  0x0 0x18>,
1499218c80c99a Neil Armstrong      2019-07-29   275  						      <0x0 0x120 0x0 0x18>,
1499218c80c99a Neil Armstrong      2019-07-29   276  						      <0x0 0x2c0 0x0 0x40>,
1499218c80c99a Neil Armstrong      2019-07-29   277  						      <0x0 0x340 0x0 0x1c>;
1499218c80c99a Neil Armstrong      2019-07-29   278  						reg-names = "gpio",
1499218c80c99a Neil Armstrong      2019-07-29   279  							    "pull",
1499218c80c99a Neil Armstrong      2019-07-29   280  							    "pull-enable",
1499218c80c99a Neil Armstrong      2019-07-29   281  							    "mux",
1499218c80c99a Neil Armstrong      2019-07-29   282  							    "ds";
1499218c80c99a Neil Armstrong      2019-07-29   283  						gpio-controller;
1499218c80c99a Neil Armstrong      2019-07-29   284  						#gpio-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29   285  						gpio-ranges = <&periphs_pinctrl 0 0 86>;
1499218c80c99a Neil Armstrong      2019-07-29   286  					};
1499218c80c99a Neil Armstrong      2019-07-29   287  
1499218c80c99a Neil Armstrong      2019-07-29   288  					cec_ao_a_h_pins: cec_ao_a_h {
1499218c80c99a Neil Armstrong      2019-07-29   289  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   290  							groups = "cec_ao_a_h";
1499218c80c99a Neil Armstrong      2019-07-29   291  							function = "cec_ao_a_h";
1499218c80c99a Neil Armstrong      2019-07-29   292  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   293  						};
1499218c80c99a Neil Armstrong      2019-07-29   294  					};
1499218c80c99a Neil Armstrong      2019-07-29   295  
1499218c80c99a Neil Armstrong      2019-07-29   296  					cec_ao_b_h_pins: cec_ao_b_h {
1499218c80c99a Neil Armstrong      2019-07-29   297  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   298  							groups = "cec_ao_b_h";
1499218c80c99a Neil Armstrong      2019-07-29   299  							function = "cec_ao_b_h";
1499218c80c99a Neil Armstrong      2019-07-29   300  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   301  						};
1499218c80c99a Neil Armstrong      2019-07-29   302  					};
1499218c80c99a Neil Armstrong      2019-07-29   303  
4d2cb376e5ccac Neil Armstrong      2020-03-13   304  					emmc_ctrl_pins: emmc-ctrl {
1499218c80c99a Neil Armstrong      2019-07-29   305  						mux-0 {
4d2cb376e5ccac Neil Armstrong      2020-03-13   306  							groups = "emmc_cmd";
1499218c80c99a Neil Armstrong      2019-07-29   307  							function = "emmc";
1499218c80c99a Neil Armstrong      2019-07-29   308  							bias-pull-up;
1499218c80c99a Neil Armstrong      2019-07-29   309  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   310  						};
1499218c80c99a Neil Armstrong      2019-07-29   311  
1499218c80c99a Neil Armstrong      2019-07-29   312  						mux-1 {
1499218c80c99a Neil Armstrong      2019-07-29   313  							groups = "emmc_clk";
1499218c80c99a Neil Armstrong      2019-07-29   314  							function = "emmc";
1499218c80c99a Neil Armstrong      2019-07-29   315  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   316  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   317  						};
1499218c80c99a Neil Armstrong      2019-07-29   318  					};
1499218c80c99a Neil Armstrong      2019-07-29   319  
4d2cb376e5ccac Neil Armstrong      2020-03-13   320  					emmc_data_4b_pins: emmc-data-4b {
4d2cb376e5ccac Neil Armstrong      2020-03-13   321  						mux-0 {
4d2cb376e5ccac Neil Armstrong      2020-03-13   322  							groups = "emmc_nand_d0",
4d2cb376e5ccac Neil Armstrong      2020-03-13   323  								 "emmc_nand_d1",
4d2cb376e5ccac Neil Armstrong      2020-03-13   324  								 "emmc_nand_d2",
4d2cb376e5ccac Neil Armstrong      2020-03-13   325  								 "emmc_nand_d3";
4d2cb376e5ccac Neil Armstrong      2020-03-13   326  							function = "emmc";
4d2cb376e5ccac Neil Armstrong      2020-03-13   327  							bias-pull-up;
4d2cb376e5ccac Neil Armstrong      2020-03-13   328  							drive-strength-microamp = <4000>;
4d2cb376e5ccac Neil Armstrong      2020-03-13   329  						};
4d2cb376e5ccac Neil Armstrong      2020-03-13   330  					};
4d2cb376e5ccac Neil Armstrong      2020-03-13   331  
4d2cb376e5ccac Neil Armstrong      2020-03-13   332  					emmc_data_8b_pins: emmc-data-8b {
4d2cb376e5ccac Neil Armstrong      2020-03-13   333  						mux-0 {
4d2cb376e5ccac Neil Armstrong      2020-03-13   334  							groups = "emmc_nand_d0",
4d2cb376e5ccac Neil Armstrong      2020-03-13   335  								 "emmc_nand_d1",
4d2cb376e5ccac Neil Armstrong      2020-03-13   336  								 "emmc_nand_d2",
4d2cb376e5ccac Neil Armstrong      2020-03-13   337  								 "emmc_nand_d3",
4d2cb376e5ccac Neil Armstrong      2020-03-13   338  								 "emmc_nand_d4",
4d2cb376e5ccac Neil Armstrong      2020-03-13   339  								 "emmc_nand_d5",
4d2cb376e5ccac Neil Armstrong      2020-03-13   340  								 "emmc_nand_d6",
4d2cb376e5ccac Neil Armstrong      2020-03-13   341  								 "emmc_nand_d7";
4d2cb376e5ccac Neil Armstrong      2020-03-13   342  							function = "emmc";
4d2cb376e5ccac Neil Armstrong      2020-03-13   343  							bias-pull-up;
4d2cb376e5ccac Neil Armstrong      2020-03-13   344  							drive-strength-microamp = <4000>;
4d2cb376e5ccac Neil Armstrong      2020-03-13   345  						};
4d2cb376e5ccac Neil Armstrong      2020-03-13   346  					};
4d2cb376e5ccac Neil Armstrong      2020-03-13   347  
1499218c80c99a Neil Armstrong      2019-07-29   348  					emmc_ds_pins: emmc-ds {
1499218c80c99a Neil Armstrong      2019-07-29   349  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   350  							groups = "emmc_nand_ds";
1499218c80c99a Neil Armstrong      2019-07-29   351  							function = "emmc";
1499218c80c99a Neil Armstrong      2019-07-29   352  							bias-pull-down;
1499218c80c99a Neil Armstrong      2019-07-29   353  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   354  						};
1499218c80c99a Neil Armstrong      2019-07-29   355  					};
1499218c80c99a Neil Armstrong      2019-07-29   356  
1499218c80c99a Neil Armstrong      2019-07-29   357  					emmc_clk_gate_pins: emmc_clk_gate {
1499218c80c99a Neil Armstrong      2019-07-29   358  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   359  							groups = "BOOT_8";
1499218c80c99a Neil Armstrong      2019-07-29   360  							function = "gpio_periphs";
1499218c80c99a Neil Armstrong      2019-07-29   361  							bias-pull-down;
1499218c80c99a Neil Armstrong      2019-07-29   362  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   363  						};
1499218c80c99a Neil Armstrong      2019-07-29   364  					};
1499218c80c99a Neil Armstrong      2019-07-29   365  
1499218c80c99a Neil Armstrong      2019-07-29   366  					hdmitx_ddc_pins: hdmitx_ddc {
1499218c80c99a Neil Armstrong      2019-07-29   367  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   368  							groups = "hdmitx_sda",
1499218c80c99a Neil Armstrong      2019-07-29   369  								 "hdmitx_sck";
1499218c80c99a Neil Armstrong      2019-07-29   370  							function = "hdmitx";
1499218c80c99a Neil Armstrong      2019-07-29   371  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   372  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   373  						};
1499218c80c99a Neil Armstrong      2019-07-29   374  					};
1499218c80c99a Neil Armstrong      2019-07-29   375  
1499218c80c99a Neil Armstrong      2019-07-29   376  					hdmitx_hpd_pins: hdmitx_hpd {
1499218c80c99a Neil Armstrong      2019-07-29   377  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   378  							groups = "hdmitx_hpd_in";
1499218c80c99a Neil Armstrong      2019-07-29   379  							function = "hdmitx";
1499218c80c99a Neil Armstrong      2019-07-29   380  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   381  						};
1499218c80c99a Neil Armstrong      2019-07-29   382  					};
1499218c80c99a Neil Armstrong      2019-07-29   383  
1499218c80c99a Neil Armstrong      2019-07-29   384  
1499218c80c99a Neil Armstrong      2019-07-29   385  					i2c0_sda_c_pins: i2c0-sda-c {
1499218c80c99a Neil Armstrong      2019-07-29   386  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   387  							groups = "i2c0_sda_c";
1499218c80c99a Neil Armstrong      2019-07-29   388  							function = "i2c0";
1499218c80c99a Neil Armstrong      2019-07-29   389  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   390  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   391  
1499218c80c99a Neil Armstrong      2019-07-29   392  						};
1499218c80c99a Neil Armstrong      2019-07-29   393  					};
1499218c80c99a Neil Armstrong      2019-07-29   394  
1499218c80c99a Neil Armstrong      2019-07-29   395  					i2c0_sck_c_pins: i2c0-sck-c {
1499218c80c99a Neil Armstrong      2019-07-29   396  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   397  							groups = "i2c0_sck_c";
1499218c80c99a Neil Armstrong      2019-07-29   398  							function = "i2c0";
1499218c80c99a Neil Armstrong      2019-07-29   399  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   400  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   401  						};
1499218c80c99a Neil Armstrong      2019-07-29   402  					};
1499218c80c99a Neil Armstrong      2019-07-29   403  
1499218c80c99a Neil Armstrong      2019-07-29   404  					i2c0_sda_z0_pins: i2c0-sda-z0 {
1499218c80c99a Neil Armstrong      2019-07-29   405  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   406  							groups = "i2c0_sda_z0";
1499218c80c99a Neil Armstrong      2019-07-29   407  							function = "i2c0";
1499218c80c99a Neil Armstrong      2019-07-29   408  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   409  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   410  						};
1499218c80c99a Neil Armstrong      2019-07-29   411  					};
1499218c80c99a Neil Armstrong      2019-07-29   412  
1499218c80c99a Neil Armstrong      2019-07-29   413  					i2c0_sck_z1_pins: i2c0-sck-z1 {
1499218c80c99a Neil Armstrong      2019-07-29   414  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   415  							groups = "i2c0_sck_z1";
1499218c80c99a Neil Armstrong      2019-07-29   416  							function = "i2c0";
1499218c80c99a Neil Armstrong      2019-07-29   417  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   418  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   419  						};
1499218c80c99a Neil Armstrong      2019-07-29   420  					};
1499218c80c99a Neil Armstrong      2019-07-29   421  
1499218c80c99a Neil Armstrong      2019-07-29   422  					i2c0_sda_z7_pins: i2c0-sda-z7 {
1499218c80c99a Neil Armstrong      2019-07-29   423  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   424  							groups = "i2c0_sda_z7";
1499218c80c99a Neil Armstrong      2019-07-29   425  							function = "i2c0";
1499218c80c99a Neil Armstrong      2019-07-29   426  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   427  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   428  						};
1499218c80c99a Neil Armstrong      2019-07-29   429  					};
1499218c80c99a Neil Armstrong      2019-07-29   430  
1499218c80c99a Neil Armstrong      2019-07-29   431  					i2c0_sda_z8_pins: i2c0-sda-z8 {
1499218c80c99a Neil Armstrong      2019-07-29   432  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   433  							groups = "i2c0_sda_z8";
1499218c80c99a Neil Armstrong      2019-07-29   434  							function = "i2c0";
1499218c80c99a Neil Armstrong      2019-07-29   435  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   436  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   437  						};
1499218c80c99a Neil Armstrong      2019-07-29   438  					};
1499218c80c99a Neil Armstrong      2019-07-29   439  
1499218c80c99a Neil Armstrong      2019-07-29   440  					i2c1_sda_x_pins: i2c1-sda-x {
1499218c80c99a Neil Armstrong      2019-07-29   441  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   442  							groups = "i2c1_sda_x";
1499218c80c99a Neil Armstrong      2019-07-29   443  							function = "i2c1";
1499218c80c99a Neil Armstrong      2019-07-29   444  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   445  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   446  						};
1499218c80c99a Neil Armstrong      2019-07-29   447  					};
1499218c80c99a Neil Armstrong      2019-07-29   448  
1499218c80c99a Neil Armstrong      2019-07-29   449  					i2c1_sck_x_pins: i2c1-sck-x {
1499218c80c99a Neil Armstrong      2019-07-29   450  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   451  							groups = "i2c1_sck_x";
1499218c80c99a Neil Armstrong      2019-07-29   452  							function = "i2c1";
1499218c80c99a Neil Armstrong      2019-07-29   453  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   454  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   455  						};
1499218c80c99a Neil Armstrong      2019-07-29   456  					};
1499218c80c99a Neil Armstrong      2019-07-29   457  
1499218c80c99a Neil Armstrong      2019-07-29   458  					i2c1_sda_h2_pins: i2c1-sda-h2 {
1499218c80c99a Neil Armstrong      2019-07-29   459  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   460  							groups = "i2c1_sda_h2";
1499218c80c99a Neil Armstrong      2019-07-29   461  							function = "i2c1";
1499218c80c99a Neil Armstrong      2019-07-29   462  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   463  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   464  						};
1499218c80c99a Neil Armstrong      2019-07-29   465  					};
1499218c80c99a Neil Armstrong      2019-07-29   466  
1499218c80c99a Neil Armstrong      2019-07-29   467  					i2c1_sck_h3_pins: i2c1-sck-h3 {
1499218c80c99a Neil Armstrong      2019-07-29   468  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   469  							groups = "i2c1_sck_h3";
1499218c80c99a Neil Armstrong      2019-07-29   470  							function = "i2c1";
1499218c80c99a Neil Armstrong      2019-07-29   471  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   472  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   473  						};
1499218c80c99a Neil Armstrong      2019-07-29   474  					};
1499218c80c99a Neil Armstrong      2019-07-29   475  
1499218c80c99a Neil Armstrong      2019-07-29   476  					i2c1_sda_h6_pins: i2c1-sda-h6 {
1499218c80c99a Neil Armstrong      2019-07-29   477  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   478  							groups = "i2c1_sda_h6";
1499218c80c99a Neil Armstrong      2019-07-29   479  							function = "i2c1";
1499218c80c99a Neil Armstrong      2019-07-29   480  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   481  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   482  						};
1499218c80c99a Neil Armstrong      2019-07-29   483  					};
1499218c80c99a Neil Armstrong      2019-07-29   484  
1499218c80c99a Neil Armstrong      2019-07-29   485  					i2c1_sck_h7_pins: i2c1-sck-h7 {
1499218c80c99a Neil Armstrong      2019-07-29   486  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   487  							groups = "i2c1_sck_h7";
1499218c80c99a Neil Armstrong      2019-07-29   488  							function = "i2c1";
1499218c80c99a Neil Armstrong      2019-07-29   489  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   490  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   491  						};
1499218c80c99a Neil Armstrong      2019-07-29   492  					};
1499218c80c99a Neil Armstrong      2019-07-29   493  
1499218c80c99a Neil Armstrong      2019-07-29   494  					i2c2_sda_x_pins: i2c2-sda-x {
1499218c80c99a Neil Armstrong      2019-07-29   495  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   496  							groups = "i2c2_sda_x";
1499218c80c99a Neil Armstrong      2019-07-29   497  							function = "i2c2";
1499218c80c99a Neil Armstrong      2019-07-29   498  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   499  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   500  						};
1499218c80c99a Neil Armstrong      2019-07-29   501  					};
1499218c80c99a Neil Armstrong      2019-07-29   502  
1499218c80c99a Neil Armstrong      2019-07-29   503  					i2c2_sck_x_pins: i2c2-sck-x {
1499218c80c99a Neil Armstrong      2019-07-29   504  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   505  							groups = "i2c2_sck_x";
1499218c80c99a Neil Armstrong      2019-07-29   506  							function = "i2c2";
1499218c80c99a Neil Armstrong      2019-07-29   507  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   508  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   509  						};
1499218c80c99a Neil Armstrong      2019-07-29   510  					};
1499218c80c99a Neil Armstrong      2019-07-29   511  
1499218c80c99a Neil Armstrong      2019-07-29   512  					i2c2_sda_z_pins: i2c2-sda-z {
1499218c80c99a Neil Armstrong      2019-07-29   513  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   514  							groups = "i2c2_sda_z";
1499218c80c99a Neil Armstrong      2019-07-29   515  							function = "i2c2";
1499218c80c99a Neil Armstrong      2019-07-29   516  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   517  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   518  						};
1499218c80c99a Neil Armstrong      2019-07-29   519  					};
1499218c80c99a Neil Armstrong      2019-07-29   520  
1499218c80c99a Neil Armstrong      2019-07-29   521  					i2c2_sck_z_pins: i2c2-sck-z {
1499218c80c99a Neil Armstrong      2019-07-29   522  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   523  							groups = "i2c2_sck_z";
1499218c80c99a Neil Armstrong      2019-07-29   524  							function = "i2c2";
1499218c80c99a Neil Armstrong      2019-07-29   525  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   526  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   527  						};
1499218c80c99a Neil Armstrong      2019-07-29   528  					};
1499218c80c99a Neil Armstrong      2019-07-29   529  
1499218c80c99a Neil Armstrong      2019-07-29   530  					i2c3_sda_h_pins: i2c3-sda-h {
1499218c80c99a Neil Armstrong      2019-07-29   531  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   532  							groups = "i2c3_sda_h";
1499218c80c99a Neil Armstrong      2019-07-29   533  							function = "i2c3";
1499218c80c99a Neil Armstrong      2019-07-29   534  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   535  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   536  						};
1499218c80c99a Neil Armstrong      2019-07-29   537  					};
1499218c80c99a Neil Armstrong      2019-07-29   538  
1499218c80c99a Neil Armstrong      2019-07-29   539  					i2c3_sck_h_pins: i2c3-sck-h {
1499218c80c99a Neil Armstrong      2019-07-29   540  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   541  							groups = "i2c3_sck_h";
1499218c80c99a Neil Armstrong      2019-07-29   542  							function = "i2c3";
1499218c80c99a Neil Armstrong      2019-07-29   543  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   544  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   545  						};
1499218c80c99a Neil Armstrong      2019-07-29   546  					};
1499218c80c99a Neil Armstrong      2019-07-29   547  
1499218c80c99a Neil Armstrong      2019-07-29   548  					i2c3_sda_a_pins: i2c3-sda-a {
1499218c80c99a Neil Armstrong      2019-07-29   549  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   550  							groups = "i2c3_sda_a";
1499218c80c99a Neil Armstrong      2019-07-29   551  							function = "i2c3";
1499218c80c99a Neil Armstrong      2019-07-29   552  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   553  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   554  						};
1499218c80c99a Neil Armstrong      2019-07-29   555  					};
1499218c80c99a Neil Armstrong      2019-07-29   556  
1499218c80c99a Neil Armstrong      2019-07-29   557  					i2c3_sck_a_pins: i2c3-sck-a {
1499218c80c99a Neil Armstrong      2019-07-29   558  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   559  							groups = "i2c3_sck_a";
1499218c80c99a Neil Armstrong      2019-07-29   560  							function = "i2c3";
1499218c80c99a Neil Armstrong      2019-07-29   561  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   562  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   563  						};
1499218c80c99a Neil Armstrong      2019-07-29   564  					};
1499218c80c99a Neil Armstrong      2019-07-29   565  
1499218c80c99a Neil Armstrong      2019-07-29   566  					mclk0_a_pins: mclk0-a {
1499218c80c99a Neil Armstrong      2019-07-29   567  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   568  							groups = "mclk0_a";
1499218c80c99a Neil Armstrong      2019-07-29   569  							function = "mclk0";
1499218c80c99a Neil Armstrong      2019-07-29   570  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   571  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   572  						};
1499218c80c99a Neil Armstrong      2019-07-29   573  					};
1499218c80c99a Neil Armstrong      2019-07-29   574  
1499218c80c99a Neil Armstrong      2019-07-29   575  					mclk1_a_pins: mclk1-a {
1499218c80c99a Neil Armstrong      2019-07-29   576  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   577  							groups = "mclk1_a";
1499218c80c99a Neil Armstrong      2019-07-29   578  							function = "mclk1";
1499218c80c99a Neil Armstrong      2019-07-29   579  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   580  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   581  						};
1499218c80c99a Neil Armstrong      2019-07-29   582  					};
1499218c80c99a Neil Armstrong      2019-07-29   583  
1499218c80c99a Neil Armstrong      2019-07-29   584  					mclk1_x_pins: mclk1-x {
1499218c80c99a Neil Armstrong      2019-07-29   585  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   586  							groups = "mclk1_x";
1499218c80c99a Neil Armstrong      2019-07-29   587  							function = "mclk1";
1499218c80c99a Neil Armstrong      2019-07-29   588  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   589  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   590  						};
1499218c80c99a Neil Armstrong      2019-07-29   591  					};
1499218c80c99a Neil Armstrong      2019-07-29   592  
1499218c80c99a Neil Armstrong      2019-07-29   593  					mclk1_z_pins: mclk1-z {
1499218c80c99a Neil Armstrong      2019-07-29   594  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   595  							groups = "mclk1_z";
1499218c80c99a Neil Armstrong      2019-07-29   596  							function = "mclk1";
1499218c80c99a Neil Armstrong      2019-07-29   597  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   598  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29   599  						};
1499218c80c99a Neil Armstrong      2019-07-29   600  					};
1499218c80c99a Neil Armstrong      2019-07-29   601  
f12a463d2f43b9 Neil Armstrong      2020-03-13   602  					nor_pins: nor {
f12a463d2f43b9 Neil Armstrong      2020-03-13   603  						mux {
f12a463d2f43b9 Neil Armstrong      2020-03-13   604  							groups = "nor_d",
f12a463d2f43b9 Neil Armstrong      2020-03-13   605  							       "nor_q",
f12a463d2f43b9 Neil Armstrong      2020-03-13   606  							       "nor_c",
f12a463d2f43b9 Neil Armstrong      2020-03-13   607  							       "nor_cs";
f12a463d2f43b9 Neil Armstrong      2020-03-13   608  							function = "nor";
f12a463d2f43b9 Neil Armstrong      2020-03-13   609  							bias-disable;
f12a463d2f43b9 Neil Armstrong      2020-03-13   610  						};
f12a463d2f43b9 Neil Armstrong      2020-03-13   611  					};
f12a463d2f43b9 Neil Armstrong      2020-03-13   612  
1499218c80c99a Neil Armstrong      2019-07-29   613  					pdm_din0_a_pins: pdm-din0-a {
1499218c80c99a Neil Armstrong      2019-07-29   614  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   615  							groups = "pdm_din0_a";
1499218c80c99a Neil Armstrong      2019-07-29   616  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   617  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   618  						};
1499218c80c99a Neil Armstrong      2019-07-29   619  					};
1499218c80c99a Neil Armstrong      2019-07-29   620  
1499218c80c99a Neil Armstrong      2019-07-29   621  					pdm_din0_c_pins: pdm-din0-c {
1499218c80c99a Neil Armstrong      2019-07-29   622  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   623  							groups = "pdm_din0_c";
1499218c80c99a Neil Armstrong      2019-07-29   624  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   625  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   626  						};
1499218c80c99a Neil Armstrong      2019-07-29   627  					};
1499218c80c99a Neil Armstrong      2019-07-29   628  
1499218c80c99a Neil Armstrong      2019-07-29   629  					pdm_din0_x_pins: pdm-din0-x {
1499218c80c99a Neil Armstrong      2019-07-29   630  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   631  							groups = "pdm_din0_x";
1499218c80c99a Neil Armstrong      2019-07-29   632  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   633  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   634  						};
1499218c80c99a Neil Armstrong      2019-07-29   635  					};
1499218c80c99a Neil Armstrong      2019-07-29   636  
1499218c80c99a Neil Armstrong      2019-07-29   637  					pdm_din0_z_pins: pdm-din0-z {
1499218c80c99a Neil Armstrong      2019-07-29   638  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   639  							groups = "pdm_din0_z";
1499218c80c99a Neil Armstrong      2019-07-29   640  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   641  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   642  						};
1499218c80c99a Neil Armstrong      2019-07-29   643  					};
1499218c80c99a Neil Armstrong      2019-07-29   644  
1499218c80c99a Neil Armstrong      2019-07-29   645  					pdm_din1_a_pins: pdm-din1-a {
1499218c80c99a Neil Armstrong      2019-07-29   646  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   647  							groups = "pdm_din1_a";
1499218c80c99a Neil Armstrong      2019-07-29   648  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   649  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   650  						};
1499218c80c99a Neil Armstrong      2019-07-29   651  					};
1499218c80c99a Neil Armstrong      2019-07-29   652  
1499218c80c99a Neil Armstrong      2019-07-29   653  					pdm_din1_c_pins: pdm-din1-c {
1499218c80c99a Neil Armstrong      2019-07-29   654  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   655  							groups = "pdm_din1_c";
1499218c80c99a Neil Armstrong      2019-07-29   656  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   657  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   658  						};
1499218c80c99a Neil Armstrong      2019-07-29   659  					};
1499218c80c99a Neil Armstrong      2019-07-29   660  
1499218c80c99a Neil Armstrong      2019-07-29   661  					pdm_din1_x_pins: pdm-din1-x {
1499218c80c99a Neil Armstrong      2019-07-29   662  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   663  							groups = "pdm_din1_x";
1499218c80c99a Neil Armstrong      2019-07-29   664  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   665  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   666  						};
1499218c80c99a Neil Armstrong      2019-07-29   667  					};
1499218c80c99a Neil Armstrong      2019-07-29   668  
1499218c80c99a Neil Armstrong      2019-07-29   669  					pdm_din1_z_pins: pdm-din1-z {
1499218c80c99a Neil Armstrong      2019-07-29   670  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   671  							groups = "pdm_din1_z";
1499218c80c99a Neil Armstrong      2019-07-29   672  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   673  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   674  						};
1499218c80c99a Neil Armstrong      2019-07-29   675  					};
1499218c80c99a Neil Armstrong      2019-07-29   676  
1499218c80c99a Neil Armstrong      2019-07-29   677  					pdm_din2_a_pins: pdm-din2-a {
1499218c80c99a Neil Armstrong      2019-07-29   678  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   679  							groups = "pdm_din2_a";
1499218c80c99a Neil Armstrong      2019-07-29   680  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   681  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   682  						};
1499218c80c99a Neil Armstrong      2019-07-29   683  					};
1499218c80c99a Neil Armstrong      2019-07-29   684  
1499218c80c99a Neil Armstrong      2019-07-29   685  					pdm_din2_c_pins: pdm-din2-c {
1499218c80c99a Neil Armstrong      2019-07-29   686  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   687  							groups = "pdm_din2_c";
1499218c80c99a Neil Armstrong      2019-07-29   688  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   689  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   690  						};
1499218c80c99a Neil Armstrong      2019-07-29   691  					};
1499218c80c99a Neil Armstrong      2019-07-29   692  
1499218c80c99a Neil Armstrong      2019-07-29   693  					pdm_din2_x_pins: pdm-din2-x {
1499218c80c99a Neil Armstrong      2019-07-29   694  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   695  							groups = "pdm_din2_x";
1499218c80c99a Neil Armstrong      2019-07-29   696  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   697  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   698  						};
1499218c80c99a Neil Armstrong      2019-07-29   699  					};
1499218c80c99a Neil Armstrong      2019-07-29   700  
1499218c80c99a Neil Armstrong      2019-07-29   701  					pdm_din2_z_pins: pdm-din2-z {
1499218c80c99a Neil Armstrong      2019-07-29   702  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   703  							groups = "pdm_din2_z";
1499218c80c99a Neil Armstrong      2019-07-29   704  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   705  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   706  						};
1499218c80c99a Neil Armstrong      2019-07-29   707  					};
1499218c80c99a Neil Armstrong      2019-07-29   708  
1499218c80c99a Neil Armstrong      2019-07-29   709  					pdm_din3_a_pins: pdm-din3-a {
1499218c80c99a Neil Armstrong      2019-07-29   710  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   711  							groups = "pdm_din3_a";
1499218c80c99a Neil Armstrong      2019-07-29   712  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   713  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   714  						};
1499218c80c99a Neil Armstrong      2019-07-29   715  					};
1499218c80c99a Neil Armstrong      2019-07-29   716  
1499218c80c99a Neil Armstrong      2019-07-29   717  					pdm_din3_c_pins: pdm-din3-c {
1499218c80c99a Neil Armstrong      2019-07-29   718  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   719  							groups = "pdm_din3_c";
1499218c80c99a Neil Armstrong      2019-07-29   720  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   721  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   722  						};
1499218c80c99a Neil Armstrong      2019-07-29   723  					};
1499218c80c99a Neil Armstrong      2019-07-29   724  
1499218c80c99a Neil Armstrong      2019-07-29   725  					pdm_din3_x_pins: pdm-din3-x {
1499218c80c99a Neil Armstrong      2019-07-29   726  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   727  							groups = "pdm_din3_x";
1499218c80c99a Neil Armstrong      2019-07-29   728  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   729  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   730  						};
1499218c80c99a Neil Armstrong      2019-07-29   731  					};
1499218c80c99a Neil Armstrong      2019-07-29   732  
1499218c80c99a Neil Armstrong      2019-07-29   733  					pdm_din3_z_pins: pdm-din3-z {
1499218c80c99a Neil Armstrong      2019-07-29   734  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   735  							groups = "pdm_din3_z";
1499218c80c99a Neil Armstrong      2019-07-29   736  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   737  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   738  						};
1499218c80c99a Neil Armstrong      2019-07-29   739  					};
1499218c80c99a Neil Armstrong      2019-07-29   740  
1499218c80c99a Neil Armstrong      2019-07-29   741  					pdm_dclk_a_pins: pdm-dclk-a {
1499218c80c99a Neil Armstrong      2019-07-29   742  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   743  							groups = "pdm_dclk_a";
1499218c80c99a Neil Armstrong      2019-07-29   744  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   745  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   746  							drive-strength-microamp = <500>;
1499218c80c99a Neil Armstrong      2019-07-29   747  						};
1499218c80c99a Neil Armstrong      2019-07-29   748  					};
1499218c80c99a Neil Armstrong      2019-07-29   749  
1499218c80c99a Neil Armstrong      2019-07-29   750  					pdm_dclk_c_pins: pdm-dclk-c {
1499218c80c99a Neil Armstrong      2019-07-29   751  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   752  							groups = "pdm_dclk_c";
1499218c80c99a Neil Armstrong      2019-07-29   753  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   754  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   755  							drive-strength-microamp = <500>;
1499218c80c99a Neil Armstrong      2019-07-29   756  						};
1499218c80c99a Neil Armstrong      2019-07-29   757  					};
1499218c80c99a Neil Armstrong      2019-07-29   758  
1499218c80c99a Neil Armstrong      2019-07-29   759  					pdm_dclk_x_pins: pdm-dclk-x {
1499218c80c99a Neil Armstrong      2019-07-29   760  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   761  							groups = "pdm_dclk_x";
1499218c80c99a Neil Armstrong      2019-07-29   762  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   763  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   764  							drive-strength-microamp = <500>;
1499218c80c99a Neil Armstrong      2019-07-29   765  						};
1499218c80c99a Neil Armstrong      2019-07-29   766  					};
1499218c80c99a Neil Armstrong      2019-07-29   767  
1499218c80c99a Neil Armstrong      2019-07-29   768  					pdm_dclk_z_pins: pdm-dclk-z {
1499218c80c99a Neil Armstrong      2019-07-29   769  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   770  							groups = "pdm_dclk_z";
1499218c80c99a Neil Armstrong      2019-07-29   771  							function = "pdm";
1499218c80c99a Neil Armstrong      2019-07-29   772  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   773  							drive-strength-microamp = <500>;
1499218c80c99a Neil Armstrong      2019-07-29   774  						};
1499218c80c99a Neil Armstrong      2019-07-29   775  					};
1499218c80c99a Neil Armstrong      2019-07-29   776  
1499218c80c99a Neil Armstrong      2019-07-29   777  					pwm_a_pins: pwm-a {
1499218c80c99a Neil Armstrong      2019-07-29   778  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   779  							groups = "pwm_a";
1499218c80c99a Neil Armstrong      2019-07-29   780  							function = "pwm_a";
1499218c80c99a Neil Armstrong      2019-07-29   781  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   782  						};
1499218c80c99a Neil Armstrong      2019-07-29   783  					};
1499218c80c99a Neil Armstrong      2019-07-29   784  
1499218c80c99a Neil Armstrong      2019-07-29   785  					pwm_b_x7_pins: pwm-b-x7 {
1499218c80c99a Neil Armstrong      2019-07-29   786  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   787  							groups = "pwm_b_x7";
1499218c80c99a Neil Armstrong      2019-07-29   788  							function = "pwm_b";
1499218c80c99a Neil Armstrong      2019-07-29   789  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   790  						};
1499218c80c99a Neil Armstrong      2019-07-29   791  					};
1499218c80c99a Neil Armstrong      2019-07-29   792  
1499218c80c99a Neil Armstrong      2019-07-29   793  					pwm_b_x19_pins: pwm-b-x19 {
1499218c80c99a Neil Armstrong      2019-07-29   794  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   795  							groups = "pwm_b_x19";
1499218c80c99a Neil Armstrong      2019-07-29   796  							function = "pwm_b";
1499218c80c99a Neil Armstrong      2019-07-29   797  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   798  						};
1499218c80c99a Neil Armstrong      2019-07-29   799  					};
1499218c80c99a Neil Armstrong      2019-07-29   800  
1499218c80c99a Neil Armstrong      2019-07-29   801  					pwm_c_c_pins: pwm-c-c {
1499218c80c99a Neil Armstrong      2019-07-29   802  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   803  							groups = "pwm_c_c";
1499218c80c99a Neil Armstrong      2019-07-29   804  							function = "pwm_c";
1499218c80c99a Neil Armstrong      2019-07-29   805  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   806  						};
1499218c80c99a Neil Armstrong      2019-07-29   807  					};
1499218c80c99a Neil Armstrong      2019-07-29   808  
1499218c80c99a Neil Armstrong      2019-07-29   809  					pwm_c_x5_pins: pwm-c-x5 {
1499218c80c99a Neil Armstrong      2019-07-29   810  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   811  							groups = "pwm_c_x5";
1499218c80c99a Neil Armstrong      2019-07-29   812  							function = "pwm_c";
1499218c80c99a Neil Armstrong      2019-07-29   813  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   814  						};
1499218c80c99a Neil Armstrong      2019-07-29   815  					};
1499218c80c99a Neil Armstrong      2019-07-29   816  
1499218c80c99a Neil Armstrong      2019-07-29   817  					pwm_c_x8_pins: pwm-c-x8 {
1499218c80c99a Neil Armstrong      2019-07-29   818  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   819  							groups = "pwm_c_x8";
1499218c80c99a Neil Armstrong      2019-07-29   820  							function = "pwm_c";
1499218c80c99a Neil Armstrong      2019-07-29   821  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   822  						};
1499218c80c99a Neil Armstrong      2019-07-29   823  					};
1499218c80c99a Neil Armstrong      2019-07-29   824  
1499218c80c99a Neil Armstrong      2019-07-29   825  					pwm_d_x3_pins: pwm-d-x3 {
1499218c80c99a Neil Armstrong      2019-07-29   826  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   827  							groups = "pwm_d_x3";
1499218c80c99a Neil Armstrong      2019-07-29   828  							function = "pwm_d";
1499218c80c99a Neil Armstrong      2019-07-29   829  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   830  						};
1499218c80c99a Neil Armstrong      2019-07-29   831  					};
1499218c80c99a Neil Armstrong      2019-07-29   832  
1499218c80c99a Neil Armstrong      2019-07-29   833  					pwm_d_x6_pins: pwm-d-x6 {
1499218c80c99a Neil Armstrong      2019-07-29   834  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   835  							groups = "pwm_d_x6";
1499218c80c99a Neil Armstrong      2019-07-29   836  							function = "pwm_d";
1499218c80c99a Neil Armstrong      2019-07-29   837  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   838  						};
1499218c80c99a Neil Armstrong      2019-07-29   839  					};
1499218c80c99a Neil Armstrong      2019-07-29   840  
1499218c80c99a Neil Armstrong      2019-07-29   841  					pwm_e_pins: pwm-e {
1499218c80c99a Neil Armstrong      2019-07-29   842  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   843  							groups = "pwm_e";
1499218c80c99a Neil Armstrong      2019-07-29   844  							function = "pwm_e";
1499218c80c99a Neil Armstrong      2019-07-29   845  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   846  						};
1499218c80c99a Neil Armstrong      2019-07-29   847  					};
1499218c80c99a Neil Armstrong      2019-07-29   848  
07398323330264 Gary Bisson         2022-01-12   849  					pwm_f_z_pins: pwm-f-z {
07398323330264 Gary Bisson         2022-01-12   850  						mux {
07398323330264 Gary Bisson         2022-01-12   851  							groups = "pwm_f_z";
07398323330264 Gary Bisson         2022-01-12   852  							function = "pwm_f";
07398323330264 Gary Bisson         2022-01-12   853  							bias-disable;
07398323330264 Gary Bisson         2022-01-12   854  						};
07398323330264 Gary Bisson         2022-01-12   855  					};
07398323330264 Gary Bisson         2022-01-12   856  
07398323330264 Gary Bisson         2022-01-12   857  					pwm_f_a_pins: pwm-f-a {
07398323330264 Gary Bisson         2022-01-12   858  						mux {
07398323330264 Gary Bisson         2022-01-12   859  							groups = "pwm_f_a";
07398323330264 Gary Bisson         2022-01-12   860  							function = "pwm_f";
07398323330264 Gary Bisson         2022-01-12   861  							bias-disable;
07398323330264 Gary Bisson         2022-01-12   862  						};
07398323330264 Gary Bisson         2022-01-12   863  					};
07398323330264 Gary Bisson         2022-01-12   864  
1499218c80c99a Neil Armstrong      2019-07-29   865  					pwm_f_x_pins: pwm-f-x {
1499218c80c99a Neil Armstrong      2019-07-29   866  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   867  							groups = "pwm_f_x";
1499218c80c99a Neil Armstrong      2019-07-29   868  							function = "pwm_f";
1499218c80c99a Neil Armstrong      2019-07-29   869  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   870  						};
1499218c80c99a Neil Armstrong      2019-07-29   871  					};
1499218c80c99a Neil Armstrong      2019-07-29   872  
1499218c80c99a Neil Armstrong      2019-07-29   873  					pwm_f_h_pins: pwm-f-h {
1499218c80c99a Neil Armstrong      2019-07-29   874  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   875  							groups = "pwm_f_h";
1499218c80c99a Neil Armstrong      2019-07-29   876  							function = "pwm_f";
1499218c80c99a Neil Armstrong      2019-07-29   877  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   878  						};
1499218c80c99a Neil Armstrong      2019-07-29   879  					};
1499218c80c99a Neil Armstrong      2019-07-29   880  
1499218c80c99a Neil Armstrong      2019-07-29   881  					sdcard_c_pins: sdcard_c {
1499218c80c99a Neil Armstrong      2019-07-29   882  						mux-0 {
1499218c80c99a Neil Armstrong      2019-07-29   883  							groups = "sdcard_d0_c",
1499218c80c99a Neil Armstrong      2019-07-29   884  								 "sdcard_d1_c",
1499218c80c99a Neil Armstrong      2019-07-29   885  								 "sdcard_d2_c",
1499218c80c99a Neil Armstrong      2019-07-29   886  								 "sdcard_d3_c",
1499218c80c99a Neil Armstrong      2019-07-29   887  								 "sdcard_cmd_c";
1499218c80c99a Neil Armstrong      2019-07-29   888  							function = "sdcard";
1499218c80c99a Neil Armstrong      2019-07-29   889  							bias-pull-up;
1499218c80c99a Neil Armstrong      2019-07-29   890  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   891  						};
1499218c80c99a Neil Armstrong      2019-07-29   892  
1499218c80c99a Neil Armstrong      2019-07-29   893  						mux-1 {
1499218c80c99a Neil Armstrong      2019-07-29   894  							groups = "sdcard_clk_c";
1499218c80c99a Neil Armstrong      2019-07-29   895  							function = "sdcard";
1499218c80c99a Neil Armstrong      2019-07-29   896  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   897  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   898  						};
1499218c80c99a Neil Armstrong      2019-07-29   899  					};
1499218c80c99a Neil Armstrong      2019-07-29   900  
1499218c80c99a Neil Armstrong      2019-07-29   901  					sdcard_clk_gate_c_pins: sdcard_clk_gate_c {
1499218c80c99a Neil Armstrong      2019-07-29   902  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   903  							groups = "GPIOC_4";
1499218c80c99a Neil Armstrong      2019-07-29   904  							function = "gpio_periphs";
1499218c80c99a Neil Armstrong      2019-07-29   905  							bias-pull-down;
1499218c80c99a Neil Armstrong      2019-07-29   906  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   907  						};
1499218c80c99a Neil Armstrong      2019-07-29   908  					};
1499218c80c99a Neil Armstrong      2019-07-29   909  
1499218c80c99a Neil Armstrong      2019-07-29   910  					sdcard_z_pins: sdcard_z {
1499218c80c99a Neil Armstrong      2019-07-29   911  						mux-0 {
1499218c80c99a Neil Armstrong      2019-07-29   912  							groups = "sdcard_d0_z",
1499218c80c99a Neil Armstrong      2019-07-29   913  								 "sdcard_d1_z",
1499218c80c99a Neil Armstrong      2019-07-29   914  								 "sdcard_d2_z",
1499218c80c99a Neil Armstrong      2019-07-29   915  								 "sdcard_d3_z",
1499218c80c99a Neil Armstrong      2019-07-29   916  								 "sdcard_cmd_z";
1499218c80c99a Neil Armstrong      2019-07-29   917  							function = "sdcard";
1499218c80c99a Neil Armstrong      2019-07-29   918  							bias-pull-up;
1499218c80c99a Neil Armstrong      2019-07-29   919  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   920  						};
1499218c80c99a Neil Armstrong      2019-07-29   921  
1499218c80c99a Neil Armstrong      2019-07-29   922  						mux-1 {
1499218c80c99a Neil Armstrong      2019-07-29   923  							groups = "sdcard_clk_z";
1499218c80c99a Neil Armstrong      2019-07-29   924  							function = "sdcard";
1499218c80c99a Neil Armstrong      2019-07-29   925  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   926  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   927  						};
1499218c80c99a Neil Armstrong      2019-07-29   928  					};
1499218c80c99a Neil Armstrong      2019-07-29   929  
1499218c80c99a Neil Armstrong      2019-07-29   930  					sdcard_clk_gate_z_pins: sdcard_clk_gate_z {
1499218c80c99a Neil Armstrong      2019-07-29   931  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   932  							groups = "GPIOZ_6";
1499218c80c99a Neil Armstrong      2019-07-29   933  							function = "gpio_periphs";
1499218c80c99a Neil Armstrong      2019-07-29   934  							bias-pull-down;
1499218c80c99a Neil Armstrong      2019-07-29   935  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   936  						};
1499218c80c99a Neil Armstrong      2019-07-29   937  					};
1499218c80c99a Neil Armstrong      2019-07-29   938  
1499218c80c99a Neil Armstrong      2019-07-29   939  					sdio_pins: sdio {
1499218c80c99a Neil Armstrong      2019-07-29   940  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   941  							groups = "sdio_d0",
1499218c80c99a Neil Armstrong      2019-07-29   942  								 "sdio_d1",
1499218c80c99a Neil Armstrong      2019-07-29   943  								 "sdio_d2",
1499218c80c99a Neil Armstrong      2019-07-29   944  								 "sdio_d3",
1499218c80c99a Neil Armstrong      2019-07-29   945  								 "sdio_clk",
1499218c80c99a Neil Armstrong      2019-07-29   946  								 "sdio_cmd";
1499218c80c99a Neil Armstrong      2019-07-29   947  							function = "sdio";
1499218c80c99a Neil Armstrong      2019-07-29   948  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   949  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   950  						};
1499218c80c99a Neil Armstrong      2019-07-29   951  					};
1499218c80c99a Neil Armstrong      2019-07-29   952  
1499218c80c99a Neil Armstrong      2019-07-29   953  					sdio_clk_gate_pins: sdio_clk_gate {
1499218c80c99a Neil Armstrong      2019-07-29   954  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   955  							groups = "GPIOX_4";
1499218c80c99a Neil Armstrong      2019-07-29   956  							function = "gpio_periphs";
1499218c80c99a Neil Armstrong      2019-07-29   957  							bias-pull-down;
1499218c80c99a Neil Armstrong      2019-07-29   958  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29   959  						};
1499218c80c99a Neil Armstrong      2019-07-29   960  					};
1499218c80c99a Neil Armstrong      2019-07-29   961  
1499218c80c99a Neil Armstrong      2019-07-29   962  					spdif_in_a10_pins: spdif-in-a10 {
1499218c80c99a Neil Armstrong      2019-07-29   963  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   964  							groups = "spdif_in_a10";
1499218c80c99a Neil Armstrong      2019-07-29   965  							function = "spdif_in";
1499218c80c99a Neil Armstrong      2019-07-29   966  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   967  						};
1499218c80c99a Neil Armstrong      2019-07-29   968  					};
1499218c80c99a Neil Armstrong      2019-07-29   969  
1499218c80c99a Neil Armstrong      2019-07-29   970  					spdif_in_a12_pins: spdif-in-a12 {
1499218c80c99a Neil Armstrong      2019-07-29   971  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   972  							groups = "spdif_in_a12";
1499218c80c99a Neil Armstrong      2019-07-29   973  							function = "spdif_in";
1499218c80c99a Neil Armstrong      2019-07-29   974  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   975  						};
1499218c80c99a Neil Armstrong      2019-07-29   976  					};
1499218c80c99a Neil Armstrong      2019-07-29   977  
1499218c80c99a Neil Armstrong      2019-07-29   978  					spdif_in_h_pins: spdif-in-h {
1499218c80c99a Neil Armstrong      2019-07-29   979  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   980  							groups = "spdif_in_h";
1499218c80c99a Neil Armstrong      2019-07-29   981  							function = "spdif_in";
1499218c80c99a Neil Armstrong      2019-07-29   982  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   983  						};
1499218c80c99a Neil Armstrong      2019-07-29   984  					};
1499218c80c99a Neil Armstrong      2019-07-29   985  
1499218c80c99a Neil Armstrong      2019-07-29   986  					spdif_out_h_pins: spdif-out-h {
1499218c80c99a Neil Armstrong      2019-07-29   987  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   988  							groups = "spdif_out_h";
1499218c80c99a Neil Armstrong      2019-07-29   989  							function = "spdif_out";
1499218c80c99a Neil Armstrong      2019-07-29   990  							drive-strength-microamp = <500>;
1499218c80c99a Neil Armstrong      2019-07-29   991  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29   992  						};
1499218c80c99a Neil Armstrong      2019-07-29   993  					};
1499218c80c99a Neil Armstrong      2019-07-29   994  
1499218c80c99a Neil Armstrong      2019-07-29   995  					spdif_out_a11_pins: spdif-out-a11 {
1499218c80c99a Neil Armstrong      2019-07-29   996  						mux {
1499218c80c99a Neil Armstrong      2019-07-29   997  							groups = "spdif_out_a11";
1499218c80c99a Neil Armstrong      2019-07-29   998  							function = "spdif_out";
1499218c80c99a Neil Armstrong      2019-07-29   999  							drive-strength-microamp = <500>;
1499218c80c99a Neil Armstrong      2019-07-29  1000  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1001  						};
1499218c80c99a Neil Armstrong      2019-07-29  1002  					};
1499218c80c99a Neil Armstrong      2019-07-29  1003  
1499218c80c99a Neil Armstrong      2019-07-29  1004  					spdif_out_a13_pins: spdif-out-a13 {
1499218c80c99a Neil Armstrong      2019-07-29  1005  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1006  							groups = "spdif_out_a13";
1499218c80c99a Neil Armstrong      2019-07-29  1007  							function = "spdif_out";
1499218c80c99a Neil Armstrong      2019-07-29  1008  							drive-strength-microamp = <500>;
1499218c80c99a Neil Armstrong      2019-07-29  1009  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1010  						};
1499218c80c99a Neil Armstrong      2019-07-29  1011  					};
1499218c80c99a Neil Armstrong      2019-07-29  1012  
5fa86f4f72e049 Neil Armstrong      2020-03-13  1013  					spicc0_x_pins: spicc0-x {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1014  						mux {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1015  							groups = "spi0_mosi_x",
5fa86f4f72e049 Neil Armstrong      2020-03-13  1016  							       "spi0_miso_x",
5fa86f4f72e049 Neil Armstrong      2020-03-13  1017  							       "spi0_clk_x";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1018  							function = "spi0";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1019  							drive-strength-microamp = <4000>;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1020  							bias-disable;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1021  						};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1022  					};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1023  
5fa86f4f72e049 Neil Armstrong      2020-03-13  1024  					spicc0_ss0_x_pins: spicc0-ss0-x {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1025  						mux {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1026  							groups = "spi0_ss0_x";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1027  							function = "spi0";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1028  							drive-strength-microamp = <4000>;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1029  							bias-disable;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1030  						};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1031  					};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1032  
5fa86f4f72e049 Neil Armstrong      2020-03-13  1033  					spicc0_c_pins: spicc0-c {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1034  						mux {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1035  							groups = "spi0_mosi_c",
5fa86f4f72e049 Neil Armstrong      2020-03-13  1036  							       "spi0_miso_c",
5fa86f4f72e049 Neil Armstrong      2020-03-13  1037  							       "spi0_ss0_c",
5fa86f4f72e049 Neil Armstrong      2020-03-13  1038  							       "spi0_clk_c";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1039  							function = "spi0";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1040  							drive-strength-microamp = <4000>;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1041  							bias-disable;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1042  						};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1043  					};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1044  
5fa86f4f72e049 Neil Armstrong      2020-03-13  1045  					spicc1_pins: spicc1 {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1046  						mux {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1047  							groups = "spi1_mosi",
5fa86f4f72e049 Neil Armstrong      2020-03-13  1048  							       "spi1_miso",
5fa86f4f72e049 Neil Armstrong      2020-03-13  1049  							       "spi1_clk";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1050  							function = "spi1";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1051  							drive-strength-microamp = <4000>;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1052  						};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1053  					};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1054  
5fa86f4f72e049 Neil Armstrong      2020-03-13  1055  					spicc1_ss0_pins: spicc1-ss0 {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1056  						mux {
5fa86f4f72e049 Neil Armstrong      2020-03-13  1057  							groups = "spi1_ss0";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1058  							function = "spi1";
5fa86f4f72e049 Neil Armstrong      2020-03-13  1059  							drive-strength-microamp = <4000>;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1060  							bias-disable;
5fa86f4f72e049 Neil Armstrong      2020-03-13  1061  						};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1062  					};
5fa86f4f72e049 Neil Armstrong      2020-03-13  1063  
1499218c80c99a Neil Armstrong      2019-07-29  1064  					tdm_a_din0_pins: tdm-a-din0 {
1499218c80c99a Neil Armstrong      2019-07-29  1065  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1066  							groups = "tdm_a_din0";
1499218c80c99a Neil Armstrong      2019-07-29  1067  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1068  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1069  						};
1499218c80c99a Neil Armstrong      2019-07-29  1070  					};
1499218c80c99a Neil Armstrong      2019-07-29  1071  
1499218c80c99a Neil Armstrong      2019-07-29  1072  
1499218c80c99a Neil Armstrong      2019-07-29  1073  					tdm_a_din1_pins: tdm-a-din1 {
1499218c80c99a Neil Armstrong      2019-07-29  1074  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1075  							groups = "tdm_a_din1";
1499218c80c99a Neil Armstrong      2019-07-29  1076  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1077  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1078  						};
1499218c80c99a Neil Armstrong      2019-07-29  1079  					};
1499218c80c99a Neil Armstrong      2019-07-29  1080  
1499218c80c99a Neil Armstrong      2019-07-29  1081  					tdm_a_dout0_pins: tdm-a-dout0 {
1499218c80c99a Neil Armstrong      2019-07-29  1082  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1083  							groups = "tdm_a_dout0";
1499218c80c99a Neil Armstrong      2019-07-29  1084  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1085  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1086  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1087  						};
1499218c80c99a Neil Armstrong      2019-07-29  1088  					};
1499218c80c99a Neil Armstrong      2019-07-29  1089  
1499218c80c99a Neil Armstrong      2019-07-29  1090  					tdm_a_dout1_pins: tdm-a-dout1 {
1499218c80c99a Neil Armstrong      2019-07-29  1091  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1092  							groups = "tdm_a_dout1";
1499218c80c99a Neil Armstrong      2019-07-29  1093  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1094  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1095  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1096  						};
1499218c80c99a Neil Armstrong      2019-07-29  1097  					};
1499218c80c99a Neil Armstrong      2019-07-29  1098  
1499218c80c99a Neil Armstrong      2019-07-29  1099  					tdm_a_fs_pins: tdm-a-fs {
1499218c80c99a Neil Armstrong      2019-07-29  1100  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1101  							groups = "tdm_a_fs";
1499218c80c99a Neil Armstrong      2019-07-29  1102  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1103  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1104  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1105  						};
1499218c80c99a Neil Armstrong      2019-07-29  1106  					};
1499218c80c99a Neil Armstrong      2019-07-29  1107  
1499218c80c99a Neil Armstrong      2019-07-29  1108  					tdm_a_sclk_pins: tdm-a-sclk {
1499218c80c99a Neil Armstrong      2019-07-29  1109  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1110  							groups = "tdm_a_sclk";
1499218c80c99a Neil Armstrong      2019-07-29  1111  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1112  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1113  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1114  						};
1499218c80c99a Neil Armstrong      2019-07-29  1115  					};
1499218c80c99a Neil Armstrong      2019-07-29  1116  
1499218c80c99a Neil Armstrong      2019-07-29  1117  					tdm_a_slv_fs_pins: tdm-a-slv-fs {
1499218c80c99a Neil Armstrong      2019-07-29  1118  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1119  							groups = "tdm_a_slv_fs";
1499218c80c99a Neil Armstrong      2019-07-29  1120  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1121  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1122  						};
1499218c80c99a Neil Armstrong      2019-07-29  1123  					};
1499218c80c99a Neil Armstrong      2019-07-29  1124  
1499218c80c99a Neil Armstrong      2019-07-29  1125  
1499218c80c99a Neil Armstrong      2019-07-29  1126  					tdm_a_slv_sclk_pins: tdm-a-slv-sclk {
1499218c80c99a Neil Armstrong      2019-07-29  1127  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1128  							groups = "tdm_a_slv_sclk";
1499218c80c99a Neil Armstrong      2019-07-29  1129  							function = "tdm_a";
1499218c80c99a Neil Armstrong      2019-07-29  1130  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1131  						};
1499218c80c99a Neil Armstrong      2019-07-29  1132  					};
1499218c80c99a Neil Armstrong      2019-07-29  1133  
1499218c80c99a Neil Armstrong      2019-07-29  1134  					tdm_b_din0_pins: tdm-b-din0 {
1499218c80c99a Neil Armstrong      2019-07-29  1135  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1136  							groups = "tdm_b_din0";
1499218c80c99a Neil Armstrong      2019-07-29  1137  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1138  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1139  						};
1499218c80c99a Neil Armstrong      2019-07-29  1140  					};
1499218c80c99a Neil Armstrong      2019-07-29  1141  
1499218c80c99a Neil Armstrong      2019-07-29  1142  					tdm_b_din1_pins: tdm-b-din1 {
1499218c80c99a Neil Armstrong      2019-07-29  1143  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1144  							groups = "tdm_b_din1";
1499218c80c99a Neil Armstrong      2019-07-29  1145  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1146  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1147  						};
1499218c80c99a Neil Armstrong      2019-07-29  1148  					};
1499218c80c99a Neil Armstrong      2019-07-29  1149  
1499218c80c99a Neil Armstrong      2019-07-29  1150  					tdm_b_din2_pins: tdm-b-din2 {
1499218c80c99a Neil Armstrong      2019-07-29  1151  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1152  							groups = "tdm_b_din2";
1499218c80c99a Neil Armstrong      2019-07-29  1153  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1154  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1155  						};
1499218c80c99a Neil Armstrong      2019-07-29  1156  					};
1499218c80c99a Neil Armstrong      2019-07-29  1157  
1499218c80c99a Neil Armstrong      2019-07-29  1158  					tdm_b_din3_a_pins: tdm-b-din3-a {
1499218c80c99a Neil Armstrong      2019-07-29  1159  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1160  							groups = "tdm_b_din3_a";
1499218c80c99a Neil Armstrong      2019-07-29  1161  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1162  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1163  						};
1499218c80c99a Neil Armstrong      2019-07-29  1164  					};
1499218c80c99a Neil Armstrong      2019-07-29  1165  
1499218c80c99a Neil Armstrong      2019-07-29  1166  					tdm_b_din3_h_pins: tdm-b-din3-h {
1499218c80c99a Neil Armstrong      2019-07-29  1167  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1168  							groups = "tdm_b_din3_h";
1499218c80c99a Neil Armstrong      2019-07-29  1169  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1170  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1171  						};
1499218c80c99a Neil Armstrong      2019-07-29  1172  					};
1499218c80c99a Neil Armstrong      2019-07-29  1173  
1499218c80c99a Neil Armstrong      2019-07-29  1174  					tdm_b_dout0_pins: tdm-b-dout0 {
1499218c80c99a Neil Armstrong      2019-07-29  1175  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1176  							groups = "tdm_b_dout0";
1499218c80c99a Neil Armstrong      2019-07-29  1177  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1178  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1179  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1180  						};
1499218c80c99a Neil Armstrong      2019-07-29  1181  					};
1499218c80c99a Neil Armstrong      2019-07-29  1182  
1499218c80c99a Neil Armstrong      2019-07-29  1183  					tdm_b_dout1_pins: tdm-b-dout1 {
1499218c80c99a Neil Armstrong      2019-07-29  1184  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1185  							groups = "tdm_b_dout1";
1499218c80c99a Neil Armstrong      2019-07-29  1186  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1187  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1188  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1189  						};
1499218c80c99a Neil Armstrong      2019-07-29  1190  					};
1499218c80c99a Neil Armstrong      2019-07-29  1191  
1499218c80c99a Neil Armstrong      2019-07-29  1192  					tdm_b_dout2_pins: tdm-b-dout2 {
1499218c80c99a Neil Armstrong      2019-07-29  1193  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1194  							groups = "tdm_b_dout2";
1499218c80c99a Neil Armstrong      2019-07-29  1195  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1196  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1197  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1198  						};
1499218c80c99a Neil Armstrong      2019-07-29  1199  					};
1499218c80c99a Neil Armstrong      2019-07-29  1200  
1499218c80c99a Neil Armstrong      2019-07-29  1201  					tdm_b_dout3_a_pins: tdm-b-dout3-a {
1499218c80c99a Neil Armstrong      2019-07-29  1202  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1203  							groups = "tdm_b_dout3_a";
1499218c80c99a Neil Armstrong      2019-07-29  1204  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1205  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1206  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1207  						};
1499218c80c99a Neil Armstrong      2019-07-29  1208  					};
1499218c80c99a Neil Armstrong      2019-07-29  1209  
1499218c80c99a Neil Armstrong      2019-07-29  1210  					tdm_b_dout3_h_pins: tdm-b-dout3-h {
1499218c80c99a Neil Armstrong      2019-07-29  1211  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1212  							groups = "tdm_b_dout3_h";
1499218c80c99a Neil Armstrong      2019-07-29  1213  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1214  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1215  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1216  						};
1499218c80c99a Neil Armstrong      2019-07-29  1217  					};
1499218c80c99a Neil Armstrong      2019-07-29  1218  
1499218c80c99a Neil Armstrong      2019-07-29  1219  					tdm_b_fs_pins: tdm-b-fs {
1499218c80c99a Neil Armstrong      2019-07-29  1220  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1221  							groups = "tdm_b_fs";
1499218c80c99a Neil Armstrong      2019-07-29  1222  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1223  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1224  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1225  						};
1499218c80c99a Neil Armstrong      2019-07-29  1226  					};
1499218c80c99a Neil Armstrong      2019-07-29  1227  
1499218c80c99a Neil Armstrong      2019-07-29  1228  					tdm_b_sclk_pins: tdm-b-sclk {
1499218c80c99a Neil Armstrong      2019-07-29  1229  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1230  							groups = "tdm_b_sclk";
1499218c80c99a Neil Armstrong      2019-07-29  1231  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1232  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1233  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1234  						};
1499218c80c99a Neil Armstrong      2019-07-29  1235  					};
1499218c80c99a Neil Armstrong      2019-07-29  1236  
1499218c80c99a Neil Armstrong      2019-07-29  1237  					tdm_b_slv_fs_pins: tdm-b-slv-fs {
1499218c80c99a Neil Armstrong      2019-07-29  1238  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1239  							groups = "tdm_b_slv_fs";
1499218c80c99a Neil Armstrong      2019-07-29  1240  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1241  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1242  						};
1499218c80c99a Neil Armstrong      2019-07-29  1243  					};
1499218c80c99a Neil Armstrong      2019-07-29  1244  
1499218c80c99a Neil Armstrong      2019-07-29  1245  					tdm_b_slv_sclk_pins: tdm-b-slv-sclk {
1499218c80c99a Neil Armstrong      2019-07-29  1246  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1247  							groups = "tdm_b_slv_sclk";
1499218c80c99a Neil Armstrong      2019-07-29  1248  							function = "tdm_b";
1499218c80c99a Neil Armstrong      2019-07-29  1249  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1250  						};
1499218c80c99a Neil Armstrong      2019-07-29  1251  					};
1499218c80c99a Neil Armstrong      2019-07-29  1252  
1499218c80c99a Neil Armstrong      2019-07-29  1253  					tdm_c_din0_a_pins: tdm-c-din0-a {
1499218c80c99a Neil Armstrong      2019-07-29  1254  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1255  							groups = "tdm_c_din0_a";
1499218c80c99a Neil Armstrong      2019-07-29  1256  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1257  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1258  						};
1499218c80c99a Neil Armstrong      2019-07-29  1259  					};
1499218c80c99a Neil Armstrong      2019-07-29  1260  
1499218c80c99a Neil Armstrong      2019-07-29  1261  					tdm_c_din0_z_pins: tdm-c-din0-z {
1499218c80c99a Neil Armstrong      2019-07-29  1262  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1263  							groups = "tdm_c_din0_z";
1499218c80c99a Neil Armstrong      2019-07-29  1264  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1265  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1266  						};
1499218c80c99a Neil Armstrong      2019-07-29  1267  					};
1499218c80c99a Neil Armstrong      2019-07-29  1268  
1499218c80c99a Neil Armstrong      2019-07-29  1269  					tdm_c_din1_a_pins: tdm-c-din1-a {
1499218c80c99a Neil Armstrong      2019-07-29  1270  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1271  							groups = "tdm_c_din1_a";
1499218c80c99a Neil Armstrong      2019-07-29  1272  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1273  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1274  						};
1499218c80c99a Neil Armstrong      2019-07-29  1275  					};
1499218c80c99a Neil Armstrong      2019-07-29  1276  
1499218c80c99a Neil Armstrong      2019-07-29  1277  					tdm_c_din1_z_pins: tdm-c-din1-z {
1499218c80c99a Neil Armstrong      2019-07-29  1278  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1279  							groups = "tdm_c_din1_z";
1499218c80c99a Neil Armstrong      2019-07-29  1280  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1281  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1282  						};
1499218c80c99a Neil Armstrong      2019-07-29  1283  					};
1499218c80c99a Neil Armstrong      2019-07-29  1284  
1499218c80c99a Neil Armstrong      2019-07-29  1285  					tdm_c_din2_a_pins: tdm-c-din2-a {
1499218c80c99a Neil Armstrong      2019-07-29  1286  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1287  							groups = "tdm_c_din2_a";
1499218c80c99a Neil Armstrong      2019-07-29  1288  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1289  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1290  						};
1499218c80c99a Neil Armstrong      2019-07-29  1291  					};
1499218c80c99a Neil Armstrong      2019-07-29  1292  
1499218c80c99a Neil Armstrong      2019-07-29  1293  					eth_leds_pins: eth-leds {
1499218c80c99a Neil Armstrong      2019-07-29  1294  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1295  							groups = "eth_link_led",
1499218c80c99a Neil Armstrong      2019-07-29  1296  								 "eth_act_led";
1499218c80c99a Neil Armstrong      2019-07-29  1297  							function = "eth";
1499218c80c99a Neil Armstrong      2019-07-29  1298  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1299  						};
1499218c80c99a Neil Armstrong      2019-07-29  1300  					};
1499218c80c99a Neil Armstrong      2019-07-29  1301  
1499218c80c99a Neil Armstrong      2019-07-29  1302  					eth_pins: eth {
1499218c80c99a Neil Armstrong      2019-07-29  1303  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1304  							groups = "eth_mdio",
1499218c80c99a Neil Armstrong      2019-07-29  1305  								 "eth_mdc",
1499218c80c99a Neil Armstrong      2019-07-29  1306  								 "eth_rgmii_rx_clk",
1499218c80c99a Neil Armstrong      2019-07-29  1307  								 "eth_rx_dv",
1499218c80c99a Neil Armstrong      2019-07-29  1308  								 "eth_rxd0",
1499218c80c99a Neil Armstrong      2019-07-29  1309  								 "eth_rxd1",
1499218c80c99a Neil Armstrong      2019-07-29  1310  								 "eth_txen",
1499218c80c99a Neil Armstrong      2019-07-29  1311  								 "eth_txd0",
1499218c80c99a Neil Armstrong      2019-07-29  1312  								 "eth_txd1";
1499218c80c99a Neil Armstrong      2019-07-29  1313  							function = "eth";
1499218c80c99a Neil Armstrong      2019-07-29  1314  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29  1315  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1316  						};
1499218c80c99a Neil Armstrong      2019-07-29  1317  					};
1499218c80c99a Neil Armstrong      2019-07-29  1318  
1499218c80c99a Neil Armstrong      2019-07-29  1319  					eth_rgmii_pins: eth-rgmii {
1499218c80c99a Neil Armstrong      2019-07-29  1320  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1321  							groups = "eth_rxd2_rgmii",
1499218c80c99a Neil Armstrong      2019-07-29  1322  								 "eth_rxd3_rgmii",
1499218c80c99a Neil Armstrong      2019-07-29  1323  								 "eth_rgmii_tx_clk",
1499218c80c99a Neil Armstrong      2019-07-29  1324  								 "eth_txd2_rgmii",
1499218c80c99a Neil Armstrong      2019-07-29  1325  								 "eth_txd3_rgmii";
1499218c80c99a Neil Armstrong      2019-07-29  1326  							function = "eth";
1499218c80c99a Neil Armstrong      2019-07-29  1327  							drive-strength-microamp = <4000>;
1499218c80c99a Neil Armstrong      2019-07-29  1328  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1329  						};
1499218c80c99a Neil Armstrong      2019-07-29  1330  					};
1499218c80c99a Neil Armstrong      2019-07-29  1331  
1499218c80c99a Neil Armstrong      2019-07-29  1332  					tdm_c_din2_z_pins: tdm-c-din2-z {
1499218c80c99a Neil Armstrong      2019-07-29  1333  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1334  							groups = "tdm_c_din2_z";
1499218c80c99a Neil Armstrong      2019-07-29  1335  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1336  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1337  						};
1499218c80c99a Neil Armstrong      2019-07-29  1338  					};
1499218c80c99a Neil Armstrong      2019-07-29  1339  
1499218c80c99a Neil Armstrong      2019-07-29  1340  					tdm_c_din3_a_pins: tdm-c-din3-a {
1499218c80c99a Neil Armstrong      2019-07-29  1341  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1342  							groups = "tdm_c_din3_a";
1499218c80c99a Neil Armstrong      2019-07-29  1343  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1344  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1345  						};
1499218c80c99a Neil Armstrong      2019-07-29  1346  					};
1499218c80c99a Neil Armstrong      2019-07-29  1347  
1499218c80c99a Neil Armstrong      2019-07-29  1348  					tdm_c_din3_z_pins: tdm-c-din3-z {
1499218c80c99a Neil Armstrong      2019-07-29  1349  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1350  							groups = "tdm_c_din3_z";
1499218c80c99a Neil Armstrong      2019-07-29  1351  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1352  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1353  						};
1499218c80c99a Neil Armstrong      2019-07-29  1354  					};
1499218c80c99a Neil Armstrong      2019-07-29  1355  
1499218c80c99a Neil Armstrong      2019-07-29  1356  					tdm_c_dout0_a_pins: tdm-c-dout0-a {
1499218c80c99a Neil Armstrong      2019-07-29  1357  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1358  							groups = "tdm_c_dout0_a";
1499218c80c99a Neil Armstrong      2019-07-29  1359  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1360  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1361  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1362  						};
1499218c80c99a Neil Armstrong      2019-07-29  1363  					};
1499218c80c99a Neil Armstrong      2019-07-29  1364  
1499218c80c99a Neil Armstrong      2019-07-29  1365  					tdm_c_dout0_z_pins: tdm-c-dout0-z {
1499218c80c99a Neil Armstrong      2019-07-29  1366  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1367  							groups = "tdm_c_dout0_z";
1499218c80c99a Neil Armstrong      2019-07-29  1368  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1369  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1370  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1371  						};
1499218c80c99a Neil Armstrong      2019-07-29  1372  					};
1499218c80c99a Neil Armstrong      2019-07-29  1373  
1499218c80c99a Neil Armstrong      2019-07-29  1374  					tdm_c_dout1_a_pins: tdm-c-dout1-a {
1499218c80c99a Neil Armstrong      2019-07-29  1375  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1376  							groups = "tdm_c_dout1_a";
1499218c80c99a Neil Armstrong      2019-07-29  1377  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1378  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1379  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1380  						};
1499218c80c99a Neil Armstrong      2019-07-29  1381  					};
1499218c80c99a Neil Armstrong      2019-07-29  1382  
1499218c80c99a Neil Armstrong      2019-07-29  1383  					tdm_c_dout1_z_pins: tdm-c-dout1-z {
1499218c80c99a Neil Armstrong      2019-07-29  1384  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1385  							groups = "tdm_c_dout1_z";
1499218c80c99a Neil Armstrong      2019-07-29  1386  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1387  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1388  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1389  						};
1499218c80c99a Neil Armstrong      2019-07-29  1390  					};
1499218c80c99a Neil Armstrong      2019-07-29  1391  
1499218c80c99a Neil Armstrong      2019-07-29  1392  					tdm_c_dout2_a_pins: tdm-c-dout2-a {
1499218c80c99a Neil Armstrong      2019-07-29  1393  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1394  							groups = "tdm_c_dout2_a";
1499218c80c99a Neil Armstrong      2019-07-29  1395  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1396  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1397  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1398  						};
1499218c80c99a Neil Armstrong      2019-07-29  1399  					};
1499218c80c99a Neil Armstrong      2019-07-29  1400  
1499218c80c99a Neil Armstrong      2019-07-29  1401  					tdm_c_dout2_z_pins: tdm-c-dout2-z {
1499218c80c99a Neil Armstrong      2019-07-29  1402  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1403  							groups = "tdm_c_dout2_z";
1499218c80c99a Neil Armstrong      2019-07-29  1404  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1405  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1406  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1407  						};
1499218c80c99a Neil Armstrong      2019-07-29  1408  					};
1499218c80c99a Neil Armstrong      2019-07-29  1409  
1499218c80c99a Neil Armstrong      2019-07-29  1410  					tdm_c_dout3_a_pins: tdm-c-dout3-a {
1499218c80c99a Neil Armstrong      2019-07-29  1411  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1412  							groups = "tdm_c_dout3_a";
1499218c80c99a Neil Armstrong      2019-07-29  1413  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1414  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1415  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1416  						};
1499218c80c99a Neil Armstrong      2019-07-29  1417  					};
1499218c80c99a Neil Armstrong      2019-07-29  1418  
1499218c80c99a Neil Armstrong      2019-07-29  1419  					tdm_c_dout3_z_pins: tdm-c-dout3-z {
1499218c80c99a Neil Armstrong      2019-07-29  1420  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1421  							groups = "tdm_c_dout3_z";
1499218c80c99a Neil Armstrong      2019-07-29  1422  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1423  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1424  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1425  						};
1499218c80c99a Neil Armstrong      2019-07-29  1426  					};
1499218c80c99a Neil Armstrong      2019-07-29  1427  
1499218c80c99a Neil Armstrong      2019-07-29  1428  					tdm_c_fs_a_pins: tdm-c-fs-a {
1499218c80c99a Neil Armstrong      2019-07-29  1429  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1430  							groups = "tdm_c_fs_a";
1499218c80c99a Neil Armstrong      2019-07-29  1431  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1432  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1433  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1434  						};
1499218c80c99a Neil Armstrong      2019-07-29  1435  					};
1499218c80c99a Neil Armstrong      2019-07-29  1436  
1499218c80c99a Neil Armstrong      2019-07-29  1437  					tdm_c_fs_z_pins: tdm-c-fs-z {
1499218c80c99a Neil Armstrong      2019-07-29  1438  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1439  							groups = "tdm_c_fs_z";
1499218c80c99a Neil Armstrong      2019-07-29  1440  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1441  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1442  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1443  						};
1499218c80c99a Neil Armstrong      2019-07-29  1444  					};
1499218c80c99a Neil Armstrong      2019-07-29  1445  
1499218c80c99a Neil Armstrong      2019-07-29  1446  					tdm_c_sclk_a_pins: tdm-c-sclk-a {
1499218c80c99a Neil Armstrong      2019-07-29  1447  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1448  							groups = "tdm_c_sclk_a";
1499218c80c99a Neil Armstrong      2019-07-29  1449  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1450  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1451  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1452  						};
1499218c80c99a Neil Armstrong      2019-07-29  1453  					};
1499218c80c99a Neil Armstrong      2019-07-29  1454  
1499218c80c99a Neil Armstrong      2019-07-29  1455  					tdm_c_sclk_z_pins: tdm-c-sclk-z {
1499218c80c99a Neil Armstrong      2019-07-29  1456  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1457  							groups = "tdm_c_sclk_z";
1499218c80c99a Neil Armstrong      2019-07-29  1458  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1459  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1460  							drive-strength-microamp = <3000>;
1499218c80c99a Neil Armstrong      2019-07-29  1461  						};
1499218c80c99a Neil Armstrong      2019-07-29  1462  					};
1499218c80c99a Neil Armstrong      2019-07-29  1463  
1499218c80c99a Neil Armstrong      2019-07-29  1464  					tdm_c_slv_fs_a_pins: tdm-c-slv-fs-a {
1499218c80c99a Neil Armstrong      2019-07-29  1465  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1466  							groups = "tdm_c_slv_fs_a";
1499218c80c99a Neil Armstrong      2019-07-29  1467  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1468  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1469  						};
1499218c80c99a Neil Armstrong      2019-07-29  1470  					};
1499218c80c99a Neil Armstrong      2019-07-29  1471  
1499218c80c99a Neil Armstrong      2019-07-29  1472  					tdm_c_slv_fs_z_pins: tdm-c-slv-fs-z {
1499218c80c99a Neil Armstrong      2019-07-29  1473  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1474  							groups = "tdm_c_slv_fs_z";
1499218c80c99a Neil Armstrong      2019-07-29  1475  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1476  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1477  						};
1499218c80c99a Neil Armstrong      2019-07-29  1478  					};
1499218c80c99a Neil Armstrong      2019-07-29  1479  
1499218c80c99a Neil Armstrong      2019-07-29  1480  					tdm_c_slv_sclk_a_pins: tdm-c-slv-sclk-a {
1499218c80c99a Neil Armstrong      2019-07-29  1481  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1482  							groups = "tdm_c_slv_sclk_a";
1499218c80c99a Neil Armstrong      2019-07-29  1483  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1484  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1485  						};
1499218c80c99a Neil Armstrong      2019-07-29  1486  					};
1499218c80c99a Neil Armstrong      2019-07-29  1487  
1499218c80c99a Neil Armstrong      2019-07-29  1488  					tdm_c_slv_sclk_z_pins: tdm-c-slv-sclk-z {
1499218c80c99a Neil Armstrong      2019-07-29  1489  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1490  							groups = "tdm_c_slv_sclk_z";
1499218c80c99a Neil Armstrong      2019-07-29  1491  							function = "tdm_c";
1499218c80c99a Neil Armstrong      2019-07-29  1492  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1493  						};
1499218c80c99a Neil Armstrong      2019-07-29  1494  					};
1499218c80c99a Neil Armstrong      2019-07-29  1495  
1499218c80c99a Neil Armstrong      2019-07-29  1496  					uart_a_pins: uart-a {
1499218c80c99a Neil Armstrong      2019-07-29  1497  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1498  							groups = "uart_a_tx",
1499218c80c99a Neil Armstrong      2019-07-29  1499  								 "uart_a_rx";
1499218c80c99a Neil Armstrong      2019-07-29  1500  							function = "uart_a";
1499218c80c99a Neil Armstrong      2019-07-29  1501  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1502  						};
1499218c80c99a Neil Armstrong      2019-07-29  1503  					};
1499218c80c99a Neil Armstrong      2019-07-29  1504  
1499218c80c99a Neil Armstrong      2019-07-29  1505  					uart_a_cts_rts_pins: uart-a-cts-rts {
1499218c80c99a Neil Armstrong      2019-07-29  1506  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1507  							groups = "uart_a_cts",
1499218c80c99a Neil Armstrong      2019-07-29  1508  								 "uart_a_rts";
1499218c80c99a Neil Armstrong      2019-07-29  1509  							function = "uart_a";
1499218c80c99a Neil Armstrong      2019-07-29  1510  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1511  						};
1499218c80c99a Neil Armstrong      2019-07-29  1512  					};
1499218c80c99a Neil Armstrong      2019-07-29  1513  
1499218c80c99a Neil Armstrong      2019-07-29  1514  					uart_b_pins: uart-b {
1499218c80c99a Neil Armstrong      2019-07-29  1515  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1516  							groups = "uart_b_tx",
1499218c80c99a Neil Armstrong      2019-07-29  1517  								 "uart_b_rx";
1499218c80c99a Neil Armstrong      2019-07-29  1518  							function = "uart_b";
1499218c80c99a Neil Armstrong      2019-07-29  1519  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1520  						};
1499218c80c99a Neil Armstrong      2019-07-29  1521  					};
1499218c80c99a Neil Armstrong      2019-07-29  1522  
1499218c80c99a Neil Armstrong      2019-07-29  1523  					uart_c_pins: uart-c {
1499218c80c99a Neil Armstrong      2019-07-29  1524  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1525  							groups = "uart_c_tx",
1499218c80c99a Neil Armstrong      2019-07-29  1526  								 "uart_c_rx";
1499218c80c99a Neil Armstrong      2019-07-29  1527  							function = "uart_c";
1499218c80c99a Neil Armstrong      2019-07-29  1528  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1529  						};
1499218c80c99a Neil Armstrong      2019-07-29  1530  					};
1499218c80c99a Neil Armstrong      2019-07-29  1531  
1499218c80c99a Neil Armstrong      2019-07-29  1532  					uart_c_cts_rts_pins: uart-c-cts-rts {
1499218c80c99a Neil Armstrong      2019-07-29  1533  						mux {
1499218c80c99a Neil Armstrong      2019-07-29  1534  							groups = "uart_c_cts",
1499218c80c99a Neil Armstrong      2019-07-29  1535  								 "uart_c_rts";
1499218c80c99a Neil Armstrong      2019-07-29  1536  							function = "uart_c";
1499218c80c99a Neil Armstrong      2019-07-29  1537  							bias-disable;
1499218c80c99a Neil Armstrong      2019-07-29  1538  						};
1499218c80c99a Neil Armstrong      2019-07-29  1539  					};
1499218c80c99a Neil Armstrong      2019-07-29  1540  				};
1499218c80c99a Neil Armstrong      2019-07-29  1541  			};
1499218c80c99a Neil Armstrong      2019-07-29  1542  
8656783f07613a Guillaume La Roque  2019-10-04  1543  			cpu_temp: temperature-sensor@34800 {
8656783f07613a Guillaume La Roque  2019-10-04  1544  				compatible = "amlogic,g12a-cpu-thermal",
8656783f07613a Guillaume La Roque  2019-10-04  1545  					     "amlogic,g12a-thermal";
8656783f07613a Guillaume La Roque  2019-10-04  1546  				reg = <0x0 0x34800 0x0 0x50>;
8656783f07613a Guillaume La Roque  2019-10-04  1547  				interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
8656783f07613a Guillaume La Roque  2019-10-04  1548  				clocks = <&clkc CLKID_TS>;
8656783f07613a Guillaume La Roque  2019-10-04  1549  				#thermal-sensor-cells = <0>;
8656783f07613a Guillaume La Roque  2019-10-04  1550  				amlogic,ao-secure = <&sec_AO>;
8656783f07613a Guillaume La Roque  2019-10-04  1551  			};
8656783f07613a Guillaume La Roque  2019-10-04  1552  
8656783f07613a Guillaume La Roque  2019-10-04  1553  			ddr_temp: temperature-sensor@34c00 {
8656783f07613a Guillaume La Roque  2019-10-04  1554  				compatible = "amlogic,g12a-ddr-thermal",
8656783f07613a Guillaume La Roque  2019-10-04  1555  					     "amlogic,g12a-thermal";
8656783f07613a Guillaume La Roque  2019-10-04  1556  				reg = <0x0 0x34c00 0x0 0x50>;
8656783f07613a Guillaume La Roque  2019-10-04  1557  				interrupts = <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;
8656783f07613a Guillaume La Roque  2019-10-04  1558  				clocks = <&clkc CLKID_TS>;
8656783f07613a Guillaume La Roque  2019-10-04  1559  				#thermal-sensor-cells = <0>;
8656783f07613a Guillaume La Roque  2019-10-04  1560  				amlogic,ao-secure = <&sec_AO>;
8656783f07613a Guillaume La Roque  2019-10-04  1561  			};
8656783f07613a Guillaume La Roque  2019-10-04  1562  
1499218c80c99a Neil Armstrong      2019-07-29  1563  			usb2_phy0: phy@36000 {
1499218c80c99a Neil Armstrong      2019-07-29  1564  				compatible = "amlogic,g12a-usb2-phy";
1499218c80c99a Neil Armstrong      2019-07-29  1565  				reg = <0x0 0x36000 0x0 0x2000>;
1499218c80c99a Neil Armstrong      2019-07-29  1566  				clocks = <&xtal>;
1499218c80c99a Neil Armstrong      2019-07-29  1567  				clock-names = "xtal";
1499218c80c99a Neil Armstrong      2019-07-29  1568  				resets = <&reset RESET_USB_PHY20>;
1499218c80c99a Neil Armstrong      2019-07-29  1569  				reset-names = "phy";
1499218c80c99a Neil Armstrong      2019-07-29  1570  				#phy-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29  1571  			};
1499218c80c99a Neil Armstrong      2019-07-29  1572  
1499218c80c99a Neil Armstrong      2019-07-29  1573  			dmc: bus@38000 {
1499218c80c99a Neil Armstrong      2019-07-29  1574  				compatible = "simple-bus";
1499218c80c99a Neil Armstrong      2019-07-29  1575  				#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29  1576  				#size-cells = <2>;
aec4353114a408 Marc Gonzalez       2023-03-27  1577  				ranges = <0x0 0x0 0x0 0x38000 0x0 0x2000>;
1499218c80c99a Neil Armstrong      2019-07-29  1578  
1499218c80c99a Neil Armstrong      2019-07-29  1579  				canvas: video-lut@48 {
1499218c80c99a Neil Armstrong      2019-07-29  1580  					compatible = "amlogic,canvas";
1499218c80c99a Neil Armstrong      2019-07-29  1581  					reg = <0x0 0x48 0x0 0x14>;
1499218c80c99a Neil Armstrong      2019-07-29  1582  				};
33acea2049b505 Marc Gonzalez       2023-03-27  1583  
33acea2049b505 Marc Gonzalez       2023-03-27  1584  				pmu: pmu@80 {
33acea2049b505 Marc Gonzalez       2023-03-27  1585  					reg = <0x0 0x80 0x0 0x40>,
33acea2049b505 Marc Gonzalez       2023-03-27  1586  					      <0x0 0xc00 0x0 0x40>;
33acea2049b505 Marc Gonzalez       2023-03-27  1587  					interrupts = <GIC_SPI 52 IRQ_TYPE_EDGE_RISING>;
33acea2049b505 Marc Gonzalez       2023-03-27  1588  				};
1499218c80c99a Neil Armstrong      2019-07-29  1589  			};
1499218c80c99a Neil Armstrong      2019-07-29  1590  
1499218c80c99a Neil Armstrong      2019-07-29  1591  			usb2_phy1: phy@3a000 {
1499218c80c99a Neil Armstrong      2019-07-29  1592  				compatible = "amlogic,g12a-usb2-phy";
1499218c80c99a Neil Armstrong      2019-07-29  1593  				reg = <0x0 0x3a000 0x0 0x2000>;
1499218c80c99a Neil Armstrong      2019-07-29  1594  				clocks = <&xtal>;
1499218c80c99a Neil Armstrong      2019-07-29  1595  				clock-names = "xtal";
1499218c80c99a Neil Armstrong      2019-07-29  1596  				resets = <&reset RESET_USB_PHY21>;
1499218c80c99a Neil Armstrong      2019-07-29  1597  				reset-names = "phy";
1499218c80c99a Neil Armstrong      2019-07-29  1598  				#phy-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29  1599  			};
1499218c80c99a Neil Armstrong      2019-07-29  1600  
1499218c80c99a Neil Armstrong      2019-07-29  1601  			hiu: bus@3c000 {
1499218c80c99a Neil Armstrong      2019-07-29  1602  				compatible = "simple-bus";
1499218c80c99a Neil Armstrong      2019-07-29  1603  				reg = <0x0 0x3c000 0x0 0x1400>;
1499218c80c99a Neil Armstrong      2019-07-29  1604  				#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29  1605  				#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29  1606  				ranges = <0x0 0x0 0x0 0x3c000 0x0 0x1400>;
1499218c80c99a Neil Armstrong      2019-07-29  1607  
1499218c80c99a Neil Armstrong      2019-07-29  1608  				hhi: system-controller@0 {
1499218c80c99a Neil Armstrong      2019-07-29  1609  					compatible = "amlogic,meson-gx-hhi-sysctrl",
1499218c80c99a Neil Armstrong      2019-07-29  1610  						     "simple-mfd", "syscon";
1499218c80c99a Neil Armstrong      2019-07-29  1611  					reg = <0 0 0 0x400>;
1499218c80c99a Neil Armstrong      2019-07-29  1612  
1499218c80c99a Neil Armstrong      2019-07-29  1613  					clkc: clock-controller {
1499218c80c99a Neil Armstrong      2019-07-29  1614  						compatible = "amlogic,g12a-clkc";
1499218c80c99a Neil Armstrong      2019-07-29  1615  						#clock-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1616  						clocks = <&xtal>;
1499218c80c99a Neil Armstrong      2019-07-29  1617  						clock-names = "xtal";
1499218c80c99a Neil Armstrong      2019-07-29  1618  					};
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1619  
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1620  					pwrc: power-controller {
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1621  						compatible = "amlogic,meson-g12a-pwrc";
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1622  						#power-domain-cells = <1>;
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1623  						amlogic,ao-sysctrl = <&rti>;
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1624  						resets = <&reset RESET_VIU>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1625  							 <&reset RESET_VENC>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1626  							 <&reset RESET_VCBUS>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1627  							 <&reset RESET_BT656>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1628  							 <&reset RESET_RDMA>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1629  							 <&reset RESET_VENCI>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1630  							 <&reset RESET_VENCP>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1631  							 <&reset RESET_VDAC>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1632  							 <&reset RESET_VDI6>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1633  							 <&reset RESET_VENCL>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1634  							 <&reset RESET_VID_LOCK>;
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1635  						reset-names = "viu", "venc", "vcbus", "bt656",
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1636  							      "rdma", "venci", "vencp", "vdac",
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1637  							      "vdi6", "vencl", "vid_lock";
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1638  						clocks = <&clkc CLKID_VPU>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1639  							 <&clkc CLKID_VAPB>;
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1640  						clock-names = "vpu", "vapb";
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1641  						/*
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1642  						 * VPU clocking is provided by two identical clock paths
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1643  						 * VPU_0 and VPU_1 muxed to a single clock by a glitch
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1644  						 * free mux to safely change frequency while running.
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1645  						 * Same for VAPB but with a final gate after the glitch free mux.
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1646  						 */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1647  						assigned-clocks = <&clkc CLKID_VPU_0_SEL>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1648  								  <&clkc CLKID_VPU_0>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1649  								  <&clkc CLKID_VPU>, /* Glitch free mux */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1650  								  <&clkc CLKID_VAPB_0_SEL>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1651  								  <&clkc CLKID_VAPB_0>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1652  								  <&clkc CLKID_VAPB_SEL>; /* Glitch free mux */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1653  						assigned-clock-parents = <&clkc CLKID_FCLK_DIV3>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1654  									 <0>, /* Do Nothing */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1655  									 <&clkc CLKID_VPU_0>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1656  									 <&clkc CLKID_FCLK_DIV4>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1657  									 <0>, /* Do Nothing */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1658  									 <&clkc CLKID_VAPB_0>;
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1659  						assigned-clock-rates = <0>, /* Do Nothing */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1660  								       <666666666>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1661  								       <0>, /* Do Nothing */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1662  								       <0>, /* Do Nothing */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1663  								       <250000000>,
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1664  								       <0>; /* Do Nothing */
f4f1c8d9ace7a0 Neil Armstrong      2019-08-23  1665  					};
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1666  
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1667  					mipi_analog_dphy: phy {
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1668  						compatible = "amlogic,g12a-mipi-dphy-analog";
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1669  						#phy-cells = <0>;
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1670  						status = "disabled";
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1671  					};
1499218c80c99a Neil Armstrong      2019-07-29  1672  				};
1499218c80c99a Neil Armstrong      2019-07-29  1673  			};
1499218c80c99a Neil Armstrong      2019-07-29  1674  
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1675  			mipi_dphy: phy@44000 {
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1676  				compatible = "amlogic,axg-mipi-dphy";
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1677  				reg = <0x0 0x44000 0x0 0x2000>;
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1678  				clocks = <&clkc CLKID_MIPI_DSI_PHY>;
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1679  				clock-names = "pclk";
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1680  				resets = <&reset RESET_MIPI_DSI_PHY>;
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1681  				reset-names = "phy";
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1682  				phys = <&mipi_analog_dphy>;
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1683  				phy-names = "analog";
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1684  				#phy-cells = <0>;
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1685  				status = "disabled";
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1686  			};
6f1c2a12ed1138 Neil Armstrong      2024-04-03  1687  
1499218c80c99a Neil Armstrong      2019-07-29  1688  			usb3_pcie_phy: phy@46000 {
1499218c80c99a Neil Armstrong      2019-07-29  1689  				compatible = "amlogic,g12a-usb3-pcie-phy";
1499218c80c99a Neil Armstrong      2019-07-29  1690  				reg = <0x0 0x46000 0x0 0x2000>;
1499218c80c99a Neil Armstrong      2019-07-29  1691  				clocks = <&clkc CLKID_PCIE_PLL>;
1499218c80c99a Neil Armstrong      2019-07-29  1692  				clock-names = "ref_clk";
1499218c80c99a Neil Armstrong      2019-07-29  1693  				resets = <&reset RESET_PCIE_PHY>;
1499218c80c99a Neil Armstrong      2019-07-29  1694  				reset-names = "phy";
1499218c80c99a Neil Armstrong      2019-07-29  1695  				assigned-clocks = <&clkc CLKID_PCIE_PLL>;
1499218c80c99a Neil Armstrong      2019-07-29  1696  				assigned-clock-rates = <100000000>;
1499218c80c99a Neil Armstrong      2019-07-29  1697  				#phy-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1698  			};
1499218c80c99a Neil Armstrong      2019-07-29  1699  
1499218c80c99a Neil Armstrong      2019-07-29  1700  			eth_phy: mdio-multiplexer@4c000 {
1499218c80c99a Neil Armstrong      2019-07-29  1701  				compatible = "amlogic,g12a-mdio-mux";
1499218c80c99a Neil Armstrong      2019-07-29  1702  				reg = <0x0 0x4c000 0x0 0xa4>;
1499218c80c99a Neil Armstrong      2019-07-29  1703  				clocks = <&clkc CLKID_ETH_PHY>,
1499218c80c99a Neil Armstrong      2019-07-29  1704  					 <&xtal>,
1499218c80c99a Neil Armstrong      2019-07-29  1705  					 <&clkc CLKID_MPLL_50M>;
1499218c80c99a Neil Armstrong      2019-07-29  1706  				clock-names = "pclk", "clkin0", "clkin1";
1499218c80c99a Neil Armstrong      2019-07-29  1707  				mdio-parent-bus = <&mdio0>;
1499218c80c99a Neil Armstrong      2019-07-29  1708  				#address-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1709  				#size-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29  1710  
1499218c80c99a Neil Armstrong      2019-07-29  1711  				ext_mdio: mdio@0 {
1499218c80c99a Neil Armstrong      2019-07-29  1712  					reg = <0>;
1499218c80c99a Neil Armstrong      2019-07-29  1713  					#address-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1714  					#size-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29  1715  				};
1499218c80c99a Neil Armstrong      2019-07-29  1716  
1499218c80c99a Neil Armstrong      2019-07-29  1717  				int_mdio: mdio@1 {
1499218c80c99a Neil Armstrong      2019-07-29  1718  					reg = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1719  					#address-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1720  					#size-cells = <0>;
1499218c80c99a Neil Armstrong      2019-07-29  1721  
e7303651bbc76c Martin Blumenstingl 2023-01-11  1722  					internal_ephy: ethernet-phy@8 {
1499218c80c99a Neil Armstrong      2019-07-29  1723  						compatible = "ethernet-phy-id0180.3301",
1499218c80c99a Neil Armstrong      2019-07-29  1724  							     "ethernet-phy-ieee802.3-c22";
1499218c80c99a Neil Armstrong      2019-07-29  1725  						interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
1499218c80c99a Neil Armstrong      2019-07-29  1726  						reg = <8>;
1499218c80c99a Neil Armstrong      2019-07-29  1727  						max-speed = <100>;
1499218c80c99a Neil Armstrong      2019-07-29  1728  					};
1499218c80c99a Neil Armstrong      2019-07-29  1729  				};
1499218c80c99a Neil Armstrong      2019-07-29  1730  			};
1499218c80c99a Neil Armstrong      2019-07-29  1731  		};
1499218c80c99a Neil Armstrong      2019-07-29  1732  
1499218c80c99a Neil Armstrong      2019-07-29  1733  		aobus: bus@ff800000 {
1499218c80c99a Neil Armstrong      2019-07-29  1734  			compatible = "simple-bus";
1499218c80c99a Neil Armstrong      2019-07-29  1735  			reg = <0x0 0xff800000 0x0 0x100000>;
1499218c80c99a Neil Armstrong      2019-07-29  1736  			#address-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29  1737  			#size-cells = <2>;
1499218c80c99a Neil Armstrong      2019-07-29  1738  			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
1499218c80c99a Neil Armstrong      2019-07-29  1739  
1499218c80c99a Neil Armstrong      2019-07-29  1740  			rti: sys-ctrl@0 {
1499218c80c99a Neil Armstrong      2019-07-29  1741  				compatible = "amlogic,meson-gx-ao-sysctrl",
1499218c80c99a Neil Armstrong      2019-07-29  1742  					     "simple-mfd", "syscon";
1499218c80c99a Neil Armstrong      2019-07-29  1743  				reg = <0x0 0x0 0x0 0x100>;
1499218c80c99a Neil Armstrong      2019-07-29  1744  
1499218c80c99a Neil Armstrong      2019-07-29  1745  				clkc_AO: clock-controller {
1499218c80c99a Neil Armstrong      2019-07-29  1746  					compatible = "amlogic,meson-g12a-aoclkc";
1499218c80c99a Neil Armstrong      2019-07-29  1747  					#clock-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1748  					#reset-cells = <1>;
1499218c80c99a Neil Armstrong      2019-07-29  1749  					clocks = <&xtal>, <&clkc CLKID_CLK81>;
1499218c80c99a Neil Armstrong      2019-07-29  1750  					clock-names = "xtal", "mpeg-clk";
1499218c80c99a Neil Armstrong      2019-07-29  1751  				};
cf42ea27fd7f08 Neil Armstrong      2024-06-06  1752  			};
1499218c80c99a Neil Armstrong      2019-07-29  1753  
cf42ea27fd7f08 Neil Armstrong      2024-06-06 @1754  			ao_pinctrl: pinctrl@14 {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


