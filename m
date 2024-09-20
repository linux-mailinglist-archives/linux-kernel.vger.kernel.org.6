Return-Path: <linux-kernel+bounces-334055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9597D216
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A47E28635A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12955E58;
	Fri, 20 Sep 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="C+gxCUP5"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2058.outbound.protection.outlook.com [40.107.215.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6B5464B;
	Fri, 20 Sep 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726819027; cv=fail; b=TDJNWORX8vuqqvd50GDtMHH4Ku5BLST7AwpfcVuo0OOrnTpOEGA1+/sHZYthy9VjsVwcLApjcJPqPqSGYuYMIYBGzy7STBy/viJgOlu3g7Gc6LwqFZkVfZwo3dDQ9WFSoydPXOxAyAzNKfmwRjhAIVr5et3hTyYMACXMZOfjF4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726819027; c=relaxed/simple;
	bh=Bqh+u+Rd4q3xJPOYcNOAbk8keKyPxei2dHUnExW91qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qD29cpMw0KM9zK7HDJuo0Z4BNke4wHxnutgKJ3pHb0Y6HUpAvYxlAP/tW9Y5wIBE0lLUw8gGjefIaqqr8LzZ2GBLstxHEVEJnhN+W+r8w5wFh1DIE2tZW1y75TSp4UypKB2TWyebnDfB70ionusWswc41zBRMtC37UTVxX2KeW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=C+gxCUP5; arc=fail smtp.client-ip=40.107.215.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyv2AubStHBQjBuGfs2tObhTxMVSw9foh/YVJgAKy+UAD/AuJbXKG4BKA1jvppMeCbNyS87UJCGcTgfXaZ43EdB7xE8+LX2MYRIZ51jdPPOAmOkN3ki81Cu6q+XDQG6veRevsEtp/Rvr2PD04Y0Lq5xiYkkU0dibZMKWFglELolCcIWaqgLs7Vlgn+z74Z51585IY8xlrycTGjsbokl7FNjFP/lMS5kxEmJhmYA1DCLShaaunEV+csDY4y4LwesAz1vheTLtCR564LxKPEhxitorSFArBxe56BA/98B2b/OFgntteK5ngi+WZsamHnQYBoJfBEPRTKt/K7JfrQDc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqh+u+Rd4q3xJPOYcNOAbk8keKyPxei2dHUnExW91qg=;
 b=iD9XxeF1YhXjFNYRyrD63hbAguADlOKn0u104qbj1AZFVV/bTKJZnYdrh5ylIfkYHkQQTO+V+WV4uhG1HWbXyijqJg1rSsWxZlWIinQ8EgmyHEyv3bQ9uZOcb1rNfyJNXLGvSzlpvTOgPKRV5PRJox9vdcfI8SfMkpX1OfqASd/gCKM1XaHEDRu/jaUlFl/rCM9A0HU9iyYGXWG7XGth5hXxqKf7rOGsmJ1jf2SQoH1+O+xmuY8hG7iShrsXKzL1+0z4gZAzRCqpCVAiFH4KqyqqjYdBVmKbwBPlP2utRJTDhPrhxlJ0pVwqUSM9Uecsx7Ima81htptYCWUhxwaomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqh+u+Rd4q3xJPOYcNOAbk8keKyPxei2dHUnExW91qg=;
 b=C+gxCUP5to5Kr7Bi5/ThYZatpwCSiUD1a7sMc88LpLJATk8tBvelG3tl8BWzAG7em6RDHCeQIagEInc93mpOwAoEqg2i3nmC7zZaVH1rtjmM9Z8Smj/hgVG6ZqP7S4yv+VB4621ydA/bam4Ak6oX7WtksicI9Ceuyrk7+2H3pFdPkVO+R5Zl6BOQOGBYwZCTtACa/v0J9V0ubD/mLclPtt+PO3n4MfiSTOUK3IbonQbHVMPwOoUYxScmipy946LNuFyAB3U9Ta1bnlk6/qN6ECaMhBROMyUe0U3UgDXdLKvuCTeTGDwnJmdh16CA9Zyg+svWaxOHGt12owbttuDW7Q==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SI6PR04MB8221.apcprd04.prod.outlook.com (2603:1096:4:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 20 Sep
 2024 07:57:02 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 07:57:01 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Thread-Topic: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Thread-Index: AQHbAy4FlwSLCeSm/kuUF733v5UXHbJTbgIAgAzwncA=
Date: Fri, 20 Sep 2024 07:57:01 +0000
Message-ID:
 <TYZPR04MB585344D2C4C75DE832F4E9B2D66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910030324.2256698-1-Delphine_CC_Chiu@wiwynn.com>
 <63ce2d4b7edc52952a5f1bb97eb4dc8e7305045f.camel@codeconstruct.com.au>
In-Reply-To:
 <63ce2d4b7edc52952a5f1bb97eb4dc8e7305045f.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SI6PR04MB8221:EE_
x-ms-office365-filtering-correlation-id: 41f5b69b-ebe5-43f4-2065-08dcd949cf9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlZKVHFoTWY5bnZ1U2tJdTJKOHh2bGJ4cSs2ZlZmanBjTVFSQ0xXOVdRQmpm?=
 =?utf-8?B?ZnpUOURkR2ljc2xKS0NBbE4xdHRERUZOLzFaSW8zVXFRc0F5R00vM1FmY0d2?=
 =?utf-8?B?WkxWNSsvdXgyM3VNcThlN0t1bWhuVmU3OUtrRDdwNVpaV2NEVVh4dE5vcVpY?=
 =?utf-8?B?bnVIRS9rLzZINTF6ODVYMVcvV21VcU5KaFh3SEh5OXNkRDlWOHBzcGlWWnNS?=
 =?utf-8?B?ZjZmaGIyTy95V0tWTHJSa3ZUODF2cVcrZnpNcnM3WDBsNEFXZE1iVloyb3dJ?=
 =?utf-8?B?RldNYTBDK2ZsbkdNRlI0aWdUN3plWWlqMWtoRzdyWXUrRWwyVmFhQXk3OFMr?=
 =?utf-8?B?OUZCR2JLdURxYnYwQ0ZOVXV6aFRnN2R1dDh3QVFtdVlHQVVoTEd0azRaNEVT?=
 =?utf-8?B?RzUvNHFkWkRGbUhrUjA0a1JkVG1LZUdvbVRRUnhIdll4T0tVNVpKNmp3ZGM2?=
 =?utf-8?B?cGdJVHJsdVdsVC9hRm13MVNycDlIQkxkZzFKZ1I2WHE3TGlkTDY5WDVJUUdX?=
 =?utf-8?B?RzNHZG8vYzdRWXZ3Vjg4NGIxSGdmWmREZGRXc0t5OWZRMWIzcTRHN0oxWHFZ?=
 =?utf-8?B?USt2YU04dDhta3QxQTJybVhLSG5MVDFxbFp2cHF2ajEyUDJMUEhYUGtDclBp?=
 =?utf-8?B?ejdZTkplZDV6cGhmZ0svMG1FYVFDQ0E3bmtnRTRDcEZrMit0b1MwcUVnQ0pB?=
 =?utf-8?B?eWV2M3BiYlYwTGY0a1Jyb1NxcFV6UkhwV2Y4bi9vRVN4ZEIwcExKTE5xcjhv?=
 =?utf-8?B?ME15cFNlbVFjbHl5Yk52VHJaSzRQK0dKWnpXUk5wR0VPTVJacXR1emIvZHAr?=
 =?utf-8?B?TUw1VTFrRFZ0cDlxbG8xYnRFWDVEMEIzZ3RJSEMzNmlqTEE4UzR2cWRyWUdQ?=
 =?utf-8?B?bmdJNXUrR3owYkh6OVEwQ0lyR2VReEVHMXlNcThXQXM2bXAwcnhmblV2ZjQ0?=
 =?utf-8?B?UXR1V0xIZDNDaC83VTdRaFZHa3hCUllDbnhTQ3VvREFUV254YWk0aDVVUU55?=
 =?utf-8?B?TmlSNFlSa3Bmay9aaVY3eFRXU1ozY0Y3eFJjYWdyZDhkcHhMdncvY2p4aklL?=
 =?utf-8?B?NzM2a1Y4bHF3Y3N6d1I0OGFWd21TOC9ZTDN5bGQ2ejRzcjFmZUpSS2p2Y1hD?=
 =?utf-8?B?eUMxUU9qeFJjdDljTFdkMkV1QzlzNGJUUXJmOHluQ0VtdnJkaGlUaU4yQ04v?=
 =?utf-8?B?U2NoRHMvU3JzbDBENjNqUzR4QzNjRmw5TVN3L3d3eFNxNTNDbEtRVHhwZ055?=
 =?utf-8?B?MXF0Z3N0cThJbHZ5bTBjTCt3a2JHRUhtWjY2K3ZMTEhldUxKTHF0Q1NUT2ZW?=
 =?utf-8?B?OVpxZFpOT3ZEc3pZRVF1dFBhSEJEcHR1QXRNelZQRkYyMUR4Y21mOWdkY21X?=
 =?utf-8?B?VXRMeE9GTkxrVU96Y2FlMGxsQ2hxNmNQb2lQWDdDeW1zTEtNa3paT1RYekho?=
 =?utf-8?B?dndOTGFreW9wMjc5Ti8vV0ZMc0pReE1wS3cyMUtPdFdvVWRUemlBcHRHREti?=
 =?utf-8?B?dlNqK1R5YWFwZGdJSVJnWHErS1lZZm5aYlBXbXlORkR3a3h4REVyckJ3MXBW?=
 =?utf-8?B?d1JTOTM5MjNycHR2dVAyT3NGbHB2U1EyL0hreUgrd2t4cDRpN29nS2RmcVph?=
 =?utf-8?B?YktEcFA2cEVWSy9xeXNBaTFYZ0RVU2VNbmpKSVlvYzBCU0x3YTNPOXVKTFNP?=
 =?utf-8?B?RjRhWTRqRjlkbVZzeWY3REVLWWlUQ2RsMFF3V214SFd6ZjFrbkVlNXRlYlRi?=
 =?utf-8?B?by81TDFHUlBXVVhFeGxMVTRjaVdPbFhheTh3aVorTEMvWGVsc1dzVEMzbmty?=
 =?utf-8?B?U3JCb3JsZlJWaHE0L2o1SzMyUisybGdUK3VJYnVwdFphZEE1Q2dXOFdTY0lu?=
 =?utf-8?B?ZU1NTnZEZUNjM2NxaHRhR3J6aWdpMXlGL0E0djR3WStvUkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODBHN0JOVStkNFlzMU51UVRlOWJ6UWlKVG5jTU03aXdYU2o4VzloczhIaEV1?=
 =?utf-8?B?ZHBwdlVIay93SCtIQS9YRG1Ra3luMEk4bUFkVVEvazduc3h6bWEvNmJWYzBj?=
 =?utf-8?B?N0VSeXhDNFNRV3hzd2RiOWNOZUpPVk85cWR1eVp4djQ0U0Z2VDd3UmRzR3JZ?=
 =?utf-8?B?MGtCMlJkdkNCdnBUZmlHTG9LeW5UdU15TXc1cC9CNmRkd3BhczN3d0NWR3Rv?=
 =?utf-8?B?VGt1N0FKOU5XdWl4TGxoZFVCYzdVcXVDOUtkMGJleExJMDJLUUNNVEtVaGZp?=
 =?utf-8?B?c3NUWDdpZTd1Z24wczBsT01weGYvSzhzUVFaUlg5T3VLbWdZNXloWEU4dU9r?=
 =?utf-8?B?dHdkM1dCY2VVTGFHQjhDZHp4Z0ppeC82TkxqYjliKzFBNmVzUnhVcU9CNHdT?=
 =?utf-8?B?OXhaN2JjQ29sYm53Q3hpRnJIWW52Y2tKS1RIYTdiUkpOd2M5WHE1M1lURlBR?=
 =?utf-8?B?aVUxczdDREVFeXl2a3NRNnN0VmxYbGVVRHVSTG84UGRyWGxnK05PTHJDaysr?=
 =?utf-8?B?cmhSSlI2dXdnSFlBYWd0QjI4cHl2Y1czRVVYQU5aVmYzQm9XSnV4dW9TQUZm?=
 =?utf-8?B?SzdVUkt4eU9PQkxqVmxnRnpOSzNpVHlIaGJxcVg3OE8vcktCTVV1bGtaQVl3?=
 =?utf-8?B?aFdRU2dsK0hKU29pL1ZIT0RwQ2thUnFncUUxQlc5SE00UUJzT2FXcFdoZmZq?=
 =?utf-8?B?K3hXcFo2V3M5YWhEaWQydnllMEJHZ2R5WitDd2Y3UGtZOE44UEFDRS90RTk0?=
 =?utf-8?B?dlZRcHRya3VzVm1uUU1acFJMcG9YcXpwRTV4WHRmZ3hwSDF4Q1dxZ0ZzQ08v?=
 =?utf-8?B?aEpSQXE1SXgxZHFJV3daNEROVU4yMCtKd3V4Y2pvNmx4WWM2L0tSUHIyRjU5?=
 =?utf-8?B?VkZzcDdBVUNVczlMK1Jhb0xtTEpOK0pOdTFEaXlHdk12VkVEclp2WG5WVFRq?=
 =?utf-8?B?QmJ1M3Voa0lRMFE4eElDdEFxalZYUVJBU0xwcUdRV3VPUlZ3clM3RGFsMnY2?=
 =?utf-8?B?TE5ySjdVS2FpRU1GUjRHUVlSSkNxUXhsNkd3ZEpPVmpMMmxKTG9kalg5bjk2?=
 =?utf-8?B?a2ZTUlp6bGZCb3BVNUVwbnV5R1VIUVZ2aG5aRXRzZjBGQ2VyZDc1UDBjNHZm?=
 =?utf-8?B?d0hyU0YyN05QbSsvZndmKzl1ZzF1TFJoVzlIUi9FTlpVQk1ncnZZL2RrMG1s?=
 =?utf-8?B?NEE5MW9GcEQzZ2FOQjlmV3NERkxQaWE0SVFtTzBHRnhDZHYzeGxkYXFoNGFH?=
 =?utf-8?B?ZUhKY2lLanBnZlUwalB0M1BtRVh3QW5pMGFjbGdlalZtVVlsT2grN3V6SzRM?=
 =?utf-8?B?QnRlc2dJcXRmTFBrVm11elMwWXloVFZ2M3RXNHZ5QTFpSzArekY5NEZEMW8v?=
 =?utf-8?B?b2xMRXo3UHVPalF2RERJUDNLZ2tvUjR6M3U4NzBpekVYcW11N3BBeW1QRnF1?=
 =?utf-8?B?bjlkbWMwMzJrWmNqZkwxakZ1VDVtWVVSb1Bsa3VRNFlCWXozamo0cytQNmJj?=
 =?utf-8?B?cEZveEtmbGVoa0UzWmsrMXBEc2Z6NlhPSWhsMjlQSlc4NC9KRCs2Zi8ydkNq?=
 =?utf-8?B?eVBmcVpLM3Urdk1kNkRINXByRGFyUmV2L0hUM3ZXd3lTN1pPOGNla0tJUzJm?=
 =?utf-8?B?dFRMdEN0MTlneFpaVmMrMzh5ZHppd0JaM1dOTnRKV3pOVTVaSmlIcElGN0tr?=
 =?utf-8?B?TGk4NzFBZ2dmY2E0S2wvY2F2YTF3WFVMQ2t2SHFtSjNqY05yRUlTQ013L2Nj?=
 =?utf-8?B?Vk9QUUtRSzVCT2xxbFdtd2FjVDNLUDA2TGFkWGY4bW9qVktLd0lkQUMwU0tN?=
 =?utf-8?B?amtiVUpjQlpGWk9JK0E0TkRpM0NUcUlyY25DNjgvcVJtMXJtbFB3SXoyUnNT?=
 =?utf-8?B?MWtHVmdOZC96UUI4QXQ0VXdQakJHb2dOaDdKZmdBRjh1N2FKKzB6elVWeUE4?=
 =?utf-8?B?SmF6Z0Jya3lCelhuRE12WEtUZlZlK1BhL0xFOGxqbE9TMHRiNWpqNmJIVnJy?=
 =?utf-8?B?dTA5c2cvajY3NFpDZ3R0TVVPSTlSM013Q1lHbHI4L0pzSnlqVU5tUXRRYk5R?=
 =?utf-8?B?dGF3M2U5aHRuaFZFUnpzV21vM2RmVFFEZUZ0TktlMml5b0M4K1lmNGtXOHZJ?=
 =?utf-8?Q?vQLANYJcnoMEytdwce6uT9bB4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f5b69b-ebe5-43f4-2065-08dcd949cf9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 07:57:01.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xc4Wao+JOoweI4WjmSAAR6cRdeOizpRoIK3a6rdIUODSqHZp7Tm0gK6rlVyMl/W9MC4Npsh343JvFyPbTQ1rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8221

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAxMiwgMjAyNCAxMDoxOSBBTQ0KPiBUbzogRGVscGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8
RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsNCj4gcGF0cmlja0BzdHdjeC54eXo7IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+IDxrcnprK2R0
QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBKb2VsIFN0
YW5sZXkNCj4gPGpvZWxAam1zLmlkLmF1Pg0KPiBDYzogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1
Lndpd3lubkBnbWFpbC5jb20+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3ps
YWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBBUk06IGR0czogYXNwZWVkOiB5b3NlbWl0ZTQ6IEVuYWJsZSBzcGktZ3BpbyBzZXR0
aW5nDQo+IA0KPiAgW0V4dGVybmFsIFNlbmRlcl0NCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0K
PiANCj4gT24gVHVlLCAyMDI0LTA5LTEwIGF0IDExOjAzICswODAwLCBEZWxwaGluZSBDQyBDaGl1
IHdyb3RlOg0KPiA+IEZyb206IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwu
Y29tPg0KPiA+DQo+ID4gRW5hYmxlIHNwaS1ncGlvIHNldHRpbmcgZm9yIHNwaSBmbGFzaCBpbiB5
b3NlbWl0ZTQuDQo+IA0KPiBJcyB0aGVyZSBhY3R1YWxseSBhIGZsYXNoIGNoaXAgb24gdGhlIHNh
bWUgYnVzPyBZb3UndmUgb25seSBkZXNjcmliZWQgYSBUUE0uIElmDQo+IHRoZXJlJ3Mgbm8gZmxh
c2ggdGhlbiB0aGlzIHNlZW1zIG1pc2xlYWRpbmcuDQo+IA0KPiBBbmRyZXcNCj4gDQpIaSBBbmRy
ZXcsDQoNClRoZXJlIGlzIG9ubHkgVFBNIG9uIHRoZSBidXMuDQpNb2RpZmllZCB0aGUgY29tbWl0
IG1lc3NhZ2UgaW4gVjIuDQoNClRoYW5rcy4NCg==

