Return-Path: <linux-kernel+bounces-310627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC2D967F45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F2A1F21AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15A1552E3;
	Mon,  2 Sep 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Peqc5QSp"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013016.outbound.protection.outlook.com [52.101.67.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E52AE99;
	Mon,  2 Sep 2024 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258040; cv=fail; b=RaCuoAD8wU3+3dIubJVrHesXteRcrthclL18yVbmr0vb73Kv7AnTs6JsbvYBp74rauehDMnQ4jYq1bvSRQdB0hNUIpeUP6wq/Cwr5VSezUu/NAZHZZkNH3IPXCUFwRWcsgVs1I+QLBlv19VJNf9cPUZMte4gAXXf6MRdSs1Ln6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258040; c=relaxed/simple;
	bh=35KUoXHr+zWvM5uJ7D05rj6ED8pd9y//gvie1Pkf4sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f5hnPKxgINL1BtOzTVZZpvBbFf1fcYVuPPH5PyytPbWK0txPjWkTsll+2K2180EZtHifKo5QjiLST4zMQ/WPRPuYwDufy0JbzOen214Z9ZYaHzVcUZZvhDlM/L+jvL2FUk60dUou4q5mH7QxvlOr7Pzu/AteIUkI6z4tFRJzWe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Peqc5QSp; arc=fail smtp.client-ip=52.101.67.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOh90qhGv1vEGSiqrSm9RlqQSg1gIiq3O1rzBgbUYC7wctWqjUdRQMuX2FDehz+JJ8xgbPQMZARtYlZa7MJ9Cb3ZXDOW3heII0aa2hQ1RM51TSkpueFbR04Std+Eyd2eX4Mtm+fNdHHCqCH6H1q4zoRRRHw6kSDPaAvn/HAkAMbcWAg2/2Tp/5oTYQSeCa8riVTQUbzUaKxWUCBXGBfJCJnZBAdblddiQt5v3L5vo1xpeuZwA2Pko7guRnIeiB1nGGy8qflUY9xKbDOXhmTiB1QXuQAXOJ7QaDM5mXJdWn2imLc/009HcBpjZe85fQ2PsiUii9on4IwverrS8BYVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35KUoXHr+zWvM5uJ7D05rj6ED8pd9y//gvie1Pkf4sk=;
 b=n9ktQYeE6HQ+LeleW3HgwXbcKelTnnAsIsrp3zTSVeeJ56VH8LpcxNyNmiBcpDSijSIxQrpg0QM1BG+A6n4hG2/GLYyEuEA/poQmZt57Q5d98IjXR5ISEVrUJrO/6+dkDik0/VyyUhSiHf/Q0pG0A90JFr6MHs644geZU4WZyV9w1l2PSPOSBJU4vtpgI7mpAD6WNUICdSpjjNhB1i3RwkYlD8Gl5E6QNp4XPT8ce8BGGWARDCjuYAoo0hccv+S9D+8EdivrrnoPbN+5zt4yFJMMFm6Z2AbABsbCXfPvwZtvUDVQRXwVTAGMb7kB28zN/mmriin11TOgU1zSj3toNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35KUoXHr+zWvM5uJ7D05rj6ED8pd9y//gvie1Pkf4sk=;
 b=Peqc5QSp+pfb0jQlO+0gjOhz+wIac/Z2ksdyKdtevg0oJghAD32x2iHsY5UD+XlYVA1wMHRJiZDM0Nqwzl2Bix8o+gxLaxv8v9M0pKj5lzmMnMpSB51MxRuje/vUB+XC7OP2XXxQvGYtWx3ytHd5ocNRlv/GYY8Dk9TUpv/gjK9T3y3rfKi6TKkDxSZytgfKOrDG/CAT2JPVsCgQAcYggE3RTANPM1pYLsEOlTRwTSpih+enc3o5Vsvz4DJR6RFBSo3PV/T559m+300jUxQ45AedKQ7pKHS6rNL1K0QVVy1QlbrhWNFGr706ZTMDmerh3y9qg9N2VmefMe/BiSzo8A==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8093.eurprd04.prod.outlook.com (2603:10a6:102:1c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 06:20:35 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%3]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:20:35 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Peng Fan
	<peng.fan@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] arm64: dts: ls1088ardb: add new RTC PCF2131 support
Thread-Topic: [PATCH v1] arm64: dts: ls1088ardb: add new RTC PCF2131 support
Thread-Index: AQHa+orZZab/kuCAHkK8oCFNm10KwLI/6leAgAQgXjA=
Date: Mon, 2 Sep 2024 06:20:35 +0000
Message-ID:
 <AS4PR04MB938617765AFE782F38A22B6CE1922@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240830032256.3701116-1-joy.zou@nxp.com>
 <ZtHigyVRl7goWD/l@lizhi-Precision-Tower-5810>
In-Reply-To: <ZtHigyVRl7goWD/l@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|PAXPR04MB8093:EE_
x-ms-office365-filtering-correlation-id: 5c604470-8b72-4ae8-2edd-08dccb175b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UkNXWkVtQlZzbk1ZVUZMYXcwUEV4QlhmSG5WTWFJS2ZaV1d2NHljSkZ4K2Fr?=
 =?gb2312?B?WDdVTlB3UXF5eGVUeUJZbC9aZGFLY2R1TVEzRzdXTTIraytWT29pR0pKNytJ?=
 =?gb2312?B?NEU3K3lURkN0aGcrOFRaNy9XUDlmdkQ2T0JDMHBvVXdiQS85WnpzcExheEpL?=
 =?gb2312?B?aGxTVW5vQngxYlFTVlVzaTFrUk1rQ0o4ckhvWkZjZFpLcnpIdlpXUVlyY2Er?=
 =?gb2312?B?Y3lJbXRNR2dud1loQy9kSU8yQU9odVhrVThvcUN0YjU1blFmQkUzRlhSRDNH?=
 =?gb2312?B?V1U5N0VBWC9heFdOTDZnTTE5OHZiUUljdWE0U2VtTjVJUzRTREFiVlpLTHBi?=
 =?gb2312?B?akV5Zk1XRmZsdVdpaUxmajJMaldFRkUwWmRpa1BMOGw5UmtvcXo2eHBpa1k1?=
 =?gb2312?B?azlad0ZnZmZkMklXNW5Sc1Q2Sm1IMHBuTmRIU1FPdHlBdm8yWU50VEU5S3hk?=
 =?gb2312?B?YStySzNMOExiaXg0T1pmdVVta281WEl6U1lYYkVBT3BBcldmc3hrWVpXSnNh?=
 =?gb2312?B?QzZpMTRJN043QXhySUxtcnBDdFM4Z1RKc09jRTNzenNNTXg4dUxHVHBnSG5u?=
 =?gb2312?B?YUpxS3ljd2J6MzhBeG1TS2VyYUxaRmhxTzhSS2pQRFViSUNIbE5YbjlVOTZi?=
 =?gb2312?B?SURWZmE5eHJxVi9LNEYrbzFlQlJQVms4L3dUM2o1eHQ4dnpBKzA2YThOczVD?=
 =?gb2312?B?bUt2Zkw0WGFiZ2E0cUVBRWp0TzQ0ZFFzSVlWclRteGdpbWZnSWw3Ny80SVZ6?=
 =?gb2312?B?TWdRRTRRK0IyMzF2MlZFbVY4NHVvYU5xWk1weWlBdi96dm1pTkhQYXFMQzkz?=
 =?gb2312?B?dTUxY0ZtaFZKUTVUV1lEWDRad3IraE8xUXBvNTBBdXNSdVo0QUZnL1BnY000?=
 =?gb2312?B?aWJnUC9uYjJLb1ZoSm9zM3d3UkVIcXVONkQyZ3hIb2FoUXlDbndJWExTUk45?=
 =?gb2312?B?Y2JGcFhtN2syNEplSWxudm9KOTJyS3haQ09IR3JLZXAva25QQXRwQlhySVV1?=
 =?gb2312?B?cFpIQkxrM1ZGTkJTdU5xdExBaDQ3eEFQenNzVk9vanUwbUVMMXZnNU00aXR2?=
 =?gb2312?B?eUFKRSt6Wjh4M29GeDdVb3E0eEMwVXQvLzNxTS9FQktrSjhINjNMUEdjTFZK?=
 =?gb2312?B?MVRVWnJzVzFkRmRoTStvK3NldUhFK29wOXErc1AyRUE3L002dFQ4QjFJWTd4?=
 =?gb2312?B?YnFDV1l4MTFoWnlPdEZpaE9FcWFkWkQ1U3hNeHhrV2NGeUFlMXBYSHY1b2RF?=
 =?gb2312?B?bFI4WEo5M1hKY3k1eEdsRUFybWdCVXF3b3RDR2Y4Q1BQazM1cm11Rjd4WXlL?=
 =?gb2312?B?TGtBWHViSVhjZ0U2M2lxd1M2UVI4VnZiN0Y0YTR3dm0vLzl1bjV1Y1Z6R1FC?=
 =?gb2312?B?OFR1SHBobElRVk5lcTQ2Q0NWamJ0dnJ5VXVPS2pNQTZMa051d3NvZ1BPZkxD?=
 =?gb2312?B?TTdVL2drTDBIU1RhWXVhNWVldVQxcG83UkgyUW9JSGNvWVJzekcxNDBpN05s?=
 =?gb2312?B?L3YvZ2ZFWFg4c1dJb05ha1hPc050UDFhTThaNGRoZnBTNlZNc3cvc09aRWQz?=
 =?gb2312?B?RUIxem1DUFVGa0lkaWc0UUcwbUVZTHRyenhwc3doYXhHM3N2U2dqZ1krWm92?=
 =?gb2312?B?QjNWUHp5Nmk5SHRDQUllZjcwc21yUU1NU2tsNFQyQ3VKOWxvWFJpeEtPSndU?=
 =?gb2312?B?KzVGMThOL1U1WEZjY2pZeEhkRnR5TXZ2WjNLTyt5MmdyaUxNSEVnWVRBTFFN?=
 =?gb2312?B?Nyt3dmhtQW5COGlTTTk5TzBDM0diM1U4ZGRVMy9Sam5GS3BaY3BtNE9JSGhy?=
 =?gb2312?B?bTUxTjV3cDFJbFc5blIraXhTbHJvelAyNEJsUEduMlJOd3ZhTWlKNFllZFF2?=
 =?gb2312?B?Q1lMbzJITFg3KzgxSEhiWnRReVdjdzNuZVZVczFEMVlEcGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eVk2SlQ0YU5xLytBbngraFpvbGdDNlpUeFE4djh5M1NqUXFhUWF1NDlTc0sz?=
 =?gb2312?B?Q21MempoMTlHNGdNUWdhSVJRcTFOY0xQZ2g5NDB2Z2p3di9iNnNKaFpNdWN6?=
 =?gb2312?B?ZDZzck51UkV0RXYxTHo0eHJjSlFBV2dYTFJNeDJPdWpiL0twL3J0YTRDai9n?=
 =?gb2312?B?ZGxxbnVMOFBLVUYrMzByd2gzNXMrZGpiTEQ1eGVPWkk3MmJXK0dQZVZSdlhU?=
 =?gb2312?B?RlNSalkydjRwTkE1QUdoSjNqZnFFSEpzSForNlR0bWtYMkc2eDBZSVFkMFFr?=
 =?gb2312?B?WkhsbU1hamQza3R3YmFxWkxqbXo5NlRmRTdtNHBDUXloVkpJbWR6TVFUUDJI?=
 =?gb2312?B?MkxlYTBaVmtIaVdKUit6Zk5QNnpVdm9JcHN5eU13di93dEllUFlGTjdzVDEr?=
 =?gb2312?B?a1RvTFFiVEtXakppN0V3elBwbUJBaDhybDVJNDlQMkZadjEzMnZuM2JjRktp?=
 =?gb2312?B?QTBqbmpVY25ncEgwNExXWWc0ZjZIR1h4NHE5TlFqMWF5S2xMMWtqM2o4RjBS?=
 =?gb2312?B?NExVQUxNeHR4RVJWYjZFbG1HOVRUeDh5UjdMRjJ3SlpGNkJMUzlWNUdiYUxu?=
 =?gb2312?B?em42YVg4RGdMVW5pUmVBZVFkZDFUMFp0a1hCSmtyTXJuSXZzdXA4bFZ6emVD?=
 =?gb2312?B?bjJNRmRIZkpZcHFMVVQ1Vzl2Mm1GQWFuMUZrMUlKZmVMbmdMYmFmYlEwS3Vz?=
 =?gb2312?B?Y1c4VnFveUZySkQ5djd0TW81djZpN2FINmwwT2lwQ3FGOElUSkN0V3d1dWM4?=
 =?gb2312?B?c2FkRENkaWF4dEdYb2p1dmw2UUxkL1VZZjdjaHNxTG9uWVE2VFpMVElDdFB4?=
 =?gb2312?B?R0h5eDI2V1l3T0Exem5sTEh6SWFCZVhwSFVHZmZLUWFWdDEyVkN4MkpjdUU0?=
 =?gb2312?B?THhGb3RJOTRHMm04ZUxGY3NXTFBuNUVzOWRadDhSdTBOUnFOalpKN0RpU3Bq?=
 =?gb2312?B?eTJxWE5yelFxVHZOaERRbVAxNnRlWmFTWHNBTXNIeGx3d2wzNHBzRko4QllV?=
 =?gb2312?B?RmhDbUVyQXVDNlhnTzFCQWo5alBDQzRrdWNZR2JZT3JjZlZDMW9ZcGt1Z1BW?=
 =?gb2312?B?NHk0NHF1RGgvVVQrSys2MjFRNzJXcG5XdWFzMmNXMEtKdk85NnZHWEZCS0RH?=
 =?gb2312?B?ekFXcERqT2p5SGQzcjBvUnZBL1VFQTB5cmdoS1lXS1Axdit4Z1dvN1NTaEpm?=
 =?gb2312?B?MEVFZER3d0xZRE1rUU1sbk9DNjlBTk5QVTJpbTFIYzMyQzNzQ1VoRCtTKzVC?=
 =?gb2312?B?ZDVvWVk3TzNSeFZDNndzd1lJNFJSUTI4My9YRk1RM1JIUlJ4V1pWREovZDc2?=
 =?gb2312?B?NlVmU0RQWmpzUExKSHI4WVg1SWR2UzFVSXg5TFN3TmNjbmRNZVduWU5zSjZt?=
 =?gb2312?B?U29KOWxQYXhIY1FxbXJGRUJVZFg5MnB6ZjVJSFRpN3JFUnlYTWI2R0l4Vzd1?=
 =?gb2312?B?YXQzcDlPN2s5RGZEeEg2ekU3RUprcTdqMVRNNjYxTTU3aUhxWDNXMFlWWGpI?=
 =?gb2312?B?bjdIYnFYVExHUzZrM2ZlbzZxN0YvU2tHNnNaS2NObEpOcm5ESjBVWE8xR3VW?=
 =?gb2312?B?M05WZHk0NUs3TVp4aHRuMHBMZ01uWVNsUi9ocWhaSFo5WWNSNlFUbUp5RGhF?=
 =?gb2312?B?SytneGhuTkVxL3ZtQ0tVQTFzQUZ5ckIvSUZqK3V5N0JNZW9yNk93SUF0MWV3?=
 =?gb2312?B?UUl5QzBRQzBXQlByT0E2NWNpcy83Y01nSjdQRy84ZUkwdzFOSlBUUG5icFZQ?=
 =?gb2312?B?VlU1UFQvWk5MVkhIbTI3R1VSVVVheS9oQjhzUEZUdXJORE1YZ2xLNWtLcHl2?=
 =?gb2312?B?WVlnc2hUMVZqdGU1QmN2SE4vWC81L2hkMGc3Zmw2TVFNRU9DOW5QQlNNZ1l6?=
 =?gb2312?B?cXhJNU9uSndwNFZLNDgvY3AyK3BrenVJUU55L1VuYm9PMnRyZFBsSnlqTk5W?=
 =?gb2312?B?NTdGQ0pMd3Y5elRVRzliNmZTYWY5RU1IMXY2Q0tDeDlEdEY4U2xwZGNXOWN4?=
 =?gb2312?B?ZVBGM21jQXhlV2ltV2I0MzJsZ3BiVzM5ZEw2VkpSa0ZoM2IxaW5FZXkrRGcr?=
 =?gb2312?B?SXBGVFFsdm0waDVMUGE5RlZPOVhOVk45VmZqNXVoL3k2KzB5akZmeVlyUmhn?=
 =?gb2312?Q?BmcE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c604470-8b72-4ae8-2edd-08dccb175b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 06:20:35.9103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MWGD8JFs7Wth90nMjigYqwzdGL0MI/4e+Cjs6ElPQ3qw8+nehWNRufLU65KpdYW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8093

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo41MIzMMjVIDIzOjE3DQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBZZSBMaSA8eWUubGlAbnhwLmNvbT47IEphY2t5IEJhaSA8
cGluZy5iYWlAbnhwLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgc2hhd25n
dW9Aa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiBrcnprK2R0QGtlcm5lbC5vcmc7IGNv
bm9yK2R0QGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gYXJt
NjQ6IGR0czogbHMxMDg4YXJkYjogYWRkIG5ldyBSVEMgUENGMjEzMQ0KPiBzdXBwb3J0DQo+IA0K
PiBPbiBGcmksIEF1ZyAzMCwgMjAyNCBhdCAxMToyMjo1NkFNICswODAwLCBKb3kgWm91IHdyb3Rl
Og0KPiA+IFRoZSBsczEwODhhcmRiIG5ldyBib2FyZCB1c2UgUlRDIFBDRjIxMzEsIHNvIGFkZCBu
ZXcgUlRDIG5vZGUuDQo+IA0KPiBBZGQgUlRDIFBDRjIxMzEgbm9kZSBmb3IgbmV3IGxzMTA4OGFy
ZGIgYm9hcmQuDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMhDQpXaWxsIG1vZGlmeSB0aGUgY29t
bWl0IG1lc3NnYWdlLg0KQlINCkpveSBab3UNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBK
b3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1sczEwODhhLXJkYi5kdHMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwODhhLXJkYi5kdHMNCj4gYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDg4YS1yZGIuZHRzDQo+ID4gaW5kZXggZWU4ZTkz
MjYyOGQxLi4yZGYxNmJmYjkwMWMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEtcmRiLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwODhhLXJkYi5kdHMNCj4gPiBAQCAtMTcwLDYgKzE3MCwx
MyBAQCBydGNANTEgew0KPiA+ICAJCQkJLyogSVJRX1JUQ19CIC0+IElSUTBfQihDUExEKSAtPiBJ
UlEwMChDUFUpLCBhY3RpdmUgbG93ICovDQo+ID4gIAkJCQlpbnRlcnJ1cHRzLWV4dGVuZGVkID0g
PCZleHRpcnEgMCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICAJCQl9Ow0KPiA+ICsNCj4gPiAr
CQkJcnRjQDUzIHsNCj4gPiArCQkJCWNvbXBhdGlibGUgPSAibnhwLHBjZjIxMzEiOw0KPiA+ICsJ
CQkJcmVnID0gPDB4NTM+Ow0KPiA+ICsJCQkJLyogSVJRX1JUQ19CIC0+IElSUTBfQihDUExEKSAt
PiBJUlEwMChDUFUpLCBhY3RpdmUgbG93ICovDQo+ID4gKwkJCQlpbnRlcnJ1cHRzLWV4dGVuZGVk
ID0gPCZleHRpcnEgMCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICsJCQl9Ow0KPiA+ICAJCX07
DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==

