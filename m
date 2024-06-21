Return-Path: <linux-kernel+bounces-224641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A5091253E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB852B280F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03C154439;
	Fri, 21 Jun 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="LxWWUdGV"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B31B152E13;
	Fri, 21 Jun 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972864; cv=fail; b=HepleDKcWqGL1Ueds+1NIXljU07qW5/pEk8hppcXDi6BfOnj95LnGMghlyTUn6J3VW+sX2QDXaUZtH2Yr2nsGsG1BcMox3TQxJklgnjQobSb3+ehslVbctdCbQXupGL+5fBtt0kHAAjo13b7XUdrjl4t4uYIVFM2/aIOTVTgSrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972864; c=relaxed/simple;
	bh=OeetlARZl6f4IA3VOpkKER3JYN2OcaKyD59/sux/Qm8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JtzaRTV0HME9sbdOXrmpNv9rsYVtUJPIQyp+YHyOQzkQAUxVx2b7adfTn5gsfKsy//1O2RZlIWvZhZjtlKGl4oETxIVVPHBgwZZP5p6bZOKLdkKTn9lPrLs+Lz6IE7OeDjtC0F7wqLlRKglaNi+rgyt1CotLub8fPm5UUVFPpmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=LxWWUdGV; arc=fail smtp.client-ip=40.107.6.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Mi5rCrZHxQVF50gpKYGdSpUQZyE4feQ1zjYF/cxlyr9H+ovLIZlwfCyGI6QJU60nryy7puMrjQVXZpM24W48OjKYDX4aoVwLlXxmIJcdXm+usLH3rWNy7D/+GtwMdzmiFEkA1aUYepRuPROgt2H7prpm1FtQRxRFVd+z8ta/m4kwZ0a7oA1nz3r/aS3J/lc0GCnMIMVA1Eju7HzF9ewx+z6+tRlXW4KBDO79enhFJHNiABDX/nakLPHhVu6YzpEW2JNTs1mZxmU57VH/9hMT+SRFAPZ+SI9Cpw1ps2iODDWgDZ1qvUaYNwZXAq/v0t48AcEk508tynXzwErAFkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyiQwrVsnMvcTZPe0rBLx8z+uz+MwyNrf8caVNyU61o=;
 b=h76hE0aHzCJac9XUr/LswMbQzfECXkMZydeqyv1aBXhj/H6pxwW0ruHUsX83JRDASs/TlTH+I4Eoa6UdqaBb4biPK5m0+9khm0U2sFeqjuxM4WGAclIk4NyRw20S3MwMSf24btwhHKQhAIrZhEQckHjq2+FWGZMcnEKesNq4tJwXNod3pTkNML70md9/1xw1g5AS/k8Ed63aA8LBpSMKQwuHEVltsJh2Q0QUP5oVB1UgLFCY/o89t0RKAfAnkTmaL1qStX8Y6bVaae/GkWM/v8+0WGSrOVgg9ep4ORHW0ITl4OFYF9vwuAPMQ1aMqXyM6Ni8QW2jZYp3+boks7sq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyiQwrVsnMvcTZPe0rBLx8z+uz+MwyNrf8caVNyU61o=;
 b=LxWWUdGV493RQ71T3kSP63XD4XfrRDmOLi7ChAg7Vz90WiHgsgXIO3I+vnLNPa9G/U8fwRDkzCa57D1r2W7mRONzLcCwbK8f1FDMZ4vuTKg4sNAkpbQ6nkvSKdTqRZguxjTunGHXrIwkSqpLCeubTbgt1/QXsAzxSc/AM554Qns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 12:27:40 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 12:27:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 21 Jun 2024 20:36:40 +0800
Subject: [PATCH 2/2] clk: clk-conf: support assigned-clock-rates-u64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-clk-u64-v1-2-d28a611b2621@nxp.com>
References: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
In-Reply-To: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718973409; l=3767;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nHgr1gsCu9pp4IhyTarapb2dgltw/OjZpRyrv87INcg=;
 b=Ic+Ic0m9UxbaBf0HyzUhFTxJkhkQrLTPwjuZT8aulMsYhoE5KoqkekhzxXQhL0LQRCYYdxvCZ
 g1GZMEf+m9PD1VVyiznq+VsqgNsFCM3fVtFoH8Urpk5EW/s7pvPDlTY
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DB8PR04MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9a35f0-fe23-440d-102b-08dc91ed8af6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTQ2Y1BXV0hWR3N1dUZwRGMxaVNJaXY5WVE1SGpIbkw1SXJqUHhKemRRR1pW?=
 =?utf-8?B?V21ER3drUlE0ZzhYcSsrdHBxcHlJV3NlRldZcVFUb3RQZHFjTWczcHo5S3ZW?=
 =?utf-8?B?TW93UVNoc3pJU1NxQVRHVjFIN2JLWTlhWmRNSlRXQkYwdjRTNWtsRThTMTZp?=
 =?utf-8?B?V09Ebjd6SGp1NmRrRDhITSt2SW45MTF3c2dSQlY4SWZZYnBSKzduVCtWdFdQ?=
 =?utf-8?B?aWkzYSs5Vm9GRjlrQnhjUnhzQWhXRW1Vc29NL0RPMGxxdk9YTDR6bW9JZlds?=
 =?utf-8?B?YjF2TldOdytRN3ZTTms3S0Z5eGtaVXdxYTRkRHh4WC9JTDRkUk1acFF5NkE3?=
 =?utf-8?B?dEpsdWdzVzZFMXJSRHZKK0xjaFM2eGpZTyt1d2ZjeWtmL0tBOTVHUVNNaUt5?=
 =?utf-8?B?dzZRbW5oekxqUndtRUtoTzhiZGlUTXFPV2dyTGJEVVU5TEF2TFoybDBFRHpz?=
 =?utf-8?B?WnEwYkFCVWFybVZGSW1Qd0JwQzMxNDU4SkZra05QVXBGZ1Z6RGJpUWJ1TXll?=
 =?utf-8?B?SHFRdHhYSlBydmxXK043VHVXUyt3Mk1jbEx0Y2EzV0p5YlZjTDVxb09wa0Nl?=
 =?utf-8?B?UkhRWTV5NDU1dmhRWS9XcjNBbnE3eEd0bTEvZTVoM2FIWjd6ZXUvZnRqa25D?=
 =?utf-8?B?bDBzeGlWaml5bllOK3o0QkJoT3ltU2hXbTVnWGt6d1licE1IeTZaS2J3RkxW?=
 =?utf-8?B?Vk9Rb3A0cTg2U0Y3QWxtdzZwR1ZUbzNFYjlUbDBrcGVRRnZpSUJkZDJybGkw?=
 =?utf-8?B?U2tZUmFYVnFKczY1V3Z6UzJxZVNzR1JiYUl0aTliYUNUb1NBWnY5dSsraTVk?=
 =?utf-8?B?bGJCRkVDbkl2RzY0Ri85MTJScHlQZ2NFRzJFWDJiK0xwVmlBbXZONlJqNTBR?=
 =?utf-8?B?U05sUzIrTmptOHZ2RysxVFBTNjhJZGRLVDNXdWNvRnhpY0czQThTOWYwUG84?=
 =?utf-8?B?czl5VVpib2VhMnJpR2tQWS9vSU5NM2lYK2ljMXJGbTJEKzlsOFFibnd4UWJv?=
 =?utf-8?B?OGxuSU9yb1BrRmRKWXNIQ3FTZVREM0sxY1lIY3c3SlpiKzdCRGwvMlc3UUN2?=
 =?utf-8?B?dGNGRm9QdGlkempWaHZteklMcXFZZkxFcjJ3TkJSaHh6RlR5TWUvaFhNSGRp?=
 =?utf-8?B?TnFjKzZtSXR4V3lYeDhVUlIrdTMzUFpuTVA0RUJ3MnBFQUd4Rm1wOVJVY2pS?=
 =?utf-8?B?dU9pUVhsTU1TTmYrTGZ3VUhSbzJEQjdBRW9LQW5FV0wyZGFIYmFBZDB5MTM2?=
 =?utf-8?B?bkw2SkMrN0dqOE5McWN6OGNYZFZvOFpFYWVKN3V1aGVZRksyNjJRUmQzSFhK?=
 =?utf-8?B?NkVJc1NGZ2VOLzEva1EzVVE0UzRoanJSVGxQMUNsSGdyaklXbUtYdDhSc0dX?=
 =?utf-8?B?dCtQYlh6WWcxTDdFdEl0OUlGUWNpSklDazZIaCtHN3dLVDJ6SXRVT1gyU3hD?=
 =?utf-8?B?U2pKOGMwcU9UMGhMT2R6QnUybmg1OEZqakFrUzNJVkRUWXVpUzZPQ09KdEFF?=
 =?utf-8?B?S2NXK1hBTDZwOFVkS1FVdUxucEVyU1dKRDI1ZGEwUE5pbW9nK01Pd0pJdmFI?=
 =?utf-8?B?LzE2UHAwUTd6U3FabGZlN3dsdDNsV2gzWlRNMDVHM1RhN3FlZ0tpang1c3BW?=
 =?utf-8?B?TlltQnRZOTRKZUc0WlNhMXNzb1Axa0poazVBVWg1WkcwelJmNmcyUHIwK0FP?=
 =?utf-8?B?YW8zVGVnbTZxZUpnTC9mclJuRmVieFJrV3VRa2poWDdZVVBRaXQ3YTFVaTZs?=
 =?utf-8?B?UFN4YkM0YzhCK00wSnFjeHVMeVROOEt6MC9aWTlKaWhPUnNWWVFNS3FtM0dI?=
 =?utf-8?Q?OtU9BpkPBJD058zLnM/+RbiOXD/kpKQcrx5Lk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmxIaTJxTUV5NS9lZDNrTFBWdkdKTXowdE5ud0ZQZjlkNUNsUndnWHArTVhz?=
 =?utf-8?B?b3F0SFpkZmtadEhvQVIvMFlNUjh4SkpFY0dRbWc0ZDNNUWR3ZEJnaUVHOHZN?=
 =?utf-8?B?TXNwWE1OcW5qMHVTM01KUzUyVGxHRFpGeTUxM2UrOFFicGRaVytmRlJBdUk5?=
 =?utf-8?B?dEpSMlNaVnJ1Wk9tcitZQVYxenNUSXcyOGFwWFFLbnhqam5nUkwyaHExcnQ1?=
 =?utf-8?B?dEJCOTJ0RFN6cEljV1E0Q3dkQWxGazg2MW5YclJoOCswa3JBdG9QQ0t6NmND?=
 =?utf-8?B?ZkQwUVRNQTFvRWZOdmIzNDVLdEUxaEJlOTJaYkx5V3JobThnTFMyWHM0cEtT?=
 =?utf-8?B?NEFUWHdKZ3JGU3U2ZDQ5TU9NUlp1V2pnR2xMRExCQ3VvK3Y1RmVjNUljalJK?=
 =?utf-8?B?eGtCb3NlOFZGdVNYVERKSXplOFh5WExiU0ZTdUx4Nm9GZGhZVmFPMFNQWk1F?=
 =?utf-8?B?bEQxN210OXlrQ214OTArNlNFZzZnV2VhYTFGWVA5S21kNVB1THlXZ3U5RC81?=
 =?utf-8?B?TFBYQVNNVDdNUTk1UkYvQWxVdldlV0QxT0lHY25remFDN1c4YU1FNUVxT2VX?=
 =?utf-8?B?Y01rTW9PeUcyMTZhVEd1WmRFa3h0bjJWSTBEcmpXUlV0bkNaK3BOcHZoMFI3?=
 =?utf-8?B?TnljeDFES3gvUHBOcG8rKzIrMWVQeFVWOWNOMFN6alZJMzhlNW5BZzAwdjJK?=
 =?utf-8?B?dlp1Mno4YTZIRUQvZmN2NUdXb1E0d1lTM21yVGFmN2w1T3dNbC9JcEp4V0Ix?=
 =?utf-8?B?cWZETkR3YnhKeU1iVHh4bnFta2dlZjBvbmFDdlZDeXRWNmhhUnlROUJZcnJ5?=
 =?utf-8?B?dTlUWTFxM0EzcHFEUlJGZS9hNDE5TkVkYjQvUUY3SnYvcUJOKzFhSVBkS1dy?=
 =?utf-8?B?RlNiaTl0YWVPNm56bnhDUDd3a0ZLNlhRY2EweVE1RWJSZGxreldCbUtFVTdC?=
 =?utf-8?B?WXY3NFVaVnU0SmpCaHB0TDNtdjN3VVRWalgxaDVSb0VOVFNDLzlERkQwZzU3?=
 =?utf-8?B?eGFxQkRuRU1yaGE1MjlKZVJpcWpadzhHT1MzOUV0c25CZU56dVhKcE9rRVg0?=
 =?utf-8?B?d3BqUEwramZZQWZzSFcwL2hCekFkWFZEd1p1dHJaYUMwVlBVUThyS25GZy9o?=
 =?utf-8?B?Z3kwb3hNKzNST0duN0IwSHVlZkdhWmFMMVFJV0oxSllvNHlzbEMzaDFUMjhr?=
 =?utf-8?B?V0FBQTh6L3o5a2ExeEZPV2pRQ3RvMWpITUVrODY1dEJCTXByZWtPVnBRQVhZ?=
 =?utf-8?B?Z1VBcVVNQmtabk8rRTZFeXlDN0tRejFrMG1LdERXQmFIdXJnbExZZ2VlaTN0?=
 =?utf-8?B?QnRyNy9VcFJxUFNWYWJBOXZ3QlFJOExZMGFDMU1PNTIzVkVRcG1UMmJuWFNQ?=
 =?utf-8?B?dDVCM3NvU0pNSjVvUU14bno5WlVzc1ZBTUFpdm1RQXprSklmWkd2blNTV3dw?=
 =?utf-8?B?Z2FSbU1RclA0MnIvbE5tSGZMeHFiNTJ3YVRWQ1p4Q0tKejBLMVlsL090U0I0?=
 =?utf-8?B?ZTc4L3VmMEI4Um43ZFc5YVBkMmVaSjdYeXdBRFpSYnlaZC80WGswaFAreHRL?=
 =?utf-8?B?S3pxeG12TkRDUG9jQjJFYTZ5MUU3RndjWm9CMzMvS0RMWitQdHJuQldhTzU4?=
 =?utf-8?B?b0FIQXlZb1RzaHZUemxFTE1NWWJaajVlQzFIUmptSzdocjY1QW1UaE1NZ2VC?=
 =?utf-8?B?Zm9oYmFRYVI5U1RtL3lsUHFJaEkxM3BGSzRWNWZCRno5bVpKSE1vVFNhdnJQ?=
 =?utf-8?B?eG9uMWRXOVN3ZXMxV2E4eUhlUjZZWjA3SXpZTldTK2owOVNRTnBhbGp4WjdK?=
 =?utf-8?B?VHo2dHNadnBtc0dJU09oTlJvRTFKRER1UGdvQ1dOcGZVMmNwajg2Z0x4UDNn?=
 =?utf-8?B?SnJXc0FlY3FGY3F1Uk5wVWdsZnhTelczRzJHWjhqY1gvSmo3WjA1VUVmdENL?=
 =?utf-8?B?eU0rWnp6eFNBb2VtSXVhNXcrR2Exb0piWktKQlA4R3QrVG11Sm1QMmtKWXFS?=
 =?utf-8?B?UFJQYVNFbzROR3JYT1UzUzdRaXRqWlM1cFJzcjdBekF3dVdCQmdjNXFXVVRN?=
 =?utf-8?B?Q05vdmhtb2liNEFLcDI3S3Nocnh5MmVDd3BmZlVJbHFrazhQOGJMYnQ0YnJZ?=
 =?utf-8?Q?QBJmwM27oK1VUOpV1EHYVDMFI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9a35f0-fe23-440d-102b-08dc91ed8af6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:27:40.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87IemYHLrohjrybm1ud+kiIm8e/JXHKWs/JgOSmnX0Ck+PoFC0wsUV02am1nuHrAsN9FDJzEG3yRJ09xh4MORA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6795

From: Peng Fan <peng.fan@nxp.com>

i.MX95 System Management Control Firmware(SCMI) manages the clock
function, it exposes PLL VCO which could support up to 5GHz rate that
exceeds UINT32_MAX. So add assigned-clock-rates-u64 support
to set rate that exceeds UINT32_MAX.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-conf.c | 106 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 1a4e6340f95c..2bb00c859eb4 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -78,49 +78,91 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 	return rc;
 }
 
-static int __set_clk_rates(struct device_node *node, bool clk_supplier)
+static int __set_clk_rate(struct device_node *node, bool clk_supplier, int index,
+			  unsigned long rate)
 {
 	struct of_phandle_args clkspec;
+	struct clk *clk;
+	int rc;
+
+	rc = of_parse_phandle_with_args(node, "assigned-clocks",
+			"#clock-cells",	index, &clkspec);
+	if (rc < 0)
+		return rc;
+
+	if (clkspec.np == node && !clk_supplier) {
+		of_node_put(clkspec.np);
+		return 1;
+	}
+
+	clk = of_clk_get_from_provider(&clkspec);
+	of_node_put(clkspec.np);
+	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) != -EPROBE_DEFER)
+			pr_warn("clk: couldn't get clock %d for %pOF\n",
+				index, node);
+		return PTR_ERR(clk);
+	}
+
+	rc = clk_set_rate(clk, rate);
+	if (rc < 0)
+		pr_err("clk: couldn't set %s clk rate to %lu (%d), current rate: %lu\n",
+		       __clk_get_name(clk), rate, rc, clk_get_rate(clk));
+	clk_put(clk);
+
+	return 0;
+}
+
+static int __set_clk_rates(struct device_node *node, bool clk_supplier)
+{
 	struct property	*prop;
 	const __be32 *cur;
 	int rc, index = 0;
-	struct clk *clk;
-	u32 rate;
+	u64 rate;
+	u32 rate_32;
+	bool is_rate_32 = false;
 
-	of_property_for_each_u32(node, "assigned-clock-rates", prop, cur, rate) {
-		if (rate) {
-			rc = of_parse_phandle_with_args(node, "assigned-clocks",
-					"#clock-cells",	index, &clkspec);
-			if (rc < 0) {
-				/* skip empty (null) phandles */
-				if (rc == -ENOENT)
-					continue;
-				else
-					return rc;
-			}
-			if (clkspec.np == node && !clk_supplier) {
-				of_node_put(clkspec.np);
-				return 0;
-			}
+	if (!of_find_property(node, "assigned-clock-rates-u64", NULL))
+		is_rate_32 = true;
 
-			clk = of_clk_get_from_provider(&clkspec);
-			of_node_put(clkspec.np);
-			if (IS_ERR(clk)) {
-				if (PTR_ERR(clk) != -EPROBE_DEFER)
-					pr_warn("clk: couldn't get clock %d for %pOF\n",
-						index, node);
-				return PTR_ERR(clk);
+	if (is_rate_32) {
+		of_property_for_each_u32(node, "assigned-clock-rates", prop, cur, rate_32) {
+			if (rate_32) {
+				rc = __set_clk_rate(node, clk_supplier, index, rate_32);
+
+				if (rc == 1 && !clk_supplier)
+					return 0;
+
+				if (rc < 0) {
+					/* skip empty (null) phandles */
+					if (rc == -ENOENT)
+						continue;
+					else
+						return rc;
+				}
 			}
+			index++;
+		}
+	} else {
+		of_property_for_each_u64(node, "assigned-clock-rates-u64", prop, cur, rate) {
+			if (rate) {
+				rc = __set_clk_rate(node, clk_supplier, index, rate);
 
-			rc = clk_set_rate(clk, rate);
-			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n",
-				       __clk_get_name(clk), rate, rc,
-				       clk_get_rate(clk));
-			clk_put(clk);
+				if (rc == 1 && !clk_supplier)
+					return 0;
+
+				if (rc < 0) {
+					/* skip empty (null) phandles */
+					if (rc == -ENOENT)
+						continue;
+					else
+						return rc;
+				}
+			}
+			index++;
 		}
-		index++;
 	}
+
 	return 0;
 }
 

-- 
2.37.1


