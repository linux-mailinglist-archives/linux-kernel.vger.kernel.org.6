Return-Path: <linux-kernel+bounces-354429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C84993D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D491C22B41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3411F37171;
	Tue,  8 Oct 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="DhciZLhm"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62B25779;
	Tue,  8 Oct 2024 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357092; cv=fail; b=raX0clSFiCADib4uG1gtpcX5sevCaukg0Yvag8p8fugmGY2ckVuD4aLi/rrI1uKNFRM4UbI3iCyV/gN9HoGYuWQNilFyJfMTq22/eARCMkIC4i4EG8DFC3jbxX6DL5X8XC/axxOQdJeYSZJ0/QC7vhYLXyedYw/F+noKE77gRLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357092; c=relaxed/simple;
	bh=yVni1puQl8VdwK/D9YWJVtSowY6NvIS1Ilr18wqG7rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rS0EDT+MPuNFGSwEAchz7NcpefsiNYDM11SoPiOMsB00BDEuwnbrooy5Z6lOpdaJvymwXVmTCiZbzOAuHAI+iHSTO0N8L6s7/Xp8kxu0S0gRtmqWC3wiG2SmhjMmOZ3yR4FaYZsZ974AjFe2WBLdKHzsCvQr8YycT1Tuc1/A7LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=DhciZLhm; arc=fail smtp.client-ip=40.107.255.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF9j93jFX6Vh0pZ6tMB2RLCYJHo09sadfyufqDfEvIfWpFYTfvbDDcrUUyo+mxKRWV3mjGUqQo6O6rcdbXA0SCdb25UI438ImsmfWzJBIrjfUcuGAzvxQFJpRaxYgmahzQZ3mMQVjazSU57a7aakPScm6TvsKZVPQYueLVz67ZZV5dMvDzOM9QAnU7+XIk/HOI6lyqQk3ZsMNHoCWci6aagM/lOrr394HA76Kvaf+t04v10tsEH8KXz/0iTfMOCmVwAEeua6NFOFeEtzkTHhzcdvb13Rka0dn9h/dS8aWL72FOAZxdtG2qVcvY0rHUy7KNpaxwp5I63BYhNMIS9q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVni1puQl8VdwK/D9YWJVtSowY6NvIS1Ilr18wqG7rE=;
 b=IdkRV9UEIQe7b2MkvQbFpbVzHpGhGpV2WwPoP+Nf9cH7odhO4woYyK2n39KmCkGIhS0BBnEbWrhHh2tZT1prWPjgC03psdkmEVXK5rK1vYYZ0XHcWhoWXyYqUFY39ih/Sbj61cu0x5Dq/XrZb9XHByJBG08QSg7lMFE8zsZ5aOfc4XbBJDRQlWjWDv4m4SstSnWBxVpQSAuHWqXyzvJD3ssizF8fTfw7359oATvjTGhE9Hr2/HF95F6TpxP+fZ193YRrIbl0SDd8pzbkFyPIFUsWlF6+fYuzfxSF7gwE2Gm2Z10sNxfUCwAfyHDIWcPzbb8SeEUqaSD1TKsag7giBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVni1puQl8VdwK/D9YWJVtSowY6NvIS1Ilr18wqG7rE=;
 b=DhciZLhmWVhEv7fDuKyBRhWVw1yocTrm+HjLPGQnNeU/l9ZqFH+ct1bdiBgVAgVqFelnZtXka9zMqyqUXugo/h5kZkpbGvmxizoL2T+N7kdzhK/ujSIGsWX3esO815DM5VVd2YxXYiIV9koPh8e2qRAXoODAQ0G/mmZDUjSp67SiDmqx5EYCMpEtr+yG2py8NtCMnO9uIfhToUpUNH+v4q2mj2cEP+EHIvKvPZ9nT0n8QoQDaC9VaIpyFgCEfxvmv7qNjek4Fy98IzcL+LgZpsJB+9PmvH12J6nWL/mxomlQUO6DqLLjkUtstOyMM+ZkWp+dDdpxWJqQ+ZdvsymImg==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SG2PR06MB4987.apcprd06.prod.outlook.com (2603:1096:4:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 03:11:13 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 03:11:13 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "lee@kernel.org" <lee@kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net"
	<olof@lixom.net>, "soc@kernel.org" <soc@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 7/9] arm64: defconfig: Add ASPEED AST2700 family
 support
Thread-Topic: [PATCH v2 7/9] arm64: defconfig: Add ASPEED AST2700 family
 support
Thread-Index: AQHa5Ls5nDTJDluzbU+9LAh6c6NjRLIUWKYAgGg9MvA=
Date: Tue, 8 Oct 2024 03:11:13 +0000
Message-ID:
 <PSAPR06MB494975CE8DBFE3CC06BBAAD9897E2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240802090544.2741206-1-kevin_chen@aspeedtech.com>
 <20240802090544.2741206-9-kevin_chen@aspeedtech.com>
 <CAA8EJprcmQvE3PjySxBKq7Qv3JHJHhic2aQ5MDnwZaf-D=K2Rw@mail.gmail.com>
In-Reply-To:
 <CAA8EJprcmQvE3PjySxBKq7Qv3JHJHhic2aQ5MDnwZaf-D=K2Rw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SG2PR06MB4987:EE_
x-ms-office365-filtering-correlation-id: 7574bf4b-7dfa-4e95-df72-08dce746dda0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2xIRWQxUW1KOXB5ZjI2Yno0UDdUTGFFdEF5S0ZISThWcnJyVy9QZ2FmWlcy?=
 =?utf-8?B?NG9DVTBaWWJhWTVhZTh6cTJUc1ZUNHZ6dmcyY1V6MGdxelY1S29vZkxSbTZE?=
 =?utf-8?B?bFR2UlpITWJWOFE5QzhsenBNcmg1TFRUbWlsRmQ5RW9ra3R3Vy9iTm15aW42?=
 =?utf-8?B?ZC9zbEZwSHl2Mm9BQ3lPQXFqdk10WmFhdU52RWdJUTJ4UVQ2OW4yeVpVak1B?=
 =?utf-8?B?eUtUZ2RWWjlWQlQ5QmZFelJwVmpMZjFKdjgrTm1ubWdlNWQ5Mzd2ZC84dXdN?=
 =?utf-8?B?WE81MVJ0QUFnRG1SRVpRcDBxa0hkSXRrQnZHNC8wWVczWFJZN3dlbkR6Tk9M?=
 =?utf-8?B?SXBjYlJMOUJtVGpKSGVaZnRFNGgzTHR4SGtPMWZLU3RrVGpSRVV4bGhpY2E2?=
 =?utf-8?B?VVcxYUtLTklqbG9LNkxKNTdwZkZ1bzAvTFJWWUdvUDJsamFxbXpPbVU4VXdw?=
 =?utf-8?B?YklrMDFKZERVQzFKSzlzU0MwSXY3WXNpMVBqL2xUa0hLZUMwNWRwQ1I0SjZ2?=
 =?utf-8?B?Sk1tTFpmbmdVeVd5K3BPSmZNRmhrZ0xwWWoyZTA4OUI0cjJObFBuNjNxV2sw?=
 =?utf-8?B?ZTIzUFpMU3Y5SjAxMFVoL1Q2dDF2andVWHdvMnB3N2V3a1NUUm0zVFZJZC93?=
 =?utf-8?B?NitWeVNhWDZzRUtldUhvQnhibVBnRG9SdXNvYS9PVngyTk9LV1g2VU1uNlVP?=
 =?utf-8?B?QmtGMDdRYWwrVk1UZGhlWEZLSlNHTXdXSDhPNk14d2d1bXBKVStYZnpxWHFG?=
 =?utf-8?B?QWZSaSs0bzk3aVE5MHZxdWxWYU9SRnphQXdwdHB5S0E1SjV1aFBCeGVjeEh5?=
 =?utf-8?B?UnF6anpaeWRrZUNZUkhxZnFDbUxHbklsRk1DWFRad1ozb0xjZE4vU3hOdmg4?=
 =?utf-8?B?clRRb1ZZRlFTMStFRlJDS0VBV1BMeVVKR2NYRUFmNmZCeWlheWIyYUdqaS9j?=
 =?utf-8?B?bktHT1RHUzYyZk5zdUVJVGJXUzV1SjR4V1MvakNjdHRJNUdJejlRWE5UcXFJ?=
 =?utf-8?B?YmF6TEN0RmJDUS81eEpxUVNYT3lCcU1CUnVyMmdjbW9aSWZOWFlhcDNVTlhl?=
 =?utf-8?B?L1BZa1ZHazFnNCtqby9aM1B0NnpsNGQ0UHhBVVQrTnRYMWlwMGtmK1V3Sjht?=
 =?utf-8?B?eUEzT2tUTllNSEJmRUhqZE9NYnlzOGZXWWRJT05oTk50QnNWbE5LRksxODVN?=
 =?utf-8?B?bytIV014U0wwbWdnckJTZGtQRkZPSmpyK2dhN04vN05yNlVQY0xtL2xkQlZE?=
 =?utf-8?B?V0VXSEtqZGUvMFl5Wm5BY1RSbWpJM0Q1TmM4bys0WklXc0R1alo2MVBBdU1R?=
 =?utf-8?B?M2k0cjBland5ZjY1N0tyLzVhemVkbXM3V1B5bGRJMlFBQXkyVXhSc3lsdXlh?=
 =?utf-8?B?N1p4VFpHNDBGT1dFVUJYeTFzdVIxOXF2emg2SDV0R3JzYS9ocGxPd281dEdR?=
 =?utf-8?B?YjF0VUx2NEdjcG9INUpxU1kwUnlEOVg2MWF1elJ1MFh3eXg4LzNuazFYbldQ?=
 =?utf-8?B?UW9URCtvQ3pGYmpyMis3U1huS2QxMVpTaDdlS2tjdk00NzdLeTBqQ1hTSDh3?=
 =?utf-8?B?cForbGw5WFRKYWRoTHhoRWVmMFhvV2hKOG9QbVdTcXB6VEhwb2txc0didVRz?=
 =?utf-8?B?dkNwZWxGdDRoRFNFWlYyRWd1T2F4d1BYYnNWdmxEK0U5U0tCSEFUZEdhV2w2?=
 =?utf-8?B?WGM5U3J5TWdyWkxFN3lsdWtFZjNlcVFkeFIwUG80Nkd4M1RSSWtNSHpkMi9u?=
 =?utf-8?B?ZXlGb1VKb2kxb25CajhuaGQvL1doL0NxMGEveFR6RHNDd2huTTZCZk9GUDlr?=
 =?utf-8?B?alVncHlQN21IRTV3aEQ4Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MW1CT3laYjFsWjh5VGpackVSWWg2dkNzUS82Yjd1RkdtSUJCUFVEbWRPM0FM?=
 =?utf-8?B?Y09hZnpXWHhOdW1NQW1haVFiZmJIWmZ2RjFmdkhWUzBhcGZsQ3BVck5wQnR6?=
 =?utf-8?B?MWRiS1ZYRkJzMjBmcmE3RWhGV1hmbkQxSjFUM1JWcFl2Ykk1OWlLYVlkZ3FQ?=
 =?utf-8?B?dFJKaFd1eldjeFlrUS85KzR6WDkzWmt4Zm5ud1ZKNWFPa2FsNDA3VnZzaGdJ?=
 =?utf-8?B?RTVjVWVycWRBNUJmUlhWQS9zVE9XZVpOSUZjVit4dDdIRDJvdGNjeERBTDkv?=
 =?utf-8?B?RnNkSGxhOGppQmsvbmVFeVZvR3VhSDBMVVRncjU2YnN1dnliNGlYTG5WZHNs?=
 =?utf-8?B?cFRDeERGZmJiZngzZ1h1UUQ2Q3drT2M3bUMrNnZOVzFMVzh6R1loendMOXJh?=
 =?utf-8?B?MElzS3VSVStQelB0eEFSZ1NHWHczWk5qS2QyZzEzMGdwNWkreTltRktwK3dR?=
 =?utf-8?B?TVplcmwxdjRxcTlkMmx0YXhKWmEySHE0K2ZLa1E3aXpFYkJ1SE40VGdaWDRS?=
 =?utf-8?B?dEhVbDlqSXlXSzNNS2dNMWV4eVNxcDBzMkppdHllYWZyNmkzWk9NQmxlTGRJ?=
 =?utf-8?B?Z3ZrRjAzbGJWTHVhc1lqTEluNmVPMmhOTEhBSHlveHZOYVlHZjVSb2tUZjRq?=
 =?utf-8?B?c3lNSWUvSy93YWJ0bjdUQUo5TUlTNXRma2VmY0Frcmd2bStrUis1RGtpNnRP?=
 =?utf-8?B?S3llUXpMd0dMSlJJdGFGczY1WndQbkRmZzRnNDI3eStFK05WZXBZVzJFNFZC?=
 =?utf-8?B?NDBublRZd0hGQ05Wak9RaytqbjBVZDRZaHhkZG1jZE5Nb2NjZGRwT1dYWk1q?=
 =?utf-8?B?YkdVa0lJZWlIYUFFMVNIc1hBbnc5YzZUTkF6bFRkdWZiTmNPTmxyWGxCWDUw?=
 =?utf-8?B?SW5uU2NsOC9kendCSlMwcE41VFE3ZWdueERrS21UZ2hGYnpCUzJ2elc5YWJC?=
 =?utf-8?B?M2dRRndhT2ZWTFFyS0JYb0N2L0E0SkxyOFNYSHoyWW5rc2l6VEJ2K2JieHJV?=
 =?utf-8?B?NGtZejk0eWV4c1R0bWFPLzVDNzErT1ZyUEhxR1VQM3Q1RE5USVVGTlRZUC9I?=
 =?utf-8?B?UklxSlRkQkFUdG85QzJ1TUxVVzd2L2VXeURGUGVRWGJXSzltOUxNbHlFcHpp?=
 =?utf-8?B?NUZ0aWl3OTUybHBnQmx0ZGcvOW5ZTDkvbHd1dHM3eWxRU1FZbkIxV0UrQjBm?=
 =?utf-8?B?RUxxeDFQcCt1SEVWT1d4ajRxMEtLRWxBZ0tmOXk5UWhZY0llcjE3ZlY1TmJ1?=
 =?utf-8?B?VDQrY01WY3h4Z1VWUTFUTG54RjJDdy9Zb0wyWHkwRWlVUGdhZTNpRTl4Z2NH?=
 =?utf-8?B?TEpvMXBlRU9mYU8xY2VaTGRueFBMdkhRd1ErYU9DK1NGZDJib2FRdnhNeWVF?=
 =?utf-8?B?NWRrd0hDKzE5bkRGWUN2dm9ZQ2M2Z0o4Q1FnM3MzQ0hpMHNCZ3dTaW8wTXhx?=
 =?utf-8?B?NnAwb1M4emxraHJFbDY2VUZJTW4vVFB1OGJKUVFoMkV4NDFuTXdqVWJtU0xC?=
 =?utf-8?B?N0ErcG8vNFArRFpwTUZTMGFNWW5mYy9vYVVNaWEyWVdIcUFybjFLN0xTZmJS?=
 =?utf-8?B?Wis2cmF0aURvNFJKMlEwVXRzRzhrVnMrTzVIcE96QjlTU1dzNTI4SEwwRVFV?=
 =?utf-8?B?NGJzQWNyQ3h2dDdmbmFOOEd3UlNkVVBQaXA4UFgxcVFPbVJHT1BWUS9uR1Va?=
 =?utf-8?B?SjlwQUZ0QU5UN2U0QklTTEMrRU9yaWVCNXpTVzl1VmkvelYxWVhPbkN1Q29n?=
 =?utf-8?B?UDVyb1VCV1Z0dGhpekVDMS9kZE1pc1hCLy8wMGJTY2R3TzJYbEJKVE9aMGVq?=
 =?utf-8?B?Sm1iLzZHU081SllnQVltd09sUGFOSWtOOWRpMTBaak1RRGFZOE9vMTR4UWM3?=
 =?utf-8?B?K3FkdGRBTmFlK1BhcWNZbDgrRzBvRFRNRlhEWUZGd1hOd2I5bTg1RERXRXJL?=
 =?utf-8?B?bmJadUk0K00rSmYzbFdPTk1CVmNIUXNEUlVDNjhQVWM1TlRraG1WY0Z2Q3RH?=
 =?utf-8?B?VitTdzV0ZkZMSGxCaUUvUGtmUUEvVmJoQVRiUHlvbmxEUzFBVlVOd1VlcjJk?=
 =?utf-8?B?RVFyYjRIdFJoWTZNMnFjcHN0dllRaW9BOWs5SzZRR1ZMeXRyU2pWcms3a2hJ?=
 =?utf-8?Q?MnWKyN2eD+jnD2UC2Zas6CyKf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7574bf4b-7dfa-4e95-df72-08dce746dda0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 03:11:13.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0nRSJqTkVUpNC85TNiOCctdfFEPQ7LgB3KmdXxjqgtG3IJxYkt6FIsl5sYvXIyS3V1BZwQ7VtetjMg299GL05/BrJfvxgCdWhgffklRFx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4987

PiA+DQo+ID4gRW5hYmxlIENPTkZJR19BUkNIX0FTUEVFRCBpbiBhcm02NCBkZWZjb25maWcuDQo+
IA0KPiBXaHk/IFVzdWFsbHkgdGhlIGRlZmNvbmZpZyBjaGFuZ2VzIGhhdmUgIkVuYWJsZSBDT05G
SUdfRk9PIGFzIGl0IGlzIHVzZWQgb24NCj4gdGhlIEJhciBCYXogcGxhdGZvcm0iIGNvbW1pdCBt
ZXNzYWdlLg0KQWdyZWUuIEkgd2lsbCBmaXggaXQgaW4gbmV4dCBwYXRjaC4NCj4gDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBDaGVuIDxrZXZpbl9jaGVuQGFzcGVlZHRlY2guY29tPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMSArDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvY29uZmlncy9kZWZjb25maWcNCj4gPiBiL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25m
aWcgaW5kZXggN2QzMmZjYTY0OTk2Li5iMzkzNzM1YTY5NWYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvY29uZmlncy9k
ZWZjb25maWcNCj4gPiBAQCAtMzgsNiArMzgsNyBAQCBDT05GSUdfQVJDSF9BSVJPSEE9eSAgQ09O
RklHX0FSQ0hfU1VOWEk9eQ0KPiA+IENPTkZJR19BUkNIX0FMUElORT15ICBDT05GSUdfQVJDSF9B
UFBMRT15DQo+ID4gK0NPTkZJR19BUkNIX0FTUEVFRD15DQo+ID4gIENPTkZJR19BUkNIX0JDTT15
DQo+ID4gIENPTkZJR19BUkNIX0JDTTI4MzU9eQ0KPiA+ICBDT05GSUdfQVJDSF9CQ01fSVBST0M9
eQ0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBXaXRoIGJlc3Qgd2lz
aGVzDQo+IERtaXRyeQ0K

