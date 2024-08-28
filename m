Return-Path: <linux-kernel+bounces-304247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ACE961CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED97B21312
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484B13699A;
	Wed, 28 Aug 2024 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eid943cV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A20433C1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814412; cv=fail; b=J7lW2K+cvnMmUGtcjqdT+pujpvrX3MmpUV1a+68f9U0M2zDC0SeLuABS7TljuXyPfwCPW0CFWtwqJ0yCXhDpu8Uo3PgYMj2tR6GRbQiso0wWnBnorKmwdvmLb/BM6GxdYROTAE2W38YjAUxGBzNZEUOb2XBE35TcbP90WPV00qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814412; c=relaxed/simple;
	bh=G++A+QQbyW/ESM2em4boI4/T5h5MQgRWtTtqJ8U/mhI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ELfevkCzTZ0wu0qKhXpLVyREt/vD6j80W08DzOdFamYuttGAjyk23ryTnQ8dhd351RapFhedQ+LjGYGXLhnogFImdepbRw0P3Ea5LAC4kvXmlXXoPP/Z3h/awqUPzsJZPQRw5gUJ8Cu6oFXgenb1jvKO5gvpMdLq424teksDXhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eid943cV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724814410; x=1756350410;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G++A+QQbyW/ESM2em4boI4/T5h5MQgRWtTtqJ8U/mhI=;
  b=Eid943cVRmgTYYAaBn2BLWwRwkm2sSsYPngO7eLRIww2WTM8zhnwtxwl
   RUzyaHbFuiubH/dwnrjT2y78I9F999HYXaWsFz/kVQ1h8uLB0HmyVAYOh
   fouJYsdL99Ln5/Ag+MCAcyem63O2/ogbfJeb++4cyqsgkH079VCDGeo/O
   CbHsrYgucTLLzzXJkMEhsqOg/Kww1P+vFaF6G8K7l/5waR3yR0oo2XfBg
   HabKHEFB4jJS9tUh4xH2la8ejzdnQ+CqPsXiYn5UddO/EewQxvoMQFic5
   mmf+dxgqNP3TY+03zTwURqj5rfcvEMTVrcuaP5EgUsx484hGnicf/SbZX
   A==;
X-CSE-ConnectionGUID: pZStw8pfQBiuP6OvA1MECA==
X-CSE-MsgGUID: PK2pUPhKQAyn+fRsf0HBVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34481095"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34481095"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 20:06:49 -0700
X-CSE-ConnectionGUID: 75sBk6iJTy+q9Jd6LA3Wig==
X-CSE-MsgGUID: MNXi+ZixQ4uE8RTkfyqaug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63118517"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 20:06:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 20:06:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 20:06:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 20:06:48 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 20:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuuL1uVs62iAqyb+IBYQBo/UDZ3P0Hey6kGrB52IyXZRiwK1RBOX/n3kBKlBnOS+okNmRTJN0+iDx8J35mBe8OQ3HU7Zz4hNhcqFeMWpS4N13uihjCXuWd6x8cvE/8NVraJWV7mNioUf8MMORKW/8U5ASdv+sEkFziWqDoj0xxwM1doybwMPiWr148gmTZKafT3TC1h7+UzQspZLsn0It3lwcyenOcDrJz40U/Mt/cNIYR/+2T9xXkVrQ60fJAt+G1cdJjFCJVMQeF3yqD3CcdQX7uFeYE/ofQYK5S12lR9AXW4ELffF6aGrSUnYydmmhCeZF17kC7BDCaraAR5c3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdYej1aO0h5UP9zYbSjdWjHBr9QtaTQCa+A4PNx29tM=;
 b=mo4ODOujk/37HmRBCLWorxaJ4j4NKJUDlKLeHYMSWpa04BLuZFGVRnyDOVJ/6KaYyGjpJp/hYpTqq7GTPoY35cmZlExgqsdODXYY54qRRrHbMuuEzI8lpQrFvhqRngpU1RDY633cDiRNZjSvRyIfON+h+/nvz+Q9ybtp7NME/giklgh4/ZzaVp3OOpcHDX8hSOX2WInzb92nnUYEvPZIaxVxUzfsLd7kwCVJg50kXw1YJM6exgpSokHMuLxmlEQYXQBscgSPCgHyil9Q1BJ/uvz7l4M4b4KdpPdu4kUKD87G8Z+p0DjXAE88SD47Unb5mqGLGpZclP5J/bjIrbLCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ2PR11MB8297.namprd11.prod.outlook.com (2603:10b6:a03:539::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.24; Wed, 28 Aug 2024 03:06:40 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 03:06:39 +0000
Date: Wed, 28 Aug 2024 11:06:24 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Valentin Schneider
	<vschneid@redhat.com>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
	<youssefesmat@chromium.org>, <tglx@linutronix.de>, <efault@gmx.de>,
	<tim.c.chen@intel.com>
Subject: Re: [PATCH 12/24] sched/fair: Prepare exit/cleanup paths for
 delayed_dequeue
Message-ID: <Zs6UMOT1VMUBIDHg@chenyu5-mobl2>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.631948434@infradead.org>
 <Zs2ZoAcUsZMX2B/I@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zs2ZoAcUsZMX2B/I@chenyu5-mobl2>
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ2PR11MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: 525ab76c-bd58-4737-f85a-08dcc70e6fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VUnq24L0uP3o/ka6tgPUdXYV3oDX+U7IHXZfkJQ7dqstkMKnMH5D+4yGNfer?=
 =?us-ascii?Q?cut9ynI0m/SwRFXoN2UeEDNlSVI6y3D82gotqtM4b6w0FBkZip01qfNaLfPH?=
 =?us-ascii?Q?dclXR3GYBRmNU2KjKEHWtBMhYNS4ISqMrDAI6QYwaUUdjDLVscpgJeeZz7ku?=
 =?us-ascii?Q?QHYeHwV8OnDMvlDW7ZPLljU/0+6Kb7Bkdcju8A+Dg8THavILHuGkZmHXOutA?=
 =?us-ascii?Q?5Ro7UUhyFgGYZWs5WhMX885253hQqU2USv8Xb/KkkUsgpNFrS+c8IZmWCO/r?=
 =?us-ascii?Q?a6/QaNk07t/lf0UiQ2AgcJv4+pbx3z6p/bQInd6ARkmajAxi1xPf3/2DOD3R?=
 =?us-ascii?Q?ZoAeyLFJsrNEYudfF3HbegW7kXtqLUXD0vAVCRcvuj5uwKhIB0B/SAZf+HKS?=
 =?us-ascii?Q?7uEOcju+PnM22T8j4A9cjro60NmN02V+RNX0DhKxCe2pYVnclzw4nBJul8JH?=
 =?us-ascii?Q?JRkG4bWFH4yQmxv2uDCehS+2fxYPdg216fwLDViXB8jf4PKZbYOnBaBQe8Kq?=
 =?us-ascii?Q?bwDk5zDYMmNdlwxlB10bL+JzGlyY52ohwYVrK8Kv/mn9UZ1/1GvK4ggxhFzI?=
 =?us-ascii?Q?st4YUVjm1FXeBYBlZi3ATF2QwNasbDo0ghvItg1gRoCppFkWJIpDRbEJ/5pb?=
 =?us-ascii?Q?2Ads0QM2KM8Md6x+CrOIP9NRuhvOwcVd97JcTiwhRpV9ExtVdZ/mcs5aQDuu?=
 =?us-ascii?Q?zWXTw5TViCJ/CqbNa2HstJhtkucxiCvbrYwx0abjEiD39bx+nX8grAW/p69r?=
 =?us-ascii?Q?4h4D1x6BtjReZYGOthx9Ck5DnH04ThE94MslxzDSw0MzWjLyUk9oiUBcVZca?=
 =?us-ascii?Q?3riUXuiuJvx4s8sTJuSYo5QlCArRqx9S7e5W/yZu6Gnolg/1tll/jjyG3b7L?=
 =?us-ascii?Q?3KilfM4PwnLdmJCL+i4paCIFzybWZ4t11nQXy6V26mRE0MhzT5rDpEQEl+42?=
 =?us-ascii?Q?4n2fJqMTKXNV2X73ONW8QNeZBMnFz6phMcr2MlGEiMQ3CP//zVkDiTgFPbiZ?=
 =?us-ascii?Q?80WQrKYHlefumrJLxpmCVnz6Mi63HdJGEqlctUQtc9qOaafL6TRyrTtEhlCp?=
 =?us-ascii?Q?nQ6NavLiuiTX5dgg+hO/MHk9Aa2Nc+kmou22/egFJKHNBn+e2LOBC9YcBWVO?=
 =?us-ascii?Q?QKDVsYSRx3q9HEIFGoBXj0Zkq3sbB0l3FdvrHnQMDzOiXRmy/uzWNg8414MY?=
 =?us-ascii?Q?tLamOMYPGYr0nmsJLJRk16+MfsLwsI90HdgYSLE3U6VixdVOBPc4e/oOX7ub?=
 =?us-ascii?Q?tIhaFUYNv/cAQlGugUlyZaIPHJyIP80hykq4OneX213Xj4E3Zh1Y92Os51WE?=
 =?us-ascii?Q?S+cCKpaownxvhWC4kn0+9vfvAnizUed6u+i+x/B1Dc8RqvUvcxbgcFfi8L1z?=
 =?us-ascii?Q?4b3Upyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SetT7y6xi7UQMAQ36U1hUuOSyLL2YtSItYNpeoVP1y29VRKwRnd8POyh/YX?=
 =?us-ascii?Q?DlWEITrgtqrfbV9mj3eYDrxDzQ+hTGF7177Z7ErQvaExJkKrm41GyNGY2YQ3?=
 =?us-ascii?Q?PLd7HFUCmkqFaDVFVKrSZaViWu7BN+1EEJQXTpI2yGoKXs9mANEcA6cTEGRx?=
 =?us-ascii?Q?IGreLbfllSLB7xhp+V+KSMBpIVgoiRSUJ4cPhN/u8ncMsNDd7harLReiE1pz?=
 =?us-ascii?Q?cMH9WUzZKlJkZ7TBbn89dUPbqK6j/pN64E/Jo/mXq/Xl7iGptyc0xWbUrEjb?=
 =?us-ascii?Q?qhHnkVSK63nGj0uCVEP+W5+K1+UbJpg2/uEmFb1uc/d34NjpIQpgP7aNbTSQ?=
 =?us-ascii?Q?5EwqdhtvTEVIuwrlt1MNKZH5OJ8xAnwen617aIHKEGXFJeKVs5GSwE1BRtrH?=
 =?us-ascii?Q?hzKUdurGOp5Q1h8vArmuWxTTdxNCsIYvXbuX8TQtvF4kxs1RsbLD2R3R0XG1?=
 =?us-ascii?Q?zD9QZjaTJMaB0pLu5XOgNmtRZ94g6hyxklyRyf7mTSkxWhCqqleJeZruoIp8?=
 =?us-ascii?Q?XtXabKD1m6SQSYt/Iq24Mn3Tzs2fYLuUvMa3L8DBaOSebCv2t73fr8ybp2Ol?=
 =?us-ascii?Q?TuQiL8Cra+TOA2a+I0OWjv5ShVweVjK3kW8kQzLE54D6BbYa0AMQCNNS3KhR?=
 =?us-ascii?Q?Tx2DjuWLx3ZobvBxVNXal3IhSXrD+PFF94zhpSIog03adZtyOvmhFpSWgWL5?=
 =?us-ascii?Q?H7IbDTIJwOoITl6g8hcU/XysWldcqMyUrygngRVCoecTvvEY5oHkdIHW8OpJ?=
 =?us-ascii?Q?PgkSSLwSUnpsWhxj+dXKb+A/ub6wbWFaYpdWd4/0FvG8yMXHKK2SFLJ2mZdY?=
 =?us-ascii?Q?RCtytvj/EvlpgBndCMueWZIWZtJNdNPBKjRKO8LAZKP/6euAwbnTyxzy+Jec?=
 =?us-ascii?Q?dU4bN07df8dFLP4jSVlR0FueSntoFVs7NGQancCjJJ8ShbaXU6ltBTb4dGcX?=
 =?us-ascii?Q?bF8peUXoyhHSDdZGj3uOXR45bgJmppd/WJ5CdGMUOqA8ik0BrZejMak6Fz9D?=
 =?us-ascii?Q?pmanEnN0fKf+ttcH9kI3nIuaks7mHa+Nhjp7ENFpjp2l4KBc5pNiPL0/7hjj?=
 =?us-ascii?Q?7KR/Jq2kgnNOvVJSET1yVvJDYbDUAlR6uTKJ2KdGJAVg0AEe24P5p1RA7KM6?=
 =?us-ascii?Q?E7jf81t+QoV849iRgPP+KQnjqHqDnELLkvDgmQmEfKHriYv/RCIhN29NPgsp?=
 =?us-ascii?Q?qdTQ51OwI8GeE3LWX3ZwJPA2EymjJNCPlIf22xxzctNEIC8IVa0mHW5DU2J4?=
 =?us-ascii?Q?OMXxWazSH0ineYnSfDRF7hG2q0ZL/5Dnzd8aXs5R+nHd+Q21arxkPSO/Dr9q?=
 =?us-ascii?Q?S7ZDpYv8LBlXz1GMWKYpgvWPwgbrEgBguM9hy2kBvLIi9pPe0LQqzQ/miZ6U?=
 =?us-ascii?Q?FiynxZXSI/5D/Haifs5OFQZFiqHw5xJ1n/rlGJrFutotNR1kGo96FKotRJQC?=
 =?us-ascii?Q?WwYE44wK8kxCRWmEUrWy/6PI8FZg4lxcpk4bUqfHMzZw/H7eqIO8J5BMQ2Mc?=
 =?us-ascii?Q?X5Qp6TRd0MT8EUuSMpq17mQrfPjyK4ymwp22v5bR7oLuh0spOLs/QqSTl5t4?=
 =?us-ascii?Q?Xpvov7P8EB7SJHhN2hEM/f6ag3TCkkS3zUwSQ0HM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ab76c-bd58-4737-f85a-08dcc70e6fb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:06:39.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTRMpNivUgM6gQEslBWrkfmRJIM3emiVJ8280d1/ds+gqopdzcwtwN8PpaDOda4EKhEXQjmR1BHpDYcUXHgm1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8297
X-OriginatorOrg: intel.com

On 2024-08-27 at 17:17:20 +0800, Chen Yu wrote:
> On 2024-07-27 at 12:27:44 +0200, Peter Zijlstra wrote:
> > When dequeue_task() is delayed it becomes possible to exit a task (or
> > cgroup) that is still enqueued. Ensure things are dequeued before
> > freeing.
> > 
> > NOTE: switched_from_fair() causes spurious wakeups due to clearing
> > sched_delayed after enqueueing a task in another class that should've
> > been dequeued. This *should* be harmless.
> >
> 
> It might bring some expected behavior in some corner cases reported here:
> https://lore.kernel.org/lkml/202408161619.9ed8b83e-lkp@intel.com/
> As the block task might return from schedule() with TASK_INTERRUPTIBLE.
> 
> We cooked a patch to workaround it(as below).
> 
> thanks,
> Chenyu
>  
> >From 9251b25073d43aeac04a6ee69b590fbfa1b8e1a5 Mon Sep 17 00:00:00 2001
> From: Chen Yu <yu.c.chen@intel.com>
> Date: Mon, 26 Aug 2024 22:16:38 +0800
> Subject: [PATCH] sched/eevdf: Dequeue the delayed task when changing its
>  schedule policy
> 
> [Problem Statement]
> The following warning was reported:
> 
>  do not call blocking ops when !TASK_RUNNING; state=1 set at kthread_worker_fn (kernel/kthread.c:?)
>  WARNING: CPU: 1 PID: 674 at kernel/sched/core.c:8469 __might_sleep
> 
>  handle_bug
>  exc_invalid_op
>  asm_exc_invalid_op
>  __might_sleep
>  __might_sleep
>  kthread_worker_fn
>  kthread_worker_fn
>  kthread
>  __cfi_kthread_worker_fn
>  ret_from_fork
>  __cfi_kthread
>  ret_from_fork_asm
> 
> [Symptom]
> kthread_worker_fn()
>   ...
> repeat:
>   set_current_state(TASK_INTERRUPTIBLE);
>   ...
>   if (work) { // false
>     __set_current_state(TASK_RUNNING);
>     ...
>   } else if (!freezing(current)) {
>     schedule();
>     // after schedule, the state is still *TASK_INTERRUPTIBLE*
>   }
> 
>   try_to_freeze()
>     might_sleep() <--- trigger the warning
> 
> [Analysis]
> The question is after schedule(), the state remains TASK_INTERRUPTIBLE
> rather than TASK_RUNNING. The short answer is, someone has incorrectly
> picked the TASK_INTERRUPTIBLE task from the tree. The scenario is described
> below, and all steps happen on 1 CPU:
> 
> time
>  |
>  |
>  |
>  v
> 
>   kthread_worker_fn()   <--- t1
>     set_current_state(TASK_INTERRUPTIBLE)
>       schedule()
>         block_task(t1)
>           dequeue_entity(t1)
>             t1->sched_delayed = 1
> 
>         t2 = pick_next_task()
>           put_prev_task(t1)
>             enqueue_entity(t1)  <--- TASK_INTERRUPTIBLE in the tree
> 
>   t1 switches to t2
> 
>   erofs_init_percpu_worker()    <--- t2
>     sched_set_fifo_low(t1)
>       sched_setscheduler_nocheck(t1)
> 
>         __sched_setscheduler(t1)
>           t1->sched_class = &rt_sched_class
> 
>           check_class_changed(t1)
>             switched_from_fair(t1)
>               t1->sched_delayed = 0 <--- gotcha
> 
>               ** from now on, t1 in the tree is TASK_INTERRUPTIBLE **
>               ** and sched_delayed = 0 **
> 
>           preempt_enable()
>             preempt_schedule()
>               t1 = pick_next_task() <--- because sched_delayed = 0, eligible
> 
>   t2 switches back to t1, now t1 is TASK_INTERRUPTIBLE.
> 
> The cause is, switched_from_fair() incorrectly clear the sched_delayed
> flag and confuse the pick_next_task() that it thinks a delayed task is a
> eligible task(without dequeue it).
>

Valentin pointed out that after the requeue, the t1 is in the new RT priolist.
So the value of sched_delayed does not matter much. The problem is
that rt priolist has a TASK_INTERRUPTIBLE task to be picked by next
schedule(). There is a fix from peter to dequeue this task in switched_from_fair(),
which can fix this problem. But I think the current proposal can save one extra
enqueue/dequeue operation, no?

thanks,
Chenyu 

> [Proposal]
> In the __sched_setscheduler() when trying to change the policy of that
> delayed task, do not re-enqueue the delayed task thus to avoid being
> picked again. The side effect that, the delayed task can not wait for
> its 0-vlag time to be dequeued, but its effect should be neglect.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408161619.9ed8b83e-lkp@intel.com
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/syscalls.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4fae3cf25a3a..10859536e509 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -818,7 +818,8 @@ int __sched_setscheduler(struct task_struct *p,
>  		if (oldprio < p->prio)
>  			queue_flags |= ENQUEUE_HEAD;
>  
> -		enqueue_task(rq, p, queue_flags);
> +		if (!p->se.sched_delayed)
> +			enqueue_task(rq, p, queue_flags);
>  	}
>  	if (running)
>  		set_next_task(rq, p);
> -- 
> 2.25.1
> 

