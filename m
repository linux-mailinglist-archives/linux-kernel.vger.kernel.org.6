Return-Path: <linux-kernel+bounces-240166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2969269D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2052B2816DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B519005F;
	Wed,  3 Jul 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1rR6zUY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446617DA30
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040602; cv=fail; b=alTEZMRJgceXtwhNNkVzqS2Vi6/p18Bq6dNUM6Xk7m09qEC7PXKH/PBkz//Arxf4YNfJJPVsLCAuAVb1Lrwig65lcJANxww3tOdbdfuBBVg/GSlRAEpbmkEQAswny02V4VXsJGjmcpgTncBD0q0eb+vsyPojKJegDRosn+CshHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040602; c=relaxed/simple;
	bh=UIMkAfQuccQmcq8f0qItgQHaKq+LpnzjupqQN9oXhGk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCjNvSH/IrfvYH2pG0tnQTPLGVvjggSMyRHuSFbXt/pFZcgvfoyV4TN9vOIvC+6LJYAss8cw3v+TSXqD2q1KAsHoIMBkGS42Trrn9XnthRok9CdmCwFtxPsaSCuYYucUjEibOa/Qcm1XEwGOmWY4bvGnebZ17BOjjy1QFHveWnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1rR6zUY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720040601; x=1751576601;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UIMkAfQuccQmcq8f0qItgQHaKq+LpnzjupqQN9oXhGk=;
  b=I1rR6zUYKPFZsNuLI7vRlXYDm5XkTFAY0oXWipQwf0b4Z0WsQLSiXYYn
   s2MXveu0zelTrAIY7N7cmQqG1maUFMINiMP4nOgU+i+16Pl6nb/pBwo7w
   2pxMlpMJQ21i63VmPfy1JXWFjASYSkMZ7uVrS50ZNZNj9KeMbqGSDw0Rj
   L/fjzY1AGzYn1459ADSU3uEBFliUYR9FhLplRUMkkpBCNlw33hYiNB2wL
   ENDjs9IpbPiwOgM/UUUb2VGwVSU41g3+lHOKGw187h9hFYDvmytOqJdmh
   WyM//kYJFQok1C3ABuFtvMEgD9YWzaHDPgOTFn7Ajok96kdSVOTphQ5s6
   w==;
X-CSE-ConnectionGUID: xvbJuzgDTwusDZ41e69tCQ==
X-CSE-MsgGUID: WeLbKH4XSCCTJQU/2mP70w==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="27912747"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="27912747"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 14:03:21 -0700
X-CSE-ConnectionGUID: 2AhdEa/hQpeoW4csSE7luQ==
X-CSE-MsgGUID: u7icS+4VQ9GZJ8WayBCTHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46518876"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 14:03:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 14:03:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 14:03:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 14:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f82X0pMTlEfNg7txD/fSeXJOCe7Z9QHf5TV8QqZb1nHFQaWRYjTgi+dDaYqLXvE1D2k0Vpf6hN3N22RfKJ3SnnUWjY0SNcaH3U87HMj9cgDgZy/BM2FXtk6u8hhSVLIzLQzf00ygBcTJWgttIPmJ7OmSvCEQGxmGi/wgoksXaIpebTjjDVHjtmcp7/fpe2LnUiY7Uv5E3NP2Xf4o23NDdNVYXjB31ZIOGCQ3KSKyeknrCOIb4g78/tM2DqSx0GT+HcuDW/lAJKvJBnANMRQ6rYSbPRGRqsBynHRk0Yy4tNTpreGKek4ds8+gUSPyT7DP/9Ck7HgB7UPNpJvJ+EvTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4Pzz7HTK2jMJ5NqqHKsPuTTsZfLdSOotN3iqPY8oQ4=;
 b=TUs+T76RCLaGWAcj1DZidoj2kIsVBI5wnTPOoFK4cc67icp91lGv29wt3Uxyp6DFHjZMNF+3HecwJn3B8HtjIxVBQJhafB83pP5XH4YHyxbx5MvJroI+WtPTXGHbH12FtjskZcS7DQcLe8FTI5zWL+H21jY+Pw7YzTONPvny2yhyeT6prxY+/eD1LEdGnO2lynuePesbUrHumdrBnJuRi7M8lw2crDl61oHZAgD62TzFjM7S/9MQo69bXv6cwdYRC6MWE5Bbs/EKHGd8DaSRwo4yM5lGs81mz+mKutJmvntxxxlDyPSHf8Aopew0p6bYbDNy23Pr6KMly9IaobZu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by CH3PR11MB7820.namprd11.prod.outlook.com (2603:10b6:610:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 21:03:17 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 21:03:17 +0000
Date: Wed, 3 Jul 2024 14:03:13 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: "Chang S. Bae" <chang.seok.bae@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, Yan Hua Wu
	<yanhua1.wu@intel.com>, William Xie <william.xie@intel.com>, Ashok Raj
	<ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] arch/x86/microcode/intel: Remove unnecessary cache
 writeback and invalidation
Message-ID: <ZoW8kYwp2GeM64oy@a4bf019067fa.jf.intel.com>
References: <20240701212012.21499-1-chang.seok.bae@intel.com>
 <20240701212012.21499-2-chang.seok.bae@intel.com>
 <0aa05063-c9ed-465d-a7d2-e5fa0bc6379a@intel.com>
 <ZoWZG75hFpfK6kkv@a4bf019067fa.jf.intel.com>
 <6332f158-005b-4c3c-8709-350dbee23f7a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6332f158-005b-4c3c-8709-350dbee23f7a@intel.com>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|CH3PR11MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6e3d3e-0d2b-4419-ab70-08dc9ba39004
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2RkaXBVzxiN5hB7XOLWG0HN5JUas8UM2AiBPfukrTRv5O5Cm20KGTkmWNIAN?=
 =?us-ascii?Q?/Id0pjHQkK+wSrF5RSD1QfKOTVbqqunRDwj9pciUq5CwLsQgl3OUL9YLCYWh?=
 =?us-ascii?Q?uD77WRBJahifRtua5LuBW6YYZtKtyBt4xf9kqgNghJjCc2WyDABESpRvfqjo?=
 =?us-ascii?Q?tRNoPhDLMHYZqoHOPTU1e1WGoMFzkYEnOZ5GLR+vyxNhZIZMvmuQUEmX5Ldh?=
 =?us-ascii?Q?3g4lsG5c9B5j07aqZ8JVySgVkTlbjeIfqOxDOBqe3iC8s1gA9CAYU7/gBZsR?=
 =?us-ascii?Q?TRmyQUU7gSAOErIVcbfCLVB+I9S+Lw391RNSKem+FJWgpp9oti7WOi+GJ0hQ?=
 =?us-ascii?Q?Xmk5l8V28AtfV+SJYea/Ely7/6KwPlmkPVJ3KsxIGKcqHqoWhsC8YreptLjo?=
 =?us-ascii?Q?KZLy2a+cCcXYA9+tpYKCFam7KF56ltauTjPND6NfNXbcRcCX+ea/+SOlAkiB?=
 =?us-ascii?Q?141YAb2upLw2t6em57y6crG/ouyJHuow2fT1nTu07Xwdlavm6hRHXP8G3yRY?=
 =?us-ascii?Q?XRfPuj+0PqAQWIXvrTDBfrPz/Djb5z9hAUIzTU1YpIn/t/1mBXruAUd2VQIL?=
 =?us-ascii?Q?0fSZzaZdLDIeUnS63Pe695fRE6ibj/gsVJmvuL/EjcQkZaiWxWHnDJbWue7b?=
 =?us-ascii?Q?qXI/uuXdq7ucN1Vcm5V2KBtHGM34eN9pel1qJB4pChrlW+qMNmu00y1+n5VU?=
 =?us-ascii?Q?GJ4aKaFFes9k0DPd7lLHfQwoOfe79ww98K0ujtx1dMXB5CN2oZ9pcI58N6+r?=
 =?us-ascii?Q?gplv84o5kB3Igoa7YvLs0phwPPMZXl2ica7E1bYL31/gIk9PpdtuUxlABQY7?=
 =?us-ascii?Q?xWOIDSa6TbrKuKnThk8V92rHRdQSjjpWNSUwr3rk5CpwpjmzcjvJhkRIWWrA?=
 =?us-ascii?Q?wpgFZBGp1sNqaPkgbCGqdLxU8EbvCEXfpwqjqAuab89S5sobaQ9WUREUaREM?=
 =?us-ascii?Q?PpclTDwLCmut9VhT1ksFlIrOYrxSTN1ZHJluVY6xOQmVyMcLhgtPlFJ4Jm+A?=
 =?us-ascii?Q?W69/POWGz2Sj8AQK/O8m+CxwYP0c7InX3wKewnBfaE1XcFndzv0H+PtWYHGV?=
 =?us-ascii?Q?vvqovTcyJaaCL/1nGymrg6eNU8FNbdgtxhkP1ws+WLpf6QGgMvL6PqxXeg6r?=
 =?us-ascii?Q?w8jQfQ4apv9EPTFDsDYjNlwtDjmpfWe7QAfZEXOYQ/r0yB7zXK1v5ydBPzP8?=
 =?us-ascii?Q?hwXnuZgxOFcK6ozJ8cI1C33HeFQZOEMPxhumh00uBbfXWZOUM9Ck6yqAsLN4?=
 =?us-ascii?Q?/gWh0WyI7w/D97+BzP18CwToBIvvkPUPA0e0nt8bjCI1oRqOABPeuKmhqcYB?=
 =?us-ascii?Q?1gsZt+CDNoE/4UWGb76tdymkv81N3tW9/e/sOfYUOxXczg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zYLZYOVxVK9261PnmWjFeCG2BDAvDuAZQBe97sblCfq51lHjPfi4Hoy32Qbd?=
 =?us-ascii?Q?/3SxyRQG07xIfw27MQr1R9Veg6aRtPXbEId9mNeoItLoe0AtJACxROXZTb/0?=
 =?us-ascii?Q?SrXK2TSZIsQjQ7YJnAaN9wiBipbAoZaYNV53VUe4W0LXO8GNLN5uhQwg9Nhf?=
 =?us-ascii?Q?psMJNxEUiX0Pdu70TCRZGS0V6zuj18voxorPlkqutuE9HYCoBWVSF84UtzFG?=
 =?us-ascii?Q?SZRvOe1qnQjq2oKs4fd7kko1+UYyQtP4KqzwJIWdz/Lmgl1IOTxC6T4Y4ojl?=
 =?us-ascii?Q?tzJU/AGeo9mc0xWa+afKqL4FuaDKDRtKmetrQa2vAmqt6OAIK3YUqqtpQ/WD?=
 =?us-ascii?Q?KKST+fEkNf2xnu0f5j7jIuYg30XIhXNhHxU0X4TywTU/wNqgdbmbLbXwDEa9?=
 =?us-ascii?Q?Vxc2+3aK47RvYM6GDwYV3DhiWkFbJ+fg+/f4Zhr8K8L1lq0gOuIR1tn7v921?=
 =?us-ascii?Q?CBbMdhC/9vN+ynTvnhWXFoRdnjAhxLXB6JnYInS6Yt1YLVY4Oep+gGhXvrMC?=
 =?us-ascii?Q?PKNiaeQbWQl+qEz89e15KCUCwOWJEtbpiJCmSPT22KcDB30or9KkouQpoTqu?=
 =?us-ascii?Q?FYzfEZE5qQgP0IInBss0cF1+kDVA357V3K0idIzwaAtvBYswylPwSwvk5vcv?=
 =?us-ascii?Q?fsXgM1sMlOEEhIxXpsUAJCzEPU5ULubxtc15+QFMyfOxw98mbV3Vky3GpzRn?=
 =?us-ascii?Q?iK/YtuuPiLVGKA04yM3xw3e/zDrjevLf0I48PlfS08iPmFMPv9k+LoKuedlW?=
 =?us-ascii?Q?8uWkp0QTbXN3gVBO7LxWmBwuPksdqx6R5eSkXpLF/1OmISlETquFM49Z6Nad?=
 =?us-ascii?Q?exnKIvNfzUQIdq/Anf247CHjzB6ml9ajmrsj4jeq87Dxxdz9XCzTaHCqwaJB?=
 =?us-ascii?Q?UQ7itn3DuqdJSKZ4bjAu2n1WkTfLzJvplUKcm4PCPBoF50dKS7HK+iaEo3s0?=
 =?us-ascii?Q?/HCCG65SNTPHBf69nebedUlHrkEqZ97NihwwddnBzuSj52pyArJaey4fBeYt?=
 =?us-ascii?Q?AF0Ge+kgIWzXcMnCfi5vSaVp2sfk832Df8Q1mhw6n8a86LpgB1LhEbsmb/yX?=
 =?us-ascii?Q?XU5S020RDliQp3l7/P17atyBglkkU9uBHlYbzwUuuI8ZKa8wrGSzNtt2Q4tA?=
 =?us-ascii?Q?Wc1i5TLbfsEcIIRbz6ISaxmVcJkvmw7zU7PKY3sjhC5lfxl5UUxHISqYtNtY?=
 =?us-ascii?Q?inyE3cPVUNGJANHf6lt6uGWFEjxtz6nPeT/1ERF4dlBDAV7z/fT6cCA4msPi?=
 =?us-ascii?Q?/92GiNSan1OpmX2Nic1j+OZbG1epFzVxbGTQI8wdKVy9rEfyQgp6olTlS5Qi?=
 =?us-ascii?Q?eIFaKuNWr+EAUUuyY8IpkwPGmhAD7E/QoAGtsY0FFdw5ywmg1LXjNlqFrqQI?=
 =?us-ascii?Q?PM7Py1mHIxf7766sgkE89n+fkavrw+kuMvs7OWENtJ8PIf+lvxXzotSqpMy4?=
 =?us-ascii?Q?in9ORrykmE39LRm+eG6fPC59gtwsoME1Wgtc6jjwz7k3z/B2WsWh7KSBCHgF?=
 =?us-ascii?Q?hKqVaYM4smJyIG3V9OSJ6m0cLxXsUb8Y3RUaXREdFvfNMCaL1u/JRvF9VhQ4?=
 =?us-ascii?Q?1rngemjE/nbHMFLWf430TIe9mVItw8f53EGozIzC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6e3d3e-0d2b-4419-ab70-08dc9ba39004
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:03:17.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8x++wPT0Zx0vTNLPdV060ayMJjerdqvaHr4NmgKoKh6rRquKxdHrjrBV23AGY0y1PAfuDP8zHO5wFw+8tHb7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7820
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 01:55:19PM -0700, Dave Hansen wrote:
> On 7/3/24 13:50, Ashok Raj wrote:
> > Agree that we must get wider testing. Only caveat is that you should find a
> > newer microcode to apply, which might be difficult for all products. Unless
> > there is a debug option to reload force the same rev in case you don't have
> > a newer ucode to test. Its good to get this in to reduce the big hammer
> > effect.
> 
> Why is it hard to find a newer microcode to apply?  Just because the
> BIOS-provided one is more likely to be the last update the other the CPU?

Yes, sometimes that, or an earlier update has already been applied via
early loading (which seems most of the case). Someone needs to do some
extra work to remove it from initramfs copy, reboot and redo the test.

Some manual assemply required. It would have been nice to just avoid
doing early loading, but that cmdline (dis_ucode_ldr) disables both early
and late-loading. I had some patches a while back to separate the two to 
help with this, but I never got a chance to send that out. 

dis_ucode_ldr: Disables both early and late-loading.

-- 
Cheers,
Ashok

