Return-Path: <linux-kernel+bounces-212003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85299059DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0984B1C22821
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11BB1822CA;
	Wed, 12 Jun 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLCCD6oh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204393209
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213190; cv=fail; b=pkNJMTx/eQs1DOKEWQ2mSP/T+R7EvOajiudc11gaodj4YBguaBofdZC8DgU7zDXvkcq0kRa/4KdaxfQPoqtyU0h2Xi0exLvjYSQ/3BxziDjRc1mtdjeRqpvwo2LK3PIWFkovKjcgKv/in8c6tM/0ouwZbc9e1vY8P2dykey5V9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213190; c=relaxed/simple;
	bh=hbC01Gf7xZ6XdnsmUA2EuRvE/lM7zGFD2UtwF6KF4CE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCqC5fi1rulY1ToHOyxAus5EzUmOiwzRZYAyDrgbxOdEEfIZ9xyrZczPQHVsOEddLQ+l7gFJgXhXlMMvdEDgfhEoMwln1ze5z3nMb0Jkrz6/fC+WSALBWqZ17psb+dmVI+LQL/9yrD5CHKJzLZoO0wSXHfQmnWVx7znYQFexMqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLCCD6oh; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718213188; x=1749749188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hbC01Gf7xZ6XdnsmUA2EuRvE/lM7zGFD2UtwF6KF4CE=;
  b=DLCCD6ohsU2IuF1WZ8M9Zt8YKrnmpRnMfYTa3w0m1ClqxaWH4DDK96S4
   NGKz0LZA80IiOLnL5yr6+LI/Upw/g/pd3OsyGQ/h8N+v+JipQSVAtBBUY
   aqHx/elooodvYrBVUBsiks8GDKewkgb+D1uKNshIzLJJLoKxDcuTbkBQo
   LXsCXy9n+LkqHUEpwr7aE5XFa+rW4J9XzdSR8L3rdHeGrmlyrXxEVEwVc
   oz23zlAS9I9EqcSyNV1P1pcZdZXViSKCqdiD9o3/ikQAc1M194Qt8cnfB
   jH1gAFhWKaN7wSZOMLl084N54g+GQF7wBiJo4R8HGVgeOkkuX2P4gdZ2F
   g==;
X-CSE-ConnectionGUID: MLQQBIpVRdmqTHL+Cx7AvA==
X-CSE-MsgGUID: 8EMciZSmTFmy9XOVZXt/sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14827775"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="14827775"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:26:27 -0700
X-CSE-ConnectionGUID: OooI0zUgRGGCHiWfVOAy1w==
X-CSE-MsgGUID: NXcz9eMiS9CWDg20InQwLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40334892"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jun 2024 10:26:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 10:26:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 10:26:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 10:25:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgyFsAZBX7PyofDfjs6wi4rvyRU8UdJNOKu+B4ZOqOvUFXmgHIfXAk9xOyuejXxgXqwsNzlyaQSMOyycHrExakIJqnhodh+5lp+/ZZ4ZxXiII7tgwVVr4JLYULbG538fJdpE8g7dbWI0Hwo2hv9zEtbo1ILfz2o3L7ZiNtu22ef12jLv4XyKn/hy1G1AkJJH53tXdfJN8rYllbQc+UZFI+b7gOiUG7y2KdwnyqiBd/fqabTLOJSyhssgKeyeKDXylz7T4zW39+xQHiJzRSa3C2DEDgRyOD3o6dOE4T6kmjjf3AIuv8JDLPoDKnM+IKsahs/uNR/uEVhtwbwo6Z3KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo1BONST0k8NwVJVq0q1JXlaAHcb+DjlGpGpVzNe1w0=;
 b=ZMn3yMubCg9U/fLs12rIYZmq++s4IVr/WY5qOn5GpEH1S6oI2BFAb9EXz4u0OCnzs6HG0AWoqbOmX4FOtstGthkTzulsDOp4ZgOUbj279GB3vexbEQoRoXUSOGzmvu6/o4gCfMKvviRTd9crCXzDPFV+EPNwPvKLlnFriMbPuI7FMTDQl8jQNa2p1bLuhk+TBwJVGAYbRmlRV3PW2f2KNMmKrv2xKFRk2QhMv6Q/jcXXpobc1P1i+HN+c+Z1873Frwa9WGV4PmV4BRxBmu3W5MlU0MwfBeNlAvN5f1wKqWZnlhSbSvnGZt4Wcc1+ZmxtwaMGVO/RQJKfL85tYRFPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 17:25:47 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 17:25:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Oscar Salvador <osalvador@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Muchun Song
	<muchun.song@linux.dev>,
	"syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com"
	<syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>
Subject: RE: [PATCH] mm/hugetlb: Guard dequeue_hugetlb_folio_nodemask against
 NUMA_NO_NODE uses
Thread-Topic: [PATCH] mm/hugetlb: Guard dequeue_hugetlb_folio_nodemask against
 NUMA_NO_NODE uses
Thread-Index: AQHavKK4B0EzVOxbPk2t2TFNeotrHrHEYELQ
Date: Wed, 12 Jun 2024 17:25:45 +0000
Message-ID: <IA0PR11MB71853C005303041A07A5CF12F8C02@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20240612082936.10867-1-osalvador@suse.de>
In-Reply-To: <20240612082936.10867-1-osalvador@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DM4PR11MB7253:EE_
x-ms-office365-filtering-correlation-id: d8ec5229-b307-4b13-c8f2-08dc8b04b1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?buwxZtK2NO/KeI4aRsqdDNzbwHFPH+T0jQlmlg1H71xUUNuqEuOB7Ig2WaBY?=
 =?us-ascii?Q?Vl38UXk6c7HdJNDQI72UYQvPQ6TVhE9e2uM+Az3WFCLMNLX3SoLklfr+qEjj?=
 =?us-ascii?Q?pubMEa0OMpa+ef2LkN7aExkVBR3wnzzn0YeBUWKS25pSrwNBRbbPhNGjph6U?=
 =?us-ascii?Q?zqykPwF8MfSgbWkx1hwTw2Y2gji0cj+AAnXjLjhtVIB0VBwvIELreWmtMlIv?=
 =?us-ascii?Q?96VvIgnoQ6zk5N9+2lXwuUKxW8Tx02xZBrLPkLvTTICTfTblQbBCo8J3L6TY?=
 =?us-ascii?Q?1h39tS0M/KTe/7Mk6X2rDAMoNu/XpN3LVszm5mFMWGHzNbhKVDxH3/MWKk2S?=
 =?us-ascii?Q?QcbrYURAKVHNL6F1ws2tUoUHnY/LFKMeWZwPUpF8jWslaa6DXl6YTxoV6Ek8?=
 =?us-ascii?Q?rk1W3oihhnHZuX5IcorwaKAXFfc1dogCTmU2IjOol9hJyDmZVOn1w5WHyzWZ?=
 =?us-ascii?Q?8jxUK5/oXTek/lcfHTqHEQKebCoFZ8e7o+Rl40HwizJQ3J8C0jLRxIk9ELJL?=
 =?us-ascii?Q?0vgfvMl3cHI+hXbzMCbM23nJQ9Kzl+J8g3lKWqZc6KEMYwBPpRNFbXevFmra?=
 =?us-ascii?Q?+t9/j0N7Oo+fTjcZyc5gqKjr1af6aU9XBMN+izdJpxLadvF3EOPW8NiCTsms?=
 =?us-ascii?Q?fh1il+YAQstehSV+cEi9GEdcay8TCdnX/Ek9vlYcMPQT1Vc9/Hc453UbuB0J?=
 =?us-ascii?Q?PP8QxzNA/i7WI8PKGfyoZrsA/406Cct62L2Qj4oeCsZjRujUmLXLxCbdzAVm?=
 =?us-ascii?Q?UwT48plabaLiJp7MxMbTIf02AwixW0aQlTLXxqRDS5m6YDnSvAemmxogv2ta?=
 =?us-ascii?Q?pdo0c1NHg3EGtXuEVRu54iZcjStacY0nut4rBdWbukK6ESF/r8sC0/Anvfi8?=
 =?us-ascii?Q?JySuX/8N8ZsLTuv0dKtsgW08xnHR1+xrZYxL0VgNur7+yHp6+yjFHK5OabLA?=
 =?us-ascii?Q?87XsO64/yycI7ZI97AaxNtbCDdtoBLiaiLhdg/ConVhH7TRzBBn88R1eanLz?=
 =?us-ascii?Q?O83aEf0Xmb2RxvsmJzvrDLOid/gca2cR4Cr4Riep/NRBLiqbfRozy8P2R5Y2?=
 =?us-ascii?Q?DAMl+o+5CWKHwSdjBywvO3KSE2X0B2tOMI2etOErLcMWhhQql9fFtyJtutL7?=
 =?us-ascii?Q?nOm1pMrtpuP92oHGHChoXx2yT183WqRju6HQqvzOVdlNypHjr337gA58CujE?=
 =?us-ascii?Q?5Ad8iofLjPv1YmmnihxuDQJb/9Zt2wj5BAYJGCJHpmhLvy/RqcdoZj5v9KV0?=
 =?us-ascii?Q?pce6k21wECS1jlpo8KQAmCASFlW63d4+cPZ+RMMu/zyzpfrDqFyzgpxySjLO?=
 =?us-ascii?Q?IOVtiMSN6gXe+HqV34qCxv+GyIJs49h5+pXvlpm7JOh204HAns2WGuHr0RZK?=
 =?us-ascii?Q?qEIAFBM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G5CMHLkLoabflzIsnncATfkot6oaQo44II+T1YXzQmx9EZp2CVjnzcRKiaYJ?=
 =?us-ascii?Q?TT/pReVedYVL7eGrzpimo/x6kob6ahUDm40MSEYkiHsKQ45pIODK7v1EQ06G?=
 =?us-ascii?Q?ClYZ9fqhDZdoK/pemMGQndGbJXdJAcAsR6uINJmzlaBYsZRShRvw+TgmO1I7?=
 =?us-ascii?Q?dXlOKYbyQs4kbAHlaXtQnao6Spr9TNMEcE+dhov6OZo5uWrTXMTQJViORAi6?=
 =?us-ascii?Q?o1gB2jog7bRqs4PwZ1IYFlTfXOhYtvDYZqY/vH3LYen9dfyo93YVxf6gSwQW?=
 =?us-ascii?Q?zB4a3mRrCpf7qb2uDxajabamqgkON9ceTzVBKWYa1jGu6PmyZlH52h8x5k9X?=
 =?us-ascii?Q?gaOd+vBBd1sM0iTBxOx40sLEg8Smz96ZQYC3qi5SrTMtKKFhOXUqBYQrnT9E?=
 =?us-ascii?Q?NTntuYDrwh0Vb9/oDvztYJaJAffLqTTQ6sDKBGbYfNb/LK0u3bjBZ5JrJgYH?=
 =?us-ascii?Q?HUSJgJOC9D+gZEugbop2TR5OxdV1tYFbtTP3nxAI4hCrHJMBqlBCdHhe5nD+?=
 =?us-ascii?Q?9tNFRaHlv/l/GpTBqrbRw6ZYseBCztCz6YS3qHJwXID7duQ70HfbI4mq2UAV?=
 =?us-ascii?Q?Tu5ZAY+mX9V52O0O5fVx0T88XftUct0NdPxW88h3iCNCzq+pPopKQ+HuwqXY?=
 =?us-ascii?Q?tk/p2wKPXaebdUz/Qk4SLjcIyxg/DKFfgymXnCDVNxfF9lLuCu2laBX8EBRq?=
 =?us-ascii?Q?VBjUUebdK8abn8n5I11z9JBBHzgK4HxGb/ucy9HhhOR2BB/xMC9Wn4vTB+ad?=
 =?us-ascii?Q?1vR5mrg27SyNhTdDI3yk2xNu95VKyUHbhWv0FKxIGwqJ7bbL/urW4S+BYyZI?=
 =?us-ascii?Q?f76w2ziaQNSIqdBQADcPogcmrlOyHO4H4s9KFt7eChvzfT4iZBbZgpNUl9O8?=
 =?us-ascii?Q?Zo/X37X73iYK5JHNEyQM+JmB56wjUgspQeMOq6ETWj1MxtvlzVu+xMlsF3Sz?=
 =?us-ascii?Q?ejSW6cRpWO1QMGWU+RwUND19z3nUCeNFGF32oz8w3SHSQw2G9qnkJ/BBbMdQ?=
 =?us-ascii?Q?zLsMR06LVdweJWmvYkl668misk1HVUMxz42BF79jM0BbPLhqtmZ7iUThT2yL?=
 =?us-ascii?Q?/kvqMtyA06dKtJf+7K0poIgA5FOvOBmVfGNAqwBPO9hGGt6pCKcws95/fJ2b?=
 =?us-ascii?Q?C1hqekvdczAyLQxw7L3+lFKV1Twt+cwF16buOUgM3oOrX6yUf0kKANFAS/2x?=
 =?us-ascii?Q?yRx4dh7OMtu9q3bakH5nD4mhEXetatfDoGSY7Nm6rO7NuLrmc6t//fDOg7es?=
 =?us-ascii?Q?LrYMqIGZZFUnn1R2e/QbyAF34y0tFNAWsZXCQJ7aXXJ9MZHaBH0sPEspCV3q?=
 =?us-ascii?Q?93xWnCMC6R896rZs9J0a1rS7qkrfsuvTazc9VKBSue7ef3CmJPGULSK0ShMB?=
 =?us-ascii?Q?LsiFk9o8JxWKGxTcmpPG3eg0xByXf4xvA82Fziec9plvQ2d8CnqYVin3k1oy?=
 =?us-ascii?Q?QqJZwffWqVx+913JxmBA0xTRFqc0zs2pm0l68n27wvGIu6psF71dZJZaJOmz?=
 =?us-ascii?Q?/1B9T091/hUF1lHXau/HsqPrD6zXVbwGalIDky6yZ7+qjP6qij2g22SkCr9p?=
 =?us-ascii?Q?6LYGAAoi98eLN4I6d7cJypbknvqIhKRFCnCcxbZ6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ec5229-b307-4b13-c8f2-08dc8b04b1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 17:25:45.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSsviDP64BzU49aoeSNuMCZckx9LYCmm/7cPT5r8pD0muquOcPS34HZ6754dA0rCt+Rl/VxiYMuSJeVOcWjv06Iwk+aSa4vN2a5LIQ6n3aU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-OriginatorOrg: intel.com

> dequeue_hugetlb_folio_nodemask() expects a preferred node where to get
> the
> hugetlb page from.
> It does not expect, though, users to pass NUMA_NO_NODE, otherwise we
> will
> get trash when trying to get the zonelist from that node.
> All current users are careful enough to not pass NUMA_NO_NODE, but
> it opens the door for new users to get this wrong since it is not
> documented [0].
> Guard against this by getting the local nid if NUMA_NO_NODE was passed.
>=20
> [0] https://lore.kernel.org/linux-
> mm/0000000000004f12bb061a9acf07@google.com/
>=20
> Closes: https://lore.kernel.org/linux-
> mm/0000000000004f12bb061a9acf07@google.com/
> Reported-and-tested-by:
> syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/hugetlb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3518321f6598..6a5ea898e4da 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1355,6 +1355,10 @@ static struct folio
> *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
>  	struct zoneref *z;
>  	int node =3D NUMA_NO_NODE;
>=20
> +	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it
> and rectifiy. */
> +	if (nid =3D=3D NUMA_NO_NODE)
> +		nid =3D numa_node_id();
> +
>  	zonelist =3D node_zonelist(nid, gfp_mask);
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

>=20
>  retry_cpuset:
> --
> 2.45.2


