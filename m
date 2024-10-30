Return-Path: <linux-kernel+bounces-388949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA69B6683
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9324D1C20A73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26031F4714;
	Wed, 30 Oct 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipCq38Nx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF061E283B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299915; cv=fail; b=ZfcuLN5bLk7FUCP+1lznmLLdkFOHOETTdkX/c2kgay+DoerbZ+QNmLPjQsBAdrTVVvrvthYeDqWs+8Lvu98Nck5M+EPWkLR3Unow/geQBYky8NMrrOonwkhgtacxdZcA/gBu6IXrV/8t3EYqDf5MsbDkn6G7mX9I3YGNvxEtde4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299915; c=relaxed/simple;
	bh=6I02rN3qcfIPc4eiWfQ+Zu/ClhBnsk607RQmmDB/6AI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ljHngSUi9Cpbz4X3t5RD6MRfBPKUAXvKtwLwnDEoenhkNxgYdyMTVjTA4IoBIMgfgLbOSUWz52nXCIP4100PD1M1Lv9gFhfwLfD8h+ICUXZuOIdrdX/3pNFSDKAIR6bicOVzkraMQmmRAA8diiwvmmnN00Lgnni793n058DTzoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipCq38Nx; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730299913; x=1761835913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6I02rN3qcfIPc4eiWfQ+Zu/ClhBnsk607RQmmDB/6AI=;
  b=ipCq38NxGi14XnXhQWzS8ah1/8Dz7dW9VH2eW912Odj3cS93A090ZcmD
   Iv56VEWgajrum6+pe3r8q7AfRWX98RbMaojCzClpAIijKhLfEouvvIC0c
   Jntn8QwykCPNBW5b5Jc7jcPGo5dhDDg6+wY+/W7kLZsrlj1OhSIblulxi
   Q5/gFnI2fCpJq0fIIc0ZjGfPw6lnhoAMKLphu69cJbsV08Cn+7Wam2y7K
   mwq5X/5sTQeKD5VyHhFs5LyX9uXiZXLEQZw6vKU2UWHgr+vvSyeqbJ2i8
   tIv9+pq2SKfAgheIM03MsMBBvMNR/3fhZzDAsldq8kDze9TB5PxxYGvAp
   Q==;
X-CSE-ConnectionGUID: mvPyP/VwQUC/oLQTAWYkiA==
X-CSE-MsgGUID: sE85qfp6Q0abeh6fLtQPzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30154850"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30154850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:51:53 -0700
X-CSE-ConnectionGUID: I/C4hk5IQNuBH266stPXFQ==
X-CSE-MsgGUID: sL39FmnQQ5W26LKKxSvPCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="119787507"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 07:51:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 07:51:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 07:51:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 07:51:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsJEW4euYkrkXc7H7Yf7pmHCZg85c3fxllmIMb2ORAK0EQrNQBIo4g79ZMLEOIjvKGBgXPT/kZVxahq+2dLJwKuIo5nyhcdrUnX8Lny7+AXbVKKKSsYKacGUfHz17UaziuAe6HYHq/A84R0KyWlIkmS5tB4Mi5vXZoKV6OASmIr5pc1qSSRB7ZypVA6B38zt/JcmlDAH22ppsZIFJFsF/ew6TRzDXx2wAtGmzsWWv8hsX1OHpUB0+p26u+5wZtPLXNNzyHc2/uhbviwD9pZT6NwSyHhlXTh9v02way4z69oFoWSTQYjaoTBdrg0T+M4HWaFT/YqT2Ag3/fBBdBs79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2xWCE+xTVPccA3Ohi23vhHaPXmdojBRCA6WMwZyjxc=;
 b=CqZymV6Ge2Kc7Ie9ZREOjNMKGFfvv9B3+8fzIBw3tFD/HBTkZhi+c13sLCJ0kbKx6wijXF5LRdk6N6ZIj7P0/H3uS+lVzqxe0RkZI9NSdZO3HQL4s86PXgX/KOglsVMBVMqYklHkkEg8Aq2fZp1O1LaBXaLcQGHSStPP5O5BALdk3dKPGSBMPMM4QKjOV8Lu8SlTaFiaV6LCMTUjew5lXD3U7us2R14Vz+pXjGHulSDkUWzr55C8jlaYOKpj+nfw/VDehTxWc/1lQERQ1g3aVSu7sgenEIWXocBnxtazmW8wAjtBMOFLJXcHxWe/pWuR6CDuP0aJh2xevSnNZ5h0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 14:51:49 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:51:49 +0000
Date: Wed, 30 Oct 2024 09:51:44 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Dan
 Williams" <dan.j.williams@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shiraz.saleem@intel.com>, Kiran Patil <kiran.patil@intel.com>,
	Martin Habets <mhabets@solarflare.com>
CC: <linux-kernel@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>
Subject: Re: [PATCH] driver core: auxiliary bus: Spelling s/pecific/specific/
Message-ID: <672248003e5f8_3ab982946c@iweiny-mobl.notmuch>
References: <f232a09c377cbe11c81b4ab69d4e7bf016e746c8.1730282860.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f232a09c377cbe11c81b4ab69d4e7bf016e746c8.1730282860.git.geert+renesas@glider.be>
X-ClientProxiedBy: MW3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:303:2b::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA3PR11MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c877058-e157-4476-2598-08dcf8f2621b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HHP5fcdwL50eaLG/1TNjnnZ+ZW7AgIYjGsiHkDviozOIuii9dF3TFUMCIttL?=
 =?us-ascii?Q?JxVp6iL8kZz+37CWYGcZyeP/m8gQLjEXC9U5vW71sNNQmL2lmaXK9gsunHst?=
 =?us-ascii?Q?lXWLOrp91YotJ+AnF5WFmow9JiN8uwYyN/PuOwyR1L3ibENT8hYRthNlyezG?=
 =?us-ascii?Q?jiYPdzA58yiJX8pH6nI7Sl1yxxqruTkl0DkVoTmX/q58g6W9d/6mXbeYgu4g?=
 =?us-ascii?Q?D/BW7oMLjNDYEhStgUDfA56VrsTGmbcF60sDwaiUsQhz4lMgUXYgEMbBAGQQ?=
 =?us-ascii?Q?Zaagw0c92DqL6MLSi7YgQ0mV24COFIbNVQC2obNa0cOxNB9HTWJz+RWWA/jm?=
 =?us-ascii?Q?x36CoR8rJKV+DUZLRW7rES36quJfnNqokbSdUI/nyw8f7d/IxS/NbNSktEXX?=
 =?us-ascii?Q?tnYaQOj7iheZN7Y+hlIe65r2XJ0TADrkVR5NCiG5q6K4QfUCAwCiUejV2X2Q?=
 =?us-ascii?Q?Zu0X7KLs8Rw2mzCVk1CZc/jN0EmRCt+iSlmD+z08eiGAOoFgqItsMK0cWFhd?=
 =?us-ascii?Q?QMANDoabmjyxjT4U7vNCiFrOxUL4qfhJm6D8NRpix5C46kWJG+oIJI/eg/8w?=
 =?us-ascii?Q?d3aYiaqXNPTeW5DIqNr55AbvGH4K/hrjk7bM2aZb9ma/SA0PLPZN5EMG172I?=
 =?us-ascii?Q?sXDLRQ4Euqd/PoeyWit1IOqi0sdiR2+o02cymWvokpfOWnX2g3Ryv2y8jy78?=
 =?us-ascii?Q?M3dSazjOhQqyySdjgEa8Ov6lwEeAzVLb7QcGDoeKhRbCWOAFvqMm12w20BO4?=
 =?us-ascii?Q?SpFEgZuz4s/RVusy1eCR80KJM19u8hSoYq3uBSDISBhwBE+JkSTvHoCARaf4?=
 =?us-ascii?Q?cPZWdaKASsEr/1+a1x3FzobjfCJBwAVfyjXrIsG2k14GfCtsrJ0kRtzyXpmi?=
 =?us-ascii?Q?/cckb4QDVcJBtLNcnSYNcymDXpFjCIcQjQXmKGU3/FuxDIQMXFto9rDRpgix?=
 =?us-ascii?Q?L978SX97BMIpLbaV/FIQTLdN2UwyaBHPe3WY/KG1b0hp3aXFgsVGfX52KzuD?=
 =?us-ascii?Q?qrYOnvbXp2Av7Y6D7qdNwhW7q/PGC/3ZgO/NUDhmFbmNCPwGvjv21u2EDIhk?=
 =?us-ascii?Q?JrCwlcc9Ocx/mIXmznxuucB0xcpQRZvZEWbwVcrErk6XY9LmG88yopEu3TtI?=
 =?us-ascii?Q?P+jDNzxZsCDDPzLV53EA7SN0G4yax7wiYTgKfErFvZdIXNiDo3n4fhM1xZ9b?=
 =?us-ascii?Q?VcmcDgNeVnzGv2pVxHD5fLd7c94npBa63y3NkzJL6R6XrR3ulUxxRXA9XRcC?=
 =?us-ascii?Q?JO40aqdDiwcdzBGdB7nbAn98Jzu0WrmwJGBKFqr9gYHMao8MUtUBluHvRbUe?=
 =?us-ascii?Q?VgAvKQ9noiMV82On3ClkySIrAR6xFs2heFGptHq+2F41vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0lf0NOztNZ3EGGfyIeNFCJieBFVvG8bYBszbHwT6JroHdohOpgWO8aml0H9?=
 =?us-ascii?Q?Of2g2QHetxaMWkl5CMQoFxfd2dsynWI93ylmu6TXqCEefV7e62Kjwf9V9tnh?=
 =?us-ascii?Q?Bz5zuBfBCdGwsDTHIdrXFIQQaG7b251jTBFGyS1fSsP0zOSidOHv4LDSKrMl?=
 =?us-ascii?Q?IFt+BvlBruGBSJh3SAr5C77m8S1eG+RRRRUFiczai3WQDiD832aVfn8ZJ6Z5?=
 =?us-ascii?Q?Ad1W57bb/4aI+tB0MLcEKTQOJEnZPTpty3JmqzOYuP0f2sl+S4oNSpq9MRPs?=
 =?us-ascii?Q?9NcMjNdheC0V2uY7665vGQao+l2GxGUBdt7pHuI0UO79r4i9P0l1BvDCMqAC?=
 =?us-ascii?Q?pfdw6d8NRLkIoa8wXQR9sxIgRUcWNlDK1nyGlGPjJg1T2H/Nh/L2wBRcQAOD?=
 =?us-ascii?Q?I44UH2BinhGCuL9IQZe0CA2h0sYkgRzuOqeNRcycaiUThJ9MRnTgU/ivre8f?=
 =?us-ascii?Q?ClzIJ4JoR4KL9ketvol0PoRP+5t2+gHIHl5yLmqLun5aUsFlmhzma/GXgt4e?=
 =?us-ascii?Q?wQrSyL/JTfnTqkbUf1+YTCOYrVs9hAtJxC3/W288pfF/q5psLOFhjLJe0kNN?=
 =?us-ascii?Q?ucuWRb27+tJf8k3N2mKTkv22DKxBULaEcdIpUaYuJGjC1svggL6VejI80Avb?=
 =?us-ascii?Q?1yAMgQb6aapnIogh4YoTk/LJLLLP2wkxlWDLhCvsUER6ZaEZi9f5SGYF4N1T?=
 =?us-ascii?Q?7jU2kL2TOCaYq4OASmS955IZ+WbB7UoYclYLysCiTNouGd9pxvz9dHrrddl0?=
 =?us-ascii?Q?Nw5NcUxDxv1pkGKWe91ebyqmNLjpATq6/RD/1KHrkiPnMy0K/6f+Q1h2mtDD?=
 =?us-ascii?Q?hhjK97rY5qF0/YcFP/aFg+gv9/qRrqWZ5CYfGViV2NjHVO/oubr/yBKbyoSk?=
 =?us-ascii?Q?rGmhOPYTCES9Js7DwNo0bwZZFqi2qo5HMq5j25ggcCqQx3g+2uoIKBBAumaP?=
 =?us-ascii?Q?Uas7UO3PvvizaOpOIj56OAwBB6VRCpkeZMydV8akDld1ed7BYH24m/epfrAx?=
 =?us-ascii?Q?TJ4TViYa2/Z+QjmOp4p5liF7frqgitND8MRd0q9G7D5hpxVuUWGTATOcpWzG?=
 =?us-ascii?Q?Th/N9oY6vXUvvKHakBOEfNZdK8GN9Amr+Q/NHbwAnQSjCF/95WygLYqnym4s?=
 =?us-ascii?Q?QK7lNpQt9x4/3Qd4H/dDhfFWMSIgnYe0lmRZbcLK2AlSB9tXcklUTjgouD6D?=
 =?us-ascii?Q?QzoJyoCLTBKlN0eVwmqpOeZmGEIScTm+47bUcogiX2Y2wFgftIVWfRgKf+qw?=
 =?us-ascii?Q?FtQuK7LLibh3cfEc3HfhzZWZAaGe3fVlUIW6WQMoZeuoAzKknZG68aLwuCUY?=
 =?us-ascii?Q?0YN/DhRsBt2+bKEVp8ueT83xMC0NuLfpt+wLeKI3X/2Rcsj0hVdVQ4OAVgLG?=
 =?us-ascii?Q?CCY6hGA5Lkke1JMzG8AoBG9XtVenJlkUV+qJ9uN7Iko8Tl8pontokAYiNuZ2?=
 =?us-ascii?Q?VyzGZHdsBwrSqdgdcgZMQcFiJwfYfP5lCyMvTnSWsvncXg5zcGmqzMqtuZe+?=
 =?us-ascii?Q?HW+/0mrw7WXsv84/A/BS1lYM+6MR9+kMqVYKp2s3RvkEqwi2v3/8eQf3fIyI?=
 =?us-ascii?Q?9XzsquamUv3xmuahj8PNKmo5yWwZef6fawXF/GR7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c877058-e157-4476-2598-08dcf8f2621b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:51:49.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwdXH1/8YAFVaehOCXbxa1tbqsTJAryFpvqZ56kMKrUfuJZDbIBtJc4bHC+mfevLNuB9QA6DYXLETMsxeGO0cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
X-OriginatorOrg: intel.com

Geert Uytterhoeven wrote:
> Fix a misspelling of the word "specific".
> 
> Fixes: 7de3697e9cbd4bd3 ("Add auxiliary bus support")
> Fixes: e1b5186810cc7d4e ("Documentation/auxiliary_bus: Move the text into the code")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

