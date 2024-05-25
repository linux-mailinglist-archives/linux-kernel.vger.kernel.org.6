Return-Path: <linux-kernel+bounces-189347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11638CEECB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553DA281AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546503C48E;
	Sat, 25 May 2024 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLt4X/uV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EEF9CF
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638281; cv=fail; b=WB2cd6uFMsPn0tm37etd/ksJzrXrTKMJhCN8wqeEwBTyG1fJOKsoxFZPNH0DfMdLI84Xsq4sAWRsQM6RXCi1cModMh2JtamNv+Uk+r5SsPe5wVfjVjmQsX77DpCoDAUnKB/8zbx3UejTOH1+FzcC3tBT1w6OauGhiux+wRQ+TOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638281; c=relaxed/simple;
	bh=yPl86q0T491wScZEHPMX6F8xyneEnw/g4xWJtfzRPH8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvpxpwgq2i3pWE0UWjwTXOru61kHxOib172XEdxCkghZQ969WATUhz0AbKtul9sNlq279Aqokz/UwxK0bu4uvWhF5pXE6Nb5NWEgP9oz1Ih3grVbFPpaTmLUs2+KJhn/4BmqyFinkkoPVP0Glj2vNeCTDRV77AhfbCWskzRlOp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLt4X/uV; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716638279; x=1748174279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yPl86q0T491wScZEHPMX6F8xyneEnw/g4xWJtfzRPH8=;
  b=MLt4X/uVxN8uoz4qEfLL42aeZOgSr+HZu9MW0ueb5vDkVfJMRLD4nHaH
   sgWNpUgSrb687tgQmllpA3wmv/epyrtZyVZROC6DEfROuwJ1WwYD9F4YX
   IlhwOlj1BGCKukJXrsZPYsqe7TDckChhK12MoxLHxQP12nVFj4ggCN689
   m4ocFAihBiZCkeFWHjnJtgMIyxD2wLjfgJJSe1tTAsxO9Mum2wE3DMQhq
   wtBLYJT98sf4qiMhQ7JBapfMy1OrBmpqAhmNqi1OHedRSeaJSgeWPaqNt
   Mu4Cd0qizHzaqNw0+TmYZA01TbAe2uA2scbfGZ54ZA6DHhB9MitskSCJg
   Q==;
X-CSE-ConnectionGUID: 7ahEWHUVS4ygXFRWfZMyhw==
X-CSE-MsgGUID: 9V0zl255StCOJv11B/nbbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11083"; a="12851586"
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="12851586"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 04:57:58 -0700
X-CSE-ConnectionGUID: R+5R/HQoTqSPyPF1m2NvAA==
X-CSE-MsgGUID: GNAF+9UISBqlfuFW4EWMWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,188,1712646000"; 
   d="scan'208";a="38708428"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 May 2024 04:57:58 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 25 May 2024 04:57:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 25 May 2024 04:57:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 25 May 2024 04:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekwyl7yi12AqMKhgrWWmpYd6XIwDbCIE7fFBqe0b3IThDX3n34PHHX8HfTUzpOXf5fxY/2aX/DSYuOcAHDGAfopH7k5MbjfUvpJFFKmHspxkfjNdb2h4io0hR58dzzIgW5RCk9WIaY2u9t4rDh0/BRJ52jiifCDYkCT3EKjieeG8HXMiBnIcAI1Agm37h1/v/nY6VlnWNP1asGxsbGcDVpGFtr9MS5gufTUSkl/BIPaBEF4LbZebiIjVlQDWibMPYsPe0M3lcY+KPa/r4FcsHA8qF4jG9OPz6q+mGaO/aCh/63R3tHnfB2LMyjekzqx95sm6ZtkjLPYeKfPOQLuzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEblkcFox+pEXrbsgJQohXJptyBpoP6ybPXVyfeO4cU=;
 b=SdNbmz7Grj17IpR20jT/Ay1kZGyxc8n0G2t1WBEEkkoZftr/cPGeejoPxo2oy5iSzFn3o8QNK1lzCk5cVgP1D9goB4ePb9LU5AylWDpO0zphR+HPs+COEzRnQ+Lfv7lE+YSczIQqh9H7LU/bM9jYypoBEXRNn6/ffHyVAsC7zDWWXCRIt6THS7U/Hm3P4iLQ22o7Yus1EadbuRT+e8xCBgluFsi9LpSdx601vDd5oGVkHQIKoklGLulEaCowM1/aYlWx6YCMIV9+YwIdDtTZeKAIw0Zuz8bY9/eYcaRw1NtsGeGvARNaXhIrwEZGtu2oHLDU17R7NcepZ/6gQgdHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH7PR11MB6475.namprd11.prod.outlook.com (2603:10b6:510:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Sat, 25 May
 2024 11:57:55 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.7611.025; Sat, 25 May 2024
 11:57:55 +0000
Date: Sat, 25 May 2024 19:57:41 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Mike Galbraith <efault@gmx.de>
CC: Chunxin Zang <spring.cxz@gmail.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<yangchen11@lixiang.com>, <zhouchunhua@lixiang.com>,
	<zangchunxin@lixiang.com>
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
Message-ID: <ZlHSNXe0c5/sx9D9@chenyu5-mobl2>
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e17d3d90440997b970067fe9eaf088903c65f41d.camel@gmx.de>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH7PR11MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca6111e-a6a7-4db1-5158-08dc7cb1e9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zofgh4TTGIuHvI0nWTZx3t3SA5LQzqx5pR/2Sm4sz59JYJO5fGrMIGBE7Y30?=
 =?us-ascii?Q?Nx8ROm+aKupGpPE0SZnxlFulGTrkYmXj7s6VJ8rMhhla1HIFknzXO67cJJ08?=
 =?us-ascii?Q?i7BBAP4NKHCXgjIjmBIBfA1tX/g7h0l0G4fl/unyEKcUcKzSRh5OdTUoSHoL?=
 =?us-ascii?Q?NnNa/eJfua+jW2NKiH8c8IBfQ+Br7cX+zeVHtOaTEUhRLj036IrBhDQpKgMC?=
 =?us-ascii?Q?759VtQl+tKZZK+RdZuaNqNw5dplZ2E1uoePjTqdX58xKt8+EjhTDzoYDpye9?=
 =?us-ascii?Q?7yzi3BslsEmyZWnhXGhNl8lM+MZe3rZck6lojzmCwkdPImzo5cBGscG5+375?=
 =?us-ascii?Q?MbDv5u9PE6iXPCuzBVY0Hhxyl/PHubFF1JqdA7LM7v7EP0STlsj1pCnZRfrm?=
 =?us-ascii?Q?qPy0eIItzwYlPvY7E52kWiRwgQp+oWhtDKpmh5BB3eHsAUWaOTiGTlV9t+Y6?=
 =?us-ascii?Q?t/TVIM1ie/qcyUMMBwN8fmmSRp9HYUpDmwLqZftjfQJz59zjVjvNyFzf9Zok?=
 =?us-ascii?Q?Nh0+pzW5vZJP0cYaCfTHKPabbzmMlJKjVPENMTp/XIMMMjUbqC2Huqq4RX3G?=
 =?us-ascii?Q?1I4qOSuu+ZNL9zmgBOETsB7cX+ZvS9QlmbOOohBy75kx7sMjGqoXrOypIVi/?=
 =?us-ascii?Q?4HI2AZxnI5U3aONo6eHOQ50uDKfy2N82ZArwVyKsqC+NoYxEcs2v9uJH3j1K?=
 =?us-ascii?Q?UZT3E0AkAfa40T6yGTKXxxSZNQg5VJp8YbBL22HnVa9L2q94vs4JHw+lxBPJ?=
 =?us-ascii?Q?fa4ncR1O7iMIXKk0kxmPZ+uXCEuhgayfrDuUPMSuCgPAFMdSFgIVXnWI+sVu?=
 =?us-ascii?Q?ndGCIOUkrocttyk1LS6AwKK8kfj2Fx1nCgrH3Gl1TOYD7awyqQZKdin+keJd?=
 =?us-ascii?Q?UHQMivhSsnX+vIgmpScfIor3rV27T4y46d7uft9Z31xITYOf0t+RGzHkgCDY?=
 =?us-ascii?Q?LXas19AgkmLeB2Or+K3MzMJUtoC7cAE6wTH8/n6agPF2Q/nmkiYDfJ884sLL?=
 =?us-ascii?Q?u3mU2UxVEce77cuC0zqQbt6uA3AnnkDLUHuHsxHNknYsqg4G207AJoIpymkw?=
 =?us-ascii?Q?N1IblUdUI/g0eedZcx+RXIJyaET8bT2hDciw9izMgagX4Q+uHOGNFdOiM5lE?=
 =?us-ascii?Q?jk5bKglpnAOyePHYQ5xUlWpMEliDetRrCH4Ej6vg+4z+eLyqEQgV7qYpxlwY?=
 =?us-ascii?Q?X1QyXYrwU4ZEXzX8L+tIc6mrzUGjsXgEO+crziCcbh1wcD6nrWAOPsj/EfB8?=
 =?us-ascii?Q?DWbtyTwW8FnNpQKq43fRxzsOfWNzpSK4lakJOE+AhQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hprZRUi6k24c00BbRIX6NWCy6E/EYapF5QmpU6Gn84J1/W97oskP+XgD0FOJ?=
 =?us-ascii?Q?fthnnCJOxsuzVGhroozZhpFf7ZQHzebp0n07uF85yJE/6N1Otoc+ZRmIqwpm?=
 =?us-ascii?Q?qAKqcT4dpQ8l+oP9PkjscJ9/6LIVxnfKcW5X3sWs7cqsVzolj2uW2O2ugqS4?=
 =?us-ascii?Q?JfqYh9YbMwXvL0d+vPPh2Jr31NFl1DfRmiMZrtlCpdPYUa6/WX3GTuLrc2h0?=
 =?us-ascii?Q?qNiM9ycHxHDbuMXfq4w5n2iA+E3hRMI0RsQbCIqMgoQGphgCefZgo4XlTXTa?=
 =?us-ascii?Q?HjZEUBzl1wh9F3GtoZVGma2qbsgrRr3wqOkw4kgone5XCiiJ64oaUn8q6Czf?=
 =?us-ascii?Q?W7lg2Ft6TarQwffpWh+w+fTiThdOlexOQXr4YBaw5mOgTJefLDFAZ8ryOljI?=
 =?us-ascii?Q?MamCvJomMcS0xc85kKxC1ISVT7LmzWXpvfjgcD6J3YvN6RILiHcMqM58Nogs?=
 =?us-ascii?Q?IQ+yPv0itbm7E4dpE5N1fBGGlSqebkLSgFe6VY2tjkuU3Gk6/tFiAsYbnwzP?=
 =?us-ascii?Q?ECJKHozNavHFl3m8xfOoi+OcZ5p9sfXN9UOeOmnp40ej8hZ8EZaCbW5wLY+/?=
 =?us-ascii?Q?UB9/QU0UWc0weY9RZOlegxQ8ytZVGeMNDrADOdh7+iYcynmphVWhwjs7F/AJ?=
 =?us-ascii?Q?7Nz7pZ6e3xkPRm8C2BqmWrZbCn14IYiKZcvvrWcMNb2GcPubeGRZalFkGh8W?=
 =?us-ascii?Q?Z9W+Pwih5EYSQ6RhyYOHNOzvN8D3tSKkr0j1AeoHxT/wOMIC57Fb461q8Vyj?=
 =?us-ascii?Q?CoPgcArs/z/mLMYVhylAD72+okutqRpEL3VpKjedSXmPMsIsoj2bF8Ci1s6X?=
 =?us-ascii?Q?t/h/Vk8DcSg3GOqvMEsFXB6pwM+cunxzpzjA8qzLtPtkMXtvupxLOkD0aLme?=
 =?us-ascii?Q?NT2JbQnKdzH3VxVpobjknjRFtRjSoM/jnnmwKmVYG/3IlC/3BVbiDSOSUBUx?=
 =?us-ascii?Q?64dlLjfFviL0gKTg3t4/z1LyhJHc2YnRpjUVPisKdR22zbPUsPCm9z9mx57Y?=
 =?us-ascii?Q?acZNNagzdmR/PlUJRWdkH3x7/H2qaScrMsD4f8E05Wk0kOW+CKecYpZiBBwn?=
 =?us-ascii?Q?ZnVBtrK1o69KLiOcEcvQmrZgm1x8BTKYPzTQ1J8cVNJIGCpeozl7K0GuBNOy?=
 =?us-ascii?Q?8VhrjcXCaI87TzhetkTUxo56PNZvJXe2ziTx4XqBA5Uhm5ywS3DMtHry6yh+?=
 =?us-ascii?Q?wbhHO3Eaf/+pUz5yNu1zED7TACVZ14OBuSnrwQ6iKsDRUMOJpdJVB/4g072P?=
 =?us-ascii?Q?4umZLgliEwnPGHmYA8qpeouwBPMUX7uwumk28hvl/p5/YQWF4Iq2qY8qnAiy?=
 =?us-ascii?Q?fzhepnWzv+Ktr4BsUXNQhW7o1/ywsuE6HbGWppHdrtvp31Tkum+PnoUwqF9K?=
 =?us-ascii?Q?u3ozkb8D0LH2c3OQUDkhU5z6D+5rBRzbYVE4y0KBBCOXzYOMQcR0NCxC70RQ?=
 =?us-ascii?Q?wu0Y694U/JpRxX7OFHd4xrX2jDSIg3elNR+LNwbwE6z6kvQqeoUf8nDoCP47?=
 =?us-ascii?Q?tlZVaHwp4sCDljp1OxUaKg3cvdVR9zMzM56m9Xxj05RuIaAmbbgdxAE1/dlT?=
 =?us-ascii?Q?jy26xIolydH5fxZvxQP0AhmzfUfK+E7/Rey923+m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca6111e-a6a7-4db1-5158-08dc7cb1e9d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2024 11:57:55.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NktggHkJZb+SOdSajamLIcFiOrtmDOiTzr7cwG4JaucYYR12IM7HEXvGH/q3KWOsRo3A2I2lfW/fzQkQkxzneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6475
X-OriginatorOrg: intel.com

On 2024-05-25 at 08:41:28 +0200, Mike Galbraith wrote:
> On Fri, 2024-05-24 at 21:40 +0800, Chunxin Zang wrote:
> > I found that some tasks have been running for a long enough time and
> > have become illegal, but they are still not releasing the CPU. This
> > will increase the scheduling delay of other processes. Therefore, I
> > tried checking the current process in wakeup_preempt and entity_tick,
> > and if it is illegal, reschedule that cfs queue.
> 
> My box gave making the XXX below reality a two thumbs up when fiddling
> with the original unfettered and a bit harsh RUN_TO_PARITY.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..922834f172b0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8413,12 +8413,13 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	update_curr(cfs_rq);
> 
>  	/*
> -	 * XXX pick_eevdf(cfs_rq) != se ?
> +	 * Run @curr until it is no longer our best option.  Basing the preempt
> +	 * decision on @curr reselection puts any previous decisions back on the
> +	 * table in context "now", including granularity preservation decisions
> +	 * by RUN_TO_PARITY.
>  	 */
> -	if (pick_eevdf(cfs_rq) == pse)
> -		goto preempt;
> -
> -	return;
> +	if (pick_eevdf(cfs_rq) == se)
> +		return;
>

I suppose this change benefits the overloaded scenario:
neither current nor the wakee is the best one.

before: current continues to run.
after: best se in the tree preempts current.

hackbench -g 12 -l 1000000000 & (480 tasks, 2x of the CPUs)

cyclictest --mlockall -D 1m -q
before:
T: 0 (15983) P: 0 I:1000 C:  43054 Min:     11 Act:  144 Avg:  627 Max:   11446

after:
T: 0 (16473) P: 0 I:1000 C:  49822 Min:      7 Act:  160 Avg:  388 Max:   10190

Min, Avg, Max latency all decreased.

thanks,
Chenyu

