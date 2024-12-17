Return-Path: <linux-kernel+bounces-448554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 417AF9F41B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450377A3EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2514AD3D;
	Tue, 17 Dec 2024 04:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhWIfpwo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1161FDF;
	Tue, 17 Dec 2024 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409542; cv=fail; b=eTGwLIy7CbvemJPN1Ayu1CANB2+TwQHSAeZpJXwRRoiBnS8GHtyUy+lxRZQkINN70Peqpk7/zggiIQFyqLkQ58FVlq6XqjFAJVmug/0v6ShwU1iL7NeEQAiXBauszc1g7CQfmaqSKSu5oSD9/rBhpOCllVyZcOz0OLvYK6kQVik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409542; c=relaxed/simple;
	bh=R10hgSkOip0WetN5eXEfAFWWCzAed98dknFp7fXjOqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTPUNpmkJ17fOy0zpctUN8+Tsveudv8bxQcLII/f5owqwE0lPTuZ0NNP4Evh2ApzozgPGNOdTz0XEIQQdzLbmLa2hjHzYxIxkuo2osqWjp6vxCEKi/dVYEcMk2X/larfhfXy8Q5RhpVIUs6CciV5NUaY0m9XYrJfEAIWsqwdaVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhWIfpwo; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734409539; x=1765945539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R10hgSkOip0WetN5eXEfAFWWCzAed98dknFp7fXjOqQ=;
  b=LhWIfpwosYAJG5CD0Qa4hG3UgvWPqRWnYuwkmkhma7il0paFDHsJnodR
   qxpiZuAj8gUVUcnLhoueyzzy0zrQIHNmUfG/OH6UjqlrdzddGa5NiRb/X
   nmXI8rqwe3jN6kMBEsyK/yOeq/RBCOyEKkHSwbZfO3WlkPjKJkB+RSpRR
   h2RpE7zpfXFfk/zb9/J4OMtLtQtn1lDPLhfGIeBw1ply4kNac4zFuLVVD
   zrzctk5c99sjzg7TOuavYzYibaGse1phiXZrxD/li6qAzQDlB8INw5WVl
   a4SU3YV+0t49Y2EM9gHLoTJQ779CaV8gXcqOZ+TXLlsUgKZuH53JC7QP0
   A==;
X-CSE-ConnectionGUID: R4/G7F6PSkK3n7w9qCADrQ==
X-CSE-MsgGUID: CU1z4hBgQBWKu3b5QUr/bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34854826"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="34854826"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 20:25:39 -0800
X-CSE-ConnectionGUID: fyJlaVYKQCuYuqAGkxn+9w==
X-CSE-MsgGUID: +d1zkI7tSN6Ymj77dwUz6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97872532"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 20:25:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 20:25:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 20:25:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 20:25:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePUPhSdAQDQxpCG9cBEUxPjU3f8oQHltAaPnfGxjHwNAln848ax5U43u8MkDCXdehC9nTlVwPnn+IOQ5Igozgiwx03fr3GpzXxYW2qlRvKC3PUuIYixgUVOyynxEPPMGoLj8/wz0gObHC4z9q1f7oVj11IyX3xdbg/CyaX6hSkrxprtigdvPPftHN37C3baHBYz/5BfMCKQ9+8NBIqie99T+q9Dkadgzbkpm/dAGEZEbAE/Hr7nQKv+ZVNj7qBJeD7G18Y0AFi6HKY6/7Dut08+6FZF/lvPPeXlrcscgJkGEb3IzYH+o5hwYqwxPQUNB24Dv+PCrA1hLginbZSFOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqInJrJTI2YibUxqk62t2P3nHol5421GhdxQ5WK/C14=;
 b=rOj1tURCukAoaA99LUKs6NjE1qyX1f1MPj0CGOWCvN4zOAWNH0o0W+5DAhuczY991jrbmLFdTOOAVhsumunGRjiC3L6OxogCclmyXEqQDus/LmqvWDLEY9FAh8f13TYyFnath213K35dZ8hrQLpNsvm82FiOWjDSQ1ivt3oVBM6YL3XozwBFxXSvrcsL9YsO5VlVC7gnlKZMjbkDNJ14B3XlbCDFqhlH4Q1WEU1sRCns2xYi0/CUTepwXGzsqWZl8PGTrIilfdE5TXBJ3ek2vLEpxXfep0Y4Ehvde3AGlhFkpOlc+f5EMRFsF1UhKtMTREAoWl5qqmnxEotR8lEe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 04:24:53 +0000
Received: from DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5]) by DS0PR11MB7457.namprd11.prod.outlook.com
 ([fe80::6078:57ee:53ba:57a5%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 04:24:53 +0000
From: "Gopal, Saranya" <saranya.gopal@intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>, Sasha Levin <sashal@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Prashant Malani <pmalani@chromium.org>, Jameson
 Thies <jthies@google.com>, Abhishek Pandit-Subedi
	<abhishekpandit@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	=?iso-8859-2?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	=?iso-8859-2?Q?Samuel_=C8avoj?= <samuel@cavoj.net>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Kenneth Crudup
	<kenny@panix.com>
Subject: RE: [PATCH 5/5] usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE
 before reset
Thread-Topic: [PATCH 5/5] usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE
 before reset
Thread-Index: AQHaepn1LhyztCr/UUiE4X9x7MOm+rLpSqsAgAHIMwCAAG6NwA==
Date: Tue, 17 Dec 2024 04:24:53 +0000
Message-ID: <DS0PR11MB7457CB5AE5287EB8D57FAB69E3042@DS0PR11MB7457.namprd11.prod.outlook.com>
References: <20240320073927.1641788-1-lk@c--e.de>
 <20240320073927.1641788-6-lk@c--e.de> <Z18hJM55ED2hYJ6D@lappy>
 <Z2Cf1AI8CXao5ZAn@cae.in-ulm.de>
In-Reply-To: <Z2Cf1AI8CXao5ZAn@cae.in-ulm.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7457:EE_|IA0PR11MB8333:EE_
x-ms-office365-filtering-correlation-id: fbafb6cd-2a4a-43d4-a973-08dd1e52c105
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-2?Q?ta45LeiQLXd5sIKuVvLPz4lAp4sMM4uXTUwTOJK42a5qLdkpSYIEriSGiZ?=
 =?iso-8859-2?Q?jLVtmcpyCf9fZW2heWo/6te4W5HHXB+kHDNqlamsOpPmL8ltt/uB47+uey?=
 =?iso-8859-2?Q?2lqusPGdnThHveh0mTKiXZXD4jOdp5uYIZRezhYzx/F8oEgGyUA+yURcG3?=
 =?iso-8859-2?Q?xkVpjnirvCVh+QUkDg8R42w0TuJr2RGxkm2P5LQXA+w9+LabulBabgRlai?=
 =?iso-8859-2?Q?kIloBiH58ghddApGoUobftTbyHBO0Qy7f/4mjXjJYALrlWqm9Wf2xL3eII?=
 =?iso-8859-2?Q?YWzMQRSUjwplbGDdKRnnDNu9kvUTWViSN8fG55bLia6qABs7GIEdIsPoAT?=
 =?iso-8859-2?Q?KUBU8fJ64SgsOBRr6ee9kvb38MXhtu8vQ5+lOVvP812AhfnK7XG6ATj+3K?=
 =?iso-8859-2?Q?Xb7Utjhr9eYCVC0q7UHSo+FJ03AcxIQHbU7I5d6TBQdjWVSZ0HW8U7NWkq?=
 =?iso-8859-2?Q?/wVen78m6jy46y9vrSoX7DYGswcL3yk5p4D5/MUCvcFAuXlMxyAZqsR4nI?=
 =?iso-8859-2?Q?uv7fZAKynK8wv+9IlwyHUTGlVEetk1Cz1hNq7tQGiq1wFYAtwyT4mO62VJ?=
 =?iso-8859-2?Q?qLFq/EVbK30Z5xxqlxf+cU29Y5lolckWsX35n3d10YpdZ7ZDGmWVJvHQ/w?=
 =?iso-8859-2?Q?sM5BDfikrxVelJ55QnsRi/RpBazF9g+0pc/hU4CQ6DUroL8u9uCJhrGRzp?=
 =?iso-8859-2?Q?dG2vNyNHHzCeJmknZQ1Eet75wCRvP1qZHh0RCwS5NAE03HW5T5fXA9ll12?=
 =?iso-8859-2?Q?xd0RtXuLm9TWzHDzjuCWjvdNGhr0KfmpzDExVg4EZDmwG0XtuGGqvDxNGb?=
 =?iso-8859-2?Q?yvjo+vApXUeBeAt8QrPJ0JFuFbcZxxcIuZj+lXix1xVITGl+3MS3N1wiNh?=
 =?iso-8859-2?Q?KNfamwd5+P5IGgn5Imt3K1dXBayHXHfUmDypUGNo93tdfbQudiAtRAjboX?=
 =?iso-8859-2?Q?izFryk74WrKlVmSKnXMQ/WpjOCbXeicbVnkrIpFzDEhSyWrP/Lsp3Ua8rx?=
 =?iso-8859-2?Q?7LkCBdEyNT9zv0WJ0AEmaWZaU39rcp4L9ucI+Mg2UDhwnbQpHI+q6Wc9e1?=
 =?iso-8859-2?Q?EDdrcgoYY/gMlWrgaBl9JHiU5jMS0YUkVK33VtFyv4b06jiZwbQ6AAaiqM?=
 =?iso-8859-2?Q?zidagL3ewCmehKaR5wbKQrO/S5FMEJScjXD7ISclU90lr+u6+Qu8A7Rhhq?=
 =?iso-8859-2?Q?+w9pYKJ5kctk3nsr3gGEUz28eXipiA7v63teCDz94pRE5zce0YT/yZVE5z?=
 =?iso-8859-2?Q?0mGgZGzpP39e3GE3lzH7+V2Kvg/FH38yQKwLSVPhTFZbxFX8hc8HzUht6p?=
 =?iso-8859-2?Q?W7sdeX/V2YTJGowFmhsWaAMTRA0djhLtC0rvGs6440XFF/Ypw2o2KIXtUB?=
 =?iso-8859-2?Q?Pcob4h8rJso9i37xH3FJ3Xp1ZI1nmePupnh+nPvUOjtHw1az4RDQ4R4835?=
 =?iso-8859-2?Q?gu7tb91WEiv8HqKWBt4TRXyPsWkPxHlnUelUwgI2f/hU3qy+4KNMZlaac6?=
 =?iso-8859-2?Q?9gjXszr81Vh3CzhZE15c2D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7457.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?i+NshEi720q5stJBULM0wIPs31MAnEGllD1OA4Gd729/3nkR0pw31Peu/q?=
 =?iso-8859-2?Q?/P4D+EmnvOF158Y6HfiqdMVzrddlCdojrCMsLVr2qcaig+tvWMO+WCOni3?=
 =?iso-8859-2?Q?olTuCm5Ze1bDyDq4YpMdulEaEKnCmwqF4TGfgdYff7h+CelpofVwvaqMyb?=
 =?iso-8859-2?Q?8h0AGc/+uyU7Q5Eus0/3zPZrsIGUOBPuzX9iGJUj7OcdW9Rc0ZCsQsuHE7?=
 =?iso-8859-2?Q?Kr5InS371oRybGCq5nPKBXvI4DHIIuY/MFhxRcICudVx0r7RHMF7vCMWhc?=
 =?iso-8859-2?Q?PYe3JMTclXDx9QO7+FZgre00kriNUfJ8IFfQiggK9NqsRSCEhGsgIiZOth?=
 =?iso-8859-2?Q?GHNhLQ2wBUZYHVlotxNQdwwablrvrr3d7R4G3Ye6CWjcwWiCRTwQJGOM6X?=
 =?iso-8859-2?Q?y7Ne0Zo4EoFS3xSokTHrTwsApsPhV/Vdgc19iiCFjWZkYmn3EdwGqKNosD?=
 =?iso-8859-2?Q?H0JO4rhYs1rlSmDFXgkHH2se0ml+HtMI8cB3VcBchzXn2mEe5rUd0kruEW?=
 =?iso-8859-2?Q?4SST23N4xtVGvJ/bJWsOML46JRplod5rKZvaky1h7YwKNmWGga953WkUz+?=
 =?iso-8859-2?Q?Eb9gwHoUas2mITXJxay6wIezJ8pgYRqEOL0hJ/9qD/QkIZ9aEdMu3c4IeS?=
 =?iso-8859-2?Q?cCP7pSSowep1WUNXrdWsUgb0mdXBYYCB9nvs7hU+KYg+VJhOHn2Z9V9Znu?=
 =?iso-8859-2?Q?TDHU6t5C/XjHow6Agr5KFMfO75y7C7rTo6dF3/D/zbHDYqkXOLc/5xSV5d?=
 =?iso-8859-2?Q?RbVFnmMaKq6APWRj/9MWLcC8U18kWM5FHhtyT4EG7f7ZLcHuCRyVwjdv9a?=
 =?iso-8859-2?Q?N+Sc5LUEUaxmz2C2FFkaNTi6RyjuGKCWCy6MXFlcjaxrD8gpR5tjymUx4b?=
 =?iso-8859-2?Q?7k/dvsxqOUHgmoCLSubeN3RVJhyWdzeT9EATlb7zFY5n8zgy0kJNZx2VAw?=
 =?iso-8859-2?Q?Dlf+VeFSl/UI+8RRHMF/0OiKzKfF0br0JjDrHYUg4jdYCuRUv5sHGS9sUN?=
 =?iso-8859-2?Q?Wy+jtQaLrqAmJkLwTQKbjziXWRGw8upkfFj9uIoyHr2q0rF5yCByay6elM?=
 =?iso-8859-2?Q?Ezbv8Hz4A0cZxJy5bTpXnRdXmWQcPrNe82yDfesp0hpvEJvL4dJJ6/kUd+?=
 =?iso-8859-2?Q?47a8mWOBxkBTXTso0YfsWPn/3csmsIqhXh2AJZImyfkXw7+OCaWgb06WWO?=
 =?iso-8859-2?Q?272wo533ZiwNmJAaihGC6UFkGqfaNpm16SrTdrye0WsVbSHvsKQwP0YNnp?=
 =?iso-8859-2?Q?siLbaney3XEuErmJPv3Y20XvkhBv26y0VPpeSvguJ4GKAm+WScvJhU+W3i?=
 =?iso-8859-2?Q?fB/L6SPABbh0ux1FbqWsh5xPBTOSuzAC4ZyKqryYCx0o47VRbXoHu67PaR?=
 =?iso-8859-2?Q?jK+p8NSB1y06lNXU9cNCKXujSrEDR4Cjwx+/Y3NPP0wfbU5qcsuVtGLbpU?=
 =?iso-8859-2?Q?BuTqbk0OEyxvePIh1W3QzK3KFqCOwhVV1U0EPE9LZOqtgDMmWOrPouKIMO?=
 =?iso-8859-2?Q?KlFcq1cRqRfRqfn+teC2607VJb4dCJywdNoqTDgJewsv+00v7mMwcyilBH?=
 =?iso-8859-2?Q?5XlGNJV4V6EF737u4pyvtvsnl4pT7PtaoKgslYiFVwAYNeL+yLhAwmO4sM?=
 =?iso-8859-2?Q?lwSvE5yTs7V6+coZVDsB7YzWTgZSNS+OJi?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7457.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbafb6cd-2a4a-43d4-a973-08dd1e52c105
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 04:24:53.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1YaxI9ir50FrC/ZqEuwH9ZzUsuzLy0c4CPAh1HnOhYOF+M//UXyi1rTuBGJ1g4qKK6J9N9X+EEH3CE9MaUwBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com

Hi Christian,

> -----Original Message-----
> From: Christian A. Ehrhardt <lk@c--e.de>
> Sent: Tuesday, December 17, 2024 3:17 AM
> To: Sasha Levin <sashal@kernel.org>
> Cc: linux-kernel@vger.kernel.org; Heikki Krogerus
> <heikki.krogerus@linux.intel.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Prashant Malani
> <pmalani@chromium.org>; Jameson Thies <jthies@google.com>;
> Abhishek Pandit-Subedi <abhishekpandit@chromium.org>; Neil
> Armstrong <neil.armstrong@linaro.org>; Uwe Kleine-K=F6nig <u.kleine-
> koenig@pengutronix.de>; Samuel =C8avoj <samuel@cavoj.net>; linux-
> usb@vger.kernel.org; Kenneth Crudup <kenny@panix.com>; Gopal,
> Saranya <saranya.gopal@intel.com>
> Subject: Re: [PATCH 5/5] usb: typec: ucsi: Clear
> UCSI_CCI_RESET_COMPLETE before reset
>=20
>=20
> Hi,
>=20
> [ CC: Saranya Gopal <saranya.gopal@intel.com> ]
>=20
> On Sun, Dec 15, 2024 at 01:34:12PM -0500, Sasha Levin wrote:
> > On Wed, Mar 20, 2024 at 08:39:26AM +0100, Christian A. Ehrhardt
> wrote:
> > > Check the UCSI_CCI_RESET_COMPLETE complete flag before
> starting
> > > another reset. Use a UCSI_SET_NOTIFICATION_ENABLE
> command to clear
> > > the flag if it is set.
> >
> > Hi Christian,
> >
> > It looks like kernelci is able to trigger the warning added by this
> > commit:
> >
> > [   15.988528] WARNING: CPU: 0 PID: 8 at
> drivers/usb/typec/ucsi/ucsi.c:1377 ucsi_reset_ppm+0x1af/0x1c0
> [typec_ucsi]
> > [ ... ]
>=20
> I think I can see what's going on.
>=20
> First of all: The warning is harmless and UCSI will still work as
> expected (but there is an additional delay during init).
>=20
> The trigger for the warning is likely this commit (reviewed by me, so
> ...):
>=20
> | commit fa48d7e81624efdf398b990a9049e9cd75a5aead
> | Author: Saranya Gopal <saranya.gopal@intel.com>
> | Date:   Fri Aug 30 14:13:42 2024 +0530
> |
> |     usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read
> |     operations
>=20
> The (compile tested) diff below should fix it and I can turn this
> into a proper patch but I lost access to test hardware with UCSI,
> thus this would need a "Tested-by:" from someone else before it can
> be included. Maybe Saranya can do this?

I can get access to a couple of systems using UCSI and get this tested tomo=
rrow.

Thanks,
Saranya
>=20
>      Best regards   Christian
>=20
>=20
> commit b44ba223cd840e6dbab6c7f69da6203c7a8ba570
> Author: Christian A. Ehrhardt <lk@c--e.de>
> Date:   Mon Dec 16 21:52:46 2024 +0100
>=20
>     acpi: typec: ucsi: Introduce a ->poll_cci method
>=20
>     For the ACPI backend of UCSI the UCSI "registers" are just
>     a memory copy of the register values in an opregion. The ACPI
>     implementation in the BIOS ensures that the opregion contents
>     are synced to the embedded controller and it ensures that the
>     registers (in particular CCI) are synced back to the opregion
>     on notifications. While there is an ACPI call that syncs the
>     actual registers to the opregion there is rarely a need to do
>     this and on some ACPI implementations it actually breaks in
>     various interesting ways.
>=20
>     The only reason to force a sync from the embedded controller
>     is to poll CCI while notifications are disabled. Only the
>     ucsi core knows if this is the case and guessing based on
>     the current command is suboptimal.
>=20
>     Thus introduce a ->poll_cci() method that works like
>     ->read_cci() with an additional forced sync and document that
>     this should be used when polling with notifications disabled.
>     For all other backends that presumably don't have this issue
>     use the same implementation for both methods.
>=20
>     Fixes: fa48d7e81624 ("usb: typec: ucsi: Do not call ACPI _DSM
> method for UCSI read operations")
>     Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
>=20
> diff --git a/drivers/usb/typec/ucsi/ucsi.c
> b/drivers/usb/typec/ucsi/ucsi.c
> index fcf499cc9458..0fe1476f4c29 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1346,7 +1346,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>=20
>  	mutex_lock(&ucsi->ppm_lock);
>=20
> -	ret =3D ucsi->ops->read_cci(ucsi, &cci);
> +	ret =3D ucsi->ops->poll_cci(ucsi, &cci);
>  	if (ret < 0)
>  		goto out;
>=20
> @@ -1364,7 +1364,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>=20
>  		tmo =3D jiffies +
> msecs_to_jiffies(UCSI_TIMEOUT_MS);
>  		do {
> -			ret =3D ucsi->ops->read_cci(ucsi, &cci);
> +			ret =3D ucsi->ops->poll_cci(ucsi, &cci);
>  			if (ret < 0)
>  				goto out;
>  			if (cci & UCSI_CCI_COMMAND_COMPLETE)
> @@ -1393,7 +1393,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>  		/* Give the PPM time to process a reset before
> reading CCI */
>  		msleep(20);
>=20
> -		ret =3D ucsi->ops->read_cci(ucsi, &cci);
> +		ret =3D ucsi->ops->poll_cci(ucsi, &cci);
>  		if (ret)
>  			goto out;
>=20
> @@ -1929,8 +1929,8 @@ struct ucsi *ucsi_create(struct device
> *dev, const struct ucsi_operations *ops)
>  	struct ucsi *ucsi;
>=20
>  	if (!ops ||
> -	    !ops->read_version || !ops->read_cci || !ops-
> >read_message_in ||
> -	    !ops->sync_control || !ops->async_control)
> +	    !ops->read_version || !ops->read_cci || !ops->poll_cci ||
> +	    !ops->read_message_in || !ops->sync_control || !ops-
> >async_control)
>  		return ERR_PTR(-EINVAL);
>=20
>  	ucsi =3D kzalloc(sizeof(*ucsi), GFP_KERNEL);
> diff --git a/drivers/usb/typec/ucsi/ucsi.h
> b/drivers/usb/typec/ucsi/ucsi.h
> index 5ff369c24a2f..e4c563da715f 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -61,6 +61,7 @@ struct dentry;
>   * struct ucsi_operations - UCSI I/O operations
>   * @read_version: Read implemented UCSI version
>   * @read_cci: Read CCI register
> + * @poll_cci: Read CCI register while polling with notifications
> disabled
>   * @read_message_in: Read message data from UCSI
>   * @sync_control: Blocking control operation
>   * @async_control: Non-blocking control operation
> @@ -75,6 +76,7 @@ struct dentry;
>  struct ucsi_operations {
>  	int (*read_version)(struct ucsi *ucsi, u16 *version);
>  	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
> +	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
>  	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t
> val_len);
>  	int (*sync_control)(struct ucsi *ucsi, u64 command);
>  	int (*async_control)(struct ucsi *ucsi, u64 command);
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c
> b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 5c5515551963..ac1ebb5d9527 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -59,19 +59,24 @@ static int ucsi_acpi_read_version(struct ucsi
> *ucsi, u16 *version)
>  static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
>  {
>  	struct ucsi_acpi *ua =3D ucsi_get_drvdata(ucsi);
> -	int ret;
> -
> -	if (UCSI_COMMAND(ua->cmd) =3D=3D UCSI_PPM_RESET) {
> -		ret =3D ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
> -		if (ret)
> -			return ret;
> -	}
>=20
>  	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
>=20
>  	return 0;
>  }
>=20
> +static int ucsi_acpi_poll_cci(struct ucsi *ucsi, u32 *cci)
> +{
> +	struct ucsi_acpi *ua =3D ucsi_get_drvdata(ucsi);
> +	int ret;
> +
> +	ret =3D ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
> +	if (ret)
> +		return ret;
> +
> +	return ucsi_acpi_read_cci(ucsi, cci);
> +}
> +
>  static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val,
> size_t val_len)
>  {
>  	struct ucsi_acpi *ua =3D ucsi_get_drvdata(ucsi);
> @@ -94,6 +99,7 @@ static int ucsi_acpi_async_control(struct ucsi
> *ucsi, u64 command)
>  static const struct ucsi_operations ucsi_acpi_ops =3D {
>  	.read_version =3D ucsi_acpi_read_version,
>  	.read_cci =3D ucsi_acpi_read_cci,
> +	.poll_cci =3D ucsi_acpi_poll_cci,
>  	.read_message_in =3D ucsi_acpi_read_message_in,
>  	.sync_control =3D ucsi_sync_control_common,
>  	.async_control =3D ucsi_acpi_async_control
> @@ -142,6 +148,7 @@ static int ucsi_gram_sync_control(struct ucsi
> *ucsi, u64 command)
>  static const struct ucsi_operations ucsi_gram_ops =3D {
>  	.read_version =3D ucsi_acpi_read_version,
>  	.read_cci =3D ucsi_acpi_read_cci,
> +	.poll_cci =3D ucsi_acpi_poll_cci,
>  	.read_message_in =3D ucsi_gram_read_message_in,
>  	.sync_control =3D ucsi_gram_sync_control,
>  	.async_control =3D ucsi_acpi_async_control
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c
> b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index fcb8e61136cf..bb0dc2005c05 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -664,6 +664,7 @@ static int ucsi_ccg_sync_control(struct ucsi
> *ucsi, u64 command)
>  static const struct ucsi_operations ucsi_ccg_ops =3D {
>  	.read_version =3D ucsi_ccg_read_version,
>  	.read_cci =3D ucsi_ccg_read_cci,
> +	.poll_cci =3D ucsi_ccg_read_cci,
>  	.read_message_in =3D ucsi_ccg_read_message_in,
>  	.sync_control =3D ucsi_ccg_sync_control,
>  	.async_control =3D ucsi_ccg_async_control,
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c
> b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 90948cd6d297..a78e53480875 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -201,6 +201,7 @@ static void
> pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
>  static const struct ucsi_operations pmic_glink_ucsi_ops =3D {
>  	.read_version =3D pmic_glink_ucsi_read_version,
>  	.read_cci =3D pmic_glink_ucsi_read_cci,
> +	.poll_cci =3D pmic_glink_ucsi_read_cci,
>  	.read_message_in =3D pmic_glink_ucsi_read_message_in,
>  	.sync_control =3D ucsi_sync_control_common,
>  	.async_control =3D pmic_glink_ucsi_async_control,
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index 6923fad31d79..57ef7d83a412 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -424,6 +424,7 @@ static irqreturn_t
> ucsi_stm32g0_irq_handler(int irq, void *data)
>  static const struct ucsi_operations ucsi_stm32g0_ops =3D {
>  	.read_version =3D ucsi_stm32g0_read_version,
>  	.read_cci =3D ucsi_stm32g0_read_cci,
> +	.poll_cci =3D ucsi_stm32g0_read_cci,
>  	.read_message_in =3D ucsi_stm32g0_read_message_in,
>  	.sync_control =3D ucsi_sync_control_common,
>  	.async_control =3D ucsi_stm32g0_async_control,
> diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> index f3a5e24ea84d..40e5da4fd2a4 100644
> --- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> +++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> @@ -74,6 +74,7 @@ static int yoga_c630_ucsi_async_control(struct
> ucsi *ucsi, u64 command)
>  const struct ucsi_operations yoga_c630_ucsi_ops =3D {
>  	.read_version =3D yoga_c630_ucsi_read_version,
>  	.read_cci =3D yoga_c630_ucsi_read_cci,
> +	.poll_cci =3D yoga_c630_ucsi_read_cci,
>  	.read_message_in =3D yoga_c630_ucsi_read_message_in,
>  	.sync_control =3D ucsi_sync_control_common,
>  	.async_control =3D yoga_c630_ucsi_async_control,

