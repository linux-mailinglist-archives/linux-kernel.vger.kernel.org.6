Return-Path: <linux-kernel+bounces-274948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FD947EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3FF286A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AEF15B11E;
	Mon,  5 Aug 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="daBqsYqj"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941D159217;
	Mon,  5 Aug 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873018; cv=fail; b=FadXMK8w8NPYRnboOLBqZwEftMGFNDJWaOYp9xyLlOQIfTPR0LBYHU0qe/eNCnTKksk1oXmhmrzUlTNIYevMNuEMZBSXTMM1lNj8nwb0QiY57m5xPqwHbFVq+3wEdl87/A9c8ADJDRyi8ug6UzN93xnh9zeob2Q0kTeMs55zEpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873018; c=relaxed/simple;
	bh=ZloRzHovFLhaYe4JbJM6ZisczbRUevP28M4xT45igj8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=DVJlSVn0HTfXvI90HXAp1JUeQvFM96kLPzkKqMpieT2bjxnlEjlr/hJKikFXDgzGwFs1nR+0kK2PGvsM+5oZo6LeQP/i9RLPyBH+wxtwR0/zg61G8LfhzZ0kOqRTDIs0+oobechHj58G9f9vZ85Mnn6xVFrJ3YxnqMqOLEza80E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=daBqsYqj; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTef5kwh1sV3ayqq0UgAwCXlF6ALNDm20sgM+gehlycrFrot2pkDw+r+ludHWRfzBctpMWJ31LPkt0BRMxcSkiky9wpbzsAKhr3CVi5253R/TUGz7IWrd+iiigHWlfOyFNkp166MG0A7XLrqXYOzOwzxpXCGnWarGvqTEjF1H4jHT/pbZIRVSHZT6qW0vFY2T/cSHu8SHoCE0pCQk+YdihozsX/bcwy/s4jeAcDGfwn1P0a8ppXCO7njwF2ypiSe6KzZbwkoeBFXxBtXlhDXBsX2gXl0vXlsIQSD5f8YruKUb/Bg9ATA8gCWWYV3KjqC8xQrxt9lIamwsxEj+EcIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25fOjOt53fwERiQ9pdXik3L5EyAFhyw0A6UXcvTBj3o=;
 b=pWc6FRY6KKSeRRrZbIGLBxSZvzaC7Ylsvf6TcHHSLSyj/uYqaZlTn7MmIjBz82spN7DhVDoE4UQJoVYovTAHpL/dEUsrSM+kE8QrIWJWkW0DCyuNbLTJ+7bEFHxYIjKwKrNM7Lc+cPlT30Qayrd+Q1Fy/YGKYU9VrRng1u5TMCb9ug3Begh3DgSbbvY8Y6VWsBD1Z5ADDTG8HJrXvywpdq/1mp+GtwZ82o18BTtS+vHkLEbEwK9HHMVUevseKo6xuacQGgIT8hoCuncbLvtrS3e8SjLRSeaL4jpjJbq6lMz0Xal2xUWDP+MYUDO26zIuyH2KF0q+zZXj06XgWHP0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25fOjOt53fwERiQ9pdXik3L5EyAFhyw0A6UXcvTBj3o=;
 b=daBqsYqjx74N/mmnthemV1QkG9wdgUC+ETxhstqAuXd2a9862PrPjkX6xcw4Glh72Z+Ez7AQdqDGdqmgNUUgweytbQb5p73AhuXY8qMbD/K9cgKSiWBNXTwjffhnzTOlOL/sRLp/2treqgqJVxCwPS2mbUSigAK5bLCuRHmLI2VSriqS+PNhZIvqFPJLiM9AEoc460iwdwfigG9gkzM/5MG00NP5MmKCMU/S7vIoiAREzzUXVlfpWvI3FB9XTkcJprm5SX04PEoZRxmvf9fo69otoYHpuOD5Bnj8phTkHhnPyO6lRqvDSYV8ZOUtWxE6Jfiz4pk4jYP60eDHzrq/eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10464.eurprd04.prod.outlook.com (2603:10a6:800:218::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:50:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:50:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/9] arm64: dts: freescale: 2nrd clean up dtb warning under
 freescale
Date: Mon, 05 Aug 2024 11:49:42 -0400
Message-Id: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJb0sGYC/x3MSwqAMAwA0auUrC3Uovi5iogEGzUgURpRQby7x
 eVbzDygFJkUWvNApJOVN0nIMwPjgjKT5ZAM3vnC1a60k65DOHS4MArLbGtCl+OIVRMCpGqPNPH
 9H7v+fT9NHauFYQAAAA==
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722873010; l=2032;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZloRzHovFLhaYe4JbJM6ZisczbRUevP28M4xT45igj8=;
 b=RBxmfXQvRmYe0Oa9SyH5jaOLeBflZ4JIhwoX/QMwWX+FGUkwvLLwiUfJ4S6biUt2UYcuaqRvR
 Evi6RTp0VzpBP5ewZXSLgF9uHgCUoCVjf4zIypwkUTwfYwB7RrUxtMJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10464:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c9d169-8650-457c-b084-08dcb5664b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFZOZG41djd0VWppS3BNeHFXaDUzQnhtd09yN3p1LzM3ZllXOTRBVkh6YWRR?=
 =?utf-8?B?Tk1sRWxKd0xrU0lvT3Z3ZWp0Ri8zMTdpSlNVWWlFWEJiNmdPK1l2VHJWZG1k?=
 =?utf-8?B?THpMSWR1UVRDMi9JVXNUV01wUllKSlpvL3BxNGNSRENoVUUzNUlsZzdEQ3h6?=
 =?utf-8?B?ZEMvMUJZY3B4WnV0dXl6OTgvcDhUUzRhN2VNOXlPN1pUK1ZQSGlxOW9oaEJn?=
 =?utf-8?B?OGliRHZjb2ZJRHlZUUgra2NIQ1ZWUCtYcFBnMktHQnJjWEhZUGZUQzJrKzdm?=
 =?utf-8?B?d04vNnFqU3hNQnIwNlp0UDFZSUVSM1BKdmk3NUVzOE1YcTA2alBjNGd3aThv?=
 =?utf-8?B?WDQ1cldlWVNiS0V2K1Nxc2ZVR0g5OWpqb3JVTjJSSHVUNzZESFBjc0hLeENr?=
 =?utf-8?B?ZjBSZ3pKb0o1RFkvZFQrWDFpVGpCZ1NVb2RpdmRlMW9USW1rV2ZnRzJwd3M0?=
 =?utf-8?B?Sm5KYkxPUTRRSVJoZERBUno4MkNzdjNmSk1DM0hxdzd1U2o5MEhnMTBWQklM?=
 =?utf-8?B?S25tblJVTWpDd05MSG9IdjFtOEtsT3E5bDVHRVVwTFU4c1RpMkd2Q3lXbjZo?=
 =?utf-8?B?eDgvcEtRck11MUcwcktKWVlGbzFGR1hnTTBkK2hIL1hibXR2dFQwajJSVnBW?=
 =?utf-8?B?eHRqa2xHMU9RWm9aMGxFcGJIQUpQcnliWURIQXRMYnN6TTg3ajFuU1AwYWRI?=
 =?utf-8?B?UUNtU0xTOUM2RWZmTHNSQjM5ZEMyNmk1dlUyNEZaaU0zcjZNbmhOWmlyYTE0?=
 =?utf-8?B?TWlUY0RGRjV5bklIeWVTSjRWNXJuUjVrTkhuYzBXalpzU1VYVCtEWndFSEx0?=
 =?utf-8?B?QVJjaHBiS0Zva1JHYU5uQUs5ZVJNeEordGNMUDhwNy9MVXRtMllHWFhJUndS?=
 =?utf-8?B?SHJOWFBUWThONGpLY3Btd1JaTWpUWUZ6SldUUENZYkQ4cVp4TnNlOHg4ZTRS?=
 =?utf-8?B?VzE3Q2gyRWdmdkNCWWtlZnhLK292cjY4d1hFU1lacEJaT09HVHVheWF2R0Yy?=
 =?utf-8?B?U2VZRHExYWtvdXpBWUlEakdSbzQvcDlkZlpHeDBoVmlacllXR0lvaHJlYzhh?=
 =?utf-8?B?TWNURllXWitnUVozb0NIY0lKVDB1Qi9ucnF6VHUxRzVubzkxUzdQMW5nRlVw?=
 =?utf-8?B?d1lWOEc3NlJCdHFmR0hGRC83MmpHUWZ3SXJNajFpazZadkhvNGtxTE9CSUR5?=
 =?utf-8?B?bmExWlBxcFM3QmE1eVpPb1JPU0lUTjhEQ1U4VEdHalBnMGRDNnZGeDdPc3F6?=
 =?utf-8?B?cVhXOE5WbXd4VlIzNEI2b3c3S1VrWVIyZHo4WEViVlc1ZC8xbDFIbUdrelIw?=
 =?utf-8?B?cXlTODUwM0tidlJyMVdVcUkyKzZkL0dlY2RlL2xFTGg3UEpzY2xMM09YTnFi?=
 =?utf-8?B?dk83VFpMWGc0OVdlZmFicHB0ZmcrUWJMVXZlSVMrYkJtQTB0MFNqZG1XOGEw?=
 =?utf-8?B?UE9EQytjK0VvOFlZMVdlSEpPTDNTNDdFVnZWM1kyS1RweE5PUzg0VkQ5aHRr?=
 =?utf-8?B?VFlhUUFyeHcwYmFOdVZkTzlOL3FXSUhRbHphbzIycXQwd28yeVNUdlU2M2U2?=
 =?utf-8?B?enB1ckNFcUN1cENrdjdPa2l1MXA2R01yaWk2TktUbW1EWmlYUi9kRFBiOFdB?=
 =?utf-8?B?TWlhcVdzVCtYRFh0NlZid3YyUjlmUFlDV1d3QVE3dlBsVldESGlFOUN3Slox?=
 =?utf-8?B?YWlmNkp0U0h3Y0JTU09FMnU4Vnc1ekFQYldmWnlkN0ZkeXlCMTZFeXZBT0tE?=
 =?utf-8?B?N21meFlkU3h2SjB0T3hROWlJS2hPdFFYUmdJMjBZdmNCUW9BSEczOGRxMUhp?=
 =?utf-8?B?aXBGdVhrcXEzYVpOUDhTMXA0TXNaNU1GeUtyU3NYbTU2SHpLTlhUc3Zxbjhh?=
 =?utf-8?B?Si9FR1hjSk1BaTlkSGVnbzlNQnAyb0dxcTVpOEluUGlUdmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVBqZTVyaFo5aElFNHRWRGRPUXRBcnVpM2xkY3BtSUp3bXJZT3hkRWdUdExk?=
 =?utf-8?B?TUxseFg3bkpheWE3ZHJHNENjTnVaeExGUHBhSXFkbkN0SHhMU2VYeVJSZnZV?=
 =?utf-8?B?TWx6Y3BBR3lXSVpQNVY2S1JuSzB6Z0JBR0JHdlZia0pic0gzNng2cjI2eHZE?=
 =?utf-8?B?VHFqeWxla3BCZDVXbGxvSHhUZGE5c3pNU2xkVXJmNWFrMkN4VkR2TlNtVzN1?=
 =?utf-8?B?bFVUM3NyM1V6OWtRbnROL21TQTNrbHlsRWdXZ3FERWM2K0dVSkN4QWUrMVh4?=
 =?utf-8?B?S3p0L0dxUWo4MDYwMXQ5YXpVRkluWFRjallIWkdTM3pzNlRzZSt6aDFUSGsz?=
 =?utf-8?B?cDJpQnRsQ0R5dmlQRXVPemJsS2E5c0t3RjlQcjZyQUlzaWZuVGUzZmpIMkEr?=
 =?utf-8?B?VDRha3p4NTNjdDltQlRqQjBhNUhSaXh2OThodDEzbEdlVnYxeEFlQkcreUhT?=
 =?utf-8?B?RjhsSGswRTJUZ29MUTBvRExmSWVVWG84SFFhaWQxWnVybUhwQkdFN1p5S3VJ?=
 =?utf-8?B?a3dFMXpUakZVZzVOMVdBdVJzL1hPYi92Um41alZTWFlmOXNKZm5zdTdGdlgz?=
 =?utf-8?B?UWNTUy8xZ3FKMm1MUHJuWm9IbWt0RFpMbDVMSTdaaitFSlc3dm1yTGVxc3BL?=
 =?utf-8?B?Q2RmZzZhdkJ1cUd3WWg3WEdlZ01QdGozQUlYQy9HOEM4SXp1RGVUN2hyeXVw?=
 =?utf-8?B?Y1VaU2ZwL0pvVGpuRkpYc0pxS3FjaGtYZnVBOWNwYml6Rjh1K1E0aytLb2Qw?=
 =?utf-8?B?ektYZHhRd1JGamZmYjBZdTZRYkZHYWFZY1gvaVBoZzNCalFSaDRvcktWYktK?=
 =?utf-8?B?UmZZMENjbjdTTU1LaFUvclIwN1RUV05mVzV4VzVhYmROMXBHdGpuaG5yVC9l?=
 =?utf-8?B?MFlSdFBMRktlMSs4b0d0N2pDTlBncmFrcnBZZFJnSndsZmhFMEZNTXljQjRr?=
 =?utf-8?B?NlRpSk05TTc4cHdHU1BjR2J4aUtnVWRtaDRDS2JDS0VMUVhWNnZmTlY2N29x?=
 =?utf-8?B?NnJ6VStsdDdKdVMvemR5cm9KODB3SHhhMFg4M0FNUmJnS2VtWncwTEJiYWVY?=
 =?utf-8?B?YTU0OUluMEhuVFVMSjA0TlBzVjJoL2JwdlIxalEvN2RZeVJCRDlqQkJma2RC?=
 =?utf-8?B?ZkNheXBiSjhRSGkyZHpoWjZEdG9kZTZBS3F6UlpKUUhKYTloQU8xYW9zMGdB?=
 =?utf-8?B?bEFNdUF2WENQemozS1JTcjVRcnB5ZHUwd3hQbDh6eU01cE11ZG1XcjJVRmZN?=
 =?utf-8?B?bkpQSG9LTzNmRlMwTFdiOXJGbmRyMUpTMVVoMjc4WEpWTUFpSGFNUHQvejE0?=
 =?utf-8?B?SnFmYk9KZkRZV29OczVZTVA2QnUyUU9CUFp1YmhVaUZUMmlsbEVNM1hrWEM0?=
 =?utf-8?B?S1ZQRGFqVUdjTEhyS0FmcnhGN21GZUt6akhKUGlxY05OVXpHZ1BFbjNUWktm?=
 =?utf-8?B?UW1LRUNBNVAwM3ZkbXpYMnludWJTODNqTVRRSjVFUENyWUE3ZGhxc3ZhZHpR?=
 =?utf-8?B?VnBWWDkyOEZUN0h6RVZnOVp2U1dyNGJ6YUlMNWF3bFNnT3JDS1RHUi9BOUd1?=
 =?utf-8?B?elBKa0tVcC9FU1ZpQmRKUmF6RU5JNlFXM3ZWQ3pKWVovZ05JVkdKUDBobkkz?=
 =?utf-8?B?ZnVQV0pKbTdVb2FUUHV6bXAzc29kRGlTanhOQkU3ZkVONEpxa2Q4aE5oclNY?=
 =?utf-8?B?eHRsZTMzK1ROdnU1Y3pCTE9UTnBxU2JYNkk5cVo4d2ZLSEJWMTV0bG9tZmZ4?=
 =?utf-8?B?WHdTMGlYdVc2eWRIR1Qva29pOVFvemV3Z2U4NXAzMEZSOXFmUzVWdjNiZ1Vz?=
 =?utf-8?B?WTBSL1BXcnAyV3dBRHltaFZKdjNBa0lCTWlVZmhOOC90T2ZRYUZPdEpYNGdY?=
 =?utf-8?B?cXE1SEQzRzR0Ym1objVlVjdBVGtnTTNraHJwanFBUUtWL0NFVUVlc2ViSE5W?=
 =?utf-8?B?ZXNXRnV4MVNaVGhBcnB3dXZrWTVGVkRyTlk2T1MyOWE5clB5VUIwZkFqMloy?=
 =?utf-8?B?aVhyYTQvVUZYL29lMmVYMmN5MWJVdHczKzNYVlh1SzgzTjRSeElZNW51bmp2?=
 =?utf-8?B?cEVGMWpLSm9HYWZ0aFEvTTgyOFd1dkhzaEhZMnArUXh5bStuTFNTODdkV251?=
 =?utf-8?Q?2joVzxskMWiAyGF5f+Ha9j1F8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c9d169-8650-457c-b084-08dcb5664b07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:50:13.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+ll9zLxHTABKB1+YfnB6mo3l2PARPV/EeoQANV31I+zWxv4YTecI3CPNPVvdZ5PfaOLU4rm+o90xtdaCxyFjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10464

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (9):
      arm64: dts: layerscape: use short name about thermal zone
      arm64: dts: fsl-ls1028a: remove undocumented 'little-endian' for dspi node
      arm64: dts: fsl-ls208xa: move reboot node under syscon
      arm64: dts: imx: add fallback compatible string fsl,imx8mm
      arm64: dts: imx8mm-venice-gw7901: add #address(size)-cells for gsc@20
      arm64: dts: imx8mp-data-modul-edm-sbc: remove #clock-cells for sai3
      arm64: dts: imx8mp-venice-gw74xx-imx219: use gateworks,imx8mp-gw74xx
      arm64: dts: imx8mm: Add fallback compatible string fsl,imx8mm
      arm64: dts: imx8mm-phygate: fix typo pinctrcl-0

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  5 +---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     | 27 +++++++++++-----------
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  2 +-
 .../imx8mm-phygate-tauri-l-rs232-rs232.dtso        |  5 ++--
 .../imx8mm-phygate-tauri-l-rs232-rs485.dtso        |  5 ++--
 .../imx8mm-phygate-tauri-l-rs232-rts-cts.dtso      |  3 ++-
 .../imx8mm-venice-gw72xx-0x-rs232-rts.dtso         |  2 +-
 .../freescale/imx8mm-venice-gw72xx-0x-rs422.dtso   |  2 +-
 .../freescale/imx8mm-venice-gw72xx-0x-rs485.dtso   |  2 +-
 .../imx8mm-venice-gw73xx-0x-rs232-rts.dtso         |  2 +-
 .../freescale/imx8mm-venice-gw73xx-0x-rs422.dtso   |  2 +-
 .../freescale/imx8mm-venice-gw73xx-0x-rs485.dtso   |  2 +-
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |  2 ++
 .../dts/freescale/imx8mp-data-modul-edm-sbc.dts    |  1 -
 .../dts/freescale/imx8mp-venice-gw74xx-imx219.dtso |  2 +-
 18 files changed, 35 insertions(+), 35 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240805-fsl_dts_warning-8ea01aca79dd

Best regards,
---
Frank Li <Frank.Li@nxp.com>


