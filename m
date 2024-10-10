Return-Path: <linux-kernel+bounces-359835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D6D99917B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165F5B29959
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22321E5730;
	Thu, 10 Oct 2024 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enjWJnSk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90FB1CF29C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584924; cv=fail; b=IK4raUAOQBOO5eG6JfTQDlxg6nC3WuF1mQHPFhQqY/E/4Zc+hipSMupTR3PSU1CklwWO3UVmcHERaJf4hl97mWRUQsieV2/aXAUMZNeNnb4xHFnPcZo8FZz+LjMzJivbskhs9dMSlYZIcf6y0kMDCGxQQESOy7otMWZ8LSDvlnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584924; c=relaxed/simple;
	bh=BKkjJRnrDjE5wI82iaCrKGMOboCx8fvc+NfHE4xCdjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dt8gtQ1KXtT9LKCwYyGnO8RViyZxXlKr4RiDBlCgPJ0SC8HR/47L1tIJl7N4eO028uVqj4WTEkP++YoPG9PkA0JLbCG2luNDVSdh17+bre5DKt+JcOsbTDHqN+1omuxKyGAYver2cPt696IG7Bj0ex09QXnlMQhQJsZyuFiRR3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enjWJnSk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728584923; x=1760120923;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BKkjJRnrDjE5wI82iaCrKGMOboCx8fvc+NfHE4xCdjc=;
  b=enjWJnSkEvG+kzAMdUxEg6FMgehnY86WIK7ATkYaEotuY/of+Sh8ff0J
   sAhP7tuZ8uDNc5rMdObUfuVGtR0OudHQGjJ1q2SeSizeiBUPLqKQb6pjY
   2Nkn188/KCygQUI1PjyYJtBL0yc4OeEP1AsfDY8OoZZzjcWJWcwERjtne
   WVmBqnRhN8y+S4OfMD6PUXH8OE1VJaFZo9oY+LmHRP+mizgQ0YGOugP8B
   h+4U9JvNWBdwU3sElPPWIvnBbQU/mrHCjm/oVutW186JfAkeefRYGzV1V
   X9WOIpYtTLRb9fFfd4sE9UDHDuaogcuRMlZBeTFRQK/unxWaZeZ1RxxDi
   g==;
X-CSE-ConnectionGUID: /qO0rTECRUuqOhj6F515zQ==
X-CSE-MsgGUID: wv4a6Iz7SFODIkaSqBItxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39335702"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="39335702"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 11:28:42 -0700
X-CSE-ConnectionGUID: qN7amqfSQaKPjKBQdIJg1g==
X-CSE-MsgGUID: 0us3RiIZQxeU3CJUzwmVKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76601968"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 11:28:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 11:28:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 11:28:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 11:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbMWwXKN7XH8I8CemUTBQv9KOyuTwrX4I+09b3GrDYqgIt5FqeIj/7Nm4At5xkKW9URMQjDOcjYQEON2Oq8l1fT/SpuOzxv8YMakcQqgQp0Y8uv136IYrhIC7bQTU86vj1fHiNgP8mWDpPdFV3ulOsJxArbGwa4kO+bPMovHTXHYB8XjAEqlOt+QgBpH6B3NCvq25J+DnzUZeK7vAP05t7HeiYmHvQioEX9j1u7f4Bc5jPxIBh9s+Cs8TpRLcDdrYTIP+QH/C3Z07cFo10bzCwmG4vNz6ZqoAl4MZZ3Vcw8uf9NpGJe12d5tp5xcBXz3HMBKlpVOaj7d0GjqohJxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns9xgw4f9v8E0Kdc2OToc0wNUv/NZdiixVhH/JnHHSU=;
 b=NdaE6k1dNl0dCWxR86Jw7vhggnmFEqCRqp1+VyPlGvCoEmV1k5gpFbLYhIkbCwHcg6fPPR+n5JEqZUd6pAg/sHJaRKqY4bEkTHRd3ohOdeWSS7CfQYVXvorAq5pJ49UQacVPjpu3g19okeIghx6CakWqbJIScRzh+xL+6yN5YYKN+0/5CSzJgcEX/r/cek5L56mD8E6k62BjvFmkK1AvkpZJ5p9i3ZBg0v05dYaSnr0ApPtTj7OaQnVNWZ1ZpHTIPM80PHT5wAsfpCL1Y9KwulTHfuVnM+FeDM5jS1leqnH7+Gk0ezoCotdYXIT8YPZHFz9ZGyVkynKkFOWwyQud1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7565.namprd11.prod.outlook.com (2603:10b6:806:344::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 18:28:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:28:32 +0000
Date: Thu, 10 Oct 2024 11:28:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: James Morse <james.morse@arm.com>, Yang Shi <shy828301@gmail.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand
	<david@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, <x86@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>,
	<linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] tdx, memory hotplug: Check whole hot-adding memory range
 for TDX
Message-ID: <67081ccd93dfe_964f22949d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240930055112.344206-1-ying.huang@intel.com>
 <cf4a3ae4-deae-4224-88e3-308a55492085@redhat.com>
 <8734lgpuoi.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkp_SyRBR+JsxMwM_qKpF=8+TU=36hDY6TuKMHdnLnyxAg@mail.gmail.com>
 <66ff297119b92_964f2294c6@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHbLzkoR1pT1NEL7qAYi+JXOsB7O0FnHyHFOJ+4eZf9vf5K6Wg@mail.gmail.com>
 <66ff5dd3b9128_964fe294ca@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHbLzkqBCfWOXEtafPnuQSj3B3OHGEPAxPs8ycDuX-a5aVgVjg@mail.gmail.com>
 <d84975b6-1c47-4290-92a3-a1dae180355a@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d84975b6-1c47-4290-92a3-a1dae180355a@arm.com>
X-ClientProxiedBy: MW4P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bac24ac-5f30-44cc-b09b-08dce9595852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uBLi2tOQqjeWZPDw0ThJDLxAFzW8jQJaAudiGcNg+seF59EuIOuUq0yGuItx?=
 =?us-ascii?Q?X6dLPiSEE8KBRrWs0mC42dpNmLmk93//yHU5vXMfD2IuYV+C5iwtPwLOKmTC?=
 =?us-ascii?Q?H3+QQA6ainXzJZntU4z2G3QBJv0PogGKLRMiOsXy0v/LCycY7jnPzfqV2nub?=
 =?us-ascii?Q?pN/XyyH9Ff745OTXON5TKIyA/emodoFScsRH6ja1ZllfXHvbxaYxrNjQqQLO?=
 =?us-ascii?Q?m78xU5KIGio2Vpy1N9iFqrYSfVV1dPxWrxe6QbKQr0rPnsa6OVHTZH3jsxjp?=
 =?us-ascii?Q?bn1NSj4z35V4P3UPPLkPy2hU5WeKNNPpHG1tY1vnszy17HLgJDFBS5aKZkKD?=
 =?us-ascii?Q?SN57G77c9TFI0jfvex/wlNkesNMcz39wAmkImO7x3q46QJTrgKB/Bz+YWs+5?=
 =?us-ascii?Q?1yjCSDsisdCI/gk6dKpO4wl57IvRw9j1bQSpEpBr62mUvnN6Bpvx1b50nonR?=
 =?us-ascii?Q?HO1fDgNWZdXqwUFIij/i2LRl30K9xvqDn4lPmg4+T0p+yxP5dCHca20cRGpa?=
 =?us-ascii?Q?K2mV1m+I5U1h6TOn7C7NEctZmvT0eqdQzwAEao1Vf49uiGs3J5WJw0GRPM7Z?=
 =?us-ascii?Q?n9W1AIPcxfhwSCfafo/PB+Y7FXqDhrRwtwCrAcfbwlUiFD3OWZ0RLOT5j/9L?=
 =?us-ascii?Q?r9Xu7KWK0+jn81qDJ6JU2ktOzgxpgCU/lNnBAqVcdqwoV9exy9GNGr1zKDIe?=
 =?us-ascii?Q?nA497rK+7DR1Qaay96fbhRkax8H2ppvY9VQzTAVQvHlrKQRsuvbwemiBnwyH?=
 =?us-ascii?Q?ICHacK7WofQIHsIVBCLJvzf6HuTFMwDIxMP4BEOg9ksyqN8KL0VQjpUNK3S5?=
 =?us-ascii?Q?bChNIr/32GLJPOKujqx8kwWHfLzkYjzJK791wfOXMA4lHHil23mtf2v9wmwd?=
 =?us-ascii?Q?aJkcB9B6wB8jMfCeHv5u1F/Otk1DelWAhdXcar1jDH5Th+JP/kozgcfwtXLD?=
 =?us-ascii?Q?i9RIafF/y4dzxCZ0g1OetS6nSfe0fa2aEqJe3as6ildVXIuh61ictma8Z/HS?=
 =?us-ascii?Q?yfz23gQlXt2SJpZ+sQmS8ylyQ2l/L9ki/37NHaRBQol5YRGG8yapprJoVQiW?=
 =?us-ascii?Q?OIQguQS/wj8uCgbh6TL2Nd4tO1KAFg9bV3uDOLWIOtzELi2mGUoNCW0YRrep?=
 =?us-ascii?Q?c8ju2yEBo1T8lAahh7sG8RyNnWj2bEORitt1ZCFV5faLtCi5LcY+7uAnZ5YY?=
 =?us-ascii?Q?yM9jXkPLUAQ+hoxrfgFCBINgVOdq5zrJ8qYsTmrY6E5ans3QHSC+mDpvGKA7?=
 =?us-ascii?Q?0EmKdG0cPEdepaAb3bYwhSKpbytAdnyXX/prPdo92g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2zCeiIvOKwBd6rX6RoODY6PFLWU2OV1RHRKw+NS3Sb4XAXb439o/qXDijmz?=
 =?us-ascii?Q?BItOlB0hX6AIqwNYlXXLJVK/9aKW3MC4kuFIa7lcSrFtjw2LqtwWSd6tCb01?=
 =?us-ascii?Q?7UgmD2U0nmQ8Mola6P2BHOqL/E6+xKBMHKn4dsXmNWejDIUoxniwnWxhsHtb?=
 =?us-ascii?Q?Y1aTHmdOuAsyT463OcJr54DPeeYvV4j1EYiDaYTNocuYDtjrusSVoRR5mOgG?=
 =?us-ascii?Q?+TdjLaaLmO2ieZh2/P8k19j9c+DG40RZbRBhNAY3p3oUPxH0t3j+/baIj15Y?=
 =?us-ascii?Q?gYwmnFUtQLB4qftcxV0n+YxQJYtisarreFo6OpLd9rY3AMOGSxvF8+ZzyuNU?=
 =?us-ascii?Q?2d+VIT94n1BtMqLEK+T5HE39ebQom0jdEoMWrHct+Mq6fg7z29kJ+gDDJP+V?=
 =?us-ascii?Q?1AcbKC6t1NUeNKJOACcEV5jm3JgepsOu3UNOW5JOk5MqWLNs9k4YMGjfsAkv?=
 =?us-ascii?Q?b5fyUh6GEVQLGXcStoa6tJsJUelfp/WEbAfVcrDSiGk+iJiERhJIPoU7xu3d?=
 =?us-ascii?Q?TVLFIB1BizraLW/HwPgvL12xXZLTY2/UEO+4XaxuvJwbGk2fCJSwEZ8w8AY5?=
 =?us-ascii?Q?jfqs6V+6a4G4fv5yNAusiPCq/utxWG4L1WoxCTln54V3ZCQnQOsbNzHMZxvz?=
 =?us-ascii?Q?7qZDHMM1Ie8gPz505cAv8dbU/Fy/cyiS2GkjbKwCFpuo7eviDDryb20g2iuF?=
 =?us-ascii?Q?6vkCfLSPaV4FWtnzcQ8Ai2DdpirWjCloRDOh2bXxCx6Z5qxMcUb/PiZF/jE+?=
 =?us-ascii?Q?qDS0swSMt0RwfTy361JhWj7d61SFSCWzt2QufQP1zRvN/JT9fcm5iFVcD1ai?=
 =?us-ascii?Q?MJu9RPtJzEYjBtet4ufWpJHf1GPaIZeBsT6rQ7D8nJS1Cgi4Mf5sqhUeHiH9?=
 =?us-ascii?Q?+P93lUo6+4QTDHU/likMX8juFl588YhJoEJ/eaAmHgjszG9WCuwnBo8ITlJm?=
 =?us-ascii?Q?zDecxmJkuxek82mPImuAd7z8QUmH5ACGZIH5g1YLWzEUNEBGwQk2OUiBlWuY?=
 =?us-ascii?Q?lXOSMW6+kdHSn8XYUACqpLSbjQOSSMvN0REp4YPLWVZqzu2MF44GR+uzF7gb?=
 =?us-ascii?Q?vWiELm0t10+aEwm7L7G+QhxNDg4QlZUaoQzYolnQW1XjF7LnlSxG5lPQYNey?=
 =?us-ascii?Q?OzllT0BH/jWef09/G1s5MNd6g+0toGwOvZBdvT8vPnc75U4bTjmb5NmxllaM?=
 =?us-ascii?Q?eUg3U6TyZa5LxudhHhTruiO+Emv1m+T7VHe03W8B6V0Yk0EyNIBnAmaNdqGB?=
 =?us-ascii?Q?/BqH+R4YBKf+JWPmI+q28Ow52KNdJNzH8k8PeaTdrcdHsVWU/8MaZKYOtnMJ?=
 =?us-ascii?Q?JgDpjcpOddwkJiLbhogaZrHlL1m9nh0fuQGoazb2Z26ZaoiU3aFeS9A+S7Gu?=
 =?us-ascii?Q?vvIC+KT/78FHZApv81m9i1UWvMPKA7TwSqu8YL8whrzsdW3v7425YQAPAWvH?=
 =?us-ascii?Q?P1eGnE5bWZcZc+oAFc4ErC35XXZ8orXo7UpQXhrQEtPKX3ettJHb/ZaU8Mw7?=
 =?us-ascii?Q?4H3PddQfaeLh8ZAgU1IkwSIM2n+nAMX/F0AFGy3y3jaCa+VFWyTEQCgSG8RR?=
 =?us-ascii?Q?sgvfLPBEMN5Bi5HU1S1DcJCuAPvxpqkCFscYE+npY2rFlflS26eaGBDsWSon?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bac24ac-5f30-44cc-b09b-08dce9595852
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:28:32.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kn0xiAXsmviSxSZ3PmkrNjeYEDX+1UeyvzBdu8zPlaj5mGCY1mxMgi1pG9mAZn8x41vvKtctvJgVRz+hskve2vK4cQpcOKqZqOaBZsBEtyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7565
X-OriginatorOrg: intel.com

James Morse wrote:
[..]
> > Yeah, it should be a good way to let the kernel know whether CXL
> > supports memory tagging or not.
> 
> On its own I don't think its enough - there would need to be some kind of capability in
> both the CXL root-port and the device to say that MTE tags are sent in that metadata
> field. If both support it, then the device memory supports MTE.
> 
> (I'll poke the standards people to see if this is something they already have in the
>  works...)

If it helps, the question I would ask is "will the ACPI CFMWS (CXL Fixed
Memory Window Structure), grow a new 'Window Restrictions' bit
indicating the presence of EMD support, or will it be left to an ARM
specific enumeration outside of CFMWS?".

> >>>> However, why would it be ok to access CXL memory without MTE via devdax,
> >>>> but not as online page allocator memory?
> 
> >>> CXL memory can be onlined as system ram as long as MTE is not enabled.
> >>> It just can be used as devdax device if MTE is enabled.
> 
> This makes sense to me.
> 
> We can print a warning that 'arm64.nomte' should be passed on the command line if the CXL
> memory is more important than MTE and the hardware can't support both.
> 
> 
> >> Do you mean the kernel only manages MTE for kernel pages, but with user
> >> mapped memory the application will need to implicitly know that
> >> memory-tagging is not available?
> > 
> > I think the current assumption is that all buddy memory (can be used
> > by userspace) should be taggable. And memory tagging is only supported
> > for anonymous mapping and tmpfs. I'm adding hugetlbfs support. But any
> > memory backed by the real backing store doesn't have memory tagging
> > support.
> 
> Hopefully there are no assumptions here! -
> Documentation/arch/arm64/memory-tagging-extension.rst says anonymous mappings can have
> PROT_MTE set.
> 
> The arch code requires all memory to support MTE if the CPUs support it.
> 
> 
> >> I worry about applications that might not know that their heap is coming
> >> from a userspace memory allocator backed by device-dax rather than the
> >> kernel.
> > 
> > IIUC, memory mapping from device-dax is a file mapping, right? If so,
> > it is safe. If it is not, I think it is easy to handle. We can just
> > reject any VM_MTE mapping from DAX.
> 
> That should already be the case. (we should check!)
> 
> Because devdax is already a file-mapping, user-space can't expect MTE to work.
> While some library may not know the memory came from devdax - whoever wrote the
> malloc()/free() implementation will have known they were using devdax - this is where the
> decisions to use MTE and what tag to use is made.
> 
> I don't think this adds a new broken case.

Yeah, makes sense.

> >>>> If the goal is to simply deny any and all non-MTE supported CXL region
> >>>> from attaching then that could probably be handled as a modification to
> >>>> the "cxl_acpi" driver to deny region creation unless it supports
> >>>> everything the CPU expects from "memory".
> >>>
> >>> I'm not quite familiar with the details in CXL driver. What did you
> >>> mean "deny region creation"? As long as the CXL memory still can be
> >>> used as devdax device, it should be fine.
> >>
> >> Meaning that the CXL subsytem knows how to, for a given address range, figure
> >> out the members and geometry of the CXL devices that contribute to that
> >> range (CXL region). It would be straightforward to add EMD to that
> >> enumeration and flag the CXL region as not online-capable if the CPU has
> >> MTE enabled but no EMD capability.
> > 
> > It sounds like a good way to me.
> 
> From your earlier description, EMD may not be enough - and this would depend on the
> root-port (or at least the host side decoders) to support this too. I'll poke the spec
> people...

About the best CXL could do is indicate that the CXL window supports
EMD, but that is not sufficient for determining the arch capability for
MTE, so something tells me this might end up being an ARM specific (ACPI
or otherwise) enumeration to flag which if any CXL windows support MTE
regardless of EMD support.

