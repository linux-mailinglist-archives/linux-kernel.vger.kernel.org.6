Return-Path: <linux-kernel+bounces-294169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C46958A39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590BFB239F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21B19309A;
	Tue, 20 Aug 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZKJU5Hro"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99184192B83;
	Tue, 20 Aug 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165643; cv=fail; b=jr7TMewLGZ6n4z9O4Fk0m0wdWFAOKH3KXVUeBfwYM9fbgkGt0OTan+MpunieD6+/9ePEGrbkO3KkfsfmeQoSwSs4pLXkclV+6ReyPkuvdor7QpTuWq9U3n8QgsOCjJ8JX2lP/mtYILmgXrnaI4TDC4vH6S/o4QmvBst49hmLhdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165643; c=relaxed/simple;
	bh=C0H3s3bXi+Cn67bVuvJ9EWu9VLYqmxSlGdV0pQHNy3o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VjWN9xE6tFknAO5keFrkRf/OIk8l9vOWiUE6e3KlSoViTw4+rR7YghkhfKQwzAUdOg5QLZfgSZ+SJTX3ji2mf8VcxVuRy9zfhLbSlkutsaAcYglqRRkZipP2ILPQPAIgTidm20DXXbfl9rDFNXvSoujX9ijgf4eQ//b5MA71Wpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZKJU5Hro; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWwZoMe9tD9JrQdCZ8JLRneyHKg5E28Z138i5UTxvpGfXIEE8T1bY6gHJU9kdWd4atm5bMgskwH+Nf8NAzhXolkmFIR7vZVUxlRz/1SdP1Slz/R9pNvLG2E4WLYLhtwr+QJNZcuplJFc0wmdYvo2fpzaT9gRfC2gIqIF4AQF5vFrjcCMV/7BARwC31xoY7fCCZtDZLWeZV3odMVx2Sk5IYOBQwFgnAweLNM8RvPThjle2pfd0im8VznlXxBWvJnPjUdnRTrDbiAUkfPUyd4l4nxjyWniw5BqTsWC96Gmv3TA/mZM4jiMyOnelDrYs6Budf90Mjn4kfHQk3LdWnOMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQDI0Kf9itwBlcMPeuph8HuMrvXLkHtTBDgqD91AP9I=;
 b=vrXfwzaj3fgbjsjAOzcZD+NjCe6cweJixFcb26WM9rsgHOsI3qQMthvBfx+rCXheVATofFomBThIdZHxaKRgt5SfppTy62noEGULeNC8fLILMXkLGjDkPebFDiacWNCZukN/kx80yUOoOc8PWVynmlsFjairHl5InWX/NTssCiThAMTmU/wW19Olwn1a5NXSqQZqbEj/nURXyegFyZRPaTw38LLmBv2Ku7naJCVB7wcNniDb9iJSvX6S3Kxj+6JMbHbxjAS9Q4mR2CZStlUVFoPF2+ZwPpWHX8UGk4vCaD9RhZxWnkd4ndrfQqk0vNGtixcOlp1FkabhYLtKB3oy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQDI0Kf9itwBlcMPeuph8HuMrvXLkHtTBDgqD91AP9I=;
 b=ZKJU5HroWsm+EbEb9c8BnQzXdUvHZo5aDiqrbswTqvW27efRB4Jmz5Ow1c8DDM8sCSZMICgFgkW942gI/nFPP6w7zK0E86ztteyGjg03V6KdFCcKy4WRwPqFELOlEzHudzzHO5MqvLKTqetfrFnAijCK8njyfinyuc6i4NF8uzKhuiXQ1d1k544Q7oXpfOcGNwloS6+ZBxb2PbODllcsvTqNer0DS7ZsoGojpPgZLEHjZRvQMogZGnTbEAzHZxBW5NBQd5pu4LXdqzK7PEFJXf9dAj1PWz7g0gJE9oUNTUADpLx+rjtggcpREbLoPn0XZmTio4iYEFJ0FSVOqMmFRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 14:53:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 14:53:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 20 Aug 2024 23:02:41 +0800
Subject: [PATCH 3/3] arm64: dts: freescale: imx93-9x9-qsb: enable
 fsl,ext-reset-output for wdog3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-imx93-wdog-v1-3-5dafda0d4319@nxp.com>
References: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
In-Reply-To: <20240820-imx93-wdog-v1-0-5dafda0d4319@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724166168; l=630;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7teppgw26jVbWEJomT6ArGpvEoq/yg2NC8HD6e7xxYM=;
 b=5CeD4L1zB2RJcxWATHcJZADpP188ouRb3Ri/PyRsq1lsIerLG1Eo4P+mr/pGhX/OmQWE1dMIM
 4BUM5Cpy2kXCW/kVxvKzeiqE+d8+MA/sCI+Ar2YOMf9PLIfaBysw3KC
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: f017ed62-fadc-42e9-11d5-08dcc127ebfc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTY4Y0VqQWhwYkRHdGUrZi9nVmtEa3d3aDJVbEFGaEkzR090Zkx4KzRPNDBa?=
 =?utf-8?B?YTYrL2FSMS9rTUpFRWNNdHJzYzdCMTViN2hyU3BxRHZYY2F1RFUrSVNLTWJ5?=
 =?utf-8?B?a05nRUx6Unh5YXdyQWI4Ty84ek1TaWpML1VQVFdHWWQxNGNkY3oxcUk4RzMv?=
 =?utf-8?B?Q2htOHZ6SncycWRidHd6ckltVTYzWmZBb0RVMVFRb1YxZTg1bkVKQ0VscU1w?=
 =?utf-8?B?ZUZSMlRGVEJTVUwxU0NybGRpL3VUV2lHM0JjVHRvdWNKNUtYcWh1ZE1VUzh4?=
 =?utf-8?B?SXdycWhyRlNxNDByVVNJT0F0NS9OeVlHNVZjd0dUeEZKYmxsVy8xSmZsSlJR?=
 =?utf-8?B?TGFEaFN1c0Z0dzQxek5FSHZDY1diRm10WU1SRnFKZXZERHFiMXRGWG0xV0xh?=
 =?utf-8?B?TXRSRVR3aVdYVWRZQks2MWp5Sit3V08zU3Z6TjFLOU5aOHFUQ1JwbHhUdWtq?=
 =?utf-8?B?TXJNaU5nWGVUazBXWXR5cTBzZEN0VTVCbXVqUXRJZWF3bkVsREhpYTJHMTZG?=
 =?utf-8?B?K0lMWDNFeTEwd2F4a05UbUV1M2hucndiQ3JlNnE1R0pMOUsyWFd6alZUcTVP?=
 =?utf-8?B?Z0JnUjE4WkZWM2VrZzVGTVl1VE5yeW9FbnExREtGVTk2Qm5lODVZNW1ZMU9F?=
 =?utf-8?B?SmdWQjduRnYwS3NJSzdhOHNCSU9YNFE0RHcxTEpOdDhGRy9SSmhwaERPQzdL?=
 =?utf-8?B?ZjFoaDVHZHYrbHBxR3JrWGFEZzJ4U3h0VnJNRG04aTdkV3lYQmNxSStRelow?=
 =?utf-8?B?ZHZMVTBXV3RXMklkNGR0dHk0eHZ1S1N2RHRvWkxNVjljY1JoeUp0MTMzN1dI?=
 =?utf-8?B?bVNoQjBSTFFaM3BnVHljNXI0ejFveFJKdk9BS291aTFrK042M2NqRHlIQlZm?=
 =?utf-8?B?M0I1UjNjbWtqQjZHMEc1SStJMDVndmRrUWVTRk50SDBnbXU3MG5QK2xxTjhl?=
 =?utf-8?B?YzIzYUpaMVlUV1F1QmplUXNnMDM3b0xJOWR4M2tVZ3RDSXNRSjA3YlJjR3F1?=
 =?utf-8?B?VEx4R3VWTFlqNWpBK2FMM3ZwMU5IQldMTHg0UmJ1Q3ZFVmdpRjZkSGtFMk9S?=
 =?utf-8?B?WklGQUdBNFlONUx0VTI4WXdYaEx5akdxSGVlRlJPZlM1Nk4yRWk4YkNlaStz?=
 =?utf-8?B?MkhINTIvazVZYy9kRjRGLzJrMmpvd1ZCWDJ3RHJaNGQvMFlCQVB4THZ2VlFM?=
 =?utf-8?B?MHhTMTNxRVkyeGFUTnZYTHRhV1BLeUVWa1Q3SFd4WjZLSGlHUkZUdXhvL2lP?=
 =?utf-8?B?OU0zMWliTTJUUlR3U1N2azFweVVXL29LWVhnOXZyUlJ0UlV5SVVVc1FTTVVW?=
 =?utf-8?B?dkt3QzlTNFVBQ01tUVlBemlUQmZoU3FDakNibmdKams3TktqZzdxM3dvQ3FP?=
 =?utf-8?B?THg0M2JoTEc2dW45S2o2czBoRmZHOXVydjl2YkxwcXAzdGEvbS9oTjFkT2pv?=
 =?utf-8?B?ZW9NSU5wMndTZ0hxcE5IUjlUalgxaStBTWtGbmIrTHhiYnI5TUc3a2ZBNFZj?=
 =?utf-8?B?Z0M5R3BMQjVYcGk2VVlvdUtTK1VKaktDQ2RScGpFVDJYRm94dEk3RDluR3Fm?=
 =?utf-8?B?dDdxM1dUQWlkOWJ6YmFpdFMvam1ndGdzSVdZNzB5TS8rTGdrZXYzOVpwcUIz?=
 =?utf-8?B?Q0JITHlRajFOeDkxemU0OWQrYU1SYVhGVEtDdElFdllGWGpTazFnSCs2d2NC?=
 =?utf-8?B?ZWszTGpkR3NOenBnUmlnaDZwcXlkcGVuYjBtNnZHenJ6cmE5Zy8yMGFSd3du?=
 =?utf-8?B?K1ZDd3FkaGUyM1ZtQ05kVmh4TDlSWXY3ZkUzNE5yTzVnRGpMMG9wTWxFNXg3?=
 =?utf-8?B?Nmg3T3BpYW9oVHphc0pvQVk4TlNFRGJtOUtvMUoxSnJzVlJjNW1IV1gxb0hi?=
 =?utf-8?B?Tkh1cXk2UXIyMHBYUmtGamVFSVlLTW1kVU10VVBnQnMwNWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWdnOHlreXdPTnZpajk3d2ZaT3NIbC9COFNoNXdyUTlDMGdNNERSL2R3SGVm?=
 =?utf-8?B?bWVKakE3VlRoM1I5N0dKRlF4ZzBmaUo2TFlNUzlNYkxkV2x5dG1ZMWRoWE9F?=
 =?utf-8?B?eVBBWDZIKzNMT0NvMm9qVzR0c1NUK3RXcEpqaW5mTkt2ZTRac2R5UkxDd2Rj?=
 =?utf-8?B?anZQMStPb1NBQVV0NGhySi9XU0ZGeHRBU2IraEdGYUN5RU5TQ3JxcE9zZjhD?=
 =?utf-8?B?WmgvR0dTcXo1QVhnZlAwa0l4SmhhcmEwblRQK1owbWdVeEVxeDZCdkZnTFZK?=
 =?utf-8?B?VkhXRGNGMkR2MG5LK0JtNEkxSzRvZVRacmNHNkk2SExhVjlyRi94dStxdDZS?=
 =?utf-8?B?ZWpKbEhObWUrL0c3YVdLQUJBQU1NaVI2NG5uMkNYd3dXQlJ5eXNXRW9jMmN5?=
 =?utf-8?B?MW9RYXl4RnJ2ZVBuVVBVSHFVTzV6RHhuQ1MwUWtGYzVjSjM3MytwT0FDY0pv?=
 =?utf-8?B?RmtxZUFGdmZmeDYrUmdGTlFnNWR1Zm8wN1VhTm9qVlFKTGJ4Smhqb291NU05?=
 =?utf-8?B?b0ZTUVdVYnpZRkswc0Z0ak03VmIydmIyVm9TMzVkYjRWVzVYVTJ4aVNzb1VD?=
 =?utf-8?B?bWU0dDZralZnTWw1WXpnOGU2M0Z2Skl0ZE1SUlpTVStXTWZ1Y2E5MWt0a1Nl?=
 =?utf-8?B?dUdzbE9vaG5IZGoxT2FsSnZDRDZRdzhkdm8yRThJSXZDU0tXck5TMXVjVWdz?=
 =?utf-8?B?ZDdETGs5eVNRT0V0aHd4c1MxTWxOS2JZa2I3Q3l3cFBvOW1yTmNodStEOGt6?=
 =?utf-8?B?K2tiU1c1SEZ3U3VpaVdpeXhRbzNRU2JEbDNWbE52eFBmdktDSVlVR0RvcENv?=
 =?utf-8?B?MTAwcjd0Y2JUcXhlejBEeEdZK1R2ZEViQkcwK1Bkb2JwNVhUMW9oSFYrclVq?=
 =?utf-8?B?YnY2OStVK1ludkVyRFBTNW5pbCtlcDh0R0NPNjVEakFXYVIyamk0dzZ0a1BP?=
 =?utf-8?B?Vjk2SE41c3dHR1pobHhiRU5wWkNwQzlKUGtRdTAycEYvT2dvNzVjaHdYUW51?=
 =?utf-8?B?QU0wMFJvRGxhbHp6RGRKY3N0WkoxSyt5RmFjUUltSS9VWWRpM29yUEIzUHk2?=
 =?utf-8?B?cWl2SXBma3UxUDk0TUQxTmVlUmpBeDJPT1FJVlBZNFdLdTdlNUtzZGQ5eDlT?=
 =?utf-8?B?RzkxL3N0VmpsbE5qaitTMlJQNjBnajR4UFRvUVNCTThUQVg3MU5OejA0NjBq?=
 =?utf-8?B?WDNsQmg2aXZnQWJCaHd6ME5EM1E5M3BOQlNOVFFoL2M3amtxNDR0VXBoWTZl?=
 =?utf-8?B?NjAwZFRNM2MvRTJlbFB4SHdIWG1vMWVRWGNha2ZLeGt2YUxBZ1Urc1dwWmhO?=
 =?utf-8?B?NVRVTTRtODJKTS90a1EybFRaUnJrZ2tsbHJHMXRZUm1WRG5JYUErRkxSa3Fy?=
 =?utf-8?B?UEgyZzZQOEp6UWVoYkxDdFJjTGkxblVuNWRvMUQ2NmprdHdpdnNnV25jN3V5?=
 =?utf-8?B?MFBrMFJEYWJhbE43Szg5QU9qYk5VRjBta0o0UysrMWt1L3VoREpzOUVNSzQz?=
 =?utf-8?B?Z0V6TXkyRHBoZVZLM1BmRGk0SVlsRU1tZ1d0NHd2YTFLbkpUcjN0YXZ1Syts?=
 =?utf-8?B?alJpVjZMcGtieFYwNUFKODJsaFZabFJ2Z0lQQ0VTVTVhYVBXaE0rWStXeE5q?=
 =?utf-8?B?SG1LK1Y2SFE2UnBhTkxrYkcrZFVKV2NOZUFKcVlkazIvY29pRE95UEZFbHh4?=
 =?utf-8?B?TzdBaGloVFdDeFh3RktKb2RpNGp4c0hLODRaU2tpZjZqRXZXZGpmVEYxODQr?=
 =?utf-8?B?MDVxZ1JpNEFQWWZJaGJDc3loeldqN3JGL1BkcjdSbWV5OElRdEtqWk11emRr?=
 =?utf-8?B?MDBkQmp6NWc5TU8xbXI2dmxSamlGeUZrNWwwQS9tVkZpUkVqbmJJSW5iZmxG?=
 =?utf-8?B?VGNtTnBaNEZNSnllWGMvTXpGSys5UjBXUDBMdXAvZkVjQlRna1N4QTEremZk?=
 =?utf-8?B?NSt3L3NabDRkMEJZOUM0Q1NWQzM1eGN1SEEya2NkQmMvNE1vWXRtSWEybk5q?=
 =?utf-8?B?RWFlbFBNYWhRVXRndCtBWitxM3BxczVHUlJFdG1kN3V4U0xOOURsd01ieG1N?=
 =?utf-8?B?c3ZGZFQvM1c5clN6UWxrTGRhNFdwRSszaVUzZ2pUV2NnWE1WQWVYdDViOEZ0?=
 =?utf-8?Q?xd38Wi6dJBOpis/lMOMRv3Sp6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f017ed62-fadc-42e9-11d5-08dcc127ebfc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:53:58.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1elqly/35kxtiDpFHIsZate5aWh3HzXe65s5S5DeD5UYuD4l63z5v6oWOquvLJMoIDkn5NQ8NEaHOItQ0n3JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415

From: Peng Fan <peng.fan@nxp.com>

The WDOG_B is connected to external PMIC, so set "fsl,ext-reset-output"
to enable triggering PMIC reset.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
index f8a73612fa05..5af4b0a34b82 100644
--- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
@@ -327,6 +327,7 @@ &usdhc2 {
 };
 
 &wdog3 {
+	fsl,ext-reset-output;
 	status = "okay";
 };
 

-- 
2.37.1


