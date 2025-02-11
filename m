Return-Path: <linux-kernel+bounces-510045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60345A3178F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332EF3A67D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8642627F5;
	Tue, 11 Feb 2025 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gc+bFePz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB92627E3;
	Tue, 11 Feb 2025 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308938; cv=fail; b=QEks/jzTZtQs1JXVQlfXKhzJhb3Y3ZeN6/tWYXSMQP8QBhdhZzFFzzG5WAp/bpTWhCGd26O3GNd6CO79x+kX4EH96wLG37tdi3H/NgTuCa1DwHeJS0XJBiMAukdsAAkQUhYJzoGfltVhhS4Gsk/PZe0AsYwmRAEzYGeKFOQ7g9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308938; c=relaxed/simple;
	bh=69gHZYinYxoyTcUcM0ise+HwsvyBAOj6qp15ZeCKjUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fa/AFKQ6tpvQExVneYGFQSKND3nTUgQLnT/D8Z8XWzA/RjAWJAw9hF4qFcIl6lQ4bo9wozb+eUQUdN1mQZQdBA3W7ir3ZFcM2TYahXwQGbdFwJbDYMD4d/L/Yyv9KQNQQsUFu84jJ7E1kncSrAtHRwKBZ8hEtnRvumA5jUej2uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gc+bFePz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739308937; x=1770844937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=69gHZYinYxoyTcUcM0ise+HwsvyBAOj6qp15ZeCKjUA=;
  b=gc+bFePzA/wK8cxLz91F9dCEK6txa+CLBbfXrBBsi/1VIXyW/vF7rlp6
   f7elMWHk6WYXyy9TD8Ehaqdi3J8R3tYG9lTUwD35broBv+EKH0VNI8C8s
   ZUf4CcvY3gw6FPtihjSLqGvF4G5blA5SG2r4+P+dLAbfq40uf8LKHmdnE
   omsbIe9TFMvpdOQT+Qg7AC6Kx58dxqUSh9fSgyIkQD20Ga6FJAd9c3KTF
   PphsGoiZprX6SOXoWU1rujOHH8a1XQhc4/vKlf9mS1F2dTjtSvCmYYP5T
   rgZMlhkFW1PEv7zzta+RoROkQSbsI9vFH1UACRmoBTc5xpFk1e/8XU6GO
   A==;
X-CSE-ConnectionGUID: RHIahoZVT0OGKptv9tPIpA==
X-CSE-MsgGUID: RXIelUPLT/qsm5Y+9yrJBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43710984"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="43710984"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:22:16 -0800
X-CSE-ConnectionGUID: 4XwiN9qBTf+MiMFvjJG8vg==
X-CSE-MsgGUID: t4bHOLPfRi+Fyi+rfxkb2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112487722"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 13:22:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 13:22:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 13:22:16 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 13:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAUjkQCk7vThZmPpKH+txUTsTTrOg2kOwjBOBvcot09Ng1y1AVRenDHnGhCt0jeJUfnHCC04PENv1s6I6k+DLeXKaNI6PQn8YhQVR5lXzn+ea9iMNCRf9KjsfLYDCAY+hVsESim//odgnBgUC4v012R+MrKPGSFgTt+IX7gTh2F8JZJidhJbFrVYFATGk4qRYyw0XRVfpeqjZOQo0k9BaU+F6ZKlo6U12DblNN6PpIqRlwBC5/0e2XMZAJLGLjvYP6QMZHgv/2v+2JZgBYXTad4/tvRGnBDAtTeNSxl74v+1FYX7zbkF9Jd5u1Egb68TKmPgKIe5kYDsaowaL3yUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz+knhOknjEB6yGoskQQMtAZP787xQcxG94axBIODrM=;
 b=n0VOx/g/4vn2X+PYx7r4vHbiRQJ9TY1cCn/QaCejbFLVJtBrcV+x/nRuMwvUomumwL/9uFlxZdDFfhiybAsuyS++fpqMKR9UgGMR2QcdOF3rx79iyebqy+VfNcdk4o/3xRG3jGgoxt/3sKIcSVc2A6zHsAEYpmxGrCcVS5gyLgj2JaZumpQpVwUaB4sg79chriuez77IBAcAS+Bweoc1vZ7LHemnmntDfNeI1qkKL0ls2dvdDI8fGafrX/GxOSxQDFSW8vV70+vVbLFXZYLzOGfgECgHq3Ox0eFJRTRyHhVHg2feiMV1AOeFl7XzRbZUB+N41NWsz59wRsTLyY//zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5985.namprd11.prod.outlook.com (2603:10b6:208:370::8)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 21:21:29 +0000
Received: from MN0PR11MB5985.namprd11.prod.outlook.com
 ([fe80::8719:7f03:49ed:939a]) by MN0PR11MB5985.namprd11.prod.outlook.com
 ([fe80::8719:7f03:49ed:939a%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 21:21:29 +0000
From: "Pathak, Asutosh" <asutosh.pathak@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-2?Q?=A3ukasz_Bartosik?= <ukaszb@chromium.org>, "Abhishek
 Pandit-Subedi" <abhishekpandit@chromium.org>, Benson Leung
	<bleung@chromium.org>, Pavan Holla <pholla@chromium.org>, "Christian A.
 Ehrhardt" <lk@c--e.de>, Jameson Thies <jthies@google.com>, "Katiyar, Pooja"
	<pooja.katiyar@intel.com>, "Jayaraman, Venkat" <venkat.jayaraman@intel.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] usb: typec: ucsi: Command mailbox interface for
 the userspace
Thread-Topic: [PATCH v1 1/2] usb: typec: ucsi: Command mailbox interface for
 the userspace
Thread-Index: AQHbeKI1OKbkdISQe0CZSSnirUdfIrM6XAcAgAF0XwCAAHh+AIAGSaeg
Date: Tue, 11 Feb 2025 21:21:28 +0000
Message-ID: <MN0PR11MB59852E3FEC3E729C9BED8AFA81FD2@MN0PR11MB5985.namprd11.prod.outlook.com>
References: <20250206141936.1117222-1-heikki.krogerus@linux.intel.com>
 <20250206141936.1117222-2-heikki.krogerus@linux.intel.com>
 <2025020643-federal-uneatable-5da4@gregkh>
 <Z6YE4mJHx1zHNW8d@kuha.fi.intel.com>
 <mpe6hgyqmw5eohrwulzy7ujdrlgccgqxwdjdjq7zmsdhsemzcd@b6q2hu5ezvqv>
In-Reply-To: <mpe6hgyqmw5eohrwulzy7ujdrlgccgqxwdjdjq7zmsdhsemzcd@b6q2hu5ezvqv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5985:EE_|IA1PR11MB7296:EE_
x-ms-office365-filtering-correlation-id: 547beb01-1e49-4803-7806-08dd4ae20c8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-2?Q?818MBA1KLJAn7IHzB7b/oqRjlj8OpMWJ0a8Y6YIuwLuCGk8XOaXBc3Qv6Z?=
 =?iso-8859-2?Q?rh+TkijsNXo1PA7SJyDTaPcl9xVhDeYRqSjYM5RGXG2C2IM7TwyZOElF5V?=
 =?iso-8859-2?Q?ymPuK6pci30pkMIVhZ4cz1cGyxmXUlWrvoYZ0IypxlUIA9HDM5Tg0dCl9w?=
 =?iso-8859-2?Q?K/fdg5uvmFVEA1/FPZx6KNs5BtaJXt79QDrnleft1uL8PcMISCYYMqJ4Ei?=
 =?iso-8859-2?Q?P2/yH3vW7aEepdBf43bgWIAT/PqCGly5Y2N5sVkQ94FSmFaSEd1z6OR3RD?=
 =?iso-8859-2?Q?u4spW7FblSFohcUNJbMa5J0eYxFE4YQi7IjN61s0vNYDO8C83DK0zm+Mgb?=
 =?iso-8859-2?Q?bNFjnqvpqewvvRcn5U75Z6Kb7ltSkc+kctlIC8OgZ3YvefdydAGVXi/Sqr?=
 =?iso-8859-2?Q?2WP3cU1izmvm8n1gV7HrZoqbIT2hxHm/TugICFXwe/+CIUlBonPCzV9AqY?=
 =?iso-8859-2?Q?0iLko31ghlU0S/PXcrzD6aOORwfKnvoHZ8wU4Oo5a+jKbeJ8650N3lILBf?=
 =?iso-8859-2?Q?orQSapy2lImPw2N/z58RReU2s3w2CTUA9Kr7Tc23Ad0G2w1Q8+/daSu5gC?=
 =?iso-8859-2?Q?QHhrujZhFtgVav81mdv6AR6Qh+NRgnZcuok6F9QvTH3FjrH12lTn4fpXkC?=
 =?iso-8859-2?Q?tO6A46kcbLg33CTB2/CpcgqSFOYDZZgcuE+Ej+LsMad0Mmmd4XOqTiQ0Ef?=
 =?iso-8859-2?Q?9/hiQTFZHgWJkZKw2BgTvon2ICIo2jjfWdYd7x2ktM4LKoLSHYFUBGbgVW?=
 =?iso-8859-2?Q?qskOKrWiH6G2+RF1RgrqNJXDM/fJix2KEgJ6YXWLF6/T1WbI7hGyV4d+2B?=
 =?iso-8859-2?Q?t1Fw9cF9jwV8pzH07IeO+XyYyxj61YrC6IjDb8Bp5CT46ILzPzeVmfTOQ+?=
 =?iso-8859-2?Q?iFjU/je3ceByW6/1qpEKjO8S+Q2NRJE9OBADutwAaz4hfpYXKMkUyfdCNN?=
 =?iso-8859-2?Q?Dnfc6CV6+mJ9wc9KgHL8aa14dGhsMQUsK37ChYh4J+Gjq0hSigBKLtRmk1?=
 =?iso-8859-2?Q?Th6Tmma39RsBpKIBuiGTldka8eJC2/JzxE0LimbtAnlur1jcyXHSv90lSw?=
 =?iso-8859-2?Q?F4KiWQdhj8ar6b2P4U/clv0oYJCM8EoZAJF9Xcje++ZtNZDltfzhnj+1fV?=
 =?iso-8859-2?Q?8j3Zk1yqZ6qQBoOwcnjrOnKKc3IIW5CQsNlfVq6RMX07q38YodAui87W21?=
 =?iso-8859-2?Q?lJaAMJwZKPer3X2ULPsbfY5hrQ1SyStnZlvd3PIR6an2Pi6j3RIuZ31+uw?=
 =?iso-8859-2?Q?E6yF1DQdiQQzymsnlV/oOD+uGNqEdeS0kdffs+Sg0v40IQIRj2JtIn10Fu?=
 =?iso-8859-2?Q?sUJE6sfft00f5BrE+Ta8G7fHvXaln3vzZgKdWIcmhosJbsa0CyllGnth2R?=
 =?iso-8859-2?Q?ObtBDIV/9jGkeTjO/TjvBOr9HcUMW5vPIW/MpRxwdiGSeRp1CVXIxNbKtY?=
 =?iso-8859-2?Q?VcBLJ6GY9I2nq0Tk6Kf7XmWt5hxCBj7XwLd5PPNndspo7e339Mb1MrNIz+?=
 =?iso-8859-2?Q?Bp/ocbDkMosdfJTB0mARE0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?tYybXRuOFVzSFqoKn5WJq7/pM/AUKWPI/6gaKnRdpX1osAwd2t1KAvGoxR?=
 =?iso-8859-2?Q?36L64uYq3gi1/WEUyehCbIqLXCXjbR38nzZXTbIgIYapBKpjq4ygJDcu8R?=
 =?iso-8859-2?Q?QRFZ3IWeTijGtMQvqIG2MVP7nZcUC/rZ/URWBc5eEjQgZmPNTc7N7ZXeyP?=
 =?iso-8859-2?Q?603PndAvtqD26ZAqtSMnIvKsaNyhZpP+LoIs4HUsGTd95vD+gdo+uXEizP?=
 =?iso-8859-2?Q?zz6zpabIefXEXtwwYUjdgidXXarkTTgGzrRKQs4fz65L94nhfGYjsu4xh8?=
 =?iso-8859-2?Q?c0iNjzN9vXxXjAc/5YWlZwCP4y1LBvkucq5kCNcDRuD/CV8m/PaU4ke3Pg?=
 =?iso-8859-2?Q?lpA3wi1qx4MyD4vddDKlBTtLB+oXwzLqJ2UzBz80Q7TX6iWPwZAwSlThld?=
 =?iso-8859-2?Q?lDFQKlmdJyQ90bjhb8wdgyZm/87JdoAhTlo6vluLd1hHUArqO2d6Egau1J?=
 =?iso-8859-2?Q?1Zx4Un5Akq+Mwh4wMyyenLeMjw8lj9SAEadRR5p3DTwmDAjBpl3K3p2Vub?=
 =?iso-8859-2?Q?33Z+Rdjvcya1xP/LFLwZ7hOXMvm3/c3j9bbYU3soEkF83qhOrfCbDTkWBe?=
 =?iso-8859-2?Q?4ZQbQjUjibJyQp72oxLjwj+VG+Tl+xdClq1a7cxwQEE7nBOE6zeAmo11+v?=
 =?iso-8859-2?Q?+4z9hNZxt7F9g/y7WJi/saPixW4EPaU4neTXUTAQha+ps4ZmLYUOZkTbd2?=
 =?iso-8859-2?Q?+XtysAlzDbuQpNBJqmS4AeFA9jX991RBOz2Mi0WqR1AqvU0DYAfeiKcOPG?=
 =?iso-8859-2?Q?OHESE8Rlj+69qLbqLoBrmddvqp/cV8H3ASsQ3Q+QJcWv8hiWCnSLm54Pem?=
 =?iso-8859-2?Q?6zBW/clplTuQ/f4IA/MQ97gj37RTMt18S6oILsZ0S0bWWiwQvaPXSYjU3T?=
 =?iso-8859-2?Q?nDzZk+EG26R5ocCnMuMJw+b/1JBVuta8K/bZxOYbZn6m2126vI1AQC7yK1?=
 =?iso-8859-2?Q?UYM6Zkn2Irw+ceMgFw9LnlQOSsLYSJa/McNnVCvbPWlAxsdMV4637DF2wL?=
 =?iso-8859-2?Q?BsSlMdTkZ2gMdHgjMGjcQ7frMt0VrprNRH0/4CWHfPd7rdYLvtwZgv6/zf?=
 =?iso-8859-2?Q?5tAlIN7oTGRrDLVvbMzhe39Ae5ssVCHzlGLKsWuR2Ysqr2EMPmYAEWY4YK?=
 =?iso-8859-2?Q?mj9okfaBUP6YNCxyOXktii45qHClXETwa5+xwNBvKtqgO0lvvJflh08PAq?=
 =?iso-8859-2?Q?Im+Q6fRiGi5GgeDCw42aLi9pRvyHDtkH7GteIlCwQElyimkP6au+0h8G/v?=
 =?iso-8859-2?Q?3QqZx171bcznJhSov1K/tj58sp2z0HvN2/e1JmMNpUEL25J4EeDocvOl+Z?=
 =?iso-8859-2?Q?BaTrj+CK2jyj1rLjxLlnXKxPrZz2ixHogrL2K6BKPcywU18IyTXJPlmk+3?=
 =?iso-8859-2?Q?aw+GDj42o77sUx2PBbZCKGfhjB+ciVN4G44h2LtTb956cPzNbbHyr6FgKl?=
 =?iso-8859-2?Q?n74zwUtfVCqZNMeYgkPX7TomIstsx/cNZvQIrh4npB0ZNLJU6Y0Eto4mkF?=
 =?iso-8859-2?Q?HXe4lx5s8zWNHIEe9pKPO8BSazwJlpzn157Y3AaQEMiUKeWmb9o1MbZMXY?=
 =?iso-8859-2?Q?CpORpEjMXkGvAWURbUa3dekgreqAxpMIsusIGwXmm0Jb0PRHgtRyi1FQ6+?=
 =?iso-8859-2?Q?DwsDDfexBQ3kx++P8q1cOsMl/O1+5RD66t5Z2uz5upGLgTtDBE7VXvIfyl?=
 =?iso-8859-2?Q?6sCHzbUQDQZ8knHkiSJBruGa3jvy3FHOydJ6NzKK?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547beb01-1e49-4803-7806-08dd4ae20c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 21:21:29.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62ssIvNQpGmg+dIkQlTP7QiacSSR80juKmF938P9VJu/IhmOyiHZhQkHwQIaklUjKr0yWaPyQYg1QbBf9wlAundLk5r/dJXHsINI1n+9l+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

On Tue, Feb 11, 2025 at 01:21:28PM -0700, Pathak Asutosh wrote:=20
> On Fri, Feb 07, 2025 at 03:04:34PM +0200, Heikki Krogerus wrote:
> > On Thu, Feb 06, 2025 at 03:51:48PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Feb 06, 2025 at 04:19:31PM +0200, Heikki Krogerus wrote:
> > > > Some of the UCSI commands can be used to configure the
> > > > entire Platform Policy Manager (PPM) instead of just
> > > > individual connectors. To allow the user space communicate
> > > > those commands with the PPM, adding a mailbox interface. The
> > > > interface is a single attribute file that represents the
> > > > main "OPM to PPM" UCSI data structure.
> > > >
> > > > The mailbox allows any UCSI command to be sent to the PPM so
> > > > it should be also useful for validation, testing and
> > > > debugging purposes.
> > >
> > > As it's for this type of thing, why not put it in debugfs instead?

The intend of this sysfs is not limited to validation, testing and
debugging purposes but rather providing interface for major user space
application developments.

At present we are working on an application/ user space service which=20
will be calling UCSI read/write power level commands. But in future
there would be more such applications which may require additional
UCSI commands to use. We wanted to have a common and=20
generic solution - and hence thought of going with sysfs interface.

Issue with debugfs is, it is default disabled in release kernels. User has=
=20
to rebuild the kernel if the application is based on the debugfs interface.
This will become a bottleneck for wider use of such appliances.
> > >
> > > > +static ssize_t ucsi_write(struct file *filp, struct kobject *kobj,
> > > > +			  const struct bin_attribute *attr,
> > > > +			  char *buf, loff_t off, size_t count)
> > > > +{
> > > > +	struct ucsi_sysfs *sysfs =3D attr->private;
> > > > +	struct ucsi *ucsi =3D sysfs->ucsi;
> > > > +	int ret;
> > > > +
> > > > +	u64 *control =3D (u64 *)&sysfs->mailbox[UCSI_CONTROL];
> > > > +	u32 *cci =3D (u32 *)&sysfs->mailbox[UCSI_CCI];
> > > > +	void *data =3D &sysfs->mailbox[UCSI_MESSAGE_IN];
> > > > +
> > > > +	/* TODO: MESSAGE_OUT. */
> > > > +	if (off !=3D UCSI_CONTROL || count !=3D sizeof(*control))
> > > > +		return -EFAULT;
> > > > +
> > > > +	mutex_lock(&sysfs->lock);
> > > > +
> > > > +	memset(data, 0, UCSI_MAX_DATA_LENGTH(ucsi));
> > > > +
> > > > +	/* PPM_RESET has to be handled separately. */
> > > > +	*control =3D get_unaligned_le64(buf);
> > > > +	if (UCSI_COMMAND(*control) =3D=3D UCSI_PPM_RESET) {
> > > > +		ret =3D ucsi_reset_ppm(ucsi, cci);
> > > > +		goto out_unlock_sysfs;
> > > > +	}
> > > > +
> > > > +	mutex_lock(&ucsi->ppm_lock);
> > > > +
> > > > +	ret =3D ucsi->ops->sync_control(ucsi, *control, cci, NULL, 0);
> > > > +	if (ret)
> > > > +		goto out_unlock_ppm;
> > > > +
> > > > +	if (UCSI_CCI_LENGTH(*cci) && ucsi->ops->read_message_in(ucsi, dat=
a,
> UCSI_CCI_LENGTH(*cci)))
> > > > +		dev_err(ucsi->dev, "failed to read MESSAGE_IN\n");
> > > > +
> > > > +	ret =3D ucsi->ops->sync_control(ucsi, UCSI_ACK_CC_CI |
> UCSI_ACK_COMMAND_COMPLETE,
> > > > +				      NULL, NULL, 0);
> > > > +out_unlock_ppm:
> > > > +	mutex_unlock(&ucsi->ppm_lock);
> > > > +out_unlock_sysfs:
> > > > +	mutex_unlock(&sysfs->lock);
> > > > +
> > > > +	return ret ?: count;
> > > > +}
> > >
> > > This worries me, any userspace tool can now do this?  What other "bad=
"
> > > things can it to the connection?
> >
> > Although, there is actually only a limited number of things that you
> > can do to the connection using UCSI, that is definitely a concern.
> >
> > The PPM (which is the EC firmware in most cases) is expected to prevent
> > any harmful or "unauthorized" UCSI commands from being executed, but
> > I'm not sure there is any guarantees for that at the moment.
> >
Critical power setting related features and options are tightly controlled=
=20
by PPM/LPM. In such cases, those UCSI command request by user space=20
will be blocked by PPM/LPM and will eventually end of into DoS.

Moreover, to further mitigate the risk of any malicious attack our=20
understanding is this sysfs interface will be accessible only with root or=
=20
super user privilege.=20

> > > > +int ucsi_sysfs_register(struct ucsi *ucsi)
> > > > +{
> > > > +	struct ucsi_sysfs *sysfs;
> > > > +	int ret;
> > > > +
> > > > +	sysfs =3D kzalloc(struct_size(sysfs, mailbox, UCSI_MAILBOX_SIZE(u=
csi)),
> GFP_KERNEL);
> > > > +	if (!sysfs)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	sysfs->ucsi =3D ucsi;
> > > > +	mutex_init(&sysfs->lock);
> > > > +	memcpy(sysfs->mailbox, &ucsi->version, sizeof(ucsi->version));
> > > > +
> > > > +	sysfs_bin_attr_init(&sysfs->bin_attr);
> > > > +
> > > > +	sysfs->bin_attr.attr.name =3D "ucsi";
> > > > +	sysfs->bin_attr.attr.mode =3D 0644;
> > > > +
> > > > +	sysfs->bin_attr.size =3D UCSI_MAILBOX_SIZE(ucsi);
> > > > +	sysfs->bin_attr.private =3D sysfs;
> > > > +	sysfs->bin_attr.read_new =3D ucsi_read;
> > > > +	sysfs->bin_attr.write_new =3D ucsi_write;
> > > > +
> > > > +	ret =3D sysfs_create_bin_file(&ucsi->dev->kobj, &sysfs->bin_attr)=
;
> > >
> > > You raced with userspace and lost, right?  Why are you dynamically
> > > creating this attribute, can't you just use a static one?
> >
> > The size of the attribute depends on the UCSI version.
> >
> > > But again, why not debugfs?  I'd feel a lot more comfortable with tha=
t
> > > instead of sysfs.
> >
> > I would actually prefer debugfs for this, but this is in any case
> > not primarily for debugging and validation.
> >
> > The initial goal was to supply the user space some way to control the
> > EC's power related policies using UCSI commands such as
> > SET_POWER_LEVEL and GET_POWER_LEVEL (guys, please correct me if I got
> > that wrong).
>=20
> It generally feels that exporting the whole unmoderated channel to the
> firmware just to set power level is wrong. It should be interfaced
> through the PSY driver.
>=20
> >
> > But I'm now again wondering could those power policy tasks be handled
> > using the UCSI power supplies after all? Venkat, did you look into
> > that?
> >
We are looking into this to figure out if there is any best way to expose=20
power level settings options using UCSI power supply class interface.=20
But even so, I believe that also does not completely eliminate risk of
any malicious use.

At present we are working on an application/ user space service which=20
will be calling UCSI read/write power level commands. But in future
there would be more such applications which may require additional
UCSI commands to use. We wanted to have a common and=20
generic solution - and hence thought of going with sysfs interface.

Issue with debugfs is, it is default disabled in release kernels. User has=
=20
to rebuild the kernel if the application is based on the debugfs interface.
This will become a bottleneck for wider use of such appliances.

Can we still think of going ahead with sysfs interface and double make=20
sure to make this accessible only with root/su privilege to minimize=20
any potential risk of bad uses?

> > thanks,
> >
> > --
> > heikki
>=20
> --
> With best wishes
> Dmitry

