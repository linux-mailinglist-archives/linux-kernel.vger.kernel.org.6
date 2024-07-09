Return-Path: <linux-kernel+bounces-245062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD9192ADD2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE02826E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5762AF12;
	Tue,  9 Jul 2024 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqDH7xlb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B5631
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488697; cv=fail; b=KjkMdk8vXCmDoCIj1lKvJjwUmklc/0NB6MonThK+WGWj3faG0eORrPNE+vEGeO7VLvwTIpRZ47r7OAFZCkeTWtlt4CmHcKCFTRGfZmZHjPi35pqrSMW578CvXH0wXGgHYjfygqLRULEphtbKXwAL3VdZJchg1eV3XsLzcQcrO/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488697; c=relaxed/simple;
	bh=k9MedfppJDxZ++FtbRjY0gSbajCQue9keKyEDwMofDI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iLIVlm8sSWWa1RrtbGxA8Gz0OUYgF6+Smav9rFyfGmq0+VHI0/Cy+pG6nzmB2A06n0JfL23P2dKsZraGIzcUgBbN/LnYdVIjnNhR/u0vZ/lV91NA8e8v/7wSYNYfuwT4uRhiO6ehSR8QsUbv9DHHFXVKfoQtzsBdzrpBvYdPsAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqDH7xlb; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720488695; x=1752024695;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k9MedfppJDxZ++FtbRjY0gSbajCQue9keKyEDwMofDI=;
  b=DqDH7xlbFgWsjC5qEQpaHu+6CarQ0CU46dYrd4XPNose4sRmzaROrvVq
   apJrA9MmKNbSs0UPnZkYqryUlR2IdV5KuBpVNHXBfHRm2JiBDW2iwrPEX
   Q2aiX8aK+Gz2C9RxSwOnMbX+lxTPWdbq+vqQggAXGTZLaSikCADNqLEgn
   NgANgSrJPOs6V75V4d6+avrw68pZ18CfDxxRrcR947tNajgnHPG3D90JS
   KDGv/veufWnjzBUjOHUZrPov2rMnf8SrCPTSiXwbhA9lfOaTrgdQYQYu5
   LsarRFPLxYEt30kA5CLyzOCdHGo06LgBHMdKGiH5JyiWBxexyi83uwCW9
   A==;
X-CSE-ConnectionGUID: XWqy7ht1SLO74Gx1LwLG0g==
X-CSE-MsgGUID: tmIx3GkwSVO+QxOAo1cl1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="29109578"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="29109578"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:31:23 -0700
X-CSE-ConnectionGUID: sirVJyx+Sr2sJ7iBtSQGfg==
X-CSE-MsgGUID: sZRk/WCRTi+/k81a5yQrIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52623826"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 18:31:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 18:31:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 18:31:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 18:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EE4pljzYDETwHVvVcq1h4SrY7Go3hVquPZ2xpp2TkUpkFUfX8WO6SHWraL8PTL7S9MVAfMxcRjp8onkx7Z/L1Dqc5i2Z6yHSMU/tgy2bRChHTg82//zPfHu5EaO3/zgDv5GP9/oQ8gsjdTNfV93131FLyx7gew4juT6y8+XNKxmekDiDWXk1uOgckhmyLjxyQarEN6Jyl+7QPVlLBXLn439VitPjMeyr3qzLCJDEQgbXGNdICU40vLq/g40zttTDUvaPgtqzhdUd05EZ4GzG+rxhz7fhGOifW56kV76pGriKwwLKZPtvwMFsksJR1tWqhR/5IaIB99JepZDfZRE/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjgEWGJ/dpk7wMLGrUa92NjteKupOL/ToKcMF5u1uTc=;
 b=E5RiqopboJpnXf3eRJ0dF+Bo8qSX3nUS8jAKYJDBJuxGvnYCiiHDpQSdMxEu1PILYkeMC3vlZfoVBhyz+ZgZeti3dvav/fS34CyEFdLQRqcxAr/Plk9u7hZxU7o5WiIGGJsulkv0fiGpCDItQQOJR0x/ZwSNVukmaZjX5OuElUYjQVE180WTkWX8EFxPZR9oXCIMrymxK+bopuvy128q/bnzig0reT9zy+snwuR0nk2/4v93mR+evN7t/WqAw77E2Ua+4z5j7x2JFLnKJnSrg7lA7ggexsytFeWEWPNCBuPgnASkZ7Scr+qnWe8CMHg/s+/YQtujUD/bLbq30DPRcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 01:31:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 01:31:19 +0000
Date: Mon, 8 Jul 2024 18:31:15 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: D Scott Phillips <scott@os.amperecomputing.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, AKASHI Takahiro
	<takahiro.akashi@linaro.org>, Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Baoquan He <bhe@redhat.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, <patches@amperecomputing.com>
Subject: Re: [PATCH v2] resource: limit request_free_mem_region based on
 arch_get_mappable_range
Message-ID: <668c92e35c677_102cc29475@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240709002757.2431399-1-scott@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240709002757.2431399-1-scott@os.amperecomputing.com>
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 30353d6f-62f0-435a-fd8e-08dc9fb6d54c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nRVrZQg0HG802Ufui9Bdk2wATSEMXgn1xDyI8jNwu02E9aC16/I3Rpes4K2s?=
 =?us-ascii?Q?ETiDyhhR6T0N+iHGTFLTWiI9uTSl+Dx/+6Z08b3BJUULXkiMojiDT3QNKmRb?=
 =?us-ascii?Q?brGzDIMfXc5pJgPXlBmfhlk+RjWgaupLiPhJoWyVKRTNgtGciafOxVqO51M/?=
 =?us-ascii?Q?M1pIbjGSgkeAyJT/GYbmjND5Oe/4XkNXMioXKz/d+IGzp4bUWQbcAEEshCX6?=
 =?us-ascii?Q?2MdwmylV6aivp4mzfyG2QZyvt8o1KKV6gwKfIXd/EZ+TEEnrcuyEdKvZDS9o?=
 =?us-ascii?Q?iJt+pPeORE3tjs6I31583Um1lCS87ArYw8U++Q48Be7OlXlyRGg0iNDIvPYq?=
 =?us-ascii?Q?Na9hpT8R9QZXF2Hn3sCL5QuTwAhEDstpogZEccMWU54xa4M3DUK+sfhcm3E/?=
 =?us-ascii?Q?91LESHUUkuvjf9qMyRKpdVUi/lvQP+5w0FdhcGQphVM60fjsJsqkTozLtnWd?=
 =?us-ascii?Q?oLn8U2d+wkOlWxNwppt9aKj6OhdR3c2oynMVciRaq0T1FPnK6Cg7FZelrpoC?=
 =?us-ascii?Q?PMGUmDsaYEmsdV5k9aG3+EKdVlExmGWKOUxx3bH1ncz3B+rhnnO/aeH+7Qcs?=
 =?us-ascii?Q?GoMbgxUFRgozFzMZZ+hm3LPb4dTWhP/hEI44j95xLkSaEUlVBbVMtDl5+Ufw?=
 =?us-ascii?Q?qDL7316/S+jTulnQVKjZtvXh/neYyAJYveFuUAVoAkmp5KEu7usNDgFuOdZN?=
 =?us-ascii?Q?PcZMcT1kL4xgfgxBssiwPzjU9vi8oMBuX+k052kFgWLenmhrwFbK4su5HqLo?=
 =?us-ascii?Q?A4raBU9QV3ez7BcE+PT3254LDZFaFPwls3sKghDIsJ2cuqcrpoO1X/F0az0U?=
 =?us-ascii?Q?KA6CvvFcWbmARfI2DoeLCcGaNrs3ctyz6m//7GrEAd8WiYDS4pzo+NCLAtRG?=
 =?us-ascii?Q?zwdrt7KIMVz5Di1pyoNxwh+NsujlsNMBpouL7dFpOEaFj7wfA9cT3hEDRsjm?=
 =?us-ascii?Q?pPTGjaVh15D6IPHwwVlFC3d9SvYW1yqU8ALaI1ZOk1X07IPeONWL50z0IjpW?=
 =?us-ascii?Q?wXQMVKlvbdxydHmc2nD3Gm8jHCGo/uA6ETomk/rMxLH27t7bXhrZ9sxdnpx6?=
 =?us-ascii?Q?3+D5gIwpy/J32qDtH3i041hcJJRuY5plUM71vT8bpOSu/yWFahJywvb1A57J?=
 =?us-ascii?Q?tDnFVYVrsrVGM8zKZlATUco7qrVM2IDCLMjXT45Qpjtke+h5Ggw6WZY+zF/w?=
 =?us-ascii?Q?oztGb/OxsyQBA1ss+dMDf6IsI+bgHb+h1Mc19qxVl16SWjA7VPWzpSlLA0e+?=
 =?us-ascii?Q?TTSupjn3RGAB5vv3Rw3GSrh81IMVAeWDWzdoH4w0tkEA9IPp2Pn5W+F+226C?=
 =?us-ascii?Q?yUEeCLPGIIOuLrz0Eujq8wdxCWX/Wg0cTrpY1EuoEqWRr0t6fNtN4i7esgkh?=
 =?us-ascii?Q?AibDxsXjRaZn3RP/p2DUpJz6M9ZV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ml+63v9V9BE51rnEOTI9nFb/J5jJxrsT9fgjQ9jzamfOhRfSoyPbqCohIuef?=
 =?us-ascii?Q?+K2ZNfWPEVFCW70gnoMU2TgmJ3v34ldExl/qpknlYi/kV7Rxnfka1FqzL1hy?=
 =?us-ascii?Q?3ts4R7LS9snJ+UNZLYRfhZkzCJPq79IYOdUyTfE1JJgNNSJehfhWWNG4bRsi?=
 =?us-ascii?Q?jSce7Irz53+e3ewJcN5872LBkc0e+mxyHWn9v6Ypv5XRexIq1RBZXllRBnAP?=
 =?us-ascii?Q?PI56roXvEbY7B9YYonPU6QkTNVGksqTL/fadbUtCLtME8BMoAMAM4T9UwdUf?=
 =?us-ascii?Q?9AqqYQ7vDLTy3/T7VHkDmDOsG4A5gaIIIxfhTO6LB0zQZe/JE8aKw0BKJbHc?=
 =?us-ascii?Q?fOsa65/87aLcmdCFDhi7e/aaQLsR6yWgeMvATEMMKsbsFVX1JNnUZmReRFI/?=
 =?us-ascii?Q?bhLugHXT6POJM9e0bkB4M65SNKC1No1SaOHcLTByOpDQB7tqXOKk7TWySNmy?=
 =?us-ascii?Q?jRBGijy0LuOIbuvIy2yrcE5mEwQNyXlIgxezCcD4HOgy8BhYZ9/KUXTJyXVh?=
 =?us-ascii?Q?knP28skDh7na3vAi22uCDPc4DpMwDjeS98KihUt1NVW/5h103VkThrurBYOh?=
 =?us-ascii?Q?13Lr61/gyc6bF64U8LIBA9Z/a+1RQOvG/2StqIxu3ATqa+7c8NpLrQPudl2X?=
 =?us-ascii?Q?1w4ckkccWBVFtVepcMhSEd+gXz4xPvVKeAI1c9d8vBrCIkNacUDDZTeDSWQN?=
 =?us-ascii?Q?h6WrSx/ThJKSNiJSaZ0/gA3I4b6f6rSW5jA3fTbn3D0Mi4oRE8q2FoYr+S0i?=
 =?us-ascii?Q?mOVGRYhToaxMBsYB4BXpsC6+wz3eAOcyJlm0QrIAJtnjPFGk6LQMm44NOGhe?=
 =?us-ascii?Q?LwQUs8tbbuH+ocHTgf3unQXl3o0E7MN3SFCTbJOXEi0uAFZUWAviY8FuOSxP?=
 =?us-ascii?Q?RHIonbtBhFA44LNwnOatdJKBCECTYFeDgN7c3zU8W/Yym/7gewaN9zd05TjF?=
 =?us-ascii?Q?ovIEaHmJtuEb/RMeme++FCZIxdPbFIRqVzmsHz8o1Wyo12QIDUQgR1QaVj+G?=
 =?us-ascii?Q?IkybSWyqKuQNYy7yHJfR5cxASGtbDstzhoLcTtL23IJ8MhkHCXksTdDJhw79?=
 =?us-ascii?Q?KWoUT1QtBOWJWaIner7grYwMEyNS1KhcVtooi0aTeXAN/9YbJQ6M9CG80RAZ?=
 =?us-ascii?Q?8qgD8ZftYTUCOXR/wHBqoodFOnbTaLrCulxjkFRXRpAAl5zycc3qANfqJvx4?=
 =?us-ascii?Q?knhueXEkwEwYYv5edzANEjDAOr7hlOpkGg1m9R9TpADCTchNs9fIzLOQZDSA?=
 =?us-ascii?Q?XGYdMaPkAZ90ax7rZObYbECDIGz/UjxlE0mz8eULVZhWusIA5gE8jK0HrdQy?=
 =?us-ascii?Q?iclOdbMc0/+DIhdU3lfUhTtSpILemrfLCRdgen1t6bASb/jRqoEKxSUL3Pj6?=
 =?us-ascii?Q?tOdHN5Q5kX52pGX/jD0KXJlOpEphUZfsd4D5ReeIWsAhMeZGpgnKdquO2910?=
 =?us-ascii?Q?XuIJAwv49FxcTrKY2FESaRcr8CvzxRZymiJzq6ohin24Bi0S5u+KfvumPwHb?=
 =?us-ascii?Q?je576yq/7fRqSyLfGPrUHCgcW6KSYj9JQOKPB0AcM/YBAATJA6aym3PucjgH?=
 =?us-ascii?Q?JW+oX6VhVb8MXQG2J8wZsI1RyqxZd/8QNRPCv8VaZNvKbI275Ba3yCJ+VO+A?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30353d6f-62f0-435a-fd8e-08dc9fb6d54c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 01:31:19.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6e5GIiX2RR4Pd6FTjRAN3Ob93/XD/5u1WyJuNI28oAIsl/m/PUl6CWArvXeW+8Ja6Xq9wLPkwuBCdHRkik1slvPvQ++TqylbtJouVWVl94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8251
X-OriginatorOrg: intel.com

D Scott Phillips wrote:
> On arm64 prior to commit 32697ff38287 ("arm64: vmemmap: Avoid base2 order
> of struct page size to dimension region"), the amdgpu driver could trip
> over the warning of:
> 
> `WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));`
> 
> in vmemmap_populate()[1]. After that commit, it becomes a translation fault
> and panic[2].
> 
> The cause is that the amdgpu driver allocates some unused space from
> iomem_resource and claims it as MEMORY_DEVICE_PRIVATE and
> devm_memremap_pages() it. An address above those backed by the arm64
> vmemmap is picked.
> 
> Limit request_free_mem_region() so that only addresses within the
> arch_get_mappable_range() can be chosen as device private addresses.

It seems odd that devm_request_free_mem_region() needs to be careful
about this restriction. The caller passes in the resource tree that is
the bounds of valid address ranges. This change assumes that the caller
wants to be restricted to vmemmap capable address ranges beyond the
restrictions it already requested in the passed in @base argument. That
restriction may be true with respect to request_mem_region(), but not
necessarily other users of get_free_mem_region() like
alloc_free_mem_region().

So, 2 questions / change request options:

1/ Preferred: Is there a possibility for the AMD driver to trim the
resource it is passing to be bound by arch_get_mappable_range()? For CXL
this is achieved by inserting CXL aperture windows into the resource
tree.

In the future what happens in the MEMORY_DEVICE_PUBLIC case when the
memory address is picked by a hardware aperture on the device? It occurs
to me if that aperture is communicated to the device via some platform
mechanism (to honor arch_get_mappable_range() restrictions), then maybe
the same should be done here.

I have always cringed at the request_free_mem_region() implementation
playing fast and loose with the platform memory map. Maybe this episode
is a sign that these constraints need more formal handling in the
resource tree.

I.e. IORES_DESC_DEVICE_PRIVATE_MEMORY becomes a platform communicated
aperture rather than hoping that unused portions of iomem_resource can
be repurposed like this.


2/ If option 1/ proves too difficult, can you rework the consideration
of @base to be gated by @desc?

Something like:

if (desc == IORES_DESC_DEVICE_PRIVATE_MEMORY)
	base_start = max(base->start, arch_get_mappable_range().start);
	base_end = min(base->end, arch_get_mappable_range().end;
else
	base_start = base->start;
	base_end = base->end;

...to localize the consideration of arch_get_mappable_range() only to
the places it is absolutely required?

