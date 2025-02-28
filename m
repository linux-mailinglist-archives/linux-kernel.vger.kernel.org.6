Return-Path: <linux-kernel+bounces-538905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C217BA49EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CA3BB8C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD94F271818;
	Fri, 28 Feb 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="HcMSgKaS"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010003.outbound.protection.outlook.com [52.103.68.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68561A8413;
	Fri, 28 Feb 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759836; cv=fail; b=gxWMsrcKRr49BGrtHP//qQ6QLjJMoQPl8mt2qDjbdjzuhYRSl4zE4lWaE/cm0xAMPSaaObC7oAGWAqqEmwr+CXK8/5W5Z6Y1/94jqecHSfpYCaFdNVEDfTSZanLvSAhWM7GsyMBv0WkJOk5wZYyoYG6/SgJ69Lnn9pk4KTjuKtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759836; c=relaxed/simple;
	bh=sN4nGIgYgqt/oqW0c2IzjUuTlw/o0T8MbxefU73P/gY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FSvH61oHSO9h548RVsXniLRcberGfNuL+dI18Ib17H0pknUzu8NgMxfnVrQXnHGA06pCyUitTJ7gohW6zwjGMNNssPVlL6fHut7D5LAQeBajr2XUbFxhwvuK1XJSv6oAGEQ2r6S8acMVWD8n+zrYVWWvW3ldzYbDHikJu36luSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=HcMSgKaS; arc=fail smtp.client-ip=52.103.68.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jq8pwKYAWykt1oSJ5mIP2kSHGbJhRrs1Vi4Ufi2D+505CIEkg9o2V+soKG/oDMIWGhppYIbjMVaUgi5cpX9wv+8BHyL0yN2xjTjvWavK0kcluFjfCkMaBfBzBQkBbBIAnOx2zWEJTxpNpU3461MOdENVzsNw4htUnWwm/azdw12GmgB1K+Fmx2DJLGdnuySJDCPK8jQtDi6ZmwwWO7OBbkLAATsU1fIudGIGxjfMN/bcWluH4MvxPDMgMvDo4ehP78ovPKSUvDgIkzQGrDNqONVBy2on773JEqugwVIned8uBks6fLbSdPqNCk9Jp2Un4p5gtK1eqPdfBNqrgqfm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN4nGIgYgqt/oqW0c2IzjUuTlw/o0T8MbxefU73P/gY=;
 b=Po3nrHbgWm5AzssvS0b/7xrWlg6QiuHvyMzwA1jYPbDwEeWNblbpqh/e6euRuctEO6mmOfudfW9odN/aZW6HiqwSihH+Qa7v+UoW+XLYxEld3S5PthGLkR7EX7RmULDMA/mBG0ZjW33FqW7fIxseqSIwUBBG2q7CcWmp6GBonf+Q4D8FCEG4T/qAnL25YItmqQQFqjea4t9xIJ19dOql09yOfYmE3bbqcr6QoV0iZxoMc8LkFi1YdC5NoWHS0IsUBNscLsSykYJ4h7lEmnyXwa0EEMV1WJZ1pD5S3WUTf1xWmdYUjgg2leYh+34KY7a8er41dT/oRIr5xuLJ4OuyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN4nGIgYgqt/oqW0c2IzjUuTlw/o0T8MbxefU73P/gY=;
 b=HcMSgKaSlZCMSv5ZbllJWZP8EaRX3+cUKxc93WV6v1wMJFgUB8/5Q/Eeo1VHy5RyCz4B8H+geJZ/5ZTtP4jg85msSc6nOI7ubLpqWjvKWRtBlXrbQa5z67qkxLhYb0O4SvNFQR8ZgJxHRdJTuril2LzzOsTDXuCdVV/Bp8vb4xUrmMoRDZtb01jaNqYgpaDY1IKDOaza3rcxhg3zR3RYbRZQ15vijW2nciWXfCUMc1g+z2qGj5ZLRLI87F2W0vaK1K+csV3xw4k1XXafjsGN7TJCKaxYXbx5qEBXiHwAJ5d0f9DccbiGKWuw9lXxX9YgkM8krHw5Ti5wdzrVZqZcsg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8104.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 16:23:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:23:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Petr Mladek <pmladek@suse.com>
CC: Steven Rostedt <rostedt@goodmis.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, "senozhatsky@chromium.org"
	<senozhatsky@chromium.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "apw@canonical.com"
	<apw@canonical.com>, "joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hector Martin
	<marcan@marcan.st>, "sven@svenpeter.dev" <sven@svenpeter.dev>, Janne Grunau
	<j@jannau.net>, "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Topic: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Thread-Index: AQHbiOEjzUrALYS3lkmTQCvm8eL6dLNc4a6AgAAG1ts=
Date: Fri, 28 Feb 2025 16:23:46 +0000
Message-ID:
 <PN3PR01MB9597B87A165D8F9D76B41762B8CC2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
 <Z8HdVfr2hWyzhwHh@pathway.suse.cz>
In-Reply-To: <Z8HdVfr2hWyzhwHh@pathway.suse.cz>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8104:EE_
x-ms-office365-filtering-correlation-id: 4649c59f-05e6-4036-de2e-08dd581446c2
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|7092599003|15080799006|461199028|8060799006|8062599003|19110799003|102099032|1602099012|440099028|4302099013|10035399004|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmdKL21PZ3VXelhsQUdkTTNFdG1rUUFuRnhWbG5yckxHRWc4TGhQdWNManZQ?=
 =?utf-8?B?MHBobWlFVlc4SGpkaHlYYW5WcS9JSit5dlgzaDhkRFdBam4zZmFLRjVGMWZT?=
 =?utf-8?B?MHpXeDdFb2xwZkduS2ZENGFvSEUwU1NHT2VoTXFoa0NkSC94RnVmYlc1ekcr?=
 =?utf-8?B?K3JjSk9EM2FBQnVwelZQYjhmTTdUT0g0YXljcGZIZVBFcm1SRUtkMEQvWCtW?=
 =?utf-8?B?UzBISFZ6MEh6TFRvVE0vc2QxYmptZkc2ZHkrQzZoN3B2WDlnQXFhbWl5aUVh?=
 =?utf-8?B?MG1YV1BQcEg3RWczQW5KM3p0Um81cDdpeUdBeEdSd01CUktoeUpOSUlWejNS?=
 =?utf-8?B?LytLaXRIL3pMZ0lBaXpzTU50NWlROXUrUUc5V2dYMlcxekcrdlpCQnFxZWpt?=
 =?utf-8?B?a2RzYlVFdzViWUpVQVRaUm9UTmhGKzFPMHkxUTFLcW4ydlRRSXR5elVZYXdq?=
 =?utf-8?B?VjVOckpqUlZNcDc1N1N0c2JJcVVWbzdOUHJLUHZGbXJjV3FhZ1UyTTJBZExD?=
 =?utf-8?B?Z3ZJSDVQQXJmQmZhdHlZOWlYYzcrZWRKNTZqRUFqMklmb1EyRGJRWExuUVZR?=
 =?utf-8?B?SVRhdVlHTjNIdjdTcVlRSWErY0dMV21ReVZyeURpQ2o4RWlxL0RPOFJKRmhD?=
 =?utf-8?B?TTd4MTVYbkc0VGZCQk9yWnR2bXdmOW1kMk10TnNic1NpMTlsNm9lVVpKR09H?=
 =?utf-8?B?NkdqWktiWFBnVEdyalR4cnhvNTE3aDl6Z1Q3QzNXMlRVQjlHVXZhb0hmbDN0?=
 =?utf-8?B?VEVSZmRwUlpzWkt1cUpwbVZGYzZKSDZ1VnNSMGsxdzNoclBRTXNELy9KNUor?=
 =?utf-8?B?eGhBODdYc2w0K3d0cit3RjVKandxWitORUhQWFB4S3pBNkRhbHhGYy9oV3Fw?=
 =?utf-8?B?bWdhcUhYVGE2dk9yenExWU9md2RvdUs2SWRvd09ra1lkKzhmZzRCQ1RwQ09J?=
 =?utf-8?B?VFVFZ2NBQlplL1hGVE13cGlySW4rUno0N0VDSG9EUmxrU2lMbEs5OWtVRitH?=
 =?utf-8?B?a01ySk12R0hKU1prcDArK2NQN1hkcUhZcmpLdTF0bUdmcFdkSnRnRW9PeVFV?=
 =?utf-8?B?eUhRRWpkOGdHeGQ0bDRvV1RYZWJzK214TnU0TDdqSUhYSVZJOWM5QTVweVov?=
 =?utf-8?B?cjNkTzZwN0ppUWRxVTNFNGVmSjUzUThmOFVFTks4bGhtUUVEemljSjg4eVRP?=
 =?utf-8?B?Q2M2NXNHc3M4NUp2UEd5ek10NEg4MXFEcVdCTVhodzFjS2ZocUVwT2l5QkpH?=
 =?utf-8?B?Nk9BME9pTGlaMXYxbmlPcndWZHRmOCt2UHUxRmJLQ0tJY2VWU3JNcDJ0bElM?=
 =?utf-8?B?dFh0d2krZmt4MjFZOEZ2dkV0Yk1iVXQ3cHg2QktodFk2RmdhSFBTQ3lxVzFj?=
 =?utf-8?B?V205aTBaN01VdlRmdjZON09iL2RUMHVxVCtKcHp1bldpbUR3cU01VmJRckVm?=
 =?utf-8?B?Y0ZNa3ZzdzU3YlFjT3JDNXRIbVFrMHZBTjR6elVhUm5ScVRVSktKditSYi9s?=
 =?utf-8?B?SXhmTzI0Z0ozQ09EY1h5b0orMUE3U0tZL2pRc0ZlOVcycTBMN1JyV0t3eGUz?=
 =?utf-8?B?OXhzSHRCVHl1dnhvUG1EQndkNnIzRHJjckttUDduWlpGaU5jSDk2ZUljRUNN?=
 =?utf-8?B?SVIxSzdleDNLWUVBeXdmSDN5Y3ZDNVE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmpkR25nQ2JXcXhROGc3bmxqRjBrYkc5Q3h4Qkt0Y1htTjBHWmhOaGt1Q2RE?=
 =?utf-8?B?QjFkbml5WjZPTEhmRU9KTldjdUpBcVZlR3FaTXZ4M1ZnemFNd2FSSzZqb2xw?=
 =?utf-8?B?RTJDZDRLZjNOcFcrY1RnNkdTOGpBdmdKbHdneW9XSWF2TlA4aUJHQ2tPZ3Jn?=
 =?utf-8?B?S1dpanBRTDFZZXJxS0tJbmt5eDdnUUZnbG1yMlJ5bzJPMkhWRVRudGJCMkpN?=
 =?utf-8?B?L3I1UmlzdGliQUtwRXVLaHpzYzJ3ZEZaQlBHK1NPTnRRa2Z2M2o2VWl5MFFi?=
 =?utf-8?B?Q0VmanhzV3FCRHZvLzRIcW1rTklncUJyb0ErUzkvZVFVeTkybXNrOU1EeHVu?=
 =?utf-8?B?Q0xOVE9kQ1NPRVBmbDhoNGNpNVpBUFdReUVxQWNGYjZCcVhXd2VHZXNyMERS?=
 =?utf-8?B?THRWZTRqTTlyajQ4Rm1BL1VvVllaRlkybC9LU21RNXRlbkxtTWJTUGlqS2ZJ?=
 =?utf-8?B?bUNPOVpPUzlZTnVqTWhwcGthVDhyN3g2SmlZdW5ENXYxWjZxM0lGUjZYa2pI?=
 =?utf-8?B?RjcwVFJ1d0FpWU9PV1hqSi9xK3Y4UGpyU3ljdXQydkVHZGJqWnE1YUZaRFRy?=
 =?utf-8?B?R0xhVFJtSGFKZ1FvK2dqclY0K1IvV3BpYjdTNVIxN1RaUjVpeHRSYzg5NXJS?=
 =?utf-8?B?YTV2SjlSQ1dQZngvUjhrdWJPRkdCOUdiQUJJb1JHNUE3Wjg3WFVWYUs1YUlm?=
 =?utf-8?B?cHZrK1ZmNDAwNGlLcXJYSzNrY3hDSGk3QnhIb2FUdzNBMndXbnRsQ3JmOXZs?=
 =?utf-8?B?cyt3WlVqTXg5Z2Q1NEtQWkpzaVVWYmx4bzRMSlp2R1JFdTdYRlM1THBISklL?=
 =?utf-8?B?ZG1vNlMrUmY4QjVmc05GUEFuVE5ITlltSkFvZ0NOeGhSMGs1OUZjWmVkSjZt?=
 =?utf-8?B?NktmQ1Y5azdZNW50NVo0cFdENDhMOW1BVW9QT3A0UUVaVUhxUkxpM0VpUFdX?=
 =?utf-8?B?T0ZSekNMOHREN3JNUllYelRKamNjNzljUlUvL3FwVGsrdC9iRnNyUHpFMTRI?=
 =?utf-8?B?RmJLWmNzaEYwY1l3L2ZNeWVPdnViMWoyWGVXdWRKQkZDa01WdytuYkZjWGlS?=
 =?utf-8?B?aGFYWW9OMTJLSHQwOEVULzZBZTV1RXp6amE3MkdEZG1jUVRlcDV3RnpzZENS?=
 =?utf-8?B?QzFyTW96eWUwSWd6QVRTcDY2b0FyMjFvbzRLU0JYcGpCQTBzQjdaTWZPOHVk?=
 =?utf-8?B?RFBJd3d6K25Nbzc2cERKSTlpWGlKelJKMWt5RHErTmhKc2NpbWtiZnplcUJH?=
 =?utf-8?B?a3dTcGVhOUpzMXEzK0ZNaWFia3ZDNW54OEhNSkM4U01hWE1lVi9KbkJRVE05?=
 =?utf-8?B?ZXpicDViQ2xoMVl6NERNT1dtbmxMWjNMeTFvYmVkQ0g5TUNpQWhJTFB3UURx?=
 =?utf-8?B?Z0ZFVmpXNDNrU3ZwcGVzWXZrdmNvRmxxVCtYMFNQSGhsN2dacDY3ZTJIUzQy?=
 =?utf-8?B?bzhibWl4cVhuTjhBVVRnejFMQ1A4U1plN0RmcXBvRHZYSlV1R3pUdVRmWkhv?=
 =?utf-8?B?K3UzcDIyNC9hcHEyVHZUQitLRzROMytvSGNRWDR5eURGMXQzaTRrbm5vZy9Z?=
 =?utf-8?B?NklScTVIY1o4cStmZVR1VmRubmZOeXl1enVrVTBRN21EblNEY0VsNmxEYkZT?=
 =?utf-8?B?VUtEZXlwYWR0dlhkSDVlaFZkTzZuNlk4bWk4WDhKVU9tQy9UUStTc3VZbE8w?=
 =?utf-8?B?MzNROVVocjhaRS9zWXJ4SWF4aTlkNm5ZeHJPVnZkWjN4UUVPRmZQVVkxL1dV?=
 =?utf-8?Q?PWP2MPIQ8WtvEWo4oA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4649c59f-05e6-4036-de2e-08dd581446c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 16:23:46.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8104

DQoNCj4gT24gMjggRmViIDIwMjUsIGF0IDk6MjnigK9QTSwgUGV0ciBNbGFkZWsgPHBtbGFkZWtA
c3VzZS5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gVGh1IDIwMjUtMDItMjcgMDY6MzA6NDgsIEFk
aXR5YSBHYXJnIHdyb3RlOg0KPj4gRnJvbTogSGVjdG9yIE1hcnRpbiA8bWFyY2FuQG1hcmNhbi5z
dD4NCj4+IA0KPj4gJXA0Y2MgaXMgZGVzaWduZWQgZm9yIERSTS9WNEwyIEZPVVJDQ3Mgd2l0aCB0
aGVpciBzcGVjaWZpYyBxdWlya3MsIGJ1dA0KPj4gaXQncyB1c2VmdWwgdG8gYmUgYWJsZSB0byBw
cmludCBnZW5lcmljIDQtY2hhcmFjdGVyIGNvZGVzIGZvcm1hdHRlZCBhcw0KPj4gYW4gaW50ZWdl
ci4gRXh0ZW5kIGl0IHRvIGFkZCBmb3JtYXQgc3BlY2lmaWVycyBmb3IgcHJpbnRpbmcgZ2VuZXJp
Yw0KPj4gMzItYml0IEZPVVJDQ3Mgd2l0aCB2YXJpb3VzIGVuZGlhbiBzZW1hbnRpY3M6DQo+PiAN
Cj4+ICVwNGNoICAgSG9zdC1lbmRpYW4NCj4+ICVwNGNsICAgIExpdHRsZS1lbmRpYW4NCj4+ICVw
NGNiICAgIEJpZy1lbmRpYW4NCj4+ICVwNGNyICAgIFJldmVyc2UtZW5kaWFuDQo+PiANCj4+IFRo
ZSBlbmRpYW5uZXNzIGRldGVybWluZXMgaG93IGJ5dGVzIGFyZSBpbnRlcnByZXRlZCBhcyBhIHUz
MiwgYW5kIHRoZQ0KPj4gRk9VUkNDIGlzIHRoZW4gYWx3YXlzIHByaW50ZWQgTVNCeXRlLWZpcnN0
ICh0aGlzIGlzIHRoZSBvcHBvc2l0ZSBvZg0KPj4gVjRML0RSTSBGT1VSQ0NzKS4gVGhpcyBjb3Zl
cnMgbW9zdCBwcmFjdGljYWwgY2FzZXMsIGUuZy4gJXA0Y3Igd291bGQNCj4+IGFsbG93IHByaW50
aW5nIExTQnl0ZS1maXJzdCBGT1VSQ0NzIHN0b3JlZCBpbiBob3N0IGVuZGlhbiBvcmRlcg0KPj4g
KG90aGVyIHRoYW4gdGhlIGhleCBmb3JtIGJlaW5nIGluIGNoYXJhY3RlciBvcmRlciwgbm90IHRo
ZSBpbnRlZ2VyDQo+PiB2YWx1ZSkuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEhlY3RvciBNYXJ0
aW4gPG1hcmNhbkBtYXJjYW4uc3Q+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2Fy
Z2FkaXR5YTA4QGxpdmUuY29tPg0KPj4gDQo+IA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9jb3Jl
LWFwaS9wcmludGstZm9ybWF0cy5yc3QNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vY29yZS1hcGkv
cHJpbnRrLWZvcm1hdHMucnN0DQo+PiBAQCAtNjQ4LDYgKzY0OCwzOCBAQCBFeGFtcGxlczo6DQo+
PiAgICAlcDRjYyAgICBZMTAgIGxpdHRsZS1lbmRpYW4gKDB4MjAzMDMxNTkpDQo+PiAgICAlcDRj
YyAgICBOVjEyIGJpZy1lbmRpYW4gKDB4YjIzMTU2NGUpDQo+PiANCj4+ICtHZW5lcmljIEZvdXJD
QyBjb2RlDQo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gKw0KPj4gKzo6DQo+PiArICAgICVw
NGNbaHJibF0gICAgZ1AwMCAoMHg2NzUwMzAzMCkNCj4+ICsNCj4+ICtQcmludCBhIGdlbmVyaWMg
Rm91ckNDIGNvZGUsIGFzIGJvdGggQVNDSUkgY2hhcmFjdGVycyBhbmQgaXRzIG51bWVyaWNhbA0K
Pj4gK3ZhbHVlIGFzIGhleGFkZWNpbWFsLg0KPj4gKw0KPj4gK1RoZSBhZGRpdGlvbmFsIGBgaGBg
LCBgYHJgYCwgYGBiYGAsIGFuZCBgYGxgYCBzcGVjaWZpZXJzIGFyZSB1c2VkIHRvIHNwZWNpZnkN
Cj4+ICtob3N0LCByZXZlcnNlZCwgYmlnIG9yIGxpdHRsZSBlbmRpYW4gb3JkZXIgZGF0YSByZXNw
ZWN0aXZlbHkuIEhvc3QgZW5kaWFuDQo+PiArb3JkZXIgbWVhbnMgdGhlIGRhdGEgaXMgaW50ZXJw
cmV0ZWQgYXMgYSAzMi1iaXQgaW50ZWdlciBhbmQgdGhlIG1vc3QNCj4+ICtzaWduaWZpY2FudCBi
eXRlIGlzIHByaW50ZWQgZmlyc3Q7IHRoYXQgaXMsIHRoZSBjaGFyYWN0ZXIgY29kZSBhcyBwcmlu
dGVkDQo+PiArbWF0Y2hlcyB0aGUgYnl0ZSBvcmRlciBzdG9yZWQgaW4gbWVtb3J5IG9uIGJpZy1l
bmRpYW4gc3lzdGVtcywgYW5kIGlzIHJldmVyc2VkDQo+PiArb24gbGl0dGxlLWVuZGlhbiBzeXN0
ZW1zLg0KPiANCj4gSSBhbSBhIGJpdCBjb25mdXNlZCBieSB0aGUgZGVzY3JpcHRpb24gbGlrZSBJ
IHdhcyBpbiB0aGUgcGFzdCwgc2VlDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvWTN6aGhM
b3FBT2FaN3JNekBhbGxleSAgOy0pDQo+IA0KPiBJIHdvbmRlciBpZiB0aGUgZm9sbG93aW5nIHNv
dW5kcyBiZXR0ZXI6DQo+IA0KPiA8cHJvcG9zYT4NCj4gUHJpbnQgYSBnZW5lcmljIEZvdXJDQyBj
b2RlLCBhcyBib3RoIEFTQ0lJIGNoYXJhY3RlcnMgYW5kIGl0cyBudW1lcmljYWwNCj4gdmFsdWUg
YXMgaGV4YWRlY2ltYWwuDQo+IA0KPiBUaGUgZ2VuZXJpYyBGb3VyQ0MgY29kZSBpcyBhbHdheXMg
cHJpbnRlZCBpbiB0aGUgdGhlIGJpZy1lbmRpYW4gZm9ybWF0LA0KPiB0aGUgbW9zdCBzaWduaWZp
Y2FudCBieXRlIGZpcnN0LiBUaGlzIGlzIHRoZSBvcHBvc2l0ZSBvZiBWNEwvRFJNDQo+IEZPVVJD
Q3MuDQo+IA0KPiBUaGUgYWRkaXRpb25hbCBgYGhgYCwgYGByYGAsIGBgYmBgLCBhbmQgYGBsYGAg
c3BlY2lmaWVycyBkZWZpbmUgd2hhdA0KPiBlbmRpYW5lcyBpcyB1c2VkIHRvIGxvYWQgdGhlIHN0
b3JlZCBieXRlcy4gVGhlIGRhdGEgbWlnaHQgYmUgaW50ZXJwcmV0ZWQNCj4gdXNpbmcgdGhlIGhv
c3QtZW5kaWFuLCByZXZlcnNlLWhvc3QtZW5kaWFuLCBiaWctZW5kaWFuLCBvciBsaXR0bGUgZW5k
aWFuLg0KPiA8L3Byb3Bvc2FsPg0KDQpEZWZpbml0ZWx5IG11Y2ggY2xlYXIuDQo+IA0KPj4gK1Bh
c3NlZCBieSByZWZlcmVuY2UuDQo+PiArDQo+PiArRXhhbXBsZXMgZm9yIGEgbGl0dGxlLWVuZGlh
biBtYWNoaW5lLCBnaXZlbiAmKHUzMikweDY3NTAzMDMwOjoNCj4+ICsNCj4+ICsgICAgJXA0Y2gg
ICAgZ1AwMCAoMHg2NzUwMzAzMCkNCj4+ICsgICAgJXA0Y3IgICAgMDBQZyAoMHgzMDMwNTA2NykN
Cj4+ICsgICAgJXA0Y2IgICAgMDBQZyAoMHgzMDMwNTA2NykNCj4+ICsgICAgJXA0Y2wgICAgZ1Aw
MCAoMHg2NzUwMzAzMCkNCj4+ICsNCj4+ICtFeGFtcGxlcyBmb3IgYSBiaWctZW5kaWFuIG1hY2hp
bmUsIGdpdmVuICYodTMyKTB4Njc1MDMwMzA6Og0KPj4gKw0KPj4gKyAgICAlcDRjaCAgICBnUDAw
ICgweDY3NTAzMDMwKQ0KPj4gKyAgICAlcDRjciAgICAwMFBnICgweDMwMzA1MDY3KQ0KPj4gKyAg
ICAlcDRjYiAgICBnUDAwICgweDY3NTAzMDMwKQ0KPj4gKyAgICAlcDRjbCAgICAwMFBnICgweDMw
MzA1MDY3KQ0KPj4gKw0KPj4gUnVzdA0KPiANCj4gVGhlIHBhdGNoIGhhcyBiZWVuIG1hbGZvcm1l
ZC4gSSBndWVzcyB0aGF0IHlvdXIgbWFpbCBjbGllbnQNCj4gcmVtb3ZlZCBzcGFjZXMgYXQgdGhl
IGJlZ2lubmluZyBvZiBzb21lIGxpbmVzLg0KDQpJIGR1bm5vIHdoYXQgd3JvbmcsIGFueXdheXMg
SSdsbCBzZW5kIGEgdjUgc28gd2lsbCBtYWtlIHN1cmUgdGhpbmdzIGdvIHJpZ2h0Lg0KPiANCj4+
IC0tLS0NCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2xpYi90ZXN0X3ByaW50Zi5jIGIvbGliL3Rlc3Rf
cHJpbnRmLmMNCj4+IGluZGV4IDU5ZGJlNGY5YS4uMDU2OTI5YzA2IDEwMDY0NA0KPj4gLS0tIGEv
bGliL3Rlc3RfcHJpbnRmLmMNCj4+ICsrKyBiL2xpYi90ZXN0X3ByaW50Zi5jDQo+PiBAQCAtNzc2
LDIxICs3NzYsNDYgQEAgc3RhdGljIHZvaWQgX19pbml0IGZ3bm9kZV9wb2ludGVyKHZvaWQpDQo+
PiAgICBzb2Z0d2FyZV9ub2RlX3VucmVnaXN0ZXJfbm9kZV9ncm91cChncm91cCk7DQo+PiB9DQo+
PiANCj4+ICtzdHJ1Y3QgZm91cmNjX3N0cnVjdCB7DQo+PiArICAgIHUzMiBjb2RlOw0KPj4gKyAg
ICBjb25zdCBjaGFyICpzdHI7DQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBfX2luaXQg
Zm91cmNjX3BvaW50ZXJfdGVzdChjb25zdCBzdHJ1Y3QgZm91cmNjX3N0cnVjdCAqZmMsIHNpemVf
dCBuLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqZm10KQ0KPj4gK3sN
Cj4+ICsgICAgc2l6ZV90IGk7DQo+PiArDQo+PiArICAgIGZvciAoaSA9IDA7IGkgPCBuOyBpKysp
DQo+PiArICAgICAgICB0ZXN0KGZjW2ldLnN0ciwgZm10LCAmZmNbaV0uY29kZSk7DQo+PiArfQ0K
Pj4gKw0KPj4gc3RhdGljIHZvaWQgX19pbml0IGZvdXJjY19wb2ludGVyKHZvaWQpDQo+PiB7DQo+
PiAtICAgIHN0cnVjdCB7DQo+PiAtICAgICAgICB1MzIgY29kZTsNCj4+IC0gICAgICAgIGNoYXIg
KnN0cjsNCj4+IC0gICAgfSBjb25zdCB0cnlbXSA9IHsNCj4+ICsgICAgc3RhdGljIGNvbnN0IHN0
cnVjdCBmb3VyY2Nfc3RydWN0IHRyeV9jY1tdID0gew0KPj4gICAgICAgIHsgMHgzMjMxNTY0ZSwg
Ik5WMTIgbGl0dGxlLWVuZGlhbiAoMHgzMjMxNTY0ZSkiLCB9LA0KPj4gICAgICAgIHsgMHhiMjMx
NTY0ZSwgIk5WMTIgYmlnLWVuZGlhbiAoMHhiMjMxNTY0ZSkiLCB9LA0KPj4gICAgICAgIHsgMHgx
MDExMTIxMywgIi4uLi4gbGl0dGxlLWVuZGlhbiAoMHgxMDExMTIxMykiLCB9LA0KPj4gICAgICAg
IHsgMHgyMDMwMzE1OSwgIlkxMCAgbGl0dGxlLWVuZGlhbiAoMHgyMDMwMzE1OSkiLCB9LA0KPj4g
ICAgfTsNCj4+IC0gICAgdW5zaWduZWQgaW50IGk7DQo+PiArICAgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZm91cmNjX3N0cnVjdCB0cnlfY2ggPSB7DQo+PiArICAgICAgICAweDQxNDI0MzQ0LCAiQUJD
RCAoMHg0MTQyNDM0NCkiLA0KPj4gKyAgICB9Ow0KPj4gKyAgICBzdGF0aWMgY29uc3Qgc3RydWN0
IGZvdXJjY19zdHJ1Y3QgdHJ5X2NyID0gew0KPj4gKyAgICAgICAgMHg0MTQyNDM0NCwgIkRDQkEg
KDB4NDQ0MzQyNDEpIiwNCj4+ICsgICAgfTsNCj4+ICsgICAgc3RhdGljIGNvbnN0IHN0cnVjdCBm
b3VyY2Nfc3RydWN0IHRyeV9jbCA9IHsNCj4+ICsgICAgICAgIGxlMzJfdG9fY3B1KDB4NDE0MjQz
NDQpLCAiQUJDRCAoMHg0MTQyNDM0NCkiLA0KPj4gKyAgICB9Ow0KPj4gKyAgICBzdGF0aWMgY29u
c3Qgc3RydWN0IGZvdXJjY19zdHJ1Y3QgdHJ5X2NiID0gew0KPj4gKyAgICAgICAgYmUzMl90b19j
cHUoMHg0MTQyNDM0NCksICJBQkNEICgweDQxNDI0MzQ0KSIsDQo+PiArICAgIH07DQo+PiANCj4+
IC0gICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUodHJ5KTsgaSsrKQ0KPj4gLSAgICAgICAg
dGVzdCh0cnlbaV0uc3RyLCAiJXA0Y2MiLCAmdHJ5W2ldLmNvZGUpOw0KPj4gKyAgICBmb3VyY2Nf
cG9pbnRlcl90ZXN0KHRyeV9jYywgQVJSQVlfU0laRSh0cnlfY2MpLCAiJXA0Y2MiKTsNCj4+ICsg
ICAgZm91cmNjX3BvaW50ZXJfdGVzdCgmdHJ5X2NoLCAxLCAiJXA0Y2giKTsNCj4+ICsgICAgZm91
cmNjX3BvaW50ZXJfdGVzdCgmdHJ5X2NyLCAxLCAiJXA0Y3IiKTsNCj4+ICsgICAgZm91cmNjX3Bv
aW50ZXJfdGVzdCgmdHJ5X2NsLCAxLCAiJXA0Y2wiKTsNCj4+ICsgICAgZm91cmNjX3BvaW50ZXJf
dGVzdCgmdHJ5X2NiLCAxLCAiJXA0Y2IiKTsNCj4gDQo+IE5pdDogSSB3b3VsZCB1c2UgQVJSQVlf
U0laRSgpIGluc3RlYWQgb2YgdGhlIGhhcmRjb2RlZCAxIGluIGFsbCBjYXNlcy4NCj4gICAgIEJ1
dCBpdCBtaWdodCBiZSBhIG1hdHRlciBvZiB0YXN0ZS4NCg0KSSdsbCBtYWtlIHRoYXQgY2hhbmdl
DQo+IA0KPj4gfQ0KPj4gDQo+IA0KPiBPdGhlcndpc2UsIGl0IGxvb2tzIGdvb2QgdG8gbWUuDQo+
IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IFBldHINCg==

