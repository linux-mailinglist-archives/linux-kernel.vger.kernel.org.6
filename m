Return-Path: <linux-kernel+bounces-402542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D149D9C28E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F129B210E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144BDDC5;
	Sat,  9 Nov 2024 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SO8Pdt+W"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9A4689;
	Sat,  9 Nov 2024 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112661; cv=fail; b=SkFwfF4LZU7dS/oYEmhu3jZn4Qb13xOOCDBkt5SRcN0M5l7ZlCcz48Z67bRFn020Y66SMPXAdPMQNSCDd9myNYpjCMqoE1EghGScmC4C2Siim9hLF80oZ93cb2B/yiF87V5ELEiscr6nDGVSu7WF8IWljP1YpWIfQtKrZtoBLPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112661; c=relaxed/simple;
	bh=ZbGwy9GFAkCukcC6v7P8notH9zg8hRfVB0YTMmRapYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H9uZip5e/Xh1cqBcmuwud1+ymCZlBgCB/EOB7HhhiLt/fy1tqA8Dr3+bKwyU3iWCc6LwH9Yd6/mS4oUYP6/wZhmjm1Q3IfqYb3tr/YOy6vxWGnOv2pqYCgrgsgtK6eeKPWOxirsI/D9p8ns56m5xklM2qRfwA6i5YllD7b0MgBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SO8Pdt+W; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK6QRhQCR51mS8AqfjaY99VYLhCL9qgrXG3s6NKDAY/5rbFp1jJ0MGu6qycuYPaOuCScV3HHTZpIX5uyWts4on7iBhxxCqHAu5GXO5E6QsYVRT3RtDXOXVnkS3iXkFTWL46fWOOclI6oOWhqXxJMxMwLVtVMbPRA1Td7mC/9kGQbmGZcPS5FbiRRHl313ltsdS6fCzdBLVMtmEAtVvz+nzfUndJrPF+85e1NNcnDeg+7rLLiCliMK3BzCWm3pu3G5rq3hHpTxzKYZmFjQRd0NVnFHZxeTF8v6KwkrUBUtUs8CwBfrEHhxawQPVDW4NBV56BS9fJ6q4QInUplzs5PUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbGwy9GFAkCukcC6v7P8notH9zg8hRfVB0YTMmRapYk=;
 b=niHAg9NNShaj9GGYgIzRyuIxZtasFKayw0GY3qDdcVOz6xwCDeP/sqaRdW2eurxGaBH2GFufxFIw1r+xgNAWWMwuDxhL/2zRP9IkJiiubnQlmbKP3C+JuM4VbcWiyiuyqIQYJH+RsOF/xn14X5pslXNCgv0nPzHX60lRIyzUoB6Aze7QJHpAtWbNJMydt6Xty5Gg/fhoZexySWqbIBsYO5mXwZbmTCOQVRZsSBkC0vI5BbvGTRsiG+uTlgK5x2z5d15inYkFAEuMbD96cxbv45UOhDRgZtqGC4Y9UTvIo/VrIzrUcBKBgDPa6QpMKJveD2U+ohcfq602Le+gl7dsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbGwy9GFAkCukcC6v7P8notH9zg8hRfVB0YTMmRapYk=;
 b=SO8Pdt+WWU4L9CL4aMUeVqkXySILyFEM7eyg3cjw0GL2+xrTsgNOt0oEs8UUn+9w6oSluO6yAkuggr33kcda2O73EhoTx4up6WnTDLmlaVE4Petz7uFdVE66rBJIfxVPUA/9AsDC6lgJp+UvX7gCGHTePjAZwABDsqT4AN9xBU2TEJAVfcglECF+/BE7payCgDZJd8hCt5cX/K02z4xIeXer97uAm1kUfJsWWR4s1OWKYamMiDSHJWZKOlLBCw46V5ciJTmEV1QBbsX7K5UHmmIFgaEkuixmsCxEmngTs48Z33HtKj2oT4Tm5r3T8FCaih/wWPe/sKCz77cOV8uutw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7931.eurprd04.prod.outlook.com (2603:10a6:10:1eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Sat, 9 Nov
 2024 00:37:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8137.018; Sat, 9 Nov 2024
 00:37:34 +0000
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
 AQHbMCsiGosLFeSwx0KHxJlfsPaJB7KqSvgAgAAA1oCAAZ6NgIABZEoAgAAIjrCAABiHAIAAqOUA
Date: Sat, 9 Nov 2024 00:37:34 +0000
Message-ID:
 <PAXPR04MB8459B6F8D5C623D19CCF6B39885E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241106090549.3684963-1-dario.binacchi@amarulasolutions.com>
 <20241106090549.3684963-2-dario.binacchi@amarulasolutions.com>
 <4bix7me5vaoyhcuffyp4btajmhy7no6ltczoesopaz2fqupyaw@fensx4nn472u>
 <b7c1499b-8337-421c-9734-6e518d678ff8@kernel.org>
 <CABGWkvrYJL9=zrPSFuEAgKO+9gDHD6RmCJM6Br6Le_eh578ETQ@mail.gmail.com>
 <54dd6ae6-b992-451e-b1c6-8a1968955f4a@kernel.org>
 <PAXPR04MB8459BE3474EFD4FCC28E0E82885D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <8c310eca-d695-418c-82cb-a89351d83887@kernel.org>
In-Reply-To: <8c310eca-d695-418c-82cb-a89351d83887@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7931:EE_
x-ms-office365-filtering-correlation-id: fd458346-9d81-452f-e6b1-08dd0056b432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUtFQlBSZ2tUNnUwOHRjajRKenVCV2NxUEV2YUd2MnVlNGpBQUJpRUZFWXRX?=
 =?utf-8?B?SmV2WWRmT0RQNkhoM0MwaWhiaXVhVzZ3N3F6RWNlOTJveFZ6M2dmTENQbFFj?=
 =?utf-8?B?T0hVenBMeHZUVGZORGJJL3o1aVhGcGZ2aUtISDI3RDAycFBoZXZOZGdqU0pD?=
 =?utf-8?B?ckhSTlpPZU5iMDRKeVN0Zlo1Ky9WMzNrN1VoOUowWmdKNUNrQ3FzLzBoQ01r?=
 =?utf-8?B?THhmQ0thdHZSNVNIOXJYMHpxNVdudVpadWlGaGg2ZWZYbVovU2laYUN5a2VW?=
 =?utf-8?B?dU82S2h6M1VlY0VaSWlIenVpQS9XMkR0VlVtQTh0eWk4MDcrS2xtQStTT2Rq?=
 =?utf-8?B?bjNzNzBSbWNESTBNcGRpNG9qVVowZkNSNStRTFlKTERXSTkycTF5Zndza0JP?=
 =?utf-8?B?NnROTS82cHQ2SlZJT2dwOHdaUll4eTh6WUw0M2JqOFVSRkhPdjZ0WmxBeUR2?=
 =?utf-8?B?Q3FIQWNyNXp0SUNzZkZiWU10NVdIYkhmUnNBbEhpT3IzMzJrTElwc0VlR2pF?=
 =?utf-8?B?Ni9XWWJTb1A2eC9ZNmp3RjVRQlorUjNxRDhhYTBpVnhwRTQra2ZnM0hQY2o5?=
 =?utf-8?B?T09nS3R3Rm5uNWQ0dTc3N0tJRVZ0dmN3dVJxaUNZOVFqNGtQVkdrcUhRTmw3?=
 =?utf-8?B?KzVJVy93YU51Z0dnVi9LTSszWW5CR1AvenZpZW9oMDBjSVhJbm9vT3kxK3JY?=
 =?utf-8?B?aFVmSXB4N01rNW9tNDgyOTlxSWhiZWNnUVVvT0xDdEluTkFoYmtuVWJHdldv?=
 =?utf-8?B?VzUrdkM0QzNHYkFyeEtJR0dnODJoUUMyY0xMSlBiRnpPZWtkaGF5WEw1M0g5?=
 =?utf-8?B?ci9GOGFQVkJXQ0Y2TEdEV1VSYW5BajNLMzIwVGNZVmNLZjA3YjF1YWZ0RXUv?=
 =?utf-8?B?OVJVL1VDS09nR0M2WklyV0VOZjErRFNiWHBETzd3dU9TRkhBY3ZPT09WWElx?=
 =?utf-8?B?WUU0c2VDdmhLUEVxK1YyT0R6OXhKRmVja0JuNCtJVUJVMThGL1k1c2dKMm5G?=
 =?utf-8?B?dUFEdXBqc2gxbW5NT3RtbERTc3pMWlVJSGhDR3lVYytpYVVaWUFHR1ZyaTlv?=
 =?utf-8?B?TWwzaXV2T0VqNHZ0ay9DcG5wTExxQU5odG1vK1dkRGxKNi9PWlJKYkdIcXhI?=
 =?utf-8?B?aGw4K0pORnNXSFMvTUYvNjVhdGtOR2toZ0sxRWs2RzU2ZkFHUWdGV3YxQlVn?=
 =?utf-8?B?d0MrM0ZsdGFab3RRMVJTN2dQZ0pJTUxrcUtERXB1cWpQZzBUV29Gd1hEK3BB?=
 =?utf-8?B?TDFZM3FJcGVVVm0xajdOeWM4a0NRMXlVRUM5U1JGZ2x4a1Q3ZjRGNG5EUTZI?=
 =?utf-8?B?T3ptWmVNNHRiUVI4Qzd0QWFsTlN1S2dTZWhicVJYNDVQTmtsdCtyNHFUR0I5?=
 =?utf-8?B?ckxmUTZNOVlhRkFZTU8rS0tvMjFFaSsxVTJUMzRoOGVFYjZXVVUxSlBkeWl3?=
 =?utf-8?B?Rm9IbzQ5Z3NBdnFrYVE0K1RsQ0FQaXg0Y0lkNFlMdWU4V3hrNmJqVjUrY3lQ?=
 =?utf-8?B?aTlhdktvbFF2VE95WG9QTTFyck9HMkUzK2JvRGVGdHJTblpmaWtDU0N5UEor?=
 =?utf-8?B?U2hVMGw4R3BEclROSkszYUdldy91dEpwU1dQRHZ0M3V6blMwWDNma2lIWW54?=
 =?utf-8?B?M2RmcEFaT0RUa2FpTU80Q05mU2J6Tk1yR1pjZXdCRGhKVGVMNk5PNWIxVEJK?=
 =?utf-8?B?MGM3a2lYNFM2YjAzYnhNZ0VudFdLYnFoc3h3aFhHVWE0cjZyVXptUFNBdkM4?=
 =?utf-8?B?ZWlxc0xDb3VRSlZDbFBKRWtObFNqVmwrS2NmcEp3NmI5Zi82RmtoNjlXMUdt?=
 =?utf-8?Q?FvG8TYb+gUCsUP2x0NOv7hI2otoavXHwVVwaA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjZ4OTJ0TmhtVmZxUEh4c01ETG5vVlhOSmdLcFVXcjR5Y3gzeEZXOXc1UHB5?=
 =?utf-8?B?Njcxb0VNK05lV2tmalpXSStZNy83c3J1T2I4WW9IV1NZQUl0T3Mvd0xsNjhG?=
 =?utf-8?B?bEk3bHg5U0NGTDdUOWNIeHBpL2cwN2tYaWRKcHdCNVY2ZFYyNC9WYTFWQWVw?=
 =?utf-8?B?MTRmQ0xzN2ZEbHdIQUpRMTArQkc3VGdsYXQ5YzRBKzdQTy9sVzRiazhJd05q?=
 =?utf-8?B?OVNibkhHM0piMjQyVnlCZ3h4RTEyWmZKaFJVT1RmUWFJWDRWdjVQMWtBU01R?=
 =?utf-8?B?ajIwWC9TOFpCMDExYzJySHJUU1czdEJJZzhTWU1hUlNpcWFBTXoyWndtMU1R?=
 =?utf-8?B?VUZmemxpTEUvZlNBVnAvUVhRMlY3RjRoWjlCVkQyRW5Rd1lZU016Q1JxbHNs?=
 =?utf-8?B?R2FjY2FNU0diSkkrdHdMUW1VTy9wMnRUT2lIR0Znc0hxUU9uOGpHU1IvYys1?=
 =?utf-8?B?T0h6TC8rckMvWjkzQVdYOWQvUmJYcmZDT3ljMTFjZzVzMENiZk5ya2xKdkRi?=
 =?utf-8?B?QjZ6cTBtd2hzdnpWKzFSenVNWStkSENLak85QW5BWTZvRDU4S0FOUXEvNVZJ?=
 =?utf-8?B?czVvLzFTb3IrcTUyaDRwNlI4TkY5NXh3UjVHeUtoSnVPUnJQNVBYV0pwSjJx?=
 =?utf-8?B?L0l5YWJmTTVYbnRaTWNBRWNwcisvTk9nL3A2bjJUNmppUnJVTmRXMGlpNjRR?=
 =?utf-8?B?MXZmNDZxNk8wQjkrRktSLzd3YjFGeHB5SmtLZVFiQlYwb2llVVpIMXNSV1B6?=
 =?utf-8?B?UzNnbFUvVkF4UE12UGJFdnUxWUt4R0ZXNDB6Tm1CZjI5TXpoaGhnbStrYUdx?=
 =?utf-8?B?YWt1bmFxc0QxMXdYU3IvalZuTW41R09vbjNZa0VMM210c1RrdkpONDZwWXVm?=
 =?utf-8?B?S01VVUtnT1ZYSENhTnY2bkFjYytoLzVqZm1jUlF4RTYwbHI4d0pIWTByU1Y1?=
 =?utf-8?B?K3ZNS2JtVXlVOXg2bnRUVHZjTTk5aWcxeEtPQ1o1VGxiZFB2aWcxVkNQbGlN?=
 =?utf-8?B?SDRrcWY5Y01nbTM4ZUZUYTZ0aTdiSWNVRXM4Mk13aFA5OXZBWVdqcmphaGYy?=
 =?utf-8?B?S0ZTNGNETmpjd1Y1MXFWcGhkMUNuenNxa1c3VUhFK2g4SllUVGhiNzJmSlY4?=
 =?utf-8?B?NVVvbEZ6Z0ZVd2I2dkF1ZldHWUQzbmdsd2FwakFpTUcrY1VPNU5selpzdklW?=
 =?utf-8?B?QmVKT1Rpanhmell0dERvblpiM1R3SnlqVWFickV2TXRhNzNzOHBmNE1VaUJm?=
 =?utf-8?B?R21Kcm5STFJNLzREOGRDSE5VU0FxRzZaZWNjNnBtakQwR2lvbjZCQnBUYXY4?=
 =?utf-8?B?N1JXNlBhMisvSnNhSlBSRU5qakxxdjQwaUQ1Z0pVclQ0VytjWWxlUWRDSE84?=
 =?utf-8?B?cGF1QXdGeGN5aU5LbThDajZFY1F4dEJtU1VzYWpvZU9KTXJVT2Z3RStaMFph?=
 =?utf-8?B?UUdkS2djZmJYUTJYRk85TjBCMjBpWWplUUM2VWtuekpJT2o4cy9HeHRjNTlL?=
 =?utf-8?B?UEI5Q1VtMzNwYTEvOHVrOTU4YUVmSUdkSStxbUVlMEhnNFhjQkdhaTdSems0?=
 =?utf-8?B?TmtJT0dWUlFFNmhWUUtzSS9DaTJjaHBvU3dINnE3VlhPTkdrVUJ6bVVvUHlx?=
 =?utf-8?B?QWdWeDJ1ZjVsd25HTEE4QVVKblJPUTUySlU3SGxGMjc2UHhqT29wdzA4VDJR?=
 =?utf-8?B?SWlQaUtWN0dHSmtHanNRbE5wRGVaVjl6Tmx2N3piam1WNmt6SkhFSW9iVm10?=
 =?utf-8?B?dDFDMHBTVlhVczlwN2U4c0ZBdFhwam5mdmF6UVVxSDF5TWhwVmtjL1pzM1RV?=
 =?utf-8?B?L2w2eWx0NGk4QlR1TjVuZVhTaHltQzQ0VmpUQ2JkUjBkREdVRjN2ZW1mWFlL?=
 =?utf-8?B?YitGZHNUbzkvckdFQnVwdlp1QjE3T0R3YmgxMldMUkhMQVhVdlFxVTRkWVVo?=
 =?utf-8?B?c3VSYVIvRVZTWmZuY1dHaVRJZkgyUWR6L05BcWt6b3YxUGVIcmM1TS9DK3ZB?=
 =?utf-8?B?ZmhwQTUySzl1OXlXVGtyaFEyd2kwVWhoWm41cXhpUFgxQ0pUYzRicFM4ZEth?=
 =?utf-8?B?WTcxUm9zVy95Vy9taFJzL3M5SkxyMmF5UEZVVUJnMWR4VUs4enVIMjNXU1ln?=
 =?utf-8?Q?fXns=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd458346-9d81-452f-e6b1-08dd0056b432
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 00:37:34.6680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mmLZGHj69TuyPImc0v+eqxRrrqwcLop8WrS4+XaE6uCc/2RunRwJyuT5j+8nb0wzxXujudGTrR/6jS4f79l1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7931

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvOF0gZHQtYmluZGluZ3M6IGNsb2NrOiBpbXg4bS1j
bG9jazogc3VwcG9ydA0KPiBzcHJlYWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gDQo+IE9uIDA4LzEx
LzIwMjQgMTM6NTAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDEvOF0gZHQtYmluZGluZ3M6IGNsb2NrOiBpbXg4bS1jbG9jazoNCj4gc3VwcG9ydA0KPiA+PiBz
cHJlYWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gPj4NCj4gPj4gT24gMDcvMTEvMjAyNCAxNTo1Nywg
RGFyaW8gQmluYWNjaGkgd3JvdGU6DQo+ID4+PiAgICAgY2xvY2tzID0gPCZvc2NfMzJrPiwgPCZv
c2NfMjRtPiwgPCZjbGtfZXh0MT4sIDwmY2xrX2V4dDI+LA0KPiA+Pj4gICAgICAgICAgICAgICAg
ICAgPCZjbGtfZXh0Mz4sIDwmY2xrX2V4dDQ+Ow0KPiA+Pj4gICAgIGNsb2NrLW5hbWVzID0gIm9z
Y18zMmsiLCAib3NjXzI0bSIsICJjbGtfZXh0MSIsICJjbGtfZXh0MiIsDQo+ID4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJjbGtfZXh0MyIsICJjbGtfZXh0NCI7DQo+ID4+PiAgICAg
YXNzaWduZWQtY2xvY2tzID0gPCZjbGsgSU1YOE1OX0NMS19BNTNfU1JDPiwNCj4gPj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU5fQ0xLX0E1M19DT1JFPiwN
Cj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JmNsayBJTVg4TU5fQ0xL
X05PQz4sDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZjbGsgSU1Y
OE1OX0NMS19BVURJT19BSEI+LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDwmY2xrIElNWDhNTl9DTEtfSVBHX0FVRElPX1JPT1Q+LA0KPiA+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTl9TWVNfUExMMz4sDQo+ID4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZjbGsgSU1YOE1OX0FVRElPX1BMTDE+LA0K
PiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTl9BVURJ
T19QTEwyPjsNCj4gPj4+ICAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1O
X1NZU19QTEwxXzgwME0+LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPCZjbGsgSU1YOE1OX0FSTV9QTExfT1VUPiwNCj4gPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmY2xrIElNWDhNTl9TWVNfUExMM19P
VVQ+LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
PCZjbGsgSU1YOE1OX1NZU19QTEwxXzgwME0+Ow0KPiA+Pj4gICAgIGFzc2lnbmVkLWNsb2NrLXJh
dGVzID0gPDA+LCA8MD4sIDwwPiwNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgPDQwMDAwMDAwMD4sDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDw0MDAwMDAwMDA+LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA8NjAwMDAwMDAwPiwNCj4gPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPDM5MzIxNjAwMD4sDQo+ID4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwzNjEyNjcyMDA+OyB9Ow0KPiA+Pj4NCj4gPj4+
IFRoZSBzcHJlYWQgc3BlY3RydW0gaXMgbm90IGNvbmZpZ3VyYWJsZSBvbiB0aGVzZSBjbG9ja3Mg
b3IsIG1vcmUNCj4gPj4+IGdlbmVyYWxseSwgbWF5IG5vdCBiZSBjb25maWd1cmFibGUgKG9ubHkg
NCBQTExzIGhhdmUgdGhpcw0KPiBjYXBhYmlsaXR5KS4NCj4gPj4+IFRoZXJlZm9yZSwgSSBuZWVk
IHRoZSAiZnNsLHNzYy1jbG9ja3MiDQo+ID4+DQo+ID4+IE5vLiBUaGF0J3Mgbm90IHRydWUuIFlv
dSBkbyBub3QgbmVlZCBpdC4NCj4gPj4NCj4gPg0KPiA+IGkuTVg4TSBjbG9jayBoYXJkd2FyZSBp
cyBzaW1pbGFyIGFzOg0KPiA+DQo+ID4gT1NDLT5BTkFUT1AtPkNDTQ0KPiA+DQo+ID4gQU5BVE9Q
IHdpbGwgcHJvZHVjZSBQTExzLg0KPiA+IENDTSB1c2UgUExMcyBhcyBpbnB1dCBzb3VyY2UuDQo+
ID4NCj4gPiBDdXJyZW50bHkgdGhlcmUgaXMgbm8gZGVkaWNhdGVkIEFOQVRPUCBkcml2ZXIgaW4g
bGludXguDQo+ID4gVGhlIENDTSBsaW51eCBkcml2ZXIgd2lsbCBwYXJzZSB0aGUgQU5BVE9QIG5v
ZGUgYW5kIHJlZ2lzdGVyIGNsa19odw0KPiA+IGZvciB0aGUgUExMcy4NCj4gDQo+IEkgZG8gbm90
IGtub3cgd2hhdCBpcyBDQ00gYW5kIGhvdyBkb2VzIGl0IGZpdCBoZXJlLiBXaGF0J3MgbW9yZSwg
SQ0KPiBkb24ndCBnZXQgZHJpdmVyIGNvbnRleHQgaGVyZS4gV2UgdGFsayBhYm91dCBiaW5kaW5n
cy4NCg0KDQpDQ006IENsb2NrIENvbnRyb2wgTW9kdWxlLCBpdCBhY2NlcHRzIFBMTCBmcm9tIGFu
YXRvcCBhcyBpbnB1dHMsDQphbmQgb3V0cHV0cyBjbG9ja3MgdG8gdmFyaW91cyBtb2R1bGVzLCBJ
MkMsIENBTiwgTkVULCBTQUkgYW5kIC4uLg0KDQo+IA0KPiANCj4gPg0KPiA+DQo+ID4+IEZpcnN0
LCB0aGUgY2xvY2sgaW5wdXRzIGZvciB0aGlzIGRldmljZSBhcmUgbGlzdGVkIGluIGNsb2NrcyAq
b25seSouDQo+ID4+IFdoYXQgaXMgbm8gdGhlcmUsIGlzIG5vdCBhbiBpbnB1dCB0byB0aGUgZGV2
aWNlLiBJbmNsdWRpbmcgYWxzbyBMaW51eA0KPiA+PiBhc3BlY3QgKG1pc3NpbmcgZGV2bGlua3Mg
ZXRjKS4gVGhlcmVmb3JlIGhvdyBjYW4geW91IGNvbmZpZ3VyZQ0KPiBzcHJlYWQNCj4gPj4gc3Bl
Y3RydW0gb24gY2xvY2tzIHdoaWNoIGFyZSBub3QgY29ubmVjdGVkIHRvIHRoaXMgZGV2aWNlPw0K
PiA+DQo+ID4gSSBub3QgdW5kZXJzdGFuZCB0aGlzIHdlbGwsIHlvdSBtZWFuDQo+ID4gYWRkIGNs
b2NrcyA9IDx4eCBDTEtfSU1YOE1NX1ZJREVPX1BMTD4gaW4gdGhlIGNjbSBkdGIgbm9kZT8NCj4g
DQo+IFllcy4gTGV0IG1lIHJlLWl0ZXJhdGUgYW5kIHBsZWFzZSByZXNwb25kIHRvIHRoaXMgZXhh
Y3RseSBjb21tZW50DQo+IGluc3RlYWQgb2YgaWdub3JpbmcgaXQuDQo+IA0KPiBIb3cgYSBkZXZp
Y2UgY2FuIGNhcmUgYWJvdXQgc3ByZWFkIHNwZWN0cnVtIG9mIGEgY2xvY2sgd2hpY2ggaXMgbm90
DQo+IHN1cHBsaWVkIHRvIHRoaXMgZGV2aWNlPw0KDQpJIGhvcGUgd2UgYXJlIG9uIHNhbWUgcGFn
ZSBvZiB3aGF0IHNwcmVhZCBzcGVjdHJ1bSBtZWFucy4NCnNwcmVhZCBzcGVjdHJ1bSBvZiBhIGNs
b2NrIGlzIHRoZSBjbG9jayBjb3VsZCBwcm9kdWNlIGZyZXEgaW4gYSByYW5nZSwNCnNheWluZyBb
NTAwTUh6IC0gMTAwS0h6LCA1MDBNSHogKyAxMDBLSHpdLiBzb2Z0d2FyZSBvbmx5IG5lZWQNCnRv
IGNvbmZpZ3VyZSB0aGUgbWlkZGxlIGZyZXF1ZW5jeSBhbmQgY2hvb3NlIHRoZSB1cC9kb3duIGJv
cmRlcg0KcmFuZ2UoMTAwS0h6IGhlcmUpIGFuZCBlbmFibGUgc3ByZWFkIHNwZWN0cnVtLiANCg0K
ZGV2aWNlOiBJIHN1cHBvc2UgeW91IG1lYW4gdGhlIENsb2NrIENvbnRyb2wgTW9kdWxlKENDTSkg
aGVyZS4NCkNDTSBkb2VzIG5vdCBjYXJlLCBpdCBqdXN0IGFjY2VwdHMgdGhlIFBMTCBhcyBpbnB1
dCwgYW5kIG91dHB1dA0KZGl2aWRlZCBjbG9jayB0byB2YXJpb3VzIElQcyhWaWRlbyBoZXJlKS4g
VGhlIHZpZGVvIElQcyBjYXJlIGFib3V0DQp0aGUgc3ByZWFkIHNwZWN0cnVtIG9mIHRoZSBjbG9j
ay4NCg0KVGhlIGNsb2NrIGhhcmR3YXJlIHBhdGggaXMgYXMgYmVsb3c6DQoNCk9TQygyNE0pIC0t
PiBBbmF0b3AocHJvZHVjZSBQTEwgd2l0aCBzcHJlYWQgc3BlY3RydW0pIC0+DQpDbG9jayBDb250
cm9sIE1vZHVsZShvdXRwdXQgY2xvY2sgdG8gbW9kdWxlcykgLT4gVmlkZW8gSVANCg0KRnJvbSBo
YXJkd2FyZSBwZXJzcGVjdGl2ZSwgQ2xvY2sgQ29udHJvbCBNb2R1bGUgZG9lcyBub3QNCmNhcmUg
c3ByZWFkIHNwZWN0cnVtLiBWaWRlbyBJUCBjYXJlcyBzcHJlYWQgc3BlY3RydW0uDQoNCg0KPiAN
Cj4gV2h5IHdvdWxkIHlvdSBjYXJlIGFib3V0IHNwcmVhZCBzcGVjdHJ1bSBvZiBzb21lIGNsb2Nr
IHdoaWNoIGlzIG5vdA0KPiBjb21pbmcgdG8gdGhpcyBkZXZpY2U/DQoNCmRldmljZSwgSSBzdXBw
b3NlIHlvdSBtZWFuIGNsb2NrIGNvbnRyb2wgbW9kdWxlKENDTSkuIA0KDQpUaGVyZSBpcyBubyAn
Y2xvY2tzID0gPCZjY20gQ0xLX0lNWDhNX1ZJREVPX1BMTD4nIHVuZGVyIGNjbSBub2RlLg0KQmVj
YXVzZSBpbiBjdXJyZW50IGRlc2lnbiwgY2NtIGlzIHRha2VuIGFzIHByb2R1Y2VyIG9mDQpDTEtf
SU1YOE1fVklERU9fUExMLCBub3QgY29uc3VtZXIuIA0KDQo+IA0KPiBQbGVhc2UgYWRkcmVzcyB0
aGVzZSBwcmVjaXNlbHkgYmVjYXVzZSB3ZSB0YWxrIGFib3V0IHRoaXMgZm9yIHdlZWtzIGluDQo+
IG11bHRpcGxlIHBsYWNlcy4gDQoNClNvcnJ5IGZvciBjb21pbmcgaW50byB0aGlzIGZlYXR1cmUg
aW4gbGF0ZSBzdGFnZS4NCg0KRGFyaW8sIHRoYW5rcyBmb3Igd29ya2luZyBvbiBzdWNoIGZlYXR1
cmUsIGdvb2QgdG8gc2VlLiBTcHJlYWQgU3BlY3RydW0NCmlzIGluZGVlZCBnb29kIGZlYXR1cmUg
d2hhdCBtYWtlcyBjbG9jayBxdWFsaXR5IGhpZ2guDQoNClRoYW5rcywNClBlbmcuDQoNCkkgZmlu
aXNoIHdpdGggdGhpcyBwYXRjaHNldCBpZiB5b3UgZG8gbm90IHByb3ZpZGUgc3VjaA0KPiBjb250
ZXh0Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

