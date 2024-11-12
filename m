Return-Path: <linux-kernel+bounces-405184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 233799C4E04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B011F22970
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E582208964;
	Tue, 12 Nov 2024 05:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="a+o7fpcZ"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2092.outbound.protection.outlook.com [40.107.22.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF311990AB;
	Tue, 12 Nov 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387844; cv=fail; b=MwrP3qb7KCOO6xbskahYmdy0XneB1jJQUUPEVM+mhdUdJuVWn0LQEW6fq14nD2gxcoyzak/6q5D9nQZSybTgmVGRlDNKf76KOUa0vq750XULgQRZ7sZRF+9HA9OUaaXLpReOKmecmv/78PbU6yMji8to9tLzjc9RARAust2GsUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387844; c=relaxed/simple;
	bh=pOYYFkEtvd71wjB03hxUmC6xyWlYZmWgM5xSa6PAyE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Urtx2MFgIFq7dF8+bpN2HDFCJWT7pp727MnX0ftv02Zb5hj2tWQeUeHC1TwhHi8xsOmJm+fgsTNIwc/9u+jbRYz8vQiRCk1u+4izzATC4XA2GtMeWg1MjgQvYyaEKJpQXN2xCqnbHsd+RDQGTtbD/HygbCpld2zIcOWQYiBOSng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=a+o7fpcZ; arc=fail smtp.client-ip=40.107.22.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdvmkWoiCJGbdgsEsSK6/uLb9bDd3Oz0nq1DToR7USyh2u5i9jOWrMFnGZxY2PUCj6K18QERR5c2T0qdkmPCV52s/3GzdXjRPsZX1c9rboxxpvw+pkw9Cn3jGJ2k3dcF9J3HDMA3fDiLiLUT0RjzkTasA33ExVF3xS6vQujBrJdr42FpYCqwi4SF+7U0KgZmlw6yK+2xQ+t9nSxuj8FPZwOuBDV7CbIXbRlHxfvms0UWXy2GyQwRCQpwrdGXyijutgJ+Bf6aD3C5y9zn4Qh7bsJPyg2wxm8dRaDHtg+wy4p3TueNWBBSTZ5NtvtZGTzIQpUGCz32Ty867+E9nnRDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOYYFkEtvd71wjB03hxUmC6xyWlYZmWgM5xSa6PAyE8=;
 b=Gqsefh6bh6164JM9ZTnk6oFFaqbSe+iDV0f/4jWKchTUz5vzt8uEZzeCPxqG0eZkZRIVb3aLfmJL7wsAR6TsV7o9gBGQ3j5d23I7JuZnUKEIMCIg1mWDpnDPEnstCVUOTeqiERmh/Y+FjYRQe8oGnYx81J6edH7kOI1aBLFNhNro+XcSwv/BnlWyXOcGjShJqi9U6aS+Aw2rleqdVxwUYAS8nAgB+ktcdYH9S2yLEq5U7J/p7ElH1o+rVn0RD/MLRe1OKOPPEk3UrkquaStWGcFSq5/XZYnzcNxeuVtqwzmfO5kHMkvArKnv2fixSmsa6A3SrAYUwFJzQvAp5iSx8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOYYFkEtvd71wjB03hxUmC6xyWlYZmWgM5xSa6PAyE8=;
 b=a+o7fpcZVlTjVTFWiRO6Jq8M4nGISyWcn+2wPtWAY3KTy4ILjZFzNl1rh++QKIVEJIuTR/UmxDBQFFl/hYkLiwKbo6zZtjaRfsKbP7P2OFEg04lCEHMft7EK1VnhhxKqNpL3LcjMNLeEU92qYt9R2Xf+EXjZVWo0dmaEGNDgg5E=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8096.eurprd04.prod.outlook.com (2603:10a6:102:1c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 05:03:58 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 05:03:58 +0000
From: Josua Mayer <josua@solid-run.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Thread-Topic: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Thread-Index:
 AQHaY0TXqy6m6Bv0g0KsvKUkI3O0eLKZBSkAgATRLQCAAB5UgIAAF7UAgAK4roCACBiPAIAL3GiA
Date: Tue, 12 Nov 2024 05:03:58 +0000
Message-ID: <520ea6d3-d0b2-46c2-bc61-1d5cb4bd54f2@solid-run.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
 <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
 <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com>
 <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
 <cd02e760-54c6-4a92-af4e-e786d80cfbbd@ti.com>
 <533c54e5-d024-4fd0-b92d-0f320f25999f@solid-run.com>
 <CAMuHMdWY0J7uooeRbUGwjkeCLd2UVyN9dtDWUkg5pJ3sAULdsQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWY0J7uooeRbUGwjkeCLd2UVyN9dtDWUkg5pJ3sAULdsQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAXPR04MB8096:EE_
x-ms-office365-filtering-correlation-id: 2ba734fb-32fa-4bcc-d76c-08dd02d76a6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bm52UGllbWhndG4zSjlvYy9XMUY3MnB1VUd1aE5uaDdPTmc1eWxPTFZmcXR4?=
 =?utf-8?B?UzVFclorS2JWU2ZJaVBFeW45bStkT2hyM3huM1hpd1RFTk9PajIwUC9HMnBq?=
 =?utf-8?B?L2pBcWRJM0JsOFpYSzN1RU1tWTk2YmlJWC9vVzFqSktsYUU2dTA2NVdhcjV4?=
 =?utf-8?B?TUhPTm0vT2xUazhSYTJZSERFd1BxMkFTWCtsYlB6T0hvMzR6UG1JT0d2M21s?=
 =?utf-8?B?WXNkVDFMeXE5ck0zN01VSHE4NTRjTTdpcG4wUW16c2NHcU1KRVRDZ2VUU0py?=
 =?utf-8?B?QXdJZXk1TmhsdFhKcmtpVi9BYVpYVnRNTm1mQjU2Z2Mvd2RPVi9PcmVDMmZx?=
 =?utf-8?B?cVByZnV1N1NoWTNUbVhUMzFwT0JTRnlMd0JudnA3eDlQQUFXSmc3RmFEdkNo?=
 =?utf-8?B?L05SaFMvendhWFlyTlRFMzdkMmFNMncrd09mTDhxOEppT2xYRlRFbC9qR1dJ?=
 =?utf-8?B?dHliSWtGZ2E1UHdGMUZWNEhzZzFiajdqOEE1WFFHOE9aMU1LcVBuOTRSTWs3?=
 =?utf-8?B?ejJkZmVVTjFNTW9MYk5OVVQ4Tkpmb2Z3TnVvWkdWRjl1TVNIR2xPNWZsdEVQ?=
 =?utf-8?B?KzlBT2UzZ1hDM0dOYzlkK1JLOEd6Zy9Zb0orTmx0dFI0Skp0YWREaUZEa2d5?=
 =?utf-8?B?Y2tVMGliUjY5cmx1c21IRVF1UGM3Z056Q3FScFkrNkJudnFGaTBCVkpVOG9T?=
 =?utf-8?B?amJtK2JiZTVkS0FMVHJSNVFqeHhDRllwTjlyMlg4Y1dWMkkrZEFKYnhCVUZs?=
 =?utf-8?B?OGlKUkIrZGhqUVdOdmNXM09Oa3JEMXQ2NmFmYmNubXVKRnlaZTQ2b3NhelJ0?=
 =?utf-8?B?MWJ1cGYrR003MzVKQWVMQWJQQlk5NnU0a09xOStETjFMdkxXTFArSVJqRk5I?=
 =?utf-8?B?eFBWL0l6cDY5SmZZa0k4VGM2c3BYUENla3ZTNStlbnVpWnB3MG1kbk0zRFZN?=
 =?utf-8?B?amV5OE9DSUZ0WXdpVkxJeXdrNXdUZDk0SVR4azJ3cUEvVDcxTWozd3Y1UkFX?=
 =?utf-8?B?V2xzVWk2ZlNYcWdlRDA5VEg3cHU5UlBOcEErYXhqclZUQUtncU5UVmFXUEsy?=
 =?utf-8?B?OTlYaHJ0Y0MrWS82VGZqYXZ1LzdKOUR1R3NwbmNOb1BiMEJIdVpERDVjdUZ5?=
 =?utf-8?B?em9FTkwzMFRBN0kzeFlsZ0NHNnFobDJZTEk5VHVCTVRjVEltK1ExeG9VWTJF?=
 =?utf-8?B?TEx1aFZiTUMxUC9JOXBpQUUxQ1UvMFRROVdNOUFxVE1WY0RRd2RVeTRsY2ta?=
 =?utf-8?B?MXY5WE9qNnRFdi9LbC9iQk9HZjc0V2dKWkJ5ZnJZTEVFNHplaXdmNUVKbGtw?=
 =?utf-8?B?Y0xDOWlUTEJUMkdjZUlmcHBJNTR0RVZrZ2NCRUR4djRxOEtMa2lxdWxJazE5?=
 =?utf-8?B?K3ZaaWJ2ZmVXTFNZUEd3aGxaUWM5WHlHQWsrTEQxM3g5WDN2RjA0UGNQNVk3?=
 =?utf-8?B?UlRXdE5nL2xKZFExd2dwZDh1NzRnQVFTbUdaQU05dFZnek5pdDNsSmV6ODR2?=
 =?utf-8?B?Y09WdUlydVJQK0V6NVdISzIzVXVHTlFuRVEvMjNET05ISnNqTkVDc0R0TENQ?=
 =?utf-8?B?Q1dndEt1ODFhdTFvcDEyV3JtSDI3MDlpWVpTZ21MWnRyNmt3czFpSUllZUFh?=
 =?utf-8?B?T3kxTnFrdnRueVdWZWF2dUx0Yndha20wcXQyYW5rZ3BtTDA4S0MzVnA0SUFa?=
 =?utf-8?B?YTdaUjAySHEzanBKZHhOWndqcWh0MTJ6bE14dGxMRVlxeXBUNHZObDk3SHY5?=
 =?utf-8?B?bVhxVXc5WVBOUG10cVZHRXEyMU0xbUxTcWZOUGF5dEhQMUNhcDBBSUxJYlBR?=
 =?utf-8?B?a2RndlcrYi94eUphZU0yNFFmSk92RXlwZW56d2xuTjQycDlnYW1LOW5zZ3Z5?=
 =?utf-8?Q?4v9cgv6O6S42/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0FBZHNxTTUvUG9lVWl5UXYrSXZGR1ZwbWEvZU1FTnpnc29IdVQydllqUXM0?=
 =?utf-8?B?ZVIra1dNdEpYYk8rczNnNStmTjd3NVJUcjk1V045VEJHa1pyZUlsbFEvNWhW?=
 =?utf-8?B?Y2MvUm9CNVZoMEliYXVNYTZ4LzJVcUZ6RjZ6aC83MndFZHJsS3dZT2xrNG9H?=
 =?utf-8?B?RWJmY01IamoyQmc2dlY0RnZKVW9SSjRtb3dUbHVOMFJnT0NGM3NrSFp4dThQ?=
 =?utf-8?B?V0Zkc2E2WDRCTm1kZ0hLVStXS1E0dDZ0V0Vlbm1NbmFCaFBSdVVpc1N4UDJj?=
 =?utf-8?B?RGlRWVE2dzNRZ0J1ZUhKVzhOVitEZnhkZGxLQmU1OUF6YWtsVG41R3p5VFNq?=
 =?utf-8?B?cmVVbWJUNkREaEcvdGpjalE2ZjlvRVEwRjFLQXlGZWI1M1I4bzlyWjdRS055?=
 =?utf-8?B?emgxdHg3dnJSa1ZDN0pRVDVjMDI1OEM2UW0zeTM5cGl1R1NCUXVETUtnMFpW?=
 =?utf-8?B?ZlA1aTFSVDRERTQwZ1JIQXF0dVYrUmtNOGpNR295Z21hVlBEelovT2h3RlEz?=
 =?utf-8?B?WWNZZUU3NC9mdityRmV2T2pNeUc2YW1jem1SSVp5ZU5SblhSK3lYVmtMYjZv?=
 =?utf-8?B?R3g4RzEzNmNEeVlVN3daU0NYWlIzakY1U2pPbTJLbi9kaWdXTktSR2JqS1d6?=
 =?utf-8?B?ZnV1ZmhBYU14S04xUlFKK1lDVjdMUjRYMFJMalNGa3IyZXcyNXlJa09kNUhy?=
 =?utf-8?B?Y2lBdEJEc3ZWR241QlBNeThYVWUyTUZnbE4xNVh4MUxucU9nbDMwUlhmT0tl?=
 =?utf-8?B?MHMyS0IybGhDNDVDNVdURXc2djAzeEZsQnd2ejdENUNWM2R4bmRVV3kvayth?=
 =?utf-8?B?K0Y4dW1WdktnK2htNEVFOS9OSXdjM2x2T1NBdHFxN2U3ZlJsQnJLSm5OZTlp?=
 =?utf-8?B?em05bDh2eHZPK1JNMmtUMkk1V3V6V2Q1Ynp3OHlhVzg1KzBpZ1FudmlSNSsz?=
 =?utf-8?B?cDhidlI0b00rVm0xTXJtbkZWaEZzVkZ5WEo0K2h1OXdaWTIxK3RDemlIKzMx?=
 =?utf-8?B?ZHR1UWFVSXhCY0dzNTlEaUppTWZ6VjMvRGNjZU5IL1FMUTlVMWcxdlJpMXNW?=
 =?utf-8?B?bS9jVVAvQ3hidzJIRDl4aVh6YWRBKy8yQWVMd0JpbmRJTjR4WGc0N1hwdWxX?=
 =?utf-8?B?bVM3TFF6eGZpWmZPVml2d2dzM2VKUGpxV1R6UWRIUVJONjVJd3psS2NZOG5Z?=
 =?utf-8?B?WEsrMGU4ekNTTmdMZEYvT0VVTFA0UTloRW9CRHVEaHFzUVZkTVdXWW1RQlpO?=
 =?utf-8?B?ZUlQUlVXV1VjS0RlbUJ0QytaMlRoNTh5QTVLVTQyMVRYVUttZjIvVTZBQXRE?=
 =?utf-8?B?cEFLaS81SEpNbmJvcENpSURkZGVNdmhydkJMWWJRYWVIZlJnNWpTeWZtRVcy?=
 =?utf-8?B?UUhDcTFDVlA4SmdySjBidHJ0S3J3UklCL04yNTdSNFlRbVI2NnF2ZWhLYnpU?=
 =?utf-8?B?K0hnQnZwMkhlMDE0QjcwRnFmVzYrYm1PUnVYczg1QWpBOXZhSS9JUFN0NjVm?=
 =?utf-8?B?cUMwWm9zQmFLZyttaWd1Q2hvQ2cyd3ZzS09lTE1kbzFaT3ljUFQyZ0NjbzV6?=
 =?utf-8?B?bmhJYk13dUVHc3cxUTZvejRpWWJ3cW1YZjNHaVBIQXVNWldDcUNmTFpFNkpn?=
 =?utf-8?B?L2RTWWR0b0tnYlp1aU5PSUcvTmtnT3JuSENNVUVBVGYzbldJZGxlQm1pckJs?=
 =?utf-8?B?enRLdHlNUHpxT2FJRVBFdHhBYThkZWc0bFFyNjA0clhOTy9rOFNJNlErRGFz?=
 =?utf-8?B?cyswalZSUzJWZzUzdGhEYm1SMHlETmwyak1hL0YyeCsyaW52M0xkQTdkWjBE?=
 =?utf-8?B?cDA5ZFVFYUpmWGdoTlVNS3VVendOcGFGd1lUeWIxanJnRnM1eklBZjgycjVq?=
 =?utf-8?B?bzdGY2o5VDdzOExuZzIrK0cvZ3F5RS9wLzFmQkwrOU84NUdrR1FvMlBWZTNl?=
 =?utf-8?B?Tys1Q2doeFdMNTIvaVVPbnFja2NXakNXZ3JXS05aMkZjd2RBdGxjKzQrRWtG?=
 =?utf-8?B?REdDbExhdTZjMmVDSFB0b1hsbkRJNmZud3VPeXZDL2NuUjE3WW1QUnlqb3Nt?=
 =?utf-8?B?WUxBdW5Lenl0VkdNeC9qa21nU2t0Z0JLZnpkZzhvRE5PSUM4RGcrNy9zYmVZ?=
 =?utf-8?Q?6lDu6akrztxmbzbyJsA3FDYV1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B8B93F5C3FDA742A22D7E2A16170FE4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba734fb-32fa-4bcc-d76c-08dd02d76a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 05:03:58.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9W4Lwp/8prURHEQQJDmhsujdbn2gJOylpQYYqcHQrATStRhfZ9fx0TXP6EUBw+m1XafPRMAtjkVLJwUvDv2Lhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8096

SGkgR2VlcnQsDQoNCkFtIDA0LjExLjI0IHVtIDE3OjU2IHNjaHJpZWIgR2VlcnQgVXl0dGVyaG9l
dmVuOg0KPiBIaSBKb3N1YSwNCj4NCj4gT24gV2VkLCBPY3QgMzAsIDIwMjQgYXQgMToxOOKAr1BN
IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPiB3cm90ZToNCj4+IEFtIDI4LjEwLjI0
IHVtIDE5OjQ0IHNjaHJpZWIgVmlnbmVzaCBSYWdoYXZlbmRyYToNCj4+PiBPbiAyOC8xMC8yNCAy
Mjo0OSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+Pj4+IEFtIDI4LjEwLjI0IHVtIDE2OjMxIHNjaHJp
ZWIgVmlnbmVzaCBSYWdoYXZlbmRyYToNCj4+Pj4+IE9uIDI1LzEwLzI0IDE5OjI3LCBHZWVydCBV
eXR0ZXJob2V2ZW4gd3JvdGU6DQo+Pj4+Pj4gT24gTW9uLCBGZWIgMTksIDIwMjQgYXQgNDowNeKA
r1BNIEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPiB3cm90ZToNCj4+Pj4+Pj4gSHVt
bWluZ0JvYXJkLVQgZmVhdHVyZXMgdHdvIE0uMiBjb25uZWN0b3JzIGxhYmVsZWQgIk0xIiBhbmQg
Ik0yIi4NCj4+Pj4+Pj4gVGhlIHNpbmdsZSBTZXJEZXMgbGFuZSBvZiB0aGUgU29DIGNhbiBiZSBy
b3V0ZWQgdG8gZWl0aGVyIE0xIHBjaS1lDQo+Pj4+Pj4+IHNpZ25hbHMsIG9yIE0yIHVzYi0zIHNp
Z25hbHMgYnkgYSBncGlvLWNvbnRyb2xsZWQgbXV4Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBBZGQgb3Zl
cmxheXMgZm9yIGVhY2ggY29uZmlndXJhdGlvbi4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4+Pj4+IC0tLSAvZGV2
L251bGwNCj4+Pj4+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1odW1t
aW5nYm9hcmQtdC11c2IzLmR0c28NCj4+Pj4+Pj4gKyZ1c2JzczAgew0KPj4+Pj4+PiArICAgICAg
IC9kZWxldGUtcHJvcGVydHkvIHRpLHVzYjItb25seTsNCj4+Pj4+PiAvZGVsZXRlLXByb3BlcnR5
LyAoYW5kIC9kZWxldGUtbm9kZS8pIHRvIGRlbGV0ZSBzb21ldGhpbmcgaW4gdGhlIGJhc2UgRFRT
DQo+Pj4+Pj4gZG9lcyBub3Qgd29yay4NCj4+Pj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGZs
YWdzIGFyZSBlcXVpdmFsZW50IHRvIGJvb2xlYW4sIGkuZToNCj4+Pj4NCj4+Pj4gdGksdXNiMi1v
bmx5ID0gPHRydWU+Ow0KPj4+PiB0aSx1c2IyLW9ubHk7DQo+Pj4+DQo+Pj4+IGFyZSBlcXVpdmFs
ZW50Lg0KPj4+Pg0KPj4+PiBJZiBzbywgY2FuIHdlIGFzc2lnbiA8ZmFsc2U+IHdpdGhpbiB0aGUg
b3ZlcmxheT8NCj4+IElzIHRoZXJlIGFueSBjaGFuY2Ugb2YgcmVhc3NpZ25pbmcgPGZhbHNlPiBh
bmQgbWFraW5nIGFuIGFyZ3VtZW50DQo+PiB0aGF0IHRoaXMgc2hvdWxkIGJlIGZpeGVkPw0KPiBJ
biB0aGVvcnksIGl0IGNhbiBiZSBkb25lLCBpZiAoMSkgYWxsIGNvZGUgdGhhdCBjaGVja3MgYm9v
bGVhbg0KPiBwcm9wZXJ0aWVzIHdvdWxkIHVzZSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woKSBpbnN0
ZWFkIG9mDQo+IG9mX3Byb3BlcnR5X3ByZXNlbnQoKSwgYW5kICgyKSBvZl9wcm9wZXJ0eV9yZWFk
X2Jvb2woKSB3b3VsZCBiZSBjaGFuZ2VkDQo+IHRvIGFjdHVhbGx5IHJlYWQgdGhlIGJvb2xlYW4g
dmFsdWUgaW5zdGVhZCBvZiBqdXN0IGNoZWNraW5nIGZvciB0aGUNCj4gcHJlc2VuY2Ugb2YgdGhl
IHByb3BlcnR5LiAgQW5kIG9mIGNvdXJzZSB3ZSBoYXZlIHRvIGRvIHRoYXQgaW4gYWxsDQo+IHNv
ZnR3YXJlIHRoYXQgdXNlcyBEVCAoaS5lLiBub3QganVzdCBMaW51eCkuDQo+IFNlZSBbMV1bMl1b
M10gYmVsb3cgZm9yIGNhdmVhdHMuDQpUaGFuayB5b3UgZm9yIGFsbCB0aG9zZSBwb2ludGVycyEN
Cj4NCj4gVXNpbmcgYSBzaW1pbGFyIHNvbHV0aW9uIGZvciAvZGVsZXRlLW5vZGUvIGlzIG1vcmUg
Y29tcGxleCwgYnV0IHN0aWxsDQo+IGZlYXNpYmxlLCBieSBzZXR0aW5nIGl0cyAic3RhdHVzIiBw
cm9wZXJ0eSB0byAiZGlzYWJsZWQiIC4gSSB0aGluaw0KPiB0aGF0IGNhbiBiZSBtYWRlIHRvIHdv
cmsgaWYgYWxsIERUIGNvcmUgY29kZSB0aGF0IGxvb2tzIHVwIG5vZGVzIHdvdWxkDQo+IGp1c3Qg
aWdub3JlIGFueSBub2RlIHRoYXQgaGFzIGEgZGlzYWJsZWQgc3RhdHVzLg0KQWdyZWVkIQ0KPiBJ
LmUuIGNhbGxlcnMgd291bGQNCj4gbm8gbG9uZ2VyIHNlZSBkaXNhYmxlZCBub2RlcyBhdCBhbGwu
DQo+DQo+PiBJIGZpbmQgaXQgZnJ1c3RyYXRpbmcgdGhhdCBvdmVybGF5cyBjYW4ndCBvdmVycmlk
ZSBib29sZWFuIHByb3BlcnRpZXMsDQo+PiBhbmQgZm9yIGNvbnNpc3RlbmN5IHJlYXNvbnMgSSB3
b3VsZCBvdGhlcndpc2UgY2hhbmdlIGJvdGgNCj4+IHBjaWUgYW5kIHVzYjMgb3ZlcmxheXMgdG8g
c3RhbmRhbG9uZSBkdHMuDQo+IE9LLg0KDQpTZXR0aW5nIGEgcHJvcGVydHkgPSAiZmFsc2UiIHdv
dWxkIGJlIHF1aXRlIHByZWZlcmVudGlhbCBpbiBteSBvcGluaW9uLA0Kb3ZlciBkcm9wcGluZyB0
aGUgb3ZlcmxheXMuDQoNClVuZm9ydHVuYXRlbHkgSSBhbSBwcmVvY2N1cGllZCwgYW5kIGNhbid0
IHN1Ym1pdCB0ZXN0ZWQgcGF0Y2hlcw0Kd2l0aGluIGN1cnJlbnQgbWVyZ2Ugd2luZG93Lg0KDQpJ
IHdpbGwgZHJhZnQgYSBtaW5pbWFsIHVudGVzdGVkIHBhdGNoLCBhbmQgc3VibWl0IGl0IHRvIHRo
ZSBsaXN0LA0KdG8gZ2V0IHNvbWUgY29tbWVudHMuDQpGb3IgbmV4dCB3aW5kb3cgSSBjb3VsZCBw
cmVwYXJlIGEgdGVzdGVkIHZlcnNpb24uDQoNCj4NCj4gWzFdIFRoZSBleGFtcGxlIGluIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9ydDU2NTEudHh0IGhhczoNCj4NCj4g
ICAgICAgICAgcmVhbHRlayxkbWljLWVuID0gInRydWUiOw0KPiAgICAgICAgICByZWFsdGVrLGlu
Mi1kaWZmID0gImZhbHNlIjsNCj4NCj4gICAgICBPYnZpb3VzbHkgdGhlIHNlY29uZCBsaW5lIGRv
ZXNuJ3QgcmVhbGx5IHdvcmsgd2l0aCB0aGUgY3VycmVudA0KPiAgICAgIGNvZGUsIGJ1dCBmb3J0
dW5hdGVseSB0aGVyZSBhcmUgbm8gYWN0dWFsIHVzZXJzIG9mIHRoYXQgKGluDQo+ICAgICAgdXBz
dHJlYW0gRFRTKS4NCj4gICAgICBOb3RlOiAicmVhbHRlayxpbjItZGlmZiIgaXMgYSB0eXBvIGZv
ciAicmVhbHRlayxpbjItZGlmZmVyZW50aWFsIi4NCj4NCj4gWzJdIFRoZSBleGFtcGxlIGluIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9wY20zMDYwLnR4dCBoYXM6DQo+
DQo+ICAgICAgICAgIHRpLG91dC1zaW5nbGUtZW5kZWQgPSAidHJ1ZSI7DQo+DQo+ICAgICAgQWdh
aW4sIHRoaXMgaXMgYW4gb3BlbiBpbnZpdGF0aW9uIGZvciByZXBsYWNpbmcgInRydWUiIGJ5ICJm
YWxzZSIuDQo+ICAgICAgRm9ydHVuYXRlbHkgdGhlcmUgYXJlIG5vIHN1Y2ggdXNlcnMgKGluIHVw
c3RyZWFtIERUUykuDQo+DQo+IFszXSBhcmNoL2FybS9ib290L2R0cy90aS9vbWFwL2FtMzM1eC1i
YWx0b3MuZHRzaSBoYXM6DQo+DQo+ICAgICAgICAgIGdwbWMsZGV2aWNlLW5hbmQgPSAidHJ1ZSI7
DQo+DQo+ICAgICAgQnV0ICJncG1jLGRldmljZS1uYW5kIiBkb2VzIG5vdCBleGlzdC4gT2gsIGl0
IGlzIHVuZGVyIHJlbW92YWw6DQo+ICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjQxMDA5LWdwbWMtb21hcC1kdGJ4LXYyLTItZmM2ODEyNGEwOTBhQGtlcm5lbC5vcmcvDQo+DQo+
DQo+DQo+IEdye29ldGplLGVldGluZ31zLA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
R2VlcnQNCj4NCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBM
aW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPg0KPiBJbiBwZXJzb25h
bCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhh
Y2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAi
cHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg0KDQo=

