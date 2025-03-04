Return-Path: <linux-kernel+bounces-543227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB609A4D2F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5EA3ADDF1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7351F4736;
	Tue,  4 Mar 2025 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4BuHsV8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC309194080;
	Tue,  4 Mar 2025 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065946; cv=fail; b=GPQFiTPc+L+uWNcmsVyDKrpn0iPBYGZ6AXzqtVZT2hjo4h3OMG+3PBPtb3mNMYtKjqBoksy4CkZVUfu8qlNkD/CZpO7NO/OiOWwhzs948ZLzPmNk8BgNcJZJn272YFPY6T8H7mgJ4a+UFLamGROG+nQy764GkLlNpgj8qYEwc6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065946; c=relaxed/simple;
	bh=k87xWYXnk5nNrhS0/YrG5rd0uVPvMrL3XT5N4yen084=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psTNc9Tuf3Tv++ijbZk5JWpQZsS+vsYJgecuUlPODad/weI9khThiof8H3mL6cPJvcUGbOf13AEdc/5TF13Fu5z4IoO5AhxEAcn99LZtOjx2LtRLcYl25KPM1AR6f6SIOmfcCJXT8z3gD7grrx7qLQemTcyncOp0QNxTxLqPPps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4BuHsV8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741065945; x=1772601945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k87xWYXnk5nNrhS0/YrG5rd0uVPvMrL3XT5N4yen084=;
  b=j4BuHsV841GbU2X4nl9i44BxPl1dy+6Kaw/FqUzaL0mhf5MFMb7WuxDe
   g67uZhuSo0NSoNRyw2lj7PEvsqh+xXylwExO+pn7EYD9W1AwjJeP05i0G
   mFpeJzSJEEEcvGwiMo3meX5WgwswxutPJ+FfGKLy3qnd/HyOh2SWj8/C5
   x4+0hyaqCJgPkTmkT17Aqel4cQ358OEhjiH42mpd7NMTAUOhVzngvT4fQ
   fUNu1i9YYecTX/rXTxuteXAxGdi/f916E61USPKKIrG4cmqW4Mugv3IyF
   toPjWVwMlyrK/Ewb8DLWndX/vO5pSCARtecplPx9MzdFJGK3ACb2W4vUS
   w==;
X-CSE-ConnectionGUID: rKf+n5LwSxi1sJKuBDYDHg==
X-CSE-MsgGUID: e5G1K8mbSoiyjAoHxak9aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="29554442"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="29554442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 21:25:43 -0800
X-CSE-ConnectionGUID: q/uEcCoLTR+VPJ7ROr1GPw==
X-CSE-MsgGUID: xcDrC6+MSuSTbZReuSxL6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123386140"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 21:25:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Mar 2025 21:25:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Mar 2025 21:25:42 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 21:25:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw7UBvG0SbBmRoWXqhvEyAgmkftglp4rV+pxySmR1i2R600KscNDgq3enuan7+o+imvaBDlstXQ/6V9q2NliMfc6yAdiRVV6Yr6b7udJYeLR9Qk5/FK1bIEA2Gej2VxWbDKUjmxxgMYFPpQ2BGWMVbIn9uUYSvtRJ+FkrtkhPNBAzFeoGBB7A77HISIIaeQ3GzQ5o6vR8ir+Qr0hBuGQ0Dy38Ic4H9aAh74Xf+ZHvSAZJgoeUWZy1h1dryLZrzPDKCzZk3HHQZmPdwSMruWsYnB8STaEFPwUaWzA7S0Psvqc3Ndb4Tz+Nw8F0JJvec1bi9FIhftAwsYZYCwiKSq3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k87xWYXnk5nNrhS0/YrG5rd0uVPvMrL3XT5N4yen084=;
 b=YGj0Ix+XfAXA0pNdba8nY15uNLnpG9PV6Yid/0w0WN1ZsZn/wfGYwt//rbBTGvvB8tXhMnwVMMaqpNYZ3xMAresBTrpM2TnyyuBQ4ZFKd8M/0xdBMc/mhu0bxwCN6CDf2rgiTPvNBPbZCqSo8Us9oxZWK4EG875OBNu6PHmiQvDFcj6UojVZq5HEuN5tFdRkPz8O7Idhs+6n9ojI9Sj4+SP2TkQFY2nikdM6+BWO3q0O24DfAWWjikZxCtlwPMVV9uHz9fnWSTHMOddeg+08bFk3keAsEgzZbWVTihHMDIlhG6gNQwm0JQEzumyvhXcPCA+KA5S95M16sEfcPb4yAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 BL4PR11MB8800.namprd11.prod.outlook.com (2603:10b6:208:5a7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.27; Tue, 4 Mar 2025 05:25:38 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 05:25:38 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Ang, Tien Sung" <tien.sung.ang@intel.com>
CC: Tien Sung Ang <tien.sung.ang@altera.com>, Boon Khai Ng
	<boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbdhhxthJ4AiCvMUCJLGSIXsfkL7NinvBA
Date: Tue, 4 Mar 2025 05:25:38 +0000
Message-ID: <DM8PR11MB5751CB62C7A68840F9AC7F9DC1C82@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
In-Reply-To: <20250203084822.18356-1-boon.khai.ng@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|BL4PR11MB8800:EE_
x-ms-office365-filtering-correlation-id: b8579b87-5b3d-4110-23fb-08dd5adcff9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Vt/PkdS34A/NyWzs8tBVbC1N0a90oz5amuYRXVjo/5jlrBy/zKEYojHUG9cz?=
 =?us-ascii?Q?+6rw94jLAGjcrFPcFc+hjTxXAA70e/pWck8VQ6412tINCAL03Jba5bpb9f7n?=
 =?us-ascii?Q?VxPNgtI3dbglPYqb3QBCIIMj1qLjK/WKPTIgkVZTMQL3wfRwlYwg1Uhi3854?=
 =?us-ascii?Q?fppkE5hU+nVR1zBl3H+zfdqxeAZlnhed5cLxnuxZkSn6WlgXSauOGnBBFu5C?=
 =?us-ascii?Q?mXLICSxmrsExJ9l2QSuudfqlBYAGfdPPXF5ZBg7/5JUNNiXfgCRcbDx76+pi?=
 =?us-ascii?Q?Bq7RW8T5ISEc1wMkWKg+ukLNzgO2l0+JKxS3Gbg0AvC+LQq8EkVqfVRoWH9f?=
 =?us-ascii?Q?98xyzwr6zeeNd5ey99iWj1VZpEzBUA7O0nRDGgOc3zqriZgzqJqO+vYZptQT?=
 =?us-ascii?Q?kUv/TU+P9AAlNMTb6taEyGZ4ZybFIRipjMJVFBEZfZMgpr5e9HUQojsjx4Sf?=
 =?us-ascii?Q?wSaGkHDTo5VO5Q8Riy3R9VgmCtlp8oBLnRVDvLSlMosbPa1zp5AlHM4pZH1P?=
 =?us-ascii?Q?qruwuWCaWi/+v07TVIXnJ/4WN+GqsQy3m5hTBDwHwgQ4foUM6Jmkcth1DCFB?=
 =?us-ascii?Q?m7127a6A+RB/v+yqvlGK2Md4kkJcthPmAdP5tipSk8o+FnHYBUwjXtHXrXMC?=
 =?us-ascii?Q?QhdPxLZPvKPWds1C/86hQM1Prr+ZrIcPL86Kx9F/LHa9IErfLMRPxcFtDB3X?=
 =?us-ascii?Q?/kJEaGHnFQhJlLpIx43/4krYFILIP5uVAt7EY6cisQyCnF+zqor2WYAwOoEK?=
 =?us-ascii?Q?JfY6CH69wEMQjfKCzsknKAu+HPOec4sAkQbH6lhkEpUTAMojNxMG62ZxF0cP?=
 =?us-ascii?Q?4/n9zpzkOQYF9pkrw/q+pWKiuZepemfs9iz8o1ixTgqKgTT0JIttuKLWf+zt?=
 =?us-ascii?Q?uk21IT2swEmbDcflNAihI1HWfDquEH4Q0vm+PR0g2n0ALhlB9yLciAqfV6rr?=
 =?us-ascii?Q?pbaBri8FBrGVeO+5Tf6diO/F7JOVWPaDEnANljkSar1k6kjwXohigldoBjbn?=
 =?us-ascii?Q?BgGVUi9YLGFWY7XjmoFj1J2TIKgJz+66rgK1S1X5uBn6hVFpJY2tONHg/FCr?=
 =?us-ascii?Q?OCVeVp0J+cTiFCntWeL6rj7GJXX/HhkdkmKG/7dW3mtZEc6xXA2IjX8omeOm?=
 =?us-ascii?Q?7gIpARtUEqwSsSgnSy08jhkO9dI3A5vbTNZ0eiF0UEJOkvdgmMgnurAFFohF?=
 =?us-ascii?Q?PPSrPwm4FwTH+MU/5jokidqTmxD8ozESlNWY/5lMOAvW4g5gan7aGqvRMJLz?=
 =?us-ascii?Q?rhQYCXdp/h5fliE8CjjCjGxFXKV8yzjX3MV7TZw+FR+RiHKhHGGJ8nHKoG+n?=
 =?us-ascii?Q?BNOj9cPaY9JbSOHug/KfsDliZR+hiDzlTytcbJc088rhDGHYw5LdCspwHRtX?=
 =?us-ascii?Q?1oAZXOeODdxKS+0qBXfz25is99KYstPyrfsWYqnnrQEeLW5MPvNV90wHXak/?=
 =?us-ascii?Q?/cMXMTISYu1IoTPuBR9uV6l97KrEe69g?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IEpoIV/Ic4XU5oMFRI5xl6Dtfi5rdslBify+ktEDbf4iKOcC/TnH5GgM0qHK?=
 =?us-ascii?Q?dD6+CbGyt1GRtRwtkbOBxZnx2D0craF3nA/4yfAWXG85eGR309hnyVBIrilP?=
 =?us-ascii?Q?zVbpjOKaJVyfUKOqgyT9J1wPoJo6mOj74ibRnMbbxFkec4l7cDHF3grfX46i?=
 =?us-ascii?Q?gMVmQIUZC70FMEpfPLRvnjGy4trocqgqdxOUHWXTpaW+0rFvHk/OdXH23CXT?=
 =?us-ascii?Q?3dIq1uBtoYgXDYolYiWU9mhYfVfSUfZIpWHjfcmeNxfPt6dfqjYsnm3WGlgF?=
 =?us-ascii?Q?2Fr+6WC6XwzMMewBJaczX1KjpaV/reLyzqfVsG7ZvBP5BNbOzyBeG2tC9Bnp?=
 =?us-ascii?Q?5rUwactaMViGKpv1lYn4RymzwA5gNmWhAHu96fLv2KCzXatXguvxEQiQXB31?=
 =?us-ascii?Q?4cbGhdftEQRDByXle39+yTQ05hEKHQcwMrw70FOHxgnqx6DSZ5ow04NqiRHs?=
 =?us-ascii?Q?wKp4uSfN9W5YZHVTusx0At7YuNxWI74AN9FG9OAmpXvEVo3hBpvV1IYEgIbM?=
 =?us-ascii?Q?sw7B9R1AZBe/TlMV6SRFFZvhzCpDFKNJkE8hjzXLwAdioEMTbGn4bpQ9wV7X?=
 =?us-ascii?Q?ucQeUC74yoUc6tPUwR5dSq5doS4VPCiXwf0Ic8JcIVxatvzatRRRzh0E+T4D?=
 =?us-ascii?Q?18qRjnKeUSW1YIIyII+mXSwn4E6wKqiF1vPSKJRbNebXLrd+EPhcBJ6gnKaT?=
 =?us-ascii?Q?Rsq/FEC2Zccm0tGNj9n7bGTrMNMvoUYUaeGd5nqWF09tjbSNDkWYT2rVWYed?=
 =?us-ascii?Q?wMiPjvSD7r1io/LVjxyqEzG52zlS4KZ50tu6p4yYVDznVOQhSqVkDnc3UzCi?=
 =?us-ascii?Q?zGL2PNOgPkVsKvV5gvh10Iw3HwlDBYqZYh/ct58C8Op3t1IyYzsVN0LNLP76?=
 =?us-ascii?Q?K8LHf1eUaEAdCu/ePTS9Szzl7K7CmqTQxideXuA8M1K//IKj1YScW9SUIMiW?=
 =?us-ascii?Q?g2w+RcovC4jf8/xKyLjwAAXSiAEbA8NHm8IyyMLguA9+I85pvh8/4Yv4KZFY?=
 =?us-ascii?Q?g2u3duLWdtmj3Azv576kj7iIW5hUnXA+MnNZqpG7HFs0SPazIWqjNNWF7g4L?=
 =?us-ascii?Q?Q/OGXTn9J7JTCuFktklQ92yShmR/fvo8dKFNLylXNAIjWW6zZB390oFVHbWR?=
 =?us-ascii?Q?Mk/nfDVpXi9OHR/9fdLnEj5Trp10u8ZAYk2bISUGzrv9YPagzDFaZ7FluUc4?=
 =?us-ascii?Q?O+fTNjhW8nXfSZtD1TDUaCP3ffhfRjduQy78w7jYliC6mj5/PLa6kZzfX6F+?=
 =?us-ascii?Q?HBrxMhj5OKetUyLHMyUIC2R7IUaVKnk1uhtu6Xp8/vNlrBda7WDRYO2HM0pw?=
 =?us-ascii?Q?aPPB6i9qiAVeKs9G2I/JrOQKAIQMoKF31W4q+aHYfhJnDcTH6bzRTVAkaOSS?=
 =?us-ascii?Q?3SfaT6bhHbykqEN1fb6gOZbvelqOu7LjKzur+DO5+I7n7HpQxstjs1Vh5fbj?=
 =?us-ascii?Q?OIaI45/+epAiYrvGxo5O0Nql9ZkTI74+WIKDX2F1vYVgdYDPyXzjQMA6AYqi?=
 =?us-ascii?Q?ynKTP0cZUYevkzAcsXoilDw4qaBTA6w5LcpPZmj62Knw2gaPGvKVsU5f8huF?=
 =?us-ascii?Q?dwRQYXBRVmI/Kssp1jspoqa3CaLGO9jICdLSxbTF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8579b87-5b3d-4110-23fb-08dd5adcff9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 05:25:38.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HL07BIefEMBs7dAtQbSpQhvrf5/0BMOgQ2FJOF6EmrWJZmudF43K0W/+N3K7WqsjdqZ/EhwsvsgdnGicvYFl7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8800
X-OriginatorOrg: intel.com

Hi Greg, Johan,

I hope you are doing well.

I'm writing to follow up on this patch I submitted for the USB FDTI driver =
to update the VID and PID about a month ago.=20

I wanted to kindly check in and inquire if there are any updates regarding =
the review or integration of the patch.
If there are any issues or additional information required from my side, pl=
ease let me know how I can assist in moving it forward.

I completely understand that you have a lot on your plates, but I would app=
reciate any guidance on the next steps to get the patch reviewed and potent=
ially merged.

Thank you for your time and attention to this, and I look forward to your f=
eedback.

Regards,
Boon Khai

