Return-Path: <linux-kernel+bounces-354805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A225A994337
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8E4B2BA06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188C1E105E;
	Tue,  8 Oct 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJIA2apc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64B1E104B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376338; cv=fail; b=KbAeFTyeNlP80Ya++W+bFWkutV70jFhTSgwbJ7Gt1anKBM34wKYv62HpNaJjG4dijWf6rrvucNRRLFIt9GTazwy/AbEoKeOxsESxgqY/mQgx98IGsH5M2d43l+hDs1iVjb+Dn+jaBH8xu2SnZfbd2U3vBgMKAhYUJ/qJYeulJCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376338; c=relaxed/simple;
	bh=uZJAHyQcndsgmX0dKS9kbvqX6o2ZiGz/0VxbSEV7XTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O+A1F28iVNhNGxRC6amInSxEIqJQEmtKMlwzbfRBJXu0DZSMUPMG275MKInJ8AmhdCrDiqtgie6HxyMJbHPaVYRObYP+kgkM0/3G1rnuDQabvdZLzvA9y75e0LF45fQuAR6eAEeR81yFJW4H8MrM2mC4J1BNELh/eN7wU3+QZlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJIA2apc; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728376336; x=1759912336;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uZJAHyQcndsgmX0dKS9kbvqX6o2ZiGz/0VxbSEV7XTQ=;
  b=iJIA2apcY8zSdinhyWZdeBxih3sfiaJn5oSWlW43imY/juh6zm4eicKP
   XKW6tajXC2FpRqQ6hF2KFPGW82tBp7Xt1bArkSJYpSiVkIeYxD+R7Wml8
   TuiTQ1Pr5Sa0I6mpUA31NFcwtuJR0GMnZ5MmH9qo5y+1i+dJUpqKVmvBJ
   a3YycMXXhJ/8A0gndwOsSGrzIqGc8sWS0jkLtdON/tdwt7Ebl3eN27YxG
   pMUPwzq9vDACqmHFS3mJVb4lnX720ppPdi9078PL5fzbdBRcjlJM7FZbT
   Gl0RldYoP47ul5C5TnLyIgUMo92HqtZ1GcuHi/kT0g15E4jK7HoAcHZLw
   A==;
X-CSE-ConnectionGUID: XdeTuX57Q6WllhnNd1BxeQ==
X-CSE-MsgGUID: xluK5I1pQLOODQBnW6R2FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52960787"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="52960787"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 01:32:15 -0700
X-CSE-ConnectionGUID: Fa0w/2SDTe6HhClWunfUTA==
X-CSE-MsgGUID: E6uB2DaZTPm8SDFPeMQNRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="80592453"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 01:32:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 01:32:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 01:32:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 01:32:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNknfc5gnVNwdH8FmDOsU93WABterChViuZ1ygdCbP5iNW9jxeZb32nr2BlHRJmPzT6OCY/fLOA9pH4eEnMtlh1gdIgxZvtMQ18SS3wHRRSe4/vRGWCC/LmSsIXc8gl+uqVP0+iVqbS1dTjlzrE1c9BI4yCzPpwUM5+UuQ7AWuqJJ/BgYuHHf+OyJSimkDebCUZrOQ/GBpQrmVj0bx/Xz1b56fX90mSH6qcsnlfOdTClEGLRawhlHbXqHTOoLomfnPxgecUUZgsFYa/JxX/BFqxmhmaoB3vdTK8MsIJenZrFFLHN78xtIg9+7im5+t5bDrV3G6d+4f7QTkk05Kik3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqddPQE1Js8Eox/Gktmud8L6kVPco0pYeKNXXk3PvGc=;
 b=SSGBM23b2HIGbLYppHkUeyo6qrmEKFIuyJxqVOMP6EEGfrievFzYiLronX+CCPDPwqXyDSlhEXpBkIzYB1HU9pH7BausbvtkLxxuAT2Sm8GxmLbo5LkXL6sj2wxqxhlqdp3ZAxW3ZvyzBysFu7EZqMCel5qz9RCojxIYSpIZQMzkq+BbuUidrvA4Bx6g6WAgYXoO1YhqQFijHCI7R6GP1+/06shhc8mYRPvAm56R6dj1CyTGxCAxAI+eBY+r4IpsSHgrY5VUUFZENddrXVZFQ8ok3BzXPj4ywZgFWEYOCNzshCpOUboNeaJ0rGMqkY7Pv3b5aSpqACgbkvvTAY1zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by IA0PR11MB7837.namprd11.prod.outlook.com (2603:10b6:208:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 08:32:11 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:32:10 +0000
Date: Tue, 8 Oct 2024 16:31:59 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
	<vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>, Jeff Xu
	<jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook
	<kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Paul Moore
	<paul@paul-moore.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, "Suren
 Baghdasaryan" <surenb@google.com>, <linux-mm@kvack.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
X-ClientProxiedBy: KL1PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::20) To SJ2PR11MB8587.namprd11.prod.outlook.com
 (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|IA0PR11MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a59121-6028-4ae8-6725-08dce773b3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZJQgxEqwNsfSyoe7diuNjUnP3XA4hUQniSzzM+eGElhhWqmfPjaNDkyDmU?=
 =?iso-8859-1?Q?JlufJd2tzkM1856J3h9gtqQ53Cz8w90E513oizoE3+nSYl+QaRv5E0UHyW?=
 =?iso-8859-1?Q?mm4RDPzNQFJuBw8ZF0t5T/Ne9XrZbi2meO8GZys4+Xj2exHdFwFFJxDtRy?=
 =?iso-8859-1?Q?ebLLUq+bK0R4x2pPmarMAoVwiRU/OoPGOn4ZDTasCC3IE7hvhdLD1lULjZ?=
 =?iso-8859-1?Q?2knZWQ8j9FtZ5tFMFapav9rbceHF4AJSHjd6KHkYmpIQWlIFWXuCO2bQpG?=
 =?iso-8859-1?Q?+DVZ53jQZZGviomsRnwO6wCCTJ6KzJymyrktKouD/NmWuYxaLgpLsts8VR?=
 =?iso-8859-1?Q?+9hM+l84OeX1rS8g0UvkLHonvpFaN15QYasbYf4dhdrH5QfljAfNgd5XaZ?=
 =?iso-8859-1?Q?Y98n+SdumY9phNF2Ym4QEZoRJLRVUT4Bjg8DBz3o+mNtVPSiJl9CwFacA7?=
 =?iso-8859-1?Q?KZBG8+rLQUzZUu1tFee0UCl98J6d4+HjnUukFKZ172SP42Ll/8xHGbWH63?=
 =?iso-8859-1?Q?ilo/Am/+oUZKYr5n7/4LMqrHNtGaiaMUWRzJQXfumdRlBb71n54Fm4cC+t?=
 =?iso-8859-1?Q?fgpj9H8oRwH79rg+U6VN4+BYT+DcaagLVDzcUX6eiEN03daUfi6gors8/+?=
 =?iso-8859-1?Q?nF+ogaSkp71NDtJ9+7w8CIllgogQbDD1lFYmSFP52L33WtrYkUyCVsvB9W?=
 =?iso-8859-1?Q?Zl2DEyRi9Abpo93SYdkS159xFLt9+l2qzOFvCk16IFFa2FZcqGznFdX66H?=
 =?iso-8859-1?Q?WzLjbGxwmCTqTtJIZG36DTbANR0PBz/6JJrRk/wM+H+ViH8UhiDyhNzcil?=
 =?iso-8859-1?Q?QBznMGSjn4YEehaJiKCGJ6LXdFPJAgjaQm9VEQ1nli6e9IiPRza12Hvviy?=
 =?iso-8859-1?Q?ZzLtfJmCIph4tO8Gp4J9gkL6Kb2sRWjGN48O+QwhDt74LXItkVDTK/Xy7F?=
 =?iso-8859-1?Q?dZ5XxZD/iFsdjP42ary7CysBM/g1MvU5D1FUX/dFNAUbsF4SlF1AMgxIe6?=
 =?iso-8859-1?Q?GhgrhSRu4E5R9k/8qb2Tuu5YAYwFnKP4ThkkWwLnHW0JQsbmdF3VeHYH7E?=
 =?iso-8859-1?Q?R4nKFCdDimQtU0uH1lkDjFej9M3ZxRNlfTNtsw1xiH2IbCM11H08y2dEe7?=
 =?iso-8859-1?Q?iDatmcJTBgt4bzgoDHStutmAcgIfYHVjKghTa4lcxYK7ZOVKxL4SvDUypE?=
 =?iso-8859-1?Q?kqd6NtyxgiQfOIb0rJL+/bKvddbiyi4XRMUPEL8czja27Zvetrv/7L4oKO?=
 =?iso-8859-1?Q?nURE4j5UiK0P9ViaXt3keuYDqRDfeZJgD9oZ+juUXKVEO08uS85rpjfAt6?=
 =?iso-8859-1?Q?S1Ocn/Hd5iEqeMuX+yzMD506elDR+SR1hQCOye/Fp0+2tTA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Aazu+IW7s5CosxrG5V/1z5WC6Nu25bSKlHsHwnCJpVrhrRCIMN/qDx9zUg?=
 =?iso-8859-1?Q?AftlIG439SQs2t0Znk25s6A+tBsSt1BdUF5x+JXZIE2uBInGddLhQLK6G5?=
 =?iso-8859-1?Q?6dE2pCaYFWSSQxdebsOKJBgh/j6PivQB51MEifNUKiJ4b+VwKCneOnJAkx?=
 =?iso-8859-1?Q?j83cMeH9CrCvSQX6NibqWZIKsaMx5PuCBbaSH16xUQIBymU15SFn6tiWfn?=
 =?iso-8859-1?Q?mNxDmKMRiboVS9E94wW8CjomDTo+Wuq8w/Bx45zmTRgBrAm407IwPpdAiS?=
 =?iso-8859-1?Q?ugR8GAZUTT3cu9eWIkXMgAgv8X0F9Tu/OztccyvWAPUveHOYQNZax6u6OF?=
 =?iso-8859-1?Q?XMd1xQTAUGp/1dbbibuElxtuVi44CnUmSZCckAG59sn8zTtLKKt03exOXF?=
 =?iso-8859-1?Q?94hid1mYWDmPzxqSj8bqVBBCr/fEuI1/d8fRNG3rUBODwM6f9IqReDcM/K?=
 =?iso-8859-1?Q?uM61BBG9N1FkUdaTdfCGDrhw0uzNfh+OqFsCZegfJlQ41e7K/7qCZp76bs?=
 =?iso-8859-1?Q?0vdVeCq3kp0K+dNNhaF86AX4MzpbOXdXlSK3M+SapajTqI9wnuGTxnDxou?=
 =?iso-8859-1?Q?ESD8Vlw78kj0WbzKaBRkCaW7FP5OBNbnw9j87kPK/7+kE8nW02nm/Rf4Lh?=
 =?iso-8859-1?Q?5zoCqGgLVMpEErZZMa+uH96xUYxgNFI4C+WFATBpCEnKSZLTHDQtLlmacP?=
 =?iso-8859-1?Q?cdSkO+iA+sXeQPshGH97wj0G2O5UBJfBn/b1pRVbbDVuUPA1UwSxU07E9A?=
 =?iso-8859-1?Q?svXI/MOHhsykLp94zpDPkmjIihpCV/S2dr58ZPhCXRa5L3FCZlORYKIK4s?=
 =?iso-8859-1?Q?kjhIK8z1tXncOIgYifvtXfAvh9EHxvl9qXZzDzxVBL5qYMxxwTP1/q06LX?=
 =?iso-8859-1?Q?NPsqKAkGAJEPwbHc4Laf57zPQXuOyUrCWtYTXG4my2YS/7Jb962xHU0Dp7?=
 =?iso-8859-1?Q?/bkqkwLaQDM3YoE1gH7/Ug2ZiiKdGm6Z/hTFHGuImVTFWhwqWLoVDHgOI0?=
 =?iso-8859-1?Q?T+s2gMVLC+dCue6rTYcUJ7vLSdoHRdib+/WVY7vdghG3K0EBoBmwHC7n9g?=
 =?iso-8859-1?Q?LQdMBn9UhyORxPSGbDDk9fkRg/sw9gXnS35xEkMftI+sSVMTEHQNby3Zoq?=
 =?iso-8859-1?Q?dWmEFuO3TqNXUWqihbeqam0ug/zwVhq6d8BdBF7UKD9nBZ4CuqRkGck0IS?=
 =?iso-8859-1?Q?NwbYFd0KDee6+ToC5uIrIlE1OI3lmsPxwR2RWW6S+BOqBeBC9RJMW/nwfz?=
 =?iso-8859-1?Q?53MQMZ5LziEWcnnZiwl+Qf7pjUtX/c+a+ZxrVtIHdz08GkmJyLGcGnOotK?=
 =?iso-8859-1?Q?VBAPylf2ZAoz/iNcbTmNuDeIRIQkNP/5cVzRxsLTV2EV9HKnJwEHBvYfSo?=
 =?iso-8859-1?Q?0A9jo+tXv1dsW/oOtpYICBNR8oJUjT/zqKsj+8f6hGgEJT6jg6H627cipa?=
 =?iso-8859-1?Q?qior6XjB0ey+vobC4GFo7rBvIrRebguu6L9tdADhLtPeEhJHks9rwADkZl?=
 =?iso-8859-1?Q?JJWob8hv+Fi3sv76iOxzMslp4FFbk2lcPWTDL1zmexjLrr047E9o+6Y1pa?=
 =?iso-8859-1?Q?Yi1ZyUjKuN2Djdj1Y8MvNxTXZ6Pi+fU0k/hlTSdKzwr6rjxPd2mxP1OED/?=
 =?iso-8859-1?Q?Ly8Azb7Gv/W1UZ3o0t3yoBHN02ond46vcfzzIFpo35vQszjFL/ENTnEA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a59121-6028-4ae8-6725-08dce773b3e9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:32:10.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ey6PW6+PkRT8tq1Z9FSilAsoXXs1rRMaPLF3a4aehtUdgvOM+zG0FAFd6RXP2J6k7sQIL2dzg9C6bJBcCL+pcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7837
X-OriginatorOrg: intel.com

hi, Lorenzo Stoakes,

sorry for late, we are in holidays last week.

On Mon, Sep 30, 2024 at 09:21:52AM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 30, 2024 at 10:21:27AM GMT, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed a -5.0% regression of aim9.brk_test.ops_per_sec on:
> >
> >
> > commit: cacded5e42b9609b07b22d80c10f0076d439f7d1 ("mm: avoid using vma_merge() for new VMAs")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > testcase: aim9
> > test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
> 
> Hm, quite an old microarchitecture no?
> 
> Would it be possible to try this on a range of uarch's, especially more
> recent noes, with some repeated runs to rule out statistical noise? Much
> appreciated!

we run this test on below platforms, and observed similar regression.
one thing I want to mention is for performance tests, we run one commit at least
6 times. for this aim9 test, the data is quite stable, so there is no %stddev
value in our table. we won't show this value if it's <2%

(1)

model: Granite Rapids
nr_node: 1
nr_cpu: 240
memory: 192G

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-gnr-1ap1/brk_test/aim9/300s

fc21959f74bc1138 cacded5e42b9609b07b22d80c10
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   3220697            -6.0%    3028867        aim9.brk_test.ops_per_sec


(2)

model: Emerald Rapids
nr_node: 4
nr_cpu: 256
memory: 256G
brand: INTEL(R) XEON(R) PLATINUM 8592+

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-emr-2sp1/brk_test/aim9/300s

fc21959f74bc1138 cacded5e42b9609b07b22d80c10
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   3669298            -6.5%    3430070        aim9.brk_test.ops_per_sec


(3)

model: Sapphire Rapids
nr_node: 2
nr_cpu: 224
memory: 512G
brand: Intel(R) Xeon(R) Platinum 8480CTDX

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/brk_test/aim9/300s

fc21959f74bc1138 cacded5e42b9609b07b22d80c10
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   3540976            -6.4%    3314159        aim9.brk_test.ops_per_sec


(4)

model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/brk_test/aim9/300s

fc21959f74bc1138 cacded5e42b9609b07b22d80c10
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
   2667734            -5.6%    2518021        aim9.brk_test.ops_per_sec


> 
> > parameters:
> >
> > 	testtime: 300s
> > 	test: brk_test
> > 	cpufreq_governor: performance
> >
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202409301043.629bea78-oliver.sang@intel.com
> >
> >
> > Details are as below:
> > -------------------------------------------------------------------------------------------------->
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240930/202409301043.629bea78-oliver.sang@intel.com
> >
> > =========================================================================================
> > compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
> >   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s
> >
> > commit:
> >   fc21959f74 ("mm: abstract vma_expand() to use vma_merge_struct")
> >   cacded5e42 ("mm: avoid using vma_merge() for new VMAs")
> 
> Yup this results in a different code path for brk(), but local testing
> indicated no regression (a prior revision of the series had encountered
> one, so I carefully assessed this, found the bug, and noted no clear
> regression after this - but a lot of variance in the numbers).
> 
> >
> > fc21959f74bc1138 cacded5e42b9609b07b22d80c10
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> >              \          |                \
> >    1322908            -5.0%    1256536        aim9.brk_test.ops_per_sec
> 
> Unfortunate there's no stddev figure here, and 5% feels borderline on noise
> - as above it'd be great to get some multiple runs going to rule out
> noise. Thanks!

as above mentioned, the reason there is no %stddev here is it's <2%

just list raw data FYI.

for cacded5e42b9609b07b22d80c10

  "aim9.brk_test.ops_per_sec": [
    1268030.0,
    1277110.76,
    1226452.45,
    1275850.0,
    1249628.35,
    1242148.6
  ],


for fc21959f74bc1138

  "aim9.brk_test.ops_per_sec": [
    1351624.95,
    1316322.79,
    1330363.33,
    1289563.33,
    1314100.0,
    1335475.48
  ],


> 
> >     201.54            +2.9%     207.44        aim9.time.system_time
> >      97.58            -6.0%      91.75        aim9.time.user_time
> >       0.04 ± 82%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> >       0.10 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> >       0.04 ± 82%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> >       0.10 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
> >   8.33e+08            +3.9%  8.654e+08        perf-stat.i.branch-instructions
> >       1.15            -0.1        1.09        perf-stat.i.branch-miss-rate%
> >   12964626            -1.9%   12711922        perf-stat.i.branch-misses
> >       1.11            -7.4%       1.03        perf-stat.i.cpi
> >  3.943e+09            +6.0%   4.18e+09        perf-stat.i.instructions
> >       0.91            +7.9%       0.98        perf-stat.i.ipc
> >       0.29 ±  2%      -9.1%       0.27 ±  4%  perf-stat.overall.MPKI
> >       1.56            -0.1        1.47        perf-stat.overall.branch-miss-rate%
> >       1.08            -6.8%       1.01        perf-stat.overall.cpi
> >       0.92            +7.2%       0.99        perf-stat.overall.ipc
> >  8.303e+08            +3.9%  8.627e+08        perf-stat.ps.branch-instructions
> >   12931205            -2.0%   12678170        perf-stat.ps.branch-misses
> >   3.93e+09            +6.0%  4.167e+09        perf-stat.ps.instructions
> >  1.184e+12            +6.1%  1.256e+12        perf-stat.total.instructions
> >       7.16 ±  2%      -0.4        6.76 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.brk
> >       5.72 ±  2%      -0.4        5.35 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
> >       6.13 ±  2%      -0.3        5.84 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.83 ± 11%      -0.1        0.71 ±  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
> >      16.73 ±  2%      +0.6       17.34        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> >       0.00            +0.7        0.66 ±  6%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
> >      24.21            +0.7       24.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> >      23.33            +0.7       24.05 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
> >       0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> >       0.00            +0.9        0.87 ±  5%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
> >       0.00            +1.1        1.07 ±  9%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> >       0.00            +1.1        1.10 ±  6%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> >       0.00            +2.3        2.26 ±  5%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
> >       0.00            +7.6        7.56 ±  3%  perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
> >       0.00            +8.6        8.62 ±  4%  perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >       7.74 ±  2%      -0.4        7.30 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       5.81 ±  2%      -0.4        5.43 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
> >       6.18 ±  2%      -0.3        5.88 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
> >       3.93            -0.2        3.73 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
> >       0.22 ± 29%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.may_expand_vm
> >       0.96 ±  3%      -0.1        0.83 ±  4%  perf-profile.children.cycles-pp.vma_complete
> >       0.61 ± 14%      -0.1        0.52 ±  7%  perf-profile.children.cycles-pp.percpu_counter_add_batch
> >       0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.brk_test
> >       0.08 ± 11%      +0.0        0.12 ± 14%  perf-profile.children.cycles-pp.mas_prev_setup
> >       0.17 ± 12%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.mas_wr_store_entry
> >       0.00            +0.2        0.15 ± 11%  perf-profile.children.cycles-pp.mas_next_range
> >       0.19 ±  8%      +0.2        0.38 ± 10%  perf-profile.children.cycles-pp.mas_next_slot
> >       0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.children.cycles-pp.mas_prev_slot
> >      23.40            +0.7       24.12 ±  2%  perf-profile.children.cycles-pp.__do_sys_brk
> >       0.00            +7.6        7.59 ±  3%  perf-profile.children.cycles-pp.vma_expand
> >       0.00            +8.7        8.66 ±  4%  perf-profile.children.cycles-pp.vma_merge_new_range
> >       1.61 ± 10%      -0.9        0.69 ±  8%  perf-profile.self.cycles-pp.do_brk_flags
> >       7.64 ±  2%      -0.4        7.20 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
> >       0.22 ± 30%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.may_expand_vm
> >       0.57 ± 15%      -0.1        0.46 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
> >       0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.brk_test
> >       0.20 ±  5%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
> >       0.07 ± 18%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp.mas_prev_setup
> >       0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.mas_next_range
> >       0.36 ±  8%      +0.1        0.45 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap
> >       0.15 ± 13%      +0.1        0.25 ± 14%  perf-profile.self.cycles-pp.mas_wr_store_entry
> >       0.17 ± 11%      +0.2        0.37 ± 11%  perf-profile.self.cycles-pp.mas_next_slot
> >       0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.self.cycles-pp.mas_prev_slot
> >       0.00            +0.3        0.33 ±  5%  perf-profile.self.cycles-pp.vma_merge_new_range
> >       0.00            +0.8        0.81 ±  9%  perf-profile.self.cycles-pp.vma_expand
> >
> >
> >
> >
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are provided
> > for informational purposes only. Any difference in system hardware or software
> > design or configuration may affect actual performance.
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> 
> Overall, previously we special-cased brk() to avoid regression, but the
> special-casing is horribly duplicative and bug-prone so, while we can
> revert to doing that again, I'd really, really like to avoid it if we
> possibly can :)

