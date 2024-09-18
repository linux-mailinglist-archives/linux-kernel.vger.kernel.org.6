Return-Path: <linux-kernel+bounces-332231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0DF97B70A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2CCDB21711
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03601386D8;
	Wed, 18 Sep 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Kr8if/If"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2046.outbound.protection.outlook.com [40.107.255.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BC2557A;
	Wed, 18 Sep 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726629176; cv=fail; b=QmyLfs/+OO2g1KHcgSmJ3pQqgOE5X29nWcBz3ka7IFjyiwAvi3eUb/D/H/y7nGJV94n+r2FZpiZmksy+lUYOOW0V0x7sXEtmw8yreOmfZzzXXOuFZruhQQy4iIvemjl1oHxNazij2BRtFKSrMYTdWvA4C3ju3kg9rUiElGo1zMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726629176; c=relaxed/simple;
	bh=AZT6J6Idv6gteducx5MFhr5nRWoIKeNLPZ66R1B+Maw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XYzSdgl8VcZoKTYld/x2mxL+K+cT6rnUgFBj5ojTSH6VJxt17dFtKlvb6Id8GJ6l2gioeqUPfjxTd4/dtdm50gMjfNl7M+pO6wdfw40Civ7rk5LXB4uRH4vjJmty8gup4kF3/6vTpFtzb2LXNT8Ki18PQ6SF49AJUlFmZewTepY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Kr8if/If; arc=fail smtp.client-ip=40.107.255.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySgyPQdijSdWKgs94Ez5WnKyD16P00qpNWhYoAEwPJCO6gLpzcW3Ifsg3WXRgl8PQ1unRKHmJddcS1guqEUmdtF4+HUOvMxnfrvaksO3PV13WQc3JkKiPSmc/y1JK7m0W3dcdblJ8SAkXVJ7XJ+fiTY/CB1Ie26OSb26AHsCYSzjM2Cm984pnUe/v/TOCbMKVK2x/xoTlXFV/sSIwlRnHdEwpIfyu6SoBW5aTzLSH7q7EwbEJ+38M2Gmk8bO+t4VgpA8szWqwvwuoKJgqGOH1yDrlLfqC+JbMyVZBoTwN05oFhX7KQIfMAx5oryJB8LPJaoQZ+CwKjtwpCKKZX9y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZT6J6Idv6gteducx5MFhr5nRWoIKeNLPZ66R1B+Maw=;
 b=OzF6jCjWMKO3zrb+h8XAtPD7iWydHflufQJhzzCcGMQv15IiW8Hy1Y82Mgh0xGU0P9+zNT/u0GBKNxmLxJTGM4JMqT1U6nNev0iqlPZTKZKd2i/r2cDEaoIGZSMt+q2bAG+KkvXRLEwlmp2bItC80TCoVcfVyh3rxq/ZlEiQzkL32V9vvdMpJxuQRuwDogHcseVyDShiDt/v0kU0MzbENMvkQfeJYa8bg2EsCySnxA33lCMcFQ0eprUVqgwvldH1j0dAW8AA2+egYBcLGkBVk4YKIz9mkT6qbic7XpRUzyjEg8Z1AySKVFtq7yDpZiz7xGQ6MqRlucVMCSU/DWbmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZT6J6Idv6gteducx5MFhr5nRWoIKeNLPZ66R1B+Maw=;
 b=Kr8if/IfX4p2vyNhfttEetOK8ADGgPZI8ZPZZwVtL+iP2V9uNOBm5EN80xvTkpoegef/mHwYM0DuzeaPGpRX9xvQ4vfhAyd53Ey6FWKZ5GMOzsym4DUb0ozDrrBUCh1DeOa4VaXqfzCScZzQnpNKliFqwPy6M2saK8keRxBhE1SQZNSEhnYXpuhFLEEI1ENThCSOFi/UeFdOHi9FYghYXRCPbH0F2RdNXH9XStVhhizsAiPpZEYXYv8uyztO8KGVQyfC4uJcAzbAcwzsB1K4UUlQpZyacx7ERtlBSkfbqHSYn1xiiSL3Nzj4goqVLkmNAUq/Ru6CrpAogH8V6K4D5w==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by KL1PR04MB7368.apcprd04.prod.outlook.com (2603:1096:820:114::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Wed, 18 Sep
 2024 03:12:50 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 03:12:50 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
Thread-Index: AQHbA0xDBqBHzMeSJ0qlHcI2T1uCCbJQoAuAgAAMc/CACXgngIACw3AA
Date: Wed, 18 Sep 2024 03:12:50 +0000
Message-ID:
 <TYZPR04MB58538354F2C7B6C767679308D6622@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
 <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
 <TYZPR04MB5853795FDC6497F7E0114E43D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <10de03e4-db98-4b5c-9cf6-3f98a5cc0537@kernel.org>
In-Reply-To: <10de03e4-db98-4b5c-9cf6-3f98a5cc0537@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|KL1PR04MB7368:EE_
x-ms-office365-filtering-correlation-id: 7fc88c94-ecef-4c7d-e594-08dcd78fc744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d09LMktFT3M4Z2dadDR1S3ZkWnk2aDRJUTJFK0tyZmN3S2hlWElBOTdVRlpu?=
 =?utf-8?B?c1BTUlIwYTlycFl1QmJBZmNuVUJMc2NQcHRhZDhVU0ZYQnJwS28zemtEbVRS?=
 =?utf-8?B?WjVNUzJpeTc2L25TcHRTZVNLZnFGekdWWkUyNytKS1pVOExSQUh2R1ZBUmVV?=
 =?utf-8?B?eHJFSlVPeVNieUZuYytGTVhybDgvUkJlWis3TmJRWEpaRXBPRCtXQXRiaEdB?=
 =?utf-8?B?YUZXZlFlZmZkZEUrcDRDY3dnODRMc0Z0OWdzbTNPRjVPQk9NcS9vZ3licVRl?=
 =?utf-8?B?MFlFdURHeERDWnFYdTFKbHY1MWc4U3NGdXhNODZqcFprNE5FVk9OSytCWm9h?=
 =?utf-8?B?TGpyQW5kTnlpcmJZZnhXL0hsNllyTE9BbFdROC9BM1NhZTZUNWJPUEdLcU0r?=
 =?utf-8?B?S0hCN1BHdTBRcnVoRkptRGwxRTFTRGFaL3U5a2VFVHVGWWdzQ2ZaRjdEaC80?=
 =?utf-8?B?N1lVL0hwOW1ieXpjc2VmTGM5R0kxUExhM0JmMFZZcjhvM2N2TUNlK29qVEF0?=
 =?utf-8?B?N3RQalBXM2hnbFFjdkJ5QTdSZ3I5T3ZnT3lsVjhpbFNLSUF2eTBickR6VndH?=
 =?utf-8?B?YnFrKzJCU2J3SFlYWGJtemxJSnc2Nk1oTXZUYXJ3eGUyZjh4Uk5EcGlwL0RH?=
 =?utf-8?B?V0xaWGkvancyNFlGSDMxN3JCTkZTSnRqNHZvZ0hYYVJiRzRTc0NyRmRVbGpD?=
 =?utf-8?B?VGZEbEV5bHVQa1FwRkVwaUNlQ0tGUkY2M2JzYzdic3U4WHpuMjNlT0VvcmJ5?=
 =?utf-8?B?MVFVd1BocGM3TWRNOUNOZHVmWWNXdnhTczlSYzFYSGRtTWRLSVYrcUlQRXNR?=
 =?utf-8?B?K3ExN2tRRlJSbXpVRmFuWHlMS2t4dW4vT0RMNSt4RkRXQkNzRGlCeDJRMldN?=
 =?utf-8?B?emVGZWVMM3F3aDc1SWhIZ3VnYjNXZzVYQ0NuVEpUeDJTcE14bWlvY3UvcTNP?=
 =?utf-8?B?WStrRXpMdFUwZFY2emR5SzgvUGtwWGhGalcrSzJYOUhkRzZzZkhlREN4SjAw?=
 =?utf-8?B?VVloVmh2MldYU2wvWjZTQ21sR0pmTnNQUGgyRm1nSjcwRUQ5RXdISk5QbUcw?=
 =?utf-8?B?NVo0L2dlZVNFWmErdHg3M3N0dkpRaGZHeFNvQTJxOWJoTDFOWm9jMXhLL0tZ?=
 =?utf-8?B?b0FuWjQ4dkxPRFRKc1FGZjZ0ZmlHUlI5eTBFMUwrSzFhOFpNc3dxME53UUNK?=
 =?utf-8?B?VFplY1k1enpsb3JiRmZYYkEvQUgxNWJjZmtMMUtrL0Z6ZjlHQVpYQjRnTjRV?=
 =?utf-8?B?YXFiL0RZcEtBdkl4MjBnZi83U2xUUVBBc01NZERQeVJvbnhFKzJrYy9IQTVO?=
 =?utf-8?B?TXpCM2lsdDBaWG9sMFJHN3laVFc4Mnh2azZFQUsrNG9RNDZRTytDdGJYRnJF?=
 =?utf-8?B?b25XYi9QQVpxWjBURTJUMHlVeHl5M1NwMzFyYS92S2RMSVN3dGxXeVdCOXI4?=
 =?utf-8?B?WnlVbjl3ek84Mk56MG9uMHludTEzMG5yenoxQTNqdTdEb0gwTWVqaEJmaDZQ?=
 =?utf-8?B?V0k5MXJnWG5nd1ZodngwTXROWXBMOXVkWTlYQmduKzJRT0F0QyswZVhTcCto?=
 =?utf-8?B?c1lqK1hXZEJ1Rnk3Mk9BclNPa1BOQVBqWVZEMmpqMjY2amNoRVk4d1NXaTQr?=
 =?utf-8?B?NGQ3Sm8wV2VHczNqbjdDUUVyQ1l5WVVWRTZGNmlkYlBST1RjNEZrNURYTVdo?=
 =?utf-8?B?Qk9INEFaL04wZW5TdHB3b1oyRGpMeWxkVFJpaDFWeWtGMUpua3M2bGJxZHlF?=
 =?utf-8?B?ZVNmakhhQ0ZPa3VDaktBNE9RNGdzWUd5YnAxeW91TFdVRnRnU2lPZ25sVk5E?=
 =?utf-8?B?LzBBQ2c5QkNpQlZrWWhha1hFeWw5Y3BEZ0E4bnZVOWlkdzYvYVIyc0hwdnBp?=
 =?utf-8?B?am92cm9udWVUUjFVKzRHbG82K1AwUkd4VDhNdmY5Z1oyK2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlFRVG9GdmxzY09LY09FQzYvdnl6QnZQdGt3aTc5VklXMklsSVJTUWV2NWhU?=
 =?utf-8?B?OWxRQ2hCMk5WdVVHN2M5dURxNkU0OWxjcGVvT3lmWEU0TDNqWk5kenRJd2hs?=
 =?utf-8?B?VXcrU1FKVkkxM0kyVlkrMUtnTXZuNGdMNE41UTY5eFBnNFgrbnBIWnhCVlA3?=
 =?utf-8?B?MGJvNVBNQk14Zy8xMmt5b2YyaHRxWXhPNVdKeEZJSncvNzF4cDBIeTliQm52?=
 =?utf-8?B?dGtxWERrYmNIWktOMCswU3ZLNDc1N0YwVXNmMjJQckV1VzhETERFUlhrVE92?=
 =?utf-8?B?R1RrOG9DSHU3UXB0MXBwYUZIWk5UL3p0dFFyM3ZjU1dXUGlQMHZDWE0wYk02?=
 =?utf-8?B?dXdJQVZOY2hVYkFWQkNpeGhsNzIwc3B6RFpKNmJkTTNjWk5JUUVEbnZ4MXg3?=
 =?utf-8?B?VDV1RG1RSjJEZXdBcVJ3TEQrUi9mSHMyeCs3MzI2SUFnVnVXVHAycjhwUWJx?=
 =?utf-8?B?TkJWYVR3Ui9KVW5hMXpoK1pkNDQrOHJEMTBkUzkwV0ttMEVoM0o0Smtnd3Bj?=
 =?utf-8?B?NG1QejQzaTJDMGdpRTI2b3Q5WUVsbkQwNjhXdW5Sd29DWU8yeGlMb3FJWFNX?=
 =?utf-8?B?TlJuUDJlTWhybVF6Q20rdTZnREF5b01mbThMN2xSLzFmVFJwT2RybHVJZUtp?=
 =?utf-8?B?Wk5kbzQvVjdKekkxcUVaL1VlcUptb29ibkJwZTIzbmVDMDVZdDBpRkV3K0NL?=
 =?utf-8?B?RHZDZWk5M3NWcTBRU0hDWVltY3h1RUFTVTBQSEFpV3FBUEE2WHBrc2I5blh5?=
 =?utf-8?B?bFdYaE5oOG02Z2kzSHcxc1ZnbGxLLzJZM2VjY0RBNytobHBNam5zRDVaU09p?=
 =?utf-8?B?TVU1T1Z0T3JLNE16dVpnS3hpUmYyOFRIVFZ4bXlyZ3B4ZU5MSHBlK3BTQ1Ur?=
 =?utf-8?B?Ry9qN3Z0UWU2ZytudzZEdXgrWTl5Ui9WaTRTUzcyck9XUGJiTld6S0g2bVpW?=
 =?utf-8?B?N0NIQmhZN1l4VFRObjY2TUxJVU8zeHNONVBQTUFxRU5OZERZYmRhd3dKZTc2?=
 =?utf-8?B?Q1FCc2RWZHowRkJyNlc0MWhvNzZvamdEUGUrRW0rN1djZGEzaVF6Z3VWbUFR?=
 =?utf-8?B?NkFpQTdwYmZxOWl5QjZKVFpUeGZmZlZ4aEV6ejlxeWtzT0dxbVB4SXQ4Nk9B?=
 =?utf-8?B?eklCUVVaNElkSjg1TlAvUTdCSTVoaTFxV0Mrbzh2akl2aloxcXF3N2FoK1hz?=
 =?utf-8?B?SWYzT2w4T3BqWFpoN0M4OHcva3lkekFhMVFxRlZaT0p1MFUwckhxWVFMaUF4?=
 =?utf-8?B?eGV0Q29NM2lMSmZvSUx4S1FoYm0xTUpHY3luRzZQdGdmMWM2WW5ybmUwUEx1?=
 =?utf-8?B?OWVVMDgvOUpyc1JSYzNmcHduOWlHYkNERzR2dlVzM213bHJoVU9FNmcwVXc4?=
 =?utf-8?B?QVA3OHl0Vm9kVHhQMGM4MFJVT2g1YTlDd3JzRGdEYzNEbkl1TTFySmxac3N0?=
 =?utf-8?B?MVhlQno5YTVlZWZpV09nMVN5YVppSU1YWC9oUjd1ZHVaaHREcUNhcUwzZldr?=
 =?utf-8?B?eVN2L0RxUXlpTVBYcUtUN2NUSTBBZjNQcWZGRUNpaDVUcGprM3Y2ck9XVGxS?=
 =?utf-8?B?VlZTVDlLUlFITEZYcVM0WnNVSWdnbWswVWhaWEdRRG43TEVDMEJKQS9FU2tn?=
 =?utf-8?B?ZTZLZ3dXbmg0TUgyckNvT0RKaFBGSUFRSHlIMm0rTHc3cmcvd0h2ekNSZU5l?=
 =?utf-8?B?VVNsdzMwM0RyMDQramt2d2NLbDVibktwc3BEMG5CUVRHRktNRVhVSTExTE5I?=
 =?utf-8?B?Sjc0L3pWbXgxWWM5dUdhVjRjR3p1c0ROUUJjNTZ3WmhvMVdDMkI2ZWo0OUJL?=
 =?utf-8?B?TGxvVlFlSzRYZ0U0VStGVWRzSTFJTWxOWGxXczVmV3V4TVBobnFLdVJQVU9Z?=
 =?utf-8?B?THJvNzVLdEFidWFqeFd0a1UxenBqQTdaYjJTM1VyT1BLcUZ6N0o3ZEdqK0xS?=
 =?utf-8?B?N2tOaUZyNW5PL2tnOVVsbUU0LzJmU2N5U016NDQxdG00ZVJ3d2U4ekpmZHh6?=
 =?utf-8?B?SC90UzVSaDlxSXpPSUFXRjJac3F6MlFZd0VsVzVEZVlyWlU2ajhFaTlicUFH?=
 =?utf-8?B?Ukt2QnN1SnhkdkEvdm90Y3ZidkVRWWNQMTEyRDQ0NDV2MDdOTi9ucXJGU0d0?=
 =?utf-8?Q?K0lEyv1CJzBQ5hm6TGZj2KKZE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc88c94-ecef-4c7d-e594-08dcd78fc744
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 03:12:50.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNa6Z5l5Xvuno6QjATti+l/z+7amLe3gE6BFFVmgDjq9MAiDejcpOEZM5hDaBQtBhe9UBvDafJBEZk2KQ87RyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7368

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAxNiwgMjAy
NCA0OjUxIFBNDQo+IFRvOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5uIDxEZWxwaGluZV9D
Q19DaGl1QHdpd3lubi5jb20+Ow0KPiBwYXRyaWNrQHN0d2N4Lnh5ejsgUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2VybmVsLm9y
Zz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEpvZWwgU3RhbmxleQ0KPiA8
am9lbEBqbXMuaWQuYXU+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29t
LmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+Ow0K
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBBUk06IGR0czogYXNw
ZWVkOiB5b3NlbWl0ZTQ6IEVuYWJsZSBpbnRlcnJ1cHQgc2V0dGluZw0KPiBmb3IgcGNhOTU1NQ0K
PiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gDQo+
IE9uIDEwLzA5LzIwMjQgMTA6MjAsIERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gd3JvdGU6
DQo+ID4gSSB3aWxsIHJldmlzZSBpbiB2Mi4gVGhhbmtzIQ0KPiA+Pj4gKyAgICAgICAgICAgICBp
bnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMD47DQo+ID4+PiArICAgICAgICAgICAgIGludGVycnVw
dHMgPSA8OTggSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gPj4+ICsgICAgICAgICAgICAgZ3Bpby1s
aW5lLW5hbWVzID0NCj4gPj4+ICsgICAgICAgICAgICAgIlA0OFZfT0NQX0dQSU8xIiwiUDQ4Vl9P
Q1BfR1BJTzIiLA0KPiA+Pg0KPiA+PiBOb3RoaW5nIGltcHJvdmVkIGhlcmUuIEkgYWxyZWFkeSBj
b21tZW50ZWQgYWJvdXQgYWJvdmUgYW5kIHRoaXMuDQo+ID4+IEltcGxlbWVudCBmZWVkYmFjayBm
b3IgYWxsIHlvdXIgcGF0Y2hlcywgbm90IG9ubHkgb25lLg0KPiA+Pg0KPiA+PiBCZXN0IHJlZ2Fy
ZHMsDQo+ID4+IEtyenlzenRvZg0KPiA+IFNvcnJ5IGFib3V0IHRoYXQuDQo+ID4gSSBzYXcgeW91
IHNheSAiQnJva2VuIGFsaWdubWVudCIgaW4gdjE1IHBhdGNoLg0KPiA+IFdvdWxkIGxpa2UgdG8g
YXNrIGlmIHRoZSBmb2xsb3dpbmcgZm9ybWF0IG1lZXRzIHlvdXIgZXhwZWN0YXRpb25zPw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBncGlvLWxpbmUtbmFtZXMgPQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJQNDhWX09DUF9HUElPMSIsDQo+ICJQNDhWX09DUF9HUElPMiIs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlA0OFZfT0NQX0dQSU8zIiwNCj4g
PiArICJGQU5fQk9BUkRfMF9SRVZJU0lPTl8wX1IiLA0KPiANCj4gUGxlYXNlIHJlYWQgRFRTIGNv
ZGluZyBzdHlsZSBiZWZvcmUgcG9zdGluZyBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoIChvciBh
bnkNCj4gcGF0Y2ggZm9yIERUUykuIFRoaXMgaXMgc3RpbGwgbm90IGFsaWduZWQuIFRoZXJlIGlz
IChhbG1vc3QpIG5ldmVyIGEgYmxhbmsgbGluZQ0KPiBhZnRlciAnPScuDQo+IA0KPiBCZXN0IHJl
Z2FyZHMsDQo+IEtyenlzenRvZg0KSGkgS3J6eXN6dG9mLA0KQWZ0ZXIgY2hlY2tpbmcgdGhlIERU
UyBjb2Rpbmcgc3R5bGUsIEkgZm91bmQgdGhlICJJbmRlbnRhdGlvbiIgc2VjdGlvbiBtZW50aW9u
ZWQgdGhhdDoNCiJGb3IgYXJyYXlzIHNwYW5uaW5nIGFjcm9zcyBsaW5lcywgaXQgaXMgcHJlZmVy
cmVkIHRvIGFsaWduIHRoZSBjb250aW51ZWQgZW50cmllcyB3aXRoIG9wZW5pbmcgPCBmcm9tIHRo
ZSBmaXJzdCBsaW5lLiINCg0KU2hvdWxkIEkgYWxpZ24gdGhlIGNvZGUgd2l0aCBmb2xsb3dpbmcg
Zm9ybWF0PyAoTm8gYmxhbmsgbGluZSBhZnRlciA9IGFuZCB1c2UgdHdvIHNwYWNlIHRvIGFsaWdu
IHRoZSAiKQ0KT3Igd291bGQgbGlrZSB0byBhc2sgY291bGQgeW91IGhlbHAgdG8gcHJvdmlkZSB0
aGUgZHRzIGZpbGUgdGhhdCBJIGNhbiBmb2xsb3c/DQoNCmdwaW8tbGluZS1uYW1lcyA9ICJIU0Mx
X0FMRVJUMV9SX04iLCAiSFNDMl9BTEVSVDFfUl9OIiwNCgkJCQkgICJIU0MzX0FMRVJUMV9SX04i
LCAiSFNDNF9BTEVSVDFfUl9OIiwNCgkJCQkgICJIU0M1X0FMRVJUMV9SX04iLCAiSFNDNl9BTEVS
VDFfUl9OIiwNCgkJCQkgICJIU0M3X0FMRVJUMV9SX04iLCAiSFNDOF9BTEVSVDFfUl9OIiwNCgkJ
CQkgICJIU0MxX0FMRVJUMl9SX04iLCAiSFNDMl9BTEVSVDJfUl9OIiwNCgkJCQkgICJIU0MzX0FM
RVJUMl9SX04iLCAiSFNDNF9BTEVSVDJfUl9OIiwNCgkJCQkgICJIU0M1X0FMRVJUMl9SX04iLCAi
SFNDNl9BTEVSVDJfUl9OIiwNCgkJCQkgICJIU0M3X0FMRVJUMl9SX04iLCAiSFNDOF9BTEVSVDJf
Ul9OIjsNClRoYW5rcy4NCg==

