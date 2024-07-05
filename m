Return-Path: <linux-kernel+bounces-242595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B2928A42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B8A1C22B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3915FCE5;
	Fri,  5 Jul 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oc7GRZtQ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15515F3FF;
	Fri,  5 Jul 2024 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187765; cv=fail; b=UtwiISC9JoO/7BUmgWpEC94o8jhKji3ZgBKg2+5GgazKfJDXmZphxti0Rd+H7HzcF3D1gonCL7QeYcHnfC94wYtQN/vOZyo8kp+wrQQ+Mk37XsIVmEzQkrNwItl7GygMZCArsRFJvS8BQhvjH0iIIzSg3Njp90xV7bqCsJlHPLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187765; c=relaxed/simple;
	bh=6weWdlgRl5lGcWG87/L1YXGq87a/EwMEcBzeAFgsoH8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YPXr3h1AdCid22T2FY6rGfDAg95ZfiyfQ7Q77Lp2Lke5Y8CMNTQeXDgJrqRYPitF0s57kZEmAec2ejP4mD20u1DLTh8mCO6ER0shcctUDHKR5Hes1yfJUzlPQ/GUGoRwm1hHnS0pzdhtIYCVChhxqup2XRQxbWwU+lylbLsOXk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oc7GRZtQ; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBSJ9rvvs5E3ARenSnxYAEjT/xeb32YPB6JnoSjPOmAIRDNH0oMLrmTs2B1T+xBSrsTPEsu8axmeR/fSkdPtqMuXJbNleosEpdcDKEbL41xnmiYIZ6Z0243vY7FNeWC7NKdUtSVX02Pi8eNuMAhusYezl2SMgY6Y6adrM7lG2okLRBxqnY23YqTe5LAci/lF8KepzV++Se5WqHT3L/u/I18jsj+AnFGneDcm3Ffmqpu9+o9NSbV0945J5Q7uLYAVwFf7YIOM9CqoMkGckPSRNdaCBZEUANXZLmLklXyjORag9aC+nH/rkUoMypn7IZOhUim8cOYGYLVgQqiUw4nt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+X+4LcJ+nsjscn0bJGRuHOjwcIcirUqr8c26b0G4KM=;
 b=Xy+oE5D4mBqOU+BkRHXszNCpWjAyAijBieVG42sSzNVSVacKYvsm1oM5oM2UYhCbaq81qsHt+zCR4hcAHw+9L1Q9zK3jxS7lRvmAwnL77YdlHgYgIACR/4WbVnulzzGZRHlRzJGyEdedcW05uzqOg0GDnuEKx4gfRcNcfWi7q5Npr/v/yUoamziKAzzJyQhnx6ZdarJNu/8dcwEb6Y2oWFVLBWOYTE4Hujr6hdj+CkAK2eCiC9mKkYZhxpfH7hStRaAnjLkF4SMYDO4nWOQM1rBRdDsZVCrQ/PVDaLhXrbdKy/XgekbHQqsVFmPIO376Ndf1+JB9xNOl7+HdvN5orA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+X+4LcJ+nsjscn0bJGRuHOjwcIcirUqr8c26b0G4KM=;
 b=Oc7GRZtQ5WYzXZ9PNieHndhTvuGBklc5pM0BhEt9oUBRenEmmdZWJgN54oH919Afvur+CYqLLiIZtX3UqayeXTapNppSPxZttrH0EaodK76jQXf2FU23eA47Jy55qBFFf5/7BjjfraBFY+uRbxP+xkJ2HAwhNpn43g7vA58d9zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9260.eurprd04.prod.outlook.com (2603:10a6:10:370::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 13:56:02 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7741.030; Fri, 5 Jul 2024
 13:56:02 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 05 Jul 2024 19:22:41 +0530
Subject: [PATCH v4 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-imx-se-if-v4-2-52d000e18a1d@nxp.com>
References: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
In-Reply-To: <20240705-imx-se-if-v4-0-52d000e18a1d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720187574; l=4546;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=6weWdlgRl5lGcWG87/L1YXGq87a/EwMEcBzeAFgsoH8=;
 b=5xsFeZhAAUvTv2RUaHTDfL6zd4mn0QxWbTO7biMLQNc1JQKrrXLtOZOz8sTytCxy7DwnAt0EE
 fNtWfestrJIAdI9jtocwCFEPt01OSWxJfzUxL+jYiTP7c50jqlHmH60
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac297c9-f5a4-43cc-26e5-08dc9cfa34be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnFZbGlYYTRiUnhFYythUys5NSsxVkRHY0pIcytQUnVFcHArY1gzRjg1eFo5?=
 =?utf-8?B?TWdkSDY3WS9SQ2pFOExSclpRSGhvL3JTSkNrN2piK1BIak81cEZCQTFmdEUr?=
 =?utf-8?B?a3pHUDB4ZDFvYVpDekRCYU5FdXZwM2dqZVVHTE94cGp6SU15QmlDcitXZ0U4?=
 =?utf-8?B?MVR0c0VIU2F0MVpmakg0bjdsNzM1aktuUUpKcEx1cGxCUTdNZ0Z1L2g2NnJp?=
 =?utf-8?B?SmJmdEczYTYxdXZqUHE4SkVKQ0ZuNFNKTWRpdDlydTZXaUsvaXRsM3BLNXJ1?=
 =?utf-8?B?VTQ5dUl1ck15OHFxbWtLYkJOWHdWZmVSamFnT0s5dG5na1JieGlMN3AxZWll?=
 =?utf-8?B?NkdUb3NSdEdpaUNkY1g1aUJNNmFLcUozWXBJWDUrVUFVYllMSjc3VlYrbytW?=
 =?utf-8?B?ZzJGRnh1djgrQXA5dk0wNjU3bmJ3YUZvSUlmUjc1a1RweUNBaXN5Nllac1hH?=
 =?utf-8?B?eUhEdFBscm9YMCtKYVkybXhzakNrOCtvcUdZbVd5THFyUHpoOFEvdC9xcnNO?=
 =?utf-8?B?eVIxMXZQVlp5ZzQ0QnRjOW9WbjFlWDMzNUFGWmlqWS82WTc3dXBrNVREZzdQ?=
 =?utf-8?B?eGxNd1lSSUhpYmNsVzhCODd0RHR5bURWc2sxTFY1cmNwSkh2d2hjeHhtZjRl?=
 =?utf-8?B?cU9aQ2dHSDRSa2wzdmdMTDhKZEZOWThqLys1NDBuWWh0ZzU0ejJPTkt1aEF0?=
 =?utf-8?B?VTFiN3c0Um5GanEwTVJ2aFI0T2hUVmgxb2JuUWdxUUZNdklMLzAvRlJmV2Vw?=
 =?utf-8?B?am1QYkwyYzhYbXRLbWxLcitvQ1FkVXVoVitseEJKQ2VvNXA5VmVWK09pdVo3?=
 =?utf-8?B?cHRvdEQvMUhURWNQWFZJdHVrU0o1d2JZQXJmTGg5cEhVN3hEZGZOcHhWdVRB?=
 =?utf-8?B?S1Q5a1N4dHZyMGtPUUJlRWk3cGxCNld0Vzk5bm9DZlhUWlFGeHhyczk5UzNM?=
 =?utf-8?B?YUY1ZnVVNXlmRkJzVE8zWGphVHNsWGR1NlVORFZMbGZCSGhSM1paNUJjSklp?=
 =?utf-8?B?dUJNeXhhTEFzRzFpM3FBOW9YQURqWFRUYjBDY1dBY1UzdFhDbFNlZHRpdmpV?=
 =?utf-8?B?NllNclBZMFVrTGZTeW9MbFFnMStPTVB0dTJCMW1jcEhwMjNoYzZ2U1Y5MmpS?=
 =?utf-8?B?aGE0RTUyTVFkZm1MdTc4Vkw0bUF2L05wOGtVeHQ0aXJjcXdpRlBKRjJrUUxI?=
 =?utf-8?B?Z1ZFdXJGVUxCNGZQbVNycWo1U1R2TFlmenRQMUdmcURiMmovSE5mOXJxV1Zw?=
 =?utf-8?B?NWZoTWV1WWNBeTBxbEVNSUh6WU9YZ1RhUXJDdUtzMHJCSjJQTDdTRmR0QmlG?=
 =?utf-8?B?UkVqQVN2R3dmKzBPWHBVZnhGZ0dpVXlQZmlGWnE4djkvOXl5cERnWmltbWZz?=
 =?utf-8?B?MTgwZFpHRFJ1N3U3VEluQ1E0OXZvQXhkajBaN21JU0U5T2J6ZDJncm8zMWda?=
 =?utf-8?B?MW5jSHA4S1hJQXFtMVpUeTVVYjBvSHF2YlV0d3BJalo0cDVLNGhKT0R2cEZu?=
 =?utf-8?B?eUt3VTlhMnRKbldIc0RPZlN5c0M3TjBjR25lUWIvOXpvK2pNK2xpRzNDbmhF?=
 =?utf-8?B?MHQ0YlJHMWJJeHZxZVltZWlwRjk2dGVQc2NEbTh4UWZ1OThZZm84SXhrVU84?=
 =?utf-8?B?QWlWRTBqZ3pzaXVqK1FMbS94MXpRckdWZmlXbkFaRG1qQjlCUGxlNkRHUVd5?=
 =?utf-8?B?QXRSZDQ2ajk1RFd2aERiQzNKYWJWOThEVU16bTluZGJoT3hoSGdzUFdCWldq?=
 =?utf-8?B?MnAzQnF4RjRzZWRoaDdNa0F5NzFIY0Q1T1FWaUlSRW5VQjJyOXh1K0VvOXNB?=
 =?utf-8?Q?7xBM3f30XnLq0zoqnUBFx1HyKv5lZIpKWbPdA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFUxL2ZCdlZ6TTkvQjdmODRYRDlGc21vcTlQRmZMaEYxeTkvZnNaVEdTMFUz?=
 =?utf-8?B?WnFRQ3U4SE9PczB3QnRaU2hQNHNpMVVIMmlnTEh0L0tkRk9RL1BOQmtQdmQ1?=
 =?utf-8?B?M2ExY0pQUkpPRG5wNmFQVmgzYVlrbUlIc2hITFlBMUg0R2h3bENzRkJKRktN?=
 =?utf-8?B?KzgvREtDbFBtcmxsWUpVQlRsRGt4S05zaTNxcFl3Q0J1WUQ1R2VnN3NEY0dt?=
 =?utf-8?B?ck8yY2xnb2NXYUJiajdaU3VQbkUyNGdhZnJKV29rRkNpWXkvckpLdHRTSkhS?=
 =?utf-8?B?dVlYMHBEQnMwN1V5dXdGc1pzTjRwK0djQ2tUVXV4T0hvUXRWU0hYamxmTWNM?=
 =?utf-8?B?TUZodjhJaEJ1QkhSQ2VkYVJSVUlGOFZJbElqdUswUS9wWFZrWWRxSXozYVkr?=
 =?utf-8?B?SzVtNXBQUTJUOG5jSk5qdFUyZGdpeTZ0Z21VRHpYUG1kblppZk9USVdCSXNa?=
 =?utf-8?B?ZzUwUGMrUUF6VThTU2NRN0VnVXp1c29QUW9id0o0VzZmY05ySkZhSmZSSG1x?=
 =?utf-8?B?cXNndjhXOGc0R3Z2bXEwdnp6YmtaQ1djZ2VFakJpckxFczNZZWJXVGdoQzM4?=
 =?utf-8?B?SitoWXdxMTlXNWVsanZWbmgzditOZS82VFQyK0FEUmxVWW91MjcvZHJYQzVW?=
 =?utf-8?B?elZJa2p3cHZzQVpHY3VtMm1pTkRBOHBLOVk3OTNMM2pUY0t6c1Vla0toZm9n?=
 =?utf-8?B?WE5WSWRuK2xNbmxIdlR4MDY1Y243ZkowU0EwNWdNbTRpUEpuZHZEcFB6Y0ho?=
 =?utf-8?B?VThXbUNSYzk3anpocDZabmFtYWpmRFNYaHlXUkVlNWdyYW5Ob1diOXlPNFhh?=
 =?utf-8?B?SU9aa3NlQ0xnSmFKeUE5emEzY1V2MzRhOFcwU21hc3dQUm8xeG1FMWNOdXZx?=
 =?utf-8?B?S3pDeE91c01qT0duRkZQaFQ1TWdBcDlmN3JRSTZ5Ly9oYnNZRlNxYjdYaHRQ?=
 =?utf-8?B?clpYbkVWN29oUDFQRFZBMjRKZmpwZ0xkcWpNamh0WTRsUEJzMWpOR3NRUFNK?=
 =?utf-8?B?SVNkN1FwaUdhZ3lCT1pyZllDbUpKS2toMWh0QW1ZL3l3d09jTi9OSlZVdVJ3?=
 =?utf-8?B?ZXBhZjZrMkprM2JycGNTaE1BSDZ3N2MwbmZXZnJtT2ZLRjRNdUhjbDNtOW1F?=
 =?utf-8?B?QUlZRkF5eWgvRGhPTUUzbWlDVVBzYmhWUzM5d3Y2cDNlelhGeUhmYnVTTy96?=
 =?utf-8?B?RHUrZGlGYTNmTnJEbDNWZm5lb0xGNFBBWERQenRJayttZ0JLaHFrSklqTlM3?=
 =?utf-8?B?SDVZbUFTVTg5bW9hZm1QTERzN1AzV0ozeUFHQjZtb251d2NGWXVUQldvemRv?=
 =?utf-8?B?dy9rb05mVlVjZEtKQlJDTzJ1UUR6M09xZ0VZQmQrWDRtKzBFTEl4K1hUUlVY?=
 =?utf-8?B?by9ta2pHMUVBbFpMUjVDbVlMTGJ5cThKMHVJQ3NUZk5BY3Qrb2NxNnBaK3Yy?=
 =?utf-8?B?UVhJZ0hURlc0N3FsVnJPNWRCNGh3czgwaEo1YTdEak1FRkhoTHpBN2tNY2Q2?=
 =?utf-8?B?VllUVHgwcVVYcTNkUkszU003SDNYTnlXNUM0ajlicnllU043NlUzVFA0RFRn?=
 =?utf-8?B?YUdJcU9YMFVDSTA0NlpHRnB6MEJGNCtRSWdHSDRtNTNZayttRDNJMnpiUUQ5?=
 =?utf-8?B?OFJkaFc5VDkzNGM4TlN6U1dhN3pVZzJ1aWJkbGxHTkpqU2l0eFkzM3dOcTNh?=
 =?utf-8?B?RUQwOGhyNzE0L3FxaXZsKzA1MkFpZUprbCtCY3lEdmNOUGY1YnVuR0EzaWk4?=
 =?utf-8?B?UnRKd25sRXVXNk1mVG9RaUlrWkRKbC9rejROTi9neXZzK0ViRDBmeWdTNTVt?=
 =?utf-8?B?bENsMDVnclN0QjJESE10ajlnTUQ0eVdKZ3l3Yjkxd09XbDFBdWNLZTR6dUdp?=
 =?utf-8?B?dGZKQ3RFcTVIVXBqbnJsMDZUV0s0dlFpWTFUVlhCZUYvY0FEb0l0MTRTbEFE?=
 =?utf-8?B?ZUR3ZStpb09NNzdiazY5YjNERjhJaEJZNyt5Y3haSllrbUw1NUZheUJnWnBr?=
 =?utf-8?B?Ty92UnMxUGErejQ1MmlvRGx0eEVieUpkRFB4YkdrbGUyWUkwWHIwYi9CYzU5?=
 =?utf-8?B?bnNFdktBbmRsZHBYWXVvQWtKUVJQeGdvbURka3JWRldXZUM2a1dkL3RxOHR4?=
 =?utf-8?Q?Sh2y1ccEPZNY3pNvScHPUwwIm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac297c9-f5a4-43cc-26e5-08dc9cfa34be
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:56:02.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfA2ycysUD5ZxG2GoYKIPU7Qh+tRMTiGEmqkjgJBR0QplvXl/uAxltLRdyqLkUporCkFEFIkCrujg1Vn5ipc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9260

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
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..b9018645101d
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,133 @@
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
+  $nodename:
+    pattern: "firmware@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  reg:
+    maxItems: 1
+    description: Identifier of the communication interface to secure-enclave.
+
+  mboxes:
+    description: contain a list of phandles to mailboxes.
+    items:
+      - description: Specify the mailbox used to send message to se firmware
+      - description: Specify the mailbox used to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+      - const: txdb
+      - const: rxdb
+    minItems: 2
+
+  memory-region:
+    description: contains the phandle to reserved external memory.
+    items:
+      - description: It is used by secure-enclave firmware. It is an optional
+          property based on compatible and identifier to communication interface.
+          (see bindings/reserved-memory/reserved-memory.txt)
+
+  sram:
+    description: contains the phandle to sram.
+    items:
+      - description: Phandle to the device SRAM. It is an optional property
+          based on compatible and identifier to communication interface.
+
+required:
+  - compatible
+  - reg
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+              - fsl,imx93-se
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+examples:
+  - |
+    firmware {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      firmware@0 {
+        compatible = "fsl,imx95-se";
+        reg = <0x0>;
+        mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      firmware@3 {
+        compatible = "fsl,imx95-se";
+        reg = <0x3>;
+        mboxes = <&v2x_mu 0 0>, <&v2x_mu 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      firmware@4 {
+        compatible = "fsl,imx95-se";
+        reg = <0x4>;
+        mboxes = <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
+        mbox-names = "tx", "rx";
+      };
+      firmware@5 {
+        compatible = "fsl,imx95-se";
+        reg = <0x5>;
+        mboxes = <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
+        mbox-names = "tx", "rx";
+      };
+    };
+...

-- 
2.34.1


