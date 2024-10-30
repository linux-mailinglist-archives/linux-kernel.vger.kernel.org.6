Return-Path: <linux-kernel+bounces-388668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3F9B62D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F121C20F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C11E7C37;
	Wed, 30 Oct 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CN6xvgDt"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DD1DD53C;
	Wed, 30 Oct 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290702; cv=fail; b=F0Stgvy2FO06GMmi9gnpL+IZYKGVUgflmRZVcMLHmAcRYVBY8OAnXaGJ5jFXbak/q1f8GY2TxXaRTF8FwdY8rCiROfSDLLplm6Q3HqMWsBhq2dzeKqOWk0svAx68hrJvtsggWJ/R8Ju/2MACYjdkevEF+ybvXMaI76rY9cP5IEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290702; c=relaxed/simple;
	bh=xAcuBVDLRl3ha3CC/UlDVOS4/mSXu0EJCrobpq9bQ2A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpZWkDDh4UU45FW+MxS2W5eYWdctUGYx/chUCPjCIt9MFXiw5pyhB2K+46p+PCCUtdlC7TWpH++22ZTJYyABwYtoH80mZEnY7xluFbwsAzwnDv0Q1nReZ8IdK0AAbwscB4fUSf7wpRPvFQ0ToLBfzUkfvm3ZK/rJjdkx7wJRubY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=CN6xvgDt; arc=fail smtp.client-ip=40.107.104.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf8UMjRziEtAu7bQTT+jdJs8pVgR8dpkAo0LQk8qAFB5u4TpzOJYdSWebIv3WyN14QlMPOHgiIkgknEJC8JUV7DP48T6t8uu2ZPXsvj+k1HxLCRb0uUNcNtKfkHdcIyrtzEEdPZHdipEasvzzwC7NCqpTtzbiNGshf5bxZG6gtuow4mj4ylJG3QY09W2lthXf9lgFQEzVsqsUpEcMprXxWDI3UpKkmasbEwh4/I2aPqwCAbCiGD4oKsrtriyW6Tw9zy/CKghwdrVLw6txJDxpUMgzVyF3Z2/I8FlTK+gUMe72kIu0mt4+HwWcY+i8+4tK8cUMdjM7lGUdV2eUjdD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAcuBVDLRl3ha3CC/UlDVOS4/mSXu0EJCrobpq9bQ2A=;
 b=jwi/ZtkIr+VdeLsfc+iFiw9/OIExc0A0qkU/V5JamuR9dJod8rrcBTAKMl+hkvbPnjgviCxT04nZ9DOIYhxTfnI3jEOHT0yfjvxl1JrSpJCtmXCiXvl88YmGp3/p/S2f99ppe8GcwjBVqm2UVRTs8OAhM2yzkeOecPLe15G3BtcnrvYc8GAkuHSFDIaocxC7RMUNKx3rprZ2shw5+OO1/dfK41O2l5TJNypNZMC6p/ONp1kpSCbBLdcq3dJVoVloS6CNn45vXLTGutKyWY2EgeRGJXlXC+UQ1JTMzpYJdA1O7xxsqsLlOXrwoDZXJtfEb0bxRhltz+PeMoS9b5kuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAcuBVDLRl3ha3CC/UlDVOS4/mSXu0EJCrobpq9bQ2A=;
 b=CN6xvgDtxMuGLhyXyaCwafEQtj0z3mnbmaLLRbgM2me+qoeO2SaABr1jJ32Av7dJ+oLvTDP7x636PqL/CU71vrv9qd4RcP04tY92WtNkyPZojipsnv4F5HfF1Lu3NobZzYGt+XGD8CMulKLX5wdYqqv/5X12lBSUUigVZPXs740=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Wed, 30 Oct
 2024 12:18:16 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 12:18:16 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Thread-Topic: [PATCH v7 4/4] arm64: dts: ti: hummingboard-t: add overlays for
 m.2 pci-e and usb-3
Thread-Index: AQHaY0TXqy6m6Bv0g0KsvKUkI3O0eLKZBSkAgATRLQCAAB5UgIAAF7UAgAK4roA=
Date: Wed, 30 Oct 2024 12:18:15 +0000
Message-ID: <533c54e5-d024-4fd0-b92d-0f320f25999f@solid-run.com>
References: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
 <20240219-add-am64-som-v7-4-0e6e95b0a05d@solid-run.com>
 <CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com>
 <a65e17e9-0055-4e5a-902f-8ee2807a86df@ti.com>
 <299b6b75-beef-46aa-9203-b96009226677@solid-run.com>
 <cd02e760-54c6-4a92-af4e-e786d80cfbbd@ti.com>
In-Reply-To: <cd02e760-54c6-4a92-af4e-e786d80cfbbd@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAXPR04MB9280:EE_
x-ms-office365-filtering-correlation-id: a77dcb4f-defc-4609-85ae-08dcf8dceeae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjIyZEFQUi9zemE4eHBrc2g1Vm9WamJnWFRId0NPNFZ5a2pZQjVDMHlCQndW?=
 =?utf-8?B?ZzlxZlR5Z1JjRndUSmxZekVIVXNjelZIZ1JubGNvajF4bEw4NHN0NjJ2TjZr?=
 =?utf-8?B?ZTZQbUthRHU1WngzcW1ISStJZ2hFbXdhMDdPRVFzTzVzQmQwdUZhS21lQnoz?=
 =?utf-8?B?Sll2U1BkVXR6Lzh1aHlwZlJHVEZyWXZrUng1VDVHWDdrekwxZVB0L2UrUVZZ?=
 =?utf-8?B?czhTUStqMmlaQzBqTXJTWGF0eTBOSWFhS2grZm13bmJaNS9Hekg2QjcxS1Av?=
 =?utf-8?B?WDRUamwxQitid25lM2xDcEE2RzIwRndMQ2thYUx1UC96TU5WemRsZ29wVWV5?=
 =?utf-8?B?UzZVOTNIU0JZVUtNcDNmSzBXSFdRUDd1MnI4anpYZERON2o4bUhWNDRZMTdt?=
 =?utf-8?B?TTV3am91UnRkNWJuQStIRGV2R3pGV2habE11MDZKakl5RHVUbm4rcFNHcklP?=
 =?utf-8?B?OGlIZEVKZi95OG5Mb3k1UWVOVjRBSkxKcDBWZHVQMmZRclZJTmFUQnhJOGls?=
 =?utf-8?B?VGtEd2pDS0JWUDFXYkZQNzFpZ2crTmlwZkxtVWVBR2lXcVNXelNTdFhpcTVQ?=
 =?utf-8?B?QzRrMjlaWHNLVTJVVEc2em1DY25qM3RTcWUybHRYbFBKOEYxNmlnaXlraXdn?=
 =?utf-8?B?ZnJ2d0V1VUxhSlZrTGZpcDM2Tm9KME5ZT1M1b3hnRGNzOW9hcWp4ZDZEUkdn?=
 =?utf-8?B?K1AyNzd4YVIxSklKcWEwOGdQSWd0NmV4RW85L2p5aWJhMTlMM0ZNek5EUHk0?=
 =?utf-8?B?K2s0STNxZTBtWE9ISG00SGFMZXdlZDZtTzdyWlM0RW5WU2FOL2E5ekM4NFpV?=
 =?utf-8?B?aHNvSFVKY2dFeEFaeFcxVE1LR3BZYkd6K0NLMks0VVh2MjdHVy9iR2g2cUpK?=
 =?utf-8?B?bVk3SnRYeC9ZMzhqcHhjT3pESVVHQVNXOHVTZDUrMHRCTzFZS2EvVmJ0Ry9W?=
 =?utf-8?B?aXJ5dk1zUWI5WGEvbFFVU3ZJL1ZmaTVDWFBCN1RUU3pnQ3BYdTA2TUNCbU1o?=
 =?utf-8?B?enNENEhEcWpmV2FVVXBnUEVGbWZsbUYyZ3A4Tkdnc25GV2NyZGErU1A1c2o4?=
 =?utf-8?B?SFhjRXhsNnV1RnVsTGVFSmVuRWlkQUhEbGRXZ0hzSm1FcHpHYTN5Q3NjZ2V6?=
 =?utf-8?B?dmJQOHJ1NlZIUUxhTXZXeHJDKzRLQTZLRVQzd3RobDhTU2hyRXdhdTJ2Qzh0?=
 =?utf-8?B?NCtMUEVKYkg3UzY3UjNiOUtPaE9FZGFZVmhLY282c0IvNU9ETUxDRkNYMEVq?=
 =?utf-8?B?a2RUeE1IdTdwckhMWWlveVJ5UThyZ2s5YkdhNUFQdUUvZEhqdFhLNDlwZ05G?=
 =?utf-8?B?RG9uc2NXNjZnbjVDd0JLcXJpeVIrOFpiZnNmL09LT00rR0NCcWtrNm9tRUFG?=
 =?utf-8?B?UHYzVkMrbEFaRHlYbTF6dVFPdXJpN0oxL2FEcHIxNnAzdW90cEt5dTQyZ0dW?=
 =?utf-8?B?YlZNTFdWREV2NUpjaVJtV3lFOTVscUN3alI4VWdyRCtYblQxSUUvdVZ5dmxC?=
 =?utf-8?B?U0ZDU01jcURSTmFmdnc2V0ppcXk5cmpKTWN2YnMzUVBXeVAyVDBKZzduSWow?=
 =?utf-8?B?Mm80QUJDVDV6bkhHZ0Z5aUFmanRJVWtLaTZuYThyYnFud2dTUVc3ZzFVVnJp?=
 =?utf-8?B?TXhSY3J1Z3dJcjk1SEFobGZmNGp5OE1pbDlDZTk0Rnd5cG9xQmNpSURlbmJS?=
 =?utf-8?B?OURDcmd1QWNTd0ptMHRTWG90T3JpMWhQalhiU3lNVi9ycW8vdjZYKzBQOWQz?=
 =?utf-8?B?T1ZscS8vaTRRb21UQkxLRTRnWWJlL3ZmblBTWHc2NWtxWjc3MXd3YW52dnhw?=
 =?utf-8?Q?sEYho7Ljij5++STPwKUhYqRa8Zt9C2RA6i/Xg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGtvMVA3UE1OTmxGL1llMWIrMFl0cUg0NlZCYWk0VjBycElZL1V3dlA3TGJr?=
 =?utf-8?B?Y3pXS1AweEpneTdySUQ5SzJpVDFvSmpibFhuY1dEdlJQdnBDQUkvVkVOVjll?=
 =?utf-8?B?OGNtQVdoOWtuUklrMTJTelNiUjlyQ3JnbFpxbUMyYVRjcG03a0dPekRJc3lp?=
 =?utf-8?B?amRIYWFGKzlUNDZWSlNHU09wZ21xdytFYiswaVl1U2Fxa3AxMjZybmtLbzVW?=
 =?utf-8?B?dDRVbnRUN1RrSExzVldBNS84TlcvbFNCakJkaVVFZHROdTd1ejFtdzNSbHJ0?=
 =?utf-8?B?VkVXU3hTQitqNmhUSVhFTG1tR3JtemNEZnY3MmVaNVhZWTk3eFo5UDV3MnFS?=
 =?utf-8?B?YVNGMUpsd3RNV0JnbitqUGlTQmVxNUIwalU4bkJBVnp5SEJRc01KalRFamlB?=
 =?utf-8?B?YjUvdDVTMFA2c0lVZmhLVzhJOGEvYlBpdDlJK3Q5azRpQ1BhMGNNMzNoeS9o?=
 =?utf-8?B?bkhpbVVxdUNQNGZpcnpPTDN5b3hoN3VMaDV3bmhFai94dDJXblV0dkJXdmlK?=
 =?utf-8?B?VmYrRWwxSkFQQy9FSGdGcDdWTWZvdHZGb3NXZjFTZ3JYL205b2ZiRlhoaFN3?=
 =?utf-8?B?RGNvNGF0S1pGMDcvRElMWks1UWo3dWZQYUJCKzhKUnM2OXM5STZBRXVzN0R1?=
 =?utf-8?B?SEhMWEwvMHhLNlNLNCtVcVVYU2l6WGFvZXR0Z3g4TjhJRFlxc29kZDkyUndO?=
 =?utf-8?B?akZCcG9TTWM0ZGxFQUNrMnZzWDZ2aThDK3BGZ3JyOFBGaFhBbTNvbG9XMHlq?=
 =?utf-8?B?T0F4ZEVUMVA0TUdDZ1Q0eUtpSlZWSDhQSm1IMjMrS0VoaEt4dnEvaEJoOXFX?=
 =?utf-8?B?R2dYUDFNQVdmT0NHaGlsUTdMQUJEVEN5bk1KWUpvUm9TSFd0b2psNDBGUHc5?=
 =?utf-8?B?aVlrYzNJMXFnZUVOQUdtMUJtVURmTmpEU3BvMmdjclh5TkxwT0s0V2ZPSXZS?=
 =?utf-8?B?a1lsZUNnMnJncVJYa0tpV1hqV05vQ1h6NnVLOEJ3ZHFyUjlySzhQTUYwbkhE?=
 =?utf-8?B?amU2aldRU0pldjIwa0F3Mlowak1YUHFTR2VlWUxIQ2VtUVlwM3krb2JoM1pH?=
 =?utf-8?B?cklydmJTaU5iM2oveVY0OE5pYjFhdlI2MUVyWWFPSUl5dHI4dFZYNktHdjVK?=
 =?utf-8?B?bjA3RDBtZXYyTlJZeUo1ajNTc09TRi80em0zZHlCZmlRSkdvZmRISUhTaHFz?=
 =?utf-8?B?Rk4raE5MUXpFVjJvRDJMOE0zVVI5NTdBSVNRczhMOHRJNUVOcDlrUkdxUlht?=
 =?utf-8?B?MWRaMGxJSkYxUktONTBJb1l1TW0yOGhrbmV4bTJJbW5jMTZrQjQ5T3lYc0N3?=
 =?utf-8?B?TDQzUGFLZU8zRHRTZ2dtWlQ5ZEFkR01kYkY1d210UGN4L0lLL2pVTEhmaTcv?=
 =?utf-8?B?S2pPNmlRcnhPRkcvbzdvSWRPdVBPSWpvY2ZGcTgvY01ZWGhXUUlhQUFySmFN?=
 =?utf-8?B?bEJuRHFRMy96VStxbzVpRzl1NndGQnpYcEpmNDlEQ0Y1QkVqWlhhd0JmWmQ0?=
 =?utf-8?B?RlV3aE5KcnpZU3ArZHlkZmNNVGhTK1UyN1czZEliZkFaQ2tNM3RCL3p2TURP?=
 =?utf-8?B?VVJtdXh2WlAxWXZQRERjOXVoY0plMmRpSE93WC9sY0ZEbDhFaW9NS2djVHVH?=
 =?utf-8?B?ZGNQYnJXZVMyZUVsOENna05US0ZkZGNUK3hTM3FQOWdxVVh2elJsbXdaMVQ5?=
 =?utf-8?B?TUFBRWx4bUlRTklqZ3FzNWd4cm1iOG91bkNOY1BpaWxkbHIvRWpqZUdXTWp2?=
 =?utf-8?B?WFRFY21ZQXhvd0dvekh6VWxuMlp0RUFuRWNRS2RZT3hJTWpmcFA1dzl0WlB4?=
 =?utf-8?B?b1hKYjNyT0docjR5M05NWWxLTzdXcVNXcTlFTjVJbEcwK1o5VHdLa3RaeHh1?=
 =?utf-8?B?ZjBtZi9vL0J4Q2RrVi90cFhBall2aVRpZ1hLKzR1dUZmSmxvMnRhTDM2TjJH?=
 =?utf-8?B?c2FOYVJKalRyMldTeXFGNFczanN4ZnBHUWJYUlkzVTdXbncwOHFrbnpUMDA3?=
 =?utf-8?B?UjhOTUh6R2FvQjcybVdCVG9sYWp6WGNFTlQzNlJiL3JEMFhSaGZuVVBRL25x?=
 =?utf-8?B?TUtOc2ZGekp1Z2I2QkNNc29ydUl5bVhMaVBLSStyRy90a1p6RmVkUlR0SGhv?=
 =?utf-8?Q?CSkw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4F9E6501789904FAF0B71BF0FFB2CCC@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a77dcb4f-defc-4609-85ae-08dcf8dceeae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 12:18:16.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5sSUJ1pI+SS2K9bnUU6iRJmunuYaqVdyDiq23s+ZfA1pZdNUL4kLQ6o8uYK8hBiotUMgj5toPWhKVth++xzPag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280

QW0gMjguMTAuMjQgdW0gMTk6NDQgc2NocmllYiBWaWduZXNoIFJhZ2hhdmVuZHJhOg0KPg0KPiBP
biAyOC8xMC8yNCAyMjo0OSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBIaSBHZWVydCwgVmlnbmVz
aCwNCj4+DQo+PiBBbSAyOC4xMC4yNCB1bSAxNjozMSBzY2hyaWViIFZpZ25lc2ggUmFnaGF2ZW5k
cmE6DQo+Pj4gT24gMjUvMTAvMjQgMTk6MjcsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4+
Pj4gSGkgSm9zdWEsDQo+Pj4+DQo+Pj4+IE9uIE1vbiwgRmViIDE5LCAyMDI0IGF0IDQ6MDXigK9Q
TSBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4gd3JvdGU6DQo+Pj4+PiBIdW1taW5n
Qm9hcmQtVCBmZWF0dXJlcyB0d28gTS4yIGNvbm5lY3RvcnMgbGFiZWxlZCAiTTEiIGFuZCAiTTIi
Lg0KPj4+Pj4gVGhlIHNpbmdsZSBTZXJEZXMgbGFuZSBvZiB0aGUgU29DIGNhbiBiZSByb3V0ZWQg
dG8gZWl0aGVyIE0xIHBjaS1lDQo+Pj4+PiBzaWduYWxzLCBvciBNMiB1c2ItMyBzaWduYWxzIGJ5
IGEgZ3Bpby1jb250cm9sbGVkIG11eC4NCj4+Pj4+DQo+Pj4+PiBBZGQgb3ZlcmxheXMgZm9yIGVh
Y2ggY29uZmlndXJhdGlvbi4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXll
ciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+Pj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLCB3aGlj
aCBpcyBub3cgY29tbWl0IGJiZWY0MjA4NGNjMTcwY2IgKCJhcm02NDoNCj4+Pj4gZHRzOiB0aTog
aHVtbWluZ2JvYXJkLXQ6IGFkZCBvdmVybGF5cyBmb3IgbS4yIHBjaS1lIGFuZCB1c2ItMyIpIGlu
IHY2LjkuDQo+Pj4+DQo+Pj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+PiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL3RpL2szLWFtNjQyLWh1bW1pbmdib2FyZC10LXVzYjMuZHRzbw0KPj4+Pj4gQEAg
LTAsMCArMSw0NCBAQA0KPj4+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
Kw0KPj4+Pj4gKy8qDQo+Pj4+PiArICogQ29weXJpZ2h0IChDKSAyMDIzIEpvc3VhIE1heWVyIDxq
b3N1YUBzb2xpZC1ydW4uY29tPg0KPj4+Pj4gKyAqDQo+Pj4+PiArICogT3ZlcmxheSBmb3IgU29s
aWRSdW4gQU02NDIgSHVtbWluZ0JvYXJkLVQgdG8gZW5hYmxlIFVTQi0zLjEuDQo+Pj4+PiArICov
DQo+Pj4+PiArDQo+Pj4+PiArL2R0cy12MS87DQo+Pj4+PiArL3BsdWdpbi87DQo+Pj4+PiArDQo+
Pj4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BoeS9waHkuaD4NCj4+Pj4+ICsNCj4+Pj4+ICsj
aW5jbHVkZSAiazMtc2VyZGVzLmgiDQo+Pj4+PiArDQo+Pj4+PiArJnNlcmRlczAgew0KPj4+Pj4g
KyAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+Pj4+ICsgICAgICAgI3NpemUtY2VsbHMg
PSA8MD47DQo+Pj4+PiArDQo+Pj4+PiArICAgICAgIHNlcmRlczBfbGluazogcGh5QDAgew0KPj4+
Pj4gKyAgICAgICAgICAgICAgIHJlZyA9IDwwPjsNCj4+Pj4+ICsgICAgICAgICAgICAgICBjZG5z
LG51bS1sYW5lcyA9IDwxPjsNCj4+Pj4+ICsgICAgICAgICAgICAgICBjZG5zLHBoeS10eXBlID0g
PFBIWV9UWVBFX1VTQjM+Ow0KPj4+Pj4gKyAgICAgICAgICAgICAgICNwaHktY2VsbHMgPSA8MD47
DQo+Pj4+PiArICAgICAgICAgICAgICAgcmVzZXRzID0gPCZzZXJkZXNfd2l6MCAxPjsNCj4+Pj4+
ICsgICAgICAgfTsNCj4+Pj4+ICt9Ow0KPj4+Pj4gKw0KPj4+Pj4gKyZzZXJkZXNfbG5fY3RybCB7
DQo+Pj4+PiArICAgICAgIGlkbGUtc3RhdGVzID0gPEFNNjRfU0VSREVTMF9MQU5FMF9VU0I+Ow0K
Pj4+Pj4gK307DQo+Pj4+PiArDQo+Pj4+PiArJnNlcmRlc19tdXggew0KPj4+Pj4gKyAgICAgICBp
ZGxlLXN0YXRlID0gPDA+Ow0KPj4+Pj4gK307DQo+Pj4+PiArDQo+Pj4+PiArJnVzYnNzMCB7DQo+
Pj4+PiArICAgICAgIC9kZWxldGUtcHJvcGVydHkvIHRpLHVzYjItb25seTsNCj4+Pj4gL2RlbGV0
ZS1wcm9wZXJ0eS8gKGFuZCAvZGVsZXRlLW5vZGUvKSB0byBkZWxldGUgc29tZXRoaW5nIGluIHRo
ZSBiYXNlIERUUw0KPj4+PiBkb2VzIG5vdCB3b3JrLg0KPj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IGZsYWdzIGFyZSBlcXVpdmFsZW50IHRvIGJvb2xlYW4sIGkuZToNCj4+DQo+PiB0aSx1c2Iy
LW9ubHkgPSA8dHJ1ZT47DQo+PiB0aSx1c2IyLW9ubHk7DQo+Pg0KPj4gYXJlIGVxdWl2YWxlbnQu
DQo+Pg0KPj4gSWYgc28sIGNhbiB3ZSBhc3NpZ24gPGZhbHNlPiB3aXRoaW4gdGhlIG92ZXJsYXk/
DQo+Pg0KPj4+IEdlZXJ0LA0KPj4+DQo+Pj4gVGhhbmtzIGZvciB0aGUgY2F0Y2hpbmcNCj4+IEV4
Y2VsbGVudCBzcG90dGluZyBpbmRlZWQuDQo+PiBJIG5vdGljZWQgdGhpcyBpbiBwYXNzaW5nIGFi
b3V0IGEgd2VlayBhZ28gd2hlbiBJIHJlcXVlc3RlZA0KPj4gRGViaWFuIGVuYWJsZSB0aGUgbmVj
ZXNzYXJ5IGRyaXZlcnMgaW4gdGhlaXIgZGlzdHJvIGtlcm5lbA0KPj4gKHdpdGhvdXQgdW5kZXJz
dGFuZGluZyB0aGUgcm9vdCBjYXVzZSkuDQo+Pj4gSm9zaHVhLA0KPj4+DQo+Pj4gVGhpcyBvdmVy
bGF5IGlzIHByZXR0eSB1c2VsZXNzIGluIGxpZ2h0IG9mIGFib3ZlIGlzc3VlLiAgSSBpbnRlbmQg
dG8NCj4+PiBqdXN0IGRyb3AgdGhpcyBmaWxlIHVubGVzcyB5b3UgY29udmluY2UgbWUgb3RoZXJ3
aXNlPw0KPj4+DQo+PiBJIHdvdWxkIHJlYWxseSBwcmVmZXIgdG8gZml4IGl0LCBvciBzb21laG93
IHJlcGxhY2Ugd2l0aCBlcXVpdmFsZW50IGZ1bmN0aW9uYWxpdHkuDQo+Pg0KPj4gTXkgb3JpZ2lu
YWwgcHJvcG9zYWwgd2FzIGhhdmluZyB0aGUgYm9hcmQgYSBkdHNpLCBhbmQgdGhlIHBjaSBhbmQg
dXNiMw0KPj4gdmFyaWFudHMgYXMgc3RhbmRhbG9uZSBkdHMuDQo+Pg0KPg0KPiBZZWFoLCB5b3Ug
d291bGQgbmVlZCBhIHNlcGFyYXRlIGJvYXJkIGR0cyBmb3IgdGhpcyBwcm9maWxlLiBQbGVhc2UN
Cj4gcHJvcG9zZSBhIHBhdGNoDQpJcyB0aGVyZSBhbnkgY2hhbmNlIG9mIHJlYXNzaWduaW5nIDxm
YWxzZT4gYW5kIG1ha2luZyBhbiBhcmd1bWVudA0KdGhhdCB0aGlzIHNob3VsZCBiZSBmaXhlZD8N
Cg0KSSBmaW5kIGl0IGZydXN0cmF0aW5nIHRoYXQgb3ZlcmxheXMgY2FuJ3Qgb3ZlcnJpZGUgYm9v
bGVhbiBwcm9wZXJ0aWVzLA0KYW5kIGZvciBjb25zaXN0ZW5jeSByZWFzb25zIEkgd291bGQgb3Ro
ZXJ3aXNlIGNoYW5nZSBib3RoDQpwY2llIGFuZCB1c2IzIG92ZXJsYXlzIHRvIHN0YW5kYWxvbmUg
ZHRzLg0KDQo=

