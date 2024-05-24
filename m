Return-Path: <linux-kernel+bounces-188482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313978CE28A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4CC28319D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476D128830;
	Fri, 24 May 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lzEMJv5F"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9456129E72;
	Fri, 24 May 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540492; cv=fail; b=L5Qzu37LUBu6gGtKb9n13b/NTKfKecFKU0TE5UdzhJzPkj8E0kAdjlc+uP2bFLRx7fQsV/qxRNi39zXFW5gaL7ZGcz5/UBrZRvdxZULX+TLyEC9rTo8/nY6kOGnczFAG2TXHHWpD/jMrfyOn6V3F/gDkFksI5Rd+5x14jaFf6CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540492; c=relaxed/simple;
	bh=maUBS8lwJVJ7F7fPkL/LNZGOYajZV0DK+3wXC+d3+7A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QFoBHjG73/IxLXsix7DfzxKPGP5G6lwPCYrRoJZF4ECUG5ELKhTHKom4hnC9cBkw9CTfaNImU4RtS/vhSlhw7OV338CQpk/gsQ6xTsBkhUOLbTvwus/vX7m1lHfwWT1k5lsrRSPhLVE8WPqcRE771f52Q+M68fTl/4iQMTWFnvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lzEMJv5F; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ/n3ttP9UsPBxyeUrY8NvEGcSYKdXnGiaMTftWCOyTbH8ljj/qP0Muq9a/okVkynBwLQKb1VFcYM4Bwkdf/62VUkUjlcIzYmQkwSmmNl3aaY7f130Ptz/JfZeNwwDUymjVuvVXEiXBTv5FMaQqJi73GP+mxy9/XIjwNOVlmKMWA9pbB1bI1DjqlwWMHvaNOpkep5ITNMmNJwWCL+cbKfmXM52vILMHda62/d8TA9wv2bCJwZL37uX3Rw+AapWmSEMCT5GhJ2CO6yToHr5NZzLC0AdbIVVUCSc/n8p/fzvzCIRBm/nrbuoodiotgCvkNvXbyvc2Fwy7FhaT14MF6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvXC7aj8CdPSyHC5mKr9ZyjkOxagmn4DuQ76T39nl34=;
 b=HL/bzScUwfpsaCduIcDNFjqbOqwlEssCRTaHkROdOUBqa/rjbn+NWyj0YOLES4QSbtqMUygQI0J8pXfBww2CrS7x3tN03f2dgTI49BoYBkEe9pN0jojp0KsL2diwJOka2183MHKOtPpzD7y2JHEeR3Z4eMJSeCeQ0JfIp2HowpaOV4X9VfVSAPS4tFlTld+oz5uDWQ+mzWTgAkdJ9BUfbY4yoRTX+DGYEzWqA+8OXM1Y/r0CGVfg+dynGR0N4u7YBj56otm3y/L53oGcvhtYZvuE+Y4bB/zoz6GYPyzzPFHJKYCtTr9qUpFkWYQYwlYtm6373S2nU6x9frLRg9NjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvXC7aj8CdPSyHC5mKr9ZyjkOxagmn4DuQ76T39nl34=;
 b=lzEMJv5FDRO9Prg35Q4FeQp7grkOPzen1WhZ4kLwQdblK8hwSvAcFppIMue7qWWJkEFNXL3Ggq/Lff9A4to7ybk5WtfVL0eC/DRtWoRO03027XksC6iTDSxEUMkwoQftOBDAxqPjEif2O6bcji277/CXakXpQGD/9LuBIYjMDVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB9931.eurprd04.prod.outlook.com (2603:10a6:800:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Fri, 24 May
 2024 08:48:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:48:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 24 May 2024 16:56:44 +0800
Subject: [PATCH v4 2/6] dt-bindings: firmware: add i.MX95 SCMI Extension
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-imx95-bbm-misc-v2-v4-2-dc456995d590@nxp.com>
References: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
In-Reply-To: <20240524-imx95-bbm-misc-v2-v4-0-dc456995d590@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541024; l=3068;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=jOGh34hNYtgrB3ysqbY5VPgRsqG8KK1fo2mx+9aW9nk=;
 b=UTrPVmTaF4kP1gw7YOYGKTSVmrdERvgmmY2Je3WUs3I9YBYACfLejAJtL0JN1YsD/pDwrhW8l
 L/Zf6K9+hvpB50apSubCYSsfymX8CLz/F4/5K6rTPwvQmnpdNFtgZNN
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 1504684a-3470-486e-f7f0-08dc7bce3bdf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|7416005|366007|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGJMaGlVdGs0TEkvVzJxOW5kVHdUbmNsOWRVTnRaMzZ3cCt0VmVKdWN3WWNI?=
 =?utf-8?B?ZGNPamVqMm1IdDBYZ0x6WUE2aVZIQ3Rxam1wZTNQOEdVdnZhcEg3aGxuQVJX?=
 =?utf-8?B?ZG1ucUNIZ2ovazlLcFQ1SklaQjlnaTlZZng0R0ZDU1Q2Z2xxajg2bDNvUmg2?=
 =?utf-8?B?Z2ZiekU3S3h3NU5sSHVFY1M0bjBONnJNNXJzVzJxbEtyTldIWjdRa0RPU1ZN?=
 =?utf-8?B?dE1MUC9UbFk3M0FxSzFlejkvVWxiSUtwZy9kci92U1pTMFJHdk9sd1Zib3pq?=
 =?utf-8?B?M21rMU9kV2cvRlFoOEZHZWNhSUoyQ0FzTHN4em0wMWlSQlB3ZTJDS3RicStr?=
 =?utf-8?B?K3NNUlN3YTlkOW1JVlZ1SFdwN0RNOC9FZmF3L0wxN1F3Q3lhL0wwbTdwOHI2?=
 =?utf-8?B?b0FjTUJMUWJxN1JpU29wVnI5ZEY3QkQ5OHZLV1lHVlVQSDBYenBnZVJmeG5t?=
 =?utf-8?B?aW1GUFlUK25Ha2xpd2lnN09pRk42VitjdVhiODBjMW1sa09JSmdwU3djQVR1?=
 =?utf-8?B?U2s4VzhzSlo3Yzg5VmpSM3dncGJFb3V6Q1VlTWU3amEzajFaOHdWTEI0Q2px?=
 =?utf-8?B?dEdDVC9JWnhZcWRqY2FkSU1HUzZNNXNhNk5EMEJWUUNnU00zYkJzT2hLRmJE?=
 =?utf-8?B?c3pPR2hWQk9DdHR1Uml3Zmx6aS9CcEhWYnJZU0IvbFljSkh3WVFGU1ZFL2tV?=
 =?utf-8?B?MVVwZ0hTb0V0bTBYNHNBM21WNEt1QlV6aHFBZ3p5Qkw1RGpyK3krWFIveGUz?=
 =?utf-8?B?d0ltNWhVT1pHak5BUnAzRk1VWmJXcVRoUXpoSHo4V0hIZlNvYlZJZW5NZlZM?=
 =?utf-8?B?UkxZYUxXd2FVM2dxak90TmQraFA1YlF2dHNSdHFQRFhiTGtLdnFQVjdBdU5n?=
 =?utf-8?B?anFjVncyNWNtNHo5QnhEUDZDOUwyeUluZEdmeWJhd0hnY2JWaFpsQ09CNDlM?=
 =?utf-8?B?d253QmNQM2NGWDVrUDdSUXVnc0szRGV5UVpZYkhRb3o1VmVERHgwVTA5RGk3?=
 =?utf-8?B?VXNoTEthTmFQUEFVOE9LL2Z5K044WmoxV1lCSDJFNDh3YVpBaklkMGJkWWhi?=
 =?utf-8?B?am9KNGk1Q1lFc3orbmZUdThNa1dMNGdLVVM0ek5lYWU1Qnp5QkU5d3pyTUNq?=
 =?utf-8?B?bXc5YWtCejFScXNUZ0cxejlhaHNvbXR4cXh4ckpGQzc5T3RaM3QvOVAyaVhj?=
 =?utf-8?B?MUdmQXp1eUhxZE5pdXVFdTB1Tlg1dW9pOHBmWTVWY3MycUR5azBvVEhuYzJ5?=
 =?utf-8?B?MFl4VUE4a1hqUDB2UWU4SWx6dkt5UVZvSHJtK2p0RzRmU3orK2h2M0N5ZVlE?=
 =?utf-8?B?STBVUjh1OTBGKzliY05MdURaY0xVdVhqbzFMZkVZZGFCd1RxSVorV3M1ckVq?=
 =?utf-8?B?NDRTQXRiU3RDS3JNbForaUU0aTY1SDZTazNid2d0WXY0amI3czBOaWVSUE1w?=
 =?utf-8?B?Myt3Z3k2RlpXUGRRL294aDN4TUozTXMvZjhiTUZCS09rQlJEWHZTN3lMa05h?=
 =?utf-8?B?RGRnclF3TUJoa0tPNTQxWDUwV25CSWpjSWtoWGR6QWVpQW1vVmx4SDdVNjNT?=
 =?utf-8?B?a0lmRUFKV0xqZXZLTkpONFhTT2x3ell0Y2wxTldOYUZGWmZERlBXSWkvY2J5?=
 =?utf-8?B?UlBtUVN3dmtkS0dvajhYemNTNW10TjJWYXJmYmZkZ3lHVGdzQTNXS3d3WmxF?=
 =?utf-8?B?dXhTeTNJM0N1dlVINlZnMFRxZ1RnUjF5cll4QUZQQnRhK2FhQnFRWGxSbTh4?=
 =?utf-8?Q?kgI3/qA03cBS//qgOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3I2NXZaVFlxT3h4eFNSa3lzVXA2SXh5VDIyTVJUUXVsT1hyUlJyN2I5cnQ3?=
 =?utf-8?B?VG9GMWF3NkxtL1A0N2JSVUFkY1lXV0tGOUh1a1VtTjRFSXRLcFVsc09qbkQ1?=
 =?utf-8?B?MnMwV1cyekxqQVZ2eVlDZ1Y0M2d2cWR4aTNjWHQvNU9hYzNvOW9YaHpsbFdP?=
 =?utf-8?B?WGlxV1hDc1pTaldGNW1IZzhvV0FKby9sYkRwU200ZHV2ZUt3MmxMSHR0ZWVF?=
 =?utf-8?B?RkY5QmwrbmRhSFI5U0wzVThTc29VT01JWXQ2VUV2UzlZaFBQM2haRzkyd1E1?=
 =?utf-8?B?bFJLRXlQOG5MaG1ySW54RWZHNjRnN1pzT0NRZHNRempVWGxUdjJrdFZjMjFO?=
 =?utf-8?B?a2djMnZFNVJNaCtURzB6SSt5a1J4ZnJuOE5lWWVtUFlZNGJrcnZTNGdCMUxD?=
 =?utf-8?B?WVNjemtneEVMUkVNdkFvWHFsTlhjMlczOEtva25tcEdNS0lvUzRwNmZpTTlx?=
 =?utf-8?B?cVRwRlUzM3BPK0RRb1FYZVFLbUVDcFdzeTJVK0xMczdSMEJqRkZuOHFIN3hB?=
 =?utf-8?B?ZFpQRzlKamx4ZTg4NGh3dk9tY2ZnRlJxa1EyQlkzU0dWRVMwem1ySGNSaDA3?=
 =?utf-8?B?aUczeUltVHoyMWRiNTltN3NicEdYQXlFbGI5Smw5Umhhd0JYanI1c0ZvalE4?=
 =?utf-8?B?NkxyR1dXUVd6U2dodDBSNW9scGdLYUNUQ3lmZEdmSXdpZXkydUtaakVqWDA0?=
 =?utf-8?B?NjNBcHJ4YnNyblpXeFRVRVVyUklrbXlVQXNDNkQxOTk4c0gycXFLeGRVaEVi?=
 =?utf-8?B?MmlERmEzaDA2NWxPeEppVlRjTDZBcWE5VFU4am9jeE9zU3A3WE9rbGpWcU9x?=
 =?utf-8?B?NnNiUlZIbUJ5NjUzZ1NwSEs3RjBBWkRqZU4xTnc3NDlOZ2JpUDRxWlJUQ3NI?=
 =?utf-8?B?NVZTQ05NT3BiZnlqVUVFNTV3aU1BSjA3ZlJzZXlLbTcySFFpKzNWc0E2R0Zx?=
 =?utf-8?B?ZEpjakI1WHFNTkUwa1ZvcHVCYmNERDJVdTRyejBEUzI1RDF3NFQvR2tZNXdj?=
 =?utf-8?B?SmhsSDlDU0tDK0xqQndDdnZvMjN0WUVKNDh4amhTaXVDUFV1d3JhSHFrRTda?=
 =?utf-8?B?QVJBRE1rQlQ5VmVud0pha1VTWnVrVmpoTkxKb0NyckIwamh0R2RYU2NXek9Z?=
 =?utf-8?B?Zi80Mk5wdG03VTBuVUg3bHUwRklGNTVPaEpkMWx3VkRVZlNSUmJMTGQ2Z25I?=
 =?utf-8?B?bWVUTGo4eFBFOVRja1kvVU1VVi8vSFhTM1REeFYzYXBUeS9CdnBwWkNLUWJY?=
 =?utf-8?B?VGF6YWZwYU9xdVlzMGQ1QzJaT0N2R2pPWTJvdEV6ekU3S2FGdkhsV0QrZSt4?=
 =?utf-8?B?V01uM2lvTzB0Y01JYlUvZ3cwYWxMMEZjN1BmRDVIaGpsdm44NkREZXFyQnBw?=
 =?utf-8?B?OHZiU0t3YjFsdmhEdi9kcGhqb3Nvamc4SDQvK2lrc3ozMHNHVVdsQktmNXlL?=
 =?utf-8?B?WnpvbHlQSklxZzEzZUFlQ2loQloySk05ck4ySmZXN0pNQTdIR1JEYUwvUjZ4?=
 =?utf-8?B?bXNKbHVNQ2xNdVJrdklHY04vcENGd1hPeWd4cU5mbHpxL0JSRlk0SzVYcUQ4?=
 =?utf-8?B?TWVHZHhCN0dJeGZrUndjRTRKa0dYNkIyOERGR2U4d203TnBNOUlCb1ExaHFM?=
 =?utf-8?B?UG1iamdJeURGdWxqbG5YQ0g1TnA3YXZwRUg0QTRhZVJJQXhDbjlERmdSK2p2?=
 =?utf-8?B?Y3ZUbElaSjRRUVF4RTV5WkR1SWtRUHVybjNaVDRQQW54MTB2Z2pUS3FyMGFY?=
 =?utf-8?B?OTdkajBnR3B4MGNWalJMQWxCSzBRa2VYblp3ZVc4cVRvbjBYR2YwSzJaZk93?=
 =?utf-8?B?MXhPSFBDNTlOOHdKMGlOZWNJcXdZT1NjakQzcndzbHRtdm5CUHJDMjF5NEVK?=
 =?utf-8?B?UjJQcmxkVDNqQ1pvYUdHRUZZRVp0dGpyMm1TYzlvdTJQUEw4dGFpSTNGS3FN?=
 =?utf-8?B?aTFvOFdXaEpRTEpESVlWUkx6K1RqMStqUGQrcGpHTjVwVFRXMlEveFU4M1do?=
 =?utf-8?B?UnVuVjdkdUFxLy9tcWliZVpwVGpmQklPM3pSZXpCTU94RWlzYXAvdmNtYWR2?=
 =?utf-8?B?VGl1cDNjaFBmaHpDaHhCVkdSME4vTmw3c2loTEdzd0ZoNlI4QlVMVENQanh1?=
 =?utf-8?Q?3gH7+uNok2/vc4XHrjYbXu0no?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1504684a-3470-486e-f7f0-08dc7bce3bdf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:48:07.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwiK9Yoy3V0kl4QEVZHBq9g4j39NfAg+DkIpqeTbDIIgbuNRDxpdrmhTWvhGpCLhRkSVrT1HRPu3qLQirbrt/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9931

From: Peng Fan <peng.fan@nxp.com>

Add i.MX SCMI Extension protocols bindings for:
- Battery Backed Module(BBM) Protocol
  This contains persistent storage (GPR), an RTC, and the ON/OFF button.
  The protocol can also provide access to similar functions implemented via
  external board components.
- MISC Protocol.
  This includes controls that are misc settings/actions that must be exposed
  from the SM to agents. They are device specific and are usually define to
  access bit fields in various mix block control modules, IOMUX_GPR, and
  other GPR/CSR owned by the SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  5 ++-
 .../bindings/firmware/nxp,imx95-scmi.yaml          | 43 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 7de2c29606e5..cead03fbe22a 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -22,6 +22,9 @@ description: |
 
   [0] https://developer.arm.com/documentation/den0056/latest
 
+anyOf:
+  - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
+
 properties:
   $nodename:
     const: scmi
@@ -278,7 +281,7 @@ properties:
     required:
       - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 $defs:
   protocol-node:
diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
new file mode 100644
index 000000000000..1a95010a546b
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX95 System Control and Management Interface(SCMI) Vendor Protocols Extension
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  protocol@81:
+    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x81
+
+  protocol@84:
+    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x84
+
+      nxp,ctrl-ids:
+        description:
+          Each entry consists of 2 integers, represents the ctrl id and the value
+        items:
+          items:
+            - description: the ctrl id index
+              enum: [0, 1, 2, 3, 4, 5, 6, 7, 0x8000, 0x8001, 0x8002, 0x8003,
+                     0x8004, 0x8005, 0x8006, 0x8007]
+            - description: the value assigned to the ctrl id
+        minItems: 1
+        maxItems: 16
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+
+additionalProperties: true

-- 
2.37.1


