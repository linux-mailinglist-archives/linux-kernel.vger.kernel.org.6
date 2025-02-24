Return-Path: <linux-kernel+bounces-529120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3584AA41FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20A11644F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4579233737;
	Mon, 24 Feb 2025 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XvuCwwK2"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00C23BCEE;
	Mon, 24 Feb 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402566; cv=fail; b=bFHAeNjjScexl7Es4n7EQs8QwkypJtypftrlw7JAUrG4PYgxbQn3NpYK0Zw2/3St6F3vOP6qe7sgH8iKz9QRHSGVBk8vN8TQzk7gBETIQZodeLrTDSXxUSS1wYNUSunRdMyuQgu2WBmSC/TBW9iGmpCJb8AMf5zfatQpViiN4F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402566; c=relaxed/simple;
	bh=8MBv6y2zkmGZMB1X0LFA8ZzbCxJO6UcjqcZBlvTg6wE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJoaa3ToHe1fer+wSdcjHclHOB26JMXJeoYeDn44MqOzh4k8hHO+vXM6w4hLKmJv8irvgsiS8PMF9XXjxb49kb9EwzEWs1SgRsmuIdE1720hUXCiZaXDi1AprDqKbg+l9oTq2HwTL+W7xMRhu1U9VCrH3+jHHBo58zYO0QbFEbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XvuCwwK2; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyPRRElBn+AT/5w0oKIAkDLclhX7AYqHxNT0JnFkbvHOl22ugI/27/d2JvwHHQKmADCKSHr6m0BB4dWfu+TDg+l44OQ9WSnJaiN4FnXLfg8hkudf+qOyrRl5tQ9IpqLHSKuqXKKbn4R3VUfJc62uf9EYDc1EXopNUTr+mT9MensDO8M94YexitmE2DvkXtSoXPvZkiK8QrvIoF+U5SS19ggwucm6Labhu4x1bYK88XcYgEuPa89HQlEu3R411FZWPVjOQ+y1Ga3zTuOynoUEg4dBHoKqxoA+PNB7ksEFW1W80cIxhm9iWI5C7GXvFx/pomzYxTeG79mgcQbkOP78kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MBv6y2zkmGZMB1X0LFA8ZzbCxJO6UcjqcZBlvTg6wE=;
 b=OMhhUU045a/Y6vFAf5DUu62a911IRxZ/pfjct0EvrZZrAvgYy1JlR0obhHmqR9waE7oxS2woU/mL6RbK7eyKkX283TVR/SNfUKEAV9mSIv8XIheSnfR9JahdARvu1y/+F220PtPbPzPBEnvxoAhE0cNKzjFP/XevLMNNsx8rpCM/R0RBBDOyo+8X+RoMmNTiVJmVr6BFy+3ZPm1I23kz3zvj8zO7wmkTQyeYLGNOL4WtkVcDQD1E2TwWBhfB75qevO6m9clYDcVOGb34T/1lNyJ9eSZ1EpKOoOeEc+/W363dvGRIRSmTUDu5V5jvjPhcTVKb4pyyD0lbRnQTECxMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MBv6y2zkmGZMB1X0LFA8ZzbCxJO6UcjqcZBlvTg6wE=;
 b=XvuCwwK24HWvzYVq8dRpnxnOdh3BNciGL01/VSQNjWhH/0CviCE2xKx9YAhKEdGyn9iwir0VHOvGD+cDT/QUwiSSIgd7bKpy6yC6K8z/pIlHM+uTSHtpkTeIjevh3c1BrQeejKRpVTZB8YLM4kFbblVA6ssoiU3zmbdixlNAMBxkHNGzVaMXsK65OukJPvvaZ07Gzr25EyJugANN8VcsqEq5GpGK3PdyppTtgvlH4i6Rva7fL9B1YCgL5Y6u/UjHwZ2sytgWDNjb0uKVDNJOMHfeelptOfIZ1lLwYboBSjp+tpFEpzQVKCL05anHTAdAoOUDNWIlA6mXkL/CCbK2UA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 13:09:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Mon, 24 Feb 2025
 13:09:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Cristian
 Marussi <cristian.marussi@arm.com>, Abel Vesa <abelvesa@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Dario Binacchi
	<dario.binacchi@amarulasolutions.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 0/4] clk: Support spread spectrum and use it in
 clk-pll144x and clk-scmi
Thread-Topic: [PATCH v2 0/4] clk: Support spread spectrum and use it in
 clk-pll144x and clk-scmi
Thread-Index: AQHbd7NuuRHK1Ej4u0urpGH2QficorNWiQLg
Date: Mon, 24 Feb 2025 13:09:20 +0000
Message-ID:
 <PAXPR04MB84596732B538D24F95E9FAC488C02@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com>
In-Reply-To: <20250205-clk-ssc-v2-0-fa73083caa92@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB6859:EE_
x-ms-office365-filtering-correlation-id: c4939664-b310-4c6a-542b-08dd54d47388
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3hRMEhhcG9aU2NtQ3MvSE9wL3RFbjNPUzROdXVmdUNxOTA3bFJ5enhNSHJG?=
 =?utf-8?B?S2FsZHdIclhPU1RBS3IrRnI5Z2xtOXpOZGZHOHVJMkFWeGNhVG56eUVlN05q?=
 =?utf-8?B?ZytRbngwUnJsT3BZcnBFTVlNNjhNVzBURUVOeE1GMG1RbFdpZE5XOU9JRUdO?=
 =?utf-8?B?WnhYdy9ucWM3RXlFbEthdUVESW5mRFBYNzBMNzBZSU5BRUpDZzF0TlhZZGtC?=
 =?utf-8?B?SklySDFza091ZmdOcVVlN3B6ODdiR2w4UzVmZzlsODlBUTVYeE16SE50OE1o?=
 =?utf-8?B?dlN1WUVCaVNLUm1lM3g3azJMS1VXbG4vUUt1ek8ybnY3SUIvUk1helRWSzRM?=
 =?utf-8?B?d0JoK0pjRHFGZWpGOHcrVHZVLy9tNWxrcnBVVEQ2eG5JNmZSYlpSMFZLVW51?=
 =?utf-8?B?UGZZa2d5b0V6NGoxWkpGMWpudkN1NkNKdVA5M2xjMmxZVGRyRWtOM1FWOUtT?=
 =?utf-8?B?MHBhT0l0WVk5VHp0emJvb0NxcnBzaVJXSGZzKzlnQ0RPUXRqRE5GdTdOcHBi?=
 =?utf-8?B?b1dzMTlDRnNYdHJhVFZ6d3BCcEttWVVMRHBGNXJwbzloOXhrbHFrNVc1N2dD?=
 =?utf-8?B?VThzVy9UWE8raEhGWmdLMXdxcWRyRjcyNC9kL204Y2lOY1dmdnRkeWYzOVJQ?=
 =?utf-8?B?QXJqZFZkcjJ3MG9UUlRUS21kbnIvRXFVRW9yL0xtKzJTNUhUei91NjVMaEhQ?=
 =?utf-8?B?MnlhcStrMmNFUEttY2hvN0xtWEltbmU0S3ZUM2RtZ3VkL043eW1mNjg0US8w?=
 =?utf-8?B?Zm9KaUFoUEVCQ3JjL3JuU2pvQjRYaTlFOU1ZdmJHblpnNTlKaTIrRjRmMnNi?=
 =?utf-8?B?WFZtK0JaNVFUd2JXb1BxRVFNZy9IWE80clpDTFpZRE5XcFpxWWNzMm4rU2tZ?=
 =?utf-8?B?ZmwxL25vbTVOWFJ3ZFFvdDI3UlFSV0pnbUlLTmpZdVJHUlhwbFdXNVM4Kzhw?=
 =?utf-8?B?NEFPYUhubzFBNS9kdXg5M29ycVpZUWhOQWRpeVFJYTI3eDBNQjdPWVBDK1g0?=
 =?utf-8?B?MUhkdGs4dE1PZlAyb0JWSFlPeGNqWEw5aGt2ZFAwN0FXTlBGZk1GcS90U1pV?=
 =?utf-8?B?ZHdnU0lxNmlhMUdTNy9QOEZnbjJRSUlhYkdpRTFaNENsRmdoZEtNUkFuVVF5?=
 =?utf-8?B?OTdGWFptYkhUL012NlZldmpVNFN1anJPd1NQNkE3ZXlncDJqZjQzd1JzQTNY?=
 =?utf-8?B?cUFiS294UkJmUTNNTGRrb25xQllxMEVlaXNEZ2dpOHIvUDZnb2xMbHpIUXQx?=
 =?utf-8?B?YUxwUHZPalpkL0tkeGs5UmQ1MzlLaFBJMVp4RmFiM0ZoNjFXYzFrWkphUnUv?=
 =?utf-8?B?OUE5MnFRcHZ3cHVQSnQrNytSZk9JUW93cUtwVHJxR1BzdlVxUVY1UEx6Wnk4?=
 =?utf-8?B?dHBvd1pJY1dBQmFBRkZaV3dRY044R1hWeUdVZWI5YnZUMm5veTFrTzlWUFQ5?=
 =?utf-8?B?UmwzSlFTVWQwbVNwUm4zVGNSbTNxcTdyamtRS0ppOHB1TUQzU2k0Z2x2MlhH?=
 =?utf-8?B?QVhoU1NYZUlnVUhtWXptK2VUaHVFdkJ5OVlVZUJ2dzZrOFFoWitmbEVTQldi?=
 =?utf-8?B?SkQ2OTNuL0ZXY2s5YStFZ0hGMHp3Z1pTRmVKVzFCV3J4Sm1xRDI3a0R4UWhT?=
 =?utf-8?B?Y0laa1hMRUVYQ0tuTXRyUDl2TDd5QTBuSFZ3Q0hrUmh2ZVFoYmllb3l4djJD?=
 =?utf-8?B?dlN3ckJ0RVhNd3NPWUdiRlloVmZLcEVTbFpNeW1SYy9pdFA4SmRMbmsyMWVp?=
 =?utf-8?B?V2RQSWNCN2NpMnJONW9tZWRWdjZxMGFMbTFYWWt0SU93QS8wM3F4QndpSERk?=
 =?utf-8?B?ZTJGcU9WaXJEUmIzNERHOER5TTEvVzlVeFJsazhxOXRYV1ZjOHNGamY4U1pz?=
 =?utf-8?B?bTNIcnp3bUk3VFUyZ0ZQdVo2WHJRYW52d3dvNVNORlltYVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VU9UY2NrcXIyQ3gwZXNhL1phWDVKd0N6S1NSYlpjajRHU0R3bmZmWUFqQ0Vs?=
 =?utf-8?B?cnJqT3lJdm54Sml3UUY5cmlSL3ZtaldPN2JBcmVUQnNIMVNHOWFaczFZSXBJ?=
 =?utf-8?B?enhxTzNQMThYR1FianJWelgrSXhDNW82NTNBS2ZETm1LVTIva00vS2xmU0Yv?=
 =?utf-8?B?cWtUWTZudmZUVzhEUHVGY0NhaG9nYXVSRDJmZjRJOU5YdE9hb0VBVG1iMFdp?=
 =?utf-8?B?YSsycjZnVlowakdiWEI0eVc0N3BSN1dTMjkxY1pxMmtjbjVnVWZUUW44Ri9Y?=
 =?utf-8?B?THJ5K210b1crMmVYaHd4TFlSMExuM0QzOXNiMnV6dE1wUkRUWllzOXRJNmsw?=
 =?utf-8?B?a1YyajFYWEIybHVKbmpUMGxVZ2MrdFFscDhyU0pRK3NvUVpadjg5eUZsZ3pW?=
 =?utf-8?B?V20xamphT3ZwUjZ0R2ZWZHpnQ1dYb1c4WjA1TUFxVWlPWnd1SUl4aW9ueDJR?=
 =?utf-8?B?d2twMkpjeDRmVlF2dlg3VCtYWW5BRXFmVFRNVC9UWlR1Q2xHN3ord3BvbVBi?=
 =?utf-8?B?alRScm5wKzZxOW9nMFp0UmN3czRWdHNibmF5ODJwZXN5NmtEQ3hTdVFzMHJY?=
 =?utf-8?B?ZGRvWDd3YXl0Q0ZIbjY4QVROelJBVmV5am9vTmQrTmRhNlRnOFNGNjZwNmY5?=
 =?utf-8?B?OE10bGJ2RURKMjdHdEducnNRUTc0M2lJV1RXSDdDYkVuZTB2VHhybjF1bnBW?=
 =?utf-8?B?ZDVwb3Z3ZlIrb2t4SFVZc3ErU2xJQUpsVUFXV3VaYUpSQjdtVm85clVnM05z?=
 =?utf-8?B?Rlk2d3V2KzF3ZCtLVUk0b21KUzZXQ09vZmlObHFSaUovd2xKb3puOXp1NXFl?=
 =?utf-8?B?ZEJvOWhVd21ZL2dnbkN3M2xURjhRS1J4TlpQaElMZ1FScnAyanVMZGtvMUJ3?=
 =?utf-8?B?QjVwWm9VZ0xFT09sSEV5MTNLOU16MjNWRWNkY29GR3JBd3FCRHd6c21WRUpV?=
 =?utf-8?B?eGNjYU9BSWU4TnJOclIra0pBLzEySkVGUlk5WWQwV0RFbnlCT21OOUhRMnNR?=
 =?utf-8?B?THV5TDVRWDI2RFJJMUhjb203cVc4dld5Q0k5QUU5UTlsdmRxNTR6NGwwY0JX?=
 =?utf-8?B?V0d5Z29XNEROcnV2MXhtMWp3VllINm5nUTVrbGs3L0xhdGp5aytCUjJxYlZC?=
 =?utf-8?B?WVQ3RXhyV0VJaHplbTVmM1dqS24wQWNSZld0Qk50bWtCUjJsMEgwODBtSmtI?=
 =?utf-8?B?a1ZiSVVCQzZaSE93Rzk4VXJFSTBXdEVwaTFlVklROFk5YXdBMVNES240Q0JI?=
 =?utf-8?B?ZEdwZklGanozMm93L3kxa1pmQnZINHV4bmpBZ2FiUTVSbEpPc2tTbXVyZ21L?=
 =?utf-8?B?VjBKaWViNDFFOHN3MW1tVVhVd1JsNmJma1FDMUx6WE0vY1kzeEpoRTdyUURh?=
 =?utf-8?B?eSs2Z3kxWXpZWUdKNGZjaEt4andBQmwva2FVWEY2bFEvb2ZNN0swSWUwdlBo?=
 =?utf-8?B?RHJTdWY2bUVQcmRWUmN1eWJwWU92NU1kMWJrRk1xYUZSbGs0aCs4NUlHQUR4?=
 =?utf-8?B?SjRsLzBnRHUvOHBtQzA1dGRWVG9ITEZlUHdpalZYMndEdVVKSUtmVzNrZjhT?=
 =?utf-8?B?TENwcW0zT1NOWEg2cEI2VXNVNGJTVDJkYTRGblUxK3VsSlVmVW5nZUFIc2lL?=
 =?utf-8?B?Z3NiWUhjaWU1by9mbDJjc2lQME9HU3R0cmhNbk9qZTFHekxFNG12cUROdGpD?=
 =?utf-8?B?WXVWbXhScVlkMU9PSnh3S0JleTYzaHZ5eDlScDVnb0UvcktEQ1dEMGZ5ZkJo?=
 =?utf-8?B?a1hlSnVvZmtGZTI0YmI3bXZ0Tmdsd1RHelUzckZVWDFsczY3M2d5bVBCdkFv?=
 =?utf-8?B?bEZPS21CN0hxY0lpYmQ2ZzNKN1RQZC9Qd0VlbDFOSTJvYk8vdWgzOE04ZjQ0?=
 =?utf-8?B?U2pFQ3A3ZzR2aGxmK0xFVjd5SHJpeFNzdmkxTkdIYWN2WkxYQkJKc05YM2tx?=
 =?utf-8?B?WGlTZHQ2U3NjaWhjajlFSzZtaDFhYTY3VkJuMWRKQVlIbDAxdER6dkQvbERK?=
 =?utf-8?B?eW9MeU4wTDdReDJROUpJV0JIOEJFZmROZGF6N3pxR3hoaFA4c0Rqc3BZRUI2?=
 =?utf-8?B?VUdaSG5kS01OSFdmY016bSt5QU8xdEluVGEzNldOMUJIc1NhTGtibjM1dkVv?=
 =?utf-8?Q?sk2A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4939664-b310-4c6a-542b-08dd54d47388
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:09:20.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4N+V35xY1IqF8IOG+vJ3JYkNBhA5EJ3EfFZGagYtPBWaVu1x/1eTcV5bcC7mYyBaIDQZXrfT8KUrKQixIpQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6859

SGkgUm9iLCBTdGVwaGVuLA0KDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwLzRdIGNsazogU3VwcG9y
dCBzcHJlYWQgc3BlY3RydW0gYW5kIHVzZSBpdCBpbiBjbGstDQo+IHBsbDE0NHggYW5kIGNsay1z
Y21pDQoNCkRvIHlvdSBoYXZlIHRpbWUgdG8gZ2l2ZSBhIGxvb2sgb24gcGF0Y2ggMSwyIGFuZCB0
aGUgYmluZGluZ3MNCnBhcnQgaW4gaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUtb3JnL2R0
LXNjaGVtYS9wdWxsLzE1NA0KDQpJIHdvdWxkIGxpa2UgdG8gc2VlIGlmIHlvdSBhZ3JlZSBvbiB0
aGlzIGFwcHJvYWNoIG9yIG5vdCwgdGhlbg0KSSBjb3VsZCB3b3JrIG9uIG5leHQgc3RlcCB0byBl
eHBsb3JlIG5ldyBtZXRob2Qgb3IgZWxzZQ0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiAtIElu
dHJvZHVjZSBjbGtfc2V0X3NwcmVhZF9zcGVjdHJ1bSB0byBzZXQgdGhlIHBhcmFtZXRlcnMgZm9y
IGVuYWJsaW5nDQo+ICAgc3ByZWFkIHNwZWN0cnVtIG9mIGEgY2xvY2suDQo+IC0gUGFyc2UgJ2Fz
c2lnbmVkLWNsb2NrLXNzY3MnIGFuZCBjb25maWd1cmUgaXQgYnkgZGVmYXVsdCBiZWZvcmUgdXNp
bmcgdGhlDQo+ICAgY2xvY2suIFRoZSBwdWxsIHJlcXVlc3QgZm9yIHRoaXMgcHJvcGVydHkgaXMg
YXQgWzFdDQo+ICAgVGhpcyBwcm9wZXJ0eSBpcyBwYXJzZWQgYmVmb3JlIHBhcnNpbmcgY2xvY2sg
cmF0ZS4NCj4gDQo+IC0gRW5hYmxlIHRoaXMgZmVhdHVyZSBmb3IgY2xrLXNjbWkgb24gaS5NWDk1
Lg0KPiAgIFRoaXMgbWF5IG5vdCB0aGUgYmVzdCwgc2luY2UgY2hlY2tpbmcgbWFjaGluZSBjb21w
YXRpYmxlcy4NCj4gICBJIGFtIHRoaW5raW5nIHRvIHByb3ZpZGUgYW4gQVBJIHNjbWlfZ2V0X3Zl
bmRvcl9pbmZvLCB0aGVuIGRyaXZlcg0KPiAgIGNvdWxkIHVzZSBpdCBmb3IgT0VNIHN0dWZmLCBz
dWNoIGFzDQo+ICAgaWYgKHNjbWlfZ2V0X3ZlbmRvcl9pbmZvIHJldHVybnMgTlhQX0lNWCkNCj4g
ICAgICAgb3BzLT5zZXRfc3ByZWFkX3NwZWN0cnVtID0gc2NtaV9jbGtfc2V0X3NwcmVhZF9zcGVj
dHJ1bTsNCj4gDQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vZGV2aWNldHJlZS1vcmcvZHQtc2No
ZW1hL3B1bGwvMTU0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gUmVuYW1lIHRvIGNsa19od19zZXRf
c3ByZWFkX3NwZWN0cnVtIGFuZCBub3QgZXhwb3J0IGl0IGFzDQo+IGNvbnN1bWVyIEFQSS4NCj4g
LSBGaXggZXJyb3IgaGFuZGxpbmcNCj4gLSBUaGUgZW5hYmxlIHBhcmFtZXRlciBpcyBzdGlsbCBr
ZXB0LCBiZWNhdXNlIDAlIGlzIHZhbGlkIHBlcg0KPiAgIGh0dHBzOi8vd3d3LnRpLmNvbS9saXQv
YW4vc2NhYTEwMy9zY2FhMTAzLnBkZj90cz0xNzM4NjY3MzA4OTAzDQo+ICAgaHR0cHM6Ly93d3cu
c3lub3BzeXMuY29tL2Jsb2dzL2NoaXAtZGVzaWduL3VuZGVyc3RhbmRpbmctcGNpZS0NCj4gc3By
ZWFkLXNwZWN0cnVtLWNsb2NraW5nLmh0bWwNCj4gLSBJbmNsdWRlIHRoZSBpLk1YIGNsayBwbGwx
NHh4IHdoaWNoIHdhcyBhbiBlZmZvcnQgdG8gZW5hYmxlIFNTQyBvbg0KPiBpLk1YOE1OIGZyb20g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMTE4MTI0MDQ0LjE1NzMwOC0xLQ0KPiBk
YXJpby5iaW5hY2NoaUBhbWFydWxhc29sdXRpb25zLmNvbS8NCj4gICBXaXRoIHRoaXMgcGF0Y2hz
ZXQsIHRoaW5ncyBjb3VsZCBiZSBzaW1wbGllZCBhIGxvdC4NCj4gLSBVcGRhdGUgdGhlIGNsay1z
Y21pIGV4dGNvbmZpZywgbWFya2VkIGFzIG5vdCBhcHBseSwgYmVjYXVzZSBzcGVjIG5vdA0KPiBz
ZXR0bGUgZG93bi4NCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1jbGsvMjAyNTAxMjQtY2xrLXNzYy12MS0wLQ0KPiAyZDM5ZjZiYWYyYWZAbnhwLmNvbS9ULyNt
Y2U5MjZlZjEwZDNkOWMxYzk2MGMyMTg2N2MyZjE1MDlmMQ0KPiBmODdjYjkNCj4gDQo+IC0tLQ0K
PiBQZW5nIEZhbiAoNCk6DQo+ICAgICAgIGNsazogSW50cm9kdWNlIGNsa19od19zZXRfc3ByZWFk
X3NwZWN0cnVtDQo+ICAgICAgIGNsazogY29uZjogU3VwcG9ydCBhc3NpZ25lZC1jbG9jay1zc2Nz
DQo+ICAgICAgIGNsazogaW14OiBwbGwxNHh4OiBzdXBwb3J0IHNwcmVhZCBzcGVjdHJ1bSBjbG9j
ayBnZW5lcmF0aW9uDQo+ICAgICAgIFtOT1QgQVBQTFldIGNsazogc2NtaTogU3VwcG9ydCBzcHJl
YWQgc3BlY3RydW0NCj4gDQo+ICBkcml2ZXJzL2Nsay9jbGstY29uZi5jICAgICAgICB8IDcwDQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMv
Y2xrL2Nsay1zY21pLmMgICAgICAgIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0N
Cj4gIGRyaXZlcnMvY2xrL2Nsay5jICAgICAgICAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysr
KysrDQo+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLXBsbDE0eHguYyB8IDY2DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvY2xrLXByb3Zp
ZGVyLmggIHwgMzIgKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvY2xrLmgg
ICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvc2NtaV9wcm90
b2NvbC5oIHwgIDYgKysrKw0KPiAgNyBmaWxlcyBjaGFuZ2VkLCAyNzUgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA0MGI4ZTkzZTE3YmZmNGE0ZTBj
YzEyOWUwNGY5ZmRmNWRhYTUzOTdlDQo+IGNoYW5nZS1pZDogMjAyNTAxMjQtY2xrLXNzYy1mM2Q3
MGZiNmNkMWMNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQoNCg==

