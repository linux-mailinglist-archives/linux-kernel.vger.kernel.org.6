Return-Path: <linux-kernel+bounces-332447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630497B9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F41F23D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB225176251;
	Wed, 18 Sep 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="BtjM3HA+"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2086.outbound.protection.outlook.com [40.107.215.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F3177999;
	Wed, 18 Sep 2024 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650005; cv=fail; b=DebRpdHKFqOTc8cKHI8HNrNDiijY0ucQZCKvX86lUS3A1T5oPFOHnVxLPxLwHQfaptW+yxRhvkfbd72VoRdqJeTLmVFgbrk/R6oje2jg91lpsMKs0f6XvAjXeiGQlG74UMMSg1Aq8bavEsWlXWojSSSopEI13pKTCGr7h4MUKdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650005; c=relaxed/simple;
	bh=Hjhdy0XwSZeFRef9Os+/raxwDhdpomzocASxoJBFtec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmeC8RfBWiAUrQVbFYSF6ieYpcT1A+0+eeU+WVbRTFuFImOXZRaYjVwohMrm+RZjAGXjpLGKYt1Zi+SVfR2EZbsYVbscJY0rBnMbKAbv8oRbpGEyO16smZKJMJTE3DzoO7vrANnYBjWV651PZiDZZr1r4Rh6jayEriDye+apgEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=BtjM3HA+; arc=fail smtp.client-ip=40.107.215.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myfveZTQ1bt7Z7EOeKXe32F7oFhMBo9GyXDiy6/vVfzpuMJAm5OQn4u0rt4Pk2rytFdTVlmuK7Bk9agQy+qflmfGlw7kGrlHAaIZhfiasbxBA8AAEfa6nospvLHoXgdXzKfjatF3jPUJEEQMUkJnNsmYrGDP6wvpFI8H4dThq+5A+SxaMf4yDyVyyGxzNg0lpuyf9Jwd8zbvZCK/7vrPq9OU3EFme3SvvbcyY7QDaDVJSLX3p/kOB1MYerCa897YupBaJNEB3ra61Rsekv20icDSg4we7I5S0/X8HUqzpGIzvxZdGRESlrW2wRJoYpASbKUlQFNRmL6IvXbMM/erpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hjhdy0XwSZeFRef9Os+/raxwDhdpomzocASxoJBFtec=;
 b=LKv/CcnjgI7ho9RtpOv91WdIxkOpscORQlXF7HnP3AxxGbR4mxd1i014Zfuf1Po8DnfC8xNnRiVReoAN7xbgq3OCUpNaPU2pXSKhWMmZlGTMo8xwhwjp1Y1lTcMTWgp5Cyg0I/rMVZ3iytDIK7uBgy/fgf/UY5KBiDNNXQYfkG/xmkIs4f0UmbhrnBazqGt2kLlW0LsMqv0eztPTYY0ACHMjuYBbGOJmJE0rjDh6HeaqleglVxKVEs6JTWw492oy+roplbWmTuVBWcUVyx4O53q2hRTXGzW5VAjFnUYIXuEH+wHONfp3sB4k+DGBWc+HxqPv70kNe6MOPMkdjfQIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hjhdy0XwSZeFRef9Os+/raxwDhdpomzocASxoJBFtec=;
 b=BtjM3HA+apct0mKQ7cDHS2fiqjSN7y4fAt5qU3wzAdrhuSg4h6k/TiRAfaA3shtzsEiFlBIlJJ/arPtcgeWYftTURhhTpWVl3Zbnaky1Bb0ZGxKjFYUJnH6QqdhIZ4IDdmJBs8xR18QztlKpEK/fjAjNc3TEb8aWeAH8NGdWJdgnx4uWKyP0Z5nQef2pVStorNdybQ2HE5zlMuEoRMrFPKkSp88hQlAK+9L/xv4Ci+E5auv92Oc4Mz1gLWE0UtDrD0jU5F7nRt/Ux2h+uc1W3d/pqked3K+SW34JokStblRz2XliXDqM3Sw4AGF/KQ4gmpapaMeveUrusU0pGt+JEA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEZPR04MB6201.apcprd04.prod.outlook.com (2603:1096:101:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 08:59:58 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 08:59:58 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable interrupt setting
 for pca9555
Thread-Index:
 AQHbA0xDBqBHzMeSJ0qlHcI2T1uCCbJQoAuAgAAMc/CACXgngIACw3AAgABXcwCAAAvuMA==
Date: Wed, 18 Sep 2024 08:59:58 +0000
Message-ID:
 <TYZPR04MB58531EA99903692B303957C2D6622@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910063952.3006665-1-Delphine_CC_Chiu@wiwynn.com>
 <42049344-fafb-4aee-8423-fe09a1a977f2@kernel.org>
 <TYZPR04MB5853795FDC6497F7E0114E43D69A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <10de03e4-db98-4b5c-9cf6-3f98a5cc0537@kernel.org>
 <TYZPR04MB58538354F2C7B6C767679308D6622@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <d9268240-4c57-4f5c-8ebb-82abb5ce0e3c@kernel.org>
In-Reply-To: <d9268240-4c57-4f5c-8ebb-82abb5ce0e3c@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEZPR04MB6201:EE_
x-ms-office365-filtering-correlation-id: 13a3bbce-8797-4c32-fd59-08dcd7c045d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHBOSFY3YVkxQmozc0N2VWJDRzlNbGlXbGsrRklVU0Mwci91R3BoWGNlenE5?=
 =?utf-8?B?YUVzdlA1UHVURGVoK0xXQTRoN2o5TktEZXY4ZjE2QWJFSWYwRlBCQ2JVVWEz?=
 =?utf-8?B?Q0hVZ25wNXRyU1pjeSs1bDBDM05FemZlWTRUdC82ZEhpeCtuVjYvSkVYSUlZ?=
 =?utf-8?B?cDN4SjhxY1R3NGlrbGZlMnVPQk5ZUzlRQ0drZDV1eEtHQmxtN3JCK0YvaUtU?=
 =?utf-8?B?TUgwdU5HeGpUay85bkJoZkREZWlqQWtBRnZ1N0pMMWJkUGRjWUQwNHRmOHl0?=
 =?utf-8?B?bkswWDlpTE5LaVduWlhtSVJLTGRKcVlScmNKc3pKdXlNenhOZi9HdkM1anJB?=
 =?utf-8?B?QlpPUE83c1drZzhxVDd4QjNXV2laeGE5QUxZeWtpNnEyblpia1RNYUJOcVhP?=
 =?utf-8?B?cDhVWHNodTQ2R0UzSDBlUlJxVEUrQnpGQnhRQ3pKRVpuMGFBOUFqQWhTcDV6?=
 =?utf-8?B?YVg3T1p0OHMxM3kzeWFQMmw5QmZKL0tPcHV0bzlSYUhsL01tY3R1UGtCZm1Y?=
 =?utf-8?B?dGxHakIrQkFJSCtmM2VKQmREeU9WUTFaT002ZnhkU1hWcG00VlJtMEJJNUxV?=
 =?utf-8?B?aFRWOXl3RXVkbVVCMDJIY1FrNVl2K1ZlNDNpeU9nUjVseW0vZUFjQ1ZjUEV4?=
 =?utf-8?B?d29xSnVNSXJhazVUUVBZc25FWkowWnNtWFlDNUpkaUZvN3I0MTlpVUVMQlBk?=
 =?utf-8?B?UFcwZVRPNHFRRFM5Nk5aclRiT0xZR1BUaEhCSFFVWVVDSVBJcWRTM3hZL210?=
 =?utf-8?B?bUdEZUR6eHlOVkJMcDVFYVdCQnZZUDVCaHhoc091QjcvVUZMTlJHZU9MK1lw?=
 =?utf-8?B?S0ppc2pXU01NWHFhcDZVSWduYzhJdkppbndndEpHYXM5TEdFOXB2ZUhqZDl3?=
 =?utf-8?B?UXZPWlRjTHJJMFFoNmJiOU1ObFgyMnFTaXRPM1NHM05XTTVmTC93K2NxSXY5?=
 =?utf-8?B?Uk14QmxlRjRHSHJPS3R3eHozYTNCdk1GTUhRM20yU2lJSll0RFY2UHNJZmM0?=
 =?utf-8?B?WXhkMG9WWjRTRVBuWU5CQzNDVkt0My9oRld1SFhpZ0ZPWjhRWlhPM1Z5emU2?=
 =?utf-8?B?cGFwcEh4NWRBMWIwcnpxZ3NaaE9GTTJZTlNEbGtKOFZ1dWtLMHk0QXFONlV0?=
 =?utf-8?B?QlVOanZMUUVuRFE2U25aRk1IR2VHZnZod1JjTVcxZXRPT1FYalI0Z3lFVzlt?=
 =?utf-8?B?MmxCak5QMzNHdTVCaVkxc2RBTmYrQUd0M2ZtbmhvRTZnL3cxY1BkZnpLNmp6?=
 =?utf-8?B?dEQwYzJuamc0YU5XSTdVVHU5L3ZDY05MUTE2Mm15dkRrMjhIR0NWKzBSQmJF?=
 =?utf-8?B?NEhUTGhVdnA1bDdIK2lYeXVuYlg0aXJJdFZCcm9RN2lKblpCOFdRd2hmMWlv?=
 =?utf-8?B?U3ZoaWdvdUtoU3ZPV2FHc1U2b1JEd2huWHpLanhpNWhtamkrSVBQRTM3NFZp?=
 =?utf-8?B?V05aTlltNGdQRnZsVHVxSzQ4MnFZTHk3aFhkbkc5bnhzbUhxSWoyaUF4eXNM?=
 =?utf-8?B?UjlGZXNjNzhCemdFOXVpYVFjaCtWNG5NT3hSUkVhYzVwZGNXM2NaamtWVEVk?=
 =?utf-8?B?bXZzdE9vVVdXM3Y2dVJQVkI4Q2Z5V2t5ZS9iYitsMk9ZcDA0QWtlNUo1bk5q?=
 =?utf-8?B?YndtZzhSOTBYczNjeTdYZW9GYWFBL29WSHZzM0VaTEdIY21VM2E5enFjK1dQ?=
 =?utf-8?B?eW5mVGZXVUFBM2JhQ1p2UnI5cnRvTERMZ3J2dEMyd1JPN0QrUVFHN2VxWFpa?=
 =?utf-8?B?elk1WWZ4eWN5eEp2VFA3dTdSS1VHUkFlNDJ2U0s3MTlDZVJJa3RSTDEwM1d4?=
 =?utf-8?B?ZUE3VUVXQ3RnRVd6ZUNmSnNzbVVrVWhKOGxUa1dQa0VQSmdWK0VGRDF0SjFm?=
 =?utf-8?B?NHMrV2RlTlA2MDVMVkZlems4QVRxeGthVEFlQ1IydWU5TlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2FUdHc3UUJDU3c4Z3hYc1NPRTRYUFp5dmEwQTZ2bTVQK09Zc3g1QUdhdWRt?=
 =?utf-8?B?NlRnN3d3ZHNmejhaQVlmL3BLaE1yQ09Lb0ZnQ2t6L2RPMFdQcXViM0VrL1Br?=
 =?utf-8?B?SEE0SnFzaFp1UlI2dnlXVlJ0d3prTlNMN0kyR3hSbDQ3dkVyRnNsZGljOXht?=
 =?utf-8?B?V0NsRmJqZTRKVDdkQkZNd2hCaEZtZ1V2YkJqaDYyMHE1YmhHNElRZGxjMk9M?=
 =?utf-8?B?SWhlN3NSZlpHdm1CbUVOdENuOFY0dUo1MDB6MWFSYTJla3hSc2JobGE0Ylo2?=
 =?utf-8?B?NDJXK25RSEtYTGdZeXkwZmVyWjlqMFZjOEpGUXArWkNzUUlpUXhQNkZYc3N0?=
 =?utf-8?B?cGs1a2RLd1FJdTJqbzBmNGlLUU85MXVINmZycmJ6MnM4SmpMcHFkdWZmajFx?=
 =?utf-8?B?c016b05Nby9WbEJGV0daMmYyM1hxNkR3eStUdWZncENJUytNeDdCVjdtWGk5?=
 =?utf-8?B?Zk9TV2l1NXo5bWNQVzZadGFsTWFRcHpMKzJMWFhkV0M0QjdGbHJvaVN4NzBQ?=
 =?utf-8?B?SFNrcGRQeG42SFFhVDJlRHBOWVZmZjc0aWthb0xMejIwY21YVDVYVk9ldUhm?=
 =?utf-8?B?UnNiTlFNekVUZ3ZRTjNqUUpKL2dNSXc1NUZTbUNZMmxOYmpxNDVGTWcybTBm?=
 =?utf-8?B?aHlqTzZEenFXMXEvWXFtdllCcVJweHpkTytCUTd1ZzlaS3JmN0ZVT2pZT05N?=
 =?utf-8?B?c0VvTGl1d2I5L1JyY0ltdW9HM09tUUVObks5V1BwS2JLWW5Hd1d1bXZ4ZTgy?=
 =?utf-8?B?OVF0K1lMNlhvZVpzNDVsSlY3bHUyb08zNFhhaFMzTU1MMDBrWCtJL2Z5Q3pB?=
 =?utf-8?B?aUJXeVVEZW9wWUxkTXA0NkNoMk5DQTlSaHVhVGc0YVcrY296QkJqb2xlSFZN?=
 =?utf-8?B?OTRkRWplL3F5YldZVTg2VjZEeXNZcGtoQmhXdlFLUTJ1cTRPeE9ON29Ra2Rx?=
 =?utf-8?B?Z3hIeGxOcjBka1Izcm9NdWNVT2JjV2szVmlyc29zYUdRb002cklkcENydTdp?=
 =?utf-8?B?UWdNSHM4TGNSbm53WWt1YUk5QmQ4NjlNbEdkS0RNV2xlL1dTMTl0YWZFajhN?=
 =?utf-8?B?bXlsWFBITTNtWnBUMG81cFlHUmsyWmtvMXZuRHl4WERwTVdCSDh5UDU3TzZa?=
 =?utf-8?B?Zk9ZZkI1aTZSQkx6TnFXZ1lEbThhOGVIT1dmNU9OSTNqR1g4c3NLT1FlT0ZF?=
 =?utf-8?B?WDIvT09LZUFrOGNzVjh1dTBod3hGSDVjZUxNcEhuOHRTdXRHZ1o2QldvNkUx?=
 =?utf-8?B?bnNyYitRblY4aEhEZzVvVmpnS0F5bWo4SUZpZlcyejNTZURaMVo1R0RORWJK?=
 =?utf-8?B?UHFBcGJoVVFRQ3BVaFlySWdBa3htNlhSOVZFWkpuaHZncTBGaUo4a1JJT3lx?=
 =?utf-8?B?Z3NKR01EeUZGUTV5YzNsZkNGRUsyVStkOWxrMjZqVURWblFZKzV1SVY1Z3k1?=
 =?utf-8?B?TmFnYnZucEJxSU0yaWVTcWk3Qm84bGRhNlpQZkUwOVZYdFVsT20rUUMya0Nh?=
 =?utf-8?B?TGRWcC8yRUgxU1ZwdHFIMlFWMldoSmdEenVERHNyczJoSS9GTG8renFET1FF?=
 =?utf-8?B?dk85RExFU0VnN0FaOWZOcDBza1had1NTdFVWNmEvSThwVUZWaHNIVVUxQTVw?=
 =?utf-8?B?a1RENWtnSXZpeE1QaVR1ZHhzOWdaZU1HMEJ6dmRwWkF1NlNlT0wzRjFlQThC?=
 =?utf-8?B?VkdqZTdtZGRJRjVFVDFqRjI2Mk91K3hwNU5Sd3c3SUdxbmlHVkFtL3pLaGtE?=
 =?utf-8?B?ek8yNHdYSWtFblRYaklJM0ZnS1RSaFIwSUNFRVhQekcwbmZBb0JKd1RkQ1JT?=
 =?utf-8?B?bnN3TUVuOWtrMERzN3FKS0J3OHQvOFhKY0txdTIzenIzM1hueEdCMXdQN2o3?=
 =?utf-8?B?MDBJYlBnQi9SSUhYZ2ZNQ3VneUlJTmlFYWdPVzlaekhmVjN2SU80TlFUWHc1?=
 =?utf-8?B?aHQ2c0t5WnNxajJXUTdPWjBmSWFNTEx0ZlpyZFRlQm96WXBDTVdNWXVzRGVk?=
 =?utf-8?B?M3A0OFh2cmRUZGZRcU5zL09jdnlJR1ozeisyQk45VVgyZHgwNm5wZEZCcFJQ?=
 =?utf-8?B?aGdxSTR6c0Z5YmMrVzZMTTZINWRkRy9DekpET2N0STRPOW96ZlhwU3pIZ1lz?=
 =?utf-8?Q?QN1Rxk9lEUM3g4R0yQ8zqGlRb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a3bbce-8797-4c32-fd59-08dcd7c045d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 08:59:58.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gqi6CMIB6y3nSonlrJrpB64sGwAG3Hct4x2MK+Q6e5Jd6b/BFcKdx1Fz5wtrsfwIS4TOsEpyxVDuRfMIGpraAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6201

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAxOCwg
MjAyNCA0OjE3IFBNDQo+IFRvOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5uIDxEZWxwaGlu
ZV9DQ19DaGl1QHdpd3lubi5jb20+Ow0KPiBwYXRyaWNrQHN0d2N4Lnh5ejsgUm9iIEhlcnJpbmcg
PHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4gPGtyemsrZHRAa2VybmVs
Lm9yZz47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEpvZWwgU3RhbmxleQ0K
PiA8am9lbEBqbXMuaWQuYXU+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3Qu
Y29tLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBBUk06IGR0czog
YXNwZWVkOiB5b3NlbWl0ZTQ6IEVuYWJsZSBpbnRlcnJ1cHQgc2V0dGluZw0KPiBmb3IgcGNhOTU1
NQ0KPiANCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4g
DQo+IE9uIDE4LzA5LzIwMjQgMDU6MTIsIERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IE1vbmRh
eSwgU2VwdGVtYmVyIDE2LCAyMDI0IDQ6NTEgUE0NCj4gPj4gVG86IERlbHBoaW5lX0NDX0NoaXUv
V1lIUS9XaXd5bm4gPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+ID4+IHBhdHJpY2tA
c3R3Y3gueHl6OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxv
d3NraQ0KPiA+PiA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBr
ZXJuZWwub3JnPjsgSm9lbA0KPiA+PiBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IEFuZHJldyBK
ZWZmZXJ5DQo+ID4+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+DQo+ID4+IENjOiBSaWNr
eSBDWCBXdSA8cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT47DQo+ID4+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
ID4+IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEFSTTogZHRzOiBhc3BlZWQ6IHlv
c2VtaXRlNDogRW5hYmxlIGludGVycnVwdA0KPiA+PiBzZXR0aW5nIGZvciBwY2E5NTU1DQo+ID4+
DQo+ID4+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiA+Pg0KPiA+PiAgW0V4dGVybmFsIFNlbmRlcl0N
Cj4gPj4NCj4gPj4gT24gMTAvMDkvMjAyNCAxMDoyMCwgRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dp
d3lubiB3cm90ZToNCj4gPj4+IEkgd2lsbCByZXZpc2UgaW4gdjIuIFRoYW5rcyENCj4gPj4+Pj4g
KyAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvMD47DQo+ID4+Pj4+ICsgICAg
ICAgICAgICAgaW50ZXJydXB0cyA9IDw5OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+Pj4+PiAr
ICAgICAgICAgICAgIGdwaW8tbGluZS1uYW1lcyA9DQo+ID4+Pj4+ICsgICAgICAgICAgICAgIlA0
OFZfT0NQX0dQSU8xIiwiUDQ4Vl9PQ1BfR1BJTzIiLA0KPiA+Pj4+DQo+ID4+Pj4gTm90aGluZyBp
bXByb3ZlZCBoZXJlLiBJIGFscmVhZHkgY29tbWVudGVkIGFib3V0IGFib3ZlIGFuZCB0aGlzLg0K
PiA+Pj4+IEltcGxlbWVudCBmZWVkYmFjayBmb3IgYWxsIHlvdXIgcGF0Y2hlcywgbm90IG9ubHkg
b25lLg0KPiA+Pj4+DQo+ID4+Pj4gQmVzdCByZWdhcmRzLA0KPiA+Pj4+IEtyenlzenRvZg0KPiA+
Pj4gU29ycnkgYWJvdXQgdGhhdC4NCj4gPj4+IEkgc2F3IHlvdSBzYXkgIkJyb2tlbiBhbGlnbm1l
bnQiIGluIHYxNSBwYXRjaC4NCj4gPj4+IFdvdWxkIGxpa2UgdG8gYXNrIGlmIHRoZSBmb2xsb3dp
bmcgZm9ybWF0IG1lZXRzIHlvdXIgZXhwZWN0YXRpb25zPw0KPiA+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgIGdwaW8tbGluZS1uYW1lcyA9DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiUDQ4Vl9PQ1BfR1BJTzEiLA0KPiA+PiAiUDQ4Vl9PQ1BfR1BJTzIiLA0KPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIlA0OFZfT0NQX0dQSU8zIiwNCj4gPj4+ICsgIkZB
Tl9CT0FSRF8wX1JFVklTSU9OXzBfUiIsDQo+ID4+DQo+ID4+IFBsZWFzZSByZWFkIERUUyBjb2Rp
bmcgc3R5bGUgYmVmb3JlIHBvc3RpbmcgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaA0KPiA+PiAo
b3IgYW55IHBhdGNoIGZvciBEVFMpLiBUaGlzIGlzIHN0aWxsIG5vdCBhbGlnbmVkLiBUaGVyZSBp
cyAoYWxtb3N0KQ0KPiA+PiBuZXZlciBhIGJsYW5rIGxpbmUgYWZ0ZXIgJz0nLg0KPiA+Pg0KPiA+
PiBCZXN0IHJlZ2FyZHMsDQo+ID4+IEtyenlzenRvZg0KPiA+IEhpIEtyenlzenRvZiwNCj4gPiBB
ZnRlciBjaGVja2luZyB0aGUgRFRTIGNvZGluZyBzdHlsZSwgSSBmb3VuZCB0aGUgIkluZGVudGF0
aW9uIiBzZWN0aW9uDQo+IG1lbnRpb25lZCB0aGF0Og0KPiA+ICJGb3IgYXJyYXlzIHNwYW5uaW5n
IGFjcm9zcyBsaW5lcywgaXQgaXMgcHJlZmVycmVkIHRvIGFsaWduIHRoZSBjb250aW51ZWQgZW50
cmllcw0KPiB3aXRoIG9wZW5pbmcgPCBmcm9tIHRoZSBmaXJzdCBsaW5lLiINCj4gPg0KPiA+IFNo
b3VsZCBJIGFsaWduIHRoZSBjb2RlIHdpdGggZm9sbG93aW5nIGZvcm1hdD8gKE5vIGJsYW5rIGxp
bmUgYWZ0ZXIgPQ0KPiA+IGFuZCB1c2UgdHdvIHNwYWNlIHRvIGFsaWduIHRoZSAiKSBPciB3b3Vs
ZCBsaWtlIHRvIGFzayBjb3VsZCB5b3UgaGVscCB0bw0KPiBwcm92aWRlIHRoZSBkdHMgZmlsZSB0
aGF0IEkgY2FuIGZvbGxvdz8NCj4gDQo+IFN1cmUsIGUuZy4gcWNvbS9zbTg2NTAuZHRzaSwgbGlu
ZSA3NjUgb3IgbGluZSA3OTYuDQo+IA0KPiBPciBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc204
NDUwLXNvbnkteHBlcmlhLW5hZ2FyYS5kdHNpIGFuZA0KPiBncGlvLWxpbmUtbmFtZXMuDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KVGhhbmtzIGZvciB5b3VyIGhlbHAhDQpJJ2xs
IGNvcnJlY3QgdGhlIGZvcm1hdCBpbiB2Mi4NCg==

