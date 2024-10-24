Return-Path: <linux-kernel+bounces-379043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36429AD8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96100282D1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11186AD55;
	Thu, 24 Oct 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAorE3Nx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F93848C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729767; cv=fail; b=csmv1fz4/cKWnRWcb/Te75SjO1lnoVpAn5J/gG8OOqBkSHC6vicsjBSmxuT0RQl1y+3nhJY/aIe2b9HT5ob9tNRRh55r5d8pFBIJ7HqdKzsOjEX2d8AjH2ZGElZmur/PMRN4pSRG49kqiZY1rwsd/M0q3rhMlHJVntbY631sQ5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729767; c=relaxed/simple;
	bh=OPsgXG69ctatyL9n/bg/Mge/pe/+95fQit4ZReyg/NE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7VUn6CJ0mMrV5fkfGpyt3P0icDcAz9Y6uqvT5j8eD1tWdclswYSgj4KikWYKs7YJ5DFJE8rwaTxW4Z2s1Dr5mO0wufsh77gyszhLvH2vXaw2X2dgUTWn50t/4Ejb07uc01/l8A1S5tyk4oEKKDs51QQaDOYjf9UEwYhXJVOzIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAorE3Nx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729729765; x=1761265765;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=OPsgXG69ctatyL9n/bg/Mge/pe/+95fQit4ZReyg/NE=;
  b=mAorE3NxwB6a+KDdrxqkUM2KCUDgWX1lpZTANe2JNcpM111ZSDZRubjX
   5Omyj9Ak7IgmKXxPYWViVVgQXeo+kFaCe7QsqNZ47ytTicZ3ccluJqK2t
   xbZ856UJr/3Ce30foVV7URFdreBPudp54OazICSjuSMi6IJFRh3Fptbt5
   azIL6D5WLF4TCUApKryoA26Vf+6Nu/lrxK2PhKVAUgIagirDlOisf3uaR
   wexKdcIEaNTlyyB1FuYlcA+9gX0D5hCGhqe52CKdPgq6Ropq96e4ONCfi
   OfEZk4N6mcHFIgNLguaTyfcjQS6B2nbWbgVolBvtUmWweijCtZI33whor
   A==;
X-CSE-ConnectionGUID: N/dx5v1tTky5VZQX4+C/lQ==
X-CSE-MsgGUID: D945r4qWQUGe1OpM2rZsNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39927625"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="39927625"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 17:29:25 -0700
X-CSE-ConnectionGUID: 6+RYJlGcQhOGOH5E7lUkaA==
X-CSE-MsgGUID: KByEDgiSSkKkl3j9aXsJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85211431"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 17:29:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 17:29:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 17:29:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 17:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H80t0fBxHs2h1lj1UFHJ4dlidvgClNhz45/OcKwaWIYZl+EpplUG7sIYa4r4JekKAyhYXNT4oJ9QGE++X6cFiqJ0Z4oMw3CWlk8ATwgHBgEKOjSd98N7jtNonM6bhmChoqh/pMKuMXxiLuDEFduoh2/EWv9FNSgcjWxP2ou+VLDN0yIK/4gA/FxdWI2ZXewWYs21edUJnvAtnnqXAsp5NtoR6iBOSq4Y6c4veTmQihH661pIxiIuQGo0bz4yY70KR+XU0xhCJZo/y+gj/LAns5bNx6GuHjn87r5VUzg7g0lJ8VCzIobJGG5Rp0RuQcy3ICZs1vBrjPXUGI7xNCkkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkNWE+O0CoBTvBHM/k6vCnLeDpJ9P2nCkTzT9VbJyuc=;
 b=oMchEWjKsDOjbIeywqCOCXNY83pDxCLDa+7UAxUDRGE37FhL/8RE892qjO5nIISOa/9VU6Z68zAqGqXf3SO8gLgjsoA+h7geo2pagW5JcMtmQfTnKDydGtFn3RqZgPYTUlCXrWwn7dQgYC7+nXoj9jT7Td1/9RD2JXAL7GwzyGOtvGXUAw94G5y1cUomXb64cbomrJ0+zaWxkqWyaFWRnQltxXgTHynta8wxRoum37f2sc0e3eVs6lqnOCeNRft3vgPpZ73i90QUSWFMkOGaKvMteQ5/nafHRS0MIEa4AO3SkG8Cmt9zsXMHo+PT2J3/bSApWXkcigMP/Q2XMA2ymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA2PR11MB4810.namprd11.prod.outlook.com (2603:10b6:806:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 00:29:21 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 00:29:21 +0000
Date: Thu, 24 Oct 2024 08:26:59 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, "Kirill A. Shutemov"
	<kirill@shutemov.name>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<x86@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ZxmUU9riSUYmodGU@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZxmRkUNmx863Po2U@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA2PR11MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: a00cb176-928b-4122-9604-08dcf3c2e77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U1P6S0Es33YT0va7ExRbVcMftXWW7KRYipK6/E5x6ovfekbUM7ytM4YV0OAU?=
 =?us-ascii?Q?8v3p7w8zTiCXVCsrbaLUrihUbksFmqwYaxqFNszWk0LJf8G0IQxUguWnBddL?=
 =?us-ascii?Q?GXcseS9OvA/hjvGOGzWRRia3MIxov1URD8H+xWhUcsaVHJZiR3a/sp+A2Ghd?=
 =?us-ascii?Q?P/ECtsj0bAEC+HmunKIpN2+DKyb5ikuZO5HXvBK0AH2xgxY6pTKoa/xBlRvY?=
 =?us-ascii?Q?ewH+i+tX6Af+m8i0O3iIGVq/vBtbAS8vuBDrDwFaV50BEVi6ueKCiY1ZT1WN?=
 =?us-ascii?Q?N4yE4BO/scip9oe+IqTtMehfVW+UqTNu9rttHqkm7eZynUHqm1WJbQ2F5eaY?=
 =?us-ascii?Q?VMlWPRnOyZbHaZSYyyHYfKA0F9//2ocjuQNBDGwpjmJMomM0p4zanXxZ5pcB?=
 =?us-ascii?Q?1yInsKIzgviTGGW9DVBwED/y7to8rS9RQ34ZchX+XcC4Q4mm54GR0ruEjv/2?=
 =?us-ascii?Q?uwCCFqaACn0Ky0pJ+YDWkXv+k7fiGXscxN5NRPFuo740XeNw8PVXDBXXXoIK?=
 =?us-ascii?Q?I5KV4hKjHu/6cHDeYdxxxzR6bX6mOGvvmzwu1FhIYE7Z0aO2UYgQneuk8GTm?=
 =?us-ascii?Q?YSGAVytDrjGdB7xFUEqJYaP6eEfPz9/tAeRMLtxA7+MG3LjVodi8TDXRuhjg?=
 =?us-ascii?Q?X1YjoaPHJOAsVv+40xN/7vgW9pBypEwHOaMRNmfGxLyU2FOXhXYUoOo8uOd1?=
 =?us-ascii?Q?9W/N9EOZve0yYbU/xoiYv5ZGeWWy9wPGKHiy3nnP6PtcRc9N+stxyY91lfXq?=
 =?us-ascii?Q?71bnEEq50980PGkZidEOotwJqelC7Da2Jwc+w3t1YLiFG8ZsGqZCrr4INub/?=
 =?us-ascii?Q?NtCYKvj9sbH1H9JSScRZsLcpuADR6zNpg0W1hyBAgf6yYf9prJCecdTLai1g?=
 =?us-ascii?Q?33sdwre5IM2LWcM0OQVUPbCrH+oxuXs7N+7vzk7obN72KF3C4q4EDLqswZiJ?=
 =?us-ascii?Q?jx5omel7cCYwV3lasyTNbN4noO/pk8LHlhCuEAvSYTF3hSHp+OdMeZHKRyt4?=
 =?us-ascii?Q?VMmEjjF0uu/mf7MH6yR4hGusKO3YPC8vX2kX3A67e8hL6tqXze5BiR1hW4Kk?=
 =?us-ascii?Q?L8dmQ+7sC4wo06PyNWOKAGlLXSXvcSJBy+l/3oITJSyZ308YecyJqKxBYy8W?=
 =?us-ascii?Q?OvOcOvQuHHNGMoFrp2eu7g8chEkMVTj2815XR/LH6buGQ4TsXvK4J884MdfO?=
 =?us-ascii?Q?2vCTp3Ye2XnceZ6AkehoqUrdWANADLc+9aa4HqjQxUO7c56jbqayujPkZOMD?=
 =?us-ascii?Q?CZoToPv4uJwm89eVrqeu+5VrCd37zkTki0hQSAXqG7rFHK2gUxeNK8hvr7Cu?=
 =?us-ascii?Q?+NsTWVUkDau1MksCqNRLppjG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7P7pWQJiAb8fPibXUZ1H4V+GbAfPrQ3jgV7Alf80kOOtoJt1O/XdPw92Xq9d?=
 =?us-ascii?Q?4OBGgZ9WB8T0k0viSIXCpf6C99DCDXV72P0UXzFtSx9HxwLAzKFHzAI3pfiG?=
 =?us-ascii?Q?2FKjN9DujFYIq1cqAXP/V2yU6yYeWBIPqCc/WYNccmAGHCw2206/VVzVGn1M?=
 =?us-ascii?Q?ZiVwSn46f6UL9R+t308jqA1EYIKDUYRPYi3WwfYsKrLxtvdDzEYPvzxwAB2f?=
 =?us-ascii?Q?pSG9NWxc0VYKd+acYilNdbR+DvZbma3RhEX2F5BJPyNBqjKDq2beUfY7Novv?=
 =?us-ascii?Q?md4/A8woFepNVglQcniTCWDPkzjZ4ImF1yUVakJIWENWgpX2/zlWUC/P4uvV?=
 =?us-ascii?Q?z0KiYsfYmYf9wLMfcNvp+kqM6TN0pslBNodV3oW8j36m14C/Z++tlcbkAGF5?=
 =?us-ascii?Q?OMpLhKABdGsp+JNSuOB/u9upnIyeaVHH2HH2qXlbXZytqJ4D1JAhXu9hpkmR?=
 =?us-ascii?Q?nR6E971dSPPWCNoaCgML4+dkq6H8Wp3/IfC71h+UwZTsLp0G5dwyej+7d561?=
 =?us-ascii?Q?NOGSY5Rx52EN7+WSK/VvBuhCiRhgJFrzFYBYUYPN3yqHbDaxUAaf8O3eoEre?=
 =?us-ascii?Q?PTczpZ7fjKhKcF+lPBibQhdxQ1sftKw4M7wDekDjjRBnCGJLjGI+zNtUeNBl?=
 =?us-ascii?Q?oKiGmE2KVKVceqeXOn15EWj8BKZDEik6vBumJLHvFtKEv599RNMV9HNuD7FW?=
 =?us-ascii?Q?uBFVF6/XMYAIspV/j7JvVAtBa4SBz5zy6gYYKr339tVQ+rp3ivEKpF3rPfDe?=
 =?us-ascii?Q?glG16xxLt3jeSj2io4zLJbbMR5S4Gfl6on3u4XSN1inui2SLW8iAH9trDFUB?=
 =?us-ascii?Q?/DX7AWt8gfIER1V+atQOM7iN1eWnw9RRTzJNkYBKAjNFgyphoWAUiUkvmxkY?=
 =?us-ascii?Q?sORqH9YP3UhqOc5yz79kgRvtotaZjEEyogJiNcHMh5HxJ8kyWxmx5f7L6p2U?=
 =?us-ascii?Q?VfYU19E7ONYpEG0xZ3gmViEg+fjig8DNw6kTAaIKlXrvr7VgtFy52NgyvnHW?=
 =?us-ascii?Q?svSdwLcnQTue8vXzTNlV/PH5erKUkQnAn13i29qvgK/noQamYE3Vgk6gsrDP?=
 =?us-ascii?Q?J+hQ+IG4JFfbVwPhSbEcTkMnUrF0nR6yOdssglIgLROa73DtiFeBvrsjWuX7?=
 =?us-ascii?Q?exhOUP6xo3iUunnU/mwpPEY5akUdT6179bjBoSspZr2bYqLrDGL+T1vd3seJ?=
 =?us-ascii?Q?AFUJO/DS2rAkayjdYBUn5bVpup82z9qqP/d6ftuZh9P//EaPl8yI5W85FLt5?=
 =?us-ascii?Q?xUVnz8+ItZZ3yVGnYkrDrQutlCycHaqKs/MnmzrrKfPWmaV9J7uopvcxGwWw?=
 =?us-ascii?Q?4ONlLs/waqY7KY6BwbHMIU7kmFG1qKYcMdYkfIenRtd+19WgRcpLI2k4vCLr?=
 =?us-ascii?Q?sEWOxM7841r35fxmBDkZ+c4CwvW6kwgbT5pOTAwRf7E75R/R0+8ZvXOvegLv?=
 =?us-ascii?Q?DAvxzV52rq3Jc/mS9nBSHcrUme3ke9T/8VkER4+hEKEl5N5B6UdYPO7WscVE?=
 =?us-ascii?Q?ahQrlj/5N0keuKouZduNR2xUnVj47mTvZdtbTccEpOmB+tnG6lN4eKWNG16A?=
 =?us-ascii?Q?lUgS+m5/xOkjSvUH5f/VBxyW+oUZ5AIs8L+DU9os?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a00cb176-928b-4122-9604-08dcf3c2e77d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 00:29:21.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6kth9Yy8eBD1XkNQvPVUmOfrSFqX5n63Aq2sjnFbg7en8jFOiXPiPFyoDSmMRshe5InryxNFSX6H+YCZQbl3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4810
X-OriginatorOrg: intel.com

On Thu, Oct 24, 2024 at 08:15:13AM +0800, Yan Zhao wrote:
> On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > 
> > > Waiting minutes to get VM booted to shell is not feasible for most
> > > deployments. Lazy is sane default to me.
> > 
> > Huh?
> > 
> > Unless my guesses about what is happening are wrong lazy is hiding
> > a serious implementation deficiency.  From all hardware I have seen
> > taking minutes is absolutely ridiculous.
> > 
> > Does writing to all of memory at full speed take minutes?  How can such
> > a system be functional?
> > 
> > If you don't actually have to write to the pages and it is just some
> > accounting function it is even more ridiculous.
> > 
> > 
> > I had previously thought that accept_memory was the firmware call.
> > Now that I see that it is just a wrapper for some hardware specific
> > calls I am even more perplexed.
> > 
> > 
> > Quite honestly what this looks like to me is that someone failed to
> > enable write-combining or write-back caching when writing to memory
> > when initializing the protected memory.  With the result that everything
> > is moving dog slow, and people are introducing complexity left and write
> > to avoid that bad implementation.
> > 
> > 
> > Can someone please explain to me why this accept_memory stuff has to be
> > slow, why it has to take minutes to do it's job.
> This kexec patch is a fix to a guest(TD)'s kexce failure.
> 
> For a linux guest, the accept_memory() happens before the guest accesses a page.
> It will (if the guest is a TD)
> (1) trigger the host to allocate the physical page on host to map the accessed
                                                                        ^^^^^^^^
s/accessed/specified

>     guest page, which might be slow with wait and sleep involved, depending on
>     the memory pressure on host.
> (2) initializing the protected page.
> 
> Actually most of guest memory are not accessed by guest during the guest life
> cycle. accept_memory() may cause the host to commit a never-to-be-used page,
> with the host physical page not even being able to get swapped out.
> 
> That's why we need a lazy accept, which does not accept_memory() until after a
> page is allocated by the kernel (in alloc_page(s)).
> 
> > I would much rather spend my time figuring out how to make accept_memory
> > run at a reasonable speed than to litter the kernel with more of this
> > nonsense.
> > 
> > Eric

