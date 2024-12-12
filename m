Return-Path: <linux-kernel+bounces-443153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796849EE807
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447991889A13
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB02135B5;
	Thu, 12 Dec 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+BYnp7Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063120ADCD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011250; cv=fail; b=OTiiOqzJ3L4kOULoiW890B+0XcVJnMCDoaZowcb0Jt/n62Kb/l2EZSgWVAG0uLZimD0f39vFmjw8qj6kii21e7sHcXz7uScW0Cih6l08gfbpgrSogDJUXHUJ5yqamshuQhLulO/mZ+TxBf7O+smNqup9t4IFmVVeUJph40Yyfb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011250; c=relaxed/simple;
	bh=nWPb9Rlx+V411u2JvBXGCPyPXztKsYmPDhksHsbxmI0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EyrgKusg9kjzV3XJTCP0Ud4xK+Qpk6d+dHlJE19SPSc0XVKVTiRDJdG0sLV/bGBWsaSF7O+zpof8BvPZS/Ox0V3dc5Ch4+GUqMV+8l1Izo53iC+EdffNLfeDqJiKg7gvdxUXiS0mBob21j9OljRZDMfzpUbSJlawYuZ6B/HCmrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+BYnp7Q; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734011247; x=1765547247;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=nWPb9Rlx+V411u2JvBXGCPyPXztKsYmPDhksHsbxmI0=;
  b=m+BYnp7Qmg/OUy6mICQn7yDWL+84UXvt1zjzGD3fLzQp/eljv6aNl+3O
   GLoIOJzrKQNKXV1J7pjLUArX0Aucn72l3hsloKBrBpyluanVUC5YjLvAw
   aukXfujaLV0s3FoaZvCsCt4tZpOL2yL3p0DG9inFoQrjMGAdRXspUrbiW
   eX8vFpP4gmeIEk4V2ALK4LdI0mZ8x2ZI003ItzZraFz/B72aYW+36bitJ
   uzMroB12AYhW1EpgfTppHrwnCQ4dpySta9qRLO/eZJldi99bSTtFua3Rw
   gokxM8uJJXkZifkWZYq52Kht3QrBsV5Iu5xD1Anc8+0beIPFvpxbP77j+
   Q==;
X-CSE-ConnectionGUID: 18f55MiITNy5uKOJNqxmJg==
X-CSE-MsgGUID: yzaFzob7RWeA9iZq0z1mHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34567188"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34567188"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 05:47:26 -0800
X-CSE-ConnectionGUID: 0ulZuZl7QpGT2G87G4HGGQ==
X-CSE-MsgGUID: LGWLJQxrS12ijn1K2Fjy5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="127036271"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 05:47:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 05:47:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 05:47:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 05:47:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkXZOIvFMBm1bmAhfJTnzq9r5VWXtWoYXrQg5AzqOTGL/XweONHpp0zhYU4ZuVHQ80O8HOI0FaB2iSkS0qGchL9zarrkRS6mv32IvZNologRmd77hIl5byK346mIXjdXIHF6GCc1nI0tme0uBDGukvoP4nko8d1Kaxze2V838y8qRsoIQSctdCZuctrkKZWGkGKAIkfrELHgX6+ZYNmnu2UsNs3bHScUxBMqKhVV7+ukX53P3wPTASoMX701Oj9fRKnn/oZMP5CQ1oxY+tPNR1+e+UtFAw6xa5bEg7MMcCkxVHyt648sVHvFygDyPRMP7dZbcNAluSx72lFp3FuI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6AhdvGLwS7NUpHzvj8CX2ETr3mriEX97QGKQJwD5p0=;
 b=kqL10+YI2YV7TOMPBbnlxrIT6IEikfhgQr/lxr18t4wfDxLjkRZrbjkqYb8y3rFPnPp6096FCFkgCFjSnqxY3P6hD88lqmR5Je53lY7xvMdNi6yG0YpiHajJ5KYgUCHy+MZCy24Ra3SP0ipjdEhlX95ck12sytTg+IXyteIqcoWObLYZZRdIZvupaIZO0oaBJZeKNs+Stark6isJEVlyGTCm1Sp/cfOLvklq7+xwsnTjm7ft05s7cf1lkMFEgC3MW/WgTT2mCDcMovMWFjrKm5Mrco7xbUzGhQnAXFW4f76G/mWxNm34uzCSkut2F/W4tpnIjEqrbH1M+VKbklp4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 13:47:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 13:47:20 +0000
Date: Thu, 12 Dec 2024 21:47:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [posix]  513793bc6a:  stress-ng.timer.ops_per_sec
 69.3% regression
Message-ID: <202412122138.3f38f520-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 7215c17f-a9af-463f-77c6-08dd1ab37fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6tTXOtrsuX9BqdzUaGdUjA60NEz641SXNmnjzttKDrEjGWqyHoyKNwACZ5?=
 =?iso-8859-1?Q?TlslpqofcqDnFFejI8NHUi97XY1Tm2CXG6AeRaR7yftKl/rnqdsDQtWw+w?=
 =?iso-8859-1?Q?8j8d7N0xD2RMNZkB6EFft87h3Zs3eBx4ZXdhbgHcKrGfBpF0crakp4vyb2?=
 =?iso-8859-1?Q?aa7WBvyUi/5BN/Ue+2LTmLEzSKP09/Og9AwMikfwrAzyacJkHl8SpmKVJM?=
 =?iso-8859-1?Q?HnvB8nn1AAMsNa4nnxIWCwmhhCosSMdeiHbV+8L+KvKqkUUfxb7LDouQqr?=
 =?iso-8859-1?Q?iiunhUdfsfDB3hnfa4StWOXaCDX/UPikr30lT7/TQzRCnkweD4H0VFeO/I?=
 =?iso-8859-1?Q?SY2EIAmAn5o4lbcstODLCZGUQHaJddWmgz8X46FUHHs+yVvupsTC/V8bQU?=
 =?iso-8859-1?Q?1ceMpVvIF6gvhxxRu6Q+rWooliQVCD/MHXBBR4DUznx5J0t1KWSF/H9YpY?=
 =?iso-8859-1?Q?7ekC8yQJsWSMUv1VxAqY2AajXs2eIrppKIPnjoTwOoGsBAJjuqLAGnSRtz?=
 =?iso-8859-1?Q?vag/HgaFlTfHVNeQhtmnIhveIxpVhGosHao7cIN+ICVr0BMKEQBwIoyMn3?=
 =?iso-8859-1?Q?G/TQRA2pxucAe+gEfxKQfdzC+5HaWUmtZaI8B+aUl/iIVsLLJqRBLcsqe5?=
 =?iso-8859-1?Q?0rtqODN/TLX+JqBqWwZBJKr3/wbahe/g5ab3EqGgudXJkY/WGkgEw/IXym?=
 =?iso-8859-1?Q?Va1M2lH2qDLC/FUi02ScMn2kOo5d0R9ayUQB5LXwoBn5ZrFAD0k9Z9MEh8?=
 =?iso-8859-1?Q?Rb4ONs2K8ln6Lm2p7Lk2+KkZfVuDY6iNDIAEOunHQ5rWq69tTagnxNRqW3?=
 =?iso-8859-1?Q?ZjnyEoYTA2gs7ssU49xT8hrhKu+Sdc+DSZnKQghcOQoWm2EW+nTh2Pe38J?=
 =?iso-8859-1?Q?VdtYQaf79KAWmx52c+CQKZPTZOm4o9n2ul9zOFwrrSfbhdH2wkln0vop23?=
 =?iso-8859-1?Q?rvpYxHvPWasMX4kh1uU/fHae3YudYO4yWhEs8TdL7AFpaeajkzG2q79DYK?=
 =?iso-8859-1?Q?dqcHe1MK6EN9+nuW+yLKimkfBJwymZ1u0xocbJehlu7jEhnaB42poqOTY1?=
 =?iso-8859-1?Q?muH9gDEAJ6Bg+YuUNH5TtvNsNBLvJFFCF/nDDUaDTGhdBUlUl8P8FR4pGA?=
 =?iso-8859-1?Q?Ap86zvfOw4fTKXdL14DZ5fujU7n8cKEIUPy3j4C7x+FZ006g3wykcx6jLl?=
 =?iso-8859-1?Q?iv3fyfnZHTFcrgTEs4Oeu2WhgH4WshUFWa2lCRegYRhi1wCmNHiIS00+IZ?=
 =?iso-8859-1?Q?jPFtC2cDWY2nVHTeGCSgpsJTBMu4bu5fVrUmaPB4eqF82R5H5x84TTkLKK?=
 =?iso-8859-1?Q?RrnOa0ndQsh1iUdg5TYMqK5IvvCAM49VdnNu906JACB9XJhLp8T/p/XsMm?=
 =?iso-8859-1?Q?nqFSghCIJv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NYDuJAVGFxrjxRtnyWQ/diiOBAB+AUT7pk/3Kv2/b5pgojMl0Z+pWb3jMq?=
 =?iso-8859-1?Q?XSO6oubaAuDgOQOSsfNnq7CV8XmTIXpJEGBsVmcoIrwf4tk4NPQ2K6kd8f?=
 =?iso-8859-1?Q?5Utx3GVByaXiCivWdlIWuXRDD/tlEvC+8WGsjm+8yvxSy0nDyL78qMPngC?=
 =?iso-8859-1?Q?zOknW6uPELU0GGDPuwtB4oLv7yQId6kU6Ux1Qev1oQp6C62tl+7kkhvMcB?=
 =?iso-8859-1?Q?j2iGfoXD4WRuHFMj7EzuSNSrM9oYoD5QW9Q3dtFT4U6x/LOxTZ0rXcY7C/?=
 =?iso-8859-1?Q?7EGFO6113iKsuUuIgqI/+7M9vFYic1PuE8Dv1j82t+/z6ouzHfQOghfgor?=
 =?iso-8859-1?Q?h/zF+AFQilJBYNny96jFgYghbBC53E4CNEMtjDBApwEOcX2fnYKttGUopS?=
 =?iso-8859-1?Q?+TOPL6Nisj2M90QE/DEH8iS0Ag7LflzB8K4PHm7/3rlHDjzzwqN3i/34Ge?=
 =?iso-8859-1?Q?guJiffEuk43rYKHGFu+2SXf3X2J3/TINPFMuOZvj2mHZwxfrdOMomEjdtn?=
 =?iso-8859-1?Q?kNKlZYr1eDhg8GYpI0RxoRG6+Zp0ztqX/Ng5zDP+axkB+6c9rdt8SmcfOX?=
 =?iso-8859-1?Q?BwqyE6d40vGiUq+f9P7Z8bFcWdKlda59faAXHiav7G8tmMNKhXVJZTQamG?=
 =?iso-8859-1?Q?3RswMVjv3+IJiU7clwX2Z6wIiMw40J/1UI/U1O06g7YlaEcAs2FwjH1kjd?=
 =?iso-8859-1?Q?hoFE8QTSlW+nJbXDsFZ5evbVOsh/QVOUkYiOZpho/fI50kge5RNf78LAqz?=
 =?iso-8859-1?Q?ho/NbIkaHxM3wKzqz9eikyrqJGN2zW1DHLGvkcZZqHWdbXo0+Fb7R5yypJ?=
 =?iso-8859-1?Q?8ddLT2z0GoUbF+ZUbINCWBZr6+M0hjdB6VdVg8OK4YFTEtHrUf+8CyEjiX?=
 =?iso-8859-1?Q?nNGnXmCPSCk9Gn+4uRLpNhubrGn8M8V+OATlLneA5sAIvolDxdOeseCFz/?=
 =?iso-8859-1?Q?yDguz/YxmOWkwjxKYv12uS/0EvZloeDCvT903EX9Dr3Laai6ZC904VQxm2?=
 =?iso-8859-1?Q?FDViKGiWop5MDlIkzzcmKZf32EQUPJYzlo8Scos9JwTgPSnHNjrMPzR6qU?=
 =?iso-8859-1?Q?4bIsMqPEob0rMYPto6UVMmOGQfYTRv2j24rtQV9y7Dzhm8267s7JeVkZPk?=
 =?iso-8859-1?Q?Nfm7Ow/3zAqGBCPYFwDsjTLDLfj+JaUNxOfQk7BqkCcb2a6W9wY+/f6dQ/?=
 =?iso-8859-1?Q?Yx2qMldhPUZAQCvj8WCKITJ5eBQLktttuwr4QFt6s/cRjHA3zycv4YcdbD?=
 =?iso-8859-1?Q?8DeJppnNjbNP3X0PQKhUeSmNn0vsjrkcoakoCAm064WHHfYnNMvoOjeh38?=
 =?iso-8859-1?Q?60Poy2eVsLK+qB2NhvqdzUxJX/FvXMudFGzGUoY4wiqHfV/Jf8iGVuArJs?=
 =?iso-8859-1?Q?Xxv0HpaWK84UQCpGNpurKkjjG9qwjmZaNsuojhuxuW/QdyYLhnxuszH4eS?=
 =?iso-8859-1?Q?oDPt2ga/NiwyCOS6SFcMi7TBf+zgRbFllnUY6I4LzRU81SWIIWgrcmPWjJ?=
 =?iso-8859-1?Q?mtNgw0+265i7rkoE4X75yndis+CKPrds+wFrcCmt5UA8bhZ519ow7jHiKg?=
 =?iso-8859-1?Q?WoXaACiXleIPQohgLchkye1eyEhYzq5wHtrLrZBB5qwz9G61ki20HZOZC3?=
 =?iso-8859-1?Q?tRCMV2sIbvaIatqCP8EFnDcvl1hMC7Wm2H7tuzPYely851ANeyrk2tug?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7215c17f-a9af-463f-77c6-08dd1ab37fc5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:47:20.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz5fVPhi3s4+nJbu2HlGxn1nyLvhTxDW8eeNjVtv9DUVTWIP8aj8HKFjxD98gh44ZwcuSjWO6YsvCXahBrejQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 69.3% regression of stress-ng.timer.ops_per_sec on:


commit: 513793bc6ab331b947111e8efaf8fcef33fb83e5 ("posix-timers: Make signal delivery consistent")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]
[test failed on linux-next/master d1486dca38afd08ca279ae94eb3a397f10737824]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: timer
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412122138.3f38f520-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241212/202412122138.3f38f520-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/timer/stress-ng/60s

commit: 
  15cbfb92ef ("posix-cpu-timers: Correctly update timer status in posix_cpu_timer_del()")
  513793bc6a ("posix-timers: Make signal delivery consistent")

15cbfb92efee5c7f 513793bc6ab331b947111e8efaf 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     48587 ±  3%    +135.1%     114226 ± 10%  cpuidle..usage
    263232 ± 19%    +902.6%    2639241 ± 19%  numa-numastat.node1.local_node
    295668 ± 12%    +804.8%    2675135 ± 18%  numa-numastat.node1.numa_hit
     58.00 ± 22%   +1696.3%       1041 ± 16%  perf-c2c.DRAM.local
    704.17 ±141%    +394.9%       3484 ± 38%  perf-c2c.DRAM.remote
      1039 ±126%   +6304.3%      66572 ±  7%  perf-c2c.HITM.local
      1439 ±126%   +4618.9%      67912 ±  6%  perf-c2c.HITM.total
     15.46 ±  2%     -51.2%       7.55 ±  5%  vmstat.cpu.us
     61.99           -33.8%      41.04 ±  4%  vmstat.procs.r
      5464 ± 18%  +2.1e+05%   11666546 ±  2%  vmstat.system.cs
  23948404           -38.3%   14769391 ±  6%  vmstat.system.in
     13.75           +28.7       42.49 ±  6%  mpstat.cpu.all.irq%
      0.00 ± 15%      +0.1        0.09 ±  4%  mpstat.cpu.all.soft%
     67.53           -22.0       45.52 ±  5%  mpstat.cpu.all.sys%
     15.96 ±  2%      -8.2        7.74 ±  6%  mpstat.cpu.all.usr%
      3.33 ± 14%    +630.0%      24.33 ± 53%  mpstat.max_utilization.seconds
    105538 ± 19%   +7757.6%    8292825 ±  7%  stress-ng.time.involuntary_context_switches
     25305            +3.2%      26119        stress-ng.time.minor_page_faults
      5399           -49.6%       2723 ±  6%  stress-ng.time.percent_of_cpu_this_job_got
      2658           -44.7%       1469 ±  5%  stress-ng.time.system_time
    590.79 ±  3%     -71.8%     166.72 ± 12%  stress-ng.time.user_time
     47287 ± 71%  +7.9e+05%   3.75e+08 ±  2%  stress-ng.time.voluntary_context_switches
 1.514e+09           -69.4%   4.64e+08 ±  6%  stress-ng.timer.ops
  25223871           -69.3%    7733023 ±  6%  stress-ng.timer.ops_per_sec
     98077 ± 29%    +217.7%     311617 ±103%  numa-meminfo.node0.Mapped
    558986 ± 33%   +1212.6%    7337204 ± 19%  numa-meminfo.node1.Active
    558986 ± 33%   +1212.6%    7337204 ± 19%  numa-meminfo.node1.Active(anon)
   1464858 ±104%    +524.8%    9153048 ± 18%  numa-meminfo.node1.FilePages
     38091 ± 67%     +80.8%      68868 ± 38%  numa-meminfo.node1.KReclaimable
     86718 ± 31%   +1905.9%    1739452 ± 16%  numa-meminfo.node1.Mapped
   2316374 ± 63%    +346.4%   10340324 ± 16%  numa-meminfo.node1.MemUsed
     38091 ± 67%     +80.8%      68868 ± 38%  numa-meminfo.node1.SReclaimable
    219892 ± 22%   +3006.7%    6831398 ± 20%  numa-meminfo.node1.Shmem
     24831 ± 28%    +215.0%      78231 ±103%  numa-vmstat.node0.nr_mapped
    139938 ± 32%   +1211.8%    1835646 ± 19%  numa-vmstat.node1.nr_active_anon
    366383 ±104%    +524.9%    2289595 ± 18%  numa-vmstat.node1.nr_file_pages
     21945 ± 31%   +1888.3%     436346 ± 16%  numa-vmstat.node1.nr_mapped
     55142 ± 22%   +2999.6%    1709183 ± 20%  numa-vmstat.node1.nr_shmem
      9523 ± 67%     +80.8%      17220 ± 38%  numa-vmstat.node1.nr_slab_reclaimable
    139938 ± 32%   +1211.8%    1835645 ± 19%  numa-vmstat.node1.nr_zone_active_anon
    295381 ± 12%    +805.6%    2674925 ± 18%  numa-vmstat.node1.numa_hit
    262944 ± 19%    +903.6%    2639031 ± 19%  numa-vmstat.node1.numa_local
    990515          +737.2%    8292656        meminfo.Active
    990515          +737.2%    8292656        meminfo.Active(anon)
   3862349          +187.0%   11085263        meminfo.Cached
   1660022          +438.8%    8944972        meminfo.Committed_AS
     92294           +17.6%     108575        meminfo.KReclaimable
    187344          +993.5%    2048608 ±  2%  meminfo.Mapped
   5627909          +134.1%   13172585        meminfo.Memused
     13092 ±  2%     +30.1%      17028 ±  2%  meminfo.PageTables
     92294           +17.6%     108575        meminfo.SReclaimable
    310825         +2323.8%    7533740        meminfo.Shmem
   5972391          +121.4%   13223165        meminfo.max_used_kB
    247604          +737.7%    2074102        proc-vmstat.nr_active_anon
    170781           +11.7%     190682 ±  5%  proc-vmstat.nr_anon_pages
   6415412            -2.9%    6226727        proc-vmstat.nr_dirty_background_threshold
  12846511            -2.9%   12468679        proc-vmstat.nr_dirty_threshold
    965609          +187.1%    2772250        proc-vmstat.nr_file_pages
  64532858            -2.9%   62643241        proc-vmstat.nr_free_pages
     46463         +1004.6%     513234 ±  2%  proc-vmstat.nr_mapped
      3276 ±  2%     +29.9%       4254 ±  2%  proc-vmstat.nr_page_table_pages
     77726         +2324.4%    1884367        proc-vmstat.nr_shmem
     23074           +17.6%      27145        proc-vmstat.nr_slab_reclaimable
    247604          +737.7%    2074102        proc-vmstat.nr_zone_active_anon
     10480 ± 56%   +1681.0%     186655 ± 10%  proc-vmstat.numa_hint_faults
      1153 ± 26%   +9995.3%     116398 ± 15%  proc-vmstat.numa_hint_faults_local
    521896          +499.5%    3128674        proc-vmstat.numa_hit
    455685          +572.1%    3062462        proc-vmstat.numa_local
     67767 ± 54%    +407.4%     343853 ±  8%  proc-vmstat.numa_pte_updates
    556175          +471.4%    3178244        proc-vmstat.pgalloc_normal
    353015 ±  2%     +88.7%     666067 ±  3%  proc-vmstat.pgfault
    416174           -17.3%     344124 ±  5%  proc-vmstat.pgfree
     13656 ±  9%     +49.6%      20432 ± 12%  proc-vmstat.pgreuse
      0.03 ± 65%    +379.4%       0.12 ± 23%  perf-stat.i.MPKI
 3.097e+10            -7.7%  2.858e+10 ±  3%  perf-stat.i.branch-instructions
      0.30            +0.5        0.79 ±  5%  perf-stat.i.branch-miss-rate%
  83195554          +156.5%  2.134e+08 ±  3%  perf-stat.i.branch-misses
     21.99 ± 19%     -15.0        7.02 ± 22%  perf-stat.i.cache-miss-rate%
   3146044 ± 75%    +446.6%   17197761 ± 23%  perf-stat.i.cache-misses
  14680100 ± 42%   +1628.5%  2.537e+08 ±  5%  perf-stat.i.cache-references
      5527 ± 19%  +2.2e+05%   12092101 ±  3%  perf-stat.i.context-switches
 2.228e+11            -1.3%    2.2e+11        perf-stat.i.cpu-cycles
    179.71 ±  3%   +3531.9%       6527 ±  5%  perf-stat.i.cpu-migrations
    183624 ± 38%     -90.7%      17016 ± 27%  perf-stat.i.cycles-between-cache-misses
      0.01 ±147%  +2.3e+06%     188.83 ±  2%  perf-stat.i.metric.K/sec
      4081 ±  3%    +126.5%       9246 ±  3%  perf-stat.i.minor-faults
      4081 ±  3%    +126.5%       9246 ±  3%  perf-stat.i.page-faults
      0.02 ± 76%    +452.2%       0.13 ± 22%  perf-stat.overall.MPKI
      0.27            +0.5        0.75 ±  6%  perf-stat.overall.branch-miss-rate%
     19.25 ± 25%     -12.5        6.79 ± 24%  perf-stat.overall.cache-miss-rate%
     96430 ± 36%     -86.0%      13454 ± 20%  perf-stat.overall.cycles-between-cache-misses
 3.045e+10            -7.8%  2.808e+10 ±  3%  perf-stat.ps.branch-instructions
  81560777          +157.1%  2.097e+08 ±  3%  perf-stat.ps.branch-misses
   3085835 ± 75%    +447.0%   16880447 ± 23%  perf-stat.ps.cache-misses
  14531051 ± 41%   +1616.0%  2.494e+08 ±  5%  perf-stat.ps.cache-references
      5419 ± 19%  +2.2e+05%   11896426 ±  3%  perf-stat.ps.context-switches
 2.192e+11            -1.3%  2.162e+11        perf-stat.ps.cpu-cycles
    177.05 ±  2%   +3519.6%       6408 ±  5%  perf-stat.ps.cpu-migrations
      4003 ±  2%    +125.7%       9036 ±  4%  perf-stat.ps.minor-faults
      4003 ±  2%    +125.7%       9036 ±  4%  perf-stat.ps.page-faults
   3258865 ±  9%     -67.4%    1060802 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.avg
  16498628 ± 39%     -58.8%    6795952 ± 24%  sched_debug.cfs_rq:/.avg_vruntime.max
   1687260           -71.8%     476141 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.min
   2850416 ± 32%     -60.1%    1136107 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.64 ±  2%      -8.2%       0.58 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_running.min
      0.31 ±  9%     +33.4%       0.42 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
      4491 ±204%   +4096.9%     188523 ± 19%  sched_debug.cfs_rq:/.left_deadline.avg
    287486 ±204%   +1084.1%    3404257 ± 37%  sched_debug.cfs_rq:/.left_deadline.max
     35653 ±204%   +1464.8%     557913 ± 24%  sched_debug.cfs_rq:/.left_deadline.stddev
      4491 ±204%   +4096.9%     188509 ± 19%  sched_debug.cfs_rq:/.left_vruntime.avg
    287466 ±204%   +1084.2%    3404139 ± 37%  sched_debug.cfs_rq:/.left_vruntime.max
     35651 ±204%   +1464.8%     557885 ± 24%  sched_debug.cfs_rq:/.left_vruntime.stddev
      7896          -100.0%       0.00        sched_debug.cfs_rq:/.load.min
      7.42 ±  2%     -78.7%       1.58 ± 88%  sched_debug.cfs_rq:/.load_avg.min
   3258865 ±  9%     -67.4%    1060802 ± 11%  sched_debug.cfs_rq:/.min_vruntime.avg
  16498628 ± 39%     -58.8%    6795952 ± 24%  sched_debug.cfs_rq:/.min_vruntime.max
   1687260           -71.8%     476141 ±  8%  sched_debug.cfs_rq:/.min_vruntime.min
   2850416 ± 32%     -60.1%    1136107 ± 19%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.50          -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
      0.22 ±  5%     +83.3%       0.40 ±  6%  sched_debug.cfs_rq:/.nr_running.stddev
     60.92 ± 12%     -35.7%      39.16 ± 47%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     60.92 ± 12%     -35.7%      39.16 ± 47%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      4491 ±204%   +4096.9%     188509 ± 19%  sched_debug.cfs_rq:/.right_vruntime.avg
    287466 ±204%   +1084.2%    3404139 ± 37%  sched_debug.cfs_rq:/.right_vruntime.max
     35651 ±204%   +1464.8%     557885 ± 24%  sched_debug.cfs_rq:/.right_vruntime.stddev
    747.36 ±  2%     -24.5%     563.96        sched_debug.cfs_rq:/.runnable_avg.avg
    512.00           -89.9%      51.83 ±168%  sched_debug.cfs_rq:/.runnable_avg.min
    176.90 ±  7%     +49.9%     265.20 ±  9%  sched_debug.cfs_rq:/.runnable_avg.stddev
    743.14 ±  2%     -26.6%     545.79 ±  2%  sched_debug.cfs_rq:/.util_avg.avg
    502.58 ±  3%     -90.1%      49.75 ±173%  sched_debug.cfs_rq:/.util_avg.min
    163.31 ±  8%     +58.8%     259.41 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
    533.20           -41.4%     312.72 ±  7%  sched_debug.cfs_rq:/.util_est.avg
    511.42          -100.0%       0.00        sched_debug.cfs_rq:/.util_est.min
     78.65 ± 21%    +162.8%     206.73 ±  7%  sched_debug.cfs_rq:/.util_est.stddev
      3.55 ± 16%     -50.4%       1.76        sched_debug.cpu.clock.stddev
      1037 ±  3%     +70.5%       1769        sched_debug.cpu.clock_task.stddev
      1649 ±  2%     -24.6%       1243 ±  5%  sched_debug.cpu.curr->pid.avg
      1142 ± 35%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
    559.51 ±  4%     +97.3%       1104 ±  3%  sched_debug.cpu.curr->pid.stddev
      0.00 ±  8%     +18.2%       0.00 ±  8%  sched_debug.cpu.next_balance.stddev
      0.64 ±  2%     -22.0%       0.50 ±  9%  sched_debug.cpu.nr_running.avg
      0.50          -100.0%       0.00        sched_debug.cpu.nr_running.min
      0.32 ±  8%     +50.6%       0.48 ±  4%  sched_debug.cpu.nr_running.stddev
      4405 ± 10%  +1.3e+05%    5667985 ±  2%  sched_debug.cpu.nr_switches.avg
     32685 ± 36%  +21085.0%    6924346 ±  3%  sched_debug.cpu.nr_switches.max
    902.17 ±  6%  +29302.1%     265256 ± 29%  sched_debug.cpu.nr_switches.min
      5789 ± 30%  +20149.4%    1172368 ±  5%  sched_debug.cpu.nr_switches.stddev
      0.02 ±102%   +6026.1%       1.45 ±212%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ±144%  +2.4e+05%      35.69 ± 36%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.02 ±109%  +4.4e+05%      96.53 ± 14%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.02 ±186%  +17151.0%       2.82 ± 90%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.96 ±118%   +6298.5%      61.52 ±125%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.07 ±112%  +36209.2%      25.78 ± 95%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.00 ±101%  +5.7e+06%     210.24 ± 45%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ±136%    +1e+05%       4.80 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 ±161%  +3.8e+05%      30.77 ± 32%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±141%  +1.4e+05%      29.58 ± 45%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.24 ±100%  +39042.1%     877.18 ± 72%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.59 ±148%    +2e+05%       1171 ± 31%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±104%    +189.3%       0.01 ± 22%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.31 ±100%  +50363.4%       2175 ± 17%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.34 ±220%   +5202.7%      17.85 ± 79%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      5.83 ±100%  +15516.7%     909.98 ±104%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.30 ±111%  +51359.7%     670.01 ± 70%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ±135%  +1.1e+07%       1175 ± 58%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1.11 ±221%  +18105.1%     202.68 ± 35%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3.41 ±212%  +57820.4%       1976 ± 30%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.64 ±104%    +596.9%      25.35 ± 58%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.48 ±172%  +37286.2%       2048 ± 48%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.66 ±108%  +30479.1%       2953 ± 17%  perf-sched.total_sch_delay.max.ms
      3712 ±100%  +1.9e+05%    7203729 ± 10%  perf-sched.total_wait_and_delay.count.ms
      2496 ±100%    +127.3%       5675 ± 10%  perf-sched.total_wait_and_delay.max.ms
      0.63 ±104%  +23844.4%     150.85 ± 24%  perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    116.17 ±100%    +165.8%     308.76 ± 21%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     86.69 ±109%    +347.0%     387.53 ± 17%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.91 ±100%   +6797.9%      62.51 ± 69%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    226.36 ±100%    +306.1%     919.26 ± 19%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      5.05 ±100%    +204.7%      15.38 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    247.75 ±100%    +139.0%     592.06 ±  8%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.26 ±158%  +44378.8%     114.24 ± 52%  perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    301.50 ±100%    +150.0%     753.75 ±  7%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    309.83 ±100%  +2.3e+06%    7192429 ± 10%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    500.82 ±100%    +465.7%       2833 ± 13%  perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    501.71 ±100%    +332.0%       2167 ± 41%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     14.96 ±190%  +15552.0%       2341 ± 53%  perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    466.29 ±101%    +171.5%       1266 ± 19%  perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      1437 ±102%    +237.2%       4848 ± 18%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3.49 ±102%  +47790.8%       1673 ± 28%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    252.50 ±100%    +864.5%       2435 ± 25%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1673 ±107%    +198.2%       4990 ± 11%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.52 ±168%  +98538.0%       1500 ± 33%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      1546 ±107%    +190.7%       4496 ± 28%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.62 ±104%  +18614.4%     115.16 ± 23%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    116.17 ±100%    +165.8%     308.75 ± 21%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     86.67 ±109%    +235.8%     291.00 ± 20%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.84 ±100%   +4296.7%      36.73 ± 52%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    226.35 ±100%    +213.2%     709.02 ± 15%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    247.74 ±100%    +126.6%     561.28 ±  9%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.13 ±116%  +51946.4%      68.61 ± 45%  perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    301.47 ±100%    +140.2%     724.17 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    500.85 ±100%    +199.5%       1500 ± 33%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     14.61 ±195%   +9055.8%       1337 ± 55%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    466.28 ±101%    +171.5%       1266 ± 19%  perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.50 ±100%    +827.4%      23.17 ± 59%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      3.22 ±103%  +31093.3%       1003        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    252.50 ±100%    +631.8%       1847 ± 12%  perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      1673 ±107%    +172.9%       4567 ±  6%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.25 ±121%  +79688.1%       1000        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
     40.51           -35.0        5.46 ±  6%  perf-profile.calltrace.cycles-pp.stress_timer_handler
     31.30 ±  2%     -26.5        4.85 ±  6%  perf-profile.calltrace.cycles-pp.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.18           -24.9        1.24 ±  7%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_timer_handler
     27.03           -24.8        2.20 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.stress_timer_handler
     27.02           -24.8        2.20 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_timer_handler
     26.93           -24.8        2.17 ±  5%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_timer_handler
     16.22 ±  2%     -15.4        0.83 ±  7%  perf-profile.calltrace.cycles-pp.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     17.69           -10.8        6.89 ±  7%  perf-profile.calltrace.cycles-pp.timer_settime
     10.48 ±  6%     -10.5        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
     12.75            -8.4        4.39 ±  8%  perf-profile.calltrace.cycles-pp.__x64_sys_timer_settime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
     13.95            -8.3        5.68 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
     14.20            -8.2        6.02 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_settime
     16.23 ±  2%      -7.2        9.02 ±  8%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     16.49 ±  2%      -7.1        9.36 ±  8%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      9.76 ±  3%      -6.8        2.98 ±  6%  perf-profile.calltrace.cycles-pp.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
     10.04            -6.7        3.36 ±  8%  perf-profile.calltrace.cycles-pp.do_timer_settime.__x64_sys_timer_settime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
      6.48 ±  6%      -6.5        0.00        perf-profile.calltrace.cycles-pp.signal_setup_done.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.34 ±  7%      -6.3        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.signal_setup_done.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      8.74            -5.8        2.90 ±  7%  perf-profile.calltrace.cycles-pp.common_timer_set.do_timer_settime.__x64_sys_timer_settime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.35 ±  2%      -5.7        2.60 ±  6%  perf-profile.calltrace.cycles-pp.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      5.72 ±  6%      -5.7        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.fpu__clear_user_states.handle_signal.arch_do_signal_or_restart
      7.38            -5.0        2.43 ±  7%  perf-profile.calltrace.cycles-pp.sigpending
      6.93            -4.9        2.05 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      6.84            -4.8        2.02 ±  7%  perf-profile.calltrace.cycles-pp.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      6.58            -4.6        1.94 ±  7%  perf-profile.calltrace.cycles-pp.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.94            -4.2        1.70 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      6.22            -4.1        2.10 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.common_timer_set.do_timer_settime.__x64_sys_timer_settime.do_syscall_64
      5.73            -4.1        1.63 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.17            -3.7        1.48 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigreturn.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.52            -3.2        1.33 ±  7%  perf-profile.calltrace.cycles-pp.restore_fpregs_from_user.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
      4.34            -2.9        1.45 ±  7%  perf-profile.calltrace.cycles-pp.copy_fpstate_to_sigframe.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      3.91            -2.8        1.09 ±  8%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_start_range_ns.common_timer_set.do_timer_settime.__x64_sys_timer_settime
      3.77            -2.7        1.10 ±  7%  perf-profile.calltrace.cycles-pp.__restore_fpregs_from_user.restore_fpregs_from_user.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn
      3.39 ±  6%      -2.5        0.91 ±  3%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.88            -2.1        0.80 ±  9%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_start_range_ns.common_timer_set.do_timer_settime
      3.19            -2.0        1.21 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sigpending
      2.56 ±  6%      -1.8        0.73 ±  7%  perf-profile.calltrace.cycles-pp.save_xstate_epilog.get_sigframe.x64_setup_rt_frame.handle_signal.arch_do_signal_or_restart
      2.94            -1.8        1.13 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigpending
      2.46            -1.6        0.82 ±  5%  perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.handle_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      2.38            -1.5        0.88 ± 11%  perf-profile.calltrace.cycles-pp.get_itimerspec64.__x64_sys_timer_settime.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
      1.84            -1.5        0.37 ± 71%  perf-profile.calltrace.cycles-pp.__fpu_restore_sig.fpu__restore_sig.restore_sigcontext.__x64_sys_rt_sigreturn.do_syscall_64
      1.80            -1.3        0.45 ± 45%  perf-profile.calltrace.cycles-pp.common_hrtimer_arm.common_timer_set.do_timer_settime.__x64_sys_timer_settime.do_syscall_64
      1.97            -1.3        0.69 ± 10%  perf-profile.calltrace.cycles-pp._copy_from_user.get_itimerspec64.__x64_sys_timer_settime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.75 ± 10%      -1.1        0.65 ±  3%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.73            -1.0        0.69 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigpending.do_syscall_64.entry_SYSCALL_64_after_hwframe.sigpending
      0.00            +0.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp.update_load_avg.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate
      0.00            +0.6        0.58 ±  4%  perf-profile.calltrace.cycles-pp.__remove_hrtimer.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities.dequeue_task_fair
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.update_load_avg.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule
      0.00            +0.6        0.59 ±  8%  perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.00            +0.6        0.60 ±  3%  perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.dl_server_stop.dequeue_entities.dequeue_task_fair
      0.00            +0.6        0.61 ±  3%  perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.stress_timer_handler
      0.00            +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer
      0.00            +0.7        0.68 ±  3%  perf-profile.calltrace.cycles-pp.set_next_entity.set_next_task_fair.pick_next_task_fair.__pick_next_task.__schedule
      1.14 ±  9%      +0.7        1.84 ± 24%  perf-profile.calltrace.cycles-pp.__x64_sys_timer_getoverrun.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_getoverrun
      0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_try_to_cancel.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00            +0.7        0.71 ±  3%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      0.00            +0.7        0.71 ±  8%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep
      0.00            +0.7        0.72 ± 10%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_start_range_ns.posixtimer_deliver_signal.dequeue_signal
      0.00            +0.7        0.72 ± 13%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
      0.00            +0.8        0.76 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep
      0.00            +0.8        0.76 ±  3%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.dl_server_stop.dequeue_entities.dequeue_task_fair.__schedule
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.set_next_task_fair.pick_next_task_fair.__pick_next_task.__schedule.schedule_idle
      0.00            +0.8        0.80 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.00            +0.8        0.80 ±  2%  perf-profile.calltrace.cycles-pp.update_curr.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule
      0.00            +0.8        0.81 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.do_nanosleep
      0.00            +0.9        0.92 ± 14%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00            +1.0        0.95        perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
      0.00            +1.0        1.00 ± 12%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_settime
      0.00            +1.0        1.01 ±  9%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_start_range_ns.posixtimer_deliver_signal.dequeue_signal.get_signal
      6.58            +1.1        7.68 ±  8%  perf-profile.calltrace.cycles-pp.timer_getoverrun
      0.00            +1.1        1.12 ± 19%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.timer_getoverrun
      0.00            +1.1        1.13 ±  5%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00            +1.2        1.16 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule_idle.do_idle
      0.00            +1.2        1.21 ±  2%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00            +1.2        1.23 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      3.56            +1.4        4.98 ± 10%  perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.5        1.50        perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      0.00            +1.5        1.52 ± 15%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64
      0.00            +1.7        1.74 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_getoverrun
      2.11 ±  3%      +2.0        4.06 ± 10%  perf-profile.calltrace.cycles-pp.dequeue_signal.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64
      0.00            +2.1        2.06 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.posixtimer_deliver_signal.dequeue_signal.get_signal.arch_do_signal_or_restart
      0.00            +2.1        2.12 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.15 ±  7%      +2.1        3.30 ± 10%  perf-profile.calltrace.cycles-pp.posixtimer_deliver_signal.dequeue_signal.get_signal.arch_do_signal_or_restart.syscall_exit_to_user_mode
      0.00            +2.4        2.41        perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_entities.dequeue_task_fair.__schedule.schedule
      2.28 ±  4%      +2.6        4.91 ± 10%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_getoverrun
      0.00            +3.1        3.11 ± 10%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe.timer_getoverrun
      2.53 ±  4%      +3.1        5.65 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.timer_getoverrun
      0.00            +6.9        6.88 ± 16%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer
      0.00            +7.1        7.10 ± 16%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      0.00            +8.6        8.58 ± 13%  perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
      0.00           +10.2       10.24 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities
      0.00           +10.5       10.48 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      0.00           +10.5       10.54 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities.dequeue_task_fair
      0.00           +10.8       10.76 ± 14%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
      0.00           +11.3       11.34 ± 13%  perf-profile.calltrace.cycles-pp.hrtimer_try_to_cancel.dl_server_stop.dequeue_entities.dequeue_task_fair.__schedule
      0.00           +12.7       12.68 ± 11%  perf-profile.calltrace.cycles-pp.dl_server_stop.dequeue_entities.dequeue_task_fair.__schedule.schedule
     23.46           +12.8       36.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     23.48           +12.9       36.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
     23.48           +15.0       38.50        perf-profile.calltrace.cycles-pp.clock_nanosleep
      0.00           +15.4       15.39 ±  9%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__schedule.schedule.do_nanosleep
      0.00           +15.5       15.51 ±  9%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.do_nanosleep.hrtimer_nanosleep
      0.00           +19.5       19.48 ± 13%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair
      0.00           +19.5       19.48 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep
      0.00           +19.8       19.84 ±  6%  perf-profile.calltrace.cycles-pp.schedule.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00           +19.9       19.88 ± 13%  perf-profile.calltrace.cycles-pp.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task
      0.00           +20.4       20.41 ± 13%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate
      0.00           +20.5       20.46 ± 13%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      3.11 ±  5%     +22.4       25.56 ±  9%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00           +22.6       22.65 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.complete_signal
      0.00           +22.7       22.72 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.complete_signal.send_sigqueue
      0.00           +22.8       22.84 ± 11%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.complete_signal.send_sigqueue.posix_timer_fn
      0.00           +23.1       23.06 ±  4%  perf-profile.calltrace.cycles-pp.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64
      1.69 ± 24%     +23.4       25.04 ± 10%  perf-profile.calltrace.cycles-pp.posix_timer_fn.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00           +23.7       23.70 ±  4%  perf-profile.calltrace.cycles-pp.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00           +23.7       23.75 ±  4%  perf-profile.calltrace.cycles-pp.common_nsleep.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.82 ±  5%     +24.0       24.82 ± 10%  perf-profile.calltrace.cycles-pp.send_sigqueue.posix_timer_fn.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00           +24.3       24.30 ± 10%  perf-profile.calltrace.cycles-pp.try_to_wake_up.complete_signal.send_sigqueue.posix_timer_fn.__hrtimer_run_queues
      0.00           +24.5       24.48 ± 10%  perf-profile.calltrace.cycles-pp.complete_signal.send_sigqueue.posix_timer_fn.__hrtimer_run_queues.hrtimer_interrupt
      0.00           +24.5       24.55 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.00           +27.0       27.01 ±  9%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch
      0.00           +27.7       27.67 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule
      0.00           +28.4       28.36 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle
      0.00           +30.7       30.75 ±  8%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule_idle.do_idle.cpu_startup_entry
      0.00           +31.6       31.61 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.finish_task_switch.__schedule.schedule_idle.do_idle
      0.00           +34.1       34.06 ±  7%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.00           +34.2       34.20 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +34.2       34.22 ±  6%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +34.2       34.22 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.00           +34.2       34.22 ±  6%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      0.00           +34.2       34.23 ±  6%  perf-profile.calltrace.cycles-pp.common_startup_64
     46.28           -33.9       12.34 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     37.68           -33.2        4.52 ±  6%  perf-profile.children.cycles-pp.stress_timer_handler
     43.26           -32.8       10.42 ±  9%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
     31.93 ±  2%     -27.0        4.92 ±  7%  perf-profile.children.cycles-pp.handle_signal
     77.60           -24.2       53.38 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     76.66           -23.7       52.99 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     17.37 ±  2%     -16.5        0.88 ±  7%  perf-profile.children.cycles-pp.fpu__clear_user_states
     17.75           -10.7        7.07 ±  7%  perf-profile.children.cycles-pp.timer_settime
     12.56            -9.0        3.58 ±  7%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
     12.81            -8.4        4.42 ±  8%  perf-profile.children.cycles-pp.__x64_sys_timer_settime
     10.40 ±  4%      -7.4        3.04 ±  7%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      7.12 ±  6%      -6.8        0.28 ±  7%  perf-profile.children.cycles-pp.signal_setup_done
     10.12            -6.7        3.39 ±  8%  perf-profile.children.cycles-pp.do_timer_settime
      8.80 ±  3%      -6.2        2.64 ±  7%  perf-profile.children.cycles-pp.get_sigframe
      8.49            -6.1        2.41 ±  7%  perf-profile.children.cycles-pp.restore_sigcontext
      8.81            -5.9        2.91 ±  7%  perf-profile.children.cycles-pp.common_timer_set
      5.60 ±  3%      -5.3        0.31 ±  8%  perf-profile.children.cycles-pp.fpregs_mark_activate
      6.89            -4.9        1.97 ±  7%  perf-profile.children.cycles-pp.fpu__restore_sig
      7.43            -4.8        2.65 ±  7%  perf-profile.children.cycles-pp.sigpending
      6.94            -4.5        2.45 ±  7%  perf-profile.children.cycles-pp.clear_bhb_loop
      7.15            -4.0        3.14 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      7.88            -3.5        4.42 ±  8%  perf-profile.children.cycles-pp.clockevents_program_event
      4.79            -3.4        1.36 ±  8%  perf-profile.children.cycles-pp.restore_fpregs_from_user
      4.72            -3.2        1.52 ±  7%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      3.96            -2.8        1.12 ±  8%  perf-profile.children.cycles-pp.__restore_fpregs_from_user
      4.43            -2.7        1.77 ± 10%  perf-profile.children.cycles-pp._copy_from_user
      5.88            -2.5        3.36 ±  8%  perf-profile.children.cycles-pp.lapic_next_deadline
      2.80 ±  7%      -2.0        0.76 ±  7%  perf-profile.children.cycles-pp.save_xstate_epilog
      2.82            -1.8        1.06 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.44            -1.5        0.90 ± 11%  perf-profile.children.cycles-pp.get_itimerspec64
      1.95            -1.4        0.55 ±  7%  perf-profile.children.cycles-pp.__fpu_restore_sig
      1.90            -1.3        0.56 ±  7%  perf-profile.children.cycles-pp.common_hrtimer_arm
      1.74            -1.2        0.49 ±  7%  perf-profile.children.cycles-pp.check_xstate_in_sigframe
      1.66 ±  6%      -1.2        0.46 ±  8%  perf-profile.children.cycles-pp.__put_user_nocheck_4
      1.89            -1.2        0.70 ±  7%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.62            -1.2        1.47 ±  4%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      1.82            -1.1        0.72 ±  6%  perf-profile.children.cycles-pp.__x64_sys_rt_sigpending
      1.46 ±  3%      -1.1        0.40 ±  8%  perf-profile.children.cycles-pp.__get_user_nocheck_4
      1.46            -1.1        0.41 ±  7%  perf-profile.children.cycles-pp.restore_altstack
      1.38            -1.0        0.38 ±  7%  perf-profile.children.cycles-pp.__get_user_nocheck_8
      1.11 ±  3%      -1.0        0.12 ±  8%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      2.12            -0.9        1.21 ±  8%  perf-profile.children.cycles-pp.native_apic_msr_eoi
      1.59            -0.7        0.90 ±  5%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.93            -0.7        0.26 ±  8%  perf-profile.children.cycles-pp.set_current_blocked
      1.48            -0.6        0.90 ±  7%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.85            -0.5        0.34 ±  7%  perf-profile.children.cycles-pp._copy_to_user
      1.73            -0.5        1.23 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.12            -0.5        1.62 ±  6%  perf-profile.children.cycles-pp.read_tsc
      2.31            -0.5        1.84 ±  6%  perf-profile.children.cycles-pp.ktime_get
      0.94            -0.5        0.49 ± 14%  perf-profile.children.cycles-pp.recalc_sigpending
      0.66 ± 34%      -0.4        0.22 ± 26%  perf-profile.children.cycles-pp.stress_timer
      0.93            -0.4        0.49 ±  5%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      1.17            -0.4        0.80 ±  7%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.65            -0.4        0.28 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.75 ±  2%      -0.3        0.41 ±  8%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.55 ±  8%      -0.3        0.22 ± 19%  perf-profile.children.cycles-pp.sync_regs
      0.50            -0.3        0.18 ±  8%  perf-profile.children.cycles-pp.do_sigpending
      0.76            -0.3        0.45 ±  7%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.63            -0.3        0.33 ±  7%  perf-profile.children.cycles-pp.__put_user_8
      0.55            -0.3        0.26 ±  7%  perf-profile.children.cycles-pp.tick_program_event
      0.73            -0.3        0.44 ±  5%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.72            -0.3        0.47 ± 14%  perf-profile.children.cycles-pp.__hrtimer_init
      0.80            -0.2        0.56 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.51 ±  3%      -0.2        0.28 ±  7%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.30            -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.56            -0.2        0.35 ±  5%  perf-profile.children.cycles-pp.__get_user_8
      0.48            -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.error_entry
      0.28 ±  2%      -0.2        0.10 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      0.41            -0.2        0.26 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      1.06            -0.1        0.91 ±  5%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.16 ±  2%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.do_sigaltstack
      0.22 ±  5%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.32 ±  3%      -0.1        0.20 ± 10%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.64            -0.1        0.51 ±  5%  perf-profile.children.cycles-pp.x64_sys_call
      0.27 ±  3%      -0.1        0.15 ±  9%  perf-profile.children.cycles-pp.prepare_signal
      0.17 ±  2%      -0.1        0.05 ±  8%  perf-profile.children.cycles-pp.fpu__alloc_mathframe
      0.91            -0.1        0.80 ±  5%  perf-profile.children.cycles-pp.sched_clock
      0.79            -0.1        0.70 ±  5%  perf-profile.children.cycles-pp.native_sched_clock
      0.21 ±  2%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.hrtimer_reprogram
      0.17 ±  3%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.12 ±  4%      -0.1        0.05 ± 13%  perf-profile.children.cycles-pp.sigismember@plt
      0.14 ±  2%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.sigismember
      0.07 ±  6%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.rcu_all_qs
      0.12            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.07            -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.pid_task
      0.12 ±  8%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.10 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.sched_clock_noinstr
      0.06 ±  9%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.irqentry_exit
      0.11            +0.0        0.13 ±  8%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.dequeue_task
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.machine__findnew_thread
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mm_cid_get
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.psi_account_irqtime
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.perf_swevent_event
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.list_add_leaf_cfs_rq
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.raw_spin_rq_unlock
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.handle_softirqs
      0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.arch_scale_cpu_capacity
      0.00            +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.pick_next_task
      0.02 ± 99%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.error_return
      0.00            +0.1        0.08        perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.__update_idle_core
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.put_prev_task_fair
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.cpuacct_charge
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.00            +0.1        0.09 ± 14%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.wakeup_preempt
      0.00            +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.hrtimer_forward
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.put_prev_task_idle
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.vruntime_eligible
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.update_curr_se
      0.00            +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.put_prev_entity
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.select_idle_sibling
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.evlist__event2evsel
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.00            +0.1        0.11 ±  5%  perf-profile.children.cycles-pp.irq_exit_rcu
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.dl_server_update_idle_time
      0.00            +0.1        0.12 ± 23%  perf-profile.children.cycles-pp.clockevents_program_min_delta
      0.00            +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.set_next_task_idle
      0.00            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__enqueue_entity
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.00            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.pick_eevdf
      0.00            +0.2        0.15 ±  5%  perf-profile.children.cycles-pp.evsel__parse_sample
      0.00            +0.2        0.15        perf-profile.children.cycles-pp.rcu_note_context_switch
      0.00            +0.2        0.15 ±  7%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.15 ±  5%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.idle_cpu
      0.00            +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.update_min_vruntime
      0.00            +0.2        0.19 ±  3%  perf-profile.children.cycles-pp.dl_scaled_delta_exec
      0.00            +0.2        0.20 ±  4%  perf-profile.children.cycles-pp.__calc_delta
      0.00            +0.2        0.22 ±  6%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.00            +0.2        0.23 ±  3%  perf-profile.children.cycles-pp.__dequeue_entity
      0.00            +0.2        0.23 ±  2%  perf-profile.children.cycles-pp.avg_vruntime
      0.00            +0.2        0.23 ±  4%  perf-profile.children.cycles-pp.task_non_contending
      0.00            +0.2        0.25        perf-profile.children.cycles-pp.resched_curr
      0.00            +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.evlist__parse_sample
      0.00            +0.2        0.25 ±  4%  perf-profile.children.cycles-pp.reweight_entity
      0.00            +0.3        0.25 ±  5%  perf-profile.children.cycles-pp.perf_tp_event
      0.11 ±  4%      +0.3        0.38 ±  4%  perf-profile.children.cycles-pp.rb_insert_color
      0.00            +0.3        0.28 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
      0.00            +0.3        0.28 ±  3%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.00            +0.3        0.28 ±  7%  perf-profile.children.cycles-pp.place_entity
      0.00            +0.3        0.30 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.00            +0.3        0.30 ±  5%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.3        0.30 ±  3%  perf-profile.children.cycles-pp.update_entity_lag
      0.00            +0.3        0.34 ± 17%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.4        0.35 ±  8%  perf-profile.children.cycles-pp.common_hrtimer_rearm
      0.32            +0.4        0.68 ±  3%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.00            +0.4        0.37 ±  6%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.00            +0.4        0.39 ±  5%  perf-profile.children.cycles-pp.update_rq_clock
      0.00            +0.4        0.41 ±  3%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.12 ±  4%      +0.4        0.54 ±  2%  perf-profile.children.cycles-pp.hrtimer_active
      0.00            +0.4        0.42 ±  5%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.00            +0.4        0.42 ± 13%  perf-profile.children.cycles-pp.get_timespec64
      0.00            +0.4        0.43 ±  4%  perf-profile.children.cycles-pp.task_contending
      0.00            +0.4        0.44 ±  3%  perf-profile.children.cycles-pp.os_xsave
      0.00            +0.4        0.45 ± 13%  perf-profile.children.cycles-pp.pick_task_fair
      0.00            +0.5        0.47 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.5        0.49 ±  4%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.00            +0.5        0.49 ±  4%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.00            +0.5        0.52 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.6        0.58 ±  3%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.00            +0.6        0.59 ±  3%  perf-profile.children.cycles-pp.prepare_task_switch
      0.00            +0.7        0.70 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.7        0.74 ±  4%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.7        0.75 ±  3%  perf-profile.children.cycles-pp.set_next_entity
      0.16 ±  7%      +0.8        0.93        perf-profile.children.cycles-pp.rb_erase
      0.00            +0.8        0.80 ±  3%  perf-profile.children.cycles-pp.set_next_task_fair
      1.20 ±  9%      +0.8        2.01 ± 22%  perf-profile.children.cycles-pp.__x64_sys_timer_getoverrun
      0.37 ±  4%      +0.8        1.20 ±  2%  perf-profile.children.cycles-pp.timerqueue_del
      0.39            +0.9        1.34        perf-profile.children.cycles-pp.timerqueue_add
      0.00            +1.0        0.96        perf-profile.children.cycles-pp.queue_event
      0.00            +1.0        0.96        perf-profile.children.cycles-pp.__remove_hrtimer
      0.00            +1.0        0.96        perf-profile.children.cycles-pp.ordered_events__queue
      0.00            +1.0        0.99        perf-profile.children.cycles-pp.process_simple
      0.54            +1.0        1.55 ±  2%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +1.1        1.10 ±  4%  perf-profile.children.cycles-pp.update_curr
      3.85 ±  2%      +1.3        5.14 ± 12%  perf-profile.children.cycles-pp.get_signal
      6.63            +1.5        8.14 ±  8%  perf-profile.children.cycles-pp.timer_getoverrun
      0.00            +1.5        1.55 ±  2%  perf-profile.children.cycles-pp.reader__read_event
      0.00            +1.6        1.55 ±  2%  perf-profile.children.cycles-pp.perf_session__process_events
      0.00            +1.6        1.58        perf-profile.children.cycles-pp.enqueue_entity
      0.00            +1.6        1.62 ±  3%  perf-profile.children.cycles-pp.update_load_avg
      2.27 ±  4%      +1.9        4.17 ± 11%  perf-profile.children.cycles-pp.dequeue_signal
      0.00            +2.0        2.02 ±  3%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.29 ±  8%      +2.1        3.39 ± 11%  perf-profile.children.cycles-pp.posixtimer_deliver_signal
      0.00            +2.4        2.38 ±  3%  perf-profile.children.cycles-pp.__pick_next_task
      0.00            +2.5        2.51        perf-profile.children.cycles-pp.dequeue_entity
      0.30            +7.2        7.55 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock
      1.28            +9.3       10.58 ±  9%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.16 ±  2%     +12.6       12.80 ± 11%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.00           +12.7       12.70 ± 11%  perf-profile.children.cycles-pp.dl_server_stop
     23.48           +15.2       38.72        perf-profile.children.cycles-pp.clock_nanosleep
      0.00           +15.4       15.41 ±  9%  perf-profile.children.cycles-pp.dequeue_entities
      0.00           +15.5       15.52 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
     22.67           +17.1       39.75 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      6.33           +19.4       25.76 ±  9%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.00           +19.9       19.88 ±  6%  perf-profile.children.cycles-pp.schedule
      0.00           +19.9       19.89 ± 13%  perf-profile.children.cycles-pp.start_dl_timer
     15.33           +20.0       35.34 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.00           +20.4       20.43 ± 13%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.00           +20.5       20.47 ± 13%  perf-profile.children.cycles-pp.dl_server_start
     13.08           +20.6       33.70 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     10.70           +21.5       32.25 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.79 ±  4%     +22.6       25.39 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.00           +22.7       22.69 ± 11%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.00           +22.8       22.76 ± 11%  perf-profile.children.cycles-pp.enqueue_task
      0.00           +22.9       22.87 ± 11%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.00           +23.2       23.24 ±  4%  perf-profile.children.cycles-pp.do_nanosleep
      2.70 ±  2%     +23.5       26.16 ±  9%  perf-profile.children.cycles-pp.posix_timer_fn
      2.01           +23.6       25.65 ±  9%  perf-profile.children.cycles-pp.send_sigqueue
      4.05 ±  3%     +23.7       27.75 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00           +23.7       23.73 ±  4%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.00           +23.9       23.86 ±  3%  perf-profile.children.cycles-pp.common_nsleep
      0.59 ±  2%     +24.2       24.82 ± 10%  perf-profile.children.cycles-pp.complete_signal
      0.12 ±  6%     +24.4       24.55 ± 10%  perf-profile.children.cycles-pp.try_to_wake_up
      0.00           +24.6       24.58 ±  3%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.00           +29.9       29.88 ± 14%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.00           +32.1       32.06 ±  7%  perf-profile.children.cycles-pp.finish_task_switch
      0.00           +34.2       34.22 ±  6%  perf-profile.children.cycles-pp.start_secondary
      0.00           +34.2       34.22 ±  6%  perf-profile.children.cycles-pp.schedule_idle
      0.00           +34.2       34.23 ±  6%  perf-profile.children.cycles-pp.common_startup_64
      0.00           +34.2       34.23 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00           +34.2       34.23 ±  6%  perf-profile.children.cycles-pp.do_idle
      0.00           +53.8       53.75 ±  6%  perf-profile.children.cycles-pp.__schedule
      6.86            -4.4        2.43 ±  7%  perf-profile.self.cycles-pp.clear_bhb_loop
      4.96 ±  3%      -4.2        0.74 ±  7%  perf-profile.self.cycles-pp.fpu__clear_user_states
      7.14            -4.0        3.14 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      3.93            -2.8        1.10 ±  8%  perf-profile.self.cycles-pp.__restore_fpregs_from_user
      4.34            -2.8        1.56 ±  8%  perf-profile.self.cycles-pp._copy_from_user
      5.84            -2.5        3.34 ±  8%  perf-profile.self.cycles-pp.lapic_next_deadline
      3.64            -2.5        1.18 ±  7%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      2.40 ±  3%      -1.9        0.52 ±  5%  perf-profile.self.cycles-pp.stress_timer_handler
      1.83 ±  6%      -1.8        0.08 ±  8%  perf-profile.self.cycles-pp.signal_setup_done
      1.98 ±  2%      -1.7        0.26 ± 10%  perf-profile.self.cycles-pp.fpregs_mark_activate
      2.50            -1.5        1.02 ±  7%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.82            -1.1        0.68 ±  7%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.51            -1.1        0.42 ±  8%  perf-profile.self.cycles-pp.__put_user_nocheck_4
      1.41 ±  3%      -1.0        0.40 ±  7%  perf-profile.self.cycles-pp.x64_setup_rt_frame
      1.40            -1.0        0.39 ±  7%  perf-profile.self.cycles-pp.__get_user_nocheck_4
      1.34            -1.0        0.37 ±  8%  perf-profile.self.cycles-pp.__get_user_nocheck_8
      2.10            -0.9        1.20 ±  8%  perf-profile.self.cycles-pp.native_apic_msr_eoi
      1.15            -0.8        0.33 ±  7%  perf-profile.self.cycles-pp.get_sigframe
      1.50            -0.8        0.68 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      1.01            -0.7        0.28 ±  8%  perf-profile.self.cycles-pp.check_xstate_in_sigframe
      0.99            -0.7        0.28 ±  6%  perf-profile.self.cycles-pp.save_xstate_epilog
      1.01            -0.6        0.38 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.83            -0.6        0.27 ±  7%  perf-profile.self.cycles-pp._copy_to_user
      0.93            -0.5        0.39 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.69            -0.5        0.20 ± 10%  perf-profile.self.cycles-pp.timer_settime
      2.02            -0.5        1.54 ±  6%  perf-profile.self.cycles-pp.read_tsc
      1.08            -0.5        0.62 ±  9%  perf-profile.self.cycles-pp.get_signal
      0.53            -0.4        0.10 ±  9%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.91            -0.4        0.48 ±  5%  perf-profile.self.cycles-pp.rseq_update_cpu_node_id
      0.89            -0.4        0.46 ± 15%  perf-profile.self.cycles-pp.recalc_sigpending
      0.65            -0.4        0.23 ±  9%  perf-profile.self.cycles-pp.sigpending
      0.65            -0.4        0.28 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.55 ±  9%      -0.3        0.22 ± 19%  perf-profile.self.cycles-pp.sync_regs
      0.71            -0.3        0.41 ±  8%  perf-profile.self.cycles-pp.__hrtimer_init
      0.42            -0.3        0.12 ± 11%  perf-profile.self.cycles-pp.handle_signal
      0.60            -0.3        0.31 ±  7%  perf-profile.self.cycles-pp.__put_user_8
      0.41            -0.3        0.12 ± 12%  perf-profile.self.cycles-pp.do_timer_settime
      0.39            -0.3        0.11 ±  9%  perf-profile.self.cycles-pp.restore_sigcontext
      0.42            -0.3        0.14 ±  8%  perf-profile.self.cycles-pp.__x64_sys_rt_sigreturn
      0.50 ±  2%      -0.3        0.24 ±  7%  perf-profile.self.cycles-pp.tick_program_event
      0.55            -0.3        0.28 ±  6%  perf-profile.self.cycles-pp.x64_sys_call
      0.36            -0.3        0.10 ± 14%  perf-profile.self.cycles-pp.common_timer_set
      0.32 ±  2%      -0.2        0.09 ±  7%  perf-profile.self.cycles-pp.restore_fpregs_from_user
      0.54            -0.2        0.32 ±  8%  perf-profile.self.cycles-pp.clockevents_program_event
      0.61            -0.2        0.39 ± 22%  perf-profile.self.cycles-pp.send_sigqueue
      0.31            -0.2        0.10 ±  7%  perf-profile.self.cycles-pp.get_itimerspec64
      0.46 ±  3%      -0.2        0.26 ±  7%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.54            -0.2        0.34 ±  5%  perf-profile.self.cycles-pp.__get_user_8
      0.68            -0.2        0.48 ± 15%  perf-profile.self.cycles-pp.timer_getoverrun
      0.55 ±  5%      -0.2        0.36 ± 16%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.28            -0.2        0.08 ±  8%  perf-profile.self.cycles-pp.common_hrtimer_arm
      0.46            -0.2        0.27 ±  7%  perf-profile.self.cycles-pp.error_entry
      0.58            -0.2        0.39 ±  8%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.62            -0.2        0.44 ±  6%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.26 ±  2%      -0.2        0.08 ± 11%  perf-profile.self.cycles-pp.__x64_sys_rt_sigpending
      0.27            -0.2        0.10 ± 10%  perf-profile.self.cycles-pp.__x64_sys_timer_settime
      0.24 ±  2%      -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.rep_stos_alternative
      0.30 ±  2%      -0.2        0.13 ± 15%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.72 ±  3%      -0.2        0.55 ±  6%  perf-profile.self.cycles-pp.ktime_get
      0.23            -0.2        0.06 ± 11%  perf-profile.self.cycles-pp.restore_altstack
      0.33            -0.2        0.17 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.22            -0.2        0.06 ± 11%  perf-profile.self.cycles-pp.set_current_blocked
      0.22 ±  2%      -0.2        0.06 ±  6%  perf-profile.self.cycles-pp.__fpu_restore_sig
      0.40            -0.2        0.25 ±  9%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.21 ±  4%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.28            -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      0.34 ±  2%      -0.1        0.21 ±  7%  perf-profile.self.cycles-pp.dequeue_signal
      0.19 ±  2%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.do_sigpending
      0.23            -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.arch_do_signal_or_restart
      0.27            -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.rseq_ip_fixup
      0.25            -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.prepare_signal
      0.36            -0.1        0.25 ±  7%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.16 ±  3%      -0.1        0.05 ± 45%  perf-profile.self.cycles-pp.fpu__restore_sig
      0.22            -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.25            -0.1        0.16 ±  7%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.22            -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.posix_timer_fn
      0.76            -0.1        0.67 ±  5%  perf-profile.self.cycles-pp.native_sched_clock
      0.15 ±  2%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.rseq_get_rseq_cs
      0.18            -0.1        0.11 ± 11%  perf-profile.self.cycles-pp.hrtimer_reprogram
      0.12 ±  3%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.sigismember
      0.10 ±  4%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__cond_resched
      0.24 ±  2%      -0.0        0.19 ±  7%  perf-profile.self.cycles-pp.posixtimer_deliver_signal
      0.15 ±  2%      -0.0        0.12 ±  8%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.28 ±  2%      -0.0        0.25 ±  5%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.09 ±  5%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.irqentry_enter
      0.09            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.08 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.12 ±  4%      -0.0        0.09 ± 20%  perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.sched_clock
      0.09            +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.enqueue_task
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.perf_swevent_event
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.raw_spin_rq_unlock
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.perf_trace_buf_update
      0.00            +0.1        0.06 ± 18%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.list_add_leaf_cfs_rq
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.put_prev_entity
      0.17 ±  2%      +0.1        0.23 ± 17%  perf-profile.self.cycles-pp.__x64_sys_timer_getoverrun
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.get_timespec64
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.__ordered_events__flush
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.13 ±  2%      +0.1        0.20 ±  6%  perf-profile.self.cycles-pp.enqueue_hrtimer
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.pick_next_task
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.error_return
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.reader__read_event
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.__update_idle_core
      0.13 ±  5%      +0.1        0.22 ±  6%  perf-profile.self.cycles-pp.timerqueue_del
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.update_entity_lag
      0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.update_curr_se
      0.00            +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.cpuacct_charge
      0.00            +0.1        0.09 ±  8%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.vruntime_eligible
      0.00            +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.hrtimer_forward
      0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.set_next_task_fair
      0.00            +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.00            +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.evlist__event2evsel
      0.00            +0.1        0.10 ±  6%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.10 ±  9%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.schedule_idle
      0.00            +0.1        0.11 ±  8%  perf-profile.self.cycles-pp.pick_eevdf
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.enqueue_dl_entity
      0.00            +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.__enqueue_entity
      0.38 ±  2%      +0.1        0.50 ±  7%  perf-profile.self.cycles-pp.hrtimer_start_range_ns
      0.00            +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.task_non_contending
      0.00            +0.1        0.13 ±  9%  perf-profile.self.cycles-pp.perf_tp_event
      0.17 ±  3%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.00            +0.1        0.13 ±  4%  perf-profile.self.cycles-pp.common_nsleep
      0.11 ±  3%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.1        0.13 ±  8%  perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.13 ±  7%  perf-profile.self.cycles-pp.set_next_entity
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__remove_hrtimer
      0.00            +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.00            +0.1        0.14        perf-profile.self.cycles-pp.rcu_note_context_switch
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.dl_scaled_delta_exec
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__pick_next_task
      0.00            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.update_min_vruntime
      0.00            +0.2        0.15 ±  5%  perf-profile.self.cycles-pp.evsel__parse_sample
      0.00            +0.2        0.15 ±  2%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.13 ±  7%      +0.2        0.28 ±  2%  perf-profile.self.cycles-pp.idle_cpu
      0.00            +0.2        0.16 ±  8%  perf-profile.self.cycles-pp.stress_timer
      0.00            +0.2        0.17 ±  4%  perf-profile.self.cycles-pp.__dequeue_entity
      0.00            +0.2        0.18 ± 12%  perf-profile.self.cycles-pp.pick_task_fair
      0.00            +0.2        0.18 ±  5%  perf-profile.self.cycles-pp.schedule
      0.00            +0.2        0.19 ±  6%  perf-profile.self.cycles-pp.__calc_delta
      0.00            +0.2        0.20 ±  5%  perf-profile.self.cycles-pp.___perf_sw_event
      0.00            +0.2        0.20 ±  5%  perf-profile.self.cycles-pp.update_rq_clock_task
      1.41            +0.2        1.61 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.00            +0.2        0.21 ±  2%  perf-profile.self.cycles-pp.avg_vruntime
      0.00            +0.2        0.21 ±  6%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.00            +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.start_dl_timer
      0.00            +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.dequeue_entities
      0.00            +0.2        0.24 ±  5%  perf-profile.self.cycles-pp.hrtimer_nanosleep
      0.00            +0.2        0.24 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.00            +0.2        0.24        perf-profile.self.cycles-pp.resched_curr
      0.00            +0.2        0.24 ±  4%  perf-profile.self.cycles-pp.reweight_entity
      0.00            +0.2        0.24 ± 19%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.00            +0.2        0.24 ±  8%  perf-profile.self.cycles-pp.__nanosleep
      0.00            +0.3        0.25 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
      0.00            +0.3        0.26 ± 11%  perf-profile.self.cycles-pp.clock_nanosleep
      0.07 ±  5%      +0.3        0.34 ±  3%  perf-profile.self.cycles-pp.rb_insert_color
      0.00            +0.3        0.28 ±  4%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.00            +0.3        0.28 ±  5%  perf-profile.self.cycles-pp.__x64_sys_clock_nanosleep
      0.00            +0.3        0.30 ±  5%  perf-profile.self.cycles-pp.prepare_task_switch
      0.00            +0.3        0.30 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      0.28            +0.4        0.64 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.05 ±  8%      +0.4        0.42 ±  2%  perf-profile.self.cycles-pp.hrtimer_try_to_cancel
      0.00            +0.4        0.36 ±  2%  perf-profile.self.cycles-pp.sched_balance_newidle
      0.11 ±  3%      +0.4        0.48 ±  3%  perf-profile.self.cycles-pp.hrtimer_active
      0.00            +0.4        0.40 ± 16%  perf-profile.self.cycles-pp.do_nanosleep
      0.00            +0.4        0.42 ±  5%  perf-profile.self.cycles-pp.dequeue_entity
      0.00            +0.4        0.44 ±  3%  perf-profile.self.cycles-pp.os_xsave
      0.00            +0.4        0.44 ±  3%  perf-profile.self.cycles-pp.update_curr
      0.44            +0.5        0.92 ±  2%  perf-profile.self.cycles-pp.__hrtimer_start_range_ns
      0.00            +0.5        0.49 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.5        0.53 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.00            +0.6        0.56 ±  3%  perf-profile.self.cycles-pp.update_load_avg
      0.31 ±  2%      +0.7        0.98        perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.7        0.70 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.00            +0.7        0.71 ±  4%  perf-profile.self.cycles-pp.__switch_to
      0.12 ± 10%      +0.8        0.89        perf-profile.self.cycles-pp.rb_erase
      0.00            +0.9        0.95        perf-profile.self.cycles-pp.queue_event
      0.00            +1.3        1.30 ±  5%  perf-profile.self.cycles-pp.__schedule
      0.00            +1.9        1.94 ±  3%  perf-profile.self.cycles-pp.finish_task_switch
      0.00           +29.9       29.86 ± 14%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


