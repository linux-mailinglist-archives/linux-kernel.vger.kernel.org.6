Return-Path: <linux-kernel+bounces-543627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C6A4D7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D96418852E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75F1FCCF7;
	Tue,  4 Mar 2025 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+N2JYFM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61271FC7CA;
	Tue,  4 Mar 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079672; cv=fail; b=tMMghiKaQrQlZ/eG1nU8knW1llbLDd/N2S90IEOTtFLIkhOVYAn2KaXguSEXbSWjzl9lSqNgKS5tqcHfDO8MkaGaNbams48lUYLTDpTE/nVLnfFD6itSahV8ak9hvgbkh+6BAT9AF84pgsa/VeSPC/nY++LJvIMvyLWxvWRGxu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079672; c=relaxed/simple;
	bh=Jgvk1JO8Aw2IZMTYao4iKplkX1vhaQMdnpS3VrOKhZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDeAN5E4OVOLVoZcrT9RYYNSL+gV4Oi5CZLs2FQQl+huUh8SSfiZk05j77Wyq9xM35r57l8icytjTJjspWJX9vYIQ68HedZm4v79QmGGV/mAKJUY/g9cnF5VZMzqVxtBcHL9h7AcVb4hP2TldOjtD1vnbf6AYqCWLHH331q2ujA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+N2JYFM; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741079671; x=1772615671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jgvk1JO8Aw2IZMTYao4iKplkX1vhaQMdnpS3VrOKhZE=;
  b=m+N2JYFMEjmfyDsKjkKoUM0BB78OvGwcNqjeiSbREW925PjpT/HkpPg+
   C4sliYLo/7PbQtILdJMn20nefLfuYqJV6t0vFiAHJky9xu7hg22CxH+Zf
   qvjECcew1bH5fGdlQ//ja2yN+Ec0Qchtq0rE1W1bWuuL3ZztHvNE1xGlq
   e8gqkCNg3oWFzYRxA1LYc1NgogZqay3eqKN1BBp0stWzyat9OtZxPpyK9
   kne3GWpCbJiWQZ6tRqSlC/NPWfKIhdvbe8QYdbZARoTonVynC44UFnt4X
   yAEx0XmNvCayaZP1zA4xSaZ9hbe5UR0dcytwz9JuRubWqBKp1bM1rbKdH
   g==;
X-CSE-ConnectionGUID: sKRjeCOXT5yVMbnspmMMVw==
X-CSE-MsgGUID: x3j5CziDRlG1OYBVLdDqGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53382670"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53382670"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:14:30 -0800
X-CSE-ConnectionGUID: Or0BPldAQaukK839cuwBQQ==
X-CSE-MsgGUID: 83sKqBL3S3GGE5J8fVnYMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149248187"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 01:14:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 01:14:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 01:14:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 01:14:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izDZ9Qh+8XmPBO4l+KRzwp3oRDdcthaSxJGFHNB+YDTh4L2O2h20ZcMVxwckDOUsyEH4q8EsPqkOw/eeE/4/Sf37pobFpxaNS6wGHOJBQaTU3YHRSZB5ZSIZeKo6S7Xjl6rzCrKUaZUaOz78qE4Du9GEbg8p0J5Pvdcj6ojgMNpNtN6dVItldHLBdF3NYtbyy+W3dfdH5PbjfVjVznV/8NQ2GlBdQC9iLvI2koPApgkE3wN0erEl0EN6xXBBxnZixGzKibPHYLj/N1UJ4CI12lWQ5dIhkIDzVK5iIaro9yTwrvANrdlQsVY1624NliXQV9wgj6VpTjW4go+PdBCLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgvk1JO8Aw2IZMTYao4iKplkX1vhaQMdnpS3VrOKhZE=;
 b=XHaahj3OL3bCI/GuL/L7Jhkg2ukN36P7/DBjXvk94FblaEnvKjTQ3bgHw3n3yRlAYgatOYx50edoSl0IOOzxhs+HUix4l/rQj14KyQbnvn2Vc6Q+u9uCPwvIZHhV2H6B702fRmcKzfQyf7Wo6hQxXm5tyU5Kc+yeqG0SIjmX6YUMQ6HfbdErw8zujAXsJ/6N82mer6mTHkmv4Qn2+V88Bbdv0GKb9RVDkohaqOGEGVx1epyhG1nbK434XEDFR0+hdk8DKT7NodmM1Iiv7Mz4sKfMNHqKcScCayjCdSVmJHXKuF2WeZtDzPJvj8i3vyTcpnVVxhBxGpxuxpTW0C0CcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 SN7PR11MB7973.namprd11.prod.outlook.com (2603:10b6:806:2e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 09:14:25 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 09:14:25 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang, Tien
 Sung" <tien.sung.ang@intel.com>, Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbdhhxthJ4AiCvMUCJLGSIXsfkL7NinvBAgAAClwCAACCFAIAAHKZA
Date: Tue, 4 Mar 2025 09:14:25 +0000
Message-ID: <DM8PR11MB5751E055858DD03432B36736C1C82@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <DM8PR11MB5751CB62C7A68840F9AC7F9DC1C82@DM8PR11MB5751.namprd11.prod.outlook.com>
 <2025030429-saddlebag-acrobat-21d8@gregkh>
 <Z8arxlXNKF45n0Nr@hovoldconsulting.com>
In-Reply-To: <Z8arxlXNKF45n0Nr@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|SN7PR11MB7973:EE_
x-ms-office365-filtering-correlation-id: f61d5242-1e68-477f-7b5a-08dd5afcf5a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?h5c4Y/1E6X2jPlndWFYypNdW8VVm4wAoT67kEN2Q7DgpmSJbpKo05psPt4rj?=
 =?us-ascii?Q?E8FIo+De3HcRt7b/SsDS/SOEvq12yb5tka8f8jDCdFi3m2+gEat2+QMttpCp?=
 =?us-ascii?Q?ZByw6W2T/O5KA3wPMV0TwzIesiGcH5teOORVNr15H5uGUIum1CCfgEtMQQP6?=
 =?us-ascii?Q?BGNRYxQdBgOEI0acpfyl8hpD+attQ7tIlm48B/KghYrSWm3hHymXRWhZBf6A?=
 =?us-ascii?Q?QGk/crRYnlPXZU1i5faNeJYR1hdoftqG+wiFLN/zNVm236xc6ZATEWRK/BXS?=
 =?us-ascii?Q?I2G2F0f9CNki3Q9SJUCwGPvJAxcUmkQwGmPgr58fDxJJbHoGeE9OZ9Kj1vaV?=
 =?us-ascii?Q?sLirTvhuTwmOWQ975mihVoBEAVWskeF0JnrLLy0NEUvu8l+V7r4ed8oxGtxm?=
 =?us-ascii?Q?bLWkBa8HH8lkbUulgFzffiVeixIHYN127dQH00XvbFyVVDERgr28KDB5ngJW?=
 =?us-ascii?Q?mr7MfJSoh4D3+NDJI8SLnbgAO6Avbz5uwUazHABbtE7CHnKAs3hs01pqmk2d?=
 =?us-ascii?Q?EqUS3y4ByAGCjPMTYXyB31UkLwbid7QqwxdbmlyQGefG0jzfdDMXmenw94nL?=
 =?us-ascii?Q?r1Dm8vMj9Ik7gP6Q3aFhazYMimhb/rRSfXlLhwS7oylI0RU4iDmNck1IK4Vq?=
 =?us-ascii?Q?z+ldKbN1gnorLKyuxgQecVwbvkwVyeyncsHqiVcsRl7XsSq72ekURKlWSTRo?=
 =?us-ascii?Q?R0XfbxV2WsjfCUp0cn3RqryFIMzvJD2vUmPVUBWW/L/1ye4c8EodGr6g1prN?=
 =?us-ascii?Q?c/iw1MxcqvPAG329rFxs6MbM64VsiW7jRrrKhNbUI7x8EirvC0A/Mupu8NQp?=
 =?us-ascii?Q?fUjpquZv5XP6JrDfPpYjSkVBuvRGByd9GoLAUgcpxbIQLYeD8NtCtvJBIBgH?=
 =?us-ascii?Q?lngofii8efYg8upL8wTlc9lO+1GQeCLmzmuaPVOoHRFFvjxHFXFga/21kR/r?=
 =?us-ascii?Q?LNiQIwy/WR02N65XN79qnnIChyCVWBUy+rS6LMkesb0ZFti85qpnOhXSbLJP?=
 =?us-ascii?Q?BUp6yNMeoEJ9LL5GL8s2w11AlY4TXt2Ulsd35BbIBgVXwADYgKd+M3olkZSD?=
 =?us-ascii?Q?XgwqNlsGCTu34t3PgW0dJSIXQPqpT4QNRRvVqnbrExWLu1XqnzAAu3cFu2Nz?=
 =?us-ascii?Q?3VgzbDTa/h8hGQ7UTgIV6o9Za0gXtKnU4lw1+sPu/3XmK/YOI8WlYuzSPi77?=
 =?us-ascii?Q?UdLFfGen1oDej8ooPSW/0KaQ6wNOGCEAqummDtJqMmHR9jcC4P/7RpHyVhJV?=
 =?us-ascii?Q?s7Qeo2KLoQ+M9ULGkcC05MYH99DYptVgrgrLnNQRMZYqmLsuP6mLuHpianyb?=
 =?us-ascii?Q?zeg1wSCuC+D6j3WezMOU4EZG2IpNEPtMTn4u0ENIJsdB5t3agcW7Q8Xa3usQ?=
 =?us-ascii?Q?97F5OGAwX3ycz9HxrG800/H81miU/Bq+IHJsk0FDhbOWkKVDuUKFACBZZcWu?=
 =?us-ascii?Q?0DruiaTq/TEJuNHMKx0dL+a5iCxrcrS6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cQ3PzjScVHvG8oCrPXY9ubEz/rR84ERhLJtIzQT3gNQt3NSn45Pqm/5m54+A?=
 =?us-ascii?Q?AAZOELjAEl9GkM4oNpGXWSQIN2eKi8etcnUc4mz3+HasGcz2OZJ2YhH572TC?=
 =?us-ascii?Q?Wd0p5DRvti5JhLgBBFJfQXt/8iGPs5HpO4x8P3nyTOt68KQk7FhdXlhp5DvW?=
 =?us-ascii?Q?o33lQTWLrVHugj6afNSr/r6iLOzz0Q8g6KHlq3Rn/5XR/f58v+Kybhf8JNvW?=
 =?us-ascii?Q?UaS9I78rOOtK1M1a01B9jfHaMIPsKQYpP2FUplS+rGnA1l0nr3p5NGDdtDPd?=
 =?us-ascii?Q?+uTCbRUR0J0AoFcmwwnb5LVi49wGHo6erg3CDDmH8LnKlqcZEx96I6fnYab7?=
 =?us-ascii?Q?32L4lNM60u5EiJ09OfvOKUt/6DVXd7f6fz5gWv8/ODa5q5Xl1R1S2CnhG7Ne?=
 =?us-ascii?Q?Lv7Uhe3unV5NJgSyJ1c6u6hKdQWSTJsLQOSvGpPFvM1n0XY3MVHsgAWYRXAb?=
 =?us-ascii?Q?/qLPQeghxMSJVjJ5gdi1rrDMSce8vfbjlI/U6Gg2TlyNvqOzqY7npyTn0IEo?=
 =?us-ascii?Q?Bq1hHFtw54ZkJLpKpj42aWMOQM8OHNMyIiySzTXlEhHh3Ew0QXQX9mNml3Ac?=
 =?us-ascii?Q?BDmhighZGf9cHArdqdK4PQu9xGYzTmUJgBeSGlRfush0nILet9/J2rkKzbZV?=
 =?us-ascii?Q?qH6l18LhF1QVcQNGXIFQ7fwV/MfoEvnbHLvvRctKnDzLAVFob3IRgasHyHhg?=
 =?us-ascii?Q?0Gk5eCQjGR3CalqITiTayelH1tdISMeYUKI5L1JotFuETXz/I0vtxThOrM6X?=
 =?us-ascii?Q?IIl4RTIC5rUSnORxgnaK/yg/lkudvwCexdu9JELEpRcv+bpC3frn8S6dPhwV?=
 =?us-ascii?Q?6I+D14MjSk2SfsnJOzON9yYbJtNbN6MOucNuVHLdHE7Dh+htvMuZnc/bzEtH?=
 =?us-ascii?Q?0L0tF/c1fMZL6AS95ko/9P5gwzB1WGQbwPJTAhuitv24up9P0cJgEkTVj6JC?=
 =?us-ascii?Q?ONWszQKdO1L+idVJ/jkfZ1MWbeXiuu5QP1gaZCo6V3hLn2NxcgJ/JKmXj1MM?=
 =?us-ascii?Q?pfa0v8VeuMejWRIBN/bqUK3a66sEo9Aw7np5wyoAilQdf707p5TYnjxSZVz3?=
 =?us-ascii?Q?TBLiUtPyO0+iskSu3Tj+zlv47OEp6LT4uNkhelACuiiixKZsazQZKMLFeKBv?=
 =?us-ascii?Q?e5N5DsEB471jQvf+eR8iTj3W7ofJJZGTEsZLmeh71LqPQVl0+/ezepK3fFIA?=
 =?us-ascii?Q?hZM3Dsvp4mp/Pm9wtZnnrgCS2/ylMFvwyiIqm3FBq5aIcGbvmlR0yzcdU1pZ?=
 =?us-ascii?Q?4guElkxp2MwA9ka+IvdB2m6PnvWHENxjFZoJufELIS9FukNc/7XGq+fdMVdo?=
 =?us-ascii?Q?mMGRcTu7lefuZzAo1OdU0p8H32dzFW4h9esf8c29J3xwJ62J4qQN32edUfKi?=
 =?us-ascii?Q?+PcC5cfBYZjB1jpbXEGw/nYbCfYLoqFTfMhFlpPtaVmubQNd/o6mntifrDyj?=
 =?us-ascii?Q?rQCDY2qfb9bTq5vwj4ZPr8kXmKKZWEzf9b9ITztsi06k+j9Z45lGoyCay56q?=
 =?us-ascii?Q?FoPBLEWr85bwtTF7ZjNx+QU6X3Llh12/Z1vZyeNrLvcR42C7MYcpP6enFcwz?=
 =?us-ascii?Q?vuw3OIRkrN9jDqj3daeKdFipUwZLlmPkpWc0kSDc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61d5242-1e68-477f-7b5a-08dd5afcf5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 09:14:25.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXpxMI1XkCIV7cokFqHcSXzfEEu6IPoDjMbVukXbK/g3aVpvLC6hDyPzCLkhn9go/RWBXv86fM2v/TpFKbRwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7973
X-OriginatorOrg: intel.com

> Should be in Johan's queue somewhere, if not, please just resend it.
> thanks,
> greg k-h

> It's still in my queue. I plan to do another pass this week so I'll get b=
ack to you
> shortly.
>=20
> Johan

Hi Greg, Johan.
Thanks for the update! I appreciate you taking the time to review it. I loo=
k forward to hearing back from you after that.

