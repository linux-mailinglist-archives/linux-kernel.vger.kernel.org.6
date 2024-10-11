Return-Path: <linux-kernel+bounces-360870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614D99A0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55132852CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F9E210C01;
	Fri, 11 Oct 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="QHD6sfqm"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020136.outbound.protection.outlook.com [52.101.128.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45642210182;
	Fri, 11 Oct 2024 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641224; cv=fail; b=tSMhzTsWLcT5daqgsHbAsF+CM4bcbAALGEAn8YMyWJARNvOlqXPF8EwqHHSrGItk3LyD+K+O7QdJsqUlne+8yGVxgeXz/nbAplA10cE0kMnwmGCPa8y9jGo4LAyXsMiPRy9h1RzNmGcB1QEKCt+vip1kOQaYIV5W0ToV8yA9QPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641224; c=relaxed/simple;
	bh=AFYoCxXECWiMAoBIUaePJnF3r+SI2MkFZWfQGsebhtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlrvDJuU4m55uyZddO4E3kY0zwnGDxop/dqgr+UdrU00TjUPkXLrfdAUwvdjkrhEVVppJ+fizPJLlVA+qFrBJhBJEkKek91qZrVAWV6WQDDPy0J1G3IjCPmlJhUTSpItBiIPwWxfki/dwG4GCghHN1vkLvQLIp7KT4b7D8T8xDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=QHD6sfqm; arc=fail smtp.client-ip=52.101.128.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biRFVoo1ilQe3SS7a5RMzQngI6Kjp5Xk6OiVyQWOTf5JeFzp9Z0q0XYOcZ6eS03fGPK611ZckCYdRzFxa31EQQBLU5VFaW9LZIBLFWmSR192/VG78G49AYu2xIqgRHKLP2lpuYsiHw+eCm+/Y8i6bcIxg1vGILfKl8SO+67hxkLBl7kUTt7w9dW3HOVceCwQbY4Fw2W7YQ+Mh2DQEpPIRugr4C800D6dlgeVRFf3+fw8bbXnqHdlgi7GWOnsQhLTWLymO3w2Dha7lOhpqEmwSSV3EiFULdDKd9LJSl/LX5bNjX+zed7RR7Kbf7o/No0kyFqw4sESIy0WF8myIKvDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFYoCxXECWiMAoBIUaePJnF3r+SI2MkFZWfQGsebhtg=;
 b=yEcOgr3Ga5ZXV06MTgIYiu4bO0nKX1Yj4pInfRs69h5CuKiAk+dqXxSEBFAd02Ax01+leoxAjvGp1//D5B/gtZqKJPj8s+2+jyDv4C3GZVfLpSLXkZw0UHyIIi3gi4c+f7DVViVELcKpVjdraCXcc2RVQtw9AALS9uWSZQr4mVdXmK75ivYHJ2npFrPOEm8yo2LItMAcZyKOo5M8xpJG5/mezXe9eqIiFgGYA21TNmwYBSf/TcY9TSXpXT70vzsrVrN6yssjE/yxc5//VURGTkYdv1R/2g3YfMhVLR7Ui7dwI7NRYKh4jab+B9K8JpHCbrdh9+Kx3X4u10G6YpPdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFYoCxXECWiMAoBIUaePJnF3r+SI2MkFZWfQGsebhtg=;
 b=QHD6sfqmOUFqFiyHqIeFcrTHAi500WE3kiRXSf4b213N9hhpHyj3Eyq1hWIhlw8gK7zH2HywAoCRFDt5naZ9n0mNiyKUhV916RZtOBWrhiRRy3hxmgtI20dlF1JJ759KHi//n1xsA9NMhG/NG592AsUrdT+ZHcwoEt+HG4y8PnTAFsdTEkikKAdrO8NhupVQsYjgVLof7rTM9imSEUS6NCXxgGKIynXDkF1xvyVuTloMswsrXNj8kRH2nVk5o6TTUuX5syUQ2f+UyFxOj+WmOBGvu6GV2avTMrQC5B4WkBCxQm/OhZeuDgIHIyg2uFKKuXn1RO9FesjwXIS080vUzg==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SI6PR06MB7102.apcprd06.prod.outlook.com (2603:1096:4:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17; Fri, 11 Oct
 2024 10:06:57 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 10:06:57 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, BMC-SW <BMC-SW@aspeedtech.com>
CC: LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Topic: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Index: AQHbGkKMCnGgBPvFn0OoVljQ1X0eJrJ+WgAAgAL6RdA=
Date: Fri, 11 Oct 2024 10:06:57 +0000
Message-ID:
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
In-Reply-To: <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SI6PR06MB7102:EE_
x-ms-office365-filtering-correlation-id: ff1f9994-5a70-42f2-2ddc-08dce9dc70e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDY5MnV6clhSVDJjZXZGZ1hmTWs2YkFmSWhaY0dKMURSSWRuUjhOUHRCeTJL?=
 =?utf-8?B?TFFiVTA4WHdqOG0zY0dmTmZIdXdMTDdLWG9HbUFyTzl4Z1hicFptdklKSC9K?=
 =?utf-8?B?OW0xSFc0Sm01M0xqeENYQ2gvWTdEelRnckxHVGxEVlhGQnpzUXVIVWRmWktL?=
 =?utf-8?B?VVZJWEc0WFdWNFBlNytNYWhiZFFETmRUd1AvSG5mMUUvaWFocU52cDd2VFJh?=
 =?utf-8?B?eU96ME5ZM3g3N3FBQVNMdHZyVGRwMjR6RzlQTGdrTTRJbU5mb3hjM3hzT0lS?=
 =?utf-8?B?emVDSFZiZTRRY2JPTEhPWHhNT0hSa1JFdzdOcDBUYmhmOVpKc2l4Mis4emVx?=
 =?utf-8?B?a0k4SnFFWjg2TXJVVkM4Uis3SEJ0elQ4TWpYQkova3hWMEVTUytST21vRUsz?=
 =?utf-8?B?UkpIU3p4cHZvM3JmWEpKZ3hFV3lGSXpLNHpqeFppVldyZXg4MnIycWRSS3Ju?=
 =?utf-8?B?R3NpU3ZPbnVFZUlyS1pvcWR6V3BsUHYzZ3p3QXFEclB6anZUd1BSU05CZGJZ?=
 =?utf-8?B?Zjl0NWJZdzRINUcyaVZaSmZ6YWloUzJPeG9oTkFyMFE1SnRsSThqclkvc0wv?=
 =?utf-8?B?KzZ1UTVNSHlZdFNlbHhvYnkvSmJmV2JPc0VYVllZdE13b045T2lQZ3VWWktC?=
 =?utf-8?B?TzFncUpCeXZSZ1NzeVZ5NzdzeGpDR3EvL2o3TTE1ZitPQW1yNXhVZWM3VFQ3?=
 =?utf-8?B?UnVGZ3lxZWFsODFrLzFoR1VlRmIrVHdlckpDaHlIeWpKeXFTd1QvTmNoU2lo?=
 =?utf-8?B?MEpROGJlSk5qMzBNZUlSSVU1ZVB4b1RYM1ljMDNSZm43M1laVjd0TitGYWVl?=
 =?utf-8?B?YXB0c3VKZU83VDVwemFwaG5qTHBReDR3QWZ2MGFXTC9EQzlteitLK2FiYjVB?=
 =?utf-8?B?d1JjLzJkaU9ONUlXNFRuTTcrVUVpM2YxOEhMRWJZcmJLWU1ySHdta3h4K1J3?=
 =?utf-8?B?RFZ4c255Sk96MllPUXVRWFVlQmg0SWhGeGowaEN6K1Y1cEN0SFZVMEZtRTZh?=
 =?utf-8?B?VkU4U2dGaGIyc2o2d0hYNzFlZ1FYMEVEOXNEc0s0bW1DVWwzLzhPbGNsVTh3?=
 =?utf-8?B?TVRDQUptZEZ3dGQrOHU0Y3JsNGpGbTlaQmdGWHRFOFFQQWd3YXFMNWR2UFl3?=
 =?utf-8?B?WHRQNjB6WGxic09pMTFiVEJHbHVIcS85cEswaldtREovM3lqNXZ5RWcxeUpw?=
 =?utf-8?B?MU5FRnBCcE83N0hoVWx5VXR1KzA5RDdZVjFENEtWSjdCdXBleEU3VG9uS1ZP?=
 =?utf-8?B?RThQZ2hKSlVFRE1DdlI2SGlvc3VVdDBGa1hnQm14ZUpxVkhTQUQrZHRtMGxS?=
 =?utf-8?B?SkwzKzA4c045czBPbkVsejV1STRTZGc1aTRjUkg4R0kvUHdzc2RFZTVtaXJq?=
 =?utf-8?B?N0hyQzFOZWJqcGVYcWhEWG0ybGRPeHpzcjRmWEJUbzh2dVVxT0hVaVhnZkNr?=
 =?utf-8?B?UTk0YXBPMFg0L0daeVBYa0tYeDRwcTJqMlRiaHJ5VW1rOTNqY1ZZMmtJeFVr?=
 =?utf-8?B?OWZWZEowall0NmNTWXVJQXdodUZ0T3ZySUExRExId1pnMGF4NUJEN3UvWHpG?=
 =?utf-8?B?Qm84SXB4L21iQkpSdndRcTFyT2F1L0RIcjI0UEpuR1VhdVZucEQzbndwLy95?=
 =?utf-8?B?alRXVXNaTTFVLzJ5ZGNLZlN2Y3JSL0pxRDM4QlczaE9nUW9CZ1ZndTdlQnRP?=
 =?utf-8?B?WHlwNG5YTEYxMzJWZ3hDWGh0L1NtcEJxRlMzb3BwOEI5N3FjZStzckg2bC9m?=
 =?utf-8?Q?7x0aYZ7p0SgAT7YG6Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzRmT2orQ2x4Z2pCL1RFQWRKTHdRQUd2RFB2OWI5SG5LM1NaNy8rcHQ2L2ND?=
 =?utf-8?B?QlVCRUczSUx6UkZhQmoydVJ6YTZDRU12RkVvZWRwb2FiZzJJRTRFWU9jSkdT?=
 =?utf-8?B?b1YzTGppQUgraFFwaENscFc2b3d1OWo2RUNRcHJhMDRwNU5pUlpIcnNseXVC?=
 =?utf-8?B?bDdraEZKeVh5R2xXRk1TK1JSZWFDNEU0RUpYZlBOTHQvWExLU3VjODEyWEhj?=
 =?utf-8?B?SHNGQnFTK3FmcGkwSk9RRndkM1dNQ1ZpWHp4c0ErbFY3OTVJMkNCS2RpMWsr?=
 =?utf-8?B?RW5xVFRpTFduOXhpaUE0dk0yUUpmaWFRNTU0amdGWk1RVXk5VmF2bUkyQjBm?=
 =?utf-8?B?azFwZE0wVHNKaEtVbHRJNVp5Uk04bWFaQ1lNV3pYZnQ3OXlzdHp3d0NTZ1BR?=
 =?utf-8?B?QWNHdXFnbkFOdUR0SnlzVVg3aXNVVlhsNUF1UVFUY0VRZ1NQOFhlZTBxNjNU?=
 =?utf-8?B?WkpDUnphTVlLdGp5S0lKU0VtQ1N5eFYvT1RDcitvYktsTjhUZTdSQ21udG1x?=
 =?utf-8?B?cHBPWEhYdUVrVXg3UWZ0WS92aHRhOTJwS3JxdUp1ZmpkT0JHaXVQODZRQzVt?=
 =?utf-8?B?akdKbE9BekVzV0JMbVVmSjNqbjQ0ZGlUU0NFS3hPR1pNbDVtb1oxbTczeXZG?=
 =?utf-8?B?STcwV2R4MkZkUDJCWFN5QnlGbGxQdU1KTnh0UUg4QXRDU2ZyeDZrc3lPM242?=
 =?utf-8?B?Y29IQ0lyZzhRS2lRNDlwVENnVFlkRlpFOFVlZjAwOE5sLy9zY2c4VnFHaTNZ?=
 =?utf-8?B?QTJZRU1iemFjSXQ2amJVNHZMMjZ5Y1BUZVdHYTJ1SExEOHJER2VwZFhBT1VT?=
 =?utf-8?B?K0hjN3hMcXVUOU51UnNJZCt0dnJ0RjR5ZVZMOVovRDJSRWUxenlFVHJ3em9O?=
 =?utf-8?B?M3lyUnpDbmxDMUQvdHFWYnZodDBmM3VvWFl0NlBBUE5DdDNJSlIzY3F2cHA3?=
 =?utf-8?B?NHVsWDZPNU0zSmJIanVFNCtYYk5DeU9ESUlqUlNJbDF0ZDZoUXhlSkd6TGhT?=
 =?utf-8?B?cnI1Qkh6c1FVaUVQaGFUaVJ6dkNxbTllQkVRcUo5eUJ5RkpzSHZFNys0eEVi?=
 =?utf-8?B?UUE0R0YxSUlHUWZaQ1VHUFF2alE0RGtUdzAvUmhGcHJKbklnNzhSU3FGT2hP?=
 =?utf-8?B?TDVMSGZxT3I4VUYzSFRod2lsd3hjYWU1VW5Zdk5rSE9zWjZqN1pGbDJkMWFG?=
 =?utf-8?B?bS9TOFN5czhuYlFFTElHOURnS2d6U3QzdXVVRm50Y2owUHJJbHJGOHY2UFAy?=
 =?utf-8?B?dmFDb21oQ2Fsc3J1T3JtYnRselkvUENCNEw5VjRLL0NRc2RZMWdCSEw1Q2tr?=
 =?utf-8?B?Yk9qdTJ2djNrUmdSL2ZyNW1FTVNpbllVcU1PbTUyT0NXVWVhUk5DWmNDa0Fr?=
 =?utf-8?B?eGFKcmFWVitJT2RXZ01ZVVlENytTVDErK2dwMjlTbGN2UTBXV08wR05Wbm0v?=
 =?utf-8?B?bnBMcGpXSnc1bUZUNWVaSTU2M2F4WEpySmlxNlNBMzdoRitmblFudTNBbktE?=
 =?utf-8?B?dkZqcVdESEdqZ3h5RlNsWHVvcXl2SnJNUE5QcXAvV04wQVN4VmliSWNPSmNO?=
 =?utf-8?B?ZUpsOUZ3Nk5iZjhDdFFFYnpNK1FXeHZkRGd2UzFyY2hldElkUzB4eUt1RTZW?=
 =?utf-8?B?UTBzekVYc2cyVVRhT0JyV0k2elhVZ3VyS3Q4R01qUkw1SFEvWUhQUEhNd0x0?=
 =?utf-8?B?bU1ZQXFpUnlMN0JGT3B4bHJINW5qejh1bTRvZk1zUStqTHp6aU8waEd5OVV3?=
 =?utf-8?B?bS9LYkM1YVRIb3EyMlRDL05EeVdHNW1PbDFzOHprajZMMm1hTkJaaG0xWUJI?=
 =?utf-8?B?Z1FzR2pBcUJ6OGpDREJraURZbTVNQmF6eGFmWjBWOUpqV0lJT1lJR0U2L0du?=
 =?utf-8?B?V1o2ckdSQ0tlNXZMY04zNFJ0L2JCVjZwUzl3WFN3aVJBam1BWG5BNFkwcVF3?=
 =?utf-8?B?R053Sm8vdFFEV3MrQzVuM2lJLzQ3SzcwcC9iR1BNc2E2TCtNODF4aVNDbit2?=
 =?utf-8?B?MUU4ZjhVcVMyR29TelI5RmZ2OHNZN2tnMHdLcjJYcXNWaXA1LzhpUmhxaXA0?=
 =?utf-8?B?RmhtZHVyQ0htM1pRTkxEcG1MeHNDZWxFMUppVXlVZE1EV3gvU1BzY2JlQnh3?=
 =?utf-8?Q?1R7aqk5NW8NbSnVfMpJXQnegP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1f9994-5a70-42f2-2ddc-08dce9dc70e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 10:06:57.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TELtAiRFeQq+VqwmhEgBErZPYsJlccqw3yw8CnFLr/2WMxH5HSVKiQaApBKE/ANINb80b6RW/f2TpbfY25gRkBjtGeUAU8Qh/XxdPYi2nZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7102

SGkgTWFya3VzLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3LiBDb3VsZCB5b3UgY2hlY2sg
dGhlIG1lc3NhZ2UgYmVsb3cuIFRoYW5rcyBhIGxvdC4NCg0KPiANCj4g4oCmDQo+ID4gVG8gc3Vw
cG9ydCBBU1BFRUQgaW50ZXJydXB0IGNvbnRyb2xsZXIoSU5UQykgbWFwcyB0aGUgaW50ZXJuYWwN
Cj4gPiBpbnRlcnJ1cHQgc291cmNlcyBvZiB0aGUgQVNUMjdYWCBkZXZpY2UgdG8gYW4gcGFyZW50
IGludGVycnVwdCBjb250cm9sbGVyLg0KPiA+IC0tLQ0KPiANCj4gKiBJIG1pc3MgeW91ciB0YWcg
4oCcU2lnbmVkLW9mZi1ieeKAnS4NCj4gDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZQ0KPiBudGF0
aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdD9oPXY2LjEyLXJjMiNuMzk2DQo+IA0K
PiAqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gY2hvb3NlIGFuIGFkZGl0aW9uYWwgaW1wZXJh
dGl2ZSB3b3JkaW5nDQo+ICAgZm9yIGFuIGltcHJvdmVkIGNoYW5nZSBkZXNjcmlwdGlvbj8NCj4g
DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZQ0KPiBudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1w
YXRjaGVzLnJzdD9oPXY2LjEyLXJjMiNuOTQNCj4gDQo+IA0KPiDigKYNCj4gPiArKysgYi9kcml2
ZXJzL2lycWNoaXAvaXJxLWFzcGVlZC1pbnRjLmMNCj4gPiBAQCAtMCwwICsxLDEzOSBAQA0KPiDi
gKYNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX2ludGNfaWNfaXJxX2hhbmRsZXIoc3RydWN0IGly
cV9kZXNjICpkZXNjKQ0KPiArew0KPiA+ICsJc3RydWN0IGFzcGVlZF9pbnRjX2ljICppbnRjX2lj
ID0gaXJxX2Rlc2NfZ2V0X2hhbmRsZXJfZGF0YShkZXNjKTsNCj4gPiArCXN0cnVjdCBpcnFfY2hp
cCAqY2hpcCA9IGlycV9kZXNjX2dldF9jaGlwKGRlc2MpOw0KPiA+ICsJdW5zaWduZWQgbG9uZyBi
aXQsIHN0YXR1czsNCj4gDQo+IEkgc3VnZ2VzdCB0byByZWR1Y2UgdGhlIHNjb3BlcyBmb3IgdGhy
ZWUgbG9jYWwgdmFyaWFibGVzLg0KTWF5IEkgY2hlY2sgdGhlIHNjb3BlcyBvZiBiaXQgYW5kIHN0
YXR1cyB1c2FnZT8NClZhcmlhYmxlcyBvZiBiaXQgYW5kIHN0YXR1cyBhcmUgdXNlZCBpbiBmb3Jf
ZWFjaF9zZXRfYml0Lg0KSG93IGNvdWxkIEkgcmVkdWNlIHRoZSBzY29wZXM/DQoNCj4gDQo+IA0K
PiA+ICsNCj4gPiArCWNoYWluZWRfaXJxX2VudGVyKGNoaXAsIGRlc2MpOw0KPiANCj4gV291bGQg
eW91IGJlY29tZSBpbnRlcmVzdGVkIHRvIGNvbGxhYm9yYXRlIHdpdGggYW5vdGhlciBzY29wZWQg
Z3VhcmQgZm9yDQo+IHRoaXMgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlPw0KPiBodHRwczovL2VsaXhp
ci5ib290bGluLmNvbS9saW51eC92Ni4xMi1yYzIvc291cmNlL2luY2x1ZGUvbGludXgvaXJxY2hp
cC9jaGFpbmVkDQo+IF9pcnEuaCNMMTMNCk1heWJlIGxpa2UgdGhlIGNoYW5nZSBpbiB0aGUgZm9s
bG93aW5nPw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1hc3BlZWQtaW50Yy5j
IGIvZHJpdmVycy9pcnFjaGlwL2lycS1hc3BlZWQtaW50Yy5jDQppbmRleCBlZjFjMDk1YWQwOWUu
LjU0ZDE4ODFjNTZjNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtYXNwZWVkLWlu
dGMuYw0KKysrIGIvZHJpdmVycy9pcnFjaGlwL2lycS1hc3BlZWQtaW50Yy5jDQpAQCAtMzIsNyAr
MzIsNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaW50Y19pY19pcnFfaGFuZGxlcihzdHJ1Y3QgaXJx
X2Rlc2MgKmRlc2MpDQogICAgICAgIHN0cnVjdCBpcnFfY2hpcCAqY2hpcCA9IGlycV9kZXNjX2dl
dF9jaGlwKGRlc2MpOw0KICAgICAgICB1bnNpZ25lZCBsb25nIGJpdCwgc3RhdHVzOw0KDQotICAg
ICAgIGNoYWluZWRfaXJxX2VudGVyKGNoaXAsIGRlc2MpOw0KKyAgICAgICBndWFyZChjaGFpbmVk
X2lycSkoZGVzYyk7DQoNCiAgICAgICAgc2NvcGVkX2d1YXJkKHJhd19zcGlubG9jaywgJmludGNf
aWMtPmdpY19sb2NrKSB7DQogICAgICAgICAgICAgICAgc3RhdHVzID0gcmVhZGwoaW50Y19pYy0+
YmFzZSArIElOVENfSU5UX1NUQVRVU19SRUcpOw0KQEAgLTQxLDggKzQxLDYgQEAgc3RhdGljIHZv
aWQgYXNwZWVkX2ludGNfaWNfaXJxX2hhbmRsZXIoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KICAg
ICAgICAgICAgICAgICAgICAgICAgd3JpdGVsKEJJVChiaXQpLCBpbnRjX2ljLT5iYXNlICsgSU5U
Q19JTlRfU1RBVFVTX1JFRyk7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICB9DQotDQotICAg
ICAgIGNoYWluZWRfaXJxX2V4aXQoY2hpcCwgZGVzYyk7DQogfQ0KDQogc3RhdGljIHZvaWQgYXNw
ZWVkX2ludGNfaXJxX21hc2soc3RydWN0IGlycV9kYXRhICpkYXRhKQ0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oIGIvaW5jbHVkZS9saW51eC9pcnFjaGlw
L2NoYWluZWRfaXJxLmgNCmluZGV4IGRkOGIzYzQ3NjY2Ni4uMzk5YTRhZTMwMjA1IDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS9saW51eC9pcnFjaGlwL2NoYWluZWRfaXJxLmgNCisrKyBiL2luY2x1ZGUv
bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oDQpAQCAtMzgsNCArMzgsNSBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgY2hhaW5lZF9pcnFfZXhpdChzdHJ1Y3QgaXJxX2NoaXAgKmNoaXAsDQogICAgICAg
ICAgICAgICAgY2hpcC0+aXJxX3VubWFzaygmZGVzYy0+aXJxX2RhdGEpOw0KIH0NCg0KK0RFRklO
RV9HVUFSRCAoY2hhaW5lZF9pcnEsIHN0cnVjdCBpcnFfZGVzYyAqICwgY2hhaW5lZF9pcnFfZXhp
dCAoIF9UIC0+aXJxX2RhdGEuY2hpcCwgX1QgKSwgY2hhaW5lZF9pcnFfZW50ZXIgKF9ULT5pcnFf
ZGF0YS5jaGlwLCBfVCkpDQogI2VuZGlmIC8qIF9fSVJRQ0hJUF9DSEFJTkVEX0lSUV9IICovDQoN
Cg0KPiANCj4gDQo+ID4gKw0KPiA+ICsJc2NvcGVkX2d1YXJkKHJhd19zcGlubG9jaywgJmludGNf
aWMtPmdpY19sb2NrKSB7DQo+ID4gKwkJc3RhdHVzID0gcmVhZGwoaW50Y19pYy0+YmFzZSArIElO
VENfSU5UX1NUQVRVU19SRUcpOw0KPiA+ICsJCWZvcl9lYWNoX3NldF9iaXQoYml0LCAmc3RhdHVz
LCBJUlFTX1BFUl9XT1JEKSB7DQo+ID4gKwkJCWdlbmVyaWNfaGFuZGxlX2RvbWFpbl9pcnEoaW50
Y19pYy0+aXJxX2RvbWFpbiwgYml0KTsNCj4gPiArCQkJd3JpdGVsKEJJVChiaXQpLCBpbnRjX2lj
LT5iYXNlICsgSU5UQ19JTlRfU1RBVFVTX1JFRyk7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCWNoYWluZWRfaXJxX2V4aXQoY2hpcCwgZGVzYyk7DQo+ID4gK30NCj4gDQo+IA0KPiBS
ZWdhcmRzLA0KPiBNYXJrdXMNCg==

