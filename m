Return-Path: <linux-kernel+bounces-233240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE091B4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB40A283F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE50125DE;
	Fri, 28 Jun 2024 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/sh+P4g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45082F9F5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538762; cv=fail; b=m7ePfszTfxYGOVAMoPzk+1mzCXcgxoRufoAfTR+1ssBKcnNJXbw/pC0iEpiWP32U9SArsDHBTRqvdU2OIK96IaKOj/k8+ws2GGul5VGHqZfjIQ2JVzE4XorAVg5mjT26aGr3oMsi7pTeq/V8rfyRfjFTFIwNCqZwZx00/YZtO3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538762; c=relaxed/simple;
	bh=sR83x/DtKL97nzMMLRShmFuEb9wwN9JuK431g8MbphE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SOJNIk/1x4iDNMPGjMzCbfM9SjOl/nTVRqlwG6EctvtL7vUdvrI1djz8XUDpt05uGgUEW5Yf1guhGy5bwxrFU8IFPfwbtEq30HWiY+hoZ1LSaBW7RgKJac7cMJT22Z6AP9bBXIWsxZdxtu3VWZme0zv8HW9F76Htt5RLWO3t2+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/sh+P4g; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719538761; x=1751074761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sR83x/DtKL97nzMMLRShmFuEb9wwN9JuK431g8MbphE=;
  b=H/sh+P4gtMDC9snuNgHtuXtfJIthcs2JaQ6g+gIlY9X6ubXvIl2IUAq/
   9sy1r2jJ4RptZBdSlvI6MMdoiSgnNeFLE2rt0w5/qJJ/ojBnDC4T363ed
   ioheRwVLZo3vOLI9pW1F0gSv9qGFvGK8zcgv5tj7HzOB6rMVz5P6MKk6X
   A69Z0LoA7NRtZ6i82XpTdQYl2TNOwuQLBnl2TXKyUmbt+wFbeMupWIbfQ
   MBuu0jo7pcBw7H+Dbb96MGNOqf9x1G4wJqPw73nec9JFpUMfZrUkVucIZ
   EpvyW0FwYyGQ7RDknR7JTRpbnNu9xSJYgBM6yd62nhsW3IvE39BwXtRm/
   w==;
X-CSE-ConnectionGUID: 6udtw1KCSsGyb4oQbY7UDQ==
X-CSE-MsgGUID: Kh8lHosqQPOnmnteMG1XxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20469751"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="20469751"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 18:39:18 -0700
X-CSE-ConnectionGUID: DtruIePGQQCOtqxfv5Z1Gw==
X-CSE-MsgGUID: QKE5rrdcS4SKilCwdureFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="45328700"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 18:39:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 18:39:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 18:39:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 18:39:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8Rd3YQv9r8liBxyB0qQoow0PkQluJPOU8AKTX6tFkIHG/7V73OsRrOVXnOvyFABgA2WoB6CEbQYz61LvTph8SYFjpyr9wnRrAfMEgIHlLi83GHiJNqKHRzqDFmyXWqi5WU8k7BGXwTNzXldKshhoHP+TJM50d+1gyzH0EFtDPeMS7iXYHAi2urH2l6ImO6NeNoulzohNEuR7BlBAsjBqCuTIr24pNYkK6n9p9t7C+EVakdASlaFEF9f9G4LOVGT11XFrAREMTxUrrytCywVVJmco4GfxLzq2F/SVHihHjA3GvUmrpf3qjQoJmbJ9vgQhYpb92vSeESeIhnoKsQQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etYwivvk78aqPuN37oi213H5pRcphEM9qGjxNhaBiB8=;
 b=LBxQdmIbH9kkzAPrPCtEbUGkT15ERUwH8g1w7lsy/T1N7CR3xoRPEoJXI+XOGoHKfs02nlhqkgET/VziQVz393sotbsV9GvueNAMvZIUQf674r5Ad24We38CtQI6cCQ7dGKKOS4z3tSJhGy4q3QuAu/CKeBWcmjMpujEUYhDt4P6Msls9TRAEj4pXjPFyyCxmWceX28pB5F/5nmHrKXLToTI2cTWKP0zll4Y/xfjUVgy8M6Zb1VDw6PQRr8mN816qr6osIlP0/mQYL1iJCFR3MnqQmQnHgd4UKjcCpzUfMhMT03zsMWwEmQM86BVqCX85iy6B4Ci+nmWJnGvmBc09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 PH7PR11MB6721.namprd11.prod.outlook.com (2603:10b6:510:1ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 01:39:10 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 01:39:10 +0000
Date: Fri, 28 Jun 2024 09:39:01 +0800
From: kernel test robot <lkp@intel.com>
To: Mantas Pucka <mantas@8devices.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>
Subject: arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: thermal-sensor@4a9000:
 compatible: 'oneOf' conditional failed, one must be fixed:
Message-ID: <Zn4UNSxi0bAE+kEt@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|PH7PR11MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 77056e6b-9b83-4cdd-604b-08dc97131b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|220923002;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?koGM+F1fjWn3RgnxnwhS5BSFPD/vW5GXG+ZZQDwM2nIGSFhQS0ArSfJKMXZj?=
 =?us-ascii?Q?S75buj2uSA55UXNJaZLJMlxvyLpYzr8ybrpvBcWk0XDTpCAbknM6b9t/YyA3?=
 =?us-ascii?Q?Nyj+OUscfxq7AumdjdJ2igJEcoHWZa80cAIKur2FJ0ZEdBY5D2foEwt2z3dz?=
 =?us-ascii?Q?W47nBi+cMXqRiVmVnAyhDXE0jOPyQXFYDKKAsVETI+vRQpxdNKE4m6VjOh6+?=
 =?us-ascii?Q?LDhwBA6a1AOAzlfkhrIm1HVqm1c8xzw682ttmyAFutgQM5xZOFFHOklBZDxd?=
 =?us-ascii?Q?TD3FUaWiAG5pGk5hdLoZIca6JNpx1OC8frU3COHfCVcvLAUBV0qDpsMdLLhq?=
 =?us-ascii?Q?gHpN9K5EGwrSc2vOUMs+niESfpg/UYBxAmzga12suFPrvXXSyvA2PBnGcd3n?=
 =?us-ascii?Q?57o08ijLvm8op44RCGopUap2paVw439fvNU/6sdiSlsKSmDx1uS9O2eQC8mH?=
 =?us-ascii?Q?FvhjKwmDay+ihcciAOe4UruvTXkwXb5a93zPmwl0uicKw1ks72ugevYW1Lbo?=
 =?us-ascii?Q?VlLYmUrlnuRZkBvJ5pg9KAvLBPazkThCnruFT+p8eITfKG55+H8Rgx8zaim1?=
 =?us-ascii?Q?SDhmZtrjSxVHMkyfPCKY5xNZ/iFXqIghxK0hRgLi37MktPFC/V1Kxm8ELsJc?=
 =?us-ascii?Q?dHc2UeYjYy+gDSmCcavgWbCzKOJeKAij0q8n+55TsUQoIhJAHuJZcgKkjMQl?=
 =?us-ascii?Q?hKjqbUXawC6s47clF9ybUGNWDr0yvMIQZRU6m6bjLnqg2b0lgRGFAPkfXpxM?=
 =?us-ascii?Q?gp66NtlXMQHlvz6ittM2jVRNHTdyQSVdxdD5FU7sY5fWpQ+29qcAYV3zxAAa?=
 =?us-ascii?Q?8PSl5I5Ckr6eCl+jEfeOoXGtbzP0ZKnlOCpmKDehJIyr7YiCIh/v3IRTRt0U?=
 =?us-ascii?Q?JPllsGgcz7WxxAeSNX2+Ydm8tmIixpo+meNqFTN11e+wiVlqBKSdigDIp7zr?=
 =?us-ascii?Q?uwwQhUauqwV0YTe0zpLxIF1fzRQIaTb3jdWfHTBEbu2+vX7IpP88eAxmnlah?=
 =?us-ascii?Q?3g16fxcD/GunhdqjRcktzhlrErZxRqo+8+S+vw55K46/MhrqtAZJ4hHk0+95?=
 =?us-ascii?Q?yxcKhjwXJKAHd6Vi5zcYTnMn7xF9A7WPr9IzGRwGldcmFwlSdifhA2wKXQyH?=
 =?us-ascii?Q?aVodWOTiNai1+p9424vqf3JXRWCN8nX1oYShwwDt2J0XINm4UXmJ4gfeL5nw?=
 =?us-ascii?Q?XHS/ThrfkKAB/j4Nds2cZKMAgPlRDCpEl96DCBYvDztas9fzj62qT2fEWEv2?=
 =?us-ascii?Q?bN96jDm15LrW4AAYgm2LD8y7c/9Skqk/1Qylrpkv6K9aPfJkKnrLcHAkgYuO?=
 =?us-ascii?Q?MzOxIGjS0SmKWM4rBD3zak4qY+yZ204RoMg1bMpIYUd9YGa4SVajvrSC5itv?=
 =?us-ascii?Q?x3tyDL8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(220923002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MblLXiJ8qZVUI9H0fnXImy+YJyki3ZnyM+/bgSSSK0UcpiOm8G+u10/Pwvm6?=
 =?us-ascii?Q?1S+YvMswKP1vO1b0juyWLYiKG8tYpO9O74idQoz764b45m/PCb6IL1XlLGTV?=
 =?us-ascii?Q?SfLHAUOBk9uPUuizwIKx/eHr42yaGhsyrT/zcJKrorY+VA6bS48WfjBX29Yx?=
 =?us-ascii?Q?qYsjIEN9+G9KkQFKrAqqOUY2OboRb1Y5ZHKu0Pc5giXRFrM/d6W5At+RABks?=
 =?us-ascii?Q?01KIkeKdAs1u60DMlzoaZcGBFZi0xxJyl+rz/FBq1Oc2Mz/qnVlbZVzlfhoc?=
 =?us-ascii?Q?911hOKL6MvPOJ+XpFhOz12o2Tn7hnf2kAmG6TwFf/1gSX7hkfX+rvN1J0Zpr?=
 =?us-ascii?Q?PsOV70dtjBjSTOzE9E6Wy0a7Aht0lIYQCDQSF2IHQHkZoKzyEYS1kmImJjIo?=
 =?us-ascii?Q?cbPyK7VYX/B1wqlycyeuSky38zq2NdyLJjbAbkoSvwLgodT9GBR+w9mhE4XN?=
 =?us-ascii?Q?8+X1t+KeebLCWOSnEndj51enjw6X8jK2mg+9jGlmNY9gB6ZPutSMI4ed4p2p?=
 =?us-ascii?Q?Ezin5ApJ1CSp8SGp27Ev2XlIU2OGHqB4HkZOinMSSxeXXjnQXU58dFzoAtE1?=
 =?us-ascii?Q?HhlUDVR4aP7mE4BGaLLcFgcU6qPALsx6K2YYaCaj0nbNHGgFmf3ISlM0Z/Ng?=
 =?us-ascii?Q?wQywlmDJqsM9mPy4CdKt81pjaSinHw/a3r80izDn6qsE+FYT2hhNEur3difQ?=
 =?us-ascii?Q?QBM3eZDXXYOWc7iTJuWWntiqwb7PFC08DZIax0XzO2PLnp5ioAff9FK54/jm?=
 =?us-ascii?Q?fVtXIgBpXBrGNZMi1AHgOHkxMtjxK1RAeoUqJ+sbzKM9Nd0Bkvdk1oEeHBRv?=
 =?us-ascii?Q?wjnOIb90lfhqfNskR1wZS1Zjou+vnhgYjVg1mULQM3Vq6a83NpX3gewMNTud?=
 =?us-ascii?Q?6BwPVnbE/uB4E/YpoGxl43Lb2xnZYnc6STrBjoPCFNtgNDDkkUYEKgo4kEAI?=
 =?us-ascii?Q?6ckD8/jz0iCpJ2ETacmxqn79UeMghhbKx03Car5S9F+wY08AW3eE1kQqH0S8?=
 =?us-ascii?Q?JQ7A9mottAq9e9moT8iYtmWfeuIc8/dplDUDhCm64GPhrrV6ehlG+PHuu69g?=
 =?us-ascii?Q?IfGAiCIBYCWimkIpuuhyDQ4KP9ZCrwMxBoD74ZnplRLAkn8ycmHRxPzSApu3?=
 =?us-ascii?Q?Uep2PhOUUfj0YjZU7HEFNQWk05Qu5lVmV2o+fsaVfEpIgWCmhqHDxeim+4GA?=
 =?us-ascii?Q?792qkjKushtKWOieiumLC/B0M326dQF0ChmvR48CTM7nQvcn5dVnNgxGFPF4?=
 =?us-ascii?Q?ViTX73Q8k+nj5xcBlB75z83rgNLB9u9aJOOAzvBR+hJET55yCVAXgonvnp2p?=
 =?us-ascii?Q?99MC5Fr6IsJPBCNVWOvXzrTrYZW7bgAHkN+gE9nQtImF9UNFFzOdGz0LnPg1?=
 =?us-ascii?Q?9mo5+OYN4cEgVvI9N1xnKs7eZsAOq9vCniRMX8UQDKYSs03tUd4ZZVf5OotI?=
 =?us-ascii?Q?APUpOik4GTFVMsfjw0TJJsx8BAtZEQTDnXw4uAhae7Vv9kHc2Zb4CdBK7r0J?=
 =?us-ascii?Q?CKWlbhZyrhaAaKx+LOpGmnhaQtwLcNEdz4I2gP89+eUD5SyxLQ/Pn4uXe+KB?=
 =?us-ascii?Q?1ADSPuAw/wcjS1tlRF2kxMXO7iXEi1wQ0TBmmMHsZflg9pBZLv8z+S53FhjO?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77056e6b-9b83-4cdd-604b-08dc97131b63
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 01:39:10.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw66flGwH605QccFMlr3m9rrRFoYaiLv7Iy5C+/NrolT8oqYlw22hlhqL3a+3sU6WG+hzwWK9LpbLZ/tPetKoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6721
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d6444ba82053c716fb5ac83346202659023044e
commit: 0b17197055b528da22e9385200e61b847b499d48 arm64: dts: qcom: ipq6018: add tsens node
date:   5 months ago
:::::: branch date: 2 hours ago
:::::: commit date: 5 months ago
config: arm64-randconfig-051-20240627 (https://download.01.org/0day-ci/archive/20240628/202406280455.q9pFQTIe-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
dtschema version: 2024.6.dev2+g3b69bad
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406280455.q9pFQTIe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406280455.q9pFQTIe-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: qusb@59000: 'vdd-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#
   arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: qusb@59000: 'vdda-pll-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#
   arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: qusb@59000: 'vdda-phy-dpdm-supply' is a required property
   	from schema $id: http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#
>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: thermal-sensor@4a9000: compatible: 'oneOf' conditional failed, one must be fixed:
   	['qcom,ipq6018-tsens', 'qcom,ipq8074-tsens'] is too long
   	'qcom,ipq6018-tsens' is not one of ['qcom,ipq8064-tsens', 'qcom,msm8960-tsens']
   	'qcom,ipq6018-tsens' is not one of ['qcom,mdm9607-tsens', 'qcom,msm8226-tsens', 'qcom,msm8909-tsens', 'qcom,msm8916-tsens', 'qcom,msm8939-tsens', 'qcom,msm8974-tsens']
   	'qcom,ipq6018-tsens' is not one of ['qcom,msm8956-tsens', 'qcom,msm8976-tsens', 'qcom,qcs404-tsens']
   	'qcom,ipq6018-tsens' is not one of ['qcom,msm8953-tsens', 'qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,qcm2290-tsens', 'qcom,sa8775p-tsens', 'qcom,sc7180-tsens', 'qcom,sc7280-tsens', 'qcom,sc8180x-tsens', 'qcom,sc8280xp-tsens', 'qcom,sdm630-tsens', 'qcom,sdm845-tsens', 'qcom,sm6115-tsens', 'qcom,sm6350-tsens', 'qcom,sm6375-tsens', 'qcom,sm8150-tsens', 'qcom,sm8250-tsens', 'qcom,sm8350-tsens', 'qcom,sm8450-tsens', 'qcom,sm8550-tsens', 'qcom,sm8650-tsens']
   	'qcom,ipq6018-tsens' is not one of ['qcom,ipq8074-tsens']
   	'qcom,ipq6018-tsens' is not one of ['qcom,ipq9574-tsens']
   	'qcom,tsens-v0_1' was expected
   	'qcom,tsens-v1' was expected
   	'qcom,tsens-v2' was expected

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


