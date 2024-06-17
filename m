Return-Path: <linux-kernel+bounces-216845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA73D90A74D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933E11C25BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CB6191464;
	Mon, 17 Jun 2024 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b39laBkW"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5319067E;
	Mon, 17 Jun 2024 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609602; cv=fail; b=C/kY7tdCAXd5qhPVzNXGcRSjGgth2ihi/XkbRt/x4mta48+ROCfT6TviXDLOE2mhjGaH+BMcEqcPW95FSbjEmuLtDT4eZ5eP6eLHLjZ917vRvmhXOrRzVUrxNIRbpU/tb8RctsYIcOKuG9WYX3DMzFlJyyZyiGnujzYji6LczE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609602; c=relaxed/simple;
	bh=UAeoxkERvyNFVNKQmxYA26IQNnb7NkmrPXxwYi9uRYc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Kf9X792zUCuQbpFAPEXjb4rOn6E2qYca/gYIs7AM8F5R8sQFjOMFXMdKlJw2VVk167y5oPjCvMccjF51ctH00pHwkFqlxVM69OtNnGPmOo7apII0evdNCG/2JNyMFHVGOt8P5ourI3F7sCZsJdseYbZDDogk4poZXX+FweP7HxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b39laBkW; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a70r34yanvPeneu803ClpiJyJUlLXsFJZknWY1HdQ0j5VBpUdhn91YBXWbm1jBcFV04n1C03LFAxMlS0ky5q2EfP7jccD2hqhdq3eJqvgIhu/N2W+GP4pvbDCkcZAT4PflgWO9QOaqR7ZYPjGte181+JX0i+Z5Z/fmJ031SRQ3NcR4rm7cdPyM87R5XWhhZghfhHU8tUFP3J7cuTVCT0tIhZJib/XD3Mr6suFZP6zDqQUuvLIS9EfKGJ6lCYwL4+bqlg6FAjrcyUzhSKt2eg+0+9fYMeFumdFM2mOiLccQxXsXXQsG1CkCNXtbyxRqslKr29+laGWM8+D6f6DrYglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUUyEIHpuwUPRyncZWhiPgOMb3q8PWdIGVB35ovqT8A=;
 b=EXFKUKOInYEI1FZHm7pyynsqa/C37IhIm7lbBxClwlMm0Y+DmAb8FrBnkM7DofoIHLvHre9K+e4BHu0q9K9GZqlvUIVwP/c/vM2Hy3lg6VQhgsjzw5qcaRm+kM8XhEeLH2eeBZVmUQbAkPel5jqyl90TIhc6PLLg41ARoUd44+AePkM7xeTSMG0QFnnig6K99w1R5LIiiKPeMmL1agMGlXLTWWaNNKNZQ37TcpY+eHeoJGPmecpMMJmpG3XYz1ztwhtU5O0vGRVEy2POomH/1Xy5B0IBa3XmbQzCWzKDobd1cv99Jd9FgjSFZl8rYzkf2uU0+ARmcvEuNBhfNPr7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUUyEIHpuwUPRyncZWhiPgOMb3q8PWdIGVB35ovqT8A=;
 b=b39laBkWOM47A7vejKKqpbLOWKv8YTRZZgYskaRlMWwDGAkX1r2C8bY3akpGvDxMA6Dh1ZL3FxI8uZU6ExhtBfIYg6bakWxFz+GSJ1Du6tAV+Dloqoz1YMYZZ14FJBw6SgnYBB2xISqC0C3l2xuYUvfERrMoiEn7kzeRhH/1Yn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9891.eurprd04.prod.outlook.com (2603:10a6:10:4c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 07:33:13 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:33:13 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 17 Jun 2024 12:59:43 +0530
Subject: [PATCH v3 5/5] firmware: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-imx-se-if-v3-5-a7d28dea5c4a@nxp.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
In-Reply-To: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718609402; l=32911;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=UAeoxkERvyNFVNKQmxYA26IQNnb7NkmrPXxwYi9uRYc=;
 b=7TUdg1lJSYsZdY4PxAjrG6tyI3BIKhcrAgabQXPPpQi7ZcT/b2Ifa23buTBfku5aim21rgWd7
 hNxN0uVFXFACVGXZxKlp1qcagydeoGcL9ciM6VTku785r2ioR9M336j
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9891:EE_
X-MS-Office365-Filtering-Correlation-Id: 9721e126-842d-476b-f663-08dc8e9fbf04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|7416011|376011|1800799021|366013|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTF3cXppNlFxUUkzaEMyNzB6eThZNm9BSStiVXJPc2srSzdTNlpoMWU4eUVy?=
 =?utf-8?B?c29RUE1udzRpanNTNWRid2NBeVMyNHMya2lkcjAxMThCQWxsMUg4VjJSSzFy?=
 =?utf-8?B?UlBkYncvZU5Kc29aN3ROU1ZSbEpjc1ZnL3ZSYzNleG84Mis2bDc0LzltZnRD?=
 =?utf-8?B?MHNZeTJRK1NFbzVoczJya2NMSjdrSXVsd2hsRnFWU3c3U0E5ZGEyU1dBMmRG?=
 =?utf-8?B?eXNPY3NhMTZUZVhFWUdEc1hHUTdsYklua25iVDNhdFU1dnNQSHlQWWZrRDJF?=
 =?utf-8?B?TnRBbWc5bHBNVURjVmIrckdvY2Z4Nk56bStudGtDSGhTZWUzVTZRcGRtaHJl?=
 =?utf-8?B?Z0ZBd0l3anNWalFmVVorS09ZWkxpNnZLOGFYUWxWMkhTTjdMck5YSXZxZXFS?=
 =?utf-8?B?TTJPelNyYTJ0M1pZOGMyU3lWaHV0ZzNyWHdHbHlENS9LMlVWcHduSGxOd05t?=
 =?utf-8?B?S1IzTUpVZTlSRXpkR0VhRFZiK21XWUdTeFdralV5MUxEVTJkb3FQczFLSlZq?=
 =?utf-8?B?UkI1N3hCK2xxY2U3d3dBOGR3ckUvekgwUVRzWk5EOE5xZ1FKalU2VFJZR0I2?=
 =?utf-8?B?YUpOWFdpeUw4UDVZYTlzM1E4cldBOFlsNFI5U3ZkNnVEbmxZaVRWTm0zZ1hL?=
 =?utf-8?B?blVzQlhSVUR0VUIrS1RlMHFKa1MzQ0R3ZGE3MmdBejBXSzJjbTVkY0p3Zytp?=
 =?utf-8?B?UEpZZUdXNVpvTS9iU2l2a05paG1lWmpUVnpMWGZwN2lYeXIvWUNySmgzSVpi?=
 =?utf-8?B?Y0toYkxNNzdub3dmazlBY25CSVVFWWNndkFXWm80NHE2a0NURlBvdTJVdU85?=
 =?utf-8?B?QzZXUUdXSWwxeVdkakQ1TWM3VVFXREl4YjF1SVRaS2d4eXpUKzZEeFhXQlhF?=
 =?utf-8?B?VmpMazNxOXllakI2YmlKSnFEenZWRzRoa2hHMklyM2pGbUhyT0ROclVHeDNW?=
 =?utf-8?B?UzJiUUV5eWFDYUFRUXZSTFNmTlBXRjZXWXoyc01WcjdFTkptdnZhRkMwb0Zs?=
 =?utf-8?B?SWo3dEFqQ0JlT2gxc0V6TGlyTnVWZHljWjFHSXJKKzR4T1ZkS2dnNmpKK3lE?=
 =?utf-8?B?QTRNY3RDTWhoTFNBSHMvS3l5VU1iNFZjOXF3c0RPZi9wVncwOFFnbnM5ZmFt?=
 =?utf-8?B?elhWUEt3Slp4YXRlU3IyS1FKNHpvYnhmNkNwOWI5ajJHWGVDMWYyc3lnM2pS?=
 =?utf-8?B?V1ZuWktCNUx0Nncxd2NqT2svRlNOaFBQa3FVejZRVWhJcFVaeEFaV3l2VFJR?=
 =?utf-8?B?UEdwbXJGU1V6SGxJRFFrbFppWGoyOHJtcDM1Y3JjREpOc2FHN3BRWFpDMmhB?=
 =?utf-8?B?Yys3cEROY0l2TWN3eFIwVW9IemRjT0pOMXcwK2NDTFhNRUV6OWRUWERmYjNP?=
 =?utf-8?B?UWRzWmsvVS9lc2l5cDZBYm5HZkUyeEZPVGtldUVGYTBiT1VHSENYSzd3Y3hF?=
 =?utf-8?B?MTRxaU1WcVZDRWJER1Axc0tQbVJCWEsxTHAwOTR3dFRzL1dpWXpTZG5yOG5J?=
 =?utf-8?B?TS9mdnR1ZEVkWmtQVUhzaktMYVp3OFNqRTgycmZJczA3elZWYnRaNHZ3ZWp3?=
 =?utf-8?B?RWZKZnRsSjI0c1VEUW9ZeU8wT1lOdDlmdDBCcnpCZ01pbEh6Q1Q3VHIyMEh0?=
 =?utf-8?B?TDA4blhTem9LN1BzUnlXUER5NlRhSHNieE9Gc2ZwV1pGL0owWVhSeFEvVmRP?=
 =?utf-8?B?dUlhejNuNGQwRVJ2eWowalpYR2tjQUN6cDJ2c25GUDNodWk3WkE5UExIUzZz?=
 =?utf-8?B?VXA0R1poQjNLUktMZm12MzcycEE0TnlRczRFbTQrRUFDQTRGRkRqZVhRSVA2?=
 =?utf-8?B?MjFudlhsYWNiQ1p3alp0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(7416011)(376011)(1800799021)(366013)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUF5ekJ5UDNqeEFvWHNURzVNVUhjRG05aGZ3OTkrRExvUWY4UVo3aTQweXh1?=
 =?utf-8?B?OVBZd0NSOGZKVVNvTWNrMDZIUCtNQWxCYXJGdjJVaUxzbTFoWDAzUnA5a0Uw?=
 =?utf-8?B?dytya1V5aUN4WUljSWgxSHFWcU1PWFJwTUtWSnhqOSs3NFJ1UjljcFdsbXNU?=
 =?utf-8?B?YWsvUmJTdWZkUFlVWEFXMkhlRE1ETE5Tdm42a2dOcWFMWFdzNXZMWnEyNVlx?=
 =?utf-8?B?ODBnSUM5a2oxaktxZ3o3TitNT1BUbjNqY09rYlVVeHE2TWVqeldFb2UrcXdH?=
 =?utf-8?B?TGVuR3RNMHhudXBob0RpMkZpYkJTUDNZekV3ZE1haUFSWFozNkpuRllyTy9O?=
 =?utf-8?B?SGF4TkVFYUFFNDFqeFZiWEhSWDUzOW12emJEMndSRVRxaVNtWFpBSU1sdWM1?=
 =?utf-8?B?ZmszdUE1Sk9QdkY2WlQveGxVdEpjREs3TGYzVnpoT0FZbW9icFZBLzhmMnVx?=
 =?utf-8?B?TzZNazZIdDhOTytOT2g1NHk5Zk1oaWRBYmYzUmVsU0JxRWR5VUNoZThvMHB5?=
 =?utf-8?B?Slp3UFNQLzEzcGdTVE81VnZSRVQ2Y3VPQW85cW5VOUpiWlRjTGlyd0QrQnRa?=
 =?utf-8?B?MzJKK2d3UXY5cmppL2FxS2J2RzVaMGZvZ1hsNGpQdVpjSDhBYk9XRk0zTUFY?=
 =?utf-8?B?dE4wYmxnYXpkakNPU3VXOUowRWZRWkh5dFliNzd3VFVYR2ZwQ0UxZEFVazA2?=
 =?utf-8?B?TUZnTWJDNHBEc2JEakdYcWkxd25yS3VGMjR4MEdWSk9DMTM4K0lUc2wya2pK?=
 =?utf-8?B?ZlFDV0dEbnFSWGo4WG9LY0dxV3dTbnpkZExWTy9jczRLR2JtUnBFZXJUT0VB?=
 =?utf-8?B?R1Ixd1RyU05aWTZzY3ZwUmh3YjNSK1dueE8wVDNTNGxITys2K1laKzFIdEo5?=
 =?utf-8?B?bnlZWWppb3hjU29tMjBpVEZWRFF1bjM1Q2FKTjlJZ0R6Y2E1elJ6ZENBWk9M?=
 =?utf-8?B?RTdOVmVSWkRyTnBIOG1zekM1L3M5a28zRHdObEg1eUYzVmJvZkZRcUp5S0dN?=
 =?utf-8?B?Y3IyM1NHcTJ4VEkyaWpRcHZaRWN2UkJvYU1yMm9Cc2dGM2lySng2ZG5NWmY1?=
 =?utf-8?B?ZFBOSVo0K0xYamNzT04xNXBEaE1YMW1wZ3BhSmNDNzVQS3VtRDFxcE9sN1pU?=
 =?utf-8?B?MGxmZVNhSGlCQUFqZnFWY0o5NG5UbzdDeVg2S3N6T2djVkVGWDlGRmxSNGlF?=
 =?utf-8?B?Y2NtNnEyS045QkdmV1NneXdlUzMwQ1BXRG5sWkJNWlNKYTlhc2RCZUM3cWRD?=
 =?utf-8?B?MndVL05ibW55WjEvblNwSklOZkdSVi9NSlVMMFRDajNwWlZmK3Y2UkQ3dVNP?=
 =?utf-8?B?STlOaXlaclZBNVRxT1NWTzJHYWpWSjM5djgxVGxjZFE2d2gzQnpuNGNCWE5T?=
 =?utf-8?B?QnZZUXU3S3lRVkxtQ1l0MDBPLzJERTJMVS9tSWFDNEJoOWtoRUpNU0JYdW9Z?=
 =?utf-8?B?Nit4dXdkWlYrRW5CVjhpeXphVDZoNk5aSmFOVk1wRkhIRGZTZGVFL2hadXls?=
 =?utf-8?B?dzYzY1B3YmUrMG54bHhZK1RQTzJzT0k5dXd5WHhPYlpDQTdTN2RNekMrckxz?=
 =?utf-8?B?T0tnek0xSkdnTDFpMlI1OGRkUzRQay80Q05BSlRIczRvczNaRVM4NkxyWkRw?=
 =?utf-8?B?cit0L1N0OUs5eWJBQVZ6bWthYmJlRUg1bG9SL05uSnZEL2Q0NUVnbkdMV2Ro?=
 =?utf-8?B?dXREcHpxQXI1VHdjbi9lNWVvZWV2QUJMRnFQc0FYUElUVE15ajBDSEVLbDNp?=
 =?utf-8?B?dFlYWDNtOExlTEhtWTZxMEhDRlhpSjdFa2VmV1JVTHN6TS9QN1gwSWRhS1RY?=
 =?utf-8?B?a1hyK3ZSMEh3aUpxM2RWbGRRNE0wNitBRVpYaDQwSy85V04xcXhodSs0OWkr?=
 =?utf-8?B?WGVnaU9VNDU2V2s0d1FlMGRpUzIrMjVVUHNUcmxjTStuNnovVjZVRk0vNEly?=
 =?utf-8?B?NFpiRmt4Uk1xeHNFWHo0NHR1SkJYNjFvVjhFNDdlbU1JV3BTWERoWHFCYmky?=
 =?utf-8?B?RTF0dlZ1YVpMZmhZTTl2NFpHOHlRV21QMk1pd0RHRmNBRGdxS1graXhqak80?=
 =?utf-8?B?a2RPWUF3azNWZyt0M0FjQjFHcUtmUHluU0NObSs1bjZXSzFMaWYwcFRaRGl1?=
 =?utf-8?Q?NAB3jP4jsn+A5UXfzVG0E3nKz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9721e126-842d-476b-f663-08dc8e9fbf04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:33:13.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+CpWwzikZFo6HETTnhpLbzDfiJRiMUr5Tce44+Drvy1xGydT9BciQevycnewrUHo5zJ7HRGu1+5+udekvgI9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9891

Adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like
EdgeLock Enclave from:
- User-Space Applications via character driver.

ABI documentation for the NXP secure-enclave driver.

User-space library using this driver:
- i.MX Secure Enclave library:
  -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
- i.MX Secure Middle-Ware:
  -- URL: https://github.com/nxp-imx/imx-smw.git

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 Documentation/ABI/testing/se-cdev |  42 +++
 drivers/firmware/imx/ele_common.c | 153 ++++++++-
 drivers/firmware/imx/ele_common.h |   4 +
 drivers/firmware/imx/se_ctrl.c    | 694 ++++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h    |  49 +++
 include/uapi/linux/se_ioctl.h     |  94 ++++++
 6 files changed, 1034 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..699525af6b86
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,42 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		May 2024
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for  secure-enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file-descriptors
+		/dev/<se>_mu*_ch* are the interface between user-space NXP's secure-
+		enclave shared-library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>
+		 ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- get mu info
+			- setting a dev-ctx as receiver that is slave to fw
+			- get SoC info
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wakeup_intruptible, that gets set by the registered mailbox callback
+		  function; indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock, before sending message on to the message unit.
+
+		close(2)
+		  Stops and free up the I/O contexts that was associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index 0139748f7150..3d608a851962 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -78,12 +78,146 @@ int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg)
 	return err;
 }
 
+int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
+			    void *rx_buf,
+			    int rx_buf_sz)
+{
+	struct se_msg_hdr *header;
+	u32 size_to_copy;
+	int err;
+
+	err = wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hdr != 0);
+	if (err)
+		dev_err(dev_ctx->dev,
+			"%s: Err[0x%x]:Interrupted by signal.\n",
+			dev_ctx->miscdev.name, err);
+
+	header = (struct se_msg_hdr *) dev_ctx->temp_resp;
+
+	if (header->tag == dev_ctx->priv->rsp_tag) {
+		if (dev_ctx->priv->waiting_rsp_dev != dev_ctx) {
+			dev_warn(dev_ctx->dev,
+			"%s: Device context waiting for response mismatch.\n",
+			dev_ctx->miscdev.name);
+			err = -EPERM;
+		}
+	}
+
+	dev_dbg(dev_ctx->dev,
+		"%s: %s %s\n",
+		dev_ctx->miscdev.name,
+		__func__,
+		"message received, start transmit to user");
+
+	/*
+	 * Check that the size passed as argument is larger than
+	 * the one carried in the message.
+	 */
+	size_to_copy = dev_ctx->temp_resp_size << 2;
+	if (size_to_copy > rx_buf_sz) {
+		dev_dbg(dev_ctx->dev,
+			"%s: User buffer too small (%d < %d)\n",
+			dev_ctx->miscdev.name,
+			rx_buf_sz, size_to_copy);
+		size_to_copy = rx_buf_sz;
+	}
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     dev_ctx->temp_resp, size_to_copy, false);
+	if (copy_to_user(rx_buf, dev_ctx->temp_resp, size_to_copy)) {
+		dev_err(dev_ctx->dev,
+			"%s: Failed to copy to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	err = size_to_copy;
+exit:
+
+	/* free memory allocated on the shared buffers. */
+	dev_ctx->secure_mem.pos = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+
+	dev_ctx->pending_hdr = 0;
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	return err;
+}
+
+int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
+			     void *tx_msg, int tx_msg_sz)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_msg_hdr *header;
+	u32 size_to_send;
+	int err;
+
+	header = (struct se_msg_hdr *) tx_msg;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	size_to_send = header->size << 2;
+
+	if (size_to_send != tx_msg_sz) {
+		err = -EINVAL;
+		dev_err(priv->dev,
+			"%s: User buffer header size mismatced with input size.\n",
+			dev_ctx->miscdev.name);
+		goto exit;
+	}
+	/* Check the message is valid according to tags */
+	if (header->tag == priv->rsp_tag) {
+		/* Check the device context can send the command */
+		if (dev_ctx != priv->cmd_receiver_dev) {
+			dev_err(priv->dev,
+				"%s: Channel not configured to send resp to FW.",
+				dev_ctx->miscdev.name);
+			err = -EPERM;
+			goto exit;
+		}
+	} else if (header->tag == priv->cmd_tag) {
+		if (priv->waiting_rsp_dev != dev_ctx) {
+			dev_err(priv->dev,
+				"%s: Channel not configured to send cmd to FW.",
+				dev_ctx->miscdev.name);
+			err = -EPERM;
+			goto exit;
+		}
+		lockdep_assert_held(&priv->se_if_cmd_lock);
+	} else {
+		dev_err(priv->dev,
+			"%s: The message does not have a valid TAG\n",
+			dev_ctx->miscdev.name);
+		err = -EINVAL;
+		goto exit;
+	}
+	err = imx_ele_msg_send(priv, tx_msg);
+	if (err < 0)
+		goto exit;
+
+	err = size_to_send;
+exit:
+	return err;
+}
+
 /*
  * Callback called by mailbox FW, when data is received.
  */
 void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 {
 	struct device *dev = mbox_cl->dev;
+	struct se_if_device_ctx *dev_ctx;
 	struct se_if_priv *priv;
 	struct se_msg_hdr *header;
 
@@ -97,8 +231,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 
 	header = (struct se_msg_hdr *) msg;
 
-	if (header->tag == priv->rsp_tag) {
-		if (!priv->waiting_rsp_dev) {
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->cmd_tag) {
+		dev_dbg(dev, "Selecting cmd receiver\n");
+		dev_ctx = priv->cmd_receiver_dev;
+	} else if (header->tag == priv->rsp_tag) {
+		if (priv->waiting_rsp_dev) {
+			dev_dbg(dev, "Selecting rsp waiter\n");
+			dev_ctx = priv->waiting_rsp_dev;
+		} else {
 			/*
 			 * Reading the EdgeLock Enclave response
 			 * to the command, sent by other
@@ -116,6 +257,14 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
 				*((u32 *) header));
 		return;
 	}
+	/* Init reception */
+	memcpy(dev_ctx->temp_resp, msg, header->size << 2);
+
+	dev_ctx->temp_resp_size = header->size;
+
+	/* Allow user to read */
+	dev_ctx->pending_hdr = 1;
+	wake_up_interruptible(&dev_ctx->wq);
 }
 
 int validate_rsp_hdr(struct se_if_priv *priv,
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 24569ad29a1f..ea443a9f7ad0 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -14,6 +14,10 @@
 #define IMX_ELE_FW_DIR                 "imx/ele/"
 
 uint32_t imx_se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
+int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx,
+			    void *rx_msg, int rx_msg_sz);
+int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
+			     void *tx_msg, int tx_msg_sz);
 int imx_ele_msg_rcv(struct se_if_priv *priv);
 int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg);
 int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void *rx_msg);
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index a7a7cacb4416..c018a4f728d0 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -236,6 +237,605 @@ static int imx_fetch_se_soc_info(struct se_if_priv *priv,
 	return 0;
 }
 
+static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
+	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int err = 0;
+
+	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 *)arg,
+			   sizeof(struct se_ioctl_cmd_snd_rcv_rsp_info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: User buffer too small(%d < %d)\n",
+			dev_ctx->miscdev.name,
+			cmd_snd_rcv_rsp_info.tx_buf_sz,
+			SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
+	if (!rx_msg) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
+			     cmd_snd_rcv_rsp_info.tx_buf_sz);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	if (tx_msg->header.tag != priv->cmd_tag) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	scoped_guard(mutex, &priv->se_if_cmd_lock);
+	priv->waiting_rsp_dev = dev_ctx;
+
+	/* Device Context that is assigned to be a
+	 * FW's command receiver, has pre-allocated buffer.
+	 */
+	if (dev_ctx != priv->cmd_receiver_dev)
+		dev_ctx->temp_resp = rx_msg;
+
+	err = imx_ele_miscdev_msg_send(dev_ctx,
+				       tx_msg,
+				       cmd_snd_rcv_rsp_info.tx_buf_sz);
+	cmd_snd_rcv_rsp_info.tx_buf_sz = err;
+	if (err < 0)
+		goto exit;
+
+	err = imx_ele_miscdev_msg_rcv(dev_ctx,
+				      cmd_snd_rcv_rsp_info.rx_buf,
+				      cmd_snd_rcv_rsp_info.rx_buf_sz);
+
+	cmd_snd_rcv_rsp_info.rx_buf_sz = err;
+	priv->waiting_rsp_dev = NULL;
+	if (dev_ctx != priv->cmd_receiver_dev)
+		dev_ctx->temp_resp = NULL;
+
+exit:
+	if (copy_to_user((void *)arg, &cmd_snd_rcv_rsp_info,
+			 sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+	}
+	return err;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_if_device_ctx *dev_ctx;
+	struct se_if_priv *priv;
+	int err;
+
+	dev_ctx = container_of(fp->private_data,
+			       struct se_if_device_ctx,
+			       miscdev);
+	priv = dev_ctx->priv;
+	dev_dbg(priv->dev,
+		"%s: write from buf (%p)%zu, ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != SE_IF_CTX_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (size < SE_MU_HDR_SZ) {
+		dev_err(priv->dev,
+			"%s: User buffer too small(%zu < %d)\n",
+				dev_ctx->miscdev.name,
+				size, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+	tx_msg = memdup_user(buf, size);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+			     tx_msg, size, false);
+
+	err = imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
+			       size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx;
+	struct se_if_priv *priv;
+	int err;
+
+	dev_ctx = container_of(fp->private_data,
+			       struct se_if_device_ctx,
+			       miscdev);
+	priv = dev_ctx->priv;
+	dev_dbg(priv->dev,
+		"%s: read to buf %p(%zu), ppos=%lld\n",
+			dev_ctx->miscdev.name,
+			buf, size, ((ppos) ? *ppos : 0));
+
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	if (dev_ctx->status != SE_IF_CTX_OPENED) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	err = imx_ele_miscdev_msg_rcv(dev_ctx, buf, size);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev_ctx->dev);
+	struct imx_se_node_info *if_node_info;
+	struct se_ioctl_get_if_info info;
+	int err = 0;
+
+	if_node_info = (struct imx_se_node_info *)priv->info;
+
+	info.se_if_id = if_node_info->se_if_id;
+	info.interrupt_idx = 0;
+	info.tz = 0;
+	info.did = if_node_info->se_if_did;
+	info.cmd_tag = if_node_info->cmd_tag;
+	info.rsp_tag = if_node_info->rsp_tag;
+	info.success_tag = if_node_info->success_tag;
+	info.base_api_ver = if_node_info->base_api_ver;
+	info.fw_api_ver = if_node_info->fw_api_ver;
+
+	dev_dbg(priv->dev,
+		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
+			dev_ctx->miscdev.name,
+			info.se_if_id, info.interrupt_idx, info.tz, info.did);
+
+	if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy mu info to user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/* Need to copy the output data to user-device context.
+ */
+int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_buf_desc *b_desc, *temp;
+
+	list_for_each_entry_safe(b_desc, temp, &dev_ctx->pending_out, link) {
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
+
+			dev_dbg(dev_ctx->dev,
+				"%s: Copy output data to user\n",
+				dev_ctx->miscdev.name);
+			if (copy_to_user(b_desc->usr_buf_ptr,
+					 b_desc->shared_buf_ptr,
+					 b_desc->size)) {
+				dev_err(dev_ctx->dev,
+					"%s: Failure copying output data to user.",
+					dev_ctx->miscdev.name);
+				return -EFAULT;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		list_del(&b_desc->link);
+		kfree(b_desc);
+	}
+	return 0;
+}
+
+/*
+ * Clean the used Shared Memory space,
+ * whether its Input Data copied from user buffers, or
+ * Data received from FW.
+ */
+void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
+{
+	struct list_head *dev_ctx_lists[] = {&dev_ctx->pending_in,
+						 &dev_ctx->pending_out};
+	struct se_buf_desc *b_desc, *temp;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		list_for_each_entry_safe(b_desc, temp,
+					 dev_ctx_lists[i], link) {
+
+			if (!b_desc)
+				continue;
+
+			if (b_desc->shared_buf_ptr)
+				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+			list_del(&b_desc->link);
+			kfree(b_desc);
+		}
+	}
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_shared_mem *shared_mem = NULL;
+	struct se_ioctl_setup_iobuf io = {0};
+	struct se_buf_desc *b_desc = NULL;
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed copy iobuf config from user\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	dev_dbg(dev_ctx->priv->dev,
+			"%s: io [buf: %p(%d) flag: %x]\n",
+			dev_ctx->miscdev.name,
+			io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* Select the shared memory to be used for this buffer. */
+	if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
+		/* App requires to use secure memory for this buffer.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	} else {
+		/* No specific requirement for this buffer. */
+		shared_mem = &dev_ctx->non_secure_mem;
+	}
+
+	/* Check there is enough space in the shared memory. */
+	if (shared_mem->size < shared_mem->pos ||
+		round_up(io.length, 8u) >= (shared_mem->size - shared_mem->pos)) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Not enough space in shared memory\n",
+				dev_ctx->miscdev.name);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
+	    !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
+		/*Add base address to get full address.*/
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed allocate SEC MEM memory\n",
+				dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
+	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
+				   io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory\n",
+				dev_ctx->miscdev.name);
+			err = -EFAULT;
+			goto exit;
+		}
+	}
+
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy iobuff setup to user\n",
+				dev_ctx->miscdev.name);
+		kfree(b_desc);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (b_desc) {
+		b_desc->shared_buf_ptr = shared_mem->ptr + pos;
+		b_desc->usr_buf_ptr = io.user_buf;
+		b_desc->size = io.length;
+
+		if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+			/*
+			 * buffer is input:
+			 * add an entry in the "pending input buffers" list so
+			 * that copied data can be cleaned from shared memory
+			 * later.
+			 */
+			list_add_tail(&b_desc->link, &dev_ctx->pending_in);
+		} else {
+			/*
+			 * buffer is output:
+			 * add an entry in the "pending out buffers" list so data
+			 * can be copied to user space when receiving Secure-Enclave
+			 * response.
+			 */
+			list_add_tail(&b_desc->link, &dev_ctx->pending_out);
+		}
+	}
+
+exit:
+	return err;
+}
+
+/* IOCTL to provide SoC information */
+static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
+					     u64 arg)
+{
+	struct imx_se_node_info_list *info_list;
+	struct se_ioctl_get_soc_info soc_info;
+	int err = -EINVAL;
+
+	info_list = (struct imx_se_node_info_list *)
+			device_get_match_data(dev_ctx->priv->dev);
+	if (!info_list)
+		goto exit;
+
+	soc_info.soc_id = info_list->soc_id;
+	soc_info.soc_rev = dev_ctx->priv->soc_rev;
+
+	err = (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(soc_info));
+	if (err) {
+		dev_err(dev_ctx->priv->dev,
+			"%s: Failed to copy soc info to user\n",
+			dev_ctx->miscdev.name);
+		err = -EFAULT;
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+/* Open a character device. */
+static int se_if_fops_open(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	int err = 0;
+
+	/* Avoid race if opened at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* Authorize only 1 instance. */
+	if (dev_ctx->status != SE_IF_CTX_FREE) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	dev_ctx->non_secure_mem.ptr = dmam_alloc_coherent(dev_ctx->dev,
+					MAX_DATA_SIZE_PER_USER,
+					&dev_ctx->non_secure_mem.dma_addr,
+					GFP_KERNEL);
+	if (!dev_ctx->non_secure_mem.ptr) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	dev_ctx->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	dev_ctx->non_secure_mem.pos = 0;
+	dev_ctx->status = SE_IF_CTX_OPENED;
+
+	dev_ctx->pending_hdr = 0;
+
+	goto exit;
+
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return err;
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	/* Avoid race if closed at the same time */
+	if (down_trylock(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	/* The device context has not been opened */
+	if (dev_ctx->status != SE_IF_CTX_OPENED)
+		goto exit;
+
+	/* check if this device was registered as command receiver. */
+	if (priv->cmd_receiver_dev == dev_ctx) {
+		priv->cmd_receiver_dev = NULL;
+		kfree(dev_ctx->temp_resp);
+	}
+
+	/* check if this device was registered as waiting response. */
+	if (priv->waiting_rsp_dev == dev_ctx) {
+		priv->waiting_rsp_dev = NULL;
+		mutex_unlock(&priv->se_if_cmd_lock);
+	}
+
+	/* Unmap secure memory shared buffer. */
+	if (dev_ctx->secure_mem.ptr)
+		devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
+
+	dev_ctx->secure_mem.ptr = NULL;
+	dev_ctx->secure_mem.dma_addr = 0;
+	dev_ctx->secure_mem.size = 0;
+	dev_ctx->secure_mem.pos = 0;
+
+	/* Free non-secure shared buffer. */
+	dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
+			   dev_ctx->non_secure_mem.ptr,
+			   dev_ctx->non_secure_mem.dma_addr);
+
+	dev_ctx->non_secure_mem.ptr = NULL;
+	dev_ctx->non_secure_mem.dma_addr = 0;
+	dev_ctx->non_secure_mem.size = 0;
+	dev_ctx->non_secure_mem.pos = 0;
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+	dev_ctx->status = SE_IF_CTX_FREE;
+
+exit:
+	up(&dev_ctx->fops_lock);
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = container_of(fp->private_data,
+							struct se_if_device_ctx,
+							miscdev);
+	struct se_if_priv *se_if_priv = dev_ctx->priv;
+	int err = -EINVAL;
+
+	/* Prevent race during change of device context */
+	if (down_interruptible(&dev_ctx->fops_lock))
+		return -EBUSY;
+
+	switch (cmd) {
+	case SE_IOCTL_ENABLE_CMD_RCV:
+		if (!se_if_priv->cmd_receiver_dev) {
+			err = 0;
+			se_if_priv->cmd_receiver_dev = dev_ctx;
+			dev_ctx->temp_resp = kzalloc(MAX_NVM_MSG_LEN, GFP_KERNEL);
+			if (!dev_ctx->temp_resp)
+				err = -ENOMEM;
+		}
+		break;
+	case SE_IOCTL_GET_MU_INFO:
+		err = se_ioctl_get_mu_info(dev_ctx, arg);
+		break;
+	case SE_IOCTL_SETUP_IOBUF:
+		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_GET_SOC_INFO:
+		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
+		break;
+	case SE_IOCTL_CMD_SEND_RCV_RSP:
+		err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
+		break;
+
+	default:
+		err = -EINVAL;
+		dev_dbg(se_if_priv->dev,
+			"%s: IOCTL %.8x not supported\n",
+				dev_ctx->miscdev.name,
+				cmd);
+	}
+
+	up(&dev_ctx->fops_lock);
+	return (long)err;
+}
+
+/* Char driver setup */
+static const struct file_operations se_if_fops = {
+	.open		= se_if_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= se_if_fops_close,
+	.unlocked_ioctl = se_ioctl,
+	.read		= se_if_fops_read,
+	.write		= se_if_fops_write,
+};
+
+/* interface for managed res to unregister a character device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -274,6 +874,7 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct se_if_priv *priv;
 	int ret = 0;
+	int i;
 
 	priv = dev_get_drvdata(dev);
 
@@ -293,6 +894,17 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
 		priv->imem.buf = NULL;
 	}
 
+	if (priv->ctxs) {
+		for (i = 0; i < priv->max_dev_ctx; i++) {
+			if (priv->ctxs[i]) {
+				devm_remove_action(dev,
+						   if_misc_deregister,
+						   &priv->ctxs[i]->miscdev);
+				misc_deregister(&priv->ctxs[i]->miscdev);
+			}
+		}
+	}
+
 	/* No need to check, if reserved memory is allocated
 	 * before calling for its release. Or clearing the
 	 * un-set bit.
@@ -303,6 +915,74 @@ static int se_probe_if_cleanup(struct platform_device *pdev)
 	return ret;
 }
 
+static int init_device_context(struct se_if_priv *priv)
+{
+	const struct imx_se_node_info *info = priv->info;
+	struct se_if_device_ctx *dev_ctx;
+	u8 *devname;
+	int ret = 0;
+	int i;
+
+	priv->ctxs = devm_kzalloc(priv->dev, sizeof(dev_ctx) * priv->max_dev_ctx,
+				  GFP_KERNEL);
+
+	if (!priv->ctxs) {
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	/* Create users */
+	for (i = 0; i < priv->max_dev_ctx; i++) {
+		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);
+		if (!dev_ctx) {
+			ret = -ENOMEM;
+			return ret;
+		}
+
+		dev_ctx->dev = priv->dev;
+		dev_ctx->status = SE_IF_CTX_FREE;
+		dev_ctx->priv = priv;
+
+		priv->ctxs[i] = dev_ctx;
+
+		/* Default value invalid for an header. */
+		init_waitqueue_head(&dev_ctx->wq);
+
+		INIT_LIST_HEAD(&dev_ctx->pending_out);
+		INIT_LIST_HEAD(&dev_ctx->pending_in);
+		sema_init(&dev_ctx->fops_lock, 1);
+
+		devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s_ch%d",
+					 info->se_name, i);
+		if (!devname) {
+			ret = -ENOMEM;
+			return ret;
+		}
+
+		dev_ctx->miscdev.name = devname;
+		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
+		dev_ctx->miscdev.fops = &se_if_fops;
+		dev_ctx->miscdev.parent = priv->dev;
+		ret = misc_register(&dev_ctx->miscdev);
+		if (ret) {
+			dev_err(priv->dev, "failed to register misc device %d\n",
+				ret);
+			return ret;
+		}
+
+		ret = devm_add_action(priv->dev, if_misc_deregister,
+				      &dev_ctx->miscdev);
+		if (ret) {
+			dev_err(priv->dev,
+				"failed[%d] to add action to the misc-dev\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
 static void se_load_firmware(const struct firmware *fw, void *context)
 {
 	struct se_if_priv *priv = (struct se_if_priv *) context;
@@ -463,6 +1143,16 @@ static int se_if_probe(struct platform_device *pdev)
 		ret = 0;
 	}
 
+	if (info->max_dev_ctx) {
+		ret = init_device_context(priv);
+		if (ret) {
+			dev_err(dev,
+				"Failed[0x%x] to create device contexts.\n",
+				ret);
+			goto exit;
+		}
+	}
+
 	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
 		 info->se_name);
 	return ret;
@@ -507,6 +1197,10 @@ static int se_resume(struct device *dev)
 {
 	struct se_if_priv *priv = dev_get_drvdata(dev);
 	const struct imx_se_node_info *info = priv->info;
+	int i;
+
+	for (i = 0; i < priv->max_dev_ctx; i++)
+		wake_up_interruptible(&priv->ctxs[i]->wq);
 
 	if (info && info->imem_mgmt)
 		se_restore_imem_state(priv);
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index 7d4f439a6158..7d7469348f1d 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -13,15 +13,62 @@
 #define MAX_FW_LOAD_RETRIES		50
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
+#define MAX_NVM_MSG_LEN			(256)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
 
+#define SE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
+
 struct se_imem_buf {
 	u8 *buf;
 	phys_addr_t phyaddr;
 	u32 size;
 };
 
+struct se_buf_desc {
+	u8 *shared_buf_ptr;
+	u8 *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+/* Status of a char device */
+enum se_if_dev_ctx_status_t {
+	SE_IF_CTX_FREE,
+	SE_IF_CTX_OPENED
+};
+
+struct se_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+/* Private struct for each char device instance. */
+struct se_if_device_ctx {
+	struct device *dev;
+	struct se_if_priv *priv;
+	struct miscdevice miscdev;
+
+	enum se_if_dev_ctx_status_t status;
+	wait_queue_head_t wq;
+	struct semaphore fops_lock;
+
+	u32 pending_hdr;
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem secure_mem;
+	struct se_shared_mem non_secure_mem;
+
+	struct se_api_msg *temp_resp;
+	u32 temp_resp_size;
+	struct notifier_block se_notify;
+};
+
 /* Header of the messages exchange with the EdgeLock Enclave */
 struct se_msg_hdr {
 	u8 ver;
@@ -96,4 +143,6 @@ void free_phybuf_mem_pool(struct device *dev,
 			  u8 *mem_pool_name,
 			  u32 *buf,
 			  u32 size);
+int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx);
+void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx);
 #endif
diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
new file mode 100644
index 000000000000..c2d0a92ef626
--- /dev/null
+++ b/include/uapi/linux/se_ioctl.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_IOCTL_H
+#define SE_IOCTL_H
+
+/* IOCTL definitions. */
+
+struct se_ioctl_setup_iobuf {
+	u8 *user_buf;
+	u32 length;
+	u32 flags;
+	u64 ele_addr;
+};
+
+struct se_ioctl_shared_mem_cfg {
+	u32 base_offset;
+	u32 size;
+};
+
+struct se_ioctl_get_if_info {
+	u8 se_if_id;
+	u8 interrupt_idx;
+	u8 tz;
+	u8 did;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+};
+
+struct se_ioctl_cmd_snd_rcv_rsp_info {
+	u32 *tx_buf;
+	int tx_buf_sz;
+	u32 *rx_buf;
+	int rx_buf_sz;
+};
+
+struct se_ioctl_get_soc_info {
+	u16 soc_id;
+	u16 soc_rev;
+};
+
+/* IO Buffer Flags */
+#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
+#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
+#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
+
+/* IOCTLS */
+#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
+					struct se_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
+					struct se_ioctl_get_if_info)
+/*
+ * ioctl to get SoC Info from user-space.
+ */
+#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
+					struct se_ioctl_get_soc_info)
+
+/*
+ * ioctl to send command and receive response from user-space.
+ */
+#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
+					struct se_ioctl_cmd_snd_rcv_rsp_info)
+#endif

-- 
2.34.1


