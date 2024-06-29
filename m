Return-Path: <linux-kernel+bounces-234899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C53491CC30
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 12:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9A91F22350
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3744C93;
	Sat, 29 Jun 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="TSAhW1qz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2056.outbound.protection.outlook.com [40.92.40.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9D2262B
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719658460; cv=fail; b=A4jdbjqNfpGpl63dTO+U0aJVZ2+tnv8btUa/8pe1z3JsOolcBE5oXuEZofljQUe/PnQWahTVO/QzpWp+YUxjI5hApVvSutapEVa82wu/l1c5PV2rfHd85CaAjx5YvnlMvhwoRAdM9UOvmewFTSBqu3QcPAlvJVL1MgVmMuDJAx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719658460; c=relaxed/simple;
	bh=Rf0ZgjPhne7eYh5c4WnW113R6mPOZr2Xn7FUmmVaydg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WXpn7yU+MGa5krcF37S2jF7jWUH6j7fOxShukMOM+QRKcHq9mW2ygPP1udtjryq95IzMPFbSBhv5eKZFrIwicsCODsaonY4suO5Qip0iPd1zezUJ9cvYsRE0A4M+IL5qDmau2iTf+SsFIoHwLLo+Uzik5nwyAFzNpaEtcL/4KYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com; spf=pass smtp.mailfrom=msn.com; dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b=TSAhW1qz; arc=fail smtp.client-ip=40.92.40.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgeIXYaa2WSPzVHJ60I6wd+yG17MTW2NsRm2a5aBG0wLmq7nl3rQ2e1+NFCBN3NTtPptXknkUTTcQa9s09LgD6wUNiIOFndIsI/6+RHoEkJXgieDXQOMihtSjmplKI2GUl10dKyJzlATlhHpnb/N2tWb2y0G8j13DfiGdiI7Of1d6ada5UGLIYFB5Yut2XjnjDZAlkc8cKGVuqFnUw3fgjqcBfaq3hkm4J7m9zrXaoRfkhQnqf00y6M22MsS5SD9H2xXBbmoiFrEWc61VRVISQ3Ps6g3NwG61scYtjE9y4UO0AMllR8W1+3P9VMJJmRLSVm7VlDukiSJVMY1CIvvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf0ZgjPhne7eYh5c4WnW113R6mPOZr2Xn7FUmmVaydg=;
 b=FNyAjanAP161ux5LHBCvSvvpGvZI8wCA6TFn2/SeID3ogij5GpC5EP6ZqkB4NF4Ggy57NaMNn+c0d2CE0fCfAFU3bI9w5P+1H2j9ZqiDqpo26FCuNC8dAo3BArzU2kuaACPTit+goqRlmr6MspXDL8cGRMfV7mz3Tsr7TY01PVzQZSyiXwq1UZoapWXLUHlYW7Jb61WmJfJl9fojirxgbCyIwFGfq+c/GdTpZmBYSGWWzHgHf70kbdKsBSjyj47H/oZsJaXGKSDgPZL1duLdXVw/nLYwST3/mwgxL6dpoxsHVkbu3VgmaW1bqYCjENXHaey6V3/dSGXVmPO87lCdmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf0ZgjPhne7eYh5c4WnW113R6mPOZr2Xn7FUmmVaydg=;
 b=TSAhW1qzT+wrXxh3TqWbX+ZUFnWcAB8V4zW0O1eSPQN4cNt9VeniVCCQg/YMX81bbx29tpNhRMBpTiAWQl3yNJDXcR3mhNvgGBxAE0XiXZADvsBexIrKvw4V/3uAocMVhtU6CmcM7JZmE5qzg1O4dpD+gEVMI3sqA4kTwWQszg13GS/QUJu4igQqokC3mXtK+keRleU+Zybewb9Y3lznmpFJax+KDlbPYxVbzQk23UE/rLAtbkUQhM9RYxx5U8VVZIrKq5UhY6iFP/Bg4UXU63pqlmAsPyVPbuuov6QaqELGSUhevUfsXgfugHEykZM9n4lkTEWjnodd+DwUqORorg==
Received: from DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) by
 MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Sat, 29 Jun
 2024 10:54:15 +0000
Received: from DS0PR12MB8069.namprd12.prod.outlook.com
 ([fe80::8f22:d569:5858:3814]) by DS0PR12MB8069.namprd12.prod.outlook.com
 ([fe80::8f22:d569:5858:3814%6]) with mapi id 15.20.7698.032; Sat, 29 Jun 2024
 10:54:15 +0000
From: lin jia <chinasjtu@msn.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWgg?= <thomas@t-8ch.de>
Subject: can anyone explain the meaning of improvement of try_attach function
 in sysctl.c?
Thread-Topic: can anyone explain the meaning of improvement of try_attach
 function in sysctl.c?
Thread-Index: AQHayhKu3PVHm1trUkOvOKNk0CooKA==
Date: Sat, 29 Jun 2024 10:54:15 +0000
Message-ID:
 <DS0PR12MB80698E311887F57598680BCDB0D12@DS0PR12MB8069.namprd12.prod.outlook.com>
References:
 <DS0PR12MB8069A682100DDA71C3C97DCAB0D12@DS0PR12MB8069.namprd12.prod.outlook.com>
 <e0fc5569-6169-4c93-93c3-76f5e5844192@t-8ch.de>
In-Reply-To: <e0fc5569-6169-4c93-93c3-76f5e5844192@t-8ch.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [XnSVLe55zoBfPZlRBpz/DqUYbRlll0Ph]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8069:EE_|MW4PR12MB7358:EE_
x-ms-office365-filtering-correlation-id: 251a26b6-1c1d-4a76-e479-08dc9829d137
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 1Z+hDD7ImkZFXaDJ84WjPmbTuUfV4eElMyoBNOcA//me4YQVL2IJkZDmKjCQ3/R4dX6BDT8TlByYWjV18H0vavLtNOypY5d5VpzTWgWOSNspzZlo495aFrHMdkX+G2bX5LQ7mwWA8L0tGF8QSiXLzuaVTFmNgpZdRJDxZ7S51nE8b8F31iiTd8APzame7SAeKtuASIHayUsXlzso+2Oa3D3er9FIbKKjuK+h0B14nNHVMaaHn5z8Ik+KI8FD3U8pLqi0dbseuwc2Jj8c50EXr81mVnlfxzgRPmOCTVaxwVnWRXtxW/oXZB/50GGNVUDmmxuUoq6rlN9InaqcTPKO4LaGQEBZW+hZYelAMFD2x/4FCGENA2xtlz3HUkT4SBLXpW7IPkIJXyNs6QbLwGH/+tT1YtcHJZU8OPICxgnHMjHsctZa7LRYJVq2q6loOKloZWRf3mWwmi2ju18WhUXqDTtFpre+cSDtKZwjX5v/9xuuzLaKxbgBxOWmBgxRcJ8Vsaha+t/XzEL2qawPASjScAr+evJsNLH3kim+m8a7gr2Rm1wwdtduEth2PV78FF42Sh4ssgMFqwyJUB3rje7SyZIfrbYjQwFGMX+7bL/pM6vuyPTEHaLjsTD9SnI7fn8C
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWlIdW1lWW54VkU3WjJoVXUwWmtGMmpuNExoc0pNN1NHWFdmdHpSZkhhZjFH?=
 =?utf-8?B?RUwrZ1NzS2ZIY0dPRWFUenI2bXpIeGhNOEdhbG9wZVdJclFKNGR4NXAxVFNz?=
 =?utf-8?B?U0lYQWZiRjltTHE0aENiOXFDa1JMOGhLV2Y4WEwvS21WZUNJOFhOT0JRN1Zu?=
 =?utf-8?B?c1d0Rm5TOWdzWld4cEM3Qmc0bEtnWWRENVlsOC93VkpBcGxMZFVRU3lnRmlk?=
 =?utf-8?B?WXY5T1VZYlpIT2RZWC83SnJBOGNyaTU5NnlnclREUXQwMkptRnNzbnFxbG41?=
 =?utf-8?B?WUpOc09rUkQ4c1NrQ1hpUFBZQUVCNUQrbXVHUlhqMU15UGNrTzlNZzVCVzM1?=
 =?utf-8?B?d2FrZVBkT0ZvNi8yUUNWWVJ4VzVwaHNxck5tbERpenl2R09naUhNR1Fhai9W?=
 =?utf-8?B?TVZsMmh6N1ZKanBKY3dTVjhNNUdPeDJWZTdtNHlwVDd1KzBSNUFvdnR4ZEc3?=
 =?utf-8?B?c0ovOFB4aXZNakJSeUxFbTFSbENmcUpGOURWWFhJL3VSVVFFUDkrTEdCOGpp?=
 =?utf-8?B?NFJhdVpiNzl4RkZrWGFQWUVscnF2NGV1bkNJc0F0OStOcmJrS3lldjlUamRt?=
 =?utf-8?B?RzJrdWJCZDlmTEhLeTBCL0NwVmdCdWxWUmdVMmNaWHJOVXp3MUYva1RrQU1H?=
 =?utf-8?B?Tyt2SDdWdFNQRURiU2M4a2xuQ0FsWmVjNWRKcGZZS2hCR0pGeFh4eE5DU1Yy?=
 =?utf-8?B?REpNMVJweGE3SHJGdS9kZHJZWTNFdWNrVGwxemNJS2gxWmwwTzRnL0N1YzVH?=
 =?utf-8?B?c2JoSHBPY1ZlWklkUnkvS2xGSkgwRnBKaXVYcE1QT2xHYVpVeVc1dURlUVBJ?=
 =?utf-8?B?cTZXbmxPTE5DOTU2TnNHVGlxVXJBNVRRRTVPSnNsaXdETXhCaGlNWllDTGlI?=
 =?utf-8?B?WHNpUWk3V3BqZENYeGFFcnpsZ2JXNHU2Wm03Q0w1aHo0eHdvOUlCSXNGR1Nj?=
 =?utf-8?B?OWYwdDhOQXNuNzNRM3FwNjVZSjYySElwbEdjWXpRUVQybmdUeDRGbURBVCt3?=
 =?utf-8?B?S09CWUc4emY4RUV5OTNpcW9jV1lzQVN1bDdoam5kVDFMVnc5Rnk1cDVpUy91?=
 =?utf-8?B?ZjJNc2VJMkJZNjVkNUh3azJ5VlFEWXMyclQySFVXdlhrVU1VNWFYMFRtbU1o?=
 =?utf-8?B?cTFPcU52aDBPYWg4QkozRlBkS2l6QnRCajBFQmRFVEZXMXF0WmZzWmFqSTFP?=
 =?utf-8?B?YTdweHZWRDRoQVVsMnlxS1RzTWNaWUJ3TmFNa2h4QUgzNHdPalhVczE0aFo1?=
 =?utf-8?B?OXFJM0FRaC9LT1E3V1JrTExlUDFZc1pubTY1a0tvSk9uZGdLYVpEcWttVjRl?=
 =?utf-8?B?ekxUMnJlOTdCUDlxSzJYN1lSR2NnYkdvQzZJWlRuR2tlM1ZJREhTblhOaTFa?=
 =?utf-8?B?UlBraWRFUi95NTNXSHhGZEpxcERoYmJpbHMwRjI2MEFHOE11L1d4a3FVTDdz?=
 =?utf-8?B?ZHdlL0RyajFBQklsQTBxNnhTeVBlL0JzZHhMNE1Ybm9PSkc3anRNYzluTlRo?=
 =?utf-8?B?UkN0bnhnQUNzZ054RTEwQzVmbDNXQnF2RTFsd0ZPNkl5ejlqeFdsZXpRd1Qv?=
 =?utf-8?B?cHZVLzRtODFPek03VVdYQWZDVTdGTmtiMDluTWtqVFJ6RGJnVlExWXlhZVJk?=
 =?utf-8?B?V2dkcXRHN09TRmlSUWl2RG9oK3VTakE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 251a26b6-1c1d-4a76-e479-08dc9829d137
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2024 10:54:15.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

SGkgYWxsOg0KICAgSSd2ZSBiZWVuIHJlYWRpbmcgdGhlIHN5c2N0bCBwYXJ0IG9mIHRoZSBMaW51
eCBrZXJuZWwgc291cmNlIGNvZGUoIDMuMy44KSByZWNlbnRseSBhbmQgZW5jb3VudGVyZWQgc29t
ZSBpc3N1ZXMuIEknbSBub3Qgc3VyZSB3aG8gSSBjYW4gYXNrIGZvciBoZWxwLg0KICAgSW4gc3lz
Y3RsLmMgLCAgdGhlIGZ1bmN0aW9uIG9mIF9fcmVnaXN0ZXJfc3lzY3RsX3BhdGhzIGlzIHRvIHJl
Z2lzdGVyIGEgc3lzY3RsIGhpZXJhcmNoeSwgIEkgYW0gY29uZnVzZWQgYnkgdGhlIGZ1bmN0aW9u
ICIgdHJ5X2F0dGFjaCIsIA0KDQovKiBzZWUgaWYgYXR0YWNoaW5nIHEgdG8gcCB3b3VsZCBiZSBh
biBpbXByb3ZlbWVudCAqLw0Kc3RhdGljIHZvaWQgdHJ5X2F0dGFjaChzdHJ1Y3QgY3RsX3RhYmxl
X2hlYWRlciAqcCwgc3RydWN0IGN0bF90YWJsZV9oZWFkZXIgKnEpDQoNCndoYXQgaXMgdGhlIG1l
YW5pbmcgb2YgImltcHJvdmVtZW50IiwgIEkgZG9u4oCZdCBrbm93IHRoZSBtYXRjaGluZyBzdGFu
ZGFyZCBmb3IgdGhlIGVudHJ5IGluIHRoZSBsaXN0DQoNCmFub3RoZXIgcXVlc3Rpb24gaXMgLCB3
aHkgbm90IGJyZWFrIHdoZW4gdmFyaWFibGUgaXNfYmV0dGVyIGFuZCBub3RfaW5fcGFyZW50IGlz
IHRydWUsIHNvIGFzIHRvIHNhdmUgdGltZSwgIHdoZW4gSSBjb25maWcgYWJvdXQgMmt+NGsgbmV0
IGRldmljZSBvYmplY3RzIGluIHN5c3RlbSwgICJyZWdpc3Rlcl9uZXRfc3lzY3RsX3RhYmxlIiBj
b3N0IGNvbnNpZGVyYWJsZSB0aW1lLg0KDQpGb3IgZXhhbXBsZSANCg0KCXN0cnVjdCBjdGxfdGFi
bGUgKnRvID0gcC0+Y3RsX3RhYmxlLCAqYnkgPSBxLT5jdGxfdGFibGU7DQoJc3RydWN0IGN0bF90
YWJsZSAqbmV4dDsNCglpbnQgaXNfYmV0dGVyID0gMDsNCglpbnQgbm90X2luX3BhcmVudCA9ICFw
LT5hdHRhY2hlZF9ieTsNCg0KCXdoaWxlICgobmV4dCA9IGlzX2JyYW5jaF9pbihieSwgdG8pKSAh
PSBOVUxMKSB7DQoJCWlmIChieSA9PSBxLT5hdHRhY2hlZF9ieSkNCgkJCWlzX2JldHRlciA9IDE7
DQoJCWlmICh0byA9PSBwLT5hdHRhY2hlZF9ieSkNCgkJCW5vdF9pbl9wYXJlbnQgPSAxOw0KCQli
eSA9IGJ5LT5jaGlsZDsNCgkJdG8gPSBuZXh0LT5jaGlsZDsNCiAgICAgICAg44CKLS0tLS0tLS0t
LS0tLS0tLS0gICBpZihpc19iZXR0ZXIgJiYgbm90X2luX3BhcmVudCkgYnJlYWs7DQogICAgDQoJ
fQ0KDQoJaWYgKGlzX2JldHRlciAmJiBub3RfaW5fcGFyZW50KSB7DQoJCXEtPmF0dGFjaGVkX2J5
ID0gYnk7DQoJCXEtPmF0dGFjaGVkX3RvID0gdG87DQoJCXEtPnBhcmVudCA9IHA7DQoJfQ0KfSAN
Cg0KVGhhbmtzIHRvIGFsbC4NCg==

