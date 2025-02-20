Return-Path: <linux-kernel+bounces-524170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14287A3E005
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A8018929F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F2220DD45;
	Thu, 20 Feb 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ib4wva/I"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3320CCD7;
	Thu, 20 Feb 2025 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067904; cv=fail; b=Q/4slZ/OpvQUcgAKOKmzExgLdwVAFK8w2/mTej9u2tII+TWnIRg13blJoGDhCCKBF66UxrTzGQTZeNeVNQPPseNbwbFuB2LXWoLpNk3PTvZ1WrdzB278sIyRI533HJOgsiO2aOGH5Se9H9wpj6I2PjlELZWkN38+d3w7Pl6x5E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067904; c=relaxed/simple;
	bh=gv9LRA/tkyiG97rIW6rStvqxfOn31iaYPYWkS2z5LZQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Yi0TN350glicLbcug0T6Ps5cJ7MlKD8EdGSH90mSr/udBAfng7QvN3uzhGGc29nnbS/IFEJnwdxlIgGZgarqlSy3lUapR0Qr4VRc8uJQveQFYckMt/v563/DGNUq5J2Sb9+PnVyFQbLBQkxRtlPwG2iKxwSkNICl9zoW205Mheg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ib4wva/I; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlmfCiX3yYwkGmB0PLRs35HlW4Yek8nb3oNZmDFI0p7VlHhFGXbETyu72RT8B7T1T1WqkXF8TzwW5P6oJN8UiuQf/OWH6tt7dBgo87E7xQWF5jXYZoC1XfkVEOnw9+KwW+yCuq/gPwhMYgyvirZj9g6+ol/+4T6AiIbIKZ474kBLu35SsPT1/JPzaM0prksX9ijqGQTwAqraFEsj1HKlLEtNgm6Svb47KvcRtA5ltPLV6oHhooNSkWAF5UkJQh6YyL4LKpnKj2Fs4xL6VBOEYU5KNYQouO7dnH23VY7hiEv+AgrIuwpalbaRLrciwypuLfgCX5fItI5rwHMrqv8YwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG8vI/27zLSEGY3Ns5WepYAXZFhR7QqOgi2wJbNFxsE=;
 b=Ym85KT5OBKiHkgKSa6Paokj4QkmiMAFGPtYsB/aWz8NtKsv6CfntexK+9S6C83JKEOiSCnK98rIlSLv4GPGjQtgKlxUFHLcG2RpJ7RzH3C6sIlbPHd7xZxMuzRmrRYwBuzM6NHIlUehmc6Cx41ECi2IqtgtI6gzjNcBXOM7n0Q6HkLBZfwCrZBi5lSbAGImYKE4ALxRAMKo5yI5VgW/21H0nggQ5CDZtyGN1PODoGzIC57PAWQEXHPHE03qjOH69YOTPntiozbjGJv4Lw89nq9IiLxCFksPZeT5Lhe39oHEwSUXqYVXV98cBg73d9185zN4GCYZt3VSguhYaDEZ6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG8vI/27zLSEGY3Ns5WepYAXZFhR7QqOgi2wJbNFxsE=;
 b=ib4wva/I/uUSzhwX5hG07SL5g8i/Jfl7fBtT0DP+dQ+whkGmWmvTJ37CEeKH+SKleoyKBc92pK4UxJgTNgJjvkN6nvYcnljnv+Izu8HdT7gUJ/WPUatlMYPdeBHCYaa5FJ/tgGvh8WnPEOLoU5EGlz36BOkweiDmAFbBamDBuWxH8oHTNEBPGlLGWCn7p/yTcn1NKN6WRX5ksuNVPcgNbK9hGuuR/cn53TQZh/EWB4FllYL9oCe/eX/c30jWzCcPtkSuMX4WoIxDA5ofTsjFkgYevw3F8/pUg/97ORCOXrzWA34jB/kJCy+OpfzB3d9LV/C6NUe2KiltEH5o2Ci9cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:11:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:11:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 20 Feb 2025 11:11:17 -0500
Subject: [PATCH v3 2/4] arm64: dts: imx95: Add #io-channel-cells = <1> for
 adc node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-imx95_15x15-v3-2-247777ed91c4@nxp.com>
References: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
In-Reply-To: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740067888; l=659;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gv9LRA/tkyiG97rIW6rStvqxfOn31iaYPYWkS2z5LZQ=;
 b=+YkA6GY61+IRn38fmgVNLcTITWjlMZYsD+Pib80hN7sYHOHT9wUAG/9UV/H9Sauh6wVevJsdr
 PouvHZWPrR2D4jrgridxZJf01NR1fMnNm4H8/xfHzAvQC7BoADP+THg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 53aad2c3-4e2e-486c-8a66-08dd51c94177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE42eFlLQ05GZk84cTRzb1l1NllNZ3FCZUlzUXhZaXFyWHFheEhhaUF6OVNB?=
 =?utf-8?B?a3M2Q3puYUNDU0hmMC9SSUNNQjkzb2tGMFp3cTZ5SEhZbnVmVUlnRjRVNEhZ?=
 =?utf-8?B?QXpvczFDVXBsdzE0VEFqRWxnWC8yR0FMZFM1NDRybW9WVkNEUGZ1VmFtaGZQ?=
 =?utf-8?B?Tjc2c2RnV3J4ZlBHa1RCcmNjaFN2VXR3TVVjRXRaTTB5UkJWOVRoaUd3VWYv?=
 =?utf-8?B?K05XV2NyKzJzMVZmL0NjcTV2ejdiVEQ5Kzh6R2tSZWtMQ1M5QVQ4TzdlV2l5?=
 =?utf-8?B?NmNqWHFhZjBkc0tzMUVNMDRWalpWT1ZRM3Fwa2lBMDdXU3d4OEdpVHNLODls?=
 =?utf-8?B?Y3YwYUFQOFJ0TXoyWXlxQXhoNTBXd1oyNTJidXJNd0IvakdrMVJXeUxneldO?=
 =?utf-8?B?dW5wOGdERElpbWVGVGp0Sy82UVFvR292OXJsZGhLZG8vdkdKSFp2NUZrZVZM?=
 =?utf-8?B?OHEwWG1mQVJnZTJMYVhsZXpITXNzN2dxTzdPdmxzU2p5MXZTUTg2UXd3MzJH?=
 =?utf-8?B?em10aHpPTmZoTGhKR2h2SGRkZWovMk9VazlwMkRmY1R5VjZJcVZZTWVTMzVp?=
 =?utf-8?B?ajd2NE9LSHhTWjNaS2EyeEVnc1JJSGFkSncxaHRQQkZpRWZtZ0YzbXhtK285?=
 =?utf-8?B?K1VvN0syUk5Kc3p2bzNiUStsK3hiMzlmMjhsRG1tbUtXaGJKMlVYdlpSZ3Jj?=
 =?utf-8?B?eWpqTUtVek5HTTJnVEY4UGxaR2RIUDY4ZXE0RkVDdG9qeDlqTFZhQXc4Ykl5?=
 =?utf-8?B?aHVpVHNYc2VoU0ZOUks0OGNkS21IL1VEcVdiQ1hiS3lhb01vd2wzekluN3Iy?=
 =?utf-8?B?akhpMVFqbzBkemo5MkpNbkJTWWJWTkxVdEloTzJyVjUyYzdxQTI5Um54QzBR?=
 =?utf-8?B?Z3dncElkUmNqTWlyTllPY1IxOHpBeWg2ODlaN1NjV2sxd2xIWW9xb3RoRXUy?=
 =?utf-8?B?ZWNIaVRvY2h2RkM4U3VPV3d0T2RLeWpEQVV3dGpwYUY0dTFiZ0JveUs5amhj?=
 =?utf-8?B?TGZhODhjVTJZVEp0anJYMEx5eGRwdHRoRFlwR2ZMNG5wWWI3WEM5dERtN0Zq?=
 =?utf-8?B?aVk4ZzNJZmdpbEZwMUhGWXNNQWFna3NkZkZURWhraEJvQ3Y1cVlmY1FlOHhP?=
 =?utf-8?B?UGVCQVg1SGZYUWxvRW5DenArRE9GeXErbmR1TFpJSFE0aGxrYlhxTk12bHVZ?=
 =?utf-8?B?ZHlmeVBLWGtWWUtuM1g4bEdxbDFjR3IyR3NsRkdaSUtJaU1YbGFrSjF1NVRu?=
 =?utf-8?B?TWlsNFlZRGN3Q2gzR2Y5ZW91R1ZxT0RIUXBlWW9VUjdQRFFUTEMzSlpRcjJp?=
 =?utf-8?B?RG1MVlZ0bXUyek9YUzFiSkh3RUcxclM1Qno0TW5MYzd6VTkzMXEvSkF4dFgr?=
 =?utf-8?B?N3d3Nk1wL1o5aVdNek1CS1kzVGdvOGVIc1p5MjJPMS9Rbk4yeC9aMFpDeG9G?=
 =?utf-8?B?dlB4d1RtdDVqYTdaTHlWME93K09hbmF6NmV4bjlzTXlqUS83YVNia2d6VXc4?=
 =?utf-8?B?VXVMaFFGRHhaTTd4c29NeG9BUmlyU1hGL2U4SU15S3RCcitZZzlSNmNjenU2?=
 =?utf-8?B?REZTOVVCMTBDSUVzMi9wVzNNdnY5dXluSUF1dm5OWWQrSXRRWVpGTXFubUNW?=
 =?utf-8?B?VFlJclo0ckQ0bWRDR2FIemZHNmVOM3F4NDZoMXBKeVRMWU8vcG1STUw1clBs?=
 =?utf-8?B?TCt3WjZYekphaitmWm5CMWxuR2gzVWlpTWhUWDNWLzc2ak9kNnhtRXljZTlR?=
 =?utf-8?B?TEt4cW9yaXZrTC9HYWo5ZkRub2w5WFhBK0lacGZlOTR6Y2twL3FJSE5GNWxy?=
 =?utf-8?B?RHZuaCtzZ0pnQjhHYjJGcWJRYVNTWWFVV1dJVjJKV0xvN2h4Q01KRHNjMDdn?=
 =?utf-8?B?ZmZ6ZzhjSGo3SldQeWh0WDF2UElmc3RQUnR4TXlPczc4M1Njb3M4RHE2Z0FE?=
 =?utf-8?Q?N1F6xdXurnOIB8nQGMQRMXQrR1zLTbZ3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzFyWWhRRFpGZm55R0tGU1dEOWlmWGFtdk9SRTRGT3FadmhkcGxBeVRoZUpJ?=
 =?utf-8?B?OU5LODNyNk83azJvY25vMnVqMlplQ2JwT2dHcFNBQVN5RllIbDNNN1hRL3dN?=
 =?utf-8?B?RXBHRXZRb05RS0c2WlJ6Z242SEVvdytvNi95QzdsTDBCSjVnVFhHbVRaZDBk?=
 =?utf-8?B?Sk85M1Nab3ZpMFUxVmZhbGI3bHdjcG1tWGY0SUozczlLZDVpbmVBaDBuTlJQ?=
 =?utf-8?B?M2R3WmxtQ3VvTDhuQnc5dmZLZFNPaE1PQ09OL0s3dm5ReWtaOVhFaWtWS2xk?=
 =?utf-8?B?SWVodWJQWXJFUnV6ZXR6eE9SYVVQWkhRUHFXRklNVVV6QnBtR1drbklYOGsr?=
 =?utf-8?B?RENBeiszSGRxQmxHeWJLTEQ0c21LMlJoTktmWnpmSG9lOFZMS2J6Zjd1dWph?=
 =?utf-8?B?RWl4N3NDZEljbHZWaWdQQTJWK3FZZXgvMWhPVGNsakVoREhwSk5wTW40dnhL?=
 =?utf-8?B?STZvOEtWWjZRSGpsdHNTdXNxa3hxNWgvTzhtUEJiL2lRUmhwb2R5Rk1rUVVQ?=
 =?utf-8?B?SnBCa1hMQTU3UWM2QlMvTjE0dTduZ2gyVE5KWTdiL0I5d1F4Q0grVi9CdDRG?=
 =?utf-8?B?Q0tzV2tCTmo4ZWp4ZFhOdDFGRXpsT2NvbW9rdmRHYVFuNHB1Tk0ydm9Pd2xI?=
 =?utf-8?B?UU5CUkowODR1cmpEMTZDRmdVMDYyMzBuYnd0RzFPYWI3YW4ySXYvN2tuZ09R?=
 =?utf-8?B?dW9tcm90RzYzOVhIMGxxTTJWTTh0RlRHc0p4TzduWFEyZkJSMy83bUo0ck5q?=
 =?utf-8?B?RzJnRHd1OHJELzVWSjYvODZoTnRJb2JEVEcrM2JPQXJFb1A1UXB6VW4ybUxJ?=
 =?utf-8?B?dkJDcm0yWTljRE8yTmgraTBBejhZQkRJWG84N3lYOVF0OWt5L2cyV0hiMU1O?=
 =?utf-8?B?OWFmZ0FTMzZtM2lVSWNVMTFKZElKc3psdlFheXJPRUd5UElYNVl0WkpRVnVm?=
 =?utf-8?B?SVR0aHo4WVdKTk13c0pVS3ovTWlCeTRXRGcreWlRKzRnUDlEVVM2eXhpWnZR?=
 =?utf-8?B?MysxTGx5WC9jdXpZMU5XUnlqdGxVSzVVb2svMDRCZUM1RTIyYlFBMEdvdkdY?=
 =?utf-8?B?dkJqZ3RKMk8vK2hIWnhYNFc4bkdFWTJUNGo2VGc3NXZxSkQ0eDlsaXlaZmty?=
 =?utf-8?B?YkpWRllYV0tSNUoxaE1lMnRlWDBLNkdHeHNzbGg0eWFLbGd2enB0RmtkNklz?=
 =?utf-8?B?NEZFWC9IM0RNYlU4cnlZUjNMM3YzMTFLVmdsbGJIdmFoWXM5UjhMZHNZY1Y3?=
 =?utf-8?B?clFLeFJqZ0ZmbG84M0dsV3F5MTFJZkNTaFdVSUMzOXhoQmVqVy9mblMzQi8v?=
 =?utf-8?B?MXJQT1lOOHE2QnhwMFhGRW5oOGdYRWNkc25tM3hoellVV2xiaXpJazhyalVr?=
 =?utf-8?B?c1pvMWVGeGxDOE1CZ0c3aTR6RDJrYWhaOXY5ekkvTmhweEk0YXJGSkd3cVg4?=
 =?utf-8?B?aGliQk1lc0I4UmVWdEpkV1VyNUlGbzMyT2cyS2trd1NRMTlRWktTanlJaXB1?=
 =?utf-8?B?N0pMZGcxN3dKT0hBVFlUVEZocUFVUlNUdjRKS2VaMWZvOC9JU3JmVGZ0TzZs?=
 =?utf-8?B?SlJNQUtDRkV2SzZqNTBSYmlZNnh3Q0I2REpyTnN3cEpYNlpPZDlza09zRDdn?=
 =?utf-8?B?cDZRVWg0c3ZENVRlVmljczQ3NU5zNldlaytlNXRDeEQzUzdUV0krbWFHQ0hM?=
 =?utf-8?B?YXY0T2dNWWtFT2toQ0s3T2JKK0VkM1hocVRTcXMxZEZ6M2ZoTUw0WmtBR1Vv?=
 =?utf-8?B?Q0ZkTG00WndycmNFaVRKaXYyOWxjNStDaXVPWDZYQ1M5cy8xOEJvdmRsM3dv?=
 =?utf-8?B?U2tpOUVRNXVQOUorTjF1MmIrcUMrTk1HaVAyZGEzZlNLeGNGazRreGdZT1Yz?=
 =?utf-8?B?dDV5T1ROM0dBSTNVc0Foc0VuUHE3Q29QZXhPczNQL0pxN0pYWnpGbzhrL3pO?=
 =?utf-8?B?N2p0YmsrRUJpaXBndHRRa0ZlM2RCTEUzRXZoYXJSZ1JFVEovUjF3NkZCbmZT?=
 =?utf-8?B?cW1LcWNsSko0NFc4eS9WV21hRitKV3lTQ0swZk9haWZFNGtTOTRFUzlsdHBl?=
 =?utf-8?B?eXZCVVhGUVV6WXpadnYxbDBUaEgvTnhYWWF4eU5JWlZrZTErSGJDd0xyYzRX?=
 =?utf-8?Q?1yh65gioCowK72S33eZOnzxnn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aad2c3-4e2e-486c-8a66-08dd51c94177
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:11:38.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuvSISQ/H5Z0MnSTG1TdPDkEE8eNenmCrmI3xMINBoDUeyekUN5uUrWOkMatCzrrgpDlUceUjbwaFx93g24wiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367

Add #io-channel-cells = <1> for adc node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 0b64a1df3c7a6..ce4c0aa70a07f 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1379,6 +1379,7 @@ adc1: adc@44530000 {
 					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_ADC>;
 				clock-names = "ipg";
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 

-- 
2.34.1


