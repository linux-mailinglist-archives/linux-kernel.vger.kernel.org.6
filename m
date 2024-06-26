Return-Path: <linux-kernel+bounces-230157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2708A91792C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9533F1F2250E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D81552F6;
	Wed, 26 Jun 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QZYa3lkj"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253D1FBB;
	Wed, 26 Jun 2024 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384580; cv=fail; b=RB9bjzOoQ0lCfeHzwAaaiDWiNvh7/mmn37GV28GXXUYGHZlDixOjBJiJlftzyiy9rsOFjB8MNypdu6SMFCGsAbgzNx2pRNh1/hNaNEGTjtZioNYzflYvnFxdLozion8v+PBPKy4myK7ptlAE9fgkqXwPm7cz7XPJugFO96d8W60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384580; c=relaxed/simple;
	bh=MOmNrVB7/gxZ/QhdQ9M2tSUEUd+hP5luT6SmrC2YArE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uu2ifUy9l6uWKXp9rAK4QENAByC98//Q59m62aPan4kbbCEcD8ZcGGAJR/jcff16AcMSMvFy1cQpsh8i/6QuyrusThKY1TXD2JA2GiQR2MDcOGerZaShfwjF29Na4mJzK1gFRoCan1JEqbKZbWErXvQIxuu5TkG54ZbNexxaEFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QZYa3lkj; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nH+CDgQNupdziSMxfiajVgKmMWzip6S5Vj7tFLZGqOhMGPb/B0LWSyL5+W/obJjsTBKcljI/E+LBZZf9mHiPZtA8suRh4SJkw4Xd1GTYLfRT1Mk5a2Inx1sKyIlvr0dA8PQ8+3vGKpNjvi3+Tu3zsI5wduWbSU7S3H90bzPIFvNVMChJ26ZwR65IIZ7Cnk3Nj0vIbjXB+p1vBN5ap51AFLd302qjTE3Wxl8xGzA3hTGEXQbgHpM19wjIdwZPrfs1lD/k0hlDECitWiPIz3dNXRmgjYS/e0Zz9Sj3cbdTizouKC980qPyBrSc89ERMG82SsAUbkdsjVMrZldOZMkkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy+VV9SuYLepJbKT4oXVpfluF2Vol8JJBAhhpGlNOgs=;
 b=k201VeEBY00hAYW85GwMz0g/g3AJiw0i62fDG2utidn9xLTaGraZfIde1Jluu6sOm+0AaFph8Ha7l1+LYz51UCnKxm5vTIS0eEXU46k0n9w9WPpL0IjNsiiU1rPfsfaxJUm8pZ2ln/DMr8M0kICBRcnV6kW4qWEf0ko6yapoutf6yXeBlRUvT6+eh5t2eHq+UTWmiCx+5hgE0SvNr6bSZ6MFSxbaUig6hALstm31gTs1I05PotbOxDNCguO9rd6VG8P+RNmJ3oIQyucKNDul1WGJA67eg+sbw8GwN/DU3qxcXxIQsK9eAXk5B5xWqh5ZEA5WGTNfUZ3ZjrVAEicJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy+VV9SuYLepJbKT4oXVpfluF2Vol8JJBAhhpGlNOgs=;
 b=QZYa3lkjewEFdInKwTng60jE1w4LU/9y32cri/M8cj9XQ34osL8rJL0roZOwZAefjq0LgpwDwHWyBtSntBYjRs2GfeId2FGsvUlHGqWddqDw0qnbCX0ZGyyVfufOgNzuJLytSTtnaKSyU+6puCRoKb4fkVo2JRrT/8j4Y/33+/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 06:49:34 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 06:49:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] firmware: arm_scmi: create scmi devices for protocols
 that not have of_node
Date: Wed, 26 Jun 2024 14:58:38 +0800
Message-Id: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB68e2YC/x3MQQqAIBBA0avIrBPUYqCuEi1Mp5pFFiNIIN09a
 fkW/1fIJEwZJlVBqHDmKzXYTkE4fNpJc2wGZ9xg0KHO4WQdhQuJHjEGtKvp0TtoxS208fPf5uV
 9P1LClMFdAAAA
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719385128; l=1557;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=MOmNrVB7/gxZ/QhdQ9M2tSUEUd+hP5luT6SmrC2YArE=;
 b=cSWw2IXghkcdx4CjwRB06UVJ2vdOek5MYvmWyHIAPdFS3Imo9+4Et2kmU1gS1FaLVtb/T9F5X
 SrwcNv/yhfbBFRO4YcMfJE2B95Td8rxIwrn55JoKnhJlkhwUikoxOmL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: ca024465-2914-4b27-11b3-08dc95ac2398
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGJTWU5CSHliZGJrMEJvMmR5OHEydTRhNCtwWUhDVi9rNXl2WHBBdmJkRjIx?=
 =?utf-8?B?U1Mwb0pxTnZTL1BJeExJUnRmdmRiaFp1TGpuWSsrV2s5WDNXd2hNZ1daeGtW?=
 =?utf-8?B?SFhOTVcvalhiTFhsNUVReUJTVXNKeUY5QXFoSFBtNitaRGJlM2QwR3cvT3gr?=
 =?utf-8?B?a0Z5SDNJTUxpR1U4YjNPWFY2cFp2UDhSTVdJOTZUYURNZ0dObGlURTVkSysw?=
 =?utf-8?B?TXpWVXlZWEZZcndkUWNzQW5CSzFGemNRQjlRNE5zYXVmLzhzeHJCVXhRQUUx?=
 =?utf-8?B?OW1kZVNjcFBPR3Jvd0diUjh5N3RkMkUwV2srUGZ4d2VydUUrRWxZaGN3eWlN?=
 =?utf-8?B?ZXVzVjNhRHdCUmVLOFN0U21pYUtCNldpRzVqbEE2SXlla0VRZE4rL1RyWTE3?=
 =?utf-8?B?Z2xJdk1LWjV6NnoyZmhCYU1hS1hScU1VWVliZEdXM09JWWdiakQvbHlHaGo3?=
 =?utf-8?B?WkRqRUkwV2xpaVpZTzJ4bnJDajRHNk9yRE9aYkVRZ3pnL0pBVXFpUmpkQ1hl?=
 =?utf-8?B?Tmh2eXlNZ0pjdE1xZE1GY3Zhd3NNVjdhT3JieUF6VlY3YXhRUzNEUXZVNjRR?=
 =?utf-8?B?dDFhaHMrdWJaSTRyekRqamc5alpQOXQvSDZWcTJodnRDbzdRMVNXcmR6dHVC?=
 =?utf-8?B?VEJBcFpQUHNXZ3pvejg4NEtKbk5YWTdNbVBkNUlJRVpDb3VKWHBCNEJ0Z014?=
 =?utf-8?B?N0ZiVnRrcDJRMVJtNy9HMFJKclNwSUdIdkpiYkhpalJ2eXlRRkUxU3AvYlhM?=
 =?utf-8?B?UXVRUHQ1ZEh6NU9ZcE41dFdVV1JmUzNOTlVkazRZck9HSkZUNWZWVGNUb1Rp?=
 =?utf-8?B?U1ZhdnY0Y3loVHFBZGo1OTh2aWFkM1l1UHB3TnhETjY4V3RNZFVvaDZtNlM2?=
 =?utf-8?B?aWg2ZGJYZWtOazI3bk9qKzY4MXcvYXdFYlpOb3c1SnJXRDI1STVxNWJHcjFp?=
 =?utf-8?B?N3JGK2ZJb3FGVVcrMTZvUkZLYjhEdXd0cUwvSzloK3ZGU04rVmx0NWlOVHhy?=
 =?utf-8?B?RnhmQ3JXVnpxUm5IbitiS0lvVUhSSDVsbzJsTVZzQkJXcFZUNHhvWERMZlQx?=
 =?utf-8?B?d3VWRUcvTGc0aGxUeFlKM2NHekFkdmNRVHVlNHVLWDZWUkFxSk5CRHM0V1ZW?=
 =?utf-8?B?TStDSS9zRGw2anM1Uk5Dd010azRTSzhJWVo0L0swMGF2Qk1ERytZQkdObStz?=
 =?utf-8?B?T2JCblA3QkpRQS9RT3dUNmZ5SjRNNVBlT2tLbHdQWk5nczl5OEIwdzFIellU?=
 =?utf-8?B?b2ErTGpoaXBTaFdGZ3RrS3hJd2lRNld4YlBLYlVZRVA5ZUZFb1Fham5KY3Fw?=
 =?utf-8?B?TXZkYUVEajkwd2Z0TE1HVFFnaWErVVI1TkRxTUsyU250b0tyNURnQ0JOR2ZG?=
 =?utf-8?B?OEoyS2JTLzdrWDFReGlFMXZJcEFpaW9sRE9GVjFDTldIdEFDUVg2azAraDhj?=
 =?utf-8?B?MFUwbkhHbWFzS3BSS3A0OXZaVUFnNmxpTUF4cVZwUVp1SmlJZnNLZmRSQ2Na?=
 =?utf-8?B?OGRlUldtR3lIbXY3ZlQ1dnpqS01LT2c1emRoMEh0OFhqcUh5WUhhSUREd2t3?=
 =?utf-8?B?cVJoSG5ZLzJneHNrQ2syVkRYZXlmcTdFcXVQYWczSDdXTWVTcVVXU2JvdEdL?=
 =?utf-8?B?N3dDR3BkcXFyNS9wQkh1eDNaSlF6cjdKWUdQeVBoSlEwZ2hVV1ZDNGl6M2Zl?=
 =?utf-8?B?UEdKUWhUTEZXSGFXMjJjN1F0MDI4OUNLK1dLc0lZbTE4ZzFqcG5YU3pIdFE1?=
 =?utf-8?B?MFdRRHJpRUxab05OSnZYeVRaMjl5MUlvT25HMzd5dnkwQ1NIcUFyYUdINThs?=
 =?utf-8?Q?v8kD7SgqNVpusVXtleCWo2ctYIHuID0fbvZVs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2E2QzA3UmdwWE5YSnBDRXBYdnZJUHB2eDgxUW5QMXBSWUtEWlJwWkhGaWtK?=
 =?utf-8?B?UmQ1ZEpTdFZjRldhczE1TE1lNllLT3V4Nys0SUV5ZCs4Q3JGRlVtQzhlRXNI?=
 =?utf-8?B?NjBrbUNQSWpLMUkreGRxK284OS8zUzhxZ2tPNmFvVUdIN2c1RU1KT29VeVlM?=
 =?utf-8?B?cUxKNUlWa2N0MnVBUUtpbHl3anE2cnRheDFCYnpndVBaNzZReXVXNzZzR3hZ?=
 =?utf-8?B?SkVmajBxb0JtRjVEa1c1bjRtK2podGNJMkNsOWdjcityZVVOSnJhL25iOTZ3?=
 =?utf-8?B?NUVrMm5UYkhvWG42OHlwVTVkeTFXbks0cHNpOVNMS2hlenJkbS84MlhPRHF5?=
 =?utf-8?B?NU9pNkcrSjg1QjRHZ2Uxckx4QTV5cnNkWU85MklBbFIrMnhwUGx4dHBaSlRx?=
 =?utf-8?B?U2hrUlV0UUN2VlVnRy8vcE9QUERGdGhpc3NobGJmQjNjWEh1TVNwSmxvaFJn?=
 =?utf-8?B?NE1Pc3h5RUwzcVBud04vaTJZMTEzdHhwV3FYbWphUlhCcnBxdEZoS2ZZay95?=
 =?utf-8?B?bnhOQk1MU01DVkcxS0hFemdSeldqWlRmOGFZQTF4cXNaVDUrY0prMWdkNGwy?=
 =?utf-8?B?WmxlbGdIeHJpQ3BTa1BvRjlNd2NJVklBUW5rRk5ZNHVraGZjbGdKTkhFd2JI?=
 =?utf-8?B?VFFoTmpzRWExRTU1UEh5ZWtHallwMXFaRTZRYXp5ZEdna1dHV0ZSWWlnWlBI?=
 =?utf-8?B?eGJ1UWRZYkJQb3hLODlmdHFRQnhCSUNCZW9WcjdoOXBHd2gzdThpRGZhK1lE?=
 =?utf-8?B?ejVGNTViWlNJci9MNC8vN0t2R0JXNWZNK0VESVdEU2tqU2pEVXhSMkpNV3hi?=
 =?utf-8?B?NVFRbUQ2b3RsMHZWOUducTBHaGJjMlhhNzd5YTBpYytDRmd5aE1LRktyS0JB?=
 =?utf-8?B?SkQ0QkJGV1BXdnFsVzZSSWRlVjJMYTA4VU5VcDc2WWtCY0hIQkVoYVpzNGhn?=
 =?utf-8?B?TFY3b00yWDNNb25rWFFiNTZQdWcveGFyRTNOT3F1d3dad2k0NDNIekhJSU81?=
 =?utf-8?B?YllhNnNkM3k0TFFuNkVjdmIrWGVTUlM1ZlRQc3RrM2lxNEpzQTBxWG5GcElV?=
 =?utf-8?B?bTJ1NGJmWElVcWFXRFZEQlVnVVcxMkQ0VFhTeVJidVlFYkRQbEFYYmkvRFhQ?=
 =?utf-8?B?RlVDOWNiZXRMdnpmeXJsRWE2SWo1K1dUTjVOOXMxNm5PS3p3b3ZhTzJiN01I?=
 =?utf-8?B?RGV2cyswWEZpcm5yWWVPRGZaSkZvTzZGL3pCRzI1MDZoNGJkeVkvS0NLRTJr?=
 =?utf-8?B?d1l6T0grYnI0aVZmajBhb1l2VWJDV2Rrc3VGT05vOEdza2YyMUx5ZGxTdC9E?=
 =?utf-8?B?QVMrcVl1V2t2Nm42dUhSVnBmdVJTMVE2TEc3K1hjb2FNNDhmUklCSms4QlFt?=
 =?utf-8?B?QkdGQU80dWIwbDEvakVrV3V5NEdWb2lTUDFPSElVVG5TazdFeml5c1dlNE5Q?=
 =?utf-8?B?ZVpiUW1uSGp4OHFrWVdrZ29vTVpNNW4zQmNQTzcxOFdReE5KekpzQ2NmMmhj?=
 =?utf-8?B?cXZTaFBIbWYwcWxQMkJsV2dIT09OUjFDaUovOU1IMnhIaFFFME8xTW13VTVt?=
 =?utf-8?B?bDF3cU1naDZRT2lhMDNFQ2p5bWJYdkIrRmIrOC82Qksyd294ZlJDZkZzbm9U?=
 =?utf-8?B?NC8zZGhPVFVtK09Ca1NFdnlrNWQwbnppQW8yRHRsS0Zzc1FPTzhlS0Noa3U3?=
 =?utf-8?B?YStIR2JSbU9yM01oWXpCMFNSckx0Y1M4KzE4MzRsa2pJTVRwclpJbytXNzJU?=
 =?utf-8?B?NktVcG8wVnVMY2dxbThic3BPUnRoeVNkdUI3Y0pTOUhwU2dvc1VWWU1KcjFw?=
 =?utf-8?B?SDVqcVI0eTUzK3I5cjRvcVJDWU9BR0hoc3pscFBYcDhPRk96ZlFVR1BlSnNX?=
 =?utf-8?B?a1JkNGhTejBzOVZGaHIzWFNrM3dSMkdiMlIvVUFiUmxaRE1xODhHUmlNa3M1?=
 =?utf-8?B?Y1RBS1ZEVjB6ZlorTDIybGdaMzlJNDBTNHVldFBIRUxuelBzcDUrdklVcXlG?=
 =?utf-8?B?UnRpT3k4Wk8yZ3UxL21xb2VJNDdnVFBHZUlmK3hyZjN6bDlBME54OGFmUkJQ?=
 =?utf-8?B?cDdDS2xTaVpqV3VYdjB6cFZ1aVVaRFNHYU1zT3JtZTFSRzBOZ0FMNHY2UFJO?=
 =?utf-8?Q?SiXpdFSY/5D5PtMb2jSdAtJt5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca024465-2914-4b27-11b3-08dc95ac2398
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 06:49:34.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1DSJDOCoe0DBuih9eC9HRm0skC08rjZMXJjNe5T5vLuu1nu1xZqBbZ4Ty1Qe1z1AT4mtTaem+XLL1n60lWwXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

Per
https://lore.kernel.org/all/20230125141113.kkbowopusikuogx6@bogus/
"
In short we shouldn't have to add a node if there are no consumers. It
was one of the topic of discussion initially when SCMI binding was added
and they exist only for the consumers otherwise we don't need it as
everything is discoverable from the interface.
"
https://lore.kernel.org/all/Y9JLUIioxFPn4BS0@e120937-lin/
If a node has its own channel, the of_node is still needed.

i.MX95 SCMI firmware not have dedicated channel for 0x12, and no need
of_node. This patchset is to support protocol 0x12 without the procotol
node in device tree.

Without of_node, still need to create the scmi devices. As of now,
it is based on an array 'protocols[]' in 'scmi_probe'. 

And no of_node, means no per protocol channel, so reuse the base
protocol channel. Need patch chan_available to support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      firmware: arm_scmi: channel unavailable if no of_node
      firmware: arm_scmi: create scmi_devices that not have of_node

 drivers/firmware/arm_scmi/driver.c  | 33 ++++++++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/mailbox.c |  2 ++
 drivers/firmware/arm_scmi/optee.c   |  3 +++
 drivers/firmware/arm_scmi/smc.c     |  7 ++++++-
 drivers/firmware/arm_scmi/virtio.c  |  3 +++
 5 files changed, 46 insertions(+), 2 deletions(-)
---
base-commit: d8003eb2eb0200352b5d63af77ec0912a52e79ad
change-id: 20240626-scmi-driver-96dc61b036a2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


