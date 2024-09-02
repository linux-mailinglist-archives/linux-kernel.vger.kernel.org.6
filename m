Return-Path: <linux-kernel+bounces-311041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE5996843B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3062B25525
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD8185922;
	Mon,  2 Sep 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uCMbSUHW"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05113C9C0;
	Mon,  2 Sep 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271853; cv=fail; b=CKkgnyYb2cEifIJ6jVun2U1ghvGcZrwbaXiS4ehsOaXcFNkMRxgSgA5ELQHzdX8I3VpwFs7NyeaDthoTZHvqn17L4Q9uVnStj5sDCD47ZtBvI/vYhiGX51OLSdPV2OZMEzaVDsSGwlK2RzGmJEYVqSq9gz/flp1LobUl1GUd36I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271853; c=relaxed/simple;
	bh=nvP/Z+rCPMhlTH5S/iqBfLUS2swaGru+WNFCuHfvKuw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kj1D9KHocs0vaLDUleHPq3s4/s+VoDaEReqCHdaIBmi3ycV4DOggR9wBiLsiYI83IGVRpwj6Dh3cHzD52i7Zf+uzGDjK9E2n3JcCEhWjktHlwkva2vckh4kSqsvu8cvj6iowqZKrgCYCOJYxciy9mRbTFS/jRWmBkV/mg5Aq5wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uCMbSUHW; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPRLZiU1GRd9Ta9ZgOaf4M0nNTMxw6nbdsF25K6nvyuL2Zym8Eo2oeb8Irf4SBl8s7e+4xH8DiJX3Oxfd6K5/3rlV5gWhPGDtqzJYImxV4kF1uhplCb5e2OD9vXbPlxLoxDUfguSIc7PpS5wLcK14qWi9g9+O84qgjj2TxJhKwbv086om1UAP/F7RVYJF5xZLTF9z+jnRfXCcTTXRN258WTEtoYbFmePykPUp0e5OqBXpPhDEMDXnm8lrPC6PFK7iiZVtzAZdIIhlPlcbubPwB9oftUTG+wg+UtmCe7FEbz/aynUIxSssl/8Kvh1uYdPFAxU5y3QMhQSrZ+jS79KDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFYdnIftNb6EmSTKPe2WBvrftuWHy+K2KeZBsTQltr4=;
 b=mpSt1J+XvESo5v5gW4Wmv4gUOABigb1yLcTHBK/giHPNdDhDOf5LTVMJyjoNlOOVD7Wmkv2GhKrGy/WU6ge7yueh6Pazp5+A4lYsmnvl/1Uzgb2CbyhOYf7VaGXSMwDwUzbgoRK84YU54rzJlSNHmTwiy/pxLaEkpdnmPVNWSu1ENGMb8cyOVhmAITIBnEhtm7DIkup5qxB4tMImW+UedLkJL/WlXgu0zOxvGAfkwGRgCS9IMLTh5sIsi1ytyeWt4H/jrm8bpHYU+QfC2QVVhYt/mGE2i+xYhU6+Fpb4dtrlMd3R5xf6E4Sa1QRsxrPd/BHSUtjWzf/x56bmoCabZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFYdnIftNb6EmSTKPe2WBvrftuWHy+K2KeZBsTQltr4=;
 b=uCMbSUHWm0hfE8jzpvsq2p+zJ1ByOO5PgxkyZWV9h8Yc7pHVQxr8ljZMVM49nQIFTcCwPFbdppY6+faOTsRakM2m2cvq/bTKrCg5BY90yZXvep6w2iL7Ue/O/v34Z9JPhTaheejyqJfx8gYDBNgSw72LS3EdhXrwDJFMF2e4en9rJt/ZaWE4EpfSJaOeijbasdOEiAb+VwT4STxPlyY4xUg8v3FUXDLiLTm3epuo0DsQy6dS2eWgAyK9/NddGfsSKqA5VtzEf38frAtiuZ46gpSzSQpWCteatAatjjxsheQmuYHpNFcneqKVAabHlC7AAImaquA+Xs9WREN5NQQUHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:10:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:10:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Sep 2024 18:19:26 +0800
Subject: [PATCH 4/7] arm64: dts: freescale: imx95: add anamix temperature
 thermal zone and cooling node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-imx95-dts-new-v1-4-a1f798f4f746@nxp.com>
References: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
In-Reply-To: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272373; l=1453;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=eaohBRB2Fb4PfzYBAS7o5j/hhfFB2BYaokXf8EKWkPE=;
 b=UaIXvy8XGcU+wIN9FB8zwr5h82fuW4JPXPmBgUarinFzwsOLq8WzwJMguutpeaJX1iYj+wp6g
 GBAbVrRwrDIBR1aW+J0/Ax4fe507pCH4rw+Rp9uW/eqIkyglhuX/aA3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 92092129-e17e-4aa4-1c98-08dccb378553
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm9BUy84VWhRdlZGcGJCSUhVVWJCZ2NTUkhveG1uQ0w5ank5ZStXRjB5dkhx?=
 =?utf-8?B?MmFtZUNUSWlSKysxRnpTdGFrRk00TTRHaWZtZUNESHdzZkpIWEE3SWhvYUJI?=
 =?utf-8?B?bHArbEc5S1NEeWhkaHdlRjJ0bVVqQks0cUEybmg5UDEvUWN3RlFUa0J3YmtT?=
 =?utf-8?B?WlN1bE1HamU4d1h5M2FhTGF3N0k1UlJjQWttUmpEcUNuZjlGbmpUZFhiRzI2?=
 =?utf-8?B?cWdTNWkvaG1JK1lZNy9mV09wNUFHV20xS00yZGVkem44SlN2QTNnWHNMU1N1?=
 =?utf-8?B?ekRjMldjdDlsZktYTUxOYTEyQTRZWUhpK0JEUDU2Mlh2QWppU0xFTzdFQjYy?=
 =?utf-8?B?NTZDeVRKWUlFNW54ZXZZaSsyK0RPRkFxKzY4VjZNMmZZTWNHbGxuRGNMdk9R?=
 =?utf-8?B?Wm9HMmVsL3hkUnZMaHpTL0FSVHkrUW9ZTWd1RGxGN01qY3Boa3E2WjhPNTRw?=
 =?utf-8?B?Tzg0TUlQRER1UksyY05KSE9OaHJQTittQ2EwbFNuazgrbWYzZHVDUVhBQXFR?=
 =?utf-8?B?R1BzSExlb2NwRkNPZUxrYUJLTFljRmxRRk15b2xhOEhFa3ZaeEdkWUhoV2RZ?=
 =?utf-8?B?MHNJZDBpbWJraHdzVG9sUElicGpFWDZWRCtlM1lIUjRkM09QRURBUWl4NW90?=
 =?utf-8?B?bU40QkFrbldsRyt0Y0QvTThnV0taRE10MTl0SVdjcGpqY1M0TWlYQ0VtdHA5?=
 =?utf-8?B?UGsxaWtuK1hvcGJXWWE5WUk3QkJHWFM4bHhzQ1BJM2t5NkJUdm5tME9idS9S?=
 =?utf-8?B?dXZtb1l2ajA0YXlnYVZRSGNuMGw3c0w0NkJ0U005SHVBYzdSYmJMaFp4QWN3?=
 =?utf-8?B?WWtHQ1R0ZDBkbG9YQlRyZXJneXpxNDlnYW1QOVpCR09TazAvTzFUNjlZN05i?=
 =?utf-8?B?RlkzaDRuWktrSllYdmdTeEVzTlFWdldCcktzVm1uNXdGYS9uY1drcy9rZ2Zm?=
 =?utf-8?B?SUdUUERZOXEyS3JBZG5RVkxqTVdyK0Nma1NrVDhJa3ZxaEs5Q295U2tUZkc2?=
 =?utf-8?B?bzZaQVdYTEtXbHByTTNqaHJMK1kybVdqNHRkOFpiZHR1Y0psMUl0UkgxdjlT?=
 =?utf-8?B?RENiM1Vha2dqR2hHb2FOWmF1Q3h5RS9kSEcwcnZBNTlWUitubWRNT0hwVjZy?=
 =?utf-8?B?Ump4VEw4ZDljSm1DMUpzMWhDZk95REtRUDVrdzRxTy9idVBxUjMwUDZ1c3Ey?=
 =?utf-8?B?UVg0NWRXNThFaGYybHJpOUVDY1FrNXZIeTBhNXJ0MFBwU2ZTakpQZ2hqakdu?=
 =?utf-8?B?eWppU3Zja1JYR25aUGJFQ1NYakJkc1J1SE1pWS9XejRLZ1hYa0U3KzFPQTNV?=
 =?utf-8?B?ZTFxWDVVTXp0bDBGM1dNUDk5T0FtY2lnVEYwUE1MUmlFdW9KM1hmdkY3Q2hT?=
 =?utf-8?B?T2FyOTlwOUlKSG5PZy9IalRrTklJT3k3SUwvL0V6S0szQWpPQjFLQ0hLbFQ2?=
 =?utf-8?B?NldhdTVINW5YWHA4elVZQXMyM0Q1djhoTkFVdCtYS0szNEdpTmdzbHdhZkpH?=
 =?utf-8?B?TkJ6NVd6NnR2eFNpRjloTHlXSGp3c2xCMTFac3lVTDN3Z3JqNVpxT0pxL0E5?=
 =?utf-8?B?dzJieU5qbUxPTkRYL2VCaXZBRTVUMWpFZlV4ZitwNmRNSjJTMkpDQlF5d1Br?=
 =?utf-8?B?Y1dBdHQ5bWxxNUwxVWExNGRmRG5hQVlDQ2xzNURsMllQTEVOWTlRKzczaEtz?=
 =?utf-8?B?MldZK0JFZEQyQnhPbjJiOGJOay9zNGNnRHpyUFRyRndER0RnUnBQNEFKZmJI?=
 =?utf-8?B?dUh2Qi9LWlM1ZWhHVXp5THNuc1VqOUp5eFJWUEx2ZVJ2OTcwM2xKVXAvMnJR?=
 =?utf-8?B?eitGeHhEajN0b3NBSFcxRHhnbmJOMGdjTE81Zi9tQ2FjUWphSC95V2k1dWla?=
 =?utf-8?B?QjdROGhEREVIcFVYNHQ2REtGSmpZQnNhc1NWbXFqdFFZeFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlJxWkhzeGlkSEtGUmNxRWo4YmJ6ZUhxQTh0OXR2OUwzWnJWWGFkU0p1Y0FY?=
 =?utf-8?B?c1plYmNJQ1dDRm1xS1c2UE5TY08rWGpoeW9Ienk3cG1nZ2o3VUxzS0F6K2dh?=
 =?utf-8?B?dm5ZMmYvRVVBcXBTalREcGl0NVFnbTdUWmxkcVdZWGpDdFE1SXg0R2R3Y0d0?=
 =?utf-8?B?TzB0ektsZVBaZDBSdlZhbUF0VndjOUlZRHRpaGhZbHExcUlqSG9NMThaUzBh?=
 =?utf-8?B?LzBjRmFYV2Ewam5iUGlXYTE4L2RjSkJNeFIxWjhYVldXa1pSdkprbWpxSm4y?=
 =?utf-8?B?VVpmR3prZmg5SDFQSjRGaXljSzBlMnp3UU5rdTNub0xDazcrZXZGSkdleU5Q?=
 =?utf-8?B?WE5HRXZ2MkFsQU5hdzJpQStINnJkamh6dTlXRFo0bC9xdnN3S1Uvd3IxUW5u?=
 =?utf-8?B?NWFTNkxpcE5YOVBUTXFONWJ3QnkzcnlBNzEydTdQNGw4d3NseUlTNGRyMzNr?=
 =?utf-8?B?TWYvTm1tQUxWVjlXTDJBQUlwRWRWdlRRTncxYzhLRmw0WVNlYllST0tKd05P?=
 =?utf-8?B?Y1hmUVpaME9RK3d6aDZ0c050WWdQekhxb2t5NUhUVWs4amM3V2ZHOTBTT3Jq?=
 =?utf-8?B?NVZUSWFib1FMY0xSblEydFNXbmJLTTBkVzRNVXI0dUxzZERLMXdCL0lraSsy?=
 =?utf-8?B?OWo1L0N0YWUzb2ZiZ3M1VG1ub21MTWJlOXJzNWRlK1RRVTMzK3FRN0NtQ3pT?=
 =?utf-8?B?QS9pdG1PcXpzRmpwNmpWYWoxR3hOc1NBY0l6c3BJN0RrWVNWNXNqbFpXS2Yy?=
 =?utf-8?B?UEZaRUtFd1FJZkdRemh2blFOTjVweW1nQXFBNzBUSG40enNLUm5hQjBjNi9P?=
 =?utf-8?B?ZEYxNWZSOThvY0dack0zV25DR29QQnJlVmdhUTE1Z3dtK0FEWUJCSndLeGxr?=
 =?utf-8?B?dVVMdnJFLzBIRjc4UFpUdnhGQTVnVDFBWTNwYXJOZTdaSHpjaTJINlVyakVv?=
 =?utf-8?B?dGQ2VnUwM0VVbjhjaFF5b0V3eDQvNmJrT01VMExBZ080YktHS1FWQmN2aFdO?=
 =?utf-8?B?dSswUVh0bWhtMjIrdTlxK2xTazdqRDd4LzRWNEorenR5OC9CWmNWTUZEb245?=
 =?utf-8?B?dmxOUW5HWVhDQ3h6eHAwMkxlbmZwdEpYWjlnS21kblcvVWJMOTVwcHlOc3B1?=
 =?utf-8?B?TWRseU5Va2hGQWNYVFM5RTB4eEI3TndXUkVWSHc5WVlBb0g4ZlRqbTNaN2tE?=
 =?utf-8?B?NVFKeTc1cUUvUEEzVHM1SVlvcUhFRGczbzByLzJYU0RNdXFPM1QwYXhsOEVK?=
 =?utf-8?B?MWpjQkx4OXUxNVdwd2pSdVowWXprNDVRZnRtVzdyRGpHL3VVOHZ5bHFoS05y?=
 =?utf-8?B?Wmx1TDlrZWEvYTdtN2U2STBhcGVlTlhXZVlTdy90V3ZGWFh0OFpaQ3dPSEo2?=
 =?utf-8?B?Uzk1VDBtREtSYWpxM1ZnY3FFSVBkM1hwT28rZlJNZEdMdHUyS3p4UlpWZ2pQ?=
 =?utf-8?B?akpjeXZSajV5bzFsS3JTQ1hkdEo4US9tZEthbC8yUGFqa2NOMTFFdGNiZDRj?=
 =?utf-8?B?c29CSDBFb0hxMm5hd2ZJZ2xack1jWDVjdy9xenpZeVdIajZjUEJCKzFJM2tp?=
 =?utf-8?B?TVVKaW1pZ1d4R2llMXl5b3JKdUFzVzJOOUs2Uk1BbnNsWE9zdENZQkxnMDZi?=
 =?utf-8?B?d01TSlZoeEkvVXhmVzRYSzdoVjA4VjBPai8waHltNS9yWWluMDhCTE9ucDJp?=
 =?utf-8?B?YkgzVXpDVUVNOXZpUHJocm1rUWY4VW5QVlo1RE9LZHI2TTdveTJqSlh6U3JF?=
 =?utf-8?B?RzVNY0tCam1iTmVnMEt0M0hpZ3ZQZWc2RXA1NW8yelBqalJWck5FejAvK3NL?=
 =?utf-8?B?WFRpK01XMmlQN1FUZ0dQZWczU3IydEhBeXlXVmlSMkZNTWUxSnRuTklBYW5w?=
 =?utf-8?B?MkRNOWlTY2tPT0QvNnhtQnc4WW5YUW8vYVdWZEhoVktZN1lJWnBvYUE5Q1RI?=
 =?utf-8?B?dXZHWHE4UjExWTNQeW1BNE9nOUlibFV6YmJxaGlSRWJQOVVaQ2RhMVlyVVJR?=
 =?utf-8?B?T21ab0FWNHlxa2ljWDk3VFhTZTRWNUpES2tNM2thZ2VFTEc1b1pMMUJwTDdo?=
 =?utf-8?B?MU9iRnBNUVU5VGJhQkY0VjE0TUdqbXZZSnBVNGNzZ20rNW9UM3Vpd2ZJcVhI?=
 =?utf-8?Q?ckyH7nl/GjdJWqGQSJ8aZhdrQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92092129-e17e-4aa4-1c98-08dccb378553
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:10:50.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRXzfGQA2Zzr7yaLEATsAdvUHXPzp7HksZMXSNolDxmwbW91tvbuBoIXM83mJWlM2UkLvEwJHe8pIiM+0+QzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099

From: Peng Fan <peng.fan@nxp.com>

i.MX95 has two on-chip temperature sensors, one is inside anamix block.
This is to add the anamix temperature thermal zone and its cooling
device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 2cba7a889030..d031b9548aaf 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -372,6 +372,38 @@ map0 {
 				};
 			};
 		};
+
+		ana-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&scmi_sensor 0>;
+			trips {
+				ana_alert: trip0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				ana_crit0: trip1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&ana_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
 	};
 
 	psci {

-- 
2.37.1


