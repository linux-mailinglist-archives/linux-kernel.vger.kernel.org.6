Return-Path: <linux-kernel+bounces-175825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121B8C25BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F9C1F25C95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417F12CD99;
	Fri, 10 May 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CUxtgCYS"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6612C461;
	Fri, 10 May 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347811; cv=fail; b=WkbyvV1GfJfMMPtkR7slsvLxWf5WmgR/mRBiRazt69gIi6wS3TOmU9/fcbkxeP8GFvMZo+zi20i9X1NPduQZMCJp6lsqH4Vvc3Indn5c71YhAuPo5R5XjyJqvS8w8oYnX0PwWfvsW2p4ZMGbFllIE0AFjpJfDkGsnXKAG0XPVPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347811; c=relaxed/simple;
	bh=q/vJk9WIp0Y1YCLwr9690Qj5FxRUgQ2QUu0wvEUbLAI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eJr8xff97Qsndiu8mJZiKwVGgbRzSn1Gm4zAT0sjSITrukWkCrs1wgQHs4QcCQJWiX3GuQAbBbxjj87dK+YRXHHX+AUrKb3pEjttv7n8QYxo1ygX//XLoNEcTglwfRrRca9Qr2Uw7WPZpHutthED3+YE5lJOU/6Vw7m9hQ8F9c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CUxtgCYS; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuvDNjWMxSFPC5EXN7GK2aVqHtc2rC2RrzZ6JkEv/P+/HOUyCGqcpRzQggvm2NWlOb8kKt5DzKeNn4AnmFD2X2we8GhWSWN/GwVOugo1W/vXcvAuiy6z32CHRb3f94PGUrFPEhu/36lSu8OxIZxp1d/EafmPsebevsUe7T9gzI2peqoXHaEfCUrzGakYMdwvOlinaTze2yW31uTiGUglp2A52MXW3mQ+d6/vyD+PM4pUkyH+Jrx2FZJstGsHB+Q9m0W4F7ZStzEjknQsfL3kQiil/+DLazStbp6yh//v7WTGyDE83NdHS6LJM489D3ZBKq2hHsBkxJpxlEvJTKLyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whpSzr5QValKfJvwH6j2OVVLtMbWNG+lF6xqAjzhzIk=;
 b=QS1lZ56NJ4/kQfsyLvOwQ9eznfBTVbVotDgHohDTrEIwD8vnx1Pg6xchFWYwqmpYEFaRKkk4PMtlbaCaANa3enENgPO41G1ipty5CjoZ6yFslUYeMO8ni/tj1B5vt1utWZIg9XZKQGQL2S970fPvzA6XDDgVRY0ID53lw/L4Epz9yiIdxgdBiDsRwxtB2AoPRKjopmch1tsJr4ER3w4lqPx15QHpTCEVfeNGNSvCz0jUsuw5tYnQv380aoru3BfFeszRqN7qP9eWwlUw/ldrSYCMUju5lcNpseeKnjTLOYN5wt+/xxxSQkm5FFjO5Sc2PPBrzIAQ07lKrXyIbaISqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whpSzr5QValKfJvwH6j2OVVLtMbWNG+lF6xqAjzhzIk=;
 b=CUxtgCYSB8x1Ma5sehEKiYPh/AM9aHVTyDEyvMW+AAHhCTKYCASnjK06Q0jaMWcsDkyN0eNDB5RguH72UGbLM/MLPJF8i/+wznbeFFpVPqSq6KUb6+GyPM6XgwrMR9ai1XTbIsx/WwN7ME8CR0kYT2Msa+fP+EMU7gbOvPcqVcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:30:06 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:30:06 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 10 May 2024 18:57:28 +0530
Subject: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-imx-se-if-v1-2-27c5a674916d@nxp.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
In-Reply-To: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6308109b-22d1-4324-fe3f-08dc70f54e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3NKbUEyTWZsWUlnREd1NXplRm9iQUdFVnhuemRnSHk3SzExWlhERUtaTzhm?=
 =?utf-8?B?aGZ2Z0hmNVF6anRmdDE3STRnTjZOZlJ2RXoxTHQxWDJGN2hEVEJLa09tN2w4?=
 =?utf-8?B?d2phc2dUbU9oVGU4OTRqWXNiRFhJcjRMWVFnb1ppb3dRbUg3Y0ttbitOYUNk?=
 =?utf-8?B?aGFKWnMrWUFJZUV6UVJJQ1haVFFJT01iNHJ5YWVhNlNvVllYSGtRWjVIUkFR?=
 =?utf-8?B?eC9aTHBlQlhGQVJzTzhjQ1YzRzZjMWxzdnFqRnVHNE53dkt6bVF0ci9sVWZn?=
 =?utf-8?B?NURZTU1tU1NEbndZZUluTmd3MVIzaHViVmw0RGxRUjFONEF1dVVJaVRkSzdH?=
 =?utf-8?B?M0dlMU4zWGk2SWFIcUVpNXExM05CZVlJVXRkbTdZc1BSMC9uVElyMnN4SjZG?=
 =?utf-8?B?RTNFQUtWU0lka1RzczlmZHlXMFpRU3VZVEJ0M2lLR2t5K3Z0T21VTWpyV3Nj?=
 =?utf-8?B?T0Z3YkZxRnBjc2M5Ri9pRkNHS3B3SGVuNDAxRThnNHZjM3dtOFRDWmRJRHZY?=
 =?utf-8?B?NW9sUlFFR1JkdEYvaUlwMWUvajIxclZlY2M4Uk5VaU1Yamp4YmtybmdVa3Rs?=
 =?utf-8?B?TSs1ay9rSzdTdEVYZEIwS2pPMWlCWG1TemdVQloraEFMV3E1dHFQY1JBSGdY?=
 =?utf-8?B?Rk13WU9vN1B5d2tVaTBVZFcwTGFiN2E1MWtoUkk4MXFRYVpjc1k4Y1ZVNnVF?=
 =?utf-8?B?aHJaL3c3RHpSejNVY2ViR3JvQnhSUXlMaXI3enBSaWw5V21rZlluL3NIRmZu?=
 =?utf-8?B?KzdOTDBjWWdXa2JjdDBiME41N3F1MGRnV2NoNmw3MUh1OVdLZXBjNGtoNkNx?=
 =?utf-8?B?Mk9DSnBnRlRSN2kxMTl4bXhyMUlxaUVTNEwvMkp6TXdDRXM0Nm12M1JjcVpo?=
 =?utf-8?B?cnFPVTFURTBLN3EzKy9RY0pWa3p6RGJEWlhiTWlSRFJJL2toYWI4SXc0N3ds?=
 =?utf-8?B?K2xCc0tCZXUxNkJHNllyWVM3bUVwZ0pnZEE3bHEwQTdMN1dWYm9Wbm03QXo2?=
 =?utf-8?B?OEFmcEYrQTk0bnlOaG9OaHBNa2QrcFRvVUdBZDNONkl4bWx4cGVKNjlWT2Zi?=
 =?utf-8?B?aEpBQVRCa0VBSjF2bkprWXFUWWlpMi9KRHluVytPK3ZRR2kzRU5GaWlORDUr?=
 =?utf-8?B?S3k4Vm9jY3U2ajUvV2ZsZkdXQURkSkNRSjRScVp0dnk2S3RxeFBMR1JMRDlh?=
 =?utf-8?B?TXVwZHhnT2VybzBUWmxVcCtXWkZLNFRIQkpnRlFFOHZDZit0SnBReTVhZnN1?=
 =?utf-8?B?K3VlMCtHY2NCNEtzd09QWWk4WVdLTlpjQzZ1NHNtYmZKSldDalNaWUlCTXdh?=
 =?utf-8?B?VE95VUxvMVMvUzdSTE13MUdSVmEzbjhneG55K2NLUUQ4QkpzWHJ5WEUrbUx0?=
 =?utf-8?B?TSs3RXhGR0lvWGxiN0g1eVVwcGRkOWN0OW44ZEpUSnVJK3dnLzIwYWlKUWJq?=
 =?utf-8?B?L0F2RCt6SkZObWpGWU9CSk5BYnAvZ2FDQkUwbEt0MjlTOFdEWElIUnZlY3Jp?=
 =?utf-8?B?cytzUmE1TlFqVjhlWWt5T05yZnY4aWliNHFJcGNYd2E0YlYzdHBzeGF2L0Nq?=
 =?utf-8?B?R0x4TkVwZWRRUDQ5NlFYS01JaVdzQWFrTVNWQm1wQllVSGtYYXNrZWplYlZn?=
 =?utf-8?B?MGVJcjlHT2laNjlWOEdZWjR5M1FyZlJCbEROcmpYdXJqK3hLZE1PTUpmNGpZ?=
 =?utf-8?B?SWxOY3gvTys5dzNaeG9LRFozRnlDQUhhSEdJOVlSTGw3TnhENWtPejV3MktU?=
 =?utf-8?Q?Y6irnGUzMCPBZst9AQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGEvSGxDWitCOXkzNmExNjlFeEJaL2FLdWw2d2tXMFBWeTJMWUFmVlhQQVoy?=
 =?utf-8?B?eEtGNVl0L1FXQzBadEJpczJVMDliaHpaQUJXWWJmVXV6RGMzSERMSGJrNTJK?=
 =?utf-8?B?aUNRdEd1YmxSbUdhM3ExREZBS1M4dWNVUWlsRTFxUndQY3hBRHBlRkNTclVk?=
 =?utf-8?B?MG90Q3NPWFNVK0pwRENuYzlWVVQveTkreTYwUGppeXQ3TG9IK1h4MHExSW5k?=
 =?utf-8?B?dWlxMS9hTWEyS3FlQUhNV1pINzd6d0pabXJGcituUGtPRWE0c1hEN3NjYzll?=
 =?utf-8?B?WGRMRXdIUG8zNlkwZ3dDdDcyZjJzbVBqODd4UmtiVzNlYUFYZ0M0bXBNUklo?=
 =?utf-8?B?b2lrR3hpME9jR0M4ZEFjNWtkd3hHOHBqWVZoRGpJTTU3VWJXM0h2eE5ENHFv?=
 =?utf-8?B?MCtQUm1iZk9oODVOWVdxN3dUZGFnUGgrQ0JwRG5mcVoyY0xDcU55ZmlaMmlw?=
 =?utf-8?B?Q01qcUJRWjVWS1pwRm45bFh3VU5GanFUTmFpdWNDOWo5QmdyK2U1UXp3MDBo?=
 =?utf-8?B?TlFRNHpma0xlVnJvRk4vaElCN3NQOFhCZFNGS3JvYTRuQXQ1bjlyMHZRNmly?=
 =?utf-8?B?Q3kyRUxqdnk1akFld09aVTl6ZEg1ejFrWUlLZjQvNHJKN2gzdVZ3dFRFTGZy?=
 =?utf-8?B?REdrTnhaZWdLTlZrZ0JzV2dPU3l3SUkxWjJiSFRzaFBHWlhZa3YrUHdoWFA0?=
 =?utf-8?B?STNvdm1hQ3NDWlRHUGRUa3RhblM2OXViaS9lZm9hQVV5MzYrVFRuVXlPWGkz?=
 =?utf-8?B?YXh3bThnNmRhclRHaGJmOUp6cURQWGRmYWQ4Y3NkV0srN0NJd01BRlRrNDJI?=
 =?utf-8?B?d2NMZEVueVZJblZqeFgwUlJaUW9iRG95VlJmWXhNQzgyZHpQMVFoRkRMTUov?=
 =?utf-8?B?Zm5tOEdENExMWVgxWlFhZDJIa2tIWjd6U0dBN1dDRVBYaU9sQnJKM2QzdkRM?=
 =?utf-8?B?YndIeFBBQnRtQ2pWT3owVFU2dmRPV25FSkNJQTVqMnZjVHd3bHJKRWE4dW03?=
 =?utf-8?B?d1pCekRNYUY0a2d1U0VhaDNnQVBGSkx3RUN5bDg1MzJ2QU5VUStMY0wyWjJH?=
 =?utf-8?B?dnJBVXRJQ0VyaVM0UTdBcEZRTnNCY1EwRFJ1bnNTeUw0QXp4K0lPVmtnQmEr?=
 =?utf-8?B?Zk5ma0R1WUNGUys2bEhKOWxhUVZnaHpENTBvaWc3UkM4aXFKditSRFlRRUtm?=
 =?utf-8?B?M1ZnZG5BWnR3Z2krOUV1MWUwOXBSMWNpbHFTNTJSUjIzeXV5enVLY3JyMGZL?=
 =?utf-8?B?NnIxRnNUQ3krNW9qdkZWa1pMcW9YYkM4SFpLTWVKTGFqNWRzY3IxVUJBZzdV?=
 =?utf-8?B?eFRnSzUwQlBPKzU2QTBsWGpsTGd4SC9nMFNaTGtXNWQyc3pSanNPeFgvWXRz?=
 =?utf-8?B?dnFYWWM1Ukd3YStIVVBHcStJUmRYOERVNmg1YUV0dHBNaWJGZmlzc2FGOUxv?=
 =?utf-8?B?c3A1RkVYdzNLQUZobHl6N0NQUUdFZXN4bmxsa0pjcmJ2U2ZRVmptNEtNeWEr?=
 =?utf-8?B?WG9qMzRNVzdmNE9GSmlOSzRDcmVnWk1Nbmh4MkRBSjdLL0tjbVdONkhmUmZp?=
 =?utf-8?B?dkdZNWhOc0JDaTY5RHlLVFdnN1R3Nnl3ZVBtYmtlTTJIU3JTYnpVeE1iYkxZ?=
 =?utf-8?B?bGNEQjRRb3Exc3VPRDRlN0Z4OFJUR0d1UHZ5OUV5WDdDclRvMEZpL2wrb2Y4?=
 =?utf-8?B?THEranhYaW1jMHdsNFJTZ1JHUE1KUklTVXRsMEJabTErSjgxSlU0TEdTWUJT?=
 =?utf-8?B?U29xQkxMVlFxT1Jkc0JmU2lkSVZiN09RWU1KNzVsTlhkWi9hbTZJWEl3ZkxK?=
 =?utf-8?B?YUU4R1BOdXpBdFFWMUpST1VqQk1RVEhZQXR4SVBHcUtwK0hqdUVpRHZuQWZS?=
 =?utf-8?B?NTNtc25oYk81OUdLMjNkZ1JlUjBteGRVOXNTN2preHdVbk1XTXBBcnNQczZV?=
 =?utf-8?B?VURWRjNaL09SZHJ0cThGRUFkVUJIZHVxUkszWWQ4SFE4TFVrQlBjdmJyNDBm?=
 =?utf-8?B?d3hFRG9Ld2EvSXdEWldpRm5TWlV3ZkN5SVd4clNieC9vUytnUkxUSGxVa3lL?=
 =?utf-8?B?bXM5Q212L3VDVGcxdTRzWHNHa0NBRCt4MjJQdEJkdVBCWnVRK1pwL1RhbmtK?=
 =?utf-8?Q?VbSpu7wgrUrSFpwFIM5jZjowB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6308109b-22d1-4324-fe3f-08dc70f54e39
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:30:06.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzyJjZopCdLvfw6qKmxLxO3z0kgngRJWkkvcq/4Knbju8UB6j+b7/ULj3w6Hv7RhnSdeddtGdrxd43Nzrqkotw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 186 +++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..a858ef6965cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,186 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves is based on the
+  messaging unit(s).
+
+properties:
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  compatible:
+    enum:
+      - fsl,imx8ulp-ele
+      - fsl,imx93-ele
+
+patternProperties:
+  "^[0-9a-z]*-if@[0-9]+$":
+    type: object
+    description:
+      Communication interface to secure-enclave node, that defines hardware
+      properties to required to establish the communication. There can be
+      multiple interfaces to the same secure-enclave. Each interface is
+      enumerated with reg property. It optionally defines properties
+      depending on the compatible string and interface enum identifier.
+
+    properties:
+      reg:
+        maxItems: 1
+        description: Identifier of the communication interface to secure-enclave.
+
+      mboxes:
+        description: contain a list of phandles to mailboxes.
+        items:
+          - description: Specify the mailbox used to send message to se firmware
+          - description: Specify the mailbox used to receive message from se firmware
+
+      mbox-names:
+        items:
+          - const: tx
+          - const: rx
+          - const: txdb
+          - const: rxdb
+        minItems: 2
+
+      memory-region:
+        description: contains a list of phandles to reserved external memory.
+        items:
+          - description: It is used by secure-enclave firmware. It is an optional
+              property based on compatible and identifier to communication interface.
+              (see bindings/reserved-memory/reserved-memory.txt)
+
+      sram:
+        description: contains a list of phandles to sram.
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        items:
+          - description: Phandle to the device SRAM. It is an optional property
+              based on compatible and identifier to communication interface.
+
+    required:
+      - reg
+      - mboxes
+      - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-ele
+              - fsl,imx93-ele
+    then:
+      patternProperties:
+        "^[0-9a-z]*-if@[0-9]+$":
+          allOf:
+            - if:
+                properties:
+                  reg:
+                    items:
+                      - enum:
+                          - 0
+              then:
+                required:
+                  - memory-region
+              else:
+                not:
+                  required:
+                    - memory-region
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-ele
+    then:
+      patternProperties:
+        "^[0-9a-z]*-if@[0-9]+$":
+          allOf:
+            - if:
+                properties:
+                  reg:
+                    items:
+                      - enum:
+                          - 0
+              then:
+                required:
+                  - sram
+              else:
+                not:
+                  required:
+                    - sram
+
+additionalProperties: false
+
+examples:
+  - |
+    ele {
+      compatible = "fsl,imx8ulp-ele";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ele-if@0 {
+        reg = <0x0>;
+        mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+        mbox-names = "tx", "rx";
+        sram = <&sram0>;
+        memory-region = <&ele_reserved>;
+      };
+    };
+  - |
+    ele {
+      compatible = "fsl,imx93-ele";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ele-if@0 {
+        reg = <0x0>;
+        mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+        mbox-names = "tx", "rx";
+        memory-region = <&ele_reserved>;
+      };
+    };
+  - |
+    v2x {
+      compatible = "fsl,imx95-v2x";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      v2x-if@0 {
+        reg = <0x0>;
+        mboxes = <&v2x_mu 0 0>, <&v2x_mu 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      v2x-if@1 {
+        reg = <0x1>;
+        mboxes = <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
+        mbox-names = "txdb", "rxdb";
+      };
+      v2x-if@2 {
+        reg = <0x2>;
+        mboxes = <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
+        mbox-names = "tx", "rx";
+      };
+    };
+...

-- 
2.34.1


