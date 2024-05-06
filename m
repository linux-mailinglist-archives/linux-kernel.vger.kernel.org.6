Return-Path: <linux-kernel+bounces-169271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0108BC5F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025DB1F21D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516B340856;
	Mon,  6 May 2024 02:57:56 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2101.outbound.protection.partner.outlook.cn [139.219.146.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18B358A7
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964275; cv=fail; b=YjEx+wJCtTOUSDAjyUHLP7GgkAHjs1PwyU1/RGAR21WHUqzEFGSpmXGrtNZ5BM4hxYVGkOgdSqg9xJybcWtsW0hK2/UTG3h43PpCqCJQYcbAu2A4Hpov34bhccd53Kiff9gMWJLWoLU83o/ewqLXJ4sE6gCzMkYA0lhy10dRkfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964275; c=relaxed/simple;
	bh=11QoA7wUsc4VpZfD9Amiq/wlT3HaXjnWFOb/FtM/BIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9nNhSvjZp9ewRq3U1DRGQy+JDZAWp759n+rTodFgd8YphNNszo2v8KOJ3z5E1Om1nIyedGLZhC7jEVZ6Ru4BvbMK/EDZBpLqTmN5YaqWDwdM4HoSXJ+B8PWhVj6ehWWkfIBvcTktra5uXWA/lDpqOzx5kssgApFZciivd9iEMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMg52JLKGFP8JTUEXKckY44/8bPegRF3Q7NFOuNTl9og4aw7IZZx6KJkkhqzXNqHXsqqNyz4oa4FO5E29gshr2bhbi8fQK8OHk8j8LZ1X9+q4T9KRkI7xei0RXMXegA5vgFdm7zhQ/EMXRI3LoKtG1KlWWAZdY8aF4T+JVVhPmwiiozWluvGO7pgi21nZ/wp6y1xyNS/z6u/mLRgBa+eD25RHal27psypShmPkKXCJ0vJfgcGtXVxJeaycMkyNLMPPura3UYiYpuYRXXcwLsXGq64gDtG4QivMHp//YuzsdyjRMdUXJ1GgPBlJcWts0Q29teZuu2PhMnAHvM7DerHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11QoA7wUsc4VpZfD9Amiq/wlT3HaXjnWFOb/FtM/BIk=;
 b=CksQMKDgJ8Z0IWJX3ocp37r2HXfv6ct8WuRK59i99B8Z2ICvFedkgivWt6eJPCq8PuVrafzaBFzf+xutqVtzLhxxA4TNEYgp0TxQs0kXnBcc5knwTEy37FHB4UzKiMQk+kjdsjUZIbu+pD+YTMOJ10DmKrjtEue5bkwitmq2p9ID1f57dMSlSHYF4JnxHHSll44IoYZ9EPIAxJ3J03IWu1lMPWEENS0IeHkqy9IWTBBLV5IeMMPfWOueVIpZbYk7OglDPLjKgnJ5aEZxS6rlQ4yoW1OnEIVqKygZrDCyjnIlGPCag9N6Qhr79hcHy1D8VSn3w6hsE6mVFjKRuszq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 6 May
 2024 02:23:26 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Mon, 6 May 2024
 02:23:26 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
Thread-Topic: [PATCH v1] riscv: defconfig: Enable StarFive JH7110 drivers
Thread-Index: AQHahY1xSncvYch2v0Wp+YvYWpBQy7GCuL4AgAbyfPA=
Date: Mon, 6 May 2024 02:23:26 +0000
Message-ID:
 <ZQ2PR01MB1307BCC6C4AA0B305ABD9416E61CA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240403060902.42834-1-hal.feng@starfivetech.com>
 <mhng-3c2a418c-ce79-4287-a890-208a5d026e70@palmer-ri-x1c9a>
In-Reply-To: <mhng-3c2a418c-ce79-4287-a890-208a5d026e70@palmer-ri-x1c9a>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
x-ms-office365-filtering-correlation-id: 09e4d942-568c-4f81-8466-08dc6d7382fe
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XzuU0oqOU6Ei6dB7lbqf6AdGxIwlTkzojP/g2+sQIzRgJwxEXQWuwjd6JKJWgPIc1i1FuD8+NRsb4fN0dZPNAcrB+g+3VZYqv83pB5SNhq7fdR453DCR6yovEdi/C7frHY96XZhYqA87C66NMR5Ba8IgPricXo6SmKLkvcxSphAXA8BMzq1F/PN4LCneaOLQlFvZqeMwKZ/FcLrr+0ZDnWb7RHtEVphKfiVOXY4EGvKRy4c6Pi++vqfhGOy3v6XUBri/ZMgQ9IlksgCDb7Hlxszpmo6aazApGF28mUwgAYFrjb9Dy9MmZPHNf/xmqQsD0aZ312kvVOJiOD2CpJJsWW0ZntONw3LSbthxs0T9qeNPnkjGsR4hVLoZZljTI0bDgb9jTZTSITEz1FaUT9cuyXATL6/HahwKo48OipXReV+w+Q/3ng9Z5phWi7Gl2D46uByKC5au82sXt7MOgddT8WLI0fl9NtFL0LtXxjnQJZTxkGdM2+AHK0MRZjXf4LYyXyG3CRgmj04VLw2gRljtcFtQLvIepAo+8LATQwT+pLCEZGCCQtn2YSVxy4ydD+Tkyn1eIHbomsWWLpwAIBSvRtOCRE5xvmORZu01O+ZX13JlvO6G+y0t6BfJKnq07AWm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHNHT1lOay9jQUxxUHlCdm50OXl1bFZBSWZJbDJzVnhEQmtHNDlOeEgvWVF5?=
 =?utf-8?B?a05ENzlXVlJSVUNmL3NXSUdFUFo2dmxpOGJCOUswVjBYVFZrb1U3VktWMWFt?=
 =?utf-8?B?L2MyYk5GaTFKR04vOEh0anpZQ0lXNmJvdDNHdndqb1ExNjJrNnpIOUpNeVIr?=
 =?utf-8?B?ZU1sK0VpelgwaTl2VVYrN0dENXpYbUQ5Tk1VZGQvazVQTXVoOUdaNjEzSmxz?=
 =?utf-8?B?T3pCd1pZdk8zZGE4VkM2ekwwS0pyeUN6enBZNTBuSmNNSEc3YmdZdHNQUXZI?=
 =?utf-8?B?M0VxR2dIM0JNbnFaVDJFaTJ0VXYzVkxFRWtZaWtSMnpRVlJFYUpJV2dwQm5y?=
 =?utf-8?B?WGczSzhuMU5DYk0raTVvdXdJL0VzdFRHRGVLTzYwd1Z4MGJ1MUpRWkY0aDJq?=
 =?utf-8?B?N0p6a2VBMmtuZUhhbDJxQjVIYlFmNTBGMXFock1HUE02TkFwQUdJK29ibnVZ?=
 =?utf-8?B?aFdiS0kzeEE3aVNUSHB5UkE0MGNoYnUyRmtWdzBiWFF1N1ZncVJ4cmMwcEI0?=
 =?utf-8?B?UmZ6YkNrcjBjUDloaDNHZTg4dmt3R09DM0M1UWZ2ZGI1cnZESlpXK3hyTndU?=
 =?utf-8?B?a1pLL2Rab01SL3hUOUlzaUt0NS9LejBsNkVWUFZjT2xvdmF6YkZBWFltQXpn?=
 =?utf-8?B?UnpsaUtqRWdGcndRMkJ4MGNmeGZQdk5WdjdXbEhpU2h2MTl0VnRsWko4YzRx?=
 =?utf-8?B?bTliSTEzU1Q2SnNXeXZkbmI1dU5RY3h1alBTU0JwV0grcFZDNWpxMDJvSjlt?=
 =?utf-8?B?RUxXQmF6bXMvRFQ0WUZTczVGRkU3MHhoU3dVR1pGRHZ5K3kreWtVeVk5eWF1?=
 =?utf-8?B?SmRDK2RlTk1oTEJmRjhld3FjR0oyNGlJOVZKTXZjeEd5Zkw3ZDdCZXdBeGtJ?=
 =?utf-8?B?UHU5VHp3VGZZLzA3MExpcmwrRWRmdzllUXNXckE1TVpjTXpuWDhNNmlKekdM?=
 =?utf-8?B?NHRsU2VycGJDSyt6YmlId2RtekZpbG1vTDV6VEJRb3BKSzVENFpyT1YrK3RC?=
 =?utf-8?B?KzMwbjBnb0JObWd3Qm50OSt3T05FQlo2SndIbWhsckZrYXJaM2hGeHZjb3pn?=
 =?utf-8?B?bTBMK2pJQWdHTTkxYnptNTdZeVZOQnhsK1Rtb093NmdKTDNCd2ovdmNldUdL?=
 =?utf-8?B?OU1oY0ttZWpEOTd2S0ZEZE83Y3ZxSXBqR2dKU01UbTFEM2lUNkl4ZkNOOEIy?=
 =?utf-8?B?a1NXYnNsaS85NnpRNWhhSzlWaTlaSWxhd2xLMUhZT3pRUWdEekJtbFozTnlx?=
 =?utf-8?B?aFkvNGtnMFBUdURjbGV2dHhVOTJmOGp6QjhONEo2MDhSano2cGRTU202bUlk?=
 =?utf-8?B?U2lEOXVreVJSdWE2K1MrVlNpaGIyR2wwWnMzRE05bVJuSldwZmtqK25hajg2?=
 =?utf-8?B?ZnNCclhXU3U3OFJOVHRHT0dFN3NrUjVmd2cvN0tjeWdpL0RGdTRhS0FybDZm?=
 =?utf-8?B?NndvYktPdE82MGJWTGxXWXZYendxUWNoTGc1ZGZENHdBNTZrd3l6UnAxTFlW?=
 =?utf-8?B?a2xhRjVhcHQwQ25NU1dWeFVJRWFzYnVDcVQzaU5ITkxlK3ZsNHN6TlNzR2ox?=
 =?utf-8?B?ZDlhMnFDaEZJZTNUYXRSeldGc084TTdqeWhhcS9MMVEzdTNOcER0WlIraWNY?=
 =?utf-8?B?ZkJXSE5DYXI5V3NqMytJWXQzYmg5VHJLL2o5SHdvbzZLRTRvU3Q3WENRdWp3?=
 =?utf-8?B?U2tXVGxPRVRWakJjeDg5VHU1djZTSXF2NlZTOWZzYWJMYlVjM0dXU0h0eEFh?=
 =?utf-8?B?d0V5ZG1mTEprZklYT1Z0Vnd5MWdSSC95Lzljblg3dGYwTXdldUpNeGZXQlZY?=
 =?utf-8?B?RU51azRyOXF5dHNpbmlmVEJ5QVYrK0RQc3k5eWlQTmpRMlE1NDliaEJBOGNo?=
 =?utf-8?B?djB0bDNIdUtWclZRS21jL0tpbmxjQWpuZW1pVVZpODIycDJpb1ZWTytjYk9o?=
 =?utf-8?B?OU5wWUEyOXFRQmFFS1RvTVV6aGRrcWhHeEtaZDdESm9IT3hZN0hYanMwdEk4?=
 =?utf-8?B?eDU5OU5wakVvU1dSYndKME5kVDlmSkg3WkdHMlFhUHE4WktDYXRnWTU0amly?=
 =?utf-8?B?Ynh0U0xqRi8wWmtOZXJqNE9zUHJWRUJ3ZEtmckMzN0xqSi9oOTZ6R3RIRkpK?=
 =?utf-8?Q?k71qcKdHQC/5mCpHjTGYFXCUg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e4d942-568c-4f81-8466-08dc6d7382fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 02:23:26.5732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e5pH0t9Klo1PiO9rPohbgLVkAoPirP0bm4xKcG2PIETFdOc/8UM9yRpghQaaVZ8uZIOnlWeG2d+0fqs1OYlVnI0FiD+PbmPjtQdsoxDJYEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164

PiBPbiAwMi4wNS4yNCAwMDowOSwgUGFsbWVyIERhYmJlbHQgd3JvdGU6IA0KPiBPbiBUdWUsIDAy
IEFwciAyMDI0IDIzOjA5OjAyIFBEVCAoLTA3MDApLCBoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29t
IHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZvciBTdGFyRml2ZSBKSDcxMTAgU29DIGFuZCBWaXNp
b25GaXZlIDIgYm9hcmQuDQo+ID4gLSBDbG9jayAmIHJlc2V0DQo+ID4gLSBDYWNoZQ0KPiA+IC0g
VGVtcGVyYXR1cmUgc2Vuc29yDQo+ID4gLSBQTUlDIChBWFAxNTA2MCkNCj4gPiAtIFJlc3RhcnQg
R1BJTw0KPiA+IC0gUk5HDQo+ID4gLSBJMkMNCj4gPiAtIFNQSQ0KPiA+IC0gUXVhZCBTUEkNCj4g
PiAtIFVTQiAmIFVTQiAyLjAgUEhZICYgUENJZSAyLjAvVVNCIDMuMCBQSFkNCj4gPiAtIEF1ZGlv
IChJMlMgLyBURE0gLyBQV00tREFDKQ0KPiA+IC0gQ2FtZXJhIFN1YnN5c3RlbSAmIE1JUEktQ1NJ
MiBSWCAmIEQtUEhZIFJYDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWwgRmVuZyA8aGFsLmZl
bmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gQXMg
bW9yZSBkcml2ZXJzIG9mIFN0YXJGaXZlIEpINzExMCBWaXNpb25GaXZlIDIgYm9hcmQgYXJlIHVw
c3RyZWFtLA0KPiA+IGFkZCBzdXBwb3J0IGZvciB0aGVtIGluIHJpc2N2IGRlZmNvbmZpZy4NCj4g
Pg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBIYWwNCj4gPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Jp
c2N2L2NvbmZpZ3MvZGVmY29uZmlnIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gYi9hcmNoL3Jpc2N2L2Nv
bmZpZ3MvZGVmY29uZmlnIGluZGV4IGZjMGVjMmVlMTNiYy4uYTRlYjY2YjMwZDk1IDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvcmlzY3YvY29uZmlncy9kZWZjb25maWcNCj4gPiArKysgYi9hcmNoL3Jp
c2N2L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gQEAgLTExMSw2ICsxMTEsNyBAQCBDT05GSUdfUENJ
RV9YSUxJTlg9eSAgQ09ORklHX1BDSUVfRlU3NDA9eQ0KPiA+IENPTkZJR19ERVZUTVBGUz15ICBD
T05GSUdfREVWVE1QRlNfTU9VTlQ9eQ0KPiA+ICtDT05GSUdfU0lGSVZFX0NDQUNIRT15DQo+ID4g
IENPTkZJR19NVEQ9eQ0KPiA+ICBDT05GSUdfTVREX0JMT0NLPXkNCj4gPiAgQ09ORklHX01URF9D
Rkk9eQ0KPiA+IEBAIC0xNTQsMjQgKzE1NSwzNiBAQCBDT05GSUdfU0VSSUFMX0VBUkxZQ09OX1JJ
U0NWX1NCST15DQo+ID4gIENPTkZJR19WSVJUSU9fQ09OU09MRT15DQo+ID4gIENPTkZJR19IV19S
QU5ET009eQ0KPiA+ICBDT05GSUdfSFdfUkFORE9NX1ZJUlRJTz15DQo+ID4gK0NPTkZJR19IV19S
QU5ET01fSkg3MTEwPW0NCj4gPiArQ09ORklHX0kyQz15DQo+ID4gIENPTkZJR19JMkNfQ0hBUkRF
Vj1tDQo+ID4gK0NPTkZJR19JMkNfREVTSUdOV0FSRV9QTEFURk9STT15DQo+ID4gIENPTkZJR19J
MkNfTVY2NFhYWD1tDQo+ID4gIENPTkZJR19JMkNfUklJQz15DQo+ID4gIENPTkZJR19TUEk9eQ0K
PiA+ICtDT05GSUdfU1BJX0NBREVOQ0VfUVVBRFNQST1tDQo+ID4gK0NPTkZJR19TUElfUEwwMjI9
bQ0KPiA+ICBDT05GSUdfU1BJX1JTUEk9bQ0KPiA+ICBDT05GSUdfU1BJX1NJRklWRT15DQo+ID4g
IENPTkZJR19TUElfU1VONkk9eQ0KPiA+ICAjIENPTkZJR19QVFBfMTU4OF9DTE9DSyBpcyBub3Qg
c2V0DQo+ID4gIENPTkZJR19HUElPX1NJRklWRT15DQo+ID4gK0NPTkZJR19QT1dFUl9SRVNFVF9H
UElPX1JFU1RBUlQ9eQ0KPiA+ICtDT05GSUdfU0VOU09SU19TRkNURU1QPXkNCj4gPiAgQ09ORklH
X0NQVV9USEVSTUFMPXkNCj4gPiAgQ09ORklHX0RFVkZSRVFfVEhFUk1BTD15DQo+ID4gIENPTkZJ
R19SWkcyTF9USEVSTUFMPXkNCj4gPiAgQ09ORklHX1dBVENIRE9HPXkNCj4gPiAgQ09ORklHX1NV
TlhJX1dBVENIRE9HPXkNCj4gPiAgQ09ORklHX1JFTkVTQVNfUlpHMkxXRFQ9eQ0KPiA+ICtDT05G
SUdfTUZEX0FYUDIwWF9JMkM9eQ0KPiA+ICBDT05GSUdfUkVHVUxBVE9SPXkNCj4gPiAgQ09ORklH
X1JFR1VMQVRPUl9GSVhFRF9WT0xUQUdFPXkNCj4gPiArQ09ORklHX1JFR1VMQVRPUl9BWFAyMFg9
eQ0KPiA+ICBDT05GSUdfUkVHVUxBVE9SX0dQSU89eQ0KPiA+ICtDT05GSUdfTUVESUFfU1VQUE9S
VD1tDQo+ID4gK0NPTkZJR19WNExfUExBVEZPUk1fRFJJVkVSUz15DQo+ID4gK0NPTkZJR19WSURF
T19DQURFTkNFX0NTSTJSWD1tDQo+ID4gIENPTkZJR19EUk09bQ0KPiA+ICBDT05GSUdfRFJNX1JB
REVPTj1tDQo+ID4gIENPTkZJR19EUk1fTk9VVkVBVT1tDQo+ID4gQEAgLTE4Myw2ICsxOTYsMTAg
QEAgQ09ORklHX1NPVU5EPXkNCj4gPiAgQ09ORklHX1NORD15DQo+ID4gIENPTkZJR19TTkRfU09D
PXkNCj4gPiAgQ09ORklHX1NORF9TT0NfUlo9bQ0KPiA+ICtDT05GSUdfU05EX0RFU0lHTldBUkVf
STJTPW0NCj4gPiArQ09ORklHX1NORF9TT0NfU1RBUkZJVkU9bQ0KPiA+ICtDT05GSUdfU05EX1NP
Q19KSDcxMTBfUFdNREFDPW0NCj4gPiArQ09ORklHX1NORF9TT0NfSkg3MTEwX1RETT1tDQo+ID4g
IENPTkZJR19TTkRfU09DX1dNODk3OD1tDQo+ID4gIENPTkZJR19TTkRfU0lNUExFX0NBUkQ9bQ0K
PiA+ICBDT05GSUdfVVNCPXkNCj4gPiBAQCAtMTk2LDYgKzIxMywxMSBAQCBDT05GSUdfVVNCX09I
Q0lfSENEX1BMQVRGT1JNPXkNCj4gPiBDT05GSUdfVVNCX1JFTkVTQVNfVVNCSFM9bSAgQ09ORklH
X1VTQl9TVE9SQUdFPXkNCj4gQ09ORklHX1VTQl9VQVM9eQ0KPiA+ICtDT05GSUdfVVNCX0NETlNf
U1VQUE9SVD1tDQo+ID4gK0NPTkZJR19VU0JfQ0ROUzM9bQ0KPiA+ICtDT05GSUdfVVNCX0NETlMz
X0dBREdFVD15DQo+ID4gK0NPTkZJR19VU0JfQ0ROUzNfSE9TVD15DQo+ID4gK0NPTkZJR19VU0Jf
Q0ROUzNfU1RBUkZJVkU9bQ0KPiA+ICBDT05GSUdfVVNCX01VU0JfSERSQz1tDQo+ID4gIENPTkZJ
R19VU0JfTVVTQl9TVU5YST1tDQo+ID4gIENPTkZJR19OT1BfVVNCX1hDRUlWPW0NCj4gPiBAQCAt
MjMzLDYgKzI1NSwxMyBAQCBDT05GSUdfVklSVElPX0JBTExPT049eQ0KPiBDT05GSUdfVklSVElP
X0lOUFVUPXkNCj4gPiBDT05GSUdfVklSVElPX01NSU89eSAgQ09ORklHX1JFTkVTQVNfT1NUTT15
DQo+ID4gK0NPTkZJR19TVEFHSU5HPXkNCj4gPiArQ09ORklHX1NUQUdJTkdfTUVESUE9eQ0KPiBn
DQo+IEkgZG9uJ3QgdGhpbmsgd2Ugd2FudCBzdGFnaW5nIG9uIGluIGRlZmNvbmZpZy4NCj4gDQo+
ID4gK0NPTkZJR19WSURFT19TVEFSRklWRV9DQU1TUz1tDQo+IA0KPiBJcyBpdCBqdXN0IGZvciB0
aGlzPyAgSSB0aGluayB3ZSBjYW4ganVzdCBleGNsdWRlIHRoYXQgZnJvbSBkZWZjb25maWcgdW50
aWwgaXQgZ2V0cyBvdXQNCj4gb2Ygc3RhZ2luZywgd2Ugc2hvdWxkIGJlIGFibGUgdG8gYm9vdCB3
aXRob3V0IGl0Lg0KPiBBY2NvcmRpbmcgdG8gdGhlIFRPRE8gdXNlcnNwYWNlIGlzbid0IHRoZXJl
IHlldCwgc28gSSB0aGluayBpdCBzaG91bGQgYmUgcHJldHR5DQo+IHNhZmUuDQoNClllYWgsIENP
TkZJR19TVEFHSU5HIGlzIGp1c3QgZm9yIENPTkZJR19WSURFT19TVEFSRklWRV9DQU1TUy4NCkkg
d2lsbCBkcm9wIHRoZSBhYm92ZSB0aHJlZSBjb25maWdzIGluIHRoZSBuZXh0IHZlcnNpb24uDQoN
CkJlc3QgcmVnYXJkcywNCkhhbA0KDQo+IA0KPiA+ICtDT05GSUdfQ0xLX1NUQVJGSVZFX0pINzEx
MF9BT049eQ0KPiA+ICtDT05GSUdfQ0xLX1NUQVJGSVZFX0pINzExMF9TVEc9eQ0KPiA+ICtDT05G
SUdfQ0xLX1NUQVJGSVZFX0pINzExMF9JU1A9eQ0KPiA+ICtDT05GSUdfQ0xLX1NUQVJGSVZFX0pI
NzExMF9WT1VUPXkNCj4gPiAgQ09ORklHX1NVTjhJX0RFMl9DQ1U9bQ0KPiA+ICBDT05GSUdfU1VO
NTBJX0lPTU1VPXkNCj4gPiAgQ09ORklHX1JQTVNHX0NIQVI9eQ0KPiA+IEBAIC0yNDQsNiArMjcz
LDkgQEAgQ09ORklHX1JaRzJMX0FEQz1tDQo+ID4gQ09ORklHX1JFU0VUX1JaRzJMX1VTQlBIWV9D
VFJMPXkgIENPTkZJR19QSFlfU1VONElfVVNCPW0NCj4gPiBDT05GSUdfUEhZX1JDQVJfR0VOM19V
U0IyPXkNCj4gPiArQ09ORklHX1BIWV9TVEFSRklWRV9KSDcxMTBfRFBIWV9SWD1tDQo+ID4gK0NP
TkZJR19QSFlfU1RBUkZJVkVfSkg3MTEwX1BDSUU9bQ0KPiA+ICtDT05GSUdfUEhZX1NUQVJGSVZF
X0pINzExMF9VU0I9bQ0KPiA+ICBDT05GSUdfTElCTlZESU1NPXkNCj4gPiAgQ09ORklHX05WTUVN
X1NVTlhJX1NJRD15DQo+ID4gIENPTkZJR19FWFQ0X0ZTPXkNCj4gPg0KPiA+IGJhc2UtY29tbWl0
OiAzOWNkODdjNGViMmI4OTMzNTRmM2I4NTBmOTE2MzUzZjI2NThhZTZmDQo=

