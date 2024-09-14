Return-Path: <linux-kernel+bounces-329283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8712E978F87
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AA8B24C72
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D10147C71;
	Sat, 14 Sep 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TwjO1hh+"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021114.outbound.protection.outlook.com [52.101.65.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AD1527B1;
	Sat, 14 Sep 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306448; cv=fail; b=UCdav2MzFLwvighCf58VJhsg7aJSOs8OjOQr1pG0YiNvonfPVHHF2dbW+A/kx8b0ls7wk3bdl577HbYoeUq/s5fJudxkMyqvPdMUKL+MD6601fYsunzYSdxXnttEl4sMgM93NacOQRREI/nmd2xoTeA4fC6MAm0Y8wiJU8NqGdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306448; c=relaxed/simple;
	bh=jcFhf6n3OMjOnnZI6i+vOr1ED+JWtmY1swA5a9hTMFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sWXShsjn1p/xlRrq4EdkiX3TUZKzXD5DCROcIc4d6A1Z5pGlNvsgS4jVubQCqh2Q9T+QTUelLX3QgDTKy4Yebv2rbXl2m4UJP2lg+bTzTAhWxkrrzd0CDe0Xi5nH1UHq4iCqVaHSqiKk62QQEusmLzh0yquxjCUjZDzKvq5Uukg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TwjO1hh+; arc=fail smtp.client-ip=52.101.65.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8HfNRcBNvd44r5+DxPFbTNXiPY7mI4IMy06KUTF1sbAr1j4a7+lf2hMRKRnuC+j1S2fw8Y/jX5d1rRTZg79dEtbMTmxUw0vLoaOjheuic5EZQR3mRTq9RhFclcoO+z0yO6x7fQmUXsThjiTV754QAOSA5og8hrLbG7iOkXSTqCAGK0oHmlqmdwfm4XQNyLcQULUOPEDX20g6f9jGt0R+/7hLn8nd2Y9l0G5aQLCb7/eUBn5ojU3Nq9NrOmamuDbuaI4dlRwmMFOSpoWbd8PzkQOalPETRR0yXJKk2dq3cX+3GWziByuhcJi8KmOICre1ass7wnyYVTtZHv3ZH3GIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcFhf6n3OMjOnnZI6i+vOr1ED+JWtmY1swA5a9hTMFg=;
 b=kyyz0BiYTFHRdqBq4tn5Ga6R4VsYIYKq22cj66JR6evOMfMkKzV+cZyK1KlMvYYEooEOw3TyAHiOJwoUefjp9auNIdhASXeo3PTmrAhrWPwfpdS+n9CCVh7tlVpR5H3V84pb0R3vpsP2qNMEvejvIv+ld/rbVTPQeaUbYQRJjMAkQNAUySas+F68qCQYypp446JVDuX+sU8vi34uMMBXMgFJjjGcrLaRoFHlrPzJupkOu2VT38l6Ybkzk1k8hQe6SjbRIQqVLTH9d0NCvqVAHwXjxlLX6FMwGqvSTs6c5hznlO5WyBDxdkODGNf7XnyFuXCKEd9yaJCSTYoiTgnbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcFhf6n3OMjOnnZI6i+vOr1ED+JWtmY1swA5a9hTMFg=;
 b=TwjO1hh+LMadklxozuB3OHc6Q9ysZby0HjHFlgn51oLrDRu8nfQVTeLnJ1VhAYtQWbjndq7yAjV37ssxkR2B+LKKW/QIDbpCHKOmBLujwLT5Mr58hRtbiWvrhxXubyjyRQ4J8FGiUoWIxucmV1WlzcxTwD2/FrS7Mn08Z35joeg=
Received: from AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11)
 by DU2PR04MB8502.eurprd04.prod.outlook.com (2603:10a6:10:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Sat, 14 Sep
 2024 09:34:02 +0000
Received: from AS8PR04MB7592.eurprd04.prod.outlook.com
 ([fe80::2ee6:244b:bfe:35c3]) by AS8PR04MB7592.eurprd04.prod.outlook.com
 ([fe80::2ee6:244b:bfe:35c3%4]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 09:34:02 +0000
From: Josua Mayer <josua@solid-run.com>
To: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-sr-som: mux ethernet phy
 reset signals input
Thread-Topic: [PATCH v2] arm64: dts: ti: k3-am642-sr-som: mux ethernet phy
 reset signals input
Thread-Index: AQHa/d6gCJuT66rbcU+oM9bE0EU3FbJGAdwAgBEU3YA=
Date: Sat, 14 Sep 2024 09:34:02 +0000
Message-ID: <120f7936-97bd-46cd-bb8c-90fca27d2140@solid-run.com>
References: <20240903-am64-phy-lockup-v2-1-8cf6bd138ebd@solid-run.com>
 <20240903124256.kmlkjcihl6zyzgiu@commuting>
In-Reply-To: <20240903124256.kmlkjcihl6zyzgiu@commuting>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB7592:EE_|DU2PR04MB8502:EE_
x-ms-office365-filtering-correlation-id: fc3e1c26-afd4-48e1-53cb-08dcd4a05e71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnZaSWFaVmFiaEVVNFF3N2sxdmxOb2RmYW9zWEFtOTV3TUo3c01NVjJ4Nm1J?=
 =?utf-8?B?RWhEeUxPbXluRFlJRzRiamFYRW50UDFHMS9qc3RtcGFRV0Y1alFOYmswWkpS?=
 =?utf-8?B?SWh4ajE1cTU1VGU5Qnd5Wnd5dEsxN3lmK1dFR0dpYzBnbEdMMS9TV3F0VzMw?=
 =?utf-8?B?SmdGM1lRMTVNczZQM0JoT0JFK2FtZWlFb0Z4L1Jzc21SVkp0Tm01NzhWNWhI?=
 =?utf-8?B?cHRHYytNWHpNU2ZGS05sZmh6cmdIVk01bzVnanM5bXg2VEU0dDBVYm9sK0JC?=
 =?utf-8?B?bzRuQ2psU0NWTlpEWE1CbWk1NHVnUHhRcWR4OExnOU5RZEd1bk1RZkJaK1VP?=
 =?utf-8?B?aU5MTlJVQTlCK081RzFoNDEvY3ZMZGpCQ1FyNzV3WkJ0ZWJLREtpcm40TEZH?=
 =?utf-8?B?VDhGTkZ5dnNRcmlpTEsrUTJmWHB4NS83ODNTWUVKcE9QYklNaGNjT0t1b3lU?=
 =?utf-8?B?SmsxWGRXQ3NpMEdsUkU1OVlrL2JOcWpVRTR6WHhzYi8xdWFJZzRmMHNmeGtI?=
 =?utf-8?B?M3A4UFBnYVhjSjFUelMyU24wcmpoVUFsUTcxZDVGMC9qNkxjVU5Pc3doNVpY?=
 =?utf-8?B?L3pzTy9nL0NlSTIwWklJSDFKaVlDMU1pK0Y1U3NUUndDY3cwUnYzZXdrcnBG?=
 =?utf-8?B?NjRXM0ZtclQ2N0NoOG5WQTh3V0VlNExoRWJGL3dzNm1iL3luL1hER1BLM3Zz?=
 =?utf-8?B?YzNvdFZTUjRIODhzekZtdHNJb1d5cWlxK2FLRnk5eVJyaEZjbDhwN29JTUh2?=
 =?utf-8?B?RndxUE9heUZKQ0FrMk1NcHJnQnNGMEtpbmNlME54ajRQVGhUakgzaHpFYnJV?=
 =?utf-8?B?aityOG9lS1FJcDNPQmlCajEzRDhQSkh4OVIrTFdyVXI1MGtFQTJGYWxidVZu?=
 =?utf-8?B?aUVXS1VnUHB6SkpnS1BPR3pUbGRkY3ZsckgvS25iL2ZjZTF6UExGWWVBbS9J?=
 =?utf-8?B?b29EU3lJVlY2c2txTWk5MCtCdUppTzRzU0p5M0NLb0RJOHFVcHAwY0dLL0R3?=
 =?utf-8?B?cVpsTkVEaGVWYjlranFMd1U0Mm5FQ2ZFNG92RXN0Zmx6ZFA1OXczUnpJQWhF?=
 =?utf-8?B?WFFnRnZrSGNvbTR3WklnR3FIRFFWR2FlcEtLUlhLODE3TkFpcDREMzNZeXJO?=
 =?utf-8?B?S3NBZ09peUU1dGtYQURNanF4dlpqdEJyd2FRSHlRZUdvN01KVFZBMDNjdWVw?=
 =?utf-8?B?dUJJS2NBSUNXZDlqWXRUNytKM2NTWUNYcnNiRTIxbExZeTZQeTNsTmlNNExh?=
 =?utf-8?B?czFYZ1N4ejdiNHhGbVpUK1pYZzRmSFVaME5GOXIrUUNMU3dERDg4VFpyWjRF?=
 =?utf-8?B?R2JoVGlJSGhLMitQZE5QUjQ0R2hDdncwNSt3OThMbWZYSForWHQwSTVJeGF6?=
 =?utf-8?B?SllaanlQUDZFbUFsUkdSVXFOV2F2aHFiaFN0d1Vhb3RUTWZTRnV5Qm5Gc1Fx?=
 =?utf-8?B?UFBRUWtaSC8xTGU5SXN5UzZIeFZzd210cy9ZZTE2WlVPWWl0OC9uOHpKQTNx?=
 =?utf-8?B?cHI0ME5LU2hSUmdrZjdVeUxoUE9SVFh2aEVQWkRpWXJuMWs3TTE0S2k2b1M0?=
 =?utf-8?B?UmFwOUZzV0J4Vk50Z0JHdmN6bzhEM2JiSnZyK013WWtBS01qbnoydkZCTkFh?=
 =?utf-8?B?bTNWRElKUS8ydi9sRGtLR3VEdVcxanZ2ZjFiZFVPR3ZPQkFKM0JOaWt0aFpP?=
 =?utf-8?B?TllFN2hOR3hKUTE0UEtka0kvL1l1WjVaV1dzTnRkUUpzU0Z2QlVWQU5qWnhE?=
 =?utf-8?B?dWcrQ2EyM0JtSGVTV0FuMGIwVzIzYzF6OHFtcCtJN2VRb0RYZkZlaUVRZFpv?=
 =?utf-8?B?OFc5R3ZEMHBQY1FnTjh4SFNJcGpDek8wWS9ITDlkWk9lVnlUSTFPZVNkbHM4?=
 =?utf-8?B?dUZZK1JMcHRGMmppaVppYVZ1QlY3aGErdVJra3Jldkk1Vnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7592.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWpobzAwRDVIZStYTE5FN3VFenc3VFhXdmhkZXN3dTNmV1pXNm5OZ01YdlRp?=
 =?utf-8?B?V3praHJ0WXhGOTFrVEc4eUo4VUhpYjNwTDBrY0FVQmtMWEQ2d25EcEJmZXV0?=
 =?utf-8?B?aGxTa2g5TmV5RXIrSkhOTFJKOXNzK1NjSmFFTzBqZnJJK05ZWmVqN1pmTnEv?=
 =?utf-8?B?enJyU3ZEemxqU0Z1dkVZR293Y2JYVlpTZnFPalJOOHhNUzJXdWtFaTNCNnhB?=
 =?utf-8?B?MFlsYThKRC9CcGdZRDBudE52UGdPaGZDOHFVcDVFUkRoMjVPbDl3UnJkaUh2?=
 =?utf-8?B?VTlhWW9LL2IxVkZDR2xGOGZuekczUUZZNHZ6ZXBPeEg4czFBb0Q2RFYvbEN6?=
 =?utf-8?B?RENPcmFsUk81VkFVTEw4ZU1VVnVmR3U3OUpic1dMTm5GNXowSE9uTy9GazAr?=
 =?utf-8?B?RzZ5d0h4bEtNZWt6bjE1dnRIdndQZ2ZBY25HUWlFV1Z1aFhuU2FRUUlaSmln?=
 =?utf-8?B?S3VJKzl3N3dpZkY5Z2RjMmEwdkl2SElLWkM0TFYxTE5tVUlmZ0gvUU1DblF0?=
 =?utf-8?B?Tzd3cGV4ZVZSc0hFVGV3anM5ZW5NazBnOU9qTER5cnhsbTVvYlNnem90U25o?=
 =?utf-8?B?QzFYeUpSWDU2dkRQWVVyMXhjYXB5SXZLWkUvbDBBTkcvb09RaUVpUDEwQjhi?=
 =?utf-8?B?ZkJrTHpWV094RTk2L2NnVTV1OGNSalgrTWdzNnlzU0VDSXdjTk0xYmR1bi93?=
 =?utf-8?B?eWRjVjVNeXlWQ3o4K0JmVzlMdERBVUJEdHhvamJpdzhKaFdyaFRXc3ROQ2N3?=
 =?utf-8?B?QllMVWEvSUc1eXJZVjdFcXdSRVQwMlE0bDZJaEQ2NFdZWUJ6ZnZHWFZORHZ3?=
 =?utf-8?B?Q09OVUE4TTkzU2hId1VISCtTbXZremhNSmZHVUpvU04vRnZLNnFXSjF6Wisx?=
 =?utf-8?B?SnF2cGNueStnaUhaSEtlQlhDb0MwdEkzOU11SjNZOUxmSEhJRFRtTVJ4QW04?=
 =?utf-8?B?aEJ5TExDUlRYL3NTd2dkSXFNUDhiaXh4aVJiVkw2WXJpWjVMSFljZzZuMjJ4?=
 =?utf-8?B?NlFpOHhac2UvWHdzK3lNMlBqZ21YMkxYTVh2c2hhOU9idlFBQnQzR0J1MXFh?=
 =?utf-8?B?T3YwQXNuTFdETzZwN0lIeFRaUWtrUy9xZlEyN1dZZnlSRkpGZnNrVHdHMTZ6?=
 =?utf-8?B?YzkrUm50NnRMMGVzMEVacHNLVm42cnJIL0MvbHFXeWZGY0dneXVncVJXQzNX?=
 =?utf-8?B?ZWdnYklIL2ZQWWhUY2JFeUpiYTZTcDljdkcxcE5wdWM5WWJiWXBKMjhBeDZ5?=
 =?utf-8?B?Mmw0VjdyM1JkWUZSRzRyUlNoUkdGUHQ3MEt5bGhacXlMRDZCd0xLZTNMNzJs?=
 =?utf-8?B?NDdkUytZL2VIY2YzcWJPSUVDRnV1dGx3UEllSTJYQ1JmY2Q2bXd5VFNkL2Jm?=
 =?utf-8?B?bFNRdHVZaHphZ20zMFphSkI1bFcrZ1BJUUtQL3lqYTFtMmxkbjNoazh3MGtp?=
 =?utf-8?B?RUhac0tJZDZxcURzWHlyWTZkbGU0K2FJMVVZY0pHbmg3aHoxQ3BlNHJVU3Bh?=
 =?utf-8?B?VllRZTRSUHR6c3VHVG9OUjRzUkR4akJOY2dKTW9VcGNpcTBDVlprZVFCUkVa?=
 =?utf-8?B?WDVDNU1zMlQrTDlDYXRDd05TM0gyRmNpNzZkdzQvOS9ydVRTZjZZc2ZEbENU?=
 =?utf-8?B?S0RXUjlNc1piMkZHSTNrSjVtc0MxRE5iaU85TExtSUUxS0Mxb1U2YkJrMnRr?=
 =?utf-8?B?Zk1QWms3YkZmeE8zb2RFS1dRVDdVbWJYMHBGS1Z2YXRPWExnMWxKVEhHandz?=
 =?utf-8?B?QmxMMDkzOTFmODlyVjdtaUpJRlgwejNCMmN2Z2FBa0Y5dzU0VzdHVUpTNVU0?=
 =?utf-8?B?OFV1TEpGT0pWcENQNHIwaGZsVU4wVHhRZnB4b2hYbHNoRE5qQXU2c292Y3hs?=
 =?utf-8?B?Z3M3OHQveEdEZWZRQzBiUUQ0bE8zSFFXWUtOeUV2R0l6NHhscnV4QWVKOWZW?=
 =?utf-8?B?RUsrZkpMYVQ1NVUrU3UyZXRtMWl5b09tY2ZiUjFWUlZYUU1LazNUaldoL0Nh?=
 =?utf-8?B?OU13NTZRandHNXZlMjNjZXlXcVViWXlpSlY4U3NlYTJGOEVsSDJvcW8zSHVv?=
 =?utf-8?B?b0t2UUp0UzJuRkZ1MXp3aUxTZkp6cTU3TEdhMmxWenYxdlpQUTEwTHlOOHV1?=
 =?utf-8?Q?wsmg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9161FCFCBC91D4E873C0F4A8F16B954@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7592.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3e1c26-afd4-48e1-53cb-08dcd4a05e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 09:34:02.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32/dsldTJ1iq8uBuMJiNRksIQ5Mj5FWd+PRUL2Yd5QQppS2QC2dsLjpkmxb14ojV/td5ekRlgWbhH+sf1v+9Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8502

QW0gMDMuMDkuMjQgdW0gMTQ6NDIgc2NocmllYiBOaXNoYW50aCBNZW5vbjoNCj4gT24gMTE6NTIt
MjAyNDA5MDMsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gU3BlY2lmaWNhbGx5IG9uIEFNNjQgU29N
IGRlc2lnbiwgdGhlIERQODM4NjkgcGh5cyBoYXZlIGEgY2hhbmNlIHRvIGxvY2sNCj4+IHVwIGlm
IHJlc2V0IGdwaW8gY2hhbmdlcyBzdGF0ZS4gVXBkYXRlIHRoZSBwaW5tdXggdG8gaW5wdXQtb25s
eSwNCj4+IHN0cm9uZ2x5IGVuZm9yY2luZyB0aGF0IHRoZXNlIHNpZ25hbHMgYXJlIGxlZnQgZmxv
YXRpbmcgYXQgYWxsIHRpbWVzLg0KPj4NCj4+IFRoaXMgYXZvaWRzIHNwb3JhZGljIHBoeSBpbml0
aWFsaXNhdGlvbiBlcnJvcnMgbW9zdGx5IGVuY291bnRlcmVkIGR1cmluZw0KPj4gcG93ZXItb24g
YW5kIHJlc2V0LiBJbiB0aGlzIHN0YXRlIHRoZSBwaHlzIHJlc3BvbmQgdG8gYWxsIG1kaW8gbWVz
c2FnZXMNCj4+IHdpdGggYSBjb25zdGFudCByZXNwb25zZSwgcmVjb3ZlcmluZyBvbmx5IGFmdGVy
IHBvd2VyLWN5Y2xlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBz
b2xpZC1ydW4uY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGluIHYyOg0KPj4gLSB1cGRhdGUgY29t
bWl0IG1lc3NhZ2Ugd2l0aCBhZGRpdGlvbmFsIGRldGFpbHMNCj4+IC0gcmViYXNlZCBvbiB2Ni4x
MS1yYzENCj4+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDcw
NC1hbTY0LXBoeS1sb2NrdXAtdjEtMS00YTM4ZGVkNDRmOWRAc29saWQtcnVuLmNvbQ0KPj4gLS0t
DQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzaSB8IDYgKysr
LS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1z
b20uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItc3Itc29tLmR0c2kNCj4+
IGluZGV4IGMxOWQwYjhiYmYwZi4uYjFmMDYwNzFkZjRjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzaQ0KPj4gQEAgLTMyMCw3ICszMjAsNyBA
QCBBTTY0WF9JT1BBRCgweDAyNzgsIFBJTl9JTlBVVCwgNykgLyogRVhUSU5Ubi5HUElPMV83MCAq
Lw0KPj4gIAlldGhlcm5ldF9waHkwX2RlZmF1bHRfcGluczogZXRoZXJuZXQtcGh5MC1kZWZhdWx0
LXBpbnMgew0KPj4gIAkJcGluY3RybC1zaW5nbGUscGlucyA9IDwNCj4+ICAJCQkvKiByZXNldCAq
Lw0KPj4gLQkJCUFNNjRYX0lPUEFEKDB4MDE1NCwgUElOX09VVFBVVCwgNykgLyogUFJHMV9QUlUx
X0dQTzE5LkdQSU8wXzg0ICovDQo+PiArCQkJQU02NFhfSU9QQUQoMHgwMTU0LCBQSU5fSU5QVVQs
IDcpIC8qIFBSRzFfUFJVMV9HUE8xOS5HUElPMF84NCAqLw0KPj4gIAkJCS8qIHJlZmVyZW5jZSBj
bG9jayAqLw0KPj4gIAkJCUFNNjRYX0lPUEFEKDB4MDI3NCwgUElOX09VVFBVVCwgNSkgLyogRVhU
X1JFRkNMSzEuQ0xLT1VUMCAqLw0KPj4gIAkJPjsNCj4+IEBAIC0zMjksNyArMzI5LDcgQEAgQU02
NFhfSU9QQUQoMHgwMjc0LCBQSU5fT1VUUFVULCA1KSAvKiBFWFRfUkVGQ0xLMS5DTEtPVVQwICov
DQo+PiAgCWV0aGVybmV0X3BoeTFfZGVmYXVsdF9waW5zOiBldGhlcm5ldC1waHkxLWRlZmF1bHQt
cGlucyB7DQo+PiAgCQlwaW5jdHJsLXNpbmdsZSxwaW5zID0gPA0KPj4gIAkJCS8qIHJlc2V0ICov
DQo+PiAtCQkJQU02NFhfSU9QQUQoMHgwMTUwLCBQSU5fT1VUUFVULCA3KSAvKiBQUkcxX1BSVTFf
R1BPMTguR1BJTzBfMjAgKi8NCj4+ICsJCQlBTTY0WF9JT1BBRCgweDAxNTAsIFBJTl9JTlBVVCwg
NykgLyogUFJHMV9QUlUxX0dQTzE4LkdQSU8wXzIwICovDQo+PiAgCQkJLyogbGVkMCwgZXh0ZXJu
YWwgcHVsbC1kb3duIG9uIFNvTSAqLw0KPj4gIAkJCUFNNjRYX0lPUEFEKDB4MDEyOCwgUElOX0lO
UFVULCA3KSAvKiBQUkcxX1BSVTFfR1BPOC5HUElPMF83MyAqLw0KPj4gIAkJCS8qIGxlZDEvcnhl
ciAqLw0KPj4gQEAgLTM0MCw3ICszNDAsNyBAQCBBTTY0WF9JT1BBRCgweDAxMWMsIFBJTl9JTlBV
VCwgNykgLyogUFJHMV9QUlUxX0dQTzUuR1BJTzBfNzAgKi8NCj4+ICAJZXRoZXJuZXRfcGh5Ml9k
ZWZhdWx0X3BpbnM6IGV0aGVybmV0LXBoeTItZGVmYXVsdC1waW5zIHsNCj4+ICAJCXBpbmN0cmwt
c2luZ2xlLHBpbnMgPSA8DQo+PiAgCQkJLyogcmVzZXQgKi8NCj4+IC0JCQlBTTY0WF9JT1BBRCgw
eDAwZDQsIFBJTl9PVVRQVVQsIDcpIC8qIFBSRzFfUFJVMF9HUE83LkdQSU8wXzUyICovDQo+PiAr
CQkJQU02NFhfSU9QQUQoMHgwMGQ0LCBQSU5fSU5QVVQsIDcpIC8qIFBSRzFfUFJVMF9HUE83LkdQ
SU8wXzUyICovDQo+IFBJTl9JTlBVVCBpcyBiaS1kaXJlY3Rpb25hbCBkZXNwaXRlIHdoYXQgdGhl
IG5hbWUgc3RhdGVzLg0KR29vZCBwb2ludCwgSSB3aWxsIHRyeSB0byBtZWFzdXJlIHRoZSBlbGVj
dHJpY2FsIHNpZ25hbCBkdXJpbmcgYm9vdA0KYW5kIGJldHRlciB1bmRlcnN0YW5kIHdoYXQgZXhh
Y3RseSBoYXBwZW5zLg0KDQpHdWVzcyBpcyB0aGVyZSBhcmUgZ2xpdGNoZXMgd2hlbiBlaXRoZXIg
dS1ib290IG9yIGxpbnV4DQphcmUgY2hhbmdpbmcgdGhlIHBpbm11eCByZWdpc3RlcnMuDQpIZW5j
ZSB3aGF0ZXZlciBnbGl0Y2gtZnJlZSB2YWx1ZSB3ZSBlbmQgdXAgcGlja2luZyBmb3IgdS1ib290
DQpzaG91bGQgYmUgcmVmbGVjdGVkIGluIGxpbnV4IGR0cyBhbHNvLg0KDQo+IEVpdGhlciB3YXks
IGl0DQo+IGlzIGEgYml0IGxhdGUgZm9yIG1lIHRvIHBpY2sgdGhpbmdzIHVwLg0KPg0KPj4gIAkJ
CS8qIGxlZDAsIGV4dGVybmFsIHB1bGwtZG93biBvbiBTb00gKi8NCj4+ICAJCQlBTTY0WF9JT1BB
RCgweDAwZDgsIFBJTl9JTlBVVCwgNykgLyogUFJHMV9QUlUwX0dQTzguR1BJTzBfNTMgKi8NCj4+
ICAJCQkvKiBsZWQxL3J4ZXIgKi8NCj4+DQo+PiAtLS0NCj4+IGJhc2UtY29tbWl0OiA4NDAwMjkx
ZTI4OWVlNmIyYmY5Nzc5ZmYxYzgzYTI5MTUwMWYwMTdiDQo+PiBjaGFuZ2UtaWQ6IDIwMjQwNzA0
LWFtNjQtcGh5LWxvY2t1cC0xMDdlYTVmZmEyMjgNCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+PiAt
LSANCj4+IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4NCg==

