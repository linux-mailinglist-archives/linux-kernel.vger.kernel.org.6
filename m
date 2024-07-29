Return-Path: <linux-kernel+bounces-266305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B0093FDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC26284461
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6B1891D6;
	Mon, 29 Jul 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EtAN+5fl"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031018787E;
	Mon, 29 Jul 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279601; cv=fail; b=oD7bW2hfMEVOxxd5hDxo6z5x3rv5cxKLsttGPAJHk3qCOjxwyMRlUKFKu9/isysCxvWdfE2mcq0t2JLkDZ2FuKigc4YVNq3luaFJR72CmMQi5Igt4C3rGk13e91d7Opo27bHeJgJR+k6GuE25eyqStYnZJESbJKi/cduaTO0iEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279601; c=relaxed/simple;
	bh=blky9SvMX6QQ01JGON2KTJt3UNjxJtSOQfMDii0yROY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o/pLOpTm9ZOaFMhx/9JcKA8zrW56AkbQfVsgjAb33oJGJjvtZo+rB+oeQIghRcv2YsSz1Mw/wIukbwXVl4ELxBAqJhixjKaic03fnVIA/Cckb/zJdj7dWDyP9OXRv1Sk7CtvWrYJmSAJY8ocaq4nLV11zA31xRk6kjYPuZmfcIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EtAN+5fl; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr5dvfzKC8D7RVzE2celbG/UkQlzPsySuZRuls7G5ppJ+qdlIg7YOqn30W5jzCgMv1GEyxzzg33cIoQPZ1Ae05lxH+BPRztUAap2XjhPc+V4TK50zNUPTMDrL0Aa05QQYVrEeQwrvSQrWY1I+NEF4uAuFzuDuvaz2JtSlPWt2G4ufGm29HXePdb8htc0BYRs1Ssk4pp9LymnSjYkY97GHRErlxfiZljBN10AeJwTxSJbAwh2tCJhEELncyd/8ot78+ekcWdyZ1b/kt1KhFUVARSvq6ULodlIj+smqv+0DQEesYTzNGjhLtN2TOuNt5OaYsmSF03L7pABnH0yUVvubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnRoZmZ6HbBvb1m9zJfvjUz7d/31F8G+3TLjNAJbz4E=;
 b=pk+QfkAJutlRUBnWmdJz4Bt+cOSCK5mikNvULIvbqXoLuPwiiQ7eB5jI7DIKsA53ka14gVsrO/r1yhWyztGm9vPv+wyWJhT/9virtXo6FrBXvKJr7MYe4Wl7lQwWbiHKVvdrm+l/l4dsl78i5v30gxWJHuAbG5gxO8m2Rz1V/2/0pnxpKagXzzuqeTFEtwPUwo9Av1qeF6Z06u8qbOXYQYGoB4Ckp+0T2fXiteSpt3lViwFFBUOAihDWcz5RsIHUqn+MAJHZx0sRXVc1hUjjLM/t/JXpUT4JlPowqfcZN7E0C3PlZfnfrAzl9FNkfNP/ro8eVbrAH4xOX5vLKNJl5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnRoZmZ6HbBvb1m9zJfvjUz7d/31F8G+3TLjNAJbz4E=;
 b=EtAN+5flX6ZDU7swlyI8nQrLrPgq6LphkagXGyG+JXkLtVecvKoMiKoWpddMwtkGWzcHHPf0Z7Zwzv5F3YRRMAHp6fI+6Tao15Y2Q4DiyccY9hSR9ZZSDiFbnD9FsSqj3y1NY/UiRvaWS9gv8VB+cyPWk24iWdkjf5zSmGyfTV52vexCU8I6Sq/tYtGVPAQUdFrlIwifWLIEuD3Fzf1chUzajfRunW7dOnh19tkebHA+0UpnNjw5G8sJVXS42ydtKV/oyYda48MunhGMyYC1Tn9hqnSJDXIZeTNurwicxfpRxbXD/sWYKB1LeupiYM0WQ8fzJ//FlUd0A44PCO2jsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:59:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:59:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:25 -0400
Subject: [PATCH v2 03/10] arm64: dts: layerscape: use common pcs-handle
 property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-3-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=6527;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=blky9SvMX6QQ01JGON2KTJt3UNjxJtSOQfMDii0yROY=;
 b=04OrOX803o51ArbEva1kqy1xQkD4/QY8FBdCKOPyOJx9XlcTtboxGCvIB8c1ivC3qwutHCRwF
 Ep2GWZUxVieBjjAaxdSJQa5DMFvJrZEKFK2LeW4xZU1X7aOghTf23hL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2e7a97-449d-42a6-a5ca-08dcb000a379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2xCL1NtZ1lEQ0VKT0RFT3d3NUU4YmR1cjNOcEJlZzFPL21LRnNsbGJtVE5H?=
 =?utf-8?B?WmhMaGEzRGEyNWgxUUJGSFhsMm0xZzNoT0JyOE5aKy9PUm9pY1VaWm9WVjl3?=
 =?utf-8?B?SmRaTGx4NEM3WlI3aTVPenJYQXFoYVVPUnBpNGVBMkd0STYzQ0RrSlVsTFR2?=
 =?utf-8?B?SmxJUzBTZVNCdmh4RFpOaExoQXNHV0lYV2R1d3o0V3h0WXlNYUJBY1kzV0RE?=
 =?utf-8?B?YVptTzFRZ3VuQm5IdGQzT1hDaEN5eHNoNkdqYThkSGdsaVJUa1VmeFpqemU3?=
 =?utf-8?B?L1BQbk5XcFpxTW5Fa3oyck9HRkRPdWt0SHoveWR6NWduTGk3UFJqRVRJcWJr?=
 =?utf-8?B?aEdrQ0RodlJEVHBFblhQRHd1VUlxNlZSYWc4OUhBaVR4elEzOGt6dER4TkZ1?=
 =?utf-8?B?aUZxTlB2OHI2eXBMWUJlNnJkVjhUSXRta1dqSStBMGRNSnpkcHlVZ0IvaUxi?=
 =?utf-8?B?LzZ5N2VBMlhrVVNSL20wWWQvUkFMM3FtVURLUWZ4U0VVQjR3VHRuOVlySDBl?=
 =?utf-8?B?a1BVTXdsRm9Dc0NuaGk4allPY3ZIWkZQYUMweXFicTEwNEFqWEcxeFRBU1k5?=
 =?utf-8?B?eUFiSi9YN2c1M0pHMVhIa05PTVFRbmJUT00xbEU0SStkL2tnaG9NRHJYNjds?=
 =?utf-8?B?NHJkN29LOEV5RWN2MGN2MU56dFRWUExCbjNiYmlGNlVlanNDcG5zc1NSR3BR?=
 =?utf-8?B?bG15amkzMGdURTl2bGtqcDVPQzlSdlNLRmtNSFlsby9EdE5jeXRlOTRFQ2N3?=
 =?utf-8?B?WXpHYzAyRTBCbzRINDhZK0J6dDFRVmsxajQ5UCtYRmRyTktMSnVKdkFZZzVn?=
 =?utf-8?B?ZUt1V3RpM0JpRWVRN3QzUFBxOEtoL0VUeE5GRWJRS3duNnFpdkFNZmRaWTQx?=
 =?utf-8?B?bHpzdkRYUDdabVFHenlTdmRuSVUvQVNsejhnZHNZZ2haWjhaQVNqSFlLSUJs?=
 =?utf-8?B?VUt1UGFsdERlTHB5eUduNTkrd3ZVeHhZV3VsZkJZZWhtbTlNUVVncjIxclcr?=
 =?utf-8?B?LzBZVUlpOVpSYWdmeGRReWhPMlNSVk9xaEM3TGFzZC9BZG9PMTRXSWpHMU1o?=
 =?utf-8?B?NFJMSFNhNk5YWC9WeVgreGh4bHFXV2dmaU85TmwwczF1aU43RVpqTmgwdS9Q?=
 =?utf-8?B?aXFKc1d3ZFRXN3pjcWpMMkY3bzBzUEpmQk5DbWJnaXRtd1pud1E1Q1VwNnJ3?=
 =?utf-8?B?RnhEc25lQ004a1pPQnpMNVVreWdvWGl0eDBzeUxJNEMyS2RNUERwUHYrL3dY?=
 =?utf-8?B?N00yRis4MzVMWU5FT3BTd2dsdUhLMXV4eFVIRmUyT1JLUjVjeGVQK3Z4WmQ1?=
 =?utf-8?B?cXdmRXMwM1Y0Z05xNG1ibWZGOXhPYXNnYXlJL3FnRzdLQzIvYXI5czNOU2VC?=
 =?utf-8?B?dWJlMVpDY2NyQnhLTkthTngwY0l3SVNOaTY1MzErbWwzYktjRFlTOEZKR1oy?=
 =?utf-8?B?b0JBTlc0K2krT3NnQzlqNER5TkRJTEMyb0tNREM1bWtmU2h2Yy9wcFhqU0VR?=
 =?utf-8?B?dmtnRXZQcGZvZk9PZzZwOTQ2N1pId1RUU2wxK0dWY2JhaFVEeFNjamNwcXBU?=
 =?utf-8?B?WnI2ckpsZnF3aG92aTVYRlR1NGNpT0tzTmVTd25GUDhjeFpXblZ4NDNmamlh?=
 =?utf-8?B?VkFCci9EWDNCcjlKd3ArUVhNOUdGdG5TenYxRWZ4ZVp0ZWgwZzNHb0EwYjh2?=
 =?utf-8?B?OU5YMVoyV3FYcmxhWnorU044Wjg4VlhKcXVFUVFWaHlsdUNZWmRWMnBSa1M4?=
 =?utf-8?B?Y255SEx0eU1XMThWK2FTUFhnRWQ3d2t6VmhjdmtOcmlGbElMaE5RMzJBbkZo?=
 =?utf-8?Q?pH0GI0ESXVRhM4L2uIWlQrB/ewKGlxNGmzH/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEEzNi9QaDMxdG1uM0tQZkNrUjFlSzZ0MjZVemgwenl1VnpwUG9PYXZsdVlh?=
 =?utf-8?B?T1JtcmRieENSdGVQRWxWZ0ZBMGtNN0p1SHV4dUlrTmt2VFkyVHN0dmVUR1pN?=
 =?utf-8?B?YitRREtuWnZ2RWdIWElsKzlVbmtoSGJpVTNQei9acFltUW1scWYybjE3TXZ1?=
 =?utf-8?B?TWpWWTJZRU96TEQvY0lJSlhIbWNoQnFZOHhMT2xaaXdkSVZ1bHhDYysvYm1o?=
 =?utf-8?B?SzdWSk05bWxsZUJGUzJHRTQvMmVhWTBGVHFmaUdPTXFBUkg2ZUxqOUcvTUlo?=
 =?utf-8?B?TG9SdjVsUUZjSHNXRmpEbGJXZUNsbWRHeURIU01MdmE1bTRIWjU0alU5a2Vo?=
 =?utf-8?B?aEdHRUNHRk1LMWVZOUV2MmNWU1crM1FWM0RWUk9nOGhLYS9zd2Y0NFdXRUVh?=
 =?utf-8?B?MzAycXc1TmgrdEx2RGpXeDkya2h6ZkpYLzlXMFFYNVRiL3pPQXlIZHZuaWxr?=
 =?utf-8?B?TTZPMjQvalFSOGdNZmJpR0pBNW1rS0RQTHJRZTVibjlVb2pZUGd5OEJ2VmhH?=
 =?utf-8?B?TXdWRldOVmppbzV4SzJXQkw1WnNnSE0raTZWcU1yR2R5QXQ3OTVzV0lYdFpN?=
 =?utf-8?B?ejBuWWYwNGVvckZUYUlKOHcvWThGVW9RdWM0UzE4aUdlL09wb3hGSFdhNlFl?=
 =?utf-8?B?MHFtQ0J5M1hqUi9mdS9RbDVlNEFWSUg0V2hlNDdJdUNRZ2h0Z3FUWFI4eldQ?=
 =?utf-8?B?R3NUTjRSb3ROWmJvMVZMaUsrSXh0T3Y2YjA0VS8vcXVJbDExK01aNXZ0eDg3?=
 =?utf-8?B?NkRqdlV5QXZ3K1FDRTE1M3ZKMitNTE5GTnBmQU5oRExBekZ4TDdiSjR6OWRn?=
 =?utf-8?B?S3pzMy9rWHZaVTNrWm4rS0xvVE96NmUzMTVEdnpIcElucWVrS2REcmtIYkpp?=
 =?utf-8?B?Wm9kQ3lOK1FBU3VuNXZ6TUpCeU5rZFRLZHArOERrVHN1VTNhSnp3bWlwVkpt?=
 =?utf-8?B?Yi9SVjFsdm5RbG9tUjZsbldEM1ZXNzNOZTNySC9zcTBYdXlrTVpDUmE2ZEpj?=
 =?utf-8?B?bS9SVmxEMUhFMzhLUU4vMjdwQWFNUWs2cU1vZEdOYndwYmF0U05mQm5rRDQ1?=
 =?utf-8?B?TWIxZXdkWlRqcjJZV1NRby9MbUlTWVFwQ0hIL0IvcjBNTEpTL3pEUFliUkFN?=
 =?utf-8?B?YXdRTXZyZnJXVHlta2tUOTQ1c2xNQVF2UmltYjFGUTd0VllWbTFQd3lXVTBm?=
 =?utf-8?B?d0kwMHR0S2ZRQzNOSVVhelVxYlViU25Zbys2YzBJNTZRWGZvYVhIc2RnU2VL?=
 =?utf-8?B?cVlmS2tkaUJpcXpMenBpaU1QNGdrcW5NZzc0V0tBSktxcnlhaktROFFnRGFY?=
 =?utf-8?B?eTEyTzNhVlhWc25DOWFqZFhKdU05dVVJSURaa28veU92YWRLcUp3clQwMGMv?=
 =?utf-8?B?NlZSa3RIZkhYOUpiMGY3SGJEbWlscTlha1p2cjZnUzBiYjNRVlgwMUlXdFV5?=
 =?utf-8?B?KzFhQXJsZE1mNm81ZkY5M2MrSXVNNitKK3hUYTdzSDhIMzFxNG1wbFcva1hM?=
 =?utf-8?B?bE9kemxzczJ1aTRNbitOUEJWK2xET0lTRkVDWTRvanlDa0JtUHVGSVYzd2lX?=
 =?utf-8?B?cm4xK1BEdXJ4N3FaaEx0V3c3Y1pVNWpxY3ZtRzdJTEI2eWxwWEdXcG9YWWtq?=
 =?utf-8?B?Wm1ZeHhGRU0wVjdoUXE0WWdUMUN0TEtPbUZobkNBSjlvMHd1SzFJTnp4Z2sy?=
 =?utf-8?B?TEtHMzZ1UUw5OWJmRGZhZHFoVVRJMFlaZ2lMMWtVSGhXNW9zdk9qOXJLYWpz?=
 =?utf-8?B?RkJqTGd6WFQ3SFNGb1RkbEtRVlNkMHR1Mllac0tCaW1DZnBGNURPbWJmcDBC?=
 =?utf-8?B?SVBoc2pMUHAyZjNtMmZtcGVTZ1laVWxvb05aZlJLeUd6anE0dVg2TzlQZnhp?=
 =?utf-8?B?ZTl6ajZGQ2RFVDZBZ2tTUGRtMjc3V1YySE85ZzJxd3JGcUhvTjN4N0hWZG9s?=
 =?utf-8?B?a01LR2N4eHEwd2VsdEJNOTRNeWJJN0dyRkFya09kWFdhUnFWcXlCV3RYRjJj?=
 =?utf-8?B?dWs5Sncvd2V4dGdvK3RGUlBMeDhxQjA0OGpyZm9mWks4SDY5UGhBNnR4dGcr?=
 =?utf-8?B?MzZxQkNjemFuUnBicmx0Wm5kVGdYTGZIbzU0VjBWTjdGUXNsT2dzZzR3Y1lq?=
 =?utf-8?Q?7tE30+WEop9RmVZoGrBD5gBzf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2e7a97-449d-42a6-a5ca-08dcb000a379
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:59:56.9525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJrYIIZNOUwcVvUxoMsBWFQwJpleP4KDIFfWEAvLJWG/4E+SCvxl+hiaUaS0Deoelt4kZMSY+Exh9D+B95/POQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

pcsphy-handle already deprecated according to binding fsl,fman-dtsec.yaml.
Add new common pcs-handle at dts and fix below CHECK_DTBS warning.

arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: fman@1a00000: ethernet@e0000: 'pcs-handle' is a dependency of 'pcs-handle-names'
        from schema $id: http://devicetree.org/schemas/net/fsl,fman.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi     | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi     | 4 ++++
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi  | 1 +
 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi  | 1 +
 9 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
index 5c4d7eef8b615..ca7cd7a33c017 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
@@ -29,6 +29,7 @@ enet0: ethernet@e0000 {
 
 	enet1: ethernet@e2000 {
 		pcsphy-handle = <&pcsphy1>, <&qsgmiib_pcs1>;
+		pcs-handle = <&pcsphy1>, <&qsgmiib_pcs1>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
@@ -40,11 +41,13 @@ enet3: ethernet@e6000 {
 
 	enet4: ethernet@e8000 {
 		pcsphy-handle = <&pcsphy4>, <&qsgmiib_pcs2>;
+		pcs-handle = <&pcsphy4>, <&qsgmiib_pcs2>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
 	enet5: ethernet@ea000 {
 		pcsphy-handle = <&pcsphy5>, <&qsgmiib_pcs3>;
+		pcs-handle = <&pcsphy5>, <&qsgmiib_pcs3>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
index 4e33450939436..15ff7c569d288 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
@@ -24,6 +24,7 @@ &fman0 {
 	/* these aliases provide the FMan ports mapping */
 	enet0: ethernet@e0000 {
 		pcsphy-handle = <&qsgmiib_pcs3>;
+		pcs-handle = <&qsgmiib_pcs3>;
 		pcs-handle-names = "qsgmii";
 	};
 
@@ -38,11 +39,13 @@ enet3: ethernet@e6000 {
 
 	enet4: ethernet@e8000 {
 		pcsphy-handle = <&pcsphy4>, <&qsgmiib_pcs1>;
+		pcs-handle = <&pcsphy4>, <&qsgmiib_pcs1>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
 	enet5: ethernet@ea000 {
 		pcsphy-handle = <&pcsphy5>, <&pcsphy5>;
+		pcs-handle = <&pcsphy5>, <&pcsphy5>;
 		pcs-handle-names = "sgmii", "qsgmii";
 	};
 
@@ -51,6 +54,7 @@ enet6: ethernet@f0000 {
 
 	enet7: ethernet@f2000 {
 		pcsphy-handle = <&pcsphy7>, <&qsgmiib_pcs2>, <&pcsphy7>;
+		pcs-handle = <&pcsphy7>, <&qsgmiib_pcs2>, <&pcsphy7>;
 		pcs-handle-names = "sgmii", "qsgmii", "xfi";
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
index 65f7b5a50eb51..1b2b20c6126dc 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
@@ -27,6 +27,7 @@ ethernet@f0000 {
 		reg = <0xf0000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x10 &fman0_tx_0x30>;
 		pcsphy-handle = <&pcsphy6>;
+		pcs-handle = <&pcsphy6>;
 	};
 
 	mdio@f1000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
index 3f70482c98c30..55d78f6f7c6ca 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
@@ -27,6 +27,7 @@ ethernet@f2000 {
 		reg = <0xf2000 0x1000>;
 		fsl,fman-ports = <&fman0_rx_0x11 &fman0_tx_0x31>;
 		pcsphy-handle = <&pcsphy7>;
+		pcs-handle = <&pcsphy7>;
 	};
 
 	mdio@f3000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
index 78841c1f32527..18916a860c2ed 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
@@ -26,6 +26,7 @@ ethernet@e0000 {
 		fsl,fman-ports = <&fman0_rx_0x08 &fman0_tx_0x28>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy0>;
+		pcs-handle = <&pcsphy0>;
 	};
 
 	mdio@e1000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
index 1f43fa6662221..e90af445a293d 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
@@ -26,6 +26,7 @@ ethernet@e2000 {
 		fsl,fman-ports = <&fman0_rx_0x09 &fman0_tx_0x29>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy1>;
+		pcs-handle = <&pcsphy1>;
 	};
 
 	mdio@e3000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
index de0aa017701dd..fec93905bc818 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
@@ -26,6 +26,7 @@ ethernet@e4000 {
 		fsl,fman-ports = <&fman0_rx_0x0a &fman0_tx_0x2a>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy2>;
+		pcs-handle = <&pcsphy2>;
 	};
 
 	mdio@e5000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
index 6904aa5d8e547..2aa953faa62b1 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
@@ -26,6 +26,7 @@ ethernet@e6000 {
 		fsl,fman-ports = <&fman0_rx_0x0b &fman0_tx_0x2b>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy3>;
+		pcs-handle = <&pcsphy3>;
 	};
 
 	mdio@e7000 {
diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
index a3d29d470297e..948e39411415e 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
@@ -26,6 +26,7 @@ ethernet@e8000 {
 		fsl,fman-ports = <&fman0_rx_0x0c &fman0_tx_0x2c>;
 		ptp-timer = <&ptp_timer0>;
 		pcsphy-handle = <&pcsphy4>;
+		pcs-handle = <&pcsphy4>;
 	};
 
 	mdio@e9000 {

-- 
2.34.1


