Return-Path: <linux-kernel+bounces-322751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C4972D43
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B8328505A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F534188A1E;
	Tue, 10 Sep 2024 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ci0k1h7q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D08187878;
	Tue, 10 Sep 2024 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959836; cv=fail; b=sigfTQT/yVhuz8v0cpp8v8kdACc7DhVAWDH3fgu8PMUrhJtny0MtxXAr/HtMcikMzU1MQpcNsU6TMmKxorCCNvygJJqAEA1nk7BU4RsZQT4D73UkFYOOiPDqYZpUwats4ORCuLExfWMYdFXACMrbX0QJ995CS/dW9sq7+JD9Lrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959836; c=relaxed/simple;
	bh=aOFgEvb4UJEgWC+Y2wMxmBveVX1/ApigsbHb+It5woY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XtFJrRI2/cgBkxeoe61aiMvK4FTJmiVINwZt8rnhNYapYnyvVv3EGy2t45hgX31h5yw2ZQSQC3bhKG37zXE6cZIo/ELwCb56z2xcGCA3RH5a9sG02c+s5hhcUlw6K4zpFozvFLhFntVq2qqT0azOs+g0IWE420zBrozxVXXNdmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ci0k1h7q; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725959835; x=1757495835;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aOFgEvb4UJEgWC+Y2wMxmBveVX1/ApigsbHb+It5woY=;
  b=ci0k1h7qqMv7poBYufj0k+nYyHKgSqIvtQUJzMGoognehdxSBZnBiqDB
   JBsQfI0ObPQ0sIYptPstey/CrGqfTNFw2y5OCTA2bv/YqbpuPZNXlNMGl
   jfBRNpVFlbxw8sfDEc0JzVx2qCIDyUWVtIDn/Kb+9v7r4OKH/66+fXT8D
   3b06V+wLWDse3ndIoyQLa4GR0B9V2/pmX7XbadzFsN6iA2O2vhUAHElcA
   azL5aMUix0PLKUa5A7Swv306Dkrr/A79Y3b9dC1NtTqcxM7Ci+BpXK7vj
   es47mJHWqF/q7oy4THItxf55AdLPnXOl02O02vfDJMb7CSjCH88Ufrju8
   Q==;
X-CSE-ConnectionGUID: qfzZb51eQuuHutT44me3HA==
X-CSE-MsgGUID: rQ87kNS+TxGEjfH2yDKxKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24852951"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24852951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 02:17:14 -0700
X-CSE-ConnectionGUID: +reia2bOR+SXQ40UNKHUIQ==
X-CSE-MsgGUID: ksQ0g8crSsWu6QR0GA+YxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71089476"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 02:17:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 02:17:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 02:17:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 02:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT5UmdXEybS7QXwY5UM1FL+O7Q0xT+G+ntBD/sziQZd/uNCF2IbLrisNsPxJuElernp9p6Tmln4RYcVNsjixU53wuzR+VjVYq64nwyMTPqhJajJ//O8t+ItD26tqMNlFJ9PFcj6gQbMSFElsZXjZtevqIHr+r8t7Xwtbqk5hGXLXMd5QQmhZeT/lNntV17V+fPcX5CYT6ptlwc4ozM6Wd0JUyS1qA+HIHgQF01coK/qKuQtVD/sAby+hwEUoYoIMs06RRWveRlDojaQnzZMVJm+/mjLqqcptlu+viCQkvA9eTW534aFDcg2N20r2Gqk/mw6v7r0HlcKiWwhg3NHb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgVxlHfnetwT6Erc6H6GH+vqEpCY/87sHtGhTg8WVro=;
 b=X++FmPhR22IYGgu9YhCIwytgqgzf9PKngfqtSrFDqTca7W5gafA0K2xny7yNDzK2j+ULaKhUhWfc5tvAoSvRMZU1bOVaMLnk1RSdUTotK4Llioi3kCc3XSV0T0xNVMMwX43mWqXr6zE5D3QjYKEp2NSXOVvKO7Vqg3HJNDS6ZlwrccIeZMCSDjd9qxeFa7k/udBZayFu03qQ103n3sciDHXeg/17jKwzHHZyjp2Qf/L9Z+YWHiFn+ma7n8VogIm/c2k80fyGnNvhixm3FvhbN+ckXELr9RuveRI69L/DcF9seyK5R3BXqII7RA+usyuEIeG7BhddnA8xUE2Lg3guzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 09:17:10 +0000
Received: from SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c]) by SJ2PR11MB8424.namprd11.prod.outlook.com
 ([fe80::4053:18a0:f95:3b9c%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 09:17:10 +0000
From: "Liao, Bard" <bard.liao@intel.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>
CC: "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "vinod.koul@linaro.org"
	<vinod.koul@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH 13/14] soundwire: mipi-disco: add new properties from 2.0
 spec
Thread-Topic: [PATCH 13/14] soundwire: mipi-disco: add new properties from 2.0
 spec
Thread-Index: AQHa+IJFWS7N3QJ9xEKrbPD17pxnn7JPopyAgAEwKVA=
Date: Tue, 10 Sep 2024 09:17:10 +0000
Message-ID: <SJ2PR11MB8424DB4CC5F16B3D8FFAC8C9FF9A2@SJ2PR11MB8424.namprd11.prod.outlook.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
 <20240827130707.298477-14-yung-chuan.liao@linux.intel.com>
 <Zt8O54x+NVu+UwwD@opensource.cirrus.com>
In-Reply-To: <Zt8O54x+NVu+UwwD@opensource.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8424:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: 48176a39-946c-462b-b37a-08dcd1795963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Wf/YAMpeXk8CnZKWvIKnsNy2jWKBNSiZlw+oFrGDQ59IyeG4ZjCmo6/ibgGL?=
 =?us-ascii?Q?KCEPubJE2k3pwkjs7TtuF/c97Ih3Oj+x/YpZFacyvZ0VhJQ4TbIybZOJNWb/?=
 =?us-ascii?Q?qiGyM+tK1da2reHVYRJsRzHSfW80JT3ok0eG6oX2aoBRRZ+lL3Tgyd9/dslL?=
 =?us-ascii?Q?fAjJkv4wRrjccqBftL4nNzHIaVETaV1yT0IseXeLkMdjwdzHxvbSAZOpiuW2?=
 =?us-ascii?Q?7Rv+ZzdeU9KBFzWMp6fu65ohXZ5DCZbfhsj589VJNC787yS7itcmz/Tl+znJ?=
 =?us-ascii?Q?P4euuYfYIq5KU2ND16IfdRCd/NOZuLxhww/qmDLYYZo7MyiVqrgH3ar9F9Bj?=
 =?us-ascii?Q?5rJejIM6/XZKljrZhuxUyfcReOW0g6kp77oOVeteqFNEsKGmKqI+Goz9oymf?=
 =?us-ascii?Q?cwXLfwLHLdPtsYVuc4lSBwc89ajPQ1+JgITA8kso4HzFbCeTcA28Y6ir8Z9/?=
 =?us-ascii?Q?joyv3Ts+m7hYpElHld1Wv67VhTS+7i/7xK4s4G2Nz05ohovkXt4i8fbCfMn3?=
 =?us-ascii?Q?JI1zxUlh+36gBpVLkJDHEJ5SsxWghd5Qk5FWhI1JMQpp7dsZYXVRNKoviUBV?=
 =?us-ascii?Q?hY3lG5kDG7f/yvY9zTxWSFd0Uy5d5v4ZrogFUBeB/t6ZTlcA1dO5I0e0bkC/?=
 =?us-ascii?Q?eKQ9PMhoCr/wLhw1Iae5tjqsmemGyoNkBmIUUmCP5gIE3PL5NC+RLSbV6jzY?=
 =?us-ascii?Q?O/3a+9jC897Hjv01I4uoWfPyqd7M0GExaTFQAGic0dwrjMZYtH3JmQ0tPUz8?=
 =?us-ascii?Q?7A+cgRNaDdBHj1R3WIO17AgbXa2K746xFitF2ENUpFHvG0dn4xbfX9cwGFtp?=
 =?us-ascii?Q?G2oDtXioxnLCx4X4gDfHmSmT9ZN8hXRIAbXkbA7Mt/0FHz1W34xjYQcEiy1s?=
 =?us-ascii?Q?sWopON4aQGBATwDEoX57AtuaeD8XCk4A/kbs4kmK8iGdCH1763bcAqW9Nq57?=
 =?us-ascii?Q?CgpugvYwHk1y+LoFpPMvTu44UoFQztdHXfVP6zwSalviypBTpmlQLuAVkWKJ?=
 =?us-ascii?Q?mo6Mf5NITGwxzbly2mFNSA/NtsO8L7SKX/FpUO3c83zW/WLkWR9mVRzHWf9J?=
 =?us-ascii?Q?UE2Vc/dF+p7taYWOOahdahexw4fbgOpsneuYozLOa/tUYMtHUTC89SCX10kX?=
 =?us-ascii?Q?mnTshUzfznup/oBKYz3e+HdXsHwYcgVcEQVvQKO9dPKnmFWVJocmimDxFUJG?=
 =?us-ascii?Q?gAGovsXlpHCfzyw1Iv+I2SC1jRkuxZrf83NEUh6hJl4JC0R9eSiUGsDs0tT+?=
 =?us-ascii?Q?cg+2oVAktg/lMUvnc6PULfw+buglJ8FBXgzetrZiGYph3w3uTLjsVI/X9Vb5?=
 =?us-ascii?Q?td9WIPEIV26lrWEbusyzHzfSzInbnd28BftKkkTCS+BabLC0tKbcfON2nqnc?=
 =?us-ascii?Q?72/3ONuMAt7EkuFxE2dlDeLFpDXmM0uWzOK41kIZOae+TyU5rA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RPEatTJgoZ8wj756Nj+Fe5xlPKQJx68kcXJ4JyqA9wgzEp/cO/Fn9RG4601I?=
 =?us-ascii?Q?BSTmo4Q41heAq6hURkHXCMPA7NEC7Udf17QAFF/H74/Dun1+1oyjFDReKVxa?=
 =?us-ascii?Q?ZytW9AKoBLK2eG/GRW0z3pycFWYiAHsy8CG5b4G6+xn3e9gv0P4rKUqS9AGN?=
 =?us-ascii?Q?66Wl2K9DWwm/ZaLPIUWymU2dJlqAiueX9qwNA5gvk2ZJqXPPWmkm0ZrpuNLu?=
 =?us-ascii?Q?fG9uOAunBkbyF/VI7DXrTDkosHuyyAAwaXcX96V0NkoOU6KYp4485MpI0p1r?=
 =?us-ascii?Q?Fse9I8O/3UKaXhsRpkxmh/7zKgblGuPZFYhjUL/f0FxyjEixcpHRmT7jS6Ke?=
 =?us-ascii?Q?0uVKZXIf1OOdwok4QcKDQXB06LurcaE1R2WV780nPvA3wH+lAc9iiKgbYuZJ?=
 =?us-ascii?Q?eb3GxOBjzJdN3v5yhz7LWMYSrHcYGwr0O/bIZxGz5c9u2I92kQKEVgdozlte?=
 =?us-ascii?Q?7MoRxVK3Ytg8vkmMLpR5/PnF+L9PDuJ0ehsOHgs8BelEjEq8Jve9NqoWo0DP?=
 =?us-ascii?Q?CRAQAb+CCX6hJqTMBag1Uu0Qm7L5vUr2S7Af2AW1a6SLLeuf/0mzEUA9F3hK?=
 =?us-ascii?Q?WXq1f1OOC9PJHNnf1VbnO69jnVSbmR4O4EMfQ1h0eacYKJN1IFp3Mi9OUSZW?=
 =?us-ascii?Q?qgKPMS7foUeo/yR2WwbrRVMY7U0ctgc6/ZbkfAkZJiNKEFFQWlgZcnw620WW?=
 =?us-ascii?Q?xEr76gZp2DBsdxEOzog3EwO4JWBAAO4oKkxSLzahSVHifYaIGkP99AngOXHd?=
 =?us-ascii?Q?uEYuRLQXKK9dWXplmOtx7OZJ54W6Vl0qHQwRwdOhRLICvUzCzscYOGxSH1/7?=
 =?us-ascii?Q?WgI+gzTBzDFaNGqNMRwmvBIlDSow1Iy8gEYE4xCtxYmH1DpbcuXuMqbfmDob?=
 =?us-ascii?Q?8ycuFWf0H0S7pJDy47mA9h8jM5SG62jjP47rbxmc/FuUHaG7BCg06N5Por9n?=
 =?us-ascii?Q?PgdxplQegf1IDNHPxICRORA3ZIEQfIkP0TWkvQVXWZ98FMrcswJR0W4hUNe9?=
 =?us-ascii?Q?t6FhIwxIFIvI2YYJ3DIhDU9b+APk7y9M3+jgs6A42OarT8n08xyBF2MWDC5G?=
 =?us-ascii?Q?hRTTKtxmIQOGEbqWWFfTCw42TKcRM4dTBiOz53+uwvEgqhEAcn+rge2HASbI?=
 =?us-ascii?Q?9Ekxn1jFA0sOqnVvG7VIt0lf3L7wh4GkXvVN9ou8iU0zGopD/hfQvYHC49Pw?=
 =?us-ascii?Q?IQokuYj87IZ6sFGxn0JjY+2IslfDNRcMLafD/LRIZgfqjGF1yTxT88d+Hqmn?=
 =?us-ascii?Q?+cfflDoevWBfpdfvDNHkBXT0QIF/KQY6K2pLRMq0pU5IeN7cAsMTxdsMdb9f?=
 =?us-ascii?Q?aeJpMrbxHQqI70y0UCenzOLJCTZ2q9xOteVVz1oue47CSlGFdp52EzRG/tZr?=
 =?us-ascii?Q?vDZ9poQiS/WRqb0QkdARi6suz+OXJK4eozfZRWZAotdyAoVHoCU2JdK33doq?=
 =?us-ascii?Q?uwDGiebBxZCNXpLHwkVjVC4q/aLFBSMES3+TXggb3R7ujRP1Sfz7vDCq6/39?=
 =?us-ascii?Q?BV+cG/rFP4rGkbTE1apQtns320Kw5mQQE1WNptdq8v986iqpa7tiug8mrGN2?=
 =?us-ascii?Q?VE0xt5Vkimw91q8ZSQM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48176a39-946c-462b-b37a-08dcd1795963
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 09:17:10.0480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MarwFMDlQbs9iP12RlVYWAyjJYsUSQ2mB9J7x0Fga07VoHTk2KddPVypGrXHUVaIyrQHPCBIcowVqBXAe3uO2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Charles Keepax <ckeepax@opensource.cirrus.com>
> Sent: Monday, September 9, 2024 11:06 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: linux-sound@vger.kernel.org; vkoul@kernel.org; vinod.koul@linaro.org;
> linux-kernel@vger.kernel.org; pierre-louis.bossart@linux.intel.com; Liao,=
 Bard
> <bard.liao@intel.com>
> Subject: Re: [PATCH 13/14] soundwire: mipi-disco: add new properties from
> 2.0 spec
>=20
> On Tue, Aug 27, 2024 at 09:07:06PM +0800, Bard Liao wrote:
> > diff --git a/drivers/soundwire/mipi_disco.c
> b/drivers/soundwire/mipi_disco.c
> > index d6eb63bf1252..2215c53f95de 100644
> > --- a/drivers/soundwire/mipi_disco.c
> > +++ b/drivers/soundwire/mipi_disco.c
> > @@ -398,6 +398,19 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
> >  	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
> >  				 &prop->sink_ports);
> >
> > +	device_property_read_u32(dev, "mipi-sdw-sdca-interrupt-register-
> list",
> > +				 &prop->sdca_interrupt_register_list);
> > +
> > +	/*
> > +	 * The specification defines the property value as boolean, but
> > +	 * the value can be defined as zero. This is not aligned the
> > +	 * implementation of device_property_read_bool() which only checks
> > +	 * the presence of the property.
> > +	 * Let's use read_u8 to work-around this conceptual disconnect.
> > +	 */
> > +	device_property_read_u8(dev, "mipi-sdw-commit-register-
> supported",
> > +				&prop->commit_register_supported);
>=20
> Would this not be a case for the new helper added earlier in the
> series? Or is this some third type of boolean?

Thanks Charles. Yes, we should use mipi_device_property_read_bool().
Will send a v2 to fix.

>=20
> Thanks,
> Charles

