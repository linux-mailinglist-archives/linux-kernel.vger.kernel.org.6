Return-Path: <linux-kernel+bounces-178501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8888C4E98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6284D1F22AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394E953E33;
	Tue, 14 May 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pj8RztkA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D574F88C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678369; cv=fail; b=BTGp7XQKKy94qlhd//zXRp3wc8hGI7RbA7Q8CxpuO+V+L1GP8qI3v4ndMS9yrJB2F0YAqUY4ZP/yUgJH7cdVb1wyRNwifXGr80xrWKp/L1QOiqq+Cs0ztGh1fQJUZSfWvYVEplV2sTy7AdpTDLFkVGrmx6DB9Vq3ZmX4qxu80qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678369; c=relaxed/simple;
	bh=wwQi6MouFCRXi7qKQqCqKrFaM0zNU6L1BfR2VRaLFiM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V2p4Iw41ZSLDsSdy4v/vUy0eaKT08I0mrelkGJcVyktx3C4LORyzAjn+rgWkGmjDxV1CpNx6RiNuepVF+6dP5HWMf31nLuKllRWcRqOZMKP/uHYIkR1clcVZdz9aO/5wwzAXyjevw9iX7ozxRBmvNj6mvAo34iXUrqlouWEza1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pj8RztkA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715678367; x=1747214367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wwQi6MouFCRXi7qKQqCqKrFaM0zNU6L1BfR2VRaLFiM=;
  b=Pj8RztkA8Cw6U5oVNAiIqKWUDySR+6VEpeU41jEt7sG/JCRcklH43887
   tF/OL4hfvM+CjCvOy2Ou9wZ0Js4Y9d6T8s6NqUDZRVU0GQNMRjhsEEx34
   yWWY2nDZZxlixbJzMhfLOP0E1tqr05CZrJXPncNL0CtcEvHPyW/vbMhci
   jaUvaYbxf8L4/35CwDaSQRNKbfv4W0dQjcw9P85PL+JNljaYxhHP1JisT
   Tl6P9IYCXe4myXKQ9W2V32klSdjZ3ulX8Bub4t94f5XebivmrFSOx8TO/
   WvGDGqpePH3mKsU92DjqlKEFefFqZ0Vo/l5I0y5rpENHwAwx0ZbYGYxNO
   w==;
X-CSE-ConnectionGUID: VSxHq5yhTwqZPK0i8PCVhg==
X-CSE-MsgGUID: 2VMCGtZ0TlChxllN+Xg3uQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11771091"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11771091"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 02:19:23 -0700
X-CSE-ConnectionGUID: 3REOJ3BQRGGBJqkni9VsXw==
X-CSE-MsgGUID: Tno/ibxpQ+CLe45Y7YFDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35164978"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 May 2024 02:19:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 02:19:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 02:19:19 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 02:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYWNppejIpyBvhKs2IYiiuykkerthJrfyV7q+0cwWdBldWK0FDOGGelp2xRrnr3mX5SjHarLgayKqmk62gFrs7V7XbFB38JR4EM8JFHiQCmyhHjw60pBXejOjTKMPBYuoy0CxbKtlVogK+ZThNPXxDhV+KmXusN7wT298hTUPDdLJIqeGnkUeBkoeYfutoHCRZGicYh6/QGjhQZY2d+y25OCad+qtHGcrWztKaW2lfjTvUV4myciP1uTPRMiBbe3t7Uw+pMWjhY4Zjt+7sbThbRjRcv1rGdoPPe+mYMgvoYDbF5bbx8LBt4DecxjQg+7a0a3Hsb1hEJTdVedN1/dZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjDkV0y0umEV8tyk7Avo9W74znX7MOVNNDSyAaExwIM=;
 b=coRPDmI7/vDgtKnSxorHIVs1dKr8ik5YuhV19fVg77UtL3Vp+d/7ty+brQLhB0s2uQRyG2HawxD5KJ/OWSx1enbMbAfjNmWA1D4hTY8Kmt4orfEYi2oiJ2Lw+uGmZQ3rXWOxpCkFqw+diwuCsfu6QF6Gxxd83zWQtggOzwvkCjm5XNb5eKG8jlLDGVsFLNCUrXmGiA7ueaSY4yf9DSMDY1kM/M+mwi6gCMjqPcRGDancioawbhanOF6PFGAEGrE0pjfeZSW377bE180mEgT1qLAZTER5H1gLYJSCSrY+1U/J8QsP8dPduT2GjCVLBtv/paRzBFxgbYh8klu1N8ozVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MN0PR11MB6159.namprd11.prod.outlook.com (2603:10b6:208:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 09:19:12 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 09:19:12 +0000
Date: Tue, 14 May 2024 17:18:55 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Peter Zijlstra <peterz@infradead.org>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, <wuyun.abel@bytedance.com>,
	<tglx@linutronix.de>, <efault@gmx.de>, <tim.c.chen@intel.com>,
	<yu.c.chen.y@gmail.com>
Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to
 set request/slice suggestion
Message-ID: <ZkMsf4Fz7/AFoQfC@chenyu5-mobl2>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.934104715@infradead.org>
 <ZjpFruUiBiNi6VSO@chenyu5-mobl2>
 <422fc38c-6096-8804-17ce-1420661743e8@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <422fc38c-6096-8804-17ce-1420661743e8@amd.com>
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MN0PR11MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be5420d-0e45-45e7-0c3a-08dc73f6eaf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q9fpMUzDwNW6oGhQcFBYJOSz0ZhJONK1HO/0vrDLTBFNpnVPhGKdRpju8Eb5?=
 =?us-ascii?Q?NJSUNKeJ5bJAgxn+wMg1vwLlb12+mab58m2v1Rvv71uXCVHguCDZaQFNSPW2?=
 =?us-ascii?Q?sQTKHjylV5h82yMubf6fjxT+YV10+Szn+/y9At/9Ryc37MAu16HeKjR5TE3A?=
 =?us-ascii?Q?nCi5ylVU/0Kh5EhvyhQKGQlSIpzSjbelROeGBbuz5hgoUzyTupLqBfgoV2k9?=
 =?us-ascii?Q?ve04nJS6ysqdFa5NBOt3ZCMtzsVCRC/C8epzpHPb8ZBvW4NfT5Jgz2dPtG/4?=
 =?us-ascii?Q?dz9iyChLFRG8TCEx2MtA+F1z9jCNlwoTrix6B6Hgk+9/Em/xJMMiREYf7y3q?=
 =?us-ascii?Q?O49p9fPwm+FKvHxKEGThsFFXTzXOi4vvgaxeYT0cCx4rAY/uQAk8rh+g8e/i?=
 =?us-ascii?Q?zjvosYZz1Sn3BKcojXd+B0PK/lS1Oxh30vt9bLIJkRXtSJPgrQ1uhze/MiZU?=
 =?us-ascii?Q?XpQ5rQ050rZkHZClcEcNb+7pKk1pu6K6llGGQByD4CmH3nJMlXffRa6vcFtR?=
 =?us-ascii?Q?0HHDw3ZC8nhzRARgLEoYZJH/ziBP7k9km7KFSQts4oFXYop5XXfTQjQO0AHY?=
 =?us-ascii?Q?Llie3W3e8Q/I0IwVTd0skITxvz9Dd7l7jLcEkVySpMI8zGhCn1QkvRkss11s?=
 =?us-ascii?Q?wstEW2NhHJ8No6JuDWJX0Nszj8sZanftmmprkxyeMlsuMv+WLapnB/lIhu8m?=
 =?us-ascii?Q?3s47/HMrjdv+o6+MIqDOuT8qLlkjmugIat42OswmP3Md26KRjWD1zK0LfFXr?=
 =?us-ascii?Q?8ajfYaSHQMwbWI6R0J8DLyNyw/KJZh+Qf5axVw5sVvhZJvYCZZ3Nc5SBvVUB?=
 =?us-ascii?Q?NgnLj4e1aQ4/H+P5GQ9465xXm4I3wpkpVTIpV3BHujd6RGIYB4TLEMLe9lKU?=
 =?us-ascii?Q?mdq39x5RsT8Bfn1/QY9Z3XMFQJ1x3AHWVCFDjbxGdYV5qcfAZhyN+1yCSe36?=
 =?us-ascii?Q?Pc8k/K4VKllRjYBaswiPp6EHiuVrMUXXSmQu3wFb2W10zy9OM1fyOTTJ+iBI?=
 =?us-ascii?Q?xAyhtHdvInVt3qmEQiBK8RPwwPKY55s+V0ZTIZXDFIT2kzUBaYKvs0LuZljD?=
 =?us-ascii?Q?kwZXuDSmLZrhW//AU3NfKy42k/t5XuKpEMHcq8zAW9w7hxVL6ixn77HbTcov?=
 =?us-ascii?Q?SAY7GQCtVaMDksts+sj2ZI2dqj/Ar2JRAUfDTZxmToB8rFz4DcErd0hQMtfd?=
 =?us-ascii?Q?Q9lBMqzB0QcrmaJCsb1bmqCJKu2a7TIqeLj4otdZRepkUqcmm+zK9kLrL4Jd?=
 =?us-ascii?Q?WvvkzcQrpbl2l1wtQUpN4PVJwmiDeOljpHtnJ20yFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPgTriCZquiYdVhFzpnx2RcoASu3M0rtsGLmfSc5/GWmXaXqHAoiaFe1jHg8?=
 =?us-ascii?Q?+cghqEit1Aotwt0hCQs+eiGUv+D5Px/o9ylEYYd5kxEx3yF9fhOgc4svKoPl?=
 =?us-ascii?Q?yK6VlO2k42Nd9x0DpP7C5whOskC34RnTVx0TigSJnxMI9CsXGOMd/NgBJz5s?=
 =?us-ascii?Q?8Q1exFPGTrTysZMvFN20+eA9dls57UlT8/xBMY8IKT266EFsIHNR2l/lvign?=
 =?us-ascii?Q?5xj9GQFQ3N44NzJ7mAVDu3c1cV+ljcdf9W7tz3aEdko1xSp2lVMJt0dvczhY?=
 =?us-ascii?Q?lTU2nMRSCbPpOQmQkw/Unib4E8In4swax/MlGu7fCf719YrW0PZPFXktNx5T?=
 =?us-ascii?Q?54Et/VsmFsjtuuxSr1ayI2ObKYrQZDcrmuMjBQBmngEpSv8vvWl5nekaZr8O?=
 =?us-ascii?Q?Dc2ag3qIflIfEHT2FrmZDgpdc2X8Z6O82TX+Sh5CE1LXuLZnZKx4FJXQKuQB?=
 =?us-ascii?Q?Dj/PYS/qiYB4WfteJkNDJTBefbawfSkxxR8HzYM7+BsadBWfOmoT6zaFrMjN?=
 =?us-ascii?Q?yXPum5smf2hegUqfKmlLGIOxcKmVoj27oEa7UupmiK5LDbyAgIrxIRlV4Zmb?=
 =?us-ascii?Q?UqYhNvIDkGXC/WPkPrhOZQ4YisVuM3mc82XVUOVNptgLVGSFXdt4rIVirHCb?=
 =?us-ascii?Q?sLZMd0P1/3k/pRw8MNQ16JpYxNiNd1tsCqQ/5N7RChnoFbZ2ZF494nwO+II5?=
 =?us-ascii?Q?gDP5vnGymtyWGv9H915yjKuzOSqU+gbFYtwDxhqXYGBgL9OKAI4gd8wuGmPG?=
 =?us-ascii?Q?2oSpvxSTKcr9ye0EiXmRhbBg888uZv/b+sjwG/suoijMY//B0pz/jmrrRCvM?=
 =?us-ascii?Q?5U5Z+118CfI4RQSoFnQvii9ClX9ZQ85fWS/NLO3vRCI6nmmQo95RI3HpNp4e?=
 =?us-ascii?Q?vX3oTfDFbmqyTfyA+czMa7jSQF2GFdxc2/IK/6WcEChoUXSM8Eehvkfk+g4I?=
 =?us-ascii?Q?L2prNUm91Est0rUmj/KrXDS6GA98AevMINRSKuvceM36h61oed3lhC7wqwiv?=
 =?us-ascii?Q?viY10DlJE79v0rmpaUlheT/MThlKItB2EqFCb9Jvkv+rD/2YMzN+9zi3J34X?=
 =?us-ascii?Q?8y3G9xrg2sLyiO9TSvaAZ1UzvT/6RRXqlNWhx8HSeEty7MhsByhp0fVavX8H?=
 =?us-ascii?Q?sr2fN2Jra0opwmLKg7X6tfS6eNLGUUoknzmI+weC6yc+LCLe3Sd07XyBniyx?=
 =?us-ascii?Q?X3PASXelHZsw02ufGtcMHmkqGbvLaf5vYDoIrUUcAQN1gF74QKrohnNyuOpc?=
 =?us-ascii?Q?j7IacyL21n3LiwrsAkRPeeUzMw+x6losc9l9LjX4+dPrQsxONbMPvQr0tOkS?=
 =?us-ascii?Q?JdL0BgUWQdlX+8cgXP3+LTvhuRO+yfWSgOpjDjsgwfpjprBDgW/H+Nq4v4YQ?=
 =?us-ascii?Q?laeZax0qzp7IXSO7v+0qJxvv4WcMPll8kK4jVJyR76MEpAJFbFpAmhyGoGZw?=
 =?us-ascii?Q?ksx3rLYMlLeVA9NrlhPZaOGpgJL+tOKY6gVjJ0MdxZKN9g1erQBxrT05ES2b?=
 =?us-ascii?Q?i36L6/TOaWL7yow2Z4Kml2VTucUzThZdRRHdHQLGKN88tt4MR6I+cM4ceB3s?=
 =?us-ascii?Q?OL/d1Masht2zmtXoguRYmxYFBxdS583H3tFu4PpM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be5420d-0e45-45e7-0c3a-08dc73f6eaf9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 09:19:12.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZt+O6WCS/thfWM/RNifEsWQwP5C5H0BIpVhu0/ODeqDGaIh9phVyt/PCaMg+/tr38w0mYKVW1WzDC2MZalImQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6159
X-OriginatorOrg: intel.com

Hi Prateek,

On 2024-05-13 at 09:37:07 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 5/7/2024 8:45 PM, Chen Yu wrote:
> > On 2024-04-05 at 12:28:04 +0200, Peter Zijlstra wrote:
> >> Allow applications to directly set a suggested request/slice length using
> >> sched_attr::sched_runtime.
> >>
> >> The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
> >> which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.
> >>
> >> Applications should strive to use their periodic runtime at a high
> >> confidence interval (95%+) as the target slice. Using a smaller slice
> >> will introduce undue preemptions, while using a larger value will
> >> increase latency.
> >>
> >> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>
> > 
> > Is it possible to leverage this task slice to do better task wakeup placement?
> > The idea is that, the smaller the slice the wakee has, the less idle CPU it
> > should scan. This can reduce wake latency and inhibit costly task migration,
> > especially on large systems.
> > 
> > We did some experiments and got some performance improvements:
> > 
> > 
> > From 9cb806476586d7048fcbd0f66d0101f0dbb8fd2b Mon Sep 17 00:00:00 2001
> > From: Chen Yu <yu.c.chen@intel.com>
> > Date: Tue, 7 May 2024 22:36:29 +0800
> > Subject: [RFC PATCH] sched/eevdf: Use customized slice to reduce wakeup latency
> >  and inhibit task migration
> > 
> > Problem 1:
> > The overhead of task migration is high on many-core system. The overhead
> > brings performance penalty due to broken cache locality/higher cache-to-cache
> > latency.
> > 
> > Problem 2:
> > During wakeup, the time spent on searching for an idle CPU is costly on
> > many-core system. Besides, access to other CPU's rq statistics brings
> > cace contention:
> > 
> > available_idle_cpu(cpu) -> idle_cpu(cpu) -> {rq->curr, rq->nr_running}
> > 
> > Although SIS_UTIL throttles the scan depth based on system utilization,
> > there is requirement to further limit the scan depth for specific workload,
> > especially for short duration wakee.
> > 
> > Now we have the interface to customize the request/slice. The smaller the
> > slice is, the earlier the task can be picked up, and the lower wakeup latency
> > the task expects. Leverage the wakee's slice to further throttle the
> > idle CPU scan depth - the shorter slice, the less CPUs to scan.
> > 
> > Test on 240 CPUs, 2 sockets system. With SNC(sub-numa-cluster) enabled,
> > each LLC domain has 60 CPUs. There is noticeable improvement of netperf.
> > (With SNC disabled, more improvements should be seen because C2C is higher)
> > 
> > The global slice is 3 msec(sysctl_sched_base_slice) by default on my ubuntu
> > 22.04, and the customized slice is set to 0.1 msec for both netperf and netserver:
> > 
> > for i in $(seq 1 $job); do
> > 	netperf_slice -e 100000 -4 -H 127.0.01 -t TCP_RR -c -C -l 100 &
> > done
> > 
> > case            	load    	baseline(std%)	compare%( std%)
> > TCP_RR          	60-threads	 1.00 (  1.60)	 +0.35 (  1.73)
> > TCP_RR          	120-threads	 1.00 (  1.34)	 -0.96 (  1.24)
> > TCP_RR          	180-threads	 1.00 (  1.59)	+92.20 (  4.24)
> > TCP_RR          	240-threads	 1.00 (  9.71)	+43.11 (  2.97)
> > 
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/sched/fair.c     | 23 ++++++++++++++++++++---
> >  kernel/sched/features.h |  1 +
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index edc23f6588a3..f269ae7d6e24 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7368,6 +7368,24 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> >  
> >  #endif /* CONFIG_SCHED_SMT */
> >  
> > +/*
> > + * Scale the scan number of idle CPUs according to customized
> > + * wakee's slice. The smaller the slice is, the earlier the task
> > + * wants be picked up, thus the lower wakeup latency the task expects.
> > + * The baseline is the global sysctl_sched_base_slice. Task slice
> > + * smaller than the global one would shrink the scan number.
> > + */
> > +static int adjust_idle_scan(struct task_struct *p, int nr)
> > +{
> > +	if (!sched_feat(SIS_FAST))
> > +		return nr;
> > +
> > +	if (!p->se.custom_slice || p->se.slice >= sysctl_sched_base_slice)
> > +		return nr;
> > +
> > +	return div_u64(nr * p->se.slice, sysctl_sched_base_slice);
> > +}
> > +
> >  /*
> >   * Scan the LLC domain for idle CPUs; this is dynamically regulated by
> >   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> > @@ -7384,10 +7402,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  	if (sched_feat(SIS_UTIL)) {
> >  		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> >  		if (sd_share) {
> > -			/* because !--nr is the condition to stop scan */> -			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
> > +			nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan));
> >  			/* overloaded LLC is unlikely to have idle cpu/core */
> > -			if (nr == 1)
> > +			if (nr <= 0)
> 
> I was wondering if this would preserve the current behavior with
> SIS_FAST toggled off? Since the implementation below still does a
> "--nr <= 0" , wouldn't it effectively visit one CPU less overall now?
>
> Have you tried something similar to the below hunk?
> 
> 	/* because !--nr is the condition to stop scan */
> 	nr = adjust_idle_scan(p, READ_ONCE(sd_share->nr_idle_scan)) + 1;
> 	if (nr == 1)
> 		return -1;
>

Yeah, right, to keep the scan depth consistent, the "+1" should be kept.
 
> I agree with Mike that looking at slice to limit scan-depth seems odd.
> My experience with netperf is that the workload cares more about the
> server-client being co-located on the closest cache domain and by
> limiting scan-depth using slice, this is indirectly achieved since all
> the wakeups carry the WF_SYNc flag.
>

Exactly. This is the original motivation.
 
> P.S. have you tried using the slice in __select_idle_cpu()? Similar to
> sched_idle_cpu() check, perhaps an additional sched_preempt_short_cpu()
> which compares rq->curr->se.slice with the waking task's slice and
> returs that cpu if SIS_SHORT can help run the workload quicker?

This is a good idea, it seems to be benefit PREEMPT_SHORT. If the customized
task slice is introduced, we can leverage this hint for latency related
optimization. Task wakeup is one thing, I can also think of other aspects,
like idle load balance, etc. I'm not sure what is the proper usage of the
task slice though, this is why I sent this RFC.

> Note:
> This will not work if the SIS scan itself is the largest overhead in the
> wakeup cycle and not the task placement itself. Previously during
> SIS_UTIL testing, to measure the overheads of scan vs placement, we
> would do a full scan but return the result that SIS_UTIL would have
> returned to determine the overhead of the search itself.
>

Regarding the task placement, do you mean the time between a task is enqueued
and picked up? Do you have any recommendation which workload can expose the
scan overhead most?

thanks,
Chenyu
 
> >  				return -1;
> >  		}
> >  	}
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index 143f55df890b..176324236018 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -50,6 +50,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> >   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> >   */
> >  SCHED_FEAT(SIS_UTIL, true)
> > +SCHED_FEAT(SIS_FAST, true)
> >  
> >  /*
> >   * Issue a WARN when we do multiple update_rq_clock() calls
> 
> --
> Thanks and Regards,
> Prateek

