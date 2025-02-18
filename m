Return-Path: <linux-kernel+bounces-519995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64221A3A477
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3972118934CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D2726D5DC;
	Tue, 18 Feb 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Al6ua0rX"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013024.outbound.protection.outlook.com [52.101.67.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1A526FDA3;
	Tue, 18 Feb 2025 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900344; cv=fail; b=lvTtwE1Ksr9v3jl1f+50y2yCtp04KVVNTcuRFx6rxGjUrV1fg6JoqPV0/bvgJdq6eGH2Pxu5EVnp4X7M+KsnCxOm8v/r8DSRmtNetlSyO6rYBhA7VWo55kVb1olFgqX1jhJe8N3AnNp/W5rU8FrWvanA1BDSw1yKPPfaSmg04aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900344; c=relaxed/simple;
	bh=V7LDZEgCBJnJn/v0q5/IfFeQdKlo4Kr5NHBseTrsKsA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=A6jgWf9WW4hw1TfmjX0KK8popmk+zZw6bXpGEpvZ+PIdNxgx+6Zf6ASJ9MfHgP+fRLps96sopNiuwBTj2bdonBsKoPwWT4JvvbC+SqLk0LbbapxYzas7k7Zg/mEslStVOevWHVKTSKxEDt4iYr6ZbLhZZnBrmZdc0a2KEj7XjaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Al6ua0rX; arc=fail smtp.client-ip=52.101.67.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2GfK+KTiZwOA4fG0G6NDJVhwWbWPReZmScZigW0kBZVOFNl6Nr7NBKIRNtN/JfPSwFde/viqHR0Ng7765j5M/HKXrLt5bV3VGL6kUOGQO5TN6kafHWt6WGnfUf3fwWSv1hYTC4sDMTI9+nL+SuNoalrjK6BwLNjQMUUMaC5TQn4voDzGlk26iyJqktf4CqrOwFrJUnKCNw1Ru5MrHySIMeg/YGrp+p4WYDmAqN+LoI9VSNVZ3HpPhQxFfOdmfiP2BKRYwyI7aw4DeOp3EV68pNx2AvMxEQPY/WyoSho5NwRKJsGGopZTNgTOz1yjCibwqHNj+QznFspJ52E9T3SYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjeXgHd4zzElrMCDLKEPe3PFcwcGt8BvtxsO+JJv0JQ=;
 b=IQbIxv2gxmItYwj5KY1r1WPseEX09T271IvjHcHDjTrtZ/6Lu4YQdFRscdsXldy5CUU88qs8eMSWl1ZK2Jeq/Ji9ugFbVuRfsOXXrFAHRt09GTXTysqUzSyN1ijlN9kp0oGBFTxNlROPQBJMQCa5JTf1/v91YQY3sJlyXotx4fzI8NAfHqHADDeEB1+8ZBAkyA4HjLauK2V+Z35dLFuda3AsmKHwUO4m1wZP9VpRMjlo6R60zl23J2FrQvi92XRLu+4hPuZIIBpTIJmQvl5+DpqbS047iwRQAtprN8R/JBpmPzdsMGq0tS12oN6OO0+hd95TK//v4BwY91WGFSHi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjeXgHd4zzElrMCDLKEPe3PFcwcGt8BvtxsO+JJv0JQ=;
 b=Al6ua0rXzTMKVr34LAgRLVoGyfg6M3K9HeWdze0ThBNtgGpyxY/Q5DtZOYlEk2L5xMGx2fO6GyqK0Sx1z5fM4RMZPhYh4lA+ZCSpR+sm60RmGnIeJ3pQbyxqWRG/m9yRLIUcEaooH/KEoV3sXLElwXk7wSJ25yqmF4QzW+5k6zGaFAt/jH9YWd+WuYYTSQSGseQPuJw3x5eeJv/Qop1/slULVw1BNQ+KFYbQOjVL8HSvzpGv+s9hSC2CX9575AW6yBcaAH0bdRq5qA8G7umeT0PRjCKfcwry4iu252W1KmHHGykpG8txXtsoQbR0X4v6+y2SShXHsK3CZxNdIL87Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10241.eurprd04.prod.outlook.com (2603:10a6:150:1a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:39:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:39:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 18 Feb 2025 12:38:39 -0500
Subject: [PATCH RESEND v4 1/2] regulator: dt-bindings: pca9450: Add
 nxp,pf9453 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pf9453-v4-1-ddfd34e02da0@nxp.com>
References: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
In-Reply-To: <20250218-pf9453-v4-0-ddfd34e02da0@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739900333; l=2225;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=V7LDZEgCBJnJn/v0q5/IfFeQdKlo4Kr5NHBseTrsKsA=;
 b=ZtdXawiN6R9i4RPpgVpuFgq65SpTLDSWwz88onpqiuipKUjj17KoCQm7B1Ui520UoGxpcJ9KE
 nUEZpT5/RVACBo66HX5Ts0MQuSvjpBZp5QuNtK+YQSzuj3aIzfHEAiz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10241:EE_
X-MS-Office365-Filtering-Correlation-Id: ca64d80d-2d27-4ecd-e1cb-08dd504320bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEtuclExenB4OW5hRUpWbGNkNmFMdEZYNzBEMkx3SE9HdlRvUHJFTDRzNnEr?=
 =?utf-8?B?NlVJZDVacDU1WEN2T0ZjR0FvSGlmZlQ3UGhvenQzNGNYd2xJNExZVE5zZldn?=
 =?utf-8?B?d09FU05UZ1JFdEhZdjNuOHl4U2lScTFxcmYvZkZ2R1BFWTZCeE44d1BGQ3Fl?=
 =?utf-8?B?K0dYK3lFU0VScjc4MEJHbjd4aVpjZ1ROOEYwQzJzQXVGOHpyZm9WdStSdWNL?=
 =?utf-8?B?ejhwYXVITzBKYisvbDlPNEllSXdsSmNld1B3U21seGt1ZGlqRHNUNzdsSk9z?=
 =?utf-8?B?SThUc0N2SThsUXoyN1I5UXpTdm1nTVVseTd5eXBXNDNSQjMyY2xBa0pKdUpH?=
 =?utf-8?B?bEo4NVFuU21mb2kvM3B5QmJqaFpWdkFpRTE1SHVKVHlXYXlabG5XWXZWdzlm?=
 =?utf-8?B?M3ZXc2l0cFExTVpTY0ZmWXFBU1Ewd2RZZ3pJUElKNEo4emxmRmJzRUhzUVJF?=
 =?utf-8?B?MkRJN25kUHh6cjJncVdhUUhVOUU4Skh5Y0JTZnJSUC9XODRBUlNHMk5jSVVk?=
 =?utf-8?B?WnBGUFVHTEQ1YmowSTJRb1Nqem54dU5BVGNxWEpEbGJDQXl2YlgyUlpwdUpr?=
 =?utf-8?B?dmRUdng3bWx3bm9uaWpWaFJPTkREOFNYcExHL2RQTWc5Y2hFRUNkYzhjM2Fp?=
 =?utf-8?B?akJZdzFZbHY4eUdpTGxMeTdMa1ZFR3Zrc21KeDN1dC9aNll0T1ZMaHNXVWZC?=
 =?utf-8?B?ZzZOWWJiQWM2SWRYSldMQlNEMkp0cnNSTnV5WFBhUkxieG1MQUo4YjBDVms5?=
 =?utf-8?B?QkU2OXhSVmN3WWFreGloTUFxSDc4VnNVTzVvYk9OOW5WMVJVeG4zZTYwWGdR?=
 =?utf-8?B?RFNsZk5vVHU4T3VFd3p2cHBlanJVUVQ1aEJYajRDbUVVMTFuRlRHY0tPT2pV?=
 =?utf-8?B?eVhZQXlmRGs2a0RXdmZ3WmkxcVBxZkV3eTRTU3ltbHNmWDZicCtzQ0g3aHNv?=
 =?utf-8?B?Z0ZVZ3ZkTmlRZVBmTnFVTXowZklKNi9IM29TODF1THpuQzU4NEk5b2UrbTBB?=
 =?utf-8?B?Q1BDSW9qUklqdHptRmNLUWtrUDVCeDQ3TzI0TkIrNzNPU2hENitEbUJEWHdt?=
 =?utf-8?B?R2NEdjVCQzdtVUh4c0o3WTh0TmtzcTV4QitqaTFnbHE5a2MwWUJzV1J3UDVW?=
 =?utf-8?B?d1NmRGw0SnhCbTk1NXVFVVI5NkFITCtjMTgyWEJoZ2JMVUg0WXl4Q1VjL1FL?=
 =?utf-8?B?eExMTFNhYXhzRXRuTTF2VnA1VnJ2WXBxYVcxMGdLTEFrQzJMK0dTYzY1a2Jj?=
 =?utf-8?B?NG9tSGlNcVZwaThXUWZYdHVWbFZUMlhsVEhDbXliK04rUmVORllIUnNmQmFV?=
 =?utf-8?B?b1dYTWlDNW1Dd1hoL0xDQzMvM2F0NXZoaU1KUjV2dXpPMFJDS2w4M1pncFN5?=
 =?utf-8?B?aHFXa2pCelRmNVhQdTFrNUtpNjFFbG02VGIxNytmdXVLc3h0Q05COWhXck1q?=
 =?utf-8?B?ME8vZkhXdlpPeE9lbldOWXR2NnBzSU1pTFhqcmk5NXRVMDZGUXJFN1Y1Wm9E?=
 =?utf-8?B?OEhoekdJa3JyRG1iNFlRZ1E4ZnlnYmh0czBINXltdHBqbDlJQXFOOXNFc2xV?=
 =?utf-8?B?aUV5dFVmcnMxSG1KZWMwOVQ5ZHI2OWRqVXRPV0FndGJwRHpWWkxhejlrRUdK?=
 =?utf-8?B?RXhpb056THpKVjBsQmRzYmExZDV5dSsxWGxtaWFHMmsrUDR2NHNjekR1TXAy?=
 =?utf-8?B?QWhZZTZJL0NYNXZxY29lWUdlTkIwN2NYYm51bWdxb25Lb3dJM2JLZDVCRFlo?=
 =?utf-8?B?MWpmTkZSemFiSnpia24ydXNWMkZDaUxMOHlaNkRvVnNPbXNva0tiVG5udVVI?=
 =?utf-8?B?bllyZzhxTzBTRm02eHE0OWZvQ1JBNU9LNTM3MjFXSjA3RjN6TE94L3V3Ky9X?=
 =?utf-8?B?eTRHQi85Mnlhb2JxWVRHdzJaVXEyMXpzcHlYOGordThRTG41THVQMlVBUmEy?=
 =?utf-8?B?ZUpWbjFPTjVqWkgvZTdtWXBXampXb2JQbm1NTHE4aTN4V0RoU3hBSEZEdE14?=
 =?utf-8?B?RzhjYXNrVWx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzFhRlJLQ29aYVN4dTFLY0pUemtmQXl1aXpSWEVXRnVZcnFRRTFjaGxrcVZJ?=
 =?utf-8?B?dHJVVis5R0t3ZW52dElxZVpYSG9vcU05WXN3UUVMK25FMytiQ0NSVWZ3WGs1?=
 =?utf-8?B?ZlBYemt4dncvWDQ2Zkk4dnB5ZzJhWmZiL1VucWVKUUJzaDZXREY1cE43aTVr?=
 =?utf-8?B?NjdaQ0dOUU9xcnBOUzdSTFMxc2Y3WnVSZzcvbDBFa1RkUEQ5S0dtK3NLdFpz?=
 =?utf-8?B?bkRtQWIwMjhUd1kyVnRnTGRVclJrb0NESDZ6bVVabzNrWVBjRXlnTUNBQmY4?=
 =?utf-8?B?OWhUQS9NZ3BjaDIyV1JndUJUZGV2QWZOckdOb1p1KzMxQ0FqZndGc0tmZysw?=
 =?utf-8?B?c1M2cWJJbkNTbHB6ckhsVDVGRTJQakZmV0Vlc3djdy8wVUh4RGtRbjd4Zy9a?=
 =?utf-8?B?WGZYT3p3N2hpRlZkOXpTeEhrNGJWUXhUTDFFWG4vSlJST3U3b3pCOTRhUE9s?=
 =?utf-8?B?WnB0OHJZaEw1Sis4UmpCcnFiN2tzR3I5T01oaUlVdENMa2dmRVMyQ0xrVG9C?=
 =?utf-8?B?TjRicEMxTkhMSXQvYUVZRERESW9Mdmo5MS9SUmFFSWpKVC9KZ0lDUjBEK0Nl?=
 =?utf-8?B?YTVuQ2JIV3k3UE5ERHdVdWx6UG1rMHJNODBsTTRBTjVPd2NmOFVHc1dnK2pV?=
 =?utf-8?B?V1p2b3p2TlRxbG5xZU9aVm9wWEJRendGcDFBdyt1OEhJdnFZWk94ekl4Qldk?=
 =?utf-8?B?bk94dnNIK3kzWDB6RTRBZmk0VEtRK09NUjJvdGdLay9EYnJYMFpSNUFrUzly?=
 =?utf-8?B?bUtLdEsrV0JWTDBOQmNWR2JMbmJaL1NTYTdMbU5vaUVaWlhNY2tZUzJDMWVl?=
 =?utf-8?B?RDQ2cVcvUHdOTUF5RXpsbERxNXowN3FHQldMdG1oc253cWVmWnJNY3ZkSW5C?=
 =?utf-8?B?clJ4WVlYemdmTjJGZHpFdWxEQ0MzWDBuTDJaVXcvdHdIaDFTc0JEQXhXQm9q?=
 =?utf-8?B?eExCMCs0YUY0S1ptMGE0N08xWi9MeUxNOEJCZVVUSzFIL1pqcXN0akFQbGM5?=
 =?utf-8?B?K0VCdUg5emQ0bW9Ya3d0OFFaTC9TcjB0cnB0eFVOVzk3NmthWldvYkswdEti?=
 =?utf-8?B?YVRkenpoNjhaNXFoSDA3VHU1di9NSTZiZHFieThCd3B0WGVuOTBkNGQyNjMw?=
 =?utf-8?B?b0JlNkdnM2gyejR4RmltSTQvZ1dXV1d4M2RTMDUzU2xwVTRTaTAwQkxWZkZN?=
 =?utf-8?B?OVI4WkdFb0hzYUhkZkNkMEY2bXd2VUREbDlxNlJoeWF6YTFQN05udnN5alFT?=
 =?utf-8?B?TlZJcDV1c1BkOW1JcWhwcTVmSkt0MlFFeFdsZjRSMjJ6WktZcHROUmp6OVB1?=
 =?utf-8?B?V2wxNzJJWHRHRlpVb3hkRjlyK1ZVeEhqKzY0UEpOMm9iZW43NkhzQmtEYXRF?=
 =?utf-8?B?NFlpbmxaK083WmlhOS9ZMjhtWEdmSlo3K09qQ2dQWVU0dFp4VnN3TS94MjlG?=
 =?utf-8?B?T0VYV3orVktLV0dtd2hsYTZGcDRDVFFBajB1MlkyT0EvdFVpOWovcGF4Z2dl?=
 =?utf-8?B?bUNHZzBSVVlqZW1pakkwcWRmci95OFdxcHhSTTNFdzVTUVhwTmRuUWtueXZY?=
 =?utf-8?B?UlZnd2s5YU1sWHl2VHU0RTgrYU1ZM3FSdm9QanJsN2RqbjNiWHlFTGxzWVAy?=
 =?utf-8?B?Q1hvd0lNQjBaMnB5aFR4eE1uNlErMkFCQUJaS0tzLzYzQVA5M0RsUDR6OGV3?=
 =?utf-8?B?TmNOa0tvRVl1OHE0MElITVVpUmdVbHNrRVZubkpWVGd4akFKdms3MzRkL3lU?=
 =?utf-8?B?azlBcVh5Q0JEOGJCUjcyT0FjRU1RdmdmaWpvdGhiWmtDby9vUkE0NklMYk80?=
 =?utf-8?B?bUFicndwbW8wRVMxdEh3ZFROMjVMWHE1M3RBa1FtWHJ4dE0vbEIzU0grdXFX?=
 =?utf-8?B?bE8wZWhsaHFMU2lOWHZBNEhjWEJEMHFXUjhtMnJvdGwwaGFYZHBudEZ0QjRD?=
 =?utf-8?B?NDlIeGVNMy9MekdCY0VQQTRaT2djaFlTNjAvQW1wcDEvU2hMNGlUWnFRU3dl?=
 =?utf-8?B?N0tOOGVvUURkaEY1eXRlaUUySjNJSUlCVXd4T2l1cEF5eG9QMHhtNjdZSVNF?=
 =?utf-8?B?RU5UTTBaT2JPYmJLNUx6a3RMek85RVRjcGZleW4vM2NUUHBnZGtFam1jNzI4?=
 =?utf-8?Q?ZalVYs+sZWAK/y82DzQ70J/ht?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca64d80d-2d27-4ecd-e1cb-08dd504320bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:39:00.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsoNjfaG9scTwDByDocKzWlftfvn+kJrxfwWZ8mmyq37zaesrLgrBSe+mj3bNOZmqQcJUU7ROYrydpW1Emb6uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10241

Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
BUCK[1-4].

Restrict LDO and BUCK numbers for nxp,pf9453 and keep the same restriction
for other compatible strings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- LDO_SNVS to LDO-SNVS
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml  | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index f8057bba747a5..a5466bece4cf7 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -17,6 +17,9 @@ description: |
   Datasheet is available at
   https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
 
+  Support PF9453, Datasheet is available at
+  https://www.nxp.com/docs/en/data-sheet/PF9453_SDS.pdf
+
 # The valid names for PCA9450 regulator nodes are:
 # BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
 # LDO1, LDO2, LDO3, LDO4, LDO5
@@ -29,6 +32,7 @@ properties:
       - nxp,pca9450b
       - nxp,pca9450c
       - nxp,pca9451a
+      - nxp,pf9453
 
   reg:
     maxItems: 1
@@ -42,7 +46,7 @@ properties:
       list of regulators provided by this controller
 
     patternProperties:
-      "^LDO[1-5]$":
+      "^LDO([1-5]|-SNVS)$":
         type: object
         $ref: regulator.yaml#
         description:
@@ -100,6 +104,24 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,pf9453
+    then:
+      properties:
+        regulators:
+          patternProperties:
+            "^LDO[3-5]$": false
+            "^BUCK[5-6]$": false
+    else:
+      properties:
+        regulators:
+          properties:
+            LDO-SNVS: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.34.1


