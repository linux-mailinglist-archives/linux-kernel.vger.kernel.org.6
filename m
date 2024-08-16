Return-Path: <linux-kernel+bounces-288949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B295408C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990F528A7CF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 04:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17C839E3;
	Fri, 16 Aug 2024 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="X/kd905k"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C415572E;
	Fri, 16 Aug 2024 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781284; cv=fail; b=K1GK/kbzDsw4jeO1FgIpdX8FHXCSys5TLxZ7mHM9qjufizNrleDH4qm3uyQA++dJmznxq6DWes9l9nl6HVteFNF6MU14Ir1jk6l1S6tjb9rY5BE63Ilpj0SlrXivoXubnEW31zyN/N3aWxLj429osntFi8DrfhvvPeUuNDG9Ruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781284; c=relaxed/simple;
	bh=Rc2HeLeQOGGnMuoLP6PLuPvyV5Y06RnVxfMuTIyr6EY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aN+0azgrJQEsPXvbNzM1u1ur+9pog0HzT2XW4IBfVLkmBfqIB7PUpnmPkVG5bJ2h4BiVt5NyFbQUjBrIGC1CzTjUxjjHgSNaKMobfeRtepY6XQG4ob1ZPFDXC4etrtFHs1vmZUHK6UzIHux5YzpOdofazgyuwGFJNs52PXm1skw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=X/kd905k; arc=fail smtp.client-ip=40.107.117.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=empprqzEKXLOfq89dH/jNdnRm3cL1GDzGjEdv3DayhB5EAo/YZ4oZGwtBjU2F13FclJEhcSSeZq53ZAqoyDb5kp9sm5uZVU3hP4Nc1mfT9kX+b2OGhagbUh53uTeB+0qHIO4A2Bv/0C4X+h5Z+Vh8ajQCib6o2RC+YfVbrVdlgZnk+MLyRKuOF4FgNDpBjLJwcEEbg67WYksEkLPxUcqmLOXCU2SxrNHoo4hXfsH2bI9bAxIZv/N7jzrjvoXSjyGc/AFswPiDcB3tX0/6gNR5y8O9YWuCdoClARobu5pVFeiLg2XyisMJhXFgbTOBtsegW1f3wnfo/PUmHgxJKtenA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc2HeLeQOGGnMuoLP6PLuPvyV5Y06RnVxfMuTIyr6EY=;
 b=cQinM88LWHE2ewO+6jqNk9W3W/zn9Mwa3C08mQsRNVQ13kJU/Ht9LiUEDhqv1N3FMDhSQlfqIN5GDUz0XKO1mJ4GlmgSPgbjWFggtSAd7HTs6vS8CYOJvTvsPfI2IiULNEm+0l6acF6gmI8tc68QzTPMiUvjEEwzsLqzceRfsBCKKZYZrUy1KvkPJmDp4jIsMPCOZJpnDMjJBIiHCtcg9nXq2Rnw+3o5VSd6t1eC6uM2cEU3BPNZd7K9DC0iQH9WuSp1vvC8TKUEsEo+KufSG063c15/zJe4z1IsVLEulI1aAz1o6eKeTIR0EbybSTGqIGiwzNjRyeDoM1iSgCht7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc2HeLeQOGGnMuoLP6PLuPvyV5Y06RnVxfMuTIyr6EY=;
 b=X/kd905kK612OE+T8untBSuFd+BZdIYcZFTSCM0BtEuy55UZ9QsEGcnYh7ZdZaDW7HWL0Tf5bwULXWevJcxKH8WUi1IWJGvDMuj15c5drUrfUcodM+eSPawOf74lTZ46Xfr2ZcT7e6NErsS2HHo9lr2jgqM4y1m2wZAOhNFv1twEsp7KvvV8ZM8i+MM7MMd1YC+P1EBfh8bUMl/Nac3fYaWzs+szsxHWUAi2DCNceGBPY2CTTFa8WaE8RpUmmR3lKtLpj0XKysEgBiXi7PbFjAHRr4ZulI2u2UIK6f1PaADusl43m4jXJkBlUVMcAQTeVB7Nxzap5Z9RwQ626RLlvw==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:07:59 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%7]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 04:07:59 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 07/10] arm64: aspeed: Add support for ASPEED AST2700
 BMC SoC
Thread-Topic: [PATCH v1 07/10] arm64: aspeed: Add support for ASPEED AST2700
 BMC SoC
Thread-Index: AQHa30uNgfdNeqemVUaxz4JUd+v/wrII29uAgCBsZ1A=
Date: Fri, 16 Aug 2024 04:07:59 +0000
Message-ID:
 <PSAPR06MB4949D912D866D3515279BAA389812@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-8-kevin_chen@aspeedtech.com>
 <b7b3cbc2-5f20-4a78-b189-b509acfee3ac@kernel.org>
In-Reply-To: <b7b3cbc2-5f20-4a78-b189-b509acfee3ac@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: 6b761f9c-c25b-484f-e153-08dcbda9042c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnlqYURzUit4dVhlSlQzOUVmbTVJRXdqZjVvdGc1Yms4RERPZXRMZHdzaElU?=
 =?utf-8?B?bjI0Sy9uSE5rbEZwTmRmWDB5eVI3dXVxQlU1QzVSL1hzQnRKdmJkeDMyTDRj?=
 =?utf-8?B?Ym5qTmZ0Sk1aaytWcFlNaTNrQlFWMXN5Vjd0WU93S3FhdFR4S3gvdzBMdlNM?=
 =?utf-8?B?NVlzQXRxN1JDc1ZSYTdDZGVra1RjZ01NNXQxOFlTYlhxd1ZwaE42eXQrTjNL?=
 =?utf-8?B?a0hUcC9KdjJ2elNTRVlHTzl2VEQyU3Foa0paU3QzaWp1aHZna3ZZbU16WkpN?=
 =?utf-8?B?SEpybTRjMXM3c3ZncllBWGNVZG56NnNUZm9qSzhobUozNEU3b0h6bzZzdHg5?=
 =?utf-8?B?Mzc1RUk4djhmRWJRUWJBd3VtMjRIanFEN3prR1pFL21qSjkwc0FxNkhEYWxu?=
 =?utf-8?B?dVJpZ0Q3Mk5wRStOZEp6NU1mZU5EUzBaRlUzYXMwdU1YR3N3Tkt1VHJlNzRr?=
 =?utf-8?B?QllhQVduSzlnK0txRDJZQVR5YUJIZFpiTEZVVDdEcUZ1VkwycU1sdC9lMTVl?=
 =?utf-8?B?WndHWWJIMHAzVXdlRzdZcW0vQVRzU0pJR2orNi85bExWNXlVbzQreWJWMU5t?=
 =?utf-8?B?U28rVHJscDdQZGUrSzRxVFJHeFVFVXEyYjRqZTQ1VFBvWm9CSFJIMTJFbk1p?=
 =?utf-8?B?amh3ci81MkVUaThVeFNxSUNLVnExT3NwWDJhVmVPdWxqTEFwbWgxaTVLZVoy?=
 =?utf-8?B?TXBIQkV0RjFYa2x2azNNM1RQSEphOG5qajY2S3VTVzBCR0I5a2tqV21ML1NX?=
 =?utf-8?B?N0FyeWlnb2lXdWd3K2VKaE92ZzRlRVhrN3l0d211UHFQL2JUVGJZMVpsVmtN?=
 =?utf-8?B?Q2VadWhDMTFiUFZtd2VxbXZyN2hKczFZR0RjbElONzBsRmdQVENlbmNHeFlR?=
 =?utf-8?B?RVlSc0RUcktsSEd5UTdKOGkzbFpCS1ZlMENxR0xqWFZUa0tWVDl5bGR4ajB1?=
 =?utf-8?B?S0E3UXlBQlZqZTAwTmk2K2RnMDQrbFRkSFVJNXQ5ZE5LK2ZaSmtqRldsTXgr?=
 =?utf-8?B?VmJZcnc0RmU2L1JTVmI0Z1pDUmFTWWJwNXpkeUl6cWIycXpJMis3Y092b2g1?=
 =?utf-8?B?R3VZOHBab2xuS3ZlN2toNFRjbXRNR2hneHdhRUVwK0dBQzl4ZjZRM0Jkb2FH?=
 =?utf-8?B?eTJzR0lSOERoTkZuZWRRV1R1OC9QckNkSEFCMW9NZGExR2orOW5wUjJSZ0RZ?=
 =?utf-8?B?aFBhODF2bk1Xb3o5RkhFcUsvenJxVmZqWFczZkNiVVlyeFJleXFEazRSWVM2?=
 =?utf-8?B?V2JsZnRCTGloa2JnR21XS2JaVXdtc2ZGdkI4VVpncVEyUWpyaXhoNWZ4SSta?=
 =?utf-8?B?TENzQjZUcHMyTFBmck9qamkvQmc0ZTBHY01RQzhNclV6WUxlZFQzS2o4bVAv?=
 =?utf-8?B?NU5xTmJvNlBaN1ArMEhYcCt4ZXptVVd2bmZBMm1oNHEvVnNXUEU3MHYxcEt0?=
 =?utf-8?B?cmg1SEMwT0tNV2lTRHZwYzJTK0FWd3JIZ0Vhb1gvSExPbjc5bGtydUJwOGg2?=
 =?utf-8?B?bjRWRHJRN0NjU0FhejVQOC9UVHpZRlArR0lpZytxYm5mQWdPOTV5OUF1eHMr?=
 =?utf-8?B?QU9hSE5laUtzUFhPMXZFbGJGQmxkV0dKRm0vUEduSENQem5CS0dWOHhLY3lJ?=
 =?utf-8?B?MU1tUGw5RUdNb1E4TzlXdVVrcEZVT0hNendlekhIZUloTjV1QWkwWS8wMjdK?=
 =?utf-8?B?NDY3WHo2Rk9kNzBGaHA4TEUxK0lvZTR3QjFDNE0veUZDTGJyaGFPRzRYKytx?=
 =?utf-8?B?djd5eWRDNUNHTmlOQitKR3lOT29DOWEwN0hsdUNkN2E5MjBkQmNDR0V5M0pB?=
 =?utf-8?B?dTJNZnZ6RnhZaHRhUkQxRHhaWC9nRzNsaW9nMzQ2R2EyZ1hEMnlEaG4zU2R3?=
 =?utf-8?B?VWRyRWE4QkREMTdOZFdQd1lhMVhBT0xGNDkyMGMxR29sNlZHR00rWUlIZjd2?=
 =?utf-8?Q?iMPM8kzGR2Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWY4OG5OSjI3Qkw1VUJNK0dqeTFDOFlvOWxRVXZMNlc3UEZaWk50S1o4d3gy?=
 =?utf-8?B?UGJHRm9TQTRkWGVxMW02emVOaEN3aUdVR2pweXFxNFJqeFg1SzlkOGc0WDd4?=
 =?utf-8?B?ZmZ1VVZIekwxaDJpVDlBL3VEaHRXSUpmZldMTnIxTERrMUxjSnVRcFh4bWhs?=
 =?utf-8?B?Y21xT1VYSXd1c3UveXdYeXpJbmV1eUNpOGRNdWdHdUQzMVprMTBtQWkrRWpp?=
 =?utf-8?B?T1FmbmtjcFNoM2tlaGJqbDhUVFdodGJJRjdrUnc3TjR1M3h0QXBOOHgzb2pG?=
 =?utf-8?B?SitGaGEvNnNlekExL1dkSlJqK2IrTHA5dXNXK2JLUjVhODZnMmljNC9vTGFZ?=
 =?utf-8?B?Tzd4R09jc0hJL0p6RnJkRnAzdmhpcnZ1MEJibXBObk9ibXlSeWdlZ0t3dmtI?=
 =?utf-8?B?TVhFVTJ1dGZCdml4R2JzdXpMd2dFYUMwRU5kNkR2U1JqTjF5T2Eycnk2YjhO?=
 =?utf-8?B?Ny9oOGFtTEh2YnJoNnZDZFdtY01NdWc0aTlvVW0rV3RrR1ZySWpzUHdJcnlP?=
 =?utf-8?B?eEJYZUdpQ3NsZUVOZ0hxY2F6Ym1udGtHNGFVbmJJRzFDZ0NnWk5zYnhBcXZp?=
 =?utf-8?B?OHBCZ1JQZkpJYTVnZ2JmTkYwSlRzekVWNlNra3VqUFYzbjMvcE5QMytyeGIz?=
 =?utf-8?B?UDJ3Y0R1QVVFN1JXdksyZllJbDdaT0U4WmtwdHByQVR0Z3hlOGdoT0FpSEFV?=
 =?utf-8?B?V1JSekNmaXhhWitqU3htVE5oL3RWNUlUcm1RTjhaOENsWElMcUR3MGgvMENG?=
 =?utf-8?B?QWUzME1IdE8wR1pEMHhLWXFQTUQ2UnpzMi9QVEdkdHgzWlNvS3gyZGk4ODFD?=
 =?utf-8?B?czBCWU8yblcrbHhnU0lVaWp1aDI2bW5VMFNKRXA4Lyt2dWdnY2V2MVgvRElt?=
 =?utf-8?B?VGZieFp1Z0luVk5JR2l1eW5yNFd1b3pOQzZLejNZMm1rdThLOHZsckRtT3JV?=
 =?utf-8?B?SjVOaHF2ZktCaHdkNnBWQmZOdWsyTi85WExtVE5rZWJ6WlVSRDJ1VVBkaGJy?=
 =?utf-8?B?Y0JpQlpJM25mRnlodW5zdytTZ3VFOXFXNHp2YVZXNmVDcWlNM2g3bmx4Zkpu?=
 =?utf-8?B?M25qeFRMbE5NRCttVDdWcEhCdVVIdnFoTUtLOUZoN0dVdjBoUlBFY2xvQ0pU?=
 =?utf-8?B?UGdURmFvNUlOK2pRQTZES2JORVFTYU9NUUpOWjFZd1ZuWlpuQ3k0bW5qVmln?=
 =?utf-8?B?dnpSQkh2YVNaaWMrcnZGMXRWcjhRRXdhOXJrN0xCRkdEWC94RXBqQVpoRGVJ?=
 =?utf-8?B?eTdCeUFwK05yemkzVmdKVjVBb05sM3o2eWRxR284SUhjSTZ5NWtVUUZBR2E2?=
 =?utf-8?B?SHlIV2FISDNIQS85cXU2NHpJa1ZmOGYzUmE5SUc2aVZvWE11UDZaQjhjdWFu?=
 =?utf-8?B?YlBUcFBQVDErNEVOS1lpMnpGV1NMMm45TXFwdi80dE9maG1Gc01XVFlET1Mx?=
 =?utf-8?B?enhZa3ZMTUFjVmFKb2lRSHdrNXVZbEE1WTJPbmhubm5BMzYxY05GMGR0U09Q?=
 =?utf-8?B?VFp4ODFRU2N0OW5tVGNZWHpPaTRLcyt0MkVjKzJhVmZuKytYR1l4SjJqSUpj?=
 =?utf-8?B?cU5Qd29yVUF1c29STXJXQktCSytuVElRQ0RDR084ZlVUSFFyQ0FxSHJ3aGNM?=
 =?utf-8?B?RkREVDF0UDhaRnZidTJwTGhvMHhLckpUQ0tBVU1CdjBSQ21mQUVadGZNTytx?=
 =?utf-8?B?SFpvaEZ3TFp6UlRFYmdyb09wVzhGSEJueVNDL3NWUmJ4WitTV3piWlZBY0pY?=
 =?utf-8?B?b2FVUXB0ellsUmhpR2tPQWZxTHFWNHJ2Vmxic1R5VHlWNXdnZTdOYkZjY29z?=
 =?utf-8?B?MW13MkN4cmhQTmE1N2lCMHhlOHFZM2pESUVDSUo4bm9CSXlRLzByVHlXWFBL?=
 =?utf-8?B?Vy81VkNsb0xPNlI0Z2pYNFY2Rlk3MHd3L0JqNlVpS3RTZHY1ZGNVSTR2UGJO?=
 =?utf-8?B?K1E2Ymp4Wm55RlpVL3pwRWxpZ3d4aWVqQ1hpZGlxQWZGSWx5c0pidWVLRTNC?=
 =?utf-8?B?VkRaUmp1R09ZZEFWRjlHRThaTGJBSW1MUUpDdEdVYlJMZkNocW9lc3Z0YWtR?=
 =?utf-8?B?dW9RckVJLzdlRzEzNUhnUHRWMkJ1N2xjTytLVnBWU2EvU3FZTTNkUXZhd0Zh?=
 =?utf-8?Q?3uyeZ3RilhajGqBggHIu+xYYL?=
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
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b761f9c-c25b-484f-e153-08dcbda9042c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 04:07:59.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvrjTna5BfARErmtm07sJjkhg1+CCU+y04U4P4Vsr1YHQaPpI3Yp75nyoKUoMRzcvltPIv6+vFbq+9A33VRXPollUf/Qhkq/oXp1/Fx1whc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510

SGkgS3J6aywNCg0KPiA+IC0tLQ0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgIHwg
IDMgKysrDQo+ID4gIGFyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMgfCAxNCArKysrKysrKysr
KysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTIGluZGV4DQo+ID4gYzBhM2Q5ZTkz
Njg5Li4wODYwOTQzMGNmZTAgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiArKysg
Yi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0yMTIxLDcgKzIxMjEsMTAgQEAgUToNCj4gICAgICAgaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LWFzcGVlZC9saXN0Lw0KPiA+
ICBUOiBnaXQgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2pv
ZWwvYm1jLmdpdA0KPiA+ICBGOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2FzcGVlZC8NCj4gPiAgRjogYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLw0KPiA+ICtGOiBhcmNo
L2FybTY0L2Jvb3QvZHRzL2FzcGVlZC8NCj4gPiAgRjogYXJjaC9hcm0vbWFjaC1hc3BlZWQvDQo+
ID4gK0Y6IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXNwZWVkLGFzdDI3MDAtY2xrLmgNCj4g
PiArRjogaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9hc3BlZWQsYXN0MjcwMC1yZXNldC5oDQo+
ID4gIE46IGFzcGVlZA0KPiA+DQo+ID4gIEFSTS9BWE0gTFNJIFNPQw0KPiA+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zDQo+ID4gYi9hcmNoL2FybTY0L0tjb25maWcu
cGxhdGZvcm1zIGluZGV4IDZjNmQxMTUzNmI0Mi4uMWRiN2I2ZjFlZTBhIDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMNCj4gPiArKysgYi9hcmNoL2FybTY0L0tj
b25maWcucGxhdGZvcm1zDQo+ID4gQEAgLTQwLDYgKzQwLDIwIEBAIGNvbmZpZyBBUkNIX0FQUExF
DQo+ID4gICAgICAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIEFwcGxlJ3MgaW4taG91c2UgQVJN
IFNvQyBmYW1pbHksIHN0YXJ0aW5nDQo+ID4gICAgICAgd2l0aCB0aGUgQXBwbGUgTTEuDQo+ID4N
Cj4gPiArY29uZmlnIEFSQ0hfQVNQRUVEDQo+ID4gKyAgIGJvb2wgIkFzcGVlZCBTb0MgZmFtaWx5
Ig0KPiA+ICsgICBzZWxlY3QgTUFDSF9BU1BFRURfRzcNCj4gPiArICAgaGVscA0KPiA+ICsgICAg
IFNheSB5ZXMgaWYgeW91IGludGVuZCB0byBydW4gb24gYW4gQXNwZWVkIGFzdDI3MDAgb3Igc2lt
aWxhcg0KPiA+ICsgICAgIHNldmVudGggZ2VuZXJhdGlvbiBBc3BlZWQgQk1Dcy4NCj4gPiArDQo+
ID4gK2NvbmZpZyBNQUNIX0FTUEVFRF9HNw0KPiA+ICsgICBib29sICJBc3BlZWQgU29DIEFTVDI3
MDAiDQo+DQo+IFRoZXJlIGFyZSBubyBNQUNIaW5lcyBmb3IgYXJtNjQuIExvb2sgYXQgdGhpcyBj
b2RlLiBEbyB5b3Ugc2VlIE1BQ0gNCj4gYW55d2hlcmUgZWxzZT8gTm8uIFRoZW4gd2h5IEFzcGVl
ZCBtdXN0IGJlIGRpZmZlcmVudD8NCj4NCj4gTm8uIERyb3AuDQpBZ3JlZS4NCg0KPg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQotLQ0KQmVzdCBSZWdhcmRzLA0KS2V2aW4uQ2hlbg0K
KioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioq
KioqKioqDQrlhY3osqzogbLmmI46DQrmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQ
q+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrprk
uYvmlLbku7bogIXvvIzoq4vku6Xpm7vlrZDpg7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvn
mbzpgIHogIUsIOS4puiri+eri+WNs+WIqumZpOacrOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWS
jOmKt+avgOaJgOacieikh+WNsOS7tuOAguisneisneaCqOeahOWQiOS9nCENCg0KRElTQ0xBSU1F
UjoNClRoaXMgbWVzc2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxs
eSBwcml2aWxlZ2VkIGFuZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlv
dSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkg
cmVwbHkgZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIHdpdGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhh
bmsgeW91Lg0K

