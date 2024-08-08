Return-Path: <linux-kernel+bounces-278810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9AA94B51D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAB61C21A36
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20E168C4;
	Thu,  8 Aug 2024 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eU5p/8dT"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013039.outbound.protection.outlook.com [52.101.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A91D502;
	Thu,  8 Aug 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084804; cv=fail; b=tv29TUahtcg7ONXCmeY1vxaMnGAOdkVnuB/6YXr8LJg1MHEioYTXZGvemiWtQWcHCcGA6nzbrT1Oj9mIvjQagYQpqPKMVLrq86iviTL/jqBaWwV49hFq5ytb+/XsgAPJTs0nIBmA1YIq+65DFyqj0cv8G/LstP/bGCkW/mqvVSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084804; c=relaxed/simple;
	bh=ot9cqqx0xxND+ZOhijtw/T9EaMYh7SK985qz0HTMcm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SErKZKKd8lI9IgOLJuzfgRWOcvgcHn14/9f2itKHQX21vLB/yplW/R7xeKtLRsUo/4oAp2uaQCawkDC2km1TBDk3zhMwTRUYBGga3e79PklpqqhlEZKgYjf6Qyfzy84ICXloVmw7V57qRmQWUdO3DG8gpNHdI8f1jUtt5YMQr98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eU5p/8dT; arc=fail smtp.client-ip=52.101.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvSEagEQipNP692tlplZrCYKDp1X5llmbyrebY4KDZbAmhi84E5wdYxl9k5S29W5YD04Mf5vAeQBHxVZCOI234SjAuYsHIn4Y5X8s7tdE9v4pqOD48fQuw/P5MT6RP/QVy9qeqxI90hZGL9n3Q4R0Dehiz2ZSZenlROJQZiVpS75QLsHtjnkj1IsmCesVeNtF9nNR7Gmje8kjwVhKXqyG0sERCWdt6Kw6ovSC3D3M6PVyfmWeq0UULjTedLHP1W2XP8I7/0ptOvSNYtEEKWvoEYP6RdiNfGjEIr1uA1h0CGzbKvlGRO0miK8oya2abmXiiFovY4ciwcbuqD686M1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot9cqqx0xxND+ZOhijtw/T9EaMYh7SK985qz0HTMcm0=;
 b=yg9syYciaw3TqwhqabZAxRr14iK2NTFSnxxSO+t28nYXlFbnN+iJ4iWSv3d/gBCxdiPzhsgGWJ8dKQhoM6jvpi6DjBxeaOnedSO8re86sm2SEFuSxHzqq0jv6S34mDozbRhEKNUFJ+3uQZj/xn3DrywP/SwKtWuCtDPhKbS5YAzK10dE9zrCmltxgYRUuydpHEZuD9rH5ehrPLie9VrKURx7KfPmJ2pD8WBTE5EEpcrCDMxOT+SyJJA/DlbdykmhGRo29HYz+lbvQGnmUDuna0UJdQA89MUzzQhKdASM9NhMMpINuHbLC37s6vSnsKPwGx88DF6orSLu18/hIRgnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot9cqqx0xxND+ZOhijtw/T9EaMYh7SK985qz0HTMcm0=;
 b=eU5p/8dTS1WCgw9EAUD4kZGS3Kna40LSH4ArTMnv40hnJe1TCq5YZXi2HkS/DZdd/+qUlVYMgT+ut47pl6l/Ym4swwYeCJLq1gLqe+5UVTU+TFB7HSxLQLe+SFoZ/2PZknjEHzt3qzoilFW2wqW6541KaXkn0LFd903ZrTDN5KaIxldU6c3/1VBXPSff5iTJidvKcR7oNb9H3mJCpHdmRBnnkgu2JBbn04GfhBcT5x62k44DfStCyAVDbdLYT/mYZTtY1yi7x0FKCZ1PqZmquv4/VhRS5ZbMHimJb3yijGZj2kqFbDtXmLupDwzFYjyOCOHmvOS+9+AWZJZ7U8/N4A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10830.eurprd04.prod.outlook.com (2603:10a6:800:260::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Thu, 8 Aug
 2024 02:39:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 02:39:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 5/6] arm64: dts: imx8mp-venice-gw74xx-imx219: remove
 compatible in overlay file
Thread-Topic: [PATCH v2 5/6] arm64: dts: imx8mp-venice-gw74xx-imx219: remove
 compatible in overlay file
Thread-Index: AQHa6NmSruVnbHVC1kCLHHlSK//Im7IcpnBw
Date: Thu, 8 Aug 2024 02:39:19 +0000
Message-ID:
 <PAXPR04MB8459249991934356CA4CDFEB88B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
 <20240807-fsl_dts_warning-v2-5-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-5-89e08c38831a@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10830:EE_
x-ms-office365-filtering-correlation-id: a7d4bbc6-8e2f-44ca-fbf4-08dcb7534db2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXZPZExLWERNd1VIdld1YVo4WmoxaDc1VHhCWExHYndsNk55aldkblRvYVVN?=
 =?utf-8?B?ZkFSVGZ1MDhFbXUyaXhVMFZKT3JubjJBZjBVZTZaeHZ4dmR5c2N1V1FRcXVZ?=
 =?utf-8?B?dWRtNW4wZzZHZjBXbHRVUTRuTGRubVhKR01JbHNwM0RXUWgzR2VYU3FNbyti?=
 =?utf-8?B?Z25tZ0ZaK2xZYUUwZ1NGOE5PU0E4U1FENW45eW85VDZLTlB5M2lxVnBmZEIv?=
 =?utf-8?B?VXZFdlptdjJqbjRzMGxyVEdnRFgvaUkrU0lGc2dsNk5Rd3RkT0FsUk5kY3pX?=
 =?utf-8?B?emNyQVZoSVdab0kyM1hjYXZnMUhVZTU3SXRwb2lmNWtJR1lNWEgrN3ppMFdl?=
 =?utf-8?B?K0Y2aTRWU1lXTWMwMFZjTllZdlIzYWRFeEtrd2lkVHlZdW1YTWVSZGJQRWVK?=
 =?utf-8?B?dlFjZ3had2JGdmJFZ0JNV2xQQjVmYS9nZEZZNGxNaTBLWS9heHV0QTY1elpX?=
 =?utf-8?B?V2lKN3MzRXFhaWtaN1N3dlpvWW15d2FTTUJGeVRUbEVNMjhPaEdnZ1Q4MUNG?=
 =?utf-8?B?ZXpXZCt6WjNPRVEybmYwYzNzc3hLRmdvb21xZ012T2tKSWVwU2JCemo4Zlpz?=
 =?utf-8?B?aFJzSlpOQTExR1l3VkFpVU4zNTJreDJNOFBDdVBNb2IxeTh0enR1WEdrbDZE?=
 =?utf-8?B?a3BiZFVXZ2pISFhtMHQvbW9ORGJqdDJ2V1Bka08rb3ZpZkdMOWVqRlRxRUtP?=
 =?utf-8?B?M2Irc0w2WHhXZkEra1NaRTN6Q1h1bjJHL0xUR280NXVZK3doQmRrSVJUNkg4?=
 =?utf-8?B?amtBTGZLYXRLSWR6RUhoc1U5TUlMc29FWTJvUFcrQkh2a0YvS0Z4Z3lqcVRR?=
 =?utf-8?B?T2E2ak1tcnh4U01QUlpLNUNrOFJvODgrQ0V3N2FKNEpnS2FMMHhLaWhuKzha?=
 =?utf-8?B?UXRiaHR4Y0Vja3MzVXdsL3NCNzdVcFR4RzZXb3ZHczdDa3IwdUFrZE1mZ2VH?=
 =?utf-8?B?a0ZSUWJjNU1HTzZkejlRUG90UE9MU0VtMjNQanNSQktBRE9DdmwrNHdZV3ZV?=
 =?utf-8?B?M2pVTi85Zm1ad09Za0hKbURmM3RXNnNRNE1LYi91T05hL1hFdjFRdzNrVy9n?=
 =?utf-8?B?R0p4TWF4TnZObDlvenhNYi8ybkt3aCtNT21IallPUU1NTkg3OWhWUEFIeWkw?=
 =?utf-8?B?UjkzaVk2Z01yU1FvUmZSNjBMRExlM2ZFS0k4cmRLZ0ZlZ2x3bG0ybldwYkJw?=
 =?utf-8?B?YlQwQXhrTDVwTk5qenM0QWU2OVowT3dXbFV5Y3dIUThZWWRlSTZlU2lhVHN5?=
 =?utf-8?B?MXlGZTVGZ0ErTE9aaERiMmJqUEwxakI3NFNvd0QvV2l3TFVtS3BMUWtiTlJS?=
 =?utf-8?B?dTVTeitaVFloMjljbGNnN3d6YlIxUVNtRWo3M1BpeUVxR29rUWtXRHk3WTh4?=
 =?utf-8?B?OGFvM1IxNGxXdWwxZkJXKzZQMHBXVU03azNwL0pwK0VjSG42RUtwQTJNblBh?=
 =?utf-8?B?TktxSUlxeC85cG92cGlRTDNSb3g1dElDbEZoWW5yZkppejRpMEt6ZDh2K3J5?=
 =?utf-8?B?RlZsRUxRNTIyZTZIaDZZQlVaYWNncEswcnVURUwrM2NqK3BZbUVseUsxMTFa?=
 =?utf-8?B?TW82ZkcyQ1kxK0JRemdIRTBQWUdkMGpVdGZ5NFU4eGFjV1JhMVF6WnlKYy9U?=
 =?utf-8?B?ZUZnNGFIV3ZmSFp5TDBYQlBsNnJDbFdnbWU4eVovalBwTUdqaWhPOUxlcDdK?=
 =?utf-8?B?eEdTd0pIVzgvUXFkQkhWOWxZaHhhTDhEUHVKMDdWVDN3UFVpWEpnWThMK2Fs?=
 =?utf-8?B?MzV1SVFlTTYzUlRtc0hGd2dmenJyQlduYjRpbndBNTFPVGtGbTVCNXo3dFYz?=
 =?utf-8?B?S2hEQjlubEFBZnoydTR6UmNXSzk2S2RQL0x1Z2NILzJYNERjSkNhSW9kUUt2?=
 =?utf-8?B?N1N2Z2dyUmpXYmcwNXA3dXRscnVFLzBrdmdvdldSZmh5UXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHl5Z2VRaVJCTVNGVlpwSlBiTk5sbDVBa2tiUjh1Z1k5a3p1L3piWGswTFBk?=
 =?utf-8?B?cU53WjA2MjdXcmcxamZuOXE5WG9PSitNU0ZKMUcwSVByNEtXQWQvdlYyQ096?=
 =?utf-8?B?bFZBNFJHM1lkK2E4OUdZM0tpOGVqVFZ5TE9PTkhCWGZqTEh2bEpMK1R5ZzBj?=
 =?utf-8?B?THNySUtZSzJtMjlwdkxQYmZhSUJEMitVa1B0dS9IcmlaNUkxbUx2WG1DaDNu?=
 =?utf-8?B?WkNVaFpqK3BuT2YyTU91ZnZ1Nit6L0RDRGNWQkVSbktMeENmUGE1YzhabVNX?=
 =?utf-8?B?UlZBMnpxRzV6UDhGUEUyeERoRkNHZUd5NjVRNUEyVkkrbnRHVUp5VXczckkw?=
 =?utf-8?B?VDg2VDRCK0lPZEpqeStyZldKbkxPdm1Tcno0aE1KZjgreFFpSDduTlpCaEZI?=
 =?utf-8?B?cERsd01LeGlkY01HNEk5Y00yL3U2QWVYUVVyQ0xUTmxiZmVwMVZESzVkUXFX?=
 =?utf-8?B?MlFxRkQrZWl3NlVxc01jZlZrTS9oSkxsS1crNEJ0Ykg3V1p4SzAxbzdxOTQ0?=
 =?utf-8?B?cE1EMTM0S1JqQkRlaXhIMmxlZW1Fd25OOGFsS3R0QjJsaGxxRVBlaTZraE8r?=
 =?utf-8?B?UUtickRMWlJlQzhjcXpBTnZ4TkRNeEl3OXZFTjZnRkxzZ0trM3cyTWVydWxT?=
 =?utf-8?B?dHRHNXpRUmNkRlpPa1VveVo3QVBXM3h4dzBDSzF1d0hJeTljeEFtVGQvbTJY?=
 =?utf-8?B?RGhlTTNOdXpqZTltMnVEcWFrWGVWb1ZmUFdRM25zei85N0o5dFh5VzFYSWkx?=
 =?utf-8?B?bHlwRm5pV3Y0UnhIcTNZUWpMTHlXSG0wZUpZMHN1Q3JvZXNmY3hJNHdSR0M0?=
 =?utf-8?B?MGpGcDF1WTZscFNUamExUFVaUDRuT0JLVlBnTUVHTzl5TllOZ2t0Y1JtUmpv?=
 =?utf-8?B?T0JhN05LbEZQWlBRZDMwOFI4dmt6Z0J0NVdSY1Z5aWMwOUFxeUNaODdEby9C?=
 =?utf-8?B?YWp3Y0FZdUMzZkNHSWV0YzAwWWk1TFpRNzJTYXMzaWd2T1luNWZCbmd4UXIy?=
 =?utf-8?B?M1o3TDFZTGtBWkxWZGpEb3Y1a3FMMjNLWExkMmp4cHhyZXZNODBYK0Q4YjdU?=
 =?utf-8?B?VWJPUUpjc2t5TVdickNWSXZFazJTZElxMmZBa2tWYm5ERWY0Nnhkd3pnOVN6?=
 =?utf-8?B?WGpsRWIwa2pONFhyS3pteG15Yzh4TzY5cDFpTnhkNUhwem5FcG5JbEY5S2FB?=
 =?utf-8?B?dGVTQlJQbW1qVUtuQTU3TWhNQnpNbXFucGhUa1NBZVhUWSt3bnB6dnFWUTRE?=
 =?utf-8?B?U3pRaG9NREhkZmk1SVhJOXMybjFGaTBheTJnbFBhV3cvNlNEU3NaYTAvQmVG?=
 =?utf-8?B?cmljNlRFYlQwZ0xVMDRyWnY4QVpGTW5XNDNhS2lWTm52ODlxaVhHZ085WFlq?=
 =?utf-8?B?WFR4TUFDcXI2NHBpR09BQmYzUjZrL1gza21yZXZqeHpGTzBLVzJRdTBUWFVH?=
 =?utf-8?B?azFDNThDYjF0a0wyaDYyeDFHcHFoM1JoY3E1UnExR013WGZTQjhzYW5sby8z?=
 =?utf-8?B?ZUdwZmFzL2x5OEdjbW1yamNQZWEzM2JmMUYwU2ZaSnEwdm1hcDBsZTVzL0M2?=
 =?utf-8?B?eWwzbVppNlE1emEvV0xrR2lKK3FSdFRCcStENUNoSWoxRXlJTUhwYmczR0tP?=
 =?utf-8?B?clYxS1NQL0l3bnpoRnQxQW1KRGd1d25sSWwwUDlieUYxTjk3VW00MHNCOFFS?=
 =?utf-8?B?N2JUNGNxNnkvOEhCUVFDVEZxanZhT29KaEFLVndoc24zbTVoZk03Q05kVkNj?=
 =?utf-8?B?bEdrOVpnSkhvSU91clMrQ2lJL25pVFZXS2g2VnQ0WEs1T2t1YUNhYzVYY3Q0?=
 =?utf-8?B?L3J6VGNrVzZSc2h4c3lBcGJKd3E0L3Jqemd3MXV5eHZVcHM1YnBvT0tPNDBC?=
 =?utf-8?B?K3kyS2ZBbEJuQWIwR2liN2dDL1VrdHEzYUFpWHBUUERhK3FuelpyajBVMU4z?=
 =?utf-8?B?QjZLQ3JXWVM0Rjlub2hVM2RLV3lWNEpwU2VxeDZBR1lvUHhjdmlKYlpFQVhE?=
 =?utf-8?B?VFIvMS90QkhzSFNHUmE3TDRrT1dWWUp1SHZPWlZwVC9veGVTaGlsYWNoc2tL?=
 =?utf-8?B?d1MvUHlvanF0Z3dtYzB3SFo3TUFmVjVlUC9CWUo3anVrNXljZDY2UzE2cGYw?=
 =?utf-8?Q?jhvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d4bbc6-8e2f-44ca-fbf4-08dcb7534db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:39:19.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0utb2inLCwj2nf7hq49fZsNTj/DBp69XpNiU/TAItarZnSkIFszizP4Ybgxpj2s1XULEuscmsXLn3aK74GrnKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10830

PiBTdWJqZWN0OiBbUEFUQ0ggdjIgNS82XSBhcm02NDogZHRzOiBpbXg4bXAtdmVuaWNlLWd3NzR4
eC1pbXgyMTk6DQo+IHJlbW92ZSBjb21wYXRpYmxlIGluIG92ZXJsYXkgZmlsZQ0KPiANCj4gUmVt
b3ZlIGNvbXBhdGlibGUgc3RyaW5nIGluIG92ZXJsYXkgZmlsZSB0byBmaXggYmVsb3cgd2Fybmlu
ZzoNCj4gZ3csaW14OG1wLWd3NzR4eCcgaXMgbm90IG9uZSBvZiBbJ2ZzbCxsczEwNDNhLXJkYics
ICdmc2wsbHMxMDQzYS1xZHMnXQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5r
LkxpQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2UgZnJvbSB2MSB0byB2Mg0KPiAtIHJlbW92ZSBj
b21wYXRpYmxlIHN0cmluZyB0b3RhbGx5DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1wLXZlbmljZS1ndzc0eHgtaW14MjE5LmR0c28gfA0KPiAyIC0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVuaWNlLWd3NzR4eC0NCj4gaW14MjE5LmR0
c28gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVuaWNlLQ0KPiBndzc0
eHgtaW14MjE5LmR0c28NCj4gaW5kZXggZWRmMjJmZjU0OWE0Ny4uZWI2NzNhOTQ3NDg0YSAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlbmljZS1n
dzc0eHgtDQo+IGlteDIxOS5kdHNvDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcC12ZW5pY2UtZ3c3NHh4LQ0KPiBpbXgyMTkuZHRzbw0KPiBAQCAtMTEsOCArMTEs
NiBAQA0KPiAgL3BsdWdpbi87DQo+IA0KPiAgJnsvfSB7DQo+IC0JY29tcGF0aWJsZSA9ICJndyxp
bXg4bXAtZ3c3NHh4IiwgImZzbCxpbXg4bXAiOw0KDQoNClRoaXMgbWFjaGluZSBzdHJpbmcgc2hv
dWxkIGJlIGFkZGVkIHRvIGRldmljZSB0cmVlLCBidXQgbm90IGp1c3QgZGVsZXRlLg0KDQpSZWdh
cmRzLA0KUGVuZy4NCg0KPiAtDQo+ICAJcmVnX2NhbTogcmVndWxhdG9yLWNhbSB7DQo+ICAJCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICAJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9yZWdf
Y2FtPjsNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K

