Return-Path: <linux-kernel+bounces-526678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965F0A401EC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47E13BB4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C46215F43;
	Fri, 21 Feb 2025 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GtJUwinD"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873911E9B29;
	Fri, 21 Feb 2025 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172586; cv=fail; b=da3tSHcM+1XfG6rjNRjeeDXWEFNDqc5bKKZI0kcz41xXkr5ONXuou5ZdZoi4vo5Ggo+ZdjGKgQRwIvTOyoiBhkawKreRslTtbza8UMQvCb9KP5Q5SBMGqxE3ujdpUAhSVY+8d8vHZcOPOfooG6m2qGN2hHYpgpSHoShI4xtJc3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172586; c=relaxed/simple;
	bh=rmTfSzfzpBsx35rM8xHzWf/F6zFcJjA+0UKTnZlLT/4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=sDWpEX7b75+GSEtNPIVPBPFyDWngM4D2HNILunS6NvjrKWGbC6HBT0HCBSKSXA68rnDTlsaSJqqxXOT3UPCJKnylfVpAjt2KZyu0+ankIhemnotSN9E1c5kUf6tYBumabgqilSQp7zQnQJbHbeTQYNI8h8DTFPhhXrSDzg68SkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GtJUwinD; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjbF2KcjZI1LZzlD3w6gZQdaM5mmOqbNy+A3VarXAbrPqO3rJ8vNMIIEj2d8ZR5CJkh1MygwWFvyw6DM+euGKIIQPqwFKNeaNXzt2zkKcpJpUwErKz/e032a3GPOdoKK7cwCIRDHJ8AZzE92WGFOMNfZmODAqE5e0b1xRtM2BENjPsO30yqG76lvj/+0ZgViQyVmTFNj2/GlSby9o4YajcJvPeAIkhWEH1YeLIAidWClhAqBZI9NyuObhSN8r+lq/ZsklY6BGgjH70PdN9VBcoie5bn1wcaHrbxOroOn6be8NxX5ejcgMpgZKdboketalXJ4V95H49ZyvaIqPhrwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCD1kCLVLSSKdgas8vORIJtb2YkR5i+UEBzob+IwRgo=;
 b=jk7ObZz4nX3I22vI9zbVYcv1346mX+I0ijn9Lw6tUsTy6NXD4X7yyOx10gSLmzewnzdQNT+NnTIz/H+d2IxvRfx06Hn2fkG9Alro8p4cdHClj+mdaDNtBfcOQYMdI6vJXqfNUBPceIlu8bOQyblmQTnHGYLtDJ0RmaKNHyRnPkwR7fzFYVYAPJnzroUguFwBcWonPkfZdyvxmMFN5o0cVgUn/G4vfe42TXYPB3JcHJ4JTtjaSWzsYyYjb7nvOpm6CChvdF2DHxGhZRH0y6WZ/Xd7bkzG4LLvBRyQTN6MsVBchzXtezV8YzWTkqnMR5+iiFdZ7oDJ5T/dDgYsyjzn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCD1kCLVLSSKdgas8vORIJtb2YkR5i+UEBzob+IwRgo=;
 b=GtJUwinDAPLygXb0CbYe5pAmL5MXaZb7c49xxg8WtpFr36S9jsLqaS9Za/y1N8lCMZe7QJ0d/4M6p6cd5mrP4JDmWEYckRiaEP4Bh8Wjo+T8eJXdqVGoy8dIGd8Ouz9SLSSCj57AzTEYowQOd/Ivfkcu/O6Qy2fKaCyvQYgQYaOMmcoZhOF31L5zdGMh+T5th71cGNDEXLGfRcYkB6CcDNacFoF+oTmDs5Ugw/Y5eGQnLG3SvXvURB1RHe2gEMnbeA2i6aJIFVeLgwCE4WK1q4c4BhQKq3nzeM9mlCnj6W+Pr5/SNcuVjNKVVAyIppsm+sJaxYUCt+PUNx4Xb6VTXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8925.eurprd04.prod.outlook.com (2603:10a6:102:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 21 Feb
 2025 21:16:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:16:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/4] arm64: dts: add imx95_15x15_evk boards support
Date: Fri, 21 Feb 2025 16:15:56 -0500
Message-Id: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAztuGcC/13OSwrCMBSF4a2UjI3k5tE2jtyHiOSlzcC2JBIip
 Xs3LUitmZ0L308mFF3wLqJTNaHgko9+6MvghwqZTvUPh70tG1FCBQEg2D+zFDcQGQSuVc2tbg2
 BtkFFjMHdfV5rl2vZnY+vIbzXeILl+u2wXScBJrg1lBitlJbOnvs8Hs3wREsl0V/J95IWSbloe
 Mu0kfJPsk1Suv97YqtsynNWguGbnOf5A/RxhtEYAQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740172577; l=1360;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rmTfSzfzpBsx35rM8xHzWf/F6zFcJjA+0UKTnZlLT/4=;
 b=8Hlg9N67T1WxHvsfznuM+l63aTBBI440SZufizqNqO2A06x2v1IlmnYRmsTXXAsJoCOhFZ36x
 9F8Onb7sL8/CharsYcqchRk51f4oz5CvFdd08Lu3OaseumNPqsqfWxz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 2207193e-1647-4f39-4f08-08dd52bcfcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFhGSUxZV2wxaGlJTjg1bjRuT3l0bUNnNnA4OHE0TEw5Rmh1cVQ2T3dCNnRD?=
 =?utf-8?B?RDNyRUYwMmhqbnpaK3d2VjVrYjJiUDhGQzJqZ3B3d1lSWkpjQUtjQjJsTmpv?=
 =?utf-8?B?d1h2d1RncjJUZHlHVFVYbkIzcmhRMGQ1RUdrZTZGMExFV3didmtpS2s2NW9O?=
 =?utf-8?B?ZDFHKzJHdFZycnFDRENWV0g5cnExeXNnaVUvUjdvQnFDMVJTc0UzWDY0ZnEx?=
 =?utf-8?B?OFRCUnkwTTllMDlpK2hoMTJjN3JtaFJRRVU5NjdEdzV4dGNMMFlJdHhFZlVh?=
 =?utf-8?B?bUtjdnMvMWhTMERoS0tFZ3drTjRYZDhIYnVaWDEvY3YrZnhVYWhlY3BsdDlO?=
 =?utf-8?B?M0dkT05WeE5idExLYXFPTWE4TzltaHJqeTFPaEJ6ZUlWU1ZUQWZZZHdWdHpV?=
 =?utf-8?B?MXlaeDBsT29TTVdpaWQzekJtV0hpN1BNQ1IvcWpSaWZMMjkybnBpTk9uQkJV?=
 =?utf-8?B?Z1hrYXIwYldKQUdqcnBHOFBycThxaEV2TG0xdGIxNnZmcXVucXNPU3djQUJV?=
 =?utf-8?B?RVFjZThRMkZja0lCZ2ZSbmc3dFpiMzVMK25Lei9JSXJHUDJQRTh0b3pGd1Ew?=
 =?utf-8?B?TWIra1pSbi9pcUtwOTJrVklMZjhtb1RiMXhrQW13KzVpcGZNR3pleXlObW1q?=
 =?utf-8?B?dUh4SnJrTWxSbmVKRUZGWGt0Y090eURTb1hPeDZvNHI3blJZNEZXSmI1eDVY?=
 =?utf-8?B?Q3NTdmx3Ullqdk4zQ1FaWHdCeW4xZGVvWkd2YVRKRmZZS1dhQ1JFV1Zmd3ZX?=
 =?utf-8?B?S3k1MVk2NkV4NXUzeGk4K0dqOUVuS2U1VDlmZ082Tkk5UnpKNWVBMC9hUnpW?=
 =?utf-8?B?VkdiRzFiWTJKYXFaUXhJakF2a0JmZmNVWWdrNDROSmlGcHl0aTNENzB4M2pq?=
 =?utf-8?B?VElmZFk0ejc4NS95bGEwajg5Rk1UaEx0MGd0ODlHM3o5c2ErMk0yOUxYVXVh?=
 =?utf-8?B?cFhIUDkwVlVjZ2dvcDNHK0lGeDJaVUhnWW1wOEwzSlNoYlNTKzlrRkZuV3RH?=
 =?utf-8?B?N0xjbVlGd1hPQXNLWnFtRTRWYmpkWk1WNTBOSXJWdHJqcDRDUTA4blhlSkpC?=
 =?utf-8?B?cnRBelU5UDY2eXZxZi9naDdoUXpwbXBKajJ0aUFDZXJ0a1JMYndDQlVYMmxw?=
 =?utf-8?B?WlJhUGlLNFRSdlBBUGNlNTNZbjJCRTUwazN4bjVzOCt1VXRiTzNvdDllSjVq?=
 =?utf-8?B?V3p1ZW8vZG9JbGhGSnI4VTZETzdpWUdoZUZiU0Y0Zkt1cGNVcjZwMVhEd0dt?=
 =?utf-8?B?dEd6Z1V3QW5rNFRQWmd0TmdVaFM3b0ZybnVzbTcwVGtxcUN0VDZFc2RMWGMr?=
 =?utf-8?B?c3hjRURucU9VQ2tJeW5hcTFlYmNIS0I2RzROVmw5LzdHSWFkSHhHbi9hdXRn?=
 =?utf-8?B?VmhHb25JUlY5VG9pVGRSVXY0WUs1a09XMnM5dDJWWGFrdWNnTFRKeG0wQ3JB?=
 =?utf-8?B?ZUIvSStDMlJ1dXNqWVRRMkdORWNYVi9vQjlva2d5VmJJa2dMRlhiZTNaRVd3?=
 =?utf-8?B?OVZiQmRtUml3V3hhSVBUaGJCTk9JQ1lvL0d1dGIvUTdydDhla2RuVW04VTR4?=
 =?utf-8?B?KzdFQWZ3K243bjgxbVdvZ1d2QU5lcEhXWFJNZE0zUEs2VG4vb1puSjhJc0d4?=
 =?utf-8?B?TmdPR2NNS2ZuazhKTDBCTlhwZGtsZnVFOXl5QzAwKzdNdlVVVjVTVmVhTzMy?=
 =?utf-8?B?WWlkUXQ0RUhmaHRoeFIzTkxJSWtjVW1ZSTQ5bWZDVzJ1SHBYNks1N3lmcjlM?=
 =?utf-8?B?d1Z5QURVbTk1ME1EcHZXM0g3bmlUeDBvK254N2ZzV1pSM3VDN3V4M1d6ODQv?=
 =?utf-8?B?VHdFVE9sczNiM3c4dy9FNmhPRkFTOFB0ZGFVTHBmMHBrN3JjMnRYdVpCb0p0?=
 =?utf-8?B?WUVXMUlObW5RdWsxVno1K21GaUhpc0FKT0tJeDNiT3BqWEJwYzlGQ25EaCt6?=
 =?utf-8?B?d2tnZFUrQ0NKcEhoYnVnQ2pNOXBTRldSQzF0UnBpYmF1TGhYNnVRTUdMeFQ3?=
 =?utf-8?B?b1FUTnd1Sk93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWxidzBrZ1lZZXlFd0RGenkrcE1hQ016UTUyUnpiQ2ZUN2JzVHNrd3p6V09C?=
 =?utf-8?B?eDVxcWtWNWlHL1p5NForQy9vMG50UnZ1SHRHZ3NWc1RpZVJBSU5rSEo5WXVI?=
 =?utf-8?B?WHRmeWR2OE1mRDhWdkJjMk0yT0dSeWhtMDZnTHV6SE02VGhhdzdUSlFsMmdz?=
 =?utf-8?B?TThucnF0cllrZVV1VFI2QTY5aWZxSmZuOTRON3FrR3ltTW9FOFh5eFFmMkZh?=
 =?utf-8?B?UmRrQThRcnV4Z3UvZ2JMK2JsVDRzcTF6TXlxU1hTTENnOU5obHVpTk1tdTBI?=
 =?utf-8?B?KzBrcC9ucjhrUGFVcnJ6dWxhd2xSSUMyK1dNdnBqdHRsZUExVUs0V05COFlt?=
 =?utf-8?B?NkhZRU1Oc0ZtbjBsL3pVUDV6RHdHdWhyN2k3Nzh3R1l1cm9xeFY5dTdFS0xB?=
 =?utf-8?B?MlphcHN3OVhZdmdlUjl5WkFDZUE2OEFGMmtTNHp0dmJMNGhNa3hRNm9QUWds?=
 =?utf-8?B?TkpSemQ4SUlVdFlYTytyZjg2QlNnT3I3T0lkaGgxbUZrL2JteW1DeUltL2Fa?=
 =?utf-8?B?c3c2bWF4UUl2dVBIT1JFOWI5bzdxeVRRNkswdDUvWWwrUzZyY0s5NXp4SnVq?=
 =?utf-8?B?d3FzSHhaNVhNYXdEemwzM1o3eDA5SDVvL2JmTFYxcnY4UW5ja0Z1Y0RoR3Va?=
 =?utf-8?B?czdGTGJNTXVDWFVzUnlvUDUwY0k3L0JkWVJ5elk3QTZvWUQwTmh1RzRrRlFF?=
 =?utf-8?B?enlKbmF2ZFh6TUpGWURtMXdva2FRS01hMHRRYXhTZ01CNTc2bjJQQjRQelZl?=
 =?utf-8?B?QXg5NlIyRS9OTGFpbGRKTFJtcjlpeXFpTkIyUG5nQ1lpZ3RUWXZNdDdVQ1lr?=
 =?utf-8?B?aEhLK3hGNVVUUXJDcHErZkc5NVYxTEhGeDFGUzB0M0tKbWJGKy94SHFPSTBp?=
 =?utf-8?B?L0NPbDhOc0Y3NllzNnE3cjYxcDZROWFZdHhYUkVSREEyYlRYS0pQV2xMOEtJ?=
 =?utf-8?B?ZjJuL2tPL2krbEtQbkM2TkFTQVlhYm0rZ2cxdkc5c2RZRXZOUlhGdytWZThF?=
 =?utf-8?B?N09leGZsZEg3RWRtbEszcGZEcVd1UUZnY2U4dlIyVFoxZUlUUnAxTllMN3pn?=
 =?utf-8?B?cnN4cnRzcUR6TjRYeXlFNDlJbk95R2hHNHUzaTcxSzhJamZTd0VGQU9jNHNs?=
 =?utf-8?B?NkNxcm9yWGZTN05lRWdCMHdvUVU1bS9PNSswWm4xS3d5N0hmWUErNzQxNUZQ?=
 =?utf-8?B?UVlXeXlqZTB6OUlLV2tQZThvcDIxR2ZZaGhkdDZMSXpBQnp2VzZwNWtPaWhB?=
 =?utf-8?B?YTVzVHlQUVpuZGc5bWVva3lpWmNQbnBuaUJkcTFwOFhrT3JhM3NNRU9manJB?=
 =?utf-8?B?NXR1VS9wKzd5ZkxhRURvNnNhbmhrQmxhZlduWGFCblR1eFZOVmJkU1BNLy82?=
 =?utf-8?B?UU5OR25WZDJWeVZDOUNxL1BZS0JNNkFQNGIzSUxYWldNTWVGcmdPdllvbXFs?=
 =?utf-8?B?a3IrdCs3cWRnb1dxbWZrMTBqcVZ5VTBaeXB1NDBWVVlvWXY0RkIvUGRyV0FD?=
 =?utf-8?B?VTNJZmFsZklqeGlqMFBVWDNUZHl5VGowYWF1bWZqclk0c1FIOEl5NnRUVjlF?=
 =?utf-8?B?RFlOMDlaKzdWME5YVHJnNGZJaDVsOUE1Vk9saU1aSklkdnp6eWNncFVjM2RX?=
 =?utf-8?B?UndjNUJCaDB3Y3JUYnBKOHM2RWJXN2ZsZHAvQ21YY2hXVzlUUE1xQ1lRY2Yz?=
 =?utf-8?B?QWgrLzNJNS9JYTVpRWlFKy9kUnVVY3ZrN1piYjI2MG5xMHI3TE5WVzNIRW1L?=
 =?utf-8?B?RjhzNFBzUDVSOFQwR1VMcXNteERuTDlCVlljVlVLQ2tlZ1F6aXFIdUpzTXBX?=
 =?utf-8?B?SHJJUGh1OGlwdzFIOVVnT2RNYkZXc0hQYkVuL0dERWpsb1VTeGpjTnRLSmIz?=
 =?utf-8?B?RTcxUkQyTVFkV2o4YWV1bXFYcFI4a0lIUFdDeXZqV01QcjY5RWNnMjJ1eEtx?=
 =?utf-8?B?S2hqSzJqcTB3NFlZaDczQUZJYU9tM3djUS8vNFlobkFOR0VpOGc5UXpVMmZx?=
 =?utf-8?B?MUZwbE1USENBczF3M3d4ZzU2TTlTMVUxeUZodU9BRnVvZkVYNVJZZnAzeVp2?=
 =?utf-8?B?aDk4M3FiVlBTZDVGSWY3UndvVVJmQzJ4NXlYZUVYWTZrYzgvaCtIRjk0a2pO?=
 =?utf-8?Q?s+nNG3r5mhl4nLSv9rAbALlLG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2207193e-1647-4f39-4f08-08dd52bcfcc4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:16:20.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPN0BeeuFoxSx+ZTkzsCdVa0ljiXK0IX2zF9Jlx4Z3H279TzX6TMbFAjhgt3Fy4yYGZeY/UTAv4WEqw3kSNhQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8925

Add related binding doc.

Add imx95_15x15_evk boards, which have big difference with imx95_19x19_evk
boards.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- Add usb typce part
- Link to v3: https://lore.kernel.org/r/20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com

Changes in v3:
- Add Rob and Conor's ack tags
- Remove undocument property (need doube check why dtb-check have not
report warning).

- Link to v2: https://lore.kernel.org/r/20250114-imx95_15x15-v2-0-2457483bc99d@nxp.com

Changes in v2:
- fixed typo 'inctrl-names'.
- Link to v1: https://lore.kernel.org/r/20250113-imx95_15x15-v1-0-8c20cbaab9ed@nxp.com

---
Frank Li (4):
      dt-bindings: arm: fsl: add i.MX95 15x15 EVK board
      arm64: dts: imx95: Add #io-channel-cells = <1> for adc node
      arm64: dts: imx95: Add i3c1 and i3c2
      arm64: dts: imx95: Add imx95-15x15-evk support

 Documentation/devicetree/bindings/arm/fsl.yaml    |    1 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1130 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi          |   27 +
 4 files changed, 1159 insertions(+)
---
base-commit: 3d34d52fb62b250297279c3d95b2562180a44569
change-id: 20250110-imx95_15x15-6a64db8c0187

Best regards,
---
Frank Li <Frank.Li@nxp.com>


