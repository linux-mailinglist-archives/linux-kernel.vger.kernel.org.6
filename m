Return-Path: <linux-kernel+bounces-356210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 217FC995DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7579CB2389D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527413B59B;
	Wed,  9 Oct 2024 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fP0sF44u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417EB20B0F;
	Wed,  9 Oct 2024 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442199; cv=fail; b=IKkYZ4oThsUGxvub/XgCVeskyOrHt6/y8toiDAqlr9rZZXzyo0CxOOiutJB3AGuXcNvw0Hwu/M1hig8RYk4LEODjTxfVtZnMoYBzALclnxOoi5FLT+i6Z2SlAOFE+QK8V+ott1oZkCM67ctYZ/jlFsvV4yRt991rGVdck2E/IZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442199; c=relaxed/simple;
	bh=Pj0VLvNDMCRf79LjMOXdzYhcazh8fQisNZdvNd7QSJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S9Cai8Gb/n/yTMHsw55/FtiYaeTSjUTLvLX5bKPhPP9pG72FBMQRekaCLeCjpjoKE7Mbu8dwMt6WVDlmohtHRKmwA6MlnwIYvPh9Z7B5JvVJ9zwClN9Hxbko/GXDLXCd28o3AjiOf0QpLFmOKk8rYAabwYrEwHF0D7DsIg29tIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fP0sF44u; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728442197; x=1759978197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pj0VLvNDMCRf79LjMOXdzYhcazh8fQisNZdvNd7QSJo=;
  b=fP0sF44uyybg05Ath73FUW5yedlxIELcJxl2SzlySo0f1mRTfI6AGCrI
   TNhsfLksTeYz4WAp+L3awIvsnIGLcXOj7j7o/7aBcmH+ND1AYK7ju/3Z8
   k2zMmObnq0gvzg+JsvC52Cr+yv8DSQlErd6eQiL2Yl+BJQLrkOXqknsW3
   oRbcbss7/HeLjRYar6Kn0HrABwaJ2UQT96HfCf1aeFxatI/valeR0+Jy0
   znpeizq8HpyuR+XRmVSPA1AySgtx9eckawkPcJNQJxrA0KER1jgK3trgm
   f2kVPcXhzrb2aUaoh0BhLt38+tj8nbqxys16DLUu+oOH86Zosy4+pAJ+8
   g==;
X-CSE-ConnectionGUID: s3FEQpOJTAiVruBClEhaLQ==
X-CSE-MsgGUID: /+Jexa0ySiGXyp+hjxPfTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38280940"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="38280940"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 19:49:56 -0700
X-CSE-ConnectionGUID: dnmOx3qiQ5me8o+yWtVwjQ==
X-CSE-MsgGUID: DRfqF8SEQGSa8gya8sxE/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="76207153"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 19:49:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 19:49:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 19:49:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 19:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3p/DLJVvY+2aSsWf50qsKZQcvRIDoNoEmjHIyOAjjmyq2rqFMGMD2srwDrmIGDPqUkssMVJcGFTGz2MTzXeu/iU+9xLDN9sNr5Q63mfAUr57FZuhfkO3UkALW5bS9kpM9o8t791p00m54UhaE0zOHKC4gmycrFEE2DjpHMPSp0QqTxTMKvIghgbmNgtpX8tkRS6/7lLoUziDrLjF+I8Bth9TVeP9kYRUStizM7lGP8+FP2CbKdNUFgJnMFrUY/nps1ATa/Bf3NkjPyUBW5pVyOWG60msTUzzjLeV5rzVrbBa0whklWdNbj7lzAz6KNx4I6JI5bv8z9WeY6TlQoHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc5MF/jVokHlEHh8fVZHMFT27rWfBUAT8DsSnZcbhRA=;
 b=WmfNjq19czfZp2auKZqfth3y3FFBtLumZNJSBCqpQKFlA+Lt1M8ehUsKK6cMS1ZuWVCbfPETu9YojEF5yQ9J/TiKrt4CgazfoGcX0gYk2tiy/SOz1ChjZA6sQ/Gai0ZNv28uDiqXK1jJLVFS854YpsSZ2TbI9JzQjDz9BALlkVS3DaRVal+M35a50ZpcDG5EE03QZ0o36Ra5RVAq/V54FdRdhCWAOyAe6iTl1gOkNMuaSpKEWU5L/elcMWqPv6wuxS3keIbvGBFM096O040YDfdq3o3MDc43z1AACdHUg9MTni2Ss6Yl9ZfeETZvtUOvEiPOpF1s8mW2K6Snk6TUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 02:49:53 +0000
Received: from MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::91f:4bc5:f5c9:ec7a]) by MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::91f:4bc5:f5c9:ec7a%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 02:49:45 +0000
From: "Hall, Christopher S" <christopher.s.hall@intel.com>
To: Rodolfo Giometti <giometti@enneenne.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "Mohan, Subramanian"
	<subramanian.mohan@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, "N, Pandith" <pandith.n@intel.com>, "T
 R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>, "Zage, David"
	<david.zage@intel.com>, "Chinnadurai, Srinivasan"
	<srinivasan.chinnadurai@intel.com>
Subject: RE: [RFC 1/3] drivers pps: add PPS generators support
Thread-Topic: [RFC 1/3] drivers pps: add PPS generators support
Thread-Index: AQHbGYkYbfgrSGS2QUSKNsWd9GaqerJ9mUuQ
Date: Wed, 9 Oct 2024 02:49:45 +0000
Message-ID: <MW4PR11MB698415531AEF2041384989FBC27F2@MW4PR11MB6984.namprd11.prod.outlook.com>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-2-giometti@enneenne.com>
In-Reply-To: <20241008135033.3171915-2-giometti@enneenne.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6984:EE_|SA1PR11MB8319:EE_
x-ms-office365-filtering-correlation-id: f101ed5d-176f-456f-06bb-08dce80d0877
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?7KwHuynxH1nAarGDIKyhSMoo8pAfl9rnuFeZo4zHwf/URdCm1intKOF7HcZk?=
 =?us-ascii?Q?X+uMcjhIZjMBvlalTKjIgRTmhVwng2c/eybOZJEqOP+D5r5nkyc93J8pctgY?=
 =?us-ascii?Q?2g29lwl2jop8MWG5Ob76pJ9MlBPKR4vvrKkQK3gB2WD9ENJCEfa95BqkNd8K?=
 =?us-ascii?Q?7jzPiylRVdfk1xSoxE4DRh4nchK1PjYUPmf+C1JZtjyvp44NV6YSw8IAOcma?=
 =?us-ascii?Q?/ZIQ2KLauL/Nq4bbi+4I1lVEojXYhfCebrdiSwCSgNZ0U9OUrGSAgGSKTn0X?=
 =?us-ascii?Q?K8saV5C/RNLrK7ktQrmSEaGCmboe1kFRp9CJMkWrie/5ERKPi1VAMoMtQkGw?=
 =?us-ascii?Q?I7dizCYmrYiZk4TSyDcORM83n/cCX8GwxKUcoIuRg4/TaoKGd78jwpG/TJ9s?=
 =?us-ascii?Q?I5jDtLCQh9Y1eBhpJFQX1BQuJLySYzZuptt25pWyZUl3C7XKO0x2APiyRcoX?=
 =?us-ascii?Q?OKVA4vDkHY3V6I04ood0WCF20udVTuhJY+YRMh6vvlsQ6bZIn4eOkVvqN/cf?=
 =?us-ascii?Q?Hvwo55vWveIbvYGlPW4iiSlNQvKoxhjcKO8gtXmZNcad+ZgqV3oB40ec5g6Y?=
 =?us-ascii?Q?zxgl2+/xI3z/NiFOO0LuHxfnHTRrmiAofkU20WGwmRhb5Qot+XzRI+v5F/XM?=
 =?us-ascii?Q?aMSk9Ev9SOLZ1M7vIId/L+VrbI0LbBP1kd16NFJIyDTqvbsgYmSrUwBznu8F?=
 =?us-ascii?Q?h2VrDqpqlPLbFrZxq4vJt6Q+goIWuWovkJzLVeXpM0ZYkDNqadrYtPXml1iq?=
 =?us-ascii?Q?9f6sJ5F5F4Iz467NDL/9/KvmmqirZHy9EME2Gn3M0fQB2MrdBH5TyrohLAOd?=
 =?us-ascii?Q?leYqRkZA5WKt7uoZLHcdkIT14BIJtWW4oNhdhV04jFmnOkYS13HT43/hiGWm?=
 =?us-ascii?Q?H+luDKvwiqdb5qHu6IZwdLloZVXvCyMC505E3SOawMLPSnW+doxMeJFq6KPl?=
 =?us-ascii?Q?WztnopKBUguNdXV4SAV06mRfzh8PNk0WPGLK90YM5vpSt47IqHSWEUdqEMWa?=
 =?us-ascii?Q?EIjvCMd7n+beSk7Y4Iidgc4AQGe2a0NC5vwQuvQvLs6m6ZS4Rw1oHUCLWjrQ?=
 =?us-ascii?Q?xJl8OU/HIy4kpL1SlAJVJBefuQ1FsPgPBClp1UgoEkAp7gZJApe9NEYJAAM/?=
 =?us-ascii?Q?qLkl4BxId3gYY4ZIx9yJzOFTbO9nctmy2dtVqIgAdMyPrlOCu1gwZ37LujJ4?=
 =?us-ascii?Q?psuXNT09Xulv/ZbnqAXTFvYHZ//eSR9MJThn71V6xshFd03BSlF4vWyBldAl?=
 =?us-ascii?Q?o1dYAtQ/LTdOMam64oSzTnqrlWKjkzk3ApnDonmYw+U+HMetoG9mvcg2CDB0?=
 =?us-ascii?Q?G3IOYTp8jidNHuFdyH38IJJpIaeqanLYXrIXfkXCQld0nQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IscCYARg9jaK/qz/d9a1AHZgWuAq/JwggHKpMu2G5Ed8XKg+APQ4neRgrWW8?=
 =?us-ascii?Q?h77/kLpbNuz0wLcyip6WK3p3Bm8jZlER/56H9JD+uc0cGWppX2vngLDohSBq?=
 =?us-ascii?Q?jFv15PnkHxaknI2QR+ccGrU0GIOexK8mE4G3S4wV76to8/WGyZWENmRJSI6c?=
 =?us-ascii?Q?zXqblKsJc3hJ2BZLfEICWzUvYA4wawy558jv56UthLaUh6qAAv0w3iZrYNEq?=
 =?us-ascii?Q?WpctR83p5XD8swl+X8ToTKrMJnA9pPS+yGEMkzY4xAtem5dwY93PEUYE0L1i?=
 =?us-ascii?Q?xBPCxPyufy2ZfULBX6/u8lHhxUYjAJDIwY9oV1D/NMsxD6oY/gi6+bJpBSp1?=
 =?us-ascii?Q?0S6dQ9k3iYL34iae/jOHRBhTCys+lC1EnY8WTn38lWLiG4XXFyEmToTbQ/sw?=
 =?us-ascii?Q?qrnNXEZlVIX+E7i3P1pfrf4bSKgLy3uVzS/SF+uHnKwXlBE1VsxtAaVP2PkH?=
 =?us-ascii?Q?fTknk5gpUKVQzgMFRNSBYAJWxhd3m21IQGOA1GFUz+EyZCp8COd7Zfk73/8X?=
 =?us-ascii?Q?yGk+fkBMekFUVOBWOwT01os+aONDoc0VZLhBIkaU6KkIhFWRcKwH5W9abKKJ?=
 =?us-ascii?Q?myWcpBWEY1ax+5MSWO8WNpzQeCl8V5zY7L3i132UFPF23MeppcEkugOTIPyR?=
 =?us-ascii?Q?2ABSpZiB3iGhcdmS9iiNGN6hvx63qcMv4CzpwlxRdqK+W3N54h0tqQe/4jjk?=
 =?us-ascii?Q?QcEogJOjBblstCIJlTWCTXqqZ/hDYW4NgyAOP+U2LLeOYzXM5/nVRvXSRQLQ?=
 =?us-ascii?Q?6WE99BehEAX8WxEBb5K9do10aTjfcc+RHukfj1t+TvtpC8qksCEvEfeoohUp?=
 =?us-ascii?Q?LcjxzZ3QDWNjsg44BWg+j8IwU8XN0yuZvD5Z7VZODzPwSnUmy69AbTLtFhXj?=
 =?us-ascii?Q?vkvPqp9FXW9J2yWf2Huhk16pNvXr8uWNHISOYA31mgoQl6pAK1tRBBuW5heR?=
 =?us-ascii?Q?MuT3HhioH0n12Vhh3VqG/Gp0c5899FxBGNEBERw+dqMrkI3glolFNdP5hLzm?=
 =?us-ascii?Q?eXjQGP/z4gGl6Z3UiFVxdffrLlgnHkCna4GeTLF9tOjJJgOqYc2mRtLqZP7n?=
 =?us-ascii?Q?aIcaJ+RKhJV/nSckqZvXTqBVPiJFkrDU1JvZxSohyDdn37HWkbyBFBMuxjsq?=
 =?us-ascii?Q?PpWDxNBLumNFV66NHHUMDuVFn0Js1YuTfJTxm7CHWPWS+/8uVVFGyvyPnRqD?=
 =?us-ascii?Q?T5nCYQ7U4babnDCNWbMU5OCgpc5ec3oZ7C+jXXguHFt0fcT+sE6IttjZxlXJ?=
 =?us-ascii?Q?dANa26fFNIOSJMeClIik38aFCtGgKULOPzDBMQ7QoABxh4xIqIq7xibdb/wX?=
 =?us-ascii?Q?0ndgJEtuXmT8OsZIHnnkdIEgWWzp+Zs8z3RnBXHzkf35HNwQkcVa+HmKDbO1?=
 =?us-ascii?Q?Xs1nKRLAnxiB6tRrZEc84tcube7D6aSsEWH+Bvj5TeTyc9y+erNnRy1tR3+o?=
 =?us-ascii?Q?NyipgTFJ0C5nuoCKQ29M+FkErW80QEL7p/8BSq0tLEXTqk0Pfi0t9fVHAN3u?=
 =?us-ascii?Q?GrNqUflbj82O5HMDvhnlWwr0mnh5qtIuoV06eluia0j5lLQBs2SN5fWAMS5s?=
 =?us-ascii?Q?uQ5gYMcfTwe5C7BCQf7eFVg0hL4/7WhpUaMpv8UkLLaH64z4g8jmyXaDtXhq?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f101ed5d-176f-456f-06bb-08dce80d0877
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 02:49:45.3960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1Lz4WLYnSAVVwQdAFqNaD9VXRRm/itO+3efVDaIr+EtRvvvGvxXg1xkq0jhR6BxTNdgOv3NP/jbsiESNu/q75WUGUkNN1ahPQgrL8DQ3Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

Hi Rudolfo,

> -----Original Message-----
> From: Rodolfo Giometti <giometti@enneenne.com>
> Sent: Tuesday, October 08, 2024 6:51 AM
> To: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org

> Sometimes one needs to be able not only to catch PPS signals but to
> produce them also. For example, running a distributed simulation,
> which requires computers' clock to be synchronized very tightly.
>=20
> This patch adds PPS generators class in order to have a well-defined
> interface for these devices.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  drivers/pps/Makefile                   |   3 +-
>  drivers/pps/generators/Kconfig         |  19 +-
>  drivers/pps/generators/Makefile        |   4 +
>  drivers/pps/generators/pps_gen-dummy.c |  83 ++++++++
>  drivers/pps/generators/pps_gen.c       | 283 +++++++++++++++++++++++++
>  drivers/pps/generators/sysfs.c         |  89 ++++++++
>  include/linux/pps_gen_kernel.h         |  57 +++++
>  include/uapi/linux/pps_gen.h           |  35 +++
>  8 files changed, 571 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pps/generators/pps_gen-dummy.c
>  create mode 100644 drivers/pps/generators/pps_gen.c
>  create mode 100644 drivers/pps/generators/sysfs.c
>  create mode 100644 include/linux/pps_gen_kernel.h
>  create mode 100644 include/uapi/linux/pps_gen.h

This looks pretty good to me. I would like to see an alarm callback. We are=
 able
to detect a missed event and rather than stopping inexplicably or writing t=
o the
system log, it would be better to be able to notify an application directly=
.

Off the top of my head, something like:

void pps_gen_alarm(pps_gen_device *pps_gen) {
	pps_gen->alarm =3D 1;
	sysfs_notify(pps_gen->dev->kobj, NULL, "alarm");
}

The device is reset by disabling/enabling and this resets the alarm flag.

Could we add something like this?

Thanks,
Chris

