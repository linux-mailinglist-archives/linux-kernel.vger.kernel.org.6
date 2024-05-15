Return-Path: <linux-kernel+bounces-179342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3EB8C5F01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991831F21F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE01DA23;
	Wed, 15 May 2024 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXngebdb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D761814F7A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737846; cv=fail; b=EJfIFB5eZj4jA/tIPuHEOU4En3pUSFA8QcDb8WmDRDFTkFy7+hJ82LGdVsL+soBqsNh4EZM0N6T6E+xyssegnajetjkzNLkrHQDLPUjQdZn+uwCm0wK2GQ++zeW+54SaerYHVYJTs0fHCD0gcdem6PKwHCjWm82WD04QmLZnfgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737846; c=relaxed/simple;
	bh=tSDLuMmWjbl/ARdON0AviBV9iCYbWyyaulTPykm7xNo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hcb1T5P5WY4L0I8VsWL0EjN/+CqfrHL5/yk7PYQYI5xBwZVe0G1QcmAp/AAxDWOlrbmDJX20cLOkYJ/GObehQm8ZjdO3EEUUzlHEJF0Zup0AKeXqGLhVrzQyUhSlkHbFT5TkjLnfxwtvjpIqhJ7WvtmeGXySB5eWtuWGk2iRl1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXngebdb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715737844; x=1747273844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tSDLuMmWjbl/ARdON0AviBV9iCYbWyyaulTPykm7xNo=;
  b=kXngebdbBiF+0Hdf6xq1WoNPVWSdF6Z3wgq5l3+B6tphv4VSnClygD70
   RqM+B6SJREEbNOIaDpoA9rMay/uD9YFfbmZK1NzFUdV3aew64goqBMmf8
   SmbI55DO05w3NjPk+tB42JFpdAnZaNtTU+qV44YHpNyaaHznLUc+v3AYi
   E/RRrONoLMo8QT2WSCzO4/P9rLBh4ZBT6UGHEhiERo6p/ppwFFM6Cb6rf
   CE5RYVsF7i04vn0WQlrQVTuutYT6qDRQK//KVCm2L0HL6XEDHxEceQnWA
   ZbjWbWiHwgKbEvvVQt4ABvM8iSMne5S8NgAZrBqar0mbKDjDaX+Op3efR
   g==;
X-CSE-ConnectionGUID: tFDrzarGQnmkd8c8OLQRKw==
X-CSE-MsgGUID: B/nmInfqTbywv4/fJ8REWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="22348210"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="22348210"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 18:50:44 -0700
X-CSE-ConnectionGUID: 8a8irKZ3SmCLHRBvwrFVVA==
X-CSE-MsgGUID: o3xPNo0ZQ6qScuGnRdm5mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="62067912"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 18:50:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 18:50:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 18:50:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 18:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW4Bce3MB3DIrL0d/01r9vdL3jFbt9iKtbM2ijOSJ3um8eA7c9fc8/SmIiXKdc3vjxI9i/Zi3lRVeYKHG2aMkaHOjxZ+KI0rlRu8kqTnw4AVe9TPCCpdhs1obOHbbS+meZAA35+5s2VMPWRQUcvor9ytfVoyw+6Vu6qah7ecFIYMFkDAXPI66uZd8X5WCV3vQpuOiRJkugFgLjS1KA5/Tta8eII7FQwWf6sngCI0M9maV+oh5tu6CVQhHMJGioSEmiXspQTxr/2i1+B0pVcFnn7eCW6QHvCPi+nDuPzNOcyqvDT4UcIN4oV/WLlZUKTCjTFnHPvq+QuZSA4bNRfbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXE/NvC3HNQhuMAuPhnt+fX5l1jU0al4pyKBOmw1WEc=;
 b=mvhDdMqNMtT9VkSLLVtH9dyMRbZXkuY7ze6WO1D/eev9sjCwEPrjFAFnzdPVrodBY67PGolhZIMWUnhsX4Wa1A1JeNKsk6S5ynF6bCOD7gH8NZbbR2Y5BgAZAaq7irX/vcauIGMOkCX455cZcAuYtOC49PHjGYMqAbJzbTNEF7Hn1X309zqeYfcwrqjpmHBd1NkwOR8dPTfzjRhoGGTmo1HiG7lYaqQMj7VrrJkj5Kg8GJEypPDk66daIZ0OetYwU/GG9IIR1/dT2HQ4OmlXAdNZG68NFFVEv+q1aeorlMzP3xN9r8j3DlcOCbzJ0X4KoonLSFzLAb7KtUcCtbP49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 01:50:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 01:50:39 +0000
Date: Wed, 15 May 2024 09:50:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vitaly Lifshits <vitaly.lifshits@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, Dima Ruinskiy
	<dima.ruinskiy@intel.com>, Naama Meir <naamax.meir@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <rui.zhang@intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@inte.com>
Subject: [linus:master] [e1000e]  861e808602: suspend-stress.fail
Message-ID: <202405150942.f9b873b1-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c9a21e-f43f-438d-a2e7-08dc74816c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?18i9sQVnbmaNoE0TD1lKvmD3Ac7OzcD2Wqs7a67OMY8ERZ4Ot+8YWxWgocma?=
 =?us-ascii?Q?/e9S8q3kSK2H4gviHlH23ChhH1h+Gosww+BQfNabqc3ITvibsej0M4hPHuY/?=
 =?us-ascii?Q?3OJL5k/IovExSfk15SX/5w/gPiGwqHEMHDdjN1j2Um2hsGL+5ZUDPXMw0IRN?=
 =?us-ascii?Q?hyd5dk9bBDICg7dNK2hk26Ihs9D/6Ma+TSVGtDV+ieyRudfcF2gYEUGBhbWQ?=
 =?us-ascii?Q?g4ztR69fiIw9xlFSDuHiUnPITAzoqFRXwj3sd/xWb994myzcRx9nIAke9+Jl?=
 =?us-ascii?Q?4IKIkL9WM/aH0F4ZzKmZHd9sZnUHIa8RC6cWJibBI77FGM02gLDGrCEXMw6b?=
 =?us-ascii?Q?IgU+918Sm0/S+BmJVMyyoh3z5ydBo9A8NRX3xUYalFAJDeMN3CfH7Lf2ugsE?=
 =?us-ascii?Q?mbn+vhwG4jKwTeYS7cvxBYhq90e/eUzJtCs0CGYLCkle5ZH9Li6kXD60yZaB?=
 =?us-ascii?Q?C0OK9rm6wq3qINGIiPfuBO4B+raXjgFeIS9y+s0S7RygjI24x9M/ZUmLn+5z?=
 =?us-ascii?Q?qcm+aKR/VPkf7O5jgv9rUofr4p2PKsudle1bc3Lrkc2dnlc9YzNMfCFs+RRT?=
 =?us-ascii?Q?VTrE1wMdp/oDBkJlLQx8VMGpa/NWNn3kHVPrOI5IhBeY60trhBtWY0CjVNMV?=
 =?us-ascii?Q?0QEdH2Lnrwt1t/hae0pwtRpswDp/f4Uj6twQU5i+1Ll0X2UfFNulFKQaUlqC?=
 =?us-ascii?Q?+qeF8uU9Y49DmjATCihUAb42iGVpf37ovfKSi84wr4YpBOGbU77qVDVGr/+s?=
 =?us-ascii?Q?cu+6XXFOLEZFJ5/V/s62fRXHLaFvtpDrVaGwuTW2JmTz+kXzFENFG4NEEboA?=
 =?us-ascii?Q?Cy23Vd3urhqYcWEzIWd0C9Hszr7Y3Y59p8UzxDJP3PL34/cWEUCKpXCAJUk/?=
 =?us-ascii?Q?GizH5NX/U+uC8KamUHW5ekPlclL728GuGK50YDFVCwM522FLGoyObglwRzwO?=
 =?us-ascii?Q?KoVvOORgkodoRgPJDR1VfNDtUllvilYnEJl+ZyR4vSJq3jZQAKxfHYxe+B00?=
 =?us-ascii?Q?EUZJPCB61lZ+xVD4xp9jCiWN/qFaJYF0uceyRy4uNfwjPVZ8Iy61xV9yshYM?=
 =?us-ascii?Q?YnLrZEEKMqJk+FfsBKJ0yC6utb6D16MYsNJZt1wwHQJnFaiq6wdU71HeFZHT?=
 =?us-ascii?Q?iElxuhVTKWwM8IOSkcos8aoX4m8GNtpY9Uca29MfEfIy1rk9c6hfZbbBpnYr?=
 =?us-ascii?Q?zgpxCtALMyOpV+A8sGHNVmjX1soPIgPXHCq6RFG5thU2VErU/FN7ub1IED4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XLSI/epS7urtVR43WP60K4DLSnjQ+XWYTG0/eBKmLvXUOxxS+Rs5uYSgY5MD?=
 =?us-ascii?Q?DtiCSAOL9MrxtsoTofQiRkq6uqRYCIIBUSjq/E1H0nKc0GROvnCY8t04ASWn?=
 =?us-ascii?Q?iieJKfCIJe3n3vOj9ioAWhsQnYhBY9Hsnp121QKNUAyT2eBU4YcA8uIZmxgo?=
 =?us-ascii?Q?bwpCNab5JqsZjpmZt3DYqgJYk3WXyve1/w+1eEexePNqQyeFXww4gV2QOLWJ?=
 =?us-ascii?Q?1TqA8q+ue14eMLvdK+nQNttt8sMuhOrB+4sMi0+SbQUNJv0vUIxbZF0Ln8iA?=
 =?us-ascii?Q?EBDWU4wnafz1g6E/gbJvbuotY9javRRw6TSm/k6B8nqdNUTTpF7vCqjOqrNi?=
 =?us-ascii?Q?rDZEGdC06yihvj7hPmPL0Jv5WH+bF2i2Uk1gLdbFOdKV4nEdlPmGRxFB8DTc?=
 =?us-ascii?Q?AIDh2KTfOX07eu+jWlPe9Ncilo40LJpoopnW07CUMFK4tX35mYJ5RlYy7TwN?=
 =?us-ascii?Q?XP9/pe2QMYmm6Z1ZXBTiy+eCN6Q6uZJzOpnqAe0YO7JBthogEms1oQUvAhO3?=
 =?us-ascii?Q?tiogM/1zKgX0OlAxFyWSdYnEK623PZFI+Vps00gCpiVtzMdEnOusJYcg1tns?=
 =?us-ascii?Q?kPIP+vsyxyiTFJqoBS6lLcwNRyZMqU8xU4qDhTrYbVBu6oQQlqVAElRqQXK5?=
 =?us-ascii?Q?n+NfYkYnKdO2Hwh0uUV3lsZgnR21Q9D63Yn9Gzs9ec5qq7lmi6O43NoD6kr7?=
 =?us-ascii?Q?vzgR/23xU00eT1nken1pOw+n7K8HwCXIv3xxT3wGhcVeQZbgIkpfRGf3cL65?=
 =?us-ascii?Q?TEhNAukeV+6s/A1hEhXL8TC5DOAfp+5VvaL33dnBvJ9nr53BANKvU0dU8nsS?=
 =?us-ascii?Q?94BesjFLXZtWBJgYRORRNj5AlHQMHpeo/R2MSKUpF7FeBmVjtaR+l1KBJRUF?=
 =?us-ascii?Q?BH0IWjAmS+Zbwfo15/lCnaLMiVdjffr45PWPhrkPzG4+Lskd6s9Q/usIckSO?=
 =?us-ascii?Q?sgJuaHG6dGqjm/TYLWp8kkjEwKdKWP1UnhhZWExr2u2ZkNBEqTKAk4ji27Dr?=
 =?us-ascii?Q?M64Bn374UdVrBRffu6IQcs2ZigaWfAso0kTIbhzpyWJA6BSUoum+3eW4zvr+?=
 =?us-ascii?Q?gig9o5lZpsAJimLwxmM9xXEWnjU/3Vnv43pM9xRUZRcEbMbef84VmfpKQPsF?=
 =?us-ascii?Q?8NwOwQ3dGhJTuViyJxgIDqeedQ1w7IWxG3ShmRshGoAm5h3aPHB42eLJpoPW?=
 =?us-ascii?Q?YaoKZ30KDuY19gTgMDNhpUZ1IG9fno0MoXCRYleuStDGxV3W8XMlBICf8yJz?=
 =?us-ascii?Q?RCVjESSY6PaG2Ph1izAZ5a/AXkUdqOpTn6WWubUjA3Si2JERzdLmE6uEqUU2?=
 =?us-ascii?Q?Ns5i+N9TkisVVYrY7YTxd8tvCGfMrjCqsgS/E2Qvr+vgosLu+hNvvTfaDKs9?=
 =?us-ascii?Q?gfFJ0gCIsaw72DrjEYxzjypc3PkRh/fzQORDQYrugqnPDsAaIU1+LM+rLlwY?=
 =?us-ascii?Q?PtM8l1ECnXWJ9WSrqAkaH7Exzoj5UtZd1xXZzxudpJOtZJ0Q0UsiKEpC9W/3?=
 =?us-ascii?Q?VdEh7bNfUyWrpCv045nXE3SGQCtZoYvIhmLUaeK7bJWT8qXe4Vn5d1ulH1wg?=
 =?us-ascii?Q?k+cmvV5i+lAWQd3N7H0l0pPXHXI7IGIkiUtU7obWTBB1E2piRr9udooSCW3x?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c9a21e-f43f-438d-a2e7-08dc74816c66
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 01:50:39.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZqhSeHmRCbUo0OWfdpyC9eQG6oE3kLRbI/kFQJiMWLG0eJ8c1FdJyF+Tla05HXEoHNuRkRBGo+a+iukjKC6jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "suspend-stress.fail" on:

commit: 861e8086029e003305750b4126ecd6617465f5c7 ("e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master a7c840ba5fa78d7761b9fedc33d69cef44986d79]
[test failed on linux-next/master 6ba6c795dc73c22ce2c86006f17c4aa802db2a60]


in testcase: suspend-stress
version: 
with following parameters:

	mode: freeze
	iterations: 10



compiler: gcc-13
test machine: 4 threads (Broadwell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405150942.f9b873b1-oliver.sang@intel.com

test started

<--- but cannot really run suspend-stress tests successfully


as a contrast, for parent, we always noticed the jobs run smoothly

SUSPEND RESUME TEST STARTED
Suspend to freeze 1/10:
/usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-freeze-debian-x86_64-20180403.cgz-6dbdd4de0362-20240406-63993-p7cw6d-0.yaml&job_state=suspending-1/10 -O /dev/null
Done
Sleep for 10 seconds

..

Suspend to freeze 10/10:
/usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-freeze-debian-x86_64-20180403.cgz-6dbdd4de0362-20240406-63993-p7cw6d-0.yaml&job_state=suspending-10/10 -O /dev/null
Done
Sleep for 10 seconds
SUSPEND RESUME TEST SUCCESS


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240515/202405150942.f9b873b1-oliver.sang@intel.com


if you need more information, please let us know. Thanks!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


