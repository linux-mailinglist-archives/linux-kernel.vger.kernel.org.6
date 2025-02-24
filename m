Return-Path: <linux-kernel+bounces-529538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19788A4278E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546517A774B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97AD2627F2;
	Mon, 24 Feb 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="g6REDzTC"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011024.outbound.protection.outlook.com [52.103.67.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13EF157A48
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413669; cv=fail; b=SBGvDfC4Ahm1bK5vAzHArraZVFki3dpm3NyOAAhJZQxJX/mpIdZgb1PRgJrA0VjYhs3u9W5vCKqqZJw4C4stPDZdzj+2rS9NGOoA5wEDHRoj5te+A+vaKK1wGyjikSt9hrIQKZSzK5MjPm7AJya7uCkT1reWFqilxMcNY9CMY2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413669; c=relaxed/simple;
	bh=mt0GZdYhsVcsQRotMgpOv7UQtXm+MtOICmSkPGiOs+8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=exHH+6oYCCrNQPvxVwHsG+Yf7qDbx3ykq8NPlXWW9TskgRcW4Ov3sclk3XgP6yEzcoY5E3zOwLzGd8lG6eZYhI6OEk96mZJ+ltaHj5rqDULYlXwwBh9q0Q3cok06fhSv4PxBC3Ag0FWfO0QspOpbnT4wcDda1TNBDvkfYbQrQEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=g6REDzTC; arc=fail smtp.client-ip=52.103.67.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an0IYW6Cfn+U5d3eAYp7P8rkv6iCtv6UTToVFM97AVuGlXmDj6FXuqxxvf/vQ9AxOxpZOL33Q5F8nT/s4Y1461r6ExHuQozQuDa74jCof7Zh0u5kEfNvipz0qz5TMo6raddfRHDaT7rfxhot+a/EAa9eVZNcxWstE3UmHZ0Nws0sIfE2K/DKtSyqEuHHxRwQD8ZARapa/fFAS4i9gHxXJZJPvRlLDLYy0b23BeuqtpVlIwyzwb0MJQY6DKWHteadtUHtTDNl+DwY/IlveVWQ10UWF60BI86m6/Z5g7Ii+EVvQfzeqSeWaq/GsKSNRDrMufPVR7xS3C/cfBaezIPt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt0GZdYhsVcsQRotMgpOv7UQtXm+MtOICmSkPGiOs+8=;
 b=AFYXR7T9PpApNuF5p5tjTVbYMKr8rqqX2SvV76MLHUBQHLlVpiY/Md+nOw7RwC/ZBrOllBP34aHcIfS0hvrLMJSiFi+XM6GhzfAPJawkQWRh4XFm8SEjLVFhgf/qaklqkfQcs8GLLv9i3PpIR45aDgoGvExWKiwyCMTS6ZcelixM60DKJgN7sDAwVYwfjlBtbf2OwANyQ2y8syGrYHz+9Paqxw8Vahbn+V+DZrTekOhQX4h0YhruqV56wyblXAZhWB4+ND3PLILjRN4xh3SSLlz3ipM0IsFudjnNidaQo9ydz1DBi21YQxFw1CMTfZ1Y7t56PVXPpz7yUrC3Fvc98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt0GZdYhsVcsQRotMgpOv7UQtXm+MtOICmSkPGiOs+8=;
 b=g6REDzTCVCBVco+4pOMPwdl9X2HJceaW5Q0jCztr1EjLKYZGLYOZoMNS20dpxIdbMc4SWwDRa6L0jWKsR/9hTSK+SIh0+uE6PB7Kb9uKzggF55Ee2GVJmJ1pA1x6jn4IcegsF8thCHESXhhWvzOchHppUpey/wtls6J7rNIAbD1Sf4hkd6Zl9/MqfOw9bLiESQ9zHLKY61ZzAttGdNNBYXu01mjKoB5BS7rDmcHE2cVhFDs9SfZ9f2l95CfrYUYnnj9fFDi0xMSRw4Hu04uL77pOnNH8XA5c2qZqj+S113qW0rYa5EkY4V/ZOxCc9H07dtFTbc/EL+NdgmDVazc4OQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7094.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 16:14:22 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:14:21 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, Kerem Karabay <kekrby@gmail.com>,
	Atharva Tiwari <evepolonium@gmail.com>, Aun-Ali Zaidi <admin@kodeit.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Topic: [PATCH v4 2/2] drm/tiny: add driver for Apple Touch Bars in x86
 Macs
Thread-Index:
 AQHbhsGm46fWR/3mxEipqc6+PMbxkrNWe38AgAAI1YCAAAcMAIAAAaKAgAACOwCAAAJQAIAAA7BUgAABjYCAAACPR4AAA3gAgAABCXSAAAT2XQ==
Date: Mon, 24 Feb 2025 16:14:21 +0000
Message-ID:
 <PN3PR01MB9597922FEF631E75EC0F0CE6B8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <Z7yMIC1wxm0AGBCt@smile.fi.intel.com>
 <PN3PR01MB9597D4FD9FD8B8A8FB0F2B3CB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB959729DB53C0D359F8A83292B8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z7ySdcYWZjCVd-7v@smile.fi.intel.com>
 <PN3PR01MB959780B670AB514305790D8BB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <Z7yV1rvSM2OPW_un@smile.fi.intel.com>
 <PN3PR01MB95976A734F6763F1574FC7EAB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95976A734F6763F1574FC7EAB8C02@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7094:EE_
x-ms-office365-filtering-correlation-id: 306ff45a-a1ce-4bb1-6f93-08dd54ee4c7a
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999004|8062599003|8060799006|19110799003|15080799006|7092599003|6072599003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkhsemVtVDB3amZKQlViRXcxMlRZOC90WHRFVEJoYldINllNT3RUUGtjOFVX?=
 =?utf-8?B?d3A1S3hCOEgwNEIvR1NDUnJTM1lEY01KeDhJN1U0NHFUNjZZVFNDaHhFaXpH?=
 =?utf-8?B?VzBhREJiOFJpaGIxT0tuWmdWNGdQTEVabzRNUStjSDJsL05iTGxaSEVId09w?=
 =?utf-8?B?a3hBYzk5Tm0yQ1c4V2RVTUpDdXF3Z0h5dTJzbXl3am1FUVhRbzA3Wmh3NTcy?=
 =?utf-8?B?c0FoNVlZWm9VNXR0OFdJWm5Ta1NJdEdYYURkVmVzRVoyU3hkSlA0Vk5rMDYx?=
 =?utf-8?B?eWtWV3J6eXBDd3dVSGY1c0tDMlYrQnYzWWNmdDRXSktscVRlZ3AwMWRRM2kr?=
 =?utf-8?B?NGwzOUNUVGx2WVdqK1dIVzhkend5OHI3aXQrb3ByR29JMUhLWm5DWFpGdWhm?=
 =?utf-8?B?aUs0bGRiQXl1YmZ3UjJQY3BJT0cxV2o4QnI5TjBHc1dxek9meGFGZ2JsMlJH?=
 =?utf-8?B?QlB4N2tzakIrUFd3bnBmRmQ3QnIrQTgzelJ3aE4rTlJxdCt0TGlablpYVUls?=
 =?utf-8?B?WmkvdHBGRjNtcVNya1h6dWRVdnVDS2d5QkxtWHhqSUhiNm5pTkU1czFSSzBN?=
 =?utf-8?B?VlExTjBaUElJUVNHdFQ0QlpxUzEzMnArakpEOTlrWEhDYm9SdFdmNjN1TEx1?=
 =?utf-8?B?YmpGUnRKNlVKRTFzRnRvbkRydFJpa1Q4UVRmbkZ1aDQ5YlZqbjRZc3FoNXlR?=
 =?utf-8?B?RXlzUmJhWVBnUTBoaWtyeWtGWWM1V01YRkMzV2FvRGJ6Q3RQaEh3YjYya3JP?=
 =?utf-8?B?cS9jQUdjZGZZNkVEbWdNR2J1b2FVWW53S0xmS2YwK2JmcjhhSk9LZG10YUFz?=
 =?utf-8?B?V0VyMSt1Ri9BKzZyWXhiOXBVWVVLTGtWdy9XQ2hEOXMyZDZjOGJqMG1ZQW81?=
 =?utf-8?B?dWQ2ZUk4N2RleUI3WCtVY3UrWEJVT2k4Uytya0hvR1ZXbUl1MUtjd1dhb0N2?=
 =?utf-8?B?ZjRLVkFHa0dydXBVakZGdFJGbkNhNmZlOTREWkU5WGJsQ09UeEcwcHhvbnhW?=
 =?utf-8?B?NGZhb3Q5QmZUSFI0V0NMQXZEQWMzcDFTRTQ0WGtMdWtjOTRtcHppTDhIVTFV?=
 =?utf-8?B?UWFZcnVuZzBCR0l6NEdoSWJPaHFveDdCa0tjd1hVL1IvMU1qMVZaczZIcjBQ?=
 =?utf-8?B?bkZNNEkxdFNkQVMwd2ZYZnZ3VEhTalJPWFM3TUttNy9FeEoxT1l5bHQ3YWlB?=
 =?utf-8?B?NlZ1TVdTUmQzOHdRa2dkWi9wY0hva2pXQ3FGNXpPYVd2aEh2b0RtM0xFc1hH?=
 =?utf-8?B?S3M5eUZ4cFRQWDJieDBMcEpuaGNmQmRObXZVZUxoUXgxMGlUeUgzNHYwODdy?=
 =?utf-8?B?M054QVNwRzNKRzVwUmZCeGFJWXI3Z3BtMHlxU3Nka3p5UFJTSFpzOUg3Um1u?=
 =?utf-8?B?alpDU1dIT2p3dnI1S2w4MlVVNEVHZ2s5S09iNkdadjhscllvdk1rUTdISEJh?=
 =?utf-8?B?V2p2NWduZGVTVVF6TTFUaTNDbVV5UlV3bmNiWmxRMDFwaHJCalpCT0M2OFRB?=
 =?utf-8?Q?lhnMLSvcUHVgwbtBIeTp8MM1qAm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGQ5QmI2dXh5dDdjZlpTbHZYKzYyeURjUDBqeVZhTzRMMU8rcnFpS2k2REsy?=
 =?utf-8?B?TGtZWGdhbm1xR1g3ZGRHaVlZdGJNR2txcnZucUQ4WFFianROZ3pualFxcCs1?=
 =?utf-8?B?cEN0ajE1WkhpNHpobjBLbHJiVFU0bUE4NklhUHZsUjY1VEtFcFJMTUQyejVT?=
 =?utf-8?B?cFkwU3JQSVdiZStpWm94UnRFZDZSL0dweVlEK0lPY2dRVHdKMnlZRkpNaG9y?=
 =?utf-8?B?aHF4UTBqaVE2U3pRRGNFeTlRT1l4MWpEVFprZDhQRmJLZTJmL0hPeFAwelVs?=
 =?utf-8?B?VmNHNFpGQ1V4Vk9sekxXemNWVzV4Zzg5anBPbWZJLzUrR2Z5SlZ2MU0vRzdG?=
 =?utf-8?B?M3MwYlc5MUc2bDVUTmRwVTZEcUxZUmFZTk90Q1dHbDdoVXpMTUdyblZvUlZa?=
 =?utf-8?B?cVVXMVlGTm1MTlgrUDJxYmxrZWZnY1NnTTJTZ0ovWU5tSndGWndVc1RvT0dM?=
 =?utf-8?B?by9HUW1wblI0QnR5b2dUT3pmMnV3SGlWSDF5Y3BCM0kyK2FGdHVvSEUrcVh6?=
 =?utf-8?B?K24yWVEwZFVnNGZEL0MvRnhGZ3RzYlIyTG1pdVJ5K25jcEMzOE9mTnB0VTdO?=
 =?utf-8?B?RUVWSDBRL1YwclkxS01xNmYyQTdzQ3dPTGdVcmFuUmhWN3dieXNaM2t1eTdC?=
 =?utf-8?B?NExYUkNjL0FpbWFUY0dZVWwwUyt0TG45bmI5b3V5cFg0dGZmTGF5TzBUM1Jr?=
 =?utf-8?B?aWwyZTdBdndmZFRQc2UrczNsMVN2NHFST1pocFd4NjlnVFd2YU5SczNGQjFj?=
 =?utf-8?B?eGRXRWQ4M1Y4NjF4L09SelYrMXlyelZZN1BxS2cvYXQ0ajdkd2IvNVB3UlVI?=
 =?utf-8?B?bjQzRmx5N2lxVDVqK2JLaEUvK2dpUFBudFVkT3Q4TFA3Y2M4U3pxdDY1Y2hR?=
 =?utf-8?B?cmVteTFzMFdEaFcwYnduTi9zaEZMejhVdWQvT3hybXMycGFUTTVDRXlVbjJU?=
 =?utf-8?B?dU9Ba1NWL2ZUTVlSdUg4N1BONWNPbW5KSmc1b3FScW5PcS9Ud092RVNETnJl?=
 =?utf-8?B?KytHTkowQTFTMkpqOXkwQktMekZNYjdFOGpTRUE0eGkxRm9uVVkxa2NyTkto?=
 =?utf-8?B?SUJaTWQ5RndaWmRnZDJ1QTY5ZHU2N0xseXNhYjJWM2pXVUVzTmNQeGhEaWJk?=
 =?utf-8?B?ZDBpRlJOdHRlaHpFRDN2ODJ2aXdYQURpMmthV1BlclNXRjVQdllLMUZqbVpT?=
 =?utf-8?B?RFlIcG9pRHo5Z3ZhSE1mazZpcWJESm5EbHkrR0FKc3FwWmtrVHRTd0hZWm9x?=
 =?utf-8?B?MldCZ2IrOGoxcGM0alNCdUlUclViMjlBcXlRRWpFNGwzdzFRNHJBSUgxTWVj?=
 =?utf-8?B?VFVKUjNzTGFQWlI5K3JFL1JvSldMTDY2SS9DRkZ0RDNka1Z4cGF1VDUxZlh6?=
 =?utf-8?B?ZFBBTE41S0hiZTJwT1k2SzZHdUdhTHZBQVYvSHUwY2FjV1A5R3FJWUxZWWls?=
 =?utf-8?B?eDVXWFNURXptaDQ1b3h3dDVQYTNIdHpJOXJqdmlYYmdhOERnRWxORm1hRnFK?=
 =?utf-8?B?VzVGTUZqVTdVQlp5VU40VFJjb0Rzd1Q1cXR4UnN3MU4yY0xwL0FieHlmZzBQ?=
 =?utf-8?B?LzlMQWQ0WXQybVdUeU1WT2ZDMExxYlRPbFVYYmlFdzlYMllZYlJjZDVLN1pj?=
 =?utf-8?B?WmpWbmc0Sm5YUUV2OXh2VGEzQjU5YWRrdDBTNmtjb3doZFg2Wlo0eFVOczhl?=
 =?utf-8?B?Zm52b1d2WG90TTkrcGQzRzZKcW1zVWE5ODdKTUt4U0M4L1FQTzY4UEpENUNS?=
 =?utf-8?Q?uEAMs+mur7GDzP0HHI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 306ff45a-a1ce-4bb1-6f93-08dd54ee4c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 16:14:21.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7094

DQoNCj4gT24gMjQgRmViIDIwMjUsIGF0IDk6MjbigK9QTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4gDQo+PiBPbiAyNCBGZWIgMjAyNSwg
YXQgOToyM+KAr1BNLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20gd3JvdGU6DQo+
PiANCj4+IO+7v09uIE1vbiwgRmViIDI0LCAyMDI1IGF0IDAzOjQwOjI5UE0gKzAwMDAsIEFkaXR5
YSBHYXJnIHdyb3RlOg0KPj4+Pj4gT24gMjQgRmViIDIwMjUsIGF0IDk6MDjigK9QTSwgYW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIHdyb3RlOg0KPj4+PiBPbiBNb24sIEZlYiAyNCwg
MjAyNSBhdCAwMzozMjo1NlBNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+Pj4+PiBPbiAy
NCBGZWIgMjAyNSwgYXQgODo1MOKAr1BNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUu
Y29tPiB3cm90ZToNCj4+Pj4+Pj4gT24gMjQgRmViIDIwMjUsIGF0IDg6NDHigK9QTSwgYW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIHdyb3RlOg0KPj4+Pj4+PiBPbiBNb24sIEZlYiAy
NCwgMjAyNSBhdCAwMzowMzo0MFBNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+Pj4+Pj4+
Pj4gT24gMjQgRmViIDIwMjUsIGF0IDg6MjfigK9QTSwgYW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPj4+Pj4+Pj4+IE9uIE1vbiwgRmViIDI0LCAyMDI1IGF0IDAyOjMy
OjM3UE0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gT24gMjQgRmViIDIw
MjUsIGF0IDc6MzDigK9QTSwgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tIHdyb3Rl
Og0KPj4+Pj4+Pj4+Pj4+Pj4gT24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgMDE6NDA6MjBQTSArMDAw
MCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4gDQo+Pj4gLi4uDQo+Pj4gDQo+Pj4+Pj4+Pj4+Pj4+
Pj4gKyNkZWZpbmUgX19BUFBMRVRCRFJNX01TR19TVFI0KHN0cjQpICgoX19sZTMyIF9fZm9yY2Up
KChzdHI0WzBdIDw8IDI0KSB8IChzdHI0WzFdIDw8IDE2KSB8IChzdHI0WzJdIDw8IDgpIHwgc3Ry
NFszXSkpDQo+Pj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4+IEFzIGNvbW1lbnRlZCBwcmV2
aW91c2x5IHRoaXMgaXMgcXVpdGUgc3RyYW5nZSB3aGF0J3MgZ29pbmcgb24gd2l0aCBlbmRpYW5l
c3MgaW4NCj4+Pj4+Pj4+Pj4+Pj4+IHRoaXMgZHJpdmVyLiBFc3BlY2lhbGx5IHRoZSBhYm92ZSB3
ZWlyZG5lc3Mgd2hlbiBnZXRfdW5hbGlnbmVkX2JlMzIoKSBpcyBiZWluZw0KPj4+Pj4+Pj4+Pj4+
Pj4gb3BlbiBjb2RlZCBhbmQgZm9yY2UtY2FzdCB0byBfX2xlMzIuDQo+Pj4+Pj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4+Pj4+PiBJIHdvdWxkIGFzc3VtZSBpdCB3YXMgYWxzbyBtaW1pY2tlZCBmcm9tIHRo
ZSBXaW5kb3dzIGRyaXZlciwgdGhvdWdoIEkgaGF2ZW4ndA0KPj4+Pj4+Pj4+Pj4+PiByZWFsbHkg
dHJpZWQgZXhwbG9yaW5nIHRoaXMgdGhlcmUuDQo+Pj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+
PiBJ4oCZZCByYXRoZXIgYmUgaGFwcHkgaWYgeW91IGdpdmUgbWUgY29kZSBjaGFuZ2Ugc3VnZ2Vz
dGlvbnMgYW5kIGxldCBtZSByZXZpZXcNCj4+Pj4+Pj4+Pj4+Pj4gYW5kIHRlc3QgdGhlbQ0KPj4+
Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+IEZvciB0aGUgc3RhcnRlciBJIHdvdWxkIGRvIHRoZSBm
b2xsb3dpbmcgZm9yIGFsbCByZWxhdGVkIGNvbnN0YW50cyBhbmQNCj4+Pj4+Pj4+Pj4+PiBkcm9w
IHRoYXQgd2VpcmQgYW5kIHVnbHkgbWFjcm9zIGF0IHRoZSB0b3AgKGl0IGFsc28gaGFzIGFuIGlz
c3VlIHdpdGgNCj4+Pj4+Pj4+Pj4+PiB0aGUgc3RyNCBsZW5ndGggYXMgaXQgaXMgNSBieXRlcyBs
b25nLCBub3QgNCwgYnR3KToNCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiAjZGVmaW5lIEFQ
UExFVEJEUk1fTVNHX0NMRUFSX0RJU1BMQVkgY3B1X3RvX2xlMzIoMHg0MzRjNTI0NCkgLyogQ0xS
RCAqLw0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gTGVtbWUgdGVzdCB0aGlzLg0KPj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+IEp1c3QgaW4gY2FzZSBpdCB3b24ndCB3b3JrLCByZXZlcnNlIGJ5dGVzIGlu
IHRoZSBpbnRlZ2VyLiBCZWNhdXNlIEkgd2FzIGxvc3QgaW4NCj4+Pj4+Pj4+PiB0aGlzIGNvbnZl
cnNpb24uDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBJdCB3b3Jrcy4gV2hhdCBJIHVuZGVyc3RhbmQgaXMg
dGhhdCB5b3UgdXNlZCB0aGUgbWFjcm8gdG8gZ2V0IHRoZSBmaW5hbCBoZXggYW5kIGNvbnZlcnRl
ZCBpdCBpbnRvIGxpdHRsZSBlbmRpYW4sIHdoaWNoIG9uIHRoZSB4ODYgbWFjcyB3b3VsZCB0ZWNo
bmljYWxseSByZW1haW4gdGhlIHNhbWUuDQo+Pj4+Pj4gDQo+Pj4+Pj4gQW5kIG5vdyB0aGF0IEkg
b2JlcnZlZCBhZ2FpbiwgJXA0Y2MgaXMgYWN0dWFsbHkgcHJpbnRpbmcgdGhlc2UgQ0xSRCwgUkVE
WSBldGMNCj4+Pj4+PiBpbiByZXZlcnNlIG9yZGVyLCBwcm9iYWJseSB0aGUgcmVhc29uICVwNGNo
IHdhcyBjaG9zZW4uIEFuZCBJIGFtIHVuYWJsZSB0bw0KPj4+Pj4+IGZpbmQgd2hhdCBtYWNybyB1
cHN0cmVhbSBjYW4gYmUgdXNlZC4NCj4+Pj4+IA0KPj4+Pj4gJS40cyBzaG91bGQgd29yayBhcyBp
dCB0ZWNobmljYWxseSBub3QgRFJNIDRjYywgYnV0IHNwZWNpZmljcyBvZiB0aGUgcHJvdG9jb2wN
Cj4+Pj4+ICh0aGF0IHJlbWluZHMgbWUgYWJvdXQgQUNQSSB0aGF0IHVzZXMgNGNjIGEgbG90KS4N
Cj4+PiANCj4+PiBJIHN0aWxsIGdldCByZXZlcnNlIG9yZGVyIGluIHRoYXQuDQo+PiANCj4+IEFo
LCByaWdodCwgaXQgd2lsbCBnaXZlIHlvdSB0aGUgZmlyc3QgbGV0dGVyIGFzIExTQiwgaW5kZWVk
LiBBdCB0aGUgZW5kIG9mIHRoZQ0KPj4gZGF5IGlmIGl0J3Mgc28gaW1wb3J0YW50LCB0aGVyZSBh
cmUgd2F5cyBob3cgdG8gc29sdmUgdGhhdCB3aXRob3V0IHVzaW5nICVwNGNjLg0KPj4gQnV0IGlm
IG90aGVycyAoYW5kIGVzcC4gUFJJTlRLIG1haW50YWluZXJzKSB3YW50IHRvIGhhdmUgLyBkb24n
dCBvYmplY3QgaGF2aW5nDQo+PiB0aGF0IGV4dGVuc2lvbiwgd2h5IG5vdD8NCj4gDQo+IFJpZ2h0
LCBidXQgd2hhdCB0byBkbyBhYm91dCB0aGUgY2FzZSBvZiBsaXR0bGUgZW5kaWFuIGFuZCBob3N0
IGVuZGlhbj8gSSByZW1lbWJlciB0aGUgc3RhdGVtZW50ICJmb3IgdGhlIHNha2Ugb2YgY29tcGxl
dGVuZXNzIiBmb3IgdGhlbS4gRG8geW91IHRoaW5rIGp1c3QgaG9zdCBlbmRpYW4gYW5kIHJldmVy
c2UgZW5kaWFuIHNob3VsZCBiZSBqdXN0IGZpbmU/IE9yIHlvdSBnb3QgYW55ICJubyBzcGFyc2Ug
d2FybmluZyIgd2F5IHRvIGdldCBpdCBkb25lPyBUaGUgbWFjcm9zIHRvIGNvbnZlcnQgdG8gbGUz
Mi9iZTMyIGV4cGVjdCBhIHUzMiB2YWx1ZSwgYnV0IGluIHRob3NlIGNhc2VzIHdlIGFjdHVhbGx5
IGFyZSBwYXNzaW5nIGEgbGUzMi9iZTMyIHZhbHVlLg0KDQpXZSBjYW4gY29udmVydCB0aGUgX19s
ZTMyIHRvIGJlIHByaW50ZWQgYnkgJXA0Y2MgdG8gX19iZTMyLg0KDQpfX2JlMzIgZXhwZWN0ZWRf
cmVzcG9uc2VfYmUgPSBjcHVfdG9fYmUzMihsZTMyX3RvX2NwdShleHBlY3RlZF9yZXNwb25zZSkp
Ow0KDQpUaGF0J3Mgc2VlbXMgdG8gYmUgdGhlIGJlc3QgcG9zc2libGUgb3B0aW9uIHRvIGZpeCB0
aGlzIHJldmVydC4=

