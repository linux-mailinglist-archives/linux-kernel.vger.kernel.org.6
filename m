Return-Path: <linux-kernel+bounces-403478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47D9C363E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411181F21263
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740334CDD;
	Mon, 11 Nov 2024 01:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aucFj19w"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44645C125;
	Mon, 11 Nov 2024 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289755; cv=fail; b=rfXaE5BeerfKuTXU94flTqzozUSHwGoqurip0ubAGCyyTZrIfDikrHX0VS98PZtPaHByeTHyzkDwzdw5M32v50KybUxtuNDkCQKCRCr8mxDKNoCY1brnb4hEubDQ8WgcI44xzlvnAx94jg68s2nH5anZ7WRddttBtSrPOuO+uFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289755; c=relaxed/simple;
	bh=zRSaacye/63A7Ow3jVPjgDYFExeDav9urtRmUBfxhgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1ivPpm8Vv0VTKgJcMoqxaYt8JOafy35nA1JMWV0YTitTgpHMlTiS0oE7ZWw+xUcG6evxzeoZ0XX6RrP5f3QvzwwMXXUK73qs67pFhUfSzWnYHbfdg7XVgnDpEyQ6lrtXxtDiuy9tKln1qTnTVdmHC6ZdN/B9JoP5zs746cs2P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aucFj19w; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIlwtieZTB2x6Q5NSssMgroC2t5PFTChlT1JUQ6GDTNz6s0kjet0APA3mHHPIZC/Oiz+cdkvYHFqewzf6KnsOpwpD0yQCw1c0ycW6tKuuFWihxLQ/Q8HBg35nTMmyB9RSejrM0NJm11+e0m7IXs+7hG2cDxOq/Ga9IOZSrihHZQzi4Q8oQANEn0cpc/+FzGwrxFKUYmk+CXHZH5B9vL3FW1XMp7Is8UEwk4H7UR3CEVvtX7mb6DFWBdVvnhwKocO3laeI0O0I4+rtUZihJ2njqFML5XB+2HE1woj1FyDbca20m0oNzZVtxjM84xFwngx/PCv5SXJo36xPZvfDSsR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRSaacye/63A7Ow3jVPjgDYFExeDav9urtRmUBfxhgw=;
 b=vQHuNK5LKTdOeqdvaam3TT9urKKmHoHgBNtX+OQs1MQTXj25lKEswRWXwEo1wRbCqrU1lG/AAF2r/RahWkq/UnYPLMS++h+A8qxPfFx3iSM9bu6fW0H8ciGwpmPHRfqXdbWLFZW3WyZBPFpnd7NAKHs/vsMpdjAXqdcYpkpHDG00VG2ivW3/0kJ2a0AZmM2sXbFmPUKltQ63vtHnLMa4P2f/h9NACVyW7aQIQsbs9UO/mUmQYJcku5Tzkke5QZLc1gqoZSyd09jCkEkUqaVghdzzActOtt6jLASDhI0gi5eSaNnMIEkCTu0isR2toqMzeD8mGLBAZ6gARwyTVoeitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRSaacye/63A7Ow3jVPjgDYFExeDav9urtRmUBfxhgw=;
 b=aucFj19wK5Km/mdB+sc5ZM0/H6HWe7CaxUpEnZjIZ6+tnZa8z9xzkg1ek5lYxGYJpufcEu78/d8XvBzqNqQphmNDtaZ9zEFIIJefWz6LLR3LOvWgU/6D+grYcmwr1BoHHPn7sbVKOogALfjFLgu4ii2w6kjKwIbWBMu16Zx8Qg6oOkNFvcCED5BJGyAAQ405BMBz2Y6KjHGTbRJGqSaJDIzKEuzgv6GjxtcEkW44Tpob8/z1mvF+FpJZ8wMGFAP1J7Yb/QvyEDYCS4dUTJKYrxRiq4tA+J+mpjts6R/eEsjbvX+gMbZnLLwWzZo4eY09gLjQPMd8k5OwavM7OhTcrw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10410.eurprd04.prod.outlook.com (2603:10a6:102:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 01:49:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 01:49:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Fabio
 Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
Thread-Topic: [PATCH v3 1/8] dt-bindings: clock: imx8m-clock: support spread
 spectrum clocking
Thread-Index:
 AQHbMCsiGosLFeSwx0KHxJlfsPaJB7KqSvgAgAAA1oCAAZ6NgIABZEoAgAAIjrCAABiHAIAAqOUAgACk74CAAAQDgIACkRcQ
Date: Mon, 11 Nov 2024 01:49:09 +0000
Message-ID:
 <PAXPR04MB845978F4D3C6E887E0DE8D5488582@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
 <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u>
 <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org>
 <CABGWkvrYJL9=zrPSFuEAgKO+9gDHD6RmCJM6Br6Le_eh578ETQ@mail.gmail.com>
 <54dd6ae6-b992-451e-b1c6-8a1968955f4a@kernel.org>
 <PAXPR04MB8459BE3474EFD4FCC28E0E82885D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <8c310eca-d695-418c-82cb-a89351d83887@kernel.org>
 <PAXPR04MB8459B6F8D5C623D19CCF6B39885E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc02327b-dea8-48c9-b036-4a0eda0c4cb9@kernel.org>
 <9f6b243b-0642-41db-85ed-d020bfa3e6e2@kernel.org>
In-Reply-To: <9f6b243b-0642-41db-85ed-d020bfa3e6e2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10410:EE_
x-ms-office365-filtering-correlation-id: ed0d21b6-7f14-45aa-eb64-08dd01f308ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1Fla3lqeldObnhNMFV3RE5Ib1dacmV4WGpTcmdJYkZHYjVpVHVvbWd6Q0Q5?=
 =?utf-8?B?cmR3bDFrUUsxNEdoN3pjZ2ltdEpQWmoybEcxdVVLaHVoUzV3M3plelVHR29Y?=
 =?utf-8?B?bXRWZHdOWUNoa01kaWNmY01VbmdCemF5a1F1dTlLaGVnSTZ1WWFKSjdFbU44?=
 =?utf-8?B?WGdlNWZKMllqakZZS2htODdFK0pZK2hSM01IakU1d3ppbkk4Um05bmxNZDl4?=
 =?utf-8?B?WFFvQ3ZWUjNFZzFZSWp4dlpEWG0yek80dHVMREFZUFRoeEoraENCZDNndVUz?=
 =?utf-8?B?ZTVsa2l1MndyZ085Ri96N1d1aHROZmcrOU1zbWdEWmp1a0RLY3hwS3hGaVFh?=
 =?utf-8?B?SFBvMzBXMklSbzlja1IxZXZMa2M0UnExYTJYK09qMmNBOE0zOWlLTTJ2SklW?=
 =?utf-8?B?bWI3QnF1ZEFpcytreHNHdDlFZldHVWdvaU53eTRkdmI3QitDbGdEU2pjUTVR?=
 =?utf-8?B?am80eUNzMDdVakN4Z1hrN3M2Zlhmd0V2U0pFOElFZkY0NnlEUVJDTktEVGdP?=
 =?utf-8?B?V1pqL242NGdFMEd4NXMwa3VERUlubko0dTAwallFZHdoRjZsUjN4R2Rhcmk3?=
 =?utf-8?B?SXdtb2JnQVhSWjQ2SStocjFsTFdpRXBTRktwdmRxMDhzZUREM2tGM3Q2bGdC?=
 =?utf-8?B?dW1URXM4M3RjSHVJbXFFRHlNQjRRcS9LNytMc0Y5TVpvMzkyQWV1S284aDQy?=
 =?utf-8?B?U3BtdkIvM1hYWmY2MG1IRXliZVNMZXZFY3BpcTg3YmpDRHlYNzI4VktxcE5q?=
 =?utf-8?B?bnJkb3hDVnEzQ1hvOExwVVR0WTVJZTVaZ05nMTgzOFVmRXFxQlBQem9sWk1T?=
 =?utf-8?B?T2N3R2Z4L1hEaSt3QzlReTYvRjB4R3NlWGQ3TVM4ZFBGOERHaS9UbWd4V3Z6?=
 =?utf-8?B?L2dVaEtlaGxCY3cyUUFBS1c5ajdCc3doL003NmZ6OUdKaThzOUV0SXRZM3hx?=
 =?utf-8?B?ZjNMTlhDY3p1ODhwbmt1aXlzN3NyL2FFMzJpNzF4ZnlKZWEwS1JTa0RVUDRv?=
 =?utf-8?B?ZmhqK21nb2R3Qm1NRnBYRmFDSjBlUU9rMUh2eDVhWGV5NjJHdi9GbHN6T05l?=
 =?utf-8?B?TGdKbFJUTm5zdDBlYzVmWEE4UTk3R2RHU1loejhpSU4xQndWZ0RFUURMTTlV?=
 =?utf-8?B?SGlkOUw0NktPbkVPaXBmZGhoeVBSWlQrclo4YkpIL0s3YnNpaG96Njhwcnpk?=
 =?utf-8?B?WmlLQXFVYXVFZ3NGVEFiVlE0MG1oYnNTSVpjaXJmcUVFQ0dteFJNeTFkTkpk?=
 =?utf-8?B?OFpsYkVhVCtWV0E3bVZLL2srTkNXUExkcG9URytkcjRzcnp6VE9JbSt1bXVY?=
 =?utf-8?B?czdnU1NUdjZlUGpjSnkvRmlZL1NyZUVDREovQXY1cEdzd3JhNHM3MG5BK3A0?=
 =?utf-8?B?QUp6TDVsakpnOVp2VU9qSEo2aG9LZGlwRjIrbFJaM2FNb2R0OHBWcHQ3aEQ3?=
 =?utf-8?B?Z0RCeWtWdHZkb1JPOHZ6ZVZJdDRrd3NDMTRaUDZFV3JweXhKd1p6akxGMTZC?=
 =?utf-8?B?L2lnWjg5ajJrUUlMVVYzeGxaOFZESVRaMVVYSjlWSlVXMjJaSE8xa2pmUlNm?=
 =?utf-8?B?TUYwWmJHSXh2VUMrUFd5YWw2czc4bU1SakhSNjkzdGsxd24yUzdRL1NpUzF4?=
 =?utf-8?B?U09RbkdNbVJJc25SYnRET3crNHJvOTI0QkwvbkVJb3BQMzFJKzRqVnd2Wm5S?=
 =?utf-8?B?NlRkcWVOMDd4YVNlVG9memlaMUNHR3NDemtGZHdsdThOU2ZzbFZhV2JVR1RG?=
 =?utf-8?B?SjQ4YjFLbnlzR25lWlp6dlBkdDVuWVZEV2Fmd1dqTVd6Y3p4NHRKdDl1QlN5?=
 =?utf-8?Q?HN7nf73FYumehj+A/qIT9nzElYxrh6f0jMEno=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djVlbWNPR2U5ek5EZjRqck1ZTTdQcGliT0hBNVFFZktIRjhhMWdzamgwSnRU?=
 =?utf-8?B?TDM2Ry9uTkxZdTJDVHNaT3h0QXFQRmF6ZENISVgxN3NURjZzVGxsclZlQW1u?=
 =?utf-8?B?NVdxdUF4ekI4bkFJU0V3K3NaK3ZkUHE2RDVPTjl1Q0RpaExRVFkwN1lVT01E?=
 =?utf-8?B?TFdSc2oyRDRHejJmVVN3V2VRV0RPTVlwVE1KNGdwVFk4YVhiY2kwQVdHZFZ3?=
 =?utf-8?B?ZGo0UWgzclhWM3hrcm1XR1NlOVNyLzdFcjhpZWVuRXZpK3V5UFNSaHpLNVND?=
 =?utf-8?B?ODFDdmpOZXVhaWQ2UUI0V3VncHc4bHp0NHNxeEhaaFhUQWZhcllBdUlMRjI1?=
 =?utf-8?B?VGI4azV1QkJXRG5qQWhMZ3B0WDNVbXFXVmd6ZGlUQk1QRFF3TFB5VldSamhC?=
 =?utf-8?B?SzNTNDdMNFRxVnBSS0pXbmNyMTROQUlkbmQyRU5vSEw4QS85ekhIRzNKakc2?=
 =?utf-8?B?dE5mQ1ZQbDRuZ3RQRHNYUEtVUUtEVFczSWpocVhrYkpkM25tSDJuS2NWWnNS?=
 =?utf-8?B?YndOb1lpbCtkeHRJaWtxc2ljUkZ1Zk5aTUxrLzVMc0FBekR0Q0R3K0NucmJN?=
 =?utf-8?B?TlNrdzFNSFc5eGhLTnRQOWdlMjRtTGIybWZlMHVOVzF6ZEhyVGR1MUg4ZXdC?=
 =?utf-8?B?RlZmYmIwSUMrazd0Z1o1QTFRWnlwVmhXQUlOc1lJVFF4WWRxbGxtd0RQZEo4?=
 =?utf-8?B?Rkd0MXNvdnBHa1E3U0ZCcUg1MUFQM2dTUlJRSlliTElsZXg2UTVubDA2UWxJ?=
 =?utf-8?B?WExSQ1lsSk5KSlZJWnZ3K0c5Rkd4SFJuNDhEeG1adDVpa1Nxb0NJY1pxbm1x?=
 =?utf-8?B?aCtFZFdhZTZqQlhYYWU3bU9iQnVoQ2hLWitMaTJvdzNVMEJUcVFYMVAwaktk?=
 =?utf-8?B?cG92MnB6RlkzUkRpVHZCZ0hsbVJZMW03ZmdqeC9NQVlHWTNkd0g0RXFpUFd5?=
 =?utf-8?B?QTNPVkZhS0ZGSFRjM2NrWlNIbmZtaFZMemV2QjVkdnhoMmNtenFPbXl2UFd3?=
 =?utf-8?B?RjB0VHVITnl3YTFuUUM0c3g3Q3dCeDlhQnV0UGZRSHFBWlJwVm5uVVBXTmQ3?=
 =?utf-8?B?ajlQWGhOWjV3ZElmbXNxQW1BTlBNL0w4SUNRbHcrME8wZVJ5djBtWUcrWkFk?=
 =?utf-8?B?QUZuN3FnWURDVThpdTdJR3BPY3JzVzRzemE5WkRLSnBNaG1lUitpVkZMTS9s?=
 =?utf-8?B?RDBCRHpwWFhRcW50allOazdOc3RLRmZZTytIQVBKSmN2d3FtZGhOUEFxb3Rh?=
 =?utf-8?B?MkQrY1BLcDJvcU10T25DZ2grbW55YnMvRkdybVdUZzFtZFBtMmwvTTVLM3Z4?=
 =?utf-8?B?c2lOMytjdEJkYncrZmdpT1Z6eDBmRElxWS9JMENiUWpmNENCeWFMTTJLZVVQ?=
 =?utf-8?B?SnkwK0xkSzhLMnVKcEMwbnNxc0l4T0VpMzFuZVdMT0d4SWFMaS96VFFFZUx0?=
 =?utf-8?B?cUhnN0FFR1dVMFNCQ3FtSTBlRjJzMytlb1lrY2Fxc3Y2WmF1WDNZVi82U05D?=
 =?utf-8?B?c1VpbHlqQVJEK1RWR20vMDhUaDV1MWlvRTN1VHNySnRVa0JaeWNEK1RTenFC?=
 =?utf-8?B?eFpwd1RLem9TRG0vQSt6ODNFM1ZKMm1qUmUvYWZlZnl4OEQ2SlhsUStwTXlS?=
 =?utf-8?B?R3VLMmx4QUpiMEtHRUJST29BbWpaS1kvVGhnOXZHQmFZajBOd21keDlVRWRD?=
 =?utf-8?B?NW04WllrdkVDZWJmZWlnSXFQdzluWTJCUWhuSVRnK0dQYUN3bUtLNU9PTHhZ?=
 =?utf-8?B?Y3Y3SWRTcHFtd0duVTRTRXN6cmpSSkZhdkxaUG1Xajg4aWJBekF3Wit4bEIy?=
 =?utf-8?B?a1FVTnpXMStIQzR0dzVVMzEyUEM5TFhJbkxNdEZ1Vm0xYjlUaEllOGgvdWVy?=
 =?utf-8?B?OUcvTVRSZ0NNSlZVWDQ1QzVoYUk2NTRoelFYbWJjRWhLVkx4SXFpM3FWWXNR?=
 =?utf-8?B?aVl1aTFPY1VLZk5CNlBQakJaQ2lYVVArSlV3QzJTQUdsMHc1WkNoaERobXN2?=
 =?utf-8?B?S3RuVmdXc3U5ZlVrZEhNS0pWRDliSWF4UXdDWCtvenNsS1JSWWdCMlQwc0RE?=
 =?utf-8?B?MWVrRTAvZlBZSGNkZStxT1VtUW5DdTk4cWFrcFNSYlQ0QzgrYjdUVHdzWE1q?=
 =?utf-8?Q?XmP0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0d21b6-7f14-45aa-eb64-08dd01f308ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 01:49:09.4547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPUULwc9zKkXwP0NJiKPIHtvAJ+bw/kMYOQ/po22fBRDz7fxhSjTszSTNrGkI3wdqYoTzZkINgZGjf0i7l6vkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10410

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvOF0gZHQtYmluZGluZ3M6IGNsb2NrOiBpbXg4bS1j
bG9jazogc3VwcG9ydA0KPiBzcHJlYWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gDQo+IE9uIDA5LzEx
LzIwMjQgMTE6MDUsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMDkvMTEvMjAy
NCAwMTozNywgUGVuZyBGYW4gd3JvdGU6DQo+ID4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEv
OF0gZHQtYmluZGluZ3M6IGNsb2NrOiBpbXg4bS1jbG9jazoNCj4gc3VwcG9ydA0KPiA+Pj4gc3By
ZWFkIHNwZWN0cnVtIGNsb2NraW5nDQo+ID4+Pg0KPiA+Pj4gT24gMDgvMTEvMjAyNCAxMzo1MCwg
UGVuZyBGYW4gd3JvdGU6DQo+ID4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS84XSBkdC1i
aW5kaW5nczogY2xvY2s6IGlteDhtLWNsb2NrOg0KPiA+Pj4gc3VwcG9ydA0KPiA+Pj4+PiBzcHJl
YWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gPj4+Pj4NCj4gPj4+Pj4gT24gMDcvMTEvMjAyNCAxNTo1
NywgRGFyaW8gQmluYWNjaGkgd3JvdGU6DQo+ID4+Pj4+PiAgICAgY2xvY2tzID0gPCZvc2NfMzJr
PiwgPCZvc2NfMjRtPiwgPCZjbGtfZXh0MT4sDQo+IDwmY2xrX2V4dDI+LA0KPiA+Pj4+Pj4gICAg
ICAgICAgICAgICAgICAgPCZjbGtfZXh0Mz4sIDwmY2xrX2V4dDQ+Ow0KPiA+Pj4+Pj4gICAgIGNs
b2NrLW5hbWVzID0gIm9zY18zMmsiLCAib3NjXzI0bSIsICJjbGtfZXh0MSIsICJjbGtfZXh0MiIs
DQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJjbGtfZXh0MyIsICJjbGtf
ZXh0NCI7DQo+ID4+Pj4+PiAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1OX0NMS19B
NTNfU1JDPiwNCj4gPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNs
ayBJTVg4TU5fQ0xLX0E1M19DT1JFPiwNCj4gPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA8JmNsayBJTVg4TU5fQ0xLX05PQz4sDQo+ID4+Pj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPCZjbGsgSU1YOE1OX0NMS19BVURJT19BSEI+LA0KPiA+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTl9DTEtfSVBH
X0FVRElPX1JPT1Q+LA0KPiA+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDwmY2xrIElNWDhNTl9TWVNfUExMMz4sDQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPCZjbGsgSU1YOE1OX0FVRElPX1BMTDE+LA0KPiA+Pj4+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTl9BVURJT19QTEwyPjsNCj4gPj4+
Pj4+ICAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1OX1NZU19QTEwxXzgw
ME0+LA0KPiA+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPCZjbGsgSU1YOE1OX0FSTV9QTExfT1VUPiwNCj4gPj4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTl9TWVNfUExMM19PVVQ+LA0K
PiA+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZj
bGsgSU1YOE1OX1NZU19QTEwxXzgwME0+Ow0KPiA+Pj4+Pj4gICAgIGFzc2lnbmVkLWNsb2NrLXJh
dGVzID0gPDA+LCA8MD4sIDwwPiwNCj4gPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPDQwMDAwMDAwMD4sDQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDw0MDAwMDAwMDA+LA0KPiA+Pj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8NjAwMDAwMDAwPiwNCj4gPj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDM5MzIxNjAwMD4sDQo+ID4+Pj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwzNjEyNjcyMDA+OyB9
Ow0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFRoZSBzcHJlYWQgc3BlY3RydW0gaXMgbm90IGNvbmZpZ3Vy
YWJsZSBvbiB0aGVzZSBjbG9ja3Mgb3IsDQo+IG1vcmUNCj4gPj4+Pj4+IGdlbmVyYWxseSwgbWF5
IG5vdCBiZSBjb25maWd1cmFibGUgKG9ubHkgNCBQTExzIGhhdmUgdGhpcw0KPiA+Pj4gY2FwYWJp
bGl0eSkuDQo+ID4+Pj4+PiBUaGVyZWZvcmUsIEkgbmVlZCB0aGUgImZzbCxzc2MtY2xvY2tzIg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBOby4gVGhhdCdzIG5vdCB0cnVlLiBZb3UgZG8gbm90IG5lZWQgaXQu
DQo+ID4+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBpLk1YOE0gY2xvY2sgaGFyZHdhcmUgaXMgc2ltaWxh
ciBhczoNCj4gPj4+Pg0KPiA+Pj4+IE9TQy0+QU5BVE9QLT5DQ00NCj4gPj4+Pg0KPiA+Pj4+IEFO
QVRPUCB3aWxsIHByb2R1Y2UgUExMcy4NCj4gPj4+PiBDQ00gdXNlIFBMTHMgYXMgaW5wdXQgc291
cmNlLg0KPiA+Pj4+DQo+ID4+Pj4gQ3VycmVudGx5IHRoZXJlIGlzIG5vIGRlZGljYXRlZCBBTkFU
T1AgZHJpdmVyIGluIGxpbnV4Lg0KPiA+Pj4+IFRoZSBDQ00gbGludXggZHJpdmVyIHdpbGwgcGFy
c2UgdGhlIEFOQVRPUCBub2RlIGFuZCByZWdpc3Rlcg0KPiBjbGtfaHcNCj4gPj4+PiBmb3IgdGhl
IFBMTHMuDQo+ID4+Pg0KPiA+Pj4gSSBkbyBub3Qga25vdyB3aGF0IGlzIENDTSBhbmQgaG93IGRv
ZXMgaXQgZml0IGhlcmUuIFdoYXQncyBtb3JlLCBJDQo+ID4+PiBkb24ndCBnZXQgZHJpdmVyIGNv
bnRleHQgaGVyZS4gV2UgdGFsayBhYm91dCBiaW5kaW5ncy4NCj4gPj4NCj4gPj4NCj4gPj4gQ0NN
OiBDbG9jayBDb250cm9sIE1vZHVsZSwgaXQgYWNjZXB0cyBQTEwgZnJvbSBhbmF0b3AgYXMgaW5w
dXRzLA0KPiBhbmQNCj4gPj4gb3V0cHV0cyBjbG9ja3MgdG8gdmFyaW91cyBtb2R1bGVzLCBJMkMs
IENBTiwgTkVULCBTQUkgYW5kIC4uLg0KPiA+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pj4NCj4gPj4+
Pg0KPiA+Pj4+PiBGaXJzdCwgdGhlIGNsb2NrIGlucHV0cyBmb3IgdGhpcyBkZXZpY2UgYXJlIGxp
c3RlZCBpbiBjbG9ja3MgKm9ubHkqLg0KPiA+Pj4+PiBXaGF0IGlzIG5vIHRoZXJlLCBpcyBub3Qg
YW4gaW5wdXQgdG8gdGhlIGRldmljZS4gSW5jbHVkaW5nIGFsc28NCj4gPj4+Pj4gTGludXggYXNw
ZWN0IChtaXNzaW5nIGRldmxpbmtzIGV0YykuIFRoZXJlZm9yZSBob3cgY2FuIHlvdQ0KPiA+Pj4+
PiBjb25maWd1cmUNCj4gPj4+IHNwcmVhZA0KPiA+Pj4+PiBzcGVjdHJ1bSBvbiBjbG9ja3Mgd2hp
Y2ggYXJlIG5vdCBjb25uZWN0ZWQgdG8gdGhpcyBkZXZpY2U/DQo+ID4+Pj4NCj4gPj4+PiBJIG5v
dCB1bmRlcnN0YW5kIHRoaXMgd2VsbCwgeW91IG1lYW4gYWRkIGNsb2NrcyA9IDx4eA0KPiA+Pj4+
IENMS19JTVg4TU1fVklERU9fUExMPiBpbiB0aGUgY2NtIGR0YiBub2RlPw0KPiA+Pj4NCj4gPj4+
IFllcy4gTGV0IG1lIHJlLWl0ZXJhdGUgYW5kIHBsZWFzZSByZXNwb25kIHRvIHRoaXMgZXhhY3Rs
eSBjb21tZW50DQo+ID4+PiBpbnN0ZWFkIG9mIGlnbm9yaW5nIGl0Lg0KPiA+Pj4NCj4gPj4+IEhv
dyBhIGRldmljZSBjYW4gY2FyZSBhYm91dCBzcHJlYWQgc3BlY3RydW0gb2YgYSBjbG9jayB3aGlj
aCBpcw0KPiBub3QNCj4gPj4+IHN1cHBsaWVkIHRvIHRoaXMgZGV2aWNlPw0KPiA+Pg0KPiA+PiBJ
IGhvcGUgd2UgYXJlIG9uIHNhbWUgcGFnZSBvZiB3aGF0IHNwcmVhZCBzcGVjdHJ1bSBtZWFucy4N
Cj4gPj4gc3ByZWFkIHNwZWN0cnVtIG9mIGEgY2xvY2sgaXMgdGhlIGNsb2NrIGNvdWxkIHByb2R1
Y2UgZnJlcSBpbiBhDQo+ID4+IHJhbmdlLCBzYXlpbmcgWzUwME1IeiAtIDEwMEtIeiwgNTAwTUh6
ICsgMTAwS0h6XS4gc29mdHdhcmUgb25seQ0KPiBuZWVkDQo+ID4+IHRvIGNvbmZpZ3VyZSB0aGUg
bWlkZGxlIGZyZXF1ZW5jeSBhbmQgY2hvb3NlIHRoZSB1cC9kb3duIGJvcmRlcg0KPiA+PiByYW5n
ZSgxMDBLSHogaGVyZSkgYW5kIGVuYWJsZSBzcHJlYWQgc3BlY3RydW0uDQo+ID4+DQo+ID4+IGRl
dmljZTogSSBzdXBwb3NlIHlvdSBtZWFuIHRoZSBDbG9jayBDb250cm9sIE1vZHVsZShDQ00pIGhl
cmUuDQo+ID4NCj4gPiBJIG1lYW4gdGhlIGRldmljZSB3ZSBkaXNjdXNzIGhlcmUsIGluIHRoaXMg
YmluZGluZy4gV2hhdGV2ZXIgdGhpcw0KPiA+IGRldmljZSBpcy4gQ0NNIG9yIENDWA0KPiA+DQo+
ID4+IENDTSBkb2VzIG5vdCBjYXJlLCBpdCBqdXN0IGFjY2VwdHMgdGhlIFBMTCBhcyBpbnB1dCwg
YW5kIG91dHB1dA0KPiA+DQo+ID4gVGFrZXMgUExMIGFzIGlucHV0IGJ1dCB5b3UgcmVmdXNlIHRv
IGFkZCBpdCBhcyBjbG9ja3M/IEFyZSB5b3UgcmVhbGx5DQo+ID4gcmVzcG9uZGluZyB0byBteSBx
dWVzdGlvbj8NCj4gPg0KPiA+IEkgYXNrZWQgaG93IGNhbiB5b3Ugc2V0IHNwcmVhZCBzcGVjdHJ1
bSBvbiBjbG9jayB3aGljaCB5b3UgZG8gbm90DQo+ID4gcmVjZWl2ZS4gV2h5IHlvdSBkbyBub3Qg
cmVjZWl2ZT8gQmVjYXVzZSB5b3UgcmVmdXNlIHRvIGFkZCBpdCB0bw0KPiA+IGNsb2NrcyBldmVu
IHRob3VnaCBJIHNwZWFrIGFib3V0IHRoaXMgc2luY2UgbW9udGhzLg0KPiA+DQo+ID4+IGRpdmlk
ZWQgY2xvY2sgdG8gdmFyaW91cyBJUHMoVmlkZW8gaGVyZSkuIFRoZSB2aWRlbyBJUHMgY2FyZSBh
Ym91dA0KPiA+PiB0aGUgc3ByZWFkIHNwZWN0cnVtIG9mIHRoZSBjbG9jay4NCj4gPg0KPiA+IFNv
IHdoaWNoIGRldmljZSBkbyB3ZSB0YWxrIGFib3V0PyBJIGFtIG5vdCBhIE5YUCBjbG9jayBkZXZl
bG9wZXINCj4gYW5kIEkNCj4gPiBjYXJlIHplcm8gYWJvdXQgTlhQLCBzbyBrZWVwIGl0IHNpbXBs
ZS4gV2UgZGlzY3VzcyB0aGlzIG9uZSBzcGVjaWZpYw0KPiA+IGJpbmRpbmcgZm9yIHNwZWNpZmlj
IGRldmljZSB3aGljaCBpcyBjYWxsZWQgImlteDhtLWNsb2NrIiAtIHNlZQ0KPiA+IHN1YmplY3Qg
cHJlZml4Lg0KPiA+DQo+ID4+DQo+ID4+IFRoZSBjbG9jayBoYXJkd2FyZSBwYXRoIGlzIGFzIGJl
bG93Og0KPiA+Pg0KPiA+PiBPU0MoMjRNKSAtLT4gQW5hdG9wKHByb2R1Y2UgUExMIHdpdGggc3By
ZWFkIHNwZWN0cnVtKSAtPiBDbG9jaw0KPiA+PiBDb250cm9sIE1vZHVsZShvdXRwdXQgY2xvY2sg
dG8gbW9kdWxlcykgLT4gVmlkZW8gSVANCj4gPj4NCj4gPj4gRnJvbSBoYXJkd2FyZSBwZXJzcGVj
dGl2ZSwgQ2xvY2sgQ29udHJvbCBNb2R1bGUgZG9lcyBub3QgY2FyZQ0KPiBzcHJlYWQNCj4gPj4g
c3BlY3RydW0uIFZpZGVvIElQIGNhcmVzIHNwcmVhZCBzcGVjdHJ1bS4NCj4gPj4NCj4gPj4NCj4g
Pj4+DQo+ID4+PiBXaHkgd291bGQgeW91IGNhcmUgYWJvdXQgc3ByZWFkIHNwZWN0cnVtIG9mIHNv
bWUgY2xvY2sgd2hpY2ggaXMNCj4gbm90DQo+ID4+PiBjb21pbmcgdG8gdGhpcyBkZXZpY2U/DQo+
ID4+DQo+ID4+IGRldmljZSwgSSBzdXBwb3NlIHlvdSBtZWFuIGNsb2NrIGNvbnRyb2wgbW9kdWxl
KENDTSkuDQo+ID4+DQo+ID4+IFRoZXJlIGlzIG5vICdjbG9ja3MgPSA8JmNjbSBDTEtfSU1YOE1f
VklERU9fUExMPicgdW5kZXIgY2NtDQo+IG5vZGUuDQo+ID4+IEJlY2F1c2UgaW4gY3VycmVudCBk
ZXNpZ24sIGNjbSBpcyB0YWtlbiBhcyBwcm9kdWNlciBvZg0KPiA+PiBDTEtfSU1YOE1fVklERU9f
UExMLCBub3QgY29uc3VtZXIuDQo+ID4NCj4gPiBJIGRvbid0IHVuZGVyc3RhbmQgbm93IGV2ZW4g
bW9yZS4gT3IgSSB1bmRlcnN0YW5kIGV2ZW4gbGVzcyBub3cuDQo+IFdoeQ0KPiA+IGJpbmRpbmcg
cmVmZXJlbmNlcyBpdHMgb3duIGNsb2NrcyB2aWEgcGhhbmRsZT8gVGhpcyBtYWtlcyBubyBzZW5z
ZQ0KPiBhdA0KPiA+IGFsbCwgZXhjZXB0IG9mIGNvdXJzZSBhc3NpZ25lZCBjbG9ja3MsIGJ1dCB0
aGF0J3MgYmVjYXVzZSB3ZSBoYXZlIG9uZQ0KPiA+IHByb3BlcnR5IGZvciBtdWx0aXBsZSBjYXNl
cy4NCj4gDQo+IEFuZCBCVFcgaWYgdGhhdCB3YXMgdGhlIHBvaW50IHRoZW4gdGhlIGV4YW1wbGUg
aXMgY29uZnVzaW5nIGJlY2F1c2UNCj4gdGhlICZjbGsgcGhhbmRsZSBpcyBub3QgdGhlIGRldmlj
ZSBub2RlIGluIHRoZSBleGFtcGxlIGJ1dCBpdCBzaG91bGQuDQo+IE5laXRoZXIgZGVzY3JpcHRp
b24gc2F5cyB3aGljaCBkZXZpY2UncyBjbG9ja3MgYXJlIHRoZXNlLg0KPiANCj4gVGhpcyBpcyBl
eHByZXNzZWQgdmVyeSBwb29ybHkgaW4gdGhlIGJpbmRpbmcsIGxvb2s6DQo+ICJQaGFuZGxlcyBv
ZiB0aGUgUExMIiAtIGl0IGNsZWFybHkgc3VnZ2VzdHMgc29tZSBvdGhlciBjbG9ja3MsIG5vdCBp
dHMNCj4gb3duLCB0aGF0J3Mgc28gb2J2aW91cyBJIGRpZCBub3QgZXZlbiB0aGluayBvZiBhc2tp
bmcuIFBhdGNoc2V0IGdvZXMNCj4gc2xvdyBhbHNvIGJlY2F1c2Ugb2YgcG9vciBleHBsYW5hdGlv
biwgbGFjayBvZiBkaWFncmFtcyBhbmQgZXhwZWN0aW5nDQo+IG1lIHRvIHJlbWVtYmVyIHlvdXIg
Y2xvY2sgaGllcmFyY2h5Lg0KDQoNCkRhcmlvIG1heSBpbXByb3ZlIHRoZSBwYXRjaHNldCBpbiBu
ZXcgdmVyc2lvbi4gQnV0IGxldCBtZSBqdXN0IHRyeQ0KdG8gZXhwbGFpbiBhIGJpdCBtb3JlIGFi
b3V0IHRoZSBoYXJkd2FyZSBsb2dpYywgSSBob3BlIHRoaXMgY291bGQNCmdpdmUgeW91IHNvbWUg
a25vd2xlZGdlIG9uIGkuTVggY2xvY2sgYW5kIHdlIGNvdWxkIGdldCBzb21lDQpzdWdnZXN0aW9u
cyBvbiBuZXh0Og0KDQoNCk9TQyB3aWxsIGdlbmVyYXRlIDI0TUh6IGNsb2NrIHRvIEFuYXRvcCBt
b2R1bGUuDQpBbmF0b3AgbW9kdWxlIHRha2VzIDI0TUh6IGFzIGlucHV0IGFuZCBwcm9kdWNlcyB2
YXJpb3VzIFBMTHMuDQpDbG9jayBDb250cm9sIE1vZHVsZShDQ00pIHRha2VzIFBMTHMgYXMgaW5w
dXQsIGFuZCBvdXRwdXRzIHRoZSBmaW5hbA0KY2xvY2tzIHRvIHZhcmlvdXMgSVBzLCBzYXlpbmcg
dmlkZW8gSVBzLg0KDQpUaGUgQW5hdG9wIG1vZHVsZSBjb3VsZCBwcm9kdWNlIFBMTHMgd2l0aCBz
cHJlYWQgc3BlY3RydW0gZW5hYmxlZC4NClRoZSBDbG9jayBDb250cm9sIG1vZHVsZSBqdXN0IGRp
dmlkZXMgdGhlIGZyZXEgYW5kIG91dHB1dCB0aGUgZW5kIElQcy4NClRoZSBlbmQgSVBzIGNhcmVz
IGFib3V0IHNwcmVhZCBzcGVjdHJ1bSBmb3IgaGlnaCBxdWFsaXR5IGNsb2NrLCB0aGUNCkNsb2Nr
IENvbnRyb2wgbW9kdWxlcyBkb2VzIG5vdCBjYXJlLiBOb3cgYmFjayB0byBiaW5kaW5nLA0KDQpU
aGVyZSBpcyBhIGlteDhtLWFuYXRvcCBiaW5kaW5nIGZzbCxpbXg4bS1hbmF0b3AueWFtbCBmb3Ig
YW5hdG9wDQphbmQgYSBpbXg4bS1jbG9jay55YW1sIGJpbmRpbmcgZm9yIGNsb2NrIGNvbnRyb2wg
bW9kdWxlLg0KDQpJIHRoaW5rIHRoZSBwYXRjaHNldCBpcyB0byBlbmFibGUgc3ByZWFkIHNwZWN0
cnVtIG9mIGEgUExMIGdsb2JhbGx5LA0Kbm90IGZvciBhIHNwZWNpZmljIGRldmljZSBzYXlpbmcg
dmlkZW8gSVAgaGVyZS4gU28gdGhlIHBhdGNoc2V0IHB1dA0KdGhlIHByb3BlcnRpZXMgdW5kZXIg
dGhlIGNsb2NrIGNvbnRyb2wgbW9kdWxlLg0KDQpGb3IgZXhhbXBsZSwgdGhlcmUgYXJlIFZQVV9K
UEVHLCBWUFVfREVDT0RFLCBib3RoIHdpbGwgdXNlDQp2aWRlbyBQTEwgd2l0aCBoaWdoIHF1YWxp
dHkuIFNvIHRoZSBjbG9jayBwcm9kdWNlciBqdXN0IHByb2R1Y2UNClBMTHMgd2l0aCBTcHJlYWQg
U3BlY3RydW0oU1MpIGVuYWJsZWQsIGFuZCBwdXQgdGhlIFNTIHByb3BlcnRpZXMNCnVuZGVyIEND
TSBvciBhbmF0b3Agbm9kZSwgbm90IHZpZGVvIElQIG5vZGVzLg0KDQoNCldlIGNvdWxkIGhhdmUg
YSB0YWxrIG9uIElSQyBpZiBEYXJpbywgQWJlbCBhbmQgeW91IGFyZSBhdmFpbGFibGUgdG8NCmRp
c2N1c3Mgb24gdGhpcyB0b3BpYy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg0K

