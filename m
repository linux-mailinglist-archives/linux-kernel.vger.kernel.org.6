Return-Path: <linux-kernel+bounces-548658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1DA547B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A477A2273
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A4201034;
	Thu,  6 Mar 2025 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3lYwkDl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7341C92;
	Thu,  6 Mar 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256731; cv=fail; b=h9d706rPiOCHO0pB74gXzHSGhsV4AvwF2hknjTCzUILttcWDaOJNDpAZK+FAyoHF5ZTgXBYQW9RY4JzJY6qN2NAoGnl741FrRPc5wDewuJR4S6f+vHAl3ReB8cHaF/7W3sOp/zocGb7Ho5ZC0zwzUSOIUbr4dCRR3d+vrl2g/aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256731; c=relaxed/simple;
	bh=nXPjDtZJUFLnVOAShHbi+l4lwRLZ/uVMRciXUvcrApE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BLDlUf3j/YtZIHtCYbQd7azNI7Wd0XCm1yXJsd4dEX1wThldO7moDi2Km8rhMU4tf1cavFePtOQ5eJWlrK1JbyledOb3Qi2ZSxxRL8CyHUzLC4e6DFQwp2a3FP5whK4Whbx9BS86iTuAkcoMmqUXfySQSql/Ondo6EhR9Wf1gCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3lYwkDl; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256729; x=1772792729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nXPjDtZJUFLnVOAShHbi+l4lwRLZ/uVMRciXUvcrApE=;
  b=A3lYwkDlBnJ2oUv7lLSurWLAbrAtBxXn6XdX0bHo7CSy95pClGMuMdSt
   JA2nIcJQ39WoJJKuyZWR8qulUv29O4Rv1iREPqUedmdmSqy005VmKBt2l
   tqAN6ffUncMlzu2iddhYWnMbbCQZSKnkIsCpo2C/5MU538TOGt0Luaa7b
   6OBpoBBSXjU2bE+D6bufTREns1bBmBXA/QVUGwArsVCo4gn2D854RAnFd
   Gu+/SWUq7pWT4gdl6bAtGN6PjOe4CYVpQ71wz3SChlwc0+jxoo5NgiO2/
   Th0PpXgYYG3Odkqc+Og6LJ8OLxPiKtKOp6KA4ep/oJzCo4nkfUqGLT6ZO
   Q==;
X-CSE-ConnectionGUID: zLkB7RHmSVu8WgGS/b5CUQ==
X-CSE-MsgGUID: fJ1I54WXRS+Fwmisr9Zo+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45065040"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="45065040"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:25:29 -0800
X-CSE-ConnectionGUID: hKLHjWLQS3mPtvCjEFfoAQ==
X-CSE-MsgGUID: VNN4w0G7Tz+0PP46aJVxCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156201424"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:25:29 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 02:25:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 02:25:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 02:25:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tICTcKZKiWXefyjY7/Mv08GMf3z4hD8KcHbVx79SMKfFlyR7wEMA441/F23WL0aYNxaQPbze7rZ/I2zge8x+8AVXzeiV4usQepUsk94/T5OEwNF5HDx2WpZAqg1wZlxyQhkft0b+42nYfx4nWONnqR0RdtHawYO16buFvZDAXUy3qb4r8HhPmulo/pF8v0BRrQdZtC9vEF7MF+cxFehco/hZpjiIifC2Pz+G3vNIKsld+s9DcSY3FcIvt5xQSGncRy8wkN+kcmmLMElf3tvjY2nYCPcYmpY+VpYEtxcas/R6YMZfUGLN1eMOvFU3QX6mjHsb5JahXEQ2YK1T7VhRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXPjDtZJUFLnVOAShHbi+l4lwRLZ/uVMRciXUvcrApE=;
 b=Ju2gDRejO3VzqFj8aiw6NO9i5U2dIBk2Jp2bbrvnKF58vkHk4yuf3yn2XWRGFvA9adOJpDA2ttczs1mSsPBHJWRnVInBY4mtzq+2zB/w97C2If26+yMcErlWarmFWIATgFLg+ET4Yt+CRxfjAquv20o/hMZjedqvJvS7kDJioM/YzbLDGSSiWV1rWWG04rKfhHjFfl1hV556v3RNKGvTQI6gB2hs7HpB9woPLWyze7mCQR0HEVfd+L6RSymXcsk6I9n64tx1kFuWvMr2Xs0NbyT5c9PPPsKPZdI/IENq+ZKxzPNZtzjqi7c54bdtJ3qexa8vY0XViONxsKJjP1A86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.20; Thu, 6 Mar 2025 10:25:25 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:25:25 +0000
From: "Ng, Boon Khai" <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Ang, Tien
 Sung" <tien.sung.ang@intel.com>, Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>
Subject: RE: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Topic: [PATCH v1] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Thread-Index: AQHbdhhxthJ4AiCvMUCJLGSIXsfkL7NkyIeAgADAZHCAAH99AIAADRTw
Date: Thu, 6 Mar 2025 10:25:25 +0000
Message-ID: <DM8PR11MB5751B5E8FAD650C31AE12410C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20250203084822.18356-1-boon.khai.ng@intel.com>
 <Z8hetcRinFXXVAdy@hovoldconsulting.com>
 <DM8PR11MB5751D2151A9FAC30E8647389C1CA2@DM8PR11MB5751.namprd11.prod.outlook.com>
 <Z8lrCnCie923f0-_@hovoldconsulting.com>
In-Reply-To: <Z8lrCnCie923f0-_@hovoldconsulting.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: e1499aaf-00af-402c-7932-08dd5c99358c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?myYvjfQlJ/+Mv5eGbvQX7tzQwH1WpxsC368NVt/z0zwNhWZTKJxbYBMII+BI?=
 =?us-ascii?Q?b4Z9ey93RAxR6ORR4/uV53yUi1+7v4lhlioAYCrFJ7G+WKcdn5ohFtXDXSUK?=
 =?us-ascii?Q?iPI60huktp0VjVRRsIX6CrvxJw0LTvcCnWhuxmU1Lfw4LNg1C57Oy+AiCozF?=
 =?us-ascii?Q?A2Ch/HWYp0DFxXFjcNkC171JoiKp2Dt2FRBuOKraOYTyRDgUveySXmWeaQl+?=
 =?us-ascii?Q?jEFwETyKwRjJ7pO3Fea3j1ehIlN9JKdD5dfjZgG2d8PFDWg1qdbRxIQkwodo?=
 =?us-ascii?Q?CQ0vS3InoZwVTyr1X2aVOazlCjYWQv1sjY3xHFpnujVVUA0+tA34rG5N3LXz?=
 =?us-ascii?Q?aj+K/CjYplrlXqItx+85wriCvfIuLhf+mmg5wCo/hAeIGBwhZYYvWo/neL2l?=
 =?us-ascii?Q?d/hQ/RpxC3HrY4jaRfo22Cm4f5cWWhk+plyRlYMp1P7wavHhTCNmxdIpj7P9?=
 =?us-ascii?Q?st/ayMEwCXS2J9xm3Mpub4PHTClX1a7PYcpyNzljQJ8B46Bms1zUueQRqvgL?=
 =?us-ascii?Q?tTQER2k77jLbLMMYXULMJ1TvYdWK5QMQxE4TCRoIW3y9FE4bv31lbJspy/Up?=
 =?us-ascii?Q?3Nlzd7Y5GScJHD452tuFpcC4KeuBeYw4TfCdycavdPrAtyIKjYYAwtyqmCeC?=
 =?us-ascii?Q?fM8hghZi6RhdIqyikL7m3TChftxBQZ+hkdLCCBftT6JMFIfggim+E1XMFuNU?=
 =?us-ascii?Q?hGfiQduIM88B1tBOtdIyV9WGJhOFCBRFM/u8MN2kQTMnm0XFv9KXGfKms4IH?=
 =?us-ascii?Q?qA2wgfG88SDarTSFewRJUHuWgqR6mEiu974YEgAEd+soyV+zdAC8U9oKfvJg?=
 =?us-ascii?Q?SkRPJZfDY1pETNCos1QNzjoodW5RJB/ULK6V8tiYsb8STQJkR81SEhWgefOX?=
 =?us-ascii?Q?QQnfbozUBvh75q7oyFf4QtVxD74jetDtXA5WmXVka4x1SolC+wcU2mI6Kzyj?=
 =?us-ascii?Q?L/F04pDKYuWFqqMLEpCxYrL8zWJyuhxaT17p/9ynw/7NmIQDQLogQX3L12mx?=
 =?us-ascii?Q?uMZelWDFImxBTk0HCmYPsvbjDA3Db3GnN+gT7FU3QXmdONbbeKUmNF31scoy?=
 =?us-ascii?Q?CNgWFC8WSojKzrbgxm/tMWpB/ifeG/xQwlj1uqAPhhaBtL2+sYFcqFgD7UZ0?=
 =?us-ascii?Q?0JE/GnTe+F8ze67McE6t+qJaj+5+8mzUgpIVoByRju3vYauchdIB60E7cl2L?=
 =?us-ascii?Q?yZ/Cd4ILJBMgPNZ73NY9NI8bIQZuQUc8SMoUvF+E3LaEeeG+hjvtfq3qiwqh?=
 =?us-ascii?Q?jTV+BlIn1zggMpgt3xkmAUF3zaYNhEsQ0e02gnLXrdt1LCWbKRw9IJ2Y0xLV?=
 =?us-ascii?Q?+GXuN9XiarRYfeuuRAogufi/ODJvfbF8lsNb4t9saGMcpNDuMhfHhOQXfouU?=
 =?us-ascii?Q?8LwXedVN+TeTGXeWXRZtmQHIy9gde4WQJFxy8a66qtF6aWrhOWDcHIkOkWgR?=
 =?us-ascii?Q?5gEzT+tUkB5ZuPB4QX0dP/2LQ3lvfFP6?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e9nFMRG+rd6EGOW3azYg9ylOZ/wSnO6zTN3MMKATl8QamND8aXQPlhrAQBZd?=
 =?us-ascii?Q?w2NhdPMLr6cH0BQ2pXC3VjjobtzCbEKPjvv5CKR27qcn/GV4jy366Rwiduip?=
 =?us-ascii?Q?mB1BpGt3tYrZDH2dIUCZcriM+pvDhUXa/BTAtEadLm72I6676ChS1IelSatk?=
 =?us-ascii?Q?Oc4drjxzKOg63t2Lb3rpIogc4iiFIFUuzqi1Rje/D5SICjkEJN+kbQbW6zyz?=
 =?us-ascii?Q?ux49sfaurs2nXlFUenxwd2PPcDLfOAbmcDL431b1PB35htRBRjEjNg18dVhk?=
 =?us-ascii?Q?cjXPEWbjeJESFe6gGslZfUCVxzJO7Jy68GrlkuEPJPlTegTeIirqkTgMnDR6?=
 =?us-ascii?Q?bLa55fyb6wuKcj5fwPrVcYxZ42hhVLm/swGzUbk7QIeXXd52kIZG+L8kVn0w?=
 =?us-ascii?Q?asRKDRO/+VEy0MdgUsFjmi8ubz908ClWIVlOrhQY/Jyq3uQj7A2pRzpAGpEG?=
 =?us-ascii?Q?sait8pGKjA2++BBWtlRYGQPatZ9gVRpVhQWUyH4R0B4HrTBcxlIJ+X7+2LGU?=
 =?us-ascii?Q?W1hkH4iT49HVuf6RU/6OzOZm2larVbdtCPsjW+iFUosKKhal7IgxdK1FNzCZ?=
 =?us-ascii?Q?iaAkPz3ukOqkuqa6NKmuB/v+Y6zDSQAYdwhvMrDx9guLMZjmpUTwKFSEdaMZ?=
 =?us-ascii?Q?EW7g2zE43dZ/1+QGDQWBfNgknBHGP9wXI3b7IREcq5GHN32j0kVA2lHIzbFY?=
 =?us-ascii?Q?cYpweZHXGhREzgEKAx6qnh+SlaZzbaRYWMlyKttwwsGnSzsRe0XO8pRXeNEE?=
 =?us-ascii?Q?4CEmXWtgmK3jUynde8rnuDxSC/dVzYJ6bZgrCdFofNARkfrRMZhpaiNo7H5D?=
 =?us-ascii?Q?7h8k1LyGFmPG1kBgqeczJMyyM8svEF/cNwD/4HBJ8QGnTjAUfdjL+sa/jIdc?=
 =?us-ascii?Q?wkhZrTnIRpJIO3cdbFvIO34074ku7PHct6zUGpmobW7ohaWDfBU9joV59Srn?=
 =?us-ascii?Q?d70xyJ7lekmUMiQrebnYjElTns7gZ0JWcbrekjIq/E8imnbyiFEa0lG+yaq0?=
 =?us-ascii?Q?kREFAbcm61WN+5P2KMlq4g9257QpAPfzge5GzD0PjILYlHp+qssAUXnuI8JR?=
 =?us-ascii?Q?Yh6Ep0kUieW+dQx0phHKrUcPggwKZiu6Zt1CO39BqL/wMKhSgMWdhchHQV90?=
 =?us-ascii?Q?ztWw2lmw158OhHL9pemASXnutKBxf4uNTAKlpzaTf28GCXhlpXxxuPfio4I8?=
 =?us-ascii?Q?wBOJZWsH5wac/3It9VBUQVUiyqmU0MS8ceCHuNEnW0kmAy9CDm+Ug96oqJMY?=
 =?us-ascii?Q?l8hkU33NoYFyUUJJXzQ7VTmBrb9c5zRK55HcHV1pB5mTROm+Zt4wKqmAIERM?=
 =?us-ascii?Q?5yRgwws1DYDxAJplFzCrt+IDv+tNL4w+G/LHEUNJdoR5XixLiYDgpbdM8GRo?=
 =?us-ascii?Q?0uQZaq745NSUA3fgZekFSDhD2XWMYX9pnG8Iw8ktRxi7kNAQlndIkiySXU1V?=
 =?us-ascii?Q?cavY4t/tb37sHcQ7OGMa6W1ExtRMMS+9wjiL4kkVvfLuTpK3SmqYnLYVqC+Y?=
 =?us-ascii?Q?nV1FlbuAp9Hp0gwMgKgAs+UlzVPBIOB4EabUe3AlSBHx9yuiBFvnhb4c3zHQ?=
 =?us-ascii?Q?u2pnHW/8OWVLZdKSZngxNWF7paU1ouztHHEkNSKw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1499aaf-00af-402c-7932-08dd5c99358c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 10:25:25.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thvDZDB2ToY0fK3+QGlORXMH82NX3YERKDwtzDAk64ezLhiXFwl6T185WHoSZ8hmtbjzyPFYAnHCyoL31Za53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

> > There are 2 type of designs, USB Blaster 3 cable or On-Board USB Blaste=
r 3.
> > They are mainly used to connect debug or configuration software.
> > Supported host software includes Quartus programmer, System Console,
> > SignalTap, Nios debugger.
>=20
> Thanks for the background. It would be good to have something like this i=
n the
> commit message.
>=20

Will add that in the next version.

> Got it, thanks. Also here it would be good to include something like the =
above,
> or a compact table like you provided in your reply to David, in the commi=
t
> message to have some overview of the configurations that the patch is
> adding.
>=20

Sure, adding that in the next version as well.
=20
> Then it should be fine to keep the PID in the define name. Just replace "=
ALTR"
> with "ALTERA" for consistency with the renamed VID define.
>=20

Okay, will update all ALTR define, to ALTERA, to align with the proposed
VID define earlier.

