Return-Path: <linux-kernel+bounces-205219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D6A8FF996
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6990B28316B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148D14006;
	Fri,  7 Jun 2024 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hf6T67po"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6012E5B;
	Fri,  7 Jun 2024 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717723965; cv=fail; b=XNMU9YE9QCw0OYsrh+wE+TCNrLFgZ7AV8nP1sV581F4FbdT3kEc8K84RgYt6+P5KlM9xYO8PZ5XBqSRHFHazIHsz2nymCBJEPLttNsTjOpKvxFuvmICiOFzPEAjzeK40MrGRlgF6PslyYbz0J14Dx03zxr8o+tWxVcEBHOrmSrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717723965; c=relaxed/simple;
	bh=E+yQ7MVe9nKOrkAgc8Br1lEsJ/M25oVSOQUd3BAff2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RryCxDAw52k2IbVv8oUHqsvSNGLMTJFNWDEbXhpaRzkPDDFXnrgzlDnw1c322cfpND6mqFsWhdsMyoPvlF5s6xwWstqC7x604iPlb8ip0KaIWFewrtp4yI2TflKto2sB8AP93CZTg4Wzi5WTA21uF+fe6xtZ/zKKSdOaKMvpp3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hf6T67po; arc=fail smtp.client-ip=40.107.15.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqa0vdJx8Y+fvrQZnrwJzcNDMM2gnQCUfnykD/xgDiruHhd+d4ylaSYlT7oQo/MJQlcFOqh3nqB4ISELLMf0MSDAkoBjOmsCPlg7oIRyNtfjuztfsAYvc7q8NpJN6alM0X32r0uY4l+uEVaBZtgFhQYtFyvr88c38FXUXfig39lsjV9hcK22dbKtxTnQTi79yzJ1WzPXpdI6lbvTpxBYdX5AylAlDiO79jSlTVcLWg322kl40ACSaTapVk8QG+JbyaPTzCU1l8aaqIlQ4h/z5zIaicfCM2GG7o3sohTqoD+gZNAlZF3OYTXPDPcNZnLzk+n99wiwEF+TWNVgiyzGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+yQ7MVe9nKOrkAgc8Br1lEsJ/M25oVSOQUd3BAff2s=;
 b=oGtxdClIB2AllJ4k4SzwaH4xGUgMOoA74T7MGRPBbC6ObRXg2KK2a5OPEm5EKIYimrewRGEggUSzaetS7qVAVYkJQUxuTtxyEbvHSuavTYRKOXFFuar1jl2f1drPI9bYq+WupSQ3+rIHS5uKCyr9mDtoc6MwGBNa+2/V0ZFaGdC4VPmgtrOP9XVIiie6N6TESPdUR5FUdgAW6xU1lEhEbXbH5iZkrCGyikDLMgCNgm69Ecc3rlXuqg1Jhh6A3i1Yjmtaosop77pwIkzrCCr4JC+Nrjkto1t4kGzE9EG7mJGJxMgmlVrneYkWEaQ0qQa8CvQRSdFF5L41A+Fgj2Gl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+yQ7MVe9nKOrkAgc8Br1lEsJ/M25oVSOQUd3BAff2s=;
 b=hf6T67pozU9aDowYzONUxApnd5+lsorDFcDJpas9TzTXmC1ltaKs/1I6GEH5i+C8kXaJ/Qqw5ZUYW4iGVRqzA9n6ilnDpmOY6oiBp8s/va4zjcmCFJWHpirfZM5O9xy+VSr0SSqjnhck0s4zXo7Rrc0mg9us7i1Tk8UfSgx9Ojo=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by GVXPR04MB10451.eurprd04.prod.outlook.com (2603:10a6:150:1ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 01:32:39 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 01:32:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 3/7] arm64: dts: imx8qm-mek: add cm4 remote-proc and
 related memory region
Thread-Topic: [PATCH 3/7] arm64: dts: imx8qm-mek: add cm4 remote-proc and
 related memory region
Thread-Index: AQHauEIRYji/itJrVEq1SGk8UC2EnLG7hHug
Date: Fri, 7 Jun 2024 01:32:38 +0000
Message-ID:
 <AM6PR04MB59414E4A20006F08758492F688FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-3-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-3-565721b64f25@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|GVXPR04MB10451:EE_
x-ms-office365-filtering-correlation-id: b0e9f13d-7724-4aa5-6272-08dc8691b7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UngwZDdqZUZMYXp3TzI2Uzh6cEY4Q2Vya2JqREx1NWoxMzhpM3JmYjR4Zlh1?=
 =?utf-8?B?cnlZaTZVUjZ5bnpqWUxpRVFDQjFnbE1nMWVnYk94R3loYTUzaERUMVFEbk93?=
 =?utf-8?B?SWxYeDBVUm9Nd0lmanFmNTVMVmhraFJ5U3dPVy8xR1ZHdENRTlFqaGJCNTFi?=
 =?utf-8?B?LytVTUJxZ1BnMjdXOFdhN0w4S2ptaEI5b1YvOVd1TVU2WHFVdHBxVGpWeExS?=
 =?utf-8?B?Zk9lUTgxcFRBNHhoa3ErSUJPWVBuQ1dMSjNrWEJmZDJ4SWJnZy8wOUc3M1g0?=
 =?utf-8?B?b1VobDFIbG04ZXZwUmVSVC9qN0lua0hta3docTR4SEpIK3hUdzcybHgvWDFp?=
 =?utf-8?B?bVdZaXc4dGx0WlFvOE5OMWJLRk9Ec0p3NWNEd3pJTUV4aTduZ1dQbWIrMHgw?=
 =?utf-8?B?Zzl1NktXOW5SeDZXRnhMNXlUbFlyWWZocWkyTFdqek5DYjQrdzg5d0kzSDFn?=
 =?utf-8?B?Sm1Ma3VNeHYwb1FnOGdvT1hJTGJWejJXQzgwZjlMWWFPUWFqOER1bU1YQ1VZ?=
 =?utf-8?B?ajJOTXBBRDVGdGhLVkh4b2FhbG5vZE8waXZsall0cDBEZVNCUGNOanVJN1JU?=
 =?utf-8?B?alhYOTFHWCtGZ1QycUhWcnBzbHBmdDZ2TnNTaVR4V1YwWnhpMjFnZDZuZm1y?=
 =?utf-8?B?QWxCTzlxK0R1VVozWXZrWXBHUXRmWnN2NU56eFVLN25NL24yd2NQSVJKUGhS?=
 =?utf-8?B?VmgyQjJtait6aThaMDd6eThwcjd5MUFUQmRlZ2E0Ri9FbDNRSHYrZURLMXl6?=
 =?utf-8?B?VldDaDJ5WVNuNlQ0L1pFaXlLU2hqYVh5VjhRWU9aTUQ1ZGVXUGczTmVybUFM?=
 =?utf-8?B?UENPWUlOVm1wZzJqQnVzY0t2dm9UOW5TVjJqeWhEWjBkUUhlMFBGRmRmNksy?=
 =?utf-8?B?VlZZK1NzRXRvRW93RWx2TnRHeFcwUTlrdFhwYndrb2NkbTRoZzBaajZxd29y?=
 =?utf-8?B?bDBsa3NXWEF3bnZLNG9TR3FzM3gyQW9WcERObjd4bE1DRHlQbmNMQWhJWVpI?=
 =?utf-8?B?Z0hZdnVlQi9RTmFXcXlGT2JvWlEyVlpkOStIanFBNGZ1TjJNa1R4b3ZqV1pk?=
 =?utf-8?B?Wkg1RWZGYWo0aHFySXFIOXlkNjZzS0FBUXRBemtCYVB5SWVKa1FlRmUvUHhL?=
 =?utf-8?B?YWc3WDRCMUo2RW1jYUZTSzZlcURVa0ROc0VwbVFDUytLNCsvaW4rdCtBRjY5?=
 =?utf-8?B?dmMwYXZjMFByNm9GMTA4YUtTVUR0M2Z5NU5DdFhvTmgxTEVHdHdXNHo0TDZG?=
 =?utf-8?B?V3czL1JML25QR3VuSUNRRjlSM01KYlZ3Q2dkY0xjZUo2Z0l0MHVrYnJCcWFh?=
 =?utf-8?B?c1JHcDFUcHlCOFdZZTUrRHFiSGhUcXJLZHptMk1EN0Y0RytTa0dESnRxKzVu?=
 =?utf-8?B?NlAyUnR5aXVvcVpsWEQzUWY2cWFTTU5pdDR6ODZIb0E5V2lydTFiS0pmMVlW?=
 =?utf-8?B?YU04RndTWkJ0ek5jRlJaNmh4YWNJL1JJNlJnNndiZllweDVVeTA2NXp3M0Y5?=
 =?utf-8?B?VzB6Q2lmWnUwcXRNaGRpbkxOeTlPOHRKZ29mazBlQ2g3OVdVNy9qQmZvT1lM?=
 =?utf-8?B?NVZOdHZuNTdBdVl6L3ZaODA5OXdyZGVBdkNoV1d3SFRoS0FUaHlqM05NckRN?=
 =?utf-8?B?NStXNWZkS1RVZm1zZjZZQmxJeldjMGlsODBzTGZsS2JMd1dFZHg1djB3UjV2?=
 =?utf-8?B?Y3NJM0ljTWdQNEp1OE00MjYvQTR2NkNhZHpQcE9rWWIyT3NmSTY1Z2MvNjhk?=
 =?utf-8?B?emhKYkZucmZRVUVjQ2RBeDFrWjB6WldqSjlYZ0JUcVQxUkppWjc4R3dzNjdK?=
 =?utf-8?Q?MEowUuAj83jGX4ROycZrJ3BB+6tlDkzX/Aks8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGQySTZYTTlLRXZRV3U4UEpCUlVtVDQ1alg0VWF2bkc0MmlBMEdKSTMvQnhJ?=
 =?utf-8?B?bGl2OUw5NTJsUVI4WURHTVpMMURrYmRWczhnb2EyME9HWHk0K3R5R0RwWXN5?=
 =?utf-8?B?SVZ3WXV6VHVZY1MzRGM0NVB0VUx4RUlEYllMUkZYY2xHTkg0akRMdVRnd0RU?=
 =?utf-8?B?RDN4ZDZJWTR3RVpicVZVNTVyQWczRmZYUWc5QXJiMnR2OXFCK3RseE5kbjVw?=
 =?utf-8?B?N1BHR1dwOFIyWml0SDNTVUQzNlFmcVFySlBSbXRLbEhqZHM1Zjd1Ums3Q09z?=
 =?utf-8?B?bWZGSXNIODdMa3BsZENUNmhNYVoxazdzRTYrREJEaE0wbkRCZHkwY2RXZFNR?=
 =?utf-8?B?RGdYTUkvbVp1RnJDUnM0Y04ydmg5UVZ2RE9BSEFHMTJoc3pmTWhtR09RL1JM?=
 =?utf-8?B?OFlMcitQZXpyN0dhWXovMTNXZTg0QTJRTDZMbzh0SEtPK0krZldLQ3czcUNZ?=
 =?utf-8?B?Y2s5aWp4aHI5TFRGbVR3NmxkNjNwWlhvUy9DOTBNd1VyMTFobU1sSi9rbFF2?=
 =?utf-8?B?RWszcEIzZXBQOVFSdU1NZEYxWlVSblZHODFXUjh5Q2pzbEJIcEdzTkhqY3k0?=
 =?utf-8?B?czRFdGVzTVBEZ2Z5d0J4R2VnM0NVYmhiYWNvQkhPV1l5RDNoc0VIemo1WjFM?=
 =?utf-8?B?aUIraVpObmxOOGl3MDhYRXRQSkZkc1hpZGpuRDY0OGZLSXBudUc2dDY2blV1?=
 =?utf-8?B?S0VtVUZwUTVjRnplVCthYkF1QWZ0SkVqZSswZk5aUHo5UGRzYkJJNzJLeEsr?=
 =?utf-8?B?LzNXR2tMZngxTDk5WDBCbHdZNVlISGZqKzllWjhwUmJIQUs3Q3RhMDVYdTFo?=
 =?utf-8?B?MTNZcTROSWZKTngycnJTZlR5d01rbmVnMjZtY2lpR1dVdlNlK2ZER0ZrbHAv?=
 =?utf-8?B?WjJxVDIwbWdUOGtVYUV1aXM4SlRYb1l2ODZsK3JjQ29MT0RySnlWY0QxamJn?=
 =?utf-8?B?OXVqSWQveWdzakFMbFlKYk15U3Njc2F2Ymt0V2duamJjaVpuZkQ4M0xrYmcw?=
 =?utf-8?B?OXpFQnN2TytKQm5mZ0xESE9OVHhZTFh6YzhrQzVFM3dCUkxqaTBTNllnZzhD?=
 =?utf-8?B?TmhxOWxBUitwSTJlSEFiMUJLeXplV25kWlh5Q05MbGkxWmlCVXBkeEtRNitJ?=
 =?utf-8?B?TEYyM3dIQk5Ec0k1QUlkKzBUYk5QMkRzU1o0c3J2VkFTU2UrZlZ3TVNRYjJv?=
 =?utf-8?B?Z3lUalNhMXUzWUZBbEdWY2pBSzl1SnlRSzcwTTM4YlV0ZjBzVFNQWkQrUDB3?=
 =?utf-8?B?cmdSek43NGNrSm92QWNsY2NOQklPK2pjM2FWUTZIM253aWxra1FpNmg1c3B3?=
 =?utf-8?B?QndoOFBGMXRKZXFkeFN2aHhydStuM1hVT3JqcjR3UVhpbW56YTNLaXFIRllD?=
 =?utf-8?B?WjlKOE5GNTVYMUVuVWR3bTdUUEZ5YUlCREJHR1g0bTFIVjB1Mlh6OXBrbnR5?=
 =?utf-8?B?MzJJVE9rbXg1RTdVRHNWdGdZMTZvQ3ZwOEpCNHFmcDZ1VHFkTzVVL24ycFRq?=
 =?utf-8?B?ZTVDUGtkOWRiV1FPRnVKNmZCRVR6elRrdExEM3ZVZVBuVmkrVU9UN3l1bjQ2?=
 =?utf-8?B?a3NGYnhQVUlzNmJGY3ZlQVFudlZleVh2Q3JrbzVQa1ovQjlZVEoxamJma21B?=
 =?utf-8?B?ckFlajMyamxNQjhPYWRrMlhMcWladWpadnExMzRQdVBSN3BQNTAzTWpNMUh4?=
 =?utf-8?B?OFJqQ1ZDeTB3VFpDNkVtVm5wWERFNVVXS2JrTlRqNmpNS0hvT2JnNCtUWFlB?=
 =?utf-8?B?ZDZFWlc2T1p6NFhtYW04dTlVZ0h5ZW11QjkwdktDOUx6ZFpKdXJWb1dyVmtK?=
 =?utf-8?B?Z1FZbmc4TkxocDFRcC9ucFpoSW1Ib0JnL0h3RmJGb2hUZHowdSs5aUNHNVFU?=
 =?utf-8?B?RDBGMGFDV3ZzMGxUc1lXdnF6b2RFbkVJVUt3V3ZRTFpyVmlqTW5tQ2d3RHhp?=
 =?utf-8?B?QUlHU1ozVU50dkROaDVBdDNKaEp4WlB4RmZpVW5WRUdxNXhoSWFCQ2xnR1BF?=
 =?utf-8?B?MGFFT3RhbUNtT2cwaVRiWnFhRGRIS0lzVUVybE1OaXZIN01McVRndHBDQXQw?=
 =?utf-8?B?b29sUUFiM21DenFtTnRwZVZuNkZORE9mZmFqYWpKaFdsdlo1UzE2MWErVVZq?=
 =?utf-8?Q?DzW0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e9f13d-7724-4aa5-6272-08dc8691b7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:32:38.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcrgNq/AiSC3D94aVRXZDBzBl0E6dBS7AjbJx52eG6g6WMjc2ttYv6xy8DaJt3OlbAJly3EEYHs2I6qPidPoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10451

PiBTdWJqZWN0OiBbUEFUQ0ggMy83XSBhcm02NDogZHRzOiBpbXg4cW0tbWVrOiBhZGQgY200IHJl
bW90ZS1wcm9jIGFuZA0KPiByZWxhdGVkIG1lbW9yeSByZWdpb24NCj4gDQo+IEFkZCB0d28gY200
IHJlbW90ZS1wcm9jIGFuZCByZWxhdGVkIG1lbW9yeSByZWdpb25zLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IC0tLQ0KUmV2aWV3ZWQtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K

