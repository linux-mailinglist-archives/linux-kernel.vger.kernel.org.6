Return-Path: <linux-kernel+bounces-291538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8399563D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95426B20FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B476E1553A7;
	Mon, 19 Aug 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="DnEsYj+w"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8414AD23;
	Mon, 19 Aug 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724049760; cv=fail; b=A87BEkvAHrmAwtM523+IANQN4zOYVYFR+b9BIfBQjtHx4eNsYAgxn1DI0yndqHMKlevwG0QAzFSYCfqs0Fsf09WpCz1G2GKJLuaK/UHBD8c8uZGU0hiNZxLPJ3o1qaHZAKt/fX0NsP32rBSrqrFvxhSM1b8h/r0lWKt8aiWOfBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724049760; c=relaxed/simple;
	bh=pItojlGHoCOE2zIAbfbaeryH/Z0R2UTkeNY+FY1sXPI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HgQpE1FE10sjZEXAa8kfnQG/I0EpKryRTQ/FpcWREFOfTqGZ8EQdT25XcsD77WAHh3D6/LUf5WpbDnUXQl+gPg8tyim3PZL3XqYEZLyr0GO6jOZIMxEcohNba2H0AfHq29ZEJlqJNltRJ1qrw12HgNwtuPSDzM+1/19ynCsC4b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=DnEsYj+w; arc=fail smtp.client-ip=40.107.117.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7qV5rXqJ/GGa030IxU6xx8Zd8VJnjDg962YHcK6zXoeyZkw72XL5XTdBcOn9oGpCTzGjzf3JGyjYj+r4P+yPR/xOEOouIZONFJdDY6gO50mBvPu3wBpGMun3qOuX1vJmJAz/iFPP98DXOuX7fJWc8EWefZ3qr3QTCVHcGrJw4b1/sk1TnJJpZ7K8fSX76V3yHCYXRUdn1j5E2AIafYbPOTom+VTAxCc7GSHZOVgIRwcd0ApOGqT1AGPE2TVh3a0ZjKjrMAhkykODoCWIu4m8ObZXpd+x0186/Vxal8hKTCUI5CebPGJl0kugM9QzHoe7HXnUVqZ84HANS4Q7yx2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pItojlGHoCOE2zIAbfbaeryH/Z0R2UTkeNY+FY1sXPI=;
 b=pn5c3tJVJZBwSgjS5CnpmiXXEqvLMjBRVSipTS8JB8+ciNfCY1EvtaqtmFPnEeQM7oSnvV+Vf920Xg/Gv95WdaceDxEIxjsuTqvQxLSACGSeP6dtlpd4iXYXkw4JwuJzLys3qVS8spZ+6QTt6D+c+xCapWMegKzO+LcoNVIFGzv0EWdHnrf0KxTTKMpp+Qqcz4F3bPtQ7wZPEXLa0qlTK0ppWJ4yIk0xKm0WtkEkt4zfv2p91cYX5LguqYmgpOksQ0DWuxlgzhG2H0l1NLrfIcqjVrzR6lPwUp28oUILjEhsDFUczJt43jdL/hgLFWZ4AHH2biyQeT4mWyznymgNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pItojlGHoCOE2zIAbfbaeryH/Z0R2UTkeNY+FY1sXPI=;
 b=DnEsYj+wsJ2NG36+br6FZhylTbwE0saKIk3qGz/Y8iv3WTj9QnhRL0TkBeSD5Hkgr9PIVAw/nCTLf6x1ZCLGCAiUd4XgJzdfauc34hjElAWAVeAIdC+SXFFI1555+7Oh9Rd2V8iJw4mqtlw5+6J53PcQ7rVJMBIt5w3uUD676jyEVB34x0ZQ17tHEtozRKP9IZk/mriPvN3iuGFJW8sYLFxvqXikvr/mkGOMKuYYrfTd+12ip18VEI0INN3cFjfEOIUGGrC6a4Y2FPfyaKRxcR/UeDBi/Bsm/yqu50vPLoLlqf1NvJRRj9kXCCpsoP/r5ZMwK13zJb4xYIId+cjJeg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SI2PR06MB5314.apcprd06.prod.outlook.com (2603:1096:4:1e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 19 Aug
 2024 06:42:31 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:42:31 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Topic: [PATCH 3/4] dt-bindings: clock: Add AST2700 clock bindings
Thread-Index:
 AQHa6WjvtGERsBjdbUe0s1M0hUJcKbIdCjAAgAFhFjCAAAaDgIAABO+QgATIDfCAAA4pgIAAAYwQgAACfgCAAASXwIAADl8ggAAEbQCAAQrHAIAARMOAgAlsyPCAAALngIAACqaQ
Date: Mon, 19 Aug 2024 06:42:30 +0000
Message-ID:
 <OS8PR06MB7541672B4F9BCAA37E0D4005F28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
 <OS8PR06MB75413728F0FCEE022B4B4F5BF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <eec21668-3674-40c6-b443-90c7c02262e3@kernel.org>
 <OS8PR06MB7541CA018C86E262F826B9E5F2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB7541B0D9A43B989DC1738F68F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5081c41b-dfbd-49ad-a993-b983d4c339f0@kernel.org>
 <OS8PR06MB7541196D3058904998820CFFF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <9465f8c0-5270-46df-af4b-e9ee78db63d1@kernel.org>
 <OS8PR06MB7541CC40B6B8877B2656182CF2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <OS8PR06MB75415EC7A912DBD4D21A0035F2852@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <e3733148-142c-40a1-b250-4502e8726f0c@kernel.org>
 <OS8PR06MB7541D5AB85D8E44E89389BC3F2862@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <26988bcd-4d58-4100-b89c-00e8ef879329@kernel.org>
 <OS8PR06MB7541A7E690A2D72BA671622EF28C2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <929c322e-7385-48da-b925-7f363cf5b6f7@kernel.org>
In-Reply-To: <929c322e-7385-48da-b925-7f363cf5b6f7@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SI2PR06MB5314:EE_
x-ms-office365-filtering-correlation-id: 7239b24d-eb3a-4ecf-7b96-08dcc01a198a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjZzUU1Sb09UenpFVXd4UUt6UFpOWk1ydHhYKytpNEZsdXBHWFdqa1BWT0Vj?=
 =?utf-8?B?RFBWTVJkdldRRExNNGZFWHZMODRjRFhNYzBKb0E3cXI5ekJSSjUvZ0ZYc2lq?=
 =?utf-8?B?bjF2WVY1Qkw1UUtMM2lSZmUxcnBjUm9yYWVTMXZVUjdsMTNGcUgxZHZJT1JE?=
 =?utf-8?B?QlhhNnRjbmk3S0UyMTVSamx2bEQrdjNra2VhbXJMUzJVejU2WFgzR1dwTlRv?=
 =?utf-8?B?OTNjeGtWQ20rSTB5dmhQclh4YklMWEtjekNHQ0QxU3VxVVNvbTI3U3B3WXA4?=
 =?utf-8?B?ekhyWHVjQXg3NHRLendSYStvNXN6bHh5RTlmdi8yMXN3dlB0MS9IenRrWkxr?=
 =?utf-8?B?ekJ1TDJKMnBGYjFNWFZ0bm1oVkUxQU5TcVRVNC9FVnBVeHVuMEsvWFNhTm5K?=
 =?utf-8?B?czZtdEVsVWNKY1YrZ1FiUldGaDF2Y3dpRnFFT0p1SWI5bVFmNnNQYzJRMTFp?=
 =?utf-8?B?OENxTUlUb2xyVC9LVVh0bTVSR1RlTEZ3UzZITzlFYUhGdlBYWElMS1JvM2tw?=
 =?utf-8?B?dkYwRG8vdERkV0tVa3U3TzlkSUd6dTc1ZEpuTDJHckpaVlhRQ2lWOXgyOHEr?=
 =?utf-8?B?QmhwVkU1OFdyMW1xWFJxSXhSMStYSWtzVTRuUmFlQmRoMmdDbDRSMkQwVWg4?=
 =?utf-8?B?bGlVRGpQTmxBZkhvVDlKb1FjSzlqdHJDbEs4eGhhMFFwdTB6RzcrYU91aGR4?=
 =?utf-8?B?VXcraW9mV2ZacEdnRVhNLzNlSThsNDFVU2l3Nk1NVjhOQmttK0dRcWZkQVJW?=
 =?utf-8?B?TDlIMC9Oa0RhUE9ZNVJCZi9PYnd6ajlvcXJxKzZnQmZGT2E3SjJubVVYNjV5?=
 =?utf-8?B?YTJTYXJVOXJiZjVBWHVxMXE0WVpBNmhqOGdIdFREaFh2OTQyS1NQeXZyUnBS?=
 =?utf-8?B?R3laaktVSVQvT1VmVW9xVTJxbDJjZi9MdzlzZUR1ZlZFY05ITVhYUEpoYTZY?=
 =?utf-8?B?Vms1RTB4Zjl0UGxDSkZZUEVONndOMllwZ2RXSXZFeFRmRGpwUkxycXAzYWZp?=
 =?utf-8?B?K3Avd0xUTURJMkN5bm5jTTBhZHpCVmRJdml6ekhmSWVpb1ZKR2E3a0RMYXRJ?=
 =?utf-8?B?ek15RGRsZ0ZvbmNSTm40Ti9kbVBmZ2tkVFg3ZU5VRFNUM2NkcTdOVmZTZlNy?=
 =?utf-8?B?U2Z6cDdKQUJGbzJwaDlhd3N6cE54N1ZTWUhZYWxucHRQMnlQSHVsbitRcVdo?=
 =?utf-8?B?KzR0a0pJS3lpS1g0UE5TQk1PaTJkN2xZN3dqTFdDMEFDYkM1VGZ2TTl5dEN2?=
 =?utf-8?B?KzA4UmV3eTFROWFRMUorQkExY01mRFFxZGhHU0tiSVRjdG1ocjA3Qm1FVjlu?=
 =?utf-8?B?dnByalZrcUp0aldTZVhYSm9HTVBKMkRPeDZhZm1haWhhSUhWdGc1MVpjTjd0?=
 =?utf-8?B?akRnWUlUZm1tY1JzSVdPckJLSWlZMjFEeW5hRkkxak02UUZhMkFKd1lRL2J2?=
 =?utf-8?B?eWc4dmRlSmlKd1NsWVQrKzh0aTB3Z2d1djF3VXEvK29abGdTeDJteVQra2pG?=
 =?utf-8?B?ZDVsUm9SbnlwVEdqd1BVUHU4cjRvdmw4WFZhOTRLSDJqelorTklQSGdpOUl1?=
 =?utf-8?B?QkxjWVE2SGNYNW1OQ1ZzMDVYUktwSW9vUFR3ZWNoNjRFcm5pWVJpcVBock13?=
 =?utf-8?B?Ym04RERYRjZEZEJpRmVKbS9SdDlBZXhaelRMbVJmc0pWY2VKRy9vd2x3RGhS?=
 =?utf-8?B?RXR2RmxCMExDb3hVYmkyVmdTZlQybWJQc1VLZy9ZTlJWVlgyRkhXcU5JaGFr?=
 =?utf-8?B?ajM0L0J5VzQxWDUwM3lGNGRxTkw1NllwT2QwQlkrY0ZBNTBmRzQrOVNHZHRo?=
 =?utf-8?B?WHNCMDJUdmlrSmRMTkdLS3ViWnE4T2tPaU9DRkYvOTlCc2dmU3JLVUpSWlBS?=
 =?utf-8?Q?baWj8bBdhBx8D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WERaOHh6TlR5d1R6Zm1RYldWVDhZdU9IOExVc3R1WG1BVjVWSjJaNmRYdVcv?=
 =?utf-8?B?aE5mWXE0azAzREVnc1dURWtJcUZwenByQWlWcjFPQnVyNG93bm55OXJpMUJ3?=
 =?utf-8?B?RlhaN2pXcEc2d1BXdkw1a2NwNzhqbXNRSnJBRHVpUHBBVTJLTmJBYWttYmVt?=
 =?utf-8?B?MGdhTktoYXN5cllWNjZ3S04vWUdyL2dCUWZlQWc5b1Rsc1lvT3RnNDZVbGY1?=
 =?utf-8?B?d1FKN0laTThnSnRBUUJZbWttVUhnTTU5UldIOE9QcXJUOXdBcHZ3SG00d3Zz?=
 =?utf-8?B?RXZPdUNXYlF1NGt5N1FuQnNCV2pPdmtjV0VIL09KRHJDRFAxN1dJZUo5cXBk?=
 =?utf-8?B?MFE2L2dWRmxoYVhLY2lkRUw5a0VhZFlLSVBOMVZDdllkYy83NHh4Yko1UWEy?=
 =?utf-8?B?T2lSUUk5UVJVYjZCdTYwdWQrZVUxaDllYnRpZnFRc2paQzdtRUorOTA1Tk5j?=
 =?utf-8?B?YWxCQVNRYVZDWFFaN2pjanh5VmgrS1ZzY085M21BYXFXQzUrcFJpUVdERXdB?=
 =?utf-8?B?Q2xwenRwSWowSjEvdUgvUE42eWhNaTBpZTVDMUp3aEZIRWswTmc0V0VHaWRT?=
 =?utf-8?B?Y0c5S2F5MnZWNTRMRUpxMDZnVFBZSWlVT3ZJTFNpdDYzano1MEZORjcvTDB6?=
 =?utf-8?B?NGJDVVVVRituYXN4cEoxMkxpcWUycEw0aDRZb2UxOGV0bHJURG5MNFdVM1Bn?=
 =?utf-8?B?S2thRmJoanZBc0QzanRwWDRCR3V3Q2c3OTN0ekRTNlltcnZKRHR0Uk1leGRt?=
 =?utf-8?B?S0x3bVZMRWZ2bkgrVHBjMmRvVlVpYktZY2dwOUZpS1FPOEFuWXBFYnB6R0oz?=
 =?utf-8?B?UFFTMy9SOXdaQXJpMVFxVnRhY0JNTHRvQWg2T2Y3dzJTK0hqRFdobHcxV0Jl?=
 =?utf-8?B?ZkFNUUZwN2JzK1lzcWgzR0xRZFB3a25RM2tVcklLWmVLaDB0NG55VzVreE1o?=
 =?utf-8?B?cGlyN200c09ib0lvZlBhWTV5NUpJL05qaXhidHFCeis5MHB4RUNob0VzMW4r?=
 =?utf-8?B?VWdVZG1VYjl6ejN2RWF0K0ZicERuUVdRV0p3QUVYNFB2eGMyM0FZRWVWdXNS?=
 =?utf-8?B?V1I1eEVHSkhzL2hONEU4RzE5UUh3UG5NRnBWRG9reVdlS1ZSTWRub1pEemhl?=
 =?utf-8?B?QzB1c1Z6K3A0MDFwU3hQMnA4L3V1Ui9iMndQZzVtdmNJQ3pobUF2ZUpjWjhT?=
 =?utf-8?B?TXFhczNIZG4yR0loWW1zMDhHbitDL0EzUkdnRXJhRTNEeEtLbVQxSG1XbW9P?=
 =?utf-8?B?WnJPei9XZThVdXM0WVM4VTBtaEV0elpBc0RFZDJaVGM4NThsNkpyMEFrNkwr?=
 =?utf-8?B?QXRFOXNRNVc3aTdyS3Q4N1lNVGwzWW9WSXJMNWtPQzBEdUova3N2c1ZtclNm?=
 =?utf-8?B?RmwwaDhvN0s3YkJLbTlwcUdNY2lVcXFHbDd3WWg1KzJhR3IraVd6Q25Dc2Yv?=
 =?utf-8?B?V1o2TFFTVVhUeXUxUWc3dE8xYUVtdk0zdmltTkRySDlKS1FSMlFMZ0pobFEz?=
 =?utf-8?B?SGo3QjBabGJrMzBpeDJTMjh0SkNEeW4wZ284eDJ4RUdtMmlJb3VRWHpmV2Qz?=
 =?utf-8?B?YjZVMS93eGFFSlhqc2Jtdk9rU3Y5MzdiY3RnVWVQdmhZNVZ5WndVcXRCNEFU?=
 =?utf-8?B?OFN5SUNoQWZ6eTZ2R3NiakhlWDJNN1FlVm5WMFNia3FPUXBScjkvVzVhV3VZ?=
 =?utf-8?B?ZHV3TytFYUxlVDYvcVJ5SWhYWTVVcHh3U0ZFYjdXd0RXNlhtOERzNHNXNG5a?=
 =?utf-8?B?NWNmRk5VVHl0eENJVkpsbEFPK2FxdEhLNXBSaW1KbzdjMEMvV0pKcVVOWmNM?=
 =?utf-8?B?SHozbGpFNktoYm1TYXBackRKVEUzYkVtL1JtVGpQdlM0Z081bjFpcVpOdXZI?=
 =?utf-8?B?bTZRbjg5dDRmTE1SSmFRSnVtbU9tUGFLckFIRHVNcHMzdFArT2E5SGlWUEtF?=
 =?utf-8?B?Mk1KZ05JKzd0b2hHSkFndnQ4VEJBTnpDanU0ajI5T3puTlBGbDFKak5nUnB4?=
 =?utf-8?B?Mk0xbnRGTXFQM1hoRmVrMVlmRFY3UmxpQzFCdFdPRmNldjlZK2F3REFkSW1X?=
 =?utf-8?B?TWJKaE52U2pQaE9FU01BZG8xY093cjFEeGFjRWJPRVRjNDkveGJOM3ptemxN?=
 =?utf-8?Q?fu5ajyUdXAV0tE9sMYOCJDWBX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7239b24d-eb3a-4ecf-7b96-08dcc01a198a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 06:42:30.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boXIm4HrrRJ9OVdYxMPtCG3fpq2xkd2/Rx687SG7Mpj+NLyhizdQ+sfVVv53iJshdHRqzD75EoJB+9h3CWwiB7jiKwfu2BbrgUFSwyjNoL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5314

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBBZGQgQVNUMjcw
MCBjbG9jayBiaW5kaW5ncw0KPiANCj4gT24gMTkvMDgvMjAyNCAwNzo1NSwgUnlhbiBDaGVuIHdy
b3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IGNsb2NrOiBB
ZGQgQVNUMjcwMCBjbG9jaw0KPiA+PiBiaW5kaW5ncw0KPiA+Pg0KPiA+PiBPbiAxMy8wOC8yMDI0
IDAzOjUzLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4+Pj4gRHJvcCB0aGUgZGVmaW5lIGZvciBudW1i
ZXIgb2YgY2xvY2tzIGZyb20gdGhlIGhlYWRlciwgYmVjYXVzZSBpdCBpcw0KPiA+Pj4+IG5vdCBh
DQo+ID4+DQo+ID4+ICpOVU1CRVIgT0YgQ0xPQ0tTKg0KPiA+Pg0KPiA+Pj4+IGJpbmRpbmcuIFlv
dSBjYW4gcHV0IGl0IGluIHRoZSBkcml2ZXIgb3Igbm90LCBJIGRvbid0IGNhcmUgYW5kIGRvDQo+
ID4+Pj4gbm90IHByb3ZpZGUgZ3VpZGFuY2Ugb24gdGhpcyBiZWNhdXNlIEkgZG9uJ3Qga25vdyBp
ZiBpdCBtYWtlcyBzZW5zZSBhdCBhbGwuDQo+ID4+Pj4gV2hhdCBJIGtub3cgaXMgdGhhdCBudW1i
ZXIgb2YgY2xvY2tzIGlzIG5vdCByZWxhdGVkIHRvIGJpbmRpbmcuIEl0DQo+ID4+Pj4gaXMgbm90
IG5lZWRlZA0KPiA+Pg0KPiA+PiAqTlVNQkVSIE9GIENMT0NLUyoNCj4gPj4NCj4gPj4+PiBpbiB0
aGUgYmluZGluZywgZWl0aGVyLg0KPiA+Pj4NCj4gPj4+IFNvcnJ5LCBJIGFtIGNvbmZ1c2VkLg0K
PiA+Pj4gaWYgeW91IHRoaW5rIHRoYXQgbnVtYmVyIG9mIGNsb2NrcyBpcyBub3QgcmVsYXRlZCB0
byBiaW5kaW5nLg0KPiA+Pg0KPiA+PiAqTlVNQkVSIE9GIENMT0NLUyoNCj4gPj4NCj4gPj4+IEhv
dyBkdHNpIGNsYWltIGZvciBjbGs/DQo+ID4+PiBGb3IgZXhhbXBsZSBpbiBkdHNpLg0KPiA+Pj4g
aW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmg+DQo+ID4+PiB1
c2IzYmhwOiB1c2IzYmhwIHsNCj4gPj4+IC4uLi4NCj4gPj4+IGNsb2NrcyA9IDwmc3lzY29uMCBT
Q1UwX0NMS19HQVRFX1BPUlRBVVNCPjsNCj4gPj4NCj4gPj4gQW5kIHdoZXJlIGlzICpOVU1CRVIg
T0YgQ0xPQ0tTKiBoZXJlPyBJIGRvbid0IHNlZSBhbnkgcHJvYmxlbS4gTm8NCj4gPj4gdXNlbGVz
cyBTQ1UwX0NMS19HQVRFX05VTSBkZWZpbmUgaGVyZS4NCj4gPj4NCj4gPiBVbmRlcnN0b29kIG5v
dywgSSB3aWxsIHJlbW92ZSB0aG9zZSAqTlVNQkVSIE9GIENMT0NLUyouDQo+ID4gQW5kIHdpbGwg
cmVwbGFjZSB0bw0KPiA+ICNkZWZpbmUgU0NVMF9DTEtfRU5EICAzNA0KPiANCj4gTkFLLCBpdCdz
IGxpa2UgeW91IGtlZXAgaWdub3JpbmcgbXkgY29tbWVudHMgZW50aXJlbHkuIEV2ZW4gaWYgeW91
IGNhbGwgaXQNCj4gIlNDVTBfQ0xLX05PVF9FTkQiIGl0IGRvZXMgbm90IGNoYW5nZS4gRG8geW91
IHVuZGVyc3RhbmQgdGhhdCBpdCBpcyBub3QNCj4gYWJvdXQgbmFtZT8gUmVhZCBteSBmaXJzdCBj
b21tZW50Lg0KPiANCj4gPg0KPiA+IFJlZmVyOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9ibG9iL21hc3Rlci9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2MNCj4gPiBrL2lt
eDgtY2xvY2suaCNMODcNCj4gDQo+IFNvIHlvdSBmb3VuZCBhIGJ1ZyBhbmQgdGhpcyBhbGxvd3Mg
eW91IHRvIGNyZWF0ZSB0aGUgc2FtZSBidWc/DQo+IA0KU29ycnksIEkgZG9uJ3Qgc2VlIHRoaXMg
aXMgYSBidWcuDQpCdXQgSSB0cnkgdG8gdW5kZXJzdGFuZCB5b3VyIHBvaW50LCB5b3UgcHJlZmVy
IGZvbGxvd2luZyBmb3IgY2xvY2sgbnVtcywgYW0gSSBjb3JyZWN0Pw0KaHR0cHM6Ly9naXRodWIu
Y29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvY2xrL21lc29uL2cxMmEuYyNM
NTU1OC1MNTU1OQ0KDQpkdC1iaW5kaW5nIGlzIGluZGV4IHRhYmxlIGxpa2UgZm9sbG93aW5nLg0K
aHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMvY2xr
L21lc29uL2cxMmEuYyNMNDM4MA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
DQo=

