Return-Path: <linux-kernel+bounces-363070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2299BD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFFC51C2206C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2322AE74;
	Mon, 14 Oct 2024 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="TjtodsXr"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A41BC2A;
	Mon, 14 Oct 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871210; cv=fail; b=pkuSeMdg6AXDgabvV16pvFXFvqKR9VgIP0QmKlwIKJwUJ1vE+A+iIKOW/zsOQ+A45Q4a+QZk5FAJBhHu5TahllFzuhO2T7AigW6sd09RT2VdxQvXVUOsYNTlxMb6B6n+sQrBcS/fTtKKFTl1rV85XqHXFsELWQzeRGBenn6enfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871210; c=relaxed/simple;
	bh=Tl0zj07X0US5DX4SLIUn1yDDyjinXlRIxjOGJW+SO9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JdNvztFrwHdJotk2GwhSz5aG0sjhFLjx9Vvq7sdZFHr0nsaLKuGpQ1nu1OFmtEhCfYEeKKGS7HjIDum9VmwxY1rAo59r+P+DBxbyis8Ds3uieEIVblMc+alThtFpEugGWxFyEdd4psbsrhrypx4XXCuS1DlKldhGPs5m2mv/y/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=TjtodsXr; arc=fail smtp.client-ip=40.107.215.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJOhUJu4zyNdfw0IngMLgptC/2ImkifqS/7ewux74xQnU33trVNBye9gX5f/JpLJCoQsAAC+z1l+VP3SPImne7CVNc+2WXBr6kcduDrDBgiHrv2up5JlcAqZCPj/BS8zvdJv3+cKTQ7jsmyOeeR5CMuxIjadVt49m+OwCVLSxyC5juOY/KKWxiN5J7wwoc89GIh0PMAbSHN1iw3IyBLtlC2wxJcit4QZEWNgqGT0GOWqPfdOk7uoIBoAPUvRM30oKgJAYHMZw80Rc7DxEPqTowhFOiYRSbmqqetOr6RSKowhMi5RRxfJ0TsSv5YIYKsdX2KW8HnJz8OzEjA/SN7X8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl0zj07X0US5DX4SLIUn1yDDyjinXlRIxjOGJW+SO9A=;
 b=NYunfBXbgxSvnGmkNLgu3gVpqBEcfeZoj02iB3/oLuSAaF1yxWDKAqmiOcGE9l8iZaYTvJeRCdcqiLNxeVXoukC5tcxfrkEysAN8lNYrOKck9r3tzkXrVBFTod5ERuhuE1CiBS3zhVX61KSI6j451jwmLKkM3kkKwPoaWhVSma379f962u1HlcopEWVeKqovuoTs9rG22aC6sl9BlDlIL1kLtjj87FsObotKT2XrcJ61hINPAsV2N5/0Fxq+X5knMU2MR+cTQAr/9895NTcnjdoOuBHkVeS8mYULDb0zU53LpV9fpknWCf/H3KG1WubXqNx1vkoj68ARciGutwyMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl0zj07X0US5DX4SLIUn1yDDyjinXlRIxjOGJW+SO9A=;
 b=TjtodsXrowX3TBZudPpKg0AZsac/rN2Vl2NAgbi/HLkd76xKH1MeiLabwJrQEKU7S+gDnjODko1kLDXv4wh5YSbigk2JfdJLFLB8HjWLZZLP6jeUunwiw7xjxNaa52mCbaGjmKrFAHslTOawi0BwUSXOnKaUFoFMaGFBRPcwurRUff5gQ9g6imD+nQda64wO4wuI1cEaWYLrapcNEtASxkH3sMmIZDjt/cgK0O9MdtI8WY42MRR0doqAzLjkAy5rj9wlcUHuMPpszyxhfnLMXF6UZ3RoUJj84iyRVqbvxBED8LGxXmWgaiATXmaNkjzytXxJA0xiNZaOPKOQJQNPJA==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TY0PR06MB5127.apcprd06.prod.outlook.com (2603:1096:400:1b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.15; Mon, 14 Oct
 2024 02:00:01 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 02:00:00 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, BMC-SW <BMC-SW@aspeedtech.com>
CC: LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Topic: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Index: AQHbGkKMCnGgBPvFn0OoVljQ1X0eJrJ+WgAAgAL6RdCAAF00AIADu5Zw
Date: Mon, 14 Oct 2024 02:00:00 +0000
Message-ID:
 <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
In-Reply-To: <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TY0PR06MB5127:EE_
x-ms-office365-filtering-correlation-id: 8b8a75f1-25f5-45aa-3acf-08dcebf3e98a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmFITGE5b0xKTUVTRmd3ZTNmbFF3RXAxZTJTdHpJU3F6WXdnT3YvYlR2WXkx?=
 =?utf-8?B?b1creXgzUkR2b3BuekZuaUlQUUNhaWhuMnRGNlVvMlU2WmVnbzhYbHRqNXZa?=
 =?utf-8?B?SDFJbCtTY0VTRHlHYlkyZ09tQXpTUkpDSzlVYzZhR1htTWdXQnJTSithazdT?=
 =?utf-8?B?ZEx6NG1XL3NCZkpaeTlTWmlhQnRkUlA3cHZHK3FkTlA5Wmc5bGpNblJKZVkr?=
 =?utf-8?B?Vy9RRjlxN0xyTHJ1S2EydjZGSE80V0c1NmM4ZGVHL25kTCtFdzI0K3hDL3BP?=
 =?utf-8?B?TXBkZzJaYy9kb28zS3cwRDVkVHJOUy90cmkzdlpTZEZGMUdRWG4ySVdQQnBP?=
 =?utf-8?B?U1UxelR4OFBSUVg1ZWFuaXExWUp1U1YrVXdWN2pkUkVSU2ZiNyttb2gzWE1h?=
 =?utf-8?B?bUJEZ2dZVUVWTGVkM2wxeDVRNWlYdEJCSVBpVGtUdUZleXAvcGVoQTJCQ1dW?=
 =?utf-8?B?ejZleHUrU042dnYyVytKOGdvSEgvYlNmenAxUEUvTmJpeWw0WTBFV1VvODJY?=
 =?utf-8?B?bllkOXh3QzlyeXFmM1NCckZ0czBZTXlJT2NCeCtDejhsNUwxRWJ2T0pCNzRn?=
 =?utf-8?B?WGxna0MrOVBvN2RqSVQ4b1NDTnhLQ1RkTHZxNzZ2cDZRUUpudlNSLzIwTzg0?=
 =?utf-8?B?cU5VRXVXS1RISjlDeEdyUUtpdSsrN3dlYXAwU1RzMDlFb054LzBPSHN4ZDJm?=
 =?utf-8?B?MmhZcGN4MjZUNUFiT3FoVjBIa1o1cExSajNoeEV3RE5ub1ZmZEFuTHE4RTRz?=
 =?utf-8?B?RTFGNW5SVFhwQjZjWjN4WlN6LzBXR1BkN25lc3ZaM2RiWitGVVA0enRWU2Zv?=
 =?utf-8?B?UEZ4MnBHS01hT0dtY3RBeEhPUjUvVmdTUmlRaHhvNkFkTUpJOVg2czFHQy96?=
 =?utf-8?B?bG1odlQ3MjdDRHR4TUplTitkUE4wanNnYWUwcmdsamN2NGprelhUY1Y1bXFH?=
 =?utf-8?B?QlY1eWRyQ2tucFNHMmNZbzlzY0hLeUdZamZQdGJVazREVWRYb0F4VHN3RlRu?=
 =?utf-8?B?UWwzb0Y5QmpMR1FrYUkwbnRHSXNOKzQ2OW9nNk9kWlpXU1BKN0VIdEp6aFBH?=
 =?utf-8?B?NmlnL1ZWZzcrUDVGWUcwS0taeU5TQjRreE9YWkpZUlEvVVVvdjhsVkljVXNi?=
 =?utf-8?B?TkxhcEp1TUVrNm1xcWhxUFNtS0RMRlM2L1NsVnRVcDEyOE9rVVRNRGZnK2Z4?=
 =?utf-8?B?d3Q5RHE0YUZ5bDhXY20yYXdOZ29PMmw2Z2U3dFJEcE1tQUpUbTFkK0JrL0Rv?=
 =?utf-8?B?aitUVFpabzU2M2xGTi9aQmNRaHBTRStHOWlSS2d1MG5LbCs4Rks3dlQ2OVRV?=
 =?utf-8?B?RnlrVE5neHkxUFRKelFocHpsTEFNMXR0R0V5dXBzVTc1Nkp6aW1LSlBkQ243?=
 =?utf-8?B?YkpqMWNOSlJzVzlGTzNBVGlCODBsc0Z0cDFpQmRLYnZmNjd3RUlhdjQrS0wv?=
 =?utf-8?B?MUwreS9zeFRVOERVNXlrVHV6UlFLZk1zK0EwKzNWNkRUd3pzWHIwTzRFbHdt?=
 =?utf-8?B?VGVTelYzeVdRcXFOdXVIY09RS2NyU3gvaUxseDRMYXJSZmMxdjU0OHdaUXhw?=
 =?utf-8?B?Zk9qWDZyS2V4NnpkWCswZmV0R1NHQ0l4QUtZUEVrYXpNcE1RTU1LZFJDNk9L?=
 =?utf-8?B?R1c2UlBHSU5VckV3czU5WEx3eWx1VE5tSkQwYXVnQmY3b3RzRXREMkl6OXdU?=
 =?utf-8?B?eWxUQXFYMmd1RUFoWklBcGcra2VXTHBQSXVkbXRLd0U2UngwOGpENmFSOFBK?=
 =?utf-8?Q?hCSbscNNzucyRrywZo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHlmUFZ0cm5OenpsNCtrK2RINlMwaHkybjBFODN3WlJ0WTFPdGZ4eTF2bXBv?=
 =?utf-8?B?elFDcGYzZVIzNWNVVHFHTDhzZW4xZXRNellpR0RxTEtubkVvN0dQQXVpYmJi?=
 =?utf-8?B?eVZaQkl6QkdSN2lOd0VSTVAvZmlDTzc4NjFzMWMzd3lNc1VKSEJGZEN5RjZM?=
 =?utf-8?B?UG9MMTJTR2VVTTRLRm1BdlNCN0cyRmIxV2QwdjZMYzk3NFIyN1BMaFJrQmkw?=
 =?utf-8?B?VGVnaGd0MG1BR2VWK2g0WTFlR1pQMnIxcS9jY2VUUmlVUVVRVVQ1eDJ2bFBz?=
 =?utf-8?B?T2Q1TkVzK3BXSWVxRDdvRVQvRFFIVTI5czA0WnVRUTRyMjRQN0p6SjNUc1dG?=
 =?utf-8?B?bHRQRi83RkxvbC9za3EvbG5sR3dDQTNuelRzUDAzbHdURFdvTzVGNVMvaExq?=
 =?utf-8?B?d1diQ3djaXg5cEZOMUVaN3J6VzJIZGM1ZHE1NG5HenlKU1dEbUYyZDFDWlEx?=
 =?utf-8?B?K0FjZ3VlU1FpL0ZKbDU3QzM3b0VYWm9vMmV0NTRNaUNPSGIvU0pVQUtVRWcw?=
 =?utf-8?B?M202Ujl2U2lZTjRwQ0NsdUxSVDdjcjBiWU5lUmI5UVdWT0JNR29ib3hzWUdi?=
 =?utf-8?B?alQvS3hFVmU4amFRY283R0Zlem1EQzIvQWFKS1hkajVhVnhVR0h4YnVkQ3RB?=
 =?utf-8?B?Wm1OM05xNWtuYnNkeENJVVpiQUdiSHFSV2hDUFlIQTF3QjJYSlZ3NzhxcDhD?=
 =?utf-8?B?Tk1UYkJkUjdvNWE4SmZPY0FzaXZSSS9mcTZWSWJBVEc4elNnbjVyMkJ0bmVF?=
 =?utf-8?B?Q0FuMjJmYlZPYUtwR1o2OVQ0Ui9WZXIvVDVZTG11OEl1MW12Z2RkRVpTN3hO?=
 =?utf-8?B?NTUrSlgvNzdVQUM0dEs3RGQ4bTZTaVpxcWZ6L2ZRZFRuSExwYmNETDJNbmxG?=
 =?utf-8?B?NHRxVGtRdmhnMEdCR3plT3NIaVlJRncxSm9WS21lNmZ0Tm9ERU9MUU1qbTAz?=
 =?utf-8?B?UXY4QXp2akxJSUVSeDE5VjZWSGV6cEhnZW5FOEY3eW1BSTlZd1pYc2pyQmdo?=
 =?utf-8?B?U1BleVZlR3d3b0lsRGZFN25JOFFGR0I1Q29SbFJ6eFAvKzk5ZHRHSHhZUG5z?=
 =?utf-8?B?M2IrOU05WlM2UDUvczg5L3V2dUxHRmM4NEs0ZGdsS1BOVFdWTldmWC92QUJL?=
 =?utf-8?B?bW9WK214ekJZNnJVTUNDL05EQzljclJWakd3MmJRNFl3azgrOHRNVzJLdFQ0?=
 =?utf-8?B?SWpxTVNDRXM0anRpN0RRK3hXU3BkRGRpWnVRWFZjRG02WHFGazB4Z1BtWU9n?=
 =?utf-8?B?Rkl4ZFdzbWl1WmYxK0JyQW8yK2pSeDNzVW1vY2Zhb0ZnaXVUNDJsQXpRbVNi?=
 =?utf-8?B?NkZYQXlkaHppdXJHUlBuTlpQbUdFYTdtblpnZE9vcWZXcmRZQnhIK0FmSlVi?=
 =?utf-8?B?ejVyKy9EbFhQejZIQ1g3Q2ZqQ1I2UzlMMzNrY1lwNTFIRkRNZVJSWFdTUjdS?=
 =?utf-8?B?dDVkWUlKTjZ5RGI1dlRrU0N3dW02OUl0eFJDaDZWUE5ndElSc3kzVmFIZmsw?=
 =?utf-8?B?bDFlOEZJaGkxTUR4THY2OEh2TSs0SmE5WjBZWm5aTVk4ZHFTMlJSTndWZjVZ?=
 =?utf-8?B?RWxjRU9RS3pEeVMzWjNRQndxU1Zjdm5WTi9Xc1dSQi9jSitURFZMYUxCUGZt?=
 =?utf-8?B?dUF1OXNxS0xKa29wczI3WS94SlkrVWkzZ0EwZytXNWpOQnc4c3JXN2VZWXcr?=
 =?utf-8?B?V0xlemRUVTc0am4yZXB3cE5XcHhDMGhsWVpPb1RVSzJqZlJBT0dxa1haK2lX?=
 =?utf-8?B?UlJZc2ZhaU9hUWhIZjJZTlVENlpLOG5LRnM4S0pHWGFNMTM4WG1jTFZ5eFJt?=
 =?utf-8?B?dXMyZHhwdmdIYlVhV1JwQzViTWE3K0hlNWtXbE10Y0QzR1VwYXdnVEhkVE5C?=
 =?utf-8?B?VlBrZkk2cW05OGl3aVhTYitoT0ttdHpISjFGK0tOTU41em5UM3EyS0taTUYw?=
 =?utf-8?B?T2Jla3pjZ1ZZbFZaR1ZXdUZhc0NncVFuMThzbCs4ZkVma2dONVpBVnY1RXlK?=
 =?utf-8?B?dnZRVXVHL3lha29henA3bC90Z2V3UzNSakE1Uml1eUExZEE0SytnMUVGMEhx?=
 =?utf-8?B?NjlwN1RTelg5aUVqOVArc2pJbDF0Mms3WTJBcVA5aVNXbUswcmNBM2UvL0t0?=
 =?utf-8?Q?J/z+mPmita6exO3onNV9jyijk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8a75f1-25f5-45aa-3acf-08dcebf3e98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 02:00:00.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgeD40wNHTQQKKbV5lIEaXDbBGIkkd7TBwKQlNj9GEvJlpqyYUKTB8hGBQbErnMNeo5lqq8IBa8OdMZLILQ25VDIlrdFzOue+5wmKIWCT8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5127

PiA+PiDigKYNCj4gPj4+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtYXNwZWVkLWludGMuYw0K
PiA+Pj4gQEAgLTAsMCArMSwxMzkgQEANCj4gPj4g4oCmDQo+ID4+PiArc3RhdGljIHZvaWQgYXNw
ZWVkX2ludGNfaWNfaXJxX2hhbmRsZXIoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPiA+PiArew0K
PiA+Pj4gKwlzdHJ1Y3QgYXNwZWVkX2ludGNfaWMgKmludGNfaWMgPSBpcnFfZGVzY19nZXRfaGFu
ZGxlcl9kYXRhKGRlc2MpOw0KPiA+Pj4gKwlzdHJ1Y3QgaXJxX2NoaXAgKmNoaXAgPSBpcnFfZGVz
Y19nZXRfY2hpcChkZXNjKTsNCj4gPj4+ICsJdW5zaWduZWQgbG9uZyBiaXQsIHN0YXR1czsNCj4g
Pj4NCj4gPj4gSSBzdWdnZXN0IHRvIHJlZHVjZSB0aGUgc2NvcGVzIGZvciB0aHJlZSBsb2NhbCB2
YXJpYWJsZXMuDQo+ID4gTWF5IEkgY2hlY2sgdGhlIHNjb3BlcyBvZiBiaXQgYW5kIHN0YXR1cyB1
c2FnZT8NCj4gPiBWYXJpYWJsZXMgb2YgYml0IGFuZCBzdGF0dXMgYXJlIHVzZWQgaW4gZm9yX2Vh
Y2hfc2V0X2JpdC4NCj4gPiBIb3cgY291bGQgSSByZWR1Y2UgdGhlIHNjb3Blcz8NCj4gDQo+IEkg
cHJvcG9zZSB0byBtb3ZlIHNlbGVjdGVkIHZhcmlhYmxlIGRlZmluaXRpb25zIGludG8gY29ycmVz
cG9uZGluZyBjb21wb3VuZA0KPiBzdGF0ZW1lbnRzIChieSB1c2luZyBleHRyYSBjdXJseSBicmFj
a2V0cykuDQo+IGh0dHBzOi8vcmVmYWN0b3JpbmcuY29tL2NhdGFsb2cvcmVkdWNlU2NvcGVPZlZh
cmlhYmxlLmh0bWwNCk9LLiBJIG1vdmVkIHRoZXNlIHR3byBsb2NhbCB2YXJpYWJsZXMgaW50byBz
Y29wZWRfZ3VhcmQuDQoNCitzdGF0aWMgdm9pZCBhc3BlZWRfaW50Y19pY19pcnFfaGFuZGxlcihz
dHJ1Y3QgaXJxX2Rlc2MgKmRlc2MpDQorew0KKyAgICAgICBzdHJ1Y3QgYXNwZWVkX2ludGNfaWMg
KmludGNfaWMgPSBpcnFfZGVzY19nZXRfaGFuZGxlcl9kYXRhKGRlc2MpOw0KKw0KKyAgICAgICBn
dWFyZChjaGFpbmVkX2lycSkoZGVzYyk7DQorICAgICAgIHNjb3BlZF9ndWFyZChyYXdfc3Bpbmxv
Y2ssICZpbnRjX2ljLT5naWNfbG9jaykgew0KKyAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
Yml0LCBzdGF0dXM7DQorDQorICAgICAgICAgICAgICAgc3RhdHVzID0gcmVhZGwoaW50Y19pYy0+
YmFzZSArIElOVENfSU5UX1NUQVRVU19SRUcpOw0KKyAgICAgICAgICAgICAgIGZvcl9lYWNoX3Nl
dF9iaXQoYml0LCAmc3RhdHVzLCBJUlFTX1BFUl9XT1JEKSB7DQorICAgICAgICAgICAgICAgICAg
ICAgICBnZW5lcmljX2hhbmRsZV9kb21haW5faXJxKGludGNfaWMtPmlycV9kb21haW4sIGJpdCk7
DQorICAgICAgICAgICAgICAgICAgICAgICB3cml0ZWwoQklUKGJpdCksIGludGNfaWMtPmJhc2Ug
KyBJTlRDX0lOVF9TVEFUVVNfUkVHKTsNCisgICAgICAgICAgICAgICB9DQorICAgICAgIH0NCit9
DQoNCg0KPiANCj4gDQo+ID4+IFdvdWxkIHlvdSBiZWNvbWUgaW50ZXJlc3RlZCB0byBjb2xsYWJv
cmF0ZSB3aXRoIGFub3RoZXIgc2NvcGVkIGd1YXJkDQo+ID4+IGZvciB0aGlzIHByb2dyYW1taW5n
IGludGVyZmFjZT8NCj4gPj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTIt
cmMyL3NvdXJjZS9pbmNsdWRlL2xpbnV4L2lycWNoDQo+ID4+IGlwL2NoYWluZWQNCj4gPj4gX2ly
cS5oI0wxMw0KPiA+DQo+ID4gTWF5YmUgbGlrZSB0aGUgY2hhbmdlIGluIHRoZSBmb2xsb3dpbmc/
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL2lycS1hc3BlZWQtaW50Yy5j
DQo+ID4gYi9kcml2ZXJzL2lycWNoaXAvaXJxLWFzcGVlZC1pbnRjLmMNCj4gPiBpbmRleCBlZjFj
MDk1YWQwOWUuLjU0ZDE4ODFjNTZjNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lycWNoaXAv
aXJxLWFzcGVlZC1pbnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWFzcGVlZC1p
bnRjLmMNCj4gPiBAQCAtMzIsNyArMzIsNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaW50Y19pY19p
cnFfaGFuZGxlcihzdHJ1Y3QgaXJxX2Rlc2MNCj4gKmRlc2MpDQo+ID4gICAgICAgICBzdHJ1Y3Qg
aXJxX2NoaXAgKmNoaXAgPSBpcnFfZGVzY19nZXRfY2hpcChkZXNjKTsNCj4gPiAgICAgICAgIHVu
c2lnbmVkIGxvbmcgYml0LCBzdGF0dXM7DQo+ID4NCj4gPiAtICAgICAgIGNoYWluZWRfaXJxX2Vu
dGVyKGNoaXAsIGRlc2MpOw0KPiA+ICsgICAgICAgZ3VhcmQoY2hhaW5lZF9pcnEpKGRlc2MpOw0K
PiA+DQo+ID4gICAgICAgICBzY29wZWRfZ3VhcmQocmF3X3NwaW5sb2NrLCAmaW50Y19pYy0+Z2lj
X2xvY2spIHsNCj4gPiAgICAgICAgICAgICAgICAgc3RhdHVzID0gcmVhZGwoaW50Y19pYy0+YmFz
ZSArIElOVENfSU5UX1NUQVRVU19SRUcpOw0KPiANCj4gUGVyaGFwcy4NCj4gDQo+IA0KPiA+IEBA
IC00MSw4ICs0MSw2IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pbnRjX2ljX2lycV9oYW5kbGVyKHN0
cnVjdCBpcnFfZGVzYw0KPiAqZGVzYykNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB3cml0
ZWwoQklUKGJpdCksIGludGNfaWMtPmJhc2UgKw0KPiBJTlRDX0lOVF9TVEFUVVNfUkVHKTsNCj4g
PiAgICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgfQ0KPiA+IC0NCj4gPiAtICAgICAgIGNo
YWluZWRfaXJxX2V4aXQoY2hpcCwgZGVzYyk7DQo+ID4gIH0NCj4g4oCmDQo+IA0KPiBQcm9iYWJs
eSwgeWVzLg0KPiANCj4gDQo+IOKApg0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvaXJxY2hpcC9j
aGFpbmVkX2lycS5oDQo+ID4gQEAgLTM4LDQgKzM4LDUgQEAgc3RhdGljIGlubGluZSB2b2lkIGNo
YWluZWRfaXJxX2V4aXQoc3RydWN0IGlycV9jaGlwICpjaGlwLA0KPiA+ICAgICAgICAgICAgICAg
ICBjaGlwLT5pcnFfdW5tYXNrKCZkZXNjLT5pcnFfZGF0YSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtE
RUZJTkVfR1VBUkQgKGNoYWluZWRfaXJxLCBzdHJ1Y3QgaXJxX2Rlc2MgKiAsIGNoYWluZWRfaXJx
X2V4aXQgKCBfVA0KPiA+ICstPmlycV9kYXRhLmNoaXAsIF9UICksIGNoYWluZWRfaXJxX2VudGVy
IChfVC0+aXJxX2RhdGEuY2hpcCwgX1QpKQ0KPiDigKYNCj4gDQo+ICogU3VjaCBhIG1hY3JvIGNh
bGwgbG9va3MgcHJvbWlzaW5nLg0KPiAgIFdvdWxkIHlvdSBsaWtlIHRvIG9taXQgYW55IHNwYWNl
IGNoYXJhY3RlcnMgYmVmb3JlIG9wZW4gcGFyZW50aGVzZXM/DQpPSy4gRml4ZWQuDQoNCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2lycWNoaXAvY2hhaW5lZF9pcnEuaCBiL2luY2x1ZGUvbGlu
dXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oDQppbmRleCBkZDhiM2M0NzY2NjYuLjdlZTI5ZTQ3ODE1
MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oDQorKysg
Yi9pbmNsdWRlL2xpbnV4L2lycWNoaXAvY2hhaW5lZF9pcnEuaA0KQEAgLTM4LDQgKzM4LDYgQEAg
c3RhdGljIGlubGluZSB2b2lkIGNoYWluZWRfaXJxX2V4aXQoc3RydWN0IGlycV9jaGlwICpjaGlw
LA0KICAgICAgICAgICAgICAgIGNoaXAtPmlycV91bm1hc2soJmRlc2MtPmlycV9kYXRhKTsNCiB9
DQoNCitERUZJTkVfR1VBUkQoY2hhaW5lZF9pcnEsIHN0cnVjdCBpcnFfZGVzYyAqLCBjaGFpbmVk
X2lycV9leGl0KChfVC0+aXJxX2RhdGEuY2hpcCksIChfVCkpLA0KKyAgICAgICAgICAgIGNoYWlu
ZWRfaXJxX2VudGVyKChfVC0+aXJxX2RhdGEuY2hpcCksIChfVCkpKQ0KDQo+IA0KPiAqIFdvdWxk
IHlvdSBsaWtlIHRvIHN1cHBvcnQgc2NvcGVkIGd1YXJkIHZhcmlhbnRzIGFjY29yZGluZ2x5Pw0K
RG8geW91IG1lYW4gdGhhdCBJIG5lZWQgdG8gY2hhbmdlIHRoZSBNQUNSTyBuYW1lIGZvciB0aGlz
IHVzYWdlPw0KDQo+IA0KPiANCj4gUmVnYXJkcywNCj4gTWFya3VzDQo=

