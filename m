Return-Path: <linux-kernel+bounces-415563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4D9D3834
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9400B26308
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0FA19D093;
	Wed, 20 Nov 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YawkxjTE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C871990C0;
	Wed, 20 Nov 2024 10:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097505; cv=fail; b=Xpaj7H1eptlzsxUh2SdH6w26MRslj/mzZJfnT+34f96TpFbLln2n+lEjAbgcS49WL8uPzz0AXKCaYBGizAyzC4BXLKp4mhPzXz4Xg1kEozTT44ssZ0Jzs9x9WL/GFH8Y94V7nXqhqkPo6J7KR0Bnzy8GuTmzgx7wIXxn4fFuogc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097505; c=relaxed/simple;
	bh=Qpsre/HqHt1S7fZAlxFke5zYs33HwJo4SW+fX2Qdcok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FuCE8xO5BzrjPPYeuKegVtEDLbxa85q1wHJs0QmXz3m1lY1dsJH1fi42K3PGBdkjP1ftrjmGkmVKngklI7Wkg1eV2iE3zUwbkN76MHMxuTrzX6pgHwMPrJp/luZUMaBXo77iJizdY4nNpORVnDvFJQ3GUlZqAdZ8jWfn3tjSxHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YawkxjTE; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbjeGubtrbr7+rUK7R7UeD0yh1uLTvQtPuHOgpFGs33vO0STfnCMq70cwi8LLxi06cx4utsM3O+K4RpwCqJrjjC+B9UhfnjmktAclgL0ZmvrfgDb5RqNewvdZODpj4xeTwyAnDt6OjBZ8uLKcuFFNDDO71NVzyjvUBlTm4mS2FmY/xAhJvQ84mcYir6O3i82v/+7b4Ty1NP1Z3ef4BPDOAktN8RWmeHNuqVNqkFI1g/4yCkAaMvBygKuIq+WqHTkwUrYFDuOOMYWDZM3qRRdl+tgJkLUWnrQHL7tFBdaII24yxFWBCcquqglXCMRCPsQ0WaaatjE8930QiOhAx/auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpsre/HqHt1S7fZAlxFke5zYs33HwJo4SW+fX2Qdcok=;
 b=JqSpBlI679ivawbv0BRQ3+boBNI3fyzzHcOV7oE/vKHRUQPpBsKHWNFTcA6isjru6UcovxZGYVHTwS1zmodhcrIwX4PBpHgKBAlYImcgCvnW0tKPKWGsO1urxsaRQk/XBdk10zOL/U8c7VVmn826k8Jfq+GbrMDVaFLHepM6gJXX1OwbwINJf7aKUcZneYFHpcwzRESXQ/WUKezd0j3tzZOM6jLtYumcP4jkwgO8w0ZKUbIjE1bZuu7r0TNlIKOwLyt5USNXs2iE5BFDOMOsW4/4+uwGWPpUsHJOdjsImNnpTUb9UGfCfmZnHoteHKcrLIXgqFSFpcfWME77GWEPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpsre/HqHt1S7fZAlxFke5zYs33HwJo4SW+fX2Qdcok=;
 b=YawkxjTEw+8yhduE+cns/XnyUxQuZS+HApPq3+4LTptBK1pfsNt5Hjuh0Kg0uxP2GgMDf16OQbTkg07mjyG8iI6PzlXlhq3vGNwTYXfPgjRUopf1IzLxaH0YB7BSf4GbMTES/ma74FnhsTtRZW4PnXt7m/TLG0xZWHCmKTnxs4+CndcKofsPZlFHUkT5TrSK0L9KS1ev6ikC1nrZ7k6nOjZJWwFha3fWW0+MDy6AmR2aIUIPcN89Kc2hfUEv3Ca3VmFNETlBb1ZodLiFsfN7g7irkLLS2QgvWmqbcas4BXhBd/DQUF4ceoM57HNkL6C3IrJgCyxPeQfMaDNiej11bw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9938.eurprd04.prod.outlook.com (2603:10a6:10:4ee::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:11:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:11:39 +0000
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
 AQHbMCsiGosLFeSwx0KHxJlfsPaJB7KqSvgAgAAA1oCAAZ6NgIABZEoAgAAIjrCAABiHAIAAqOUAgACk74CAAAQDgIACkRcQgA1lpQCAAU9NoA==
Date: Wed, 20 Nov 2024 10:11:39 +0000
Message-ID:
 <PAXPR04MB8459695A42922E52FCC9295488212@PAXPR04MB8459.eurprd04.prod.outlook.com>
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
 <PAXPR04MB845978F4D3C6E887E0DE8D5488582@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <d137cc7e-9b78-4cfb-ac50-023d1ea4c82b@kernel.org>
In-Reply-To: <d137cc7e-9b78-4cfb-ac50-023d1ea4c82b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB9938:EE_
x-ms-office365-filtering-correlation-id: 5470f5cb-876d-4ba0-b24f-08dd094bb985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzVZaUtVZHRiSVF6akpqRzdnZGxQc0RnMjZlek1wVFNHRmtmdjBSVWRZOUtr?=
 =?utf-8?B?WjNYMDAzMXROSVJOa21EQXZ4NFp3ZWdzemw1SFJQZlAvZ3E1NDlMcnhPcDJD?=
 =?utf-8?B?K0oxdDFCNFJac29ZeVkzR2h2eEtTSHpBWjJPZlRsWi9pdEEvYnJGMGFydDd6?=
 =?utf-8?B?UStFWW9uTXJSYUd3c0IyTk02N0RwZGlsblRHQmlla0VXT1d0THVQSEZOcjdG?=
 =?utf-8?B?VmVMYkRENk5ad2VmK3lwZmhkbkhvRUpUSS9ENUd2UkxDRUp6RHY0a1BSMXN0?=
 =?utf-8?B?Zi9yb2NpQitGbnNwYzVvdGJBcU51OWpORWNienBUT1E4ZDFnbm9Od3JIczNR?=
 =?utf-8?B?T2dvU3lTV2pwRHNxdEpXdHJGaCtVbUhCeDNiaVJpeFQrUC9nSkVHMEZKcDF6?=
 =?utf-8?B?Ui8wMSs1RUJBQU93SXByLzFjWTJVZzdwSmg0bkd0S0JCaDZDYlZEeTZlbWI4?=
 =?utf-8?B?NWtiVU96UHZaQVdKZEhLZ2VCcFNjZ3FpWFU2akNDSWRPd0YxQUNsSGozL0hM?=
 =?utf-8?B?L1dwRDlMUHF5Z2wybVVvVG1wbU8vSFpKQ2VHTk1RaTgvem1lcFFLK0ZlTGIz?=
 =?utf-8?B?dW5CZXF3bDNEUEl2akVwNEJSYmxYVTA5YldTRXlOYWUrcFBlbXhJVjRwZEFB?=
 =?utf-8?B?TjRjR1VLSGYzT0xJbzBmTW9Majk4R3lVaC9obzhOdHV4elpLd0JzaDBEM3NU?=
 =?utf-8?B?Ym5BOVFhd3BwcDJUVGpDekhMMStNejg4bkxzU2NLQWh0MkRlVERabnlQb1pk?=
 =?utf-8?B?Q1RNZllXaEF0SXpUcVprSU8xeVArZGVqcm5GSTdqejVxTUUxL211bFg5azhU?=
 =?utf-8?B?d1FiSFgzTWJkbmxWa256M2djNnIrcWYzL2N3ZVNlQlhRcGZvcXRWVDFCVkI0?=
 =?utf-8?B?SFp3U1VBcVkzSnZGbk1jY1VhdlRTUWk0TUMyalgrTnVmeTlhdDRtSTdPT3B0?=
 =?utf-8?B?dGFjQ2EvazNRT1ZKWEU5b1QwTUY4dW1XWFFwOUlZWk1PMkpsbm5YY0phRERl?=
 =?utf-8?B?TVBEd1cveXZwdWFxOUZObnhJaGM5YklVWFhJcEFNTDFFVHppT29CR0xlcW1y?=
 =?utf-8?B?ay9kVnFlelNRclFBTDlDczA5UDhoMTlXUG5VaGQrWUdUVlZDcjFHYWhaQjJX?=
 =?utf-8?B?WlYyQTdNTDdMR21KeXN0UVQwVm1CSEszLy9Ob2RVU042MG1XdzV3aXU3Sm8z?=
 =?utf-8?B?bWxRaDR4amU4ZXNpM3MzR1hiNFRmTGtyeFJVRkpJaTJMZC9iQTE0T1Vmakll?=
 =?utf-8?B?M2wrbUZtQVFzaStkcDhuQ2xXeG5ybzZERngxY3F3LzBoNVpWVHMwbmU3SUNO?=
 =?utf-8?B?UWYxK1hNS3NUTTBLekZvSCsxSU5kZmdOY2Z3QnIrYU8vdWZHcnhqa00wMDJZ?=
 =?utf-8?B?RU51QUFWUFlqWUtQOWd1V0pKS0xULzRaWXVoYjA3VXJsT1pTNTY0TkF6aTdY?=
 =?utf-8?B?ZUdjQmVxMzJ4NFIwbHdLekkyYVd6OTg4VmR3ZFkwcjU0WnY0OEd6eXB3eWdu?=
 =?utf-8?B?Y2picGs4cUtDWHI2N2d0ZHlRV2dZclRWdllVUmkwK2x5dGR4NmpKTFlnVEI4?=
 =?utf-8?B?THpkS1FzeHZ3TFV5RENDQVdseE54T0pSY3JIaWpLNnBBMHlXUlEwZTdoRWdj?=
 =?utf-8?B?OVh3RC9TZHBmZC9FUXNmTnVOZFhCUHdYZW8vMjhReVk4T0laOHdIZFhwYm5y?=
 =?utf-8?B?bDRTWHlGSnhISmEwYUlRWGErd1JLK0dOS3ZoYzFQaCswbnkvTVBDMStHV3FT?=
 =?utf-8?B?R0NUR0xiL1hmdHhTTWUzZFZJWTVBdzlEZWRmYVJlelpTdlJlKzZ2dnd3eklN?=
 =?utf-8?Q?ol7drNkwZG5KjCxQAdx5t4EO/hGgbH6t/iVhE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVNxVmpnbTcxZzVTNSt5ME5UWjhKbUxMOURnWEtXM0E4eElrMzU3ckxhL1c0?=
 =?utf-8?B?Z2ZuaUNDUjNLV0x5YmVpTGtZUitJK2dNTWE4SGtHZHBBK1htK2RQNEUxWGVs?=
 =?utf-8?B?WlNmb09OK1lLdEtkbWZoZ21TcGV6M2JoNnJRMUphU05EY1AvZzI5V0JaVTha?=
 =?utf-8?B?eSt6UUJOV2tKNW1zTjdXbFVXTkpwdWF2dmJGNGgrUXlNTXVpTHZVU0NEZEYx?=
 =?utf-8?B?NEJWbHR1MWtlOC9TNUhBbjhFZjlFakg4bWhiOWlMeW5la2dmQjFJaXBaZElQ?=
 =?utf-8?B?cnVacVRqVERUd0orTHlSM0F5UXZIbDUzV0o4azB6dnAxemtacHdKTm9tUStj?=
 =?utf-8?B?Z2NxVlBBNFZJdlAvZGlSTEhGTjNXeVhzQ0ZkM1RMeVI4SUlHbXg5UjJlZXdi?=
 =?utf-8?B?Wnl4SWd5MXRSLzhLOCszbGhwRHQ4OS9DVzVoQmE1dnJFVUlPR05sNUZZaEx0?=
 =?utf-8?B?dW50NEQ0ZXBicWw3emdhWHd2VTN1WmNWZVNRZ2ZYRGk0VWJ4bjE0SEFRR0Ji?=
 =?utf-8?B?RjczTmREZThFYURRdnRiODNDeE5LTnRWZldlYk9FeDdOOHFPVXA1SjlhWUNH?=
 =?utf-8?B?eS9aTUFRQ0dSaDk0c29MekloM3NWRU91cW8vNzMwaFQ2NWxEWmFKY2NxVHVw?=
 =?utf-8?B?UE95M2k1TG8rSTZ2YTJTTDJTbnRyMmord3FobThCamUwSDBkRmFnQXQ5aU9t?=
 =?utf-8?B?Wng1R1hjMTVvU3lQQzgvaTkvUmFoZHlnZWpGV2JZT24rYWd3VUJqRVpMdmdI?=
 =?utf-8?B?WHN3UFJBbVRmdmJJVXZaTm8zTzUvNXhDdC9IaG9FeTBkS3NrYnVqUFJRZERP?=
 =?utf-8?B?aWQya0lhUlZmcWxLWmVOaGxHNnExdVRSWHpYSkdFdDhUbWVrOGlWOTRmZmVm?=
 =?utf-8?B?SUZjclNvaE14Ym81QnBsZHJoVzZXMW90eHU1dHZ4TGMrblpBLzJnRWJwMXo4?=
 =?utf-8?B?bm1wNWJOZkpnT2k3UE1xMWtlZlFzZDdYV0NmbW11WkF3cmxJUUhCcFVZR0kx?=
 =?utf-8?B?ZUxlWTZkTW5xc21DQjA2QytzMUdNOFFkRzBqSE4yTUloc3h6dWtXWCtkZDBk?=
 =?utf-8?B?RVBYWk9iWUlURHIyOE5SamdMcHdtcnhlWFcyWnBOMURsV1VOQi9nL1FjdFJ6?=
 =?utf-8?B?UnRMWGRQa05Da1p2V00yTDJYT3FYYWpUQ01NeUtzNGFyMTIwYklKUHZaTnFL?=
 =?utf-8?B?SmFZRTR1S3VwS2tkcWhYYjdaS3NuV2RMazJRQk12a1JDSXdURkV5cUM3U2FB?=
 =?utf-8?B?d0U4UXJUdktFQmJCZ1BHZ3VZZ1RvTEI3SEpMUkpuSXBNaDd3T1hJaUdxMFBG?=
 =?utf-8?B?Q0pqOTlXSktiL0I2WWVoeFRaa1pvR0VDYis4ekI5d01YNkVUMmtDZWdEWVEy?=
 =?utf-8?B?WHAxSjcvV3I3R2VXKzJONWUvam1BYzZYSmZWalNjbFlYMGNlSUpFMjB3TVFM?=
 =?utf-8?B?SW1XaG1EVGdOWlBsMldqbkJ2Qmp2TTJBWUZvaTk0bFovOHRzZDZ0bUZhQmVh?=
 =?utf-8?B?TUhoMUhXVHJSZUVySVhGMkdreXVSNjg4RTZhTlFWMGhUaStHai9DR1JIM09q?=
 =?utf-8?B?aFJwV3ZOUTFiV0QwVG1KV3Z6azJyU0ZIaUwxU2NpMkhQeE5MdXJkek1jZzUy?=
 =?utf-8?B?a1ZVKzMycHNsQVNiVVJ1TzY2ZDYvdkEyZkRFYjFxSW9nOFdwMUpFZU1nWk1Q?=
 =?utf-8?B?cklqdmVQTEdBVU5XRldsYzZDUHcwejk0TFRPNFV4bGJDV2VPQkpqUFE4WXpV?=
 =?utf-8?B?UkdGaWFpVnZ5N0ZxWU1PaEdZVDk4K0w4cHJhRzdTeEl1U2tBRUMzRi9CcmxF?=
 =?utf-8?B?dFcwcm1MZkVTeW5aeGdQQzhZbnRHVUlIRjVRdGQ4STR3bkkxeElEVW9aLzNs?=
 =?utf-8?B?dWJTU3VMWWo5enFTSS9TOXJianZNbUxSNllSZ2lNTk1WNXJKdG5UM01aeVQz?=
 =?utf-8?B?dkxvZDhpVERYU3VqeFExVEd0YmZKaHB2L0N5YVBuZ2RUL1NYc0tJaWVkQzhj?=
 =?utf-8?B?U1dsVSt5V2RpWFpEWlVoTU1TMjFSS1d0aVVSTnArNUExVGVhWm95aUpjRXdW?=
 =?utf-8?B?SmMvQlBrTWtUaEFlM2dMdzdFT1lzZTdaV2RZZS8ydWI1ZW52K0paKzZjZVhY?=
 =?utf-8?Q?0K2k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5470f5cb-876d-4ba0-b24f-08dd094bb985
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 10:11:39.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UP+FabYRK4Ni21ABRhKllXUYFW4/5IFGO/R2L/ohOPJwXk1ve52HmIS/W7nKEnJYL9SooIKkU9O0tGZuFVaTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9938

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvOF0gZHQtYmluZGluZ3M6IGNsb2NrOiBpbXg4bS1j
bG9jazogc3VwcG9ydA0KPiBzcHJlYWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gDQo+IE9uIDExLzEx
LzIwMjQgMDI6NDksIFBlbmcgRmFuIHdyb3RlOg0KPiA+Pj4gSSBkb24ndCB1bmRlcnN0YW5kIG5v
dyBldmVuIG1vcmUuIE9yIEkgdW5kZXJzdGFuZCBldmVuIGxlc3Mgbm93Lg0KPiA+PiBXaHkNCj4g
Pj4+IGJpbmRpbmcgcmVmZXJlbmNlcyBpdHMgb3duIGNsb2NrcyB2aWEgcGhhbmRsZT8gVGhpcyBt
YWtlcyBubyBzZW5zZQ0KPiA+PiBhdA0KPiA+Pj4gYWxsLCBleGNlcHQgb2YgY291cnNlIGFzc2ln
bmVkIGNsb2NrcywgYnV0IHRoYXQncyBiZWNhdXNlIHdlIGhhdmUNCj4gPj4+IG9uZSBwcm9wZXJ0
eSBmb3IgbXVsdGlwbGUgY2FzZXMuDQo+ID4+DQo+ID4+IEFuZCBCVFcgaWYgdGhhdCB3YXMgdGhl
IHBvaW50IHRoZW4gdGhlIGV4YW1wbGUgaXMgY29uZnVzaW5nDQo+IGJlY2F1c2UNCj4gPj4gdGhl
ICZjbGsgcGhhbmRsZSBpcyBub3QgdGhlIGRldmljZSBub2RlIGluIHRoZSBleGFtcGxlIGJ1dCBp
dCBzaG91bGQuDQo+ID4+IE5laXRoZXIgZGVzY3JpcHRpb24gc2F5cyB3aGljaCBkZXZpY2UncyBj
bG9ja3MgYXJlIHRoZXNlLg0KPiA+Pg0KPiA+PiBUaGlzIGlzIGV4cHJlc3NlZCB2ZXJ5IHBvb3Js
eSBpbiB0aGUgYmluZGluZywgbG9vazoNCj4gPj4gIlBoYW5kbGVzIG9mIHRoZSBQTEwiIC0gaXQg
Y2xlYXJseSBzdWdnZXN0cyBzb21lIG90aGVyIGNsb2Nrcywgbm90DQo+ID4+IGl0cyBvd24sIHRo
YXQncyBzbyBvYnZpb3VzIEkgZGlkIG5vdCBldmVuIHRoaW5rIG9mIGFza2luZy4gUGF0Y2hzZXQN
Cj4gPj4gZ29lcyBzbG93IGFsc28gYmVjYXVzZSBvZiBwb29yIGV4cGxhbmF0aW9uLCBsYWNrIG9m
IGRpYWdyYW1zIGFuZA0KPiA+PiBleHBlY3RpbmcgbWUgdG8gcmVtZW1iZXIgeW91ciBjbG9jayBo
aWVyYXJjaHkuDQo+ID4NCj4gPg0KPiA+IERhcmlvIG1heSBpbXByb3ZlIHRoZSBwYXRjaHNldCBp
biBuZXcgdmVyc2lvbi4gQnV0IGxldCBtZSBqdXN0IHRyeSB0bw0KPiA+IGV4cGxhaW4gYSBiaXQg
bW9yZSBhYm91dCB0aGUgaGFyZHdhcmUgbG9naWMsIEkgaG9wZSB0aGlzIGNvdWxkIGdpdmUNCj4g
PiB5b3Ugc29tZSBrbm93bGVkZ2Ugb24gaS5NWCBjbG9jayBhbmQgd2UgY291bGQgZ2V0IHNvbWUN
Cj4gc3VnZ2VzdGlvbnMgb24NCj4gPiBuZXh0Og0KPiA+DQo+ID4NCj4gPiBPU0Mgd2lsbCBnZW5l
cmF0ZSAyNE1IeiBjbG9jayB0byBBbmF0b3AgbW9kdWxlLg0KPiA+IEFuYXRvcCBtb2R1bGUgdGFr
ZXMgMjRNSHogYXMgaW5wdXQgYW5kIHByb2R1Y2VzIHZhcmlvdXMgUExMcy4NCj4gPiBDbG9jayBD
b250cm9sIE1vZHVsZShDQ00pIHRha2VzIFBMTHMgYXMgaW5wdXQsIGFuZCBvdXRwdXRzIHRoZSBm
aW5hbA0KPiA+IGNsb2NrcyB0byB2YXJpb3VzIElQcywgc2F5aW5nIHZpZGVvIElQcy4NCj4gPg0K
PiA+IFRoZSBBbmF0b3AgbW9kdWxlIGNvdWxkIHByb2R1Y2UgUExMcyB3aXRoIHNwcmVhZCBzcGVj
dHJ1bQ0KPiBlbmFibGVkLg0KPiA+IFRoZSBDbG9jayBDb250cm9sIG1vZHVsZSBqdXN0IGRpdmlk
ZXMgdGhlIGZyZXEgYW5kIG91dHB1dCB0aGUgZW5kIElQcy4NCj4gPiBUaGUgZW5kIElQcyBjYXJl
cyBhYm91dCBzcHJlYWQgc3BlY3RydW0gZm9yIGhpZ2ggcXVhbGl0eSBjbG9jaywgdGhlDQo+ID4g
Q2xvY2sgQ29udHJvbCBtb2R1bGVzIGRvZXMgbm90IGNhcmUuIE5vdyBiYWNrIHRvIGJpbmRpbmcs
DQo+IA0KPiBBbGwgYWJvdmUgbWFrZXMgc2Vuc2UuIFRoZSBwcmV2aW91cyBtZXNzYWdlOg0KPiAi
QmVjYXVzZSBpbiBjdXJyZW50IGRlc2lnbiwgY2NtIGlzIHRha2VuIGFzIHByb2R1Y2VyIG9mDQo+
IENMS19JTVg4TV9WSURFT19QTEwsIG5vdCBjb25zdW1lci4gIg0KPiANCj4gY29uZnVzZWQgbWUg
YSBsb3QgYmVjYXVzZSBpdCBzdWdnZXN0cyB0aGF0IHRoZXNlIFBMTHMgYXJlIHByb3ZpZGVkIGJ5
DQo+IENDTS4gSXQgdHVybnMgb3V0IG5vdC4uLiBzbyB0aGUgYW5zd2VyIGlzIGxpa2UgSSBzYWlk
IGxvbmcgdGltZSBhZ286IHlvdQ0KPiBtdXN0IHRha2UgdGhlc2UgY2xvY2tzIGFzIGlucHV0cyBh
bmQgdGhpcyBpcyBkb25lIHZpYSBjbG9ja3MgcHJvcGVydHkuDQo+IE5vdCBmc2wsY2xvY2tzIG9y
IGZzYyxpLXdhbnQtbW9yZS1wcm9wZXJ0aWVzLWNsb2Nrcy4NCj4gDQo+ID4NCj4gPiBUaGVyZSBp
cyBhIGlteDhtLWFuYXRvcCBiaW5kaW5nIGZzbCxpbXg4bS1hbmF0b3AueWFtbCBmb3IgYW5hdG9w
DQo+IGFuZCBhDQo+ID4gaW14OG0tY2xvY2sueWFtbCBiaW5kaW5nIGZvciBjbG9jayBjb250cm9s
IG1vZHVsZS4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIHBhdGNoc2V0IGlzIHRvIGVuYWJsZSBzcHJl
YWQgc3BlY3RydW0gb2YgYSBQTEwgZ2xvYmFsbHksDQo+ID4gbm90IGZvciBhIHNwZWNpZmljIGRl
dmljZSBzYXlpbmcgdmlkZW8gSVAgaGVyZS4gU28gdGhlIHBhdGNoc2V0IHB1dA0KPiA+IHRoZSBw
cm9wZXJ0aWVzIHVuZGVyIHRoZSBjbG9jayBjb250cm9sIG1vZHVsZS4NCj4gDQo+IEkgdW5kZXJz
dGFuZC4gVGhpcyBsb29rcyBob3dldmVyIGFzIG1pc3JlcHJlc2VudGF0aW9uLiBJZiB5b3UgZG8g
bm90DQo+IGhhdmUgdGhlIHZpZGVvIElQIGJsb2NrIGVuYWJsZWQsIHdoeSB3b3VsZCB5b3UgY29u
ZmlndXJlIHNwcmVhZA0KPiBzcGVjdHJ1bT8gSU9XLCBzcHJlYWQgc3BlY3RydW0gYXMgeW91IGRl
c2NyaWJlZCBpcyBuZWVkZWQgZm9yIHRoZQ0KPiBmaW5hbCBJUCBibG9jayBhbmQgdGhpcyBmaW5h
bCBJUCBibG9jayBzaG91bGQgY29uZmlndXJlIGl0LiBQcm9wZXJ0aWVzDQo+IGJlbG9uZyB0aGVy
ZS4NCg0KTXVsdGlwbGUgSVBzIHVzZSBzYW1lIFBMTHMgYXMgc291cmNlIGFuZCBzaGFyZSBzYW1l
IHBsbCBzZXR0aW5ncywNCml0IGlzIGJldHRlciB0byBjb25maWd1cmUgU3ByZWFkIFNwZWN0cnVt
KFNTKSBhdCBjbG9jayBwcm9kdWNlciBzaWRlLA0KSSB0aGluay4NCg0KRGFyaW8sIA0KDQpXaXRo
b3V0IHRhbGtpbmcgYWJvdXQgZHQtYmluZGluZ3MsIGFub3RoZXIgYXBwcm9hY2ggdG8gZW5hYmxl
IFNTDQppcyB0byBlbmFibGUgU1MgZm9yIFZpZGVvL0F1ZGlvIFBMTHMgdXNpbmcgZHJpdmVyIHBh
cmFtZXRlcnMsDQphbmQgdGhlIHBhcmFtZXRlciB0aGF0IG5lZWRzIGZvciB0aGUgUExMcyBjb3Vs
ZCBiZSBwYXNzZWQNCmZyb20gbW9kdWxlIHBhcmFtZXRlciwgc3VjaCBhcyBjbGtfaW14OG1tLmF1
ZGlvX3NzX3h4PS4NCg0KVGhlbiB5b3Ugbm8gbmVlZCBiaW5kaW5ncy4NCg0KUmVnYXJkcywNClBl
bmcuDQoNCj4gDQo+IEl0J3Mga2luZCBvZiBzaW1pbGFyIGZvciBzb21lIE9QUC9wZXJmb3JtYW5j
ZS9iYW5kd2lkdGggcmVxdWVzdHMuDQo+IEV2ZW4gbW9yZSBzaW1pbGFyIHRvIGNsb2NrIGZyZXF1
ZW5jaWVzLiBXaGljaCBkZXZpY2UgcmVxdWVzdHMgdG8NCj4gY29uZmlndXJlIGdpdmVuIGNsb2Nr
IGZyZXF1ZW5jaWVzPyBGaW5hbCBjb25zdW1lciwgbm90IGNsb2NrIGNvbnRyb2xsZXIuDQo+IA0K
PiANCj4gPg0KPiA+IEZvciBleGFtcGxlLCB0aGVyZSBhcmUgVlBVX0pQRUcsIFZQVV9ERUNPREUs
IGJvdGggd2lsbCB1c2UgdmlkZW8NCj4gUExMDQo+ID4gd2l0aCBoaWdoIHF1YWxpdHkuIFNvIHRo
ZSBjbG9jayBwcm9kdWNlciBqdXN0IHByb2R1Y2UgUExMcyB3aXRoDQo+IFNwcmVhZA0KPiA+IFNw
ZWN0cnVtKFNTKSBlbmFibGVkLCBhbmQgcHV0IHRoZSBTUyBwcm9wZXJ0aWVzIHVuZGVyIENDTSBv
cg0KPiBhbmF0b3ANCj4gPiBub2RlLCBub3QgdmlkZW8gSVAgbm9kZXMuDQo+ID4NCj4gPg0KPiA+
IFdlIGNvdWxkIGhhdmUgYSB0YWxrIG9uIElSQyBpZiBEYXJpbywgQWJlbCBhbmQgeW91IGFyZSBh
dmFpbGFibGUgdG8NCj4gPiBkaXNjdXNzIG9uIHRoaXMgdG9waWMuDQo+IA0KPiANCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

