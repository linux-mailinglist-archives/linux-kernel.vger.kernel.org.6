Return-Path: <linux-kernel+bounces-292580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD2957172
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9022820F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828834F5FB;
	Mon, 19 Aug 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RgqnCTMt"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC9188CCD;
	Mon, 19 Aug 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087005; cv=fail; b=hOX5wj0fNxn7pov3me9v0/a9BiGn+ZswRJ1rgBGYPVnjYADkMyrmgzycEPDoB+ZGScL5lXfQD4tTFKlPn0a+gPMq7dz3alZ8poQ3SCEfkSz3i+PlIh/r3U5ZMGafKI83zFiBHtF32cqg/Hs4fr/HE/3Sac+zYD2I3cBArJwHbMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087005; c=relaxed/simple;
	bh=RIAtv1ln6rz+VL129rkdQxt2aQl3BMopwFlsihJ9reY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=leIILFjewngPDgm7UK+GFJ5ZcyAPYEiYVMJ4mztU6ehnBr/mv+MzN1xcHbaUuUYJlNdjDLx0EPkha4ECg/qV6cjVXGGJrrFZayGlRtssIz4EKtY6X7KVuFjuIZSErVH6GbSy3TIBkNt+THfrV8onzBWZhyu8NhtsDRL5Z4rlRVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RgqnCTMt; arc=fail smtp.client-ip=40.107.249.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuUdFO+SHLKRoGye2GRUWq5i9kgF91i8nnCm84oHOARPOsS4GYpqbVRvCfKOeKnFJav94GA4R1RXJtj4cyeoJ5rxclsiOfOxoumbIB9LlDMN0dJJGevp4cGlmEkDP5Apn7RUKhCxALa/GSFKzkvJgxwCy0Ns0nsdY/c8oR/ckhh9hXrLlNeSORjYzH5CFOQAbtanW80Zfc/9qoDLXHdtZGZcJnnGhdhFWzJs64kUVUV/Gfwkb6D7CdnHFjWp+fz3kqTmwU5gQ56aIszJd4ilvsQ3vmT34qbhdFAs8vik/bnjreHfupybw5xjVR6b1Sakx/Lwy6XRgu8ZzoNPV5O+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+XxQkOx43LqpWRHWE3skGqEBqwR7n8fYwpf1oCkIzA=;
 b=ngpvXBlNhvP/8VQWruF/t2Pj67sl7v2rKw2T1Lb69jESb4M2MsAt1wYDSZ4r+WGpv7KnRHY2W4u48ruH1Zt5DorsAq/O9OyZ1+P/syP6CVZzNfVzCPs4CZhwdvnl36PYQlPlSC2lroSZEnTTZs/3GxREKjymsXwX6sClXbv7IBi9wPjc+WHnb+St4be6x75g0SPlVwZngUJQ6ps9fjskYiHkhp+q0wgVCYtewjSJuZTxSrzRy8fRN9fN11XA8w+mhyXvTMgpCw3Sxgx+U4BivvJz4nS+6cv9l8Z7Y5VLKW3Kwfs6KV3Ni0Xq89fK/l3XomgvRQDqyIPbKr1mD6wEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+XxQkOx43LqpWRHWE3skGqEBqwR7n8fYwpf1oCkIzA=;
 b=RgqnCTMtXFa5dbxdwn/5IwMvZh4pFge7zNo72d3bgKy3RY+GNUmVXyVFb+GUuoqvVhgH7tpQBtMGT9lANNEHkum1pk8yUv6WmA1/3s5rs2vberTFqTWdnJt2wk4cRliz1rmsSnEFoqnxID0E6Rxc+9Afi+oI3QUz/g3MCswzkJkSBJstOsyAlYNhqdp4095ZAl4BnoJxDlQFrR02Mgk05c2k7e7lAd08ftrLwRB/ECfbsmdlZOz2FWQmvbHPEt4E5fJ/5yvXPSVuxk9aCGMG65R53AqqexLEZu6e8XiqmyPyHeLYCF5PalI+kr6Mj1i85IXdSmhoGz+4tW2v0t9zTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:13 -0400
Subject: [PATCH v2 04/12] arm64: dts: fsl-ls1012a-frdm: move
 clock-sc16is7xx under root node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-4-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=1360;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RIAtv1ln6rz+VL129rkdQxt2aQl3BMopwFlsihJ9reY=;
 b=orjmcKAb6MM5YeCkkoeDRHchRiYkZvd6RfE8FN/sNpDRgMCPTLSxVgbl2mRWIlbUuVPK88Fzw
 Mgtu3OzSwkVDO2ZL+0W1g83IQrrEYJOsErWDmo0PTPjCyvfTrZ/d6ok
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a38906-30f4-4668-b254-08dcc070d43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZRWm0vU2pZVktHZlZNNUllNjIycEhRc3Jkc29Cc1dpaVJ1WFVtMUJYN3Ry?=
 =?utf-8?B?cUl4QURNcmhxM3VNWUNFT0ZsNHRkT2s2eS9kc0gyWUx0YjV5OFJKN2J6MTUr?=
 =?utf-8?B?R2k1dW8zZ0UxYk5uVmJ6T1N2L01lVjc3cjZHR0hSUTduVGVaaTRJRHc5Y1Jw?=
 =?utf-8?B?T21QZEVCOFdWQTF2d0ovazNEa1M0TGdEOUpuWldlK3ZuWG94THdYNzZHUnR3?=
 =?utf-8?B?SkRUdDh4bG5sQTIvRUNkcE9GSitUWHdaRjRqVE5TeSsxTWlBcFllSGhZMktD?=
 =?utf-8?B?UzNrdnVBcWhTV0xEb3JocmN0Z29BK3NNZDVHQjRTUkJaS0hwUEtibXFsbi80?=
 =?utf-8?B?dkM0OTlZWVlyMXZ6bkN0UEZBRE5iYUl1R2ZyWWNOa01NQW8rU3BKa2M2RVRU?=
 =?utf-8?B?KzB5ZjhpOTNMR1VWSkVMc2ZGS3JuMU5xSmRPS0VJOGpGa3hnNXpSZUttd3Bw?=
 =?utf-8?B?OG40d2JrdnE1QlEzRW5qQ1NJY1M3cVBqT3ZleTBqb3BJbnNldysxZngwcmJW?=
 =?utf-8?B?eERUK0RBb0drNFFnbnI4UkUvOUJsQkNvZzRjOGFMOGkvM0NJaFlCT3BHWlg1?=
 =?utf-8?B?ODZaRzU5OUU5dTExT0thNGs4aWpheEt2Z0NYQzRiM080dVliTGFXREE2Y25w?=
 =?utf-8?B?RmNQeFVzb2NOdkRaVFFlNlBkeURCTFJTN2xQelNlNjR5Vk00bzRzczBlM1d1?=
 =?utf-8?B?dFBmTkFISmVWcmVRWjAvcVNHQm5CU0ordGMyMGdLSTJwZVRoa1Q2akd5Z3RL?=
 =?utf-8?B?Um5Qd2pFZkh1U09PaDloMXVtMjNWcUF0SEtMSzR3aFYwZit5cnZrWkNMVjI5?=
 =?utf-8?B?MllyNWo4ZERIYUxGMDU2Uk04RzVpQ0RFSkZ5VDBpcVJPeGp1Qm1PNk9IWDll?=
 =?utf-8?B?cUhXbXV3THlLUGJqWU9IZHBGMVNFOU9EUjd2bC90N2NDM002dk1NYmhhcG9Z?=
 =?utf-8?B?Vy9uUHl5clpDMTVlOUlzR28wcW1LeXlDZisxeDlWUDNYNktnbVQ2czdRRlo2?=
 =?utf-8?B?ZXpybE40cUJLNmhHWDJjZ1l4czMrcGZxbWFqaG5IbDY2cGhZK0Yza1hTUzZG?=
 =?utf-8?B?T0dDU0ZJUSsvbStpN202Zy9mZEdoaHNtaExpMnRuRS94Z1I0RVZyZ3J0UXVG?=
 =?utf-8?B?QllXREhYTExOMUVrU0RabThqaWFhY3BRbzZlQWIwTmVFcFJ0NzA5UHNNZlBl?=
 =?utf-8?B?S0ZNcVQzRWVNTHBzOHJjSzdiQk13TzZacExlaUJjSjRKSlR3MUpnc3NjeExn?=
 =?utf-8?B?ZndTek1kUWN0OTFlSm1jQ0JCQ1VwUXVlaUNnRFdqR2xzR1l5eUdBS2tCUzJ6?=
 =?utf-8?B?MWdBZWQ1RTN5eXVhZzdCMW1PRlpKWGRPVU9jQTlKclJISjFKN1llU1l5R1B1?=
 =?utf-8?B?SUN2bUtmVEJBelNPUVJzTWVFOTQ5aG5zQjJpZnFraUNxcXA5QzdNMEMrSWs3?=
 =?utf-8?B?MmI1cVFSSGVsRFdEaUdwSFZDTGRlcDdBd2lNNm95Q0lrR3QwUDRXZzREeGJj?=
 =?utf-8?B?UnpnVUFndTR3d3llbENXQVhFWVVGVEU0bE5xaWppWmo5TFBBUmdRM1Z4cTNM?=
 =?utf-8?B?Y1JJRnhOSGhScjdPSmk2dVpmYUYrYnZ4ajFVa040UHR6U2k1TTBNYVRuTDFR?=
 =?utf-8?B?SG5taVFoZGMrb1FTOGxGSmxOZlAzZmN6amRFNklWeGxEU3BtQ1Q3citEQkJr?=
 =?utf-8?B?NkN1UUVOTlBBVVBsU1gvU1h3bmhmSXNvajJCNTMveWp1cS9VQ3ZGY3VRRTc5?=
 =?utf-8?B?STVmNlhuRmxMUlg1NmUxV0d2TENqOG5ZVDRYZnU2TWtHY2N0Y29ndElaQ0tQ?=
 =?utf-8?B?VEkvcjB1cU1vVnVlaG9iNGo2bm5hRTF5aGZ6SzVMTFAxelNJWngrbjFSUlFT?=
 =?utf-8?B?Zk5ONDdIWkZvUU1qK0RtRjE4S2dGSjlmQy9hSk5jUTl4Zmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDk5UUFQQ2I3bFJoaHpram1obHcvZzlUUHorQjdpNU9GNjBRc0t5bnZpNEJl?=
 =?utf-8?B?WXVUbjc1alNIUnpDSW5tcytpVDFLTTNNN0ZoU3h6TC9vR1NNUVVwdVIxM1pY?=
 =?utf-8?B?QnBLSmRwRHZuWGo5UGczOEtpYXoxRWNrSURDalovakVXV1kwVUl1SnovbFpw?=
 =?utf-8?B?Y2Y0MlUrc2Y5L2F6SWVuNjJPbGV0YnJTcjhmcUpQbDcrRVR5Sy8vQWQvNmdU?=
 =?utf-8?B?Y2dBbGZ0d0ZsVzUweXRGcGIyWEEzSG9iSU15d3VzNFRIMGRCL2JtWE9qZzRE?=
 =?utf-8?B?NENZcFBBengyWWpuZHNYWldveWlqVG9XSlZaeFk5MmV3aDMrSnJUdkwrWnE2?=
 =?utf-8?B?dXpjOXIwY3RROWJXb1FKcjhiN3BFMVpzZElXWUZFQy9pamVlbXgxbC9LZmtD?=
 =?utf-8?B?aWtMeFMyVXdscFpSamNmeHVqZjloVGtZRVV4WFFYbThjY1Y2RHU4MGkvclRC?=
 =?utf-8?B?dk5YRG93d0t2SzI0b01YVi94ZHYyRG9VK1NZTVJUU01FOHZFalZtRFVITldP?=
 =?utf-8?B?Q0hsS3dEZVVLVTYzRFA5bFNaU0FnL25kV3BxdUxsT3ZnUUplZ3YzbjhkZnp0?=
 =?utf-8?B?ZWoxWnMzZldxbWkrckU1bFFwdXRUeFRzdWZQaTdVU1NjTS9INlBObzFmK0pl?=
 =?utf-8?B?YUNpVnNwZURsc0luUWVGQjhLS0tSN1Z0VzV1RWVaNHpzWVpCWmt3aGV6Q0Zq?=
 =?utf-8?B?TTNUenpsN0kxZ0kwOVNqZHk0dnFxYm9jcXBVQTR1ODJGS0p3QTRnclJXLzJR?=
 =?utf-8?B?UlA5MXdwaHVQWHgxaXZjTDhwR3U5NFhhODJCMVlFN3lkRnRWWC9qVFVuYmFz?=
 =?utf-8?B?NTBobjlTV3VnREFRUDhSNVlrNGJsMlFmcWZmL1FRMkN3UHEwQnYzcDUvTHhQ?=
 =?utf-8?B?SVh0MVE0a0o4Q2EwYXY1OVlTWGJjV2l5UTdJcVBORWFSTGxoMGpVNGgva0ZW?=
 =?utf-8?B?TFR0QUFxS3FycFAwdUpxS1dzRjFqcC95TUpDck9FZTFPeW1hWXJvOEFIV1dj?=
 =?utf-8?B?bUs4ZXYwQmtQS3ZtV2xkaXR4SmN5TG8rUG9NTlJRdmhOU1dvRllJWHp0dzJN?=
 =?utf-8?B?TjEveFlrOWdoV2JEa3JKUkFUaUVtbXE0Mkk2Ykt6NFI2NG02QTVBUE9vbUpS?=
 =?utf-8?B?T0VLZVc4dU5XQyszMlB6Ky85M0RLWk1uUktFYmNZdm14cVZhSHJWRGVFaU5F?=
 =?utf-8?B?SVZONTlPOGplbzB6UWpXMERGeWQyOWs5dWhtVjZielJMT3MzMDYzRmo4OGRY?=
 =?utf-8?B?SFJoY3BRNEJKYnJZMUhyQjR5TW5JNS9BaHFheTh0ZDVpZWErNEdNS3VQTFFl?=
 =?utf-8?B?NVpwb1RiUDh1T0VGUThSbEU3YTNaRFloWGxoM0pMZkVTSUp3Zm1tTDdUa2RI?=
 =?utf-8?B?T2FIcVhyeTBrNTdaQjBnaFkvZ1BiM1htaldNc1hxazdOTzJvTmh1VmcxRk93?=
 =?utf-8?B?QUVSc0pvdUt1emkweURtRjJJbVBVNG1rWXpKTlpHa3htdWIvNU1NM241NTVC?=
 =?utf-8?B?MVExVjBaWFgxV09LMDlHZzd5aEU3SEZLd0NJYk5iUndQUytIb1dqL0xOZ2RW?=
 =?utf-8?B?ekliSEo5KzVoUHhSZzRZTXhqaUFLQjgzbnhsMEV6eGU1Z2o0ZGRhSHRHaXBZ?=
 =?utf-8?B?Z1dUQlFNd1pCVm1vNW12SUo0TzFXMkhKWFUrWEZTaDdJWG1tdHdKcmIvSUNn?=
 =?utf-8?B?anVvUjhtREdJbC8yUWdSYnQ3R3YzbHd3Vmd4R0JJSFdYK1ZOMXBNWXdUYSt5?=
 =?utf-8?B?VXRWUXVSVE0vbGNCWnhvTld1dUZGaDhRdlZoVW9LWSs5Y04rZjlBeXFxUjFl?=
 =?utf-8?B?UmdZUXZHaVFkYy9HNXdVdkp0VEhsMVN0SmIzVEwxaTJ2dVdLaFJMams5QlF0?=
 =?utf-8?B?N1RVYWxsR1dPSEhYeDRiMjluR0lrYjRyR1lrWDRLdW1kbUdjV0VCSHgxclgw?=
 =?utf-8?B?My84MVZueTdPRGFNU0pYcUUxSXNaQmxXSjZ4K1ZNVTdHc3ZEelRoYWZlQ1V5?=
 =?utf-8?B?VllRREFRY0Zabjh1enZub3NHbFpqcmpOUDExZTVRWlFlTVJFQU5sTlI2TEVi?=
 =?utf-8?B?NU02RWthSzgxVHhXOWljUVRqK25Id09KZjgxNElqQVpITE5iVGhCWnJBRzRa?=
 =?utf-8?Q?o/tsbXrhzsBlSuR5W5ENoDGOE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a38906-30f4-4668-b254-08dcc070d43d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:21.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBsM0W942HO+QzfHrxSgCTOVAN1GLpGKGvGfPjeGlDYbbDt0GEhwu5Jpbjcd6EOdrsm91gwAY9NxAtoFUWeI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Move fixed clock "clock-sc16is7x" from dspi to root node to fix below
warning:
arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb:
    serial@0: Unevaluated properties are not allowed ('clock-sc16is7xx' was unexpected)

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
index 2517528f684fe..75081ce3e9a6f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
@@ -20,6 +20,12 @@ sys_mclk: clock-mclk {
 		clock-frequency = <25000000>;
 	};
 
+	sc16is7xx_clk: clock-sc16is7xx {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "1P8V";
@@ -69,12 +75,6 @@ serial@0 {
 		clocks = <&sc16is7xx_clk>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
-
-		sc16is7xx_clk: clock-sc16is7xx {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <24000000>;
-		};
 	};
 };
 

-- 
2.34.1


