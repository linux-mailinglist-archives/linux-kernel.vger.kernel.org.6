Return-Path: <linux-kernel+bounces-369102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300E9A18EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E141F22B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD06770FE;
	Thu, 17 Oct 2024 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJMkMX3Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536C64A8F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133949; cv=fail; b=gc9OpH8ucN06LqMWovrgznrWB9QrHafvLGOK1VDE7gfWgFOaxHQI9bO35SyJBDSYBmi75I8MJ+emUgfCuwaLrYm0TTht3WCIjVyh4uO8e+KBNkEJ58/UqhHAc5nj9hTBK8DoeSESMwZIQD1owzbYDQbywicwhIG79cmpnpDLH4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133949; c=relaxed/simple;
	bh=wf915rR2OETMa+1060GUuMnjgsP4BQ0ya3C+BaYn2eE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ekrsGOozhWptSEF2a5E4IFMKjtiFz6miXQerORAagu6wePe+Th+XrrQCUIzgrGx1Zmjv7V6ybhw9V+yEyGdZGOpnOtjdS9PAR3kC9PgA4p7X8NwfAinR1AydryPwDJKEU/EG+SICICm2bvzZ4OGS3/Jddm7v1KSLbyY/ioyMhPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJMkMX3Z; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729133945; x=1760669945;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wf915rR2OETMa+1060GUuMnjgsP4BQ0ya3C+BaYn2eE=;
  b=DJMkMX3ZhzliJcTODDigqf9IzMt2KHAakfr2wyuYh4Kc2uWmt+pXQ0ao
   rlUGaWQyoN1/JGgXdeUfnZSFwEgfRoUGlmntebRvA4K/lZquoDYyiCIYh
   U3kh1AFh14J9A081lukziMg8TAEPcTLjDM5ZIIcuKw+G+fIvpCdyaPN5q
   471ZQQwfwaxKLMERqyErMlJhd/3PcYodCY4tKi/c1As9NaTr7TotheOXs
   hrQPNgWRsS7q/AgvDxQypRN3sKCHd8nvDY5M5emtJVZWylKYdxFhp3l5a
   Wop6KRR6ZRuqX/sMGsO7peGSGFqa3JYWXqeHMh7EA63pREhfsGKLWouSp
   g==;
X-CSE-ConnectionGUID: ZHqVr8kJSbCBjrBZSDtW0g==
X-CSE-MsgGUID: +/ZNhJItRI28TYiPywMPdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39242653"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208,209";a="39242653"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 19:59:04 -0700
X-CSE-ConnectionGUID: ODDEzJwgSaKoQitclYdcNA==
X-CSE-MsgGUID: OBCuJ9g8T36nh05rbKtPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208,209";a="78844949"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 19:59:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 19:59:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 19:59:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 19:59:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 19:59:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4Dg27DrZxmL+ftsOgvyCqzFGLKl/XN5qC5UMb1mUEoeGWR3BoJZD6FI+dvSaBhN//sIMNC/nzbQWAfA6UfZMiAZBXwCpKVdiOUmd80nfp+zClasvZk7wzcD5j1kp52diq8jzgh6KyiqJeIYavBmsLQvFSIAmHcR3D4UwRAbIpwjO5yGd4RJV0Xf7TYwDSu7d2CwbYvQYimtghW2gvRS9mDPG4kArBIKzFND+HVkH8M17aRREG5Y7tnkCyc1l+YiAJNqbwcOc5WaPWfAPkb9jvgiqXNN7CPdTU5pa3FatpSmeIuPIUqzcwQLUY+CiTqSDd/JFQ4w31ecdgN83+mQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDQ+u5qUijicLmUl/p24TOSGnvL+Ew6jHjEy8Bj33iw=;
 b=I2t6IInFvHsf9F5crGDABhpw0M6dvw+hM31Jq4P6AswC0Dqp7ZOIQV5HmXvv+mJ3n8h0KLyhRgV+3MFDfVqWkGnMeZiOUaBhvyXOoymKX0lchCOBS/rz7ZZWsWozp6o844g5oqW7MC2MmLhayiWmEXWWJwCpEE7j92rLdVScM9MLe61jjPPKQY/JJ4nVsfovLu3ssr6O6yAY6nPCSfDeP9xgt5p7PXijZm7v2vR+q/JqxDhswi8uKyfVuaBAuKkFVEQo6lUQQm/md0UULdGddPnX8Twn13OfU2zQprscTcoZ1uOs0L8CRj1Ob6nV/DT7C9GRGt8aF3OiTeTlYp8q0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6906.namprd11.prod.outlook.com (2603:10b6:510:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 02:58:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 02:58:53 +0000
Date: Thu, 17 Oct 2024 10:58:38 +0800
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
Message-ID: <ZxB9XpvYoDrYgnah@xsang-OptiPlex-9020>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
 <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
 <5b7227fa-d0f1-452e-b1b3-9d7b87641522@lucifer.local>
 <ZwiRdemGMY6Z6pSN@xsang-OptiPlex-9020>
 <fa645dd9-3835-4e1d-aa04-1892d97a6c86@lucifer.local>
 <af510726-4245-46c1-81bb-e32379c2c127@lucifer.local>
Content-Type: multipart/mixed; boundary="t1myKVu9sjgSYkoK"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af510726-4245-46c1-81bb-e32379c2c127@lucifer.local>
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a1d3f0-358c-42f8-87ec-08dcee57a241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NJuQxpWvsoS7Os5mcdRzExrzplq6UbPkIVrbI9mUPoYf94girCSs9QIoOl9H?=
 =?us-ascii?Q?Sbngj3M5McoMr01A/aWPLwbmSmfAQVS7F73goGyFoy+DHNu8rVHX40CIeChi?=
 =?us-ascii?Q?MpWQJDkE0bZlMlTQ8f8ZoDcptBWvQS0FjIuzfzTPA3EWPVsfzsrV82Bsqtjr?=
 =?us-ascii?Q?jlZrfC8j/3CkzP7tsN3zT7Vv3xU1LJ3e3Z0ze9GMSMWS3Yi6vb+AG+K092jf?=
 =?us-ascii?Q?nzr1opC0Vb9hjfTcv9S30RZtHxXWYtDiOopH/8GBe91xuhYR4Epge34uZ+ua?=
 =?us-ascii?Q?WWiu2uKfiQF9Urxwoxun2aWakRjJZoBwrNSzTe/UMdMpBssBjwyHfaK9+bNV?=
 =?us-ascii?Q?GcBgazNXNGyvnMwy+BmptUOKMQDgxwE+6sLwdZVPPG2nH1zeRvtXhx+IAi0d?=
 =?us-ascii?Q?YSMc5R+ZOH4bqkQUrCjpOEPiwLCQLXL9sq4KZuu35OTHNJT7M6fiCIJm8j3O?=
 =?us-ascii?Q?v8i3nrFm9M3H/iuhaT04FqGi+RrJexoQBWqpAqivJvTl26GxV1N3tIujvtil?=
 =?us-ascii?Q?s+WZry0rsFQl7Mc1J5WD5Ej9pxd1IqVExq9yj2+Nb78SodrdzUmgP96qEtj6?=
 =?us-ascii?Q?qLay4Ivpq4jI6zqyvuEpqYtEb9fw4ylizzxqMbS7feg8EDLuO3R/iUWwO2c3?=
 =?us-ascii?Q?Xnw0zqiJLGR88sT/xPBu9U4dhRiqFXeHyrBtGO5pJeEMIGMsHXifeTmYiFtt?=
 =?us-ascii?Q?/Xyc7ohb+Rau7GL9UsaInDtmzGa/7t8UTDndWVLY6oVvBY6EpQ94bUKSj9Sg?=
 =?us-ascii?Q?gr+nGGG6IljMJKRqUZILvhyEClg4FyNCrl5LhWB3HDnGtO+VV+UxJk/d2LiM?=
 =?us-ascii?Q?n0HpLwadXT5KAw8wYFXqfuPpXjfEFw9NxYPou/pSKpYJ985xjDo7hIHlKyvU?=
 =?us-ascii?Q?mg9KcTKde4yD+FKrpB/aTM+TeNRBRiGxMqadwn9q8b7FgPLix9X+jPLvK1z+?=
 =?us-ascii?Q?x/k6sGC4tW2Z0gbS7LdSFN9JvF7FMrtvUDMeiwUy08qSY3kuHiYdGnYiY5n4?=
 =?us-ascii?Q?FblK8y4mJuajn1IyYTVdwuY2tuqbhQaSixvoHRBRVGU54vcBNpjJjkFgqRgP?=
 =?us-ascii?Q?t6BzSpMcCgWqtDEe5oZjjNXmw+zavxZV1BKYy3i4eX2Ns3Ot0k6ho+fA9HWP?=
 =?us-ascii?Q?UjMyjx8Y8wyoD07OOvx14oPQ49JD7P0ek/c2MK2fjivrYbvl3TRqSzb/E3ra?=
 =?us-ascii?Q?RV99AJTfLSe+8a3CnSsqSVVAnfyS3F/dr430k9MbTJeIFIf6yTk3HxM19zVz?=
 =?us-ascii?Q?nMfBzVLcxvTFoJLzcPV03eR6W5GcbOg7UGomCsUqh7M65+srbG2DY8O4niT0?=
 =?us-ascii?Q?Uc+DtUtAUg03HVx7DXHub+uh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T64H/IhB1zbi8e7EsaFplvNemr1fYBdDAoQBrKSucaMntdfv0ueWPK4XjGUd?=
 =?us-ascii?Q?cDHjscj0MgHo7iPMq5KMieUNXqw707P4vEDSFirITi+T2I/GLo8Bw4pk18NQ?=
 =?us-ascii?Q?T11tUrMFnVWlz28b2GI3IHRmyED89KedQjWI/GL3WC43W+CMDYvh8/Rn9gv5?=
 =?us-ascii?Q?lpQbKKOXZRgAnIMSMDWZwi3vBZIlqP5jeJU8RCDO39eV8qED9GaR5Nctch47?=
 =?us-ascii?Q?59dirY48cdykvZo1iFhBfgJw+QFbWcfhrvpv0hTIQqZJrvA4pqsiI1pRrOml?=
 =?us-ascii?Q?ja7ug7+Y+77kDAAopLCBzH5vxJVjhBxd30sPcR1fVdFHSO57UyEiCfb4+fuO?=
 =?us-ascii?Q?Axc7MhoW5zQY11EGjBseVnxuUyntxq+fKWMfwtkBLORpv+841zct7+8aRROa?=
 =?us-ascii?Q?eyHSZ/MVsR+QIoPje7KjymnURKp/APYSaLDbkfXR+nyalm0sU/MnXqHxBFNY?=
 =?us-ascii?Q?50RalXFQ/iykktUGa0ohSwv8xvez7OIa5RyE+XUfiZHAPJmaIIUhmkcZkntt?=
 =?us-ascii?Q?9UG7Bp7xw4ViBoskvy+4l3d3BiOjPJzY2kgu0nVgCPDLlPT4Aga864VJBPss?=
 =?us-ascii?Q?rrZ6huNvVXwpfV6MaUCq/ZcyQlWK8sp/v764M5yQQega8thjrZCgXqAjrM+s?=
 =?us-ascii?Q?LonHrzbWldbdT/duroJqm4XlI+LcRHYCb0+ta5BqJ9J/kOLWNF5T9lT7DJEt?=
 =?us-ascii?Q?KkZ4pIEg8Mdb/UBx4Magnls0Qpegkq48NlMmE52tejdM0X+dF5boRDv/cfwE?=
 =?us-ascii?Q?UhcgX/yX86O5AkFAYxlhzGtHYLf60m+okDm02KBbRKw0UWFAnEimdG4A6+sP?=
 =?us-ascii?Q?T77UNmeAXT/NiOhAlUo1kROm6Ji2TtkzPWzUYCJdp1yvYuo/45ylL1xRBJ9o?=
 =?us-ascii?Q?mq7YI/uyZF/9QOIRa4Ln4HVq5/KrGpujbT10Dbt29Saf7QRJdFmagQDzZTlq?=
 =?us-ascii?Q?plXqYSRR9LWr5rMSlEhkk+7hfj5hT1imjbJ/ifg7LvpytFR6OL3j8P7MVdSw?=
 =?us-ascii?Q?5w7CXybUwJtRzAIgXNnKcSWCIdzFpRwKhDOy3ATX+lhYW+3U39hIREB1GyxW?=
 =?us-ascii?Q?UzHt6Rnz1ZJN+B1Bf2MXxCR7Xfp0wGWmbZftbZHbG0+yFkckxqVwmR3dn1Uu?=
 =?us-ascii?Q?8EdYNB7RvED9ACZkO9E3CV/k0RB1H58rR9g+dmGsHCZwZCyyLyq71OOun0GW?=
 =?us-ascii?Q?PLMgsd+DZo32YlXkNyWXavgK82xQ7bG6i9CpPkSs1pRuNRy5VcohDNT5wSnx?=
 =?us-ascii?Q?m+IAFFABluwnqNb57zZGa5RW8M5zY6Wdcn0Tut48fdw/g8UUbzhzYyIBD/v/?=
 =?us-ascii?Q?sU1OHXXiKFZpF6aW7VoZU+EvNDOFLFYl/4mTR/DF9LoE54LR7GQ1MwaGmL3r?=
 =?us-ascii?Q?r2xU8FECFjxvDSdIhmYtuvrCPag3jbiL/eeFrUJN6M6zdEya5x/dvPOkpvLz?=
 =?us-ascii?Q?UWJB8Z3ZbY76YuOXSB2aOrolKiul6NHRHC5+8baMoyuGBPqiZkDwc3GneF6w?=
 =?us-ascii?Q?sQ870W5bZupgRBGqbX2dyD4ZtCzg4mCmb6ZmO+SfCZnqJ8bcSQ7CfDsA7Rz7?=
 =?us-ascii?Q?CJsPCEc2hvBYSd6/2bF8rV6IA4WErT5ESctIjBUizj9y5aMjktRyi5MYjofz?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a1d3f0-358c-42f8-87ec-08dcee57a241
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:58:53.8129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tF+jxnqDZ5FJxivFDGNOaF5itwPhLTrZqHMhGbbcyNCSpYw5Ma78iDIUdbYBVqQEZsC5ZM60v2cxxNpjVbRkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6906
X-OriginatorOrg: intel.com

--t1myKVu9sjgSYkoK
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Lorenzo,

On Tue, Oct 15, 2024 at 08:56:28PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 11, 2024 at 08:26:37AM +0100, Lorenzo Stoakes wrote:
> [snip]
> 
> > Thanks for testing this suffices to rule this one out... I will try to get a
> > functional and reliable performance environment locally so I can properly
> > address this and then we can try something else.
> >
> > Thanks!
> > Lorenzo
> >
> 
> OK Oliver, could you try the below patch? I have got aim9.brk up and
> running locally and for me this seems to address the issue.
> 
> This is against Andrew's tree [0] in the mm-unstable branch. It should
> hopefully apply cleanly to -next also.

I found the patch still be able to applied to cacded5e42 cleanly, so below data
still based on this applyment.

$ git log --oneline 9cecc5dc893886
9cecc5dc893886 mm: add expand-only VMA merge mode and optimise do_brk_flags()
cacded5e42b960 mm: avoid using vma_merge() for new VMAs
fc21959f74bc11 mm: abstract vma_expand() to use vma_merge_struct
...

again, if some patches in mm-unstable or -next have some impacts, please let me
know then I can re-apply the patch and do the tests again. thanks


by this patch, we do see performance recovery but not fully.

e.g. for
model: Granite Rapids
nr_node: 1
nr_cpu: 240
memory: 192G

we got better score from the patch than cacded5e42b960, but still 2.0%
regression than fc21959f74bc11 (the parent of cacded5e42b960)

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-gnr-1ap1/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   3220697            -6.0%    3028867            -2.0%    3156931        aim9.brk_test.ops_per_sec


similar results on other platforms, full data is attached as
fc21959f74bc11-cacded5e42b960-9cecc5dc893886


for
model: Emerald Rapids
nr_node: 4
nr_cpu: 256
memory: 256G
brand: INTEL(R) XEON(R) PLATINUM 8592+

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-emr-2sp1/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")
  
fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   3669298            -6.5%    3430070            -2.7%    3571699        aim9.brk_test.ops_per_sec


for
model: Sapphire Rapids
nr_node: 2
nr_cpu: 224
memory: 512G
brand: Intel(R) Xeon(R) Platinum 8480CTDX

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   3540976            -6.4%    3314159            -2.6%    3449384        aim9.brk_test.ops_per_sec


for
model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   2667734            -5.6%    2518021            -1.0%    2640850        aim9.brk_test.ops_per_sec


for
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
which we made the original report

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   1322908            -5.0%    1256536            -1.6%    1301387        aim9.brk_test.ops_per_sec

> 
> Very much appreciated, thanks!
> 
> [0]:https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/
> 
> ----8<----
> From cee7f4196247de0da2b7632838fd36aee8b77e13 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Tue, 15 Oct 2024 20:16:32 +0100
> Subject: [PATCH] mm: add expand-only VMA merge mode and optimise
>  do_brk_flags()
> 
> We know in advance that do_brk_flags() wants only to perform a VMA
> expansion (if the prior VMA is compatible), and that we assume no mergeable
> VMA follows it.
> 
> These are the semantics of this function prior to the recent rewrite of the
> VMA merging logic, however we are now doing more work than necessary -
> positioning the VMA iterator at the prior VMA and performing tasks that are
> not required.
> 
> Add a new field to the vmg struct to permit merge flags and add a new merge
> flag VMG_FLAG_JUST_EXPAND which implies this behaviour, and have
> do_brk_flags() use this.
> 
> This fixes a reported performance regression in a brk() benchmarking suite.
> ---
>  mm/mmap.c |  3 ++-
>  mm/vma.c  | 23 +++++++++++++++--------
>  mm/vma.h  | 16 ++++++++++++++++
>  3 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 02f7b45c3076..b99ba4cac9fe 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1741,7 +1741,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
> 
>  		vmg.prev = vma;
> -		vma_iter_next_range(vmi);
> +		/* vmi is positioned at prev, which this mode expects. */
> +		vmg.merge_flags = VMG_FLAG_JUST_EXPAND;
> 
>  		if (vma_merge_new_range(&vmg))
>  			goto out;
> diff --git a/mm/vma.c b/mm/vma.c
> index 749c4881fd60..69ce9e07ab11 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -562,6 +562,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  	pgoff_t pgoff = vmg->pgoff;
>  	pgoff_t pglen = PHYS_PFN(end - start);
>  	bool can_merge_left, can_merge_right;
> +	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;
> 
>  	mmap_assert_write_locked(vmg->mm);
>  	VM_WARN_ON(vmg->vma);
> @@ -575,7 +576,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  		return NULL;
> 
>  	can_merge_left = can_vma_merge_left(vmg);
> -	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
> +	can_merge_right = !just_expand && can_vma_merge_right(vmg, can_merge_left);
> 
>  	/* If we can merge with the next VMA, adjust vmg accordingly. */
>  	if (can_merge_right) {
> @@ -590,7 +591,11 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  		vmg->vma = prev;
>  		vmg->pgoff = prev->vm_pgoff;
> 
> -		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
> +		/* In expand-only case we are already positioned here. */
> +		if (!just_expand) {
> +			/* Equivalent to going to the previous range. */
> +			vma_prev(vmg->vmi);
> +		}
>  	}
> 
>  	/*
> @@ -604,12 +609,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
>  	}
> 
>  	/* If expansion failed, reset state. Allows us to retry merge later. */
> -	vmg->vma = NULL;
> -	vmg->start = start;
> -	vmg->end = end;
> -	vmg->pgoff = pgoff;
> -	if (vmg->vma == prev)
> -		vma_iter_set(vmg->vmi, start);
> +	if (!just_expand) {
> +		vmg->vma = NULL;
> +		vmg->start = start;
> +		vmg->end = end;
> +		vmg->pgoff = pgoff;
> +		if (vmg->vma == prev)
> +			vma_iter_set(vmg->vmi, start);
> +	}
> 
>  	return NULL;
>  }
> diff --git a/mm/vma.h b/mm/vma.h
> index 82354fe5edd0..8f8548958e41 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -59,6 +59,19 @@ enum vma_merge_state {
>  	VMA_MERGE_SUCCESS,
>  };
> 
> +typedef unsigned long vma_merge_flags_t;
> +
> + /*
> +  * If we can expand, simply do so. We know there is nothing to merge to the
> +  * right.
> +  *
> +  * Does not reset state upon failure to merge.
> +  *
> +  * IMPORTANT: The VMA iterator is assumed to be positioned at the previous VMA,
> +  *            rather than at the gap.
> +  */
> +#define VMG_FLAG_JUST_EXPAND (1 << 0)
> +
>  /* Represents a VMA merge operation. */
>  struct vma_merge_struct {
>  	struct mm_struct *mm;
> @@ -75,6 +88,7 @@ struct vma_merge_struct {
>  	struct mempolicy *policy;
>  	struct vm_userfaultfd_ctx uffd_ctx;
>  	struct anon_vma_name *anon_name;
> +	vma_merge_flags_t merge_flags;
>  	enum vma_merge_state state;
>  };
> 
> @@ -99,6 +113,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
>  		.flags = flags_,					\
>  		.pgoff = pgoff_,					\
>  		.state = VMA_MERGE_START,				\
> +		.merge_flags = 0,					\
>  	}
> 
>  #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
> @@ -118,6 +133,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
>  		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
>  		.anon_name = anon_vma_name(vma_),		\
>  		.state = VMA_MERGE_START,			\
> +		.merge_flags = 0,				\
>  	}
> 
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> --
> 2.46.2

--t1myKVu9sjgSYkoK
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: attachment;
	filename="fc21959f74bc11-cacded5e42b960-9cecc5dc893886"
Content-Transfer-Encoding: 8bit

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-gnr-1ap1/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   3220697            -6.0%    3028867            -2.0%    3156931        aim9.brk_test.ops_per_sec
     24.58            -3.9%      23.63            +0.5%      24.71        time.user_time
    119459            -3.2%     115601            -0.5%     118822        proc-vmstat.nr_active_anon
    120943            -3.2%     117079            -0.5%     120301        proc-vmstat.nr_shmem
    119459            -3.2%     115601            -0.5%     118822        proc-vmstat.nr_zone_active_anon
     26.78 ± 11%      +3.2%      27.63 ± 29%     +36.7%      36.60 ± 20%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     13.45 ± 11%      +4.4%      14.04 ± 30%     +36.7%      18.39 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     13.44 ± 11%      +4.5%      14.04 ± 30%     +36.8%      18.39 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      0.02 ±120%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      3.27 ±  5%   +5112.4%     170.40 ±218%   +5108.0%     170.26 ±218%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.20 ±188%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.02 ±120%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.20 ±188%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
 1.767e+09            +4.2%  1.841e+09            -0.5%  1.757e+09        perf-stat.i.branch-instructions
      0.45            -6.2%       0.42            -1.0%       0.44        perf-stat.i.cpi
 8.347e+09            +6.6%    8.9e+09            +0.9%  8.426e+09        perf-stat.i.instructions
      2.27            +6.6%       2.42            +1.3%       2.30        perf-stat.i.ipc
      0.03 ±  4%      -2.0%       0.03 ±  3%      -5.4%       0.03 ±  2%  perf-stat.overall.MPKI
      0.44            -5.9%       0.42            -1.5%       0.44        perf-stat.overall.cpi
      2.25            +6.2%       2.39            +1.6%       2.29        perf-stat.overall.ipc
 1.761e+09            +4.2%  1.834e+09            -0.5%  1.752e+09        perf-stat.ps.branch-instructions
 8.319e+09            +6.6%   8.87e+09            +1.0%  8.398e+09        perf-stat.ps.instructions
 2.519e+12            +6.4%   2.68e+12            +1.3%  2.552e+12        perf-stat.total.instructions
      7.07            -7.1        0.00            -7.1        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.30            -6.3        0.00            -6.3        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.35            -1.0       17.36            -0.7       17.68        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.40            -0.9       15.47            -0.6       15.83        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
     10.17            -0.8        9.36            -0.4        9.76        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
     11.92            -0.8       11.12            -0.4       11.48        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      5.07 ±  3%      -0.2        4.84 ±  2%      -0.1        4.94        perf-profile.calltrace.cycles-pp.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.40 ±  3%      -0.2        5.18 ±  2%      -0.0        5.35        perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.66 ±  2%      -0.2        3.50 ±  2%      -0.0        3.61 ±  2%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
      1.66 ±  2%      -0.1        1.56 ±  3%      -0.0        1.64 ±  4%  perf-profile.calltrace.cycles-pp.up_write.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.68 ±  3%      -0.1        0.60 ±  5%      -0.1        0.60 ±  8%  perf-profile.calltrace.cycles-pp.kfree.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      5.91 ±  2%      -0.1        5.85            +0.4        6.34        perf-profile.calltrace.cycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      4.23 ±  2%      -0.0        4.21            +0.2        4.47 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.37 ± 70%      +0.3        0.67 ±  4%      +0.3        0.64 ±  5%  perf-profile.calltrace.cycles-pp.strlen.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      0.49 ± 44%      +0.5        1.02 ±  5%      +0.6        1.04 ±  4%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     83.74            +0.5       84.28            +0.1       83.83        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.6        0.60 ±  6%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_next_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.65 ±  7%      +0.7        0.72 ±  7%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +0.7        0.68 ±  4%      +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.7        0.68 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     80.24            +0.7       80.95            +0.1       80.38        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.7        0.74 ±  2%      +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +0.8        0.75 ±  4%      +0.6        0.56 ±  4%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.8        0.81 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.8        0.84 ±  5%      +0.9        0.89 ±  2%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.3        1.30 ±  5%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +1.4        1.35 ±  4%      +2.0        2.03 ±  3%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.6        1.60 ±  4%      +1.7        1.66 ±  3%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.8        1.76 ±  2%      +1.8        1.82 ±  3%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
      0.00            +1.8        1.78 ±  2%      +2.0        1.99 ±  2%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +2.0        2.03            +2.1        2.13 ±  2%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +2.1        2.06 ±  3%      +2.0        2.04 ±  3%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +2.3        2.29 ±  3%      +2.3        2.26 ±  3%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
     53.64            +2.6       56.21            +0.7       54.36        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +3.1        3.14 ±  2%      +3.3        3.27 ±  2%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +3.2        3.25            +3.4        3.43        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +3.8        3.84            +4.1        4.05 ±  2%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +5.3        5.31 ±  2%      +5.6        5.56        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +6.1        6.07            +6.2        6.24 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00           +27.7       27.74           +29.5       29.50        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00           +32.4       32.43           +31.6       31.64        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.49            -1.0       17.47            -0.7       17.81        perf-profile.children.cycles-pp.perf_event_mmap
      6.54            -1.0        5.54 ±  2%      -0.7        5.82        perf-profile.children.cycles-pp.mas_preallocate
      7.40            -1.0        6.40 ±  2%      -0.8        6.56        perf-profile.children.cycles-pp.mas_store_prealloc
      5.68            -1.0        4.72            -0.1        5.54 ±  2%  perf-profile.children.cycles-pp.up_write
     16.88            -0.9       15.93            -0.6       16.27        perf-profile.children.cycles-pp.perf_event_mmap_event
     10.35            -0.8        9.53            -0.4        9.92        perf-profile.children.cycles-pp.perf_event_mmap_output
     12.16            -0.8       11.35            -0.4       11.73        perf-profile.children.cycles-pp.perf_iterate_sb
      4.02 ±  2%      -0.7        3.32            -0.5        3.50        perf-profile.children.cycles-pp.mas_wr_store_type
      2.97            -0.6        2.37 ±  3%      -0.6        2.35 ±  3%  perf-profile.children.cycles-pp.mas_update_gap
      1.36 ±  8%      -0.6        0.80 ±  4%      -0.8        0.61 ±  5%  perf-profile.children.cycles-pp.can_vma_merge_after
      2.26 ±  2%      -0.5        1.80 ±  2%      -0.4        1.87 ±  3%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      3.71 ±  2%      -0.3        3.44            -0.1        3.58 ±  2%  perf-profile.children.cycles-pp.vma_complete
      5.62 ±  3%      -0.2        5.40 ±  2%      -0.1        5.57        perf-profile.children.cycles-pp.check_brk_limits
      3.83 ±  2%      -0.2        3.65 ±  2%      -0.0        3.78 ±  2%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      0.66 ±  7%      -0.1        0.55 ±  9%      -0.1        0.53 ±  6%  perf-profile.children.cycles-pp.may_expand_vm
      0.78 ±  3%      -0.1        0.69 ±  4%      -0.1        0.70 ±  6%  perf-profile.children.cycles-pp.kfree
      0.15 ± 12%      -0.1        0.08 ± 13%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.arch_vma_name
      6.23 ±  2%      -0.1        6.17            +0.4        6.65        perf-profile.children.cycles-pp.mas_find
      4.32 ±  2%      -0.0        4.30            +0.2        4.56 ±  2%  perf-profile.children.cycles-pp.mas_walk
      0.23 ±  7%      +0.0        0.24 ± 18%      +0.0        0.26 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24 ±  7%      +0.0        0.24 ± 18%      +0.0        0.27 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.81 ±  6%      +0.0        0.83 ±  3%      +0.1        0.91 ±  4%  perf-profile.children.cycles-pp.vma_adjust_trans_huge
      0.54 ±  5%      +0.0        0.58 ± 12%      +0.1        0.59 ±  4%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.57 ±  4%      +0.0        0.62 ± 12%      +0.1        0.63 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.58 ±  7%      +0.1        0.66 ±  7%      +0.1        0.73 ±  7%  perf-profile.children.cycles-pp.mas_wr_slot_store
      0.19 ± 10%      +0.1        0.31 ± 10%      +0.1        0.32 ± 10%  perf-profile.children.cycles-pp.rb_next
      0.50 ±  4%      +0.1        0.62 ±  7%      +0.1        0.61 ±  9%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.40 ±  6%      +0.1        0.53 ±  6%      +0.1        0.47 ± 10%  perf-profile.children.cycles-pp.strnlen
      0.58 ± 13%      +0.2        0.75 ±  4%      +0.1        0.72 ±  5%  perf-profile.children.cycles-pp.strlen
      0.96 ±  6%      +0.2        1.14 ±  3%      +0.2        1.20 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.68 ±  3%      +0.3        0.98 ±  5%      +0.4        1.05 ±  3%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      1.77 ±  4%      +0.3        2.09            +0.4        2.14 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.4        0.36 ±  9%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_setup
      0.36 ±  8%      +0.4        0.76 ±  3%      +0.4        0.78 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.48 ±  7%      +0.4        0.90 ±  6%      -0.0        0.47 ±  7%  perf-profile.children.cycles-pp.mas_prev_setup
      0.67 ±  9%      +0.6        1.24 ±  4%      +0.6        1.29 ±  3%  perf-profile.children.cycles-pp.__vm_enough_memory
      3.81            +0.6        4.39            +0.7        4.48        perf-profile.children.cycles-pp.down_write
     80.98            +0.7       81.64            +0.1       81.13        perf-profile.children.cycles-pp.__do_sys_brk
      1.05 ±  4%      +0.7        1.72 ±  3%      -0.0        1.00 ±  4%  perf-profile.children.cycles-pp.mas_next_slot
      0.00            +0.7        0.70 ±  6%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_range
      1.11 ±  4%      +1.0        2.10 ±  3%      -0.0        1.11 ±  4%  perf-profile.children.cycles-pp.mas_prev
      2.82 ±  3%      +1.2        4.07            +1.5        4.30 ±  2%  perf-profile.children.cycles-pp.vma_prepare
      1.54 ±  4%      +1.3        2.88 ±  3%      -0.0        1.53 ±  6%  perf-profile.children.cycles-pp.mas_prev_slot
     54.97            +1.6       56.61            -0.2       54.72        perf-profile.children.cycles-pp.do_brk_flags
      0.00           +28.6       28.64           +30.4       30.44        perf-profile.children.cycles-pp.vma_expand
      0.00           +32.9       32.91           +32.0       31.95        perf-profile.children.cycles-pp.vma_merge_new_range
      5.90 ±  2%      -3.5        2.37 ±  4%      -3.5        2.44 ±  3%  perf-profile.self.cycles-pp.do_brk_flags
      5.36 ±  2%      -1.0        4.38            -0.1        5.21 ±  2%  perf-profile.self.cycles-pp.up_write
     10.18            -0.8        9.36            -0.4        9.74        perf-profile.self.cycles-pp.perf_event_mmap_output
      3.86 ±  2%      -0.7        3.18            -0.5        3.33        perf-profile.self.cycles-pp.mas_wr_store_type
      1.28 ±  7%      -0.5        0.74 ±  4%      -0.7        0.55 ±  7%  perf-profile.self.cycles-pp.can_vma_merge_after
      3.02 ±  2%      -0.5        2.52 ±  4%      -0.4        2.57 ±  2%  perf-profile.self.cycles-pp.mas_store_prealloc
      2.19 ±  2%      -0.4        1.78 ±  2%      -0.4        1.82 ±  3%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      5.03            -0.4        4.67            +0.1        5.09        perf-profile.self.cycles-pp.__do_sys_brk
      2.60 ±  4%      -0.3        2.27 ±  5%      -0.2        2.40 ±  2%  perf-profile.self.cycles-pp.mas_preallocate
      1.89 ±  4%      -0.3        1.59 ±  4%      -0.3        1.55 ±  5%  perf-profile.self.cycles-pp.perf_event_mmap_event
      1.71 ±  4%      -0.2        1.53 ±  3%      -0.1        1.59 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.74 ±  3%      -0.2        0.57 ±  7%      -0.2        0.52 ±  6%  perf-profile.self.cycles-pp.mas_update_gap
      1.89 ±  4%      -0.2        1.73 ±  2%      +0.0        1.90        perf-profile.self.cycles-pp.init_multi_vma_prep
      1.58 ±  4%      -0.1        1.47 ±  3%      -0.1        1.50 ±  5%  perf-profile.self.cycles-pp.perf_event_mmap
      1.27 ±  2%      -0.1        1.16 ±  2%      -0.1        1.22 ±  4%  perf-profile.self.cycles-pp.vma_complete
      0.69 ±  2%      -0.1        0.61 ±  4%      -0.1        0.61 ±  7%  perf-profile.self.cycles-pp.kfree
      4.24 ±  2%      -0.0        4.20            +0.2        4.48 ±  2%  perf-profile.self.cycles-pp.mas_walk
      1.02            +0.0        1.05 ±  4%      +0.2        1.21 ±  4%  perf-profile.self.cycles-pp.mas_find
      0.55 ±  7%      +0.0        0.59 ±  8%      +0.1        0.65 ±  6%  perf-profile.self.cycles-pp.mas_wr_slot_store
      0.18 ± 16%      +0.0        0.23 ± 14%      +0.1        0.24 ±  5%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.15 ± 10%      +0.1        0.24 ± 11%      +0.1        0.23 ± 10%  perf-profile.self.cycles-pp.rb_next
      0.58 ±  8%      +0.1        0.68 ±  5%      +0.2        0.74 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.37 ±  5%      +0.1        0.50 ±  7%      +0.1        0.45 ± 10%  perf-profile.self.cycles-pp.strnlen
      0.54 ± 13%      +0.2        0.68 ±  4%      +0.1        0.66 ±  6%  perf-profile.self.cycles-pp.strlen
      1.01 ±  6%      +0.2        1.17 ±  2%      +0.2        1.17 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.66 ±  6%      +0.2        0.83 ±  2%      +0.2        0.87 ±  5%  perf-profile.self.cycles-pp.vma_prepare
      0.46 ±  6%      +0.2        0.67 ±  7%      +0.3        0.74 ±  5%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.34 ± 12%      +0.2        0.54 ±  3%      +0.2        0.58 ±  6%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.00            +0.3        0.29 ± 10%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_setup
      0.32 ± 11%      +0.3        0.62 ±  7%      +0.0        0.32 ±  5%  perf-profile.self.cycles-pp.mas_prev_setup
      0.23 ±  7%      +0.3        0.55 ±  6%      +0.3        0.55 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.00            +0.4        0.35 ±  7%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_range
      2.65 ±  3%      +0.4        3.00 ±  2%      +0.4        3.07        perf-profile.self.cycles-pp.down_write
      0.64 ±  5%      +0.6        1.21 ±  3%      -0.0        0.62 ±  5%  perf-profile.self.cycles-pp.mas_prev
      0.89 ±  5%      +0.7        1.54 ±  3%      -0.0        0.85 ±  5%  perf-profile.self.cycles-pp.mas_next_slot
      1.46 ±  4%      +1.3        2.72 ±  3%      -0.0        1.45 ±  6%  perf-profile.self.cycles-pp.mas_prev_slot
      0.00            +1.3        1.33 ±  2%      +0.9        0.86 ±  4%  perf-profile.self.cycles-pp.vma_merge_new_range
      0.00            +3.5        3.54 ±  3%      +3.7        3.73        perf-profile.self.cycles-pp.vma_expand

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-emr-2sp1/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")
  
fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   3669298            -6.5%    3430070            -2.7%    3571699        aim9.brk_test.ops_per_sec
     23.53            -4.9%      22.38            -2.0%      23.06        time.user_time
    491107 ±  5%      -7.2%     455906 ±  6%      -5.1%     466069 ±  4%  meminfo.Active
    491011 ±  5%      -7.2%     455810 ±  6%      -5.1%     465957 ±  4%  meminfo.Active(anon)
    505666 ±  5%      -7.0%     470410 ±  5%      -5.0%     480514 ±  4%  meminfo.Shmem
     10118 ± 40%     -61.8%       3861 ± 40%     -24.4%       7653 ± 61%  numa-vmstat.node1.nr_slab_reclaimable
    121015 ±  6%      -7.3%     112196 ±  6%     -18.6%      98460 ± 20%  numa-vmstat.node3.nr_active_anon
    121371 ±  6%      -7.3%     112537 ±  6%     -18.6%      98831 ± 20%  numa-vmstat.node3.nr_shmem
    121015 ±  6%      -7.3%     112196 ±  6%     -18.6%      98460 ± 20%  numa-vmstat.node3.nr_zone_active_anon
     40474 ± 40%     -61.8%      15444 ± 40%     -24.4%      30612 ± 61%  numa-meminfo.node1.KReclaimable
     40474 ± 40%     -61.8%      15444 ± 40%     -24.4%      30612 ± 61%  numa-meminfo.node1.SReclaimable
    484115 ±  6%      -7.3%     448760 ±  6%     -18.7%     393817 ± 20%  numa-meminfo.node3.Active
    484083 ±  6%      -7.3%     448760 ±  6%     -18.7%     393798 ± 20%  numa-meminfo.node3.Active(anon)
    485577 ±  6%      -7.3%     450224 ±  6%     -18.6%     395333 ± 20%  numa-meminfo.node3.Shmem
    122753 ±  5%      -7.1%     113979 ±  6%      -5.1%     116468 ±  4%  proc-vmstat.nr_active_anon
    899298            -1.0%     890515            -0.7%     892993        proc-vmstat.nr_file_pages
    126417 ±  5%      -6.9%     117634 ±  5%      -5.0%     120109 ±  4%  proc-vmstat.nr_shmem
    122753 ±  5%      -7.1%     113979 ±  6%      -5.1%     116468 ±  4%  proc-vmstat.nr_zone_active_anon
    595.50 ± 22%     +53.6%     914.50 ± 12%     +34.1%     798.50 ± 37%  proc-vmstat.numa_hint_faults_local
     17958            -4.3%      17188 ±  2%      -5.1%      17041 ±  2%  proc-vmstat.pgactivate
      0.01 ± 52%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.01 ± 15%      +7.0%       0.01 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 69%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.01 ± 17%      -3.8%       0.01 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    400.06            +0.0%     400.07          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     10.00            +0.0%      10.00          -100.0%       0.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
    999.53            -0.0%     999.38          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 52%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
    400.05            +0.0%     400.06          -100.0%       0.00        perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 69%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
    999.52            -0.0%     999.37          -100.0%       0.00        perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
 2.071e+09            +2.8%  2.128e+09            -1.5%   2.04e+09        perf-stat.i.branch-instructions
      0.48            -4.2%       0.46            +1.4%       0.48 ±  2%  perf-stat.i.cpi
 4.717e+09            -0.7%  4.686e+09            -0.9%  4.676e+09        perf-stat.i.cpu-cycles
 9.794e+09            +5.1%   1.03e+10            -0.1%  9.787e+09        perf-stat.i.instructions
      2.15            +5.8%       2.28            +0.5%       2.16        perf-stat.i.ipc
      0.34 ±  3%      -0.0        0.33            -0.0        0.33 ±  3%  perf-stat.overall.branch-miss-rate%
      0.48            -5.5%       0.46            -0.8%       0.48        perf-stat.overall.cpi
      2.08            +5.8%       2.20            +0.8%       2.09        perf-stat.overall.ipc
 2.063e+09            +2.8%   2.12e+09            -1.5%  2.032e+09        perf-stat.ps.branch-instructions
 4.703e+09            -0.7%  4.672e+09            -0.9%  4.662e+09        perf-stat.ps.cpu-cycles
 9.758e+09            +5.1%  1.026e+10            -0.1%  9.751e+09        perf-stat.ps.instructions
 2.944e+12            +5.5%  3.106e+12            +0.4%  2.957e+12        perf-stat.total.instructions
      6.54 ±  2%      -6.5        0.00            -6.5        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.22            -6.2        0.00            -6.2        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.69 ±  2%      -0.6        9.07            +0.3       10.01        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
     11.30 ±  2%      -0.6       10.71            +0.5       11.80        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
     15.57            -0.5       15.05            +0.6       16.16        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
      3.61 ±  5%      -0.2        3.38 ±  4%      -0.3        3.33 ±  3%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
      2.76            -0.1        2.62 ±  3%      -0.1        2.67 ±  2%  perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.58 ±  3%      -0.1        0.44 ± 44%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.brk
      0.84 ±  4%      -0.1        0.74 ±  8%      -0.1        0.75 ±  4%  perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.12 ±  5%      +0.2        1.29 ±  3%      +0.1        1.27 ±  3%  perf-profile.calltrace.cycles-pp.sized_strscpy.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      0.65 ±  6%      +0.4        1.07 ±  5%      +0.5        1.11 ±  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.54 ±  4%      +0.6        0.56 ±  6%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +0.5        0.55 ±  4%      +0.2        0.18 ±141%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +0.7        0.66 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.68 ±  9%      +0.7        0.68 ±  4%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.7        0.68 ±  4%      +0.7        0.66 ±  3%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.8        0.76 ±  2%      +0.8        0.76 ±  3%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +0.8        0.80 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.8        0.82 ±  3%      +0.9        0.88 ±  4%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
     77.52            +1.0       78.50            +0.7       78.17        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +1.3        1.26 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +1.3        1.35 ±  3%      +1.9        1.89 ±  2%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.6        1.56 ±  2%      +1.6        1.59 ±  3%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.7        1.72 ±  3%      +1.8        1.85 ±  3%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.9        1.87 ±  4%      +2.1        2.08 ±  3%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
      0.00            +2.1        2.07 ±  2%      +2.1        2.08 ±  5%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +2.1        2.14 ±  2%      +2.1        2.12 ±  2%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +2.4        2.37 ±  2%      +2.7        2.72 ±  2%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
     51.80            +2.9       54.66            +2.0       53.75        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +3.0        3.02 ±  2%      +2.9        2.90 ±  3%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +3.1        3.06            +3.1        3.10 ±  2%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +3.9        3.86            +3.9        3.92 ±  2%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +5.0        5.01            +4.9        4.88        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +5.9        5.88            +6.3        6.35        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00           +27.1       27.13           +28.6       28.60        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00           +31.6       31.63           +30.9       30.88        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.46            -1.2        5.24            -1.4        5.11        perf-profile.children.cycles-pp.mas_preallocate
      5.54            -0.9        4.64            -0.3        5.27 ±  2%  perf-profile.children.cycles-pp.up_write
      3.99            -0.9        3.10 ±  2%      -1.0        2.98 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_type
      9.85 ±  2%      -0.6        9.22            +0.3       10.18        perf-profile.children.cycles-pp.perf_event_mmap_output
      6.82 ±  2%      -0.6        6.22            -0.1        6.70        perf-profile.children.cycles-pp.mas_store_prealloc
      1.33 ±  5%      -0.6        0.75 ±  4%      -0.6        0.73 ±  4%  perf-profile.children.cycles-pp.can_vma_merge_after
     11.53 ±  2%      -0.6       10.96            +0.5       12.04        perf-profile.children.cycles-pp.perf_iterate_sb
     16.03            -0.5       15.50            +0.6       16.61        perf-profile.children.cycles-pp.perf_event_mmap_event
      2.65 ±  3%      -0.2        2.40 ±  3%      +0.2        2.82 ±  2%  perf-profile.children.cycles-pp.mas_update_gap
      2.18 ±  2%      -0.2        1.94 ±  3%      -0.0        2.15 ±  2%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      3.72 ±  6%      -0.2        3.48 ±  4%      -0.3        3.44 ±  4%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      3.52            -0.1        3.38 ±  2%      -0.1        3.41 ±  2%  perf-profile.children.cycles-pp.vma_complete
      0.62 ±  7%      -0.1        0.48 ±  9%      -0.1        0.53 ±  3%  perf-profile.children.cycles-pp.may_expand_vm
      1.92 ±  2%      -0.1        1.79 ±  3%      -0.0        1.92 ±  4%  perf-profile.children.cycles-pp.init_multi_vma_prep
      0.40 ±  6%      -0.1        0.35 ±  9%      -0.0        0.40 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.35 ±  2%      -0.0        0.33 ±  7%      -0.1        0.29 ±  9%  perf-profile.children.cycles-pp.brk_test
      0.07 ± 18%      -0.0        0.06 ± 45%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.elf_load
      0.18 ±  7%      -0.0        0.17 ± 23%      +0.1        0.28 ± 10%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.44 ±  4%      -0.0        0.44 ±  5%      +0.0        0.46 ±  2%  perf-profile.children.cycles-pp.mas_destroy
      0.11 ± 20%      +0.0        0.14 ±  8%      +0.0        0.14 ± 11%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      0.52 ±  3%      +0.0        0.56 ±  4%      +0.1        0.60 ±  5%  perf-profile.children.cycles-pp.mas_wr_slot_store
      0.20 ± 11%      +0.1        0.28 ±  7%      +0.1        0.32 ±  9%  perf-profile.children.cycles-pp.rb_next
      0.49 ±  3%      +0.1        0.61 ±  4%      +0.1        0.57 ±  5%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.98 ±  4%      +0.1        1.11 ±  3%      +0.2        1.13 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.39 ±  7%      +0.2        0.55 ±  7%      +0.1        0.53 ±  5%  perf-profile.children.cycles-pp.strnlen
      1.18 ±  5%      +0.2        1.37 ±  3%      +0.2        1.34 ±  3%  perf-profile.children.cycles-pp.sized_strscpy
      1.78 ±  3%      +0.3        2.04 ±  2%      +0.3        2.06 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.3        0.33 ±  4%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_setup
      0.41 ±  9%      +0.4        0.76 ±  7%      +0.4        0.77 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.58 ±  4%      +0.4        0.96 ±  2%      +0.5        1.04 ±  3%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.44 ± 17%      +0.4        0.85 ±  7%      -0.0        0.42 ±  4%  perf-profile.children.cycles-pp.mas_prev_setup
      4.11 ±  2%      +0.4        4.52            +0.4        4.52 ±  2%  perf-profile.children.cycles-pp.down_write
      0.74 ±  6%      +0.6        1.29 ±  5%      +0.6        1.35 ±  3%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.00            +0.7        0.67 ±  6%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_range
      0.95 ±  5%      +0.7        1.64 ±  2%      +0.0        0.98 ±  3%  perf-profile.children.cycles-pp.mas_next_slot
     78.23            +0.9       79.17            +0.6       78.84        perf-profile.children.cycles-pp.__do_sys_brk
      1.02 ± 14%      +1.0        1.99 ±  4%      -0.0        1.01 ±  3%  perf-profile.children.cycles-pp.mas_prev
      2.89 ±  3%      +1.2        4.10            +1.2        4.14 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      1.38 ± 12%      +1.3        2.73 ±  4%      +0.1        1.48 ±  4%  perf-profile.children.cycles-pp.mas_prev_slot
     53.08            +1.9       55.03            +1.0       54.10        perf-profile.children.cycles-pp.do_brk_flags
      0.00           +28.0       27.95           +29.5       29.47        perf-profile.children.cycles-pp.vma_expand
      0.00           +32.1       32.10           +31.2       31.24        perf-profile.children.cycles-pp.vma_merge_new_range
      5.69            -3.4        2.34 ±  3%      -3.4        2.34 ±  2%  perf-profile.self.cycles-pp.do_brk_flags
      5.22            -0.9        4.33 ±  2%      -0.3        4.95 ±  3%  perf-profile.self.cycles-pp.up_write
      3.82            -0.9        2.95 ±  3%      -1.0        2.83 ±  3%  perf-profile.self.cycles-pp.mas_wr_store_type
      9.68 ±  2%      -0.6        9.05            +0.3       10.00        perf-profile.self.cycles-pp.perf_event_mmap_output
      1.28 ±  5%      -0.6        0.69 ±  6%      -0.6        0.67 ±  4%  perf-profile.self.cycles-pp.can_vma_merge_after
      2.88 ±  3%      -0.4        2.44 ±  2%      -0.4        2.49        perf-profile.self.cycles-pp.mas_store_prealloc
      2.55            -0.3        2.22 ±  2%      -0.4        2.19 ±  3%  perf-profile.self.cycles-pp.mas_preallocate
      4.98 ±  2%      -0.3        4.70            -0.3        4.71        perf-profile.self.cycles-pp.__do_sys_brk
      2.15 ±  3%      -0.2        1.93 ±  3%      -0.0        2.12 ±  2%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      1.82            -0.2        1.60 ±  4%      -0.1        1.67 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_event
      1.51 ±  4%      -0.2        1.31 ±  4%      -0.2        1.35 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap
      1.85 ±  2%      -0.2        1.66 ±  3%      -0.1        1.77 ±  4%  perf-profile.self.cycles-pp.init_multi_vma_prep
      2.38 ±  7%      -0.2        2.20 ±  5%      -0.2        2.17 ±  3%  perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      5.65 ±  2%      -0.1        5.50            -0.3        5.40 ±  2%  perf-profile.self.cycles-pp.brk
      2.77            -0.1        2.63 ±  3%      -0.1        2.67 ±  2%  perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.75 ±  5%      -0.1        0.67 ±  4%      -0.1        0.66 ±  2%  perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.28 ±  5%      -0.0        0.26 ±  8%      -0.1        0.22 ± 11%  perf-profile.self.cycles-pp.brk_test
      0.45 ±  7%      -0.0        0.45 ±  8%      +0.2        0.66 ±  5%  perf-profile.self.cycles-pp.mas_update_gap
      0.11 ± 12%      +0.0        0.11 ± 21%      +0.0        0.15 ± 10%  perf-profile.self.cycles-pp.khugepaged_enter_vma
      0.62 ±  4%      +0.0        0.65 ±  5%      +0.1        0.70 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.03 ± 70%      +0.0        0.07 ± 14%      +0.0        0.07 ± 12%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      1.77 ±  4%      +0.1        1.82 ±  3%      +0.2        1.93 ±  3%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.15 ± 12%      +0.1        0.20 ±  5%      +0.1        0.24 ± 10%  perf-profile.self.cycles-pp.rb_next
      0.40 ±  5%      +0.1        0.48 ±  5%      +0.0        0.45 ±  5%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.34 ±  6%      +0.2        0.50 ±  8%      +0.1        0.48 ±  4%  perf-profile.self.cycles-pp.strnlen
      0.66 ±  4%      +0.2        0.84 ±  5%      +0.1        0.79 ±  6%  perf-profile.self.cycles-pp.vma_prepare
      1.12 ±  5%      +0.2        1.30 ±  3%      +0.2        1.28 ±  3%  perf-profile.self.cycles-pp.sized_strscpy
      3.00 ±  2%      +0.2        3.19 ±  2%      +0.2        3.20 ±  3%  perf-profile.self.cycles-pp.down_write
      0.92 ±  4%      +0.2        1.13 ±  2%      +0.2        1.08 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.3        0.26 ±  7%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_setup
      0.28 ±  8%      +0.3        0.54 ±  8%      +0.2        0.53 ±  5%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.29 ± 12%      +0.3        0.58 ±  9%      +0.4        0.66 ±  4%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.29 ± 24%      +0.3        0.58 ±  7%      -0.0        0.28 ±  8%  perf-profile.self.cycles-pp.mas_prev_setup
      0.40 ±  4%      +0.3        0.70 ±  2%      +0.3        0.74 ±  4%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.00            +0.4        0.36 ±  6%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_range
      0.58 ± 14%      +0.5        1.12 ±  5%      +0.0        0.59 ±  4%  perf-profile.self.cycles-pp.mas_prev
      0.81 ±  4%      +0.7        1.48 ±  3%      +0.0        0.83 ±  3%  perf-profile.self.cycles-pp.mas_next_slot
      1.32 ± 11%      +1.3        2.59 ±  3%      +0.1        1.40 ±  5%  perf-profile.self.cycles-pp.mas_prev_slot
      0.00            +1.3        1.30 ±  4%      +1.0        1.03 ±  6%  perf-profile.self.cycles-pp.vma_merge_new_range
      0.00            +3.4        3.39            +3.9        3.88 ±  2%  perf-profile.self.cycles-pp.vma_expand

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   3540976            -6.4%    3314159            -2.6%    3449384        aim9.brk_test.ops_per_sec
     23.65            -5.8%      22.28            -3.4%      22.84        time.user_time
   1046452 ±  3%      +4.2%    1090314           +26.9%    1327644 ± 24%  sched_debug.cpu.avg_idle.max
    535529 ±  5%      +3.1%     552160 ±  2%     +30.0%     696343 ± 30%  sched_debug.cpu.max_idle_balance_cost.max
    111409 ±  2%      -5.1%     105748 ±  3%      -3.4%     107624        proc-vmstat.nr_active_anon
    114711 ±  2%      -5.0%     109006 ±  3%      -3.3%     110946        proc-vmstat.nr_shmem
    111409 ±  2%      -5.1%     105748 ±  3%      -3.4%     107624        proc-vmstat.nr_zone_active_anon
     17422 ±  2%      -5.3%      16494            -0.4%      17353        proc-vmstat.pgactivate
 1.999e+09            +3.2%  2.064e+09            -1.3%  1.972e+09        perf-stat.i.branch-instructions
   6526528 ±  3%      -1.2%    6446015            -7.6%    6028010 ±  4%  perf-stat.i.branch-misses
      0.47            -5.1%       0.44            -0.1%       0.47        perf-stat.i.cpi
 9.452e+09            +5.6%  9.983e+09            +0.1%  9.461e+09        perf-stat.i.instructions
      2.19            +5.8%       2.31            +0.7%       2.20        perf-stat.i.ipc
      0.33 ±  3%      -0.0        0.31            -0.0        0.30 ±  4%  perf-stat.overall.branch-miss-rate%
      0.47            -5.1%       0.45            -0.8%       0.47        perf-stat.overall.cpi
      2.12            +5.4%       2.23            +0.8%       2.13        perf-stat.overall.ipc
 1.991e+09            +3.2%  2.056e+09            -1.3%  1.964e+09        perf-stat.ps.branch-instructions
   6486215 ±  3%      -1.2%    6410482            -7.7%    5987617 ±  4%  perf-stat.ps.branch-misses
 9.417e+09            +5.6%  9.946e+09            +0.1%  9.426e+09        perf-stat.ps.instructions
 2.841e+12            +5.7%  3.002e+12            +0.4%  2.852e+12        perf-stat.total.instructions
      0.01 ± 42%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.02 ± 37%     -68.5%       0.01 ± 44%     -32.3%       0.01 ± 82%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ± 56%     -30.8%       0.04 ±105%     +79.5%       0.11 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.04 ± 66%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.05 ± 47%     -75.3%       0.01 ± 83%     -34.8%       0.03 ± 93%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ± 45%     -38.0%       0.05 ± 98%     +56.1%       0.13 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ±  9%     +33.8%       0.02 ± 18%     +11.2%       0.01 ±  9%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.08 ± 57%     -69.7%       0.02 ±146%     -86.4%       0.01 ± 67%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.10 ± 37%     +45.2%       0.15 ±  8%      -3.3%       0.10 ± 21%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7209 ±  3%      -7.8%       6648 ±  2%      -2.4%       7039 ±  2%  perf-sched.total_wait_and_delay.count.ms
      1533 ±  6%     -10.2%       1377            -5.1%       1454 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 42%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.02 ± 37%     -68.5%       0.01 ± 44%     -32.3%       0.01 ± 82%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.04 ± 66%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.05 ± 47%     -75.3%       0.01 ± 83%     -34.8%       0.03 ± 93%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.61            -6.6        0.00            -6.6        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.20            -6.2        0.00            -6.2        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.96            -1.1       16.87            -0.1       17.84        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.08            -1.0       15.10            +0.0       16.08        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
      9.85            -0.8        9.02            +0.1        9.94        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
     11.56            -0.8       10.73            +0.2       11.80 ±  2%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      3.57 ±  2%      -0.1        3.43 ±  3%      -0.1        3.46        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
      2.35 ±  3%      -0.1        2.22 ±  3%      -0.2        2.16 ±  2%  perf-profile.calltrace.cycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     10.59 ±  2%      -0.1       10.48            -0.4       10.15 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.brk
      0.58 ±  4%      -0.1        0.48 ± 45%      -0.1        0.44 ± 44%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      5.67 ±  2%      -0.0        5.66 ±  4%      +0.4        6.02 ±  2%  perf-profile.calltrace.cycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.93 ±  4%      +0.1        4.00 ±  4%      +0.2        4.12        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ±  4%      +0.4        1.06 ±  2%      +0.5        1.10 ±  3%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.56 ±  5%      +0.6        0.58 ±  4%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +0.6        0.57 ±  6%      +0.6        0.60 ±  8%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +0.6        0.58 ±  7%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_next_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.69 ±  4%      +0.7        0.69 ±  6%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.7        0.70 ±  6%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.73 ±  8%      +0.8        0.77 ±  5%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +0.7        0.74 ±  5%      +0.8        0.79 ±  6%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.8        0.84 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +0.9        0.88 ±  5%      +0.9        0.89 ±  3%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
     78.92            +0.9       79.81            +0.6       79.50        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +1.3        1.28 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +1.4        1.42 ±  3%      +1.9        1.88 ±  3%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.6        1.59 ±  4%      +1.6        1.62 ±  3%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.8        1.80 ±  4%      +1.8        1.83 ±  4%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.9        1.89 ±  4%      +2.1        2.10 ±  2%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
      0.00            +2.1        2.06 ±  3%      +2.1        2.13        perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +2.1        2.12 ±  2%      +2.2        2.22 ±  3%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +2.4        2.43 ±  4%      +2.7        2.70 ±  2%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
     52.76            +2.6       55.40            +1.8       54.61        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +3.0        2.98            +3.0        2.95        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +3.1        3.11 ±  3%      +3.1        3.13 ±  2%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +3.9        3.90 ±  2%      +4.0        4.00        perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +5.0        4.96            +5.0        4.97        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +6.0        6.04 ±  2%      +6.4        6.44        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00           +27.5       27.47           +29.1       29.12        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00           +32.1       32.09           +31.7       31.72        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.44            -1.2        5.20            -1.2        5.20        perf-profile.children.cycles-pp.mas_preallocate
     18.11            -1.1       16.99            -0.1       17.98        perf-profile.children.cycles-pp.perf_event_mmap
      4.01 ±  2%      -1.0        3.06            -1.0        3.03        perf-profile.children.cycles-pp.mas_wr_store_type
     16.54            -0.9       15.60            +0.0       16.55        perf-profile.children.cycles-pp.perf_event_mmap_event
     10.02            -0.8        9.18            +0.1       10.10        perf-profile.children.cycles-pp.perf_event_mmap_output
      5.61            -0.8        4.77            -0.3        5.32 ±  2%  perf-profile.children.cycles-pp.up_write
     11.80            -0.8       10.97            +0.2       12.02 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      1.39            -0.6        0.81 ±  3%      -0.5        0.86 ±  5%  perf-profile.children.cycles-pp.can_vma_merge_after
      6.89            -0.5        6.38            -0.1        6.79        perf-profile.children.cycles-pp.mas_store_prealloc
      3.67 ±  2%      -0.3        3.41 ±  3%      -0.2        3.44 ±  2%  perf-profile.children.cycles-pp.vma_complete
      2.20 ±  4%      -0.2        1.97 ±  3%      -0.0        2.16 ±  2%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      2.68 ±  3%      -0.2        2.47 ±  3%      +0.1        2.78 ±  2%  perf-profile.children.cycles-pp.mas_update_gap
      2.51 ±  3%      -0.1        2.36 ±  3%      -0.2        2.32 ±  2%  perf-profile.children.cycles-pp.down_write_killable
      0.61 ±  5%      -0.1        0.49 ±  7%      -0.1        0.51 ±  8%  perf-profile.children.cycles-pp.may_expand_vm
      1.25 ±  4%      -0.1        1.14 ±  5%      -0.1        1.18 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.14 ± 11%      -0.1        0.08 ± 12%      -0.1        0.05 ± 46%  perf-profile.children.cycles-pp.arch_vma_name
      0.42            -0.1        0.36 ±  4%      -0.0        0.41 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.36 ±  6%      -0.1        0.31 ±  4%      -0.1        0.30 ±  9%  perf-profile.children.cycles-pp.brk_test
      0.25 ±  5%      -0.0        0.21 ±  9%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.41 ±  6%      -0.0        0.38 ±  5%      -0.0        0.36 ±  8%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.61 ±  4%      -0.0        0.59 ±  3%      -0.0        0.57 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      5.98 ±  2%      -0.0        5.97 ±  4%      +0.4        6.34 ±  2%  perf-profile.children.cycles-pp.mas_find
      0.18 ± 18%      -0.0        0.17 ± 13%      +0.1        0.25 ±  6%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.14 ±  3%      -0.0        0.14 ±  7%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.intel_idle
      0.08 ± 10%      +0.0        0.12 ± 16%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.mmap_region
      0.09 ±  8%      +0.0        0.12 ± 15%      +0.0        0.11 ± 10%  perf-profile.children.cycles-pp.do_mmap
      0.10 ± 14%      +0.0        0.15 ± 11%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.anon_vma_interval_tree_remove
      4.02 ±  4%      +0.1        4.08 ±  4%      +0.2        4.20        perf-profile.children.cycles-pp.mas_walk
      1.01 ±  5%      +0.1        1.08 ±  5%      +0.1        1.12 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.19 ±  5%      +0.1        0.30 ±  5%      +0.1        0.31 ±  6%  perf-profile.children.cycles-pp.rb_next
      1.27 ±  4%      +0.1        1.40 ±  2%      +0.0        1.31 ±  4%  perf-profile.children.cycles-pp.sized_strscpy
      0.42 ±  6%      +0.1        0.57 ±  6%      +0.1        0.54 ±  7%  perf-profile.children.cycles-pp.strnlen
      0.48 ±  4%      +0.2        0.64 ±  5%      +0.2        0.65 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_entry
      1.80 ±  4%      +0.2        2.02 ±  2%      +0.3        2.09        perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.3        0.31 ± 12%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_setup
      4.16 ±  3%      +0.3        4.48            +0.5        4.68        perf-profile.children.cycles-pp.down_write
      0.40 ±  6%      +0.4        0.78 ±  4%      +0.4        0.77 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.48 ±  4%      +0.4        0.92 ±  5%      -0.0        0.44 ±  9%  perf-profile.children.cycles-pp.mas_prev_setup
      0.56 ±  6%      +0.5        1.02 ±  4%      +0.5        1.04 ±  3%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.79 ±  4%      +0.5        1.30 ±  3%      +0.5        1.32 ±  3%  perf-profile.children.cycles-pp.__vm_enough_memory
      1.02 ±  2%      +0.7        1.72 ±  3%      -0.0        0.98 ±  2%  perf-profile.children.cycles-pp.mas_next_slot
      0.00            +0.7        0.70 ±  6%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_range
     79.62            +0.9       80.50            +0.6       80.20        perf-profile.children.cycles-pp.__do_sys_brk
      1.10 ±  3%      +1.0        2.10 ±  3%      -0.0        1.06 ±  2%  perf-profile.children.cycles-pp.mas_prev
      2.86 ±  3%      +1.3        4.12 ±  3%      +1.4        4.24        perf-profile.children.cycles-pp.vma_prepare
      1.45 ±  4%      +1.3        2.79 ±  3%      -0.0        1.41 ±  4%  perf-profile.children.cycles-pp.mas_prev_slot
     54.06            +1.8       55.82            +0.9       54.96        perf-profile.children.cycles-pp.do_brk_flags
      0.00           +28.3       28.30           +30.0       30.00        perf-profile.children.cycles-pp.vma_expand
      0.00           +32.6       32.58           +32.1       32.11        perf-profile.children.cycles-pp.vma_merge_new_range
      5.90 ±  2%      -3.4        2.47 ±  3%      -3.5        2.38        perf-profile.self.cycles-pp.do_brk_flags
      3.84 ±  2%      -0.9        2.90            -1.0        2.88        perf-profile.self.cycles-pp.mas_wr_store_type
      9.85            -0.8        9.02            +0.1        9.95        perf-profile.self.cycles-pp.perf_event_mmap_output
      5.26            -0.8        4.47 ±  2%      -0.3        5.00        perf-profile.self.cycles-pp.up_write
      1.34 ±  2%      -0.6        0.75 ±  3%      -0.6        0.78 ±  5%  perf-profile.self.cycles-pp.can_vma_merge_after
      2.86            -0.4        2.47 ±  5%      -0.3        2.53 ±  2%  perf-profile.self.cycles-pp.mas_store_prealloc
      2.50 ±  2%      -0.3        2.22 ±  2%      -0.3        2.24 ±  4%  perf-profile.self.cycles-pp.mas_preallocate
      5.02 ±  2%      -0.2        4.79            -0.2        4.78 ±  2%  perf-profile.self.cycles-pp.__do_sys_brk
      2.19 ±  4%      -0.2        1.96 ±  3%      -0.1        2.13 ±  2%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      1.87 ±  3%      -0.2        1.66 ±  4%      -0.2        1.67 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_event
      1.52 ±  3%      -0.2        1.33 ±  2%      -0.1        1.40 ±  3%  perf-profile.self.cycles-pp.perf_event_mmap
      1.82 ±  3%      -0.1        1.68 ±  4%      -0.2        1.66 ±  2%  perf-profile.self.cycles-pp.down_write_killable
      1.84 ±  2%      -0.1        1.74 ±  4%      -0.1        1.77 ±  4%  perf-profile.self.cycles-pp.init_multi_vma_prep
      1.18 ±  2%      -0.1        1.09            -0.1        1.10 ±  5%  perf-profile.self.cycles-pp.do_syscall_64
      5.62 ±  2%      -0.1        5.54            -0.2        5.37 ±  2%  perf-profile.self.cycles-pp.brk
      0.79 ±  4%      -0.1        0.73 ±  6%      -0.1        0.71 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.33 ±  4%      -0.0        0.30 ±  5%      +0.0        0.34 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      1.08 ±  2%      -0.0        1.05 ±  4%      +0.2        1.29 ±  6%  perf-profile.self.cycles-pp.mas_find
      0.61 ±  4%      -0.0        0.59 ±  3%      -0.0        0.56 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.14 ±  3%      -0.0        0.14 ±  7%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.intel_idle
      0.10 ± 16%      +0.0        0.10 ± 16%      +0.0        0.14 ± 10%  perf-profile.self.cycles-pp.khugepaged_enter_vma
      0.29 ± 10%      +0.0        0.33 ± 15%      +0.1        0.37 ±  8%  perf-profile.self.cycles-pp.security_mmap_addr
      0.46 ±  3%      +0.0        0.51 ±  8%      +0.2        0.62 ±  4%  perf-profile.self.cycles-pp.mas_update_gap
      0.03 ± 70%      +0.1        0.08 ± 14%      +0.0        0.08 ± 14%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      3.94 ±  4%      +0.1        4.00 ±  4%      +0.2        4.12 ±  2%  perf-profile.self.cycles-pp.mas_walk
      0.13 ±  7%      +0.1        0.22 ± 10%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.rb_next
      0.40 ±  7%      +0.1        0.50 ±  9%      +0.1        0.52 ±  4%  perf-profile.self.cycles-pp.mas_wr_store_entry
      1.21 ±  4%      +0.1        1.32 ±  2%      +0.0        1.24 ±  5%  perf-profile.self.cycles-pp.sized_strscpy
      0.38 ±  7%      +0.1        0.50 ±  7%      +0.1        0.48 ±  8%  perf-profile.self.cycles-pp.strnlen
      0.95 ±  7%      +0.1        1.10 ±  4%      +0.2        1.13 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.63 ±  5%      +0.2        0.82 ±  9%      +0.2        0.84 ±  3%  perf-profile.self.cycles-pp.vma_prepare
      2.98 ±  2%      +0.2        3.20            +0.3        3.31        perf-profile.self.cycles-pp.down_write
      0.37 ±  6%      +0.2        0.60 ±  6%      +0.2        0.59 ±  5%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.00            +0.2        0.24 ± 11%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_setup
      0.24 ±  6%      +0.3        0.54 ±  6%      +0.3        0.55 ±  8%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.32 ±  4%      +0.3        0.64 ±  5%      -0.0        0.29 ±  9%  perf-profile.self.cycles-pp.mas_prev_setup
      0.38 ± 10%      +0.3        0.72 ±  6%      +0.3        0.72 ±  5%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.00            +0.4        0.41 ±  5%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_range
      0.63 ±  5%      +0.5        1.17 ±  3%      -0.0        0.61 ±  4%  perf-profile.self.cycles-pp.mas_prev
      0.87 ±  3%      +0.6        1.49 ±  3%      -0.0        0.83 ±  3%  perf-profile.self.cycles-pp.mas_next_slot
      1.37 ±  4%      +1.3        2.64 ±  3%      -0.0        1.33 ±  5%  perf-profile.self.cycles-pp.mas_prev_slot
      0.00            +1.3        1.30            +1.3        1.26 ±  6%  perf-profile.self.cycles-pp.vma_merge_new_range
      0.00            +3.4        3.45 ±  2%      +4.0        3.96 ±  2%  perf-profile.self.cycles-pp.vma_expand

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-icl-2sp9/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
   2667734            -5.6%    2518021            -1.0%    2640850        aim9.brk_test.ops_per_sec
    196.00            +0.0%     196.00          +404.4%     988.58 ±168%  meminfo.Inactive(file)
     23.94            -8.7%      21.86 ±  2%      -4.6%      22.84        time.user_time
    948658            +2.3%     970280            +1.0%     958340        proc-vmstat.pgalloc_normal
    792310            -1.5%     780779            -0.1%     791672        proc-vmstat.pgfault
    814343            +2.4%     833987            +0.9%     821925        proc-vmstat.pgfree
      0.01 ± 47%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.06 ± 34%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
    399.96            -0.0%     399.92           -43.8%     224.93 ±  2%  perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
     10.00            +0.0%      10.00           +80.0%      18.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 47%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
    399.95            -0.0%     399.92           -43.8%     224.93 ±  2%  perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.06 ± 34%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
 1.721e+09            +3.0%  1.773e+09            -0.2%  1.717e+09        perf-stat.i.branch-instructions
      0.54            -5.4%       0.52            -1.7%       0.54        perf-stat.i.cpi
 7.553e+09            +6.0%  8.003e+09            +1.2%  7.645e+09        perf-stat.i.instructions
      1.86            +6.1%       1.97            +2.0%       1.90        perf-stat.i.ipc
      0.36 ±  2%      -0.0        0.35            -0.0        0.34 ±  5%  perf-stat.overall.branch-miss-rate%
      0.55            -5.3%       0.52            -2.1%       0.54        perf-stat.overall.cpi
      1.82            +5.6%       1.92            +2.2%       1.86        perf-stat.overall.ipc
 1.715e+09            +3.0%  1.767e+09            -0.2%  1.711e+09        perf-stat.ps.branch-instructions
 7.529e+09            +5.9%  7.977e+09            +1.2%  7.621e+09        perf-stat.ps.instructions
 2.275e+12            +5.8%  2.408e+12            +1.7%  2.314e+12        perf-stat.total.instructions
      6.58 ±  2%      -6.6        0.00            -6.6        0.00        perf-profile.calltrace.cycles-pp.mas_store_prealloc.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.76 ±  2%      -5.8        0.00            -5.8        0.00        perf-profile.calltrace.cycles-pp.mas_preallocate.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.35            -1.3       17.10            -0.5       17.82        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.92            -1.1       14.78 ±  2%      -0.6       15.36        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
     11.03            -0.7       10.33            -0.3       10.71 ±  2%  perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      4.22 ±  3%      -0.4        3.79 ±  2%      -0.2        4.00 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.48            -0.4        8.08 ±  2%      -0.2        8.32 ±  2%  perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
      5.32            -0.3        4.98            -0.2        5.08        perf-profile.calltrace.cycles-pp.clear_bhb_loop.brk
      5.38 ±  3%      -0.3        5.06            +0.0        5.39        perf-profile.calltrace.cycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      1.16 ±  7%      -0.3        0.86 ±  5%      -0.2        0.95 ±  4%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.88 ± 14%      -0.2        0.64 ±  8%      -0.1        0.75 ±  5%  perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.56            -0.2        5.38            +0.2        5.73        perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.74 ±  6%      -0.2        0.57 ±  6%      -0.1        0.69 ±  3%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64
      5.09            -0.2        4.92            +0.1        5.22        perf-profile.calltrace.cycles-pp.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.73            -0.2        3.56 ±  2%      +0.1        3.79 ±  2%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
      1.25 ±  2%      -0.2        1.08 ±  9%      -0.1        1.17 ±  7%  perf-profile.calltrace.cycles-pp.sized_strscpy.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      1.98 ±  2%      -0.1        1.84 ±  3%      +0.0        1.99 ±  4%  perf-profile.calltrace.cycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.55 ±  2%      -0.1        0.42 ± 44%      +0.0        0.60 ±  8%  perf-profile.calltrace.cycles-pp.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ±  3%      -0.1        0.72 ±  4%      -0.0        0.77 ±  3%  perf-profile.calltrace.cycles-pp.mas_prev.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.6        0.56 ±  5%      +0.5        0.46 ± 44%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +0.6        0.64            +0.6        0.64 ±  5%  perf-profile.calltrace.cycles-pp.vma_adjust_trans_huge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +0.7        0.69 ±  8%      +0.7        0.66 ±  6%  perf-profile.calltrace.cycles-pp.__anon_vma_interval_tree_remove.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +0.8        0.78 ±  4%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_next_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.8        0.80 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
     82.26            +0.8       83.07            +0.7       82.94        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.8        0.82 ±  4%      +1.0        1.04 ±  3%  perf-profile.calltrace.cycles-pp.can_vma_merge_after.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
     81.38            +0.8       82.20            +0.6       82.03        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.8        0.84 ±  4%      +0.9        0.91 ±  6%  perf-profile.calltrace.cycles-pp.mas_wr_slot_store.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
     77.94            +1.0       78.92            +0.6       78.57        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +1.2        1.24 ±  3%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_prev_slot.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +1.3        1.32 ±  2%      +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_next_slot.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.38 ±  2%      +1.4        1.39 ±  3%  perf-profile.calltrace.cycles-pp.down_write.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.4        1.40 ±  4%      +1.5        1.49 ±  4%  perf-profile.calltrace.cycles-pp.up_write.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.6        1.64            +1.7        1.74 ±  4%  perf-profile.calltrace.cycles-pp.up_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.8        1.82 ±  5%      +1.8        1.84 ±  2%  perf-profile.calltrace.cycles-pp.down_write.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.9        1.89 ±  3%      +2.0        2.04 ±  2%  perf-profile.calltrace.cycles-pp.init_multi_vma_prep.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.9        1.92 ±  3%      +2.0        2.01 ±  3%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
      0.00            +2.3        2.31            +2.3        2.33 ±  3%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +2.7        2.68 ±  2%      +2.8        2.78 ±  2%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +2.9        2.92 ±  4%      +3.0        2.96 ±  2%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +2.9        2.93 ±  2%      +2.8        2.84 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
     53.19            +3.0       56.14            +1.2       54.34        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +4.4        4.42            +4.6        4.57        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +7.1        7.09            +7.4        7.42        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00           +26.8       26.83           +27.6       27.58        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00           +31.4       31.41           +30.5       30.46        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.93            -1.3        4.62            -1.2        4.76        perf-profile.children.cycles-pp.mas_preallocate
     18.48            -1.3       17.23            -0.5       17.96        perf-profile.children.cycles-pp.perf_event_mmap
     16.41            -1.2       15.23            -0.5       15.88        perf-profile.children.cycles-pp.perf_event_mmap_event
      3.46            -1.1        2.37            -1.1        2.40 ±  3%  perf-profile.children.cycles-pp.mas_wr_store_type
     11.24            -0.7       10.52 ±  2%      -0.3       10.93 ±  2%  perf-profile.children.cycles-pp.perf_iterate_sb
      4.29 ±  3%      -0.4        3.86 ±  2%      -0.2        4.06 ±  2%  perf-profile.children.cycles-pp.mas_walk
      8.61            -0.4        8.21 ±  2%      -0.2        8.44 ±  2%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.83 ±  7%      -0.4        0.47 ±  8%      -0.3        0.50 ±  7%  perf-profile.children.cycles-pp.may_expand_vm
      3.82            -0.3        3.48 ±  3%      -0.3        3.48 ±  3%  perf-profile.children.cycles-pp.down_write
      5.39            -0.3        5.06            -0.2        5.16        perf-profile.children.cycles-pp.clear_bhb_loop
      1.36 ±  5%      -0.3        1.03 ±  5%      -0.2        1.16 ±  3%  perf-profile.children.cycles-pp.__vm_enough_memory
      1.18 ±  5%      -0.3        0.88 ±  4%      -0.1        1.11 ±  2%  perf-profile.children.cycles-pp.can_vma_merge_after
      0.57 ± 22%      -0.2        0.33 ± 12%      -0.1        0.45 ±  8%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      1.06 ± 11%      -0.2        0.83 ±  9%      -0.1        0.94 ±  4%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      5.30            -0.2        5.11            +0.1        5.42        perf-profile.children.cycles-pp.__get_unmapped_area
      5.75            -0.2        5.56            +0.2        5.93        perf-profile.children.cycles-pp.check_brk_limits
      0.82 ±  4%      -0.2        0.64 ±  4%      -0.1        0.76 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      3.86            -0.2        3.69 ±  2%      +0.1        3.93 ±  2%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      1.32 ±  2%      -0.2        1.16 ±  8%      -0.1        1.24 ±  6%  perf-profile.children.cycles-pp.sized_strscpy
      2.10 ±  2%      -0.1        1.96 ±  2%      +0.0        2.11 ±  3%  perf-profile.children.cycles-pp.down_write_killable
      1.86 ±  3%      -0.1        1.74 ±  2%      -0.0        1.83 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.57 ±  7%      -0.1        0.45 ± 13%      -0.1        0.46 ±  7%  perf-profile.children.cycles-pp.strlen
      2.78            -0.1        2.66 ±  2%      +0.0        2.80 ±  2%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      3.16            -0.1        3.10            -0.2        3.00 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      0.72 ±  5%      -0.0        0.68 ±  9%      -0.1        0.66 ±  4%  perf-profile.children.cycles-pp.brk_test
      0.20 ± 11%      -0.0        0.19 ±  9%      +0.1        0.28 ± 11%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      1.92 ±  2%      +0.0        1.96 ±  3%      +0.2        2.10 ±  3%  perf-profile.children.cycles-pp.init_multi_vma_prep
      0.70 ±  2%      +0.1        0.81 ±  6%      +0.1        0.80 ±  6%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
     95.56            +0.2       95.72            +0.4       95.92        perf-profile.children.cycles-pp.brk
      0.68 ±  9%      +0.2        0.90 ±  3%      +0.3        0.98 ±  6%  perf-profile.children.cycles-pp.mas_wr_slot_store
      0.34 ±  5%      +0.3        0.68 ±  6%      +0.0        0.34 ±  6%  perf-profile.children.cycles-pp.mas_prev_setup
      0.00            +0.4        0.43 ±  2%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_setup
      6.91 ±  2%      +0.5        7.37            +0.9        7.76        perf-profile.children.cycles-pp.mas_store_prealloc
      0.92 ±  3%      +0.8        1.76 ±  3%      -0.0        0.90 ±  4%  perf-profile.children.cycles-pp.mas_prev
     83.20            +0.9       84.05            +0.7       83.85        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     82.36            +0.9       83.23            +0.6       83.00        perf-profile.children.cycles-pp.do_syscall_64
     78.68            +0.9       79.62            +0.6       79.31        perf-profile.children.cycles-pp.__do_sys_brk
      0.00            +0.9        0.94 ±  3%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_range
      1.35 ±  5%      +1.2        2.59 ±  3%      +0.1        1.49 ±  3%  perf-profile.children.cycles-pp.mas_prev_slot
      0.84 ±  3%      +1.4        2.26 ±  3%      +0.1        0.93 ±  6%  perf-profile.children.cycles-pp.mas_next_slot
     54.26            +2.3       56.54            +0.4       54.70        perf-profile.children.cycles-pp.do_brk_flags
      0.00           +27.5       27.55           +28.3       28.34        perf-profile.children.cycles-pp.vma_expand
      0.00           +31.9       31.86           +30.8       30.80        perf-profile.children.cycles-pp.vma_merge_new_range
      6.50            -3.3        3.19 ±  2%      -2.8        3.65 ±  2%  perf-profile.self.cycles-pp.do_brk_flags
      3.35            -1.1        2.25            -1.1        2.28 ±  3%  perf-profile.self.cycles-pp.mas_wr_store_type
      5.31 ±  2%      -0.4        4.88            -0.2        5.13 ±  3%  perf-profile.self.cycles-pp.__do_sys_brk
      4.22 ±  3%      -0.4        3.80 ±  2%      -0.2        4.00 ±  2%  perf-profile.self.cycles-pp.mas_walk
      8.47            -0.4        8.07 ±  2%      -0.2        8.28 ±  2%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.71 ±  8%      -0.3        0.38 ±  8%      -0.3        0.39 ±  5%  perf-profile.self.cycles-pp.may_expand_vm
      5.32            -0.3        5.00            -0.2        5.10        perf-profile.self.cycles-pp.clear_bhb_loop
      1.12 ±  5%      -0.3        0.82 ±  4%      -0.1        1.04 ±  4%  perf-profile.self.cycles-pp.can_vma_merge_after
      2.62            -0.2        2.38 ±  5%      -0.2        2.40 ±  3%  perf-profile.self.cycles-pp.down_write
      0.44 ± 28%      -0.2        0.20 ± 13%      -0.1        0.33 ± 12%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      2.50 ±  3%      -0.2        2.31 ±  2%      -0.1        2.42        perf-profile.self.cycles-pp.mas_preallocate
      0.61 ±  9%      -0.2        0.42 ±  7%      -0.2        0.45 ±  5%  perf-profile.self.cycles-pp.__vm_enough_memory
      1.26 ±  2%      -0.2        1.09 ±  9%      -0.1        1.17 ±  6%  perf-profile.self.cycles-pp.sized_strscpy
      0.57 ±  5%      -0.1        0.44 ±  4%      -0.0        0.52 ±  5%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      2.25 ±  3%      -0.1        2.13 ±  3%      -0.0        2.23 ±  3%  perf-profile.self.cycles-pp.perf_event_mmap_event
      2.70            -0.1        2.60 ±  2%      +0.0        2.74 ±  2%  perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.50 ±  8%      -0.1        0.40 ± 12%      -0.1        0.41 ±  6%  perf-profile.self.cycles-pp.strlen
      0.57 ±  4%      -0.1        0.52 ±  4%      -0.0        0.56 ±  9%  perf-profile.self.cycles-pp.strnlen
      0.46 ±  7%      -0.0        0.45 ± 12%      +0.1        0.51 ±  5%  perf-profile.self.cycles-pp.check_brk_limits
      1.85 ±  2%      -0.0        1.84 ±  3%      +0.1        1.98 ±  3%  perf-profile.self.cycles-pp.init_multi_vma_prep
      0.60 ±  5%      +0.0        0.63            +0.1        0.65 ±  2%  perf-profile.self.cycles-pp.vma_adjust_trans_huge
      0.01 ±223%      +0.1        0.06 ± 15%      +0.0        0.05 ± 46%  perf-profile.self.cycles-pp.anon_vma_interval_tree_remove
      0.64 ±  7%      +0.1        0.72 ±  6%      +0.2        0.81 ±  5%  perf-profile.self.cycles-pp.mas_find
      0.51 ±  4%      +0.1        0.60 ±  5%      +0.1        0.60 ±  6%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      2.87 ±  2%      +0.2        3.10 ±  2%      +0.4        3.24 ±  2%  perf-profile.self.cycles-pp.mas_store_prealloc
      0.61 ±  8%      +0.2        0.84 ±  4%      +0.3        0.91 ±  5%  perf-profile.self.cycles-pp.mas_wr_slot_store
      0.26 ±  7%      +0.3        0.56 ±  5%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.mas_prev_setup
      0.00            +0.3        0.33 ±  3%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_setup
      0.53 ±  6%      +0.4        0.98 ±  3%      -0.0        0.51 ±  8%  perf-profile.self.cycles-pp.mas_prev
      0.00            +0.6        0.56 ±  5%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_range
      1.29 ±  4%      +1.2        2.46 ±  3%      +0.1        1.42 ±  4%  perf-profile.self.cycles-pp.mas_prev_slot
      0.72 ±  4%      +1.4        2.07 ±  3%      +0.1        0.79 ±  8%  perf-profile.self.cycles-pp.mas_next_slot
      0.00            +1.4        1.40 ±  4%      +1.3        1.29 ±  3%  perf-profile.self.cycles-pp.vma_merge_new_range
      0.00            +3.6        3.55 ±  6%      +3.7        3.66 ±  2%  perf-profile.self.cycles-pp.vma_expand

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s

commit:
  fc21959f74bc11 ("mm: abstract vma_expand() to use vma_merge_struct")
  cacded5e42b960 ("mm: avoid using vma_merge() for new VMAs")
  9cecc5dc893886 ("mm: add expand-only VMA merge mode and optimise do_brk_flags()")

fc21959f74bc1138 cacded5e42b9609b07b22d80c10 9cecc5dc89388676d1d0d47461c
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     78524 ±113%     +27.6%     100212 ± 86%     +64.3%     128984 ± 72%  numa-meminfo.node0.AnonHugePages
     38.39 ±113%     +27.5%      48.94 ± 86%     +64.1%      63.00 ± 72%  numa-vmstat.node0.nr_anon_transparent_hugepages
      0.54 ± 14%      -6.6%       0.50 ± 23%     -38.6%       0.33 ± 32%  sched_debug.cpu.nr_running.max
      5949            -1.7%       5850 ±  2%      -4.0%       5713 ±  3%  vmstat.system.in
    201.54            +2.9%     207.44            +2.0%     205.54        time.system_time
     97.58            -6.0%      91.75            -4.0%      93.66        time.user_time
   1322908            -5.0%    1256536            -1.6%    1301387        aim9.brk_test.ops_per_sec
    201.54            +2.9%     207.44            +2.0%     205.54        aim9.time.system_time
     97.58            -6.0%      91.75            -4.0%      93.66        aim9.time.user_time
     61335            -2.5%      59800            -3.4%      59279        proc-vmstat.nr_active_anon
     62342            -2.4%      60875            -3.3%      60255        proc-vmstat.nr_shmem
     61335            -2.5%      59800            -3.4%      59279        proc-vmstat.nr_zone_active_anon
      0.04 ± 82%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.10 ± 60%    -100.0%       0.00          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.04 ± 82%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
      0.10 ± 60%    -100.0%       0.00          -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
  8.33e+08            +3.9%  8.654e+08            -1.1%   8.24e+08        perf-stat.i.branch-instructions
      1.15            -0.1        1.09            -0.0        1.14 ±  2%  perf-stat.i.branch-miss-rate%
  12964626            -1.9%   12711922            -4.5%   12386373        perf-stat.i.branch-misses
      1.11            -7.4%       1.03            -2.0%       1.09        perf-stat.i.cpi
 4.277e+09            -1.1%  4.229e+09            -2.0%  4.191e+09        perf-stat.i.cpu-cycles
 3.943e+09            +6.0%   4.18e+09            +0.2%  3.951e+09        perf-stat.i.instructions
      0.91            +7.9%       0.98            +2.5%       0.93        perf-stat.i.ipc
      0.29 ±  2%      -9.1%       0.27 ±  4%      -5.7%       0.28 ±  5%  perf-stat.overall.MPKI
      1.56            -0.1        1.47            -0.1        1.50        perf-stat.overall.branch-miss-rate%
      1.08            -6.8%       1.01            -2.2%       1.06        perf-stat.overall.cpi
      0.92            +7.2%       0.99            +2.3%       0.94        perf-stat.overall.ipc
 8.303e+08            +3.9%  8.627e+08            -1.1%  8.214e+08        perf-stat.ps.branch-instructions
  12931205            -2.0%   12678170            -4.5%   12352666        perf-stat.ps.branch-misses
 4.263e+09            -1.1%  4.215e+09            -2.0%  4.177e+09        perf-stat.ps.cpu-cycles
  3.93e+09            +6.0%  4.167e+09            +0.2%  3.938e+09        perf-stat.ps.instructions
 1.184e+12            +6.1%  1.256e+12            +0.8%  1.194e+12        perf-stat.total.instructions
      7.16 ±  2%      -0.4        6.76 ±  4%      -0.6        6.55 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.brk
      5.72 ±  2%      -0.4        5.35 ±  3%      +0.0        5.73        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
      6.13 ±  2%      -0.3        5.84 ±  3%      +0.1        6.25        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.83 ± 11%      -0.1        0.71 ±  5%      -0.1        0.74 ±  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.51 ±  5%      -0.0        2.48 ± 11%      +0.2        2.71 ±  4%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.32 ±  5%      -0.0        1.31 ± 14%      +0.1        1.45 ±  4%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +0.6        0.58 ±  5%      +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
     16.73 ±  2%      +0.6       17.34            +0.3       16.99        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.7        0.66 ±  6%      +0.7        0.67 ±  8%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
     24.51            +0.7       25.17 ±  2%      +0.6       25.14        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.brk
     24.21            +0.7       24.90            +0.6       24.84        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     23.33            +0.7       24.05 ±  2%      +0.6       23.89        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.8        0.82 ±  4%      +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +0.9        0.87 ±  5%      +0.9        0.88 ±  2%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
      0.00            +1.1        1.07 ±  9%      +1.0        1.04 ± 13%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +1.1        1.10 ±  6%      +1.2        1.16 ±  4%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +2.3        2.26 ±  5%      +2.2        2.21 ±  2%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
      0.00            +7.6        7.56 ±  3%      +7.5        7.52        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
      0.00            +8.6        8.62 ±  4%      +8.0        7.97        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.74 ±  2%      -0.4        7.30 ±  4%      -0.6        7.14 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      5.81 ±  2%      -0.4        5.43 ±  3%      -0.0        5.80        perf-profile.children.cycles-pp.perf_event_mmap_event
      6.18 ±  2%      -0.3        5.88 ±  3%      +0.1        6.29        perf-profile.children.cycles-pp.perf_event_mmap
      3.93            -0.2        3.73 ±  3%      +0.0        3.96        perf-profile.children.cycles-pp.perf_iterate_sb
      0.22 ± 29%      -0.1        0.08 ± 17%      -0.0        0.19 ± 69%  perf-profile.children.cycles-pp.may_expand_vm
      0.96 ±  3%      -0.1        0.83 ±  4%      -0.1        0.84 ±  2%  perf-profile.children.cycles-pp.vma_complete
      0.61 ± 14%      -0.1        0.52 ±  7%      -0.0        0.57 ±  5%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.15 ±  7%      -0.1        0.08 ± 20%      -0.1        0.09 ± 11%  perf-profile.children.cycles-pp.brk_test
      2.58 ±  5%      -0.0        2.54 ± 11%      +0.2        2.76 ±  4%  perf-profile.children.cycles-pp.menu_select
      0.27 ±  9%      -0.0        0.26 ±  8%      +0.1        0.35 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.06 ± 49%      -0.0        0.06 ± 13%      +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.28 ± 19%      -0.0        0.27 ± 16%      +0.1        0.36 ± 11%  perf-profile.children.cycles-pp.__softirqentry_text_end
      1.36 ±  5%      -0.0        1.35 ± 13%      +0.1        1.49 ±  3%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.08 ± 11%      +0.0        0.12 ± 14%      -0.0        0.06 ± 48%  perf-profile.children.cycles-pp.mas_prev_setup
      0.17 ± 12%      +0.1        0.27 ± 10%      -0.0        0.16 ±  5%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.00            +0.2        0.15 ± 11%      +0.0        0.00        perf-profile.children.cycles-pp.mas_next_range
      0.19 ±  8%      +0.2        0.38 ± 10%      +0.0        0.22 ± 22%  perf-profile.children.cycles-pp.mas_next_slot
      0.34 ± 17%      +0.3        0.64 ±  6%      -0.0        0.33 ± 18%  perf-profile.children.cycles-pp.mas_prev_slot
      1.70 ± 12%      +0.5        2.18 ± 15%      +0.4        2.08 ± 10%  perf-profile.children.cycles-pp.mas_find
     25.16            +0.7       25.83 ±  2%      +0.6       25.79        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     24.86            +0.7       25.56 ±  2%      +0.6       25.49        perf-profile.children.cycles-pp.do_syscall_64
     23.40            +0.7       24.12 ±  2%      +0.6       23.95        perf-profile.children.cycles-pp.__do_sys_brk
      0.00            +7.6        7.59 ±  3%      +7.6        7.56        perf-profile.children.cycles-pp.vma_expand
      0.00            +8.7        8.66 ±  4%      +8.0        7.98        perf-profile.children.cycles-pp.vma_merge_new_range
      1.61 ± 10%      -0.9        0.69 ±  8%      -0.8        0.78 ±  6%  perf-profile.self.cycles-pp.do_brk_flags
      7.64 ±  2%      -0.4        7.20 ±  4%      -0.6        7.04 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.22 ± 30%      -0.1        0.08 ± 17%      -0.0        0.19 ± 70%  perf-profile.self.cycles-pp.may_expand_vm
      0.57 ± 15%      -0.1        0.46 ±  6%      -0.0        0.52 ±  5%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.15 ±  7%      -0.1        0.08 ± 20%      -0.1        0.09 ± 11%  perf-profile.self.cycles-pp.brk_test
      0.20 ±  5%      -0.0        0.18 ±  4%      -0.0        0.19 ± 10%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
      0.19 ±  8%      -0.0        0.18 ±  8%      +0.0        0.23 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.06 ± 48%      -0.0        0.05 ±  8%      +0.0        0.11 ± 17%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ± 11%      -0.0        0.09 ± 18%      +0.1        0.15 ± 25%  perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.07 ± 18%      +0.0        0.10 ± 18%      -0.0        0.05 ± 47%  perf-profile.self.cycles-pp.mas_prev_setup
      0.00            +0.1        0.09 ± 12%      +0.0        0.00        perf-profile.self.cycles-pp.mas_next_range
      0.36 ±  8%      +0.1        0.45 ±  6%      +0.1        0.48 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap
      0.15 ± 13%      +0.1        0.25 ± 14%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.17 ± 11%      +0.2        0.37 ± 11%      +0.0        0.20 ± 23%  perf-profile.self.cycles-pp.mas_next_slot
      0.34 ± 17%      +0.3        0.64 ±  6%      -0.0        0.33 ± 18%  perf-profile.self.cycles-pp.mas_prev_slot
      0.00            +0.3        0.33 ±  5%      +0.2        0.22 ± 12%  perf-profile.self.cycles-pp.vma_merge_new_range
      0.00            +0.8        0.81 ±  9%      +0.7        0.69 ± 12%  perf-profile.self.cycles-pp.vma_expand


--t1myKVu9sjgSYkoK--

