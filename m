Return-Path: <linux-kernel+bounces-221258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C590F0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B30286239
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C28F22611;
	Wed, 19 Jun 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qMs12YL5"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2145.outbound.protection.outlook.com [40.92.62.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A981CD15;
	Wed, 19 Jun 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718808035; cv=fail; b=PYN5bUXMiKs7/Mvo9aruW5cfNdpXaqb0t4yMhDRbY9oI54KYJaCQF709yWSCsEzC75hxuWIvdqSREIsavUFKUv7RQToYXRYmNyjlkdrGuHVR9gDwt50QTOR1PtrCTHNM+WiModMMSz8wDT7qAbbC4gY+1FIqsozZg9evqc2UWXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718808035; c=relaxed/simple;
	bh=mEZEZxulfUI2rn7pDIkdbIuFDifLhe6CxBBNqiq6iDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rjJN5V1aZz5DEJEyNihXHdvrkISyZNaxjYwPW3W1S5z+e294wpOU+y3xNJKXDwCaZ9DmEtzJ+sSlEWr6k8urv9XcPAEUptJznD5dD5EHvLWxEQcZF2v8BAwRF3W2WnW1lajystMkHaRiEg2/k9560UQhTOiHWvxJERe2kLRJpNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qMs12YL5; arc=fail smtp.client-ip=40.92.62.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJbfBqsvHh6BaONW+pb7q2PELbOoik5UYpkpULSWZpgoX7eSUBtMl5x4PW0PeR3eGk3d1vKXWz2+6Ip3aazYCNo33P8s/dtwM+tFkpyO+UeogD0fvMzvbBQBux+qy+dmqahDGwCGl6+fjgFQfg/fTSFd9cSFVraffmIVVtBBTx5e6QCWeWWBLlLSoBCxJbvxmwVVV8dg7WMfFdunru2qzSRcErEVlBigeLijGye9+Hs9KP4v/8L/1YIWAHSHVoa/aa4lwJx40dNI9Nkyj5Z6pMlZLbQAD9OoalE4yA8pkCjvdAOIIOsL/cpUzweDwvTcIkvD/f3/3emmDpF2H0eR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEZEZxulfUI2rn7pDIkdbIuFDifLhe6CxBBNqiq6iDk=;
 b=PhKj78MYq9MsDv+hWm+1fec2pxySEIl+LwWYpO/f8iURCwetC/+jgmEIcok5BaA//yRJe8SvTkIG+D9xH9HvZf8s4xO8xSsOfipsXfHIpxZ9XiAoE35pnF3FLAL+D3jVA4/5Aw9pDhvOfONDwV79QAb2fTcO+7E1XEdt2cfjyGsN8S7h/JHMbp8oNo9ZzDWfffDiN5aFvTmErr8LslPLcGxnIU29iTSD+g9LK7lmPCg1ofFJBswqWUdnVjHn2pMV+GC+W6EHDoVrhZ/ekOALlWY66C4eUSOwhQg1iwPgeqLTbM973/yzT09cMB90IuwC0qJN5FTe/Nq0Fn+kHYYbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEZEZxulfUI2rn7pDIkdbIuFDifLhe6CxBBNqiq6iDk=;
 b=qMs12YL50PJlFuZ7j2rMprKrWnVmYjhftlG4VPLcqGxrb8IRt3b3R8XPRMsllxbDtMedLxWljhu9gUjpkLzTO5iAztjK/REFH7v5HaH5WE9TwZIMpRVRY3FQLBh6wsN1l7kICwZ0rwIBjHS48vGxmcmM/SpTpModXXQnlzdZPAjMYjagDko+3uX+MzaLxg9vkhZD3JWnfoSnpTvfRz2hafnFIwbYZFlecLRyKHCzfRLNE59TNyLyKs5MMOTkxezmxjSOXdd3jA9t5ZqUJzjHkLbVRboSVWLGURO2UpTvdGmf6fUTCzDx93yHFhqYqYg0Shq10MFdgJIfJxNG1iKiWg==
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:9b::8) by
 ME3P282MB1602.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 14:40:28 +0000
Received: from SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3]) by SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
 ([fe80::ac24:7d2b:92fe:20c3%2]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 14:40:28 +0000
From: =?utf-8?B?6Z+15rabIOS7ow==?= <d1581209858@live.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Inochi Amaoto <inochiama@outlook.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Thread-Topic: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Thread-Index: AQHawZIDXpA1fvG1y0K0Pqnnh8DDpbHNvRcAgAFrtDw=
Date: Wed, 19 Jun 2024 14:40:28 +0000
Message-ID:
 <SYBP282MB223856F82B67BBC4C94A9072C4CF2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
References:
 <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <171872963677.3062707.7560457462678270333.robh@kernel.org>
In-Reply-To: <171872963677.3062707.7560457462678270333.robh@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [2GXrTZ8ERgjnflUvsGy57chpERrFAhkO]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBP282MB2238:EE_|ME3P282MB1602:EE_
x-ms-office365-filtering-correlation-id: 22abd656-6657-468d-f023-08dc906dc35b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|1602099009|440099025|4302099010|3412199022|102099029;
x-microsoft-antispam-message-info:
 9QdVMJwicEcP3f3QzKh7MDi0d74ZUlcmPsYb38KYwQo8mCYvtdOysh9Ps/geNwC0+JrsV7dVbR8JextnP7AGE2fRuWtcfSmTUX4EsOWZoHjnoSk5M6NtEstbrOCpEhuFxVwMSqkiGHXa3reqTesaC9JcC8H51J6DhuQvZDGlbaIJhdrl+Cuw5moxzA5TswSarCw+4CPubQtXS03T5z5J5MijDQSXcw3UgxNqNOlX6Ip0s/c1SylF9B7f4MhEupZTPzMgoEDNFBxNTFk0CYKsArux5i/iCv5SRwck9pSwILxeMAwYxUpj7O+d+ypTQ166M+u4J8cPcDxPFavA709IHxpvQGelMn6U9wlYlwpqfm7wM9qpKpwv2Mzz/tGEuypMf9zXLStCBJcPKnn6j7OB2wbvOPSgl1a+gfdL3mq8voSJzm4vS9hjCB5fN1WctmL9vkVE1ZnOsnFtqzrpNuJQy27HhaJnt4+OQiyDHEck3RZtqavMIrpQi419J1WBkA8RmoC8DZrjzC8STeWIw0SzKcXqp9+tD0H4DRG9Rwd5bzqprG5J5VHv7rrMjS/dPa25uDbpqWfys3vIs6B8Wq+LnUsyidfd0oGQnzXFUptr+6ijdqmmtTDSIEu3nlrvZmq0Vz+N7rQNPdFlLSHKPJsxdzL8DbwxbvKBmmggQN42OiucRM/kgzc6VCOKGDY+YGif
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDNCOFRFN21RblFlM0piQlFnZXZEWGthbi9DdWtSdmpHMHM3NWhUc1ltNmgw?=
 =?utf-8?B?dGpabVUzd2NtR2E1UmFheHVyWUttTUcrS3VOZSszRERVWWYwZmI1OGhlNXZS?=
 =?utf-8?B?N2VBYms2OHJtZ0RsaXBMc0NZbXNVd01iNW11b1hrNkM2TktIem5kdmtFT2kz?=
 =?utf-8?B?b0JrRmlxNGhjaFdHZG1NU2dUbGp0cmZ3WENnL2lXYU5pTTRoREE3aEExaGRU?=
 =?utf-8?B?bmYydFRxa3JhWTJ2YTNxYVF2OEUwMnM2aUNpK0dFd25pQi9WTVV6bmZqL3J5?=
 =?utf-8?B?Zm56SFFqZlhobTV3M1BSNXdBbDJtWEl4Y1JTU1BkajIrblM4UVZVODY0bVox?=
 =?utf-8?B?NEVuQzlTOWN6ZnVFQzdSTk1vVmZhOHpNb3J1T1M2MzFkMzVqZzJUaG9RSWJ4?=
 =?utf-8?B?cWtHOG1GREVhNFpERWpySWZINmhHNytuSlF3RldwdkhFWU5DT1haR2IvRUx4?=
 =?utf-8?B?cW5BYW5SUnk0T1RsUDVFQys3cHhwR2R5SVAyNUIySzkvc2RybEcrY1BJbDU5?=
 =?utf-8?B?aUVvaFV5VFROVy85a1U4dVIrUDg0Y3MyQm5pdjJMK0R0a1ROMExCTFdIYVFq?=
 =?utf-8?B?ZlN6YkYyUjZuYmJ2c3BHM0xXM0h2ZkplYVZIZDIrb0hqclczOGJrTjJKRnZz?=
 =?utf-8?B?THFFbmZ5MFdPR3Qrb0greHFzYjF3cTNnVFpLWk1PL243Wm5JRU04bVVaY1Ba?=
 =?utf-8?B?NFdXeWUxTlNEUm4xYUtoVGtsQVhJZGhCWm1KYkM2Q09nR2FrSE5FQkhyU3gx?=
 =?utf-8?B?OTNZcXhKa0txL1RoY2FqL1B0aVlrNGFicThqMlY3RDkyWFlRS1lZTEZCcit5?=
 =?utf-8?B?a1VpOHBieDNJR1NwNlhFRTMyWk8rVnJ5azNBVllCU0hsM0tnMFBaQnV4eHZs?=
 =?utf-8?B?eGxWVUxuOFZFZXpOV09LWm1pdXJPMmhwK0U0bnc3SkZJMms2MTVURzZ1ditC?=
 =?utf-8?B?ZktZekN5RDlhdUgxN08xZmhSY1Q2Q2JOdlNmb3hwKzZUazBGZFpyTWFWanUz?=
 =?utf-8?B?SlNWaUJwUEFLZmJUcy81TkI4c1BFelc2NzJYaXZDcmczbk5Hc1Y0dWZHY09X?=
 =?utf-8?B?dkJlRHhNMnJ4bHpheEwwdFFKR0Z4bFYxdGIvcnJwZ1ZZYzI0ZUgxUE5oeHNx?=
 =?utf-8?B?TWdBdnFDUGp6YTM0WUN4MlJ6ckQ2dnlxZVlDNDVxdVIwUXNOOGJnQTNMTWMz?=
 =?utf-8?B?eVRvbzJ3SDJkVitUSjZ1NVg0dnNIMjVXYVBsWkZaQU14YmtFdU9ZTCtsQ0tG?=
 =?utf-8?B?aFRyQWYyRXpTdEVDTXVjcitHZ3hSQnJyb2hqSmNIbzdvOVBnTzJ4eUx0MHlv?=
 =?utf-8?B?SVp6ejJXbGJYdk05VExwNytWOG1najlHNFRJVzZaeUN2RFdkZnhvRVpKOUt2?=
 =?utf-8?B?ZHFSc2FOMkhUck9GQTRQUGhkanBsdjdRVUtuNk1XaE1oQkJzTGlvWkZwTGtL?=
 =?utf-8?B?SHgyNGhwaCt6bUdBVmFTT1RpZng0cnVqeVU2UU1pdVJjTWl6NS9YVmFMRjlL?=
 =?utf-8?B?Z3FVZ2Nzb1M3bi9QYlAzU0tRS1lqUGplbWFUM2NOMWVtQjR3N0lGMFB4a3dW?=
 =?utf-8?B?RWkvUEw1TjlQUVJMQ3IyTVhVemJ1V2x1L1FXMTNWUGpZa1FHaHVkUER0R3F3?=
 =?utf-8?Q?1BuJwfrV8Rs464v29QxSq3KDbCZm1MNsUGWARL0gMaCw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 22abd656-6657-468d-f023-08dc906dc35b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 14:40:28.2920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1602

SGkgUm9iLAoKPiBPbiBUdWUsIDE4IEp1biAyMDI0IDIzOjEyOjMzICswODAwLCBZdW50YW8gRGFp
IHdyb3RlOgo+ID4gQWRkIGRldmljZXRyZWUgYmluZGluZ3MgZG9jdW1lbnRhdGlvbiBmb3IgU29w
aGdvIGN2MTh4IFNvQ3MgbWFpbGJveAo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bnRhbyBEYWkg
PGQxNTgxMjA5ODU4QGxpdmUuY29tPgo+ID4gLS0tCj4gPsKgIC4uLi9tYWlsYm94L3NvcGhnbyxj
djE4MDBiLW1haWxib3gueWFtbMKgwqDCoMKgwqDCoCB8IDc1ICsrKysrKysrKysrKysrKysrKysK
PiA+wqAgMSBmaWxlIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykKPiA+wqAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L3NvcGhnbyxj
djE4MDBiLW1haWxib3gueWFtbAo+ID4KPiAKPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcg
J21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoKPiAKPiB5YW1sbGludCB3YXJu
aW5ncy9lcnJvcnM6Cj4gCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoKPiAvYnVpbGRz
L3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9tYWlsYm94L3NvcGhnbyxjdjE4MDBiLW1haWxib3gueWFtbDogcmVjdmlkOiBtaXNz
aW5nIHR5cGUgZGVmaW5pdGlvbgo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kvbGlu
dXgvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvc29waGdvLGN2MTgw
MGItbWFpbGJveC55YW1sOiBzZW5kdG86IG1pc3NpbmcgdHlwZSBkZWZpbml0aW9uCj4gCj4gZG9j
IHJlZmVyZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2NzKToKPiAKPiBTZWUgaHR0cHM6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0Y2gvU1lC
UDI4Mk1CMjIzODlGRDFFMDdCQkRDNkZFMUQ5MEEwQzRDRTJAU1lCUDI4Mk1CMjIzOC5BVVNQMjgy
LlBST0QuT1VUTE9PSy5DT00KCnRoYW5rcyB5b3VyIGFkdmljZSwgSSB3aWxsIHRyeSB1cGdyYWRl
IHRoZXNlIHRvb2xzIGFuZCBmaXggaXQKCkJlc3QgcmVnYXJkcywKWXVudGFv

