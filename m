Return-Path: <linux-kernel+bounces-563239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93639A63AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910033ADCEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1A1459F7;
	Mon, 17 Mar 2025 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3G/pRwg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC2182CD;
	Mon, 17 Mar 2025 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742176131; cv=fail; b=oTiz+PHkXBQyDOxnEnaj+BcCOPctM7Wtdwrjsy9claTuQMd15L8KZqo0tDyfmf7S1KRCnhJDJQQBVRAUVwMHExU93EgoZsomcA64KhoQ8YMA1Wn/PQM+37f4Jj093k8HyDOH/cGmswB/IQRyg3EhR0qKguGK0QhfZdv9us4sO50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742176131; c=relaxed/simple;
	bh=eOheaSUnyZSpZhU3r92+AawdEkFSkKNPrqNtBm+Hazs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vEVeV/Jlr8xSanoA+4rqaWSPUuwlSNfdiSC7qp0RCSTzMw76pRpKLdR+EXhVNr29eNV4k0msLrWJN/Z+jMcsmGVLStXo6+E14gYee1BTsMA3BJ3WJQ2j7wwTayddfppIDuQuf0NUgG9hWf1bRfcon4U6aBgxWtXMot5cDN+i/js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3G/pRwg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742176130; x=1773712130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eOheaSUnyZSpZhU3r92+AawdEkFSkKNPrqNtBm+Hazs=;
  b=A3G/pRwgngqw6RR6MqMczXHvSrzDa49rw89+c1gT014HOEHzF78Cu+of
   Oh4qeEtR8zbnBJe4/RYjndegBmUBpVRXsDmxMAh9FMbZuXnM2gSYGDGIA
   KKt8e+xsbCxNb34T6qOepHOlmPJwzqanziGjOR/BLVFp1ag3AtHCilWkz
   E49SlIuUz/ia7AwwvhQSTPt011Aeg7s2+6YgWB7NQLFax5j7i2vn5XhlK
   jF6/sjzZN+EgAweOjcStlp+NMfMLOsL/8L+eELhVU7RNhU9CIYidY7eVV
   Z23ME3w7Ho87zRDTqTlZa8VOEqajh/kCQlGKRxp+j1FxGps5YokjtEeX0
   w==;
X-CSE-ConnectionGUID: 76Hr+85kRs+/XZ1WxRot4g==
X-CSE-MsgGUID: tX5X/XGZQRakW1nl6gAbug==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43391847"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="43391847"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 18:48:49 -0700
X-CSE-ConnectionGUID: c3Halrf4T7SwCYCSvpz+ZA==
X-CSE-MsgGUID: esA+GavrSjmIOdneMhGjzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="126832925"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 18:48:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Mar 2025 18:48:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Mar 2025 18:48:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Mar 2025 18:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKnwoyO48ZOmvkEt/PQrE1B37dWnmxsk66nv4kOEeLWhp3G3ITSfPg9Y1oAca/2toPSfsoFBNjl/iM2zyBKXywXbeEz08KCP6ODp3J7q33Vwoosz/NVrBsPpdzUTBYNfCbMfY1lnW4bZ6HFsV+n3ispoJ10B77jJaHNnoLOthQyQ5PPMNQLkO66nUnP2HrfiS685PF9MbISgG6earzwCIrBJShe5iVcDaXB5MIMzSmiXpdr9jztIqBdYkteBS5qFJvCQzFBcJ7nskA5O20/Dob3ErMP6GyqQZIIhEzxDwNKGf2cUUihOr+dqiokMnzHsWhGIzE+DNBs929meoHrNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOheaSUnyZSpZhU3r92+AawdEkFSkKNPrqNtBm+Hazs=;
 b=zRaj5ZiZ7UVXWwR0aiW3JmQAD0LdxgH2CQeWrhmIbKWrXd9TjCojN1K7d9GjCUa3F+iCedivnyIfnt08voqcdLiwiyt0z27Ija9Y3zuEP7TSbCjLx4oGQKqP5Onqpq9+xBqy0lRA4oQJ/eBIKsTbWI7rBoGFFMkqqVpTL0Uehy1kCOkJRblCcZvsonkdSZ5mhPpXkjPY8t5ZwBvZBLyXB0SO93sfGy99GiAaSZQKwjEMvC1Vd61SNpgLVpm+qdODe2Gojl6LtymFYVEmv5NwTP3pftRmds3vpG3a5Rk4k9oM0hDGZQAAzzlL0p7x+qGvuenLvC6haLULInrKQpWl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Mon, 17 Mar 2025 01:48:46 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 01:48:45 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>, "Ng, Boon Khai" <boon.khai.ng@altera.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb
	<linux-usb@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@altera.com>
Subject: RE: [PATCH v3] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v3] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbkvvQSXSY6O9/1UOihOLWiD8uZLNvubiAgAIuB4CAAFZmgIAEWG8w
Date: Mon, 17 Mar 2025 01:48:45 +0000
Message-ID: <DM8PR11MB5751C69BBD6F48F89161F272C1DF2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250312030544.4967-1-boon.khai.ng@intel.com>
 <Z9G8-66NI_5TLSY-@hovoldconsulting.com>
 <BN8PR03MB507362B42C47E2D3FF7C2D7CB4D22@BN8PR03MB5073.namprd03.prod.outlook.com>
 <Z9PZkX12YX1sbvSt@hovoldconsulting.com>
In-Reply-To: <Z9PZkX12YX1sbvSt@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CY8PR11MB6842:EE_
x-ms-office365-filtering-correlation-id: 27d157b2-c22e-4474-3070-08dd64f5daba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TxX8Lol7s4NyyJmqzZgM0LetAiDj7ipjWr7exwO2/ZwKb3H6N7no3lQGK2pX?=
 =?us-ascii?Q?ZELKgqYxS2xq1OfUXEw3WygEsUhspVLg2FKD592BeM73klEtDFOThBYFRCNt?=
 =?us-ascii?Q?peAMO+tvGlYpsLgsk970UPGb7/eF1G+r1iOQEm1N4BVAdKFPbAFCuEou8LL2?=
 =?us-ascii?Q?C01WiJnqQRKJ7W5AUHJSib46WOEjUOZjC6sYvFyFz5/FUE08DLoivdlxuZE5?=
 =?us-ascii?Q?kZfwZaqHvOl+9BSKuZFuRrrs9xIXi2AOyESrq4cY4LaKJWmr23c4DTklN/8l?=
 =?us-ascii?Q?z03pZQm9zGl++DV0pK2OrjQqoqR4CJnvaaIl5RewxDE2DWfk6gUkB7mp0KT4?=
 =?us-ascii?Q?OzZTfAcU3rCho/n0R7+kBnO0Gg81v3x22HsB1UnrU2iojxyGdGjn29PtUI1z?=
 =?us-ascii?Q?E59enUm6C/vo7QcMaK/J81Ns+UKeBdsWSgcAp/ToXlmnQfon+PnagnrCcnP7?=
 =?us-ascii?Q?omMSfL69w4AyV1xdNnrNq9G8ESsd6iQPUViQsAs/rKpxL8WYxxbUWCug4cga?=
 =?us-ascii?Q?dGYPwkZgZwGw5+bqVej34GUIhhiBffEz33nJvwu+vP4uTOWXBKSyrFlJ3AdS?=
 =?us-ascii?Q?zNqAQHrJ0KqLGfCEUR7sQCERjFanM/nhEwTP2xd5EqySZin5AkpU3w4mjkqe?=
 =?us-ascii?Q?cZpuA/wonWpA+/v11mG3MRP+Brbfx912HEYkJiseYWap7fDW8GImgnkuGtPw?=
 =?us-ascii?Q?5m666dQiRC4dU4dt4ygrj6zzvJDFHZAZMgPJsMWBYqydE5EoS9epHxibl8Cb?=
 =?us-ascii?Q?3sghRCEkR0tF3RuUr/oH+PLv36ie04/1cqsOiJdswR8xObZrZ+RDnagXH5xG?=
 =?us-ascii?Q?wk46SrvyOVck72NViKXd8NXu4SUciaXN1IXtVEwoYY2sQxFD5jJUNG5leA3I?=
 =?us-ascii?Q?QNAllc9w9l1fOzruDvaq8L0wtk/hZwbf7fZsnkraDy+GRn14t9Ddn6YyjFgy?=
 =?us-ascii?Q?fRpmPvb6H+CEXYgloTMJNeMSNLDlc5AUBk5bPqB3/qWEyu0raLH8L5O6SKM7?=
 =?us-ascii?Q?kFRv6bh41ka145HUFc66XlnIM6zrEnxmqimA6DWcphbMCWKkZNmIheSIVv5s?=
 =?us-ascii?Q?LhM3LAgLYck9nFxr2tC8hmti52pFh4SUIb2MwcwyCPmcoK6gIV3AvRWFcbNb?=
 =?us-ascii?Q?y2ucoxLhD7TUe96CTFsZ++710pyyCCz3MKVQV9vAgEaYvQGf2efteQ5/jKYX?=
 =?us-ascii?Q?3yeP3KatgDfwZ+Fi2YiVwujXIM3pHIS/OVc8paiPFXzKWM3SG2izkEZi+HVz?=
 =?us-ascii?Q?tgEVEXvKjfcCGRWV5qe4HYolxRZpF5IUujKSY9QsjTvPlR1lfglHMp6r2ZRY?=
 =?us-ascii?Q?dNVRdn65CQiPZxLZCQ6LS63P0TgGnsvKMamDULH7HWFE2BCWHCFErTx3H6Rc?=
 =?us-ascii?Q?p1RstwkfSYAl9P4SlHyfLxPWr+eZNqzC/qHmrPN/VdEHCTULZSn9RDkpdGLN?=
 =?us-ascii?Q?O6MvhqD6JwomFhFnIOAk2nIZaj+gg69w?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s8svT0l2y17W6zpj7/1e7zw/bioIK2nRHm9PoJhLbYFUWZ5KwdAF88sSk1Io?=
 =?us-ascii?Q?8j1prcr0LECnYwk8+bOMbHIvRgHjBCVESIDnEWKbzaR/DHHKzH/c/MAVqtmX?=
 =?us-ascii?Q?y3u/QIs8YDXyoTEIZ6mZeNI9X4HW9POpy7c1m4XporF8fSF1UudVgk27iNX9?=
 =?us-ascii?Q?JfbUxakDjdnSg9ro2ICJWpRqhku8sYizE3rrZDqgPdeb0c0T7gJnMGZffXNG?=
 =?us-ascii?Q?5rCaITJwqr7HwzW4Pdccm6OcOg6ItOdahbuDg46HSACB5lhGjC9R8ghKqJkf?=
 =?us-ascii?Q?DNzQKaqTSEu8X0MKfdeTAUurmY5xtteub+8oc8c3RPxWskz0o7c4x9CY/BYJ?=
 =?us-ascii?Q?kwBzG28/qd9y1HFnIvxdM0hmI6cMzz9G7rY41cFKhRHcxSw3DQNYGp3wHhks?=
 =?us-ascii?Q?/nIFU3mZW8NPl/use6bcOXH6+yt7ovSqgTL0yuU5Yj/b2OCg2kNLUkNMehcG?=
 =?us-ascii?Q?aoa9WRddCM0fg8Vb3jDAG9N9G/pVlfL/GdnFjLZfyC6PJPX9rcJhsPBZZqFZ?=
 =?us-ascii?Q?nwG9+XdUud7z0YrezzpnpLotsKTysR1qbhr3gt9TN72XI+W1Kp638Ce2lLfg?=
 =?us-ascii?Q?1thchnI+RNVpYuCow3s4VHeka0pqg/++nnGYx+d/OeDCS5sYRr6N2P8AoSpg?=
 =?us-ascii?Q?aCM9DAzYhLxWeIwvKVc7yWWzA4L+SagtIAIUcaqh+SPcCL0dAJnfBhkwbKJM?=
 =?us-ascii?Q?0pNTC9W8KGOAp8H7Lhllc08vAfew5p2JnqgC5/MjmpX2WmCNBgnkjOxdhvNa?=
 =?us-ascii?Q?LnsfAj5lH9XgzIwxYFHuHqDf5fcc0D5NMQprTfkeg00r4JUgypsVn4FKP3oj?=
 =?us-ascii?Q?EeGsff6OMYnkZ5Pz8AIEq79PL7sucETzCVwXcvE48Hulr7UtQoS7QcZ/eO86?=
 =?us-ascii?Q?yFcD+mIPAa0ZpQ9Z4AE1y7sNsGAumCk5d9PV6zVuSesXFBdDAc/umvf7E8as?=
 =?us-ascii?Q?nOrIVvCEUmCkhTmDUyaKPFkKnni6sFOiokS/Ik18QfFVPQDIrsD8MUjdOGN3?=
 =?us-ascii?Q?Y8MAvET+dT5JOQLXbyzUrf6cvXMfICOTOlnk82SUrYkTI4lKhYr4omiCrVsN?=
 =?us-ascii?Q?Ubhsv72UxluCvBnFYE24zHN+qQkDjAGRuv7YlkQAeaULtR3rsCSc7FY5n4vY?=
 =?us-ascii?Q?sH48sny9c148K7fMxRLLZMajYXhQk/Qj8GQZNTXcAwi/9c2N9Ziv/g6MjxLn?=
 =?us-ascii?Q?mCQFtCtK8YEiEHtaAPt3+AoPMBmtxR/YrBaNxKBKI/Ww/S1t1xCmlDiMcplh?=
 =?us-ascii?Q?pTeMIXuaHmeiX5ckRqnUZkwFegmo2b+YSWX5gALtanf+LYBiyQxhsIQ71Sb7?=
 =?us-ascii?Q?/f+MjCITMaivMOpdv6pWwWrRQ2GKWOwVzh8sFZS9/QQKXPGzIMYebCEDOtEe?=
 =?us-ascii?Q?4jfh8aRrgGz9Chs3UYwIPwQ3L2FK5MJX9aLIJjdmTVkxfApMYcna+f9AzK+e?=
 =?us-ascii?Q?Mb3DfKvwMiI9fNEvqJ5xMiyBjTC6q4sUxpcknHRFA4Nwcc8nMHRRWWbjXR4n?=
 =?us-ascii?Q?CP5vI0ZhCsEVc2cZuuQx86OJa/IFv9tuDMowxIVIa9kw2FdVY3/MCKNNylMr?=
 =?us-ascii?Q?a4DQEn/snjAjZO6OKMmiSYUXgPvIyez2KsEJI+ESP19TSNnM28LEomTqPIMn?=
 =?us-ascii?Q?bu0Z1xuZkISlveghjG+GYEo4vvBUxPl90WnZYwcOwgl/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d157b2-c22e-4474-3070-08dd64f5daba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 01:48:45.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXJGD6mSLSChLC/Cw4CZVPyPe6DuU6KFxFLbMBG1hNLwdwc0yeubvzcqZVlMFEOQLrG/rtcVcd2iAQrXi12vhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com

 > That's what I do, but if you add your SoB followed by a cut-off line and=
 change
> log to your local commit, then that should also work if you later run git=
-
> format-patch.
>=20

Hi Johan, thank you for clarifying the step. Will make sure that I follow t=
he step
in the future to ensure everything formatted correctly especially on the So=
B.

Thanks again for your guidance and support=20

Regards,
Boon Khai

