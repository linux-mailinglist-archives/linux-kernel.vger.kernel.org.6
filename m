Return-Path: <linux-kernel+bounces-285860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21988951383
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD353284094
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F84D8AF;
	Wed, 14 Aug 2024 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j50UTzqi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989733CA;
	Wed, 14 Aug 2024 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723610172; cv=fail; b=o5ku539q6GwyvDMLjzDiRYJ1Nx7Xwh/VUWXD/HC7irZpjO5tLQl9DbScz7nnCtmaVBmA2IjtF4LOfQRUVORauAotkyjfGx94IlelGWU5TBRTDKqYTq0nmsDrg1mMW2uKd9uomkVkEV8yHVnUK9regAVl4gs+1vjFuAVyFhL9obw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723610172; c=relaxed/simple;
	bh=41TheGVcww8XzONHQ9YwSHpEUVwtaeF5gpeLUETzoYY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cNx6/FxA0lf1bOByMd33dUyKlFDoGY+3nivYuvAkXmVb4Emoes2h5hszFcmYgwGRHhVOg+qJJOkIRwrjjoXZf7fEO3sM0jjlRD29ijT7CTGLt8b0D23IU2cxWLaip01y143/HGNUL15h8ZXr9QH4Lep2XUAvM8tvUgCXY4dTQDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j50UTzqi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723610170; x=1755146170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=41TheGVcww8XzONHQ9YwSHpEUVwtaeF5gpeLUETzoYY=;
  b=j50UTzqiBq7j8XexrN4LMjAsZOOmefe9WgOZUR+4GReUJJZ6YWlKwQA0
   dpxa3f+loM2NWPmbSLTdqvItBTLsQd7y4/AqCu5hQNa/aubgFnlUHcCKX
   DHuRgeWOCkHadW9kTtGXRadqAHFoKk7Ld6FHMOM5AsnxOLQ8qJcYT3ulE
   mFePwo+DHw5KO4i+ktWuOhIKgBf80qJX0htWNjOSKI7CB7Cj4fPyDwg1t
   onGmah/6o7mO7dChZXVQsMw3qN67ntd6JIYohNeRD2mGB23EcPiiON5B1
   YoLR8CEbg36w/vCHM0UiXnC0GBihq3tw4pBxZl/Ku0mvWtzaLJ6ci4UNS
   A==;
X-CSE-ConnectionGUID: f0g8GP4WRRijiXnkzvhrYQ==
X-CSE-MsgGUID: zz6aJ+TZSrqEXQ+5g93LqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25604768"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="25604768"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:36:09 -0700
X-CSE-ConnectionGUID: 2jktuyWPRYiuvqem6kAMUA==
X-CSE-MsgGUID: Cp/3SrLpT9OF+Xk27c78ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58878436"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:36:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:36:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:36:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:36:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bStjYZfvrlQwNGcpRNnMYMLhM3H5KAJ08cW06YIwnjpOTIWpeogZ/wd/uZ8qg7aBPZdiTCrNZkVrXKZDmNPcAwiVqP3lk9IZpqlLp7yEUSVRnfYad071hCkESMbMFA0oXDH4LR5nl3gjRPrGz3y1xbMQvjbvcMt9a/X4lCVkoL5hXFpGxqu1Fu4jD+9+RU/mNAAK2LMcJubLhSRfabrYrlGsF3JnvvFaCZ2o36gjPaDq1unzHBH0dkVRIcUle0uX5nw8xB9xV5RZITByf83sRhLCq3EEOLe4jBbHSyhpiB2o2Ia1/AVAZmuZJrhPUQ7Anl3QL55KpKyOoBiF11qSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1ECqgpxGrVXT4HhL5Z2ypn2gLJobZJwkYlArLgWDl4=;
 b=g8b/ztv6U24zyg7O5BNwKWGwmDB6CbLOtjSY9LrWbeVA1EkDOBs8GV/RUnITVBgIEEbzCKpONgbsPhtzIrOxWJcb0u6/oU2yC2yL+yFiB/Ftqu9h9ikQcnkgjtJcKEJ+xMmMIGTATnCacmLjAMWMAZugp/A+nSDAqNCKlPCGlsYqgB7s5MBw5HbkqWhvWjNhzUZzsRO3+mv10yOzdh5UeBblK5AzTcubQimkcAluExaK51eRfyAQJllIkRUjOrpDCRRfQF6w2owMoBOavOq49Rt5lfzr6fT3ZjNSKjvL1nhBku7TGl9bVggDmrjjyfRLNY5r6/WkPtDU9Q8iEUDnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by SJ2PR11MB8499.namprd11.prod.outlook.com (2603:10b6:a03:578::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 14 Aug
 2024 04:36:04 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::7d59:aa70:2555:e6fd%5]) with mapi id 15.20.7828.030; Wed, 14 Aug 2024
 04:36:04 +0000
From: "Mohan, Subramanian" <subramanian.mohan@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "giometti@enneenne.com"
	<giometti@enneenne.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"Dong, Eddie" <eddie.dong@intel.com>, "Hall, Christopher S"
	<christopher.s.hall@intel.com>, "N, Pandith" <pandith.n@intel.com>, "T R,
 Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: [PATCH v10 0/3] Add support for Intel PPS Generator
Thread-Topic: [PATCH v10 0/3] Add support for Intel PPS Generator
Thread-Index: AQHavHw4HwBpHDuB80W1a11GH1dPprIlOQqAgAFUOoA=
Date: Wed, 14 Aug 2024 04:36:04 +0000
Message-ID: <PH7PR11MB5862AE3F6A9E446A24170064F7872@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <2024081330-retouch-platter-f21d@gregkh>
In-Reply-To: <2024081330-retouch-platter-f21d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5862:EE_|SJ2PR11MB8499:EE_
x-ms-office365-filtering-correlation-id: d733fd23-e06f-4eb1-98c7-08dcbc1a9b9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?izgBWHJA9S909z/1Fni7uRdaeoKR2yjw45qABHxOfxrj5QvjXIeeUMc9Dc9G?=
 =?us-ascii?Q?yMYQGnjsh5T6sRc5excW/TMRyb4IBoxkvCnBYr5OV4Ec8NcA07V9MnL0U26o?=
 =?us-ascii?Q?g8Nj281leMcX9lrd3Aq9BLbbA9D8LKh2XG7WuqpchqvkUUDIHfD4bPw/fY88?=
 =?us-ascii?Q?nEHMFCXoj4TmunyW8ttIRAUPN8VvXWjagz973N8f9GUPlSqHomtYxqsp4zP7?=
 =?us-ascii?Q?4tedXRIpzy3NKM0dNSyN6cDtcqucJE6e+b38p77cCHamw9mFgsYNl35V7RHw?=
 =?us-ascii?Q?vz8CauucsxyqccIHs08MoALed2YU0rp1R+g5FawXq/bmmg4ceKeEt05KTX/a?=
 =?us-ascii?Q?XE9zWMo7ee/yFOte6JeAyylpk7LkGyxInyTpAxQRKdCnxgbQur/S9gFWTGeE?=
 =?us-ascii?Q?/hJTUodL3UeKZhH+98pmBa5IEEq/u7hseZ+1rSbS+BbsbyhHoADehcCicEje?=
 =?us-ascii?Q?BCJCsJ7gJJN/+uYj2k7RizY7inP69wmn/C8pI9+Hy8a1n06CRea18nS9NU8q?=
 =?us-ascii?Q?33utoGBLfiUHDt434ppWRaIP/6dspwsteAlIAYzK0TmJet2PEcnln3h+w4EY?=
 =?us-ascii?Q?tMy9+MGsVwrD+0AppT8h499p7cYAouxztNdTK0J8vAjy1PQTgQ/l2/YlCpD0?=
 =?us-ascii?Q?AIcoUXBKZFrIeSet/+XisG74JiPMqSKTcYz7HAPyt0l/qihE0nvRQ7mIYhBP?=
 =?us-ascii?Q?RG7LI68kD1yYtj2AUDEoiT60jQuAgae2lEo4c2EmCz7NZisUQMjntAhDnpop?=
 =?us-ascii?Q?Tk3gVqZzAR6oL0aOJsPdbjH2YS8TVWxdZ3Dd/YYGdQK7vghWZ+YqipT0r0x5?=
 =?us-ascii?Q?zKlWiwd1NOT+w9JFbcRP5iFVoUzxUmVqHeNjjbNQf+zqonzv2Ke0Wq8eeNtl?=
 =?us-ascii?Q?nhlF4bOT1/OdzgDkKOmu151dPxNeQhF17Mquxv7v23uOeqM2W2mOcOKbA9eO?=
 =?us-ascii?Q?oRxNwnzqzIbHFaw1/cJk7Uo/Z4K/ZI4tpaXYDvezCtyYFdVq6PLYQ+IPCtOa?=
 =?us-ascii?Q?9ohCB4+Mfj0Pz7fn4JxgbOPwLPALl3gZLO9W3e2qanzVZDV1sETleklBVHX0?=
 =?us-ascii?Q?9/pioBXq/nEG/BRUVEK8teyGeMTDGUm4iyue/jL65YrNDgDL2vSUbiwLzuM5?=
 =?us-ascii?Q?uSIX8XllxsEv2DivZxKTZzuEbAydVexvM0HK7CkrfrmvwQGGBhmKbTm5qRPi?=
 =?us-ascii?Q?eG945qbFTHpns3R/PeSqfISBxKSpn9qoFR72ydNFGxZuAlNvGthbUxgzAHaZ?=
 =?us-ascii?Q?GdOftcQfOpm1i63KSOOw+EFCr42GboS+pL13CzmDK9meQEvP9EEtAixIMTMg?=
 =?us-ascii?Q?XZXEV3lLTLSNOLR6AIFjSS86cy5T7AyVyXnt0s3dV1p6HQQ3HtowF1eWZbZM?=
 =?us-ascii?Q?2nxL5Og=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ki/mdq+fijNMK4NBN1MU8yVGhIoUHfrolP0BuoWxcihEbvx2jsmHhioJYFhA?=
 =?us-ascii?Q?ktv/ucyDr0txTXx8XMpQmeIqkcY+3AXr03C3ffl/xfnh3u9ofsEoUX3lAMD6?=
 =?us-ascii?Q?xGgGCUahS5hDCepYLz9tSM/V+ApUU7cdzXw+mWSw2HVjvYoinD2BgbnIp3OV?=
 =?us-ascii?Q?NlXTsacWPgtWHN+qCxwiY+S5eHInvbn6SFZNANCtpmlkHOuBAfUQV+KmAR3O?=
 =?us-ascii?Q?5tDdcOQmSoPVLcd4cG3yV5wJHebBoIAa1KqJ30e87un0D+ACR11vQ8cFMQGQ?=
 =?us-ascii?Q?e0qfrJOHKJPhivC/2/UpVHvblYCAhmVV+51G7RiQhJaMTp7Qj1B8u7hxIDrV?=
 =?us-ascii?Q?6+8jcJAesX674w8Gz1GrJsiI8AupiUA9YR3/pRnVlpl57xZFTMoIq5OwH1NL?=
 =?us-ascii?Q?XjFea65HH2Ct+pa2r8gSWsdSo//S7ehMu8dLfdFU2TjOa26onkdD9rc5dcio?=
 =?us-ascii?Q?Cn0+uZh+R/VeCaPgi/QPSo2ERkqvO7Z1sLha7cDCNTmXiTsCMQD6wGFUt7MD?=
 =?us-ascii?Q?edfJJdjJg9ZxvTmmtybJc6IxzOYt62C7epHIE3HXeJS7AHOVNr5yH84qUM+K?=
 =?us-ascii?Q?UOTrQ1ErSx2/ZiKWpSbH3nhfJZ5apMz9vHz69N3rwBvoTXjKREb8XOHcZjrs?=
 =?us-ascii?Q?OQDLD8gX2808LWjU7wNh1Kn63DgoR/lMdL81rCQph75bJ0SCpivOYMbm7rJQ?=
 =?us-ascii?Q?0paj4u3gENf2Dp4olH90nR0iYhHP7dfbEyum7q21UWC1TayJ0Zp1qmj1E0ae?=
 =?us-ascii?Q?Fy85kwFCVBPh62mIigG6pEChQpe3waA+zQgLtG9Yi+Hs9OqniLt4HLLwZDD2?=
 =?us-ascii?Q?c/S47agTSDOtdlF+A5RyZ6+sDSZe+D6pR3JCBntf/KMbm67Y7g5O5w4yIfhP?=
 =?us-ascii?Q?3rx9dsvJopR1IFuiDfRa9oNUMt9p4ektho8Kx4Vo2AmVXdCIIQe/Zje92NmX?=
 =?us-ascii?Q?hs6y7q9ERWKjbVDTxn+EVJy4tKmBkx98A2LJb1boLBJiqqcEzBemOC6KIbND?=
 =?us-ascii?Q?Od+yeYATP+yhDQ88wnzY/PF8gfOcaROPlNSlwZNhFbKLu6YHiDxnlFP3ufZK?=
 =?us-ascii?Q?2Ka1Qxy7Xkzk/xq+C1qGw02lfpcaQvofmnuQGq+s0j5Guy4g6DQ4A6E0EnUa?=
 =?us-ascii?Q?AZuG6K/nPt669VOkDN5QcOy5pzjj1bNqYkeFyEJ+Jc8WDDBPHejfSll6qMxK?=
 =?us-ascii?Q?EbSV0R/SHJMLwCo3TjbQdbAd53yA36Iq1VtwWygG8Qc5tobeTLCzBqIii5a8?=
 =?us-ascii?Q?bl6La7lXt5kE4quZwP7/CvWVr58/BpMiRFjfEZnPi3XFce8MlPk9pi1PirX5?=
 =?us-ascii?Q?vR+tD27JjMuY7SXKaRZdTf1R7Kc80TgVt4Uzw27MbdAxc/WFjOE0r86Ywi3F?=
 =?us-ascii?Q?hDF5iy4ogtNSRrn52XEcVRRxm+ucU6HqehtsuA8DdlbPHSWxfCCor+4r4uoX?=
 =?us-ascii?Q?MgFvpJBVAz/xW1WL63Xy/BOd4v+4GBuc+I4obaGLYDofL5PhH3bV8QL/Hc2Q?=
 =?us-ascii?Q?eq1UhtlVLS1UlnKUyia8k+oce87BoQe5Ja9aEkoHA+oAJjFi7+3mFTTPA0Ta?=
 =?us-ascii?Q?60Zarw/Qk4MAv1ioEshOX/ltfLp6YdOrPlERGuSd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d733fd23-e06f-4eb1-98c7-08dcbc1a9b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 04:36:04.5377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWc7Ezamq4PG3RmSsOoq10Rzb/U63mKv9Kc9zTna6TmmE7haGW4Qhgx2FcO4gQzDeiYo/UjNiyLczTqms9ia+dxpxn8bjGNWwA+qgzLdCnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8499
X-OriginatorOrg: intel.com

Hi Greg,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, August 13, 2024 1:46 PM
> To: lakshmi.sowjanya.d@intel.com
> Cc: tglx@linutronix.de; giometti@enneenne.com; corbet@lwn.net; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; Dong, Eddie <eddie.dong@intel.com>;
> Hall, Christopher S <christopher.s.hall@intel.com>; N, Pandith
> <pandith.n@intel.com>; Mohan, Subramanian
> <subramanian.mohan@intel.com>; T R, Thejesh Reddy
> <thejesh.reddy.t.r@intel.com>
> Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
>=20
> On Wed, Jun 12, 2024 at 09:23:56AM +0530, lakshmi.sowjanya.d@intel.com
> wrote:
> > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> >
> > The goal of the PPS (Pulse Per Second) hardware/software is to
> > generate a signal from the system on a wire so that some third-party
> > hardware can observe that signal and judge how close the system's time
> > is to another system or piece of hardware.
> >
> > Existing methods (like parallel ports) require software to flip a bit
> > at just the right time to create a PPS signal. Many things can prevent
> > software from doing this precisely. This (Timed I/O) method is better
> > because software only "arms" the hardware in advance and then depends
> > on the hardware to "fire" and flip the signal at just the right time.
> >
> > To generate a PPS signal with this new hardware, the kernel wakes up
> > twice a second, once for 1->0 edge and other for the 0->1 edge. It
> > does this shortly (~10ms) before the actual change in the signal needs
> > to be made. It computes the TSC value at which edge will happen,
> > convert to a value hardware understands and program this value to Timed
> I/O hardware.
> > The actual edge transition happens without any further action from the
> > kernel.
> >
> > The result here is a signal coming out of the system that is roughly
> > 1,000 times more accurate than the old methods. If the system is
> > heavily loaded, the difference in accuracy is larger in old methods.
> >
> > Application Interface:
> > The API to use Timed I/O is very simple. It is enabled and disabled by
> > writing a '1' or '0' value to the sysfs enable attribute associated
> > with the Timed I/O PPS device. Each Timed I/O pin is represented by a
> > PPS device. When enabled, a pulse-per-second (PPS) synchronized with
> > the system clock is continuously produced on the Timed I/O pin,
> > otherwise it is pulled low.
> >
> > The Timed I/O signal on the motherboard is enabled in the BIOS setup.
> > Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>
> >
> > References:
> > https://en.wikipedia.org/wiki/Pulse-per-second_signal
> > https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-
> DxLW6t_V/view
> > https://youtu.be/JLUTT-lrDqw
> >
> > Patch 1 adds the pps(pulse per second) generator tio driver to the pps
> > subsystem.
> > Patch 2 documentation and usage of the pps tio generator module.
> > Patch 3 includes documentation for sysfs interface.
> >
> > These patches are based on the timers/core branch:
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=3Dtimers=
/
> > core These changes are dependent on patches that are merged in [1].
>=20
> This series now breaks the build due to api changes in 6.11-rc1.  Please =
fix up
> and resend.

Ok, will fix up the API changes  and resend the patch series.

> thanks,
>=20
> greg k-h

Thanks,
Subbu

