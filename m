Return-Path: <linux-kernel+bounces-334133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBBA97D2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DAF1C214FE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F27013A409;
	Fri, 20 Sep 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bNb+oEXR"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1091304B0;
	Fri, 20 Sep 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821932; cv=fail; b=GfC2xQ0RjVT6g6jzwv3AmBCLLKeIIAZ3Z48yCui7gHWw/gmTlt+GoKCr+JhlUiwDnJW8WC8ax60gEqNtXr98CBKQSqOhTUrQ1iML9JLvkanrWtLHX/aRCivdJJtKY4SSkBuxtnul6bhb+ccScHFgwkwUdvbE2zClZwxcTylGcgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821932; c=relaxed/simple;
	bh=WJEcSi1OYM/hgifBm18d3QkwepyGnB3yiJLnO4RNtBU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E2Sd4+zMVxaAEeClySS7F8LB+wlaPHjH6wKZr1WXzZ17bWOZlGzckxrqP2KXB+x6FXAudDWQYzHySbc6l0Dj6ZEKOOOC8gdq/OQq6DnPHfxd/yopUEx78LpKPv8u+Doe1TlIHTBifI1HqOsf7OORlJ4V1vqUDDC39O0vrXsUTXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bNb+oEXR; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1bfNviKUXCguiZeTuhUg+Zxg85kh2FHtcD2lhZia5OwN+7q130Uul9oQ2U2241ZZZXZriWma1u6K5cFud22T2mNXUqjiAfaUr/5Pa519QJ5gTkiARQ5iH2jP/pzrBpSs9yqm3gb65FcdXaO6+QjqsTpJaaHlAElubRsUufSeZubk25oW4qAqIqhPYy2eA8oX/jXT6PFNcQlsWjQNf0e4jAPOJh9crqOFOoD1e/Gi2pfZGR/yx7Lnm5BWblIg0yet5ElDcZdaY2U+KrdeUzveE6XQ5cgL2w9DtOr93WShUzT2brWcmPDSwGWbPRWjHW7fxK33qPyDAr/mGggbKBKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7jQMVsaBaR0K5GQ5FK86+/yOlnXxkx8ikniVNSfvZw=;
 b=IPqh2L+Ztj03Yk5l5bflA/lpafaGaRaymJOI3rd2D3vF673IiqtDnk+Sy4i8r7FMuMJqdBJ0wkUoirSOnYc1pjHuEXmXw23vWy3WSfYIQV+Nd0Ef2BsPktWiC+TjZ/f1XITMdqMuNCzQXJcd0dHfWalbUV5IjcZdWwBXNRqFz9lDXmM2C+G+K70YJzUiSJbxyY+AKx2VNimvrrT7cBcZ7RzG5ff9xNmh+sLj3m7gDjOsxNvbYDm3c7cTSoOhMSSrFYC8+7MNz9gTrPflDN9sErXHHEV75poYKJ9LZpQ6jITFQQ1Q+pfKnfli0k7+G+EcXOMaeejnuhOrJ9M3kLfHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7jQMVsaBaR0K5GQ5FK86+/yOlnXxkx8ikniVNSfvZw=;
 b=bNb+oEXR9hBF734cUOsZNuqF0burfzuLuC0Bs15qnBQWyLU0x3Vg9OY8krVhqQBCo2GvO7pdsutu4sTLIXaV6mLp5+jcaz9g3unfPqQcrpYLEqPkKlBhBq3xfTAqIqIvwFtiRR96VNCYloiK+7lSBr/vKsNhteUwJoP8NfDOlx9siWCejcN7FSXBFGmkghxY8BeLjg5EAorycc/aNwfKgnQfxzde6SV5ZgkPcUUiKAcgr+LLFgzZNklUO29z0H8rhi+n7hQkqH8Afvk/fZPMjOzRiElpF4oaMpwAGlcvr1SZC19K6LW5stF2HYt/iSE0uOtN/DzW+tVn9IUwUb8n6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 08:45:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 08:45:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 20 Sep 2024 16:54:06 +0800
Subject: [PATCH 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-spi-v1-1-97f220c2e10c@nxp.com>
References: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
In-Reply-To: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726822454; l=884;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BuP9VyjeIY/9wyT5y3n2z0sc+8ehoRAlvVwYzILjd1s=;
 b=l0fa3qM67G88SMRC47Xxw5dUnzFlbTGEr7zVNPiaLXcpB5sA+evHZdwEtJYHqvZrhFKax1fGg
 sSMuDiLHRbdCmcX8wuvkK0BGlgnbC6eKxqHKFfWHT0ejg+HuQfn6XQq
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 550d5a8d-98f3-4939-4f1e-08dcd950931f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHFVb1VPR0VxZGF1OWNQTDNmY3pqSitBeWZvUmorL3RyaFk2NzlhaXYyaXZo?=
 =?utf-8?B?Ni9kN2dFWmFHZVBNUjFiMlVhTnNyUUVWVlJrZGhTUVZVdlBlcVUxY3lidlVm?=
 =?utf-8?B?eHlidWVLUmc1bXF0TkRqdVV2SDBjQ2pSeFRGYUN2RG9IUmRueTFkUCtndk5E?=
 =?utf-8?B?aVdGcWtEZTc3TGFteFppYzVBbUpRdFo1QisvclVNVXUrejNpK2cxMEE5dlJr?=
 =?utf-8?B?TnREbkROaGwwWWFQVWlkKzRiby8zYktEZTRhQWxSVGtqd1AybDJUWXRpVXIz?=
 =?utf-8?B?TlBaM3dwS0V5a2lXL0o3REZacmREVmlWUyt6YkJ6TjFoUnI1UFFKeDhHeC8r?=
 =?utf-8?B?NThVZDZDOVhpSndpMlNmcGJRWitORmRLT1dVUEhpaTlWOEo5Y3BTdjUxZytj?=
 =?utf-8?B?U2Q4eWFXaHdRZ0xLd1NqNEV1M3hvWXZDeDBXUEc0cHk2WVluc0VxWklUVzZi?=
 =?utf-8?B?VFFNQTNQZGszcmczSy9JYjdJT28zMzdyK3ZDZW1ydFB1MVZEaVpZVnBTMVRF?=
 =?utf-8?B?MU5lQ0VCY0d1WHJ1TWVuK2wrVloyOVhuanlZbVlhMGx6L0hIZnJ1dnZNY29G?=
 =?utf-8?B?WHB6UG5TQXBVWVBvTmpSSUR0ZmpvRUJ2TWhReWtrU0U0NDNPbHRtdFhPV3VR?=
 =?utf-8?B?aGpKQTZFRFBXUGppZHA1OFFRNkszWkZ1L3MrbVhiTTc4YmllMVd6TElzcVpC?=
 =?utf-8?B?c1hxT0hPTGlEZU1OM3ByOGRRU2QvT0VaN0xSckJBa3BQWDFUWDk1WHFYS2tP?=
 =?utf-8?B?dC84RFNRQ3dhT2piZDRxZzJhQ3JnTjFFZTA4NUVGcVBWSVdtdlVaMW16K3Rk?=
 =?utf-8?B?OEh4SkNqRlpwWkVaVThnTHJPMlE1em9rVVVNNnBqcXhreFpiaG8zNFIyTWRD?=
 =?utf-8?B?R2wzQWNCMUhGMFZhL0JDTW84NWN3SEpFLy9KaitjL2lYYVEreWw5U01HcU45?=
 =?utf-8?B?ejc4YUVtTXdkcUlkNHVpRlpmdXVselVCL1BoVVNNWTlKSWw4TEVuaGlHRUFu?=
 =?utf-8?B?bmwvb1JBWC9Cd3p3ZitTd3grc09Eay8rMm84MTdUQmJaN3VrUUo4L1BramlK?=
 =?utf-8?B?MGJPMWZQVW9qOHhrTzA3VU5HYWpTWlNDTFNMcThpMUdmQ0NGVEdESGJBTElE?=
 =?utf-8?B?aThOcEowdVF6Mkt2RlZ5bjNoVkFaNExJL0I0SVVkRXFQOWN4SkJKWHNpd1hG?=
 =?utf-8?B?M3I1UGZpMzdqUC9Sa3dHT2EvQkkrM3NITDZ2RTVyUUNtOHJsWDVZK3dNcHFF?=
 =?utf-8?B?TURUek5sNzdIbnVXcHhkRmttQnBSQnNQR1VwUlhCdE5Sb01vQm1Eb3ZDczVM?=
 =?utf-8?B?QmRZd0x3RUY2STJ0SmYzMFd4Rmp4WFNsTEptOUNSdS92T214ZHlxRWNEZkRr?=
 =?utf-8?B?MGJPWjRQZ1l5aEFsME4xbFI3N2R0T25iaGRwS1p4Q3Jzc1pDc0QxMVBqRVBm?=
 =?utf-8?B?UW1taGRTZWI3ZlJGSG92cDdUT25laXNoKzFldmdoUkxlQndrNExxQnBPc1lr?=
 =?utf-8?B?MGVWb0VWM1Ewb2NTTTVyRXY3VWVTZ0NPUldnV2JJV280OXhjMWJxa2ZiZExz?=
 =?utf-8?B?a2lwS0lYYnJaOHpZS0h1cm5TU09FeU1kSVBOQ1ZCcFdtRlFPUlVNY0JxdFl1?=
 =?utf-8?B?TzV2cEhVc2MrTkdGQVk4THBlSXN5UTlHQ1BxalJLM3NEZjZFelZ0SnpxSkR0?=
 =?utf-8?B?WklXcFpjK0p2aTZqWUdFNGNNbHZhaCtvSU0rQ1lqVnlxcEU0cEcyaGdpd0kx?=
 =?utf-8?B?TGpTcmNwdm9hYU5tRVZ4d2hSS0cwaTZocDhxbFlUaTZWV1gxaFpzbjZQOHMx?=
 =?utf-8?B?TTlZZ2tnQStKeXZIUHhUOUwwcEhZNTcreXo0WHFRWkV1NnBDeW9Ba3ZRQ0Fk?=
 =?utf-8?B?V2J2bFhJRnhGVGhON3NlVC9raXpzMWhkWkVma2RjeEd4MmdNaHEvaFdSWDM5?=
 =?utf-8?Q?bNrcHJZuk9o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVNEeXNoSlFiREViS1Q3cVIwSHhBOWVEMEdtWW9IVGgwMDQzLzVYTnp4a2pa?=
 =?utf-8?B?ejlSUG9yTEZWT0pGc0JSYnJORDlBVWk2YjhUMmxZb0hsMThqTlZsMGp3Y0R6?=
 =?utf-8?B?TEV4Tnlybndsbm4rVDhZaVRoM2tuWnJtYys1elN2bnFDWmVod0M5RlZtMldq?=
 =?utf-8?B?UlZQUGlseWM1QVBIRUY3YUhkZFVVdDZVSGdEWlpTcGVSOVZadWpzeVpQU0or?=
 =?utf-8?B?WmUyRE1BcS9FUWJwaTRJeWk5ZW9LTXlKcE5NQXVCdnlvU045a0pWU3pRa2R4?=
 =?utf-8?B?dElieVBBMmdHcnNpdTBwSW1aUnpuOURBZmVIKzBkdENBUEw0cGJiRW9lVElK?=
 =?utf-8?B?UTBZeHo1R0tXSjQvaFFsNGRrUUdNM2lKcU1xKytyNVNlcUdyRmUwRFNoSlRC?=
 =?utf-8?B?ajdHRjBaOUV0UVMrN2ZHTmNSbU5NOVNyaGtNZVBCNUxFa0V1V0xKVEtabmpY?=
 =?utf-8?B?MWhrUFVPVGgyK2RsZjhwSzN3WlE4Sy9pTW9EbVdUWEhKcVE1a2lvbnFIRkhS?=
 =?utf-8?B?U1dXaXhEV1NnSEJicEFFMXhNZEdvRVZhR2FyY00vSURnZUR2d01DWVF4bnVS?=
 =?utf-8?B?bGU4bXF1MW4rb3lRTDNOeE9vSy94NUpqRTN0TXI3eFZpcW5zUG5xTjJ0eUph?=
 =?utf-8?B?L2dDN2hoVElLeVdFVE45cGRBdU1SdnM2WFplOTQvdlE0dWxSQUJXOGM2UGYv?=
 =?utf-8?B?KzBTUzRLMml1eG9ONEVKcU9lVW9RTHdvRnVWazhQRlBIYXNNSHJjY0QycmVJ?=
 =?utf-8?B?RGhYUm9SNWVmNFpsUFRYdk1hZFp4KzdFVCtkQWJhRmFVaUg5N0dvRXVGeHRX?=
 =?utf-8?B?R3ovOXpLZGwyQkpJSHVXNDV2N0p2TmdKNWlXbVhPUXd1cTRwWGVCb2RON1VH?=
 =?utf-8?B?eXdSR25CaGJyR3d0YTlEWU1rTVNzMUdZWEhESThORDV1MzR1MUI5aEw2aExD?=
 =?utf-8?B?QnU5SnRXRUYzaXdyQjdhSlpERlZUZFFOVlBoc0J0RFo4bHhXbm5QRlNOSjk4?=
 =?utf-8?B?OHZDUzB4U3pVM2hiNWdudi96Z2VWTmVEQlpxQlFOeU4xMjEzTEc3TTJQRlFK?=
 =?utf-8?B?UE1MS0xZOW1tRXdvM2lqTHdIYUN6aERhdEJVM0FleFFXRk5jSmJ2Q3Z6a3dr?=
 =?utf-8?B?OXR3TVBhMmpRbjFMV2htZmFETCsyZ3NSNS9IWGM4LzR4Sk1Xb1pMNkFYM0ls?=
 =?utf-8?B?YjlMSUNSeUYrSnRBQ1kwVVlaSzUrcFRYc0Q1VldsbUQwMnJVWS9SeVByejBB?=
 =?utf-8?B?WnQvak9qamtMVVZ2ODJPakhpVkp5MlY3elh1VUhiVFJKdFdJRmlVNFI2OG5i?=
 =?utf-8?B?Snh0bUNIL1k5M29MTURyb2l2Yzd5OFlHMFFZNUJpZEQ0dnZVbFVtVUN4VktD?=
 =?utf-8?B?Z3RobzBqUnFnWUZHam9GZml1NkdlMVdPQmpVTTFTRWE0aVRaeHk1WHFYbVhx?=
 =?utf-8?B?L0thbmV4MG54NG1LWHV5enZPbFlWVzZUZ2g0YzdwWmJTQ0tDd3NhWUgraWpH?=
 =?utf-8?B?ZU5sRXkyUE1XY2FTWk1WT2dtc3p4K2Jidno3TTQwTVl0TjhsZUs4UW9INDQr?=
 =?utf-8?B?Yk8vNU4zeDFHR20rMzdkNkVRUXhvWVBvc0p5emF0d3ZCMjBoQjdaQnU5WTBR?=
 =?utf-8?B?YTA4KzZlYm82VjVGdit2QTljd2h2KzcweGFyWkQ3K3NucnkxSzZndFJPb1c3?=
 =?utf-8?B?aUVOY1FLRXd5ZGxMTVJvdVJJWXZvWWVkYW5Zano2R3FjamcwWnh6KzVLWmZn?=
 =?utf-8?B?YlI5UzNiT01zbThUZk01Snd4WE5adHhuaXRrOThCZXVtYTI4S3NRejFzL3Ro?=
 =?utf-8?B?dThBeWFxdTZtVnV1TzRDaW8xak5mK2kvYWgrZjk4UGNNbmhZRThQUFNpUUFR?=
 =?utf-8?B?V1cwRTlneGdUUXk5WmxWaHQ3aXZtc0E3Y3htUzVoc3dZeU40Ymh2aTJYaWRW?=
 =?utf-8?B?Szkrd0NSYml6SGthM1ZtcmU0TXZrSjR2NzltTU1jVWZFay9IMXAvdHV2Nkpr?=
 =?utf-8?B?ZWI2WnRpSXo5VG5uRWVCVk1aRVJPcUc1RE85eHZ2WVM2L2pyL0NIRWpwYWtk?=
 =?utf-8?B?S2puOWxGdUp3MlFoM3JMd3ZLQ1JnUmxFbUpzR0Ezdk16Sk9aN3VQWHRZT2k5?=
 =?utf-8?Q?VoP9syrQS0Ydp2RXNshsRjxSw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550d5a8d-98f3-4939-4f1e-08dcd950931f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:45:27.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeWMFe3ZsOhJcuxRfdPfbf7zuB3iXZS+eQUiDX4Uxdqgg+Jrgo3CDKlFTF+nMLrXxdJbRVfuP5tiUxPAOJrT+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

From: Peng Fan <peng.fan@nxp.com>

Introduce optional vcc-supply property, spi nor flash needs power supply
to work properly. The power supply maybe software controlable per board
design.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6e3afb42926e..bab0617a51d5 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -96,6 +96,10 @@ properties:
       If "broken-flash-reset" is present then having this property does not
       make any difference.
 
+  vcc-supply:
+    description:
+      Supply for the spi nor power.
+
   spi-cpol: true
   spi-cpha: true
 

-- 
2.37.1


