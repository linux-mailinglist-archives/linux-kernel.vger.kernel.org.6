Return-Path: <linux-kernel+bounces-341384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D92987F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D142B21BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EE183CCF;
	Fri, 27 Sep 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ymp0M1ij"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010014.outbound.protection.outlook.com [52.101.128.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB414A0A9;
	Fri, 27 Sep 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421734; cv=fail; b=PfNrWppKPX602x8xc0fzLQk2XYlQR891+Gnen0h5Z3VuI/SfAUx0a5XbisSfiT5K86SGzDkDMEF+rxqLVayJmk2a63dWhQ94HzsWogTWfWuBnAuDJEIHzvz/Ei6sIF8KA9FZufAFGTZOdb8j5H7B8ZMrm+ALND3DxNu7AR+1B7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421734; c=relaxed/simple;
	bh=nhjQpRUHSq3GjhyuICLmQ4ibUcljIFIFFZVXu2gF/S4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AEjTKiUvGtl+fcT/kfgWGJZVLnCDNGFWnKzVin8ovnLFvTiMRH7JQ5Kkl7Oq6cFuXgPzmN11hhlNd7k7T75YdxOw8Ge4a49gTJv+vSC06dCxzN7i4VLiTk2T6Yb5yifPnxoaqR6DuVbPun+eGx5bKdtcilV3IMx9AYoMSwRGGJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ymp0M1ij; arc=fail smtp.client-ip=52.101.128.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeGNyxgKUhtpoScOyqNnRPQ6y8BzSiQm3CqMDxzCMRpxCiEHDx10tMSkVUusFkRd6KFcgKtQE8qgIwAVvUnLIJ34fBuMy7tgUnt2EAHCoGA2qrO0ZiUCK+/OqeagWZFW6HA4ISMtHiFjIaV7L9gLm3SuU2YX2wwBezEyBuGklsRrEiMx2eE6FMCQ1dP1ouKG4lo48dDoo6s4YxWzjaiB4mfJvqA1b+gJMIUVcqpqt5NOVhDb/wwrnPbVj2DLETsQXJyJ3tPGVQPk65ZoMg12KfhPc7FAGtSFl/2Hepdb6rp0GTqXX+UoKOgZGgEKrcug01FK8K4/i5C1ZFeAklwOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhjQpRUHSq3GjhyuICLmQ4ibUcljIFIFFZVXu2gF/S4=;
 b=DwKEh6K1OTgf6ADW4BOjhJoKmWAC4WkGhV1qVruKWD1VD9ygQnvduNAAL+cLB/70uBmVjF/JSje/oec18BJLVaiCMSBYZcyYAEmOgahbIhIr72WxFk7jhRH0+O48i/TkeQ+NEsXXS3PcChLlgQe9a1mPd8Ix+FmVwNv/8Jc1SSldM+ynwRbR7lHIiG45nZ4JBmAeaCApolXo++xvzz7MhAAAF7snUrvSc75Tj1EL9HCgYGIx8vDy0o1brWWmrAeQZ/yrgqMh7c+puT+W6zGjaO2ovgNoLBKDMAdykBXHxdLw+q9shiiKs5gZkqIp+LV63LCdwNUSAfrOuL4N0lWUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhjQpRUHSq3GjhyuICLmQ4ibUcljIFIFFZVXu2gF/S4=;
 b=ymp0M1ij37qQM+mPuxCRtQ51KBwlBycySfAv8oNsz1YDoP/Peke5ItSVA/hPF+J1RjZAuBQxL/wSNmUQdd2c4PAt085FRX6QllLDNuxMVxTTbPIls9d7FlWD6slxN+r0FbjEMyj3/nCr2+wfBoll25D4os0RueX7gKWQIhe4HrRtfu2YBL5aERmOZVcU2ylJNvYLcXl3HDDSxWSGMPeGZhuVlMUhpuBFwtxQuXuXOIjMVjJZ6OY/VNuAnUXQEA+xmvZsz2G+ghLZjU/ZQFuBQHsvE2q4+rXwe06hc59fDgNoPEP0k2hxFCRgA3FRfdJS7xlXW5/QzUkUY9ys7Qz0rA==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by TYZPR04MB7579.apcprd04.prod.outlook.com (2603:1096:405:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 07:22:07 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 07:22:06 +0000
From: Ricky CX Wu/WYHQ/Wiwynn <Ricky_CX_Wu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
Thread-Index: AQHbD7Q2eW66Wbq4s0SgBTKCf2nHYLJrJbkAgAAE6+CAAALoAIAADvNA
Date: Fri, 27 Sep 2024 07:22:06 +0000
Message-ID:
 <TYZPR04MB5853261AECA51C086E3FD30ED66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
	 <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
	 <TYZPR04MB5853E2B3197AAD9268A0BAB2D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <7fd8cffb3212de8ae6acd7ab434a22cdd94d7279.camel@codeconstruct.com.au>
In-Reply-To:
 <7fd8cffb3212de8ae6acd7ab434a22cdd94d7279.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|TYZPR04MB7579:EE_
x-ms-office365-filtering-correlation-id: 52e9309d-fead-48e7-e4ef-08dcdec517cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjNDNkJ5b3kzWXlCRjBWMThmVndybWdWbkVNTDRmbnNQQmRRejgyRDNpNDAw?=
 =?utf-8?B?RkhvbmNlNFBOQVFab285NUdRWFRDT05mZHZLckZXZ0dTQWYzOVBsYzZFajVr?=
 =?utf-8?B?M1lhT2VBZU9Mc0pCK0VHUkhKaHE1WFR4aktKN0RLaGVEQlEveGJMK3hsZnVO?=
 =?utf-8?B?N0p1U1NiZmU5bUxiWnEvdFlvWGlNVEZSdHQrdm5tTHZGYTJWREJDKzlWQTZs?=
 =?utf-8?B?NzFPVk1kOUxOcjh5ek9kUElGUU9DSFVNZGFtOFdCN2Q2UkN3bVlGSHZKWWQx?=
 =?utf-8?B?Nng1Nm83cHdqTDBXVkZ6b3lmWlhuRnMyK2dyN3RjbHpvVHp6WTNob3Yra1ZK?=
 =?utf-8?B?aTlPOERuNVd6RmRLekcwN0ZNQ0lxSGVrL2phb20yZ0dEOWNrSGNrVEVHSGFO?=
 =?utf-8?B?M3dvWXpMNW55T0Vhbnp3eWJ3N3hPRThHTU5GNFNNKzhhV0M4WUQvTDdOQ3J3?=
 =?utf-8?B?blRDcDNjSE5rYXBGL3hzSWdIcjNYTnZMV0dKVE1KRnZ3V2FhaGtmRm8vUCsz?=
 =?utf-8?B?alAwNWM0QmZOQ0o0elFxSzA2SlVXUzg4VmZRd1NKaFNvSGhLczMrMkVoMVl2?=
 =?utf-8?B?UlBBVDlJOXkxd1IyNm4wMTdCZ2Z0ZjBudHc0N0wvQnRzQzk4ZkRRSmkwakRD?=
 =?utf-8?B?L0tJRjFoWWw5S0hpYjN0UXY2eUhZaEg2TXF6bjlmVUg4YnlGN21LMkNqajRL?=
 =?utf-8?B?c0FhVHRMWTJWZlNTeU1jNURRcXIyZVJ2TFJURE5XUzZqYjkxYVhrbVNMTWNl?=
 =?utf-8?B?TDVrWnd5dWtqbE41YlBOS3cyRDdBUTJCRW42dUlVUjhIdmdWdi81R2M5SnhU?=
 =?utf-8?B?SXJVUEo3M0NuUk9zeGpEZDdqdVRZRHVlMXAwVS9NNUEwaDJOY2dyVDFZbGhW?=
 =?utf-8?B?S0tDMDJIaWhwM2JwYnBFQVhqWWpVSHpxaHBlZ2RZbjJGZklkWDdDTHMzbXcw?=
 =?utf-8?B?SjBUaGJwUlRhZ2dGMGdTNVZSbk56dW5kVjkra1pzV090Z0tQWk9PRVZoRkNK?=
 =?utf-8?B?QUdQd3kyMGhsWFpoVWI3RllTMXNqZkFHbnJ4bEszbGJPUXl6ek9pd1ZMRDZN?=
 =?utf-8?B?bWlsTFUrYWwxV21GUDhYVmVCcVIraVhXMzIrUnNieHhXQXhxNGdyY2J4M2lG?=
 =?utf-8?B?OWpmZk5uQUs1c1BmeGxFcHNtRDJ3WkZrVjRiWXJ1eHJ6NzdHamxrSE5EQ2Rq?=
 =?utf-8?B?YlkyV1p4a0Iwd2Nva2k0U01IZHYzTjAyVWhyMUtmalA5V2RpV3QrZ2VBWnll?=
 =?utf-8?B?Y0k3N05lb0hTV01vUjRyS0lLa1dMNUtmUDhqMUwzb3Nvc0FQeEpWUjI2RWdx?=
 =?utf-8?B?bGJKdTgreVVWUzR0bmlvNjE2Z3J3S1M3RDJSSk0rYVJsaUhUcUd5U0xiQ1Js?=
 =?utf-8?B?ekRaTUcrMVZjWkhsRGZBdXJMS0dGSENNSGl6MU95Z1FzMFNIK01jV1VYaFlu?=
 =?utf-8?B?dHJLRmlqWlpRYXZpbUlqa20xTU5sVG9wT0dKQURPR1RWWDBQL2lNQUFHVmFp?=
 =?utf-8?B?bGJQK3FJVWlramxUTUJsbjgrOGh4TDlIR0M3OFFQVFcya1VJdzN2V3YyVGVX?=
 =?utf-8?B?Mk94dzdOOGpGZTRPb25PUXU3L3VPbzY3dG5MVmhiaWdpQ0k0b3BqQ0RiWHo4?=
 =?utf-8?B?bzdHSlV6VFZMblJpckNHbE5OaWNFQ0FXMmtwMGJqT1lLMmhLVERPTFhKZExO?=
 =?utf-8?B?dGNiWVpMZ2xzTnVZNDFzeG90eGdaSjluSmczN2dWbkhEZmplak1QVG5RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkdSUkxFa0tGUzdOT2VuY1ZWV3kxc2hGbkZlbUp6STdjSTJUYnZocjRKcU8y?=
 =?utf-8?B?WWZJY29jY0k2OFdKOXVwOEVYRjRpM1RxWlZacGp2WEhxcDh6MGNYcnpTTWh2?=
 =?utf-8?B?RW96dkFTUE5xWmRwZjlldWNLa1hhZmxXOHNMTnVNK1kvV2RackNwVTVxT05X?=
 =?utf-8?B?bElrYjNjdEpkQnFZSmg0bUVqVnRuSlFIa205eEtzMmp4TVNVTjl3SE4xeVRC?=
 =?utf-8?B?clVUcmxVcGpUbGxiRnFXWFVSWE1CVm5UZURnYnRLdW43cnBFOUxSRDRqbTRh?=
 =?utf-8?B?eUhOaDVCWlZDdlNYYVREcmZJL04xTWs0TUVQcnNKQWtKalZjazNFa1gvRmF3?=
 =?utf-8?B?QUdhaExCSTNsR3ptNllRRmc3Nm80ZUJkVU1obHhyWEV0dy9KM09rdzJBTkVu?=
 =?utf-8?B?Ynp5ZEgrY0tEQ2g2YUhVRlovUW42L3hydHEvVWwyQXovWTRjR0N4aTNNcEJ5?=
 =?utf-8?B?TnB2My9PQ1VOY09oNVNiTFhhUlgwMzZTSDZFLzJvU0V4TnpxV3NPSm0zdE1C?=
 =?utf-8?B?RnMyMTJMck9XSFJrU2k0WDhXblZDY1Qrb0dvS0NRZzJhdFFlWjRyMlpCZ1B2?=
 =?utf-8?B?UTZhMHNLdzhwRUdpbWUxOGwvVy9JbDRRYktJTFEvZXlOUVozUWh5akJ2cWZl?=
 =?utf-8?B?MC9DOHNZYjRBQXg5ZHMvQWo3dnpWM3ZZdUozUzNQZ0pUeExIZ1RxTXRNWWJ5?=
 =?utf-8?B?WVpFalJScWh2OXNOMUhDUmhDZmZZcG5DdWF0bWY3bHBaUTkwTWxEVkdWVmwx?=
 =?utf-8?B?ZTRrVnVmb3Fka1RxU20yWUIrVElZZC9sM2ZFVGxiSzF1eTRPdEJhUzlWVEov?=
 =?utf-8?B?RTFXaXdrWjh0T01RZDFHcFp3V01DNDRMa29TMzhEV1NGendoa2NBVlVHUUVR?=
 =?utf-8?B?YkNZWEJVMFdEM3k5SjJqdGovelc1YkpTYkQvQkpiektzSmc1STdKS1NwVFhZ?=
 =?utf-8?B?bS9hblFwaEJOSlQzOU93T3RZYnhKOER0S0tYQWlNOUhNbElzQ1NRaUpoalQw?=
 =?utf-8?B?OG1DajQycmpnQ01wbmRoNjFwSDBidkp0THJOQnhaN281aU1ZenhGU1hRSWxE?=
 =?utf-8?B?STZzYmx5dEZOamJHUEdVTWhaOXdwYU10aGtqSGs4WUdaenNMMHNEc1EwYjlH?=
 =?utf-8?B?UHI5c1J4YTljRDFlWTRLNVVkYkpBTC96dVhFR25LRkJVMVE4NGdzSmZWRTUz?=
 =?utf-8?B?aUltNXAwSG44bDQ4SHJINkgxZXJ0S0xIeGFwSm90RS96U2VBQ29aUkZHVjlV?=
 =?utf-8?B?b0ZVWWRnaDJFWGI4eG9nVHVTU1Nrd2NhRXR6M3dRZ21XKzJQTVB2UFhBTWZW?=
 =?utf-8?B?djAvcG5qUE10US95aVkyZHVLYVRqclMyQnFqTDhEeGU0dUhaT0NxMWdVam1J?=
 =?utf-8?B?L1lidUxkWlByckRsSXRKRjJrdUlUaURNMksvSThpbW5keDFxOTZ4dnV5UzNX?=
 =?utf-8?B?bTBLaGdrNktIME5iTTdMOWpYMWxxRm1Ea2wxc0toVWhBaVBKTjZQYUw2SDJh?=
 =?utf-8?B?VGFEU2dxelEzT3JIYVVralBYdnlkcnU1VTBvT2dGekRBRi9HbzB4R3hGUGg4?=
 =?utf-8?B?UEg3Y2tpYTdNTmV6YlJqcjRoMHdxTVlXcllSaG93NzFlTnhaNk5NS2ZibTlT?=
 =?utf-8?B?QmNpSlhubG1PMHVJK0lUd1YrUnhFWnNCTDR2QVJpN2xPeFR4SGVlZ29ZMHlo?=
 =?utf-8?B?WG1UTlh2Ris0U2dHOEpTYXlhMXdGVHVzMWhWYnV0cXpaRWZZUFZndExVdHpZ?=
 =?utf-8?B?eDBMdWRLa0NtU2p2K0dHb2xOUWhId2dqcmpNeU0yRjh3L1lvZEtrU1djNGNQ?=
 =?utf-8?B?ZWxETEtDOU9IVS94VForMFBvb1VrLzI1RjJUdkxaWGxWbHpqN1dxVTRsVHRu?=
 =?utf-8?B?MytBUkFFVERoT3NYZ015UUFLY2VFT3dBaTdyZ0gvNWkwWHR0MnVuaUZ1OWE1?=
 =?utf-8?B?aUV4QWxwa0J5bk52OXB5QTNYZ1pqeFJnaWtkd1hZRWcrNmhOdDlDRmFpMG5E?=
 =?utf-8?B?b3I4R1FUZ004Q05XVU9BT3RRdUpXN3J3OUlpY2JWUG9kWmtzZWdaTm5sTWp4?=
 =?utf-8?B?R0NUVVIvUHIvQzdzZzkzOXhPRFQ3ajdhakcvZUlJQWdHLzR3MXlRRDhlaiti?=
 =?utf-8?Q?zR+2dNNGRVCaQnI465pj8vGBI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e9309d-fead-48e7-e4ef-08dcdec517cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 07:22:06.8726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VaISeqW/FePpEJWXRYD6ZSklbsTOExSW+wLGFslYaPYPnotglsNjIEdC39stnIbg9/33sIrBt9p7Sgwt5ZOI1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7579

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MjcsIDIwMjQgMjoyOSBQTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVs
cGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtl
cm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0YW5s
ZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndp
d3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJz
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxXSBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IGNvcnJlY3QgdGhlIGNvbXBhdGlibGUN
Cj4gc3RyaW5nIG9mIGFkbTEyNzINCj4NCj4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+DQo+ICBbRXh0
ZXJuYWwgU2VuZGVyXQ0KPg0KPiBPbiBGcmksIDIwMjQtMDktMjcgYXQgMDY6MjEgKzAwMDAsIERl
bHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVj
b25zdHJ1Y3QuY29tLmF1Pg0KPiA+ID4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjQg
MjowMSBQTQ0KPiA+ID4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4NCj4gPERlbHBo
aW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+ID4gPiBwYXRyaWNrQHN0d2N4Lnh5ejsgUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiA+ID4gS296bG93c2tpIDxrcnpr
K2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiA+
ID4gSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCj4gPiA+IENjOiBSaWNreSBDWCBXdSA8
cmlja3kuY3gud3Uud2l3eW5uQGdtYWlsLmNvbT47DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGlu
dXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRl
NDogY29ycmVjdCB0aGUNCj4gPiA+IGNvbXBhdGlibGUgc3RyaW5nIG9mIGFkbTEyNzINCj4gPiA+
DQo+ID4gPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gPiA+DQo+ID4gPiAgW0V4dGVybmFsIFNlbmRl
cl0NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIDIwMjQtMDktMjYgYXQgMDk6MzQgKzA4MDAsIERlbHBo
aW5lIENDIENoaXUgd3JvdGU6DQo+ID4gPiA+IEZyb206IFJpY2t5IENYIFd1IDxyaWNreS5jeC53
dS53aXd5bm5AZ21haWwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBSZW1vdmUgdGhlIHJlZHVuZGFu
dCBzcGFjZSBpbiB0aGUgY29tcGF0aWJsZSBzdHJpbmcgb2YgYWRtMTI3Mi4NCj4gPiA+DQo+ID4g
PiBJbiB0aGlzIGNhc2UgdGhlIHNwYWNlIGlzIG5vdCByZWR1bmRhbnQsIGl0J3MganVzdCBpbmNv
cnJlY3QsIHRoZQ0KPiA+ID4gY29tcGF0aWJsZSBzdHJpbmcgZG9lc24ndCBtYXRjaCBhbnkgc3Bl
Y2lmaWVkLiBEbyB5b3UgbWluZCBmaXhpbmcgdGhlDQo+IHdvcmRpbmc/DQo+ID4gPg0KPiA+IFN1
cmUsIEknbGwgZml4aW5nIHRoZSB3b3JkaW5nIGluIHYyLg0KPg0KPiBUaGFua3MuDQo+DQo+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1
Lndpd3lubkBnbWFpbC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERlbHBoaW5lIENDIENo
aXUgPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT4NCj4gPiA+DQo+ID4gPiBDYW4geW91IHBs
ZWFzZSBhZGQgYW4gYXBwcm9wcmlhdGUgRml4ZXM6IHRhZz8NCj4gPiA+DQo+ID4gPiBUaGFua3Ms
DQo+ID4gPg0KPiA+ID4gQW5kcmV3DQo+ID4gPg0KPiA+IFdvdWxkIGxpa2UgdG8gYXNrIHdoZXJl
IHNob3VsZCBJIGFkZCB0aGUgRml4ZXM6IHRhZz8NCj4gPiBTaG91bGQgSSBhZGQgaW4gdGhlIHBh
dGNoIHRpdGxlIGxpa2U6DQo+ID4gRml4ZXM6IEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDog
Y29ycmVjdCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgb2YNCj4gPiBhZG0xMjcyDQo+ID4NCj4gPiBP
ciBzaG91bGQgSSBhZGQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlPw0KPg0KPiBJdCBnb2VzIGluIHRo
ZSB0cmFpbGVyIGJsb2NrIGFib3ZlIHlvdXIgU2lnbmVkLW9mZi1ieSB0YWcuIEl0IHdpbGwgYmUg
d29ydGggeW91cg0KPiB0aW1lIHRvIHJldmlldyB0aGUgZm9sbG93aW5nIGRvY3VtZW50YXRpb246
DQo+DQo+IC0NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZG9jcy5rZXJu
ZWwub3JnL3Byb2Nlc3MvNS5Qb3N0aW5nLmh0bWwqcA0KPiBhdGNoLWZvcm1hdHRpbmctYW5kLWNo
YW5nZWxvZ3NfXztJdyEhSjYzcXFnWGohTGRwS1RyMzZZVjVlNGNDUmx5NWxJSTVpQ0YNCj4gbTl6
c25hdmlfdlJ1ZU5Xdk5IR1E4U2ltQ2YtWWZMMTRmeFhUUkwzRnhua21pZDRWTERsR1NZX0d4ZFhC
aFNUckENCj4gJA0KPiAtDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2Rv
Y3Mua2VybmVsLm9yZy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2gNCj4gZXMuaHRtbCpkZXNjcmli
ZS15b3VyLWNoYW5nZXNfXztJdyEhSjYzcXFnWGohTGRwS1RyMzZZVjVlNGNDUmx5NWxJSTVpQ0Zt
DQo+IDl6c25hdmlfdlJ1ZU5Xdk5IR1E4U2ltQ2YtWWZMMTRmeFhUUkwzRnhua21pZDRWTERsR1NZ
X0d4ZDBwS0FZbVUNCj4gJA0KPg0KPiBUaGUgZXhwZWN0ZWQgZm9ybWF0IGFuZCBvdGhlciBkZXRh
aWxzIGFyZSBkZXNjcmliZWQgdGhlcmUuDQo+DQo+IFRoYW5rcywNCj4NCj4gQW5kcmV3DQoNCldJ
V1lOTiBQUk9QUklFVEFSWQ0KVGhpcyBlbWFpbCAoYW5kIGFueSBhdHRhY2htZW50cykgY29udGFp
bnMgcHJvcHJpZXRhcnkgb3IgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBpcyBmb3IgdGhl
IHNvbGUgdXNlIG9mIGl0cyBpbnRlbmRlZCByZWNpcGllbnQuIEFueSB1bmF1dGhvcml6ZWQgcmV2
aWV3LCB1c2UsIGNvcHlpbmcgb3IgZGlzdHJpYnV0aW9uIG9mIHRoaXMgZW1haWwgb3IgdGhlIGNv
bnRlbnQgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5v
dCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYW5kIGRl
bGV0ZSB0aGlzIGVtYWlsIGltbWVkaWF0ZWx5Lg0K

