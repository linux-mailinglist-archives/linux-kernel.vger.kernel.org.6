Return-Path: <linux-kernel+bounces-353074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670B499280A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7556D1F233E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7F197549;
	Mon,  7 Oct 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="HXv81T6z"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55318E362;
	Mon,  7 Oct 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293184; cv=fail; b=idHYU6rztwmLNmumTSOfTFDjccP+ZJddM1ok9OKYFxi4qsS4/jaZC3JOCk17eTR4jp36Zn+gTBzfgV8ke6bw0ryh1ODa9BAK1BOLQTJOlbQe05oVOkBiEsnYx3woRWW/GlqkBdjLqpb1hOrwKZhz7Sc2NV5CveGDbr+wuem1N7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293184; c=relaxed/simple;
	bh=fkRdu7T9rq5Se+1Rrfwvn5wVT8w8S0+uIERK5H7sX7k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CjmlvZE3dNg6pxbYZJR2wCFFHgcGx3hF0/Xf+OAnEOG5g+DPvA4KkA/JxqOdMXZCI1kSHLIL1DlHvFdztlxtzW2K1qtVSSes8+ytoBtvJ2DodZKEu+gUTid6wouTP4OdnJr1pd0UDBEzGAChOUE1g3wyyyyqSk0fn/UNr4IrYP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=HXv81T6z; arc=fail smtp.client-ip=40.107.215.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiO53K86YXNwSkzX4fqMXuBXo5fMFWYUlhuTXRxSg2LNzRBziKuWoseBvbe2fZuqkfNj1GbFjqGrlazs50DRzm0ZHVI6a1ArrXUi+MiaEjC3GdqzjH0CqQMWYqQ26HDA7iLSnQkr1xEJwc9VtawPytl/T8avCmC6aYyzJqG2ampAseMqmh7pdOS5osbBpMANg4ic+/p7z0JwZ7InncmQ4nhkJcH6iAz8I0gSB0seiDeCR+TkoJoXlmXFNoc4WWNr05WxPVgqL123E1CwXfeQGAV47YH7NWlnZUI9cVHoC1E6Z7P4yVUanPj2z0llSSMA+5e0jgVVHKmyRFv+qwOLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkRdu7T9rq5Se+1Rrfwvn5wVT8w8S0+uIERK5H7sX7k=;
 b=fBUgj08RcSKUvQJaND6GwjITYRu8PC+fMzRCXPHEwKJNBtYoSh+H8882ho8qjxKIkSaIj+JtgwCTlb/2mGIA7Mg769WfA5Y4P9P4GGm28IJ9tl0T11HXvVYzr61jDvaPFiGU2eJHpwLEQaePxlIydanSUrqgONa6K55OJHndIbtUj9XwG9AAY2qHrCqiThfZ9zGnO79Lz/5LStlfRkKoLRikkBo//MZFB9Db26d8UhXt5wGs038+6SOKF8aHQZao1e4rdayfoFAvF2c/vy7bmzBWNh+Mwn+MZywYXXOUzAmaMLXmLVucIFOasjJvPJxgp3G/0/cmDmlQd67RT6tMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkRdu7T9rq5Se+1Rrfwvn5wVT8w8S0+uIERK5H7sX7k=;
 b=HXv81T6zIW6Qa8pVgdPYpJ6wLvPCKfrq6uJUnNfegeW/gU14S/MDFStq1okY6+ZEgOgxnyoXs/Psolvkg2DzWrMHFmlaRUxag9ugjENYOucqHPaBINKKCHZ+vUEhDAhR0s/9uT5ISqz0hyV6wM0N19GcvvO0fO4s1sSyYKtOB+MsTEYKRy4UYx7lsVhKt4GAIgvgAKQtIQWH4BmFcXjDgIUJ30J8FWYp72Pt6HhNEai1fmWHkCH8aE8KwBgmdD0+9msEBjim2qMxrDtgLq07Z25LB6AZBMmz5BNOGFXkpkCwBfsQwOe1exVQXkywm9aC0D8U9GddRlQESFYQkin8ow==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SEYPR06MB6984.apcprd06.prod.outlook.com (2603:1096:101:1de::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.13; Mon, 7 Oct
 2024 09:26:20 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Mon, 7 Oct 2024
 09:26:20 +0000
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
Subject:
 =?utf-8?B?UkU6IOWbnuimhjogW1BBVENIIHYxIDA4LzEwXSBhcm02NDogZHRzOiBhc3Bl?=
 =?utf-8?Q?ed:_Add_initial_AST27XX_device_tree?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggdjEgMDgvMTBdIGFybTY0OiBkdHM6IGFzcGVlZDog?=
 =?utf-8?Q?Add_initial_AST27XX_device_tree?=
Thread-Index: AQHa30uP3XAu0OFrb0ehga5NxGtcErII3N4AgB70k2uAAaSBAIBR561A
Date: Mon, 7 Oct 2024 09:26:20 +0000
Message-ID:
 <PSAPR06MB4949B860119DCC42C9BC0E42897D2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <20240726110355.2181563-9-kevin_chen@aspeedtech.com>
 <b6be1531-d8e2-44d1-a81a-6db8f9ae4ad4@kernel.org>
 <PSAPR06MB4949EC0D0E0DA16F50BBF40489802@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <aa3a1835-19e0-43a5-b6a4-4a7e531f3b2e@kernel.org>
In-Reply-To: <aa3a1835-19e0-43a5-b6a4-4a7e531f3b2e@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SEYPR06MB6984:EE_
x-ms-office365-filtering-correlation-id: f2a0986b-1520-425f-64ca-08dce6b21a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3J3bnlPdmkreHBIRjhOK2wvTno0Vkh1UG13MUpBdnJ2Tlh5WXQ5amVKZkNW?=
 =?utf-8?B?RVBZRVM5RzV0TEs0WFU0a0ZmUVBrT2h2c1E1anRqeUowZWlOWUt3M29yTXdK?=
 =?utf-8?B?NzQwWFlwU3RUY3pKSmxKVEp0NHVXMXhsa2Rkbm5zY1FrZ2NoSVl1U0ZVM2Vs?=
 =?utf-8?B?cW9mTnlIYS9HVHRpM1N4QmVCRDJSaDhwbkJvNWxjRERnSnZ5YnAwSjJQMCt2?=
 =?utf-8?B?TWpEYXNDUkozUEZQb0MzUzhFUHFyNStGOHV5Y3c1RlNHckptWXhsbFdJT3Q2?=
 =?utf-8?B?S0JkbmFFRFZqdWJGNU8yUkxicEh5RTI0SjMrMnArZk5SVUZBYmtsWTdBNHhN?=
 =?utf-8?B?b1N4MEJMcW1rclYxTzYwbzUxd0RJS2x4VURWUDBwQzNsd1FaN1FjdGNUemZN?=
 =?utf-8?B?aTdFcENtaVZITEMvdmllWEZDWVFyR1VHUy9QWVFHTXA4aFhGMlB0Q0E1WUtI?=
 =?utf-8?B?RHI1elF5U3l4OVpmY0psVHhjdlM0R0owaVAzUERHbk5va002aTRpejVuTmda?=
 =?utf-8?B?Szc0TFpxRk1UTko2TDJLYVJZZGFYN0NYeEhXUHgzT0svbGdOZHlSZVpaa2JD?=
 =?utf-8?B?OXdPWjllM0pxdmZIMlBRd0RpQXVxUkJDTXRoWmlWNmVtd05JY3dtNFk0V3JE?=
 =?utf-8?B?L2k2ZHB3RldRQURoazRGMWp1aDZKK2c3WThNZktWN0VaWTFacUxDM3NVWjdJ?=
 =?utf-8?B?ZmpOM1hyK0JaTFgzQUNsbWEwNFRabW9QQnR4a056QURXRkc4MlQxTFlmWVdi?=
 =?utf-8?B?VmFmbml2ODkvUXJyS2pEMW5FSjVNalJzZjI0OUtkU2swaHoybTV0dXpRTTZR?=
 =?utf-8?B?aUd1dHZiUXg3U2lPSC9jallNRmtUZUI4UkwvOFc4ZUEybkt2WEhUdk1PZFRP?=
 =?utf-8?B?NUVna1VYVVE5QVd2Z0tvZE5BclU4cDFaNGtLSUx4Uk9uZVhJcWs3M0MwZ2hs?=
 =?utf-8?B?alJkUFBMYkdmQTQ5Q21LSllTS1VMMVNRSlRCaDRTTlQzRmVEM3AvekdkalFa?=
 =?utf-8?B?Rm13a2V1VXFWY0hTaGV0V1FaWWZpOTlzanNlc3ZFaldtVGh1RG5qaGxvTHYz?=
 =?utf-8?B?c2lXVENDeHRyaFhLaXVSYStidHB3Q1JreEpSTTJoS0c2US9GTFFwRGxFdGh6?=
 =?utf-8?B?NVJxSEl1R3FtdHBEcEdjbjFwblRza2xyM1FudkI1UllPLzNzTXhUQWtZaUha?=
 =?utf-8?B?QVhCL1YvRDgvcys2Qk5vVVdNMXpoTXN6RjNoUzJ5THBxNGZSNEJTVGJZTHZu?=
 =?utf-8?B?Zzl3U0o5alB4b0MwZytEaGhJZG9LZnhjNTYwR2VPSnNxL2tUS1BOYytqTXlj?=
 =?utf-8?B?RVJWeE9TUkdFZEJidXpjTllUR3hKRjl6aHo3ZXdwc2hUdjBicG9CaXQxMVQ1?=
 =?utf-8?B?Y0w1MllOWmxxbUVpOEhwc0M4amI3ZEUrZ3NwVXF2UUE0TlUydUpNSWl2eTFE?=
 =?utf-8?B?NHh4V3FFenVoVDJqWHh0UHJTN1dMTnhqVDcwTFF1WlJjeUZCRHRlQTVhTTE3?=
 =?utf-8?B?YkZWd21tZHM2ZXlkT1hJd3RXcnpjcWh4WjFaRC9TK24vRk1scExOeDlXMStC?=
 =?utf-8?B?blZPVHFRUUZkL2VERklTZDZUUVRMRFhNWEpUeXZKaFlQNEhTb056ODJKVTF5?=
 =?utf-8?B?c0JKZ3ZVOG9Jdk8rUEZvUGtSbng5TW9aNDRyRk5XT1ZmVGZCQVgrTGpuaytP?=
 =?utf-8?B?NWx3UU5nYWFwK1lFZ0ZONkozK2kxcE12dFhEbzR1UmpnZEE2Q1h1aGExaGIr?=
 =?utf-8?Q?d1zhdpArUs39775P0g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFUvYVovbW9mUjJPdVZqZFJqcHpIMVBDUE1SRno3SHdKZVJ5bXBhSnR6SnFH?=
 =?utf-8?B?UW1pdDg4aFM1aUtWWFNWdjFKMmNrbUNwcDJQeGw3UFRNTDFrQm8wSzBPVW5T?=
 =?utf-8?B?YytkbHJjWlNObmE5WG5mODk0RG1nYlcxSTVFSXVJYkNPUkRkS0pzNmVZeXFu?=
 =?utf-8?B?bTBqb3g2R0NPT3JkcEVJN1lnRWRHTm1VQXBLZ1pJbHdKc0tiaUJRdllOR3Bn?=
 =?utf-8?B?ckJmS3JuN1ZCc0dpOFlURVNJeC8rYUJqZTFlV0NGZjRmcm9IMXh0azU1Y1Mw?=
 =?utf-8?B?UVQveUFObkxPeWl5MzhQL0QzNTZpZGdQMzJESzRwbjcyMGFYekFyU2tqeDFX?=
 =?utf-8?B?bGZPTWF1Q3RBVUhUalBTQnBOVzkyelZNU3pDMGllTmtoUW1QRGIyN2twVGJm?=
 =?utf-8?B?VGNoT0tWVTRSRUtFTWR5Y0xUNWtFalZxUnRwSkkrUnJENkZ1S0prVE8rQ0tj?=
 =?utf-8?B?TTVSYWVKcGtlVC84V1hRck1oUFJhdFRMdE1XbnBObTdiazVIN1hWUFNoT0Zk?=
 =?utf-8?B?WVFrTzUvN1Y4VzBqWnlIYzNsZi9GZnVhRkhIVGhBUUV1OGhMQXJOcElOenJq?=
 =?utf-8?B?TGlodFdRVjEvdHBlVkF2VldUWGpYYndhbGxnSDZyQTdGT1NMOGlkMUxpb3Ry?=
 =?utf-8?B?VmlOSXliMjZyYm5WUkIycDdxa2djZkY0OTY3bEhlWGFkSDUzMmxJVU00RzJE?=
 =?utf-8?B?cE05NEpYaHFaREM5bldIOFVrUVZLRElBM285VC9zNmhqSEFDQU5wczh5a1pn?=
 =?utf-8?B?RDN4YVNGUkk4Y2w3L1dRVk43VkloMXlUNFFPVmZrV1BiVU94V2JaOGtFRkxi?=
 =?utf-8?B?REE3YjJPZlU1SWJSMEFHTk82WWhRdGJHQnN5NGJ1TS90TFlZbnlBTFd4SEho?=
 =?utf-8?B?N2E3cEVCK2lBMVU5bFllWHc4VXFRczFwUnQ3RmRsOE1oT0xyUWJmbFBJL2Qr?=
 =?utf-8?B?QlZ3MGZEclBoUENMdEFMRjRzSmNkWDJ2SU1oU0IybWpEMU83Wm5vYVo2dUJN?=
 =?utf-8?B?ZTk3ZVBKQ0twVU9MajBNMHVqV1I4aVpQWkJpZDh0K2pxbGtVRUVqTVNNaTg1?=
 =?utf-8?B?d3JRNlhsUnpHMzBQTTZzOVFTTlN1d1hJblp0Yjc3VnNoa2lYVTA3dERYWXg0?=
 =?utf-8?B?TE8zeDJHYUxDOFkvVGhWVjk3TUpjQ05uRkk0dk0ySmVROCt0VjJlaCtPcmJL?=
 =?utf-8?B?VUFyL3dkWUZIK1QxM01wSDZuSUFaQjhrdm95TWJsVDV6Rml0SHBRcmF4Y05J?=
 =?utf-8?B?YXZHTjZJSGMwZWZLc2lqMW8vazJYSllGQ0o5YmFoc0RFMUh6SkNVeTl5L1A0?=
 =?utf-8?B?UGlsWms3OVJqQm5JRGxlVk1mN3NPUW5ic2Nabnk3SFUvbktXci9sNkh6SExx?=
 =?utf-8?B?b1laVW5wbkR3OXIrS0ZhWHBldjBZWkY4Z1o3emM4UHVMVTFib1pORTFYZllv?=
 =?utf-8?B?YlJqYjNXdTNuQXA2cWVDOFZqc0tHVVBQRDFqVWJHOWVGeUVMNGZYQWVUenVR?=
 =?utf-8?B?VlBYRkNSZlB2UzQyZW5Cdzg2N3huTXh3dWpwK3ZBYUw4dlAzdGh1QVpQclUz?=
 =?utf-8?B?ampLY080T2JNREdRMWdhYWdTdTdvSUZidEtSWkRqRzNEZ3h1UlVtc3FOV0xo?=
 =?utf-8?B?NVBZNEhUbDNXeURwZy9CN1hjdk1FTEVkZ1dkOGdEK1J4U2pIbGxsKzZMRzZF?=
 =?utf-8?B?WlJUQzFaMnkzTlVJQ2JleWNYcmgvV1U4WU1Pb3RxZTRVak5yNnFLOHp4Rk8y?=
 =?utf-8?B?WGVWRU5rc043QklOOEZHeFRLN0VQd1VMWlBIbFZUUzk0QURySVJsRHlMdWtt?=
 =?utf-8?B?d3Jha1FCL1lNeWszcU5YTnZGR0FEODBQcy9STytQTi9nN2NJMjNsSzRIWWNa?=
 =?utf-8?B?Rzhta3U3TThOM1I3eERQWnBQU0hqYitpdTlOV3haUUhJNWszQ0IvZFJVNzdM?=
 =?utf-8?B?OTNUMU90VkdEVUthU3N5bkFKMWxpUzlTb3FyNzNSdE8xTjNKbWFpUk9MQlo1?=
 =?utf-8?B?QjlFT3E1VDVGRWZhQzZVeS9ES2FPSWFuYSs3bzAvUUNRQU96bk9ZeEY2WXNS?=
 =?utf-8?B?aG9uWmR5d2RHMEcwemwxRGJjSElHNjdNZGZaVzVDQ1NmNkdBNjBZU1lQdVNH?=
 =?utf-8?Q?GIIAXJwYGzg7Mn1FX+RcroJmo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a0986b-1520-425f-64ca-08dce6b21a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 09:26:20.4124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axC4m0PJHv7FWlTgDGitMhKPnQE8MJ8YkWRAD4d/tpsupJyYo2sXVOJYuznt7eW6HkPZPtDOQZ3hDU10tLstfr0QuvS39HBnLSkcyJLh/+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6984

PiA+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1nNy5k
dHNpDQo+ID4+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1nNy5kdHNpDQo+
ID4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi44NThh
Yjk1MjUxZTQNCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvYXNwZWVkL2FzcGVlZC1nNy5kdHNpDQo+ID4+PiBAQCAtMCwwICsxLDIxNyBAQA0KPiA+
Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICNpbmNsdWRl
DQo+ID4+PiArPGR0LWJpbmRpbmdzL2Nsb2NrL2FzcGVlZCxhc3QyNzAwLWNsay5oPg0KPiA+Pj4g
KyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC9hc3BlZWQsYXN0MjcwMC1yZXNldC5oPg0KPiA+
Pj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+
DQo+ID4+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FzcGVl
ZC1zY3UtaWMuaD4NCj4gPj4+ICsNCj4gPj4+ICsvIHsNCj4gPj4+ICsgICAgIG1vZGVsID0gIkFz
cGVlZCBCTUMiOw0KPiA+Pg0KPiA+PiBNb2RlbCBvZiB3aGF0PyBObywgZHJvcC4NCj4gPiBDYW4g
SSBjaGFuZ2UgdG8gIm1vZGVsID0gIkFTVDI3MDAgRVZCIiINCj4gDQo+IE1vZGVsIG9mIHdoYXQ/
IE5vLCBpdCBkb2VzIG5vdCBtYWtlIHNlbnNlIGhlcmUuDQpTaG91bGQgSSBjaGFuZ2UgdG8gbW9k
ZWwgPSAiQXNwZWVkIEJNQyBTb0MiOw0KDQo+IA0KPiANCj4gLi4NCj4gDQo+IA0KPiA+Pj4gKw0K
PiA+Pj4gKyAgICAgICAgICAgICB1YXJ0MTI6IHNlcmlhbEAxNGMzM2IwMCB7DQo+ID4+PiArICAg
ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJuczE2NTUwYSI7DQo+ID4+PiArICAgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDB4MCAweDE0YzMzYjAwIDB4MCAweDEwMD47DQo+ID4+PiAr
ICAgICAgICAgICAgICAgICAgICAgcmVnLXNoaWZ0ID0gPDI+Ow0KPiA+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgIHJlZy1pby13aWR0aCA9IDw0PjsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
ICBjbG9ja3MgPSA8JnN5c2NvbjENCj4gU0NVMV9DTEtfR0FURV9VQVJUMTJDTEs+Ow0KPiA+Pj4g
KyAgICAgICAgICAgICAgICAgICAgIG5vLWxvb3BiYWNrLXRlc3Q7DQo+ID4+PiArICAgICAgICAg
ICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPj4NCj4gPj4gV2hhdCBp
cyB0aGlzPw0KPiA+IEJNQyB1YXJ0IHVzaW5nIGluIHVhcnQxMiBpbiBzb2MxLg0KPiANCj4gTm8s
IHRoYXQgbGluZS4gcGluY3RybC1uYW1lcyBkbyBub3QgbWFrZSBzZW5zZSBoZXJlIHdpdGhvdXQg
dmFsdWVzLg0KQWdyZWUsIEkgd2lsbCByZW1vdmUgdGhlIGxpbmUgb2YgcGluY3RybC1uYW1lcyBp
biBuZXh0IHBhdGNoLg0KUGluY3RybCBwcm9wZXJ0eSBuZWVkZWQgdG8gYmUgZGVmaW5lZCBpbiB0
aGUgZnV0dXJlIHBhdGNoZXMuDQoNCj4gDQo+ID4NCj4gPj4NCj4gPj4+ICsgICAgICAgICAgICAg
fTsNCj4gPj4+ICsgICAgIH07DQo+ID4+PiArfTsNCj4gPj4+ICsNCj4gPg0KPiA+IC0tDQo+ID4g
QmVzdCBSZWdhcmRzLA0KPiA+IEtldmluLiBDaGVuDQo+ID4NCj4gDQo+IFdoeSBkbyB5b3UgcXVv
dGUgbXkgZW1haWwgdHdpY2U/DQo+IA0KPiANCj4gLi4uDQo+IA0KPiA+PiArICAgICAgICAgICAg
IHVhcnQxMjogc2VyaWFsQDE0YzMzYjAwIHsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAibnMxNjU1MGEiOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgcmVnID0g
PDB4MCAweDE0YzMzYjAwIDB4MCAweDEwMD47DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICBy
ZWctc2hpZnQgPSA8Mj47DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICByZWctaW8td2lkdGgg
PSA8ND47DQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JnN5c2NvbjENCj4g
U0NVMV9DTEtfR0FURV9VQVJUMTJDTEs+Ow0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgbm8t
bG9vcGJhY2stdGVzdDsNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMg
PSAiZGVmYXVsdCI7DQo+ID4NCj4gPiBXaGF0IGlzIHRoaXM/DQo+ID4NCj4gPj4gKyAgICAgICAg
ICAgICB9Ow0KPiA+PiArICAgICB9Ow0KPiA+PiArfTsNCj4gPj4gKw0KPiA+DQo+ID4gQmVzdCBy
ZWdhcmRzLA0KPiA+IEtyenlzenRvZg0KPiA+DQo+IG90aGVyIGNvbmZpZGVudGlhbCBpbmZvcm1h
dGlvbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgaXQgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhl
DQo+IHNlbmRlciBieSByZXBseSBlLW1haWwgYW5kIGltbWVkaWF0ZWx5IGRlbGV0ZSB0aGUgZS1t
YWlsIGFuZCBhbnkNCj4gYXR0YWNobWVudHMgd2l0aG91dCBjb3B5aW5nIG9yIGRpc2Nsb3Npbmcg
dGhlIGNvbnRlbnRzLiBUaGFuayB5b3UuDQo+IA0KPiBNYXliZSBJIGFtIHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQgb2YgeW91ciBtZXNzYWdlLCBtYXliZSBub3QuIEkgZG9uJ3Qgd2FudCB0bw0KPiBo
YXZlIGFueSBsZWdhbCBxdWVzdGlvbnMgcmVnYXJkaW5nIHVwc3RyZWFtLCBwdWJsaWMgY29sbGFi
b3JhdGlvbiwgdGh1cw0KPiBwcm9iYWJseSBJIHNob3VsZCBqdXN0IHJlbW92ZSB5b3VyIG1lc3Nh
Z2VzLg0KPiANCj4gUGxlYXNlIHRhbGsgd2l0aCB5b3VyIElUIHRoYXQgc3VjaCBkaXNjbGFpbWVy
cyBpbiBvcGVuLXNvdXJjZSBhcmUgbm90IGRlc2lyZWQNCj4gKGFuZCBtYXliZSBldmVuIGhhcm1m
dWwpLg0KPiBJZiB5b3UgZG8gbm90IHVuZGVyc3RhbmQgd2h5LCBwbGVhc2UgYWxzbyBzZWU6DQo+
IGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL2xpdmUvZk1lSDd3cU93WEE/c2k9R1k3aWdmYmRhNnZu
alhsSiZ0PTgzNQ0KPiANCj4gSWYgeW91IG5lZWQgdG8gZ28gYXJvdW5kIGNvbXBhbnkgU01UUCBz
ZXJ2ZXIsIHRoZW4gY29uc2lkZXIgdXNpbmcgYjQNCj4gd2ViLXJlbGF5OiBodHRwczovL2I0LmRv
Y3Mua2VybmVsLm9yZy9lbi9sYXRlc3QvY29udHJpYnV0b3Ivc2VuZC5odG1sDQo+IA0KPiBQbGVh
c2UgYmUgaW5mb3JtZWQgdGhhdCBieSByZXNwb25kaW5nIHRvIHRoaXMgZW1haWwgeW91IGFncmVl
IHRoYXQgYWxsDQo+IGNvbW11bmljYXRpb25zIGZyb20geW91IGFuZC9vciB5b3VyIGNvbXBhbnkg
aXMgbWFkZSBwdWJsaWMuIEluIG90aGVyIHdvcmRzLA0KPiBhbGwgbWVzc2FnZXMgb3JpZ2luYXRp
bmcgZnJvbSB5b3UgYW5kL29yIHlvdXIgY29tcGFueSB3aWxsIGJlIG1hZGUgcHVibGljLg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

