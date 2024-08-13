Return-Path: <linux-kernel+bounces-284091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5F94FCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981D0B209EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720CE3A8D8;
	Tue, 13 Aug 2024 04:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7Lm4+FE"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E7383A9;
	Tue, 13 Aug 2024 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523728; cv=fail; b=c+pJkmc0+wrtrwDP+4qonGxaB1A+M3lxn31LzRAo7MLqqCB+6nydd/F0UpSMTef/a5kJvZKSgzDtJ2MsRwmwucnOmGJCRPNAcX4cy8eLMPQ9lEH+7ha0K4DOSqEknUsZG6UuT82/DU7bATl+RyQjU0VgtirWaigdzZ8udc/PaKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523728; c=relaxed/simple;
	bh=RJgWbSkGg5PqESd4dPjUNv6SsL83ND+/WrCJopkOHF8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G1IMuHzTON2Zmq5SCZ2/JLYnqQ3aEykKjxpF+MreS4AoTv0HzFBXB14yJ+mnV9iFnmILt/OEQaDVIqO8vHPr4qyG+Hj8Zxb5NZwlt02pO7PXJCgWX1kBNF+a2DUuARIk3g6ECSNjbJs3Dr7ZQYl4gcTmfQCnIF3JTtkTY4I7Snk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f7Lm4+FE; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+lMgXnZG09KqH1WveLUyXkqaF8XzZp0zH1ok0iVVOQsN6Xay6QffGmz+ONjxIK0rfPTd8HyQC6PZizJJLrJ1pcIby+DulVhU6JDDGEd0ebCw9J3qxiTa/C6J0rhU2/Le0BDileSXpDNbdgkpOvWue4KhySezdr2UV0N5WKkFoiLbIUfxUr5N6jOrBpd/CgPZoKoLFwvJS0IPKzaet4BhrUn3+3+khdwGvSjniLBPWbY3+QVGDW2jR56uSn/UPPztCMaQJtJYk+6HmxhiNOnPRa4X6PszGHoVWpN9/S5hnd61tPEqKPeFV6o+gLboujRx+kYW2ZlnfiiW/x1PFgrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAx2TeOUQJdbt3hAdD2XSpwJO8BxCpgZORg0yIx3Be8=;
 b=vjqWHJACj8P6Vw+g+4x6J/5ZEcUNoPl6peQB6BFPawQyRVdQ2djlB6OI5f0zFly9dVB4MDeAvUhR/K3jJvdjqGKcJAqO+UK1lDn0MbEBXOpaxSzdA2e2xE3SGR29SawioWSwgBZx3wiYapbBeXTrOCaaawlr1b6yre1nYtLUnXSM1DKuDXavbXjeixJJIdGMMqF1jirgefDxSRiZ6/qMaqcRpKNH5M/EfqwXF8GPRsVlVhhW1Qhl1s+PCte0Q9N2HXz5gPH+kiwBwfxSxZw2JV9mHsBTcmQmH51jkPIxbSzuOd+oOK+KEkAd40ev2I8FOoA7YaasaJfFCm/DLf0P6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAx2TeOUQJdbt3hAdD2XSpwJO8BxCpgZORg0yIx3Be8=;
 b=f7Lm4+FE5wopOi6bZadl69Ji81pEWwSoU/00l+ww6sTx2O0l544gFdFs8NQxLzM2Y/U50W4k4dIIOebp/e//xeFgSMcrCXZLm+e2IbA9jZtBUcocOQFK2HWAp7jVW6D1ZONMALRZV5qEuVnEUiRzADk3V5KyoMyNEt1tCMd11kndjojsAf5sXycV/2eRXjneIL4U7YpqQQIYPv46rYMk1RGxaBLcqUnPClG2xxVXeoevG/n37rHxMlaoXB0pTTa6EAHlLiS0JcsfRUZEWxOWrS+70Rv7uoJOJMAHptLS8ntnAoRMhfAHma9clLYrkSbhjfSeiXyUdQ79fukttxyILQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:34:59 -0400
Subject: [PATCH 04/17] arm64: dts: imx8mm-venice: rename rs485_en as
 rs485-en-hog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-4-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=4265;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RJgWbSkGg5PqESd4dPjUNv6SsL83ND+/WrCJopkOHF8=;
 b=oEPuuRgAJdKzUcnw3wCdC/YGcUxhXPQlhJ2Fqp0NmVKldPlQfEGutbvQ8bnD6bXi7vgPDEysT
 qEktruOIWZYA6/KG8lslhx1A4drie7aYendCZcxLNO0XNLKWGEOnqqN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bfed0d-aa62-424f-cc51-08dcbb5158e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnQvRkgySmdVTVgxbFBhQitkWFBmSEh4ckV6U3Z2WHM0NlEwUXJtSlZHU29t?=
 =?utf-8?B?M0I0U1dwdmRwNGdsSFhTRkZxeXRMbXpCM01FcTl4elovNkhnY01WUTE0eTVX?=
 =?utf-8?B?bTV2cDhKYkhEUDBXY0xSeS92alFkSG0xdUw0TFU0bFdXY29RUHdmVWlZNDB5?=
 =?utf-8?B?czVIdHVwMnlZbGQzMHFRNFNvSnhIZVVEQTVMRWkvakNKSWxEb2IzSHg4ck01?=
 =?utf-8?B?d2FVS1FXMmlDOUJRemFlUWNabFRpM3g2cXhzK0x1OWRZNXRQczgrc3hVRHB2?=
 =?utf-8?B?OHdBUDI5QmdOYVJvL3h5WjRsYXZSUFhIam82azhCWG4xL0Y5OUZTZ1RKNC9w?=
 =?utf-8?B?N3BFbU91Q2d2NGpDRWZSZ0Y4eUcyaGY4c01zQWs5S0FON0l4em0wdTBVMTNt?=
 =?utf-8?B?ek11d0M5dWFUYTBDZmJZN09VaWFYa2VSRTk1YWR0VldEQ2RVU3h5WFNEYmlV?=
 =?utf-8?B?dWU5bHo0TlZZdGY2WHNyOUdDOFNrNTVxbm92bEFnVGs4L2xVSHp4Y0dqVzJU?=
 =?utf-8?B?eXAyQVY1M3h3eWpGKy94cnZaNE96QXdvMmJEcmgybGhKcW5ybXI4OTdla0Y5?=
 =?utf-8?B?c0trRlgxdTVFVkZRdWdtODhBQU9qOFVyQmF4eTdYMHI4NERCb1BIREd3TzdX?=
 =?utf-8?B?enpFMkNyaHZ3SURGTEVMem9kUjA2OSt0ZVIzcENyM0JiVGkwZUVOemkyZmF2?=
 =?utf-8?B?UHRucHlFSmw3YTVqK2VwQmlZbzlSajQ3N2NhOW1nTHJnY205TWFndW9OWHhY?=
 =?utf-8?B?SXo1RngxN2IyZnZ4T3FHWngremptWWpsaUVyU29XK0x5S0trQ1l5eC9Tcm1u?=
 =?utf-8?B?cUJvR1RxamVQTjQvSTVTcGRwRVhGNWg3VG9ZUlEwb3ViWmJIZGlzVkFXaGhP?=
 =?utf-8?B?RGJqZlJvTFJXVlRlZENocTFIQVU0WVppSnMzLzBQNG5RU2hlMWZBOER5bU5S?=
 =?utf-8?B?YndsazNFTDBTSVIwMTJsL1JVQndnMDVrZ2JHYXgvcC9OUEhqRjNmLzMzSjA5?=
 =?utf-8?B?N0QwUEtZWmdFdk9VTTdLYXpVYS8yRVBXN2M5VWcyeHFROFBWbE0wYUlVZFJI?=
 =?utf-8?B?WmZDTy9XZStkWmU2ZDJWZVNqSlNhWWZuM0hqWGxTZ0ZhOUlhajBEcURDYktw?=
 =?utf-8?B?elF4OEVodUZaUlR1NkdQVzVzTGFkZHQ3QVNtdFprSUpLdHpsMVU4QjFEaUly?=
 =?utf-8?B?NEZBVjU0bWUxWk1iaUI5U0RNSGMzcHMyRjRhMUE2ZXV5WFBLSG1tTFhVVzNv?=
 =?utf-8?B?WFVhSWpxZ2JkLzRwSVZSc2ppZHYyUEFNbmNRcWR0VzRubkNXQTNRaFVGN2Rh?=
 =?utf-8?B?SnY1Snh0eG5nYXRRZEx3SnZ6L3g1cnFrZGhZWTlYNUpSZDJvN1JobWdxRTht?=
 =?utf-8?B?Tmw3aGNabXJMd0VxcjE3RnlEcklsV0owS3FRbS9qT1JKSjhrYURJbWtDdW03?=
 =?utf-8?B?ZFZkdGNkd3BBam1FQ1pRZnVmYkc4MjNHQkprMUpQcWNEWW9PNld5ZkQ3UVdi?=
 =?utf-8?B?MVJDR3NRMU9qT3VESUVrK1I5aHdIUzV4Y0F4UGgrODhha3cza0RYYjh2MkxN?=
 =?utf-8?B?bGdxU05QbUdMNytJSEY5UkFQUUI4RkJNUVhybUpIRnNSQVdTT0JoMWUycGtE?=
 =?utf-8?B?Tk9RdU9Oang1UlJMN1pBMHZ3bDZXMkZwWU9HSHBUVFRoak9yQ280TzBRTFlo?=
 =?utf-8?B?VndOaVg0dWJSdWpoc0lQNmJFSEVPbUl2SVRKd0hMVXdjd3JrVWxlaWFhMHBN?=
 =?utf-8?B?Nk9lbGJYL0l0YkdGcjlLU3FmRTBkeWNmeStFZHY5Wkl4QVBoWGNiV1MvOEV1?=
 =?utf-8?B?bE1McWUzUlRSYkxDb2syQXVZOVJmeVpJcTd4UmMrNE5ZRE8zQU91ZWlSN0NR?=
 =?utf-8?B?SnhoeW82b1psS0Y3Wi9aZXNlNGRseW5GU3Nxa3ZQaEhYbmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djVPK2xPNUExb3RYTHZySG0vMUZwZWY3bXF0SVB4eXoyMVhiVXRtUGNML0F6?=
 =?utf-8?B?a25ubDNTZHg0ZUlqSURyK2FWYWZVWXhHNzVGZkMweGFKbnpQSnpqdTF5cDFw?=
 =?utf-8?B?MW1RVjQ0bVRrUnBzbnkvODFYY3ZtaDloMm5HNDJDVUhxTXpUVEZSZUZ5a0pM?=
 =?utf-8?B?YUVMbCtKRXZxRnhUZEI3bzRBKzZZNTVnNmRUUlQvV1gvSCtncEJyS09BK0tt?=
 =?utf-8?B?MGJRY2tFdEM5MGNSb0NiSENTUElEdEN5RFFCVEZqUDlLMjdtV2s0Q1dSLy9t?=
 =?utf-8?B?WTF6M3JWdEpvM212VDhIUWg0NkdEMFNBNGJMNTRVSWlTdFY3aGJEeE54RG1m?=
 =?utf-8?B?anNrdGJoaXVLTFE0V1ZKMEtrUWNPeWh0c3NOTFo1aWlVdzNYejZMYWt2RFRL?=
 =?utf-8?B?RlpVU0tWeGc0bk5IWnZPSSs5d3RTNDhPY1RKS2RCV1AzOGN3NENmUTlwRldu?=
 =?utf-8?B?RVBnWU5Fd2lwMFpIR3FqUVdRQWpWSzFPSVpyNXlyV0FCV0dVRzUrQUYrR3Rv?=
 =?utf-8?B?bDFRMDlid0hSRUMyVUtFaWM5Nk81Z3o5NFJtTmNPcVRtSUUxaXRLclkzQmRw?=
 =?utf-8?B?NVU0MXQ2R251SVZ3aVFXNXZvRFNvNnI1alFBaVZpNlBxYTVoVWxLQTJjRFp4?=
 =?utf-8?B?UmpscWNicnlVVEdEYlRwQXM2eTVVUlhvZ29OcFB0RER1V3lFT3NYUUJlYmFJ?=
 =?utf-8?B?RkUvblFFY0NlTWNhK2ttM2laYWdMQ0g4SzRYemZkaDJwWXNlNVUrckdqejdh?=
 =?utf-8?B?OTk5cnlka2lNelF6dFhqZzd2cm0xVXdxekpBYUZoWnI2Nk5YOVdSY3RpNE0x?=
 =?utf-8?B?ZzBoNGRkY1lsY2RlSTA3RDdjQ29yaGhsS1RhQ2ozakVma0x6Wit3b214bnNr?=
 =?utf-8?B?R1dwb1NyWDBPMHhkY1lpajJYby9nSmNxTVN1TWtVV0JjeWoxNlE2OW5nSjNC?=
 =?utf-8?B?anFMMUtkVlY2dVh6SDBmS3R5ZHlaU3N0dHVRb1VCenNrSzNOaERsV0hINm9E?=
 =?utf-8?B?VFhCdWR0U2x6T2ttdzdieFhkcVZ4V0xTOWtyRkFSbkc4dVFmQXpQWUlrMHI4?=
 =?utf-8?B?ZVNPZ0U4T2xHdHVmeDE5ZzBzdGlNSjJwRDBiRHhMb0xoM1p2ejk4SE40bTdk?=
 =?utf-8?B?eGdVdUtNWkJsU3ZxaW9hK3c2Uk5HV1hNNnhYOERyN2h0Wlc2bnlEang2bXUz?=
 =?utf-8?B?QmtHY3FWMjNIWFZWdFZXQlMwUFcrNXV1L3dFQW9XeU9BNkl5dHEzZ0cwNU5E?=
 =?utf-8?B?WGV6d3g0cFlDVGRNT0xDbm1ldDlQYjlNWnZETzFjaEN0NExGcTFuYnRtdzBF?=
 =?utf-8?B?M1lRWXM4ekRHbVJxQlZGYUh1WUIzVFlxdDFHUm4zRDEzRGJPczlJcGVjamlx?=
 =?utf-8?B?SVlTL1VEYlBnZmc3Vy95VE1NSGwyMDJtQkdPQ2Z0MHdPZ2dWQ1RTemd6WE5v?=
 =?utf-8?B?TEM2ZE1nT0lhb1UrcC9CU0k2KzZ2eG11UGxPV3AwNVE1aHVnOVVEWkZqNXBv?=
 =?utf-8?B?S1F3NzNEeFBPeEo1d0Q0eGJ6TVVYZXFDdEE1aXZ2N3hPQ3hMeEtjdit3Y3dM?=
 =?utf-8?B?Y3cxNjFUaEx5MFkrUUFuOTVrdE16OEp0Znp3eWlCUTVOVU45THNnZko3ZkZs?=
 =?utf-8?B?bHVOTExrUjFUVDI5Vm5FWFhEa2hleDdxUzg1eGdBSUNjMVNrSHVGTVk5U2NV?=
 =?utf-8?B?ZHV2OVFCd3Fsa1JGSUFLL3dvVExTeFg4bzlLQjRKa296Z0NKT0VXUGhtdDFz?=
 =?utf-8?B?SmVIOW05MDIxVTBRRW9kS3M2L3UwRDhqUUVqM3ppK1RsbVQ0VDFYT0N5QmYz?=
 =?utf-8?B?QmE5YytvdjBiVWI5S0tRS2NRQU1LbXV0b1VWYURpWENnVHNpV3dhaTZPRHdY?=
 =?utf-8?B?TE9wemFPZHdEMENObHlHMnlqNnpYcmdRUXFjQlhWaTZhMmNPMWZuMlIxYkRF?=
 =?utf-8?B?RnZKMmNncENtekN2S3RraHVNd2JZUjRrL3VLSHVWNDlaSVR1c3JBMkdkbFVY?=
 =?utf-8?B?RDlOenF4S2hJS0ZweXhJS2Z5TXJEUU1MbWFwdlkwYUhENzVtdHZ1cXRnbFFn?=
 =?utf-8?B?cjh3N0xlbkN3a0hmVGtBaUtwbWZwVUFJU2Z0NThXa0todmlMZ0tKNGJBd0FE?=
 =?utf-8?Q?xLfc8ZqPnXWLBS9AxYXFONgaH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bfed0d-aa62-424f-cc51-08dcbb5158e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:23.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv+xj3PVqILo4qUhK1FTuNzc7Roq7ah5E7y2UJki8PRO2qb+F8GBBke6elmgOFHm9gMDdw+7rGPx+8oRxJVVNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Rename gpio rs485_en as rs485-en-hog to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb:
  gpio@30230000: 'rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso     | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso     | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
index 47d3c0c49e8a0..bb2056746f8c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
@@ -16,7 +16,7 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
index 7fcd8c851159a..45ac8bdce8699 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
index b19e38fc27bae..30aa620d7004d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
index c0f6aece844a0..b1a9f35e1dfa7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
@@ -16,7 +16,7 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
index e909cbd8db4bc..44ebc0a58c51a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
index 1508cb5175b3e..2f8a7ac408739 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-high;

-- 
2.34.1


