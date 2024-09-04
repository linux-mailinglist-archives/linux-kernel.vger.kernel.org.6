Return-Path: <linux-kernel+bounces-314023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9CD96ADC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C47285D24
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9842945A;
	Wed,  4 Sep 2024 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J9CfO00Q"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6463C;
	Wed,  4 Sep 2024 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413058; cv=fail; b=DGDN2R6XDl8Me4qbkgIqO8XywyR6rZ5Mr2tjTccMICGM4pGaenTLQ2gfOBQuQ6ugFGJaguzm/UGBgGkMDrjwFuHGA9xPd6T4StPK5PLHYo0l//+d8Gawddom8alKCt6nQ7eF8x3pZFBVzITOTP3osyb+w/KpufZYYix9PbnNGLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413058; c=relaxed/simple;
	bh=CnoadoTFlgDqAU28xg9TscgiO0XKhc9skIV1CosesCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OyPfzj9Bn6e5H0mEXB5bTvjvS9mJLN5rMw5Nc8nHANdZ+qFB+aD4v99hXNVfXIWmKcogtH68FBm+Ir6ludtGC1HpeGXd+HDw5eudk9rFupY4gjdBbVOf0q3wAbdA0L9aSR3O9oy0T1GntN/8Ta/MhAyVznFwx046CAtusJyuPOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J9CfO00Q; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmfS7tyWXU3UgzQFN3nAqes4QVmiO2G0VqM44OTQIqxuISPvbkJWHEN0LkwPhyPsHcA+KIyn5h/YZku8IZIvNE+xA6kOjFaqxEJWwuVXDzO7IverfHrCBDRbn3+8oUUvZH6Re+Om0TTzUe13pDl80INK+/rNXOgrLFf3NtJfvxgejeBEt36Pqe37XTvM8LDvwXWnz0MSqnIotXN12qJT71uAoxYWuGXrUdDdkKKyhc6Ms3Dx0jJEXz0T366FueSCyipWSjrj9359227YPKldA/uX+uv8+rhSuReAH54BJiuh94BAGGSKjwCsYE8MfePMrwDuUY0R3bqGlv6f41UW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnoadoTFlgDqAU28xg9TscgiO0XKhc9skIV1CosesCA=;
 b=xZgvA/7Klg0rnIAl9/l/stKdhoEcEFzdJmkpWX4RTSXGdrUqKqrUhRpsAlUhw/YPZpwDhkP+TJa9u/2fecYKYAYY2J4DnXf3g9qWr5+X6iQbhEwullhg7v7y2qtQ/rTKjxqJL/VUhzgjwcY/Gv7efZ8BoCuZzwo4cgVQgJTNb9lYIHpHnBTU/mTsULs8EjEnJLyR0ik0z/8u5cuhPgLA7/z5bNs7m99epHgBbzusV2SFT+V2BM++iPdCqwr8ZzS/pjBeWfu5lVhAimXLxG9iKhY6D5721qw/7YXzG1e0BzVWB4XtclFOz7yR3icsR6L3Kly3zqMLHjCp/dZHL1WKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnoadoTFlgDqAU28xg9TscgiO0XKhc9skIV1CosesCA=;
 b=J9CfO00QsV09pPDnomVIsQI9qhY8WCf6VqqKP6jxO4GtrB912Q9wwp9iD+D5VOlbpAVphSMUZYNvC4G4k1pWizTfSGbh+AcEaIH6tqj9dXjYt6jmm6qggWvDeFxizASHT5KC4zb0uw4/zn3Lna8WNj8gJbDykiiZ8tDfoJeZ6IA/YevTT9Ie81vgcTzi0FMKnp06JqN52SXqkSt/p1TRbYoz5xY+xCFa7Cx4wAuMV1V6zFRjb7+8pfKtemLsFksSsCvaIEIUSoHB9E3oZisMoKe6oCi8NtWuh2d68v7ZG7C2wyx0uaZX0svcS+L1LZgks18w5Sd2U1FB2d+N44Y0TQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB8805.eurprd04.prod.outlook.com (2603:10a6:10:2e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 01:24:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 01:24:12 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"abelvesa@kernel.org" <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v1 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
Thread-Topic: [PATCH v1 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
Thread-Index: AQHa/do9Amcx/fZehUKA0S3Ogw2bVrJGBqGAgADPqpA=
Date: Wed, 4 Sep 2024 01:24:12 +0000
Message-ID:
 <AS8PR04MB86768AA98590AC6B2657466F8C9C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1725350397-19527-1-git-send-email-hongxing.zhu@nxp.com>
 <1725350397-19527-2-git-send-email-hongxing.zhu@nxp.com>
 <5712ca1f-8570-4f2f-bba2-beb2968bb5bb@linaro.org>
In-Reply-To: <5712ca1f-8570-4f2f-bba2-beb2968bb5bb@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU2PR04MB8805:EE_
x-ms-office365-filtering-correlation-id: 4e387c1d-9d2a-4bbf-df5f-08dccc8048cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGhvL25oSmtMOUZjU3ArQnJlMktxSElGdi9YQmtEY3lzMXJzUDRhZlN4UjBL?=
 =?utf-8?B?cDQzVFA5WGEwejk0dHhNdEpIRXZwaWhrNXpRanVZVXJNY3NpUnltTzYvdTFn?=
 =?utf-8?B?MndEUWJmVmoyZGdVc2NrZEQwYmlxQ1JCT05JN2xsV01tV3NUb2YrM0h1V2dU?=
 =?utf-8?B?SXlENldCWU5HRlBIVU5mYXQwME45Z2ozM0dNczlBclIvYkdPY2srY3Nua29V?=
 =?utf-8?B?WGMvS0k0czZyRUQxdGNmblRjdVkvSm1qNldzcVVneWovdm40UE9HSzBVMDNX?=
 =?utf-8?B?S0JoQXNtTzMxT21hcThMYXhDZW9CRFlsYm5SV3J0aGZ5T05MV2Z5RUxYVzQw?=
 =?utf-8?B?QnJSTmk0ZktsL3RoMmQrSkcyYk54OXlkK0JqWlBRem02ejBaZHd3a3hDWU1w?=
 =?utf-8?B?UWNBdXpSaGRMYmFra2dqY2hWZWpHN2M2T1BXVUhpbzRCOElEVHZZSUFuRzRX?=
 =?utf-8?B?SEJtbncrQmJCVEJoREtKU2dsMEltaTNXQ2VyM0ZpTmZ5aTIyNGRmbTNqVXFY?=
 =?utf-8?B?R3RxMlJ2K0lGMjNORVg0eGFPc0pOb2pVcjNDZ0laZGIxR1dpdkNaWVNRWWNa?=
 =?utf-8?B?bTlTaUtoNTg5Y0dUZ3NpMFpmQU5BaytST3ZxMHlHOHpxT01HMjY1SmFuODU1?=
 =?utf-8?B?WmNOZy80YkFZTW9vYUM1U050d3BSR00wN2RUZUtFN3FhUzJPMWpSeHpQcjkr?=
 =?utf-8?B?ajNzbDBKbmJDUGlXamFDRVpWVXoyUS9MRTAwMnh3T2tkRE1EK2kzekZkVDZW?=
 =?utf-8?B?Ums0cjlpZERsVGZkMTYxbUtnTUtHTHVYK1J5aHQxbFl5cnM5N2dtYnEvTjlN?=
 =?utf-8?B?RFVUSXJQSTBOM09qbTFNTFhSdjY1YUltcGR1MG9tdFkzUG9lMklaeWp3Q3Q3?=
 =?utf-8?B?V1FPRm5zWi8zODl1bVlKVE43NHRGVVdBa1hXZHRkeDFuNUdjYlVLTEdtNG1i?=
 =?utf-8?B?NHpraW0yZGJFdEQ4T0x0RlFrclhxeWN6SDlmVUZPd2xzQVI1SzJock92RGRM?=
 =?utf-8?B?QVJGb001MEJSN3l5ckl5TWxSb05CekRKNnpReWgzMlRyMkdFR2Yrb3FSdGoz?=
 =?utf-8?B?alphT01lWE1yZDlhOENvYkM0U29sMm5MS2xjeE1yZHhIL2JVNlRpNkxWVVgz?=
 =?utf-8?B?VkZ5d2FFNXRqMXAvclNzOUI5T1kxLzZ0TVdjRkJsWDc1cXBKcm03RGFVNEp2?=
 =?utf-8?B?VXdQUS9vU2xqOXY0clpKOEhNUkhqVGRSQ1AwdFl6S3JYTVR3d2hQTEdFN1Ax?=
 =?utf-8?B?aHIwdHZnM0lENVhrcGFhUmJRK0owQVZIVEt3RkpaWHhxRkYvdDRMakRaVlo3?=
 =?utf-8?B?VnpCUnliMllXbkgrYXdHYXZoOHZDbkdDaXFxNUFrY1FnUGpEejFOMXZIZFI0?=
 =?utf-8?B?NC9lSXZKSGE2UTZBZTMwWkRleGFmNG00bU1IQVlXczJPYS96QnNRcUhEeXZ4?=
 =?utf-8?B?c3VQUHdDd0U0ekprQmM0RjhuSnQwMFJmblA2eG4vSXd5SlZJZEFjVTJMS245?=
 =?utf-8?B?WStVNGtoeDNZQlpqRk4vUlVMSVNnVW9pV1g5azM5SWJGZ05NNWJRY1RoNnVF?=
 =?utf-8?B?MnhSbm91R0MwSTFmZFVseWJmZ0lPU1pNMjB1OEVBcytndDZtMFd2RXBCcy8w?=
 =?utf-8?B?b3ovcUJ1OHN1dllKbDNxcHZQSGhLREc3RUxCQ0tKUWdnWDZFcjF0SVFlVk1N?=
 =?utf-8?B?TlUvUWJBZmhlUWNYZ1lDazBwUjBWNjRWZkdKMnZRUFZRdDhYYzY5NHdJb2U3?=
 =?utf-8?B?Qm80NGZHR1RWYjRUZHN4WVpqMFphMHZkZ3ltUWp5QnFCMGhMUGpzdG9xQzlI?=
 =?utf-8?B?a0ZHT0t4TnJWM3F3MjZBdWNoYyt0cTY1VTViWUVzUVNZcmJIRzNjS2dxSVFp?=
 =?utf-8?B?L25BUDJoUDhqVC9wZGdvUW5ZSUlva0dJaEQ3S0dTWHRzanc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlgyZmMxczFBaGtaaExBZWcrUGxjeW9MK2tWRmtwMnFPekg5R2k1aXplVkNx?=
 =?utf-8?B?cEZQT3JqOTJPN2w0cExFdHRmSzlKYXZZZmU4b2ZqZVE1SjFlTXFDWmhkV0NY?=
 =?utf-8?B?MFY3S0NHN0h4clpqM3pUb1dNOFhOcmZJZndnbVVOa2VTOGZ3cHVzOHRsZGNF?=
 =?utf-8?B?bkVoL3AvaURuYWwwVW13RmxLUnd0REtzVDd4dTk0K3pRaFQvcTFVMUF1T3gz?=
 =?utf-8?B?VkUycVQwUmwrOUtUMWUvNytsVENqS3BkbjJLNHJFU1FQZHZPZE1HbE9yYjc1?=
 =?utf-8?B?T3ZBUlZHN2NoU3hRUDQwSWNuU2FXbDFWQ0w1WGRMaFY4VjJ0UzlFN0lDL2JD?=
 =?utf-8?B?S0NvdmdyU1daQlo1MG1GNzhrdWFId3FhdVRvV3lTSm92YzZhUFVuQjB0MWMx?=
 =?utf-8?B?Q1lETUU1T0xBQjhxMi92ei90a0gzVnhIYWJJNHpqZW5kbmlvNWJ1S1V2Qis1?=
 =?utf-8?B?cTYwNGg2V016c1BlY3NOSk5acnZzaFFTVVVidjkxTEN1anZVT2NWRHk4Vk1p?=
 =?utf-8?B?T2dsOUxMU1NiZGJLNnpYRFg1eEZVdG02K2lER1h5U1dJc01WQnlWRUI0bTB3?=
 =?utf-8?B?RG9rVy9OVkRRTisybVc3bUdkVTU4UCsySlZUYnYxeVRIWjVZQkJkaGxiejlV?=
 =?utf-8?B?VUJJdWttSXBUN3p2OXV3YURLV3hFTkdaOWlCWEkzdlkxd285MWRzdENPS01k?=
 =?utf-8?B?bERydjY0VXVjckJ2NzBrTGhxbDZBRml3U2dUQURvMHJTN05FT2RRN3hoQW5Q?=
 =?utf-8?B?aVV1OStFM1QvUHcvRS9kZ1g2bU1tZmlRZHBwRk13djlmdDJ6K1FKeDcrenFU?=
 =?utf-8?B?ZCtETU5OTEFnTDlXcW4xN3BvRXdvZXd5cXJtUlNxaSt6L0VXRXRkM2pKQ0VF?=
 =?utf-8?B?WEhHRDVtWEoxS1lWMngxZGZZQ2UyOG1vUm5UbHlORE9xSElvbytuWjZUQ2t1?=
 =?utf-8?B?enYvN0dBZlRqTkdOTzh3Wk1BSWdFVXBGYWhJVlZ5N21NRGx1cjBrY0hKdWFD?=
 =?utf-8?B?L3JHTjh2NWpvTTNnbGpuV1dpZ0FjeEtnRFZQSGlqTHpyTFJyMWpYVldLSHFV?=
 =?utf-8?B?aGtLcjFUaUUyTk40SzdzUUJTZ2llUUdGWnpnTzR6blFlUVA1VGNhRnZ0NGN1?=
 =?utf-8?B?OWJncmorYmI2UlBtS3BIRlFXdXdrM1NYMGFBWFR2NFRrYjA4U3VEb1FMWDl4?=
 =?utf-8?B?MUpnRTdQQnIrQTUxUkV0SGhaMFgxQUcyK3NNSWZjMUxJL0g0aXBRSjY3cTl1?=
 =?utf-8?B?eGtvbXZieGtTajJBT1VmUFBLeHYrOENTcDU5dnJpNko3Y0FMUS9ORWFDRUJL?=
 =?utf-8?B?Ri9wVXB0ZndLNi83d3R1anF2dktCdmxudW1VeWUyWlFDTEprRWhFUDlLNU8w?=
 =?utf-8?B?NFpsdjllU1d5WEVldzlrKzRqWjA4ZU4yK05sc2liejVzemtZS3BaRU5GNTBQ?=
 =?utf-8?B?OXJQWStYSEl3dDlPbEdsNnV3a3pmamRTRlRGaEZxNWJ5Uk5nYzFjY250cFNY?=
 =?utf-8?B?a3cycTVhb1FCS0dEcWhNZ3JBNEdwZEtENmhsUDEydHE2VFo1T1BTUitxQ1FL?=
 =?utf-8?B?WGFzWVk3bVZPanV5c1hnNFVNUDN5WTdOWmdUMklFcEQxYUdtS2ZHUzFVTmFU?=
 =?utf-8?B?aGJWK09mQ0lDUlNXQTNWQVF5WXFncEpWWGJ5YXBDMThybEMydG5vRmhHZHdW?=
 =?utf-8?B?WENEam5EcnJ5MXZ4cmZyVDBpWDhweHBwdit3K01wS3pWd1FGRU45cEl2ZE5N?=
 =?utf-8?B?RXNBbDZlUXJqQzByYk9aeGN5a014cWUwR3N2N00zZmEvaktEVTNqSUdpT2dp?=
 =?utf-8?B?clVaeHFxWVEzL3lSYURZSDRaOXRuL2ZzNVc2TktiUUJRNXgzT1hwdElaRi9z?=
 =?utf-8?B?eE1pRUVTVkhKcHJLdHllWmtCcHE1SXRremVJaWdGMTNpVEMvYjBEV1JSbmcv?=
 =?utf-8?B?QXQvelE5WUE2MERvTUZ0WnI3bGM2SVVlTDRjR1lRYlBuUWRLcjh0SzZwZEYv?=
 =?utf-8?B?ak94MkRlN2dqb09VcmRWSm1pbVp0NGpERlF6bG81WVZlUXhsdjBEUG5PYStj?=
 =?utf-8?B?K2pnUkJRdTNkR0VzZ2l1cE1NakxocitmWmgveDFUc0g5elN4d3czUS9MUHli?=
 =?utf-8?Q?VcC6cTnTw1tdaVW8lYT8PneRI?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e387c1d-9d2a-4bbf-df5f-08dccc8048cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 01:24:12.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2JzHK286d9QQOLSkq3O4pMYfelk3xrpaVYtZkuA1oK/44pzxMWMtNnvPMIGPn+VtUuFapTj2O/FSbBxsAdNMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8805

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ55pyIM+aX
pSAyMTowMA0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGFiZWx2
ZXNhQGtlcm5lbC5vcmc7IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgbXR1cnF1ZXR0
ZUBiYXlsaWJyZS5jb207IHNib3lkQGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2OyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIGR0LWJp
bmRpbmdzOiBjbG9jazogbnhwLGlteDk1LWJsay1jdGw6IEFkZA0KPiBjb21wYXRpYmxlIHN0cmlu
ZyBmb3IgaS5NWDk1IEhTSU8gQkxLIENUUkwNCj4gDQo+IE9uIDAzLzA5LzIwMjQgMDk6NTksIFJp
Y2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFkZCBjb21wYXRpYmxlIHN0cmluZyAibnhwLGlteDk1LWhz
aW8tYmxrLWN0bCIgZm9yIGlNWDk1Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiANCj4gPGZvcm0gbGV0dGVyPg0K
PiBQbGVhc2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2Yg
bmVjZXNzYXJ5IHBlb3BsZSBhbmQNCj4gbGlzdHMgdG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwgdGhh
dCBjb21tYW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwgZ2l2ZXMNCj4geW91IG91dGRh
dGVkIGVudHJpZXMuIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBhdGNo
ZXMgb24NCj4gcmVjZW50IExpbnV4IGtlcm5lbC4NCj4gDQo+IFRvb2xzIGxpa2UgYjQgb3Igc2Ny
aXB0cy9nZXRfbWFpbnRhaW5lci5wbCBwcm92aWRlIHlvdSBwcm9wZXIgbGlzdCBvZiBwZW9wbGUs
IHNvDQo+IGZpeCB5b3VyIHdvcmtmbG93LiBUb29scyBtaWdodCBhbHNvIGZhaWwgaWYgeW91IHdv
cmsgb24gc29tZSBhbmNpZW50IHRyZWUgKGRvbid0LA0KPiBpbnN0ZWFkIHVzZSBtYWlubGluZSkg
b3Igd29yayBvbiBmb3JrIG9mIGtlcm5lbCAoZG9uJ3QsIGluc3RlYWQgdXNlIG1haW5saW5lKS4N
Cj4gSnVzdCB1c2UgYjQgYW5kIGV2ZXJ5dGhpbmcgc2hvdWxkIGJlIGZpbmUsIGFsdGhvdWdoIHJl
bWVtYmVyIGFib3V0IGBiNCBwcmVwDQo+IC0tYXV0by10by1jY2AgaWYgeW91IGFkZGVkIG5ldyBw
YXRjaGVzIHRvIHRoZSBwYXRjaHNldC4NCj4gDQo+IFlvdSBtaXNzZWQgYXQgbGVhc3QgZGV2aWNl
dHJlZSBsaXN0IChtYXliZSBtb3JlKSwgc28gdGhpcyB3b24ndCBiZSB0ZXN0ZWQgYnkNCj4gYXV0
b21hdGVkIHRvb2xpbmcuIFBlcmZvcm1pbmcgcmV2aWV3IG9uIHVudGVzdGVkIGNvZGUgbWlnaHQg
YmUgYSB3YXN0ZSBvZg0KPiB0aW1lLg0KPiANCj4gUGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGlu
Y2x1ZGUgYWxsIG5lY2Vzc2FyeSBUby9DYyBlbnRyaWVzLg0KPiA8L2Zvcm0gbGV0dGVyPg0KVGhh
bmtzIGZvciByZW1pbmRlci4gSXQncyBteSBmYXVsdCBtaXNzaW5nIHNvbWUgZW50cmllcy4NCldv
dWxkIGluY2x1ZGUgYWxsIGVudHJpZXMgbGF0ZXIuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBa
aHUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

