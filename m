Return-Path: <linux-kernel+bounces-246895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42F292C89D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332011F2333D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11C1802B;
	Wed, 10 Jul 2024 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f/Lvsp0I"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C42BB04;
	Wed, 10 Jul 2024 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578874; cv=fail; b=Mkzk4poN9G2iBM1puy6yAF5OeeYhAWis/UzjlxuFpGoscTwfjJEZBaaWWTVoujFsGGQ0ed02NCmg4sPcQ4iKih5qaO0cH1O5nEUOzENPKQ25HSP8dXSrU3byKsbuF8naY4lB8L380qvq9JqWDIDqTSzNZFYXLNmeGIh7Pr47HBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578874; c=relaxed/simple;
	bh=Ghmchd7RoLyrfVG36uw/Kbxi5Ey4g8nR4CxSJaU7Rlg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUs/wg9tIpEnkmPIR5VXd1uR4/E3R3g4erl8mdttxMb7lANtajNDslBwMh7oNgY4C1w29wh36B0z2ZPcdswwO2JXrIN0D9IVLy1/1BDq2qfr9z9OjSNMPFXcqNsFCCRBz6lXJjvJcvtzRnUV6spvw6p22RIg/ht8dmZlvjBjqOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=f/Lvsp0I; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyx4H0pkRpNdwq1i+ozBMy82cphj8PWc3aclsiJD1WWDxh5FA4rzJWTci6foGD4Y2BaYfD3wO+14BYNRIox95l4E5rXZgVNkBAdXlha/G44GuSoGkpn1tsHOny4Ch4apOpHH+pIeYx3N8xP7fABUMYMG/f182vAVJ/wzsA6P0j5/26fJI04SecdCN8NM+Xglwfo5A+2txweKTvPDVl/WI4VQGGIGZW44vrZKYqf84474p9gHcBTEpWzEq1B6etZnYwH+85AHfGsNF/fYFta8tNCaA0T1nW3YiPqOrpOVa7AbzpKfP3DpxXm9/mejCdTVF7LxJM2a20Lst3Xkv4AlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ghmchd7RoLyrfVG36uw/Kbxi5Ey4g8nR4CxSJaU7Rlg=;
 b=i4pzIQCydkSV5ZRc7jL5IGVAtJPKRD3jKqmEyyX4ZCY1Xjb2padwPHIlS5TsVAd9Th9OmmQcoKmzC85ZEWRbzRfl2JEnB4beqVlqQ722J0Z2IBzY9xYl6dO3TcbHHa8406b5SlrhVSoFsXFPXjb8XB4wAmcJVRjYsnqDpHqvcIpuAW8y+vyQCNsHKXY8wijMm9X/p8Dos++8T1wKFzzXZbIGD2irZqzDkliei61ck+RFhIm/9aC7SNR8BRTClZrsCSRB4gcm/LGRT8NV8OqGir12Fqlsoaapz/ylVcDaJT/GOZg3dqCawu5we4O5jjWC9xnj8N2lvHn374lFuZihvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghmchd7RoLyrfVG36uw/Kbxi5Ey4g8nR4CxSJaU7Rlg=;
 b=f/Lvsp0IIgC2QTz/aodGtWWSxd2I6Y392xOq0ouxGrDi3QwtY4jT34VzJsr8zq1HdcQUkmcP5mQ5o65YLdySO8+4ad6Jqzff0v1MnXD3A8JkbzgAm3GfiRWBM5bJFzqYk2MIqUHk6OqcX/mo2sPZDMuiMBVZ19eLzjJgsvLDEX8=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7973.eurprd04.prod.outlook.com (2603:10a6:20b:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 02:34:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:34:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>, Clark Wang
	<xiaoning.wang@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block control
Thread-Topic: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Index: AQHa0dSlmJsiuMOg1UmEpR/J2kHl/LHucI+AgADGRlCAAAWeAIAAAShA
Date: Wed, 10 Jul 2024 02:34:29 +0000
Message-ID:
 <PAXPR04MB851032D025F16B516E351DEB88A42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
 <20240709073603.1967609-3-wei.fang@nxp.com>
 <PAXPR04MB8459C43A1D11FA8A9F4AD0FC88DB2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB85108ED62C1178D9D0BED9F388A42@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8459724CAF741E00C61E8F5F88A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459724CAF741E00C61E8F5F88A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7973:EE_
x-ms-office365-filtering-correlation-id: d0d0028f-6dd5-450b-0c49-08dca088d2c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZFBPVnVaZS91YjVreDRwUUZTVG5jQzZ1SEVoYjZGck5XL1JBVHRtMHVrekJz?=
 =?gb2312?B?aVZIVFdndUIxZWVyaDc5UGk4aTNNWGxBTjZ3eHZMak85KzJPOTQ0L3ovQmpU?=
 =?gb2312?B?c3hNc3pFZVNKZ1E1TFZJWUtHa1Y2Ymh6VWRwY2NtUWgyWVAycTdXc0dxRUFk?=
 =?gb2312?B?cDdsd1M0WjhiZVA2ZlFCWUVSL0dXNHRZbXdIVXJRb3BKSHNTa0pBVFBQV1dj?=
 =?gb2312?B?RlU4czh0QVFHU0ZjWDFHMHNLeXNCMnUxbXNUZjhTTURkOTZaN21sM095SEhh?=
 =?gb2312?B?U3JROWt5bnBKV0w2cTF1RkNrVFNWVXhXY0QwOENzSCt0YldGTlpSM0t5Wi9m?=
 =?gb2312?B?WkxIUnFVUWEwTVFQOWEwMHYyb1pPT1ErdVhGQ0NJWHIzdm1FT1VZUmxvU3Bh?=
 =?gb2312?B?MnlnaHc3OVJ3Y2RFTlp4WHpnRHkydU4ycE55akh0ZHNQSFFDdEFlNGxrUU9B?=
 =?gb2312?B?VG1DV3llOC9RWDV3cHhOdVgwM0szaHFRVWdXSUFpakNvY014RXQ2aEdvNVg2?=
 =?gb2312?B?UVJKUFExNEFFamdjVlZwWXV5VlY5bDk2Z29ERmhmVlBoZnVmNHhySG1tRU1O?=
 =?gb2312?B?QTNvaWFwRUowbzZWWU1mb25BcXR4UE41OVdWN3B4dy8rUWdCNEc1QmhNbklJ?=
 =?gb2312?B?amFsK0RsZHRSeXhQVUg3U2U4Zm8xWm1xT203Y3FjOTV0SlFxbkcrYUFwdGFl?=
 =?gb2312?B?c1IzeGRoUUsvam0rdnlWdkVBdUFPQ1ZRRUx5K0NnRWNabUJLcXhodWc2R3pj?=
 =?gb2312?B?Q1MwOFBsSXBBUDRBSUtOdnVDWUw3MXo0TmVVUzE3eDZKTnk4b1Q3RzZHUCsx?=
 =?gb2312?B?TmsxTTA2MGY2Z3dzTGlETmZ5OTNzME5oZlRxbS9QYUhNS1pVNS92Zm9kNllV?=
 =?gb2312?B?L0tzZFh2OVpYN053WUQ4UnA3dU8yOTdFVGJjdGE5VVNjSU5jMmhHMEJnN0I3?=
 =?gb2312?B?YjlrTDlqZnVrc1ZoWTQ0ZVRPQXhEK0lQOFFITGIza2dXZnBFNVZRdk1RMmNx?=
 =?gb2312?B?YThvSVliOWQ5YmM3SmQ5ZmJJaG5KN2g5Mkw2ajJLUlltNzNoSmRvaTI4VHg4?=
 =?gb2312?B?Ukp3QXV4ekpQOTBNNktnSHdDd2txSGZwN2RaTHNwb1VwSnFzSWJncHJJQU5w?=
 =?gb2312?B?UHV3ckkvL05uNnVMeUxnQllnNEZ6TFovbmlnK1BaUnd5elVYelNaVnpqL0Uw?=
 =?gb2312?B?Zk10MnVjbURwTHk4T3p3a2hBRjFkSWZYcWpka08vUG5JVC82S09KNjhpVFJx?=
 =?gb2312?B?MDgrd0luQ0Y3MDNJNWxuTUdhM0RpUCtlbVJBRlhBb0lFZGtEclZEMTVMdFZC?=
 =?gb2312?B?L1BWK1FsR1pKSTRnbDU1TlVWSDZTYTd5R3Q3Yk5YOWU3ZUtYZW5Zd2NtbjhT?=
 =?gb2312?B?OUVXZ3h2czN4bTJlUnhpdHVwZ05XQWFOcDNkTmk1U09mV1dNL0JJenpwR1V0?=
 =?gb2312?B?bjV2UFNKeTJFQ2F0eUJUQ0cyRUJpeWovMlUvZWZYQWt4MVZ1U2UvQi9xNjZm?=
 =?gb2312?B?cFRRcXFJZ3A5Q2VNY1NHZE9EMXJqMGxBWkpWQkR3VE95d2JZZ1pyakU2SWxE?=
 =?gb2312?B?bm11Q1I0L09XL1UxMi8yKzRWOGhrL3BZMVE5UityZEZoSFJvRjdtWU4xV3Z6?=
 =?gb2312?B?MHZGNnFOcnNldHFRVHJBT0xpdTJWMmdtS3drV2UvbFAwYXQwdGdvajVCQnJZ?=
 =?gb2312?B?anF0b29zYWVJRnFaK0cwWGJ3cWVUcWNJTnlZZmlzbTRnc1BPRngyRUVNOFY0?=
 =?gb2312?B?NXdMWUVWMVlyQ2xjOGt1WTJBVDVnY3h2Qm1MQ3ZKNDB6UUZDOWUwNTF5OEhr?=
 =?gb2312?B?aGVlaUVOVlZBczVLdWFBdWlIUkJvSnJZVHNiKzA3S3VHckt0SUlDU0V5Q1Z1?=
 =?gb2312?B?T0UvdFdrSjAzR0pWSlJVTDZDdHdxc2htK2Z5NGk0L01OSWFhL3FxbVhjTlFp?=
 =?gb2312?Q?N1wkCXwX8WE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?TmlwTE94eFNTVlZQN2xicWxjVVlQWVVJV2hHNXg0OHBsUUE1OGloYkROUWFZ?=
 =?gb2312?B?K0duUElPSUFZM3lvTWt2Y2NFcnRBVkk1NkQ1Vng4RVluZTFVbUhvWWpnbDZU?=
 =?gb2312?B?eVdNUWM4cWNCaEJ5bytBMUQ3K2lSNkMveFZvRU9QcU5EdVdueCtHczhFL1BW?=
 =?gb2312?B?REUzZ0VRRE91eXdySFhVSmhVaCtsMEl2SVhmZThIZlJGcnowRGJtdGZDZmps?=
 =?gb2312?B?eVVMNldjNkpzNll2a3UzMmRYSldYMlQvdWpsZTdVbGhwdWJsWGxXL1NZNUhi?=
 =?gb2312?B?bVNvajFpdTY4bkdoV0o0VnhtYXdPdjVwQ1RsNWtvcnlUR0NBT2JPd0ZCTXQw?=
 =?gb2312?B?dkFraElNNU9qRHFYNlN4K1lldUZ3VWRJd3pUaVZ0Mkx2M3FkZ3FNK0YvU2lP?=
 =?gb2312?B?TFNVWVFISGFWL3NhdFhUei92NTlwVjlSaUQyNDhnMjBnMGZ0TDBUcG4ybHNr?=
 =?gb2312?B?TUE4eXgzSmwzbVQ3UFAzMlIyYUVqWHB2UzY2OVVzdFd5LytucUFnb3VUcDdz?=
 =?gb2312?B?WjdNQmQvTU1nOUU0eDQzT3ZxN3hhaVBncUVObFVVOHVnbzl2eEs3a2xSQ0Jw?=
 =?gb2312?B?TkU2bTV2WUN2SFVmRGpsb2w3UnprUmRNSUtzRkxpNm1uamU4OU53Nkh4cUQ4?=
 =?gb2312?B?NVZmSk4zcmp1dHIxOEFPTkwzbVg4S3JqN1hlSDdFTWNhVEM2WnlOM2w5dVpn?=
 =?gb2312?B?aEtYLzNNYTFQWEVlZzh1TGNOb1QwYlM0ZGVhaTJZSkJtUWt0UFg0RzBLeG5a?=
 =?gb2312?B?RkI3aHpOWURBVGU5WERGMEVuTzQ2elZtdGRwa24vcDF2czM4TXVwMjZmNk95?=
 =?gb2312?B?RjBPN2NISDk2R0hKK3JpOWkyVVEyREduUmxpWHJ2MFV2aFV0OUtoMlduc01o?=
 =?gb2312?B?OUxjei8yVURuem11d01UWURyQWFpR25Ybm5kV0p2SFY0Tkt6UlhjN2xsTmJG?=
 =?gb2312?B?cytrVEJlYndjY2I2UlplY2NORWEwdWx0cHV2VXcwUmdsSlo3VHNzMlhYaHd6?=
 =?gb2312?B?c0pvbFNKSjdJYTZqS0lsZDR2ZWFXTzJKQlRFZ2ZNSGJaNE91cytOazBlM0Uv?=
 =?gb2312?B?ZVl2WWdaMVp4Q0RqaVhmUXdISWJNaGZVUElTQjk3N2FZTWgxY0F3MzdpM3JU?=
 =?gb2312?B?dFBIYllpOUxnQUhrSVRhM1NzSDRITm1BakhFUW9Vc0ExUGhHeUdqekhSbXo1?=
 =?gb2312?B?WWc5bG5FNTJlL0NlM2JlUG9VZXNVZ3RBWlcrSjRXMFd4cVVud0JKdDVvMzg0?=
 =?gb2312?B?ODBPZnJVeWhrTm1oTEovLzdRYlh2ZS83V1ZQYmhDUkVocUZxc3JUdWFUdnRP?=
 =?gb2312?B?QVNPOEdBRitIeTNYcGhOQzFSa3IzaHIxb0hhZUhmYTJXOHkrSmlwaUc5Z1Ni?=
 =?gb2312?B?ZjdrRjluN29xdUFUNEpLNUlzSGtTb3pNMFFlVDAyVFpzelFqN0JFUGgrV2VP?=
 =?gb2312?B?Qm16VkhFdDJ6bWt4UUJMKzNMUDZ3WFNpeGc3dnR1aGw4VGJ6Qzg0d2pEK0Ro?=
 =?gb2312?B?RmlBRWZ5QkU1VE8rYUdzdi9MTFdNSTBqNHNMSnhSK1YrbUloNUM2Q1ZZSzdm?=
 =?gb2312?B?c0J5MVo2eFJtOExqVDI4S0dIWklWV3FFMVhYaWJ3anh3TTFnT3ZScThaMVJE?=
 =?gb2312?B?YU1Tc2IxY1VsODhhMk5FdVFNUVF1emhrTVRDazQ5dU9XajV0bnlndEpKZVFm?=
 =?gb2312?B?OVdoUmVCNlB6Z3o3VVphclNJdkh1QTNRYjNwdldIaHE5eHRFamdaOGVQOXpN?=
 =?gb2312?B?VUtSZG51VnRKaklna1UrL1dvMmFuVjg5Y2E2YWNBZWtsOXVyMkJ2N0UwSHJw?=
 =?gb2312?B?UTRFQlduSGdPd0RxczI3NU5yc1gybUdSUkVQSjJTMjh2LzZEZkliTUcyQUxn?=
 =?gb2312?B?NE9NZFpjdU9iTXF5SkE3a0Q3NXFNZEc2eXQrZG5ZYXNocGNpN0FycWxlTnFh?=
 =?gb2312?B?ZEJ4UVBPOW9UYlFIT2FnMXorcjI2VzRVbGFLQnIyalk5VkE1QnBvSEJyRlRL?=
 =?gb2312?B?VUZEd1hURGFOQjRnSThOcnZpcXFvN0hOUW1RclR1dUg3K3RlR2hzeW9IYnFY?=
 =?gb2312?B?UVVML0tnTitwcWxpNXk2ZmIwMmlVTGF2U1R4NGNBbllySDJnVGtmVU1UZkJq?=
 =?gb2312?Q?kWaA=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d0028f-6dd5-450b-0c49-08dca088d2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:34:29.1300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dad2NadfpJqa4s6YZHGoOyr20GBf5QEwLBSbjrgvIF1iZm4wadfyQK1YHHZIWC3mNjpXnkUn/JFb/PchhtGkiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7973

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqN9TCMTDI1SAxMDoyMw0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+OyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAa2VybmVs
Lm9yZzsgcm9iaEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+
IGFiZWx2ZXNhQGtlcm5lbC5vcmc7IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4N
Cj4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6
IFtQQVRDSCAyLzNdIGNsazogaW14OTU6IGVuYWJsZSB0aGUgY2xvY2sgb2YgTkVUQ01JWCBibG9j
ayBjb250cm9sDQo+IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8zXSBjbGs6IGlteDk1OiBl
bmFibGUgdGhlIGNsb2NrIG9mIE5FVENNSVggYmxvY2sNCj4gPiBjb250cm9sDQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMjTE6jfUwjnI1SAyMjoxMw0KPiA+ID4gVG86IFdl
aSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+ID4g
PiBzYm95ZEBrZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7
DQo+ID4gPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+
IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGFiZWx2ZXNhQGtlcm5lbC5vcmcNCj4gPiA+IENj
OiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gPiA+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggMi8zXSBjbGs6IGlteDk1OiBlbmFibGUgdGhlIGNsb2NrIG9mIE5FVENN
SVgNCj4gPiBibG9jaw0KPiA+ID4gY29udHJvbA0KPiA+ID4NCj4gPiA+ID4gU3ViamVjdDogW1BB
VENIIDIvM10gY2xrOiBpbXg5NTogZW5hYmxlIHRoZSBjbG9jayBvZiBORVRDTUlYIGJsb2NrDQo+
ID4gPiA+IGNvbnRyb2wNCj4gPiA+ID4NCj4gPiA+ID4gVGhlIE5FVENNSVggYmxvY2sgY29udHJv
bCBjb25zaXN0cyBvZiByZWdpc3RlcnMgZm9yIGNvbmZpZ3VyYXRpb24NCj4gPiA+ID4gb2YgcGVy
aXBoZXJhbHMgaW4gdGhlIE5FVEMgZG9tYWluLCBzbyBlbmFibGUgdGhlIGNsb2NrIG9mIE5FVENN
SVgNCj4gPiA+ID4gdG8gc3VwcG9ydCB0aGUgY29uZmlndXJhdGlvbi4NCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiA+IC0t
LQ0KPiA+ID4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1ibGstY3RsLmMgfCAxICsNCj4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+ID4gPg0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1ibGstY3RsLmMNCj4gPiA+ID4g
Yi9kcml2ZXJzL2Nsay9pbXgvY2xrLSBpbXg5NS1ibGstY3RsLmMgaW5kZXgNCj4gPiA+ID4gNzRm
NTk1ZjllNWUzLi4wN2M3MGMwYTUzZDQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xr
L2lteC9jbGstaW14OTUtYmxrLWN0bC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OTUtYmxrLWN0bC5jDQo+ID4gPiA+IEBAIC00MTksNiArNDE5LDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gPiA+ID4gaW14OTVfYmNfb2ZfbWF0Y2hbXSA9IHsN
Cj4gPiA+ID4gIAl7IC5jb21wYXRpYmxlID0gIm54cCxpbXg5NS1sdmRzLWNzciIsIC5kYXRhID0N
Cj4gPiAmbHZkc19jc3JfZGV2X2RhdGEgfSwNCj4gPiA+ID4gIAl7IC5jb21wYXRpYmxlID0gIm54
cCxpbXg5NS1kaXNwbGF5LWNzciIsIC5kYXRhID0NCj4gPiA+ID4gJmRpc3BtaXhfY3NyX2Rldl9k
YXRhIH0sDQo+ID4gPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJueHAsaW14OTUtdnB1LWNzciIsIC5k
YXRhID0NCj4gPiAmdnB1YmxrX2Rldl9kYXRhIH0sDQo+ID4gPiA+ICsJeyAuY29tcGF0aWJsZSA9
ICJueHAsaW14OTUtbmV0Y21peC1ibGstY3RybCIsIH0sDQo+ID4gPg0KPiA+ID4gVGhpcyBzaG91
bGQgbm90IGJlIGFkZGVkIGhlcmUgaWYgbm8gcmVhbCBjbG9ja3MgYXJlIGluY2x1ZGVkLg0KPiA+
ID4NCj4gPiBUaGlzIGlzIHRoZSBmaXJzdCBwaGFzZSwgYW5kIHdlIGFyZSBjdXJyZW50bHkgcHJp
b3JpdGl6aW5nIHN1cHBvcnRpbmcNCj4gPiB0aGUgUkdNSUkgaW50ZXJmYWNlIG9mIEVORVRDIG9u
IHVwc3RyZWFtLiBXZSB3aWxsIGFkZCBzdXBwb3J0IGZvcg0KPiA+IG11bHRpcGxleGluZyBvZiB0
aGUgUk1JSSByZWZlcmVuY2UgY2xvY2sgbGF0ZXIuDQo+IA0KPiBObywgcGxlYXNlIGluY2x1ZGUg
Y2xvY2sgY2hhbmdlcywgb3RoZXJ3aXNlLCB0aGlzIGlzIGp1c3QgbGV0IGRldmljZSB0cmVlIG5v
ZGUNCj4gYXNzaWduZWQtY2xvY2sgYW5kIHBvd2VyIGRvbWFpbnMgc2V0dXAgYnkgcGxhdGZvcm0g
cHJlLXByb2JlIGNvZGUsIGFuZA0KPiBub3RoaW5nIGVsc2UuDQo+IA0KSSBzYXcgdGhhdCAibnhw
LGlteDk1LWRpc3BsYXktbWFzdGVyLWNzciIgd2FzIGFkZGVkIGhlcmUsIHNvIEkgdGhvdWdodCBh
ZGRpbmcNCiJueHAsaW14OTUtbmV0Y21peC1ibGstY3RybCIgd2FzIGFsc28gZmluZS4gSXMgdGhl
cmUgYW55IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGVzZQ0KdHdvPw0KDQo+IA0KPiA+DQo+ID4gPg0K
PiA+ID4gPiAgCXsgLyogU2VudGluZWwgKi8gfSwNCj4gPiA+ID4gIH07DQo+ID4gPiA+ICBNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBpbXg5NV9iY19vZl9tYXRjaCk7DQo+ID4gPiA+IC0tDQo+ID4g
PiA+IDIuMzQuMQ0KDQo=

