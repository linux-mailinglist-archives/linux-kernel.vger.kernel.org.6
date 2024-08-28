Return-Path: <linux-kernel+bounces-305045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36517962898
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E358B20D17
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE2187FE5;
	Wed, 28 Aug 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b="lfpQ5JHl"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2101.outbound.protection.outlook.com [40.107.249.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7516BE1B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851613; cv=fail; b=sy8kKYizsb3X6jWE7YZewIAE+kLAlTpAQhoO+NE7lYTcHNhhN98cBASju8y290PShf7bJj2CBfh1VunUtu39T6HbGwZd4LjFXKPctBZwe7m50Uv3vNiMUHU/doFETcS04safMAacH9j1997eWzHhfVMa7J7VELj0nVEMjN5+JgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851613; c=relaxed/simple;
	bh=7AKiAtqgtzCb57+kxBMVPMsU1IRbONtSkx9Bt1GnzOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qh7ZayZVvaDeFN0BvJwtFVjjlYlC/kl0+7pXXiUxKYan4Wkmjkh3qMzZw1WvyBiA0SEai+vJNCfUm87xSfIbBf1thIVIq69+SKMp6HRglpEgQJh/uGFKROralsLrj7eYHW4FobJ9P8KrXP4SCFVTZ0pMILR21BMn9mre11ZJe1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com; spf=pass smtp.mailfrom=lenze.com; dkim=pass (2048-bit key) header.d=lenze.com header.i=@lenze.com header.b=lfpQ5JHl; arc=fail smtp.client-ip=40.107.249.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lenze.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenze.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVc0uoXiNbSn9DopCUZYRiU5tqNYReCNtxqOPzO2CT7Gcoz+7HjaovQ+J/i6z4eZC+nlPk+E0KKlpy2oO7dprCt2oh63QZZD7oD10UVpHvP0NN5ck/6FyWo/6Sd1VffjMs7Ap8Rp15Rs82caw46VDHzlFv7/RSMRGE92hMhgSye+KF7E5i9//cH0kYtv2GKMOj65A9qCLJrYbVKZ2zmchwpl1NeNKVwtEZ0dpHyTwEbL/RmY3VZU20nWzuqZM5831xu15RXUC/N/XIEX53IHnhy7ENMvc13r+gYaKNyBgHCfkY+yGQW8MX1bJtrI4nvmzZrAOtNQ3Fxea/tGke+A1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AKiAtqgtzCb57+kxBMVPMsU1IRbONtSkx9Bt1GnzOw=;
 b=yj8ukZsoPU+UNkK+BXnqZnGdsRGDQHJ6NXz7QRKallzlEKBH7o8cSNyHsubsIbu/gld0OXT7AWhhYeQp5r5kFtbDp8dv76jI+yzj9nAev7Xy+Gtd3o7qr55ejsVliYUlL7CMOULhQpTmrYfLhpSd1LUwraX4J3B54CyWBfV97o90fz8wucfbixjbK/160dIEVhZdo2iyLUJX6PM1NoIuTsfu7sU1EBxsAmUYt4NtF7704VODI5q0uyzfW2Hs9x70a5rU9lmqtX/yAQn/fCBPDJXOSthpck8OBiSxKJWRAVlClhAefcwz/VvMYHpjtZE9nSjJhHzXhk4Fqi2lgbLbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenze.com; dmarc=pass action=none header.from=lenze.com;
 dkim=pass header.d=lenze.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenze.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AKiAtqgtzCb57+kxBMVPMsU1IRbONtSkx9Bt1GnzOw=;
 b=lfpQ5JHlnRO/e9RQLZemtuZfJYLHh9LAQbZwI3RU6QOtlD+9yUL1EAZl9Gx3C7TkfsLIwZVDMbh4a52dAD3/AH+O3lU3EE6tcGe+mWXFVBTHafmb5cB1sfrwkSpHXdt9z+qU5NqYrxmXE7r3P5JigwdvCdmJModJ8fsRH/5fDldkG8bHuNNzjzDXRlq/GcEUx1Nz1hY6OrEUhDV/sxJ/r5DkZwx4LzUsJMRm7w4x1H9fbfpDgovZ8l87CXtE/mWK63V3XAJPVrrpj+z1edvKptdIJPeKWbZw74s2oz33kmY8ob6scoc2LvgZXNSPiSZS5I0q5jpVUBXOBMuJPC46Zw==
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:162::23)
 by VI1P194MB0686.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 13:26:42 +0000
Received: from DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5491:d30f:43f:4123]) by DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
 ([fe80::5491:d30f:43f:4123%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 13:26:42 +0000
From: "Brandt, Oliver - Lenze" <oliver.brandt@lenze.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Thread-Topic: [PATCH] irq_work: Avoid unnecessary "IRQ work" interrupts
Thread-Index: AQHa+JgsDXr6phuOQ0i6GwOBiXtqZrI8ao+AgAAEvICAADtagA==
Date: Wed, 28 Aug 2024 13:26:42 +0000
Message-ID: <1dc4fa0a48b05e14a1ae2a751441ba021ecee286.camel@lenze.com>
References: <25833c44051f02ea2fd95309652628e2b1607a1e.camel@lenze.com>
	 <20240828093719.3KJWbR6Y@linutronix.de>
	 <20240828095415.43iwHYdM@linutronix.de>
In-Reply-To: <20240828095415.43iwHYdM@linutronix.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenze.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P194MB0806:EE_|VI1P194MB0686:EE_
x-ms-office365-filtering-correlation-id: 4e47fa16-98d5-4e29-4c94-08dcc7650e3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anF0aTAyd1JzNzdFMkhuSU15b1NTQmVNOTRQRHJRc1BUSHVVVmdHMEoxSUxM?=
 =?utf-8?B?M3JVMmlHeVJWb0FYdnBraGdaMGN3VllUR0FrVnNZYzVZRERQSmxjNUNjazdO?=
 =?utf-8?B?SUF1RkZycVZvbHdjakd6U2tmQ2NyRnNVNEEvNndxbGpXcW51ZDV0MXBWSmhx?=
 =?utf-8?B?UTJjcjROc1lRU0JpVE1NNHR5enBkOHhoTFJSdU5adVo0SWpQZzBkMitFQ3pR?=
 =?utf-8?B?SVN5KzA0VHl6Y2FmK3ZvYmFRMWNRSS8vN00zTWFicWdyQ2dzM3pIeEU4cFZl?=
 =?utf-8?B?dmJ5SnM4ZEo2RUQyOGJqVXpKYlhZWE9ick9hMWxLQ2R3aWNtazhoT1dpRkNB?=
 =?utf-8?B?ZTY0QitBN0U3TlRsZmFlazZUc2tFNWo0aEliWXRiYUh0NGR4NS9hR1lFZDE5?=
 =?utf-8?B?TWtoN1orTTVTTlNWczBYN1NyR2VGZWNMSW44OGZqSFhwYmx6SitSYlNzd25C?=
 =?utf-8?B?MC9iRVR2RGNwNzRiT01vR2JaL3FMNlN4RVNFUWVpTVN1V3ovZ2kyaWhBZC93?=
 =?utf-8?B?dXo3c1M0Q3VzRXBySjZtbTdYYmk2K3hKOHhvWlIxVytNWHgzNExrNWpWUEln?=
 =?utf-8?B?NFNVTWJRTWFpUk1GNkNUQUlrRS9GY3Z0RzVMbC9OcU1HR1EvTDBweXJvNEYv?=
 =?utf-8?B?MGIyVW9lejhBMUczRDFDeEEyL2dLNjA1Mm9WNm9Ha05ZeHZnbVhuVXJYdE40?=
 =?utf-8?B?T3ZubVdaWTFidE53RVYzUFBGTmpKQ1lteW5vYU82ZURhSE9BU2FodzMxelBC?=
 =?utf-8?B?TzF2MEhjS0JlYVhURGpVbng1Vzl4NnZXeGVSaHVGa3Q1V2xQVnFHdU4rYmRV?=
 =?utf-8?B?R2d1RVdiRDU0RDVyQ0JITFdyT0NqWU5haWV3VkVWaXBqSmRCUk05b0dHdFox?=
 =?utf-8?B?dG9rRzl4MXB5cW9pMy9FM2krYjdkcUJON2UrNVRBVlpjYmc1dnh4Sm5CaEV3?=
 =?utf-8?B?S2tNWHhNaUNHeVF0QlZDRHJNQzlWTmxzVk1TKytYUnVXamozaGQxRjFiM2lw?=
 =?utf-8?B?ck5uZzFXcVBCTy9FaE5raklDa0dpRE8reVkxWUZvOTVMTGZWc2pCcjhMTEl0?=
 =?utf-8?B?MDQ5RVA2K3JEMnk2NTg1NmhpVldtclNFUllhSlRjd1lQRWtGQlhDczdiSGRo?=
 =?utf-8?B?WCtsdzIwTWZhSUxtM2wzaTFveVVNVDJmdjZwNlFKWGc3SEp2NGZlTEhMMjEy?=
 =?utf-8?B?eG5tYytkRytpaVVYY3l6SlVSSXE4VklYNEdMYWpHcFc1RjljMGZTNWFqeStn?=
 =?utf-8?B?ckFpU2ppNjVzbjRqZGtoRmRTNzJuVk1EYUIyN29VWVpyLy9BcDA3YmVpMk0y?=
 =?utf-8?B?bFBucTVwVU9IN1BJNTcwYzJUbE9ZQkJXeGhXbWp1K0xIWHlhWEl1TWdFR3Js?=
 =?utf-8?B?aGdIdC9pNXdlVnpETUdTRHpPVWRta0I2VXNhdDJDZU5PSVkweXlmNCtldEVG?=
 =?utf-8?B?NUxONFdUZjdIWkkzaWZRTDduQXp3YzJtRFh3T3BCZCtCLzEybTF4VlB4L0Fz?=
 =?utf-8?B?L2Y0KzRTUm45S054enZaR3VKb2tSbzBUbUJxeTJxZUx2dUFlZzBteWl4TWxH?=
 =?utf-8?B?M3lSMWowTjlWYS9lSzlaeHpZeXduM0xLU0NscUtrL3BzUWhLYUVwOWQyamIw?=
 =?utf-8?B?elJkYlRtRmhROGdubVZqdExibVdteDhpQzQzTTRMMDdFT05RTGFFWm9FdEp1?=
 =?utf-8?B?anhvUVRMU3RSa21NQkE4NXFWT3ZIV3lPdE9LZTR4NUdIWFhkWDZLS3NkUk84?=
 =?utf-8?B?SUd6ZGR5Sm5aT21tbmJYRkt1cVhEUUo3NDN4Nmk5MG04aHI1ZmE4eGRIWFpR?=
 =?utf-8?B?QzFSVzU3TVcrQUtjbWltOWFoRngvRHRucFN0dEthUW84V0h3bDNjSENXaEZy?=
 =?utf-8?B?clhrb3huZFArWld1WEhDQXFmM3BJT1dUTUJ6czlIOWNCeEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P194MB0806.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXlZdnRRZXhOV2VtdTBlR3BzQ3ZvRGU4d2VqK2YwT2tWZ0tVMitPbmN0cXRC?=
 =?utf-8?B?Uk5GNUtHMVFQNjVOcjFqM1ZGZjhodFd0YzgzQlpydEFaTDNIT2NiWURIMExp?=
 =?utf-8?B?NlAvQldWUHlzeUJWVWJEUVQ3UTRLR3B6WEJ1WUtOdG1iQ0ZJOVp2QWVNYkxk?=
 =?utf-8?B?eVRGMi90SHI5ZWVWa0lxV3JtUzZJMHFuYzkyb0VMbW9rVFN3MCtxMzdJcHhH?=
 =?utf-8?B?ZituQTJaclJTVlNnSHlzTlVpQmI0NmxRUWtKVXpVZHVWbEZueFY0dXBWSSt2?=
 =?utf-8?B?OGxLdDhJOEpsM1RBNWpUYkgvVDk4enR2NUlCUFRIYk9nZzFNRGR1eCs3ckhJ?=
 =?utf-8?B?VHMyV0JIUXFpQnhRSFpoaG1sbW8xdG96Um1UREZEY3E2aEUrYWQ0TTkzTW1h?=
 =?utf-8?B?UEpNSlN4SWp3ZXAvWUwzRE9CNjVBa05BVURIWTk5U2ZNZ2I3SllhRjF2OXht?=
 =?utf-8?B?YmZEOXNYU051UnZPOXFmTzhMY2drQWVoS0Y1TGhtSllLWW1zTWtoK0RycjJL?=
 =?utf-8?B?cmhEWGdGMC9qN0dVMllCQTFadHVEelpYSUZmWmVOblRTRkJrY1R3Z09qN3N1?=
 =?utf-8?B?dWxBeER3OGJrNlVnVUhvclN6ZmJCRUh6c2xXNE1yKzBlT0lEREFsUldFOTNz?=
 =?utf-8?B?eXB3WGEvMGp2RG4xazYwMGx4UG9Bd1MxVWtiMW1MWHY4N3NiVTZCSlR3Z1lP?=
 =?utf-8?B?TC9jMWxYUjh3QWlPdzAwY0QycmtYZHhNaGMzYjgzRjRXVk9IaEgxT1pQdHFL?=
 =?utf-8?B?NEk1QzlvT0dUNXQ5Tjh3a1E3aFJlbDVZQjBUWjREUTZFS25VQjBkTGs3V0Fi?=
 =?utf-8?B?alBQZHlLSkZ2a09jTjQ1Q3dxenpnbUpiUEJmeTJ1dHVWaVRwckpDSTBNWjl4?=
 =?utf-8?B?VWcra0oxdWNSRjJoc0xzeDVKVHhMSVNtVWZtcCtmYk8yTlovWnhkcjZHSS83?=
 =?utf-8?B?ZlE0T0F6Y3NzelNrdXhUZjlzcGswWXY1Qzk3cTFITkJtcVpORkQzc0ViL3FJ?=
 =?utf-8?B?eVQ1QjhtcUdjTUFMNjdCNHMyRmd3d3VaUWk4MFlENitiZTNxTGlQOEhrY2Fo?=
 =?utf-8?B?THBFcEhTWXFxdHU0QXc3Z0Z3R1QzMksxc3FrbGlvRmRjeU5rQTI1c29VMCtO?=
 =?utf-8?B?QVRNWVVYSzlabnpPaUI1WXg4aFk4WHhzRkRlSDBGK0hKemhUTzAvMEtvWGtq?=
 =?utf-8?B?RVJJUndud040TVFaWlhsUFZlQzRTTWZpQURpSVJqNjF6bG9qQ3pLNU9kZ2VN?=
 =?utf-8?B?Wlc5RW1UUllxblRYcC84YkFaaGdUVlkweVV5Z0hIQUxSR2FRbE5FaU1KMW1M?=
 =?utf-8?B?czgvV2J4OHhEVFJ0M1Erc2FLVUlQelRNQXZ3T3JzYU1jTHhzQ05ucy9tajgx?=
 =?utf-8?B?NG5jMjZ0eXM3SE0zSzAzS2pINnhwL3owMjVqL1hPZnErOVlrcFNINWZsL3hQ?=
 =?utf-8?B?d0k4SWo4Vi9adHg0b1dWL1Fab1pvdU5Oamc5L1FWcktKN2lkZDRyN0Z3UUxC?=
 =?utf-8?B?cnJWWDA0U0JUY2JyK0x5VExaeXJtVUVOdDlnNlkyYldFQUgySUx4cVBUbmtO?=
 =?utf-8?B?U0ZNOU9UMWh6NTFzZHVTa3NMNnFEMU9VSnYzelhKWVRHaTczOUs3bGczWWdU?=
 =?utf-8?B?Y0RLS0Z2NWlaSXdjVmhPWEVoTDdjeTErTUN3SVlUZW1hL083OUFIdTcrMDlB?=
 =?utf-8?B?aXFYdDVVN2M3eVhPMGNzTG5jUFVuYjFKa0VKU2RvcGFZSExiUzI1b0VxQ01E?=
 =?utf-8?B?d09TbHZqYkJ3UklHclFmd1d0dUhYMENYeER0eHNDeEZwaldMdUthT0s2aDM4?=
 =?utf-8?B?Z3VxSUxIN3ZOSjdodURIV3o5Y00zNjdZM284OVVrN3BTVjNqK3gyaW5hN1VP?=
 =?utf-8?B?YlFhLzNwSWoveTBvYm5tT0xLZG51VElIZko2TkJsZm1aR0VXNHAzcmtRU2I5?=
 =?utf-8?B?QnZaekZ5OVJJRnI0TW9RTEJxSFRNOERNRnJtTUYxalFkekwySGVDaytvTW8w?=
 =?utf-8?B?OURxZURBWlA1Ry9DdHl2Ujd4Nkg2dDRKMkJQVC9CMjV6Y0pIemRWOGhXcjBp?=
 =?utf-8?B?ZUpTSTdFV0krL3NSZmYxcGNzamhWWjA1Zzd0MEsxL1ArLzVFeFB3OXB3MXJi?=
 =?utf-8?Q?8EuXIlg7l6jpqWhrOChljwlS1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <444BCC92F5EE7542A581BEC20D0343A9@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lenze.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P194MB0806.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e47fa16-98d5-4e29-4c94-08dcc7650e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 13:26:42.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 37cf0ce8-ac09-4e7d-9ff2-f1da44914b3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIcN/B89RU8T+i5BdtT5iDNYQzDXNhjt2JzKrfquzvuW4E/ARIZgruYu82+BSb2h/Gwvd6geg6dl9gjT/Mxa2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P194MB0686

T24gV2VkLCAyMDI0LTA4LTI4IGF0IDExOjU0ICswMjAwLCBTZWJhc3RpYW4gQW5kcnplaiBTaWV3
aW9yIHdyb3RlOg0KPiBPbiAyMDI0LTA4LTI4IDExOjM3OjIwIFsrMDIwMF0sIFRvIEJyYW5kdCwg
T2xpdmVyIC0gTGVuemUgd3JvdGU6DQo+ID4gPiBGaXhlczogYjRjNmY4NmVjMmY2ICgnaXJxX3dv
cms6IEhhbmRsZSBzb21lIGlycV93b3JrIGluIGEgcGVyLUNQVSB0aHJlYWQgb24gUFJFRU1QVF9S
VCcpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBPbGl2ZXIgQnJhbmR0IDxvbGl2ZXIuYnJhbmR0QGxl
bnplLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGtlcm5lbC9pcnFfd29yay5jIHwgMiArLQ0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4g
DQo+ID4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2lycV93b3JrLmMgYi9rZXJuZWwvaXJxX3dvcmsu
Yw0KPiA+ID4gaW5kZXggMmY0ZmIzMzZkZGExLi5kZjA4YjdkZGU3ZDUgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9rZXJuZWwvaXJxX3dvcmsuYw0KPiA+ID4gKysrIGIva2VybmVsL2lycV93b3JrLmMNCj4g
PiA+IEBAIC0xMDgsNyArMTA4LDcgQEAgc3RhdGljIHZvaWQgX19pcnFfd29ya19xdWV1ZV9sb2Nh
bChzdHJ1Y3QgaXJxX3dvcmsgKndvcmspDQo+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiA+ID4gDQo+ID4gPiAgICAgICAgIC8qIElmIHRoZSB3b3JrIGlzICJsYXp5IiwgaGFuZGxlIGl0
IGZyb20gbmV4dCB0aWNrIGlmIGFueSAqLw0KPiA+ID4gLSAgICAgICBpZiAoIWxhenlfd29yayB8
fCB0aWNrX25vaHpfdGlja19zdG9wcGVkKCkpDQo+ID4gPiArICAgICAgIGlmICghKGxhenlfd29y
ayB8fCBydF9sYXp5X3dvcmspIHx8IHRpY2tfbm9oel90aWNrX3N0b3BwZWQoKSkNCj4gPiA+ICAg
ICAgICAgICAgICAgICBpcnFfd29ya19yYWlzZSh3b3JrKTsNCj4gPiANCj4gPiBMb29raW5nIGF0
IHRoaXMgSSAqdGhpbmsqIHJ0X2xhenlfd29yayB3YXMgbmVlZGVkIGVhcmxpZXIgZHVlIHRvDQo+
ID4gZGlmZmVyZW50IGNvZGUgYnV0IG5vdCBhbnltb3JlLiBDb3VsZG4ndCB5b3UganVzdCByZW1v
dmUgcnRfbGF6eV93b3JrDQo+ID4gYW5kIHNldCBsYXp5X3dvcmsgaW4gdGhlIFJUIHBhdGg/IFRo
YXQgc2hvdWxkIHdvcmsuDQo+IA0KPiBBY3R1YWxseSBuby4gSWYgd2UgbWVyZ2UgcnRfbGF6eV93
b3JrIGludG8gbGF6eV93b3JrIHRoZW4gd2Ugd291bGQgaGF2ZQ0KPiB0aGUgYmVoYXZpb3VyIHlv
dSBoYXZlIGhlcmUuIEJ1dCB3ZSBuZWVkIGlycV93b3JrX3JhaXNlKCkgaW4gb3JkZXIgdG8NCj4g
ICAgICAgICBpcnFfd29ya19ydW4oKTsNCj4gICAgICAgICAtPiB3YWtlX2lycV93b3JrZCgpOw0K
PiAgICAgICAgICAgLT4gd2FrZV91cF9wcm9jZXNzKGlycV93b3JrZCk7DQo+IA0KPiBJZiB3ZSBk
b24ndCBpcnFfd29ya19yYWlzZSgpIGhlcmUgdGhlbiBpdCB3aWxsIGJlIGRlbGF5ZWQgdW50aWwg
dGhlIG5leHQNCj4gdGljayBhbmQgd2UgZGlkbid0IHdhbnQgdGhhdCBpZiBteSBtZW1vcnkgc2Vy
dmVzIG1lLg0KDQpIbW0uLi4uIEkgc2VlLiBXaGF0IGFib3V0IGNhbGxpbmcgd2FrZV9pcnFfd29y
a2QoKSBkaXJlY3RseTsgc29tZXRoaW5nDQpsaWtlDQoNCiAgICAgICAgaWYgKHJ0X2xhenlfd29y
aykNCiAgICAgICAgICAgICAgICB3YWtlX2lycV93b3JrZCgpOw0KICAgICAgICBlbHNlIGlmICgh
bGF6eV93b3JrIHx8IHRpY2tfbm9oel90aWNrX3N0b3BwZWQoKSkNCiAgICAgICAgICAgICAgICBp
cnFfd29ya19yYWlzZSh3b3JrKTsNCg0KPiANCj4gU2ViYXN0aWFuDQoNClJlZ2FyZHMsDQpPbGl2
ZXINCg==

