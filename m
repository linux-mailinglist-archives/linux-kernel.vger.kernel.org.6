Return-Path: <linux-kernel+bounces-169266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FAC8BC5ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8631F2161D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2C3EA64;
	Mon,  6 May 2024 02:47:09 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76C22075
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714963628; cv=fail; b=R1J4ub+lJfjKAr2wV41aMVuSaIgdGmTawJRGUbB6YmCk0uPNyj99sDwhxrVx7eY1t7v++SLT6LG5sPzZV8KtpRyjVHaDToAfv+e0JvYB+HNBXRo7VTRQMyfXX85F/T9ws05Tec/AZ0od4X6njlQBciVOUm4oWK7QjAJgaNSiGd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714963628; c=relaxed/simple;
	bh=vHKu9ME0dAUnnyP8jkLjBfSJi6FMr2EDfFnzykWSen0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6S6kE1/mGMy7bwXpLfO9cbpyj5qPIlzd1Y2iZOji2l/DDeTPIHvgnpw7ZBPyByjLgyT698p466ehHChsWFqZx43Uv31hUHkotm2iiCSF8is5xYxzsUlUCbHsCVkZ4KlLQJ5w5kJ/dQ8Rki3Tsm1PSgP7sJwMOsaEDAk1KiTHFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtWgjprOwZAFY5yaAdU7Mjtbl5qrHp8tW/Qr24Yefdo2K6+1RvwUZFiTVdJvysZ4lvwD83fFeT3soisknvrq86vo3E/hhVwtcIdEXohWZc5HB0a16wnShRb86SQWBGBa+PTEMqM0edLQ3JvBKzwO0skmQMoH4ivDo8mtxuwI7SVeSxB/o7K5M68dAdIM5gZ1f5vy1N3TjaT0xOAxrtLi+Cm0G9eh9cbd+w4yVextJ870RlHPhZ2+uXbcPNKQNg2RQ/z4Jz02GUl2iN+Wy1r+J4XP2fYl+bCuOAZGFhCpPlyCLCj7VLnZ4ZYfx8+zxTMbAOeU3XkqRG5va2vOq/pV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHKu9ME0dAUnnyP8jkLjBfSJi6FMr2EDfFnzykWSen0=;
 b=R1YgF7Mg/bYDsO1D23++Gtqi7Kb+I1V+cwU5Gy3PHGxIsvKTulS0uQphZM9WRL24xfXMudxiN291qe1Bpf1DweE8TYiyUHSvzLFQmMQBjKLHCMue/J4i0h+vE7XXbGd5X3FJ1lj8BUoYY9P8jJJO49JQ+oIoDb6eL+NK22Ymf2uxkV5isSmiSZEUN6bKyaTVq0ra6o7ohvmOouVV3ploYCqAaBR8X19/E3b0Rj/hae2F8/pW2dO/hZ+29y9cAMrrfSalcOgEZmPskLf/pJf9Lsybik8RPU0Cqnvd2HJf5k2q7Q/RmLPjPODM5CNr2VjcQalXz+ZEESaFqwd3F1/VKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 6 May
 2024 02:31:15 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Mon, 6 May 2024
 02:31:15 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Palmer Dabbelt
	<palmer@dabbelt.com>
CC: Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
Thread-Topic: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
Thread-Index: AQHahY1xSncvYch2v0Wp+YvYWpBQy7GCuL4AgAAElICABvC90A==
Date: Mon, 6 May 2024 02:31:15 +0000
Message-ID:
 <ZQ2PR01MB13078E6EBA4D625735B45843E61CA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240403060902.42834-1-hal.feng@starfivetech.com>
 <mhng-3c2a418c-ce79-4287-a890-208a5d026e70@palmer-ri-x1c9a>
 <CAJM55Z810=pxc+tmgw0yS+Nx=K9h=OGFxOhvtJT7nyGGg0d_nA@mail.gmail.com>
In-Reply-To:
 <CAJM55Z810=pxc+tmgw0yS+Nx=K9h=OGFxOhvtJT7nyGGg0d_nA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
x-ms-office365-filtering-correlation-id: ecd5aaeb-fe4f-42e2-2172-08dc6d749a8e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XA8q6qKmCHlNWR2aFSsW8+vcAbBpWgVGkH/RLFyxsHGyvzQZbAG069X6aXRHc3tKLkYRkP2akK8ZxBv4+JOGoOAvHw7Q7IMhkl/JHcZfv/LwIfP3ePYHx/FmHkTtEsu1dwTK37h23OUlAoWBlcHgdpFlcN//w0iXP3CGwAuPaWlp+amQ1BBHGH/gia+CJQE5uZL/ryUjb7sYIIniXSeC6WEr2aIQ8FQgB+KmN4Br1L/h6QLdLyky11whXci+dAssOf8AXhr2NhvvKxMH/6e1UL5J/DkZZU2ehPX2McIVkUaGarX8eAio8xAz4+OTSb5HLnnvmvCpLNnBtHl0WduheGNhdGA3gOHnX8Q4t3JzXDThNmqe6sKufYNuHEmJftEAiVUTyFl0JNUVFYZXmb0/2GHkMwr35n5e1AOvGXelY/rT8Yt3duUQ1Ou2JI6oxda4X6MtVeSzj6gqR4NHE53m6UJHZCHY1BSOi8ebEKdRUwquTjV+Q0t3Nzk15PEM3O3kMRmV+X2MC08ZNQ3dWrdu4aAg6xGOCtqXQ7bGIuc7ZP2cP/pJcyAlNW6FWOjlN1lmE5vIybmwILwjX5BrU6lHc6bXTtYhHHL6Y/zCI5DHuUxpOz5MIvUTeoSQrYA5JxV3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWxwY21VQWdSanM4SlFpRlQ5NE5weHc4NHp0VGhMTTk1WUJtVHN2a05FKzI3?=
 =?utf-8?B?eGJickZCS2hlamcvTnQrRXg0eWNGS1h3Zm5TV0MxWjFSOVRyREJra2UrV08z?=
 =?utf-8?B?YjFINEliT1hlWFJyUGs3NzhmY01vZjlnYVExUHJZVFlKZTFYL1BkUDFZTkdC?=
 =?utf-8?B?Z2dicnZsalNhK0ExeVZaVXRqczEyeXQ3VmRxSW10SVVZU0RDY2l3ekRheWFq?=
 =?utf-8?B?UFFQK0U4dlRwODFGQ2hPQUxzaUhMVXU4amFhR1ZSc3JBSVZmZ3pMaFRqbHlt?=
 =?utf-8?B?b3R2NURpdFFCNjVoZ1Bhc3lNZk1kMHhab0N3Q1daMmRsWWhkUXdoVnI0THRy?=
 =?utf-8?B?VGlKeGgxUFNpemc0c01ZcGd6WnF4aitGK1RITUxWWkRxM3diY2ltbkw0aW4z?=
 =?utf-8?B?YXBaZ0gwbW1aU280bXV5SGhvbWFtWTZjYW5UbFhCbUJFRDhwY2wxUThPQzlR?=
 =?utf-8?B?K0w5d25DN0NYa2doM0VSWUtET285MEtNMWdoNDlQWFZxSEVoZ3FyYnZQVXhk?=
 =?utf-8?B?aUgwc0x1L21aZks0RnpPdmp4ZFhrRXE2cUVTZjFjdEVrYzIrc3h3WVJEa2xG?=
 =?utf-8?B?NlhHL2N0WGF4NVloWkg0clh6K3BxSXBIdGhrQXdNZmVPS0lyS0xLRjRQVkxq?=
 =?utf-8?B?c3NFTmFSOWl4TnJzcEE3QXI4VFFhRXhCd0lJTU43SW40dktHTldudlU2dzBy?=
 =?utf-8?B?eWFudnBjcy9vOU1XZjZWYThucVpOMXJuZTJSVjhOM2pOQkovdm85QVJlKzZl?=
 =?utf-8?B?OHJPVERvNXR6d2wrYkd4bmh3dENmZUg1Ynh4WVV0TDRsc1NkUHQ2aFlWWDF5?=
 =?utf-8?B?cy9taWovVzJVaWVKK3V2QnV1NU9BRWhXdTkrVnFCLy9jYVNVMGM5Umt4UU5Q?=
 =?utf-8?B?OE5qZE9QMERZNjRVbVRQbmxKOWNaaHdCNzRpZC9wa1psWFYwdE1IOXVHYW84?=
 =?utf-8?B?NkdMZUNwYndScGU2Z0N2b2lxU09HK3cwejdaWUhZeFpwSTFTNUE3ZmYweUl1?=
 =?utf-8?B?a2YyOXY1YmJqTk0reGFMR1RrdWRHY0YxVzY0bkQ1ZzRhM0xVWmNud0hzRFlW?=
 =?utf-8?B?akoyR3d5dE1ENzBsZTdzSy9KU2RSZ3FOQ0Q5NFBOdWhScjdibzVQNXY5SlR2?=
 =?utf-8?B?MUZzYXplaVNrZUxkUmFmRU8zc3dMZ1V2di9FOWlPYmZiTk5BVndTOHRDTHl6?=
 =?utf-8?B?alM5Y0hQaHZMaS9xNHBHUlczWWhQVHlYeU0xMkJkNlF5emxsMExuaTE1ckxv?=
 =?utf-8?B?NmpZRG8yNi9rQXpqWis1M2RVMUl2VzZCeTJoczM3RzdFbThhRTF5YWdyUGdq?=
 =?utf-8?B?WjB3NjZxM3J5akFFUDcyWDJKZDBQdjZjRDliZXNDLy9xdHRpMTRmUTYxN1I1?=
 =?utf-8?B?aEZYTlhsdlFWL3djck1BY2Jha2dSZUtiVGVZak9tc29NSHdsa3lvUGFiT1pY?=
 =?utf-8?B?OTZMTHpSVjd3YXYyckI1alc3dDhNbDd1bUpUMlBtUkFqT1lJRU1vSDd3b0lW?=
 =?utf-8?B?T1JVV2pLL3RvWVBNSmI5ZTB3elpBcUhweGZ6TUJSZTRLT3FhbnNrQWZWL0NS?=
 =?utf-8?B?R215VjJSTmRtZVFKMXJ3cVVRNlBxTGZEakNIa1c4K2NIcFVDKzdsNmRDOXpI?=
 =?utf-8?B?dm0vQ2t5T0E1TzErSkNKQk1xcC9kalZON2VKRktaN0FxZSs3aTNkWDlTdVRN?=
 =?utf-8?B?Z1lMNis2U1RBT2UvZjZCcVhHTElqeXluaC85ZDNkR0ozZnVtQ1liWFVHR2pN?=
 =?utf-8?B?ZmVBMjF1VlVCTnk3d3Q1SlBUNkYyTVFiVjdYVDFsdUc0TEhOV0NnYTBIZmhu?=
 =?utf-8?B?cTBMTG5INFVVWVVVSG01TlBtcEtEcEt0d1pPY01qYkIvYlEzNGVjR3dMRjVv?=
 =?utf-8?B?WHplZVd3MmN5WC81cVp6c1MwdjBOZURpMnhKckZrSWx3ZkxlMDloOWEzVkxh?=
 =?utf-8?B?d3BRTER6K3IxeDUrbTM3Vkc3cTA1RUM5V3c2VURVbVRLbFJ1NUthK0JsdW9V?=
 =?utf-8?B?clF6QjdVT0I2ZmJGMElLOXNJN25pZWk3b1JSdnBUdGFGL094OUcrVUdmMXBJ?=
 =?utf-8?B?Znc0azAwK3IydFhGMGE2TTZVTmluNGlkTWhhOHNiT2dkU0FsZS9vYjExOHBz?=
 =?utf-8?Q?x5vBJFTm5VfKsZ48UKP2s3yFk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd5aaeb-fe4f-42e2-2172-08dc6d749a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 02:31:15.6115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZCAqPB/7fxE+bvY2iRRb+7YLkrVn1qfeflPrcQLSOsJARwVkA3C2KN9PPLTU/hSiJI6Y30KeUo+CejwUUqS+iK0faR+B2sx52xVOzO9RJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211

PiBPbiAwMi4wNS4yNCAwMDoyNiwgRW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+IFBhbG1l
ciBEYWJiZWx0IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMDIgQXByIDIwMjQgMjM6MDk6MDIgUERUICgt
MDcwMCksIGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20gd3JvdGU6DQo+ID4gPiBBZGQgc3VwcG9y
dCBmb3IgU3RhckZpdmUgSkg3MTEwIFNvQyBhbmQgVmlzaW9uRml2ZSAyIGJvYXJkLg0KPiA+ID4g
LSBDbG9jayAmIHJlc2V0DQo+ID4gPiAtIENhY2hlDQo+ID4gPiAtIFRlbXBlcmF0dXJlIHNlbnNv
cg0KPiA+ID4gLSBQTUlDIChBWFAxNTA2MCkNCj4gPiA+IC0gUmVzdGFydCBHUElPDQo+ID4gPiAt
IFJORw0KPiA+ID4gLSBJMkMNCj4gPiA+IC0gU1BJDQo+ID4gPiAtIFF1YWQgU1BJDQo+ID4gPiAt
IFVTQiAmIFVTQiAyLjAgUEhZICYgUENJZSAyLjAvVVNCIDMuMCBQSFkNCj4gPiA+IC0gQXVkaW8g
KEkyUyAvIFRETSAvIFBXTS1EQUMpDQo+ID4gPiAtIENhbWVyYSBTdWJzeXN0ZW0gJiBNSVBJLUNT
STIgUlggJiBELVBIWSBSWA0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhbCBGZW5nIDxo
YWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gSGksDQo+
ID4gPg0KPiA+ID4gQXMgbW9yZSBkcml2ZXJzIG9mIFN0YXJGaXZlIEpINzExMCBWaXNpb25GaXZl
IDIgYm9hcmQgYXJlIHVwc3RyZWFtLA0KPiA+ID4gYWRkIHN1cHBvcnQgZm9yIHRoZW0gaW4gcmlz
Y3YgZGVmY29uZmlnLg0KPiA+ID4NCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IEhhbA0KPiA+
ID4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcgfCAzMiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAz
MiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvY29u
Zmlncy9kZWZjb25maWcNCj4gPiA+IGIvYXJjaC9yaXNjdi9jb25maWdzL2RlZmNvbmZpZyBpbmRl
eCBmYzBlYzJlZTEzYmMuLmE0ZWI2NmIzMGQ5NQ0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9h
cmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2NvbmZp
Z3MvZGVmY29uZmlnDQo+ID4gPiBAQCAtMTExLDYgKzExMSw3IEBAIENPTkZJR19QQ0lFX1hJTElO
WD15ICBDT05GSUdfUENJRV9GVTc0MD15DQo+ID4gPiBDT05GSUdfREVWVE1QRlM9eSAgQ09ORklH
X0RFVlRNUEZTX01PVU5UPXkNCj4gPiA+ICtDT05GSUdfU0lGSVZFX0NDQUNIRT15DQo+ID4gPiAg
Q09ORklHX01URD15DQo+ID4gPiAgQ09ORklHX01URF9CTE9DSz15DQo+ID4gPiAgQ09ORklHX01U
RF9DRkk9eQ0KPiA+ID4gQEAgLTE1NCwyNCArMTU1LDM2IEBAIENPTkZJR19TRVJJQUxfRUFSTFlD
T05fUklTQ1ZfU0JJPXkNCj4gPiA+ICBDT05GSUdfVklSVElPX0NPTlNPTEU9eQ0KPiA+ID4gIENP
TkZJR19IV19SQU5ET009eQ0KPiA+ID4gIENPTkZJR19IV19SQU5ET01fVklSVElPPXkNCj4gPiA+
ICtDT05GSUdfSFdfUkFORE9NX0pINzExMD1tDQo+ID4gPiArQ09ORklHX0kyQz15DQo+ID4gPiAg
Q09ORklHX0kyQ19DSEFSREVWPW0NCj4gPiA+ICtDT05GSUdfSTJDX0RFU0lHTldBUkVfUExBVEZP
Uk09eQ0KPiA+ID4gIENPTkZJR19JMkNfTVY2NFhYWD1tDQo+ID4gPiAgQ09ORklHX0kyQ19SSUlD
PXkNCj4gPiA+ICBDT05GSUdfU1BJPXkNCj4gPiA+ICtDT05GSUdfU1BJX0NBREVOQ0VfUVVBRFNQ
ST1tDQo+ID4gPiArQ09ORklHX1NQSV9QTDAyMj1tDQo+ID4gPiAgQ09ORklHX1NQSV9SU1BJPW0N
Cj4gPiA+ICBDT05GSUdfU1BJX1NJRklWRT15DQo+ID4gPiAgQ09ORklHX1NQSV9TVU42ST15DQo+
ID4gPiAgIyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0sgaXMgbm90IHNldA0KPiA+ID4gIENPTkZJR19H
UElPX1NJRklWRT15DQo+ID4gPiArQ09ORklHX1BPV0VSX1JFU0VUX0dQSU9fUkVTVEFSVD15DQo+
ID4gPiArQ09ORklHX1NFTlNPUlNfU0ZDVEVNUD15DQo+IA0KPiBJZiB0aGlzIG5lZWRzIGFuIHVw
ZGF0ZSBhbnl3YXkgdGhpcyB0ZW1wZXJhdHVyZSBzZW5zb3Igc2hvdWxkbid0IGJlIGNyaXRpY2Fs
IHRvDQo+IGJvb3QgYW5kIGNhbiBiZSBsZWZ0IGFzIGEgbW9kdWxlLg0KDQpPSywgSSB3aWxsIG1v
ZGlmeSBhY2NvcmRpbmdseSBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBUaGFua3MuDQoNCkJlc3QgcmVn
YXJkcywNCkhhbA0K

