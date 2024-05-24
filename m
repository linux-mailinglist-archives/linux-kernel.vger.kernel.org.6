Return-Path: <linux-kernel+bounces-188195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40F48CDF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA6B21EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFCC6116;
	Fri, 24 May 2024 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Se9xdCc3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96041109
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512731; cv=fail; b=atdR/cb/eqBN6YyPOdpO2MDwz9l/x3FhPbCQyy9MaErVy1bgSxhdiTEEFgV4lIRy72R+kTjmhxZUMrBxDbSUIec/4VnyoKBHzY08y1MsSofEg1IomzOUqDCZNHh/FF0Qpy5PGbPKw5YWWpX40RIeyG/GjxGMUqOoOyBX/MU3jE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512731; c=relaxed/simple;
	bh=+WtxMaOFykwKglwvb3UwcKatfdJdKrN04yrvZhH7XjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IKP+2E/SC2MVATjFaXqEvsvjdowr5so6s11zPRqAbBoeYi5qwl3N81raoYDlzaW0vfo1qIT7N0jLQos34UdgSHHbJ3jj7aJrzC5ccaUwGv5d/mRfEwT9AV+ru1wKD8PQtVVZeGemzbYkw3QYwIwI/22/jmLvgG3oMy27mY2mqrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Se9xdCc3; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716512729; x=1748048729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+WtxMaOFykwKglwvb3UwcKatfdJdKrN04yrvZhH7XjQ=;
  b=Se9xdCc3T6cC9XUcM6UBMcHm78toOQgVsqUiNd4b3YTj8cPPgaI2asRi
   dvBSVzGx9MfzyjsOSLtlu2OOfRVIrhnsK+v59uXVcoRbUtlI/YG3Z+/33
   f/wZjvsH/vEOBx/jXySNoY7m0jUJ1wKECUVqaMhGujBSvDFYp1zRswFcR
   3p+5EPEXiBBhocwGlEr65EjJDuoi7m1RIg1NU8Gr3elsPAfM5zIPCSNgG
   T7HaJpu1GOJ1nnWeqEGcvC3KZAKdUgbPCbnV6j8m12HvlSnRmuc9J93Wh
   5eIm5kY1VmTZB/r/zIUNmEfLKKayswteVP8qS2PNrnmtu/xjwKXoQCsL2
   w==;
X-CSE-ConnectionGUID: 3/985VkkTWaoJx81UNkSKw==
X-CSE-MsgGUID: dcngH//6Rda6+qn8zXKsvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="30374430"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="30374430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 18:01:50 -0700
X-CSE-ConnectionGUID: foPI8NPQT3uAygnqHBetOw==
X-CSE-MsgGUID: aEfggjxNQY6SbC9piJBmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="33730568"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 18:01:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 18:01:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 18:01:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 18:01:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 18:01:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmhPLHPUrYo0IQlwozNwA6ZvkAoOjLlTdGKysLoTtiEO5d0ciwafpRdvWe9RDJ03UQ4bntrX71xBkXazPms6FppW5RURlyBWzKsn7rkLrsvZ3wGbyZUPUe8nDT9Wzl10V/0LY510YI62BVGfn2IgOhL+vMKXcsOzcD19BGrG8b2mPGC90C5EBXkb/a2PXfKyjLE3JNOvL8ls8TeORAKi9x45geqbEzNDHP0DcHCXyhY+20M5cSyAKP5SMeOUVSTCvz8siY3OtKJ9stLWwohPdxpUceocZCghnSwkj378noiN+nZl3KtYaONrZyaBJH/Q3wJ409T93I1jaHE/Jqeuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYppio94qHwOWEAi2DX7oFaDG/0u5ZYEL6yGts64Zu0=;
 b=kOIsxlTel/c3oS850/F8/XiA5xeGBYtTE1vZsRiIFZ8o9siy/rYWFtlBlfrFHe2WQgYIEPHYTRC2XfROuLPICeWRLtqqk3rbPnOzDMEc2NTqaIgWp8O/BYAYhW40RRv0rqpi7WTrrabipz9W8HfsrSuTu/7mMKk7Zh4QQHyJRFeIHD3ffTk/sxwtB5lg+UcJO+tUypGFfQS35Em+URqezLELtyFbHGLQVrKtPp4QrKfJ7RM5OSjPAcqCBmltUPZGIIcIljaaE2k/9JNwiVDFx+cE3xSV+cxOUprIfn/yEmLY01VInq+jdgGbMRxuly+suDlx1XHd1W/AbVy8oCWl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DS7PR11MB6175.namprd11.prod.outlook.com (2603:10b6:8:99::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.20; Fri, 24 May 2024 01:01:47 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::4046:430d:f16c:b842%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 01:01:47 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Qingfang Deng <dqfext@gmail.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: RE: [PATCH] riscv: hweight: relax assembly constraints
Thread-Topic: [PATCH] riscv: hweight: relax assembly constraints
Thread-Index: AQHarPW0mKA+dDLouUGCTB73Tx9JyLGlj16A
Date: Fri, 24 May 2024 01:01:46 +0000
Message-ID: <DM8PR11MB57515218B467E28FFDDB6703B8F52@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240523094325.3514-1-dqfext@gmail.com>
In-Reply-To: <20240523094325.3514-1-dqfext@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DS7PR11MB6175:EE_
x-ms-office365-filtering-correlation-id: f6b36cc0-f439-4951-bffb-08dc7b8d1615
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?Windows-1252?Q?N/72xfG4EGxN2A6w6udPKi0psqoc9VGvTC4i1FihJhjEWknPTj32qfau?=
 =?Windows-1252?Q?i5hDuiaQgxiSdUo2oxPAD5jSc0kRoKwbx6KJEp1hDs8yvjbMaXZCOtu+?=
 =?Windows-1252?Q?aoBPJLt8L5xtA1hNZBTBMR6QlsCtoG37WwbOXsuTqDTVS8sfvugD+Pno?=
 =?Windows-1252?Q?w93N5U+37LNXvtnZJ8N0UEwCefXrZq7zo3Ogt/fXetNibcjAcvUgK7Px?=
 =?Windows-1252?Q?DtvaMUBDT8ggfeWTqZgs+REfDoY/fyHMc2kEYCUwqNH6yPkjIvj42mEG?=
 =?Windows-1252?Q?8/jvxWoi9R5iAqYImmp5QBRdBjIzNCDy9EPrSd8NTGfseNsWgtEMWvv8?=
 =?Windows-1252?Q?qaCCC0GdWV0Kd10nsD+6VFbM9iUIuwbg56r8qYYrIE9VglkkuQtDgdi1?=
 =?Windows-1252?Q?0x/eYk4bYe7j8LEYEeQP9Ab2XOuN6tCDPM1wFzz21/e+n4v8gKx01hqC?=
 =?Windows-1252?Q?DY6exIfGU0lJCMa3JDkofjC7fUrNfVY9BfsBwcWFuiiul5y7Pf4BPS+T?=
 =?Windows-1252?Q?BB+qSHWYVWJSa1YBQojf8cpPNjUdQBRHQ81Gz2IrUAf8vMZRkoAhVUsu?=
 =?Windows-1252?Q?BbIT9QpdT5UaK9lqn1TZCLGLq95UdmYXBXjryKVaH9wbCtzAiisxBZrE?=
 =?Windows-1252?Q?96DRP7Lhwxq4wPbZ9wngY9RfQ9lzPX7UtfKKl17Ljai1O4b5GTCQh1p6?=
 =?Windows-1252?Q?n8S4EFcNbgzse8lr6lMwcVcfYNnkOZqjV3K6066CBoclPgja+giU8GOE?=
 =?Windows-1252?Q?M2rSqNjERaDb7zZmRJ1631VQnYx9GOSu62X7bcuN9qgSXEocHODT3/mx?=
 =?Windows-1252?Q?0dUTgOEcLVC7dMRxjEgrvfCqP/nDp5scgNrYeSBy1ZTQUKR9IzLNGFVb?=
 =?Windows-1252?Q?aAJormZcwtS7PivkgnyURRdMz7J2AvnvL13VBz3CXh87eq0Sbh5IEC6n?=
 =?Windows-1252?Q?Lgpb82Vrx53w+qHqbg6AIKuKAhsHEqwS3lnCcoFh+gaU6VTjAtJJOJC5?=
 =?Windows-1252?Q?K0HANL0ycFx8NHmlToptEfsmT5CZGwIXcAB9i/rodg/+y5nL0zFEy8qL?=
 =?Windows-1252?Q?r8hzMsXYTZdiHCYUkODc90QVL3dkYhHzQJ4XPao5jMy61JQGL5y7u+Kh?=
 =?Windows-1252?Q?YTNSsCMUpEBRM3/AeV5nike9L3uWcuIXjVvSih8q8xZnL+OKA0XGq3io?=
 =?Windows-1252?Q?QWZiJdkRZzBA9vCECSRRWfdUF9t+vUXhUSdJ4g0cCgz8W7G85OkzJbKn?=
 =?Windows-1252?Q?grpmIK2bZPBSkBQqTUcIO/8HIUkrbIs1cxVrdm0h1GEyh+Zo6Gpc+DHE?=
 =?Windows-1252?Q?KZdGsgMTEVTIz9y9qsvovVPQXIdWsXDhBYx6QmDXdVV3tnEqHdkDov00?=
 =?Windows-1252?Q?K9r6DKz2Fpvq8fwIYe30lcsmLcPkD0e4Q08i2hShvcG2M7hbJon9vfm2?=
 =?Windows-1252?Q?fmxccRfF0maiC5R0M7OhPw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?3Umu8M40Rc5ogvq+b1ZmhkGtRTQNBMGuLf3JOfobke2L0Vmnt35ql5iY?=
 =?Windows-1252?Q?pRE3MxkqG/rJ8JwHZrfyG9qhAktVV4f7lUyeveNB1Wki/Y2J38tjspej?=
 =?Windows-1252?Q?s3StbUj46DGJQ8mmkom9xPqb4Ipowbo1SpKHu8eQ8kX7ZK05xovKztNV?=
 =?Windows-1252?Q?gVaFxwkuD6dwSHsbs0A5Ztu0aMcjt4JJzxVYfsaDiZq6SIOSqe/nLIXk?=
 =?Windows-1252?Q?kgsO++I5p+XqzIlWjXMv8/v4zJhsY1xzu5f1dgHSptx1utS9NMEX4NRj?=
 =?Windows-1252?Q?5ho0kjt1EStqQ7Y977ga5xx511lo3unQIJFQoBXikmvkxE3u87WPg4X6?=
 =?Windows-1252?Q?NGCHAXYruG/bwpsQGKhdZ1tah+Wj/HpFHhZLW+KVvL3LQTsbRtxxLwcs?=
 =?Windows-1252?Q?7sfeS5SE0D3sTZmzQe4h+rZGJw/a9cV1qObmQgZuWuOgOhhjEHVV27GE?=
 =?Windows-1252?Q?RRV3xZodZxmi68e1vZ4cemTfumk3eshK8a8gNSb4dI07skqNCfCwTSSR?=
 =?Windows-1252?Q?1rPeVcZwR0R/rE7KIQ9ovfWrKyOs/jeohnAFs9/fkJWbsJ6gZYjfVkyr?=
 =?Windows-1252?Q?EzFMeTk/1UCqCulvTWHrz645qPt2fwk8rFfp69l8dM1oJ1NpOuTv4Sma?=
 =?Windows-1252?Q?DHxSN7mC6tGmeA6ZNtScLT6+jLtXufCd10l7QEBQCsUG3WpZpQO3rcB6?=
 =?Windows-1252?Q?ud37J/S55veeJHkrgeVeCen07BE0IwxWqM0pQSxs1diVSsJrhZ75sEAh?=
 =?Windows-1252?Q?wMT3eac7mcsRj5olBW05r9hvHmE1sqHNUlkN0LD7cJe/gN2qXszmbxrp?=
 =?Windows-1252?Q?IERZgNkNdrO4FMmymKmibM/j9Rd7K8+Q5Zy/e2iAfn/siQAswjxjve7Q?=
 =?Windows-1252?Q?pZePRL6J85WeI/pDgAuwB7WrRUw9QF0brshWlPxxbJINdvy9QwhRmuEC?=
 =?Windows-1252?Q?9dLgQ+X2ykJzg5tAELvHWg5X1bB3q6t1NQ7AHFzl7QBskIEABOA0Gmzo?=
 =?Windows-1252?Q?8xThrC+ovXsDk30Y4YlNzHHGcEZL8VdejGp83ptllBRmmxn68MlmlOZU?=
 =?Windows-1252?Q?xncSCDSoX7Fk69xyAAbvOoj3nvD+sY341wscpv9TnIFZbhYXuoUTd2H8?=
 =?Windows-1252?Q?EBni+G2yWcryuipYdbBVg4k2hxNmjjS34PSbVlmMYtw6qOXbtHImiE6V?=
 =?Windows-1252?Q?7dhorP6E++CQV/OvW5Rv4QBs/rJmQ5LdsHr9ZIKP5/Y1RrAXRL15/Z1A?=
 =?Windows-1252?Q?C/+UphKd9XBy4UhsWbgwGBSdLiax2PxB2EyYqqHxgBNy9MILY3OOEjh0?=
 =?Windows-1252?Q?TYywEv8ezYjSpac70f4/NiJHr/11UQJmqLWTOW2pF6tUksBdcsLFc4xG?=
 =?Windows-1252?Q?2fFDrwOQillfFNDcqHGpCHudVZiyIpcRYOYxld4C+YcP7/MLRBwh70YS?=
 =?Windows-1252?Q?r9cqvtlv1TsYquQA1CSvcxQk60YUfLo9IgzzEM6xyLxGo+vYUGQJ79vz?=
 =?Windows-1252?Q?RhgPCvIm8tDatgrCjOWvSM4hoyDd2nTTxSk5a9JPkXCzOYmUn9wo8s2+?=
 =?Windows-1252?Q?dxWUPJbNx+ipB7xDAtSCgZmGelZAuFKNW99F6G6dbJjEmZL2Ii45glAj?=
 =?Windows-1252?Q?D+XeWvspPa3/xZuJaOsXzoT1EUWvMgMS46zCVe7hYkB7Ezw8ypluaph2?=
 =?Windows-1252?Q?iLDcGjom1RA5mUNTIP1LWJVL/NL0Qe4Y?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b36cc0-f439-4951-bffb-08dc7b8d1615
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 01:01:47.0480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cfhPEv1Wu8/0wWi1TtDUlLeZyRsl609vEmrCEwzFpATL2zx6mASZJva1j+/UBu7ZiZjWd2PvKUXc9Dlg1IdNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6175
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Qingfang Deng <dqfext@gmail.com>
> Sent: Thursday, May 23, 2024 5:43 PM
> To: Paul Walmsley <paul.walmsley@sifive.com>; Palmer Dabbelt
> <palmer@dabbelt.com>; Albert Ou <aou@eecs.berkeley.edu>; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Wang, Xiao W <xiao.w.wang@intel.com>; Qingfang Deng
> <qingfang.deng@siflower.com.cn>
> Subject: [PATCH] riscv: hweight: relax assembly constraints
>=20
> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
>=20
> rd and rs don't have to be the same.
>=20
> Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
> ---
>  arch/riscv/include/asm/arch_hweight.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/arch_hweight.h
> b/arch/riscv/include/asm/arch_hweight.h
> index 85b2c443823e..613769b9cdc9 100644
> --- a/arch/riscv/include/asm/arch_hweight.h
> +++ b/arch/riscv/include/asm/arch_hweight.h
> @@ -26,9 +26,9 @@ static __always_inline unsigned int
> __arch_hweight32(unsigned int w)
>=20
>  	asm (".option push\n"
>  	     ".option arch,+zbb\n"
> -	     CPOPW "%0, %0\n"
> +	     CPOPW "%0, %1\n"
>  	     ".option pop\n"
> -	     : "+r" (w) : :);
> +	     : "=3Dr" (w) : "r" (w) :);

The above code piece takes variable "w" as both input and output, so intuit=
ively, the previous
patch made rs and rd the same.
Though rs and rd can be different, do you see performance difference with t=
his change?
Or any analysis from assembly dump?

BRs,
Xiao

>=20
>  	return w;
>=20
> @@ -57,9 +57,9 @@ static __always_inline unsigned long
> __arch_hweight64(__u64 w)
>=20
>  	asm (".option push\n"
>  	     ".option arch,+zbb\n"
> -	     "cpop %0, %0\n"
> +	     "cpop %0, %1\n"
>  	     ".option pop\n"
> -	     : "+r" (w) : :);
> +	     : "=3Dr" (w) : "r" (w) :);
>=20
>  	return w;
>=20
> --
> 2.34.1


