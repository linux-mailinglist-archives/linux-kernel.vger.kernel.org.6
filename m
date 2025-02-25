Return-Path: <linux-kernel+bounces-531261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25FA43E41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CFA42096E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E701620B21B;
	Tue, 25 Feb 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="vSZE9sBb"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0B91E1C2B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484150; cv=fail; b=urJg8p86LSw5T410Mv1C4JTnekbOP7I8vdpaQ5lcWh2RVO2Rwashs3oP+oj3WY+slRxj6onABPf47inf4xR/ECed3FDCoY2p5qqdgDUd+sduHZm/ulxJLnw8tuvvsghKFvLCuZwR4ZYsGRzrsrEnXHM8Ux9wS82zo/j8xQGYiOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484150; c=relaxed/simple;
	bh=GqKRUPbCvosD6Buv/Jwv7k6DysCk+DqrnGTnc7hWAC0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fZolby6QqvwyuHj9I6dV5CCoXfYjaSlFbu9IDwFP6xzUB7GoK10wtmzvZWNXLNrWHJ4WsuWWBqwQ97SCsC2OZJgp77EZqmQQVxlX8mJsBPZLta2rU2kROAyaHWiYmZG56GbU7/CYC4d1AO6Hj3NPlti+5GTz7nFtl8uVSCcZ2To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=vSZE9sBb; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/c7Ws344HoN1JKzFj192vy1dpkm9ZYaHvkj2l+w6EqcahuOgTxJLueSB0QZYjmOltXNRh3AQBvcXgo4WthlVueuyWcRalqfGfuJO6OJ9581UuRWlnKiySu+utB40QrB4bdC1PHfZtsYPdT5YOjLO/NAdgnFTzzzPVrMP2VHJfXtvDYVhFnswNgEUMOsmJiRxfszDFkoyDYsXUgyFOguSdDNZHy+Eaz6uUk8t65qA8YMTzvqMKSGdlvUfTb9JrDTjZW2WwzygvDYOg6mwch5dsLHP9j+UhpM5sy3lyw3MmtMBHXKZowpDmE8L8ONvV8X9i2cwTRMo+1Muxt5053Vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqKRUPbCvosD6Buv/Jwv7k6DysCk+DqrnGTnc7hWAC0=;
 b=H0e6HLMzG5XMAVvk04KqZmwbMYl9gA5y9oET5yMQtT6xikI6iH9U5BdtaCUD/OBYHFpp+j83WcVrNLaCe1Qf0hSjfewK/ct4WtMPkrZKZVNWdFru/tAnkpwE6iRn/3t+VftVpH/fzm5+3W5wA0ns9KOHZBw38S8f+rDeH9X11pNnKNx4Ir+0CnezmFmyYMpKDCZKs4pcIzVnlStpMpMERVsGcqvYpBVYdLvE48M6RneGKuouaZrKS2H4kX5WKegY0DAx4bG8+F3LKfJ6aFIZXa42i3kCqHt3jh9I6wmHCATYlyaqy3XJlJuSGA5xap9hgvEfxzyw6PRpHApamGME6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqKRUPbCvosD6Buv/Jwv7k6DysCk+DqrnGTnc7hWAC0=;
 b=vSZE9sBbpooFxzs6ras8sGUFJEUHYRLrvQW7HU1sbhPAjnUXrJhDVBeGRuuqHTQWfxEOzdw+GUyCBF+xhcNIbk4VxOzpjYNSpLJOXgLg7aXJsFfKY+83xouX+0KZzhrHyPI4gaQ9WOS9zEQlg9/q888n9Ro2qDICrbpLY/yj4AUVNtvMWIaHihaj0RZ7wn0HrXm4MzCtu+DvTXzfXPZAy+0HujoiVaOKBGqoSU9XiEMIk4QV5GqlkbmScGkpk92qo7mxaolJLBcc2CThzwHXepVHiod9e8wehrGTKZ8wZWVdB7NEB3t5FP/rLe6ToFNztUthS4yKECxGjQBcRQ3ffA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9655.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 11:49:02 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 11:49:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>, Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Topic: [PATCH v5 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Index: AQHbh21jOPDlavrp2kW5T/JI6UK95bNX0p8AgAAAqJOAAAMMgIAAEVj2
Date: Tue, 25 Feb 2025 11:49:02 +0000
Message-ID:
 <PN3PR01MB959764DE7E98ECBDF07296C6B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <3457BF95-0E50-4B70-86DE-EE5EE95D3ACE@live.com>
 <4D7C00B4-7B75-4715-8D37-0059B22C030D@live.com>
 <Z72chunE_vvxtjLQ@smile.fi.intel.com>
 <PN3PR01MB9597BF95EC490951D75748F1B8C32@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z72foRL3diil9icd@smile.fi.intel.com>
In-Reply-To: <Z72foRL3diil9icd@smile.fi.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9655:EE_
x-ms-office365-filtering-correlation-id: b2ccd3cb-18af-4a34-2d97-08dd55926626
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|12121999004|19110799003|8060799006|461199028|6072599003|15080799006|7092599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?UHFqL2xCcUozSmd5S0tnRkgxbFNWRHdzc3Z0L2F5c0JZaEdQNDE3NTgycnNm?=
 =?utf-8?B?NEhPL1IvSU1qbnpnUm5zNjZVMkU1TVhNTUpocE1xWGpkaWI4S2p5bEVnaXh3?=
 =?utf-8?B?QXFaWEVjSmlNTkZTR1ZrZTF4YkljNlJkSVlFclZVRVJEQ0MzcDVsWEJoOHpE?=
 =?utf-8?B?QXJNblpBVXFnQStvMmYraFhKNVkyd1pUaVFoUnFxMVRXZU5JVzF2bDJRdHpl?=
 =?utf-8?B?STBXVytzZFJPTEIrMmx4SVcway9ZRVVETEhsYmFPRUMwSmQzYUh2QkxjTHlU?=
 =?utf-8?B?TW1rdDRtTE8yU2J5TzV1cDAvKzVuTVlZN2hRNThjNkN6RHJqMnpBZ1RoY0Rz?=
 =?utf-8?B?THExME0wQ2lsb09Wc0RDb3JFVVBManpOL2xRYWx3b3dUdGxkN3VMZ0dWYVpx?=
 =?utf-8?B?SnRuTUtCT0hMUzNvMkZ6RTRBeEFLcXRGa0RyNE1wemVadUIwQ3lMWUxLMS8z?=
 =?utf-8?B?QnpLZHk0cVhJcC9PeU81MnFDaURuNDlCQzJxT3BMRTNaRU9EUXlWZExSa1Zx?=
 =?utf-8?B?WC9tNDNCQjkySkw1RWRaVWtlcHhvOXBGK1k0QnluMjRIenEwdGRNeE0rYjls?=
 =?utf-8?B?amc3bXMxdXB0Y0dPNWtxM0h3TVk5UzZjcEREWmhmbFJGK0JVTmdtWWNKVHM3?=
 =?utf-8?B?TUs2MTBNQ0FRNHppczFuRUJMRnFZTjB2VlBKN0ZaVnA1ZEtjUjBsSDJITm1J?=
 =?utf-8?B?ak5wWksvd1M2dHRQVlU2NmMreGg4WXVFOFZpdWZUUnJyeXhRWVhjaDNYQzFs?=
 =?utf-8?B?ekU4TFV6UmhoTFlrVmw2dThoS1Fqb1p5MzdPcTRINER2VUFtcmlZYWh4SEhn?=
 =?utf-8?B?emEwd0VFWXQ5dWg3NTNZOW1FbnpjSTdROFJkaDFBUEMrVzF2bWxhK1dKUTM2?=
 =?utf-8?B?OUNhOC9VS3ZYTGlZRlo4QUp3Wm5pZUdKcnZzL0Q1RTNMN3hPVkpLWVdBWHNP?=
 =?utf-8?B?Nkl2czRGd3ZscEdXK2NMVTFuallpK0hQR0dCSVZ4aVFRKzd0YkJEQThvcUZL?=
 =?utf-8?B?OWNDZEh5WHBiWjF4NTFKTzl0WEcyK25RcXBIYmdTSG8xMUJmcUZpSDRPUDEx?=
 =?utf-8?B?R28vc28wMmU1WnJBSmpIUU0ydHIwZ0ZvOWJqQkgzZUJacGM4bWFiMnhRdk9k?=
 =?utf-8?B?Y20ya2tYQjU2NHFGSDd5MDVQVnZiZEl4RmllRjNXS21pQURDTlZuUy9GcnRF?=
 =?utf-8?B?Y2F0c3dKRHJUbTRxemt3cjBzM1R2Rklva0FkaHBUaE52VnYyRFhtUG9DNyty?=
 =?utf-8?B?RFluVjRSeUp6MlhqOEp5Zmg5a0FSSEYwelJNV3UxVDVMT3BseS9oSm5KUHAv?=
 =?utf-8?B?eWZxSzZkL3UvSmV5Lzg2d2s4ZG5zc0h1b243VEcvdlNoQ01sNStocDYzYmNI?=
 =?utf-8?B?cGQ1ZnVpZmxFWW1hYTBCWTc5S0RhYWVIekFTLzNaa2xVY2lZQ1RCREdxUFdv?=
 =?utf-8?B?QnVEeWY3VmZmRm5UU3Z3WDh6amlKUDVkNlBtN2JaTGQ5dnN1ZjlMNWxDYVRF?=
 =?utf-8?Q?jInbhKofsp+laf91Z9sB/wXbFgH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDFMdm9jYlJHL25DRVh4SnUwUjZOMUtjMnVZQldteHVJaXdnU0piVnlsM2Z3?=
 =?utf-8?B?aFZPbHJhLzMwMGZVRTZSUHBFWmZ2cUNXNFBuL1F5MWFqczZPQU9CU0NqKy8v?=
 =?utf-8?B?eE9hR2ZXUXJTQUEraXhxZjFQVE92dFkyeHFhc2Z6SS9jNDBwYkVLVVNaWU4v?=
 =?utf-8?B?Q3ZnMGJFcEN0NzZHTTExWHRpcjV0cHpWaGRVV3ZRdzlOOWlUc0lJVmdvVnlR?=
 =?utf-8?B?V25WM1JTeTc2M3VyaGN3MG5PcXpyK2UyTDUweHgyUnRrZFBwMTBmUEUzdVg4?=
 =?utf-8?B?RmxkamNpV1BVUkxvOUF2ekFRck5lZUhlbTNnemVMSWFobzg3S0ZnTjdManZ0?=
 =?utf-8?B?TWtpRUw2MkQyaE13R25hTE5uUTVBTmZVOTNtbUhKdGdWMnRzM25JL3N3UVli?=
 =?utf-8?B?K3A5d2kzSldRaXhGRW9WSUdWVlpVNEQ1WGY4TmJTOTFmMHNDMCtDb1NYbVZW?=
 =?utf-8?B?MUIraUJBUi9aKzJZb2ZuS1NlYStmMmExOUhxNHFJTWlmOGNEanRVaHV6ZUNj?=
 =?utf-8?B?dG5UQVFQRlc5dnMrbFMraDJNb0tDU2ZzaVJFU0dNMkNzQnNsUmZVWlpZS0ps?=
 =?utf-8?B?Zi9YaDdYdFROdUZMWk1yQ0Q3dWRNOEpwZTFqclJCdldKTUtTeS8rMndzc251?=
 =?utf-8?B?b1ZWSFJhN2hpS2Y1Tk1wcVJ0K3gxZThxRTBkMW16Umc3TEFQekE4cTN5YWNN?=
 =?utf-8?B?QnFqUVlldDEyc2VSamxLTXVCVjFTZW4vMm5xdGg0Y0VpTC83eG9teEVLN0N4?=
 =?utf-8?B?bUsra1h5RFgrK0didkk5OEhxMnpvNXJwL3hSUmtFdWdtSHR2UjdvbUdyR0RL?=
 =?utf-8?B?TnF3blRpcFlCQ0ZudDlFR1N2VTQwdEFySFVoN3NBcUxuM04zRVpucmpsdndF?=
 =?utf-8?B?VHd2dmN4THF2WWNua3FtRkx2RzBrdzZyMVdSTmlnY3MzVGhReW1ZRnVlUjYy?=
 =?utf-8?B?NEoyUHlDNXZLUUtSTlowOCsrVEZEclk5SFBFVjZZcU8rWGxhR1E0K2l6ZjRu?=
 =?utf-8?B?ZjdQelVWRDcwenA2R041eGZhcUtLcy9CMUxVdTk4Y0FQdWZPcGtDMitZYW5X?=
 =?utf-8?B?Ti9QcVk3YzgzdUVPcmU2RTFYYXVQNUxTdy80eGdnUThZNlhOZWZNLzAyMG44?=
 =?utf-8?B?NlZsZCtVU2xzZ3p5RjVkaUdKUkRaZ1JQL2JDaEJpb01jQytXSnJtUU5nY0dE?=
 =?utf-8?B?V0paL2NtT09PMWN5NWpFKytMNDRWaUJSZU1aWGZ5K205Q2hGVndDQlpMR2RD?=
 =?utf-8?B?dk12RGlCTjVkcXdOLzhqSkVDUUxrNjdacndtNFN5ZFpLM3BYSDdia2NtQVFL?=
 =?utf-8?B?ZlZheEVKYmIwK2NKK0JhS2U2bEZSSXdtRmZTK2dkQTRWSmtxc2ZkTTlZa1BH?=
 =?utf-8?B?Q1JSVTVXS3hhZUIrdmxGbitWcTN3L1diOE9ZckMrbElDbDVSQ1Q0ZmZXU3l3?=
 =?utf-8?B?eDR5WWlrNTlzeFJzZUx2Q0g5YWRFdThvdUNFUDZEd0F1WmNDc1dwWFRZcGZV?=
 =?utf-8?B?Wnh4Mmt0UjZCWUZsaFRqRHFZUU84VWNJKzBTTWNIYi8vWlYzNFlROVdRb3VY?=
 =?utf-8?B?bm5hcEp1enJIcnYxZGN0VzhxNlpmZmdRNG9obXp3TEk0Vk84UUVsQVIrbDd0?=
 =?utf-8?Q?8Ca6YJRUPul+F7VqyP81dvz++q6Loi04PXizALXPJooY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ccd3cb-18af-4a34-2d97-08dd55926626
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 11:49:02.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9655

DQoNCj4gT24gMjUgRmViIDIwMjUsIGF0IDQ6MTfigK9QTSwgYW5kcml5LnNoZXZjaGVua29AbGlu
dXguaW50ZWwuY29tIHdyb3RlOg0KPiANCj4g77u/T24gVHVlLCBGZWIgMjUsIDIwMjUgYXQgMTA6
MzY6MDNBTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4+IE9uIDI1IEZlYiAyMDI1LCBh
dCA0OjAz4oCvUE0sIGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbSB3cm90ZToNCj4+
PiBPbiBUdWUsIEZlYiAyNSwgMjAyNSBhdCAxMDowOTo0MkFNICswMDAwLCBBZGl0eWEgR2FyZyB3
cm90ZToNCj4gDQo+IC4uLg0KPiANCj4+Pj4gK3N0YXRpYyBpbnQgYXBwbGV0YmRybV9wcm9iZShz
dHJ1Y3QgdXNiX2ludGVyZmFjZSAqaW50ZiwNCj4+Pj4gKyAgICAgICAgICAgICAgICBjb25zdCBz
dHJ1Y3QgdXNiX2RldmljZV9pZCAqaWQpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgc3RydWN0IHVzYl9l
bmRwb2ludF9kZXNjcmlwdG9yICpidWxrX2luLCAqYnVsa19vdXQ7DQo+Pj4+ICsgICAgc3RydWN0
IGRldmljZSAqZGV2ID0gJmludGYtPmRldjsNCj4+Pj4gKyAgICBzdHJ1Y3QgYXBwbGV0YmRybV9k
ZXZpY2UgKmFkZXY7DQo+Pj4+ICsgICAgc3RydWN0IGRybV9kZXZpY2UgKmRybTsNCj4+Pj4gKyAg
ICBpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICsgICAgcmV0ID0gdXNiX2ZpbmRfY29tbW9uX2VuZHBv
aW50cyhpbnRmLT5jdXJfYWx0c2V0dGluZywgJmJ1bGtfaW4sICZidWxrX291dCwgTlVMTCwgTlVM
TCk7DQo+Pj4+ICsgICAgaWYgKHJldCkgew0KPj4+PiArICAgICAgICBkcm1fZXJyKGRybSwgIkZh
aWxlZCB0byBmaW5kIGJ1bGsgZW5kcG9pbnRzXG4iKTsNCj4+PiANCj4+PiBUaGlzIGlzIHNpbXBs
eSB3cm9uZyAoYW5kIGluIHRoaXMgY2FzZSBldmVuIGxlYWQgdG8gY3Jhc2ggaW4gc29tZSBjaXJj
dW1zdGFuY2VzKS4NCj4+PiBkcm1fZXJyKCkgbWF5IG5vdCBiZSB1c2VkIGhlcmUuIFRoYXQncyBt
eSBwb2ludCBpbiBwcmV2aW91cyBkaXNjdXNzaW9ucy4NCj4+PiBJbmRlcGVuZGVudGx5IG9uIHRo
ZSBzdWJzeXN0ZW0gdGhlIC0+cHJvYmUoKSBmb3IgdGhlIHNha2Ugb2YgY29uc2lzdGVuY3kgYW5k
DQo+Pj4gYmVpbmcgaW5mb3JtYXRpdmUgc2hvdWxkIG9ubHkgcmVseSBvbiBzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+PiANCj4+IEknbSBub3Qgc3VyZSBob3cgZHJtX2VyciB3b3JrcywNCj4gDQo+IEl0
J3MgYSBtYWNyby4NCj4gDQo+PiBidXQgc3RydWN0IGRybV9kZXZpY2UgZG9lcyBoYXZlIGEgc3Ry
dWN0IGRldmljZSAqZGV2IGFzIHdlbGwuDQo+IA0KPiBZZXMsIGJ1dCBvbmx5IHdoZW4gaXQncyBp
bml0aWFsaXplZC4NCg0KTG9va3MgbGlrZSBJIGluaXRpYWxpc2VkIGl0IGFmdGVyIHRoaXMgZXJy
b3Igc3RhdGVtZW50LiBZZWFoLCBpdCBhbiBlcnJvciBvbiBteSBwYXJ0LiBXaWxsIHdhaXQgZm9y
IG1vcmUgcmV2aWV3cyB0aWxsIHRvbW9ycm93IHRob3VnaC4NCj4gDQo+PiBBbnl3YXlzLCB0aGlz
IGlzIHNvbWV0aGluZyBJJ2xsIGxlYXZlIGZvciBUaG9tYXMgdG8gcmVwbHkuDQo+IA0KPiBUaGUg
Y29kZSBhYm92ZSBpcyB3cm9uZyBpbmRlcGVuZGVudGx5IG9uIGhpcyByZXBseSA6LSkNCj4gDQo+
IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQo+IA0K

