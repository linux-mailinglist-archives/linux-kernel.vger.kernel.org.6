Return-Path: <linux-kernel+bounces-284088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B7E94FCCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13FD282EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433B2233A;
	Tue, 13 Aug 2024 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SrZWHbr2"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D11F959;
	Tue, 13 Aug 2024 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523715; cv=fail; b=eu+08HttPQXUGC4Nzhcfc4xRjcCWINS1s1cb/pdmR2y5TqUpbVi3rzVMY/ITRve1C7RFkU/MkzXfWP80R9feMOF7bray+fdja9qFJC1AfaLhsBhYb6obgr/QMJazFCEjPAPghUW4gYzgD/bSciulfngouFcW291e41YPFHOb3M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523715; c=relaxed/simple;
	bh=2fsHcVqpA4YJZDp/CBpE8FVx45PCbc2KL6pBPGoY7jM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tLhoKiruZcOzXyCJKSag4wW9/0mZjaW2VmjPv0HWof16w/LAIMme80MkdQZG76gSdIG2BfTbcKICkhKbFOfbLolLWecqex8kHB4lenxcNCNW3+2QtxRPyRoRQ09Mi5yQEfOqSX1kANljZzl6yA7KuW9gI1eA7wx30WwknbclAFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SrZWHbr2; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+hilxPHRJEX9icJkFER7FZcKR3DzWJOTiGurHv9vIG4BM4h/quCzkbTScf5WLpqSc8I4qQrbx05eN9YIKVsMZZKyhIDNGDVsXo+SrmICQLaSSIZWUDRuC+u5/n+PV4linkL3L1aamD6MkQGAnPz3TWnZDoea9zmJGhOYzUEZFGMb+jHxLwXKp6+HG4iMf8XSuOnnLCf9zBUscjfOLiyoNOl5fa/ahv+GpxRQ84MSG6DIRFXfGu1UV0k4wubq8/D5/HrAN+jj+3+SHQkI151vZqSXcFVW5ii6qOccyMO+l5XrcH7mA303prk5FBWAnSs4wJ5Te6AeErwNwY46IX79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXndktea5ygTZQegwfjucd0subT4uXeYxI72LUcdEBU=;
 b=adW0huDeUnihxkyCB90rz611+VGiwor6u614jKVNtau9523c4VhshLsAauAiN1Oo3x5Wixrhuljsz/k5rQSX9B1gVQz1Hw9wglVj13n00DgqJBIPetTfDfHXsW1nxEfOIvq5RFyPtZEMXz/M+r+E/7rstofQvRnKMTv2iw1/vyB1L00FVZPbjP93BRA4NQjyH34wHavBeYrMOZkot2mgclMHwYuUaC7VdunDXrgNjhYCwKqUOlbskfbsjFSXOwWGhfuiQWhr6R8+nNA7CPqPhxoxFw1f5cxUs6MPecChznczdCrxtCH2j7GkkP4j2lLDmfllF+pEaSj2PH0I4Z8r5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXndktea5ygTZQegwfjucd0subT4uXeYxI72LUcdEBU=;
 b=SrZWHbr2M+h8lbQ+78k2czUQLnPhdb+kin2pCeJ3sgtdiEzD2DYd2iYQ4UgpV/aQgAv/01091K6A64hA8Vxnm8TqPRTEFbysSDH4M8BxJ6Q0427WmVRAgjEKjOxrAIdZF4UiMoJFjWrgsAoU+UbVlMJ6/DK+qP+/aO+/VTOZdrLa95BryeM+VNAFVquBSK8Eb8UWyo0+gos/Nb3rtATL0qZTN7MQvNXQZsF58TnKRODCMwM9v7/zQz3bV1bLcGzNaWi0hexi66JVIiFc56eoE+lladut3d9c+pf4o3t1BFZfIppe6HAYQt3eomwnQd2GOTTP7guCowlTPfsPZkxMmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:34:56 -0400
Subject: [PATCH 01/17] arm64: dts: imx8-ss-img: remove undocument slot for
 jpeg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-1-3494426aea09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1425;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2fsHcVqpA4YJZDp/CBpE8FVx45PCbc2KL6pBPGoY7jM=;
 b=myh/glCN+aHV48sS6c0xHA9CmA4Jf9+oxqkEq/XaJ+ddGLQAwQ4zsDvfwCf+Cbadj5V6+3aJr
 3x8fCGCoXiTDPwRQesfTnQUKIwoYe3itg0ozLKX2kMcMQUCfm/rMhSj
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
X-MS-Office365-Filtering-Correlation-Id: 8caac2ac-3bff-4835-79dd-08dcbb51522b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmZieVhzeFV4Z2tDUzVqbnJKN3Z5bysrY2NzWTBDMHVoVVFjQUhINHJpOTBr?=
 =?utf-8?B?clFrZXhBMWpZSDc3VFlmVUdhN0p4S3dsdTRDMkNScXdkMDlxT2NEUDFuSTdq?=
 =?utf-8?B?b3gxQVJiYStvUUtFcXNGUUJaUC9BblZOczk3TE1YRnh4OUdjSTNuWHFIc1dH?=
 =?utf-8?B?SXZQSndZV2ZJZU9qekFKU2xNTkJoZ0VJb0hHaE43YlV5OFNQMFNGR2pVTU1T?=
 =?utf-8?B?Wk9aSjdnTk9MWjd0c2JUbzdsS0VtUkFlcjJFUm9Ud0NSVnVHdXFFYmNRck1s?=
 =?utf-8?B?NnkrV3VpeEVtMnIydEpYMC9XNFgyK2t5RkMva2M4SjJhNFo4M3FBUDRCdlkz?=
 =?utf-8?B?K1Zmd3lTdmp4K1dUeTJHVW9rNTBORWtRTWFNeUxHclVaVTM4K3haQmtZUlFR?=
 =?utf-8?B?RzFzUEhlcVRzTWVzZVZBZ1ljenpCTVFvdEtjNnduY05uaDQwZ1YzbEZvVmgx?=
 =?utf-8?B?b3FNQU8yUWNIVG5OdDBiOERBaitnYzFOWmNFZml0ejhMQ01PMnE2bmRxbFIx?=
 =?utf-8?B?RWl4bTluZEpYRnlqQ0hMQ2dVMldURnZ5ekxtMjlJcWN5TVZIWkZFSGhhTE5k?=
 =?utf-8?B?d1FiajVia3FuYUxQbjRpRVBQcXpta2RFZUw0TW8zL1dXbDRwNzZRbmladXlE?=
 =?utf-8?B?S3YyTWQxcGU2bmxzd2pHQWVzRkVacmR2QmpKRHNGSGovM3paZS9hYzB1VGE5?=
 =?utf-8?B?Vk9Ta09tVFc5Ymx6bHBaWUpabnZDK25tb0RETFFrRjlyOFJLaXovVFlnQ25r?=
 =?utf-8?B?dnZCNWFiZUN6bk81SDRKd3FMZW1JR3M1S0wzekpoNC9FS2RNajhTQStBSjRz?=
 =?utf-8?B?NUFPeEZaUmE5aHEzUkVoY1JvZUhrbXQxVXBvUUc4bUswb2R5b2JDR0ZLWE5x?=
 =?utf-8?B?NmVuMFJvdm1CSUNzVjhZTTA1VmtYV1BFY3FRSGxWMWlGcmJuKzJHQkxHNmY2?=
 =?utf-8?B?a3JrK3padkRpbmJMdVphUWc1dzlFbHpaMTBXdVU5Sk53OFRCVnliRDJEM1cx?=
 =?utf-8?B?bDNEamVJbDE0TUszTUVHNDY5NkZXcTBrcEdxWk5wRzB0SlNMbW9iVWNMeXNB?=
 =?utf-8?B?VDBjS0Q5L1JvVEVsMXlzdmRvZ1B1eTdpenFuSzdST0JIOTV1MS9WSFZoeU84?=
 =?utf-8?B?ZUdFY2s2Vm8wdFoya2NhT1NVTGdsYjBybld1Qm9FSk1WRDMrZ050UWtxRXVr?=
 =?utf-8?B?RXNwMzI3b2xVRWtaNnduS3J3dkFPbUp1cWhWT2padk5aeVlyN2o0UExyRjB2?=
 =?utf-8?B?cU5mYmZibmVhM0ZsellET3NVZGd5Y3NiWXVyY1VRWkpzeHdhc2IrYXZHRGlD?=
 =?utf-8?B?WHVxcDQ1cklvbkcyUFFyY2d4RDYveVZrVWE3czdEa0N1c09SVHk5TVlENEFi?=
 =?utf-8?B?aS95MW5nL1dma0wyTU56N2NHVkVoUzYxY2g5VVIwRkhEeVhadzh0enRncDdw?=
 =?utf-8?B?eElzWVZFYjUxNk1wemlJOU0yVFpJQVU1RUR3aHpUVmVLSmhTZUNBZFJqQXo0?=
 =?utf-8?B?VXNnbXlKRHRLQmlJT3c0TGw4V25lZzBCaWh2VFRqYjFSZUpHbmxsYk5wVHR4?=
 =?utf-8?B?NEU5QURMa3I3Y3doZWhDZjJrK2xrVlE5Y2tMZ1A0WHNoS2swRjBKSVhKaG9G?=
 =?utf-8?B?enRTU0ZNdnVlOVltLzRleFEyVUlaeHlneWxwTkZIL3ZhQnNmVTBabjAzckp2?=
 =?utf-8?B?YlRIVVdlVktjTGZTcjZKTzdUTjZRdm90VytBbFVuaFZmWllwak1IZzlMNDFX?=
 =?utf-8?B?QUJKV25qRG9MYkZXcVBZYUxXN2EyTVRwcU5XTWtuWXBmUnM4MUo2dGhVcitz?=
 =?utf-8?Q?h7oe6n47JFYDjBC6t6T0ClcVYXdmSobvwFEfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWRZNDZ5WElHOWtHSWQ0RVJFdEgyNVZsb0V1aVNjZmc3TnBZdy85SEFNUkdV?=
 =?utf-8?B?WVdXYkg0SGxsZUhreERtdkgyL21XME9kVk9TYllMRU8zUFVNa2hpVmF0cXpy?=
 =?utf-8?B?Y0t6RkczWU94OGY5b2ExSE44RlYwNU42eDB6bDRueFg3Sm1vdnA1anJSaUZI?=
 =?utf-8?B?SkkrV1dlTXI4OFp2QVNBR0g4Q0EzamRxTG1Bc1hIWm5LRlNwQUFvck9XcEdx?=
 =?utf-8?B?NEJDTCtPbHRVSlluV1RVbVo0NzNkQ3VLbjRGaGxqbjVGaVlIWFZzWHV1OTAr?=
 =?utf-8?B?dFhyMXB1S01Ra2liSHlUbFdTNnBnNjZjeFFVZHBPMy8vT0FTY3U1L045cThV?=
 =?utf-8?B?MkgzWXpNblBrbjljd1BpRXZodlNlWnpXYnhCSEdVR1pxdjhubzVuODhiQzJP?=
 =?utf-8?B?OFU4azFPNHRERTJ4T29jM3dzUTBaTmU2Q3c4alZqY3YwUE44S25UdzlBbDJj?=
 =?utf-8?B?MVJKVDJZWG15K0J2NTNNaWYybmgxSzZ0N0IrcGdaQzFhOVVaV3ZrUHRxd3l5?=
 =?utf-8?B?b2xTYU1sRHJ5dW5FR21PNzdIclRZZXRwY1FLL05rUDNIUDZpNDJuRWlxbVBj?=
 =?utf-8?B?dFFMU2NXWk9pc2JiSmNOSTYxRWdub2tFUGFkUVk2QVZpVkczaHhIZmU1ZGJN?=
 =?utf-8?B?ZEoxWXNMcHkvK2tWRVc0K3RNd1EvZEtvSlg4aXJodFcwN1NHRy9DYTRXUXha?=
 =?utf-8?B?aGhWTFNPRjdNRjhTdlpkNlp3TlRoMVNmSjJMU0o1V0FYM05QQWRVWUo1clVX?=
 =?utf-8?B?TkFMSlVPSXE3K3M1UEovQURBRHdiMzRqWHdFcDBiYW1RaEtzMDJMYWdRbklm?=
 =?utf-8?B?SDM2WlJyZmloblRJRnJPT1JlSTZrUzlpUnFFU1I5MHdxeEFVNkIwVkk0QXB1?=
 =?utf-8?B?eDJUczNDa2FpbmdMWm1XOGVUZXlhWS9WTFBqN2NqdytBcENyS2ZXWVo0VmQx?=
 =?utf-8?B?UnR2MnVSdmFna0RhaE44TXFDWGpxeERsS1c2V2tTRnp1cC9ZL1ZYS1pCajNz?=
 =?utf-8?B?QzZXa0VMdjJVejZ6VGViTVgwUVZVNGxId2ozVy9rbUpQL3VvbHRxNDNZRGQ4?=
 =?utf-8?B?OFdKZXRRMTRUSGhSQitPTjR5SnBpaE54MjM4WWZaWllRMmFVTm9JdzZIRWk1?=
 =?utf-8?B?NHRJeXdESXltK05GbHVteTd3NlhMelNRN3RONGRmTUJWczZNMGJkZ29GV2lC?=
 =?utf-8?B?WVVlYVViZ2tEZElyVzVtRjZ5azNEQ1NQRlFaOGpNTzJsdURQTHlDWVlXTFVp?=
 =?utf-8?B?M0h2MUdGWGhlRXU3N1B0aXpmSlE3R0puTWtnQmRDRVluUGhydWRWMG9LanBz?=
 =?utf-8?B?dGVOTzR3TTQ1RjFzS0g1Y0lZT1JXbG1JR0FWQ0dpUmQ1a1VWOU1sSWsyTjAv?=
 =?utf-8?B?VlFVQ09FZjRUKzdoa04wRjJvYi83Tm8zNVFHOHZMdmJVMER5bzBKRkxtSVA1?=
 =?utf-8?B?aThua1hEcUoyemk2VCtxNmZmMlp6cVgzVCszK0UvTzFnWUl4a0lDeTZtTFZM?=
 =?utf-8?B?b2RpUzN1V2EzcS9FTFBwbFU2eUdvMFBUVkJFMXZoUWNhaHcwMmVaRVJuMko2?=
 =?utf-8?B?SnF5UTRXdEIvK0NxRW1uMTdUR1JEZlpzV3hYeHFmeWFrMkc1dE5GSW1wQU8x?=
 =?utf-8?B?UGlwY3hGWkh5OC9kd2JkS2dJRGszVTdmdG9XSUFuRE5KaW9hZ09QSEJJeW9O?=
 =?utf-8?B?T2NBb2EvWGFkWVBTckR3cjJVaHlNMmo4VnhtVUJ1c3doYVdjbGx4ZVo0cFhC?=
 =?utf-8?B?bkVtWEprWW56L0ZhVVpCU2pCWHdKbEVnNjJnYWtwZ1I3bjBua2pPL25nQ1pr?=
 =?utf-8?B?ZTBwN1dkc21WakZVT1o4WFdZL2tqalFVUStHU2RZUUFMUlVyODRJM05HOEdI?=
 =?utf-8?B?aDRsV0h4NEo3cGZtVWhlcWZJZWp0WFpEYXRoUGxLcXRXd3ZFaGVmWWVoeDFS?=
 =?utf-8?B?eUpyOWs0V3M5TUU3SnJ1QnQyTysreU9YY2VkYm5maDl2NzBkckpwL1g4bTM5?=
 =?utf-8?B?ekltSXpHakVxM2gyUDhlUE9mbnBpeTlMcW9xQVU5UlN3aU9NTFNaUnF4bysx?=
 =?utf-8?B?THVGbVFoOVN5bVNVY0xiYkhYMEtMT0dqTWpxR1pNcStiaUQ0cE9DQndBSTJR?=
 =?utf-8?Q?qWpHx3UJ/W6917xP33muP1TtH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caac2ac-3bff-4835-79dd-08dcbb51522b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:12.5877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BaDFXHrwDE6JPHfAWbbdqCpfOyWu5YxA7VygDUN26wZ9qf7suWLBkfYENuSdmCE0bFb10k+vDcZiW+jONkCcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Remove undocument 'slot' property. It is default 0 at driver. We can remove
it safely.

Fix below warning:
arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dtb: jpegdec@58400000:
	'slot' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Previous discuss at thread
- https://lore.kernel.org/imx/e3d64b07-98fc-4d43-a1ef-561cbac58552@nxp.com/
- https://lore.kernel.org/all/bbb1875b-7980-46aa-80b4-dbaf2a2d5755@linaro.org/

Slot should be managed by driver self. So remove "slot" in dts file.
---
 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index 77d2928997b4b..d39242c1b9f79 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -26,7 +26,6 @@ jpegdec: jpegdec@58400000 {
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
 				<&pd IMX_SC_R_MJPEG_DEC_S0>;
-		slot = <0>;
 	};
 
 	jpegenc: jpegenc@58450000 {
@@ -39,7 +38,6 @@ jpegenc: jpegenc@58450000 {
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
 				<&pd IMX_SC_R_MJPEG_ENC_S0>;
-		slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {

-- 
2.34.1


