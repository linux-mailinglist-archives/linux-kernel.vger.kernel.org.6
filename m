Return-Path: <linux-kernel+bounces-353157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC299297C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA23A1C21546
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2141D0F78;
	Mon,  7 Oct 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="mo96frAD"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD01ACE12;
	Mon,  7 Oct 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298096; cv=fail; b=CC+LBXZJYzVlM01s9526oqR9NbPALvUUxzT1qLw4fUrmCYmm1wtLBS8Fi3lfof4RA3QqFXI70LlK4dv2yDClR21zvb8VgXKazrS4K1cbaztFgSEt8zSSIPDxJDCwm3w7sFTrOanVKYlosNADyJLzZwlh7EsBj0Hrxny4OF43qwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298096; c=relaxed/simple;
	bh=cD5GLZmkweId2SZoTtRfRRXrZ0Pv/aV0UQCXgkdxyqA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fyqDmLQCVngVwHZNdjAxL8Y2xRs7KBHVbC7UwoOX1q15fTBo/AeNQ3gvAeV/+CdXjp3UAjQN8ntOJuZI6tqj9y7phHIq084+OBr/UdCNp/4lBPlaYkJijtg2eq3W0vTeddfpkpCSbVyAd9z7ibomX/snYtghMxltsnLm7/Zw16E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=mo96frAD; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMBj+drcoE/zkE0njgQv7bRwA2E9cFSusY2heI2PCX5I5b/7v0LbzdXLZ9dzT1XdKIVCZYq+whQBVVPFZwarm4yzODT6/W4S9q5mGcfjckS6+0VsLbzyHNNNh9qfq59onWEj1/sntu3XbZcfYlMRjVb7rv90A7PXmibcdI6WL50+mmFFeWHeq6s/GZEHOtZt7arcWD8yHo0YU18KINEoCbO8gqiYcL9KEX2YtDGHWz9XMEBR1K7w8pEnT3IoS/9J6MFZ0lwTRo5SUDFohxqiosjKMCvfafkIhC8t/V/XpC0tjr5i3pOxAjn35H1rbpjgEmlSTj/kMnJFv7fBSnzcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD5GLZmkweId2SZoTtRfRRXrZ0Pv/aV0UQCXgkdxyqA=;
 b=PgBuOSwa6LVXbm3QaJZmtKfaVShXB01F0gGGF+9yuS7Wn6RtAgI8+oyDzSJQp9PS4ti9vj544QCc5tuN+1FdB2W4U0eyD2mwGfY+JN7SDpxHpRtyUGbRKOplIgNwcXCpdyVSfhE5bgg1M+4rD0hIqbbdrsdSM/akTX+Dms5YNhKgIBzPTqT+vBkWtyNuf8vs3O382JBi1nScp4vxphd5ZsLJOB/IC26Q9xKICFCfkL4jzUiuhVclIN7WEAn+vo7qGWQ4w5dLvT57sUitfwDzU8cAyyKFb95Cn18DnUrHVykuTfwTO63VcLREvEnyDOVCw2iaIvKwGRfok3S0spNw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD5GLZmkweId2SZoTtRfRRXrZ0Pv/aV0UQCXgkdxyqA=;
 b=mo96frAD2bHyAodgwxK8uzwwO2U0L8kb/4ZhLOD82kf08b3bQmj3w4mk28fg3vDvuHbncvpkmXDC5K1BFbL/3mJN30d0Uoo4yWhlaZ2zKswjKa4qkhSq2+8VTYLsHVpmjleR2tYT6Zj19WJwjHm24jc3kJJi5iGXCMKQdZeiU0fDYc3MmBESU/Qu+WNSFDJRLxwXnFiQpKe0PEHd694rR/gH7Lphsah3mzdL8QGzy/wqTi9Tvdn5n+Uvn7HyKwi27t8jR0fT2PUJd2rkN0UDxyLqxXQRRFvjcz5E7YeJxV7QFNN8hhZpqQtOQDcuTPJLAKiN33jf0xMgOY7jtkNn8g==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by SEZPR06MB6496.apcprd06.prod.outlook.com (2603:1096:101:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Mon, 7 Oct
 2024 10:48:07 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8048.013; Mon, 7 Oct 2024
 10:48:07 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support for
 ASPEED AST27XX INTC
Thread-Topic: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
Thread-Index: AQHa7j7ei9vfdj76sUGd392NW1ic3rImyV6AgFSG+rA=
Date: Mon, 7 Oct 2024 10:48:06 +0000
Message-ID:
 <PSAPR06MB49494DB3D3062AB23931FD08897D2@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
 <31635635-b743-446d-a94e-b3b8082c06a2@kernel.org>
In-Reply-To: <31635635-b743-446d-a94e-b3b8082c06a2@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|SEZPR06MB6496:EE_
x-ms-office365-filtering-correlation-id: cc6bd1e5-615a-4977-40e0-08dce6bd8728
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmdoeEtEYVVWc0Q1VCt5WTdkb0IzbUYzVm90MFJYUWo4ZS9WQktWd1hROWE3?=
 =?utf-8?B?VEhmcUc5Q3NidmhyQmRLdHF2THgrcWRtYXZJR291b3ZBWHlEeW1hYXhXMk1y?=
 =?utf-8?B?MlhZODgvNXRVcEJ4RGt2WHJkTUNQby92QTYvbWxEQzFnVWR2S0FTRDhSMmlN?=
 =?utf-8?B?Z3BuY1BmejJGRXczTVgwbTNkT1VGaHFudXp3eGwyOHhTclgxejFnSk1pMDdk?=
 =?utf-8?B?NjRIRmRIQWFCVjROWnR6eE9qNGlzMGVvQWJWZ1lTSDFheFBLWXMvNFA4VHpK?=
 =?utf-8?B?VG9neWp5aGtJOCt0SFczU0dOYUlUQ25KVE5rWVJrMWlqRFBhUzJkcVJkOTAv?=
 =?utf-8?B?OXdLQnVMdkYwVHRGWlBFa1BDZmRienpHZ3Mvdm56bDQxdTRWMDAzWGlpNXIv?=
 =?utf-8?B?dWRMd1dacE1SMUd5MGFlZ1dmQ1RhWDcrNXhGZ1hTNkl0eXFTN0JEcTB1bnZ4?=
 =?utf-8?B?RzF4V0JlZld0Q2paS1IxcENOZEJLak9nNWh6WWJMc3M4RVFCN0Mxbm9UQjVj?=
 =?utf-8?B?ZjAybGpKc3dwdXJKVDBTMEhJMml6RXo2VW5JbFUxdFVRaFU1MEV0WHpxeGRO?=
 =?utf-8?B?WG1DeUNQSm9ybkNzQVRreThCemVyQ1g0UGl3ckRDN3hmdFlBKzV4RDJ2Tkcy?=
 =?utf-8?B?Qkx1KytIdy9BU3pwYi9iM1M5ODl5ejBpdlBkYm1CZm5nM2hSNGx6ajZzMS9L?=
 =?utf-8?B?OHRXOGpKa1lWQW9XNU5JdnZZcGY4Tk8wV3djQ3hzNVlKOHVFWFkzWU5sSk5E?=
 =?utf-8?B?Qy9CQVh1S0o0b2szSGcrVjRIcHBhNThmdlVhQ2x5aTFsVy90cDh3UVR5K0xE?=
 =?utf-8?B?V2NkR0p4aWRRUHpwYmUvQzRvT2RlcUFHZDluZWs0NVJiUzkxeWhybWcya1Uy?=
 =?utf-8?B?cklQQ0NIZVpsRzI3cFBDVTVCWTVqNzVaNzY5RWVQNllnSmVkczd2aDFVeXJa?=
 =?utf-8?B?M3FOcVRHditodGtxb3NFRXlGdjhUalIwUTJTWE1xU3B4c01iWDFZbkVLbWpZ?=
 =?utf-8?B?bFMrME9jQm1kbFRRZW4xUEl4K3ptMGJuZWZOcFlaa3Y5bjIrWXRabkc3a1J0?=
 =?utf-8?B?RllQc25kNVBEbk1Hb1ZpdEVxSHUrQlRpOFRvaUFCWTBjT0R0N29zbmJMNiti?=
 =?utf-8?B?QlFlV29YV0VaVUlsTUtYR2VzSWpWUURJUG41bmM4eVdGdUR1ZkJZOTYwRWRN?=
 =?utf-8?B?Lyt1M2w1SVA2SFZlMWRuZmxZMTR3QnpyTkRkbzMycjVGRGZnbkVNMVRMK2Z3?=
 =?utf-8?B?ZWRocEVhWjJHQytSTDZMQ2t1YjBWVzQzWTRNUHlUM1l5U0lySzh4Y3gwNWFw?=
 =?utf-8?B?UFR1SkVwOENKWkxKeWEwd2VTMW0rclQ3SVpFc1lkMnVXamgralZUeFNzWDB6?=
 =?utf-8?B?MGRwQWZnV24wQzdsYmdCY2xpa3YxcUk5eUpFamkzM3h4ZHhjaVJFMlMvM1A2?=
 =?utf-8?B?YnJZd1VZS0tUUkQ2YW5zdk9DSzl4a2xoYmpIVnYyNlhnUG5XczNna1NNMkts?=
 =?utf-8?B?bnlTd0pucWxjeVpoenNOSkFMQlRQQm5wMWtoSjhzKzNLekFuNWdkdmRvZXJR?=
 =?utf-8?B?Z2xyekFUTHdMSDg2S1N1akFTSGo0Y1czSS9XVzJGbmR0NDg1SWVWMVFSdzJG?=
 =?utf-8?B?d1A0WUJXM3dqUWk2ZU1rWk5mL0J0VnV1SStFcEx0SmhDUWErSVNnenVLWmtQ?=
 =?utf-8?B?SklBSG1RMHVIMFJtMHp3bDl0Z0dubnB0MWJSZ1FHMk12TVdxNVRTZnExVzNy?=
 =?utf-8?B?aTN1aDV1TTg3L0VkNnlNekE2d0ExUHFoTkpISCtPTlRsLzhjV3JlL3ZtWVNU?=
 =?utf-8?Q?kCrh/gKYsKoVEHbZXoyDp6djFAc4jDKAAAqxk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVhFdFgwU0JieGNBd2lSeGtka1NtRFFEbEo4dUhuUVBUNzJwak43Uk1qYlV1?=
 =?utf-8?B?OGJTNHQ5TENaME9TOHc0UXl1ckhJTXdKNFFqSVluWDRCbktoazhSN0VSRmoz?=
 =?utf-8?B?OHRwS25BOWQraldrRW5YMnF3Zzd4STFscSt2MDh3UDB0Ky9MWkMwbWI1U0pP?=
 =?utf-8?B?dU1JUkJVVWJ3cWNNVW9XUm01cFpOMG4xc3R3U1pDdGhINElackpoOU14VEFB?=
 =?utf-8?B?L1JoWVhCYXU2dXo3RzFqYjJGMnRIL0lkcDVvU1lkL0hlOGl0R1FZVFFkTGll?=
 =?utf-8?B?VGRTWmFmTi9aVjUrRVRVZjZZRGxCWnJ6V0JHaTFhZTlxNkFLbzRHQ2Y4TGRL?=
 =?utf-8?B?ajdJcmZ4SUsvVSs3RmRuM3Q2cDZNUWg4bktDOU1ad1doRFJCWm5McTJsUTdr?=
 =?utf-8?B?VmxTdWUvYzNqbVV3U3YrNUJDQ0dVdHAzZTd4YmxMYldZVm5JM3JaVzJrMkFp?=
 =?utf-8?B?SnZRT1NmaDQrZUI4ZEs2dENRSHJRNEI0UFRtMXFqV1JHbVY0L1MwRkJEcndV?=
 =?utf-8?B?TkRsMFVXY0c0cVhUaHZLNy83c0JIckJGREkrbTM1Q01Zbnk1QzZHNnhnb01t?=
 =?utf-8?B?VUk1ZmoyWmYwS0NVeVM1UFE0cEF3QVlKU0tGeXdYWFZGWk5Ndkd0bzNCQ3VE?=
 =?utf-8?B?aDduRUZPLzNqUUNuLy9xd2dUMllvc2VCVkE1MG8wZHBSUExPcFVrQitqd09X?=
 =?utf-8?B?SmtFTjNBamNkeWNma0RlQ3JBa2lrcmh1d0pYaHpkeWUzVXNBK0s4WEd6YXZM?=
 =?utf-8?B?TzJLOFBzNU5pK0RJMENKVm55RGVUMkZaWUZKNlYyVUwvTTZYVG9ldlQwVVlL?=
 =?utf-8?B?V2RQd2laZk40UzlOaGszc3VzQjFDNXp1Nis5QkZVOEEwZXRTQVNXd2RXa0JU?=
 =?utf-8?B?Mi92bXlCaXg1a0R1NTNESlBaRE0waksybGhmR2lTeTFPWUcxZWJsMFBpYVdC?=
 =?utf-8?B?SVRlOE5FQ1hNcWZNS2tMRmExdUVZWW9XL0RRUU5ELzNYc3BvUWY5U0dvQ3dl?=
 =?utf-8?B?emxPM1JxWERvYURIbVBrbXN2d0gyRXdONDVqYmd4bVFoK1EzV0dSa29UMXBW?=
 =?utf-8?B?YlpCdDVuSFdOQXlZUWtJOFM4OU9XenA3a1dmSForNENzb3grVncwRVRuTGJm?=
 =?utf-8?B?cDJJTDMyQk1lYUZOaHgrMEl5QUNoR0JQSm9SNEViQzROM1k5cGVZdWxHWE0z?=
 =?utf-8?B?Z0JOTk5Bb2g5M1ZCRUpJc0JOdlNQVUJObzYvNktFNmhmeEJCeEF3TDhYQzd2?=
 =?utf-8?B?SVUwNGNoZjFDUDAwWDRZSWRLQ3IzY1d4QkxGdWxldnJ1OGNNNEhNV2tHSXl2?=
 =?utf-8?B?cW4yQjFvbHN4cmlwU3hodDZ1b3U0MGZGOEx2TXhlaVdzVzZ6V0wyMXZmODRj?=
 =?utf-8?B?eFd1UyszbFQwZk5rek15QVVWYzZmOGNIRjdpKzFDZmE2SkpxMEJQVnNjMU5E?=
 =?utf-8?B?SXZwMk5DVzFoS0NQNzhLalBlbzVtOGVDbW4rK1BxQllKZGZReStQcDJ1SmJz?=
 =?utf-8?B?WVNwa1ZXQ0h2WGZINUxkM2hEL2o3aHIrRUpOSURqb1RDVDNMK0NOWVp5UEQr?=
 =?utf-8?B?c2Z5Wm5taEJUZngrL0hNNjgrcG9JVm1rKzF3bitDazA4ZlhxQlN2aEh5SFFV?=
 =?utf-8?B?UWpEa1RGbWU3amZlTnZvNW0xNDBBTE9uOWF2Ri8rV256ZTNpV3grcVZtQ2tK?=
 =?utf-8?B?MmVSRWJIWXMzWUczNWlCaHErUG9LcnFNNjhwQTNHZ21ON3RJTEZ4aTNOMmZw?=
 =?utf-8?B?MW96cm5reGNZc25pUVR3VmFKU2doTi8wUldLQTdrY2YzK1IxVzJobXFtK3R0?=
 =?utf-8?B?RTZLb29mdEZ2Y1IybGl6VjJtcnY2eCt4WVlUU29xQmkycFZyMmVhcS9mM2lH?=
 =?utf-8?B?ZmZlZWUzVXNYUVYyRDdOOUYwbGowc0xXY1grNGQxby9MY2VzcnJjZmNlSnNp?=
 =?utf-8?B?b01mR3B5Y2JrUFc4MmdzdU5zUndIVGJRbHgyeFB6ZkFXZng4cjVGNTVZOEhH?=
 =?utf-8?B?cWFSUGo4aWxmMVBiV3BzTG15eENLZ3Y2MXVsQkFHeWw0YWM5Tk5DRGc1VGdC?=
 =?utf-8?B?NDd6b1pKWXlXbHIyZHptaEJNdHFBSnVTM3FKYzNxQzc4TFM2MHhhbnZmM3Vj?=
 =?utf-8?Q?28xoBq/3IIpoa8QIGMg3gtuj4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6bd1e5-615a-4977-40e0-08dce6bd8728
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 10:48:07.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Le5vfopGKDRYyhJvgtu3sBbvruVZInxYe694DTu4t15JEKeA5/loZUeHv3ohcMeBtBSh7XpEa5U05jpqmTTbqtRqerB9eqgK/EJm8WwrgNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6496

PiA+IFRoZSBBU1BFRUQgQVNUMjdYWCBpbnRlcnJ1cHQgY29udHJvbGxlcihJTlRDKSBjb250YWlu
IHNlY29uZCBsZXZlbCBhbmQNCj4gPiB0aGlyZCBsZXZlbCBpbnRlcnJ1cHQgY29udHJvbGxlci4g
VGhlIHRoaXJkIGxldmVsIElOVEMgY29tYmluZXMgMzINCj4gPiBpbnRlcnJ1cHQgc291cmNlcyBp
bnRvIDEgaW50ZXJydXB0IGludG8gcGFyZW50IGludGVycnVwdCBjb250cm9sbGVyLg0KPiA+IFRo
ZSBzZWNvbmQgbGV2ZWwgSU5UQyBkb2luZyBoYW5kIHNoYWtlIHdpdGggdGhpcmQgbGV2ZWwgSU5U
Qy4NCj4gDQo+IA0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEtldmluIENoZW4gPGtldmlu
X2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIGFzcGVlZCxhc3QyNzAwLWlu
dGMtaWMNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gDQo+IFRo
YXQncyB1bmNvbnN0cmFpbmVkLiBJbnN0ZWFkOiBtYXhJdGVtczogMQ0KQWdyZWUuDQoNCj4gDQo+
ID4gKw0KPiA+ICsgIGludGVycnVwdC1jb250cm9sbGVyOiB0cnVlDQo+ID4gKw0KPiA+ICsgICcj
aW50ZXJydXB0LWNlbGxzJzoNCj4gPiArICAgIGNvbnN0OiAyDQo+ID4gKw0KPiA+ICsgIGludGVy
cnVwdHM6DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgbWF4SXRlbXM6IDEwDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgSXQgY29udGFpbnMgdHdvIHR5cGVzIG9mIGlu
dGVycnVwdCBjb250cm9sbGVyLiBUaGUgZmlyc3QgdHlwZSBpcyBtdWx0aXBsZQ0KPiA+ICsgICAg
ICBpbnRlcnJ1cHQgc291cmNlcyBpbnRvIHBhcmVudCBpbnRlcnJ1cHQgY29udHJvbGxlci4gVGhl
IHNlY29uZCB0eXBlIGlzDQo+ID4gKyAgICAgIDEgaW50ZXJydXB0IHNvdXJjZSB0byBwYXJlbnQg
aW50ZXJydXB0IGNvbnRyb2xsZXIuDQo+IA0KPiBJIHRoaW5rIEkgYXNrZWQgYWxyZWFkeSAtIGxp
c3QgdGhlIGl0ZW1zIHdpdGggZGVzY3JpcHRpb24uDQo+IA0KPiBXaHkgdGhlIG51bWJlciBpcyBm
bGV4aWJsZT8NCkRlcGVuZCB0byB3aGljaCBJTlRDMCBvciBJTlRDMSB1c2VkLg0KSU5UQzAgYW5k
IElOVEMxIGFyZSB0d28ga2luZHMgb2YgaW50ZXJydXB0IGNvbnRyb2xsZXIgd2l0aCBlbmFibGUg
YW5kIHJhdyBzdGF0dXMgcmVnaXN0ZXJzIGZvciB1c2UuDQpJTlRDMCBpcyB1c2VkIHRvIGFzc2Vy
dCBHSUMoIzE5Mn4jMTk3KSBpZiBpbnRlcnJ1cHQgaW4gSU5UQzEgYXNzZXJ0ZWQuIFRoZXJlIGFy
ZSA2IEdJQyBpbnRlcnJ1cHQgbnVtYmVyKCMxOTJ+IzE5NykgdXNlZCBpbiBvbmUgSU5UQzAuDQpJ
TlRDMSBpcyB1c2VkIHRvIGFzc2VydCBJTlRDMCBpZiBpbnRlcnJ1cHQgb2YgbW9kdWxlcyBhc3Nl
cnRlZC4gVGhlcmUgYXJlIDMyIG1vZHVsZSBpbnRlcnJ1cHRzIHVzZWQgaW4gb25lIElOVEMxLg0K
DQo+IA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAg
LSByZWcNCj4gPiArICAtIGludGVycnVwdC1jb250cm9sbGVyDQo+ID4gKyAgLSAnI2ludGVycnVw
dC1jZWxscycNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAg
ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0K
PiA+ICsNCj4gPiArICAgIGJ1cyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47
DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgIGlu
dGVycnVwdC1jb250cm9sbGVyQDEyMTAxYjAwIHsNCj4gPiArICAgICAgICAgIGNvbXBhdGlibGUg
PSAiYXNwZWVkLGFzdDI3MDAtaW50Yy1pYyI7DQo+IA0KPiBNZXNzZWQgaW5kZW50YXRpb24uDQpB
Z3JlZS4gV291bGQgY2hhbmdlIHRvIHRoZSBmb2xsb3dpbmcuDQpleGFtcGxlczoNCiAgLSB8DQog
ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4N
Cg0KICAgIGJ1cyB7DQogICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KICAgICAgICAjc2l6
ZS1jZWxscyA9IDwyPjsNCg0KICAgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlckAxMjEwMWIwMCB7
DQogICAgICAgICAgICBjb21wYXRpYmxlID0gImFzcGVlZCxhc3QyNzAwLWludGMtaWMiOw0KICAg
ICAgICAgICAgcmVnID0gPDAgMHgxMjEwMWIwMCAwIDB4MTA+Ow0KICAgICAgICAgICAgI2ludGVy
cnVwdC1jZWxscyA9IDwyPjsNCiAgICAgICAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KICAg
ICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5MiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwN
CiAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAxOTMgSVJRX1RZUEVfTEVWRUxfSElH
SD4sDQogICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgMTk0IElSUV9UWVBFX0xFVkVM
X0hJR0g+LA0KICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDE5NSBJUlFfVFlQRV9M
RVZFTF9ISUdIPiwNCiAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQSSAxOTYgSVJRX1RZ
UEVfTEVWRUxfSElHSD4sDQogICAgICAgICAgICAgICAgICAgICAgICAgPEdJQ19TUEkgMTk3IElS
UV9UWVBFX0xFVkVMX0hJR0g+LA0KICAgICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDE5
OCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCiAgICAgICAgICAgICAgICAgICAgICAgICA8R0lDX1NQ
SSAxOTkgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQogICAgICAgICAgICAgICAgICAgICAgICAgPEdJ
Q19TUEkgMjAwIElSUV9UWVBFX0xFVkVMX0hJR0g+LA0KICAgICAgICAgICAgICAgICAgICAgICAg
IDxHSUNfU1BJIDIwMSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAgICAgICAgfTsNCiAgICB9Ow0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

