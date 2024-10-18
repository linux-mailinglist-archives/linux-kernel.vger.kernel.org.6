Return-Path: <linux-kernel+bounces-370759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55219A31B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A531C22225
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31B383A5;
	Fri, 18 Oct 2024 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0PL3BcG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994AA2A1CF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729211687; cv=fail; b=Pa+20vTvhumdXihFwPA7++XuG3yqdKTV5gynmgYgtn7mG72DVyXeTcL2Hp/o6k1AyobLNWcd2xvEI2FMcg+zt+uiNRLaHQ+YIezlTf78E1CGKAx6lv2Cr9yTr36OTYPM8KQf4Nr7nyX0jLbfUuu4Cn6T4zMGLiphzuiwaUIFRlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729211687; c=relaxed/simple;
	bh=vMZgyha66GJbOI4pjQVix75M+mlt/3YsryLb8QZOEsk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KiloufoLLJTdhL7D9zErpA6t398aAjlGXyMTtToQyh4LCjoz8X/hO2z7gLXrtyaYmZrVt1ByV0Zm7aiwfw2prvdUD354QlGWpwqwyey34mecr/k761Y9zE4hdREUKuHe2dLkaXE55PcxbaQJYjJ14vSQAKAtNu00K2xzozB9q6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0PL3BcG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729211685; x=1760747685;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vMZgyha66GJbOI4pjQVix75M+mlt/3YsryLb8QZOEsk=;
  b=F0PL3BcGirBxwe6ypdOKnktDTt/4TMyhnaiP3GPrGjmRmihaB3r3az1d
   13Rpb2byTmM3+0O880YO7G+i2np3r2/qdWSRGfagjIP3pmxvmqimMK4I3
   Mo6R3jPan83VPch2EcE01PEY58vG7ivgTY+Hlq8jPFWNOKjFeczr9/soh
   6OIaMnTaQzqXMAx3pLfQ4DZTTYrjGzPBnaHmC+4BzjqTU80neTsDAkvzA
   A/a3K7ZKzSO6AMoFuQvNKfDZXGKi6yteY+VebEKvucp491h1BJ1zsD2Ap
   oN1ejPYFEsRd52wv9hVOJIj9Awq8gfdPqiVwUEZRB3aAdKA9tds7R92gv
   w==;
X-CSE-ConnectionGUID: sdP9/PEYSPe72GVk4/b0ug==
X-CSE-MsgGUID: 18yFCPYOQpadLzOFF7zI6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28690484"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28690484"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 17:34:45 -0700
X-CSE-ConnectionGUID: Vcbe2pZ6SkOs8Q3r8EaBrQ==
X-CSE-MsgGUID: xTL3EQuTRESWN7+NnbZumg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83489230"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 17:34:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 17:34:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 17:34:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 17:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3wpnMugou/kpgQ892pCC9XrRuq4sHstT8KxNpLxJkxc01DsK57OI+MJoEOrajmBdabMDF+c1Hz5zCLeOmVw2K9ouvwiFaLMec9ayeK+VZkmR+oonkr4sQKSaqpz0u3RfDDCRjc0tlVKnEF5XUCGVLW9YtE40RJgK0S9pnOIG6QGGwtUzncupxcARNlHyq2EqTLm+E8dD0R59V5jCfQgqAvhxwBqVoNTE9V19prr1QMaQFNN3t4oSvpAqKsVZZeM9+LLibUEysect3wcw7UwqseQofMqXNegJjAQzBzRAbKNKPljgYkwV844ao/dclSQHuBEamZiRhfphQYL316JTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJkrnzloDKxr4GSfBbs6JaSGcAyvTM5Ui0YdrT4oAjk=;
 b=Awsbn8YE1bN6z+W8zqdcB37GYvsbOlZmYL/dfQTigyuiJK0rk7RdbLPr0aMxRgtAGXDxgyj/6JKxOpz5habYTD1mTaGG1MaCXD4k+LORPivmQDujgjd6g1BmJgaecqeMzaB7WiU7yL/o1H/v/npuI0JQM2AfWkIrAGRm5XJiQFqkapNFvAX5vTcY6aSxfboPkNoC8k4MvrNZUwPZ85OiQZw60HSMG7Ill/fSohZz14txD94QxP6cpGjabip5azJnFaMZ9EJURLghk3Nzjmn+ayNOaiTgNmWi5MFSN7lCH+J9IPJYrnwy6Ry6aT+6H4j/c3w/We46ZwcqMTu4vWZiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 00:34:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8069.018; Fri, 18 Oct 2024
 00:34:42 +0000
Date: Fri, 18 Oct 2024 08:34:28 +0800
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
Message-ID: <ZxGtFCzk5kwycFV3@xsang-OptiPlex-9020>
References: <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
 <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
 <5b7227fa-d0f1-452e-b1b3-9d7b87641522@lucifer.local>
 <ZwiRdemGMY6Z6pSN@xsang-OptiPlex-9020>
 <fa645dd9-3835-4e1d-aa04-1892d97a6c86@lucifer.local>
 <af510726-4245-46c1-81bb-e32379c2c127@lucifer.local>
 <ZxB9XpvYoDrYgnah@xsang-OptiPlex-9020>
 <ac1e101c-f3ed-4e9a-9ef4-37788fce4680@lucifer.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac1e101c-f3ed-4e9a-9ef4-37788fce4680@lucifer.local>
X-ClientProxiedBy: KL1P15301CA0059.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ead933f-7da2-4ade-8dd5-08dcef0ca842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zu1N2bsGkrMj5LZrctlboImhrLIJQRhExHAEbPBUHDks39nZSeczQrXBcCYC?=
 =?us-ascii?Q?7fWvPEiIJYLLGcLt+s7dYGBdzxV7tEcxJCwQEjteL9Nsoh0fcliefX/tqk60?=
 =?us-ascii?Q?ALSu6Y6JfsM0x1gfT+aPk72XP/gIFwzmN/LJXyhfZ0YiMBc1pPSxu3sVK+e1?=
 =?us-ascii?Q?/NVXcIYF40TsbqQ4/JUeWpsE+qoyKUVG0yLoP/LkXMl5SujDvMrxWY9x28t0?=
 =?us-ascii?Q?Hk8h5HX4rtYPlcZ+JeRhZxHvPDdtY4t5stRleElwFCf4BNla0lqd99MBNZoM?=
 =?us-ascii?Q?IYXphu394PDe1zVwWCK0DU1pHKWWoBfkuEnjYULbsrsyX6nfMGZDZptKgL9t?=
 =?us-ascii?Q?pzaZr1cYAokHTGHLtLSxk4ET3LwtJuHVVzaE3M17BL/QpcABZXSy2iA0MYzH?=
 =?us-ascii?Q?NfpN6DujbjojgwVsCJwxX6TY2KU6wPutAhm35iAOqE21pm3JaJj/II6+T+g6?=
 =?us-ascii?Q?RD5hjIlojikF9hhjt8WciGxSE2hv+2ZpPhKoerhH+cpgX3KguBwQI94Rnfe/?=
 =?us-ascii?Q?PXNWQ9R+8qc60OoFsxVPUGBX15c3pSC4DEQ/GTUoapHxoJTvUEq884urFxjc?=
 =?us-ascii?Q?J88k4YM+U73AWEgjEx5oOSkNsQfkLcMwlRmGOMu08/VTZHxxBTC2/ACfzZkE?=
 =?us-ascii?Q?cWXaejW3Hj/BJWtlCS8EnAWDLm+yTR8ASgyCqVmoA5VeGGn0hZ3O0WSAaTOL?=
 =?us-ascii?Q?w6/uxd4YC3EEGtgzVNF5hOtR13RGM53FSeiyyqOLyV1I+lS3yJk+OuEZMTLe?=
 =?us-ascii?Q?6nIUgHrnizHCH32ZDIKbxfHf0T/CrnphrlUEJPSJ6yAm0E0dnCbhbLrszjLm?=
 =?us-ascii?Q?+ZOi0+B6r3I1HsIJpHZZ6+ynWT+E80i3joRbsUfkqHzojaejI1t3qjXgSX7+?=
 =?us-ascii?Q?ksCLmXLEDlBpUaxa+0Wh1da3XcRoUvb0SkyiQ6plb5h7wCnkVMTkrjJiDSnj?=
 =?us-ascii?Q?t0mD+d49Nuuv1IjNUwPgWPRgllq91lq/ir6587m7oYjbe31vD6ZdbbdF6vm5?=
 =?us-ascii?Q?oYebo18yTpqwrjaAsuO+yTFP05KPwn87w5ugmncLwJgRBDW5ENLkOWe21BUa?=
 =?us-ascii?Q?6YwuM8XpnL33sAy/mJn54iEsxmbaRElfqsXpOwqd8AtsBpM7aQ6wKyhvFXs2?=
 =?us-ascii?Q?4zdtmOwmn3fCNhx70gw5Nbtwq0q1B5MT/EOihxHMO2Rpn4Mf7K8iOLm+UiWg?=
 =?us-ascii?Q?kH2JaDbDyldTs1DSShpye5G7ngJwv+d4lwpqyulhrOnAMRjVaC106YhAKjld?=
 =?us-ascii?Q?OtbCTFdeZtiX014Si3junCYOOGsl+ShZA0h8muC5ggMh3RuZm5phjV6ltF7R?=
 =?us-ascii?Q?vYgn+j5Kdx+lgTvNZDhBc2IT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ck09GUJYD8ZUVCVMn5/swn2HnY8Ao3mVVynMxs6a6aBngbcn1kXcTHGs1sJa?=
 =?us-ascii?Q?6MjDzMv4dahJxW83yJM0dRpPZSZEKtRgxV1A8H/ZL3vFSyBogxH2Bc3mKR/B?=
 =?us-ascii?Q?WNZ+XWlpTxmCkJc1g021ncpSm+30206USgH+WIoDGw03X2BZipegTps+48qU?=
 =?us-ascii?Q?T5KGkXOQQllQfaQlmBJNsWaFDtuaCo0r09wrCT+OZJ3wR3t0EVtuuO9boAoV?=
 =?us-ascii?Q?gnpnKPE1XXvESOC5a/8n9dMips3c03GO+a+yXd0KRVJVI9UjuqR1ltPros9s?=
 =?us-ascii?Q?vimu4+eA2++O9LS5FAAr+RtSh/vWDxxMmpd/wcdb2FUQ2TiWUk+67mhZntgI?=
 =?us-ascii?Q?sfc4wTgLYuom0AY/wJ0wm2N1vvU9HAl6SVd2TVg1qSA16UogvMiS7cZKXj2G?=
 =?us-ascii?Q?/QPhDtUSUYJK8D1a5ES2GY2rGt+XGyh6kQAMrg0zMgzPeOHQJHGyxggEVOaL?=
 =?us-ascii?Q?BJGvbhHN7C7wFD+JQSkH+WLtX4FZljphKXzHeKnnwa+Yvw0kV2fPFfYHCkOF?=
 =?us-ascii?Q?C+VzWVKjZF18vg1qz8AYDJnPJJ//fSWdA6+GjpkchZzG0xweDgo5c74GWEVS?=
 =?us-ascii?Q?11owgT4D64Zc+R5rs4WrLboa1sRknKSV5ZtJjel8/juFSCRPSLDzt7fYCea4?=
 =?us-ascii?Q?0vSi/ovzXOqlN8zZfe2FxlP2sgxAAO0OoRdIP3zXLKenPJSGiAmPrvkQvhsq?=
 =?us-ascii?Q?mN1f42GtIlRY2Ap+dDu7wBB5qevMJOSqAmEPtgapbRA/yhgMHcy3malRlc4L?=
 =?us-ascii?Q?JIeJjjicB+bNraORXddJU8XX1PmPvZB2C2ZzKlOtk6PX+/kkFSu2R//EUJE/?=
 =?us-ascii?Q?F9uaqCXCIUWbycyiWuYYSOBIXySO4M3HEUUKtRdJRrMKoOPcXadRqoiBSQmP?=
 =?us-ascii?Q?B4Uc6lr9HdIIXxgZOw2At8qsI+ngHI1sk5ucPo9oJlwfZkTBj3spQWV8zIRQ?=
 =?us-ascii?Q?nvqFo17lg5pnipGtKNT4PmBsf5y4pmXJqd+/5LPOJCr9D0ow6HkuV/rfxo3Z?=
 =?us-ascii?Q?zduOhIDvA7vU1fW6r5baSjdguAJ8pDu8Abrc6ypbIUdtxzvB6qSb9jX2kp6X?=
 =?us-ascii?Q?4XFcijTA9+mFEIaS0PpZG5MJ6OzxLjEHQG0x7mnf8FLYSwAR9a830rvf6H+M?=
 =?us-ascii?Q?LrR2tECLYmXMNB5h1DqRHkuRgufapKY/TbguweKmvKVZ68GMCtsfgZ1wKMGA?=
 =?us-ascii?Q?+UHy0M5T79Moyg+97Uoy5Uy7bsQdXi2Hpjv78fqTVoJggpjaUv556dWYXWaV?=
 =?us-ascii?Q?dS3GoXJNFsgTzNC60O4FlAvViAVxTRoSo8F3D0oJIj/nTuHAGsxbnkBWGQjS?=
 =?us-ascii?Q?NPQZa3NnuHDu8euUZYKIP6Aod7mc0Ay1AbF7ysGAD9wAB2Cgza25iFpe4CUR?=
 =?us-ascii?Q?G1BqwbETfFSI0QsolQp+xF3+XJ1Z3N1TGEuIjJN8CYWajXU2K1qjapCt3NR+?=
 =?us-ascii?Q?ehS+tYJnr+/CauOquhoNqbWWrSTjIpCNEh0KwW2I7ortpHDYCPdTRqBQerdi?=
 =?us-ascii?Q?CcWGdpxxwMrSK+m9PUkBD/l+FWAEEK62k/l+67+lunSrqKmuWrZCWuUTb+go?=
 =?us-ascii?Q?wbZCwwJ448xONmmsCxU3MChH/fpTDJbpEj3vb0mR9H3CefgX1wHDXzuf7vJp?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ead933f-7da2-4ade-8dd5-08dcef0ca842
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 00:34:42.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HUCiegI6WXhh9X34qvlwMQp6qZz/hmqOdNc748YQYY4gpTsJZyZaeby0/Tq/npP63jKemM5m9oAjYje9NoTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
X-OriginatorOrg: intel.com

hi, Lorenzo,

On Thu, Oct 17, 2024 at 09:54:13AM +0100, Lorenzo Stoakes wrote:
> On Thu, Oct 17, 2024 at 10:58:38AM +0800, Oliver Sang wrote:

[...]

> 
> Thanks for this. As far as I'm concerned this puts us into noise territory,
> so we'll go with this as the solution!
> 
> A side-note, the brk2 test from the will-it-scale suite, written explicitly
> to be more real-world representative, sees an actual performance
> _improvement_ here (though small).
> 
> So overall I'm comfortable with this, we can revisit if anybody raises any
> objection! The benefit in de-duplicating code is very significant.

thanks a lot for all these informations!

> 
> Thanks for all your help, hugely appreciated!

you are welcome :) just our great pleasure!

> 
> Cheers, Lorenzo
> 
> [snip]

