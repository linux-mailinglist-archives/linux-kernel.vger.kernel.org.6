Return-Path: <linux-kernel+bounces-365506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E56699E36A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D1E284193
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBC019F132;
	Tue, 15 Oct 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLQEGiPj"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCAF1B85DB;
	Tue, 15 Oct 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986883; cv=fail; b=o1QrTffQTFbSsOaCeByxdaj/COkdqg1E4U716MIWGWKGHtWi8J3rxOt/PWolpySLO7N3vE8d9a6baTfea1VM3sNHnlc+SzdmuDHgPf0p7GQ0vyQcH1GXGspPXJGG5Cv39+GEw36/gFeFjeMES7TJKRpVgVZQAd4lIoBH6Ceiha4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986883; c=relaxed/simple;
	bh=oCHTSp5OAF0ee1qa6d8pKESef4MwL2eg4CfJ3+GzyKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XfsAfodJ91R3br0SlFJoGSxh3G8oVz0PtZ470XY+5dGqyv4cLjpEoCu9xN1uw71+aOMUGH8+ptKH52JYvdlVOhHD6JSetlDgoST7FDAUBMrswFdAqGEhIzC9m8FjhlYuR/88vfIgPqMlUAqAqKJmh4x9PxS9pxKo5nDrLSRf+e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HLQEGiPj; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T82R5toW4178Uvd52VsjbyCcWSwuG8SdK7cA9Z1aXQGzlp1NffBcOC8OeQWcxP4zn6HtSW7pFerqmKbEaxdclRs5vmWWHUfPhRoe3Di532SGZRnoP7Y5vFRo8pS9CPhYw+w9iqpkq4e17df9TO5KnO+NyFDdgiQmKSAcP7bXZOkKQHRd3u2GYmXeO+EMMkIwtFhnkClrt8rFGCEtOKc2498uGKv4yJVp72HJU80qfvmnDK5jN5UYofeKhL1XCm4iKGs72gX0e8ikhKn9zwMudTXSZ/zSuByKORSrOUYmaEtpV0S4VUjMw2BM310Jt06oHIkqfO6DO2droU+B16NfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sLO3OQYDlTs0V4Od+wdtcFTBRd6NhRBrlJZW4Q0BY0=;
 b=BWjyRxWwxDALoiaWvtO5oWb91Zz33pQO4nHi+n/yS+fG8yu2kDOQ7NhiFFsTGneOek56+F4DcnatT8A4PM8Wv8Rv6hsZTXh0Jtt+jX+7DuptuxDB4nsU4R9FdGdIGV6kWiyzsZwHbm19PYs4FPZMP5GGYeMjhiTM56+UxFlvZiAtyHjbD5frb9taa0KxMMFMcL2IVTd+cUkKKO5j2r/y/A13nLFGQ6XlailFgDcXj1soobLg6ZyTprNQTHoXViswzMwML8WgpVEd1B79iSljsvCphzAR3f3NmXq2ISlLGcA3frE3W0hcQc7bpZHXkEkg8bVzLZx24yV1O0B7+IW4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sLO3OQYDlTs0V4Od+wdtcFTBRd6NhRBrlJZW4Q0BY0=;
 b=HLQEGiPjsLK8HnKPnU5H9ZIrAx5WtivieKdPAkaeoaE5+Uo3IEyx+PYHlYS4hjZtN2dAUEj0Fwj6Py0Ul+6L5P+wS+4N7gtKXXf/+tSCsAaF7N28jw0RhVZ7inwfrXKvqbLMLc+/2+vLeVB/IDXcGE9xp4eYrcFzqBtIom2eXbjhFJbnfqoc2gYaK5G/sRh21TPzg/cWM0dS6KWMQsEplk8bfo0VhQFnAMEp/XGEAWpyhSZn2zBfxC85nBcqs3ayt3HsRIInTYB4CdstJ4lxpdN6OlI0WUIP1wqcWaSHtkwZToyKwuiG7zZG/mHlcSGo8EsDVru3ntr4FiNsL7zcuQ==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB8262.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:07:54 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 10:07:53 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: RE: [EXT] Re: [PATCH v8 0/5] v8: firmware: imx: driver for NXP
 secure-enclave
Thread-Topic: RE: [EXT] Re: [PATCH v8 0/5] v8: firmware: imx: driver for NXP
 secure-enclave
Thread-Index: AQHbHuFiApqEh3ZFxkmL/JRn9AD86LKHjVaAgAABpCCAAAWQAIAAAbUg
Date: Tue, 15 Oct 2024 10:07:53 +0000
Message-ID:
 <AM9PR04MB860412527EA8DE6E5211377A95452@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
 <20241015-silky-mussel-of-tolerance-b3f5ba-mkl@pengutronix.de>
 <AM9PR04MB860408A38DB566BB18B6E2E695452@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20241015-literate-onyx-rhino-1f73c7-mkl@pengutronix.de>
In-Reply-To: <20241015-literate-onyx-rhino-1f73c7-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB8262:EE_
x-ms-office365-filtering-correlation-id: 84f76019-eca2-4790-038d-08dced013bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTJpdUY4S3pwUmwweUppVDRyVW9ZaGY1dm9rUllNb1hZQU9tQ3V4L0tXMGpD?=
 =?utf-8?B?RHNpTU4wOUlRVFE1bUcvbzFCNmhPMkhjTTlJSEw0RkdEOUM1S21yWEFOWFJX?=
 =?utf-8?B?dWgzeHdhZ1U3TU82K202NFdWTjRtSGxEcjIwMHE3TUNtY1J1Y0F4bU40bUd5?=
 =?utf-8?B?Rm12S2R5eGUya2dXSUVnQWh3ZSt4K3Y5NTVUSGRzejRnQ1luNUMrSG5zNkFS?=
 =?utf-8?B?YVFYOHpWaDFGS3BqNUVPU2J5djI4UytDWVcyTEtLelE4a2NDdVlReEdMRE91?=
 =?utf-8?B?aFNmR05ZUmNZOHRza09TZ0FVcEcyNXJYc0hET0xrT01zb21hbmpwN2pSODNk?=
 =?utf-8?B?UDMwVkxXV3ZHWS91UDBaL1BySlZ3NitWWXR2NHRpaERjVjlEOXByR0xYa0RG?=
 =?utf-8?B?RStiNFpnRWlCZFZjNm5uMHZzS0lPRVFyYnVsRzhQWkhZV29Xd2lWRkVqdDZM?=
 =?utf-8?B?eXQ4dUpUWDB6b09zSFN4MGZ0NzJZTXJ4dHBKOVROazhCMGgydTg4Z3A4bVBS?=
 =?utf-8?B?Q3FNSUc2emk5bmVISURkelFZWjFzUWRiVTBCT05IN1hHaFVHVzZBQkhmZFl2?=
 =?utf-8?B?NWZTWGk1N3lJMmh2VlJvSEYzYTZiNGs0SHZFcUVEekhhb1Z1cFdyREVydWNH?=
 =?utf-8?B?bEVHQkpQci9FVGdiM0VmcldVc0c1R3FFTnkzb2J0R0ZVbmpRNXc3WTQydUM4?=
 =?utf-8?B?bFR6a0NFY2RmNkd2b2djakxiYngvMGY3dkNUNW00RDg2TTBYbDg1TzYwSFVj?=
 =?utf-8?B?cTE4RWx5Z1pWYjRoTmtVd3lzS1hJQ01HV0dQUzRUNWdyMG4rc1prZFJ3Sjdm?=
 =?utf-8?B?cHdWeWpVcHljNGFKNzhNSWJyTU43dEw3U1pjUFo2UlZtb0p5M3NYL1kvRXR6?=
 =?utf-8?B?MHJ4UVhFMW5OUVJ5Q1Z1bDlEb29ScWdFQWo5elh3L05Bb01LdW9pOGlIZkxv?=
 =?utf-8?B?b2RFTHpaTWxMa2lXa0NYSURWbEY1UXg0cFdlSmpBSFFKVHI4b1hZcUtZT213?=
 =?utf-8?B?eTNjS2F1VmlrRXFiajl3NXVSYlo3TXFQblJlRFVOQWlwcG82VDIzVzFFTjMw?=
 =?utf-8?B?K3R6c24vVUtmelZGS0hlT01BRW9JSHlLcloyU3JOQUlYNE9wZFpZZmxlK3c3?=
 =?utf-8?B?b0w0QnBqcTlrWVcrS0o1UG5PLys4cUdMTHhJeVcvUUhjYjVvVVIwcUxJcCtj?=
 =?utf-8?B?dTlya0ZsdWVudVEwMjBJYllXejZYbmNZYXR1TG1KdUovWFhSUVVhWjcxdVFC?=
 =?utf-8?B?RFN0UDVHcUVkcmFEY0xOMCsxREE5aUFtd2premF3MEJQMC9RVUg2Ty9WditB?=
 =?utf-8?B?MkpQY01iTXlSUTlxTmxQSlgvZVB1SlMxNWNVNFNOK3hpNTRtT21Ed05nWjBh?=
 =?utf-8?B?T3ZCSkgzdjB0UUVQQWIxSDNXSnFGaHp2Uk5VaUc1QnBSV210K3k4SEZ6cUpP?=
 =?utf-8?B?UGJEUVMycytKUUpNd0xVU1dZTkpIRjYrM2hHdS9SblFrTnNWWmFpdW5NdEFX?=
 =?utf-8?B?bUVkZ013WDQ2MmNKcFR0cFJoZzNOTEErTmhnU3VhMk1hY3ZqK0xNbzFXSTBq?=
 =?utf-8?B?d0NLQytVc2ZOaUNtQXQyYWRzWDZZb1lkSVViWktoT1oyb0ZxcWtoMHc4SzZm?=
 =?utf-8?B?RTF0ajJkakdEVGpqSnBiRjVXTytTcDZpK3U5RmVMMXVXQ1VWN2U4RTlpZGk1?=
 =?utf-8?B?UEswUWRjQ1VIK1pyNTk1QWt6T2Vzbnk1OGNZNkJhNFJ2SmM3eTJ0NDd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2JZaWR3bWZ3N2g2ZGcwVU1TWnRmMEZBWU9VdEd2NDJRcGNROFVtcmNkRjZN?=
 =?utf-8?B?QncrcWowbmJvT2pWSElodzRGbWRYMWUzQmlEZG9wUzk1NzhMbmZFTk9zOTNk?=
 =?utf-8?B?ajBzL2FZNkcxT0FmOEVPQmdBbmtabkZkdzdQK2lHbFpSL2lmOHgyczk3SFZn?=
 =?utf-8?B?Y1ZlckNRNGsxNlA5SmRxS3hpNmFndXBmOW5SMmFwb2ltVk5RdGs1UXpVY2Vw?=
 =?utf-8?B?eVB1TGtGRlJWajhhbHhpeExQSmx6Y04zZktPTWVGMGhuVk1IMmsrdlhNNDE4?=
 =?utf-8?B?ZXN3MmIzTU9KenpmOVdGNzVYaTlFQktEN2xmbFZWbS9iUWVwU0cvbi9ySFBE?=
 =?utf-8?B?UWZhUFNCekFDWlpDdTV0ZG1ZV2NqbExyUkx4RUNWeUl1b1BhM0k1MlZDY2tZ?=
 =?utf-8?B?OUVYTm1ZUXMzdDVEWDlWZWFaK25abm0vWVMxeFF1dnhTVkFmTW5RbjZYbEFa?=
 =?utf-8?B?S1FqUklteURoNW5ZQjN5a2djSEdkNHo0NkRQdUEra05GU25hNUQrcWZLZXhQ?=
 =?utf-8?B?cjArelNwRVZGeFRPMk9GakpyRVVqbEZqRlhSWDdYY1VuY1FnRWVwRE4rNUFJ?=
 =?utf-8?B?cVBOVG1tT3RsK0hXRHIvVnNHR1FNSGVVME1ZcTV4QU1zYTVPSzRLNEUxNzRW?=
 =?utf-8?B?T0NkQ2ZNV2ttKzUrRXRGaHFJVnlQc3QzZSt1aEtQTlEvYW8vaFNOL1NScGk5?=
 =?utf-8?B?aFNpZU5SVWRPeFhvZCtsNU5rZWhTcFBlUGtMRFZnZTFzNWxSUXIwT2o3Ukdp?=
 =?utf-8?B?MTA2dXBBUjlodnpwV25VLzdlNEtFVUJISnhjK2pzVFAzSENyUVZFWS9jZnJv?=
 =?utf-8?B?M1FJM2srYUh1V25NNTlWS0FBNlQ3Q1NTVnJjTkJsdFpRWDhJYy9MKzFpSnph?=
 =?utf-8?B?UVltZDBzTXdNNGZIQll3dzRoemYwcnR6U0FGQ3paNkhVTXdaUTh3QVVGdStE?=
 =?utf-8?B?M1EydFQ4cWN2WDFtNWpvaEtxNjlSRnU3VzVCU3FrQ1F0NU8veGRmMXNSZ1hC?=
 =?utf-8?B?QVJZUFFqTXdkQVpGQURRZXAyOUs5WEdEL3F5aUp1TVBQaE1OTVNqYXBlZDFS?=
 =?utf-8?B?VWZ2azR5cVJwY2VTVWR4T3JNVDk5M0haVjJORGpyaG9JbjdRVDlRbUh5OUdT?=
 =?utf-8?B?T3ZERWZiMk53T2dNNEhJZXpxVXc0M3VDeXNJMUMrZEN2cmpPYXR3TDVqSFVS?=
 =?utf-8?B?Qjk5OVUxTjFiRUhqcmVGSHZwcjQ0eGlXUkIxSS9PTTg3UHdoQ3ZHdEdsbU5G?=
 =?utf-8?B?dmc4WFdhcTFyUUVFSkVRODZmaHhUaXBmWmVaWHJXN2lpbHdXaG45RVovRHVi?=
 =?utf-8?B?R2s5SHIvYUpCV21sL2lkQ3NxZEtvZnIzQWNrdzN0YTBLYWdMNGdyMGJzWjN4?=
 =?utf-8?B?SDQxZDJoZEs1elkvK0ZOcnBLV2Z2TGpERzFMQndibWdyUUl6VysrNHp3a2l4?=
 =?utf-8?B?SEtuRjJEbnRlT0ZMVlJXRHYybjZKSXVwakdLaDRDYXFjZGdqRzkzUmV3Uk54?=
 =?utf-8?B?Y3JuUWpsMC9ndVZZWFBXSDBEUHZwbG54WHk3c2tRRkdEZlRSUzVLaGY0d1JH?=
 =?utf-8?B?ekN5Y3dEVHgyNm1hc2FoY3Q3R3d3Q25zdURqWG1lNytvamptcXpVR2FCU25N?=
 =?utf-8?B?NGhpaUp1cUtUUFZ6d2F2RVROdHhqZ05JSFA1UU9qb1Yrek5ibUxtRElLbDMy?=
 =?utf-8?B?a1g5bzh1dDluMTlOV1FocWJwM0o4Zi9VR2lFc0d5TG5YbUNHaW45TXhEcmNE?=
 =?utf-8?B?Q0diSms0QnVFWkZIZVFRQktOVnhtWlgwUngwSGY4OThCL2l2M3Y3dWZIQkdy?=
 =?utf-8?B?eWIwRlZ3UHJmcWxzWUVwTDBjMWMydjFVQmU4aklFTENhOWsyYlNjMlpvN0da?=
 =?utf-8?B?MVN1NFZITWJnMWlCQ2Nhd1VyV0VDcDl5QWg1WEIyNkxmSWV0WUhhSHhQUS85?=
 =?utf-8?B?VGVLWVNEb3ZGbHBHTktkUVJERHo5VkRrZTlQYWRYUU9STkYwYllsK3RwTjBi?=
 =?utf-8?B?a09oWlpTZzdJSnM4bWZZMkxnWXc0YmlVVWNLNWxGSVliU0JLQUEyVTg4ekl4?=
 =?utf-8?B?cmtpd2x1cm5NNE1FTGY5ZCtTNTBqSlUrejdoVTBIQWZTR0NidEJvazVTa2pV?=
 =?utf-8?Q?wyMsGBnQUjwlMJlXpQS7iHV2R?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00B4_01DB1F18.31788620"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f76019-eca2-4790-038d-08dced013bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 10:07:53.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EK9U5vlmQ07D4LqraLQQDjhZYHXcaB6xUGnJZu7AGRbvotvEHBOWh8F1aYQQD3x4eS2Ozypwy9BHTh/rt3rXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8262

------=_NextPart_000_00B4_01DB1F18.31788620
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

Ok, I will post v9 today, after rebasing the branch.

Regards
Pankaj

-----Original Message-----
From: Marc Kleine-Budde <mkl@pengutronix.de>=20
Sent: Tuesday, October 15, 2024 3:31 PM
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>; =
Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley =
<conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer =
<s.hauer@pengutronix.de>; Pengutronix Kernel Team =
<kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob Herring =
<robh+dt@kernel.org>; devicetree@vger.kernel.org; imx@lists.linux.dev; =
linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; =
linux-doc@vger.kernel.org
Subject: Re: RE: [EXT] Re: [PATCH v8 0/5] v8: firmware: imx: driver for =
NXP secure-enclave

On 15.10.2024 09:52:01, Pankaj Gupta wrote:
> Details about Base-Commits for this patch set:
>=20
> commit b63ff26648537a5600cf79bd62f916792c53e015 arm64: dts: imx8ulp:=20
> add caam jr commit 74f3788167230721a47d9f22afb746b8e6ba33e9 drivers:=20
> crypto: caam: i.MX8ULP donot have CAAM page0 access commit=20
> 5adcb3eebd33e5ced26b5ecc59f54be027bb4f1a caam: init-clk based on=20
> caam-page0-access commit 28e880c89d1ca6315a67330f15dddcf693be58ab=20
> Linux 6.9
>=20
> Above base commits are corresponding to the following commits in the =
Linux tree:
>=20
> d2835701d93c crypto: caam - i.MX8ULP donot have CAAM page0 access
> 6144436803b7 crypto: caam - init-clk based on caam-page0-access=20
> e6b73eb23f0b arm64: dts: imx8ulp: add caam jr ..... // This one is the =

> base commit

Please base your patch set on public available base commits. Preferred =
v6.12-rc1.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

------=_NextPart_000_00B4_01DB1F18.31788620
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MTAxNTEwMDc1MFowIwYJKoZIhvcNAQkEMRYEFK0lZ9QwZpqdXxT1mtNw
GAG45TfBMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQCXeYdq2Xj8hgDvORl4UpoWoczytjjlAcxChpSumZNHYY2OGrVPr+GLTuW78rKvvoKSDQ4m1m3A
HnzHG/ejnPWFkYG2ctqHz2Jto5ohAjW9XUeOBGOKqfuHOAQSofGNSDrPEFetBokkTKeysnC6PxOZ
Qld9zOnmHyxQhuLjAiJYnOEgjx/gNRXMlIgF2YtAnWnMknuhlnfk867vlgjdnXG6icm3isFnIfTv
0auqjO5C3oqVcU8Wm/q4pl7KI0miC4AokIIo6VeRAHZu0yNpILIzIYFw1DyLVEdhOGwT2DAR66oV
i4HIgMNLmtu7TQ8WObw0aR4n49HZGim1H9uC67MHAAAAAAAA

------=_NextPart_000_00B4_01DB1F18.31788620--

