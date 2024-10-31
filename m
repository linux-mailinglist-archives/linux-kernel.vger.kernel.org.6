Return-Path: <linux-kernel+bounces-390244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ACF9B7758
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1E32884D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1CE17E01B;
	Thu, 31 Oct 2024 09:23:25 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2134.outbound.protection.partner.outlook.cn [139.219.17.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED61BD9ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366604; cv=fail; b=hQppE33UvpgHsJogty72IYxSHnkgPOeRN6PSlEeCoLxumu9meXbZRiWG9EAh4d/oJ3dUNjQWLxe9tJVVAV+/KYMtPqJ1C70MPwHlrHiINddUxBQStM0ble0VrJlALevHS9/ZM28VI828XOsj3Q7eZwN+5Byvz85CuLzDMVD8RrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366604; c=relaxed/simple;
	bh=3SZnvTTU1b9To8tKCVRpVZbUSGHFpjYQoDkdHCJDZf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T2XAUvqSqu04EVxkATcFmXO7j9N3UTAFt3d6lAlwlp4vrMIKRw3FMEfNvJoOTEc7lpPjAbQgZBFSfP+B/fger377uGSFb2gtydeZ8XXzZv3VCATesmaWo0qR0a6LiPNNExOKiwLt+MSd7vw4JNsrUDzOzvC8DwMBbsk0AlTQRQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKULHs15i89ks91qEKXSbFSq2ZJwsoHxFwftlpOlaeavd+2zZJDeAGUonqWyayQuJBLytfxQTiFI+osch6uSFdp1mkUSH9J9Gq/c/ubC57VVA+6FO4ugPMQlwL+MRtnUODa0WWIbyHJ9hSA1DQPchMOPDZBfJbNJ/70QYb/t/VVSaF+p4Zcmfg8bJg01S4CCAzVnJ4ur0Qi+mv22mFN9WIbXRlkIJqWWS4gp4OZkyDa6F/dpOZIZTc8SgKP/u+J81S1nQuEXaUrTuKYYTybEvGdLGEX7kFnseGvnYIa17j7Enfq1+Wkgo27cAHvfYLEDvF7lkYkt0X+9qyDKElJKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SZnvTTU1b9To8tKCVRpVZbUSGHFpjYQoDkdHCJDZf4=;
 b=klAKrLXipmLJGXtrAB2cpBIHY7/ET8SNlJuFXDhCPLmgJ9K+5NMaC7jkLqNLsLDHJu6Ymvwyk8819tokAfVN8u4OItbXNlobpWzfapcDDdQpIFb3HPzUkueIYChmgej0AbGzcT/U/fr9GEba4Iw3ax19qni/0MHsCZyn0qBZg+WctIjvvfpn0/2w4Y9GTluK1asBaLholu9j2Dy9XLUU7jyXSdRNrPpfePuCJLITdFLDRFHChIooQB5GQe1iHBAWX2sXV0V876WLDgqs21LNG5YrDS4CByqWcGvbgdkI69dITqMN/PXZIIn20TxMo777ObHC0YUNSD0OvW4KHAlJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::6) by NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 07:51:05 +0000
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 ([fe80::512d:38d7:ed9f:dfbe]) by
 NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn ([fe80::512d:38d7:ed9f:dfbe%6])
 with mapi id 15.20.8093.027; Thu, 31 Oct 2024 07:51:05 +0000
From: Keith Zhao <keith.zhao@starfivetech.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Vinod Koul
	<vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] phy: starfive: jh7110-dphy-tx: Add missing
 clk_disable_unprepare()
Thread-Topic: [PATCH] phy: starfive: jh7110-dphy-tx: Add missing
 clk_disable_unprepare()
Thread-Index: AQHbK2dd0+5aA472p0qaNGM9cgk7ErKgfB3w
Date: Thu, 31 Oct 2024 07:51:05 +0000
Message-ID:
 <NTZPR01MB10503E5B049DA0F2E9B33CAAEE552@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
References: <20241031073428.266942-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20241031073428.266942-1-changhuang.liang@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1050:EE_
x-ms-office365-filtering-correlation-id: 02ecb0e6-cf9c-4692-47b7-08dcf980c61b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 qXiGL/yHvniHeauunU6Khozk1sKRqQFRYe1/CrWABqT00WoCdcj9tMCjlaDJwl7dK3xchyHP+3gy89/bxcoKhb5kHyefZHBka+CHgPku7dCut0qMWW7JFsKvU9Qd8CbJOZgL2GPKEUFSoK5MDlo/vpfOoql8V98w8FndjuHwnvtSNQR1VfBNdOMAK55oOJOugFOMrmxN8vrv+mHyTJnSZw64r7pCf18+stCK0ysdgRivRwtaTTjZ11uSqZJOpKT9Dsm4MM/eztEOSot04cv0mFZWDQdtt4eg1INGAjDUl8QWVwwdlcmeOAsVtn8Qh5QZzrPUeXvWvU2NYpK/S5TzbP1NBKGkw5mWcsMj8/jNaaoKPjpdpuPR6QelWEOk+dfYBQ4WUrgtHn/Qh4Ob2ogPFcZl8R4QFPuTR9O+grA9DUVqZ4jtGLlWtoECDY2Q/VvudK/1mFn/Iz920aJkViEVbLyRU52eJQGFwegjXqwzHaoZ4RVmuo81X/g6JYEdDBLTbOSXvBBT7F4N6zmxFw9hfdVu7XG4eA7wMKnLoVMHfIN1/+93vS4Hm8MlQKKF1tTrNM1/AT243Ts9AGBZX5yRxF0f46XpordurJ5kNi/eTxmvrWvqxHxgoLod9EpVHNuN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?STdmQVlQNm02UG9WNGRuc3RGeGhMRkQ0TzdsUFJaalgxaFUrSHQ4bXBlZy9U?=
 =?gb2312?B?TnNLN1dXbHQyeU9qT01MMlcwMzk5aGVFWVNSNjEyQS95OUlnRlhQNzFZOERo?=
 =?gb2312?B?K1I1eW9odTJUckp3TXBlTjlFWlp4d1hibmdnd2UyTGNoMnBNOHVEWDRISkpP?=
 =?gb2312?B?dnJzQlpLZTdNRHZJTWlvRG9wd2VFTUE2SXg1MHhGTWJJL0h2NjZOMXlrazNr?=
 =?gb2312?B?M3Zzc1VPeS9PYytPOHhnR2FMRk5oNlEvK0lBdHV0Rldnc1pEMkdQRU4vSHFK?=
 =?gb2312?B?OWI0TXp0Um92WVVTMnZnUmp6djl3aHBabFdtQkhRalJYUVRoV1FyQk1uVnVX?=
 =?gb2312?B?eEZyVVVaWmFJS2dEblhickFWY2d4Y0tQZ1BGNXNHNTRrOGx6L2ZGME9pRXoy?=
 =?gb2312?B?TlVkRzBHRFpYd1VHSWVTaHZWQUQ2aXVrV3BTY3hKTlUzL2RFZFJneG55VU1Y?=
 =?gb2312?B?M2d3WStKYzV3VmI0U2RUcndleXNCRzc5VUEwSkRDcHVKY3JXYllSRFI5K3dP?=
 =?gb2312?B?UmE3NmdXK3NMd1RNRUJmcmlkbktmcTBDZTJtWE0vdUNZZnJ0ZHVqZFkxL0F3?=
 =?gb2312?B?dUMwTityVXc1T1o4U3NVWkNyL0ErSXpGeURHNVdVQkRBUUJkQ3lHRFBoMnBX?=
 =?gb2312?B?S1E0cWZ2bXNQVjJ4K1dWcXJOR2E4dzY0OTR5STJQYlZPRml6emV6b1kyRmFN?=
 =?gb2312?B?Mk1UNGV2UVFWVXpLUThvSFVOaWVqYjNSSkRvZTM1QThaWjRwcDJmcTB4N29H?=
 =?gb2312?B?eEdqYXhpYmgwc0VHdG5pTnE0MlRYRDFBVnVPOXFlL1NqUC95LzdiU1ZHcHpu?=
 =?gb2312?B?MjRRUDRKT1N0Z1N4ZXYxSHg2Q0J2WHgyWFA3a1V1djZQNjllYWxSWTNnSWhl?=
 =?gb2312?B?UjJMWlJUK1hEYVA4bGJNbUQvM3FpWG1KZ3hpUTRTMnhsRjFnVCtQMlBCRm1s?=
 =?gb2312?B?TUIrK01qQXUwMVM2dld6S2E1dlM3ZUN3VGlYN3ludVBPVGFuNHhWZHhGZ3lX?=
 =?gb2312?B?V21LSHdZd0VUQVB4QWJlaXpXVWpiait5SWNLTXpWSEhvL2VMWWlEVHV4N3FL?=
 =?gb2312?B?Q0JIeFZLUG0wSmlZN2JaTFJRRWhKUml0czFHeVFFMCtkeDhOY005Vys2SEEv?=
 =?gb2312?B?Sm5WcFg2WlRrTzMxVVVlcjVMS0R1OEsweUo1NkdINDVDZkxPS1VLQXlmU0NL?=
 =?gb2312?B?eWp2SkxLVlp3RGRNRE5tWkdLSTVLbGZOb0Nta2NEdzRtdUVyb1N3WDNMMUpV?=
 =?gb2312?B?N0dRS1J3S0xtcVVUdG1VNis1ZzZPZkJqY3dWY2NEejlscEp0OExYbEU4MVo2?=
 =?gb2312?B?S3hZWnh6NnJPR3V6c3licHczT1RySDZTTW9wWjBzZ0RpUjM2RnZzc0tHUzFx?=
 =?gb2312?B?ZS9rZGJmMzgvOFd4VXAvWVQ3STRDUHYxZnpmVTkxb1ZHYk9wTGQzOXF2ZkZt?=
 =?gb2312?B?YTVqY3VXY2JFODVGNTgwd0IrWHNsSUo4U0dBRlR3VXN3L211Y2M0bExubDMv?=
 =?gb2312?B?RklrUTdHalh0UTJ1WGZqMFhmNWRpK29NcWRIUEdDTHJtdG5aUnlzdWdsTmhT?=
 =?gb2312?B?WWtjakNnelA2VUFESk5BUlZmYmF3UUJlT2RPM0RZYUFOaUFhdTZtN3REbzA5?=
 =?gb2312?B?eXBmWmVPa0ZYMm1CYnRMeEozLzdmRVJmSEtmaUJkcFRIRTMwOEtFSzhNZDl6?=
 =?gb2312?B?WnJJaVZ5MW5CRDRhZnlub2d2MmpoTklQOHRYWkxRU3FmVGtOQUJvSHdIcWpa?=
 =?gb2312?B?VTR4cGV5ZDNyRFZ4d0syUmVlaUJ4KzREdHFxeTR4cTA2VXNCODVEbnFVcDNJ?=
 =?gb2312?B?bUorWjBHL1p1WXJOL3h6M1g0L3h4SGZVNUwvSFZlMm1yZzZUaGJtVlNuamps?=
 =?gb2312?B?UUlYZ1U2enN6WkRSNCtUOTJIdHUybjBrdm4ra2NvdmVQbjhaQ0Q1R0p2ay9i?=
 =?gb2312?B?UHNnNnkvOUxsSVJqK3l6dURsRzlUcmpDSkErUVVFNmNzaHFhcDVxL2RvWkh5?=
 =?gb2312?B?aUpHd2FsV2w0Y0lYMUkxbmZjcjh6ZGNndkJzaUhoalVMaHo1OUN3YXczb0Na?=
 =?gb2312?B?RVRBVk9RNW5LYkQrZkJJMzZuNHluSU1Sc2NWdHdneDBMWk5kZVk2ajBGaEVr?=
 =?gb2312?Q?ceyqF+BJkSNISyrskvSLZJdOx?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ecb0e6-cf9c-4692-47b7-08dcf980c61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 07:51:05.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5q1V0kFnV3Y2+/1IUY+deJoXhRlzJoNl9v3v2yJpPXCCmSMIqzaupTnK2yNf1a2f6M+7ancyHh1JIaur4Y0GJXjh5LHts8fv6uJX+NofO1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1050

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hhbmdodWFuZyBMaWFu
ZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiBTZW50OiAyMDI0xOoxMNTC
MzHI1SAxNTozNA0KPiBUbzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47IEtpc2hvbiBW
aWpheSBBYnJhaGFtIEkgPGtpc2hvbkBrZXJuZWwub3JnPg0KPiBDYzogS2VpdGggWmhhbyA8a2Vp
dGguemhhb0BzdGFyZml2ZXRlY2guY29tPjsgQ2hhbmdodWFuZyBMaWFuZw0KPiA8Y2hhbmdodWFu
Zy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPjsgRGFuIENhcnBlbnRlcg0KPiA8ZGFuLmNhcnBlbnRl
ckBsaW5hcm8ub3JnPjsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBwaHk6IHN0YXJmaXZlOiBq
aDcxMTAtZHBoeS10eDogQWRkIG1pc3NpbmcNCj4gY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkNCj4g
DQo+IE9uY2UgdGhlIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoKSBmYWlscywgd2UgbmVlZCB0byBy
dW4gdGhlIG1pc3NpbmcNCj4gY2xrX2Rpc2FibGVfdW5wcmVwYXJlKCkgYmVmb3JlIHJldHVybiBp
biBzdGZfZHBoeV9pbml0KCkuDQo+IA0KPiBGaXhlczogZDNhYjc5NTUzMzA4ICgicGh5OiBzdGFy
Zml2ZTogQWRkIG1pcGkgZHBoeSB0eCBzdXBwb3J0IikNCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyNDEwMzEwNzE1LmR1bzNTaFI0LWxrcEBpbnRlbC5jb20vDQo+IFNpZ25lZC1vZmYt
Ynk6IENoYW5naHVhbmcgTGlhbmcgPGNoYW5naHVhbmcubGlhbmdAc3RhcmZpdmV0ZWNoLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IEtlaXRoIFpoYW8gPGtlaXRoLnpoYW9Ac3RhcmZpdmV0ZWNoLmNvbT4N
Cg0KPiAtLS0NCj4gIGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtZHBoeS10eC5jIHwg
MSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3MTEwLWRwaHktdHguYw0KPiBiL2RyaXZlcnMv
cGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtZHBoeS10eC5jDQo+IGluZGV4IGM2NGQxYzkxYjEzMC4u
N2I1OTQ5Njk4M2QyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3
MTEwLWRwaHktdHguYw0KPiArKysgYi9kcml2ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3MTEwLWRw
aHktdHguYw0KPiBAQCAtMzMwLDYgKzMzMCw3IEBAIHN0YXRpYyBpbnQgc3RmX2RwaHlfaW5pdChz
dHJ1Y3QgcGh5ICpwaHkpDQo+IA0KPiAgCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoZHBo
eS0+c3lzX3JzdCk7DQo+ICAJaWYgKHJldCkgew0KPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUo
ZHBoeS0+dHhlc2NfY2xrKTsNCj4gIAkJZGV2X2VycihkcGh5LT5kZXYsICJGYWlsZWQgdG8gZGVh
c3NlcnQgc3lzX3JzdFxuIik7DQo+ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAtLQ0KPiAyLjI1
LjENCg0K

