Return-Path: <linux-kernel+bounces-266304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106FF93FDED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE7B22DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0C188CBE;
	Mon, 29 Jul 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdNMxnWi"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37525187848;
	Mon, 29 Jul 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279599; cv=fail; b=pj7lnKFhqAm/Pmowrayc7bGxrXW1TW4B2+DjtL4InWFRy+bDZp5Qsrqo3ALV85MLGcDXtDS73NshYEhctSexfjxqfq7XuxwmlE8QMoYlDXyUMxAw8yzrR1m1dQ1deovyuHy6kGtGwSoEyZyh5DLXST2AzObuLSCAFmSFwj4/euY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279599; c=relaxed/simple;
	bh=ywaotsSC4Tvp+5zjmChty/XuyHkh8NltdyiOv5uzS70=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YrB+vc3prLRHtj8FC5mdn7Sxa83glwaUlXGN/BLldSPkNbXbF+Sqeyj4NnAeDC/ZwqxvYXkRLm7ruSfxw88nJfxT8VVKBk0aPSoYo/lkotUKTaQG2I6f+UvVpfnIsuUJkpN0hqZvWr9MDXT4zm7sGrNjDf6lvjPs78SPKwr5JSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TdNMxnWi; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9XFqIUPlE6tS36sF2vZZx0wI3E4GAyd81+ZxIMmI1geSdl0H9eDPvZzuCfTpfjnmCRvsxf8gHhtyNhWMG5epZ9SXcqi0UYtGCwrZYR/+7rsFcDrW4DceT+6r8MBIgXsL1D5vuwoNy5dz/j0p2ldDXozx/xUvm8NGQEH7HB6uTQ1rVoyTCOK2Jy+ce50TEXy4V8xz2EDeT9DA2teazkGrrwMXkJa8IGPR0QK/aJIAqZ+TR0/hpTetVmCbtDIkYZKit50O42ayLiNblVTFtCvxrbuPMJmkJlGWRMOqB1S64WnGPO9SU70fd+iKXaroiwH7GxYuplDdQjrClaW9iY4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm02Jc2y97vkeU25g/cBKjMnqHrvWeKxhBrM7cEO3mA=;
 b=Gm64MANQwKP1xhmJzCK3OGEWoz/OgPdmsGIpFVUPM82cpwV1tWI1tpdzpJ2G2KjgzgyvA+Z6ingf9xc7VvWpoj9oKiOF5u4PXUq+Ln7NBFelmMJz3b70OifM/WTwruPPw3huZBFbPagCVJVVnG4oV/+SEPG0DmT0JuHJdchKVge+qmXC27SyDnRpmHhKIXIBCOrZsZ2qF0N1y/So0/SNocKUX9q5YpER77uv7oz9KaajKUPL096UvCn3Y1Qv9zZuEjk5J//3V6GyWclxhKU6oKOkzCALqyrxMKNY1+7wx8w0D6LjageLDX5vdI0RpoKgWwpUcsd4gh62FvpG7njP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm02Jc2y97vkeU25g/cBKjMnqHrvWeKxhBrM7cEO3mA=;
 b=TdNMxnWiMSuAD3bC0la5prSNuZ1W7QtptINQgRLwvpTpYPKlxsgNk3IUUsne2hsv+95gD8ZqWDJHH2HvN8D+Y6NO1fqLO1GZ2RloS20MKrylUsUtsUmPXRIReE/u+f4TGlGg0uX67hzrIV48wO18qSSysAdu3M2LQY/Vfs9xs3EaH+M1Z/HRGqvG9y3pk9VuMtJZxCvHLtajOXJgReGkKRAShv8aWB7nYF9+WwJ4jNFXNcPLbT7Xf5lgyfTVG5sPQvrIpjsopDSllzlIWYZfgkXj52Fo3J5vnQ8CoC4akaOjSOY3WpDpxb1B7slN/icFvb/sCsAnMn1K82cylbm7IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6939.eurprd04.prod.outlook.com (2603:10a6:10:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 18:59:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:59:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Jul 2024 14:59:24 -0400
Subject: [PATCH v2 02/10] arm64: dts: layerscape: rename rcpm as
 wakeup-control from power-control
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-ls_warning_all-v2-2-942d80ddd441@nxp.com>
References: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
In-Reply-To: <20240729-ls_warning_all-v2-0-942d80ddd441@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722279587; l=4708;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ywaotsSC4Tvp+5zjmChty/XuyHkh8NltdyiOv5uzS70=;
 b=rMtzriLi08C2GQ41t2J6MYYsNUPyYnOqlqUOZF+TAR6ZvXPGOwSmEBX9X5GibVjeOHK8akvQO
 r9ETCFoYoF9DmwQGyT2uhpcFjtkuwBwFGojgYe85+csqSGe+b96debQ
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
X-MS-Office365-Filtering-Correlation-Id: 42458a2a-e391-465f-b4fb-08dcb000a20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzVXZ1JRWjdJQjk3bGJWaDVaQUx0L0p1KzR1dHdXU05xNTRwdU1NNG1OYWJt?=
 =?utf-8?B?azJFdkdPMHNZWGZwejM0ZW1MOHdyZFh0b2FNdXo0T1B0UzdHZ1Q1UlpBMi80?=
 =?utf-8?B?SGxGS2UzTUJWSnFFWGQzd3VYbHRVbzNqNWZrcm5SRTFQWmlqWDl2L09BWkYv?=
 =?utf-8?B?ZFhMaW1LTkNhN0ZWL29qc29PbkFRV1dMZGhxMmhqL0Rvem96TmdRM0gwdkVP?=
 =?utf-8?B?UUw2aDVYUlBheVhjOVZOcW5tUHdtV0V4dExvN1hBaWNVOWg3MnpsUitPb05z?=
 =?utf-8?B?dlBjaWVzNGZVazBEZ2Q0bDI1b2szVTNLdDVBREltMEdPMzJNMm1mUGlTTWkw?=
 =?utf-8?B?T3MvanZ0em9CQ3ZvaitJVEVIbkF6Um8wZEVaWEM1VWRqUHc1b2ZIMFF1WVFr?=
 =?utf-8?B?S2xqbEFHWUlkVmhtcytQN3VhNDlnODQyTVU0TmVjTnZvWWt4TlNJbDErQ2g3?=
 =?utf-8?B?YWZSOHFlczN0cHF6ZVpERTNJR0lGRUxxZ1R3TDJtanYwdzUzVm5ycDhIL2Nj?=
 =?utf-8?B?T1RnNFZpSytSOE5JRkYwbGVmVytGcy9sNVhEaXVkQW9Balc3T1hFRTcwNVAv?=
 =?utf-8?B?SFAzaVYvOStjV0Zxc3YzVE1HS1NRbHVrTzdqTzBIbnNrUmZHY3FIMUEyS2Mv?=
 =?utf-8?B?REpkZHZHYk9hNDFEakl2dW4rSWgwdjV0WThlZWpYNFpSVjdHbGlqVjJUT2Q5?=
 =?utf-8?B?V1JHSDZrbEhTQURoR0QzM1QyNmlXODY2Um1GYXpBbm1rZ3lyTUZXZEwySklt?=
 =?utf-8?B?SzNxRkJGOTNUVy9TOFhRU0tzRHpLN2FRZVlkSG1nK2Yvai85L0dSaUZFRXdV?=
 =?utf-8?B?WitwL0RBcnNHRVNDZ3NQQ2hWaFRrdERBQWVCUk5TcmR6elVpNERKL0RXMnd3?=
 =?utf-8?B?aGx2Q3RvdTNJQUNkb05WN3dYL1c5bVRKb3NUenAxY2ZUNFpiQ21hNTlVOXRE?=
 =?utf-8?B?TU4vendTOCtmUzMrdnBuSm5IbU1RSnIveTZPQzdCWmhkbXcvSlJ6MklnMzZU?=
 =?utf-8?B?Yi9MWkFpc1IrTzVxaHc2QUdVSXBYc204Sm1td2VLelJhUldKY1hucDJmQ0Vz?=
 =?utf-8?B?eTZTZ3FxdmxsWFc2Zk1VRGJZQjdydGMzVDQyVU9PdHN1TDdUaExCOWdXbmdV?=
 =?utf-8?B?KzdxY05tMjBza2FjbTliWmJ5QVh4V0c5cDMyK1pwdnNFTkI5OE1XTDBweGVk?=
 =?utf-8?B?SjJQU2kwb25tRHJ0cEl5QjRGU0Q1aFJqM2huLytIelJFRmlIbHd4bi8waFVh?=
 =?utf-8?B?QUxnaFFiZVVRWTlwRFFUV3NTWW1Kck8veVV1MmlhWlFLZlBjem1CdVNBRGFx?=
 =?utf-8?B?NlVGUituMVRqbmdjRW1aVWRjUU5EemtFT3owdzRDYnRvUzNxNFNYbDJuNWVY?=
 =?utf-8?B?cStKZXUzMTE5TlRSN2VrTWY3SHdhaVoweDRjb2NkMkJYWElta2gxS05vdnh4?=
 =?utf-8?B?dENwZy9RNmJUNlArNDZiS0pxV1lVK3JiRUw3d0MrdlN6S2tTbzlHTUJwMnd2?=
 =?utf-8?B?VUw0TWZTdHNmK0tLbEprTThSUGJPWm0xVEh0VUxhS1krYVVaWE5XNUtIdGVT?=
 =?utf-8?B?R1J4OExFdzhKcURRTEFlRVpwZG8vemhDTFJBYWhXMFdiSHg4bjRHRFcrdXNt?=
 =?utf-8?B?aWV0OTNrbzV5ZVVTTU9iQXBKNjJjeG9wWTYzWng2TlhwT2lMdHNsU2IzdmlM?=
 =?utf-8?B?bFdDakNqKytRdWRKM3FxMVpsVXZHcDNLaWpwK0h6U3B3NTN2Sm5GbVdXSHZa?=
 =?utf-8?B?RjJPbTFVUWtEZEx0K1RzcVhVZ1p4T2xDYkFBNzlKTHM1NC9BOGJ4REluNXFN?=
 =?utf-8?Q?m0pf6nUd+uqXMJzTBrgj7Js+U6aWrR96/UAr0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUd2QzVPbjJhM1Z3WkRLejBvb28zVkU0eG5OQm9WdklvVkdQU1JnRXZKOGds?=
 =?utf-8?B?SC9RdFpzbXZtRzZCbGNIVXBZRGNaQzBuMndUejJNdFc4bmR5ck5ibnZHdE9H?=
 =?utf-8?B?dUZqY2dRNSt2OXdKNm9BQ3daWmpkRHFSZnFsd0xJa2hjZTRHOG9oRFVEU3Zr?=
 =?utf-8?B?TEJYd1RPSWxLODBzQU82V2dXRGpOcDFiMk1JVzZqQ1V1akVVOG93WTc1aWMv?=
 =?utf-8?B?cEVVRkZMbWcxK3hBeFVuWldmSVpkWTlJdkpaamh1MHhUVUF1Y0tUM3cxVHUx?=
 =?utf-8?B?ZUVpRUx2bkN4Tnh6RUd1NWdZMGovTnM2aWJ1eTdKSEJPaGtoY21XMVg5TlAr?=
 =?utf-8?B?aHRoVkxmRlk3c0tVcWp1QmFUVHpsSGRKOC9QTVQxREhtL3BTWWRBUWJKa3gy?=
 =?utf-8?B?YWd0NHJnOURMeDhIQlJPSkJNQkEwVEtQbWdiMDVzTEs4VExwVFlwOXRaSnQ1?=
 =?utf-8?B?ZDRoTTFXajNxOE5LeFhiNjF1Z1Z0aFQvNzlvY2YvTzQ3ajhlN2hVOGFDUEJP?=
 =?utf-8?B?Q1B0dFdJSG9RcitnZW9uODRyNWVacGdkWWV5QTlyb2hSN25aWXBtWUdsTjVE?=
 =?utf-8?B?WE94U0Z0enJZVTF4dFltOWlXelBPQmpaTUlqRTFlWUJjOVdubXI2MmlIckxP?=
 =?utf-8?B?TlEyMHY4Y2lMMWhWdlFJS1VieGdpSTlvaXd3UHZPb3V0RW1DL2p6T0pVV0FK?=
 =?utf-8?B?TmVEUjVkRGJPa0RuRVVOU2VOdkE1MC9EVTh1RFNyR1lacm8wdzhGaHVSWnhM?=
 =?utf-8?B?Yk9samNPbG9TM0l3UXVBWVFEUUplMzhSck41dkZwQ25kbEpsZlh1alF6UE1U?=
 =?utf-8?B?SHRxczFjZ3o4RTkwWWkzQ3RrQVNQUzZzSGJ0YkxBNDhtd0hZdnZLUnRIaHlz?=
 =?utf-8?B?RUZSclpaSDVOeWdBcHZhOGNMU2pKaURiUmV0WWtOQWErMi9IbSthblR1b2hs?=
 =?utf-8?B?eUh0eno3dW5zUFMvd2ZBaG1vOG9KNEd1UlhIQW9TOHVMdGxzMDJVVjB2eVlr?=
 =?utf-8?B?TnFKb1JicldkUXNQUE5scFh4OEozV1o2cmZPSFFsVWdaMkpJZlVDMW8xTjEr?=
 =?utf-8?B?Sm9ZQlBxOTFnMkpUQ0lkZzJiYWgwYnRxMlBLMzlXUHJYdVplRUlvVi92ZE53?=
 =?utf-8?B?VTBsb3ZYbjNZZ0dMbStRcllYV0NoWS96enpYRldoOVhjVGhRcysvdnJwMDk0?=
 =?utf-8?B?L0tCd2tUVnorbDY3MmtGeWFOTWVKQldjQ1Y4c2hxcVk0L0FIc3pTelAyMXJi?=
 =?utf-8?B?QnZSdkFLM21QZXNHWHlTK2ZUeE8ya2oxaXNEUHQvQXpMUFhoNjRMN05FcWFn?=
 =?utf-8?B?YnBFa0l6MXVMcStQUmFxKzJ0WTNKWVNBUWdlWG1TUzhXMTR5ZkVSd0s1ekRE?=
 =?utf-8?B?NUJlRkpZK1NoS2hZZE5QK0FtVDJhaUZxR0VDdGJ5amtjK1h0Z0V2djJkUGo5?=
 =?utf-8?B?S2YrSUJPYlBwNUkzSG0zamtrcFBkWkJ1Q01xVlZaSEdVMmU5ZGthVTM3eHpJ?=
 =?utf-8?B?MjJmRUxiNjhhTjczc2RsallmUmJ5ODBVV29ocXc3dXEvR2ZWcEZiNzFOZGpG?=
 =?utf-8?B?L0YxZXNQYVpPTkJmUWhJOXpXTVQrTFg5dWtML25oTjl6VmhFOWt1L05LZUZZ?=
 =?utf-8?B?K09hQUtjQWdObzE0bjZSemtNN2d4akljTWhkNkE2cWY4N2xUNEJ3OElXaC9N?=
 =?utf-8?B?cTJSQSt5dll3NzhnbEw5ZWRFcXB4OCtoZUtZNGROK3BydjVvSCszOHdyQVVP?=
 =?utf-8?B?YWRRMVVJYWJvODJaaUJsaGttbXlqWWxib3hkckdPYVNySFBCbHFuemZOOVla?=
 =?utf-8?B?d2xrS2lzQ3NUYjJTOFFteGlHMElMNk1PQWxGN2ZzdTVGSWdCTUh0MWl0Rm5R?=
 =?utf-8?B?eTZsNUNVVlgrSko5VDJEcFJySHJzVDMxREVEVVUxZTRTaFVmYXl3S3lRSzFK?=
 =?utf-8?B?a3JhY3JFVFI0dWRlL1RkNERuS2JZbkpNYS90N3NjWFdBaUtDdWowekdtYzF6?=
 =?utf-8?B?Uy9iQ1B5Uk5IT2UvdzlueXhMZTZqaVVJbGlHVjYxa2Z4eFp2U25XK1pIbDV0?=
 =?utf-8?B?QUxxT21GYlRmVlRFaldlVmhRTDBLcmlPYzBvSS9NS0haZHc2WDQrc1BDYW5h?=
 =?utf-8?Q?nClBMXxzG44Acg8IR5u+3RTD4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42458a2a-e391-465f-b4fb-08dcb000a20a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:59:54.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+hSAwnvH2CHZSoN4gBN93egph/XdOtqpH1LGBdC2niPFqQh8TcbnxetOQP11pebAFVdc+MZlCA91HlyTHLg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6939

Invoke power-domain.yaml if node name as 'power-control'.

Rcpm actually are not power domain controller. It just control wakeup
capability. So rename it as wakeup-control. Fix below CHECK_DTBS warning.

power-controller@1ee2140: '#power-domain-cells' is a required property
        from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index e61ea7e0737e4..dfd245b326a0d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -556,7 +556,7 @@ pcie1: pcie@3400000 {
 			status = "disabled";
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1012a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
 			#fsl,rcpm-wakeup-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 6b6e3ee950e53..24e86abe88ea1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1319,7 +1319,7 @@ pwm7: pwm@2870000 {
 			status = "disabled";
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
 			#fsl,rcpm-wakeup-cells = <7>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index b19a024525cbc..c176d36f68437 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -983,7 +983,7 @@ qdma: dma-controller@8380000 {
 			big-endian;
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1043a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
 			#fsl,rcpm-wakeup-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 6e244dc4832d1..baf9cb90ba8e7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -935,7 +935,7 @@ qdma: dma-controller@8380000 {
 			big-endian;
 		};
 
-		rcpm: power-controller@1ee2140 {
+		rcpm: wakeup-controller@1ee2140 {
 			compatible = "fsl,ls1046a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
 			#fsl,rcpm-wakeup-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8ce4b6aae79d4..c980f4c5dcfdc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -1033,7 +1033,7 @@ dpmac10: ethernet@a {
 			};
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,ls1088a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
 			#fsl,rcpm-wakeup-cells = <6>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index bde89de2576e1..8691117ffcf76 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1218,7 +1218,7 @@ ccn@4000000 {
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,ls208xa-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
 			#fsl,rcpm-wakeup-cells = <6>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 26c7ca31e22e7..73ee45acfde13 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1078,7 +1078,7 @@ watchdog@23a0000 {
 			timeout-sec = <30>;
 		};
 
-		rcpm: power-controller@1e34040 {
+		rcpm: wakeup-controller@1e34040 {
 			compatible = "fsl,lx2160a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
 			#fsl,rcpm-wakeup-cells = <7>;

-- 
2.34.1


