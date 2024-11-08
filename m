Return-Path: <linux-kernel+bounces-401645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D569C9C1D53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D645A284766
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1D21E882E;
	Fri,  8 Nov 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NjHAuHsf"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6931E511;
	Fri,  8 Nov 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070240; cv=fail; b=TDvh0ZoL2yzQaQHkS4G0J3Hg4/REM6kSNt6UgH7fmHZjNYZ7hCJxiK6pLG7G5xem0Qu++HLAmxhmn1q8ZvYkESWnGyy47MiOMp9NcGoaKfN//Z3QRI0XaMxf89Dch5pRpm2b4c12Th1BdK8RI+GtRxD9vBHkZ6j+wxee8ym3j88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070240; c=relaxed/simple;
	bh=yTQbwOa0jKPCp5LYiO8iGjNYn5d/dEWCS9DNCf6NmSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2M6Bvmsgj/8b8MlxPfx56G2qg2zvJ5YkP1Yg3xfJXl6PrI6dSV9R7WiTWnx6bTbOlj5edVkP1kN3NQF7ktn4P4KObNqvXAaPV01YRQYrg67vFLOvmuDj1Art5O/ICfn3b5A8iu/ttyFe3E81oiCBJYUYEkr6mB+GFpQlB2AK98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NjHAuHsf; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD1e3hc8Urmc+zFBbGMyqnTAPYpkSjDaz+5SG9pcRN43eSno9B8cGSixULwWsTvggpFuISRm5DNr8QvvV1Q8DT/NjTfvHbJ2mxlOtfUde22/7BXFY3no6bj6FsIuP0vt1qO3p4F++V+ou6r4LiOyUhD5SEQMgTr3eZxx3BthRxHRtt1B19UjXh+WGKomtvqDEsjZqBZAX3bcJQMUMsQya9Ac8jn4g787YDiyxPpC5P0AMdVG+cRFqFKbZrmjmUtnjZNbdTbRq3zMWD+WLV5pXRLrAlf0rKFAYydAqRGsuyQ4YAbd+daEKKZGumb72HPLNsBBiLqFH4YEu1SaQFNVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTQbwOa0jKPCp5LYiO8iGjNYn5d/dEWCS9DNCf6NmSU=;
 b=R67PuZMjJRM0TfySRGgxpgGmhsxqrYm+CSKQkS78pqVPMiFI+XKnRGGctEb1+ms08fQHkImicwLn6qcIYzTBtiBo0frgovFGRlH3MPqLVr/+/5eEkJFIRAP7P7yu7nntsy6XF/Rf/saIYomzBqcE9ol5W/jLMjQQhPGCcq/l9wCxxhJHqxfHdGKl0Vn4l6k8K382ciYdH8o+42goG/QOIBlI5C1hAPYX+igTwcjUEK607KXOhvk1eOX2hvZV3VWDz+IFV08FaXwK2ubfv2RdwJCwQ5jhFV6gKuYOw13+TmL5gjZL021daIzslWYHSgk54j3O0l/12bWa0Q7BIQsR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTQbwOa0jKPCp5LYiO8iGjNYn5d/dEWCS9DNCf6NmSU=;
 b=NjHAuHsfieIfjVFr5LB1tf9m47P3UWfV1ynfT9WdePiMA4WpWjeMWRD1/fII4kIhbCOQyZbYRTFyBym4eehdvqT9/u9DZx066+JeDFSU/dFeVnMJpZaG50XZDvegTE7d1tsECCc1BA/DAHT0bctqlgdH27CYNg4W8Uaj2cQ2T9FXciXfpx3e8AEzPwud49vCKHTLyorJOCnQzCfmySvv7FKiPQ40/8EOYY6YAKPovybmpPoIqNC1SsTBn8bXr9bfMjIJDcbwhy1KvxagPkY4x+sWjhxoJNETkhYi5axRBr5gFwL6G7BGButUh398cBwr/3rPAXEpeCP0QMsUr4NJ9g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10579.eurprd04.prod.outlook.com (2603:10a6:102:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 12:50:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 12:50:34 +0000
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
Thread-Index: AQHbMCsiGosLFeSwx0KHxJlfsPaJB7KqSvgAgAAA1oCAAZ6NgIABZEoAgAAIjrA=
Date: Fri, 8 Nov 2024 12:50:34 +0000
Message-ID:
 <PAXPR04MB8459BE3474EFD4FCC28E0E82885D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
 <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u>
 <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org>
 <CABGWkvrYJL9=zrPSFuEAgKO+9gDHD6RmCJM6Br6Le_eh578ETQ@mail.gmail.com>
 <54dd6ae6-b992-451e-b1c6-8a1968955f4a@kernel.org>
In-Reply-To: <54dd6ae6-b992-451e-b1c6-8a1968955f4a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10579:EE_
x-ms-office365-filtering-correlation-id: c675337c-05a2-4039-c4e6-08dcfff3efbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dE0vN3hVdmRCQm51UURPVitQemIvZzN6NGlnc2NKQnQ4aFBhZE9sMXBVVDhz?=
 =?utf-8?B?OURDeFJEU091a2Q4dG1KVkFSd204dk0vS2hGb0RwRSs4Y0N3ZDFxN0pNTlhq?=
 =?utf-8?B?WUh1dGREYUNNNGUybUkvSEloY0RNSTU5Mlk5UFVDUnBHdE5LcXpZMVAzd09t?=
 =?utf-8?B?L1JKemZWbkhINllYcEtUV2t0c2hQWHRPeE94cm9aaXByUStFdXNrZkNMU3FE?=
 =?utf-8?B?cHhvVFZ1L05HSXVlQnBnUHVXVmdVcXhLTzNjUzlwcFcweHVVb1R5MkZORFdj?=
 =?utf-8?B?UFVxNzc3SkFVczNuWSs2VFFTTkNVYWxXNUdFWk5IUE9FTGxQWTBwNkVBMkVV?=
 =?utf-8?B?UUE1TDB4OElUak1sWFFKU2lTRXBaSjZaWjZEMzNmcWFLMi9EUDRWcEtXeGZl?=
 =?utf-8?B?QVRRcVFuN1lram44ZDlmaFVFM0oxUDFEYVNRMjNreCtCczhhcVEwWjJHQjA5?=
 =?utf-8?B?dXFUbzVRWmZxMkt2aUZNbUhjSkZrN0tsbVovQTVQNXI0ZkxNaUh3cUNDN0Yx?=
 =?utf-8?B?UEZ5dXBGWFp2TW5VT0RFd2xHVHU0MHNDcE5xODNTcEhVK2pqY2RPSjZRT1Ur?=
 =?utf-8?B?WnRlOXFGWkNJTmZzWW95S1lkcDMxd2Vac2tEa2lhSDI2Tno2bS9adFVwM0Rm?=
 =?utf-8?B?b3J6bm54VE9LSDlxbmsvQ1g3ekVvWkttLzdHdjR4SWFHRFdxY0FWK2pIc3R1?=
 =?utf-8?B?UXJ5cGpjekhaZGptSUN2MDBiYlhTOUF5YndCSWdIQkIyK2NvdGZmMEd5UStO?=
 =?utf-8?B?dXJ2OHYxSklsdElvNjFhZWlwcDBWalZjOWNUbmV2L2lYNjVZaWREcjJKR1Z6?=
 =?utf-8?B?aS9pSGxsUjdFTUhuYWdmcTE0NzlGK3RCbHgvaWhqbmFtdjFrMUk4V1p0b1E1?=
 =?utf-8?B?OWRaamJSYVlUMnRxc2Q5RGdYUW53SGF2ZFFramhMeFc2a2szUEZtWUt3QjlM?=
 =?utf-8?B?UFU2eWROUURZdGszNjhKS25PUTBRR0pZMllXS3ZsQmR5WjVGVFFmRVF0c2ow?=
 =?utf-8?B?b2pNWnlBcFJqdFpjelE5RXF1eGNCdFRtSGU0MVhaUHNCMVRNZmhtLzU3c0FL?=
 =?utf-8?B?OE5wOVVoK2I5RHZDVHh2UnZ2My9nWjRPaWJ4MlFhVHlFcGpVWm44bEI0NC9H?=
 =?utf-8?B?TEhTZXZFSWpqWVlhYUcrZSsxMGV4QUVWVnZJQmo1WDZHeVBhSHQ1UC82ZGR4?=
 =?utf-8?B?VE5abkJPWlZhOUpudnJseHFTUDVDU0ovVDVteHpZemJya21OSExSVnVyNDZT?=
 =?utf-8?B?UlhOZWhJbm5FR1hDR3htejh5d2JkbXNoaW9KS0QyaTFaNXV4Ky9BMUliTHZN?=
 =?utf-8?B?Um1Uek5sRXhoMWNpWVYxZzJXNW9Ya0tIeWVNYy9jVmNzZC80aTNYM3pvbDNs?=
 =?utf-8?B?bnpxOTczL3BaM01IejhwK0kxUkFwVGd5Q2VEVitYUGNBTDhVaHJ1QTFONzlN?=
 =?utf-8?B?TWJPYnRSVHF3VzBBRFRpTlpEOFZJMmo3SGhBNGdYS2JMTWVhV1BYVVdsMXB0?=
 =?utf-8?B?V0FFUU9lMTZLS1Fia1gwRExYODRURjBoT3FpQTZiVXZvakwzZ0JWSWE0TFRa?=
 =?utf-8?B?blNsaEpuc0pTcWpzSWZLa1dzYTJiNGNaMUt1VlNNRGxrQzl5QWFiVVFxaXlH?=
 =?utf-8?B?czh6dDdGZ1hLNnJsV25yMktGSHIvRlA1eThUejYrNk43a1lwTmVKdFFERUl4?=
 =?utf-8?B?VmNKMkt4dHJXOVN0VmRIS3Job3F2Sm9UdERiSnJSQ3VITGVRUGkrUWhEVVhP?=
 =?utf-8?B?ejFaNjFKdXJFQjgzK2VXdEZudVF0WWNIWnlmVDJrL1pja0dXQVUzdDlQWnVn?=
 =?utf-8?Q?6UsOp7ZwXqSkmf01dSeQ2PvVUHFs+lu9iuuqE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWluL0ZneDFUQlYzUjdrcVBtMy9VcmkrRHJLK2hEZFhVa1ZvUzU1Ty9aMk1m?=
 =?utf-8?B?ZENQeXQ2MXJIb0poWHhzZG5IYi90MEdKUWdXdG9rNWNaa284UVBKYVJIWlRR?=
 =?utf-8?B?YllyczRCUFo0NllBUHdwM3ExYVVUMUo3dENZZVFNYUF1NmZVQ0N0NG5lazFt?=
 =?utf-8?B?eFFBdHRhNi9aeFhOb1JuSTBUY0lRcks0S0paVGZhRGlYZmNmdVhQTVUvNkVw?=
 =?utf-8?B?cmsxeEVJbVhuT1dVcCtMTVVYU2NRNXFuaUlRSFlxdm1BdjdOVldMcGR4dDFQ?=
 =?utf-8?B?ODlFOEx1aTZMbVAzRlVnOEN4SU9CeHN5RTZpY1YyUlQ1OVEvNjZ3bGhTbHlJ?=
 =?utf-8?B?TkNPZVpDb01sTG05bzRCVE1zVWJMS3QvQlVkQnJoRktMWlpEM05oT2pTU29B?=
 =?utf-8?B?WkZOU3lzRW5jcEl4aCtsOVJZVVdDSjRkWk04dUN2QU5WRmRqdENiTStoZzNu?=
 =?utf-8?B?WDB6VHZVa2tKeVdTdnpNV0VITWJ1RVJ1U2Nnc05hSzRpTUh3ZFlFbTYyc3l2?=
 =?utf-8?B?Vm9kMHp5YlYwVkRwWjlXWW1TNWd5WWRpRFhvcFNZZm01UmlrOXhpLzRHSllj?=
 =?utf-8?B?bnNPR1BGelpVRXFvWURXN2htVUszaWViRDJVMUpIOFZRazAwUGlzOVFnV0FX?=
 =?utf-8?B?R3hrWDdEOUREendFTk9FaXRRTEFjZElQZE4rRjJXTFZMU1YyVUZBaEdwcENM?=
 =?utf-8?B?TlVVcXFROHZpbUh2eGJnY3E1UmNzMFUwaC9FZXk1elpjT1Q4RVl6T0o2dUxp?=
 =?utf-8?B?KzRRREM0RWsxbGFrS3RKSlJueWUzUTZpYUxod1k3TTh2SlJ2MVZ0eHdPK2ty?=
 =?utf-8?B?ZWZtSUw3NnVITlI4ME5qQnNUL0NvTS85R0VFeGFzcFVtMm9yMEluTXk3ejVr?=
 =?utf-8?B?aWh3VElKcTBSK3o1enpnVmtVSzRHRElmSHJQTmVLR2xncDhHREFvNmpZQ0JC?=
 =?utf-8?B?MlFGYll4S0VhOHB6YjRieFNqQU1tU3NscW0yZzBTaXRIbUtTTjFXeHRqZVdE?=
 =?utf-8?B?Nnl3TjRvRVNzOExTMWNJZ3YvVW9vbmt3SGlkbWdwMi82ZzNKb2hhQmFxNHlz?=
 =?utf-8?B?d3pneUU5a3hhcXV5ZUEvTlZVOFErbktmVUt0QitYS2RyQUFPZE13b09oTTh3?=
 =?utf-8?B?eEFkNVFMaGR5QXVleUN3M2g5OXZQTGg2dk1GZ3Z5N3U1Mnk4Wld0UUFXU1dH?=
 =?utf-8?B?c05IcjViYzNTa2hiYlhYNlZ0L0lnZ24yTWE0eTl5MG15VHY2M2VieXdhOGov?=
 =?utf-8?B?ZEt2bTBiYm0wbHVIWW1lckQxU2toTEh5WUViY2o4N3VxbG5TczQxbHZVTy85?=
 =?utf-8?B?T2hkblpCUFVDVFk2ZXcxaGZIaXNIR1BEdHY5MDZDR3NjZk5hSjhpekRiVFBP?=
 =?utf-8?B?UFlCV3lTNmhRbFovYk1PYWh6UkFwSjV1b2hQVjdMWkdIekp6SHJKeHlTU1BH?=
 =?utf-8?B?UWpkME03NUIzY1ZCWDFJK1MvQ2VEK3h1dmltWmY0UExtdlpuSGlWdTlNWHQ3?=
 =?utf-8?B?aE1pQi9pb3p2K295SjJKUW9RdlppZDdvc05uemkyTjAzMEFSbW5WNkVGbEln?=
 =?utf-8?B?Q0JBNE1DZSt0WXlra01ySEIyQWpwMXNhSGZoUUd6ckM1UHRCbERUSDhiMUQx?=
 =?utf-8?B?WmlJRGJZQno2WXN2bkpDR1NFbWFRd1huclJTN3hTZlR4RzhCT0NGNVJ4ZkZr?=
 =?utf-8?B?TlJ1QWl5cDl3cGdlTzNKR0VlcEZ5aXpCMW43T21Hc05rb1FmNEVUQmMvOFQz?=
 =?utf-8?B?VXo5RWdnaFRQYitISEVBWW8xN0dSZitZN1hvSlJkV3EwdVdvQjNBNktTbkVz?=
 =?utf-8?B?enJmaDRXNEdGdnV3a2V0UzBnekxhU0o2cFhJcEc1WHJjYVFnOUxoQW9XTndy?=
 =?utf-8?B?ME05M05KRHFuR1ZGT2phTUg1eTErbEprMkVkZ0hiSUprYmtGRm5vNWdFc3ZJ?=
 =?utf-8?B?bi9pc0NaMFoyRkhOM2NYTldZZ3ZkOFJSY0N5dHNtVVVvUXBGMjd5Rk9aUEY5?=
 =?utf-8?B?TzVCREh2VjFmSmxvU1pkQzQ0QWxZY3pRZDFPTDhFR2k1YXdRY0QybTliZDVk?=
 =?utf-8?B?MVNyVCt1NW94M0lmNWVycDVOa0pSQjlRRjlWdGc2c2diVjFTMG14T1RRM25L?=
 =?utf-8?Q?xcq4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c675337c-05a2-4039-c4e6-08dcfff3efbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 12:50:34.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0yIWYzgA8YHAPN5x6f/+6BPTI0c8GzggKP+WMCHUsMW9gS049fLgUl2ypyLRd8im2tcyfEhTrhz8lZig/25pfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10579

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvOF0gZHQtYmluZGluZ3M6IGNsb2NrOiBpbXg4bS1j
bG9jazogc3VwcG9ydA0KPiBzcHJlYWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gDQo+IE9uIDA3LzEx
LzIwMjQgMTU6NTcsIERhcmlvIEJpbmFjY2hpIHdyb3RlOg0KPiA+ICAgICBjbG9ja3MgPSA8Jm9z
Y18zMms+LCA8Jm9zY18yNG0+LCA8JmNsa19leHQxPiwgPCZjbGtfZXh0Mj4sDQo+ID4gICAgICAg
ICAgICAgICAgICAgPCZjbGtfZXh0Mz4sIDwmY2xrX2V4dDQ+Ow0KPiA+ICAgICBjbG9jay1uYW1l
cyA9ICJvc2NfMzJrIiwgIm9zY18yNG0iLCAiY2xrX2V4dDEiLCAiY2xrX2V4dDIiLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgImNsa19leHQzIiwgImNsa19leHQ0IjsNCj4gPiAg
ICAgYXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1OX0NMS19BNTNfU1JDPiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZjbGsgSU1YOE1OX0NMS19BNTNfQ09SRT4s
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTl9DTEtf
Tk9DPiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZjbGsgSU1YOE1O
X0NMS19BVURJT19BSEI+LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8
JmNsayBJTVg4TU5fQ0xLX0lQR19BVURJT19ST09UPiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPCZjbGsgSU1YOE1OX1NZU19QTEwzPiwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgPCZjbGsgSU1YOE1OX0FVRElPX1BMTDE+LA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU5fQVVESU9fUExMMj47DQo+
ID4gICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JmNsayBJTVg4TU5fU1lTX1BMTDFfODAw
TT4sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZj
bGsgSU1YOE1OX0FSTV9QTExfT1VUPiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU5fU1lTX1BMTDNfT1VUPiwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU5fU1lTX1BM
TDFfODAwTT47DQo+ID4gICAgIGFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDA+LCA8MD4sIDwwPiwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDw0MDAwMDAwMDA+
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDQwMDAwMDAw
MD4sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8NjAwMDAw
MDAwPiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwzOTMy
MTYwMDA+LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDM2
MTI2NzIwMD47IH07DQo+ID4NCj4gPiBUaGUgc3ByZWFkIHNwZWN0cnVtIGlzIG5vdCBjb25maWd1
cmFibGUgb24gdGhlc2UgY2xvY2tzIG9yLCBtb3JlDQo+ID4gZ2VuZXJhbGx5LCBtYXkgbm90IGJl
IGNvbmZpZ3VyYWJsZSAob25seSA0IFBMTHMgaGF2ZSB0aGlzIGNhcGFiaWxpdHkpLg0KPiA+IFRo
ZXJlZm9yZSwgSSBuZWVkIHRoZSAiZnNsLHNzYy1jbG9ja3MiDQo+IA0KPiBOby4gVGhhdCdzIG5v
dCB0cnVlLiBZb3UgZG8gbm90IG5lZWQgaXQuDQo+IA0KDQppLk1YOE0gY2xvY2sgaGFyZHdhcmUg
aXMgc2ltaWxhciBhczoNCg0KT1NDLT5BTkFUT1AtPkNDTQ0KDQpBTkFUT1Agd2lsbCBwcm9kdWNl
IFBMTHMuDQpDQ00gdXNlIFBMTHMgYXMgaW5wdXQgc291cmNlLg0KDQpDdXJyZW50bHkgdGhlcmUg
aXMgbm8gZGVkaWNhdGVkIEFOQVRPUCBkcml2ZXIgaW4gbGludXguDQpUaGUgQ0NNIGxpbnV4IGRy
aXZlciB3aWxsIHBhcnNlIHRoZSBBTkFUT1Agbm9kZSBhbmQNCnJlZ2lzdGVyIGNsa19odyBmb3Ig
dGhlIFBMTHMuDQoNCg0KPiBGaXJzdCwgdGhlIGNsb2NrIGlucHV0cyBmb3IgdGhpcyBkZXZpY2Ug
YXJlIGxpc3RlZCBpbiBjbG9ja3MgKm9ubHkqLg0KPiBXaGF0IGlzIG5vIHRoZXJlLCBpcyBub3Qg
YW4gaW5wdXQgdG8gdGhlIGRldmljZS4gSW5jbHVkaW5nIGFsc28gTGludXgNCj4gYXNwZWN0ICht
aXNzaW5nIGRldmxpbmtzIGV0YykuIFRoZXJlZm9yZSBob3cgY2FuIHlvdSBjb25maWd1cmUgc3By
ZWFkDQo+IHNwZWN0cnVtIG9uIGNsb2NrcyB3aGljaCBhcmUgbm90IGNvbm5lY3RlZCB0byB0aGlz
IGRldmljZT8NCg0KSSBub3QgdW5kZXJzdGFuZCB0aGlzIHdlbGwsIHlvdSBtZWFuDQphZGQgY2xv
Y2tzID0gPHh4IENMS19JTVg4TU1fVklERU9fUExMPiBpbiB0aGUgY2NtIGR0YiBub2RlPw0KDQpD
dXJyZW50bHkgdGhlIENMS19JTVg4TU1fVklERU9fUExMIGlzIHJlZ2lzdGVycyBieSBDQ00gZHJp
dmVyLA0Kc28gaW1wb3NzaWJsZSB0aGUgYWRkIHRoZSB1cHBlciBjbG9ja3MsIHVubGVzcyBhIGRl
ZGljYXRlZA0KYW5hdG9wIGRyaXZlciBpcyBkZXZlbG9wZWQuDQoNClRoYW5rcw0KUGVuZy4NCg0K
PiANCj4gU2Vjb25kLCBJIGRvIG5vIGFzayB5b3UgdG8gY29uZmlndXJlIHNwcmVhZCBzcGVjdHJ1
bSBvbiBvdGhlciBjbG9ja3MsDQo+IG9ubHkgb24gdGhlIG9uZXMgeW91IGludGVudCB0by4gTGlz
dCBpcyBmaXhlZCBhbmQgb3JkZXJlZCwgc28gbm8gcHJvYmxlbQ0KPiB3aXRoIHRoYXQuDQo+IA0K
PiA+IHByb3BlcnR5IHRvIGxpc3QgdGhlIFBMTHMgb24gd2hpY2ggSSB3YW50IHRvIGVuYWJsZSBh
bmQgY29uZmlndXJlDQo+ID4gc3ByZWFkIHNwZWN0cnVtLg0KPiA+DQo+ID4gRnVydGhlcm1vcmUs
IHNwcmVhZCBzcGVjdHJ1bSBjYW5ub3QgYmUgY29uc2lkZXJlZCBhIG5ldyBkZXZpY2UNCj4gYnV0
DQo+ID4gcmF0aGVyIGEgcHJvcGVydHkgYXZhaWxhYmxlIG9ubHkgZm9yIHNvbWUgb2YgdGhlIGNs
b2NrcyBtYW5hZ2VkIGJ5DQo+IHRoZQ0KPiA+IGNsb2NrIGNvbnRyb2xsZXIgbWFuYWdlciAoQ0NN
KS4NCg0KDQoNCg0KPiA+DQo+IA0KPiBNeSBjb21tZW50IHN0YW5kcyBhbmQgdGhhdCdzIGEgZGlz
YWdyZWVtZW50IGZyb20gbWUuIEZlZWwgZnJlZSB0bw0KPiBnZXQgc2Vjb25kIERUIG1haW50YWlu
ZXIgb3BpbmlvbiwgdGhvdWdoLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4g
DQoNCg==

