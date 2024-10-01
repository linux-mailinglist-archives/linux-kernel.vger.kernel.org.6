Return-Path: <linux-kernel+bounces-345457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2698B688
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E71B21B98
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12DE1BDAAE;
	Tue,  1 Oct 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhYuFtLW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8DE1BD005
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770100; cv=fail; b=re6K0CW/r1uJR3qPQ7O/Ezvq7/dvvbUa7bLQY68b5PtRB6z7cPRSzmYJbfYK4LRk+3r9SS7ZsE7YEh2sl3wi7eXTy3qqwOegdsXITK7LIE+rzoT0FlplLKPfQJeX44UvfGQAFOQhDo9W5aM/jz5YycETIhgpV+ALHO0vfV9Czz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770100; c=relaxed/simple;
	bh=kmoIDHGFDQVh5nz/IwKh+G97XhZsjLHfnIsxJYzxo5Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IDHQgKu8b3QC4tt3Rk099eUqD48gB2R72TOgCcvsfkQI6syPgFszo4Z1vWsflOZ/J4Koo6VS6dE9OwX1SBj/mJYCvUHVLVciFjme9izGhe5q23NmMfBjEP8dbpyPpHrDtjjanio7eCNeNfYvUEraUeeslxLHtToQkJOCNakcwAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhYuFtLW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727770098; x=1759306098;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kmoIDHGFDQVh5nz/IwKh+G97XhZsjLHfnIsxJYzxo5Y=;
  b=DhYuFtLWSGKG0fVZzl6IlyOHY4/E/8QKMsTjXQ5PKzxWcFThZuptmDMK
   U5UrFmcAm6gP5Z/EnwX5lryRXh2PsQ1GTkMvbaEN/bYKn9ymt7OEoXCmq
   S9d3E8QfXTyDyDJaaatucGD6Mx3s53Q/Sg3CO1y3j0xCzIKGGAk7EC4Gg
   ltQddCgh74VsahKf/V/p/C5jUFz/OTNSW3w7lkgGbp96NEYwc89okzxt8
   3B8oK68a8WjYCKs5SVZGMbdr/soth8XDQhr0VFzJx0ZxKFwrde4FliWZo
   3+SuT8dOehqo1Zu/8Iz2R0hx18dPp1OqNAWQF7cQOI7rwSILLb9lqB1fN
   A==;
X-CSE-ConnectionGUID: e4EuSatrRUiydA80GAW7WA==
X-CSE-MsgGUID: +VWZDZTAQYe7y/4+kx82mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44350623"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="44350623"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 01:08:11 -0700
X-CSE-ConnectionGUID: vZJH6/kKTB22+b2ImFrbrQ==
X-CSE-MsgGUID: iSvAlnJWS5K5BBlOG8LPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104364126"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 01:08:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 01:08:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 01:08:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 01:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=af7iKRF5TY/E8Hi7BLRbT6KrBmkm0HSVZl1wZnPAD44tZNNN15ht39ovIYIBuOkuxDNkEJPjjwluHrxsWKVedw8DlhRv+1YyLWCQ0N3gCFV/KPL0tDEAtrC+VF5414cWakeKfUxa8DZugEA5dp9VkwyUEcY16dwhWNLBL2JxZeoLZ76ZZcl//gNRth0hCHko649Vc8Ptq7ZfIZFjdNjjNvjkZwgS7d6wIswCJick8cvFf6pNA6BPFG7Qr088PmPa1SMBGUnpvlRZxdDOMOcBLZvrWnx0q8MvyDwrIBM50nCh1B3+pH3Z3IvopRIunufEa8SVnuYn3lROABclMb0y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BijKm30Ncb2gyfWPTtKwA1zMEojfm69WN1JF2WZ1zS8=;
 b=QnRMM58CaKzxzT4X9jZ6FIK2mkaFlR5LQLXqP+MfxWac8N7fpE+ZNIBsRrppPtKozLfZbgW9QyloGRJOLHF4szNpsyiCGs702CJrR/Rntjvzp11WR+ezRRwowhB1AGWWeiTjK3ES+WS8DUpE2YMquI+qy7Q85eF3XnfG4PBpD8ZtEyOmKEMIjTk/w4h4AlYLuBjxoI8pI4ZluLDebwKahD+M4WlMsa9oAPj5MruR19WPef+a86dp9ySrshGa97lnT9/LIvrRisJvtAfU4JDdD8H6tP5U65x9tHZuu3gu9f46MaVR+eg4y05ahP1XVdU5WVRfg+7sKj9GGdmg5s1f6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 08:08:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 08:08:06 +0000
Date: Tue, 1 Oct 2024 01:08:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: David Hildenbrand <david@redhat.com>, Dan Williams
	<dan.j.williams@intel.com>, Huang Ying <ying.huang@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A
 . Shutemov" <kirill.shutemov@linux.intel.com>
CC: <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Oscar
 Salvador" <osalvador@suse.de>, <linux-coco@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Kai Huang
	<kai.huang@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
Message-ID: <66fbade318730_964f2294d1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240930055112.344206-1-ying.huang@intel.com>
 <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <66fb9a89dd814_964fe294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <c9dcdc44-7031-4541-96a2-70a071accb61@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c9dcdc44-7031-4541-96a2-70a071accb61@redhat.com>
X-ClientProxiedBy: MW4PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:303:b6::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c087619-7100-4cb6-726d-08dce1f02de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvL0Zb7olfnkjFZVdwnBSE47a45LNrmLQXAQaEMzi8M4OMEM4F4mXnYTkzwo?=
 =?us-ascii?Q?jSxc7xjRJq4KT/xr7l2GtCaHztqD5gExw8jNQfPNGTmnor+zkGpaun1JJmRh?=
 =?us-ascii?Q?xDUCeowT6HcamVv9R+wNI/xrbFtWZKqLtR96XC70uKWqNBG24ukvNSR03l++?=
 =?us-ascii?Q?04xXz8JbD8+cYdB583O/4m2hrNmfaIDznV0o/80KYtGE8kUfTwhu6reyJhTM?=
 =?us-ascii?Q?CbWSi5bIW017c19lli+y0DWYUXEO/KF5CmCCCPFRstnZuyjafP9TyGLijiO1?=
 =?us-ascii?Q?OkM63QEAQN31LfX/Lrz4nKCsW5yUNKqurq42v0mpDvQnPSLpcpQpDEG4hMC9?=
 =?us-ascii?Q?APjMpoM4j8TIEzrgER7O06ltkNlEqmajBp7k04LN4+tclcYULvHFt60vkwWw?=
 =?us-ascii?Q?ceplEWGmkZgy6PUQ3+khVrFQWGFiJKKuOpZzyX/+Hq3CpqSqjK/8jXIYAvMj?=
 =?us-ascii?Q?SxUUAATG3pL7hUwhHFd7eGoGVpTCYJQukKXKfGKmigXIitx2QK1UdxMRvVsC?=
 =?us-ascii?Q?J7Dbvid1GL7ZbjdAzcY/0Je89XEi3oCIWgiPkLiTOf0e0TWRDe9sb2H5uv10?=
 =?us-ascii?Q?N01RSGdp1LQnAY+aHVxEM5ACQXA2rU1GbVAZvOfpiIUs4ZVIwlDohCKsgGcq?=
 =?us-ascii?Q?pCnBSQ7s7b9dQNUehusYOCrAxrJJREdLCm0nbLFX7BE9Ui5ei5pPiPY5K5c4?=
 =?us-ascii?Q?mNV43Moza1E86pY/uCxyfIb0VKJT9rrNLUDa2hnLeWdVLET5MZYmYcdqT659?=
 =?us-ascii?Q?xgHyoC8rsXN0KoPe8bu/t1y+XdtTi+XzEQUj+pI8MmuLF6/qEL53yYSyItdB?=
 =?us-ascii?Q?T5qzJx5aVbwm4sv4cex0NKBcyoUuHgoV/rfGToSdFO78kpoULn5xXTE6NMKN?=
 =?us-ascii?Q?9XSXLjUJzrZm18RTvSTSfcpYNWAa+sL1dQWjOd61laccl1Zx1nIr46vDwtKw?=
 =?us-ascii?Q?f1xe5ZCBK+OG47cfcgZZ7FqYnHgBxAfyCKqDlxrDM8xUSH4GILOe3msilCWd?=
 =?us-ascii?Q?4nivkptibF/KQGAZmJhbbgXR2vok9C6Aj62qPSnq0+v6c4cMnZzMlmOWWTy+?=
 =?us-ascii?Q?jM/SaQH6/tSqbiDCPZcrs5WPV0YokrIXpwoNU7Ep7JVk9g/UoF0KXN9Pm6eM?=
 =?us-ascii?Q?OnaM3+xTTwK8ReXg9n2MAzO2jamqx52Ku1dI4s2y8vAZA+Iz2/SMwFnrenla?=
 =?us-ascii?Q?14WqtZt/bj8S4lGYZ1k8flreLXDBSuZOElBp/w6/usPhFZewz0658NS2qtNf?=
 =?us-ascii?Q?MjJpmSRoxq93LHpfe2Blk0dJrXHJZORmY/OkBxxn8k3+YhiIllMzhzQulU86?=
 =?us-ascii?Q?xJSVnJHVSZ51lA1ZA07kK4zgcgkiGNIRUtfKDKglMyVjJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qtne7AruQKdmns/uHOQOSotQfmwptzskMJEJQlU7zuBC6NVGu53uRHaLgkDi?=
 =?us-ascii?Q?6xisEVFVbjLkB1Y7N3Qw18wyCLbLu+TKEMZsIWsFXdATmmHR2Nvs6OxtGgro?=
 =?us-ascii?Q?SoiPmzBDUGkKcZOyULlKbISDI04XCS8NVqcJntqOOzBtZetoZfOB1JYdOz2i?=
 =?us-ascii?Q?CpV5sj9VHJ4WI2hgLnCEbIK/TIHgK6TwSdni1hXlinKb4i3AjoYZd0rhXNZ8?=
 =?us-ascii?Q?K0ttGMJhJD09giZPfedFwulnIv2Opf08iXbj1ZsRZpPJgrFJhPMqwnYWAbol?=
 =?us-ascii?Q?C2s1v5rEVTsNFcM37FYusL9g45koKXvmleHZcjoLxZa8vwRn2vQfBYkuNgh0?=
 =?us-ascii?Q?PBH3r7ufV8+vGjY4o09FYK50JtgznuLOKVlBsXnvXZHd3JmQALx3nyEeGZVs?=
 =?us-ascii?Q?0pKyeLeEjC7oNsehogW5zzxoeEhIVkH6nVx/OTG678zcvdJu+uFrCet8LNb2?=
 =?us-ascii?Q?N+B6r8DIGiO9j3MAyycoVZQ7Y7GsfoqHp9ojofw1dhSd7oKln7zWLszw4OCw?=
 =?us-ascii?Q?wrAkhV8X4NUfpovRsR6KlFwSzRiz7A6YXTUXZsn1qS4Xa+Hd4ioEL/W1Y320?=
 =?us-ascii?Q?WB3U1B9oEZtlAnqIYqgn7Nmu9gQQA/CpQHSlAM2MnOqmJo7aM4W09l7e/EBL?=
 =?us-ascii?Q?127+o5o6fIWX3OBbNZmgf6A+nvdwswrpsoHttFAymePyPBRejjOZJuEI+5jX?=
 =?us-ascii?Q?Atw+rUV+2a6smD2P1Oa66kXThw//CT23ZmselKjvon5shI6R9rLFYFNkm//+?=
 =?us-ascii?Q?UIABO+nnAtZROqZ1kCmP77+RF3g8H6OVM0/gzo87GFb9EiBUN68zQK4+yCPN?=
 =?us-ascii?Q?oxXmy/lzyLDvxnkw4nxfZPVb0UZ2eH7DRu6qEaTjMS26cGfch3WNdgO/vab7?=
 =?us-ascii?Q?OWW5wahcNb8u+n9ib6nklrPX9RTi9/C8EuFc9l9rfiPRXgxHRkuunL4+puoN?=
 =?us-ascii?Q?Jm4GCm2SybG4gmQB9dAvqJZczFxtPpPWCs3rSfsKZlXwex/NKvvmT0lT+gK5?=
 =?us-ascii?Q?vIa9S7eHIM0kK/0GPeVrBX2g5NtMakEn2u5PI4IsWrIcWvZfVyTCexrgWSFE?=
 =?us-ascii?Q?jlg34Cw0iwzxxRgL2hQ1U3tgLNV85nh/JH9cyN7FcrWZxjAaXUwDG7cvImhR?=
 =?us-ascii?Q?exlAnIRHnd6C3yXJLSxNe/O4u0MPv/wAeGu3AZSGkbCINUHgD+yudLcVtQql?=
 =?us-ascii?Q?pXQY0IMkRbjqDFvsVFA9edJ6egAOHWYVgDb0lUOVc2piq/2TF2hESrG+edBC?=
 =?us-ascii?Q?qJ1x8IjDT7+nP8Fs3Y1FJUgPLlFmyztgtoYcDay8a6n2naNX/vuqRef4LzHc?=
 =?us-ascii?Q?FxEBZLFGAFTD5F4pqDHAwrjAONW1KxzgiFQ6MB1TwrTLAXU74RFTNqgkLNja?=
 =?us-ascii?Q?vp88eygf206vPQTpLQZstQLLED9kK9nfgbG2yXe/o4K8+wY0Xt4z2Su3OSoq?=
 =?us-ascii?Q?M3zY3aQYznaujCrJW5fP4RG+joqW2JOrhCEmfu4MLuFTantu/E2m6Hsy8mq7?=
 =?us-ascii?Q?ADdkA59APKrWiQH6Zu1hsFpJZENi8LH6TRhtlK3P66bSyUabgVvm6szv0Wut?=
 =?us-ascii?Q?1h9P+UBCmPr268E/HJuWfBQo2N9UMyyVyJlCxXpzB+v0n4kF0Y8Cvw+okxHU?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c087619-7100-4cb6-726d-08dce1f02de5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:08:05.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tay9cnhYfux0OH7/EhkMx1dxoj2McU1NtRKY1sJ2p8mdsEVSg7dmbEXQUxRSQQNd678T+vo06jw0o/At+8LrvnMgoH1/hTEYc6wH0P8Er0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
X-OriginatorOrg: intel.com

David Hildenbrand wrote:
> On 01.10.24 08:45, Dan Williams wrote:
> > David Hildenbrand wrote:
> >> On 30.09.24 07:51, Huang Ying wrote:
> >>> On systems with TDX (Trust Domain eXtensions) enabled, memory ranges
> >>> hot-added must be checked for compatibility by TDX.  This is currently
> >>> implemented through memory hotplug notifiers for each memory_block.
> >>> If a memory range which isn't TDX compatible is hot-added, for
> >>> example, some CXL memory, the command line as follows,
> >>>
> >>>     $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
> >>>
> >>> will report something like,
> >>>
> >>>     bash: echo: write error: Operation not permitted
> >>>
> >>> If pr_debug() is enabled, the error message like below will be shown
> >>> in the kernel log,
> >>>
> >>>     online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
> >>>
> >>> Both are too general to root cause the problem.  This will confuse
> >>> users.  One solution is to print some error messages in the TDX memory
> >>> hotplug notifier.  However, memory hotplug notifiers are called for
> >>> each memory block, so this may lead to a large volume of messages in
> >>> the kernel log if a large number of memory blocks are onlined with a
> >>> script or automatically.  For example, the typical size of memory
> >>> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
> >>> will be logged.
> >>
> >> ratelimiting would likely help here a lot, but I agree that it is
> >> suboptimal.
> >>
> >>>
> >>> Therefore, in this patch, the whole hot-adding memory range is checked
> >>> for TDX compatibility through a newly added architecture specific
> >>> function (arch_check_hotplug_memory_range()).  If rejected, the memory
> >>> hot-adding will be aborted with a proper kernel log message.  Which
> >>> looks like something as below,
> >>>
> >>>     virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
> >>   > > The target use case is to support CXL memory on TDX enabled systems.
> >>> If the CXL memory isn't compatible with TDX, the whole CXL memory
> >>> range hot-adding will be rejected.  While the CXL memory can still be
> >>> used via devdax interface.
> >>
> >> I'm curious, why can that memory be used through devdax but not through
> >> the buddy? I'm probably missing something important :)
> > 
> > TDX requires memory that supports integrity and encryption. Until
> > platforms and expanders with a technology called CXL TSP arrives, CXL
> > memory is not able to join the TCB.
> > 
> > The TDX code for simplicity assumes that only memory present at boot
> > might be capable of TDX and that everything else is not.
> 
> So is there ever a chance where add_memory() would actually work now 
> with TDX? Or can we just simplify and unconditionally reject 
> add_memory() if TDX is enabled?

Only if the memory address range is enumerated by the platform firmware
(mcheck) at boot time.

This will eventually be possible with the CXL dynamic-capacity (DCD)
capability once CXL TSP arrives. In that scenario the CXL DCD expander
is brought into the TCB at boot time and assigned a fixed address range
where future memory could arrive. I.e. the CXL device is brought into
the TCB at boot, but the memory it provides can arrive later.

> > Confidential VMs use guest_mem_fd to allocate memory, and that only
> > pulls from the page allocator as a backend.
> > 
> > This ability to use devdax in an offline mode is a hack to not
> 
> Thanks, I was missing the "hack" of it, and somehow (once again) assumed 
> that we would be hotplugging memory into confidential VMs.

When / if dynamic capacity and this security-protocol for CXL arrives
that may yet happen. For now it is safe to block adding anything which
mcheck does not like which is everything but memory present at boot
(is_tdx_memory()).

