Return-Path: <linux-kernel+bounces-233433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD6391B703
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343D71F2397A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A85644E;
	Fri, 28 Jun 2024 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OxzdGetO"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1655893;
	Fri, 28 Jun 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556124; cv=fail; b=SRNF0qgoVKiEimKPUd9xkXD6YTWA6DhIgBWQxZCywc9yAdx66/V/HvMrFLsRjyFJFPhjcPpIcTbCbnIHmiiTOp6tXrb9GspjkEl86kp0/LfQ2BBwxYGjXcMxgGxeEPQUTVwjrRBgv7ccxovxvsS6TyV1iXeWE8fAbIz/LMAbyf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556124; c=relaxed/simple;
	bh=9810tIGPJKUYzId1p5AGF1J6iJmw22VMzDtc5SWzgJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pftMVVOgq43xkErg4GlcL8FerXL+FSBHS01EzyzCn7q2mpDeiagqKJAD4QFQ/dfdYitvY/hKK054rA9Zr55ETafr1+PpandABrCdN6WOISBrAv7jxCepZiwkNjoqeWwg6LMDE1mUcOIGU9AyDUgr2avFUAPC2l2VXGfz7qtJNrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OxzdGetO; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSmgM8IsX53tCExBDJ1buOFTDC3GveITip89Fwfbnrlr9s92fSCekkyw4qy8sCpFKDaIuzjisWtUV1FlPru8tUZu9pJnMEevhSfaQBg+DvxPWH/Oqt+bQRLtHedxVA7MYY//fXC7JzB/OQ3Ryipmrt5FO14aUfa4VYoTePtSG2HFCAEBrnHgoKdMcGSmQeUqjW+TXx4i4IrnpsU2iol3FRLvceAY435NUaVmvMTOIQLrVajHlD6qGxVFk+Wb3zf0cRy5vS+HijlbELqKA2LH15btck1R8MpZe60benhbO01SZu34mpY7UZ7h/mZCzQ0XAthkFlwLuz1XSSKGwTclbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9810tIGPJKUYzId1p5AGF1J6iJmw22VMzDtc5SWzgJQ=;
 b=IO0u/8ahwEHzGhms+pnak8Hi7am8vxQJPfBcj7jo9alDCKsH/XTFjUx6X1tsXSf+IOk4spSRl+R4+lrLG1IGhnA6/OC9npCcqGZplt0Dha+mYtHZdhgBedOKq9iCfIVtVgoGNg2b5c29RKlCOZGuJvXNtMLOBKdo6By802Kmrl7ZWnq+7WD037VqRx/tp9hnIYX2HnFkJgF217GBuz0nLStPoXPO0LmxAFOIQkrswl4j2WBWX6rdvtJry868XBlcI4Puz8TjSRXXu0QQE3NBEL1MclWahrNsnk1cGSiGiXTDxY1l9JFceryfdXpiWuaYvufi2VqS4OsTu9hL2KBqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9810tIGPJKUYzId1p5AGF1J6iJmw22VMzDtc5SWzgJQ=;
 b=OxzdGetOTx2xXaMlu9x+bEEuJJjyz3Av0S0QuGx94Dkq5baVlTKHhKaio5jiv71Mwqr/bBGFgVh5Nc4TlM83YLK85KO36wSr75Og1rsVGxFlxA76L5EEEXnKOuLMh98oMKWhOIa+rOO1pRk98suQ6Y5TwXbxPJOARi84ajjMr+E=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PA1PR04MB10625.eurprd04.prod.outlook.com (2603:10a6:102:48a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 06:28:38 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 06:28:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Pengfei Li <pengfei.li_1@nxp.com>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "abelvesa@kernel.org" <abelvesa@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, Jacky Bai <ping.bai@nxp.com>, Ye Li
	<ye.li@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Frank Li
	<frank.li@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Thread-Topic: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Thread-Index:
 AQHaxqICs0HdElmggEaM9UqDqnF2eLHYGdAAgAAyBQCAADFugIAD5tIAgABVXYCAAADGEA==
Date: Fri, 28 Jun 2024 06:28:38 +0000
Message-ID:
 <AM6PR04MB5941D63D1AD2CE63E8D0388F88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
 <20240625175147.94985-2-pengfei.li_1@nxp.com>
 <39bcab8b-ed9c-4da9-b1ee-32dbfb2a23a4@kernel.org>
 <ZnqfIudepX4sH4oL@pengfei-OptiPlex-Tower-Plus-7010>
 <61c1eb8b-b8fd-4e9e-b0fc-27ce1c2eb2b1@kernel.org>
 <AM6PR04MB5941061D0DCA71B31F44497488D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <79955001-132c-4eef-b741-9e6a35da1361@kernel.org>
In-Reply-To: <79955001-132c-4eef-b741-9e6a35da1361@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PA1PR04MB10625:EE_
x-ms-office365-filtering-correlation-id: 9b3b9ed9-fedd-4a62-7b72-08dc973b8bda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTByUENsa3FLVHViN2s2dmNTbFFEOWYvekVOTUxjR01wTEFEaldIMzJwWUxV?=
 =?utf-8?B?Q1NjbG1GZ1ovbGc0cThTODVTVDNPNGw0UW9tajB4TmVNbTZmWXV0MXN5V0Rj?=
 =?utf-8?B?cmp6OWhxcTE2MmIwSGh0OGpseXpPWFFCMUVzQjZ5ZndSY2l1UTNNNkVKSElI?=
 =?utf-8?B?T2dHcVI3Zm9qUXk3ZmlTZndkaXBkRVI5V1k2UzNESGdQZ1N3RjhEaGFBMDNa?=
 =?utf-8?B?VkJDSU5ZTDVMeGZadjEwZXdIVXJ4alNjU1dLMlQ2T0NRYXp1MURUaGFEdm9T?=
 =?utf-8?B?bHFyRDRocG1ESHF1UEFLbi9YOEl1Zys0MnRHVDZRczlHSnNZTllkQy82dXUz?=
 =?utf-8?B?QjV3UXg5RUM1VmdOdTQ1cGtuVWY3a2UvYmNFMzQ4TCs0K0lobmdzOGg5RjA5?=
 =?utf-8?B?RUJDUzNkUmZCRzhqeXVFdFR2azU3RDlBajJZbzZhNEZqS2dMMlp4WFA0OUhx?=
 =?utf-8?B?NGM2UUxoMEptUm1XZzBPSmR4ZXNOZEEyWk54TmI5MGRMVEtYMXpyK1JrQlNR?=
 =?utf-8?B?TkNIeUhvV2xKenYwc0ZoQ2h5amVZODgyczJNRHhaVi91YWRGQUh3QjQ0TW1V?=
 =?utf-8?B?TWQwZUw1aGg0Qk5TUHRVUW1IN0c2cDMzMzdpQzBVbzVxMG1jWWtMWnJlRk1K?=
 =?utf-8?B?MGJUSE5SSmlxNGJpUHd6S042ektUaG45MXo5YTBWVTZEQm9ycTNwNDRrQUha?=
 =?utf-8?B?M0FmVk1zSi9NV0FNZXpaVGswSFMxQXNEREd1dGQ5YllhN1dtbERTR2p4NTBD?=
 =?utf-8?B?Z2Myekd0eWw4Mk9OaExuM0M5VkdTSjg0YXpWQXMxUDZSSStlVnhiRlBHWkg1?=
 =?utf-8?B?L3BxM1BhMEhVWktrL0dvaFRnTGQ3WFpmcVlWbzlQMS9CbVR3RWlvaU5wZDYy?=
 =?utf-8?B?dTc3RVc1UzA0bW9SNC9mc0xaZXExRFRQOFlPL1ExWkVsZkx1TXRVTWRvMUJ0?=
 =?utf-8?B?K1ZsK3Y5Tkh3WnZSbFN1U3ZMK3VjNnVkYy9DMU8veUw2NXB5Yk52TExLSnZZ?=
 =?utf-8?B?ZEFKenMrZWFaekJNaTBGNHl4ZE11UlJRUUx6bE5nVndrWjF4MktqQ3VxV1JD?=
 =?utf-8?B?Qi9QS3BHUldUZms5bGk1eEFQNWIrY0tsWGNWWlNjQXp1Qzh4ZVQ4aWdwOXBy?=
 =?utf-8?B?b25WNXIyNmlqWEpDUkk0d0ZmYWpqSnVpTnFzNWZTMlFFelJ3cW9BUTJKUEVo?=
 =?utf-8?B?aVUzNU5zWE1jVkR3WGZKRC91bms5UkJxUWlyY21SZTZ3QVhKWlB4WjVCbEw4?=
 =?utf-8?B?M0NLbjFwUEVjdS8wd0owL24rcTRNYi92bFBtanhVaDg1UHpUWTF2MUI0QVV6?=
 =?utf-8?B?d2RwR2MxNVBrd2dGcWdGbUZhbGxZQnpZM01ZLzFGeTZSZTVReE11MWw4REpF?=
 =?utf-8?B?emp6LytXMTNrZjJleUlHRklSVjFwWkF0OGhMeWlRTTMwdnBoY2JONWpZdHhP?=
 =?utf-8?B?V1hPbUFLVTRaMG9WVDZpQ3o5d2dPWjZSVVMza3haaS9DVCtyV2NMNUt1VTFI?=
 =?utf-8?B?LzUxUjIzb28zUWprUVZJVG9IRk5WNzl4OWNxelZIRVNuekdlditLNWRlMEdP?=
 =?utf-8?B?aGRxOUxkYTFQOEFPc0F5Mk9aZzh0SVRybzRPNXdIU0g5elFZN3JTdDE2dW13?=
 =?utf-8?B?cERZNkdtQ1dXdlhCQjRXeFp2Zk1WL01GOVhqMGt2Q1BoZ0lNRDdZdEZvUktu?=
 =?utf-8?B?T29KK1dzdUE1bDdQdWZjZENDeUlyWUZjcTl5RTRES0tPUFlkbHIybGdOSjF5?=
 =?utf-8?B?U213bVRkMmJrWDczUDBsUVZkbDlDOUhPWEFudFFTaHRMVjVSN2tLMUZpZmZ5?=
 =?utf-8?B?T3ZXVS9CZGJkMmM4SUs3YWtkblJWbDhDeHN6VjNiSnpwZlNWemtSa1E5YlJD?=
 =?utf-8?B?b0hzRmovclBBRm1lSjk4cDlZeWJTOGJUS1RVRmtkd1RNYlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTQwWWE2YVBkM2MraUVoMXY5SWQ3QW9vb1BJSzFndjh4Qndvc0JaVDBLS3gy?=
 =?utf-8?B?U2RNNnQrR2dEOEdQS0xseko2UWUwVnQ2cGtidisvT2FCRytudkFpeXcvV0RT?=
 =?utf-8?B?OEd6MXc1SzFNcjZHSGpsWUQ1NC93VnFaWVcrN1crU2EyY2JxMVlvSHYvSzlQ?=
 =?utf-8?B?YS9OalZDTFZqWVkwaTRhTFF6ODFuSExNcVJIUjNWUHA5OGg5QVpLeW9iT3BO?=
 =?utf-8?B?NitxOWk2VzBmQXRQWVQzQ2dTT3U0NjUzcHByakVhUnNCdE5iTlVVNlVOUk92?=
 =?utf-8?B?cnUwckszOXJNdnl3anFMN2RabWNIZFlxRHBMajhnenJnQ3kwaWhwaVUva3Nq?=
 =?utf-8?B?bGJyVnR1ZlZ6cWdFWjBKUVpLbjBHSWZNdmw2V2xyMUhtVkFscFBtN1VvQ0Ft?=
 =?utf-8?B?TmF3NzVMRUNmV3B2MTNFaHlIUlJSb01xeHVOSThqNXZqREdPRFp0R0g4UVR0?=
 =?utf-8?B?STdKS3MvZW9nOVBwOVFod29wN05RK1VrVHdBMUhUcWRoRXYwZW1kSlNFQ011?=
 =?utf-8?B?ekNWQnVKWVMyV1pOOVVQeUQ0MGplNWN6TEpjbWhUT0Zkd01WZWNTWWFqT0RF?=
 =?utf-8?B?RmdwdTRzZ1NzU3dkM1QvbXViaU5JSy9ieGhKZVNMR3U3MUxHZ3NYeXEyTXYy?=
 =?utf-8?B?STlnaU5rQUZDWHpPbFFDWEZTZm04VEF0dGFwR2ZQaEJ5MFFaTHVsR1dZS3Iv?=
 =?utf-8?B?ejVsSlJYM3I4ZTdDMDd5TFhqdEFad05UZk1BL2lMYS9qd3laMFp1akt0Y0tW?=
 =?utf-8?B?L3V0U3RHMmErS0NRczNjSnNXNkZqVmRTeHZUTTA0MjZEaW1LWEdHbFBTVlVl?=
 =?utf-8?B?VUpGd3Nyb3ZNTTBKMlhreGV6UmhNanZ1ZEVDZDc2RDFxazhaZDVESHpaY3Vw?=
 =?utf-8?B?WTUydjAxLzlmQ2VVVUR2OTFqcEJjU1dKU0RibUJYM1hWZWw0bmxQMHo5VTFR?=
 =?utf-8?B?UENQSy9NckcwSDRtQlZQaVV0VGJmbU96aE1GNnlHSjVRZHM2ZXRVa21PTktv?=
 =?utf-8?B?QkdCZngybWduVG55eW9WbTlYck5BbDludXpUb0N6VU1VVTNEWUFVMEZyUUM2?=
 =?utf-8?B?WllyZXBuV1FMeHhuMmxySGM1eVhtN1VCMGlqK0JVQjRYd29XVG1tVnhPeWc5?=
 =?utf-8?B?K0pnZG4rM2xvZm5tNHFaa0ltZkhBbktEdnVnd0tuRTFHdlBEakhLSTlaMjRz?=
 =?utf-8?B?cnF2bEVJUW9Db1V1WDk3UzFrSUxiWVBHazhDRnlVK1RqVUN1c1BBMy9BTVg0?=
 =?utf-8?B?eEZSNCszQVlBVVBTZlNaaHduZXVlYVZPekR3Nm1DVkRJNDEzWVdtTVlnR2xZ?=
 =?utf-8?B?WHJVMTI2UWV5RU5Od3MvR0txL2ZyL05SOEl3VVgwQzN6OGJkWllLYm9aNG9O?=
 =?utf-8?B?MGl3NkpYY2c3T0pvRVVKRW5IRU9YY3VGWWJPMzIybnpLM2Qwa2M2T0tuZjdC?=
 =?utf-8?B?eVM5SXFDUkJXdUo2L2dETnlpSFBvS3hLTkYxdHJBL3VRV0ZVSEhTS1UybUtL?=
 =?utf-8?B?WjIzVEhBSUJaM3RWa1BLWFlCQ2YwZDR5aEkvS2x4Q0xRWmFrTFRud0FZbkRW?=
 =?utf-8?B?RmV6eHg5ckRIN3dkOTFHb3A1SjZ2ZlM0dEcwZmRJSGNpcWR6N1lWUERpaFBZ?=
 =?utf-8?B?SWd6M01XSGV5M3B4SzRaR1QzM1VQMXlsYWF6VERyQUdZb2N6MkQ4Wm5XeUxp?=
 =?utf-8?B?NmVpWkpxcnNUbTNaa2RRaGRjWGhSR0grQURETmdxWW1xZkpaV0Z1RkNtZERH?=
 =?utf-8?B?TWNiNVJJOWU1cHN6NEI0OWpMaVM5SnNtemhodWJKQ1N0ZkVRYWlYUktybjRZ?=
 =?utf-8?B?WjdwNkR1YjZwNHBIeE4wZlg0WGRPTk1RMlcwcSt5d0lpWklZajVKbndBcFhB?=
 =?utf-8?B?ZGpiM3FOWnB2ejlxZWxMVXQweHBtd0s1Q0paY0gxaGo1M1BNSGFVYy94MTl3?=
 =?utf-8?B?M3hGUFQxTFh3eG96b2Ewb3hpRXRoMnpHMFZSTlM0cVZzeVMxOGZKU1ZGTVhq?=
 =?utf-8?B?cjNoZU5seHhtTU5aYmV0b0FOaFhZZWExWUZVY1hkblpWYWxpN2oxMCt2ajNL?=
 =?utf-8?B?SnRLazk1OXdBRWdYdnhwT2lVVURzVUJ4UnM4b3VZQjk3TCtENkZsQVJZK05U?=
 =?utf-8?Q?Vc+k=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3b9ed9-fedd-4a62-7b72-08dc973b8bda
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 06:28:38.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89MqxKYX5vd+mf9BP9UXGcGRbuAwmBtoiR7LG44I36cz5CgyfpVezpAErDWevVxXsK4uAgYBjRw0N4x5kEIjnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10625

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gY2xrOiBpbXg5MzogRHJvcCBtYWNybyBJTVg5M19D
TEtfRU5EDQo+IA0KPiBPbiAyOC8wNi8yMDI0IDAzOjE3LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGNsazogaW14OTM6IERyb3AgbWFjcm8gSU1YOTNfQ0xL
X0VORA0KPiA+Pg0KPiA+PiBPbiAyNS8wNi8yMDI0IDEyOjQzLCBQZW5nZmVpIExpIHdyb3RlOg0K
PiA+Pj4gT24gVHVlLCBKdW4gMjUsIDIwMjQgYXQgMDk6NDQ6NDJBTSArMDIwMCwgS3J6eXN6dG9m
IEtvemxvd3NraQ0KPiA+PiB3cm90ZToNCj4gPj4+PiBPbiAyNS8wNi8yMDI0IDE5OjUxLCBQZW5n
ZmVpIExpIHdyb3RlOg0KPiA+Pj4+PiBJTVg5M19DTEtfRU5EIHdhcyBwcmV2aW91c2x5IGRlZmlu
ZWQgaW4gaW14OTMtY2xvY2suaCB0bw0KPiA+PiBpbmRpY2F0ZQ0KPiA+Pj4+PiB0aGUgbnVtYmVy
IG9mIGNsb2NrcywgYnV0IGl0IGlzIG5vdCBwYXJ0IG9mIHRoZSBBQkksIHNvIGl0IHNob3VsZA0K
PiA+Pj4+PiBiZSBkcm9wcGVkLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBOb3csIHRoZSBkcml2ZXIgZ2V0
cyB0aGUgbnVtYmVyIG9mIGNsa3MgYnkgcXVlcnlpbmcgdGhlDQo+IG1heGltdW0NCj4gPj4+Pj4g
aW5kZXggaW4gdGhlIGNsayBhcnJheS4gRHVlIHRvIHRoZSBkaXNjb250aW51aXR5IGluIHRoZSBk
ZWZpbml0aW9uDQo+ID4+Pj4+IG9mIGNsayBpbmRleCwgd2l0aCBzb21lIGdhcHMgcHJlc2VudCwg
dGhlIHRvdGFsIGNvdW50IGNhbm5vdCBiZQ0KPiA+Pj4+PiBvYnRhaW5lZCBieSBzdW1taW5nIHRo
ZSBhcnJheSBzaXplLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nZmVpIExp
IDxwZW5nZmVpLmxpXzFAbnhwLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICBkcml2ZXJzL2Ns
ay9pbXgvY2xrLWlteDkzLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4+Pj4+
ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPj4+
Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OTMuYw0KPiA+
Pj4+PiBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OTMuYyBpbmRleA0KPiBjNmE5YmM4ZWNjMWYu
LjY4YzkyOTUxMmUxNg0KPiA+Pj4+PiAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg5My5jDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OTMu
Yw0KPiA+Pj4+PiBAQCAtMjU3LDYgKzI1NywyMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteDkz
X2Nsa19jY2dyDQo+ID4+IHsgIHN0YXRpYw0KPiA+Pj4+PiBzdHJ1Y3QgY2xrX2h3X29uZWNlbGxf
ZGF0YSAqY2xrX2h3X2RhdGE7ICBzdGF0aWMgc3RydWN0IGNsa19odw0KPiA+Pj4+PiAqKmNsa3M7
DQo+ID4+Pj4+DQo+ID4+Pj4+ICtzdGF0aWMgaW50IGlteF9jbGtzX2dldF9udW0odm9pZCkgew0K
PiA+Pj4+PiArCXUzMiB2YWwgPSAwOw0KPiA+Pj4+PiArCWludCBpOw0KPiA+Pj4+PiArDQo+ID4+
Pj4+ICsJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocm9vdF9hcnJheSk7IGkrKykNCj4gPj4+
Pj4gKwkJdmFsID0gbWF4X3QodTMyLCB2YWwsIHJvb3RfYXJyYXlbaV0uY2xrKTsNCj4gPj4+Pj4g
Kw0KPiA+Pj4+PiArCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGNjZ3JfYXJyYXkpOyBpKysp
DQo+ID4+Pj4+ICsJCXZhbCA9IG1heF90KHUzMiwgdmFsLCBjY2dyX2FycmF5W2ldLmNsayk7DQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gKwlyZXR1cm4gdmFsICsgMTsNCj4gPj4+Pj4gK30NCj4gPj4+Pj4g
Kw0KPiA+Pj4+PiAgc3RhdGljIGludCBpbXg5M19jbG9ja3NfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikgIHsNCj4gPj4+Pj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+
ZGV2OyBAQCAtMjY0LDE0ICsyNzgsMTcgQEANCj4gc3RhdGljDQo+ID4+Pj4+IGludCBpbXg5M19j
bG9ja3NfcHJvYmUoc3RydWN0DQo+ID4+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPj4+Pj4g
IAljb25zdCBzdHJ1Y3QgaW14OTNfY2xrX3Jvb3QgKnJvb3Q7DQo+ID4+Pj4+ICAJY29uc3Qgc3Ry
dWN0IGlteDkzX2Nsa19jY2dyICpjY2dyOw0KPiA+Pj4+PiAgCXZvaWQgX19pb21lbSAqYmFzZSwg
KmFuYXRvcF9iYXNlOw0KPiA+Pj4+PiArCWludCBjbGtzX251bTsNCj4gPj4+Pj4gIAlpbnQgaSwg
cmV0Ow0KPiA+Pj4+Pg0KPiA+Pj4+PiArCWNsa3NfbnVtID0gaW14X2Nsa3NfZ2V0X251bSgpOw0K
PiA+Pj4+PiArDQo+ID4+Pj4+ICAJY2xrX2h3X2RhdGEgPSBkZXZtX2t6YWxsb2MoZGV2LCBzdHJ1
Y3Rfc2l6ZShjbGtfaHdfZGF0YSwNCj4gPj4gaHdzLA0KPiA+Pj4+PiAtCQkJCQkgIElNWDkzX0NM
S19FTkQpLA0KPiA+PiBHRlBfS0VSTkVMKTsNCj4gPj4+Pj4gKwkJCQkJICBjbGtzX251bSksIEdG
UF9LRVJORUwpOw0KPiA+Pj4+PiAgCWlmICghY2xrX2h3X2RhdGEpDQo+ID4+Pj4+ICAJCXJldHVy
biAtRU5PTUVNOw0KPiA+Pj4+Pg0KPiA+Pj4+PiAtCWNsa19od19kYXRhLT5udW0gPSBJTVg5M19D
TEtfRU5EOw0KPiA+Pj4+PiArCWNsa19od19kYXRhLT5udW0gPSBjbGtzX251bTsNCj4gPj4+Pg0K
PiA+Pj4+IFdoeSBzbyBjb21wbGljYXRlZCBjb2RlIGluc3RlYWQgb2YgcHJlLXByb2Nlc3NvciBk
ZWZpbmUgb3IgYXJyYXkNCj4gPj4gc2l6ZT8NCj4gPj4+Pg0KPiA+Pj4+IEJlc3QgcmVnYXJkcywN
Cj4gPj4+PiBLcnp5c3p0b2YNCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSGkgS3J6eXN6
dG9mLA0KPiA+Pj4NCj4gPj4+IFRoYW5rcyBmb3IgdGhlIGNvbW1lbnQsIGhlcmUgYXJlIHNvbWUg
b2Ygb3VyIHRob3VnaHRzLg0KPiA+Pj4NCj4gPj4+IFJlZ2FyZGluZyB0aGUgcHJlZGVmaW5lZCBt
ZXRob2QsIGl0J3MgZWFzeSB0byBmb3JnZXQgdG8gdXBkYXRlIHRoZQ0KPiA+Pj4gbWFjcm8gZGVm
aW5pdGlvbiB3aGVuIGFkZGluZyBzb21lIG5ldyBjbG9ja3MgdG8gaW14OTMtY2xvY2suaCBpbg0K
PiA+PiB0aGUgZnV0dXJlLg0KPiA+Pg0KPiA+PiBTb21laG93IG1vc3QgZGV2ZWxvcGVycyBpbiBt
b3N0IHBsYXRmb3JtcyBjYW4gZG8gaXQuLi4gQW55d2F5LA0KPiB0aGF0DQo+ID4+IHdvdWxkIGJl
IGJ1aWxkIHRpbWUgZGV0ZWN0YWJsZSBzbyBubyBwcm9ibGVtIGF0IGFsbC4NCj4gPj4NCj4gPj4+
DQo+ID4+PiBBbHNvLCB3ZSBjYW5ub3QgdXNlIHRoZSBhcnJheSBzaXplIG1ldGhvZCBpbiB0aGlz
IHNjZW5hcmlvLCBhcyBzb21lDQo+ID4+PiB1bm5lY2Vzc2FyeSBjbG9ja3MgaGF2ZSBiZWVuIHJl
bW92ZWQgaW4gdGhlIHBhc3QsIHJlc3VsdGluZyBpbg0KPiA+Pj4gZGlzY29udGludW91cyBkZWZp
bml0aW9ucyBvZiBjbG9jayBpbmRleGVzLiBUaGlzIG1lYW5zIHRoYXQgdGhlDQo+ID4+PiBtYXhp
bXVtIGNsb2NrIGluZGV4IGNhbiBiZSBsYXJnZXIgdGhhbiB0aGUgYWxsb2NhdGVkIGNsa19odw0K
PiBhcnJheQ0KPiA+PiBzaXplLiBBdCB0aGlzIHBvaW50LCB1c2luZyB0aGUgbWF4aW11bSBpbmRl
eCB0byBhY2Nlc3MgdGhlIGNsa19odw0KPiA+PiBhcnJheSB3aWxsIHJlc3VsdCBpbiBhbiBvdXQg
b2YgYm91bmRzIGVycm9yLg0KPiA+Pg0KPiA+PiBZb3UgbWl4IGJpbmRpbmdzIHdpdGggYXJyYXkg
ZW50cmllcy4gVGhhdCdzIGluZGVwZW5kZW50IG9yIGp1c3QgY2xvY2sNCj4gPj4gZHJpdmVycyBh
cmUgYnJva2VuLg0KPiA+DQo+ID4gQnV0IHRoZXJlIGlzIGlzc3VlIHRoYXQgYmluZGluZyB1cGRh
dGUgYW5kIGNsb2NrIGRyaXZlciBhcmUgbm9ybWFsbHkNCj4gPiBpbiB0d28gcGF0Y2hlcy4gIFNv
IGlmIGp1c3QgdXNlIHRoZSBJTVg5M19DTEtfRU5EIGluIHRoaXMgZmlsZSwgaXQNCj4gPiB3aWxs
IGJlIGVhc3kgdG8gYnJlYWsgYGdpdCBiaXNlY3RgLg0KPiANCj4gVGhlcmUgaXMgbm8gaXNzdWUu
IFNyc2x5LCB0aGlzIHdvdWxkIGJlIHRoZSBvbmx5LCBvbmx5IG9uZSBkcml2ZXIgaGF2aW5nDQo+
IHRoYXQgaXNzdWUuDQo+IA0KPiBIb3cgaXMgdGhpcyBldmVuIHBvc3NpYmxlPyBIb3cgYWRkaW5n
IG9uZSBuZXcgZGVmaW5lIGZvciBwcmUtDQo+IHByb2Nlc3NvciB3b3VsZCBjYXVzZSBkcml2ZXIg
aXNzdWVzIG9yIHNvbWUgc29ydCBvZiBiaXNlY3RhYmlsaXR5DQo+IHByb2JsZW1zPw0KDQpBaCwg
SSB3YXMgd3JvbmcsIEkganVzdCB0aG91Z2h0IGRyaXZlciB1cGRhdGUgaXMgYXBwbGllZCBmaXJz
dC4NCg0KV2l0aCBiaW5kaW5nIHVwZGF0ZSBhcHBsaWVkIGZpcnN0LCB0aGVuIGRyaXZlciB1cGRh
dGUgYXBwbGllZCwNCnRoZXJlIGlzIG5vIGlzc3VlLg0KDQpSZWdhcmRzLA0KUGVuZy4NCg0KPiAN
Cj4gVGhlc2UgYXJlIGJhc2ljcyBvZiBDIHdlIHRhbGsgYWJvdXQgbm93Li4uDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0K

