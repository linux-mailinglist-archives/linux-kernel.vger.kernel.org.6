Return-Path: <linux-kernel+bounces-510659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCFFA32018
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2DC18895DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF922046A3;
	Wed, 12 Feb 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r9NOLl2B"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC52045B9;
	Wed, 12 Feb 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346085; cv=fail; b=fPFLIsmd7JWPnTjY7LEpTgKzVUKruq9CSYWgIvRVtvtDTsiaCdWmLwDcVQDZ0iZwNOvxf4WmBVjUPG+p5WZUIrpM5oeXYN/EMO7KfZkTDxvsbxxvIZsT9uCFtqQnlX/EPNnXQbHOAiUSpyx7EZQYqKjgJMelYrnmHhae0ict0b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346085; c=relaxed/simple;
	bh=ELwIL41txEYnXVsqlJVAe6Kei0c/P/+vK+xTIEN0sOc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TNaKwamzzul+HVKinR39l1CWrHkbRjDxOJXRYoRvhDe3a9oAVNelDB1Rf4rbm+pEJ2T1KqYgZcjNE5BiPIDxWXLX6RJUsa/KA9lfXHMbHlMS0+BVOCJ+5FZrKycpIbsD5tNaIMV/5TCZcm4/vUD0APhnKChGnGBz4MHjI0GX5Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=r9NOLl2B; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGiplq6X02Hksa/tK5jE11stbk+KXjAWNVePZe9D/tof9ir2xcgJtqd2OVmZ5xMX9jzvRe2/DQWnfzGR0mn/m32+irachg31+noArSZRCIfK5Q0d3Esz3LHAvSda6IwyUcxQ3oATZbznJc/4bRM+wvunjkuOpH1PshaOdSX+7K8so0Fv6LnIPMhoIfsV7Na4D2uvwZEFWgBnqmGGXiK+sLeX8DcDJRZQYJEQAdwSepQBX+xgBOvZIUY9od2MgkABlpduc0oLfY84Xc/lXo1VBttKKZaBFSsj6UnXIqUnLWrleMGlBxzQpBREixobo+3lCTjo1lO7FNI/gUes0+SENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUyVxBECE8HyWdtaWnYcdoGwVXVxDuOTkNMJqAZSSBs=;
 b=D0PuRlSLx4vXXGuvbtPxJaJn7UBGL0e/k2fIiahUiOtCM5Zw0mhKkY9Q+Yq26LMF3so1p07fF3+7JmYAiR5JvWS2boTcqYDJIkT8CsX2YBOM610tQ5lsZx/nWEcceJXtRIqJyzaxpa9roPh/QT5H1RNkuf16grF0Xxj/wweLnVDcvx6BKtCacWBUu7iTHfFrzOOWM7QUKfTQ80nAKaU6A2Iju0UuZxGUc5i6KuDBhvDkcjkG0akF0Q6ECpqlYehVuLKF/MR4JvaLSExxHdVXSTCDAmcRqwtvvMv5HGs+HrNuqLRMOV13Pb9bPF0JW9NmeyUxAGByOrJpj9kvRsNy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUyVxBECE8HyWdtaWnYcdoGwVXVxDuOTkNMJqAZSSBs=;
 b=r9NOLl2BhKQJqTHAlqLs1+UTJA6LV8dg3UsCKb6AhQgIF0w0V4wPPTORG8y2KC8/Xindo/Y4fvQevIP+ivh/03aszhgnyZpfCES5IwHwjxMxihOnaQwiavWcA1TKAomGYM+bPd27jEBB2oua1zwjGGW1SYPqwdd2eXR9icPptCucNPaWKTObP7OvE/msuyG/fHcBd1BRm7rO2pMkNDJ3XUbyme/O9yF/fcSce3rl16afX77mvOzfyGVFFi/rLOtEzPkLWMDxbwvU/Bc84hzpmPr2SXKvX9+vdGzWY4AbL06C57JMvGP5Rw3s+yBarZ+OfGMACDeBy36leIHfYa+07Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 07:41:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 07:41:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/7] firmware: scmi/imx: Add i.MX95 LMM/CPU Protocol
Date: Wed, 12 Feb 2025 15:40:22 +0800
Message-Id: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZQrGcC/1XMQQrCMBCF4auUWTuSxJaIK+8hXcR0tAMmKYmGS
 MndjQUXLv8H71shUWRKcOpWiJQ5cfAt1K4DOxt/J+SpNSihBiGVQHYFH86hXV7Yy+NkjFGDJgX
 tsUS6cdm0y9h65vQM8b3hWX7XnyP/nCxRoCBz1ST0gXo6+7LsbXAw1lo/JrtZjaQAAAA=
X-Change-ID: 20250120-imx-lmm-cpu-418daaa257e2
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739346036; l=2597;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ELwIL41txEYnXVsqlJVAe6Kei0c/P/+vK+xTIEN0sOc=;
 b=aGDTekAb/IQncOgsZAo8vL215sPJRTTwqk4M6DuUcXG2DjYjdE6YJjov/MCsiaps7HrK61mOG
 FzVcpSYk6rrAGZQJ/TZstLP/ghs9UeIAFVUlkjPnwEIrAzyDbSKyQu2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc5e80b-8f13-4790-3ae7-08dd4b38a34e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVMWnM0b01uYk42SXl2UGVSUTNRdlVoZTlLaVlTUE9zU0hwcnlHQk0zUmlZ?=
 =?utf-8?B?bnZPc2VFbWEvaTBFYXJ2Z1hZRlBYS3czNDZjVkZlS0h4czVKYTZGOFliYzli?=
 =?utf-8?B?QTIvbE5tSE4zbWRQQThTcnltcEN3MmhCd2ZqMkxONzNzUHpuNzdUNUpEKzVH?=
 =?utf-8?B?bjdBTU9QWGFsVzlTcEk4VE1QcWxGSElqZGZTOEo3eUpUSkljYUhKU1V6VUZx?=
 =?utf-8?B?UzZMaW80ZkRHQTlGRmFaMnRVZThoS0lad05jbnBhZ0hIekxYTTVOMW1iZWgy?=
 =?utf-8?B?SWlOZlZnYVcxV3docVdPTXd5YTMraDBKWmVrZ25ieVJpTjk5eG5OTlVseW9B?=
 =?utf-8?B?blV0TWVTeGlTK0ltUjB2eDJCUU5YUUhPRTA0WEtPalVrdlBjT2tGOWdYTkcy?=
 =?utf-8?B?T2NTNk9BM052cWFHcWJaYnlCakVQSUxkNFFQZGhCUnM4eVFjQU96ZDBHMUJQ?=
 =?utf-8?B?WjZnM0dVRkdHMFBtaytDYzM2WUNpckcrNmpVTmhwamtseVo2YUZJbEZjdFBT?=
 =?utf-8?B?cDRobC9OS2EwWURHcXpVaUdEZXBBaWYvaS9sMmVNQkhDRjljOGphWk13UVFG?=
 =?utf-8?B?SU1CMVNVZ1NIbU16a1ZTNkJxUWtkVUhQOWNLV2RvdEhTc2hqb0IvMzRhekFW?=
 =?utf-8?B?emNsdjYwSm5jVENLbEQ2VU5LTk5lWXJsNHpPZ1hhaXpXMlZlV2ltQjVnQkFm?=
 =?utf-8?B?WnRMVkRvdmJYN3FNRnVidXB3TEJ0dWV1clU0REtLSDgxL3hmNkJZcjdNWGVG?=
 =?utf-8?B?NlFic2hhNCtudTFScCtDWkpzZHZVdnAzT0dxam52ZGhFYklWVUwvN2RSSEpI?=
 =?utf-8?B?MjkwSlNHVU44ZStOWFRGUm5oVzBrQVpHOU54Zm14TldNblRaeFZIdjFQYXFK?=
 =?utf-8?B?ajV1U1BQSWlrN1hJYjBqR2piUHJDdG9WQzJJdVViaUp6VHhWbVBqZWs2TEhn?=
 =?utf-8?B?ekFTL3NydnZibUJTWnlGNDl5SXRVWjZsKzhnMHk2UzFXWmpKUXQ1a1U4dzRO?=
 =?utf-8?B?VW5Lb1BERENTUGxwbzdBNVl5U1dzSEJoc3QyTW95UVQ3TStHZHJVNXZ3Q1g5?=
 =?utf-8?B?TDBDVGNQUlFyOThieVBFdk94TFdjQ2YxeGN0c05hbGRVVEhORGc5WjBraW81?=
 =?utf-8?B?REp4SnVLanRxa0dqT1lrM0xKOHVMR0p3dzVBSDdWNU1PZnFTSWEwN3I4NlVs?=
 =?utf-8?B?aysxYkZxY25iTU9iYWFwVEZuUityK1JpTUpyT0xRb0NZWGNjV0sraWw1UHlV?=
 =?utf-8?B?K3NtVEthd1B4Z3FUWGdUYmhtU0xqVzB2YnJQYm5WMFFUTzhpcHo5NnRkdmZO?=
 =?utf-8?B?RVNlUTFEamxNWTZ4bnRpQnlmaGNLRzJiSVZGaTZ6aXByaXU3Zjh2NFc2QjdB?=
 =?utf-8?B?ZVcyNXUrenh2TGJEemFTZGxPaXRkVzl2b3VDVURLUnUzQVI0QmN6Rm1VbVFa?=
 =?utf-8?B?VUgwVXh3dWx4cFA4OWN6clhPWklTWnhmTFdvajk3Z2NkRnp1RlFpcnoyckFi?=
 =?utf-8?B?Tks3KzBVTmF3WUxFRzlwSlBDR1pSTHROU25MNnJMUFRLZjUrNnlqdzYwM3Jx?=
 =?utf-8?B?OUNkdE1zMFpFVm5TdFdONGl1WXk4K0R2Wno5THVNODNRVXkvT0pEcTZTZkxv?=
 =?utf-8?B?bXNRMXFNTEJ6T01vTmJ0Wnl0YlFpdUovWjQzVTJHZnZDVkYvZmhNam85YXZF?=
 =?utf-8?B?dHZtUlBWSHd4NzBJWDkxekhMU1hlTHhERWxpSXc4cTFab094bUU4c05CaFRG?=
 =?utf-8?B?NkJGYVpHcExBT3hGUTRlTVdmdG1Rd0kvVnQ5aEJjSG5KTTFiRGE2c1J2MDFn?=
 =?utf-8?B?SXdqRG9qdU4vVDczRGF4VUFFTVd1aGpIcEZsV0lZR0pnRWtuYU9BanI1UVJt?=
 =?utf-8?B?SFdQZ1lnd09SeFNndXJqTUlMMFB4Z0p3Q0JwTzJiQVF6MzFDV0taWUREdlZ1?=
 =?utf-8?Q?bqJRy+vpaWU0D7eXls8B6HwnXWkMgzgI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzhNTFVQeVRrb3I3S25tdUpyL2ZwUXd6ekFCWnowamtMd1pSc0ZqT011S2tB?=
 =?utf-8?B?d3lLMXhxU2Y0Mlc3NS91Y3hwSGhDemp2TmxLOTlRTW9rcXZTMGZON0dUL3RE?=
 =?utf-8?B?S2laTkhvYnVOYTFMN0tnZ0ZxbCtmRVIxS0F0bzdudXg2cTZlV2VrUWFxN3dw?=
 =?utf-8?B?Z00zTEtIVERGdWFkekN4eFR6NFRJeXpxWlRSUERnZlNxdFN2aXFtTGxvb2RT?=
 =?utf-8?B?K3ZSVTlOaEtxQ3ViNUdtQXRMeDNoRVhyYW1zT1orZVRna3dENnJrUFBDZCtj?=
 =?utf-8?B?dVlBYWhEbnlYYlBicFcycVo4c0JlaXhxOE9NSDN3dmJUQjNsSnJvRXhob3Vp?=
 =?utf-8?B?aHVrNy9KMHY4dFlXWEhpNlBpY2pLTTdmMlRQRHR2MVV3YXpWc3A3bFlscXhR?=
 =?utf-8?B?NEhvWHBiREZQWXVYem1NNDdXb2F5dHVtVTlFNVhWa1I2M09iYldzQURYaFd1?=
 =?utf-8?B?WGltZXlraVRqUTh1dEt6ZUV1ZHRJWFBOUzcvUWxHbERQWnNnczkyK0RpNTB0?=
 =?utf-8?B?SU15dDYyNzZXWStuMkNSYXhsOXBzTG4xdmZ2ZC9EMnFmL1pPdVBvNWVKVzk1?=
 =?utf-8?B?RmVBbVFlMHdTRTVSY3M4Mk4zQWU3ZTNMb1dQMXVJTGJBaGN2RG5lZ3ZOYnhx?=
 =?utf-8?B?R0M4eis3YWpVWWxlZkVKcDVpb3FwRGQvS0R5alQ3bitKMEt4WGtrZUJ3WWRJ?=
 =?utf-8?B?WTZ5SExQbC91Y2tQYW1IdGRTWGVhTDdVVytEZGVIMlBJVEVFNUpqLzhNWEoy?=
 =?utf-8?B?QzRhTHhsaEdBV3B1c2ZTNGRWWk5nT1kwOUZFZjNRYlVCUUhNVkhEWXd2ZzVU?=
 =?utf-8?B?SEVtaU9OL0owQ0t2cFczOEI5anJ4QndXMHdiL3d1enJ4V05lRHFKc0picG04?=
 =?utf-8?B?cUZiTFZQQko1OXVOWHdmVjdHQzljZmhGanZDenNKc01uZVEyQkpUY1JIb2pC?=
 =?utf-8?B?Z2NaU1BITFlFZTFwWkxLdEtiSmJJKzVwd01yU1pTMTBXejZKVWUzRFpCbWxz?=
 =?utf-8?B?Tm16VUZzM3ZyRUwrdjExL2syTEhQbUZLcE9pbk52WVRxdGhsVWUvNWQ1ZzlJ?=
 =?utf-8?B?OGFZOXRLS1FHNmc0VmdWMC9zY2xaVHFKUURabmFrelBJYkQxdmxtN010T0RU?=
 =?utf-8?B?c0lZRU1BOU5qbkdSc2pXUzhnVVVlaUVmQXpZZ0FEcmU0NE9ObjRyREc3Nzda?=
 =?utf-8?B?UzIzc0dFRnM2bjlRVVhUMTZ3MVNUNGl3Z1NrOWNyTC9rYWZ3cmdZWDNtRmxx?=
 =?utf-8?B?dkNIMEVObUlTZyt0elFMQ3FIT3BRMW5sbVNQaFJseWtJRWFwOWlDaVMyc1U1?=
 =?utf-8?B?bjF4cURPU3dtVnpYR2xmTU1zdzRBak1lQ293NE9vaXBvMVRtQkpwWkd2NjBU?=
 =?utf-8?B?a1hZTzV6dS83K0dYTVpqMWNVSThxUkRQNzB2VW5Nd0h6OFQ3YUsyN0RYTWZ3?=
 =?utf-8?B?TWNWOFd1Vy9QWFByaWNjN3lSVXY1d2FEUEhlajd4NnlRdjJaRUxId0FRZFAy?=
 =?utf-8?B?ZkhaSXZEdVNEQXB2M0ZWUlN5NUxsQlVuRUJsQ2d3MEVFWnYvenUyT0hIdjVQ?=
 =?utf-8?B?TVE3UE9FaTNOaGFPYm91Tkl6MWtLRXYxUlorUTJ3RFpIWGcrUXR6cndxN2lz?=
 =?utf-8?B?NTEyWCt4VjZQQzJ0V1pzdWhEN0VUVUZtQ3loVDFIWVNWeUZXbkZNMWhzUUsr?=
 =?utf-8?B?c29YbW1ubHBrcGhTelJBVDZSeTlrWDZwMzJaNjY2N1VLQmREQUJ1ajFzaEkx?=
 =?utf-8?B?cFBrS0ZocEdTT1pXUE5jYWRpeGNKeVlDckVKcWtGNll2MW1EV1ppL05UVEdR?=
 =?utf-8?B?a05HeTBrWWxydzRIc0RZeTZXQlFyalpTVTBxZkxOTkw5bE9oSXpUUUdZY0la?=
 =?utf-8?B?am9SZThCOU84QVcvZFNXSG4wSVdsanFBNHB3MEduV0s2M0ZSRnBTM3lVNGR5?=
 =?utf-8?B?REhrYVlkdTBuY0lwZElTYjZOL3lVSTMxcjV5alNWUFBiZis2RlZuK2k5b3Bw?=
 =?utf-8?B?cVl0KzRYSDZDMGthSEErVFErSUxtQ3hEd3U5SFFWekwvM3d6M2wzMXA4Um0r?=
 =?utf-8?B?UEZBYkU4U08wYnZwTUhDUldaVisweVFyZk44VWJjQlVtRmdOZmNQS0daYVFr?=
 =?utf-8?Q?QfeLLPsROd3YMyw/V/c/WL9BR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc5e80b-8f13-4790-3ae7-08dd4b38a34e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:41:18.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1jaXyzRJ/NlG/b1vFdRgNokWkwS/57vwDut9aNCIzwAqS6q9CFMBjsW6OIuckVceXQnWOpQ8J2pe2z6i5WzXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

i.MX95 System Manager(SM) implements Logical Machine Management(LMM) and
CPU protocol to manage Logical Machine(LM) and CPUs(eg, M7).

To manage M7 in a separate LM or in same LM as Linux itself. LMM APIs
and CPU APIs are needed.

When M7 is in LM 'lm-m7', and this LM is managable by 'linux-lm',
linux could use LMM_BOOT, LMM_SHUTDOWN and etc to manage 'lm-m7'.

If in same LM, use CPU_START, CPU_STOP, CPU_RESET_VECTOR_SET and etc to
manage M7.

Both LMM/CPU APIs will be used by remoteproc driver. The remoteproc
patchset will be posted out after this patchset gets reviewed or in
good shape per Maitainer's view.

Build pass with COMPILE_TEST
Tested with remoteproc on i.MX95

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add dt-bindings patch 2
- Add a maintainer entry with patch 7
- Update doc to address various questions and make it clear
- Use strscpy to use scmi server returned string
- Drop extra blank line
- Shrink scmi_imx_cpu_attributes_get function args.
- Typo fixes
- Add LMM_RESET_VECTOR_SET
- Link to v1: https://lore.kernel.org/r/20250121-imx-lmm-cpu-v1-0-0eab7e073e4e@nxp.com

---
Peng Fan (7):
      firmware: arm_scmi: imx: Add LMM and CPU documentation
      dt-bindings: firmware: Add i.MX95 SCMI LMM and CPU protocol
      firmware: arm_scmi: imx: Add i.MX95 LMM protocol
      firmware: arm_scmi: imx: Add i.MX95 CPU Protocol
      firmware: imx: Add i.MX95 SCMI LMM driver
      firmware: imx: Add i.MX95 SCMI CPU driver
      MAINTAINERS: add entry for i.MX SCMI extensions

 .../bindings/firmware/nxp,imx95-scmi.yaml          |  16 +
 MAINTAINERS                                        |   9 +
 drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  22 +
 drivers/firmware/arm_scmi/vendors/imx/Makefile     |   2 +
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-cpu.c | 287 ++++++++
 drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c | 270 ++++++++
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst    | 737 +++++++++++++++++++++
 drivers/firmware/imx/Kconfig                       |  22 +
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/sm-cpu.c                      |  91 +++
 drivers/firmware/imx/sm-lmm.c                      |  98 +++
 include/linux/firmware/imx/sm.h                    |  62 ++
 include/linux/scmi_imx_protocol.h                  |  41 ++
 13 files changed, 1659 insertions(+)
---
base-commit: c4661e026ccea82ebec71e4b9013c9a4f9f4e232
change-id: 20250120-imx-lmm-cpu-418daaa257e2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


